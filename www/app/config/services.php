<?php

use Phalcon\DI\FactoryDefault;
use Phalcon\Flash\Direct as FlashDirect;
use Phalcon\Flash\Session as FlashSession;
use Phalcon\Mvc\View;
use Phalcon\Mvc\Router;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Db\Adapter\Pdo\Mysql as DbAdapter;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Model\Metadata\Memory as MetaDataAdapter;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Mvc\View\Engine\Php as PhpViewEngine;
use \Phalcon\Mvc\Dispatcher as PhDispatcher;

/**
 * The FactoryDefault Dependency Injector automatically registers the right
 * services to provide a full stack framework
 */
$di = new FactoryDefault();

$di->set('router', function(){
		return require __DIR__ . '/routes.php';
}, true);

/**
 * The URL component is used to generate all kind of urls in the application
 */
$di->set(
    "url",
    function () use ($config) {
        $url = new UrlResolver();

        $url->setBaseUri(
            $config->application->baseUri
        );

        return $url;
    },
    true
);

// Set up the flash service
$di->set(
    'flash',
    function () {
        return new FlashDirect([
			'error'   => 'alert alert-error',
			'success' => 'alert alert-success',
			'notice'  => 'alert alert-info',
			'warning' => 'alert alert-warning',
		]);
    }
);

// Set up the flash session service
$di->set(
    'flashSession',
    function () {
        return new FlashSession([
			'error'   => 'alert alert-error',
			'success' => 'alert alert-success',
			'notice'  => 'alert alert-info',
			'warning' => 'alert alert-warning',
		]);
    }
);

/**
 * Setting up the view component
 */
$di->set(
    "view",
    function () use ($config) {
        $view = new View();

        $view->setViewsDir(
            $config->application->viewsDir
        );


        $view->registerEngines(
            [
                ".volt" => function ($view, $di) use ($config) {
                    $volt = new VoltEngine($view, $di);

                    $volt->setOptions(
                        [
                            "compiledPath"      => $config->application->cacheDir,
                            "compiledSeparator" => "_",
                        ]
                    );

                    $compiler = $volt->getCompiler();
                    $compiler->addFilter('diffForHumans', function($resolvedArgs, $exprArgs){
                        return '\Carbon\Carbon::createFromFormat("Y-m-d H:i:s", '.$resolvedArgs.')->diffForHumans()';
                    });
                    $compiler->addFilter('money', function($resolvedArgs, $exprArgs){
                        return 'money_format(\'$%i\', ' . $resolvedArgs .')';
                    });
                    $compiler->addFilter('date', function($resolvedArgs, $exprArgs){
                        return 'date("d F Y", strtotime(' . $resolvedArgs .'))';
                    });

                    return $volt;
                },

                // Generate Template files uses PHP itself as the template engine
                ".phtml" => PhpViewEngine::class
            ]
        );

        return $view;
    },
    true
);

/**
 * Database connection is created based on the parameters defined in the
 * configuration file
 */
$di->set(
    'db',
    function () use ($config) {
        return new DbAdapter(
            [
                "host"     => $config->database->host,
                "username" => $config->database->username,
                "password" => $config->database->password,
                "dbname"   => $config->database->dbname,
            ]
        );
    }
);

/**
 * If the configuration specify the use of metadata adapter use it or use memory otherwise
 */
$di->set(
    "modelsMetadata",
    function () use ($config) {
        return new MetaDataAdapter();
    }
);

/**
 * Start the session the first time some component request the session service
 */
$di->set(
    "session",
    function () {
        $session = new SessionAdapter();

        $session->start();

        return $session;
    }
);

$di->set(
    'dispatcher',
    function() use ($di) {

        $evManager = $di->getShared('eventsManager');

        $evManager->attach(
            "dispatch:beforeException",
			new App\Plugins\NotFoundPlugin()
        );

		$evManager->attach(
			'dispatch:beforeExecuteRoute',
			new App\Plugins\SecurityPlugin()
		);

        $dispatcher = new PhDispatcher();
		$dispatcher->setDefaultNamespace('App\Controllers');
        $dispatcher->setEventsManager($evManager);
        return $dispatcher;
    },
    true
);

// Register composer autoloader
require_once((__DIR__) . '/../../vendor/autoload.php');
