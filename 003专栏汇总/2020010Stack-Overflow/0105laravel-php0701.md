I'm trying to fetch relational data from a model where the date column is higher or equal to the current time.The date column is formated as this: Y-m-d H:i:sWhat I'm trying to do is to grab all rows where the Y-m-d H:i:s is in the future. Example: lets assume the date is 2017-06-01 and the time is 09:00:00

Then i would like got all rows where the date is in the future, and the time is in the future. Currently my code looks like this, and it's almost working but it doesn't grab the rows where the date is the current day.What am I doing wrong?

Thanks in advance.

2017-05-30 15:30:26Z

I'm trying to fetch relational data from a model where the date column is higher or equal to the current time.The date column is formated as this: Y-m-d H:i:sWhat I'm trying to do is to grab all rows where the Y-m-d H:i:s is in the future. Example: lets assume the date is 2017-06-01 and the time is 09:00:00

Then i would like got all rows where the date is in the future, and the time is in the future. Currently my code looks like this, and it's almost working but it doesn't grab the rows where the date is the current day.What am I doing wrong?

Thanks in advance.Sounds like you need to use >=, for example:Here you can use this:

Intervention Image: Save image directly from an url with original file name and ext?

Salines

[Intervention Image: Save image directly from an url with original file name and ext?](https://stackoverflow.com/questions/32828606/intervention-image-save-image-directly-from-an-url-with-original-file-name-and)

How to get the filename, when taking image from a remote server? And how to save with original size and filename?I use Intervention, (http://image.intervention.io/api/make) to build CakePHP 3 image Behavior, I want to provide an easy uploading from remote servers, and keep the original image as a source for future manipulation.EDIT I ask, is there the Intervention Image method that returns the name of the file, when taken from the remote server. I know php copy(), I can also use the CakePHP File  utilities, but it gives me the duplicate request on remote file.

2015-09-28 17:26:53Z

How to get the filename, when taking image from a remote server? And how to save with original size and filename?I use Intervention, (http://image.intervention.io/api/make) to build CakePHP 3 image Behavior, I want to provide an easy uploading from remote servers, and keep the original image as a source for future manipulation.EDIT I ask, is there the Intervention Image method that returns the name of the file, when taken from the remote server. I know php copy(), I can also use the CakePHP File  utilities, but it gives me the duplicate request on remote file.response() does not return the original filename like Salines was requesting. This should work  You can easily do it using the make(); and response(); methods. Check my code below.Just keep in mind that allow_url_fopen must be enabled to fetch a remote image.This will display my profile picture. If you are not using it with Laravel Framework, just replace return with echo.Hope that helps and upvote my reply if useful ;)If you need further help just ask.

Laravel Faker - What's the difference between create and make

Simon Suh

[Laravel Faker - What's the difference between create and make](https://stackoverflow.com/questions/44119401/laravel-faker-whats-the-difference-between-create-and-make)

I have the following code:what is the difference between create() and make() and why is it not listed in the helper functions page in the Laravel documentation? Thank you! :)

2017-05-22 18:07:56Z

I have the following code:what is the difference between create() and make() and why is it not listed in the helper functions page in the Laravel documentation? Thank you! :)create persists to the database while make just creates a new instance of the model.https://laravel.com/docs/5.4/database-testing#using-factoriesIf you'd like to see the source code differences between make and create you can see them in src/Illuminate/Database/Eloquent/FactoryBuilder.phpclick here for more info

What is a usage and purpose of Laravel's binding?

Andrii H.

[What is a usage and purpose of Laravel's binding?](https://stackoverflow.com/questions/49348681/what-is-a-usage-and-purpose-of-laravels-binding)

I cannot understand a point of Laravel's binding system. I know what does dependency injection mean. And it can work even without that weird "bindings", right? I saw in documentation, that binding can return a new object. Why and when I have to use that? Please, explain not very complicated, because I've read documentation and I could not understand the use and the purpose of that bindings. Thanks.

2018-03-18 13:58:11Z

I cannot understand a point of Laravel's binding system. I know what does dependency injection mean. And it can work even without that weird "bindings", right? I saw in documentation, that binding can return a new object. Why and when I have to use that? Please, explain not very complicated, because I've read documentation and I could not understand the use and the purpose of that bindings. Thanks.Not really. Sure it can work just fine if the required dependencies are simple to instantiate. Let's say you have this simple class Foo stored in app directory:You can type hinted this class without binding it first in the container. Laravel will still be able to resolve this class. Let's say you type-hinted it like this in the routes:We can even go further, let's say this Foo class required another simple class Bar. Our Bar class looks like this:And our Foo class looks like this now:Will Laravel be able to resolve the type-hinted Foo class now? YES! Laravel will still be able to resolve this Foo class.Now the issue will come in when our Foo class needs slightly more complex dependencies that need to be configured. Imagine that our Foo class simply need the name of our application. Sure you can simply use config('app.name') within the class's method, but imagine that this can be an HTTP client that requires a configuration array to instantiate.Will Laravel be able to solve this class now? NOPE. Service Container to the rescue! You can teach Laravel how to resolve this Foo class by binding it in service container. You can define the binding within the register method on app\Providers\AppServiceProvider.php file:And sometimes, you don't want multiple instances to be created. Like our Foo class for instance, there's no need for multiple instances for this kind of class. In this case, we can bind it with singleton method.More Important UsageBut the more important usage of this service container is that we can bind an interface to it's implementation. Let's say we have this PaymentProcessorInterface with pay method:Then we have the implementation of this interface named StripeProcessor:With service container, we can bind the PaymentProcessorInterface to StripeProcessor class:We can then type-hinted PaymentProcessorInterface within our code:This way we can easily swap the PaymentProcessorInterface implementation. Let's say we want to change the payment processor to Paypal then we have this PaypalProcessor class.All we have to do is update the binding:Hope this gives you some ideas.

How does the static password work in the default Laravel user factory?

Kim Prince

[How does the static password work in the default Laravel user factory?](https://stackoverflow.com/questions/44037895/how-does-the-static-password-work-in-the-default-laravel-user-factory)

Per this link, https://laravel.com/docs/5.4/database-testing#writing-factories, the default Laravel user factory tests the value of a static $password variable.  If it is falsey, it bcrypts 'secret' and uses that.How does one go about setting the value of the static variable $password?  Obviously I don't want to import it at the time the function is declared (since that would defeat the purpose of making it variable).  I realise that I can override the value of password by passing an array to the make() method, but this is a different thing altogether.

2017-05-18 03:00:15Z

Per this link, https://laravel.com/docs/5.4/database-testing#writing-factories, the default Laravel user factory tests the value of a static $password variable.  If it is falsey, it bcrypts 'secret' and uses that.How does one go about setting the value of the static variable $password?  Obviously I don't want to import it at the time the function is declared (since that would defeat the purpose of making it variable).  I realise that I can override the value of password by passing an array to the make() method, but this is a different thing altogether.I had the exact same question and found the answer here:See the comment at the bottomSo the static $password is not for including some password from the outside. It is just a clever trick to gain performance.

Laravel Composer sees wrong PHP Version

Miguel Stevens

[Laravel Composer sees wrong PHP Version](https://stackoverflow.com/questions/46785969/laravel-composer-sees-wrong-php-version)

I'm trying to install an older Laravel Project.When I run composer install I get the following errorWhen I run I get the following resultThis is the content of my composer.jsonHow is it possible that this project thinks I have php 5.6 running?Thank you.

2017-10-17 08:41:10Z

I'm trying to install an older Laravel Project.When I run composer install I get the following errorWhen I run I get the following resultThis is the content of my composer.jsonHow is it possible that this project thinks I have php 5.6 running?Thank you.I've had this problem too. If you don't want to update all your composer packages, you can solve this issue by manually changing the composer.lock file and writing your actual PHP version in platform > php in the JSON object.ExampleAlthough it works, the most recommended way to do this would be deleting your composer.lock file, changing the platform > php version in composer.json and then executing composer install.additional information and response to @nicohase,   Nico, you are correct when you state that composer is not using the same php executable as apache.  Why would composer ensure that php-cli meets the requirements of the other required packages?  It wouldn't and doesn't.   The user is administering composer with php-cli, which inherently means that they are compatible.  Composer is checking to ensure that the version of php that is running on the webserver and the other packages are compatible.  Now, as to why, both the method that I listed and the other post suggests, are both likely solutions. Composer caches information regarding the system, php and the packages that are installed for two reasons, 1. continuity.. 2. version history.  If composer modified its own cache files when external changes occurred, it would be difficult to know which packages versions were compatible with each other, and when.So, composer is not checking the php version when an update or install is occurring, it references its cache.  Apache likely greps any references to php versions that are being disabled by the user, it would find a reference in composer's cache files. My suggestion recommends that the cache be deleted for that reason.  Additionally, thetells composer to update itself, as opposed to the packages it manages ...at that point if php had been initially installed by way of yum/apt, and then upgraded by easy apache, the --ignore-platform-reqs flag will circumvent any rpm exclude functionality that may still exist, and allow the install or update of the composer packages. this is a config/env issue. Ideally you can have multiple php versions to test with, in apache you can swap versions like this:Whats happening here is when he runs php -v he is running php-cli which is configured to run in php7, but perhaps his apache has 5.5 enabled.

so In case it helps someone in the future, I ran into this problem while trying to run composer update from inside  PHPStorm (2017.2).  I tried the above suggestions, but none ofthem worked.  I have multiple versions of PHP installed (5.6, 7.0, 7.1) all added under PHPStorm settings, so I can switch based on project requirements.  Regardless of selected CLI interpreter setting, it always looks to PHP 7.0 when calling composer.  Running composer in a terminal outside of PHPStorm works without issue (references the path configured version, 7.1).  In my case, this feels like a PHPStorm bug.On my HostGator shared hosting, I was able to overcome this problem by creating Aliases in my .bashrc file for the php version I wanted to use:Remember to source after editing the .bashrc file: 'source ~/.bashrc'

Using Distinct in Laravel Fluent

Glenn Williams

[Using Distinct in Laravel Fluent](https://stackoverflow.com/questions/16298368/using-distinct-in-laravel-fluent)

I have this join:But it unsurprisingly returns duplicate records, so I try to use distinct(): but I want to use distinct() on a specific single field which I'd easily be able to do in SQL. It seems distinct() does not take parameters, i.e. I can't say distinct('volunteer.id').Can anyone point me to how can I remove my duplicate records? I bet this is another forehead slapper for me.

2013-04-30 11:06:34Z

I have this join:But it unsurprisingly returns duplicate records, so I try to use distinct(): but I want to use distinct() on a specific single field which I'd easily be able to do in SQL. It seems distinct() does not take parameters, i.e. I can't say distinct('volunteer.id').Can anyone point me to how can I remove my duplicate records? I bet this is another forehead slapper for me.In my project I tried distinct() and groupby() too and both of them worked:According to this, distinct() should work in your case too, just use it with get():Otherwise you don't need distinct() when you use groupby() so you could just use:

How to get next id of autogenerated field in laravel for specific table?

fico7489

[How to get next id of autogenerated field in laravel for specific table?](https://stackoverflow.com/questions/37210747/how-to-get-next-id-of-autogenerated-field-in-laravel-for-specific-table)

I am looking for something like :notDoes anybody know hot to achieve this ?

2016-05-13 13:00:24Z

I am looking for something like :notDoes anybody know hot to achieve this ?This work for me:

(PHP: 7.0 - Laravel 5.5)You need to execute MySQL query to get auto generated ID.In Laravel5, you can do as following.In Laravel5, you can do as following.Try this:This is the code snippet i used in laravel,witch will work perfectlythanks,In MySQL you can get auto generated id by this query.For PostgreSQL:The model:The result:

Laravel mail bcc

Ivan Dokov

[Laravel mail bcc](https://stackoverflow.com/questions/26774204/laravel-mail-bcc)

I am using the default Laravel Mail class to send emails.I am trying to add bcc to myself, but when I add a bcc the email is not send at all.

Here is my code:

2014-11-06 07:45:47Z

I am using the default Laravel Mail class to send emails.I am trying to add bcc to myself, but when I add a bcc the email is not send at all.

Here is my code:I have found the problem.

I didn't use the correct parameters for $message->bcc('mybcc@email.com');I had to write email AND name: $message->bcc('mybcc@email.com', 'My Name');

The same way as I use $message->to($toEmail, $toName);As Ivan Dokov said, you need to pass the email and name to the bcc function.

You could also shorten your code by doing this

Create model in a custom path in laravel

Saleh Ahmad Oyon

[Create model in a custom path in laravel](https://stackoverflow.com/questions/37251322/create-model-in-a-custom-path-in-laravel)

I want to create a model in a custom path. If i write the php artisan command like the following it will create model inside app.But i want to create the model file inside the custom made Models folder. How can i do it ?

2016-05-16 10:05:10Z

I want to create a model in a custom path. If i write the php artisan command like the following it will create model inside app.But i want to create the model file inside the custom made Models folder. How can i do it ?Just define the path where you want to create model. e.g.You can do it easily with custom directory of your Models Folder (I assume Models Folder is sub folder of App). 

Just use this command php artisan make:model Models/core then you will get your desire result.

Thanks.

Dynamic mail configuration with values from database [Laravel]

Saurabh

[Dynamic mail configuration with values from database [Laravel]](https://stackoverflow.com/questions/45146260/dynamic-mail-configuration-with-values-from-database-laravel)

I have created a service provider in my Laravel Application SettingsServiceProvider. This caches the settings table from the database.settings table:I am able to echo the value from the table like this:This works fine on any blade files or controllers in App\Http\ControllersProblem:I am trying to echo the value to App\config\mail.php like this:But I'm getting this error:Update:I have created a new service provider MailServiceProvider to override the settings in Mail.php like this:But still I am getting the same error!!Is there any way to override default mail configuration (in app/config/mail.php) on-the-fly (e.g. configuration is stored in database) before swiftmailer transport is created?

2017-07-17 13:58:07Z

I have created a service provider in my Laravel Application SettingsServiceProvider. This caches the settings table from the database.settings table:I am able to echo the value from the table like this:This works fine on any blade files or controllers in App\Http\ControllersProblem:I am trying to echo the value to App\config\mail.php like this:But I'm getting this error:Update:I have created a new service provider MailServiceProvider to override the settings in Mail.php like this:But still I am getting the same error!!Is there any way to override default mail configuration (in app/config/mail.php) on-the-fly (e.g. configuration is stored in database) before swiftmailer transport is created?Struggled for 3 days with this issue finally I figured out a way to solve it.First I created a table mails and populated it with my values.

Then I created a provider MailConfigServiceProvider.phpAnd then registered it in the config\app.phpMaybe its usefull to somebody, but I solved it as following;In a ServiceProvider under the boot-method;I used array_merge with the original config, so we only override the values we need to. Also we can use the Cache-facade in the boot-method.

Changing database name in Laravel/Homestead

Kapil Sharma

[Changing database name in Laravel/Homestead](https://stackoverflow.com/questions/25317370/changing-database-name-in-laravel-homestead)

I started learning Laravel just an hour ago and following tutorials.My settings for database are as follow (File: app/config/database.php):In mySQL on homestead, I already created laraveltest database. I also created migration file in database/migration directory with following code:and migration commands were:As displayed, table users created but in homestead database, not in laraveltest database. Can someone please tell where I went wrong and how to force laravel to use laraveltest database?Edit after first comment

File: bootstrap/start.php

2014-08-14 20:50:13Z

I started learning Laravel just an hour ago and following tutorials.My settings for database are as follow (File: app/config/database.php):In mySQL on homestead, I already created laraveltest database. I also created migration file in database/migration directory with following code:and migration commands were:As displayed, table users created but in homestead database, not in laraveltest database. Can someone please tell where I went wrong and how to force laravel to use laraveltest database?Edit after first comment

File: bootstrap/start.phpIt is most likely an issue with environments. Check that you have a database configuration file in app/config/local/, and check that it has the proper settings.If anyone finds this looking for the answer for Laravel 5 or later: It's the same as @camroncade says, but in this case it's your .env file in the project root you want to look at.I am currently dealing with this issue as well. Changed the .env file numerous times as well as the config.php file. Nothing seemed to work.

After having done some deep digging into the framework I have found an acceptable temporary workaround to the problem that does not conflict with ANY of Laravel 5.0.2's Exceptions.NOTE: I'm currently using Ampps 3.4 with php 7.0.2 phpmyadmin 4.4.15.1 on a Windows 8.1 OS.Inside of the file "ConnectionFactory.php" (located at "laravel\vendor\laravel\framework\src\Illuminate\Database\Connectors"),

scroll down to the public function make located at line 41.

Within this function you can do the following after this statement $config = $this->parseConfig($config, $name); which should be on line 43:This change will allow Laravel to continue with its normal process having no negative effect anywhere with the framework or your project. That is until this bug is fixed by the makers of Laravel or the community.Till then happy coding! =)

Configure and Test Laravel Task Scheduling

cyber8200

[Configure and Test Laravel Task Scheduling](https://stackoverflow.com/questions/40161679/configure-and-test-laravel-task-scheduling)

I'm trying to run a command every 1 minute using Laravel Task Scheduling.I've added this line to my cron tab file *   *   *   *   *   php artisan schedule:run >> /dev/null 2>&1Here is my /app/Console/Kernel.phpI've added this line $schedule->command('echo "Happy New Year!" ')->everyMinute();How do I test this ?How do I trigger my echo to display ? How do I know if what I did is not wrong ?  I'm opening to any suggestions at this moment.Any hints / suggestions / helps on this be will  be much appreciated !

2016-10-20 18:16:29Z

I'm trying to run a command every 1 minute using Laravel Task Scheduling.I've added this line to my cron tab file *   *   *   *   *   php artisan schedule:run >> /dev/null 2>&1Here is my /app/Console/Kernel.phpI've added this line $schedule->command('echo "Happy New Year!" ')->everyMinute();How do I test this ?How do I trigger my echo to display ? How do I know if what I did is not wrong ?  I'm opening to any suggestions at this moment.Any hints / suggestions / helps on this be will  be much appreciated !command() runs an artisan command. What you're trying to achieve - issuing a command to the OS - is done by exec('echo "Happy New Year!"')Testing depends on what you want to test:In this case, you don't have to. It is tested in the original framework code.Well, you can manually run php artisan schedule:run and see the output. The scheduler does not produce any output on default (>> /dev/null 2>&1). You can, however, redirect the output of the runned scripts to any file by chaining writeOutputTo() or appendOutputTo() (https://laravel.com/docs/5.1/scheduling#task-output).For more complex logic, write a console command instead (https://laravel.com/docs/5.1/artisan#writing-commands)  and use command() - this way you can write nice, testable code.If you want to unit test the scheduling of events you can use this example. It is based on the default inspire command:Building on Michiel's answer, I've used the methods contained in Illuminate\Console\Scheduling\Event to test if the event is due to run for a given date.I've mocked the current date using Carbon::setTestNow() so that any date based logic in the when() and skip() filters will behave as expected.

Laravel: Route::resource() GET & POST work, but PUT & DELETE throw MethodNotAllowedHttpException

mOrloff

[Laravel: Route::resource() GET & POST work, but PUT & DELETE throw MethodNotAllowedHttpException](https://stackoverflow.com/questions/27029025/laravel-routeresource-get-post-work-but-put-delete-throw-methodnotallo)

I'm writing a webservice API (in laravel 4.2).

For some reason, the routing to one of my controllers is selectively failing based on HTTP method.My routes.php looks like:So, when I try any of GET / POST / PUT / PATCH / DELETE methods for the

project.dev/v2/foo or project.dev/v2/foo/1234 urls, everything works perfectly.But, for some reason, only GET and POST work for project.dev/v2/foo/1234/bar. The other methods just throw a 405 (MethodNotAllowedHttpException).

(fyi, I am issuing requests via the Advanced Rest Client Chrome extension.)What's going on?

What am I missing?

2014-11-19 23:27:41Z

I'm writing a webservice API (in laravel 4.2).

For some reason, the routing to one of my controllers is selectively failing based on HTTP method.My routes.php looks like:So, when I try any of GET / POST / PUT / PATCH / DELETE methods for the

project.dev/v2/foo or project.dev/v2/foo/1234 urls, everything works perfectly.But, for some reason, only GET and POST work for project.dev/v2/foo/1234/bar. The other methods just throw a 405 (MethodNotAllowedHttpException).

(fyi, I am issuing requests via the Advanced Rest Client Chrome extension.)What's going on?

What am I missing?Solved!

The answer can be found by running php artisan routes.That showed me that DELETE and PUT/PATCH expect (require) a bar ID.

I happened to be neglecting that because there can only be one of this particular type of "bar". The easy fix it to simply add it to my URL's regardless, like project.dev/v2/foo/1234/bar/5678.For the ones who are using Laravel versions > 4.2  use this : This will give the list of routes set in your application. Check if routes for PUT and DELETE are allowed in your routes or not.

405 error is mostly because there is no route for these methods.I don't know about older Laravel versions. But I use Laravel since 5.2 and it is necessary to include a hidden method input when using put, patch or delete.Ex:Check https://laravel.com/docs/5.6/routing#form-method-spoofingJust add a hidden input field to your formAnd keep form method as post

Laravel 5 Force Download a pdf File [closed]

Ahmed Badawy

[Laravel 5 Force Download a pdf File [closed]](https://stackoverflow.com/questions/28465434/laravel-5-force-download-a-pdf-file)

Edited 

i want to Force Download a pdf File in laravel 5. 

in laravel 4 i used the following code: but in laravel 5 that doesn't work.it comes out with this error:also i tried this:same error apeared...

what can i do to force a download in laravel 5.it was a server thing. thanks any way.

you just enable this extension: php_fileinfo.dll in the php.ini file. 

then restart the server.

2015-02-11 22:05:03Z

Edited 

i want to Force Download a pdf File in laravel 5. 

in laravel 4 i used the following code: but in laravel 5 that doesn't work.it comes out with this error:also i tried this:same error apeared...

what can i do to force a download in laravel 5.it was a server thing. thanks any way.

you just enable this extension: php_fileinfo.dll in the php.ini file. 

then restart the server.Remove the headers, they're not necessary. In L5, you can do Please read the docs.

Composer & composer.lock in GIT and merge conflicts

cenob8

[Composer & composer.lock in GIT and merge conflicts](https://stackoverflow.com/questions/25728847/composer-composer-lock-in-git-and-merge-conflicts)

Here's our situation :We have 3 different Laravel projects and all 3 projects rely on our Core project.

This Core project is a separate Laravel package hosted on our private repo and is used as a dependency for other projects.Before, whenever something would change in the Core project we woud just run a composer update ourvendor/ourcorepackage on our servers for each project to pull in the core changes. However as of lately composer seems to suffer from serious memory issues when we try to run the update on our Digital Ocean staging environment with 512 MB Ram. See : https://github.com/composer/composer/issues/1898The solution I always come across is people saying that you should always run composer install on your production servers. I can relate to that in terms of security because it can be dangerous if you update to a new version of some 3rd party package that can possibly break your code. But in our case we only update our own core package so we know what we're doing but this memory issue forces us to use the composer install method because it is less memory demanding.So basically this is our current workflow :However this solution raises 2 issues :So what am I supposed to do here? Before the pull on the server remove the composer.lock file?

How should we handle the merge conflicts for the composer.lock file?It's a shame that composer update suffers from memory issues because that method seems much more logical. Just update the package you want and no hassle with the composer.lock file..Please advice how a correct workflow with GIT and composer should be in our case and how to solve the conflicts above ?Many thanks for your input

2014-09-08 16:27:54Z

Here's our situation :We have 3 different Laravel projects and all 3 projects rely on our Core project.

This Core project is a separate Laravel package hosted on our private repo and is used as a dependency for other projects.Before, whenever something would change in the Core project we woud just run a composer update ourvendor/ourcorepackage on our servers for each project to pull in the core changes. However as of lately composer seems to suffer from serious memory issues when we try to run the update on our Digital Ocean staging environment with 512 MB Ram. See : https://github.com/composer/composer/issues/1898The solution I always come across is people saying that you should always run composer install on your production servers. I can relate to that in terms of security because it can be dangerous if you update to a new version of some 3rd party package that can possibly break your code. But in our case we only update our own core package so we know what we're doing but this memory issue forces us to use the composer install method because it is less memory demanding.So basically this is our current workflow :However this solution raises 2 issues :So what am I supposed to do here? Before the pull on the server remove the composer.lock file?

How should we handle the merge conflicts for the composer.lock file?It's a shame that composer update suffers from memory issues because that method seems much more logical. Just update the package you want and no hassle with the composer.lock file..Please advice how a correct workflow with GIT and composer should be in our case and how to solve the conflicts above ?Many thanks for your inputHow can you test that a core update (or any other dependency that gets updated) doesn't break things in the projects using it if the developer don't do this step themselves?That's why the usual workflow is expecting the composer update being run on a development machine having enough RAM (i.e. probably more than 1GB set as memory limit for PHP), and the update should be triggered manually by the developer (and if triggered automatically by a continuous integration build, the memory requirements apply to this machine as well).There is no way around this memory requirement. A web server with only 512 MB RAM installed might be able to function as a staging server with barely any concurrent users present, but it shouldn't be used to update the Composer dependencies.Personally I fix the merge conflicts in the composer.lock with a very easy system: Delete the lock file and run composer update. This will update all dependencies to the latest versions that satisfy the version requirements, and create a new working composer.lock file that get's committed during the merge.I am not afraid to potentially update everything, because either it works as expected, or my tests will catch errors quickly. I do select the 3rd party packages I use carefully:This works with around 270 packages served by our local Satis instance (probably also a factor to consider when trying to reduce memory footprint - only the packages known to Composer can end up in memory: Compare the ten thousand packages potentially available on packagist.org with 270 local packages). 60 packages of the 270 are locally developed by 20 developers, and randomly releasing new versions. The update failures in the last 2 years are very rare, and should be handled like other bugs: If a tagged version is detected to be incompatible, we release a bugfix release reverting the change, and tag the original change with a new major release, if the incompatible change is necessary.So the workflow you ask for is probably like this:Merging an already committed version on another developers machine will likely show merge conflicts with composer.lock.Another approach (without doing composer update):This method will keep locks from remote branch (maybe master or develop branches), and only updates your new packages.

Laravel Input::hasFile('image') returns false even if a File is uploaded

jrenk

[Laravel Input::hasFile('image') returns false even if a File is uploaded](https://stackoverflow.com/questions/25929197/laravel-inputhasfileimage-returns-false-even-if-a-file-is-uploaded)

I have a Form field for an Image upload, which I open with 'files' => true, like so:And in my Controller I want to check if a File was uploaded and do something with it:But Input::hasFile always returns false and I don't know why.

results in:I have tested around with another picture for another User and this works fine. I don't get why this is working for some Users and for some others not.

Is there maybe some kind of Pictures that are not accepted?What other sources could be the cause of this problem?

2014-09-19 08:07:09Z

I have a Form field for an Image upload, which I open with 'files' => true, like so:And in my Controller I want to check if a File was uploaded and do something with it:But Input::hasFile always returns false and I don't know why.

results in:I have tested around with another picture for another User and this works fine. I don't get why this is working for some Users and for some others not.

Is there maybe some kind of Pictures that are not accepted?What other sources could be the cause of this problem?I solved what was wrong.

The code is fine, but the problem was some pictures were simply to big.

EDIT:

As Don't Panic pointed out, editing upload_max_filesize can solve the problem.How do you open your form? If you want your form to accept files you need so open it like this:Opening a form in the Laravel DocsI had the same problem, I checked my code and noticed that I had not the enctype="multipart/form-data" header in the form, hope that this big neglect help anyone 

Laravel : Setting dynamic routes based on access control list

user254153

[Laravel : Setting dynamic routes based on access control list](https://stackoverflow.com/questions/48758552/laravel-setting-dynamic-routes-based-on-access-control-list)

I am building REST API with JWT authentication and authorization with own logic. It's working perfectly. Now, I want to set the routes dynamically based on roles and permission. Suppose I have database structure like:Role:Permissions:Permission_roleNow, I want to create routes according to roles and permission in database.Currently my routes seems like:I don't want above routes to be hard coded. How can I get this routes from database. Something like below. But couldnot get idea how to do it.In routes file,Thank you.

2018-02-13 02:27:55Z

I am building REST API with JWT authentication and authorization with own logic. It's working perfectly. Now, I want to set the routes dynamically based on roles and permission. Suppose I have database structure like:Role:Permissions:Permission_roleNow, I want to create routes according to roles and permission in database.Currently my routes seems like:I don't want above routes to be hard coded. How can I get this routes from database. Something like below. But couldnot get idea how to do it.In routes file,Thank you.The best idea was using middleware parameter

create Middleware call CheckPermission then you have to register that middleware into your app/Http/kernel.php file thats only you need check below codeYour kernel.php fileCheckPermission.phpYour Route fileSo what you can do is make your role name accountants a value to key in the .env file and same for each and every role name.In case you want to change it in near future you can change it manually in the .env file or you can make changes in the .env file via php code writtern on one of your Laravel function.While I doubt that this is the best approach to this, but in your way of thinking you could try out this "pseudo code". I hope this expresses the basic idea. What that implies is:I'm not totally sure if you can load your middleware dynamically like this. If so, this could be a valid approach for this.In your routes.phpAdd this route at the end of all your routes.Now create a new controller called AccessController and add the below constructor and method to it.

Assuming user has a relationship with roles.Overall it is retrieving the URL and comparing it against available routes in the authenticated user's permissions. If the authenticated user has the permission which the route belongs to, Then adding appropriate middleware.Finally the redirectURI method is calling the appropriate controller method and returning the response.Remember to replace the code with appropriate namespace and relations where ever necessary. 

Laravel: Pass Parameter to Relationship Function?

user2840318

[Laravel: Pass Parameter to Relationship Function?](https://stackoverflow.com/questions/23016216/laravel-pass-parameter-to-relationship-function)

Is it possible to pass, somehow, a parameter to a relationship function?I have currently the following:The problem is that, in some cases, it does not fetch the unlocked_at column and it returns an error.I have tried to do something like:And call it as:But this does not work. Is there a way to pass parameters into that function or any way to check if the pivot_unlocked_at is being used?

2014-04-11 15:04:37Z

Is it possible to pass, somehow, a parameter to a relationship function?I have currently the following:The problem is that, in some cases, it does not fetch the unlocked_at column and it returns an error.I have tried to do something like:And call it as:But this does not work. Is there a way to pass parameters into that function or any way to check if the pivot_unlocked_at is being used?Well what I've did was just adding new attribute to my model and then add the my condition to that attirbute,simply did this.You can do more simple, and secure:When you call the relation function with the parentesis Laravel will return just the query, you will need to add the get() or first() to retrieve the resultsAnd then you can call it like:Works for the latest version of Laravel.You can simply create a scope and then when necessary add it to a builder instance.Example:User.phpAchievement.phpthen when using:You can read more about scopes at Eloquent documentation.

How to unlock the file after AWS S3 Helper uploading file?

cytsunny

[How to unlock the file after AWS S3 Helper uploading file?](https://stackoverflow.com/questions/41395252/how-to-unlock-the-file-after-aws-s3-helper-uploading-file)

I am using the official PHP SDK with the official service provider for laravel to upload an image to Amazon S3. The image is temporarily stored on my server and should be deleted after uploading. The following is the code I used to do my upload and delete.The upload is successful. I can see my image with the link return, and I can see it on the amazon console. The problem is that the delete fails, with the following error message:I am sure my file permission setting is correct, and I am able to delete my file with the section of code for uploading to S3 comment out. So it should be the problem that the file is locked during uploading the file. Is there a way I can unlock and delete my file?

2016-12-30 11:07:00Z

I am using the official PHP SDK with the official service provider for laravel to upload an image to Amazon S3. The image is temporarily stored on my server and should be deleted after uploading. The following is the code I used to do my upload and delete.The upload is successful. I can see my image with the link return, and I can see it on the amazon console. The problem is that the delete fails, with the following error message:I am sure my file permission setting is correct, and I am able to delete my file with the section of code for uploading to S3 comment out. So it should be the problem that the file is locked during uploading the file. Is there a way I can unlock and delete my file?Yes the stream upload locks the file till it finishes, Try either of 2,orWhen you're using SourceFile option at putObject S3Client opens a file, but doesn't close it after operation.In most cases you just can unset $client and/or $result to close opened files.

But unfortunately not in this case.Use Body option instead of the SourceFile.EDIT: I just noticed the string in your $temp_path begins with a "/" slash character. This beginning slash typically starts at the root directory of the website, are you sure this is the correct location? Use the getcwd() command in PHP to find out what folder PHP thinks it is inside of.I understand you believe the permissions are correct but in light of the "Permission denied" error I still believe it is telling you something relevant.I see you are trying to chown the directory, did you perhaps mean to chmod it? If you can SSH to your server and run this command you may have more luck:Or even try changing the "chown" to "chmod" in your PHP code.I'm not a PHP guy, but I'd try popping that bad boy into a stream and then passing the stream to the SDK.That way, you can explicitly close the stream and then delete the temp file.  You may even be able to eliminate the temporary file altogether and deal solely with streams, if that's allowed by your specific use-case.Looks like this SO post might set you on the right track.

What is the differences between updateOrCreate() and updateOrInsert() in Laravel

Daniel

[What is the differences between updateOrCreate() and updateOrInsert() in Laravel](https://stackoverflow.com/questions/44407210/what-is-the-differences-between-updateorcreate-and-updateorinsert-in-laravel)

Both methods seem to create a new record if not existed or update a record with provided data. Whats the difference between the two?

2017-06-07 08:18:14Z

Both methods seem to create a new record if not existed or update a record with provided data. Whats the difference between the two?updateOrCreate is method of Eloquent Builder and updateOrInsert is method of Query Builder.updateOrCreate returns model, whereas updateOrInsert returns booleanSignatures from Laravel code:updateOrCreateupdateOrInsert

「Access denied for user ''@'localhost' to database 'forge」appears randomly

cre8

[「Access denied for user ''@'localhost' to database 'forge」appears randomly](https://stackoverflow.com/questions/35187814/access-denied-for-user-localhost-to-database-forge-appears-randomly)

I have a search function for my database but sometimes I get this message:In one of ten calls I get this 500 error message, but I don't know why. The other calls give the right result..envSearch function:database.phpI haven't modified the database.php file and all other calls work great.

2016-02-03 21:12:38Z

I have a search function for my database but sometimes I get this message:In one of ten calls I get this 500 error message, but I don't know why. The other calls give the right result..envSearch function:database.phpI haven't modified the database.php file and all other calls work great.PLEASE RUN THIS COMMANDTHEN This seems to hold most of the answers : Laravel 5.2 not reading env fileRemember to not to edit your core files as one of the users said.

Just do the safe checks, clear cache, should work.Hope it helps.As a workaround you can add to your DB forge account with all privileges.Try php artisan clear:cache to clear your cache and re-configure your cache php artisan config:cache it might works for you . I had the same issue once. what I discovered was that my default connection was set to PostgreSQL instead of MySQL so I changed my  default connection in database.phpother wise do add following to your .envtry adding remaining methods in your .env file

How to send data from client to redis and then after to laravel

Mr. Engineer

[How to send data from client to redis and then after to laravel](https://stackoverflow.com/questions/46527342/how-to-send-data-from-client-to-redis-and-then-after-to-laravel)

I'm using laravel and redis for real time chat. I can fire event from my laravel and receiving that data to client side. My problem is how can i send something from client and then receive it to redis and pass it to laravelE.g How can i check if user has read the chat message.Code : Note : I'm emitting data from IOS app. 

2017-10-02 14:16:44Z

I'm using laravel and redis for real time chat. I can fire event from my laravel and receiving that data to client side. My problem is how can i send something from client and then receive it to redis and pass it to laravelE.g How can i check if user has read the chat message.Code : Note : I'm emitting data from IOS app. Redis is a key/value store engine.  You should treat it like a database.A client sends a request to a webserver that receives this request and decides what to do with it.  For requests that require server-side processing, it will pass that request to a server-side "engine" for processing, in your case, probably PHP-FPM, which then passes it to a PHP daemon that will then execute the request.Redis is not able to interpret a request in this manner.  Therefore, you must intercept the request with Laravel and then send it to Redis.  Not the other way around.If you're trying to have Laravel get the information from Redis, you'll want to use Redis' pub/sub feature.  Then you can have Laravel subscribe to Redis updates, get the updates and persist or handle the data however you want.The phpredis lib supports the pub/sub functionality.Here is an example of the PHP implementation with that lib.

https://xmeng.wordpress.com/2011/11/14/pubsub-in-redis-using-php/You can leverage Broadcasting in Laravel for the same. Also you can broadcast between multiple clients using whisper. Also there is a redis based broadcaster in it.First you need to include its package in composer.Configure the credentials in app/broadcasting.phpYou need to configure broadcasting queue as well.Sending BroadcastReceiving BroadcastInstantiate socket ID for echo [included in header as X-Socket-ID]Make sure you have echo installedCreate echo instanceListening eventsBroadcast an event to other connected clients without hitting your Laravel application at allLaravel Broadcast DocumentationI think this tutorial is what you want:Laravel 5 and Socket.io Tutorialit contains tutorial for client side and server sideyou could use: Socket.IO-Client-Swiftcheck this also: Socket.IO on iOS

Laravel scheduler not working as expected

twister_void

[Laravel scheduler not working as expected](https://stackoverflow.com/questions/54864558/laravel-scheduler-not-working-as-expected)

I build an application in laravel which suppose to fetch news using webhose.io every 4 hours for all country . It seems to work fine for sometime . But stops and restart again after sometime . I don't know how to track what is going wrong . Laravel Version Laravel Framework 5.5.45Ubuntu 16.04.5 LTS (GNU/Linux 4.4.0-142-generic x86_64)CRON Job details Kernel.phpLaravel Logs for Jobs 

Recent logs ( Which is working fine ) Log for CRON JobLOG for CRON from System logEdit : Added withoutoverlapping() Logs with time 

I found news update task is running every 4 hours but getting intreputted by other task . Logs with timeLaravel Recent Log where you can see inconsistency . Incomplete task is being done if you compare with complete task from above.

2019-02-25 10:51:53Z

I build an application in laravel which suppose to fetch news using webhose.io every 4 hours for all country . It seems to work fine for sometime . But stops and restart again after sometime . I don't know how to track what is going wrong . Laravel Version Laravel Framework 5.5.45Ubuntu 16.04.5 LTS (GNU/Linux 4.4.0-142-generic x86_64)CRON Job details Kernel.phpLaravel Logs for Jobs 

Recent logs ( Which is working fine ) Log for CRON JobLOG for CRON from System logEdit : Added withoutoverlapping() Logs with time 

I found news update task is running every 4 hours but getting intreputted by other task . Logs with timeLaravel Recent Log where you can see inconsistency . Incomplete task is being done if you compare with complete task from above.In Simple Terms 

When the CRON daemon calls the php artisan schedule:run command every minute, the Console Kernel will be booted up and the jobs you defined inside your App\Console\Kernel::schedule() method will be registered into the scheduler.The schedule() method takes an instance of Illuminate\Console\Scheduling\Schedule as the only argument, this is the schedule manager used to record the jobs you give it and decides what should run every time the CRON daemon pings it.Now moving towards your issue . as @hoseinz3 Mentioned is almost right How Laravel prevents your scheduled jobs from overlapping ?Sometimes a scheduled job takes more time to run than what we initially expected, and this causes another instance of the job to start while the first one is not done yet, for example imagine that we run a job that generates a report every minute, after sometime when the data gets huge the report generation might take more than 1 minute so another instance of that job starts while the first is still ongoing.In most scenarios this is fine, but sometimes this should be prevented in order to guarantee correct data or prevent a high server resources consumption .Laravel will check for the Console\Scheduling\Event::withoutOverlapping class property and if it's set to true it'll try to create a mutex for the job, and will only run the job if creating a mutex was possible.For more on MutexSo Laravel creates a mutex when the job starts the very first time, and then every time the job runs it checks if the mutex exists and only runs the job if it doesn't.So Laravel creates a filter-callback method that instructs the Schedule Manager to ignore the task if a mutex still exists, it also creates an after-callback that clears the mutex after an instance of the task is done.Try this snippet  Try some kind of CRON Job Monitoring system . 

You can Try Eyewitness which is very good tool to monitor Laravel Application .You have used withoutOverlapping method, based on  Laravel documentation that means when one job took longs time to run Laravel Hold new job for 24 hours by default, and after that, it tries to run that job if no job would running, and you could also change this number by passing through withoutOverlapping argument. for exampleIt means Laravel hold new command for 5 hours if there is running command after that it will try to run this again.Laravel run cron jobs synchronously, so some tasks can block other.Since cron start each minute all scheduled tasks will be started normally with few minutes delay between it without blocking each other.or

Laravel 5 / Codeception not routing correctly

delatbabel

[Laravel 5 / Codeception not routing correctly](https://stackoverflow.com/questions/29529440/laravel-5-codeception-not-routing-correctly)

I'm trying to write an API test case for a controller function using codeception, and I'm hitting an issue where the route to the controller function does not appear to be evaluated correctly, and the evaluation seems to be different depending on what I have in my test case.Here is a code sample from my test case:I have a routes.php file containing these routes:I have inserted some debug statements into my controller classes so that I can see what routes get run, like this:At the moment I have stripped down everything from my controller classes so that ONLY the debug statements are included.When I run the test case as above, I get the following debug output:... so it appears that sendPOST('register', ...) actually routes to the GET route for "/" instead of the POST route for "/register".  Outside of the test case everything works normally -- I can POST to the register routes fine, routing appears to work OK, the problem only appears inside a codeception test case.If I change the test case so that I am doing the sendGET and the sendPOST inside the same function call, for example like this:then I see this debug output:... so that by inserting the sendGET into the same function as the sendPOST, it has changed the sendPOST behaviour so that it now routes to the GET route for register instead of the GET route for index (but still won't route to the correct POST route).I have tried turning xdebug on and don't have any clues from the xdebug output as to what's going on either.

2015-04-09 03:54:00Z

I'm trying to write an API test case for a controller function using codeception, and I'm hitting an issue where the route to the controller function does not appear to be evaluated correctly, and the evaluation seems to be different depending on what I have in my test case.Here is a code sample from my test case:I have a routes.php file containing these routes:I have inserted some debug statements into my controller classes so that I can see what routes get run, like this:At the moment I have stripped down everything from my controller classes so that ONLY the debug statements are included.When I run the test case as above, I get the following debug output:... so it appears that sendPOST('register', ...) actually routes to the GET route for "/" instead of the POST route for "/register".  Outside of the test case everything works normally -- I can POST to the register routes fine, routing appears to work OK, the problem only appears inside a codeception test case.If I change the test case so that I am doing the sendGET and the sendPOST inside the same function call, for example like this:then I see this debug output:... so that by inserting the sendGET into the same function as the sendPOST, it has changed the sendPOST behaviour so that it now routes to the GET route for register instead of the GET route for index (but still won't route to the correct POST route).I have tried turning xdebug on and don't have any clues from the xdebug output as to what's going on either.I think I found the answer after a lot of command line debugging (using phpstorm):The POST register route handling function in the controller was declared like this:... requiring an instance of Request to be passed in via dependency injection.  That request contained some validation code and if for some reason the validation code could not complete (e.g. throws an exception) then the controller function never gets called -- because building the request fails.This, in browser-land, throws a 500 error but in codeception land the exception is trapped differently and it returns a redirect to / with no data.  This all happens outside of the controller function rather than inside it, so that the Log statement in the controller function never runs because the function never gets called.  The exception handler in codeception is a generic trap.The implicit suggestion is that maybe dependency injections in controllers are a bad idea.  Or, maybe, that generic exception handlers are a bad idea.

implement DDD in MVC Frameworks - PHP

Susantha7

[implement DDD in MVC Frameworks - PHP](https://stackoverflow.com/questions/42803820/implement-ddd-in-mvc-frameworks-php)

in mvc the model is a layer and it's contain all the domain business logic.

in domain driven design business logic can be divide into various building blocks like.in Domain Driven Design domain model is.developer has read Domain Driven Design, or is using Doctrine2 or Hibernate,

usually have a better focus on the domain model in DDD.in mvc frameworks model layer is overlap with domain model in DDD.it  means we can implement domain model in model folder in mvc frameworkssuch a implementations is shown below.shows how model folder is structure

2017-03-15 07:49:18Z

in mvc the model is a layer and it's contain all the domain business logic.

in domain driven design business logic can be divide into various building blocks like.in Domain Driven Design domain model is.developer has read Domain Driven Design, or is using Doctrine2 or Hibernate,

usually have a better focus on the domain model in DDD.in mvc frameworks model layer is overlap with domain model in DDD.it  means we can implement domain model in model folder in mvc frameworkssuch a implementations is shown below.shows how model folder is structureI doubt MVC pattern itself declares something special about the Domain. It operates model as a bag of properties and doesn't care how it was created and how it guards its invariants.At the same time Onion architecture states that it's important to isolate Domain out of Application Service (which MVC Framework is). So I like to place Domain layer which contains Entities, Value objects, Domain events and Aggregates to a separate module or a top-level folder. One more reason for placing Domain separately from MVC stuff is that it will allow you easier manage multiple bounded contexts, because each context needs its own module/folder.I sugget you to check out this ASP MVC project structure. It was designed by well-known DDD expert. Besides domain, please take a look at how MVC part is organized. It exploits feature slice approach which is getting more and more popular these days and I find it extremely useful.Although I'm quite new to the world of DDD, in the process of gradually migrating an application I was working on to a more DDD-oriented structure I also confronted the question of directory structure.  Piecing together the information I was able to find which wasn't entirely conceptual I came up with the following simplified directory structure, (which exists within a CRUD-oriented Laravel application), that has served me well enough:Addressing your specific concerns, repository interfaces and entities were placed within Domain folders underneath each separable component of the application (e.g. - User).  Additionally, this is where I placed any Domain events and exceptions.  Repository implementations were placed under each Infrastructure folder.  Application services are placed within a Services directory under Application directories.Leaving aside the hybrid nature of my own application (I'm using ORM-reliant DAO's/Entities, transaction scripts, and avoiding Value Objects just to name a few diversions), this may still help serve as a rough idea of a potential DDD directory structure within an MVC app.I am agree with @Zharro's suggestion.Good structure is like below:1) View part access only CoreBundle and does not change behaviour of database.2) Core part access BuisnessLogic and Entity3) BuisnessLogic part access only Entity4) Entity part access only database.I would consider the Model in MVC to be a combination of ViewModels and Commands. Incoming requests are mapped to commands that would get dispatched to a "write" layer that retrieves the appropriate aggregate and calls the appropriate method on it, then commits the transaction.ViewModels exist solely to carry data in a presentation-ready format for the user interface. You can have a very simple "read" layer that queries database views or tables and returns the results to the client. This will allow you to have a domain model that does not expose all of its state via getters and setters.Your first assumption is not correct, MVC does not really fit with DDD, a better approach would be to use the CQRS pattern.Your second assumption is also not correct, buildings blocks are not all in the domain model folder, actually, here is a good structure for your project:That way you can keep a pseudo MVC, but with the difference that View and Controller are in Interfaces package, and the Rich Model is in the domain/model package. You can only manipulate the model through Application services, and querying the model through Query services. Query services provides you fast access to model representation, and commands are sent to Application services to behave as controllers.Note the CommentAuthor class could be a Value Object, not containing the user ID of database but a unique username. Since the User aggregate root is from another package: which makes sense from a domain PointOfView. We could call it an identity (or username). This would be ideally mapped to a unique column of the User table, but would be an indexed value of the Comment table.Another option would be to use the User in the Blog package as part of the same concept which is a blog but DDD does not recommend this approach. Actually it would recommand you to put the Identity and Access in a separate bounded context, but I guess in the context of the application you are writing mapping the user as part of a Comment could be ok.In the infrastructure layer, you define your persistence provider, that way, the day you want to switch to Doctrine, only the implementation in this package must change.The application layer is responsible to manage security, span transactionnal context, and log high level events.I can provide you more insight about the inners of classes if you need some clarification. Also this might requires some infrastructure or a support framework to get it working, i'm thinking at:

PHP AWS ElastiCache Connection Failure

whobutsb

[PHP AWS ElastiCache Connection Failure](https://stackoverflow.com/questions/37306112/php-aws-elasticache-connection-failure)

Recently I just started using AWS ElastiCache for a Laravel application.  The application is running on 2 instances behind a ELB and handles about 6-10 request/second.  Everything was going fine when I launched the application but then I started to receiving connection errors to the application with high latency and timeouts.  The error messages was as follows: For my setup I'am using: To solve my issue for the time being I have installed memcached on a separate EC2 instance and have had no issues.  My question is, do I need to use AWS ElastiCache PHP Client instead of the php5-memcached to use Elasticache? I was under the impression that Elasticache was a drop in replacement for Memcached and could be used with out a problem. Thank you for the help!

2016-05-18 17:09:59Z

Recently I just started using AWS ElastiCache for a Laravel application.  The application is running on 2 instances behind a ELB and handles about 6-10 request/second.  Everything was going fine when I launched the application but then I started to receiving connection errors to the application with high latency and timeouts.  The error messages was as follows: For my setup I'am using: To solve my issue for the time being I have installed memcached on a separate EC2 instance and have had no issues.  My question is, do I need to use AWS ElastiCache PHP Client instead of the php5-memcached to use Elasticache? I was under the impression that Elasticache was a drop in replacement for Memcached and could be used with out a problem. Thank you for the help!Check what your security group settings are and set them to 0.0.0.0/32(not secure - open to everyone but a good way to test) then if that works just set it to your public ip address which you can find here https://www.whatismyip.com/what-is-my-public-ip-address/.

Trying to avoid Duplicate User's Session Records in Session Table: Laravel

Pankaj

[Trying to avoid Duplicate User's Session Records in Session Table: Laravel](https://stackoverflow.com/questions/38969510/trying-to-avoid-duplicate-users-session-records-in-session-table-laravel)

Sample data in this table looks like below: There are multiple duplicate User's Session records present in the table.In the above file path, we have below methodIt checks for Session ID.QuestionCan I avoid creation of duplicate User Session Records in Session Table? Is there any flag that do so in Session Config file? 

2016-08-16 08:00:24Z

Sample data in this table looks like below: There are multiple duplicate User's Session records present in the table.In the above file path, we have below methodIt checks for Session ID.QuestionCan I avoid creation of duplicate User Session Records in Session Table? Is there any flag that do so in Session Config file? It seems to be an error in your traitement, must be like this no ? :From your question, you want only leave one user session in database, which means one user can only login from one device, example if you already logined from chrome , then if you login from firefox, your chrome login status will be removed.To acheive this you can write a function in App\Http\Controllers\Auth\AuthController:this function will destory prvious session from database before login.

for more info you should check Trait :Illuminate\Foundation\Auth\AuthenticatesUsers

Laravel Model Factory without connection to database

user1292810

[Laravel Model Factory without connection to database](https://stackoverflow.com/questions/38882594/laravel-model-factory-without-connection-to-database)

I would like to use Laravel's Model Factory in some PHPUnit tests. The only thing I want to do is make a Model instance without saving it to database.Why the Model Factory needs connection to database? These tests must pass on CI environment without configured database.When I create Model manually by new App\Model($dataArray), tests pass and the connection is not needed.I am using Model Factory in other places, so I would like to reuse it in that tests, to avoid code duplication.I am using MongoDB and jenssegers/laravel-mongodb library, but I am guessing that it has no matter - in pure Eloquent and e.g. MySQL database, the issue would be the same.Test that works without database:My Model FactoryTest that needs database connection:Full stack trace:

2016-08-10 20:06:49Z

I would like to use Laravel's Model Factory in some PHPUnit tests. The only thing I want to do is make a Model instance without saving it to database.Why the Model Factory needs connection to database? These tests must pass on CI environment without configured database.When I create Model manually by new App\Model($dataArray), tests pass and the connection is not needed.I am using Model Factory in other places, so I would like to reuse it in that tests, to avoid code duplication.I am using MongoDB and jenssegers/laravel-mongodb library, but I am guessing that it has no matter - in pure Eloquent and e.g. MySQL database, the issue would be the same.Test that works without database:My Model FactoryTest that needs database connection:Full stack trace:I don't think this is currently possible. The make() method calls newModelInstance() which tries to set a database connection.You can review the source code yourself.Do you try using DatabaseTransactions?For exampleI normally go for creating a similar test DB and run all the tests on that DB. It ensures that your test DB type is same as production and you don't touch the production DB for running the tests.

Randomly appearing gzip headers

Kristoffer Sall-Storgaard

[Randomly appearing gzip headers](https://stackoverflow.com/questions/21547936/randomly-appearing-gzip-headers)

I have a long running script in a shared hosting environment that outputs a bunch of XMLSometimes (only sometimes) a random GZIP header will appear in my output, and the output will be terminated.For instanceor orThe switch to GZIP does not seem to hit at any particular time og byte count, it can be after 1MB of data or after 15MBThe compiled blade template at the corresponding lines are as follows--I am at my wits end, I have tried the following:When I visit other pages, no gzip encoding or headers appear, so I'm thinking this is something with the output size or output buffer.

2014-02-04 09:00:38Z

I have a long running script in a shared hosting environment that outputs a bunch of XMLSometimes (only sometimes) a random GZIP header will appear in my output, and the output will be terminated.For instanceor orThe switch to GZIP does not seem to hit at any particular time og byte count, it can be after 1MB of data or after 15MBThe compiled blade template at the corresponding lines are as follows--I am at my wits end, I have tried the following:When I visit other pages, no gzip encoding or headers appear, so I'm thinking this is something with the output size or output buffer.Did you finally find out where these headers come from? I mean apache or php?You can simulate xml generator scipt with something like: If you won't see any headers, I suggest to debug your xml generator. You can try to call header_remove(); before output. If you see headers, you have to debug your web server. Try to disable gzip in apache by rewrite rule: Whenever you have any proxy or balancer (nginx, squid, haproxy) you automaticly get one more firing line.your gziping is not related to server output that returns your main xml body. Otherwise the whole xml would be compressed.These methods return GZIP sometimes because the source where these take the items is set to support gzip and are not asked properly.Look inside these. 

- Check web calls for all places where headers are set.

-  temporally disable compression for database connection if any.Add CDATA tags for all places where binary data could be returned to avoid main xml body building termination. Wait for an xml with bin data, Save bin data, unzip it and look what is inside. :-)This is more of a set of comments, but it is too long for the comment box.First, this very likely NOT an output buffer issue. Even though <![CDATA[ and  ]]> is not within PHP tags this doesn't mean that it doesn't pass through PHP's output buffer. To be clear, anything within a .php file will be placed in the PHP output buffer. The content within a .php file (including static content) is buffered outside of Apache and then passed back to Apache through this buffer when the script is finished. This means that your problem must lie within the code itself, which is a shot in the dark to solve without viewing the code.My suggestions:1) do a search within the script to find any instances of gz functions (gzcompress, gzdeflate, gzdecode, etc). I have seen scripts compress content if it was greater than a specific size and then decompress the content on the fly when taken from the DB. If that is the case you are likely dealing with a faulty comparison operation. In short, the logic within compression and decompression conditions is slightly off so it is failing to decompress SOME of the content.2) do a search within the script to see how this data is fetched. Is it all from a database? Does any of it come from a stream? Is any of it fetched remotely? These questions might not directly lead to an answer but are vital. It can safely be assumed that these variables are being set with data already compressed when it shouldn't be. It requires knowing where/why/how the compression is taking place in order to answer why it is not being decompressed.3) It matters greatly that it is working as expected on one system but not the other. The only times I have seen this happen was always due to differences in configuration. What operating system was your local machine using? What's the difference in local database (if any), what extensions might be missing/present on one or the other, possibly causing a function to fall back on different procedure on the two different machines.EDIT:

Also, and this is a small chance, but are you dealing with data that originated from an SQL dump from a different server? You said it works on your local host but not on a different host, so we know your dealing with two machines. Was there a third at some point? If so, it might have been compressed using a mismatched version/form of compression, or might be an issue with encoding.

Laravel: Working a large number of tasks into a queue

haakym

[Laravel: Working a large number of tasks into a queue](https://stackoverflow.com/questions/35648386/laravel-working-a-large-number-of-tasks-into-a-queue)

I'm building a web application using Laravel 5 that creates links to the web application that when visited show a form for a student's progress report. These links are sent by the web application to an email of a contact at the institution the student attends in order for the recipient to complete the progress report accessed by the link in the email.The problem I face is when creating and sending links. I have some code which works fine with a couple of hundred students, however in real world use the application would be potentially creating and sending 3000+ or so links at one time. The code I've written simply can't handle such a large number in a timely manner and the application crashes. Strangely enough though I don't receive any timeout error via laravel (I'll need to double check the php logs).Although I'm more than welcome to other suggestions, I believe the answer to the problem is utilising queues. I have already used queues when sending email (see code), but I would like to work some other parts of the code into queues, but I'm a bit unsure how to do this!Brief database schemaStudent hasMany LinkStudent hasMany InstitutionContact (limited to two by my application)Link hasMany InstitutionContact (limited to two by my application)Email manyToMany LinkWhat I am trying to accomplishSo the main challenge I'm facing is performing the aforementioned task with a large dataset. I have already considered creating and sending a Link one by one via a queue, however this wouldn't allow me to group all the Links together by contact/email. As the task wouldn't be performed regularly I would be open to consider performing the task as it is with an increase in memory and time for the process, however I didn't have much success when attempting this using set_time_limit(0); and ini_set('memory_limit','1056M'); before sending any links.Any help would be really appreciated, thank you if you read this far!Codeapp\Http\Controllers\LinkController.phpapp\Models\Link.phpapp\Emails\LinkEmailer.php

Edit 1I've got this working now with set_time_limit(0); and ini_set('memory_limit','1056M'); it took 8 mins to do 3000 students. Edit 2I'm running Laravel Framework version 5.1.6 (LTS), MySQL for DB.Edit 3Appreciate all the answers so far, thank you all. I am thinking that I may work the link creation process into a queue which will have a related entity in the database called something like Batch and when that Batch of links has finished being created then group all the Links from that Batch and send them.I could use the approach that @denis-mysenko suggested by having a sent_at field in the Links table and have a scheduled process to check for Links that haven't been sent and then send them. However, using the aforementioned approach I can send the Batch of Links when they've all finished being created, whereas with the sent_at approach with a scheduled process looking for Links that haven't been sent it could potentially send some links when all the links haven't been created yet.

2016-02-26 09:51:14Z

I'm building a web application using Laravel 5 that creates links to the web application that when visited show a form for a student's progress report. These links are sent by the web application to an email of a contact at the institution the student attends in order for the recipient to complete the progress report accessed by the link in the email.The problem I face is when creating and sending links. I have some code which works fine with a couple of hundred students, however in real world use the application would be potentially creating and sending 3000+ or so links at one time. The code I've written simply can't handle such a large number in a timely manner and the application crashes. Strangely enough though I don't receive any timeout error via laravel (I'll need to double check the php logs).Although I'm more than welcome to other suggestions, I believe the answer to the problem is utilising queues. I have already used queues when sending email (see code), but I would like to work some other parts of the code into queues, but I'm a bit unsure how to do this!Brief database schemaStudent hasMany LinkStudent hasMany InstitutionContact (limited to two by my application)Link hasMany InstitutionContact (limited to two by my application)Email manyToMany LinkWhat I am trying to accomplishSo the main challenge I'm facing is performing the aforementioned task with a large dataset. I have already considered creating and sending a Link one by one via a queue, however this wouldn't allow me to group all the Links together by contact/email. As the task wouldn't be performed regularly I would be open to consider performing the task as it is with an increase in memory and time for the process, however I didn't have much success when attempting this using set_time_limit(0); and ini_set('memory_limit','1056M'); before sending any links.Any help would be really appreciated, thank you if you read this far!Codeapp\Http\Controllers\LinkController.phpapp\Models\Link.phpapp\Emails\LinkEmailer.php

Edit 1I've got this working now with set_time_limit(0); and ini_set('memory_limit','1056M'); it took 8 mins to do 3000 students. Edit 2I'm running Laravel Framework version 5.1.6 (LTS), MySQL for DB.Edit 3Appreciate all the answers so far, thank you all. I am thinking that I may work the link creation process into a queue which will have a related entity in the database called something like Batch and when that Batch of links has finished being created then group all the Links from that Batch and send them.I could use the approach that @denis-mysenko suggested by having a sent_at field in the Links table and have a scheduled process to check for Links that haven't been sent and then send them. However, using the aforementioned approach I can send the Batch of Links when they've all finished being created, whereas with the sent_at approach with a scheduled process looking for Links that haven't been sent it could potentially send some links when all the links haven't been created yet.If you've tested your code with a small amount of data and it succeeds without crashing, it's clear that the problem is (as you said) the quite high number of records you're dealing with. Why don't you process your collection with the chunk method?Accordingly to the Laravel docs: Anyway, I think the use of a queue it's required in this kind of scenarios. I believe that working on a large set of data on a HTTP request should be absolutely avoided due to the high risk of request timeout. The queued process doesn't have the limit of execution time.Why don't you use the queue AND the chunk method on your collection together? This will make you able to:The Laravel docs covers all you need: Eloquent - Retrieving multiple models (see the "Chunking results" chapter for going deeper on how to save memory when dealing with a large data set) and Queues for creating jobs and detach some parts of your software that should not run under your webserver, avoiding the risk of timeoutsI would propose to change the architecture. I think it's unnecessarily overcomplicated.Controller could like like:Why keep so many fields in Link model that already exist in Student model and are accessible via student() relationship? You could just keep the status and the token (I assume it's part of the link?), as well as 'sent_at' timestamp. If links are usually sent only once, it's reasonable to keep the email body and subject there as well.If student updates his institution contacts, fresh data will be used at the time of email composition because you are not linking links to institution contacts explicitly.Then, I would create a command (let's say newLinkNotifier) that would run, for instance, every 10 minutes and that would look for links that haven't been sent yet ($links->whereNull('sent_at')), group them by email ($link->student->institutionContacts) and email content ($link->email_body, $link->email_subject) and create queued email jobs. Then a queue worker would send those emails (or you could set queue to 'async' to send them right away from the command).Since this command will run async, it doesn't really matter if it takes 5 minutes to finish. But in real life, it would take less than a minute for thousands and thousands of objects.How to do the grouping? I would probably just rely on MySQL (if you are using it), it will do the job faster than PHP. Since all 3 fields are accessible from SQL tables (two directly, another from JOIN) - it's actually a pretty simple task.In the end your emailers send() method will become as trivial as:This is not perfect yet, and I haven't tested this code - I wrote it right here, but it shows the proposed concept.If you don't plan to get millions of entries - this is probably good enough. Otherwise, you could move link creation into a separate async job as well.Assuming you're running version 5.0, how about passing off that initial processing to the queue as well?app\Http\Controllers\LinkController.phpapp\Console\Commands\CreateActiveLinks.php (queued job)Queuing Commands in Laravel 5.0In 5.1 forward, these are called Jobs and work a little differently.This code is untested, and I don't have a firm grasp on your application structure, so please don't take it as gospel.  It's just based on work I've done in my own application when faced with similar circumstances.  Maybe this will at least give you some ideas.  If you really have a lot of records, then adding the chunk() method in the CreateActiveLinks class query might be helpful.I have found out that creating an Event/Listener and them implementing queue is a lot more easier. All you have to is to create an Event and Listener for your email process(LinkEmailer) and then implement ShouldQueue interface as mentioned in the documentation.https://laravel.com/docs/5.1/events#queued-event-listeners

Laravel check for unique rule without itself in update

user3714582

[Laravel check for unique rule without itself in update](https://stackoverflow.com/questions/28198897/laravel-check-for-unique-rule-without-itself-in-update)

I am having my validation rules for unique in the update section.In inserting or adding the unique rule is 'Email' =>  array('unique:driver_details'), and it will check for the unique coloumn. But this fails for the update section. While updating it satisfies the other rules and in the unique of email it is checking itself for the unique coloumn  and it fails but seeing its own field.So, how can i check for the unique except its own value in the database ?

2015-01-28 17:43:50Z

I am having my validation rules for unique in the update section.In inserting or adding the unique rule is 'Email' =>  array('unique:driver_details'), and it will check for the unique coloumn. But this fails for the update section. While updating it satisfies the other rules and in the unique of email it is checking itself for the unique coloumn  and it fails but seeing its own field.So, how can i check for the unique except its own value in the database ?This forces to ignore specific id:replace segments table, email_column_to_check, id_to_ignore in above exampleYou could check it here http://laravel.com/docs/4.2/validation#rule-uniqueFor those using Laravel 5 and Form Requests, you may get the id of the model of the Route-Model Binding directly as a property of the Form Request as $this->name_of_the_model->id and then use it to ignore it from the unique rule.For instance, if you wanted to have unique emails, but also allow an administrator to edit users, you could do:Route:Controller:Form Request:Please note that we are ignoring the user that is being edited, which in this case could be different than the authenticated user.Include Rule by writingand write your validation code as follows:Here $id is the id of the email that you want to ignore during validation which is obtained from the controller.I am using Laravel 5.2if your primary key is named 'id'

table name is users_table and I want to update user_name

so I do it this wayif your primary key is not named 'id'

In my case my primary key is user_id and table name is users_table and I want to update user_nameso I do it this wayThis took me a while to figure out but when you are dealing with update/create requests you also have access to the request object. Here I am enforcing that client names are unique but allowing currently edited client.Been facing this issue for a while also. Try this:Works on Laravel 5.8. I don't know if it does work on lower versions of Laravel.In Laravel 6 app it helped me to exclude current user's email from validation:Try this$this->id will be the value from your request

Using JavaScript to display Laravel's Variable

Sylar

[Using JavaScript to display Laravel's Variable](https://stackoverflow.com/questions/29308441/using-javascript-to-display-laravels-variable)

In my code I am using typeahead.js. I use Laravel 5 and I need to replace the var states with my {{ $jobs }} variable. I need to list all Job Titles as an array.In my controller I haveI know the loop method in javascript but I dont know how to "link" my blade's variable in the javascript. Anyone knows how to?I have tried, in my.jsBut that wont work.

2015-03-27 19:10:20Z

In my code I am using typeahead.js. I use Laravel 5 and I need to replace the var states with my {{ $jobs }} variable. I need to list all Job Titles as an array.In my controller I haveI know the loop method in javascript but I dont know how to "link" my blade's variable in the javascript. Anyone knows how to?I have tried, in my.jsBut that wont work.For more complex variable types like arrays your best bet is to convert it into JSON, echo that in your template and decode it in JavaScript. Like this:Note that PHP has to run over this code to make it work. In this case you'd have to put it inside your Blade template. If you have your JavaScript code in one or more separate files (which is good!) you can just add an inline script tag to your template where you pass your variables. (Just make sure that it runs before the rest of your JavaScript code. Usually document.ready is the answer to that)If you don't like the idea of doing it like this I suggest you fetch the data in a separate ajax request.This works for meJust to add to above :var jobs = JSON.parse("{{ json_encode($jobs) }}");will return escaped html entities  ,hence you will not be able to loop over the json object in javascript , to solve this please use below :var jobs = JSON.parse("{!! json_encode($jobs) !!}");or var jobs = JSON.parse(<?php echo json_encode($jobs); ?>);this approach work for me:and use in java script in laravel 6 this works for meusing laravel blade directivealso used @json directive using php style I just solved this by placing a reference on the window Object in the <head> of my layout file, and then picking that reference up with a mixin that can be injected into any component..envconfig/geodata.phpresources/views/layouts/root.blade.phpresources/js/components/mixins/geodataUrl.jsusageIf you want, you can use a global mixin instead by adding this to your app.js entrypoint:I would not recommend using this pattern, however, for any sensitive data because it is sitting on the window Object.I like this solution because it doesn't use any extra libraries, and the chain of code is very clear. It passes the grep test, in that you can search your code for "window.geodataUrl" and see everything you need to understand how and why the code is working.That consideration is important if the code may live for a long time and another developer may come across it.However, JavaScript::put([]) is in my opinion, a decent utility that can be worth having, but in the past I have disliked how it can be extremely difficult to debug if a problem happens, because you cannot see where in the codebase the data comes from.Imagine you have some Vue code that is consuming window.chartData that came from JavaScript::put([ 'chartData' => $user->chartStuff ]). Depending on the number of references to chartData in your code base, it could take you a very long time to discover which PHP file was responsible for making window.chartData work, especially if you didn't write that code and the next person has no idea JavaScript::put() is being used.In that case, I recommend putting a comment in the code like:Then the person can search the code for "JavaScript::put" and quickly find it. Keep in mind "the person" could be yourself in 6 months after you forget the implementation details.It is always a good idea to use Vue component prop declarations like this:My point is, if you use JavaScript::put(), then Vue cannot detect as easily if the component fails to receive the data. Vue must assume the data is there on the window Object at the moment in time it refers to it. Your best bet may be to instead create a GET endpoint and make a fetch call in your created/mounted lifecycle method.I think it is important to have an explicit contract between Laravel and Vue when it comes to getting/setting data.In the interest of helping you as much as possible by giving you options, here is an example of making a fetch call using ES6 syntax sugar:routes/web.phpapp/Http/Controllers/UserController.phpAnywhere in Vue, especially a created lifecycle method:That example assumes your Vue component is a Mealy finite state machine, whereby the component can only be in one state at any given time, but it can freely switch between states.I'd recommend using such states as computed props:With markup such as:

How to fix in laravel 5.2 zizaco entrust:migration class name validation?

Noproblem

[How to fix in laravel 5.2 zizaco entrust:migration class name validation?](https://stackoverflow.com/questions/34529621/how-to-fix-in-laravel-5-2-zizaco-entrustmigration-class-name-validation)

I have followed zizac/entrust installation tutorial from GitHub Link and faced  with error:MigrationCommand.php file url : LinkOutut: the command: php artisan vendor:publish was successful.File : config/entrust.php exist.I didin't change any options to config/auth.php file same as - auth.php. How to fix it?         

2015-12-30 12:31:20Z

I have followed zizac/entrust installation tutorial from GitHub Link and faced  with error:MigrationCommand.php file url : LinkOutut: the command: php artisan vendor:publish was successful.File : config/entrust.php exist.I didin't change any options to config/auth.php file same as - auth.php. How to fix it?         in vendor/zizaco/entrust/src/commands/MigrationCommand.php on line 86remove line :add line :and config/auth.php file write provider line as like me : then your problem will solve : happy coding In vendor/zizaco/entrust/src/commands/MigrationCommand.php on line 86.Laravel 5.1.* Add LineLaravel 5.2.* Add LineThe accepted answer may fix the problem but it is very bad practice to edit direct vendor files. The following will fix the issue you may be having and will support your app still working if you decide to update Entrust and they fix their codebase.Add the following lines to config/auth.php underneath:Laravel 5.1 - 5.4Once Entrust rolls out an update you can remove this or keep it. Up to you.Try running:to make sure your application is using fresh config filesEDITOk, now I see, this library want to use:but there is no something like this in auth any more.So as temporary workaround you should probaby add table and model to auth file like so: https://github.com/laravel/laravel/blob/5.1/config/auth.phpand wait until Entrust will be upgraded to remove this

Getting selected values from a multiple select form in Laravel

SUB0DH

[Getting selected values from a multiple select form in Laravel](https://stackoverflow.com/questions/15358227/getting-selected-values-from-a-multiple-select-form-in-laravel)

For generating a drop-down list with an item selected by default, the following is done:So I generated a drop-down list that has more than one item selected by default, in the following way:But how do I get the more than one selected values?Input::get('size') returns only the last selected string.

2013-03-12 10:05:18Z

For generating a drop-down list with an item selected by default, the following is done:So I generated a drop-down list that has more than one item selected by default, in the following way:But how do I get the more than one selected values?Input::get('size') returns only the last selected string.First, if you want to have multiple item selected by default, you have to give an array of values as 3rd parameter, not a simple value.Exemple:should show the select with S and M selected.For the second point, you should try to give a name like size[] instead of size, it could be solve the problem (because your posted select is not a simple value, its an array of values)Usual Select statements go  And the workflow is that Laravel gets the form elements by their name. 

To make it work, change the name to an array. This will make laravel get the values of select as an array of data. According with https://laravelcollective.com/docs/5.2/html#drop-down-listsBy the way, please notice dropdown's name (size[]) if you want to be able to use this field as array in your backend.Things get tricky when you want uses relationships as value, for instance So $user->colors will return something likeYou could do something like, remember User Model have a sizes relationship of one to many with SIZE Model Hope it helps

Pinging test.dev after Laravel Valet install returns「Unknown Host」

Nate Ritter

[Pinging test.dev after Laravel Valet install returns「Unknown Host」](https://stackoverflow.com/questions/37719851/pinging-test-dev-after-laravel-valet-install-returns-unknown-host)

Update: Don't use ".dev". When this was originally posted in 2016, it was fine. Now it's not. Start by changing your TLD to somethinge else like ".localhost" or whatever. (This change would not have fixed my issue, but it might fix yours if you're still using ".dev").Problem: I've installed Laravel Valet and it all seems to be working except when I ping test.dev (which just contains an index.htm file and is located in ~/Sites), after hanging for a long time I get the response ping: cannot resolve test.dev: Unknown hostHere's what I've already done:Now, in addition to all this, I decided to try all the valet arguments out. valet share seemed to bork with an error at one point, which is interesting but I'm not sure it has anything to do with the original issue. ERROR:  Tunnel 'command_line' specifies invalid address 'test.dev:80': unexpected '[' in address test.dev:80After this I get 21 lines of Failed to connect to 127.0.0.1 port 4040: Connection refused and then an exception: 

2016-06-09 07:47:45Z

Update: Don't use ".dev". When this was originally posted in 2016, it was fine. Now it's not. Start by changing your TLD to somethinge else like ".localhost" or whatever. (This change would not have fixed my issue, but it might fix yours if you're still using ".dev").Problem: I've installed Laravel Valet and it all seems to be working except when I ping test.dev (which just contains an index.htm file and is located in ~/Sites), after hanging for a long time I get the response ping: cannot resolve test.dev: Unknown hostHere's what I've already done:Now, in addition to all this, I decided to try all the valet arguments out. valet share seemed to bork with an error at one point, which is interesting but I'm not sure it has anything to do with the original issue. ERROR:  Tunnel 'command_line' specifies invalid address 'test.dev:80': unexpected '[' in address test.dev:80After this I get 21 lines of Failed to connect to 127.0.0.1 port 4040: Connection refused and then an exception: The problem ended up being something to do with dnsmasq.  Using the very thorough this answer to another related SO post, I ended up doing the following to solve my issue:brew unlink dnsmasqbrew install dnsmasqbrew prunebrew services restart dnsmasqvalet installThen, just to test before I did a ping, I did dig test.dev and the response included: I'm not sure why the IP is 127.0.53.53 and not 127.0.0.1 but when I did a ping test.dev it did return ...Browsing to test.dev worked as well.  One thing to note that I haven't looked into yet is that index.htm is not recognized by valet/caddy as a potential index file.  Not part of the issue, but something interesting to note.I had the same problem, some brew services were stopped, running this command fixed it:I had everything set up correctly, but had the same issue - could not get the app.dev running.After runningI noticed that all services except dnsmasq were running as "root", but dnsmasq was running on my user.Stopped dnsmasq withand started it with:This worked for me, after a few hours of frustration.Nothing mentioned above helped me on macos sierra, but one little remark did: Avoiding '.dev' and using '.devel' did the trick for me, probably needed if you are on google's 8.8.8.8 dns *.dev does not work anymore since it is a real TLD. So use something else like *.test or *.local.Also don't forget to add http:// or https:// to your domain like http://blog.test for the first time when you open in the browser. Otherwise it will go to your default search engine.If you're just getting started with Laravel and following the Laracast tutorials, make sure to also read the latest documentation.In Laravel 5.6 and Valet 2.0.12 the *.dev domains were replaced by *.test, as you can see in here: https://laravel.com/docs/5.6/valet#installationFor me somehow a syntax error sneaked into the dnsmasq.conf which would prevent it from starting up correctly. To check this I did dnsmasq --test which gave the following output dnsmasq: bad option at line 1 of /usr/local/etc/dnsmasq.conf I fixed the typo on line 1 and did restarted all services with brew services restart --allAfter that, I can ping again to .dev domains and it works in my browserHope this will help some one!

Laravel create or update without two queries

mpen

[Laravel create or update without two queries](https://stackoverflow.com/questions/23315949/laravel-create-or-update-without-two-queries)

I'm trying to use one form for both creates and updates. Both actions save through this method:How can I rewrite this line:So that it doesn't fetch the object from the database first? There's no need for that; I'm not doing anything with it. It should either issue a INSERT if Input::get('id') is set, or an UPDATE if it's not.

2014-04-26 20:08:30Z

I'm trying to use one form for both creates and updates. Both actions save through this method:How can I rewrite this line:So that it doesn't fetch the object from the database first? There's no need for that; I'm not doing anything with it. It should either issue a INSERT if Input::get('id') is set, or an UPDATE if it's not.If you have all fields unguarded in your model, I think you can do it like this:If you have some guarded fields, then you can unguard it first:The reguard() call is not actually needed if you don't do anything else with the model.This is what I use:The second parameter is an array of the data for the model you want to save.I used to have this problem and created an accepted pull request on Laravel which you can use. Try the code below. The method you will basically need is the findOrNew.My model uses self validation but you can create your own validation like the one you have now.Find or New based on primary key idFirst or New based on non-primary key single filedFirst or New based on non-primary key multiple filedIf you are following the resource router methodology of laravel, you should use a separate method named update to update your model, so the separation can be done by the framework. With this it is still possible to reuse your form.If you really want to avoid a new method to update the model, you could rewrite it as follows:You may try this:If $data contains an id/primary key it'll be updated otherwise insert will be performed. In other words, for updating, you need to pass the id/primary key in the $data/attributes with other attributes and second argument in the newInstance method must be true.If you pass false/default to newInstance method then it'll perform an insert but $data can't contain an id/primary key. You got the idea and these three lines of code should work. $isSaved will be a Boolean value, true/false.If $data contains id/primary key then it'll be updated, otherwise an insert will be performed.

Laravel 5 InvalidArgumentException in FileViewFinder.php line 137: View [.admin] not found

deep singh

[Laravel 5 InvalidArgumentException in FileViewFinder.php line 137: View [.admin] not found](https://stackoverflow.com/questions/31262069/laravel-5-invalidargumentexception-in-fileviewfinder-php-line-137-view-admin)

This is student.php and my function for admin:routes.phpThis is admin form:Don't know why showing error:

2015-07-07 07:13:32Z

This is student.php and my function for admin:routes.phpThis is admin form:Don't know why showing error:A view should an extension .blade.php.So your file that has the admin form should have the name admin.blade.phpNote : If you have the view under any sub directory like somefolder/admin.blade.phpThen you should do like this return \View::make('somefolder/admin');Learn more about templating here :)If you recently deployed you project to your production server or moved the project to another server, do not forget to clear the app cache by running these commands.it should fix it.Also consider updating your .env file to match new environment variables.If any of the answers above do not work. why don't you try modifying the name of config.php project/bootstrap/cache/config.php to another name like config.php.old  it worked for me with laravel 5.3I had the same problem because I had a backslash \, the solution was change it to slash:You don't want to reference your views beginning with a slash.This:return \View::make('/admin');Should look like:return \View::make('admin');Please check first that  folder is under views folder

i.e resources/views/foldername/filenamethen you can testLaravel has an authentication skeleton generator which might have been previously used prior to your current state in your project. I had this error and I was coming from a git clone that had Laravel extra's omitted from sharing good practices.By reissuing the command https://laravel.com/docs/5.6/authentication#introduction

Laravel 5.4: Class 'App\Http\Controllers\Response' not found error

Tartar

[Laravel 5.4: Class 'App\Http\Controllers\Response' not found error](https://stackoverflow.com/questions/44506361/laravel-5-4-class-app-http-controllers-response-not-found-error)

I am following the Laracast's API tutorial and trying to create an ApiController that all the other controllers extend. ApiController is responsible for response handling.And i also have a ReportController that extends ApiController.When i try to call respondNotFound method from ReportController i geteventhough i add use Illuminate\Support\Facades\Response;to parent or child class i get the error. How can i fix this ?Any help would be appreciated.

2017-06-12 18:28:44Z

I am following the Laracast's API tutorial and trying to create an ApiController that all the other controllers extend. ApiController is responsible for response handling.And i also have a ReportController that extends ApiController.When i try to call respondNotFound method from ReportController i geteventhough i add use Illuminate\Support\Facades\Response;to parent or child class i get the error. How can i fix this ?Any help would be appreciated.Since it's a facade, add this:Or use full namespace:Or just use helper:

Laravel 4.1: How to paginate eloquent eager relationship?

user991

[Laravel 4.1: How to paginate eloquent eager relationship?](https://stackoverflow.com/questions/20913606/laravel-4-1-how-to-paginate-eloquent-eager-relationship)

There was question about old L3 eager loaded paginations, not using eloquent. But i want to use eloquent to get eager loaded relationship with pagination.Main model: Topic that has one to many relationship with Posts,

So that one Topic has many Posts. I get all data with this function:And later I make loop to display all results, but they are not paginated:So, i could make a workaround and select separately all posts that has $id of topic and use ->paginate() instead of ->get() and would got paginated $pots, 

2014-01-03 22:10:00Z

There was question about old L3 eager loaded paginations, not using eloquent. But i want to use eloquent to get eager loaded relationship with pagination.Main model: Topic that has one to many relationship with Posts,

So that one Topic has many Posts. I get all data with this function:And later I make loop to display all results, but they are not paginated:So, i could make a workaround and select separately all posts that has $id of topic and use ->paginate() instead of ->get() and would got paginated $pots, To clarify something: paginating eager-loaded relationships is somewhat of a misconception. The point of eager loading is to retrieve all relationships in as few queries as you can. If you want to retrieve 10 topics, all of which have 35 posts, you will only need two queries. Sweet!That said, paginating an eager-loaded relationship is not going to work. Consider two scenarios when eager loading happens:That said, there are two potential solutions:Option 1: Create a custom accessor that paginates the Eloquent relationship.Pros: Paginates very easily; does not interfere with normal posts relationship.

Cons: Eager loading posts will not affect this accessor; running it will create two additional queries on top of the eager loaded query.Option 2: Paginate the posts Collection returned by the eager-loaded relationship.Pros: Uses the eager-loaded relationship; creates no additional queries.

Cons: Must retrieve ALL elements regardless of current page (slow); have to build the current-page elements manually.You may want to take a look at following:By Zenry :

Source:http://laravel.io/forum/02-25-2014-eager-loading-with-constrains-load-post-based-on-category-nameHope this helps

Undefined variable: errors — Laravel 5.2

Muhammad Asif Saleem

[Undefined variable: errors — Laravel 5.2](https://stackoverflow.com/questions/34474224/undefined-variable-errors-laravel-5-2)

I am new in Laravel and using laravel version 5.2.I created a controller and request named as ArticlesController and CreateArticleRequest respectively and i defined some validation rules.CreateArticleRequestArticlesControllerWhen i use $errors variable in my template named as add.blade.php it show error undefined variable: $errors 

I tried to solve the problem but i did't .Please tell me where i am wrong .

add.blad.php

2015-12-26 18:51:15Z

I am new in Laravel and using laravel version 5.2.I created a controller and request named as ArticlesController and CreateArticleRequest respectively and i defined some validation rules.CreateArticleRequestArticlesControllerWhen i use $errors variable in my template named as add.blade.php it show error undefined variable: $errors 

I tried to solve the problem but i did't .Please tell me where i am wrong .

add.blad.phpThis is a breaking problem with the 5.2 upgrade. What's happening is the middleware which is responsible for making that errors variable available to all your views is not being utilized because it was moved from the global middleware to the web middleware group.There are two ways to fix this:Posting this as it might be useful for others, As Praveen mentioned in 1st solution, in your Kernel.php file(app/Http/Kernel.php) move \Illuminate\View\Middleware\ShareErrorsFromSession::class

from $middlewareGroups to protected $middleware property, but the same will start throwing the error "Session store not set on request", to resolve this move

\Illuminate\Session\Middleware\StartSession::class, to $middleware property as well.This happens because the file below is not updated in the composer update process, so doesn't have the mapWebRoutes method implemented.Copy this file over from a fresh install and it will work. Better, follow the upgrade path on the docs.Just cut all your routes from routes.php file and paste it between the middleware group 'web', just like this:Routes fileFor 5.2, simply move the the routes that have the errors variable to middleware groupWith this code, you can catch errors and display them :

php Laravel- A non well formed numeric value encountered (on string)

Farzan Najipour

[php Laravel- A non well formed numeric value encountered (on string)](https://stackoverflow.com/questions/40057476/php-laravel-a-non-well-formed-numeric-value-encountered-on-string)

I have two function in my controller and service. I want to call a function in service. Here is my code : Controller:my service (Map.php) :Actually , I get an error :at this line: 

public function getOriginPoint(string $origin):PointHow to solve it?

2016-10-15 09:43:42Z

I have two function in my controller and service. I want to call a function in service. Here is my code : Controller:my service (Map.php) :Actually , I get an error :at this line: 

public function getOriginPoint(string $origin):PointHow to solve it?This is a bug in the symfony/var-dumper package when using PHP7.1. It was fixed in version 2.7.16, 2.8.9, 3.0.9 and 3.1.3. See the pull request: https://github.com/symfony/symfony/pull/19379In my case, I needed to composer update my laravel framework packages, as my vendor directory copy of that package was at 2.7.9. (I'm using Laravel 5.1; later versions use 2.8 and 3.0 of symfony, which also had the bug)I had the same issue on Laravel 5.2 PHP 7.1. If you don't want to update the entire framework, you can do:as stated here.

laravel search multiple words separated by space

user4006175

[laravel search multiple words separated by space](https://stackoverflow.com/questions/28270244/laravel-search-multiple-words-separated-by-space)

I am new to laravel query builder, I want to search multiple words entered in an input field for example if I type "jhon doe" I want to get any column that contains jhon or doeI have seen/tried solutions using php MySQL but can't able to adapt to query builderhow do I do this using query builderthis is what i have so far, what is the proper way of doing this, please help, thanks in advance

2015-02-02 02:12:58Z

I am new to laravel query builder, I want to search multiple words entered in an input field for example if I type "jhon doe" I want to get any column that contains jhon or doeI have seen/tried solutions using php MySQL but can't able to adapt to query builderhow do I do this using query builderthis is what i have so far, what is the proper way of doing this, please help, thanks in advanceThis is how you do it with Query\Builder, but first some additional notes:That said, you obviously can't rely on explode because in the above case you would get all the rows.So, this is what you should do:There is closure in the where because it is a good practice to wrap your or where clauses in parentheses. For example if your User model used SoftDeletingScope and you would not do what I suggested, your whole query would be messed up.This would work.the whereIn would search for first name from the keywords you entered.Try this..You can try as followsHave you considered using a FULLTEXT index on your first_name column?You can create this index using a Laravel migration, although you need to use an SQL statement:You can then run quite advanced searches against this field, like this:That will match records containing either the words "john" or "doe"; note that this approach will match on whole words, rather than substrings (which can be the case if you use LIKE).If you want to find records containing all words, you should precede each keyword with a '+', like this:You can even sort by relevance, although this is probably overkill for your needs (and irrelevant for "all" searches). Something like this:There is a good article that covers this general approach here:http://www.hackingwithphp.com/9/3/18/advanced-text-searching-using-full-text-indexesYou can use this package https://github.com/nicolaslopezj/searchableor just do this, if you don't want to use packageUsing 'orWhere' will get you results for each keyword not results for keyword1 + keyword2...So all depends on what your looking for

laravel mysql query with multiple where orwhere and inner join

Alberto

[laravel mysql query with multiple where orwhere and inner join](https://stackoverflow.com/questions/27063077/laravel-mysql-query-with-multiple-where-orwhere-and-inner-join)

How can I prepare the following MySQL query in Laravel?This is the code I used without success:The conditions must be:

2014-11-21 14:00:32Z

How can I prepare the following MySQL query in Laravel?This is the code I used without success:The conditions must be:Okay it looks like your problem is with the nested whereTry this one:I think you want to look into the possibility of using an inline function on the join clause... Your where clauses might be colliding - and really you want the role_id clause to be on your join.http://laravel.com/docs/4.2/queries#joinsThe above produces this query:Which is giving me one row back, given the following database:

How to get list of all cached items by key in Laravel 5?

kohloth

[How to get list of all cached items by key in Laravel 5?](https://stackoverflow.com/questions/31791178/how-to-get-list-of-all-cached-items-by-key-in-laravel-5)

The Cache class in laravel has methods such as get('itemKey') to retrieve items from the cache, and remember('itemKey', ['myData1', 'myData2']) to save items in the cache.There is also a method to check if an item exists in the cache: Cache::has('myKey');Is there any way, (when using the file-based cache driver), to get a list of all items in the cache?For instance, something that might be named something like "Cache::all()" that would return:The only way I can think of doing this is to loop through all possible key names using the Cache::has() method. i.e. aaa, aab, aac, aad... but of course, this is not a solution.I can't see anything in the documentation or the API that describes a function like this, but I don't think its unreasonable to believe that one must exist.

2015-08-03 15:28:26Z

The Cache class in laravel has methods such as get('itemKey') to retrieve items from the cache, and remember('itemKey', ['myData1', 'myData2']) to save items in the cache.There is also a method to check if an item exists in the cache: Cache::has('myKey');Is there any way, (when using the file-based cache driver), to get a list of all items in the cache?For instance, something that might be named something like "Cache::all()" that would return:The only way I can think of doing this is to loop through all possible key names using the Cache::has() method. i.e. aaa, aab, aac, aad... but of course, this is not a solution.I can't see anything in the documentation or the API that describes a function like this, but I don't think its unreasonable to believe that one must exist.There is no way to do that using Cache facade. Its interface represents the functionality that all underlying storages offer and some of the stores do not allow listing all keys.If you're using the FileCache, you could try to achieve that by interacting with the underlying storage directly. It doesn't offer the method you need, so you'll need to iterate through the cache directory. It won't be too efficient due to a lot of disk I/O that might need to happen.In order to access the storage, you need to do ^This above dont work in LV 5.2Try this solution: In 'yourKeyGoesHere' you can insert a string used as same as a like with a * or insert directly the exactly key.     For Memcached, you can do this:This gives you an array of keys you can go through.in \config\database.php make a redis store for the cachein \config\cache.php use this redis databasenow you can use Redis class to check what is in your cache

Laravel uploading file Unable to write in directory

user3714932

[Laravel uploading file Unable to write in directory](https://stackoverflow.com/questions/34836602/laravel-uploading-file-unable-to-write-in-directory)

I'm uploading files in my system and it works locally where am using windows and xampp but when hosting where am using an Ubuntu stack my file is not being uploaded. I'm getting an error that it cannot be written in the 'system' directory which is within the public folder. This is my code    after looking for solutions I found out that I should make my directory writable so I ran the following command in puttychmod 770 /var/www/html/public/systembut still even after that am getting an error Unable to write in the "/var/www/html/public/system" directory.I'm using laravel 5 and my host is digital ocean. Thanks

2016-01-17 08:45:35Z

I'm uploading files in my system and it works locally where am using windows and xampp but when hosting where am using an Ubuntu stack my file is not being uploaded. I'm getting an error that it cannot be written in the 'system' directory which is within the public folder. This is my code    after looking for solutions I found out that I should make my directory writable so I ran the following command in puttychmod 770 /var/www/html/public/systembut still even after that am getting an error Unable to write in the "/var/www/html/public/system" directory.I'm using laravel 5 and my host is digital ocean. Thankschmod 755 /var/www/html/public/system and  chown www-data:www-data /var/www/html/public/system as stated by @JLPuro works perfectly. Thanks a lot guys.permission for folder sudo chmod 777./(folder name)for file sudo chmod 777 -R ./(file name)

In Laravel, how do I retrieve a random user_id from the Users table for Model Factory seeding data generation?

Simon Suh

[In Laravel, how do I retrieve a random user_id from the Users table for Model Factory seeding data generation?](https://stackoverflow.com/questions/44102483/in-laravel-how-do-i-retrieve-a-random-user-id-from-the-users-table-for-model-fa)

Currently, in my ModelFactory.php, I have:I would like to generate a random user_id from one of the user ID's already stored in the user table. I'm stumped because I don't know the way to display data output to code properly, and I was wondering how I would be able to allow Laravel to choose a random user ID and insert into the database. Thank you! :)

2017-05-21 22:38:09Z

Currently, in my ModelFactory.php, I have:I would like to generate a random user_id from one of the user ID's already stored in the user table. I'm stumped because I don't know the way to display data output to code properly, and I was wondering how I would be able to allow Laravel to choose a random user ID and insert into the database. Thank you! :)Try the below. Remember that this gets all the user data from your table and then choses an id randomly. So if your table has huge amount of data, it is not recommended. Instead, in your Test Case, you can create a new User (via its own factory) and assign the id to the Reply object generated from the above factory.Alternately, you can query for a specific user in the above factory definition.If you have a test user set up in your DB this will avoid pulling all the user data.It does not work like that 'user_id':But that's how it works:Any class that extends Illuminate\Database\Eloquent\Model will be able to do this:Or to get a Collection of 3 items:This might be more efficient than using User::all()->first(), which ought to first query all Users.Your IDE (like PhpStorm) will probably be wildly confused that this is an option though.Also see: Laravel - Eloquent or Fluent random row

Laravel 5.4 get Referer

PHPprogrammer42

[Laravel 5.4 get Referer](https://stackoverflow.com/questions/45713409/laravel-5-4-get-referer)

I'm trying to get the Referer of my users. Like if they come from facebook, youtube, google or anything else. Now I've tried something like that: This: that: But nothing worked like expected.Does someone know a solution how I can check the referer? I need that because I want to check if the user comes from some specific URL's and if so, I want to give the user some extra "clicks" to rank up. Something like a small affiliate system.

2017-08-16 12:21:26Z

I'm trying to get the Referer of my users. Like if they come from facebook, youtube, google or anything else. Now I've tried something like that: This: that: But nothing worked like expected.Does someone know a solution how I can check the referer? I need that because I want to check if the user comes from some specific URL's and if so, I want to give the user some extra "clicks" to rank up. Something like a small affiliate system.It seems like this will do what you are looking for :You can read the Api DOC here : http://laravel.com/api/5.0/Illuminate/Http/Request.html#method_server The reason you get Undefined index: HTTP_REFERER is because not all requests have a HTTP_REFERER header, only most of the requests that come from other websites. If you visit a website directly with the url, you wont be sending a HTTP_REFERER header.So, you should check if the header is set first.Proper way is to use I hope this message finds you happy with your code. However, if you are facing any issue with referrer URL, you probably should read this article https://scotthelme.co.uk/a-new-security-header-referrer-policy/. The Referrer Policy header is the key behind such an issue. I have been facing problem with referrer URL in my Laravel + NGINX application and tried all possible ways to fix that by code mentioned in above comments (back, previous, header etc.) but finally found this article to enrich my knowledge before fixing my issue appropriately. It's up to the client to send the referrer information int he HTTP request's header.So if the client (browser, app, etc.) doesn't send the referrer, it won't be available to the server in the request headers. I guess the WhatsApp app has disabled sending the referrer, so there is no way to get it.In some browsers, sending of the referrer information can be turned off in the settings or with a extension. It is also easily spoofed with curl for instance, so it cannot be relied on as a security measure.More info in my answer here: https://stackoverflow.com/questions/49050268/does-document-referrer-equal-the-http-referer-header/49050494If your unsure about the client sending the referrer, it's easy to check it with JavaScript (referrer is spelled here differently from the HTTP header, to add to the confusion):

Laravel Unit Testing Dependency Injection

Denis Priebe

[Laravel Unit Testing Dependency Injection](https://stackoverflow.com/questions/40657440/laravel-unit-testing-dependency-injection)

I'm trying to write a test class for a shopping cart. Here is what I have: ShoppingCartTest.phpHowever, when I run phpunit, it seems like Laravel is unable to resolve my ShoppingCartClass.Here is the error:I have my ShoppingCart class being resolved in a number of different controllers just fine.Why can't Laravel resolve it during my tests?I refered to this post as well but still didn't have any luck.

2016-11-17 14:27:28Z

I'm trying to write a test class for a shopping cart. Here is what I have: ShoppingCartTest.phpHowever, when I run phpunit, it seems like Laravel is unable to resolve my ShoppingCartClass.Here is the error:I have my ShoppingCart class being resolved in a number of different controllers just fine.Why can't Laravel resolve it during my tests?I refered to this post as well but still didn't have any luck.I figured it out. Here is the updated class.Thanks to @edcs for guiding me in the right direction.

You need to use a setUp function and not __construct as the app instance hasn't been created yet.If you want to use __construct you have to use the same constructor of PHPUnit\Framework\TestCase and remember to call the parent method if you don't want to break anythingHowever the proper way would be to use the method setUpBeforeClass() if you want to execute your init code once or setUp() if you want to execute the init code before each test contained in your class.

Check PHPUnit documentation for more details.

How to change mail configuration before sending a mail in the controller using Laravel?

jibe

[How to change mail configuration before sending a mail in the controller using Laravel?](https://stackoverflow.com/questions/23438342/how-to-change-mail-configuration-before-sending-a-mail-in-the-controller-using-l)

I'm using Laravel 4, I would like to change the mail configuration (like driver/host/port/...) in the controller as I would like to save profiles in databases with different mail configuration. This is the basic send mail using configuration from config/mail.phpI've tried to put something like but it didn't workThanks for your support!Jean

2014-05-02 23:15:36Z

I'm using Laravel 4, I would like to change the mail configuration (like driver/host/port/...) in the controller as I would like to save profiles in databases with different mail configuration. This is the basic send mail using configuration from config/mail.phpI've tried to put something like but it didn't workThanks for your support!JeanYou can set/change any configuration on the fly using Config::set:So, to set/change the port in mail.php you may try this:Update: A hack for saving the config at runtime.The selected answer didn't work for me, I needed to add the following for the changes to be registered.I know is kind of late but an approach could be providing a swift mailer to the laravel mailer.

How to delete record in laravel 5.3 using ajax request?

Ayaz Shah

[How to delete record in laravel 5.3 using ajax request?](https://stackoverflow.com/questions/39350918/how-to-delete-record-in-laravel-5-3-using-ajax-request)

I'm trying to delete record using ajax in laravel 5.3, i know this is one of the common question and there is already lots of online solutions and tutorials available about this topic. I tried some of them but most of giving me same error NetworkError: 405 Method Not Allowed. I tried to do this task by different angle but i'm stuck and could not found where i'm wrong, that's why i added this question for guideline.I'm trying following script for deleting the record.Controller.phpRoutes.phpIn ViewApp.jsWhen i'm click on delete button it returning me error NetworkError: 405 Method Not Allowed in console. Without ajax same delete function is working properly. Can anyone guide me where i'm wrong that i can fix the issue, i would like to appreciate if someone guide me regarding this. Thank You..

2016-09-06 13:58:32Z

I'm trying to delete record using ajax in laravel 5.3, i know this is one of the common question and there is already lots of online solutions and tutorials available about this topic. I tried some of them but most of giving me same error NetworkError: 405 Method Not Allowed. I tried to do this task by different angle but i'm stuck and could not found where i'm wrong, that's why i added this question for guideline.I'm trying following script for deleting the record.Controller.phpRoutes.phpIn ViewApp.jsWhen i'm click on delete button it returning me error NetworkError: 405 Method Not Allowed in console. Without ajax same delete function is working properly. Can anyone guide me where i'm wrong that i can fix the issue, i would like to appreciate if someone guide me regarding this. Thank You..Instead of using Route::get use Route::delete.In addition to that change the type: 'Put' to type: 'DELETE' in the ajax call.P.S. This codecan be written as:Or even shorter:Keep in mind that ->delete() will fire an event while ::destroy() will not.Make sure to add this in the meta tag of your viewIn your Routes, do thisIn your controller, do thisorMake sure to check that the user who is deleting the account actually owns the account a.k.a run authorization test.Since it's a delete request, you would require to send the csrf_token along with your ajax header as the official site states.

https://laravel.com/docs/5.5/csrf#csrf-x-csrf-tokenMake sure to add this before the ajax call Now send the requestI hope this helps.});i'm resuming a working flow of deletion, with a request VERB. Hope it helpsIn the form (with blade):Route:ProductController:In the redirect part, i'm going back to my list page (admin.products) with a success notifier. The route would be:So you can complete the flow.

issue with dropping foreign key

Jimmyt1988

[issue with dropping foreign key](https://stackoverflow.com/questions/26628176/issue-with-dropping-foreign-key)

My foreign key relates to its own table. This was to produce posts with hierarchy.Now when I try and drop the column in the database, it gives me this error:This is the code:The only way I seem to be able to do it, is to goto phpmyadmin and remove the foreign key itself. and then drop the column.

2014-10-29 10:37:40Z

My foreign key relates to its own table. This was to produce posts with hierarchy.Now when I try and drop the column in the database, it gives me this error:This is the code:The only way I seem to be able to do it, is to goto phpmyadmin and remove the foreign key itself. and then drop the column.Just figured this out for my own project. When you are dropping a foreign key, you need to concatenate the table name and the columns in the constraint then suffix the name with "_foreign"http://laravel.com/docs/5.1/migrations#foreign-key-constraintsHere’s how to do it:1) Log in to your database and lookup the name of the foreign key relationship. If you use phpmyadmin, go to the table, click the「Structure」tab, click the link「Relation View」and wait a few seconds for it to load. Search for the field「Constraint name」. In my example this is:「contribution_copyright_id_foreign」2) Go to the Laravel migration script (or create one). The trick is to first drop the foreign key relationship and then drop the column.If you want to remove a table where a foreign key is present, you also first have to drop the foreign key relationship.copied from hereHope it help someoneTry placing "_foreign" on the end of the column name. For example:To check the name of the foreign key , first backup your database to .sqlthere you will see the name of your foreign key like this :in my case is laravel 5.4,

it start by this format : tablename_columnname_foreignso in your laravel (here i try to drop foreign key from employee table)

New to Laravel PHP framework. Routes other than「/」doesn't work

Rafael Adel

[New to Laravel PHP framework. Routes other than「/」doesn't work](https://stackoverflow.com/questions/18491760/new-to-laravel-php-framework-routes-other-than-doesnt-work)

I'm a beginner at Lavarel framework. I know about MVC structure, Since I've used it before inside ASP.net, But using Laravel is quite confusing to me.I've installed Laravel inside photozoom directory using:Here's my app/routes.php : When i run http://localhost/photozoom/public/users, I get 404 Not Found error. But when i try http://localhost/photozoom/public/, The route for / is invoked and the corresponding view is called.I even tried to create a view for the users route. Using Laravel documentation. I've created two files :layout.blade.php : users.blade.php :But still, When i call http://localhost/photozoom/public/users I get 404 Not Found error.Here's my public/.htaccess file:I'm using PHP 5.5, Apache 2.4.6 .Any help would be appreciated.SOLVED

After enabling mod_rewrite, I had to enable AllowOverride too.

2013-08-28 15:10:55Z

I'm a beginner at Lavarel framework. I know about MVC structure, Since I've used it before inside ASP.net, But using Laravel is quite confusing to me.I've installed Laravel inside photozoom directory using:Here's my app/routes.php : When i run http://localhost/photozoom/public/users, I get 404 Not Found error. But when i try http://localhost/photozoom/public/, The route for / is invoked and the corresponding view is called.I even tried to create a view for the users route. Using Laravel documentation. I've created two files :layout.blade.php : users.blade.php :But still, When i call http://localhost/photozoom/public/users I get 404 Not Found error.Here's my public/.htaccess file:I'm using PHP 5.5, Apache 2.4.6 .Any help would be appreciated.SOLVED

After enabling mod_rewrite, I had to enable AllowOverride too.Try http://localhost/photozoom/public/index.php/users for now. And then enable pretty URLs.The .htaccess file in the /public directory enables pretty URLs.

In order for the .htaccess file to do its work:For example:There are two AllowOverride in the httpd.conf file.andif you're running windows 10 then you just need to do one thing simple as enough.create new folder in c:/wamp64/www/ and

copy your all file from laravel folder and paste in folder which you just created thats my solution.

Laravel - Paginate and get()

Bajongskie

[Laravel - Paginate and get()](https://stackoverflow.com/questions/19616720/laravel-paginate-and-get)

With the code below, what I wanted was paginate the query I created. But, when I try to add paginate after get, it throws an error. I wanted to remain get since I want to limit to columns that was set on $fields.

What would should be the better idea to paginate this thing? or what's a good substitute for get and limit the columns?What I tried:Part of my controller:}

2013-10-27 09:50:09Z

With the code below, what I wanted was paginate the query I created. But, when I try to add paginate after get, it throws an error. I wanted to remain get since I want to limit to columns that was set on $fields.

What would should be the better idea to paginate this thing? or what's a good substitute for get and limit the columns?What I tried:Part of my controller:}If you look at the method signature you will see that paginate receives a second argument, $columns. So your solution would be to useFurthermore, you can clean up your controller by changing things slightly:

laravel4 composer install got proc_open not available error

Felix

[laravel4 composer install got proc_open not available error](https://stackoverflow.com/questions/19911737/laravel4-composer-install-got-proc-open-not-available-error)

Now I am trying to use composer to install my php package but I got this error message:

$ composer installedit :after enable the proc_open function I got this error and also set my php memory_limit to 384M :

2013-11-11 16:56:10Z

Now I am trying to use composer to install my php package but I got this error message:

$ composer installedit :after enable the proc_open function I got this error and also set my php memory_limit to 384M :You should use php-cli to by-pass disable_functions temporarily.Edit your php.ini file and search for the lineIt should be disabled there and you must enabled it. This a security precaution.

laravel 5.4 : Laravelcollective/html v5.3.0 requires illuminate/view 5.3.*

Gammer

[laravel 5.4 : Laravelcollective/html v5.3.0 requires illuminate/view 5.3.*](https://stackoverflow.com/questions/41845042/laravel-5-4-laravelcollective-html-v5-3-0-requires-illuminate-view-5-3)

I was using Laravelcollective/html v5.3.0 with laravel 5.3. Now i am using laravel 5.4. I have forms which are using Laravelcollective/html v5.3.0.The composer require laravelcollective/html gives me the following error:When gonna laravel 5.4 support Laravelcollective/html ?

2017-01-25 06:41:36Z

I was using Laravelcollective/html v5.3.0 with laravel 5.3. Now i am using laravel 5.4. I have forms which are using Laravelcollective/html v5.3.0.The composer require laravelcollective/html gives me the following error:When gonna laravel 5.4 support Laravelcollective/html ?Update:The Laravelcollective/html has been updated to Laravel 5.4 but there is no any changes in the documentation till now.

If you want to see the pull request it is right here:https://github.com/LaravelCollective/html/pull/276https://github.com/LaravelCollective/html/pull/284Just use:Or,If you don't want to specify the version and get the same latest version of LaravelCollective.Older Issue:Laravelcollective/html v5.3.0 requires Laravel 5.3 and not yet supports Laravel 5.4.The laravelcollective/html v5.4 is under open issue:https://github.com/LaravelCollective/html/pull/276It could be merged any time.Just have an eye on it.Edit: Alternatively you could use maddhatter's git repository as he had done some changes that is not yet provided in git@github.com:st3f/html.git repository.Just add it into your composer.jsonand runOr, if you don't need those changes you could follow Cerlin Boss answerhttps://stackoverflow.com/a/41845331/3887342NOTE: This answer was posted when laravelcollective/html was not supporting laravel 5.4For dev purpose you can use the origin repo from the pull request for 5.4Configure the repoTo add this automatically without manually editing the composer.json

run,Require the dev-master as it has the changes for 5.4Once the original repo author releases the support for 5.4, just remove the vcs repo reference and change the dev-master to 5.4

On server my application is looking for uppercase table name instead of lowercase

Alexander Solonik

[On server my application is looking for uppercase table name instead of lowercase](https://stackoverflow.com/questions/41967746/on-server-my-application-is-looking-for-uppercase-table-name-instead-of-lowercas)

I have this table on my local xampp , the table name is tags , this works perfectly fine on my local system, but when I upload this table to my server I get the following error:The tables I have under the table peckinga_blog are the following:As you can see tags is one of them , Also for the tags table I have the following migrations in my laravel application:Now why am I getting this this error in spite of my database clearly being available ? What can I do so that my server will look for the database tags instead of Tags ?

2017-01-31 21:24:26Z

I have this table on my local xampp , the table name is tags , this works perfectly fine on my local system, but when I upload this table to my server I get the following error:The tables I have under the table peckinga_blog are the following:As you can see tags is one of them , Also for the tags table I have the following migrations in my laravel application:Now why am I getting this this error in spite of my database clearly being available ? What can I do so that my server will look for the database tags instead of Tags ?Database and table names are not case sensitive in Windows, and case sensitive in most varieties of Unix or Linux. Table names in MySQL are file system entries, so they are case insensitive if the underlying file system is.Although after applying the migration, it should work But in case if it is not working and you want both statements i.e. lower case and upper case name in table to succeed, you need to put the following line in your /etc/my.cnf or wherever you keep your MySQL configuration.Doctrine generated capital/CamelCase table names and MySQL stored them as lowercase!Or Be sure to add the system variable to [mysqld] section of the configuration file.For more information you can check the MySQL Reference Link.I had the following line in my code:worked perfectly locally on my windows XAMPP, but needed to change it to:to work on my server.the case sensitivity depends on your underlying filesystem, which explains the discrepancy between your local and production machine.since this is a common problem, I'd recommend to use lowercase allover as a convention. change your Tags to tags in your migrations and also in your model and you should be good to go.if you need to rename your table, rename it first to something_else, and than again to tags.

Sanitize user input in laravel

warmspringwinds

[Sanitize user input in laravel](https://stackoverflow.com/questions/12813424/sanitize-user-input-in-laravel)

I've got a simple question:

When is it best to sanitize user input?

And which one of these is considered the best practice:For example use HTML::entities() and save result to database.

Or by using HTML methods in the views because in this case laravel by default uses HTML::entities().

Or maybe by using the both.EDIT: I found interesting example http://forums.laravel.com/viewtopic.php?id=1789. Are there other ways to solve this? 

2012-10-10 06:40:39Z

I've got a simple question:

When is it best to sanitize user input?

And which one of these is considered the best practice:For example use HTML::entities() and save result to database.

Or by using HTML methods in the views because in this case laravel by default uses HTML::entities().

Or maybe by using the both.EDIT: I found interesting example http://forums.laravel.com/viewtopic.php?id=1789. Are there other ways to solve this? I would say you need both locations but for different reasons. When data comes in you should validate the data according to the domain, and reject requests that do not comply. As an example, there is no point in allowing a tag (or text for that matter) if you expect a number. For a parameter representing.a year, you may even want to check that it is within some range.

Sanitization kicks in for free text fields. You can still do simple validation for unexpected characters like 0-bytes. IMHO it's best to store raw through safe sql (parameterized queries) and then correctly encode for output. There are two reasons. The first is that if your sanitizer has a bug, what do you do with all the data in your database? Resanitizing can have unwanted consequences. Secondly you want to do contextual escaping, for whichever output you are using (JSON, HTML, HTML attributes etc.)I have a full article on input filtering in Laravel, you might find it useful http://usman.it/xss-filter-laravel/, here is the excerpt from this article:You can do a global XSS clean yourself, if you don’t have a library to write common methods you may need frequently then I ask you to create a new library Common in application/library. Put this two methods in your Common library:Then put this code in the beginning of your before filter (in application/routes.php):I just found this question. Another way to do it is to enclose dynamic output in triple brackets like this {{{ $var }}} and blade will escape the string for you. That way you can keep the potentially dangerous characters in case they are important somewhere else in the code and display them as escaped strings. It depends on the user input. If you're generally going to be outputting code they may provide (for example maybe it's a site that provides code snippets), then you'd sanitize on output. It depends on the context. If you're asking for a username, and they're entering HTML tags, your validation should be picking this up and going "no, this is not cool, man!"If it's like the example I stated earlier (code snippets), then let it through as RAW (but be sure to make sure your database doesn't break), and sanitize on output. When using PHP, you can use htmlentities($string).i'd found this because i was worried about xss in laravel, so this is the packages gvlatkoit is easy: To Clear Inputs = $cleaned = Xss::clean(Input::get('comment');To Use in views = $cleaned = Xss::clean(Input::file('profile'), TRUE);

Select, where JSON Array contains

Elwin

[Select, where JSON Array contains](https://stackoverflow.com/questions/46055223/select-where-json-array-contains)

So in Laravel 5 there's the handy thing called JSON Where Clauses using MySQL's new ability to store and fetch JSON stored in a column:would return all rows, where colors in the column meta would be set to red.Now let's say colors is not a string, but an array containing multiple colors (colors => ['red', 'blue', 'green']).  What would be an efficient way to retrieve all rows, where colors contains e.g. the value red?

2017-09-05 12:39:43Z

So in Laravel 5 there's the handy thing called JSON Where Clauses using MySQL's new ability to store and fetch JSON stored in a column:would return all rows, where colors in the column meta would be set to red.Now let's say colors is not a string, but an array containing multiple colors (colors => ['red', 'blue', 'green']).  What would be an efficient way to retrieve all rows, where colors contains e.g. the value red?JSON_CONTAINS() does exactly what you're looking for:  Currently, Laravel's query builder does not provide a corresponding API. There's an open internals proposal for it though. In the meantime, you can execute a raw query:  Which would return all users that have "red" in their meta->colors JSON field. Note that the -> operator requires MySQL 5.7.9+.You can also call the whereRaw() directly on an Eloquent model.  As of the 5.6 release, Laravel's query builder contains a new whereJsonContains method.I think a way would be using the like operator:However, this would only work if the values never contain the character " and the delimiters wouldn't change.An update for this answer, according to MySQL or MariaDb, the correct syntax must be JSON_CONTAINS(@json, 'red', '$.colors'), and is necessary to use JSON_EXTRACT.Remember to use double quotes in value sentence.

JSON_CONTAINS(JSON_EXTRACT(meta, '$.colors'), '"red"')The whereIn method verifies that a given column's value is contained within the given array.

Try this:More about Laravel's whereIn.

How can I add external class in Laravel 5

Hamed Kamrava

[How can I add external class in Laravel 5](https://stackoverflow.com/questions/28816707/how-can-i-add-external-class-in-laravel-5)

There is a class in app/Libraries/TestClass.php with following content:Now, I would like to call getInfo() method from this external class in my Controller.How can I do such thing?

2015-03-02 18:17:30Z

There is a class in app/Libraries/TestClass.php with following content:Now, I would like to call getInfo() method from this external class in my Controller.How can I do such thing?First you should make sure that this class is in the right namespace. The correct namespace here would be:Then you can just use it like any other class:Don't forget the import at the top of the class you want to use it in:In case you don't have control over the namespace or don't want to change it, add an entry to classmap in your composer.json:Then run composer dump-autoload. After that you'll be able to use it the same way as above except with a different (or no) namespace.

How to get name of requested controller and action in middleware Laravel

Deejay

[How to get name of requested controller and action in middleware Laravel](https://stackoverflow.com/questions/30442746/how-to-get-name-of-requested-controller-and-action-in-middleware-laravel)

I am new to Laravel, and i want to get name of requested controller and action in beforefilter middelware.Thanks,

DJ

2015-05-25 16:52:38Z

I am new to Laravel, and i want to get name of requested controller and action in beforefilter middelware.Thanks,

DJLaravel 5.6:Laravel 5.5 and lower:You can retrieve the current action name with Route::currentRouteAction(). Unfortunately, this method will return a fully namespaced class name. So you will get something like:Then just separate method name and controller name:

Laravel command - Only optional argument

TheNiceGuy

[Laravel command - Only optional argument](https://stackoverflow.com/questions/46670304/laravel-command-only-optional-argument)

I have a command with this signatureAnd execute this:For some reason that results in this exceptionWhy? I want that this command can either be executed as php artisan order:check or with an optional order id php artisan order:check --order X

2017-10-10 15:16:03Z

I have a command with this signatureAnd execute this:For some reason that results in this exceptionWhy? I want that this command can either be executed as php artisan order:check or with an optional order id php artisan order:check --order XThe {--order} option (without an = sign) declares a switch option, which takes no arguments. If the switch option is present, its value equals true, and, when absent, false (--help is like a switch—no argument needed).When we provide an argument on the command line for this option, the console framework cannot match the input to an option with an argument, so it throws the error as shown in the question.To allow the option to accept an argument, change the command's $signature to: Note the addition of the equal sign after --order. This tells the framework that the --order option requires an argument—the command will throw an exception if the user doesn't provide one.If we want our command to accept an option with or without an argument, we can use a similar syntax to provide a default value: ...but this doesn't seem useful for this particular case.After we set this up, we can call the command, passing an argument for --order. The framework supports both formats:...and then use the value of order in our command: 

How to inject multiple classes that share the same interface in Laravel 4

bitinn

[How to inject multiple classes that share the same interface in Laravel 4](https://stackoverflow.com/questions/19365138/how-to-inject-multiple-classes-that-share-the-same-interface-in-laravel-4)

Say I have an interface CrawlerInterface with implementation PageCrawler and FeedCrawler; if we happen to need both classes in a controller, how can that be achieved with constructor injection?Previously we use a central ServiceProvider to register (i.e. App::bind) such classes, but in most cases we only have 1 implementation of an interface, so said problem hasn't occured to us yet.PS: I also wonder if this problem suggests we should split the controller.Updates:Thanks for the comments and response, to explain, said interface has only one public method: crawl($uri), and both page/feed crawler implements it as given a resource identifier, return resource.My follow up question:Say we are in a calculator scenario where Addition, Subtraction and Multiplication share the same interface Operation, which has only 1 public method run, at some point we will still encounter this problem right? How do we handle situation like these in general with ServiceProvider?

2013-10-14 16:48:29Z

Say I have an interface CrawlerInterface with implementation PageCrawler and FeedCrawler; if we happen to need both classes in a controller, how can that be achieved with constructor injection?Previously we use a central ServiceProvider to register (i.e. App::bind) such classes, but in most cases we only have 1 implementation of an interface, so said problem hasn't occured to us yet.PS: I also wonder if this problem suggests we should split the controller.Updates:Thanks for the comments and response, to explain, said interface has only one public method: crawl($uri), and both page/feed crawler implements it as given a resource identifier, return resource.My follow up question:Say we are in a calculator scenario where Addition, Subtraction and Multiplication share the same interface Operation, which has only 1 public method run, at some point we will still encounter this problem right? How do we handle situation like these in general with ServiceProvider?If each crawler exists for a different reason, you can use arbitrary names for your instances, for example:For the controller:Your controller code would then use each crawler differently:If you just have a list of crawlers where each is used for the same thing, you probably want to do something like:In your controller, you'll get a list of "crawlers" by configuring it like so:Your controller code could be something like this:Ok lets assume you have a CrawlerControlleran interface and concrete implementations of that intefrace called PageCrawler and FeedCrawlerYou would inject the dependencies by writing a service locator likeBut as suggested by others you should rethink your logic, use it only if this kind

of architecture is unavoidableI think that the interface won't help you in this case. By doing:You need to choose one:orAnd then Laravel will inject it:To have both you have 2 options-Have 2 different interfaces-Inject the implementations directly:But I also think that, if you need something like this, you better rethink your logic.

Use other column values for Eloquent update

lesssugar

[Use other column values for Eloquent update](https://stackoverflow.com/questions/31118045/use-other-column-values-for-eloquent-update)

I would like to perform an UPDATE using Eloquent, that will set column_c value using values of column_a and column_b of the same table. Basically, something like this:where $this->column_a and $this->column_b would be the actual values from the current row.MySQL equivalent:Note: The code above is just an example to show the idea. It's not the actual implementation (which would be creating a DB redundancy).How do I perform such update in Laravel 5.1? I would really like to avoid a foreach.

2015-06-29 14:17:36Z

I would like to perform an UPDATE using Eloquent, that will set column_c value using values of column_a and column_b of the same table. Basically, something like this:where $this->column_a and $this->column_b would be the actual values from the current row.MySQL equivalent:Note: The code above is just an example to show the idea. It's not the actual implementation (which would be creating a DB redundancy).How do I perform such update in Laravel 5.1? I would really like to avoid a foreach.Maybe DB::raw can help. This will allow you to use any standard sql query to combine your data:You could use an override.. Somthing like this:Edit:

This might help you as well:

   laravel model callbacks after save, before save, etc

How do I set laravel test to go to site name instead of localhost

Rockwell Rice

[How do I set laravel test to go to site name instead of localhost](https://stackoverflow.com/questions/33547952/how-do-i-set-laravel-test-to-go-to-site-name-instead-of-localhost)

I am trying to write some tests for an application.  I have the server set up on MAMP going to dev.myappnamehere.com.When I run a test (based off of Laracasts Integrated) it fails because it is looking for the routeBut what it needs to go to is How can I change that so it does not default to looking for the localhost and instead goes to the correct path?I attempted to change this in the test but got nowhere and I was unable to located an answer through googling.

