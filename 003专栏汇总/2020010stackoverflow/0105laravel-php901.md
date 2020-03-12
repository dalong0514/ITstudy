Zarathuztra

[Laravel 5.1 to 5.2 composer update error](https://stackoverflow.com/questions/34455132/laravel-5-1-to-5-2-composer-update-error)

Whenever I try to run composer update I now receive an error with a root cause of the followingCall to undefined method Illuminate\Bus\Dispatcher::mapUsing()I can confirm Laravel 5.2 is properly installed, as are all other dependencies. This only happens when php artisan clear-compiled is run.I've also updated my base controller based on a suggestion from a few hours ago in the Laracasts forumBut I still receive the errorUPDATE: This happens whenever the application is bootstrapped at all. My app won't even run now.UPDATE 2, full stack trace:

2015-12-24 15:51:50Z

Whenever I try to run composer update I now receive an error with a root cause of the followingCall to undefined method Illuminate\Bus\Dispatcher::mapUsing()I can confirm Laravel 5.2 is properly installed, as are all other dependencies. This only happens when php artisan clear-compiled is run.I've also updated my base controller based on a suggestion from a few hours ago in the Laracasts forumBut I still receive the errorUPDATE: This happens whenever the application is bootstrapped at all. My app won't even run now.UPDATE 2, full stack trace:From the Laravel 5.2 Upgrade GuideThere is no longer support for non self handling commands which is what the mapper would be for; mapping commands to handlers.Check Service ProvidersCheck any service providers you have registered to make sure they aren't calling that method on dispatcher. If still having that issue, you can try checking any package service providers to make sure they aren't calling that method.

Auth::user()->username and similar are very slow

TheNiceGuy

[Auth::user()->username and similar are very slow](https://stackoverflow.com/questions/34773687/authuser-username-and-similar-are-very-slow)

I am having a werid issue. My Laravel 5 application is very slow, it take 1-3 seconds to completely load, that is something that is not tolerable.After hours of debugging, I found out that the issue is Auth::user(), more specifically when you try to access something like Auth::user()->username.What I noticed: Auth::user()->id is blazing fast, while Auth::user()->username takes 1-3 seconds. It does also not to appear to have something todo with the mySQL server, as the exact same queries are being executed, no matter if I use ->id or ->username.It is not only that slow when using ->username but it appears to be that slow for alsmost everything besides ->id, also when accessing roles like Auth::user()->roles.In case it matters, I am using Entrust for the permission/role management. User Model:Even if I remove the Entrust Service Provider and therefore also the EntrustUserTrait, it is still as slow as before.SHOW CREATE TABLE users as requestedAny idea why this is happening? Thanks!

2016-01-13 17:55:15Z

I am having a werid issue. My Laravel 5 application is very slow, it take 1-3 seconds to completely load, that is something that is not tolerable.After hours of debugging, I found out that the issue is Auth::user(), more specifically when you try to access something like Auth::user()->username.What I noticed: Auth::user()->id is blazing fast, while Auth::user()->username takes 1-3 seconds. It does also not to appear to have something todo with the mySQL server, as the exact same queries are being executed, no matter if I use ->id or ->username.It is not only that slow when using ->username but it appears to be that slow for alsmost everything besides ->id, also when accessing roles like Auth::user()->roles.In case it matters, I am using Entrust for the permission/role management. User Model:Even if I remove the Entrust Service Provider and therefore also the EntrustUserTrait, it is still as slow as before.SHOW CREATE TABLE users as requestedAny idea why this is happening? Thanks!Use xdebug to generate a profile of the execution. Then download that file and open it in Wincachegrind or Kcachegrind (depending on what OS you're running on your desktop)In those programs you can drill down and see what's taking the extra time by double-clicking and looking at the columns to see how much time something has taken.The Auth facade returns an object of class Illuminate\Auth\Guard, normally it it caches the entire object you request.   Could it be that somewhere in your application the facade has been overwritten extended to a version that only caches the id instead of all the properties?You might want to make the inital query for the user into User::with('personalData','banned') in your inital load so it will fetch all your relevant data.Basically make sure all your fields get eager loaded on the first query for the user.It's very strange only the user id is loaded, it's as if your user object gets instantiated with the id, but doesn't execute the query till you request it.Use a cache technology if you have big data and performance issue linking this,  like memcache table!Use method instead of Facade.

reCaptcha v3 handle score callback

Victordb

[reCaptcha v3 handle score callback](https://stackoverflow.com/questions/52334269/recaptcha-v3-handle-score-callback)

I followed recaptcha v3 example and managed to make it return a callback with a score for a page, similar with their demo.What I don't understand is how to handle the score that is returned.I understand that the success is based on the treshold. Using the github package the backend verification is returning json (fail or success) back to the frontend.Am I supposed to handle the fail or success in the front end using javascript? What if the browser has the javascript disabled?I was thinking to use the recaptcha v3 on all the pages and block the users considered bots for an amount of time.I am using laravel but I can't figure out how to handle the verification in the middleware, or somewhere else, in order to block the users if they don't have a token (javascript is disabled) or they are considered bots.

2018-09-14 14:42:29Z

I followed recaptcha v3 example and managed to make it return a callback with a score for a page, similar with their demo.What I don't understand is how to handle the score that is returned.I understand that the success is based on the treshold. Using the github package the backend verification is returning json (fail or success) back to the frontend.Am I supposed to handle the fail or success in the front end using javascript? What if the browser has the javascript disabled?I was thinking to use the recaptcha v3 on all the pages and block the users considered bots for an amount of time.I am using laravel but I can't figure out how to handle the verification in the middleware, or somewhere else, in order to block the users if they don't have a token (javascript is disabled) or they are considered bots.reCAPTCHA token should be validated server side. First of all, attach generated token into your form:Then when you capture the input on you controller, you can use a custom form request:g-recaptcha-response field is required so if users disable JS they will get an error when form input is validated.Next for g-recaptcha-response we apply a custom validation rule: RecaptchaV3.Here's my implementation:Next, in your controller use the above form request:Hope this helps.Unfortunately, recaptcha v3 does not have challenge methods, which means we need to handle the score threshold in our own server side. The best solution would be that apply both v2 and v3 together, e.g. if v3 fails threshold, then it pops up v2 challenge. The official site suggests to use 2-way authentication e.g. SMS. However, I don't think 70% of people would do it.I have created a composer package for Laravel framework which supports score settings. You can check the source code in github recaptcha:You can do score comparison for your own score handler.The basic usage would be like:If JavaScript is disabled, reCAPTCHA doesn't work anyway and most form submissions will/should fail if bot protection is critical to you.As for the score that V3 returns, it is entirely up to you how you handle it.Generally this is handled on form validations. The with V3 you could require the g-response value to be greater than 0.8 or something to your liking. Exact implementation varies greatly by how your app is structured.From the docs:

reCAPTCHA v3 returns a score (1.0 is very likely a good interaction, 0.0 is very likely a bot). Based on the score, you can take variable action in the context of your site.

How to use token authentication in laravel web page

Rishi Raut

[How to use token authentication in laravel web page](https://stackoverflow.com/questions/45386587/how-to-use-token-authentication-in-laravel-web-page)

I am trying to use JWT for laravel web page instead of session. so I made some changes.Now I am getting error How to fix this and start token authentication for laravel web page(blades not API).

2017-07-29 07:23:19Z

I am trying to use JWT for laravel web page instead of session. so I made some changes.Now I am getting error How to fix this and start token authentication for laravel web page(blades not API).I'm also using jwt protecting our api. You should change your config like below:Make sure the jwt library installed correctly: I found the solution here : https://github.com/tymondesigns/jwt-auth/issues/860In /routes/api.php - added a few basic authentication routesIn /app/http/Controller/auth/LoginController.phpand then override methods in login contollerAdding middleware AddTokenRegister middleware in Kernel.phpI think you can try this :EDITYou can find some help from the step by step example. In this example you need to focus on how to configure and use that token base authentication. Hope this help you well. Please refer this link. If you are using api as default then laravel authentication will throw an error. Laravel uses default Session based authentication out of the box with the default scaffolding users-view-controller that you already have. You have additional means of adding your own custom guard in the doc, so you can make use of the guard as needed.Therefore as @KevinPatel suggested, revert back to the default configuration, then in your route: group the route you want to be under JWT authentication, add the JWTMiddleware, in this case you have to update the controller responsible for your authentication to use the JWTAuth instead of the default auth. You should check this answer if you need to understand it better check this answer on LaracastsOne recommended way to incorporate the JWTAuth is to go for Dingo API (of course you are not building api, but) because Dingo already added some flesh to the authentication and other routes management - so things are pretty easy to use and configure

Calling .jar files from PHP - Stanford NLP - Could not find or load main java class

Diego Vidal

[Calling .jar files from PHP - Stanford NLP - Could not find or load main java class](https://stackoverflow.com/questions/39306031/calling-jar-files-from-php-stanford-nlp-could-not-find-or-load-main-java-cl)

I've got a project that is using this package agentile/PHP-Stanford-NLP (PHP interface to Stanford NLP Tools (POS Tagger, NER, Parser) which calls a few .jar files. Everything is working ok on localhost (MAMP) but when I deployed it to laravel forge it is not working anymore. I installed JRE/JDK, Oracle JDK, Oracle JDK 8 in my server.This is the piece of code I use to call the java files:This is the piece of code where the error comes from:https://github.com/agentile/PHP-Stanford-NLP/blob/51f99f1aaa1c3d5822fe634346b2b4b33a7a6223/src/StanfordNLP/Parser.php#L90This is the error:EDITED:This is the $cmd output from localhost:This is the $cmd output from production:

2016-09-03 10:45:08Z

I've got a project that is using this package agentile/PHP-Stanford-NLP (PHP interface to Stanford NLP Tools (POS Tagger, NER, Parser) which calls a few .jar files. Everything is working ok on localhost (MAMP) but when I deployed it to laravel forge it is not working anymore. I installed JRE/JDK, Oracle JDK, Oracle JDK 8 in my server.This is the piece of code I use to call the java files:This is the piece of code where the error comes from:https://github.com/agentile/PHP-Stanford-NLP/blob/51f99f1aaa1c3d5822fe634346b2b4b33a7a6223/src/StanfordNLP/Parser.php#L90This is the error:EDITED:This is the $cmd output from localhost:This is the $cmd output from production:The error message you posted:indicates that your class could be found by the java command. Which means your class is not in the classpath.The class edu.stanford.nlp.parser.lexparser.LexicalizedParser should be inside stanford-parser.jar which you are manually including in the classpath.In this scenario (since you said in the comments that the file actually exists) there are two main reasons that could cause the problem:The first cause is unlikely if you uploaded the files with the same user with which you are running the process, in any case it is easy to check and fix.The second cause can be solved by downloading a clean version and replacing the current one. You can download the new version from Maven Central and replace the one in your server using the following command:There can be two issues1) Please check if the paths /home/forge/mydomainname.com/public/lib /home/forge/mydomainname.com/public/ and corresponding jar files are present.

2) Check the access for all these files (is the access on these files same as your MAMP?)?

Laravel Auth::attempt() returns false

Programming_Duders

[Laravel Auth::attempt() returns false](https://stackoverflow.com/questions/41342907/laravel-authattempt-returns-false)

I am a home hobbyist and am studying Laravel, currently in version 5.3. I am using a Mac, neither homestead nor vagrant.  I'm currently working on a website that uses a login and a register system to create users.I've used php artisan migrate to manipulate my database locally.

As listed below, it has three fields, namely:I have a User model (users.php):And also, a UserController class (UserController.php):  As you can see, I am using bcrypt() as my hashing method.However, this problem is, it will always result to a failure.

I have checked the following links:P.S. These links seem very hard to follow as I do not utilize the Input class.

2016-12-27 09:56:51Z

I am a home hobbyist and am studying Laravel, currently in version 5.3. I am using a Mac, neither homestead nor vagrant.  I'm currently working on a website that uses a login and a register system to create users.I've used php artisan migrate to manipulate my database locally.

As listed below, it has three fields, namely:I have a User model (users.php):And also, a UserController class (UserController.php):  As you can see, I am using bcrypt() as my hashing method.However, this problem is, it will always result to a failure.

I have checked the following links:P.S. These links seem very hard to follow as I do not utilize the Input class.The problem is with the way you're redirecting the user to login route after the registration. You're falsely assuming that the $request data will be accompanied with the redirect.  Let's assume this scenario: A request gets dispatched to the postRegister method with name, email and password fields. The controller creates the user and saves it into the database. Then it redirects the user, who is not yet authenticated, to the login route. The postLogin method gets triggered, but this time with no request data. As a result, Auth::attempt($credentials) fails and you get that nasty Failure on screen.  If you add a dd($credentials) right after you create the array, you'll see that it has no values:  It will return something like this:  You cannot redirect with custom request data (unless with querystring which is part of the URL), not matter what. It's not how HTTP works. Request data aside, you can't even redirect with custom headers.  Now that you know what's the root of your problem, let's see what are the options to fix it.  In case you want to preserve this structure, you need to flash the request data of postRegister() into the session (which is persistent between requests) and then retrieve it in the postLogin() method using Session facade, session() helper or the actual Illuminate\Session\SessionManager class.  Here's what I mean:

(I slightly modified your code; dropped extra variables, made it a lil bit cleaner, etc.)I strongly recommend you against using this approach. This way the implementation of postLogin() method which is supposed to be responsible to login users gets coupled with session data which is not good. This way, you're not able to use postLogin independently from the postRegister.This is a slightly better solution; If you decided that you need to log in the user right after the registration, why not just doing that?  Note that Laravel's own authentication controller does it automatically.  By the way, here's what I mean:

(Ideally this should be broken down into multiple methods, just like Laravel's own authentication controller. But it's just an example to get you started.)But still, it's far from perfect! There are many other ways to tackle this. One could be using events, throwing exceptions on failure and redirecting using custom exceptions. But I'm not gonna explore them as there's already a solution perfectly designed for this.  If you want to write your own authentication controller, that's fine. You'll learn a lot along the way. But I strongly suggest reading Laravel's own authentication code, especially RegistersUsers and AuthenticatesUsers traits in order to learn from it. And one more note; you don't need that Illuminate\Auth\Authenticatable trait in your User model as it's already extending Authenticatable which use that trait.You should hash your password everytime you insert a row bcrypt(pass). Auth::attempt assumes that the password being retrieved from the database is hashedAuth::attempt uses \Hash::make($someString) to generate the hash. You should use this as well in order to generate same hashes from same strings (I assume the seed is different than with bcrypt() function).So change this line:To:

Mouse Hover in VueJS component implementation in Laravel

Albert Ruelan

[Mouse Hover in VueJS component implementation in Laravel](https://stackoverflow.com/questions/58025504/mouse-hover-in-vuejs-component-implementation-in-laravel)

My Mouse hover is not working when I am using it on Laravel.My Vue file is stored in resources/js/Dashboard.vueWhat I tried so far is to change v-on:mouseover with @mouseover but it still not working.The Result is that when I hover the button it doesn't change texts.What am I doing wrong and how can I fix it?Below, the content of my Dashboard.vue file;Here, the content of my Blade.php file;To take a close look and reproduce locally, below is the package.json file;Edit added my app.js

2019-09-20 09:23:03Z

My Mouse hover is not working when I am using it on Laravel.My Vue file is stored in resources/js/Dashboard.vueWhat I tried so far is to change v-on:mouseover with @mouseover but it still not working.The Result is that when I hover the button it doesn't change texts.What am I doing wrong and how can I fix it?Below, the content of my Dashboard.vue file;Here, the content of my Blade.php file;To take a close look and reproduce locally, below is the package.json file;Edit added my app.jsTry adding these to prevent default event and propagationThe code works, When i run on my system it works.I tried it on JSFiddle.Neat. Looks like as the button changes size during the animation, the mouse goes in and out of hover state because the edge is moving.I added a div around each button, and attached the hover triggers to the divs instead of the buttons

https://jsfiddle.net/jmbldwn/kbswLpto/5/In your Dashboard.vue file, try to change below:Into:(maybe an object works better for you)The answer is that i should put in resources/views/layouts/app.blade.php instead of putting it in my other view file such as those i manually created. For those wondering where in app.blade.php should i put the code above.Put it at the end of the body tagFor example in app.blade.php

How to make MySQL driver for HHVM return IDs as integers?

mauvm

[How to make MySQL driver for HHVM return IDs as integers?](https://stackoverflow.com/questions/26801856/how-to-make-mysql-driver-for-hhvm-return-ids-as-integers)

I noticed that my Laravel API does not return entity identifiers (the primary keys) as integers.In Api\PostController.php::show():Which returns something like:This messes up my table sorting (because IDs will be sorted as string: 1, 10, 11, 2 etc.).Dumping the entity itselfs also shows that the id attribute is a string.As mentioned here the probable cause is that the MySQL driver does not return values in the appropriate type.I'm using HHVM 3.3.1 on a Ubuntu 14.04 server. Is there any way I can use a native MySQL library (like php5-mysqlnd) for HHVM?I could use Laravel model accessors to solve the problem. But that is more of a hack IMO.Please help!References:EDIT: I have verified that it's not the ORM layer of Laravel. The PDO instance already returns IDs as strings.

2014-11-07 13:02:57Z

I noticed that my Laravel API does not return entity identifiers (the primary keys) as integers.In Api\PostController.php::show():Which returns something like:This messes up my table sorting (because IDs will be sorted as string: 1, 10, 11, 2 etc.).Dumping the entity itselfs also shows that the id attribute is a string.As mentioned here the probable cause is that the MySQL driver does not return values in the appropriate type.I'm using HHVM 3.3.1 on a Ubuntu 14.04 server. Is there any way I can use a native MySQL library (like php5-mysqlnd) for HHVM?I could use Laravel model accessors to solve the problem. But that is more of a hack IMO.Please help!References:EDIT: I have verified that it's not the ORM layer of Laravel. The PDO instance already returns IDs as strings.Create an accessor for the id in your Post class.You need to set typed_results in your /etc/hhvm/php.ini file.hhvm.mysql.typed_results = trueI don't have HHVM set up to test, but the fix in PHP would be to disable PDO::ATTR_EMULATE_PREPARES. For example, in your database config file, add:

Laravel Socialite + Making API calls after login

joepferguson

[Laravel Socialite + Making API calls after login](https://stackoverflow.com/questions/30586966/laravel-socialite-making-api-calls-after-login)

Laravel 5, Socialite, and google/apiclient packages.Source code: https://github.com/svpernova09/meatingsI have socialite working fine with Google for logging users in.I'm trying to make an API call in a different method to fetch Calendar events as the logged in user. I'm getting stuck with what tokens to use where.The error I'm getting is:My method:The Laravel output is:$user-code looks like: 4/hfPzDrOHyaEv3asdfadsfasdfDw72nXIl0rt2boUpGj7hM.Um5wPgCeasdfasdfafd1t6qxkmwIAny guidance would be great. I'm not getting anywhere with the google guides.

2015-06-02 03:47:07Z

Laravel 5, Socialite, and google/apiclient packages.Source code: https://github.com/svpernova09/meatingsI have socialite working fine with Google for logging users in.I'm trying to make an API call in a different method to fetch Calendar events as the logged in user. I'm getting stuck with what tokens to use where.The error I'm getting is:My method:The Laravel output is:$user-code looks like: 4/hfPzDrOHyaEv3asdfadsfasdfDw72nXIl0rt2boUpGj7hM.Um5wPgCeasdfasdfafd1t6qxkmwIAny guidance would be great. I'm not getting anywhere with the google guides.Calendar uses a different scope than social login. You have to ask for permission again. You can check the documentation of the Calendar API and try it out on Google Playground.Also Google returns "Code was already redeemed." because you already have an access token for the public information of the user with your code.

Wordpress Subscriptions in laravel (corcel)

Ivan Bravo Carlos

[Wordpress Subscriptions in laravel (corcel)](https://stackoverflow.com/questions/31485273/wordpress-subscriptions-in-laravel-corcel)

I have 2 projects, one in Wordpress, and the other one in Laravel 4.2.Recently i had to merge both projects into one Laravel 4.2 App using jgrossi/corcel. This was my only option.Everything works fantastic! I can even post directly into Wordpress without logging into Wordpress to get posts, comments, etc.But there is something I can't figure out. Wordpress is using Jetpack for subscribers. The laravel app needs a field to add more subscribers. I have very little experience in Wordpress.Is it possible to add subscribers from outside Wordpress directly into the database? If not, is there a way to use a Jetpack plugin outside of Wordpress?

2015-07-17 21:52:09Z

I have 2 projects, one in Wordpress, and the other one in Laravel 4.2.Recently i had to merge both projects into one Laravel 4.2 App using jgrossi/corcel. This was my only option.Everything works fantastic! I can even post directly into Wordpress without logging into Wordpress to get posts, comments, etc.But there is something I can't figure out. Wordpress is using Jetpack for subscribers. The laravel app needs a field to add more subscribers. I have very little experience in Wordpress.Is it possible to add subscribers from outside Wordpress directly into the database? If not, is there a way to use a Jetpack plugin outside of Wordpress?Yes you can add new users in database with subscribers role.Wordpress stores the users data in wp_users table and its meta info in wp_usermeta. So follow the following stepsSo you added a new user with subscriber role.

How to select all column name from a table in laravel?

Heng Sopheak

[How to select all column name from a table in laravel?](https://stackoverflow.com/questions/37157270/how-to-select-all-column-name-from-a-table-in-laravel)

I have tried to get all column names from a table TellerFunction:

2016-05-11 08:40:20Z

I have tried to get all column names from a table TellerFunction:You can get all columns name by simply doing that...Get Table Name From ModelGet Table Column Name From ModelNow you will get all columns of "products" table and if you need it in controller then you can get it by following way :Just in-case if you have multiple databases connections, try following:Add in the top of your php scriptRetrieve anywhere in your codeWith Database Connection    Without Database Connection    As of Laravel 6.x this works: The hint here is just to go around eloquent (which should just provide a simple way to do this, but clearly does not) and grab the PDO object and then use the answer from the same question for straight PDO accessThis will also work when there is no database selected by replacing 'Teller' with databasename.TellerHTH,-ftYou only need extract the keys from the query responseTo get all raws from table:This method will return the value of the column directly:Refer:You could simply write:If you have a Teller model you can also use Teller::all();UpdateTo get all column name you can run SHOW FIELDS TellerYou can use this

Laravel 5 syntax error, unexpected 'extends' (T_EXTENDS)

Santosh Achari

[Laravel 5 syntax error, unexpected 'extends' (T_EXTENDS)](https://stackoverflow.com/questions/30631635/laravel-5-syntax-error-unexpected-extends-t-extends)

This is the code in my controller: My App.blade.phpAnd index.blade.phpThis is the error that I get: Please help.Solution listed below. While the issue is silly, and easy to fix - it's hard to find a straight answer via Google Search. Hence keeping this question. 

2015-06-03 22:07:16Z

This is the code in my controller: My App.blade.phpAnd index.blade.phpThis is the error that I get: Please help.Solution listed below. While the issue is silly, and easy to fix - it's hard to find a straight answer via Google Search. Hence keeping this question. The <?php ?> Tags are not required in .blade.php files. Remove them and it works. (The blade syntax need not be in php tags. You can however, include PHP code in  tags.)The <?php ?> tags are not required in your laravel blade file saved with extension .blade.php laravel templating engine automatically parse blade commands from these files.But if you want to include php code in your blade file which is not part of blade engine commands then you will have to use <?php ?> tags.I know this is a bit old but the issue was clearly missed.In your index.blade.php file your missing the closing php tag "?>".The blade sytanx @extends, @section etc... should be in your html on the outside of any php code block.When you use @extends, it must be the first piece of code in your blade file.A blank space or an empty new line before @extends will also throw an error.

Laravel - where less/greater than date syntax

Selim

[Laravel - where less/greater than date syntax](https://stackoverflow.com/questions/41180569/laravel-where-less-greater-than-date-syntax)

This is not showing the correct count. What is the correct syntax ?

2016-12-16 08:59:18Z

This is not showing the correct count. What is the correct syntax ?Use a Carbon instance:Use DB::raw:We can also try this one. It works for me.

save image in public folder instead storage laravel 5

siros

[save image in public folder instead storage laravel 5](https://stackoverflow.com/questions/42562203/save-image-in-public-folder-instead-storage-laravel-5)

i wanna save my avatar at "Public" folder and ther retrieve.ok. i can save it but in "storage/app" folder instead "public"my friend told me go to "config/filesystem.php" and edit it ,so i did it like thisstill no change.here my simple codesRoute :ControllerView:How Can save my image (and file in future) at public folder instead storage?

2017-03-02 17:37:39Z

i wanna save my avatar at "Public" folder and ther retrieve.ok. i can save it but in "storage/app" folder instead "public"my friend told me go to "config/filesystem.php" and edit it ,so i did it like thisstill no change.here my simple codesRoute :ControllerView:How Can save my image (and file in future) at public folder instead storage?In config/filesystems.php, you could do this...

change the root element in public and you can access it by You can pass disk option to method of \Illuminate\Http\UploadedFile class:or you can create new Filesystem disk and you can save it to that disk.You can create a new storage disc in config/filesystems.php:in controller:You'll need to link your storage directory to your public folder with:Once you've done that, to display it in the view you can do:Or in your case:

How to get the day after tomorrow in PHP using DateTime?

Pat841

[How to get the day after tomorrow in PHP using DateTime?](https://stackoverflow.com/questions/18238394/how-to-get-the-day-after-tomorrow-in-php-using-datetime)

I have an Eloquent query that  currently looks like this:Which works fine, my question is, how do I go about formatting it like so:Meaning I am trying to find the results whose dates are between tomorrow and the day after tomorrow. Any help would be greatly appreciated.

2013-08-14 17:29:27Z

I have an Eloquent query that  currently looks like this:Which works fine, my question is, how do I go about formatting it like so:Meaning I am trying to find the results whose dates are between tomorrow and the day after tomorrow. Any help would be greatly appreciated.If you want to get the day after tomorrow you can use:You can find more information in the manual page 'Relative time formats'new \DateTime('tomorrow + 1day') It's OK if you are not interested in hours and minutes.. It's gives you always midnigth but $dayAfterTomorrow = (new \DateTime())->add(new \DateInterval('P2D'));gives you exactly 2 days from now and hours and minutes are keptThe day after tomorrow is two days from now, so this will work:-See it working

Laravel: Generate random unique token

user5486944

[Laravel: Generate random unique token](https://stackoverflow.com/questions/33334927/laravel-generate-random-unique-token)

I have a table in my database called keys that has this structure:Every time a user logs into my site, I need to generate a new token_id and token_key set for that user. How can I generate a random token for both the token_id and the token_key while keeping the two values unique?For example, if:Meaning:There can be no other row in the table with that combination of tokens. How can I do this?

2015-10-25 20:48:29Z

I have a table in my database called keys that has this structure:Every time a user logs into my site, I need to generate a new token_id and token_key set for that user. How can I generate a random token for both the token_id and the token_key while keeping the two values unique?For example, if:Meaning:There can be no other row in the table with that combination of tokens. How can I do this?I'd avoid including an extra package for a case like this one. Something like:...should do. Replace model name with yours, if different from 'User', and use your or suggested functions for creating random strings.In terms of generating the tokens, you could use one of Laravel's Helper Functions; str_random().This will generate a random string of a specified length, e.g str_random(16) will generate a random string of 16 characters (upper case, lower case, and numbers).Depending on how you are using the tokens, do they really need to be completely unique? Given that they will match to a user, or I assume you may be using the token_id and then verifying this against the token_key does it really matter if there is a double up of one of them? - although the chances of this are extremely small!However, if you do need them to be truly unique you can always use a validator with the unique constraint. Using this package you could also test that the two of them are unique too with unique_with. And then if the validator fails then it generates a new token as needed.Based off your examples, you would be using str_random(16) for token_id and str_random(30) for the token_key.You can use a dependency to do this. Dirape laravel-tokenRun the commandIn your controller useYou can use it like this:Following @ivanhoe suggestion... this is what I came up with:-

Laravel - DecryptException: 'The MAC is invalid'

user7346035

[Laravel - DecryptException: 'The MAC is invalid'](https://stackoverflow.com/questions/46070732/laravel-decryptexception-the-mac-is-invalid)

In laravel for registration I'm using encrypt algorithm for password instead of inbuilt bcrypt function in Laravel because to get password and send it to mail when password is forgot.But decrypt it is showing a error like This , when I run this code it is working on local but server itself it is not working below i have mentioned the code , can anyone please help

2017-09-06 08:51:41Z

In laravel for registration I'm using encrypt algorithm for password instead of inbuilt bcrypt function in Laravel because to get password and send it to mail when password is forgot.But decrypt it is showing a error like This , when I run this code it is working on local but server itself it is not working below i have mentioned the code , can anyone please helpThe problem is you generated a new APP_KEY, then if you try to decrypt the old encrypted data it will show the DecryptException: The MAC is invalid.If you want to decrypt the old data you need to restore your old APP_KEY.After realizing that, now, adding a new problem there, if you stored new data with another APP_KEY or another encryption method you have a problem on the data because they are mixed on the table.In case you don't know when do you started with the new encrypt method or differentiate the new encrypted entries, the fastest solution would be reset all the passwords with the new encrypt method.You can learn more about how Laravel encryption works on the official Laravel docs.To avoid this, use a custom key instead. The default key is APP_KEY, but you can provide one so your decrypt is not linked with new or old APP_KEY.

I use the following code to resolve it, and it worked in different APP_KEYs.Important for key length : if $cipher == 'AES-128-CBC' use $length === 16, if $cipher == 'AES-256-CBC' use $length === 32). Check in config/app.cipher which cipher your app uses.I copied the APP_KEY from the environment it was working dev to the production and the issue was solved. you may want to try it.If you have imported DB form one environment to another, most likely you will face this error. Its recommended to have same APP_KEY as data source application in order to fix bug.

Laravel4 duplicate / copy table row

kilrizzy

[Laravel4 duplicate / copy table row](https://stackoverflow.com/questions/18322214/laravel4-duplicate-copy-table-row)

I'm sure there has to be a quicker way to do the following. I wasn't able to find anything about how to save a laravel modal object as a new row without overwriting the existing item. Essentially, a simpler of my existing code:Instead, copying everything but the id of the row:

2013-08-19 20:08:16Z

I'm sure there has to be a quicker way to do the following. I wasn't able to find anything about how to save a laravel modal object as a new row without overwriting the existing item. Essentially, a simpler of my existing code:Instead, copying everything but the id of the row:You can try

Replacement for File::mime() in Laravel 4 (to get mime type from file extension)

mtmacdonald

[Replacement for File::mime() in Laravel 4 (to get mime type from file extension)](https://stackoverflow.com/questions/19681854/replacement-for-filemime-in-laravel-4-to-get-mime-type-from-file-extension)

Laravel 3 had a File::mime() method which made it easy to get a file's mime type from its extension:On upgrading to Laravel 4 I get an error:Call to undefined method Illuminate\Filesystem\Filesystem::mime()I also can't see any mention of mime types in the Filesystem API docs.What's the recommended way to get a file's mime type in Laravel 4 (please note this is not a user-uploaded file)?

2013-10-30 12:09:25Z

Laravel 3 had a File::mime() method which made it easy to get a file's mime type from its extension:On upgrading to Laravel 4 I get an error:Call to undefined method Illuminate\Filesystem\Filesystem::mime()I also can't see any mention of mime types in the Filesystem API docs.What's the recommended way to get a file's mime type in Laravel 4 (please note this is not a user-uploaded file)?One solution I've found is to use the Symfony HttpFoundation File class (which is already included as a dependency in Laravel 4):And in fact the File class uses the Symfony MimeTypeGuesser class so this also works:But unfortunately I'm getting unexpected results: I'm getting text/plain instead of text/css when passing a path to a css file.IF you had just uploaded the file you can use:  You can see more here! I hope it be for some help! :DEDIT:

Input::file is some kind of extention from File, so you may use File::get('file')->getMimeType(); also. Didn't test, but MUST work.After reading that:I decided instead to port Laravel 3's implementation of File::mime() into a helper library within my Laravel 4 application. The Laravel 3 implementation just reads the MIME types from a config lookup array, based on file extension.Solution:It turned out that Symfony ExtensionGuesser and MimeTypeGuesser use unreliable FileInfo class. For that reason validation of mimes return unpredictable results and can not be used with files uploads in a proper way (it returns text/plain mime for js, xls, po etc.).I've found very simple solution for this problem.Instead of I split that into two different parts and now my validation looks like this:I simply try to verify that extension of the file is present and that it is listed in my in rule. That works, however, solution is not perfect.Ref: https://github.com/illuminate/filesystem/blob/master/Filesystem.php#L194

Clear Laravel's orderBy

Rafael Sierra

[Clear Laravel's orderBy](https://stackoverflow.com/questions/26869897/clear-laravels-orderby)

I have a generic function which gives me generic querysets, something like:This function is used everywhere my project, but in a specific point I need to use this queryset but changing the ORDER BY, much like this:If I run this code, the ORDER BY will just append onto the previous and generate an invalid query, since the "somefield" is not on the SELECTed fields. i.e.: How do I clear the orderBy so I can just reuse querysets?

2014-11-11 16:40:35Z

I have a generic function which gives me generic querysets, something like:This function is used everywhere my project, but in a specific point I need to use this queryset but changing the ORDER BY, much like this:If I run this code, the ORDER BY will just append onto the previous and generate an invalid query, since the "somefield" is not on the SELECTed fields. i.e.: How do I clear the orderBy so I can just reuse querysets?I agree there should be a clearOrderBy() method added to the query builder. However because the registry of orderbys is a public property on Illuminate\Database\Query\Builder you actually can clear it yourself today. The trick is getting access to the base query object:At other times, for example when manipulating a relation query, you need to get to access the base query (Illuminate\Database\Query\Query). So for example:Thats it. I plan to submit a PR for a clearOrderBy() as well.Why not "genericise" your queryset?Then you can useHere is a simple solution , tiny package you can use it by simply calling ->clearOrdersBy()

https://github.com/phpfalcon/laravel-clear-orders-by

No table name set on execute migration in Lumen

henriale

[No table name set on execute migration in Lumen](https://stackoverflow.com/questions/32879392/no-table-name-set-on-execute-migration-in-lumen)

I'm facing this error when attempting to run the migration in Lumen Framework:$ php artisan migrate:installAnd now I have no idea what's going on.Note that the table that is not being created is the one which controls the migrations at all.

2015-10-01 04:19:56Z

I'm facing this error when attempting to run the migration in Lumen Framework:$ php artisan migrate:installAnd now I have no idea what's going on.Note that the table that is not being created is the one which controls the migrations at all.I found the solution myself!Just add the name of the table on database config array and it's done!'migrations' => 'migrations',

Laravel get intended url

Adams.H

[Laravel get intended url](https://stackoverflow.com/questions/21499444/laravel-get-intended-url)

I use a common httpRequest to login, so I could use Redirect::intended(); to lead the user to a url before them being lead to the login page.  That all works well.Now I've changed login to ajax request I can only redirect the url in javascript now. So I've to pass the intended url to front end then do the window.location=urlThe problem is I can't get the intended/original url. Can any kind laravel expert help me out ?

2014-02-01 14:45:26Z

I use a common httpRequest to login, so I could use Redirect::intended(); to lead the user to a url before them being lead to the login page.  That all works well.Now I've changed login to ajax request I can only redirect the url in javascript now. So I've to pass the intended url to front end then do the window.location=urlThe problem is I can't get the intended/original url. Can any kind laravel expert help me out ?In your controller action use:$url = Redirect::intended( ... )->getTargetUrl();(Where ... is the fallback url)Then return it in the JSON response, and use window.location or other to do the redirect.When you are showing the form foe log in, you can grab the intended url from session if available and pass it to the view then redirect using window.location.So. how to grab the intended url ?Here, first argument is intended url if available in the session and default is set to home page using url('/') helper method, so the $intended_url will always contain a url, intended or defaulr. Then when you are loading the view, pass the $intended_url using this:Then use it from the view like:Alternatively, you may setup a View Composer so whenever the login view/form is displayed the intended url will be available in that view and you can do it using this:Here, login is the view name for login page, if this is something else in your case then change it to the appropriate name of your login view. You can keep this code in your app/start folder inside the 'global.php' file or keep it in a separate file and include this fie inside global.php file using this (at the end):Assumed that, file name would be view_composer.php, present in the app/start folder.In Laravel 5.7: I am using the following approach with a custom login controller and middleware for Laravel 5.7, but I hope that works in any of laravel 5 versions

Trying to understand why Laravel's many static methods is not considered bad practice [closed]

Lisa Miskovsky

[Trying to understand why Laravel's many static methods is not considered bad practice [closed]](https://stackoverflow.com/questions/15080612/trying-to-understand-why-laravels-many-static-methods-is-not-considered-bad-pra)

I'm pretty confused.I've asked a few developers on Reddit to review my codes. It looks like this.So it loads register.php, replaces {error_message} with translation. (Sorry, this username is in use. Please pick another.)They said using too many static calls is a bad practise. Yet they suggest Laravel framework, which completely gets rid of $this and uses static calls.Can someone explain me how come if this is bad practise, Laravel being a classy framework?

2013-02-26 03:02:06Z

I'm pretty confused.I've asked a few developers on Reddit to review my codes. It looks like this.So it loads register.php, replaces {error_message} with translation. (Sorry, this username is in use. Please pick another.)They said using too many static calls is a bad practise. Yet they suggest Laravel framework, which completely gets rid of $this and uses static calls.Can someone explain me how come if this is bad practise, Laravel being a classy framework?Static state is omnipresent and entirely destroys testability since you can't just reset the state. Additionally, anything could affect the state in ways that other aspects of the code can't predict, resulting in the potential for wildly unpredictable behavior.Laravel 4 prevents this by using static 'facades'. These facades are "syntactic short-hand for IoC resolution". They provide both syntactic sugar and prevent tightly coupled code.The classes that are resolved by the facades can be changed and allow you to inject mock systems or whatever you wish. Of course, this doesn't really solve the other aspect of static access.. Which is that you can't just inject different functionality. But, with Laravel applications you generally don't have facade use within your domain. It's more for the web transport layer, where it's very helpful since the web transport layer is already tightly coupled with your framework, this just makes good use of that fact by creating something sort of akin to a DSL for that layer of your application.I repeat, please consider not using facades deep in your domain layer.

Problems installing laravel with composer [duplicate]

matt

[Problems installing laravel with composer [duplicate]](https://stackoverflow.com/questions/28332103/problems-installing-laravel-with-composer)

Problem: I'm wanting to explore laravel 5, and failing miserably at installing it. I'm using this guide: http://laravel.com/docs/5.0 and need someone to help me understand the instructions.Background and What I've TriedI'm running Mac OSX 10.10.2 (Yosemite) and MAMP. So far, I've downloaded Composer to my home folder using terminal. There is just a composer.phar file sitting there.When I run:I get the message:I assume that is ok because when I run the following in terminal, I get the composer logo and a list of optionsI'm not 100% sure what the following means, from the Laravel Docs:Because I can't figure it out, the following steps throw errors, such as: I've been going through a few forums, and it's suggested that I need to update my PHP.ini file - this seems more related to Composer install, and not specifically Laravel. Because composer is working, this seems to be a dead end.Ideally, I want to install Laravel 5 to the directory because Composer.phar is in my home folder, I think the command should be:or just As mentioned, it just (correctly) throws errors. Question:

If anyone can help solve my total user error, by explaining what "Make sure to place the ~/.composer/vendor/bin directory in your PATH so the laravel executable can be located by your system." means to a n00b, that'd be really appreciated.Many thanks!

2015-02-04 21:47:20Z

Problem: I'm wanting to explore laravel 5, and failing miserably at installing it. I'm using this guide: http://laravel.com/docs/5.0 and need someone to help me understand the instructions.Background and What I've TriedI'm running Mac OSX 10.10.2 (Yosemite) and MAMP. So far, I've downloaded Composer to my home folder using terminal. There is just a composer.phar file sitting there.When I run:I get the message:I assume that is ok because when I run the following in terminal, I get the composer logo and a list of optionsI'm not 100% sure what the following means, from the Laravel Docs:Because I can't figure it out, the following steps throw errors, such as: I've been going through a few forums, and it's suggested that I need to update my PHP.ini file - this seems more related to Composer install, and not specifically Laravel. Because composer is working, this seems to be a dead end.Ideally, I want to install Laravel 5 to the directory because Composer.phar is in my home folder, I think the command should be:or just As mentioned, it just (correctly) throws errors. Question:

If anyone can help solve my total user error, by explaining what "Make sure to place the ~/.composer/vendor/bin directory in your PATH so the laravel executable can be located by your system." means to a n00b, that'd be really appreciated.Many thanks!Laravel is a PHP framework (makes writing PHP applications easy)Composer is a PHP package and dependency manager. (makes installing and updating third party code libraries easy)When you runYou're using composer to install the laravel/installer=~1.1 package into composer's "global" project folder (usually ~/.composer).  This is what installed the command line program named laravel.The command line program named laravel is a shell script for installing the PHP framework (Also named Laravel).Your "Unix Path" is a list of folders where a command line script will search for an executable.  Usually is has folders like /usr/bin, /usr/local/bin, etc.  This is why when you run ls, you're actually running /usr/bin/ls -- the shell knows to check each folder in the path for a location.  You can view your current path by typingSo, the problem is composer installed the laravel command line program to a folder that's not in your unix path.  You need to add this folder to your unix path.  You can do this by running the following (assuming you're using bash, which is OS X's default shell)If you run that, you should be able to run the laravel command line program and continue your installation. Most people add this to their .bash_profile or .bashrc files.  The Unix Stack Exchange has a lot of good information if you're interested in learning how to do this. You can add the directory to the PATH variable by editing /etc/paths.

Here's a tutorial on how to do that.Just add a line with:Then the laravel new command should work fineIf everything fails you can still use the composer create-project command to make a new laravel instance:I added C:\Users\Leon\AppData\Roaming\Composer\vendor\bin instead of ~/.composer/vendor/bin to the Path variable.  Here is instructions on changing the path variable on Windows 10:

http://windowsitpro.com/systems-management/how-can-i-add-new-folder-my-system-path

Apply Middleware to all routes except `setup/*` in Laravel 5.4

Andy Holmes

[Apply Middleware to all routes except `setup/*` in Laravel 5.4](https://stackoverflow.com/questions/43135138/apply-middleware-to-all-routes-except-setup-in-laravel-5-4)

I'm experimenting with Middleware in my Laravel application. I currently have it set up to run on every route for an authenticated user, however, I want it to ignore any requests that begin with the setup URI.Here is what my CheckOnboarding middleware method looks like:This is being used in my routes like this:Now, if I go to /home or /account I get redirected to /setup as you would expect. This originally caused a redirect loop error hence why & $request->path() != 'setup' is in the Middleware.I feel like this is a really clunky way of doing it, and obviously doesn't match anything after setup like the setup/settings route I have created.Is there a better way to have this Middleware run on all routes for a user, but also set certain routes that should be exempt from this check? 

2017-03-31 07:37:46Z

I'm experimenting with Middleware in my Laravel application. I currently have it set up to run on every route for an authenticated user, however, I want it to ignore any requests that begin with the setup URI.Here is what my CheckOnboarding middleware method looks like:This is being used in my routes like this:Now, if I go to /home or /account I get redirected to /setup as you would expect. This originally caused a redirect loop error hence why & $request->path() != 'setup' is in the Middleware.I feel like this is a really clunky way of doing it, and obviously doesn't match anything after setup like the setup/settings route I have created.Is there a better way to have this Middleware run on all routes for a user, but also set certain routes that should be exempt from this check? There's nothing wrong with what you're doing, however, I would suggest splitting your route groups up instead i.e.:Alternatively, have a parent group for your auth:This will also mean you can remove the extra condition in your middleware:Hope this helps!You can utilize the Controller class for this with pretty spectacular results. If you create a __construct function inside of HTTP/Controllers/Controller.php then you can declare middleware to run on every controller action and even declare exceptions as needed.Be careful not to put any of the standard index, store, update, destroy functions in the exception or you'll open up potential security issues. Routes on which you dont want the middleware to run , simply put them outside of the function:

Laravel 4 validator for password field in edit account

Mwirabua Tim

[Laravel 4 validator for password field in edit account](https://stackoverflow.com/questions/17899755/laravel-4-validator-for-password-field-in-edit-account)

I need to check if a user has posted the same password as the one in the database. Field for old password is 'oldpass'. The custom validator i created is called 'passcheck'. It should fail or pass accordingly.My UsersController code below doesnt work. What could have I have done wrong? 

2013-07-27 16:02:33Z

I need to check if a user has posted the same password as the one in the database. Field for old password is 'oldpass'. The custom validator i created is called 'passcheck'. It should fail or pass accordingly.My UsersController code below doesnt work. What could have I have done wrong? You should use something like this,So, you have to get the record using username or any other field and then check the password.@lucasmichot offered even shorter solution:I would make it like this:This validator rule will make database query to check current user's passwordYou can make it even shorter and save query:Please dont tie your rule to an Html element. Use the parameters Laravel provides to create your custom rules. This would be (asuming that you have a user authenticated):

Laravel returning children of parents in same table

Randy Rankin

[Laravel returning children of parents in same table](https://stackoverflow.com/questions/32122849/laravel-returning-children-of-parents-in-same-table)

Using Laravel 5.1, I am trying to create a menu list from a MySQL categories table. My service provider returns data, but I don't understand how to create the child categories in a foreach loop. When I perform the loop, only the last row of the child query is returned. Any guidance would be appreciated.categories TableDesired ResultviewComposerServiceProvider.phpheader view

2015-08-20 15:52:46Z

Using Laravel 5.1, I am trying to create a menu list from a MySQL categories table. My service provider returns data, but I don't understand how to create the child categories in a foreach loop. When I perform the loop, only the last row of the child query is returned. Any guidance would be appreciated.categories TableDesired ResultviewComposerServiceProvider.phpheader viewFirst of all, what you are doing is inefficient. Your view iterates through all subcategories for every parent category. If you defined relations properly and made use of Eloquent's eager loading, you could fetch and access child categories in easier way.Start with defining relations:Once you have the relations defined properly, you can fetch whole category tree like below:The second composer won't be needed, as parent categories already contain children.Now, you only need to display the categories in your view:I've found the solution myself.

I have to iterate through the results to get access to the member variable.

How to get view data during unit testing in Laravel

Claire

[How to get view data during unit testing in Laravel](https://stackoverflow.com/questions/21139026/how-to-get-view-data-during-unit-testing-in-laravel)

I would like to check the array given to a view in a controller function has certain key value pairs.  How do I do this using phpunit testing?

2014-01-15 13:42:21Z

I would like to check the array given to a view in a controller function has certain key value pairs.  How do I do this using phpunit testing?I found a better way to do it.  I wrote a function in the TestCase which returns the array I want from the view data.So to get a value from the $data object I simply use $user = $this->getResponseData($response, 'user');Inside a test case use: $data = $this->response->getOriginalContent()->getData();Example:Example dumping data so you can see what in data(array) passed to view:Should get something back like what's in image:I managed it by doing it in a messy way. I used assertViewHas:So looking at how assertViewHas is implemented HERE it looks like, what the method does, is access the view's data after this call:In your code, the line:essentially returns the same thing as the line above it, namely a \Illuminate\Http\Response (which extends the symfony component \HttpFoundation\Response)So, inside the assertViewHas function it looks like laravel accesses the data using $response->$key, so I would try to access the clients and 'content' variables through the $response object.If that doesn't work try searching around the TestCase file in the Laravel framework ... I'm sure the answer is in there somewhere. Also try to dump the $response object and see what it looks like, there should be some clues there.The first thing I would try, though, is accessing your data through the $response object.You can access data in  the response and it can be checked..This worked for me:And from there you can check the contents of the message box for whatever error you might want verify.Looking for something like this in 2019, I got:

$response->getData()->data[0]->...my propertiesStill looking for a simpler way to access it.

Laravel validate error

Vitalii

[Laravel validate error](https://stackoverflow.com/questions/24328850/laravel-validate-error)

This is the errorThis is my codeWhat can this be?

2014-06-20 13:49:25Z

This is the errorThis is my codeWhat can this be?I believe that you probably have in your file.  (Your IDE probably thought it was being helpful.)  To use the static :: call, Validator should be aliased to Illuminate\Support\Facades\Validator. (The \app\config\app.php file does this for you by default.)Chances are good that changing the use statement to will fix things.Can you plz go to your app/config/app.php and check whether 

    'Illuminate\Validation\ValidationServiceProvider' 

is available or not.If not then just add this line and check if the problem is solved or not.

Hope it will help you.

Laravel Eloquent, select only rows where the relation exists

Kenyon

[Laravel Eloquent, select only rows where the relation exists](https://stackoverflow.com/questions/31598949/laravel-eloquent-select-only-rows-where-the-relation-exists)

I am trying to select from a table, but I only want to select things that have an existing relationship.For example, if I have Users and Comments, and Users haveMany Comments, I want to do something like:So, I only want to select Users that have at least 1 Comment, and paginate the result of that query. Is there any way to do this?

2015-07-23 22:11:20Z

I am trying to select from a table, but I only want to select things that have an existing relationship.For example, if I have Users and Comments, and Users haveMany Comments, I want to do something like:So, I only want to select Users that have at least 1 Comment, and paginate the result of that query. Is there any way to do this?According to Laravel's Eloquent documentation for querying relations (look for the "Querying Relationship Existence" subheading), this should work:Flip your thinking upside down and I think that you can do it.You may not need the groupBy() but that should get you started towards a way to do it.Then you should be able to iterate through each like so:

LARAVEL: Get an array of scheduled tasks for output in admin dashboard

John Mellor

[LARAVEL: Get an array of scheduled tasks for output in admin dashboard](https://stackoverflow.com/questions/35559769/laravel-get-an-array-of-scheduled-tasks-for-output-in-admin-dashboard)

Using the Laravel task scheduler I have created a number of tasks in Kernel.phpe.g:I would like to display the list of scheduled commands and there frequency (as well as last/next run time, which I can log myself using the before/after functions).However i'm stuck at the first hurdle. What i'm not sure how to do is get an array of the scheduled tasks that have been defined in Kernel.phpSimplified Question: How can I get an array of the scheduled tasks in Laravel?

2016-02-22 17:15:26Z

Using the Laravel task scheduler I have created a number of tasks in Kernel.phpe.g:I would like to display the list of scheduled commands and there frequency (as well as last/next run time, which I can log myself using the before/after functions).However i'm stuck at the first hurdle. What i'm not sure how to do is get an array of the scheduled tasks that have been defined in Kernel.phpSimplified Question: How can I get an array of the scheduled tasks in Laravel?There's actually no support out of the box for this, unfortunately. What you'll have to do is extend the artisan schedule command and add a list feature. Thankfully there's a simple class you can run:This will provide you with a php artisan schedule:list.  Now that's not exactly what you need, but then you can easily get this list from within your Laravel stack by executing:And that will provide you with a list of the schedule commands.Of course, don't forget to inject the Facade: use Illuminate\Support\Facades\Artisan;As your not running through the console you need to invoke the schedule method on the Kernel in your controller... (don't forget to make the schedule method public instead of protected).I was having the task to stop/enable and edit the frequency of the scheduled tasks from the admin dashboard. So I foreach them in Kernel.php and capture the output in function.Hope this help you.

Laravel 4 : How are Facades resolved?

theUnknown777

[Laravel 4 : How are Facades resolved?](https://stackoverflow.com/questions/20311336/laravel-4-how-are-facades-resolved)

I've kind of looking at what's going on Laravel 4 facades under the hood.Let's take this Facade as an example:If i'm not mistaken, the step by step (oversimplified) invocation would be:What I'am confused about is in the commented line below of the method File::resolveFacadeInstance() below:My questions are:

2013-12-01 10:51:56Z

I've kind of looking at what's going on Laravel 4 facades under the hood.Let's take this Facade as an example:If i'm not mistaken, the step by step (oversimplified) invocation would be:What I'am confused about is in the commented line below of the method File::resolveFacadeInstance() below:My questions are:I'll try to describe in short :So, you already know that resolveFacadeInstance method is called via __callStatic method of Facade class and component's Facade (i.e. File extends Facade) extends this Facade class.During the boot-up process of the framework, from public/index.php following line starts the execution of bootstrap/start.php fileSo, in this (bootstrap/start.php) file you can see some code likeIn this code snippet, require $framework.'/Illuminate/Foundation/start.php'; line starts the execution of Foundation/start.php file and in this file you may see something like thisThis (given above) line sets application instanse to $app property in the Facade classThen in the Foundation/start.php file at the bottom, you can see something like thisIn this code snippet given above, all the core components registered by the framework and as you know that, every component has a service provider class (i.e. FilesystemServiceProvider) and in every service provider class there is a method register which is (for FilesystemServiceProvider)Well, in this case $this->app['files'] setting (return new Filesystem) an anonymous function, which returns the filesystem when gets executedto $app['files'] so, when you call the File::get(), it finally calls the anonymous function and in this case, the following lineCalls the function for static::$app['file']; and this function returns the instance but before returning, it stores the instance in the $resolvedInstance variable, so, next time it can return the instance from the variable without calling the anonymous function again. 

So, it looks like that, static::$resolvedInstance[$name] = static::$app[$name]; calls the anonymous function which returns the instance and this function was registered earlier, when the app was started through boot up process.Important :Application extends Container and Container extends ArrayAccess class and that's why, a property of the $app object could be (accessed) set/get using array notation.I've tried to give you an idea but you have to look in to the code, step by step, you won't get it only reading/tracking the code once.

Laravel 4: Adding where clause to a join condition

user9507

[Laravel 4: Adding where clause to a join condition](https://stackoverflow.com/questions/20880151/laravel-4-adding-where-clause-to-a-join-condition)

It says in the laravel docs that it is possible to add where clause on a join, but whenever I try in my code using the where clause, I get the error: Call to undefined method Illuminate\Database\Query\JoinClause::where(). Anyone knows how to add where clause in a join clause?Laravel Website Example:Code I'm trying to implement:

2014-01-02 09:48:21Z

It says in the laravel docs that it is possible to add where clause on a join, but whenever I try in my code using the where clause, I get the error: Call to undefined method Illuminate\Database\Query\JoinClause::where(). Anyone knows how to add where clause in a join clause?Laravel Website Example:Code I'm trying to implement:if you want add more condition on a join add more $join->on or $join->orOn.if you want to add a condition to your first select, add it outside join function.Updated

In Laravel 4.0 which I think you use, you can't use where inside your join closure, but since Laravel 4.1 and above you can have where conditions after your join condition. I couldn't find documentation for Laravel 4.1 but this is the #join documentation for L4.2 and abovePlease Check Below AnswerTry This solutionYou are calling $current_date but you decarle $dateI don't know if this solve the problem, try it ;)You are sure that you are working with laravel 4.1? I think you are using laravel 4.0 instead of 4.1. Look in your composer.json file. https://laravel.com/docs/5.6/queries please check this link

Get rows where created date is older than 14 days

nielsv

[Get rows where created date is older than 14 days](https://stackoverflow.com/questions/34138194/get-rows-where-created-date-is-older-than-14-days)

This is the case:In my database I have a table deployments. The rows in the table also have a field created_at. Now I would like to select all rows where the created_date is older than 14 days. But I'm stuck on how to do this with Carbon. My query now looks like this:Can anyone help me with this?

2015-12-07 16:17:00Z

This is the case:In my database I have a table deployments. The rows in the table also have a field created_at. Now I would like to select all rows where the created_date is older than 14 days. But I'm stuck on how to do this with Carbon. My query now looks like this:Can anyone help me with this?You can use the subDays() method:You can use Carbon::now()->subDays(14)You can read more about Carbon its feature here Carbon Documentation

Laravel 5.2 login session not persisting

Nauphal

[Laravel 5.2 login session not persisting](https://stackoverflow.com/questions/34529146/laravel-5-2-login-session-not-persisting)

I have been implementing a simple authentication system on Laravel 5.2 using Sentinel. So, the above code outputs Login success after the authentication code. But, the login status is not getting persisted to other requests. ie: if I check the authentication status from other requests, it is saying that I am not logged in!I have even tried to implement a defaut laravel authencation using \Auth::attempt. But, that also giving the same thing.Any help on this is greatly appreciated.

2015-12-30 11:58:24Z

I have been implementing a simple authentication system on Laravel 5.2 using Sentinel. So, the above code outputs Login success after the authentication code. But, the login status is not getting persisted to other requests. ie: if I check the authentication status from other requests, it is saying that I am not logged in!I have even tried to implement a defaut laravel authencation using \Auth::attempt. But, that also giving the same thing.Any help on this is greatly appreciated.In Laravel 5.2 you need to apply web group middlewere to all your routes you wan't to make sessions work. This is the major change from Laravel 5.1.Please look at https://laravel.com/docs/5.2/routing#basic-routingThe default routes.php file looks like this at the moment:EDITYou can look also directly at https://github.com/laravel/laravel/blob/master/app/Http/Kernel.php into middlewareGroups property to know which middlewares are fired for web group middleware

Multiple Projects using single laravel instance

kanchan

[Multiple Projects using single laravel instance](https://stackoverflow.com/questions/22555094/multiple-projects-using-single-laravel-instance)

I am new to Laravel. As per my research on this framework I find it quite useful for my projects. However I am facing difficulty in customizing it to use a single instance of Laravel framework for multiple projects. I do not want to follow the multi site approach as available in Laravel i.e., using directory structure in models and controllers for projects because I won't be able to push my project related changes in a single step in Git.I want something like this.i.e., New project must have its own app directory and is able to use model functions from common project.This will ease my task and would be very useful for my upcoming projects.

If someone could help me with this I'll really appreciate.

2014-03-21 09:40:22Z

I am new to Laravel. As per my research on this framework I find it quite useful for my projects. However I am facing difficulty in customizing it to use a single instance of Laravel framework for multiple projects. I do not want to follow the multi site approach as available in Laravel i.e., using directory structure in models and controllers for projects because I won't be able to push my project related changes in a single step in Git.I want something like this.i.e., New project must have its own app directory and is able to use model functions from common project.This will ease my task and would be very useful for my upcoming projects.

If someone could help me with this I'll really appreciate.Create PSR-4 autoloading entries to separate your projects files by namespace:Everything common you put in Core, everything non-common in the related project files. Now you just have to create your files in theirs respective folders and namespace them:This is a BaseController in Core, used by all your controllers:This is a BaseController of the Main application using your Core Controller:And this is a HomeController of the Main application using your its Base Controller, as they are in the same namespace you don't even need to import the file:Every single class file in Laravel can be organized this way, even your views, so you can have those files:Then your routes could be separated (organized) and prefixed by namespace:Giving those urls:And pointing actions to those controller actions:There's not really a question here to be answered, but in general terms what you want to do is very feasible.You could create a directory under the apps folder for each project and namespace each of the classes in the structure you create below it. You'd then use PSR (ideally PSR-4) autoloading to make these classes accessible.You'd put the routes for each project in their own routes file and then include them through the main routes file, or you could create a service provider for each project, add it your app config file and use that to load the routes for that project.HOWEVER, all that said, this isn't what I would do. You haven't said why you want to structure your projects this way, so you may have a perfectly good reason, but personally I prefer to put common libraries into their own packages (helps to ensure clear boundaries and clean apis) and use Composer to pull them into each project.

Laravel: Escape「LIKE」clause?

mpen

[Laravel: Escape「LIKE」clause?](https://stackoverflow.com/questions/22749182/laravel-escape-like-clause)

How can I escape a LIKE clause in Laravel/Eloquent? e.g.,If $search contains a % or _ they need to be escaped.

2014-03-30 20:09:13Z

How can I escape a LIKE clause in Laravel/Eloquent? e.g.,If $search contains a % or _ they need to be escaped.The other answer forgets about escaping the escape character itself, here is a more robust solution:Temporary solution:referenceI was hoping for something database-agnostic and more robust. I think you can change the escape char in MySQL, although I don't know why you would.

How do I perform Laravel Artisan migrations on AWS Elastic Beanstalk?

oskarth

[How do I perform Laravel Artisan migrations on AWS Elastic Beanstalk?](https://stackoverflow.com/questions/22974516/how-do-i-perform-laravel-artisan-migrations-on-aws-elastic-beanstalk)

I have a Laravel installation and have set up three environments with their own corresponding config directories:I use php artisan migrate:make create_users_table etc as described here to create database migrations.In my local environment I use Vagrant and a simple MySQL server setup, and on staging & production I use AWS RDS.To configure database access for the staging environment I have a app/config/staging/database.php file with settings like this:I use git to deploy the app with git aws.push as described here.The question is: How do I run the migration on my staging (and later production) EBS server when deploying?

2014-04-09 21:42:58Z

I have a Laravel installation and have set up three environments with their own corresponding config directories:I use php artisan migrate:make create_users_table etc as described here to create database migrations.In my local environment I use Vagrant and a simple MySQL server setup, and on staging & production I use AWS RDS.To configure database access for the staging environment I have a app/config/staging/database.php file with settings like this:I use git to deploy the app with git aws.push as described here.The question is: How do I run the migration on my staging (and later production) EBS server when deploying?I solved it by creating a new directory in the root of my project named .ebextensions. In that directory I created a script file my-scripts.config:The file my-scripts.config gets executed when EBS deploys, is a YAML file and looks like this:Add the directory and file to git, commit, and run git aws.push and it will migrate.Explanations on how stuff in .ebextensions works can be found here.The path /var/app/ondeck is where your application lives when your script runs, it will afterwards be copied into /var/app/current.The artisan option --env=staging is useful for telling artisan what environment it should run in, so that it can find the correct database settings from app/config/staging/database.phpIf you need a quick and dirty way to log why the migrate command fails you might want to try out something like "php /var/app/ondeck/artisan --env=staging migrate > /tmp/artisan-migrate.log" so that you can log into your ec2 instance and check the log.

Laravel custom validation - get parameters

Rajesh Kumar

[Laravel custom validation - get parameters](https://stackoverflow.com/questions/30296615/laravel-custom-validation-get-parameters)

I want to get the parameter passed in the validation rule.For certain validation rules that I have created, I'm able to get the parameter from the validation rule, but for few rules it's not getting the parameters.In model I'm using the following code:In ValidatorServiceProvider I'm using the following code:But here I'm not able to get the sponsor id using the following:

2015-05-18 06:42:46Z

I want to get the parameter passed in the validation rule.For certain validation rules that I have created, I'm able to get the parameter from the validation rule, but for few rules it's not getting the parameters.In model I'm using the following code:In ValidatorServiceProvider I'm using the following code:But here I'm not able to get the sponsor id using the following:As a 4th the whole validator is passed to the closure you define with extends. You can use that to get the all data which is validated:By the way I'm using array_get here to avoid any errors if the passed input name doesn't exist.http://laravel.com/docs/5.0/validation#custom-validation-rulesWhy Input::get( $parameters ); then? you should check $parameters contents.Edit. 

Ok I figured out what are you trying to do. You are not going to read anything from input if the value you are trying to get is not being submitted. Take a look to You then will find that is working in places where sponsor_id was submited.

Laravel: How to include file from Vendor folder in Laravel

Growlithe

[Laravel: How to include file from Vendor folder in Laravel](https://stackoverflow.com/questions/21671816/laravel-how-to-include-file-from-vendor-folder-in-laravel)

I am trying to include the YouTube Analytics Service of Google but I can not  access it through the Vendor folder.It is not working, because it defaults to the App folder. How can I get out of the App folder and into the Vendor folder (where the YouTube Analytics file is at)?The error is {

2014-02-10 08:03:06Z

I am trying to include the YouTube Analytics Service of Google but I can not  access it through the Vendor folder.It is not working, because it defaults to the App folder. How can I get out of the App folder and into the Vendor folder (where the YouTube Analytics file is at)?The error is {From where do you want to include that file ?Place a reference to your file in composer.json autoload object:Run composer dumpautoload, and you'll have your file :)Actually you have in the helpers function the path so basically the function base_path give the direction to the root of your project soShould be the route to your vendor folder.You can se all the documentation in

Helper Functions LaravelBe sure that you are seeing the documentation of the laravel version that you are using (I put the link for the 4.2 version).This question was asked a long time ago and the answers reflect that.  Most the time now all you need to do is import it using the "use" statement if you installed it with composer.  Composer will already reference all the important directories.It should be something like this, but it will vary depending on the project.That could include a base class as well as some exception classes.Usually most packages if compliant with modern composer and php standards work in this fashion.

whereBetween Dates in laravel 4 eloquent

Md. Sahadat Hossain

[whereBetween Dates in laravel 4 eloquent](https://stackoverflow.com/questions/26082043/wherebetween-dates-in-laravel-4-eloquent)

I have a query like thatNow how I can convert this query in laravel 4. I use Eloquent

2014-09-28 05:45:09Z

I have a query like thatNow how I can convert this query in laravel 4. I use Eloquentmaybe you can try thisIn your example, you're checking both from_date and to_date for the same range of dates...if this will always be the case, you can make this query a bit more "eloquent":In the SpPrice.php model:Then, to call this method from a controller:You can use whereRaw() to add a raw where clause to the query, for example:Or maybe you can use DB::raw() as first argument of whereBetween(), but I'm not sure if it's possible, in that case you can use orWhere() with a closure to write a more readable code, for example:But I'm not quite sure if this works, give it a try.

Traits with PHP and Laravel

whoacowboy

[Traits with PHP and Laravel](https://stackoverflow.com/questions/30922175/traits-with-php-and-laravel)

I am using Laravel 5.1 and would like to access an array on the Model from the Trait when the Model before the model uses the appends array. I would like to add certain items to the appends array if it exists from my trait. I don't want to edit the model in order to achieve this. Are traits actually usable in this scenario or should I use inheritance?Here is how my current setup works.TraitModelWhat I would like to do is something to achieve the same effect as extending a class. I have a few similar traits, so using inheritance gets somewhat ugly.I have seen some workarounds for this, but none of them seem better/cleaner than just adding the item to the array manually. Any ideas are appreciated.UpdateI discovered this way of accomplishing what I need for one trait, but it only works for one trait and I don't see an advantage of using this over inheritance.traitHow I am currently handling my Model, for what it is worth. model

2015-06-18 17:42:43Z

I am using Laravel 5.1 and would like to access an array on the Model from the Trait when the Model before the model uses the appends array. I would like to add certain items to the appends array if it exists from my trait. I don't want to edit the model in order to achieve this. Are traits actually usable in this scenario or should I use inheritance?Here is how my current setup works.TraitModelWhat I would like to do is something to achieve the same effect as extending a class. I have a few similar traits, so using inheritance gets somewhat ugly.I have seen some workarounds for this, but none of them seem better/cleaner than just adding the item to the array manually. Any ideas are appreciated.UpdateI discovered this way of accomplishing what I need for one trait, but it only works for one trait and I don't see an advantage of using this over inheritance.traitHow I am currently handling my Model, for what it is worth. modelTraits are sometimes described as "compiler-assisted copy-and-paste"; the result of using a Trait can always be written out as a valid class in its own right. There is therefore no notion of parent in a Trait, because once the Trait has been applied, its methods are indistinguishable from those defined in the class itself, or imported from other Traits at the same time.Similarly, as the PHP docs say:As such, they are not very suitable for situations where you want to mix in multiple variants of the same piece of behaviour, because there is no way for base functionality and mixed in functionality to talk to each other in a generic way.In my understanding the problem you're actually trying to solve is this:One approach would be to continue to use Traits, and use Reflection to dynamically discover which methods have been added. However, beware that Reflection has a reputation for being rather slow.To do this, we first implement a constructor with a loop which we can hook into just by naming a method in a particular way. This can be placed into a Trait of its own (alternatively, you could sub-class the Eloquent Model class with your own enhanced version):Then any number of Traits implementing differently named extraConstruct methods:Finally, we mix in all the traits into a plain model, and check the result:We can set the initial content of $appends inside the decorated model itself, and it will replace the BaseModel definition, but not interrupt the other Traits:However, if you over-ride the constructor at the same time as mixing in the AppendingGlue, you do need to do a bit of extra work, as discussed in this previous answer. It's similar to calling parent::__construct in an inheritance situation, but you have to alias the trait's constructor in order to access it:This can be avoided by inheriting from a class which either exists instead of the AppendingGlue trait, or already uses it:Here's a live demo of all of that put together.I thought I'd add an update for 2019 since this was one of the first discussions that popped up when trying to do a similar thing.  I'm using Laravel 5.7 and nowadays Laravel will do the reflection that IMSoP mentioned.After the trait has been booted, Laravel will then call initializeTraitName() on the constructed object (where TraitName is the full name of the trait).To add extra items to $appends from a trait, you could simply do this...KISS:I don't see any reason why you should use trait when your are simply appending attributes. I would only recommend using trait without a constructor like you were doing, only if you model is getting pretty bulky and you wish to slim down things.Please also note this not the correct way of appending attributeYou could do this:Appends attribute names should the snake_case of its method NameEdited: The idea behind appends is to dynamically add fields that doesn't exist in your database table to your model so after you can do like:

Laravel 5 Class admin does not exist

Djordje Vanjek

[Laravel 5 Class admin does not exist](https://stackoverflow.com/questions/29363811/laravel-5-class-admin-does-not-exist)

Having problem with Laravel 5 and this admin class, the thing is that everything worked on localhost and now after I deployed it on server (made ton of fixes but didn't touched this) it doesn't work.The Error is coming out when I go to the page '/moderate' which should be visible just by the admin.Error:AdminController location(App/Http/Controllers/):Routes:

2015-03-31 08:16:37Z

Having problem with Laravel 5 and this admin class, the thing is that everything worked on localhost and now after I deployed it on server (made ton of fixes but didn't touched this) it doesn't work.The Error is coming out when I go to the page '/moderate' which should be visible just by the admin.Error:AdminController location(App/Http/Controllers/):Routes:Fixed!Forgot to sync Kernel.phpAdditional infoapp/Htpp/Kernel.php not console/Kernel.php

Converting a laravel application to lumen

Bill Garrison

[Converting a laravel application to lumen](https://stackoverflow.com/questions/33811475/converting-a-laravel-application-to-lumen)

So, I have been building a laravel 5.1 API and after months of work on it it dawned on me that I should have been using Lumen all along. Is there a way to convert a laravel app to a lumen app?

2015-11-19 18:19:03Z

So, I have been building a laravel 5.1 API and after months of work on it it dawned on me that I should have been using Lumen all along. Is there a way to convert a laravel app to a lumen app?Lumen is essentially a stripped down version of Laravel. The application structure is the same, so as far as that goes it should be safe to create a new Lumen app and copy the app directory from your Laravel app.However, for performance reasons, Lumen does not have all the Laravel goodies working out of the box, and some are not there at all. So depending on how you've implemented you're Laravel app, here's a few things that you might need to change in order to migrate your app:I've probably not covered everything, but this is to offer an idea on what you should be looking out for. All those things can be enabled, but the performance benefits Lumen brings are mostly because those things are disabled to get rid of that overhead, so try to modify your application wherever possible to make use of what Lumen offers by default.Assuming everything you are using is in the Lumen documentation and actually available to Lumen, you should be able to create a new Lumen project and drop your app folder from Laravel into the new Lumen project.

PUT/PATCH request with postman returns status code 0 in Laravel

sesc360

[PUT/PATCH request with postman returns status code 0 in Laravel](https://stackoverflow.com/questions/30775428/put-patch-request-with-postman-returns-status-code-0-in-laravel)

I have written some REST API Methods, including one for updating a DB entry:The Route is defined as:A Request is being handled by:But when I use postman and try to update the existing DB entry and I fill in the owner and street variable to be sent in POSTMAN as requested, I get the message: "Could not get any response. Returns Status Code 0"All the other methods work fine. Is the definition of my routing not correct?Update

When I send the data as x-www-form-urlencodedit works! When I send them as form-data it brings up the error message.

2015-06-11 08:24:51Z

I have written some REST API Methods, including one for updating a DB entry:The Route is defined as:A Request is being handled by:But when I use postman and try to update the existing DB entry and I fill in the owner and street variable to be sent in POSTMAN as requested, I get the message: "Could not get any response. Returns Status Code 0"All the other methods work fine. Is the definition of my routing not correct?Update

When I send the data as x-www-form-urlencodedit works! When I send them as form-data it brings up the error message.It looks like in Postman you should point that the data you send is x-www-url-formurlencoded.In Postman

Returning multiple variables with view::share( ) - Laravel 5.1

senty

[Returning multiple variables with view::share( ) - Laravel 5.1](https://stackoverflow.com/questions/32939485/returning-multiple-variables-with-viewshare-laravel-5-1)

I want to return multiple variable to my view.This code works fine, however how can if I also want to share $needToBePassed, what should I do?Is rewriting it is a good practice?

2015-10-04 23:34:43Z

I want to return multiple variable to my view.This code works fine, however how can if I also want to share $needToBePassed, what should I do?Is rewriting it is a good practice?You can pass an array of data, I know the question is already answered, but maybe I can still help a few people by adding this solution. This way you don't have to change all your views.I was looking for a way to solve this issue without changes all my views.

Laravel /broadcasting/auth Always Fails With 403 Error

user2321275

[Laravel /broadcasting/auth Always Fails With 403 Error](https://stackoverflow.com/questions/41728930/laravel-broadcasting-auth-always-fails-with-403-error)

I have recently delved into Laravel 5.3's Laravel-Echo and Pusher combination. I have successfully set up public channels and moved on to private ones. I am having trouble with Laravel returning a 403 from the /broadcasting/auth route, no matter what I do to try to authorize the action (up to and including using a simple return true statement). Can anyone tell me what I am doing wrong?App/Providers/BroadcastServiceProvider.php:

    

resources/assets/js/booststrap.js:I can see the event and it's payload in my Pusher debug console, it is simply failing once it hits the auth route.

2017-01-18 20:33:07Z

I have recently delved into Laravel 5.3's Laravel-Echo and Pusher combination. I have successfully set up public channels and moved on to private ones. I am having trouble with Laravel returning a 403 from the /broadcasting/auth route, no matter what I do to try to authorize the action (up to and including using a simple return true statement). Can anyone tell me what I am doing wrong?App/Providers/BroadcastServiceProvider.php:

    

resources/assets/js/booststrap.js:I can see the event and it's payload in my Pusher debug console, it is simply failing once it hits the auth route.Error 403 /broadcasting/auth with Laravel version > 5.3 & Pusher, you need change your code in resources/assets/js/bootstrap.js withAnd in app/Providers/BroadcastServiceProvider.php change bywithorit worked for me, and hope it help you.What worked for me was to use the method private of the Laravel Echo package:

https://laravel.com/docs/5.3/notifications#listening-for-notificationsI solve it by creating channel route. Create your Authorizing Channels in routes->channels.phpSee Documentation : https://laravel.com/docs/5.4/broadcasting#authorizing-channelsthanks I paired socket.io with redis and also had a problem with 403 error, even though there weren't any authentication middlewares over /broadcasting/auth route. Only after whatching laracasts lesson I figured out that just channel authorization is not enough, there always should be user and no matter how you authenticate and obtain user, using default laravel auth or some token algorithm - jwt or anything else.Authenticated user is automatically resolved and passed as first parameter to  to closures functions in routes/channels.php file, so you can check channel availability for currently logged in user

Check how you are authorising your channel. Depending on your setup this might help. Update your BroadcastServiceProvider with the following:Adds in the Auth API middleware for use with Laravel Passport.In my case the problem was a wrong user id:This can happen if you are no longer logged in. Make sure you are actually logged into the Laravel app and that your current session hasn't expired.I logged back in and it worked for me.In case, someone comes in the latest Laravel 5.7 with the same issues, the good solution worked for me is to check authentication in each channel before returning or on the return like below.This way it works with any channel broadcasting any event including users.I hope it may help someone else.

How to debug Laravel error 500 with no logs, no information

Gauthier

[How to debug Laravel error 500 with no logs, no information](https://stackoverflow.com/questions/44921945/how-to-debug-laravel-error-500-with-no-logs-no-information)

I'm working on an existing Laravel application in order to develop new feature but after installing the app on my computer, I have an error 500 and no clue to resolve it.In my app.php file I have set : But still I have no information, no logs are generated in storage/logs . I have no idea of what could be the problem.The previous developer was on windows and I'm working on Linux but I'm not sure this is revelant.EDIT:I also have those variable in my config/app.php

2017-07-05 09:17:01Z

I'm working on an existing Laravel application in order to develop new feature but after installing the app on my computer, I have an error 500 and no clue to resolve it.In my app.php file I have set : But still I have no information, no logs are generated in storage/logs . I have no idea of what could be the problem.The previous developer was on windows and I'm working on Linux but I'm not sure this is revelant.EDIT:I also have those variable in my config/app.phpNext to looking into your .env file, make sure permissions are correctly set (and good practice to create the storage/logs folder(s) manually - at least on windows that causes problems).Some PHP exceptions are not possible to catch, so Laravel cant handle them. For example syntax errors, or maximum memory limit errors.Ref.: http://php.net/manual/en/function.set-error-handler.phpI tried to everything to find out the issue like enabling error reporting to report all like :Also i tried to add my custom error handler as well but nothing worked for me. So finally i found the actual issue in php error log file in apache error logs folder (Applications/MAMP/logs as am using Mac).

Debug iconv_strlen error - PHP 5.5

Gravy

[Debug iconv_strlen error - PHP 5.5](https://stackoverflow.com/questions/22492776/debug-iconv-strlen-error-php-5-5)

I am trying to export a document to PDF using Laravel & DomPDF. This works on my mac, but not on staging or live server. Error as follows:I have no idea what this means, and cannot find any solutions.iconv_strlen(): Wrong charset, conversion from8bit//IGNORE' to UCS-4LE' is not allowedI have tried adding the following to .htaccessI have tried adding the following to the top of the view which I am trying to generate the pdf for:If you need any further information to assist me in debugging, please ask in comments.

2014-03-18 22:54:22Z

I am trying to export a document to PDF using Laravel & DomPDF. This works on my mac, but not on staging or live server. Error as follows:I have no idea what this means, and cannot find any solutions.iconv_strlen(): Wrong charset, conversion from8bit//IGNORE' to UCS-4LE' is not allowedI have tried adding the following to .htaccessI have tried adding the following to the top of the view which I am trying to generate the pdf for:If you need any further information to assist me in debugging, please ask in comments.Problem solved. Thanks BrianS. This was solved by re-installing mbstring. BrianS's solution does indeed solve the issue, but I thought it'd be interesting to explain what caused the original problem.In the latest release of dompdf,

the Cpdf class

contains about 30 calls to mb_strlen() with the $encoding parameter set to '8bit', which is a

valid encoding for mb_strlen().Laravel's composer.json

requires patchwork/utf8. It provides the mb_strlen() shim

which calls iconv_strlen().PHP usually uses either glibc or libiconv for its iconv module.

For both libraries, the list of supported encodings can be

displayed using iconv --list.Neither of those libraries support an encoding called '8bit', which is why iconv_strlen()

throws that error:Installing the mbstring PHP module causes mb_strlen() to be executed natively,

so the shim isn't used and the error doesn't occur.@rofavadeka One solution is to create a

fork of the

dompdf repo, and replace every use of

'8bit' encoding with a different 8-bit encoding which is supported by

mb_strlen(), glibc and libiconv.I've written a script to determine which encodings are suitable.

Here's the output of the script for

glibc and

libiconv.

The suitable encodings are:I was getting that error in Hash:make() during seeding my DB for testing.Enabling php_mbstring in php-cli.ini caused it.In Windows the solution is: remove the semicolon before If you are using WHM then you can use EasyApache to rebuild.  Once you get the modules options after selecting your version of PHP select the "Exhaustive Options List" button.  Then ctrl+f "mbstring" and it should come up.  Mark the check box and rebuild.  It should work.If you are on wamp or some custom stack, remember that the php in your wamp may be using a custom php_something.ini for the apache use, due to which even if the wamp GUI is showing that mbstring is on(uncommented) still its quiet possible that that same line is commented out(disabled/off) inside the actual php.ini file (True Story).Solution:-

Just navigate toIn this directory you shall find various .ini files named slightly differently, Mine was using php_uwamp.ini for the stack but for the CLI,  php was using the adjacent file named php.ini.This had me pulling hairs for quiet long, thought it might help someone.

One-to-many then eager load an array with Laravel Eloquent ORM

drew schmaltz

[One-to-many then eager load an array with Laravel Eloquent ORM](https://stackoverflow.com/questions/14288065/one-to-many-then-eager-load-an-array-with-laravel-eloquent-orm)

With Laravel and the eloquent ORM, I want to create an array or object of all posts and corresponding comments that belong to a specific user (the logged in one).  The result will then be used with Response::eloquent(); to return JSON.Basically in pseudo-code:orI have my database setup per the usual with a user's table, comments table and posts table.  The comments table has a post_id and the posts table has a user_id.The long way of doing this without Laravel would be something like:But I want to accomplish it with Laravel's Eloquent ORM.

2013-01-11 23:02:31Z

With Laravel and the eloquent ORM, I want to create an array or object of all posts and corresponding comments that belong to a specific user (the logged in one).  The result will then be used with Response::eloquent(); to return JSON.Basically in pseudo-code:orI have my database setup per the usual with a user's table, comments table and posts table.  The comments table has a post_id and the posts table has a user_id.The long way of doing this without Laravel would be something like:But I want to accomplish it with Laravel's Eloquent ORM.It looks like you don't even need a nested eager load, you just need to modify the query that with returns, so:You can daisy chain most of the methods in the Eloquent system, generally they're just returning a Fluent query object.(I haven't tested it but I'm fairly certain that'll work. Also, you can't do it on ::all() because that calls ->get() for you. You have to dig in the source code to find this, I don't think the Eloquent documentation mentions that's what it's doing.)Also the Eager Loading Documentation covers nested eager loading, so you could load all users, with their posts, with the comments:

Role based permission to Laravel

UselesssCat

[Role based permission to Laravel](https://stackoverflow.com/questions/47821342/role-based-permission-to-laravel)

I am trying to do a role based permission control in a Laravel application. I want to check what actions can some user do, but i can't figure out how to implement gates and policies in my model (the permission description is in the database and are booleans asociated to a table that stores the resource's ids). This is the database model that im using:I would like to know if laravel gates is useful in my case, and how can i implement it, if not, how to make a basic middleware that take care of permission control to protect routes (or controllers).In the table resource i have a uuid that identifies the resources, the alias is the name of the resource and has dot notation values of actions or context of the resource (eg. 'mysystem.users.create', 'mysystem.roles.delete', 'mysystem.users.images.view'). The policy tables has a boolean 'allow' field that describes the permission of users.Thanks in advance.

2017-12-14 20:13:34Z

I am trying to do a role based permission control in a Laravel application. I want to check what actions can some user do, but i can't figure out how to implement gates and policies in my model (the permission description is in the database and are booleans asociated to a table that stores the resource's ids). This is the database model that im using:I would like to know if laravel gates is useful in my case, and how can i implement it, if not, how to make a basic middleware that take care of permission control to protect routes (or controllers).In the table resource i have a uuid that identifies the resources, the alias is the name of the resource and has dot notation values of actions or context of the resource (eg. 'mysystem.users.create', 'mysystem.roles.delete', 'mysystem.users.images.view'). The policy tables has a boolean 'allow' field that describes the permission of users.Thanks in advance.This is the way that I implement role based permissions in Laravel using Policies.Users can have multiple roles.

Roles have associated permissions.

Each permission allows a specific action on a specific model.Roles tablePermissions tablePermission Role Pivot TableRole User Pivot TableUserRolePermissionA policy is required for each model.  Here is an example policy for a model item.  The policy defines the 'rules' for the four actions 'view, create, update, delete.Register each policy in AuthServiceProvider.phpIn each controller, refer to the corresponding authorisation action from the policy.For example, in the index method of ItemController:In your views, you can check if the user has a specific role:or if a specific permission is required:Answer for your Question:how to make a basic middleware that take care of permission control to protect routes (or controllers)?.Just an Example:

Here is the simple role middleware for your routes

AdminRoleAfter defining this middleware

Update your kernel.php file as And to use this route middleware:

There are different way to use route middleware but following is one exampleNote: There are some tools and libraries for roles and permission on laravel but above is the example of creating basic route middle-ware.Because the laravel model did not fit my database so much, I did almost everything again. This is a functional draft in which some functions are missing, the code is not optimized and it may be a bit dirty, but here it is:proyect/app/Components/Contracts/Gate.php This interface is used to create singleton in AuthServiceProvider.proyect/app/Components/Security/Gate.php This file loads the permissions from the database. This could be improved a lot :(proyect/app/Traits/Security/AuthorizesRequests.php This file is added to controller. Allows to use $this->authorize('stuff'); in a controller when is added.proyect/app/Providers/AuthServiceProvider.php This file is the same that can be found on proyect/vendor/laravel/framework/src/Illuminate/Auth/AuthServiceProvider.php, but i changed some parts to add new classe. Here are the important methods:proyect /app/Http/Middleware/AuthorizeRequest.php This file is used to allow add the 'can' middleware to routes, eg: Route::get('users/', 'Security\UserController@index')->name('users.index')->middleware('can:inet.user.list');but you must overwrite the default value in proyect/app/Http/Kernel.php:To use @can('inet.user.list') in a blade template you have to add this lines to proyect/app/Providers/AppServiceProvider.php:User model at proyect/app/Models/Security/User.phpGroup model at proyect/app/Models/Security/Group.php THis is the same than Role, change only namesResource Model proyect/app/Models/Security/Resource.phpThere are a lot of things that I have not put here, but this is what I have so farThe problem i find with trying to combine permissions from a db with policies is when it comes to the ownership of a record.Ultimately in our code we would like to check access to a resource using permission only. This is because as the list of roles grows we don't want to have to keep adding checks for these roles to the codebase.If we have a users table we may want 'admin' (role) to be able to update all user records but a 'basic' user to only be able to update their own user record. We would like to be able to control this access SOLELY using the database.However, if you have an 'update_user' permission then do you give it to both roles?

If you don't give it to the basic user role then the request won't get as far as the policy to check ownership.Hence, you cannot revoke access for a basic user to update their record from the db alone.

Also the meaning of 'update_user' in the permissions table now implies the ability to update ANY user.SOLUTION?Add extra permissions to cater for the case where a user owns the record.So you could have permissions to 'update_user' AND 'update_own_user'.The 'admin' user would have the first permission whilst the 'basic' user would have the second one.Then in the policy we check for the  'update_user' permission first and if it's not present we check for the 'update_own_user'.If the 'update_own_user' permission is present then we check ownership. Otherwise we return false.The solution will work but it seems ugly to have to have manage 'own' permissions in the db.

Retrieving GET and POST data inside controller in Laravel 4

Jan

[Retrieving GET and POST data inside controller in Laravel 4](https://stackoverflow.com/questions/18761555/retrieving-get-and-post-data-inside-controller-in-laravel-4)

I've been searching the web for how to get POST data inside the controller, so far I have found two solutions: Input::get() and $_POST.The comment for Input::get() reads:What is this "named" source they refer to? What is it I should use instead of Input::get() ?

2013-09-12 10:18:42Z

I've been searching the web for how to get POST data inside the controller, so far I have found two solutions: Input::get() and $_POST.The comment for Input::get() reads:What is this "named" source they refer to? What is it I should use instead of Input::get() ?The documentation shows you can retrieve an input value for any HTTP verb by using  Input::get().TO get all the inputs use Input::all() method.

To check if specific column exists use Input::has('column_name') eg.Input::has('name').

To retrieve column value use Input::get('column_name') eg. Input::get('name').You can get a parameter from url using :-if you want to get GET parameter using :-if you want to get POST parameter using :-

How to Migrate and seed before the full test suite in Laravel with in memory database?

Franklin Rivero

[How to Migrate and seed before the full test suite in Laravel with in memory database?](https://stackoverflow.com/questions/38573830/how-to-migrate-and-seed-before-the-full-test-suite-in-laravel-with-in-memory-dat)

I'm trying to set up the test environment in my Laravel project.

I'm using http://packalyst.com/packages/package/mayconbordin/l5-fixtures with json for the seeding with a sqlite in memory database and calling:in my setUp function but this is executed before every single test which it can grow to thousands in this project.I tried the setUpBeforeClass but it didn't work. 

I think there because the createApplication method is called in every test and that reset the whole application and also wasn't loading the fixtures from the json probably for the same reason.

2016-07-25 17:16:23Z

I'm trying to set up the test environment in my Laravel project.

I'm using http://packalyst.com/packages/package/mayconbordin/l5-fixtures with json for the seeding with a sqlite in memory database and calling:in my setUp function but this is executed before every single test which it can grow to thousands in this project.I tried the setUpBeforeClass but it didn't work. 

I think there because the createApplication method is called in every test and that reset the whole application and also wasn't loading the fixtures from the json probably for the same reason.This is how I did it in case someone else is struggling with the same, I created a base testClase class that inherits from Laravel's and did this:I overwrote the createApplication() and tearDown() methods. I changed the first one to use the same $app configuration and remove the part of the teardown() where it flush $this->app.Every other of my test has to inherit from this TestClass and that's it.Everything else didn't work. This works even with in memory database, it's 100s times faster. if you are dealing with user session, once you log the user in you will have to log him out in tear down, otherwise the user will be logged in because the app environment is never reconstructed or you can dd something like this to refresh the application every time you want:And add this to the tearDown() before the $this->setUphasRun = false;:The main approach in the above solutions is to run all migrations for all tests. I prefer an approach to specify which migrations and seeds should run for each test. It may be more worthwhile on big projects as this can reduce timings for tests by about 70% (using the sqlite in-memory DB as already explained above). For small projects, it's maybe a bit too much faffing about. But anyway...Use these in TestCase:Then call migrate() and seed as required in individual tests, eg:create file in your project testrunner with this content (also prepare  .env.testing file with testing environment variables) :And give permission to execute by command chmod +x testrunner and execute it by ./testrunner. Thats all :)How about setting up the database using a migration and seeds and then using database transcations? (https://laravel.com/docs/5.1/testing#resetting-the-database-after-each-test)I wanted to be able to set up my test database via artisan like this:As you can guess, I'm using mysql, but I don't see why this shouldn't work for sqlite.

This is how I do it.config/database.phpFirst add the test database info to your config/database.php file, under your current database info.If you do it like this, don't forget to add DB_TEST_DATABASE to your  .env file:phpunit.xmlAny values set in the phpunit.xml file, under  overwrite values given in the .env file. So we tell phpunit to use the "mysql_testing" database connection instead of the "mysql" database connection.Test classMy test classes look like this:Here the database is reset before every test, which is why I prefer Option 1. But you might be able to get it to work the way you like.I tried this once before, and it might work for you.tests/TestCase.php

Extend the test case, to load a new .env file, .env.testing.env.testingCreate this new .env file and add in the database detailsIn the test class:Use PDO to drop and recreate the database - easier than trying to truncate everything.

Then use artisan to migrate and seed the database.

Object of class Carbon\Carbon could not be converted to int

Patrick

[Object of class Carbon\Carbon could not be converted to int](https://stackoverflow.com/questions/41454800/object-of-class-carbon-carbon-could-not-be-converted-to-int)

I have already search for this, and i did find some topics discussing this problem, however none of which I felt like was the way I want to go, so therefore I hope to get a better sugestion here.I want to get a timestamp from when a user was last updated.If i run this, it gives me this errorThis is because it returns a Carbon instance in Laravel 5.2, and I only need the timestamp.How do i fetch the "date" from the carbon instance, so I only get 2017-01-04 00:35:38 - I have no idea where .000000 comes from, as this doesn't show up in the database. In the MySQL database, it simply shows 2016-07-20 20:23:07 as of type timestamp.Hope for some pointers and suggestions

2017-01-04 01:18:00Z

I have already search for this, and i did find some topics discussing this problem, however none of which I felt like was the way I want to go, so therefore I hope to get a better sugestion here.I want to get a timestamp from when a user was last updated.If i run this, it gives me this errorThis is because it returns a Carbon instance in Laravel 5.2, and I only need the timestamp.How do i fetch the "date" from the carbon instance, so I only get 2017-01-04 00:35:38 - I have no idea where .000000 comes from, as this doesn't show up in the database. In the MySQL database, it simply shows 2016-07-20 20:23:07 as of type timestamp.Hope for some pointers and suggestionsThe Carbon object has a toDateTimeString method you can use:It will give you the value 2017-01-04 00:35:38 as a string.While using Carbon library to perform multiple action using date.Example :Right now what you are doing.Suggest : 

Laravel 5 not getting any error logs

SamXronn

[Laravel 5 not getting any error logs](https://stackoverflow.com/questions/36113032/laravel-5-not-getting-any-error-logs)

I installed Laravel 5 on a new VPS, I was running everything fine but I noticed I wasn't getting any Laravel errors the system would only fire a server 500 error at me which is no help when debugging my code. When I looked in the laravel storage/log it was empty which was strange because I had set the correct file permissions of 777. So how do I get laravel logs? Why aren't they being written to my storage/log file.

2016-03-20 11:16:52Z

I installed Laravel 5 on a new VPS, I was running everything fine but I noticed I wasn't getting any Laravel errors the system would only fire a server 500 error at me which is no help when debugging my code. When I looked in the laravel storage/log it was empty which was strange because I had set the correct file permissions of 777. So how do I get laravel logs? Why aren't they being written to my storage/log file.If you've set your file permissions correctly on the /storage file directory and you're running on a VPS no shared hosting you might want to check your apache log, inside var/log/apache2/error.logHere you might just see a line that read something along the lines of /var/www/html/storage/logs/laravel.log" could not be opened: failed to open stream: Permission deniedWell this is strange because you have the correct file permissions... Let's start by SSH'ing into your VPS head to the directory where laravel is installed normally cd /var/www/htmlIn here if you run ls -l You should get some results similar to this image below:

Notice how we've been accessing the site as the root user, this is our problem and we can confirm this by running ps aux | grep apache2You can see here apache2 is running as the user www-data, which is normal for apache. Which means when our laravel installation trys to move files either using ->move() or just trying to write the log file it fails as the www-data user doesn't have permission. So you can change to this www-data user by running: chown -R www-data:www-data * (shorthand for same user/group chown -R www-data. *)Now if you run ls -l in your www/html directory you should see root user changed to www-data:This means were now editing the files as the www-data user which has permission, so any changes you make via SFTP should reflect this user change. Fixed! Edit - This is the first time I answered my own question hopefully it's okay.

Laravel 5.1 hasManyThrough relationships and pivot table

V4n1ll4

[Laravel 5.1 hasManyThrough relationships and pivot table](https://stackoverflow.com/questions/36596068/laravel-5-1-hasmanythrough-relationships-and-pivot-table)

I have the following models / tables setup in my application;timesheetusersupervisor_userUsers get "assigned" to supervisors via the supervisor_user pivot table.I have the following relationship setup on the User model, which gets supervisor users.I want to setup another relationship which gets a list of timesheets "assigned" to a supervisor.  I'm guessing with hasManyThrough relationship...but not exactly how to write the code for it.How can I achieve what I need?

2016-04-13 10:47:48Z

I have the following models / tables setup in my application;timesheetusersupervisor_userUsers get "assigned" to supervisors via the supervisor_user pivot table.I have the following relationship setup on the User model, which gets supervisor users.I want to setup another relationship which gets a list of timesheets "assigned" to a supervisor.  I'm guessing with hasManyThrough relationship...but not exactly how to write the code for it.How can I achieve what I need?In your Role model make a method:In your User model make a method:And then make a call:Yes, you are right you can achieve timesheets for supervisor using two methods. Either use join query, that is joining multiple tables and finding the timesheets or  using hasManyThrough. The Easy way:  because you have user_id in supervisor table and I assume that is the user that belongs to the given supervisor.  We can simply compare supervisor_users.user_id with timesheets.user_id. This should do the trick. If you need to add where or select clause then add before get() thing.The faster way :

If you check the laravel documentation, for hasmanythrough, you would probably have a case where its one to many and again one to many. So like: country has many users and users have many posts. In this if we do hasmanythrough we can pull posts that belongs to country. And for you what I see is, A single supervisor has many users and a user has many timesheet. Please correct me here if I am wrong my solution is based on that,  so I will help u get timesheets for a given supervisor. Inshort all the timesheets that belong to a user which is again belonged to a given supervisor. You will have all the timesheets for all the users for a given supervisor. Here argument one is the final table from which you want data to be. And argument two is your intermediate table we passing through. You can add third and fourth argument if you like for Id's.

Now simply try :

    $supervisor_timesheet = $Supervisor_user->timesheets

Clarify how to setup a one-to-many relationship in Laravel's Eloquent ORM

eimajenthat

[Clarify how to setup a one-to-many relationship in Laravel's Eloquent ORM](https://stackoverflow.com/questions/16869249/clarify-how-to-setup-a-one-to-many-relationship-in-laravels-eloquent-orm)

Okay, I'm working through the Laravel 4 docs to setup a one-to-many relationship between two models.  Obviously, one side should use hasMany().  But for the other side, should I use hasOne or belongsTo?  Does it matter?  What's difference?  Why do both exist?I had thought hasOne would be for one-to-one relationships, and belongsTo would be for the one side of one-to-many.  But in the docs, for inserting a related model here:http://laravel.com/docs/eloquent#inserting-related-modelsthey are using save() which seems to only be present in hasOne and hasMany relationships, not in belongsTo.  It looks like belongsTo uses associate() for the same purpose:https://github.com/laravel/framework/blob/master/src/Illuminate/Database/Eloquent/Relations/BelongsTo.php#L188Maybe I just need some general background on when to use belongsTo vs. hasOne, and why belongsTo uses associate() while hasOne uses save().EDIT: I guess my point of confusion was that in the docs (http://laravel.com/docs/eloquent#inserting-related-models), they used:where I would have used:Is there an advantage to one way or the other?  Or is it just a question of what makes sense in the context?

2013-06-01 04:58:32Z

Okay, I'm working through the Laravel 4 docs to setup a one-to-many relationship between two models.  Obviously, one side should use hasMany().  But for the other side, should I use hasOne or belongsTo?  Does it matter?  What's difference?  Why do both exist?I had thought hasOne would be for one-to-one relationships, and belongsTo would be for the one side of one-to-many.  But in the docs, for inserting a related model here:http://laravel.com/docs/eloquent#inserting-related-modelsthey are using save() which seems to only be present in hasOne and hasMany relationships, not in belongsTo.  It looks like belongsTo uses associate() for the same purpose:https://github.com/laravel/framework/blob/master/src/Illuminate/Database/Eloquent/Relations/BelongsTo.php#L188Maybe I just need some general background on when to use belongsTo vs. hasOne, and why belongsTo uses associate() while hasOne uses save().EDIT: I guess my point of confusion was that in the docs (http://laravel.com/docs/eloquent#inserting-related-models), they used:where I would have used:Is there an advantage to one way or the other?  Or is it just a question of what makes sense in the context?Please refer to the laravel docs on the one to many relationship between posts and comments http://laravel.com/docs/eloquent#relationships. (Where one post has many comments and a comment belongs to a post).The tables for posts and comments be as followsPosts Table

id | title | bodyComments Table

id | comment | post_idThe database table that contains a foreign key belongs to a record in the other table, therefore, in the comments model you must specify that comments belongs to posts. You are correct that the hasOne relationship only applies to one to one relationships.Here is a blog post with laravel 3 code which gives an explanation into how eloquent relationship methods work.http://laravel.io/topic/14/how-eloquent-relationship-methods-work

Passing cookies from browser to Guzzle 6 client

Thelonias

[Passing cookies from browser to Guzzle 6 client](https://stackoverflow.com/questions/31882080/passing-cookies-from-browser-to-guzzle-6-client)

I have a PHP webapp that makes requests to another PHP API. I use Guzzle to make the http requests, passing the $_COOKIES array to $options['cookies']. I do this because the API uses the same Laravel session as the frontend application. I recently upgraded to Guzzle 6 and I can no longer pass $_COOKIES to the $options['cookies'] (I get an error about needing to assign a CookieJar). My question is, how can I hand off whatever cookies I have present in the browser to my Guzzle 6 client instance so that they are included in the request to my API?

2015-08-07 16:01:02Z

I have a PHP webapp that makes requests to another PHP API. I use Guzzle to make the http requests, passing the $_COOKIES array to $options['cookies']. I do this because the API uses the same Laravel session as the frontend application. I recently upgraded to Guzzle 6 and I can no longer pass $_COOKIES to the $options['cookies'] (I get an error about needing to assign a CookieJar). My question is, how can I hand off whatever cookies I have present in the browser to my Guzzle 6 client instance so that they are included in the request to my API?Try something like:and here's how to get them out again:I think you can simplify this now with CookieJar::fromArray:

What is the real difference between Laravel's session() and request()->session()?

Oluwatobi Samuel Omisakin

[What is the real difference between Laravel's session() and request()->session()?](https://stackoverflow.com/questions/45059458/what-is-the-real-difference-between-laravels-session-and-request-session)

I am working on a Laravel(5.2) project that heavily relies on session, quite new though but I was just curious what difference global session() and Http request()->session() has apart from the fact that they have different means of accessing and writing into session?Here are the few information I have about this from laravel 5.4 doc,Unfortunately, this does not really make me understand the difference. I have as well googled and stackoverflowed perhaps I could find an answer to no avail. Example is laravel difference of session::flash and request->session->flash but I am not so comfortable with the answerWhat is the real difference they have in managing session data? I wouldn't mind a reference to a documentation where this is or even if I have to dig into laravel core.Thanks

2017-07-12 13:44:31Z

I am working on a Laravel(5.2) project that heavily relies on session, quite new though but I was just curious what difference global session() and Http request()->session() has apart from the fact that they have different means of accessing and writing into session?Here are the few information I have about this from laravel 5.4 doc,Unfortunately, this does not really make me understand the difference. I have as well googled and stackoverflowed perhaps I could find an answer to no avail. Example is laravel difference of session::flash and request->session->flash but I am not so comfortable with the answerWhat is the real difference they have in managing session data? I wouldn't mind a reference to a documentation where this is or even if I have to dig into laravel core.Thankssession() is a helper that gives you a faster access to request()->session()Note that request() is also a helper that gives you a faster access to the request object.There are no differences, it's just a shortcut.i think this would help you:

$request->session() and session() both are same thing.There are two primary ways of working with session data in Laravel: the global function in session() helper and via a $request instance.you can use it like thisUnfortunately the best answer has already been given by the Laravel note; and I can only attest to that for now cos I have noticed such situation once. I couldn't understand why global session('key') refuse to echo the value of $request->session()->put('key', 'value') within the same method. Hopefully I'd come across the situation again just for proof but the last response I'd want to give you is: "There are no differences, it's just a shortcut." Cos just like the docs mentioned, there's difference notable in practice

how to detach one instance from multiple in a laravel | Eloquent pivot table?

KernelCurry

[how to detach one instance from multiple in a laravel | Eloquent pivot table?](https://stackoverflow.com/questions/21149164/how-to-detach-one-instance-from-multiple-in-a-laravel-eloquent-pivot-table)

Pivot Table: 'bonus_circle' has the ability to have multiple items with the same circle_id and bonus_id. In other words There can be multiple of the same bonuses associated with the same circle.  Using $circle->bonuses()->detach($id) removes ALL of the instances.  I need it to only detach ONE instance. Does anyone know a work around for this?

2014-01-15 22:01:20Z

Pivot Table: 'bonus_circle' has the ability to have multiple items with the same circle_id and bonus_id. In other words There can be multiple of the same bonuses associated with the same circle.  Using $circle->bonuses()->detach($id) removes ALL of the instances.  I need it to only detach ONE instance. Does anyone know a work around for this?I searched for over a week for the answer to this. I can't use your code as an example because there's not quite enough there for me to go on, but I'll use my code to show you the answer I received from Kindari (thank you) in Laravel IRC chat.I have users, roles, and accounts. A user can have one role on one or more accounts. My role_user_account table has role_id, user_id, account_id. I needed to remove a user's role where account_id = x But I found that detach() was removing ALL account roles for the user.What didn't work:What does work:Raw Query works for now, but if anyone can answer this i would appreciate it.I had the same problem. Got around it using this.

@extends('layout') laravel. Blade Template System seems like Not working

Luillyfe

[@extends('layout') laravel. Blade Template System seems like Not working](https://stackoverflow.com/questions/21458885/extendslayout-laravel-blade-template-system-seems-like-not-working)

I tried to use the laravel's template system: blade but seems like not working when using the code below in the file users.blade.php:and browser,

2014-01-30 14:16:45Z

I tried to use the laravel's template system: blade but seems like not working when using the code below in the file users.blade.php:and browser,That should work if you have a template file at /app/views/layout.blade.php that containsThen in your /app/views/user.blade.php, the contentIf you call return View::make('user') you should have the compiled contentI hope that helps clarify things for you. If not, can you provide your template file locations and the relevant content?Just remove the extra space or anything before @extends('yourlayoutfile').It should be the first thing to be rendered in the file.I was facing the same problem and tried many things.Suddenly I found a single space at the starting of the file before @extends.Removed the space and is working fine.Thanks.Format:---Edit----If this didnt work then try :Copy all the content in the file and then delete the file.Create a new file and save it as filename.blade.phpOnly after saving the file paste the content into the page.

Save the changes and run it.This works.Thank you.Where is your layout?If its in app/views/layouts, then it should be(assuming the name is index.blade.php)ex: @extends('layouts.foo') equals a file in app/views/layouts/ called either foo.blade.php or foo.php. (depending if you use blade)I have the same problem. What is did is:

1. in routes.php that

AboutController is a controller file AboutController.php in app/controllers

index is a function inside that controller.2.Create AboutController.php in app/controllersYou can look at this reference: Defining A Layout On A ControllerBy default,Laravel has a layouts folder inside views folder, i.e. app/views/layouts and in this folder you keep your layout files, i.e. app/views/layouts/index.master.php and if you have something similar then you should use something like this:This will inherit/use the master.blade.php file (as layout) from layouts folder, here, layouts.master means layouts/master.blade.php.In your master.blade.php file you mast have thisSo, data/content from the view between @section('content') and @stop will be dumped in the place of @yield('content') of your layout.You can use any name for your layout file, if it's layouts/main.blade.php then you should uselet's say you have 'master.blade.php' and 'index.blade.php'. 

and both of files are in views->home directory. when you want to use @extends in 'index.blade.php' by calling 'master.blad.php' , you should write in index.blade.php file this statment:notSimply save your source using encoding UTF-8 without signature.

Laravel 5: allow user to edit post if he's the owner of the post or the owner of the forum category

Halnex

[Laravel 5: allow user to edit post if he's the owner of the post or the owner of the forum category](https://stackoverflow.com/questions/32951025/laravel-5-allow-user-to-edit-post-if-hes-the-owner-of-the-post-or-the-owner-of)

So far I was able to allow the user to edit his own posts but whenever I through the if he's owner of the subreddit/category condition, it stops working altogether.I have these 3 tableThis is the edit() method in PostsController.phpAnd this is the viewThis works fine, it only checks if the logged in user_id is the same as the posts's user_id and updating goes through.But if I added if(Auth::id() == $subreddit->user_id) it stops working. It displays the "Edit" link on the view on all the posts but clicking on any of them gives me the validation error You cannot do that even for posts that I own.So how can I check if the users is the owner of the article OR the owner of the category to display and allow EDIT?Updated method with $subreddit->user_idViewThis will allow me to edit my own posts but will still give me the validation error You cannot do that on posts in my own forum category/subreddit.This is the Gate policies that I've tried but it also didn't workPostsController.phpViewWith the above code, I am finally able to edit posts if 'update-post' is true but I cannot check if mod-update-post is also true, I keep receiving the validation error You cannot do thisdd($subreddit) inside edit() method shows an empty array. https://cryptbin.com/x6V6wX#26810f755a62f6c8837c0c0fe0371dcfEDIT: I think I've solved it. I used $post->subreddit->user->id instead of $subreddit->user_id because that was returning null. And now it all seems to work based on if posts belongs to user or user is forum owner.But the edit link on the view still shows whether or not I have access. I am unable to double check for update-post and mod-update-post simultaneously. and using @can('update-post', $post) only works once, I cannot double check that.

2015-10-05 14:26:57Z

So far I was able to allow the user to edit his own posts but whenever I through the if he's owner of the subreddit/category condition, it stops working altogether.I have these 3 tableThis is the edit() method in PostsController.phpAnd this is the viewThis works fine, it only checks if the logged in user_id is the same as the posts's user_id and updating goes through.But if I added if(Auth::id() == $subreddit->user_id) it stops working. It displays the "Edit" link on the view on all the posts but clicking on any of them gives me the validation error You cannot do that even for posts that I own.So how can I check if the users is the owner of the article OR the owner of the category to display and allow EDIT?Updated method with $subreddit->user_idViewThis will allow me to edit my own posts but will still give me the validation error You cannot do that on posts in my own forum category/subreddit.This is the Gate policies that I've tried but it also didn't workPostsController.phpViewWith the above code, I am finally able to edit posts if 'update-post' is true but I cannot check if mod-update-post is also true, I keep receiving the validation error You cannot do thisdd($subreddit) inside edit() method shows an empty array. https://cryptbin.com/x6V6wX#26810f755a62f6c8837c0c0fe0371dcfEDIT: I think I've solved it. I used $post->subreddit->user->id instead of $subreddit->user_id because that was returning null. And now it all seems to work based on if posts belongs to user or user is forum owner.But the edit link on the view still shows whether or not I have access. I am unable to double check for update-post and mod-update-post simultaneously. and using @can('update-post', $post) only works once, I cannot double check that.Use Laravel’s new authorization component.EDIT: I think you’re misunderstanding how authorization should be used. It should be used to check if the current user can perform an action (or not). Therefore, you don’t want to be defining multiple methods for different users types.Take editing a post for example. There’s the name of your authorization check: @can('edit', $post). You don’t need to define a different one for regular users, and another for moderators. Just add the logic to your edit post method:As you can see, I’m doing the different checks in the same method, so in your Blade template you can just do this:Hope this clears things up.Alternative technique (maybe a little bit simpler) is described here:https://laracasts.com/discuss/channels/laravel/dont-allow-user-to-change-others-postsSo the idea is to implement a subclass of Request, where you can implement validation rules, and where you can also implement an 'authorize' method.

How to call a trait method with alias

Jammer

[How to call a trait method with alias](https://stackoverflow.com/questions/34363431/how-to-call-a-trait-method-with-alias)

I'm trying to place a trait inside a class called Page. I also need to rename a trait function so that it doesn't clash with an existing class function. I thought I did all this successfully however I get an error that points to the wrong location?!Call to undefined function App\Pages\Models\myTraitDefaultScope()I've also tried: MyTrait\defaultScope($query) instead of trying to rename the conflicting function. But I then get the following error:Call to undefined function App\MyTrait\defaultScope()Below is the trait and class contained in separate files..I'm not all that awesome at this so please don't shoot if I've got something badly wrong :)  

2015-12-18 20:26:29Z

I'm trying to place a trait inside a class called Page. I also need to rename a trait function so that it doesn't clash with an existing class function. I thought I did all this successfully however I get an error that points to the wrong location?!Call to undefined function App\Pages\Models\myTraitDefaultScope()I've also tried: MyTrait\defaultScope($query) instead of trying to rename the conflicting function. But I then get the following error:Call to undefined function App\MyTrait\defaultScope()Below is the trait and class contained in separate files..I'm not all that awesome at this so please don't shoot if I've got something badly wrong :)  When you 'use' a trait in your class, the class inherits all the methods and properties of the trait, like if it was extending an abstract class or an interfaceSo, this method of MyTrait:will be inherited by your Page class As you have aliased this method as: myTraitDefaultScope, to call the method you should call it in the same way you would call every other method of the  Page class:As you're using trait. So it points to the current or parent class. Thus, calling any method should be like $this->method($params); syntax. 

Laravel 5.4 OAuth with Dingo internal requests

Squiggs.

[Laravel 5.4 OAuth with Dingo internal requests](https://stackoverflow.com/questions/47383367/laravel-5-4-oauth-with-dingo-internal-requests)

I am using Laravel 5.4 with Dingo API, and I'm trying to get Laravel's OAuth 2.0 (Passport) to work with Internal Dingo requests. Previously, I was using JWT, but now I wish to use OAuth. This is my previous dispatcher code which passes along the required token to perform the authentication on an internal request.Now that I'm using OAuth to authenticate, my JavaScript code manages to get authentication simply by passing a cookie using this method in the JavaScript, which works perfectly.Now I need to modify the getDispatcher() method to get the OAuth token on an "internal request" within Dingo. Does anyone have any tips on how to do this? In theory I could create a personal access token for every user but this seems like overkill just for an internal request. Any advice or approaches appreciated.  How can I get the OAuth token without going through the complete OAuth flow, or alternatively, how can I turn off authentication just for internal requests.Update based on answer below:'api.auth' on its own on the route (just Dingo) and the internal request works. auth:api (Passport) + api.auth and I get the method not allowed on internal requests this comes back as JSON. {"message":"405 Method Not Allowed"} now when trying to call an internal POST request. (It looks like a 301 redirect to the login page occurs when trying to POST to these routes, and in turn causes the API path to turn into a GET somehow thus throwing the 405 error).API requests via Postman work in the inverse capacity. Can't find a user when both active (['middleware' => ['auth:api','api.auth'])  when (auth:api just Passport) active it works fine. 

2017-11-20 00:01:43Z

I am using Laravel 5.4 with Dingo API, and I'm trying to get Laravel's OAuth 2.0 (Passport) to work with Internal Dingo requests. Previously, I was using JWT, but now I wish to use OAuth. This is my previous dispatcher code which passes along the required token to perform the authentication on an internal request.Now that I'm using OAuth to authenticate, my JavaScript code manages to get authentication simply by passing a cookie using this method in the JavaScript, which works perfectly.Now I need to modify the getDispatcher() method to get the OAuth token on an "internal request" within Dingo. Does anyone have any tips on how to do this? In theory I could create a personal access token for every user but this seems like overkill just for an internal request. Any advice or approaches appreciated.  How can I get the OAuth token without going through the complete OAuth flow, or alternatively, how can I turn off authentication just for internal requests.Update based on answer below:'api.auth' on its own on the route (just Dingo) and the internal request works. auth:api (Passport) + api.auth and I get the method not allowed on internal requests this comes back as JSON. {"message":"405 Method Not Allowed"} now when trying to call an internal POST request. (It looks like a 301 redirect to the login page occurs when trying to POST to these routes, and in turn causes the API path to turn into a GET somehow thus throwing the 405 error).API requests via Postman work in the inverse capacity. Can't find a user when both active (['middleware' => ['auth:api','api.auth'])  when (auth:api just Passport) active it works fine. If I read the question correctly, it looks like we're trying to use two authentication providers—Dingo's and Passport—at the same time. Correct me if I misunderstand, but it doesn't seem like we actually need to use both in this project. For most applications, we can perform authentication using Passport, and simply pass the result to Dingo. We achieve this by creating a custom authentication provider that bridges Dingo with the authentication performed by Passport: As we can see, the Dingo auth provider shown above just hooks into the Laravel auth system to forward the User when authenticated. The 'api' guard specified in the constructor should match the guard configured for Passport (we usually add an 'api' entry to the 'guards' array in config/auth.php):Then, we need to register the custom provider with Dingo in config/api.php:Now we can declare protected routes that use both the Passport auth middleware (auth:api) and the Dingo auth middleware (api.auth): We can create a middleware group in app/Http/Kernel.php that combines these if desired: By the time the application needs to call the internal API, the client should already be authenticated because typical Laravel applications handle authentication in the middleware stack. As you know, we can simply pass on the authenticated User to a Dingo endpoint if needed:...but this shouldn't be necessary with the auth provider shown above. Dingo will resolve the authenticated user from Passport's auth guard.Here's a sample project that combines these concepts.When we use the CreateFreshApiToken middleware, Laravel generates an encrypted JWT on-the-fly. We can create one of these tokens manually:We can see this isn't a standard OAuth access token—Passport only uses these for web requests. Alternatively, we can fetch this value from the cookie passed back from JavaScript: However, we shouldn't need this token if we integrate Dingo with Passport as described above.

Laravel Multi Insert issue with quotes in value

Awais Qarni

[Laravel Multi Insert issue with quotes in value](https://stackoverflow.com/questions/39634178/laravel-multi-insert-issue-with-quotes-in-value)

I need to insert a large set of records in to a database table. I am getting the data from a CSV file. I thought about using a multi-insert statement for good performance. So I did something similar to the following:But in doing so I always see the error:I have debugged it by printing the query and I observed that by doing so, Laravel doesn't take care of single quotes or double quotes in the description value, as it automatically does while usiung $model::save();. The printed query version breaks if the description value has single quotes ' or double quotes " in it. But if I do some thing likeIt runs successfully without generating any error. Can anybody let me know how to correct this problem?

2016-09-22 08:40:13Z

I need to insert a large set of records in to a database table. I am getting the data from a CSV file. I thought about using a multi-insert statement for good performance. So I did something similar to the following:But in doing so I always see the error:I have debugged it by printing the query and I observed that by doing so, Laravel doesn't take care of single quotes or double quotes in the description value, as it automatically does while usiung $model::save();. The printed query version breaks if the description value has single quotes ' or double quotes " in it. But if I do some thing likeIt runs successfully without generating any error. Can anybody let me know how to correct this problem?Its due to large set of data nothing wrong with quotes problem. When you are trying to insert all rows at once using multi-insert, the dataset becomes too heavy. Either you need to increase the max_allowed_packet or you need to do in chunks. 

You can use chunk for that.

suppose you want to insert 100 elements at a time. you can do something like that.Hope this will help :)How much records are your trying to bulk insert? 

Can you try with just two? 

Can you try to make severals bulk inserts (like 100 by 100).Usually, the error Mysql has gone away means that the database server killed the query because it was waiting for too much data (your query is too big).You can usually set a higher value to max_allowed_packet var in my.conf to allow you to send more data at once.

Laravel echo server not working in production server

z0mbieKale

[Laravel echo server not working in production server](https://stackoverflow.com/questions/51944819/laravel-echo-server-not-working-in-production-server)

I am having problem with socket.io as a broadcaster with laravel echo.What have I tried:I can see users connecting within the logs:My queue is running and is logging all the events properly.I can see redis my events and database notifications perfectly in the redis console.But no events are broadcasted and I am not seeing them in the laravel-echo-server console. Everything is working in my localhost, but not in the production and I losing my mind.Here's my laravel echo JS:On my user model I have defined this:And in my channels I have this:This is my echo server config where all the paths are correct. I tested the same file on my localhost and everything is working:My redis log shows this when published a database notificationThis is my notification

2018-08-21 08:42:06Z

I am having problem with socket.io as a broadcaster with laravel echo.What have I tried:I can see users connecting within the logs:My queue is running and is logging all the events properly.I can see redis my events and database notifications perfectly in the redis console.But no events are broadcasted and I am not seeing them in the laravel-echo-server console. Everything is working in my localhost, but not in the production and I losing my mind.Here's my laravel echo JS:On my user model I have defined this:And in my channels I have this:This is my echo server config where all the paths are correct. I tested the same file on my localhost and everything is working:My redis log shows this when published a database notificationThis is my notificationAs I see you use 'https' protocol in prodaction server, so you need to define 'sslCertPath' and 'sslKeyPath':From docsRunning with SSLIf you are seeing users joining the channels, then it is most likely set up correctly. You just need to broadcast a notification for your console.log(notification) call to work, since you are specifically calling the notification function on the user channel. See https://laravel.com/docs/5.6/broadcasting#notifications for more details.Broadcast with notification:Then when you are ready to broadcast your message, just notify the user:Edit:Also, make sure you have the Notifiable trait in your user model:

Laravel 5 Call to undefined method Illuminate\Database\Query\Builder::method()

Liam

[Laravel 5 Call to undefined method Illuminate\Database\Query\Builder::method()](https://stackoverflow.com/questions/30325169/laravel-5-call-to-undefined-method-illuminate-database-query-buildermethod)

I have projects which hasMany users, and users belongsTo a project.I want to count the total amount of users a project has so I need to link them.This way I'm getting a Call to undefined method Illuminate\Database\Query\Builder::user() error. What am I doing wrong?Controller:}Model user:Model project:HTML/Blade:

2015-05-19 12:06:14Z

I have projects which hasMany users, and users belongsTo a project.I want to count the total amount of users a project has so I need to link them.This way I'm getting a Call to undefined method Illuminate\Database\Query\Builder::user() error. What am I doing wrong?Controller:}Model user:Model project:HTML/Blade:You have to provide the method name that defines the relationship.I mean users not user

Upgrading Laravel 5.0 to Laravel 5.1 Commands to Jobs

user391986

[Upgrading Laravel 5.0 to Laravel 5.1 Commands to Jobs](https://stackoverflow.com/questions/30767884/upgrading-laravel-5-0-to-laravel-5-1-commands-to-jobs)

Laravel 5.1 is renaming Commands to Jobs and Events to Listeners.

http://laravel.com/docs/5.1/releases#laravel-5.1I was using Commands and Command Handlers in Laravel 5.0 like so.app\Commands\MyCommandapp\Handlers\Commands\MyCommandI don't see how I'm supposed to implement the handler in Laravel 5.1? 

2015-06-10 21:47:13Z

Laravel 5.1 is renaming Commands to Jobs and Events to Listeners.

http://laravel.com/docs/5.1/releases#laravel-5.1I was using Commands and Command Handlers in Laravel 5.0 like so.app\Commands\MyCommandapp\Handlers\Commands\MyCommandI don't see how I'm supposed to implement the handler in Laravel 5.1? From the 5.1 release notes:In case you want to upgrade, you just have to rename your folder and change the namespace (Laravel uses PSR-4 autoloader in version 5, so the folder structure corresponds to the namespace of your files). However if your project is quite large I do not recommend you that, since as the documentation states this is not required step for the upgrade your code will work just fine in 5.1. It is more like a cosmetic change.

Testing a Laravel 5 route with an exists rule via Codeception

John Dorean

[Testing a Laravel 5 route with an exists rule via Codeception](https://stackoverflow.com/questions/33085786/testing-a-laravel-5-route-with-an-exists-rule-via-codeception)

I'm writing tests for my Laravel application using the Codeception library. I'm using the Laravel5 module, and have it configured with cleanup which means that all tests will run inside a database transaction, so that my testing database doesn't get filled with test data.One of the endpoints I'm testing has the following validation rules set against it via Form Requests:The test that I've written to POST to this endpoint is as follows:This test always fails. After investigating, I can see that it fails because the request is failing validation due to the exists:users,id rule. If I change the Codeception settings to not execute tests inside a transaction, Laravel's validator can successfully see the existence of the two user's that I created at the start of my test and the test passes.So, my question is, is there any way that I can maintain the behaviour of wrapping each of my tests in a database transaction, and have Laravel's validator be able to see the records that I create in my tests?

2015-10-12 16:21:15Z

I'm writing tests for my Laravel application using the Codeception library. I'm using the Laravel5 module, and have it configured with cleanup which means that all tests will run inside a database transaction, so that my testing database doesn't get filled with test data.One of the endpoints I'm testing has the following validation rules set against it via Form Requests:The test that I've written to POST to this endpoint is as follows:This test always fails. After investigating, I can see that it fails because the request is failing validation due to the exists:users,id rule. If I change the Codeception settings to not execute tests inside a transaction, Laravel's validator can successfully see the existence of the two user's that I created at the start of my test and the test passes.So, my question is, is there any way that I can maintain the behaviour of wrapping each of my tests in a database transaction, and have Laravel's validator be able to see the records that I create in my tests?The problem is, that if the transaction is not commited, the original data in the database tables is not affected. So within the transaction, you create two users, but there is no commit statement that would persist that to your database. Hence the laravel validation rule 'exists' cannot find them ( that rule makes a database request to find particular user_id ). So in your case the users have to exist before testing. I would recommend to use Migrations instead. Resetting Database after each testCreate your tables with database migrations and seeds and roll them back after tests have finished. Quote:Why are you sending $users[0]->id in the request url and then 'user_id' => $users[1]->id in the parameters?Could this be your problem? Could this be the reason you are failing the validation?

