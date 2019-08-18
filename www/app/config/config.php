<?php

use Phalcon\Config;

define('CONSUMER_KEY', '');
define('CONSUMER_SECRET', '');
define('ACCESS_TOKEN', '');
define('ACCESS_TOKEN_SECRET', '');

return new Config(
    [
        "database" => [
            "adapter"     => "Mysql",
            "host"        => "localhost",
            "username"    => "",
            "password"    => "",
            "dbname"      => "nugget",
        ],
        "application" => [
            "controllersDir" => __DIR__ . "/../../app/controllers/",
            "apiDir" => __DIR__ . "/../../app/controllers/api/",
            "modelsDir"      => __DIR__ . "/../../app/models/",
            "viewsDir"       => __DIR__ . "/../../app/views/",
            "formsDir"       => __DIR__ . "/../../app/forms/",
            "pluginsDir"     => __DIR__ . "/../../app/plugins/",
            "libraryDir"     => __DIR__ . "/../../app/library/",
            "cacheDir"       => __DIR__ . "/../../app/cache/",
            "baseUri"        => "/",
        ],
    ]
);
