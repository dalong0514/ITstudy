# dingo-api

[dingo/api: A RESTful API package for the Laravel and Lumen frameworks.](https://github.com/dingo/api)

[Home · dingo/api Wiki](https://github.com/dingo/api/wiki)

## Home

The Dingo API package is meant to provide you, the developer, with a set of tools to help you easily and quickly build your own API. While the goal of this package is to remain as flexible as possible it still won't cover all situations and solve all problems.



Configuration
Creating API Endpoints
Responses
Errors And Error Responses
Transformers
Authentication
Rate Limiting
Internal Requests
OAuth 2.0
Making Requests To Your API
API Blueprint Documentation
Commands
Package Incompatibilities

## Installation

Requirements
Please note, that only versions 5.6+ of Laravel/Lumen are supported. Additionally, only version 2 of this package is supported.

Laravel 6 is supported.

To install this package you will need:

PHP ^7.1 (Laravel 5.6+)
PHP ^7.2 (Laravel 6+)
You must then modify your composer.json file and run composer update to include the latest version of the package in your project.

"require": {
    "dingo/api": "^2.4.0"
}
At this time the package is still in a developmental stage and as such does not have a stable release. You may need to set your minimum-stability to dev.

Once the package is installed the next step is dependant on which framework you're using.

Laravel
If you'd like to make configuration changes in the configuration file you can publish it with the following Artisan command:

php artisan vendor:publish --provider="Dingo\Api\Provider\LaravelServiceProvider"
Lumen
Open bootstrap/app.php and register the required service provider.

$app->register(Dingo\Api\Provider\LumenServiceProvider::class);
Facades
There are two facades shipped with the package. You can add either of them should you wish.

Dingo\Api\Facade\API
This is a facade for the dispatcher, however, it also provides helper methods for other methods throughout the package.

Dingo\Api\Facade\Route
This is a facade for the API router and can be used to fetch the current route, request, check the current route name, etc.

