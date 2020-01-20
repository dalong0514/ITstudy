Object.getPrototypeOf(o)

Arguments

o

An object.

Returns

The prototype object of o.

Description

Object.getPrototypeOf() returns the prototype of its argument. Note that this is a global function, and you must pass an object to it. It is not a method that is invoked on an object.

Example

var p = {}; // An ordinary object Object.getPrototypeOf(p) // => Object.prototype var o = Object.create(p) // An object that inherits from p Object.getPrototypeOf(o) // => p

See Also

Object.create(); Chapter 6

Name

Object.hasOwnProperty() — check whether a property is inherited

Synopsis

object.hasOwnProperty(propname)

Arguments

propname

A string that contains the name of a property of object.

Returns

true if object has a noninherited property with the name specified by propname; false if object does not have a property with the specified name or if it inherits that property from its prototype object.

Description

As explained in Chapter 9, JavaScript objects may have properties of their own, and they may also inherit properties from their prototype object. The hasOwnProperty() method provides a way to distinguish between inherited properties and noninherited local properties.

Example

var o = new Object(); // Create an object o.x = 3.14; // Define a noninherited local property o.hasOwnProperty("x"); // Returns true: x is a local property of o o.hasOwnProperty("y"); // Returns false: o doesn't have a property y o.hasOwnProperty("toString"); // Returns false: toString property is inherited

See Also

Function.prototype, Object.propertyIsEnumerable(); Chapter 9

Name

Object.isExtensible() — can new properties be added to an object?

Availability

ECMAScript 5

Synopsis

Object.isExtensible(o)

Arguments

o

The object to be checked for extensibility

Returns

true if the object can be extended with new properties, or false if it cannot.

Description

An object is extensible (or extendable) if it can have new properties added to it. All objects are extendable when they are created and remain that way unless they are passed to Object.preventExtensions(), Object.seal(), or Object.freeze().

Note that this is not a method to be invoked on an object: it is a global function and you must pass an object to it.

Example

var o = {}; // Start with a newly-created object Object.isExtensible(o) // => true: it is extendable Object.preventExtensions(o); // Make it non-extendable Object.isExtensible(o) // => false: now it is not extendable

See Also

Object.isFrozen(), Object.isSealed(), Object.preventExtensions(), The extensible Attribute

Name

Object.isFrozen() — is an object immutable?

Availability

ECMAScript 5

Synopsis

Object.isFrozen(o)

Arguments

o

The object to be checked

Returns

true if o is frozen and immutable, or false if it is not.

Description

An object is frozen if all of its non-inherited properties (except those with setter methods) are read-only, and if it is sealed. An object is sealed if no new (non-inherited) properties can be added to it, no existing (non-inherited) properties can be deleted from it. Object.isFrozen() tests whether its argument is frozen or not. Once frozen, an object can never be unfrozen.

The usual way to freeze an object is by passing it to Object.freeze(). It is also possible to freeze an object by passing it to Object.preventExtensions() and then using Object.defineProperty() to make all of its properties read-only and nondeletable.

Note that this is not a method to be invoked on an object: it is a global function and you must pass an object to it.

See Also

Object.defineProperty(), Object.freeze(), Object.isExtensible(), Object.isSealed(), Object.preventExtensions(), Object.seal(), The extensible Attribute

Name

Object.isPrototypeOf() — is one object the prototype of another?

Synopsis

object.isPrototypeOf(o)

Arguments

o

Any object.

Returns

true if object is the prototype of o; false if o is not an object or if object is not the prototype of o.

Description

As explained in Chapter 9, JavaScript objects inherit properties from their prototype object. The prototype of an object is referred to by the prototype property of the constructor function that creates and initializes the object. The isPrototypeOf() method provides a way to determine if one object is the prototype of another. This technique can be used to determine the class of an object.

Example

var o = new Object(); // Create an object Object.prototype.isPrototypeOf(o) // true: o is an object Function.prototype.isPrototypeOf(o.toString); // true: toString is a function Array.prototype.isPrototypeOf([1,2,3]); // true: [1,2,3] is an array // Here is a way to perform a similar test (o.constructor == Object); // true: o was created with Object() constructor (o.toString.constructor == Function); // true: o.toString is a function // Prototype objects themselves have prototypes. The following call // returns true, showing that function objects inherit properties // from Function.prototype and also from Object.prototype. Object.prototype.isPrototypeOf(Function.prototype);

See Also

Function.prototype, Object.constructor; Chapter 9

Name

Object.isSealed() — can properties be added to or deleted from an object?

Availability

ECMAScript 5

Synopsis

Object.isSealed(o)

Arguments

o

The object to be checked

Returns

true if o is sealed, or false if it is not.

Description

An object is sealed if no new (non-inherited) properties can be added to it and no existing (non-inherited) properties can be deleted from it. Object.isSealed() tests whether its argument is sealed or not. Once sealed, an object can never be unsealed. The usual way to seal an object is by passing it to Object.seal() or Object.freeze(). It is also possible to seal an object by passing it to Object.preventExtensions() and then using Object.defineProperty() to make all of its properties non-deleteable.

Note that this is not a method to be invoked on an object: it is a global function and you must pass an object to it.

See Also

Object.defineProperty(), Object.freeze(), Object.isExtensible(), Object.isFrozen(), Object.preventExtensions(), Object.seal(), The extensible Attribute

Name

Object.keys() — return own enumerable property names

Availability

ECMAScript 5

Synopsis

Object.keys(o)

Arguments

o

An object

Returns

An array that contains the names of all enumerable own (non-inherited) properties of o.

Description

Object.keys() returns an array of property names for the object o. The array only includes the names of properties that are enumerable and are defined directly on o: inherited properties are not included. (See Object.getOwnPropertyNames() for a way to obtain the names of non-enumerable properties.) Property names appear in the returned array in the same order they would be enumerated by a for/in loop.

Note that this is not a method to be invoked on an object: it is a global function and you must pass an object to it.

Example

Object.keys({x:1, y:2}) // => ["x", "y"]

See Also

Object.getOwnPropertyNames(), for/in, Enumerating Properties

Name

Object.preventExtensions() — don’t allow new properties on an object

Availability

ECMAScript 5

Synopsis

Object.preventExtensions(o)

Arguments

o

The object that is to have its extensible attribute set

Returns

The argument object o.

Description

Object.preventExtensions() sets the extensible attribute of o to false so that no new properties can be added to it. This is a permanent change: once an object has been made non-extensible, it cannot be make extensible again.

Note that Object.preventExtensions() does not affect the prototype chain, and a nonextensible object can still gain new inherited properties.

Note that this is not a method to be invoked on an object: it is a global function and you must pass an object to it.

See Also

Object.freeze(), Object.isExtensible(), Object.seal(), The extensible Attribute

Name

Object.propertyIsEnumerable() — will property be seen by a for/in loop?

Synopsis

object.propertyIsEnumerable(propname)

Arguments

propname

A string that contains the name of a property of object.

Returns

true if object has a noninherited property with the name specified by propname and if that property is enumerable, which means that it would be enumerated by a for/in loop on object.

Description

The for/in statement loops through the enumerable properties of an object. Not all properties of an object are enumerable, however: properties added to an object by JavaScript code are enumerable, but the predefined properties (such as methods) of built-in objects are not usually enumerable. The propertyIsEnumerable() method provides a way to distinguish between enumerable and nonenumerable properties. Note, however, that the ECMAScript specification states that propertyIsEnumerable() does not examine the prototype chain, which means it works only for local properties of an object and does not provide any way to test the enumerability of inherited properties.

Example

var o = new Object(); // Create an object o.x = 3.14; // Define a property o.propertyIsEnumerable("x"); // true: property x is local and enumerable o.propertyIsEnumerable("y"); // false: o doesn't have a property y o.propertyIsEnumerable("toString"); // false: toString property is inherited Object.prototype.propertyIsEnumerable("toString"); // false: nonenumerable

See Also

Function.prototype, Object.hasOwnProperty(); Chapter 6

Name

Object.seal() — prevent the addition or deletion of properties

Availability

ECMAScript 5

Synopsis

Object.seal(o)

Arguments

o

The object to be sealed

Returns

The now-sealed argument object o.

Description

Object.seal() makes o non-extensible (see Object.preventExtensions()) and makes all of its own properties non-configurable. This has the effect of preventing the addition of new properties and preventing the deletion of existing properties. Sealing an object is permanent: once sealed, an object cannot be unsealed.

Note that Object.seal() does not make properties read-only; see Object.freeze() for that. Also note that Object.seal() does not affect inherited properties. If a sealed object has a non-sealed object in its prototype chain, then inherited properties may be added or removed.

Note that this is not a method to be invoked on an object: it is a global function and you must pass an object to it.

See Also

Object.defineProperty(), Object.freeze(), Object.isSealed(), Object.preventExtensions(), The extensible Attribute

Name

Object.toLocaleString() — return an object’s localized string representation

Synopsis

object.toString()

Returns

A string representing the object.

Description

This method is intended to return a string representation of the object, localized as appropriate for the current locale. The default toLocaleString() method provided by the Object class simply calls the toString() method and returns the nonlocalized string that it returns. Note, however, that other classes, including Array, Date, and Number, define their own versions of this method to perform localized string conversions. When defining your own classes, you may want to override this method as well.

See Also

Array.toLocaleString(), Date.toLocaleString(), Number.toLocaleString(), Object.toString()

Name

Object.toString() — define an object’s string representation

Synopsis

object.toString()

Returns

A string representing the object.

Description

The toString() method is not one you often call explicitly in your JavaScript programs. Instead, you define this method in your objects, and the system calls it whenever it needs to convert your object to a string.

The JavaScript system invokes the toString() method to convert an object to a string whenever the object is used in a string context. For example, an object is converted to a string when it is passed to a function that expects a string argument:

alert(my_object);

Similarly, objects are converted to strings when they are concatenated to strings with the + operator:

var msg = 'My object is: ' + my_object;

The toString() method is invoked without arguments and should return a string. To be useful, the string you return should be based, in some way, on the value of the object for which the method was invoked.

When you define a custom class in JavaScript, it is good practice to define a toString() method for the class. If you do not, the object inherits the default toString() method from the Object class. This default method returns a string of the form:

[objectclass]

where class is the class of the object: a value such as「Object」,「String」,「Number」,「Function」,「Window」,「Document」, and so on. This behavior of the default toString() method is occasionally useful to determine the type or class of an unknown object. Because most objects have a custom version of toString(), however, you must explicitly invoke the Object.toString() method on an object o with code like this:

Object.prototype.toString.apply(o);

Note that this technique for identifying unknown objects works only for built-in objects. If you define your own object class, it will have a class of「Object」. In this case, you can use the Object.constructor property to obtain more information about the object.

The toString() method can be quite useful when you are debugging JavaScript programs; it allows you to print objects and see their value. For this reason alone, it is a good idea to define a toString() method for every object class you create.

Although the toString() method is usually invoked automatically by the system, there are times when you may invoke it yourself. For example, you might want to do an explicit conversion of an object to a string in a situation where JavaScript does not do it automatically for you:

y = Math.sqrt(x); // Compute a number ystr = y.toString(); // Convert it to a string

Note in this example that numbers have a built-in toString() method you can use to force a conversion.

In other circumstances, you can choose to use a toString() call even in a context where JavaScript does the conversion automatically. Using toString() explicitly can help to make your code clearer:

alert(my_obj.toString());

See Also

Object.constructor, Object.toLocaleString(), Object.valueOf()

Name

Object.valueOf() — the primitive value of the specified object

Synopsis

object.valueOf()

Returns

The primitive value associated with the object, if any. If there is no value associated with object, returns the object itself.

Description

The valueOf() method of an object returns the primitive value associated with that object, if there is one. For objects of type Object, there is no primitive value, and this method simply returns the object itself.

For objects of type Number, however, valueOf() returns the primitive numeric value represented by the object. Similarly, it returns the primitive boolean value associated with a Boolean object and the string associated with a String object.

It is rarely necessary to invoke the valueOf() method yourself. JavaScript does this automatically whenever an object is used where a primitive value is expected. In fact, because of this automatic invocation of the valueOf() method, it is difficult to even distinguish between primitive values and their corresponding objects. The typeof operator shows you the difference between strings and String objects for example, but in practical terms, you can use them equivalently in your JavaScript code.

The valueOf() methods of the Number, Boolean, and String objects convert these wrapper objects to the primitive values they represent. The Object() constructor performs the opposite operation when invoked with a number, boolean, or string argument: it wraps the primitive value in an appropriate object wrapper. JavaScript performs this primitive-to-object conversion for you in almost all circumstances, so it is rarely necessary to invoke the Object() constructor in this way.

In some circumstances, you may want to define a custom valueOf() method for your own objects. For example, you might define a JavaScript object type to represent complex numbers (a real number plus an imaginary number). As part of this object type, you would probably define methods for performing complex addition, multiplication, and so on (see Example 9-3). But you might also want to treat your complex numbers like ordinary real numbers by discarding the imaginary part. To achieve this, you might do something like the following:

Complex.prototype.valueOf = new Function("return this.real");

With this valueOf() method defined for your Complex object type, you can, for example, pass one of your complex number objects to Math.sqrt(), which computes the square root of the real portion of the complex number.

See Also

Object.toString()

Name

parseFloat() — convert a string to a number

Synopsis

parseFloat(s)

Arguments

s

The string to be parsed and converted to a number.

Returns

The parsed number, or NaN if s does not begin with a valid number. In JavaScript 1.0, parseFloat() returns 0 instead of NaN when s cannot be parsed as a number.

Description

parseFloat() parses and returns the first number that occurs in s. Parsing stops, and the value is returned, when parseFloat() encounters a character in s that is not a valid part of the number. If s does not begin with a number that parseFloat() can parse, the function returns the not-a-number value NaN. Test for this return value with the isNaN() function. If you want to parse only the integer portion of a number, use parseInt() instead of parseFloat().

See Also

isNaN(), parseInt()

Name

parseInt() — convert a string to an integer

Synopsis

parseInt(s) parseInt(s, radix)

Arguments

s

The string to be parsed.

radix

An optional integer argument that represents the radix (i.e., base) of the number to be parsed. If this argument is omitted or is 0, the number is parsed in base 10—or in base 16 if it begins with 0x or 0X. If this argument is less than 2 or greater than 36, parseInt() returns NaN.

Returns

The parsed number, or NaN if s does not begin with a valid integer. In JavaScript 1.0, parseInt() returns 0 instead of NaN when it cannot parse s.

Description

parseInt() parses and returns the first number (with an optional leading minus sign) that occurs in s. Parsing stops, and the value is returned, when parseInt() encounters a character in s that is not a valid digit for the specified radix. If s does not begin with a number that parseInt() can parse, the function returns the not-a-number value NaN. Use the isNaN() function to test for this return value.

The radix argument specifies the base of the number to be parsed. Specifying 10 makes parseInt() parse a decimal number. The value 8 specifies that an octal number (using digits 0 through 7) is to be parsed. The value 16 specifies a hexadecimal value, using digits 0 through 9 and letters A through F. radix can be any value between 2 and 36.

If radix is 0 or is not specified, parseInt() tries to determine the radix of the number from s. If s begins (after an optional minus sign) with 0x, parseInt() parses the remainder of s as a hexadecimal number. Otherwise parseInt() parses it as a decimal number.

Example

parseInt("19", 10); // Returns 19 (10 + 9) parseInt("11", 2); // Returns 3 (2 + 1) parseInt("17", 8); // Returns 15 (8 + 7) parseInt("1f", 16); // Returns 31 (16 + 15) parseInt("10"); // Returns 10 parseInt("0x10"); // Returns 16

See Also

isNaN(), parseFloat()

Name

RangeError — thrown when a number is out of its legal range

Inherits from

Object → Error → RangeError

Constructor

new RangeError() new RangeError(message)

Arguments

message

An optional error message that provides details about the exception. If specified, this argument is used as the value for the message property of the RangeError object.

Returns

A newly constructed RangeError object. If the message argument is specified, the Error object uses it as the value of its message property; otherwise, it uses an implementation-defined default string as the value of that property. When the RangeError() constructor is called as a function, without the new operator, it behaves just as it would when called with the new operator.

Properties

message

An error message that provides details about the exception. This property holds the string passed to the constructor or an implementation-defined default string. See Error.message for details.

name

A string that specifies the type of the exception. All RangeError objects inherit the value「RangeError」for this property.

Description

An instance of the RangeError class is thrown when a numeric value is not in its legal range. For example, setting the length of an array to a negative number causes a RangeError to be thrown. See Error for details about throwing and catching exceptions.

See Also

Error, Error.message, Error.name

Name

ReferenceError — thrown when reading a variable that does not exist

Inherits from

Object → Error → ReferenceError

Constructor

new ReferenceError() new ReferenceError(message)

Arguments

message

An optional error message that provides details about the exception. If specified, this argument is used as the value for the message property of the ReferenceError object.

Returns

A newly constructed ReferenceError object. If the message argument is specified, the Error object uses it as the value of its message property; otherwise, it uses an implementation-defined default string as the value of that property. When the ReferenceError() constructor is called as a function, without the new operator, it behaves just as it would with the new operator.

Properties

message

An error message that provides details about the exception. This property holds the string passed to the constructor or an implementation-defined default string. See Error.message for details.

name

A string that specifies the type of the exception. All ReferenceError objects inherit the value「ReferenceError」for this property.

Description

An instance of the ReferenceError class is thrown when you attempt to read the value of a variable that does not exist. See Error for details about throwing and catching exceptions.

See Also

Error, Error.message, Error.name

Name

RegExp — regular expressions for pattern matching

Inherits from

Object → RegExp

Literal Syntax

/pattern/attributes

Constructor

new RegExp(pattern, attributes)

Arguments

pattern

A string that specifies the pattern of the regular expression or another regular expression.

attributes

An optional string containing any of the「g」,「i」, and「m」attributes that specify global, case-insensitive, and multiline matches, respectively. The「m」attribute is not available prior to ECMAScript standardization. If the pattern argument is a regular expression instead of a string, this argument must be omitted.

Returns

A new RegExp object, with the specified pattern and flags. If the pattern argument is a regular expression rather than a string, the RegExp() constructor creates a new RegExp object using the same pattern and flags as the specified RegExp. If RegExp() is called as a function without the new operator, it behaves just as it would with the new operator, except when pattern is a regular expression; in that case, it simply returns pattern instead of creating a new RegExp object.

Throws

SyntaxError

If pattern is not a legal regular expression, or if attributes contains characters other than「g」,「i」, and「m」.

TypeError

If pattern is a RegExp object, and the attributes argument is not omitted.

Instance Properties

global

Whether the RegExp has the「g」attribute.

ignoreCase

Whether the RegExp has the「i」attribute.

lastIndex

The character position of the last match; used for finding multiple matches in a string.

multiline

Whether the RegExp has the「m」attribute.

source

The source text of the regular expression.

Methods

exec()

Performs powerful, general-purpose pattern matching.

test()

Tests whether a string contains a pattern.

Description

The RegExp object represents a regular expression, a powerful tool for performing pattern matching on strings. See Chapter 10 for complete details on regular-expression syntax and use.

See Also

Chapter 10

Name

RegExp.exec() — general-purpose pattern matching

Synopsis

regexp.exec(string)

Arguments

string

The string to be searched.

Returns

An array containing the results of the match or null if no match was found. The format of the returned array is described below.

Throws

TypeError

If this method is invoked on an object that is not a RegExp.

Description

exec() is the most powerful of all the RegExp and String pattern-matching methods. It is a general-purpose method that is somewhat more complex to use than RegExp.test(), String.search(), String.replace(), and String.match().

exec() searches string for text that matches regexp. If it finds a match, it returns an array of results; otherwise, it returns null. Element 0 of the returned array is the matched text. Element 1 is the text that matched the first parenthesized subexpression, if any, within regexp. Element 2 contains the text that matched the second subexpression, and so on. The array length property specifies the number of elements in the array, as usual. In addition to the array elements and the length property, the value returned by exec() also has two other properties. The index property specifies the character position of the first character of the matched text. The input property refers to string. This returned array is the same as the array that is returned by the String.match() method, when invoked on a nonglobal RegExp object.

When exec() is invoked on a nonglobal pattern, it performs the search and returns the result described earlier. When regexp is a global regular expression, however, exec() behaves in a slightly more complex way. It begins searching string at the character position specified by the lastIndex property of regexp. When it finds a match, it sets lastIndex to the position of the first character after the match. This means that you can invoke exec() repeatedly in order to loop through all matches in a string. When exec() cannot find any more matches, it returns null and resets lastIndex to zero. If you begin searching a new string immediately after successfully finding a match in another string, you must be careful to manually reset lastIndex to zero.

Note that exec() always includes full details of every match in the array it returns, whether or not regexp is a global pattern. This is where exec() differs from String.match(), which returns much less information when used with global patterns. Calling the exec() method repeatedly in a loop is the only way to obtain complete pattern-matching information for a global pattern.

Example

You can use exec() in a loop to find all matches within a string. For example:

var pattern = /\bJava\w*\b/g; var text = "JavaScript is more fun than Java or JavaBeans!"; var result; while((result = pattern.exec(text)) != null) { alert("Matched '" + result[0] + "' at position " + result.index + " next search begins at position " + pattern.lastIndex); }

See Also

RegExp.lastIndex, RegExp.test(), String.match(), String.replace(), String.search(); Chapter 10

Name

RegExp.global — whether a regular expression matches globally

Synopsis

regexp.global

Description

global is a read-only boolean property of RegExp objects. It specifies whether a particular regular expression performs global matching—i.e., whether it was created with the「g」attribute.

Name

RegExp.ignoreCase — whether a regular expression is case-insensitive

Synopsis

regexp.ignoreCase

Description

ignoreCase is a read-only boolean property of RegExp objects. It specifies whether a particular regular expression performs case-insensitive matching—i.e., whether it was created with the「i」attribute.

Name

RegExp.lastIndex — the starting position of the next match

Synopsis

regexp.lastIndex

Description

lastIndex is a read/write property of RegExp objects. For regular expressions with the「g」attribute set, it contains an integer that specifies the character position immediately following the last match found by the RegExp.exec() and RegExp.test() methods. These methods use this property as the starting point for the next search they conduct. This allows you to call those methods repeatedly, to loop through all matches in a string. Note that lastIndex is not used by RegExp objects that do not have the「g」attribute set and do not represent global patterns.

This property is read/write, so you can set it at any time to specify where in the target string the next search should begin. exec() and test() automatically reset lastIndex to 0 when they fail to find a match (or another match). If you begin to search a new string after a successful match of some other string, you have to explicitly set this property to 0.

See Also

RegExp.exec(), RegExp.test()

Name

RegExp.source — the text of the regular expression

Synopsis

regexp.source

Description

source is a read-only string property of RegExp objects. It contains the text of the RegExp pattern. This text does not include the delimiting slashes used in regular-expression literals, and it does not include the「g」,「i」, and「m」attributes.

Name

RegExp.test() — test whether a string matches a pattern

Synopsis

regexp.test(string)

Arguments

string

The string to be tested.

Returns

true if string contains text that matches regexp; false otherwise.

Throws

TypeError

If this method is invoked on an object that is not a RegExp.

Description

test() tests string to see if it contains text that matches regexp. If so, it returns true; otherwise, it returns false. Calling the test() method of a RegExp r and passing it the string s is equivalent to the following expression:

(r.exec(s) != null)

Example

var pattern = /java/i; pattern.test("JavaScript"); // Returns true pattern.test("ECMAScript"); // Returns false

See Also

RegExp.exec(), RegExp.lastIndex, String.match(), String.replace(), String.substring(); Chapter 10

Name

RegExp.toString() — convert a regular expression to a string

Inherits from

Overrides Object.toString()

Synopsis

regexp.toString()

Returns

