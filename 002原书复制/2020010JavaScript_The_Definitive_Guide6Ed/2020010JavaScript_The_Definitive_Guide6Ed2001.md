See Also

Window in Part IV ; Chapter 3

Name

Infinity — a numeric property that represents infinity

Synopsis

Infinity

Description

Infinity is a global property that contains the special numeric value representing positive infinity. The Infinity property is not enumerated by for/in loops and cannot be deleted with the delete operator. Note that Infinity is not a constant and can be set to any other value, something that you should take care not to do. (Number.POSITIVE_INFINITY is a constant, however.)

See Also

isFinite(), NaN, Number.POSITIVE_INFINITY

Name

isFinite() — determine whether a number is finite

Synopsis

isFinite(n)

Arguments

n

The number to be tested.

Returns

true if n is (or can be converted to) a finite number, or false if n is NaN (not a number) or positive or negative infinity.

See Also

Infinity, isNaN(), NaN, Number.NaN, Number.NEGATIVE_INFINITY, Number.POSITIVE_INFINITY

Name

isNaN() — check for not-a-number

Synopsis

isNaN(x)

Arguments

x

The value to be tested.

Returns

true if x is not a number or if it is the special numeric value NaN. It returns false if x is any other number.

Description

「NaN」is an acronym for「not-a-number」. The global variable NaN holds a special numeric value (also known as NaN) that represents an illegal number (such as the result of zero divided by zero). isNaN() tests whether its argument is not a number. This function returns false if x is, or can be converted to, a number other than NaN. It returns true if x is not and cannot be converted to a number, or if it is equal to NaN.

NaN has the special property that it is not equal to any value including itself. So if you want to test specifically for the NaN value, rather than generically for any non-number, do not write x === NaN: that will always be false. Instead use the expression x !== x: this will evaluate to true only if x is NaN.

A common use of isNaN() is to test the results of parseFloat() and parseInt() to determine if they represent legal numbers.

Example

isNaN(0); // => false isNaN(0/0); // => true isNaN(parseInt("3")); // => false isNaN(parseInt("hello")); // => true isNaN("3"); // => false isNaN("hello"); // => true isNaN(true); // => false isNaN(undefined); // => true

See Also

isFinite(), NaN, Number.NaN, parseFloat(), parseInt()

Name

JSON — JSON parsing and stringification

Availability

ECMAScript 5

Description

JSON is a simple object that serves as the namespace for the global ECMAScript 5 functions JSON.parse() and JSON.stringify(). JSON is not a constructor. Prior to ECMAScript 5, compatible JSON parsing and serialization functions are available from http://json.org/json2.js.

「JSON」stands for JavaScript Object Notation. JSON is a data serialization format based on JavaScript literals, and can represent the null value, the boolean values true and false, floating-point numbers (using JavaScript numeric literals), strings (using JavaScript string literals), arrays of values (using JavaScript array literal syntax) and string to value mappings (using JavaScript object literal syntax). The primitive value undefined as well as the numbers NaN and Infinity are not representable in JSON. JavaScript functions, Dates, RegExps and Errors are not supported either.

Example

// Make a deep copy of any object or array that can be JSON-serialized function deepcopy(o) { return JSON.parse(JSON.stringify(o)); }

See Also

JSON.parse(), JSON.stringify(), Serializing Objects, http://json.org

Name

JSON.parse() — parse a JSON-formatted string

Availability

ECMAScript 5

Synopsis

JSON.parse(s) JSON.parse(s, reviver)

Arguments

s

The string to be parsed

reviver

An optional function that can transform parsed values.

Returns

An object, array, or primitive value parsed from s (and optionally modified by reviver).

Description

JSON.parse() is a global function for parsing JSON-formatted strings. Typically, you pass a single string argument and JSON.parse() returns the JavaScript value that the string represents.

You can use the optional reviver argument to filter or post-process the parsed value before it is returned. If it is specified, the reviver function is invoked once for each primitive value (but not the objects or arrays that contain those primitive values) parsed from s. reviver is invoked with two arguments. The first is a property name—either an object property name or an array index converted to a string. The second argument is the primitive value of that object property or array element. reviver is invoked as a method of the object or array that contains the primitive value. As a special case, if the string s represents a primitive value rather than the more typical object or array, then that primitive value will be stored in a newly-created object using a property whose name is the empty string. In this case, reviver will be invoked once on that newly created object, with an empty string as its first argument and the primitive value as its second.

The return value of the reviver function becomes the new value of the named property. If reviver returns its second argument, then the property will remain unchanged. If reviver returns undefined (or returns no value at all) then the named property will be deleted from the object or array before JSON.parse() returns to the user.

Example

Many uses of JSON.parse() are trivial:

var data = JSON.parse(text);

The JSON.stringify() function converts Date objects to strings, and you can use a reviver function to reverse this transformation. The example below also filters property names and returns undefined to remove certain properties from the result object:

var data JSON.parse(text, function(name, value) { // Remove any values whose property name begins with an underscore if (name[0] == '_') return undefined; // If the value is a string in ISO 8601 date format convert it to a Date. if (typeof value === "string" && /^\d\d\d\d-\d\d-\d\dT\d\d:\d\d:\d\d.\d\d\dZ$/.test(value)) return new Date(value); // Otherwise, return the value unchanged return value });

See Also

JSON.stringify(), Serializing Objects

Name

JSON.stringify() — serialize an object, array or primitive value

Availability

ECMAScript 5

Synopsis

JSON.stringify(o) JSON.stringify(o, filter) JSON.stringify(o, filter, indent)

Arguments

o

The object, array, or primitive value to be converted to a JSON string.

filter

An optional function that can replace values before stringification, or an array that contains the names of properties to be stringified.

indent

An optional argument that specifies an indentation string or the number of spaces to use for indentation when formatted human-readable output is desired. If omitted, the returned string contains no extraneous spaces and is machine-readable, but not easily human-readable.

Returns

A JSON-formatted string representing the value o, as filtered by filter and formatted according to indent.

Description

JSON.stringify() converts a primitive value, object or array to a JSON-formatted string that can later be parsed with JSON.parse(). Usually, this function is called with a single argument and returns the corresponding string.

When JSON.stringify() is called with a single argument, and when that value consists only of objects, arrays, strings, numbers, booleans and the null value the stringification is completely straightforward. When the value to be stringified contains objects that are instances of a class, however, the stringification process is more complex. If JSON.stringify() encounters any object (or array) with a method named toJSON(), it invokes that method on the object and stringifies the return value instead of the object itself. It invokes toJSON() with a single string argument which is the property name or array index of the object. The Date class defines a toJSON() method that converts Dates to strings using the Date.toISOString() method. No other built-in JavaScript class defines a toJSON() method, but you can define them for your own classes. Remember that, despite its name, toJSON() does not have to stringify the object on which it is invoked: it merely has to return a value that will be stringified in place of the original object.

The second argument to JSON.stringify() allows a second layer of filtering for the stringification process. This optional argument may be a function or an array and the two cases provide completely different filtering functionality. If you pass a function, it is a replacer function, and works something like the toJSON() method described above. If specified, the replacer function is invoked for each value to be stringified. The this value is the object or array within which the value is defined. The first argument to the replacer function is the object property name or array index of the value within that object, and the second argument is the value itself. That value is replaced by the return value of the replacer function. If the replacer returns undefined or returns nothing at all, then that value (and its array element or object property) are omitted from the stringification.

If an array of strings (or numbers—they are converted to strings) is passed instead as the second argument, these are used as the names of object properties. Any property whose name is not in the array will be omitted from stringification. Furthermore, the returned string will include properties in the same order that they appear in the array.

JSON.stringify() normally returns a machine-readable string without any whitespace or newlines inserted. If you want the output to be more human readable, specify a third argument. If you specify a number between 1 and 10, JSON.stringify() will insert newlines and use the specified number of spaces to indent each「level」of output. If you specify a non-empty string instead, JSON.stringify() will insert newlines and use that string (or the first 10 characters of it) to indent each level.

Examples

// Basic serialization var text = JSON.stringify(data); // Specify exactly what fields to serialize var text = JSON.stringify(address, ["city","state","country"]); // Specify a replacer function so that RegExp objects can be serialized var text = JSON.stringify(patterns, function(key, value) { if (value.constructor === RegExp) return value.toString(); return value; }); // Or acheive the same replacement like this: RegExp.prototype.toJSON = function() { return this.toString(); }

See Also

JSON.parse(), Serializing Objects

Name

Math — mathematical functions and constants

Synopsis

Math.constant Math.function()

Constants

Math.E

The constant e, the base of the natural logarithm.

Math.LN10

The natural logarithm of 10.

Math.LN2

The natural logarithm of 2.

Math.LOG10E

The base-10 logarithm of e.

Math.LOG2E

The base-2 logarithm of e.

Math.PI

The constant π.

Math.SQRT1_2

The number 1 divided by the square root of 2.

Math.SQRT2

The square root of 2.

Static Functions

Math.abs()

Computes an absolute value.

Math.acos()

Computes an arccosine.

Math.asin()

Computes an arcsine.

Math.atan()

Computes an arctangent.

Math.atan2()

Computes the angle from the X axis to a point.

Math.ceil()

Rounds a number up.

Math.cos()

Computes a cosine.

Math.exp()

Computes a power of e.

Math.floor()

Rounds a number down.

Math.log()

Computes a natural logarithm.

Math.max()

Returns the larger of two numbers.

Math.min()

Returns the smaller of two numbers.

Math.pow()

Computes x y

Math.random()

Computes a random number.

Math.round()

Rounds to the nearest integer.

Math.sin()

Computes a sine.

Math.sqrt()

Computes a square root.

Math.tan()

Computes a tangent.

Description

Math is an object that defines properties that refer to useful mathematical functions and constants. These functions and constants are invoked with syntax like this:

y = Math.sin(x); area = radius * radius * Math.PI;

Math is not a class of objects as Date and String are. There is no Math() constructor, and functions like Math.sin() are simply functions, not methods that operate on an object.

See Also

Number

Name

Math.abs() — compute an absolute value

Synopsis

Math.abs(x)

Arguments

x

Any number.

Returns

The absolute value of x.

Name

Math.acos() — compute an arccosine

Synopsis

Math.acos(x)

Arguments

x

A number between −1.0 and 1.0.

Returns

The arccosine, or inverse cosine, of the specified value x. This return value is between 0 and π radians.

Name

Math.asin() — compute an arcsine

Synopsis

Math.asin(x)

Arguments

x

A number between −1.0 and 1.0.

Returns

The arcsine of the specified value x. This return value is between -π/2 and π/2 radians.

Name

Math.atan() — compute an arctangent

Synopsis

Math.atan(x)

Arguments

x

Any number.

Returns

The arc tangent of the specified value x. This return value is between -π/2 and π/2 radians.

Name

Math.atan2() — compute the angle from the X axis to a point

Synopsis

Math.atan2(y, x)

Arguments

y

The Y coordinate of the point.

x

The X coordinate of the point.

Returns

A value between -π and π radians that specifies the counterclockwise angle between the positive X axis and the point (x, y).

Description

The Math.atan2() function computes the arc tangent of the ratio y/x. The y argument can be considered the Y coordinate (or「rise」) of a point, and the x argument can be considered the X coordinate (or「run」) of the point. Note the unusual order of the arguments to this function: the Y coordinate is passed before the X coordinate.

Name

Math.ceil() — round a number up

Synopsis

Math.ceil(x)

Arguments

x

Any numeric value or expression.

Returns

The closest integer greater than or equal to x.

Description

Math.ceil() computes the ceiling function—i.e., it returns the closest integer value that is greater than or equal to the function argument. Math.ceil() differs from Math.round() in that it always rounds up, rather than rounding up or down to the closest integer. Also note that Math.ceil() does not round negative numbers to larger negative numbers; it rounds them up toward zero.

Example

a = Math.ceil(1.99); // Result is 2.0 b = Math.ceil(1.01); // Result is 2.0 c = Math.ceil(1.0); // Result is 1.0 d = Math.ceil(-1.99); // Result is -1.0

Name

Math.cos() — compute a cosine

Synopsis

Math.cos(x)

Arguments

x

An angle, measured in radians. To convert degrees to radians, multiply the degree value by 0.017453293 (2π/360).

Returns

The cosine of the specified value x. This return value is between −1.0 and 1.0.

Name

Math.E — the mathematical constant e

Synopsis

Math.E

Description

Math.E is the mathematical constant e, the base of the natural logarithm, with a value of approximately 2.71828.

Name

Math.exp() — compute e x

Synopsis

Math.exp(x)

Arguments

x

A numeric value or expression to be used as the exponent.

Returns

e x , e raised to the power of the specified exponent x, where e is the base of the natural logarithm, with a value of approximately 2.71828.

Name

Math.floor() — round a number down

Synopsis

Math.floor(x)

Arguments

x

Any numeric value or expression.

Returns

The closest integer less than or equal to x.

Description

Math.floor() computes the floor function; in other words, it returns the nearest integer value that is less than or equal to the function argument.

Math.floor() rounds a floating-point value down to the closest integer. This behavior differs from that of Math.round(), which rounds up or down to the nearest integer. Also note that Math.floor() rounds negative numbers down (i.e., to be more negative), not up (i.e., closer to zero).

Example

a = Math.floor(1.99); // Result is 1.0 b = Math.floor(1.01); // Result is 1.0 c = Math.floor(1.0); // Result is 1.0 d = Math.floor(-1.01); // Result is -2.0

Name

Math.LN10 — the mathematical constant log e 10

Synopsis

Math.LN10

Description

Math.LN10 is log e 10, the natural logarithm of 10. This constant has a value of approximately 2.3025850929940459011.

Name

Math.LN2 — the mathematical constant log e 2

Synopsis

Math.LN2

Description

Math.LN2 is log e 2, the natural logarithm of 2. This constant has a value of approximately 0.69314718055994528623.

Name

Math.log() — compute a natural logarithm

Synopsis

Math.log(x)

Arguments

x

Any numeric value or expression greater than zero.

Returns

The natural logarithm of x.

Description

Math.log() computes log e x, the natural logarithm of its argument. The argument must be greater than zero.

You can compute the base-10 and base-2 logarithms of a number with these formulas:

log10x = log10e · logex log2x = log2e · logex

These formulas translate into the following JavaScript functions:

function log10(x) { return Math.LOG10E * Math.log(x); } function log2(x) { return Math.LOG2E * Math.log(x); }

Name

Math.LOG10E — the mathematical constant log10e

Synopsis

Math.LOG10E

Description

Math.LOG10E is log10 e the base-10 logarithm of the constant e. It has a value of approximately 0.43429448190325181667.

Name

Math.LOG2E — the mathematical constant log2e

Synopsis

Math.LOG2E

Description

Math.LOG2E is log2 e the base-2 logarithm of the constant e. It has a value of approximately 1.442695040888963387.

Name

Math.max() — return the largest argument

Synopsis

Math.max(args...)

Arguments

args...

Zero or more values.

Returns

The largest of the arguments. Returns -Infinity if there are no arguments. Returns NaN if any of the arguments is NaN or is a nonnumeric value that cannot be converted to a number.

Name

Math.min() — return the smallest argument

Synopsis

Math.min(args...)

Arguments

args...

Any number of arguments.

Returns

The smallest of the specified arguments. Returns Infinity if there are no arguments. Returns NaN if any argument is NaN or is a nonnumeric value that cannot be converted to a number.

Name

Math.PI — the mathematical constant π

Synopsis

Math.PI

Description

Math.PI is the constant π or pi, the ratio of the circumference of a circle to its diameter. It has a value of approximately 3.14159265358979.

Name

Math.pow() — compute x y

Synopsis

Math.pow(x, y)

Arguments

x

The number to be raised to a power.

y

The power that x is to be raised to.

Returns

x to the power of y, x y

Description

Math.pow() computes x to the power of y. Any values of x and y may be passed to Math.pow(). However, if the result is an imaginary or complex number, Math.pow() returns NaN. In practice, this means that if x is negative, y should be a positive or negative integer. Also, bear in mind that large exponents can easily cause floating-point overflow and return a value of Infinity.

Name

Math.random() — return a pseudorandom number

Synopsis

Math.random()

Returns

A pseudorandom number greater than or equal to 0.0 and less than 1.0.

Name

Math.round() — round to the nearest integer

Synopsis

Math.round(x)

Arguments

x

Any number.

Returns

The integer closest to x.

Description

Math.round() rounds its argument up or down to the nearest integer. It rounds .5 up. For example, it rounds 2.5 to 3 and rounds −2.5 to −2.

Name

Math.sin() — compute a sine

Synopsis

Math.sin(x)

Arguments

x

An angle, in radians. To convert degrees to radians, multiply by 0.017453293 (2π/360).

Returns

The sine of x. This return value is between −1.0 and 1.0.

Name

Math.sqrt() — compute a square root

Synopsis

Math.sqrt(x)

Arguments

x

A numeric value greater than or equal to zero.

Returns

The square root of x. Returns NaN if x is less than zero.

Description

Math.sqrt() computes the square root of a number. Note, however, that you can compute arbitrary roots of a number with Math.pow(). For example:

Math.cuberoot = function(x){ return Math.pow(x,1/3); } Math.cuberoot(8); // Returns 2

Name

Math.SQRT1_2 — the mathematical constant 1/√2

Synopsis

Math.SQRT1_2

Description

Math.SQRT1_2 is 1/√2 the reciprocal of the square root of 2. This constant has a value of approximately 0.7071067811865476.

Name

Math.SQRT2 — the mathematical constant √2

Synopsis

Math.SQRT2

Description

Math.SQRT2 is the constant √2, the square root of 2. This constant has a value of approximately 1.414213562373095.

Name

Math.tan() — compute a tangent

Synopsis

Math.tan(x)

Arguments

x

An angle, measured in radians. To convert degrees to radians, multiply the degree value by 0.017453293 (2π/360).

Returns

The tangent of the specified angle x.

Name

