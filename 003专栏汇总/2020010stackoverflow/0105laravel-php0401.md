However, I can't seem to find anything about it anywhere.Should I use the fopen function or can I do it with the File::get() function?I've checked the API but there doesn't seem to have a function to read the contents of the file.You can use simple PHP:You can use the following to get the contents:Which will return a Illuminate\Filesystem\FileNotFoundException if it's not found. If you want to fetch something remote you can use: Which will return false if not found. When you have the file you don't need laravel specific methods for handling the data. Now you need to work with the content in php. If you wan't to read the lines you can do it like @kylek described: You can use

if else condition in blade file (laravel 5.3)

user3386779

[if else condition in blade file (laravel 5.3)](https://stackoverflow.com/questions/40122633/if-else-condition-in-blade-file-laravel-5-3)

I want to check if else condition in my blade file.

 I want to check $user->status =='waiting' as code given below.output return correctly what I expect.But along with my output I caught curly braces {} printed above.I to remove curly brace.Is anything wrong in my if condition

2016-10-19 05:11:17Z

I want to check if else condition in my blade file.

 I want to check $user->status =='waiting' as code given below.output return correctly what I expect.But along with my output I caught curly braces {} printed above.I to remove curly brace.Is anything wrong in my if conditionNo curly braces required you can directly writeI think you are putting one too many curly brackets. Try this

best way for managing uploaded files in my editor?

k90mirzaei

[best way for managing uploaded files in my editor?](https://stackoverflow.com/questions/52734396/best-way-for-managing-uploaded-files-in-my-editor)

I'm working on a social blog that has an editor built in JavaScript for creating a blog by a user. One of my biggest issues is uploading files and its limitations. Right now for auto-saving user posts, I store images uploaded simultaneously to the server. But the problem is when the user deletes images from the editor because:My editor is a customized version of ckeditor5, and for uploading files, I use an uploadadapter like :

2018-10-10 06:59:00Z

I'm working on a social blog that has an editor built in JavaScript for creating a blog by a user. One of my biggest issues is uploading files and its limitations. Right now for auto-saving user posts, I store images uploaded simultaneously to the server. But the problem is when the user deletes images from the editor because:My editor is a customized version of ckeditor5, and for uploading files, I use an uploadadapter like :IMHO first you should define your goals, then search for the solution.Managing images removed from the content can be tricky depending on the needs. For example, if you want to keep track changes and allow users to re-use uploaded images in other posts - before removing any image from the storage you should check all posts and all versions if they do not contain this image anymore. OTOH if you don't care about versions and do not allow users to re-use images - then you can remove any image just after it's removed from the content.Nowadays storage is cheap, so I wouldn't bother that much about keeping some extra images that are not used anymore. And what's more important - I wouldn't add the clean-up to the main flow. Rather than that - create a dedicated, repeated job for scanning the content and removing unused images. To make it more robust I would save the image usages in some kind of database. This way it would be much easier to perform the clean-up.There are out-of-the-box paid solutions like EasyImage (upload, re-scale and optimize images to the CDN), or CKFinder (fully-featured file manager).Although, depending on your needs you may need to tune those solutions anyway. For example, if you have a file manager then maybe you would like to block deleting files if they are used anywhere. So additional work on some plugin might be needed.Steps i followed when i inserting images with other contents:Collected all the images from editor Here i receiving the images as base64. thats why i needed to decode them and store separately When i delete or update the content i just remove all the images which i received in $imagePaths array previously and stored.When i worked on this, i followed this documentationHere i shared full controller script.I used the below to embed the images as base64 instead of uploading themIt seems like that you just need an extra hidden input which records all uploaded successfully images and do a little compare with the image`s urls in the editor after user posted the form, and then you will get the image list to be deleted.

I wish I had expressed my mean clearly.

Random RuntimeException: The only supported ciphers are AES-128-CBC and AES-256-CBC with the correct key length

Raul

[Random RuntimeException: The only supported ciphers are AES-128-CBC and AES-256-CBC with the correct key length](https://stackoverflow.com/questions/41551622/random-runtimeexception-the-only-supported-ciphers-are-aes-128-cbc-and-aes-256)

I have same problem with Laravel 5.3 (on windows server). I did all possible attempts: checked .env file, config, artisan new key generation, cache: clear, config: clear, composer update, but the problem randomly persists.Note that the same code with exactly same version of apache, mysql, php, doesn't generate this problem on Mac OS.I found that the key (first parameter of Encrypter constractor) arrives "sometimes" empty and of course it fails. Most of the times the key is correct, but randomly the key arrives empty from EncryptionServiceProvider that in turns asks it to the app config.So the only solution that worked for me was to add an if ($key) in EncryptionServiceProvider so that the Encryption constructor doesn't get called with empty key.Of course is not a "clean" solution nor it explains the problem, but at least avoids to find the log file filled with the error: If this is a Laravel bug I don't know, but of course if someone could explain this I will be more then happy to know.Below is my modified class: I just added the if ($key) line before new Encrypter:Further details and backtrace log:Of course, as I wrote I checked, .env file, config, artisan new key generation, cache: clear, config: clear, composer update.

This stuff is ok since it works 99% of the time but randomly I get the error.Here the back trace:Stack trace:

2017-01-09 15:44:08Z

I have same problem with Laravel 5.3 (on windows server). I did all possible attempts: checked .env file, config, artisan new key generation, cache: clear, config: clear, composer update, but the problem randomly persists.Note that the same code with exactly same version of apache, mysql, php, doesn't generate this problem on Mac OS.I found that the key (first parameter of Encrypter constractor) arrives "sometimes" empty and of course it fails. Most of the times the key is correct, but randomly the key arrives empty from EncryptionServiceProvider that in turns asks it to the app config.So the only solution that worked for me was to add an if ($key) in EncryptionServiceProvider so that the Encryption constructor doesn't get called with empty key.Of course is not a "clean" solution nor it explains the problem, but at least avoids to find the log file filled with the error: If this is a Laravel bug I don't know, but of course if someone could explain this I will be more then happy to know.Below is my modified class: I just added the if ($key) line before new Encrypter:Further details and backtrace log:Of course, as I wrote I checked, .env file, config, artisan new key generation, cache: clear, config: clear, composer update.

This stuff is ok since it works 99% of the time but randomly I get the error.Here the back trace:Stack trace:The issue occurs when using thread-safe versions of PHP on multi-threaded web servers, instead of multi-process web servers. You can read about the issue a little more on the Github issue here, Github issue here, and a PHP bug report here. There are a few more links, but they are just branched off from those few I posted.The basic gist is that with the multi-threaded web server, you have a single process that handles multiple threads. However, the putenv()/getenv() methods are not thread safe, and change environment variables at the process level, so all threads under that process are affected.So, you end up with something like this: (as described in this issue):So, request 1 comes in, loads the environment fine, and gets to work. While request 1 is working, request 2 comes in and starts on another thread. Before request 2 reads the environment variables, request 1 finishes and PHP clears out all variables set by putenv(). Now, request 2 attempts to read the environment, but gets null because the variables were cleared when request 1 finished.This issue can be mitigated in two ways:I installed Laravel 5.3 and I didn't found a .env file there. And boom.... That was the issue. I created .env file in root of application and ran in terminal and it generated base 64 encoded string in terminal. Copy that string in to .env file aswhere **** is generated encoded string. Run application again and it should work.It is so simple, copy the APP_KEY from .env file to config/app.php -> key or run command below:php artisan key:generate

403 Forbidden on nginx/1.4.6 (Ubuntu) - Laravel

cyber8200

[403 Forbidden on nginx/1.4.6 (Ubuntu) - Laravel](https://stackoverflow.com/questions/33443918/403-forbidden-on-nginx-1-4-6-ubuntu-laravel)

I keep getting 403 ForbiddenMy settings:/etc/nginx/sites-available/defaultdefaultUpdateI followed this instruction : here Any hints/suggestions on this will be a huge help ! 

2015-10-30 19:53:55Z

I keep getting 403 ForbiddenMy settings:/etc/nginx/sites-available/defaultdefaultUpdateI followed this instruction : here Any hints/suggestions on this will be a huge help ! You need to specify an absolute path for your root directive. Nginx uses the directory set at compile time using the --prefix switch. By default this is /usr/local/nginx.What this means is that your root, which is currently set to root home/laravel-app/ causes nginx to look for files at /usr/local/nginx/home/laravel-app/ which presumably isn't where your files are.If you set your root directive to an absolute path such as /var/www/laravel-app/public/ nginx will find the files.Similarly you'll note that I added /public/ to the path above. This is because Laravel stores it's index.php file there. If you were to just point at /laravel-app/ there's no index file and it'd give you a 403.you need to have a rule for php files (in the default file)The error you added in your update indicates that nginx is attempting a directory index from your ssc-portal folder. Since you appear to be using a basic nginx installation, the only reason a directory index should fail here is if nginx is unable to find the listed index options.In your server block, you are telling nginx to try the following locations in order when a directory listing is requested (a URI that ends with a trailing slash): index.php, index.html, then index.htm.If none of those files is found, the directory index request fails.My best guess is you have your index.php file in the wrong place. Did you move it up from the ssc-portal folder?

Rate limiting yourself from overloading external API's

williamvicary

[Rate limiting yourself from overloading external API's](https://stackoverflow.com/questions/31195934/rate-limiting-yourself-from-overloading-external-apis)

I found a lot of information and script examples around that showed how to rate limit the users of an API but I wasn't able to find any examples of how to rate limit your own requests of an API when these limits are imposed.I've always rate limited my scripts with code such as sleep or usleep commands but it feels like an inefficient way of doing things, especially when the API endpoints have pretty high rate limits and hammering API's until you hit the limits is also inefficient.For example, Google's API limits vary based on the API you are using and can increase/decrease, in this case a fixed rate limit hard coded into the code just seems like primitive guess work!Have I missed something pretty obvious? Or is this just not as common as I expect it to be?

2015-07-02 22:56:27Z

I found a lot of information and script examples around that showed how to rate limit the users of an API but I wasn't able to find any examples of how to rate limit your own requests of an API when these limits are imposed.I've always rate limited my scripts with code such as sleep or usleep commands but it feels like an inefficient way of doing things, especially when the API endpoints have pretty high rate limits and hammering API's until you hit the limits is also inefficient.For example, Google's API limits vary based on the API you are using and can increase/decrease, in this case a fixed rate limit hard coded into the code just seems like primitive guess work!Have I missed something pretty obvious? Or is this just not as common as I expect it to be?Okay, for giggles I've thrown together a limiter class that will allow you to specify the limit per second, minute and hour.  I can't resist having a good reason to use a circular queue!If you have multiple processes doing the consumption, whether simultaneous or not, you'll have to devise a way to store and/or share the usage history on your own.In order to demonstrate it in action I've put in some "verbose mode" statements in the limit checking function.  Here is some sample output.Well, first things first - you should call any external API's only when you actually need to - the providers will thank you dearly.There is two ways I usually "impose" a limit on my own API usage - if possible, cache the result for N amount of time, usually a lot less than hard limit of the API itself. This, however, works only in very specific cases.The second is persistent/semi-persistent counters, where you store a counter in some sort of memory backend along with time when the limiting period begins. Every time before calling API check the storage and see whether the current time minus interval begin and number of requests you have already made is less than imposed by API. If it is, you can make a request - if the interval is larger, you can reset the limit, and if your next request will exceed the limit, and you are still in the previous interval, you can show a pretty error. On each external request then update the interval time if it's exceeded and increment the counter.I think we can not answer your question in a few sentences . It takes a true reflection of architecture linked to your application . For me to make an API rate limit for repeat I use caches that store values ​​and utilization of my API. I have to date found no code ready .

「There are no commands defined in the 'command' namespace.」after running command:make in Laravel

Zbigniew Kisły

[「There are no commands defined in the 'command' namespace.」after running command:make in Laravel](https://stackoverflow.com/questions/32396158/there-are-no-commands-defined-in-the-command-namespace-after-running-comman)

Just like in title. I'm trying to run from artisanbut all I see isAny idea what is this?

2015-09-04 10:45:58Z

Just like in title. I'm trying to run from artisanbut all I see isAny idea what is this?You have misplaced the command it isand not If you have simply write php artisan within your command prompt it'll show you the list of commands over there have a lookAs the documentation says (Current version is 5.2 at this moment): in the Kernel.php file you must add:

    protected $commands = [

      Commands\NameOfCommand::class

    ];

(ref: https://laravel.com/docs/5.2/artisan#registering-commands)In laravel 5.2 use php artisan make:console NameOfCommand

How to format PHP files with HTML markup in Visual Studio Code?

progonkpa

[How to format PHP files with HTML markup in Visual Studio Code?](https://stackoverflow.com/questions/41330707/how-to-format-php-files-with-html-markup-in-visual-studio-code)

I'm using Laravel so all the views are .blade.php files. Visual Studio Code won't format the HTML because of the PHP extension. I removed the blade part of the filename, but it still isn't formatting the files properly (via Alt+Shift+F).I also tried about five extensions but none of them do the reformatting.How can I format .blade.php files in Visual Studio Code?

2016-12-26 11:40:07Z

I'm using Laravel so all the views are .blade.php files. Visual Studio Code won't format the HTML because of the PHP extension. I removed the blade part of the filename, but it still isn't formatting the files properly (via Alt+Shift+F).I also tried about five extensions but none of them do the reformatting.How can I format .blade.php files in Visual Studio Code?The extension beautify just do it very well, either add php and any other file extension type to the config as said above here is an example : 

OTHERWISE: you can also do it directly, type F1 then write beautify, the auto completion give you two choices beautify selection or beautify file. Choose the one you need, and it will do the job. that's a straight direct way.You can also add a keybinding to have a keyboard shortcut, here how to do it:choose any key you want, and make sure you don't override and existing one, search first in the left side if it exist or not.note that all of those things are well documented on the description of the extension.Beautify does solve this problem! Many people add "blade.php" and "php" to HTML config Beautify does not recognize and manually choose HTML template. Instead just adding "blade" to HTML config fix all issues.I think beautify might do the trick. Just add 'php' and/or 'blade.php' to the HTML section of its config to beautify PHP / Blade view files. Works for me!If you want something that just works out the box, adds the format nested HTML in PHP files support vscode should already have.Uses all the native settings for html.format, format on save, etc. Give the extension Format HTML in PHP a try. I made it because every other solution made me annoyed because it didn't work 100%.I found this extension called Format HTML in PHP that works well for me.This can be done by using html formatting for .blade.php Andrew Schultz mentioned the extension: "[Format HTML in PHP][1]"

[1]: https://marketplace.visualstudio.com/items?itemName=rifi2k.format-html-in-php. This is indeed a great extension for format PHP files with html markup. It also format js included in PHP files. Moreover. Good news! The developer is already working successfully to include Laravel blade.php files. In the meantime I format Laravel blade files on vscode by switching language manually from blade to php then I use the extension "[Format HTML in PHP][1]" with CTRL+ALT+F or right click. It works great for me.  

Laravel belongsToMany exclude pivot table

Patrick Reck

[Laravel belongsToMany exclude pivot table](https://stackoverflow.com/questions/26474201/laravel-belongstomany-exclude-pivot-table)

I have two models, User and Badge. A user can have multiple badges, and a badge can belong to multiple users. (using a pivot table)Currently I am getting the data I need, but additionally I am getting the pivot table along. How do I exclude this?Here's the User model:And the Badge model:

2014-10-20 20:20:43Z

I have two models, User and Badge. A user can have multiple badges, and a badge can belong to multiple users. (using a pivot table)Currently I am getting the data I need, but additionally I am getting the pivot table along. How do I exclude this?Here's the User model:And the Badge model:Add pivot to your $hidden property's array in your model(s).And same with your User modelOr you can still hide the pivot on demand this way... 

Where to place Blade::extend

Vincent

[Where to place Blade::extend](https://stackoverflow.com/questions/18329541/where-to-place-bladeextend)

I want to add the following code to my laravel project to support the break and continue statements in blade.This is the code:I have no idea however where to place it, any help would be appreciated?

2013-08-20 07:43:07Z

I want to add the following code to my laravel project to support the break and continue statements in blade.This is the code:I have no idea however where to place it, any help would be appreciated?There's no requirement telling you where you should put the code, you could even put it in your routes.php (which is a bit messy of course). You only have to make sure that it's loaded when laravel processes a page view.In this case, creating a new file blade_extensions.php somewhere and including it in start/global.php might be a good solution.PS: Be sure to clear out your compiled views, as Blade only recompiles the views if it detects a change, so if you've just plonked in this code it won't work until you clear out the views.1) create app/Providers/BladeServiceProvider.php2) in config/app.php add3) run php artisan clear-compiled4) in your template use @datetime($updated_at) or @eval($var = 1), @eval($var++) for example5) important remarka) run php artisan clear-compiled might be helpfulb) I changed the code for$pattern = $compiler->createOpenMatcher('datetime');andreturn preg_replace($pattern, '$1<?php echo $2->format(\'m/d/Y H:i\')); ?>', $view);because the example from the Laravel 5 Documentation will not work.The example is corrected now.The example was removed.Laravel 5 update:1) You may want to create Extensions\BladeExtensions.php folder\file on the same level as Models, Providers, Services folders2) BladeExtensions.php3) AppServiceProvider.php

Check if row exists, Laravel

O P

[Check if row exists, Laravel](https://stackoverflow.com/questions/25209302/check-if-row-exists-laravel)

I have the following db structure:On my items permalink pages, I have an 'Add to favorites' button which inserts a new row into user_favoritesI want to be able to replace it for a 'Remove from favorites' button if the user already has it in their favorites.I can't figure out the logic behind this - do I need to check if a row exists in user_favorites that has the current user's id and the permalink item id? This did not work for me:

2014-08-08 17:46:07Z

I have the following db structure:On my items permalink pages, I have an 'Add to favorites' button which inserts a new row into user_favoritesI want to be able to replace it for a 'Remove from favorites' button if the user already has it in their favorites.I can't figure out the logic behind this - do I need to check if a row exists in user_favorites that has the current user's id and the permalink item id? This did not work for me:You may want something like this:I advise you to use exists() or count() to check, not use first().The fastest way:Or:SQL:The faster way: only select idSQL:The normal way:SQL:Let User_favorite be a model that accesses your user_favorites tableThe simplest way to do is to use toggle() method of many-to-many relationship.e.g.It also returns an array which tells you if the ID is attached or detached in DB.

Laravel - Where relationship column equals?

VoiD HD

[Laravel - Where relationship column equals?](https://stackoverflow.com/questions/43105870/laravel-where-relationship-column-equals)

I am trying to grab all records where Player's relationship called stats() has a column value of something. I would usually do ::where('column_name' 'column_value') for the players table, but how can I get ::where the relationship table's column equals to something?But I want to check a column in the relationships table?

2017-03-29 23:20:42Z

I am trying to grab all records where Player's relationship called stats() has a column value of something. I would usually do ::where('column_name' 'column_value') for the players table, but how can I get ::where the relationship table's column equals to something?But I want to check a column in the relationships table?This will filter Player based on a related table

Laravel 4 - two submit buttons in one form and have both submits to be handled by different actions

Abhay PS

[Laravel 4 - two submit buttons in one form and have both submits to be handled by different actions](https://stackoverflow.com/questions/20932543/laravel-4-two-submit-buttons-in-one-form-and-have-both-submits-to-be-handled-b)

I have a login form which has email and password fields. And I have two submit buttons, one for login ( if user is already registered ) and the other one for registration ( for new users ). As the login action and register action are different so I need some way to redirect the request with all the post data to its respective action. Is there a way to achieve this in Laravel 4 in pure Laravel way?

2014-01-05 10:35:41Z

I have a login form which has email and password fields. And I have two submit buttons, one for login ( if user is already registered ) and the other one for registration ( for new users ). As the login action and register action are different so I need some way to redirect the request with all the post data to its respective action. Is there a way to achieve this in Laravel 4 in pure Laravel way?The way I would do itIf your form is (2 buttons):Create a controller 'TestController'Add a routeIn TestController you'd have one method that checks which submit was clicked on and two other methods for login and registerMy solution:first I set up form with no actionfor routes (routes.php):controller (TestController.php)Jquery: (test.js)ClickCoder's answer is spot-on, the only thing I would replace, to do it in an 100% "pure Laravel way" would be to use the Form Builder for the submit buttons as well. http://laravel.com/docs/4.2/html#buttonsThe first parameter is the submit's value, and you can pass its name in the following options array.So instead of:You'd do:If you'd like, you could escape the if statement altogether by having them share the same name and do something like this:html:php:A bit less nesting, a bit more Laravel!You can do like the following:Your routes (routes.php):filters.phpTestController.phpForm: should be in your view.however, I have created a temp form in route file for this answer.now browse:Please note: I am not sure this is the right approach to allow two submit buttons but it work for two submit buttons.Give the submit buttons different names, egIn your controller, simply handle login or signup depending on which button was submitted. You will still get all your inputs, you can do this;

Laravel 4.2 blade: check if empty

Marten

[Laravel 4.2 blade: check if empty](https://stackoverflow.com/questions/27486179/laravel-4-2-blade-check-if-empty)

In Laravel blade you can do: This will check if a variable is set or not. I get some data from the database, and those variables are always set, so I can not use this method.I am searching for a shorthand 'blade' function for doing this:It is hard to use this piece or code for doing this beacuse of, I do not know how to do it with a link or something like this:I tried:But, it does not work. And, I would like to keep my code as short as possible ;)Can someone explain it to me?UPDATEI do not use a foreach because of, I get a single object  (one school) from the database. I passed it from my controller to my view with: So, I do not want to make an @if($value != ''){} around each $variable (like $school->name).

2014-12-15 14:23:05Z

In Laravel blade you can do: This will check if a variable is set or not. I get some data from the database, and those variables are always set, so I can not use this method.I am searching for a shorthand 'blade' function for doing this:It is hard to use this piece or code for doing this beacuse of, I do not know how to do it with a link or something like this:I tried:But, it does not work. And, I would like to keep my code as short as possible ;)Can someone explain it to me?UPDATEI do not use a foreach because of, I get a single object  (one school) from the database. I passed it from my controller to my view with: So, I do not want to make an @if($value != ''){} around each $variable (like $school->name).try this:I prefer the @unless directive for readability in this circumstance.With php 7, you can use null coalescing operator. This is a shorthand for @m0z4rt's answer.change toor the same codeI wonder why nobody talked about $variable->isEmpty() it looks more better than other. Can be used like:  

Laravel Session Flash persists for 2 requests

Walid Ammar

[Laravel Session Flash persists for 2 requests](https://stackoverflow.com/questions/24579580/laravel-session-flash-persists-for-2-requests)

Recently I have changed to Laravel from Codeigniter, everything was going fine except I encountered a problem with Session::flash.when I create new user I get success message but It will persist for 2 requests, even I didn't pass the validator:

my code in UsersController:in form.blade:in master.blade:Maybe I'm not alone with this issue, here is another unanswered question.For anyone in future facing this problem: 

Never flash session data without redirecting.My code now looks like this:

2014-07-04 18:51:24Z

Recently I have changed to Laravel from Codeigniter, everything was going fine except I encountered a problem with Session::flash.when I create new user I get success message but It will persist for 2 requests, even I didn't pass the validator:

my code in UsersController:in form.blade:in master.blade:Maybe I'm not alone with this issue, here is another unanswered question.For anyone in future facing this problem: 

Never flash session data without redirecting.My code now looks like this:You are Flashing session data and creating a view instead of redirecting, meaning the message will Flash for this request and for the next one, showing twice. If you want to show the message on the current request without redirecting, I would suggest providing the errors to your View::make instead of trying to Flash the messages. If you MUST Flash the message on the current request, then you will need to Session::forget('key') or Session::flush() after your view.The following seems to be available from version 5.1 onward. Although the method is not mentioned on Laravel's documentation page about sessions.This is the same as flash, except it won't persist to the next request.As @Drew  said earlierAn easy way to flash a message once when you are creating a view is:Happy coding!I had a similar problem, but I couldn't use Return::redirct, as I was using Ajax to to post to and from a  within a set of Tabs. Therefore, I was calling only if the validation failed and returning a view with the old input. Assuming validation passed and I wanted to run some functions and create a new view based on new data, I would call:I would put this before my final View::makeHope this helps (or makes sense)...create:delete:A good method to repopulate form with old data:Controller:View:

laravel fatal error for TestCase not found

Steve Bals

[laravel fatal error for TestCase not found](https://stackoverflow.com/questions/21726963/laravel-fatal-error-for-testcase-not-found)

if i run laravel it shows the following errorFatal error: Class 'TestCase' not found in D:\xampp\htdocs\laravel\app\tests\ExampleTest.php on line 3 , any idea 

2014-02-12 11:41:39Z

if i run laravel it shows the following errorFatal error: Class 'TestCase' not found in D:\xampp\htdocs\laravel\app\tests\ExampleTest.php on line 3 , any idea Run following command in your project's root directoryUpdate:You can also run with the following command if phpunit is not installed on your machine. Which is also better to avoid version differences between team mates.Check if your tests directory is listed on the classmap property of your composer.json file.If not add it and run composer dump-autoload.In my case, i noticed that my root folder not contained the phpunit.xml file.Solve it including the following code in phpunit.xml at the root folder:You haven't really given much information to go on here, but the specific problem is probably that you don't have an autoloader (thus the TestCase class that PHP is expecting isn't actually loaded. The underlying problem in turn is likely that you're trying to run ExampleTest.php directly on the terminal, whereas instead you must bootstrap a test environment correctly through Laravel and PHPUnit.You should find a phpunit.xml file in the root of your Laravel install. This file tells PHPUnit how to bootstrap and start executing tests for your application, so you should just be able to run phpunit on the command line in the root of your application and it should work.If that's not the issue, please do provide more detail for people to help with.I had same issue, you should run test from root folder, in your case 'http://localhost/laravel' and in terminal you just need to write phpunit, and test will be executed.Had the same issue with PHPUnit, he would output always the same message : PHP Fatal error:  Class 'Tests\TestCase' not found ... and indeed I think he had troubles to find that class so what you need to do is transform one line : From this : To this : I got the same error but none worked, except for this one, this worked for me,I tried reinstalling and upgrading my phpunit in Laravel 5.4,or run specific unit,  phpunit --filter yourTestCaseClassThe is caused by an outdated phpunit. If you using a globally installed phpunit, here is a link on how to update it https://stackoverflow.com/a/40701333/3792206  . Or you can explicitly use the phpunit that was installed with the project.

What do the three dots before a function argument represent?

Salar

[What do the three dots before a function argument represent?](https://stackoverflow.com/questions/40439733/what-do-the-three-dots-before-a-function-argument-represent)

I was working with Laravel 5.3 and in one of the functions, I found this piece of

code:The code comes from \Illuminate\Auth\Middleware\Authenticate::class.What are those 3 dots before $guards variable?

2016-11-05 15:07:31Z

I was working with Laravel 5.3 and in one of the functions, I found this piece of

code:The code comes from \Illuminate\Auth\Middleware\Authenticate::class.What are those 3 dots before $guards variable?It indicates that there may be a variable number of arguments. When the function is called with more than 3 arguments, all the arguments after $next will be added to the $guards array.You can read about it here.

Laravel migration transaction

olivarra1

[Laravel migration transaction](https://stackoverflow.com/questions/20420600/laravel-migration-transaction)

When developing i'm having so many issues with migrations in laravel.I create a migration. When i finish creating it, there's a small error by the middle of the migration (say, a foreign key constraint) that makes "php artisan migrate" fail. He tells me where the error is, indeed, but then migrate gets to an unconsistent state, where all the modifications to the database made before the error are made, and not the next ones.This makes that when I fix the error and re-run migrate, the first statement fails, as the column/table is already created/modified. Then the only solution I know is to go to my database and "rollback" everything by hand, which is way longer to do.migrate:rollback tries to rollback the previous migrations, as the current was not applied succesfully.I also tried to wrap all my code into a DB::transaction(), but it still doesn't work.Is there any solution for this? Or i just have to keep rolling things back by hand?

edit, adding an example (not writing Schema builder code, just some kind of pseudo-code):

Migration1:Migration1 executed OK. Some days later we make Migration 2:Now what will happen is that migrate will call the first statement and will create the table items with his foreign key to users. Then when he tries to apply the next statement it will fail.If we fix the make_some_error_here, we can't run migrate because the table "items" it's created. We can't rollback (nor refresh, nor reset), because we can't delete the table users since there's a foreign key constraint from the table items.Then the only way to continue is to go to the database and delete the table items by hand, to get migrate in a consistent state.

2013-12-06 09:40:15Z

When developing i'm having so many issues with migrations in laravel.I create a migration. When i finish creating it, there's a small error by the middle of the migration (say, a foreign key constraint) that makes "php artisan migrate" fail. He tells me where the error is, indeed, but then migrate gets to an unconsistent state, where all the modifications to the database made before the error are made, and not the next ones.This makes that when I fix the error and re-run migrate, the first statement fails, as the column/table is already created/modified. Then the only solution I know is to go to my database and "rollback" everything by hand, which is way longer to do.migrate:rollback tries to rollback the previous migrations, as the current was not applied succesfully.I also tried to wrap all my code into a DB::transaction(), but it still doesn't work.Is there any solution for this? Or i just have to keep rolling things back by hand?

edit, adding an example (not writing Schema builder code, just some kind of pseudo-code):

Migration1:Migration1 executed OK. Some days later we make Migration 2:Now what will happen is that migrate will call the first statement and will create the table items with his foreign key to users. Then when he tries to apply the next statement it will fail.If we fix the make_some_error_here, we can't run migrate because the table "items" it's created. We can't rollback (nor refresh, nor reset), because we can't delete the table users since there's a foreign key constraint from the table items.Then the only way to continue is to go to the database and delete the table items by hand, to get migrate in a consistent state.It is not a Laravel limitation, I bet you use MYSQL, right?As MYSQL documentation says hereAnd we have a recommendation of Taylor Otwell himself here saying: -- UPDATE --Do not worry!The bast practises say:It means, in one deployment you create new tables and fields and deploy a new release that uses them. In a next deployment you delete unused table and fields. Now, even if you'll get a problem in either of these deployments, don't worry if your migration failed, the working release uses the functional data structure anyway. And with the single operation per migration you'll find a problem in no time.I'm using MySql and I'm having this problem.My solution depends that your down() method does exactly what you do in the up()  but backwards.This is what i go:So here if something fails automatically calls the down() method and throws again the exception.Instead of using the migration between transaction() do it between this tryLike Yevgeniy Afanasyev highlighted Taylor Otwell as saying (but an approach I already took myself): have your migrations only work on specific tables or do a specific operation such as adding/removing a column or key. That way, when you get failed migrations that cause inconsistent states like this, you can just drop the table and attempt the migration again.I’ve experienced exactly the issue you’ve described, but as of yet haven’t found a way around it.Just remove the failed code from the migration file and generate a new migration for the failed statement. Now when it fails again the creation of the database is still intact because it lives in another migration file.Another advantage of using this approach is, that you have more control and smaller steps while reverting the DB.Hope that helps :DI know it's an old topic, but there was activity a month ago, so here are my 2 cents.This answer is for MySql 8 and Laravel 5.8

MySql, since MySql 8, introduced atomic DDL: https://dev.mysql.com/doc/refman/8.0/en/atomic-ddl.html

Laravel at the start of migration checks if the schema grammar supports migrations in a transaction and if it does starts it as such.

The problem is that the MySql schema grammar has it set to false. We can extend the Migrator, MySql schema grammar and MigrationServiceProvider, and register the service provider like so:Of course, we have to add transactions to our database config...

DISCLAIMER - Haven't tested yet, but looking only at the code it should work as advertised :) Update to follow when I test...I think the best way to do it is like shown in the documentation:See: https://laravel.com/docs/5.8/database#database-transactions

Hotmail rejecting all emails using Mailgun or SparkPost [closed]

Syed Abdur Rehman Kazmi

[Hotmail rejecting all emails using Mailgun or SparkPost [closed]](https://stackoverflow.com/questions/50416923/hotmail-rejecting-all-emails-using-mailgun-or-sparkpost)

I have been trying to send mail using Laravel. I have been successful in integrating Mailgun/SparkPost in my application. It is sending mail to every other domain except for Hotmail/Outlook/MSN/Live. 

Somehow they are saying that the IP I am trying to send mail from is on their blocked list.This is the error message i keep on getting: When I tried to reach out to Hotmail's support and explained my issue to them, this is the reply I got from them. I am using Laravel 5.4 and i am able to send mails to every other network i.e gmail/yahoo 

2018-05-18 18:00:03Z

I have been trying to send mail using Laravel. I have been successful in integrating Mailgun/SparkPost in my application. It is sending mail to every other domain except for Hotmail/Outlook/MSN/Live. 

Somehow they are saying that the IP I am trying to send mail from is on their blocked list.This is the error message i keep on getting: When I tried to reach out to Hotmail's support and explained my issue to them, this is the reply I got from them. I am using Laravel 5.4 and i am able to send mails to every other network i.e gmail/yahoo Seems like there is some problem with the IpAddress that Mailgun assigns you.All I had to do was to go into the domain i setup at Mailgun there was an IP address assigned to my domain. I removed it. It assigned me a new one and done. I recently encountered this issue as well - I highly recommend that you reach out to the Mailgun support team and notify them of the issue. They recognized that the IP that I was on was associated with a user who had been sending a lot of spam and they hooked us up with a "clean" IP. I'd guess that if you delete your IP and they automatically assign you a new one, that can work but might not be a guaranteed fix if the new IP is also blacklisted - just let them know, they'll help you out.Hotmail reject email, maybe Mailgun server is using a IP address, but it is in blacklist of Hotmail, you can create new ticket, and Mailgun will support to change IP address. Your can send the detail of error by go to tab: Logs > coppy json returned and send to mailgun. Good luck.

Check for Session timeout in Laravel

mattl

[Check for Session timeout in Laravel](https://stackoverflow.com/questions/14688853/check-for-session-timeout-in-laravel)

I was just wondering if anyone knew how to check for session timeout in Laravel. You can check whether the session has a specific item:But you can't check whether the session has expired. It would be nice so that I can report back to the user in a more specific way. "Your session has timed out, please start again."Any thoughts?

2013-02-04 14:30:13Z

I was just wondering if anyone knew how to check for session timeout in Laravel. You can check whether the session has a specific item:But you can't check whether the session has expired. It would be nice so that I can report back to the user in a more specific way. "Your session has timed out, please start again."Any thoughts?Just use the same logic as the session class itself.Place this in your 'before' filter - and it will run on every request.Why not do this?If a session times out then the name will no longer be set. You can then write some code to respond to $sessionTimeout == 1;BTW,

Specifically if you need the session lifetime,Use this:When describing this, Use this:

Setting up Laravel with Nginx

Kyle Decot

[Setting up Laravel with Nginx](https://stackoverflow.com/questions/8856664/setting-up-laravel-with-nginx)

I'm attempting to set up the Laravel PHP Framework to work with Nginx. Here is my directory structure:Basically what I have is a standard Laravel download w/ a legacy folder thrown in which holds all of the files from my non-MVC project. I need Nginx to first check if the requested page/file exists inside of legacy, if it does then I want to use that. Otherwise, I want to fall back to Laravel's index.php file which is located in project/public/. I'm no expert when it comes to Nginx configurations so any help that you can provide would be most appreciated.

2012-01-13 20:12:54Z

I'm attempting to set up the Laravel PHP Framework to work with Nginx. Here is my directory structure:Basically what I have is a standard Laravel download w/ a legacy folder thrown in which holds all of the files from my non-MVC project. I need Nginx to first check if the requested page/file exists inside of legacy, if it does then I want to use that. Otherwise, I want to fall back to Laravel's index.php file which is located in project/public/. I'm no expert when it comes to Nginx configurations so any help that you can provide would be most appreciated.

Using withTrashed with relationships in Eloquent

Vuk Stanković

[Using withTrashed with relationships in Eloquent](https://stackoverflow.com/questions/25868025/using-withtrashed-with-relationships-in-eloquent)

Is there a way to use withTrashed with relationships in Eloquent. What I need is this. I have table and model Mark and another table User. User has many Mark and Mark belongs to User. So I defined this in Eloquent models.Now I need to get an instance of Mark that is soft deleted. This is not a problem if User isn't soft deleted, but if both Mark and User are soft deleted, I get an error Trying to get property of non-object, becausewon't return actual user, cause it is soft deleted.Is there a way that I can do something like to get this related user even if it is deleted?

2014-09-16 11:49:43Z

Is there a way to use withTrashed with relationships in Eloquent. What I need is this. I have table and model Mark and another table User. User has many Mark and Mark belongs to User. So I defined this in Eloquent models.Now I need to get an instance of Mark that is soft deleted. This is not a problem if User isn't soft deleted, but if both Mark and User are soft deleted, I get an error Trying to get property of non-object, becausewon't return actual user, cause it is soft deleted.Is there a way that I can do something like to get this related user even if it is deleted?Depenging on your needs, you can define the relationship:or use it on the fly:And in your pasted example it will be:You can do that like this:

Laravel Homestead Swift Cannot send message without a sender address

Gergely Havlicsek

[Laravel Homestead Swift Cannot send message without a sender address](https://stackoverflow.com/questions/31871806/laravel-homestead-swift-cannot-send-message-without-a-sender-address)

I get this error with stock email settings in Laravel 5.1 Homestead when I try to send a password reset mail. The address is filled in app/config/mail.php: 

2015-08-07 07:20:26Z

I get this error with stock email settings in Laravel 5.1 Homestead when I try to send a password reset mail. The address is filled in app/config/mail.php: In your .env file you will need to set the email address and password of your email account. You also need to set the host and port of the mail server you are using.Or make sure that everything is complete in your mail.php file (see note below). Note: It's better to use the .env file, as you most likely will have a different configuration in your production environment.If everything is completed and it still doesn't work, it might be caching. You can clear the config cache with this:Also note: As Viktorminator mentioned:

Take into consideration creating app passwords and not using your usual pass for this needs. Link for creating passwords myaccount.google.com/apppasswords Make sure you have set the 'from' in app/config/mail.phpIt will fix the problem.If you don't have access to the .env file, you can add default values to those env calls on app/config/mail.php, like this:This approach will try to get the data from the .env file, if there's nothing there, it'll default to whatever you set.error was still occure. after settings and run commandscheck the codeTo make Mailtrap work in my case, I had to provide a value for MAIL_FROM_ADDRESS environment variable on Laravel 6+ instead of keeping it null.Maybe someone is using laravel 6

Its problem is "Cannot send message without a sender address" so there is no email address to send the email in .env fileJust add sender email addressI didn't change anything in the mail.php file, its work for me in laravel 6, after that runThe file: /bootstrap/cache/config.php

The change:

How to change reset password email subject in laravel?

Chinmay235

[How to change reset password email subject in laravel?](https://stackoverflow.com/questions/40574001/how-to-change-reset-password-email-subject-in-laravel)

I am beginner in Laravel. Currently I am learning this framework. My curent Laravel version is 5.3.I am scaffolding my auth by using php artisan make:auth All are working fine. Also I configured gmail smtp in my .env file and mail.php in config directgory. All are perfectly working. But I saw by-default the forgot password email subject is going Reset Password. I want to change that.I saw some blog. I found some blog. I have implement that in my site. But same output coming.I followed these links - https://laracasts.com/discuss/channels/general-discussion/laravel-5-password-reset-link-subjecthttps://laracasts.com/discuss/channels/general-discussion/reset-password-email-subjecthttps://laracasts.com/discuss/channels/laravel/how-to-override-message-in-sendresetlinkemail-in-forgotpasswordcontroller

2016-11-13 12:48:37Z

I am beginner in Laravel. Currently I am learning this framework. My curent Laravel version is 5.3.I am scaffolding my auth by using php artisan make:auth All are working fine. Also I configured gmail smtp in my .env file and mail.php in config directgory. All are perfectly working. But I saw by-default the forgot password email subject is going Reset Password. I want to change that.I saw some blog. I found some blog. I have implement that in my site. But same output coming.I followed these links - https://laracasts.com/discuss/channels/general-discussion/laravel-5-password-reset-link-subjecthttps://laracasts.com/discuss/channels/general-discussion/reset-password-email-subjecthttps://laracasts.com/discuss/channels/laravel/how-to-override-message-in-sendresetlinkemail-in-forgotpasswordcontrollerYou can change your password reset email subject, but it will need some extra work. First, you need to create your own implementation of ResetPassword notification.Create a new notification class insideapp\Notifications directory, let's named it ResetPassword.php:You can also generate the notification template using artisan command: Or you can simply copy-paste the above code. As you may notice this notification class is pretty similar with the default Illuminate\Auth\Notifications\ResetPassword. You can actually just extend it from the default ResetPassword class. The only difference is here, you add a new method call to define the email's subject:You may read more about Mail Notifications here.Secondly, on your app\User.php file, you need to override the default sendPasswordResetNotification() method defined by Illuminate\Auth\Passwords\CanResetPassword trait. Now you should use your own ResetPassword implementation:And now your reset password email subject should be updated!Hope this help!You may easily modify the notification class used to send the password reset link to the user. To get started, override the sendPasswordResetNotification method on your User model. Within this method, you may send the notification using any notification class you choose. The password reset $token is the first argument received by the method, See the Doc for CustomizationHope this helps!In Laravel 5.7 the default implementation is similar to this:All you have to do is change your locale from config/app.php for example to ro, then in your resources/lang, create a file ro.json similar to this:It will translate both the subject (first key) and the mail body.UPDATE for Laravel 6.*

This can be also used for VerifyEmail.php notification.You can create a custom function that will create the reset password token like this.To everyone asking how to update the Hello, Regards, and subcopy text:php artisan vendor:publish (option 11)then in views/vendor/notifications/email.blade.phpIn this file there will be the text like Hello, wich you can change by changing:

for example:

line 9# @lang('Hallo!, Hei!, Bonjour!, Guten Tag!,   Geia!')Just add the line:->subject('New Subjetc')in the the method toMail of the file Illuminate\Auth\Notifications\ResetPassword

like this:

Laravel Task Scheduling Every X Hours

senty

[Laravel Task Scheduling Every X Hours](https://stackoverflow.com/questions/42799953/laravel-task-scheduling-every-x-hours)

I undestand that you can create hourly tasks on Laravel by using:$schedule->command('catalog:update')->hourly(); however is there a way to do for example every 2 hours or 5 hours? I couldn't find it on documentation or here.

2017-03-15 02:14:31Z

I undestand that you can create hourly tasks on Laravel by using:$schedule->command('catalog:update')->hourly(); however is there a way to do for example every 2 hours or 5 hours? I couldn't find it on documentation or here.You've tagged your question as Laravel 4, but I don't think the scheduler was introduced until Laravel 5...Anyway, based on the code snippet you've posted, you could use the cron method.See the docs for other options. https://laravel.com/docs/5.4/scheduling#defining-schedules

How to implement a self referencing (parent_id) model in Eloquent Orm

Dinesh Copoosamy

[How to implement a self referencing (parent_id) model in Eloquent Orm](https://stackoverflow.com/questions/20292329/how-to-implement-a-self-referencing-parent-id-model-in-eloquent-orm)

I have a User table and need to allow for users to have a parent user.the table would have the fields:How would I define this self referencing relationship in Eloquent ORM?

2013-11-29 19:32:50Z

I have a User table and need to allow for users to have a parent user.the table would have the fields:How would I define this self referencing relationship in Eloquent ORM?I had some success like this, using your exact DB table.User Model:and then I could use it in my code like this:Give that a try and let me know how you get on!I had a chain of self referencing contracts (a contract can be continued by another contract) and also needed self referencing. Each contract has zero or one previous and also zero or one next contract.My data table looked like the following:To define the inverse of a relationship (previous contract) you have to inverse the related columns, that means setting

 * foreign key column on the model table

 * associated column on the parent table (which is the same table)See http://laravel.com/docs/5.0/eloquent#one-to-one for further details.

How to use break or continue with Laravel Eloquent Collection's each method?

Nasif Md. Tanjim

[How to use break or continue with Laravel Eloquent Collection's each method?](https://stackoverflow.com/questions/29725880/how-to-use-break-or-continue-with-laravel-eloquent-collections-each-method)

How to use break or continue with Laravel Eloquent Collection's each method.

My code is this:

2015-04-19 04:43:30Z

How to use break or continue with Laravel Eloquent Collection's each method.

My code is this:To continue, just return out of the inner function. To break, well..If you're using Laravel 5.1+, you can return false to break the loop:For older version of Laravel, use a regular foreach loop:We can return true/false true for continue, false for breakContinue:Output:

1 3 4Break:Output:

1

Laravel Update Query

Brent

[Laravel Update Query](https://stackoverflow.com/questions/27248753/laravel-update-query)

I am trying to update a User on the basis of the email not there id, is there a way of doing this without raw queries. Currently the error My Code 

2014-12-02 11:51:56Z

I am trying to update a User on the basis of the email not there id, is there a way of doing this without raw queries. Currently the error My Code This error would suggest that User::where('email', '=', $userEmail)->first() is returning null, rather than a problem with updating your model.Check that you actually have a User before attempting to change properties on it, or use the firstOrFail() method.or using the firstOrFail() method, theres no need to check if the user is null because this throws an exception (ModelNotFoundException) when a model is not found, which you can catch using App::error() http://laravel.com/docs/4.2/errors#handling-errorsYou could use the Laravel query builder, but this is not the best way to do it.Check Wader's answer below for the Eloquent way - which is better as it allows you to check that there is actually a user that matches the email address, and handle the error if there isn't.If you have multiple fields to update you can simply add more values to that array at the end.Try doing it like this.

What is Closure in Laravel?

vishal ribdiya

[What is Closure in Laravel?](https://stackoverflow.com/questions/47348081/what-is-closure-in-laravel)

I saw one Laravel function in middlewere:What is Closure and what does it do?

2017-11-17 10:07:40Z

I saw one Laravel function in middlewere:What is Closure and what does it do?A Closure is an anonymous function. Closures are often used as callback methods and can be used as a parameter in a function. If you take the following example:We start by adding a Closure parameter the handle function. This will type hint us that the handle function takes a Closure.We then call the handle function and pass a function as the first parameter.By using $closure(); in the handle function we tell PHP to execute the given Closure which will then echo 'Hello!'It is also possible to pass parameters into a Closure. We can do so by changing the Closure call in the handle function to pass on a parameter. In this example i'll just pass a string but this can be any variable.The handle function now looks likeWe now also need to modify the Closure itself to take the parameter. We do so by simply adding a parameter to the function. And then we pass that variable to the echo. The function now looks likeWhich will echo Hello World!For more information you can check out these links:http://php.net/manual/en/functions.anonymous.phphttp://php.net/manual/en/class.closure.php

Pass a custom message (or any other data) to Laravel 404.blade.php

giò

[Pass a custom message (or any other data) to Laravel 404.blade.php](https://stackoverflow.com/questions/29163564/pass-a-custom-message-or-any-other-data-to-laravel-404-blade-php)

I am using Laravel 5, and I have created a file 404.blade.php inThis file gets rendered each time I call:How can I pass a custom message? Something like this in 404.blade.phpFilled by (example):or In Laravel 4 one could use App::missing:

2015-03-20 09:45:13Z

I am using Laravel 5, and I have created a file 404.blade.php inThis file gets rendered each time I call:How can I pass a custom message? Something like this in 404.blade.phpFilled by (example):or In Laravel 4 one could use App::missing:(Note: copied from my answer here.)In Laravel 5, you can provide Blade views for each response code in the /resources/views/errors directory. For example a 404 error will use /resources/views/errors/404.blade.php.What's not mentioned in the manual is that inside the view you have access to the $exception object. So you can use {{ $exception->getMessage() }} to get the message you passed into abort().Extend Laravel's Exception Handler, Illuminate\Foundation\Exceptions\Handler, and override renderHttpException(Symfony\Component\HttpKernel\Exception\HttpException $e) method with your own.If you haven't run php artisan fresh, it will be easy for you. Just edit app/Exceptions/Handler.php, or create a new file.And then, use $e variable in your 404.blade.php.i.e.and in your 404.blade.phpFor other useful methods like getStatusCode(), refer Symfony\Component\HttpKernel\ExceptionHow about sharing a variable globally?Just make sure in the template to fallback to a default in case you forget to set it.See sharing data with views: http://laravel.com/docs/5.0/views

Laravel 5.1 PHP DOMDocument() class not found

user3023925

[Laravel 5.1 PHP DOMDocument() class not found](https://stackoverflow.com/questions/31577588/laravel-5-1-php-domdocument-class-not-found)

I'm using PHP's built-in DOMDocument() class to do some simple web-scrapping.

However, it works on my 4.2 site, but not my 5.1 (both are on same installation of PHP).Here's the error:Here's my controller:I figure this is a namespace issue, but I have no idea how to access DOMDocument()Thanks for any help.

2015-07-23 03:16:45Z

I'm using PHP's built-in DOMDocument() class to do some simple web-scrapping.

However, it works on my 4.2 site, but not my 5.1 (both are on same installation of PHP).Here's the error:Here's my controller:I figure this is a namespace issue, but I have no idea how to access DOMDocument()Thanks for any help.In Laravel 5.1 you must prefix the class name with the global namespace prefix '\'.So your updated code:For me, in order to solve the error: DOMDocument() class not found. I had to install the DOM extension.If you are using PHP 5:You can do so on Debian / Ubuntu using:And on Centos / Fedora / Red Hat:If you are using PHP 7:For Ubuntu:For CentOS / Fedora / Red Hat:Tested in Laravel 5.4 you can use keyword use :In top of file before define the class you can write use DOMDocument; instead of new \DOMDocument();For eg:what is this '...' ?I had this problem in laravel 5.6 on a server with ubuntu 16.04, and I solved this issue installing the xml package for php7.1 version, this does not work for me in the php7.2 version I don't know why.1.- Make sure you have the version 7.1 of php installed, I use this command to select the correct php version in ubuntu: Note: In case you don't have installed the php7.1 version, do you need to install it before the above command, in that case you can use this command: apt-get install php7.12.- To install the package XML I was used the following command:3.- Restart your apache server, in my case with this command:I hope to be helpful, this saved my day.I had the same issue with Amazon Linux 2 (LAMP) with laravel frameworkPlease find below steps resolve issues:

Laravel 5.3 - How to log all queries on a page?

DevK

[Laravel 5.3 - How to log all queries on a page?](https://stackoverflow.com/questions/41163199/laravel-5-3-how-to-log-all-queries-on-a-page)

My team and I are working on a rather big project. There's queries going on everywhere - in controllers, in view composers in views (lazy loading) and probably in some other services as well. It's getting hard to keep a track of it all and the page load speed is fairly slow at the moment. Where would I put \DB::enableQueryLog() and \DB::getQueryLog() to log ALL the queries and dump them? Basically I'm looking for some place in code that happens before any of the queries happen (to put enableQueryLog()) and I'm looking for a place that happens after the views render (to dump getQueryLog()).What would be a good way to go about this?Thanks in advance.

2016-12-15 11:35:35Z

My team and I are working on a rather big project. There's queries going on everywhere - in controllers, in view composers in views (lazy loading) and probably in some other services as well. It's getting hard to keep a track of it all and the page load speed is fairly slow at the moment. Where would I put \DB::enableQueryLog() and \DB::getQueryLog() to log ALL the queries and dump them? Basically I'm looking for some place in code that happens before any of the queries happen (to put enableQueryLog()) and I'm looking for a place that happens after the views render (to dump getQueryLog()).What would be a good way to go about this?Thanks in advance.Here comes the perfect example:https://laravel.com/docs/5.3/database#listening-for-query-eventsOpen app\Providers\AppServiceProvider.php and add the following to Boot() function:   You can add this to the Providers/AppServiceProvider.php file and check them in the laravel log file with tail:You can even filter with queries you want to log. For example, here I was using Laravel Passport, and didn't want to log all the oauth queries.If you want to print a query which is executed on your app do following steps.Step1: Go to your AppServiceProvider.php file.   // File path App\Providers\AppServiceProvider.phpStep2: Make boot() method and paste below code.Step3: Now you can see you queries in lumen.log or laravel.log file. File path is laravel_app\storage\logs\laravel.log or lumen.log.Enjoy....Put this code right above the code where your query is executed Just modified for executable query:add a middleware that executes after the request is done and logs your queries ... see Terminable MiddlwaresAre you using MySQL? You can just tail the log.How to show the last queries executed on MySQL?Or use the Laravel Debug Bar?Additioanlly There's package available also: https://packagist.org/packages/technoknol/log-my-queries Just install and add it's entry to middleware. It will log all the queries in laravel.log default log file. 

How To Cast Eloquent Pivot Parameters?

Josh Janusch

[How To Cast Eloquent Pivot Parameters?](https://stackoverflow.com/questions/30226496/how-to-cast-eloquent-pivot-parameters)

I have the following Eloquent Models with relationships:The pivot table contains an additional param (is_primary) that marks a relationship as the primary. Currently, I see returns like this when I query for a contact:Is there a way to cast the is_primary in that to a boolean? I've tried adding it to the $casts array of both models but that did not change anything.

2015-05-13 22:50:02Z

I have the following Eloquent Models with relationships:The pivot table contains an additional param (is_primary) that marks a relationship as the primary. Currently, I see returns like this when I query for a contact:Is there a way to cast the is_primary in that to a boolean? I've tried adding it to the $casts array of both models but that did not change anything.Since this is an attribute on the pivot table, using the $casts attribute won't work on either the Lead or Contact model.One thing you can try, however, is to use a custom Pivot model with the $casts attribute defined. Documentation on custom pivot models is here. Basically, you create a new Pivot model with your customizations, and then update the Lead and the Contact models to use this custom Pivot model instead of the base one.First, create your custom Pivot model which extends the base Pivot model:Now, override the newPivot() method on the Lead and the Contact models:In Laravel 5.4.14 this issue has been resolved. You are able to define a custom pivot model and tell your relationships to use this custom model when they are defined. See the documentation, under the heading Defining Custom Intermediate Table Models.To do this you need to create a class to represent your pivot table and have it extend the Illuminate\Database\Eloquent\Relations\Pivot class. On this class you may define your $casts property.You can then use the using method on the BelongsToMany relationship to tell Laravel that you want your pivot to use the specified custom pivot model.Now, whenever you access your pivot by using ->pivot, you should find that it is an instance of your custom pivot class and the $casts property should be honoured.Update 1st June 2017The issue raised in the comments by @cdwyer regarding updating the pivot table using the usual sync/attach/save methods is expected to be fixed in Laravel 5.5 which is due to be released next month (July 2017).See Taylor's comment at the bottom of this bug report and his commit, fixing the issue here.Good news! Tylor already fixed this bug:https://github.com/laravel/framework/issues/10533In Laravel 5.1 or higher you can use dot notation for pivot casts:The answer provided by @patricus above is absolutely correct, however, if like me you're looking to also benefit from casting out from JSON-encoded strings inside a pivot table then read on.I believe that there's a bug in Laravel at this stage. The problem is that when you instantiate a pivot model, it uses the native Illuminate-Model setAttributes method to "copy" the values of the pivot record table over to the pivot model.This is fine for most attributes, but gets sticky when it sees the $casts array contains a JSON-style cast - it actually double-encodes the data.The way I overcame this is as follows:1. Set up your own Pivot base class from which to extend your pivot subclasses (more on this in a bit)2. In your new Pivot base class, redefine the setAttribute method, commenting out the lines that handle JSON-castable attributesThis highlights the removal of the isJsonCastable method call, which will return true for any attributes you have casted as json, array, object or collection in your whizzy pivot subclasses.3. Create your pivot subclasses using some sort of useful naming convention (I do {PivotTable}Pivot e.g. FeatureProductPivot)4. In your base model class, change/create your newPivot method override to something a little more usefulMine looks like this:Then just make sure you Models extend from your base model and you create your pivot-table "models" to suit your naming convention and voilà you will have working JSON casts on pivot table columns on the way out of the DB!NB: This hasn't been thoroughly tested and may have problems saving back to the DB.I had to add some extra checks to have the save and load functions working properly in Laravel 5.

Temporary property for Laravel Eloquent model

Nick

[Temporary property for Laravel Eloquent model](https://stackoverflow.com/questions/22297240/temporary-property-for-laravel-eloquent-model)

I have a Laravel Eloquent model User, which has a table with username and email columns. I need to add a property for the model on runtime, something like $user->secure. This property doesn't need to go to database.When i add this property and hit $user->save() i get an error saying i don't have database column 'secure'. I can unset 'secure' before save but somehow it feels there should be a better way to do so. Any suggestions?

2014-03-10 10:10:49Z

I have a Laravel Eloquent model User, which has a table with username and email columns. I need to add a property for the model on runtime, something like $user->secure. This property doesn't need to go to database.When i add this property and hit $user->save() i get an error saying i don't have database column 'secure'. I can unset 'secure' before save but somehow it feels there should be a better way to do so. Any suggestions?Just add an attribute to your class.Note that it is better to declare it protected and add corresponding accessors and mutators (getSecure and setSecure methods) to your model.For those who still find this post (like I did), you may need to explicitly declare the property as null to prevent it from being automatically added to the attributes array, and thus being added to INSERT/UPDATE queries:Source: http://laravel.io/forum/02-10-2014-setting-transient-properties-on-eloquent-models-without-saving-to-databaseIf you intend to make use of that add-on property, then $append will blow your mind.http://laraveldaily.com/why-use-appends-with-accessors-in-eloquent/

Call Laravel model by string [duplicate]

Parampal Pooni

[Call Laravel model by string [duplicate]](https://stackoverflow.com/questions/34409665/call-laravel-model-by-string)

Is it possible to call a Laravel model by string? This is what i'm trying to achieve but its failing:I get the following exception:

2015-12-22 06:23:20Z

Is it possible to call a Laravel model by string? This is what i'm trying to achieve but its failing:I get the following exception:Yes, you can do this, but you need to use the fully qualified class name:If your model name is stored in something other than a plain variable (e.g. a object attribute), you will need to use an intermediate variable in order to get this to work.Try this:Yes you can do it with more flexible way. Create a common function.Now you can call this method in different ways.By the way I like to use such functions.if you use it in many of the places use this functionExample if you want to get all the userScenario 1:Scenario 2:if your model in in custom namespace may be App\ModelsHope it helpsThis method should work well:My project has multiple subdirectory and this function work well. So I recover the namespace of the model with $model = current($this->getNamespace($this->request->get('model'))); 

Then I just have to call my query: $model::all()You can also try like this:-

How do I send an email with Laravel 4 without using a view?

Jason Thuli

[How do I send an email with Laravel 4 without using a view?](https://stackoverflow.com/questions/25394476/how-do-i-send-an-email-with-laravel-4-without-using-a-view)

I'm developing a site using Laravel 4 and would like to send myself ad-hoc emails during testing, but it seems like the only way to send emails is to go through a view.Is it possible to do something like this?

2014-08-19 23:18:03Z

I'm developing a site using Laravel 4 and would like to send myself ad-hoc emails during testing, but it seems like the only way to send emails is to go through a view.Is it possible to do something like this?As mentioned in an answer on Laravel mail: pass string instead of view, you can do this (code copied verbatim from Jarek's answer):You can also use an empty view, by putting this into app/views/email/blank.blade.phpAnd nothing else. Then you code And this allows you to send custom blank emails from different parts of your application without having to create different views for each one.If you want to send just text, you can use included method:No, with out of the box Laravel Mail you will have to pass a view, even if it is empty. You would need to write your own mailer to enable that functionality. 

Is it possible to prevent Laravel running Model Events when the database is being Seeded?

Jack

[Is it possible to prevent Laravel running Model Events when the database is being Seeded?](https://stackoverflow.com/questions/30492227/is-it-possible-to-prevent-laravel-running-model-events-when-the-database-is-bein)

Laravel's seeder runs a variety of Model Events on my models which trigger New Order notification emails, among other things, from the Product::saved() Model Event.This significantly slows down database seeding. Is it possible to detect whether a Seed is being ran and if so, tell Laravel not to run the Model Events?

2015-05-27 20:10:15Z

Laravel's seeder runs a variety of Model Events on my models which trigger New Order notification emails, among other things, from the Product::saved() Model Event.This significantly slows down database seeding. Is it possible to detect whether a Seed is being ran and if so, tell Laravel not to run the Model Events?There are functions on the Model class which will allow you to ignore events.Before using a model to seed, you will need to do something like this...I recommend to remove the Dispatcher in this Case from the Eloquent Model.For example.

How to simplify this Laravel PHP code to one Eloquent query?

Z0q

[How to simplify this Laravel PHP code to one Eloquent query?](https://stackoverflow.com/questions/41847910/how-to-simplify-this-laravel-php-code-to-one-eloquent-query)

I assume that this should all be in one query in order to prevent duplicate data in the database. Is this correct?How do I simplify this code into one Eloquent query?

2017-01-25 09:30:27Z

I assume that this should all be in one query in order to prevent duplicate data in the database. Is this correct?How do I simplify this code into one Eloquent query?It's not correct. You prevent duplication by placing unique constraints on database level.There's literally nothing you can do in php or any other language for that matter, that will prevent duplicates, if you don't have unique keys on your table(s). That's a simple fact, and if anyone tells you anything different - that person is blatantly wrong. I can explain why, but the explanation would be a lengthy one so I'll skip it.Your code should be quite simple - just insert the data. Since it's not exactly clear how uniqueness is handled (it appears to be user_2, accepted, but there's an edge case), without a bit more data form you - it's not possible to suggest a complete solution.You can always disregard what I wrote and try to go with suggested solutions, but they will fail miserably and you'll end up with duplicates.I would say if there is a relationship between User and Friend you can simply employ Laravel's model relationship, such as:Thats what I would do to ensure that the new data is updated or a new one is created.UPDATEOkay. Depending on what fields in the friends table marks the two friends, now using your example user_1 and user_2. By the example I gave, the $attributes_to_update would be (assuming otherID is the new friend's id):If your relationship between User and Friend is set properly, then the user_1 would already included in the insertion.Furthermore,on this updateOrCreate function:$attributes_to_check would mean those fields you want to check if they already exists before you create/update new one so if I want to ensure, the check is made when accepted is 0 then I can pass both say `['user_1' => 1, 'accepted' => 0]Hope this is clearer now.I'm assuming "friends" here represents a many-to-many relation between users. Apparently friend requests from one user (myID) to another (otherId).You can represent that with Eloquent as:That is, no need for Friend model.Then, I think this is equivalent to what you want to accomplish (if not, please update with clarification):(accepted 0 or 1, according to your business logic).This sync method prevents duplicate inserts, and updates or creates any row for the given pair of "myId - otherId". You can set any number of additional fields in the pivot table with this method.However, I agree with @Mjh about setting unique constraints at database level as well.For this kind of issue,  First of all, you have to enjoy the code and database if you are working in laravel.  For this first you create realtionship between both table friend and user in database as well as in Models . Also you have to use unique in database .This is query you can work with this . Also you can pass multiple condition here. ThanksYou can use firstOrCreate/ firstOrNew methods (https://laravel.com/docs/5.3/eloquent)Example (from docs) :use `firstOrCreate' it will do same as you did manually. Definition of FirstOrCreate copied from the Laravel Manual. The firstOrCreate method will attempt to locate a database record using the given column / value pairs. If the model can not be found in the database, a record will be inserted with the given attributes.So according to that you should try : It will check with both IDs if not exists then create record in friends table.

Laravel - Union + Paginate at the same time?

Lior

[Laravel - Union + Paginate at the same time?](https://stackoverflow.com/questions/25338456/laravel-union-paginate-at-the-same-time)

Brief:I am trying to union 2 tables recipes and posts then add ->paginate(5) to the queries.But for some reason I get this error:Code:Am i doing something wrong?Without ->paginate(5) the query works fine.

2014-08-16 08:45:42Z

Brief:I am trying to union 2 tables recipes and posts then add ->paginate(5) to the queries.But for some reason I get this error:Code:Am i doing something wrong?Without ->paginate(5) the query works fine.You're right, pagination cause problem. Right now, you can create a view and query the view instead of the actual tables, or create your Paginator manually: I faced this kind of issue already. I found a thread also not about pagination but about unions.Please see this link : Sorting UNION queries with Laravel 4.1@Mohamed Azher has shared a nice trick and it works on my issue.This creates an sql like below:And you can already utilize Laravel's paginate same as usual like $query->paginate(5). (but you have to fork it a bit to fit to your problem)View page :Reiterating jdme's answer with a more elegant method from Illuminate\Database\Query\Builder.I hope this helps!I had this same problem, and unfortunately I couldn't get the page links with {{ $result->links() }}, but I found another way to write the pagination part and the page links appearsCustom data pagination with Laravel 5Getting the total count for pagination is the problem here. This is the error I got when used $builder->paginate()If you want to paginate without total count you can useto get only set of rows in the page.Getting all the rows and counting total is memory inefficient. So I used following approach to get total count.Then we have to paginate the result manually.If you can use raw sql queries, it is much more CPU and memory efficient.for paginate collection do this:add this to boot function in \app\Providers\AppServiceProvider From hereafter for all collection you can paginate like your codeI know this answer is too late. But I want to share my problems and my solution.※This is the sample.

MariaDB, about 146,000 records.Reference from www.tech-corgi.com (やり方２), I updated my PHP code to filter inside my query, and then call paginate normally.I must add a condition (filter) before getting large records. In this example is organization_id.But it still cannot be used in paginate (). There is a trick to solve this problem. See below.Trick: put query inside (). For example: (SELECT * FROM TABLE_A).Reason: paginage () will generate and run Count query SELECT count (*) FROM (SELECT * FROM TABLE_A), if we did not put inside brackets, Count query would not be a correct query.Now I can use it normally:Hope it help!!!The accepted answer works great for Query Builder.But here's my approach for Laravel Eloquent Builder.Assume that we're referring to same ModelI'm using Laravel 5.6For those who may still look for the answer, I have tried union and paginate together and got right result under laravel 5.7.20. This will be better than merging collections then paginate which will not work on big amount of data.Some demo code (in my case, I will deal with multiple databases with same table name):I haven't tried on other higher version of laravel. But at least it could work now!More information My previous version of laravel is 5.7.9 which will report the Cardinality violation error. So the laravel team solved this issue in some version of 5.7.x.

Unit Test Laravel's FormRequest

Dov Benyomin Sohacheski

[Unit Test Laravel's FormRequest](https://stackoverflow.com/questions/36978147/unit-test-laravels-formrequest)

I am trying to unit test various custom FormRequest inputs. I found solutions that: I am looking for a solution where I can unit test individual field inputs against the rules (independent of other fields in the same request).Sample FormRequest:Desired Test:How can I unit test (assert) each validation rule of every field in isolation and individually?

2016-05-02 08:28:39Z

I am trying to unit test various custom FormRequest inputs. I found solutions that: I am looking for a solution where I can unit test individual field inputs against the rules (independent of other fields in the same request).Sample FormRequest:Desired Test:How can I unit test (assert) each validation rule of every field in isolation and individually?I found a good solution on Laracast and added some customization to the mix.The CodeUpdateThere is an e2e approach to the same problem. You can POST the data to be checked to the route in question and then see if the response contains session errors.Friends, please, make the unit-test properly, after all, it is not only rules you are testing here, the validationData and withValidator functions may be there too.This is how it should be done:

Cookie session driver won't save any validation error or flash data

ipalaus

[Cookie session driver won't save any validation error or flash data](https://stackoverflow.com/questions/46762477/cookie-session-driver-wont-save-any-validation-error-or-flash-data)

I am having a hard time with the cookie session driver in Laravel.I have a simple form with a validation in place. This is my method for saving this form data:Pretty simple.The problem is that, when using the cookie session driver, if I save this form with a description that's 1024 characters long, I'll get redirected back but with no flash data and no $errors in the view for the next request to handle.Example:This is a POST after using this line:In the description field. 1024 bytes to be exact.Instead, if I just fill the field with some more dummy data but nothing too crazy:If I change the session driver to file:... it works.But this does not fix my problem. I do need to use the cookie driver for session as the production website is running in 3 different datacenters to achieve high availability. Using the cookie for the session allows the user to hit any of the 3 servers and still continue with it's request without having to use any sticky session or any central session driver.Using the database as a driver—which is also in a cluster with HA—is not an option as this is a really high traffic website and that would be a write per request which doesn't sound appealing at all. I would like to prevent that at any cost.There is anyway this can be solved?I must say this is the backoffice of the website, but soon the user in the frontend will be able to also write more than 1024 characters in a textarea... so if I just change the driver for the backoffice doesn't help, as we will run into the same for our users.

2017-10-16 03:20:24Z

I am having a hard time with the cookie session driver in Laravel.I have a simple form with a validation in place. This is my method for saving this form data:Pretty simple.The problem is that, when using the cookie session driver, if I save this form with a description that's 1024 characters long, I'll get redirected back but with no flash data and no $errors in the view for the next request to handle.Example:This is a POST after using this line:In the description field. 1024 bytes to be exact.Instead, if I just fill the field with some more dummy data but nothing too crazy:If I change the session driver to file:... it works.But this does not fix my problem. I do need to use the cookie driver for session as the production website is running in 3 different datacenters to achieve high availability. Using the cookie for the session allows the user to hit any of the 3 servers and still continue with it's request without having to use any sticky session or any central session driver.Using the database as a driver—which is also in a cluster with HA—is not an option as this is a really high traffic website and that would be a write per request which doesn't sound appealing at all. I would like to prevent that at any cost.There is anyway this can be solved?I must say this is the backoffice of the website, but soon the user in the frontend will be able to also write more than 1024 characters in a textarea... so if I just change the driver for the backoffice doesn't help, as we will run into the same for our users.The cookie session driver is not suitable for applications that must store any significant amount of data in the user's session. Browsers typically limit data stored in one cookie to around 4 KB (4096 bytes). As we found, we can easily exhaust this capacity by attempting to store a 1024-character-long string in the session cookie—the "Lorem ipsum..." string in the question contains only ASCII characters, and each ASCII character is represented using 4 bytes, so 1024 × 4 = 4096 bytes. As we can see, we quickly begin to run out of space when we need to store additional items in one session cookie, such as the serialization metadata for PHP values, or when the data contains UTF-8 characters that consume more than 4 bytes per character. To continue to use cookies to store session data greater than 4 KB, we'd need to write a custom session driver that partitions session data across multiple cookies for each response and then reassembles them on each request. For good reason, no existing packages do this that I'm aware of. This brings me to my next point...I want to strongly discourage the use of cookies for storing a full session (instead of just a session ID). This approach can expose security vulnerabilities, adds overhead to requests and responses (including requests for static assets on the same domain), risks desynchronizing data (right-click app tab → Duplicate to see what happers), complicates tests and debugging, and causes problems when storing certain kinds of data.For the distributed application in the question, we have four options: I think we can reasonably eliminate the fourth option. Unless we have a very good reason to avoid using the first three approaches, and for typical applications we usually don't, we cannot justify the amount of work, complexity, and overhead needed to build a system to transfer session data back and forth across HTTP when the first three options are standard, widely-accepted solutions. Based on the information in the question, it sounds to me like you already understand the concepts and implications behind the other three options, so I won't elaborate on explanations for each one (but do comment to let me know if I should). For applications without advanced infrastructure requirements, I recommend the third approach: sticky sessions. These are relatively easy to set up and usually require configuration on the load balancer so that once a client starts a session with an application server, the load balancer routes any subsequent requests to the same server until the session ends. For high-availability, we can combine this approach with the Redis session driver and Redis servers configured for master-slave replication between the datacenters, and, optionally, Redis Sentinel to automate failover. Redis suits session data well and offers better performance than a relational database. If we have multiple application instances at each data center, Redis provides a central location for session data for all instances at one site.For completeness, and to directly answer the question, here's an overview for the development needed to create a cookie-based session driver that handles session data greater than 4 KB. Again, I recommend one of the other approaches described above: If you do decide to go down this path, be sure to test the implementation in every browser you plan to support, as different browsers impose their own limitations on the size and quantity of cookies. Even if we've increased the amount of session data we can store as cookies, we're still limited to the maximum number of cookies a browser will accept per domain.As a final note, storing sessions in the database may not impact performance as much as you think. It could be worth measuring the actual load created by this simple solution before investing many hours optimizing for a concern that might not be a real issue.The browser has limitation of cookie. It's too large for the browser to store the cookie while you use cookie as the session driver. You can check the browser cookie limitation here http://browsercookielimits.squawky.net/  Recommendation:

Use redis as the session driver.Steps:

 1.After installed Redis server, add the predis/predis package:2.Change your configuration file config/database.php:

How to test file upload with laravel and phpunit?

Jasper Kennis

[How to test file upload with laravel and phpunit?](https://stackoverflow.com/questions/33281614/how-to-test-file-upload-with-laravel-and-phpunit)

I'm trying to run this functional test on my laravel controller. I would like to test image processing, but to do so I want to fake image uploading. How do I do this? I found a few examples online but none seem to work for me. Here's what I have:But the controller doesn't get passed this check:So somehow the file isn't passed correctly. How do I go about this?

2015-10-22 12:57:27Z

I'm trying to run this functional test on my laravel controller. I would like to test image processing, but to do so I want to fake image uploading. How do I do this? I found a few examples online but none seem to work for me. Here's what I have:But the controller doesn't get passed this check:So somehow the file isn't passed correctly. How do I go about this?Docs for CrawlerTrait.html#method_action reads:So I assume the correct call should beunless it requires non-empty wildcards and cookies.For anyone else stumbling upon this question, you can nowadays do this:With phpunit you can attach a file to a form by using attach() method.Example from lumen docs:Here is a full example how to test with custom files. I needed this for parsing CSV files with known format so my files had to had exact formatting and contents. If you need just images or random sized files use $file->fake->image() or create() methods. Those come bundled with Laravel.Here is the controller to go with it:The best and Easiest way : First Import the Necessary thingsThen make a fake file to upload.Then make a JSON Data to pass the file. ExampleThen send the Data to your API.I hope it will work.Add similar setUp() method into your testcase:This will spoof your $_FILES global and let Laravel think that there is something uploaded.

Install multiple laravel projects in subfolders without subdomain

Rodrigo Souza

[Install multiple laravel projects in subfolders without subdomain](https://stackoverflow.com/questions/36404259/install-multiple-laravel-projects-in-subfolders-without-subdomain)

I already tried to search for this issue, but it's all different from mine, so I'm posting this here. I'm trying to create a webserver using nginx to host multiple laravel projects in subfolders. It's my labs server. So I'd like to have my projects like this:I'm copying the following nginx location block for each project (i don't know what's happening here, I just copied from the internet and it worked):And RESTful routes in my laravel app like this:

    

Although it seems to work (the page appears, etc) when it goes into bussiness logic (save to database, etc.) it appears to have many bugs. For example when I try to create a new employee in url http://domain.com/project1/administracao/funcionarios it gives me the error: SQLSTATE[42S22]: Column not found: 1054 Unknown column '/administracao/funcionarios' in (it's kinda prepending some url routes)And when I setup a subdomain like project1.domain.com everything works fine. But I don't want to create a subdomain for each project, I want it to work in subfolders url. Is it possible?

2016-04-04 13:37:14Z

I already tried to search for this issue, but it's all different from mine, so I'm posting this here. I'm trying to create a webserver using nginx to host multiple laravel projects in subfolders. It's my labs server. So I'd like to have my projects like this:I'm copying the following nginx location block for each project (i don't know what's happening here, I just copied from the internet and it worked):And RESTful routes in my laravel app like this:

    

Although it seems to work (the page appears, etc) when it goes into bussiness logic (save to database, etc.) it appears to have many bugs. For example when I try to create a new employee in url http://domain.com/project1/administracao/funcionarios it gives me the error: SQLSTATE[42S22]: Column not found: 1054 Unknown column '/administracao/funcionarios' in (it's kinda prepending some url routes)And when I setup a subdomain like project1.domain.com everything works fine. But I don't want to create a subdomain for each project, I want it to work in subfolders url. Is it possible?I have successfully run a Laravel 5.4 project in a "subfolder" of another site by using a simple symlink. There was no funky special rewrite rules in the Nginx configuration. No copy & paste of sections of the project. No mention of the subfolder in the routes. Just a regular Laravel 5 project neatly contained somewhere on the server and a symlink to it's public folder from the main site's document root. All the routes just work! When writing your views you do have to wrap the paths for client-side assets in asset() helper function so the paths in the HTML will contain the subfolder and the browser can find them. But doing that does not make your code less flexible, because if you do run the site in an environment where it is not accessed via a subfolder, it works because asset() works with what the address bar contains. Recently I had the exact same problem. I wanted to havebut I hated having to modify nginx conf every time I added a new project.Here's what I came up with:The result is that I don't have to do ANYTHING other than git clone in /sites/customerdemo.example.com/ folder and run composer install and php artisan migrate to add a new project.Actually, I have developed myself a control panel where I can click on "Add project" and specify project details and a new bitbucket repo, mysql user and database will be created and customerdemo server will be given deploy access to this bitbucket repo and a webhook is set up in this new repo which will call a deployment script on customerdemo server each time someone commits to master on this repo which will trigger either git clone or git pull and composer install and database migration. That's why I needed dynamic Nginx configuration. ;-)I think the problem might be in your nginx.conf file. Try this:Also, please be sure that /home/web/project1/ is outside of your web root.This being said, it is really not recommended to run Laravel in a subfolder. Much easier in a subdomain.I got the basic idea for this suggestion from this gist.Not completely sure about the solution, but I think you should try these ones:In last instance, var_dump the model and look for where it comes from.have you tried this configuration ?https://gist.github.com/tsolar/8d45ed05bcff8eb75404I will test tomorrow as soon I have time to replicate your situation in my env.There is a simple solution to " I want it to work in subfolders url. Is it possible?".Steps

 1. make folder inside of your main domain public folder.

 you need to create 3 folders 

home/web/public/project1

home/web/public/project2

home/web/public/project3

 2. Inside each project folder you need to paste the content of the public folder of your laravel app

(from your Laravel Project) project1/public/{contents}  -- copy this to -->(hosted server) home/web/public/project1/{contents} require __DIR __.'/../../PROJECTONE/bootstrap/autoload.php';$app = require_once __DIR __.'/../../PROJECTONE/bootstrap/app.php';try something like this .... I'm using following .conf for my server :Check this Nginx configuration I believe it will helps you 

Laravel migrations/db:seed super slow

JSelser

[Laravel migrations/db:seed super slow](https://stackoverflow.com/questions/31706146/laravel-migrations-dbseed-super-slow)

I recently upgraded from my old Windows computer into a gen. 4 I7 Ubuntu 15.04Runs like a dream, well...Except that any Laravel artisan command that touch the database takes a million years to complete, while my old computer performed any of those commands in seconds.The major difference is that instead of XAMPP I'm running MySQL as a local service.Also in my old computer I could see how migrations slowly showed on screen as they appear to be processed while now, it takes like 2~5 minutes and when done the whole migration list is shown at once.

This could indicate a bottle neck of sort somewhere.Somewhere around the internet someone said to use '127.0.0.1' instead of 'localhost' because of DSN resolution. Didn't solve it.To make sure that's not the issue i ran~halpEditI collected the running times for each query from the framework, I have LOTS of migrations, analyzing the data I found there's nothing insanely slow (like a query running for a minute). Here's a link with the data. Actual queries were ommited in favor of my employer. Although there's many queries running for a second or longer, the slowest, number 221 takes a whoping 3.5 seconds. I have around a hundred migrations(I know) but here's the thing, if each migration took a second I'd be waiting around a minute and a half to migrate, but it often takes from 4 to 5 minutes.As suggested by oliverpool, I did some profiling by replaying queries on the mysql via terminal, but I never had to wait longer than a second with the average query taking around thenth of a second.Here is a pic of the profiling for the slowest query (3.5secs in migration, not close to a second in the pic)Maybe this points towards the connection? By the way the slow query log is empty after running the migrations.Also, I'm using laravel 5 now and the behaviour is the same. I dont know how to trouble shoot connection so I guess some googling is in order, any suggestions are welcome.Thanks in advance.

2015-07-29 16:29:06Z

I recently upgraded from my old Windows computer into a gen. 4 I7 Ubuntu 15.04Runs like a dream, well...Except that any Laravel artisan command that touch the database takes a million years to complete, while my old computer performed any of those commands in seconds.The major difference is that instead of XAMPP I'm running MySQL as a local service.Also in my old computer I could see how migrations slowly showed on screen as they appear to be processed while now, it takes like 2~5 minutes and when done the whole migration list is shown at once.

This could indicate a bottle neck of sort somewhere.Somewhere around the internet someone said to use '127.0.0.1' instead of 'localhost' because of DSN resolution. Didn't solve it.To make sure that's not the issue i ran~halpEditI collected the running times for each query from the framework, I have LOTS of migrations, analyzing the data I found there's nothing insanely slow (like a query running for a minute). Here's a link with the data. Actual queries were ommited in favor of my employer. Although there's many queries running for a second or longer, the slowest, number 221 takes a whoping 3.5 seconds. I have around a hundred migrations(I know) but here's the thing, if each migration took a second I'd be waiting around a minute and a half to migrate, but it often takes from 4 to 5 minutes.As suggested by oliverpool, I did some profiling by replaying queries on the mysql via terminal, but I never had to wait longer than a second with the average query taking around thenth of a second.Here is a pic of the profiling for the slowest query (3.5secs in migration, not close to a second in the pic)Maybe this points towards the connection? By the way the slow query log is empty after running the migrations.Also, I'm using laravel 5 now and the behaviour is the same. I dont know how to trouble shoot connection so I guess some googling is in order, any suggestions are welcome.Thanks in advance.In this case, I think that the buffer pool size increment is required. Set the following:

Handling Mysql Spatial datatypes in Laravel Eloquent ORM

Jithin Jose

[Handling Mysql Spatial datatypes in Laravel Eloquent ORM](https://stackoverflow.com/questions/30682538/handling-mysql-spatial-datatypes-in-laravel-eloquent-orm)

How to handle mysql spatial datatypes in eloquent ORM?, This include how to create migration, insert spatial data and performing spatial query's. If there is not actual solutions exists, is there any workarounds?

2015-06-06 11:54:11Z

How to handle mysql spatial datatypes in eloquent ORM?, This include how to create migration, insert spatial data and performing spatial query's. If there is not actual solutions exists, is there any workarounds?A workaround I have implemented a while ago is to have a latitude and longitude fields on the model with the following validations (see Validator class):The magic comes on the boot method of the model, which sets the correct value of the spatial point field:About migrations, like @jhmilan says you can always use the Schema::create and DB::statement methods to customize the migration.It is available to use https://github.com/grimzy/laravel-mysql-spatialyou may use:then you are able to run queries on the 'location' field.to store model you may use:to retrieving a model you should use:

How to create the migrations for database views using php artisan in Laravel?

rc.adhikari

[How to create the migrations for database views using php artisan in Laravel?](https://stackoverflow.com/questions/36287364/how-to-create-the-migrations-for-database-views-using-php-artisan-in-laravel)

Actually, I have managed to create a sql views for Laravel using PHP Artisan using below step.Step 1. Run below command:Step 2.Open the migration file and add the below code:Step 3. To call and run the SQL Views via Laravel queryHope that helps. Please let me know if anyone has better solution!!

2016-03-29 14:33:46Z

Actually, I have managed to create a sql views for Laravel using PHP Artisan using below step.Step 1. Run below command:Step 2.Open the migration file and add the below code:Step 3. To call and run the SQL Views via Laravel queryHope that helps. Please let me know if anyone has better solution!!Stumbled on the same issue and found the solution @ http://programmingarehard.com/2013/11/10/eloquent_and_views.html/I've created a package for creating, renaming and dropping views:

https://github.com/staudenmeir/laravel-migration-viewsYou can provide a query builder instance or an SQL string:You can also try this DB::connection()->getPdo()->exec("your sql query");  it worksWrite your migration like this, with 'CREATE OR REPLACE' in up function:You have to use laravel eloquent an create the relation between in your model.

Forexample:

If you have 2 table (roles , users) and the relation between them  is many to many you have to create to model Role and User after that in Role Model write the code below:

    public function users()

    {

    return $this->belongaToMany('App/User');

    }and in User model:after that create a new migration and put the table name role_user and put the code below into this:Save it and run php artisan migrate.

Its finished and now you have many to many relation.

After all of this for geting query forexample for related role to a user add your User and Role model to your controler an do like this:and to show the selected roles into your view write:Its finished.

Generate HTML to show custom questions with the correct type (text, checkbox, …) and add the required attribute properly

johnW

[Generate HTML to show custom questions with the correct type (text, checkbox, …) and add the required attribute properly](https://stackoverflow.com/questions/50724984/generate-html-to-show-custom-questions-with-the-correct-type-text-checkbox)

I have a form for a user create custom questions. For that the user needs to introduce the question (ex: Whats your phone?) and also the type of field (text, long text, checkbox, select menu, radio button). If the user selects a field of checkbox, select menu or radio button he also need to introduce the available options for the question.In the database the questions are inserted in the questions and question_options tables like:Questions Table:Registration_type_questions pivot table:The options are stored in the questions_options table:Then in the view I want to show properly in the view registration.blade.php the inputs (text, radio button, checkbox, select, textarea and input file) based on the type stored in the column "type" of the questions table. And also add the required attribute if the required column in the pivot table is "1".When a question is of the type text, radio button, select, textarea or file it is working fine, the required attribute is added to the form field. But it's not working properly with checkboxes because in the case of checkboxes if the question is of type checkbox and the question is required that should mean that the user needs to answer that question but should not mean that the user needs to check all checkboxes. The issue is that with the function getHTMLInput() the generated html for checkboxes have required in each checkbox input and because of that the user needs to check all checkboxes:Do you know how to solve that issue? When a custom question is required that should mean that the question is required so the user should select at least 1 checkbox but should not mean that the user needs to check all checkboxes.And also do you know how to, if the custom question is required add inside each question label this "<span class="text-primary">*</span>"?GetHtmlInput() in the Question model:Then the getHtmlInput() is used like:Generated HTML with getHTMLInput():Also, checking this form in a HTML validator like w3c validator it appears some errors:

2018-06-06 16:11:20Z

I have a form for a user create custom questions. For that the user needs to introduce the question (ex: Whats your phone?) and also the type of field (text, long text, checkbox, select menu, radio button). If the user selects a field of checkbox, select menu or radio button he also need to introduce the available options for the question.In the database the questions are inserted in the questions and question_options tables like:Questions Table:Registration_type_questions pivot table:The options are stored in the questions_options table:Then in the view I want to show properly in the view registration.blade.php the inputs (text, radio button, checkbox, select, textarea and input file) based on the type stored in the column "type" of the questions table. And also add the required attribute if the required column in the pivot table is "1".When a question is of the type text, radio button, select, textarea or file it is working fine, the required attribute is added to the form field. But it's not working properly with checkboxes because in the case of checkboxes if the question is of type checkbox and the question is required that should mean that the user needs to answer that question but should not mean that the user needs to check all checkboxes. The issue is that with the function getHTMLInput() the generated html for checkboxes have required in each checkbox input and because of that the user needs to check all checkboxes:Do you know how to solve that issue? When a custom question is required that should mean that the question is required so the user should select at least 1 checkbox but should not mean that the user needs to check all checkboxes.And also do you know how to, if the custom question is required add inside each question label this "<span class="text-primary">*</span>"?GetHtmlInput() in the Question model:Then the getHtmlInput() is used like:Generated HTML with getHTMLInput():Also, checking this form in a HTML validator like w3c validator it appears some errors:It is because you have the checkbox group html inside your foreach loop here:You need to think about how you would get around this maybe using a variable like $checkboxesFound and set it to 0 at the start of the function and when case is checkbox, increment the variable, and if $checkboxesFound == 0 then echo the group div.Replace your getHtmlInput() with thisandblade code with thisyou need to set the name attribute same of same group options in order to work required option properly.But in your code all options including of different option groups are sharing same name attribute.The above code is not tested. But I hope it will work for youHTML5 doesn't have a solution to implement that a group of checkboxes should be required, so with some changes you could achieve it. First on your controller you will need to change it to achieve the same you are doing with your select menu.Then in your case 'checkbox' you would only need to print the options that will be inside your 'required group of checkboxs':This should output the following html:Then  on submit, I don't know if you do it with ajax or not but I'll assume you do not, so if you add an id to your form -> id="questionForm"Unfortunately there is no way to achieve what you are looking for  using only html5, whatever solution you choose it will probably have to be done with js.

Extend Blueprint class?

mpen

[Extend Blueprint class?](https://stackoverflow.com/questions/22444685/extend-blueprint-class)

I want to override the timestamps() function found in the Blueprint class. How can I do that?e.g.,

2014-03-16 23:44:37Z

I want to override the timestamps() function found in the Blueprint class. How can I do that?e.g.,There is a new blueprintResolver function which takes a callback function which then returns the Blueprint instance.So create your custom Blueprint class like this:And then call the blueprintResolver function where you return your CustomBlueprint instance. I'm not sure if creating a new schema instance with  DB::connection()->getSchemaBuilder(); is state of the art but it works.You could additionally override the Schema facade and add the custom blueprint by default.Just to add a few points to Marcel Gwerder's answer (which is already great):

(edit 2016-03-06)A GitHub issue has been recently opened about this: #12539.Marcel Gwerder's answer was a life saver. Like some of the users commented there, I wondered if this could be done more automagically. My goal was similarly to overwrite the timestamps method. After some tinkering, this is what I ended up with which is working for me:I created a file at app/Classes/Database/Blueprint.php:I created a file at app/Facades/Schema.phpInside config/app.php I updated the alias for Schema as follows:Now, in my migrations, like the below, when I call timestamps(), it calls my overwritten method.

Two models into one paginated query with eager loaded relations using Laravel

whoacowboy

[Two models into one paginated query with eager loaded relations using Laravel](https://stackoverflow.com/questions/33354721/two-models-into-one-paginated-query-with-eager-loaded-relations-using-laravel)

I have two  Models that I would like to merge into one timeline. I have been able to do this by creating a View in mysql that normalizes and unions the tables. I created a Model for this view, NewsFeed. This works well if I do not want related Comment model. I have gotten close to this by overriding the getMorphClass method on the model. This allows me to get the related comments for the pictures, but not the posts, because when getMorphClass is called the model doesn't have any data. I am open to any approach on how to solve this, not just the way I am proposing, but I don't want to pull more data than I have to from the database.NewsFeedMySQL Viewpictures tableposts

2015-10-26 20:11:28Z

I have two  Models that I would like to merge into one timeline. I have been able to do this by creating a View in mysql that normalizes and unions the tables. I created a Model for this view, NewsFeed. This works well if I do not want related Comment model. I have gotten close to this by overriding the getMorphClass method on the model. This allows me to get the related comments for the pictures, but not the posts, because when getMorphClass is called the model doesn't have any data. I am open to any approach on how to solve this, not just the way I am proposing, but I don't want to pull more data than I have to from the database.NewsFeedMySQL Viewpictures tablepostsYou are really close with your idea to build a view. In fact, if you create an actual table instead of a view, the solution becomes quite simple.With a 'FeedItem' polymorph object that points to your Post class or Picture class, you can attach the comments directly to the FeedItem with a hasMany relationship.This solution may require some refactoring on your forms since you will need to create a FeedItem entry for each Post entry and Picture entry. Event listeners for Picture::created and Post::created should do the trick (http://laravel.com/docs/5.1/eloquent#events).Once it's set up, you can use:Although I am not familiar with Laravel nor Eloquent for that matter, Here's my input on this.Assuming you're getting the output from that SQL view into $EntriesAs I understand Eloquent allows you to set the values for yourself, therefore something like this might work for you (I am not sure about the syntax or usage for that matter).

Laravel 5.3 - Clear config cache in shared hosting

Wahyu Handy

[Laravel 5.3 - Clear config cache in shared hosting](https://stackoverflow.com/questions/41521837/laravel-5-3-clear-config-cache-in-shared-hosting)

Currently I'm working on small project that require me to host my laravel app on shared hosting (please ignore the reason why I didn't use VPS to host my laravel project) and this hosting provider disable escapeshellarg() for security reason so I can't use php artisan config:cache to clear config cache.Is there any workaround for this?

2017-01-07 13:15:07Z

Currently I'm working on small project that require me to host my laravel app on shared hosting (please ignore the reason why I didn't use VPS to host my laravel project) and this hosting provider disable escapeshellarg() for security reason so I can't use php artisan config:cache to clear config cache.Is there any workaround for this?config:clear command just deletes bootstrap/cache/config.php file, so just delete this file manually.You can call artisan commands programmaticallyThis can be helpful in setups where the PHP user has a different set of permissions than the FTP user (so files created by PHP cannot be deleted via FTP)Try also for command lineusing artisan commandshttps://www.tutsmake.com/laravel-clear-cache-using-artisan-command-cli/

Laravel validation checkbox

Sander Van Keer

[Laravel validation checkbox](https://stackoverflow.com/questions/37345363/laravel-validation-checkbox)

I am using the laravel register function to register a user. I added a checkbox where the user needs to accept the terms and conditions. I only want to user to register when the checkbox is checked. Can I use the 'required' validation in laravel? This is my validation function:When I use the function like this, laravel gives the required error for the checkbox even if it is checked. This is the html of the checkboxI hope you guys can help me!

2016-05-20 11:19:53Z

I am using the laravel register function to register a user. I added a checkbox where the user needs to accept the terms and conditions. I only want to user to register when the checkbox is checked. Can I use the 'required' validation in laravel? This is my validation function:When I use the function like this, laravel gives the required error for the checkbox even if it is checked. This is the html of the checkboxI hope you guys can help me!Use the accepted rule.Sample for your case:It will work, just be sure the input value will not be an empty string or false. And 'checkbox' =>'required' is ok as long as the key is the value of the input name attribute.I just had a big frustration, because the code i'm using returns the checkbox value as a boolean value.If you have a similar situation you can use the following rule:Use  required_without_all for checkbox :Refer : https://laravel.com/docs/5.1/validation#available-validation-rulesYour validation rules must corrolate with the name attributes of your html form fields:

revert 'php artisan serve' command in laravel

halkujabra

[revert 'php artisan serve' command in laravel](https://stackoverflow.com/questions/23932127/revert-php-artisan-serve-command-in-laravel)

I have a laravel app. I ran 'php artisan serve' command for local testing and my app was served at localhost:8000. But now I want to stop serving it at localhost:8000 ie., I want it not to serve now. I closed the command line, restarted the server but it is still serving. How can it be done?Note: I am using windows for testing purposes.

2014-05-29 11:19:54Z

I have a laravel app. I ran 'php artisan serve' command for local testing and my app was served at localhost:8000. But now I want to stop serving it at localhost:8000 ie., I want it not to serve now. I closed the command line, restarted the server but it is still serving. How can it be done?Note: I am using windows for testing purposes.Press Ctrl + Shift + ESC. Locate the php process running artisan and kill it with right click -> kill process.Reopen the command-line and start back the server.Note that you should be able to kill the process just by sending it a kill signal with Ctrl + C.here is what i do 

press ctrl+ cto check if the port is busy or not  if any process is listening to the port 8000 it will be displayed with port id kill the process that listen to that port id run lsof agin volaI used Ctrl + C in my mac for stop the command php artisan laravel serveFor windows user, type this command for showing the list of current running php artisan process:Will show:Look up PID number (XXXX), and type this to kill the process:Windows 10 with XAMPP server depending on what shell you use to run:In Windows CMD: CTRL + C

In XAMPP Shell: CTRL + Pause/Break

In Ubuntu and RedHat/CentOS terminal  it's: CTRL + CCtrl + Pause|Break should do it for Windows.If your using VS Code, simply do the following:This deletes the shell and kills the server.When I use cygwin to run my php artisan serve on Windows machine, pressing ctrl + c does not kill the process. To stop it, use @jsalonen's solution. Basically you are looking for this then kill it:

How to get last insert id in Eloquent ORM laravel

Deenadhayalan Manoharan

[How to get last insert id in Eloquent ORM laravel](https://stackoverflow.com/questions/27873777/how-to-get-last-insert-id-in-eloquent-orm-laravel)

I am performing a database operation with "Eloquent ORM in Laravel". I just want to take the last insert id (not the maximum id) in the database.I searched to get last insert id in laravel Eloquent ORM, I got following link (Laravel, get last insert id using Eloquent) that is refer to get last insert id from following function "$data->save()".But I need to get "Model::create($data)";My Query:How can I retrieve the last inserted id?

2015-01-10 07:12:19Z

I am performing a database operation with "Eloquent ORM in Laravel". I just want to take the last insert id (not the maximum id) in the database.I searched to get last insert id in laravel Eloquent ORM, I got following link (Laravel, get last insert id using Eloquent) that is refer to get last insert id from following function "$data->save()".But I need to get "Model::create($data)";My Query:How can I retrieve the last inserted id?Like the docs say: Insert, update, delete So in your sample:then on table2 it is going to be**** For Laravel ****You could wrap your data in the insertGetId() method like thisIn this case the array $data would look something like thisand  if you’re using the DB façade you could just append the lastInsertID() method to your query.As others said bfore me you may retrieve id by usingbut only if you are using standard naming convention for eloquent. If you want to use other name for primaryKey column, eg:you may retrieve last inserted id by callingIt is described in: https://laravel.com/docs/master/eloquent#eloquent-model-conventions where one can find:You may do it as,Hope this will help you.This is my try:And use $model_ins->id.This code works with Laravel 5.3:User pages/site I was call data.idThis is an eloquent model:A solution using Query Builder:This is my solution. I return the inserted object and get its ID or any other property.This is an easier way that works on all of the ways that you inserted:

Laravel 5.3 return custom error message using $this->validate()

cmac

[Laravel 5.3 return custom error message using $this->validate()](https://stackoverflow.com/questions/40067212/laravel-5-3-return-custom-error-message-using-this-validate)

How to return a custom error message using this format?

2016-10-16 05:35:15Z

How to return a custom error message using this format?to get custom error message you need to pass custom error message on third parameter,like that For Multiple Field, Role and Field-Role Specific Messagehttps://laravel.com/docs/5.3/validation#working-with-error-messages"In most cases, you will probably specify your custom messages in a language file instead of passing them directly to the Validator. To do so, add your messages to custom array in the resources/lang/xx/validation.php language file."You need to first add following lines in view page where you want to show the Error message:Here is a demo controller by which error message will appear on that page:For details You can follow the Blog post. 

Besides that you can follow laravel official doc as well Validation. 

Laravel 4 - how to return all validation error messages for all fields as a JSON structure?

mtmacdonald

[Laravel 4 - how to return all validation error messages for all fields as a JSON structure?](https://stackoverflow.com/questions/19422259/laravel-4-how-to-return-all-validation-error-messages-for-all-fields-as-a-json)

I'm upgrading from Laravel 3 to Laravel 4. My app has some AJAX-only forms that are rendered client-side (i.e. there are no server-side views). Therefore, instead of passing validation errors to views with the withErrors() method, I've been returning the validation error objects to the client as JSON structures.  In Laravel 3, I had this:But in Laravel 4, the error messages are protected:var_dump($validation->messages()) returns:json_encode($validation->messages) returnsQuestion: how do I return all the validation error messages for all fields as a JSON structure in Laravel 4?

2013-10-17 08:59:49Z

I'm upgrading from Laravel 3 to Laravel 4. My app has some AJAX-only forms that are rendered client-side (i.e. there are no server-side views). Therefore, instead of passing validation errors to views with the withErrors() method, I've been returning the validation error objects to the client as JSON structures.  In Laravel 3, I had this:But in Laravel 4, the error messages are protected:var_dump($validation->messages()) returns:json_encode($validation->messages) returnsQuestion: how do I return all the validation error messages for all fields as a JSON structure in Laravel 4?Simply use toJson() method.Here is another way that let u add HTTP code to the response:I discovered it was possible to use the toArray() method:I think that this is the Laravel way to get the error messages. There are special methods to get them. So here how I do this stuff:This produces output in the following format:

Convert laravel object to array

Your Friend

[Convert laravel object to array](https://stackoverflow.com/questions/26174267/convert-laravel-object-to-array)

Laravel output:I want to convert this into normal array. Just want to remove that stdClass Object. I also tried using ->toArray(); but I get an error:How can I fix this?Functionalities have been Implemented on http://www.srihost.com

2014-10-03 06:32:01Z

Laravel output:I want to convert this into normal array. Just want to remove that stdClass Object. I also tried using ->toArray(); but I get an error:How can I fix this?Functionalities have been Implemented on http://www.srihost.comUPDATE since version 5.4 of Laravel it is no longer possible.You can change your db config, like @Varun suggested, or if you want to do it just in this very case, then:For New Laravel above 5.4 (Ver > 5.4) 

see https://laravel.com/docs/5.4/upgrade fetch mode sectionOr when toArray() fails because it's a stdClass Not working? Maybe you can find your answer here:Convert PHP object to associative arrayYou can also get all the result always as array by changingHope this will help.this worked for me:or Just in case somebody still lands here looking for an answer. It can be done using plain PHP. 

An easier way is to reverse-json the object. this worked for me in laravel 5.4outputhttps://laravel.com/docs/5.4/collections#method-allYou need to iterate over the arrayans use (array) conversion because you have array of objects of Std class and not object itselfExample:Output for this is:as expected. Object of stdClass has been converted to array.If you want to get only ID in array, can use array_map:With that, return an array with ID in every pos.Its very simple. You can use like this :-Hope it helpsIt's also possible to typecast an object to an array. That worked for me here.(array) $object;will converttoHad the same problem when trying to pass data from query builder to a view. Since data comes as object. So you can do:And in your view you use variables likeI suggest you simply do this within your methodWith this all you need is to pass the string 'array' as your argument and Voila! An Associative array is returned.$foo = Bar::getBeers();

$foo = $foo->toArray();I use get(), it returns an object, I use the attributesToArray() to change the object attribute to an array.

Set session variable in laravel

user3429578

[Set session variable in laravel](https://stackoverflow.com/questions/28417796/set-session-variable-in-laravel)

I would like to set a variable in the session using laravel this waybut the problem is that I don't know where to put this code, 'cause I would like to set it for one time (when the guest visite the home page or any other page)?

The main idea is to use a global variable to use it in all application controllers, I heared about something related to configuration variables but I'm not sure if it will be a good Idea to use config variables or only the session?

Thanks

2015-02-09 19:33:30Z

I would like to set a variable in the session using laravel this waybut the problem is that I don't know where to put this code, 'cause I would like to set it for one time (when the guest visite the home page or any other page)?

The main idea is to use a global variable to use it in all application controllers, I heared about something related to configuration variables but I'm not sure if it will be a good Idea to use config variables or only the session?

ThanksThe correct syntax for this is...For Laravel 5.4 and later, the correct method to use is put.To get the variable, you'd use...If you need to set it once, I'd figure out when exactly you want it set and use Events to do it.  For example, if you want to set it when someone logs in, you'd use...I think your question ultimately can be boiled down to this:The obvious answer is that it depends.  What it depends on are a couple of factors:ConfigIf the value is the same for everyone and will seldom change, the best place to probably put it is in a configuration file somewhere underneath app/config, e.g. app/config/companyname.php:You could access this value from anywhere in your application via Config::get('companyname.somevalue')SessionIf the value you are intending to store is going to be different for each user, the most logical place to put it is in Session.  This is what you allude to in your question, but you are using incorrect syntax.  The correct syntax to store a variable in Session is:The correct syntax to retrieve it back out later is:As far as when to perform these operations, that's a little up to you.  I would probably choose a route filter if on Laravel 4.x or Middleware if using Laravel 5.  Below is an example of using a route filter that leverages another class to actually come up with the value:In Laravel 5.6, you will need to set it asTo retrieve it is as simple as in Laravel 5.4use this method:For example, To store data in the session, you will typically use the putmethod or the session helper:orfor retrieving an item from the session, you can use get :or global session helper : To determine if an item is present in the session, you may use the has method:You can try To add to the above answers, ensure you define your function like this:Note the "(Request $request)", now set a session like this:And retrieve the session in this way:To erase the session try this:orIn Laravel 6.xhttps://laravel.com/docs/6.x/sessionto set session you can try this:also to get session data you can try this:If you want to get all session data:

Using a Progress Bar while Seeding a database in Laravel

Sevenearths

[Using a Progress Bar while Seeding a database in Laravel](https://stackoverflow.com/questions/37319676/using-a-progress-bar-while-seeding-a-database-in-laravel)

I have to seed quite a lot of data into a database and I want to be able to show the user a progress bar while this happens. I know this is documented:but I'm having problems including it in my seeder.orfrom https://mattstauffer.co/blog/advanced-input-output-with-artisan-commands-tables-and-progress-bars-in-laravel-5.1Any ideas?

2016-05-19 09:51:28Z

I have to seed quite a lot of data into a database and I want to be able to show the user a progress bar while this happens. I know this is documented:but I'm having problems including it in my seeder.orfrom https://mattstauffer.co/blog/advanced-input-output-with-artisan-commands-tables-and-progress-bars-in-laravel-5.1Any ideas?You can get access to output through $this->command->getOutput()Your code isn't working because you're using $this->output in the wrong class. If you take a look again to the article you shared, $this-output is used in an Artisan command class.In fact, every Artisan command is made with the Symfony Console component.You're actually trying to use it in a database seeder :)My suggestion: build your seeders and then call them with an "install" or "seed" customized command for your needs.Here is my implementation code,Just in case anyone else comes across a similar scenario and is looking for a solution I created the following base class:And then used it something like this...

Laravel - htmlspecialchars() expects parameter 1 to be string, object given

Kiddo

[Laravel - htmlspecialchars() expects parameter 1 to be string, object given](https://stackoverflow.com/questions/43217872/laravel-htmlspecialchars-expects-parameter-1-to-be-string-object-given)

I go this error: I'm using in controller:And i send it to the view as array: 'data' => $newData

And when i try to use $data into the view, it give me that errorTried already to use $data->ac OR $data['ac'] but still the same...

Some help, please?

2017-04-04 21:18:27Z

I go this error: I'm using in controller:And i send it to the view as array: 'data' => $newData

And when i try to use $data into the view, it give me that errorTried already to use $data->ac OR $data['ac'] but still the same...

Some help, please?When you use a blade echo {{ $data }} it will automatically escape the output. It can only escape strings. In your data $data->ac is an array and $data is an object, neither of which can be echoed as is. You need to be more specific of how the data should be outputted. What exactly that looks like entirely depends on what you're trying to accomplish. For example to display the link you would need to do {{ $data->ac[0][0]['url'] }} (not sure why you have two nested arrays but I'm just following your data structure).if your intention is send the full array from the html to the controller, can use this:from the blade.php:in controllerYou could use serializeBut best way in this case use the json_encode method in your blade and json_decode in controller.This is the proper way to access data in laravel :

413 Request Entity Too Large

AhmedShawky

[413 Request Entity Too Large](https://stackoverflow.com/questions/26608606/413-request-entity-too-large)

I use nginX/1.6 and laravel when i posted data to server i get this error 413 Request Entity Too Large. i tried many solutions as bellowAfter restarting php5-fpm and nginx the problem still not solved

2014-10-28 12:39:42Z

I use nginX/1.6 and laravel when i posted data to server i get this error 413 Request Entity Too Large. i tried many solutions as bellowAfter restarting php5-fpm and nginx the problem still not solvedAdd ‘client_max_body_size xxM’ inside the http section in /etc/nginx/nginx.conf, where xx is the size (in megabytes) that you want to allow.I had the same issue but in docker. when I faced this issue, added client_max_body_size 120M; to my Nginx server configuration,nginx default configuration file path is /etc/nginx/conf.d/default.confit resizes max body size to 120 megabytes.after that, I did add these three lines to my PHP docker file since docker PHP image automatically includes all setting files from the path (/usr/local/etc/php/conf.d/) into php.ini file, PHP configuration file will change by these three lines and the issue must disappear

Run Laravel 5 seeder programmatically instead of from CLI

geoffs3310

[Run Laravel 5 seeder programmatically instead of from CLI](https://stackoverflow.com/questions/28799779/run-laravel-5-seeder-programmatically-instead-of-from-cli)

Is there a way to run the Laravel 5 seeder from within PHP rather than from the command line. The hosting I am using doesn't allow me to use the command line. Just to confirm I want to do the equivalent of this but in my app code:

2015-03-01 22:11:47Z

Is there a way to run the Laravel 5 seeder from within PHP rather than from the command line. The hosting I am using doesn't allow me to use the command line. Just to confirm I want to do the equivalent of this but in my app code:You can use the following method:To get the output of the last run command, you can use:You can also call directly the Seeder class if needed. 

Just make sure you did a composer dump-autoload if you created your seeder manually. From there code is very straightforward : You can add parameters to the seeder on runexample//school meal

Laravel 5.2 Auth not Working

Hassan Saqib

[Laravel 5.2 Auth not Working](https://stackoverflow.com/questions/34548061/laravel-5-2-auth-not-working)

As you guys know Laravel 5.2 was released a few days ago. I am trying this new version. I made a new project using the following command on CLI:As per documentation of Authentication Quickstart, I followed the following command  to scaffold  routes and views of authentication:It worked fine. Registration is working fine. But I am facing problem in Login. After login I tested following in route.php file:Auth::user() is returning null and also Auth::check() and Auth::guest() are not working appropriately. I have tried same thing again and again two three times by making new projects but couldn't get the correct results.Below is the complete route.phpCan anyone help me? or Is anyone facing the same problem? How can I fix it?

2015-12-31 14:55:53Z

As you guys know Laravel 5.2 was released a few days ago. I am trying this new version. I made a new project using the following command on CLI:As per documentation of Authentication Quickstart, I followed the following command  to scaffold  routes and views of authentication:It worked fine. Registration is working fine. But I am facing problem in Login. After login I tested following in route.php file:Auth::user() is returning null and also Auth::check() and Auth::guest() are not working appropriately. I have tried same thing again and again two three times by making new projects but couldn't get the correct results.Below is the complete route.phpCan anyone help me? or Is anyone facing the same problem? How can I fix it?Laravel 5.2 introduces the middleware groups concept: you can specify that one or more middleware belongs to a group, and you can apply a middleware group to one or more routesBy default Laravel 5.2 defines a group named web, used to group the middleware handling session and other http utilities:So, if you want session handling, you should use this middleware group for all the routes in which you want to use authentication:UPDATE FOR LARAVEL VERSION >= 5.2.27As of Laravel 5.2.27 version, all the routes defined in routes.php are using by default the web middleware group. That is achieved in app/Providers/RouteServiceProvider.php :So you don't need anymore to add manually the web middleware group to your routes.Anyhow, if you want to use the default authentication for a route, you still need bind the auth middleware to the route

What is the best practice to create a custom helper function in php Laravel 5?

cyber8200

[What is the best practice to create a custom helper function in php Laravel 5?](https://stackoverflow.com/questions/30804201/what-is-the-best-practice-to-create-a-custom-helper-function-in-php-laravel-5)

the default created_at date keep printing out as an MySQL format : 2015-06-12 09:01:26. I wanted to print it as my own way like 12/2/2017, and other formats in the future.a file called DataHelper.php and store it at /app/Helpers/DateHelper.php - and it looks like this to be able to called it in my blade view like I'm not sure what to do next.What is the best practice to create a custom helper function in php Laravel 5?

2015-06-12 13:21:32Z

the default created_at date keep printing out as an MySQL format : 2015-06-12 09:01:26. I wanted to print it as my own way like 12/2/2017, and other formats in the future.a file called DataHelper.php and store it at /app/Helpers/DateHelper.php - and it looks like this to be able to called it in my blade view like I'm not sure what to do next.What is the best practice to create a custom helper function in php Laravel 5?That should do it. :)Since your Helper method is static you could add your helper class to config/app alias just like a Facade, like so:Then later in your view:However, if you are also looking for a way to do this without a helper class. You may consider using Mutators and Appends in your model:Later you can do

Laravel - Artisan not working

He Hui

[Laravel - Artisan not working](https://stackoverflow.com/questions/21882897/laravel-artisan-not-working)

I'm aware of the other questions out there, but they are different to my situation.I installed a fresh copy of my own laravel, and I tried running php artisan list, which works.Now, I have a colleague who has installed a copy of laravel himself, and he pushes his entire directory onto a git repository. I pulled the entire branch off the repository, and tried running php artisan list, but nothing happens this time. I mean, literally, nothing happens.Any ideas as to why this is happening?

2014-02-19 14:07:49Z

I'm aware of the other questions out there, but they are different to my situation.I installed a fresh copy of my own laravel, and I tried running php artisan list, which works.Now, I have a colleague who has installed a copy of laravel himself, and he pushes his entire directory onto a git repository. I pulled the entire branch off the repository, and tried running php artisan list, but nothing happens this time. I mean, literally, nothing happens.Any ideas as to why this is happening?Generally speaking, the vendor directory is not committed to VCS, as such, doing a clone on a standard Laravel app won't include all its dependencies.Once you have cloned, doing composer install (or composer update if you want the latest packages as a developer) will fetch the dependencies and allow your app to work.You need to run composer install, so the composer refresh all dependencies, artisan's begin on the middle. That should do the job!My artisan was not working because i had the following lines in my routes.phpI simply commented the exit(). So my code becomes as followsJust to point out some thing to anyone struggling with artisan, as this answer is 1st link in google to artisan CLI empty line:It will print blank line whenever some error happens, even if you have all dependencies installed with composer install. And it won't tell you exactly what is wrong. I couldn't figure it out until I put into artisan file in the root directory this:That forced artisan CLI to show error message and therefore I was able to fix it (my .env file was broken).Hope this helps someone.In my case problem was to connect artisan with database (migrates) i.e. the command was not working.I was running laravel project on 8888 port.

In this case I updated .env file as:

DB_HOST=localhost to DB_HOST=localhost to DB_HOST=127.0.0.1

and DB_PORT=3306 to DB_PORT=8889Cleared cache by running artisan command and run the migrates:

Adjust number of Rows to Form:: Textarea Laravel 5

Jonny C

[Adjust number of Rows to Form:: Textarea Laravel 5](https://stackoverflow.com/questions/30107501/adjust-number-of-rows-to-form-textarea-laravel-5)

How can I control the number of Rows added to a textarea using the Illuminate\Html\FormFacade class?I have added the field into my template.When it gets rendered the textarea has cols="50" and rows="10"I want a way to control these numbers, I have checked the documentation but couldnt spot anything?

2015-05-07 17:03:42Z

How can I control the number of Rows added to a textarea using the Illuminate\Html\FormFacade class?I have added the field into my template.When it gets rendered the textarea has cols="50" and rows="10"I want a way to control these numbers, I have checked the documentation but couldnt spot anything?The options (third parameter) array is actually the attributes array of that element, you so can just pass any 'key' => 'value' and the element will have it as attributes, for example:I have accepted the other answer as it works perfectly.I have also found that the class actually checks for an attribute size Its a minor space saving, Im not sure it makes the code anymore readable, but it is an alternative to cut off a few charactersAlso try this:

Where to put the php artisan migrate command

Tara Prasad Gurung

[Where to put the php artisan migrate command](https://stackoverflow.com/questions/48850813/where-to-put-the-php-artisan-migrate-command)

The services and the task are running welldocker-compose.ymlHere is the dockerfile with which the image is generatedTried adding to the Dockerfile as is commented but didn't solve the problemTried adding on docker-compose as command: php artisan migrate:fresh too Previously was doing this in jenkins to make it work Now dont want it via jenkins

2018-02-18 10:50:10Z

The services and the task are running welldocker-compose.ymlHere is the dockerfile with which the image is generatedTried adding to the Dockerfile as is commented but didn't solve the problemTried adding on docker-compose as command: php artisan migrate:fresh too Previously was doing this in jenkins to make it work Now dont want it via jenkinsThis is how I solved it .Created a bash script called run.sh and added the php artisan migrations commands followed by the php serve command. run.sh Added entrypoint to the Dockerfile removing the CMD  in the end which will run the commands desired.Remove the command from the docker-compose.ymlto run all migrate u need to be inside ur container, for that u need to run ur containers with docker-compose up, here u need to be with terminal in the directory where ur docker-compose.yml file is. after that,and with the same place of docker-compose.yml file, run this commande to be inside ur container : and when u will be inside ur container, go to ur shared app inside the container, i think here is app so cd app.after all of this run :php artisan migrate

How to leverage the glob method of Filesystem class with StorageFacade?

Réjôme

[How to leverage the glob method of Filesystem class with StorageFacade?](https://stackoverflow.com/questions/29729863/how-to-leverage-the-glob-method-of-filesystem-class-with-storagefacade)

This is concerning Laravel 5.I can see in Illuminate\Filesystem\Filesystem a method called glob($pattern, $flags = 0)Unfortunately, this method is not reflected in the default FilesystemAdapter shipped with Laravel 5.This would be great, due to the fact that I would need to do something like Storage::disk('local')->glob([_]*[.blade.php]); (in order to get all stored blade files starting with an underscore.What is the cleanest way to achieve this?

2015-04-19 12:29:23Z

This is concerning Laravel 5.I can see in Illuminate\Filesystem\Filesystem a method called glob($pattern, $flags = 0)Unfortunately, this method is not reflected in the default FilesystemAdapter shipped with Laravel 5.This would be great, due to the fact that I would need to do something like Storage::disk('local')->glob([_]*[.blade.php]); (in order to get all stored blade files starting with an underscore.What is the cleanest way to achieve this?I think you cannot run glob here, but you could get all files and then filter them, for example:Of course you need to decide to use files or allFiles (recursively) depending on your needs. Probably it's not the best solution if you have thousands of files but if you don't it should be enough

How to properly install package in Laravel?

cyber8200

[How to properly install package in Laravel?](https://stackoverflow.com/questions/34726101/how-to-properly-install-package-in-laravel)

Recently, I installed the a package LaravelFacebookSdk.InstallI update my composer.json by adding Then, I run composer update Service ProviderIn my /config/app.php, I add the LaravelFacebookSdkServiceProvider to the providers array.Everything works great. Then, I pushed it to my repository. Here comes the issue !Second developer coming in did a git pull and run composer update He will get an error  is undefine. because, I declared that in my /config/app.php under my providers array.He have to go comment out that line, and run the composer update first. After everything successfully installed, then go back in and uncomment that line back again.Will other developer have to do this each time, we installed a new package ? Am I missing something here ? Please kindly advise if I did anything wrong. 

2016-01-11 16:10:05Z

Recently, I installed the a package LaravelFacebookSdk.InstallI update my composer.json by adding Then, I run composer update Service ProviderIn my /config/app.php, I add the LaravelFacebookSdkServiceProvider to the providers array.Everything works great. Then, I pushed it to my repository. Here comes the issue !Second developer coming in did a git pull and run composer update He will get an error  is undefine. because, I declared that in my /config/app.php under my providers array.He have to go comment out that line, and run the composer update first. After everything successfully installed, then go back in and uncomment that line back again.Will other developer have to do this each time, we installed a new package ? Am I missing something here ? Please kindly advise if I did anything wrong. The problem here is that there is a php artisan clear-compiled command being configured to run before the update process in your composer.json file. And since artisan is an integral part of the Laravel app, it will complain when there's something wrong with the app code. Since you have a reference to a class that is not yet present, it will spit out that RuntimeException. You can fix that by moving that command from the pre-update-cmd list to post-update-cmd list in your composer.json.So change this:To this:Now the clear-compiled command will be run after the update process, when the referenced LaravelFacebookSdkServiceProvider class is present, so no more errors.Instead of running composer update run composer install. There is no need to change the commands in your json file.When you run composer update it will go through all your packages and update to the most recent minor version based on your composer.json then update the composer.lock. This isn't what you want.When you run composer install it will make sure everything in your json file is installed, including packages you just added. This is what your looking for.

Laravel project next to Wordpress project (in public_html folder)

nielsv

[Laravel project next to Wordpress project (in public_html folder)](https://stackoverflow.com/questions/38716585/laravel-project-next-to-wordpress-project-in-public-html-folder)

I have a Laravel project in my public_html folder. The domain is for example domain.com My .htaccess file (in public_html folder) is like this:There are the following routes:So an example of a URL is http://domain.com/appointment.Now I would like to have a wordpress website on domain.com. So when you go to domain.com you see the wordpress website. But I also want to have the urls like /appointment of my laravel project.What's the easiest and cleanest way to do this?

2016-08-02 09:25:47Z

I have a Laravel project in my public_html folder. The domain is for example domain.com My .htaccess file (in public_html folder) is like this:There are the following routes:So an example of a URL is http://domain.com/appointment.Now I would like to have a wordpress website on domain.com. So when you go to domain.com you see the wordpress website. But I also want to have the urls like /appointment of my laravel project.What's the easiest and cleanest way to do this?You can create symlink to Wordpress public directory in Laravel folder. For example, wp:And describe Laravel routes in .htaccess. Example of code of /var/www/laravel/public/.htaccess:Code of /var/www/wordpress/public_html/.htaccess (just copy of your wordpress .htaccess):.htaccess files provide a way to make configuration changes on a per-directory basis. This means that you only need to direct the request to the directory that will have rules for how to best process the request. Thus you will leave the .htaccess files that came with both Laravel and WordPress in their directories. Just create another one for the parent directory that holds them both.The below assumes that the full path of public_html is /var/www/public_html.Both Laravel and WordPress have ways to generate links to their assets (images, CSS, JavaScript).WordPress is built to easily allow for installation to a sub-directory so you only need to change the WordPress Address and Site Address on the General Settings Screen.Laravel assumes that it is installed to the top directory. The asset() helper is used to generate paths to asset files. So you will need to override the default function with one of your own. Here is how:Here is an approach that I took when encountered a similar situation. Install your wordpress in public_html directory and preferably place your laravel application with the WP directory:Best approach is to follow the Laravel Service Provider Architecture. Write a service provider for including the wp-load.php and use the boot function to load assets: And add the service provider to your laravel app config, config/app.php:Now we have access to our WordPress functions within Laravel and can alter laravel views to something like:Your wordpress site should be accessible at www.urdomain.com and laravel app under url  www.urdomain.com/app/appointment or adjust you .htaccess if you wish a different URL pattern.  Hope this help.

Laravel Eloquent $model->save() not saving but no error

Jacob

[Laravel Eloquent $model->save() not saving but no error](https://stackoverflow.com/questions/46919857/laravel-eloquent-model-save-not-saving-but-no-error)

When updating my Post model, I run:This does not update my post. But it should according to the Laravel docs on updating Eloquent models. Why is my model not being updated?Post model:Post controller:Running dd($post->save()) returns true.Runningshows me that $fetchedPost is the same post as before without the updated data.

2017-10-24 20:55:05Z

When updating my Post model, I run:This does not update my post. But it should according to the Laravel docs on updating Eloquent models. Why is my model not being updated?Post model:Post controller:Running dd($post->save()) returns true.Runningshows me that $fetchedPost is the same post as before without the updated data.Check your database table if the 'id' column is in uppercase 'ID'. Changing it to lower case allowed my save() method to work.Since Laravel 5.5 laravel have change some validation mechanism I guess you need to try this way.I had the same and turned out to be because I was filtering the output columns without the primary key.Fixed withMakes perfect sense on review, without the primary key available the update command will be on Null.I had the same problem and changing the way I fetch the model solved it! Was not saving even though everything was supposedly working just as you have mentioned:This is working:Try this In my experience, if you select an Eloquent model from the db and the primary_key column is not part of the fetched columns, your $model->save() will return true but nothing is persisted to the database.So, instead of doing \App\Users::where(...)->first(['email']), rather do \App\Users::where(...)->first(['id','email']), where id is the primary_key defined on the target table.If the (sometimes micro-optimization) achieved by retrieving only a few columns is not really of importance to you, you can just fetch all columns by doing \App\Users::where(...)->first(), in which case you do not need to bother about the name of the primary_key column since all the columns will be fetched.Running dd() inside a DB::transaction will cause a rollback, and the data in database will not change.The reason being, that transaction will only save the changes to the database at the very end. Ergo, the act of running "dump and die" will naturally cause the script to cease and no therefore no database changes.I have been experiencing the same issue and found a workaround. I found that I was unable to save() my model within a function called {{ generateUrl() }} on my home.blade.php template. What worked was moving the save() call to the controller that returns the home.blade.php template. (IE, save()ing before the view is returned, then only performing read operations within {{ generateUrl() }}.)I was (and am) generating a state to put in a URL on page load:Below is what did not work.This was able to find() the User from the database, but it was unable to save() it back. No errors were produced. The function appeared to work properly... until I tried to read the User's state later, and found that it did not match the state in the URL.Here is what did work.Instead of trying to save() my User as the page was being assembled, I generated the state, save()d it, then rendered the page:Landing at the root directory sends you to the index() function of HomeController.php:Then, when generating the URL, I did not have to save() the User, only read from it:This worked! The only difference (as far as I see) is that I'm save()ing the model before page assembly begins, as opposed to during page assembly.

brew link php71: Could not symlink sbin/php-fpm

