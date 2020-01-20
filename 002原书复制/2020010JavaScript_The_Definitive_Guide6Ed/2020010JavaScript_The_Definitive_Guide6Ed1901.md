decodeURIComponent() is a global function that returns a decoded copy of its s argument. It reverses the encoding performed by encodeURIComponent(). See that function’s reference page for details.

See Also

decodeURI(), encodeURI(), encodeURIComponent(), escape(), unescape()

Name

encodeURI() — escape characters in a URI

Synopsis

encodeURI(uri)

Arguments

uri

A string that contains the URI or other text to be encoded.

Returns

A copy of uri, with certain characters replaced by hexadecimal escape sequences.

Throws

URIError

Indicates that uri contains malformed Unicode surrogate pairs and cannot be encoded.

Description

encodeURI() is a global function that returns an encoded copy of its uri argument. ASCII letters and digits are not encoded, nor are the following ASCII punctuation characters:

- _ . ! ~ * ' ( )

Because encodeURI() is intended to encode complete URIs, the following ASCII punctuation characters, which have special meaning in URIs, are not escaped either:

; / ? : @ & = + $ , #

Any other characters in uri are replaced by converting each character to its UTF-8 encoding and then encoding each of the resulting one, two, or three bytes with a hexadecimal escape sequence of the form %xx. In this encoding scheme, ASCII characters are replaced with a single %xx escape, characters with encodings between \u0080 and \u07ff are replaced with two escape sequences, and all other 16-bit Unicode characters are replaced with three escape sequences.

If you use this method to encode a URI, you should be certain that none of the components of the URI (such as the query string) contain URI separator characters such as ? and #. If the components have to contain these characters, you should encode each component separately with encodeURIComponent().

Use decodeURI() to reverse the encoding applied by this method. Prior to ECMAScript v3, you can use escape() and unescape() methods (which are now deprecated) to perform a similar kind of encoding and decoding.

Example

// Returns http://www.isp.com/app.cgi?arg1=1&arg2=hello%20world encodeURI("http://www.isp.com/app.cgi?arg1=1&arg2=hello world"); encodeURI("\u00a9"); // The copyright character encodes to %C2%A9

See Also

decodeURI(), decodeURIComponent(), encodeURIComponent(), escape(), unescape()

Name

encodeURIComponent() — escape characters in a URI component

Synopsis

encodeURIComponent(s)

Arguments

s

A string that contains a portion of a URI or other text to be encoded.

Returns

A copy of s, with certain characters replaced by hexadecimal escape sequences.

Throws

URIError

Indicates that s contains malformed Unicode surrogate pairs and cannot be encoded.

Description

encodeURIComponent() is a global function that returns an encoded copy of its s argument. ASCII letters and digits are not encoded, nor are the following ASCII punctuation characters:

- _ . ! ~ * ' ( )

All other characters, including punctuation characters such as /, :, and # that serve to separate the various components of a URI, are replaced with one or more hexadecimal escape sequences. See encodeURI() for a description of the encoding scheme used.

Note the difference between encodeURIComponent() and encodeURI(): encodeURIComponent() assumes that its argument is a portion (such as the protocol, hostname, path, or query string) of a URI. Therefore it escapes the punctuation characters that are used to separate the portions of a URI.

Example

encodeURIComponent("hello world?"); // Returns hello%20world%3F

See Also

decodeURI(), decodeURIComponent(), encodeURI(), escape(), unescape()

Name

Error — a generic exception

Inherits from

Object → Error

Constructor

new Error() new Error(message)

Arguments

message

An optional error message that provides details about the exception.

Returns

A newly constructed Error object. If the message argument is specified, the Error object uses it as the value of its message property; otherwise, it uses an implementation-defined default string as the value of that property. When the Error() constructor is called as a function, without the new operator, it behaves just as it does when called with the new operator.

Properties

message

An error message that provides details about the exception. This property holds the string passed to the constructor or an implementation-defined default string.

name

A string that specifies the type of the exception. For instances of the Error class and all of its subclasses, this property specifies the name of the constructor used to create the instance.

Methods

toString()

Returns an implementation-defined string that represents this Error object.

Description

Instances of the Error class represent errors or exceptions and are typically used with the throw and try/catch statements. The name property specifies the type of the exception, and the message property can provide human-readable details about the exception.

The JavaScript interpreter never throws Error objects directly; instead, it throws instances of one of the Error subclasses, such as SyntaxError or RangeError. In your own code, you may find it convenient to throw Error objects to signal exceptions, or you may prefer to simply throw an error message or error code as a primitive string or number value.

Note that the ECMAScript specification defines a toString() method for the Error class (it is inherited by each of the subclasses of Error) but that it does not require this toString() method to return a string that contains the contents of the message property. Therefore, you should not expect the toString() method to convert an Error object to a meaningful, human-readable string. To display an error message to a user, you should explicitly use the name and message properties of the Error object.

Examples

You might signal an exception with code like the following:

function factorial(x) { if (x < 0) throw new Error("factorial: x must be >= 0"); if (x <= 1) return 1; else return x * factorial(x-1); }

And if you catch an exception, you might display its to the user with code like the following (which uses the client-side Window.alert() method):

try { &*(&/* an error is thrown here */ } catch(e) { if (e instanceof Error) { // Is it an instance of Error or a subclass? alert(e.name + ": " + e.message); } }

See Also

EvalError, RangeError, ReferenceError, SyntaxError, TypeError, URIError

Name

Error.message — a human-readable error message

Synopsis

error.message

Description

The message property of an Error object (or of an instance of any subclass of Error) is intended to contain a human-readable string that provides details about the error or exception that occurred. If a message argument is passed to the Error() constructor, this message becomes the value of the message property. If no message argument is passed, an Error object inherits an implementation-defined default value (which may be the empty string) for this property.

Name

Error.name — the type of an error

Synopsis

error.name

Description

The name property of an Error object (or of an instance of any subclass of Error) specifies the type of error or exception that occurred. All Error objects inherit this property from their constructor. The value of the property is the same as the name of the constructor. Thus SyntaxError objects have a name property of「SyntaxError」, and EvalError objects have a name of「EvalError」.

Name

Error.toString() — convert an Error object to a string

Inherits from

Overrides Object.toString()

Synopsis

error. toString()

Returns

An implementation-defined string. The ECMAScript standard does not specify anything about the return value of this method, except that it is a string. Notably, it does not require the returned string to contain the error name or the error message.

Name

escape() — encode a string

Availability

deprecated

Synopsis

escape(s)

Arguments

s

The string that is to be「escaped」or encoded.

Returns

An encoded copy of s in which certain characters have been replaced by hexadecimal escape sequences.

Description

escape() is a global function. It returns a new string that contains an encoded version of s. The string s itself is not modified.

escape() returns a string in which all characters of s other than ASCII letters, digits, and the punctuation characters @, *, _, +, -, ., and / have been replaced by escape sequences of the form % xx or %u xxxx (where x represents a hexadecimal digit). Unicode characters \u0000 to \u00ff are replaced with the % xx escape sequence, and all other Unicode characters are replaced with the %u xxxx sequence.

Use the unescape() function to decode a string encoded with escape().

Although the escape() function was standardized in the first version of ECMAScript, it was deprecated and removed from the standard by ECMAScript v3. Implementations of ECMAScript are likely to implement this function, but they are not required to. You should use encodeURI() and encodeURIComponent() instead of escape().

Example

escape("Hello World!"); // Returns "Hello%20World%21"

See Also

encodeURI(), encodeURIComponent()

Name

eval() — execute JavaScript code from a string

Synopsis

eval(code)

Arguments

code

A string that contains the JavaScript expression to be evaluated or the statements to be executed.

Returns

The value of the evaluated code, if any.

Throws

eval() throws a SyntaxError if code is not legal JavaScript code. If the evaluation of code raises an error, eval() propagates that error.

Description

eval() is a global method that evaluates a string of JavaScript code. If code contains an expression, eval evaluates the expression and returns its value. (Some expressions, such as object and function literals look like statements and must be enclosed in parentheses when passed to eval() in order to resolve the ambiguity.) If code contains a JavaScript statement or statements, eval() executes those statements and returns the value, if any, returned by the last statement. If code does not return any value, eval() returns undefined. Finally, if code throws an exception, eval() passes that exception on to the caller.

eval() behaves different in ECMAScript 3 and ECMAScript 5, and in ECMAScript 5, it behaves differently in strict mode and non-strict mode, and a minor digression is necessary in order to explain these differences. It is much easier to implement efficient interpreters when a programming language defines eval as an operator instead of as a function. JavaScript’s eval is a function, but for the sake of efficiency, the language draws a distinction between direct, operator-like calls to eval() and indirect calls. A direct call uses the identifier eval directly and, if you removed the parentheses, it would look like eval was an operator. Any other invocation of eval() is an indirect call. If you assign the eval() function to a variable with a different name and invoke it through that variable, it is an indirect call. Similarly, if you invoke eval() as a method of the global object, it is an indirect call.

With that distinction between direct and indirect calls made, we can document the behavior of eval() like this:

Direct call, ES3 and ES5 non-strict mode

eval() evaluates code in the current lexical scope. If code contains variable or function declarations they are defined in the local scope. This is the normal use-case for eval().

Indirect call, ES3

The ECMAScript 3 specification allows interpreters to throw an EvalError for any indirect call to eval(). Implementations of ES3 don’t generally do this in practice, but indirect calls should be avoided.

Indirect call, ES5

In ECMAScript 5, indirect calls to eval() must not throw an EvalError, and instead must evaluate code in the global scope, ignoring any local variables in the current lexical scope. In ES5, we can assign var geval = eval;, then we can use geval() to evaluate code in the global scope.

Direct or Indirect call, strict mode

In strict mode variable and function definitions in code are defined in a private scope that lasts only for the duration of the eval() call. This means that direct calls to eval() in strict mode cannot alter the lexical scope and indirect calls in strict mode cannot alter the global scope. These rules apply if the invocation of eval() is in strict mode, or if code begins with a「use strict」directive.

eval() provides a very powerful capability to the JavaScript language, but its use is infrequent in real-world programs. Obvious uses are to write programs that act as recursive JavaScript interpreters and to write programs that dynamically generate and evaluate JavaScript code.

Most JavaScript functions that expect string arguments convert whatever value they are passed to a string before proceeding. eval() does not behave like this: if code is not a primitive string value, it is simply returned unchanged. Be careful, therefore, that you do not inadvertently pass a String object to eval() when you intended to pass a primitive string value.

Example

eval("1+2"); // Returns 3 // This code uses client-side JavaScript methods to prompt the user to // enter an expression and to display the results of evaluating it. // See the client-side methods Window.alert() and Window.prompt() for details. try { alert("Result: " + eval(prompt("Enter an expression:",""))); } catch(exception) { alert(exception); }

Name

EvalError — thrown when eval() is used improperly

Inherits from

Object → Error → EvalError

Constructor

new EvalError() new EvalError(message)

Arguments

message

An optional error message that provides details about the exception. If specified, this argument is used as the value for the message property of the EvalError object.

Returns

A newly constructed EvalError object. If the message argument is specified, the Error object uses it as the value of its message property; otherwise, it uses an implementation-defined default string as the value of that property. When the EvalError() constructor is called as a function without the new operator, it behaves just as it does when called with the new operator.

Properties

message

An error message that provides details about the exception. This property holds the string passed to the constructor or an implementation-defined default string. See Error.message for details.

name

A string that specifies the type of the exception. All EvalError objects inherit the value「EvalError」for this property.

Description

An instance of the EvalError class may be thrown when the global function eval() is invoked under any other name. See eval() for an explanation of the restrictions on how this function may be invoked. See Error for details about throwing and catching exceptions.

See Also

Error, Error.message, Error.name

Name

Function — a JavaScript function

Inherits from

Object → Function

Synopsis

functionfunctionname(argument_name_list) // Function definition statement { body } function (argument_name_list) {body} // Unnamed function literal functionname(argument_value_list) // Function invocation

Constructor

new Function(argument_names..., body)

Arguments

argument_names...

Any number of string arguments, each naming one or more arguments of the Function object being created.

body

A string that specifies the body of the function. It may contain any number of JavaScript statements, separated with semicolons, and may refer to any of the argument names specified by previous arguments to the constructor.

Returns

A newly created Function object. Invoking the function executes the JavaScript code specified by body.

Throws

SyntaxError

Indicates that there was a JavaScript syntax error in the body argument or in one of the argument_names arguments.

Properties

arguments[]

An array of arguments that were passed to the function. Deprecated.

caller

A reference to the Function object that invoked this one, or null if the function was invoked from top-level code. Deprecated.

length

The number of named arguments specified when the function was declared.

prototype

An object which, for a constructor function, defines properties and methods shared by all objects created with that constructor function.

Methods

apply()

Invokes a function as a method of a specified object, passing a specified array of arguments.

bind()

Return a new function that invokes this one as a method of the specified object with the optionally specified arguments.

call()

Invokes a function as a method of a specified object, passing the specified arguments.

toString()

Returns a string representation of the function.

Description

A function is a fundamental datatype in JavaScript. Chapter 8 explains how to define and use functions, and Chapter 9 covers the related topics of methods, constructors, and the prototype property of functions. See those chapters for complete details. Note that although function objects may be created with the Function() constructor described here, this is not efficient, and the preferred way to define functions, in most cases, is with a function definition statement or a function literal.

In JavaScript 1.1 and later, the body of a function is automatically given a local variable, named arguments, that refers to an Arguments object. This object is an array of the values passed as arguments to the function. Don’t confuse this with the deprecated arguments[] property listed earlier. See the Arguments reference page for details.

See Also

Arguments; Chapter 8, Chapter 9

Name

Function.apply() — invoke a function as a method of an object

Synopsis

function.apply(thisobj, args)

Arguments

thisobj

The object to which function is to be applied. In the body of the function, thisobj becomes the value of the this keyword. If this argument is null, the global object is used.

args

An array of values to be passed as arguments to function.

Returns

Whatever value is returned by the invocation of function.

Throws

TypeError

If this method is invoked on an object that is not a function or if this method is invoked with an args argument that is not an array or an Arguments object.

Description

apply() invokes the specified function as if it were a method of thisobj, passing it the arguments contained in the args array. It returns the value returned by the function invocation. Within the body of the function, the this keyword refers to the thisobj object.

The args argument must be an array or an Arguments object. Use Function.call() instead if you want to specify the arguments to pass to the function individually instead of as array elements.

Example

// Apply the default Object.toString() method to an object that // overrides it with its own version of the method. Note no arguments. Object.prototype.toString.apply(o); // Invoke the Math.max() method with apply to find the largest // element in an array. Note that first argument doesn't matter // in this case. var data = [1,2,3,4,5,6,7,8]; Math.max.apply(null, data);

See Also

Function.call()

Name

Function.arguments[] — arguments passed to a function

Availability

deprecated

Synopsis

function.arguments[i] function.arguments.length

Description

The arguments property of a Function object is an array of the arguments that are passed to a function. It is defined only while the function is executing. arguments.length specifies the number of elements in the array.

This property is deprecated in favor of the Arguments object; it should never be used in new JavaScript code.

See Also

Arguments

Name

Function.bind() — return a function that invokes this as a method

Availability

ECMAScript 5

Synopsis

function.bind(o) function.bind(o, args...)

Arguments

o

The object to which this function should be bound.

args...

Zero or more argument values that will also be bound.

Returns

A new function which invokes this function as a method of o and passes it the arguments args.

Description

The bind() method returns a new function which invokes this function as a method of the object o. The arguments passed to this function consist of the args passed to bind() followed by whatever values are passed to the new function.

Example

Suppose that f is a function and we call the bind() method like this:

var g = f.bind(o, 1, 2);

Now g is a new function and the invocation g(3) is equivalent to:

f.call(o, 1, 2, 3);

See Also

Function.apply(), Function.call(), The bind() Method

Name

Function.call() — invoke a function as a method of an object

Synopsis

function.call(thisobj, args...)

Arguments

thisobj

The object on which function is to be invoked. In the body of the function, thisobj becomes the value of the this keyword. If this argument is null, the global object is used.

args...

Any number of arguments, which will be passed as arguments to function.

Returns

Whatever value is returned by the invocation of function.

Throws

TypeError

If this method is invoked on an object that is not a function.

Description

call() invokes the specified function as if it were a method of thisobj, passing it any arguments that follow thisobj in the argument list. The return value of call() is the value returned by the function invocation. Within the body of the function, the this keyword refers to the thisobj object, or to the global object if thisobj is null.

Use Function.apply() instead if you want to specify the arguments to pass to the function in an array.

Example

// Call the default Object.toString() method on an object that // overrides it with its own version of the method. Note no arguments. Object.prototype.toString.call(o);

See Also

Function.apply()

Name

Function.caller — the function that called this one

Availability

deprecated; not defined in strict mode

Synopsis

function.caller

Description

In early versions of JavaScript, the caller property of a Function object is a reference to the function that invoked the current one. If the function is invoked from the top level of a JavaScript program, caller is null. This property may be used only from within the function (i.e., the caller property is only defined for a function while that function is executing).

Function.caller is not part of the ECMAScript standard and is not required in conforming implementations. It should not be used.

Name

Function.length — the number of declared arguments

Synopsis

function.length

Description

The length property of a function specifies the number of named arguments declared when the function was defined. The function may actually be invoked with more than or fewer than this number of arguments. Don’t confuse this property of a Function object with the length property of the Arguments object, which specifies the number of arguments actually passed to the function. See Arguments.length for an example.

See Also

Arguments.length

Name

Function.prototype — the prototype for a class of objects

Synopsis

function.prototype

Description

The prototype property is used when a function is used as a constructor. It refers to an object that serves as the prototype for an entire class of objects. Any object created by the constructor inherits all properties of the object referred to by the prototype property.

See Chapter 9 for a full discussion of constructor functions, the prototype property, and the definition of classes in JavaScript.

See Also

Chapter 9

Name

Function.toString() — convert a function to a string

Synopsis

function.toString()

Returns

A string that represents the function.

Throws

TypeError

If this method is invoked on an object that is not a Function.

Description

The toString() method of the Function object converts a function to a string in an implementation-dependent way. In most implementations, such as the implementations in Firefox and IE, this method returns a string of valid JavaScript code—code that includes the function keyword, argument list, the complete body of the function, and so on. In these implementations, the output of this toString() method is valid input for the global eval() function. This behavior is not required by the specification, however, and should not be relied upon.

Name

Global — the global object

Inherits from

Object → Global

Synopsis

this

Global Properties

The global object is not a class, so the following global properties have individual reference entries under their own names. That is, you can find details on the undefined property listed under the name undefined, not under Global.undefined. Note that all top-level variables are also properties of the global object:

Infinity

A numeric value that represents positive infinity.

NaN

The not-a-number value.

undefined

The undefined value.

Global Functions

The global object is an object, not a class. The global functions listed here are not methods of any object, and their reference entries appear under the function name. For example, you’ll find details on the parseInt() function under parseInt(), not Global.parseInt():

decodeURI()

Decodes a string escaped with encodeURI().

decodeURIComponent()

Decodes a string escaped with encodeURIComponent().

encodeURI

Encodes a URI by escaping certain characters.

encodeURIComponent

Encodes a URI component by escaping certain characters.

escape()

Encodes a string by replacing certain characters with escape sequences.

eval()

Evaluates a string of JavaScript code and returns the result.

isFinite()

Tests whether a value is a finite number.

isNaN()

Tests whether a value is the not-a-number value.

parseFloat()

Parses a number from a string.

parseInt()

Parses an integer from a string.

unescape()

Decodes a string encoded with escape().

Global Objects

In addition to the global properties and functions listed earlier, the global object also defines properties that refer to all the other predefined JavaScript objects. Most of these properties are constructor functions:

Array

The Array() constructor.

Boolean

The Boolean() constructor.

Date

The Date() constructor.

Error

The Error() constructor.

EvalError

The EvalError() constructor.

Function

The Function() constructor.

JSON

A reference to an object that defines JSON parsing and serialization functions.

Math

A reference to an object that defines mathematical functions.

Number

The Number() constructor.

Object

The Object() constructor.

RangeError

The RangeError() constructor.

ReferenceError

The ReferenceError() constructor.

RegExp

The RegExp() constructor.

String

The String() constructor.

SyntaxError

The SyntaxError() constructor.

TypeError

The TypeError() constructor.

URIError

The URIError() constructor.

Description

The global object is a predefined object that serves as a placeholder for the global properties and functions of JavaScript. All other predefined objects, functions, and properties are accessible through the global object. The global object is not a property of any other object, so it does not have a name. (The title of this reference page was chosen simply for organizational convenience and does not indicate that the global object is named「Global」). In top-level JavaScript code, you can refer to the global object with the keyword this. It is rarely necessary to refer to the global object in this way, however, because the global object serves as the top of the scope chain, which means that unqualified variable and function names are looked up as properties of the object. When JavaScript code refers to the parseInt() function, for example, it is referring to the parseInt property of the global object. The fact that the global object is the top of the scope chain also means that all variables declared in top-level JavaScript code become properties of the global object.

The global object is simply an object, not a class. There is no Global() constructor, and there is no way to instantiate a new global object.

When JavaScript is embedded in a particular environment, the global object is usually given additional properties that are specific to that environment. In fact, the type of the global object is not specified by the ECMAScript standard, and an implementation or embedding of JavaScript may use an object of any type as the global object, as long as the object defines the basic properties and functions listed here. In client-side JavaScript, for example, the global object is a Window object and represents the web browser window within which the JavaScript code is running.

Example

In core JavaScript, none of the predefined properties of the global object are enumerable, so you can list all implicitly and explicitly declared global variables with a for/in loop like this:

var variables = "" for(var name in this) variables += name + "\n";

