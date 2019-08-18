<!DOCTYPE html>
<html>
	<head>
		<!-- Basic Page Needs
	  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
	  <meta charset="utf-8">
        {{ getTitle() }}
	  <meta name="description" content="">
	  <meta name="author" content="Nathan Hollows">

	  <!-- Mobile Specific Metas
	   –––––––––––––––––––––––––––––––––––––––––––––––––– -->
	   <meta name="viewport" content="width=device-width, initial-scale=1">

	   <!-- FONT
		–––––––––––––––––––––––––––––––––––––––––––––––––– -->

<link href="https://fonts.googleapis.com/css?family=Fjalla+One|Noto+Sans:400,700&display=swap" rel="stylesheet">


		<!-- CSS
	  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
	  <link rel="stylesheet" href="/css/normalize.css?a=1">
	  <link rel="stylesheet" href="/css/skeleton.css?2">

	  <!-- Favicon
	   –––––––––––––––––––––––––––––––––––––––––––––––––– -->
	   <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
	   <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
	   <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
	   <link rel="manifest" href="/site.webmanifest">
	   <link rel="mask-icon" href="/safari-pinned-tab.svg" color="#c1022b">
	   <meta name="msapplication-TileColor" content="#2b5797">
	   <meta name="theme-color" content="#ffffff">


	   <head>
    <body>
	  <div class="navBar" id="mainNavBar">
        <div class="container">
		  <a href="/" class="title active">Nugget Watch</a>
		  <a href="/messages">Messages</a>
		  <a href="/prices">Prices</a>
		  <a href="/reviews">Reviews</a>
          <a href="/logout" class="{% if router.getControllerName() is 'contact' %}active {% endif %}u-pull-right">Logout</a>
		  <!--&#9776; is the code for the 3 line menu button-->
		  <a href="javascript:void(0);" class="icon" onClick="openDrawerMenu()">&#9776;</a>
        </div>
	  </div>
        {{ content() }}
		{# Menu script #}
	  <script>
function openDrawerMenu(){
	var x = document.getElementById("mainNavBar");
	if (x.className === "navBar"){
		x.className += " responsive";
	} else {
		x.className = "navBar";
	}
}
	  </script>
    </body>
</html>
