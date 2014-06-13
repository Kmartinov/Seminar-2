<?php

/**
 * JadeView
 *
 * The JadeView is a custom View class that renders templates using the Jade
 * template language (http://jade-lang.com).
 *
 * originally JadeView made use of jade.php from Konstantin Kudryashov aka everzet
 * (https://github.com/everzet/jade.php)
 *
 * as original jade.php used Symfony class autoloader and it (jade.php, not
 * Symphony :D ) wasn't updated for long time, a fork of jade.php was chosen,
 * made by hackaugusto, sisoftrg and lately lukegb
 * (https://github.com/lukegb/jade.php)
 *
 *
 * Two fields that you, the developer, will need to change are:
 * - jadeDirectory
 * - jadeTemplatesDirectory
 *
 * @package Slim
 * @author  Joe Fleming <http://joefleming.net> - original code
 * @author  Stipe Predanic <stipe.predanic@gmail.com>  - changes for newer jade.php
 */

use \Jade;

class JadeView extends \Slim\View
{
    /**
     * @var string The path to the Twig code directory WITHOUT the trailing slash
     */
    public static $jadeDirectory = null;

    /**
     * @var string The path to the templates folder WITHOUT the trailing slash
     */
    public static $jadeTemplateDirectory = 'views/';

    /**
     * @var persistent instance of the Jade object
     */
    private static $jadeInstance = null;

    /**
     * @var boolean if true jade renderer gives a nice readable HTML output,
     * false gives obfustcated minimized version
     */
    public static $jadeNiceOutput = true;

    /**
    * Render Jade Template
    *
    * This method will output the rendered template content
    *
    * @param    string $template The path to the Jade template, relative to the  templates directory.
    * @return   void
    */
    public function render( $template )
    {
        $instance = self::getInstance();
        if (substr($template, 0, 1) != '/') {
            $template = self::$jadeTemplateDirectory . $template; }
        if (!stristr($template, '.jade')) {
            $template = $template . '.jade'; }

        //assign local variables
        foreach ($this->data as $key=>$value) {
            $$key = $value;
        }
        //return $instance->render($template);
        /*return eval(' ?>'.$instance->render($template));*/
        ob_start();
        include $instance->cache($template);
        ob_flush();
}

    /**
     * Creates new Jade object instance if it doesn't already exist, and returns it.
     *
     * @throws RuntimeException If Jade lib directory does not exist
     * @return Jade             Instance
     */
    public function getInstance()
    {
        if ( ! (self::$jadeInstance instanceof Jade) ) {
            if (! is_dir(self::$jadeDirectory) ) {
                throw new RuntimeException('Jade.php directory does not exist : '.self::$jadeDirectory);
            }

            self::$jadeInstance = new \Jade\Jade(self::$jadeNiceOutput);
            self::$jadeInstance->cacheDir=self::$jadeTemplateDirectory.'cache/';
        }

        return self::$jadeInstance;
    }
}
