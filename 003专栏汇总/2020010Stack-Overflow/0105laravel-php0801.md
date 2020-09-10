2015-11-05 15:02:37Z

I am trying to write some tests for an application.  I have the server set up on MAMP going to dev.myappnamehere.com.When I run a test (based off of Laracasts Integrated) it fails because it is looking for the routeBut what it needs to go to is How can I change that so it does not default to looking for the localhost and instead goes to the correct path?I attempted to change this in the test but got nowhere and I was unable to located an answer through googling.From Laravel 5.4 the $baseUrl method doesn't seem to work anymoreAlso, trying to set the url dinamically with \Config:set('app.url', 'http://dev.myappnamehere') doesn't work either, as it seems that Laravel caches the root urlA way to set a custom root url is:So shortly after I asked I stumbled on the answer.  In there is a function called which sets the url it looks for.  Once I changed that it looked in the correct spot.  That file was part of the laracast testing that I loaded in.For Laravel 5,

In the tests directory there should be a file called TestCase.php. In that file is a property $baseUrl. Update the value to your desired url. For example change toChange the APP_URL in your .env file from localhost to your desired URL.Ex:

APP_URL=http://myproject.testMost likely you need to change a domain root in your existing request(). testThe below instead

Difference between get() and all() in laravel

Muhammad Raheel

[Difference between get() and all() in laravel](https://stackoverflow.com/questions/15362252/difference-between-get-and-all-in-laravel)

What is difference between these two in laravelAndAnd which one i should prefer.

2013-03-12 13:12:14Z

What is difference between these two in laravelAndAnd which one i should prefer.Taken from the laravel source:So all() calls get() and returns it's contents along with query(), and file() the $_FILES superglobal.Preference will obviously depend on circumstance. I personally choose to use Input::get($key, $default) as I usually know what I am after.From the Laravel Manual: http://laravel.com/docs/inputRetrieve a value from the input array:Note: The "get" method is used for all request types (GET, POST, PUT, and DELETE), not just GET requests.Retrieve all input from the input array:Retrieve all input including the $_FILES array:By default, null will be returned if the input item does not exist. However, you may pass a different default value as a second parameter to the method:

Laravel - Checking passwords before manually logging in

Silverfall05

[Laravel - Checking passwords before manually logging in](https://stackoverflow.com/questions/20783790/laravel-checking-passwords-before-manually-logging-in)

I'm getting problem with manually logging in users using Auth::loginUsingId

. Before I do that I need to check if password matches and there is my problem. Password comparision is always returning false;That's how I save password to DB:And that's how I try to compare these two passwordsAnd this is returning false, and I don't know where the problem is.EDIT:

In DB field varchar is 70 char long, hash is 60 characters longOk I've noticed: that every time Hash::make gives another string from my password. How it's even possible? I mean how then Auth::attempt works?

2013-12-26 11:11:15Z

I'm getting problem with manually logging in users using Auth::loginUsingId

. Before I do that I need to check if password matches and there is my problem. Password comparision is always returning false;That's how I save password to DB:And that's how I try to compare these two passwordsAnd this is returning false, and I don't know where the problem is.EDIT:

In DB field varchar is 70 char long, hash is 60 characters longOk I've noticed: that every time Hash::make gives another string from my password. How it's even possible? I mean how then Auth::attempt works?Try the following:

Laravel 5.4 - How to use multiple error messages for the same custom validation rule

Marc

[Laravel 5.4 - How to use multiple error messages for the same custom validation rule](https://stackoverflow.com/questions/44696091/laravel-5-4-how-to-use-multiple-error-messages-for-the-same-custom-validation)

In order to reuse code, I created my own validator rule in a file named ValidatorServiceProvider :And I use this rule like this :But, I want to set different error messages for each case, something like this : But I don't figure out how to achieve this without doing 2 differents rules ...

Of course it could work with multiple rules but it will also perform multiple SQL queries, and I really want to avoid that.

Also, keep in mind that in real case I could have more than 2 validations like theses in a single rule.Does anyone have an idea ?=====

EDIT 1 :Actually, I think that I want something that works in a similar way than the beetween or size rules.

They represent one single rule, but provide multiple error messages :Laravel checks if the value represents a numeric, a file, a string or an array ; and gets the right error message to use.

How do we achieve this kind of thing with custom rule ?

2017-06-22 09:57:07Z

In order to reuse code, I created my own validator rule in a file named ValidatorServiceProvider :And I use this rule like this :But, I want to set different error messages for each case, something like this : But I don't figure out how to achieve this without doing 2 differents rules ...

Of course it could work with multiple rules but it will also perform multiple SQL queries, and I really want to avoid that.

Also, keep in mind that in real case I could have more than 2 validations like theses in a single rule.Does anyone have an idea ?=====

EDIT 1 :Actually, I think that I want something that works in a similar way than the beetween or size rules.

They represent one single rule, but provide multiple error messages :Laravel checks if the value represents a numeric, a file, a string or an array ; and gets the right error message to use.

How do we achieve this kind of thing with custom rule ?Unfortunately Laravel doesn't currently provide a concrete way to add and call your validation rule directly from your attribute params array. But that's does not exclude a potential and friendly solution based on Trait and Request usage.Please find below my solution for example.First thing is to wait for the form to be processed to handle the form request ourselve with an abstract class. What you need to do is to get the current Validator instance and prevent it from doing further validations if there's any relevant error. Otherwise, you'll store the validator instance and call your custom user validation rule function that you'll create later :The next step is to create your Trait which will provide the way to validate your inputs thanks to the current validator instance and handle the correct error message you want to display :Finally, do not forget to extend your MyCustomFormRequest. For example, after your php artisan make:request CreateUserRequest, here's the easy way to do so :I hope that you'll find your way in what I suggest.Poor handling of custom validation rules is why I ditched laravel (well, it was one of many reasons, but it was the straw that broke the camel's back, so to speak).  But anyway, I have a three part answer for you: a reason why you don't want to do this in this specific case, a quick general overview of the mess you have to deal with, and then the answer to your question in case you still want to do it. Important security concernBest security practices for managing logins dictate that you should always return one generic error message for login problems.  The quintessential counter-example would be if you returned "That email is not registered with our system" for an email-not-found and "Wrong password" for a correct email with the wrong password.  In the case where you give separate validation messages, you give potential attackers additional information about how to more effectively direct their attacks.  As a result, all login-related issues should return a generic validation message, regardless of the underlying cause, something to the effect of "Invalid email/password combination".  The same is true for password recovery forms, which often say something like, "Password recovery instructions have been sent to that email, if it is present in our system".  Otherwise you give attackers (and others) a way to know what email addresses are registered with your system, and that can expose additional attack vectors.  So in this particular case, one validation message is what you want.The trouble with laravelThe issue you are running into is that laravel validators simply return true or false to denote whether or not the rule is met.  Error messages are handled separately.  You specifically cannot specify the validator error message from inside your validator logic.  I know.  It's ridiculous, and poorly planned.  All you can do is return true or false.  You don't have access to anything else to help you, so your pseudo code isn't going to do it.The (ugly) answerThe simplest way to create your own validation messages is to create your own validator.  That looks something like this (inside your controller):You would still have to create your validator on boot (your Valiator::Extend call.  Then you can specify the $rules normally by passing them in to your custom validator.  Finally, you can specify your messages.  Something like this, overall (inside your controller):(I don't remember if you have to specify each rule in your $messages array.  I don't think so).  Of course, even this isn't very awesome, because what you pass for $messages is simply an array of strings (and that is all it is allowed to be).  As a result, you still can't have this error message easily change according to user input.  This all happens before your validator runs too.  Your goal is to have the validation message change depending on the validation results, however laravel forces you to build the messages first.  As a result, to really do what you want to do, you have to adjust the actual flow of the system, which isn't very awesome.A solution would be to have a method in your controller that calculates whether or not your custom validation rule is met.  It would do this before you make your validator so that you can send an appropriate message to the validator you build.  Then, when you create the validation rule, you can also bind it to the results of your validation calculator, so long as you move your rule definition inside of your controller.  You just have to make sure and not accidentally call things out of order.  You also have to keep in mind that this requires moving your validation logic outside of the validators, which is fairly hacky.  Unfortunately, I'm 95% sure there really isn't any other way to do this.I've got some example code below.  It definitely has some draw backs: your rule is no longer global (it is defined in the controller), the validation logic moves out of the validator (which violates the principle of least astonishment), and you will have to come up with an in-object caching scheme (which isn't hard) to make sure you don't execute your query twice, since the validation logic is called twice.  To reiterate, it is definitely hacky, but I'm fairly certain that this is the only way to do what you want to do with laravel.  There might be better ways to organize this, but this should at least give you an idea of what you need to make happen.Also, it is worth a quick note that this implementation relies on $this support for closures, which (I believe) was added in PHP 5.4.  If you are on an old version of PHP you'll have to provide $this to the closure with use.Edit to rantWhat it really boils down to is that the laravel validation system is designed to be very granular.  Each validation rule is specifically only supposed to validate one thing.  As a result, the validation message for a given validator should never have to be changed, hence why $messages (when you build your own validator) only accepts plain strings.In general granularity is a good thing in application design, and something that proper implementation of SOLID principles strive for.  However, this particular implementation drives me crazy.  My general programming philosophy is that a good implementation should make the most common uses-cases very easy, and then get out of your way for the less-common use-cases.  In this cases the architecture of laravel makes the most common use-cases easy but the less common use-cases almost impossible.  I'm not okay with that trade off.  My general impression of Laravel was that it works great as long as you need to do things the laravel way, but if you have to step out of the box for any reason it is going to actively make your life more difficult.  In your case the best answer is to probably just step right back inside that box, i.e. make two validators even if it means making a redundant query.  The actual impact on your application performance likely will not matter at all, but the hit you will take to your long-term maintainability to get laravel to behave the way you want it will be quite large.Alternatively to the other proposals, I think you could also call Validator::replacer('yourRule', function()) in addition to Validator::extend('yourRule', function(...)) and keep track of what causes validation failures in the service provider class you're extending the validator from. This way, you are be able to completely replace the default error message with another one.According to docs, replacer() is meant for making placeholder replacements in the error message before it is being returned, so while this is not strictly that case, it is close enough. Of course, it's kind of an ugly(ish) workaround, but it will probably work (at least it seems to work for me, at a first glance).One thing to keep in mind though is that you'll probably have to keep track of these failure causes in an array if you want to avoid automatically returning same message for all fields that failed your custom validation rule.Where have you found the error messages for the size validation?I looked up the validation rules in the

Illuminate\Validation\ConcernsValidatesAttributes trait and all functions return a bool value (also the size validation).What you have found belongs to this part:In this case it's only for formatting the the output by setting a lowerRule value, that laravel handles in special cases, like the size validation:So as long as validation rules have to return a bool value there is no way to return more than one error message. Otherwise you have to rewrite some party of the validation rules.An approach for your problem with the validation you could use the exists validation:So you would need 2 exists validation rules. I would suggest to use the existing one from laravel to check if the email is set and a custom one to check if the account is validated.

Laravel passport installation error

Arafath

[Laravel passport installation error](https://stackoverflow.com/questions/41886595/laravel-passport-installation-error)

I've just downloaded the latest laravel 5.3 and I'm trying to install passport, but I'm getting the following composer error:Composer .json file 

http://pastebin.com/ne4RkL96

2017-01-27 03:33:20Z

I've just downloaded the latest laravel 5.3 and I'm trying to install passport, but I'm getting the following composer error:Composer .json file 

http://pastebin.com/ne4RkL96It happens, because after releasing Laravel 5.4, this package also had been updated to v 2.0 and requires Laravel 5.4. But you are using Laravel 5.3. Try to install earlier version:Also, you can learn about the versions of this package here:Laravel PassportIn line with Rashad's answer as it helped me out, you need a version of passport less than major version 2. This can be accomplished with several version strings ^v1, v1.x, >= 1 < 2 and several other combinations.I used this: php composer.phar require laravel/passport ^v1 and it worked awesomely.For Laravel 5.3. In your composer.json file put "laravel/passport": "~1.0" and  run "composer update" command.

Laravel 5 SwiftMailer's Send: how to get error code

user1506104

[Laravel 5 SwiftMailer's Send: how to get error code](https://stackoverflow.com/questions/45819536/laravel-5-swiftmailers-send-how-to-get-error-code)

Good day guys,I am sending email similar to this: Laravel 5: Sending Email. This is how I do it:Now, if the $ret_status is 'sent_failed', I want to know what happened. How do I do it? How can I see the message from the mail server?Here is my .env file:UPDATE:Looks like the approach above is Laravel 4. If you know how to get the error code using Laravel 5+, I can consider it as the correct answer.

2017-08-22 13:50:32Z

Good day guys,I am sending email similar to this: Laravel 5: Sending Email. This is how I do it:Now, if the $ret_status is 'sent_failed', I want to know what happened. How do I do it? How can I see the message from the mail server?Here is my .env file:UPDATE:Looks like the approach above is Laravel 4. If you know how to get the error code using Laravel 5+, I can consider it as the correct answer.You can use try catch for that, also you mistaken that use $email, $email_from, $email_name, $subject without passing into function scope.Added failure printing for email address to check email fail for which address.Checking Mail::failures() immediately after Mail::send() will return an array of failed email addresses you tried to send an email to.However, as far as I know you cannot get the exact error on failure using Mail facade. For that, you need to set the debug true on your .env and check on Laravel log.here is a working example:and the dd() result:

Laravel Eloquent - Using pivot table's id as a foreign key in another table

Tornike

[Laravel Eloquent - Using pivot table's id as a foreign key in another table](https://stackoverflow.com/questions/26238639/laravel-eloquent-using-pivot-tables-id-as-a-foreign-key-in-another-table)

I need to use pivot table's id as a foreign key in another table.for example i have following tables:so when user says I am going to that place, I have a new entry in place_user table and start to log the route he takes to get there. So for each place_user entry i have many entries in routes table.what is the correct way of doing this kind of relationship using eloquent? Should I create a model for the pivot table?I have tried to solve my problem by the following solution but no luck: https://github.com/laravel/framework/issues/2093#issuecomment-39154456 and posted a comment there https://github.com/laravel/framework/issues/2093#issuecomment-58187802any suggestions will be appreciated.

2014-10-07 14:39:19Z

I need to use pivot table's id as a foreign key in another table.for example i have following tables:so when user says I am going to that place, I have a new entry in place_user table and start to log the route he takes to get there. So for each place_user entry i have many entries in routes table.what is the correct way of doing this kind of relationship using eloquent? Should I create a model for the pivot table?I have tried to solve my problem by the following solution but no luck: https://github.com/laravel/framework/issues/2093#issuecomment-39154456 and posted a comment there https://github.com/laravel/framework/issues/2093#issuecomment-58187802any suggestions will be appreciated.After lots of searching and trying different solutions I came up with the following solution:User Model:Place Model:PlaceUser Model:I have Changed name route to footprint to avoid problems with route class included in laravel.Footprint Model:In the end I get structure where I can make different queries like:hope this helps

Language Translation popup is missing on DOM ready in browser: Laravel 5.2

Pankaj

[Language Translation popup is missing on DOM ready in browser: Laravel 5.2](https://stackoverflow.com/questions/36851759/language-translation-popup-is-missing-on-dom-ready-in-browser-laravel-5-2)

I have below code in my controller.Definition of method to fetch data is below.In English language file I have below code.In French language file I have below code.In View file I have below code.Normally when we visit a website that isn't the default language set in our browser we see a notification to translate the page on page load. See the screenshot below:However, this is not happening for my website. Although I can see the French language, the translate notification is not popping up so that I can translate it in English. Why?

2016-04-25 21:52:48Z

I have below code in my controller.Definition of method to fetch data is below.In English language file I have below code.In French language file I have below code.In View file I have below code.Normally when we visit a website that isn't the default language set in our browser we see a notification to translate the page on page load. See the screenshot below:However, this is not happening for my website. Although I can see the French language, the translate notification is not popping up so that I can translate it in English. Why?Chrome translation does not change your template variables or tells your website it should display another language. It uses google translate to translate it (in other words: it would not look up the english language file on your server to translate "F Country" to "E Country", but would translate "F Country" with google translate).To get the message, your site has to contain french words. Try replacing "F Country" in your language file with an actual french word (or maybe a whole sentence), or just put some french content on your test page.If you don't get the message, check your chrome settings ("Offer page translation when a webpage is not in ..."), or if you disabled it for your site.Then check if your site metadata contains <meta name=」google」value=」notranslate」>, it will disable the message for your site.Your trans(...) can be used to translate your site on your end: You can e.g. set the local language (session) variable by a button "I'm french" to let the user change it, by using the browsers language settings or by some other mean - but this has nothing to do with chrome translate and especially would work on other browsers too.Update since you asked what the language files are for: They are used when you parse your files (e.g. when you create the page the user requests); it makes your code (which is usually language indepentent) and content manageable: to add or edit a language, you don't have to change the coding-files and risk destroying something, you can just change app()->setLocale at one point.  But this parsing is done before the content gets to the user: so basically you either send that specific sentence in french or in english to the user, but not both. You can of course use app()->setLocale with a variable that is specific to the user (or "session"). In some function that the user can call (e.g. the action of some form) useThis will set a session-variable, and you can use this variable from now on to set the language you use to parse your files (on your end!) not with a fixed value, but the session-variable viaSo again: you still send your content in just one language to the user, but you or the user can choose which one it should be. Setting the active language always needs to be done before you parse a request (e.g. put it in a middlewareclass that runs (be)for every request). You can set the session-variable by the browser language settings, the url (e.g. depending on entering mysite.com or fr.mysite.com or mysite.fr you can just set the value of the language variable) and about 404 other possibilities.Google uses various parts of a site to determine the language and (probably) offer a translation hint for that.The following things you can try to make sure that they are correctly set and hope, Chrome is considering these:There is no 100% guide by Google and also no 100% certainty that Google Chrome detects the correct language. Laravel resource lang has nothing related to translate in browser. Request contains locale and laravel can respect that via resource-lang. As a result laravel will present text in clients browser local settings via the code you wrote.

More info here content negotiationWhy dont you have a dropdown select btn with defined languages ?

You can use this library : https://github.com/ruyadorno/dom-i18n to get it working

How do you find the underlying class behind a Laravel facade?

the_velour_fog

[How do you find the underlying class behind a Laravel facade?](https://stackoverflow.com/questions/29736616/how-do-you-find-the-underlying-class-behind-a-laravel-facade)

For example - this function uses a facade:It turns out the underlying class that actually supplies File::get is Illuminate\Filesystem\FilesystemI looked at the Laravel 4.2 documentation - thats the version Im using - and also the api reference but I couldn't find anything that would explain how to someone who didn't know in advance how to find the "real" class to a facade.  this tutorial on Laravel facades gives a method of doing it which involvesThis is a good demonstration of whats going on, but I wouldn't want to do this regularly.  My question is, knowing that the "facaded classes" you use in your app dont necessarily have a the same name or some convention to help you search the filesystem,  how can someone - who doesn't know in advance what the underlying class is - find the underlying class for a laravel facade? 

2015-04-19 22:26:48Z

For example - this function uses a facade:It turns out the underlying class that actually supplies File::get is Illuminate\Filesystem\FilesystemI looked at the Laravel 4.2 documentation - thats the version Im using - and also the api reference but I couldn't find anything that would explain how to someone who didn't know in advance how to find the "real" class to a facade.  this tutorial on Laravel facades gives a method of doing it which involvesThis is a good demonstration of whats going on, but I wouldn't want to do this regularly.  My question is, knowing that the "facaded classes" you use in your app dont necessarily have a the same name or some convention to help you search the filesystem,  how can someone - who doesn't know in advance what the underlying class is - find the underlying class for a laravel facade? This is a nice resource: https://laravel.com/docs/facades#facade-class-reference other than that make sure to install some kind of intellisense plugin for whatever editor you happen to be using. Most of them allow you to Ctrl+Right-Click on a class/method and go to the definition.It seems that you can use getFacadeRoot(). For example, to find out what's behind the Mail facade:

Single Laravel Route for multiple controllers

omer Farooq

[Single Laravel Route for multiple controllers](https://stackoverflow.com/questions/31368433/single-laravel-route-for-multiple-controllers)

I am creating a project where i have multiple user types, eg. superadmin, admin, managers etc. Once the user is authenticated, the system checks the user type and sends him to the respective controller. The middle ware for this is working fine.So when manager goes to http://example.com/dashboard he will see the managers dashboard while when admin goes to the same link he can see the admin dashboard. The below route groups work fine individually but when placed together only the last one works.I know we can rename the routes like superadmin/dashboard and admin/dashboard but i was wondering if there is any other way to achieve the clean route. Does anyone know of any anywork arounds ? BTW i am using LARAVEL 5.1Any help is appreciated :)

2015-07-12 13:46:49Z

I am creating a project where i have multiple user types, eg. superadmin, admin, managers etc. Once the user is authenticated, the system checks the user type and sends him to the respective controller. The middle ware for this is working fine.So when manager goes to http://example.com/dashboard he will see the managers dashboard while when admin goes to the same link he can see the admin dashboard. The below route groups work fine individually but when placed together only the last one works.I know we can rename the routes like superadmin/dashboard and admin/dashboard but i was wondering if there is any other way to achieve the clean route. Does anyone know of any anywork arounds ? BTW i am using LARAVEL 5.1Any help is appreciated :)The best solution I can think is to create one controller that manages all the pages for the users. example in routes.php file:your PagesController.php file:You can do this with a Before Middleware that overrides the route action's namespace, uses and controller attributes:This way you have to register each route only once without the final namespace prefix:The middleware will convert 'dashboard@index' to 'Admin\dashboard@index' or 'SuperAdmin\dashboard@index' depending on current user's role attribute as well as apply the role specific middleware.

How to automatically enable php extensions in Homestead on vagrant up

Wesley Smith

[How to automatically enable php extensions in Homestead on vagrant up](https://stackoverflow.com/questions/40641526/how-to-automatically-enable-php-extensions-in-homestead-on-vagrant-up)

Im using Laravel 5.3 in Homestead with Vagrant  1.8.7 running on VirtualBox. I have need to enable some php extensions.I know that I could ssh into the box and edit the php.ini to enable the extension but this seems like a very anti-vagrant way to do this.I want to tell Vagrant to provision the box with specific php extensions enabled so that I can simply call vagrant up --provision and the box will be ready to go (kinda the point of vagrant right?)So, How can we automatically enable php extensions in Homestead on vagrant up?

2016-11-16 20:17:32Z

Im using Laravel 5.3 in Homestead with Vagrant  1.8.7 running on VirtualBox. I have need to enable some php extensions.I know that I could ssh into the box and edit the php.ini to enable the extension but this seems like a very anti-vagrant way to do this.I want to tell Vagrant to provision the box with specific php extensions enabled so that I can simply call vagrant up --provision and the box will be ready to go (kinda the point of vagrant right?)So, How can we automatically enable php extensions in Homestead on vagrant up?After some tinkering, the below is what I came up with. I make no assurances that this is the right way to do it only that, in my case, it seems to be working:Find the after.sh that was generated when you installed homestead. For me, on Mac El Capitain, the file is created at ~/.homestead/after.sh, I imagine there is a .bat in a similar location on windows.Do not make the mistake of editing ~/Homestead/src/stubs/after.sh, thats the template file from the homestead installation, not your actual generated copy.Add the below lines to after.sh (this is my whole file, only the first 5 comment lines were in the default file):If you dont psychically know the exact name for the extension you need (I didnt) you can use sudo apt-cache search php7-* or similar to list the available onesNow, if you have homestead up, in the terminal, cd to your Homestead dir, for me cd ~/Homestead and then run vagrant destroyWhile inside /Homestead run vagrant up --provisionTo check that the extensions installed correctly, while inside /Homestead run these two commands:vagrant sshphp -r "print_r(get_loaded_extensions());"My output (33 and 61 were added):Like I stated at the beginning, I cant say this is the right way, but it's working for me so far.you should first log onto Homestead server using ssh ( probably you know this already - "vagrant ssh").then go to "/etc/php/7.0/fpm/" 

there is also for cli on this location  "/etc/php/7.0/cli/"

edit it with "sudo vi php.ini" ( esc and :wq to save changes ). then you should restart nginx: "sudo nginx -s reload"and after that, restart php-fpm: "sudo service php7.0-fpm restart" if you are not sure if it is php 5.x or 7.x on your homestead, use "find / -name php.ini" to find php.ini, you will probably get 2 or 3 results. In case there's still a need for this :=> https://guides.wp-bullet.com/install-apcu-object-cache-for-php7-for-wordpress-ubuntu-16-04/=> Run the 3 first commands :Or simply add to after.sh: 

Laravel download file from php output buffer VS. private storage folder | security

Roman

[Laravel download file from php output buffer VS. private storage folder | security](https://stackoverflow.com/questions/57923991/laravel-download-file-from-php-output-buffer-vs-private-storage-folder-securi)

A user can download query results in CSV format. The file is small (a few KB), but the contents are important.The first approach is to use php output buffer php://:The second approach is to create a new folder in laravels storage system and set it to private and download the file from there. You could even delete the file after the download:Here is the create/download code:This return will instantly delete the file after the download:What would be more secure? What is the better approach? I am currently leaning towards the second approach with the storage.

2019-09-13 12:51:25Z

A user can download query results in CSV format. The file is small (a few KB), but the contents are important.The first approach is to use php output buffer php://:The second approach is to create a new folder in laravels storage system and set it to private and download the file from there. You could even delete the file after the download:Here is the create/download code:This return will instantly delete the file after the download:What would be more secure? What is the better approach? I am currently leaning towards the second approach with the storage.Option 1Reasons:If you were dealing with files that are tens/hundreds of MB, I'd be thinking differently...Let's think about all options,Option 1 is good solution because you are not storing the file. It will be more secure than others. But timeout can be a problem at high traffic.Option 2 also good solution with delete. But you need to create files with unique names so you can use parallel downloads.Option 3 is like option 2 but if you are using laravel don't use it. (And think about 2 people are downloading at the same time)After this explanation, you need to work on option 1 to make it more secure if you are using one server. But if you are using microservices you need work on option 2. I can suggest one more thing to make it secure. Create a unique hashed URL. For example, use timestamp and hash it with laravel and check them before URL. So people can't download again from download history. https://example.com/download?hash={crypt(timestamp+1min)}If it is not downloaded in 1 min URL will be expired.I think the reply depends on the current architecture and the size of file to download(1)st approach is applicable when: Reasons:.

.

.(2)nd approach is applicable when: Reasons:Still, I consider expiration time instead or additionally to the downloading fact -- the download process can fail, or the file is lost (ensure 1+ hour availability) or vice versa the user will try to download it only after 1 year or never -- why should you keep this file for more than N days?I think first optionis more secure then other where you're not storing file anywhere.

Can you reload Boris in Laravel 4.1 without having to exit?

Dave

[Can you reload Boris in Laravel 4.1 without having to exit?](https://stackoverflow.com/questions/20590171/can-you-reload-boris-in-laravel-4-1-without-having-to-exit)

While using php artisan tinker, I changed some class files in my project. Is there a way to reload the REPL without having to type exit and php artisan tinker again?

2013-12-15 01:11:40Z

While using php artisan tinker, I changed some class files in my project. Is there a way to reload the REPL without having to type exit and php artisan tinker again?If the sequence CTRL+d, up, enter is too long for you, you could file a feature request with laravel, but last time I checked you couldn't Redefine Class Methods or Class , so I think isn't a trivial thing to do.If tinkering is all you do you could make it even shorter starting your tinker session withNow just the CTRL+d will reload the tinker session.And if that is too much to type you could define a Terminal/iTerm Profile with this command:

PHP $_COOKIE is not entirely populated

stevendesu

[PHP $_COOKIE is not entirely populated](https://stackoverflow.com/questions/32428076/php-cookie-is-not-entirely-populated)

I've spent a little while trying to trace the root cause of a particular Laravel bug since the original GitHub issue was closed without resolution.After some time of experimenting I discovered that the session was being regenerated because the laravel_session cookie was set to null. Tracing this back as far as possible, I found that in index.php -- before Laravel ever loads -- the value of $_COOKIE is corrupt... sometimesAbout 90% of the time when I make a call to my app, my cookies look like so:But then 10% of the time, it looks like so:Using a web proxy (Charles) to monitor network traffic, the issue is not on my end -- the full cookie string is being sent, but the server is only seeing a partial message (the laravel_session cookie gets cut off)Every time the issue occurs, it gets cut off at the exact same spot: 678 bytes after the start of the cookie string (1435 bytes into the raw HTTP request text). Strangely the request body is transmitted with no harm, and this comes after the cookie string in the raw HTTP request, so it's not a matter of the TCP connection failing out.I'm using PHP's built-in development server (php -S 0.0.0.0:80). I tried using Apache to see if it resolves the issue and while it seems like the cookie string always comes across correctly with Apache, I've got another error where PHP utterly crashes and burns upon hitting a file_put_contents call. I have the following code:Which is returning only Writing... (LOCK_EX: 2)<br />\nNone of "Done.", "WHAT", or "Failed?" are displayed.Looking as ps all to see if the server was hanging, I don't even see the Apache process. However I know Apache is running because if I stop Apache (sudo apachectl stop) I stop getting any response from the serverI'm really not sure what's going on (why Apache is failing or why the PHP built-in server is cutting off my $_COOKIE variable).As a final note, I've already checked the permissions on the file I'm attempting to write to:So it's not that.Per @Siguza's suggestion, I tried adding another cookie to see what would happen. Upon first inspection it looked like there was some very strange behavior going on when I ran dd( $request->cookies ) before decryption:SuccessFailureStrangely the new cookie I added (yetAnotherCookie) is entirely gone while the laravel session still gets truncated. Inspecting the HTTP request, I noticed that yetAnotherCookie was appended at the end, so truncating the whole string would reasonably remove it from the list:PHPSESSID=k8qvmt8ccbhcqepbn7mib8kra6; __unam=bc7c68-14f8d12a5ef-43097c02-217; __utma=152883115.857409601.1438038184.1440976773.1441571912.15; __utmb=152883115.4.9.1441572254693; __utmc=152883115; __utmz=152883115.1435960225.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); XSRF-TOKEN=eyJpdiI6ImVqcW1cL09cL3oyQ0ZIcFBiQTRmZXFKUT09IiwidmFsdWUiOiJEbzV0NHcraGNmd3BMb0hibG5uNm9UTnhvNlV4bVRCVWRHOWFBM3VrOG0wZ2Z2NmF5QnpuNFh6a1dYdmhcL2pmWUtIb2lsOGdBS29xV0hvNnFOQktxR2c9PSIsIm1hYyI6IjRjMjU4ZWYxMTJkZTQ1NTU2YWQ3M2EwZjAzZDQwNDI4YzNmOTJjYTVhZTUzZTg4MzFmNTUxZDFkMTljNDBjZjkifQ%3D%3D; laravel_session=eyJpdiI6IkRkcGNLRE9KK3hkOFRNdzFXQzQreWc9PSIsInZhbHVlIjoiQm1qN2lNa2pTQTE2ZTQxUzJxbExGYnhheFhjUkQwMEpybEQ3XC9cL0pDMzA1MXdEeHF3a09qbnRKTjdPMzRKdjdBeFFNQ1hkamw1THFQanlnUURoRjJndz09IiwibWFjIjoiYTkzNjdmYjYyYTMzODM2MmY2MjQyNzZhNDQ1YjY2NzQ3OTFiZjVjODIyZmYzYmE3YjhlNGM1ZjQ2NTk1MTczNyJ9; yetAnotherCookie=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789I cleared all of my cookies for the domain and tried again:SuccessFailureOnly yetAnotherCookie was truncated this time, not laravel_session. Looking at the HTTP request again, this cookie has made its way to the end of the list again despite being set first (I guess Chrome alphabetized the list of cookies?) only now the full list was shorter:__unam=bc7c68-14f8d12a5ef-43097c02-217; XSRF-TOKEN=eyJpdiI6ImV6aklvVVNwZHdCMThON1hQOW9rcmc9PSIsInZhbHVlIjoiWlY1aGdQamJ1Y2FQTGxTUDZTTmxPK2xLZm5xZG15enlVXC95RXhRMHNqbm9udkp5T3NnR3FBQ0dxRWEzYTdIVUFveHA1TTZkV2lTcGlcL1wvalQzQ09QbUE9PSIsIm1hYyI6IjYyMzM5MGM4MjYxNzYzNmI5NGYyZDFmMTU3M2M4NTA5NzBlYjZlMGZmMmViM2QzNjlhZjZmNTdlMmE4ZmRjMmUifQ%3D%3D; laravel_session=eyJpdiI6Illzd2xnalRXVzhKaVI0blRQUUtiNXc9PSIsInZhbHVlIjoiKzVaQVR0cHNqbDZEcGd5UG9POWFhbFdyYzhaTDNqb1FOQ2xmcEFYVUZUZTJkNUZSYzNRUlhCajJhNHBNK3VXd2gxYlwvUWtiTEE0bk5lVmp0d2lcL3pkQT09IiwibWFjIjoiNjA5MDU2ODViYTQ4YmM0YjlmYWVmOWY1NzliY2Y3YjdhYjMzYTA0MWU4ZjMwODg0N2E5NGI2N2U2ZDc3MTIwNSJ9; yetAnotherCookie=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789It cut off at 685 bytes this time instead of the 678 from earlier. Curiouser and curiouser.Here's another odd one. I tried hitting a slightly different endpoint. Instead of www.mywebsite.com/api/employees/1, I pinged www.mywebsite.com/api/employees/10This time one additional letter was removed from the cookie string. This prompted me to look at the entire raw HTTP request one more. Exactly 1435 bytes into the raw HTTP request is when the cookie string got cut off.So I performed one more experiment: I sent a huge custom header using the following javascript from the browserI also modified the return value slightly because Laravel's dd() function wraps the return value in a lot of HTML that would make it hard to interpret in the console. With the really long header in place, I got the following after a few attempts:This was actually 1460 bytes into the raw request... I'm not sure how to interpret the fact that it behaved differently, but this is suggesting some weird 1450-ish byte limit before PHP's built-in server craps out on the HTTP request.Attempted to upgrade PHP to 5.6First apt-get failed me. apt-get install --only-upgrade php5 just installed a slightly newer 5.5.9Then I downloaded the source from php.net and attempted to build from source. Per the INSTALL instructions, you should run ./configure before running make and make install, so I tried it out. After a short while I got the following:I tried updating this with apt-get install libxml2 and got the following:Since ./configure failed me and I can't upgrade libxml2, I tried just installing:It's possible I'm just incompetent as a server admin, but I don't know how to install PHP 5.6 without a helpful MSI file

2015-09-06 20:39:28Z

I've spent a little while trying to trace the root cause of a particular Laravel bug since the original GitHub issue was closed without resolution.After some time of experimenting I discovered that the session was being regenerated because the laravel_session cookie was set to null. Tracing this back as far as possible, I found that in index.php -- before Laravel ever loads -- the value of $_COOKIE is corrupt... sometimesAbout 90% of the time when I make a call to my app, my cookies look like so:But then 10% of the time, it looks like so:Using a web proxy (Charles) to monitor network traffic, the issue is not on my end -- the full cookie string is being sent, but the server is only seeing a partial message (the laravel_session cookie gets cut off)Every time the issue occurs, it gets cut off at the exact same spot: 678 bytes after the start of the cookie string (1435 bytes into the raw HTTP request text). Strangely the request body is transmitted with no harm, and this comes after the cookie string in the raw HTTP request, so it's not a matter of the TCP connection failing out.I'm using PHP's built-in development server (php -S 0.0.0.0:80). I tried using Apache to see if it resolves the issue and while it seems like the cookie string always comes across correctly with Apache, I've got another error where PHP utterly crashes and burns upon hitting a file_put_contents call. I have the following code:Which is returning only Writing... (LOCK_EX: 2)<br />\nNone of "Done.", "WHAT", or "Failed?" are displayed.Looking as ps all to see if the server was hanging, I don't even see the Apache process. However I know Apache is running because if I stop Apache (sudo apachectl stop) I stop getting any response from the serverI'm really not sure what's going on (why Apache is failing or why the PHP built-in server is cutting off my $_COOKIE variable).As a final note, I've already checked the permissions on the file I'm attempting to write to:So it's not that.Per @Siguza's suggestion, I tried adding another cookie to see what would happen. Upon first inspection it looked like there was some very strange behavior going on when I ran dd( $request->cookies ) before decryption:SuccessFailureStrangely the new cookie I added (yetAnotherCookie) is entirely gone while the laravel session still gets truncated. Inspecting the HTTP request, I noticed that yetAnotherCookie was appended at the end, so truncating the whole string would reasonably remove it from the list:PHPSESSID=k8qvmt8ccbhcqepbn7mib8kra6; __unam=bc7c68-14f8d12a5ef-43097c02-217; __utma=152883115.857409601.1438038184.1440976773.1441571912.15; __utmb=152883115.4.9.1441572254693; __utmc=152883115; __utmz=152883115.1435960225.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); XSRF-TOKEN=eyJpdiI6ImVqcW1cL09cL3oyQ0ZIcFBiQTRmZXFKUT09IiwidmFsdWUiOiJEbzV0NHcraGNmd3BMb0hibG5uNm9UTnhvNlV4bVRCVWRHOWFBM3VrOG0wZ2Z2NmF5QnpuNFh6a1dYdmhcL2pmWUtIb2lsOGdBS29xV0hvNnFOQktxR2c9PSIsIm1hYyI6IjRjMjU4ZWYxMTJkZTQ1NTU2YWQ3M2EwZjAzZDQwNDI4YzNmOTJjYTVhZTUzZTg4MzFmNTUxZDFkMTljNDBjZjkifQ%3D%3D; laravel_session=eyJpdiI6IkRkcGNLRE9KK3hkOFRNdzFXQzQreWc9PSIsInZhbHVlIjoiQm1qN2lNa2pTQTE2ZTQxUzJxbExGYnhheFhjUkQwMEpybEQ3XC9cL0pDMzA1MXdEeHF3a09qbnRKTjdPMzRKdjdBeFFNQ1hkamw1THFQanlnUURoRjJndz09IiwibWFjIjoiYTkzNjdmYjYyYTMzODM2MmY2MjQyNzZhNDQ1YjY2NzQ3OTFiZjVjODIyZmYzYmE3YjhlNGM1ZjQ2NTk1MTczNyJ9; yetAnotherCookie=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789I cleared all of my cookies for the domain and tried again:SuccessFailureOnly yetAnotherCookie was truncated this time, not laravel_session. Looking at the HTTP request again, this cookie has made its way to the end of the list again despite being set first (I guess Chrome alphabetized the list of cookies?) only now the full list was shorter:__unam=bc7c68-14f8d12a5ef-43097c02-217; XSRF-TOKEN=eyJpdiI6ImV6aklvVVNwZHdCMThON1hQOW9rcmc9PSIsInZhbHVlIjoiWlY1aGdQamJ1Y2FQTGxTUDZTTmxPK2xLZm5xZG15enlVXC95RXhRMHNqbm9udkp5T3NnR3FBQ0dxRWEzYTdIVUFveHA1TTZkV2lTcGlcL1wvalQzQ09QbUE9PSIsIm1hYyI6IjYyMzM5MGM4MjYxNzYzNmI5NGYyZDFmMTU3M2M4NTA5NzBlYjZlMGZmMmViM2QzNjlhZjZmNTdlMmE4ZmRjMmUifQ%3D%3D; laravel_session=eyJpdiI6Illzd2xnalRXVzhKaVI0blRQUUtiNXc9PSIsInZhbHVlIjoiKzVaQVR0cHNqbDZEcGd5UG9POWFhbFdyYzhaTDNqb1FOQ2xmcEFYVUZUZTJkNUZSYzNRUlhCajJhNHBNK3VXd2gxYlwvUWtiTEE0bk5lVmp0d2lcL3pkQT09IiwibWFjIjoiNjA5MDU2ODViYTQ4YmM0YjlmYWVmOWY1NzliY2Y3YjdhYjMzYTA0MWU4ZjMwODg0N2E5NGI2N2U2ZDc3MTIwNSJ9; yetAnotherCookie=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789It cut off at 685 bytes this time instead of the 678 from earlier. Curiouser and curiouser.Here's another odd one. I tried hitting a slightly different endpoint. Instead of www.mywebsite.com/api/employees/1, I pinged www.mywebsite.com/api/employees/10This time one additional letter was removed from the cookie string. This prompted me to look at the entire raw HTTP request one more. Exactly 1435 bytes into the raw HTTP request is when the cookie string got cut off.So I performed one more experiment: I sent a huge custom header using the following javascript from the browserI also modified the return value slightly because Laravel's dd() function wraps the return value in a lot of HTML that would make it hard to interpret in the console. With the really long header in place, I got the following after a few attempts:This was actually 1460 bytes into the raw request... I'm not sure how to interpret the fact that it behaved differently, but this is suggesting some weird 1450-ish byte limit before PHP's built-in server craps out on the HTTP request.Attempted to upgrade PHP to 5.6First apt-get failed me. apt-get install --only-upgrade php5 just installed a slightly newer 5.5.9Then I downloaded the source from php.net and attempted to build from source. Per the INSTALL instructions, you should run ./configure before running make and make install, so I tried it out. After a short while I got the following:I tried updating this with apt-get install libxml2 and got the following:Since ./configure failed me and I can't upgrade libxml2, I tried just installing:It's possible I'm just incompetent as a server admin, but I don't know how to install PHP 5.6 without a helpful MSI fileCongrats, you found a PHP bug; I've just reported it.You can't do anything about it now, except waiting for a fix.As I noted inside the bug report, the cause really is that the headers are so large, thus the browser splitting it up into multiple TCP packets… and the HTTP parser in sapi/cli/php_http_parser.c currently does not seem to back up the buffer with the header value in case it needs to wait for the next packet and merging it with the next packet later. Hence, it ends up to be truncated.As code tells sometimes more than text: a simple reproduce case: http://git.php.net/?p=php-src.git;a=commitdiff;h=37d814b84cff3678a2e1d56ea9d3ba3c35082e13

Model relationships in Laravel 5.3

Detryer

[Model relationships in Laravel 5.3](https://stackoverflow.com/questions/42020559/model-relationships-in-laravel-5-3)

I've got MySQL tables for site cart:Class Cart, which contains goods:Class Good, which can be Detail or Appliance and relative to cart by cart_id:Detail class:And i need to get all appliances and details in cart. How can i do it by using ORM?

2017-02-03 09:10:58Z

I've got MySQL tables for site cart:Class Cart, which contains goods:Class Good, which can be Detail or Appliance and relative to cart by cart_id:Detail class:And i need to get all appliances and details in cart. How can i do it by using ORM?Use nested eager loading. Assuming that relationship method names are cartGoods, details and appliances, that details are details of a cart and that you've defined the relationships right:Try this:Method 1: If you have a $cart model instanceMethod 2: If you need all appliances and details from cart by card IDI've done this, problem was in model name, i was writing it to DB like Detail and Appliance, but i was need to useIn AppServiceProvider class.

How to test POST routes in Laravel

Martyn

[How to test POST routes in Laravel](https://stackoverflow.com/questions/28790348/how-to-test-post-routes-in-laravel)

I'm doing the following to test a POST call to Laravel. I'm expecting that POST to questions, in accordance with my routes, will be dispatches as the store action method. This works in the browser.My test:However, I tells me that the redirect doesn't match. Also, I can see that it isn't going to the store action method at all. I want to know what action method it is going to, and why it isn't going to the store method (if I look at route:list I can see there is a POST questions/ route that should go to questions.store; this also works in the browser, but not in my tests). Also, am I writing the call correctly for this resource? I added the token here as it was throwing an exception as it should, in some tests I will let the token check pass.

2015-03-01 05:12:24Z

I'm doing the following to test a POST call to Laravel. I'm expecting that POST to questions, in accordance with my routes, will be dispatches as the store action method. This works in the browser.My test:However, I tells me that the redirect doesn't match. Also, I can see that it isn't going to the store action method at all. I want to know what action method it is going to, and why it isn't going to the store method (if I look at route:list I can see there is a POST questions/ route that should go to questions.store; this also works in the browser, but not in my tests). Also, am I writing the call correctly for this resource? I added the token here as it was throwing an exception as it should, in some tests I will let the token check pass.You could try this:The most recommended way to test your routes is to check for 200 response. This is very helpful when you have multiple tests, like you are checking all of your post routes at once.To do so, just use:I use in order to assert validation works. But to use this, you must start from the page that is going to send the post request. Like this:Then if you want to test that the errors also being displayed correctly back. Run again above test with some changes as per below:My guess is that if you dont start with the page to show the error, (the create / update page where you put the form), chain of session during the process will miss some important keys.I was getting a TokenMismatchException and this fixed it, maybe it helps you tooLaravel Unit cases without middleware

Extending core Laravel 5 functionality

Marcin Nabiałek

[Extending core Laravel 5 functionality](https://stackoverflow.com/questions/29084661/extending-core-laravel-5-functionality)

The question is quite simple - is it possible to extend Laravel 5 functionality in any smart way or you need to copy sometimes a lot of code/classes just to achieve what you want.Because it's quite broad, I'll give you 2 examples.1) I would like to change urls for edit and create for \Illuminate\Routing\ResourceRegistrar. At the moment the only way I found to achieve that is: extending main Illuminate Application to pass own RoutingServiceProvider, then extend Router, then extend Illuminate\Routing\ResourceRegistrar and finally in bootstrap/app.php use our extended Application class. Quite a lot of modifications just to change 2 lines. Many methods are in fact duplicated just to pass our custom class which code is exact the same except it uses class from other namespace2) Other similar change - set custom paths for cached config - you need to again extend  Application to override method getCachedConfigPath and then make a change in bootstrap/app.phpSo the question is - is it the way that some modifications need to be done or maybe the same (for example those 2 above) could be achieved somehow easier not extending core Application class and making so many changes?

2015-03-16 18:48:21Z

The question is quite simple - is it possible to extend Laravel 5 functionality in any smart way or you need to copy sometimes a lot of code/classes just to achieve what you want.Because it's quite broad, I'll give you 2 examples.1) I would like to change urls for edit and create for \Illuminate\Routing\ResourceRegistrar. At the moment the only way I found to achieve that is: extending main Illuminate Application to pass own RoutingServiceProvider, then extend Router, then extend Illuminate\Routing\ResourceRegistrar and finally in bootstrap/app.php use our extended Application class. Quite a lot of modifications just to change 2 lines. Many methods are in fact duplicated just to pass our custom class which code is exact the same except it uses class from other namespace2) Other similar change - set custom paths for cached config - you need to again extend  Application to override method getCachedConfigPath and then make a change in bootstrap/app.phpSo the question is - is it the way that some modifications need to be done or maybe the same (for example those 2 above) could be achieved somehow easier not extending core Application class and making so many changes?You should be able to overwrite the core ResourceRegistrar by binding your own implementation to the service container:Let MyResourceRegistrar extend the core ResourceRegistrar and you should be able to overwrite the edit and create methods:

vagrant homestead can't access host(laravel 5.2)

YaSh Chaudhary

[vagrant homestead can't access host(laravel 5.2)](https://stackoverflow.com/questions/38726056/vagrant-homestead-cant-access-hostlaravel-5-2)

When I goto my host ao.dev:8000 or ao.dev, "this site can't be reached,ao.dev refused to connect" is displayed.My yaml file:also i've my view file:i've checked:I've run vagrant up command by going to Homestead directory .Also see: https://stackoverflow.com/questions/38801375/vagrant-up-not-forwarding-all-portshomesteadlaravel-5-2windows-10

2016-08-02 16:37:14Z

When I goto my host ao.dev:8000 or ao.dev, "this site can't be reached,ao.dev refused to connect" is displayed.My yaml file:also i've my view file:i've checked:I've run vagrant up command by going to Homestead directory .Also see: https://stackoverflow.com/questions/38801375/vagrant-up-not-forwarding-all-portshomesteadlaravel-5-2windows-10Actually I was using WAMP before installing homestead.

So I uninstalled both i.e. wamp and homestead setup including vagrant and virtual box.

Then I installed homestead setup again and it worked.

I dont know the logic behind but maybe wamp and homestead were conflicting.

It worked so I posted the answer.What I needed to do to get my local Laravel up and running:Additionally:Here is an example Homestead.yaml file from one of my own projects:Notice how my paths are double-quoted (to: "/home/vagrant/example")? In your code above, these paths are not double-quoted as they should be.I also recommend after you fix your configuration that you completely destroy and re-create your VM by running:vagrant destroy -f && vagrant upIn your Laravel project root directory.Your Vagrant VM machine is up but you can't reach to the machine.Can you paste your hosts file on your host machine?Can you paste the output of a "nmap 192.168.10.10" from your host machine?Can you paste "ls /etc/nginx/sites-enabled/ -la" on your Vagrant VM machine?I had the same problem, I installed and run fiddler and it was enough to solve it.

delete confirmation in laravel

yudijohn

[delete confirmation in laravel](https://stackoverflow.com/questions/32984859/delete-confirmation-in-laravel)

I have the following code:How to add a confirmation on delete each data?

2015-10-07 06:04:46Z

I have the following code:How to add a confirmation on delete each data?I prefer a more easier way, just add onclick="return confirm('Are you sure?')", as bellow:If this is your link:Use this Javascript:Note: the <a> needs the delete in class.

This solution uses Unobtrusive JavaScript and should work with IE 9 or newer.With brexis/laravel-data-method package, you can specify appropriate HTTP method and a confirmation text.This is helpful if you have this for example into your routes file:If this is your link:Route:Use this Javascript:Note: the <a> needs the delete in class.

This solution uses Unobtrusive JavaScript and should work with IE 9 or newer.index.blade.phpI used pure PHP Form, the method DELETE has to be passed as hidden on the submit page action, so I catch it trough javascript and I get the confirmation alert.

How to change / Custom password field name for Laravel 4 and Laravel 5 user authentication [duplicate]

Marcin Nabiałek

[How to change / Custom password field name for Laravel 4 and Laravel 5 user authentication [duplicate]](https://stackoverflow.com/questions/26073309/how-to-change-custom-password-field-name-for-laravel-4-and-laravel-5-user-auth)

I would like to change password field in database when using Laravel authentication. I want my column in users table has name passwd and not password. I tried to run something like this:but it doesn't work. I also tried to add in User model the following function:but it also changes nothing. User is still not being authenticated. Is it possible in Laravel to change password field name in database ?

2014-09-27 09:41:23Z

I would like to change password field in database when using Laravel authentication. I want my column in users table has name passwd and not password. I tried to run something like this:but it doesn't work. I also tried to add in User model the following function:but it also changes nothing. User is still not being authenticated. Is it possible in Laravel to change password field name in database ?You can change easy all other fields in database and use them for authentication. The only problem is with password field.In fact password field is in some way hard coded in Laravel (but not the way many think) so you cannot just pass array as you passed in your question.By default if you pass array to attempt (and probably other Auth functions like validate or once) if you do it this way:default Eloquent driver will run the following query:After getting this data from database it will compare password you gave with password property for User object that was created.But if you simply use:the following query will be run:and no user will be found in database (in passwd you store hashed password). This is because Eloquent removes from query password but use any other data to run query. Also if you try here to use 'passwd' => Hash:make($data['password']) although user will be found, comparing password won't work.Solution is quite easy. You need to run Auth::attempt like this:As you see you still pass password as key (although this column doesn't exits in users table)  because only this way Eloquent driver won't use it for building query.Now in User model (app/models/User.php) file you need to add the following function:As you see you use here the column that really exists in database: passwd. Using it this way you can have column with password named anything you want and you can still use default Eloquent driver for it.I've created very simple test for it.You just need to replace your app/routes.php file with the following:This solution was tested in Larave 4.2.9 (everything as above) and also in Laravel 5. In Laravel5 everything works the same but you need of course edit files in different paths:

Using Laravel 5 with AngularJS blade tag conflict

imperium2335

[Using Laravel 5 with AngularJS blade tag conflict](https://stackoverflow.com/questions/28548694/using-laravel-5-with-angularjs-blade-tag-conflict)

I am trying to setup Angular with Laravel 5.I have tried doing in appServiceProvider:With:But I'm getting:

2015-02-16 19:14:01Z

I am trying to setup Angular with Laravel 5.I have tried doing in appServiceProvider:With:But I'm getting:When doing changes that have to do with Blade (Extending Blade, changing the tags etc) always make sure to delete the cached views.They're located in storage/framework/views.Just delete all files (except the .gitignore)If you want something a bit more practical you can create a command to do that. Like this oneThe easiest way to do this is to simply use @ in front of your Angular code:sourceWhile adding @ in front of the braces does still work, Laravel has also included another handy blade utility that lets you mark an entire block as-is:Particularly helpful if you're not doing much with the Blade template renderingElse you modify angular syntax...

how to check if a user email already exist

ballerz

[how to check if a user email already exist](https://stackoverflow.com/questions/17799148/how-to-check-if-a-user-email-already-exist)

In laravel, when a new user is registering to my site and the email they use already exist in the database. how can tell the user that the email already exist ?. I am new to laravel framework. A sample code would be nice too.

2013-07-22 23:29:10Z

In laravel, when a new user is registering to my site and the email they use already exist in the database. how can tell the user that the email already exist ?. I am new to laravel framework. A sample code would be nice too.The validation feature built into Laravel lets you check lots of things, including if a value already exists in the database. Here's an overly simplified version of what you need. In reality you'd probably want to redirect back to the view with the form and show some error messages.);Laravel has built-in human readable error messages for all its validation. You can get an array of the these messages via: $validator->messages();You can learn more about validation and what all you can do with it in the Laravel Docs.Basic Usage Of Unique RuleSpecifying A Custom Column NameForcing A Unique Rule To Ignore A Given IDAdding Additional Where ClausesYou may also specify more conditions that will be added as "where" clauses to the query:The above is from the documentation of LaravelYou could add:You can add more rules to the $rules like:It will automatically produce the error messagesand add:to the model User.phpThen in the function you're using to register, you could add:The great resource is only Laravel Documentation @ 

enter link description hereI also did like below when integrating user management system

Syntax error or access violation: 1115 Unknown character set: utf8mb4

Alexu

[Syntax error or access violation: 1115 Unknown character set: utf8mb4](https://stackoverflow.com/questions/41835923/syntax-error-or-access-violation-1115-unknown-character-set-utf8mb4)

I am migrating my classes but I am getting this error in laravel.How do I resolve this error?

2017-01-24 18:05:55Z

I am migrating my classes but I am getting this error in laravel.How do I resolve this error?Go to config/database.php and replace these two lines with these'charset' => 'utf8',

            'collation' => 'utf8_unicode_ci',Go to config/database.php and replace these lines. That's it

Adding a new config file in Laravel 5 not working

geoffs3310

[Adding a new config file in Laravel 5 not working](https://stackoverflow.com/questions/28794861/adding-a-new-config-file-in-laravel-5-not-working)

I want a new config file in my Laravel 5 app to store all my constants in. After looking around the net I found the recommended solution seems to be to create a new config file that returns an array of key value pairs and then use that. So I created the following file:Then in one of my controllers I try to access one of these values like so:I just get the following error:Do I have to do something else to get it to work?

2015-03-01 14:47:46Z

I want a new config file in my Laravel 5 app to store all my constants in. After looking around the net I found the recommended solution seems to be to create a new config file that returns an array of key value pairs and then use that. So I created the following file:Then in one of my controllers I try to access one of these values like so:I just get the following error:Do I have to do something else to get it to work?In Laravel 5, to avoid this kind of headache, you can use the config helper function to get a config item, like this : config('constants.ADMIN_EMAIL')Nice and easy ;)The Config class is an alias in the global namespace. To reference it from inside the controller (which is in the App\Http\Controllers namespace) you have to prepend it with a backslash:Or add a use statement above the controller class:As an alternative you might also want to use dependency injection to access the config. That would look somewhat like this:As @Bernig suggests you can also simply use the new config() helper function:I met the same issue today, and I find an elegant solution: 

add the config/your_new_config.php to ConfigServiceProvider, like this:The reason is well explained in the function's comments

file_put_contents , failed to open stream: No such file or directory Laravel [duplicate]

Wahid Nahiyan

[file_put_contents , failed to open stream: No such file or directory Laravel [duplicate]](https://stackoverflow.com/questions/32126122/file-put-contents-failed-to-open-stream-no-such-file-or-directory-laravel)

I just want to run my client's project in to my local and having this problem.ErrorException in compiled.php line 6301: file_put_contents(C:\xampp\htdocs\tiger\storage/framework/views/111182673e168569a2371e23629d9c08): failed to open stream: No such file or directoryit is something like permission issue .. and i am windows user don't know how to figure it ... experts can u help me ? Thanks in Advance.

2015-08-20 18:52:36Z

I just want to run my client's project in to my local and having this problem.ErrorException in compiled.php line 6301: file_put_contents(C:\xampp\htdocs\tiger\storage/framework/views/111182673e168569a2371e23629d9c08): failed to open stream: No such file or directoryit is something like permission issue .. and i am windows user don't know how to figure it ... experts can u help me ? Thanks in Advance.In case anyone here is using Homestead like me, you can run into the same issue using PHPUnit. When you run php artisan config:cache, Laravel hardcodes some paths in the cache. If you run it on your Homestead VM, it uses those paths. If you run it from your workstation, it uses those paths. You should make your cache from the Homestead VM and then execute your tests from there as well to avoid cache problems.You can tell when the cache needs to be cleared by looking at the file path that PHPUnit tries to use. If it's not a valid path on the machine you're running the command from, you need to rebuild your cache.I had the same exact problem, try thisThis solves the problemThis code clear the cache and delete cache files.Inside the folder C:\xampp\htdocs\tiger\storage/framework/views

make a file named 111182673e168569a2371e23629d9c08now refresh your browser 

this should solve your problem in window 

for linux users you should provide permission to for this file

Laravel s3 multiple buckets

Leandro Ferreira

[Laravel s3 multiple buckets](https://stackoverflow.com/questions/35225836/laravel-s3-multiple-buckets)

My Laravel application needs to manipulate files present in multiple buckets simultaneously into a single session. So, I couldn't find a way to change several times the current bucket, since my .env file is like this:I found somewhere that I could do this:but It works only once. What I need is something like:Where /bucket-name/ could be any bucket that I already create. What can I do? Thanks a lot!

2016-02-05 13:49:31Z

My Laravel application needs to manipulate files present in multiple buckets simultaneously into a single session. So, I couldn't find a way to change several times the current bucket, since my .env file is like this:I found somewhere that I could do this:but It works only once. What I need is something like:Where /bucket-name/ could be any bucket that I already create. What can I do? Thanks a lot!You are correct in that  Config::set(); only works once per request. My estimation is that this is done intentionally to stop the kind of thing you are attempting to do in your code example.In config/filesystems.php you can list any number of "disks". These are locations of your file repositories. It looks like so:The solution is to create a new disk of the extra buckets you want to use. Treat your buckets like different disks.Note: The user that the S3_Key belongs to needs to have permissions to perform your required actions on the S3 buckets you are setting up as additional 'disks'.Then whenever you want to access the bucket of your choice call it like so:If you have dynamic buckets you also can create a new instance like this:You can add the buckets to the filesystems config like so:Then you can access the server using the following:

Laravel 5 Carbon global Locale

Mathieu Urstein

[Laravel 5 Carbon global Locale](https://stackoverflow.com/questions/32549845/laravel-5-carbon-global-locale)

I'm trying to set the same global locale of laravel which is :to work with Carbon.It seems like you can do it by using either :or So I have tried using middleware or providers but was not successful.(why is this not a default feature of laravel?)

2015-09-13 12:49:42Z

I'm trying to set the same global locale of laravel which is :to work with Carbon.It seems like you can do it by using either :or So I have tried using middleware or providers but was not successful.(why is this not a default feature of laravel?)So this is my bad, Carbon is actually using the phpthemethod is only for themethod.

Notice that the php setlocale() reference to the locale stored on your OS

to choose one of the installed one useon your consolesecondly, you have to usemethod instead ofmethodand lastly all the usefull methods likeare not being localizedand lastly you have to use these parsing lettershttp://php.net/manual/en/function.strftime.phpI configured it in the AppServiceProvider.in AppServiceProviderthen to make locale output do something like thisFor more information about converting localize dates you can see on below link

https://carbon.nesbot.com/docs/#api-localization

Laravel Homestead

AxlSmith

[Laravel Homestead](https://stackoverflow.com/questions/23709039/laravel-homestead)

I'm trying to get Laravel Homestead up and running. I believe I did everything as manual says. When I run vagrant up -command I get following error on OS X 10.9: My Homestead.yaml file is following:And this is what I get while executing vagrant up:

2014-05-17 08:04:25Z

I'm trying to get Laravel Homestead up and running. I believe I did everything as manual says. When I run vagrant up -command I get following error on OS X 10.9: My Homestead.yaml file is following:And this is what I get while executing vagrant up:Map your projects directory to something else than /home/vagrant:This should fix your problem and you probably don't want your vagrant's config files (.ssh, .bashrc, etc) synced back to your local projects directory anyway.Also your keys property should be set to private key, not public.If you look at original Homestead.yaml again, you'll see that:authorize needs your public key (id_rsa.pub)keys needs your privte key (id_rsa)keys should be:keys: - /Users/foo/.ssh/id_rsa

not 

keys: - /Users/foo/.ssh/id_rsa.pubHomestead is just an implementation of vagrant.Try:If this still doesn't work, tryA little suggestion here based on my own learning experience. Homestead provides a nice and neat way for beginners to work on Laravel Framework in no time. However, I think the vagrant settings and weird environment is not straight forward to me. I believe everyone has to work with the real Server and Laravel environment eventually. Therefore, I decided to give up homestead and simply install Ubuntu on VirtualBox. Then, I followed official instructions here and installed my Laravel pretty easily. Just for your information. Just go straight to the real Laravel system instead of Homestead.

laravel 5.1 not seeing changes to Job file without VM restart

Nicekiwi

[laravel 5.1 not seeing changes to Job file without VM restart](https://stackoverflow.com/questions/30881324/laravel-5-1-not-seeing-changes-to-job-file-without-vm-restart)

I have created a new Job in a laravel 5.1 app, running in Homestead VM. I've set it to be queued and have code in the handle method.The handle() method previous expected a param to be passed, but is no longer required and I've removed the param form the handle method. However, when the queue runs the job I get an error saying:line 31 of that file is:Its not longer expecting any parameters, unless there's a default one that's not documented. Now ANY changes I make, including comments out ALL content in the Job file are not seen when I run the queue. I will still get the same error.Ive tried restarting nginx, php5-fpm, supervisor, beanstalkd, and running: artisan cache:clear, artisan clear-compiled, artisan optimize, composer dumpautoload. Nothing works. The only way I get get laravel to see any updated to the Job file is to restart the VM. vagrant halt, then vagrant up.The job is triggered in a console command like this:  Here is the full code of the SpecialJob.php file:http://laravel.io/bin/qQQ3M#5I tried created another new Job and tested, I get the same result. All other non-job files update instantly, no issue. Its just the Job files. Like an old copy is being cached somewhere I can't find. 

2015-06-17 02:25:36Z

I have created a new Job in a laravel 5.1 app, running in Homestead VM. I've set it to be queued and have code in the handle method.The handle() method previous expected a param to be passed, but is no longer required and I've removed the param form the handle method. However, when the queue runs the job I get an error saying:line 31 of that file is:Its not longer expecting any parameters, unless there's a default one that's not documented. Now ANY changes I make, including comments out ALL content in the Job file are not seen when I run the queue. I will still get the same error.Ive tried restarting nginx, php5-fpm, supervisor, beanstalkd, and running: artisan cache:clear, artisan clear-compiled, artisan optimize, composer dumpautoload. Nothing works. The only way I get get laravel to see any updated to the Job file is to restart the VM. vagrant halt, then vagrant up.The job is triggered in a console command like this:  Here is the full code of the SpecialJob.php file:http://laravel.io/bin/qQQ3M#5I tried created another new Job and tested, I get the same result. All other non-job files update instantly, no issue. Its just the Job files. Like an old copy is being cached somewhere I can't find. When running the queue worker as a daemon, you must tell the worker to restart after a code change.

Laravel 5 echo out session variable containing html in blade

Webtect

[Laravel 5 echo out session variable containing html in blade](https://stackoverflow.com/questions/32172241/laravel-5-echo-out-session-variable-containing-html-in-blade)

I did a redirect in laravel:$returnData is a string that contains a bootstrap info div with the result from the controller. Almost everything is working except when the page loads again it shows the html on the page as if it were text, brackets and everything. If I use this:Then it shows is as pure text. If I change it toIt works fine. Im ok keeping it like this but I would rather utilize Blade / Laravel as its supposed to be used so I was wondering if there is a way to have the @if statement show the rendered html and not the text version?

2015-08-23 22:38:59Z

I did a redirect in laravel:$returnData is a string that contains a bootstrap info div with the result from the controller. Almost everything is working except when the page loads again it shows the html on the page as if it were text, brackets and everything. If I use this:Then it shows is as pure text. If I change it toIt works fine. Im ok keeping it like this but I would rather utilize Blade / Laravel as its supposed to be used so I was wondering if there is a way to have the @if statement show the rendered html and not the text version?I would recommend returning just the error message then in your view create the div. So if you were to change the layout of the view, you would it in one place. hope this help. To show the rendered HTML you should use {!! $variable->coontent !!} in your view, and this gonna convert your HTML text to render May this example will help you.

Try this Try changing your blade code to following.

Laravel dynamic page title in navbar-brand

nclsvh

[Laravel dynamic page title in navbar-brand](https://stackoverflow.com/questions/34497428/laravel-dynamic-page-title-in-navbar-brand)

I have layouts.app.blade.php where I have my <html> and <body> tags and also the <nav>.

In the <body> I yield content for every page, so they basically extend this app.blade.php.

All basic Laravel stuff so now I have this:  And I would like to use this <a class="navbar-brand"> to display my pagetitle. So this means it has to change for each template that is loaded (with @yield('content')) in this 'parent.blade.php'.How would I do this using Laravel 5.2?Many thanks

2015-12-28 16:51:20Z

I have layouts.app.blade.php where I have my <html> and <body> tags and also the <nav>.

In the <body> I yield content for every page, so they basically extend this app.blade.php.

All basic Laravel stuff so now I have this:  And I would like to use this <a class="navbar-brand"> to display my pagetitle. So this means it has to change for each template that is loaded (with @yield('content')) in this 'parent.blade.php'.How would I do this using Laravel 5.2?Many thanksIf this is your master page title belowthen your page title can be changed in your blade page like belowMore information can be found here Laravel DocsYou can pass it to a view for exampleControllerViewor php7Blade view like this-instead of-And now in your view you can use:

After upgrading Laravel from 5.6 to 6.0, Call to undefined str_random() function not working

Vishal Srivastava

[After upgrading Laravel from 5.6 to 6.0, Call to undefined str_random() function not working](https://stackoverflow.com/questions/58163406/after-upgrading-laravel-from-5-6-to-6-0-call-to-undefined-str-random-function)

I have upgraded Laravel from 5.6 to 6.0. Previously, default helper functions were running fine on the controllers, but now it says "undefined." In my controller, I have used the following.I am getting the following error.I have also used the random() function, and it's saying the same thing.Can somebody please guide me on what to do?.I have run commands like:But I get the same error.

2019-09-30 07:36:50Z

I have upgraded Laravel from 5.6 to 6.0. Previously, default helper functions were running fine on the controllers, but now it says "undefined." In my controller, I have used the following.I am getting the following error.I have also used the random() function, and it's saying the same thing.Can somebody please guide me on what to do?.I have run commands like:But I get the same error.In Laravel 6 All str_ and array_ helpers have been moved to the new laravel/helpers Composer package and removed from the framework. If desired, you may update all calls to these helpers to use the Illuminate\Support\Str and Illuminate\Support\Arr classes. Alternatively, you can add the new laravel/helpers package to your application to continue using these helpers:If don't want to add Package then Used Str And Arr Classes.For Example :https://laravel.com/docs/master/helpers#method-str-randomAdd the following string library.now you can use it as below.alternatively, install the following package.

Trying to get key in a foreach loop to work using blade

Artful_dodger

[Trying to get key in a foreach loop to work using blade](https://stackoverflow.com/questions/33641912/trying-to-get-key-in-a-foreach-loop-to-work-using-blade)

if I use {{$node[0]->url}} then Laravel's templating engine dislays the correct result but I can not figure out how to display all using the @for $i=0 within a @foreach loop this is what I have in my routes fileand this is what I have tried in my view filesorry here is the complete print_r result

2015-11-10 23:55:13Z

if I use {{$node[0]->url}} then Laravel's templating engine dislays the correct result but I can not figure out how to display all using the @for $i=0 within a @foreach loop this is what I have in my routes fileand this is what I have tried in my view filesorry here is the complete print_r resultThe simple answer is that foreach in Blade works the same as a regular PHP foreach. You should be able to do something like:If you need access to the array key value for each node:However, I think the problem may not be with your Blade syntax, but with the way you created your input variables. Given the way you created $oReturn in the code above, it won't have the properties you appear to be expecting. To illustrate, here's a simplified version of what you appear to be creating:would return:So when you do @foreach ($oReturn as $node) the value of $node would be the entry[] array, which has a single element, that is an array of nodes. It is not clear from your input that these nodes even have url elements. If you did want to loop through the nodes you'd have to do something like:Does this make sense? I think you need to rethink your creation of $oReturn.Given feedback below and the output of your print_r statement above, the following should work:The (string) casts the result of $node->url to string. Otherwise PHP may treat it as some kind of object. SimpleXMLElement can be weird.

Laravel eloquent model how to get data from relationship's table

Ajeesh

[Laravel eloquent model how to get data from relationship's table](https://stackoverflow.com/questions/34082264/laravel-eloquent-model-how-to-get-data-from-relationships-table)

I am developing a laravel application which has the following eloquent modelsI have a controller 'ProductController' where the following code is availableI am exposing RESTfull API which will allow my users to get all product details (including skus, shipping types etc..).Suppose if I have an API GET : /productsThe code which fetches all the product details will be some what the followingNow my question is , is this logic proper? In this case all the logics are in the controller since im using eloquent models I have a model for each table and the relationships are defined in it. Is there a way I can get all the details of a product/associated model (Products details (in table 1)+ Sku details (in table 2)) rather than using the belowI am pretty new to laravel development and eloquent models. I will be using repository pattern for the development and in that case where does the aboe logic (Product+Sku combining) resides.Please help out.

2015-12-04 06:32:31Z

I am developing a laravel application which has the following eloquent modelsI have a controller 'ProductController' where the following code is availableI am exposing RESTfull API which will allow my users to get all product details (including skus, shipping types etc..).Suppose if I have an API GET : /productsThe code which fetches all the product details will be some what the followingNow my question is , is this logic proper? In this case all the logics are in the controller since im using eloquent models I have a model for each table and the relationships are defined in it. Is there a way I can get all the details of a product/associated model (Products details (in table 1)+ Sku details (in table 2)) rather than using the belowI am pretty new to laravel development and eloquent models. I will be using repository pattern for the development and in that case where does the aboe logic (Product+Sku combining) resides.Please help out.Yes, you can get the details of the products and skus without making one additional query per product using eager loading 

 ( this is referred as the typical N+1 query problem where N is the number of the products ) Suppose the relation between your Product and Sku models model is:ProductTo fetch the products data along with the sku data you can use the with method. In your controller:ControllerThen, in your views, you can get the info this way:ViewFor the repository question: if you want to use a repository you can place the eloquent-access part of your code inside the repository. So, for example you could have this method inside the repository:ProductRepositorythen you can use your repository in your controller:ControllerIf I understand your question correctly, you can use eager loading.This will give you an array of products that have a skus array in each product object.If the repository pattern is used, do it like this.You can try this:This will give you the exact result in the object form.

Laravel - Set global variable from settings table

Caio Kawasaki

[Laravel - Set global variable from settings table](https://stackoverflow.com/questions/34126578/laravel-set-global-variable-from-settings-table)

I'm trying to store all my settings from my settings table into a global variable, but I'm stucked now(I have no idea what's the next step), this is my actual model and seeder:model - Settings.phpseeder - SettingsTableSeeder.phpHow can I store all the data inside the settings table and make then acessible from blade, or any controller or view?Now, my question is, how can i update a single or multiple value(s) from a form?I have set this up:My route:My Admin\AdminConfiguracoesController:My SettingRepository:My blade form:But things does not work. How can I update the values into the table?

2015-12-07 04:41:55Z

I'm trying to store all my settings from my settings table into a global variable, but I'm stucked now(I have no idea what's the next step), this is my actual model and seeder:model - Settings.phpseeder - SettingsTableSeeder.phpHow can I store all the data inside the settings table and make then acessible from blade, or any controller or view?Now, my question is, how can i update a single or multiple value(s) from a form?I have set this up:My route:My Admin\AdminConfiguracoesController:My SettingRepository:My blade form:But things does not work. How can I update the values into the table?See improved answer in Update 2I would add a dedicated Service Provider for this. It will read all your settings stored in the database and add them to Laravels config. This way there is only one database request for the settings and you can access the configuration in all controllers and views like this: Step 1: Create the Service Provider.You can create the Service Provider with artisan:php artisan make:provider SettingsServiceProviderThis will create the file app/Providers/SettingsServiceProvider.php.Step 2: Add this to the boot-method of the provider you have just created:From the Laravel Docs:http://laravel.com/docs/5.1/providers#the-boot-methodStep 3: Register the provider in your App.Add this line to the providers array in config/app.php:And that's it. Happy coding!Update: I want to add that the boot-method supports dependency injection. So instead of hard coding \App\Setting, you could inject a repository / an interface that is bound to the repository, which is great for testing.Update 2: As Jeemusu mentioned in his comment, the app will query the database on every request. In order to hinder that, you can cache the settings. There are basically two ways you can do that.To make thinks more fault tolerant, I'd use the second option. Caches can be cleared unintentionally. The first option will fail on fresh installations as long as the admin did not set the settings or you reinstall after a server crash.For the second option, change the Service Providers boot-method:Now you only have to make the cache forget the settings key after the admin updates the settings:To avoid querying the database on each request, you should save the settings to a config file each time they are changed by the admin/user. The above will create a Laraval compatible config file that essentially just returns an array of key => values. The generated file will look something like this.Any php file in the /config directory will be auto-included by Laravel and the array variables accessible to your application via the config() helper:You can store the data in the database just like you do it normally in Laravel. \App\Setting::create(), \App\Setting::new() and other methods.For using the values in blade, you can do {{\App\Setting::where('name','title')->pluck('value')}}And, you can also use scopes for this.then you could use \App\Setting::for('title')->pluck('value')

find in set in laravel ? example

Ravi Kadia

[find in set in laravel ? example](https://stackoverflow.com/questions/35594450/find-in-set-in-laravel-example)

I am new in laravel. My query is i need to find out value from comma separated field. Here is my table:tags_valueThis is my SQL query:but it's not working.Please help me to solve this problem.

Thanks in advance.

2016-02-24 06:03:39Z

I am new in laravel. My query is i need to find out value from comma separated field. Here is my table:tags_valueThis is my SQL query:but it's not working.Please help me to solve this problem.

Thanks in advance.You need to escape the call to FIND_IN_SET() using quotes:If you want to parameterize the column for which you search in FIND_IN_SET, then you can try something like this:Try this : 

Laravel: Enable Sentry user account be used in multiple computers

enchance

[Laravel: Enable Sentry user account be used in multiple computers](https://stackoverflow.com/questions/17393833/laravel-enable-sentry-user-account-be-used-in-multiple-computers)

While using Sentry in L4, is it possible to make an account be used in multiple computers at the same time? Right now, Sentry logs out the user the moment the same account is used in another computer.Right now I'm trying for that not to happen and keep both users logged in at the same time. I know that it's a security feature when a user gets logged out, but my project's circumstances aren't what you'd call normal.

2013-06-30 19:01:30Z

While using Sentry in L4, is it possible to make an account be used in multiple computers at the same time? Right now, Sentry logs out the user the moment the same account is used in another computer.Right now I'm trying for that not to happen and keep both users logged in at the same time. I know that it's a security feature when a user gets logged out, but my project's circumstances aren't what you'd call normal.Extension to Nico Kaag's answer and implementation of spamoom's comment:/app/config/packages/cartalyst/sentry/config.php/app/models/User.php

It is possible, but not supported by Sentry itself.

To do this, you have to change some core code in Sentry, or find a way to override the User class that's in the Sentry code.The function you need to adjust is "GetPresistCode()" in the User model, which can be found in:And this is how the function should look like (not tested):I have to say that I highly recommend you don't change the code in Sentry, and that you find another way around, but that might be really hard.

laravel orderByRaw() on the query builder

Amir

[laravel orderByRaw() on the query builder](https://stackoverflow.com/questions/20065972/laravel-orderbyraw-on-the-query-builder)

there is no way to make such a query(with the binding) using the Laravel query builder right now:this will order the results by relevance, If we had(which we don't now!) orderByRaw then the above query would be:I opened this issue but It didn't get anywhere:

https://github.com/laravel/framework/issues/2134any suggestion?

2013-11-19 07:49:54Z

there is no way to make such a query(with the binding) using the Laravel query builder right now:this will order the results by relevance, If we had(which we don't now!) orderByRaw then the above query would be:I opened this issue but It didn't get anywhere:

https://github.com/laravel/framework/issues/2134any suggestion?Using Eloquent you can do the following:The same would work with the Query Builder, but then you have to do a little rewriting.

Laravel「undefined method Illuminate\Database\Query\Builder::attach()」

glasstree

[Laravel「undefined method Illuminate\Database\Query\Builder::attach()」](https://stackoverflow.com/questions/22495130/laravel-undefined-method-illuminate-database-query-builderattach)

I'm trying to associate related models during database seeding in Laravel 4. According to the documentation here, I can do it like this:So, in my database seed I'm running:The packages items have already been seeded at this point, and they seed without problems. The above code gives this from Artisan though:Someone here seems to think that the attach() method doesn't actually exist and the docs are wrong, but I find that hard to believe.TL;DR What is the correct way to create many-to-many relationships in Eloquent?

2014-03-19 02:37:32Z

I'm trying to associate related models during database seeding in Laravel 4. According to the documentation here, I can do it like this:So, in my database seed I'm running:The packages items have already been seeded at this point, and they seed without problems. The above code gives this from Artisan though:Someone here seems to think that the attach() method doesn't actually exist and the docs are wrong, but I find that hard to believe.TL;DR What is the correct way to create many-to-many relationships in Eloquent?The function items() in your Package model has to return a BelongsToMany relationship in order to use attach().

Using Laravel Socialite with an API?

Rob

[Using Laravel Socialite with an API?](https://stackoverflow.com/questions/35966605/using-laravel-socialite-with-an-api)

I'm trying to use Laravel Socialite package over an api. I try to pass the code into my api to fetch the user but it keeps giving me an error:Since I'm doing the request over an API, I take the following steps.Send a request to api for the url to fetch the code:Then make a request with the above fetched url, which redirects with the code parameter.Send the code to the api and fetch the user:This is where it crashes. I'm not sure why. I've used the package before and it works fine when I just have an app that reloads the page. But when I send it to an api (on a different domain) it crashes. I'm thinking there is some issue with how the code is generated. Is there anyway to fix this?

2016-03-13 04:47:02Z

I'm trying to use Laravel Socialite package over an api. I try to pass the code into my api to fetch the user but it keeps giving me an error:Since I'm doing the request over an API, I take the following steps.Send a request to api for the url to fetch the code:Then make a request with the above fetched url, which redirects with the code parameter.Send the code to the api and fetch the user:This is where it crashes. I'm not sure why. I've used the package before and it works fine when I just have an app that reloads the page. But when I send it to an api (on a different domain) it crashes. I'm thinking there is some issue with how the code is generated. Is there anyway to fix this?Just found my answer. Need to use stateless in both calls:Hope this helps someone.I made SocialController.php and url (POST request) /api/social-login which accepts provider and access_token.SocialAccount here is a laravel model where you'll provider and provider_user_id and local database user id. Below is the example of social_accounts tableAnd in SocialController :EDIT:I have created package for the same https://packagist.org/packages/pimplesushant/laravelsocialiteapi

Artisan Call output in Controller?

user1469734

[Artisan Call output in Controller?](https://stackoverflow.com/questions/37726558/artisan-call-output-in-controller)

I have a complex Artisan Command that I wanna call in my Controller also. That works. Except that it return an Exitcode instead of output.I want the output of the command. How to do that? The last line of my Artisan command has a return on the last line that should be returned.. How?

2016-06-09 12:52:19Z

I have a complex Artisan Command that I wanna call in my Controller also. That works. Except that it return an Exitcode instead of output.I want the output of the command. How to do that? The last line of my Artisan command has a return on the last line that should be returned.. How?Some off commands can not run with php artisan in controller you need to run them with shellThis is the list of commands and api:gen and passport install just will run with shell from /bootstrap folder !code to output inspire phrases instead of exit code

Laravel using where clause on a withCount method

slapbot

[Laravel using where clause on a withCount method](https://stackoverflow.com/questions/39930975/laravel-using-where-clause-on-a-withcount-method)

I am trying to do a where clause on withCount method of laravel's eloquent query builder using this piece of code.and this code is giving me this error.So from what I can guess is that upvotes_count isn't selected and hence the column is not being found, BUT if I execute this piece of code.Then I am getting this output.Which basically means that upvotes_count is being selected, hence i am really confused about how to solve this problem.(More options that I tried so far are given below with the respective error associated to it.)error.code.ANDerror.I just want to use where clause on a count() method which is in a relationship with a parent model.

2016-10-08 09:49:51Z

I am trying to do a where clause on withCount method of laravel's eloquent query builder using this piece of code.and this code is giving me this error.So from what I can guess is that upvotes_count isn't selected and hence the column is not being found, BUT if I execute this piece of code.Then I am getting this output.Which basically means that upvotes_count is being selected, hence i am really confused about how to solve this problem.(More options that I tried so far are given below with the respective error associated to it.)error.code.ANDerror.I just want to use where clause on a count() method which is in a relationship with a parent model.You can achieve requested result by using:I'm not sure if this was implemented after your question, but you can now do it like thisI ran into the same problem, and tried the same things you did.  I'm guessing there is a way to replicate the SQL generated by the withCounts call but add a way to make xxx_counts available to a where clause, but I just filtered the resulting collection instead.If you need to select only rows that the counter is greater than or equal to 1 you can try the follow code:I don't know if this is the best solution but it's an alternative. Another alternative would be get the posts and use array filter as mentioned in a comment above.another good way to do this

we can filter that separately and even assign an alias to that column nameNow in blade you can do I think using has() is the best solution:You could also use a filter:You could also disable strict mode in config/database.php (probably not a good idea)You could also try to add a groupBy clause (using having in strict mode), but this will likely require you to include every column in your table (due to 'ONLY_FULL_GROUP_BY'), which could break things if you ever add another column to your table, and probably won't work anyway because I think you need to include 'upvotes_count' in the groupBy and it seems to be a non grouping field.

how to show 500 internal Server error page in laravel 5.2?

kunal

[how to show 500 internal Server error page in laravel 5.2?](https://stackoverflow.com/questions/41216672/how-to-show-500-internal-server-error-page-in-laravel-5-2)

I want to show the page 500 internal server error Page. when user had syntax error mistake in project can anyone help me? if i do some mistake in syntax i want to show that particular blade. 

2016-12-19 06:09:46Z

I want to show the page 500 internal server error Page. when user had syntax error mistake in project can anyone help me? if i do some mistake in syntax i want to show that particular blade. You need to create handler to catching FatalErrorExceptions in your handler like below code:Handler

In app/Exceptions/Handler.php View

See resources/views/errors/500.blade.php. If not exist then create it.You can get more detailed OR other ways from Laravel 5 custom error view for 500 In your resources/views/errors  folder create a file named 500.blade.php.The problem is that Laravel will only do this automatic rendering of error pages for exceptions that are instances of HttpException. Unfortunately when your server throws an error (method does not exist, variable undefined, etc) it actually throws a FatalErrorException. As such, it is uncaught, and trickles down to the SymfonyDisplayer() which either gives you the trace (debug true) or ugly one-liner 'Whoops, looks like something went wrong' (debug false).To solve this you have add this to your render method to app/Exceptions/HandlerDocsMy solution is simple, just replace your render() method in Exceptions\Handler.php file with:It will show 500 page if app in production environment. You will need to have 500.blade.php view in your resources/views/errors folder.Like @Amit said So my solution is to replace whatever exception that is not HttpException by a HttpException.in app\Exceptions\Handler create the following method:it will override the one in the parent class (Illuminate\Foundation\Exceptions\Handler) that displays the whoops page.In Laravel 5.4, you could override prepareException function in your app\Exception\Handler.php:

Laravel 4 route with unlimited number of parameters

David Maksimov

[Laravel 4 route with unlimited number of parameters](https://stackoverflow.com/questions/21522677/laravel-4-route-with-unlimited-number-of-parameters)

I'm trying to create a dynamic route for an unlimited number of URL levels.Here's my current routeThis works for the first level. So a URL like something.com/foo/ would work. But if I had something like something.com/foo/bar/ it wouldn't catch that URL. I need it to match unlimited levels. That way in my controller it'll get me a variable of whatever the entire link is.I know I could doBut that just seems like an overkill. Is there a better way to do this so it'll match to the end of the URL?Thanks.

2014-02-03 08:30:04Z

I'm trying to create a dynamic route for an unlimited number of URL levels.Here's my current routeThis works for the first level. So a URL like something.com/foo/ would work. But if I had something like something.com/foo/bar/ it wouldn't catch that URL. I need it to match unlimited levels. That way in my controller it'll get me a variable of whatever the entire link is.I know I could doBut that just seems like an overkill. Is there a better way to do this so it'll match to the end of the URL?Thanks.You can try something like this: Remember to put the above on the very end (bottom) of routes.php file as it is like a 'catch all' route, so you have to have all the 'more specific' routes defined first. This approach should let you use unlimited amount of params, so this is what you seem to need. @Fusion

https://laravel.com/docs/5.4/routing You may constrain the format of your route parameters using the where method on a route instance. The where method accepts the name of the parameter and a regular expression defining how the parameter should be constrained. so {id} is a route parameter , and ->where('id', '[0-9]+') is a regex expression for this parameter. If u need to use more than parameters you can do something like this : 

Laravel 5.1 - How to set a message on progress bar

Christopher

[Laravel 5.1 - How to set a message on progress bar](https://stackoverflow.com/questions/32015511/laravel-5-1-how-to-set-a-message-on-progress-bar)

I'm trying the same example as provided on Laravel docs:And this works well. I want to customize the progress bar (see this) but $this->output->setMessage('xpto'); gives:

2015-08-14 17:19:19Z

I'm trying the same example as provided on Laravel docs:And this works well. I want to customize the progress bar (see this) but $this->output->setMessage('xpto'); gives:The $this->output object is a instance of Symfony's Symfony\Component\Console\Style\SymfonyStyle, which provides the methods progressStart(), progressAdvance() and progressFinish().The progressStart() method dynamically creates an instance of Symfony\Component\Console\Helper\ProgressBar object and appends it to your output object, so you can manipulate it using progressAdvance() and progressFinish().Unfortunatelly, Symfony guys decided to keep both $progressBar property and getProgressBar() method as private, so you can't access the actual ProgressBar instance directly via your output object if you used progressStart() to start it.createProgressBar() to the rescue!However, there's a cool undocumented method called createProgressBar($max) that returns you a shiny brand new ProgressBar object that you can play with.So, you can just do:And do whatever you want with it using the Symfony's docs page you provided. For example:Hope it helps. ;)

Laravel Collection keys modification

pavon147

[Laravel Collection keys modification](https://stackoverflow.com/questions/40568745/laravel-collection-keys-modification)

I use filter method from Collection class to remove some objects from collection. But after that operation, sometimes objects with keys eg. 1, 4, 5 left. I would like to always have elements with order 0, 1, 2, 3 etc. after filter action.Is there any elegant way to do it without rewriting table to a new one?Thanks!

2016-11-12 23:11:42Z

I use filter method from Collection class to remove some objects from collection. But after that operation, sometimes objects with keys eg. 1, 4, 5 left. I would like to always have elements with order 0, 1, 2, 3 etc. after filter action.Is there any elegant way to do it without rewriting table to a new one?Thanks!You can use Laravel Collection's values() method to make the the keys of a collection in a serialized order like this:Hope this helps!

How do Laravel migrations work?

Recur

[How do Laravel migrations work?](https://stackoverflow.com/questions/30220377/how-do-laravel-migrations-work)

I'm totally new to this type of framework. I've come from barebones PHP development and I can't seem to find an easy to understand guide what migrations actually do.I'm trying to create a project that already has an existing database. I've used this: https://github.com/Xethron/migrations-generator[1] but making changes to the schema via the migrations seems to spit out errors which means I have no idea what I'm doing.I really need a simple run down of what migrations actually do, how they affect the database and anything else you think would help an absolute beginner.

2015-05-13 16:23:19Z

I'm totally new to this type of framework. I've come from barebones PHP development and I can't seem to find an easy to understand guide what migrations actually do.I'm trying to create a project that already has an existing database. I've used this: https://github.com/Xethron/migrations-generator[1] but making changes to the schema via the migrations seems to spit out errors which means I have no idea what I'm doing.I really need a simple run down of what migrations actually do, how they affect the database and anything else you think would help an absolute beginner.Migrations are a type of version control for your database. They allow a team to modify the database schema and stay up to date on the current schema state. Migrations are typically paired with the Schema Builder to easily manage your application's schema.With migrations you don't need to create table in phpMyAdmin, you can do it in Laravel. Here is an example to create a user table:I this code we create table with fields like "name", "lastname"... we said in our Laravel code they are string type when migration is done we have complete table in databese with this fields.Run a migration to create tableTo create a migration, you may use the make:migration command on the Artisan CLI (artisan command line interface):orRun a migration to alter tableWhen you need to do some changes in database table example: add field vote to user table you can do like this in your Laravel code without touching SQL codeRollback the last migration operationIf you make mistake and did something wrong you can always rollback to return database in previous state.Rollback all migrationsRollback all migrations and run them all againOne of best advantage of migrations are creating database without touching SQL code. You can make whole database with relationship in PHP code then migrate it into MySQL, PL/SQL, MSSQL or any other database.Also I recommend the free Laravel 5 fundamental series, in episode 7 you can hear more about migrations.A simple explanation of migrations:They're a versioning system for your database scheme.Imagine you're setting up a new application. The first thing you do is create a table (call it mytable) with a couple of columns. This will be your first migration. You run the migration (php artisan migrate) when you start working on your application and voila! You have a new table in your database.Some time later, you decide that you need a new column in your table. You create a migration (php artisan make:migration in Laravel 5) and a new migration file is created for you. You update the code in that migration, run php artisan migrate again, and you have a new column in your table.Ok, that's the basic idea behind migrations. But there's more...Suppose, later on, you realize that you messed up when you created that last migration. You've already run it, so your database has changed. How to you fix it? Well, if you wrote your migration correctly and implemented the down method, you can just do php artisan migrate:rollback and it will rollback the migration.How does Laravel do this? By keeping track of your migrations in a special database table. The php artisan migrate:install command will set things up for you so Laravel can manage these migrations.Over time, as your application grows, you will add more and more migrations. Laravel gives you a way to step forward and back through your migrations as needed to ensure your database is at whatever state you need it to be as you're working.Check out the list of artisan commands with php artisan. You can also request help on a particular command with php artisan help <command>.Imagine you are working on a project with other developers.  As developers are adding more and more features, they are also required to add more and more tables, columns, remove columns, change column data types, etc...This can very quickly and easily get out of control.  If you missed some SQL from one developer, another developer's SQL may not work correctly.  It also potentially becomes a huge time waster trying to sort through a bunch of sql files trying to figure out which ones you've missed.  It's only a matter of time till everyone on the development team is working with different databases or god forbid, someone breaks the production database.  With migrations, you just need to run php artisan migrate in the command line and all changes to the database will be taken care of for you.This is basically why migrations are useful I'm not going to go into the basics of how they work because Kryten has a pretty good write-up here already.

Safely edit a third party composer (vendor) package in Laravel & prevent losing customized changes on release of a new version of the package

TimothyBuktu

[Safely edit a third party composer (vendor) package in Laravel & prevent losing customized changes on release of a new version of the package](https://stackoverflow.com/questions/31080696/safely-edit-a-third-party-composer-vendor-package-in-laravel-prevent-losing)

I want to edit a package I pulled from composer in my Laravel 5 project, however i believe that if I ran composer update and a new version of this package has been released, I will lose all of my changes. How should I go about editing the package? Is there a way to copy package out of the vendor directory so I can use it somewhere else in my project?

2015-06-26 19:23:19Z

I want to edit a package I pulled from composer in my Laravel 5 project, however i believe that if I ran composer update and a new version of this package has been released, I will lose all of my changes. How should I go about editing the package? Is there a way to copy package out of the vendor directory so I can use it somewhere else in my project?It actually isn't safe to edit composer packages, for the very reason you point out.What I do is extends the classes that I want/need to change.I have done it here with the Filesystem class. It doesn't ensure that it won't break, but it does let you update without overwriting your changes.config/app.phpMyApp\Filesystem\FilesystemServiceProvider.phpThe simple, fast and safe method:first remove it from require and then add it to autoloadPlease do not forget to runAlternative for step 3.There is also a new alternative if you're using latest version of composer.Add this to you composer.jsonAnd then modify the version of package to dev-masterFinallyIf you want to make changes to a class of a package you have toif you want to keep your changes AND update the package from the original repo at the same time, you can fork this package and point composer to pull from your fork, not the original repo.update your composer.json file as follows:Note that you don't change the require statement except to specify your bugfix branch. You still reference the upstream package (laravelcollective/html), not your personal fork (MyGithub/html). also, note that dev- is automatically added so branch name is bugfix not dev-bugfix. if you named your branch as dev-bugfix you will require it as dev-dev-bugfix.

Session data not preserved after redirection

Drown

[Session data not preserved after redirection](https://stackoverflow.com/questions/34438852/session-data-not-preserved-after-redirection)

I'm trying to implement some custom flash messages and I'm having some issues with the session data being destroyed after a redirect.Here's how I create my flash messages : Here's the declaration of the flash() function : And here is how I'm checking the session/displaying the flash messages, using SweetAlerts. This code is included at the bottom of the main layout file that I'm extending in all my Blade templates.The code above will work if I call the flash() function before displaying a view, like so : However, it will not work if I call it before doing a redirect to another page, like so : Why is the session data lost on redirect? How can I make it persists so that I can display my flash message?

2015-12-23 15:27:56Z

I'm trying to implement some custom flash messages and I'm having some issues with the session data being destroyed after a redirect.Here's how I create my flash messages : Here's the declaration of the flash() function : And here is how I'm checking the session/displaying the flash messages, using SweetAlerts. This code is included at the bottom of the main layout file that I'm extending in all my Blade templates.The code above will work if I call the flash() function before displaying a view, like so : However, it will not work if I call it before doing a redirect to another page, like so : Why is the session data lost on redirect? How can I make it persists so that I can display my flash message?I found out that it is necessary to apply the web middleware on all routes. Drown has mentioned to do so, but since March 23st 2016, Taylor Otwell changed the default RouteServiceProvider at https://github.com/laravel/laravel/commit/5c30c98db96459b4cc878d085490e4677b0b67edBy that change the web middleware is applied automatically to all routes. If you now apply it again in your routes.php, you will see that web appears twice on the route list (php artisan route:list). This exactly makes the flash data discard.Also see: https://laracasts.com/discuss/channels/laravel/session-flash-message-not-working-after-redirect-route/replies/159117It turns out that with Laravel 5.2, the routes have to be wrapped in the web middleware for the session to work properly. This fixed it : With Laravel 5.2.34, all routes are using web middleware by default.Therefore, change this:To this:And then in your controller you could use:The issue i had was Session::save() preventing swal from showing after redirect.Redirect with flash data is done like this:In early Laravel 5.2 versions, all of your Flash and Session data are stored only if your routes are inside web middleware group.As of Laravel 5.2.34, all routes are using web middleware by default. If you will put them into middleware web group again, you will apply web middleware on your routes twice - such routes will be unable to preserve Flash or Session data.Please check APP/kernel.php\Illuminate\Session\Middleware\StartSession::class,is define multiple timesYou can comment any one or delete it. We need to define one time only.have you tired using "redirect with"https://laravel.com/docs/5.2/responses#redirecting-with-flashed-session-dataCheck your App\Kernel.php file. 

There may be multiple lines of \Illuminate\Session\Middleware\StartSession::class,

Comment one from $middlewareGroups.Additional to @Harry Bosh answer,In Laravel there an issue when Session::save() happen inside the middleware,

this make _flash session gone after redirection happenthis can be fix by using alternative : 

Laravel: How to access session value in AppServiceProvider?

Qazi

[Laravel: How to access session value in AppServiceProvider?](https://stackoverflow.com/questions/35314031/laravel-how-to-access-session-value-in-appserviceprovider)

Is there any way available to access Session values in AppServiceProvider? I would like to share session value globally in all views.

2016-02-10 11:32:02Z

Is there any way available to access Session values in AppServiceProvider? I would like to share session value globally in all views.You can't read session directly from a service provider: in Laravel the session is handled by StartSession middleware that executes after all the service providers boot phaseIf you want to share a session variable with all view, you can use a view composer from your service provider:The callback passed as the second argument to the composer will be called when the view will be rendered, so the StartSession will be already executed at that pointThe following works for me on Laravel 5.2, is it causing errors on your app?AppServiceProvider.phphome.blade.phpShows "en_US" in the browser.

String as Primary Key in Laravel migration

DGeo

[String as Primary Key in Laravel migration](https://stackoverflow.com/questions/44229280/string-as-primary-key-in-laravel-migration)

I've had to change a table in my database so that the primary key isn't the standard increments.Here's the migration,However, MySQL keeps returning with,I've tried leaving the normal increments id in there and modifying the table in a different migration but the same thing happens.Any ideas of what I'm doing wrong?Laveral Version 5.4.23

2017-05-28 15:56:57Z

I've had to change a table in my database so that the primary key isn't the standard increments.Here's the migration,However, MySQL keeps returning with,I've tried leaving the normal increments id in there and modifying the table in a different migration but the same thing happens.Any ideas of what I'm doing wrong?Laveral Version 5.4.23Change it to string.

Only User Model is saving with empty Values to database

Viral Solani

[Only User Model is saving with empty Values to database](https://stackoverflow.com/questions/43249062/only-user-model-is-saving-with-empty-values-to-database)

In Laravel 5.4 when I try to save User model to the database the values are not saved. I've set the fillable property as well.It was working in Laravel 5.3. This issue is coming after upgrading the application into Laravel 5.4.Below is a User model.Please note the issue is with User Model only.I'm saving User as below.Then the create method of BaseModel will be called and below is the code of it.

2017-04-06 07:55:20Z

In Laravel 5.4 when I try to save User model to the database the values are not saved. I've set the fillable property as well.It was working in Laravel 5.3. This issue is coming after upgrading the application into Laravel 5.4.Below is a User model.Please note the issue is with User Model only.I'm saving User as below.Then the create method of BaseModel will be called and below is the code of it.The reason is most probably the new middleware in Laravel 5.4 called "Request Sanitization Middleware" as explained in https://laravel.com/docs/5.4/releases.Disable \Illuminate\Foundation\Http\Middleware\ConvertEmptyStringsToNull::class, in app/Http/kernel.php and see what you get. You can also check in /config/database.php and your mysql connection settings: 'strict' => true, if so, set to false. A good practice is using the model for user input. In this case, instead of $user = $this->model->create(...) populate you model with 

$user = new \App\User($input) and update your values from there, f.ex. 

$user->confirmation_code = md5(uniqid(mt_rand(), true)); and 

$user->password = bcrypt($user->password);If fields are nullable, indicate as such in your migration file, f.ex. $table->string('all')->nullable();If done just run $user->save();From 5.4 the create() function is not more defined in Illuminate\Database\Eloquent\Model:Is handled as dinamic method call, that is by calling one of these functions (dependig on if it's called statically or not):In the Illuminate\Database\Eloquent\Model class.Now I dont have all your code but, IMHO, I will try to change this line in your BaseModel class:to this:or, even better for me, to this:Sowhere users() is your public function but I don't know what is $this in your case but should be the model as in the example from documentation.Why you're not using resource controllers? Or if you need to populate the db use a seeder

I think It will be more easy to manage.So 2 things i can think off1st there is no need to use  protected $guarded = []; and protected $fillable = [];Guarded will assume everything is fillable if its not in here and fillable will assume everything is guarded unless in here.To quote the docs2nd to rule out any of the $this->model stuff try instantiate the class first and save themGuys I'm able to resolve issue by using Fill() method.Also By mistake I've added Construction on CanResetPassword Trait which causing issue as well. So If i remove that everything will work as before as well.Yes, you can't use __construct method in Traits.Please Refer PHP.net for more details about trait, they said "Using AS on a __construct method (and maybe other magic methods) is really, really bad."You can use trait like following way.I have created "userRelation" Trait which contains few useful code to re-use.Please refer following link for more details - http://php.net/manual/en/language.oop5.traits.phpPlease try it and let me know if it won't work.

Thanks

Sorting Laravel Collection via Array of ID's

Matthew Brown

[Sorting Laravel Collection via Array of ID's](https://stackoverflow.com/questions/28118361/sorting-laravel-collection-via-array-of-ids)

Is it possible to order a relationship collection using a separate array of ID's while still accessing through the relationship?The setup is Checklist has many ChecklistItems, and I access this relationship the normal way:Now the desired order of $item exists as a property on $list under the attribute $list->item_order, it is just an array of $item ID's in the users desired order, specific to the $list being iterated.Is there a feasible way to order the $items attached to the $list based on the item_order array that the $list model has?(I can't just add a 'order' column to the 'item' table, b/c order changes based on specific 'list' relationship).Thanks for any help!

2015-01-23 20:39:39Z

Is it possible to order a relationship collection using a separate array of ID's while still accessing through the relationship?The setup is Checklist has many ChecklistItems, and I access this relationship the normal way:Now the desired order of $item exists as a property on $list under the attribute $list->item_order, it is just an array of $item ID's in the users desired order, specific to the $list being iterated.Is there a feasible way to order the $items attached to the $list based on the item_order array that the $list model has?(I can't just add a 'order' column to the 'item' table, b/c order changes based on specific 'list' relationship).Thanks for any help!You can do this:Also you could add an attribute accessor to your model which does the sameUsage:If you need this sort of functionality in multiple places I suggest you create your own Collection class:Then, to actually use that class override newCollection() in your model. In this case it would be in the ChecklistItems class:You can try setting up a relationship that returns the results in the order for which you're looking. You should still be able to eager load the relationship, and have the results in the specified order. This is all assuming the item_order field is a comma separated string list of ids.Or, if you don't want to hardcode the tables/fields:Now, you can:Just a warning: this is fairly experimental code. It looks to work with the tiny amount of test data I have available to me, but I have not done anything like this in a production environment. Also, this is only tested on a HasMany relationship. If you try this exact code on a BelongsToMany or anything like that, you'll have issues.

Use of undefined constant MCRYPT_RIJNDAEL_128 - assumed 'MCRYPT_RIJNDAEL_128'

Philip

[Use of undefined constant MCRYPT_RIJNDAEL_128 - assumed 'MCRYPT_RIJNDAEL_128'](https://stackoverflow.com/questions/29993399/use-of-undefined-constant-mcrypt-rijndael-128-assumed-mcrypt-rijndael-128)

I have successfully installed Laravel, but after running php artisan serve and going to localhost:8000 I get this error:I have checked phpinfo() on localhost:8888 and it says that mcrypt is properly installed. However the only thing I can think of is that maybe my path is wrong?in my .bash_profile I haveEvery time I try to run Laravel commands I have to type this in the terminal:I am running on a Mac. Is there a simple way I can set up my bash_profile so that I can consistently change between localhost addresses and still have all the proper PHP functions working?

2015-05-01 19:06:00Z

I have successfully installed Laravel, but after running php artisan serve and going to localhost:8000 I get this error:I have checked phpinfo() on localhost:8888 and it says that mcrypt is properly installed. However the only thing I can think of is that maybe my path is wrong?in my .bash_profile I haveEvery time I try to run Laravel commands I have to type this in the terminal:I am running on a Mac. Is there a simple way I can set up my bash_profile so that I can consistently change between localhost addresses and still have all the proper PHP functions working?This problem relative to the PHP extensions loader.

You no need to use laravel command at all after successful installation.

Laravel framework need Mcrypt Library for the security module and encrypt some of configure file.The things that you need is theses steps.then configure make and install it.More simple way on ubuntuNote: if you don't have "/etc/php5/conf.d" just skip that step and it will work ok check http://php.net/manual/en/mcrypt.installation.php For Mac users's specially - install it using Home BrewI’ve installed an empty Laravel installation and got the following error message when navigating to http://localhost/kanban/public/:Notice: Use of undefined constant MCRYPT_RIJNDAEL_128 – assumed ‘MCRYPT_RIJNDAEL_128′ in /Library/WebServer/Documents/xxx/config/app.php on line 83Googling for this error message return many tutorials on how to install mcrypt on Mac OS X (whether building it from source or using Homebrew). The problem was that both the mcrypt and the php55-mcrypt packages were properly installed:Mcrypt was also properly loaded by PHP:for more details refer this link - http://benohead.com/mac-os-x-php-notice-use-undefined-constant-mcrypt_rijndael_128/If you are seeing this on ubuntu or other flavors of *nix , it might help to do the following:I just adjusted the .bash_profile in MacOS and it worked:I also had this problem in trying to deploy a Laravel to Apache on Mac OS Sierra. I eventually found this post that gave step-by-step instructions to resolve this issue. These instructions assume that you have Homebrew installed; if you don't have it installed, then paste the following into a Terminal window to install it:Here is the relevant steps pasted from the post given above:Step 1: Install autoconf and mcryptI used homebrew to install autoconf and mcrypt, which is as easy as:If this does not work for you, or you don't want to use homebrew, then check out this tutorial.Step 2: Build the PHP extensionTo build the PHP extension you will need the PHP 5.4.17 source code that is available for download here and extract it:Then build the extension using the following commands:Step 3: Enable the extensionAll that is left is to enable the extension by editing /etc/php.ini. If this file is not present, copy /etc/php.ini.default and rename it:Edit the /etc/php.ini file and add the following:Step 4: Restart apache

Now just restart apache and you're done!ADDITIONAL NOTES AND CLARIFICATIONI did encounter two issues with following these steps:So I didto determine the version number and then changed the download to match that version number. In my case the PHP version was 5.6.28 and so I needed to download the PHP source fromApplying the information from this answer changed the step 2 listed above and replaced the sudo make install with the following:Take note that because of this change, step 4 above also needs to changed to include the path to mcrypt.so. So the following must go in the php.ini:I use nginx and php-fpm, and already did apt-get install php5-mcrypt, and moved the mcrypt.ini file to mods-available. I had to do sudo service php5-fpm restart before it actually worked.

Multiple Policies for a Model in Laravel

AshMenhennett

[Multiple Policies for a Model in Laravel](https://stackoverflow.com/questions/41604230/multiple-policies-for-a-model-in-laravel)

Does Laravel allow us to add multiple Policies for a Model? I.e. consider App\Providers\ASuthServiceProvider's $policies property:I haven't tested it in an application, because even if it worked, I would be here asking a similar question, regarding whether this is considered bad practise or prone to unexpected behaviour.The alternative I have is a very messy Policy, containing policies relating to several controllers, named in camel case:etc. etc.

2017-01-12 02:37:23Z

Does Laravel allow us to add multiple Policies for a Model? I.e. consider App\Providers\ASuthServiceProvider's $policies property:I haven't tested it in an application, because even if it worked, I would be here asking a similar question, regarding whether this is considered bad practise or prone to unexpected behaviour.The alternative I have is a very messy Policy, containing policies relating to several controllers, named in camel case:etc. etc.The $policies variable uses the model as key and as value a policy. Keys are unique so you can only set one policy per model. However you can use a policy on multiple models.In your case the App\Policies\AnotherPolicy is the only one which will be used. Also assigning multiple models the same policy really depends on what you want to do. Basically you do not want messy or gross code. So if you create a policy for two models and the policy code becomes too large, it is time to consider if creating another policy would make the code simpler/less gross.You could use traits to separate the logic for your policy.You would create a base TeamPolicy and then multiple traits with the various methods that you would want within the base class.

Default values for Laravel 5.4+ blades new components?

Chris

[Default values for Laravel 5.4+ blades new components?](https://stackoverflow.com/questions/42966549/default-values-for-laravel-5-4-blades-new-components)

Laravel 5.4+ allows for components of the following structure:Which are called like:Is there a shorthand or blade marker to set default values for the variables passed in?For example, in the above, if I don't pass in "type" I get a undefined variable error. I could do something like:But the above feels verbose, especially if the variable is used in multiple spots. 

2017-03-23 03:07:34Z

Laravel 5.4+ allows for components of the following structure:Which are called like:Is there a shorthand or blade marker to set default values for the variables passed in?For example, in the above, if I don't pass in "type" I get a undefined variable error. I could do something like:But the above feels verbose, especially if the variable is used in multiple spots. I don't think it does. Having said that blade has the or operator that wraps the isset() call (see docs).If you're running php 7 this is a case for the Null coalescing operator.Both will make your call site tider.

Laravel timestamps to show milliseconds

raphadko

[Laravel timestamps to show milliseconds](https://stackoverflow.com/questions/31227069/laravel-timestamps-to-show-milliseconds)

I need to store updated_at timestamp with high precision on a laravel application, using the format "m-d-Y H:i:s.u" (including milisseconds)According to laravel documentation, I can customize the date format by setting the $dateFormat property on a class, but...The main problem is that Laravel's schema builder adds a column of type timestamp in the database when I use $table->nullableTimestamps() And according to mysql documentation, columns of type TIMESTAMP only allow the precision up to seconds..Any ideas on how I could achieve that?

2015-07-05 04:11:07Z

I need to store updated_at timestamp with high precision on a laravel application, using the format "m-d-Y H:i:s.u" (including milisseconds)According to laravel documentation, I can customize the date format by setting the $dateFormat property on a class, but...The main problem is that Laravel's schema builder adds a column of type timestamp in the database when I use $table->nullableTimestamps() And according to mysql documentation, columns of type TIMESTAMP only allow the precision up to seconds..Any ideas on how I could achieve that?You can't because the PHP PDO driver doesn't support fractional seconds in timestamps. A work around is to select the timestamp as a string instead so the PDO driver doesn't know its really a timestamp, simply by doing $query->selectRaw(DB::raw("CONCAT(my_date_column) as my_date_column")) however this means you can't use the default select for all fields so querying becomes a real pain. Also you need to override getDateFormat on the model.Finally in your migration rather than nullableTimestamps, outside of the Schema callback do:Note this example was for 3 decimal places however you can have up to 6 if you like, by changing the 3 to a 6 in two places, in the alter table and in the sprintf and also adjusting the multiplier * 1000 to 1000000 for 6.Hopefully some day PHP PDO will be updated to fix this, but its been over 5 years and nothings changed so I don't have my hopes up. In case you are interested in the details, see this bug report:

http://grokbase.com/t/php/php-bugs/11524dvh68/php-bug-bug-54648-new-pdo-forces-format-of-datetime-fields

I found that link in this other answer which might help you more understand the issue:

https://stackoverflow.com/a/22990991/259521PHP is really showing its age lately, and I would consider this issue one of my reasons for considering moving to the more modern Node.js.Based on malhal's answer, I was able to get fractional timestamp reading to work here.  Pasting the answer here for convenience:There is a lot going on here because it gets the query with scopes applied and then adds a select for the updated_at column to the end, which overwrites any previously loaded updated_at column later while Laravel hydrates the Model from the query. For being an ugly hack, it worked surprisingly well the very first time.Timestamps are stored internally as Carbon in Laravel:Output:Also be sure to run a migration to convert your columns to fractional timestamps. Microsecond precision raises the size of timestamps from 4 bytes to 7 bytes but this is 2017, don't let saving a byte or two by choosing millisecond precision cost you a fortune later when you find yourself serving stale cache entries:Sadly I haven't found a way to modify the migration schema timestamps() function to do this.

How to make routes in Laravel case insensitive?

Nishant Srivastava

[How to make routes in Laravel case insensitive?](https://stackoverflow.com/questions/31964973/how-to-make-routes-in-laravel-case-insensitive)

I have a project in laravel and there are many routes in that project.But i just discovered that the routes are all case sensitive, means 

/advertiser/reports is different than /advertiser/Reports . So what i want is both the routes should redirect to same view. Currently 

/advertiser/Reports gives RouteNotFound Exception.I have read about the Route::pattern() way of doing it but since there are many routes i'll have to put in a lot of efforts for that. So, what i want is a better way of doing it, if there is any.

2015-08-12 12:16:25Z

I have a project in laravel and there are many routes in that project.But i just discovered that the routes are all case sensitive, means 

/advertiser/reports is different than /advertiser/Reports . So what i want is both the routes should redirect to same view. Currently 

/advertiser/Reports gives RouteNotFound Exception.I have read about the Route::pattern() way of doing it but since there are many routes i'll have to put in a lot of efforts for that. So, what i want is a better way of doing it, if there is any.In order to make routes case-insensitive you'll need to modify the way routes are matched with the URLs. In Laravel, it all happens in UriValidator object so you'll need to create your own validator.Luckily, like most tasks in Laravel, it's not really complicated.First, create the new validator class - the only difference between this one and the original is that you'll append the i modifier at the end of regular expression for the compiled route to switch enable case-insensitive matching.Secondly, you need to update the list of matchers that are used to match URL to a route and replace the original UriValidator with yours.In order to do that, add the following at the top of your routes.php file:This will remove the original validator and add yours to the list of validators.Keep in mind that this code has not been tested by running. Let me know if there are any typos or something doesn't work as expected. I'll be more than happy to get that working for you :)I know this is an old question but I came across this same problem and I just want to share my solution.On method render(...) at Exceptions/Handler.php, catch 404 exceptions and validate the case of the URL then redirect like this: That's it.I wrote a gist which does this: https://gist.github.com/samthomson/f670f9735d200773e543Edit your app/filters.php to check for uppercase characters in the route and redirect them to a converted route.

Testing listeners with Queue::fake()

Denis Priebe

[Testing listeners with Queue::fake()](https://stackoverflow.com/questions/48083893/testing-listeners-with-queuefake)

My Laravel 5.5 application has a Product model. The Product model has a dispatchesEvents property that looks like this:I also have a listener that is called CreateProductInMagento which is mapped to the ProductCreated event in the EventServiceProvider. This listener implements the ShouldQueue interface.When a product is created, the ProductCreated event is fired and the CreateProductInMagento listener is pushed to the queue and is run.I am now trying to write a test for all of this. Here is what I have:But I get a The expected [App\Listeners\Magento\Product\CreateProductInMagento] job was not pushed. error message.How do I test queueable listeners using Laravel's Queue::fake() method?

2018-01-03 19:25:45Z

My Laravel 5.5 application has a Product model. The Product model has a dispatchesEvents property that looks like this:I also have a listener that is called CreateProductInMagento which is mapped to the ProductCreated event in the EventServiceProvider. This listener implements the ShouldQueue interface.When a product is created, the ProductCreated event is fired and the CreateProductInMagento listener is pushed to the queue and is run.I am now trying to write a test for all of this. Here is what I have:But I get a The expected [App\Listeners\Magento\Product\CreateProductInMagento] job was not pushed. error message.How do I test queueable listeners using Laravel's Queue::fake() method?The problem here is that the listener is not the job pushed to the queue. Instead, there's a Illuminate\Events\CallQueuedListener job that is queued and will in turn call the appropriate listener when resolved.So you could do your assertion like this:Running artisan queue:work won't solve the issue because when testing, Laravel is configured to use the sync driver, which just runs jobs synchronously in your tests. I am not sure why the job is not being pushed, though I would guess it has to do with Laravel handling events differently in tests. Regardless, there is a better approach you can take to writing your tests that should both fix the issue and make your code more extendable.In your ProductTest, rather than testing that a_created_product_is_pushed_to_the_queue_so_it_can_be_added_to_magento, you should simply test that the event is fired. Your ProductTest doesn't care what the ProductCreated event is; that is the job of a ProductCreatedTest. So, you can use Event Faking to change your test a bit:Then, create a new ProductCreatedTest to unit test your ProductCreated event. This is where you should place the assertion that a job is pushed to the queue:This has the added benefit of making your code easier to change in the future, as your tests now more closely follow the practice of only testing the class they are responsible for. Additionally, it should solve the issue you're having where the events fired from a model aren't queuing up your jobs. 

Laravel: Permission denied in laravel Blade File

alvincrespo

[Laravel: Permission denied in laravel Blade File](https://stackoverflow.com/questions/10840088/laravel-permission-denied-in-laravel-blade-file)

I have the following issue when trying to install Laravel http://laravel.comAny help, would be greatly appreciated.

2012-05-31 19:31:43Z

I have the following issue when trying to install Laravel http://laravel.comAny help, would be greatly appreciated.I would check that the permissions on:Allow your application to write to this directory.Assuming you are on a linux box you could run ls -l to see what the permissions are, and if it is set to read only, change the permissions with chmod.As you can see in the very good documentation under install, you have to make the directory storage/views writeable.http://laravel.com/docs/install#installationcheck the permissions of /storage directory in the laravel installation. The views directory must have write permisison for the webserver that is it.

Using multiple where clauses with laravel query builder

Dan Hastings

[Using multiple where clauses with laravel query builder](https://stackoverflow.com/questions/29342028/using-multiple-where-clauses-with-laravel-query-builder)

I'm having a lot of trouble converting the following SQL query to work with Laravel's query builder.This query works fine, but I can't get the same results when using Laravel's query builder. I have the following code so far. It is not working correctly at all. I'm thinking the issue could lie with the orWhere part because it seems to be returning results that don't match any of the other where clauses.

2015-03-30 08:55:58Z

I'm having a lot of trouble converting the following SQL query to work with Laravel's query builder.This query works fine, but I can't get the same results when using Laravel's query builder. I have the following code so far. It is not working correctly at all. I'm thinking the issue could lie with the orWhere part because it seems to be returning results that don't match any of the other where clauses.You want to use advanced where with parameter grouping:

Laravel 5.1 loading relationship data into selected row

V4n1ll4

[Laravel 5.1 loading relationship data into selected row](https://stackoverflow.com/questions/35271896/laravel-5-1-loading-relationship-data-into-selected-row)

I have a timesheet table and a user table in my database.  The following relationship is setup on the timesheet model.The above means I can get user data when I select timesheets from the database by using something like:This will load the user object in the result and if converted to an array will look like so;However, I only need first_name and last_name from the user table.  Is there a way to merge/flatten the user array with the timesheet so that it looks like this instead;I have tried to use eager loading like so;However, it results in the following output;

2016-02-08 14:21:42Z

I have a timesheet table and a user table in my database.  The following relationship is setup on the timesheet model.The above means I can get user data when I select timesheets from the database by using something like:This will load the user object in the result and if converted to an array will look like so;However, I only need first_name and last_name from the user table.  Is there a way to merge/flatten the user array with the timesheet so that it looks like this instead;I have tried to use eager loading like so;However, it results in the following output;The reason why the user relationship is null in your second example is because in order for Eloquent relationships to work, it needs the keys that tie the relationships. In other words...In order for your query to work, you need to adjust it like this:With that out of the way, if you want a flattened result, I think it's best to use joins rather than eager loading because of the nature of eager loading.This assumes that your table names are users and timesheets.Have you tried to get a listor if you wanted to perform a selectUpdate

You can also perform eager loading to eager load related objects. Here is an example Please let me know if that helps. Laravel models have a way to modify data before getting/setting an attribute. You can actually add the attributes to the model by defining a getter function. This will let you reference the user names in the same way you would the user_id or status. These functions are also great for changing date formats for a view or sanitizing form input.That's exactly what a join do. From the documentationIf you want to be more selective on your fields, you can choose what you select;As other have suggested, it might be better to use the DB query builder such asIn this case it's better to use Raw SQL or Query builder. 

Because relations made for using database data as an relational objects. 

What is the significance of Application key in a Laravel Application?

Shobi

[What is the significance of Application key in a Laravel Application?](https://stackoverflow.com/questions/49445420/what-is-the-significance-of-application-key-in-a-laravel-application)

from laravel docs What I know about application key is: If the application key is not set, generally I do get an exception. 

2018-03-23 08:37:27Z

from laravel docs What I know about application key is: If the application key is not set, generally I do get an exception. As we can see its used in EncryptionServiceProvider:So every component that uses encryption: session, encryption (user scope), csrf token benefit from the app_key.Rest of the questions can be answered by "how encryption" (AES) works, just open up Encrypter.php, and confirm that Laravel uses AES under the hood and encodes the result to base64.Further more we can see how its all done by using tinker:After decoding the result we get (you can try decode your own cookie with session):to understand above json (iv, value, mac) you need to understand AES:

Call to undefined function Illuminate\Filesystem\finfo_file()

haakym

[Call to undefined function Illuminate\Filesystem\finfo_file()](https://stackoverflow.com/questions/44929092/call-to-undefined-function-illuminate-filesystem-finfo-file)

I have the following error showing up in my laravel.log file on a website I have running. How can I pin down where the error originates from? As the stack trace is so short I am unsure where to start.I've ran a search on the site's folder using sublime's global search for when finfo_file() is used and I've used it in a helper in a test...Currently, my tests are all passing.Any ideas?

2017-07-05 14:30:23Z

I have the following error showing up in my laravel.log file on a website I have running. How can I pin down where the error originates from? As the stack trace is so short I am unsure where to start.I've ran a search on the site's folder using sublime's global search for when finfo_file() is used and I've used it in a helper in a test...Currently, my tests are all passing.Any ideas?When you are managing the server yourself you should runfrom the commandline and edit php.ini (probably located at /etc/php.ini)to contain the linedon't forget to restart the web server. Depending on your os and web stack this is something likeWhen using a shared hosting, you probably have an option in the webinterface to enable it from there. For example in directadminAdvanced features > Select PHP version And thenTick the checkbox next to fileinfoDon't forget to click saveYou are supposed to activate finfo_file() [check this link]As Michael Hamisi said, it's a method that is declared by a PECL PHP Extension named fileinfo that is commonly present on PHP installations.it is used in Laravel to get information about files especially in upload cases.you should check that the extension is enabled on your installations.

usually, when you do composer install, an error will be triggered telling you to activated the missing extension. You need to enable fileinfo extension.please refer to this : https://stackoverflow.com/a/24565508/7171624As others have already pointed out how to fix the error itself I'm going to answer your question about how you can find out where the error originates from.The error message tells us that you are not calling finfo_file() directly but that you are calling a method of Illuminate/Filesystem/Filesystem which uses it at line 254. So you need to search for where you are using this method from Illuminate/Filesystem/Filesystem.If you are not using this method directly you could be using it indirectly through a dependency of yours. In this case you would need to search in your vendor directory for the usage of the method from Illuminate/Filesystem/Filesystem.

Laravel: How to add a composite key (2 or more columns) as the $primaryKey in the related model?

Amr

[Laravel: How to add a composite key (2 or more columns) as the $primaryKey in the related model?](https://stackoverflow.com/questions/30427868/laravel-how-to-add-a-composite-key-2-or-more-columns-as-the-primarykey-in-th)

Name of the primary key column in any model in Laravel framework is idAnd I know I can change that default name like this:My question is: What if I have a composite key (2 or more columns) in the table, how do I add them as the $primaryKey? And do I really have to define them?

2015-05-24 20:14:09Z

Name of the primary key column in any model in Laravel framework is idAnd I know I can change that default name like this:My question is: What if I have a composite key (2 or more columns) in the table, how do I add them as the $primaryKey? And do I really have to define them?From the Laravel docs:Edit: I misunderstood the question. This thread might provide some answers: http://forumsarchive.laravel.io/viewtopic.php?pid=34475Specifically overriding the find() method.

What problems could I meet with Laravel 4 on PHP 5.3.3?

Alexandre Butynski

[What problems could I meet with Laravel 4 on PHP 5.3.3?](https://stackoverflow.com/questions/17062182/what-problems-could-i-meet-with-laravel-4-on-php-5-3-3)

I know that the Laravel 4 requirements are PHP >= 5.3.7 but my client must recent application server only has PHP 5.3.3. Yes, three years old version...I need more arguments to explain the situation and find a solution with him (no move, upgrade or cloud hosting).The questions are the following :[EDIT] What I know about my client configuration is : Red Hat Enterprise Linux 6.3 on VMWare virtual machine with Apache 2.2 and PHP 5.3.3.

2013-06-12 09:35:59Z

I know that the Laravel 4 requirements are PHP >= 5.3.7 but my client must recent application server only has PHP 5.3.3. Yes, three years old version...I need more arguments to explain the situation and find a solution with him (no move, upgrade or cloud hosting).The questions are the following :[EDIT] What I know about my client configuration is : Red Hat Enterprise Linux 6.3 on VMWare virtual machine with Apache 2.2 and PHP 5.3.3.Laravel 4 requires PHP 5.3.7 due to using the bcrypt algorithm when hashing passwords, which received a huge bugfix at that version.Have a look at this article for bringing the requirement of PHP for Laravel 4 down to 5.3.2: http://laravel.io/topic/39/laravel-4-easily-extendedEDIT: here is an archived version of the linked article, as the original appears to be down:

https://web.archive.org/web/20130805153640/http://laravel.io/topic/39/laravel-4-easily-extendedNOTE: some PHP versions of 5.3.3 on certain distros do have the bcrypt algorithm fix backported into them, such as RedHat. You can read on how you can test if the distro you are using is one of them here; if it is, your distro supports the fix, and in turn supports Laravel 4 out of the box.I had an experience with a remote webhost that offers several versions of php, and somehow, was set to an older default version of php.For example, I could not figure out why my migrations would not run - artisan commands failed for no apparent reason, when a nearly identical local setup worked.  Come to find out that my root folder was set to 5.2 something.  A quick chat session with the webhost guys, and they showed me how to fix.  Presto- migrations work.Much of the rest of my application worked, but the artisan functionality is a no-can-do-without for me.  Hope that helps.Also, the built-in php development web server is handy - starts with 5.4.EDIT: Here is a little more ammo for you: another specific issue I encountered:So there you have it: Entrust is one specific example of a package you cannot use without 5.4....I hope that helps someone!UPDATE: July 2013, per php.net : Please Note: This will be the last regular release of the PHP 5.3 series. All users of PHP are encouraged to upgrade to PHP 5.4 or PHP 5.5. The PHP 5.3 series will receive only security fixes for the next year.

Laravel - Reusable resource controller

Caio Kawasaki

[Laravel - Reusable resource controller](https://stackoverflow.com/questions/50182156/laravel-reusable-resource-controller)

I am modifying the CMS that I use in my projects, and recently I decided to create a controller for default actions BaseController, where all other controllers will extend this controller BaseController.The problem is: I wrote the BaseController using the Form Requests of the UserController and I have no idea how to leave these Request dynamic so that I can implement them from other controllers.Here is my default controller:Any idea how to solve this?

2018-05-04 19:48:44Z

I am modifying the CMS that I use in my projects, and recently I decided to create a controller for default actions BaseController, where all other controllers will extend this controller BaseController.The problem is: I wrote the BaseController using the Form Requests of the UserController and I have no idea how to leave these Request dynamic so that I can implement them from other controllers.Here is my default controller:Any idea how to solve this?After the comments I could understand better.

I had the same issue here and that's my workaroundShort answer:Bindings.One Route::model.And one Simple Binding for each Form Request type, using Interfaces for the Method Injection in the Controller.Long answer applied to your example:Models binding in routes/web.php:Requests bindings in the Controller Base:And the Example Controller:So the Requests interfaces would look something like:And you should use it as an interface in your Form Requests:Opinionated alternative answer:General controller base:Resource Controller Base:Resource controller for Example model:English Language file in resources/lang/en/resource.php:Portuguese Language file in resources/lang/pt/resource.php:Web Routes in routes/web.php:Request interfaces (for binding):Same for App\Http\Requests\UpdateRequestInterface and App\Http\Requests\StatusRequestInterface...Example Form Request:Same for App\Http\Requests\Example\UpdateRequest and App\Http\Requests\Example\StatusRequest...Documentation applied for this reply:Notice: This reply is for Laravel 5.6. Some code used in this reply is not supported in previews versions. If you want it for a specific version, let me know and I will try to adapt it.Any CustomFormRequest that you will use, will be an instance of FormRequest.. a class that in turn extends the Request class. So in your BaseController do this:Then in your child Controllers:}Give it a try.

Laravel 5 losing sessions and .env configuration values in AJAX-intensive applications

JustAMartin

[Laravel 5 losing sessions and .env configuration values in AJAX-intensive applications](https://stackoverflow.com/questions/31295126/laravel-5-losing-sessions-and-env-configuration-values-in-ajax-intensive-applic)

I am using Laravel 5 (to be specific,  "laravel/framework" version is "v5.0.27"), with session driver = 'file'.I'm developing on Windows 7 64 bit machine.I noticed that sometimes (once a week or so) I get unexpectedly and randomly logged out. Sometimes this happens even immediately after I log in. I have added log messages to my auth logic code, but the log code was not triggered. Laravel behaved as if it has completely lost the session file.Another, more serious issue, was that sometimes after debugging sessions (using xdebug and Netbeans) Laravel started losing also other files - .env settings, some debugbar JS files etc. The error log had messages like:This clearly signals that .env file was not read by Laravel, so it is using default settings:Losing files happened rarely, maybe once a month or so, and it always happened after debugging sessions. I always had to restart Apache to make it work again.To stress-test the system and reproduce the issues reliably, I used a quick hack in my Angular controller:It is just a basic data request from Angular to Laravel.And that was it - now I could reproduce the session losing and .env losing in 3 minutes or less.I have developed AJAX-intensive web applications earlier on the same PC with the same Apache+PHP, but without Laravel, without .env, and I hadn't noticed such issues before.While debugging through code, I found out that Laravel is not using PHP built-in sessions at all, but has implemented their own files-based session. Obviously, it  does not provide the same reliability as default PHP sessions and I'm not sure why.Of course, in real life scenarios my app won't be that AJAX-intensive, but in my experiences on some occasions it is enough with just two simultaneous AJAX requests to lose the session.I have seen some related bug reports on Laravel for various session issues. I haven't yet seen anything about dot-env, though, but it seems suffering from the same issue.My guess is that Laravel does not use file locks and waiting, thus if a file cannot be read for some reason (maybe locked by some parallel process or Apache) then Laravel just gives up and returns whatever it can.Is there any good solution to this? Maybe it is specific to Windows and the problems will go away on a Linux machine?Curious, why Laravel (or Symfony) developers haven't fixed their session file driver yet. I know that locking/waiting would slow it down, but it would be great to at least have some option to turn on "reliable sessions".Meanwhile I'll try to step through Laravel code and see if I can invent some "quick&dirty" fix, but it would be much better to have some reliable and "best practices" solution.The issue turned to be not related to locking files. I found the Laravel bug report for .env issue, which lead me to a linked report for Dotenv project which, in turn, says that it is a core PHP issue. What disturbs me is that Dotenv devs say that Dotenv was never meant to be used for production, but Laravel seems to rely upon Dotenv.In https://github.com/laravel/framework/pull/8187 there seems to be a solution which should work in one direction but some commenter says that in their case the issue was the opposite. Someone called crynobone gave a clever code snippet to try:There appeared another suggestion to use "makeMutable()" on both Dotenv and Laravel Githubs, but commenters report that this might break tests. So I tried the crynobone's code but it did not work for me. While debugging, I found out that in my case when things break down for concurrent requests, the $key cannot be found nor in getenv(), nor in $_ENV and not even in $_SERVER.

The only thing that worked (quick&dirty experminet) was to add:static::$cached[$name] = $value;to Dotenv class and then in helpers.php env() method I see that:is always good, even when $_ENV and getenv both give nothing.Although Dotenv was not meant for production, I don't want to change our deployment and configuration workflow.Next I'll have to investigate the session issues...Related Laravel bug reports (some even from version 4. and it seems, not fixed):

https://github.com/laravel/framework/issues/4576https://github.com/laravel/framework/issues/5416https://github.com/laravel/framework/issues/8172and an old article which sheds some light on what's going on (at least with session issues):

http://thwartedefforts.org/2006/11/11/race-conditions-with-ajax-and-php-sessions/

2015-07-08 14:05:43Z

I am using Laravel 5 (to be specific,  "laravel/framework" version is "v5.0.27"), with session driver = 'file'.I'm developing on Windows 7 64 bit machine.I noticed that sometimes (once a week or so) I get unexpectedly and randomly logged out. Sometimes this happens even immediately after I log in. I have added log messages to my auth logic code, but the log code was not triggered. Laravel behaved as if it has completely lost the session file.Another, more serious issue, was that sometimes after debugging sessions (using xdebug and Netbeans) Laravel started losing also other files - .env settings, some debugbar JS files etc. The error log had messages like:This clearly signals that .env file was not read by Laravel, so it is using default settings:Losing files happened rarely, maybe once a month or so, and it always happened after debugging sessions. I always had to restart Apache to make it work again.To stress-test the system and reproduce the issues reliably, I used a quick hack in my Angular controller:It is just a basic data request from Angular to Laravel.And that was it - now I could reproduce the session losing and .env losing in 3 minutes or less.I have developed AJAX-intensive web applications earlier on the same PC with the same Apache+PHP, but without Laravel, without .env, and I hadn't noticed such issues before.While debugging through code, I found out that Laravel is not using PHP built-in sessions at all, but has implemented their own files-based session. Obviously, it  does not provide the same reliability as default PHP sessions and I'm not sure why.Of course, in real life scenarios my app won't be that AJAX-intensive, but in my experiences on some occasions it is enough with just two simultaneous AJAX requests to lose the session.I have seen some related bug reports on Laravel for various session issues. I haven't yet seen anything about dot-env, though, but it seems suffering from the same issue.My guess is that Laravel does not use file locks and waiting, thus if a file cannot be read for some reason (maybe locked by some parallel process or Apache) then Laravel just gives up and returns whatever it can.Is there any good solution to this? Maybe it is specific to Windows and the problems will go away on a Linux machine?Curious, why Laravel (or Symfony) developers haven't fixed their session file driver yet. I know that locking/waiting would slow it down, but it would be great to at least have some option to turn on "reliable sessions".Meanwhile I'll try to step through Laravel code and see if I can invent some "quick&dirty" fix, but it would be much better to have some reliable and "best practices" solution.The issue turned to be not related to locking files. I found the Laravel bug report for .env issue, which lead me to a linked report for Dotenv project which, in turn, says that it is a core PHP issue. What disturbs me is that Dotenv devs say that Dotenv was never meant to be used for production, but Laravel seems to rely upon Dotenv.In https://github.com/laravel/framework/pull/8187 there seems to be a solution which should work in one direction but some commenter says that in their case the issue was the opposite. Someone called crynobone gave a clever code snippet to try:There appeared another suggestion to use "makeMutable()" on both Dotenv and Laravel Githubs, but commenters report that this might break tests. So I tried the crynobone's code but it did not work for me. While debugging, I found out that in my case when things break down for concurrent requests, the $key cannot be found nor in getenv(), nor in $_ENV and not even in $_SERVER.

The only thing that worked (quick&dirty experminet) was to add:static::$cached[$name] = $value;to Dotenv class and then in helpers.php env() method I see that:is always good, even when $_ENV and getenv both give nothing.Although Dotenv was not meant for production, I don't want to change our deployment and configuration workflow.Next I'll have to investigate the session issues...Related Laravel bug reports (some even from version 4. and it seems, not fixed):

https://github.com/laravel/framework/issues/4576https://github.com/laravel/framework/issues/5416https://github.com/laravel/framework/issues/8172and an old article which sheds some light on what's going on (at least with session issues):

http://thwartedefforts.org/2006/11/11/race-conditions-with-ajax-and-php-sessions/My personal opinion that using .env to configure Laravel is a bad decision. Having .php files that contained key:value style of configuration was much better.However, the problem you are experiencing is not PHP's fault, nor Apache's - it's most likely Windows issue.A few other things: Apache contains a module that allows PHP binary to be integrated into Apache's process or thread, called mod_php - the issue with this is that PHP is not only slow, but getting another binary integrated into an existing one is super tricky and things might be missed. PHP also must be built with thread-safety in this case. If it's not, then weird bugs can (and will) occur.To circumvent the problem of tricky integration of one program into another, we can avoid this completely and we can have .php served over FastCGI protocol. This means that the web server (Apache or Nginx) will take the HTTP request and pass it to another "web" server. In our case, this will be PHP FastCGI Process Manager or PHP-FPM.PHP-FPM is preferred way of serving .php pages - not only because it's faster (much, much faster than integrating via mod_php), but you can easily scale your HTTP frontend and have multiple machines serve .php pages, allowing you to easily horizontally scale your HTTP frontend.However, PHP-FPM is something called a supervisor process and it relies on process control. As far as I'm aware, Windows do not support process control in the way *nix does, therefore php-fpm is unavailable for Windows (in case I am wrong here, please correct me).What does all of this mean for you? It means that you should use software that's designed to play nicely with what you want to do.

This is the logic that should be followed:Now, this process while great, comes with a few issues and one huge problem here is how PHP deals with sessions. A default PHP session is a file stored somewhere on the server. This means that if you have 2 physical machines serving your php-fpm, you're going to have problems with sessions. This is where Laravel does something great - it lets you use encrypted cookie based sessions. It comes with limitations (you can't store resources in those sessions and you have a size limit), but a correctly built app wouldn't store too much info in a session in the first place. There are, of course, multiple ways of dealing with sessions, but in my opinion the encrypted cookie is super, super trivial to use and powerful. When such a cookie is used, it's the client who carries the session information and any machine that contains decryption key can read this session, which means that you can easily scale your setup to multiple servers - all they have to do is have access to same decryption key (it's the APP_KEY in the .env). Basically you need to copy the same Laravel installation to machines that you wish to serve your project.The way I would deal with the issue that you have while developing is the following:Now what you gain via this process is this: you don't pollute your Windows machine with a program that listens on ports 80 / 443, when you're done working you can just shut the VM down without losing work, you can also easily simulate how your website would behave on an actual production machine and you wouldn't have surprises such as "it works on my dev machine but it doesn't work on my production machine" because you'd have the same software for both purposes.These are my opinions, they are not all cold-facts and what I wrote here should be taken with a grain of salt. If you think what I wrote might help you, then please try to approach the problem that way. If not, well, no hard feelings and I wish you good luck with your projects.After two days of intensive debugging I have some workarounds which might be useful to others:Here is my patch for Dotenv 1.1.0 and Laravel 5.0.27 to fix .env issues:

https://gist.github.com/progmars/db5b8e2331e8723dd637And here is my workaround patch to make session issues much less frequent (or fix them completely, if you don't write to session yourself on every request):

https://gist.github.com/progmars/960b848170ff4ecd580aI tested them with Laravel 5.0.27 and Dotenv 1.1.0.Also recently recreated patches for Laravel 5.1.1 and Dotenv 1.1.1:

https://gist.github.com/progmars/e750f46c8c12e21a10ea

https://gist.github.com/progmars/76598c982179bc335ebbMake sure you add to your config/session.php for this patch to become effective.All the patches should be applied to vendor folder each time it gets recreated.Also you might want to separate the session patch out because you update session.php just once, but the other parts of the patch should be applied to vendor folder each time it gets recreated before deployment.Be warned: "It works on my machine". I really hope Laravel and Dotenv developers will come up with something better, but meanwhile I can live with these fixes.

laravel 5.2 Insert login session data to database on custom auth

Hassaan

[laravel 5.2 Insert login session data to database on custom auth](https://stackoverflow.com/questions/48140332/laravel-5-2-insert-login-session-data-to-database-on-custom-auth)

I have a custom auth login in laravel 5.2, my config for custom login isI have two auth controllers, One is laravel AuthController and other is ProviderAuthController. I have set SESSION_DRIVER=database in my env and also created a session table in my database I am getting sessions from web login but problem is that I am not able to get sessions on provider login. Is there any workaround to insert session on provider login.There is nothing in my app service providerThe route for my providerAuthcontroller are

    Route::group(['prefix' => 'provider'], function(){

2018-01-07 18:37:13Z

I have a custom auth login in laravel 5.2, my config for custom login isI have two auth controllers, One is laravel AuthController and other is ProviderAuthController. I have set SESSION_DRIVER=database in my env and also created a session table in my database I am getting sessions from web login but problem is that I am not able to get sessions on provider login. Is there any workaround to insert session on provider login.There is nothing in my app service providerThe route for my providerAuthcontroller are

    Route::group(['prefix' => 'provider'], function(){Its supposed to happen in the middlewares, not in the providers.andAlso check laravel lifecycle.I used this code to get session(just doing R&D that time). I think this  could work for you well.

Laravel 5.1 to 5.2 composer update error

