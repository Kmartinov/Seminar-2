<!DOCTYPE html>

<html lang='en'>
  <head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>
      Registracija @ Moreno
    </title>
    <!--
    <Bootstrap>
       
    </Bootstrap>
    -->
    <link href='css/bootstrap.min.css' rel='stylesheet'>
    <link href='css/customstyle.css' rel='stylesheet'>
    <!--
    <HTML5>
      Shim and Respond.js IE8 support of HTML5 elements and media queries 
    </HTML5>
    -->
    <!--
    <WARNING>
      <Respond class='js'>
        doesn't work if you view the page via file:// 
      </Respond>
    </WARNING>
    -->
    <!--[if lt IE 9]>
    <script src='https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js'>
    </script>
    <script src='https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js'>
    </script>
    <![endif]-->
  </head>
  <body>
    <div class='container'>
      <div class='row credentials-panel'>
        <div class='col-md-4 col-md-push-4'>
          <div class='welcome-panel'>
            <div class='page-header'>
              <h1>
                Registracija
              </h1>
            </div>
            <form role='form' method='post'>
              <div class='form-group'>
                <input id='registername' type='text' name='username' placeholder='Korisničko ime' class='form-control'>
              </div>
              <div class='form-group'>
                <input id='registeremail' type='email' name='email' placeholder='Email adresa' class='form-control'>
              </div>
              <div class='form-group'>
                <input id='registerpass' type='password' name='pass' placeholder='Lozinka' class='form-control'>
              </div>
              <div class='form-group'>
                <input id='registerrepeatpass' type='password' name='passrepeat' placeholder='Ponovite lozinku' class='form-control'>
              </div>
              <button type='submit' class='btn btn-primary'>
                Registracija
              </button>
              <p class='sub'>
                <a href='<?php echo '' . $baseUrl . '' ?>'>
                  ← Natrag na W2GCRO
                </a>
              </p>
            </form>
          </div>
        </div>
      </div>
    </div>
    <!--
    <jQuery>
      (necessary for Bootstrap's JavaScript plugins) 
    </jQuery>
    -->
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js'>
    </script>
    <!--
    <Include>
      all compiled plugins (below), or include individual files as needed 
    </Include>
    -->
    <script src='js/bootstrap.min.js'>
    </script>
  </body>
</html>
