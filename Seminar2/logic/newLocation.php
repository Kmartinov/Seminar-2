<?php

$req = $app->request()->post();

// VALIDACIJA na serverskoj strani se vrši GUMP klasom (https://github.com/Wixel/GUMP),

require ROOT . 'lib/gump.class.php';

$gump = new GUMP();

$postData = $gump->sanitize($req); // You don't have to sanitize, but it's safest to do so.

$gump->validation_rules(array(
    'pageTitle'    => 'required|max_len,200|min_len,3',
    'pageDesc'    => 'max_len,200',
    'catId'    => 'integer|max_len,11|min_len,1',
));

$gump->filter_rules(array(
    'pageTitle'    => 'trim|sanitize_string',
    'pageDesc'       => 'trim|sanitize_string',
    'catId'       => 'trim|sanitize_numbers',
));

$validated_data = $gump->run($postData);

if ($validated_data !== FALSE) {
    
    // validacija prema bazi
	// - trust no one! - provjeri da li postoji kategorija u bazi
	
	include_once('logic/idiormUse.php');

	$catIds = ORM::for_table('s2_categories')
			->table_alias('c')
			->select('c.*')
			->where('c.category_id',$validated_data['catId'])
			->find_one();
			
	if(!$catIds)
		$validated_data = NULL;
	else{
		//Сheck that we have a file
		if((!empty($_FILES["pageImg"])) && ($_FILES['pageImg']['error'] == 0)) {
		  //Check if the file is JPEG/GIF image and it's size is <= 1 Mb
		  $filename = basename($_FILES['pageImg']['name']);
		  $ext = substr($filename, strrpos($filename, '.') + 1);
		  if (($ext == "jpg" || $ext == "gif") && ($_FILES["pageImg"]["type"] == "image/jpeg" || $_FILES["pageImg"]["type"] == "image/gif") && ($_FILES["pageImg"]["size"] < 1048600)) {
			//Determine the path to which we want to save this file
			  $newname = dirname(dirname(__FILE__)).'/uploads/'.$_SESSION['uid'].'-'.$filename;
			  $db_path = '/uploads/'.$_SESSION['uid'].'-'.$filename;
			  //Check if the file with the same name is already exists on the server
			  if (!file_exists($newname)) {
				//Attempt to move the uploaded file to it's new place
				if ((move_uploaded_file($_FILES['pageImg']['tmp_name'],$newname))) {
				   $validated_data['pageImg'] = $db_path;
				} else {
				   $validated_data = NULL;
				   echo "Neuspjelo dodavanje slike. Molim pokušajte ponovo.";
				}
			  } else {
				$validated_data  = NULL;
				echo "Greška: Slika ".$_FILES["pageImg"]["name"]." već postoji";
			  }
		  } else {
			$validated_data = NULL;
			 echo "Greška: Slika mora biti jpeg/gif, veličine do 1 MB";
		  }
		} else {
			$validated_data = NULL;
			echo "Greška - Niste dodali sliku lokacije";
		}
	}

}
//var_dump($validated_data);
if($validated_data === false) {
    echo $gump->get_readable_errors(true);
} else {
  //var_dump($validated_data); // validation successful
    $cleanData = $validated_data;
}

