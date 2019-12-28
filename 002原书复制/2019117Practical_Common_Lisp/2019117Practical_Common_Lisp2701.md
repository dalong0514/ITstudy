AllegroServe, like most Web programming frameworks, takes care of parsing both these sources of input for you. By the time your published functions are called, all the key/value pairs from the query string and/or post data have been decoded and placed into an alist that you can retrieve from the request object with the function request-query. The following function returns a page showing all the query parameters it receives:

(defun show-query-params (request entity) (with-http-response (request entity :content-type "text/html") (with-http-body (request entity) (with-html-output ((request-reply-stream request)) (html (:standard-page (:title "Query Parameters") (if (request-query request) (html (:table :border 1 (loop for (k . v) in (request-query request) do (html (:tr (:td k) (:td v)))))) (html (:p "No query parameters."))))))))) (publish :path "/show-query-params" :function 'show-query-params)

If you give your browser a URL with a query string in it like the following:

http://localhost:2001/show-query-params?foo=bar&baz=10

you should get back a page similar to the one shown in Figure 26-4.

Figure 26-4. http://localhost:2001/show-query-params?foo=bar&baz=10

To generate some post data, you need an HTML form. The following function generates a simple form, which submits its data to show-query-params:

(defun simple-form (request entity) (with-http-response (request entity :content-type "text/html") (with-http-body (request entity) (let ((*html-output* (request-reply-stream request))) (html (:html (:head (:title "Simple Form")) (:body (:form :method "POST" :action "/show-query-params" (:table (:tr (:td "Foo") (:td (:input :name "foo" :size 20))) (:tr (:td "Password") (:td (:input :name "password" :type "password" :size 20)))) (:p (:input :name "submit" :type "submit" :value "Okay") (:input ::type "reset" :value "Reset")))))))))) (publish :path "/simple-form" :function 'simple-form)

Point your browser to http://localhost:2001/simple-form, and you should see a page like the one in Figure 26-5.

If you fill in the form with the "abc" and "def" values, clicking the Okay button should take you to a page like the one in Figure 26-6.

Figure 26-5. http://localhost:2001/simple-form

Figure 26-6. Result of submitting the simple form

However, most of the time you won't need to iterate over all the query parameters; you'll want to pick out individual parameters. For instance, you might want to modify random-number so the limit value you pass to RANDOM can be supplied via a query parameter. In that case, you use the function request-query-value, which takes the request object and the name of the parameter whose value you want and returns the value as a string or NIL if no such parameter has been supplied. A parameterizable version of random-number might look like this:

(defun random-number (request entity) (with-http-response (request entity :content-type "text/html") (with-http-body (request entity) (let* ((*html-output* (request-reply-stream request)) (limit-string (or (request-query-value "limit" request) "")) (limit (or (parse-integer limit-string :junk-allowed t) 1000))) (html (:html (:head (:title "Random")) (:body (:p "Random number: " (:print (random limit))))))))))

Because request-query-value can return either NIL or an empty string, you have to deal with both those cases when parsing the parameter into a number to pass to RANDOM. You can deal with a NIL value when you bind limit-string, binding it to "" if there's no "limit" query parameter. Then you can use the :junk-allowed argument to PARSE-INTEGER to ensure that it returns either NIL (if it can't parse an integer from the string given) or an integer. In the section "A Small Application Framework," you'll develop some macros to make it easier to deal with grabbing query parameters and converting them to various types.

Cookies

In AllegroServe you can send a Set-Cookie header that tells the browser to save a cookie and send it along with subsequent requests by calling the function set-cookie-header within the body of with-http-response but before the call to with-http-body. The first argument to the function is the request object, and the remaining arguments are keyword arguments used to set the various properties of the cookie. The only two you must pass are the :name and :value arguments, both of which should be strings. The other possible arguments that affect the cookie sent to the browser are :expires, :path, :domain, and :secure.

Of these, you need to worry only about :expires. It controls how long the browser should save the cookie. If :expires is NIL (the default), the browser will save the cookie only until it exits. Other possible values are :never, which means the cookie should be kept forever, or a universal time as returned by GET-UNIVERSAL-TIME or ENCODE-UNIVERSAL-TIME. An :expires of zero tells the client to immediately discard an existing cookie.11

After you've set a cookie, you can use the function get-cookie-values to get an alist containing one name/value pair for each cookie sent by the browser. From that alist, you can pick out individual cookie values using ASSOC and CDR.

The following function shows the names and values of all the cookies sent by the browser:

(defun show-cookies (request entity) (with-http-response (request entity :content-type "text/html") (with-http-body (request entity) (with-html-output ((request-reply-stream request)) (html (:standard-page (:title "Cookies") (if (null (get-cookie-values request)) (html (:p "No cookies.")) (html (:table (loop for (key . value) in (get-cookie-values request) do (html (:tr (:td key) (:td value))))))))))))) (publish :path "/show-cookies" :function 'show-cookies)

The first time you load the page http://localhost:2001/show-cookies it should say "No cookies" as shown in Figure 26-7 since you haven't set any yet.

Figure 26-7. http://localhost:2001/show-cookies with no cookies

To set a cookie, you need another function, such as the following:

(defun set-cookie (request entity) (with-http-response (request entity :content-type "text/html") (set-cookie-header request :name "MyCookie" :value "A cookie value") (with-http-body (request entity) (with-html-output ((request-reply-stream request)) (html (:standard-page (:title "Set Cookie") (:p "Cookie set.") (:p (:a :href "/show-cookies" "Look at cookie jar.")))))))) (publish :path "/set-cookie" :function 'set-cookie)

If you enter the URL http://localhost:2001/set-cookie, your browser should display a page like the one in Figure 26-8. Additionally, the server will send a Set-Cookie header with a cookie named "MyCookie" with "A cookie value" as its value. If you click the link Look at cookie jar, you'll be taken to the /show-cookies page where you'll see the new cookie, as shown in Figure 26-9. Because you didn't specify an :expires argument, the browser will continue to send the cookie with each request until you quit the browser.

Figure 26-8. http://localhost:2001/set-cookie

Figure 26-9. http://localhost:2001/show-cookies after setting a cookie

A Small Application Framework

Although AllegroServe provides fairly straightforward access to all the basic facilities you need to write server-side Web code (access to query parameters from both the URL's query string and the post data; the ability to set cookies and retrieve their values; and, of course, the ability to generate the response sent back to the browser), there's a fair bit of annoyingly repetitive code.

For instance, every HTML-generating function you write is going to take the arguments request and entity and then will contain calls to with-http-response, with-http-response, and--if you're going to use FOO to generate HTML--with-html-output. Then, in functions that need to get at query parameters, there will be a bunch of calls to request-query-value and then more code to convert the string returned to whatever type you actually want. Finally, you need to remember to publish the function.

To reduce the amount of boilerplate you have to write, you can write a small framework on top of AllegroServe to make it easier to define functions that handle requests for a particular URL.

The basic approach will be to define a macro, define-url-function, that you'll use to define functions that will automatically be published via publish. This macro will expand into a DEFUN that contains the appropriate boilerplate as well as code to publish the function under a URL of the same name. It'll also take care of generating code to extract values from query parameters and cookies and to bind them to variables declared in the function's parameter list. Thus, the basic form of a define-url-function definition is this:

(define-url-function name (request query-parameter*) body)

where the body is the code to emit the HTML of the page. It'll be wrapped in a call to FOO's html macro, so for simple pages it might contain nothing but s-expression HTML.

Within the body, the query parameter variables will be bound to values of query parameters with the same name or from a cookie. In the simplest case, a query parameter's value will be the string taken from the query parameter or post data field of the same name. If the query parameter is specified with a list, you can also specify an automatic type conversion, a default value, and whether to look for and save the value of the parameter in a cookie. The complete syntax for a query-parameter is as follows:

name | (name type [default-value] [stickiness])

The type must be a name recognized by define-url-function. I'll discuss in a moment how to define new types. The default-value must be a value of the given type. Finally, stickiness, if supplied, indicates that the parameter's value should be taken from an appropriately named cookie if no query parameter is supplied and that a Set-Cookie header should be sent in the response that saves the value in the cookie of the same name. Thus, a sticky parameter, after being explicitly supplied a value via a query parameter, will keep that value on subsequent requests of the page even when no query parameter is supplied.

The name of the cookie used depends on the value of stickiness: with a value of :global, the cookie will be named the same as the parameter. Thus, different functions that use globally sticky parameters with the same name will share the value. If stickiness is :package, then the cookie name is constructed from the name of the parameter and the package of the function's name; this allows functions in the same package to share values but not have to worry about stomping on parameters of functions in other packages. Finally, a parameter with a stickiness value of :local will use a cookie made from the name of the parameter, the package of the function name, and the function name, making it unique to that function.

For instance, you can use define-url-function to replace the previous eleven-line definition of random-page with this five-line version:

(define-url-function random-number (request (limit integer 1000)) (:html (:head (:title "Random")) (:body (:p "Random number: " (:print (random limit))))))

If you wanted the limit argument to be sticky, you could change the limit declaration to (limit integer 1000 :local).

The Implementation

I'll explain the implementation of define-url-function from the top down. The macro itself looks like this:

(defmacro define-url-function (name (request &rest params) &body body) (with-gensyms (entity) (let ((params (mapcar #'normalize-param params))) `(progn (defun ,name (,request ,entity) (with-http-response (,request ,entity :content-type "text/html") (let* (,@(param-bindings name request params)) ,@(set-cookies-code name request params) (with-http-body (,request ,entity) (with-html-output ((request-reply-stream ,request)) (html ,@body)))))) (publish :path ,(format nil "/~(~a~)" name) :function ',name)))))

Let's take it bit by bit, starting with the first few lines.

(defmacro define-url-function (name (request &rest params) &body body) (with-gensyms (entity) (let ((params (mapcar #'normalize-param params)))

Up to here you're just getting ready to generate code. You GENSYM a symbol to use later as the name of the entity parameter in the DEFUN. Then you normalize the parameters, converting plain symbols to list form using this function:

(defun normalize-param (param) (etypecase param (list param) (symbol `(,param string nil nil))))

In other words, declaring a parameter with just a symbol is the same as declaring a nonsticky, string parameter with no default value.

Then comes the PROGN. You must expand into a PROGN because you need to generate code to do two things: define a function with DEFUN and call publish. You should define the function first so if there's an error in the definition, the function won't be published. The first two lines of the DEFUN are just boilerplate.

(defun ,name (,request ,entity) (with-http-response (,request ,entity :content-type "text/html")

Now you do the real work. The following two lines generate the bindings for the parameters specified in define-url-function other than request and the code that calls set-cookie-header for the sticky parameters. Of course, the real work is done by helper functions that you'll look at in a moment.12

(let* (,@(param-bindings name request params)) ,@(set-cookies-code name request params)

The rest is just more boilerplate, putting the body from the define-url-function definition in the appropriate context of with-http-body, with-html-output, and html macros. Then comes the call to publish.

(publish :path ,(format nil "/~(~a~)" name) :function ',name)

The expression (format nil "/~(~a~)" name) is evaluated at macro expansion time, generating a string consisting of /, followed by an all-lowercase version of the name of the function you're about to define. That string becomes the :path argument to publish, while the function name is interpolated as the :function argument.

Now let's look at the helper functions used to generate the DEFUN form. To generate parameter bindings, you need to loop over the params and collect a snippet of code for each one, generated by param-binding. That snippet will be a list containing the name of the variable to bind and the code that will compute the value of that variable. The exact form of code used to compute the value will depend on the type of the parameter, whether it's sticky, and the default value, if any. Because you already normalized the params, you can use DESTRUCTURING-BIND to take them apart in param-binding.

(defun param-bindings (function-name request params) (loop for param in params collect (param-binding function-name request param))) (defun param-binding (function-name request param) (destructuring-bind (name type &optional default sticky) param (let ((query-name (symbol->query-name name)) (cookie-name (symbol->cookie-name function-name name sticky))) `(,name (or (string->type ',type (request-query-value ,query-name ,request)) ,@(if cookie-name (list `(string->type ',type (get-cookie-value ,request ,cookie-name)))) ,default)))))

The function string->type, which you use to convert strings obtained from the query parameters and cookies to the desired type, is a generic function with the following signature:

(defgeneric string->type (type value))

To make a particular name usable as a type name for a query parameter, you just need to define a method on string->type. You'll need to define at least a method specialized on the symbol string since that's the default type. Of course, that's pretty easy. Since browsers sometimes submit forms with empty strings to indicate no value was supplied for a particular value, you'll want to convert an empty string to NIL as this method does:

(defmethod string->type ((type (eql 'string)) value) (and (plusp (length value)) value))

You can add conversions for other types needed by your application. For instance, to make integer usable as a query parameter type so you can handle the limit parameter of random-page, you might define this method:

(defmethod string->type ((type (eql 'integer)) value) (parse-integer (or value "") :junk-allowed t))

Another helper function used in the code generated by param-binding is get-cookie-value, which is just a bit of sugar around the get-cookie-values function provided by AllegroServe. It looks like this:

(defun get-cookie-value (request name) (cdr (assoc name (get-cookie-values request) :test #'string=)))

The functions that compute the query parameter and cookies names are similarly straightforward.

(defun symbol->query-name (sym) (string-downcase sym)) (defun symbol->cookie-name (function-name sym sticky) (let ((package-name (package-name (symbol-package function-name)))) (when sticky (ecase sticky (:global (string-downcase sym)) (:package (format nil "~(~a:~a~)" package-name sym)) (:local (format nil "~(~a:~a:~a~)" package-name function-name sym))))))

To generate the code that sets cookies for sticky parameters, you again loop over the list of parameters, this time collecting a snippet of code for each sticky param. You can use the when and collect it LOOP forms to collect only the non-NIL values returned by set-cookie-code.

(defun set-cookies-code (function-name request params) (loop for param in params when (set-cookie-code function-name request param) collect it)) (defun set-cookie-code (function-name request param) (destructuring-bind (name type &optional default sticky) param (declare (ignore type default)) (if sticky `(when ,name (set-cookie-header ,request :name ,(symbol->cookie-name function-name name sticky) :value (princ-to-string ,name))))))

One of the advantages of defining macros in terms of helper functions like this is that it's easy to make sure the individual bits of code you're generating look right. For instance, you can check that the following set-cookie-code:

(set-cookie-code 'foo 'request '(x integer 20 :local))

generates something like this:

(WHEN X (SET-COOKIE-HEADER REQUEST :NAME "com.gigamonkeys.web:foo:x" :VALUE (PRINC-TO-STRING X)))

Assuming this code will occur in a context where x is the name of a variable, this looks good.

Once again, macros have allowed you to distill the code you need to write down to its essence--in this case, the data you want to extract from the request and the HTML you want to generate. That said, this framework isn't meant to be the be-all and end-all of Web application frameworks--it's just a little sugar to make it a bit easier to write simple apps like the one you'll write in Chapter 29.

But before you can get to that, you need to write the guts of the application for which the Chapter 29 application will be the user interface. You'll start in the next chapter with a souped-up version of the database you wrote in Chapter 3, this time to keep track of ID3 data extracted from MP3 files.

* * *

1Readers new to Web programming will probably need to supplement this introduction with a more in-depth tutorial or two. You can find a good set of online tutorials at http://www.jmarshall.com/easy/.

2Loading a single Web page may actually involve multiple requests--to render the HTML of a page containing inline images, the browser must request each image individually and then insert each into the appropriate place in the rendered HTML.

3Much of the complexity around Web programming is a result of trying to work around this fundamental limitation in order to provide a user experience that's more like the interactivity provided by desktop applications.

4Unfortunately, dynamic is somewhat overloaded in the Web world. The phrase Dynamic HTML refers to HTML containing embedded code, usually in the language JavaScript, that can be executed in the browser without further communication with the Web server. Used with some discretion, Dynamic HTML can improve the usability of a Web-based application since, even with high-speed Internet connections, making a request to a Web server, receiving the response, and rendering the new page can take a noticeable amount of time. To further confuse things, dynamically generated pages (in other words, generated on the server) could also contain Dynamic HTML (code to be run on the client.) For the purposes of this book, you'll stick to dynamically generating plain old nondynamic HTML.

5http://www.fractalconcept.com/asp/html/mod_lisp.html

6http://lisplets.sourceforge.net/

7AllegroServe also provides a framework called Webactions that's analogous to JSPs in the Java world--instead of writing code that generates HTML, with Webactions you write pages that are essentially HTML with a bit of magic foo that turns into code to be run when the page is served. I won't cover Webactions in this book.

8Loading PortableAllegroServe will create some other packages for the compatibility libraries, but the packages you'll care about are those three.

9The ~@ followed by a newline tells FORMAT to ignore whitespace after the newline, which allows you to indent your code nicely without adding a bunch of whitespace to the HTML. Since white-space is typically not significant in HTML, this doesn't matter to the browser, but it makes the generated HTML source look a bit nicer to humans.

10FOO is a recursive tautological acronym for FOO Outputs Output.

11For information about the meaning of the other parameters, see the AllegroServe documentation and RFC 2109, which describes the cookie mechanism.

12You need to use LET* rather than a LET to allow the default value forms for parameters to refer to parameters that appear earlier in the parameter list. For example, you could write this:

(define-url-function (request (x integer 10) (y integer (* 2 x))) ...)

and the value of y, if not explicitly supplied, would be twice the value of x.

Copyright © 2003-2005, Peter Seibel

27. Practical: An MP3 Database

In this chapter you'll revisit the idea first explored in Chapter 3 of building an in-memory database out of basic Lisp data structures. This time your goal is to hold information that you'll extract from a collection of MP3 files using the ID3v2 library from Chapter 25. You'll then use this database in Chapters 28 and 29 as part of a Web-based streaming MP3 server. Of course, this time around you can use some of the language features you've learned since Chapter 3 to build a more sophisticated version.

The Database

The main problem with the database in Chapter 3 is that there's only one table, the list stored in the variable *db*. Another is that the code doesn't know anything about what type of values are stored in different columns. In Chapter 3 you got away with that by using the fairly general-purpose EQUAL method to compare column values when selecting rows from the database, but you would've been in trouble if you had wanted to store values that couldn't be compared with EQUAL or if you had wanted to sort the rows in the database since there's no ordering function that's as general as EQUAL.

This time you'll solve both problems by defining a class, table, to represent individual database tables. Each table instance will consist of two slots--one to hold the table's data and another to hold information about the columns in the table that database operations will be able to use. The class looks like this:

(defclass table () ((rows :accessor rows :initarg :rows :initform (make-rows)) (schema :accessor schema :initarg :schema)))

As in Chapter 3, you can represent the individual rows with plists, but this time around you'll create an abstraction that will make that an implementation detail you can change later without too much trouble. And this time you'll store the rows in a vector rather than a list since certain operations that you'll want to support, such as random access to rows by a numeric index and the ability to sort a table, can be more efficiently implemented with vectors.

The function make-rows used to initialize the rows slot can be a simple wrapper around MAKE-ARRAY that builds an empty, adjustable,vector with a fill pointer.

The Package

The package for the code you'll develop in this chapter looks like this:

(defpackage :com.gigamonkeys.mp3-database (:use :common-lisp :com.gigamonkeys.pathnames :com.gigamonkeys.macro-utilities :com.gigamonkeys.id3v2) (:export :*default-table-size* :*mp3-schema* :*mp3s* :column :column-value :delete-all-rows :delete-rows :do-rows :extract-schema :in :insert-row :load-database :make-column :make-schema :map-rows :matching :not-nullable :nth-row :random-selection :schema :select :shuffle-table :sort-rows :table :table-size :with-column-values))

The :use section gives you access to the functions and macros whose names are exported from the packages defined in Chapter 15, 8, and 25 and the :export section exports the API this library will provide, which you'll use in Chapter 29.

(defparameter *default-table-size* 100) (defun make-rows (&optional (size *default-table-size*)) (make-array size :adjustable t :fill-pointer 0))

To represent a table's schema, you need to define another class, column, each instance of which will contain information about one column in the table: its name, how to compare values in the column for equality and ordering, a default value, and a function that will be used to normalize the column's values when inserting data into the table and when querying the table. The schema slot will hold a list of column objects. The class definition looks like this:

(defclass column () ((name :reader name :initarg :name) (equality-predicate :reader equality-predicate :initarg :equality-predicate) (comparator :reader comparator :initarg :comparator) (default-value :reader default-value :initarg :default-value :initform nil) (value-normalizer :reader value-normalizer :initarg :value-normalizer :initform #'(lambda (v column) (declare (ignore column)) v))))

The equality-predicate and comparator slots of a column object hold functions used to compare values from the given column for equivalence and ordering. Thus, a column containing string values might have STRING= as its equality-predicate and STRING< as its comparator, while a column containing numbers might have = and <.

The default-value and value-normalizer slots are used when inserting rows into the database and, in the case of value-normalizer, when querying the database. When you insert a row into the database, if no value is provided for a particular column, you can use the value stored in the column's default-value slot. Then the value--defaulted or otherwise--is normalized by passing it and the column object to the function stored in the value-normalizer slot. You pass the column in case the value-normalizer function needs to use some data associated with the column object. (You'll see an example of this in the next section.) You should also normalize values passed in queries before comparing them with values in the database.

Thus, the value-normalizer's responsibility is primarily to return a value that can be safely and correctly passed to the equality-predicate and comparator functions. If the value-normalizer can't figure out an appropriate value to return, it can signal an error.

The other reason to normalize values before you store them in the database is to save both memory and CPU cycles. For instance, if you have a column that's going to contain string values but the number of distinct strings that will be stored in the column is small--for instance, the genre column in the MP3 database--you can save space and speed by using the value-normalizer to intern the strings (translate all STRING= values to a single string object). Thus, you'll need only as many strings as there are distinct values, regardless of how many rows are in the table, and you can use EQL to compare column values rather than the slower STRING=.1

Defining a Schema

Thus, to make an instance of table, you need to build a list of column objects. You could build the list by hand, using LIST and MAKE-INSTANCE. But you'll soon notice that you're frequently making a lot column objects with the same comparator and equality-predicate combinations. This is because the combination of a comparator and equality predicate essentially defines a column type. It'd be nice if there was a way to give those types names that would allow you to say simply that a given column is a string column, rather than having to specify STRING< as its comparator and STRING= as its equality predicate. One way is to define a generic function, make-column, like this:

(defgeneric make-column (name type &optional default-value))

Now you can implement methods on this generic function that specialize on type with EQL specializers and return column objects with the slots filled in with appropriate values. Here's the generic function and methods that define column types for the type names string and number:

(defmethod make-column (name (type (eql 'string)) &optional default-value) (make-instance 'column :name name :comparator #'string< :equality-predicate #'string= :default-value default-value :value-normalizer #'not-nullable)) (defmethod make-column (name (type (eql 'number)) &optional default-value) (make-instance 'column :name name :comparator #'< :equality-predicate #'= :default-value default-value))

The following function, not-nullable, used as the value-normalizer for string columns, simply returns the value it's given unless the value is NIL, in which case it signals an error:

(defun not-nullable (value column) (or value (error "Column ~a can't be null" (name column))))

This is important because STRING< and STRING= will signal an error if called on NIL; it's better to catch bad values before they go into the table rather than when you try to use them.2

Another column type you'll need for the MP3 database is an interned-string whose values are interned as discussed previously. Since you need a hash table in which to intern values, you should define a subclass of column, interned-values-column, that adds a slot whose value is the hash table you use to intern.

To implement the actual interning, you'll also need to provide an :initform for value-normalizer of a function that interns the value in the column's interned-values hash table. And because one of the main reasons to intern values is to allow you to use EQL as the equality predicate, you should also add an :initform for the equality-predicate of #'eql.

(defclass interned-values-column (column) ((interned-values :reader interned-values :initform (make-hash-table :test #'equal)) (equality-predicate :initform #'eql) (value-normalizer :initform #'intern-for-column))) (defun intern-for-column (value column) (let ((hash (interned-values column))) (or (gethash (not-nullable value column) hash) (setf (gethash value hash) value))))

You can then define a make-column method specialized on the name interned-string that returns an instance of interned-values-column.

(defmethod make-column (name (type (eql 'interned-string)) &optional default-value) (make-instance 'interned-values-column :name name :comparator #'string< :default-value default-value))

With these methods defined on make-column, you can now define a function, make-schema, that builds a list of column objects from a list of column specifications consisting of a column name, a column type name, and, optionally, a default value.

(defun make-schema (spec) (mapcar #'(lambda (column-spec) (apply #'make-column column-spec)) spec))

For instance, you can define the schema for the table you'll use to store data extracted from MP3s like this:

(defparameter *mp3-schema* (make-schema '((:file string) (:genre interned-string "Unknown") (:artist interned-string "Unknown") (:album interned-string "Unknown") (:song string) (:track number 0) (:year number 0) (:id3-size number))))

To make an actual table for holding information about MP3s, you pass *mp3-schema* as the :schema initarg to MAKE-INSTANCE.

(defparameter *mp3s* (make-instance 'table :schema *mp3-schema*))

Inserting Values

Now you're ready to define your first table operation, insert-row, which takes a plist of names and values and a table and adds a row to the table containing the given values. The bulk of the work is done in a helper function, normalize-row, that builds a plist with a defaulted, normalized value for each column, using the values from names-and-values if available and the default-value for the column if not.

(defun insert-row (names-and-values table) (vector-push-extend (normalize-row names-and-values (schema table)) (rows table))) (defun normalize-row (names-and-values schema) (loop for column in schema for name = (name column) for value = (or (getf names-and-values name) (default-value column)) collect name collect (normalize-for-column value column)))

It's worth defining a separate helper function, normalize-for-column, that takes a value and a column object and returns the normalized value because you'll need to perform the same normalization on query arguments.

(defun normalize-for-column (value column) (funcall (value-normalizer column) value column))

Now you're ready to combine this database code with code from previous chapters to build a database of data extracted from MP3 files. You can define a function, file->row, that uses read-id3 from the ID3v2 library to extract an ID3 tag from a file and turns it into a plist that you can pass to insert-row.

(defun file->row (file) (let ((id3 (read-id3 file))) (list :file (namestring (truename file)) :genre (translated-genre id3) :artist (artist id3) :album (album id3) :song (song id3) :track (parse-track (track id3)) :year (parse-year (year id3)) :id3-size (size id3))))

You don't have to worry about normalizing the values since insert-row takes care of that for you. You do, however, have to convert the string values returned by the track and year into numbers. The track number in an ID3 tag is sometimes stored as the ASCII representation of the track number and sometimes as a number followed by a slash followed by the total number of tracks on the album. Since you care only about the actual track number, you should use the :end argument to PARSE-INTEGER to specify that it should parse only up to the slash, if any.3

(defun parse-track (track) (when track (parse-integer track :end (position #\/ track)))) (defun parse-year (year) (when year (parse-integer year)))

Finally, you can put all these functions together, along with walk-directory from the portable pathnames library and mp3-p from the ID3v2 library, to define a function that loads an MP3 database with data extracted from all the MP3 files it can find under a given directory.

(defun load-database (dir db) (let ((count 0)) (walk-directory dir #'(lambda (file) (princ #\.) (incf count) (insert-row (file->row file) db)) :test #'mp3-p) (format t "~&Loaded ~d files into database." count)))

