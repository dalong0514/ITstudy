This XHR2 property specifies a timeout value in milliseconds. If the HTTP request takes longer than this to complete, it will be aborted and timeout event will be triggered. You can only set this property after calling open() and before calling send().

readonly XMLHttpRequestUpload upload

This XHR2 property refers to an XMLHttpRequestUpload object that defines a set of event handler registration properties for monitoring the progress of the HTTP request body upload.

boolean withCredentials

This XHR2 property specifies whether authentication credentials should be included in CORS requests and whether cookie headers in CORS responses should be processed. The default value is false.

Methods

void abort()

This method resets the XMLHttpRequest object to a readyState of 0 and aborts any pending network activity. You might call this method, for example, if a request has taken too long, and the response is no longer necessary.

string getAllResponseHeaders()

This method returns the HTTP response headers (with cookie and CORS headers filtered out) sent by the server, or null if the headers have not been received yet. The headers are returned as a single string, with one header per line.

string getResponseHeader(string header)

Returns the value of a named HTTP response header, or null if headers have not been received yet or if the response does not include the specified header. Cookie and CORS-related headers are filtered out and cannot be queried. If the response includes more than one header with the specified name, the returned string will include the value of all of those headers, concatenated and separated by a comma and a space.

void open(string method, string url, [boolean async, string user, string pass])

This method resets the XMLHttpRequest object and stores its arguments for later use by the send().

method is the HTTP method to be used for the request. Reliably implemented values include GET, POST, and HEAD. Implementations may also support the CONNECT, DELETE, OPTIONS, PUT, TRACE, and TRACK methods.

url is the URL being requested. Relative URLs are resolved in the normal way, using the URL of the document that contains the script. The same-origin security policy (see The Same-Origin Policy) requires that this URL have the same hostname and port as the document that contains the script making the request. XHR2 allows cross-origin requests to servers that support CORS.

If the async argument is specified and is false, the request is performed synchronously and the send() method will block until the response is complete. This is not recommended except when XMLHttpRequest is used in a Worker.

The optional user and pass arguments specify a username and password to use with the HTTP request.

void overrideMimeType(string mime)

This method specifies that the server’s response should be interpreted according to the specified mime type (and charset parameter, if that is included) instead of using the Content-Type header of the response.

void send(any body)

This method causes an HTTP request to be issued. If there has been no previous call to open(), or, more generally, if readyState is not 1, send() throws an exception. Otherwise, it issues an HTTP request that consists of:

The HTTP method, URL, and authorization credentials (if any) specified in the previous call to open().

The request headers, if any, specified by previous calls to setRequestHeader().

The body argument passed to this method. The body may be a string or a Document object that specifies the request body, or may be omitted or null if the request has no body (such as GET requests that never have a body). In XHR2, the body may also be an ArrayBuffer, a Blob, or a FormData object.

If the async argument to the previous call to open() was false, this method blocks and does not return until readyState is 4 and the server’s response has been fully received. Otherwise, send() returns immediately, and the server’s response is processed asynchronously with notifications provided through event handlers.

void setRequestHeader(string name, string value)

setRequestHeader() specifies an HTTP request header name and value that should be included in the request issued by a subsequent call to send(). This method may be called only when readyState is 1—i.e., after a call to open(), but before a call to send().

If a header with the specified name has already been specified, the new value for that header is the previously specified value, plus a comma, a space, and the value specified in this call.

If the call to open() specifies authorization credentials, XMLHttpRequest automatically sends an appropriate Authorization request header. You can also append to this header yourself with setRequestHeader(), however.

XMLHttpRequest automatically sets「Content-Length」,「Date」,「Referer」, and「User-Agent」and does not allow you to spoof them. There are a number of other headers, including cookie-related headers, that you cannot set with this method. The complete list is in Using XMLHttpRequest.

Event Handlers

The original XMLHttpRequest object defined only a single event handler property: onready state change. XHR2 expands the list with a set of progress event handlers that are much easier to use. You can register handlers by setting these properties or by using the methods of EventTarget. XMLHttpRequest events are always dispatched on the XMLHttpRequest object itself. They do not bubble and have no default action to cancel. readystatechange events have an associated Event object, and all of the other event types have an associated ProgressEvent object.

See the upload property and XMLHttpRequestUpload for a list of events you can use to monitor the progress of HTTP uploads.

onabort

Triggered when a request is aborted.

onerror

Triggered if the request fails with an error. Note that HTTP status codes such as 404 do not constitute an error since the response still completes successfully. A DNS failure while trying to resolve the URL or an infinite loop of redirects would both cause this event to occur, however.

onload

Triggered when the request completes successfully.

onloadend

Triggered when the request has succeeded or failed after the load, abort, error, or timeout event.

onloadstart

Triggered when the request starts.

onprogress

Triggered repeatedly (approximately every 50ms) while the response body is downloading.

onreadystatechange

Triggered when the readyState property changes, most importantly when the response is complete.

ontimeout

Triggered if the time specified by the timeout property has elapsed and the response is not complete.

Name

XMLHttpRequestUpload

Inherits from

EventTarget

Synopsis

An XMLHttpRequestUpload object defines a set of event handler registration properties for monitoring the progress of an HTTP request body upload. In browsers that implement the XMLHttpRequest Level 2 specification, each XMLHttpRequest object has an upload property that refers to an object of this type. To monitor the progress of the request upload, simply set these properties to appropriate event handler functions or call the EventTarget methods. Note that the upload progress event handlers defined here are exactly the same as the download progress event handlers defined on XMLHttpRequest itself, except that there is no onready statechange property on this object.

Event Handlers

onabort

Triggered if the upload is aborted.

onerror

Triggered if the upload fails with a network error.

onload

Triggered when the upload succeeds

onloadend

Triggered when the upload finishes, whether successfully or not. A loadend event will always follow a load, abort, error, or timeout event.

onloadstart

Triggered when the upload starts.

onprogress

Triggered repeatedly (approximately every 50ms) while the upload is occurring.

ontimeout

Triggered if the upload is aborted because the XMLHttpRequest timeout expired.

Index

A note on the digital index

A link in an index entry is displayed as the section title in which that entry appears. Because some sections have multiple index markers, it is not unusual for an entry to have several links to the same section. Clicking on any link will take you directly to the place in the text in which the marker appears.

Symbols

3D graphics for <canvas> element, Graphics in a <canvas>, Typed Arrays and ArrayBuffers

& (ampersand), Boolean Values, Operator Overview, Operator Overview, Operator Overview, Bitwise Operators, Logical AND (&&), Assignment with Operation, Property Access Errors

&& (logical AND) operator, Boolean Values, Operator Overview, Logical AND (&&), Property Access Errors

short-circuiting behavior of, Property Access Errors

&= (bitwise AND and assignment) operator, Operator Overview, Assignment with Operation

bitwise AND operator, Operator Overview, Bitwise Operators

< > (angle brackets), Operator Overview, Operator Overview, Operator Overview, Operator Overview, Operator Overview, Operator Overview, Operator Overview, Operator Overview, Operator Overview, Operator Overview, Bitwise Operators, Bitwise Operators, Bitwise Operators, Comparison Operators, Comparison Operators, Comparison Operators, Comparison Operators, Assignment with Operation, Assignment with Operation, Assignment with Operation, Comparison Methods, Comparison Methods, Comparison Methods, Comparison Methods

< (less than) operator, Operator Overview, Comparison Operators, Comparison Methods

substituting compareTo ( ) method, Comparison Methods

<< (bitwise left shift) operator, Operator Overview, Bitwise Operators

<<= (bitwise left shift and assignment) operator, Operator Overview, Assignment with Operation

<= (less than or equal to) operator, Operator Overview, Comparison Operators, Comparison Methods

substituting compareTo( ) method, Comparison Methods

> (greater than) operator, Operator Overview, Comparison Operators, Comparison Methods

substituting compareTo( ) method, Comparison Methods

>= (greater than or equal to) operator, Operator Overview, Comparison Operators, Comparison Methods

substituting compareTo( ) method, Comparison Methods

>> (bitwise right shift with sign extension) operator, Operator Overview, Bitwise Operators

>>= (bitwise right shift with sign extension and assignment) operator, Operator Overview, Assignment with Operation

>>> (bitwise right shift with zero fill) operator, Operator Overview, Bitwise Operators

>>>= (bitwise right shift with zero fill and assignment) operator, Operator Overview, Assignment with Operation

* (asterisk), Arithmetic in JavaScript, Operator Overview, Operator Overview, Assignment with Operation, Repetition, E4X: ECMAScript for XML

*= (multiplication and assignment) operator, Operator Overview, Assignment with Operation

matching zero or more occurrences in regular expressions, Repetition

multiplication operator, Arithmetic in JavaScript, Operator Overview

wildcard character in E4X, E4X: ECMAScript for XML

@ (at sign), E4X: ECMAScript for XML, Conditional Comments in Internet Explorer

@if, @else, and @end keywords in conditional comments, Conditional Comments in Internet Explorer

in attribute names, E4X: ECMAScript for XML

\ (backslash), String Literals, Escape Sequences in String Literals, Literal Characters

breaking multiline string literals, String Literals

escape sequences in string literals, Escape Sequences in String Literals

escaping special characters in regular expressions, Literal Characters

^ (caret), Operator Overview, Operator Overview, Bitwise Operators, Assignment with Operation, Character Classes, Specifying Match Position

beginning-of-string matching in regular expressions, Specifying Match Position

bitwise XOR operator, Operator Overview, Bitwise Operators

negating character classes in regular expressions, Character Classes

^= (bitwise XOR and assignment) operator, Operator Overview, Assignment with Operation

, (comma) operator, The Comma Operator (,)

{ } (curly braces), Core JavaScript, Object and Array Initializers, Compound and Empty Statements, Defining Functions, Shorthand Functions, E4X: ECMAScript for XML

around function body, omitting in shorthand functions, Shorthand Functions

enclosing object initializer expressions, Object and Array Initializers

enclosing statement blocks, Compound and Empty Statements

escape characters in XML literal syntax of E4X, E4X: ECMAScript for XML

in function definitions, Defining Functions

initializer expressions in, Core JavaScript

$ (dollar sign), Client-Side JavaScript, Defining Regular Expressions, Specifying Match Position, String Methods for Pattern Matching, Document Elements As Window Properties, jQuery Basics, The jQuery() Function, Queries and Query Results, Queries and Query Results, Properties, Element $(string id) , NodeList $$(string selector)

$$( ) method, ConsoleCommandLine, NodeList $$(string selector)

$( ) function, Client-Side JavaScript, Document Elements As Window Properties, jQuery Basics, The jQuery() Function, Queries and Query Results, Queries and Query Results

looking up elements by ID, Document Elements As Window Properties

using instead of querySelectorAll( ), Queries and Query Results

$( ) method, ConsoleCommandLine, Element $(string id)

$0 and $1 properties, ConsoleCommandLine, Properties

$1, $2 … $n variables in regular expressions, String Methods for Pattern Matching

end-of-string matching in regular expressions, Defining Regular Expressions, Specifying Match Position

. (dot), Core JavaScript, Property Access Expressions, Querying and Setting Properties, Method Invocation, Character Classes, Subsets for Security, E4X: ECMAScript for XML

. . (descendant) operator, E4X: ECMAScript for XML

dot operator, Core JavaScript, Querying and Setting Properties, Method Invocation, Subsets for Security

property access in method invocations, Method Invocation

property access with, secure subsets and, Subsets for Security

querying and setting properties, Querying and Setting Properties

matching any character except newlines in regular expressions, Character Classes

in property access expressions, Property Access Expressions

= (equals sign), Arithmetic in JavaScript, null and undefined, Wrapper Objects, Conversions and Equality, Object to Primitive Conversions, Operator Overview, Operator Overview, Operator Overview, Equality and Inequality Operators, Equality and Inequality Operators, Comparison Methods, jQuery.getJSON()

== (equality) operator, Arithmetic in JavaScript, Object to Primitive Conversions, Operator Overview, Equality and Inequality Operators, Comparison Methods

NaN values and, Arithmetic in JavaScript

object-to-primitive conversions, Object to Primitive Conversions

substituting compareTo( ) method, Comparison Methods

== and === operators, null and undefined, Wrapper Objects, Conversions and Equality

comparing null and undefined values, null and undefined

comparing primitive values and wrapper objects, Wrapper Objects

type conversions and equality, Conversions and Equality

=== (strict equality) operator, Operator Overview, Equality and Inequality Operators

=? in URL or data string passed to jQuery.getJSON( ), jQuery.getJSON()

assignment operator, Operator Overview

! (exclamation mark), Arithmetic in JavaScript, Boolean Values, Explicit Conversions, Operator Overview, Operator Overview, Operator Overview, Equality and Inequality Operators, Equality and Inequality Operators, Logical NOT (!), Testing Properties, Comparison Methods

!= (inequality) operator, Arithmetic in JavaScript, Operator Overview, Equality and Inequality Operators, Comparison Methods

NaN comparisons, Arithmetic in JavaScript

substituting compareTo( ) method, Comparison Methods

!== (strict inequality) operator, Boolean Values, Operator Overview, Equality and Inequality Operators, Testing Properties

comparing variable to null, Boolean Values

testing for undefined properties, Testing Properties

logical NOT operator, Explicit Conversions, Operator Overview, Logical NOT (!)

- (minus sign), Optional Semicolons, Optional Semicolons, Arithmetic in JavaScript, Arithmetic in JavaScript, Operator Overview, Operator Overview, Operator Overview, Operator Side Effects, Unary Arithmetic Operators, Unary Arithmetic Operators, Assignment with Operation, Expression Statements

-- (decrement) operator, Optional Semicolons, Operator Overview, Operator Side Effects, Unary Arithmetic Operators, Expression Statements

line breaks in statements and, Optional Semicolons

side effects, Operator Side Effects, Expression Statements

-= (subtraction and assignment) operator, Assignment with Operation

-Infinity (negative infinity), Arithmetic in JavaScript

negation operator, Operator Overview

statements beginning with, Optional Semicolons

subtraction operator, Arithmetic in JavaScript, Operator Overview

unary minus operator, Unary Arithmetic Operators

( ) (parentheses), Optional Semicolons, Function Definition Expressions, Invocation Expressions, Object Creation Expressions, if, Defining Functions, Alternation, Grouping, and References, Generator Expressions

enclosing expressions in if statements, if

grouping in regular expressions, Alternation, Grouping, and References

in function and method invocations, Invocation Expressions

in function definitions, Function Definition Expressions, Defining Functions

in generator expressions, Generator Expressions

in object creation expressions, Object Creation Expressions

statements beginning with (, Optional Semicolons

% (percent sign), Arithmetic in JavaScript, Operator Overview, Operator Overview, Assignment with Operation

%= (modulus and assignment) operator, Operator Overview, Assignment with Operation

modulus operator, Arithmetic in JavaScript, Operator Overview

. (period), Property Access Expressions (see . (dot))

+ (plus sign), Optional Semicolons, Optional Semicolons, Arithmetic in JavaScript, Object to Primitive Conversions, Operator Overview, Operator Overview, Operator Overview, Operator Overview, Operator Side Effects, The + Operator, Unary Arithmetic Operators, Unary Arithmetic Operators, Assignment with Operation, Expression Statements, Repetition, Element Content As HTML

++ (increment) operator, Optional Semicolons, Operator Overview, Operator Side Effects, Unary Arithmetic Operators, Expression Statements

line breaks in statements and, Optional Semicolons

side effects, Operator Side Effects, Expression Statements

+= (addition and assignment) operator, Operator Overview, Assignment with Operation, Element Content As HTML

appending text to innerHTML property, Element Content As HTML

addition and string concatenation operators, Object to Primitive Conversions, The + Operator

object-to-primitive conversions, Object to Primitive Conversions

addition operator, Arithmetic in JavaScript, Operator Overview

matching one or more occurrences in regular expressions, Repetition

statements beginning with, Optional Semicolons

string concatenation operator, Operator Overview

unary plus operator, Unary Arithmetic Operators

? (question mark), Operator Overview, The Conditional Operator (?:), Nongreedy repetition, Specifying Match Position, Specifying Match Position

?! (negative lookahead assertion) in regular expressions, Specifying Match Position

?: (conditional) operator, Operator Overview, The Conditional Operator (?:)

?= (positive lookahead assertions) in regular expressions, Specifying Match Position

nongreedy repetition in regular expressions, Nongreedy repetition

" " (quotation marks, double) enclosing string literals, String Literals, Scripting Inline Styles

quoting in stylesheet or style attribute strings, Scripting Inline Styles

' ' (quotation marks, single) enclosing string literals, String Literals, Bookmarklets

single-quoted HTML attribute, JavaScript code in, Bookmarklets

; (semicolon), Core JavaScript, Optional Semicolons, Statements, Compound and Empty Statements, Overview of CSS, Scripting Inline Styles

ending statements, Core JavaScript, Statements

optional, ending statements, Optional Semicolons

placing outside of style attribute or stylesheet strings, Scripting Inline Styles

separating name-value pairs in style properties, Overview of CSS

statement blocks and, Compound and Empty Statements

/ (slash), Core JavaScript, Comments, Optional Semicolons, Arithmetic in JavaScript, Operator Overview, Operator Overview, Assignment with Operation, Defining Regular Expressions, JavaScript in URLs, Conditional Comments in Internet Explorer

/* */ comments in javascript: URL code, JavaScript in URLs

/*@cc_on and @*/in conditional comments, Conditional Comments in Internet Explorer

// and /」*/ in comments, Comments

// in comments, Core JavaScript

/= (division and assignment) operator, Operator Overview, Assignment with Operation

division operator, Arithmetic in JavaScript, Operator Overview

enclosing regular expression literals, Defining Regular Expressions

statements beginning with, Optional Semicolons

[ ] (square brackets), Core JavaScript, Optional Semicolons, Working with Strings, Object and Array Initializers, Property Access Expressions, Querying and Setting Properties, Objects As Associative Arrays, Creating Arrays, Reading and Writing Array Elements, Multidimensional Arrays, Strings As Arrays, Method Invocation, Character Classes, Subsets for Security, Array Comprehensions, Typed Arrays and ArrayBuffers

accessing array elements, Reading and Writing Array Elements

accessing individual string characters, Strings As Arrays

accessing values in multidimensional arrays, Multidimensional Arrays

array operator, Core JavaScript, Working with Strings, Typed Arrays and ArrayBuffers

accessing individual string characters, Working with Strings

creating arrays, Creating Arrays

enclosing array comprehensions, Array Comprehensions

enclosing array initializers, Object and Array Initializers

enclosing character classes in regular expressions, Character Classes

in property access expressions, Property Access Expressions, Method Invocation, Subsets for Security

restriction in secure subsets, Subsets for Security

querying and setting properties, Querying and Setting Properties, Objects As Associative Arrays

statements beginning with [, Optional Semicolons

~ (tilde), bitwise NOT operator, Operator Overview, Bitwise Operators

_ (underscore), in function names, Defining Functions

| (vertical bar), Operator Overview, Operator Overview, Operator Overview, Bitwise Operators, Logical OR (||), Assignment with Operation, Optional Parameters, Alternation, Grouping, and References

alternation in regular expression pattern matching, Alternation, Grouping, and References

bitwise OR operator, Operator Overview, Bitwise Operators

|= (bitwise OR and assignment) operator, Operator Overview, Assignment with Operation

|| (logical OR) operator, Operator Overview, Logical OR (||), Optional Parameters

A

<a> elements, JavaScript in URLs, Selecting Elements by Type, Selecting Elements by Type

having name attribute rather than href attribute, Selecting Elements by Type

href attribute, JavaScript in URLs, Selecting Elements by Type

abort( ) method, HTTP Progress Events, Aborting Requests and Timeouts, void abort()

FileReader object, void abort()

XMLHttpRequest object, HTTP Progress Events, Aborting Requests and Timeouts

about:blank URL, Opening and Closing Windows

abs( ) function, Math object, Math.abs()

absolute positioning of elements, Positioning Elements with CSS

abstract classes, Subclasses, Class Hierarchies and Abstract Classes, Classes in ECMAScript 5

class hierarchies and, Class Hierarchies and Abstract Classes, Classes in ECMAScript 5

abstract methods, Subclasses

accept property, Input object, Properties

acceptCharset property, Form object, Properties

Access-Control-Allow-Origin response header, Relaxing the same-origin policy

accessibility, Accessibility

accessor properties, Inheritance, Property Getters and Setters, Property Getters and Setters, Property Getters and Setters, Property Attributes, Property Attributes, Legacy API for Getters and Setters, Property Descriptors

adding to existing objects, Property Attributes

defining using object literal syntax, Property Getters and Setters

inheritance and, Inheritance

legacy API for, Legacy API for Getters and Setters

property descriptor, Property Attributes

uses of, Property Getters and Setters

accuracy property, Geocoordinates, Properties

acos( ) function, Math object, Math.acos()

action property, Form object, Form and Element Properties, Properties

activeElement property, Document, Properties

ActiveX controls, scripting, Scripting Plug-ins and ActiveX Controls

add( ) method, Scripting CSS Classes, Selection Methods, void add(string token) , void add(Element option, [any before]) , void add(Element element, [any before])

DOMTokenList object, Scripting CSS Classes, void add(string token)

HTMLOptionsCollection object, void add(Element option, [any before])

jQuery, Selection Methods

Select element, void add(Element element, [any before])

addClass( ) method, jQuery, Getting and Setting CSS Classes

addColorStop( ), CanvasGradient object, Colors, Transparency, Gradients, and Patterns, void addColorStop(double offset, string color)

addElement( ), DataTransfer object, Drag and Drop Events, void addElement(Element element)

addEventListener( ) method, Event-Driven JavaScript, Compatibility and Interoperability, Compatibility Libraries, Registering Event Handlers, addEventListener(), Event Propagation, Worker Objects, Worker Scope, void addEventListener(string type, function listener, [boolean useCapture])

capturing event handlers, Event Propagation

EventTarget object, void addEventListener(string type, function listener, [boolean useCapture])

incompatibilities between attachEvent( ) and, Compatibility Libraries

not implemented by Internet Explorer, Compatibility and Interoperability

registering event handlers, addEventListener()

Worker object, Worker Objects

WorkerGlobalScope object, Worker Scope

adoptNode( ) method, Document object, Node adoptNode(Node node)

ADsafe security subset, Subsets for Security

affine transforms, Understanding transformations mathematically

after( ) method, jQuery, Inserting and Replacing Elements

Ajax, Scripted HTTP, Scripted HTTP, Scripted HTTP, Ajax with jQuery, Ajax Events, The load() Method, jQuery.getScript(), jQuery.getJSON(), jQuery.getJSON(), jQuery.get() and jQuery.post(), jQuery.get() and jQuery.post(), The jQuery.ajax() Function, Uncommon options and hooks, The jQuery.ajax() Function, jQuery Ajax Functions

defined, Scripted HTTP

functions in jQuery, jQuery Ajax Functions

in jQuery 1.5, The jQuery.ajax() Function

transport mechanisms for, Scripted HTTP

utilities in jQuery, Ajax with jQuery, Ajax Events, The load() Method, jQuery.getScript(), jQuery.getJSON(), jQuery.getJSON(), jQuery.get() and jQuery.post(), jQuery.get() and jQuery.post(), The jQuery.ajax() Function, Uncommon options and hooks

ajax( ) function, The jQuery.ajax() Function, Uncommon options and hooks

data types, jQuery.get() and jQuery.post()

get( ) and post( ) functions, jQuery.get() and jQuery.post()

getJSON( ) function, jQuery.getJSON()

getScript( ) function, jQuery.getScript()

load( ) method, The load() Method

passing data to, jQuery.getJSON()

XML with, Scripted HTTP

ajax( ) function, The jQuery.ajax() Function, Uncommon options and hooks, Common Options, Callbacks, Uncommon options and hooks

callbacks, Callbacks

common options, Common Options

uncommon options and hooks, Uncommon options and hooks

ajaxSetup( ) function, The jQuery.ajax() Function

alert( ) method, Window object, Client-Side JavaScript, Dialog Boxes, void alert(string message)

alpha values, Color, Transparency, and Translucency, Colors, Transparency, Gradients, and Patterns

specifying in canvas, Colors, Transparency, Gradients, and Patterns

transparency of a color, Color, Transparency, and Translucency

altitude property, Geocoordinates object, Properties

altitudeAccuracy, Geocoordinates object, Properties

altKey property, Mouse events, Mouse Events, Keyboard Events, Properties

Event object, Properties

mouse events, Mouse events

anchors (regular expression), Specifying Match Position

anchors property, HTMLDocument, Selecting Elements by Type

andSelf( ) method, jQuery, Reverting to a previous selection

angles, specifying in radians in canvas, SVG: Scalable Vector Graphics, Coordinate System Transforms

animate( ) method, jQuery, Animated Effects, Animated Effects, Custom Animations, The animation properties object, The animation options object

animation options object, The animation options object

animation properties object, The animation properties object

custom animations with, Custom Animations

animations, CSS Example, CSS Animations, CSS Animations, CSS Animations, Animated Effects, Canceling, Delaying, and Queuing Effects, Simple Effects, Custom Animations, Canceling, Delaying, and Queuing Effects, Canceling, Delaying, and Queuing Effects, jQuery Effects and Animation Methods

client-side libraries supporting, CSS Animations

creating using inline scripting of CSS, CSS Animations, CSS Animations

creating using jQuery, Animated Effects, Canceling, Delaying, and Queuing Effects, Simple Effects, Custom Animations, Canceling, Delaying, and Queuing Effects, Canceling, Delaying, and Queuing Effects

canceling, delaying, and queuing effects, Canceling, Delaying, and Queuing Effects

custom animations, Custom Animations, Canceling, Delaying, and Queuing Effects

simple effects, Simple Effects

CSS Transitions and Animations, CSS Example

jQuery methods for, jQuery Effects and Animation Methods

API-specific events, Types of Events

apostrophes, String Literals, Escape Sequences in String Literals

(see also ‘ ’ (quotation marks, single), under Symbols)

escaping in single-quoted strings, String Literals

append( ) method, Inserting and Replacing Elements, Building Blobs, void append(string text, [string endings]) , Constructor

BlobBuilder object, Building Blobs, void append(string text, [string endings])

FormData object, Constructor

jQuery, Inserting and Replacing Elements

appendChild( ), Node object, Inserting Nodes, Node appendChild(Node newChild)

appendData( ) method, Methods, void appendData(string text)

Comment node, Methods

Text node, void appendData(string text)

appendTo( ) method, jQuery, Inserting and Replacing Elements

Apple iPhone and iPad devices, gesture and touch events, Touchscreen and Mobile Events

<applet> elements, Getting and Setting Element Data

application cache, Application Storage and Offline Webapps, Cache Updates, The Application Cache Manifest, Cache Updates, Cache Updates, Cache Updates

creating application manifest file, The Application Cache Manifest

status property values, Cache Updates

updates, Cache Updates, Cache Updates

ApplicationCache object, Cache Updates, ApplicationCache, Constants, void swapCache() , void update() , Event Handlers

constants, values for status property, Constants

event handlers, Event Handlers

status property, Cache Updates

swapCache( ) method, void swapCache()

update( ) method, void update()

applicationCache property, Window object, Cache Updates, Properties

apply( ) and call( ), Function object, Indirect Invocation, The call() and apply() Methods, Subsets for Security

restrictions in secure subsets, Subsets for Security

apply( ) method, Function object, Arguments

appName property, The Navigator Object, Properties, Properties

Navigator object, The Navigator Object, Properties

WorkerNavigator object, Properties

appVersion property, The Navigator Object, Properties, Properties

Navigator object, The Navigator Object, Properties

WorkerNavigator object, Properties

arc( ), CanvasRenderingContext2D, Graphics in a <canvas>, Drawing and Filling Curves, void arc(double x, y,radius, startAngle,endAngle, [boolean anticlockwise])

arcTo( ), CanvasRenderingContext2D, Drawing and Filling Curves, void arcTo(double x1, y1, x2, y2, radius)

arguments (function), Function Arguments and Parameters, Variable-Length Argument Lists: The Arguments Object, Using Object Properties As Arguments

object properties as, Using Object Properties As Arguments

variable-length argument lists, Variable-Length Argument Lists: The Arguments Object

Arguments object, Variable-Length Argument Lists: The Arguments Object, The callee and caller properties, The length Property, Subsets for Security, Elements, Description, Description

callee and caller properties, The callee and caller properties

callee property, Description

length property, The length Property, Description

restriction in secure subsets, Subsets for Security

arguments property, Function object, Description

arguments[ ] array, Description

arithmetic expressions, Arithmetic Expressions, Bitwise Operators, The + Operator, Unary Arithmetic Operators, Bitwise Operators

+ operator, The + Operator

bitwise operators, Bitwise Operators

unary arithmetic operators, Unary Arithmetic Operators

arithmetic operators, Arithmetic in JavaScript, Operator Overview

arity (functions), Variable-Length Argument Lists: The Arguments Object, The length Property

array comprehensions, Array Comprehensions, Array Comprehensions, Generator Expressions

changing to generator expressions, Generator Expressions

syntax, Array Comprehensions

Array( ) constructor, Creating Arrays

array-like objects, Array-Like Objects, Strings As Arrays, Variable-Length Argument Lists: The Arguments Object, Document Elements As Window Properties, Relationships Between Frames, Selecting Elements by Type, Scripting CSS Classes, Queries and Query Results, Typed Arrays and ArrayBuffers

Arguments object, Variable-Length Argument Lists: The Arguments Object

DOMTokenList object, Scripting CSS Classes

frames property referring to, Relationships Between Frames

HTMLCollection objects, Selecting Elements by Type

jQuery, Queries and Query Results

typed arrays, Typed Arrays and ArrayBuffers

ArrayBuffer object, Typed Arrays and ArrayBuffers, Typed Arrays and ArrayBuffers, Reading Blobs, Reading Blobs, ArrayBuffer

byte ordering endianness, Typed Arrays and ArrayBuffers

