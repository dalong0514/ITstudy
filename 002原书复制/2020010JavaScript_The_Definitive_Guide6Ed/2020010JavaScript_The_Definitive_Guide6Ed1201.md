[44] The name Comet was coined by Alex Russell in「Comet: Low Latency Data for the Browser」. The name is likely a play on Ajax: both Comet and Ajax are US brands of scouring powder.

[45] Images of this sort are sometimes called web bugs. Privacy concerns arise when web bugs are used to communicate information to a server other than the one from which the web page was loaded. One common use of this kind of third-party web bug is for hit counting and website traffic analysis.

HTTP by <script>: JSONP

The introduction to this chapter mentioned that a <script> element can be used as an Ajax transport mechanism: simply set the src attribute of a <script> (and insert it into the document if it isn’t already there) and the browser will generate an HTTP request to download the URL you specify. <script> elements are useful Ajax transports for one primary reason: they are not subject to the same origin policy, so you can use them to request data from servers other than your own. A secondary reason to use <script> elements is that they automatically decode (i.e., execute) response bodies that consist of JSON-encoded data.

Scripts and Security

In order to use a <script> element as an Ajax transport, you have to allow your web page to run whatever JavaScript code the remote server chooses to send you. This means that you must not use the technique described here with untrusted servers. And when you do use it with trusted servers, keep in mind that if an attacker can hack into that server, then the hacker can take over your web page, run any code she wants and display any content she wants, and that content will appear to come from your site.

With that said, note that it has become commonplace for websites to use trusted third-party scripts, especially to embed advertising or「widgets」into a page. Using a <script> as an Ajax transport to communicate with a trusted web service is no more dangerous than that.

The technique of using a <script> element as an Ajax transport has come to be known as JSONP: it works when the response body of the HTTP request is JSON-encoded. The「P」stands for「padding」or「prefix」—this will be explained in a moment.[46]

Suppose you’ve written a service that handles GET requests and returns JSON-encoded data. Same-origin documents can use it with XMLHttpRequest and JSON.parse() with code like that in Example 18-3. If you enable CORS on your server, cross-origin documents in new browsers can also use your service with XMLHttpRequest. Cross-origin documents in older browsers that do not support CORS can only access your service with a <script> element, however. Your JSON response body is (by definition) valid JavaScript code, and the browser will execute it when it arrives. Executing JSON-encoded data decodes it, but the result is still just data, and it doesn’t do anything.

This is where the P part of JSONP comes in. When invoked through a <script> element, your service must「pad」its response by surrounding it with parentheses and prefixing it with the name of a JavaScript function. Instead of just sending JSON data like this:

[1, 2, {"buckle": "my shoe"}]

It sends a padded-JSON response like this:

handleResponse( [1, 2, {"buckle": "my shoe"}] )

As the body of a <script> element, this padded response does something valuable: it evaluates the JSON-encoded data (which is nothing more than one big JavaScript expression, after all) and then passes it to the function handleResponse(), which, we assume, the containing document has defined to do something useful with the data.

In order for this to work, we have to have some way to tell the service that it is being invoked from a <script> element and must send a JSONP response instead of a plain JSON response. This can be done by adding a query parameter to the URL: appending ?json (or &json), for example.

In practice, services that support JSONP do not dictate a function name like「handleResponse」that all clients must implement. Instead, they use the value of a query parameter to allow the client to specify a function name, and then use that function name as the padding in the response. Example 18-14 uses a query parameter named「jsonp」to specify the name of the callback function. Many services that support JSONP recognize this parameter name. Another common name is「callback」, and you might have to modify the code shown here to make it work with the particular requirements of the service you need to use.

Example 18-14 defines a function getJSONP() that makes a JSONP request. This example is a little tricky, and there are some things you should note about it. First, notice how it creates a new <script> element, sets its URL, and inserts it into the document. It is this insertion that triggers the HTTP request. Second, notice that the example creates a new internal callback function for each request, storing the function as a property of getJSONP() itself. Finally, note that callback performs some necessary cleanup: it removes the script element and deletes itself.

Example 18-14. Making a JSONP request with a script element

// Make a JSONP request to the specified URL and pass the parsed response // data to the specified callback. Add a query parameter named "jsonp" to // the URL to specify the name of the callback function for the request. function getJSONP(url, callback) { // Create a unique callback name just for this request var cbnum = "cb" + getJSONP.counter++; // Increment counter each time var cbname = "getJSONP." + cbnum; // As a property of this function // Add the callback name to the url query string using form-encoding // We use the parameter name "jsonp". Some JSONP-enabled services // may require a different parameter name, such as "callback". if (url.indexOf("?") === -1) // URL doesn't already have a query section url += "?jsonp=" + cbname; // add parameter as the query section else // Otherwise, url += "&jsonp=" + cbname; // add it as a new parameter. // Create the script element that will send this request var script = document.createElement("script"); // Define the callback function that will be invoked by the script getJSONP[cbnum] = function(response) { try { callback(response); // Handle the response data } finally { // Even if callback or response threw an error delete getJSONP[cbnum]; // Delete this function script.parentNode.removeChild(script); // Remove script } }; // Now trigger the HTTP request script.src = url; // Set script url document.body.appendChild(script); // Add it to the document } getJSONP.counter = 0; // A counter we use to create unique callback names

* * *

[46] Bob Ippolito coined the term「JSONP」in 2005.

Comet with Server-Sent Events

The Server-Sent Events draft standard defines an EventSource object that makes Comet applications trivial to write. Simply pass a URL to the EventSource() constructor and then listen for message events on the returned object:

var ticker = new EventSource("stockprices.php"); ticker.onmessage = function(e) { var type = e.type; var data = e.data; // Now process the event type and event data strings. }

The event object associated with a message event has a data property that holds whatever string the server sent as the payload for this event. The event object also has a type property like all event objects do. The default value is「message」, but the event source can specify a different string for the property. A single onmessage event handler receives all events from a given server event source, and can dispatch them, if necessary, based on their type property.

The Server-Sent Event protocol is straightforward. The client initiates a connection to the server (when it creates the EventSource object) and the server keeps this connection open. When an event occurs, the server writes lines of text to the connection. An event going over the wire might look like this:

event: bid sets the type of the event object data: GOOG sets the data property data: 999 appends a newline and more data a blank line triggers the message event

There are some additional details to the protocol that allow events to be given IDs and allow a reconnecting client to tell the server what the ID of the last event it received was, so that a server can resend any events it missed. Those details are not important here, however.

One obvious application for the Comet architecture is online chat: a chat client can post new messages to the chat room with XMLHttpRequest and can subscribe to the stream of chatter with an EventSource object. Example 18-15 demonstrates how easy it is to write a chat client like this with EventSource.

Example 18-15. A simple chat client, using EventSource

<script> window.onload = function() { // Take care of some UI details var nick = prompt("Enter your nickname"); // Get user's nickname var input = document.getElementById("input"); // Find the input field input.focus(); // Set keyboard focus // Register for notification of new messages using EventSource var chat = new EventSource("/chat"); chat.onmessage = function(event) { // When a new message arrives var msg = event.data; // Get text from event object var node = document.createTextNode(msg); // Make it into a text node var div = document.createElement("div"); // Create a <div> div.appendChild(node); // Add text node to div document.body.insertBefore(div, input); // And add div before input input.scrollIntoView(); // Ensure input elt is visible } // Post the user's messages to the server using XMLHttpRequest input.onchange = function() { // When user strikes return var msg = nick + ": " + input.value; // Username plus user's input var xhr = new XMLHttpRequest(); // Create a new XHR xhr.open("POST", "/chat"); // to POST to /chat. xhr.setRequestHeader("Content-Type", // Specify plain UTF-8 text "text/plain;charset=UTF-8"); xhr.send(msg); // Send the message input.value = ""; // Get ready for more input } }; </script> <!-- The chat UI is just a single text input field --> <!-- New chat messages will be inserted before this input field --> <input id="input" style="width:100%"/>

At the time of this writing, EventSource is supported in Chrome and Safari, and Mozilla is expected to implement it in the first release after Firefox 4.0. In browsers (like Firefox) whose XMLHttpRequest implementation fires a readystatechange event (for readyState 3) whenever there is download progress, it is relatively easy to emulate EventSource with XMLHttpRequest, and Example 18-16 shows how this can be done. With this emulation module, Example 18-15 works in Chrome, Safari, and Firefox. (Example 18-16 does not work in IE or Opera, since their XMLHttpRequest implementations do not generate events on download progress.)

Example 18-16. Emulating EventSource with XMLHttpRequest

// Emulate the EventSource API for browsers that do not support it. // Requires an XMLHttpRequest that sends readystatechange events whenever // there is new data written to a long-lived HTTP connection. Note that // this is not a complete implementation of the API: it does not support the // readyState property, the close() method, nor the open and error events. // Also event registration for message events is through the onmessage // property only--this version does not define an addEventListener method. if (window.EventSource === undefined) { // If EventSource is not defined, window.EventSource = function(url) { // emulate it like this. var xhr; // Our HTTP connection... var evtsrc = this; // Used in the event handlers. var charsReceived = 0; // So we can tell what is new. var type = null; // To check property response type. var data = ""; // Holds message data var eventName = "message"; // The type field of our event objects var lastEventId = ""; // For resyncing with the server var retrydelay = 1000; // Delay between connection attempts var aborted = false; // Set true to give up on connecting // Create an XHR object xhr = new XMLHttpRequest(); // Define an event handler for it xhr.onreadystatechange = function() { switch(xhr.readyState) { case 3: processData(); break; // When a chunk of data arrives case 4: reconnect(); break; // When the request closes } }; // And establish a long-lived connection through it connect(); // If the connection closes normally, wait a second and try to restart function reconnect() { if (aborted) return; // Don't reconnect after an abort if (xhr.status >= 300) return; // Don't reconnect after an error setTimeout(connect, retrydelay); // Wait a bit, then reconnect }; // This is how we establish a connection function connect() { charsReceived = 0; type = null; xhr.open("GET", url); xhr.setRequestHeader("Cache-Control", "no-cache"); if (lastEventId) xhr.setRequestHeader("Last-Event-ID", lastEventId); xhr.send(); } // Each time data arrives, process it and trigger the onmessage handler // This function handles the details of the Server-Sent Events protocol function processData() { if (!type) { // Check the response type if we haven't already type = xhr.getResponseHeader('Content-Type'); if (type !== "text/event-stream") { aborted = true; xhr.abort(); return; } } // Keep track of how much we've received and get only the // portion of the response that we haven't already processed. var chunk = xhr.responseText.substring(charsReceived); charsReceived = xhr.responseText.length; // Break the chunk of text into lines and iterate over them. var lines = chunk.replace(/(\r\n|\r|\n)$/, "").split(/\r\n|\r|\n/); for(var i = 0; i < lines.length; i++) { var line = lines[i], pos = line.indexOf(":"), name, value=""; if (pos == 0) continue; // Ignore comments if (pos > 0) { // field name:value name = line.substring(0,pos); value = line.substring(pos+1); if (value.charAt(0) == " ") value = value.substring(1); } else name = line; // field name only switch(name) { case "event": eventName = value; break; case "data": data += value + "\n"; break; case "id": lastEventId = value; break; case "retry": retrydelay = parseInt(value) || 1000; break; default: break; // Ignore any other line } if (line === "") { // A blank line means send the event if (evtsrc.onmessage && data !== "") { // Chop trailing newline if there is one if (data.charAt(data.length-1) == "\n") data = data.substring(0, data.length-1); evtsrc.onmessage({ // This is a fake Event object type: eventName, // event type data: data, // event data origin: url // the origin of the data }); } data = ""; continue; } } } }; }

We conclude this exploration of the Comet architecture with a server example. Example 18-17 is a custom HTTP server written in server-side JavaScript for the Node (Asynchronous I/O with Node) server-side environment. When a client requests the root URL「/」, it sends the chat client code shown in Example 18-15 and the emulation code from Example 18-16. When a client makes a GET request for the URL「/chat」, it saves the response stream in an array and keeps that connection open. And when a client makes a POST request to「/chat」, it uses the body of the request as a chat message and writes it, prefixed with the Server-Sent Events「data:」prefix, to each of the open response streams. If you install Node, you can run this server example locally. It listens on port 8000, so after starting the server, you’d point your browser to http://localhost:8000 to connect and begin chatting with yourself.

Example 18-17. A custom Server-Sent Events chat server

// This is server-side JavaScript, intended to be run with NodeJS. // It implements a very simple, completely anonymous chat room. // POST new messages to /chat, or GET a text/event-stream of messages // from the same URL. Making a GET request to / returns a simple HTML file // that contains the client-side chat UI. var http = require('http'); // NodeJS HTTP server API // The HTML file for the chat client. Used below. var clientui = require('fs').readFileSync("chatclient.html"); var emulation = require('fs').readFileSync("EventSourceEmulation.js"); // An array of ServerResponse objects that we're going to send events to var clients = []; // Send a comment to the clients every 20 seconds so they don't // close the connection and then reconnect setInterval(function() { clients.forEach(function(client) { client.write(":ping\n"); }); }, 20000); // Create a new server var server = new http.Server(); // When the server gets a new request, run this function server.on("request", function (request, response) { // Parse the requested URL var url = require('url').parse(request.url); // If the request was for "/", send the client-side chat UI. if (url.pathname === "/") { // A request for the chat UI response.writeHead(200, {"Content-Type": "text/html"}); response.write("<script>" + emulation + "</script>"); response.write(clientui); response.end(); return; } // Send 404 for any request other than "/chat" else if (url.pathname !== "/chat") { response.writeHead(404); response.end(); return; } // If the request was a post, then a client is posting a new message if (request.method === "POST") { request.setEncoding("utf8"); var body = ""; // When we get a chunk of data, add it to the body request.on("data", function(chunk) { body += chunk; }); // When the request is done, send an empty response // and broadcast the message to all listening clients. request.on("end", function() { response.writeHead(200); // Respond to the request response.end(); // Format the message in text/event-stream format // Make sure each line is prefixed with "data:" and that it is // terminated with two newlines. message = 'data: ' + body.replace('\n', '\ndata: ') + "\r\n\r\n"; // Now send this message to all listening clients clients.forEach(function(client) { client.write(message); }); }); } // Otherwise, a client is requesting a stream of messages else { // Set the content type and send an initial message event response.writeHead(200, {'Content-Type': "text/event-stream" }); response.write("data: Connected\n\n"); // If the client closes the connection, remove the corresponding // response object from the array of active clients request.connection.on("end", function() { clients.splice(clients.indexOf(response), 1); response.end(); }); // Remember the response object so we can send future messages to it clients.push(response); } }); // Run the server on port 8000. Connect to http://localhost:8000/ to use it. server.listen(8000);

Chapter 19. The jQuery Library

JavaScript has an intentionally simple core API and an overly complicated client-side API that is marred by major incompatibilities between browsers. The arrival of IE9 eliminates the worst of those incompatibilities, but many programmers find it easier to write web applications using a JavaScript framework or utility library to simplify common tasks and hide the differences between browsers. At the time of this writing, one of the most popular and widely used such libraries is jQuery.[47]

Because the jQuery library has become so widely used, web developers should be familiar with it: even if you don’t use it in your own code, you are likely to encounter it in code written by others. Fortunately, jQuery is stable and small enough to document in this book. You’ll find a comprehensive introduction in this chapter, and Part IV includes a jQuery quick reference. jQuery methods do not have individual entries in the reference section, but the jQuery gives a synopsis of each method.

jQuery makes it easy to find the elements of a document that you care about and then manipulate those elements by adding content, editing HTML attributes and CSS properties, defining event handlers, and performing animations. It also has Ajax utilities for dynamically making HTTP requests and general-purpose utility functions for working with objects and arrays.

As its name implies, the jQuery library is focused on queries. A typical query uses a CSS selector to identify a set of document elements and returns an object that represents those elements. This returned object provides many useful methods for operating on the matching elements as a group. Whenever possible, these methods return the object on which they are invoked, which allows a succinct method chaining idiom to be used. These features are at the heart of jQuery’s power and utility:

An expressive syntax (CSS selectors) for referring to elements in the document

An efficient query method for finding the set of document elements that match a CSS selector

A useful set of methods for manipulating selected elements

Powerful functional programming techniques for operating on sets of elements as a group, rather than one at a time

A succinct idiom (method chaining) for expressing sequences of operations

This chapter begins with an introduction to jQuery that shows how to make simple queries and work with the results. The sections that follow explain:

How to set HTML attributes, CSS styles and classes, HTML form values and element content, geometry, and data

How to alter the structure of a document by inserting, replacing, wrapping, and deleting elements

How to use jQuery’s cross-browser event model

How to produce animated visual effects with jQuery

jQuery’s Ajax utilities for making scripted HTTP requests

jQuery’s utility functions

The full syntax of jQuery’s selectors, and how to use jQuery’s advanced selection methods

How to extend jQuery by using and writing plug-ins

The jQuery UI library

jQuery Basics

The jQuery library defines a single global function named jQuery(). This function is so frequently used that the library also defines the global symbol $ as a shortcut for it. These are the only two symbols jQuery defines in the global namespace.[48]

This single global function with two names is the central query function for jQuery. Here, for example, is how we ask for the set of all <div> elements in a document:

var divs = $("div");

The value returned by this function represents a set of zero or more DOM elements and is known as a jQuery object. Note that jQuery() is a factory function rather than a constructor: it returns a newly created object but is not used with the new keyword. jQuery objects define many methods for operating on the sets of elements they represent, and most of this chapter is devoted to explaining those methods. Below, for example, is code that finds, highlights, and quickly displays all hidden <p> elements that have a class of「details」:

$("p.details").css("background-color", "yellow").show("fast");

The css() method operates on the jQuery object returned by $(), and returns that same object, so that the show() method can be invoked next in a compact「method chain.」This method chaining idiom is common in jQuery programming. As another example, the code below finds all elements in the document that have the CSS class「clicktohide」and registers an event handler on each one. That event handler is invoked when the user clicks on the element and makes the element slowly「slide up」and disappear:

$(".clicktohide").click(function() { $(this).slideUp("slow"); });

Obtaining jQuery

The jQuery library is free software. You can download it from http://jquery.com. Once you have the code, you can include it in your web pages with a <script> element like this:

<script src="jquery-1.4.2.min.js"></script>

The「min」in the filename above indicates that this is the minimized version of the library, with unnecessary comments and whitespace removed, and internal identifiers replaced with shorter ones.

Another way to use jQuery in your web applications is to allow a content distribution network to serve it using a URL like one of these:

http://code.jquery.com/jquery-1.4.2.min.js http://ajax.microsoft.com/ajax/jquery/jquery-1.4.2.min.js http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js

This chapter documents jQuery version 1.4. If you are using a different version, you should replace the「1.4.2」version number in the URLs above as necessary.[49] If you use the Google CDN, you can use「1.4」to get the latest release in the 1.4.x series, or just「1」to get the most current release less than 2.0. The major advantage of loading jQuery from well-known URLs like these is that, because of jQuery’s popularity, visitors to your website will likely already have a copy of the library in their browser’s cache and no download will be necessary.

The jQuery() Function

The jQuery() function (a.k.a. $()) is the most important one in the jQuery library. It is heavily overloaded, however, and there are four different ways you can invoke it.

The first, and most common, way to invoke $() is to pass a CSS selector (a string) to it. When called this way, it returns the set of elements from the current document that match the selector. jQuery supports most of the CSS3 selector syntax, plus some extensions of its own. Complete details of the jQuery selector syntax are in jQuery Selectors. If you pass an element or a jQuery object as the second argument to $(), it returns only matching descendants of the specified element or elements. This optional second argument value defines the starting point (or points) for the query and is often called the context.

The second way to invoke $() is to pass it an Element or Document or Window object. Called like this, it simply wraps the element, document, or window in a jQuery object and returns that object. Doing this allows you to use jQuery methods to manipulate the element rather than using raw DOM methods. It is common to see jQuery programs call $(document) or $(this), for example. jQuery objects can represent more than one element in a document, and you can also pass an array of elements to $(). In this case, the returned jQuery object represents the set of elements in your array.

The third way to invoke $() is to pass it a string of HTML text. When you do this, jQuery creates the HTML element or elements described by that text and then returns a jQuery object representing those elements. jQuery does not automatically insert the newly created elements into the document, but the jQuery methods described in Altering Document Structure allow you to easily insert them where you want them. Note that you cannot pass plain text when you invoke $() in this way, or jQuery will think you are passing a CSS selector. For this style of invocation, the string you pass to $() must include at least one HTML tag with angle brackets.

When invoked in this third way, $() accepts an optional second argument. You can pass a Document object to specify the document with which the elements are to be associated. (If you are creating elements to be inserted into an <iframe>, for example, you’ll need to explicitly specify the document object of that frame.) Or you can pass an object as the second argument. If you do this, the object properties are assumed to specify the names and values of HTML attributes to be set on the object. But if the object includes properties with any of the names「css」,「html」,「text」,「width」,「height」,「offset」,「val」, or「data」, or properties that have the same name as any of the jQuery event handler registration methods, jQuery will invoke the method of the same name on the newly created element and pass the property value to it. (Methods like css(), html(), and text() are covered in jQuery Getters and Setters and event handler registration methods are in Handling Events with jQuery. For example:

var img = $("<img/>", // Create a new <img> element { src:url, // with this HTML attribute, css: {borderWidth:5}, // this CSS style, click: handleClick // and this event handler. });

Finally, the fourth way to invoke $() is to pass a function to it. If you do this, the function you pass will be invoked when the document has been loaded and the DOM is ready to be manipulated. This is the jQuery version of the onLoad() function from Example 13-5. It is very common to see jQuery programs written as anonymous functions defined within a call to jQuery():

jQuery(function() { // Invoked when the document has loaded // All jQuery code goes here });

You’ll sometimes see $(f) written using the older and more verbose form: $(document). ready(f) .

The function you pass to jQuery() will be invoked with the document object as its this value and with the jQuery function as its single argument. This means that you can undefine the global $ function and still use that convenient alias locally with this idiom:

jQuery.noConflict(); // Restore $ to its original state jQuery(function($) { // Use $ as a local alias for the jQuery object // Put all your jQuery code here });

jQuery triggers functions registered through $() when the DOMContentLoaded event is fired (Client-Side JavaScript Timeline) or, in browsers that don’t support that event, when the load event is fired. This means that the document will be completely parsed, but that external resources such as images may not be loaded yet. If you pass a function to $() after the DOM is ready, that function will be invoked immediately, before $() returns.

The jQuery library also uses the jQuery() function as its namespace and defines a number of utility functions and properties under it. The jQuery.noConflict() function mentioned above is one such utility function. Others include jQuery.each() for general-purpose iteration and jQuery.parseJSON() for parsing JSON text. Utility Functions lists general-purpose utility functions, and other jQuery functions are described throughout this chapter.

jQuery Terminology

Let’s pause here to define some important terms and phrases that you’ll see throughout this chapter:

「the jQuery function」

The jQuery function is the value of jQuery or of $. This is the function that creates jQuery objects, registers handlers to be invoked when the DOM is ready, and that also serves as the jQuery namespace. I usually refer to it as $(). Because it serves as a namespace, the jQuery function might also be called「the global jQuery object,」but it is very important not to confuse it with「a jQuery object.」

「a jQuery object」

A jQuery object is an object returned by the jQuery function. A jQuery object represents a set of document elements and can also be called a「jQuery result,」a「jQuery set,」or a「wrapped set.」

「the selected elements」

When you pass a CSS selector to the jQuery function, it returns a jQuery object that represents the set of document elements that match that selector. When describing the methods of the jQuery object, I’ll often use the phrase「the selected elements」to refer to those matching elements. For example, to explain the attr() method, I might write「the attr() method sets HTML attributes on the selected elements.」This is instead of a more precise but awkward description like「the attr() method sets HTML attributes on the elements of the jQuery object on which it was invoked.」Note that the word「selected」refers to the CSS selector and has nothing to do with any selection performed by the user.

「a jQuery function」

A jQuery function is a function like jQuery.noConflict() that is defined in the namespace of the jQuery function. jQuery functions might also be described as「static methods.」

「a jQuery method」

A jQuery method is a method of a jQuery object returned by the jQuery function. The most important part of the jQuery library is the powerful methods it defines.

The distinction between jQuery functions and methods is sometimes tricky because a number of functions and methods have the same name. Note the differences between these two lines of code:

// Call the jQuery function each() to // invoke the function f once for each element of the array a $.each(a,f); // Call the jQuery() function to obtain a jQuery object that represents all // <a> elements in the document. Then call the each() method of that jQuery // object to invoke the function f once for each selected element. $("a").each(f);

The official jQuery documentation at http://jquery.com uses names like $.each to refer to jQuery functions and names like .each (with a period but without a dollar sign) to refer to jQuery methods. In this book, I’ll use the terms「function」and「method」instead. Usually it will be clear from the context which is being discussed.

Queries and Query Results

When you pass a CSS selector string to $(), it returns a jQuery object that represents the set of matched (or「selected」) elements. CSS selectors were introduced in Selecting Elements with CSS Selectors, and you can review that section for examples—all of the examples shown there work when passed to $(). The specific selector syntax supported by jQuery is detailed in jQuery Selectors. Rather than focus on those advanced selector details now, however, we’re going to first explore what you can do with the results of a query.

The value returned by $() is a jQuery object. jQuery objects are array-like: they have a length property and have numeric properties from 0 to length-1. (See Array-Like Objects for more on array-like objects.) This means that you can access the contents of the jQuery object using standard square-bracket array notation:

$("body").length // => 1: documents have only a single body element $("body")[0] // This the same as document.body

If you prefer not to use array notation with jQuery objects, you can use the size() method instead of the length property and the get() method instead of indexing with square brackets. If you need to convert a jQuery object to a true array, call the to Array() method.

In addition to the length property, jQuery objects have three other properties that are sometimes of interest. The selector property is the selector string (if any) that was used when the jQuery object was created. The context property is the context object that was passed as the second argument to $(), or the Document object otherwise. Finally, all jQuery objects have a property named jquery, and testing for the existence of this property is a simple way to distinguish jQuery objects from other array-like objects. The value of the jquery property is the jQuery version number as a string:

// Find all <script> elements in the document body var bodyscripts = $("script", document.body); bodyscripts.selector // => "script" bodyscripts.context // => document.body bodyscripts.jquery // => "1.4.2"

$() versus querySelectorAll()

The $() function is similar to the Document method querySelectorAll() that was described in Selecting Elements with CSS Selectors: both take a CSS selector as their argument and return an array-like object that holds the elements that match the selector. The jQuery implementation uses querySelectorAll() in browsers that support it, but there are good reasons to use $() instead of querySelectorAll() in your own code:

querySelectorAll() has only recently been implemented by browser vendors. $() works in older browsers as well as new ones.

Because jQuery can perform selections「by hand,」the CSS3 selectors supported by $() work in all browsers, not just those browsers that support CSS3.

The array-like object returned by $() (a jQuery object) is much more useful than the array-like object (a NodeList) returned by querySelectorAll().

If you want to loop over all elements in a jQuery object, you can call the each() method instead of writing a for loop. The each() method is something like the ECMAScript 5 (ES5) forEach() array method. It expects a callback function as its sole argument, and it invokes that callback function once for each element in the jQuery object (in document order). The callback is invoked as a method of the matched element, so within the callback the this keyword refers to an Element object. each() also passes the index and the element as the first and second arguments to the callback. Note that this and the second argument are raw document elements, not jQuery objects; if you want to use a jQuery method to manipulate the element, you’ll need to pass it to $() first.

jQuery’s each() method has one feature that is quite different than forEach(): if your callback returns false for any element, iteration is terminated after that element (this is like using the break keyword in a normal loop). each() returns the jQuery object on which it is called, so that it can be used in method chains. Here is an example (it uses the prepend() method that will be explained in Altering Document Structure):

// Number the divs of the document, up to and including div#last $("div").each(function(idx) { // find all <div>s, and iterate through them $(this).prepend(idx + ": "); // Insert index at start of each if (this.id === "last") return false; // Stop at element #last });

Despite the power of the each() method, it is not very commonly used, since jQuery methods usually iterate implicitly over the set of matched elements and operate on them all. You typically only need to use each() if you need to manipulate the matched elements in different ways. Even then, you may not need to call each(), since a number of jQuery methods allow you to pass a callback function.

The jQuery library predates the ES5 array methods, and it defines a couple of other methods that provide functionality similar to the ES5 methods. The jQuery method map() works much like the Array.map() method. It accepts a callback function as its argument and invokes that function once for each element of the jQuery object, collecting the return values of those invocations, and returning a new jQuery object holding those return values. map() invokes the callback in the same way that the each() method does: the element is passed as the this value and as the second argument and the index of the element is passed as the first argument. If the callback returns null or undefined, that value is ignored and nothing is added to the new jQuery object for that invocation. If the callback returns an array or an array-like object (such as a jQuery object), it is「flattened」and its elements are added individually to the new jQuery object. Note that the jQuery object returned by map() may not hold document elements, but it still works as an array-like object. Here is an example:

// Find all headings, map to their ids, convert to a true array, and sort it. $(":header").map(function() { return this.id; }).toArray().sort();

Along with each() and map(), another fundamental jQuery method is index(). This method expects an element as its argument and returns the index of that element in the jQuery object, or –1 if it is not found. In typical jQuery fashion, however, this index() method is overloaded. If you pass a jQuery object as the argument, index() searches for the first element of that object. If you pass a string, index() uses it as a CSS selector and returns the index of the first element of this jQuery object in the set of elements matching that selector. And if you pass no argument, index() returns the index of the first element of this jQuery object within its sibling elements.

The final general-purpose jQuery method we’ll discuss here is is(). It takes a selector as its argument and returns true if at least one of the selected elements also matches the specified selector. You might use it in an each() callback function, for example:

$("div").each(function() { // For each <div> element if ($(this).is(":hidden")) return; // Skip hidden elements // Do something with the visible ones here });

* * *

[47] Other commonly used libraries not covered in this book include Prototype, YUI, and dojo. Search the Web for「JavaScript libraries」to find many more.

[48] If you use $ in your own code, or are using another library, such as Prototype, that uses $, you can call jQuery.noConflict() to restore $ to its original value.

[49] When this chapter was written, the current version of jQuery was 1.4.2. As the book goes to press, jQuery 1.5 has just been released. The changes in jQuery 1.5 mostly involve the Ajax utility function, and they will be mentioned in passing in Ajax with jQuery.

jQuery Getters and Setters

Some of the simplest, and most common, operations on jQuery objects are those that get or set the value of HTML attributes, CSS styles, element content, or element geometry. This section describes those methods. First, however, it is worth making some generalizations about getter and setter methods in jQuery:

Rather than defining a pair of methods, jQuery uses a single method as both getter and setter. If you pass a new value to the method, it sets that value; if you don’t specify a value, it returns the current value.

When used as setters, these methods set values on every element in the jQuery object, and then return the jQuery object to allow method chaining.

When used as getters, these methods query only the first element of the set of elements and return a single value. (Use map() if you want to query all elements.) Since getters do not return the jQuery object they are invoked on, they can only appear at the end of a method chain.

When used as setters, these methods often accept object arguments. In this case, each property of the object specifies a name and a value to be set.

When used as setters, these methods often accept functions as values. In this case, the function is invoked to compute the value to be set. The element that the value is being computed for is the this value, the element index is passed as the first argument to the function, and the current value is passed as the second argument.

Keep these generalizations about getters and setters in mind as you read the rest of this section. Each subsection below explains an important category of jQuery getter/setter methods.

Getting and Setting HTML Attributes

The attr() method is the jQuery getter/setter for HTML attributes, and it adheres to each of the generalizations described above. attr() handles browser incompatibilities and special cases and allows you to use either HTML attribute names or their JavaScript property equivalents (where they differ). For example, you can use either「for」or「htmlFor」and either「class」or「className」. removeAttr() is a related function that completely removes an attribute from all selected elements. Here are some examples:

$("form").attr("action"); // Query the action attr of 1st form $("#icon").attr("src", "icon.gif"); // Set the src attribute $("#banner").attr({src:"banner.gif", // Set 4 attributes at once alt:"Advertisement", width:720, height:64}); $("a").attr("target", "_blank"); // Make all links load in new windows $("a").attr("target", function() { // Load local links locally and load if (this.host == location.host) return "_self" else return "_blank"; // off-site links in a new window }); $("a").attr({target: function() {...}}); // We can also pass functions like this $("a").removeAttr("target"); // Make all links load in this window

Getting and Setting CSS Attributes

The css() method is very much like the attr() method, but it works with the CSS styles of an element rather than the HTML attributes of the element. When querying style values, css() returns the current (or「computed」; see Querying Computed Styles) style of the element: the returned value may come from the style attribute or from a stylesheet. Note that it is not possible to query compound styles such as「font」or「margin」. You must instead query individual styles such as「font-weight」,「font-family」,「margin-top」, or「margin-left」. When setting styles, the css() method simply adds the style to the element’s style attribute. css() allows you to use hyphenated CSS style names (「background-color」) or camel-case JavaScript style names (「backgroundColor」). When querying style values, css() returns numeric values as strings, with units suffixes included. When setting, however, it converts numbers to strings and adds a「px」(pixels) suffix to them when necessary:

$("h1").css("font-weight"); // Get font weight of first <h1> $("h1").css("fontWeight"); // Camel case works, too $("h1").css("font"); // Error: can't query compound styles $("h1").css("font-variant", // Set a style on all <h1> elements "smallcaps"); $("div.note").css("border", // Okay to set compound styles "solid black 2px"); $("h1").css({ backgroundColor: "black", // Set multiple styles at once textColor: "white", // camelCase names work better fontVariant: "small-caps", // as object properties padding: "10px 2px 4px 20px", border: "dotted black 4px" }); // Increase all <h1> font sizes by 25% $("h1").css("font-size", function(i,curval) { return Math.round(1.25*parseInt(curval)); });

Getting and Setting CSS Classes

Recall that the value of the class attribute (accessed via the className property in JavaScript) is interpreted as a space-separated list of CSS class names. Usually, we want to add, remove, or test for the presence of a single name in the list rather than replacing one list of classes with another. For this reason, jQuery defines convenience methods for working with the class attribute. addClass() and removeClass() add and remove classes from the selected elements. toggleClass() adds classes to elements that don’t already have them and removes classes from those that do. hasClass() tests for the presence of a specified class. Here are some examples:

// Adding CSS classes $("h1").addClass("hilite"); // Add a class to all <h1> elements $("h1+p").addClass("hilite first"); // Add 2 classes to <p> elts after <h1> $("section").addClass(function(n) { // Pass a function to add a custom class return "section" + n; // to each matched element }); // Removing CSS classes $("p").removeClass("hilite"); // Remove a class from all <p> elements $("p").removeClass("hilite first"); // Multiple classes are allowed $("section").removeClass(function(n) { // Remove custom classes from elements return "section" + n; }); $("div").removeClass(); // Remove all classes from all <div>s // Toggling CSS classes $("tr:odd").toggleClass("oddrow"); // Add the class if it is not there // or remove it if it is $("h1").toggleClass("big bold"); // Toggle two classes at once $("h1").toggleClass(function(n) { // Toggle a computed class or classes return "big bold h1-" + n; }); $("h1").toggleClass("hilite", true); // Works like addClass $("h1").toggleClass("hilite", false); // Works like removeClass // Testing for CSS classes $("p").hasClass("first") // Does any p element have this class? $("#lead").is(".first") // This does the same thing $("#lead").is(".first.hilite") // is() is more flexible than hasClass()

Note that the hasClass() method is less flexible than addClass(), removeClass(), and toggleClass(). hasClass() works for only a single class name and does not support function arguments. It returns true if any of the selected elements has the specified CSS class and returns false if none of them do. The is() method (described in Queries and Query Results) is more flexible and can be used for the same purpose.

These jQuery methods are like the classList methods described in Scripting CSS Classes, but the jQuery methods work in all browsers, not just those that support the HTML5 classList property. Also, of course, the jQuery methods work for multiple elements and can be chained.

Getting and Setting HTML Form Values

val() is a method for setting and querying the value attribute of HTML form elements and also for querying and setting the selection state of checkboxes, radio buttons, and <select> elements:

$("#surname").val() // Get value from the surname text field $("#usstate").val() // Get single value from <select> $("select#extras").val() // Get array of values from <select multiple> $("input:radio[name=ship]:checked").val() // Get val of checked radio button $("#email").val("Invalid email address") // Set value of a text field $("input:checkbox").val(["opt1", "opt2"]) // Check any checkboxes with // these names or values $("input:text").val(function() { // Reset all text fields to their default return this.defaultValue; })

Getting and Setting Element Content

The text() and html() methods query and set the plain-text or HTML content of an element or elements. When invoked with no arguments, text() returns the plain-text content of all descendant text nodes of all matched elements. This works even in browsers that do not support the textContent or innerText properties (Element Content As Plain Text).

If you invoke the html() method with no arguments, it returns the HTML content of just the first matched element. jQuery uses the innerHTML property to do this: x.html() is effectively the same as x[0].innerHTML.

If you pass a string to text() or html(), that string will be used for the plain-text or HTML-formatted text content of the element, and it will replace all existing content. As with the other setter methods we’ve seen, you can also pass a function, which will be used to compute the new content string:

var title = $("head title").text() // Get document title var headline = $("h1").html() // Get html of first <h1> element $("h1").text(function(n,current) { // Give each heading a section number return "§" + (n+1) + ": " + current });

Getting and Setting Element Geometry

We learned in Document and Element Geometry and Scrolling that it can be tricky to correctly determine the size and position of an element, especially in browsers that do not support getBoundingClientRect() (Querying the Geometry of an Element). jQuery simplifies these computations with methods that work in any browser. Note that all of the methods described here are getters, but only some can also be used as setters.

To query or set the position of an element, use the offset() method. This method measures positions relative to the document and returns them in the form of an object with left and top properties that hold the X and Y coordinates. If you pass an object with these properties to the method, it sets the position you specify. It sets the CSS position attribute as necessary to make elements positionable:

var elt = $("#sprite"); // The element we want to move var position = elt.offset(); // Get its current position position.top += 100; // Change its Y coordinate elt.offset(position); // Set the new position // Move all <h1> elements to the right by a distance that depends on their // position in the document $("h1").offset(function(index,curpos) { return {left: curpos.left + 25*index, top:curpos.top}; });

The position() method is like offset(), except that it is a getter only and it returns element positions relative to their offset parent, rather than relative to the document as a whole. In More on Element Size, Position and Overflow, we saw that every element has an offsetParent property that its position is relative to. Positioned elements always serve as the offset parents for their descendants, but some browsers also make other elements, such as table cells, into offset parents. jQuery only considers positioned elements to be offset parents, and the offset Parent() method of a jQuery object maps each element to the nearest positioned ancestor element or to the <body> element. Note the unfortunate naming mismatch for these methods: offset() returns the absolute position of an element, in document coordinates. And position() returns the offset of an element relative to its offsetParent().

There are three getters for querying the width of an element and three for querying the height. The width() and height() methods return the basic width and height and do not include padding, borders, or margins. innerWidth() and innerHeight() return the width and height of an element plus the width and height of its padding (the word「inner」refers to the fact that these methods return the dimensions measured to the inside of the border). outerWidth() and outerHeight() normally return the element’s dimensions plus its padding and border. If you pass the value true to either of these methods, they also add in the size of the element’s margins. The code below shows four different widths that you can compute for an element:

var body = $("body"); var contentWidth = body.width(); var paddingWidth = body.innerWidth(); var borderWidth = body.outerWidth(); var marginWidth = body.outerWidth(true); var padding = paddingWidth-contentWidth; // sum of left and right padding var borders = borderWidth-paddingWidth; // sum of left and right border widths var margins = marginWidth-borderWidth; // sum of left and right margins

The width() and height() methods have features that the other four methods (the inner and outer methods) do not. First, if the first element of the jQuery object is a Window or Document object, they return the size of the window’s viewport or the full size of the document. The other methods only work for elements, not windows or documents.

The other feature of the width() and height() methods is that they are setters as well as getters. If you pass a value to these methods, they set the width or height of every element in the jQuery object. (Note, however, that they cannot set the width or height of Window and Document objects.) If you pass a number, it is taken as a dimension in pixels. If you pass a string value, it is used as the value of the CSS width or height attribute and can therefore use any CSS unit. Finally, as with other setters, you can pass a function that will be called to compute the width or height.

There is a minor asymmetry between the getter and setter behavior of width() and height(). When used as getters, these methods return the dimensions of an element’s content box, excluding padding, borders, and margins. When you use them as setters, however, they simply set the CSS width and height attributes. By default, those attributes also specify the size of the content box. But if an element has its CSS box-sizing attribute (The border-box model and the box-sizing property) set to border-box, the width() and height() methods set dimensions that include the padding and border. For an element e that uses the content-box box model, calling $(e).width(x).width() returns the value x. For elements that use the border-box model, however, this is not generally the case.

The final pair of geometry-related jQuery methods are scrollTop() and scrollLeft(), which query the scrollbar positions for an element or set the scrollbar positions for all elements. These methods work for the Window object as well as for document elements, and when invoked on a Document, they query or set the scrollbar positions of the Window that holds the document. Unlike with other setters, you cannot pass a function to scrollTop() or scrollLeft().

We can use scrollTop() as a getter and a setter, along with the height() method to define a method that scrolls the window up or down by the number of pages you specify:

// Scroll the window by n pages. n can be fractional or negative function page(n) { var w = $(window); // Wrap the window in a jQuery object var pagesize = w.height(); // Get the size of a page var current = w.scrollTop(); // Get the current scrollbar position w.scrollTop(current + n*pagesize); // Set new scrollbar position }

Getting and Setting Element Data

jQuery defines a getter/setter method named data() that sets or queries data associated with any document element or with the Document or Window objects. The ability to associate data with any element is an important and powerful one: it is the basis for jQuery’s event handler registration and effects queuing mechanisms, and you may sometimes want to use the data() method in your own code.

To associate data with the elements in a jQuery object, call data() as a setter method, passing a name and a value as the two arguments. Alternatively, you can pass a single object to the data() setter and each property of that object will be used as a name/value pair to associate with the element or elements of the jQuery object. Note, however, that when you pass an object to data(), the properties of that object replace any data previously associated with the element or elements. Unlike many of the other setter methods we’ve seen, data() does not invoke functions you pass. If you pass a function as the second argument to data(), that function is stored, just as any other value would be.

The data() method can also serve as a getter, of course. When invoked with no arguments, it returns an object containing all name/value pairs associated with the first element in the jQuery object. When you invoke data() with a single string argument, it returns the value associated with that string for the first element.

Use the removeData() method to remove data from an element or elements. (Using data() to set a named value to null or undefined is not the same thing as actually deleting the named value.) If you pass a string to removeData(), the method deletes any value associated with that string for the element or elements. If you call removeData() with no arguments, it removes all data associated with the element or elements:

$("div").data("x", 1); // Set some data $("div.nodata").removeData("x"); // Remove some data var x = $('#mydiv').data("x"); // Query some data

jQuery also defines utility function forms of the data() and removeData() methods. You can associate data with an individual element e using either the method or function form of data():

$(e).data(...) // The method form $.data(e, ...) // The function form

jQuery’s data framework does not store element data as properties of the elements themselves, but it does need to add one special property to any element that has data associated with it. Some browsers do not allow properties to be added to <applet>, <object>, and <embed> elements, so jQuery simply does not allow data to be associated with elements of these types.

Altering Document Structure

In Getting and Setting Element Content we saw the html() and text() methods for setting element content. This section covers methods for making more complex changes to a document. Because HTML documents are represented as a tree of nodes rather than a linear sequence of characters, insertions, deletions, and replacements are not as simple as they are for strings and arrays. The subsections that follow explain the various jQuery methods for document modification.

Inserting and Replacing Elements

Let’s begin with basic methods for insertions and replacements. Each of the methods demonstrated below takes an argument that specifies the content that is to be inserted into the document. This can be a string of plain text or of HTML to specify new content, or it can be a jQuery object or an Element or text Node. The insertion is made into or before or after or in place of (depending on the method) each of the selected elements. If the content to be inserted is an element that already exists in the document, it is moved from its current location. If it is to be inserted more than once, the element is cloned as necessary. These methods all return the jQuery object on which they are called. Note, however, that after replaceWith() runs, the elements in the jQuery object are no longer in the document:

$("#log").append("<br/>"+message); // Add content at end of the #log element $("h1").prepend("§"); // Add section sign at start of each <h1> $("h1").before("<hr/>"); // Insert a rule before each <h1> $("h1").after("<hr/>"); // And after as well $("hr").replaceWith("<br/>"); // Replace <hr/> elements with <br/> $("h2").each(function() { // Replace <h2> with <h1>, keeping content var h2 = $(this); h2.replaceWith("<h1>" + h2.html() + "</h1>"); }); // after() and before() can be called on text nodes, as well // This is another way to add a section sign at the start of each <h1> $("h1").map(function() { return this.firstChild; }).before("§");

Each of these five structure-altering methods can also be passed a function that will be invoked to compute the value to be inserted. As usual, if you supply such a function, it will be invoked once for each selected element. The this value will be that element and the first argument will be the index of that element within the jQuery object. For append(), prepend(), and replaceWith(), the second argument is the current content of the element as an HTML string. For before() and after(), the function is invoked with no second argument.

The five methods demonstrated above are all invoked on target elements and are passed the content that is to be inserted as an argument. Each of those five methods can be paired with another method that works the other way around: invoked on the content and passed the target elements as the argument. This table shows the method pairs:

Operation $(target).method(content) $(content).method(target)

insert content at end of target append() appendTo()

insert content at start of target prepend() prependTo()

insert content after target after() insertAfter()

insert content before target before() insertBefore()

replace target with content replaceWith() replaceAll()

The methods demonstrated in the example code above are the ones in the second column. The methods in the third column are demonstrated below. There are a couple of important things to understand about these pairs of methods:

If you pass a string to one of the second column methods, it is taken as a string of HTML to insert. If you pass a string to one of the third column methods, it is taken as a selector that identifies the target elements. (You can also identify the target elements directly by passing a jQuery object or Element or text node.)

The third column methods do not accept function arguments like the second column methods do.

The second column methods return the jQuery object on which they were invoked. The elements in that jQuery object may have new content or new siblings, but they are not themselves altered. The third column methods are invoked on the content that is being inserted and they return a new jQuery object that represents the new content after its insertion. In particular, note that if content is inserted at multiple locations, the returned jQuery object will include one element for each location.

With those differences listed, the code below performs the same operations as the code above, using the methods in the third column instead of the methods in the second column. Notice that in the second line we can’t pass plain text (without angle brackets to identify it as HTML) to the $() method—it thinks we’re specifying a selector. For this reason, we must explicitly create the text node that we want to insert:

$("<br/>+message").appendTo("#log"); // Append html to #log $(document.createTextNode("§")).prependTo("h1"); // Append text node to <h1>s $("<hr/>").insertBefore("h1"); // Insert rule before <h1>s $("<hr/>").insertAfter("h1"); // Insert rule after <h1>s $("<br/>").replaceAll("hr"); // Replace <hr/> with <br/>

Copying Elements

As noted above, if you insert elements that are already part of the document, those elements will simply be moved, not copied, to their new location. If you are inserting the elements in more than one place, jQuery will make copies as needed, but copies are not made when only one insertion is done. If you want to copy elements to a new location instead of moving them, you must first make a copy with the clone() method. clone() makes and returns a copy of each selected element (and of all of the descendants of those elements). The elements in the returned jQuery object are not part of the document yet, but you can insert them with one of the methods above:

// Append a new div, with id "linklist", to the end of the document $(document.body).append("<div id='linklist'><h1>List of Links</h1></div>"); // Copy all links in the document and insert them into that new div $("a").clone().appendTo("#linklist"); // Insert <br/> elements after each link so they display on separate lines $("#linklist > a").after("<br/>");

clone() does not normally copy event handlers (Handling Events with jQuery) or other data you have associated with elements (Getting and Setting Element Data); pass true if you want to clone that additional data as well.

Wrapping Elements

Another type of insertion into an HTML document involves wrapping a new element (or elements) around one or more elements. jQuery defines three wrapping functions. wrap() wraps each of the selected elements. wrapInner() wraps the contents of each selected element. And wrapAll() wraps the selected elements as a group. These methods are usually passed a newly created wrapper element or a string of HTML used to create a wrapper. The HTML string can include multiple nested elements, if desired, but there must be a single innermost element. If you pass a function to any of these methods, it will be invoked once in the context of each element (with the element index as its only argument) and should return the wrapper string, Element, or jQuery object. Here are some examples:

// Wrap all <h1> elements with <i> elements $("h1").wrap(document.createElement("i")); // Produces <i><h1>...</h1></i> // Wrap the content of all <h1> elements. Using a string argument is easier. $("h1").wrapInner("<i/>"); // Produces <h1><i>...</i></h1> // Wrap the first paragraph in one anchor and div $("body>p:first").wrap("<a name='lead'><div class='first'></div></a>"); // Wrap all the other paragraphs in another div $("body>p:not(:first)").wrapAll("<div class='rest'></div>");

Deleting Elements

Along with insertions and replacements, jQuery also defines methods for deleting elements. empty() removes all children (including text nodes) of each of the selected elements, without altering the elements themselves. The remove() method, by contrast, removes the selected elements (and all of their content) from the document. remove() is normally invoked with no arguments and removes all elements in the jQuery object. If you pass an argument, however, that argument is treated as a selector, and only elements of the jQuery object that also match the selector are removed. (If you just want to remove elements from the set of selected elements, without removing them from the document, use the filter() method, which is covered in Selection Methods.) Note that it is not necessary to remove elements before reinserting them into the document: you can simply insert them at a new location and they will be moved.

The remove() method removes any event handlers (see Handling Events with jQuery) and other data (Getting and Setting Element Data) you may have bound to the removed elements. The detach() method works just like remove() but does not remove event handlers and data. detach() may be more useful when you want to temporarily remove elements from the document for later reinsertion.

Finally, the unwrap() method performs element removal in a way that is the opposite of the wrap() or wrapAll() method: it removes the parent element of each selected element without affecting the selected elements or their siblings. That is, for each selected element, it replaces the parent of that element with its children. Unlike remove() and detach(), unwrap() does not accept an optional selector argument.

Handling Events with jQuery

As we saw in Chapter 17, one of the difficulties of working with events is that IE (until IE9) implements a different event API than all other browsers do. To address this difficulty, jQuery defines a uniform event API that works in all browsers. In its simple form, the jQuery API is easier to use than the standard or IE event APIs. And in its more complex full-featured form, the jQuery API is more powerful than the standard API. The subsections below have all the details.

Simple Event Handler Registration

jQuery defines simple event-registration methods for each of the commonly used and universally implemented browser events. To register an event handler for click events, for example, just call the click() method:

// Clicking on any <p> gives it a gray background $("p").click(function() { $(this).css("background-color", "gray"); });

Calling a jQuery event-registration method registers your handler on all of the selected elements. This is typically much easier than one-at-a-time event handler registration with addEventListener() or attachEvent().

These are the simple event handler registration methods jQuery defines:

blur() focusin() mousedown() mouseup() change() focusout() mouseenter() resize() click() keydown() mouseleave() scroll() dblclick() keypress() mousemove() select() error() keyup() mouseout() submit() focus() load() mouseover() unload()

Most of these registration methods are for common event types you are already familiar with from Chapter 17. A few notes are in order, however. Focus and blur events do not bubble, but the focusin and focusout events do, and jQuery ensures that these events work in all browsers. Conversely, the mouseover and mouseout events do bubble, and this is often inconvenient because it is difficult to know whether the mouse has left the element you’re interested in or whether it has simply moved out of one of the descendants of that element. mouseenter and mouseleave are nonbubbling events that solve this problem. These event types were originally introduced by IE, and jQuery ensures that they work correctly in all browsers.

The resize and unload event types are only ever fired on the Window object, so if you want to register handlers for these event types, you should invoke the resize()and unload() methods on $(window). The scroll() method is also most often used on $(window), but it can also be used on any element that has scrollbars (such as when the CSS overflow attribute is set to「scroll」or「auto」). The load() method can be called on $(window) to register a load event handler for the window, but it is usually better to pass your initialization function directly to $() as shown in The jQuery() Function. You can use the load() method on iframes and images, however. Note that when invoked with different arguments, load() is also used to load new content (via scripted HTTP) into an element—see The load() Method. The error() method can be used on <img> elements to register handlers that are invoked if an image fails to load. It should not be used to set the Window onerror property that was described in Error Handling.

In addition to these simple event registration methods, there are two special forms that are sometimes useful. The hover() method registers handlers for mouseenter and mouseleave events. Calling hover(f,g) is like calling mouseenter(f) and then calling mouseleave(g). If you pass just one argument to hover(), that function is used as the handler for both enter and leave events.

The other special event registration method is toggle(). This method binds event handler functions to the click event. You specify two or more handler functions and jQuery invokes one of them each time a click event occurs. If you call toggle(f,g,h), for example, the function f() is invoked to handle the first click event, g() is invoked to handle the second, h() is invoked to handle the third, and f() is invoked again to handle the fourth click event. Be careful when using toggle(): as we’ll see in Simple Effects, this method can also be used to show or hide (i.e., toggle the visibility of) the selected elements.

We’ll learn about other more general ways to register event handlers in Advanced Event Handler Registration, and we’ll end this section with one more simple and convenient way to register handlers. Recall that you can pass a string of HTML to $() to create the elements described by that string, and that you can pass (as a second argument) an object of attributes to be set on the newly created elements. This second argument can be any object that you would pass to the attr() method. But in addition, if any of the properties have the same name as the event registration methods listed above, the property value is taken as a handler function and is registered as a handler for the named event type. For example:

$("<img/>", { src: image_url, alt: image_description, className: "translucent_image", click: function() { $(this).css("opacity", "50%"); } });

jQuery Event Handlers

The event handler functions in the examples above expect no arguments and return no values. It is quite normal to write event handlers like that, but jQuery does invoke every event handler with one or more arguments, and it does pay attention to the return value of your handlers. The most important thing you should know is that every event handler is passed a jQuery event object as its first argument. The fields of this object provide details (like mouse pointer coordinates) about the event. The properties of the standard Event object were described in Chapter 17. jQuery simulates that standard Event object, even in browsers (like IE8 and before) that do not support it, and jQuery event objects have the same set of fields in all browsers. This is explained in detail in The jQuery Event Object.

Normally, event handlers are invoked with only the single event object argument. But if you explicitly trigger an event with trigger() (see Triggering Events), you can pass an array of extra arguments. If you do this, those arguments will be passed to the event handler after the first event object argument.

Regardless of how they are registered, the return value of a jQuery event handler function is always significant. If a handler returns false, both the default action associated with the event and any future propagation of the event are canceled. That is, returning false is the same as calling the preventDefault() and stopPropagation() methods of the Event object. Also, when an event handler returns a value (other than undefined), jQuery stores that value in the result property of the Event object where it can be accessed by subsequently invoked event handlers.

The jQuery Event Object

jQuery hides implementation differences between browsers by defining its own Event object. When a jQuery event handler is invoked, it is always passed a jQuery Event object as its first argument. The jQuery Event object is based heavily on W3C standards, but it also codifies some de facto event standards. jQuery copies all of the following fields from the native Event object into every jQuery Event object (though some of them will be undefined for certain event types):

altKey ctrlKey newValue screenX attrChange currentTarget offsetX screenY attrName detail offsetY shiftKey bubbles eventPhase originalTarget srcElement button fromElement pageX target cancelable keyCode pageY toElement charCode layerX prevValue view clientX layerY relatedNode wheelDelta clientY metaKey relatedTarget which

In addition to these properties, the Event object also defines the following methods:

preventDefault() isDefaultPrevented() stopPropagation() isPropagationStopped() stopImmediatePropagation() isImmediatePropagationStopped()

Most of these event properties and methods were introduced in Chapter 17 and are documented in Part IV under Event. Some of these fields are specially handled by jQuery to give them a uniform cross-browser behavior and are worth noting here:

metaKey

If the native event object does not have a metaKey property, jQuery sets this to the same value as the ctrlKey property. In MacOS, the Command key sets the metaKey property.

pageX, pageY

If the native event object does not define these properties, but does define the viewport coordinates of the mouse pointer in clientX and clientY, jQuery computes the document coordinates of the mouse pointer and stores them in pageX and pageY.

target, currentTarget, relatedTarget

The target property is the document element on which the event occurred. If the native event object has a text node as the target, jQuery reports the containing Element instead. currentTarget is the element on which the current executing event handler was registered. This should always be the same as this.

If currentTarget is not the same as target, you’re handling an event that has bubbled up from the element on which it occurred and it may be useful to test the target element with the is() method (Queries and Query Results):

if ($(event.target).is("a")) return; // Ignore events that start on links

relatedTarget is the other element involved in transition events such as mouseover and mouseout. For mouseover events, for example, the relatedTarget property specifies the element that the mouse pointer exited as it moved over the target. If the native event object does not define relatedTarget but does define toElement and fromElement, relatedTarget is set from those properties.

timeStamp

The time at which the event occurred, in the millisecond representation returned by the Date.getTime() method. jQuery sets the field itself to work around a long-standing bug in Firefox.

which

jQuery normalizes this nonstandard event property so that it specifies which mouse button or keyboard key was pressed during the event. For keyboard events, if the native event does not define which, but defines charCode or keyCode, which will be set to whichever of those properties is defined. For mouse events, if which is not defined but the button property is defined, which is set based on the button value. 0 means no buttons are pressed. 1 means the left button is pressed, 2 means the middle button is pressed, and 3 means the right button is pressed. (Note that some browsers don’t generate mouse events for right-button clicks.)

In addition, the following fields of the jQuery Event object are jQuery-specific additions that you may sometimes find useful:

data

If additional data was specified when the event handler was registered (see Advanced Event Handler Registration), it is made available to the handler as the value of this field

handler

A reference to the event handler function currently being invoked

result

The return value of the most recently invoked handler for this event, ignoring handlers that do not return a value

originalEvent

A reference to the native Event object generated by the browser

Advanced Event Handler Registration

We’ve seen that jQuery defines quite a few simple methods for registering event handlers. Each of these simply invoke the single, more complex method bind() to bind a handler for a named event type to each of the elements in the jQuery object. Using bind() directly allows you to use advanced event registration features that are not available through the simpler methods.[50]

In its simplest form, bind() expects an event type string as its first argument and an event handler function as its second. The simple event registration methods use this form of bind(). The call $('p').click(f), for example, is equivalent to:

$('p').bind('click', f);

bind() can also be invoked with three arguments. In this form, the event type is the first argument and the handler function is the third. You can pass any value between those two and jQuery will set the data property of the Event object to the value you specify before it invokes the handler. It is sometimes useful to pass additional data to your handlers in this way without having to use closures.

There are other advanced features of bind() as well. If the first argument is a space-separated list of event types, then the handler function will be registered for each of the named event types. The call $('a').hover(f) (see Simple Event Handler Registration), for example, is the same as:

$('a').bind('mouseenter mouseleave', f);

Another important feature of bind() is that it allows you to specify a namespace (or namespaces) for your event handlers when you register them. This allows you to define groups of handlers and comes in handy if you later want to trigger or deregister the handlers in a particular namespace. Handler namespaces are particularly useful for programmers who are writing libraries or modules of reusable jQuery code. Event namespaces look like CSS class selectors. To bind an event handler in a namespace, add a period and the namespace name to the event type string:

// Bind f as a mouseover handler in namespace "myMod" to all <a> elements $('a').bind('mouseover.myMod', f);

You can even assign a handler to multiple namespaces like this:

// Bind f as a mouseout handler in namespaces "myMod" and "yourMod" $('a').bind('mouseout.myMod.yourMod', f);

The final feature of bind() is that the first argument can be an object that maps event names to handler functions. To use the hover() method as an example again, the call $('a').hover(f,g) is the same as:

$('a').bind({mouseenter:f, mouseleave:g});

When you use this form of bind(), the property names in the object you pass can be space-separated strings of event types and can include namespaces. If you specify a second argument after the first object argument, that value is used as the data argument for each of the event bindings.

jQuery has another event handler registration method. The one() method is invoked and works just like bind() does, except that the event handler you register will automatically deregister itself after it is invoked. This means, as the method name implies, that event handlers registered with one() will never be triggered more than once.

One feature that bind() and one() do not have is the ability to register capturing event handlers as you can with addEventListener() (addEventListener()). IE (until IE9) does not support capturing handlers, and jQuery does not attempt to simulate that feature.

Deregistering Event Handlers

After registering an event handler with bind() (or with any of the simpler event registration methods), you can deregister it with unbind() to prevent it from being triggered by future events. (Note that unbind() only deregisters event handlers registered with bind() and related jQuery methods. It does not deregister handlers passed to add Event Listener() or the IE method attachEvent(), and it does not remove handlers defined by element attributes such as onclick and onmouseover.) With no arguments, unbind() deregisters all event handlers (for all event types) for all elements in the jQuery object:

$('*').unbind(); // Remove all jQuery event handlers from all elements!

With one string argument, all handlers for the named event type (or types, if the string names more than one) are unbound from all elements in the jQuery object:

// Unbind all mouseover and mouseout handlers on all <a> elements $('a').unbind("mouseover mouseout");

This is a heavy-handed approach and should not be used in modular code because the user of your module might be using other modules that register their own handlers for the same event types on the same elements. If your module registered event handlers using namespaces, however, you can use this one-argument version of unbind() to deregister only the handlers in your namespace or namespaces:

// Unbind all mouseover and mouseout handlers in the "myMod" namespace $('a').unbind("mouseover.myMod mouseout.myMod"); // Unbind handlers for any kind of event in the myMod namespace $('a').unbind(".myMod"); // Unbind click handlers that are in both namespaces "ns1" and "ns2" $('a').unbind("click.ns1.ns2");

If you want to be careful to unbind only event handlers you registered yourself and you did not use namespaces, you must retain a reference to the event handler functions and use the two-argument version of unbind(). In this form, the first argument is an event type string (without namespaces) and the second argument is a handler function:

$('#mybutton').unbind('click', myClickHandler);

When invoked this way, unbind() deregisters the specified event handler function for events of the specified type (or types) from all elements in the jQuery object. Note that event handlers can be unbound using this two-argument version of unbind() even when they were registered with an extra data value using the three-argument version of bind().

You can also pass a single object argument to unbind(). In this case, unbind() is invoked recursively for each property of the object. The property name is used as the event type string and the property value is used as the handler function:

$('a').unbind({ // Remove specific mouseover and mouseout handlers mouseover: mouseoverHandler, mouseout: mouseoutHandler });

Finally, there is one more way that unbind() can be invoked. If you pass a jQuery Event object to it, it unbinds the event handler that that event was passed to. Calling unbind(ev) is equivalent to unbind(ev.type, ev.handler).

Triggering Events

The event handlers you register are automatically invoked when the user uses the mouse or keyboard or when other kinds of events occur. Sometimes, however, it is useful to be able to manually trigger events. The simple way to do this is to invoke one of the simple event registration methods (like click() or mouseover()) with no argument. Just as many jQuery methods serve as both getters and setters, these event methods register an event handler when invoked with an argument and trigger event handlers when invoked with no arguments. For example:

$("#my_form").submit(); // Act as if the user clicked the Submit button

The submit() method in the line above synthesizes an Event object and triggers any event handlers that have been registered for the submit event. If none of those event handlers return false or call the preventDefault() method of the Event object, the form will actually be submitted. Note that events that bubble will bubble even when triggered manually like this. This means that triggering an event on a selected set of elements may also trigger handlers on the ancestors of those elements.

It is important to note that jQuery’s event triggering methods will trigger any handlers registered with jQuery’s event registration methods, and they will also trigger handlers defined on HTML attributes or Element properties such as onsubmit. But you cannot manually trigger event handlers registered with addEventListener() or attachEvent() (those handlers will still be invoked when a real event occurs, however).

Also note that jQuery’s event triggering mechanism is synchronous—there is no event queue involved. When you trigger an event, event handlers are invoked immediately, before the triggering method you called returns. If you trigger a click event and one of the triggered handlers triggers a submit event, all of the matching submit handlers are invoked before the next「click」handler is invoked.

Methods like submit() are convenient for binding and triggering events, but just as jQuery defines a more general bind() method, so too it defines a more general trigger() method. Normally you invoke trigger() with an event type string as the first argument and it triggers the handlers registered for events of that type on all elements in the jQuery object. So the submit() call above is equivalent to:

$("#my_form").trigger("submit");

Unlike the bind() and unbind() methods, you cannot specify more than one event type in this string. Like bind() and unbind(), however, you can specify event namespaces to trigger only the handlers defined in that namespace. If you want to trigger only event handlers that have no namespace, append an exclamation mark to the event type. Handlers registered through properties like onclick are considered to have no namespace:

$("button").trigger("click.ns1"); // Trigger click handlers in a namespace $("button").trigger("click!"); // Trigger click handlers in no namespace

Instead of passing an event type string as the first argument to trigger(), you can also pass an Event object (or any object that has a type property). The type property will be used to determine what kind of handlers to trigger. If you specified a jQuery Event object, that object will be the one passed to the triggered handlers. If you specified a plain object, a new jQuery Event object will be created, and the properties of the object you passed will be added to it. This is an easy way to pass additional data to event handlers:

// The onclick handler of button1 triggers the same event on button2 $('#button1').click(function(e) { $('#button2').trigger(e); }); // Add an extra property to the event object when triggering an event $('#button1').trigger({type:'click', synthetic:true}); // This handler tests that extra property to distinguish real from synthetic $('#button1').click(function(e) { if (e.synthetic) {...}; });

Another way to pass additional data to event handlers when you trigger them manually is to use the second argument to trigger(). The value you pass as the second argument to trigger() will become the second argument to each of the event handlers that is triggered. If you pass an array as the second argument, each of its elements will be passed as arguments to the triggered handlers:

$('#button1').trigger("click", true); // Pass a single extra argument $('#button1').trigger("click", [x,y,z]); // Pass three extra arguments

Sometimes you may want to trigger all handlers for a given event type, regardless of which document element those handlers are bound to. You could select all elements with $('*') and then call trigger() on the result, but that would be very inefficient. Instead, to trigger an event globally, call the jQuery.event.trigger() utility function. This function takes the same arguments as the trigger() method and efficiently triggers event handlers for the specified event type throughout the document. Note that「global events」triggered in this way do not bubble, and only handlers registered using jQuery methods (not event handlers registered with DOM properties like onclick) are triggered with this technique.

After invoking event handlers, trigger() (and the convenience methods that call it) perform whatever default action is associated with the triggered event (assuming that the event handlers didn’t return false or call preventDefault() on the event object). For example, if you trigger a submit event on a <form> element, trigger() will call the submit() method of that form, and if you trigger a focus event on an element, trigger() will call the focus() method of that element.

If you want to invoke event handlers without performing the default action, use trigger Handler() instead of trigger(). This method works just like trigger(), except that it first calls the preventDefault() and cancelBubble() methods of the Event object. This means that the synthetic event does not bubble or perform the default action associated with it.

Custom Events

jQuery’s event management system is designed around the standard events like mouse clicks and key presses that web browsers generate. But it is not tied to those events, and you can use any string you want as an event type name. With bind() you can register handlers for this kind of「custom event」and with trigger() you can cause those handlers to be invoked.

This kind of indirect invocation of custom event handlers turns out to be quite useful for writing modular code and implementing a publish/subscribe model or the Observer pattern. Often when using custom events you may find it useful to trigger them globally with the jQuery.event.trigger() function instead of the trigger() method:

// When the user clicks the "logoff" button, broadcast a custom event // to any interested observers that need to save their state and then // navigate to the logoff page. $("#logoff").click(function() { $.event.trigger("logoff"); // Broadcast an event window.location = "logoff.php"; // Navigate to a new page });

We’ll see in Ajax Events that jQuery’s Ajax methods broadcast custom events like this to notify interested listeners.

Live Events

The bind() method binds event handlers to specific document elements just as add Event Listener() and attachEvent() (see Chapter 17) do. But web applications that use jQuery often dynamically create new elements. If we’ve used bind() to bind an event handler to all <a> elements in the document and then we create new document content with new <a> elements, those new elements will not have the same event handlers as the old ones and will not behave in the same way.

jQuery addresses this issue with「live events.」To use live events, use the delegate() and undelegate() methods instead of bind() and unbind(). delegate() is usually invoked on $(document) and is passed a jQuery selector string, a jQuery event type string, and a jQuery event handler function. It registers an internal handler on the document or window (or on whatever elements are in the jQuery object). When an event of the specified type bubbles up to this internal handler, it determines whether the target of the event (the element that the event occurred on) matches the selector string. If so, it invokes the specified handler function. So to handle mouseover events on both old and newly created <a> elements, you might register a handler like this:

$(document).delegate("a", "mouseover", linkHandler);

Or you might use bind() in the static portions of your document and then use delegate() to handle the portions that change dynamically:

// Static event handlers for static links $("a").bind("mouseover", linkHandler); // Live event handlers for parts of the document that are dynamically updated $(".dynamic").delegate("a", "mouseover", linkHandler);

Just as the bind() method has a three-argument version that allows you to specify the value of the data property of the event object, the delegate() method has a four-argument version that allows the same thing. To use this version, pass the data value as the third argument and the handler function as the fourth.

It is important to understand that live events depend on event bubbling. By the time an event bubbles up to the document object, it may have already been passed to a number of static event handlers. And if any of those handlers called the cancel Bubble() method of the Event object, the live event handler will never be invoked.

jQuery defines a method named live() that can also be used to register live events. live() is a little harder to understand than delegate(), but it has the same two- or three-argument signature as bind() and is more commonly used in practice. The two calls to delegate() shown above could also be written as follows using live():

$("a").live("mouseover", linkHandler); $("a", $(".dynamic")).live("mouseover", linkHandler);

When the live() method is invoked on a jQuery object, the elements in that object are not actually used. What matters instead is the selector string and the context object (the first and second arguments to $()) that were used to create the jQuery object. jQuery objects make these values available through their context and selector properties (see Queries and Query Results). Normally, you invoke $() with only one argument and the context is the current document. So for a jQuery object x, the following two lines of code do the same thing:

x.live(type,handler); $(x.context).delegate(x.selector, type, handler);

To deregister live event handlers, use die() or undelegate(). die() can be invoked with one or two arguments. With one event type argument, it removes all live event handlers that match the selector and the event type. And with an event type and handler function argument, it removes only the one specified handler. Some examples:

$('a').die('mouseover'); // Remove all live handlers for mouseover on <a> elts $('a').die('mouseover', linkHandler); // Remove just one specific live handler

undelegate() is like die() but more explicitly separates the context (the elements on which the internal event handlers are registered) and the selector string. The calls to die() above could instead be written like this:

$(document).undelegate('a'); // Remove all live handlers for <a> elements $(document).undelegate('a', 'mouseover'); // Remove live mouseover handlers $(document).undelegate('a', 'mouseover', linkHandler); // One specific handler

Finally, undelegate() can also be called with no arguments at all. In this case, it deregisters all live event handlers that are delegated from the selected elements.

* * *

[50] jQuery uses the term「bind」for event handler registration. ECMAScript 5, and a number of JavaScript frameworks, define a bind() method on functions (The bind() Method), and use the term for the association of functions with objects on which they are to be invoked. jQuery’s version of the Function.bind() method is a utility function named jQuery.proxy(), and you can read about it in Utility Functions.

Animated Effects

Chapter 16 showed how to script the CSS styles of document elements. By setting the CSS visibility property, for example, you can make elements appear and disappear. CSS Animations went on to demonstrate how CSS scripting can be used to produce animated visual effects. Instead of just making an element disappear, for example, we might reduce the value of its opacity property over the period of a half second so that it quickly fades away instead of just blinking out of existence. This kind of animated visual effect creates a more pleasing experience for users, and jQuery makes them easy.

jQuery defines simple methods such as fadeIn() and fadeOut() for basic visual effects. In addition to simple effects methods, it defines an animate() method for producing more complex custom animations. The subsections below explain both the simple effects methods and the more general animate() method. First, however, we’ll describe some general features of jQuery’s animation framework.

Every animation has a duration that specifies how long the effect should last for. You specify this as a number of milliseconds or by using a string. The string「fast」means 200ms. The string「slow」means 600ms. If you specify a duration string that jQuery does not recognize, you’ll get a default duration of 400ms. You can define new duration names by adding new string-to-number mappings to jQuery.fx.speeds:

jQuery.fx.speeds["medium-fast"] = 300; jQuery.fx.speeds["medium-slow"] = 500;

jQuery’s effect methods usually take effect duration as an optional first argument. If you omit the duration argument, you usually get the default 400ms. Some methods, however, produce an instant nonanimated effect when you omit the duration:

$("#message").fadeIn(); // Fade an element in over 400ms $("#message").fadeOut("fast"); // Fade it out over 200ms

Disabling Animations

Animated visual effects have become the norm on many websites, but not all users like them: some users find them distracting and others feel they cause motion sickness. Disabled users may find that animations interfere with assistive technology like screen readers and users on old hardware may feel that they require too much processing power. As a courtesy to your users, you should generally keep your animations simple and understated and also provide an option to disable them completely. jQuery makes it easy to globally disable all effects: simply set jQuery.fx.off to true. This has the effect of changing the duration of every animation to 0ms, making them behave as instantaneous, nonanimated changes.

To allow end users to disable effects, you might use code like this in your scripts:

$(".stopmoving").click(function() { jQuery.fx.off = true; });

Then, if the web designer includes an element with class「stopmoving」on the page, the user can click it to disable animations.

jQuery’s effects are asynchronous. When you call an animation method like fadeIn(), it returns right away and the animation is performed「in the background.」Because animation methods return before the animation is complete, the second argument (also optional) to many of jQuery’s effect methods is a function that will be invoked when the effect is complete. The function is not passed any arguments, but the this value is set to the document element that was animated. The callback function is invoked once for each selected element:

// Quickly fade in an element, and when it is visible, display some text in it. $("#message").fadeIn("fast", function() { $(this).text("Hello World"); });

Passing a callback function to an effect method allows you to perform actions at the end of an effect. Note, however, that this is not necessary when you simply want to perform multiple effects in sequence. By default, jQuery’s animations are queued (The animation options object shows how to override this default). If you call an animation method on an element that is already being animated, the new animation does not begin right away but is deferred until the current animation ends. For example, you can make an element blink before fading in permanently:

$("#blinker").fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn();

jQuery’s effect methods are declared to accept optional duration and callback arguments. It is also possible to invoke these methods with an object whose properties specify animation options:

// Pass duration and callback as object properties instead of arguments $("#message").fadeIn({ duration: "fast", complete: function() { $(this).text("Hello World"); } });

Passing an object of animation objects is most commonly done with the general animate() method, but it is also possible for the simpler effects methods. Using an options object allows you to set other advanced options to control queuing and easing, for example. The available options are explained in The animation options object.

Simple Effects

jQuery defines nine simple effects methods to hide and show elements. They can be divided into three groups based on the kind of effect they perform:

fadeIn(), fadeOut(), fadeTo()

These are the simplest effects: fadeIn() and fadeOut() simply animate the CSS opacity property to show or hide an element. Both accept optional duration and callback arguments. fadeTo() is slightly different: it expects a target opacity argument and animates the change from the element’s current opacity to this target. For the fadeTo() method, the duration (or options object) is required as the first argument and the target opacity is required as the second argument. The callback function is an optional third argument.

show(), hide(), toggle()

The fadeOut() method listed above makes elements invisible but retains space for them in the document layout. The hide() method, by contrast, removes the elements from the layout as if the CSS display property was set to none. When invoked with no arguments, hide() and show() simply hide or show the selected elements immediately. With a duration (or options object) argument, however, they animate the hiding or showing process. hide() shrinks an element’s width and height to 0 at the same time that it reduces the element’s opacity to 0. show() reverses the process.

toggle() changes the visibility state of the elements it is invoked on: if they are hidden, it calls show(), and if they are visible, it calls hide(). As with show() and hide(), you must pass a duration or options object to toggle() to get an animated effect. Passing true to toggle() is the same as calling show() with no arguments and passing false is the same as calling hide() with no arguments. Note also that if you pass two or more function arguments to toggle() it registers event handlers, as described in Simple Event Handler Registration.

slideDown(), slideUp(), slideToggle()

slideUp() hides the elements in the jQuery object by animating their height to 0 and then setting the CSS display property to「none」. slideDown() reverses the process to make a hidden element visible again. slideToggle() toggles the visibility of an item using a slide up or slide down animation. Each of the three methods accepts the optional duration and callback arguments (or the options object argument).

Here is an example that invokes methods from each of these groups. Keep in mind that jQuery’s animations are queued by default, so these animations are performed one after the other:

// Fade all images out, then show them, then slide up, then slide down $("img").fadeOut().show(300).slideUp().slideToggle();

Various jQuery plug-ins (see Extending jQuery with Plug-ins) add additional effect methods to the library. The jQuery UI library (The jQuery UI Library) includes a particularly comprehensive set of effects.

Custom Animations

You can use the animate() method to produce more general animated effects than are available with the simple effects methods. The first argument to animate() specifies what to animate and the remaining arguments specify how to animate it. The first argument is required: it must be an object whose properties specify CSS attributes and their target values. animate() animates the CSS properties of each element from its current value to the specified target value. So, for example, the slideUp() effect described above can also be performed with code like this:

// Shrink the height of all images to 0 $("img").animate({ height: 0 });

As an optional second argument, you can pass an options object to animate():

$("#sprite").animate({ opacity: .25, // Animate opacity to .25 font-size: 10 // Animate font size to 10 pixels }, { duration: 500, // Animation lasts 1/2 second complete: function() { // Call this function when done this.text("Goodbye"); // Change element text. } });

Instead of passing an options object as the second argument, animate() also allows you to specify three of the most commonly used options as arguments. You can pass the duration (as a number or string) as the second argument. You can specify the name of an easing function as the third argument. (Easing functions will be explained shortly.) And you can specify a callback function as the fourth argument.

In the most general case, animate() accepts two object arguments. The first specifies what to animate and the second specifies how to animate it. To fully understand how to perform animations with jQuery, there are additional details about both objects that you must be aware of.

The animation properties object

The first argument to animate() must be an object. The property names for this object must be CSS attribute names, and the values of those properties must be the target values toward which the animation will move. Only numeric properties can be animated: it is not possible to animate colors, fonts, or enumerated properties such as display. If the value of a property is a number, pixels are assumed. If the value is a string, you may specify units. If you omit the units, pixels are again assumed. To specify relative values, prefix the value string with「+=」to increase the value or with「-=」to decrease the value. For example:

$("p").animate({ "margin-left": "+=.5in", // Increase paragraph indent opacity: "-=.1" // And decrease their opacity });

Note the use of the quotes around the property name「margin-left」in the object literal above. The hyphen in this property name means that it is not a legal JavaScript identifier, so it must be quoted here. jQuery also allows you to use the mixed-case alternative marginLeft, of course.

In addition to numeric values (with optional units and「+=」and「-=」prefixes), there are three other values that can be used in jQuery animation objects. The value「hide」will save the current state of the property and then animate that property toward 0. The value「show」will animate a CSS property toward its saved value. If an animation uses「show」, jQuery will call the show() method when the animation completes. And if an animation uses「hide」, jQuery will call hide() when the animation completes. You can also use the value「toggle」to perform either a show or a hide, depending on the current setting of the attribute. You can produce a「slideRight」effect (like the slideUp() method, but animating element width) like this:

$("img").animate({ width: "hide", borderLeft: "hide", borderRight: "hide", paddingLeft: "hide", paddingRight: "hide" });

Replace the property values with「show」or「toggle」to produce sideways slide effects analogous to slideDown() and slideToggle().

The animation options object

The second argument to animate() is an optional object that holds options that specify how the animation is performed. You’ve already seen two of the most important options. The duration property specifies the length of the animation in milliseconds, or as the string「fast」or「slow」, or any name you’ve defined in jQuery.fx.speeds.

Another option you’ve already seen is the complete property: it specifies a function that will be called when the animation is complete. A similar property, step, specifies a function that is called for each step or frame of the animation. The element being animated is the this value, and the current value of the property being animated is passed as the first argument.

The queue property of the options object specifies whether the animation should be queued—whether it should be deferred until any pending animations have completed. All animations are queued by default. Set the queue property to false to disable queuing. Unqueued animations start immediately. Subsequent queued animations are not deferred for unqueued animations. Consider the following code:

$("img").fadeIn(500) .animate({"width":"+=100"}, {queue:false, duration:1000}) .fadeOut(500);

The fadeIn() and fadeOut() effects are queued, but the call to animate() (which animates the width property for 1000ms) is not queued. The width animation begins at the same time the fadeIn() effect begins. The fadeOut() effect begins as soon as the fadeIn() effect ends: it does not wait for the width animation to complete.

Easing Functions

The straightforward but naive way to perform animations involves a linear mapping between time and the value being animated. If we are 100ms into a 400ms animation, for example, the animation is 25 percent done. If we are animating the opacity property from 1.0 to 0.0 (for a fadeOut() call, perhaps) in a linear animation, the opacity should be at 0.75 at this point of the animation. It turns out, however, that visual effects are more pleasing if they are not linear. So jQuery interposes an「easing function」that maps from a time-based completion percentage to the desired effect percentage. jQuery calls the easing function with a time-based value between 0 and 1. It returns another value between 0 and 1 and jQuery computes the value of the CSS property based on this computed value. Generally, easing functions are expected to return 0 when passed the value 0 and 1 when passed the value 1, of course, but they can be nonlinear between those two values and this nonlinearity makes the animation appear to accelerate and decelerate.

jQuery’s default easing function is a sinusoid: it starts off slow, then speeds up, then slows down again to「ease」the animation to its final value. jQuery gives its easing functions names. The default one is named「swing」, and jQuery also implements a linear function named「linear」. You can add your own easing functions to the jQuery.easing object:

jQuery.easing["squareroot"] = Math.sqrt;

The jQuery UI library and a plug-in known simply as「the jQuery Easing Plugin」define a comprehensive set of additional easing functions.

The remaining animation options involve easing functions. The easing property of the options object specifies the name of an easing function. By default, jQuery uses the sinusoidal function it calls「swing」. If you want your animations to be linear, use an options object like this:

$("img").animate({"width":"+=100"}, {duration: 500, easing:"linear"});

Recall that the duration, easing, and complete options can also be specified by arguments to animate() instead of passing an options object. So the animation above could also be written like this:

$("img").animate({"width":"+=100"}, 500, "linear");

Finally, jQuery’s animation framework even allows you to specify different easing functions for the different CSS properties you want to animate. There are two different ways to achieve this, demonstrated by the code below:

// Hide images, as with the hide() method, but animate the image size linearly // while the opacity is being animated with the default "swing" easing function // One way to do it: // Use the specialEasing option to specify custom easing functions $("img").animate({ width:"hide", height:"hide", opacity:"hide" }, { specialEasing: { width: "linear", height: "linear" }}); // Another way to do it: // Pass [target value, easing function] arrays in the first object argument. $("img").animate({ width: ["hide", "linear"], height: ["hide", "linear"], opacity:"hide" });

Canceling, Delaying, and Queuing Effects

jQuery defines a few more animation and queue-related methods that you should know about. The stop() method is first: it stops any currently executing animations on the selected elements. stop() accepts two optional boolean arguments. If the first argument is true, the animation queue will be cleared for the selected elements: this will cancel any pending animations as well as stopping the current one. The default is false: if this argument is omitted, queued animations are not canceled. The second argument specifies whether the CSS properties being animated should be left as they are currently or whether they should be set to their final target values. Passing true sets them to their final values. Passing false (or omitting the argument) leaves them at whatever their current value is.

When animations are triggered by user events, you may want to cancel any current or queued animations before beginning a new one. For example:

// Images become opaque when the mouse moves over them. // Be careful that we don't keep queueing up animations on mouse events! $("img").bind({ mouseover: function() { $(this).stop().fadeTo(300, 1.0); }, mouseout: function() { $(this).stop().fadeTo(300, 0.5); } });

The second animation-related method we’ll cover here is delay(). This simply adds a timed delay to the animation queue: pass a duration in milliseconds (or a duration string) as the first argument and a queue name as the optional second argument (the second argument is not normally needed: we’ll talk about queue names below). You can use delay() in compound animations like this one:

// Quickly fade out halfway, wait, then slide up $("img").fadeTo(100, 0.5).delay(200).slideUp();

In the stop() method example above, we used mouseover and mouseout events to animate the opacity of images. We can refine that example by adding a short delay before beginning the animation. That way, if the mouse quickly moves through an image without stopping, no distracting animation occurs:

$("img").bind({ mouseover: function() { $(this).stop(true).delay(100).fadeTo(300, 1.0); }, mouseout: function() { $(this).stop(true).fadeTo(300, 0.5); } });

The final animation-related methods are ones that give low-level access to the jQuery queuing mechanism. jQuery queues are lists of functions to be executed in sequence. Each queue is associated with a document element (or the Document or Window objects) and each element’s queues are independent of the queues of other elements. You can add a new function to the queue with the queue() method. When your function reaches the head of the queue, it will be automatically dequeued and invoked. When your function is invoked, the this value is the element with which it is associated. Your function will be passed a function as its single argument. When your function has completed its operation, it must invoke the function that was passed to it. This runs the next operation in the queue, and if you don’t call the function, the queue will stall and queued functions will never get invoked.

We’ve seen that you can pass a callback function to jQuery’s effect methods in order to perform some kind of action after the effect completes. You can achieve the same effect by queuing up your function:

// Fade an element in, wait, set some text in it, and animate its border $("#message").fadeIn().delay(200).queue(function(next) { $(this).text("Hello World"); // Display some text next(); // Run the next item on the queue }).animate({borderWidth: "+=10px;"}); // Grow its border

The function argument to queued functions is a new feature in jQuery 1.4. In code written for earlier versions of the library, queued functions dequeue the next function「manually」by calling the dequeue() method:

$(this).dequeue(); // Instead of next()

If there is nothing in the queue, calling dequeue() does nothing. Otherwise, it removes a function from the head of the queue and invokes it, setting the this value and passing the function described above.

There are a few more heavy-handed ways to manipulate the queue as well. clearQueue() clears the queue. Passing an array of functions to queue() instead of a single function replaces the queue with the new array of functions. And calling queue() with neither a function nor an array of functions returns the current queue as an array. Also, jQuery defines versions of the queue() and dequeue() methods as utility functions. If you want to add the function f to the queue for an element e, you can use either the method or the function:

