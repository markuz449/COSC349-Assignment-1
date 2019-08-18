<!DOCTYPE html>
<html>
	<head>
		<!-- Basic Page Needs
	  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
	  <meta charset="utf-8">
      {{ getTitle() }}
      {% if meta_d is defined%}
	  <meta name="description" content="{{ meta_d }}">
      {% endif %}
	  <meta name="author" content="Nathan Hollows">

	  <!-- Mobile Specific Metas
	   –––––––––––––––––––––––––––––––––––––––––––––––––– -->
	   <meta name="viewport" content="width=device-width, initial-scale=1">

	   <!-- FONT
		–––––––––––––––––––––––––––––––––––––––––––––––––– -->

<link href="https://fonts.googleapis.com/css?family=Fjalla+One|Noto+Sans:400,700&display=swap" rel="stylesheet">


		<!-- CSS
	  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
	  <link rel="stylesheet" href="/css/normalize.css">
	  <link rel="stylesheet" href="/css/skeleton.css?b">

	  <!-- Favicon
	   –––––––––––––––––––––––––––––––––––––––––––––––––– -->


        <!-- Chicken by Ecem Afacan from the Noun Projectthenounproject.com -->
        <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
        <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
        <link rel="manifest" href="/site.webmanifest">
        <link rel="mask-icon" href="/safari-pinned-tab.svg" color="#213140">
        <meta name="msapplication-TileColor" content="#213140">
        <meta name="theme-color" content="#ffffff">

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-142609992-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-142609992-1');
</script>


	   <head>
    <body>
	  <div class="navBar" id="mainNavBar">
        <div class="container">
<a href="/" class="title">Nugget Watch
<a href="/about" {% if router.getControllerName() is "about" %}class="active"{% endif %}>About
<a href="/chains" {% if router.getControllerName() is "chains" %}class="active"{% endif %}>Chains
<a href="/contact" class="{% if router.getControllerName() is 'contact' %}active {% endif %}">Contact</a>
<a href="/review" class="{% if router.getControllerName() is "review" %}active{% endif %} u-pull-right">Write a Review</a>
		  <a href="javascript:void(0);" class="icon" onClick="openDrawerMenu()">&#9776;</a>
          </div>
	  </div>
        {{ content() }}
        {{ partial('partials/footer') }}
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
