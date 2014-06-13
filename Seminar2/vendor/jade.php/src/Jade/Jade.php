<?php

namespace Jade;

use Jade\Parser;
use Jade\Lexer;
use Jade\Compiler;

class Jade {
    protected $prettyprint = false;
    public $cacheDir='';
    public $cacheTime=3600;

    public function __construct($prettyprint = false) {
        $this->prettyprint  = $prettyprint;
    }

    public function render($input, $scope=null) {
        require_once('Parser.php');
        require_once('Compiler.php');

        if ($scope !== null && is_array($scope)) {
            extract($scope);
        }

        $parser = new Parser($input);
        $compiler = new Compiler($this->prettyprint);

        return $compiler->compile($parser->parse($input));
    }

    public function cache($input) {
        if ( !is_dir($this->cacheDir) ) {
            throw new \Exception('You must provide correct cache path to Jade for caching.');
        }
        if ( !is_file($input) ) {
            throw new \InvalidArgumentException('Only file templates can be cached.');
        }

        $cacheKey = basename($input, '.jade');
        $path = $this->cacheDir . '/' . $cacheKey . '.php';
        $cacheTime = $this->cacheTime;

        if (file_exists($path)) {
            $cacheTime = filemtime($path);
        }

        if ( $cacheTime && filemtime($input) < $cacheTime ) {
            return $path;
        }

        if ( !is_writable($this->cacheDir) ) {
            throw new \Exception(sprintf('Cache directory must be writable. "%s" is not.', $this->cacheDir));
        }

        $rendered = $this->render($input);
        file_put_contents($path, $rendered);

        return $path;
    }
}
