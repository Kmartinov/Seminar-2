<!DOCTYPE html>

<html lang='en'>
  <head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>
      Naslov stranice @ Moreno
    </title>
    <!--Bootstrap -->
    <link href='<?php echo '' . $baseUrl . '/css/bootstrap.min.css' ?>' rel='stylesheet'>
    <link href='<?php echo '' . $baseUrl . '/css/customstyle.css' ?>' rel='stylesheet'>
    <!--HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src='https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js'>
    </script>
    <script src='https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js'>
    </script>
    <![endif]-->
  </head>
  <body id='page'>
    <nav role='navigation' class='navbar navbar-default navbar-fixed-top'>
      <div class='container'>
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class='navbar-header'>
          <button type='button' data-toggle='collapse' data-target='#bs-example-navbar-collapse-1' class='navbar-toggle'>
            <span class='sr-only'>
              Toggle navigation
            </span>
            <span class='icon-bar'>
            </span>
            <span class='icon-bar'>
            </span>
            <span class='icon-bar'>
            </span>
          </button>
          <a href='<?php echo '' . $baseUrl . '' ?>' class='navbar-brand'>
            W2GCRO
          </a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div id='bs-example-navbar-collapse-1' class='collapse navbar-collapse'>
          <ul class='nav navbar-nav'>
            <li>
              <a href='<?php echo "" . $baseUrl . "/search" ?>'>
                Pretraga
              </a>
            </li>
            <li>
              <a href='<?php echo '' . $baseUrl . '/new/location' ?>'>
                + Dodaj lokaciju
              </a>
            </li>
          </ul>
          <ul class='nav navbar-nav navbar-right'>
            <li>
              <p class='navbar-text'>
                <?php echo htmlspecialchars($user) ?>
              </p>
            </li>
            <?php if($isadmin) { ?>
              <li>
                <a href='<?php echo '' . $baseUrl . '/dashboard' ?>'>
                  Administracija
                </a>
              </li>
            <?php } ?>
            <li class='dropdown'>
              <a href='#' data-toggle='dropdown' class='dropdown-toggle'>
                Moj račun
                <b class='caret'>
                </b>
              </a>
              <ul class='dropdown-menu'>
                <li>
                  <a href='<?php echo '' . $baseUrl . '/user/' . $userid . '' ?>'>
                    Profil
                  </a>
                </li>
                <li class='divider'>
                </li>
                <li>
                  <a href='<?php echo '' . $baseUrl . '/logout' ?>'>
                    Odjava
                  </a>
                </li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    <div style='<?php echo 'background-image: url(' . $baseUrl . '/img/search_bg.jpg);position:relative;' ?>' class='intro-image'>
      <div class='searchform'>
        <div class='col-md-12'>
          <h3>
            Pretraži lokacije
            <small>
              Pronađi savršen odmor za sebe
            </small>
          </h3>
          <form action='<?php echo '' . $baseUrl . '/search/results' ?>' method='post'>
            <p>
              Traži po nazivu
              <input type='text' name='bytitle' placeholder='naziv lokacije' class='form-control'>
            </p>
            <p>
              Ili po vrsti odmora
              <select name='bycat' class='form-control'>
                <option value='0'>
                  -
                </option>
                <?php foreach ($categories as $category) { ?>
                  <option value='<?php echo '' . $category['category_id'] . '' ?>'>
                    <?php echo htmlspecialchars($category['category_title']) ?>
                  </option>
                <?php } ?>
              </select>
            </p>
            <button type='submit'>
              Traži
            </button>
          </form>
        </div>
      </div>
    </div>
    <div class='container'>
      <div class='col-md-12 page'>
        <div class='row'>
          <div class='col-md-4'>
            <div class='panel panel-default'>
              <div class='panel-body'>
                <h3>
                  Nove lokacije
                </h3>
                <ul>
                  <?php foreach ($newlocations as $recent) { ?>
                    <li>
                      <a href='<?php echo '' . $baseUrl . '/location/' . $recent['location_id'] . '' ?>'>
                        <?php echo htmlspecialchars($recent['location_name']) ?>
                      </a>
                    </li>
                  <?php } ?>
                </ul>
              </div>
            </div>
          </div>
          <div class='col-md-4'>
            <div class='panel panel-default'>
              <div class='panel-body'>
                <h3>
                  Top 10
                </h3>
                <ol>
                  <?php foreach ($toplocations as $top) { ?>
                    <li>
                      <a href='<?php echo '' . $baseUrl . '/location/' . $top['location_id'] . '' ?>'>
                        <?php echo htmlspecialchars($top['location_name']) ?>
                      </a>
                    </li>
                  <?php } ?>
                </ol>
              </div>
            </div>
          </div>
          <div class='col-md-4'>
            <div class='panel panel-default'>
              <div class='panel-body'>
                <h3>
                  Kategorije
                </h3>
                <ul>
                  <?php foreach ($categories as $allcat) { ?>
                    <li>
                      <a href='<?php echo '' . $baseUrl . '/category/' . $allcat['category_id'] . '' ?>'>
                        <?php echo htmlspecialchars($allcat['category_title']) ?>
                      </a>
                    </li>
                  <?php } ?>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js'>
    </script>
    <script src='<?php echo '' . $baseUrl . '/js/bootstrap.min.js' ?>'>
    </script>
  </body>
</html>
