<?php

use Phalcon\Loader;

$loader = new Loader();

$loader->registerNamespaces(
	array(
		'App\Controllers'	=> $config->application->controllersDir,
		'App\API'	=> $config->application->apiDir,
		'App\Models' 		=> $config->application->modelsDir,
		'App\Forms' 		=> $config->application->formsDir,
		'App\Plugins' 		=> $config->application->pluginsDir,
	)
)->register();

/**
 * We're a registering a set of directories taken from the configuration file
 */
$loader->registerDirs(
    [
        $config->application->controllersDir,
        $config->application->modelsDir,
        $config->application->formsDir,
        $config->application->pluginsDir,
    ]
);

$loader->register();
