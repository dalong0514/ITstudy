Kousha

[Laravel Eloquent - Attach vs Sync](https://stackoverflow.com/questions/23968415/laravel-eloquent-attach-vs-sync)

What is the difference between attach() and sync() in Laravel 4's Eloquent ORM? I've tried to look around but couldn't find anything!

2014-05-31 09:25:16Z

What is the difference between attach() and sync() in Laravel 4's Eloquent ORM? I've tried to look around but couldn't find anything!attach(): Example:sync():Similar to the attach() method, the sync() method is used to attach related models. However, the main differences are:Example:user_roleThe above operation will delete:And insert role_id 3 to the table.user_role tableTo make it even simpler:The attach function only adds records to the Pivot table.The sync function replaces the current records with the new records. This is very useful for updating a model.Example: Assuming you have a created Post that has many Tags attached on it where the Tags ID's are [1,2,3].And the user has the ability to update the Post and its Tags.The user will send you the new Tags ID's [3,4,5]. If you use the sync function, the new Tags of the Post will be [3,4,5] only.If you use the attach function, the new Tags of the Post will be [1,2,3,4,5].

Laravel migration table field's type change

naing linhtut

[Laravel migration table field's type change](https://stackoverflow.com/questions/32940495/laravel-migration-table-fields-type-change)

Following is my file 2015_09_14_051851_create_orders_table.php.

And I want to change $table->integer('category_id'); as a string with new migration.

2015-10-05 02:33:32Z

Following is my file 2015_09_14_051851_create_orders_table.php.

And I want to change $table->integer('category_id'); as a string with new migration.update: 31 Oct 2018, Still usable on laravel 5.7 https://laravel.com/docs/5.7/migrations#modifying-columnsTo make some change to existing db, you can modify column type by using  change() in migration.This is what you could doplease note you need to add doctrine/dbal dependency to composer.json

for more information you can find it here http://laravel.com/docs/5.1/migrations#modifying-columnsThe standard solution didn't work for me, when changing the type from TEXT to LONGTEXT.I had to it like this:This could be a Doctrine issue. More information here.Another way to do it is to use the string() method, and set the value to the text type max length:2018 Solution, still other answers are valid but you dont need to use any dependency:First you have to create a new migration:Then in that migration file up(), try:If you donot change the size default will be varchar(191) but If you want to change size of the field:Then migrate the file by:more info from doc.all other answers are Correct But  Before you runmake sure you run this code first to avoid this error First composer requires doctrine/dbal, then:For me the solution was just replace unsigned with indexThis is the full code:Not really an answer, but just a note about ->change():https://laravel.com/docs/5.8/migrations#modifying-columnsIf your column isn't one of these you will need to either drop the column or use the alter statement as mentioned in other answers.

Get previous attribute value in Eloquent model event

coatesap

[Get previous attribute value in Eloquent model event](https://stackoverflow.com/questions/17367383/get-previous-attribute-value-in-eloquent-model-event)

Is there a way to see the old/previous value of a model's attribute in its saving or updating event?eg. Is something like the following possible:

2013-06-28 14:42:38Z

Is there a way to see the old/previous value of a model's attribute in its saving or updating event?eg. Is something like the following possible:Ok, I found this quite by chance, as it's not in the documentation at present...There is a getOriginal() method available which returns an array of the original attribute values:In Laravel 4.0 and 4.1, you can check with isDirty() method:You could overload the methods, then call the parent method.

Laravel where on relationship object

Lic

[Laravel where on relationship object](https://stackoverflow.com/questions/29989908/laravel-where-on-relationship-object)

I'm developing a web API with Laravel 5.0 but I'm not sure about a specific query I'm trying to build.My classes are as follows:andNow, I want to get all the events with a specific participant.

I tried with:but the where condition is applied on the Event and not on its Participants. The following gives me an exception:I know that I can write this:but it doesn't seem very efficient to send so many queries to the server.What is the best way to perform a where through a model relationship using Laravel 5 and Eloquent?

2015-05-01 15:31:43Z

I'm developing a web API with Laravel 5.0 but I'm not sure about a specific query I'm trying to build.My classes are as follows:andNow, I want to get all the events with a specific participant.

I tried with:but the where condition is applied on the Event and not on its Participants. The following gives me an exception:I know that I can write this:but it doesn't seem very efficient to send so many queries to the server.What is the best way to perform a where through a model relationship using Laravel 5 and Eloquent?The correct syntax to do this on your relations is:Read more at https://laravel.com/docs/5.8/eloquent-relationships#eager-loading@Cermbo's answer is not related to this question. in this answer, Laravel will give you all Events if per Event has 'participants' with IdUser is 1.But if you want to get all Events with all 'participants' provided that per 'partecipants' with IdUser is 1, then you should do something like this :attention to:in where use your table name, no Model name.this worked for me

Laravel use same form for create and edit

Kevin Joymungol

[Laravel use same form for create and edit](https://stackoverflow.com/questions/22844022/laravel-use-same-form-for-create-and-edit)

Am quite new to Laravel and I have to create a form for create and a form for edit. In my form I have quite some jquery ajax posts. Am wondering whether Laravel does provide for an easy way for me to use the same form for my edit and create without having to add tons of logic in my code. I don't want to check if am in edit or create mode every time when assigning values to fields when the form loads. Any ideas on how I can accomplish this with minimum coding?

2014-04-03 16:47:28Z

Am quite new to Laravel and I have to create a form for create and a form for edit. In my form I have quite some jquery ajax posts. Am wondering whether Laravel does provide for an easy way for me to use the same form for my edit and create without having to add tons of logic in my code. I don't want to check if am in edit or create mode every time when assigning values to fields when the form loads. Any ideas on how I can accomplish this with minimum coding?I like to use form model binding so I can easily populate a form's fields with corresponding value, so I follow this approach (using a user model for example):So, for example, from a controller, I basically use the same form for creating and updating, like:Pretty easy in your controller you do:And you just have to use this way:Another clean method with a small controller, two views and a partial view :UsersController.phpcreate.blade.phpedit.blade.php_fields.blade.phpFor the creation add an empty object to the view.Old function has a second parameter, default value, if you pass there the object's field, the input can be reused.For the form action, you can use the correct endpoint.And for the update you have to use PATCH method.Simple and clean :)UserController.phpedit.blade.phpInstead of creating two methods - one for creating new row and one for updating, you should use findOrNew() method. So:In Rails, it has form_for helper, so we could make a function like form_for.We can make a Form macro, for example in resource/macro/html.php:(if you don't know how to setup a macro, you can google "laravel 5 Macro")The Controller:Then in the view _form.blade.php:Then view create.blade.php:Then view edit.blade.php:You can use form binding and 3 methods in your Controller. Here's what I doAnd in my views I have UserController.phpuser.blade.phpFor example, your controller, retrive data and put the viewAdd default value in the same form, create and edit, is very simpleAnd, you remember add csrf_field, in case a POST method requesting. Therefore, repeat input, and select element, compare each option I hope this will help you!!form.blade.phpcreate.blade.phpedit.blade.phpUsersController.php

How to bind parameters to a raw DB query in Laravel that's used on a model?

MarkL

[How to bind parameters to a raw DB query in Laravel that's used on a model?](https://stackoverflow.com/questions/20864872/how-to-bind-parameters-to-a-raw-db-query-in-laravel-thats-used-on-a-model)

Re,I have the following query:It doesn't work: Invalid parameter number: mixed named and positional parameters.Does anyone know a trick or a workaround (I can obviously write the full query but prefer to use fluent builder).

2014-01-01 01:43:55Z

Re,I have the following query:It doesn't work: Invalid parameter number: mixed named and positional parameters.Does anyone know a trick or a workaround (I can obviously write the full query but prefer to use fluent builder).OK, after some experimenting, here's the solution that I came up with:Basically, setBindings has to be called on the query. Wish this was documented!Old question, but if we have to repeat a variable, we have to change its key value in the bindings array.That's enough.why not?I encountered same issue just recently and the answer is in that error message mixed named and positional parameters. In your case, the :lat and :lng are named parameters while you have $radius as positional. So one possible fix to your issue is make use of havingRaw() and apply named parameters. 

--havingRaw('distance < :radius', ['radius' => $radius])

I ported the nearby search from Doctrine v1 to Laravel, check it out here.Just add the Geographical trait to the model then you can do:It works by using selectRaw with bindings like this:

ReflectionException: Class ClassName does not exist - Laravel

Nana Partykar

[ReflectionException: Class ClassName does not exist - Laravel](https://stackoverflow.com/questions/32475892/reflectionexception-class-classname-does-not-exist-laravel)

As soon, I am typing php artisan db:seed command. I'm getting Error Like:root@dd-desktop:/opt/lampp/htdocs/dd/laravel# php artisan db:seedHere, Is my UserTableSeeder.php & DatabaseSeeder.php PageUserTableSeeder.phpDatabaseSeeder.phpI'm Referring This Link To Design & Develop Login Page.

Please Help me to resolve this issue. Thanks.

2015-09-09 09:30:00Z

As soon, I am typing php artisan db:seed command. I'm getting Error Like:root@dd-desktop:/opt/lampp/htdocs/dd/laravel# php artisan db:seedHere, Is my UserTableSeeder.php & DatabaseSeeder.php PageUserTableSeeder.phpDatabaseSeeder.phpI'm Referring This Link To Design & Develop Login Page.

Please Help me to resolve this issue. Thanks.Perform a composer update, then composer dump-autoload.If the above doesn't solve the problem, change the classmap in your composer.json file such that it contains the project-relative path to your php files:and soon after, perform a composer dump-autoload, and it should work now like a breeze!If composer dump-autoload is not found, just enable this option composer config -g -- disable-tls true.From my experience, this will show up most of the time when the class you are trying to call has some bugs and cannot be compiled.  Check if the class that is not being reflected can be executed at its own.A composer dump-autoload should fix it.I had this problem and I could solve it by doing php artisan config:cache.  The problem was that I had already run that command previously and later included some new seeder classes.  The cached configurations didn't recognize the new classes.  So running that command again worked.If you see yourself making frequent changes to include new seeder classes then consider running php artisan config:clear.  This will enable you to make as many changes as you'd like and then after testing you can run config:cache again to make things run optimally again.For some reason I had to run composer dumpautoload -o. Notice flag -o which mean with optimization. I don't have any idea why it works only with it but give it a try. Perhaps it helps someone.I have the same problem with a class. I tried composer dump-autoload and php artisan config:clear but it did not solve my problem.Then I decided to read my code to find the problem and I found the problem. The problem in my case was a missing comma in my class. See my Model code:Check your capitalization!Your host system (Windows or Mac) is case insensitive by default, and Homestead inherits this behavior. Your production server on the other hand is case sensitive.Whenever you get a ClassNotFound Exception check the following:try to use following commandYou need to assign it to a name space for it to be found.I am not writing as the answer for this question. But I want to help others if they faced the same bug but the answers mentioned here not works. I also tried all the solutions mentioned here. But my problem was with the namespace I used. The path was wrong.The namespace I used is:But actually the controller reside inside a folder named 'FrontEnd'so the solution is change the namespace to:This will surely work. 

If not then, you need to do and then, the aforementioned commands. If the issue is not resolved by composer dump-autoload or is not a newly created class.Check for syntax errors in your class and its traits as well.

In my case, there was a syntax error in a Trait, but ReflectionException was shown for the actual Class using that Trait instead.When it is looking for the seeder class file, you can run composer dump-autoload. When you run it again and it's looking for the Model, you can reference it on the seeder file itself. Like so,Not strictly related to the question but received the error ReflectionException: Class config does not existI had added a new .env variable with spaces in it. Running php artisan config:clear told me that any .env variable with spaces in it should be surrounded by "s.Did this and  my application stated working again, no need for config clear as still in development on Laravel Homestead (5.4)I've recreated class, and it worked. Copy all file content, delete file, and run php artisan make:seeder ModelTableSeeder. Because composer dump-autoload didn't worked for me. You may try to write app in use uppercase, so App. Worked for me.this will fix itUsually error message ReflectionException: Class app does not exist appears in larval test when you forget to close connection.if you're using setUp or tearDown function in your test do not forget to close connection by calling parent::setUp and parent::tearDownIn case of using psr-0 , check the class name does not contain underscore .Above command worked for me.Whenever you make new migration in la-ravel you need to refresh classmap in composer.json file .I had this error when trying to reach an endpoint in a custom route file, that had a namespace prepended in RouteServiceProviderUpdating the namespace in the RouteServiceProvider solved the issue, as the relative controller path specified in the routes file was now resolving correctly.

Laravel-5 how to populate select box from database with id value and name value

borracciaBlu

[Laravel-5 how to populate select box from database with id value and name value](https://stackoverflow.com/questions/29508297/laravel-5-how-to-populate-select-box-from-database-with-id-value-and-name-value)

I want to create a select box like the one below using illuminate\html :In my controller I tried this:And in my view this:The issue is that instead of $item->name is displaying all the info of the entity. 

2015-04-08 07:17:38Z

I want to create a select box like the one below using illuminate\html :In my controller I tried this:And in my view this:The issue is that instead of $item->name is displaying all the info of the entity. Laravel provides a Query Builder with lists() functionIn your case, you can replace your codewithAlso, you can chain it with other Query Builder as well.source: http://laravel.com/docs/5.0/queries#selectsUpdate for Laravel 5.2 Thank you very much @jarry. As you mentioned, the function for Laravel 5.2 should beorref: https://laravel.com/docs/5.2/upgrade#upgrade-5.2.0  -- look at Deprecations listsLaravel >= 5.3 method lists() is deprecated use pluck()This will give you a select box with same select options as id numbers in DBfor example if you have this in your DB table: in select box it will be like thisI found out that pluck now returns a collection, and you need to add ->toArray() at the end of pluck...so like this: pluck('name', 'id')->toArray();Just change your controller to the following:And your view to:Hope this will solve your problemControllercompact('campaignStatus') will result in  [id=>status]; //example [1 => 'pending']ViewIn your controller, add,And in your view, useIn select box, it will be like this,Laravel use array for Form::select. So I passed array like below:In your view:Laravel 5.3  use pluck($value, $key )$value is displayed in your drop list and $key is idcontrollerviewLaravel 5.*In your controller:In your view:I have added toArray() after pluckSorry for the late reply Obviously lists method has been deprecated in Laravel, but you can use the pluck method. For Eg:Laravel 5.7and in the view if you are FORM components just pass asif will generate the dropdownbut i have a situation to show that select country as the first option and as null valueso I have referred to and fixed this, but in later times if I want to change this I hate being changing it in the viewSo have created the helper function  based on https://stackoverflow.com/a/51324218/8487424  and placed in the  Country Modeland in controllerand finally in the viewand the result is as expected, but I strongly recommend to use pluck() methodFor Laravel 5 :Push an item onto the beginning of the collection.Many has been said already but keep in mind that there are a times where u don't want to output all the records from the database into your select input field ..... Key example I have been working on this school management site where I have to output all the noticeboard categories in a select statement. From my controller this is the code I wrote Noticeboard:: groupBy()->pluck('category')->get(); This way u get distinct record as they have been grouped so no repetition of recordsTo populate the drop-down select box in laravel we have to follow the below steps.From controller we have to get the value like this:And the same we can display in view:This key value in drop down you can use as per your requirement.

Hope it may help someone.I was trying to do the same thing in Laravel 5.8 and got an error about calling pluck statically. For my solution I used the following. The collection clearly was called todoStatuses.Try this one. Without using controller

Php artisan make:auth command is not defined

naan

[Php artisan make:auth command is not defined](https://stackoverflow.com/questions/34545641/php-artisan-makeauth-command-is-not-defined)

I am trying to run this command in laravel 5.2 but it's not working.and prompts with these statements.

2015-12-31 11:16:08Z

I am trying to run this command in laravel 5.2 but it's not working.and prompts with these statements.For Laravel >=6Reference : Laravel Documentation for authenticationit looks you are not using Laravel 5.2, these are the available make commands in L5.2 and you are missing more than just the make:auth commandBe sure you have this dependency in your composer.json fileThen runUpdate for Laravel 6Now that Laravel 6 is released you need to install laravel/ui.You can change vue with react if you use React in your project (see Using React).And then you need to perform the migrations and compile the frontendSource : Laravel Documentation for authenticationNote: That's only if you want to use scaffolding, you can use the default User model and the Eloquent authentication driver.Update Nov 18th:

Taylor just released Laravel Installer 2.3.0 added a new "--auth" flag to create a new project with the authentication scaffolding installed!To update laravel installer read hereIt means we can do:Which is a shorthand of commands in the Section B. Also read more hereStep 1 - First do this:Note: 

Laravel UI Composer package is a new first-party package that extracts the UI portion of a Laravel project ( frontend scaffolding typically provided with previous releases of Laravel ) into a separate laravel/ui package. The separate package enables the Laravel team to update, develop and version UI scaffolding package separately from the primary framework and the main Laravel codebase.Step 2 - Then do this:or instead ofMore Options hereThe above command will generate only the auth routes, a HomeController, auth views, and a app.blade.php layout file.You can also generate the views only with:The console command will prompt you to confirm overwriting auth files if you've already run the command before.and also:To see differences read this articleStep 3 - Then you need to do:In short and precise, all you need to do is php artisan ui vue --auth and then the migrate php artisan migrate.Just for an overview of Laravel AuthenticationLaravel Authentication facilities comes with Guard and Providers, Guards define how users are authenticated for each request whereas Providers define how users are retrieved from you persistent storage.Database Consideration - By default Laravel includes an App\User Eloquent Model in your app directory.Auth Namespace - App\Http\Controllers\AuthControllers - RegisterController, LoginController, ForgotPasswordController and ResetPasswordController, all names are meaningful and easy to understand!Routing - Laravel/ui package provides a quick way to scaffold all the routes and views you need for authentication using a few simple commands (as mentioned in the start instead of make:auth).You can disable any newly created controller, e. g. RegisterController and modify your route declaration like, Auth::routes(['register' => false]);

For further detail please look into the Laravel Documentation.In the Laravel 6 application the make:auth command no longer exists.Laravel UI is a new first-party package that extracts the UI portion of a Laravel project into a separate laravel/ui  package. The separate package enables the Laravel team to iterate on the UI package separately from the main Laravel codebase.You can install the laravel/ui package via composer:Besides the new ui command, the laravel/ui package comes with another command for generating the auth scaffolding:If you run the ui:auth command, it will generate the auth routes, a HomeController, auth views, and a app.blade.php layout file.If you want to generate the views alone, type the following command instead:If you want to generate the auth scaffolding at the same time:php artisan ui vue --auth command will create all of the views you need for authentication and place them in the resources/views/auth directoryThe ui command will also create a resources/views/layouts directory containing a base layout for your application. All of these views use the Bootstrap CSS framework, but you are free to customize them however you wish.More detail follow. laravel-news & documentation

How do I write to the console from a Laravel Controller?

Jrop

[How do I write to the console from a Laravel Controller?](https://stackoverflow.com/questions/25148662/how-do-i-write-to-the-console-from-a-laravel-controller)

So I have a Laravel controller:Currently, I'm running the application using artisan (which runs PHP's built-in development web server under the hood):I would like to log console messages to the STDOUT pipe for the artisan process.

2014-08-05 21:29:34Z

So I have a Laravel controller:Currently, I'm running the application using artisan (which runs PHP's built-in development web server under the hood):I would like to log console messages to the STDOUT pipe for the artisan process.Aha!This can be done with the following PHP function:Found the answer here: Print something in PHP built-in web serverThe question relates to serving via artisan and so Jrop's answer is ideal in that case. I.e, error_log logging to the apache log.However, if your serving via a standard web server then simply use the Laravel specific logging functions:With current versions of laravel like this for info:This logs to Laravel's log file located at /laravel/storage/logs/laravel-<date>.log (laravel 5.0). Monitor the log - linux/osx: tail -f /laravel/storage/logs/laravel-<date>.logI haven't tried this myself, but a quick dig through the library suggests you can do this:I couldn't find a shortcut for this, so you would probably want to create a facade to avoid duplication.It's very simple.You can call it from anywhere in APP.For better explain Dave Morrissey's answer I have made these steps for wrap  with Console Output class in a laravel facade.1) Create a Facade in your prefer folder (in my case app\Facades):2) Register a new Service Provider in app\Providers as follow:}3) Add all this stuffs in config\app.php file, registering the provider and alias. That's it, now in any place of your Laravel application, just call your method in this way:Hope this help you.If you want to log to STDOUT you can use any of the ways Laravel provides; for example (from wired00's answer):The STDOUT magic can be done with the following (you are setting the file where info messages go):Word of caution: this is strictly for debugging. Do no use anything in production you don't fully understand.I wanted my logging information to be sent to stdout because it's easy to tell Amazon's Container service (ECS) to collect stdout and send it to CloudWatch Logs. So to get this working, I added a new stdout entry to my config/logging.php file like so:Then I simply added 'stdout' as one of the channels in the stack log channel:This way, I still get logs in a file for local development (or even on the instance if you can access it), but more importantly they get sent to the stdout which is saved in CloudWatch Logs.If you want the fancy command IO from Laravel (like styling, asking and table) then I created this class belowI have not fully verified everywhere that it is THE cleanest solution etc, but it works nice (but I only tested it from within a unit test case, under Laravel 5.5).So most probably you can use it however you like:Or course you can also wrap in your own facade, or some static singleton etc, or anyway you wish.In Laravel 6 there is a channel called 'stderr'. See config/logging.php:In your controller:Bit late to this...I'm surprised that no one mentioned Symfony's VarDumper component that Laravel includes, in part, for its dd() (and lesser-known, dump()) utility functions. There's a bit more code needed, but, in return, we get nice formatted, readable output in the console—especially useful for debugging complex objects or arrays: To take this a step further, we can even colorize the output! Add this helper function to the project to save some typing: If we're running the app behind a full webserver (like Apache or Nginx—not artisan serve), we can modify this function slightly to send the dumper's prettified output to the log (typically storage/logs/laravel.log):...and, of course, watch the log using: PHP's error_log() works fine for quick, one-off inspection of simple values, but the functions shown above take the hard work out of debugging some of Laravel's more complicated classes.You can use echo and prefix "\033", simple:And change color text:I use this for Lumen, pretty sure it will work with Laravel too

Laravel 5 - Interface is not instantiable

Andrew Kulakov

[Laravel 5 - Interface is not instantiable](https://stackoverflow.com/questions/29690056/laravel-5-interface-is-not-instantiable)

I know that this question was asked so many times, but none of answers helped me.I'm getting exception in Laravel 5What I've done without success:Structure:App\Contracts\CustomModelInterface.phpApp\Repositories\CustomModelRepository.phpApp\Services\MyService.php (Keep business logic / layer between controller and repositories)App\Providers\AppRepositoryProvider.phpMy controller looks like:composer.json

2015-04-17 04:04:03Z

I know that this question was asked so many times, but none of answers helped me.I'm getting exception in Laravel 5What I've done without success:Structure:App\Contracts\CustomModelInterface.phpApp\Repositories\CustomModelRepository.phpApp\Services\MyService.php (Keep business logic / layer between controller and repositories)App\Providers\AppRepositoryProvider.phpMy controller looks like:composer.jsonThank you everyone, but problem was in my AppRepositoryProvider. As it's binding exception, then obviously the problem was with binding :)Correct file is:Note, that I'm using "App\Contracts\\{$model}Interface" (not escaping "{" symbol) and it generate correct string App\Contracts\CustomModelInterface instead of App\Contracts\{$model}Interface (with unexpected escaping).Every time I create a new repository/contract pair I make sure I do the following: Many hours of useless debugging led me to this short checklist.For me, I forgot to bind in app->providers->RepositoryServiceProvider

the repository like this in the register methodMake sure your RepositoryServiceProvider is registered in AppServiceProvider.I got past this error running:Related to:Target is not instantiable. Laravel 5 - App binding service providerOn App\Services\MyService.php you are passing that interface with dependency injection which tries to instantiate that - which is wrong.Try implement that in that class - class MyService implements CustomModelInterface { and use the function of that interface like - Or you are using it - class CustomModelRepository implements CustomModelInterface {So if you do - then also you can access the interface methods.I've just experienced an issue similar to this and the cause of my error was that I had set $defer to true in the service provider class but I had not implemented the required provides() method.If you have deferred the creation of your class until it is need rather than it being loaded eagerly, then you need to also implement the provides method which should simply return an array of the classes that the provider provides. In the case of an interface, I believe it should be the name of the interface rather than the concrete class.E.g.Current documentation: https://laravel.com/docs/5.5/providers#deferred-providersI hope this helps somebody else.Don't worry guys. I have a solution to your problem.I have an example for you.Step1: php artisan make:repository Repository/Post    //By adding this command you can create a repository and eloquent filesStep2: After adding that file you have to add/use this repository in the controller in which you want to use.for eg: use App\Repositories\Contracts\PostRepository;Step3: After adding that repo in your controller if you will run the app you will get an error like " Interface is not instantiable". It comes because you have created a repo and used in a controller, but laravel don't know where this repository is register and bind with which eloquent. So that it throws an error.Step4: To solve this error you have to bind your repo with your eloquent in AppServiceProvider. 

    E.g: AppServiceProvider.php fileStep5: After binding repo and eloquent you can use all method of repo in your controller. Enjoy.....Please let me know if you have any query.I think the problem here is that you don't bind App\Contracts\CustomModelInterface to anything so Laravel tries to create instance of interface.In App\Providers\AppRepositoryProvider.php you have only:but you should have in this array CustomModel also, so it should look like this:Note that this can also be caused by the _constructor on the class being declared private, or otherwise being blocked...

If it cant call the constructor, the binding will failThe last thing you do is to use the interface you bound to the repository. Set it up and try running your laravel app to make sure you get no errors. In my case I had a mismatch between my repository and interface.As you can see the interface get method does not include a type hint but the UserRepository class' get method has a type hint.You won't get this error if you immediately start to use your Interface Binding.The problem is solved by adding your repository in app/providers/AppServiceProvider

like the example below.Dont forget the name spaceIt worked for me

Laravel firstOrNew how to check if it's first or new?

raphadko

[Laravel firstOrNew how to check if it's first or new?](https://stackoverflow.com/questions/30686880/laravel-firstornew-how-to-check-if-its-first-or-new)

I'm using Laravel's function firstOrNew() to create a new user or find and update an existing one.How can I know, after the object is created, if it existed before or if it's a new object?The idea is something like this:

2015-06-06 19:45:51Z

I'm using Laravel's function firstOrNew() to create a new user or find and update an existing one.How can I know, after the object is created, if it existed before or if it's a new object?The idea is something like this:You can check the exists property on the Model.You can check if your user was recently created.(Source: Thomas Kim from this answer)If you created the model in the current lifecycle, then the model's wasRecentlyCreated attribute will be set to true. Otherwise, that attribute will be set to false.In other words, lets say you have a user with the email, test@yopmail.com// the above will dump out false because this entry already existed otherwise true.You can always check for an ID (or any other unique primary key) in the model. It is important to keep in mind that after you persist the model using $user->save(), you will NOT be able to use $user->id to check if it was found in the database or not. This is because Eloquent populates all the attributes of the new model after it is saved.

How to set laravel 5.3 logout redirect path?

Tim van Uum

[How to set laravel 5.3 logout redirect path?](https://stackoverflow.com/questions/39327970/how-to-set-laravel-5-3-logout-redirect-path)

Is there no elegant solution to redirect to a specific page after logging out in Laravel 5.3? The function being called is from the trait AuthenticatesUsers: This is a default function from the core of laravel. So I have to override the whole function I cannot edit the core.

But isn't there a more simpler solution, cause it feel like overkill to manually logout, flush and regenerate again.Worked the answers out in an article:

https://codeneverlied.com/how-to-set-logout-redirect-path-in-laravel-5-8-and-before/

2016-09-05 09:51:24Z

Is there no elegant solution to redirect to a specific page after logging out in Laravel 5.3? The function being called is from the trait AuthenticatesUsers: This is a default function from the core of laravel. So I have to override the whole function I cannot edit the core.

But isn't there a more simpler solution, cause it feel like overkill to manually logout, flush and regenerate again.Worked the answers out in an article:

https://codeneverlied.com/how-to-set-logout-redirect-path-in-laravel-5-8-and-before/This is how I did it. In Auth\LoginController you have:Change it to:Then, define a new logout() method in your LoginController:Sure, regular logout() method in that trait has only 3 lines (used to log users out of the system) so you can copy them to your method, but you should always follow the DRY principle (don't repeat yourself) and re-use as much code as you can.The accepted answer is fine, but you can completely bypass touching any of the logout logic by simply overwriting the loggedOut method:I would inherit LoginController and override the logout function coming from the trait in there:LoginController.php -> leave that as it is.MyLoginController.php:Of course, you should remember to update your Auth routes accordingly.I'm using Laravel-5.2, what I used was:Make sure you have imported:In your controller.The Auth::routes method in laravel 5.3 registers a POST route for /logout instead of a GET route. This prevents other web applications from logging your users out of your application. To upgrade, you should either convert your logout requests to use the POST verb or just register your own GET route for the /logout URI by adding this route to the file Routes/web.php:-and it should work fine and redirect you to the '/' directory as it's defined in the LoginController.phpQuoted from:-https://laravel.com/docs/5.3/upgradeAssuming someone is viewing it now a days and the version of the laravel they are using is 5.7Add this line in LoginController.phpThis assumes you are using the out of the box authentication module provided by laravelEvery logout action fires an event Events\Logout. You can create a listener that listens to this event and add some logic to there. See more about listeners here https://laravel.com/docs/5.3/eventsThe simplest way is to override logout trait at LoginController in App\Http\Controllers\Auth\LoginController like thisIf you're using the out of the box AuthController add this variable to the top and then change the string to redirect wherever you want.The AuthenticatesUsers class has a logout function that checks for this variable.Just use this in routes/web.phpIn Laravel 5.8 find the below path :App\Http\Controllers\Auth\LoginController.phpwrite this function To avoid repeating logout code and to follow DRY, you may The accepted answer is fine, but you can completely bypass touching any of the logout logic by simply overwriting the loggedOut method:Illuminate Support package: override logout method in LoginController.phpyou can go to vendor\laravel\framework\src\Illuminate\Foundation\Auth\AuthenticatesUsers.php

in function logout change  return redirect('/'); to your route address.

How to set a default attribute value for a Laravel / Eloquent model?

J. Bruni

[How to set a default attribute value for a Laravel / Eloquent model?](https://stackoverflow.com/questions/18747500/how-to-set-a-default-attribute-value-for-a-laravel-eloquent-model)

If I try declaring a property, like this:...it doesn't work, because it is not considered an "attribute", but merely a property of the model class. Not only this, but also I am blocking access to the actually real and existent "quantity" attribute.What should I do, then?

2013-09-11 17:22:11Z

If I try declaring a property, like this:...it doesn't work, because it is not considered an "attribute", but merely a property of the model class. Not only this, but also I am blocking access to the actually real and existent "quantity" attribute.What should I do, then?An update to this...@j-bruni submitted a proposal and Laravel 4.0.x is now supporting using the following:Which will automatically set your attribute subject to A Post when you construct. You do not need to use the custom constructor he has mentioned in his answer.However, if you do end up using the constructor like he has (which I needed to do in order to use Carbon::now()) be careful that $this->setRawAttributes() will override whatever you have set using the $attributes array above. For example:See the Github thread for more info.This is what I'm doing now:I will suggest this as a PR so we don't need to declare this constructor at every Model, and can easily apply by simply declaring the $defaults array in our models...UPDATE:As pointed by cmfolio, the actual ANSWER is quite simple: Just override the $attributes property! Like this:The issue was discussed here.I know this is really old, but I just had this issue and was able to resolve this using this site.Add this code to your modelUpdate/DisclaimerThis code works, but it will override the regular Eloquent Model creating Event

Disable rate limiter in Laravel?

SimpleJ

[Disable rate limiter in Laravel?](https://stackoverflow.com/questions/43058219/disable-rate-limiter-in-laravel)

Is there a way to disable rate limiting on every/individual routes in Laravel?I'm trying to test an endpoint that receives a lot of requests, but randomly Laravel will start responding with { status: 429, responseText: 'Too Many Attempts.' } for a few hundred requests which makes testing a huge pain.

2017-03-27 23:40:06Z

Is there a way to disable rate limiting on every/individual routes in Laravel?I'm trying to test an endpoint that receives a lot of requests, but randomly Laravel will start responding with { status: 429, responseText: 'Too Many Attempts.' } for a few hundred requests which makes testing a huge pain.In app/Http/Kernel.php Laravel has a default throttle limit for all api routes.Comment or increase it. You can actually disable only a certain middleware in tests.   Assuming you are using the API routes then you can change the throttle in app/Http/Kernel.php or take it off entirely.  If you need to throttle for the other routes you can register the middleware for them separately.(example below: throttle - 60 attempts then locked out for 1 minute)In Laravel 5.7Dynamic Rate Limiting

You may specify a dynamic request maximum based on an attribute of the authenticated User model. For example, if your User model contains a rate_limit attribute, you may pass the name of the attribute to the throttle middleware so that it is used to calculate the maximum request count:https://laravel.com/docs/5.7/routing#rate-limitingIf you want to disable just for automated tests, you can use the WithoutMiddleware trait on your tests.Otherwise, just remove the 'throttle:60,1', line from your Kernel file (app/Http/Kernel.php), and your problem will be solved.A non-hacky way to increase the throttle in unit tests to avoid the dreaded 429:You can add the following lines in your app/Http/Kernel.phpIf the problem persists try the artisan command php artisan cache:clear

How can I manually return or throw a validation error/exception in Laravel?

Svish

[How can I manually return or throw a validation error/exception in Laravel?](https://stackoverflow.com/questions/47219542/how-can-i-manually-return-or-throw-a-validation-error-exception-in-laravel)

Have a method that's importing CSV-data into a Database. I do some basic validation using But after that things can go wrong for more complex reasons, further down the rabbit hole, that throws exceptions of some sort. I can't write proper validation stuff to use with the validate method here, but, I really like how Laravel works when the validation fails and how easy it is to embed the error(s) into the blade view etc, so...Is there a (preferably clean) way to manually tell Laravel that "I know I didn't use your validate method right now, but I'd really like you to expose this error here as if I did"? Is there something I can return, an exception I can wrap things with, or something?

2017-11-10 09:30:13Z

Have a method that's importing CSV-data into a Database. I do some basic validation using But after that things can go wrong for more complex reasons, further down the rabbit hole, that throws exceptions of some sort. I can't write proper validation stuff to use with the validate method here, but, I really like how Laravel works when the validation fails and how easy it is to embed the error(s) into the blade view etc, so...Is there a (preferably clean) way to manually tell Laravel that "I know I didn't use your validate method right now, but I'd really like you to expose this error here as if I did"? Is there something I can return, an exception I can wrap things with, or something?As of laravel 5.5, the ValidationException class has a static method withMessages that you can use:I haven't tested this, but it should work.UpdateThe message does not have to be wrapped in an array. You can also do:Laravel <= 6.2 this solution worked for me:Simply return from controller:    you can try a custom message bagi just add /**

     * @throws \Illuminate\Validation\ValidationException

     */and fix For Laravel 5.8:.The easiest way to throw an exception is like this:

What is the concept of Service Container in Laravel?

Nello

[What is the concept of Service Container in Laravel?](https://stackoverflow.com/questions/37038830/what-is-the-concept-of-service-container-in-laravel)

I am starting to look into Laravel but I don't understand the concept of Service Container.How does it work and what do developers need to know to fully utilize this concept in Laravel?

2016-05-04 22:01:02Z

I am starting to look into Laravel but I don't understand the concept of Service Container.How does it work and what do developers need to know to fully utilize this concept in Laravel?The Service Container in Laravel is a Dependency Injection Container and a Registry for the applicationThe advantages of using a Service Container over creating manually your objects are:Capacity to manage class dependencies on object creationYou define how a object should be created in one point of the application (the binding) and every time you need to create a new instance, you just ask it to the service container, and it will create it for you, along with the required dependenciesFor example, instead of creating objects manually with the new keyword:you can register a binding on the Service Container:and create an instance through the service container with:Binding of interfaces to concrete classes  With Laravel automatic dependency injection, when an interface is required in some part of the app (i.e. in a controller's constructor), a concrete class is instantiated automatically by the Service Container. Changing the concrete class on the binding, will change the concrete objects instantiated through all your app:Using the Service Container as a Registry    You can create and store unique object instances on the container and get them back later: using the App::instance method to make the binding, and thus using the container as a Registry.As a final note, essentially the Service Container -is- the Application object: it extends the Container class, getting all the container's funtionalities  Laravel container create instance for full application from services(class)

We don't need to create instance for our application likeFirst, We are going look bind static method of App class. bind is just binding your class instance(object) with an application, nothing more.Now, we can use this object for our application by using make a static method of App class.In above example when we are going to call make method then its generate every time new instance of class, So Laravel have pretty solution for Singleton

We can bind an object to our application by singleton method.We can be resolved by make method. Now, we have always received the exact same instance from this method.App::instance

We can bind an instance to the container and we will always return the exact same instance using instance method.We can be resolved byWe can bind interface byYaa, We have a question, How can we implement binding in our application? We can implement binding in our AppServiceProvider

Laravel : How to Log INFO to separate file

Rohit Jindal

[Laravel : How to Log INFO to separate file](https://stackoverflow.com/questions/32552450/laravel-how-to-log-info-to-separate-file)

How to specify a separate file for logging INFO in Laravel 5.1?Any immediate help will be highly appreciable. Thanks

2015-09-13 17:21:17Z

How to specify a separate file for logging INFO in Laravel 5.1?Any immediate help will be highly appreciable. ThanksDo you want to specifically log info to one log file and another log type to another location? My solution might not help in that case, but could still be useful.To write a log file to another location, use the method useDailyFiles or useFiles, and then info to log to the log file at the path you just specified. Like so:The first parameter for both methods is the path of the log file (which is created if it doesn't already exist) and for useDailyFiles the second argument is the number of days Laravel will log for before erasing old logs. The default value is unlimited, so in my example I haven't entered a value.In Laravel 5.6 you can create your own channel in config\logging.php. If you have upgraded from an older Laravel version you need to create this file (https://laravel.com/docs/5.6/upgrade).Add this to you channel array in config\logging.phpYou can then call  any of the 8 logging levels like that:The logs will be stored in logs/your_file_name.logIf you would like add another monolog handler, you may use the application's configureMonologUsing method. Place a call to this method in bootstrap/app.php file right before the $app variable is returned:A simple logger helper that allows you to log to multiple custom files on the fly. You can also add your custom handler and set the file path.App\Helper\LogToChannels.phpApp\Providers\LogToChannelsServiceProvider.phpconfig\app.php (add the service provider)Then anywhere in your app you can call using dependency injection (add the class in your constructor and bind it to a log class attribute)You can even customize your logger output by callingAnd it will be accessible when you will call its name anywhere in your app.Since Laravel >= 5.6 we can use Log Channels to make it work in a easy way. This allows you to create log channels which can be handled as own log files with own drivers, paths or levels. You just need this few lines to make it work. config/logging.php: Log where ever you want by parse the channel name:To activate logging to file in Laravel 5.8 or 6:Message will be logged to storage/logs/laravel.log. This is a default path for single channel at config/logging.php.

What is the best practice for adding constants in laravel? (Long List)

Faran Khan

[What is the best practice for adding constants in laravel? (Long List)](https://stackoverflow.com/questions/42155536/what-is-the-best-practice-for-adding-constants-in-laravel-long-list)

I am rather new to laravel. I have a basic question, What is the best way to add constants in laravel. 

I know the .env method that we use to add the constants. 

Also I have made one constants file to use them for my project. 

For example:And so on. It can reach upto 100 or more records. So What should be the best approach to write the constants. The .env method. Or adding the constant.php file?Thanks 

2017-02-10 09:13:26Z

I am rather new to laravel. I have a basic question, What is the best way to add constants in laravel. 

I know the .env method that we use to add the constants. 

Also I have made one constants file to use them for my project. 

For example:And so on. It can reach upto 100 or more records. So What should be the best approach to write the constants. The .env method. Or adding the constant.php file?Thanks For most constants used globally across the application, storing them in config files is sufficient. It is also pretty simpleCreate a new file in the config directory. Let's call it constants.phpIn there you have to return an array of config values.And you can access them as followsI use aliased class constants : First, create your class that contain your constants : App/MyApp.php for exempleThen add it to the aliased classes in the config/app.phpFinally use them wherever you like (controllers or even blades) : Your question was about the 'best practices' and you asked about the '.env method'..env is only for variables that change because the environment changes. Examples of different environments: test, acceptance, production. So the .env contains database credentials, API keys, etc.The .env should (imho) never contain constants which are the same over all environments. Just use the suggested config files for that.First you make Constants folder inside your app directory.And then you make Constants.php. Define your constants in this fileFor Example : And you modify the composer.jsonAlternatively, you can use composer.json to load the bootstrap/constants.php file by adding the following code to the「autoload」section, like so:And update your composer !You can create a file named paths.php in root directory/config/paths.phpInsert this data into paths.phpNote : make sure to run command : php artisan config:clearIn addition to Arun Singh's answer I would recommend you to use helpers.Inside your helper.php you may defineThus instead of you may callAnother way as following:You can define constants at the top of the web.php file located in routes and can be access the constants anywhere in project  with just constant nameor  -And use it like before:You can simply do this:

Setting up Laravel on a Mac php artisan migrate error: No such file or directory [duplicate]

Mwirabua Tim

[Setting up Laravel on a Mac php artisan migrate error: No such file or directory [duplicate]](https://stackoverflow.com/questions/19475762/setting-up-laravel-on-a-mac-php-artisan-migrate-error-no-such-file-or-directory)

NB:

php -v is 5.5 and mysql -v is 5.5 from the terminal

Here is part of my config/database.phpI tried replacing localhost with 127.0.0.1 with no avail. Kindly help..Edit:

I added these three lines in my php.ini I also added this symlink:But that didnt solve. I also pulled a fresh new laravel project from git and ran into the same error after composer install then php artisan migrateThe mac version is 10.7.4

2013-10-20 09:17:27Z

NB:

php -v is 5.5 and mysql -v is 5.5 from the terminal

Here is part of my config/database.phpI tried replacing localhost with 127.0.0.1 with no avail. Kindly help..Edit:

I added these three lines in my php.ini I also added this symlink:But that didnt solve. I also pulled a fresh new laravel project from git and ran into the same error after composer install then php artisan migrateThe mac version is 10.7.4If you are using MAMP be sure to add the unix_socket key with a value of the path that the mysql.sock resides in MAMP.First of all, get your unix_socket location.Enter your mysql password and login your mysql server from command line.Your unix_soket could be diffrent.Then you got 2 solution to solve your issue:(1) Change your config/database.php(2) Change your php.ini, find your php.ini file fromYou maybe install many php with different version, so please don't assume your php.ini file location, get it from your 'phpinfo';Change your php.ini:Then restart your apache or php-fpm.Had the same problem, but it's working for me now.If anybody is still having problems, try this:If you are using XAMPP, the solution is:This works for me in Laravel 5.0, change the DB_HOST=127.0.0.1:33060 in .env file.Others answers don't work... For Laravel 5.0+ change localhost to 127.0.0.1 in your .env file as well before you go playing around with Unix Sockets etc - this worked for me.Noobs beware: For anyone using Laravel 5 and using older learning material be aware that there was quite a marked shift in folder structure from previous versions though this seems to be for the better- check out this article https://mattstauffer.co/blog/laravel-5.0-directory-structure-and-namespaceIf you are using Laravle 5.1.11 version + MAC + MAMPP you  have to add  "Unix_socket " in  file "yourapp"/app/config/database.php  Unix_socket param was added to above  mysql config drive.Another solution is to add the port number in the host key. In this case MAMP uses the 8889 by default:

Laravel Eloquent: Return Array key as the fields ID

Broshi

[Laravel Eloquent: Return Array key as the fields ID](https://stackoverflow.com/questions/26865877/laravel-eloquent-return-array-key-as-the-fields-id)

When I execute a query via Laravel's Eloquent ORM, I want to get the row ID as the Array result key, this will make things easier when I want to check something based on an ID (using array_key_exists) or do some look ups (if I need a specific entry from the result array)Is there any way I can tell Eloquent to set the key to the fields ID?

2014-11-11 13:19:13Z

When I execute a query via Laravel's Eloquent ORM, I want to get the row ID as the Array result key, this will make things easier when I want to check something based on an ID (using array_key_exists) or do some look ups (if I need a specific entry from the result array)Is there any way I can tell Eloquent to set the key to the fields ID?

You can simply do Cheers :)Since you have an Eloquent Collection (a child class of the generic Collection class) you can use the getDictionary method. $collection->getDictionary() will give you an array of your Category objects keyed by their primary keys.If you wanted another Collection rather than a native PHP array, you could instead use $collection->keyBy($property). It looks like your primary key is category_id, so $collection->keyBy('category_id'). You can use that method to key by any arbitrary property, including any get mutators you may have written.While getDictionary is unique to the Eloquent Collection extension, keyBy is available to all Laravel Collection objects. See the Laravel 4.2 API docs or Laravel 5.0 API docs.You have a Support\Collection/Database\Eloquent\Collection you can use the method lists('id') to return an array of the id of each of the models within the collection. Then use array_combine to map the keys to the models. The result of which will be an array with the id mapped to their corresponding model. If you need id as the key, then rely on the Collection:Otherwise, nice or not, you can do this:pluck('label','id') on the get() output is what you're looking for in Laravel 5.8+, which gives you a collection, ready to be toArray()edeg:I had a similar challenge - I wanted to a PHP array to allow me  to create a  with an  for each choice, with the 's value being the id auto increment column, and the displayed text being the value.

Environment driven database settings in Laravel?

Hailwood

[Environment driven database settings in Laravel?](https://stackoverflow.com/questions/13860283/environment-driven-database-settings-in-laravel)

I am moving over the the Laravel framework, but I am having trouble with the database settings,Specifically, I have my environments setup, and they are working fine for the application.php config file, however the database.php config file seems to have no effect.Even if I have a database.php config file in my environments folder it is never loaded, I put a bunch of invalid characters (keyboard mash) into the file to get php to throw an error, but it is never hit.Does Laravel not support environment based database settings? or am I doing this wrong?

2012-12-13 12:53:49Z

I am moving over the the Laravel framework, but I am having trouble with the database settings,Specifically, I have my environments setup, and they are working fine for the application.php config file, however the database.php config file seems to have no effect.Even if I have a database.php config file in my environments folder it is never loaded, I put a bunch of invalid characters (keyboard mash) into the file to get php to throw an error, but it is never hit.Does Laravel not support environment based database settings? or am I doing this wrong?You can definitely set database settings (and any other config setting) by environment.For Laravel 3 (for Laravel 4 and Laravel 5 see below):Firstly - you need to define $environments in your paths.php and set it to something like this:Laravel will automatically look for this variable, and if set, will use the associated configuration.Normally you have a config folder, with settings such as database.php and auth.phpNow just create a new folder for each Laravel_Env you plan to use (such as Development). You'll end up with a folder structure like this;You'll note I've only included database.php in each subfolder. Laravel will always load the default config settings first, then override them with any custom configs from the environments setting.Finally, in your development/database file, you would have something like this;p.s. I just tested this on the current 3.2.12 build of Laravel - and it definitely works.Bonus Tip: You can also automatically set an environment for Artisan, so you do not have to include the environment manually on each command line! To do this:You should end up with something like this:Artisan will now run using your development environment. If you deploy to a live server - re-run these steps to get the hostname() for the server, and you can configure a specific artisan config just for the server!For Laravel 4:The default environment is always production. But in your start.php file you can define additional environments.On Linux and Mac, you may determine your hostname by type hostname in your terminal - it will output the name of your computer. On Windows put dd(gethostname()); at the beginning of your routes.php file - and run the website once - it will show you the current hostname of your computer.To get the current environment as a variable in your application - read this SO answer here. Laravel 4: how can I get the environment value?For Laravel 5:There is single configuration file, called .env in your root directory.

Watch this laracast, config explained fully.if you are using the artisan ( command line for laravel ) every command you need to add orHeres how I have it setup for my needs. I personally need 4 different configurations:Since all 4 of my environments have distinctive directory structure, I can use php's magic constant __DIR__ to fetch the app directory and then use the strpos() function to do a simple check and return the appropriate environment. It will take care of Artisan environment as well, no need to manually type the environment, or add any machine names.Inside the Add a callback functionWe can also set and grab all the values at once into an array, and run a foreach loop.Tip: Since we using the strpos() function, which checks position of the first occurrence of the given value against the $haystack, and returns the position number. We don't really have to supply the entire path, we can simply add a distinctive value from each path to get the job done. Whether we work on one machine or multiple, the chances of having the same path to different environments is very slim. Or so I think. :)How to setup environment specific configuration is now in the official Laravel docs. I would recommend using their method instead of the accepted answer:Use the DotEnv approach detailed in the Laravel docs here.We are using the method Jeffrey Way recommended in this Laracasts lesson.I've been working away on this today, struggling to work out how best to do environmental settings for a database. In the end, after trying several methods, I fully agree with @troy-harvey that Jeffrey Way's recommendation of doing this is the best (for me at least). One thing I will add to this, and its what held me up so much today is (and correct me if I'm wrong) that you need to access the settings you are trying to over-ride in your environmental settings file by their corresponding array keys. I started out returning a simple array:within an app/config/staging/database.php. This had no effect and after much head scratching realised that you need to access the array as it is presented in app/config/database.php, like so:At least this is how I finally managed to get my settings being picked up. Adding this here in case anyone else is struggling to work this out. Upon realisation I understood how obvious a mistake I was making. Edited 01 July 2014An additional comment to this is that since 4.1 Laravel ships with an append_config() helper function for appending environmental configurations to the main config array. This would look like this for the example given above:In Laravel 3 to detect the environment it was:Which would return whatever was identified in the environments array found in the paths.php file.As mentioned before in Laravel 4 it is now:My way of doing it!If you're trying to use Laravel in a Windows environment, check out the settings in file .env in the top level folder for your Laravel project - these will override whatever database settings you have in config/database.phpIf you are on Laravel 4 here is a gist that will take you through the process step by step. Credits to @"The Shift Exchange"'s answer for guiding me to create it.

Laravel 5.2 redirect back with success message

Stefan

[Laravel 5.2 redirect back with success message](https://stackoverflow.com/questions/37376168/laravel-5-2-redirect-back-with-success-message)

I'm trying to get a success message back to my home page on laravel.For some reason the variable $success doesn't get any value after running this code.The code I'm using to display the succes message:I have added the home and newsletter page to the web middleware group in routes.php like this:Does anyone have any idea why this doesn't seem to work?

2016-05-22 15:26:50Z

I'm trying to get a success message back to my home page on laravel.For some reason the variable $success doesn't get any value after running this code.The code I'm using to display the succes message:I have added the home and newsletter page to the web middleware group in routes.php like this:Does anyone have any idea why this doesn't seem to work?You should remove web middleware from routes.php. Adding web middleware manually causes session and request related problems in Laravel 5.2.27 and higher.If it didn't help (still, keep routes.php without web middleware), you can try little bit different approach:Displaying message if it exists:you can use this :and use this in your view :Controller:BladeYou can always save this part as separate blade file and include it easily.

fore example:All of the above are correct, but try this straight one-liner:{{session()->has('message') ? session()->get('message') : ''}}One way to do that is sending the message in the session like this:Controller:View:And other way to do that is just creating the session and put the text in the view directly:Controller:View:You can check the full documentation here: Redirecting With Flashed Session DataI hope it is very helpful, regards.You can simply use back() function to redirect no need to use redirect()->back() make sure you are using 5.2 or greater than 5.2 version.You can replace your code to below code.In the view file replace below code.For more detail, you can read here back() is just a helper function. It's doing the same thing as redirect()->back()In ControllerIn viewYou can use laravel MessageBag to add our own messages to existing messages.To use MessageBag you need to use:In the controller:Hope it will help some one.

Install dependency (doctrine/dbal) on composer laravel

elvainch

[Install dependency (doctrine/dbal) on composer laravel](https://stackoverflow.com/questions/22413408/install-dependency-doctrine-dbal-on-composer-laravel)

I am trying to execute a migration to rename some columns and I got an exception. As I read on the documentation I have to add the doctrine/dbal dependency to my composer.json file. How do I do that? Which is the correct composer.json file. I have many in my application. Is the one that is on the same level as the folders app,bootstrap, public and vendor.If so how do I add that dependency. Do I have to download anything?By the way im using easyphp, not wamp!After doing that the console throws this error

2014-03-14 18:51:33Z

I am trying to execute a migration to rename some columns and I got an exception. As I read on the documentation I have to add the doctrine/dbal dependency to my composer.json file. How do I do that? Which is the correct composer.json file. I have many in my application. Is the one that is on the same level as the folders app,bootstrap, public and vendor.If so how do I add that dependency. Do I have to download anything?By the way im using easyphp, not wamp!After doing that the console throws this errorTo add this dependency open the composer.json at the root of your project (in the same level as app, public etc.) and in the require section add the doctrine/dbal package like:Save the file and run composer updateEdit You probably installed git with the default settings and it's not in your PATH env.Open Git Bash (it was installed with git - you will find it in your programs) and do composer update. By the way it's far better that windows command prompt.1) To install dependency , run this command2) For 'git' is not recognized error, either you don't have git installed or the PATH is not added in the environment variables.Install git for windows. 

Get environment value in controller

nielsv

[Get environment value in controller](https://stackoverflow.com/questions/34263107/get-environment-value-in-controller)

In my .env file I have the following:Now I would like to use them in my controller. I've tried this but with no result:The $hostname variable is equal to null. How can I use these config variables in my controller?

2015-12-14 09:08:27Z

In my .env file I have the following:Now I would like to use them in my controller. I've tried this but with no result:The $hostname variable is equal to null. How can I use these config variables in my controller?try it with Doesn't work in Laravel 5.3+ if you want to try to access the value from the controller like below, it returns always nullSOLUTION: Rather you need to create a file in config folder ..say values.php and then 

write the codes like belowvalues.phpThen access the value in your controller with the following codeWhere "values" is the filename followed by the key "myvalue"

Hope it helpsI thought I'd add an answer, to simplify what has been said in the past. Only config files can access env variables - and then pass them on.Step 1.) Add your variable to your .env file, ie.Step 2.) Create a new file inside of the config folder, any name, ie.Step 3.) Inside of this new file, I add an array being returned, containing that env variable.Step 4.) Because I named it "example" my configuration 'namespace' is now example. So now, in my controller I can access this variable with:Tip - if you add use Config; at the top of your controller, you don't need the backslash (which designates the root namespace). Ie.--- IMPORTANT --- Remember to enter into the console php artisan config:cache once you have created your example.php file. Config files and variables are cached, so if you make changes you need to flush that cache - the same applies to the .env file being changed / added to.All of the variables listed in  .env file will be loaded into the $_ENV PHP super-global when your application receives a request.

    Checkout laravel configuration pageInControllerIn blade.viewin Laravel Controlllerin Laravel Blade filesExample : Accessing Laravel .env variables in bladeGet environment value in controllerYou can use with this format, (Tested on Laravel 5.5) in my case i used for get the data of database connections and use on Controller:The second parameter can be null, or set any default in case of DB_USERNAMEchild is null.you .env file can be the same:It's a better idea to put your config variables in a config file.In your case, I would suggest putting your variables in config/mail.php like 'imap_hostname' => env('IMAP_HOSTNAME_TEST', 'imap.gmail.com')and refer to them byIt first tries to get config variable value in the .env file and if it couldn't find the variable value in the .env file it will get variable value from config/mail.phpyou can not access the env variable like this. inside .env file you write next inside config folder there is a mail.php you may use this file to code. As you are working with mail functionality. You might use another file as well. you can call the variable from a controller using 'config( 

Whatever file you are using inside config folder. you need to use that file name (without extension) + '.' + 'variable name' + ')' . Current case you can call the variable as follows.    since you declare the variable inside mail.php and variable name is imap_hostname_test. you need to call like this. If you declare this variable inside app.php then you should call May be not related, but it might help someone.... in Laravel just dd(config('app.env'));

and you'll see 'local' or 'production'

Blade: escaping text and allowing new lines

lesssugar

[Blade: escaping text and allowing new lines](https://stackoverflow.com/questions/28027236/blade-escaping-text-and-allowing-new-lines)

I have a user-input text displayed on one of the pages. I want to allow new lines, though. How do I display the text, so it is escaped AND allows new lines?I used nl2br() and Blade's tripple brackets {{{$text}}}, however, obviously, the tripple brackets escape <br/> tags as well.Is there a way to combine escaping and HTML's new lines using Blade?Thanks.

2015-01-19 14:47:13Z

I have a user-input text displayed on one of the pages. I want to allow new lines, though. How do I display the text, so it is escaped AND allows new lines?I used nl2br() and Blade's tripple brackets {{{$text}}}, however, obviously, the tripple brackets escape <br/> tags as well.Is there a way to combine escaping and HTML's new lines using Blade?Thanks.You can do the escaping first, using e() and then apply nl2br():e() is the function Blade uses when compiling triple bracketsYou can use thisin simple approach  you can use it in blade File

Laravel $q->where() between dates

Jono20201

[Laravel $q->where() between dates](https://stackoverflow.com/questions/24824624/laravel-q-where-between-dates)

I am trying to get my cron to only get Projects that are due to recur/renew in the next 7 days to send out reminder emails. I've just found out my logic doesn't quite work.I currently have the query:However, I realized what I need to do is something like:Psudo SQL:How would I do this in Laravel 4, and using the DATETIME datatype, I've only done this sort of thing using timestamps. Update:Managed to solve this after using the following code, Stackoverflow also helps when you can pull bits of code and look at them out of context.Updated Question: Is there better way to do this in Laravel/Eloquent?Update 2:The first resolution ended up not been right after further testing, I have now resolved and tested the following solution:

2014-07-18 12:05:51Z

I am trying to get my cron to only get Projects that are due to recur/renew in the next 7 days to send out reminder emails. I've just found out my logic doesn't quite work.I currently have the query:However, I realized what I need to do is something like:Psudo SQL:How would I do this in Laravel 4, and using the DATETIME datatype, I've only done this sort of thing using timestamps. Update:Managed to solve this after using the following code, Stackoverflow also helps when you can pull bits of code and look at them out of context.Updated Question: Is there better way to do this in Laravel/Eloquent?Update 2:The first resolution ended up not been right after further testing, I have now resolved and tested the following solution:You can chain your wheres directly, without function(q). There's also a nice date handling package in laravel, called Carbon. So you could do something like:Just make sure you require Carbon in composer and you're using Carbon namespace (use Carbon\Carbon;) and it should work.EDIT:

As Joel said, you could do:Didn't wan to mess with carbon. So here's my solution@Tom : Instead of using 'now' or 'addWeek' if we provide date in following format, it does not give correct recordsit gives records having date form 2015-10-16 to less than 2015-10-23.

If value of recur_at is 2015-10-23 00:00:00 then only it shows that record 

else if it is 2015-10-23 12:00:45 then it is not shown.Edited: Kindly note that whereBetween('date',$start_date,$end_date) is inclusive of the first date. 

How to get All input of POST in Laravel

Abrar Jahin

[How to get All input of POST in Laravel](https://stackoverflow.com/questions/32718870/how-to-get-all-input-of-post-in-laravel)

I am using Laravel 5 and trying to get all input of POST variable in controller like this-So, I am getting this errors-What I am doing wrong?

2015-09-22 13:56:51Z

I am using Laravel 5 and trying to get all input of POST variable in controller like this-So, I am getting this errors-What I am doing wrong?Try this :There seems to be a major mistake in almost all the current answers in that they show BOTH GET and POST data. Not ONLY POST data. The issue with your code as the accepted answer mentioned is that you did not import the facade. This can imported by adding the following at the top:You can also use the global request method like so (mentioned by @Canaan Etai), with no import required:However, a better approach to importing Request in a controller method is by dependency injection as mentioned in @shuvrow answer:More information about DI can be found here:In either case, you should use:For those who came here looking for "how to get All input of POST" onlyclass Illuminate\Http\Request extends from Symfony\Component\HttpFoundation\Request which has two class variables that store request parameters.public $query - for GET parameterspublic $request - for POST parametersUsage: To get a post data onlySource hereEDITFor Laravel >= 5.5, you can simply call $request->post() or $request->post('my_param') which internally calls $request->request->all() or $request->request->get('my_param') respectively.You should use the facade rather than Illuminate\Http\Request. Import it at the top:And make sure it doesn't conflict with the other class.Edit: This answer was written a few years ago. I now favour the approach suggested by shuvrow below.You can get all post data into this function :-and if you want specific filed then use it :-It should be at least this:You can use it withoutimport Illuminate\Http\Request   OR use Illuminate\Support\Facades\Request OR other.its better to use the Dependency than to attache it to the class.or if you prefer using input variable use you can now use the global request method provided by laravelfor example to get the first_name of a form input.

Setting Bootstrap navbar active class in Laravel 5

Ikong

[Setting Bootstrap navbar active class in Laravel 5](https://stackoverflow.com/questions/29837555/setting-bootstrap-navbar-active-class-in-laravel-5)

I've been wondering around looking for solutions, but can't really understand especially when creating helpers. I'm new in Laravel and I want a simple or if not a detailed instruction on how to set the active class for my bootstrap navbar.Here's what I've done so far, but can't get it done:EDITSetting class="active" will make all nav-pills active. The intended effect is that only the li of the current page have the active class.EDITFor those who are visiting this post. I have managed to get a solution, but I'm not sure if it is neat. Well it's working and fine for me.

2015-04-24 02:12:24Z

I've been wondering around looking for solutions, but can't really understand especially when creating helpers. I'm new in Laravel and I want a simple or if not a detailed instruction on how to set the active class for my bootstrap navbar.Here's what I've done so far, but can't get it done:EDITSetting class="active" will make all nav-pills active. The intended effect is that only the li of the current page have the active class.EDITFor those who are visiting this post. I have managed to get a solution, but I'm not sure if it is neat. Well it's working and fine for me.Your code is working fine, but you have to use it for every link that can be active. It is better to return only class name, not class="..." so you can add other classes.Be careful when using * at the end (about*). If you use /* for home page then it will always be marked as active (because every other page starts with /).You can also move {{ Request::is('/') ? 'active' : '' }} to helper function/method.If you are working with named routes. You can use this approach in your views:orThe Illuminate\Routing\Router#is(...) is an alias of the Illuminate\Routing\Router#currentRouteNamed(...).Throw this in your helper.phpUse it like soYou can pass a single string to a route or multiple and wildcards.See more detail on Laravel TrickRequest::path() returns the request uri, for example: http://localhost/programs , will return programs, so you can do this:The solution given by @Daniel Antos is best answer, as I have found. Mr. Danial Antos also warned about  using * at the end (about*). Because while using /* for home page then it is always marked as active (because every other page starts with /). So, I have used as follows and it worked fine for me:Set a section on your blade file (let home.blade.php) likeAnd set a section on your another blade file (let about.blade.php) likeand yield this section on app.blade.php (Suppose you are extending from app.blade.php)I think this would be simple, and it works for me.I found the solution:More details : https://github.com/DevMarketer/LaravelEasyNavuse

Request::is('[level]') ? 'active' : '' 

In case of multilevel, use:Request::is('[level]', '[level]/*') ? 'active' : ''This is simple: to get your links to be active when using bootstrap, all you need is an if statement inside the class link, for instance: i have my current url as http://example.com/homeand you are good to go.         

How to get Current Timestamp from Carbon in Laravel 5

Abrar Jahin

[How to get Current Timestamp from Carbon in Laravel 5](https://stackoverflow.com/questions/32719972/how-to-get-current-timestamp-from-carbon-in-laravel-5)

I want to get current timestamp in laravel 5 and I have done this-I am getting eror- 'Carbon not found'-What can I do?Can anyone help, please?

2015-09-22 14:44:12Z

I want to get current timestamp in laravel 5 and I have done this-I am getting eror- 'Carbon not found'-What can I do?Can anyone help, please?You can try this if you want date time string:If you want timestamp, you can try:See the official Carbon documentation here.For Laravel 5.5 or above just use the built in helperIf you want a unix timestamp, you can also try this:You need to add another \ before your carbon class to start in the root namespace.Also, make sure Carbon is loaded in your composer.json.Laravel 5.2 <= 5.5In addition, this is how to change datetime format for given date & time, in blade:Laravel 5.6 <It may be a little late, but you could use the helper function time() to get the current timestamp. I tried this function and it did the job, no need for classes :). You can find this in the official documentation at https://laravel.com/docs/5.0/templatesRegards.With a \ before a Class declaration you are calling the root namespace:otherwise it looks for it at the current namespace declared at the beginning of the class. 

other solution is to use it:you can even assign it an alias:hope it helps.

Laravel 5.1 - Checking a Database Connection

Enijar

[Laravel 5.1 - Checking a Database Connection](https://stackoverflow.com/questions/33432752/laravel-5-1-checking-a-database-connection)

I am trying to check if a database is connected in Laravel.I've looked around the documentation and can't find anything. The closest thing I've found is this, but this doesn't solve my problem.I have three instances of MySQL that are set up on different machines. Below is a simplified version of what I am trying to achieve.To be clear, is there a way to check that a database is connected in Laravel 5.1?

2015-10-30 09:35:00Z

I am trying to check if a database is connected in Laravel.I've looked around the documentation and can't find anything. The closest thing I've found is this, but this doesn't solve my problem.I have three instances of MySQL that are set up on different machines. Below is a simplified version of what I am trying to achieve.To be clear, is there a way to check that a database is connected in Laravel 5.1?Try just getting the underlying PDO instance.  If that fails, then Laravel was unable to connect to the database!You can use alexw's solution with the Artisan. Run following commands in the command line.If connection is OK, you should see near the end of the response. You can use this, in a controller method or in an inline function of a route:You can use this query for checking database connection in laravel:For more information you can checkout this page https://laravel.com/docs/5.0/database.When Laravel tries to connect to database, if the connection fails or if it finds any errors it will return a PDOException error. We can catch this error and redirect the actionAdd the following code in the app/filtes.php file.Hope this is helpful.

Unable to Get Eloquent to Automatically Create Joins

Graham Kennedy

[Unable to Get Eloquent to Automatically Create Joins](https://stackoverflow.com/questions/11099570/unable-to-get-eloquent-to-automatically-create-joins)

Apologies in advance if the answer to my question is obvious. I have done my due diligence in researching this topic before I posted it here.Most of my framework experience comes from using CodeIgniter, so I've never had hands-on experience using ORM. (CI does have some off-the-shelf ORM solutions, but I've never used them.)I would like to use built-in ORM functionality in Laravel's Eloquent ORM to automatically join the tournaments and countries tables together when running a query, and return the data set that includes tournament data as well as its associated country data.That is, I want Eloquent to recognize the foreign key relationship automatically so that I can just run a query (e.g. Tournament:: with('Country')->all()) that will return the entire set of tournament and country data.Please stop me right now if I'm using Eloquent in a way that it was never intended to be used! My confusion may be more about me trying to mash together an untenable solution rather than syntax or coding error.I expect to receive an array of Tournament objects (in PHP), where a single Tournament object would look like:I ran all of these attempts in a dummy controller method and output the result as a formatted string to the profiler.PHP code in the dummy controller:Generates the following query:Attempt #1 returns:An array containing Tournament objects that only include the columns in the tournaments table.PHP code in the dummy controller:Generates the following error:I've tried various combinations of naming conventions (e.g. columns, tables, etc.) to no avail. I've also tried creating the query in Fluent, which worked fine, but required me to specify the joins which is what I'm trying to avoid.

2012-06-19 10:59:36Z

Apologies in advance if the answer to my question is obvious. I have done my due diligence in researching this topic before I posted it here.Most of my framework experience comes from using CodeIgniter, so I've never had hands-on experience using ORM. (CI does have some off-the-shelf ORM solutions, but I've never used them.)I would like to use built-in ORM functionality in Laravel's Eloquent ORM to automatically join the tournaments and countries tables together when running a query, and return the data set that includes tournament data as well as its associated country data.That is, I want Eloquent to recognize the foreign key relationship automatically so that I can just run a query (e.g. Tournament:: with('Country')->all()) that will return the entire set of tournament and country data.Please stop me right now if I'm using Eloquent in a way that it was never intended to be used! My confusion may be more about me trying to mash together an untenable solution rather than syntax or coding error.I expect to receive an array of Tournament objects (in PHP), where a single Tournament object would look like:I ran all of these attempts in a dummy controller method and output the result as a formatted string to the profiler.PHP code in the dummy controller:Generates the following query:Attempt #1 returns:An array containing Tournament objects that only include the columns in the tournaments table.PHP code in the dummy controller:Generates the following error:I've tried various combinations of naming conventions (e.g. columns, tables, etc.) to no avail. I've also tried creating the query in Fluent, which worked fine, but required me to specify the joins which is what I'm trying to avoid.Clearly with('Country') or with('country') doesn't do any different due to the fact that he managed to get following error:What wrong is how the relationship is defined: A tournament must have a country would be a tournament need to belong to a country, and not has one country. So to solve this change the relationship to According to the Eloquent docs:So with that in mind something like:Should be replicable in Eloquent. I personally use the query builder version just now which you may want to use but I will try and test with Eloquent when I get the chance and update this.UPDATE:Yep, using Eloquent's query builder methods you can have:This will return a Tournament model that includes the fields of both tables.HTHYour 'with' clause asks for 'Country', but your code declares it as 'country'.So, should:Be:Because in your Tournaments Model, you've defined this as:Does making this change solve it?You have to make sure your relationship is declared in your Tournament model:Also, you will have to declare the opposite in your Country model:At this point, you can access the tournament object associated with the country object like so:Let me know if this display each corresponding country to the tournament.

Laravel RESTful API versioning design

Sam Wong

[Laravel RESTful API versioning design](https://stackoverflow.com/questions/30239823/laravel-restful-api-versioning-design)

I am new to Laravel (4 and 5) and recently I am working on a RESTful API.

In order to allow  multiple version of the API, I am using URL to determine the version. I read follow this post and it seem most people following this approach:

How to organize different versioned REST API controllers in Laravel 4?Folders structures:And in UserController.php files I set the namespace accordingly:orand in routes:URL will be simple http://..../api/v1 for version 1 and http://..../api/v2 for version. This is straight forward.My questions is:

What if I am building minor upgrade of api, say v1.1 , how do I organize my folder structure? 

My thought was  this and it should be still fine as dot is valid name of folders? Also, how should I write the namespace? This is no namespace like this Is there naming convention I can refer to for using "dot" ?Note: I do not want to call it as version v2 because this is not a major upgrade.

2015-05-14 14:23:09Z

I am new to Laravel (4 and 5) and recently I am working on a RESTful API.

In order to allow  multiple version of the API, I am using URL to determine the version. I read follow this post and it seem most people following this approach:

How to organize different versioned REST API controllers in Laravel 4?Folders structures:And in UserController.php files I set the namespace accordingly:orand in routes:URL will be simple http://..../api/v1 for version 1 and http://..../api/v2 for version. This is straight forward.My questions is:

What if I am building minor upgrade of api, say v1.1 , how do I organize my folder structure? 

My thought was  this and it should be still fine as dot is valid name of folders? Also, how should I write the namespace? This is no namespace like this Is there naming convention I can refer to for using "dot" ?Note: I do not want to call it as version v2 because this is not a major upgrade.IMO, minor upgrades should not publish breaking changes to an API. So my suggestion is to stick to integer versioned APIs. Enhancements are no problems, but existing endpoints should behave as usual. This way your API-Versions would be in sync with the route-prefixes and the namespaces as well as the tests.EXAMPLEBe aware that you can of course keep track of the minor versions internally (e.g in SCM), but there should be no need for developers to change all of their API-Calls just to benefit from that little bugfix you published. Anyways, it is nice of course if you notify your clients of the newer minor versions and the bugfixes or enhancements they offer (blog, newsletter, ..)Let me add, that i am not aware of any RESTful APIs with minor API-URL-prefixes, so i guess this is quite a common practice.You can not use dots, use underscores instead.But...A well-designed api must have BC between minor versions, so you do not need to create new version for minor update, instead you need to write compatible code.

php artisan migrate throwing [PDO Exception] Could not find driver - Using Laravel

Vamshi Vangapally

[php artisan migrate throwing [PDO Exception] Could not find driver - Using Laravel](https://stackoverflow.com/questions/22463614/php-artisan-migrate-throwing-pdo-exception-could-not-find-driver-using-larav)

I have a bad experience while installing laravel. However, I was able to do so and move to the next level. I used generators and created my migrations. 

But when I type the last command It's throwing a PDOException - could not find driver.That's my configuration in config/database.php.I tried searching on stackoverflow and laravel forums and people suggest that it's PDO problem and not artisan's or php's - I followed those suggestions like adding in php.ini No positive result. It always says [PDOException]could not find driver.Can someone please help resolving this.Environment that I am using: Mac, laravel 4, MAMP PRO with php 5.4.4

2014-03-17 19:30:09Z

I have a bad experience while installing laravel. However, I was able to do so and move to the next level. I used generators and created my migrations. 

But when I type the last command It's throwing a PDOException - could not find driver.That's my configuration in config/database.php.I tried searching on stackoverflow and laravel forums and people suggest that it's PDO problem and not artisan's or php's - I followed those suggestions like adding in php.ini No positive result. It always says [PDOException]could not find driver.Can someone please help resolving this.Environment that I am using: Mac, laravel 4, MAMP PRO with php 5.4.4You can useororThis worked for me.This worked for me:This installed sqlite for php5, then I ran the php artisan migrate command again and worked perfectly.You need to specifically enable the pdo_mysql plugin. Assuming you're using a standard PHP installation, then generally you would simply need to add this to your PHP.ini file:You need to ensure that this file exists in the extension directory though.Adding pdo_pgsql.so doesn't help because that is for PostgreSQL.Additionally, you should ensure that you restart the web-server after you make the changes to the PHP ini file, as the changes may not be reflected otherwise.Ran into the same issue here, and turns out this is because PHP at the command line uses a different php.ini file from the browser version, which is why it looks like it's loading the extension correctly when you look at phpinfo() in a browser.As per this answer, you just need to run:At the command line, which will tell you the path to the currently loaded php.ini (probably actually a php-cli.ini file located in the same place as your regular php.ini file).Once you've found that, modify it with the pdo extensions you want (in this case for MySQL):Or, for any other users that are on Windows using some kind of WAMP server, it probably looks like this instead:I think you missed the mysql driver for php5.

Execute below command:Please check your Laravel .env file also. Make sure DB_CONNECTION=mysql, otherwise it won't work with MySQL. It tried to load something else.You are missing a PDO driver.First install the driver For ubuntu: For mysql database.You also can search for other database systems.You also can search for the driver:Had the same issue and just figured, website is running under MAMP's php, but when you call in command, it runs mac's(if no bash path modified). you will have issue when mac doesn't have those extensions.run php -i to find out loaded extensions, and install those one you missed. or run '/Applications/MAMP/bin/php/php5.3.6/bin/php artisan {your command}' to use MAMP'sI was also getting the same error --> "[PDOException]

  could not find driver "After that I used many commands but not didn't get any helpFinally I used the following command, which solved my problem.sudo apt-get install php5-sqliteLaravel Testing with sqlite needs php pdo sqlite driversFor Ubuntu 14.04In ubuntu 16.04 there is no php5-sqliteYou must be installing the latest version of php mysql

in my case I am install php7.1-mysqlTry thisI am using the latest version of laravelI got this error for the PostgreSQL and the solution is:You only need to use your installed PHP version, mine is 7.1.

This has fixed the issue for PostgreSQL.I'm unsing ubuntu 14.04Below command solved this problem for me.In my case, after updating my php version from 5.5.9 to 7.0.8 i received this error including two other errors.errors: Solutions:I installed this packages and my problems are gone.I had this problem on debian. The issue was, I was using the dotdeb repository for more recent PHP packages. For some reason, it updated the php cli to 7.0, while the web php binary remained php 5.6. I used this answer to link the php command line binary to the 5.6 version, like so:This worked with me:(for pgsql: use 'pgsql' instead of 'mysql')Step 1)Step 2)Step 3)Step 4)

Then restart your server, and generate key again and migrate it, Its Donefirst check your php version  like this : after you get  version number for example i get 7.1 then install like thatand need to restart apache2For future searchers.

On FreeBSD try the next if you see the empty line in return do the following:and the do the installthen simply restart your apache and you are donee.g.  sudo /usr/local/etc/rc.d/apache22 restart

Install it via this command sudo apt-get install php5-gdthis worked for me.In my case I wasn't aware that the PHP run by Apache was different from the one run by CLI. That might be the case if during configuration in httpd.conf you specified a PHP module, not being the default one your CLI uses.I found the proper solution for this error! Either you don't have any database installed or your default database in this file

config/database.php

is set to some other database like thischange the default to which one you have installed or install that database which is made to be default! I had installed mysql and php artisan migrate worked after i changed that line to this:I was also getting the same error --> "[PDOException]

could not find driver "I realized that the php was pointing to /usr/bin/php instead of the lampp /opt/lampp/bin/php so i simply created

and aliasalias php="/opt/lampp/bin/php" also had to make update to the .env file to ensure the database access credentials were updated.And guess what, it Worked!If you are using Laravel 5.x, and the error is from trying to modify the attributes of a column, it is possible the error comes from a missing pre-requisite.Try this:Then try running your migrations.From here:

https://laravel.com/docs/master/migrations#modifying-columnsjust replaced: ;extension=pdo_mysql to extension=pdo_mysql in php.ini file.If you are using arch based system like in manjaro just use Restart your httpdfor those users of windows 10 and WAMP that found this post, i have a solution.Please go visit this link. It worked for me and it was difficult to come to the solution but i hope it might be of help for others in the future.Assuming you did the normal installation with virtual box, vagrant etc..

This can happen to new people.

PHP can be installed on your PC but all the modules PHP for your laravel project is on your VM

So to access your VM, go to your homestead folder and type:

vagrant sshthen to go your project path and execute the php artisan migrate.

Laravel Eloquent get results grouped by days

jct

[Laravel Eloquent get results grouped by days](https://stackoverflow.com/questions/20603075/laravel-eloquent-get-results-grouped-by-days)

I currently have a table of page_views that records one row for each time a visitor accesses a page, recording the user's ip/id and the id of the page itself. I should add that the created_at column is of type: timestamp, so it includes the hours/minutes/seconds. When I try groupBy queries, it does not group same days together because of the seconds difference.I'd like to get results based on views/day, so I can get something like:I'm thinking I'll need to dig into DB::raw() queries to achieve this, but any insight would help greatly, thanksEdit: Added clarification of created_at format.

2013-12-16 03:40:46Z

I currently have a table of page_views that records one row for each time a visitor accesses a page, recording the user's ip/id and the id of the page itself. I should add that the created_at column is of type: timestamp, so it includes the hours/minutes/seconds. When I try groupBy queries, it does not group same days together because of the seconds difference.I'd like to get results based on views/day, so I can get something like:I'm thinking I'll need to dig into DB::raw() queries to achieve this, but any insight would help greatly, thanksEdit: Added clarification of created_at format.I believe I have found a solution to this, the key is the DATE() function in mysql, which converts a DateTime into just Date:However, this is not really an Laravel Eloquent solution, since this is a raw query.The following is what I came up with in Eloquent-ish syntax. The first where clause uses carbon dates to compare.You can use Carbon (integrated in Laravel) Here is how I do it. A short example, but made my query much more manageableYou can filter the results based on formatted date using mysql (See here for Mysql/Mariadb help) and use something like this in laravel-5.4:I had same problem, I'm currently using Laravel 5.3.I use DATE_FORMAT()

Hopefully this will help you.Like most database problems, they should be solved by using the database.Storing the data you want to group by and using indexes you can achieve an efficient and clear method to solve this problem.To group data according to DATE instead of DATETIME, you can use CAST function.Warning: untested code.Using Laravel 4.2 without CarbonHere's how I grab the recent ten days and count each row with same day created_at timestamp.Hope this helpsin mysql you can add MONTH keyword having the timestamp as a parameter

in laravel you can do it like thisI built a laravel package for making statistics : https://github.com/Ifnot/statisticsIt is based on eloquent, carbon and indicators so it is really easy to use. It may be usefull for extracting date grouped indicators.```I know this is an OLD Question and there are multiple answers. How ever according to the docs and my experience on laravel below is the good "Eloquent way" of handling thingsIn your model, add a mutator/Getter like thisAnother way is to cast the columns

in your model, populate the $cast arrayThe catch here is that you won't be able to use the Carbon on this model again since Eloquent will always cast the column into stringHope it helps :)You could also solve this problem in following way:

Laravel 5.4 Disable Register Route

Dev.Wol

[Laravel 5.4 Disable Register Route](https://stackoverflow.com/questions/42695917/laravel-5-4-disable-register-route)

I am trying to disable the register route on my application which is running in Laravel 5.4.In my routes file, I have only theIs there any way to disable the register routes?

2017-03-09 12:52:38Z

I am trying to disable the register route on my application which is running in Laravel 5.4.In my routes file, I have only theIs there any way to disable the register routes?The code:its a shorcut for this collection of routes:So you can substitute the first with the list of routes and comment out any route you don't want in your application.Edit for laravel version => 5.7 In newer versions you can add a parameter to the Auth::routes() function call to disable the register routes:The email verification routes were added:BTW you can also disable Password Reset and Email Verification routes:Since Laravel 5.7, a new $options parameter is introduced to the Auth::routes() method; through which you can pass an array to control the generation of the required routes for user-authentication (valid entries can be chosen from the 'register', 'reset', or 'verify' string literals).You could try this. Add those routes just below the Auth::routes() to override the default registration routes. Any request to the /register route will redirect to the baseUrl. This is deceptively easy! You just need to override two methods in your app/Http/Controllers/Auth/RegisterController.php Class. See below which will prevent the form from being displayed and most importantly block direct POST requests to your application for registrations..In web.php, Replace Auth::routes();WithAuth::routes(['register' => false]);So that you can remove register route from default auth route list. i tried in 5.7 and it worked fine.Though the above solutions work but, I think changing the middleware to 'auth' in the App\Http\Controllers\Auth\RegisterController will be one of the easiest solutions. This will redirect all visitors to login page if they want to access any of the registration routes. Like this:I suppose you want to restrict access to some pages for guests and only the admin can register a guest. You can achieve it by adding your own middleware on kernel.php file like below:After creating the middleware you have to use it so you can go on web.php file where your routes are and add it to the route you want to restrict like below:This way registration is restricted to guests but the admin can still access the page if he ever want to register some other admin!Don't forget to replace the Auth::routes(); with the detailed list as below:I guess you can do it like this, in your web.php file:On my Laravel 5.6 project this method didn't work:So I had to use the following method:Add this two method to app\Http\Controllers\Auth\RegisterController.phpJust overwrite your auth showRegistrationForm() method ( place this code inside your Auth/RegisterController )public function showRegistrationForm()

    {

        return redirect()->route('login');

    }I'm just redirecting my register route to login route. Here you don't need to append or remove any other codeYes, there is a wayRemote that route from your web.php in your routes directory.That route is what controls registration.Change to routes :

How to solve a timeout error in Laravel 5

Geordie Gadgie

[How to solve a timeout error in Laravel 5](https://stackoverflow.com/questions/30270316/how-to-solve-a-timeout-error-in-laravel-5)

I have the following set up:In routes I have:Route::get('articles', 'ArticlesController@index');The index method in the controller is simply:and in the view:I attempted to replace the: withsuch that I can actually show the articles latest first.

I got the error:and the call stack is:... etcI have restored the controller method to what it was, but the error persists.Can you please tell me how I can solve this problem?

2015-05-15 23:49:11Z

I have the following set up:In routes I have:Route::get('articles', 'ArticlesController@index');The index method in the controller is simply:and in the view:I attempted to replace the: withsuch that I can actually show the articles latest first.

I got the error:and the call stack is:... etcI have restored the controller method to what it was, but the error persists.Can you please tell me how I can solve this problem?The Maximum execution time of 30 seconds exceeded error is not related to Laravel but rather your PHP configuration.Here is how you can fix it. The setting you will need to change is max_execution_time. You can change the max_execution_time to 300 seconds like max_execution_time = 300You can find the path of your PHP configuration file in the output of the phpinfo function in the Loaded Configuration File section.it's a pure PHP setting.

The alternative is to increase the execution time limit only for specific php scripts, by inserting on top of that php file, the following:In Laravel:Add set_time_limit(0) line on top of query.It helps you in different large queries but you should need to improve query optimise. Sometimes you just need to optimize your code or query, Setting more max_execution_time is not a solution.A code should not be run more than 30s.set time limit in __construct method or you can set in your index controller also where you want to have large time limit.trywhere $time is in seconds, set it to 0 for no time. make sure to make it 60 back after your function finishIf using PHP7, I would suggest you changing the default value in the public/.htaccess Execution  is not related to laravel go to the php.ini file 

In php.ini file  set max_execution_time=360 (time may be variable depends on need)

if you want to increase execution of a specific page then write ini_set('max_execution_time',360) at top of page otherwise in htaccess 

php_value max_execution_time 360

Add above query ini_set("memory_limit", "10056M");If you are hosting your Laravel app on Heroku, you can create custom_php.ini in the root of your project and simply add max_execution_time = 60

    

        Options -MultiViews -Indexes

    You need to just press CTRL + F5. It will work after that. 

Laravel default orderBy

M K

[Laravel default orderBy](https://stackoverflow.com/questions/20701216/laravel-default-orderby)

Is there a clean way to enable certain models to be ordered by a property by default?

It could work by extending the laravel's QueryBuilder, but to do so, you'll have to rewire some of it's core features - bad practice.reasonThe main point of doing this is - one of my models get's heavily reused by many others and right now you have to resort the order over and over again. Even when using a closure for this - you still have to call it. It would be much better to be able to apply a default sorting, so everyone who uses this model, and does not provide custom sorting options, will receive records sorted by the default option. Using a repository is not an option here, because it get's eager loaded.SOLUTIONExtending the base model:In your model:In your controller:

2013-12-20 10:13:24Z

Is there a clean way to enable certain models to be ordered by a property by default?

It could work by extending the laravel's QueryBuilder, but to do so, you'll have to rewire some of it's core features - bad practice.reasonThe main point of doing this is - one of my models get's heavily reused by many others and right now you have to resort the order over and over again. Even when using a closure for this - you still have to call it. It would be much better to be able to apply a default sorting, so everyone who uses this model, and does not provide custom sorting options, will receive records sorted by the default option. Using a repository is not an option here, because it get's eager loaded.SOLUTIONExtending the base model:In your model:In your controller:Yes you would need to extend Eloquent to always do this as standard for any query. What's wrong with adding an order by statement to the query when you need it ordered? That is the cleanest way, ie, you dont need to 'unhack' Eloquent to get results by natural order.Other than that the closest thing to what you want would be to create query scopes in your models.You can then call ordered as a method instead of get to retrieve your ordered results.If you wanted this across different models you could create a base class and just extend it to the models you want to have access to this scoped method.Nowadays we can solve this problem also with global scopes, introduced in Laravel 4.2 (correct me if I'm wrong). We can define a scope class like this:Then, in your model, you can add the scope in the boot() method:Now the model is ordered by default. Note that if you define the order also manually in the query: MyModel::orderBy('some_column'), then it will only add it as a secondary ordering (used when values of the first ordering are the same), and it will not override. To make it possible to use another ordering manually, I added an (optional) macro (see above), and then you can do: MyModel::unordered()->orderBy('some_column')->get().Laravel 5.2 introduced a much cleaner way to work with global scopes. Now, the only thing we have to write is the following:Then, in your model, you can add the scope in the boot() method:To remove the global scope, simply use:Solution without extra scope classIf you don't like to have a whole class for the scope, you can (since Laravel 5.2) also define the global scope inline, in your model's boot() method:You can remove this global scope using this:Another way of doing this could be by overriding the newQuery method in your model class. This only works if you never, ever want results to be ordered by another field (since adding another ->orderBy() later won't remove this default one). So this is probably not what you'd normally want to do, but if you have a requirement to always sort a certain way, then this will work:In Laravel 5.7, you can now simply use addGlobalScope inside the model's boot function:In the above example, I order the model by created_at desc to get the most recent records first. You can change that to fit your needs.you should use eloquent global scope that can apply to all queries(also you can set parameter for it).And for relations you can use this useful trick:this will add order by to all posts when we get them from a category.

If you add an order by to your query, this default order by will cancel!An slightly improved answer given by Joshua Jabbouryou can use the code he offered in a Trait, and then add that trait to the models where you want them to be ordered.then in whichever model you want the data to be ordered you can use use :now everytime you request that model, data will be ordered, that's somehow more organized, but my answers is Jabbour's answer.A note from my experience, never to use orderBy and GroupBy such term on global scope. Otherwise you will easily face database errors while fetching related models in other places.Error may be something like:Thanks.

How add Custom Validation Rules when using Form Request Validation in Laravel 5

gsk

[How add Custom Validation Rules when using Form Request Validation in Laravel 5](https://stackoverflow.com/questions/28793716/how-add-custom-validation-rules-when-using-form-request-validation-in-laravel-5)

I am using form request validation method for validating request in laravel 5.I would like to add my own validation rule with form request validation method.My request class is given below.I want to add custom validation numeric_array with field items.My cusotom function is given belowHow can use this validation method with about form request validation in laravel5? 

2015-03-01 12:48:46Z

I am using form request validation method for validating request in laravel 5.I would like to add my own validation rule with form request validation method.My request class is given below.I want to add custom validation numeric_array with field items.My cusotom function is given belowHow can use this validation method with about form request validation in laravel5? Using Validator::extend() like you do is actually perfectly fine you just need to put that in a Service Provider like this:Then register the provider by adding it to the list in config/app.php:You now can use the numericarray validation rule everywhere you wantWhile the above answer is correct, in a lot of cases you might want to create a custom validation only for a certain form request. You can leverage laravel FormRequest and use dependency injection to extend the validation factory. I think this solution is much simpler than creating a service provider.Here is how it can be done. The accepted answer works for global validation rules, but many times you will be validating certain conditions that are very specific to a form. Here's what I recommend in those circumstances (that seems to be somewhat intended from Laravel source code at line 75 of FormRequest.php):Add a validator method to the parent Request your requests will extend:Now all your specific requests will look like this: You need to override getValidatorInstance method in your Request class, for example this way:Custom Rule ObjectOne way to do it is by using Custom Rule Object, this way you can define as many rule as you want without need to make changes in Providers and in controller/service to set new rules.In NumericArray.phpThen in Form request haveYou don't need to extend the validator to validate array items, you can validate each item of a array with "*" as you can see in

Array ValidationAlternatively to Adrian Gunawan's solution this now also can be approached like:For me works the solution that give us lukasgeiter, but with a difference that we create a class with our custom validations ,like this, for laravel 5.2.* The next example is for add a validation to a range of date in where the second date has to be equals or more big that the first oneIn app/Providers create ValidatorExtended.phpOk. now lets create the Service Provider. Create ValidationExtensionServiceProvider.php inside app/Providers, and we codeNow we to tell Laravel to load this Service Provider, add to providers array at the end in config/app.php andnow we can use this validation in our request in function rulesor in Validator:makeyou have to notice that the name of the method that makes the validation has the prefix validate and is in camel case style validateAfterOrEqual but when you use the rule of validation every capital letter is replaced with underscore and the letter in lowercase letter.All this I take it from https://www.sitepoint.com/data-validation-laravel-right-way-custom-validators// here explain in details. thanks to them.All answers on this page will solve you the problem, but... But the only right way by the Laravel conventions is solution from Ganesh KarkiOne example:Let’s take an example of a form to fill in Summer Olympic Games events – so year and city. First create one form.Now, let’s create a validation rule that you can enter only the year of Olympic Games. These are the conditionsLet’s run a command:php artisan make:rule OlympicYearLaravel generates a file app/Rules/OlympicYear.php. Change that file to look like this:namespace App\Rules;use Illuminate\Contracts\Validation\Rule;class OlympicYear implements Rule

{}Finally, how we use this class? In controller's store() method we have this code:If you want to create validation by Laravel conventions follow tutorial in link below. It is easy and very well explained. It helped me a lot. Link for original tutorial is here Tutorial link.

hasMany vs belongsToMany in laravel 5.x

user101289

[hasMany vs belongsToMany in laravel 5.x](https://stackoverflow.com/questions/36208460/hasmany-vs-belongstomany-in-laravel-5-x)

I'm curious why the Eloquent relationship for hasMany has a different signature than for belongsToMany. Specifically the custom join table name-- for a system where a given Comment belongs to many Roles, and a given Role would have many Comments, I want to store the relationship in a table called my_custom_join_table and have the keys set up as comment_key and role_key.But on the inverse, I can't define that custom table (at least the docs don't mention it):If I have a Role object that hasMany Comments, but I use a non-standard table name to store that relationship, why can I use this non-standard table going one way but not the other?

2016-03-24 19:25:47Z

I'm curious why the Eloquent relationship for hasMany has a different signature than for belongsToMany. Specifically the custom join table name-- for a system where a given Comment belongs to many Roles, and a given Role would have many Comments, I want to store the relationship in a table called my_custom_join_table and have the keys set up as comment_key and role_key.But on the inverse, I can't define that custom table (at least the docs don't mention it):If I have a Role object that hasMany Comments, but I use a non-standard table name to store that relationship, why can I use this non-standard table going one way but not the other?hasMany is used in a One To Many relationship while belongsToMany refers to a Many To Many relationship. They are both distinct relationship types and each require a different database structure - thus they take different parameters.The key difference is that in a One To Many relationship, you only need the two database tables that correspond to the related models. This is because the reference to the relation is stored on the owned model's table itself. For instance, you might have a Country model and a City model. A Country has many cities. However, each City only exists in one country. Therefore, you would store that country on the City model itself (as country_id or something like that).However, a Many To Many relationship requires a third database table, called a pivot table. The pivot table stores references to both the models and you can declare it as a second parameter in the relationship declaration. For example, imagine you have your City model and you also have a Car model. You want a relationship to show the types of cars people drive in each city. Well, in one city people will drive many different types of car. However, if you look at one car type you will also know that it can be driven in many different cities. Therefore it would be impossible to store a city_id or a car_id on either model because each would have more than one. Therefore, you put those references in the pivot table.As a rule of thumb, if you use a belongsToMany relationship, it can only be paired with another belongsToMany relationship and means that you have a third pivot table. If you use a hasMany relationship, it can only be paired with a belongsTo relationship and no extra database tables are required.In your example, you just need to make the inverse relation into a belongsToMany and add your custom table again, along with the foreign and local keys (reversing the order from the other model).Try to understand with text and a figure.

Laravel - Check if @yield empty or not

user2840318

[Laravel - Check if @yield empty or not](https://stackoverflow.com/questions/20412738/laravel-check-if-yield-empty-or-not)

Is it possible to check into a blade view if @yield have content or not?I am trying to assign the page titles in the views:So I would like to check in the main layout view... something like:

2013-12-05 23:11:08Z

Is it possible to check into a blade view if @yield have content or not?I am trying to assign the page titles in the views:So I would like to check in the main layout view... something like:There is probably a prettier way to do this. But this does the trick.In Laravel 5 we now have a hasSection method we can call on a View facade.You can use View::hasSection to check if @yeild is empty or not:This conditional is checking if a section with the name of title was set in our view. Tip: I see a lot of new artisans set up their title sections like this:but you can simplify this by just passing in a default value as the second argument:  The hasSectionmethod was added April 15, 2015. For those looking on it now (2018+), you can use : See : https://laravel.com/docs/5.6/blade#control-structuresGiven from the docs:Type in your main layout e.g. "app.blade.php", "main.blade.php", or "master.blade.php"And in the specific view page (blade file) type as follows:You can simply check if the section exists:And you can even go a step further and pack this little piece of code into a Blade extension: http://laravel.com/docs/templates#extending-bladewhy not pass the title as a variable View::make('home')->with('title', 'Your Title') this will make your title available in $titleI don't think you can, but you have options, like using a view composer to always provide a $title to your views:Can you not do:layout.blade.php<title> Sitename.com @section("title") Default @show </title>And in subtemplate.blade.php:The way to check is to not use the shortcut '@' but to use the long form: Section.Building on Collin Jame's answer, if it is not obvious, I would recommend something like this:Sometimes you have an enclosing code, which you only want to have included in that section is not empty. For this problem I just found this solution:The title H2 gets only displayed it the section really contains any value. Otherwise it won't be printed...Complete simple answerI have a similar problem with the solution:The result will be the empty <div></div>Now, my suggestion, to fix this, is

Laravel nested relationships

Miguel Stevens

[Laravel nested relationships](https://stackoverflow.com/questions/25628754/laravel-nested-relationships)

I'm having trouble getting a very-nested relationship to work correctly in laravel.The wanted behaviour is as follows, I select an event by ID and i want to see which persons are subscribed to it.

Now the problem is there are some tables between the event and the person..This is the query that works!andAnd many other possibilities, I'm really stuck on this. Is it so difficult in laravel to achieve this kind of nested relationship linking?Thanks!

2014-09-02 17:08:52Z

I'm having trouble getting a very-nested relationship to work correctly in laravel.The wanted behaviour is as follows, I select an event by ID and i want to see which persons are subscribed to it.

Now the problem is there are some tables between the event and the person..This is the query that works!andAnd many other possibilities, I'm really stuck on this. Is it so difficult in laravel to achieve this kind of nested relationship linking?Thanks!If you only want to select certain fields from the persons table, use this:For city and companies specific fields , you need to distribute the with eloquent.

Eg: I created a HasManyThrough relationship for cases like this: Repository on GitHubAfter the installation, you can use it like this:You can get attributes from intermediate tables with withIntermediate():To expand on @rashmi-nalwaya 's answer. I got it working for a 5.8 project with some tweaks.My example was a bit different because I am trying to reference hasOne relations, rather than hasMany.So for reference, Domains belong to one Website, which belongs to one Server.  I only wanted to return certain columns from all of those tables.  I had to do this.Had to make sure I passed through the primary key for the table I'm on at any time (so the id in my case), and secondly, the foreign key of the related table I'm trying to get to.  So website_id from domain, and server_id from website.  Then it worked perfectly.In my code I also have a further where clause on the main domain, after all this with-ness.

Laravel 5: Handle exceptions when request wants JSON

Jonathon

[Laravel 5: Handle exceptions when request wants JSON](https://stackoverflow.com/questions/28944097/laravel-5-handle-exceptions-when-request-wants-json)

I'm doing file uploads via AJAX on Laravel 5. I've got pretty much everything working except one thing.When I try to upload a file that is too big (Bigger than upload_max_filesize and post_max_size I get a TokenMismatchException thrown.This is to be expected however, because I know that my input will be empty if these limits are being exceeded. Empty input, means no _token is received hence why the middleware responsible for verifying CSRF tokens is kicking up a fuss.My issue however is not that this exception is being thrown, it is how it is being rendered. When this exception is being caught by Laravel it's spitting out the HTML for the generic Whoops page (With a load of stack tracing since I'm in debug mode).What's the best way to handle this exception so that JSON is returned over AJAX (Or when JSON is requested) while keeping the default behaviour otherwise?Edit: This seems to happen regardless of the exception thrown. I've just tried making a request via AJAX (Datatype: JSON) to a 'page' that doesn't exist in an attempt to get a 404 and the same thing happens - HTML is returned, nothing JSON friendly.

2015-03-09 14:12:02Z

I'm doing file uploads via AJAX on Laravel 5. I've got pretty much everything working except one thing.When I try to upload a file that is too big (Bigger than upload_max_filesize and post_max_size I get a TokenMismatchException thrown.This is to be expected however, because I know that my input will be empty if these limits are being exceeded. Empty input, means no _token is received hence why the middleware responsible for verifying CSRF tokens is kicking up a fuss.My issue however is not that this exception is being thrown, it is how it is being rendered. When this exception is being caught by Laravel it's spitting out the HTML for the generic Whoops page (With a load of stack tracing since I'm in debug mode).What's the best way to handle this exception so that JSON is returned over AJAX (Or when JSON is requested) while keeping the default behaviour otherwise?Edit: This seems to happen regardless of the exception thrown. I've just tried making a request via AJAX (Datatype: JSON) to a 'page' that doesn't exist in an attempt to get a 404 and the same thing happens - HTML is returned, nothing JSON friendly.I'm going to take a shot at this one myself taking into account the answer given by @Wader and the comments from @Tyler Crompton:app/Exceptions/Handler.phpIn your application you should have app/Http/Middleware/VerifyCsrfToken.php. In that file you can handle how the middleware runs. So you could check if the request is ajax and handle that how you like.Alternativly, and probably a better solution, would be to edit the exception handler to return json. See app/exceptions/Handler.php, something like the below would be a starting placeBuilding on @Jonathon's handler render function, I would just modify the conditions to exclude ValidationException instances. Laravel 5 returns validation errors in JSON already if appropriate.The full method in App/Exceptions/Handler.php:I have altered several implementations found here to work on Laravel 5.3.

The main difference is that mine will return the correct HTTP status textsIn your render() function in app\Exceptions\Handler.php add this snippet to the top:Contents of renderExceptionAsJson:Using @Jonathon's code, here's a quick fix for Laravel/Lumen 5.3 :)Quick note on this... In Laravel 5.5 the exception is named "$exception" and not "$e" in the method. 

Laravel: validate an integer field that needs to be greater than another

Alexandre Thebaldi

[Laravel: validate an integer field that needs to be greater than another](https://stackoverflow.com/questions/32036882/laravel-validate-an-integer-field-that-needs-to-be-greater-than-another)

I have two fields that are optional only if both aren't present:Now, end_page needs to be greater than initial_page. How include this filter?

2015-08-16 15:35:50Z

I have two fields that are optional only if both aren't present:Now, end_page needs to be greater than initial_page. How include this filter?There is no built-in validation that would let you compare field values like that in Laravel, so you'll need to implement a custom validator, that will let you reuse validation where needed. Luckily, Laravel makes writing custom validator really easy.Start with defining new validator in yor AppServiceProvider:Now you can use your brand new validation rule in your $rules:You'll find more info about creating custom validators here: http://laravel.com/docs/5.1/validation#custom-validation-rules. They are easy to define and can then be used everywhere you validate your data.For Laravel 5.4 it will be:As of Laravel 5.6 gt, gte, lt and lte rules are added.I think you can try something like this,the question was asked in 2015 so most of the answers are also outdated now in 2019i want to give answer which uses features provided by laravel team which is included in it's new version,so as stated by @Sarpadoruk as of laravel 5.6 laravel added features in validation like 

gt,gte,lt and lte which means:so using gt you can check that your end_page should be greater than your initial_page and your task becomes very easy now:Why not just define $min_number = $min + 1 number and use validator min:$min_number, example:And you can then return custom error message to explain the error to user.

eloquent laravel: How to get a row count from a ->get()

JP Foster

[eloquent laravel: How to get a row count from a ->get()](https://stackoverflow.com/questions/33676576/eloquent-laravel-how-to-get-a-row-count-from-a-get)

I'm having a lot of trouble figuring out how to use this collection to count rows. I have tried adding->count() but didn't work. I have tried doing count($wordlist). I'm not really sure what to do without needing a second request as a->count() method. 

2015-11-12 16:34:57Z

I'm having a lot of trouble figuring out how to use this collection to count rows. I have tried adding->count() but didn't work. I have tried doing count($wordlist). I'm not really sure what to do without needing a second request as a->count() method. Answer has been updatedcount is a Collection method. The query builder returns an array. So in order to get the count, you would just count it like you normally would with an array:If you have a wordlist model, then you can use Eloquent to get a Collection and then use the Collection's count method. Example:There is/was a discussion on having the query builder return a collection here: https://github.com/laravel/framework/issues/10478However as of now, the query builder always returns an array.Edit: As linked above, the query builder now returns a collection (not an array). As a result, what JP Foster was trying to do initially will work:However, as indicated by Leon in the comments, if all you want is the count, then querying for it directly is much faster than fetching an entire collection and then getting the count. In other words, you can do this:Direct get a count of row Using EloquentUsing query builderIts better to access the count with the laravels count method orit's work me Step 1Add in headerStep 2use in div tag 

Skip model accessor

LHolleman

[Skip model accessor](https://stackoverflow.com/questions/17543843/skip-model-accessor)

I got a model called Run which contains this method:I need this setup for laravel administrator, since alot of runs will have the same name and the only difference is the race name. But in 1 place in the website i need to get the name only, without mutating. Is this possbile?

2013-07-09 08:49:34Z

I got a model called Run which contains this method:I need this setup for laravel administrator, since alot of runs will have the same name and the only difference is the race name. But in 1 place in the website i need to get the name only, without mutating. Is this possbile?this is the correct wayhttps://laravel.com/api/5.2/Illuminate/Database/Eloquent/Model.html#method_getOriginalEdit: Careful! As Maksym Cierzniak explained in the comments, getOriginal() doesn't just skip mutators, it also returns the "original" value of the field at the time the object was read from the database.  So if you have since modified the model's property, this won't return your modified value, it will still return the original value.  The more consistent and reliable way to get the un-mutated value from within the model class is to retrieve it from the attributes property like this:  But be aware that attributes is a protected property, so you can't do that from outside the model class. In that case, you can use or Maksym's technique from his comment below.I was running into an issue with Eloquent accessors and form model binding - by formatting an integer with money_format, the value was no longer being loaded into the form number input field.The workaround I am using is to create an accessor with a different name:This provides me with an accessor without affecting the form model binding.

How to test file upload in Laravel 5.2

Ramin

[How to test file upload in Laravel 5.2](https://stackoverflow.com/questions/36408134/how-to-test-file-upload-in-laravel-5-2)

Im trying to test an upload API but it fails every time: Test Code :Here is My Upload code in a controller :How should I test file upload in Laravel 5.2? How to use call method to upload a file?

2016-04-04 16:35:11Z

Im trying to test an upload API but it fails every time: Test Code :Here is My Upload code in a controller :How should I test file upload in Laravel 5.2? How to use call method to upload a file?When you create an instance of UploadedFile set the last parameter $test to true.Here is a quick example of a working test. It expects that you have a stub test.png file in tests/stubs folder.In Laravel 5.4 you can also use \Illuminate\Http\UploadedFile::fake(). A simple example below:If you want to fake a different file type you can use More information directly on Laravel Documentation.You can find this code at this linkSetupUsageFolder Structure:The laravel documentation has an answer for when you want to test a fake file. When you want to test using a real file in laravel 6 you can do the following:

What is the purpose of the server.php file in Laravel 4?

Michael Irigoyen

[What is the purpose of the server.php file in Laravel 4?](https://stackoverflow.com/questions/16919920/what-is-the-purpose-of-the-server-php-file-in-laravel-4)

In the /app/ directory in Laravel 4, there is a file called server.php. The contents of this file look like this:It seems that this file is in someway used to mimic Apache's mod_rewrite functionality, however I cannot find anything in the Laravel documentation that mentions it or it's use.I currently am trying to utilize Laravel on an IIS server that I do not manage. I do not have the ability to modify the URL rewrite module options on IIS (I will in the future), but would like to get started working with the framework now, if possible. This server.php file seems like it may be a stop-gap solution to do just that.Can anyone shed some light on the purpose of the server.php file and how to use/activate it if the purpose is really to emulate Apache's mod_rewrite functionality?

2013-06-04 14:02:45Z

In the /app/ directory in Laravel 4, there is a file called server.php. The contents of this file look like this:It seems that this file is in someway used to mimic Apache's mod_rewrite functionality, however I cannot find anything in the Laravel documentation that mentions it or it's use.I currently am trying to utilize Laravel on an IIS server that I do not manage. I do not have the ability to modify the URL rewrite module options on IIS (I will in the future), but would like to get started working with the framework now, if possible. This server.php file seems like it may be a stop-gap solution to do just that.Can anyone shed some light on the purpose of the server.php file and how to use/activate it if the purpose is really to emulate Apache's mod_rewrite functionality?It is meant to be used with PHP's internal web server which was introduced in PHP 5.4.According to the PHP manual:I can't emphasize this enough.If you would like to use it with the Laravel server.php file you can head to your cli and start the server with the following command (from the root of your Laravel directory):You should then be able to head to localhost:8000 in your web browser and begin using your Laravel application.Alternatively as Anand Capur mentioned you can launch the server with:Ultimately this just runs the aforementioned php -S command for you.You can optionally specify the host and port by doing something like:As with all artisan commands you can find out this information and additional information by doing:You can also use the commandartisan serve which will run the appropriate command to start the development server.

Posting JSON To Laravel

Joel_Blum

[Posting JSON To Laravel](https://stackoverflow.com/questions/21219482/posting-json-to-laravel)

I am trying to make a post request of json to Laravel. The request is received on the server however when I try to access a property I get: 

"Trying to get property of non-object".

On the client I'm using angularjs.angular: laravel: Note: I can see in Fiddler that the JSON being sent is valid and that it reaches the controller+method (http 200).The post request itself (As seen with Fiddler) 

2014-01-19 16:37:23Z

I am trying to make a post request of json to Laravel. The request is received on the server however when I try to access a property I get: 

"Trying to get property of non-object".

On the client I'm using angularjs.angular: laravel: Note: I can see in Fiddler that the JSON being sent is valid and that it reaches the controller+method (http 200).The post request itself (As seen with Fiddler) Laravel's Input::all method returns an associative array, not an object of PHP's stdClass.Please note as of Laravel 5.0, the Input facade has been removed from the official documentation (and in 5.2 it was also removed from the list of default Facades provided) in favor of directly using the Request class that Input invokes, which is Illuminate\Http\Request.Also, as of the Laravel 5.1 documentation, all references to the Request facade have been removed, again in preference of using the Illuminate\Http\Request instance directly, which it encourages you to do via dependency injection in either:...your Controller Method:...or a Route Closure (as of 5.3):It's worth noting that $request->json() returns an instance of Symfony\Component\HttpFoundation\ParameterBag, and that ParameterBag's ->all() method returns an associative array, and not an object as the OP expected.So one would now fetch the rough equivalent of $_POST['id'] as follows:Both facades have been removed from the official documentation (as of 5.1), and yet they both also remain in the source code with no 'deprecated' label.As mentioned earlier, Input was removed as a default facade ('alias') in 5.2, but as of 5.4, the Request facade remains a default.This seems to imply that one could still use the Request facade to invoke methods on the Request instance (e.g. Request::json()), but that using dependency injection is simply now the officially preferred method.To expand (and correct) the above, in Laravel 5 you would retrieve JSON as shown:In non-trivial examples you might want to also validate your input first.

PHP7.1 and Laravel 5.3: Function mcrypt_get_iv_size() is deprecated

nodeffect

[PHP7.1 and Laravel 5.3: Function mcrypt_get_iv_size() is deprecated](https://stackoverflow.com/questions/41031076/php7-1-and-laravel-5-3-function-mcrypt-get-iv-size-is-deprecated)

I'm using Laravel 5.0 for all my projects. Yesterday, I've updated my PHP version from 7.0.x to version 7.1.0. Once updated, I tried opening my Laravel project and saw this message below:May I know how can I solve this ? Does using Laravel 5.3 solve the problem? I don't feel like updating my Laravel to 5.3 because it's a huge project and it will takes a long time to update. There are too much differences between these two versions. Lots of codes need to be modified.Is there an easier way to solve this issue? 

2016-12-08 03:05:21Z

I'm using Laravel 5.0 for all my projects. Yesterday, I've updated my PHP version from 7.0.x to version 7.1.0. Once updated, I tried opening my Laravel project and saw this message below:May I know how can I solve this ? Does using Laravel 5.3 solve the problem? I don't feel like updating my Laravel to 5.3 because it's a huge project and it will takes a long time to update. There are too much differences between these two versions. Lots of codes need to be modified.Is there an easier way to solve this issue? This error occurs because you probably have something other than AES-256-CBC as your cipher in your config/app.php file that depends on the mcrypt extension. Perhaps you are using MCRYPT_RIJNDAEL_256 or MCRYPT_RIJNDAEL_128?The best thing you can do without a full-blown Laravel upgrade is install the legacy encrypter and use it to update all your encrypted data to use the AES-256-CBC cipher which has been the default cipher since Laravel 5.1, I believe. Once you do this, you should be able to use PHP 7.1 for your Laravel application.In your config/app.php configuration file, you should update the cipher to "AES-256-CBC" and set your key to a random 32 byte string which may be securely generated using php artisan key:generateAdd this to the beginning of the config/app.php:error_reporting(E_ALL ^ E_DEPRECATED);Source: https://stackoverflow.com/a/42515505/225790to solve this just change cipher in app.php from 'MCRYPT_RIJNDAEL_128' to 'AES-256-CBC'

disable csrf in laravel for specific route

jedrzej.kurylo

[disable csrf in laravel for specific route](https://stackoverflow.com/questions/31729415/disable-csrf-in-laravel-for-specific-route)

I've a payment system, where data is submitted to 3rd party site and than hauled back...When data returns it hits specific url lets say /ok route. $_REQUEST['transaction'].But because of laravel middleware I'm getting token mismatch. There is no way 3rd party payment API can generate token, so how I disable it? only for this route?or is there a better option?

2015-07-30 16:36:33Z

I've a payment system, where data is submitted to 3rd party site and than hauled back...When data returns it hits specific url lets say /ok route. $_REQUEST['transaction'].But because of laravel middleware I'm getting token mismatch. There is no way 3rd party payment API can generate token, so how I disable it? only for this route?or is there a better option?Since version 5.1 Laravel's VerifyCsrfToken middleware allows to specify routes, that are excluded from CSRF validation. In order to achieve that, you need to add the routes to $except array in your App\Http\Middleware\VerifyCsrfToken.php class:See the docs for more information.

Laravel Custom Model Methods

Jeremy Harris

[Laravel Custom Model Methods](https://stackoverflow.com/questions/23658479/laravel-custom-model-methods)

Whenever I add additional logic to Eloquent models, I end up having to make it a static method (i.e. less than ideal) in order to call it from the model's facade. I've tried searching a lot on how to do this the proper way and pretty much all results talk about creating methods that return portions of a Query Builder interface. I'm trying to figure out how to add methods that can return anything and be called using the model's facade.For example, lets say I have a model called Car and want to get them all:Great, except for now, let's say I want to sort the result into a multidimensional array by make so my result may look like this:Taking that theoretical example, I am tempted to create a method that can be called like:For a moment, lets forget the terrible method name and the fact that it is tightly coupled to the data structure. If I make a method like this in the model:And finally call it in my controller, I will get this Exception thrown:TL;DR: How can I add custom functionality that makes sense to be in the model without making it a static method and call it using the model's facade?This is a theoretical example. Perhaps a rephrase of the question would make more sense. Why are certain non-static methods such as all() or which() available on the facade of an Eloquent model, but not additional methods added into the model? This means that the __call magic method is being used, but how can I make it recognize my own functions in the model?Probably a better example over the "sorting" is if I needed to run an calculation or algorithm on a piece of data:To me, it makes sense for something like that to be in the model as it is domain specific.

2014-05-14 15:05:07Z

Whenever I add additional logic to Eloquent models, I end up having to make it a static method (i.e. less than ideal) in order to call it from the model's facade. I've tried searching a lot on how to do this the proper way and pretty much all results talk about creating methods that return portions of a Query Builder interface. I'm trying to figure out how to add methods that can return anything and be called using the model's facade.For example, lets say I have a model called Car and want to get them all:Great, except for now, let's say I want to sort the result into a multidimensional array by make so my result may look like this:Taking that theoretical example, I am tempted to create a method that can be called like:For a moment, lets forget the terrible method name and the fact that it is tightly coupled to the data structure. If I make a method like this in the model:And finally call it in my controller, I will get this Exception thrown:TL;DR: How can I add custom functionality that makes sense to be in the model without making it a static method and call it using the model's facade?This is a theoretical example. Perhaps a rephrase of the question would make more sense. Why are certain non-static methods such as all() or which() available on the facade of an Eloquent model, but not additional methods added into the model? This means that the __call magic method is being used, but how can I make it recognize my own functions in the model?Probably a better example over the "sorting" is if I needed to run an calculation or algorithm on a piece of data:To me, it makes sense for something like that to be in the model as it is domain specific.If you look at the Laravel Core - all() is actually a static functionYou have two options:orBoth will allow you to doActually you can extend Eloquent Builder and put custom methods there. Steps to extend builder : 1.Create custom builder2.Add this method to your base model : 3.Run query with methods inside your custom builder : for above code generated mysql query will be : PS: First Laurence example is code more suitable for you repository not for model, but also you can't pipe more methods with this approach : Second Laurence example is event worst. Many people suggest using scopes for extend laravel builder but that is actually bad solution because scopes are isolated by eloquent builder and you won't get the same query with same commands inside vs outside scope. I proposed PR for change whether scopes should be isolated but Taylor ignored me.More explanation : 

For example if you have scopes like this one : and two eloquent queries : vsGenerated queries would be : vs on first sight queries look the same but there are not. For this simple query maybe it does not matter but for complicated queries it does, so please don't use scopes for extending builder :)for better dynamic code, rather than using Model class name "Car",just use "static" or "self"

How to check if row is soft-deleted in Eloquent?

DisgruntledGoat

[How to check if row is soft-deleted in Eloquent?](https://stackoverflow.com/questions/34003284/how-to-check-if-row-is-soft-deleted-in-eloquent)

In Laravel 5.1 is there a nice way to check if an eloquent model object has been soft-deleted? I'm not talking about selecting data but once I have the object e.g. Thing::withTrashed()->find($id)So far the only way I can see isI do not see any relevant method in the API that would allow for example

2015-11-30 16:27:56Z

In Laravel 5.1 is there a nice way to check if an eloquent model object has been soft-deleted? I'm not talking about selecting data but once I have the object e.g. Thing::withTrashed()->find($id)So far the only way I can see isI do not see any relevant method in the API that would allow for exampleJust realised I was looking in the wrong API. The Model class doesn't have this, but the SoftDelete trait that my models use has a trashed() method.So I can writeIn laravel6, you can use followings.To check the Eloquent Model is using soft delete:To check the Eloquent Model is using soft delete in resource (when using resource to response):And finally to check if the model is trashed:Hope, this will be helpful!

Laravel Rule Validation for Numbers

AngularAngularAngular

[Laravel Rule Validation for Numbers](https://stackoverflow.com/questions/27614936/laravel-rule-validation-for-numbers)

I have the following Rule : But How to have the Rule that Fno Should be a Digit with Minimum 2 Digit to Maximum 5 Digit andLno Should be a Digit only with Min 2 Digit

2014-12-23 06:02:24Z

I have the following Rule : But How to have the Rule that Fno Should be a Digit with Minimum 2 Digit to Maximum 5 Digit andLno Should be a Digit only with Min 2 DigitIf I correctly got what you want:orFor all the available rules: http://laravel.com/docs/4.2/validation#available-validation-rulesTry this it will be workAlso, there was just a typo in your original post.'min:2|max5' should have been 'min:2|max:5'.

Notice the ":" for the "max" rule.Laravel min and max validation do not work properly with a numeric rule validation. Instead of numeric, min and max, Laravel provided a rule digits_between.

Run raw SQL in migration

Milkncookiez

[Run raw SQL in migration](https://stackoverflow.com/questions/28787293/run-raw-sql-in-migration)

I was trying with whatever syntax and can't think how can I write this correctly:also tried withand double quotation marks and so on. I always get the following when I run the migration:Yes, I have checked, MariaDB uses MySQL's syntax (at least for this case).

2015-02-28 21:44:34Z

I was trying with whatever syntax and can't think how can I write this correctly:also tried withand double quotation marks and so on. I always get the following when I run the migration:Yes, I have checked, MariaDB uses MySQL's syntax (at least for this case).Use back-ticks instead of single quotes to escape identifiers in MySQL:In this particular case you can omit escaping at all:The issue (as @postashin said) was the backticks.As of Laravel 5 (not sure about Laravel 4), you could have done this:In fact you didn't even need the back ticks as they don't need escaping. So you could have just written:You do not need this in the closure either if you are just executing a database statement.However a better approach to what you are doing is as follows:Note the last solution can sometimes raise an error due to a bug in Doctrine, which usually occurs if you have an enum in the table (not just the column you are changing).For more information, see Laravel Database Migration - Modifying Column

Calculate difference between two dates using Carbon and Blade

iivannov

[Calculate difference between two dates using Carbon and Blade](https://stackoverflow.com/questions/39508963/calculate-difference-between-two-dates-using-carbon-and-blade)

Does anyone know how to pass a given variable instead the Carbon's default parameters ?The documentation of Carbon says:And i want to do something like this in my controller:And retrieving that on a Blade template

2016-09-15 10:37:05Z

Does anyone know how to pass a given variable instead the Carbon's default parameters ?The documentation of Carbon says:And i want to do something like this in my controller:And retrieving that on a Blade templateYou are not following the example from the Carbon Documentation. The method Carbon::createFromDate() expects 4 parameters: year, month, day and timezone. And you are trying to pass a formatted date string.If you want to create a Carbon object from a formatted date string you can use the constructor of the class just like this:Or you can use the static Carbon::parse() method:For your purposes you can use the this full example:And then in your Blade template:You code can be cleaned up and have the commented out code removed by doing:Blade Template A shorter codeResult : 6 minutes ago

Laravel quick start guide route not working

twigg

[Laravel quick start guide route not working](https://stackoverflow.com/questions/16897504/laravel-quick-start-guide-route-not-working)

Ok I'm new to Laravel so went straight to the documentation to get started. There are massive holes in the documentation so it took a lot of effort and googling to fill the gaps in order to get Laravel set-up. I now have it set up and moved on to the next step in the quick start guide.I created my routeNow it says:So I hit up:but get a 404? I tried but still a 404? I followed the steps on the quick start guide to the letter, what am I missing?

2013-06-03 13:08:12Z

Ok I'm new to Laravel so went straight to the documentation to get started. There are massive holes in the documentation so it took a lot of effort and googling to fill the gaps in order to get Laravel set-up. I now have it set up and moved on to the next step in the quick start guide.I created my routeNow it says:So I hit up:but get a 404? I tried but still a 404? I followed the steps on the quick start guide to the letter, what am I missing?Seems like your Laravel app is accesible via an Apache HTTP alias, because your URL looks like: http://localhost/laravel/. If this is the case and assuming that http://localhost/laravel is pointing to your public directory, then follow these steps:Basically, if you app resides in a alias or virtual directory (say http://localhost/alias) you should add an entry in your rewrite rule to rewrite the base directory with alias.Apache isn't probably reading the public/.htaccess file due to the directive AllowOverride being set to None. Try to set it to All.Laravel 4 simple route not working using mod_rewrite, and .htaccess The problem is well explained by Rubens above, A simpler solution is to use the supplied built-in PHP Server by issuing this commandNote that I am using port 8080 here, you can omit it.Now you can browse the site by going toand it should work!I had the same problem and spent hours to solve it. 

I have several apps under the same domain, but in different segments. So Laravel's url is http://myhostname/mysubdir/My controllers were only working as http://myhostname/mysubdir/index.php/mycontrollerOn /var/www/.../public/.htaccess I put RewriteBase /mysubdir and worked!!! I know this question is 4 years old but still it have its significance.Rubens Mariuzzo was answered it correctly but I want to add some points on it. You said"There are massive holes in the documentation so it took a lot of effort and googling to fill the gaps in order to get Laravel set-up"For beginners it is difficult to find correct way of configuring Laravel. Once it is mastered it is fun developing Laravel :) . There are certain correct way of doing this.Detailed description is given in this blog http://masterlaravel.blogspot.in/2017/08/laravelquick-start-composer-create.htmlplease refer to this follow url and see RoboTamer's config:http://forums.laravel.io/viewtopic.php?id=511it solved my problem the same as yourssolution in nginx:server {}Thanks. Knowledge of the above by @rubens, and a comment by @GaryJ here made me do this to make it work from my Apache virtual hosts file.Copied these lines from .htaccess file in laravel within  node of the vhosts config.

Removed my .htaccess file (it was anyway not being applied, i am on a windows apache virtual host, laravel env)Better:

Later read @Ag0r0 's reply, that worked. i was missing the allow override, making the above neccessary. once allowoverride all was there, the default settings itself worked.In my case (Ubuntu 14.04 LTS & Apache 2.2) I was stuck at #1 step of @Rubens' solution. I could see the page with this url: http://localhost/laravel/index.php/users but step #2 and others didn't work.Also I've tried to add RewriteBase /laravel/public to .htaccess but it didn't work too.Then I've set up a new virtual host with the help of this awesome tutorial: https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-ubuntu-14-04-lts (they rock with these tuts)In addition to tutorial, I've set DocumentRoot (in example.com.conf file) like this:Yes, public is the big deal here. Btw, don't put RewriteBase /laravel/ to your .htacces file otherwise you'll get HTTP/500 error.Now, I can see example.com/users page.my previous post with the describtion of the problem was deleted, but it was similar to the situation that is described here. anyway... simply i have tried all the possibilities that are described here as well as on other pages and I did not find solution to my problem. The fresh installation of the Laraval simply did not worked.... after trying everythink from this post i decided to create yet another fresh installation and miracle happened this installation is actually working... So my advice is: if you are not able to fix this problem just try to create another installation of the laravel and it might actually work. This might be actually the easiest way how to fix your problem in case you are starting from the scrach. 

Laravel 5 migration identifier name too long

geoffs3310

[Laravel 5 migration identifier name too long](https://stackoverflow.com/questions/30170268/laravel-5-migration-identifier-name-too-long)

I am trying to run the following migration:But I get the following error:

2015-05-11 14:24:55Z

I am trying to run the following migration:But I get the following error:You can pass a custom index name as the second parameter into the foreign() method. Or just use shorter table/column names.So you want to do something like:

validating a numeric input's length in laravel 5

bobD

[validating a numeric input's length in laravel 5](https://stackoverflow.com/questions/39539436/validating-a-numeric-inputs-length-in-laravel-5)

foo.blade.phpFooController.phpthe national-id field should contain 10 digits and I actually expected the code above to validate this , but instead It will check If the national-id exactly equals to 10 or not ...

how can I validate the length of a numeric field?

2016-09-16 20:13:46Z

foo.blade.phpFooController.phpthe national-id field should contain 10 digits and I actually expected the code above to validate this , but instead It will check If the national-id exactly equals to 10 or not ...

how can I validate the length of a numeric field?In fact you don't need to use digits_between rule. You can use digits rule so according to documentation it will be enough to use:without numeric rule because digits rule also verify if given value is numeric.When using size on a number it will check if the number is equal to the size, on string, it will check the amount of characters, for number you should use :In laravel the size validation on a field that's numeric  will indicate the max integer it cannot be larger than.Use digits_between: 

Displaying the Error Messages in Laravel after being Redirected from controller

SA__

[Displaying the Error Messages in Laravel after being Redirected from controller](https://stackoverflow.com/questions/26732821/displaying-the-error-messages-in-laravel-after-being-redirected-from-controller)

How can I display the validation message in the view that is being redirected in Laravel ?Here is my function in a ControllerI know the below given code is a bad try, But how can I fix it and what am 

 I missing 

2014-11-04 10:27:11Z

How can I display the validation message in the view that is being redirected in Laravel ?Here is my function in a ControllerI know the below given code is a bad try, But how can I fix it and what am 

 I missing Laravel 4When the validation fails return back with the validation errors.You can catch the error on your view usingUPDATETo display error under each field you can do like this.For better display style with css.You can refer to the docs here.UPDATE 2To display all errors at onceTo display error under each field.If you want to load the view from the same controller you are on:And if you want to quickly display all errors but have a bit more control:to Make it look nice you can use little bootstrap helpA New Laravel Blade Error Directive comes to Laravel 5.8.13Move all that in kernel.php if just the above method didn't work for you

remember you have to move all those lines in kernel.php in addition to the above solutionlet me first display the way it is there in the file already..now what you have to do isi.e.;

How to use the request route parameter in Laravel 5 form request?

Rohan

[How to use the request route parameter in Laravel 5 form request?](https://stackoverflow.com/questions/30051970/how-to-use-the-request-route-parameter-in-laravel-5-form-request)

I am new to Laravel 5 and I am trying to use the new Form Request to validate all forms in my application.Now I am stuck at a point where I need to DELETE a resource and I created a DeleteResourceRequest for just to use the authorize method.The problem is that I need to find what id is being requested in the route parameter but I cannot see how to get that in to the authorize method.I can use the id in the controller method like so:But how to get this to work in the authorize method of the Form Request?

2015-05-05 11:39:38Z

I am new to Laravel 5 and I am trying to use the new Form Request to validate all forms in my application.Now I am stuck at a point where I need to DELETE a resource and I created a DeleteResourceRequest for just to use the authorize method.The problem is that I need to find what id is being requested in the route parameter but I cannot see how to get that in to the authorize method.I can use the id in the controller method like so:But how to get this to work in the authorize method of the Form Request?That's very simple, just use the route() method. Assuming your route parameter is called id:You can accessing a Route parameter Value via  Illuminate\Http\Request instanceLaravel 5.2, from within a controller:I've found this useful if you want to use the same controller method for more than one route with more than one URL parameter, and perhaps all parameters aren't always present or may appear in a different order...i.e. getParameter('id')will give you the correct answer, regardless of {id}'s position in the URL.See Laravel Docs: Accessing the Current RouteDepending on how you defined the parameter in your routes.For my case below, it would be: 'user' not 'id'$id = $this->route('user');I came here looking for an answer and kind of found it in the comments, so wanted to clarify for others using a resource route trying to use this in a form requestas mentioned by lukas in his comment:

Given a resource controller Route::resource('post', ...) the parameter you can use will be named postThis was usefull to me but not quite complete. It appears that the parameter will be the singular version of the last part of the resource stub.In my case, the route was defined as $router->resource('inventory/manufacturers', 'API\Inventory\ManufacturersController');And the parameter available was manufacturer (the singular version of the last part of the stub inventory/manufacturers)

Add「ON DELETE CASCADE」to existing column in Laravel

Farid Movsumov

[Add「ON DELETE CASCADE」to existing column in Laravel](https://stackoverflow.com/questions/26820788/add-on-delete-cascade-to-existing-column-in-laravel)

I have user_id fk column in my tableI should add on cascade delete feature to this existing column. How can I do this?

2014-11-08 18:49:34Z

I have user_id fk column in my tableI should add on cascade delete feature to this existing column. How can I do this?Drop foreign key first. Thanks to Razor for this tip

Laravel schema builder can't modify columns at the current state, so you will use raw queries. You will have to drop and recreate the constraint:PostgreSQLMySQLIn my case, i'll need to put the col name in an array else that will be an error.mysql 5.7 verThanks for question answer. Help me get to this working code in L5.1 :I am assuming you used Illuminate\Database\Schema\Blueprint::primary() to create users.id. If that is the case, then users.id will be unsigned. Therefore your foreign key column user_id must also be unsigned.Use the unsigned function to user_id in the present migration:

Laravel 4 - logging SQL queries

ericbae

[Laravel 4 - logging SQL queries](https://stackoverflow.com/questions/19131731/laravel-4-logging-sql-queries)

There are already several questions in regards to logging the SQL query in Laravel 4. But I've tried almost all of them and it's still not working the way I want.Here's my situationIf I useI just get "select * from my_table where id=?" as the log message without the ID value actually populated.If I useI still don't have the final SQL query with the ID populated.Finally, if I use a logging tool like https://github.com/loic-sharma/profiler - it doesn't display anything since I'm making an AJAX request.Have I exhausted my options? Is there still another better way?

2013-10-02 07:14:42Z

There are already several questions in regards to logging the SQL query in Laravel 4. But I've tried almost all of them and it's still not working the way I want.Here's my situationIf I useI just get "select * from my_table where id=?" as the log message without the ID value actually populated.If I useI still don't have the final SQL query with the ID populated.Finally, if I use a logging tool like https://github.com/loic-sharma/profiler - it doesn't display anything since I'm making an AJAX request.Have I exhausted my options? Is there still another better way?Here is what I am currently using for logging of sql queries. You should be able to drop this into your main routes file then add 'log' => true into your database config. Thanks to Jeemusu answer for the bit about inserting the bindings into the prepared statement.You should be able to find the bindings by passing $bindings as the second parameter of the Event function.In Laravel 3.x I think the event listener was called laravel.queryContinuing on @Collin James answer.If you want to log to a seperate file only for sql, you can do it with this:With this at the top of your file:This will log all your queries to a file named sql-YYYY-mm-dd.log in storage/logs/.While the accepted answer stands correct, this answer explains how to update loic-sharma profiler when making Ajax requests using jQuery. Using this approach one doesn't need to read file logs. The first problem is to send the updated profiler data to the client on every Ajax-request. This can be solved using the "after" events of the Laravel application.app/filters.php:The App::after filter will run upon every Laravel request. The first line of the closure above, makes sure that it will only continue if a the response is of type JsonResponse and the profiler is enabled. If that is the case, render the profiler and append the HTML to the JSON object. Note: this code assumes that the returned JSON is a object. So it will fail for arrays: Response::json(array(1,2,3)).Now that the updated profiler HTML is being sent to the client, we must update the DOM with the new profiler HTML using javascript. This should happen every time the client gets a JSON response. jQuery provides global Ajax event handlers, which is perfect to achive this.Here's a method to replace the old profiler with the new one:Now it is as simple as returning responses as:Laravel will append the profiler HTML. The javascript will catch the JSON response and update the DOM. You will have the SQL queries and timings right on the web page.While the code is tested, there might be a bug or two. This is also not exactly how I do it. Instead of sending the HTML in the json response, I extend the object with the actual data from the profiler. On the client side I render the profiler using a mustache template.That's what I've been using:While the question was originally targeted at Laravel 4, I still ended up here through google, but I'm using Laravel 5.There are new ways to log all queries in Laravel 5 using Middleware, but if you prefer the same approach here is the same code provided by Collin James but working for Laravel 5

Starting with laravel on ubuntu

Isaac Gonzalez

[Starting with laravel on ubuntu](https://stackoverflow.com/questions/11981621/starting-with-laravel-on-ubuntu)

I'm trying laravel as a PHP framework, I have already extracted the laravel zip into ~/opt/xampp/htdocs/laravel but when I go to localhost/laravel or localhost/laravel I get a 403 error message saying: I read somewhere that I need to edit the storage folder inside of laravel so it can be readable and writable so I chmod -R 766 laravel/storage but still no luck, I'm doing this from Ubuntu 12.04 have anyone encountered this ?

