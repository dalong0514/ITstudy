$(e).queue(f); // Create a jQuery object holding e, and call queue method jQuery.queue(e,f); // Just call the jQuery.queue() utility function

Finally, note that queue(), dequeue(), and clearQueue() all take an optional queue name as their first argument. jQuery’s effects and animation methods use a queue named「fx」, and this is the queue that is used if you do not specify a queue name. jQuery’s queue mechanism is useful whenever you need to perform asynchronous operations sequentially: instead of passing a callback function to each asynchronous operation so that it can trigger the next function in the sequence, you can use a queue to manage the sequence instead. Simply pass a queue name other than「fx」, and remember that queued functions do not execute automatically. You must explicitly call dequeue() to run the first one, and each operation must dequeue the next one when it finishes.

Ajax with jQuery

Ajax is the popular name for web application programming techniques that use HTTP scripting (see Chapter 18) to load data as needed, without causing page refreshes. Because Ajax techniques are so useful in modern web apps, jQuery includes Ajax utilities to simplify them. jQuery defines one high-level utility method and four high-level utility functions. These high-level utilities are all based on a single powerful low-level function, jQuery.ajax(). The subsections that follow describe the high-level utilities first, and then cover the jQuery.ajax() function in detail. In order to fully understand the operation of the high-level utilities, you’ll need to understand jQuery.ajax(), even if you never need to use it explicitly.

The load() Method

The load() method is the simplest of all jQuery utilities: pass it a URL and it will asynchronously load the content of that URL and then insert that content into each of the selected elements, replacing any content that is already there. For example:

// Load and display the latest status report every 60 seconds setInterval(function() { $("#stats").load("status_report.html"); }, 60000);

We also saw the load() method in Simple Event Handler Registration, where it was used to register a handler for load events. If the first argument to this method is a function instead of a string, it behaves as an event handler registration method instead of as an Ajax method.

If you only want to display a portion of the loaded document, add a space to the URL and follow it with a jQuery selector. When the URL has loaded, the selector you specified will be used to select the portions of the loaded HTML to be displayed:

// Load and display the temperature section of the weather report $('#temp').load("weather_report.html #temperature");

Note that the selector at the end of this URL looks very much like a fragment identifier (the hash portion of the URL described in Browser Location and Navigation). The space is required, however, if you want jQuery to insert only the selected portion (or portions) of the loaded document.

The load() method accepts two optional arguments in addition to the required URL. The first is data to append to the URL or to send along with the request. If you pass a string, it is appended to the URL (after a ? or & as needed). If you pass an object, it is converted to a string of ampersand-separated name=value pairs and sent along with the request. (The details of object-to-string conversion for Ajax are in the sidebar of jQuery.getJSON()). The load() method normally makes an HTTP GET request, but if you pass a data object, it makes a POST request instead. Here are two examples:

// Load the weather report for a specified zipcode $('#temp').load("us_weather_report.html", "zipcode=02134"); // Here we use an object as data instead and specify degrees Fahrenheit $('#temp').load("us_weather_report.html", { zipcode:02134, units:'F' });

Another optional argument to load() is a callback function that will be invoked when the Ajax request completes successfully or unsuccessfully and (in the case of success) after the URL has been loaded and inserted into the selected elements. If you don’t specify any data, you can pass this callback function as the second argument. Otherwise, it should be the third argument. The callback you specify will be invoked once as a method of each of the elements in the jQuery object and will be passed three arguments to each invocation: the complete text of the loaded URL, a status code string, and the XMLHttpRequest object that was used to load the URL. The status argument is a jQuery status code, not an HTTP status code, and it will be a string like「success」,「error」, or「timeout」.

jQuery’s Ajax Status Codes

All of jQuery’s Ajax utilities, including the load() method, invoke callback functions to provide asynchronous notification of the success or failure of the request. The second argument to these callbacks is a string with one of the following values:

「success」

Indicates that the request completed successfully.

「notmodified」

This code indicates that the request completed normally but that the server sent an HTTP 304「Not Modified」response, indicating that the requested URL has not changed since it was last requested. This status code only occurs if you set the ifModified option to true. (See Common Options.) jQuery 1.4 considers a「notmodified」status code a success, but earlier versions consider it an error.

「error」

Indicates that the request did not complete successfully, because of an HTTP error of some sort. For more details, you can check the HTTP status code in the XMLHttpRequest object, which is also passed to each callback.

「timeout」

If an Ajax request does not complete within the timeout interval that you select, the error callback is invoked with this status code. By default, jQuery Ajax requests do not time out; you’ll only see this status code if you set the timeout option (Common Options).

「parsererror」

This status code indicates that the HTTP request completed successfully, but that jQuery could not parse it in the way it expected to. This status code occurs if the server sends a malformed XML document or malformed JSON text, for example. Note that this status code is「parsererror」, not「parseerror」.

Ajax Utility Functions

The other high-level jQuery Ajax utilities are functions, not methods, and are invoked directly through jQuery or $, not on a jQuery object. jQuery.getScript() loads and executes files of JavaScript code. jQuery.getJSON() loads a URL, parses it as JSON, and passes the resulting object to the callback you specify. Both of these functions call jQuery.get(), which is a more general-purpose URL fetching function. Finally, jQuery.post() works just like jQuery.get(), but it performs an HTTP POST request instead of a GET. Like the load() method, all of these functions are asynchronous: they return to their caller before anything is loaded and notify you of the results by invoking a callback function you specify.

jQuery.getScript()

The jQuery.getScript() function takes the URL of a file of JavaScript code as its first argument. It asynchronously loads and then executes that code in the global scope. It can work for both same-origin and cross-origin scripts:

// Dynamically load a script from some other server jQuery.getScript("http://example.com/js/widget.js");

You can pass a callback function as the second argument, and if you do, jQuery will invoke that function once after the code has been loaded and executed.

// Load a library and use it once it loads jQuery.getScript("js/jquery.my_plugin.js", function() { $('div').my_plugin(); // Use the library we loaded });

jQuery.getScript() normally uses an XMLHttpRequest object to fetch the text of the script to be executed. But for cross-domain requests (when the script is served by a server other than the one that served the current document), jQuery loads the script with a <script> element (see HTTP by <script>: JSONP). In the same-origin case, the first argument to your callback is the text of the script, the second argument is the status code「success」, and the third argument is the XMLHttpRequest object used to fetch the text of the script. The return value of jQuery.getScript() is also the XMLHttpRequest object in this case. For cross-origin requests, there is no XMLHttpRequest object, and the text of the script is not captured. In this case, the callback function is called with its first and third arguments undefined, and the return value of jQuery.getScript() is also undefined.

The callback function you pass to jQuery.getScript() is invoked only if the request completes successfully. If you need to be notified of errors as well as success, you’ll need to use the lower-level jQuery.ajax() function. The same is true of the three other utility functions described in this section.

jQuery.getJSON()

jQuery.getJSON() is like jQuery.getScript(): it fetches text and then processes it specially before invoking the callback you specify. Instead of executing the text as a script, jQuery.getJSON() parses it as JSON (using the jQuery.parseJSON() function: see Utility Functions). jQuery.getJSON() is only useful when passed a callback argument. If the URL is loaded successfully and if its content is successfully parsed as JSON, the resulting object will be passed as the first argument to the callback function. As with jQuery.getScript(), the second and third arguments to the callback are the status code「success」and the XMLHttpRequest object:

// Suppose data.json contains the text: '{"x":1,"y":2}' jQuery.getJSON("data.json", function(data) { // Now data is the object {x:1, y:2} });

Unlike jQuery.getScript(), jQuery.getJSON() accepts an optional data argument like the one passed to the load() method. If you pass data to jQuery.getJSON(), it must be the second argument and the callback must be the third. If you do not pass any data, the callback may be the second argument. If the data is a string, it is appended to the URL, following a ? or &. If the data is an object, it is converted to a string (see the sidebar) and then appended to the URL.

Passing Data to jQuery’s Ajax Utilities

Most of jQuery’s Ajax methods accept an argument (or an option) that specifies data to send to the server along with the URL. Usually this data takes the form of URL-encoded name=value pairs separated from each other by ampersands. (This data format is known by the MIME type「application/x-www-form-urlencoded」. You can think of it as an analog of JSON: a format for converting simple JavaScript objects to and from strings.) For HTTP GET requests, this string of data is appended to the request URL. For POST requests, it is sent as the request body, after all the HTTP headers are sent.

One way to obtain a string of data in this format is to call the serialize() method of a jQuery object that contains forms or form elements. To submit an HTML form using the load() method, for example, you might use code like this:

$("#submit_button").click(function(event) { $(this.form).load( // Replace the form by loading... this.form.action, // the form url $(this.form).serialize()); // with the form data appended to it event.preventDefault(); // Don't do the default form submission this.disabled = "disabled"; // Prevent multiple submissions });

If you set the data argument (or option) of a jQuery Ajax function to an object rather than a string, jQuery will normally (with an exception described below) convert that object to a string for you by calling jQuery.param(). This utility function treats object properties as name=value pairs and converts the object {x:1,y:"hello"}, for example, to the string "x=1&y=hello".

In jQuery 1.4, jQuery.param() handles more complicated JavaScript objects. If the value of an object property is an array, each element of that array will have its own name/value pair in the resulting string and the property name will have square brackets appended. And if the value of a property is an object, the property names of that nested object are placed in square brackets and appended to the outer property name. For example:

$.param({a:[1,2,3]}) // Returns "a[]=1&a[]=2&a[]=3" $.param({o:{x:1,y:true}}) // Returns "o[x]=1&o[y]=true" $.param({o:{x:{y:[1,2]}}}) // Returns "o[x][y][]=1&o[x][y][]=2"

For backward compatibility with jQuery 1.3 and before, you can pass true as the second argument to jQuery.param() or set the traditional option to true. This will prevent the advanced serialization of properties whose values are arrays or objects.

Occasionally, you may want to pass a Document (or some other object that should not be automatically converted) as the body of a POST request. In this case you can set the contentType option to specify the type of your data and set the processData option to false, to prevent jQuery from passing your data object to jQuery.param().

If either the URL or data string passed to jQuery.getJSON() contains the string「=?」at the end of the string or before an ampersand, it is taken to specify a JSONP request. (See HTTP by <script>: JSONP for an explanation of JSONP.) jQuery will replace the question mark with the name of a callback function it creates, and jQuery.getJSON() will then behave as if a script is being requested rather than a JSON object. This does not work for static JSON data files: it only works with server-side scripts that support JSONP. Because JSONP requests are handled as scripts, however, it does mean that JSON-formatted data can be requested cross-domain.

jQuery.get() and jQuery.post()

jQuery.get() and jQuery.post() fetch the content of the specified URL, passing the specified data, if any, and pass the result to the specified callback. jQuery.get() does this using an HTTP GET request and jQuery.post() uses a POST request, but otherwise these two utility functions are the same. These two methods take the same three arguments that jQuery.getJSON() does: a required URL, an optional data string or object, and a technically optional but almost always used callback function. The callback function is invoked with the returned data as its first argument, the string「success」as its second, and the XMLHttpRequest (if there was one) as its third:

// Request text from the server and display it in an alert dialog jQuery.get("debug.txt", alert);

In addition to the three arguments described above, these two methods accept a fourth optional argument (passed as the third argument if the data is omitted) that specifies the type of the data being requested. This fourth argument affects the way the data is processed before being passed to your callback. The load() method uses the type「html」, jQuery.getScript() uses the type「script」, and jQuery.getJSON() uses the type「json」. jQuery.get() and jQuery.post() are more flexible than those special-purpose utilities, however, and you can specify any of these types. The legal values for this argument, as well as jQuery’s behavior when you omit the argument, are explained in the sidebar.

jQuery’s Ajax Data Types

You can pass any of the following six types as an argument to jQuery.get() or jQuery.post(). Additionally, as we’ll see below, you can pass one of these types to jQuery.ajax() using the dataType option:

"text"

Returns the server’s response as plain text with no processing.

"html"

This type works just like「text」: the response is plain text. The load() method uses this type and inserts the returned text into the document itself.

"xml"

The URL is assumed to refer to XML-formatted data, and jQuery uses the response XML property of the XMLHttpRequest object instead of the responseText property. The value passed to the callback is a Document object representing the XML document instead of a string holding the document text.

"script"

The URL is assumed to reference a file of JavaScript, and the returned text is executed as a script before being passed to the callback. jQuery.getScript() uses this type. When the type is「script」, jQuery can handle cross-domain requests using a <script> element instead of an XMLHttpRequest object.

"json"

The URL is assumed to reference a file of JSON-formatted data. The value passed to the callback is the object obtained by parsing the URL contents with jQuery. parse JSON() (Utility Functions). jQuery.getJSON() uses this type. If the type is「json」and the URL or data string contains "=?", the type is converted to「jsonp」.

"jsonp"

The URL is assumed to refer to a server-side script that supports the JSONP protocol for passing JSON-formatted data as an argument to a client-specified function. (See HTTP by <script>: JSONP for more on JSONP.) This type passes the parsed object to the callback function. Because JSONP requests can be made with <script> elements, this type can be used to make cross-domain requests, like the「script」type can. When you use this type, your URL or data string should typically include a parameter like "&jsonp=?" or "&callback=?". jQuery will replace the question mark with the name of an automatically generated callback function. (But see the jsonp and jsonpCallback options in Uncommon options and hooks for alternatives.)

If you do not specify one of these types when you invoke a jQuery.get(), jQuery.post(), or jQuery.ajax(), jQuery examines the Content-Type header of the HTTP response. If that header includes the string「xml」, an XML document is passed to the callback. Otherwise, if the header includes the string「json」, the data is parsed as JSON and the parsed object is passed to the callback. Otherwise, if the header includes the string「javascript」, the data is executed as a script. Otherwise, the data is treated as plain text.

The jQuery.ajax() Function

All of jQuery’s Ajax utilities end up invoking jQuery.ajax()—the most complicated function in the entire library. jQuery.ajax() accepts just a single argument: an options object whose properties specify many details about how the Ajax request is to be performed. A call to jQuery.getScript(url,callback), for example, is equivalent to this jQuery.ajax() invocation:

jQuery.ajax({ type: "GET", // The HTTP request method. url: url, // The URL of the data to fetch. data: null, // Don't add any data to the URL. dataType: "script", // Execute the response as a script once we get it. success: callback // Call this function when done. });

You can set these five fundamental options with jQuery.get() and jQuery.post(). jQuery.ajax() supports quite a few other options, however, if you invoke it directly. The options (including the basic five shown above) are explained in detail below.

Before we dive into the options, note that you can set defaults for any of these options by passing an options object to jQuery.ajaxSetup():

jQuery.ajaxSetup({ timeout: 2000, // Abort all Ajax requests after 2 seconds cache: false // Defeat browser cache by adding a timestamp to the URL });

After running the code above, the specified timeout and cache options will be used for all Ajax requests (including high-level ones like jQuery.get() and the load() method) that do not specify their own values for these options.

While reading about jQuery’s many options and callbacks in the sections that follow, you may find it helpful to refer to the sidebars about jQuery’s Ajax status code and data type strings in The load() Method and jQuery.get() and jQuery.post().

Ajax in jQuery 1.5

jQuery 1.5, which was released as this book was going to press, features a rewritten Ajax module, with several convenient new features. The most important is that jQuery.ajax() and all of the Ajax utility functions described earlier now return a jqXHR object. This object simulates the XMLHttpRequest API, even for requests (like those made with $.getScript()) that do not use an XMLHttpRequest object. Furthermore, the jqXHR object defines success(), error() methods that you can use to register callback functions to be invoked when the request succeeds or fails. So instead of passing a callback to jQuery.get(), for example, you might instead pass it to the success() method of the jqXHR object returned by that utility function:

jQuery.get("data.txt") .success(function(data) { console.log("Got", data); }) .success(function(data) { process(data); });

Common Options

The most commonly used jQuery.ajax() options are the following:

type

Specifies the HTTP request method. The default is「GET」.「POST」is another commonly used value. You can specify other HTTP request methods, such as「DELETE」and「PUT」, but not all browsers support them. Note that this option is misleadingly named: it has nothing to do with the data type of the request or response, and「method」would be a better name.

url

The URL to be fetched. For GET requests, the data option will be appended to this URL. jQuery may add parameters to the URL for JSONP requests and when the cache option is false.

data

Data to be appended to the URL (for GET requests) or sent in the body of the request (for POST requests). This can be a string or an object. Objects are usually converted to strings as described in the sidebar of jQuery.getJSON(), but see the processData option for an exception.

dataType

Specifies the type of data expected in the response, and the way that that data should be processed by jQuery. Legal values are「text」,「html」,「script」,「json」,「jsonp」, and「xml」. The meanings of these values were explained in the sidebar in jQuery.get() and jQuery.post(). This option has no default value. When left unspecified, jQuery examines the Content-Type header of the response to determine what to do with the returned data.

contentType

Specifies the HTTP Content-Type header for the request. The default is「application/x-www-form-urlencoded」, which is the normal value used by HTML forms and most server-side scripts. If you have set type to「POST」and want to send plain text or an XML document as the request body, you also need to set this option.

timeout

A timeout, in milliseconds. If this option is set and the request has not completed within the specified timeout, the request will be aborted and the error callback will be called with status「timeout」. The default timeout is 0, which means that requests continue until they complete and are never aborted.

cache

For GET requests, if this option is set to false, jQuery will add a _= parameter to the URL or replace an existing parameter with that name. The value of this parameter is set to the current time (in millisecond format). This defeats browser-based caching, since the URL will be different each time the request is made.

ifModified

When this option is set to true, jQuery records the values of the Last-Modified and If-None-Match response headers for each URL it requests and then sets those headers in any subsequent requests for the same URL. This instructs the server to send an HTTP 304「Not Modified」response if the URL has not changed since the last time it was requested. By default, this option is unset and jQuery does not set or record these headers.

jQuery translates an HTTP 304 response to the status code「notmodified」. The「notmodified」status is not considered an error, and this value is passed to the success callback instead of the normal「success」status code. Thus, if you set the ifModified option, you must check the status code in your callback—if the status is「notmodified」, the first argument (the response data) will be undefined. Note that in versions of jQuery before 1.4, a HTTP 304 code was considered an error and the「notmodified」status code was passed to the error callback instead of the success callback. See the sidebar in The load() Method for more on jQuery’s Ajax status codes.

global

This option specifies whether jQuery should trigger events that describe the progress of the Ajax request. The default is true; set this option to false to disable all Ajax-related events. (See Ajax Events for full event details.) The name of this option is confusing: it is named「global」because jQuery normally triggers its events globally rather than on a specific object.

Callbacks

The following options specify functions to be invoked at various stages during the Ajax request. The success option is already familiar: it is the callback function that you pass to methods like jQuery.getJSON(). Note that jQuery also sends notification about the progress of an Ajax request as events (unless you have set the global option to false) .

context

This option specifies the object to be used as the context—the this value—for invocations of the various callback functions. This option has no default value, and if left unset, callbacks are invoked on the options object that holds them. Setting the context option also affects the way Ajax events are triggered (see Ajax Events). If you set it, the value should be a Window, Document, or Element on which events can be triggered.

beforeSend

This option specifies a callback function that will be invoked before the Ajax request is sent to the server. The first argument is the XMLHttpRequest object and the second argument is the options object for the request. The beforeSend callback gives programs the opportunity to set custom HTTP headers on the XMLHttp Request object. If this callback function returns false, the Ajax request will be aborted. Note that cross-domain「script」and「jsonp」requests do not use an XMLHttpRequest object and do not trigger the beforeSend callback.

success

This option specifies the callback function to be invoked when an Ajax request completes successfully. The first argument is the data sent by the server. The second argument is the jQuery status code, and the third argument is the XMLHttpRequest object that was used to make the request. As explained in jQuery.get() and jQuery.post(), the type of the first argument depends on the dataType option or on the Content-Type header of the server’s response. If the type is「xml」, the first argument is a Document object. If the type is「json」or「jsonp」, the first argument is the object that results from parsing the server’s JSON-formatted response. If the type was「script」, the response is the text of the loaded script (that script will already have been executed, however, so the response can usually be ignored in this case). For other types, the response is simply the text of the requested resource.

The second argument status code is normally the string「success」, but if you have set the ifModified option, this argument might be「notmodified」instead. In this case, the server does not send a response and the first argument is undefined. Cross-domain requests of type「script」and「jsonp」are performed with a <script> element instead of an XMLHttpRequest, so for those requests, the third argument will be undefined.

error

This option specifies the callback function to be invoked if the Ajax request does not succeed. The first argument to this callback is the XMLHttpRequest object of the request (if it used one). The second argument is the jQuery status code. This may be「error」for an HTTP error,「timeout」for a timeout, and「parsererror」for an error that occurred while parsing the server’s response. If an XML document or JSON object is not well-formed, for example, the status code will be「parsererror」. In this case, the third argument to the error callback will be the Error object that was thrown. Note that requests with dataType「script」that return invalid JavaScript code do not cause errors. Any errors in the script are silently ignored, and the success callback is invoked instead of the error callback.

complete

This option specifies a callback function to be invoked when the Ajax request is complete. Every Ajax request either succeeds and calls the success callback or fails and calls the error callback. jQuery invokes the complete callback after invoking either success or error. The first argument to the complete callback is the XMLHttpRequest object, and the second is the status code.

Uncommon options and hooks

The following Ajax options are not commonly used. Some specify options that you are not likely to set and others provide customization hooks for those who need to modify jQuery’s default handling of Ajax requests.

async

Scripted HTTP requests are asynchronous by their very nature. The XMLHttpRequest object provides an option to block until the response is received, however. Set this option to false if you want jQuery to block. Setting this option does not change the return value of jQuery.ajax(): the function always returns the XMLHttpRequest object, if it used one. For synchronous requests, you can extract the server’s response and HTTP status code from the XMLHttpRequest object yourself, or you can specify a complete callback (as you would for an asynchronous request) if you want jQuery’s parsed response and status code.

dataFilter

This option specifies a function to filter or preprocess the data returned by the server. The first argument will be the raw data from the server (either as a string or Document object for XML requests) and the second argument will be the value of the dataType option. If this function is specified, it must return a value, and that value will be used in place of the server’s response. Note that the dataFilter function is invoked before JSON parsing or script execution is performed. Also note that dataFilter is not invoked for cross-origin「script」and「jsonp」requests.

jsonp

When you set the dataType option to「jsonp」, your url or data option usually includes a parameter like「jsonp=?」. If jQuery does not find such a parameter in the URL or data, it inserts one, using this option as the parameter name. The default value of this option is「callback」. Set this option if you are using JSONP with a server that expects a different parameter name and have not already encoded that parameter into your URL or data. See HTTP by <script>: JSONP for more about JSONP.

jsonpCallback

For requests with dataType「jsonp」(or type「json」when the URL includes a JSONP parameter like「jsonp=?」), jQuery must alter the URL to replace the question mark with the name of the wrapper function that the server will pass its data to. Normally, jQuery synthesizes a unique function name based on the current time. Set this option if you want to substitute your own function for jQuery’s. If you do this, however, it will prevent jQuery from invoking the success and complete callbacks and from triggering its normal events.

processData

When you set the data option to an object (or pass an object as the second argument to jQuery.get() and related methods), jQuery normally converts that object to a string in the standard HTML「application/x-www-form-urlencoded」format (see the sidebar in jQuery.getJSON()). If you want to avoid this step (such as when you want to pass a Document object as the body of a POST request), set this option to false.

scriptCharset

For cross-origin「script」and「jsonp」requests that use a <script> element, this option specifies the value of the charset attribute of that element. It has no effect for regular XMLHttpRequest-based requests.

traditional

jQuery 1.4 altered slightly the way that data objects were serialized to「application/x-www-form-urlencoded」strings (see the sidebar in jQuery.getJSON() for details). Set this option to true if you need jQuery to revert to its old behavior.

username, password

If a request requires password-based authentication, specify the username and password using these two options.

xhr

This option specifies a factory function for obtaining an XMLHttpRequest. It is invoked with no arguments and must return an object that implements the XMLHttpRequest API. This very low-level hook allows you create your own wrapper around XMLHttpRequest, adding features or instrumentation to its methods.

Ajax Events

Callbacks explained that jQuery.ajax() has four callback options: beforeSend, success, error, and complete. In addition to invoking these individually specified callback functions, jQuery’s Ajax functions also fire custom events at each of the same stages in a Ajax request. The following table shows the callback options and the corresponding events:

CallbackEvent TypeHandler Registration Method

beforeSend「ajaxSend」ajaxSend()

success「ajaxSuccess」ajaxSuccess()

error「ajaxError」ajaxError()

complete「ajaxComplete」ajaxComplete()

「ajaxStart」ajaxStart()

「ajaxStop」ajaxStop()

You can register handlers for these custom Ajax events using the bind() method (Advanced Event Handler Registration) and the event type string shown in the second column or using the event registration methods shown in the third column. ajaxSuccess() and the other methods work just like the click(), mouseover(), and other simple event registration methods of Simple Event Handler Registration.

Since the Ajax events are custom events, generated by jQuery rather than the browser, the Event object passed to the event handler does not contain much useful detail. The ajaxSend, ajaxSuccess, ajaxError, and ajaxComplete events are all triggered with additional arguments, however. Handlers for these events will all be invoked with two extra arguments after the event. The first extra argument is the XMLHttpRequest object and the second extra argument is the options object. This means, for example, that a handler for the ajaxSend event can add custom headers to an XMLHttpRequest object just like the beforeSend callback can. The ajaxError event is triggered with a third extra argument, in addition to the two just described. This final argument to the event handler is the Error object, if any, that was thrown when the error occurred. Surprisingly, these Ajax events are not passed jQuery’s status code. If the handler for an ajaxSuccess event needs to distinguish「success」from「notmodified」, for example, it will need to examine the raw HTTP status code in the XMLHttpRequest object.

The last two events listed in the table above are different from the others, most obviously because they have no corresponding callback functions, and also because they are triggered with no extra arguments. ajaxStart and ajaxStop are a pair of events that indicate the start and stop of Ajax-related network activity. When jQuery is not performing any Ajax requests and a new request is initiated, it fires an ajaxStart event. If other requests begin before this first one ends, those new requests do not cause a new ajaxStart event. The ajaxStop event is triggered when the last pending Ajax request is completed and jQuery is no longer performing any network activity. This pair of events can be useful to show and hide some kind of「Loading...」animation or network activity icon. For example:

$("#loading_animation").bind({ ajaxStart: function() { $(this).show(); }, ajaxStop: function() { $(this).hide(); } });

These ajaxStart and ajaxStop event handlers can be bound to any document element: jQuery triggers them globally (Triggering Events) rather than on any one particular element. The other four Ajax events, ajaxSend, ajaxSuccess, ajaxError, and ajaxComplete, are also normally triggered globally, so you can bind handlers to any element. If you set the context option in your call to jQuery.ajax(), however, these four events are triggered on the context element rather than globally.

Finally, remember that you can prevent jQuery from triggering any Ajax-related events by setting the global option to false. Despite its confusing name, setting global to false stops jQuery from triggering events on a context object as well as stopping jQuery from triggering events globally.

Utility Functions

The jQuery library defines a number of utility functions (as well as two properties) that you may find useful in your programs. As you’ll see in the list below, a number of these functions now have equivalents in ECMAScript 5 (ES5). jQuery’s functions predate ES5 and work in all browsers. In alphabetical order, the utility functions are:

jQuery.browser

The browser property is not a function but an object that you can use for client sniffing (Browser Testing). This object will have the property msie set to true if the browser is IE. The mozilla property will be true if the browser is Firefox or related. The webkit property will be true for Safari and Chrome, and the opera property will be true for Opera. In addition to this browser-specific property, the version property contains the browser version number. Client sniffing is best avoided whenever possible, but you can use this property to work around browser-specific bugs with code like this:

if ($.browser.mozilla && parseInt($.browser.version) < 4) { // Work around a hypothetical Firefox bug here... }

jQuery.contains()

This function expects two document elements as its arguments. It returns true if the first element contains the second element and returns false otherwise.

jQuery.each()

Unlike the each() method which iterates only over jQuery objects, the jQuery.each() utility function iterates through the elements of an array or the properties of an object. The first argument is the array or object to be iterated. The second argument is the function to be called for each array element or object property. That function will be invoked with two arguments: the index or name of the array element or object property, and the value of the array element or object property. The this value for the function is the same as the second argument. If the function returns false, jQuery.each() returns immediately without completing the iteration. jQuery.each() always returns its first argument.

jQuery.each() enumerates object properties with an ordinary for/in loop, so all enumerable properties are iterated, even inherited properties. jQuery.each() enumerates array elements in numerical order by index and does not skip the undefined properties of sparse arrays.

jQuery.extend()

This function expects objects as its arguments. It copies the properties of the second and subsequent objects into the first object, overwriting any properties with the same name in the first argument. This function skips any properties whose value is undefined or null. If only one object is passed, the properties of that object are copied into the jQuery object itself. The return value is the object into which properties were copied. If the first argument is the value true, a deep or recursive copy is performed: the second argument is extended with the properties of the third (and any subsequent) objects.

This function is useful for cloning objects and for merging options objects with sets of defaults:

var clone = jQuery.extend({}, original); var options = jQuery.extend({}, default_options, user_options);

jQuery.globalEval()

This function executes a string of JavaScript code in the global context, as if it were the contents of a <script> element. (In fact, jQuery actually implements this function by creating a <script> element and temporarily inserting it into the document.)

jQuery.grep()

This function is like the ES5 filter() method of the Array object. It expects an array as its first argument and a predicate function as its second, and it invokes the predicate once for each element in the array, passing the element value and the element index. jQuery.grep() returns a new array that contains only those elements of the argument array for which the predicate returned true (or another truthy value). If you pass true as the third argument to jQuery.grep(), it inverts the sense of the predicate and returns an array of elements for which the predicate returned false or another falsy value.

jQuery.inArray()

This function is like the ES5 indexOf() method of the Array object. It expects an arbitrary value as its first argument and an array (or array-like object) as its second and returns the first index in the array at which the value appears, or -1 if the array does not contain the value.

jQuery.isArray()

Returns true if the argument is a native Array object.

jQuery.isEmptyObject

Returns true if the argument has no enumerable properties.

jQuery.isFunction()

Returns true if the argument is a native Function object. Note that in IE8 and earlier, browser methods like Window.alert() and Element.attachEvent() are not functions in this sense.

jQuery.isPlainObject()

Returns true if the argument is a「plain」object rather than an instance of some more specialized type or class of objects.

jQuery.makeArray()

If the argument is an array-like object, this function copies the elements of that object into a new (true) array and returns that array. If the argument is not array-like, this function simply returns a new array with the argument as its single element.

jQuery.map()

This function is like the ES5 map() method of the Array object. It expects an array or array-like object as its first argument and a function as its second. It passes each array element along with the index of that element to the function and returns a new array that collects the values returned by the function. jQuery.map() differs from the ES5 map() method in a couple of ways. If your mapping function returns null, that value will not be included in the result array. And if your mapping function returns an array, the elements of that array will be added to the result rather than the array itself.

jQuery.merge()

This function expects two arrays or array-like objects. It appends the elements of the second to the first and returns the first. The first array is modified, the second is not. Note that you can use this function to shallowly clone an array like this:

var clone = jQuery.merge([], original);

jQuery.parseJSON()

This function parses a JSON-formatted string and returns the resulting value. It throws an exception when passed malformed input. jQuery uses the standard JSON.parse() function in browsers that define it. Note that jQuery defines only a JSON parsing function, not a JSON serialization function.

jQuery.proxy()

This function is something like the ES5 bind() (The bind() Method) method of the Function object. It takes a function as its first argument and an object as its second and returns a new function that invokes the function as a method of the object. It does not perform partial application of arguments like the bind() method does.

jQuery.proxy() can also be invoked with an object as its first argument and a property name as its second. The value of the named property should be a function. Invoked in this way, the function jQuery.proxy(o,n) returns the same thing that jQuery.proxy(o[n],o) does.

jQuery.proxy() is intended for use with jQuery’s event handler binding mechanism. If you bind a proxied function, you can unbind it using the original function.

jQuery.support

This is a property like jQuery.browser, but it is intended for portable feature testing (Feature Testing) rather than more brittle browser testing. The value of jQuery.support is an object whose properties are all boolean values that specify the presence or absence of browser features. Most of these jQuery.support properties are low-level details used internally by jQuery. They may be of interest to plug-in writers, but most are not generally useful to application writers. One exception is jQuery. support. boxModel: this property is true if the browser uses the CSS standard「context-box」model and is false in IE6 and IE7 in quirks mode (see The border-box model and the box-sizing property).

jQuery.trim()

This function is like the trim() method added to strings in ES5. It expects a string as its only argument and returns a copy of that string with leading and trailing whitespace removed.

jQuery Selectors and Selection Methods

Throughout this chapter, we’ve been using the jQuery selection function, $(), with simple CSS selectors. It is now time to study the jQuery selector grammar in depth, along with a number of methods for refining and augmenting the set of selected elements.

jQuery Selectors

jQuery supports a fairly complete subset of the selector grammar defined by the CSS3 Selectors draft standard, with the addition of some nonstandard but very useful pseudoclasses. Basic CSS selectors were described in Selecting Elements with CSS Selectors. We repeat that material here, and add explanations for more advanced selectors as well. Bear in mind that this section documents jQuery selectors. Many, but not all, of these selectors can also be used in CSS stylesheets.

The selector grammar has three layers. You’ve undoubtedly seen the simplest kind of selectors before.「#test」selects an element with an id attribute of「test」.「blockquote」selects all <blockquote> elements in the document, and「div.note」selects all <div> elements with a class attribute of「note」. Simple selectors can be combined into「selector combinations」such as「div.note>p」and「blockquote i」by separating them with a combinator character. And simple selectors and selector combinations can be grouped into comma-separated lists. These selector groups are the most general kind of selector that we pass to $(). Before explaining selector combinations and selector groups, we must explain the syntax of simple selectors.

Simple selectors

A simple selector begins (explicitly or implicitly) with a tag type specification. If you are only interested in <p> elements, for example, your simple selector would begin with「p」. If you want to select elements without regard to their tagname, use the wildcard「*」instead. If a selector does not begin with either a tagname or a wildcard, the wildcard is implicit.

The tagname or wildcard specifies an initial set of document elements that are candidates for selection. The portion of the simple selector that follows this type specification consists of zero or more filters. The filters are applied left-to-right, in the order that they appear, and each one narrows the set of selected elements. Table 19-1 lists the filters supported by jQuery.

Table 19-1. jQuery Selector Filters

FilterMeaning

# id Matches the element with an id attribute of id. Valid HTML documents never have more than one element with the same ID, so this filter is usually used as a stand-alone selector.

. class Matches any elements whose class attribute (when interpreted as a list of words separated by spaces) includes the word class.

[ attr ] Matches any elements that have an attr attribute (regardless of its value).

[ attr = val ] Matches any elements that have an attr attribute whose value is val.

[ attr != val ] Matches elements that have no attr attribute, or whose attr attribute is not equal to val (jQuery extension).

[ attr ^= val ] Matches elements whose attr attribute has a value that begins with val.

[ attr $= val ] Matches elements whose attr attribute has a value that ends with val.

[ attr *= val ] Matches elements whose attr attribute has a value that contains val.

[ attr ~= val ] Matches elements whose attr attribute, when interpreted as a list of words separated by spaces, includes the word val. Thus the selector「div.note」is the same as「div[class~=note]」.

[ attr |= val ] Matches elements whose attr attribute has a value that begins with val and is optionally followed by a hyphen and any other characters.

:animated Matches elements that are currently being animated by jQuery.

:button Matches <button type="button"> and <input type="button"> elements (jQuery extension).

:checkbox Matches <input type="checkbox"> elements (jQuery extension). This filter is most efficient when explicitly prefixed with the input tag:「input:checkbox」.

:checked Matches input elements that are checked.

:contains( text ) Matches elements that contain the specified text (jQuery extension). The parentheses of this filter delimit the text—no quotation marks are required. The text of the elements being filtered is determined with their textContent or innerText properties—this is the raw document text, with tags and comments stripped out.

:disabled Matches disabled elements.

:empty Matches elements that have no children, including no text content.

:enabled Matches elements that are not disabled.

:eq( n ) Matches only the nth element of the document-order zero-indexed list of matches (jQuery extension).

:even Matches elements with even indexes in the list. Since the first element has an index of 0, this actually matches the first, third, and fifth (and so on) elements (jQuery extension).

:file Matches <input type="file"> elements (jQuery extension).

:first Matches only the first element in the list. Same as :eq(0) (jQuery extension).

:first-child Matches only elements that are the first child of their parent. Note that this is completely different than :first.

:gt( n ) Matches elements in the document-order list of matches whose zero-based index is greater than n (jQuery extension).

:has( sel ) Matches elements that have a descendant matching the nested selector sel.

:header Matches any header element: <h1>, <h2>, <h3>, <h4>, <h5>, or <h6> (jQuery extension).

:hidden Matches any element that is not visible on the screen: roughly those elements whose offsetWidth and offsetHeight are 0.

:image Matches <input type="image"> elements. Note that this does not match <img> elements (jQuery extension).

:input Matches user input elements: <input>, <textarea>, <select>, and <button> (jQuery extension).

:last Matches the last element in the list of matches (jQuery extension).

:last-child Matches any element that is the last child of its parent. Note that this is not the same as :last.

:lt( n ) Matches all elements in the document-order list of matches whose zero-based index is less than n (jQuery extension).

:not( sel ) Matches elements that are not matched by the nested selector sel.

:nth( n ) A synonym for :eq(n) (jQuery extension).

:nth-child( n ) Matches elements that are the nth child of their parent. n can be a number, the word「even」, the word「odd」, or a formula. Use :nth-child(even) to select elements that are the second and fourth (and so on) in their parent’s list of children. Use :nth-child(odd) to select elements that are first, third, and so on.

Most generally, n can be a formula of the form xn or xn+y where x and y are integers and n is the literal letter n. Thus nth-child(3n+1) selects the first, fourth, and seventh (and so on) elements.

Note that this filter uses one-based indexes, so an element that is the first child of its parent is considered odd and is matched by 3n+1, not 3n. Contrast this with the :even and :odd filters that filter based on an element’s zero-based position in the list of matches.

:odd Matches elements with odd (zero-based) indexes in the list. Note that elements 1 and 3 are the second and fourth matched element, respectively (jQuery extension).

:only-child Matches elements that are the only child of their parent.

:parent Matches elements that are parents. This is the opposite of :empty (jQuery extension).

:password Matches <input type="password"> elements (jQuery extension).

:radio Matches <input type="radio"> elements (jQuery extension).

:reset Matches <input type="reset"> and <button type="reset"> elements (jQuery extension).

:selected Matches <option> elements that are selected. Use :checked for selected checkboxes and radio buttons (jQuery extension).

:submit Matches <input type="submit"> and <button type="submit"> elements (jQuery extension).

:text Matches <input type="text"> elements (jQuery extension).

:visible Matches all elements that are currently visible: roughly those that have nonzero offsetWidth and offsetHeight. This is the opposite of :hidden.

Notice that some of the filters listed in Table 19-1 accept arguments within parentheses. The following selector, for example, selects paragraphs that are the first or every third subsequent child of their parent, as long as they contain the word「JavaScript」and do not contain an <a> element.

p:nth-child(3n+1):text(JavaScript):not(:has(a))

Filters typically run most efficiently if prefixed with a tag type. Rather than simply using「:radio」to select radio buttons, for example, it is better to use「input:radio」. The exception is ID filters, which are most efficient when they stand alone. The selector「#address」is typically more efficient than the more explicit「form#address」, for example.

Selector combinations

Simple selectors can be combined using special operators or「combinators」to represent relationships between elements in the document tree. Table 19-2 lists the selector combinations supported by jQuery. These are the same selector combinations that CSS3 supports.

Table 19-2. jQuery Selector Combinations

CombinationMeaning

A B Selects document elements that match selector B that are descendants of elements that match selector A. Note that the combinator character is simply whitespace for this combination.

A > B Selects document elements that match selector B that are direct children of elements that match selector A.

A + B Selects document elements that match selector B and immediately follow (ignoring text nodes and comments) elements that match selector A.

A ~ B Selects document elements matching B that are sibling elements that come after elements that match A.

Here are some example selector combinations:

"blockquote i" // Matches an <i> element within a <blockquote> "ol > li" // An <li> element as a direct child of an <ol> "#output + *" // The sibling after the element with id="output" "div.note > h1 + p" // A <p> following a <h1> inside a <div class="note">

Note that selector combinations are not limited to combinations of two selectors: three or more selectors are allowed, too. Selector combinations are processed left to right.

Selector groups

A selector group, which is the kind of selector that we pass to $() (or use in a stylesheet), is simply a comma-separated list of one or more simple selectors or selector combinations. A selector group matches all elements that match any of the selector combinations in the group. For our purposes here, even a simple selector can be considered a selector combination. Here are some example selector groups:

"h1, h2, h3" // Matches <h1>, <h2>, and <h3> elements "#p1, #p2, #p3" // Matches elements with id p1, p2, and p3 "div.note, p.note" // Matches <div> and <p> elements with class="note" "body>p,div.note>p" // <p> children of <body> and <div class="note">

Note that the CSS and jQuery selector syntax uses parentheses for some of the filters in simple selectors, but it does not allow parentheses to be used more generally for grouping. You cannot put a selector group or selector combination in parentheses and treat it like a simple selector, for example:

(h1, h2, h3)+p // Not legal h1+p, h2+p, h3+p // Write this instead

Selection Methods

In addition to the selector grammar supported by $(), jQuery defines a number of selection methods. Most of the jQuery methods we’ve seen so far in this chapter perform some action on the selected elements. The selection methods are different: they alter the set of selected elements by refining it, augmenting it, or just using it as a starting point for a new selection.

This section describes these selection methods. You’ll notice that many of the methods provide the same functionality as the selector grammar itself.

The simplest way to refine a selection is by position within the selection. first() returns a jQuery object that contains only the first selected element, and last() returns a jQuery object that contains only the last element. More generally, the eq() method returns a jQuery object that contains only the single selected element at the specified index. (In jQuery 1.4, negative indexes are allowed and count from the end of the selection.) Note that these methods return a jQuery object with a single element. This is different than regular array indexing, which returns a single element with no jQuery object wrapped around it:

var paras = $("p"); paras.first() // Select only the first <p> element paras.last() // Select only the last <p> paras.eq(1) // Select the second <p> paras.eq(-2) // Select the second to last <p> paras[1] // The second <p> element, itself

The general method for refining a selection by position is slice(). The jQuery slice() method works like the Array.slice() method: it accepts a start and an end index (with negative indexes measured from the end of the array) and returns a jQuery object that contains elements from the start index up to, but not including, the end index. If the end index is omitted, the returned object includes all elements at or after the start index:

$("p").slice(2,5) // Select the 3rd, 4th, and 5th <p> elements $("div").slice(-3) // The last three <div> elements

filter() is a general-purpose selection filtering method, and you can invoke it in three different ways:

If you pass a selector string to filter(), it returns a jQuery object containing only those selected elements that also match that selector.

If you pass another jQuery object to filter(), it returns a new jQuery object that contains the intersection of the two jQuery objects. You can also pass an array of elements, or even a single document element, to filter().

If you pass a predicate function to filter(), that function is called for each matched element, and filter() returns a jQuery object containing only those elements for which the predicate returned true (or any truthy value). The predicate function is called with the element as its this value and the element index as an argument. (See also jQuery.grep() in Utility Functions.)

$("div").filter(".note") // Same as $("div.note") $("div").filter($(".note")) // Same as $("div.note") $("div").filter(function(idx) { return idx%2==0 }) // Same as $("div:even")

The not() method is just like filter(), except that it inverts the sense of the filter. If you pass a selector string to not(), it returns a new jQuery object containing only the selected elements that do not match the selector. If you pass a jQuery object or an array of elements or a single element, not() returns all of the selected elements except for the elements you’ve explicitly excluded. If you pass a predicate function to not(), it is invoked just as it is for filter(), but the returned jQuery object includes only those elements for which the predicate returns false or a falsy value:

$("div").not("#header, #footer"); // All <div> elements except two special ones

In jQuery 1.4, the has() method is another way to refine a selection. If you pass a selector, it returns a new jQuery object that contains only the selected elements that have a descendant that matches the selector. If you pass a document element to has(), it refines the selection to match only those elements that are ancestors of the specified element:

$("p").has("a[href]") // Paragraphs that include links

The add() method augments a selection rather than filtering or refining it. You can invoke add() with any arguments (other than a function) that you would pass to $(). add() returns the originally selected elements plus whatever elements would be selected (or created) by the arguments if those arguments were passed to $(). add() removes duplicate elements and sorts the combined selection so that the elements are in document order:

// Equivalent ways to select all <div> and all <p> elements $("div, p") // Use a selector group $("div").add("p") // Pass a selector to add() $("div").add($("p")) // Pass a jQuery object to add() var paras = document.getElementsByTagName("p"); // An array-like object $("div").add(paras); // Pass an array of elements to add()

Using a selection as context

The filter(), add(), and not() methods described above perform set intersection, union, and subtraction operations on independent selections. jQuery defines a number of other selection methods that use the current selection as the context. For each selected element, these methods make a new selection using the selected element as the context or starting point, and then return a new jQuery object that contains the union of those selections. As with the add() method, duplicates are removed and the elements are sorted so that they are in document order.

The most general of this category of selection methods is find(). It searches the descendants of each of the currently selected elements for elements that match the specified selector string, and it returns a new jQuery object that represents that new set of matching descendants. Note that the newly selected elements are not merged with the existing selection; they are returned as a new set of elements. Note also that find() is not the same as filter(), which simply narrows the currently selected set of elements without selecting new elements:

$("div").find("p") // find <p> elements inside <div>s. Same as $("div p")

The other methods in this category return new jQuery objects that represent the children, siblings, or parents of each of the currently selected elements. Most accept an optional selector string as an argument. With no selector, they return all appropriate children, siblings, or parents. With the selector, they filter the list to return only those that match.

The children() method returns the immediate child elements of each selected element, filtering them with an optional selector:

// Find all <span> elements that are direct children of the elements with // ids "header" and "footer". Same as $("#header>span,#footer>span") $("#header, #footer").children("span")

The contents() method is similar to children(), but it returns all child nodes, including text nodes, of each element. Also, if any of the selected elements is an <iframe>, contents() returns the document object for the content of that <iframe>. Note that contents() does not accept an optional selector string—this is because it returns document nodes that are not elements, and selector strings only describe element nodes.

The next() and prev() methods return the next and previous sibling of each selected element that has one. If a selector is specified, the sibling is selected only if it matches the selector:

$("h1").next("p") // Same as $("h1+p") $("h1").prev() // Sibling elements before <h1> elements

nextAll() and prevAll() return all siblings following and all siblings preceding (if there are any) each selected element. And the siblings() method returns all siblings of each selected element (elements are not considered siblings of themselves). If a selector is passed to any of these methods, only siblings that match are returned:

$("#footer").nextAll("p") // All <p> siblings following the #footer element $("#footer").prevAll() // All siblings before the #footer element

In jQuery 1.4 and later, the nextUntil() and prevUntil() methods take a selector argument and select all siblings following or preceding the selected element until a sibling is found that matches the selector. If you omit the selector, these methods work just like nextAll() and prevAll() with no selector.

The parent() method returns the parent of each selected element:

$("li").parent() // Parents of list items, like <ul> and <ol> elements

The parents() method returns the ancestors (up to the <html> element) of each selected element. Both parent() and parents() accept an optional selector string argument:

$("a[href]").parents("p") // <p> elements that contain links

parentsUntil() returns the ancestors of each selected element until the first ancestor that matches the specified selector. The closest() method requires a selector string and returns the closest ancestor (if any) of each selected element that matches the selector. For this method, an element is considered an ancestor of itself. In jQuery 1.4, you can also pass an ancestor element as the second argument to closest(), to prevent jQuery from climbing the ancestor tree beyond the specified element:

$("a[href]").closest("div") // Innermost <div>s that contain links $("a[href]").parentsUntil(":not(div)") // All <div> wrappers directly around <a>

Reverting to a previous selection

To facilitate method chaining, most jQuery object methods return the object on which they are called. The methods we’ve covered in this section all return new jQuery objects, however. Method chaining works, but you must keep in mind that methods called later in the chain may be operating on a different set of elements than those near the start of the chain.

The situation is a little more complicated than this, however. When the selection methods described here create and return a new jQuery object, they give that object an internal reference to the older jQuery object from which it was derived. This creates a linked list or stack of jQuery objects. The end() method pops this stack, returning the saved jQuery object. Calling end() in a method chain restores the set of matched elements to its previous state. Consider the following code:

// Find all <div> elements, then find the <p> elements inside them. // Highlight the <p> elements and then give the <div> elements a border. // First, without method chaining var divs = $("div"); var paras = divs.find("p"); paras.addClass("highlight"); divs.css("border", "solid black 1px"); // Here's how we could do it with a method chain $("div").find("p").addClass("highlight").end().css("border", "solid black 1px"); // Or we can reorder the operations and avoid the call to end() $("div").css("border", "solid black 1px").find("p").addClass("highlight");

If you ever want to manually define the set of selected elements in a way that is compatible with the end() method, pass the new set of elements as an array or array-like object to the pushStack() method. The elements you specify become the new selected elements, and the previous set of selected elements is pushed on the stack, where they can be restored with end():

var sel = $("div"); // Select all <div> elements sel.pushStack(document.getElementsByTagName("p")); // Modify it to all <p> elts sel.end(); // Restore <div> elements

Now that we’ve covered the end() method and the selection stack that it uses, there is one final method we can cover. andSelf() returns a new jQuery object that includes all of the elements of the current selection plus all of the elements (minus duplicates) of the previous selection. andSelf() works like the add() method, and「addPrev」might be a more descriptive name for it. As an example, consider the following variant on the code above: it highlights <p> elements and the <div> elements that hold them, and then adds a border to the <div> elements:

$("div").find("p").andSelf(). // find <p>s in <div>s, and merge them addClass("highlight"). // Highlight them all end().end(). // Pop stack twice back to $("div") css("border", "solid black 1px"); // Give the divs a border

Extending jQuery with Plug-ins

jQuery is written so that it is easy to add new functionality. Modules that add new functionality are called plug-ins, and you can find many of them at http://plugins.jquery.com. jQuery plug-ins are just ordinary files of JavaScript code, and to use them in your web pages, you just include them with a <script> element as you would any other JavaScript library (you must include plug-ins after you include jQuery itself, of course).

It is almost trivially easy to write your own jQuery extensions. The trick is to know that jQuery.fn is the prototype object for all jQuery objects. If you add a function to this object, that function becomes a jQuery method. Here is an example:

jQuery.fn.println = function() { // Join all the arguments into a space-separated string var msg = Array.prototype.join.call(arguments, " "); // Loop through each element in the jQuery object this.each(function() { // For each one, append the string as plain text, then append a <br/>. jQuery(this).append(document.createTextNode(msg)).append("<br/>"); }); // Return the unmodified jQuery object for method chaining return this; };

With that jQuery.fn.println function defined, we can now invoke a println() method on any jQuery object like this:

$("#debug").println("x = ", x, "; y = ", y);

It is common practice to add new methods to jQuery.fn. If you find yourself using the each() method to「manually」iterate through the elements in a jQuery object and perform some kind of operation on them, ask yourself whether it might make sense to re-factor your code so that the each() invocation is moved into an extension method. If you follow basic modular coding practices when writing your extension and abide by a few jQuery-specific conventions, you can call your extension a plug-in and share it with others. These are the jQuery plug-in conventions to be aware of:

Don’t rely on the $ identifier: the including page may have called jQuery.no Conflict() and $() may no longer be a synonym for the jQuery() function. In short plug-ins like the one shown above, you can just use jQuery instead of $. If you are writing a longer extension, you are likely to wrap it all within one anonymous function to avoid the creation of global variables. If you do so, you can use the idiom of passing the jQuery as an argument to your anonymous function, and receiving that value in a parameter named $:

(function($) { // An anonymous function with one parameter named $ // Put your plugin code here }(jQuery)); // Invoke the function with the jQuery object as its argument

If your extension method does not return a value of its own, be sure to return a jQuery object that can be used in a method chain. Usually this will just be the this object and you can return it unmodified. In the example above, the method ended with the line return this;. The method could have been made slightly shorter (and less readable) following another jQuery idiom: returning the result of the each() method. Then the println() method would have included the code return this.each(function() {...});

If your extension method has more than a couple of parameters or configuration options, allow the user to pass options in the form of an object (as we saw with the animate() method in Custom Animations and the jQuery.ajax() function in The jQuery.ajax() Function).

Don’t pollute the jQuery method namespace. Well-behaved jQuery plug-ins define the smallest number of methods consistent with a usable API. It is common for jQuery plug-ins to define only a single method in jQuery.fn. This one method takes a string as its first argument and interprets that string as the name of a function to pass its remaining arguments to. When you are able to limit your plug-in to a single method, the name of that method should be the same as the name of the plug-in. If you must define more than one method, use the plug-in name as a prefix for each of your method names.

If your plug-in binds event handlers, put all of those handlers in an event namespace (Advanced Event Handler Registration). Use your plug-in name as the namespace name.

If your plug-in uses the data() method to associate data with elements, place all of your data values in a single object, and store that object as a single value, giving it the same name as your plug-in.

Save your plug-in code in a file with a name of the form「jquery.plugin.js」, replacing「plugin」with the name of your plug-in.

A plug-in can add new utility functions to jQuery by adding them to the jQuery object itself. For example:

// This method prints its arguments (using the println() plugin method) // to the element with id "debug". If no such element exists, it is created // and added to the document. jQuery.debug = function() { var elt = jQuery("#debug"); // Find the #debug element if (elt.length == 0) { // Create it if it doesn't exist elt = jQuery("<div id='debug'><h1>Debugging Output</h1></div>"); jQuery(document.body).append(elt); } elt.println.apply(elt, arguments); // Output the arguments to it };

In addition to defining new methods, it is also possible to extend other parts of the jQuery library. In Animated Effects, for example, we saw that it is possible to add new effect duration names (in addition to「fast」and「slow」) by adding properties to jQuery.fx.speeds and that it is possible to add new easing functions by adding them to jQuery.easing. Plug-ins can even extend the jQuery CSS selector engine! You can add new pseudoclass filters (like :first and :input) by adding properties to the jQuery.expr[':'] object. Here is an example that defines a new :draggable filter that returns only elements that have a draggable=true attribute:

jQuery.expr[':'].draggable = function(e) { return e.draggable === true; };

With this selector defined, we can select draggable images with $("img:draggable") instead of the more verbose $("img[draggable=true]").

As you can see from the code above, a custom selector function is passed a candidate DOM element as its first argument. It should return true if the element matches the selector and false otherwise. Many custom selectors need only the one element argument, but they are actually invoked with four arguments. The second argument is an integer index that gives the position of this element within an array of candidate elements. That array is passed as the fourth argument and your selector must not modify it. The third argument is an interesting one: it is the array result of a call to the RegExp.exec() method. The fourth element of this array (at index 3) is the value, if any, within parentheses after the pseudoclass filter. The parentheses and any quotes inside are stripped, leaving only the argument string. Here, for example, is how you could implement a :data(x) pseudoclass that returns true only for arguments that have a data-x attribute (see Dataset Attributes):

jQuery.expr[':'].data = function(element, index, match, array) { // Note: IE7 and before do not implement hasAttribute() return element.hasAttribute("data-" + match[3]); };

The jQuery UI Library

jQuery limits itself to providing core DOM, CSS, event handling, and Ajax functionality. These provide an excellent foundation for building higher-level abstractions, such as user interface widgets, and the jQuery UI library does just that. Full coverage of jQuery UI is beyond the scope of this book, and all we can do here is offer a simple overview. You can find the library and its documentation at http://jqueryui.com.

As its name implies, jQuery UI defines a number of user interface widgets: autocompletion input fields, date pickers for entering dates, accordions and tabs for organizing information, sliders and progress bars for visually displaying numbers, and modal dialogs for urgent communication with the user. In addition to these widgets, jQuery UI implements more general「interactions」, which allow any document element to be easily made draggable, droppable, resizable, selectable, or sortable. Finally, jQuery UI adds a number of new visual effects methods (including the ability to animate colors) to those offered by jQuery itself, and it defines lots of new easing functions as well.

Think of jQuery UI as a bunch of related jQuery plug-ins packed into a single JavaScript file. To use it, simply include the jQuery UI script in your web page after including the jQuery code. The Download page at http://jqueryui.com allows you to select the components you plan to use and will build a custom download bundle for you that may reduce your page load times compared to the full jQuery UI library.

jQuery UI is fully themeable, and its themes take the form of CSS files. So in addition to loading the jQuery UI JavaScript code into your web pages, you’ll have to include the CSS file for your selected theme as well. The jQuery UI website features a number of prebuilt themes and also a「ThemeRoller」page that allows you to customize and download your own theme.

jQuery UI widgets and interactions are structured as jQuery plug-ins, and each defines a single jQuery method. Typically, when you call this method on an existing document element, it transforms that element into the widget. For example, to alter a text input field so that it pops up a date picker widget when clicked or focused, simply call the datepicker() method with code like this:

// Make <input> elements with class="date" into date picker widgets $("input.date").datepicker();

In order to make full use of a jQuery UI widget, you must be familiar with three things: its configuration options, its methods, and its events. All jQuery UI widgets are configurable, and some have many configuration options. You can customize the behavior and appearance of your widgets by passing an options object (like the animations options object passed to animate()) to the widget method.

jQuery UI widgets usually define at least a handful of「methods」for interacting with the widget. In order to avoid a proliferation of jQuery methods, however, jQuery UI widgets do not define their「methods」as true methods. Each widget has only a single method (like the datepicker() method in the example above). When you want to call a「method」of the widget, you pass the name of the desired「method」to the single true method defined by the widget. To disable a date picker widget, for example, you don’t call a disableDatepicker() method; instead, you call datepicker ("disable").

jQuery UI widgets generally define custom events that they trigger in response to user interaction. You can bind event handlers for these custom events with the normal bind() method, and you can also usually specify event handler functions as properties in the options object you pass to the widget method. The first argument to these handler methods is an Event object as usual. Some widgets pass a second「UI」object as the second argument to the event handler. This object typically provides state information about the widget.

Note that the jQuery UI documentation sometimes describes「events」that are not truly custom events and could better be described as callback functions set through the configuration options object. The date picker widget, for example, supports a number of callback functions that it can call at various times. None of these functions have the standard event handler signature, however, and you cannot register handlers for these「events」with bind(). Instead, you specify appropriate callbacks when you configure the widget in your initial call to the datepicker() method.

Chapter 20. Client-Side Storage

Web applications can use browser APIs to store data locally on the user’s computer. This client-side storage serves to give the web browser a memory. Web apps can store user preferences, for example, or even store their complete state, so that they can resume exactly where you left off at the end of your last visit. Client-side storage is segregated by origin, so pages from one site can’t read the data stored by pages from another site. But two pages from the same site can share storage and can use it as a communication mechanism. Data input in a form on one page can be displayed in a table on another page, for example. Web applications can choose the lifetime of the data they store: data can be stored temporarily so that it is retained only until the window closes or the browser exits, or it can be saved to the hard drive and stored permanently, so that it is available months or years later.

There are a number of forms of client-side storage:

Web Storage

Web Storage is an API that was originally defined as part of HTML5 but was spun off as a standalone specification. That specification is still in draft form, but it is partially (and interoperably) implemented in all current browsers including IE8. This API consists of the localStorage and sessionStorage objects, which are essentially persistent associative arrays that map string keys to string values. Web Storage is very easy to use, is suitable for storing large (but not huge) amounts of data, and is available on all current browsers, but it is not supported by older browsers. localStorage and sessionStorage are covered in localStorage and sessionStorage.

Cookies

Cookies are an old client-side storage mechanism that was designed for use by server-side scripts. An awkward JavaScript API makes cookies scriptable on the client-side, but they are hard to use and are suitable only for storing small amounts of textual data. Also, any data stored as cookies is always transmitted to the server with every HTTP request, even if the data is only of interest to the client. Cookies continue to be of interest to client-side programmers because all browsers, old and new, support them. Once Web Storage is universally available, however, cookies will revert to their original role as a client-side storage mechanism for server-side scripts. Cookies are covered in Cookies.

IE User Data

Microsoft implements its own proprietary client-side storage mechanism, known as「userData,」in IE5 and later. userData enables the storage of medium amounts of string data and can be used as an alternative to Web Storage in versions of IE before IE8. The userData API is covered in IE userData Persistence.

Offline Web Applications

HTML5 defines an「Offline Web Applications」API that allows the caching of web pages and their associated resources (scripts, CSS files, images, and so on). This is client-side storage for web applications themselves rather than just their data, and it allows web apps to install themselves so that they are available even when there is no connection to the Internet. Offline web apps are covered in Application Storage and Offline Webapps.

Web Databases

Developers who need to work with really huge amounts of data like to use databases, and the most recent browsers have started to integrate client-side database functionality into their browsers. Safari, Chrome, and Opera include a client-side API to a SQL database. The standardization effort for that API has failed, however, and it is unlikely to be implemented by Firefox or IE. An alternative database API is being standardized under the name「Indexed Database API.」This is an API to a simple object database without a query language. Both of the client-side database APIs are asynchronous and require the use of event handlers, which makes them somewhat complicated. They are not documented in this chapter, but see Client-Side Databases for an overview and an example of the IndexedDB API.

Filesystem API

We saw in Chapter 18 that modern browsers support a File object that allows user-selected files to be uploaded through an XMLHttpRequest. Related draft standards define an API for obtaining a private local filesystem and for reading and writing files from and to that filesystem. These emerging APIs are described in The Filesystem API. When they are more widely implemented, web applications will be able to use the kind of file-based storage mechanisms that are already familiar to many programmers.

Storage, Security, and Privacy

Web browsers often offer to remember web passwords for you, and they store them safely in encrypted form on the disk. But none of the forms of client-side data storage described in this chapter involve encryption: anything you save resides on the user’s hard disk in unencrypted form. Stored data is therefore accessible to curious users who share access to the computer and to malicious software (such as spyware) that exists on the computer. For this reason, no form of client-side storage should ever be used for passwords, financial account numbers, or other similarly sensitive information. Remember: just because a user types something into a form field when interacting with your website doesn’t mean that he wants a copy of that value stored on disk. Consider a credit card number as an example. This is sensitive information that people keep hidden in their wallets. If you save this information using client-side persistence, it is almost as if you wrote the credit card number on a sticky note and stuck it to the user’s keyboard.

Also, bear in mind that many web users mistrust websites that use cookies or other client-side storage mechanisms to do anything that resembles「tracking.」Try to use the storage mechanisms discussed in this chapter to enhance a user’s experience at your site; don’t use them as a privacy-invading data collection mechanism. If too many sites abuse client-side storage, users will disable it or clear it frequently, which will defeat the purpose and cripple the sites that depend on it.

localStorage and sessionStorage

Browsers that implement the「Web Storage」draft specification define two properties on the Window object: localStorage and sessionStorage. Both properties refer to a Storage object—a persistent associative array that maps string keys to string values. Storage objects work much like regular JavaScript objects: simply set a property of the object to a string, and the browser will store that string for you. The difference between localStorage and sessionStorage has to do with lifetime and scope: how long the data is saved for and who the data is accessible to.

Storage lifetime and scope are explained in more detail below. First, however, let’s look at some examples. The following code uses localStorage, but it would also work with sessionStorage:

var name = localStorage.username; // Query a stored value. name = localStorage["username"]; // Array notation equivalent if (!name) { name = prompt("What is your name?"); // Ask the user a question. localStorage.username = name; // Store the user's response. } // Iterate through all stored name/value pairs for(var name in localStorage) { // Iterate all stored names var value = localStorage[name]; // Look up the value of each one }

Storage objects also define methods for storing, retrieving, iterating, and deleting data. Those methods are covered in Storage API.

The Web Storage draft specification says that we should be able to store structured data (objects and arrays) as well as primitive values and built-in types such as dates, regular expressions, and even File objects. At the time of this writing, however, browsers only allow the storage of strings. If you want to store and retrieve other kinds of data, you’ll have to encode and decode it yourself. For example:

// If you store a number, it is automatically converted to a string. // Don't forget to parse it when retrieving it from storage. localStorage.x = 10; var x = parseInt(localStorage.x); // Convert a Date to a string when setting, and parse it when getting localStorage.lastRead = (new Date()).toUTCString(); var lastRead = new Date(Date.parse(localStorage.lastRead)); // JSON makes a convenient encoding for any primitive or data structure localStorage.data = JSON.stringify(data); // Encode and store var data = JSON.parse(localStorage.data); // Retrieve and decode.

Storage Lifetime and Scope

The difference between localStorage and sessionStorage involves the lifetime and scope of the storage. Data stored through localStorage is permanent: it does not expire and remains stored on the user’s computer until a web app deletes it or the user asks the browser (through some browser-specific UI) to delete it.

localStorage is scoped to the document origin. As explained in The Same-Origin Policy, the origin of a document is defined by its protocol, hostname, and port, so each of the following URLs has a different origin:

http://www.example.com // Protocol: http; hostname: www.example.com https://www.example.com // Different protocol http://static.example.com // Different hostname http://www.example.com:8000 // Different port

All documents with the same origin share the same localStorage data (regardless of the origin of the scripts that actually access localStorage). They can read each other’s data. And they can overwrite each other’s data. But documents with different origins can never read or overwrite each other’s data (even if they’re both running a script from the same third-party server).

Note that localStorage is also scoped by browser vendor. If you visit a site using Firefox, and then visit again using Chrome (for example), any data stored during the first visit will not be accessible during the second visit.

Data stored through sessionStorage has a different lifetime than data stored through localStorage: it has the same lifetime as the top-level window or browser tab in which the script that stored it is running. When the window or tab is permanently closed, any data stored through sessionStorage is deleted. (Note, however, that modern browsers have the ability to reopen recently closed tabs and restore the last browsing session, so the lifetime of these tabs and their associated sessionStorage may be longer than it seems.)

Like localStorage, sessionStorage is scoped to the document origin so that documents with different origins will never share sessionStorage. But sessionStorage is also scoped on a per-window basis. If a user has two browser tabs displaying documents from the same origin, those two tabs have separate sessionStorage data: the scripts running in one tab cannot read or overwrite the data written by scripts in the other tab, even if both tabs are visiting exactly the same page and are running exactly the same scripts.

Note that this window-based scoping of sessionStorage is only for top-level windows. If one browser tab contains two <iframe> elements, and those frames hold two documents with the same origin, those two framed documents will share session Storage .

Storage API

localStorage and sessionStorage are often used as if they were regular JavaScript objects: set a property to store a string and query the property to retrieve it. But these objects also define a more formal method-based API. To store a value, pass the name and value to setItem(). To retrieve a value, pass the name to getItem(). To delete a value, pass the name to removeItem(). (In most browsers you can also use the delete operator to remove a value, just as you would for an ordinary object, but this technique does not work in IE8.) To delete all stored values, call clear() (with no arguments). Finally, to enumerate the names of all stored values, use the length property and pass numbers from 0 to length-1 to the key() method. Here are some examples using localStorage. The same code would work using sessionStorage instead:

localStorage.setItem("x", 1); // Store an number with the name "x" localStorage.getItem("x"); // Retrieve a value // Enumerate all stored name/value pairs for(var i = 0; i < localStorage.length; i++) { // Length gives the # of pairs var name = localStorage.key(i); // Get the name of pair i var value = localStorage.getItem(name); // Get the value of that pair } localStorage.removeItem("x"); // Delete the item "x" localStorage.clear(); // Delete any other items, too

Although it is usually more convenient to store and retrieve values by setting and querying properties, there are some times when you might want to use these methods. First, the clear() method has no equivalent and is the only way to delete all name/value pairs in a Storage object. Similarly, the removeItem() method is the only portable way to delete a single name/value pair, since IE8 does not allow the delete operator to be used in that way.

If browser vendors fully implement the specification and allow objects and arrays to be stored in a Storage object, there will be another reason to use methods like setItem() and getItem(). Objects and array values are normally mutable, so a Storage object is required to make a copy when you store a value, so that any subsequent changes to the original value have no effect on the stored value. The Storage object is also required to make a copy when you retrieve a value so that any changes you make to the retrieved value have no effect on the stored value. When this kind of copying is being done, using the property-based API can be confusing. Consider this (hypothetical, until browsers support structured values) code:

localStorage.o = {x:1}; // Store an object that has a property x localStorage.o.x = 2; // Attempt to set the property of the stored object localStorage.o.x // => 1: x is unchanged

The second line of code above wants to set a property of the stored object, but instead it retrieves a copy of the stored object, sets a property in that copied object, and then discards the copy. The stored object remains unchanged. There would be less chance of confusion if we used getItem() here:

localStorage.getItem("o").x = 2; // We don't expect this to store the value 2

Finally, another reason to use the explicit method-based Storage API is that we can emulate that API on top of other storage mechanisms in browsers that do not yet support the Web Storage specification. The sections that follow will implement the Storage API using cookies and IE userData. If you use the method-based API, you can write code that makes use of localStorage when available and falls back on one of the other storage mechanisms in other browsers. Your code might start like this:

// Figure out what memory I'm using var memory = window.localStorage || (window.UserDataStorage && new UserDataStorage()) || new CookieStorage(); // Then search my memory var username = memory.getItem("username");

Storage Events

Whenever the data stored in localStorage or sessionStorage changes, the browser triggers a storage event on any other Window objects to which that data is visible (but not on the window that made the change). If a browser has two tabs open to pages with the same origin, and one of those pages stores a value in localStorage, the other tab will receive a storage event. Remember that sessionStorage is scoped to the top-level window, so storage events are only triggered for sessionStorage changes when there are frames involved. Also note that storage events are only triggered when storage actually changes. Setting an existing stored item to its current value does not trigger an event, nor does removing an item that does not exist in storage.

Register a handler for storage events with addEventListener() (or attachEvent() in IE). In most browsers, you can also set the onstorage property of the Window object, but at the time of this writing, Firefox does not support that property.

The event object associated with a storage event has five important properties (they are not supported by IE8, unfortunately):

key

The name or key of the item that was set or removed. If the clear() method was called, this property will be null.

newValue

Holds the new value of the item, or null if removeItem() was called.

