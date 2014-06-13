<?php
require_once 'idiorm.php';

// podesite parametre za svoju bazu
ORM::configure('mysql:host=localhost;dbname=mts2');
ORM::configure('username', 'mtadmin');
ORM::configure('password', 'Y29XTxHAveUe8mUL');

// iduća linija je potrebna kako bi natjerali konekciju prema MySQL-u u utf8
ORM::configure('driver_options', array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8'));

ORM::configure('id_column_overrides', array(
    's2_locations' => 'location_id',
    's2_categories' => 'category_id',
    's2_users' => 'user_id',
    's2_ratings' => 'rating_id',
    's2_comments' => 'comment_id',
    's2_roles' => 'role_id',
));

