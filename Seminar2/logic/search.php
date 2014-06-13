<?php

$req = $app->request()->post();

// VALIDACIJA na serverskoj strani se vrši GUMP klasom (https://github.com/Wixel/GUMP),

require ROOT . 'lib/gump.class.php';

$gump = new GUMP();

$postData = $gump->sanitize($req); // You don't have to sanitize, but it's safest to do so.

$gump->validation_rules(array(
    'bytitle'    => 'max_len,200',
    'bycat'    => 'max_len,11'
));

$gump->filter_rules(array(
    'bytitle'    => 'trim|sanitize_string',
    'bycat'    => 'trim'
));

$validated_data = $gump->run($postData);

if ($validated_data !== FALSE) {
	
    if(!empty($validated_data['bycat'])){
        include_once('logic/idiormUse.php');
        $catIds = ORM::for_table('s2_categories')
                ->table_alias('c')
                ->select('c.*')
                ->where('c.category_id',$validated_data['bycat'])
                ->find_one();
                
        if(!$catIds)
            $validated_data = NULL;
    }

}
//var_dump($validated_data);
if($validated_data === false) {
    echo $gump->get_readable_errors(true);
} else {
  //var_dump($validated_data); // validation successful
    $cleanData = $validated_data;
}

