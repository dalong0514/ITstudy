EDIT 

I have chmod -R 0+w laravel/storage and now when i go to localhost/laravel i get an index of some files in there, but when i go to localhost/laravel/public/ still get the 403 error, instead of the expected result

EDIT 2 

I have set chmod -R 765 laravel/public and now when i get to localhost/laravel/public i get this message which leads me to believe i'm getting closer: 

2012-08-16 06:13:29Z

I'm trying laravel as a PHP framework, I have already extracted the laravel zip into ~/opt/xampp/htdocs/laravel but when I go to localhost/laravel or localhost/laravel I get a 403 error message saying: I read somewhere that I need to edit the storage folder inside of laravel so it can be readable and writable so I chmod -R 766 laravel/storage but still no luck, I'm doing this from Ubuntu 12.04 have anyone encountered this ?

EDIT 

I have chmod -R 0+w laravel/storage and now when i go to localhost/laravel i get an index of some files in there, but when i go to localhost/laravel/public/ still get the 403 error, instead of the expected result

EDIT 2 

I have set chmod -R 765 laravel/public and now when i get to localhost/laravel/public i get this message which leads me to believe i'm getting closer: Final Update

I finally solved it, what happened was that the laravel folder was read protected, what i had to do was to set chmod 755 -R laravel and then chmod -R o+w storage and voila i had laravel up and running, thanks to everybody that contributed.for just getting start with laravel, I just do these following steps:then add www-data group to your laravelYour on the right track, after install of laravel you need to ensure the storage directory has the correct permissions: Then make sure you are serving your public folder and not your laravel folder in apaches document rootBoth requirements are covered hereOn the Laravel forum, Kaspien gave this usefull answers:From the thread: http://forums.laravel.com/viewtopic.php?id=1552In your .htaccess file:Change permission to the storage and bootstrap folders like so

Laravel, How to use where conditions for relation's column?

Tharshan Venkdesan

[Laravel, How to use where conditions for relation's column?](https://stackoverflow.com/questions/14621943/laravel-how-to-use-where-conditions-for-relations-column)

I'm using Laravel and having a small problem with Eloquent ORM.. I can get this working simply with SQL query using a JOIN but I can't seem to get it working with Eloquent!This is what I want, I have two tabels. one is 'Restaurants' and other is 'Restaurant_Facilities'. The tables are simple.. and One-To-One relations. like there is a restaurant table with id, name, slug, etc and another table called restaurant_facilities with id, restaurant_id, wifi, parking, etcNow what I want to do is.. load all restaurants which have wifi = 1 or wifi = 0..

How can i do that with Eloquent ? I have tried eager loading, pivot tables, with(), collections() and nothing seems to work!The same problem I have for a Many-To-Many relation for cuisines!

I have the same restaurant table and a cuisine table and a restaurant_cuisine_connection table..but how do I load all restaurants inside a specific cuisine using it's ID ?This works.Cuisine::find(6)->restaurants()->get();but I wanna load this from Restaurant:: model not from cuisines.. because I have many conditions chained together.. its for a search and filtering / browse page.Any ideas or ways ? I've been struggling with this for 3 days and still no answer.Example Models :PS :

This seems to be working.. but this is not Eloquent way right ?Also what is the best method to find a count of restaurants which have specific column value without another query ? like.. i have to find the total of restaurants which have parking = 1 and wifi = 1 ?Please help on this.Thank you.

2013-01-31 09:04:49Z

I'm using Laravel and having a small problem with Eloquent ORM.. I can get this working simply with SQL query using a JOIN but I can't seem to get it working with Eloquent!This is what I want, I have two tabels. one is 'Restaurants' and other is 'Restaurant_Facilities'. The tables are simple.. and One-To-One relations. like there is a restaurant table with id, name, slug, etc and another table called restaurant_facilities with id, restaurant_id, wifi, parking, etcNow what I want to do is.. load all restaurants which have wifi = 1 or wifi = 0..

How can i do that with Eloquent ? I have tried eager loading, pivot tables, with(), collections() and nothing seems to work!The same problem I have for a Many-To-Many relation for cuisines!

I have the same restaurant table and a cuisine table and a restaurant_cuisine_connection table..but how do I load all restaurants inside a specific cuisine using it's ID ?This works.Cuisine::find(6)->restaurants()->get();but I wanna load this from Restaurant:: model not from cuisines.. because I have many conditions chained together.. its for a search and filtering / browse page.Any ideas or ways ? I've been struggling with this for 3 days and still no answer.Example Models :PS :

This seems to be working.. but this is not Eloquent way right ?Also what is the best method to find a count of restaurants which have specific column value without another query ? like.. i have to find the total of restaurants which have parking = 1 and wifi = 1 ?Please help on this.Thank you.I don't see anything wrong with doing the left join here, if you have to load from the Restaurant model. I might abstract it away to a method on my Restaurant model, like so:And then, from your routes:On the go - haven't tested that code, but I think it should work. You could instead use eager loading with a constraint, but that will only specify whether the facility object is null or not. It would still return all restaurants, unless you specify a where clause.(P.S. I'd stick with the singular form of Facility. Notice how hasOne('Facilities') doesn't read correctly?)I stumbled across this post while trying to improve my REST API methodology when building a new sharing paradigm. You want to use Eager Loading Constraints. Let's say you have an api route where your loading a shared item and it's collection of subitems such as this:When hitting this route with a GET request, you want to load that specific subitem. Granted you could just load that model by that id, but what if we need to validate if the user has access to that shared item in the first place? One answer recommended loading the inversed relationship, but this could lead to a confusing and muddled controller very quickly. Using constraints on the eager load is a more 'eloquent' approach. So we'd load it like this:So where only want the subitem that has that id. Now we can check if it was found or not by doing something like this:Since subitems is a collection (array of subitems) we return the subitem[0] with this:Use whereHas to filter by any relationship.  It won't join the relation but it will filter the current model by a related property.  Also look into local scopes to help with situations like this https://laravel.com/docs/5.3/eloquent#local-scopesYour example would be:To achieve the same thing with local scopes: For local scopes you DO NOT want to define them as static methods on your model as this creates a new instance of the query builder and would prevent you from chaining the methods.  Using a local scope will injects and returns the current instance of the query builder so you can chain as many scopes as you want like:Local Scopes are defined with the prefix scope in the method name and called without scope in the method name as in the example abover.Another solution starring whereHas() function:Nice and tidy.Do you absolutely have to load it from the Restaurant model? In order to solve the problem, I usually approach it inversely.This will get all the restaurant facilities that match your conditions, and eager load the restaurant. You can chain more conditions and count the total like this.. This will work with cuisine as wellThis grabs the cuisine object with the id of 1 eager loaded with all the restaurants that have this cuisine

PHP Artisan Tinker crashing from any command

G.S.

[PHP Artisan Tinker crashing from any command](https://stackoverflow.com/questions/53773098/php-artisan-tinker-crashing-from-any-command)

I haven't had this problem before, but my php artisan tinker crashes from issuing any command - and leaves no logs whatsoever on what is causing the crash.or even the simplest command:I almost wonder if it isn't connecting to PHP correctly, but I can't find any logs anywhere. Laravel has no trace of the commands. I ran brew update, but no difference. For the record, all of my projects are affected. I can't tinker on any of my projects. Help!I did recently upgrade to PHP 7.3.0, which is working fine in every other area. Hmm...

2018-12-14 03:25:15Z

I haven't had this problem before, but my php artisan tinker crashes from issuing any command - and leaves no logs whatsoever on what is causing the crash.or even the simplest command:I almost wonder if it isn't connecting to PHP correctly, but I can't find any logs anywhere. Laravel has no trace of the commands. I ran brew update, but no difference. For the record, all of my projects are affected. I can't tinker on any of my projects. Help!I did recently upgrade to PHP 7.3.0, which is working fine in every other area. Hmm...If you are using PHP 7.3 installed by homebrew on Mojave, try creating a config file at ~/.config/psysh/config.php if not already there:Source: https://github.com/bobthecow/psysh/issues/540#issuecomment-446480753This happens on Mojave when you upgrade/install PHP 7.3 using homebrew, 

(It's a problem with PsySh (used by Tinker) and Homebrew's PHP 7.3.0 build.)Simple solution is, 

In your php.ini set If you don't know which ini file is used, you can run php --ini to find it,I'd recommend to install a previous version of PHP via brew, if you have PHP 7.3 just a take a step back and install 7.2brew install php@7.2It worked for me, hope does it for you too. 

Can't make Laravel 4 to work on localhost

Carlo

[Can't make Laravel 4 to work on localhost](https://stackoverflow.com/questions/14345174/cant-make-laravel-4-to-work-on-localhost)

I'm trying Laravel for the first time after reading an announcement of the Laravel4 beta releasing.I followed these steps I installed composer and laravel with all the dependencies it needed. I put the laravel inside my ~/public_html directory - as I'm used to do it with Codeigniter, but I think something's wrong here.If I point to the browser to http://localhost/~carlo/laravel-develop/, it just displays the content of the directory.Then, while on the filesystem I had a laravel-develop/public folder, it didn't appear on the browser.I've found that changing the .htaccess like this:resulted in an error when I try to access the public folder.

The error:another one:then a long list of errors. The last one is:

2013-01-15 19:15:52Z

I'm trying Laravel for the first time after reading an announcement of the Laravel4 beta releasing.I followed these steps I installed composer and laravel with all the dependencies it needed. I put the laravel inside my ~/public_html directory - as I'm used to do it with Codeigniter, but I think something's wrong here.If I point to the browser to http://localhost/~carlo/laravel-develop/, it just displays the content of the directory.Then, while on the filesystem I had a laravel-develop/public folder, it didn't appear on the browser.I've found that changing the .htaccess like this:resulted in an error when I try to access the public folder.

The error:another one:then a long list of errors. The last one is:Try to change the folder permissions for the storage folder using the terminal:chmod -R 777 storageMore info on this matter can be found here.Your errors resulted because laravel couldn't write to the app/storage folder. The rest was just a stack trace. In order to make the storage folder writable, cd into your app folder and then run:Production way, moderate complexity for people not familiar with Unix, but more secure: Voila!.Fast and dirty way, for those who doesn't care about security and want make it works at any cost, not secure:In my case I resolved this error by modifying in file /app/config/app.php the default setting:to my local custom virtualhost host url:This seemed to be THE essential change that resolved the issue (I also chmod'ed the storage folder, as suggested here)hope this helps some of you..further to above, if you're using a virtualbox/vagrant VM type environment, then on my Mac I needed to issue the chmod on the host (mac) system but on my Windows box, it was fine issuing the chmod direcly on the VM.You need to add: Options +FollowSymLinksYou need to read the installation documentation:http://laravel.com/docs/installation#configurationPay attention to the bit here:There is also other stuff thats useful in that document, so make sure you read it all.I had the same problem, here is how I solve it:

In your httpd-vhosts.conf files you need to add the configurations to your folders, this is what I have in mineThe webroot of your server should point to the /public folder of your Laravel installation. This is where the index.html file recides from where Laravel is initialized.First, this answer here will help you with permissions.  Second, you may need to add RewriteBase ~/carlo/public_html/laravel-develop to your .htaccess since you're running it out of a home directory.Hey I got this error too and changing the write permissions didn't seem to work either. It turned out I needed to change the User and Group settings in apache's httpd.conf file. Here's a good tutorial for it: Enable Write Permissions for the Native Built-In Apache in Mac OS X LionChecking on the Requirement for the LR4, your local server must have these:

PHP >= 5.3.7

MCrypt PHP ExtensionOtherwise, will fail. I am facing this trouble also and now looking for an updated PHP and its extension for my XAMPP.I like this method better than changing permissions to 777.

Set Apache to run as you.I ran into this problem a few minutes back and using sudo chmod -R 777 storage seemed to help make the storage/meta/services.json writable. Just to add to what everyone has been saying. This worked for me.

Laravel - Model Class not found

Sylnois

[Laravel - Model Class not found](https://stackoverflow.com/questions/28350232/laravel-model-class-not-found)

When starting to work with models I got the following error All I did:

- Created a Model with  the command php artisan make:model

- Tried to get all entries from table posts with echo Post::all()  I used the following code:router.phpPost.php  What I tried

- Renaming Class

- Dump-autoload (Laravel 4 Model class not found)

2015-02-05 17:23:44Z

When starting to work with models I got the following error All I did:

- Created a Model with  the command php artisan make:model

- Tried to get all entries from table posts with echo Post::all()  I used the following code:router.phpPost.php  What I tried

- Renaming Class

- Dump-autoload (Laravel 4 Model class not found)Laravel 5 promotes the use of namespaces for things like Models and Controllers. Your Model is under the App namespace, so your code needs to call it like this: As mentioned in the comments you can also use or import a namespace in to a file so you don't need to quote the full path, like this: While I'm doing a short primer on namespaces I might as well mention the ability to alias a class as well. Doing this means you can essentially rename your class just in the scope of one file, like this: More info on importing and aliasing namespaces here: http://php.net/manual/en/language.namespaces.importing.phpI was having the same "Class [class name] not found" error message, but it wasn't a namespace issue. All my namespaces were set up correctly. I even tried composer dump-autoload and it didn't help me.Surprisingly (to me) I then did composer dump-autoload -o which according to Composer's help, "optimizes PSR0 and PSR4 packages to be loaded with classmaps too, good for production." Somehow doing it that way got composer to behave and include the class correctly in the autoload_classmap.php file.I had the same error in Laravel 5.2, turns out the namespace is incorrect in the model class definition.I created my model using the command:By default, Laravel 5 creates the model under App folder, but if you were to move the model to another folder like I did, you must change the the namespace inside the model definition too:To include the folder name when creating the model you could use (don't forget to use double back slashes):If after changing the namespace and the config/auth.php it still fails, you could try the following:In your router.php file, you should use the model class like thisand use the model class like this.As @bulk said, it uses namespaces.I recommend you to start using an IDE, it will suggest you to import all the required namespaces (\App\Post in this case).Make sure to be careful when editing your model file. For example, in your post model:You need to pay close attention to the class Post extend Model line. The class Post defined here will be your namespace for your controller.For me it was really silly I had created a ModelClass file without the .php extension.  So calling that was giving model not found.  So check the extension has .php

Storage in laravel says symlink - no such file

Programmmereg

[Storage in laravel says symlink - no such file](https://stackoverflow.com/questions/47409417/storage-in-laravel-says-symlink-no-such-file)

I deployed laravel app on shared hosting in public_html/app folder. Here is everything from public folder. In /../../files I have rest of files. When I do php artisan storage:link in files folder my console says On localhost I upload files to storage/uploads folder. What to do now? I tried to change links but nothing works for me...

2017-11-21 09:21:10Z

I deployed laravel app on shared hosting in public_html/app folder. Here is everything from public folder. In /../../files I have rest of files. When I do php artisan storage:link in files folder my console says On localhost I upload files to storage/uploads folder. What to do now? I tried to change links but nothing works for me...Edited on May 1st 2018This problem comes when laravel project is moved/copied to some other folder.The storage link is still there thus causing the exception error. public/storage folder exists and points to wrong location and it needs to be deleted with rm storage command.After that run php artisan storage:link in terminal and it will create the storage link.This needs to be done EVERY time when laravel is moved/copied/deployed!I'm face same error when use share hosting and my public directory move to public_html or different directory

like : 

project directory in root name "project"

and public directory in root name "public_html"when run artisan command by Artisan::call('storage:link'); then face this error.Solution: 

 1st need to bind your public directory in app/Providers/AppServiceProvider register methodNow run the command its working fineThis usually happens after moving Laravel app to another directoryThe actual storage directory is "/AppName/storage/app/public/"Laravel creates a symbolic link pointing to actual storage dir  "/AppName/public/storage"Other meaning On changing root app directory to "/AnotherAppName/" symlink will still point to the old pathmy solution is to manually update the symlink usingDelete the existing storage symbolic link (public/storage) and then run 

php artisan storage:link command again.create new php file and put this code on the file:"CpanelUser" change to youre cpanel user name or host name.upload this file to public_html folder (www) of site

execute file with write site name+this file in browser

done!example:

my file name is symlink.php and site name is www.anysite.com

upload symlink.php to public_html folder in host and get web address in browserhttp://www.anysite.com/symlink.phpafter execute this file storage folder creite in public folder in laravel and link to storage folder in app.I was using Vagrant and had the same problem. I removed to storage directory in public/storage but couldn't resolve the problem when using the command php artisan storage:link.Therefore I connected with ssh to my vagrant box and ran the command there. It worked, so if you are running Vagrant and have the same problem this might help.Make sure the APP_URL configuration in .env file is set correctly. after that run following command line:

Empty string instead of null values Eloquent

Israel Ortuño

[Empty string instead of null values Eloquent](https://stackoverflow.com/questions/17452923/empty-string-instead-of-null-values-eloquent)

I'm trying to create entities using mass-assignment Eloquent feature...The problem's that this way, every field's filled out with an empty string instead of null values as I expected.I'm currently developing the system and still some table columns're not defined, that's why using this method, to avoid adding every new field to $fillable array and to a new Contact(array(...));...Also I've around 20 fields in this table, so It'd be a bit ugly to have an array such asAny tips of how to do this or fix?Update By now I've sorted out this doing the array_filter in the App::before() filter.Update In filter was a bit mess. I end up doing:And in my functions.php.By now only working with fields that ends with "_id". This is my biggest problem as if a relationship is not NULL, the database will throw an error as the foreign key "" cannot be found.Works perfect. Any comment?

2013-07-03 16:07:55Z

I'm trying to create entities using mass-assignment Eloquent feature...The problem's that this way, every field's filled out with an empty string instead of null values as I expected.I'm currently developing the system and still some table columns're not defined, that's why using this method, to avoid adding every new field to $fillable array and to a new Contact(array(...));...Also I've around 20 fields in this table, so It'd be a bit ugly to have an array such asAny tips of how to do this or fix?Update By now I've sorted out this doing the array_filter in the App::before() filter.Update In filter was a bit mess. I end up doing:And in my functions.php.By now only working with fields that ends with "_id". This is my biggest problem as if a relationship is not NULL, the database will throw an error as the foreign key "" cannot be found.Works perfect. Any comment?Use the model 'saving' event to look for empty models and explicitly set them to null. 'Project' is the name of my model in this example. Put this in a helper function and wire it up to all your models.UPDATE FOR LARAVEL 5 (April 11 2016)I also ended up creating an Http Middleware to cleanup the input data from the http request, in addition to cleaning up the data before it is sent to the database.I've looked for the answer to this myself, and the closest I can come up with is using Mutators (http://laravel.com/docs/eloquent#accessors-and-mutators).The same problem was solved by adding a (magic!) Mutator method for the foreign key field in the model:For a table with a lot of foreign keys, this can get kind of bulky, but it's the most "built-in" method I've found for handling this. The upside is that it's magic, so all you have to do is create the method and you're good to go.UPDATE -- Laravel 5.4 and aboveAs of Laravel 5.4, the \Illuminate\Foundation\Http\Middleware\ConvertEmptyStringsToNull::class middleware handles this when the request is received. In my example above, if the request contains an empty string value for 'header_image_id', this middleware automatically converts it to null before I can assign it to my model.If it is necessary you could remove any empty string in an array by filtering.Then if you have something like array('a' => 'a', 'b' => '') you will get: array('a' => 'a').As far as I know, if a field is not specified in the array for mass-assignment, then Laravel Eloquent ORM will treat it like NULL.orProbably more generic solution:The model where you needs to sanitize empty form fields should extends this class, then you should fill $forcedNullFields array with field names that required to be NULL in case of empty form fields:And thats all, you should not repeat same code in mutators.For a form input, it's normal, and more logical to have empty values, rather then null values.If you really think the best way to do this, is to directly put the input into your database, than the solution to make empty values null would be something like this.Personally I don't approve with these kind of solutions, but it does work for some people.Another simple solution is to create base model class and extend models from it:Then just fill required fields in $forcedNullFields for each model if needed.In your Eloquent model, make sure $guarded is empty. You don't need to set $fillable.Mass assignment isn't usually a good idea, but it's OK to do in some scenarios - you must determine when.See: http://laravel.com/docs/eloquent#mass-assignment

Laravel 5 controller sending JSON integer as string

Muggles

[Laravel 5 controller sending JSON integer as string](https://stackoverflow.com/questions/31527050/laravel-5-controller-sending-json-integer-as-string)

On my development server the JSON response from the Laravel 5 controller shows the data in the correct types.e.gBut on the production server, the JSON response is sent back as strings.Both development and production have the same version of PHP installed (5.6.11-1).Any ideas on what may be causing this behaviour?

2015-07-20 21:58:33Z

On my development server the JSON response from the Laravel 5 controller shows the data in the correct types.e.gBut on the production server, the JSON response is sent back as strings.Both development and production have the same version of PHP installed (5.6.11-1).Any ideas on what may be causing this behaviour?Make sure to use MySQL Native Driver which will support native data types.MySQL Client Library will return all fields as strings.Another solution would be to use json_encode options with JSON_NUMERIC_CHECK.For example:I just ran into this same issue! For those of you looking for a more appropriate solution, you might want to check out the $casts property for Eloquent models.The accepted solution will work, but it will also convert fields that you may not want converted. I would recommend adding this to your Eloquent model:This will convert the values directly in your model object, so you won't need to worry about updating multiple endpoints. I hope this helps others as it did me!you can return the integer with typecasting like 

Laravel classloader.php error failed to open stream: No such file or directory

Matt

[Laravel classloader.php error failed to open stream: No such file or directory](https://stackoverflow.com/questions/31284774/laravel-classloader-php-error-failed-to-open-stream-no-such-file-or-directory)

I am able to run "php artisan migrate" fine. I'm able to get all the form input if I use Request::all() but when I try to add the data to my mysql database table I get the below error:I currently have the form attached to a controller method with the below code:I know that I am properly connected to mysql server because I'm able to migrate my migrations.Any help would be great. Also why did laravel change so many things in Laravel 5?Thanks

2015-07-08 06:09:51Z

I am able to run "php artisan migrate" fine. I'm able to get all the form input if I use Request::all() but when I try to add the data to my mysql database table I get the below error:I currently have the form attached to a controller method with the below code:I know that I am properly connected to mysql server because I'm able to migrate my migrations.Any help would be great. Also why did laravel change so many things in Laravel 5?ThanksYou have to run composer dumpautoload inside your project folder.ClassLoader.php Load the given class file into Laravel. Similar errors are due to failure to autoload new classes.composer dump-autoload regenerates the list of all classes that need to be included in the project (autoload_classmap.php). It won’t download anything. When to use: 

When you have a new class inside your project, Run it from the project root. 

Laravel 5.2 $errors not appearing in Blade

Neal Crowley

[Laravel 5.2 $errors not appearing in Blade](https://stackoverflow.com/questions/34438463/laravel-5-2-errors-not-appearing-in-blade)

So I'm following along with the Laravel 5 fundamentals tutorial and I am stuck on the form validation. I have followed along exactly with the tutorial but I am getting a Undefined variable: errors in my create articles view.In the tutorial I am following and what I have found online they say the errors variable is always there in the blade file for you to use so I don't know what i am doing wrong?Any help would be appreciated! loving Laravel except for this error!ControllerRequest validation

2015-12-23 15:05:19Z

So I'm following along with the Laravel 5 fundamentals tutorial and I am stuck on the form validation. I have followed along exactly with the tutorial but I am getting a Undefined variable: errors in my create articles view.In the tutorial I am following and what I have found online they say the errors variable is always there in the blade file for you to use so I don't know what i am doing wrong?Any help would be appreciated! loving Laravel except for this error!ControllerRequest validationThis is a breaking problem with the 5.2 upgrade.  What's happening is the middleware which is responsible for making that errors variable available to all your views is not being utilized because it was moved from the global middleware to the web middleware group.There are two ways to fix this: SolvedYou may change any one of the following:1. put your working route (app/http/routes.php) onRoute::group(['middleware' => ['web']], function () {

    // Here like

    Route::get('/', 'TodoController@index');

    Route::post('/', 'TodoController@store');

});Screenshot - 2. Move your protected $middlewareGroups web (app/Http/Kernel.php) on protected $middleware = []Screenshot -simply, you have to move : from protected $middlewareGroups to protected $middlewareThis is solution:Change the defination of your Route groups with a middleware, from :toSource: https://github.com/laravel/framework/issues/13000From protected $middlewareGroups to protected $middleware in kernel.php page As the Laravel Documentation says: So removing from routes.php file would be the correct way.Posting this as it might be useful for others, As Smartrahat mentioned in 1st solution, in your Kernel.php file(app/Http/Kernel.php) move \Illuminate\View\Middleware\ShareErrorsFromSession::class

from $middlewareGroups to protected $middleware property, but the same will start throwing the error "Session store not set on request", to resolve this move

\Illuminate\Session\Middleware\StartSession::class, to $middleware property as well.As of 5.2, routes.php is by default already called in the context of a ['middleware'=>'web'] by RouteServiceProvider. But in routes.php default generation of auth routes, the Route::group call is still happening by default - so if you delete that Route::group declaration from routes.php the application then correctly shows errors.A couple of observations regarding this issue. First off there a related bug in github regarding this issue

PFA

https://github.com/laravel/framework/issues/12022If you look at the last comment which Graham wrote, I think that is the facing I was facing.

For me even though there was a error in form post data, I was getting the below equalityIn my case I added log statements in the the above  middleware class ran twice for a given request, I am not sure why it ran twice, but I think because of this the $errors variable is getting reset.

I was using this configuration (which I think came default with Laravel@5.2.43)I changed the configuration which worked for me and the $errors variable's count is not zero (also the above middleware ran only once per request)Note:

All my routes are in the web middleware group before and after the Kernel.php configuration change, I didnot move my routes at all from the web middleware group.Change @foreach($errors->any() as $error) to @foreach($errors->all() as $error)in this case laravel 5.2 you can refer may example code and edit your kernal.php file. move this  \Illuminate\View\Middleware\ShareErrorsFromSession::class, form middlewareGroups to middleware and add  \Illuminate\Session\Middleware\StartSession::class, to  middleware 

then its work correctly.Having both Web and API requirements in our application, we did not want to move the middleware around; perhaps that would have worked, however:We had the very peculiar situation that the flash[] and $errors session data was transmitted correctly between the standard laravel resource methods, store() and edit(), but in some cases the data did not get back across nearly identical methods, storeSale() and editSale().We found that in our development and deployment environments, the 'file' and 'database' session drivers worked in all cases, but the 'cookie' driver did not.Switching to the database driver in all instances solved the problem.

Laravel not sending email and not giving errors

Daniel Barde

[Laravel not sending email and not giving errors](https://stackoverflow.com/questions/23980979/laravel-not-sending-email-and-not-giving-errors)

I've been on a project for the past four months now and I am really pissed at what am facing with Laravel right now. It's not sending emails; I set it up to use the mail driver and put in the right code, but it seems not to work at all. Besides not working, it doesn't even give me an error!Here is my configuration:Here is my PHP code  for sending email:

2014-06-01 14:39:11Z

I've been on a project for the past four months now and I am really pissed at what am facing with Laravel right now. It's not sending emails; I set it up to use the mail driver and put in the right code, but it seems not to work at all. Besides not working, it doesn't even give me an error!Here is my configuration:Here is my PHP code  for sending email:First and foremost, go to the app/config/mail.php and change the driver to「mail」. Also put the host as blank.In my scenario email was being queued so that is why I got no output. I had forgotten I set email to queue by default. I looked in the Jobs table I saw all my messages waiting in there. I ran php artisan queue:work to get the queue running/sending them.It could be because you have a ".env" file, in the Laravel project root, with mail server configuration like this:It seems the ".env" file just overrides "config/mail.php" file. You can just remove same lines from the ".env" file for use "config/mail.php" configuration options.Go to .env file and set Or you can set driver from the config files. Go to file

Laravel 4 : app/config/mail.php

Laravel 5 : config/mail.php

and set You may use SMTP. Hope It will help.The Fix That Worked For MeAfter that my mail started sending! How I Arrived At That FixI had previously set my SMTP details up correctly, but even after doing config:cache config:clear and restarting my server, the emails were not sending. After that I compared it to my working Laravel App, and the only difference was the 127.0.0.1 -> http://localhost, so I changed that as a last ditch attempt, and it worked.A solution for notifications not sent via 'mail'https://laravel.com/docs/5.7/notifications#customizing-the-recipientConfiguration file:Then run the make:mail command:Routes:Controller:View:Mail:Thing to remember: The message variable is a build-in variable and will generate error so use any other variable instead of message.More details:Change the driver in your config file to 'smtp' from 'mail'. I guess that should work. I finally got it to work. If you're using mailgun, add this information below to your .env fileand then runFor Laravel 6, if verification email is not send anymore:in user.php addandand in routes/web.phpFirstle go to your project root on cmd and run this cmd -Go to .env fileGo to project root and use this cmdafter that goto App\mail\WelcomeUserVerifyMail

add these line -In your controller where you use mail functionality -Not a technical answer but it fixed my issue.If your using GMAIL to check the incoming mail just make sure you check your SPAM folder.run as

Laravel migrations nice way of disabling foreign key checks

Pavlin

[Laravel migrations nice way of disabling foreign key checks](https://stackoverflow.com/questions/34298639/laravel-migrations-nice-way-of-disabling-foreign-key-checks)

When running laravel migrations, I am facing a small inconvenience. I use Laravel 5.1.Since there are a lot of tables with many relationships, it is probably impossible that I rename the migration files so they run in the correct order, so no foreign key constraint is violated. This was what I did once in the past, and it was very inpractical.What I'm doing now is defining each migration like this:The problem with this is that it's tedious to write and it clutters up the code.I've also thought about creating two dummy migration files, whose only purpose would be to enable and disable the foreign key checks, and I would name them in such a way that they would run at the beginning and the end of each migration.If there is an elegant solution, would it be possible to apply it to the seeding process as well, since this tends to be a problem there as well.This is obviously a very improvised solution, and I am asking if there is a better way of doing it. Is there some beforeMigrate and afterMigrate methods that I can override or something along those lines?And if not, how do you go about doing it?Any insights would be appreciated, I dislike all the options I have stated.

2015-12-15 20:20:46Z

When running laravel migrations, I am facing a small inconvenience. I use Laravel 5.1.Since there are a lot of tables with many relationships, it is probably impossible that I rename the migration files so they run in the correct order, so no foreign key constraint is violated. This was what I did once in the past, and it was very inpractical.What I'm doing now is defining each migration like this:The problem with this is that it's tedious to write and it clutters up the code.I've also thought about creating two dummy migration files, whose only purpose would be to enable and disable the foreign key checks, and I would name them in such a way that they would run at the beginning and the end of each migration.If there is an elegant solution, would it be possible to apply it to the seeding process as well, since this tends to be a problem there as well.This is obviously a very improvised solution, and I am asking if there is a better way of doing it. Is there some beforeMigrate and afterMigrate methods that I can override or something along those lines?And if not, how do you go about doing it?Any insights would be appreciated, I dislike all the options I have stated.I had a similar task at hand when Lumen / Laravel started using Passport and I had to ditch the previous oauth server implementation from lucadegasperi/oauth2-server-laravel.I finally managed to get things going by creating 2 migrations, where the first one clears foreign keys and the second one actually deletes the tables.I had to use dates before the migrations of Laravel's Passport (2016-06-01) so they will be executed before those.2016_05_31_000000_clear_old_oauth_relations.phpAnd in the second file

2016_05_31_000001_clear_old_oauth.phpI got this done by extracting the foreign key logic into a separate migration file. This helped me to:In code:Another important aspect to remember is to drop the foreignKey FIRST, then the column. Dropping the column first throws the error: Cannot drop index 'tableName_columnName_foreign': needed in a foreign key constraintThe proper order matters:

Tell Composer to use Different PHP Version

Boom

[Tell Composer to use Different PHP Version](https://stackoverflow.com/questions/32750250/tell-composer-to-use-different-php-version)

I've been stuck at this for a few days. I'm using 1and1 hosting, and they have their PHP set up a bit weird.If I use just php composer.phar install, then I'm using PHP 4.4.6, which is horribly insufficient. However, I can run php5.5 composer.phar install, get a little bit further, but it still fails because somewhere along the line, PHP is called again, but it fails, as it's using 4.4.6.Is there any way to tell Composer to use the php5.5 command? Has anyone successfully gotten Composer configured on 1and1 hosting?I'm trying to get Laravel up and running (which uses Composer). I've been able to do it on my GoDaddy domain, but not 1and1.

2015-09-23 22:01:48Z

I've been stuck at this for a few days. I'm using 1and1 hosting, and they have their PHP set up a bit weird.If I use just php composer.phar install, then I'm using PHP 4.4.6, which is horribly insufficient. However, I can run php5.5 composer.phar install, get a little bit further, but it still fails because somewhere along the line, PHP is called again, but it fails, as it's using 4.4.6.Is there any way to tell Composer to use the php5.5 command? Has anyone successfully gotten Composer configured on 1and1 hosting?I'm trying to get Laravel up and running (which uses Composer). I've been able to do it on my GoDaddy domain, but not 1and1.Ubuntu 18.04 case ... this run for me.On xubuntu I had php 7.2 as default. But needed to run composer with php 5.6.So this worked for me:Just add below code to your composer.json file to set different php version.Try this approachI too have a shared hosting account on 1&1 (ionos) and here's what I have had to do:if you login as the root ssh account, you can create a ~/.bash_profile and addto it so that you can now use the commands you would normally use and it just works. (put composer.phar in your project folder root)Then, make sure your laravel composer.lock file from your dev machine gets up to your project folder on 1and1 and run I still had STDIN issues with artisan commands so make sure you change the .env file tobecause having it set to production throws infinite STDIN warnings as it waits for you to type yes. At least on my account it does.Hope this helps somebody.You could change your PATH to override the php version.In /home/user/bin (or any other directory really) make a symlink named php to the php5 binary.Another option, use a shell alias:php5.5 composer.phar install fails because your composer.json is telling it to run php and not php5.5, edit the file composer.json replace the php scripts references to php5.5. Example:From:To:Even when doing this, 1and1 has a memory limit for scripts execution so php5.5 composer.phar install won't fail but it won't complete its execution either. You can still run the scripts post install manually.I have deployed Laravel webapps to 1and1 without commit vendor directory, following this guide: Deploy Laravel Webapp to 1and1composer is a PHP binary script and it's using Unix Shebang to define which interpreter for executing.So if you're running composer without any specific option, it will use your PHP version at /usr/bin/env php (which is your default PHP)We can have many versions of PHP inside your Linux and you can flexible use which PHP version for executing as you want like this way:Or justTo check & find all installed PHP packages, goto /usr/bin/ Know this question is a bit old... but if you pull down composer into your app root:https://getcomposer.org/download/Instead of relying on global composer, then you can run:or I believe newer homstead versions would be like:https://laracasts.com/discuss/channels/laravel/run-composer-commands-with-different-php-versionsYou could try and copy the php and php-config files into /usr/local/bin instead.  That path has a higher order of precedence and should override the /usr/bin folder without needing to disable SIP.  That is what I did.

Class 'UserTableSeeder' does not exist - Laravel 5.0 [php artisan db:seed]

thirdriver

[Class 'UserTableSeeder' does not exist - Laravel 5.0 [php artisan db:seed]](https://stackoverflow.com/questions/36206742/class-usertableseeder-does-not-exist-laravel-5-0-php-artisan-dbseed)

I'm trying a basic php artisan db:seed after migrating my database but it keeps returning the title error in cmd -[ReflectionException] Class 'UserTableSeeder' does not existThings I Have TriedBelow is the migrationsBelow is the UserTableSeeder.phpBelow is the DatabaseSeeder.php

2016-03-24 17:47:31Z

I'm trying a basic php artisan db:seed after migrating my database but it keeps returning the title error in cmd -[ReflectionException] Class 'UserTableSeeder' does not existThings I Have TriedBelow is the migrationsBelow is the UserTableSeeder.phpBelow is the DatabaseSeeder.phpRun composer dumpautoload after creating files in the database/ folder.Why?Check the composer.json autoload section and you'll see the database/ folder is loaded by "classmap" (source):The Composer docs describe classmap as:Emphasis added. You need to run the composer dumpautoload command to generate a new classmap every time you add a file to database/, otherwise it will not be autoloaded.The app/ folder, by contrast, uses the PSR-4 standard for converting a fully qualified class name to a filesystem path. This is why you don't need to dumpautoload after adding files there.Try changing toand try runningSometimes the code is correct but you need to run the following command in order to run the seeder command.

First Run this commandThen seed the seederI hope it will workWhen we change or delete the Controller file or another file then their file should be removed from everywhere in code. You need to run command to refresh your composer

Laravel password validation rule

Bharanikumar

[Laravel password validation rule](https://stackoverflow.com/questions/31539727/laravel-password-validation-rule)

How to added password validation rule in the validator?Validation rule:The password contains characters from at least three of the following five categories:How to add above rule in the validator rule?My Code Here

2015-07-21 12:59:49Z

How to added password validation rule in the validator?Validation rule:The password contains characters from at least three of the following five categories:How to add above rule in the validator rule?My Code HereI have had a similar scenario in Laravel and solved it in the following way.The password contains characters from at least three of the following five categories:First, we need to create a regular expression and validate it.Your regular expression would look like this:I have tested and validated it on this site. Yet, perform your own in your own manner and adjust accordingly. This is only an example of regex, you can manipluated the way you want.So your final Laravel code should be like this: Update

As @NikK in the comment mentions, in Laravel 5.6 the the password value should encapsulated in array Square brackets likeI have not testing it on Laravel 5.6 so I am trusting @NikK hence I have moved to working with c#/.net these days and have no much time for Laravel.Note: Some online referencesRegarding your custom validation message for the regex rule in Laravel, here are a few links to look at:This doesn't quite match the OP requirements, though hopefully it helps. With Laravel you can define your rules in an easy-to-maintain format like so:Would output:(The regex rules share an error message by default—i.e. four failing regex rules result in one error message)Sounds like a good job for regular expressions. Laravel validation rules support regular expressions. Both 4.X and 5.X versions are supporting it :This might help too:http://www.regular-expressions.info/unicode.html

Mongo groupby is not working with different time in Laravel raw method

Sarath TS

[Mongo groupby is not working with different time in Laravel raw method](https://stackoverflow.com/questions/45568957/mongo-groupby-is-not-working-with-different-time-in-laravel-raw-method)

The below code is to fetch data from MongoDB and plot sum of amounts and dates in a graph within date range (sum(prepayment_amount) and sum(total_prepayment_amount) group by checkin_from date). The sum of amounts is in y axis and date is in x axis.  From this code, I am getting the sum of amounts and date but the problem is, see date and time 2017-10-05T19:07:17Z & 2017-10-05T00:00:00Z. In this case (sum(prepayment_amount) and sum(total_prepayment_amount) dates are plotting separately.  If date and time is 2017-10-05T00:07:17Z & 2017-10-05T00:00:00Z, I am getting a correct result.I don't know where is the issue. I have added expected results. Any help would be appreciated. ThanksBooking.php (model)DashbardController.phpBooking CollectionExpecting resultImagePlease check the image, here you can find the problem. For better understanding I have listed time also in the x-axis.Note: In graph data not match with question data because I have connected a database with a test server.

2017-08-08 12:54:35Z

The below code is to fetch data from MongoDB and plot sum of amounts and dates in a graph within date range (sum(prepayment_amount) and sum(total_prepayment_amount) group by checkin_from date). The sum of amounts is in y axis and date is in x axis.  From this code, I am getting the sum of amounts and date but the problem is, see date and time 2017-10-05T19:07:17Z & 2017-10-05T00:00:00Z. In this case (sum(prepayment_amount) and sum(total_prepayment_amount) dates are plotting separately.  If date and time is 2017-10-05T00:07:17Z & 2017-10-05T00:00:00Z, I am getting a correct result.I don't know where is the issue. I have added expected results. Any help would be appreciated. ThanksBooking.php (model)DashbardController.phpBooking CollectionExpecting resultImagePlease check the image, here you can find the problem. For better understanding I have listed time also in the x-axis.Note: In graph data not match with question data because I have connected a database with a test server.In the $group you are using $checkin_from directly as a date with time hence it is grouped by date AND time.The answer is to use $dateFormat so we have only the date without the time:You can use this group stag, Where I am convert string into number. total_prepayment_amount and prepayment_amount are string as per provided data 

  they should be integer to $sum. like this in query for mongodbPlease make sure mongodb ^4.0 (for use $toInt) 

Laravel 5.1 Eloquent ORM randomly returning incorrect relationship - *major update*

BrynJ

[Laravel 5.1 Eloquent ORM randomly returning incorrect relationship - *major update*](https://stackoverflow.com/questions/33607125/laravel-5-1-eloquent-orm-randomly-returning-incorrect-relationship-major-upda)

I have a Laravel app that powers an ecommerce website with moderate traffic. This website allows people to place orders via the frontend, but it also has backend functionality for taking orders over the phone via a call centre. An order is related to a customer, and a customer can optionally be a user - a user being someone with a login to the frontend. A customer with no user account is only ever created as a result of an order being taken via the call centre.The issue I have encountered is very odd, and I believe might be some kind of Laravel bug. It only occurs very occasionally, but what is happening is that when an order is taken via the call centre for a customer with no user account, an order confirmation is being sent out to a random user - literally random, as far as I can tell, just plucked out of the database despite no relation in the data.These are the relevant parts of the models in the project:These are the database migrations for the above (edited for brevity):The logic that sends the order confirmation is within an event handler that gets fired after the order has been paid. Here is the OrderSuccess event (edited for brevity):As can be seen, this event is passed an Order model object.Here is the event handler (edited for brevity):There is a check to see if the $order->customer->user object is not null and, if true, an order confirmation is sent. If it is null (which it frequently is), then no confirmation is sent.As can be seen from the above, I added a log to record the objects when an email is sent. Here is an example of an erroneous one (again, truncated for brevity):As you can see, there is no user_id for Customer, and yet Laravel has returned a User object.What is more, if I manually fire the exact same OrderSuccess event, the above is not reproducible - it does not send the email, and it does not load a User object.As I said before, this issue is happening very infrequently - there are on average about 40 orders a day via the call centre for customers with no user account, and the highlighted issue might only occur once or twice a week.I'm not familiar enough with Laravel to know what might be the issue here - is it some form of model caching, a problem with Eloquent ORM, or some other gremlin in the system?Any ideas appreciated - I may post this problem in the Laravel github issue tracker if it appears to be some form of bug.Update Relating to some of the answers / comments put forward, I have tried to remove any potential Eloquent ORM issues, to retrieve the data manually, like so:The above is still producing the same random results - unrelated users are being retrieved even when the customer has no user_id (it's NULL in this instance).Update 2 As the first update did not help in any way, I reverted to using the original Eloequent approach. To try another solution, I took my event code out of the event handler, and placed it in my controller - I was previously firing by OrderSuccess event using Event::fire(new OrderSuccess ($order));, and instead I commented this line out and just placed the event handler code in the controller method:The above change has been on the production site for over a week now - and since that change, there has not been a single instance of the issue. The only possible conclusion I can reach is some kind of bug in the Laravel event system, somehow corrupting the passed object. Or could something else be at play? Update 3

It seems I was premature to state that moving my code outside the event fixed the issue - in fact, via my logging, in the last 2 days I can see some more incorrect order confirmation were sent out (a total of 5, after almost 3 weeks of no issues).I noticed that the user ids that had received the rogue order confirmations appeared to be incrementing (not without gaps, but still in ascending order). I also noticed that each of the problem orders had been paid for via cash and account credit - most are cash only. I looked further into this, and the user ids are actually the ids of the related credit transactions! The above is the first cast iron breakthrough in trying to resolve this issue. On closer inspection, I can see that the issue is still random - there are quite a few (at least 50%) orders that have been paid via account credit for customer's with no user account, but that have not caused incorrect emails to be sent out (despite the associated credit transaction id having a user id match).So, the problem is still random, or seemingly so. My credit redemption event is triggered like so:The above is called just prior to my OrderSuccess event - as you can see, both events are passed the $order model object.My CreditRedemption event handler looks like this:The $credit_transaction->save(); is generating the id in my credit_transactions table that is somehow being used by Laravel to retrieve a user object. As can be seen in the above handler, I'm not updating my $order object at any point. How is Laravel using (remember, still randomly, some < 50% of the time) the id of my newly created $credit_transaciton to populate the $order->customer->user model object?

2015-11-09 10:29:05Z

I have a Laravel app that powers an ecommerce website with moderate traffic. This website allows people to place orders via the frontend, but it also has backend functionality for taking orders over the phone via a call centre. An order is related to a customer, and a customer can optionally be a user - a user being someone with a login to the frontend. A customer with no user account is only ever created as a result of an order being taken via the call centre.The issue I have encountered is very odd, and I believe might be some kind of Laravel bug. It only occurs very occasionally, but what is happening is that when an order is taken via the call centre for a customer with no user account, an order confirmation is being sent out to a random user - literally random, as far as I can tell, just plucked out of the database despite no relation in the data.These are the relevant parts of the models in the project:These are the database migrations for the above (edited for brevity):The logic that sends the order confirmation is within an event handler that gets fired after the order has been paid. Here is the OrderSuccess event (edited for brevity):As can be seen, this event is passed an Order model object.Here is the event handler (edited for brevity):There is a check to see if the $order->customer->user object is not null and, if true, an order confirmation is sent. If it is null (which it frequently is), then no confirmation is sent.As can be seen from the above, I added a log to record the objects when an email is sent. Here is an example of an erroneous one (again, truncated for brevity):As you can see, there is no user_id for Customer, and yet Laravel has returned a User object.What is more, if I manually fire the exact same OrderSuccess event, the above is not reproducible - it does not send the email, and it does not load a User object.As I said before, this issue is happening very infrequently - there are on average about 40 orders a day via the call centre for customers with no user account, and the highlighted issue might only occur once or twice a week.I'm not familiar enough with Laravel to know what might be the issue here - is it some form of model caching, a problem with Eloquent ORM, or some other gremlin in the system?Any ideas appreciated - I may post this problem in the Laravel github issue tracker if it appears to be some form of bug.Update Relating to some of the answers / comments put forward, I have tried to remove any potential Eloquent ORM issues, to retrieve the data manually, like so:The above is still producing the same random results - unrelated users are being retrieved even when the customer has no user_id (it's NULL in this instance).Update 2 As the first update did not help in any way, I reverted to using the original Eloequent approach. To try another solution, I took my event code out of the event handler, and placed it in my controller - I was previously firing by OrderSuccess event using Event::fire(new OrderSuccess ($order));, and instead I commented this line out and just placed the event handler code in the controller method:The above change has been on the production site for over a week now - and since that change, there has not been a single instance of the issue. The only possible conclusion I can reach is some kind of bug in the Laravel event system, somehow corrupting the passed object. Or could something else be at play? Update 3

It seems I was premature to state that moving my code outside the event fixed the issue - in fact, via my logging, in the last 2 days I can see some more incorrect order confirmation were sent out (a total of 5, after almost 3 weeks of no issues).I noticed that the user ids that had received the rogue order confirmations appeared to be incrementing (not without gaps, but still in ascending order). I also noticed that each of the problem orders had been paid for via cash and account credit - most are cash only. I looked further into this, and the user ids are actually the ids of the related credit transactions! The above is the first cast iron breakthrough in trying to resolve this issue. On closer inspection, I can see that the issue is still random - there are quite a few (at least 50%) orders that have been paid via account credit for customer's with no user account, but that have not caused incorrect emails to be sent out (despite the associated credit transaction id having a user id match).So, the problem is still random, or seemingly so. My credit redemption event is triggered like so:The above is called just prior to my OrderSuccess event - as you can see, both events are passed the $order model object.My CreditRedemption event handler looks like this:The $credit_transaction->save(); is generating the id in my credit_transactions table that is somehow being used by Laravel to retrieve a user object. As can be seen in the above handler, I'm not updating my $order object at any point. How is Laravel using (remember, still randomly, some < 50% of the time) the id of my newly created $credit_transaciton to populate the $order->customer->user model object?I can't help you get to the root of whats causing your issue, but I can offer a possible work around based on the logic you provided in Update 1 of your question. Because a customers user_id can be null, it may be more effective to limit the returned customers to those who have a user_id. This can be achieved by using the whereNotNull() method. We can then go on to check if a customer was returned, and if so send the email, etc.By not giving the application a chance to return a customer with a null user_id this should hopefully solve your issue, but unfortunately it doesn't shine any light on why it is happening in the first place.Shouldn't your migrations havefor example:As mentioned in the Laravel Doc?I am not sure if your migrations are defined correctly specially when compared to your Models. If you are using belongsTo and hasOne relationship, you should use foreign key references in migrations. Now you will need to set this column whenever an actual user exists when the customer record is being created. But you don't actually have to set this column manually. You can do this below as you are using relationships:Step 1: Save the customer first.Step 2: Now we will set the user_id on the customer if exists. To do this, you can get the user object in $user and then just callThe code above will automatically set the user_id on customers tableThen I will check if user record exists in this way below:It is not necessary to have FK.

Eloquent can mange to build relations based on the name of the columns. Change the name of the fields. The name of the field should match table name with suffix "_id". In the customers table user_id should be users_id. In orders customer_id should be customers_id. You can try to pass the name of the field you want to join with:I am not very advanced user with Laravel so this might not work. I had the same issue and I solved it by renaming all models and columns to match table names (with "s").your user_id field in customers table should be nullable.

laravel model callbacks after save, before save, etc

Orbitum

[laravel model callbacks after save, before save, etc](https://stackoverflow.com/questions/13518674/laravel-model-callbacks-after-save-before-save-etc)

Are there callbacks in Laravel like:I searched but found nothing. If there are no such things - what is best way to implement it?Thanks!

2012-11-22 19:01:17Z

Are there callbacks in Laravel like:I searched but found nothing. If there are no such things - what is best way to implement it?Thanks!Actually, Laravel has real callback before|after save|update|create some model. check this:https://github.com/laravel/laravel/blob/3.0/laravel/database/eloquent/model.php#L362the EventListener like saved and saving are the real callbacks how can we work with that? just assign it to this eventListener example:The best way to achieve before and after save callbacks in to extend the save() function.Here's a quick exampleSo now when you save a Page object its save() function get called which includes the parent::save() function;Adding in an example for Laravel 4:Even though this question has already been marked 'accepted' - I'm adding a new updated answer for Laravel 4.Beta 4 of Laravel 4 has just introduced hook events for Eloquent save events - so you dont need to extend the core anymore:In Laravel 5.7, you can create a model observer from the command line like this:Then in your app\AppServiceProvider tell the boot method the model to observe and the class name of the observer.Then in your app\Observers\ you should find the observer you created above, in this case ClientObserver, already filled with the created/updated/deleted event hooks for you to fill in with your logic.  My ClientObserver:I really like the simplicity of this way of doing it.  Reference https://laravel.com/docs/5.7/eloquent#eventsIf you want control over the model itself, you can override the save function and put your code before or after __parent::save().Otherwise, there is an event fired by each Eloquent model before it saves itself.There are also two events fired when Eloquent saves a model."eloquent.saving: model_name" or "eloquent.saved: model_name".http://laravel.com/docs/events#listening-to-eventsYour app can break using afarazit solution*

Here's the fixed working version:NOTE: saving or any other event won't work when you use eloquent outside of laravel, unless you require the events package and boot the events. This solution will work always.So now when you save a Page object its save() function get called which includes the parent::save() function;afarazit* I tried to edit his answer but didn't work

Find or Create with Eloquent

charleyh

[Find or Create with Eloquent](https://stackoverflow.com/questions/20309033/find-or-create-with-eloquent)

I have recently started working with Laravel and Eloquent, and was wondering about the lack of a find or create option for models. You could always write, for example:However, is there not a better way to find or create? It seems trivial in the example, but for more complex situations it would be really helpfully to either get an existing record and update it or create a new one.

2013-12-01 05:26:49Z

I have recently started working with Laravel and Eloquent, and was wondering about the lack of a find or create option for models. You could always write, for example:However, is there not a better way to find or create? It seems trivial in the example, but for more complex situations it would be really helpfully to either get an existing record and update it or create a new one.Below is the original accepted answer for: Laravel-4There is already a method findOrFail available in Laravel and when this method is used it throws ModelNotFoundException on fail but in your case you can do it by creating a method in your model, for example, if you have a User model then you just put this function in the modelFrom your controller, you can useIf a user with id of 5 exists, then it'll be updated, otherwise a new user will be created but the id will be last_user_id + 1 (auto incremented).This is another way to do the same thing:Instead of creating a static method, you can use a scope in the Model, so the method in the Model will be scopeMethodName and call Model::methodName(), same as you did in the static method, for exampleThe firstOrCreate is available in Laravel 5x, the answer is too old and it was given for Laravel-4.0 in 2013.In Laravel 5.3, the firstOrCreate method has the following declaration:Which means you can use it like this:User's existence will be only checked via email, but when created, the new record will save both email and name.API DocsAlternatively, in this case you can also use Laravel's function and search for id as an attribute, i.e.Laravel 4 models have a built-in findOrNew method that does what you need:Find or New based on primary key idFirst or New based on non-primary key single filedFirst or New based on non-primary key multiple filedIn Laravel 5:

There are two methods you may use to create models by mass assigning attributes: firstOrCreate and firstOrNew. 

The firstOrCreate method will attempt to locate a database record using the given column / value pairs. If the model can not be found in the database, a record will be inserted with the given attributes.

The firstOrNew method, like firstOrCreate will attempt to locate a record in the database matching the given attributes. However, if a model is not found, a new model instance will be returned. Note that the model returned by firstOrNew has not yet been persisted to the database. You will need to call save manually to persist it:You can use firstOrCreate (It's working with Laravel 4.2)returns found instance or new instance.

Generate Controller and Model

Sophy

[Generate Controller and Model](https://stackoverflow.com/questions/14265996/generate-controller-and-model)

I am newbie with Laravel and I played around laravel 4(Beta version). I want to know how to generate Controller and Model by command line use php artisan. But I don't know how to do them.

2013-01-10 19:44:19Z

I am newbie with Laravel and I played around laravel 4(Beta version). I want to know how to generate Controller and Model by command line use php artisan. But I don't know how to do them.See this video: http://youtu.be/AjQ5e9TOZVk?t=1m45s

You can do php artisan list to view all commands, 

The command for generating REST-ful controllers is controller:make

You can view the usage with: php artisan help make:controllerLaravel 5The other answers are great for Laravel 4 but Laravel 5 is here! We now have the ability to generate all kinds of stuff by default. Run php artisan help to view all artisan commands. Here are all of the make commands:Note: we no longer use item:make. Instead we now have make:item. Run php artisan help make:item to see what you can pass it. For instance php artisan help make:migration shows that we need to pass it the migration name but we can also pass it --create="" or --table="" to specify the table name to create or modify respectively. Run php artisan make:migration create_articles_table --create="articles" to generate the articles table. Moreover, generating models takes care of generating the migration for that model. Follow the naming conventions and it will be pluralized it for the migration. Thank you @user1909426, I can found solution by php artisan list it will list all command that was used on L4. It can create controller only not Model. I follow this command to generate controller.On Laravel 5, the command has changed:Note: [Name] name of controllerMake resource controller with Model.php artisan make:controller PostController --model=PostFor generate Model , controller with resources and migration best command is:laravel artisan does not support default model and view generation. check this provider https://github.com/JeffreyWay/Laravel-4-Generators to generate models, views, seeder etc.You can make a plain controller file likeModels:Create with Resource MethodUse It With a pathMake model , Controller by Make model , Controller with Resource Use:e.g

Laravel migration array type (store array in database column)

Zakaria Acharki

[Laravel migration array type (store array in database column)](https://stackoverflow.com/questions/32954424/laravel-migration-array-type-store-array-in-database-column)

I want to store an array of integers in my table and I can't find any type that supports array in Documentation, any suggestion.Migration:

2015-10-05 17:28:08Z

I want to store an array of integers in my table and I can't find any type that supports array in Documentation, any suggestion.Migration:The array datatype is not present in all database systems and because Laravel's Schema Builder is database agnostic, it doesn't offer methods to create non-common datatype columns. So you have two options:1. Use a raw SQL statement to add the column, something like the statement below I think should work. Although I'm not sure if the Query Builder or Eloquent can handle these types of columns correctly:2. Use Eloquent's available workaround by using attribute casting. In your migration create the column as json like so:Then you can setup your Pickup model (if you haven't done so already) and use the $casts property:This will let Eloquent know that when it fetches data from the database it will have to convert the shifts column value to an array. This is only emulating an actual array, as at the database level the column is of type TEXT and the array is serialized. However when unserializing the column value, Eloquent returns an actual array of integers for you to use in your code. Below is an example use case:Assuming the above generated an entry with id equal to 1 when you later retrieve the entry:The dump() from the code above will output an actual array of integers:

Laravel retrieve binded model in Request

Phil Cross

[Laravel retrieve binded model in Request](https://stackoverflow.com/questions/29775032/laravel-retrieve-binded-model-in-request)

Is there any easy way of retrieving the route binded model within a Request?I want to update a model, but before I do, I want to perform some permissions checks using the Requests authorize() method. But I only want the owner of the model to be able to update it.In the controller, I would simply do something like this:But I'm looking to do this within the Request, rather than within the controller. If I do:It only gives me the scalar form properties (such as _method and so on, but not the model).QuestionIf I bind a model to a route, how can I retrieve that model from within a Request?Many thanks in advance.

2015-04-21 14:24:12Z

Is there any easy way of retrieving the route binded model within a Request?I want to update a model, but before I do, I want to perform some permissions checks using the Requests authorize() method. But I only want the owner of the model to be able to update it.In the controller, I would simply do something like this:But I'm looking to do this within the Request, rather than within the controller. If I do:It only gives me the scalar form properties (such as _method and so on, but not the model).QuestionIf I bind a model to a route, how can I retrieve that model from within a Request?Many thanks in advance.Absolutely! It’s an approach I even use myself.You can get the current route in the request, and then any parameters, like so:Unlike smartman’s (now deleted) answer, this doesn’t incur another find query if you have already retrieved the model via route–model binding.To add on to Martin Bean's answer, you can access the bound instance using just route($param):Note: This works in Laravel 5.1. I have not tested this on older versions.Once you did your explicit binding (https://laravel.com/docs/5.5/routing#route-model-binding) you actually can get your model directly with $this.Even cleaner!

Laravel Auth:attempt() will not persist login

Leon Revill

[Laravel Auth:attempt() will not persist login](https://stackoverflow.com/questions/21603347/laravel-authattempt-will-not-persist-login)

I have found many resources online with similar issues but none of the solutions appear to solve my problem.When I log a user in with the following code, everything seems fine:The Auth::attempt() function returns true and the logged in user is returned to the client using Auth::user().But if the client makes another request to the server directly after, Auth::user() returns NULL.I have confirmed that Laravel sessions are working correctly by using the Session::put() and Session::get() successfully. On further investigation it appears that sessions are not persisting either! Could this be something to do with having the AngularJS web app server via app.mydomain.com and the Laravel API being served via api.mydomain.com?My User model is as follows:My auth config is as follows:The migration used to create the users table is as follows:And the session config:Any ideas?

2014-02-06 12:43:10Z

I have found many resources online with similar issues but none of the solutions appear to solve my problem.When I log a user in with the following code, everything seems fine:The Auth::attempt() function returns true and the logged in user is returned to the client using Auth::user().But if the client makes another request to the server directly after, Auth::user() returns NULL.I have confirmed that Laravel sessions are working correctly by using the Session::put() and Session::get() successfully. On further investigation it appears that sessions are not persisting either! Could this be something to do with having the AngularJS web app server via app.mydomain.com and the Laravel API being served via api.mydomain.com?My User model is as follows:My auth config is as follows:The migration used to create the users table is as follows:And the session config:Any ideas?I had this problem. Changing primary key for user model helped for me.Try to add something likein class User{} (app/models/User.php)(Field user_id is auto increment key in my Schema for 'users' table)See also this ticket: https://github.com/laravel/framework/issues/161I had this problem today morning, and I realized that when you output data before callingThen you can BE SURE THAT YOUR SESSION WILL NOT BE SET.

So for example if you do something like just above the line that says Then rest assured that you will spend the whole morning trying to find why laravel is not persisting the authenticated user and calling will give you a null, and also calling will always give you false.This was my problem and that is how I fixed it, by removing the echo statement.I had the same issue in laravel 5.7. Whoever facing similar issues if session not persisting after authentication , can follow the solution like below..Open file App\Http\kernel.phpMove \Illuminate\Session\Middleware\StartSession::class, from protected $middlewareGroups to protected $middleware . That's it.Try passing true to Auth:attempt() for the remember parameter:I'm not sure why you're returning Auth::user() at all though.I was having a similar issue, and in the end I was so focused on the back-end that I didn't consider the problem could be on the front-end. I'd used blade to output Auth:logout() directly to the front end to create a logout button, like so:Which is incorrect. Each time I logged into the application, I would be directed to a page with this button on, which I mistakenly thought would call Auth::logout() when pressed. Of course, the PHP is rendered on pageload and Auth::logout() is called straight away. Then when a user navigates to another page, since they've been logged out they're redirected to the login page to start the process again.FYI - The correct way to create a logout button, if you're using the default Auth route controller would be to direct to the route '/auth/logout', like so:<a href="{{url('/auth/logout')}}">Log Out</a>Firstly, I have the same problem on Laravel 5.8.I confirm that the solution of @nayeem-azad is the good one, at least in my case.

One difference, in App\Http\kernel.php, I do not moved this line :from protected $middlewareGroups to protected $middleware but only copied it to protected $middleware.Hope it helps ;-)The issue might be with your session configuration. Check to see if you've set up the session table Laravel needs to use the 'database' driver. You can see the config here: http://laravel.com/docs/session#database-sessionsHope this helps!How long is the id field in your sessions table?  Laravel uses a sha1 hash as the session id, which yields a string of length 40.  I had a similar problem and it was because my id field was set to length 32.See this question: Laravel 4.1 authentication session data not persisting across requestsOkay I haven't dug deep into it, but i've figured that laravel only returns cookies over a secure connection. As you must have noticed, laravel is setting up a cookie but it is not responding to the lifetime setting in session.phpTo get this to work on your local server you must mimic a https connection to ensure that the login persists. 

You can do this by generating a fake ssl certificate/key for your local domain.There are several tutorials available online that can help you enable ssl. These might be useful :How to enable SSL in MAMP ProMAMP with SSL (https)How To Create a SSL Certificate on Apache for Ubuntu 12.04Try to use before the return or the echo statment;ex:Using Laravel 5.7 by the way.I had the same problem but it was because I was trying to use their username for logging in. In the case you have custom user data besides the default email, name, and password and you don't want them to login via their email then you go to vendor/laravel/framework/src/Illuminate/Foundation/Auth/ and open the AuthenticatesUsers.php file. In it there's a public function called username:As you can see, by default it's set to 'email'. You can then change this to what you want the user to login with in combination with their password. So for my website I wanted the user to login using their username. So you simply change it from 'email' to 'username'.I hope this helps someone.NOTE: Peculiarly enough, for whatever reason, it gave me no errors when I tried to log in using username and password. Instead, it would seemingly validate but just not persist the user and I have no idea why.

Laravel's Artisan says nothing to migrate

totymedli

[Laravel's Artisan says nothing to migrate](https://stackoverflow.com/questions/21266956/laravels-artisan-says-nothing-to-migrate)

I installed migrations with php artisan migrate:install then created a migration with the php artisan migrate:make create_teams_table command. Now I try to run them with the following command that I made according to the official documentation:This gives me the following on the console:The migrations table in the database is empty and the new table isn't created neither. I don't understand why the documentation says foo in the path. What does foo mean and where does it comes from? First I tought that the path is wrong because of the foo thing and as I know the path is relative to the app folder so I changed it to app/database/migrations but it doesn't work. I also tried a lot of other path combination but none of them worked.Did I entered the wrong path? In this case shouldn't the console show some other kind of helpfull message? What does foo mean? How can I run my migration?

2014-01-21 19:08:16Z

I installed migrations with php artisan migrate:install then created a migration with the php artisan migrate:make create_teams_table command. Now I try to run them with the following command that I made according to the official documentation:This gives me the following on the console:The migrations table in the database is empty and the new table isn't created neither. I don't understand why the documentation says foo in the path. What does foo mean and where does it comes from? First I tought that the path is wrong because of the foo thing and as I know the path is relative to the app folder so I changed it to app/database/migrations but it doesn't work. I also tried a lot of other path combination but none of them worked.Did I entered the wrong path? In this case shouldn't the console show some other kind of helpfull message? What does foo mean? How can I run my migration?That foo thing is just an example. Laravel will look for migrations to run in app/database/migrations on default. Try removing that --path parameter and see if it works.Try this:First:Rolled back: 2014_03_28_142140_user_tableNothing to rollback.second:Migrated: 2014_03_28_142140_user_tablecheck the database.The path argument is for creating a migration for example:But it is not documented to use while running the migrations, as it was in prior versions of laravel. Dropping the --path argument should work in your caseWhat helped me:You don't need to move the migration file anywhere, just change its filename; for example, increase time integer and then run the migrate command with path pointing the migration. e.g: php artisan migrate --path="database/migrations/2019_07_06_145857_create_products_table.php"For anyone who still cannot migrate their database:Assume you have a file to migrate abc_migrate.php.Firstly put your file inside the new folder named abc_folder.

Then, enter this command 

php artisan migrate --path=database/migrations/abc_folder/.You don't have to add file name at last of the directory path.Done. Hope it helps.          The problem arises if the migrations table in the database is empty.

So the solution is open up the tinker from the composerHere is the result of the above commands executedAlso define the method down(), if it doesn't exist. 

Otherwise, it'll show

How to load view from alternative directory in Laravel 4

devo

[How to load view from alternative directory in Laravel 4](https://stackoverflow.com/questions/18954758/how-to-load-view-from-alternative-directory-in-laravel-4)

In my Laravel 4 application's root directory, I have a folder themes. Inside the themes folder, I have default and azure.

How can I access view from this themes/default folder in a specific route. -app--themes---default---azureI need to load views from localhost/laravel/app/themes/default folder. Please explain this.

2013-09-23 08:27:33Z

In my Laravel 4 application's root directory, I have a folder themes. Inside the themes folder, I have default and azure.

How can I access view from this themes/default folder in a specific route. -app--themes---default---azureI need to load views from localhost/laravel/app/themes/default folder. Please explain this.This is entirely possible with Laravel 4. What you're after is actually the view environment. 

You can register namespace hints or just extra locations that the finder will cascade too. Take a look hereYou'd add a location like so:It might be easier if you namespace them though, just in case you have conflicting file names as your path is appended to the array so it will only cascade so far until it finds an appropriate match. Namespaced views are loaded with the double colon syntax.You can also give addNamespace an array of view paths instead of a single path.Here I am not accessing my project from public folder. Instead of this I am accessing from project root itself. I have seen a forum discussion about Using alternative path for views here. But I am little confused about this.The discussed solution was,You'd add a location like,Then add namespace for theme,Then render it,What will be the value for /path/to/ ? Can I use the same project in different operating system without changing the path?Yes, we can do this using the following,Put the following in app/start/global.phpThen call view like the default way,This will render page.php or page.blade.php file from project_directory/app/themes/defualt folder.I've developed a theme package for laravel 5 with features like:Try it here: igaster/laravel-theme\View::addLocation($directory); works fine but the new right way to do it  is using loadViewsFrom($path, $namespace) (available on any service provider).

Laravel 5 Form Request data pre-manipulation

Jonathon

[Laravel 5 Form Request data pre-manipulation](https://stackoverflow.com/questions/28854585/laravel-5-form-request-data-pre-manipulation)

I'm processing a form where a user can update their date of birth. The form gives the user 3 separate fields for day, month and year. On the server-side of course I want to treat these 3 separate fields as one value i.e. yyyy-mm-dd.So before validation and updating my database, I want to alter the form request to create a date_of_birth field by concatenating year, month and day with - characters to create the date format I need (And possibly unset the original 3 fields).Achieving this manually with my controller is not a problem. I can simply grab the input, join the fields together separated by - characters and unset them. I can then validate manually before passing off to a command to deal with the processing.However, I would prefer to use a FormRequest to deal with the validation and have that injected into my controller method. Therefore I need a way of actually modifying the form request before validation is executed.I did find the following question which is similar: Laravel 5 Request - altering dataIt suggests overriding the all method on the form request to contain the logic for manipulating the data prior to validation.This is all well and good for the validation, but overriding the all method doesn't actually modify the data on the form request object. So when it comes to executing the command, the form request contains the original unmodified data. Unless I use the now overridden all method to pull the data out.I'm looking for a more concrete way to modify the data within my form request that doesn't require the calling of a specific method.Cheers

2015-03-04 12:30:35Z

I'm processing a form where a user can update their date of birth. The form gives the user 3 separate fields for day, month and year. On the server-side of course I want to treat these 3 separate fields as one value i.e. yyyy-mm-dd.So before validation and updating my database, I want to alter the form request to create a date_of_birth field by concatenating year, month and day with - characters to create the date format I need (And possibly unset the original 3 fields).Achieving this manually with my controller is not a problem. I can simply grab the input, join the fields together separated by - characters and unset them. I can then validate manually before passing off to a command to deal with the processing.However, I would prefer to use a FormRequest to deal with the validation and have that injected into my controller method. Therefore I need a way of actually modifying the form request before validation is executed.I did find the following question which is similar: Laravel 5 Request - altering dataIt suggests overriding the all method on the form request to contain the logic for manipulating the data prior to validation.This is all well and good for the validation, but overriding the all method doesn't actually modify the data on the form request object. So when it comes to executing the command, the form request contains the original unmodified data. Unless I use the now overridden all method to pull the data out.I'm looking for a more concrete way to modify the data within my form request that doesn't require the calling of a specific method.Cheersin laravel 5.1 you can do thatSince Laravel 5.4, you can use the prepareForValidation method on FormRequest classes.There's a more detailed write-up here:

https://sampo.co.uk/blog/manipulating-request-data-before-performing-validation-in-laravelNote: This question and answer were both posted before Laravel 5.1 was released and both target 5.0. For 5.1 and above, see this answer by @Julia Shestakova or this answer by @BenSampo for a more modern solution.After some messing around myself I've come up with the following:app/Http/Requests/Request.phpThen on extending classes you can just override the modifyInput method like this:app/Http/Requests/TestRequest.phpThis seems to work for my needs. I'm not sure of any drawbacks of doing it this way so I welcome any comments/criticism.The answer given by The Shift Exchange above will also work just fine.I took a similar approach to Julia Logvina but I think this way is a slightly more elegant way to add/modify fields before validation (Laravel 5.1) This will extend the default getValidatorInstance so we can modify the input values in the request before it gets to the validator (preventing it from using the original unmodified data). Once the data has been modified, it fires off the original getValidatorInstance then everything continues as normal.You can either use $this->replace(array()) or $this->merge(array()) your new fields into your request.  I've included an example of how to do both in the snippet above. replace() will replace all fields with the array you provide.merge() will add a new field into your request.I think this is the best approach to do so: Laravel 5.1 Modify input before form request validationIn Laravel 5.4+ there is a dedicated method for stuff like this so use it: prepareForValidationYou still override the all() method - but try it like thisThen you dont actually call the method yourself - it will be called by the validator itself when doing the rules.I too needed a quick and dirty way to accomplish this. I wanted to use The Shift Exchanges solution but it didn't work because of the calls to $this which creates an infinite recursive loop. A quick change to reference the parent method instead will fix the issue:HTH others in need.

naming tables in many to many relationships laravel

Pedram marandi

[naming tables in many to many relationships laravel](https://stackoverflow.com/questions/34897444/naming-tables-in-many-to-many-relationships-laravel)

I concerned about auto naming tables in many-to-many Laravel relationship.for example: when change the table name to:I have an error in my relationship. What's the matter with product_feature? 

2016-01-20 10:26:44Z

I concerned about auto naming tables in many-to-many Laravel relationship.for example: when change the table name to:I have an error in my relationship. What's the matter with product_feature? Laravel's naming convention for pivot tables is snake_cased model names in alphabetical order separated by an underscore. So, if one model is Feature, and the other model is Product, the pivot table will be feature_product.You are free to use any table name you want (such as product_feature), but you will then need to specify the name of the pivot table in the relationship. This is done using the second parameter to the belongsToMany() function.You can read more about many to many relationships in the docs.

Check if laravel model got saved or query got executed

user2722667

[Check if laravel model got saved or query got executed](https://stackoverflow.com/questions/27877948/check-if-laravel-model-got-saved-or-query-got-executed)

I've seen alot of people using this way to check if a laravel model got saved. So now I wonder if it is a safe way.And also can I check if the queries bellow got executed like thisCheck if model got saved Eg:Is the above a safe way to check whenever my model got saved or not?Check if query returned a resultEg:Does above return an error if no product where found?Check if query got executedEg:Does above check if a user was created?

2015-01-10 15:40:17Z

I've seen alot of people using this way to check if a laravel model got saved. So now I wonder if it is a safe way.And also can I check if the queries bellow got executed like thisCheck if model got saved Eg:Is the above a safe way to check whenever my model got saved or not?Check if query returned a resultEg:Does above return an error if no product where found?Check if query got executedEg:Does above check if a user was created?save() will return a boolean, saved or not saved. So you can either do:Or directly save in the if:Note that it doesn't make sense to call save() two times in a row like in your example. And by the way, many errors or problems that would keep the model from being saved will throw an exception anyways...first() will return null when no record is found so your check works find. However as alternative you could also use firstOrFail() which will automatically throw a ModelNotFoundException when nothing is found:(The same is true for find() and findOrFail())Unfortunately with create it's not that easy. Here's the source:As you can see it will create a new instance of the model with the $attributes and then call save(). Now if save() where to return true you wouldn't know because you'd get a model instance anyways. What you could do for example is check for the models id (since that's only available after the record is saved and the newly created id is returned)You can also check the public attribute $exists on your model.I would do such move to when I use Model::create method : As for the Save method it's easier because $model->save() returns Bool :

How to execute Stored Procedure from Laravel

Jordan Davis

[How to execute Stored Procedure from Laravel](https://stackoverflow.com/questions/34497063/how-to-execute-stored-procedure-from-laravel)

I need to execute a stored procedure after my form submits data. I have the stored procedure working like I want it, and I have my form working properly. I just do not know the statement to execute the sp from laravel 5.it should be something like this: execute my_stored_procedure. but I can not seem to find anything like that online. 

2015-12-28 16:27:36Z

I need to execute a stored procedure after my form submits data. I have the stored procedure working like I want it, and I have my form working properly. I just do not know the statement to execute the sp from laravel 5.it should be something like this: execute my_stored_procedure. but I can not seem to find anything like that online. Try something like thisorTry this for without parameters You can also do this:for Laravel 5.4if you want to pass parameters:for Laravel 5.5orno parameterRunning the Microsoft SQL Server Stored Procedure (MS SQL Server) using PHP Laravel framework.

If you are trying to run SP using Laravel Model then you can use following two approaches.If incase you are passing the Varchar Parameter then use the following:If you are just passing parameter which are of INT or BIGINT then this should work and you can get the return from SP:Once the stored procedure is executed the values will be present in the $submit in the form of array, you need to loop through it and access the required columns.After a long research, this works:For version 5.5 use CALL:Working code with Laraval 5.6,If using MySql with Laravel. Below is the way to go.DB::select(

        'call sp($id)'

    );

What's the difference between Commands and Events in the context of Laravel 5?

Peter Fox

[What's the difference between Commands and Events in the context of Laravel 5?](https://stackoverflow.com/questions/28344009/whats-the-difference-between-commands-and-events-in-the-context-of-laravel-5)

So Laravel 5 was finally released yesterday with the final implementation of the command bus but I was wandering, what's the real difference in using a command bus over event mechanisms that we have in the previous releases?Ok, I see the reason that it can be used to create commands from Request objects which is pretty useful but beyond that it seems to behave in a similar way even down to the whole queuing functionality for events now?Can you please provide examples of use cases and where the pros and cons of either are?

2015-02-05 12:29:12Z

So Laravel 5 was finally released yesterday with the final implementation of the command bus but I was wandering, what's the real difference in using a command bus over event mechanisms that we have in the previous releases?Ok, I see the reason that it can be used to create commands from Request objects which is pretty useful but beyond that it seems to behave in a similar way even down to the whole queuing functionality for events now?Can you please provide examples of use cases and where the pros and cons of either are?The differences appear minor - but have some key differences.Lets do an example to illustrate it best. Lets say we create a user, and we want to send them a welcome email and also update our newsletter list.In a Command Scenario would would dothen in our CommandClass - we would doBut if we use events - we would do something like this in our CommandClassthen we can create as many events as we want to listen to that event and do something:EventClassAEventClassB   The great thing is separation of concerns. The command "createuser" now does not need to worry itself about what happens after a user is created. It just needs to CreateUser.Also - if we want to add another function after a user signs up - say enter them in a lotto draw - you can just add another Event Class and add a new event listener.EventClassCNotice how we didnt need to touch the command CreateUser class code at all? This provides a true separation concerns of classes in a OOP style approach.I just want to share my understanding of this concept on top of the correct answer:The main difference is that Commands can change a Model state, while Events just react to a state change.COMMANDS:Commands in Laravel represent the implementation of the Command design pattern.The main adventages of Commands: To create a Command in Laravel 5:You need to generate a command DTO (which can implement the SelfHandling interface). Using php artisan make:command {command-name}Example: php artisan make:command Course/PostCourseCommandThe naming convention for commands: speak the business language and add postfix Command to itTo call (dispatch) the command from you controller, you can use:$this->dispatch(new PostCourseCommand())or Bus::dispatch(new PostCourseCommand());Side Note: 

The "dispatch from request」feature is a nice way to skip passing the variables to the command constructor one by one, instead it will resolve this for you:Example: Finally:You can separate the handler function and it’s logic from the command DTO to the Handlers directory, to do so:art handler:command --command="Course/PoatCourseCommand"EVENTS:Events in Laravel represent the implementation of the Observer design pattern.To create an Event in Laravel 5:Example: art make:event LogSomethingart handler:event LogSomething --event="LogSomething"Example: To call (fire) an Event:use:Event::fire(New LogSomething());or you can use the event helper          event(New LogSomething());Side Note:

alternatively you can generate an event by simply registering the event in the service provider then running this command.php artisan event:generate << this will automatically add the two classes for youAlso you can listen to an event without creating an event handler or registering a lister in the listeners array, by just going to the event service prover and inside the boot function writing your event and its action (NOT RECOMMENDED). Example:Finally: you can queue an event or even subscribe to multiple events from within the class itself..

How to add custom config file to app/config in Laravel 5?

Alexander Lomia

[How to add custom config file to app/config in Laravel 5?](https://stackoverflow.com/questions/38665907/how-to-add-custom-config-file-to-app-config-in-laravel-5)

I want to add custom_config.php to app/config directory of my Laravel 5 project, but can't find any article explaining this process. How is this done?

2016-07-29 19:04:21Z

I want to add custom_config.php to app/config directory of my Laravel 5 project, but can't find any article explaining this process. How is this done?You can easily add a new file to the config folder. This file should return configuration values. Check other config files for reference. Say constants.php is like soYou can now access this config file from anywhere by either using the Config Facade or the config() global function like soori.e. I don't know how many times one might need to create a config file, but here you have an Artisan command for it: https://gist.github.com/jotaelesalinas/eafd831048ca5fb5fba970afd1921f70

How to use pagination in laravel 5?

Sojan V Jose

[How to use pagination in laravel 5?](https://stackoverflow.com/questions/27980373/how-to-use-pagination-in-laravel-5)

am trying to port my laravel4 application to laravel 5 . In the previous version i could use the following method for generating pagination urls .In controller:and after sharing the data array with the view, i could user In views :In laravel 5 the doing that results in following errornot sure what i am missing here, can somebody help ?

2015-01-16 09:03:08Z

am trying to port my laravel4 application to laravel 5 . In the previous version i could use the following method for generating pagination urls .In controller:and after sharing the data array with the view, i could user In views :In laravel 5 the doing that results in following errornot sure what i am missing here, can somebody help ?In Laravel 5 there is no method "links" you can try thisIn other frameworks, pagination can be very painful. Laravel 5 makes it a breeze. For using it, first you have to make a change in your controller code where you calling data from the database:...after that you can use this code:That will make you use simple Laravel 5 beauty.Pagination Laravel 5.6.26,

  for the pagination  the controller are :  Controller code  (https://laravel.com/docs/5.6/pagination#basic-usage)Front end into blade (view) (https://laravel.com/docs/5.6/pagination#displaying-pagination-results)Use the array name (items) in the render() or links() method NOT the array item. It worked for me.Hi there is my code for pagination:

Use in view:

@include('pagination.default', ['paginator' => $users])Views/pagination/default.blade.php

laravel 5.2 How to get route parameter in blade?

msonowal

[laravel 5.2 How to get route parameter in blade?](https://stackoverflow.com/questions/39011648/laravel-5-2-how-to-get-route-parameter-in-blade)

this is my url

http://project.dev/blogs/image-with-article

so, here I need the parameter image-with-article

in my blade to display which is a parameter named slug here is in my routes file I need the slug paramter in blade.

2016-08-18 06:51:50Z

this is my url

http://project.dev/blogs/image-with-article

so, here I need the parameter image-with-article

in my blade to display which is a parameter named slug here is in my routes file I need the slug paramter in blade.I'm not sure what you mean. If you're trying to construct the route in a Blade template, useIf you're trying to access the given parameter, I would suggest passing it from the controller:And if you really need to access the parameter from the view without first sending it from the controller... you really shouldn't, but you can use the facade:If you want to get the parameters without using the controller method

Response::json() - Laravel 5.1

senty

[Response::json() - Laravel 5.1](https://stackoverflow.com/questions/31865493/responsejson-laravel-5-1)

I am trying to return Response::json('data', $request); however, I am getting an error:Where is the Response::json() is located? What am I doing wrong?

2015-08-06 20:46:00Z

I am trying to return Response::json('data', $request); however, I am getting an error:Where is the Response::json() is located? What am I doing wrong?use the helper function in laravel 5.1 instead:This will create an instance of \Illuminate\Routing\ResponseFactory. See the phpDocs for possible parameters below:After enough googling I found the answer from controller you need only a backslash like return \Response::json(['success' => 'hi, atiq']); . Or you can just return the array return array('success' => 'hi, atiq'); which will be rendered as json  in Laravel version 5.2 .You need to add use Response; facade in header at your file.Only then you can successfully retrieve your data with From a controller you can also return an Object/Array and it will be sent as a JSON response (including the correct HTTP headers).although Response::json() is not getting popular of recent, that does not stop you and Me from using it.

In fact you don't need any facade to use it,instead of:Use this:with the slash, you are sure good to go.However, the previous answer could still be confusing for some programmers. Most especially beginners who are most probably using an older book or tutorial.

Or perhaps you still feel the facade is needed. Sure you can use it.

Me for one I still love to use the facade, this is because some times while building my api I forget to use the '\' before the Response.if you are like me,

simply add above your class ...extends contoller.

this should do.with this you can now use:instead of:

Laravel 5 : Use different database for testing and local

James Okpe George

[Laravel 5 : Use different database for testing and local](https://stackoverflow.com/questions/35227226/laravel-5-use-different-database-for-testing-and-local)

How does one change database for development and testing on local system without editing the .env file each time?I have found it quite inconvenient to practice TDD because of this.Is it possible for a Laravel application to differentiate between normal development and testing so that it can choose the appropriate database?

2016-02-05 15:02:29Z

How does one change database for development and testing on local system without editing the .env file each time?I have found it quite inconvenient to practice TDD because of this.Is it possible for a Laravel application to differentiate between normal development and testing so that it can choose the appropriate database?Edit the config\database.php file and add a testing-array into the connections array:Then add the necessary variables to your .env-file.Open your phpunit.xml-file and add the following within your <php>-tag:<env name="DB_CONNECTION" value="testing"/>Now PHPUnit will run with the tests on the database you defined in the testing-array.For Laravel 5.5, the proper way to do this is create a testing environment file called .env.testing.  Here, you can define your testing environment, including the database you want to use for testing...Then run this command...This will configure the cache to the .env.testing file parameters.Here is a link to the documentation.If your testing database uses the same configuration but only it's name is different, you could only change the selected database name by addingto the file phpunit.xml in the <php> nodeif you need a specific database for one of your unit tests, add this code at the start of your unit testYou can use a different .env file for each type of test. You can modify your tests/functional.suite.yml and  tests/unit.suite.yml something like this:And this:Or you can simply modify your phpunit.xml and add environment vars like @Tijmen did above.

Laravel 4/5 search form like

erm_durr

[Laravel 4/5 search form like](https://stackoverflow.com/questions/18283714/laravel-4-5-search-form-like)

I have a search form and functions, all done. Just to ask, is it possible to do it in Eloquent a query like this:To display some possible matching names. My current controller function:And my view:Thanks in advance.

2013-08-16 23:56:36Z

I have a search form and functions, all done. Just to ask, is it possible to do it in Eloquent a query like this:To display some possible matching names. My current controller function:And my view:Thanks in advance.Hmmm, yes, just set like as your comparison operator, and send the string with %'s. Something like this:If you need to frequently use LIKE, you can simplify the problem a bit. A custom method like () can be created in  the model that inherits the Eloquent:So then you can use this method in such way:With quote of string:Try the above

Laravel pluck fields from relations

Alan

[Laravel pluck fields from relations](https://stackoverflow.com/questions/40635146/laravel-pluck-fields-from-relations)

I have a Seller object which has a related User. I need to fill a select from LaravelCollective so I need to make something like this:The problem is that I cannot take fields from relationships (user.first_name). How can I do it?UPDATEI want to avoid doing this...

2016-11-16 14:51:14Z

I have a Seller object which has a related User. I need to fill a select from LaravelCollective so I need to make something like this:The problem is that I cannot take fields from relationships (user.first_name). How can I do it?UPDATEI want to avoid doing this...You can use Laravel's pluck method as:You can achieve it by using join() & pluck() like this:This would give an array like this:Hope this helps!Another way to do it is to define what columns you need inside the relationship. It's good if you always need just these columns on the given relationship. Example: 

How to make a REST API first web application in Laravel

Martin Taleski

[How to make a REST API first web application in Laravel](https://stackoverflow.com/questions/23115291/how-to-make-a-rest-api-first-web-application-in-laravel)

I want to make an API first application in Laravel. I don't know what is the best approach to do this, I will explain what I am trying to do, but please feel free to give answers how to do this in a different way.I don't want all my frontend to be written in javascript and parse the JSON output of the API with angular.js or something similar. I want my Laravel application to produce the HTML views. I am trying to go down the road of having two controllers one on for the API and one for the web. For the show User action my routes.php looks like this:So /user will take me to WebUserController and /api/user will take me to the UserController. Now I want to put all my logic in the API UserController, and call its actions from the WebUserController. Here is the code for both of them:In the WebUserController I am able to get the json content of the response with getData(), but I am not able to get the headers and status code (they are protected properties of Illuminate\Http\JsonResponse).I think that my approach might not be the best, so I am open to suggestions how to make this app.EDIT: The question how to get the headers and status of the response has been answered by Drew Lewis, but I still think that there might be a better way how to design this

2014-04-16 16:39:47Z

I want to make an API first application in Laravel. I don't know what is the best approach to do this, I will explain what I am trying to do, but please feel free to give answers how to do this in a different way.I don't want all my frontend to be written in javascript and parse the JSON output of the API with angular.js or something similar. I want my Laravel application to produce the HTML views. I am trying to go down the road of having two controllers one on for the API and one for the web. For the show User action my routes.php looks like this:So /user will take me to WebUserController and /api/user will take me to the UserController. Now I want to put all my logic in the API UserController, and call its actions from the WebUserController. Here is the code for both of them:In the WebUserController I am able to get the json content of the response with getData(), but I am not able to get the headers and status code (they are protected properties of Illuminate\Http\JsonResponse).I think that my approach might not be the best, so I am open to suggestions how to make this app.EDIT: The question how to get the headers and status of the response has been answered by Drew Lewis, but I still think that there might be a better way how to design thisYou should utilize the Repository / Gateway design pattern: please see the answers here.For example, when dealing with the User model, first create a User Repository. The only responsibility of the user repository is to communicate with the database (performing CRUD operations). This User Repository extends a common base repository and implements an interface containing all methods you require:Then, create a service provider, which binds your user repository interface to your eloquent user repository. Whenever you require the user repository (by resolving it through the IoC container or injecting the dependency in the constructor), Laravel automatically gives you an instance of the Eloquent user repository you just created. This is so that, if you change ORMs to something other than eloquent, you can simply change this service provider and no other changes to your codebase are required:Next, create a User Gateway, who's purpose is to talk to any number of repositories and perform any business logic of your application:Finally, create your User web controller. This controller talks to your User Gateway:By structuring the design of your application in this way, you get several benefits: you achieve a very clear separation of concerns, since your application will be adhering to the Single Responsibility Principle (by separating your business logic from your database logic) . This enables you to perform unit and integration testing in a much easier manner, makes your controllers as slim as possible, as well as allowing you to easily swap out Eloquent for any other database if you desire in the future.For example, if changing from Eloquent to Mongo, the only things you need to change are the service provider binding as well as creating a MongoUserRepository which implements the UserRepository interface. This is because the repository is the only thing talking to your database - it has no knowledge of anything else. Therefore, the new MongoUserRepository might look something like:And the service provider will now bind the UserRepository interface to the new MongoUserRepository:Throughout all your gateways you have been referencing the UserRepository, so by making this change you're essentially telling Laravel to use the new MongoUserRepository instead of the older Eloquent one. No other changes are required.You should be use Repository for this design.Example -Checkout Laravel's RESTful controllers:http://laravel.com/docs/controllers#restful-controllersTheir docs do a pretty good job.But even better is this tutorial:http://code.tutsplus.com/tutorials/laravel-4-a-start-at-a-restful-api-updated--net-29785This is a video by Jeffrey Way he is one of the better Laravel developers. In this tutorial he is connecting a BackboneJS application to a RESTful service that he sets up in Laravel. It doesn't get any better then this. I can write you a lot of boilerplate, but just learn it by watching a nice video and having a coffee. ;)https://www.youtube.com/watch?v=uykzCfu1RiQI have a response to the problem you are having with the Response.

You can get the headers, status code and data from the Response.$response->headers is a Symfony\Component\HttpFoundation\ResponseHeaderBag which inherits from Symfony\Component\HttpFoundation\HeaderBagI would also recommend using a repository.

Attempting to call one controller from another would be falling into a pattern called HMVC (Hierarchical model–view–controller).

This means that your entire application relies on lower modules.

In this case, your API would serve as a repository for your data (which isn't the worst thing in the world at first).However, when you then modify the structure of how data is returned in your API, everything else relying on it would have to know how to respond.

Say you wanted to have authorization checks to see if a logged in user should be able to see the details of a returned user and there was an error.In the API, you would return a Response object with a 403 forbidden code and some meta data.

Your HTML controller would have to know how to handle this.Contrast this to a repository which could throw an exception.And your API controller would look more like this:Your HTML controller would then look like this:This gives you very reusable code and let's you change your controller implementations independently without worry of changing the other's behavior.

I wrote more on how to implement the repository pattern in this post: you can ignore the interface and skip right to the implementations if you would like.

How does Reflection in Laravel work?

Krystian Polska

[How does Reflection in Laravel work?](https://stackoverflow.com/questions/47200527/how-does-reflection-in-laravel-work)

How does reflection in Laravel actually work?I tried to debug it to see how Laravel uses reflection in a controller's constructor or methods to resolve their dependencies and sub-dependencies and then and give it back to us.But I found it hard, and it's very complicated to see and to even understand 50% of. Jumping from class to class, I can't really see it. I tried a few times by debugging it with low results of understanding.I am very impressed by this and by reflection, and the way Laravel uses it makes my heart burn—it's just beautiful. And I wish to fully understand that—the whole process—in general, and step by step.Beginning from hitting the route to finally having, let's say, dd($x), where $x is from a method argument and is a TestClass that has another dependency of TestClass2 that should be constructed through: $x = new TestClass(new TestClass2());I think those are beautiful mechanics and architecture, and understanding this is something I want so badly.So again, my question is: how does reflection in Laravel actually work?It's not about dd guys... Let's say without dd. Just as I said earlier - when we have this object instantiated from the class method. It's not about dumping it, it's just about having it from method injection by reflection.The dd was only an example. It can even be die(var_dump()); and it will work

2017-11-09 11:20:01Z

How does reflection in Laravel actually work?I tried to debug it to see how Laravel uses reflection in a controller's constructor or methods to resolve their dependencies and sub-dependencies and then and give it back to us.But I found it hard, and it's very complicated to see and to even understand 50% of. Jumping from class to class, I can't really see it. I tried a few times by debugging it with low results of understanding.I am very impressed by this and by reflection, and the way Laravel uses it makes my heart burn—it's just beautiful. And I wish to fully understand that—the whole process—in general, and step by step.Beginning from hitting the route to finally having, let's say, dd($x), where $x is from a method argument and is a TestClass that has another dependency of TestClass2 that should be constructed through: $x = new TestClass(new TestClass2());I think those are beautiful mechanics and architecture, and understanding this is something I want so badly.So again, my question is: how does reflection in Laravel actually work?It's not about dd guys... Let's say without dd. Just as I said earlier - when we have this object instantiated from the class method. It's not about dumping it, it's just about having it from method injection by reflection.The dd was only an example. It can even be die(var_dump()); and it will workLaravel uses PHP's reflection API for several components. Of these, the inverson-of-control (IoC) dependency injection container and controller method injection are most visible to developers.To more clearly illustrate the use of reflection, here's a dramatically simplified version of the routine Laravel's IoC container class uses to build up an object's dependencies through constructor injection:As we can see, the concept isn't too difficult to understand. The container uses PHP's ReflectionClass to find the names of the classes in an object's constructor, and then loops through each of these names recursively to create instances of each object in the dependency tree. With these instances, build() finally instantiates the original class and passes the dependencies as arguments to the constructor.Controller method injection uses the same container functionality shown above to resolve instances of dependencies declared as method parameters, but there's a bit of extra logic needed to separate class dependencies from route parameters:Again, this adaptation is slimmed-down to highlight the role reflection plays and relies on our build() function shown previously. The ControllerDispatcher class uses the getParameters() method of PHP's ReflectionMethod to determine which parameters a controller method expects, and then loops through these to find parameters that represent dependencies that it can resolve from the container. Then, it splices each dependency it finds back into the array of route parameters that it passes back to the controller method defined for the route. See RouteDependencyResolverTrait for details.If we ignore the application bootstrapping process, this dependency injection cascade typically starts for a request when Laravel maps a request to a route, and then determines which controller to pass the request to. Laravel first resolves an instance of the controller from the container, which builds out any constructor-injected dependencies. Then, Laravel finds the appropriate controller method and resolves any more dependencies for the arguments as needed.As shown here, Laravel uses relatively simple techniques to implement these tools using reflection. However, unlike the examples shown in this answer, the framework adds a lot of additional code to make them as robust and flexible as they are today.

change password user laravel 5.3

ardi gunawan

[change password user laravel 5.3](https://stackoverflow.com/questions/39586104/change-password-user-laravel-5-3)

I want to create form with 3 field (old_password, new_password, confirm_password) with laravel 5.Viewold password : 

{!! Form::password('old_password',['class' => 'form-control']) !!}New Password : {!! Form::password('password',['class' => 'form-control']) !!}Confirm New Password : {!! Form::password('verify_password',['class' => 'form-control']) !!}Controller when user registerI'm new in laravel, i've read some similar problem to change password in stackoverflow but it didn't help me.How should I write code in my controller for change password user?.

Thanks in Advance.

2016-09-20 05:09:19Z

I want to create form with 3 field (old_password, new_password, confirm_password) with laravel 5.Viewold password : 

{!! Form::password('old_password',['class' => 'form-control']) !!}New Password : {!! Form::password('password',['class' => 'form-control']) !!}Confirm New Password : {!! Form::password('verify_password',['class' => 'form-control']) !!}Controller when user registerI'm new in laravel, i've read some similar problem to change password in stackoverflow but it didn't help me.How should I write code in my controller for change password user?.

Thanks in Advance.This is change password formCreate rulesUser controller method to changes passworduse Validator;I am explain here another method to change user password

changepassword.blade.phpThis is route in web.php Controller Methodi have follow that link :- https://www.5balloons.info/setting-up-change-password-with-laravel-authentication/Laravel 6 Check Old Password and Updating a New PasswordThis is how I do this with Laravel 5.8:ViewConfirm password must be something like this:Because Laravel provides out the box a field confirmed rule. Create a form request and put this inside the rules part:Let's use artisan to generate a rule that verifies if old_password is the real current password:And put this inside the passes method of rule generated:Do not forget to import Hash:ControllerAll you need to do in your controller is this:And tada :) Hope I help.changePassword.blade.phpController Post Function

Laravel default mail not working

Sainath Krishnan

[Laravel default mail not working](https://stackoverflow.com/questions/22192133/laravel-default-mail-not-working)

Im attempting to send a user activation email upon registration. I have a simple laravel site with registration and authentication. Upon registration, there are no errors, and the data is stored correctly, however the email never actually gets sent. Tried a few different examples, but I have the same problem.This is my mail.php config file -And this is the logic for handling the mailer - (This is in UsersController)

2014-03-05 08:17:53Z

Im attempting to send a user activation email upon registration. I have a simple laravel site with registration and authentication. Upon registration, there are no errors, and the data is stored correctly, however the email never actually gets sent. Tried a few different examples, but I have the same problem.This is my mail.php config file -And this is the logic for handling the mailer - (This is in UsersController)Okay, I'd give Yousef an ''Up One''

, but my reputation is not high enough (seems broken). I had EXACTLY the same issue with my ISP in connecting to their smtp server. The only way I could FINALLY get an email through using laravel was to set the 'encryption' value to nothing (ie just as in the post above). Every other combination of port-change, account-change, etc. resulted in a laravel exception. I tried using my gmail account and credentials with no luck.The only combination of settings that finally worked was to useExpanding on the answers above as they weren't working for me.The port you define has to correlate with the right type of encryption. As it turns out, ssl and tls are not equivalent and correlate to different ports.

The default encryption setting in laravel is set on tls (port 587), but if you're using port 465, you need to change it to ssl.Google's smtp.gmail.com server is a good example of this:ORFurthermore, port 587 doesn't mandate the use of encryption (more on that here). If you find that setting 'encryption' => '' works for you, it should raise a red flag as it may mean the smtp server you're using is not encrypting your emails.

In this case, you should find alternative means of sending your emails.try removing tls encryption by setting it toi had a similar issue, and the tls was it.If you are using this on local machine using Xampp. Please disable all the encryption application which are running at the back end. I had experienced the same issue and it was solved when i disabled PGP encryption software. The encryption software doesn't allow to pass token to the email.I had this problem but I set configuration mail in .env file and I used this:

Templating in Laravel

coryj

[Templating in Laravel](https://stackoverflow.com/questions/12524712/templating-in-laravel)

I'm trying to get my default template working with Laravel. I'm coming from Codeigniter and Phil Sturgeon's template system so I'm trying to do it in a similar way. Can anyone help me with what I'm missing/doing wrong? Thanks!

2012-09-21 05:26:15Z

I'm trying to get my default template working with Laravel. I'm coming from Codeigniter and Phil Sturgeon's template system so I'm trying to do it in a similar way. Can anyone help me with what I'm missing/doing wrong? Thanks!

You are mixing two different layout approaches of Laravel.

This way you are rendering the layout view, include the home view and try to include inside again the layout.My personal preference is the controller approach.The controller and the layouts can remain the same.Note: As a shortcut you could nest the content instead of View::make, that automaically renders it when you echo it out in the layout.In home.blade.php remove the @layout function.Edit (example):controllers/home.phpviews/layouts/default.blade.php

views/home.blade.phpPartials are included in the content.

If you want this approach you have a few problems there. First, you are including new content after the layout. Not sure if intentional, but the @layout function itself is basicly just an @include restricted to be at the very beginning of the view. So if your layout is a closed html, any include after that will be appended after your html layout.Your content should use sections here with the @section function and @yield it in your layout. The header and footer could be included in the layout with @include or if you want to define it in the content view then put those in a @section too, like below. If you define it that way if a section doesn't exist nothing gets yielded.controllers/home.phpviews/layouts/default.blade.php

views/home.blade.php

The answer given above explains how templating is done in Laravel, however to gain additional benefits like managing themes organised into a theme directory with ability to switch between themes and having partials and theme resources all together sounds like almost something similar to Phil Sturgeon Template Library for CI. You may want to check the Theme bundle for Laravel. Here is the link:http://raftalks.github.io/Laravel_Theme_Bundle/

How to Format Laravel Blade Codes in Visual Studio Code?

coolsaint

[How to Format Laravel Blade Codes in Visual Studio Code?](https://stackoverflow.com/questions/46268211/how-to-format-laravel-blade-codes-in-visual-studio-code)

I have installed some Visual Studio Code extensions to handle Laravel Blade Codes likelaravel-blade [ https://marketplace.visualstudio.com/items?itemName=KTamas.laravel-blade ]Laravel Blade Snippets [ https://marketplace.visualstudio.com/items?itemName=onecentlin.laravel-blade ]But they are not helping me to format Laravel Blade Codes [blade.php files]. I mean they are not auto indenting the codes as I expected. But I have seen blade codes online which are well indented in visual studio Code IDE.Example : https://medium.com/@ardanirohman/laravel-%EF%B8%8F-visual-studio-code-debug-environment-65440274d3b0Is their any specific configuration or technique which I can use to make these extensions work or there is some other way? Thanks in advance

2017-09-17 19:44:57Z

I have installed some Visual Studio Code extensions to handle Laravel Blade Codes likelaravel-blade [ https://marketplace.visualstudio.com/items?itemName=KTamas.laravel-blade ]Laravel Blade Snippets [ https://marketplace.visualstudio.com/items?itemName=onecentlin.laravel-blade ]But they are not helping me to format Laravel Blade Codes [blade.php files]. I mean they are not auto indenting the codes as I expected. But I have seen blade codes online which are well indented in visual studio Code IDE.Example : https://medium.com/@ardanirohman/laravel-%EF%B8%8F-visual-studio-code-debug-environment-65440274d3b0Is their any specific configuration or technique which I can use to make these extensions work or there is some other way? Thanks in advanceIt'll associate .blade.php and .tpl file extensions for html type Save it and your are good to go. Happy formatting :)Update: There are still some issues in formatting html with blade code, the formatter tend to bring blade codes in a single line while executing format command. However, if your codes grow that's won't be a problem. Moreover, you can easily manage those by putting a line comment in between your blade blocks. And commenting in code is always a good thing.Update: Seems updated version adds an option to enable blade formatting in the user settings. To use that, 

 3. In "User settings" > "Extensions" > "Blade Configaration" check the option Enable format blade file. That's it.Update your VSCode. Go to Settings>Extensions and Enable Blade Format checkbox.

Use Shortcut for Window: Shift+Alt+F:For me, this extension works perfect for auto indentation with the following settings:Then Enable format blade file (Follow Image).Then Restart Visual Studio Code.Now Use Shift+Alt+F To format. Now OK.

First install this extension, https://marketplace.visualstudio.com/items?itemName=onecentlin.laravel-bladeOpen settings.json.

Add this lines.

Laravel 4 - Connect to other database

TheNiceGuy

[Laravel 4 - Connect to other database](https://stackoverflow.com/questions/17410049/laravel-4-connect-to-other-database)

I want to connect to another database sometimes.I created a config.php with the database connection data.But how can i tell laravel to connect to this database insted of using the config/database.php?For example when using the Schema class.Since no one seems to understand what i want.I DON'T want to use the config/database.php, i want to use a different config file on a different location.

2013-07-01 17:16:02Z

I want to connect to another database sometimes.I created a config.php with the database connection data.But how can i tell laravel to connect to this database insted of using the config/database.php?For example when using the Schema class.Since no one seems to understand what i want.I DON'T want to use the config/database.php, i want to use a different config file on a different location.It sounds like you figured this out. Here's how I'd accomplish it anyway for other people coming in, or in case something useful is here for you.First, Add a second connection in app/config/database.php. Note: That file path may change depending on your environment.Second, in your code, you can use (as mentioned) the 2nd connection where you would like:Schema::connection('mysql2')->create('users', function($table) {})There's more documentation on this - see Accessing Connections.Eloquent ORM

You can define the variable for "connection" in an eloquent class to set which connection is used. That's noted in the Basic Usage section.See that variable on here on Github and the method which you can set to set the connection dynamically here.Edit

The OP has made it clear that they do not wish to use the config/database.php file for config.However without explaining further, I can't comment. I'm happy to help - sounds like it would be useful to know why the config/database.php file can't/shouldn't be used, as this can help us ascertain the problem and create a useful solution. Remember that Laravel 4 is actually a collection of components, and you can use these components solo.https://github.com/illuminate/databaseThere is an example here that shows off how interacting with the Capsule class works:This is a bunch of bootstrapping that you'll need to run, so tuck it away somewhere in a function or method.But, its absolutely possible.I believe you want to implement some kind of logical sharding where databases would be dynamically created.In such scenario in laravel you can dynamically add a database config, like belowNow to connect via eloquentIncase of Query Builder you can douse $DB->select() for querying now.Hope this would help devs looking for a possible solution for this questionThere is a simpler solution. If you are using Larave 4 there is an option that worked for me. Recently they added $table variable that you can specify in your model. Refer to this link. If you are using MySQL, you can do the following:If you are using SQL Server, you can do this:My Config file had DB1 specified but I created a model which wants to access DB2 in the same MySQL host. So this was a quick and dirty way to accomplish this. Now I don't fully leverage Eloquent ORM all the time so this "hack" may not work with Many to Many or one to Many Eloquent methods.One another idea I had but I didn't actually try was creating a stored procedure (routine) in DB1 and inside of that routine I can access DB2 tables by querying link this:To use a config file in another location, say src/config:Where dbInfo is a simple php file in your app's src/config directory returning an array containing the element connections which is an array of database properties.You can tell Laravel to use an external config file using:Edit bootstrap/start.php file and add your machine name (open terminal: hostname).Add your machine to $env,

How can I query raw via Eloquent?

Chilion

[How can I query raw via Eloquent?](https://stackoverflow.com/questions/22925451/how-can-i-query-raw-via-eloquent)

I am trying to do a query in my Laravel app and I want to use a normal structure for my query. This class either does use Eloquent so I need to find something to do a query totally raw.Might be something like Model::query($query);. Only that doesn't work.

2014-04-08 00:25:45Z

I am trying to do a query in my Laravel app and I want to use a normal structure for my query. This class either does use Eloquent so I need to find something to do a query totally raw.Might be something like Model::query($query);. Only that doesn't work.use DB::statement('your raw query here'). Hope this helps.You may try this:An Example:Also, you may use something like this (Using Query Builder):Also, you may try something like this  (Using Query Builder):Check more about Raw-Expressions on Laravel website.You can use hydrate() function to convert your array to the Eloquent models, which Laravel itself internally uses to convert the query results to the models. It's not mentioned in the docs as far as I know.Below code is equviolent to $userModels = User::where('id', '>', $userId)->get();:hydrate() function is defined in \Illuminate\Database\Eloquent\Builder as:I don't think  you can by default. I've extended Eloquent and added the following method.You can then do something like this:Old question, already answered, I know.However, nobody seems to mention the Expression class.Granted, this might not fix your problem because your question leaves it ambiguous as to where in the SQL the Raw condition needs to be included (is it in the SELECT statement or in the WHERE statement?).  However, this piece of information you might find useful regardless.Include the following class in your Model file:Then inside the Model class define a new variableAnd add a scope:Then from your controller or logic-file, you simply call:Happy days.(Works in Laravel framework 5.5)You could shorten your result handling by writing

Laravel mail pretend prints nothing

totymedli

[Laravel mail pretend prints nothing](https://stackoverflow.com/questions/18532353/laravel-mail-pretend-prints-nothing)

I set 'pretend' => true, in the mail.php, created this new.php view:Then in my controller I use this code to "send" the mail:The output in the log file is only this:I tried with a full HTML view, also with another view that contains only strings, no variables, but the output is the same.Is this the way how this should work? Shouldn't it print the whole message, title, etc? Is there a problem with the code or this is the proper output?

2013-08-30 11:55:42Z

I set 'pretend' => true, in the mail.php, created this new.php view:Then in my controller I use this code to "send" the mail:The output in the log file is only this:I tried with a full HTML view, also with another view that contains only strings, no variables, but the output is the same.Is this the way how this should work? Shouldn't it print the whole message, title, etc? Is there a problem with the code or this is the proper output?If you set 'pretend' => true in app/config/mail.php then no mail is ever sent, you get just a message in the log, like this:However, if you leave 'pretend' => false and instead use the log driver ('driver' => 'log', available since Laravel 4.2), then instead of sending the mail, you'll get the whole mail content written into the log:If you actually want to view the contents of the message (for instance when testing user account verification or password reset emails) in the /storage/logs logfile; You can modify your local copy of vendor/laravel/framework/src/Illuminate/Mail/Mailer.php and in the logMessages function modify it to look likeThen you will see the body of the message in the logs.This is the normal behaviour of pretend in the Laravel Mailer system. It will not render your message anywhere, not even in the log, it will just log that a mail message was pretended to be sent. Look at the related source code:I include this in my send callbacks:Alternately, you can pass the views render into another view to see the html rendered in your browser.I created a package to also include subject and body for laravel 4.2.The package can be found here: https://packagist.org/packages/peercode/mailJust enable the package as descripted here: https://github.com/peercode-eric/laravel-maillog

and the log will contain the additional information.

Artisan, creating tables in database

Streetlamp

[Artisan, creating tables in database](https://stackoverflow.com/questions/30447385/artisan-creating-tables-in-database)

I am trying to create mysql tables in Laravel 5. I created a file in /project/database/migrations called users.php:I then tried running these commands in the project-folder:None of them return any output and no tables are created. The database to be populated exists.

2015-05-25 23:45:05Z

I am trying to create mysql tables in Laravel 5. I created a file in /project/database/migrations called users.php:I then tried running these commands in the project-folder:None of them return any output and no tables are created. The database to be populated exists.Migration files must match the pattern *_*.php, or else they won't be found. Since users.php does not match this pattern (it has no underscore), this file will not be found by the migrator.Ideally, you should be creating your migration files using artisan:This will create the file with the appropriate name, which you can then edit to flesh out your migration. The name will also include the timestamp, to help the migrator determine the order of migrations.You can also use the --create or --table switches to add a little bit more boilerplate to help get you started:The documentation on migrations can be found here.In order to give a value in the table, we need to give a command:and after then this command line

How to autoload Guzzle in Laravel 4?

Iain

[How to autoload Guzzle in Laravel 4?](https://stackoverflow.com/questions/22725266/how-to-autoload-guzzle-in-laravel-4)

How can I autoload Guzzle in Laravel 4?I am encountering the following error when I try to create a new GuzzleHttp/Client:I have the following set up in my composer.json autoload section:

2014-03-29 00:04:53Z

How can I autoload Guzzle in Laravel 4?I am encountering the following error when I try to create a new GuzzleHttp/Client:I have the following set up in my composer.json autoload section:You don't need to add Guzzle to your composer.json, it's already autoloaded by it's own composer.json.Create a client:Get results:Install it:Create a client setting the base URL:Get your response:And display it:If you still don't get it running, check the file vendor/composer/autoload_psr4.php, Guzzle must appear in it. If it doesn't, remove your vendor folder and install it again:

Can I use Laravel's database layer standalone?

sjosen

[Can I use Laravel's database layer standalone?](https://stackoverflow.com/questions/26083175/can-i-use-laravels-database-layer-standalone)

For some time now I have been looking towards using a php framework for my work. I've been writing procedural style until recently and is still trying to find my way around the oop world/style.

I figured that a php framework would help me write better code and I'm pretty sure I'll lean towards the Laravel project in a near future. Right now I'm in need of a database layer that I can use in my existing code. I use mysqli with prepared statements right now, as it was easy for me to implement (using MySQL before).I've been looking at http://medoo.in as an "easy" way to use a pdo wrapper/class but the lack of activity on the support page, and the fact that I'm working on using Laravel in the future, made me wonder if I could use the Laravel database layer now for my existing code. Could this be done and would it make sense or am I misunderstanding and mixing concepts of code styling?

2014-09-28 08:45:34Z

For some time now I have been looking towards using a php framework for my work. I've been writing procedural style until recently and is still trying to find my way around the oop world/style.

I figured that a php framework would help me write better code and I'm pretty sure I'll lean towards the Laravel project in a near future. Right now I'm in need of a database layer that I can use in my existing code. I use mysqli with prepared statements right now, as it was easy for me to implement (using MySQL before).I've been looking at http://medoo.in as an "easy" way to use a pdo wrapper/class but the lack of activity on the support page, and the fact that I'm working on using Laravel in the future, made me wonder if I could use the Laravel database layer now for my existing code. Could this be done and would it make sense or am I misunderstanding and mixing concepts of code styling?IMO it's absolutely valid to transition to an OOP approach step by step.To your question:Yes, you can use Eloquent standalone.Here is the packagist site: https://packagist.org/packages/illuminate/database

Add "illuminate/database": "5.0.*@dev" to your composer.json and run composer update.

Now you'll need to bootstrap Eloquent. (https://github.com/illuminate/database)The following is copied from the repo's readme:Usage InstructionsFirst, create a new "Capsule" manager instance. Capsule aims to make configuring the library for usage outside of the Laravel framework as easy as possible.Once the Capsule instance has been registered. You may use it like so:Using The Query BuilderOther core methods may be accessed directly from the Capsule in the same manner as from the DB facade:Using The Schema BuilderUsing The Eloquent ORMFor further documentation on using the various database facilities this library provides, consult the Laravel framework documentation.Bastian's answer is pretty well. But there is one more thing. It can't work without Event Lib. To install it;You are good to go

Laravel Creating Dynamic Routes to controllers from Mysql database

user3150060

[Laravel Creating Dynamic Routes to controllers from Mysql database](https://stackoverflow.com/questions/23145245/laravel-creating-dynamic-routes-to-controllers-from-mysql-database)

I have the following table: group_pages in mysql database with page name route name :what I am trying to do is to create dynamic routes in my : routes.php ? Where if I go to for example: /about it will go to AboutController.php ( which will be created dynamically) is that possible? is it possible to create a dynamic controller file? I am trying to create dynamic pages routes that links to a controllerexample i want to generate this dynamically in my routes.php

2014-04-17 23:40:10Z

I have the following table: group_pages in mysql database with page name route name :what I am trying to do is to create dynamic routes in my : routes.php ? Where if I go to for example: /about it will go to AboutController.php ( which will be created dynamically) is that possible? is it possible to create a dynamic controller file? I am trying to create dynamic pages routes that links to a controllerexample i want to generate this dynamically in my routes.phpThis is not the right way to create dynamic pages instead, you should use a database and keep all pages in the database. For example:Then create Page Eloquent model:Then create  Controller for CRUD, you may use a resource controller or a normal controller, for example, normally a PageController:The views/page/index.blade.php view file:To show pages create a route like this:To access a page, you may require url/link like this:This is a rough idea, try to implement something like this.After spending 2 hours, digging through google and Laravel source, I came up with this solution, which I think works the best and looks the cleanest. No need for redirects and multiple inner requests.You add this route at the very bottom of routes files.

If no other routes are matched, this is executed. In the closure, you decide which controller and action to execute.

The best part is - all route parameters are passed to action, and method injection still works. The ControllerDispatcer line is from Laravel Route(r?) class.My example would handle 2 cases - first checks if user exists by that name, then checks if an article can be found by the slug.Laravel 5.2 (5.3 below)5.3 has changed how the controller gets dispatched.Heres my dynamic controller example for 5.3, 5.4Hope this helps!try We can make dynamic route by this wayGet Route value from DatabaseThen iterate the value to make dynamic routeYou can use GET|POST|PUT|PATCH|DELETE methods alsoThere is a component available, which you can use to store routes in a database. As an extra advantage, this component only loads the current active route, so it improves performance, since not all routes are loaded into the memory.https://github.com/douma/laravel-database-routesFollow the installation instructions provided in the readme. Storing routes in the databaseThe only thing needed here is injecting the RouteManager into for example a cli command. With addRoute can tell the RouteManager to store the route into the database. You can easily change this code and use your own repository of pages or other data to construct the routes. Run this cli command every 2-5 minutes or after a change in your data to make sure the routes are recent. Register the RouteMiddleware in App\Http\Kernel.php\Douma\Routes\Middleware\RouteMiddleware::classEmpty your web.phpIf you have defined any Laravel route, make sure to empty this file. Using routes from the databaseYou can use the route in blade: Or you can inject the RouteManager-interface anywhere you like to obtain the route:For more information see the readme. 

Has one through Laravel Eloquent

yayuj

[Has one through Laravel Eloquent](https://stackoverflow.com/questions/27466542/has-one-through-laravel-eloquent)

I have three tables garages, cars, securities.The securities are the ones that is keeping one car safe, you can have more than one security, but a single security can keep only one car safe. The garage is where the car is and the securities are as well.What I want is to list all the securities and know the name of the garage that he is. The problem is that securities doesn't have a column containing the id of the garage, only the id of the car that he is keeping safe, but car has the id of the garage.Laravel Eloquent has a method called hasManyThrough, but securities has one garage through cars only.Here is the tables:garages table:cars table:securities table:The output must to be:And I have the models:The code is to list the garages, but I want to make similar but to list the securities (just for you to have an idea of how the structure is).And just to make an emphasis again: I want to have the name of the garage related to the car that the security is keeping safe.Just to make it even easier to understand, if I do this:I will get only the garage_id from cars table as relations. What I really want is the name of the garage.

2014-12-14 05:07:31Z

I have three tables garages, cars, securities.The securities are the ones that is keeping one car safe, you can have more than one security, but a single security can keep only one car safe. The garage is where the car is and the securities are as well.What I want is to list all the securities and know the name of the garage that he is. The problem is that securities doesn't have a column containing the id of the garage, only the id of the car that he is keeping safe, but car has the id of the garage.Laravel Eloquent has a method called hasManyThrough, but securities has one garage through cars only.Here is the tables:garages table:cars table:securities table:The output must to be:And I have the models:The code is to list the garages, but I want to make similar but to list the securities (just for you to have an idea of how the structure is).And just to make an emphasis again: I want to have the name of the garage related to the car that the security is keeping safe.Just to make it even easier to understand, if I do this:I will get only the garage_id from cars table as relations. What I really want is the name of the garage.It looks like you are not relating objects correctly. Let's break that down:If a Garage Has Many Car then a Car Belongs To Garage, Lets proceed with this idea in mind.In Eloquent you can just go ahead and clap those relations in, it should work given the schema you posted above.And that should be it.EDIT: You can access all these relations from any model as long as there is a path you can draw from one model to another using a combination of these relations. Check this out for example:will retrieve first Security record and load Car relation on it, then it goes one more step and load all Garage relations on every Car object loaded under Security model.You can access them using this syntax:Furthermore, notice that the relationship objects are an instance of Collection so you have all the fancy methods such as ->each(), ->count(), ->map() available on them.I ran into a similar problem recently and was able to do something like this:This gives you the Securities has one garage relationship and you can do something like:This is relevant to your original inquiry.hasOneThrough will be available in Laravel 5.8https://github.com/laravel/framework/pull/26057/filesYou can use hasOneThrough, integrated on Laravel => 5.8.Dont use solutions likeBecause it are using eager loading, and you call to database on each iteration. These type of solution are not optimized.

Laravel 5 CSRF global token hidden field for all forms in a page

raphadko

[Laravel 5 CSRF global token hidden field for all forms in a page](https://stackoverflow.com/questions/28500525/laravel-5-csrf-global-token-hidden-field-for-all-forms-in-a-page)

I recently migrated to Laravel 5, and now CSRF check is on every post submission. I thought about removing it but I want to follow the best practices, so I'll keep it that way.On the other hand, I'm problems submitting ajax requests.. my page has multiple forms and some submissions are not even from forms, just plain ajax calls. My idea is to have one single hidden "token" input on the page and attach it to every submission. Are there any drawbacks on having that universal single token input?Also, how can I output the token? Would it be ok to just create a hidden input on the page footer?

2015-02-13 13:17:56Z

I recently migrated to Laravel 5, and now CSRF check is on every post submission. I thought about removing it but I want to follow the best practices, so I'll keep it that way.On the other hand, I'm problems submitting ajax requests.. my page has multiple forms and some submissions are not even from forms, just plain ajax calls. My idea is to have one single hidden "token" input on the page and attach it to every submission. Are there any drawbacks on having that universal single token input?Also, how can I output the token? Would it be ok to just create a hidden input on the page footer?I don't see any drawbacks. You can easily create a global token field in your layout file:Or if you use the form builder:In jQuery you could use something like this to attach the token to every request.There is a helper to add the form token inside forms. You can just useinside the forms. It will add the hidden input and the token.You can use something like this at the bottom of the page:This will append a hidden input to all your forms:And for all your AJAX requests:Here are some excerpts of how I got my CSRF working for all the different scenarios in my jQuery Mobile application that I recently upgraded to use Laravel 5:I added an encrypted csrf token in a variable that will be passed to my views in my main base controller:

app\Http\Controllers\MyController.phpThen, I added the meta tag in my main view header:

resources\views\partials\htmlHeader.blade.phpThen, I also added this jquery snippet as suggested in some forums:But, the key (for my setup at least) was the addition of the check for the XSRF-TOKEN cookie in my custom VerifyCsrfToken middleware:

app\Http\Middleware\VerifyCsrfToken.php:Before I added that, just about all of my AJAX POSTs (including form submissions and lazyloading listviews) were failing due to a TokenMismatchException.  EDIT:

On second thought, I'm not sure how much sense it makes to compare the session token with the one set in the cookie (which would have come from the session token in the first place right?).  That may have just been bypassing the security of it all.I think my main issue was with the jquery snippet above which was supposed to be adding the X-XSRF-TOKEN header to every ajax request.  That wasn't working for me in my in jQuery Mobile app (specifically, in my lazyloader plugin) until I added some options for the plugin itself.  I added a new default selector csrf (which would be meta[name="_token"] in this case) and a new default setting csrfHeaderKey (which would be X-XSRF-TOKEN in this case).  Basically, during initialization of the plugin, a new _headers property is initialized with the CSRF token if one is locatable by the csrf selector (default or user-defined).  Then, in the 3 different places where an ajax POST can be fired off (when resetting session variables or when lazyloading a listview) the headers option of $.ajax is set with whatever is in _headers.        Anyway, since the X-XSRF-TOKEN received on the server-side comes from the encrypted meta _token, I think the CSRF protection is now working as it should.    My app\Http\Middleware\VerifyCsrfToken.php now looks like this (which is essentially back to the default implementation provided by Laravel 5 - LOL):I think you can do something like this (not tested will update if I get a chance)you actually might want to store token in a variable that you reupdate as it expires. The benefit of appending it on submit is if you append elements via ajax I think it'll still work without having to add anything else.EDIT: Here's a great article on using Rails UJS with Laravel (which includes this auto CRSF token functionality): https://medium.com/@barryvdh/unobtrusive-javascript-with-jquery-ujs-and-laravel-e05f444d3439You need to pass along the header X-XSRF-TOKEN which contains an encrypted version of the csrf-token.There are two ways which this can be done that I am aware of. You can encrypt the token and pass it along to the view:Or you can grab the token from cookies using JavaScript (Angular makes this easy). In vanilla JS you might do something like this:In jQuery you might then do something like this for the ajax request:

Class 'App\Http\Controllers\Session' not found in Laravel 5.2 [duplicate]

AiD

[Class 'App\Http\Controllers\Session' not found in Laravel 5.2 [duplicate]](https://stackoverflow.com/questions/34419378/class-app-http-controllers-session-not-found-in-laravel-5-2)

Hi guys i'm using sessions in Laravel 5.2 

there is my Controller code :i try just to get a value from the session , and i got this error :How can i resolve it ?

2015-12-22 15:38:11Z

Hi guys i'm using sessions in Laravel 5.2 

there is my Controller code :i try just to get a value from the session , and i got this error :How can i resolve it ?From the error message:I see that Laravel is searching the Session class in the current namespace: App\Http\ControllersThe problem is you don't have aliased the class from the global namespace: Session is a Facade, and all the facades are in the global namespaceTo use the class from the global namespace, put:on top of your controller, after your namespace declarationAlternatively, you can call the class from the global namespace with:

Can I group multiple domains in a routing group in Laravel?

Andy Fleming

[Can I group multiple domains in a routing group in Laravel?](https://stackoverflow.com/questions/18603330/can-i-group-multiple-domains-in-a-routing-group-in-laravel)

Let's say I have the following:Is there any way to have multiple domains share a routing group? Something like:

2013-09-04 00:01:23Z

Let's say I have the following:Is there any way to have multiple domains share a routing group? Something like:Laravel does not seem to support this.I'm not sure why I didn't think of this sooner, but I guess one solution would be to just declare the routes in a separate function as pass it to both route groups.I'm not sure if there is any significant performance impact to this solution.Laravel 5.1Interested in this also! I'm trying to register a local development + production subdomain route, for the one controller action.i.e.I tried:But it failed.Not a huge issue, as DesignerGuy mentioned I can just pass in a function to both routes - but it would just be more elegant if they could be grouped :)check in laravel docs, if you main domain is myapp, in production is myapp.com and in local environment is myapp.dev try using a *You can pass on the domain name as well:Just in case you need to know with which domain name the controller is called.

Tested it with Laravel 5.6.Currently you cannot. I had the same 'problem'; my fix is to cycle through your subdomains with a foreach and register the routes.according to laravel document

in laravel 5.4+ you can use this way:see this link. http://laravel.com/docs/routing#sub-domain-routingor Use this package.https://github.com/jasonlewis/enhanced-routerIt help you can set where on group routing like this.

LAMP PHP Configuration

Arafath

[LAMP PHP Configuration](https://stackoverflow.com/questions/47493587/lamp-php-configuration)

OS : Ubuntu 17.10 

I have installed LAMP stack and Laravel, and when I tried composer install in my Laravel app, I got the following errors.I have rechecked the files, all extensions are enabled and they are located in 

/usr/lib/php/20160303 folder.

2017-11-26 06:21:29Z

OS : Ubuntu 17.10 

I have installed LAMP stack and Laravel, and when I tried composer install in my Laravel app, I got the following errors.I have rechecked the files, all extensions are enabled and they are located in 

/usr/lib/php/20160303 folder.Sometimes the problem is the php-xml extension.Try:If still facing the issue then tryTry following command : As the log speaks we need to install the extension dom. This is how we do it:If the log shows only one extension missing, than above command works. If there are other extension missing, you can add those extension in the same line like shown below:That’s it. Now you won’t have any issues in installing  composer. Enter composer install

laravel TokenMismatchException in ajax request

DolDurma

[laravel TokenMismatchException in ajax request](https://stackoverflow.com/questions/21627170/laravel-tokenmismatchexception-in-ajax-request)

i'm using resource group and use this filter to resolve TokenMismatchException problem:my route :now. i get error to Ajax requests such as this code:ERROR:i think i'm must be sent _token in $.post. but i can not get input tag with name attribute. iget this error:

2014-02-07 11:55:50Z

i'm using resource group and use this filter to resolve TokenMismatchException problem:my route :now. i get error to Ajax requests such as this code:ERROR:i think i'm must be sent _token in $.post. but i can not get input tag with name attribute. iget this error:There is a tip in the Laravel docs on how to do this.  This might not have been available at the time of the question, but I thought I would update it with a answer.http://laravel.com/docs/master/routing#csrf-x-csrf-tokenI have tested the meta tag method from the documentation and got it working.  Add the following meta tag into your global templateAdd this JavaScript that sets defaults for all ajax request in jQuery.  Preferably in a js file that is included across your app.This token can exist in the request header or the form.  This populates it into the request header of every ajax request.You have to insert a hidden input with the _token and later get that value as you do to get the other form fields in your ajax post.An another method,On your view you can set an object with the _token and later on your ajax call you can get the _token from the object like this:and include it on your ajax post.Just do simple thing as i have shown in following code,I hope this one is the easiest way to solve this problem without any hidden field and it works for me in laravel 5.4 version :)Hope it helps.You can as well add the url thats giving you the error inside the VerifyCsrfToken.php file in the Let's say your route is post. You can just add in like this Hope this helps others.and VerifyCsrfToken.php file add this function

Laravel routes.php getting big [closed]

Chris G.

[Laravel routes.php getting big [closed]](https://stackoverflow.com/questions/14904333/laravel-routes-php-getting-big)

As you continually add more and more routes to Routes.php it gets bigger and bigger. How do you organize them?

2013-02-15 22:20:47Z

As you continually add more and more routes to Routes.php it gets bigger and bigger. How do you organize them?I usually use Group routes (because controllers tend to have the same type of filtering needed if they are related) to organize them or if you wish to/can have a smaller routes file you might want to register your controllers and do the extra validation checks of the URL's parameters inside the controller itself.I created a directory /application/routes/ and added files in there. Each file is just a set of routes. Then in routes.php I added the following code to include them all:even after adopting all the best practices as mentioned in the other answers, 

Ie: using resource controller, route groups etc.You can simple 'include' the route files the old fashion way. as mentioned by Chris G in this comment. you can create simple directory structure and include the route files in the route.php file.In route.php file There is nothing wrong in it. This is how routes are included in the packages.http://laravel.com/docs/packages#package-routingActually routs should stay slim. Just move your code to controllers and use the routs to register and redirect to them. The convention is to store one controller per file so your code becomes automatically organized.Take a look at this The controller-action route can be registered like this: Very straight forward and comfortable. Update:You can also register all your controllers with this line for the whole application automatically:Or the controller with all actions:Alternatively you could just store the routes in a different files and then get those files using include:That gives a nice and clean way to sort handle when there's way too much code, also you could just mention And then structure your controllers accordingly:If you have to passin parameters to some function:You can reach those functions like this:Then you could just call the function by appending the parameters to the URL,               If you need some methods to be protected then append them without the action_ so that they can't be accessed by the public.Alternatively, you could switch to restful methods which is basically a way to respond to some input based on the type of query you get, for instance when you receive a "GET" request to the login page that means that the user needs to see the login screen, when you receive a "POST"request that would usually mean that the user is posting login data and accordingly you can respond which will help you cut down on the number of functions for more information on restful methods you can read this brilliant article by Ryan Tomayako at http://tomayko.com/writings/rest-to-my-wifeTo use restful methods you need to mention restful to true and then append the action keyword before the function's name.This way you can eliminate the need for another route to process and verify the users credentials!and if you don't want certain methods to be accessed using restful methods then just don't include the action keyword, (get,post,...) in the function name.Combining restful methods with smart routing is the most efficient way to keep your code clean and safe.

DomPDF: Image not readable or empty

David P. P.

[DomPDF: Image not readable or empty](https://stackoverflow.com/questions/25558449/dompdf-image-not-readable-or-empty)

For some reason, DomPDF won't render an image included in the html that is being parsed:However, the image is rendered on the page when it is returned as html:I've looked at these issues and have make sure that DOMPDF_ENABLE_REMOTE is set to true and verified file permissions:

dompdf image not real image not readable or empty

Image error in DOMPDF for ZF2Are there any other things that I should be checking for?

2014-08-28 21:37:52Z

For some reason, DomPDF won't render an image included in the html that is being parsed:However, the image is rendered on the page when it is returned as html:I've looked at these issues and have make sure that DOMPDF_ENABLE_REMOTE is set to true and verified file permissions:

dompdf image not real image not readable or empty

Image error in DOMPDF for ZF2Are there any other things that I should be checking for?Following helped me like charm, at least localy, and even with The solution is to change the image SRC to the absolute path on the server, like this:All of the following worked for me:$_SERVER["DOCUMENT_ROOT"] is C:/wamp/www/ZendSkeletonApplication/publicThanks to this: lost in codeOk

I had the same problem with image using :But if I add a . before /images, without changing anything in dompdf_config.custom.inc, it worksHope it helpsAs there was another answer that suggests enabling the remote option in module.config.php and I can't yet add comments, I thought it would be best to answer that this file does not exist in newer versions of DomPDF.If you need to include remotely stored images in a newer version you have to pass it as an option to the constructor:This fixed the issue I had.Now (May 2018) the correct way is :In path :change settings то true.None of the solutions here worked for me. Instead I just base64 encoded the image and then it worked. You can use this tool.I solve this problem by using external CSS's full path. This one worked on my linux ubuntu server :<link href="{{ public_path('css/style.css') }}" /><img src="{{ public_path('images/image.jpg') }}" />and work on image.For our use case we had to convert all the images on the page to base64 since the pdf should be usable offline. Our code lives inside a controller class but you can modify that to your needs.Here's the code:You can use base64 encoded image

How create package in Laravel 5?

Marty Aghajanyan

[How create package in Laravel 5?](https://stackoverflow.com/questions/27661322/how-create-package-in-laravel-5)

command is not available in laravel 5, but how now create package in laravel 5 ?

2014-12-26 19:52:36Z

command is not available in laravel 5, but how now create package in laravel 5 ?The laravel workbench has been renamed in laravel 5 to "Package Development" in the documentationhttp://laravel.com/docs/master/packagesNotice that there is no longer a workbench command and you need to create your own package structure, as the Laravel creator want to limit the dependency between created packages and the Laravel framework (#ref)UPDATE: Laravel 5 is now stable and the illuminate/workbench package can be used in a laravel 5 application as I suggested in this postShameless self-promotion, but I've written a post about this called "Creating Laravel 5 packages for dummies" that explains how to create the package, how to put it on GitHub & Packagist and how to push changes/new versions afterwards.If you're already familiar with creating packages in Laravel 4, the fastest solution I've found was to use this CLI tool.

Authenticate users from more than two tables in laravel 5 [duplicate]

RAUSHAN KUMAR

