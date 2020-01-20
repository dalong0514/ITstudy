Uint8Array

One byte per array element, interpreted as an unsigned integer.

Uint16Array

Two bytes per array element, interpreted as an unsigned integer, using platform byte order.

Uint32Array

Four bytes per array element, interpreted as an unsigned integer, using platform byte order.

Float32Array

Four bytes per array element, interpreted as a floating-point number, using platform byte order.

Float64Array

Eight bytes per array element, interpreted as a floating-point number, using platform byte order.

As their name implies, these are array-like objects, and you can get and set element values using normal square-bracket array notation. Note, however, that objects of these types always have a fixed length.

As noted in the descriptions above, the TypedArray classes use the default byte ordering of the underlying platform. See DataView for an ArrayBuffer view that allows explicit control over byte order.

Constructor

new TypedArray(unsigned long length) new TypedArray(TypedArray array) new TypedArray(type[] array) new TypedArray(ArrayBuffer buffer,[unsigned long byteOffset],[unsigned long length])

Each of the eight kinds of TypedArray has a constructor that can be invoked in the four ways shown above. The constructors work as follows:

If the constructor is called with a single numeric argument, it creates a new typed array with the specified number of elements, and initializes each element to 0.

If passed a single typed array object, the constructor creates a new typed array with the same number of arguments as the argument array, and then copies the elements of the argument array to the newly created array. The type of the argument array need not be the same as the type of the array being created.

If passed a single array (a true JavaScript array), the constructor creates a new typed array with the same number of arguments and then copies element values from the argument array into the new array.

Finally, if passed an ArrayBuffer object, along with optional offset and length arguments, the constructor creates a new typed array that is a view of the specified region of the specified ArrayBuffer. The length of the new TypedArray depends on the ArrayBuffer region and on the element size of the typed array.

Constants

long BYTES_PER_ELEMENT

The number of bytes that each element of this array occupies in the underlying ArrayBuffer. This constant will have the value 1, 2, 4, or 8, depending on what kind of TypedArray is in use.

Properties

readonly unsigned long length

The number of elements in the array. TypedArrays have fixed size, and the value of this property never changes. Note that this property is not, in general, the same as the byteLength property inherited from ArrayBufferView.

Methods

void set(TypedArray array, [unsigned long offset])

Copy elements of array into this typed array, starting at index offset.

void set(number[] array, [unsigned long offset])

This version of set() is like the one above, but it uses a true JavaScript array rather than a typed array.

TypedArray subarray(long start, long end)

Return a new TypedArray that uses the same underlying ArrayBuffer as this one does. The first element of the returned array is element start of this array. And the last element of the returned array is element end–1 of this array. Negative values of start and end are interpreted as offsets from the end of this array rather than the beginning.

Name

URL — Blob URL methods

Synopsis

The URL property of the Window object refers to this URL object. In the future, this object may become a constructor for a URL parsing and manipulation utility class. At the time of this writing, however, it simply serves as a namespace for the two Blob URL functions described below. See Blobs and Blob URLs for more on Blobs and Blob URLs.

The URL object is new at the time of this writing and the API is not yet stable. You may need to use it with a vendor-specific prefix: webkitURL, for example.

Functions

string createObjectURL(Blob blob)

Return a Blob URL for the specified blob. HTTP GET requests for that URL will return the contents of blob.

void revokeObjectURL(string url)

Revoke the specified Blob url, so that it is no longer associated with any Blob and can no longer be loaded.

Name

Video — an HTML <video> element

Inherits from

Node, Element, MediaElement

Synopsis

A Video object represents an HTML <video> element. <video> and <audio> elements are very similar and their common properties and methods are documented in MediaElement. This page documents a handful of additional properties that are specific to Video objects.

Properties

DOMSettableTokenList audio

This property specifies audio options for the video. The options are specified as a space-separated list of tokens on the HTML audio attribute, and the set is mirrored in JavaScript as a DOMSettableTokenList. At the time of this writing, however, the HTML5 standard defines only one legal token (「muted」), and you can treat this property as a string.

unsigned long height

The onscreen height of the <video> element, in CSS pixels. Mirrors the HTML height attribute.

string poster

The URL of an image to be displayed as a「poster frame」before the video begins playing. Mirrors the HTML poster attribute.

readonly unsigned long videoHeight

readonly unsigned long videoWidth

These properties return the intrinsic width and height of the video (i.e., the size of its frames) in CSS pixels. These properties will be zero until the <video> element has loaded the video metadata (while readyState is still HAVE_NOTHING and the loadedmetadata event has not been dispatched).

unsigned long width

The desired onscreen width of the <video> element, in CSS pixels. Mirrors the HTML width attribute.

Name

WebSocket — a bidirectional socket-like network connection

Inherits from

EventTarget

Synopsis

A WebSocket represents a long-lived, bidirectional, socket-like network connection to a server that supports the WebSocket protocol. This is a fundamentally different networking model than the request/response model of HTTP. Create a new connection with the WebSocket() constructor. Use send() to send textual messages to the server, and register a handler for message events to receive messages from the server. See Web Sockets for further details.

WebSockets are a new Web API and, at the time of this writing, are not supported by all browsers.

Constructor

new WebSocket(string url, [string[] protocols])

The WebSocket() constructor creates a new WebSocket object and begins the (asynchronous) process of establishing a connection to a WebSocket server. The url argument specifies the server to connect to and must be an absolute URL that uses the ws:// or wss:// URL scheme. The protocols argument is an array of subprotocol names. If the argument is specified, it is the client’s way of telling the server which communication protocols or which protocol versions it is able to「speak.」The server must choose one and inform the client as part of the connection process. protocols may also be specified as a single string instead of an array: in this case, it is treated as an array of length 1.

Constants

These constants are the values of the readyState property.

unsigned short CONNECTING = 0

The connection process is underway.

unsigned short OPEN = 1

The WebSocket is connected to the server; messages can be sent and received.

unsigned short CLOSING = 2

The connection is closing.

unsigned short CLOSED = 3

The connection has closed.

Properties

readonly unsigned long bufferedAmount

The number of characters of text that have been passed to send() but not yet actually sent. If you need to send large amounts of data, you can use this property to ensure that you are not sending messages faster than they can be transmitted.

readonly string protocol

If an array of subprotocols was passed to the WebSocket() constructor, this property holds the one chosen by the server. Note that when the WebSocket is first created, the connection is not established and the server’s choice is not known. So this property starts as the empty string. If you passed protocols to the constructor, this property will change to reflect the server’s choice of subprotocol when the open event is triggered.

readonly unsigned short readyState

The current state of the WebSocket connection. This property holds one of the constant values listed above.

readonly string url

This property holds the URL that was passed to the WebSocket() constructor.

Methods

void close()

If the connection is not already closed or closing, this method begins the process of closing it, setting readyState to CLOSING. Message events may continue to be fired even after close() is called, until readyState changes to CLOSED and the close event is fired.

void send(string data)

This method sends the specified data to the server at the other end of the WebSocket connection. This method throws an exception if called before the open event has been triggered, while readyState is still CONNECTING. The WebSocket protocol supports binary data, but at the time of this writing, the WebSocket API only allows strings to be sent and received.

Event Handlers

Network communication is inherently asynchronous, and like XMLHttpRequest, the WebSocket API is event-based. WebSocket defines four event handler registration properties, and also implements EventTarget, so you can also register event handlers using the EventTarget methods. The events described below are all fired at the WebSocket object. None of them bubble, and none have a default action to cancel. Note, however, that they do have different event objects associated with them.

onclose

A close event is triggered when the WebSocket connection closes (and readyState changes to CLOSED). The associated event object is a CloseEvent, which specifies whether the connection closed cleanly or not.

onerror

An error event is triggered when a network or WebSocket protocol error occurs. The associated event object is a simple Event.

onmessage

When the server sends data through the WebSocket, the WebSocket fires a message event, with an associated MessageEvent object whose data property refers to the received message.

onopen

The WebSocket() constructor returns before the connection to the specified url is established. When the connection handshake completes and the WebSocket is ready to send and receive data, an open event is fired. The associated event object is a simple Event.

Name

Window — a web browser window, tab, or frame

Inherits from

EventTarget

Synopsis

The Window object represents a browser window, tab, or frame. It is documented in detail in Chapter 14. In client-side JavaScript, the Window serves as the「global object,」and all expressions are evaluated in the context of the current Window object. This means that no special syntax is required to refer to the current window, and you can use the properties of that window object as if they were global variables. For example, you can write document rather than window.document. Similarly, you can use the methods of the current window object as if they were functions: e.g., alert() instead of window.alert().

Some of the properties and methods of this object actually query or manipulate the browser window in some way. Others are defined here simply because this is the global object. In addition to the properties and methods listed here, the Window object also implements all the global properties and functions defined by core JavaScript. See Global in Part III for details.

Web browsers fire many kinds of events at windows. This means that the Window object defines quite a few event handlers, and that Window objects implement the methods defined by EventTarget.

The Window object has window and self properties that refer to the window object itself. You can use these to make the current window reference explicit rather than implicit.

A Window can contain other Window objects, typically in the form of <iframe> tags. Each Window is an array-like object of nested Window objects. Rather than indexing a Window object directly, however, you typically use its self-referential frames property as if it were the array-like object. The parent and top properties of a Window refer to the directly containing window and top-level ancestor window.

New top-level browser windows are created with the Window.open() method. When you call this method, save the return value of the open() call in a variable and use that variable to reference the new window. The opener property of the new window is a reference back to the window that opened it.

Properties

In addition to the properties listed here, document content displayed within the window causes new properties to come into existence. As explained in Document Elements As Window Properties, you can refer to an element within the document by using the value of the element’s id attribute as a property of the window (and since the window is the global object, its properties are global variables).

readonly ApplicationCache applicationCache

A reference to the ApplicationCache object. Cached and offline web apps can use this object to manage their cache updates.

readonly any dialogArguments

In Window objects created by the showModalDialog(), this property is the arguments value that was passed to showModalDialog(). In regular Window objects, this property does not exist. See Dialog Boxes for more information.

readonly Document document

The Document object that describes the content of this window (see Document for details).

readonly Event event [IE only]

In Internet Explorer, this property refers to the Event object that describes the most recent event. In IE8 and before, the event object is not always passed to the event handler and must sometimes be accessed through this property. See Chapter 17 for further details.

readonly Element frameElement

If this Window is within an <iframe>, this property refers to that IFrame element. For top-level windows, this property is null.

readonly Window frames

This property, like the self and window properties, refers to the Window object itself. Every Window object is an array-like object of the frames contained within it. Instead of writing w[0] to refer to the first frame within a window w, this property allows you to more clearly write w.frames[0].

readonly History history

The History object of this window. See History.

readonly long innerHeight

readonly long innerWidth

The height and width, in pixels, of the document display area of this window. These properties are not supported in IE8 and before. See Example 15-9 for an example.

readonly unsigned long length

The number of frames contained in this window. See frames.

readonly Storage localStorage

This property refers to a Storage object that provides client-side storage for name/value pairs. Data stored through localStorage is visible to and shared with any documents with the same origin, and persists until deleted by the user or by a script. See also sessionStorage and localStorage and sessionStorage.

readonly Location location

The Location object for this window. This object specifies the URL of the currently loaded document. Setting this property to a new URL string causes the browser to load and display the contents of that URL. See Location.

string name

The name of the window. The name is optionally specified when the window is created with the open() method or with the name attribute of a <frame> tag. The name of a window can be used as the value of a target attribute of an <a> or <form> tag. Using the target attribute in this way specifies that the hyperlinked document or the results of form submission should be displayed in the named window or frame.

readonly Navigator navigator

A reference to the Navigator object, which provides version and configuration information about the web browser. See Navigator.

readonly Window opener

A read/write reference to the Window object that contained the script that called open() to open this browser window, or null for windows that were not created in that way. This property is valid only for Window objects that represent top-level windows, not those that represent frames. The opener property is useful so that a newly created window can refer to properties and functions defined in the window that created it.

readonly long outerHeight

readonly long outerWidth

These properties specify the total height and width, in pixels, of the browser window, including toolbars, scrollbars, window borders, and so on. These properties are not supported in IE8 and before.

readonly long pageXOffset

readonly long pageYOffset

The number of pixels that the current document has been scrolled to the right (pageXOffset) and down (pageYOffset). These properties are not supported in IE8 and before. See Example 15-8 for an example and compatibility code that works in IE.

readonly Window parent

The Window object that contains this one. If this window is a top-level window, parent refers to the window itself. If this window is a frame, the parent property refers to the window or frame that contains it.

string returnValue

This property does not exist in normal windows, but it is defined for Windows created by showModalDialog() and has the empty string as its default value. When a dialog Window is closed (see the close() method), the value of this property becomes the return value of showModalDialog().

readonly Screen screen

The Screen object that specifies information about the screen: the number of available pixels and the number of available colors. See Screen for details.

readonly long screenX

readonly long screenY

The coordinates of the upper left corner of the window on the screen.

readonly Window self

A reference to this window itself. This is a synonym for the window property.

readonly Storage sessionStorage

This property refers to a Storage object that provides client-side storage for name/value pairs. Data stored through sessionStorage is visible only to same-origin documents within the same top-level window or tab, and persists only for the duration of the browsing session. See also localStorage and localStorage and sessionStorage.

readonly Window top

The top-level window that contains this window. If this window is a top-level window itself, the top property simply refers to the window itself. If this window is a frame, the top property refers to the top-level window that contains the frame. Contrast with the parent property.

readonly object URL

At the time of this writing, this property is simply a reference to a placeholder object that defines the functions documented at URL. In the future, this property may become a URL() constructor and define an API for parsing URLs and their query strings.

readonly Window window

The window property is identical to the self property; it contains a reference to this window. Since the Window object is the global object of client-side JavaScript, this property allows us to write window to refer to the global object.

Constructors

As the global object for client-side JavaScript, the Window object must define all the global constructors for the client-side environment. Although they are not listed here, all of the global constructors documented in this reference section are properties of the Window object. The fact that client-side JavaScript defines Image() and XMLHttpRequest() constructors, for example, means that every Window object has properties named Image and XMLHttpRequest.

Methods

The Window object defines the following methods and also inherits all the global functions defined by core JavaScript (see Global in Part III).

void alert(string message)

The alert() method displays the specified plain-text message to the user in a dialog box. The dialog box contains an OK button the user can click to dismiss it. The dialog box is typically modal (at least for the current tab), and the call to alert() blocks until the dialog is dismissed.

string atob(string atob)

This utility function accepts a base64-encoded string and decodes it into a JavaScript binary string in which each character represents a single byte. Use the charCodeAt() method of the returned string to extract byte values. See also btoa().

void blur()

The blur() method removes keyboard focus from the top-level browser window specified by the Window object. It is unspecified which window gains keyboard focus as a result. In some browsers and/or platforms, this method may have no effect.

string btoa(string btoa)

This utility function accepts a JavaScript binary string (in which each character represents a single byte) as an argument and returns the base64 encoding of it. Use String.fromCharCode() to create a binary string from an arbitrary sequence of byte values. See also atob().

void clearInterval(long handle)

clearInterval() stops the repeated execution of code that was started by a call to setInterval(). intervalId must be the value that was returned by a call to setInterval().

void clearTimeout(long handle)

clearTimeout() cancels the execution of code that has been deferred with the setTimeout() method. The timeoutId argument is a value returned by the call to setTimeout() and identifies which deferred code to cancel.

void close()

The close() method closes the top-level browser window on which it is invoked. Scripts are generally only allowed to close windows that they opened.

boolean confirm(string message)

This method displays the specified question as plain text in a modal dialog box. The dialog box contains OK and Cancel buttons that the user can use to answer the question. If the user clicks the OK button, confirm() returns true. If the user clicks Cancel, confirm() returns false.

void focus()

This method gives keyboard focus to the browser window. On most platforms, a top-level window is brought forward to the top of the window stack so that it becomes visible when it is given focus.

CSSStyleDeclaration getComputedStyle(Element elt, [string pseudoElt])

An element in a document can obtain style information from an inline style attribute and from any number of stylesheets in the stylesheet「cascade.」Before the element can actually be displayed in a window, its style information must be extracted from the cascade, and styles specified with relative units (such as percentages or「ems」) must be「computed」to convert to pixels. These computed values are sometimes also called「used」values.

This method returns a read-only CSSStyleDeclaration object that represents the CSS style values actually used to display the element. All dimensions will be in pixels.

The second argument to this method is usually omitted or null, but you can also pass the CSS pseudoelement「::before」or「::after」to determine the styles used for CSS-generated content.

Contrast getComputedStyle() with the style property of an HTMLElement, which gives you access only to the inline styles of an element, in whatever units they were specified, and tells you nothing about stylesheet styles that apply to the element.

This method is not implemented in IE8 and before, but similar functionality is available through the nonstandard currentStyle property of each HTMLElement object.

Window open([string url], [string target], [string features], [string replace])

The open() method loads and displays the specified url in a new or existing browser window or tab. The url argument specifies the URL of the document to load. If not specified,「about:blank」is used.

The target argument specifies the name of the window into which the url should be loaded. If not specified,「_blank」is used. If target is「_blank」, or if there is no existing window with the specified name, a new window is created to display the contents of url. Otherwise, the url is loaded into the existing window with the specified name.

The features argument used to specify the window position, size, and features (such as menubar, toolbar, etc.). In modern browsers that support tabs, it is often ignored, and it is not documented here.

When you use Window.open() to load a new document into an existing window, the replace argument specifies whether the new document has its own entry in the window’s browsing history or whether it replaces the history entry of the current document. If replace is true, the new document replaces the old. If this argument is false or is not specified, the new document has its own entry in the Window’s browsing history. This argument provides functionality much like that of the Location.replace() method.

void postMessage(any message, string targetOrigin, [MessagePort[] ports])

Send a copy of the specified message and the optionally specified ports to this window, but only if the document displayed in this window has the specified targetOrigin.

message can be any object that can be cloned with the structured clone algorithm (see Structured Clones). targetOrigin should be an absolute URL that specifies the scheme, host, and port of the desired origin. Or targetOrigin can be「*」if any origin is acceptable or「/」to use the script’s own origin.

Calling this method on a window causes a message event on that window. See MessageEvent and Cross-Origin Messaging.

void print()

Calling print() causes the browser to behave as if the user had selected the browser’s Print button or menu item. Usually, this brings up a dialog box that enables the user to cancel or customize the print request.

string prompt(string message, [string default])

The prompt() method displays the specified message in a modal dialog box that also contains a text input field and OK and Cancel buttons and blocks until the user clicks one of the buttons.

If the user clicks the Cancel button, prompt() returns null. If the user clicks the OK button, prompt() returns the text currently displayed in the input field.

The default argument specifies the initial value of the text input field

void scroll(long x, long y)

This method is a synonym for scrollTo().

void scrollBy(long x, long y)

scrollBy() scrolls the document displayed in window by the relative amounts specified by dx and dy.

void scrollTo(long x, long y)

scrollTo() scrolls the document displayed within window so the point in the document specified by the x and y coordinates is displayed in the upper left corner, if possible.

long setInterval(function f, unsigned long interval, any args...)

setInterval() registers the function f to be invoked after interval milliseconds and then to be repeatedly invoked at that specified interval. f will be invoked with the Window as its this value, and will be passed any additional args that were passed to setInterval().

setInterval() returns a number that can later be passed to Window.clearInterval() to cancel the execution of code.

For historical reasons, f may be a string of JavaScript code instead of a function. If so, the string will be evaluated (as if it were a <script>) every interval milliseconds.

Use setTimeout() when you want to defer the execution of code but do not want it to be repeatedly executed.

long setTimeout(function f, unsigned long timeout, any args...)

setTimeout() is like setInterval(), except that it invokes the specified function only once: it registers f to be invoked after timeout milliseconds have been elapsed and returns a number that can later be passed to clearTimeout() to cancel the pending invocation. When the specified time has passed, f will be invoked as a method of the Window and will be passed any specified args. If f is a string rather than a function, it will be executed after timeout milliseconds as if it were a <script>.

any showModalDialog(string url, [any arguments])

This method creates a new Window object, sets its dialogArguments property to arguments, loads url into the window, and blocks until the window is closed. Once closed, it returns the returnValue property of the window. See Dialog Boxes and Example 14-4 for a discussion and example.

Event Handlers

Most events that occur on HTML elements bubble up the document tree, to the Document object and then on to the Window object. For this reason, you can use all of the event handler properties listed in Element on Window objects. And in addition, you can use the event handler properties listed below. For historical reasons, each of the event handler properties listed here can also be defined (as an HTML attribute or as a JavaScript property) on the <body> element.

Event Handler Invoked...

onafterprint After the window’s contents are printed

onbeforeprint Before the window’s contents are printed

onbefore unload Before navigating away from the current page. If the return value is a string, or if the handler sets the returnValue property of its event object to a string, that string will be displayed in a confirmation dialog. See BeforeUnloadEvent.

onblur When the window loses keyboard focus

onerror When a JavaScript error occurs. This is not an ordinary event handler. See Error Handling.

onfocus When the window gains keyboard focus

onhashchange When the fragment identifier (see Location.hash) of the document changes as the result of history navigation (see HashChangeEvent)

onload When the document and its external resources are fully loaded

onmessage When a script in another window sends a message by calling the postMessage() method. See MessageEvent.

onoffline When the browser loses its connection to the Internet

ononline When the browser regains a connection to the Internet

onpagehide When the page is about to be cached and replaced by another page

onpageshow When a page is first loaded, a pageshow event is fired right after the load event, and the event object has a persisted property of false. When a previously loaded page is restored from the browser’s in-memory cache, however, no load event is fired (since the cached page is already in its loaded state) and a pageshow event is fired with an event object that has its persisted property set to true. See PageTransitionEvent.

onpopstate When the browser loads a new page or restores a state saved with History.pushState() or History.replaceState(). See PopStateEvent.

onresize When the user changes the size of the browser window

onscroll When the user scrolls the browser window

onstorage Content of localStorage or sessionStorage changes. See StorageEvent.

onunload The browser navigates away from a page. Note that if you register an onunload handler for a page, that page will not be cacheable. To allow users to quickly return to your page without reloading, use onpagehide instead.

Name

Worker — a worker thread

Inherits from

EventTarget

Synopsis

A Worker represents a background thread. Create a new Worker with the Worker() constructor, passing the URL of a file of JavaScript code for it to run. The JavaScript code in that file can use synchronous APIs or perform compute-intensive tasks without freezing up the main UI thread. Workers run their code in a completely separate execution context (see WorkerGlobalScope), and the only way to exchange data with a worker is via asynchronous events. Call postMessage() to send data to the Worker, and handle message events to receive data from the worker.

See Web Workers for an introduction to worker threads.

Constructor

new Worker(string scriptURL)

Constructs a new Worker object and causes it to run the JavaScript code in scriptURL.

Methods

void postMessage(any message, [MessagePort[] ports])

Send message to the worker, which will receive it as a MessageEvent object sent to its on message handler. message can be a JavaScript primitive value or object or array, but not a function. Client-side types ArrayBuffer, File, Blob, and ImageData are allowed, but Nodes, such as Document and Element, are not allowed (see Structured Clones for details).

The optional ports argument is an advanced feature that allows you to pass one or more direct communication channels to the Worker. If you create two Worker objects, for example, you can allow them to communicate directly with each other by passing them each one end of a MessageChannel.

void terminate()

Stop the worker and abort the script it is running.

Event Handlers

Because workers run code in a completely separate execution environment than the one that created them, the only way they can communicate with their parent thread is by events. You can register event handlers on these properties or use the EventTarget methods.

onerror

When an exception is thrown in the script being run by a Worker, and that error is not handled by the onerror handler of the WorkerGlobalScope, the error triggers an error event on the Worker object. The event object associated with this event is a ErrorEvent. The error event does not bubble. If this worker is owned by another worker, canceling an error event prevents it from being propagated up to the parent worker. If this Worker object is already in the main thread, canceling the event may prevent it from being displayed in the JavaScript console.

onmessage

When the script that the worker is running calls its global postMessage() function (see WorkerGlobalScope), a message event is triggered on the Worker object. The object passed to the event handler is a MessageEvent, and its data property contains a clone of the value that the worker script passed to postMessage().

Name

WorkerGlobalScope

Inherits from

EventTarget, Global

Synopsis

A Worker thread runs in a completely different execution environment than the parent thread that spawned it. The global object for a worker is a WorkerGlobalScope object, so this page describes the execution environment「inside」a Worker. Since WorkerGlobalScope is a global object, it inherits the Global object of core JavaScript.

Properties

In addition to the properties listed here, WorkerGlobalScope also defines all of the core JavaScript global properties, such as Math and JSON.

readonly WorkerLocation location

This property is like the window.location Location object: it allows a worker to inspect the URL it was loaded from and includes properties that return individual portions of the URL.

readonly WorkerNavigator navigator

This property is like the window.navigator Navigator object: it defines properties that allow a worker to determine what browser it is running in and whether it is currently online or not.

readonly WorkerGlobalScope self

This self-referential property refers to the WorkerGlobalScope global object itself. It is like the window property of the Window object in the main thread.

Methods

In addition to the properties listed here, WorkerGlobalScope also defines all of the core JavaScript global functions, such as isNaN() and eval().

void clearInterval(long handle)

This method is just like the Window method of the same name.

void clearTimeout(long handle)

This method is just like the Window method of the same name.

void close()

This method puts the worker into a special「closing」state. Once in this state, it will not fire any timers or trigger any events. The script continues running until it returns to the worker’s event loop, at which point the worker stops.

void importScripts(string urls...)

For each of the specified urls, this method resolves the URL relative to the worker’s location, then loads the content of the URL, and then executes that content as JavaScript code. Note that this is a synchronous method. It loads and executes each file in turn and does not return until all scripts have executed. (If any script throws an exception, however, that exception will propagate and prevent any subsequent URLs from being loaded and executed.)

void postMessage(any message, [MessagePort[] ports])

Sends a message (and optionally an array of ports) to the thread that spawned this worker. Calling this method causes a message event to be triggered on the Worker object in the parent thread, and the associated MessageEvent object will include a clone of message as its data property. Note that in a worker, postMessage() is a global function.

long setInterval(any handler, [any timeout], any args...)

This method is just like the Window method of the same name.

long setTimeout(any handler, [any timeout], any args...)

This method is just like the Window method of the same name.

Constructors

WorkerGlobalScope includes all of the core JavaScript constructors, such as Array(), Date(), and RegExp(). It also defines key client-side constructors for XMLHttpRequest, FileReaderSync, and even the Worker object itself.

Event Handlers

You can register event handlers for workers by setting these global event handler properties, or you can use the EventTarget methods implemented by WorkerGlobalScope.

onerror

This is not a normal event handler: it is like the onerror property of Window rather than the onerror property of Worker. When an unhandled exception occurs in the worker, this function, if defined, will be invoked with three string arguments that specify an error message, a script URL, and a line number. If the function returns false, the error is considered handled and does not propagate. Otherwise, if this property is not set, or if the error handler does not return false, the error propagates and causes an error event on the Worker object in the parent thread.

onmessage

When the parent thread calls the postMessage() method of the Worker object that represents this worker, it causes a message event to be triggered on this WorkerGlobalScope. This event handler function will be passed a MessageEvent object, and the data property of that object will hold a clone of the message argument sent by the parent thread.

Name

WorkerLocation — the URL of a worker’s main script

Synopsis

The WorkerLocation object referenced by the location property of a WorkerGlobalScope is like the Location object referenced by the location property of a Window: it represents the URL of the worker’s main script and defines properties that represent portions of that URL.

Workers differ from Windows in that they cannot be navigated or reloaded, so the properties of a WorkerLocation object are read-only, and the object does not implement the methods of the Location object.

The WorkerLocation object does not automatically convert to a string the way a regular location object does. In a worker, you cannot simply write location when you mean location. href.

Properties

These properties have the same meanings as the same-named properties of the Location object.

readonly string hash

The fragment identifier portion of the URL, including the leading hash mark.

readonly string host

The host and port portions of the URL.

readonly string hostname

The host portion of the URL.

readonly string href

The complete text of the URL that was passed to the Worker() constructor. This is the only value that the worker receives directly from its parent thread: all other values are received indirectly through message events.

readonly string pathname

The pathname portion of the URL.

readonly string port

The port portion of the URL.

readonly string protocol

The protocol portion of the URL.

readonly string search

The search or query portion of the URL, including the leading question mark.

Name

WorkerNavigator — browser information for workers

Synopsis

The navigator property of a WorkerGlobalScope refers to a WorkerNavigator object that is a simplified version of the Navigator object of a Window.

Properties

Each of these properties has the same meaning that it does in the Navigator object.

readonly string appName

See the appName property of Navigator.

readonly string appVersion

See the appVersions property of Navigator.

readonly boolean onLine

true if the browser is online and false if it is not.

readonly string platform

A string that identifies the operating system and/or hardware platform on which the browser is running.

readonly string userAgent

The value the browser uses for the user-agent header in HTTP requests.

Name

XMLHttpRequest — An HTTP request and response

Inherits from

EventTarget

Synopsis

The XMLHttpRequest object allows client-side JavaScript to issue HTTP requests and receive responses (which need not be XML) from web servers. XMLHttpRequest is the subject of Chapter 18, and that chapter contains many examples of its use.

Create an XMLHttpRequest object with the XMLHttpRequest() constructor (see the sidebar in Using XMLHttpRequest for information on how to create an XMLHttpRequest object in IE6) and then use it like this:

Call open() to specify the URL and method (usually「GET」or「POST」) for the request.

Set the onreadystatechange property to the function that will be notified of the progress of the request.

Call setRequestHeader(), if needed, to specify additional request parameters.

Call send() to send the request to the web server. If it is a POST request, you can also pass a request body to this method. Your onreadystatechange event handler function will be invoked as the request proceeds. When readyState is 4, the response is complete.

When readyState is 4, check the status code to ensure that the request was successful. If so, use getResponseHeader() or getResponseHeaders() to retrieve values from the response header, and use the responseText or responseXML properties to obtain the response body.

XMLHttpRequest defines a relatively high-level interface to the HTTP protocol. It takes care of details such as handling redirects, managing cookies, and negotiating cross-origin connections with CORS headers.

The XMLHttpRequest features described above are well supported by all modern browsers. At the time of this writing, an XMLHttpRequest Level 2 standard is under development and browsers are beginning to implement it. The properties, methods, and event handlers listed below include XMLHttpRequest Level 2 features, which may not yet be implemented by all browsers. These newer features are marked「XHR2.」

Constructor

new XMLHttpRequest()

This no-argument constructor returns a new XMLHttpRequest object.

Constants

These constants define the values of the readyState property. Prior to XHR2, these constants are not widely defined, and most code uses integer literals rather than these symbolic values.

unsigned short UNSENT = 0

This is the initial state. The XMLHttpRequest object has just been created or has been reset with the abort() method.

unsigned short OPENED = 1

The open() method has been called, but send() has not. The request has not yet been sent.

unsigned short HEADERS_RECEIVED = 2

The send() method has been called, and the response headers have been received, but the response body has not yet been received.

unsigned short LOADING = 3

The response body is being received but is not complete.

unsigned short DONE = 4

The HTTP response has been fully received or has stopped because of an error.

Properties

readonly unsigned short readyState

The state of the HTTP request and the server’s response. The value of this property begins at 0 when an XMLHttpRequest is first created and increases to 4 when the complete HTTP response has been received. The constants listed above define the possible values.

The value of readyState never decreases, unless abort() or open() is called on a request that is already in progress.

In theory, a readystatechange event is dispatched every time the value of this property changes. In practice, however, an event is only really guaranteed when readyState changes to 4. (The XHR2 progress events provide a more reliable way of tracking the progress of a request.)

readonly any response

In XHR2, this property holds the server’s response. Its type depends on the responseType property. If responseType is the empty string or「text」, property will hold the response body as a string. If responseType is「document」, this property will be a parsed representation of the response body as an XML or HTTP Document. If responseType is「arraybuffer」, this property will be an ArrayBuffer that represents the bytes of the response body. And if responseType is「blob」, this property will be a Blob that represents the bytes of the response body.

readonly string responseText

If readyState is less than 3, this property is the empty string. When readyState is 3, this property returns whatever portion of the response has been received so far. If readyState is 4, this property holds the complete body of the response.

If the response includes headers that specify a character encoding for the body, that encoding is used. Otherwise, the Unicode UTF-8 encoding is assumed.

string responseType

In XHR2, this property specifies the desired response type and determines the type of the response property. The legal values are「text」,「document」,「arraybuffer」, and「blob」. The default is the empty string, which is a synonym for「text」. If you set this property, the responseText and responseXML properties will raise exceptions and you must use the XHR2 response property to get the server’s response.

readonly Document responseXML

The response to the request, parsed as an XML or HTML Document object, or null if the response body is not ready or is not a valid XML or HTML document.

readonly unsigned short status

The HTTP status code returned by the server, such as 200 for success, 404 for「Not Found」errors, or 0 if the server has not set a status code yet.

readonly string statusText

This property specifies the HTTP status code of the request by name rather than by number. That is, it is「OK」when status is 200 and「Not Found」when status is 404. This property is the empty string if the server has not set a status code yet.

unsigned long timeout

