<?php

$req = $app->request()->post();

// VALIDACIJA na serverskoj strani se vrši GUMP klasom (https://github.com/Wixel/GUMP),
// dok je na klijentskoj strani za to zadužen jQuery Validation plugin (http://bassistance.de/jquery-plugins/jquery-plugin-validation/)
require ROOT . 'lib/gump.class.php';

$gump = new GUMP();

$postData = $gump->sanitize($req); // You don't have to sanitize, but it's safest to do so.

$gump->validation_rules(array(
    'catTitle'    => 'required|max_len,200|min_len,3',
    'catDesc'    => 'max_len,200',
));

$gump->filter_rules(array(
    'catTitle'    => 'trim|sanitize_string',
    'catDesc'       => 'trim|sanitize_string',
));

$validated_data = $gump->run($postData);

if ($validated_data !== FALSE) {
    //var_dump($validated_data);
    
    // validacija prema bazi
	
	//include_once('logic/idiormUse.php');

	/*$catIds = ORM::for_table('s2_categories')
			->table_alias('c')
			->select('c.category_id')
			->find_many();*/
	

}
//var_dump($validated_data);
if($validated_data === false) {
    echo $gump->get_readable_errors(true);
} else {
  //var_dump($validated_data); // validation successful
    $cleanData = $validated_data;
}

