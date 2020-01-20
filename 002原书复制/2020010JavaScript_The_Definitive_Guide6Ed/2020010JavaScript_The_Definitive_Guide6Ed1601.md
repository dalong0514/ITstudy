The WebSocket API is surprisingly easy to use. First, create a socket with the WebSocket() constructor:

var socket = new WebSocket("ws://ws.example.com:1234/resource");

The argument to the WebSocket() constructor is a URL that uses the ws:// protocol (or wss:// for a secure connection like that used by https://). The URL specifies the host to connect to, and may also specify a port (WebSockets use the same default ports as HTTP and HTTPS) and a path or resource.

Once you have created a socket, you generally register event handlers on it:

socket.onopen = function(e) { /* The socket is now connected. */ }; socket.onclose = function(e) { /* The socket closed. */ }; socket.onerror = function(e) { /* Something went wrong! */ }; socket.onmessage = function(e) { var message = e.data; /* The server sent us a message. */ };

In order to send data to the server over the socket, you call the send() method of the socket:

socket.send("Hello, server!");

The current version of the WebSocket API supports only textual messages, and sends them as UTF-8 encoded strings. The current WebSocket protocol includes support for binary messages, however, and a future version of the API may allow binary data to be exchanged with a WebSocket server.

When your code is done communicating with the server, you can close a WebSocket by calling its close() method.

WebSocket is completely bidirectional, and once a WebSocket connection has been established, the client and server can send messages to each other at any time, and that communication does not have to take the form of requests and responses. Each WebSocket-based service will define its own「subprotocol」for transferring data between client and server. Over time, these「subprotocols」may evolve, and you may end up with clients and servers that need to support more than one version of a subprotocol. Fortunately, the WebSocket protocol includes a negotiation mechanism for choosing a subprotocol that both client and server can understand. You can pass an array of strings to the WebSocket() constructor. The server will take these as a list of the subprotocols that the client understands. It will pick one to use and send it back to the client. Once the connection is established, the client can determine which subprotocol is in use by checking the protocol property of the socket.

Comet with Server-Sent Events explained the EventSource API and demonstrated it with an online chat client and server. WebSockets make it even easier to write this kind of application. Example 22-16 is a very simple chat client: it is a lot like Example 18-15, but it uses a WebSocket for bidirectional communication instead of using an EventSource to receive messages and an XMLHttpRequest to send them.

Example 22-16. A WebSocket-based chat client

<script> window.onload = function() { // Take care of some UI details var nick = prompt("Enter your nickname"); // Get user's nickname var input = document.getElementById("input"); // Find the input field input.focus(); // Set keyboard focus // Open a WebSocket to send and receive chat messages on. // Assume that the HTTP server we were downloaded from also functions as // a websocket server, and use the same host name and port, but change // from the http:// protocol to ws:// var socket = new WebSocket("ws://" + location.host + "/"); // This is how we receive messages from the server through the web socket socket.onmessage = function(event) { // When a new message arrives var msg = event.data; // Get text from event object var node = document.createTextNode(msg); // Make it into a text node var div = document.createElement("div"); // Create a <div> div.appendChild(node); // Add text node to div document.body.insertBefore(div, input); // And add div before input input.scrollIntoView(); // Ensure input elt is visible } // This is how we send messages to the server through the web socket input.onchange = function() { // When user strikes return var msg = nick + ": " + input.value; // Username plus user's input socket.send(msg); // Send it through the socket input.value = ""; // Get ready for more input } }; </script> <!-- The chat UI is just a single, wide text input field --> <!-- New chat messages will be inserted before this element --> <input id="input" style="width:100%"/>

Example 22-17 is a WebSocket-based chat server intended to be run in Node (Asynchronous I/O with Node). You can compare this example to Example 18-17 to see that WebSockets simplify the server-side of the chat application as well as the client-side.

Example 22-17. A chat server using WebSockets and Node

/* * This is server-side JavaScript, intended to be run with NodeJS. * It runs a WebSocket server on top of an HTTP server, using an external * websocket library from https://github.com/miksago/node-websocket-server/ * If it gets an HTTP request for "/" it returns the chat client HTML file. * Any other HTTP requests return 404. Messages received via the * WebSocket protocol are simply broadcast to all active connections. */ var http = require('http'); // Use Node's HTTP server API var ws = require('websocket-server'); // Use an external WebSocket library // Read the source of the chat client at startup. Used below. var clientui = require('fs').readFileSync("wschatclient.html"); // Create an HTTP server var httpserver = new http.Server(); // When the HTTP server gets a new request, run this function httpserver.on("request", function (request, response) { // If the request was for "/", send the client-side chat UI. if (request.url === "/") { // A request for the chat UI response.writeHead(200, {"Content-Type": "text/html"}); response.write(clientui); response.end(); } else { // Send a 404 "Not Found" code for any other request response.writeHead(404); response.end(); } }); // Now wrap a WebSocket server around the HTTP server var wsserver = ws.createServer({server: httpserver}); // Call this function when we receive a new connection request wsserver.on("connection", function(socket) { socket.send("Welcome to the chat room."); // Greet the new client socket.on("message", function(msg) { // Listen for msgs from the client wsserver.broadcast(msg); // And broadcast them to everyone }); }); // Run the server on port 8000. Starting the WebSocket server starts the // HTTP server as well. Connect to http://localhost:8000/ to use it. wsserver.listen(8000);

Part III. Core JavaScript Reference

This part of the book is a reference that documents the classes, methods, and properties defined by the core JavaScript language. This reference is arranged alphabetically by class or object name:

Arguments EvalError Number String

Array Function Object SyntaxError

Boolean Global RangeError TypeError

Date JSON ReferenceError URIError

Error Math RegExp

The reference pages for the methods and properties of classes are alphabetized by their full names, which include the names of the classes that define them. For example, if you want to read about the replace() method of the String class, you would look under String.replace(), not just replace.

Core JavaScript defines some global functions and properties, such as eval() and NaN. Technically, these are properties of the global object. Since the global object has no name, however, they are listed in this reference section under their own unqualified names. For convenience, the full set of global functions and properties in core JavaScript is summarized in a special reference page named「Global」(even though there is no object or class by that name).

Core JavaScript Reference

* * *

Name

arguments[ ] — an array of function arguments

Synopsis

arguments

Description

The arguments[] array is defined only within a function body. Within the body of a function, arguments refers to the Arguments object for the function. This object has numbered properties and serves as an array containing all arguments passed to the function. The arguments identifier is essentially a local variable automatically declared and initialized within every function. It refers to an Arguments object only within the body of a function and is undefined in global code.

See Also

Arguments; Chapter 8

Name

Arguments — arguments and other properties of a function

Inherits from

Object → Arguments

Synopsis

arguments arguments[n]

Elements

The Arguments object is defined only within a function body. Although it is not technically an array, the Arguments object has numbered properties that function as array elements and a length property that specifies the number of array elements. Its elements are the values that are passed as arguments to the function. Element 0 is the first argument, element 1 is the second argument, and so on. All values passed as arguments become array elements of the Arguments object, whether or not those arguments are given names in the function declaration.

Properties

callee

A reference to the function that is currently executing.

length

The number of arguments passed to the function and the number of array elements in the Arguments object.

Description

When a function is invoked, an Arguments object is created for it, and the local variable arguments is automatically initialized to refer to that Arguments object. The main purpose of the Arguments object is to provide a way to determine how many arguments are passed to the function and to refer to unnamed arguments. In addition to the array elements and length property, however, the callee property allows an unnamed function to refer to itself.

For most purposes, the Arguments object can be thought of as an array with the addition of the callee property. However, it is not an instance of Array, and the Arguments.length property does not have any of the special behaviors of the Array.length property and cannot be used to change the size of the array.

In non-strict mode, the Arguments object has one very unusual feature. When a function has named arguments, the array elements of the Arguments object are synonyms for the local variables that hold the function arguments. The Arguments object and the argument names provide two different ways of referring to the same variable. Changing the value of an argument with an argument name changes the value that is retrieved through the Arguments object, and changing the value of an argument through the Arguments object changes the value that is retrieved by the argument name.

See Also

Function; Chapter 8

Name

Arguments.callee — the function that is currently running

Availability

not defined in strict mode

Synopsis

arguments.callee

Description

arguments.callee refers to the function that is currently running. It provides a way for an unnamed function to refer to itself. This property is defined only within a function body.

Example

// An unnamed function literal uses the callee property to refer // to itself so that it can be recursive var factorial = function(x) { if (x < 2) return 1; else return x * arguments.callee(x-1); } var y = factorial(5); // Returns 120

Name

Arguments.length — the number of arguments passed to a function

Synopsis

arguments.length

Description

The length property of the Arguments object specifies the number of arguments passed to the current function. This property is defined only within a function body.

Note that this property specifies the number of arguments actually passed, not the number expected. See Function.length for the number of declared arguments. Note also that this property does not have any of the special behavior of the Array.length property.

Example

// Use an Arguments object to check that correct # of args were passed function check(args) { var actual = args.length; // The actual number of arguments var expected = args.callee.length; // The expected number of arguments if (actual != expected) { // Throw exception if they don't match throw new Error("Wrong number of arguments: expected: " + expected + "; actually passed " + actual); } } // A function that demonstrates how to use the function above function f(x, y, z) { check(arguments); // Check for correct number of arguments return x + y + z; // Now do the rest of the function normally }

See Also

Array.length, Function.length

Name

Array — built-in support for arrays

Inherits from

Object → Array

Constructor

new Array() new Array(size) new Array(element0, element1, ..., elementn)

Arguments

size

The desired number of elements in the array. The returned array has its length field set to size.

element0, ... elementn

An argument list of two or more arbitrary values. When the Array() constructor is invoked with these arguments, the newly created array is initialized with the specified argument values as its elements and its length field set to the number of arguments.

Returns

The newly created and initialized array. When Array() is invoked with no arguments, the returned array is empty and has a length field of 0. When invoked with a single numeric argument, the constructor returns an array with the specified number of undefined elements. When invoked with any other arguments, the constructor initializes the array with the values specified by the arguments. When the Array() constructor is called as a function, without the new operator, it behaves exactly as it does when called with the new operator.

Throws

RangeError

When a single integer size argument is passed to the Array() constructor, a RangeError exception is thrown if size is negative or is larger than 232−1.

Literal Syntax

ECMAScript v3 specifies an array literal syntax. You may also create and initialize an array by placing a comma-separated list of expressions within square brackets. The values of these expressions become the elements of the array. For example:

var a = [1, true, 'abc']; var b = [a[0], a[0]*2, f(x)];

Properties

length

A read/write integer specifying the number of elements in the array or, when the array does not have contiguous elements, a number one larger than the index of the last element in the array. Changing the value of this property truncates or extends the array.

Methods

The methods every(), filter(), forEach(), indexOf(), lastIndexOf(), map(), reduce(), reduceRight(), and some() are new in ECMAScript 5 but were implemented by browsers other than IE before ES5 was standardized.

concat()

Concatenates elements to an array.

every()

Test whether a predicate is true for every array element.

filter()

Return array elements that satisfy a predicate function.

forEach()

Invoke a function for each element of the array.

indexOf()

Search an array for a matching element.

join()

Converts all array elements to strings and concatenates them.

lastIndexOf()

Search backward through an array.

map()

Compute new array elements from the elements of this array.

pop()

Removes an item from the end of an array.

push()

Pushes an item to the end of an array.

reduce()

Compute a value from the elements of this array.

reduceRight()

Reduce this array from right-to-left.

reverse()

Reverses, in place, the order of the elements of an array.

shift()

Shifts an element off the beginning of an array.

slice()

Returns a subarray slice of an array.

some()

Test whether a predicate is true for at least one element of this array.

sort()

Sorts, in place, the elements of an array.

splice()

Inserts, deletes, or replaces array elements.

toLocaleString()

Converts an array to a localized string.

toString()

Converts an array to a string.

unshift()

Inserts elements at the beginning of an array.

Description

Arrays are a basic feature of JavaScript and are documented in detail in Chapter 7.

See Also

Chapter 7

Name

Array.concat() — concatenate arrays

Synopsis

array.concat(value, ...)

Arguments

value, ...

Any number of values to be concatenated with array.

Returns

A new array, which is formed by concatenating each of the specified arguments to array.

Description

concat() creates and returns a new array that is the result of concatenating each of its arguments to array. It does not modify array. If any of the arguments to concat() is itself an array, the elements of that array are concatenated, rather than the array itself.

Example

var a = [1,2,3]; a.concat(4, 5) // Returns [1,2,3,4,5] a.concat([4,5]); // Returns [1,2,3,4,5] a.concat([4,5],[6,7]) // Returns [1,2,3,4,5,6,7] a.concat(4, [5,[6,7]]) // Returns [1,2,3,4,5,[6,7]]

See Also

Array.join(), Array.push(), Array.splice()

Name

Array.every() — test whether a predicate is true for every element

Availability

ECMAScript 5

Synopsis

array.every(predicate) array.every(predicate, o)

Arguments

predicate

A predicate function to test array elements

o

The optional this value for invocations of predicate.

Returns

true if predicate returns true (or any truthy value) for every element of array or false if the predicate returns false (or a falsy value) for any element.

Description

The every() method tests whether some condition holds for all elements of an array. It loops through the elements of array, in ascending order, and invokes the specified predicate function on each element in turn. If predicate returns false (or any value that converts to false), then every() stops looping and returns false immediately. If every invocation of predicate returns true, then every() returns true. When invoked on an empty array, every() returns true.

For each array index i, predicate is invoked with three arguments:

predicate(array[i], i, array)

The return value of predicate is interpreted as a boolean value. true and all truthy values indicate that the array element passes the test or meets the condition described by that function. A return value of false or any falsy value means that the array element does not pass the test.

See Array.forEach() for further details.

Example

[1,2,3].every(function(x) { return x < 5; }) // => true: all elts are < 5 [1,2,3].every(function(x) { return x < 3; }) // => false: all elts are not < 3 [].every(function(x) { return false; }); // => true: always true for []

See Also

Array.filter(), Array.forEach(), Array.some()

Name

Array.filter() — return array elements that pass a predicate

Availability

ECMAScript 5

Synopsis

array.map(predicate) array.map(predicate, o)

Arguments

predicate

The function to invoke to determine whether an element of array will be included in the returned array.

o

An optional value on which predicate is invoked.

Returns

A new array containing only those elements of array for which predicate returned true (or a truthy value).

Description

filter() creates a new array and then populates it with the elements of array for which the predicate function returns true (or a truthy value). The filter() method does not modify array itself (though the predicate function may do so).

filter() loops through the indexes of array, in ascending order, and invokes predicate once for each element. For an index i, predicate is invoked with three arguments,

predicate(array[i], i, array)

If predicate returns true or a truthy value, then the element at index i of array is appended to the newly created array. Once filter() has tested each element of array it returns the new array.

See Array.forEach() for further details.

Example

[1,2,3].filter(function(x) { return x > 1; }); // => [2,3]

See Also

Array.every(), Array.forEach(), Array.indexOf(), Array.map(), Array.reduce()

Name

Array.forEach() — invoke a function for each array element

Availability

ECMAScript 5

Synopsis

array.forEach(f) array.forEach(f, o)

Arguments

f

The function to invoke for each element of array.

o

An optional value on which f is invoked.

Returns

This method returns nothing.

Description

forEach() loops through the indexes of array, in ascending order, and invokes f once for each element. For an index i, f is invoked with three arguments:

f(array[i], i, array)

The return value, if any, of f is ignored. Note that forEach() does not have a return value. In particular, it does not return array.

Array Method Details

The following details apply to the forEach() method, and also to the related methods map(), filter(), every(), and some().

Each of these methods expects a function as its first argument and accepts an optional second argument. If a second argument o is specified, then the function is invoked as if it was a method of o. That is, within the body of the function, this will evaluate to o. If the second argument is not specified, then the function is invoked as a function (not a method) and this will be the global object in non-strict code or null in strict code.

Each of these methods notes the length of array before it begins looping. If the invoked function appends new elements to array, those newly-added elements will not be looped over. If the function alters existing elements that have not yet been looped over, it is the altered values that will be passed.

When invoked on sparse arrays, these methods do not invoke the function for indexes at which no element actually exists.

Example

var a = [1,2,3]; a.forEach(function(x,i,a) { a[i]++; }); // a is now [2,3,4]

See Also

Array.every(), Array.filter(), Array.indexOf(), Array.map(), Array.reduce()

Name

Array.indexOf() — search an array

Availability

ECMAScript 5

Synopsis

array.indexOf(value) array.indexOf(value, start)

Arguments

value

The value to search array for.

start

An optional array index at which to begin the search. If omitted, 0 is used.

Returns

The lowest index >= start of array at which the element is === to value, or -1 if no such matching element exists.

Description

This method searches array for an element that is equal to value, and returns the index of the first element it finds. The search begins at the array index specified by start, or at index 0, and continues with successively higher indexes until a match is found or all elements have been checked. The === operator is used to test equality. The return value is the index of the first matching element found, or -1 if no match is found.

Example

['a','b','c'].indexOf('b') // => 1 ['a','b','c'].indexOf('d') // => -1 ['a','b','c'].indexOf('a',1) // => -1

See Also

Array.lastIndexOf(), String.indexOf()

Name

Array.join() — concatenate array elements to form a string

Synopsis

array.join() array.join(separator)

Arguments

separator

An optional character or string used to separate one element of the array from the next in the returned string. If this argument is omitted, a comma is used.

Returns

The string that results from converting each element of array to a string and then concatenating them together, with the separator string between elements.

Description

join() converts each element of an array to a string and then concatenates those strings, inserting the specified separator string between the elements. It returns the resulting string.

You can perform a conversion in the opposite direction—splitting a string into array elements—with the split() method of the String object. See String.split() for details.

Example

a = new Array(1, 2, 3, "testing"); s = a.join("+"); // s is the string "1+2+3+testing"

See Also

String.split()

Name

Array.lastIndexOf() — search backward through an array

Availability

ECMAScript 5

Synopsis

array.lastIndexOf(value) array.lastIndexOf(value, start)

Arguments

value

The value to search array for.

start

An optional array index at which to begin the search. If omitted, the search begins with the last element of the array.

Returns

The highest index <= start of array at which the element is === to value, or -1 if no such matching element exists.

Description

This method searches backward through successively lower elements of array for an element that is equal to value, and returns the index of the first such element it finds. If start is specified, it is used as the starting position for the search; otherwise the search begins at the end of the array. The === operator is used to test equality. The return value is the index of the first matching element found, or -1 if no match is found.

See Also

Array.indexOf(), String.lastIndexOf()

Name

Array.length — the size of an array

Synopsis

array.length

Description

The length property of an array is always one larger than the index of the highest element defined in the array. For traditional「dense」arrays that have contiguous elements and begin with element 0, the length property specifies the number of elements in the array.

The length property of an array is initialized when the array is created with the Array() constructor method. Adding new elements to an array updates the length, if necessary:

a = new Array(); // a.length initialized to 0 b = new Array(10); // b.length initialized to 10 c = new Array("one", "two", "three"); // c.length initialized to 3 c[3] = "four"; // c.length updated to 4 c[10] = "blastoff"; // c.length becomes 11

You can set the value of the length property to change the size of an array. If you set length to be smaller than its previous value, the array is truncated, and elements at the end are lost. If you set length to be larger than its previous value, the array becomes bigger, and the new elements added at the end of the array have the undefined value.

Name

Array.map() — compute new array elements from old

Availability

ECMAScript 5

Synopsis

array.map(f) array.map(f, o)

Arguments

f

The function to invoke for each element of array. Its return values become elements of the returned array.

o

An optional value on which f is invoked.

Returns

A new array with elements computed by the function f.

Description

map() creates a new array with the same length as array, and computes the elements of this new array by passing the elements of array to the function f. map() loops through the indexes of array, in ascending order, and invokes f once for each element. For an index i, f is invoked with three arguments, and its return value is stored at index i of the newly created array:

a[i] = f(array[i], i, array)

Once map() has passed each element of array to f and has stored the results in the new array, it returns that new array.

See Array.forEach() for further details.

Example

[1,2,3].map(function(x) { return x*x; }); // => [1,4,9]

See Also

Array.every(), Array.filter(), Array.forEach(), Array.indexOf(), Array.reduce()

Name

Array.pop() — remove and return the last element of an array

Synopsis

array.pop()

Returns

The last element of array.

Description

pop() deletes the last element of array, decrements the array length, and returns the value of the element that it deleted. If the array is already empty, pop() does not change the array and returns the undefined value.

Example

pop(), and its companion method push(), provide the functionality of a first-in, last-out stack. For example:

var stack = []; // stack: [] stack.push(1, 2); // stack: [1,2] Returns 2 stack.pop(); // stack: [1] Returns 2 stack.push([4,5]); // stack: [1,[4,5]] Returns 2 stack.pop() // stack: [1] Returns [4,5] stack.pop(); // stack: [] Returns 1

See Also

Array.push()

Name

Array.push() — append elements to an array

Synopsis

array.push(value, ...)

Arguments

value, ...

One or more values to be appended to the end of array.

Returns

The new length of the array, after the specified values are appended to it.

Description

push() appends its arguments, in order, to the end of array. It modifies array directly, rather than creating a new array. push(), and its companion method pop(), use arrays to provide the functionality of a first in, last out stack. See Array.pop() for an example.

See Also

Array.pop()

Name

Array.reduce() — compute a value from the elements of an array

Availability

ECMAScript 5

Synopsis

array.reduce(f) array.reduce(f, initial)

Arguments

f

A function that combines two values (such as two array elements) and returns a new「reduced」value.

initial

An optional initial value to seed the array reduction with. If this argument is specified, reduce() behaves as if it had been inserted at the start of array.

Returns

The reduced value of the array, which is the return value of the last invocation of f.

Description

The reduce() method expects a function f as its first argument. This function should behave like a binary operator: it takes two values, performs some operation on them and returns a result. If array has n elements, the reduce() method invokes f n-1 times to reduce those elements to a single combined value. (You may be familiar with this array reduction operation from other programming languages where it is sometimes called「fold」or「inject」.)

The first invocation of f is passed the first two elements of array. Each subsequent invocation of f is passed the return value of the previous invocation and the next element (in ascending order) of array. The return value of the final invocation of f becomes the return value of the reduce() method itself.

reduce() may be invoked with an optional second argument, initial. If initial is specified, then reduce() behaves as if that argument has been inserted at the beginning of array (it does not actually modify array, however). Another way to say this is that if reduce() is invoked with two arguments, then initial is used as if it had previously been returned from f. In this case, the first invocation of f is passed initial and the first element of array. When initial is specified, there are n+1 elements to reduce (n elements of array, plus the initial value) and f is invoked n times.

If array is empty and initial is not specified, reduce() throws a TypeError. If array is empty and initial is specified, then reduce() returns initial and never calls f. If array has only a single element and initial is not specified, then reduce() returns the single element of array without calling f.

The paragraphs above describe two arguments to f, but reduce() actually invokes that function with four arguments. The third argument is the array index of the second argument. The fourth argument is array itself. f is always invoked as a function, not as a method.

Example

[1,2,3,4].reduce(function(x,y) { return x*y; }) // => 24: ((1*2)*3)*4

See Also

Array.forEach(), Array.map(), Array.reduceRight()

Name

Array.reduceRight() — reduce an array from right-to-left

Availability

ECMAScript 5

Synopsis

array.reduceRight(f) array.reduceRight(f, initial)

Arguments

f

A function that combines two values (such as two array elements) and returns a new「reduced」value.

initial

An optional initial value to seed the array reduction with. If this argument is specified, reduceRight() behaves as if it had been inserted at the end of array.

Returns

The reduced value of the array, which is the return value of the last invocation of f.

Description

reduceRight() works like the reduce() method: it invokes the function f n-1 times to reduce the n elements of array to a single value. reduceRight() differs from reduce() only in that it enumerates array elements from right to left (from highest index to lowest) rather than left to right. See Array.reduce() for details.

Example

[2, 10, 60].reduceRight(function(x,y) { return x/y }) // => 3: (60/10)/2

See Also

Array.reduce()

Name

Array.reverse() — reverse the elements of an array

Synopsis

array.reverse()

Description

The reverse() method of an Array object reverses the order of the elements of an array. It does this in place: it rearranges the elements of the specified array without creating a new array. If there are multiple references to array, the new order of the array elements is visible through all references.

Example

a = new Array(1, 2, 3); // a[0] == 1, a[2] == 3; a.reverse(); // Now a[0] == 3, a[2] == 1;

Name

Array.shift() — shift array elements down

Synopsis

array.shift()

Returns

The former first element of the array.

Description

shift() removes and returns the first element of array, shifting all subsequent elements down one place to occupy the newly vacant space at the start of the array. If the array is empty, shift() does nothing and returns the undefined value. Note that shift() does not create a new array; instead, it modifies array directly.

