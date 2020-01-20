JavaScript code can appear inline within an HTML file between <script> and </script> tags:

<script> // Your JavaScript code goes here </script>

In XHTML, the content of a <script> element is treated like any other content. If your JavaScript code contains the < or & characters, these characters are interpreted as XML markup. For this reason, it is best to put all JavaScript code within a CDATA section if you are using XHTML:

<script><![CDATA[ // Your JavaScript code goes here ]]></script>

Example 13-2 is an HTML file that includes a simple JavaScript program. The comments explain what the program does, but the main point of this example is to demonstrate how JavaScript code is embedded within an HTML file along with, in this case, a CSS stylesheet. Notice that this example has a structure similar to Example 13-1 and uses the onload event handler in much the same way as that example did.

Example 13-2. A simple JavaScript digital clock

<!DOCTYPE html> <!-- This is an HTML5 file --> <html> <!-- The root element --> <head> <!-- Title, scripts & styles go here --> <title>Digital Clock</title> <script> // A script of js code // Define a function to display the current time function displayTime() { var elt = document.getElementById("clock"); // Find element with id="clock" var now = new Date(); // Get current time elt.innerHTML = now.toLocaleTimeString(); // Make elt display it setTimeout(displayTime, 1000); // Run again in 1 second } window.onload = displayTime; // Start displaying the time when document loads. </script> <style> /* A CSS stylesheet for the clock */ #clock { /* Style apply to element with id="clock" */ font: bold 24pt sans; /* Use a big bold font */ background: #ddf; /* On a light bluish-gray background */ padding: 10px; /* Surround it with some space */ border: solid black 2px; /* And a solid black border */ border-radius: 10px; /* Round the corners (where supported) */ } </style> </head> <body> <!-- The body is the displayed parts of the doc. --> <h1>Digital Clock</h1> <!-- Display a title --> <span id="clock"></span> <!-- The time gets inserted here --> </body> </html>

Scripts in External Files

The <script> tag supports a src attribute that specifies the URL of a file containing JavaScript code. It is used like this:

<script src="../../scripts/util.js"></script>

A JavaScript file contains pure JavaScript, without <script> tags or any other HTML. By convention, files of JavaScript code have names that end with .js.

A <script> tag with the src attribute specified behaves exactly as if the contents of the specified JavaScript file appeared directly between the <script> and </script> tags. Note that the closing </script> tag is required in HTML documents even when the src attribute is specified, and there is no content between the <script> and </script> tags. In XHTML, you can use the shortcut <script/> tag in this case.

When you use the src attribute, any content between the opening and closing <script> tags is ignored. If desired, you can use the content of the <script> tag to include documentation or copyright information for the included code. Note, however, that HTML5 validators will complain if any text that is not whitespace or a JavaScript comment appears between <script src=""> and </script>.

There are a number of advantages to using the src attribute:

It simplifies your HTML files by allowing you to remove large blocks of JavaScript code from them—that is, it helps keep content and behavior separate.

When multiple web pages share the same JavaScript code, using the src attribute allows you to maintain only a single copy of that code, rather than having to edit each HTML file when the code changes.

If a file of JavaScript code is shared by more than one page, it only needs to be downloaded once, by the first page that uses it—subsequent pages can retrieve it from the browser cache.

Because the src attribute takes an arbitrary URL as its value, a JavaScript program or web page from one web server can employ code exported by other web servers. Much Internet advertising relies on this fact.

The ability to load scripts from other sites allows us to take the benefits of caching a step further: Google is promoting the use of standard well-known URLs for the most commonly used client-side libraries, allowing the browser to cache a single copy for shared use by any site across the Web. Linking to JavaScript code on Google servers can decrease the start-up time for your web pages, since the library is likely to already exist in the user’s browser cache, but you must be willing to trust a third-party to serve code that is critical to your site. See http://code.google.com/apis/ajaxlibs/ for more information.

Loading scripts from servers other than the one that served the document that uses the script has important security implications. The same-origin security policy described in The Same-Origin Policy prevents JavaScript in a document from one domain from interacting with content from another domain. However, notice that the origin of the script itself does not matter: only the origin of the document in which the script is embedded. Therefore, the same-origin policy does not apply in this case: JavaScript code can interact with the document in which it is embedded, even when the code has a different origin than the document. When you use the src attribute to include a script in your page, you are giving the author of that script (and the webmaster of the domain from which the script is loaded) complete control over your web page.

Script Type

JavaScript was the original scripting language for the Web and <script> elements are, by default, assumed to contain or to reference JavaScript code. If you want to use a nonstandard scripting language, such as Microsoft’s VBScript (which is supported by IE only), you must use the type attribute to specify the script MIME type:

<script type="text/vbscript"> ' VBScript code goes here </script>

The default value of the type attribute is「text/javascript」. You can specify this type explicitly if you want, but it is never necessary.

Older browsers used a language attribute on the <script> tag instead of the type attribute, and you may still sometimes see web pages that include tags like this:

<script language="javascript"> // JavaScript code here... </script>

The language attribute is deprecated and should no longer be used.

When a web browser encounters a <script> element with a type attribute whose value it does not recognize, it parses the element but does not attempt to display or execute that content. This means that you can use the <script> element to embed arbitrary textual data into your document: just use the type attribute to specify a non-executable type for your data. To retrieve the data, you can use the text property of the HTML Element object that represents the script element (Chapter 15 explains how to obtain these elements). Note, however, that this data embedding technique only works for inline scripts. If you specify a src attribute and an unknown type, the script will be ignored and nothing will be downloaded from the URL you specified.

Event Handlers in HTML

JavaScript code in a script is executed once: when the HTML file that contains it is loaded into the web browser. In order to be interactive, a JavaScript program must define event handlers—JavaScript functions that are registered with the web browser and then invoked by the web browser in response to events (such as user input). As shown at the start of this chapter, JavaScript code can register an event handler by assigning a function to a property (such as onclick or onmouseover) of an Element object that represents an HTML element in the document. (There are also other ways to register event handlers—see Chapter 17.)

Event handler properties like onclick mirror HTML attributes with the same names, and it is also possible to define event handlers by placing JavaScript code in HTML attributes. For example, to define an event handler that is invoked when the user toggles a checkbox in a form, you can specify the handler code as an attribute of the HTML element that defines the checkbox:

<input type="checkbox" name="options" value="giftwrap" onchange="order.options.giftwrap = this.checked;">

What’s of interest here is the onchange attribute. The JavaScript code that is the value of this attribute will be executed whenever the user checks or unchecks the checkbox.

Event handler attributes defined in HTML may include any number of JavaScript statements, separated from each other by semicolons. These statements become the body of a function, and that function becomes the value of the corresponding event handler property. (The details of the conversion of HTML attribute text to a JavaScript function are covered in Setting Event Handler Attributes.) Typically, however, an HTML event handler attribute consists of a simple assignment as above or a simple invocation of a function defined elsewhere. This keeps most of your actual JavaScript code within scripts and reduces the need to mingle JavaScript and HTML. In fact, the use of HTML event handler attributes is considered poor style by many web developers who prefer to keep content and behavior separate.

JavaScript in URLs

Another way that JavaScript code can be included on the client side is in a URL following the javascript: protocol specifier. This special protocol type specifies that the body of the URL is an arbitrary string of JavaScript code to be run by the JavaScript interpreter. It is treated as a single line of code, which means that statements must be separated by semicolons and that /* */ comments must be used in place of // comments. The「resource」identified by a javascript: URL is the return value of the executed code, converted to a string. If the code has an undefined return value, the resource has no content.

You can use a javascript: URL anywhere you’d use a regular URL: the href attribute of an <a> tag, the action attribute of a <form>, for example, or even as an argument to a method like window.open(). A JavaScript URL in a hyperlink might look like this:

<a href="javascript:new Date().toLocaleTimeString();"> What time is it? </a>

Some browsers (such as Firefox) execute the code in the URL and use the returned string as the content of a new document to display. Just as when following a link to an http: URL, the browser erases the current document and displays the new one. The value returned by the code above does not contain any HTML tags, but if it did, the browser would have rendered them as it would have rendered the equivalent conventionally loaded HTML document. Other browsers (such as Chrome and Safari) do not allow URLs like the one above to overwrite the containing document—they just ignore the return value of the code. They do, however, still support URLs like this one:

<a href="javascript:alert(new Date().toLocaleTimeString());"> Check the time without overwriting the document </a>

When this sort of URL is loaded, the browser executes the JavaScript code, but because there is no returned value (the alert() method returns undefined), browsers like Firefox do not replace the currently displayed document. (In this case, the javascript: URL serves the same purpose as an onclick event handler. The link above would be better expressed as an onclick handler on a <button> element—the <a> element should generally be reserved for hyperlinks that load new documents.) If you want to ensure that a javascript: URL does not overwrite the document, you can use the void operator to force an invocation or assignment expression to be undefined:

<a href="javascript:void window.open('about:blank');">Open Window</a>

Without the void operator in this URL, the return value of the Window.open() method call would (in some browsers) be converted to a string and displayed, and the current document would be overwritten by a document that contains this text:

[object Window]

Like HTML event handler attributes, JavaScript URLs are a holdover from the early days of the Web and are generally avoided in modern HTML. javascript: URLs do have a useful role to play outside of HTML documents. If you need to test a small snippet of JavaScript code, you can type a javascript: URL directly into the location bar of your browser. Another legitimate (and powerful) use of javascript: URLs is in browser bookmarks, as described below.

Bookmarklets

In a web browser, a「bookmark」is a saved URL. If you bookmark a javascript: URL, you are saving a small script, known as a bookmarklet. A bookmarklet is a mini-program that can be easily launched from the browser’s menus or toolbar. The code in a bookmarklet runs as if it were a script on the page and can query and set document content, presentation, and behavior. As long as a bookmarklet does not return a value, it can operate on whatever document is currently displayed without replacing that document with new content.

Consider the following javascript: URL in an <a> tag. Clicking the link opens a simple JavaScript expression evaluator that allows you to evaluate expressions and execute statements in the context of the page:

<a href='javascript: var e = "", r = ""; /* Expression to evaluate and the result */ do { /* Display expression and result and ask for a new expression */ e = prompt("Expression: " + e + "\n" + r + "\n", e); try { r = "Result: " + eval(e); } /* Try to evaluate the expression */ catch(ex) { r = ex; } /* Or remember the error instead */ } while(e); /* Continue until no expression entered or Cancel clicked */ void 0; /* This prevents the current document from being overwritten */ '> JavaScript Evaluator </a>

Note that even though this JavaScript URL is written across multiple lines, the HTML parser treats it as a single line, and single-line // comments will not work in it. Also, remember that the code is all part of a single-quoted HTML attribute, so the code may not contain any single quotes.

A link like this is useful when hardcoded into a page that you are developing but becomes much more useful when stored as a bookmark that you can run on any page. Browsers typically allow you to bookmark the destination of a hyperlink by right-clicking on the link and selecting something like Bookmark Link or by dragging the link to your bookmarks toolbar.

Execution of JavaScript Programs

There is no formal definition of a program in client-side JavaScript. We can say that a JavaScript program consists of all the JavaScript code in a web page (inline scripts, HTML event handlers, and javascript: URLs) along with external JavaScript code referenced with the src attribute of a <script> tag. All of these separate bits of code share a single global Window object. That means that they all see the same Document object, and they share the same set of global functions and variables: if a script defines a new global variable or function, that variable or function will be visible to any JavaScript code that runs after the script does.

If a web page includes an embedded frame (using the <iframe> element), the JavaScript code in the embedded document has a different global object than the code in the embedding document, and it can be considered a separate JavaScript program. Remember, though, that there is no formal definition of what the boundaries of a JavaScript program are. If the container document and the contained document are from the same server, the code in one document can interact with the code in the other, and you can treat them as two interacting parts of a single program, if you wish. JavaScript in Interacting Windows explains more about the global Window object and the interactions between programs in separate windows and frames.

javascript: URLs in bookmarklets exist outside of any document and can be thought of as a kind of user extension or modification to other programs. When the user runs a bookmarklet, the bookmarked JavaScript code is given access to the global object and content of the current document and can manipulate it as desired.

JavaScript program execution occurs in two phases. In the first phase, the document content is loaded and the code from <script> elements (both inline scripts and external scripts) is run. Scripts generally (but not always; see Synchronous, Asynchronous, and Deferred Scripts) run in the order in which they appear in the document. The JavaScript code within any single script is run from top to bottom, in the order that it appears, subject, of course, to JavaScript’s conditionals, loops, and other control statements.

Once the document is loaded and all scripts have run, JavaScript execution enters its second phase. This phase is asynchronous and event-driven. During this event-driven phase, the web browser invokes event handler functions (defined by HTML event handler attributes, by scripts executed in the first phase, or by previously invoked event handlers) in response to events that occur asynchronously. Event handlers are most commonly invoked in response to user input (mouse clicks, keystrokes, etc.) but may also be triggered by network activity, elapsed time, or errors in JavaScript code. Events and event handlers are described in detail in Chapter 17. We’ll also have more to say about them in Event-Driven JavaScript. Note that javascript: URLs embedded in a web page can be thought of as a type of event handler, since they have no effect until activated by a user input event such as clicking on a link or submitting a form.

One of the first events that occurs during the event-driven phase is the load event, which indicates that the document is fully loaded and ready to be manipulated. JavaScript programs often use this event as a trigger or starting signal. It is common to see programs whose scripts define functions but take no action other than defining an onload event handler function to be triggered by the load event at the beginning of the event-driven phase of execution. It is this onload handler that then manipulates the document and does whatever it is that the program is supposed to do. The loading phase of a JavaScript program is relatively short, typically lasting only a second or two. Once the document is loaded, the event-driven phase lasts for as long as the document is displayed by the web browser. Because this phase is asynchronous and event-driven, there may be long periods of inactivity, where no JavaScript is executed, punctuated by bursts of activity triggered by user or network events. Client-Side JavaScript Timeline covers the two phases of JavaScript execution in more detail.

Both core JavaScript and client-side JavaScript have a single-threaded execution model. Scripts and event handlers are (or must appear to be) executed one at a time without concurrency. This keeps JavaScript programming simple and is discussed in Client-Side JavaScript Threading Model.

Synchronous, Asynchronous, and Deferred Scripts

When JavaScript was first added to web browsers, there was no API for traversing and manipulating the structure and content of a document. The only way that JavaScript code could affect the content of a document was to generate that content on the fly while the document was loading. It did this using the document.write() method. Example 13-3 shows what state-of-the-art JavaScript code looked like in 1996.

Example 13-3. Generating document content at load time

<h1>Table of Factorials</h1> <script> function factorial(n) { // A function to compute factorials if (n <= 1) return n; else return n*factorial(n-1); } document.write("<table>"); // Begin an HTML table document.write("<tr><th>n</th><th>n!</th></tr>"); // Output table header for(var i = 1; i <= 10; i++) { // Output 10 rows document.write("<tr><td>" + i + "</td><td>" + factorial(i) + "</td></tr>"); } document.write("</table>"); // End the table document.write("Generated at " + new Date()); // Output a timestamp </script>

When a script passes text to document.write(), that text is added to the document input stream, and the HTML parser behaves as if the script element had been replaced by that text. The use of document.write() is no longer considered good style, but it is still possible (see The document.write() Method) and this fact has an important implication. When the HTML parser encounters a <script> element, it must, by default, run the script before it can resume parsing and rendering the document. This is not much of a problem for inline scripts, but if the script source code is in an external file specified with a src attribute, this means that the portions of the document that follow the script will not appear in the browser until the script has been downloaded and executed.

This synchronous or blocking script execution is the default only. The <script> tag can have defer and async attributes, which (in browsers that support them) cause scripts to be executed differently. These are boolean attributes—they don’t have a value; they just need to be present on the <script> tag. HTML5 says that these attributes are only meaningful when used in conjunction with the src attribute, but some browsers may support deferred inline scripts as well:

<script defer src="deferred.js"></script> <script async src="async.js"></script>

Both the defer and async attributes are ways of telling the browser that the linked script does not use document.write() and won’t be generating document content, and that therefore the browser can continue to parse and render the document while downloading the script. The defer attribute causes the browser to defer execution of the script until after the document has been loaded and parsed and is ready to be manipulated. The async attribute causes the browser to run the script as soon as possible but not to block document parsing while the script is being downloaded. If a <script> tag has both attributes, a browser that supports both will honor the async attribute and ignore the defer attribute.

Note that deferred scripts run in the order in which they appear in the document. Async scripts run as they load, which means that they may execute out of order.

At the time of this writing, the async and defer attributes are not yet widely implemented, and they should be considered optimization hints only: your web pages should be designed to work correctly even if deferred and asynchronous scripts are executed synchronously.

You can load and execute scripts asynchronously, even in browsers that do not support the async attribute, by dynamically creating a <script> element and inserting it into the document. The loadasync() function shown in Example 13-4 does this. The techniques it uses are explained in Chapter 15.

Example 13-4. Asynchronously loading and executing a script

// Asynchronously load and execute a script from a specified URL function loadasync(url) { var head = document.getElementsByTagName("head")[0]; // Find document <head> var s = document.createElement("script"); // Create a <script> element s.src = url; // Set its src attribute head.appendChild(s); // Insert the <script> into head }

Notice that this loadasync() function loads scripts dynamically—scripts that are neither included inline within the web page nor referenced statically from the web page are loaded into the document and become part of the running JavaScript program.

Event-Driven JavaScript

The ancient JavaScript program shown in Example 13-3 is a synchronous one: it starts running when the page loads, produces some output, and then terminates. This kind of program is very uncommon today. Instead, we write programs that register event handler functions. These functions are then invoked asynchronously when the events for which they were registered occur. A web application that wants to enable keyboard shortcuts for common actions would register an event handler for key events, for example. Even noninteractive programs use events. Suppose you wanted to write a program that would analyze the structure of its document and automatically generate a table of contents for the document. No event handlers for user input events are necessary, but the program would still register an onload event handler so that it would know when the document had finished loading and was ready to have a table of contents generated.

Events and event handling are the subject of Chapter 17, but this section will provide a quick overview. Events have a name, such as「click」,「change」,「load」,「mouseover」,「keypress」, or「readystatechange」, that indicates the general type of event that has occurred. Events also have a target, which is the object on which they occurred. When we speak of an event, we must specify both the event type (the name) and the target: a click event on an HTMLButtonElement object, for example, or a readystatechange event on an XMLHttpRequest object.

If we want our program to respond to an event, we write a function known as an「event handler,」「event listener,」or sometimes just a「callback.」We then register this function so that it is invoked when the event occurs. As noted earlier, this can be done using HTML attributes, but this kind of mixing of JavaScript code with HTML content is discouraged. Instead, the simplest way to register an event handler is usually to assign a JavaScript function to a property of the target object, with code like this:

window.onload = function() { ... }; document.getElementById("button1").onclick = function() { ... }; function handleResponse() { ... } request.onreadystatechange = handleResponse;

Notice that event handler properties have names that, by convention, begin with「on」and are followed by the name of the event. Also notice that there are no function invocations in any of the code above: we’re assigning functions themselves to these properties. The browser will perform the invocation when the events occur. Asynchronous programming with events often involves nested functions and it is not uncommon to end up writing code that defines functions within functions within functions.

In most browsers, for most kinds of events, event handlers are passed an object as an argument, and the properties of this object provide details about the event. The object passed to a click event, for example, would have a property that specified which mouse button was clicked. (In IE, these event details are stored in the global event object instead of being passed to the handler function.) The return value of an event handler is sometimes used to indicate whether the function has sufficiently handled the event and to prevent the browser from performing whatever default action it would otherwise take.

Events whose targets are elements in a document often propagate up the document tree in a process known as「bubbling.」If the user clicks the mouse on a <button> element, for example, a click event is fired on the button. If that event is not handled (and its propagation stopped) by a function registered on the button, the event bubbles up to whatever element the button is nested within, and any click event handler registered on that container element will be invoked.

If you need to register more than one event handler function for a single event, or if you want to write a module of code that can safely register event handlers even if another module has already registered a handler for the same event on the same target, you have to use another event handler registration technique. Most objects that can be event targets have a method named addEventListener(), which allows the registration of multiple listeners:

window.addEventListener("load", function() {...}, false); request.addEventListener("readystatechange", function() {...}, false);

Note that the first argument to this function is the name of the event. Although add Event Listener() has been standardized for over a decade, Microsoft is only now implementing it for IE9. In IE8 and earlier, you must use a similar method, named attachEvent() :

window.attachEvent("onload", function() {...});

See Chapter 17 for more on addEventListener() and attachEvent().

Client-side JavaScript programs also use other kinds of asynchronous notification that are not, technically speaking, events. If you set the onerror property of the Window object to a function, that function will be invoked when a JavaScript error (or any uncaught exception) occurs (see Error Handling). Also, the setTimeout() and setInterval() functions (these are methods of the Window object and therefore global functions of client-side JavaScript) trigger the invocation of a specified function after a specified amount of time. The functions passed to setTimeout() are registered differently than true event handlers, and they are usually called「callbacks」instead of「handlers,」but they are asynchronous just as event handlers are. See Timers for more on setTimeout() and setInterval().

Example 13-5 demonstrates setTimeout(), addEventListener(), and attachEvent() to define an onLoad() function that registers a function to be run when the document finishes loading. onLoad() is a very useful function, and we’ll use it in examples throughout the rest of this book.

Example 13-5. onLoad(): invoke a function when the document loads

// Register the function f to run when the document finishes loading. // If the document has already loaded, run it asynchronously ASAP. function onLoad(f) { if (onLoad.loaded) // If document is already loaded window.setTimeout(f, 0); // Queue f to be run as soon as possible else if (window.addEventListener) // Standard event registration method window.addEventListener("load", f, false); else if (window.attachEvent) // IE8 and earlier use this instead window.attachEvent("onload", f); } // Start by setting a flag that indicates that the document is not loaded yet. onLoad.loaded = false; // And register a function to set the flag when the document does load. onLoad(function() { onLoad.loaded = true; });

Client-Side JavaScript Threading Model

The core JavaScript language does not contain any threading mechanism, and client-side JavaScript has traditionally not defined any either. HTML5 defines「WebWorkers」which serve as a kind of a background thread (more on web workers follows), but client-side JavaScript still behaves as if it is strictly single-threaded. Even when concurrent execution is possible, client-side JavaScript cannot ever detect the fact that it is occurring.

Single-threaded execution makes for much simpler scripting: you can write code with the assurance that two event handlers will never run at the same time. You can manipulate document content knowing that no other thread is attempting to modify it at the same time, and you never need to worry about locks, deadlock, or race conditions when writing JavaScript code.

Single-threaded execution means that web browsers must stop responding to user input while scripts and event handlers are executing. This places a burden on JavaScript programmers: it means that JavaScript scripts and event handlers must not run for too long. If a script performs a computationally intensive task, it will introduce a delay into document loading, and the user will not see the document content until the script completes. If an event handler performs a computationally intensive task, the browser may become nonresponsive, possibly causing the user to think that it has crashed.[26]

If your application must perform enough computation to cause a noticeable delay, you should allow the document to load fully before performing that computation, and you should be sure to notify the user that computation is underway and that the browser is not hung. If it is possible to break your computation down into discrete subtasks, you can use methods such as setTimeout() and setInterval() to run the subtasks in the background while updating a progress indicator that displays feedback to the user.

HTML5 defines a controlled form of concurrency called a「web worker.」A web worker is a background thread for performing computationally intensive tasks without freezing the user interface. The code that runs in a web worker thread does not have access to document content, does not share any state with the main thread or with other workers, and can only communicate with the main thread and other workers through asynchronous events, so the concurrency is not detectable to the main thread, and web workers do not alter the basic single-threaded execution model of JavaScript programs. See Web Workers for full details on web workers.

Client-Side JavaScript Timeline

We’ve already seen that JavaScript programs begin in a script execution phase and then transition to an event-handling phase. This section explains the timeline of JavaScript program execution in more detail.

The web browser creates a Document object and begins parsing the web page, adding Element objects and Text nodes to the document as it parses HTML elements and their textual content. The document.readyState property has the value「loading」at this stage.

When the HTML parser encounters <script> elements that have neither the async nor defer attributes, it adds those elements to the document and then executes the inline or external script. These scripts are executed synchronously, and the parser pauses while the script downloads (if necessary) and runs. Scripts like these can use document.write() to insert text into the input stream. That text will become part of the document when the parser resumes. Synchronous scripts often simply define functions and register event handlers for later use, but they can traverse and manipulate the document tree as it exists when they run. That is, synchronous scripts can see their own <script> element and document content that comes before it.

When the parser encounters a <script> element that has the async attribute set, it begins downloading the script text and continues parsing the document. The script will be executed as soon as possible after it has downloaded, but the parser does not stop and wait for it to download. Asynchronous scripts must not use the document.write() method. They can see their own <script> element and all document elements that come before it, and may or may not have access to additional document content.

When the document is completely parsed, the document.readyState property changes to「interactive」.

Any scripts that had the defer attribute set are executed, in the order in which they appeared in the document. Async scripts may also be executed at this time. Deferred scripts have access to the complete document tree and must not use the document.write() method.

The browser fires a DOMContentLoaded event on the Document object. This marks the transition from synchronous script execution phase to the asynchronous event-driven phase of program execution. Note, however, that there may still be async scripts that have not yet executed at this point.

The document is completely parsed at this point, but the browser may still be waiting for additional content, such as images, to load. When all such content finishes loading, and when all async scripts have loaded and executed, the document. readyState property changes to「complete」and the web browser fires a load event on the Window object.

From this point on, event handlers are invoked asynchronously in response to user input events, network events, timer expirations, and so on.

This is an idealized timeline and all browsers do not support all of its details. The load event is universally supported: all browsers fire it, and it is the most common technique for determining that the document is completely loaded and ready to manipulate. The DOMContentLoaded event fires before the load event and is supported by all current browsers except IE. The document.readyState property is implemented by most browsers at the time of this writing, but the values of this property differ slightly from browser to browser. The defer attribute is supported by all current versions of IE, but it is only now being implemented by other browsers. Support for the async attribute is not yet common at the time of this writing, but asynchronous script execution via the technique shown in Example 13-4 is supported by all current browsers. (Notice, though, that the ability to dynamically load scripts with functions like loadasync() blurs the boundary between the script loading and event-driven phases of program execution.)

This timeline does not specify when the document becomes visible to the user or when the web browser must start responding to user input events. Those are implementation details. For very long documents or very slow network connections, it is theoretically possible that a web browser will render part of a document and allow the user to start interacting with it before all the scripts have executed. In that case, user input events might be fired before the event-driven phase of program execution has formally started.

* * *

[26] Some browsers guard against denial-of-service attacks and accidental infinite loops by prompting the user if a script or event handler takes too long to run. This gives the user the chance to abort a runaway script.

Compatibility and Interoperability

The web browser is the operating system for web apps, but the web is a heterogeneous environment and your web documents and applications will be viewed and run in browsers of different ages (from cutting-edge beta releases to decade-old browsers like IE6) from different vendors (Microsoft, Mozilla, Apple, Google, Opera) running on different operating systems (Windows, Mac OS, Linux, iPhone OS, Android). It is challenging to write nontrivial client-side JavaScript programs that run correctly on such a wide variety of platforms.

Client-side JavaScript compatibility and interoperability issues fall into three general categories:

Evolution

The web platform is always evolving and expanding. A standards body proposes a new feature or API. If the feature seems useful, browser vendors implement it. If enough vendors implement it interoperably, developers begin to use and depend on the feature, and it secures a permanent place in the web platform. Sometimes browser vendors and web developers take the lead and standards bodies write the official version well after the feature is already a de facto standard. In either case, a new feature has been added to the Web. New browsers support it and old browsers do not. Web developers are pulled between wanting to use powerful new features and wanting their web pages to be usable by the largest number of visitors—even those who are not using the latest browsers.

Nonimplementation

Sometimes browser vendors differ in their opinions of whether a particular feature is useful enough to implement. Some vendors implement it and others do not. This is not a matter of current browsers with the feature versus older browsers without it, but a matter of browser implementors who prioritized the feature versus those who did not. IE8, for example, does not support the <canvas> element, though all other browsers have embraced it. A more egregious example is Microsoft’s decision not to implement the DOM Level 2 Events specification (which defines addEvent Listener() and related methods). This specification was standardized almost a decade ago, and other browser vendors have long since supported it.[27]

Bugs

Every browser has bugs, and none implement all of the client-side JavaScript APIs exactly as specified. Sometimes, writing compatible client-side JavaScript code is a matter of being aware of, and knowing how to work around, the bugs in existing browsers.

Fortunately, the JavaScript language itself is interoperably implemented by all browser vendors and is not a source of compatibility problems. All browsers have interoperable implementations of ES3, and, at the time of this writing, all vendors are working on implementing ES5. The transition between ES3 and ES5 may be the source of compatibility problems, because some browsers will support strict mode while others do not, but the expectation is that browser vendors will implement ES5 interoperably.

The first step in addressing compatibility issues in client-side JavaScript is to be aware of what those issues are. The web browser release cycle is about three times as rapid as the release cycle for this book, which means that this book cannot reliably tell you which versions of which browser implement which features, much less describe the bugs in or the quality of implementation of the features in various browsers. Details like this are best left to the Web. The HTML5 standardization effort aims to eventually produce a test suite. At the time of this writing, no such tests exist, but once they do, they ought to provide a wealth of browser compatibility information. In the meantime, here are some websites you might find useful:

https://developer.mozilla.org

The Mozilla Developer Center

http://msdn.microsoft.com

The Microsoft Developer Network

http://developer.apple.com/safari

The Safari Dev Center at the Apple Developer Connection

http://code.google.com/doctype

Google describes its Doctype project as「an encyclopedia of the open web.」This user-editable site includes extensive compatibility tables for client-side JavaScript. At the time of this writing, these tables report only on the existence of various properties and methods in each browser: they do not actually say whether those features work correctly.

http://en.wikipedia.org/wiki/Comparison_of_layout_engines_(HTML_5)

A Wikipedia article tracking the implementation status of HTML5 features and APIs in various browsers.

http://en.wikipedia.org/wiki/Comparison_of_layout_engines_(Document_Object_Model)

A similar article that tracks the implementation status of DOM features.

http://a.deveria.com/caniuse

The「When can I use...」website tracks the implementation status of important web features, allows them to be filtered according to various criteria, and recommends their use once there are few remaining deployed browsers that do not support the feature.

http://www.quirksmode.org/dom

Tables that list the compatibility of various browsers with the W3C DOM.

http://webdevout.net/browser-support

Another site that attempts to track the implementation of web standards by browser vendors.

Note that the last three sites listed are maintained by individuals. Despite the dedication of these client-side JavaScript heroes, these sites may not always be up to date.

Awareness of the incompatibilities between browsers is only the first step, of course. Next, you must decide how to address the incompatibilities. One strategy is to restrict yourself to using only those features that are universally supported (or easily emulated) by all of the browsers that you choose to support. The「When can I use...」website mentioned previously (http://a.deveria.com/caniuse) is based around this strategy: it lists a number of features that will become usable as soon as IE6 has been phased out and no longer has a significant market share. The subsections that follow explain a few less passive strategies you can use to work around client-side incompatibilities.

A Word about「Current Browsers」

Client-side JavaScript is a moving target, especially with the advent of ES5 and HTML5. Because the platform is evolving rapidly, I shy away from making narrow statements about particular versions of particular browsers: any such claims are likely to be outdated well before a new edition of this book appears. You’ll find, therefore, that I often hedge my statements with purposely vague language like「all current browsers」(or sometimes「all current browsers except IE」). To put this in context, while I was writing this chapter, the current (non-beta) browsers were:

Internet Explorer 8

Firefox 3.6

Safari 5

Chrome 5

Opera 10.10

When this book reaches bookstores, the current browsers will likely be Internet Explorer 9, Firefox 4, Safari 5, Chrome 11, and Opera 11.

This is not a guarantee that every statement in this book about「current browsers」is true for each of these specific browsers. However, it allows you to know what browsers were current technology when this book was written.

The fifth edition of this book used the phrase「modern browsers」instead of「current browsers.」That edition was published in 2006, when the current browsers were Firefox 1.5, IE6, Safari 2, and Opera 8.5 (the Chrome browser from Google did not exist yet). Any references to「modern browsers」remaining in this book can now be taken to mean「all browsers,」since browsers older than those are now quite rare.

Many of the newest client-side features described in this book (in Chapter 22 particularly) are not yet implemented by all browsers. The features that I’ve chosen to document in this edition are being developed under an open standards process, have been implemented in at least one released browser, are under development in at least one more, and seem likely to be adopted by all browser vendors (with the possible exception of Microsoft).

Compatibility Libraries

One of the easiest ways to deal with incompatibilities is to use libraries of code that work around them for you. Consider the <canvas> element for client-side graphics (the topic of Chapter 21), for example. IE is the only current browser that does not support this feature. It does support an obscure proprietary client-side graphics language called VML, however, and the canvas element can be emulated on top of that. The open source「explorercanvas」project at http://code.google.com/p/explorercanvas has released a library that does just that: you include a single file of JavaScript code named excanvas.js and IE will behave as if it supports the <canvas> element.

excanvas.js is a particularly pure example of a compatibility library. It is possible to write similar libraries for certain features. The ES5 Array methods (ECMAScript 5 Array Methods), such as forEach() , map(), and reduce(), can be almost perfectly emulated in ES3, and by adding the appropriate library to your pages, you can treat these powerfully useful methods as part of the baseline platform of all browsers.

Sometimes, however, it is not possible to completely (or efficiently) implement a feature on browsers that do not support it. As already mentioned, IE is the only browser that does not implement the standard event-handling API, including the addEvent Listener() method for registering event handlers. IE supports a similar method called attachEvent(). attachEvent() is not as powerful as addEventListener() and it is not really feasible to transparently implement the entire standard on top of what IE offers. Instead, developers sometimes define a compromise event handling method—often called addEvent()—that can be portably implemented using either addEvent Listener() or attachEvent(). Then, they write all their code to use addEvent() instead of either addEventListener() or attachEvent().

In practice, many web developers today use client-side JavaScript frameworks such as jQuery (see Chapter 19) on all their web pages. One of the functions that makes these frameworks so indispensable is that they define a new client-side API and implement it compatibly for you across all browsers. In jQuery, for example, event handler registration is done with a method named bind(). If you adopt jQuery for all your web development, you’ll never need to think about the incompatibilities between add Event Listener() and attachEvent(). See Client-Side Frameworks for more on client-side frameworks.

Graded Browser Support

Graded browser support is a testing and QA technique pioneered and championed by Yahoo! that brings some sanity to the otherwise unmanageable proliferation of vendor/version/OS browser variants. Briefly, graded browser support involves choosing「A-grade」browsers that receive full support and testing and identifying「C-grade」browsers that are not powerful enough. A-grade browsers get full-featured web pages, and C-grade browsers are served minimal HTML-only versions of the pages that require no JavaScript or CSS. Browsers that are not A-grade or C-grade are called X-grade: these are usually brand-new or particularly rare browsers. They are assumed to be capable and are served the full-featured web pages, but they are not officially supported or tested.

You can read more about Yahoo!’s system of graded browser support at http://developer.yahoo.com/yui/articles/gbs. That web page also includes Yahoo!’s current list of A-grade and C-grade browsers (the list is updated quarterly). Even if you don’t adopt graded browser support techniques yourself, Yahoo!’s list of A-grade browsers is a useful way to determine which browsers are current and have significant market share.

Feature Testing

Feature testing (sometimes called capability testing) is a powerful technique for coping with incompatibilities. If you want to use a feature or capability that may not be supported by all browsers, include code in your script that tests to see whether that feature is supported. If the desired feature is not supported on the current platform, either do not use it on that platform or provide alternative code that works on all platforms.

You’ll see feature testing again and again in the chapters that follow. In Chapter 17, for example, we use code that looks like this:

if (element.addEventListener) { // Test for this W3C method before using it element.addEventListener("keydown", handler, false); element.addEventListener("keypress", handler, false); } else if (element.attachEvent) { // Test for this IE method before using it element.attachEvent("onkeydown", handler); element.attachEvent("onkeypress", handler); } else { // Otherwise, fall back on a universally supported technique element.onkeydown = element.onkeypress = handler; }

The important thing about the feature-testing technique is that it results in code that is not tied to a specific list of browser vendors or browser version numbers. It works with the set of browsers that exists today and should continue to work with future browsers, whatever feature sets they implement. Note, however, that it requires browser vendors not to define a property or method unless that property or method is fully functional. If Microsoft were to define an addEventListener() method that only partially implemented the W3C specification, it would break a lot of code that uses feature testing before calling addEventListener().

Quirks Mode and Standards Mode

When Microsoft released IE6, it added support for a number of standard CSS features that were not supported in IE5. In order to ensure backward compatibility with existing web content, however, it had to define two distinct rendering modes. In「standards mode」or「CSS compatibility mode,」the browser would follow CSS standards. In「quirks mode,」the browser would behave in the quirky nonstandard manner that IE4 and IE5 had. The choice of rendering modes depended on the DOCTYPE declaration at the top of the HTML file. Pages with no DOCTYPE at all and pages that declared certain permissive doctypes that were in common use during the IE5 era were rendered in quirks mode. Pages with strict doctypes (or, for forward compatibility, pages with unrecognized doctypes) were rendered in standards mode. Pages with an HTML5 doctype (<!DOCTYPE html>) are rendered in standards mode in all modern browsers.

This distinction between quirks mode and standards mode has stood the test of time. New versions of IE still implement it, other modern browsers do too, and the existence of these two modes is recognized by the HTML5 specification. The differences between quirks mode and standards mode usually matter most to people writing HTML and CSS. But client-side JavaScript code sometimes needs to know which mode a document is rendered in. To perform this kind of rendering mode feature testing, check the document. compatMode property. If it has the value「CSS1Compat,」the browser is using standards mode. If the value is「BackCompat」(or undefined if the property doesn’t exist at all), the browser is using quirks mode. All modern browsers implement the compatMode property, and the HTML5 specification standardizes it.

It is not often necessary to test compatMode. Example 15-8 illustrates one case where this test is necessary, however.

Browser Testing

Feature testing is well suited to checking for support of large functional areas. You can use it to determine whether a browser supports the W3C event-handling model or the IE event-handling model, for example. On the other hand, sometimes you may need to work around individual bugs or quirks in a particular browser, and there may be no easy way to test for the existence of the bug. In this case, you need to create a platform-specific workaround that is tied to a particular browser vendor, version, or operating system (or some combination of the three).

The way to do this in client-side JavaScript is with the Navigator object, which you’ll learn about in Chapter 14. Code that determines the vendor and version of the current browser is often called a browser sniffer or a client sniffer. A simple example is shown in Example 14-3. Client sniffing was a common programming technique in the early days of the Web, when the Netscape and IE platforms were incompatible and diverging. Client sniffing has now fallen out of favor and should be used only when absolutely necessary.

Note that client sniffing can be done on the server side as well, with the web server choosing what JavaScript code to send based on how the browser identifies itself in its User-Agent header.

Conditional Comments in Internet Explorer

In practice, you’ll find that many of the incompatibilities in client-side JavaScript programming turn out to be IE-specific. That is, you must write code in one way for IE and in another way for all other browsers. IE supports conditional comments (introduced in IE5) that are completely nonstandard but can be quite useful for working around incompatibilities.

Here is what IE’s conditional comments look like in HTML. Notice the tricks played with the closing delimiter of HTML comments:

<!--[if IE 6]> This content is actually inside an HTML comment. It will only be displayed in IE 6. <![endif]--> <!--[if lte IE 7]> This content will only be displayed by IE 5, 6 and 7 and earlier. lte stands for "less than or equal". You can also use "lt", "gt" and "gte". <![endif]--> <!--[if !IE]> <--> This is normal HTML content, but IE will not display it because of the comment above and the comment below. <!--> <![endif]--> This is normal content, displayed by all browsers.

As a concrete example, consider the excanvas.js library described above to implement the <canvas> element in Internet Explorer. Since this library is required only in IE (and works only in IE), it is reasonable to include it on your pages within a conditional comment so that other browsers never load it:

<!--[if IE]><script src="excanvas.js"></script><![endif]-->

Conditional comments are also supported by IE’s JavaScript interpreter, and C and C++ programmers may find them similar to the #ifdef/#endif functionality of the C preprocessor. A JavaScript conditional comment in IE begins with the text /*@cc_on and ends with the text @*/. (The cc in cc_on stands for conditional compilation.) The following conditional comment includes code that is executed only in IE:

/*@cc_on @if (@_jscript) // This code is inside a JS comment but is executed in IE. alert("In IE"); @end @*/

Inside a conditional comment, the keywords @if, @else, and @end delimit the code that is to be conditionally executed by IE’s JavaScript interpreter. Most of the time, you need only the simple conditional shown above: @if (@_jscript). JScript is Microsoft’s name for its JavaScript interpreter, and the @_jscript variable is always true in IE.

With clever interleaving of conditional comments and regular JavaScript comments, you can set up one block of code to run in IE and a different block to run in all other browsers:

/*@cc_on @if (@_jscript) // This code is inside a conditional comment, which is also a // regular JavaScript comment. IE runs it but other browsers ignore it. alert('You are using Internet Explorer); @else*/ // This code is no longer inside a JavaScript comment, but is still // inside the IE conditional comment. This means that all browsers // except IE will run this code. alert('You are not using Internet Explorer'); /*@end @*/

* * *

[27] To Microsoft’s credit, IE9 now supports both the <canvas> element and the addEventListener() method.

Accessibility

The Web is a wonderful tool for disseminating information, and JavaScript programs can enhance access to that information. JavaScript programmers must be careful, however: it is easy to write JavaScript code that inadvertently denies information to visitors with visual or physical handicaps.

Blind users may use a form of「assistive technology」known as a screen reader to convert written words to spoken words. Some screen readers are JavaScript-aware, and others work best when JavaScript is turned off. If you design a website that requires JavaScript to display its information, you exclude the users of these screen readers. (And you have also excluded anyone who intentionally disables JavaScript in her browser.) The proper role of JavaScript is to enhance the presentation of information, not to take over the presentation of that information. A cardinal rule of JavaScript accessibility is to design your code so that the web page on which it is used will still function (at least in some form) with the JavaScript interpreter turned off.

Another important accessibility concern is for users who can use the keyboard but cannot use (or choose not to use) a pointing device such as a mouse. If you write JavaScript code that relies on mouse-specific events, you exclude users who do not use the mouse. Web browsers allow keyboard traversal and activation of UI elements within a web page, and your JavaScript code should as well. As shown in Chapter 17, JavaScript supports device-independent events, such as onfocus and onchange, as well as device-dependent events, such as onmouseover and onmousedown. For accessibility, you should favor the device-independent events whenever possible.

Creating accessible web pages is a nontrivial problem and a full discussion of accessibility is beyond the scope of this book. Web application developers who are concerned about accessibility should familiarize themselves with the WAI-ARIA (Web Accessibility Initiative–Accessible Rich Internet Applications) standards at http://www.w3.org/WAI/intro/aria.

Security

The introduction of JavaScript interpreters into web browsers means that loading a web page can cause arbitrary JavaScript code to be executed on your computer. This has clear security implications, and browser vendors have worked hard to balance two competing goals:

Defining powerful client-side APIs to enable useful web applications.

Preventing malicious code from reading or altering your data, compromising your privacy, scamming you, or wasting your time.

As in many fields, JavaScript security has evolved through an interactive and ongoing process of exploits and patches. In the early days of the Web, browsers added features like the ability to open, move, and resize windows and to script the browser’s status line. When unethical advertisers and scammers started abusing these features, browser makers had to restrict or disable those APIs. Today, in the process of standardizing HTML5, browser vendors are carefully (and openly and collaboratively) lifting certain long-standing security restrictions and adding quite a bit of power to client-side JavaScript while (hopefully) not introducing any new security holes.

The subsections below introduce the JavaScript security restrictions and security issues that you, as a web developer, need to be aware of.

What JavaScript Can’t Do

Web browsers’ first line of defense against malicious code is that they simply do not support certain capabilities. For example, client-side JavaScript does not provide any way to write or delete arbitrary files or list arbitrary directories on the client computer. This means a JavaScript program cannot delete data or plant viruses. (But see Reading Blobs to learn how JavaScript can read user-selected files and see The Filesystem API to learn how JavaScript can obtain a secure private filesystem within which it can read and write files.)

Similarly, client-side JavaScript does not have any general-purpose networking capabilities. A client-side JavaScript program can script the HTTP protocol (see Chapter 18). And another HTML5-affiliated standard, known as WebSockets, defines a socket-like API for communicating with specialized servers. But neither of these APIs allows unmediated access to the wider network. General-purpose Internet clients and servers cannot be written in client-side JavaScript.

Browsers’ second line of defense against malicious code is that they impose restrictions on the use of certain features that they do support. The following are some restricted features:

A JavaScript program can open new browser windows, but, to prevent pop-up abuse by advertisers, most browsers restrict this feature so that it can happen only in response to a user-initiated event, such as a mouse click.

A JavaScript program can close browser windows that it opened itself, but it is not allowed to close other windows without user confirmation.

The value property of HTML FileUpload elements cannot be set. If this property could be set, a script could set it to any desired filename and cause the form to upload the contents of any specified file (such as a password file) to the server.

A script cannot read the content of documents loaded from different servers than the document that contains the script. Similarly, a script cannot register event listeners on documents from different servers. This prevents scripts from snooping on the user’s input (such as the keystrokes that constitute a password entry) to other pages. This restriction is known as the same-origin policy and is described in more detail in the next section.

Note that this is not a definitive list of client-side JavaScript restrictions. Different browsers have different security policies and may implement different API restrictions. Some browsers may also allow restrictions to be strengthened or weakened through user preferences.

The Same-Origin Policy

The same-origin policy is a sweeping security restriction on what web content JavaScript code can interact with. It typically comes into play when a web page includes <iframe> elements or opens other browser windows. In this case, the same-origin policy governs the interactions of JavaScript code in one window or frame with the content of other windows and frames. Specifically, a script can read only the properties of windows and documents that have the same origin as the document that contains the script (see Multiple Windows and Frames to learn how to use JavaScript with multiple windows and frames).

The origin of a document is defined as the protocol, host, and port of the URL from which the document was loaded. Documents loaded from different web servers have different origins. Documents loaded through different ports of the same host have different origins. And a document loaded with the http: protocol has a different origin than one loaded with the https: protocol, even if they come from the same web server.

It is important to understand that the origin of the script itself is not relevant to the same-origin policy: what matters is the origin of the document in which the script is embedded. Suppose, for example, that a script hosted by host A is included (using the src property of a <script> element) in a web page served by host B. The origin of that script is host B and the script has full access to the content of the document that contains it. If the script opens a new window and loads a second document from host B, the script also has full access to the content of that second document. But if the script opens a third window and loads a document from host C (or even one from host A) into it, the same-origin policy comes into effect and prevents the script from accessing this document.

The same-origin policy does not actually apply to all properties of all objects in a window from a different origin. But it does apply to many of them, and, in particular, it applies to practically all the properties of the Document object. You should consider any window or frame that contains a document from another server to be off-limits to your scripts. If your script opened the window, your script can close it, but it cannot「look inside」the window in any way. The same-origin policy also applies to scripted HTTP requests made with the XMLHttpRequest object (see Chapter 18). This object allows client-side JavaScript code to make arbitrary HTTP requests to the web server from which the containing document was loaded, but it does not allow scripts to communicate with other web servers.

The same-origin policy is necessary to prevent scripts from stealing proprietary information. Without this restriction, a malicious script (loaded through a firewall into a browser on a secure corporate intranet) might open an empty window, hoping to trick the user into using that window to browse files on the intranet. The malicious script would then read the content of that window and send it back to its own server. The same-origin policy prevents this kind of behavior.

Relaxing the same-origin policy

In some circumstances, the same-origin policy is too restrictive. This section describes three techniques for relaxing it.

The same-origin policy poses problems for large websites that use multiple subdomains. For example, a script in a document from home.example.com might legitimately want to read properties of a document loaded from developer.example.com, or scripts from orders.example.com might need to read properties from documents on catalog.example.com. To support multidomain websites of this sort, you can use the domain property of the Document object. By default, the domain property contains the hostname of the server from which the document was loaded. You can set this property, but only to a string that is a valid domain suffix of itself. Thus, if domain is originally the string「home.example.com」, you can set it to the string「example.com」, but not to「home.example」or「ample.com」. Furthermore, the domain value must have at least one dot in it; you cannot set it to「com」or any other top-level domain.

If two windows (or frames) contain scripts that set domain to the same value, the same-origin policy is relaxed for these two windows, and each window can interact with the other. For example, cooperating scripts in documents loaded from orders. example.com and catalog.example.com might set their document.domain properties to「example.com」, thereby making the documents appear to have the same origin and enabling each document to read properties of the other.

The second technique for relaxing the same-origin policy is being standardized under the name Cross-Origin Resource Sharing (see http://www.w3.org/TR/cors/). This draft standard extends HTTP with a new Origin: request header and a new Access-Control-Allow-Origin response header. It allows servers to use a header to explicitly list origins that may request a file or to use a wildcard and allow a file to be requested by any site. Browsers such as Firefox 3.5 and Safari 4 use this new header to allow the cross-origin HTTP requests with XMLHttpRequest that would otherwise have been forbidden by the same-origin policy.

Another new technique, known as cross-document messaging, allows a script from one document to pass textual messages to a script in another document, regardless of the script origins. Calling the postMessage() method on a Window object results in the asynchronous delivery of a message event (you can handle it with an onmessage event handler function) to the document in that window. A script in one document still cannot invoke methods or read properties of the other document, but they can communicate safely through this message-passing technique. See Cross-Origin Messaging for more on the cross-document messaging API.

Scripting Plug-ins and ActiveX Controls

Although the core JavaScript language and the basic client-side object model lack the filesystem and networking features that the worst malicious code requires, the situation is not quite as simple as it appears. In many web browsers, JavaScript is used as a「script engine」for ActiveX controls (in IE) or plug-ins (other browsers). The Flash and Java plug-ins are commonly installed examples, and they expose important and powerful features to client-side scripts.

There are security implications to being able to script ActiveX controls and plug-ins. Java applets, for example, have access to low-level networking capabilities. The Java security「sandbox」prevents applets from communicating with any server other than the one from which they were loaded, so this does not open a security hole. But it exposes the basic problem: if plug-ins are scriptable, you must trust not just the web browser’s security architecture, but also the plug-in’s security architecture. In practice, the Java and Flash plug-ins seem to have robust security and they are actively maintained and updated when security holes are discovered. ActiveX scripting has had a more checkered past, however. The IE browser has access to a variety of scriptable ActiveX controls that are part of the Windows operating system, and in the past some of these scriptable controls have included exploitable security holes.

Cross-Site Scripting

Cross-site scripting, or XSS, is a term for a category of security issues in which an attacker injects HTML tags or scripts into a target website. Defending against XSS attacks is typically the job of server-side web developers. However, client-side JavaScript programmers must also be aware of, and defend against, cross-site scripting.

A web page is vulnerable to cross-site scripting if it dynamically generates document content and bases that content on user-submitted data without first「sanitizing」that data by removing any embedded HTML tags from it. As a trivial example, consider the following web page that uses JavaScript to greet the user by name:

<script> var name = decodeURIComponent(window.location.search.substring(1)) || ""; document.write("Hello " + name); </script>

This two-line script uses window.location.search to obtain the portion of its own URL that begins with ?. It uses document.write() to add dynamically generated content to the document. This page is intended to be invoked with a URL like this:

http://www.example.com/greet.html?David

When used like this, it displays the text「Hello David」. But consider what happens when it is invoked with this URL:

http://www.example.com/greet.html?%3Cscript%3Ealert('David')%3C/script%3E

With this URL, the script dynamically generates another script (%3C and %3E are codes for angle brackets)! In this case, the injected script simply displays a dialog box, which is relatively benign. But consider this case:

http://siteA/greet.html?name=%3Cscript src=siteB/evil.js%3E%3C/script%3E

Cross-site scripting attacks are so called because more than one site is involved. Site B (or some other site C) includes a specially crafted link (like the one above) to site A that injects a script from site B. The script evil.js is hosted by the evil site B, but it is now embedded in site A, and it can do absolutely anything it wants with site A’s content. It might deface the page or cause it to malfunction (such as by initiating one of the denial-of-service attacks described in the next section). This would be bad for site A’s customer relations. More dangerously, the malicious script can read cookies stored by site A (perhaps account numbers or other personally identifying information) and send that data back to site B. The injected script can even track the user’s keystrokes and send that data back to site B.

In general, the way to prevent XSS attacks is to remove HTML tags from any untrusted data before using it to create dynamic document content. You can fix the greet.html file shown earlier by adding this line of code to remove the angle brackets around <script> tags:

name = name.replace(/</g, "&lt;").replace(/>/g, "&gt;");

The simple code above replaces all angle brackets in the string with their corresponding HTML entities, thereby escaping and deactivating any HTML tags in the string. IE8 defines a more nuanced toStatic HTML() method that removes <script> tags (and any other potentially executable content) without altering nonexecutable HTML. toStaticHTML() is not standardized, but it is straightforward to write your own HTML sanitizer function like this in core JavaScript.

HTML5 goes beyond content sanitation strategies and is defining a sandbox attribute for the <iframe> element. When implemented, this should allow the safe display of untrusted content, with scripts automatically disabled.

Cross-site scripting is a pernicious vulnerability whose roots go deep into the architecture of the Web. It is worth understanding this vulnerability in depth, but further discussion is beyond the scope of this book. There are many online resources to help you defend against cross-site scripting. One important primary source is the original CERT Advisory about this problem: http://www.cert.org/advisories/CA-2000-02.html.

Denial-of-Service Attacks

The same-origin policy and other security restrictions described here do a good job of preventing malicious code from damaging your data or compromising your privacy. They do not protect against brute-force denial-of-service attacks, however. If you visit a malicious website with JavaScript enabled, that site can tie up your browser with an infinite loop of alert() dialog boxes or can slow down your CPU with an infinite loop or a meaningless computation.

Some browsers detect repeated dialog boxes and long-running scripts and give the user the option to stop them. But malicious code can use methods such as setInterval() to load the CPU and can also attack your system by allocating lots of memory. There is no general way that web browsers can prevent this kind of ham-handed attack. In practice, this is not a common problem on the Web since no one returns to a site that engages in this kind of scripting abuse!

Client-Side Frameworks

Many web developers find it useful to build their web applications on top of a client-side framework library. These libraries are「frameworks」in the sense that they build a new higher-level API for client-side programming on top of the standard and proprietary APIs offered by web browsers: once you adopt a framework, your code needs to be written to use the APIs defined by that framework. The obvious benefit of using a framework is that it is a higher-level API that allows you to do more with less code. A well-written framework will also address many of the compatibility, security, and accessibility issues described above.

This book documents jQuery, one of the most popular frameworks, in Chapter 19. If you decide to adopt jQuery for your projects, you should still read the chapters leading up to Chapter 19; understanding the low-level APIs will make you a better web developer, even if you rarely need to use those APIs directly.

There are many JavaScript frameworks other than jQuery—many more than I can list here. Some of the best known and most widely used open source frameworks include:

Prototype

The Prototype library (http://prototypejs.org) focuses on DOM and Ajax utilities, like jQuery does, and adds quite a few core-language utilities as well. The Scriptaculous library (http://script.aculo.us/) can be added on for animations and visual effects.

Dojo

Dojo (http://dojotoolkit.org) is a large framework that advertises its「incredible depth.」It includes an extensive set of UI widgets, a package system, a data abstraction layer, and more.

YUI

YUI (http://developer.yahoo.com/yui/) is the in-house library of Yahoo!, and it is used on their home page. Like Dojo, it is a large, all-encompassing library with language utilities, DOM utilities, UI widgets, and so on. There are actually two incompatible versions of YUI, known as YUI 2 and YUI 3.

Closure

The Closure library (http://code.google.com/closure/library/) is the client-side library that Google uses for Gmail, Google Docs, and other web applications. This library is intended to be used with the Closure compiler (http://code.google.com/closure/compiler/), which strips out unused library functions. Because unused code is stripped out before deployment, the designers of the Closure library did not need to keep the feature set compact, so Closure has a sprawling set of utilities.

GWT

GWT, the Google Web Toolkit (http://code.google.com/webtoolkit/), is a completely different kind of client-side framework. It defines a web application API in Java and provides a compiler to translate your Java programs into compatible client-side JavaScript. GWT is used in some of Google’s products, but it is not as widely used as their Closure library.

Chapter 14. The Window Object

Chapter 13 introduced the Window object and the central role it plays in client-side JavaScript: it is the global object for client-side JavaScript programs. This chapter covers the properties and methods of the Window object. These properties define a number of different APIs, only some of which are actually related to the browser windows for which the Window object was named. This chapter covers the following:

Timers shows how to use setTimeout() and setInterval() to register a function to be invoked at specified times in the future.

Browser Location and Navigation explains how to use the location property to obtain the URL of the currently displayed document and to load new documents.

Browsing History covers the history property, and shows how to move the browser backward and forward through its history.

Browser and Screen Information shows how to use the navigator property to obtain browser vendor and version information and how to use the screen property to query the size of the desktop.

Dialog Boxes shows how to display simple text dialogs with the alert(), confirm(), and prompt() methods and how to display HTML dialog boxes with showModalDialog().

Error Handling explains how you can register an onerror handler method to be invoked when uncaught JavaScript exceptions occur.

Document Elements As Window Properties explains that the IDs and names of HTML elements are used as properties of the Window object.

Multiple Windows and Frames is a long section that explains how to open and close browser windows and how to write JavaScript code that works with multiple windows and nested frames.

Timers

setTimeout() and setInterval() allow you to register a function to be invoked once or repeatedly after a specified amount of time has elapsed. These are important global functions of client-side JavaScript, and are therefore defined as methods of Window, but they are general-purpose functions and don’t really have anything to do with the window.

The setTimeout() method of the Window object schedules a function to run after a specified number of milliseconds elapses. setTimeout() returns a value that can be passed to clearTimeout() to cancel the execution of the scheduled function.

setInterval() is like setTimeout() except that the specified function is invoked repeatedly at intervals of the specified number of milliseconds:

setInterval(updateClock, 60000); // Call updateClock() every 60 seconds

Like setTimeout(), setInterval() returns a value that can be passed to clear Interval() to cancel any future invocations of the scheduled function.

Example 14-1 defines a utility function that waits a specified amount of time, invokes a function repeatedly, and then cancels the invocations after another specified amount of time. It demonstrates setTimeout(), setInterval(), and clearInterval().

Example 14-1. A timer utility function

/* * Schedule an invocation or invocations of f() in the future. * Wait start milliseconds, then call f() every interval milliseconds, * stopping after a total of start+end milliseconds. * If interval is specified but end is omitted, then never stop invoking f. * If interval and end are omitted, then just invoke f once after start ms. * If only f is specified, behave as if start was 0. * Note that the call to invoke() does not block: it returns right away. */ function invoke(f, start, interval, end) { if (!start) start = 0; // Default to 0 ms if (arguments.length <= 2) // Single-invocation case setTimeout(f, start); // Single invocation after start ms. else { // Multiple invocation case setTimeout(repeat, start); // Repetitions begin in start ms function repeat() { // Invoked by the timeout above var h = setInterval(f, interval); // Invoke f every interval ms. // And stop invoking after end ms, if end is defined if (end) setTimeout(function() { clearInterval(h); }, end); } } }

For historical reasons, you can pass a string as the first argument to setTimeout() and setInterval(). If you do this, the string will be evaluated (as with eval()) after the specified timeout or interval. The HTML5 specification (and all browsers except IE) allow additional arguments to setTimeout() and setInterval() after the first two. Any such arguments are passed to the function that is invoked. If portability with IE is required, however, you shouldn’t use this feature.

If you call setTimeout() with a time of 0 ms, the function you specify is not invoked right away. Instead, it is placed on a queue to be invoked「as soon as possible」after any currently pending event handlers finish running.

Browser Location and Navigation

The location property of the Window object refers to a Location object, which represents the current URL of the document displayed in the window, and which also defines methods for making the window load a new document.

The location property of the Document object also refers to the Location object:

window.location === document.location // always true

The Document object also has a URL property, which is a static string that holds the URL of the document when it was first loaded. If you navigate to fragment identifiers (like「#table-of-contents」) within the document, the Location object is updated to reflect this, but the document.URL property remains unchanged.

Parsing URLs

The location property of a window is a reference to a Location object; it represents the current URL of the document being displayed in that window. The href property of the Location object is a string that contains the complete text of the URL. The toString() method of the Location object returns the value of the href property, so in contexts that will implicitly invoke toString(), you can just write location rather than location.href.

Other properties of this object—protocol, host, hostname, port, pathname, search, and hash—specify the various individual parts of the URL. They are known as「URL decomposition」properties, and they are also supported by Link objects (created by <a> and <area> elements in HTML documents). See the Location and Link entries in Part IV for further details.

The hash and search properties of the Location object are interesting ones. The hash property returns the「fragment identifier」portion of the URL, if there is one: a hash mark (#) followed by an element ID. The search property is similar. It returns the portion of the URL that starts with a question mark: often some sort of query string. In general, this portion of a URL is used to parameterize the URL and provides a way to embed arguments in it. While these arguments are usually intended for scripts run on a server, there is no reason why they cannot also be used in JavaScript-enabled pages. Example 14-2 shows the definition of a general-purpose urlArgs() function you can use to extract arguments from the search property of a URL. The example uses decode URI Component() , which is a global function defined by client-side JavaScript. (See Global in Part III for details.)

Example 14-2. Extracting arguments from the search string of a URL

/* * This function parses ampersand-separated name=value argument pairs from * the query string of the URL. It stores the name=value pairs in * properties of an object and returns that object. Use it like this: * * var args = urlArgs(); // Parse args from URL * var q = args.q || ""; // Use argument, if defined, or a default value * var n = args.n ? parseInt(args.n) : 10; */ function urlArgs() { var args = {}; // Start with an empty object var query = location.search.substring(1); // Get query string, minus '?' var pairs = query.split("&"); // Split at ampersands for(var i = 0; i < pairs.length; i++) { // For each fragment var pos = pairs[i].indexOf('='); // Look for "name=value" if (pos == -1) continue; // If not found, skip it var name = pairs[i].substring(0,pos); // Extract the name var value = pairs[i].substring(pos+1); // Extract the value value = decodeURIComponent(value); // Decode the value args[name] = value; // Store as a property } return args; // Return the parsed arguments }

Loading New Documents

The assign() method of the Location object makes the window load and display the document at the URL you specify. The replace() method is similar, but it removes the current document from the browsing history before loading the new document. When a script unconditionally loads a new document, the replace() method is often a better choice than assign(). Otherwise, the Back button would take the browser back to the original document, and the same script would again load the new document. You might use location.replace() to load a static HTML version of your web page if you detected that the user’s browser did not have the features required to display the full-featured version:

// If the browser does not support the XMLHttpRequest object // redirect to a static page that does not require it. if (!XMLHttpRequest) location.replace("staticpage.html");

Notice that the URL passed to replace() is a relative one. Relative URLs are interpreted relative to the page in which they appear, just as they would be if they were used in a hyperlink.

In addition to the assign() and replace() methods, the Location object also defines reload(), which makes the browser reload the document.

A more traditional way to make the browser navigate to a new page is to simply assign the new URL directly to the location property:

location = "http://www.oreilly.com"; // Go buy some books!

You can also assign relative URLs to location. They are resolved against the current URL:

location = "page2.html"; // Load the next page

A bare fragment identifier is a special kind of relative URL that does not cause the browser to load a new document but simply scroll to display a new section of the document. The identifier #top is a special case: if no document element has the ID「top」, it makes the browser jump to the start of the document:

location = "#top"; // Jump to the top of the document

The URL decomposition properties of the Location object are writable, and setting them changes the location URL and also causes the browser to load a new document (or, in the case of the hash property, to navigate within the current document):

location.search = "?page=" + (pagenum+1); // load the next page

Browsing History

The history property of the Window object refers to the History object for the window. The History object models the browsing history of a window as a list of documents and document states. The length property of the History object specifies the number of elements in the browsing history list, but for security reasons scripts are not allowed to access the stored URLs. (If they could, any scripts could snoop through your browsing history.)

The History object has back() and forward() methods that behave like the browser’s Back and Forward buttons do: they make the browser go backward or forward one step in its browsing history. A third method, go(), takes an integer argument and can skip any number of pages forward (for positive arguments) or backward (for negative arguments) in the history list:

history.go(-2); // Go back 2, like clicking the Back button twice

If a window contains child windows (such as <iframe> elements—see Relationships Between Frames), the browsing histories of the child windows are chronologically interleaved with the history of the main window. This means that calling history.back() (for example) on the main window may cause one of the child windows to navigate back to a previously displayed document but leave the main window in its current state.

Modern web applications can dynamically alter their own content without loading a new document (see Chapters 15 and 18, for example). Applications that do this may want to allow the user to use the Back and Forward buttons to navigate between these dynamically created application states. HTML5 standardizes two techniques for doing this, and they are described in History Management.

History management before HTML5 is a more complex problem. An application that manages its own history must be able to create a new entry in the window browsing history, associate its state information with that history entry, determine when the user has used the Back button to move to a different history entry, get the state information associated with that entry, and re-create the previous state of the application. One approach uses a hidden <iframe> to save state information and create entries in the browser’s history. In order to create a new history entry, you dynamically write a new document into this hidden frame using the open() and write() methods of the Document object (see The document.write() Method). The document content should include whatever state information is required to re-create the application state. When the user clicks the Back button, the content of the hidden frame will change. Before HTML5, no events are generated to notify you of this change, however, so in order to detect that the user has clicked Back you might use setInterval() (Timers) to check the hidden frame two or three times a second to see if it has changed.

In practice, developers who need this kind of pre-HTML5 history management usually rely on a prebuilt solution. Many JavaScript frameworks include one. There is a history plug-in for jQuery, for example, and standalone history management libraries are also available. RSH (Really Simple History) is one popular example. You can find it at http://code.google.com/p/reallysimplehistory/. History Management explains how to do history management with HTML5.

Browser and Screen Information

Scripts sometimes need to obtain information about the web browser in which they are running or the desktop on which the browser appears. This section describes the navigator and screen properties of the Window object. Those properties refer to Navigator and Screen objects, respectively, and these objects provide information that allows a script to customize its behavior based on its environment.

The Navigator Object

The navigator property of a Window object refers to a Navigator object that contains browser vendor and version number information. The Navigator object is named after the early Navigator browser from Netscape, but it is also supported by all other browsers. (IE also supports clientInformation as a vendor-neutral synonym for navigator. Unfortunately, other browsers have not adopted this more sensibly named property.)

In the past, the Navigator object was commonly used by scripts to determine if they were running in Internet Explorer or Netscape. This「browser-sniffing」approach is problematic because it requires constant tweaking as new browsers and new versions of existing browsers are introduced. Today, feature testing (see Feature Testing) is preferred: rather than making assumptions about particular browser versions and their features, you simply test for the feature (i.e., the method or property) you need.

Browser sniffing is sometimes still valuable, however, such as when you need to work around a specific bug that exists in a specific version of a specific browser. The Navigator object has four properties that provide information about the browser that is running, and you can use these properties for browser sniffing:

appName

The full name of the web browser. In IE, this is「Microsoft Internet Explorer」. In Firefox, this property is「Netscape」. For compatibility with existing browser-sniffing code, other browsers often report the name「Netscape」as well.

appVersion

This property typically begins with a number and follows that with a detailed string that contains browser vendor and version information. The number at the start of this string is often 4.0 or 5.0 to indicate generic compatibility with fourth- and fifth-generation browsers. There is no standard format for the appVersion string, so parsing it in a browser-independent way isn’t possible.

userAgent

The string that the browser sends in its USER-AGENT HTTP header. This property typically contains all the information in appVersion and may contain additional details as well. Like appVersion, there is no standard format. Since this property contains the most information, browser-sniffing code typically uses it.

platform

A string that identifies the operating system (and possibly the hardware) on which the browser is running.

The complexity of the Navigator properties demonstrates the futility of the browser-sniffing approach to client-side compatibility. In the early days of the Web, lots of browser-specific code was written that tested properties like navigator.appName. As new browsers were written, vendors discovered that in order to correctly display existing websites, they had to set the appName property to「Netscape」. A similar process caused the number at the start of the appVersion to lose meaning, and today browser-sniffing code must rely on the navigator.userAgent string and is more complicated than it once was. Example 14-3 shows how to use regular expressions (from jQuery) to extract the browser name and version number from navigator.userAgent.

Example 14-3. Browser sniffing using navigator.userAgent

// Define browser.name and browser.version for client sniffing, using code // derived from jQuery 1.4.1. Both the name and number are strings, and both // may differ from the public browser name and version. Detected names are: // // "webkit": Safari or Chrome; version is WebKit build number // "opera": the Opera browser; version is the public version number // "mozilla": Firefox or other gecko-based browsers; version is Gecko version // "msie": IE; version is public version number // // Firefox 3.6, for example, returns: { name: "mozilla", version: "1.9.2" }. var browser = (function() { var s = navigator.userAgent.toLowerCase(); var match = /(webkit)[ \/]([\w.]+)/.exec(s) || 	 /(opera)(?:.*version)?[ \/]([\w.]+)/.exec(s) || 	 /(msie) ([\w.]+)/.exec(s) || 	 !/compatible/.test(s) && /(mozilla)(?:.*? rv:([\w.]+))?/.exec(s) || 	 []; return { name: match[1] || "", version: match[2] || "0" }; }());

In addition to its browser vendor and version information properties, the Navigator object has some miscellaneous properties and methods. The standardized and widely implemented nonstandard properties include:

onLine

The navigator.onLine property (if it exists) specifies whether the browser is currently connected to the network. Applications may want to save state locally (using techniques from Chapter 20) while they are offline.

geolocation

A Geolocation object that defines an API for determining the user’s geographical location. See Geolocation for details.

javaEnabled()

A nonstandard method that should return true if the browser can run Java applets.

cookiesEnabled()

A nonstandard method that should return true if the browser can store persistent cookies. May not return the correct value if cookies are configured on a site-by-site basis.

The Screen Object

The screen property of a Window object refers to a Screen object that provides information about the size of the user’s display and the number of colors available on it. The width and height properties specify the size of the display in pixels. The availWidth and availHeight properties specify the display size that is actually available; they exclude the space required by features such as a desktop taskbar. The colorDepth property specifies the bits-per-pixel value of the screen. Typical values are 16, 24, and 32.

The window.screen property and the Screen object to which it refers are both nonstandard but widely implemented. You might use the Screen object to determine whether your web app is running in a small form factor device such as a netbook computer. If screen space is limited, you might choose to use smaller fonts and images, for example.

Dialog Boxes

The Window object provides three methods for displaying simple dialog boxes to the user. alert() displays a message to the user and waits for the user to dismiss the dialog. confirm() displays a message, waits for the user to click an OK or Cancel button and returns a boolean value. And prompt() displays a message, waits for the user to enter a string, and returns that string. The following code uses all three methods:

do { var name = prompt("What is your name?"); // Get a string var correct = confirm("You entered '" + name + "'.\n" + // Get a boolean "Click Okay to proceed or Cancel to re-enter."); } while(!correct) alert("Hello, " + name); // Display a plain message

Although the alert(), confirm(), and prompt() methods are very easy to use, good design dictates that you use them sparingly, if at all. Dialog boxes like these are not a common feature on the Web, and most users will find the dialog boxes produced by these methods disruptive to their browsing experience. The only common use for these methods today is debugging: JavaScript programmers sometimes insert alert() methods in code that is not working in an attempt to diagnose the problem.

Note that the messages displayed by alert(), confirm(), and prompt() are plain text, not HTML-formatted text. You can format these dialog boxes only with spaces, newlines, and punctuation characters.

The confirm() and prompt() methods block—that is, these methods do not return until the user dismisses the dialog boxes they display. This means that when you pop up one of these boxes, your code stops running, and the currently loading document, if any, stops loading until the user responds with the requested input. In most browsers, the alert() method also blocks and waits for the user to dismiss the dialog box, but this is not required. For complete details on these methods, see Window.alert, Window.confirm, and Window.prompt in Part IV.

In addition to the Window methods alert(), confirm(), and prompt(), a more complicated method, showModalDialog(), displays a modal dialog box containing HTML-formatted content and allows arguments to be passed to, and a value returned from, the dialog. showModalDialog() displays a modal dialog in a browser window of its own. The first argument is the URL that specifies the HTML content of the dialog box. The second argument is an arbitrary value (arrays and objects are allowed) that will be made available to scripts in the dialog as the value of the window.dialogArguments property. The third argument is a nonstandard list of semicolon-separated name=value pairs that, if supported, may configure the size or other attributes of the dialog. Use「dialogwidth」and「dialogheight」to set the size of the dialog window, and use「resizable=yes」to allow the user to resize the window.

The window displayed by this method is modal, and the call to showModalDialog() does not return until the window is closed. When the window closes, the value of the window. returnValue property becomes the return value of the method call. The HTML content of the dialog must typically include an OK button that sets returnValue, if desired, and calls window.close() (see Closing windows).

Example 14-4 is an HTML file suitable for use with showModalDialog(). The comment at the top of the code includes a sample invocation of showModalDialog(), and Figure 14-1 shows the dialog created by the sample call. Note that most of the text that appears in the dialog comes from the second argument to showModalDialog(), rather than being hard-coded in the HTML.

Figure 14-1. An HTML dialog displayed with showModalDialog()

Example 14-4. An HTML file for use with showModalDialog()

<!-- This is not a stand-alone HTML file. It must be invoked by showModalDialog(). It expects window.dialogArguments to be an array of strings. The first element of the array is displayed at the top of the dialog. Each remaining element is a label for a single-line text input field. Returns an array of input field values when the user clicks Okay. Use this file with code like this: var p = showModalDialog("multiprompt.html", ["Enter 3D point coordinates", "x", "y", "z"], "dialogwidth:400; dialogheight:300; resizable:yes"); --> <form> <fieldset id="fields"></fieldset> <!-- Dialog body filled in by script below --> <div style="text-align:center"> <!-- Buttons to dismiss the dialog --> <button onclick="okay()">Okay</button> <!-- Set return value and close --> <button onclick="cancel()">Cancel</button> <!-- Close with no return value --> </div> <script> // Create the HTML for the dialog body and display it in the fieldset var args = dialogArguments; var text = "<legend>" + args[0] + "</legend>"; for(var i = 1; i < args.length; i++) text += "<label>" + args[i] + ": <input id='f" + i + "'></label><br>"; document.getElementById("fields").innerHTML = text; // Close the dialog without setting a return value function cancel() { window.close(); } // Read the input field values and set a return value, then close function okay() { window.returnValue = []; // Return an array for(var i = 1; i < args.length; i++) // Set elements from input fields window.returnValue[i-1] = document.getElementById("f" + i).value; window.close(); // Close the dialog. This makes showModalDialog() return. } </script> </form>

Error Handling

The onerror property of a Window object is an event handler that is invoked when an uncaught exception propagates all the way up the call stack and an error message is about to be displayed in the browser’s JavaScript console. If you assign a function to this property, the function is invoked whenever a JavaScript error occurs in that window: the function you assign becomes an error handler for the window.

For historical reasons, the onerror event handler of the Window object is invoked with three string arguments rather than with the one event object that is normally passed. (Other client-side objects have onerror handlers to handle different error conditions, but these are all regular event handlers that are passed a single event object.) The first argument to window.onerror is a message describing the error. The second argument is a string that contains the URL of the JavaScript code that caused the error. The third argument is the line number within the document where the error occurred.

In addition to those three arguments, the return value of the onerror handler is significant. If the onerror handler returns false, it tells the browser that the handler has handled the error and that no further action is necessary—in other words, the browser should not display its own error message. Unfortunately, for historical reasons, an error handler in Firefox must return true to indicate that it has handled the error.

The onerror handler is a holdover from the early days of JavaScript, when the core language did not include the try/catch exception handling statement. It is rarely used in modern code. During development, however, you might define an error handler like this to explicitly notify you when an error occurs:

// Display error messages in a dialog box, but never more than 3 window.onerror = function(msg, url, line) { if (onerror.num++ < onerror.max) { alert("ERROR: " + msg + "\n" + url + ":" + line); return true; } } onerror.max = 3; onerror.num = 0;

Document Elements As Window Properties

If you name an element in your HTML document using the id attribute, and if the Window object does not already have a property by that name, the Window object is given a nonenumerable property whose name is the value of the id attribute and whose name is the HTMLElement object that represents that document element.

As we’ve already noted, the Window object serves as the global object at the top of the scope chain in client-side JavaScript, so this means that the id attributes you use in your HTML documents become global variables accessible to your scripts. If your document includes the element <button id="okay"/>, you can refer to that element using the global variable okay.

There is an important caveat, however: this doesn’t happen if the Window object already has a property by that name. Elements with the ids「history」,「location,」or「navigator」, for example, won’t appear as global variables, because those IDs are already in use. Similarly, if your HTML document includes an element whose id is「x」and you also declare and assign a value to the global variable x in your code, the explicitly declared variable will hide the implicit element variable. If the variable is declared in a script that appears before the named element, its existence will prevent the element from getting a window property of its own. And if the variable is declared in a script that appears after the named element, your explicit assignment to the variable overwrites the implicit value of the property.

In Selecting Document Elements, you’ll learn that you can look up document elements by the value of their HTML id attribute using the document.getElementById() method. Consider this example:

var ui = ["input","prompt","heading"]; // An array of element ids ui.forEach(function(id) { // For each id look up the element ui[id] = document.getElementById(id); // and store it in a property });

After running this code, ui.input, ui.prompt, and ui.heading refer to document elements. A script could use the global variables input and heading instead of ui.input and ui.heading. But recall from Dialog Boxes that the Window object has a method named prompt(), so a script cannot use the global variable prompt instead of ui.prompt.

The implicit use of element IDs as global variables is a historical quirk of web browser evolution. It is required for backward compatibility with existing web pages, but its use is not recommended—any time a browser vendor defines a new property of the Window object it breaks any code that uses an implicit definition of that property name. Instead, use document.getElementById() to look up elements explicitly. The use of this method seems less onerous if we give it a simpler name:

var $ = function(id) { return document.getElementById(id); }; ui.prompt = $("prompt");

Many client-side libraries define a $ function that looks up elements by ID like this. (We’ll see in Chapter 19 that jQuery’s $ function is a general-purpose element selection method that returns one or more elements based on their ID, tag name, class attribute, or other criteria.)

Any HTML element with an id attribute will become the value of a global variable, assuming the ID is not already used by the Window object. The following HTML elements also behave this way when given a name attribute:

<a> <applet> <area> <embed> <form> <frame> <frameset> <iframe> <img> <object>

The id element is required to be unique within a document: two elements cannot have the same id. This is not true for the name attribute, however. If more than one of the elements above has the same name attribute (or if one element has a name attribute, and another element has an id with the same value), the implicit global variable with that name will refer to an array-like object that holds each of the named elements.

There is a special case for <iframe> elements with a name or id attribute. The implicitly created variable for these elements refers not to the Element object that represents the element itself, but to the Window object that represents the nested browser frame created by the <iframe> element. We’ll talk about this again in Relationships Between Frames.

Multiple Windows and Frames

A single web browser window on your desktop may contain several tabs. Each tab is an independent browsing context. Each has its own Window object, and each is isolated from all the others. The scripts running in one tab usually have no way of even knowing that the other tabs exist, much less of interacting with their Window objects or manipulating their document content. If you use a web browser that does not support tabs, or if you have tabs turned off, you may have many web browser windows open on your desktop at one time. As with tabs, each desktop window has its own Window object, and each is usually independent of and isolated from all of the others.

But windows are not always isolated from one another. A script in one window or tab can open new windows or tabs, and when a script does this, the windows can interact with one another and with one another’s documents (subject to the constraints of the same-origin policy of The Same-Origin Policy). Opening and Closing Windows has more about opening and closing windows.

HTML documents may contain nested documents using an <iframe> element. An <iframe> creates a nested browsing context represented by a Window object of its own. The deprecated <frameset> and <frame> elements also create nested browsing contexts, and each <frame> is represented by a Window. Client-side JavaScript makes very little distinction between windows, tabs, iframes, and frames: they are all browsing contexts, and to JavaScript, they are all Window objects. Nested browsing contexts are not isolated from one another the way independent tabs usually are. A script running in one frame can always see its ancestor and descendant frames, though the same-origin policy may prevent the script from inspecting the documents in those frames. Nested frames are the topic of Relationships Between Frames.

Since the Window is the global object of client-side JavaScript, each window or frame has a separate JavaScript execution context. Nevertheless, JavaScript code in one window can, subject to same-origin constraints, use the objects, properties, and methods defined in other windows. This is discussed in more detail in JavaScript in Interacting Windows. When the same-origin policy prevents the scripts in two distinct windows from interacting directly, HTML5 provides an event-based message passing API for indirect communication. You can read about it in Cross-Origin Messaging.

Opening and Closing Windows

You can open a new web browser window (or tab; this is usually a browser configuration option) with the open() method of the Window object. Window.open() loads a specified URL into a new or existing window and returns the Window object that represents that window. It takes four optional arguments:

The first argument to open() is the URL of the document to display in the new window. If this argument is omitted (or is the empty string), the special blank-page URL about:blank is used.

The second argument to open() is a string that specifies a window name. If a window by that name already exists (and if the script is allowed to navigate that window), that existing window is used. Otherwise a new window is created and is assigned the specified name. If this argument is omitted, the special name「_blank」is used: it opens a new, unnamed window.

Note that scripts cannot simply guess window names and take over the windows in use by other web applications: they can only name existing windows that they are「allowed to navigate」(the term is from the HTML5 specification). Loosely, a script can specify an existing window by name only if that window contains a document from the same origin or if the script opened that window (or recursively opened a window that opened that window). Also, if one window is a frame nested within the other, a script in either one can navigate the other. In this case, the reserved names「_top」(the top-level ancestor window) and「_parent」(the immediate parent window) can be useful.

Window Names

The name of a window is important because it allows the open() method to refer to existing windows, and also because it can be used as the value of the HTML target attribute on <a> and <form> elements to indicate that the linked document (or the result of submitting the form) should be displayed in the named window. The target attribute on these elements can also be set to「_blank」,「_parent」, or「_top」to direct the linked document into a new blank window, the parent window or frame, or the top-level window.

The name property of a Window object holds its name, if it has one. This property is writable, and scripts can set it as desired. If a name (other than「_blank」) is passed to Window.open(), the window created by that call will have the specified name as the initial value of its name property. If an <iframe> element has a name attribute, the Window object that represents that frame will use that name attribute as the initial value of the name property.

The third optional argument to open() is a comma-separated list of size and features attributes for the new window to be opened. If you omit this argument, the new window is given a default size and has a full set of UI components: a menu bar, status line, toolbar, and so on. In tabbed browsers, this usually results in the creation of a new tab. On the other hand, if you specify this argument, you can explicitly specify the size of the window and the set of features it includes. (Explicitly specifying a size is likely to result in the creation of a new window rather than a tab.) For example, to open a small but resizable browser window with a status bar but no menu bar, toolbar, or location bar, you might write:

var w = window.open("smallwin.html", "smallwin", "width=400,height=350,status=yes,resizable=yes");

This third argument is nonstandard and the HTML5 specification insists that browsers be able to ignore it. See Window.open() in the reference section for more details on what you can specify in this argument. Note that when you specify this third argument, any features you do not explicitly specify are omitted. For various security reasons, browsers include restrictions on the features you can specify. You are typically not allowed to specify a window that is too small or is positioned offscreen, for example, and some browsers will not allow you to create a window without a status line.

The fourth argument to open() is useful only when the second argument names an existing window. This fourth argument is a boolean value that indicates whether the URL specified as the first argument should replace the current entry in the window’s browsing history (true) or create a new entry in the window’s browsing history (false). Omitting this argument is the same as passing false.

The return value of the open() method is the Window object that represents the named or newly created window. You can use this Window object in your JavaScript code to refer to the new window, just as you use the implicit Window object window to refer to the window within which your code is running:

var w = window.open(); // Open a new, blank window. w.alert("About to visit http://example.com"); // Call its alert() method w.location = "http://example.com"; // Set its location property

In windows created with the window.open() method, the opener property refers back to the Window object of the script that opened it. In other windows, opener is null:

w.opener !== null; // True for any window w created by open() w.open().opener === w; // True for any window w

Window.open() is the method by which advertisements are made to「pop up」or「pop under」while you browse the Web. Because of this flood of annoying pop ups, most web browsers have now instituted some kind of pop up–blocking system. Typically, calls to the open() method are successful only if they occur in response to a user action such as clicking on a button or a link. JavaScript code that tries to open a pop-up window when the browser first loads (or unloads) a page will usually fail. Testing the lines of code shown above by pasting them into the JavaScript console of your browser may also fail for the same reason.

Closing windows

Just as the open() method opens a new window, the close() method closes one. If you create a Window object w, you can close it with:

w.close();

JavaScript code running within that window itself can close it with:

window.close();

Note the explicit use of the window identifier to distinguish the close() method of the Window object from the close() method of the Document object—this is important if you’re calling close() from an event handler.

Most browsers allow you to automatically close only those windows that your own JavaScript code has created. If you attempt to close any other window, the request either fails or the user is presented with a dialog box that asks him to allow (or cancel) that request to close the window. The close() method of a Window object that represents a frame rather than a top-level window or tab does nothing: it is not possible to close a frame (instead you’d delete the <iframe> from its containing document).

A Window object continues to exist after the window it represents has been closed. A window that has been closed will have a closed property of true, its document will be null, and its methods will typically no longer work.

