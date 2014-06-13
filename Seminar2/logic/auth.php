<?php

$req = $app->request()->post();

// VALIDACIJA na serverskoj strani se vrši GUMP klasom (https://github.com/Wixel/GUMP),
// dok je na klijentskoj strani za to zadužen jQuery Validation plugin (http://bassistance.de/jquery-plugins/jquery-plugin-validation/)
require ROOT . 'lib/gump.class.php';

$gump = new GUMP();

$postData = $gump->sanitize($req); // You don't have to sanitize, but it's safest to do so.

$gump->validation_rules(array(
    'username'    => 'required|alpha_numeric|min_len,4',
    'password'    => 'required|alpha_numeric|min_len,8',
));

$gump->filter_rules(array(
    'username'    => 'trim|sanitize_string',
    'password'       => 'trim|sanitize_string',
));

$validated_data = $gump->run($postData);

if ($validated_data !== FALSE) {
	$pass = md5($validated_data['password']);
    $admin = false;
	// validacija uz pomoc baze
	include_once('logic/idiormUse.php');

    // provjeri da li postoji korisnik s tom kombinacijom imena/lozinke
    $user = ORM::for_table('s2_users')
        ->select('s2_users.*')
        ->where('user_name', $validated_data['username'])
		->where_raw('(`user_password` = ?)', array($pass))
        ->find_one();
	
	// ako ne postoji korisnik	
	if(!$user)
        $validated_data=NULL;
	else {
		$validated_data['uid'] = $user->user_id;
		$validated_data['role'] = $user->user_role;
		if($user->user_role == 1)
			$admin = true;
		else $admin = false;
	}
}

//var_dump($validated_data);

if($validated_data === false) {
    echo $gump->get_readable_errors(true);
} else {
  //  print_r($validated_data); // validation successful
    $_SESSION['user']=$validated_data['username'];
    $_SESSION['uid']=$validated_data['uid'];
    $_SESSION['role']=$validated_data['role'];
    $_SESSION['isadmin']=$admin;
}

