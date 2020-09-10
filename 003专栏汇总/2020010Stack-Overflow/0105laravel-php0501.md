AlxVallejo

[brew link php71: Could not symlink sbin/php-fpm](https://stackoverflow.com/questions/46778133/brew-link-php71-could-not-symlink-sbin-php-fpm)

I'm trying to install Laravel Valet, which requires php 7.1, but when i run brew install php71, I get the following error:I get the same error when i run brew link php71. If i run php -v, I actually see that I'm currently running PHP 7.1.7.But when I run valet install, I get:I don't even have an sbin directory in /usr/local. Any suggestions?

2017-10-16 19:58:08Z

I'm trying to install Laravel Valet, which requires php 7.1, but when i run brew install php71, I get the following error:I get the same error when i run brew link php71. If i run php -v, I actually see that I'm currently running PHP 7.1.7.But when I run valet install, I get:I don't even have an sbin directory in /usr/local. Any suggestions?I solved this problem by first creating the directory sbin:then if you are like me using macOS highSierra 10+ you need to run:after thisInstalling Laravel Valet, I had a similar issue with sbin not being writable. I had to make the directory, then utilized the solution included at this page. This finally allowed me the proper permissions to run a brew link command with a previously installed version of php 7.1.

How can I return a view from an AJAX call in Laravel 5?

Chris Jackson

[How can I return a view from an AJAX call in Laravel 5?](https://stackoverflow.com/questions/28634712/how-can-i-return-a-view-from-an-ajax-call-in-laravel-5)

I'm trying to get an html table to return on an ajax call.  route:  ajax on calling page:  controller:  view:  Im not getting anything in the json.html data. nothing. If in the controller I say:  This works just fine.  How can I return a view from an ajax call in Laravel 5.

2015-02-20 17:24:11Z

I'm trying to get an html table to return on an ajax call.  route:  ajax on calling page:  controller:  view:  Im not getting anything in the json.html data. nothing. If in the controller I say:  This works just fine.  How can I return a view from an ajax call in Laravel 5.The view() function just creates an instance of the View class. Not just an HTML string. For that you should call render():use string function before view file name like asSo this question is old and the most upvoted answer did not solve the problem for the asker and for me neither. I ran into the same problem and it took me two days to find the solution. Everywhere I came looking for answers the said use ->render(). But nothing returned. I have a partial view which I wanted to include. I had not extended my partial view or given it a section name. Since this is not necessary when including it inside a blade file with the include directive.So the solution is, enclose your html inside a section and instead of render(), use renderSections()['sectionname']. Just using render() will not work. I hope this will safe somebody some time and frustration!if your ajax is correct and you are getting results from your DBDon't return your view as JSON, just return the view from your controller

For example:This will work for sure.Ok - I found by trial and error that you don't include the blade template commands in the view file for this to work.I had:and now its working with:Altho I searched - I never found documentation stating this.remove this if condition and see if it worksidk if you are still looking for answer but i ran into same issue as you, it kept returning blank. the key to success was to remove @section @endsection part in your partial viewThis helped me:I have used echo view('ajaxView') instead  return view('ajaxView').I got it working without these : @section & @stopeither or thisboth workedIf you use AJAX in Laravel then when you want to display view with AJAX response don't use return command instead use echo command.For example, don't use:use:Other example, don't use:use:

Laravel db migration - renameColumn error - Unknown database type enum requested

Latheesan

[Laravel db migration - renameColumn error - Unknown database type enum requested](https://stackoverflow.com/questions/29165259/laravel-db-migration-renamecolumn-error-unknown-database-type-enum-requested)

I am using Laravel 4.2. I have the following library loaded in my composer.jsonI created the following migration:Where delivery_notes column type is text.When I run the migration, I get the following error:Any idea why I am getting this error? How should I go about fixing this? I need to rename a column in my table. Are there any alternative way to rename the column?

2015-03-20 11:16:48Z

I am using Laravel 4.2. I have the following library loaded in my composer.jsonI created the following migration:Where delivery_notes column type is text.When I run the migration, I get the following error:Any idea why I am getting this error? How should I go about fixing this? I need to rename a column in my table. Are there any alternative way to rename the column?Laravel's documentation says that:Here: https://github.com/laravel/framework/issues/1186You can find some workarounds about this issue. And since you said that this column is not enum, take a look at @upngo's comment:Also I found this article that focuses on this issue and suggest an option that might help you.http://www.paulbill.com/110/laravel-unknown-database-type-enum-requested-doctrinedbalplatformsmysqlplatform-may-not-support-itThis works for me on Laravel 5.1I met this problem in Laravel version 5.1.19 (LTS). This is actual for earlier versions too.

I wanted to inform you as I resolved the issue base on previous comments.First of all, I tried next code in my migration file:But after command php artisan migrate, I got next error:As you know DBAL was removed from the laravel core and we need add it to the composer.json.(For example:"require": {"doctrine/dbal": "2.5.1"}).

I set DBAL as required and tried again to do migrate command but got next error:Then I tried next raw sql in my migration file:

For up():For down():and it works.P.S. For renaming other fields in the table which contains an enum field we should 

use same schema with raw sql as was written in previous comments.You can add custom constructor to migration and explain to Doctrine that enum should be treated like string.I had the same problem with Laravel 5.1 and PostGres.

So basically I used the DB::statement to create the ENUM and solve the problem:And then:Here is the answer for Laravel 5.2.45+ (might work in 5.1 as well, have not tested or checked yet, please let me know so I can update this question.)Add this line in you up method:Something like this:Though the original author had issues with Laravel 4, this can safely be fixed in Laravel 5 by bumping the version of doctrine/dbal in your composer.json to ^2.6, as it was fixed in this PR on release 2.6.0Make sure to check for compatibility-breaking changes in the release changelog

Check if name is unique among non-deleted items with laravel validation

Samsquanch

[Check if name is unique among non-deleted items with laravel validation](https://stackoverflow.com/questions/23374995/check-if-name-is-unique-among-non-deleted-items-with-laravel-validation)

I have a simple form which posts to a controller which checks if a name for an item is already taken for a particular project. If it is, then it returns an error. This is the code I'm using for that:The problem I've run into is that instead of a hard delete, I'm using a soft delete to remove them from the database, meaning that, for example, 'Test' can only be used as the name once, even after it's been deleted.How can I make it check that it is unique for that project among the items that are not soft deleted?

2014-04-29 20:51:02Z

I have a simple form which posts to a controller which checks if a name for an item is already taken for a particular project. If it is, then it returns an error. This is the code I'm using for that:The problem I've run into is that instead of a hard delete, I'm using a soft delete to remove them from the database, meaning that, for example, 'Test' can only be used as the name once, even after it's been deleted.How can I make it check that it is unique for that project among the items that are not soft deleted?You may try this:This will make sure that the name in the versions table will be unique, if a record is soft deleted and has same name name then it won't be counted, means, name will be accepted even if there is a soft deleted record with the same name exists.To ignore a model when updating, you should pass the id after name in the place of first NULL.Update: Also you may use something like this to add your own custom rule:You may use it like this:I know this question is old, but I stumbled across this when looking for a solution to a similar problem.  You don't need custom validation code.I have a database of ledger codes in which the 'name' and 'short_name' must be unique for each user (user_id). I have soft deletes enabled, so they should only be unique among non-deleted rows for a given user.This is my function which returns the validation strings:For any one wondering about the argument string syntax for the unique validator, it is as follows: The value fields in field name/value pairs can be either a value to match, NULL, or NOT_NULL.If someone is looking for solution using Rule class.Basically, we just ignoring rows which deleted_at fields are not null.Here are the methods which you can use along with ignore function: https://laravel.com/api/5.7/Illuminate/Validation/Rules/DatabaseRule.htmlOn Create Method:On Update Method:For add recordFor edit that record

General error: 1364 Field 'user_id' doesn't have a default value [duplicate]

Mohammed Sabbah

[General error: 1364 Field 'user_id' doesn't have a default value [duplicate]](https://stackoverflow.com/questions/43651446/general-error-1364-field-user-id-doesnt-have-a-default-value)

I am trying to assign the user_id with the current user but it give me this errorhere is my methodwith these fillablesHowever this method do the jobany idea why this fail?

2017-04-27 07:37:59Z

I am trying to assign the user_id with the current user but it give me this errorhere is my methodwith these fillablesHowever this method do the jobany idea why this fail?

you need to change database strict mode. for disable follow below stepSo, after After reviewing the code again, I found the error.

I am wondering how no one notice that!

In the above code I wroteactually, there is no need for the request function warping the body of the create function.Here's how I did it:This is my PostsControllerAnd this is my Post Model.And try refreshing the migration if its just on test instanceNote: migrate: refresh will delete all the previous posts, usersTry 'user_id' => auth()->id

or'user_id' => Auth::user()->idinstead of There are two solutions for this issue.First, is to create fields with default values set in datatable. It could be empty string, which is fine for MySQL server running in strict mode.Second, if you started to get this error just recently, after MySQL/MariaDB upgrade, like I did, and in case you already have large project with a lot to fix, all you need to do is to edit MySQL/MariaDB configuration file (for example /etc/my.cnf) and disable strict mode for tables:This error started to happen quite recently, due to new strict mode enabled by default. Removing STRICT_TRANS_TABLES from sql_mode configuration key, makes it work as before.User Auth::user()->id instead.Here is the correct way :If your user is authenticated, Then Auth::user()->id will do the trick. I've had a similar issue with User registration today and I was getting aSQLSTATE[HY000]: General error: 1364 Field 'password' doesn't have a default value (SQL: insert into `users`

I fixed it by adding password to my protected $fillable array and it workedprotected $fillable = [

        'name',

        'email',

        'password',

    ];

I hope this helps.Try doing Auth::id(), like also remember to include Auth facade at top of your controller which is App\Http\Controllers\Authuse print_r(Auth);then see in which format you have user_id / id variable and use itIt's seems flaw's in your database structure. Keep default value None to your title and body column.Try this:In my case, the error was because I had not declared the field in my $fillable array in the model. Well, it seems to be something basic, but for us who started with laravel it could work.Use database column nullble() in Laravel. You can choose the default value or nullable value in database.The above error can be as a result of wrongly named input variables from the view form, which resorts to seeking a default value since no variable is supplied hence-- SQLSTATE[HY000]: General error: 1364 Field 'user_id' doesn't have a 

default value (SQL: insert into posts (updated_at, created_at) 

values (2017-04-27 10:29:59, 2017-04-27 10:29:59))In your file create_file, the null option must be enabled.you dont need the request() as you doing that already pulling the value of body and title

Get user data using access token in laravel passport client app

Tauras

[Get user data using access token in laravel passport client app](https://stackoverflow.com/questions/41746078/get-user-data-using-access-token-in-laravel-passport-client-app)

I have successfully created server.app and client.app using Laravel Passport documentation. Everything works as expected.client.app Route:By default, this route returns access_token, with which i can do whatever i want.Request:Returns:Question:How to make correct request to server.app with given access_token in client.app to get for example user(s) email(s).Should i use: http://server.app/api/user request to get data? If yes, how i can do that? If possible, please write a code.Thanks for any answers.

2017-01-19 15:49:04Z

I have successfully created server.app and client.app using Laravel Passport documentation. Everything works as expected.client.app Route:By default, this route returns access_token, with which i can do whatever i want.Request:Returns:Question:How to make correct request to server.app with given access_token in client.app to get for example user(s) email(s).Should i use: http://server.app/api/user request to get data? If yes, how i can do that? If possible, please write a code.Thanks for any answers.I've been going absolutely insane about this issue! It just made no freaking sense as to why it kept spitting out the stupid Unauthenticated error when trying to hit-up a route such as /api/user. After much searching (MUCH searching), I finally found the answer. If you see this fero from Laracasts, you're my hero!https://laracasts.com/discuss/channels/laravel/laravel-53-passport-api-unauthenticated-in-postman-using-personal-access-tokensEdit:Once you've made the change to the app\Providers\RouteServiceProvider.php mentioned above, proceed with the below example.First things first, we need to retrieve a fresh access_token. To do this, I'm using the password grant_type (more info: https://laravel.com/docs/5.4/passport#password-grant-tokens)To retrieve a fresh access_token, I've created a new route on routes/web.php and called it /connect. I've then placed the code from the above link into it:Using Chrome Postman, you need to:Example result:Highlight the access_token string and copy it to a text editor.You'll then need to create a new route in routes/api.php. The route below will simply output the current API users' info:Once you've done the above, make these changes to Postman:Example output:Have you tried running it on POSTMAN chrome app?

If not, download it. https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=enFill the information.

After you successfully generated the data, click the CODE button from the top-right (I highlighted it with green).Lastly, select your language and copy the code. For PHP, I selected php cURL.Hope it works.According to Laravel documentation, you should add route to server app (routes/api.php): $response->getBody();Make request via quzzle:

What is the difference between laravel cursor and laravel chunk method?

Suraj

[What is the difference between laravel cursor and laravel chunk method?](https://stackoverflow.com/questions/45464676/what-is-the-difference-between-laravel-cursor-and-laravel-chunk-method)

I would like to know what is the difference between laravel chunk and laravel cursor method. Which method is more suitable to use? What will be the use cases for both of them? I know that you should use cursor to save memory but how it actually works in the backend? A detailed explanation with example would be useful because I have searched on stackoverflow and other sites but I didn't found much information.Here is the code snippet's from the laravel documentation.Chunking ResultsUsing Cursors

2017-08-02 15:12:39Z

I would like to know what is the difference between laravel chunk and laravel cursor method. Which method is more suitable to use? What will be the use cases for both of them? I know that you should use cursor to save memory but how it actually works in the backend? A detailed explanation with example would be useful because I have searched on stackoverflow and other sites but I didn't found much information.Here is the code snippet's from the laravel documentation.Chunking ResultsUsing CursorsIndeed This question might attract some opinionated answer, however the simple answer is here in Laravel DocsJust for reference:This is chunk:This is Cursor:Chunk retrieves the records from the database, and load it into memory while setting a cursor on the last record retrieved so there is no clash.So the advantage here is if you want to reformat the large record before they are sent out, or you want to perform an operation on an nth number of records per time then this is useful. An example is if you are building a view out/excel sheet, so you can take the record in counts till they are done so that all of them are not loaded into the memory at once and thereby hitting the memory limit.Cursor uses PHP Generators, you can check the php generators page however here is an interesting caption:While I cannot guarantee that I understand fully the concept of Cursor, but for Chunk, chunk runs the query at every record size, retrieving it, and passing it into the closure for further works on the records.Hope this is useful.We have a comparison:  chunk() vs cursor()10,000 records:100,000 records:chunk is based on pagination, it maintains a page number, and do the looping for you.For example, DB::table('users')->select('*')->chunk(100, function($e) {}) will do multiple queries until the result set is smaller than the chunk size(100):cursor is based on PDOStatement::fetch and Generator. will do issue a single query:But the driver doesn't fetch the result set at once.ProsConsProsConsI used to think cursor() will do query each time and only keep one row result in memory. So when I saw @mohammad-asghari's comparison table I got really confused. It must be some buffer behind the scenes.By tracking Laravel Code as below I understood Laravel build this feature by wrap PDOStatement::fetch().

And by search buffer PDO fetch and MySQL, I found this document.https://www.php.net/manual/en/mysqlinfo.concepts.buffering.phpso by doing PDOStatement::execute() we actually fetch whole result rows at ones and stored in the memory, not only one row. So if the result is too huge, this will lead to out of memory exception.Though the Document shown we could use $pdo->setAttribute(PDO::MYSQL_ATTR_USE_BUFFERED_QUERY, false); to get rid of buffered query. But the drawback should be caution.I made some benchmark using cursor and wherehere is the result: 

How to seed database migrations for laravel tests?

Jeff Puckett

[How to seed database migrations for laravel tests?](https://stackoverflow.com/questions/42350138/how-to-seed-database-migrations-for-laravel-tests)

Laravel's documentation recommends using the DatabaseMigrations trait for migrating and rolling back the database between tests.However, I've got some seed data that I would like to use with my tests. If I run:then it works for the first test, but it fails subsequent tests. This is because the trait rolls back the migration, and when it runs the migration again, it doesn't seed the database. How can I run the database seeds with the migration?

2017-02-20 16:52:39Z

Laravel's documentation recommends using the DatabaseMigrations trait for migrating and rolling back the database between tests.However, I've got some seed data that I would like to use with my tests. If I run:then it works for the first test, but it fails subsequent tests. This is because the trait rolls back the migration, and when it runs the migration again, it doesn't seed the database. How can I run the database seeds with the migration?All you need to do is make an artisan call db:seed in the setUp functionref: https://laravel.com/docs/5.6/testing#creating-and-running-testsIt took me some digging to figure this out, so I thought I'd share.If you look at the source code for the DatabaseMigrations trait, then you'll see it has one function runDatabaseMigrations that's invoked by setUp which runs before every test and registers a callback to be run on teardown.You can sort of "extend" the trait by aliasing that function, re-declare a new function with your logic in it (artisan db:seed) under the original name, and call the alias inside it.I know this question has already been answered several times, but I didn't see this particular answer so I thought I'd throw it in. For a while in laravel (at least since v5.5), there's been a method in the TestCase class specifically used for calling a database seeder:https://laravel.com/api/5.7/Illuminate/Foundation/Testing/TestCase.html#method_seedwith this method, you just need to call $this->seed('MySeederName'); to fire the seeder.So if you want this seeder to fire before every test, you can add the following setUp function to your test class:The end result is the same as:or But the syntax is a bit cleaner (in my opinion).If you're using the RefreshDatabase testing trait:Here is an alternate solution, in case you prefer to bypass Artisan's native DatabaseMigrations and seeder/migration methods. You can create your own trait to seed your database:Then call it in your test like this: 

Why does `catch (Exception $e)` not handle this `ErrorException`?

duality_

[Why does `catch (Exception $e)` not handle this `ErrorException`?](https://stackoverflow.com/questions/15071191/why-does-catch-exception-e-not-handle-this-errorexception)

I get the ErrorException on the function call bellow. How can this be? Why is it not caught?The underlying reason for the error is a file_put_contents call. I'm using the Laravel 4 framework, if it makes any difference.

2013-02-25 16:08:14Z

I get the ErrorException on the function call bellow. How can this be? Why is it not caught?The underlying reason for the error is a file_put_contents call. I'm using the Laravel 4 framework, if it makes any difference.I suspect that you need to write this:Note the \ in front of Exception.When you have declared a namespace, you need to specify the root namespace in front of classes like Exception, otherwise the catch block here will be looking for \Your\Namespace\Exception, and not just \Exception

How to write a migrate to undo the unique constraint in Laravel?

cyber8200

[How to write a migrate to undo the unique constraint in Laravel?](https://stackoverflow.com/questions/30607670/how-to-write-a-migrate-to-undo-the-unique-constraint-in-laravel)

I would do this to make my email field unique in the table. $table->unique('email');I've triedThen, when I run php artisan migrate, I got this It tell me that it's not there, but I'm 100% sure that it's there.How do write a migration to undo that ?

2015-06-02 22:24:40Z

I would do this to make my email field unique in the table. $table->unique('email');I've triedThen, when I run php artisan migrate, I got this It tell me that it's not there, but I'm 100% sure that it's there.How do write a migration to undo that ?You have to do $table->dropUnique('users_email_unique');This the better way to drop unique. You can use the real column name here.

Laravel - syntax error, unexpected end of file

Ivanka Todorova

[Laravel - syntax error, unexpected end of file](https://stackoverflow.com/questions/16116212/laravel-syntax-error-unexpected-end-of-file)

I have a website which works fine on host, but I'm currently trying to install it on localhost.I've downloaded everything and configured to work on localhost - Database & URL.The problem is this error:And I don't know what causes it. Any solutions?P.S. I've setup in my windows' host file 127.0.0.1 myproject.dev.

2013-04-20 03:23:41Z

I have a website which works fine on host, but I'm currently trying to install it on localhost.I've downloaded everything and configured to work on localhost - Database & URL.The problem is this error:And I don't know what causes it. Any solutions?P.S. I've setup in my windows' host file 127.0.0.1 myproject.dev.There is an error within one of your views. If there is a more detailed stack trace it should show you details of a view, although the name will be an md5() string so it's a bit hard to find. You might want to delete all compiled Blade views in storage/views and let Blade re-compile the views. If you still get the error then check your views to make sure you have all the proper closing tags, e.g., @endif or @endforeachAlways double check your views for any syntax errors.I've run into this same error and I was able to fix it by adding spaces to the content within an inline if statement. For example:Experienced error with:Fixed error with:This may not be a problem in all cases and it was certainly difficult to track down but it is just one example that can cause this exact error.A variation of this problem -- I had a php block, which I'd opened with 

<?  as opposed to <?php worked fine on LocalHost/MAMP, but gave the above error under Nginx/Ubuntu 16.04/PHP7 (both Laravel)you should remove a character from view file. for example my character was "," (a comma) before some "@endfor". when i remove those worked!

Parameters inside Laravel localized string

JasonGenX

[Parameters inside Laravel localized string](https://stackoverflow.com/questions/30242119/parameters-inside-laravel-localized-string)

I'd like have something like this in the lang/en/mymsgs.phpI would provide the content for %1 and %2 when getting the 'string1' from my code. I couldn't find a way to do this. Any pointers? 

2015-05-14 16:12:48Z

I'd like have something like this in the lang/en/mymsgs.phpI would provide the content for %1 and %2 when getting the 'string1' from my code. I couldn't find a way to do this. Any pointers? Laravel message localization uses named, not numeric, parameters.Rewriting your example message:You can now use, for example:If anyone use string translation for Laravel. They can use like this ->

__('Some translatable string with :attribute',['attribute' => $attribute_var])

check the documentation for more https://laravel.com/docs/5.7/localization#using-short-keys

Eloquent attach/detach/sync fires any event?

Mihai Crăiță

[Eloquent attach/detach/sync fires any event?](https://stackoverflow.com/questions/28925292/eloquent-attach-detach-sync-fires-any-event)

I have a laravel project, and I need to make some calculations immediately after I save a model and attach some data to it. Is there any event that is triggered in laravel after calling attach (or detach/sync)?

2015-03-08 10:14:46Z

I have a laravel project, and I need to make some calculations immediately after I save a model and attach some data to it. Is there any event that is triggered in laravel after calling attach (or detach/sync)?Steps to solve your problem:and that's it. I created package that already doing that: https://github.com/fico7489/laravel-pivotNo, there are no relation events in Eloquent. But you can easily do it yourself (Given for example Ticket belongsToMany Component relation):event object as simple as this:then a basic listener as a sensible example:and usage:Of course you could do it without creating Event objects, but this way is more convenient, flexible and simply better.Laravel 5.8 now fires events on ->attach()Check out: https://laravel.com/docs/5.8/releasesAnd search for: Intermediate Table / Pivot Model Eventshttps://laracasts.com/discuss/channels/eloquent/eloquent-attach-which-event-is-fired?page=1

Laravel Pass Parameter from Route to Filter

735Tesla

[Laravel Pass Parameter from Route to Filter](https://stackoverflow.com/questions/20790922/laravel-pass-parameter-from-route-to-filter)

I am using the laravel framework.

If I have the following route:And this filter:How can I pass parameters to the filter so that when visiting /test/foobar I would get a page saying: "The value is foobar"?

2013-12-26 20:35:55Z

I am using the laravel framework.

If I have the following route:And this filter:How can I pass parameters to the filter so that when visiting /test/foobar I would get a page saying: "The value is foobar"?Filters can be passed parameters, like the Route object or the Request:Specifying Filter ParametersAbove example is taken from the docs: http://laravel.com/docs/routing#route-filtersOnce you're inside the closure, you take the parameter from the $route:

Laravel Eloquent truncate - Foreign key constraint

Wesley

[Laravel Eloquent truncate - Foreign key constraint](https://stackoverflow.com/questions/29119272/laravel-eloquent-truncate-foreign-key-constraint)

I am having some issues with deleting data using Laravel 5. I seem to be stuck on a 'foreign key constraint', while I don't see why. In my current database model I have a datapoints table, which has a foreign key to the sensors table (datapoints.sensors_id -> sensor.id).The code I am trying:});The result:I would understand this constraint if the order would be inverse (first deleting sensors), but when datapoints is empty, there should be no problem deleting sensors? I have also tried:Lastly I also tried adding explicitly 'DB::commit()' between the delete statements, but all return the same result.Is this normal behaviour? Am I missing something?Thanks in advance.Cheers,Wesley

2015-03-18 10:14:26Z

I am having some issues with deleting data using Laravel 5. I seem to be stuck on a 'foreign key constraint', while I don't see why. In my current database model I have a datapoints table, which has a foreign key to the sensors table (datapoints.sensors_id -> sensor.id).The code I am trying:});The result:I would understand this constraint if the order would be inverse (first deleting sensors), but when datapoints is empty, there should be no problem deleting sensors? I have also tried:Lastly I also tried adding explicitly 'DB::commit()' between the delete statements, but all return the same result.Is this normal behaviour? Am I missing something?Thanks in advance.Cheers,WesleyNo, this is the way your database works. You can't truncate table that is referenced by some other table. You may do something liketo disable foreign key checks, truncate tables and enable it again.If you prefer to use Eloquent objects, Maksym's answer the "Eloquent" way

Get Laravel Models with All Attributes

kenshin9

[Get Laravel Models with All Attributes](https://stackoverflow.com/questions/33512184/get-laravel-models-with-all-attributes)

Is there a way to retrieve a model in Laravel with all the attributes, even if they're null? It seems to only return a model with the attributes that aren't null.The reason for this is that I have a function that will update the model attributes from an array, if the attributes exists in the model. I use the property_exists() function to check the model if it has a particular attribute before setting it. The array key and model attribute are expected to match, so that's how it works. It works fine if the model already has the attributes set, because the attribute exists and takes the value from the array. But nothing will get updated or set if the attribute was previously null, because it fails the property_exists() check.What's ultimately happening is that I have a single array of attributes, and then perhaps two models. And I run my setter function, passing in the attributes array, and each of the objects in separate calls. If the model has a matching property, it gets updated.

2015-11-04 01:28:25Z

Is there a way to retrieve a model in Laravel with all the attributes, even if they're null? It seems to only return a model with the attributes that aren't null.The reason for this is that I have a function that will update the model attributes from an array, if the attributes exists in the model. I use the property_exists() function to check the model if it has a particular attribute before setting it. The array key and model attribute are expected to match, so that's how it works. It works fine if the model already has the attributes set, because the attribute exists and takes the value from the array. But nothing will get updated or set if the attribute was previously null, because it fails the property_exists() check.What's ultimately happening is that I have a single array of attributes, and then perhaps two models. And I run my setter function, passing in the attributes array, and each of the objects in separate calls. If the model has a matching property, it gets updated.Here are two ways to do this. One method is to define default attribute values in your model.Then, you can use the getAttributes() method to get the model's attributes.If you don't want to set default attributes though, I wrote up a quick method that should work.Basically, if the attribute has not been set, this will append a null value to that attribute and return it to you as an array.Above will return an array of raw attributes (as stored in the database table)Above will return all the model's raw, mutated(if used), and appended attributesHope it will helpful!!Update:If you are trying to do this after instantiating like so:then please differ to Thomas Kim's answer.Otherwise:

You could use the toArray() or getArributes() method on the model instance, that would give back all the attributes including nulls. Then you can use array_key_exists to check.Like so:What if you were to explicitly declare all the fields you want back.Pretty generic example but hopefully someone will find this useful.

Laravel difference between Events, Listeners, Jobs, Queues [closed]

Taylor

[Laravel difference between Events, Listeners, Jobs, Queues [closed]](https://stackoverflow.com/questions/36106532/laravel-difference-between-events-listeners-jobs-queues)

It sounds extremely confusing to me, what are the differences? Can someone please do an ELI5?

2016-03-19 20:04:42Z

It sounds extremely confusing to me, what are the differences? Can someone please do an ELI5?Although they all can work together, I find it's easiest to look at Events and Listeners together, and then Jobs and Queues together.Events and ListenersEvents are objects that hold data that are "fired", the Laravel event system "catches" the event object when it is fired, and then all the Listeners that are registered for that particular event are run.If you think about it, this is akin to how exceptions work. You throw an exception, and you can define several catch blocks to react depending on which exception is thrown. In the case of Events and Listeners, an Event is thrown and one or more Listeners represent the contents of a catch block. Though similar, Events and Listeners are not error handlers, they just have conceptual similarities.Jobs and QueuesI think the best way to think of these is like a line at a bank. The line itself is the Queue, and each customer in the line is a Job.In order to process Jobs in the Queue you need command line processes or daemons. Think of launching a queue daemon on the command line as adding a new bank teller to the pool of available bank tellers. When a daemon is available it will ask the Queue for the next Job like the bank teller asking for the next person in line to step to the window.Each person in line has a specific task they want accomplished, like making a deposit or withdrawal. The action that the person in line needs completed is the Worker in Laravel.The Worker is the thing the daemon will do for the Job that was taken from the Queue, just like the task is the thing the bank teller will do for the customer who stepped forward from the line.Hope any of that makes some sense.

Laravel Policies - How to Pass Multiple Arguments to function

Johannes

[Laravel Policies - How to Pass Multiple Arguments to function](https://stackoverflow.com/questions/36482737/laravel-policies-how-to-pass-multiple-arguments-to-function)

I'm trying to authorize a users character to delete/update post. I was using policies to do so, but I could only pass one parameter to the policy function. If I pass more than the user and another variable, the variable isn't passed into the function.Models: User has many characters, a character can post multiple posts. So for authorization purposes, I would have to compare the post's character_id with the current character's id...-Per the docs, you can pass more multiples to the Gate Facade:But I couldn't find anyway to do so with policies. What I had to do was to inject the Request object to get the object needed for authorization. Basically I wouldn't even need the User Object. Using the Request object works, but it feels very hacky. Is there a nicer way to achieve this?edit:In the CharacterLocationController I have a method show and I want to authorize the action before showing the resource. The policy is registered like this: 'App\Location' => 'App\Policies\LocationPolicy' in the AuthServiceProviderI dumped the array passed to the policy function, and it only outputs the $location.

2016-04-07 17:01:30Z

I'm trying to authorize a users character to delete/update post. I was using policies to do so, but I could only pass one parameter to the policy function. If I pass more than the user and another variable, the variable isn't passed into the function.Models: User has many characters, a character can post multiple posts. So for authorization purposes, I would have to compare the post's character_id with the current character's id...-Per the docs, you can pass more multiples to the Gate Facade:But I couldn't find anyway to do so with policies. What I had to do was to inject the Request object to get the object needed for authorization. Basically I wouldn't even need the User Object. Using the Request object works, but it feels very hacky. Is there a nicer way to achieve this?edit:In the CharacterLocationController I have a method show and I want to authorize the action before showing the resource. The policy is registered like this: 'App\Location' => 'App\Policies\LocationPolicy' in the AuthServiceProviderI dumped the array passed to the policy function, and it only outputs the $location.I think there is possibly some confusion here on what functions are doing what.When you useOr in the CommentPolicyAll you are doing is defining the rules.  At this point, we aren't worried about passing anything, only that the objects we received can or should be able to interact with each other.  The only difference between these two is when using policies, it's just an easy way to abstract all your rules into one simple and easy to read class.  If you have an app with potentially hundreds of tables and models, it will get confusing fast if you have these rules littered all over your app so policies would help to keep them all organized.It's when you are actually checking if someone has permission to do something when you should be passing these items along.  For example, when you do the following, Or if in the CommentControllerThat is what controls which parameters are going to be passed to the policy or the Gate::define method.  According to the docs, the $user parameter is already added for you so in this case, you only need to worry about passing the correct $post and $comment being modified.

Where is Illuminate?

sCha

[Where is Illuminate?](https://stackoverflow.com/questions/38319050/where-is-illuminate)

Every time when I try to do some modifications in certain area, Authentication for example, I end up finding everything is declared in Illuminate\Foundation\....Okay, now all I need to do is get to that location and look into some codes.But hey, where is this Illuminate and all stuff???I don't see any folders named Illuminate anywhere in my Laravel package.Tried to search for the solution but I guess I'm the only silly person who lacks ability in understanding some basics.

2016-07-12 02:23:55Z

Every time when I try to do some modifications in certain area, Authentication for example, I end up finding everything is declared in Illuminate\Foundation\....Okay, now all I need to do is get to that location and look into some codes.But hey, where is this Illuminate and all stuff???I don't see any folders named Illuminate anywhere in my Laravel package.Tried to search for the solution but I guess I'm the only silly person who lacks ability in understanding some basics.Just to officially answer this question.The files OP was looking for, along with any other Laravel or package files, are stored in the vendor folder - which you can access from the root Laravel directory.As @Gavin points out in the comments:Laravel take the advantage of the autoload features in Composer. One quick and simple tips:You can actually find this in composer.lock file. Then find the PSR autoload. For instance, for Laravel/framework:Since there are a lot of packages in vendor folder, refer the name of the package in the composer.lock. For example, Illuminate is under laravel/framework packages. Then, look for vendor/laravel/frameworkThen you know, Illuminate is mapped to vendor/laravel/framework/src/Illuminate

How can I change the public path to something containing an underscore in Laravel Mix?

Mike

[How can I change the public path to something containing an underscore in Laravel Mix?](https://stackoverflow.com/questions/42051576/how-can-i-change-the-public-path-to-something-containing-an-underscore-in-larave)

In Laravel 5.4 Mix was introduced to compile assets and maintain the asset pipeline.  Mix defaults to your public directory being named public.  In many cases, including mine, my public directory is called something else.  In my case, it's public_html.How can I change the public directory where assets are compiled to?I have tried changing the paths within webpack.min.js to:Unfortunately this compiles to:In Laravel 5.3 and Elixir this was as simple as:I have checked Mix's config file, but can't see anything obvious here.Please note: this is Laravel Mix, the npm package, so it's nothing to do with amends in the index.php file.

2017-02-05 11:35:25Z

In Laravel 5.4 Mix was introduced to compile assets and maintain the asset pipeline.  Mix defaults to your public directory being named public.  In many cases, including mine, my public directory is called something else.  In my case, it's public_html.How can I change the public directory where assets are compiled to?I have tried changing the paths within webpack.min.js to:Unfortunately this compiles to:In Laravel 5.3 and Elixir this was as simple as:I have checked Mix's config file, but can't see anything obvious here.Please note: this is Laravel Mix, the npm package, so it's nothing to do with amends in the index.php file.There is an undocumented (I believe) method called setPublicPath.  You can then omit the public path from the output.  setPublicPath plays nicely with underscores.In Laravel 5.5 I've solved like this,In Laravel 5.8In Laravel 5.4 you can us this code:in AppServiceProvider :

Laravel : Redis No connection could be made : [tcp://127.0.0.1:6379]

Gammer

[Laravel : Redis No connection could be made : [tcp://127.0.0.1:6379]](https://stackoverflow.com/questions/38604524/laravel-redis-no-connection-could-be-made-tcp-127-0-0-16379)

I have installed redis with laravel by adding "predis/predis":"~1.0",Then for testing i added the following code :In app/config/database.php i have :It throws the following error : No connection could be made because the target machine actively refused it. [tcp://127.0.0.1:6379]I using virtualhost for the project.

Using Xampp with windows.

2016-07-27 05:37:53Z

I have installed redis with laravel by adding "predis/predis":"~1.0",Then for testing i added the following code :In app/config/database.php i have :It throws the following error : No connection could be made because the target machine actively refused it. [tcp://127.0.0.1:6379]I using virtualhost for the project.

Using Xampp with windows.First make sure Redis is actually listening on that port by opening up powershell and typing netstat -aon | more (this command may need to be enabled in features or installed somehow).  If it is listening then check your firewall settings. If if not listening then make sure Redis is started and is configured to listen on that port.It looks like predis/predis is a client library only.  See https://packagist.org/packages/predis/predis.You need to install the Redis server, but it looks like it is not officially supported on Windows. See http://redis.io/download.  Per information on that page, it looks like there is a Win64 port for Redis here https://github.com/MSOpenTech/redis.If it still doesn't work after that then update your question with the new error you see.I had this issue in Ubuntu 18.04I installed redis in my local system, got solved.Ref solution: https://rapidsol.blogspot.com/2018/10/php-fatal-error-uncaught.htmlIt is showing your server is not accepting connections from outside. You need to provide ip of your redis server.if problem still come then try below steps.So you need to edit :

$sudo vi /usr/local/etc/redis.confand find the line  bind 127.0.0.1 ::1

and change it to  #bind 127.0.0.1 ::1

and then find line protected-mode yes

and then change it to protected-mode noand then restart the redis server

In Laravel, how can I get *only* POST parameters?

NeuronQ

[In Laravel, how can I get *only* POST parameters?](https://stackoverflow.com/questions/27366243/in-laravel-how-can-i-get-only-post-parameters)

I know that one can use $request->get('my_param') or Input::get('my_param') to get a POST or GET request parameter in Laravel (I'm toying with v5/dev version now, but it's the same for 4.2).But how can I make sure that my my_param came via a POST parameter and was not just from a ?my_param=42 appended to the URL? (besides reverting to the ol' $_POST and $_GET superglobals and throwing testability out the window)(Note: I also know that the Request::get method will give me the POST param for a POST request, if both a POST an URL/GET param with the same name exist, but... but if the param land in via the url query string instead, I want a Laravel-idiomatic way to know this)

2014-12-08 20:24:09Z

I know that one can use $request->get('my_param') or Input::get('my_param') to get a POST or GET request parameter in Laravel (I'm toying with v5/dev version now, but it's the same for 4.2).But how can I make sure that my my_param came via a POST parameter and was not just from a ?my_param=42 appended to the URL? (besides reverting to the ol' $_POST and $_GET superglobals and throwing testability out the window)(Note: I also know that the Request::get method will give me the POST param for a POST request, if both a POST an URL/GET param with the same name exist, but... but if the param land in via the url query string instead, I want a Laravel-idiomatic way to know this)In the class Illuminate\Http\Request (or actually the Symphony class it extends from Symfony\Component\HttpFoundation\Request) there are two class variables that store request parameters.public $query - for GET parameterspublic $request - for POST parametersBoth are an instance of Symfony\Component\HttpFoundation\ParameterBag which implements a get method.Here's what you can do (although it's not very pretty)Why trying to complicate things when you can do easily what you need :

How to generate「screenshot」of html div with external images?

cytsunny

[How to generate「screenshot」of html div with external images?](https://stackoverflow.com/questions/41254805/how-to-generate-screenshot-of-html-div-with-external-images)

I have a HTML div with external images. (The following is an example, but in the actual case I am using Amazon S3, so downloading and storing the image on the same server is not an option) Currently I am using html2canvas to convert the div to image. However, the external image is always replaced by a blank space.The code I use to capture the image:Edited: jsfiddle: https://jsfiddle.net/0y2zxxL8/3/I may use other library. I may also do that in backend. (I am using PHP + laravel 5 for backend) Is there a way I can generate a "screenshot" of the HTML div with external images?Update The current answer are working after editing. Yet, for my actual use, there will be multiple image with their position set by the user by drag and drop. I can still get the position, but it would be better for me if it is possible to not set the position specifically.

2016-12-21 03:50:03Z

I have a HTML div with external images. (The following is an example, but in the actual case I am using Amazon S3, so downloading and storing the image on the same server is not an option) Currently I am using html2canvas to convert the div to image. However, the external image is always replaced by a blank space.The code I use to capture the image:Edited: jsfiddle: https://jsfiddle.net/0y2zxxL8/3/I may use other library. I may also do that in backend. (I am using PHP + laravel 5 for backend) Is there a way I can generate a "screenshot" of the HTML div with external images?Update The current answer are working after editing. Yet, for my actual use, there will be multiple image with their position set by the user by drag and drop. I can still get the position, but it would be better for me if it is possible to not set the position specifically.Your JSFiddle given ReferenceError: Canvas2Image is not defined while hit on 'Save PNG' button. So check your code(not fiddle) for same error.UPDATE

See this JSFiddle example as reference. May this one will help you.UPDATE 2

I place some code into your one, check it out. Hope this will be your solution..!Working result with FF v44 and its working. Taken snap with JSFiddle code

UPDATE 3 (12/29/2016) JSFiddleAfter research, found that the problem is because we are only assigning the image source which is only pass message to the browser to retrieve the data. Further image element is may be not really accessible with the browser when click to draw canvas from it. We are just tell code to load it and it's done.Change code to solve OP's facing chrome issue like below:UPDATE 4   JSFiddle

Make image position dynamic based on OP requirement.You may try to  scan the image source for external urls and change them to your website and load them with php.Something likeimageproxy.phpnote: php script is very simple, image detection is not working 100%, this is just ti give you an idea. If you use some php image libs to load and get image type you can do this just with few lines of code. you may also try with "php readfile".onrendered is no longer working..i solved this problem by adding "allowTaint" option2018 solution:

Twilio lookup API not working?

ReactingToAngularVues

[Twilio lookup API not working?](https://stackoverflow.com/questions/31354989/twilio-lookup-api-not-working)

I'm trying to use Twilio's Lookup API to get certain properties of a mobile number via PHP... with very little success:Note that this is the example code present within their 'Getting Started' page here. By taking a look at $number in the debugger, I can confirm it is returning something:The highlighted property of the object is simply recursive with no new information.Attempting to evaluate $number->phone_number returns null. I have tried this with perhaps half a dozen completely valid numbers now and this is the only response I get. Attempting to json_encode($number) returns false. I have no idea why this is not working, but it'd be helpful if I could know what I'm doing wrong. 

2015-07-11 08:13:04Z

I'm trying to use Twilio's Lookup API to get certain properties of a mobile number via PHP... with very little success:Note that this is the example code present within their 'Getting Started' page here. By taking a look at $number in the debugger, I can confirm it is returning something:The highlighted property of the object is simply recursive with no new information.Attempting to evaluate $number->phone_number returns null. I have tried this with perhaps half a dozen completely valid numbers now and this is the only response I get. Attempting to json_encode($number) returns false. I have no idea why this is not working, but it'd be helpful if I could know what I'm doing wrong. I'm just gonna go ahead and assume the phone numbers you've tried are neither from the US, nor in international format.From Twilio's Lookups Quickstart Tutorial:So your lookup should probably look like:If the phone numbers are from the US, in international format, or if the above still does not work, try whether the lookup succeeds on Twilio's web interface (you'll need the international prefix there).If it does, your software library might be broken or your Twilio account might have incorrect/broken access rights.If the web lookup fails as well, you should contact Twilio and report the issue.I would have been also not successful with their code defined so i used CURL to grab their API methods and it worked like a charm for me, you can try following code to get you needIt will return you few parameters (country_code, national_format, carrier)Now 9-6-2016 and they still haven't fixed their PHP library...None the less here is what worked for me. If you want more information like caller name etc you have to enable this in your twilio dashboard first.

How do I namespace a model in Laravel so as not to clash with an existing class?

Dwight

[How do I namespace a model in Laravel so as not to clash with an existing class?](https://stackoverflow.com/questions/16116378/how-do-i-namespace-a-model-in-laravel-so-as-not-to-clash-with-an-existing-class)

In Laravel 4 I want to use a model that represents an Event coming from my database. Thus, in app/models I have my Event model that extends Eloquent.However, Laravel 4 already has an Event class which is used to manage events within the application lifecycle. What I want to know is, how can I properly namespace my Event model and access it in a way that will not clash with the existing Event class.

2013-04-20 03:54:34Z

In Laravel 4 I want to use a model that represents an Event coming from my database. Thus, in app/models I have my Event model that extends Eloquent.However, Laravel 4 already has an Event class which is used to manage events within the application lifecycle. What I want to know is, how can I properly namespace my Event model and access it in a way that will not clash with the existing Event class.You just need to apply a namespace to it as you normally would. So, for example.You should then correctly setup your composer.json so that it loads your models. You could use classmap or psr-0 for this, depending on whether or not you're following PSR-0 with your directory structure.I'm pretty sure the models directory is already mapped.Edit

As mentioned in the comments you must run composer dump-autoload.As much i have research about using namespaces, because i want to use those inside the PHPDocumentar, its not possible to add twice the namespaces, as laravel already adds those for you, if we understand the basic problem, why we use namespaces1 - many libraries uses same class name, so we use namespaces to differentiate that.2 - if you want to use namespaces then you should be out of the scope of the app, means is the vendor folder for you to this kind of stuff.Enjoy

Download a file in Laravel using a URL to external resource

lesssugar

[Download a file in Laravel using a URL to external resource](https://stackoverflow.com/questions/38791635/download-a-file-in-laravel-using-a-url-to-external-resource)

I'm keeping all uploads on a custom, external drive. The files are being stored via custom API. In Laravel 5.2, I can do this for a local file to download it:Unfortunately, when I pass a URL instead of a path, Laravel throws an error:(the URL is a dummy of course).Is there any way I can download the image.jpg file using Laravel's implementation or do I do this with plain PHP instead?

2016-08-05 14:25:59Z

I'm keeping all uploads on a custom, external drive. The files are being stored via custom API. In Laravel 5.2, I can do this for a local file to download it:Unfortunately, when I pass a URL instead of a path, Laravel throws an error:(the URL is a dummy of course).Is there any way I can download the image.jpg file using Laravel's implementation or do I do this with plain PHP instead?There's no magic, you should download external image using copy() function, then send it to user in the response: TL;DR

Use the streamDownload response if you're using 5.6 <=. Otherwise implement the function below.Original Answer

Very similar to the "download" response, Laravel has a "stream" response which can be used to do this. Looking at the API, both of the these functions are wrappers around Symfony's BinaryFileResponse and StreamedResponse classes. In the Symfony docs they have good examples of how to create a StreamedResponseBelow is my implementation using Laravel:Update 2018-01-17This has now been merged into Laravel 5.6 and has been added to the 5.6 docs. The streamDownload response can be called like this:Why not just use a simple redirect?As for 2019 this is all pretty easy. 2 lines of code to download to your server and 2 lines to upload to browser (if needed).Assume you want an HTML for google home page to get saved locally onto your server, and then return an HTTP response to initiate browser to download the file:Look up Laravel Storage facade documentation for details on disk configuration and put method and Response with file download documentaion for returning file with an HTTP reponse.try this script:  If you do not want end user can see main_url in header try this:You could pull down the content of the original file, work out its mime type and then craft your own response giving the right headers.I do this myself using a PDF library, but you could modify to use file_get_contents() to pull down the remote assets:You need to change $pdf to be the data of the file, Content-Type to contain the mimetype of the file that the data is and Content-Disposition is the filename you want it to appear as.Not sure whether this will work, mine simply makes the browser popup with a PDF download so I'm not sure whether it'll work for embedding CDN files... Worth a try though.

How to select year and month from the created_at attributes of database table in laravel 5.1?

Pawan Dongol

[How to select year and month from the created_at attributes of database table in laravel 5.1?](https://stackoverflow.com/questions/32840698/how-to-select-year-and-month-from-the-created-at-attributes-of-database-table-in)

My problem is that I want to get data form the database table from the created_at attributes as per year and month only. The code I have tried is:

2015-09-29 09:40:31Z

My problem is that I want to get data form the database table from the created_at attributes as per year and month only. The code I have tried is:There are date helpers available in the query builder:If you want to get the year and month from a single instance of Mjblog you can access them like this:Read more about Carbon\Carbon getters documentation.

FatalErrorException in Inflector.php line 265: syntax error, unexpected ':', expecting ';' or '{'

Abdul Qadir

[FatalErrorException in Inflector.php line 265: syntax error, unexpected ':', expecting ';' or '{'](https://stackoverflow.com/questions/48380892/fatalerrorexception-in-inflector-php-line-265-syntax-error-unexpected-exp)

I went to update composer using after update having the following error:Please assistThanks in advanceUsing Laravel Framework version 5.2.45here is the composer codePlease see the function of inflector.php where error occures

2018-01-22 11:47:21Z

I went to update composer using after update having the following error:Please assistThanks in advanceUsing Laravel Framework version 5.2.45here is the composer codePlease see the function of inflector.php where error occuresIt's a PHP version issue, update to PHP 7.0 and doctrine/inflector will work properly because doctrine/inflector 1.20 and above require PHP 7. But if you want to stay at your current PHP version, you can downgrade the doctrine/inflector version by running the following commands:doctrine/inflector:1.1.0 supports PHP 5.6 & above. If you have another version of php, you can refer to this linkI'm working on:My table name is like this: "test_meetings"I solved the error specifying in testMeeting.php Model the table name:It's really obvious when you search for this file name and then start comparing package versions.You are requiring laravelcollective/html at any version, so, for now, the latest version is 5.5.x. This package in its turn requires "doctrine/inflector": "~1.1",, so any version below 2.0, which is currently 1.3.0 and requires PHP 7.0 or higher.If you look at the source of the latest inflector.php, you will see a return type is set on line 265, which is only supported in PHP 7.0 and up.You are using PHP 5.6.24, so this code won't work on your system.The simple way to fix your error is to use the laravelcollective/html version corresponding to your Laravel version. Which should probably be 5.2.*.In case this helps anyone. I had a similar problem. My doctrine/inflector was expecting php>=7 for some reason (That's what was to found in the composer.json from doctrine/inflector). And this even though I had followed the instructions to install laravel 5.4. I ran rm -f Composer.lock and rm -R -f vendor and then did a composer install after vagrant ssh to the homestead VM, which was using php 5.6.8 (originally I had run composer from my MacBook terminal, which was using php 7)This cleared up the issues.afterTry this after you have run the composer update:

Laravel 4 workbench class not found

Ray

[Laravel 4 workbench class not found](https://stackoverflow.com/questions/18499393/laravel-4-workbench-class-not-found)

I'm trying to develop a package in laravel 4 - my first attempt at a package. 

I found a couple of tutorials which I've tried to follow:and and of course in the official documentation.I've followed the basic structure to create the framework. However on loading the app I get a class not found error. This relates directly to the serviceprovider I have placed in the app.php file.here's my entry in the providers array:My folder structure is:My service provider has the following entries:I've double checked to spelling and ran a composer dump-autoload both from the root of the project and the root of the package.I've run out of ideas for solving the class not found  any ideas where I've gone wrong?The line producing the error is this one:Any help appreciatedThanksUpdate:

I ran a composer update as suggested in the workbench/package folder with a response nothing to update. I then ran composer at the root of the project and an error was produced: I probably posted the wrong error line earlier. The full exception response is:THe error extract:which I assume relates to the service provider loader not finding the CalendarServiceProvider?

2013-08-28 22:34:04Z

I'm trying to develop a package in laravel 4 - my first attempt at a package. 

I found a couple of tutorials which I've tried to follow:and and of course in the official documentation.I've followed the basic structure to create the framework. However on loading the app I get a class not found error. This relates directly to the serviceprovider I have placed in the app.php file.here's my entry in the providers array:My folder structure is:My service provider has the following entries:I've double checked to spelling and ran a composer dump-autoload both from the root of the project and the root of the package.I've run out of ideas for solving the class not found  any ideas where I've gone wrong?The line producing the error is this one:Any help appreciatedThanksUpdate:

I ran a composer update as suggested in the workbench/package folder with a response nothing to update. I then ran composer at the root of the project and an error was produced: I probably posted the wrong error line earlier. The full exception response is:THe error extract:which I assume relates to the service provider loader not finding the CalendarServiceProvider?I found that running composer install from within the workbench/[vendor]/[package] folder solved the problem.I encountered the same error, so I went deeper on its flow to knew what happens.So dissecting a little bit basically, in the bootstrap phase, when bootstrap/autoload.php is loaded it runs at the end:This requires EVERY workbench/vendor/package/**/**/**/autoload.php he found (by using Symfony Finder Component)Successively in bootstrap/start.php it gets the 'providers' defined in config/app.php and try to load each of them:and then in ProviderRepository.phpso we'll end up with:where it tried to create an instance of a class isn't really autoloaded. And so that's why the exception thrown!He's absolutely right because this create the autoload vendor dir and files, and everything works as we expect it to because it finds the autoload files:In addition to @ilpaijin's and @Andrew Holt's answer, there sometimes comes the need (when there's a new version of Laravel) to run composer update within the workbench/vendor/package folder.Also, as noted here, the composer.json within the package must require the same version of illuminate/support as the one required of laravel/framework in the project root's composer.json.Thanks to @biscii note that one should use:instead of 

Laravel Production issue - Updating composer with Laravel 4.1.x

olleh

[Laravel Production issue - Updating composer with Laravel 4.1.x](https://stackoverflow.com/questions/30868608/laravel-production-issue-updating-composer-with-laravel-4-1-x)

I haven't encountered any issue in deploying my laravel project until now. I've been deploying for like almost a year already for this project. But some new bug came up.First of all. 

I can't run composer update, cause it says this error.So what I did is update my Composer library.This is my current version.I updated composer.But I encounter a new problem once I ran composer updateNow I am leaning towards uninstalling my composer, and creating a new fresh copy.

2015-06-16 13:12:41Z

I haven't encountered any issue in deploying my laravel project until now. I've been deploying for like almost a year already for this project. But some new bug came up.First of all. 

I can't run composer update, cause it says this error.So what I did is update my Composer library.This is my current version.I updated composer.But I encounter a new problem once I ran composer updateNow I am leaning towards uninstalling my composer, and creating a new fresh copy.fixed this for me on Ubuntu with PHP 5.6. (Its nothing to do with Laravel BTW - I'm not using that framework at all.)I fixed it by installing the missing dependencies.had the same problem, performed the composer installation command in the terminal and problem solvedthe composer via yum install command:You can install phpunit, after that, if there are problems, execute the command: sudo a2dismod php5 .If you still have questions, to analyze your problem by looking at the system log.

array_map and pass 2 arguments to the mapped function - array_map(): Argument #3 should be an array

Latheesan

[array_map and pass 2 arguments to the mapped function - array_map(): Argument #3 should be an array](https://stackoverflow.com/questions/27599767/array-map-and-pass-2-arguments-to-the-mapped-function-array-map-argument-3)

I have an abstract class that looks like this:Then I have the following class that implements it:When this code runs, I get the error: How do you pass 2 or more arguments when you call array_map function within a class? I checked the PHP Documentation and it looks like this is allowed, but it isn't working on my Larave 4.2 project.Any ideas?

2014-12-22 09:22:35Z

I have an abstract class that looks like this:Then I have the following class that implements it:When this code runs, I get the error: How do you pass 2 or more arguments when you call array_map function within a class? I checked the PHP Documentation and it looks like this is allowed, but it isn't working on my Larave 4.2 project.Any ideas?Please always read docs:http://php.net/manual/en/function.array-map.phpand yet you pass bool $format as argumentI would create anonymous function with use() syntaxYou can't use array_map to pass hard-coded values to a callback function (what is commonly referred to as currying or partially-applied functions in functional languages). What array_map takes is a variable amount of arrays, all of which should have the same amount of elements. The element at the current index of each array is passed to the callback as separate arguments. So, for instance, if you do this:You get this:Hopefully that explains the idea behind it - each array you pass in will have the element at the current position in the first array passed as the relevant parameter to the callback function.So, as I said, it's not to be used for passing 'static' values to the callback. However, you can do this yourself by defining an anonymous function on the fly. In your transformCollection method:Most answers show that an anonymous function with the use keyword is the typical way to pass additional arguments through to other callables.Most likely though, this particular situation would be better suited by a standard foreach loop over array_map, as it would potentially be more efficient and easier to read. This would also prevent your indexes from being renumbered, as well as work with Traversable and ArrayAccess items.If you really, really have your heart set on using array_map, anonymous functions don't work with your environment (i.e. pre PHP 5.3) and you need to pass $format through as the 2nd argument, then you will need to convert $format to an array with the same length as $items.EDIT:I realised recently that there was another option available since you're using an instance to transform your data. It involves storing $format to the instance, possibly using a setter, and overriding it if it is provided as an argument. This way it's accessible via the transform method using $this->format.This may not be applicable for laravel 4.2 // pre php 5.3 (as Shaun mentions) but might come in handy for some people who come across this question.So, that's a dynamic use, by using the call-method on the Closure-class that's underneath php's anonymous functions. If the callback is an array, it will bind the scope of the ->call to the first array-element, which should be the method's object.

Laravel Lumen Ensure JSON response

John Fonseka

[Laravel Lumen Ensure JSON response](https://stackoverflow.com/questions/37296654/laravel-lumen-ensure-json-response)

I am new to Laravel and to Lumen. I want to ensure I am always getting only a JSON object as output. How can I do this in Lumen?I can get a JSON response using response()->json($response);. But when an error happens, API giving me text/html errors. But I want only application/json responses.Thanks in advance.

2016-05-18 10:17:24Z

I am new to Laravel and to Lumen. I want to ensure I am always getting only a JSON object as output. How can I do this in Lumen?I can get a JSON response using response()->json($response);. But when an error happens, API giving me text/html errors. But I want only application/json responses.Thanks in advance.You'll need to adjust your exception handler (app/Exceptions/Handler.php) to return the response you want.This is a very basic example of what can be done.A more accurate solution based on @Wader's answer can be:As MTVS answer you could even use JsonResponse class to format your response, and use it as static member from within render method, not importing it in the Handler namespace like this:

Method orderBy does not exist in Laravel Eloquent?

Harrison

[Method orderBy does not exist in Laravel Eloquent?](https://stackoverflow.com/questions/37760963/method-orderby-does-not-exist-in-laravel-eloquent)

I have a piece of code like this:I got the following error:I guess orderBy need to follow Product:: directly, but I can't save $products = Product::, can I?Any suggestions? Thanks.

2016-06-11 07:04:41Z

I have a piece of code like this:I got the following error:I guess orderBy need to follow Product:: directly, but I can't save $products = Product::, can I?Any suggestions? Thanks.You're trying to use orderBy() method on Eloquent collection. Try to use sortByDesc() instead.Alternatively, you could change $products = Product::all(); to $products = new Product();. Then all your code will work as you expect.just use the one line code it will work fineIf you want to get the list of all data and grab it in descending order try this:You are first getting all() data and then trying to sort which is wrong. You have to fix this by removing and changing your code into something like this Hope you get idea to tweak your code.Your query is wrong.remove all from $products = Product::all() and then put get() at the end of your query.You can use this...use sortByDesc('id') or simple sortBy() inside use the variable through which you wanna sort like i add id

How to access the laravel .env variables inside javascript?

Stephan-v

[How to access the laravel .env variables inside javascript?](https://stackoverflow.com/questions/35683562/how-to-access-the-laravel-env-variables-inside-javascript)

I am currently using Algolia for my search engine inside a Laravel application, so whenever a record is created it is also sent to the Agolia database. Of course I want to separate my data in the Algolia database with a testset for local development and a production set for the live website. I have defined which indices of my Algolia database are being used in a JavaScript file.Now I am wondering how do I react accordingly to my APP_ENV variable to change it depending on my current environment? Obviously I need to put stuff into an if statement in my JavaScript but how do I make my javascript access the .env variables properly?Hopefully somebody can help me out.Cheers.

2016-02-28 14:13:42Z

I am currently using Algolia for my search engine inside a Laravel application, so whenever a record is created it is also sent to the Agolia database. Of course I want to separate my data in the Algolia database with a testset for local development and a production set for the live website. I have defined which indices of my Algolia database are being used in a JavaScript file.Now I am wondering how do I react accordingly to my APP_ENV variable to change it depending on my current environment? Obviously I need to put stuff into an if statement in my JavaScript but how do I make my javascript access the .env variables properly?Hopefully somebody can help me out.Cheers.You can just echo out the env variable as a javascript string in your view:And your .env file would look like this:NAME=AlexAs the documentation suggest it: you can now easily use env variables by prefixing a key in your .env file with MIX_.MIX_SENTRY_DSN_PUBLIC=http://example.comAfter the variable has been defined in your .env file, you may access via the process.env object.process.env.MIX_SENTRY_DSN_PUBLICIf accessing the env vars from outside of the main js file. You can do the following:then:Requiring mix and the dotenv config gives you access. :)There are a lot of ways.One of the best is to pass data from Controller to the view:or like this:Or you could use Sessions:Of course you can create dedicated route and get it with Ajax, but I don't think it's a good way to do this in real life web application.A cleaner solution is to use the laracasts/utilities package to send your variables to your file.Install it with the composer require laracasts/utilities command.Then add use JavaScript; at the top of your controller.And finally send your variable this way :  JavaScript::put([ 'foo' => $bar ]);.

Laravel Carbon See if date is in the past

Packy

[Laravel Carbon See if date is in the past](https://stackoverflow.com/questions/47059484/laravel-carbon-see-if-date-is-in-the-past)

I am very confused by this, maybe its something simple I am not seeing. If I want to see if a date is in the past of today I should be able to do something like this? if I dump out the dates its $league->date_start is a protected date so its a carbon instance But this doesnt work, if I switch it to $league->date_start >= Carbon::now() it works and wont let me join. I know the "league" start date is in the past so shouldnt it be $league->date_start <= Carbon::now()?????

2017-11-01 16:31:24Z

I am very confused by this, maybe its something simple I am not seeing. If I want to see if a date is in the past of today I should be able to do something like this? if I dump out the dates its $league->date_start is a protected date so its a carbon instance But this doesnt work, if I switch it to $league->date_start >= Carbon::now() it works and wont let me join. I know the "league" start date is in the past so shouldnt it be $league->date_start <= Carbon::now()?????There's built-in Carbon method isPast so you can use:to determine if date is in past or notCheck the section「Comparison」on carbon docs. You should call $first->lte($second) to compare two carbon instances.Try using if ($league->date_start->diffInSeconds() >= 0). The method diffInSeconds returns the difference between the current time and your carbon instance.Here's an example of an output from tinker -

Combining AND/OR eloquent query in Laravel

SUB0DH

[Combining AND/OR eloquent query in Laravel](https://stackoverflow.com/questions/15653216/combining-and-or-eloquent-query-in-laravel)

How can I write following or similar kind of queries using Eloquent?SELECT * FROM a_table WHERE (a LIKE %keyword% OR b LIKE %keyword%) AND c = 1 AND d = 5I couldn't combine AND/OR in the way I wanted by chaining where & or_where functions.

2013-03-27 06:46:57Z

How can I write following or similar kind of queries using Eloquent?SELECT * FROM a_table WHERE (a LIKE %keyword% OR b LIKE %keyword%) AND c = 1 AND d = 5I couldn't combine AND/OR in the way I wanted by chaining where & or_where functions.You can nest where clauses : http://laravel.com/docs/database/fluent#nested-whereThis should produce : SELECT * FROM models WHERE (a LIKE %keyword% OR b LIKE %keyword%) AND c = 1For a more accurate answer to the example:Note: This is Laravel 3 syntax, use camelCase orWhere() for Laravel 4In Laravel 5.1+ this will also do the job and looks cleaner:You can use DB::raw() in the first where() to put in the like/or statement.

Laravel - delete whole collection

Marco

[Laravel - delete whole collection](https://stackoverflow.com/questions/38120305/laravel-delete-whole-collection)

I have images for articles, and when I am updating article I would like to check if the images are the same, if not I would like to delete them but if it is possible I would like to delete the whole collection without another query, something like what I have in the code below $images->delete();.

This is my function:

2016-06-30 10:21:06Z

I have images for articles, and when I am updating article I would like to check if the images are the same, if not I would like to delete them but if it is possible I would like to delete the whole collection without another query, something like what I have in the code below $images->delete();.

This is my function:You just can't delete from database without making a query. You will have to make new request like this: It's just one simple query, so there shouldn't be any performance penalty.If we are talking about collection with 100's of items, you can optimize the query like this:If you have your Models linked, you can.Class Exercise.php:and Class Lecture.php:Then you can in your controller simply do:(Imagine that your Article == my Lecture, and your Media == my Exerises)Of course, at first you have to set properly foreign keys in your DB and link your Models that way.

composite-unique-key-validation - laravel

sumit

[composite-unique-key-validation - laravel](https://stackoverflow.com/questions/29093061/composite-unique-key-validation-laravel)

seems it's not possible with built-in validators, how I should implement this feature in the model?above will prevent duplicacy of user_id and service_id  independently which is not my requirementit will reject because 1  is duplicate but it should be accepted as i want composite unique key

2015-03-17 06:59:03Z

seems it's not possible with built-in validators, how I should implement this feature in the model?above will prevent duplicacy of user_id and service_id  independently which is not my requirementit will reject because 1  is duplicate but it should be accepted as i want composite unique keyComposite unique field validation is provided out-of-the-box in 5.0+. I can't speak for earlier versions.You can essentially specify a where clause for when your unique validation rule applies. E.g.This rule says that term should be unique on the terms table but only where the taxonomy is equal to "category".For example, it will prevent a "news" category being duplicated but I can still have a "news" tag.I don't know your schema but in your case it'd be something like this:This is not possible out of the box in Laravel. You would either have to write a custom validator or use a package for that.Here is one that should do what you need:

- https://github.com/felixkiss/uniquewith-validatorWith this package, your rules could look like the following:It works for both Laravel 4 and 5.My solution Laravel 5.3 and 5.4Note: Without model bindingStoreUpdateWith the help of this link , I am able to achieve composite validation from out of the box laravel 5.3. I knew it is old question and answered already. In my case vendor and client combination is unique. My sample code is below

Laravel 5.2 Missing required parameters for [Route: user.profile] [URI: user/{nickname}/profile]

SCRATK

[Laravel 5.2 Missing required parameters for [Route: user.profile] [URI: user/{nickname}/profile]](https://stackoverflow.com/questions/35259948/laravel-5-2-missing-required-parameters-for-route-user-profile-uri-user-ni)

I keep getting this error When ever any page loads and I'm logged in.Here is what my nav looks likeThe problem I'm having is that the {{ route('user.profile') }} is not working??When i hit the link is www.mydomain.com/User/SCRATK/profile is works fine but the page wont load becuase of this error??This is my routes file

2016-02-07 22:29:47Z

I keep getting this error When ever any page loads and I'm logged in.Here is what my nav looks likeThe problem I'm having is that the {{ route('user.profile') }} is not working??When i hit the link is www.mydomain.com/User/SCRATK/profile is works fine but the page wont load becuase of this error??This is my routes fileYou have to pass the route parameters to the route method, for example:It's because, both routes have a {nickname} in the route declaration. I've used $nickname for example but make sure you change the $nickname to appropriate value/variable, for example, it could be something like the following: My Solution in laravel 5.2My Routes File (under middleware)

Using Laravel Socialite to login to facebook

Namit

[Using Laravel Socialite to login to facebook](https://stackoverflow.com/questions/30590243/using-laravel-socialite-to-login-to-facebook)

I am new to Laravel however and I am following the tutorial on http://www.codeanchor.net/blog/complete-laravel-socialite-tutorial/, to login a user through Facebook into my application. However, almost everywhere I find a tutorial using either Github or Twitter for the Socialite Plugin provided in Laravel.My problem is that on following everything in the tutorial, as I click on the "Login to Facebook" button, it throws an "Invalid Argument Exception" with No Socialite driver was specified.".Another stack overflow question seemed to narrow things down: 

https://stackoverflow.com/questions/29673898/laravel-socialite-invalidargumentexception-in-socialitemanager-php-line-138-nStating that the problem is in the config/services.phpNow, i have the app_id and app_secret. However, the redirect link seems to be confusing as I can't find it on Facebook either. I am aware that this is where my app should go to Facebook for login, however, unsure of what it should be.Does anyone have any idea on this.

2015-06-02 07:45:00Z

I am new to Laravel however and I am following the tutorial on http://www.codeanchor.net/blog/complete-laravel-socialite-tutorial/, to login a user through Facebook into my application. However, almost everywhere I find a tutorial using either Github or Twitter for the Socialite Plugin provided in Laravel.My problem is that on following everything in the tutorial, as I click on the "Login to Facebook" button, it throws an "Invalid Argument Exception" with No Socialite driver was specified.".Another stack overflow question seemed to narrow things down: 

https://stackoverflow.com/questions/29673898/laravel-socialite-invalidargumentexception-in-socialitemanager-php-line-138-nStating that the problem is in the config/services.phpNow, i have the app_id and app_secret. However, the redirect link seems to be confusing as I can't find it on Facebook either. I am aware that this is where my app should go to Facebook for login, however, unsure of what it should be.Does anyone have any idea on this.In your composer.json add- "laravel/socialite": "~2.0",the run composer updateIn config/services.php add:You need to create two routes, mine are like these:You also need to create controller  for the routes above like so:and finally add Site URL to your Facebook App like so:It's little bit tricky for something that looks/should be easy, but anyway this is how i make things works for me.you can find those instructions and more details in socialite docsin config/services.php add in .env file add in routes/web.php addin App\Http\Controllers\Auth add new controller FacebookController.phpgo to https://developers.facebook.com/apps and create new app (if you don't have one already)and make sur your app settings are like below in those screen shots:If you are developing in your local machine, you have to use tools like ngrok that provide a secure link to your localhost.In the facebook login settings change https://www.example.com with the url provided by ngrok something like https://8b0215bc.ngrok.io.It is the only way that worked for me while developing in my local machine.Create a provider under your config/services.php filenow you can create a controller with following code and this is your route

Pagination for search results laravel 5.3

Casper Spruit

[Pagination for search results laravel 5.3](https://stackoverflow.com/questions/39326206/pagination-for-search-results-laravel-5-3)

I have just started with Laravel and I am trying to make a search function with proper pagination. The function works for page one but on page two it doesn't. I think it's not giving the results to the next page but I can't seem to find an answer.this is my search function inside IndexController:this is my route:this is the URL of page two:this is how I show my pagination:the error:Get error on request.Route:Error:I hope my question is clear and in the right format. Thank you in advance (sorry for my bad English)Answer:I ended up using the answer of this post in combination with some help of this postI used a post function for the initial search and a get function for the following pages. This was possible because I'm now giving my search to the URL.EDIT:

2016-09-05 08:04:20Z

I have just started with Laravel and I am trying to make a search function with proper pagination. The function works for page one but on page two it doesn't. I think it's not giving the results to the next page but I can't seem to find an answer.this is my search function inside IndexController:this is my route:this is the URL of page two:this is how I show my pagination:the error:Get error on request.Route:Error:I hope my question is clear and in the right format. Thank you in advance (sorry for my bad English)Answer:I ended up using the answer of this post in combination with some help of this postI used a post function for the initial search and a get function for the following pages. This was possible because I'm now giving my search to the URL.EDIT:If you want to apply filters to the next page you should add them to your paginator like this:And change your route from post to get:View:I assume you want to change pages with urls like this search/1, search/2? First of all your route should be probably Route::post('search/{page?}').I'm not sure if only this change will work, but if it does not, you have to resolve page like thisand in your view page make your route to get methodthis will be done, thanks,a quick way in view (Lavarel 5.7)  in my case, i've laravel 5.7 installed.and my view files codes arefor per_page select dropdown and search area

  and my pagination generator codeIf you are using search form with GET method then use something like these to preserve pagination withing search results.For pagination, you should create a simple form:Pagination methods are here:In your view file where you display pagination...appends keeps the query string value except "page".use any in route Instead post

Route::any('search', 'IndexController@search');

Redirect::route with parameter in URL in Laravel 5

Bellots

[Redirect::route with parameter in URL in Laravel 5](https://stackoverflow.com/questions/30019627/redirectroute-with-parameter-in-url-in-laravel-5)

I'm developing a Laravel 5 app, I have this route Route::get('states/{id}/regions', ['as' => 'regions', 'uses' => 'RegionController@index']);

In my controller, after I make a post call correctly, I want to redirect to that view, with this command:The problem is that I don't know how can I pass {id} parameter, which should be in my URL.Thank you.

2015-05-03 21:29:34Z

I'm developing a Laravel 5 app, I have this route Route::get('states/{id}/regions', ['as' => 'regions', 'uses' => 'RegionController@index']);

In my controller, after I make a post call correctly, I want to redirect to that view, with this command:The problem is that I don't know how can I pass {id} parameter, which should be in my URL.Thank you.You can pass the route parameters as second argument to route():If it's only one you also don't need to write it as array:In case your route has more parameters, or if it has only one, but you want to clearly specify which parameter has each value (for readability purposes), you can always do this:You could still do it like this: In cases where you have multiple parameters, you can pass the parameters as array, for example, say you had to pass the capital of a particular region in you route, your route could look something like this:and you can then redirect using:You can pass {id} parameter with redirection like that If the router contains like this :and in the controller redirection can be done like thisYou can use the following ORThere are several ways to redirect this URL in laravel:

Laravel 5.5 API resources for collections (standalone data)

Dorin Niscu

[Laravel 5.5 API resources for collections (standalone data)](https://stackoverflow.com/questions/46388205/laravel-5-5-api-resources-for-collections-standalone-data)

I was wondering if it is possible to define different data for item resource and collection resource. For collection I only want to send ['id', 'title', 'slug'] but the item resource will contain extra details ['id', 'title', 'slug', 'user', etc.]I want to achieve something like:PageResourceCollection will not work as expected because it uses PageResource so it needs I could duplicate the resource into PageFullResource / PageListResource and PageFullResourceCollection / PageListResourceCollection but I am trying to find a better way to achieve the same result.

2017-09-24 08:39:06Z

I was wondering if it is possible to define different data for item resource and collection resource. For collection I only want to send ['id', 'title', 'slug'] but the item resource will contain extra details ['id', 'title', 'slug', 'user', etc.]I want to achieve something like:PageResourceCollection will not work as expected because it uses PageResource so it needs I could duplicate the resource into PageFullResource / PageListResource and PageFullResourceCollection / PageListResourceCollection but I am trying to find a better way to achieve the same result.The Resource class has a collection method on it. You can return that as the parameter input to your ResourceCollection, and then specify your transformations on the collection.Controller:Resources:If you want the response fields to have the same value in the Resource and Collection, you can reuse the Resource inside the CollectionPersonResource.phpPersonCollection.phpThe accepted answer works, if you are not interested in using links and meta data. If you want, simply return:in your controller. You should also look to eager load other dependent relationships before passing over to the resource collection.

Laravel route pass variable to controller

imperium2335

[Laravel route pass variable to controller](https://stackoverflow.com/questions/26844484/laravel-route-pass-variable-to-controller)

How do I pass a hard coded variable to a controller?My route is:I want to do something like:But that doesn't work.How can this be done?Sorry if I have not explained well.I wish to simply hardcode (set in stone by me) the type_id for certain routes like so:My ProductsController for reference:

2014-11-10 13:03:11Z

How do I pass a hard coded variable to a controller?My route is:I want to do something like:But that doesn't work.How can this be done?Sorry if I have not explained well.I wish to simply hardcode (set in stone by me) the type_id for certain routes like so:My ProductsController for reference:You can use a closure for your route and then call the controller action:However, a nicer way would be to use a where condition and then do the type-to-id conversion in the controller. You will lose the direct alias though and would have to pass in the product as parameter when generating the URL.I have used this to pass values to the controller...route:in controller:if want dynamic :hope this helps...I feel like the tidiest way to do this is probably with route constraints:It has some redundancy, but if you want to do it purely from your routes, I'd go with this.For making SEO-friendly names though, you could use Sluggable to generate a unique slug for each product, then create the following route:And this filter:Here is how you actually do it without messing up the url:Define Route:Now in the controller, inside function __construct(Request $request):

How to Disable Selected Middleware in Laravel Tests

surfer190

[How to Disable Selected Middleware in Laravel Tests](https://stackoverflow.com/questions/34357350/how-to-disable-selected-middleware-in-laravel-tests)

So it is common that errors from Authentication and CSRF arise when running phpunit.So in the TestCase we use:use WithoutMiddleware;The problem with this is that when forms fail, it usually comes back with a Flash Message and Old Input. We have disabled all middleware so we have no access to Input::old('username'); or the flash message.Furthermore our tests of this failed form post returns:Is there a way to enable the Session Middleware and disable everything else.

2015-12-18 13:58:54Z

So it is common that errors from Authentication and CSRF arise when running phpunit.So in the TestCase we use:use WithoutMiddleware;The problem with this is that when forms fail, it usually comes back with a Flash Message and Old Input. We have disabled all middleware so we have no access to Input::old('username'); or the flash message.Furthermore our tests of this failed form post returns:Is there a way to enable the Session Middleware and disable everything else.The best way I have found to do this isn't by using the WithoutMiddleware trait but by modifying the middleware you want to disable. For example, if you want to disable the VerifyCsrfToken middleware functionality in your tests you can do the following.Inside app/Http/Middleware/VerifyCsrfToken.php, add a handle method that checks the APP_ENV for testing.This will override the handle method inside of Illuminate\Foundation\Http\Middleware\VerifyCsrfToken, disabling the functionality entirely.As of Laravel 5.5, the withoutMiddleware() method allows you to specify the middleware to disable, instead of disabling them all. So, instead of modifying all of your middleware to add env checks, you can just do this in your test:If you're on Laravel < 5.5, you can implement the same functionality by adding the updated method to your base TestCase class to override the functionality from the framework TestCase.PHP >= 7If you're on PHP7+, add the following to your TestCase class, and you'll be able to use the same method call mentioned above. This functionality uses an anonymous class, which was introduced in PHP7.PHP < 7If you're on PHP < 7, you'll have to create an actual class file, and inject that into the container instead of the anonymous class.Create this class somewhere:Override the withoutMiddleware() method in your TestCase and use your FakeMiddleware class:You can use trait in test:Laravel >= 5.7

Laravel: How can i change the default Auth Password field name

D.Intziadis

[Laravel: How can i change the default Auth Password field name](https://stackoverflow.com/questions/39374472/laravel-how-can-i-change-the-default-auth-password-field-name)

I'm currently working on my first laravel project and i'm facing a problem.If you have experience with laravel you probably know that by calling php artisan make:auth you will get a predefined mechanism that handles login and registration.This mechanism is set to understand a couple of commonly used words in order to automate the whole procedure.The problem that occurs in my case is that i'm using oracle db and it won't let me have a table column with the name of password because its a system keyword and it throws errors when trying to insert a user.So far, i've tried to change my password column to passwd and it worked in my registration form as expected. The User row was successfully inserted and my page was redirected to /home.

But when i try to logout and then relogin, i get this error telling me that my credentials are not correct.

As for my code, i've changed my RegisterController.php so that it takes username instead of emailThe User $fillableI'm guessing that Auth is trying to authenticate with email and not username or that Auth is searching for password and not passwd

2016-09-07 15:55:10Z

I'm currently working on my first laravel project and i'm facing a problem.If you have experience with laravel you probably know that by calling php artisan make:auth you will get a predefined mechanism that handles login and registration.This mechanism is set to understand a couple of commonly used words in order to automate the whole procedure.The problem that occurs in my case is that i'm using oracle db and it won't let me have a table column with the name of password because its a system keyword and it throws errors when trying to insert a user.So far, i've tried to change my password column to passwd and it worked in my registration form as expected. The User row was successfully inserted and my page was redirected to /home.

But when i try to logout and then relogin, i get this error telling me that my credentials are not correct.

As for my code, i've changed my RegisterController.php so that it takes username instead of emailThe User $fillableI'm guessing that Auth is trying to authenticate with email and not username or that Auth is searching for password and not passwdFor having username instead of email, you can overwrite username() in your LoginController.phpAnd for passwd instead of password, you can do define an accessor in your App\User.phplogin.blade.php : Replace email input with username but do not change the name of the input for password.In the app/Http/Controllers/Auth/LoginController override the default class by adding:Don't forget to add use Illuminate\Http\Request;It could be you have to add this too to your LoginController. That should do it.Use this. It's work for me. So far I have changed the User.phpandAlso on LoginController.phpIn Laravel 5.7 beside above answer you must change EloquentUserProvider class. search in the file for 'password' word in lines (107,117, and 140) you found 'password' word and change it with new name, and this is all solustion.Edit :I change EloquentUserProvider class but if you think changing laravel class is a bad practice you can create custom provider and override the retrieveByCredentials and validateCredentials functions in the custom provider.If you are using the latest version. I am returning it like the following code below for a custom password field. On my end, I am using Lumen 6.x though it would apply to current version of Laravel also.In your AuthController.php (Located in app/http/Controllers/Auth)

Laravel 5 Multi-Tenancy App with separate databases - users have access to multiple installations

Nicko Brooko

[Laravel 5 Multi-Tenancy App with separate databases - users have access to multiple installations](https://stackoverflow.com/questions/28942145/laravel-5-multi-tenancy-app-with-separate-databases-users-have-access-to-multi)

Over the past couple of years I have developed a very customised PHP/MySQL application that is used for a number of clients. I have been creating a new database and new installation for each client up to this point.The first obvious problem here is keeping multiple installations up to date with any code changes; a second problem is that each installation has a large amount of users; and for most clients; some of these users are the same - and they have to have a number of seperate user accounts and urls to remember.I am moving the application over to Laravel 5 at the moment and looking into the best implementation for multi-tenancy; so looking for a little advice on the best implementation. I've used Laravel before but am by no means an expert.This is what I am thinking as far as setup.1 Master Database that holds tables for:Then a seperate database for each installation that contains all the information that is needed for, and submitted to, that installation.The ideal setup is that a user can go to a subdomain i.e installationname.appname.com; sign in with their master login details and automatically go to the required installation; OR go to appname.com, sign in and then select which installation to connect to.My questions are:I'm sure there's a lot of issues that I have not thought of; but if anyone has any links or guidance that may help that would be great. First time asking a question on SO but have found a huge amount of research help here in the past so thanks to the community! UPDATE - So I think I have a way to make this work now; using seperate databases as above; set in the models relating to tenant-specific database content.Then somewhere in a header file set the tenant_connection that is wanted based on a session variable which has been set on login/by subdomain.Assuming relationships will work across connections; I don't see why this would not work; just need to work out best place to set the tenant connection. 

2015-03-09 12:34:59Z

Over the past couple of years I have developed a very customised PHP/MySQL application that is used for a number of clients. I have been creating a new database and new installation for each client up to this point.The first obvious problem here is keeping multiple installations up to date with any code changes; a second problem is that each installation has a large amount of users; and for most clients; some of these users are the same - and they have to have a number of seperate user accounts and urls to remember.I am moving the application over to Laravel 5 at the moment and looking into the best implementation for multi-tenancy; so looking for a little advice on the best implementation. I've used Laravel before but am by no means an expert.This is what I am thinking as far as setup.1 Master Database that holds tables for:Then a seperate database for each installation that contains all the information that is needed for, and submitted to, that installation.The ideal setup is that a user can go to a subdomain i.e installationname.appname.com; sign in with their master login details and automatically go to the required installation; OR go to appname.com, sign in and then select which installation to connect to.My questions are:I'm sure there's a lot of issues that I have not thought of; but if anyone has any links or guidance that may help that would be great. First time asking a question on SO but have found a huge amount of research help here in the past so thanks to the community! UPDATE - So I think I have a way to make this work now; using seperate databases as above; set in the models relating to tenant-specific database content.Then somewhere in a header file set the tenant_connection that is wanted based on a session variable which has been set on login/by subdomain.Assuming relationships will work across connections; I don't see why this would not work; just need to work out best place to set the tenant connection. Ok so what I ended up doing was having all user info, names of installations and mappings of what users can access what installations in one database, and all tenant info in seperate databases.I then had two connections, mysql and mysql_tenant; where mysql_tenant database is not pre-set but dynamic.The User, Installations and mappings model use the mysql connection, all others use mysql_tenantCreated a code for each installation, and used this as the name of the tenant database; storing this code in the session.Used a middleware MultiTenant, to control the switching between installations using these key lines:There's a lot more to it for building the method to switch etc, but this is the gist.It is difficult to answer most of your question - as it is specific to your application and opinion based.But the one bit I can answer is different models can have different database connections. So your user model uses the normal default connection - but your other models can use another connection:Then in your DB connection file - you would have something like this:Laravel 5 is advanced enough that you should be able to have simply one installation along with a strategic database, with well defined relations and keys. There is rarely ever a need for multiple databases.If you can be more specific about your requirements I can provide a more specific answer.

Persist Form Data Across Multiple Steps in Laravel

Jeemusu

[Persist Form Data Across Multiple Steps in Laravel](https://stackoverflow.com/questions/22371630/persist-form-data-across-multiple-steps-in-laravel)

When I've made multistep forms in the past I would generally store the form data in the session before returning it to the view, that way the data persists if the user refreshes the page or clicks the browser's native back buttons.Transferring my past logic to Laravel I built the following form consisting of three stages:[Input  ->  Confirm  ->  Success]The above works fine, however I am wondering if this is the best way to approach multi-step forms in Laravel?

2014-03-13 07:14:49Z

When I've made multistep forms in the past I would generally store the form data in the session before returning it to the view, that way the data persists if the user refreshes the page or clicks the browser's native back buttons.Transferring my past logic to Laravel I built the following form consisting of three stages:[Input  ->  Confirm  ->  Success]The above works fine, however I am wondering if this is the best way to approach multi-step forms in Laravel?When I have created multi-part forms, I have always done it in a way so that the user can always come back and finish the form later, by making each form persist what it has to the database.For instanceI would have the user create their authentication details at this step, create the user account (with password) here and also log the user in, redirecting to the dashboard. There I can do a check to see if the user has a profile and if they don't, redirect them to the profile creation form.Because we have an authenticated user, the profile creation form can save its data to the currently logged in user. Subsequent sections follow the same process but check the existence of the previous step.Your question seems to be about confirming whether a user wishes to create an account. What I would do in your situation would be, on the form you created to confirm the user account, I would keep the user's data in hidden input fields.Although displaying the user's chosen password back to them on this page seems to be a bit superfluous when you ask them to confirm their password on the previous page, plus some users might question why their password is being shown in plaintext on the screen, especially if they are accessing the site from a public computer.The third option I would suggest would be to create the user account and soft-delete it (Laravel 4.2 Docs / Laravel 5 Docs), returning the user's account number to the new form:then undo the soft-delete when the user confirms their account. This has the added bonus that you could track people trying to sign up multiple times for an account and not completing the process and see if there's a problem with your UX.Of course, you could also still do it the way you always have with a session, all I have tried to do here is show you some other ways you can approach it, as with everything to do with the best way of doing something, this is a highly opinionated subject and is likely to get many opposing views on how it should be done. The best way to do it is the way that works best for you and your users... mainly your users.There are two ways to do it (that i can think of). I prefer second one.Adding "forget me" action would be nice (especially if form requires more private data).Why getCreate() has Session::forget()? If someone goes back to change something and accidently leaves your site his data will be lost.1st) Create a custom hidden field in the form containing a random md5 character set to submit it with the form... (it can be the timestamp, the user ip address, and country concatenated together as 3 md5 strings separated by whatever character , or #, so it can be working as a token of the form)2nd) pass the hidden field into your controller and validate it after getting the user input from the form by generating the same values in your controller, encrypting these values as md5 too, then concatenate them all together, and compare the values that is coming from the user input form with the values you are generating in your controller.3rd) Put the values of the form in your controller in a session then regenerate the session id every visit to every view the user is going to visit.4th) update the timestamp in your session according the timestamp the user is visiting every page.Just because you know Laravel, does not mean you have to do everything in Laravel.Multi-step forms should never involve server-side magic. The best and easiest you can do is to hide certain steps with display:none; and switch to the next step using javascript toggling visibilities only. 

How to Deploy CodeIgniter/Laravel Apps

Javier Cadiz

[How to Deploy CodeIgniter/Laravel Apps](https://stackoverflow.com/questions/13753198/how-to-deploy-codeigniter-laravel-apps)

I need to know which are my options when deploying codeigniter/laravel apps.I develop locally all the time at my home and when i go to work i need some quick way to push all the changes to the server.Application code needs to be updated, database schemas need to be migrated, and application servers must be restarted. I do all of this manually wasting a lot of time and i need some automated way kinda like capistrano in Rails environment.What are my options here ??Update:

I got my own server machine, and everything needs to work on an intranet environment without internet connection.

2012-12-06 21:46:42Z

I need to know which are my options when deploying codeigniter/laravel apps.I develop locally all the time at my home and when i go to work i need some quick way to push all the changes to the server.Application code needs to be updated, database schemas need to be migrated, and application servers must be restarted. I do all of this manually wasting a lot of time and i need some automated way kinda like capistrano in Rails environment.What are my options here ??Update:

I got my own server machine, and everything needs to work on an intranet environment without internet connection.I've used the following:Nothing has truly been satisfactory and DB schema changes are a huge pain.  So much so that for client configs, we're moving from MySQL to Cassandra, which is basically schemaless.  CI installer is interesting, but I'm not sure how it handles updates.I recently came across this CodeIgniter Installer on GitHub. I've played around with it a few times and it works like a charm for me.It's as simple as putting it in your root directory (alongside your system folder), generating a MySQL dump, and editing a few files. Full instructions are hereI hope it works for you as well as it did for me.I found this Laravel Installer on Github which might be useful. (First I came across this question after searching for Laravel installer in Google, then searched Github for Laravel Installer)

Get latest message (row) per user in Laravel

Trakus Ret

[Get latest message (row) per user in Laravel](https://stackoverflow.com/questions/38120810/get-latest-message-row-per-user-in-laravel)

TL;DR: Need latest message from each sender.In my Laravel application I have two tables:Users:Messages:And of course models.User model:Messages model:When user opens his inbox, he should see list of latest message from any other user.So if there are messages:Then user with id 1 (recipient_id) should see only messages with id 2 and 4.This is current solution in Users model:This is working, but I was wandering if it is possible to achieve this the Laravel way. Probably with eager loading. My Laravel skills just not enough and after several days of trying I don't have a solution.Thanks.

2016-06-30 10:44:16Z

TL;DR: Need latest message from each sender.In my Laravel application I have two tables:Users:Messages:And of course models.User model:Messages model:When user opens his inbox, he should see list of latest message from any other user.So if there are messages:Then user with id 1 (recipient_id) should see only messages with id 2 and 4.This is current solution in Users model:This is working, but I was wandering if it is possible to achieve this the Laravel way. Probably with eager loading. My Laravel skills just not enough and after several days of trying I don't have a solution.Thanks.Taking inspiration from this post, the most efficient way to do this would be like so:While it is not the most Laravel friendly, it is the best solution based on performance as highlighted by the post linked in this answer aboveWhy not simply accessing the messages, like this -I tried some similar approach and found out you only need to orderBy created_at immediately you find all the messages of the User then you can use Laravel's Collection to group them them by sender_id. So to my understanding, the following approach should work, i.e give you the last message receive by the user from the senders :So assuming you have an Authenticated User as $user which in this context is the same as receiver with receiver_id in messages table, then:Then loop round the collection, and fetch the first:You should end up with the result such as:Hope it helps :)UPDATE: I will break it down as I tried it. ~It fetches all records of messages that belongs to user into a collection (already ordered by created_at) then, using laravel's groupBy() you have a result like the example given in that doc.This time I didnt convert to Array. Instead, its a collection Of Collections. like collection(collection(Messages))Then you pick the first Model at each index. The parameters I already passed into the get() method ensures only those fields are present (i.e ->get(['sender_id', 'body', 'created_at']). This is is totally different from mysql groupBy(), as it does not return one row for each group rather, simply groups all records by the given identifier.ANOTHER UPDATEI discovered later that calling unique() method on the resulting ordered messages would actually do the job, but in this case the unique identifier would be sender_id. (ref: Laravel's unique)That is:The consequence is that we don't need the foreach and the groupBy we have the result here.One other way to avoid repeatition (of the above) if this is needed in more than one place is to use Laravel's query scope i.e in Message model we can have something as this:Then in the controller use:PS: Still not sure which one is optimally better than the other.this may be a solution (not tested though) I like a simpler approach which is mentioned here.In your User model additionally to existing messages() relationship,  add this relationshipThen when you query simply query like this.$messages contains latest message per user.EditIn order to order the result by datetime/id you could do it like this.$messages contains latest message per user ordered by id. Refer this answerThis is the most "Eloquent way" I have found of doing this:In User model:Then just $user->latestMessagePerSenderMaybe you can try this one:This may not be very efficient since it took two queries to do the job but you will gain benefits thru code readability.I hope it works the way it should be. I haven't tested it though but that's how I usually do this... Cheers!I found this solution in another forum, I think that is what you were looking for. I post it so it can be useful for other usersoriginal post: https://laracasts.com/discuss/channels/laravel/get-the-latest-message-of-chat-model-with-mysql-just-cannot-get-the-idea-how-to-do-this?page=1#reply=392529You can try this one

Laravel or Phalcon for a heavy-traffic site [closed]

Noah Goodrich

[Laravel or Phalcon for a heavy-traffic site [closed]](https://stackoverflow.com/questions/24997988/laravel-or-phalcon-for-a-heavy-traffic-site)

I come from a Codeigniter background. I've used it for three years and really like it. It's simplicity is great.I've built massive sites with Codeigniter, but I'm looking for a new PHP framework to learn.The main reason for this change is a potentially big project on the horizon. It will not have many users (perhaps 100 at most), but the outbound traffic produced by the server will be huge. The project will transmit thousands of files (ranging in size from 1mb to several hundred mb) via FTP, one after the other. It also deals with users uploading hundreds of files.The key for this project is speed. The system needs to fly through the running of the scripts (it runs a long script every time a file is sent via FTP to gather the file, it's type and it's destination) as quickly as possible to minimize performance issues. I'm aware that the transmitting of the files will only be as quick as the server can do it, and really as quick as the slowest bottleneck, but here I'm trying to minimize the bottleneck in the code as much as possible. After a bit of research, I like the look of Laravel and have installed it to get to grips with it. But it's could its speed be an issue as its been tested to be slower than Codeigniter? Will heavy traffic and a lot of PHP parsing slow down the  I know that Phalcon is based on C thus making it the fastest framework, would Phalcon be the better choice?Any thoughts are much appreciated :)

2014-07-28 14:55:09Z

I come from a Codeigniter background. I've used it for three years and really like it. It's simplicity is great.I've built massive sites with Codeigniter, but I'm looking for a new PHP framework to learn.The main reason for this change is a potentially big project on the horizon. It will not have many users (perhaps 100 at most), but the outbound traffic produced by the server will be huge. The project will transmit thousands of files (ranging in size from 1mb to several hundred mb) via FTP, one after the other. It also deals with users uploading hundreds of files.The key for this project is speed. The system needs to fly through the running of the scripts (it runs a long script every time a file is sent via FTP to gather the file, it's type and it's destination) as quickly as possible to minimize performance issues. I'm aware that the transmitting of the files will only be as quick as the server can do it, and really as quick as the slowest bottleneck, but here I'm trying to minimize the bottleneck in the code as much as possible. After a bit of research, I like the look of Laravel and have installed it to get to grips with it. But it's could its speed be an issue as its been tested to be slower than Codeigniter? Will heavy traffic and a lot of PHP parsing slow down the  I know that Phalcon is based on C thus making it the fastest framework, would Phalcon be the better choice?Any thoughts are much appreciated :)I am unsure if your question will be taken down as it being an opinion (you know according to guidelines and all) but IMO - despite Phalcon being fast for its C build, I find (being Laravel 3 user transitioning from Codeigniter before it retired) with Laravel 4 now - it has a lot of integration with known networks and architectures.Not to bash Phalcon as I have very minimal usage of it but here are some bullets for Laravel:Some further readings from those who switched over and wondered like you:

http://www.web-and-development.com/laravel-vs-codeigniter/and

http://mulzer.tumblr.com/post/24141993116/12-reasons-you-should-switch-from-codeigniter-toNow a bullets for Phalcon vs Laravel in speed:

With Laravel + APC + a few other tweaks you can achieve something close to it while giving you all the flexibility that you gain from Laravel.Finally if you need a side by side comparison:

http://vschart.com/compare/phalconphp/vs/laravelIf it's just about speed take a look at this benchmark: 

http://systemsarchitect.net/performance-benchmark-of-popular-php-frameworks/I would def go with phalcon since it's created on c level basically the same as if it is php  itself.As of the writing of this edit, the site mentioned above is non-functional. Below is a snapshot from archive.org:

https://web.archive.org/web/20160329072449/http://systemsarchitect.net:80/2013/04/23/performance-benchmark-of-popular-php-frameworks/

Get record by ID and all foreigns recursive in Laravel 5

Siper

[Get record by ID and all foreigns recursive in Laravel 5](https://stackoverflow.com/questions/31427227/get-record-by-id-and-all-foreigns-recursive-in-laravel-5)

I've two tables, looks that (migrations):The 'set' table is for storing data in which the location (country, city...) the post should be view. For example, let's store some countries:And, my post has set_id as 6. Looking logically, when I want get posts from Europe (ID 1), that post should be returned too, because 6 belongs to 5, and 5 belongs to 1. And this is that what I want to do. It's possible to do without using too much PHP? 

2015-07-15 09:58:07Z

I've two tables, looks that (migrations):The 'set' table is for storing data in which the location (country, city...) the post should be view. For example, let's store some countries:And, my post has set_id as 6. Looking logically, when I want get posts from Europe (ID 1), that post should be returned too, because 6 belongs to 5, and 5 belongs to 1. And this is that what I want to do. It's possible to do without using too much PHP? Okay, I found the best solution. It's the Nested Set pattern. I used baum package and it looks that:For sets table I added Baum's colums:And done! Just get set_id's and return posts, for example:I’m leave this for posterity ;)You need to break down region, country and city into different tables and establish the relationship between these OR

you can list all the combinations in one single table i.e. ID | Region | Country | City so you would have separate row for each city containing the country and the region.

Is Laravel 5.1 Compatible with PHP 7

Enijar

[Is Laravel 5.1 Compatible with PHP 7](https://stackoverflow.com/questions/34308160/is-laravel-5-1-compatible-with-php-7)

According to the installation section on the Laravel website, 5.1 is compatible with PHP >= 5.5.9.Looking through the incompatibilities I can't see anything that immediately flags warning signs.Has anyone run into issues running PHP 7 with Laravel 5.1?Edit: Set Kyar Wa Lar linked a useful resource to PHP 7 and Laravel.

2015-12-16 09:24:18Z

According to the installation section on the Laravel website, 5.1 is compatible with PHP >= 5.5.9.Looking through the incompatibilities I can't see anything that immediately flags warning signs.Has anyone run into issues running PHP 7 with Laravel 5.1?Edit: Set Kyar Wa Lar linked a useful resource to PHP 7 and Laravel.No issues on my local VM installed from Laravel Homestead Box.

Everything works really fine.You have all the setup information for this box here and a specific section for PHP 7 upgrade: http://laravel.com/docs/5.1/homesteadFor Laravel 5.1.43, with updated vendor, is compatible with PHP 7.and you can make sure through these methods by your self for any version of Laravel.1. All unit test passed in PHP 7.0.82. Homestead for 5.1 is already upgrade to PHP 7https://laravel.com/docs/5.1/homestead3. Analysis using PHP-MigrationThese spots is compatible with PHP 7 after manually checking.For better experience with PHP 7.3, you may simply upgrade it to Laravel 5.2.

It works well with PHP 7.3 environment.

Get enum options in laravels eloquent

barfoos

[Get enum options in laravels eloquent](https://stackoverflow.com/questions/26991502/get-enum-options-in-laravels-eloquent)

In my migration file, I gave my table pages a enum field with 2 possible values (as seen below). My question is, if it's possible to select these values with Laravels Eloquent?There are several Workarounds that I found, but there must be some "eloquent-native" way to handle this. My expected output would be this (that would be perfect!):Thank you in advance!

2014-11-18 10:03:59Z

In my migration file, I gave my table pages a enum field with 2 possible values (as seen below). My question is, if it's possible to select these values with Laravels Eloquent?There are several Workarounds that I found, but there must be some "eloquent-native" way to handle this. My expected output would be this (that would be perfect!):Thank you in advance!Unfortunately, Laravel does not offer a solution for this. You will have to do it by yourself. I did some digging and found this answerYou can use that function and turn it into a method in your model class...And you use it like thisIf you want you can also make it a bit more universally accessible and generic.First, create a BaseModel. All models should then extend from this classAfter that, put this function in thereYou call this one like thatMade a small improvement to lukasgeiter's function.  The foreach loop in his answer is parsing the string.  You can update the regex to do that for you.As of L5.17 Eloquent does not include this functionality, instead you need to fall back to native QL. Here's an example that will work with SQL and in one line - returning an array like you asked.In the spirit of one liner complexity ;)I threw this in one of my view composers - it fetches the column from the table, explodes it and assembles the values in an array.I iterate over that in my views using a foreach.

Laravel pagination pretty URL

jOpacic

[Laravel pagination pretty URL](https://stackoverflow.com/questions/20974404/laravel-pagination-pretty-url)

Is there a way to get a pagination pretty URL in Laravel 4?For example, by default:And what I would like to get:Also, the pagination should render this way, and appending to the pagination should appear in this way.

2014-01-07 14:38:58Z

Is there a way to get a pagination pretty URL in Laravel 4?For example, by default:And what I would like to get:Also, the pagination should render this way, and appending to the pagination should appear in this way.Here's a hacky workaround. I am using Laravel v4.1.23. It assumes page number is the last bit of your url. Haven't tested it deeply so I'm interested in any bugs people can find. I'm even more interested in a better solution :-)Route:View:Model:Migration:It's possible but you need to code a bit.First you need to change in app/config/app.php pagination service provider - you need to write your own.Comment:and addin providers section.Now you need to create your PaginationServiceProvider to use custom pagination factory:model/Providers/PaginationServiceProvider.php file:Above you create Providers\PaginationFactory object, so now we need to create this file:model/providers/PaginationFactory.php file:Here you create only \Utils\Paginator object so now let's create it:model/Utils/Paginator.php file:In this file we finally override default method for creating pagination urls.Let's assume you have route defined this way:As you see we defined here route name using as (it's important because of Paginator implementation above - but you can do it of course in different way).Now in method displayList of CategoryController class you can do:When in your view you add:you will get generated urls this way:without ? in query stringHowever in my opinion something like this should be added by default or at least it should be enough to extend one class and not to create 3 classes just to implement one method.hope this is helpful for someone, I've made a trait to be used in models.

The idea is that this custom method can detect current route and adjust links  to use correct segment position for {page} parameter:https://gist.github.com/zofe/ced0054e6ac6eff1ea95The only way I can think of doing this is by extending the Paginator class to do the matching. However, just know that it may conflict with third-party packages and other classes/libraries. The current method is designed to work with nearly all classes/libraries/packages.Perhaps you could try the following:http://packalyst.com/packages/package/desmart/pagination ('pagination' by 'desmart')For anyone that is using laravel version 5.6+You can pass additional parameters to set the page number.According to: https://laravel.com/api/5.6/Illuminate/Database/Eloquent/Builder.html#method_paginateExample:StoreController.phpThen, in your blade template. You can just route( ... , array('page' => $page));For Laravel 5.8 use this solution in blade.php where you generate links:

Laravel homestead IP address not working

evcohen

[Laravel homestead IP address not working](https://stackoverflow.com/questions/28036879/laravel-homestead-ip-address-not-working)

I’m using Laravel Homestead 2.0 for my VM and am trying to serve my sites on the default IP address in the YAML file 192.168.10.10My /etc/hosts file looks like this:My Homestead.yaml file looks like this:The sites come up when I link my domains to 127.0.0.1 but I have to append port 8000 onto the end of the URL (which isn’t a big deal, I just want to get the specified IP address to work). Does anyone know why I cannot connect to server when my domains are pointed to 192.168.10.10?When I ping deploy.dev the right IP address shows up, but still my browser can’t connect to the server. I’m thinking it might have something to do with DNS issues in Yosemite.

2015-01-20 02:39:17Z

I’m using Laravel Homestead 2.0 for my VM and am trying to serve my sites on the default IP address in the YAML file 192.168.10.10My /etc/hosts file looks like this:My Homestead.yaml file looks like this:The sites come up when I link my domains to 127.0.0.1 but I have to append port 8000 onto the end of the URL (which isn’t a big deal, I just want to get the specified IP address to work). Does anyone know why I cannot connect to server when my domains are pointed to 192.168.10.10?When I ping deploy.dev the right IP address shows up, but still my browser can’t connect to the server. I’m thinking it might have something to do with DNS issues in Yosemite.I had the same problems a few weeks ago.First:

make sure your folder paths are correct, if so, double check itNext:

run homestead destroy and homestead up to reinitialize the VMif that all didnt work:

Check if you have any devices at home that might also be on 192.168.10.10.If that all didnt work, your problem is probably alot harder to fix and i'd suggest making a github issue for it.Hey I had this exact same problem. I eventually got it working by installing the deprecated net-tools package: 

sudo apt-get update and

sudo apt-get install gnome-nettoolAfter this,

homestead destroy and

homestead upThis allowed me to access my virtual machine sites from my local machine's browser using the 'domains' I specified in the hosts file - in your case beta.dev and deploy.dev - without referring to localhost or port 8000. Good luck, hope this helps.This is the solution I did for my Windows 10 machine:Make sure you add a persistent route to your vagrant box

In Administrator command prompt enter

route -p add 192.168.10.0 mask 255.255.255.0 192.168.10.1And make sure you are able to ping 192.168.10.10Also check the IP address configured for the virtualbox host-only adapter is 192.168.10.1 with mask 255.255.255.0Installing net-tools on ubuntu fixed this for meI had exactly this issue, and it turned out that nginx was failing to start due to an error when loading the TLS certificates. The vagrant up command doesn't report that nginx failed to start, or that any ports failed to bind.To diagnose this, I did the following:There is no port 80 in the list. Let's double-check port 80.So it is certainly closed. What do the guest logs say? vagrant ssh and...Nginx has failed to start due to an error in it's config. The PEM_read_bio_X509_AUX error points to the /etc/nginx/ssl/homestead.app.crt file. Where is that file used in the configuration?I commented out the related lines:Start nginx with $ sudo service start nginx and run nmap again from the host.Port 80 is open and should be accessible now from http://homestead.app . Of course TLS won't be working but you should be able to fix it by generating new certificates. I'm not sure of the reason for the certificates failing to load in the first place.I had the same situation, but I made a change.I changed my /etc/hosts file with this IP 127.0.0.1I had a similar issue yesterday for Homestead 5. It turned out the cause of my problem was that I was running the wrong Vagrantfile.An instance should give a response to the ip address: 192.168.10.10To correct the problem in my case what I did was to follow these instructions: http://laravel.com/docs/5.0/homesteadTo recap:In terminal run: then then and run this command FROM INSIDE the new "Homestead" folderthen run the commands vagrant up and vagrant provision to that Vagrantfile, that should have been created inside ./HomesteadHere is what the output of the vagrant provision command looks like on my system:In my case the problem was solved by letting vagrant up install the guest additions:After this point, I got a new interface with the expected IP address:I had this issue come up on my Windows machine and it turns out I had accidentally reversed the folders section "map" and "to". When I found that the folder wasn't underneath ~/code/ in the vagrant ssh session it was obvious it wasn't working right, but double checking the paths didn't yield anything. Here is the correct way to map the folder section on your Windows machine:

Recommend way to Artisan on Docker

tomsowerby

[Recommend way to Artisan on Docker](https://stackoverflow.com/questions/24821859/recommend-way-to-artisan-on-docker)

I am yet to find an elegant and efficient way to run Laravel Artisan commands in my Docker based local dev environment.Could anybody suggest the recommended or "proper" way to do things like migrations?Or, has anybody found a neat way of doing this? Ideally with examples or suggestions.Things that I've considered:I'm still getting my head around Docker and it's new-container-for-everything approach.I suppose I want to balance cool-dev-ops stuff with why-do-I-need-another-fake-server-just-get-it-working-already.I'd love to commit to it for my dev workflow, but it seems to become awkward to use under certain circumstances, like this one...Any suggestions and ideas are welcome. Thanks all.

2014-07-18 09:40:13Z

I am yet to find an elegant and efficient way to run Laravel Artisan commands in my Docker based local dev environment.Could anybody suggest the recommended or "proper" way to do things like migrations?Or, has anybody found a neat way of doing this? Ideally with examples or suggestions.Things that I've considered:I'm still getting my head around Docker and it's new-container-for-everything approach.I suppose I want to balance cool-dev-ops stuff with why-do-I-need-another-fake-server-just-get-it-working-already.I'd love to commit to it for my dev workflow, but it seems to become awkward to use under certain circumstances, like this one...Any suggestions and ideas are welcome. Thanks all.The best practice regarding Docker is to run each process inside it's own container. Therefore, the ideal way to run artisan commands is to have an image for creating containers specifically for this purpose.I've created an image which can be pulled from the Docker Hub dylanlindgren/docker-laravel-artisan and it works really well. It's on GitHub as well if you want to take a look at the Dockerfile behind it.I've also just written a blog post describing the way that all these seperate containers fit together.Docker 1.3 bring new command exec

So now you can "enter" running container likeAfter that you can run any command you wantThere are a couple of possibilities...If you're primarily interested in deployment and you're doing it via a dockerfile, then the answer would be to add composer install and php artisan migrate to your dockerfile so they run when the container is built.I'm interested in hearing more answers to this. It's something that I'm just getting into as well and would like to learn more about.I use SSH and run migrations from a terminal inside the container.I personally like Phusion's approach of using Docker as a 'lightweight virtual machine'. So I used their baseimage-docker which I've extended to create my own Docker image for Laravel applications.I'm aware Phusion's image can be contentious in the Docker community, and that SSH is frowned upon by some who advocate Docker containers as microservices. But I'm happy with Phusion's approach until there are more established tools and practices for the multi-container approach.

How to retrieve full data of record by its foreign key in laravel?

user2551866

[How to retrieve full data of record by its foreign key in laravel?](https://stackoverflow.com/questions/17873721/how-to-retrieve-full-data-of-record-by-its-foreign-key-in-laravel)

I've been trying to figure out the proper way to get all the data from a record via a foreign key. I have  simple app where users can add books to their "bookshelf". Here are my tables:USERS BOOKSBOOKSHELFBOOKSHELF_BOOKSIn my Eloquent Models, a bookshelf hasMany books and bookshelf_books belongsTo a bookshelfand I have set those up in my models. What happens is users create a "bookshelf" and add books to it from the list of books. I'm at the point where I need to render the bookshelf with the user's books.When I retrieve my bookshelf books with a call like Bookshelf::find($id)->books, the books that belong to that bookshelf return just fine..but only columns from the bookshelf table. So I get in return the bookshelf id, the user id, and the book id.What I want to have returned is all the data of the book itself when i query for books in the bookshelf, not just it's id. E.G. [{"book_id":1, "pages":364, "number_of_chapters":14},{"book_id":2, "pages":211, "number_of_chapters":9}]. I've been scratching my head all day trying to figure out how to take this "join" one step further in Laravel/Eloquent ORM. Would love any help with this, thanks!!

2013-07-26 05:38:49Z

I've been trying to figure out the proper way to get all the data from a record via a foreign key. I have  simple app where users can add books to their "bookshelf". Here are my tables:USERS BOOKSBOOKSHELFBOOKSHELF_BOOKSIn my Eloquent Models, a bookshelf hasMany books and bookshelf_books belongsTo a bookshelfand I have set those up in my models. What happens is users create a "bookshelf" and add books to it from the list of books. I'm at the point where I need to render the bookshelf with the user's books.When I retrieve my bookshelf books with a call like Bookshelf::find($id)->books, the books that belong to that bookshelf return just fine..but only columns from the bookshelf table. So I get in return the bookshelf id, the user id, and the book id.What I want to have returned is all the data of the book itself when i query for books in the bookshelf, not just it's id. E.G. [{"book_id":1, "pages":364, "number_of_chapters":14},{"book_id":2, "pages":211, "number_of_chapters":9}]. I've been scratching my head all day trying to figure out how to take this "join" one step further in Laravel/Eloquent ORM. Would love any help with this, thanks!!Just eager load the relationshipChangetoWhat about just doing it manually, and building your own array.Then just return $thebooks to the View.  Which will be an array of book models.What you have should be correct.$bookshelf = Bookshelf::find($id)->books;To get your books, you would create a loop...To take this further, if you had an Author model which your books would belongTo(), you could even do something like..Try this queryTry this sql statement, it will work.

How to Display Validation Errors Next to Each Related Input Field in Laravel 5?

Matt Komarnicki

[How to Display Validation Errors Next to Each Related Input Field in Laravel 5?](https://stackoverflow.com/questions/36885413/how-to-display-validation-errors-next-to-each-related-input-field-in-laravel-5)

Default solution is trivial:and I can include errors.blade.php anywhere.Is there any way to extract each element and display it next to input field that holds the value that failed?I assume that would require me to define a lot of conditional if statements next to each input, right? How to sort this problem? Could you give me any examples?Thanks.

2016-04-27 09:16:29Z

Default solution is trivial:and I can include errors.blade.php anywhere.Is there any way to extract each element and display it next to input field that holds the value that failed?I assume that would require me to define a lot of conditional if statements next to each input, right? How to sort this problem? Could you give me any examples?Thanks.You can use something like this :@Zorx has given a right solution. But what if there are multiple errors and you want to display all of them at once.According to the documentation you could use:Retrieving All Error Messages For A FieldIf you are validating an array form field, you may retrieve all of the messages for each of the array elements using the * character:Retrieving All Error Messages For All Fields

Laravel Interfaces

Hardist

[Laravel Interfaces](https://stackoverflow.com/questions/30976140/laravel-interfaces)

I used the following tutorial to get an idea about interfaces:http://vegibit.com/what-is-a-laravel-interface/But I wanted to change the directory of where I am putting my interfaces to "App/Models/Interfaces". And so I did. But now I cannot get it to work anymore. Here is my code:Routes.phpModel Subaru.phpInterface CarInterfaceI added this in my composer.json:And I even added this in my start/global.php file:

2015-06-22 09:14:30Z

I used the following tutorial to get an idea about interfaces:http://vegibit.com/what-is-a-laravel-interface/But I wanted to change the directory of where I am putting my interfaces to "App/Models/Interfaces". And so I did. But now I cannot get it to work anymore. Here is my code:Routes.phpModel Subaru.phpInterface CarInterfaceI added this in my composer.json:And I even added this in my start/global.php file:In my recent laravel 5 project, I'm used to prepare my logics as Repository method. 

So here's my current directory structure. For example we have 'Car'.So first I just create directory call it libs under app directory and loaded it to composer.jsonafter that I create a subfolder call it Car . Under the Car folder create two file 'CarEloquent.php' for eloquent implementation and CarInterface.php as interface.Then create Car Service Provider to bind ioc controller.

For create Car service provider you can also use php artisan command by laravel. 

php artisan make:provider CarServiceProvider And final step would be add these service provider to config/app.php provider array.And finally we are ready to use our repository method in our controller.Main purpose to achieve here call repository method to controller, however you need use them as per your requirement.CarEloqent basically help us to improve database implementation, for example in future if you want to implement same functionality for other database like redis you just add another class CarRedis and change implementation file path from server provider. http://programmingarehard.com/2014/03/12/what-to-return-from-repositories.html[book] From Apprentice to Artisan by Taylor OtwellVery good explanation about repository method and software design principle commonly called separation of concerns. You should read this book. If you still have any confusion to achieve these behaviors let me know and however I will keep eye on this question to update this answer, if I find some things to change or update or as per requirement. 

Laravel artisan optimize Best Practices

suncoastkid

[Laravel artisan optimize Best Practices](https://stackoverflow.com/questions/31895854/laravel-artisan-optimize-best-practices)

I'm trying to fully understand the Laravel (5.1) artisan optimize command and best practices, but the documentation seems lacking. I don't have Composer installed on the production server so, specifically, I want to know what files are modified or created when running artisan optimize --force on development that must get pushed to production. The goal being not to blow up the app in production! After running the command, I see the following files have been modified:Am I overthinking this, or do I just push these files to production and I'm good to go? Also, what is the best practice regarding when to run artisan optimize? Each time a new model is created? What about controllers, routes and helper classes? Lastly, I see the \bootstrap\cache\compiled.php file is a whopping 548KB and almost 17K lines! Is that really considered optimal?

2015-08-08 16:00:01Z

I'm trying to fully understand the Laravel (5.1) artisan optimize command and best practices, but the documentation seems lacking. I don't have Composer installed on the production server so, specifically, I want to know what files are modified or created when running artisan optimize --force on development that must get pushed to production. The goal being not to blow up the app in production! After running the command, I see the following files have been modified:Am I overthinking this, or do I just push these files to production and I'm good to go? Also, what is the best practice regarding when to run artisan optimize? Each time a new model is created? What about controllers, routes and helper classes? Lastly, I see the \bootstrap\cache\compiled.php file is a whopping 548KB and almost 17K lines! Is that really considered optimal?[edit - As @crishoj says, as of Laravel 5.5, php artisan optimize is no longer needed]Normal Laravel practice is to have composer installed on your production server.These are the steps Envoyer (made by Laravel's creator) takes to deploy an app on production -- I've annotated them below:As of Laravel 5.5, php artisan optimize is not longer required.You can also take benefit of laravel packages to easily optimize your application by caching page partialshttps://github.com/imanghafoori1/laravel-widgetize

Laravel belongsTo returning null when using 'with'

Djave

[Laravel belongsTo returning null when using 'with'](https://stackoverflow.com/questions/26778082/laravel-belongsto-returning-null-when-using-with)

I'm just getting started with Laravel so please forgive any noobness.I have a User and Order model, a user has many orders:So I think I have the above right.But when I do this:I get Call to a member function addEagerConstraints() on null.However, if I do it the other way around, it works great:What am I doing wrong / what don't I understand?! Or is my problem bigger than I think?Database:

2014-11-06 11:14:35Z

I'm just getting started with Laravel so please forgive any noobness.I have a User and Order model, a user has many orders:So I think I have the above right.But when I do this:I get Call to a member function addEagerConstraints() on null.However, if I do it the other way around, it works great:What am I doing wrong / what don't I understand?! Or is my problem bigger than I think?Database:The problem is you don't have return for your orders relationship. It should be:You should also use your relationships case sensitive. you showed:is working, but you should rather use to avoid extra queries to your database in futureFor anyone else that runs across this, I was having the same issue, but my problem was that I had the foreign/local keys swapped. Example:Notice that for hasX relationships, the foreign key is the second parameter, and the local key is the third. However, for belongsTo relationships, these two are swapped.

laravel - Can't get session in controller constructor

gogagubi

[laravel - Can't get session in controller constructor](https://stackoverflow.com/questions/41542802/laravel-cant-get-session-in-controller-constructor)

In new laravel I can't get session in constructor. Why? and then below In old laravel i remember there was not this problem. something changed?

2017-01-09 07:15:04Z

In new laravel I can't get session in constructor. Why? and then below In old laravel i remember there was not this problem. something changed?You can't do it by default with Laravel 5.3. But when you edit you Kernel.php and change protected $middleware = []; to the following it wil work.Hope this works!As of other answers no out of the box solution for it.

But you still can access it using Middleware in constructor.So here is another hackLaravel 5.7 solutionIf you want to use constructor for any other functionality or query or data then do all the work in $this->middleware function, NOT outside of this. If you do so it will not work in all the functions of entire class.In Laravel 5.3 sessions related functionality will not work in the a controller constructor, so you should move all sessions related logic to methods.I used Session in the construct using middleware, You can try, It would be helpful

How to validate time in laravel

Vikash

[How to validate time in laravel](https://stackoverflow.com/questions/39467452/how-to-validate-time-in-laravel)

I want to validate time in Laravel. Ex:- I want that when user input the time between 8 PM to 10 PM then it will show the validation error. How can I achieve that in Laravel

2016-09-13 10:11:23Z

I want to validate time in Laravel. Ex:- I want that when user input the time between 8 PM to 10 PM then it will show the validation error. How can I achieve that in LaravelUse date_format rule validationFrom docsThe field under validation must match the format defined according to the date_parse_from_format PHP function.Probably this code would work in your controller. However it won't validate times from different days (eg 9pm - 3am next day). time_start and time_end in this case should be provided as HH:mm but you can change it easily.Try This codeCreate DateRequest and then addYou probably should take a look to this bit of the documentations. A custom rule sounds like your way to go.In Lavavel 5.6:Inside the file located in /app/Http/Requests/YourRequestValidation

Laravel 4 : Best Practice to Trim Input before Validation

Chen-Tsu Lin

[Laravel 4 : Best Practice to Trim Input before Validation](https://stackoverflow.com/questions/22399326/laravel-4-best-practice-to-trim-input-before-validation)

Now, I do trim for each input separately like below code:Is any approach to do Trim at the same time withInput::all() or Input::only('username', 'password', 'email')?And what is the best practice to do this?

2014-03-14 08:04:02Z

Now, I do trim for each input separately like below code:Is any approach to do Trim at the same time withInput::all() or Input::only('username', 'password', 'email')?And what is the best practice to do this?Note: This solution won't work if any of your inputs are arrays (such as "data[]").You may try this, trim using this one line of code before validation:Now do the rest of your codingIf you want to exclude some inputs from trimming then you may use following instead if all()Or you may useUpdate: Since Laravel 5.4.* inputs are trimmed because of new TrimStringsmiddleware. So, no need to worry about it because this middleware executes on every request and it handles array inputs as well.Depending on your project, the below might be too intrusive/generalized/etc for your needs; customize as needed.app/helpers.phpapp/filters.phpMaybe you can use the array_map function of php, to trim the content of your input array.Or if you want a variable you can use later:Usually, I also use this approach to replace optional values with null when they're empty, because I prefer to store them in DB as NULL rather than empty strings.It's a better practice to do trimming in the model instead of in controllers because then you don't have to duplicate code in all your controllers to trim the same things over and over:This way, you never have to remember to trim anything model attributes in your controllers. The model will take care of it and you don't have to worry about it ever again.As far as trimming everything at once vs. individually, I think the difference is so small that no human would ever notice the difference.A combination of the above is best. Generally you'll want to filter on all input apart from password and password_confirmation fields. Also doing it with a single line in a filter is nice.// app/filters.phpan improvement in Halil Özgür code to remove all spaces, <br>, <br >, <br class="asdasd">, &nbsp, etcJust Use TrimStrings and ConvertEmptyStringsToNull Middleware.You do not need to do anything extra, because those middlewares are built-in to Laravel 5.4.See this PostEdit:

What if I am not using Laravel 5.4?

How to give custom field name in laravel form validation error message

JOE

[How to give custom field name in laravel form validation error message](https://stackoverflow.com/questions/25187846/how-to-give-custom-field-name-in-laravel-form-validation-error-message)

I was trying form validation in laravel. 

I have a input text field in my form called 'Category' and i'm given the field name as 'cat' as short. And i defined the validation rules like this.When the validation fails i'm getting error message like thisBut i want to display it as "The category field is required" instead of 'cat'. How can i change 'cat' to 'Category' in error message ?.

2014-08-07 16:41:25Z

I was trying form validation in laravel. 

I have a input text field in my form called 'Category' and i'm given the field name as 'cat' as short. And i defined the validation rules like this.When the validation fails i'm getting error message like thisBut i want to display it as "The category field is required" instead of 'cat'. How can i change 'cat' to 'Category' in error message ?.You can specify custom error message for your field as follows.Please see Custom Error Messages section in laravel documentation for more information. Or you can keep a mapping for your field names like below. And you can set those into you validator. So you can see descriptive name instead of real field name.I'm using this to deal with dynamic row addition in forms. This answer is provided in context of managing larger forms.

This answer is for Laravel 5Form requestHope this help steer you in the right direction if you are using Laravel 5. I'm currently working on testing it out. The documentation seems to be amiss regarding this potential?I did some digging in the framework (Illuminate\Foundation\Http\FormRequest.php) and (Illuminate\Validation\Validator.php) for the clues. you can customize every message ,also change the attribute fields name in validation.php (resources/lang/en/).

for set the attribute in validation.php Here's an alternative:Simply got to resources/lang/en/validation.phpThere is a blank array named attributes.add your attribute name here like 'cat'=>'category'now all validation messages show category instead of cat.Here is an Alternative

$this->validate(request(), [rules], [custom messages], [Custom attribute name]);

Saving one to one relation in Laravel

rap-2-h

[Saving one to one relation in Laravel](https://stackoverflow.com/questions/32498142/saving-one-to-one-relation-in-laravel)

A User has one (or zero) Company, and a Company belongs to one and only one User. I try to save a company for a user but it adds a new entry in database every time I re-trigger the save method. It's a one to one relation, so I though save method on User.So Company has one method user():And User has one method company():I'm trying to save (so create or update) a user's company like this (in a Controller):First time I run this code it creates the entry in database (OK), but second time it adds a new entry for the same user (Not OK). I thought it will only update the database entry.Is it a glitch (or something I don't understand in one to one relation) in Laravel or am I doing something wrong? (I think and hope it's the second purpose)

2015-09-10 09:32:46Z

A User has one (or zero) Company, and a Company belongs to one and only one User. I try to save a company for a user but it adds a new entry in database every time I re-trigger the save method. It's a one to one relation, so I though save method on User.So Company has one method user():And User has one method company():I'm trying to save (so create or update) a user's company like this (in a Controller):First time I run this code it creates the entry in database (OK), but second time it adds a new entry for the same user (Not OK). I thought it will only update the database entry.Is it a glitch (or something I don't understand in one to one relation) in Laravel or am I doing something wrong? (I think and hope it's the second purpose)Creating and updating need to treat differently. So check the existence of company attribute first.Note that hasOne() does not guarantee that you will have one-to-one relationship, it just telling Eloquent how to create query. It works even you have multiple Company refer to same User, in such case when you call $user->company you will get first Company in the result data set from database.You can do exactly that with the updateOrCreate method:The first parameter of updateOrCreate is an empty array, because the companies id is determined by the hasOne relationship $user->company().And by the way, I would recommend not using an auto-increment id field in a hasOne relationship. If you set user_id as primary in your company table, its technically not possible to create duplicate company rows for one user. Check out my blog post for more.You are doing wrong hereSo your code has to be modified like this

Laravel access request object outside controller

xelber

[Laravel access request object outside controller](https://stackoverflow.com/questions/38319707/laravel-access-request-object-outside-controller)

According to the Laravel documentation Request is acquired via dependency injection. For a controller this is fine, but how do we access Request object outside a controller, for example in a view

2016-07-12 03:46:41Z

According to the Laravel documentation Request is acquired via dependency injection. For a controller this is fine, but how do we access Request object outside a controller, for example in a viewThere is request helper in laravel. You can use Request Object anywhere.

For exampleHere's  laravel documentation link for request helper

https://laravel.com/docs/5.2/helpers#method-request

In Laravel 5, What's the difference between {{url}} and {{asset}}?

无名小路

[In Laravel 5, What's the difference between {{url}} and {{asset}}?](https://stackoverflow.com/questions/39217975/in-laravel-5-whats-the-difference-between-url-and-asset)

I find sometimes both is OK?  So what's the really difference?For example,andthese two form is both OK.So, what's the differences?

2016-08-30 02:40:32Z

