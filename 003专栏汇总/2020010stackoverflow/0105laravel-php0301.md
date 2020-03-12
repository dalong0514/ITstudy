[Authenticate users from more than two tables in laravel 5 [duplicate]](https://stackoverflow.com/questions/46292391/authenticate-users-from-more-than-two-tables-in-laravel-5)

As I know Auth::attempt is used to authenticate users from users table,  but i want to authenticate another users from managers table and admin from admins table. I know there are laravel-multiauth plugin already exist. But can we create our own AuthServiceProvider for authenticating users from multiple tables..?

2017-09-19 05:21:22Z

As I know Auth::attempt is used to authenticate users from users table,  but i want to authenticate another users from managers table and admin from admins table. I know there are laravel-multiauth plugin already exist. But can we create our own AuthServiceProvider for authenticating users from multiple tables..?First create Admin Authenticatable in Illuminate\Foundation\Auth like Then create Admin Model by extending  Authenticatable Admin Model :-After that you need to modify config/auth.php like below 

Add in providers arrayand Add in guards array.Now to authenticate from user table And to authenticate from Admin tableYou could setup multiple authentication guards, with each one having a different provider. The providers define the table or model to be used.In config/auth.php you setup the providers as follows and you also setup corresponding guards for each of those providers:Then you can authenticate like this:Check out the docs here.Try my idea if you want to. I'm expecting that different table has different users. Because it won't work if you have the same user in other tables.Note: Your priority table here is users, then if the user doesn't exists in that table, it will try the managers table, then if still doesn't exists, it will check the admins table, otherwise (use else) return a message error.Other option:Other option is to use this package sarav/laravel-multiauth. You can follow this thread. How to use authentication for multiple tables in Laravel 5 for more information.More Reference:https://laracasts.com/discuss/channels/general-discussion/using-laravel-auth-for-multiple-tables?page=1Can anyone explain Laravel 5.2 Multi Auth with examplehttps://laracasts.com/discuss/channels/laravel/52-auth-multiple-tables?page=1Create a model for managers table and admins table. This model should extend Illuminate\Foundation\Auth\UserIn config/auth.php,Add to the providers array:Add to the guards array:Then. in LoginController (create one for manager using php artisan make:auth) use the trait Illuminate\Foundation\Auth\AuthenticatesUsers and 

override  guard and redirect properties.The manager model is authenticated and you can get the auuthenticated manager's object  Auth::guard('web_manager')->user();

Laravel: Access Model instance in Form Request when using Route/Model binding

Jonathon

[Laravel: Access Model instance in Form Request when using Route/Model binding](https://stackoverflow.com/questions/37347415/laravel-access-model-instance-in-form-request-when-using-route-model-binding)

I have some route/model binding set up in my project for one of my models, and that works just fine. I'm able to use my binding in my route path and accept an instance of my model as a parameter to the relevant method in my controller.Now I'm trying to do some work with this model, so I have created a method in my controller that accepts a Form Request so I can carry out some validation.Each different instance of my model can be validated differently, so I need to be able to use an instance of the model in order to build a custom set of validation rules.Is there a way of getting the instance of the model, that is injected into the controller from the Form Request?I have tried type-hinting the model instance in the Form Request's constructorI have also tried type-hinting the model instance in the Form Request's rules() method.In both instances I am provided an empty/new instance of the model, rather than the instance I am expecting.Of course, I could always get around this by not bothering with Form Requests and just generate the rules in the controller and validate manually - but I would rather do it the Laravel way if it's possible.Thanks

2016-05-20 12:58:59Z

I have some route/model binding set up in my project for one of my models, and that works just fine. I'm able to use my binding in my route path and accept an instance of my model as a parameter to the relevant method in my controller.Now I'm trying to do some work with this model, so I have created a method in my controller that accepts a Form Request so I can carry out some validation.Each different instance of my model can be validated differently, so I need to be able to use an instance of the model in order to build a custom set of validation rules.Is there a way of getting the instance of the model, that is injected into the controller from the Form Request?I have tried type-hinting the model instance in the Form Request's constructorI have also tried type-hinting the model instance in the Form Request's rules() method.In both instances I am provided an empty/new instance of the model, rather than the instance I am expecting.Of course, I could always get around this by not bothering with Form Requests and just generate the rules in the controller and validate manually - but I would rather do it the Laravel way if it's possible.ThanksYou can simply access it using the binding key, so for example if you bind Brand model: $router->model('brand', '\App\Brand') you can get instance of your model with $this->brand. Here is validation rules example:EDITSometimes you might have an input name that uses the same name as the binding key, for example, if you bind Address model as address then you have an input field address it will make Laravel confuse. For this situation you can use route() method.

Including PHP files with Laravel framework

user1072337

[Including PHP files with Laravel framework](https://stackoverflow.com/questions/17159046/including-php-files-with-laravel-framework)

I am trying to "include" a php script into one of my views (landing.blade.php).  The script is in: When I try to include this code in the view:I get the error:  include_once(/assets/scripts/config.php): failed to open stream: No such file or directoryThis is on localhost using MAMP.  I'm not sure if there is a different set of rules I need to use with Laravel 4 to include a php file.  Thank you for your help!

2013-06-18 00:47:55Z

I am trying to "include" a php script into one of my views (landing.blade.php).  The script is in: When I try to include this code in the view:I get the error:  include_once(/assets/scripts/config.php): failed to open stream: No such file or directoryThis is on localhost using MAMP.  I'm not sure if there is a different set of rules I need to use with Laravel 4 to include a php file.  Thank you for your help!First, it's not really recommended that you keep your PHP files in the public directory, they should be kept inside the app folder. I'd suggest you create a folder inside app, something like includes and put your files there. Then, you include it, do:Although, since it looks like you're trying to load some configuration files, I'd recommend you also check out Laravel's own way of handling configurations. For instance, if you created a myapp.php file inside the app/config folder, Laravel would handle it automatically for you, as long as you'd have some key-value pairs, like this:You could then retrieve these values using the Config class:This is a better solution because you can also take advantage of Laravel's environment configuration.

Laravel: Class 'GuzzleHttp\Client' not found

InvalidSyntax

[Laravel: Class 'GuzzleHttp\Client' not found](https://stackoverflow.com/questions/31227080/laravel-class-guzzlehttp-client-not-found)

I am trying to use Mandrill to send emails via my Laravel framework, however I am receiving the following error:I have installed Guzzle using the following command in Terminal:According to Laravel's documentation I need to add "guzzlehttp/guzzle": "~4.0" to my composer.json file, but I'm not sure if where I have placed it is correct as I still see the error.Here is the list of packages my application has, notice that guzzle has a different version: 4.2.3 which i've also tried updating to but still get the same error.

2015-07-05 04:14:14Z

I am trying to use Mandrill to send emails via my Laravel framework, however I am receiving the following error:I have installed Guzzle using the following command in Terminal:According to Laravel's documentation I need to add "guzzlehttp/guzzle": "~4.0" to my composer.json file, but I'm not sure if where I have placed it is correct as I still see the error.Here is the list of packages my application has, notice that guzzle has a different version: 4.2.3 which i've also tried updating to but still get the same error.

Open up your terminal at the root of your project and enterIt worked for the mailgun API. For some reason, the suggested method at the laravel's mail doc. You may install this package to your project by adding the following line to your composer.json file doesn't make the composer download the Guzzle source codes. By the way, I didn't find out what | means in determining the version. This command just downloads the PSR code. In this moment, the solution may work. However, be aware of compatibility issues. Because the command would install the latest stable version, not the suitable one. If you're using Laravel when you run into this error, just run:And try again.After updating your composer.json file you need to run the update command to resolve and install your dependencies:or, if composer isn't in your path:Did you try :or if artisan is not available try to remove compiled.php if exist (in vendor directory) and launch composer dumpautoload  I had the same issue.

I used an old version in order to work.

It's not working anymore since version 4.

It works on version 3.8.1So you can add "guzzlehttp/guzzle": "~3" to workssimple in my case add "guzzlehttp/guzzle": "^6.3" in composer.json

require object as mentioned belowthan run composer update in project root using terminal than its working fine.I got this error when I tried running my code outside of the Laravel framework while testing in a stand alone file.  It worked for me when I moved it inside a controller.You can solve this problem to add "mews/captcha": "1.0.1" and "guzzlehttp/guzzle": "~4.0" to your composer.json file. And then you need run composer update command on your terminal.I have tried on Laravel 4. It works for me.I am oblivious to why this worked for me, I saw this in a forum somewhereI just added this captcha generator to the composer.json fileadded it to all the require packageIf someone knows why this worked it would really scratch the itch in my brain.

The Mix manifest does not exist when it does exist

Chris

[The Mix manifest does not exist when it does exist](https://stackoverflow.com/questions/45153738/the-mix-manifest-does-not-exist-when-it-does-exist)

For my admin panel I extract all the assets including the manifest-json.js to mix.setPublicPath(path.normalize('public/backend/')).All the files get correctly added to the backend folder, and the manifest-json.js file looks as follows:the problem is that when using in my blade-files, it looks in public/manifest-json.js instead of looking for it in backend/manifest-json.js.How can I make sure the right manifest-json.js file is used?

2017-07-17 21:11:22Z

For my admin panel I extract all the assets including the manifest-json.js to mix.setPublicPath(path.normalize('public/backend/')).All the files get correctly added to the backend folder, and the manifest-json.js file looks as follows:the problem is that when using in my blade-files, it looks in public/manifest-json.js instead of looking for it in backend/manifest-json.js.How can I make sure the right manifest-json.js file is used?i solved my problem running this commandand thenThank You.I had same exception after deployment  laravel project to  server. It was working perfectly fine on localhost but after  lot of research I found a solution. If you encounter this exception on server then you have to bind your public path to public_htmlJust go to under the app/Providers, you will find your AppServiceProvider file and inside boot() method make the binding as below.The problem I faced was that the mix()-helper function by default looks for the manifest-json file in /public/manifest-json.js so if you store that file on any other directory level then it will throw that error.Let's say the manifest-json file is stored in public/app/manifest-json.js, then for a file located in public/app/css/app.css you would use:The mix()-helper function allows for a second argument, the directory of the manifest file. Just specify it there and it will use the correct manifest file.In shared hosts and laravel 5.6 tested:

after doing standard levels such as explained here;

two levels needed:

in app/Providers/AppServiceProvider.php:and in public_html file make .htaccess file with content:source: here

this file most change for some situations.that's all and solved my problemi have same problem as questioner: manifest does not exist for solving it what i have done is ran 2 commands as following:and thenand the error is solved now. yippi.I had the same issue with a Laravel package, its assets were not published:This solved the issue for me:php artisan vendor:publish --tag=telescope-assets --forceSources:

https://github.com/laravel/telescope/issues/136

https://github.com/laravel/telescope/issues/250I found new solutionThe problem is mix manifest right?

So just redirect to the mix manifest feature. for example, you have:just change your code into it works for meI had the issue on a shared host, where I was not able to run npm commands. Then I used the simplest way. In the /vendor/laravel/.../Foundation/Mix.php replace toNot recommended, but it works. You can use it as your last try.

Expected response code 250 but got code「530」, with message "530 5.7.1 Authentication required

Abdallah Abdillah

[Expected response code 250 but got code「530」, with message "530 5.7.1 Authentication required](https://stackoverflow.com/questions/48341078/expected-response-code-250-but-got-code-530-with-message-530-5-7-1-authentic)

I got stack on this error I trying to configure SMTP  mail on laravel here is my configuration on .env 

I have try to authenticate the SMTP on env  but I keep get the same error so for now am stack on that error

2018-01-19 12:25:35Z

I got stack on this error I trying to configure SMTP  mail on laravel here is my configuration on .env 

I have try to authenticate the SMTP on env  but I keep get the same error so for now am stack on that erroryour mail.php on config you declare host as smtp.mailgun.org and port is 587 while on env is different. you need to change your mail.php to'host' => env('MAIL_HOST', 'mailtrap.io'),'port' => env('MAIL_PORT', 2525),if you desire to use mailtrap.Then runI believe this has been answered in some sections already, just test with gmail for your "MAIL_HOST" instead and don't forget to clear cache. Setup like below:

Firstly, you need to setup 2 step verification here google security. An App Password link will appear and you can get your App Password to insert into below "MAIL_PASSWORD". More info on getting App Password hereClear cache with:That is basically authentication error due to misconfiguration of email settings.Go to .env filechangetoThe MAIL_USERNAME and PASSWORD should be replaced with your Gmail Email address and Password respectively. Login to your Google Account, Go to security settings and enable Allow Less Secure App switch button.After that go to your project root directory and run the following command:. Please refer to this guide  for assistance and clarification (Note: For MAIL_HOST use smtp.gmail.com)I see you have all the settings right. You just need to end the local web server and start it again with Everytime you change your .env file, you need tor restart the server for the new options to take effect.Or clear and cache your configuration with Yep, and if you have tried all the above solutions (what's more likely to happen) and none work for you, it may happen that Guzzle is not installed.Laravel ships mailing tools, by which is required the Guzzle framework, but it won't be installed, and AS OF the documentation, will have to install it manually:

https://laravel.com/docs/master/mail#driver-prerequisites

Eloquent ORM Code Hinting in PhpStorm

Josh Janusch

[Eloquent ORM Code Hinting in PhpStorm](https://stackoverflow.com/questions/29439753/eloquent-orm-code-hinting-in-phpstorm)

So I'm just starting off with Laravel (using v5) and Eloquent. I'm working on getting some basic APIs up and running and noticing that a lot of working methods don't show up in PhpStorm's code hintingSo I have this model:And in one of my controllers I try to doUser::query() creates a Eloquent Builder object and orderBy() behave properly and without error. However, PhpStorm does not show orderBy() (or take(), skip(), and I'm sure others) when I type User::query()-> and gives warnings when I actually do use it.I am using Laravel IDE Helper which has helped immensely with bringing code hints to the Facades, but not to the models/builders it would seem.Does anyone have a solution to this?

2015-04-03 21:12:54Z

So I'm just starting off with Laravel (using v5) and Eloquent. I'm working on getting some basic APIs up and running and noticing that a lot of working methods don't show up in PhpStorm's code hintingSo I have this model:And in one of my controllers I try to doUser::query() creates a Eloquent Builder object and orderBy() behave properly and without error. However, PhpStorm does not show orderBy() (or take(), skip(), and I'm sure others) when I type User::query()-> and gives warnings when I actually do use it.I am using Laravel IDE Helper which has helped immensely with bringing code hints to the Facades, but not to the models/builders it would seem.Does anyone have a solution to this?For future Googlers, and perhaps OP as well if you are still sticking to Laravel.The laravel-ide-helper package solves this issue for you quite elegantly, with what I believe is a relatively new feature; generated model PHPDocs.You can generate a separate file for all PHPDocs with this command:The generated metadata will look something like this for each class:This caused issues for me in PHPStorm however, where the software was complaining about multiple class definitions. Luckily an option is readily available for writing directly to the model files:There are a few more options and settings available if you need to tweak the behavior, but this is the gist of it.Add in model PHPDoc@mixinIn PHPStorm worksOr add to \Illuminate\Database\Eloquent\ModelPHPDocA little late but I recently had the same problem so I thought I would put a note down:This is because Database\Eloquent\Model.php has a query() function which returns \Illuminate\Database\Eloquent\Builder and the Eloquent\Builder has a line:Then it uses 'magic' __call methods to call to functions in Query\Builder. (look for __call method in Eloquent\Builder)See:

http://php.net/manual/en/language.oop5.overloading.php#object.callSo, indeed the method you are calling is inaccessible :) There is not much that the IDE can do.There are workarounds like using @method tags but it is unmaintainable. An alternative is to use @mixin (but this is not standards based).

See: https://github.com/laravel/framework/issues/7558I think this all be resolved when they get rid of all the magic calls in the Laravel code and use PHP 'traits' instead. See last message here. :)You can try Laravel plug-in for PhpStorm and you need to specifically activate it in your project settings.If you're using BarryVHD's Laravel IDE Helper package, run:This will write /** @mixin \Eloquent */ into the vendor\laravel\framework\src\Illuminate\Database\Eloquent\Model.php file.I wanted to have some kind of explicit "casting" when interacting with the query builder. Example...Since all my models are extending my custom base Model which in turn extends Eloquent, I've ended up creating this method in my custom base model:This way, it solves the IDE invalid error and helps me:Please note that this is not OOP type casting. It is only a hint to help the IDE. In my example, the returned Model was already a User. If I woud use this method on a derived class like SuperUser, only the IDE will be fooled...An nice alternative also is to put meta information directly over the assignment statement:Or next to it...

CRUD Laravel 4 how to link to destroy?

helloworld

[CRUD Laravel 4 how to link to destroy?](https://stackoverflow.com/questions/19643483/crud-laravel-4-how-to-link-to-destroy)

I will destroy my user with a HTML link, but it doesn't seem to generate the correct link, what am i doing wrong?In my view i call this

{{URL::action('UserController@destroy', array($user->id))}}

2013-10-28 19:30:56Z

I will destroy my user with a HTML link, but it doesn't seem to generate the correct link, what am i doing wrong?In my view i call this

{{URL::action('UserController@destroy', array($user->id))}}Update 08/21/2017 for Laravel 5.xThe question asks about Laravel 4, but I include this in case people looking for Laravel 5.x answers end up here. The Form helper (and some others) aren't available as of 5.x. You still need to specify a method on a form if you are doing something besides GET or POST. This is the current way to accomplish that:You can also use {{ method_field('PUT') }} instead of writing out the hidden _method input.See https://laravel.com/docs/5.4/routing#form-method-spoofingOriginal Answer for Laravel 4I think when you click the link, it is probably sending a GET request to that end point. CRUD in Laravel works according to REST. This means it is expecting a DELETE request instead of GET.Here's one possibility from a tutorial by Boris Strahija.This way, you send the request in a form with the DELETE method. The article explains why a traditional link won't work:An cool ajax solution that works is this:And in the UserController.php we have this method: Another "clean" solution is to make it the Rails way as described here:What I like about this that it seems much cleaner than bloating your code with Form::open(); in blade templates.For those looking to create the delete button in Laravel 5:This is similar to Tayler's answer but we use the new blade escape tags ( {!! and !!} ), we use the Form facade to generate the button and we use a more elegant approach to link to the controller. In Laravel < 5 the Forms & HTML package was pulled in automatically. In Laravel 5 we must add this package to composer.json:Now add the Service Provider and Alias in config/app.php:The above will outputIf you are using a different form builder just make sure it generates something similar to the above. This is an old questions, but I was just looking for a quick answer and am not satisfied with any of these.  What I would suggest to anyone with this same problem is create a new route.  Worrying too much about crud compliance is silly, because there is no such thing over HTML; any solution is just shoe-horned to fit, whether it's a hidden form field or a get route.So, in your routes, you likely have something like this:Route::resource('users', 'UsersController');

The problem with this is that the only way to get to the "destroy" method is to sent a post request which has a hidden input named "_method" and a value of "DELETE".Simply add under that line:

Route::get('users/{id}/destroy',['as'=>'users.delete','uses'=>'UsersController@destroy']);Now you have a route you can access from HTML::linkRoute, Route::url, or whatever method you please.For example:

{{ HTML::linkRoute( 'users.delete', 'Delete' , [ 'id' => $user->id ]) }}EDITI want to clarify, though I have explained why it's somewhat silly to bend over backward to fit crud compliance, it is still true that your app will be more secure if changes are made only through POST requests.Want to send a DELETE request when outside of a form?Well, Jeffrey Way created a nice javascript that creates a form for you and to use it you only need to add data-method="delete" to your delete links.To use, import script, and create a link with the data-method="DELETE" attribute.script :For those looking to create delete button using anchor tag in laravel 5.I tried your code, used it like this and worked:I think that the only problem is in your array: 

Laravel redirect with logout not working

winnyboy5

[Laravel redirect with logout not working](https://stackoverflow.com/questions/23242533/laravel-redirect-with-logout-not-working)

I am Using laravel 4 framework's. When I used redirect after the Auth::logout(), the redirection was not working. I used View::make() too, but same "Whoops, looks like something went wrong." error throws up.This is the logout code. I am using. Some one please help me with this.routes.php HTMLThis is what my debugger shows.

2014-04-23 11:11:32Z

I am Using laravel 4 framework's. When I used redirect after the Auth::logout(), the redirection was not working. I used View::make() too, but same "Whoops, looks like something went wrong." error throws up.This is the logout code. I am using. Some one please help me with this.routes.php HTMLThis is what my debugger shows.You may be missing the remember_token for the users table.see: http://laravel.com/docs/upgrade#upgrade-4.1.26Laravel requires "nullable remember_token of VARCHAR(100), TEXT, or equivalent to your users table."Update for new documentationLaravel 4.2 and up now has a method you can use with your schema builder to add this column.$table->rememberToken();Laravel Docs - Schema - Adding ColumnsIf you have Laravel 4.2 you can do this:Command Line:After this open the file app/database/migrations/2014_10_16_124421_add_remember_token_to_users_table and edit it like this:for your problem ,you may pass null value or you may off your remember_token value in your model php file ashere is a sample code from how I handle logging out users on my system using Laravel 4. I am not sure why yours isn't working and it will be great to see your route, and html code that triggers the logout process as well. The RouteThe HTML button/link triggering the logoutThe Controller Function Handling the logoutHere you got! You should replace it with your route names and controller function. This should work! If it doesn't, post your route and html code! Cheers!Due to the current Laravel update there should be a "remember_token" column in the user table. This solves the problem.I learned that I was getting the logout error in my application because I was usingJust remember to use the following instead.This worked smoothly.You need to add updated_at column into your SQL table user_tbl. If you do not wish to use it. you may also turn off timestamps within your model.

What is the usage of repositories and interfaces in Laravel?

Dreengreen

[What is the usage of repositories and interfaces in Laravel?](https://stackoverflow.com/questions/45914154/what-is-the-usage-of-repositories-and-interfaces-in-laravel)

After developing a few projects using Codeigniter since 2 years,  I stared to learn Laravel.I downloaded a few projects lo learn how they are coded. As I understood, many of them are using only models, views and controllers which is same as Codeigniter.But one project has used repositories and interfaces. It is really hard to understand whats going on that project. So what is the usage of repositories and interfaces in Laravel? When should I use them?

2017-08-28 07:49:16Z

After developing a few projects using Codeigniter since 2 years,  I stared to learn Laravel.I downloaded a few projects lo learn how they are coded. As I understood, many of them are using only models, views and controllers which is same as Codeigniter.But one project has used repositories and interfaces. It is really hard to understand whats going on that project. So what is the usage of repositories and interfaces in Laravel? When should I use them?I will try to explain as clearly as possible the two concepts.Interfaces\ContractsIn general OOP interfaces are used to describe which methods/functionalities the class that implements that interface is offering without caring about the actual implementation.Laravel uses Contracts mainly to separate a service from the actual implementation. To be more clear let's make an exampleAs you can see in this class the code is tightly coupled to a cache implementation (i.e. \SomePackage\Cache\Memcached) so if the API of that Cache class changes our code also must be changed accordingly. The same thing happens if we want to change the Cache implementation with another one (e.g. redis).Instead of doing that, our code could depend on an interface that is agnostic from the implementation:Now our code is not coupled with any specific implementation because Cache is actually an interface. So basically in our class we are requiring an instance of a class that behaves like described in the Cache interface, but we are not really interested in how it works internally. Doing that if we want to change the cache implementation we could write a class that implements the interface Cache without changing any line of code in our OrdersCache class. Doing that our code is easier to understand and maintain and your packages are a lot more reusable. See the section Loose Coupling in the Laravel documentation for further examples.Interfaces and Service ContainerOne of the main features of Laravel is its Service Container, it is used to manage dependencies and performing dependency injection. Please take a look at Service Container definition from Laravel documentation.Dependency Injection is widely used by Laravel also to bind interfaces to implementation. Let's make an example:And let our class beWithout declaring anything else we are basically saying everytime that someone need an EventPusher instance, please Laravel, provide an instance of RedisEventPusher class. In this case everytime that your controller is instantiated, Laravel will pass an instance of RedisEventPusher to your controller without specifying anything else.You can dig into that by looking at Binding Interfaces to Implementation section on the Laravel documentation.RepositoriesRepositories is a concept applicable to the MVC pattern independently from any specific framework. Typically you have your Model that is the data layer (e.g. interacts with the database directly), your Controller that handles the access logic to the data layer and your View that shows the data provided by the Controller.Repositories instead could be defined as follows:To know how to use them within Laravel please take a look at this great article.That's all, i hope it helps to clear up your mind.Interfaces are what any implementing class should call. 

Think of it like programming without bothering with logic.Now we could have passed a Bird object, or an Aeroplane object! PHP DOESN'T CARE, so long as it implements the interface!Your other question, what a Repository class is. It's just a class that keeps all your DB queries in the one place. Check this interface as an example:Hopefully this should clear things up for you! Good luck with all your PHP coding :-DLet's start with the easier one, the interface:You normally use interfaces to implement classes with required methods:

http://php.net/manual/en/language.oop5.interfaces.phpWhen Laravel is running it can check if a class implements a special interface:Since Laravel is able to work with queues it will check if the event should be queued or not by checking for an exiting interface.Repository:I didn't found that much about this:But I found some other information on a webpage:The link will give you more information about the the details.Hope I could help you :)First of all, using Repository and Interface in larger application is not only beneficiary in Laravel but in all technology for coding standard as well as for separation of concern.According to Microsoft (I found best explanation here)Why to use Repository:For Interface, you have a lot of answers above, hope you have understand.First of all, repositories and interfaces are not specific to Laravel but common coding standards in most of the languages.Below Laracasts videos will be useful to understand the basics if you don't mind spend few dollars.https://laracasts.com/lessons/repositories-and-inheritancehttps://laracasts.com/series/object-oriented-bootcamp-in-php

Laravel form model binding

eimajenthat

[Laravel form model binding](https://stackoverflow.com/questions/16873638/laravel-form-model-binding)

I've been reading about this feature: http://laravel.com/docs/html#form-model-bindingAnd it looks really neat, but there are couple of things that I'm not certain about.Do I need to put any code in the controller action to process this form?  What does that look like?The model (User) I want to bind in my form has a separate table for addresses.  So I want to be able to fill out the User model's fields, but also the fields for the related Address model.  Can I do that with form-model-binding, or do I have to handle the form manually?Or, failing that, can I use form model binding for the user fields, but manually handle the address fields?

2013-06-01 14:18:02Z

I've been reading about this feature: http://laravel.com/docs/html#form-model-bindingAnd it looks really neat, but there are couple of things that I'm not certain about.Do I need to put any code in the controller action to process this form?  What does that look like?The model (User) I want to bind in my form has a separate table for addresses.  So I want to be able to fill out the User model's fields, but also the fields for the related Address model.  Can I do that with form-model-binding, or do I have to handle the form manually?Or, failing that, can I use form model binding for the user fields, but manually handle the address fields?You don't need any different code in your controller to process this form. All your (named) form variables will be in Input::all(). The model ($user) you pass in Is just any record you need to, if you have more than one table involved, you'll have to do something likeAnd pass this composed model to your Form::model().How you name your inputs is entirely up to you, because you'll have to write the logic to process your form. But, in my opinion users_address[street] for the address inputs is good, because you'll end up with an array of addresses columns that you can pass right away to your UserAddress model.And if you do dd( Input::all() ) in your controller, you'll get something like this:

This result is provided by Kint's dd(): https://github.com/raveren/kint. Really helpful.If your form just have fields from a single Model, your update method can be very simple and look something like:On forms a little bit more complex, coders will have to add more logic to their controllers, in you case with a little bit more of research I think you can make this happen:In Laravel 5.1 for relation model binding you just need to eager load relation table(s):And in view set fields names as array:

Laravel dynamic config settings

Courtney Ball

[Laravel dynamic config settings](https://stackoverflow.com/questions/39563042/laravel-dynamic-config-settings)

I'm using a package within my project and it stores a setting inside config/packagenameI would like to dynamically change this value inside the config file, this is how the file structure looks currently;I would like to change it to something like this - Can you do this within the config file, or do you have to store some sort of variable to be updated later within a controller. Is there a way to place these variables in an env file and access these new variables from a controller?

2016-09-18 21:54:35Z

I'm using a package within my project and it stores a setting inside config/packagenameI would like to dynamically change this value inside the config file, this is how the file structure looks currently;I would like to change it to something like this - Can you do this within the config file, or do you have to store some sort of variable to be updated later within a controller. Is there a way to place these variables in an env file and access these new variables from a controller?This also is a generic solution to dynamically update your .env file (respective the individual key/value pairs)(The $delim parameter is needed if you want to make this function more generic in order to work with key=value pairs in .env where the value has to be enclosed in double quotes because they contain spaces).Admittedly, this might not be a good solution if you have multiple users at the same time using this package in your project. So it depends on what you are using this package for.NB: You need to make the function public of course if you plan to use it from other classes.All configuration files of Laravel framework stored in the app/config directory.so if we need to create custom configuration values it would be better to keep separate our custom configuration in custom file.

so we need to create custom file in app/config directory. Laravel auto read this file as a config file and will auto manage it

In this topic we are working with custom configuration in laravel and get configuration value in controller or view.Now i am going to explain how to create a custom config file in Laravel so that we can implement dynamic feature over to this.create a file in app/config/custom.php which have config keys and value like:-Now need to get these config values in view/controller so we will use Config class get() method for thisSyntax:where filename is the config file’s name, custom in our case, and key is the array key of the value you’re wanting to access.In Our case it will be as:Create run time configuration in laravel :- Configuration values which are set at run-time are will set for the current request, not be carried over to subsequent requests.Like how the @Kundan roy as suggested using of the isset() the same condition applies here to. But this one is the alternative method that will work for the dynamic setting of the values in the config.Hence by using this method you can create the dynamic config files based on the values that you need.If you want to actually edit the config files (either config/packagename.php or .env) then you may follow matthiku's answer.However, if I were you, I guess I'd rather want to configure this 3rd party package based on some value defined at runtime, instead of modifying any file (which by the way won't take effect until the next request, when the env values are read again).So, in my opinion the cleanest way to do this is::This way you can have the provider read the config values when you are about to instantiate the service, after you set any runtime config values.Use this in controller when you need to change.  You can do like this.In your custom config file. Add the following code You can send your id dynamically from the query string.To get view idSince Laravel v5.2 you can dynamically set config values this way:Actually if you are that point of code which forces you to make the config values dynamic, then there should be something wrong with your code flow, as the use of config file is just for initializing required values - which should be defined before the app is loaded.Making config values dynamic is a "BAD PRACTICE" in the world of coding.

So there is the following alternative for your problem.Define value in .env file (optional)Use value inside ControllerHope this helps you!

Laravel 5.3 date validator: equal to or after start_date

Paul Z.

[Laravel 5.3 date validator: equal to or after start_date](https://stackoverflow.com/questions/41342818/laravel-5-3-date-validator-equal-to-or-after-start-date)

I'm using Laravel 5.3 to validate start_date and end_date for an event.

end_date should be equal to start_date or the after date. end_date >= start_dateI tried to use after, but it only works for end_date > start_date.

Of course, I can add custom rule using Validator::extend, but I'd like to know if we can do without adding custom rule.Is there any way to add negative rule or add >= rule?Thanks

2016-12-27 09:50:34Z

I'm using Laravel 5.3 to validate start_date and end_date for an event.

end_date should be equal to start_date or the after date. end_date >= start_dateI tried to use after, but it only works for end_date > start_date.

Of course, I can add custom rule using Validator::extend, but I'd like to know if we can do without adding custom rule.Is there any way to add negative rule or add >= rule?ThanksUse after_or_equal Actually, you can also use after_or_equal and before_or_equal when using at least Laravel version 5.3.31. This may help to avoid having to upgrade to a higher Laravel version.upgarate to 5.4 and you can use after_or_equal

see

https://laravel.com/docs/5.4/validation#rule-after-or-equalBe careful when you set a validation rule after_or_equal:now and date_format with a format without hours, minutes or seconds!For example:Laravel passing all date fields into the strtotime() function.

Including now string.

And strtotime('now') will return a unix timestamp with current minutes, hours and seconds.For example, the today date is 2020-05-03.

When you send a date value 2020-05-03 into your script, Laravel will pass 2 values into the strtotime() for compare:And you will always fail a validation (exclude a 1 second of the day).To fix it, you should use:

Laravel 5.6 Upgrade caused Logging to break

cbloss793

[Laravel 5.6 Upgrade caused Logging to break](https://stackoverflow.com/questions/49073558/laravel-5-6-upgrade-caused-logging-to-break)

Heey!So I've recently been given the task to take a Laravel 5.2 up to 5.6. It seemed to be fine...until I tried to do a \Log::info(). Every time I run that, I get a big error, but at the end, it still prints to the log. I saw the 5.6 documentation on creating the config/logger.php. I took a fresh copy of it from github. The only thing I did after that was set an env variable for the LOG_CHANNEL to be single. Here's the error I get: I did a file comparison between Laravel 5.2 and 5.6. I'm not seeing anything that jumps out that would break the Logging functionality. Has anyone run into this with a Laravel upgrade?

2018-03-02 16:42:41Z

Heey!So I've recently been given the task to take a Laravel 5.2 up to 5.6. It seemed to be fine...until I tried to do a \Log::info(). Every time I run that, I get a big error, but at the end, it still prints to the log. I saw the 5.6 documentation on creating the config/logger.php. I took a fresh copy of it from github. The only thing I did after that was set an env variable for the LOG_CHANNEL to be single. Here's the error I get: I did a file comparison between Laravel 5.2 and 5.6. I'm not seeing anything that jumps out that would break the Logging functionality. Has anyone run into this with a Laravel upgrade?Add this file to your config folder

https://github.com/laravel/laravel/blob/develop/config/logging.phpand add this to your .env file LOG_CHANNEL=stackI was facing the same issue due to upgrade of my laravel version from 5.3 to 5.7. But after search of few mints i found the solution. 

You just need to follow the following steps.All done. Happy Coding :) I recently had the same error in my development machine (and not in the production one, oddly). In my development machine I have both php 7.1 and php 7.2 installed. Checking with phpinfo(), I discovered that 7.1 was the default version, so I decided to switch to 7.2.That didn't solve the problem (but maybe was part of it).After several hours spent on trying everything suggested around the web, I found my solution by:In detail:After this, I had no problem any more. Maybe try 0755 as permission for the storage folder. Hope this helps!I got the same problem and tried to do everything as you did but not work.Finally, I've found that it was because of cached config, just clear it and everything will be fine:After two days of some research, I found a solution on Github.If you are using Laravel 5.5.4 to Laravel 5.6.*, then you can just install and configure the exceptions package by Graham Campbell.Link: https://github.com/GrahamCampbell/Laravel-ExceptionsThis worked perfectly for me on Mac OSX (PHP 7.1.7), Laravel 5.6.22My initial error:Using emergency logger. {"exception":"[object] (InvalidArgumentException(code: 0): Log [] is not defined. at /Users/pro/Sites/metiwave/vendor/laravel/framework/src/Illuminate/Log/LogManager.php:181)use upgrade guide , and add logging.php to your config files.

A __construct on an Eloquent Laravel Model

Nathan Lochala

[A __construct on an Eloquent Laravel Model](https://stackoverflow.com/questions/30502922/a-construct-on-an-eloquent-laravel-model)

I have a custom setter that I'm running in a __construct method on my model. This is the property I'm wanting to set.My ConstructorThe setter:My problem is that inside my setter the, $this->student_id (which is an attribute of the model being pulled from the database) is returning null.

When I dd($this) from inside my setter, I notice that my #attributes:[] is an empty array.  So, a model's attributes aren't set until after __construct() is fired. How can I set my $directory attribute in my construct method?

2015-05-28 09:45:00Z

I have a custom setter that I'm running in a __construct method on my model. This is the property I'm wanting to set.My ConstructorThe setter:My problem is that inside my setter the, $this->student_id (which is an attribute of the model being pulled from the database) is returning null.

When I dd($this) from inside my setter, I notice that my #attributes:[] is an empty array.  So, a model's attributes aren't set until after __construct() is fired. How can I set my $directory attribute in my construct method?You need to change your constructor to:The first line (parent::__construct()) will run the Eloquent Model's own construct method before your code runs, which will set up all the attributes for you. Also the change to the constructor's method signature is to continue supporting the usage that Laravel expects: $model = new Post(['id' => 5, 'title' => 'My Post']);The rule of thumb really is to always remember, when extending a class, to check that you're not overriding an existing method so that it no longer runs (this is especially important with the magic __construct, __get, etc. methods). You can check the source of the original file to see if it includes the method you're defining.

How do you get the HTTP host with Laravel 5

Sean the Bean

[How do you get the HTTP host with Laravel 5](https://stackoverflow.com/questions/39835650/how-do-you-get-the-http-host-with-laravel-5)

I'm trying to get the hostname from an HTTP request using Laravel 5, including the subdomain (e.g., dev.site.com). I can't find anything about this in the docs, but I would think that should be pretty simple. Anyone know how to do this?

2016-10-03 15:54:51Z

I'm trying to get the hostname from an HTTP request using Laravel 5, including the subdomain (e.g., dev.site.com). I can't find anything about this in the docs, but I would think that should be pretty simple. Anyone know how to do this?Good news! It turns out this is actually pretty easy, although Laravel's Request documentation is a bit lacking (the method I wanted is inherited from Symfony's Request class). If you're in a controller method, you can inject the request object, which has a getHttpHost method. This provides exactly what I was looking for:From anywhere else in your code, you can still access the request object using the request helper function, so this would look like:If you want to include the http/https part of the URL, you can just use the getSchemeAndHttpHost method instead:It took a bit of digging through the source to find this, so I hope it helps!There two ways, so be careful:Example of use in blade : You can use request()->url();Also you can dump the complete request()->headers();And see if that data is useful for you.

global variable in laravel

Pars

[global variable in laravel](https://stackoverflow.com/questions/19808715/global-variable-in-laravel)

In PHP, I used to define some variables in my header.php and use them in all my pages.  How can I have something like that in Laravel?I am not talking about View::share('xx', 'xx' );Assume I want to have a variable which holds a number in it and I need this number inside all my controllers to calculate something.

2013-11-06 09:49:01Z

In PHP, I used to define some variables in my header.php and use them in all my pages.  How can I have something like that in Laravel?I am not talking about View::share('xx', 'xx' );Assume I want to have a variable which holds a number in it and I need this number inside all my controllers to calculate something.Sounds like a good candidate for a configuration file.Create a new one, let's call it calculations.php:Laravel ~4ish:Laravel 5,6,7+:Then put stuff in the new config file:Then retrieve the config in your code somewhere (note the file name becomes a "namespace" of sorts for the config item):Set a property on the BaseController, which should be located in your controllers directory.Your controllers should extend the BaseController class and thus inherit its properties.You could use View ComposersAnd instead of using the boot method described in the docs you could use:That would render whatever variables you declare with to all the views in your app.Here is a full example of how I used this in one of my projects.app/Providers/ComposerServiceProvider.phpapp/Http/ViewComposers/UserComposer.phpJust remember that because you declared a new service provider it needs to be included in the 'providers' array in config/app.php

How can I paginate a merged collection in Laravel 5?

KinsDotNet

[How can I paginate a merged collection in Laravel 5?](https://stackoverflow.com/questions/30420505/how-can-i-paginate-a-merged-collection-in-laravel-5)

I am creating a stream which contains two types of objects, BluePerson and RedPerson. To create the stream, I fetch all of both objects, then merge them into one collection. After doing so, I need to paginate them, however paginate is for eloquent models and DB queries, and not collections, it seems. I have seen a lot about manually creating a paginator, but the documentation, especially in the API is sparse (I can't even seem to find the arguments the Paginator class accepts.) How can I paginate the results of merging my collections?

2015-05-24 05:48:45Z

I am creating a stream which contains two types of objects, BluePerson and RedPerson. To create the stream, I fetch all of both objects, then merge them into one collection. After doing so, I need to paginate them, however paginate is for eloquent models and DB queries, and not collections, it seems. I have seen a lot about manually creating a paginator, but the documentation, especially in the API is sparse (I can't even seem to find the arguments the Paginator class accepts.) How can I paginate the results of merging my collections?You are right. but there is ineed a paginator function for collections. forPageRest is simple. If you want to use a LengthAwarePaginator simply instantiate one. As mentioned in the comments of a previous answer you will have to set the path for this. You will also need to make sure you resolve the "currentPage" and set the items to be returned before you instantiate the paginator. This can all be done before/on instantiation. So a function may look something like:You might try paginating both sets and merging them. You can find more information about pagination in the docs and the api. Here is an example of manually creating your own paginator...I have included the PaginationMerger class below.You can add the following code for Collection in the Providers/AppServiceProvider. Then, you can call paginate from a Collection, just like an Eloquent model. For examplebest way for paginate collection:1- add this to boot function in \app\Providers\AppServiceProvider 2-From hereafter for all collection you can paginate like your codeTry following.I had to deal with something like that in a project i was working on, where in one of the pages i had to display two type of publication paginated and sorted by the created_at field. In my case it was a Post model and an Event Model (hereinafter referred to as publications).The only difference is i didn't want to get all the publications from database then merge and sort the results, as you can imagine it would rise a performance issue if we have hundreds of publications.So i figure out that it would be more convenient to paginate each model and only then, merge and sort them.So here is what i did (based on answers and comments posted earlier)First of all let me show you a simplified version of "my solution", then i will try to explain the code as much as i could.

As you can guess it by now, the facade Paginator is the responsible of merging and sorting my paginators ($events & $posts)To make this answer a little bit more clear and complete, i will show you how to create your own Facade.You can choose to put your own facades anywhere you like, personally, i choose to put them inside Facades folder under the app folder, just like shown in this tree.Put this code inside app/Facades/Paginator.php

For more info, you can see How Facades WorkNext, bind paginator to service container, open app\Providers\AppServiceProvider.php

For more info, you can see The Boot MethodMy Paginator class is under app/Services/Pagination/ folder. Again, you can put your classes wherever you like.

Definitely there is room for improvements, so please if you see something that needs to be changed, leave a comment here or reach me on twitter.

In Laravel, how can I obtain a list of all files in a public folder?

kant312

[In Laravel, how can I obtain a list of all files in a public folder?](https://stackoverflow.com/questions/31316543/in-laravel-how-can-i-obtain-a-list-of-all-files-in-a-public-folder)

I'd like to automatically generate a list of all images in my public folder, but I cannot seem to find any object that could help me do this.The Storage class seems like a good candidate for the job, but it only allows me to search files within the storage folder, which is outside the public folder.

2015-07-09 11:47:34Z

I'd like to automatically generate a list of all images in my public folder, but I cannot seem to find any object that could help me do this.The Storage class seems like a good candidate for the job, but it only allows me to search files within the storage folder, which is outside the public folder.You could create another disk for Storage class. This would be the best solution for you in my opinion.In config/filesystems.php in the disks array add your desired folder. The public folder in this case.Then you can use Storage class to work within your public folder in the following way:The $exists variable will tell you if file.jpg exists inside the public folder because the Storage disk 'public' points to public folder of project.You can use all the Session methods from documentation, with your custom disk. Just add the disk('public') part.http://laravel.com/docs/5.0/filesystem#basic-usageStorage::disk('local')->files('optional_dir_name');or array_filter(Storage::disk('local')->files(), function ($item) {return strpos($item, 'png');});Note that laravel disk has files() and allfiles().  allfiles is recursive.Consider using glob. No need to overcomplicate barebones PHP with helper classes/methods in Laravel 5.To list all files in directory use thisTo list all images in your public dir try this:

see here btw http://php.net/manual/en/class.splfileinfo.phpPlease use the following code and get all the subdirectories of a particular folder in the public folder. When some click the folder it lists the files inside each folder.Controller FileRoute ( Web.php )Route::get('get-files/{directoryName}', 'Displaybackups\BackupController@getFiles');View files - List FoldersView - List Files

Laravel - Database, Table and Column Naming Conventions?

The Dude

[Laravel - Database, Table and Column Naming Conventions?](https://stackoverflow.com/questions/25927700/laravel-database-table-and-column-naming-conventions)

I'm using laravel eloquent data objects to access my data, what is the best way to name my tables, columns, foreign/primary keys etc?I found, there are lots of naming conventions out there. I'm just wondering which one best suits for laravel eloquent models.I'm thinking of following naming convention:So with this, I could use similar syntax in the controller.Are there any recommended Laravel guidelines for this? Can I proceed with these naming conventions?If someone has better suggestions, I will be very happy to hear them.Thanks a lot!

2014-09-19 06:31:41Z

I'm using laravel eloquent data objects to access my data, what is the best way to name my tables, columns, foreign/primary keys etc?I found, there are lots of naming conventions out there. I'm just wondering which one best suits for laravel eloquent models.I'm thinking of following naming convention:So with this, I could use similar syntax in the controller.Are there any recommended Laravel guidelines for this? Can I proceed with these naming conventions?If someone has better suggestions, I will be very happy to hear them.Thanks a lot!Laravel has it's own naming convention. For example, if your model name is User.php then Laravel expects class 'User' to be inside that file. It also expects users table for User model. However, you can override this convention by defining a table property on your model like,From Laravel official documentation:If you will use user table id in another table as a foreign key then, it should be snake-case like user_id so that it can be used automatically in case of relation. Again, you can override this convention by specifying additional arguments in relationship function. For example,Docs for Laravel eloquent relationship For other columns in table, you can name them as you like.I suggest you to go through documentation once.I don't agree in general with these examples you both have shown right on here.It is clean if you take a look at the official Laravel documentation, especially in the Eloquent's relationship session (http://laravel.com/docs/4.2/eloquent#relationships).Table names should be in plural, i.e. 'users' table for User model.And column names don't need to be in Camel Case, but Snake Case. See it is already answered: Database/model field-name convention in Laravel?It is too usual you can see it is like the RedBeanORM: the Snake Case for columns, even if you try other one. And it is adviced to avoid repeating the table names with column ones due to the method you can call from the Model object to access their relationships.The default table naming conventions can easily cause conflicts with the installation of multiple packages who may have incidentally the same class names. A solution would be to name tables as: [vendor].[package].[class], which is in line with how namespacing in Laravel is applied.  Edited: Using dots in table names is not recommended though. Would there be an alternative convention to use to ensure developers of a modular built application do not need to worry about existing table names.

Laravel 5 needs index.php using Apache virtual host

Sven van den Boogaart

[Laravel 5 needs index.php using Apache virtual host](https://stackoverflow.com/questions/30825221/laravel-5-needs-index-php-using-apache-virtual-host)

When I load pages that are not root, the page won't load without index.php before the route. The error I get:To start with I have a virtual host file containing:and a .htacces in my public with :I have another domain with the same .htaccess and appache config on the same server and it works fine. Also I did restart apache. If I use phpinfo on my index.php/route page I see at Loaded Modules:When running the website localy with xampp everything works fine.

For hours i'm trying now but I can't fix it or find any error (logs are empty) or any solutions that I haven't tried yet.Edit:Im using Ubuntu Ubuntu 14.04 x64 on a digital ocean VPS. And I tried turning it on and off again (as suggested). PHP Version 5.5.9-1ubuntu4.9. I followed this tutorial to config everything (except the direcoty part). I changed the location of the apache log and a file error.log is created on the given directory but no errors are in it.My currently appache config is : (i've triple checked the white parts where the domain name is).When I run apache2ctl -t D DUMP_VHOSTS I get this looks fine to me, also tried disabling the default config but it didnt help.Note: i've replaced my real domain with mydomain.com in reality I use my real domain on these spots.Thought how do I know for sure that the conf file im editing is the one being used by the domain?

2015-06-14 01:40:07Z

When I load pages that are not root, the page won't load without index.php before the route. The error I get:To start with I have a virtual host file containing:and a .htacces in my public with :I have another domain with the same .htaccess and appache config on the same server and it works fine. Also I did restart apache. If I use phpinfo on my index.php/route page I see at Loaded Modules:When running the website localy with xampp everything works fine.

For hours i'm trying now but I can't fix it or find any error (logs are empty) or any solutions that I haven't tried yet.Edit:Im using Ubuntu Ubuntu 14.04 x64 on a digital ocean VPS. And I tried turning it on and off again (as suggested). PHP Version 5.5.9-1ubuntu4.9. I followed this tutorial to config everything (except the direcoty part). I changed the location of the apache log and a file error.log is created on the given directory but no errors are in it.My currently appache config is : (i've triple checked the white parts where the domain name is).When I run apache2ctl -t D DUMP_VHOSTS I get this looks fine to me, also tried disabling the default config but it didnt help.Note: i've replaced my real domain with mydomain.com in reality I use my real domain on these spots.Thought how do I know for sure that the conf file im editing is the one being used by the domain?This is the correct Alternative htaccess rule for Laravel 5 suggested to use when the default doesn't work:The Options +FollowSymLinks I believe plays an important role because the DirectotyIndex acts like a symlink.Also check /app/config/app.php to make sure you haven't set the Config('app.url') to contain the index.php. If you have laravel installed in a sub-directory see this:

How can I remove "public/index.php" in the url generated laravel?Have you tried turning it all off (shutdown), and then turning it on again?If everything is as you say, it should work. I would try a restart to see if it changes anything.If it doesn't, please update with what OS you are using.I ended up deleting the complete conf file and copied it again from the one thats working. I took the default .htaccess from laravel and it worked. Unfortunately I still dont know what was wrong though. The current conf file looks likeMy .htaccess in /publicI had almost exactly the same problem today, which @dasper also helped me out on. I am using digital ocean Ubuntu 14.04 also, and I had to run the command a2enmod rewrite then reload apache2. It seemed that even though rewrite appeared to be on, it actually wasn't. First, make sure mode_rewrite is enabled.  I am sure you have probably done this but I want to make sure nothing is missed.Next, see what version of apache you are running since the syntax has changed between 2.2 and 2.4. This should not be a big deal and highly doubt this is the culprit but could save you trouble in the futureNext, try putting the rewrite condition inside of the vhost information instead of the htaccess file. This can help a little with performance as well as give you a console warn/err when restarting apache where the htaccess errors could be squelched.Beyond this point I would be at a loss without some more logging or information from the server. You can also add CustomLog into the vhost and report all requests processed by the server.The problem could be with your virtual host configuration and/or a misplaced .htaccess file.Make sure your .htaccess file is in the public/ folder and that the DocumentRoot is set to that public/ folder.And also, the < Directory> directive isn't controlling your virtual host but rather controls the folder itself and how it can be (or can't be) accessed on the server. To change the configuration of the virtual host do so inside the < VirtualHost> directive.Here is an example of a virtual host configuration:Here is the default Laravel Apache config:and here is an alternative:Try to rename the server.php in the your Laravel root folder to index.php and copy the .htaccess file from /public directory to your Laravel root folder.Solution found hereI believe your directory path is wrong. You need /public on the end because Laravel treats that directory as the web root. Try this:But the better solution is to put the contents of the .htaccess file in your virtual host. Like this:Also, you should make sure your config file is loaded by running:apache2ctl -t -D DUMP_VHOSTSThis will print a list of all the loaded vhosts. If yours isn't in that list then make sure it is enabled by running:a2ensite [name_of_your_config_file]Then restart apache with: service apache2 reloadOne more note: don't forget to edit /etc/hosts and add 127.0.0.2 yourdomain.com

How to pass a PHP variable to Vue component instance in Laravel blade?

mastercheef85

[How to pass a PHP variable to Vue component instance in Laravel blade?](https://stackoverflow.com/questions/41520258/how-to-pass-a-php-variable-to-vue-component-instance-in-laravel-blade)

How can I pass a value of a PHP variable to a Vue component in Laravel blade files?In my example, I have an inline template client-details, I get this view from Laravel so now I want to pass the id which comes with the url /client/1 to my Vue instance.My component, which is loaded by Laravel, looks like:and mounted by:I already tried like but it does not work.

2017-01-07 10:12:43Z

How can I pass a value of a PHP variable to a Vue component in Laravel blade files?In my example, I have an inline template client-details, I get this view from Laravel so now I want to pass the id which comes with the url /client/1 to my Vue instance.My component, which is loaded by Laravel, looks like:and mounted by:I already tried like but it does not work.You have to use Vue's props to be able to pass attributes to Vue's components through markup. Take a look at the following example:In your Vue component:Now in other parts of your Vue component, you can access this value as this.clientId. Issue DetailsPlease note that in HTML we write attribute name in kebab-case but in Vue side we write it in camelCase. More info in official docs here.Also, you are using Vue's v-bind shorthand in :clientId="{{ $client->id }}" which means that Vue will deal anything inside double quotes as a JavaScript expression, therefore you may get errors in that case as well. Instead, you should use this format clientId="{{ $client->id }} without a colon.I just did this and it's working great for me. Using Laravel 5.4 and Vue 2.x.In my component, declare a property (props) for the object:props: ['currentUser'],On my blade page where the component is instantiated:<my-component v-bind:current-user='{!! Auth::user()->toJson() !!}'></my-component>Note that in the component, I am using camelCase for currentUser, but because html is case-insensitive, you have to use kebab-case (thus, the 'current-user').Also note, if you use blade syntax {{  }} then the data between is run through php htmlspecialchars. if you want unencoded data (which in this case you would), then use {!! !!} For anyone who comes across this thread and is still getting errors, the answer is correctly given above by Mustafa Ehsan, but not explained. Trial and error helped me see it. My component in newuser.blade.phpIts very important to note the binding method used. On the component above, I wrote only the name of the data binding (like React props), then registered it on the component props (see below). This is how Mustafa wrote his binding in his answer, and works fine. The other, more Vue way to pass the props is with the v-bind: or :, but you have to make sure to use both double-quotes and single-quotes:Without both quotes, you get Vue warnings. AccessRequest.vue:I had to pass some server data to my Vue component, I ended up creating a $server_data variable in the controller and passing it in a json script tag.In the controller:In the template:In the vue initialisation, I put a computed property:Then, the data is accessible in the component template with server_data.some_object.This allows to pass a lot of structured data without needing many html attributes. Another benefit is that the data is escaped by the the json encoding. This avoids potential bugs with variables that contain double quotes ("), which would mess up the dom.

The Response content must be a string or object implementing __toString(), \「boolean\」given."

Alen

[The Response content must be a string or object implementing __toString(), \「boolean\」given."](https://stackoverflow.com/questions/26022390/the-response-content-must-be-a-string-or-object-implementing-tostring-boo)

I'm trying to return a rendered View using Response::json but I'm getting this error:This is my code:If I var_dump($data) I get this:This is posts.partials.loadHome view:I tested this on localhost and everything works fine. What could be the problem?

2014-09-24 16:51:38Z

I'm trying to return a rendered View using Response::json but I'm getting this error:This is my code:If I var_dump($data) I get this:This is posts.partials.loadHome view:I tested this on localhost and everything works fine. What could be the problem?Check to make sure there aren't any illegal characters. I had this issue once and ran utf8_encode on the string and that solved the issue.I ran in to this blog post and think it gives a pretty good idea for fixing it: Create the following functionTry to do the followingIn my case the error apeared also even when eliminating view variables one by one or when using another view (as suggsested by WillyBurb). So his answer was not working for me. After a long research I found out that the problem was caused by the following columns:After adding them to the $hidden property, the error was gone.from the docs:You can try this please? im return true or false (a boolean value) and not an Response value like thisthis error only happened when you return false;it means  Response::json($data) == false  .some character that json can't encode perhaps，some ASCII char (like 0x00~0x31 that can't display) in your string...so,json encode return falseAlthough this question is a bit old and your problem probably solved by now, I thought this may be relevant for others. Tl;dr: use DB::statement("SET NAMES 'UTF8'"); just before retrieving the results from the database.Your data is probably stored in a character set other than UTF-8 in the database, for instance lantin1. As an alternative for encoding the DB results in your application, you might consider letting the DB handle this. When using MySQL, you can specify the character set to communicate to the server with using SET NAMES 'charset_name'. This specifies to the server that queries are sent using this character set, and asks the server to return results using this character set. (see documentation)Laravel expects UTF-8 data. So, in this case you can issue a statement asking to communicate in UTF-8 before selecting results:If necessary, you can always switch back to another character set afterwards. That you didn't create $data = array(); and the local and remote PHP versions differ.

Laravel 5.2 : Do something after user has logged in?

夏期劇場

[Laravel 5.2 : Do something after user has logged in?](https://stackoverflow.com/questions/36491035/laravel-5-2-do-something-after-user-has-logged-in)

(I'm a beginner of Laravel)I'm using Laravel 5.2. I have successfully enabled the Authentication; by doing the php artisan make:auth and stuffs.So my login is working.Now i need to do something once someone has logged in. For an simple example:LOGIN:LOGOUT:I'm not sure whether there are (things like) hooks or Event Listeners, Event Handlers, or something like that.How can i do it please?

2016-04-08 03:31:45Z

(I'm a beginner of Laravel)I'm using Laravel 5.2. I have successfully enabled the Authentication; by doing the php artisan make:auth and stuffs.So my login is working.Now i need to do something once someone has logged in. For an simple example:LOGIN:LOGOUT:I'm not sure whether there are (things like) hooks or Event Listeners, Event Handlers, or something like that.How can i do it please?For newer versions of LaravelIf you are only doing something very simple then creating an event handler seems overkill to me. Laravel has an empty method included in the AuthenticatesUsers class for this purpose.Just place the following method inside app\Http\Controllers\LoginController (overriding it):For the post login, you can do that by modifying App/Http/Controllers/Auth/AuthController.phpAdd authenticated() into that class to override the default one:For the logout, add this function into the same class:You could try setting up event listeners for the Auth events that are fired.You can setup a listener that listens for Illuminate\Auth\Events\Login to handle what you need post login and Illuminate\Auth\Events\Logout for post logout.Laravel Docs - Authentication - EventsAlief's Answer below works fine as expected. But as i googled through, using the Event Handlers is probably the more preferred way. (It works like custom hooks).So without any less respects to Alief's Answer below, let me choose --> this Event Handers approach i just found out.Thanks all with regards!If you are testing, with authenticated(Request $request, User $user) method dont use alert inside this method to test, it will not show any result, so better put some insert query or something like that to test this method.Why not simple check forMake sure you include use Auth;

How to sort NULL values last using Eloquent in Laravel

eagle0042

[How to sort NULL values last using Eloquent in Laravel](https://stackoverflow.com/questions/17644072/how-to-sort-null-values-last-using-eloquent-in-laravel)

I've got a many to many relationship between my employees and groups table. I've created the pivot table, and all is working correctly with that. However, I've got a sortOrder column on my employees table that I use to determine the order in which they display. Employee with a value of 1 in the sortOrder column should be first, value of 2 should be second, so on. (Or backwards if sorted descending) The sortOrder column is a integer column that allows null values.I've set up my group model to sort the employees by the sort column, but I've run into a problem. The null values always are displayed first. I've tried using ISNULL and similar SQL methods in place of the regular "asc" or "desc" used, but I only get an error.Here's the code in my Group model:And here's what I use in the controller to access my model:What's the trick in Laravel to sorting NULL values last?

2013-07-14 21:42:25Z

I've got a many to many relationship between my employees and groups table. I've created the pivot table, and all is working correctly with that. However, I've got a sortOrder column on my employees table that I use to determine the order in which they display. Employee with a value of 1 in the sortOrder column should be first, value of 2 should be second, so on. (Or backwards if sorted descending) The sortOrder column is a integer column that allows null values.I've set up my group model to sort the employees by the sort column, but I've run into a problem. The null values always are displayed first. I've tried using ISNULL and similar SQL methods in place of the regular "asc" or "desc" used, but I only get an error.Here's the code in my Group model:And here's what I use in the controller to access my model:What's the trick in Laravel to sorting NULL values last?Explanation:

The IF statement solves the issue here. If NULL value is found, some big number is assigned to sortOrder instead. If found not NULL value, real value is used.Laravel does not take into consideration the ISNULL method however, you can pass it in as a raw query and still make use of it as it's more efficient than IF statements and the results will stay the same if you ever go beyond 1000000 employees (accepted answer), like so:Update:

You can also use the orderByRaw() method:Just add a minus sign to field and change order to DESC.In Laravel 5.2 or higher just call orderByRaw. You even able to sort through aggregated value rather than a column. In the following example max_st can be null if there is no submodels.Instead of relying on an arbitrary large number you can also do:It has an added benefit of being supported by SQLite.I ran into this problem recently using Laravel 5.6, where junkystu answer was perfect for me. However our testing framework uses sqlite, so tests were constantly returning a 500 error.This is what we came up with, which should be slightly more agnostic of a DB driver.AscendingDescendingA workaround for PostgreSQL For numeric types:For text types:The trick is to replace NULL values in the sorting column to zero (or empty string) so that it could be sorted as an ordinary integer (or text) value.Seems to work.

laravel 4 artisan — how to rollback to a specific migration state?

do.

[laravel 4 artisan — how to rollback to a specific migration state?](https://stackoverflow.com/questions/17697247/laravel-4-artisan-how-to-rollback-to-a-specific-migration-state)

Say i got a.php, b.php, c.php and d.php migration classes files.  How to rollback to a specific migration state, the state defined within b.php for example, with artisan command ?

2013-07-17 10:23:53Z

Say i got a.php, b.php, c.php and d.php migration classes files.  How to rollback to a specific migration state, the state defined within b.php for example, with artisan command ?I am afraid, you cannot do this directly.You can:

1, Rollback The Last Migration Operation (all migrations ran in the last batch)2, Rollback all migrations3, Rollback all migrations and run them all again  In your situation, modify b.php and it's up() method, then execute artisan migrate:refresh command.There's a way to hack it by manually editing the database. In the migrations table change the batch column by giving the last migration a different batch number. Be aware that they are in increasing order, so edit accordingly. This tracks which migrations were applied separately.Then run artisan:rollback and it will undo the last "batch".So if you want to separate them all, then start from the top and give each 1,2,3,4,5 and so on... You can see that it is easily scriptable, and you can make an artisan command if you wish to separate all your migrations.In my experience. I never do migrate:rollback. I would usually create another migration that does all the changes i need to "undo/rollback" the previous migrations.This way you can be flexible if you want to rollback 2-x steps back, you can just create a new migration to effect the changes you want and then run the new migration by php artisan migrate.In fact, there is not this feature (yet). surprisinglyThe best idea, is create a new file backtob.php and make its up call the down of your other migrate files. To avoid copy and paste, you can do something like this:As you can see, you can create the up and down calling the up and down of those migrations what you want to revert.It is not the ideal, but it is what we can do.With Laravel 5.3 there is no need for heavy scripting. As it allows to rollback given number of migrations.Here's the manual page for reference.If you really wanted to - you could write a custom function that queries the migrations table, looks for the file you are after, and works out how many times to roll back - then does a loop of 'migrate:rollback' until you reach the required migration...There is an easy yet dirty way:If you have migrations a.php, b.php and c.php and want to rollback c and b, you can simply modify a.php in such a way that there will be a syntax error... drop a semi-colon or something.So, when you run php artisan migrate:rollback it will rollback both c and b and stop with an error in a. From then on, the rollback of c and b will be considered the last migration operation.Don't forget to fix whatever error you made on purpose in a.php.Since Laravel just provide php artisan migrate:rollback to rollback your migration script, the best way to rollback your selected migration script is to create a new migration script and put the script in your down method (on your selected migration script) to the newly created migration script.

Hope this help.Use the php artisan migrate:rollback command.To see what rollback will do, use the --pretend option.You can also specify a database connection other than the default one.

laravel 4 -> get column names

Centurion

[laravel 4 -> get column names](https://stackoverflow.com/questions/19951787/laravel-4-get-column-names)

How to get column names of a table in an array or object in Laravel 4 , using Schema, DB, or Eloquent.It seems that I can't find a ready to use function, maybe you have some custom implementations.Thx.

2013-11-13 10:51:03Z

How to get column names of a table in an array or object in Laravel 4 , using Schema, DB, or Eloquent.It seems that I can't find a ready to use function, maybe you have some custom implementations.Thx.At the time I gave this answer Laravel hadn't a way to do this directly, but now you can just:Using attributes won't work because if you doYou have no attributes set to that model and you'll get nothing.Then there is still no real option for that, so I had to go down to the database level and this is my BaseModel:Use it doing:You may try Schema::getColumnListing('tablename'):Result would be something like this depending on your table:You can dig down into DB's Doctrine instance.edit: Doctrine is no longer (as of L4.1) installed by default (it's a 'suggested' rather than 'required' package), but can be added to your composer.json as doctrine/dbal to retain this functionality.I think there's a couple different options, if you are using an Eloquent model, you can look at the getAccessibleAttributes() method, which in theory would give you all the columns of a model consider Eloquent seems them as properties.For example, you'd be able to do something like this for your users table on a User Eloquent model.Another Eloquent method to look at that's similar, but doesn't have the 'accessibility' requirement is the attributesToArray() method.  The returned array of which should have your columns as a key.  Then you can use the PHP function array_keys() to build an array of the keys, which would be your columns.I know it might not be the answer for everyone, but maybe you can grab one record, and get all keys of the data. Ex.This may also be of interest:http://laravelsnippets.com/snippets/get-all-columns-names-from-a-eloquent-model-2You also can try this:I use SQL Server and the Schema way worked for me:

Laravel 4 migrate base table not found

ihkawiss

[Laravel 4 migrate base table not found](https://stackoverflow.com/questions/19265202/laravel-4-migrate-base-table-not-found)

I'm trying to make following tutorial: https://medium.com/on-coding/e8d93c9ce0e2When it comes to run:I get following error:Database connection is working, the migrations table was created successfully. Database name was changed as you can see in the error message. Whats quite strange to me, is that it tries to alter the table - which doesn't exists - and not to create it.Here are my other files, like UserModel, Seeder, Migtation and DB Config.CreateUserTable:UserModel:

    

UserSeeder:

    

DatabaseSeeder:

    

Database Config:

    

Hope somebody can give me a hint here. Best regards ihkawiss

2013-10-09 07:01:17Z

I'm trying to make following tutorial: https://medium.com/on-coding/e8d93c9ce0e2When it comes to run:I get following error:Database connection is working, the migrations table was created successfully. Database name was changed as you can see in the error message. Whats quite strange to me, is that it tries to alter the table - which doesn't exists - and not to create it.Here are my other files, like UserModel, Seeder, Migtation and DB Config.CreateUserTable:UserModel:

    

UserSeeder:

    

DatabaseSeeder:

    

Database Config:

    

Hope somebody can give me a hint here. Best regards ihkawissIn your CreateUserTable migration file, instead of Schema::table you have to use Schema::create.The Schema::table is used to alter an existing table and the Schema::create is used to create new table.Check the documentation:So your user migration will be:The underlying cause of this may be if the syntax used for creating the migration php artisan migrate ... is not quite correct.  In this case the --create will not get picked up properly and you will see the Schema::table instead of the expected Schema::create.  When a migration file is generated like this you might also be missing some of the other markers for a create migration such as the $table->increments('id'); and $table->timestamps();For example, these two commands will not create a create table migration file as you might expect:However, the command will not fail with an error. Instead laravel will create a migration file using Schema::tableI always just use the full syntax when creating a new migration file like this:to avoid any issues like this.  Sometimes it is caused by custom artisan commands. Some of these commands might initiate few classes. And because we did a rollback, the table cannot be found. Check you custom artisan commands. You can comment out the lines which are causing the trigger. Run the php artisan migrate command and then uncomment. This is what I had to do.

Laravel Eloquent: How to automatically fetch relations when serializing through toArray/toJson

Ronni Egeriis Persson

[Laravel Eloquent: How to automatically fetch relations when serializing through toArray/toJson](https://stackoverflow.com/questions/21589622/laravel-eloquent-how-to-automatically-fetch-relations-when-serializing-through)

I figures this works for automatically fetching user and replies when I am serializing my object to JSON, but is overriding toArray really the proper way of doing this?

2014-02-05 22:10:00Z

I figures this works for automatically fetching user and replies when I am serializing my object to JSON, but is overriding toArray really the proper way of doing this?Instead of overriding toArray() to load user and replies, use $with.Here's an example:Also, you should be using toArray() in your controllers, not your models, like so:Hope this helps!I must submit a new answer since I'm a SO pleb. A more proper way to accomplish this for those finding this on Google like I did would be to avoid using protected $with if you don't have to and instead move that with() call to your retrieval.And then you could modify the Post call to pre-load as needed:This way, you won't be including un-needed data every time you grab a record, if you don't need it.

Laravel how to return single column value using Query Builder

user3349495

[Laravel how to return single column value using Query Builder](https://stackoverflow.com/questions/27143961/laravel-how-to-return-single-column-value-using-query-builder)

I want to use the data from the SQL Query, to explain it further here is my code:Now I want the value of my $myquery to be USER_ID's value, I get error if I used the Above code -$myquery->user_id;

2014-11-26 08:03:50Z

I want to use the data from the SQL Query, to explain it further here is my code:Now I want the value of my $myquery to be USER_ID's value, I get error if I used the Above code -$myquery->user_id;You're trying to get property of the array, so obviously you're getting error.If you need single field only, then use pluck (which returns single value - string by default):When you need whole row, then first (which returns stdObject):And get is when you want multiple results (which returns simple array of stdObjects):That's for Laravel 5.3:This will return user_id onlyTo get only the list of value of a single column you can do like this.here $result will give you the result like this:hope it may help someoneAccording to the latest documentation: 5.6will do the trick.I think there is some confusion; but I am using Laravel 5.3 and pluck and value function is not deprecated as depicted above.For more clarification:

pluck() will be used instead of get() when you want all the values only

value() will be used instead of first() when you want only one value.use method all() to get the array of itmes. 

usage:DB::table('table_name')->select('column_na')->get();If you have data in array already and you want to filter only such kind of data, you can do this as wellby default, the returned data will be array of objects. you need to loop over it. e.g. 

BinaryFileResponse in Laravel undefined

Sebi55

[BinaryFileResponse in Laravel undefined](https://stackoverflow.com/questions/29289177/binaryfileresponse-in-laravel-undefined)

I have got the following problem:

I want to return an Image on the route /getImage/{id}

The function looks like this:When I do this it returns me this:I have got use Response; at the beginning of the controller.

I dont think that the HandleCors.php is the problem but anyway:I actually dont know why this happens since it is exactly like it is described in the Laravel Docs.

I have updated Laravel when I got the error but this did not fix it.

2015-03-26 21:25:58Z

I have got the following problem:

I want to return an Image on the route /getImage/{id}

The function looks like this:When I do this it returns me this:I have got use Response; at the beginning of the controller.

I dont think that the HandleCors.php is the problem but anyway:I actually dont know why this happens since it is exactly like it is described in the Laravel Docs.

I have updated Laravel when I got the error but this did not fix it.The problem is that you're calling ->header() on a Response object that doesn't have that function (the Symfony\Component\HttpFoundation\BinaryFileResponse class). The ->header() function is part of a trait that is used by Laravel's Response class, not the base Symfony Response.Fortunately, you have access to the headers property, so you can do this:When responding to file a request, you may not want to set headers at all on these types of requests but do on all other native response types.This can be done by checking the header method exists in the returned closure.You may want to do something else if the header method is not available on the current closure instance.

Query relationship Eloquent

Vuk Stanković

[Query relationship Eloquent](https://stackoverflow.com/questions/20036269/query-relationship-eloquent)

I have News model, and News has many comments, so I did this in News model:But I also have field trashed in comments table, and I only want to select comments that are not trashed. So trashed <> 1. So I wonder is there a way to do something like this: Is there a way to use above method or should I just write something like this: 

2013-11-17 21:15:47Z

I have News model, and News has many comments, so I did this in News model:But I also have field trashed in comments table, and I only want to select comments that are not trashed. So trashed <> 1. So I wonder is there a way to do something like this: Is there a way to use above method or should I just write something like this: Any of these should work for you, pick the one you like the most:I couldn't help but notice, though, that what you're probably trying to do is handle soft deleting, and that Laravel has built-in functionality to help you with that: http://laravel.com/docs/eloquent#soft-deletingrmobis's answer was what I needed, but it throws an error in current Laravel 5. You have to use it as an associatve array now:Took me some time to figure it out, hope this will help others.Read more in Laravel's Docs (5.6): https://laravel.com/docs/5.6/eloquent-relationships#querying-relationsYou can do simply in your eloquent model file.

do like this :call like this : 

laravel updateOrCreate method

Gammer

[laravel updateOrCreate method](https://stackoverflow.com/questions/42695943/laravel-updateorcreate-method)

I have the following code in my method which I am sending via ajax to the controller method :The dd($request->all()) gives me :which is perfect.Jquery code :Now the problem is that i have a record in my table, But the above code creates another one, And the second is that it creates multiply by two records on each button click (request). 

2017-03-09 12:54:15Z

I have the following code in my method which I am sending via ajax to the controller method :The dd($request->all()) gives me :which is perfect.Jquery code :Now the problem is that i have a record in my table, But the above code creates another one, And the second is that it creates multiply by two records on each button click (request). In your use case, you should specify a second parameter. The first indicates the conditions for a match and second is used to specify which fields to update.Here is an example from the documentation: https://laravel.com/docs/5.4/eloquentMy code is

Multi-tiered comment system Laravel

O P

[Multi-tiered comment system Laravel](https://stackoverflow.com/questions/35073613/multi-tiered-comment-system-laravel)

I'm having difficulty with blade recursive partial views. Everything works for the most part with the exception of recursion in the comment.blade.php file.I know I need to use a foreach around the @include('articles.comments.comment', $comment) to call itself again, but I'm not sure how to call for it.article_comments table:app\Article.php Class:app\Comments.php Class:app\Http\Controllers\ArticlesController.php:resources\views\articles\show.blade.phpresources\views\articles\comments\comment.blade.phpCurrent error:

2016-01-28 22:45:44Z

I'm having difficulty with blade recursive partial views. Everything works for the most part with the exception of recursion in the comment.blade.php file.I know I need to use a foreach around the @include('articles.comments.comment', $comment) to call itself again, but I'm not sure how to call for it.article_comments table:app\Article.php Class:app\Comments.php Class:app\Http\Controllers\ArticlesController.php:resources\views\articles\show.blade.phpresources\views\articles\comments\comment.blade.phpCurrent error:You're pretty close.  I think this should work:    resources\views\articles\show.blade.phpresources\views\articles\comments\comment.blade.phpapp\Http\Controllers\ArticlesController.php:First, I see that you're laying all the comments in one page without any pagination, yet, you constrain your comments() method on the Article model to only comments having parent_id=0 to get only the root comments. But, looking further at your code, in your controller, you're lazy loading comments.author and comments.children along. Note that the lazy loading will happen only for the first parent comments and after that, all the children will have to do a lot queries to get their relations by eagerly loading the relations. If you stil want to lay all the comments in one page, I suggest you remove the parent_id=0 constraint and load the comments all at once and apply a strategy to order them. Here's an example:app\Article.php app\Http\Controllers\ArticlesController.phpNow that we have our comments all sorted without penalizing the database, we can start looping through the ads. I prefer to use two files instead of one for looping so I can reuse the code later.resources\views\articles\show.blade.phpresources\views\articles\comments\container.blade.phpresources\views\articles\comments\show.blade.phpI might be missing something, but it looks to me like you have over complicated some of your code. For example, you could add a user relation to your comments model (You could also possibly remove the whole count method as well):Then whenever you need to access the user id or username of the commenter, you can just call:Then you should be able to clean up a lot of your controller:Your show.blade.php file should be just fine as is.

Your comment.blade.php file could be written this way:I believe your issue with the Invalid argument supplied for foreach() error you are getting has to do with your original query for the comments. The error should be fixed by using the proper relational models.As a side note, if you need to count your comment's children by a node column, you should be able to do something like this:I simplified it a bit but this is what I would do:Eloquent part:Controller/Route action part:View part:

Article view:Comments view:Please note that this is not very efficient if there are a lot of nested comments such as:A different way to structure this would be by by fetching all comments as once:Assuming here the default value for parent_id is 0 then in your article view you could do something like this:And in your comments view you could do something like this:Update:

Looking at how you're still stuck with this I've uploaded an example: https://github.com/rojtjo/comments-exampleMake sure check out the last commit, it shows the diff between the different methods I've used in the examples.Starting with the mysql database:Comment table structureArticle table structureYour models will be setup as such: Comments model will be polymorphic, so that you may use your comments on other sections of your application. Note: I recommend moving your models to app\models\ folder.app\Comments.php Class:app\Articles.php class:The article controller will be practically the same with the added code to eager load the comments and its children.app\Http\Controllers\ArticlesController.php:Finally, the views to display your dataresources\views\articles\show.blade.phpresources\views\articles\comments\comment.blade.phpI sort of refactored your Comments.php. You can try this:app\Comments.phpresources\views\articles\comments\comment.blade.phpresources\views\articles\show.blade.php

Dynamic urls in laravel?

Hailwood

[Dynamic urls in laravel?](https://stackoverflow.com/questions/13860162/dynamic-urls-in-laravel)

I am looking at switching to laravel for my next project.My next project is probably going to be a small site with a few static pages, a blog and a projects manager and will be using controllers not routes.What I am curious about is how I can manage dynamic routes in Laravel.Basically, I want to build in an admin section so I can easily create the static pages on the fly, and the static pages will have SEO focussed urls, e.g. http://domain.com/when-it-started I do not want to have to create a new controller or route manually for each page.So I am wondering what the cleanest way is to handle this.essentially all static pages are going to share the same view, just a few variables to change.The dynamic routing should work with the controllers not instead of.E.g. if we have a controller about with a function staff then this should be loaded via  http://domain.com/about/staffbut we dont have the function players, so a call to http://domain.com/about/players should check the database to see if a dynamic route exists and matches. If it does display that, otherwise show the 404 page. Likewise for a non-existant controller. (e.g. there would not be a when-it-started controller!)The chosen answer doesn't seem to work in Laravel 4. Any help with that?

2012-12-13 12:46:23Z

I am looking at switching to laravel for my next project.My next project is probably going to be a small site with a few static pages, a blog and a projects manager and will be using controllers not routes.What I am curious about is how I can manage dynamic routes in Laravel.Basically, I want to build in an admin section so I can easily create the static pages on the fly, and the static pages will have SEO focussed urls, e.g. http://domain.com/when-it-started I do not want to have to create a new controller or route manually for each page.So I am wondering what the cleanest way is to handle this.essentially all static pages are going to share the same view, just a few variables to change.The dynamic routing should work with the controllers not instead of.E.g. if we have a controller about with a function staff then this should be loaded via  http://domain.com/about/staffbut we dont have the function players, so a call to http://domain.com/about/players should check the database to see if a dynamic route exists and matches. If it does display that, otherwise show the 404 page. Likewise for a non-existant controller. (e.g. there would not be a when-it-started controller!)The chosen answer doesn't seem to work in Laravel 4. Any help with that?For Laravel 4 do thisYou could use the route wildcards for the job, you can start with an (:any) and if you need multiple url segments add an optional (:all?), then identify the page from the slug.For example:Very similar to Charles' answer, but in the controller:Then you can route it like this:...which has the added bonus of allowing you an easy way to link straight to the slug routes on an index page, for example:

Laravel PDOException SQLSTATE[HY000] [1049] Unknown database 'forge'

Anastasie Laurent

[Laravel PDOException SQLSTATE[HY000] [1049] Unknown database 'forge'](https://stackoverflow.com/questions/24119818/laravel-pdoexception-sqlstatehy000-1049-unknown-database-forge)

I am using Laravel to connect to MySQL database.I got this exception:and this is my config.database.phpwhy is the error referring to PDO database? and why the forge database name? I have already changed it. Should I do anything to tell Laravel that I am using MySQL database?I found this line

protected $table = 'users';

in my user.php file and I have changed it to 

protected $table = 'user'; because the table in my database is user not usersI wrote this in my Routeand I added UsersController.php in my controllers folderand inside UsersController.php I have this:and I call this url http://localhost:8082/laravel/public/users/I am using Windows 7 with Laravel 4.2Thanks in advance

2014-06-09 11:57:45Z

I am using Laravel to connect to MySQL database.I got this exception:and this is my config.database.phpwhy is the error referring to PDO database? and why the forge database name? I have already changed it. Should I do anything to tell Laravel that I am using MySQL database?I found this line

protected $table = 'users';

in my user.php file and I have changed it to 

protected $table = 'user'; because the table in my database is user not usersI wrote this in my Routeand I added UsersController.php in my controllers folderand inside UsersController.php I have this:and I call this url http://localhost:8082/laravel/public/users/I am using Windows 7 with Laravel 4.2Thanks in advanceYou have to clear the cache like that (because your old configuration is in you cache file) :The pdo error comes from the fact Laravel use the pdo driver to connect to mysqlHope your problem will get resolved.Using phpMyAdmin (or whatever you prefer), I just created a database called "forge" and re-ran the php artisan migrate command and it all worked.Sounds like you have an environment-specific config file somewhere that overrides the default database settings. Possibly app/config/local/database.php.Note: Once it happened that I accidentally had a space before my database name such as mydatabase instead of mydatabase, phpmyadmin won't show the space, but if you run it from the command line interface of mysql, such as mysql -u the_user -p then show databases, you'll be able to see the space.I had the same problem...

If you have set your DB name and username and pass correctly in .env file and its still not working run the blow code in terminal:(this will clean the caches that left from previous apps)and then run the command php artisan serve again (if you are running it stop and run it again)Encountered this issue quite a few times, note that I'm running laravel via Vagrant. So here are the fixes that work for me:You may try reloading your server instead of vagrant (ie MAMP)OK, found solution. In the file database.php, by default, it comes the "mysql" part:all you need to do is change the values :by your database name (you must create one if you dont have any) and by that database usernamelike thisMake sure you do not have a duplicated .env file in the laravel folder. If it exists, delete it. Only keep the .env file. You need to modify the name of the DB in the file .env (and if need in .env.example)

I solved my problem with this little correction.In my particular case, I finally realised that my phpMyAdmin was using port 3308 while Laravel was attempting to connect through 3306. so my advice would be to ensure you have the correct connection string!If you've used Homestead, make sure the database name in your .env file belowIs the same as the value in your Homestead.yaml file.I did all of them but didn't work, I find out should stop php artisan serve(Ctrl + C) and start php artisan serve again.Here is my response to the problem described in the question.in cmd write:then try to do this code in your terminalnote:

this will start again the serverI had this problem for several days, it turns out if I created the db inside phpMyAdmin it wouldn't appear to Laravel,

so, I created the db through MySqlWorkbench, and it worked :)sometimes its because DB_CONNECTION=mysql and you want to use SQLite database.

A solution to that is to make DB_CONNECTION=sqlite. hope it helps

Laravel, create MySQL trigger from Migration

maytham-ɯɐɥʇʎɐɯ

[Laravel, create MySQL trigger from Migration](https://stackoverflow.com/questions/27410909/laravel-create-mysql-trigger-from-migration)

I have created MySQL stored procedure from migration and it works just fine.Hereafter I tried to do the same to create MySQL trigger with following codeBut it returns error after I run php artisan migrateQuestion: What is going wrong?

2014-12-10 21:13:26Z

I have created MySQL stored procedure from migration and it works just fine.Hereafter I tried to do the same to create MySQL trigger with following codeBut it returns error after I run php artisan migrateQuestion: What is going wrong?There was issue with class naming.Correct class name could help OR do as I did, Copy your working trigger code temporary in notepad/text. Delete the old migration trigger file and generate new one.In Laravel 4In Laravel 5After it was generated I copy and paste the same Trigger code from my notepad/text and it works just fine.Here is the final working code for creating trigger through migration.it works both with RAW and UNPREPARED method.Run composer dumpautoload in the root (the same place as artisan) should make it work.In Laravel 5.5 works only with DB::unprepared() method.

How to debug php artisan serve in PHPStorm?

chemitaxis

[How to debug php artisan serve in PHPStorm?](https://stackoverflow.com/questions/32780258/how-to-debug-php-artisan-serve-in-phpstorm)

I am using PHPStorm for develop my PHP web pages. All work fine with my Apache Server, XDebug, and a simple web PHP project. No problem.But, when I try to debug a Laravel 5.1 Web Project using php artisan serve, I can't debug the breakpoints. It's like the php artisan serve use another server...And on my PHPStorm, I always see:I have configured all in PHPStorm (enabling remote debug, correct port, etc.), and with "normal" PHP projects all works fine.Can someone tell me if I need to change something?Thanks!

2015-09-25 10:32:37Z

I am using PHPStorm for develop my PHP web pages. All work fine with my Apache Server, XDebug, and a simple web PHP project. No problem.But, when I try to debug a Laravel 5.1 Web Project using php artisan serve, I can't debug the breakpoints. It's like the php artisan serve use another server...And on my PHPStorm, I always see:I have configured all in PHPStorm (enabling remote debug, correct port, etc.), and with "normal" PHP projects all works fine.Can someone tell me if I need to change something?Thanks!Debugging using php artisan serve does not work unless you have enabled debugging in ini file.@Bogdan pointed out the reason. artisan serve will call PHP Built-in Web Server but does not pass on the php command line options (named interpreter options in PHPStorm).ie if you execute from command line:Then these options given by -d are not passed to called PHP Built-in Web server. You can see the calling of build-in server here.Workaround in PHPStorm is to create Run configuration that calls PHP Build-in Web server directly. Instructions:Now the PHPStorm will execute same command as php artisan serve does with additional interpreter options. Actually the php artisan serve only purpose is to append the server.php to PHP Build-In Web Server. server.php just emulates Apache's mod_rewrite functionality. Update: Good reminder from @attila-szeremi: make sure "Start Listening for PHP Debug Connections" is enabled which you manually need to do if you don't run a PhpStorm configuration with "Debug"I don't use phpstorm, but perhaps the solution that I use for debugging in netbeans will prove useful.artisan serve uses a different ini file from the one loaded by your web containerFind this by typingOn my ubuntu box it's located at Edit the ini for your cli environment and use the same configuration you used to enable it for your web container;Example...The only caveat for this, is that as long as you have this configured, it will impact other things that you use php cli for.Additional noteIf you want your debug session to always start automatically (instead of initiating a remote debug via URL request parameter  XDEBUG_SESSION_START=name, for example, when debugging CLI stuff), you can set XDEBUG to always start a remote debugging session with this additional configuration;See https://xdebug.org/docs/allSo, after going through Jeffry's Be Awesome in PhpStorm, I had been stuck in a similar situation to the OP (in the chapter regarding Xdebug and Laravel). I was setting up the breakpoints, but PhpStorm was not able to break the execution according to those points. And, to be honest, Josh's answer here somewhat helped me to understand the problem, but was not clear enough for me. So, I went out and found the solution myself by hit and trial method, the final solution of which I want to share. May be it will come in handy for some folks still wondering.Firstly, as OP said/guessed, php artisan server does use another server. It is PHP's built in web server plus the server.php router file. And the configurations it uses are the CLI configurations. Try php --ini to find all the included configurations. In my case (Ubuntu 17.10), the Xdebug configuration file being included was from the location /etc/php/7.2/cli/conf.d/20-xdebug.ini. I added the second line to enable remote xdebug and now the file looks like this with total 2 lines:zend_extension=xdebug.so

 xdebug.remote_enable=1

Now for configuring PhpStorm:Please remember that the debugger will only work after the actual web server starts, which is the server that starts with php artisan server command.Now, start the web server ie. php artisan serve and in PhpStorm click Run > Debug 'your-debug-config', and everything should work fine!Part 1

Run > Edit Configurationschoose PHP-BuiltIn Web Server

and just set the

Host: localhost

Port: 8000 // or whichever you are usingClick OKPart 2

Install Xdebug helper Chrome extensionIn Chrome browser there should be a bug icon in top right corner

Click on it and choose Debug

so that the gray bug icon changes the color to greenNow when you run php artisan serve

and set a debug checkpointand click on phone icon to "Start listening for Xdebug connection"it should catch your debug checkpoint

create folder in laravel

user1775888

[create folder in laravel](https://stackoverflow.com/questions/21869223/create-folder-in-laravel)

I have problem let user create folder in laravel 4 through ajax request > route > controller@method.

I did test ajax success request to the url call right method.

When I use mkdir or File::mkdir($path); (is this method exist?) , I will get the response Failed to load resource: the server responded with a status of 500 (Internal Server Error) and fail to create new folder.. how to solve it ?route.phpAdminDashboardControllerjs

2014-02-19 01:37:25Z

I have problem let user create folder in laravel 4 through ajax request > route > controller@method.

I did test ajax success request to the url call right method.

When I use mkdir or File::mkdir($path); (is this method exist?) , I will get the response Failed to load resource: the server responded with a status of 500 (Internal Server Error) and fail to create new folder.. how to solve it ?route.phpAdminDashboardControllerjsNo, actually it'sAlso, you may try this:Update: Actually it does work, mkdir is being used behind the scene. This is the source:For deleting:Check the source at following path (in your local installation): Thanks to The Alpha. Your answer helped me, here is a laravel 5 way to do it for those who use the later version :This will create a directory in storage/app/path/toRetrieve the directory you just created with :There's multiple arguments you can use.You can create a directory using defaults.This will return true if directory was able to be created in the /path/to directory. The file mode of the created directory is 0777.You can specify the mode.This will return true if directory was able to be created in the /path/to directory. The file mode of the created directory will be 0775.You can also create the directories recursively.

ajax post in laravel 5 return error 500 (Internal Server Error)

Juliver Galleto

[ajax post in laravel 5 return error 500 (Internal Server Error)](https://stackoverflow.com/questions/30154489/ajax-post-in-laravel-5-return-error-500-internal-server-error)

this is my test ajax in laravel 5 (refer below)and the trigger linkand my routebut it gives me error when I run the console in google chrome and it doesnt return the expected response "return 'Success! ajax in laravel 5';"whats wrong/problem to my code? anything im missing?

2015-05-10 17:34:25Z

this is my test ajax in laravel 5 (refer below)and the trigger linkand my routebut it gives me error when I run the console in google chrome and it doesnt return the expected response "return 'Success! ajax in laravel 5';"whats wrong/problem to my code? anything im missing?While this question exists for a while, but no accepted answer is given I'd like to point you towards the solution. Because you're sending with ajax, and presumably still use the CSRF middleware, you need to provide an additional header with your request.Add a meta-tag to each page (or master layout): <meta name="csrf-token" content="{{ csrf_token() }}">And add to your javascript-file (or section within the page):See https://laravel.com/docs/master/csrf#csrf-x-csrf-token for more details.90% of the laravel ajax internal server error is due to missing CSRF token. other reasons can inlucde:You can read further about this in details here: https://abbasharoon.me/how-to-fix-laravel-ajax-500-internal-server-error/I guess this has been solved by now but still the best thing to do here is to send the token with your form and then in your ajax You can add your URLs to VerifyCsrfToken.php middleware. The URLs will be excluded from CSRF verification.In App\Http\Middleware\VerifyCsrfToken.php you could try updating the file to something like:This allows you to explicitly bypass specific routes that you do not want verified without disabling csrf validation globally.By default Laravel comes with CSRF middleware.You have 2 options:for me this error cause of different stuff.

i have two ajax call in my page.

first one for save comment and another one for save like.

in my routes.php i had this:and i got 500 internal server error for my save like ajax call.

so i change second line http request type to PUT and error goes away.

you can use PATCH too.

maybe it helps.you have to pass the csrf field through ajax please look at the code hereand you also need to write this input field before thisstill if you do not understand please enjoy this video

https://www.youtube.com/watch?v=ykXL8o0slJA&t=20sUsing post jquery instead helped me to solve this problemI have written this blog just for you guys, hope it helped you. do not forget add "use Illuminate\Http\Request;" on your controller

Required_if laravel with multiple value

Donny Akhmad Septa Utama

[Required_if laravel with multiple value](https://stackoverflow.com/questions/36274940/required-if-laravel-with-multiple-value)

I have a dropdown menu like this:I want the following in laravel:But if I select option 1, stext is still required. Why?

How can I fix it?

2016-03-29 03:36:37Z

I have a dropdown menu like this:I want the following in laravel:But if I select option 1, stext is still required. Why?

How can I fix it?I think that the require_if validation accept only one value per time.

Try to change your validation code as below:EDIT:

Check LePhleg answer, is more cleaner.

At the time of the answer that was not possible, just check the question, he was using the same method but not worked.You just have to pass all the values as parameters separated by comma:try this oneif single match value then used like thatif you have multiple value then used like that (separated by comma)for more information see documentation required_ifYou can go ahead with sometimes validation for laravel. you can define a custom closure as in the below example 

CRUD Laravel 5 how to link to destroy of Resource Controller?

xenish

[CRUD Laravel 5 how to link to destroy of Resource Controller?](https://stackoverflow.com/questions/30299202/crud-laravel-5-how-to-link-to-destroy-of-resource-controller)

I have a link         this link is supposed to direct to the destroy method of the Usercontroller , this is my route Route::resource('/user', 'BackEnd\UsersController');UserController is a  Resource Controller. But at this moment it is directing me to the show method rather than directing to the destroy method

2015-05-18 09:13:33Z

I have a link         this link is supposed to direct to the destroy method of the Usercontroller , this is my route Route::resource('/user', 'BackEnd\UsersController');UserController is a  Resource Controller. But at this moment it is directing me to the show method rather than directing to the destroy methodThis is because you are requesting the resources via GET method instead DELETE method. Look:Both routes have the same URL, but the header verb identifies which to call. Looks the RESTful table. For example, via ajax you can send a DELETE request:You need to send a DELETE request instead of a GET request. You can't do that with a link, so you have to use an AJAX request or a form.Here is the generic form method:If you're using Laravel 5.1 or later then you can use Laravel's built-in helpers to shorten your code:If you're using Laravel 5.6 or later then you can use the new Blade directives to shorten your code even further:You can read more about method spoofing in Laravel here.I use this template 'resources/views/utils/delete.blade.php'Called as this:If you're looking to do this via a regular link instead of through AJAX or another type of form request you can set up a special route that will respond to a normal GET request:In your routes, define this in addition to the resource:In your view:In your controller:If we need to use an anchor to trigger the destroy route, and we don't want to use ajax, we can put a form inside our link, and submit the form using the onclick attribute:If you really want to visit the destroy action on delete route by HTML, then there is an approach to use HTTP Method Spoofing which means that you could visit a delete HTTP method by adding a hidden input named _method with the value of `"DELETE". Same way can be used for "PUT" and "PATCH" HTTP method.Below is a sample for DELETE method.will get the routeif you use laravel collective, you can write this way in your views.If you want to use a link, you can use a library I have created that lets people make links that behave like POST, DELETE... calls.https://github.com/Patroklo/improved-linksIn case someone came here to find how to replace standard laravel form for delete, from button in it to link, you can just replace:TOJust replace button with simple <a href="#"... but with onclick attribute to submit the form!GET and DELETE Both routes have the same URL, but the header verb identifies which to call. Here are my code snippets for edit and delete. I use bootstrap modal confirmation for delete action BootStrap Modal

And Finally JS codeMy, non-ajax version. I use it in dropdowns (bootstrap) in resource list (datatables as well). Very short and universal.Global jQuery method:And then we can use everywhere something like this:Recommend: It's easy to integrate with confirms scripts for example swal.

Laravel / Intervention Image Class - class not found

Tomas Turan

[Laravel / Intervention Image Class - class not found](https://stackoverflow.com/questions/27374613/laravel-intervention-image-class-class-not-found)

I just installed Intervention Image Class following instructions from here: http://image.intervention.io/getting_started/installationI also added these 2 lines into config/app.php file:When I open my website, i get this error:Why is that and what should I do now?

2014-12-09 08:44:31Z

I just installed Intervention Image Class following instructions from here: http://image.intervention.io/getting_started/installationI also added these 2 lines into config/app.php file:When I open my website, i get this error:Why is that and what should I do now?Add "intervention/image": "dev-master" to the「require」section of your composer.json file.If you've got this warning:do $ composer update and then $ composer installopen the config/app.php file. Add this to the $providers array.Next add this to the $aliases array.If there is an error;try Try this, It works for me.solves definitively the problem.Try add \ symbol before Image:It helped for me on Laravel 5.3 and Intervention 2.3add new code "intervention/image": "dev-master"  in composer.json, and

cmd just write that on the controllerconfig/app.php 

providersAliasIn laravel 5.8 you can easily fix that error.first open config folder app.php file add providers then goto aliases and add the open the the if you want to image upload controller add theprovidersaliasesController

Can't get Laravel associate to work

Matthijn

[Can't get Laravel associate to work](https://stackoverflow.com/questions/26160661/cant-get-laravel-associate-to-work)

I'm not quite sure if I understand the associate method in Laravel. I understand the idea, but I can't seem to get it to work. With this (distilled) code:I get a Call to undefined method Illuminate\Database\Query\Builder::associate() when I try to run this.From what I can read, I do it exactly as is stated in the docs. What am I doing wrong?

2014-10-02 12:19:17Z

I'm not quite sure if I understand the associate method in Laravel. I understand the idea, but I can't seem to get it to work. With this (distilled) code:I get a Call to undefined method Illuminate\Database\Query\Builder::associate() when I try to run this.From what I can read, I do it exactly as is stated in the docs. What am I doing wrong?I have to admit that when I first started using Laravel the relationships where the part that I had to consistently refer back to the docs for and even then in some cases I didn't quite get it right.To help you along, associate() is used to update a belongsTo() relationship. Looking at your code, the returned class from $user->customer() is a hasOne relationship class and will not have the associate method on it.If you were to do it the other way round.It would work as $customer->user() is a belongsTo relationship.To do this the other way round you would first save the user model and then save the customer model to it like:Edit: It may not be necessary to save the user model first but I've just always done that, not sure why.As I understand it, ->associate() can onyl be called on a BelongsTo relationship. So, in your example, you could do $customer->user()->associate($user). However, in order to 'associate' a Has* relationship you use ->save(), so your code should be $user->customer()->save($customer)

Passing arguments to a filter - Laravel 4

AndrewMcLagan

[Passing arguments to a filter - Laravel 4](https://stackoverflow.com/questions/18249260/passing-arguments-to-a-filter-laravel-4)

Is it possible to access route parameters within a filter?e.g. I want to access the $agencyId parameter:I want to access this $agencyId parameter within my filter:Just for reference i call this filter in my controller as such:

2013-08-15 08:49:42Z

Is it possible to access route parameters within a filter?e.g. I want to access the $agencyId parameter:I want to access this $agencyId parameter within my filter:Just for reference i call this filter in my controller as such:Input::get can only retrieve GET or POST (and so on) arguments.To get route parameters, you have to grab Route object in your filter, like this :And get parameters (in your filter) :(just for fun)

In your routeyou can use in the parameters array 'before' => 'YOUR_FILTER' instead of detailing it in your constructor.The method name has changed in Laravel 4.1 to parameter. For example, in a RESTful controller:Another option is to retrieve the parameter through the Route facade, which is handy when you are outside of a route:

How to specify a different .env file for phpunit in Laravel 5?

Gnuffo1

[How to specify a different .env file for phpunit in Laravel 5?](https://stackoverflow.com/questions/31681914/how-to-specify-a-different-env-file-for-phpunit-in-laravel-5)

I have a .env file containing my database connection details, as is normal for Laravel 5. I want to override these for testing, which I can do in phpunit.xml. However, doing this seems to go against the philosophy of .env which is not to commit environmental configurations, particularly passwords.Is it possible to have something like .env.testing and tell phpunit.xml to read from that?

2015-07-28 16:18:41Z

I have a .env file containing my database connection details, as is normal for Laravel 5. I want to override these for testing, which I can do in phpunit.xml. However, doing this seems to go against the philosophy of .env which is not to commit environmental configurations, particularly passwords.Is it possible to have something like .env.testing and tell phpunit.xml to read from that?Copy your .env to .env.testing, then edit the .env.testing file and change the APP_ENV parameter to make it like this APP_ENV=testing this way you will be able to specify your settings int this new fileIn case you don't want to create a new .env.testing file you have to specify your variables in the phpunit.xml in the php section with the values you need, something like thisJust use the key values in the name section and the value of that key in the value section.For this example I am specifying phpunit to use an sqlite database with the name of testing.By the way in config/database.php I added this

'default' => env('DB_CONNECTION', 'mysql'), to use mysql by default unless I specify something diferent, as in this case.You could override the .env file being used in your TestCase file, where the framework is booted for testing.More specific:tests/TestCase.phpAll the tests extending TestCase will use this configuration file.Please note that any setting defined in phpunit.xml will override this configuration.Starting Laravel5.4, the createApplication function is no longer found in tests\TestCase. It has been moved to tests\CreatesApplication trait.This is 2019.I had this issues for so long until I was able to figure it out.And here is my assumption:If you are also finding it difficult to make your PHPUnit.xml talk with your .env.testing file, then you are likely using PHPStorm!If this is true, continue reading.If not, nope...this won't help.Ok...Here you go:What this does is to make all your changes in the xml file take effect.

So, go ahead, create the .env.testing file, create your preferred DB config variables for test...and try running your tests again!Create a local database on your dev machine, e.g. 'local_test_db'Create a new .env.testing file.Make sure your phpunit.xml file has at least this one env var:Lastly your base testcase (TestCase.php) should run a migration to populate the db with tables:From this linkMethod 1Step 1: Create New Test Database Connection on Database/Config.php as below:Step 2: Specify the Database Credential on .env fileStep 3: Specify test db conection to be used on phpunit.xml.Step 4: Migrate database to this new testing database - if you choose to use Database Transaction to Rollback insertion on the table.Step 5: Now, the Unit test with Database Transaction looks like below:Note: If you prefer not to use Database Transaction, you can use setup and teardown method on TestCase.php class to migrate and rollback the database as below:I can't think of a way other than temporarily renaming .env.testing to .env before the unit tests start.You could put some logic in bootstrap/autoload.php as this is what phpunit uses as it's bootstrap file before loading the application.In your app.php change the Dotenv sectionThis will work hence PHPUnit changes the env before loading your app..so if running tests you will have the env already at testingI did all the steps in @Sambhu Singh answer as well as followed his link.

But didn't work for me in L5.5When migrating, adding/setting APP_ENV to 'testing' in front of the artisan command worked for me:Been struggling with this for a few months now and just came across this Github issue today.

From the solutions proposed there, here's what you should do in your CreatesApplication.php file (to delete the cached config in order to have Laravel load the test environment):If you're still experiencing this issue after the above modification, you can go further by rebuilding the entire application as follows:This is working just fine for me.UpdatedFor Laravel 5.8 users, you may create a .env.testing file in the root of your project. Use a different db, like my_app_testing.So, it will be, in .env and in .env.testingThen, make config clear.Re-run the test. In my setup, it works.

Passing a class as function parameter

Alex

[Passing a class as function parameter](https://stackoverflow.com/questions/32614696/passing-a-class-as-function-parameter)

I'm trying to do something like this:Is it possible?To explain better what I'm trying to do. I have a helper function in Laravel to generate unique slugs, so I have to query different tables depending on where the slug is going to be saved.Actual code I'm trying to write:Thanks!

2015-09-16 17:09:16Z

I'm trying to do something like this:Is it possible?To explain better what I'm trying to do. I have a helper function in Laravel to generate unique slugs, so I have to query different tables depending on where the slug is going to be saved.Actual code I'm trying to write:Thanks!You can use the magic ::class constant:In PHP, classes (or class names) are handled as strings. Since PHP 5.5, you can use YourClass::class to get a fully qualified class name.

If you want to get it in an earlier version of php, you can (if you have already an object of the calss) either do the following:or, you can implement a static method in your class, like this:If you want to pass a class to a function, you can do it like this:orIf you need to call a non-static method of that class, you need to instanciate it:Note: You can use PHP type hinting with passed class names:I think you can.Send the class name as string parameter then use it like below.Send the class name as string parameter you need use the namespace. For example:

Storing an array of data using Redis (from Laravel)

Kalai

[Storing an array of data using Redis (from Laravel)](https://stackoverflow.com/questions/22718903/storing-an-array-of-data-using-redis-from-laravel)

I have started to work with laravel. It is quite interesting to work. I have started to use the features of laravel. I have started to use redis by install redis server in my system and change the configuration for redis in app/config/database.php file. The redis is working fine for the single variables by using set. i.e.,and i could able to get the value by usingBut i want to set the array by using set function. If i try do that getting the following error I have tried by using following codes.and if i use getting the following error Can any one explain me the problem and is that possible with redis?...we can set the array values using redis ?

2014-03-28 16:57:56Z

I have started to work with laravel. It is quite interesting to work. I have started to use the features of laravel. I have started to use redis by install redis server in my system and change the configuration for redis in app/config/database.php file. The redis is working fine for the single variables by using set. i.e.,and i could able to get the value by usingBut i want to set the array by using set function. If i try do that getting the following error I have tried by using following codes.and if i use getting the following error Can any one explain me the problem and is that possible with redis?...we can set the array values using redis ?This has been answered in the comments but to make the answer clearer for people visiting in the future.Redis is language agnostic so it won't recognise any datatype specific to PHP or any other language. The easiest way would be to serialise / json_encode the data on set then unserialise/json_decode on get.Example to store data using json_encode:Example to retrieve data using json_decode:In your controller, you can add such function:Then in your index method (or others) you can do this:Source: accepted answer and this.

Good single sign-on solution for Laravel

lesssugar

[Good single sign-on solution for Laravel](https://stackoverflow.com/questions/31241498/good-single-sign-on-solution-for-laravel)

I plan to introduce a single sign-on (SSO) to my Laravel 5 applications. Basically, I have two websites on different domains. The idea is simple: if I'm already authenticated on one of them, I don't need to sign in on the other.I've been looking for a solution for a while now, but I would like to ask you: Do you know or can recommend a package or library to provide SSO to Laravel application?Native PHP solutions are also welcome. Thanks!

2015-07-06 08:52:57Z

I plan to introduce a single sign-on (SSO) to my Laravel 5 applications. Basically, I have two websites on different domains. The idea is simple: if I'm already authenticated on one of them, I don't need to sign in on the other.I've been looking for a solution for a while now, but I would like to ask you: Do you know or can recommend a package or library to provide SSO to Laravel application?Native PHP solutions are also welcome. Thanks!You can use the SAML standard in order to solve your SSO needs.Review this github repository that help you implement a SAML service provider:

https://github.com/aacotroneo/laravel-saml2If you need to implement a SAML Identity provider you can use simpleSAMLphp and use Lavarel database as authentication source.

https://simplesamlphp.org/docs/stable/simplesamlphp-idpYou can try out the miniorange/saml-laravel-free package. It makes things quite simple as it also provides a GUI and also does the whole authentication thing own its own. 

Laravel: how to separate cache and session into different redis database?

Nemo Jia

[Laravel: how to separate cache and session into different redis database?](https://stackoverflow.com/questions/27835300/laravel-how-to-separate-cache-and-session-into-different-redis-database)

I want to put session and cache data into redis. This is my configuration in database.php:session.php:cache.php:However, where I write code like this:cache driver uses the same redis database as session driver does, which results in:Anyone knows how to force cache to use a specific redis connection? Or I have to mix them up together?

2015-01-08 07:50:45Z

I want to put session and cache data into redis. This is my configuration in database.php:session.php:cache.php:However, where I write code like this:cache driver uses the same redis database as session driver does, which results in:Anyone knows how to force cache to use a specific redis connection? Or I have to mix them up together?Here is my note, for some other guy who running in to this problem, I think this is should be in the docs.By default, redis gives you 16 separate databases, but laravel out of the box will try to use database 0 for both sessions and cache.Our solution is to let Redis caching using database 0, and database 1 for Session, there for solving the session clear by running php artisan cache:clear problem. Modify config/database.php, add session key to the redis option:Modify config/session.php, change the following:to:Modify .env, change SESSION_DRIVER:Execute the following artisan command, then check your login state:If the login state persists, voilà!Laravel 5 now supports this.https://github.com/laravel/framework/commit/d10a840514d122fa638eb5baa24c8eae4818da3eYou can select redis connection by modifying config/cache.phpLaravel 4 CacheManager does not support selecting redis connection.What you need to do is to modify/extend CacheManager and override createRedisDriver() method.Modify this line ToNow you can define your configuration in cache.phpLaravel 5.5: database.php should look like this:And in the session.php you have to update also the key "connection" to the right key. In this case 'session'

how to authenticate RESTful API in Laravel 5?

Vaibhav

[how to authenticate RESTful API in Laravel 5?](https://stackoverflow.com/questions/28829587/how-to-authenticate-restful-api-in-laravel-5)

How to authenticate RESTful API in Laravel 5?

I am using Laravel 5 to build a RESTful API & I want to use those API for mobile application.I have also seen http://laravel.com/docs/5.0/authentication

but not getting any related example so,please provide me sample example or appropriate link for authenticate RESTful API in Laravel 5.

2015-03-03 10:35:42Z

How to authenticate RESTful API in Laravel 5?

I am using Laravel 5 to build a RESTful API & I want to use those API for mobile application.I have also seen http://laravel.com/docs/5.0/authentication

but not getting any related example so,please provide me sample example or appropriate link for authenticate RESTful API in Laravel 5.I was looking for the same answer and I found this link very useful with detailed information and usage for L5 with the use of JWT . JSON Web TokenHope it helps you too.The Concept to use here would be Middleware:

To get you started, put this in your API-Controller's ctors:Your app should then be able to call the resources like

Get instance of subtype of a model with Eloquent

ClmentM

[Get instance of subtype of a model with Eloquent](https://stackoverflow.com/questions/60191688/get-instance-of-subtype-of-a-model-with-eloquent)

I have an Animal model, based on the animal table.This table contains a type field, that can contain values such as cat or dog.I would like to be able to create objects such as :Yet, being able to fetch an animal like this :But where $animal would be an instance of Dog or Cat depending on the type field, that I can check using instance of or that will work with type hinted methods. The reason is that 90% of the code is shared, but one can bark, and the other can meow.I know that I can do Dog::find($id), but it's not what I want : I can determine the type of the object only once it was fetched. I could also fetch the Animal, and then run find() on the right object, but this is doing two database calls, which I obviously don't want.I tried to look for a way to "manually" instantiate an Eloquent model like Dog from Animal, but I could not find any method corresponding. Any idea or method I missed please ?

2020-02-12 15:26:24Z

I have an Animal model, based on the animal table.This table contains a type field, that can contain values such as cat or dog.I would like to be able to create objects such as :Yet, being able to fetch an animal like this :But where $animal would be an instance of Dog or Cat depending on the type field, that I can check using instance of or that will work with type hinted methods. The reason is that 90% of the code is shared, but one can bark, and the other can meow.I know that I can do Dog::find($id), but it's not what I want : I can determine the type of the object only once it was fetched. I could also fetch the Animal, and then run find() on the right object, but this is doing two database calls, which I obviously don't want.I tried to look for a way to "manually" instantiate an Eloquent model like Dog from Animal, but I could not find any method corresponding. Any idea or method I missed please ?You can use the Polymorphic Relationships in Laravel as explained in Official Laravel Docs. Here is how you can do that.Define the relationships in the model as givenHere you'll need two columns in the animals table, first is animable_type and another is animable_id to determine the type of model attached to it at runtime.You can fetch the Dog or Cat model as given,After that, you can check the $anim object's class by using instanceof.This approach will help you for future expansion if you add another animal type (i.e fox or lion) in the application. It will work without changing your codebase. This is the correct way to achieve your requirement. However, there is no alternative approach to achieve polymorphism and eager loading together without using a polymorphic relationship. If you don't use a Polymorphic relationship, you'll end up with more then one database call. However, if you have a single column that differentiates the modal type, maybe you have a wrong structured schema. I suggest you improve that if you want to simplify it for future development as well. Rewriting the model's internal newInstance() and newFromBuilder() isn't a good/recommended way and you have to rework on it once you'll get the update from framework.If you really want to do this, you could use the following approach inside your Animal model.As the OP stated inside his comments: The database design is already set and therefore Laravel's Polymorphic Relationships seems not to be an option here.I like the answer of Chris Neal because I had to do something similar recently (writing my own Database Driver to support Eloquent for dbase/DBF files) and gained a lot experience with the internals of Laravel's Eloquent ORM.I've added my personal flavour to it to make the code more dynamic while keeping an explicit mapping per model.Supported features which I quickly tested:Disadvantages:I hope it helps and I'm up for any suggestions, questions and additional use-cases in your scenario. Here are the use-cases and examples for it: And this is an example of how it can be used and below the respective results for it:which results the following:And in case you want you use the MorphTrait here is of course the full code for it: I think you could override the newInstance method on the Animal model, and check the type from the attributes and then init the corresponding model.You'll also need to override the newFromBuilder method.I think I know what you're looking for. Consider this elegant solution which uses Laravel query scopes, see https://laravel.com/docs/6.x/eloquent#query-scopes for additional information:(same applies to another class Cat, just replace the constant)The global query scope acts as a default query modification, such that the Dog class will always look for records with type='dog'.Say we have 3 records:Now calling Dog::find(1) would result in null, because the default query scope will not find the id:1 which is a Cat. Calling Animal::find(1) and Cat::find(1) will both work, although only the last one gives you an actual Cat object.The nice thing of this setup is that you can use the classes above to create relations like:And this relation will automatically only give you all the animals with the type='dog' (in the form of Dog classes). The query scope is automatically applied.In addition, calling Dog::create($properties) will automatically set the type to 'dog' due to the saving event hook (see https://laravel.com/docs/6.x/eloquent#events).Note that calling Animal::create($properties) does not have a default type so here you need to set that manually (which is to be expected).Although you are using Laravel, in this case, I think you should not stick to Laravel short-cuts.This problem you are trying to solve is a classic problem that many other languages/frameworks solve using Factory method pattern (https://en.wikipedia.org/wiki/Factory_method_pattern).If you want to have your code easier to understand and with no hidden tricks, you should use a well-known pattern instead of hidden/magic tricks under the hood.The easiest way yet is to make method in Animal classResolving modelThis will return instance of class Animal, Dog or Cat depending on model type

(Laravel) Dynamic dependency injection for interface, based on user input

JuanDMeGon

[(Laravel) Dynamic dependency injection for interface, based on user input](https://stackoverflow.com/questions/36853791/laravel-dynamic-dependency-injection-for-interface-based-on-user-input)

I am currently facing a very interesting dilemma with my architecture and implementation.I have an interface called ServiceInterface which have a method called execute()Then I have two different implementations for this interface: Service1 and Service2, which implements the execute method properly.I have a controller called MainController and this controller has a "type-hint" for the ServiceInterface (dependency injection), it means that both, Service1 and Service2, can be called as resolution for that dependency injection.Now the fun part:I do not know which of those implementations to use (Service1 or Service2) because I just know if I can use one or other based on a user input from a previous step.It means the user choose a service and based on that value I know if a can use Service1 or Service2.I am currently solving the dependency injection using a session value, so depending of the value I return an instance or other, BUT I really think that it is not a good way to do it.Please, let me know if you faced something similar and, how do you solve it, or what can I do to achieve this in the right way.Thanks in advance. Please let me know if further information is required.

2016-04-26 01:24:05Z

I am currently facing a very interesting dilemma with my architecture and implementation.I have an interface called ServiceInterface which have a method called execute()Then I have two different implementations for this interface: Service1 and Service2, which implements the execute method properly.I have a controller called MainController and this controller has a "type-hint" for the ServiceInterface (dependency injection), it means that both, Service1 and Service2, can be called as resolution for that dependency injection.Now the fun part:I do not know which of those implementations to use (Service1 or Service2) because I just know if I can use one or other based on a user input from a previous step.It means the user choose a service and based on that value I know if a can use Service1 or Service2.I am currently solving the dependency injection using a session value, so depending of the value I return an instance or other, BUT I really think that it is not a good way to do it.Please, let me know if you faced something similar and, how do you solve it, or what can I do to achieve this in the right way.Thanks in advance. Please let me know if further information is required.Finally after some days researching and thinking alot about the best approach for this, using Laravel I finally solved.I have to say that this was specially difficult in Laravel 5.2, because in this version the Session middleware only is executed in the controllers used in a route, it means that if for some reason I used a controller (not linked for a rote) and try to get access to the session it is not going to be possible.So, because I can not use the session I decided to use URL parameters, here you have the solution approach, I hope some of you found it useful.so, you have an interface:Then a couple of implementations for the interface:The service one:The service two.Now the interesting part: have a controller with a function that have a dependency with the Service interface BUT I need to resolve it dinamically to ServiceOne or ServiceTwo based in a use input. So:The controllerPlease note that ServiceRequest, validated that the request already have the parameter that we need to resolve the dependency (call it 'service_name')Now, in the AppServiceProvider we can resolve the dependency in this way:So now all the responsibilty is for the Resolver class, this class basically use the parameter passed to the contructor to return the fullname (with namespace) of the class that is going to be used as a implementation of the Service interface:Well, I really hope it help to some of you.Best wishes!---------- EDIT -----------I just realize, that it is not a good idea to use directly the request data, inside the container of Laravel, it really is going to make some trouble in the long term.The best way is to directly register all the possible instances suported (serviceone and servicetwo) and then resolve one of them directly from a controller or a middleware, so then is the controller "who  decides" what service to use (from all the available) based on the input from the request.At the end it works at the same, but it is going to allow you to work in a more natural way.I have to say thanks to rizqi. A user from the questions channel of the slack chat of Laravel.He personally created a golden article about this. Please read it because solve this issue completely and in a very right way.laravel registry patternThe fact that you define that your controller works with ServiceInterface is okIf you have to choose the concrete implementation of the service basing on a previous step  (that, as i've understood, happens in a previous request) storing the value in session or in database is right too, as you have no alternative: to choose the implementation you have to know the value of the inputThe important point is to 'isolate' the resolution of the concrete implementation from the input value in one place: for example create a method that takes this value as a parameter and returns the concrete implementation of the service from the value:and in your controller:In this example i've used a different class to store the method, but you can place the method in the controller or use a Simple Factory pattern, depending on where the service should be resolved in your applicationIt's an interesting problem. I'm currently using Laravel 5.5 and have been mulling it over. I also want my service provider to return a specific class (implementing an interface) based upon user input. I think it's better to manually pass the input from the controller so it's easier to see what's going on. I would also store the possible values of the class names in the config.

So based upon the Service classes and interface you've defined above i came up with this:/config/services.php/app/Http/Controllers/MainController.php/app/Http/Requests/ServiceRequest.php/app/Providers/CustomServiceProvider.phpThis way we can validate the input to ensure we are passing a valid service, then the controller handles passing the input from the Request object into the ServiceProvider. I just think when it comes to maintaining this code it will be clear what is going on as opposed to using the request object directly in the ServiceProvider.

PS Remember to register the CustomServiceProvider!I find the best way to deal with this is using a factory pattern. You can create a class say ServiceFactory and it has a single method create() it can accept an argument which is used to dynamically choose which concrete class to instantiate.It has a case statement based on the argument. It will use App::make(ServiceOne::class) or App::make(ServiceTwo::class).depending on which one is required. You are then able to inject this into your controller (or service which depends on the factory). You can then mock it in a service unit test.

Laravel eloquent get relation count

Vincent Decaux

[Laravel eloquent get relation count](https://stackoverflow.com/questions/41165726/laravel-eloquent-get-relation-count)

I use Laravel 5.3. I have 2 tables :AndI have defined my relations in my models : Is there an easy way using Eloquent to have a list a categories with count of articles. The difficulty is that I want to group categories where id_parent = 0, i.e. I want to display only parent categories with count of articles in children.I tried something like that :But I am lost...

2016-12-15 13:45:52Z

I use Laravel 5.3. I have 2 tables :AndI have defined my relations in my models : Is there an easy way using Eloquent to have a list a categories with count of articles. The difficulty is that I want to group categories where id_parent = 0, i.e. I want to display only parent categories with count of articles in children.I tried something like that :But I am lost...you can use withCount(). It is available from 5.3 versionfor more info about eloquent visit : https://laravel.com/docs/5.3/eloquent-relationshipsYou can use the hasManyThrough() Eloquent method to fetch all of the childrens' Articles, then add the article counts together in a nice little getter. I added the getter to the $appends array on the model to help illustrate it in the Tinker output.Here's the Tinker output:If you want to restrict your Category query to ones that have children that have articles, you could do that using the has() method:Here's more on the has() method:https://laravel.com/docs/5.3/eloquent-relationships#querying-relationship-existenceAnd the hasManyThrough() method:https://laravel.com/docs/5.3/eloquent-relationships#has-many-throughDefine a articles() relation in your Category model as:Then you can try it as:This should work:The above query will get you category IDs and count of all articles that belong to the category.After reading your question and comments again, if I understand correctly you want to get the count of all articles that belong to those categories (with parent_id = 0) + the count of articles that belong to sub categories (those with parent_id = (id of some category)).Now I have no way of testing this easily, but I think something along these lines should work for that.That beign said, I think you're better of having a column named count in categories and update it each time a new article gets added. For performance.I am sure somebody is still going through this, I was able to solve it the following way, suppose I have an Agent model and a Schedule model, i.e. one agent may have many schedules:Well some agents may not necessarily have schedules assigned, thus, I filtered those before calling the with() method, like this:Hope this helps!.

How to break a foreach loop in laravel blade view?

Sagar Gautam

[How to break a foreach loop in laravel blade view?](https://stackoverflow.com/questions/45189524/how-to-break-a-foreach-loop-in-laravel-blade-view)

I have a loop like this:I want to break the loop after data display if condition is satisfied.How it can be achieved in laravel blade view ?

2017-07-19 11:43:20Z

I have a loop like this:I want to break the loop after data display if condition is satisfied.How it can be achieved in laravel blade view ?From the Blade docs:By default, blade doesn't have @break and @continue which are useful to have. So that's included.Furthermore, the $loop variable is introduced inside loops, (almost) exactly like Twig.you can break like this   

Laravel: Difference Between Route Middleware and Policy

James Okpe George

[Laravel: Difference Between Route Middleware and Policy](https://stackoverflow.com/questions/35019292/laravel-difference-between-route-middleware-and-policy)

I am developing an app with laravel, I realised that what can be done with Policy can exactly be done with Middleware. Say I want to prevent a user from updating a route if he/she is not the owner of the information, I can easily check from the route and can do the same from the policy.So my question is why should I use policy over middleware and vice versa

2016-01-26 16:50:45Z

I am developing an app with laravel, I realised that what can be done with Policy can exactly be done with Middleware. Say I want to prevent a user from updating a route if he/she is not the owner of the information, I can easily check from the route and can do the same from the policy.So my question is why should I use policy over middleware and vice versaI'm currently going through a small refactor with my roles, permissions and routes and asked myself the same question. At the surface level, it appears true middleware and policies perform the same general idea. Check if a user can do what they are doing.For reference here's the laravel docs...Middleware 

"May I see this? May I go here?"https://laravel.com/docs/master/middleware#introductionIn my reading, Middleware is about operating at the request level. In the terms of "Can this user see a page?", or "Can this user do something here?" If so, it goes to the controller method associated with that page. Interestingly enough, Middleware may say, "Yes you may go there, but I'll write down that you are going." Etc.Once it's done. It has no more control or say in what the user is doing. Another way I think of it as the middleperson. Policies 

"Can I do this? Can I change this?"https://laravel.com/docs/master/authorization#introductionPolicies however, appear to be more concerned with doing. Can the user update any entry, or only theirs?These questions seem fit for a controller method where all the calls to action on a resource are organized. Retrieve this object, store or update the article. As tjbb mentioned, middleware can make routes very messy and hard to manage. This is an example from my routes file:The problemThis gets very hard to read in my route file!Another approach with policiesRoute middleware allows you to apply request handling to a large range of routes, instead of repeating the code in every controller action - checking authentication and redirecting guests is a good example. Controllers instead contain logic unique to specific routes/actions - you could use middleware for this, but you'd need separate middleware for every route's logic and it would all get very messy.Policies/abilities are simply a way of checking user permissions - you can query them from a controller, or from middleware, or anywhere else. They only return true or false, so they aren't equivalent to controllers or middleware. Most of the time abilities will be comparing a user to another model, which will have been loaded based on an identifier sent to a controller action, but there are probably some applications for use with middleware too.

Guzzle: handle 400 bad request

mwafi

[Guzzle: handle 400 bad request](https://stackoverflow.com/questions/25040436/guzzle-handle-400-bad-request)

I'm using Guzzle in Laravel 4 to return some data from another server, but I can't handle Error 400 bad requestusing:how to solve it?

thanks,

2014-07-30 15:10:07Z

I'm using Guzzle in Laravel 4 to return some data from another server, but I can't handle Error 400 bad requestusing:how to solve it?

thanks,As written in Guzzle official documentation: http://guzzle.readthedocs.org/en/latest/quickstart.htmlFor correct error handling I would use this code:Use http_errors => false option with the request.

Is there any way to validate a foreign key using Laravel's Validation syntax?

ReactingToAngularVues

[Is there any way to validate a foreign key using Laravel's Validation syntax?](https://stackoverflow.com/questions/29611807/is-there-any-way-to-validate-a-foreign-key-using-laravels-validation-syntax)

Say I have an object which relates to a mission. Users can upload objects and say that it has a relationship with one of these missions. Is there anyway to check that the mission_id that the user has selected for this object actually exists in this database using Laravel's Validation class and rules?This way, I can check that mission_id is not only an integer, but also exists in the database.For example, I guess I'm looking for something like:Where foreignKeyExistsInMissions is the validation rule I'm looking for. 

2015-04-13 17:51:51Z

Say I have an object which relates to a mission. Users can upload objects and say that it has a relationship with one of these missions. Is there anyway to check that the mission_id that the user has selected for this object actually exists in this database using Laravel's Validation class and rules?This way, I can check that mission_id is not only an integer, but also exists in the database.For example, I guess I'm looking for something like:Where foreignKeyExistsInMissions is the validation rule I'm looking for. This should work:And the message:Source (v4.2 docs)Source (v5.5 docs)

Laravel 5.3 Storage::put creates a directory with the file name

zundi

[Laravel 5.3 Storage::put creates a directory with the file name](https://stackoverflow.com/questions/40002275/laravel-5-3-storageput-creates-a-directory-with-the-file-name)

I'm using Laravel's file storage functionality to save a file:This does save the file, but inside a directory named the same as the file, for example:storage/app/952d6c009.jpg/952d6c009.jpgorstorage/app/234234234.jpg/234234234.jpgIs this expected? Is there any way to just store the file without a separate directory for each file?Thanks!

2016-10-12 15:16:43Z

I'm using Laravel's file storage functionality to save a file:This does save the file, but inside a directory named the same as the file, for example:storage/app/952d6c009.jpg/952d6c009.jpgorstorage/app/234234234.jpg/234234234.jpgIs this expected? Is there any way to just store the file without a separate directory for each file?Thanks!you need to provide the file contents in the second argument not file object, try this:Storage::disk('local')->put($newFilename, file_get_contents($file));This happened because you specify the directory to store as filename. The newFilename, should be the directory name such as 'images'. Refer to this lineSo you could change this toThen you will get the path stored at storage/app/images/234234234.jpg$file is encoded.You have to unencode the file.Storage::disk('local')->put($newFilename, File::get($file));

Read file contents with Laravel

Cheskq

[Read file contents with Laravel](https://stackoverflow.com/questions/26730861/read-file-contents-with-laravel)

I am trying to read the contents of a file line by line with Laravel.

However, I can't seem to find anything about it anywhere.Should I use the fopen function or can I do it with the File::get() function?I've checked the API but there doesn't seem to have a function to read the contents of the file.

2014-11-04 08:43:38Z

I am trying to read the contents of a file line by line with Laravel.

