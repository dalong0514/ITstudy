I find sometimes both is OK?  So what's the really difference?For example,andthese two form is both OK.So, what's the differences?Consider the type of URL that is needed / how the URL is being used. One of the advantages of having separate helper methods for each type of URL is they can have different handling logic. For example, assets (e.g. CSS, images, etc.) could involve a check that the file exists in the file system but do not require the type of analysis that a route would because the route may have parameters.{{url}} allows you to create a link to a URL on your site -- another benefit is the fact that you can set the second parameter to an array with query string parameters within.{{asset} simply allows you to link to an asset within your public directory -- for example css/main.css.asset() asset function generates a url for an asset using the current scheme of request.

Ex : asset('images/img.png')url() The url function generates a fully qualified URL to the given path.Ex : url('admin/users')URL::route gets the URL to a named route. So in your case if you name your route like this:then you will be able to use<a href="{{ URL::route('register') }}" >Register 1</a>

in Blade templates.

Check if any error message exists and show all of them in laravel

Suman Ghosh

[Check if any error message exists and show all of them in laravel](https://stackoverflow.com/questions/12419814/check-if-any-error-message-exists-and-show-all-of-them-in-laravel)

In laravel for showing all error messages at once i use the following code in the viewBut when I want to use $errors->all() instead of $something in the if condition it's showing an errorAlthough the above code works fine, I think there may be a better ways to check if any error message exists and if it does then display it. 

2012-09-14 07:17:35Z

In laravel for showing all error messages at once i use the following code in the viewBut when I want to use $errors->all() instead of $something in the if condition it's showing an errorAlthough the above code works fine, I think there may be a better ways to check if any error message exists and if it does then display it. Yes, because you can't use any method as empty function parameter. From php docs:What class is $errors? If it's your own class you can implement such method like 'isEmpty()' and then use in if statement:In my controller I use the following code to pass validation errors to my view:Then, in my view, I can use the following code to check if errors exist:You can also use if($errors->all()). From the Laravel (v4) docs:

PDOException: could not find driver when using phpunit

melanholly

[PDOException: could not find driver when using phpunit](https://stackoverflow.com/questions/23245800/pdoexception-could-not-find-driver-when-using-phpunit)

I am starting to use laravel 4 and I am trying to start using unit tests so I can make my live easier. Well as all of you will guess my development hasn't become easier after trying phpunit tests. The simple tests are well, easy but when the things start to get a bit more complicated  they does not go as I though they will. The problem is I have conducted simple tests but I get some strange error PDOException: could not find driver. I have read a few articles and post on this topic but nothing solved my problem. I have installed php5-mysql and when I call php -m it says that I have both PDO and pdo_mysql. The actual command I use is php -m |grep -i "pdo" and the output is: Well I've tried to actualy test PDOException class in the browser. For that purpose I have change the mysql user password to incorrect one and tested what will happen in artisan server (called with command php artisan serve ---> http://localhost:8000/). In the browser everything works as a charm but when I try to call ``phpunit` in the console the result is not the same. I have tried to see if webserver and cli have different configuration files but it turnout that the files are identical. The configuration files that I have compared are:for the web serverfor command lineto compare them I user the diff command like so diff -s /path/to/file1 /path/to/file2.The errors look like this:Can you give me a hint or solution to this problem? Thank you for your time :)

2014-04-23 13:26:44Z

I am starting to use laravel 4 and I am trying to start using unit tests so I can make my live easier. Well as all of you will guess my development hasn't become easier after trying phpunit tests. The simple tests are well, easy but when the things start to get a bit more complicated  they does not go as I though they will. The problem is I have conducted simple tests but I get some strange error PDOException: could not find driver. I have read a few articles and post on this topic but nothing solved my problem. I have installed php5-mysql and when I call php -m it says that I have both PDO and pdo_mysql. The actual command I use is php -m |grep -i "pdo" and the output is: Well I've tried to actualy test PDOException class in the browser. For that purpose I have change the mysql user password to incorrect one and tested what will happen in artisan server (called with command php artisan serve ---> http://localhost:8000/). In the browser everything works as a charm but when I try to call ``phpunit` in the console the result is not the same. I have tried to see if webserver and cli have different configuration files but it turnout that the files are identical. The configuration files that I have compared are:for the web serverfor command lineto compare them I user the diff command like so diff -s /path/to/file1 /path/to/file2.The errors look like this:Can you give me a hint or solution to this problem? Thank you for your time :)It seems Laravel using SQLite as database for testing. See the backtrace at line 2:But this seems not installed on your system. So I think you need to install the SQLite driver.If you are using sqlite for testing you will need php sqlite driversFor Ubuntu 14.04In ubuntu 16.04 there is no php5-sqliteOn Windows i had to activate extension=php_pdo_sqlite.dll in php.ini.If you are occupying SqLite you have to enter php.init and uncomment this line.For those using Laravel Homestead, make sure you're running phpunit from within Homestead and not on your local machine! You can SSH into it with vagrant ssh.As others have mentioned, it requires SQLite and thus running it within your virtual machine ensures that's available to your test.php7.0-sqlite no longer works use php7.1-sqlite

Laravel Mail sending email but returning false

Chris Casper

[Laravel Mail sending email but returning false](https://stackoverflow.com/questions/24772531/laravel-mail-sending-email-but-returning-false)

I am trying to send a email and show any errors if needed. The following code is sending a email and I am receiving it just fine. The issue though, is that when I do the check on the $sent var, it returns false for me.Am I just missing something here? It might be because it's late. Who knows...

2014-07-16 05:01:55Z

I am trying to send a email and show any errors if needed. The following code is sending a email and I am receiving it just fine. The issue though, is that when I do the check on the $sent var, it returns false for me.Am I just missing something here? It might be because it's late. Who knows...The Mail::send() method doesn't return anything.You can use the Mail::failures() (introduced in 4.1 I think) method to get an array of failed recipients, in your code it would look something like this.

Import CSV file to Laravel controller and insert data to two tables

Devin Gray

[Import CSV file to Laravel controller and insert data to two tables](https://stackoverflow.com/questions/35220048/import-csv-file-to-laravel-controller-and-insert-data-to-two-tables)

So I am a complete noob to Laravel and am trying something here. I want to import a CSV file into two tables, I have a table called lists that will get the list name and a client_id.Then I have a table called customers that will get name surname contact number as well as client_id and a list_id. What I want to achieve is to import a CSV file that will take the file name and store it in the list table, then create an array through the CSV file and import the data into the customers table with the list and client id's.I have the first part done, and it inserts into the lists table correctly, How do I now create an array from the CSV that is located in storage/documents and then insert that into the customers table?I chose to use the answer that I had accepted but I also played with the other answer and got it to work like this.

2016-02-05 09:03:25Z

So I am a complete noob to Laravel and am trying something here. I want to import a CSV file into two tables, I have a table called lists that will get the list name and a client_id.Then I have a table called customers that will get name surname contact number as well as client_id and a list_id. What I want to achieve is to import a CSV file that will take the file name and store it in the list table, then create an array through the CSV file and import the data into the customers table with the list and client id's.I have the first part done, and it inserts into the lists table correctly, How do I now create an array from the CSV that is located in storage/documents and then insert that into the customers table?I chose to use the answer that I had accepted but I also played with the other answer and got it to work like this.There are 3 steps to read CSV file and import it in database in Laravel. Before we start, I have created a sample test.csv file and put it on my public folder under file folder:Step 1 and 2; I created a helper function called csvToArray, I just put it in my controller for now (this function is inspired from this link) it simply reads the CSV file and convert it to array:Step 3; And here is my final step, read array and insert it in our database:if you use dd($customerArr) you will get this

In your store() method, create the record in your lists table, and then iterate over the contents of the CSV file and insert the data into the customers table. You should create a relation between customers and lists for this purpose. You would also be better off using something like the PHP League’s CSV package for reading such files:@maytham The solution by Maytham will work well. However, it will have a huge problem if you're trying to do with large data. Even if you do 1000 rows, it will create a problem, as it will make 1000 insert statement separately. I will just edit the third method by him and add my own inputThis will call the database once to insert as many rows as you wish. Be it 1000, 100000 or whatever. 

However, if you have a huge csv, this will be a problem too since you will be required to insert in chunks. Like in PostgreSQL, I have noticed that you can insert up to 65000 something rows in one statement. Maybe I am wrong about the number but there's a limit in every database and you need to look for that.

My composer won't update completely with Laravel 4 it gets stuck with artisan

jnbdz

[My composer won't update completely with Laravel 4 it gets stuck with artisan](https://stackoverflow.com/questions/19775012/my-composer-wont-update-completely-with-laravel-4-it-gets-stuck-with-artisan)

Here is the error I am getting:This shows after:I tried to delete all my folders in my vendor folder. But that did not change anything.I am using MAMP server on my Mac OS X.PHP Version 5.4.10mcrypt 2.5.8I just tried "sudo composer update --verbose" and I got this error:Here is the error I found in my PHP error logs:I just tried to test my composer:Just applied the recommendation in the error message from the last command. Now everything is showing as OK.I just tried this:I am now getting new errors in my PHP Error logs:

2013-11-04 18:58:52Z

Here is the error I am getting:This shows after:I tried to delete all my folders in my vendor folder. But that did not change anything.I am using MAMP server on my Mac OS X.PHP Version 5.4.10mcrypt 2.5.8I just tried "sudo composer update --verbose" and I got this error:Here is the error I found in my PHP error logs:I just tried to test my composer:Just applied the recommendation in the error message from the last command. Now everything is showing as OK.I just tried this:I am now getting new errors in my PHP Error logs:I believe this error results from not being able to find mcrypt.Apparently it is not quite that easy to install mcrypt.The final steps were inspired by Vuk Stanković.Okay, did some further research with Google and it seems that this has to do with the autoload caching from Composer. There are various ways on how you can solve this.This would re-create the autoload stuff for you and it should solve your problem for now.If this doesn't help, try deleting everything and re-install fresh: [ref]This would re-create just about everything.It looks like your laravel install did not run correctly and since part of the composer.json runs the php artisan clear-compiled and php artisan optimize if your laravel application is not working then composer will fail. Try running your composer update without invoking the Laravel scripts.After that you can either run the commands from the scripts block in your composer.json manually. Else you can just run a standardagain which will run the scripts for you.To fix this you need to install mcrypt.

In ubuntu execute the following command: Then update composer:Another solution for me, setting xdebug.scream = 1 gives problem:1) Find xdebug configuration file. 2) Edit file using any text editor.3) Set xdebug.scream = 04) Reload serverI had a similar issue when trying to run composer update and none of the solutions above had worked. It turns out I had 2 require sections in my composer.json which is actually wrong. Combining the two as below solved my issue.If you still have a problem, try deleting the composer.lock and the vendor directory and runTo clear the composer cache and finally run This should solve the issue.

Laravel check for constraint violation

guidsen

[Laravel check for constraint violation](https://stackoverflow.com/questions/26363271/laravel-check-for-constraint-violation)

I was curious if there is a way we can check if there is a constraint violation error when delete or insert a record into the database.The exception thrown is called 'QueryException' but this can be a wide range of errors. Would be nice if we can check in the exception what the specific error is.

2014-10-14 14:24:25Z

I was curious if there is a way we can check if there is a constraint violation error when delete or insert a record into the database.The exception thrown is called 'QueryException' but this can be a wide range of errors. Would be nice if we can check in the exception what the specific error is.You are looking for the 23000 Error code (Integrity Constraint Violation). If you take a look at QueryException class, it extends from PDOException, so you can access to $errorInfo variable.To catch this error, you may try:To be more specific (Duplicate entry, not null, add/update child row, delete parent row...), it depends on each DBMS:For laravel, handling errors is easy, just add this code in your "app/start/global.php" file ( or create a service provider):first put this in your controller second handle the error by using try catch like this exampleNew updates here without need to use try catch you can easily do that in validation rules as the following code blew where id related to record which you edit.You may also trythen look for error code.This catches all exception including QueryExceptionYou can add the following code in app/start/global.php file in order to print the exceptioncheck this part in the  documentationIf you are using Laravel version 5 and want global exception handling of specific cases you should put your code in the report method of the /app/Exception/Handler.php file. Here is an example of how we do it in one of our micro services:The Response class we use is a simple wrapper of Symfony\Component\HttpFoundation\Response as HttpResponse which returns HTTP responses in a way that better suits us.Have a look at the documentation, it is straightforward.

Laravel 5 form request validation returning forbidden error

Emeka Mbah

[Laravel 5 form request validation returning forbidden error](https://stackoverflow.com/questions/30878105/laravel-5-form-request-validation-returning-forbidden-error)

I am trying to use Laravel 5.1's form request validation, to authorize if the request is from the owner. The validation is used when the user is trying to update part of the table clinics through the show.blade.php.My set up so far:routes.php:ClinicController.php:UpdateClinicAddressFormRequest.php:Show.blade.phpAny help why on submit it's saying 'forbidden' would be hugely appreciated.

2015-06-16 21:00:33Z

I am trying to use Laravel 5.1's form request validation, to authorize if the request is from the owner. The validation is used when the user is trying to update part of the table clinics through the show.blade.php.My set up so far:routes.php:ClinicController.php:UpdateClinicAddressFormRequest.php:Show.blade.phpAny help why on submit it's saying 'forbidden' would be hugely appreciated.You are getting Forbidden Error because authorize() method of form request is returning false:The issue is this: $clinicId = $this->route('postUpdateAddress'); To access a route parameter value in Form Requests you could do this:$clinicId = \Route::input('id'); //to get the value of {id} so authorize() should look like this:I add this owner confirmation to authorize() method in Request and work

Laravel 5 Auth Logout not destroying session

seoppc

[Laravel 5 Auth Logout not destroying session](https://stackoverflow.com/questions/29621965/laravel-5-auth-logout-not-destroying-session)

I am using Laravel5 Auth system for my new project, I am able to use registration and login functions with out any problem but logout is not working as expected, however I get redirected to url specified at $redirectAfterLogout but it does not destroy session so even after hitting logout button I am able to see dashboard. Does laravel has some bug in Auth system, please suggest, thanks

2015-04-14 07:55:44Z

I am using Laravel5 Auth system for my new project, I am able to use registration and login functions with out any problem but logout is not working as expected, however I get redirected to url specified at $redirectAfterLogout but it does not destroy session so even after hitting logout button I am able to see dashboard. Does laravel has some bug in Auth system, please suggest, thanksYou have not provided any piece of code that you have used. However, the following code works:The Session::flush();clears all the existing sessions.Using Laravel 5.2, I registered a listener, handled the logout event and called Session::flush as suggested above. Seemed to work pretty well. Hope this is helpful.EventServiceProvider.phpClearSessionAfterUserLogout.phpI had the same issue and I tried everything, but in the end I could fix it.My problem was that when I hit on the logout button, before that I had some http requests that weren't answered yet, so even when the user was log out, later with the response of the pending requests it got logged in again. Here is an example:So Removing those non-answered requests worked for me. I hope that this answer helps :)I switched to the database session driver and used the following code in my logout actionYou can simply override the logout method in AuthController.phpHere is code sample:trait AuthenticatesUsers change this to  thisThe function getLogout() is never reached, hence the logout() method never fires.In your case you are not probably reaching the logout() method. If you are using Laravel 5 builting auth mechanism then you will run AuthenticatesAndRegistersUsers trait getLogout() method which does $this->auth->logout();Find this code edit the method like below for debugging. If you see the string "Logging out" then you must be logged out. Ohterwise something is wrong with your routing and logout is just never executed.I've been fighting with this, and I've come to a solution.In short: The Laravel session reads and writes with middleware. It reads the stored session in at the start of the request, and writes any changes at the end of the request. If you make a redirect, then the current request never finishes, and the middleware write doesn't happen.So, how to fix this? Depending on your implementation... you should return the redirect command rather than calling it directly.I ran into a similar issue and it turned out using the 'file' driver for sessions somehow the server was creating files it could not modify later but there was no file permission warning. I switched to a redis implementation so I unfortunately can not say how to fix the file creation issue, but thought this might save someone some time.By accepting the request object in a controller action (Remember to add this after the controller namespace declaration: use Auth; ):For the newest versions.

How can I redirect with old input in Laravel?

cyber8200

[How can I redirect with old input in Laravel?](https://stackoverflow.com/questions/30002608/how-can-i-redirect-with-old-input-in-laravel)

I have a login modal. When the user log-in fail the authentication, I want to redirect back to this modal with : As you can see as part of my image, the error message seem to display, but the old input of username doesn't seem to populate.Can someone please correct me ? 

Did I forget to do anything ? 

What is the most efficient way in Laravel to accomplish something like this ? 

2015-05-02 13:02:18Z

I have a login modal. When the user log-in fail the authentication, I want to redirect back to this modal with : As you can see as part of my image, the error message seem to display, but the old input of username doesn't seem to populate.Can someone please correct me ? 

Did I forget to do anything ? 

What is the most efficient way in Laravel to accomplish something like this ? You can access the last inputs like so:$username = Request::old('username');As pointed at by @Arian Acosta you may simply do<input type="text" ... value="{{ old('username') }}" ... >.As described in the docs it is more convenient in a blade view.There are several possibilties in the controller:Instead of

  ->withInput(Request::except('password')) do:a) Input::flash(); or:b) Input::flashExcept('password');and redirect to the view with:a) ->withInput(Input::except('password'));resp. with:b) ->withInput();The docs about Old Input for further reading...You are missing the value on your input element...For my project, I needed another way:Shove a GET request in the validation return to fetch some previous data:

Laravel Blade Templating @foreach order

Ugo Guazelli

[Laravel Blade Templating @foreach order](https://stackoverflow.com/questions/34700499/laravel-blade-templating-foreach-order)

Is there any way to sort @foreach loop in laravel blade? I wolud like to order by $key->description, I know I can use order by in my controller,but the controller returns other values and those values must be sorted as well, so I need to order by in blade.

2016-01-10 00:12:54Z

Is there any way to sort @foreach loop in laravel blade? I wolud like to order by $key->description, I know I can use order by in my controller,but the controller returns other values and those values must be sorted as well, so I need to order by in blade.Assuming that your $specialist variable is an Eloquent collection, you can do:Moreover, you could call your Eloquent model directly from the template:Note that you are using a misleading variable name of $key in your foreach() loop. Your $key is actually an array item, not a key. I assume that you saw foreach ($array as $key => $value) syntax somewhere and then removed the $value?I would suggest using a laravel collection. More specifically, the sortBy(). You can use either of these in your view or the controller that you are passing the data from. If the data is being passed by a model, be sure to use the collect() function before proceeding to use any of the others listed.Hope this helps!

Laravel 5 - skip migrations

Erhnam

[Laravel 5 - skip migrations](https://stackoverflow.com/questions/35115541/laravel-5-skip-migrations)

I have migrated an existing Laravel 5 application and database. Only no migrations table was there yet, so I created this with the following command:Inside the database migration folders three files exist (2015_12_08_134409_create_tables_script.php, 2015_12_08_134410_create_foreign.php, 2015_12_08_134411_create_index.php) When using 'php artisan migrate' the scripts inside the migrations folder are executed again. This is what I want to avoid. Is it possible to insert records in Laravel's migrations table, so these scripts will be skipped and new scripts will be picked up once 'php artisan migrate' is executed again?

2016-01-31 15:26:56Z

I have migrated an existing Laravel 5 application and database. Only no migrations table was there yet, so I created this with the following command:Inside the database migration folders three files exist (2015_12_08_134409_create_tables_script.php, 2015_12_08_134410_create_foreign.php, 2015_12_08_134411_create_index.php) When using 'php artisan migrate' the scripts inside the migrations folder are executed again. This is what I want to avoid. Is it possible to insert records in Laravel's migrations table, so these scripts will be skipped and new scripts will be picked up once 'php artisan migrate' is executed again?Once you have the migration table created, insert these records:So artisan will understand those migrations as 'executed'Another way is just create a folder under database/migrations to put you want skip migrations, this method works for both files that have been migrated or not yet migrated.This Artisan CLI extension command is support single command to migrate specific files on Laravel 5.4 or later:

Laravel: orderBy a column with collections

Hamed Kamrava

[Laravel: orderBy a column with collections](https://stackoverflow.com/questions/42854788/laravel-orderby-a-column-with-collections)

I need to OrderBy a column with collection.I need to orderBy(updated_at, 'desc') all posts which owned by current logged user. Here is my code :Here is User model :It doesn't return any errors also doesn't sort !Any helps would be great appreciated.P.S:I know I can achieve this with :But I would like to do the same thing with collections.

2017-03-17 10:16:01Z

I need to OrderBy a column with collection.I need to orderBy(updated_at, 'desc') all posts which owned by current logged user. Here is my code :Here is User model :It doesn't return any errors also doesn't sort !Any helps would be great appreciated.P.S:I know I can achieve this with :But I would like to do the same thing with collections.So this is how you sort with SQL:And with collections:I've tested the 2nd one and it works as intended for me.Documentation: https://laravel.com/docs/6.x/collections#method-sortbydesc 

*Its available since Laravel 5.1Try adding the following to your User modelThen get the posts by calling posts_sortedByDesc instead of  posts@devk is right. What I wrote in the first post is correct.The problem was in DataTables in the the view.It needed to add this line to the Datatables options:So this is working fine :

Trait not found inside Laravel 5 unit tests

John Dorean

[Trait not found inside Laravel 5 unit tests](https://stackoverflow.com/questions/31253706/trait-not-found-inside-laravel-5-unit-tests)

I'm writing some unit tests to test the API endpoints in my Laravel 5 application, and a lot of endpoints require user authentication. Instead of having the same user account creation code in every test, I wanted to define a RegistersUsers trait to use on the test classes, which will have a registerUser() method.The directory structure of my tests directory is like so:I've namespaced TestCase.php and UserTest.php by adding this namespace declaration:and I've namespaced RegistersUsers.php like so:My UserTest looks like this, with the namespace and the use declaration so that I can leverage RegistersUsers.However, when I run the test, PHPUnit dies with the fatal error:As far as I can tell, my namespacing is correct and my trait should be found. I've been going around in circles with this and can't seem to figure it out.

2015-07-06 19:08:19Z

I'm writing some unit tests to test the API endpoints in my Laravel 5 application, and a lot of endpoints require user authentication. Instead of having the same user account creation code in every test, I wanted to define a RegistersUsers trait to use on the test classes, which will have a registerUser() method.The directory structure of my tests directory is like so:I've namespaced TestCase.php and UserTest.php by adding this namespace declaration:and I've namespaced RegistersUsers.php like so:My UserTest looks like this, with the namespace and the use declaration so that I can leverage RegistersUsers.However, when I run the test, PHPUnit dies with the fatal error:As far as I can tell, my namespacing is correct and my trait should be found. I've been going around in circles with this and can't seem to figure it out.I'm guessing having the trait in the traits folder, the trait is no longer accounted for in your autoloader.In order to correct this, you should open up composer.json, find the sectionfor autoload-dev and change it to something like the following...And that should add any traits you have in that folder to the autloader.EditSome additional ideas were brought up in the comments.  If you are going to be maintaining proper folder/namespace structure, it would be a good idea to use psr-4 autoloading rather than maintaining the class map.Also, rather than put logic in a trait to register a user for use with testing, when you extend TestCase, it brings in a helper method for logging in as a certain user.  You'd use it like so...

Laravel controller construct

Raggaer

[Laravel controller construct](https://stackoverflow.com/questions/17697575/laravel-controller-construct)

I started with laravel few days ago and I'm facing this issue:The NO is never returned!This is Controller, do you have any idea why?

2013-07-17 10:39:49Z

I started with laravel few days ago and I'm facing this issue:The NO is never returned!This is Controller, do you have any idea why?

Laravel Eloquent: Best Way to Calculate Total Price

Wendy Adi

[Laravel Eloquent: Best Way to Calculate Total Price](https://stackoverflow.com/questions/31421666/laravel-eloquent-best-way-to-calculate-total-price)

Im building a simple buy and sell application with Laravel 5.1. Each Buy Model has many BuyDetail which stores bought item quantity and buy_price. I have implement the relationship between table on the Model.I'd like to calculate the total price for each Buy. What is the best way to calculate the total price using Eloquent ORM?for now i just implement it like this:

2015-07-15 04:42:57Z

Im building a simple buy and sell application with Laravel 5.1. Each Buy Model has many BuyDetail which stores bought item quantity and buy_price. I have implement the relationship between table on the Model.I'd like to calculate the total price for each Buy. What is the best way to calculate the total price using Eloquent ORM?for now i just implement it like this:This can be done in (at least) 2 ways.Using pure Eloquent model logic:The only issue here is that it needs to fetch all buy details from the database but this is something you need to fetch anyway to display details in the view.If you wanted to avoid fetching the relation from the database you could build the query manually:I realise an answer’s already been accepted, but just thought I’d add my own detailing another approach.Personally, I like to put「aggregate」methods like these on custom collection classes. So if I have a Buy model that can have many BuyDetail models, then I would put a getTotal() method on my BuyDetailCollection method like this:I can then add this to the BuyDetail model:And use my getTotal() method where ever I need to now:

Laravel: String data, right truncated: 1406 Data too long for column

Sergej Fomin

[Laravel: String data, right truncated: 1406 Data too long for column](https://stackoverflow.com/questions/48477861/laravel-string-data-right-truncated-1406-data-too-long-for-column)

I have a table with a column 'hotel'. The project is created in Laravel 5.4, so I used Migrations. This is MYSQL VARCHAR (50). It was working good, because when I was developing I used short hotel names like "HILTON NEW YORK 5"*. Now the project is on production and customer asked why they can't input long hotel names. I've tested it with such a mock hotel name as "Long long long long long long long long long and very-very-very long hotel name 5 stars"It gave me an error:I've opened database in my Sequel Pro and changed itAfter each change I tested it with the same "Long long long long long long long long long and very-very-very long hotel name 5 starts" and get the same error (see above).I've checked the type of column with and it gave me so the type of the field is 'text' indeed  (65 535 characters). Maybe it's somehow connected with Laravel Migration file (see above) where I set VARCHAR (50) in the beginning? But I can't re-run migration on production, because the table has data now. Would appreciate any help.UPDATE:

I discovered that it actually saves that long hotel name in the DB. But user still gets this annoying mistake every time after submitting the form...

2018-01-27 16:26:36Z

I have a table with a column 'hotel'. The project is created in Laravel 5.4, so I used Migrations. This is MYSQL VARCHAR (50). It was working good, because when I was developing I used short hotel names like "HILTON NEW YORK 5"*. Now the project is on production and customer asked why they can't input long hotel names. I've tested it with such a mock hotel name as "Long long long long long long long long long and very-very-very long hotel name 5 stars"It gave me an error:I've opened database in my Sequel Pro and changed itAfter each change I tested it with the same "Long long long long long long long long long and very-very-very long hotel name 5 starts" and get the same error (see above).I've checked the type of column with and it gave me so the type of the field is 'text' indeed  (65 535 characters). Maybe it's somehow connected with Laravel Migration file (see above) where I set VARCHAR (50) in the beginning? But I can't re-run migration on production, because the table has data now. Would appreciate any help.UPDATE:

I discovered that it actually saves that long hotel name in the DB. But user still gets this annoying mistake every time after submitting the form...You need to create a new migration, register it with composer du command and run php artisan migrate command to change type of the column:On your local development, try changing the column type to:from your migration file. That solved it for me. But if you have gone live, then create a new migration just as Alexey has suggested and then use longText() column type.change the type of column fromstring to text. Then run a migrate refresh using php artisan migrate:refeshChange column's datatype from string to text and do not give length.Change column's datatype from string to text and do not give length.

dd($request->all()); gives back empty array

chloealee

[dd($request->all()); gives back empty array](https://stackoverflow.com/questions/30334216/ddrequest-all-gives-back-empty-array)

I am trying to upload a photo from my Laravel 5 app to be stored in AWS. I am using the Postman REST client to test. When I upload a photo, the request returns an empty array. Does anyone know why this might be? Here's the code for my Avatar Controller: 

2015-05-19 19:11:34Z

I am trying to upload a photo from my Laravel 5 app to be stored in AWS. I am using the Postman REST client to test. When I upload a photo, the request returns an empty array. Does anyone know why this might be? Here's the code for my Avatar Controller: Found the answer - looks like there was an issue with my headers in Postman. I had both Accept application/json and Content-Type application/json. Once I removed Content-Type, all is fixed. Thanks! Bit late to the party, but might be usefull for others:

My problem was that the Content-Type header value was application/json while the actual payload was form data. Changing the header to application/x-www-form-urlencoded fixed the issue.You might want to test that the JSON is validTry dd($request), dd($_REQUEST), dd($request->files).try use thisThe same issue on postman, while using PUT/PATCH method directly.

One possible solution is to send your PUT/PATCH request as a POST, but include proper _method in the request body along with other parameters.

_method: PUTHope this helpsShould be using:Request::all();As per documents: http://laravel.com/docs/5.0/requests

OctoberCMS How To Create Custom User Registration Form With Fields From Plugin Extension

user2694306

[OctoberCMS How To Create Custom User Registration Form With Fields From Plugin Extension](https://stackoverflow.com/questions/34681748/octobercms-how-to-create-custom-user-registration-form-with-fields-from-plugin-e)

I'm trying to learn OctoberCMS and I am confused about the complete process of extending plugins. I've extended the user plugin according to the screencast (https://vimeo.com/108040919). Ultimately, I'm looking to create a new field called "category" which wold store a users category. On a new page, I have the following form which I am trying to use to register a new user based solely on their e-mail address. The "category" is populated based on the page that they registered from and the password should be automatically generated so that the user will set it upon confirming their account from an e-mail activation link. My plugin is called "Profile".My plugin.php file looks like:My profile.php file looks like:I am trying to create a user registration form that looks like the following:What I am confused about is how to make an "onSignup" component that will basically extend the functionality of the user plugins "onRegister" component and then automatically generate a password and also save the "category" field. Can anyone provide an example or link to a page that shows an example of this? Thanks.

2016-01-08 16:31:20Z

I'm trying to learn OctoberCMS and I am confused about the complete process of extending plugins. I've extended the user plugin according to the screencast (https://vimeo.com/108040919). Ultimately, I'm looking to create a new field called "category" which wold store a users category. On a new page, I have the following form which I am trying to use to register a new user based solely on their e-mail address. The "category" is populated based on the page that they registered from and the password should be automatically generated so that the user will set it upon confirming their account from an e-mail activation link. My plugin is called "Profile".My plugin.php file looks like:My profile.php file looks like:I am trying to create a user registration form that looks like the following:What I am confused about is how to make an "onSignup" component that will basically extend the functionality of the user plugins "onRegister" component and then automatically generate a password and also save the "category" field. Can anyone provide an example or link to a page that shows an example of this? Thanks.Okay, I just had to do something like this for my own site.  So I'll try and explain the 2 options you have.

1: Override stuff using the theme and page php.2: Create a component to do it all.  This is the way I ended up goingIt's definitely confusing.    Take a look at the User Plus plugin as a guide and the locations plugin (required) to add country/state dropdown.    Far as making the password random, not 100% the best way but you can use onInit for your component to just seed one in the form post data.  the password field has to be added to the post data since the user's plugin passes the post fields to the model (which is why you must set category_id as fillable or it gets blocked for security reasons).  I am messing with this stuff myself and the users plus with the location plugin helped a lot. Sorry i couldn't be more detailed. 

Integration tests mocking facades vs injecting mocks

myol

[Integration tests mocking facades vs injecting mocks](https://stackoverflow.com/questions/39255103/integration-tests-mocking-facades-vs-injecting-mocks)

We have some legacy laravel projects which use facades in the classes. Our more recent projects use dependency injection of the underlying laravel classes that the facades represent as has been hinted at by Taylor Otwell himself. (We use constructor injection for each class, but to keep the example short, here I use method injection and use a single class.)I know facades can be mockedWhich works nicely for unit tests. The problem I am trying to understand is if these facades are mocked 'globally'.For example, lets imagine I am writing an integration test (testing a few interconnected classes while mocking services - not an end to end test using live services) which at some point, executes two separate classes which contain the same facade that calls the same method with the same parameters. In between these classes being called, is some complex functionality that changes what data is returned by that facades method using the same parameter.*Our modern classes are easy to test because the underlying class that the facade represents is injected into each class (in this example, each method). This means I can create two separate mocks and inject them into each class (method) to mock the different results.In the legacy systems though, it would seem that the mocked facade is 'global' so that when the facade is run in each class, the exact same value is returned.Am I correct in thinking this?*I understand this example may seem completely redundant from a code architecture and testing point of view, but I am stripping out all real functionality to try and give some sort of 'simple' example of what I am asking.

2016-08-31 16:53:50Z

We have some legacy laravel projects which use facades in the classes. Our more recent projects use dependency injection of the underlying laravel classes that the facades represent as has been hinted at by Taylor Otwell himself. (We use constructor injection for each class, but to keep the example short, here I use method injection and use a single class.)I know facades can be mockedWhich works nicely for unit tests. The problem I am trying to understand is if these facades are mocked 'globally'.For example, lets imagine I am writing an integration test (testing a few interconnected classes while mocking services - not an end to end test using live services) which at some point, executes two separate classes which contain the same facade that calls the same method with the same parameters. In between these classes being called, is some complex functionality that changes what data is returned by that facades method using the same parameter.*Our modern classes are easy to test because the underlying class that the facade represents is injected into each class (in this example, each method). This means I can create two separate mocks and inject them into each class (method) to mock the different results.In the legacy systems though, it would seem that the mocked facade is 'global' so that when the facade is run in each class, the exact same value is returned.Am I correct in thinking this?*I understand this example may seem completely redundant from a code architecture and testing point of view, but I am stripping out all real functionality to try and give some sort of 'simple' example of what I am asking.Dependency Injection vs FacadesOne of the major benefits of Dependency Injection is that code becomes a lot more testable once you start injecting dependencies into methods instead of instantiating/hardcoding them inside the method. This is because you can pass in the dependencies from inside unit tests and they will propagate through the code.See: http://slashnode.com/dependency-injection/Dependency Injection stands in stark contrast to Facades. Facades are static global classes, the PHP language does not allow one to overwrite or replace static functions on static classes. The Laravel facades use Mockery to provide mock functionality and they are limited by the same facts as above. The issue for integration testing can come where you are hoping to retrieve data from a non-mocked Cache but once you use Facade::shouldReceive() then Facade::get() will be overridden by the mocked Cache. The reverse is also true. As a result, Facades are inappropriate where you are interleaving calls for mocked and unmocked data.In order to test your code with the different data sets that you require, the best practice would be to refactor your legacy code to use DI. Integration TestsEasier methodAn alternative is to call multiple Facade::shouldReceive() with expectations at the beginning of your integration test. Ensuring that you have the right numbers of expectations in the right order for each of the calls you will make in the integration test. This would probably be the faster way to write tests given your existing codebase.Harder methodWhilst dependency injection is programming best practice. It could very well be that your codebase has so many legacy classes that it would take an unbelievable amount of time to refactor. In this case, it might be worthwhile considering end-to-end integration tests using a test database with fixtures.Appendix:

Laravel 5 file downloads: stream() or download()

Jones03

[Laravel 5 file downloads: stream() or download()](https://stackoverflow.com/questions/44965777/laravel-5-file-downloads-stream-or-download)

I have a Laravel 5.4 app where authenticated users need to be able to download private files from S3 storage. I've setup a route and controller to allow private file downloads. The code looks like this:Route:Controller:All working fine, but when I had a closer look to the Laravel docs, I found that they just talk about response()->download(). If I implement that kind of response, my code would look like this:Both functions can be found in the API docs.My question: what would be the preferred way to go and what are the advantages/disadvantages of each?From what I've gathered so far:Stream:Download:

2017-07-07 08:11:46Z

I have a Laravel 5.4 app where authenticated users need to be able to download private files from S3 storage. I've setup a route and controller to allow private file downloads. The code looks like this:Route:Controller:All working fine, but when I had a closer look to the Laravel docs, I found that they just talk about response()->download(). If I implement that kind of response, my code would look like this:Both functions can be found in the API docs.My question: what would be the preferred way to go and what are the advantages/disadvantages of each?From what I've gathered so far:Stream:Download:When you call Laravel the response() helper, it returns an instance of the Illuminate\Routing\ResponseFactory. The ResponseFactory has these two methods: download and stream - the two methods in question. If you dig a little bit deeper, you'll see that download returns an instance of \Symfony\Component\HttpFoundation\BinaryFileResponse, while stream returns a \Symfony\Component\HttpFoundation\StreamedResponse - these are both Symfony components.Digging through the code here isn't necessary, but it is nice to have an understanding of what's going on under the hood. Now that we know the underlying objects returned are from the Symfony HTTP Component, we can consult the Symfony docs and see what they recommend using. Typically, streams are used when the size of the file is unknown, such as when you are generating the file on the fly. In most other cases, the BinaryFileResponse generated by the download method will be sufficient for your needs. You can take a look at a much more in-depth explanation of HTTP Streaming and its use cases here.

laravel whereHas results weird

user259752

[laravel whereHas results weird](https://stackoverflow.com/questions/46492444/laravel-wherehas-results-weird)

product modelthe controllerthe raw SQL:above SQL return no results(when the product id = 3below SQL return the correct result(when the product id = 6)have no idea, the query look like no problemprevious project i got this issues too, at the end i use find and loop once more instead of using whereHas, but this time i encounter this problem again and try to find out why but few hours wasted, still no clue, below is a workaround(ignoring the bugs?)

2017-09-29 15:42:01Z

product modelthe controllerthe raw SQL:above SQL return no results(when the product id = 3below SQL return the correct result(when the product id = 6)have no idea, the query look like no problemprevious project i got this issues too, at the end i use find and loop once more instead of using whereHas, but this time i encounter this problem again and try to find out why but few hours wasted, still no clue, below is a workaround(ignoring the bugs?)i created the tables mentioned above (giving exactly same relations, table names, model names) and tried your code (by giving hard coded values) but got the perfect resultsandpls check if everything is fine with your database, check if every primary key and foreign keys are created as "integer". And check "collation" of db well as tables.This doesn't seem Laravel-related (since you still get no results when running the query directly with MyAdmin).Run the query again, commenting each where condition one by one (I added a true first condition to easily comment out all "and ..." lines) to see if you spot where the problem begins.(I did try creating both tables, and both queries return correct results, by the way.)try this hope it will help you,I think you should change your relationship concept in the product model from hasMany to belongsToMany.

Also update the parameters by defining the country model as first argument, intermediate table name as second argument then foreign key and primary key as 3rd and 4th arguments. belongsToMany('App\Models\Country', 'product_country','product_id', 'country_id')Product ModelBecause each country may belong to many products and each product may belong to many countries.First things first:If you're using eloquent (find method), you can do something like:and it returns a model of product where the id you've provided equals the primary key. Having that said, there is no need to use a whereHas() since it will have no effect. Instead of find(), you can try get() or first() for example, depending on what you're looking for.If you want to print out your query, you can end it with ->toSql(); and it will print the query as a string (helps a lot!).I didn't paid much attention to the objective but I'm sure if you use the You'll be able to compare what you're doing (since you know what the correct result or query should be like) and be able to figure it out. After all, we do need to exercise to explore our mind!I know this thread is a little bit stale, but my team actually had a very similar issue with Laravel and the whereHas (MySQL EXISTS) on MySQL 5.7.18. As soon as we upgraded MySQL, the same query started to return exactly as expected. I haven't yet figured out if this was a bug with 5.7.18, but I suspect it might be.

Export CSV or PDF Based On Datatables Laravel 4

hahahaha

[Export CSV or PDF Based On Datatables Laravel 4](https://stackoverflow.com/questions/32173798/export-csv-or-pdf-based-on-datatables-laravel-4)

I have a datatables which contains the data retrieved from database. When I enter some keywords into search textbox (the search textbox is generated by datatables), the result of the table will be changes. This is good. But when I click export to csv or pdf, the result in csv or pdf will be retrieved from database instead of datatables. How to export to csv/pdf based on the datatables plugin using laravel? //datatable plugins//php

2015-08-24 02:45:35Z

I have a datatables which contains the data retrieved from database. When I enter some keywords into search textbox (the search textbox is generated by datatables), the result of the table will be changes. This is good. But when I click export to csv or pdf, the result in csv or pdf will be retrieved from database instead of datatables. How to export to csv/pdf based on the datatables plugin using laravel? //datatable plugins//phpI would probably post the keyword to my server and run the sql query again filtering those results and then create the csv/pdfOne way you could do it is to use jQuery and make an ajax call.Firstly, give the table an ID. Next, get the table itself and get its HTML using this bit of code:Then make an ajax call to Laravel to generate the PDF passing through the HTML. You can use this HTML to PDF library: http://wkhtmltopdf.org/You should then get back the PDF with the exact table you had on screen (with any filters etc).As a sidenote, you can also add your CSS to the HTML to give to the PDF library and it will even style the table to be the same too!Hope this helps.

Conditional extends in Blade

Jordan Doyle

[Conditional extends in Blade](https://stackoverflow.com/questions/18524365/conditional-extends-in-blade)

Is there any way to do a conditional @extends statement in the Blade templating language?When the request was not AJAX it printed out @extends('dashboard.master'), but the AJAX request worked fine.Stop including the master template (which includes header and footer) for AJAX so it can easily display the requested content

2013-08-30 03:18:35Z

Is there any way to do a conditional @extends statement in the Blade templating language?When the request was not AJAX it printed out @extends('dashboard.master'), but the AJAX request worked fine.Stop including the master template (which includes header and footer) for AJAX so it can easily display the requested contentin the master layout:This kind of logic should really be kept out of the template.In your controller set the $layout property to be dashboard.master then instead of calling returning your view or response, terminate with just $this->layout->content = View::make('dashboard.template')Take a look at the Laravel docs on thisYou could end up with something like this

Laravel 5 Class 'Collective\Html\HtmlServiceProvider' not found on AWS

carbide20

[Laravel 5 Class 'Collective\Html\HtmlServiceProvider' not found on AWS](https://stackoverflow.com/questions/32795154/laravel-5-class-collective-html-htmlserviceprovider-not-found-on-aws)

I know there are a bunch of other questions floating around out there with the same error, such as: Class 'Illuminate\Html\HtmlServiceProvider' not found Laravel 5My problem is that I've followed all suggested steps to solve this on my local (XAMPP), and it fixed it without a hitch. The issue is when I went to deploy to my AWS ubuntu box (nginx). I followed all the usual instructions: http://laravelcollective.com/docs/5.1/html#installationMy providers and aliases had been added when I did a git pull from what I had pushed from my local. Perhaps this file should have been gitignored, and the change made manually on the server?I then manually added:And finally, I ran:It was running this command that throws the error:I then tried running php artisan clear-compiled, to see if that would do anything, and got:I know my nginx ubuntu environment is not the same as a windows xampp env, but I'm still unsure why following the Laravel-provided instructions for adding this don't seem to working. Would greatly appreciate some advice on this.Cheers!

2015-09-26 08:29:05Z

I know there are a bunch of other questions floating around out there with the same error, such as: Class 'Illuminate\Html\HtmlServiceProvider' not found Laravel 5My problem is that I've followed all suggested steps to solve this on my local (XAMPP), and it fixed it without a hitch. The issue is when I went to deploy to my AWS ubuntu box (nginx). I followed all the usual instructions: http://laravelcollective.com/docs/5.1/html#installationMy providers and aliases had been added when I did a git pull from what I had pushed from my local. Perhaps this file should have been gitignored, and the change made manually on the server?I then manually added:And finally, I ran:It was running this command that throws the error:I then tried running php artisan clear-compiled, to see if that would do anything, and got:I know my nginx ubuntu environment is not the same as a windows xampp env, but I'm still unsure why following the Laravel-provided instructions for adding this don't seem to working. Would greatly appreciate some advice on this.Cheers!When you update your composer it will check the providers. Because you haven't installed laravelcollective/html yet he can't find it and throws an error:So first require your packeges, then add them to the config file.You can also work with composer require laravelcollective/html, it will add it to the json file automatically. Then it doesn't matter if you have added them before or not because the config file won't be checked.I have encountered the same error on Laravel 5.2.*, followed instruction here: https://laravelcollective.com/docs/5.2/html, but did not work.The other way to fix it, on your CLI, run:$ composer dump-autoloadThen run:$ composer updateThis works for me. ;)If you're using Laravel 5.2, try adding this to your composer.jsonInstallation failed, reverting ./composer.json to its original content.[ErrorException]

  copy(/home/zahid/.composer/cache/files/laravelcollective/html/20e9e29d83e23aba16dc4b8d93d0757e1541f076.zip): failed to open stream: Permiss

  ion denied Command: composer require laravelcollective/html --prefer-sourcethen it workFirst try composer update . It will update all dependencies but in case it doesn’t work delete vendor folder of your project and type composer install  and run in cli which again add dependencies.

how to clean Laravel Bootstrap cache config file?

Abel D

[how to clean Laravel Bootstrap cache config file?](https://stackoverflow.com/questions/33823207/how-to-clean-laravel-bootstrap-cache-config-file)

I developed laravel app locally and uploaded in shared hosting. While hosting I changed the database name and username of mysql in the .env and the config/database files.But in remote its still using the old db name and user which is found in the bootstrap/cache/config file.So how to clean the bootstrap/cache/config.php file?

2015-11-20 09:30:42Z

I developed laravel app locally and uploaded in shared hosting. While hosting I changed the database name and username of mysql in the .env and the config/database files.But in remote its still using the old db name and user which is found in the bootstrap/cache/config file.So how to clean the bootstrap/cache/config.php file?Use php artisan cache:clear to flush the application's cache.If you are trying to clear configuration cache, which it sounds like you are. You need to run:php artisan config:clearAt some point, you probably ran php artisan config:cache which generated a cached version of your config file, and this file is not cleared with php artisan cache:clearI tried all the above options but nothing works.I manually removed from bootstrap/cache/config.php. And it works. This is the Ultimate solution.I just stumbled into this while building automated deployment in AWS. The problem with Laravel is that artisan commands also use the cache. Now if you deploy new version of your application you may have outdated entries in the cache which in turn will make the artisan command to crash i.e. cannot find some class that was cached but no longer exist. Therefore you either need to:1) Clear cache before you deploy the application2) Clear cache manuallyFinally you want to run optimize command which will re-build your configuration cache, bootstrap file cache and route caches.Or you can just manually delete bootstrap/config.php, which is what artisan does after all.See: vendor\laravel\framework\src\Illuminate\Foundation\Console\ConfigClearCommand.phpYou can use:Laravel 4 : php artisan cache:clearalso for laravel 5(not tested),Illuminate\Cache\FileStore has the function flushalso,Here is the Tip,if you still stuck in finding helpful commands, you can run php artisan list and it will list out every command with its description. look for a specific thing you want to perform. if you need migration-related command, you can look in migration.The solution for me was to remove the files in the bootstrap/cache/ directory and then delete the vendor folder. Re-run composer install and then composer dump-autoload and the above campaigns should run fine. Deleting the vendor folder and re-running composer install was the missing link for me

Just installed Lumen and got NotFoundHttpException

robertsan

[Just installed Lumen and got NotFoundHttpException](https://stackoverflow.com/questions/36436967/just-installed-lumen-and-got-notfoundhttpexception)

I'm searching for a solution ... it's getting so frustrating.

After a fresh installation of Lumen by Laravel, I simply can't access the "/" route. When I try to, it throws an error:

2016-04-05 21:00:32Z

I'm searching for a solution ... it's getting so frustrating.

After a fresh installation of Lumen by Laravel, I simply can't access the "/" route. When I try to, it throws an error:Got it! .... The solution is to change in public/index.php at line 28:toNo clue why, maybe you know.The problem was solved by changing thein /public/index.php toI had the same problem today.I was accessing it using the url

http://localhost/lumen.api/public/ and I think that was the cause of the error.To get around it, this is what I did:First I configured a new VirtualHost entry on Xampp, located in "C:\xampp\apache\conf\extra\httpd-vhosts.conf" in my case:and restarted Apache on Xampp.Then I edited my hosts file (c:\windows\system32\drivers\etc\hosts) to map a new address to my localhost.I tried again using the new URL http://lumen.api and the error was gone.Probably the .htaccess file was deleted or somehow missing from public folder. Without it the rewrite URL will not work.Check this: https://github.com/laravel/lumen/blob/master/public/.htaccess

Laravel 4 CSRF on all POST requests

Dexty

[Laravel 4 CSRF on all POST requests](https://stackoverflow.com/questions/17329952/laravel-4-csrf-on-all-post-requests)

Been looking into laravel lately, and trying to figure out the CSRF protection that they have. However, i can't get it work. Is there any way i can validate all post request submitted, with the CSRF filter? I've seen that the laravel system has:How would i be able to use this with the CSRF filter? Been trying a few different things likeBut i'm probably way off here.. how would this work? or is it even possible doing it this way?

2013-06-26 20:34:32Z

Been looking into laravel lately, and trying to figure out the CSRF protection that they have. However, i can't get it work. Is there any way i can validate all post request submitted, with the CSRF filter? I've seen that the laravel system has:How would i be able to use this with the CSRF filter? Been trying a few different things likeBut i'm probably way off here.. how would this work? or is it even possible doing it this way?You can use route groups. This will apply the specified options to any routes defined in a group:For certain routes, or if grouping isn't what you want, you can also use a pattern filter:NOTE: this code would go in your routes.php fileThis is the best and the simplest solution:No need to group routes or to mess with constructors.In my BaseController I have this:Having such App::before filter is an interesting approach but I don't know which is better?For some reason puttinginto BaseController.php didn't work for me; I did the test with fake tokens. So i came with the following solution:routes.php:filters.php (csrf filter section):That did the trick for me.This will allow you to apply CSRF to all forms across all pages of your appNote: 'post' is the HTTP POST verb - so it will cover Laravel post, put, delete requests etc.The code you provided only creates the filter. You still need to use it in either your ROUTER or CONTROLLER (even in the basecontroller if need be).In my opinion, using the filter in your ROUTES is the best place to use it.Simply add this to the BaseController.This add the CSRF filter to all post, put, patch and delete request.

Laravel Dusk, how to destroy session data between tests

Inigo

[Laravel Dusk, how to destroy session data between tests](https://stackoverflow.com/questions/44906797/laravel-dusk-how-to-destroy-session-data-between-tests)

I am getting started using Laravel Dusk for browser testing, and have created a couple of tests to test my login form. I have the following code:See the comment. The first function runs fine, but when it comes to the second function, I have to logout first, since the user is already logged in as a result of running the first function. This came as a surprise to me as I thought unit tests were completely independent, with session data being destroyed automatically.Is there a better way of doing this- some Dusk method that I'm missing perhaps- than having to call $browser->visit('/admin/logout'); ?ThanksEDIT Thanks for the 2 answers so far, which both seem valid solutions. I've updated the second function to the following:Which does the job. So

2017-07-04 13:01:36Z

I am getting started using Laravel Dusk for browser testing, and have created a couple of tests to test my login form. I have the following code:See the comment. The first function runs fine, but when it comes to the second function, I have to logout first, since the user is already logged in as a result of running the first function. This came as a surprise to me as I thought unit tests were completely independent, with session data being destroyed automatically.Is there a better way of doing this- some Dusk method that I'm missing perhaps- than having to call $browser->visit('/admin/logout'); ?ThanksEDIT Thanks for the 2 answers so far, which both seem valid solutions. I've updated the second function to the following:Which does the job. SoIn my case, tearDown() was not enough, for some reason, a logged users was still persisted between tests, so I placed deleteAllCookies() at setUp().So, in my DuskTestCase.php I added:It was the only way I could flush up session around all tests. I hope it helps.Note: I'm using Homestead and Windows 10.If you just want to logout your signed in user, after login test, simply use:You could flush the session in a tearDown() method:If in case it helps some one else. You can use tearDown method to clear all cookies. Following is the example of doing so, you can add this method in DuskTestCase.php fileI hope this will help.You can call InteractsWithAuthentication - GithubEdit:This is the behaviour of the Dusk Test case, the primary browser instance remains for the other tests.A second solution, create a second browser instance, which will be destroyed after the single testSee Dusk/TestCase #L103I'm not sure if its the answer you are looking for, but you can create multiple browsers to perform a test that requires clean history/cookies/cache.For example, if you have lots of tests where the user should be logged in and you don't want to log out for only one test that checks reset password form, then you can create an additional browser for this exact case and switch to the previous browser when moving to the next tests.It might look the next way:

Convert hour to PM and AM with Carbon

Sredny M Casanova

[Convert hour to PM and AM with Carbon](https://stackoverflow.com/questions/34228745/convert-hour-to-pm-and-am-with-carbon)

I have a timestamp in PHP, so I'm using Carbon extension to manage everything that is related with date, time,etc. Now I have for example a hour 23:00 or 20:00 with this extension how I can convert that to AM and PM format?

2015-12-11 17:01:33Z

I have a timestamp in PHP, so I'm using Carbon extension to manage everything that is related with date, time,etc. Now I have for example a hour 23:00 or 20:00 with this extension how I can convert that to AM and PM format?I'm not sure if there is a out-of-the-box helper method for this, but you could always use the format method, which defers to the base class method DateTime::format().Example:This will echo out something like 5:17 PM.The g, i, and A can seem random, but the list of parameters can be found here: http://php.net/manual/en/function.date.phpg: 12-hour format of an hour without leading zerosi: Minutes with leading zerosA: Uppercase Ante meridiem and Post meridiem

Can't catch Exception thrown by Carbon

Nathan

[Can't catch Exception thrown by Carbon](https://stackoverflow.com/questions/31248584/cant-catch-exception-thrown-by-carbon)

The following code throws an exception that I can't catch for whatever reason.Now, if I put this in my routes file in a function closure, it works fine. It's only throwing an exception when it's called from the Model.exception 'Exception' with message 'DateTime::__construct(): Failed to parse time string (Summer 2015) at position 0 (S): The timezone could not be found in the database' in /home/vagrant/www/steamcompare/vendor/nesbot/carbon/src/Carbon/Carbon.php:222Has anyone else had this issue with Carbon?

2015-07-06 14:33:04Z

The following code throws an exception that I can't catch for whatever reason.Now, if I put this in my routes file in a function closure, it works fine. It's only throwing an exception when it's called from the Model.exception 'Exception' with message 'DateTime::__construct(): Failed to parse time string (Summer 2015) at position 0 (S): The timezone could not be found in the database' in /home/vagrant/www/steamcompare/vendor/nesbot/carbon/src/Carbon/Carbon.php:222Has anyone else had this issue with Carbon?Immediately after posing the question, I thought of the answer. Since I saw a lot of posts online about a very similar issue, I figured I'd go ahead and answer this one.The issue was namespacing. Carbon was running in a different namespace from my app (obviously) so when I tried to catch (Exception) I was actually trying to catch an exception within my app's namespace. Changing the catch statement to catch (\Exception) resolved it.I hope this helps anyone that ends up on this page.

Function mcrypt_get_iv_size() is deprecated on Laravel 4

cyber8200

[Function mcrypt_get_iv_size() is deprecated on Laravel 4](https://stackoverflow.com/questions/42515368/function-mcrypt-get-iv-size-is-deprecated-on-laravel-4)

I am in L4, here is my app.php I kept gettig How can I prevent that ?

2017-02-28 17:40:07Z

I am in L4, here is my app.php I kept gettig How can I prevent that ?You can use PHP 7 instead of PHP 7.1. Or you can upgrade to Laravel 5 if it's possible. If not, add this to the beginning of the config/app.php:It looks dirty, but I'm afraid there is no a better way to avoid the error at the moment.

How to display Laravel artisan command output on same line?

eComEvo

[How to display Laravel artisan command output on same line?](https://stackoverflow.com/questions/25388430/how-to-display-laravel-artisan-command-output-on-same-line)

I would like to display processing progress using a simple series of dots. This is easy in the browser, just do echo '.' and it goes on the same line, but how do I do this on the same line when sending data to the artisan commandline?Each subsequent call to $this->info('.') puts the dot on a new line.

2014-08-19 16:25:15Z

I would like to display processing progress using a simple series of dots. This is easy in the browser, just do echo '.' and it goes on the same line, but how do I do this on the same line when sending data to the artisan commandline?Each subsequent call to $this->info('.') puts the dot on a new line.The method info uses writeln, it adds a newline at the end, you need to use write instead.Probably a little bit of topic, since you want a series of dots only. But you can easily present a progress bar in artisan commands using built in functionality in Laravel.Declare a class variable like this:And initialize the progress bar like this, lets say in fire() method:And then do something like this:And finilize the progress when done by calling this:Update: For Laravel 5.1+ The simpler syntax is even more convenient:If you look at the source, you will see that $this->info is actually just a shortcut for $this->output->writeln: Source.You could use $this->output->write('<info>.</info>') to make it inline.If you find yourself using this often you can make your own helper method like:

How to customize the email verification email from Laravel 5.7?

Wayne Fulcher

[How to customize the email verification email from Laravel 5.7?](https://stackoverflow.com/questions/52416804/how-to-customize-the-email-verification-email-from-laravel-5-7)

I just upgraded to Laravel 5.7 and now I am using the built in Email Verification. However there is 2 things I have not been able to figure out and the primary issue is how can I customize the email that is being sent to the user for verifying their email? I also can't figure out how to initiate sending that email if the users changes their email but I can save that for another thread.

2018-09-20 02:42:23Z

I just upgraded to Laravel 5.7 and now I am using the built in Email Verification. However there is 2 things I have not been able to figure out and the primary issue is how can I customize the email that is being sent to the user for verifying their email? I also can't figure out how to initiate sending that email if the users changes their email but I can save that for another thread.When you want to add Email Verification in Laravel 5.7 the suggested method is to implement Illuminate\Contracts\Auth\MustVerifyEmail and use the Illuminate\Auth\MustVerifyEmail trait on the App\User Model.To make some custom behaviour you can override the method sendEmailVerificationNotification which is the method that notifies the created user by calling the method notify, and passes as a parameter a new instance of the Notifications\MustVerifyEmail class.You can create a custom Notification which will be passed as a parameter to the $this->notify() within the sendEmailVerificationNotification method in your User Model:...then in your CustomVerifyEmail Notification you can define the way the verification will be handled. You can notify created user by sending an email with a custom verification.route which will take any parameters that you want.Email verification notification processWhen a new user signs-up an Illuminate\Auth\Events\Registered Event is emitted in the App\Http\Controllers\Auth\RegisterController and that Registered event has a listener called Illuminate\Auth\Listeners\SendEmailVerificationNotification which is registered in the App\Providers\EventServiceProvider:The SendEmailVerificationNotification listener checks if the $user – which is passed as a parameter to new Registered($user = $this->create($request->all())) in the Laravel default authentication App\Http\Controllers\Auth\RegisterController – is an instance of Illuminate\Contracts\Auth\MustVerifyEmail which is the name of the trait that Laravel suggests is used in the App\User Model when you want to provide default email verification and also check that $user is not already verified. If all that passes, the sendEmailVerificationNotification method is called on that user:I think the simple way to do this is to make a new notification using the docs here: https://laravel.com/docs/5.7/notifications#creating-notificationsThen override the function:In the users model.Or you can This will copy the templates to the resources/views/vendor/notifications directory and you can modify them thereUnfortunately this email that is sent out is not from a "view", it is a Notification that is built inline actually. This is where it is currently built when needing to be sent off: Illuminate\Auth\Notifications\VerifyEmail@toMail. This particular class has a static callback that can be set to build this email instead of letting it do it.In a Service Provider in the boot method you will need to assign a callback for this class:Something "like" this might work:As this is a notification you should have more options on customizing it.If you want to use your own Notification class you can override the sendEmailVerificationNotification method on the User (Authenticatable) model (this is from the MustVerifyEmail trait).Second Question:The VerificationController (App\Http\Controllers\Auth\VerificationController) that you should have has a method named resend (from the trait VerifiesEmails) that looks like a good candidate for this purpose.You should have routes setup for these verification routes via Auth::routes(['verify' => true]);Note:The verification system uses a field on the users table email_verified_at in 5.7 to mark this. You would want to make sure you have this field. When the user changes email address I suppose you could make this null then redirect them to the resend route, to send off the new verification. This will put them into an "unverified" state though until they reverify, if that is what you intend to happen.Update:Seems we were going down the right track. I found this SO answer that goes over similar things:Changing the default「subject」field for the verification email in laravel 5.7For quick and easy way: It's creating a new file in: This is Laravel's email themplate. You can change and customize it.Building slightly on the answer by Andrew Earls, you can also publish all the markdown mail components used by the application with this command: php artisan vendor:publish --tag=laravel-mailOnce that's done you'll have a series of html and markdown files to modify in resources/views/vendor/mail. This will allow you to modify the overall email layout and also 'theme' the CSS. I'd highly recommend having a good read of the Mail docs - Customizing The Components.As a general email theming quick-start (Laravel 5.7), you can: Hope that helps someone. To send verification email you can just use the next code: Navigate to these filesand then customize it.

you can even introduce a constructor in 

vendor/laravel/framework/src/Illuminate/Auth/Notifications/VerifyEmail.php 

and pass value through vendor/laravel/framework/src/Illuminate/Auth/MustVerifyEmail.phpeg:

Laravel : Calling functions defined in base_controller from view

Jim

[Laravel : Calling functions defined in base_controller from view](https://stackoverflow.com/questions/13481136/laravel-calling-functions-defined-in-base-controller-from-view)

In using the laravel framework, how can I call a function defined in base_controller, in a view.  For exacmple:How can i call format_something() in a view file?Usually the error I get looks something like this:

    Method [link_to_action] is not defined on the View class.Probably a silly question, but thanks in advance!EditOkay! First the correct place to do something like this is in the libraries folder.

Second, problem is that your class cannot have underscores.So in application/libraries I made file AppHelper.php with classAnd can call it like:Thanks for the help and the good forum find Boofus McGoofus.

2012-11-20 20:01:15Z

In using the laravel framework, how can I call a function defined in base_controller, in a view.  For exacmple:How can i call format_something() in a view file?Usually the error I get looks something like this:

    Method [link_to_action] is not defined on the View class.Probably a silly question, but thanks in advance!EditOkay! First the correct place to do something like this is in the libraries folder.

Second, problem is that your class cannot have underscores.So in application/libraries I made file AppHelper.php with classAnd can call it like:Thanks for the help and the good forum find Boofus McGoofus.This answer was written for Laravel 3. For Laravel 4 and after, Lajdák Marek's answer using Composer's autoloader is better.Functions like format_something() don't belong in the controller.  The controller should just be about collecting data from various sources and passing it to the view. It's job is mostly just routing.I've created a folder called "helpers" in the application folder for all my little helpery functions.  To make sure all my controllers, views, and models have access to them, I've included the following in my start.php file:I suspect that there's a better way to do that, but so far it has worked for me.For me is working:Create directory "helpers" or whatever and file:Add path to composer.jsonRun: (reload the autoload)Now you can call: You can inspire yourself from Laravel framework itself.I will take your example of a formatter and refer to url helper in Laravel Framework.Start by creating your own helpers.php file:And add it to your composer.json file:Run this command to recreate the autoload php file:Create your service provider app/Providers/FormatterServiceProvider.php:Register your service provider. Laravel framework invokes register method but you only need to add it to your app config file config/app.php:Finally, create your actual generator class app/Helpers/FormatGenerator.phpYou can optionally create a Facade app/Facade/Formatter.php, to be able to do Formatter::format_that($text):You could ask yourself:

Laravel 4 - Route::resource vs Route::controller. Which to use?

Gravy

[Laravel 4 - Route::resource vs Route::controller. Which to use?](https://stackoverflow.com/questions/19102534/laravel-4-routeresource-vs-routecontroller-which-to-use)

I understand that a Resource controller can have the following methodsNow suppose I have the following actions which need to be performed in addition to the resource actions:Are resource controllers useless for the above functionality? If programming an API, I obviously want the index, show, edit,create,destroy... but also the login, find, search etc...Is it possible to route to both types of controller? e.g.Or should I just forget about the resource controller and use a restful controller instead?

2013-09-30 19:48:13Z

I understand that a Resource controller can have the following methodsNow suppose I have the following actions which need to be performed in addition to the resource actions:Are resource controllers useless for the above functionality? If programming an API, I obviously want the index, show, edit,create,destroy... but also the login, find, search etc...Is it possible to route to both types of controller? e.g.Or should I just forget about the resource controller and use a restful controller instead?Just use a resource controller, add those other methods to that same controller, and add routes to those methods directly:P.S. I generally shy away from using Route::controller(). It's too ambiguous.one of the problems associated with resource controllers are when you are using named routes, with group prefixes it all turns out into a big mess . if you want to make a small change in your prefix, you have to make changes throughout the views and controllers . ie you can't make full power of named routes.i follow this model when developing my laravel apps .  so that i have the following advantages .and i can generate urls comfortably using the syntax,even if i make a change in prefix or resource names urls are not affected 

Detect changes when saving Laravel 4: Eloquent

Karl

[Detect changes when saving Laravel 4: Eloquent](https://stackoverflow.com/questions/20179711/detect-changes-when-saving-laravel-4-eloquent)

I'm using the Laravel 4 framework and I am trying to work out a way to display notifications depending on whether a save() was successful or not. Here's what I have so far:My problem is that it always returns true when a user is saved, even if no changes have been made to the database (I know this from the updated_at timestamp). Is there a way to detect whether any changes have actually been made or not using Laravel?

2013-11-24 19:15:58Z

I'm using the Laravel 4 framework and I am trying to work out a way to display notifications depending on whether a save() was successful or not. Here's what I have so far:My problem is that it always returns true when a user is saved, even if no changes have been made to the database (I know this from the updated_at timestamp). Is there a way to detect whether any changes have actually been made or not using Laravel?Depending on what you want to achieve, you have some options here. Check out the below first.Model Hooks with Ardent package 

If you are interested in autovalidating models, take a look at the https://github.com/laravelbook/ardent package - Self-validating smart models for Laravel Framework 4's Eloquent O/RM. Apart form great validation features it offers additional model hooks you can use: Laravel Model Events 

If you dont want to use any additional stuff, you can just use the Laravel Model Events (that in fact Ardent is wrapping in the hooks). Look into the docs http://laravel.com/docs/eloquent#model-events Solution

Finally, reffering to you question you can utilize the above approaches in numerous ways but most obviously you can combine it (or not) with the Eloquent Models' getDirty() api docs here method. It will work for example with the saving event. You can take a look at the getDirty() method in the Eloquent model (model.php). 

This method should return the changed attributes.

Laravel hasManyThrough

Greg

[Laravel hasManyThrough](https://stackoverflow.com/questions/24994640/laravel-hasmanythrough)

I'm struggling to get my head around a hasManyThrough concept with laravel.

I have three tables:What I am trying to get is an Eloquent model that allows me to have a single booking record with multiple Meta records of type MetaType. I thought that hasManyThrough might have solved this, but now I am thinking that perhaps this is not the best way.In my booking model I haveBut this fails to generate the correct SQL and fails. I getWhereas what I am really trying to achieve isIf anyone can point me in the right direction I'd really appreciate it. Thanks.

2014-07-28 11:51:44Z

I'm struggling to get my head around a hasManyThrough concept with laravel.

I have three tables:What I am trying to get is an Eloquent model that allows me to have a single booking record with multiple Meta records of type MetaType. I thought that hasManyThrough might have solved this, but now I am thinking that perhaps this is not the best way.In my booking model I haveBut this fails to generate the correct SQL and fails. I getWhereas what I am really trying to achieve isIf anyone can point me in the right direction I'd really appreciate it. Thanks.hasManyThrough is not the way at all. It works only for relations like this:What you have here is a many to many (belongsToMany), with meta being the pivot table.So you can do this (assuming meta is table name, Booking and MetaType are models):Then you can access all associated MetaType:query it like this (eager loading):or set constraints on the related table to filter the Booking:Note: wherePivot works only when you eager load the relationship, so you can't use it in whereHas closure.

What does isDirty() mean in Laravel?

shay.k

[What does isDirty() mean in Laravel?](https://stackoverflow.com/questions/28836013/what-does-isdirty-mean-in-laravel)

First of all, I am not familiar with Laravel so much (or with the term "dirty" for that matter).

I stumbled upon this line of code - And I couldn't understand what that means exactly. I tried to find out on the internet but the Laravel site only says thiswhich doesn't really help...

2015-03-03 15:49:48Z

First of all, I am not familiar with Laravel so much (or with the term "dirty" for that matter).

I stumbled upon this line of code - And I couldn't understand what that means exactly. I tried to find out on the internet but the Laravel site only says thiswhich doesn't really help...When you want to know if the model has been edited since it was queried from the database, or isn't saved at all, then you use the ->isDirty() function.As support for the accepted answer:

Chain commands in Laravel Artisan Scheduler?

wkm

[Chain commands in Laravel Artisan Scheduler?](https://stackoverflow.com/questions/29825483/chain-commands-in-laravel-artisan-scheduler)

Suppose I have three commands I want to schedule:

'commandA', 'commandB', and 'commandC'But I don't want to run 'commandB' until 'commandA' is complete and I don't want to run 'commandC' until 'commandB' is complete.I know I can schedule each to run every five minutes:But is it possible to chain them one after the other?

2015-04-23 13:48:59Z

Suppose I have three commands I want to schedule:

'commandA', 'commandB', and 'commandC'But I don't want to run 'commandB' until 'commandA' is complete and I don't want to run 'commandC' until 'commandB' is complete.I know I can schedule each to run every five minutes:But is it possible to chain them one after the other?Use then(Closure $callback) to chain commands:

Class 'App\Http\Controllers\Excel' not found in Laravel

Lulzim

[Class 'App\Http\Controllers\Excel' not found in Laravel](https://stackoverflow.com/questions/30155145/class-app-http-controllers-excel-not-found-in-laravel)

In my controller I have the code as below:In config/app.php in aliases array i have defined this:I dont know why i cant make it work this library...

Any idea?

2015-05-10 18:31:42Z

In my controller I have the code as below:In config/app.php in aliases array i have defined this:I dont know why i cant make it work this library...

Any idea?Instead of Excel::create you should use \Excel::create or add at the beginning of your file after current namespace use Excel; and then you will be able to use Excel::createAnd the second error is that you used:and you should use:instead according to the docs.Sometimes, clearing configuration cache makes it workphp artisan config:cacheThis should work after all you have followed all the instruction correctly but still getting "Class 'App\Http\Controllers\Excel' not found in Laravel" errorAfter all this you need to check whether or not you have this at the top:

use DELETE method in route with Laravel 5.4

Needlle

[use DELETE method in route with Laravel 5.4](https://stackoverflow.com/questions/44113969/use-delete-method-in-route-with-laravel-5-4)

I'm working on a Laravel (v 5.4) project and i did the CRUD to manage categories. Currently, i can create a new category and i would be able to delete.I created the view (with blade) to delete the categories :And in the routing file web.php, i wrote :I have a controller CategoryController with a method destroy() who delete category and redirect to list of categories. But when i click on the button to delete, i get an error that explain this route is not define. If i replace Route::delete with Route::get it works. I think the url is called with GET but i would keep that for an other action.I tried to replace the link with a form and "DELETE" as the value of "method" attribute but it didn't work.How can i call url with DELETE method to catch it with Route::delete ?Thanks in advance.

2017-05-22 13:18:53Z

I'm working on a Laravel (v 5.4) project and i did the CRUD to manage categories. Currently, i can create a new category and i would be able to delete.I created the view (with blade) to delete the categories :And in the routing file web.php, i wrote :I have a controller CategoryController with a method destroy() who delete category and redirect to list of categories. But when i click on the button to delete, i get an error that explain this route is not define. If i replace Route::delete with Route::get it works. I think the url is called with GET but i would keep that for an other action.I tried to replace the link with a form and "DELETE" as the value of "method" attribute but it didn't work.How can i call url with DELETE method to catch it with Route::delete ?Thanks in advance.If you click on an url it will always be a GET method.Since you wish to define it as DELETE, you should remake it into a post form and addin it. Like replace:with:Same goes for PUT request.Since Laravel 5.1 method_field:Since Laravel 5.6 just with @ tag:Any method other than GET and POST  requires you to specify the method type using a hidden form input. That's how laravel detects them. In your case you need to send the delete action using a form. Do this.For laravel 5.7 please look my example:

Composite keys laravel schema builder

Can Geliş

[Composite keys laravel schema builder](https://stackoverflow.com/questions/17065112/composite-keys-laravel-schema-builder)

I need two composite primary keys and only one should be AUTO INCREMENT what I tried so far:None works. Error message:[Exception]

  SQLSTATE[42000]: Syntax error or access violation: 1068 Multiple primary ke

  y defined (SQL: alter tablekitchenadd primary key kitchen_restaurant_id

  _primary(restaurant_id)) (Bindings: array (

  ))       The solution without Schema builder: first, I need to add two composite primary keys and then I need to make one of the AUTO INCREMENT but I think Schema builder can't do this.Note: I can do this with SQL, I mean no problem with MySQLAny suggestions?   Summary:What I need is;http://oi39.tinypic.com/es91ft.jpgwith Schema builder

2013-06-12 12:08:32Z

I need two composite primary keys and only one should be AUTO INCREMENT what I tried so far:None works. Error message:[Exception]

  SQLSTATE[42000]: Syntax error or access violation: 1068 Multiple primary ke

  y defined (SQL: alter tablekitchenadd primary key kitchen_restaurant_id

  _primary(restaurant_id)) (Bindings: array (

  ))       The solution without Schema builder: first, I need to add two composite primary keys and then I need to make one of the AUTO INCREMENT but I think Schema builder can't do this.Note: I can do this with SQL, I mean no problem with MySQLAny suggestions?   Summary:What I need is;http://oi39.tinypic.com/es91ft.jpgwith Schema builderYou can do this with a little help from the unprepared method:This is tested, and works!I know it's a little late, and you might have moved on, but someone else might come across this :)Eloquent's increments() sets the column as an unsigned integer.  With that in mind you have multiple way of achieving your desired composite keys.You could use either interger() or unsignedInteger() and setting the autoIncrements to true:Then you could tell Eloquent which are your primary keys via primary().Your Schema::create() should look like this:Assuming your Restaurant table is using $table->increments('id') this should make 'id' and 'restaurant_id' your primary keys while also matching 'restaurant_id' to the Restaurant table 'id'.It makes no sense to have the autoincrement as part of a composite primary key as it will be unique for every record anyway.

If you want an autoincrement primary key and a unique composite key on eg 2 other columns such as 'restaurant_id' and 'name':It seems you've hit something that is not currently possible with Laravel, since ->increments() already sets ->primary() , so when you add it yourself you end up with two PRIMARY clauses in the resulting SQL.But you may want to try creating the table with the wrong primary key, dropping it, then recreating it:Another option from Dayle Rees

How can I get the return value of a Laravel chunk?

Citizen

[How can I get the return value of a Laravel chunk?](https://stackoverflow.com/questions/26026795/how-can-i-get-the-return-value-of-a-laravel-chunk)

Here's an over-simplified example that doesn't work for me. How (using this method, I know there are better ways if I were actually wanting this specific result), can I get the total number of users?This returns NULL. Any idea how I can get a return value from the chunk function?Edit:Here might be a better example:

2014-09-24 21:25:49Z

Here's an over-simplified example that doesn't work for me. How (using this method, I know there are better ways if I were actually wanting this specific result), can I get the total number of users?This returns NULL. Any idea how I can get a return value from the chunk function?Edit:Here might be a better example:I don't think you can achieve what you want in this way. The anonymous function is invoked by the chunk method, so anything you return from your closure is being swallowed by chunk. Since chunk potentially invokes this anonymous function N times, it makes no sense for it to return anything back from the closures it invokes.However you can provide access to a method-scoped variable to the closure, and allow the closure to write to that value, which will let you indirectly return results. You do this with the use keyword, and make sure to pass the method-scoped variable in by reference, which is achieved with the & modifier.This will work for example;

Overwrite laravel 5 helper function

guidsen

[Overwrite laravel 5 helper function](https://stackoverflow.com/questions/28474640/overwrite-laravel-5-helper-function)

I'm using the response() helper very often and I just return the data with a message to the user. Now I have to include the http status code as well, but I don't want to change every response (which is likely bad anyway).So I'm trying to overwrite the response() helper function by creating my own helpers.php within app/Http/helpers.php. When I add it to my composer files, it does autoload the current helpers.php from the framework first and when I add it before the autload include in bootstrap/global.php I wont be able to use the app() and other Laravel functions.How would I be able to solve this issue? I just want to include the status code as well in the response array.

2015-02-12 10:10:01Z

I'm using the response() helper very often and I just return the data with a message to the user. Now I have to include the http status code as well, but I don't want to change every response (which is likely bad anyway).So I'm trying to overwrite the response() helper function by creating my own helpers.php within app/Http/helpers.php. When I add it to my composer files, it does autoload the current helpers.php from the framework first and when I add it before the autload include in bootstrap/global.php I wont be able to use the app() and other Laravel functions.How would I be able to solve this issue? I just want to include the status code as well in the response array.All Laravel helper functions written with this logicfor first Laravel check is this function exists, if it exists, Laravel will not define this function again(otherwise it will throw fatal error).

So if you will define your function before autoloader include  vendor/laravel/framework/src/Illuminate/Foundation/helpers.php file, 

you can define your custom response function.Unfortunately there is no way to say composer load first your autoload.files section, then laravel autoload.files. But you can do small hack ...open bootstrap/autoload.php file and include your file before autoloaderI've just had to do this in order to override the now() helper so I can control the apparent time when running tests. I followed the regular advice of creating app/Http/helpers.php and then adding it to bootstrap/autoload.php like so:This usually works because as Marty says, all helpers are only defined if there's not an existing function with that name. So the two lines above load your custom helpers, then perform all vendor autoloading, which includes Laravel's helpers, and your already-defined function takes precedence.But unfortunately, autoload.php doesn't seem to be used when testing with Behat, which is what I'm using. So I needed an alternative solution. Long story short, the only easy way to ensure that files get autoloaded before vendor files is by using the https://github.com/funkjedi/composer-include-files package. To quote from its readme:So I installed this package using composer require funkjedi/composer-include-files and then added this to composer.json:Once that's done, run composer dump-autoload to regenerate the autoload files. Now the overrides work both during regular app operation, and when running tests!I'm not going to directly answer your question since I don't know if there's a solution (without changing Laravels helpers.php or renaming your function)However there is a solution from the framework for this common use case. Response MacrosYou can define a macro (this is done in a service provider)And you can use it like this:

Dynamic Routing in Laravel 5 Application

Becky

[Dynamic Routing in Laravel 5 Application](https://stackoverflow.com/questions/33003097/dynamic-routing-in-laravel-5-application)

I am hoping that someone can help me out with dynamic routing for urls that can have multiple segments. I've been doing some searching all over the web, but nothing I find helps me out with my specific situation.A little background ... several years ago, I developed a CMS package for custom client websites that was built on CodeIgniter. This CMS package has several modules (Pages, Blog, Calendar, Inquiries, etc). For the Pages module, I was caching the routes to a "custom routes" config file that associated the full route for the page (including parent, grandparent, etc) with the ID of the page. I did this so that I didn't have to do a database lookup to find the page to display.I am currently working on rebuilding this CMS package using Laravel (5.1) [while I'm learning Laravel]. I need to figure out the routing situation before I can move on with my Pages module in the new version of the package.I know that I can do something like ...And this would work if I didn't allow nested pages, but I do. And I only enforce uniqueness of the slug based on the parent. So there could be more than one page with a slug of fargo ... As with the package that I built using CodeIgniter, I would like to be able to avoid extra database lookups to find the correct page to display.My initial thought was to create a config file that would have the dynamic routes like I did with the old version of the system. The routes will only change at specific times (when page is created, when slug is modified, when parent is changed), so "caching" them would work great. But I'm still new to Laravel, so I'm not sure what the best way to go about this would be. I did manage to figure out that the following routes work. But is this the best way to set this up?Basically, I would like to bind a specific route to a specific page ID when the page is created (or when the slug or parent are changed).Am I just overcomplicating things?Any help or direction regarding this would be greatly appreciated.Thanks!

2015-10-07 21:57:48Z

I am hoping that someone can help me out with dynamic routing for urls that can have multiple segments. I've been doing some searching all over the web, but nothing I find helps me out with my specific situation.A little background ... several years ago, I developed a CMS package for custom client websites that was built on CodeIgniter. This CMS package has several modules (Pages, Blog, Calendar, Inquiries, etc). For the Pages module, I was caching the routes to a "custom routes" config file that associated the full route for the page (including parent, grandparent, etc) with the ID of the page. I did this so that I didn't have to do a database lookup to find the page to display.I am currently working on rebuilding this CMS package using Laravel (5.1) [while I'm learning Laravel]. I need to figure out the routing situation before I can move on with my Pages module in the new version of the package.I know that I can do something like ...And this would work if I didn't allow nested pages, but I do. And I only enforce uniqueness of the slug based on the parent. So there could be more than one page with a slug of fargo ... As with the package that I built using CodeIgniter, I would like to be able to avoid extra database lookups to find the correct page to display.My initial thought was to create a config file that would have the dynamic routes like I did with the old version of the system. The routes will only change at specific times (when page is created, when slug is modified, when parent is changed), so "caching" them would work great. But I'm still new to Laravel, so I'm not sure what the best way to go about this would be. I did manage to figure out that the following routes work. But is this the best way to set this up?Basically, I would like to bind a specific route to a specific page ID when the page is created (or when the slug or parent are changed).Am I just overcomplicating things?Any help or direction regarding this would be greatly appreciated.Thanks!The way I handle this is to use two routes, one for the home page (which generally contains more complex logic like news, pick up articles, banners, etc), and a catch all for any other page.The important part to note in the above is the ->where() method chained on the end of the route. This allows you to declare regex pattern matching for the route parameters. In this case I am allowing alphanumeric characters, hyphens and forward slashes for the {slug} parameter.This will match slugs like

test-page

test-page/sub-page

another-page/sub-page   I keep the template file information in the database, as I allow users to create templates in the content management system.The response from the query on the database is then passed to the view where it can be output to the metadata, page, breadcrumbs, etc.I was also looking for the same answer that is about creating a dynamic routing in laravel i come up with this:

In routes.phpExif you have PostController with method hello in laravel. You can use this url http://localhost/shortproject/public/post/hello. Where shortproject is your project folder name.

Laravel 5 console (artisan) command unit tests

bernie

[Laravel 5 console (artisan) command unit tests](https://stackoverflow.com/questions/34814954/laravel-5-console-artisan-command-unit-tests)

I am migrating my Laravel 4.2 app to 5.1 (starting with 5.0) and am a lot of trouble with my console command unit tests. I have artisan commands for which I need to test the produced console output, proper question/response handling and interactions with other services (using mocks). For all its merits, the Laravel doc is unfortunately silent with regards to testing console commands.I finally found a way to create those tests, but it feels like a hack with those setLaravel and setApplication calls.Is there a better way to do this? I wish I could add my mock instances to the Laravel IoC container and let it create the commands to test with everything properly set. I'm afraid my unit tests will break easily with newer Laravel versions.Here's my unit test:Use statements:SetupInput provided as command arguments. Checks console outputInput provided by simulated keyboard keys

2016-01-15 15:54:25Z

I am migrating my Laravel 4.2 app to 5.1 (starting with 5.0) and am a lot of trouble with my console command unit tests. I have artisan commands for which I need to test the produced console output, proper question/response handling and interactions with other services (using mocks). For all its merits, the Laravel doc is unfortunately silent with regards to testing console commands.I finally found a way to create those tests, but it feels like a hack with those setLaravel and setApplication calls.Is there a better way to do this? I wish I could add my mock instances to the Laravel IoC container and let it create the commands to test with everything properly set. I'm afraid my unit tests will break easily with newer Laravel versions.Here's my unit test:Use statements:SetupInput provided as command arguments. Checks console outputInput provided by simulated keyboard keysI have done this before as follows - my console command returns a json response:So if you want to put this in it's own command tester class, or as a function within TestCase etc... up to you.

Dynamic partial arguments in AngularJS routing

Ali

[Dynamic partial arguments in AngularJS routing](https://stackoverflow.com/questions/39727540/dynamic-partial-arguments-in-angularjs-routing)

I'm working with an angularjs site and have a background with working with routes in Rails and also Laravel in php. With routes in Laravel we could dynamically create a set of routes similar to:Here we defined series of seperate routes in Laravel which technically do look the same except for the value of city and slug.I'm finding angularJS a bit limited in defining routes in this case. Frankly am a bit lost here.I've made some modifications here - basically I set up a service which retrieves assets from my database such as in this case a list of cities and categories. I'm trying to do this:If {slug} is in the array of categories retrieved from my API, then use my ListController and list view but if its not then instead use my SingleVenueController and single view. Here's my code at the moment but its not working :(In the above sharedParams is a service and the getCurrentPageType just checks the url slug to decide what controller to send back - but its not really working at all :(

2016-09-27 14:36:40Z

I'm working with an angularjs site and have a background with working with routes in Rails and also Laravel in php. With routes in Laravel we could dynamically create a set of routes similar to:Here we defined series of seperate routes in Laravel which technically do look the same except for the value of city and slug.I'm finding angularJS a bit limited in defining routes in this case. Frankly am a bit lost here.I've made some modifications here - basically I set up a service which retrieves assets from my database such as in this case a list of cities and categories. I'm trying to do this:If {slug} is in the array of categories retrieved from my API, then use my ListController and list view but if its not then instead use my SingleVenueController and single view. Here's my code at the moment but its not working :(In the above sharedParams is a service and the getCurrentPageType just checks the url slug to decide what controller to send back - but its not really working at all :(How about defining a single route with a paramater ?

In angularjs v1.x you can defined as many routes you want with as many params xor queryref: https://docs.angularjs.org/api/ngRoute/service/$routeYou can do it with separate routes. The idea is when user hits the main route it resolves first with the data from the backend. If the condition is met, resolve function will redirect to specific route if not it wont passServices in Angular cannot be injected in the configuration phase since they become available only in the run phase of an Angular application.There is however a trick to load $http service in the config phase which you can use to load your cities/categories and set up your routes. Meanwhile, since controllers aren't registered up until the run phase, you may use the $controllerProvider to register your controllers beforehand in the configuration phase:You can now call your API to get the cities (or whatever else) and iterate while registering each route:Note that I'm using the getTemplate and the getController methods which return the templateUrl and the relevant controller name strings respectively using an ordinary switch expression. You can choose your own approach.Note:While a function with the templateUrl route options property does work with setting up a custom template, but when you use a function alongside the controller property, Angular will consider it as the constructor for the controller. Therefore, returning the name of the controller in that function won't work.As Ahmad has already pointed out in his answer, if you pass a function to controller it is considered as a constructor for the controller. 

Also you can't get a service injected dynamically in config block of your app.So what you can do is, move your sharedData service in separate app (in my code below I've used appShared as a separate app where this service is defined) and then access it using angular.injector. This way you don't have to define it as a parameter to templateUrl / controller functions.Btw, you can't pass custom parameters to templateUrl function (ref: https://docs.angularjs.org/api/ngRoute/provider/$routeProvider)Now for the controller, use $controller to dynamically load either ListsController or SingleController based on your condition.

Once that is loaded, extend your current controller (defined by your controller function) using angular.extend so that it inherits all the properties and methods of the dynamically loaded controller.Check the complete code here: http://plnkr.co/edit/ORB4iXwmxgGGJW6wQDy9

Optional parameter in the middle of a route

rap-2-h

[Optional parameter in the middle of a route](https://stackoverflow.com/questions/31584302/optional-parameter-in-the-middle-of-a-route)

Is there any way to add an optional parameter in the middle of a route ? Example routes:I tried this, but it does not work:I know I can do this...... but my question is:  Can I add an optional parameter in the middle of a route?

2015-07-23 10:10:31Z

Is there any way to add an optional parameter in the middle of a route ? Example routes:I tried this, but it does not work:I know I can do this...... but my question is:  Can I add an optional parameter in the middle of a route?No. Optional parameters need to go to the end of the route, otherwise Router wouldn't know how to match URLs to routes. What you implemented already is the correct way of doing that:You could try doing it with one route:and pass * or 0 if you want to fetch entities for all things, but I'd call it a hack.There are some other hacks that could allow you to use one route for that, but it will increase the complexity of your code and it's really not worth it.Having the optional parameter in the middle of the route definition like that, will only work when the parameter is present. Consider the following:So you'll have to go with the separate route definition approach.The "correct" answer for this question is; No, you can't and shouldn't use an optional parameter unless it's at the end of the route/url.But, if you absolutely need to have an optional parameter in the middle of a route, there is a way to achieve that. It's not a solution I would recommend, but here you go:routes/web.php:app/Http/Controllers/Pages/TestController.php:resources/views/test.blade.php:Both links will trigger the first-method in TestController. The second-method will never be triggered.This solution works in Laravel 6.3, not sure about other versions. And once again, this solution is not good practice.

Why should Client Creadentials be associated with a user in Laravel Passport?

Meena Alfons

[Why should Client Creadentials be associated with a user in Laravel Passport?](https://stackoverflow.com/questions/43706309/why-should-client-creadentials-be-associated-with-a-user-in-laravel-passport)

I want to use Client Credentials to authenticate client applications to access the API.My problem is with creating client credentials. Using php artisan passport:client requires me to enter a user_id to associate the client to that user. I don't get it. Why the client application has to be associated to a user?! Or Is there another way?passport:client command only supports creating Password Grant Clients and Personal Grant Client. I don't think that any of them is what I need.What I really need is to create client credentials that will only be used by the client application to authorize itself to access some APIs. How to do that?

2017-04-30 12:23:02Z

I want to use Client Credentials to authenticate client applications to access the API.My problem is with creating client credentials. Using php artisan passport:client requires me to enter a user_id to associate the client to that user. I don't get it. Why the client application has to be associated to a user?! Or Is there another way?passport:client command only supports creating Password Grant Clients and Personal Grant Client. I don't think that any of them is what I need.What I really need is to create client credentials that will only be used by the client application to authorize itself to access some APIs. How to do that?I assume you want to use machine-to-machine authentication (no user interactions)I would recommend to read through the docs a couple of times to get the hang of it.I do not believe there is an specific way to create an only client credentials client, What i do is to create an personal client then change the field for personal client in the database personal_access_client 1 => 0You could use the personal client option, as seen from the --help optionphp artisan passport:client --personaloutput You would need to use another middleware other then the default one because there is no user present when using this methodClass \App\Http\Kernel:

Class \App\Http\Controllers\ApiTestController:

From php artisan route:listFollowing the specified request in the documentation on client-credentials-grant-tokensI use Postman for simplicity, easily send test request with Postman (www.getpostman.com)Set authorization to OAuth 2.0, image: Postman authenticationSet access token URL, client id, client secret and grant type to 'Client Credentials', image: Postman OAuth FieldsPostman creates an token and appends it to URL or Header, in this case headerResponse:I was gonna comment but I don't have enough reputation yet =pYou could give the command a name parameter that won't require any user input. As far as how you would get that client secret over to your client without manual intervention is where the real wizardry would come in. That command would still give you:as expected.

Many-to-Many Eloquent relationship update with Laravel Form Model Binding & Checkboxes

Yev

[Many-to-Many Eloquent relationship update with Laravel Form Model Binding & Checkboxes](https://stackoverflow.com/questions/20179473/many-to-many-eloquent-relationship-update-with-laravel-form-model-binding-chec)

I have 3 tables:doorscolorsdoor_colorsand 2 models with a many-to-many relationship (each door comes in a variety colors, and many colors overlap door-to-door):Door ModelColor ModelI want to create a form where I can edit the door, and update the available colors via checkboxes.

This is my Admin Doors Controllerand the Admin Doors Form ViewQuestion 1: How do I make it so that as the checkboxes are outputted, the ones with an existing relationship with the current door are checked and the ones without are unchecked.Question 2: Once I check the boxes and hit submit, how would I update the relationships? $door->colors()->detach(); to clear all existing ones for this door, then $door->colors()->attach($color_id_array); to create new ones based on an array of color ids?Any input is appreciated!

2013-11-24 18:55:17Z

I have 3 tables:doorscolorsdoor_colorsand 2 models with a many-to-many relationship (each door comes in a variety colors, and many colors overlap door-to-door):Door ModelColor ModelI want to create a form where I can edit the door, and update the available colors via checkboxes.

This is my Admin Doors Controllerand the Admin Doors Form ViewQuestion 1: How do I make it so that as the checkboxes are outputted, the ones with an existing relationship with the current door are checked and the ones without are unchecked.Question 2: Once I check the boxes and hit submit, how would I update the relationships? $door->colors()->detach(); to clear all existing ones for this door, then $door->colors()->attach($color_id_array); to create new ones based on an array of color ids?Any input is appreciated!Question 1: You should pass this into the view that contains your form, though it can also go right in the view, though that's not really best practice.  Do something similar to this......where the door you are finding is the door that's being updated.  Then before you output the checkbox in the loop, add Then you would change to Question 2:  There is actually a perfect method given to you for this.  Use It will both delete the old ones and add all the new ones in one shot.Suppose you are modeling user and role and want to edit user with roles. In your controller edit, In your template if you use select,In your controller update,

Laravel File Storage delete all files in directory

ßiansor Å. Ålmerol

[Laravel File Storage delete all files in directory](https://stackoverflow.com/questions/47007356/laravel-file-storage-delete-all-files-in-directory)

Is there a way to delete all files in specific directory. I'm trying to clear all my files in my created folder backgrounds in storage\app\backgrounds but in docs seems no method for delete all.

2017-10-30 02:28:20Z

Is there a way to delete all files in specific directory. I'm trying to clear all my files in my created folder backgrounds in storage\app\backgrounds but in docs seems no method for delete all.I don't think if this is the best way to solve this. But I solved mine callingThen initiate new instanceYou can use Filesystem method cleanDirectoryPlease see documentation for more information:https://laravel.com/api/5.5/Illuminate/Filesystem/Filesystem.html#method_cleanDirectoryIn Laravel 5.8 you can use:Remember to include:In Laravel 5.7 you can empty a directory using the Storage facade like so:The delete() method can receive an array of files to delete, while deleteDirectory() deletes one directory (and its contents) at a time.I don't think it's a good idea to delete and then re-create the directory as that can lead to unwanted race conditions.Just use it.I'm handling this by deleting the whole directory as I don't need it. But if, for any case, you need the directory you should be good by just recreating it:

Laravel - Creating tables dynamically (without migration)

Shay

[Laravel - Creating tables dynamically (without migration)](https://stackoverflow.com/questions/30096105/laravel-creating-tables-dynamically-without-migration)

I'm trying to create a table dynamically upon an admin request, and while it seems all fun and dandy like in most of Laravel's documentation, I can't seem to create a table. Though I can drop tables, and add or drop columns as I wish.This is my basic code model:What could possibly be the problem here? Unfortunately I don't receive any errors, so I don't know how to debug it. It just goes on to the next line, like everything's working fine. It just doesn't create any tables.Any advice? Much thanks in advance!

2015-05-07 08:47:06Z

I'm trying to create a table dynamically upon an admin request, and while it seems all fun and dandy like in most of Laravel's documentation, I can't seem to create a table. Though I can drop tables, and add or drop columns as I wish.This is my basic code model:What could possibly be the problem here? Unfortunately I don't receive any errors, so I don't know how to debug it. It just goes on to the next line, like everything's working fine. It just doesn't create any tables.Any advice? Much thanks in advance!Ugh, never mind... I worked on it for long enough, and the solution as always was... Very simple.I just had to figure a connection for the database first, so instead ofIt isHope this helps someone someday in the future!This one is even better.

「laravel.log」could not be opened: failed to open stream [duplicate]

Josh Mountain

[「laravel.log」could not be opened: failed to open stream [duplicate]](https://stackoverflow.com/questions/24055056/laravel-log-could-not-be-opened-failed-to-open-stream)

I have setup Laravel homestead on a local OSX machine, everything seemed to be going smoothly until I tried to open example.app:8000 and got this error:I followed the Laravel docs as well as a Laracast about setting up homestead, so I am not sure what would be causing this. I can see that /home/vagrant/Code/example/app/storage/logs/laravel.log doesn't exist, but I assume that is something that should be created automatically?

2014-06-05 08:17:53Z

I have setup Laravel homestead on a local OSX machine, everything seemed to be going smoothly until I tried to open example.app:8000 and got this error:I followed the Laravel docs as well as a Laracast about setting up homestead, so I am not sure what would be causing this. I can see that /home/vagrant/Code/example/app/storage/logs/laravel.log doesn't exist, but I assume that is something that should be created automatically?You need to run one of the following:All files and folders under app/storage should be writable by you and group www-data (the webserver).If you get this error (or a similar error) in the browser when accessing your site, then the group www-data can't write to app/storage. If you get this error when you execute certain php artisan commands, then you (the user) can't write to app/storage. Therefore both you and the www-data group must have write permission.To ensure the files and folders have the correct permissions:As for me I had changed my storage permission with chmod -R 777 storage and it's work well.However, setting 777 permissions is incredibly dangerous and should not be done on any server other than your local machine.I had checked for this configuration at here.You can do this by following stepswhich meansIf your webserver is not running as Vagrant, it will not be able to write to it, so you have 2 options:or change the group to your webserver user, supposing it's www-data:If changing the file permissions as described in the other answers didn't work and you're using CentOS 7 or RHEL then the issue may be a security program called selinux.  I struggled with all kinds of permissions and groups before noticing user3670777 answer to Laravel 4: Failed to open stream: Permission deniedHope this helps others.If All Above suggestions not working disable your selinux and try againim pretty new on laravel. May be I could not explain it in depth but that command fixed my problem. 

Laravel/Eloquent: Fatal error: Call to a member function connection() on a non-object

J. LaRosee

[Laravel/Eloquent: Fatal error: Call to a member function connection() on a non-object](https://stackoverflow.com/questions/26680716/laravel-eloquent-fatal-error-call-to-a-member-function-connection-on-a-non-o)

I'm building a package in Laravel 4 but am getting a non-object error when attempting to access the db from which seems to be a properly instantiated object. Here's the setup:The config and class in question:composer.json:The class:The call:The error:I believe I'm missing something fundamental and under my nose. Thanks for any and all help!EDIT:Here is the class that's instantiating ChatHistory and calling the write:The fact that DB isn't available suggest that Eloquent isn't being loaded up top?

2014-10-31 17:54:17Z

I'm building a package in Laravel 4 but am getting a non-object error when attempting to access the db from which seems to be a properly instantiated object. Here's the setup:The config and class in question:composer.json:The class:The call:The error:I believe I'm missing something fundamental and under my nose. Thanks for any and all help!EDIT:Here is the class that's instantiating ChatHistory and calling the write:The fact that DB isn't available suggest that Eloquent isn't being loaded up top?Answer:Bootstrap your package in your service provider's boot method.Explanation:Since you're developing a package to be used with Laravel, there's no point in making your own Capsule instance. You can just use Eloquent directly.Your problem seems to stem from DB/Eloquent not being set up yet by the time your code hits it.You have not shown us your service provider, but I'm guessing you're using one and doing it all in the register method.Since your package depends on a different service provider (DatabaseServiceProvider) to be wired up prior to its own execution, the correct place to bootstrap your package is in your service provider's boot method.Here's a quote from the docs:In case you're working with Lumen, you may occur identical problem. In this case just uncomment:in bootstrap\app.php@matpop and @TonyStark were on the right track: Capsule\Manager wasn't being booted.I am able to extend Eloquent after booting. I think another solution might be along the lines of (but not tested):What i did was simple, i just forgot to uncomment $app->withFacades();

$app->withEloquent(); in my bootstrap/app.php.Now works fineTry including the DB facade as well as Eloquent......and then see if you have access to DB::table('chat_history'). (Also note that in your class, your call to use Illuminate\Database\Model; should be Illuminate\Database\Eloquent\Model; )

Is it possible to reference a Foreign Key in a different database in Laravel?

cchapman

[Is it possible to reference a Foreign Key in a different database in Laravel?](https://stackoverflow.com/questions/28950070/is-it-possible-to-reference-a-foreign-key-in-a-different-database-in-laravel)

I'm trying to create a model and a migration for that model in Laravel 4.2. All of my Laravel apps use the same MySQL database called laravel. However, we also have another database (on the same server), called main_db that contains a users table, which I would like to use for the source of a few foreign keys in my own laravel_users table in the laravel database.According to the Laravel documentation, I would designate a foreign key with this code:But I believe this assumes that the 'users' table exists within the same database.Is it possible to do trans-database foreign keys in Laravel? Would I have to first create a model that uses the users table from main_db? And is it possible to set up two different database connections in the app/config/database.php?

2015-03-09 19:18:17Z

I'm trying to create a model and a migration for that model in Laravel 4.2. All of my Laravel apps use the same MySQL database called laravel. However, we also have another database (on the same server), called main_db that contains a users table, which I would like to use for the source of a few foreign keys in my own laravel_users table in the laravel database.According to the Laravel documentation, I would designate a foreign key with this code:But I believe this assumes that the 'users' table exists within the same database.Is it possible to do trans-database foreign keys in Laravel? Would I have to first create a model that uses the users table from main_db? And is it possible to set up two different database connections in the app/config/database.php?Cross database foreign keys hasn't much to do with Laravel actually. The real question is if the database does support it. And MySQL (at least with InnoDB) does support foreign key constraints accross multiple databases. You just have to specify the database with the dot notation: db.table.Regarding the Laravel schema builder, this should work:If you get an error, check if the column types are the same.

(You can't reference varchar to int or vice versa, keys have to be of same type).For future reference if you ever change the name of the database this will not work.  It is best to grab the name of the database by the database definition.config/database.phpThen in your migration file:Answer of @lukasgeiter worked for me with following two changes:1- I changed both database engines to InnoDB.2- I had to set the foreign key to be an Unsigned integer in the migration file as the reference was an unsigned integer and was the primary key.

Laravel Migrations - Issues while creating timestamps

cheese5505

[Laravel Migrations - Issues while creating timestamps](https://stackoverflow.com/questions/30555844/laravel-migrations-issues-while-creating-timestamps)

I am trying to run migrations on my Laravel instance. They are just the default migrations (users and password resets) but when it tries to make the timestamps it  throws this error:as well as a PDOException:How can I fix this?Thanks.

2015-05-31 09:25:55Z

I am trying to run migrations on my Laravel instance. They are just the default migrations (users and password resets) but when it tries to make the timestamps it  throws this error:as well as a PDOException:How can I fix this?Thanks.This is due to MySQL not accepting zero as a valid default date and thus the table creation fails a constraint check on creation.You probably have NO_ZERO_DATE enabled in your MySQL configuration. Setting this to off will allow you to create the table or alternatively remove the default 0 value or change it to CURRENT_TIMESTAMP.You can find out more about this exact issue here: https://github.com/laravel/framework/issues/3602I have been facing the same error. Given solutions does work properly still i want to help laravel developers.

Simply add a following line to config/database.phpit sounds like strict mode.You may disable strict mode in one of two ways:Open your my.ini file within the MySQL installation directory, and look for the text sql-mode.Find:sql-mode="STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"and change tosql-mode="NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"or you can run the following in phpMyAdminSET @@global.sql_mode='';This is due to MySQL not accepting zero as a valid default date  so you can write or $table->nullableTimestamps();Instead of $table->timestamps();This worked for me after being unsuccessful with strict mode:You can use nullableTimestamps() instead of timestamps()or elsealso, check the database server versionPlease have a look on these ref links:https://github.com/laravel/framework/issues/3602https://laracasts.com/discuss/channels/forge/syntax-error-or-access-violation-1067-invalid-default-value-for-created-atI have used the following method:Really worked!Migrating old tables works like that:from https://github.com/laravel/framework/issues/3602you should disable MySQL strict mode on Laravel.

MySQL has had a strict mode since 5.1, but in 5.7 it became the default.

In Laravel, you can fix this in code: edit your database.php config file, and add a key of strict with a value of false.for non-Laravel users:if you're using a non-Laravel application,you won't have that option.Here's how to disable strict mode globally.find your MySQL configuration file my.cnf or my.ini 

the default MySQL configuration will live in /etc/mysql/my.cnf open the file and find the [mysqld] section.We're going to add a new key, sql_mode

On MySQL 5.7, the default values for this key out of the box are: The strict mode comes from STRICT_TRANS_TABLES. So, let's overwrite the sql_mode to:That's it! Save the file, and restart MySQL.MySQL 5.7.28The MySQL docs recommend the following (note the use of GLOBAL):

Laravel: blade foreach looping bootstrap columns

Thomas Charlesworth

[Laravel: blade foreach looping bootstrap columns](https://stackoverflow.com/questions/41650670/laravel-blade-foreach-looping-bootstrap-columns)

I have a foreach loop and inside that contains html with bootstrap columns.However, bootstrap requires the row div before creating columns, placing that straight in to the foreach loop would create a row div for each col-md-6. I want to know how I can throw in the row div, skip the next loop throwing in only the closing div tag. And then repeat that process.Example output where the loops 4 times:

2017-01-14 13:44:10Z

I have a foreach loop and inside that contains html with bootstrap columns.However, bootstrap requires the row div before creating columns, placing that straight in to the foreach loop would create a row div for each col-md-6. I want to know how I can throw in the row div, skip the next loop throwing in only the closing div tag. And then repeat that process.Example output where the loops 4 times:As an alternative to Alexey Mezenin's answer you could use array_chunk instead. http://php.net/manual/en/function.array-chunk.phpI personally find the the above a little more readable.Alternatively, if $address is a collection you could do $address->chunk(2) instead of array_chunk($address, 2).If you want to change the amount of columns you have you would simply need to change the 2 to be however many columns you want.You can use Laravel chunk in the blade template.Copied from the blogpost.Use the $loop variable:

How to create laravel storage symbolic link for production or sub domain system?

Mizanur Rahman Khan

[How to create laravel storage symbolic link for production or sub domain system?](https://stackoverflow.com/questions/45825889/how-to-create-laravel-storage-symbolic-link-for-production-or-sub-domain-system)

When I worked on laravel local development server php artisan storage:link works fine for me. But when I transfer my site to production server then I saw my public storage link was a folder. Then I delete that tried to create a link. I got an error because my app was in the root folder and tried to solve this problem.

2017-08-22 19:49:55Z

When I worked on laravel local development server php artisan storage:link works fine for me. But when I transfer my site to production server then I saw my public storage link was a folder. Then I delete that tried to create a link. I got an error because my app was in the root folder and tried to solve this problem.I solved this problem by another command for creating a symbolic link by terminal/cmd/shh:I solved this also Using laravel web route routes/web.phpAnother simple way is to run Executing php artisan storage:link Command ProgrammaticallyOn routes/web.php

Permission Denied Error using Laravel & Docker

Anand Naik B

[Permission Denied Error using Laravel & Docker](https://stackoverflow.com/questions/48619445/permission-denied-error-using-laravel-docker)

I have two docker containers: Nginx and App.

The app container extends PHP-fpm and also has my Laravel Code.In my docker-compose.yml I'm doing:In my Nginx Dockerfile i'm doing:In my App Dockerfile I'm doing:After successfully running docker-compose up, I have the following error when I try localhostFrom my understanding, the storage folder needs to writable by the webserver.

What should I be doing to resolve this?

2018-02-05 09:35:53Z

I have two docker containers: Nginx and App.

The app container extends PHP-fpm and also has my Laravel Code.In my docker-compose.yml I'm doing:In my Nginx Dockerfile i'm doing:In my App Dockerfile I'm doing:After successfully running docker-compose up, I have the following error when I try localhostFrom my understanding, the storage folder needs to writable by the webserver.

What should I be doing to resolve this?Make your Dockerfile something as below - This makes directory /var/www owned by www-data which is the default user for php-fpm. Since it is compiled with user www-data.Ref- https://github.com/docker-library/php/blob/57b41cfc2d1e07acab2e60d59a0cb19d83056fc1/7.0/jessie/fpm/DockerfileI found similar problem and I fixed it by When using bind mounts in Docker, the original permissions in the Docker host are preserved in the container. This enables us to set appropriate permissions on the Docker host, to be used inside the container.First, you should find the uid and gid of the nginx, for example:docker-compose exec nginx id www-dataThe output of this command would be something like this:uid=33(www-data) gid=33(www-data) groups=33(www-data)Then, you should use these uid and gid to set permissions on Docker host, which will be used by the container too. So, run the following command on the Docker host:sudo chown -R 33:33 siteNow everything must be working.You can do 3 things as I used/usingNote: If the project is in /var/www/ then if you wrote file upload also you need permission to that folders too. this will avoid such error when you moved that to /homeu can just right click on your laravel folder, click on properties,then permissions, and from 'group' field, select the 'docker' and give necessary permissions to 'docker' group :) thats work for me

How to use patch request in Laravel?

Darama

[How to use patch request in Laravel?](https://stackoverflow.com/questions/42313033/how-to-use-patch-request-in-laravel)

There is entity User that is stoted in table UsersSome fields in this table are null by default. I need to update these fields and set not null data.For this I try to use PATCH method in Laravel:Routing:Controller:Does it mean that I can pass any data to update?

Should I pass $id parameter to routing and controller relatively?How to use right handler for PATCH method in Laravel?

2017-02-18 08:43:29Z

There is entity User that is stoted in table UsersSome fields in this table are null by default. I need to update these fields and set not null data.For this I try to use PATCH method in Laravel:Routing:Controller:Does it mean that I can pass any data to update?

Should I pass $id parameter to routing and controller relatively?How to use right handler for PATCH method in Laravel?your route is:replace your route with following route that use for all CRUD opration:if you use ajax for submit data then replace your type and url with following:if you don't use ajax than use following:update: after version 5.6 you can use these syntax for above functions in any blade file:Update the routing as per below Yes, you need to send id for route patch. Example from https://laravel.com/docs/5.4/controllers#resource-controllers for Laravel PUT/PATCH  - /photos/{photo}, so you don't need update word in your route. Just users/id and methods PUT or PATCH.UPD for CRUD operations:

How to install PHP composer inside a docker container

Andre

[How to install PHP composer inside a docker container](https://stackoverflow.com/questions/51443557/how-to-install-php-composer-inside-a-docker-container)

I try to work out a way to create a dev environment using docker and laravel.I have the following dockerfile:Laravel requires composer to call composer dump-autoload when working with database migration. Therefore, I need composer inside the docker container. I tried:But when I call It throws the following error:I would be more than happy for advice how I can add composer to the PATH within my dockerfile or what else I can do to surpass this error. Thanks for your support.

Also: this is the gitub repository if you need to see the docker-compose.yml file or anything else.

2018-07-20 13:24:35Z

I try to work out a way to create a dev environment using docker and laravel.I have the following dockerfile:Laravel requires composer to call composer dump-autoload when working with database migration. Therefore, I need composer inside the docker container. I tried:But when I call It throws the following error:I would be more than happy for advice how I can add composer to the PATH within my dockerfile or what else I can do to surpass this error. Thanks for your support.

Also: this is the gitub repository if you need to see the docker-compose.yml file or anything else.I can install composer adding this line on my test dockerfile:Here is the dockerfile:It works for me, to test if the composer are installed i access to my container bash and execute:In Dockerfile :We have basicly the same command running with the difference, Alternatively, you should add the composer bin files path to the $PATH variable.Create an executable of your composer file using

Laravel 5 app always using 'testing' environment configuration

Simon Fredsted

[Laravel 5 app always using 'testing' environment configuration](https://stackoverflow.com/questions/27438817/laravel-5-app-always-using-testing-environment-configuration)

I have a Laravel 5 app with two environments and two configurations: testing (for PHPUnit configuration, in-memory db) and local (my development configuration).Even when the environment is configured to be local, the application only loads the configuration in the resources/config/testing folder. I can see the environment in the same app from the APP_ENV environment variable, and it is local.

2014-12-12 07:28:39Z

I have a Laravel 5 app with two environments and two configurations: testing (for PHPUnit configuration, in-memory db) and local (my development configuration).Even when the environment is configured to be local, the application only loads the configuration in the resources/config/testing folder. I can see the environment in the same app from the APP_ENV environment variable, and it is local.Laravel 5 doesn't cascade config files correctly anymore so your testing config file is overriding anything you have in your local config file. Now you aren't supposed to have any subfolders for each environment, but rather set configuration settings inside the .env file in the root folder.This file isn't checked in to the repo to ensure that nothing sensitive is checked into the repo. You should have a separate .env file for each environment your application is living.TESTINGFor php unit (functional) you can set env variables in the phpunit.xml file e.g..For behat (acceptance) testing the Laracasts Laravel Behat extension allows you to create a .env.behat file to change the environment variables.For phpspec (unit) testing well the environment shouldn't matter as your testing individual methods in isolation and mock everything else. For selenium (integration / system / e2e) testing the environment variables should come from the .env file on the server wherever you are doing this testing. Additional points I've just had to use to get tests running on sqlite, while the main app normally defaults to mysql:Add something like this to phpunit.xml, as explained by craig.michael.morris:And this change to config/database.phpAnd in the 'sqlite' section of config/database.php1) open the config file  database.php and add the following inside the 'connections' => [this in memory sqlite will be used for your testing2) open the .env file and make sure it has the following:3) open phpunit.xml and add the following inside the <php> tag:here’s where you can add all the testing related env variables4) in your tests were you use a database connection use the Database Migration Trait:for more details about the DatabaseMigrations refer to the documentation https://laravel.com/docs/5.1/testing#resetting-the-database-after-each-test

Fill method in Laravel not working?

marc_aragones

[Fill method in Laravel not working?](https://stackoverflow.com/questions/24303003/fill-method-in-laravel-not-working)

I am learning how to use Laravel framework but I am having troubles with filling a Model. Here is my code:The model Event:And here is the code in the controller:So, why the print_r is displaying an empty array?

2014-06-19 09:17:42Z

I am learning how to use Laravel framework but I am having troubles with filling a Model. Here is my code:The model Event:And here is the code in the controller:So, why the print_r is displaying an empty array?Actually. at first you should change the model name from Event to something else, Laravel has a Facade class as Illuminate\Support\Facades\Event so it could be a problem.Regarding the fill method, you should pass an associative array to fill method like:Also make sure you have a protected $fillable (check mass assignment) property declared in your Model with property names that are allowed to be filled. You may also do the same thing when initializing the Model:Finally, call:Because attributes is a protected property.Also make sure that the $fillable property is defined in your model class. For example, in your new renamed model:If you do not have either $fillable or $guarded defined on your Model, fill() won't set any values. This is to prevent the model from mass assignment. See "Mass Assignment" on the Laravel Eloquent docs: http://laravel.com/docs/5.1/eloquent.When filling the attributes, make sure to use an associative array:A useful way to debug and check all your values:Hope this helps!Use a key/value array in fill:An example:In your model you need to have protected $fillable = ['foo','bar'];Then you can do:The array key needs to be on the $fillable, as Laravel will effectively call:Alternatively, you can write directly to a column name:

How I can install the PHPExcel library in laravel?

TuGordoBello

[How I can install the PHPExcel library in laravel?](https://stackoverflow.com/questions/23764375/how-i-can-install-the-phpexcel-library-in-laravel)

I'm trying to use this library to create excel files but not how to install it. I was considering to download the library from its home page (http://phpexcel.codeplex.com/wikipage?title=Examples) but also do not know what folder should I place it. How I can install?

2014-05-20 15:40:32Z

I'm trying to use this library to create excel files but not how to install it. I was considering to download the library from its home page (http://phpexcel.codeplex.com/wikipage?title=Examples) but also do not know what folder should I place it. How I can install?You should use composer:  Add "phpexcel/phpexcel": "dev-master" to your composer.json Then execute composer update. So you can use it as normal: For install PhpExcel in laravel 5. Please visit this link for pakage -https://packagist.org/packages/phpoffice/phpexcel.Please follow the instruction --1:- Add "phpoffice/phpexcel": "dev-master" to your composer.json. 2:- execute "composer update" on terminal.3:- Open the file "/vendor/composer/autoload_namespaces.php". Paste the below line in the file.4:- Now you can use PHPEXCEL library in your controllers or middleware or library. There's actually a neat new PHPExcel library specifically made for Laravel. Easy installation and it looks easy to use (I'm unaffiliated). https://laravel-excel.com/If you are using Laravel 5. It is very easy. check this link for configurationyou may need to type in the following command to proceed with the package download check this link for usagemy might want to look at my example code:For future readers:PHPExcell is no more maintained. Rather use: https://github.com/PHPOffice/PhpSpreadsheet

http://phpspreadsheet.readthedocs.io/en/develop/#installation

Laravel - Add custom column in select with Eloquent query buider

ZarkDev

[Laravel - Add custom column in select with Eloquent query buider](https://stackoverflow.com/questions/27143652/laravel-add-custom-column-in-select-with-eloquent-query-buider)

this is a simplified use case, only to illustrate what I want to achieve:Considering this query in pure SQL:How can I add the constant active column using query builder ?Here is my Query Builder without the extra column:

2014-11-26 07:42:22Z

this is a simplified use case, only to illustrate what I want to achieve:Considering this query in pure SQL:How can I add the constant active column using query builder ?Here is my Query Builder without the extra column:Simplest would be to use DB::raw        We can add subquery or "custom column" in select with first argument of \Illuminate\Database\Query\Builder::selectSub method as raw SQL or Closure, or \Illuminate\Database\Query\Builder. Better solution is closure or Builder. 

In your case it will be:Tested on Laravel 5.5. In closure $query is a object of \Illuminate\Database\Query\Builder for subquery. Prepared SQL will be:Extended example... If we use App\Module eloquent for modules and we need get url of modules and count of their submodules with id > 5, we can write next:Prepared SQL will be:Or you can write your example with raw sql:Then prepared SQL will be:For get all columns necessarily to use select('*'): Not:Laravel Eloquent has very flexible query builder.You can specify a column to return as:

Run one file or map in phpunit

Jamie

[Run one file or map in phpunit](https://stackoverflow.com/questions/35596637/run-one-file-or-map-in-phpunit)

I'm using laravel and I've written some test files. But how can I exec only one file? When I do for example: phpunit tests/resulttesting/school/deleteSchoolForRealTest It throws an error:When I run phpunit it runs all my tests. And how can I exec only one folder? I'm on a mac. 

2016-02-24 08:13:49Z

I'm using laravel and I've written some test files. But how can I exec only one file? When I do for example: phpunit tests/resulttesting/school/deleteSchoolForRealTest It throws an error:When I run phpunit it runs all my tests. And how can I exec only one folder? I'm on a mac. You are doing everything correctly.1) First way to add folder.

 My correct way was:I had same errors when I forget to start from "tests" folderI got2) Filter is another option. read here

example:Meaning that you will have executed files EWalletTest and EWalletFooTest and test cases from other filee with names like `test_EWallet_with_Australian_dollar.Use filter optionUsing phpunit.xmlthe @group option can be used on classes and methods.class Aclass Bin phpunit.xmlthe classes that belongs to group active will be executed.

How to compare two encrypted(bcrypt) password in laravel

Jija

[How to compare two encrypted(bcrypt) password in laravel](https://stackoverflow.com/questions/35715755/how-to-compare-two-encryptedbcrypt-password-in-laravel)

How to compare two bcrypt passwordAnd Both $pass1 & $pass2 are bcrypt for 'test'.How I can check for equality. without using text 'test' like this

2016-03-01 06:01:47Z

How to compare two bcrypt passwordAnd Both $pass1 & $pass2 are bcrypt for 'test'.How I can check for equality. without using text 'test' like thisYou can't actually compare two encrypted bcrypt passwords to each other directly as strings because the encryption contains salt which makes the hashes different each time.You can simply use Hash::check() method

eg:reference https://laravel.com/docs/5.5/hashingYou can try this way:you can compare hash encrypt the password using Hash. but note that in this method 

the first value should be plain-text and second bcrypt value.

Laravel framework classes not available in PHPUnit data provider

FixMaker

[Laravel framework classes not available in PHPUnit data provider](https://stackoverflow.com/questions/26710631/laravel-framework-classes-not-available-in-phpunit-data-provider)

I have something like the following set up in Laravel:In /app/controllers/MyController.php:In /app/tests/MyControllerTest.php:However, when I run vendor/bin/phpunit I get the following error:If I remove the reference to the MyController class in myDataProvider() and replace it with a literal constant then the test completes successfully.In addition, I can place references to MyController::MAX_FILE_SIZE inside the actual testMyController() method, and the test also completes successfully.It appears that the autoloading setup for Laravel framework classes isn't being set up until after the data provider method is being called, but before the actual test methods are called. Is there any way around this so that I can access Laravel framework classes from within a PHPUnit data provider?NOTE: I'm calling PHPUnit directly from the command line and not from within an IDE (such as NetBeans). I know some people have had issues with that, but I don't think that applies to my problem.

2014-11-03 08:48:42Z

I have something like the following set up in Laravel:In /app/controllers/MyController.php:In /app/tests/MyControllerTest.php:However, when I run vendor/bin/phpunit I get the following error:If I remove the reference to the MyController class in myDataProvider() and replace it with a literal constant then the test completes successfully.In addition, I can place references to MyController::MAX_FILE_SIZE inside the actual testMyController() method, and the test also completes successfully.It appears that the autoloading setup for Laravel framework classes isn't being set up until after the data provider method is being called, but before the actual test methods are called. Is there any way around this so that I can access Laravel framework classes from within a PHPUnit data provider?NOTE: I'm calling PHPUnit directly from the command line and not from within an IDE (such as NetBeans). I know some people have had issues with that, but I don't think that applies to my problem.As implied in this answer, this appears to be related to the order that PHPUnit will call any data providers and the setUp() method in any test cases.PHPUnit will call the data provider methods before running any tests. Before each test it will also call the setUp() method in the test case. Laravel hooks into the setUp() method to call $this->createApplication() which will add the controller classes to the 'include path' so that they can be autoloaded correctly.Since the data provider methods are run before this happens then any references to controller classes inside a data provider fail. It's possible work around this by modifying the test class to something like this:This will call createApplication() before the data provider methods are run, and so there is a valid application instance that will allow the appropriate classes to be autoloaded correctly.This seems to work, but I'm not sure if it's the best solution, or if it is likely to cause any issues (although I can't think of any reasons why it should).The test will initialize much faster if you create the application right within the dataProvider method, especially if you have large set of items to test.Performance warning for the other solutions (especially if you plan to use factories inside your dataProviders):As this article explains:The above article proposes to return a closure from the dataProvider and execute that in your test:

Laravel seeder gives error. Class not found

samhu kiklsk

[Laravel seeder gives error. Class not found](https://stackoverflow.com/questions/26345408/laravel-seeder-gives-error-class-not-found)

I'm a newbie in Laravel and and I'm teaching myself how to authenticate from a login table. I have migrated and created the table. Now, I'm trying to seed the data into the login table, but the command prompt is continuously giving me error, which says Fatal Error, class login not found and I have no idea what i have missed. So can anyone please help me. Here is the code that i have, and yes I'm using Laravel 4.3

2014-10-13 17:17:29Z

I'm a newbie in Laravel and and I'm teaching myself how to authenticate from a login table. I have migrated and created the table. Now, I'm trying to seed the data into the login table, but the command prompt is continuously giving me error, which says Fatal Error, class login not found and I have no idea what i have missed. So can anyone please help me. Here is the code that i have, and yes I'm using Laravel 4.3You need to create an Eloquent model for that table in order to use Login::create(). You can do that with a simple artisan command:$ php artisan generate:model LoginThis will generate a new Eloquent model in app/models directory which should look like this.Your code should work after that. If it still doesn't make sure you run composer dump-autoload.EDITNow I see, the problem  is with your login class (with earlier question formatting the exact error was illegible). You should look again what's the name of file where you have login class and what's the name of class. The convention is that the file should have name Login.php (with capital letter) and the name of class also should be Login (with capital letter). You should also check in what namespace is your Login class. If it is defined in in App namespace, you should add to your LoginTableSeeder:in the next line after <?phpso basically the beginning of your file should look like this:EARLIER ANSWERYou didn't explained what the exact error is (probably the error is for Seeder class)  but:In database/seeds/DatabaseSeeder.php you should run Login seeder like this:You should put into database/seeds file LoginTableSeeder.php with capital letter at the beginning.Now, your file LoginTableSeeder.php file should look like this:you need to import Seeder with use at the beginning of file and again class name should start with capital letter.Now you should run composer dump-autoload and now when you run php artisan db:seed it will work fine.Just run 

composer dump-autoload -o

for the autoloader to pick up the newly classes because the database folder is not automatically autoloaded with PSR-4.This worked for meI have the same problem but you can solve it by adding your namespace:I've experienced the same problem. In my case, the composer was extremely old and after it's update everything runs Ok.Update composer with the command:$ composer self-update Hope it can help others.

Laravel eloquent where date is equal or greater than DateTime

Kaizokupuffball

[Laravel eloquent where date is equal or greater than DateTime](https://stackoverflow.com/questions/44266337/laravel-eloquent-where-date-is-equal-or-greater-than-datetime)

