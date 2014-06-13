<?php
//bootstrap the application
require_once 'bootstrap.php';
$app->appUrl = 'http://www.awesome.dev/s2';


// sustav ne koristi lokalne sesije, nego kriptirane kolačiće kod korisnika. Ovo je lozinka.
$app->add(new \Slim\Middleware\SessionCookie(array('secret' => 'mts2app')));


// funkcija koja provjerava je li korisnik autenticiran
$authenticate = function ($app) {
    return function () use ($app) {
        if (!isset($_SESSION['user'])) {
            $_SESSION['urlRedirect'] = $app->request()->getPath();
            $app->flash('error', 'Login required');
            $app->redirect($app->urlFor('login'));
        }
    };
};

// funkcija koja provjerava da li korisnik ima pravo pristupa
$authorize = function ($app) {
    return function () use ($app) {
        if (isset($_SESSION['role']) && $_SESSION['role']==2) {
            $app->redirect($app->urlFor('search'));
        }
    };
};

// Postavljamo base url za daljnje korištenje
$app->hook('slim.before', function () use ($app) {
    $app->view()->appendData(array('baseUrl' => $app->appUrl));
});

// postavlja neke parametre prije davanja stranice template enginu
$app->hook('slim.before.dispatch', function () use ($app) {
    $user = null; $isadmin = false; $userid = null;
    if (isset($_SESSION['user'])) {
        $user = $_SESSION['user'];
        $userid = $_SESSION['uid'];
        $isadmin = $_SESSION['isadmin'];
    }

    $app->view()->appendData(array(
        'user' => $user,
        'userid' => $userid,
        'isadmin' => $isadmin
    ));
});

// Kontrola što se dobiva na stranici na čistom URL-u, bez ikakve dodatne oznake.
$app->get('/', function () use ($app) {
    
	$app->render('welcome');
	
})->name('welcome');


// Kontrola za stranicu za /login 
$app->get('/login', function () use ($app) {
    $app->render('login');
})->name('login');


// Kontrola za stranicu za /login 
$app->post('/login', function () use ($app) {
    require_once "logic/auth.php";
    if (isset($_SESSION['user']) && strlen($_SESSION['user']) > 0) {
		if(isset($_SESSION['urlRedirect']))
			$app->redirect(''.$_SESSION['urlRedirect'].'');
		else
			$app->redirect($app->urlFor('search'));
    } else {
        $app->flashNow("error", "Greška u korisničkom imenu ili lozinci");
        $app->render('login');
    }
});


// Kontrola za logout
// isključivo GET pristup stranici.
$app->get('/logout', $authenticate, function () use ($app) {
    if (isset($_SESSION['user'])) {
        //unset($_SESSION['user']);
        session_unset();
        $app->flashNow("error", "Hvala na korištenju sustava");
        $app->redirect($app->urlFor('login'));
    } else {
        $app->flashNow("error", "Za odspajanje je potrebno prvo biti spojeni!");
        $app->render('login');
    }

});

// Kontrola za stranicu za /register 
// GET za register - netko se tek želi registrirati.
$app->get('/register', function () use ($app) {

    $app->render('register');
	
})->name('register');

// Post metoda za registraciju
$app->post('/register', function() use ($app) {
	require_once "logic/register.php";
		
		if(isset($cleanData)){
			include_once('logic/idiormUse.php');
			
			$mdpass = md5($cleanData['pass']);

			// upisujemo podatke u tablicu korisnika
			$newUser = ORM::for_table('s2_users')->create();

			$newUser->user_name = $cleanData['username'];
			$newUser->user_password = $mdpass;
			$newUser->user_email = $cleanData['email'];
			$newUser->user_role = 2;

			$newUser->save();
			$app->redirect($app->urlFor('login'));
		}
		else 
			$app->render('register');
});

// kontrola za pregled kategorije. Sav kod je umetnut ovdje u kontroler
// isključivo GET pristup stranici
$app->get('/category/:id', $authenticate($app), function($id) use ($app) {
    
    include_once('logic/idiormUse.php');

    $cat = ORM::for_table('s2_categories')->find_one($id);
    
    if($cat){
    
        $locations = ORM::for_table('s2_locations')
            ->select('s2_locations.*')
            ->where('location_cat', $id )
            ->find_many();
            
        if($locations){
            $app->view()->appendData(array(
                'locations'=>$locations,
                'cat'=>$cat
            ));
            $app->render('category');
        }
        else{
            $app->flash('info', 'Trenutno nema lokacija u ovoj kategoriji!');
            $app->view()->appendData(array(
                'locations'=>$locations,
                'cat'=>$cat
            ));
            $app->render('category');
        }
    }
    else
        $app->render('404');
    
})->name('category');

// kontrola za pregled jedne lokacije. Sav kod je umetnut ovdje u kontroler
// isključivo GET pristup stranici
$app->get('/category/:id/edit', $authenticate($app), $authorize($app), function($id) use ($app) {
    
    include_once('logic/idiormUse.php');
	
	$category = ORM::for_table('s2_categories')->find_one($id);
	
    $app->view()->setData('category', $category);
	
    $app->render('edit-category');
})->name('category-edit');

// kontrola za slanje izmjena kategorije
$app->post('/category/:id/edit', $authenticate($app), $authorize($app), function($id) use ($app){
	require_once('logic/newCategory.php');
	
	if(isset($cleanData)){
	
		include_once('logic/idiormUse.php');
		
		$catUp = ORM::for_table('s2_categories')->find_one($id);
		
		$catUp->category_title = $cleanData['catTitle'];
		$catUp->category_desc = $cleanData['catDesc'];
		
		$catUp->save();
		
		$app->redirect($app->urlFor('category', array('id' => $id)));
	}
	else {
		$app->redirect($app->urlFor('category-edit', array('id' => $id)));
	}
	
});

// kontrola za pregled jedne lokacije. Sav kod je umetnut ovdje u kontroler
// isključivo GET pristup stranici
$app->get('/location/:id', $authenticate($app), function($id) use ($app) {
    
    include_once('logic/idiormUse.php');

    $location = ORM::for_table('s2_locations')->find_one($id);
	
    if($location){
        $commentCount = ORM::for_table('s2_comments')
            ->table_alias('c')
            ->select('c.comment_id')
            ->where('c.comment_lid', $id)
            ->count();
                
        $comments = ORM::for_table('s2_comments')
                ->table_alias('c')
                ->select('c.*')
                ->select('u.user_name', 'username')
                ->join('s2_users', array('c.comment_author','=','u.user_id'), 'u')
                ->where('c.comment_lid',$id)
                ->order_by_asc('c.comment_date')
                ->find_many();
            
        $userVoted = ORM::for_table('s2_ratings')
            ->select('s2_ratings.*')
            ->where('rating_lid', $id)
            ->where_raw('(`rating_uid` = ?)', array($_SESSION['uid']))
            ->find_one();
            
        if($userVoted)
            $hideVoting = true;
        else $hideVoting = false;

        $app->view()->appendData(array(
                'location'=>$location, 
                'comCount'=>$commentCount, 
                'commentsList'=>$comments, 
                'userVoted'=>$hideVoting
        ));
        
        $app->render('location');
    }
    else $app->render('404');
})->name('location');

// kontrola za pregled jedne lokacije. Sav kod je umetnut ovdje u kontroler
// isključivo GET pristup stranici
$app->get('/location/:id/edit', $authenticate($app), $authorize($app), function($id) use ($app) {
    
    include_once('logic/idiormUse.php');

    $location = ORM::for_table('s2_locations')
        ->select('s2_locations.*')
        ->where('location_id', $id )
        ->find_one();
		
	$locationCat = ORM::for_table('s2_categories')->find_one($location->location_cat);
		
	$categories = ORM::for_table('s2_categories')
		->select('s2_categories.*')			
		->order_by_asc('category_title')
		->find_many();

    $app->view()->appendData(array(
            'location'=>$location, 
            'locationCat'=>$locationCat, 
            'categories'=>$categories
    ));
    
    $app->render('edit-location');
	
})->name('page-edit');

// kontrola za slanje izmjena lokacije
$app->post('/location/:id/edit', $authenticate($app), $authorize($app), function($id) use ($app){
	require_once('logic/editLocation.php');
	
	if(isset($cleanData)){
	
		include_once('logic/idiormUse.php');
		
		$locationUp = ORM::for_table('s2_locations')
			->select('s2_locations.*')
			->where('location_id', $id )
			->find_one();
		
		$locationUp->location_name = $cleanData['pageTitle'];
		$locationUp->location_desc = $cleanData['pageDesc'];
		$locationUp->location_text = $cleanData['pageTxt'];
		$locationUp->location_lat = $cleanData['lat'];
		$locationUp->location_lng = $cleanData['lng'];
		
		
		// da li je kategorija mijenjana
		if($cleanData['catId'])
			$locationUp->location_cat = $cleanData['catId'];
		
		if($cleanData['pageImg'])
			$locationUp->location_image = $cleanData['pageImg'];
		
		$locationUp->save();
		
		$app->redirect($app->urlFor('location', array('id' => $id)));
	}
	else {
		$app->redirect($app->urlFor('page-edit', array('id' => $id)));
	}
	
});


// dodavanje komentara za lokaciju
$app->post('/location/:id', $authenticate($app), function($id) use ($app) {
    //$app->redirect('http://www.awesome.dev/s2/page/'.$id.'');
	require_once('logic/newComment.php');
	
	if(isset($cleanData)){
			include_once('logic/idiormUse.php');
			date_default_timezone_set('Europe/Zagreb');
			
			// upisujemo podatke u tablicu lokacija
			$comment = ORM::for_table('s2_comments')->create();

			$comment->comment_lid = $id;
			$comment->comment_author = $_SESSION['uid'];
			$comment->comment_text = $cleanData['comTxt'];
			$comment->comment_date = date('Y-m-d H:i:s');

			$comment->save();
			
			if($cleanData['locationRating']>0){
				// upisujemo podatke u tablicu ocjena
				$rating = ORM::for_table('s2_ratings')->create();

				$rating->rating_lid = $id;
				$rating->rating_uid = $_SESSION['uid'];
				$rating->rating_vote = $cleanData['locationRating'];

				$rating->save();
                
                if($rating->id()){
                    // izracunavamo novu vrijednost ocjene lokacije
                    $locrate = ORM::for_table('s2_ratings')->select('s2_ratings.*')->where('rating_lid', $id)->find_many();
                              
                    if($locrate){
                   
                        $sum = 0;
                        $count = 0;
                        
                        foreach($locrate as $loc){
                            $sum += $loc->rating_vote;
                            $count++;
                        }
                        
                        $total = $sum/$count;
                        
                        $updated = ORM::for_table('s2_locations')->find_one($id);
                        $updated->set('location_rating', $total);
                        $updated->save();
                    }
                }
                
			}
	}
	$app->redirect($app->urlFor('location', array('id' => $id)));
});

// Uređivanje komentara i brisanje
// isključivo GET pristup stranici
$app->get('/comment/:id/edit', $authenticate($app), $authorize($app), function($id) use ($app) {
    
    include_once('logic/idiormUse.php');
	
	$comment = ORM::for_table('s2_comments')->find_one($id);
	
    $app->view()->setData('comment', $comment);
	
    $app->render('edit-comment');
})->name('comment-edit');

// kontrola za slanje izmjena komentara
$app->post('/comment/:id/edit', $authenticate($app), $authorize($app), function($id) use ($app){
	require_once('logic/editComment.php');
	
	if(isset($cleanData)){
	
		include_once('logic/idiormUse.php');
		
		$comUp = ORM::for_table('s2_comments')->find_one($id);
		$lid = $comUp->comment_lid;
		
		if(!$cleanData['delete']){
		
			$comUp->comment_text = $cleanData['comTxt'];
						
			$comUp->save();
			
		} else $comUp->delete();
		
		$app->redirect($app->urlFor('location', array('id' => $lid)));
	}
	else {
		$app->redirect($app->urlFor('comment-edit', array('id' => $id)));
	}
	
});

// Kontrola za stranicu za pretragu 
// GET za pretragu - čista stranica
$app->get('/search', $authenticate($app), function () use ($app) {
	
		include_once('logic/idiormUse.php');

		$recentLocations = ORM::for_table('s2_locations')
			->select('s2_locations.*')
			->order_by_desc('location_id')
            ->limit(10)
			->find_many();
            
        $topLocations = ORM::for_table('s2_locations')
			->select('s2_locations.*')
			->order_by_desc('location_rating')
            ->limit(10)
			->find_many();

		$categories = ORM::for_table('s2_categories')
			->select('s2_categories.*')
			->order_by_asc('category_title')
			->find_many();

		$app->view()->appendData(array(
            'toplocations'=> $topLocations,
            'newlocations'=> $recentLocations,
            'categories'=> $categories
        ));
		
    $app->render('search');
})->name('search');

// Kontrola za stranicu za pretragu 
// POST za pretragu
$app->post('/search/results', $authenticate($app), function () use ($app) {
	
    require_once('logic/search.php');
	
	if(isset($cleanData)){
	
		include_once('logic/idiormUse.php');
				
		if(isset($cleanData['bytitle']) || isset($cleanData['bycat'])){
            $sres = ORM::for_table('s2_locations')
                ->select('s2_locations.*')
                ->where_raw('(location_name LIKE ? OR location_cat = ?)',array('%'.$cleanData['bytitle'].'%', $cleanData['bycat']))
                ->find_many();
                
            $categories = ORM::for_table('s2_categories')
			->select('s2_categories.*')
			->order_by_asc('category_title')
			->find_many();
            
            $app->view()->appendData(array(
                'results'=> $sres,
                'categories' => $categories
            ));
            $app->render('search-results');
		} 	
	}
	else {
		$app->redirect($app->urlFor('search'));
	}
	
});

// Kontrola za stranicu administracije 
// GET za administraciju - čista stranica
$app->get('/dashboard', $authenticate($app), $authorize($app), function () use ($app) {

		include_once('logic/idiormUse.php');

		$recentLocations = ORM::for_table('s2_locations')
			->table_alias('l')
			->select('l.location_id', 'id')
			->select('l.location_name', 'name')
			->select('c.category_id', 'cid')
			->select('c.category_title', 'cat')
			->join('s2_categories', array('l.location_cat','=','c.category_id'), 'c')
			->order_by_desc('id')
            ->limit(10)
			->find_many();
		
		$totalLocations = ORM::for_table('s2_locations')
			->select('s2_locations.location_id')
			->count();
			
		$totalCategories = ORM::for_table('s2_categories')
			->select('s2_categories.category_id')
			->count();
		
		$totalUsers = ORM::for_table('s2_users')
			->select('s2_users.user_id')
			->count();
		
		$app->view()->appendData(array(
			'recentLocations' => $recentLocations, 
			'totalLocations' => $totalLocations, 
			'totalCategories' => $totalCategories, 
			'totalUsers' => $totalUsers
		));

    $app->render('dashboard');
	
})->name('dashboard');

// Kontrola za dodavanje stranice/kategorije 
// GET za dodavanje stranica/kategorija - čista stranica
$app->get('/new/:type', $authenticate($app), function ($type) use ($app) {
	if($type=='location'){
		
		include_once('logic/idiormUse.php');

		$categories = ORM::for_table('s2_categories')
			->select('s2_categories.*')
			->order_by_asc('category_title')
			->find_many();

		$app->view()->setData('categories', $categories);
	
	
		$app->render('new-location');
	}
	else if($type=='category'){
		$app->render('new-category');
	}
	else $app->render('404');
})->name('new');

// Kontrola za dodavanje stranice/kategorije 
// POST za dodavanje stranica/kategorija - čista stranica
$app->post('/new/:type', $authenticate($app), function ($type) use ($app) {
	if($type=='location'){
		
		require_once('logic/newLocation.php');
		
		if(isset($cleanData)){
			include_once('logic/idiormUse.php');

			// upisujemo podatke u tablicu lokacija
			$location = ORM::for_table('s2_locations')->create();

			$location->location_name = $cleanData['pageTitle'];
			$location->location_desc = $cleanData['pageDesc'];
			$location->location_text = $cleanData['pageTxt'];
			$location->location_cat = $cleanData['catId'];
			$location->location_author = $_SESSION['uid'];
			$location->location_image = $cleanData['pageImg'];

			$location->save();

			if($location->id()){
				$nid = $location->id();
				$app->redirect($app->urlFor('location', array('id' => $nid)));
			} else $app->render('new-location');
			
		}
        $app->flash('error', 'Greška! Sva polja moraju biti ispunjena!');
		$app->redirect($app->urlFor('new', array('type' => 'location')));
	}
	else if($type=='category'){
		
		require_once('logic/newCategory.php');
		
		if(isset($cleanData)){
		
			include_once('logic/idiormUse.php');

			// upisujemo podatke u tablicu kategorija
			$location = ORM::for_table('s2_categories')->create();

			$location->category_title = $cleanData['catTitle'];
			$location->category_desc = $cleanData['catDesc'];

			$location->save();
			
			$app->flash('success', 'Uspješno dodana kategorija - "'.$cleanData['catTitle'].'"');
            $app->redirect($app->urlFor('new', array('type' => 'category')));
		}
        $app->flash('error', 'Greška! Sva polja moraju biti ispunjena!');
		$app->redirect($app->urlFor('new', array('type' => 'category')));		
	}
});

// kontrola za pregled korisnika.
// isključivo GET pristup stranici
$app->get('/user/:id', $authenticate($app), function($id) use ($app) {
    
    include_once('logic/idiormUse.php');

    $userprofile = ORM::for_table('s2_users')->find_one($id);
    
    if($userprofile){
    
        $added = ORM::for_table('s2_locations')
                ->where('location_author', $id)
                ->find_many();
    
        $app->view()->appendData(array(
                    'isauthor' => $added,
                    'userprofile' => $userprofile
        ));
        $app->render('user');
    }
    else
        $app->render('404');
    
})->name('user');

//let Slim work its magic
$app->run();
