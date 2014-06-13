<?php

$req = $app->request()->post();

// VALIDACIJA na serverskoj strani se vrši GUMP klasom (https://github.com/Wixel/GUMP),
// dok je na klijentskoj strani za to zadužen jQuery Validation plugin (http://bassistance.de/jquery-plugins/jquery-plugin-validation/)
require ROOT . 'lib/gump.class.php';

$gump = new GUMP();

$postData = $gump->sanitize($req); // You don't have to sanitize, but it's safest to do so.

$gump->validation_rules(array(
    'username'    => 'required|alpha_numeric|min_len,4',
    'email'    => 'required|valid_email',
    'pass'    => 'required|alpha_numeric|max_len,12|min_len,8',
    'passrepeat'    => 'required|alpha_numeric|min_len,8',
));

$gump->filter_rules(array(
    'username'    => 'trim|sanitize_string',
    'email'       => 'trim|sanitize_email',
    'pass'       => 'trim|sanitize_string',
    'passrepeat'       => 'trim|sanitize_string',
));

$validated_data = $gump->run($postData);

if ($validated_data !== FALSE) {
	$pass = md5($validated_data['pass']);
	$pass2 = md5($validated_data['passrepeat']);
	
	if($pass==$pass2){
    
		// validacija uz pomoc baze
		include_once('logic/idiormUse.php');

		// provjeri da li postoji korisnik s tim korisničkim imenom ili emailom
		$user = ORM::for_table('s2_users')
			->raw_query('SELECT * FROM s2_users u WHERE u.user_name = :uname OR u.user_email = :uemail', array('uname' => $validated_data['username'],'uemail' => $validated_data['email']))
			->find_many();
	
		// ako postoji korisnik	s tim imenom ili emailom
		if($user)
			$validated_data=NULL;
	}
	else 
		$validated_data=NULL;
}

//var_dump($validated_data);

if($validated_data === false) {
    echo $gump->get_readable_errors(true);
} else {
  //  print_r($validated_data); // validation successful
    $cleanData = $validated_data;
}

