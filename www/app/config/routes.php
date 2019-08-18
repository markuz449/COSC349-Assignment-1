<?php
$router = new Phalcon\Mvc\Router(false);
$router->removeExtraSlashes(true);
$router->setDefaultNamespace('App\Controllers');
// Define default routes. File gets included in services.php
$router->add('/', array(
	'controller' => 1
));
$router->add('/:controller/:action/:params', array(
	'controller' => 1,
	'action' => 2,
	'params' => 3,
));
$router->add('/:controller', array(
	'controller' => 1
));
// API controllers
$router->add('/api/:controller/:action/:params', array(
    'namespace' => 'App\API',
	'controller' => 1,
	'action' => 2,
	'params' => 3,
));
$router->add('/api/:controller', array(
    'namespace' => 'App\API',
	'controller' => 1
));
// Auth controllers
$router->add('/login', array(
	'controller' => 'session',
	'action'	=>	'start'
));
$router->add('/logout', array(
	'controller' => 'session',
	'action'	=>	'end'
));
$router->add('/forgotpassword', array(
	'controller' => 'session',
	'action'	=>	'forgotpassword'
));
$router->add('/chains/:params', array(
	'controller' => 'chains',
	'action' => 'view',
	'params' => 1,
));
$router->add('/review/:params', array(
	'controller' => 'review',
	'action' => 'index',
	'params' => 1,
));
$router->add('/resetpassword/:params', array(
	'controller' => 'session',
	'action'	=>	'resetpassword',
    'params'    => 1,
));
return $router;
