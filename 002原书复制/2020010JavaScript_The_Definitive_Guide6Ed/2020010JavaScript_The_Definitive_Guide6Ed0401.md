"use strict" is a directive introduced in ECMAScript 5. Directives are not statements (but are close enough that "use strict" is documented here). There are two important differences between the "use strict" directive and regular statements:

It does not include any language keywords: the directive is just an expression statement that consists of a special string literal (in single or double quotes). JavaScript interpreters that do not implement ECMAScript 5 will simply see an expression statement with no side effects and will do nothing. Future versions of the ECMAScript standard are expected to introduce use as a true keyword, allowing the quotation marks to be dropped.

It can appear only at the start of a script or at the start of a function body, before any real statements have appeared. It need not be the very first thing in the script or function, however: a "use strict" directive may be followed or preceded by other string literal expression statements, and JavaScript implementations are allowed to interpret these other string literals as implementation-defined directives. String literal expression statements that follow the first regular statement in a script or function are simply ordinary expression statements; they may not be interpreted as directives and they have no effect.

The purpose of a "use strict" directive is to indicate that the code that follows (in the script or function) is strict code. The top-level (nonfunction) code of a script is strict code if the script has a "use strict" directive. A function body is strict code if it is defined within strict code or if it has a "use strict" directive. Code passed to the eval() method is strict code if eval() is called from strict code or if the string of code includes a "use strict" directive.

Strict code is executed in strict mode. The strict mode of ECMAScript 5 is a restricted subset of the language that fixes a few important language deficiencies and provides stronger error checking and increased security. The differences between strict mode and non-strict mode are the following (the first three are particularly important):

The with statement is not allowed in strict mode.

In strict mode, all variables must be declared: a ReferenceError is thrown if you assign a value to an identifier that is not a declared variable, function, function parameter, catch clause parameter, or property of the global object. (In non-strict mode, this implicitly declares a global variable by adding a new property to the global object.)

In strict mode, functions invoked as functions (rather than as methods) have a this value of undefined. (In non-strict mode, functions invoked as functions are always passed the global object as their this value.) This difference can be used to determine whether an implementation supports strict mode:

var hasStrictMode = (function() { "use strict"; return this===undefined}());

Also, in strict mode, when a function is invoked with call() or apply(), the this value is exactly the value passed as the first argument to call() or apply(). (In nonstrict mode, null and undefined values are replaced with the global object and non-object values are converted to objects.)

In strict mode, assignments to nonwritable properties and attempts to create new properties on nonextensible objects throw a TypeError. (In non-strict mode, these attempts fail silently.)

In strict mode, code passed to eval() cannot declare variables or define functions in the caller’s scope as it can in non-strict mode. Instead, variable and function definitions live in a new scope created for the eval(). This scope is discarded when the eval() returns.

In strict mode, the arguments object (Variable-Length Argument Lists: The Arguments Object) in a function holds a static copy of the values passed to the function. In non-strict mode, the arguments object has「magical」behavior in which elements of the array and named function parameters both refer to the same value.

In strict mode, a SyntaxError is thrown if the delete operator is followed by an unqualified identifier such as a variable, function, or function parameter. (In non-strict mode, such a delete expression does nothing and evaluates to false.)

In strict mode, an attempt to delete a nonconfigurable property throws a TypeError. (In non-strict mode, the attempt fails and the delete expression evaluates to false.)

In strict mode, it is a syntax error for an object literal to define two or more properties by the same name. (In non-strict mode, no error occurs.)

In strict mode, it is a syntax error for a function declaration to have two or more parameters with the same name. (In non-strict mode, no error occurs.)

In strict mode, octal integer literals (beginning with a 0 that is not followed by an x) are not allowed. (In non-strict mode, some implementations allow octal literals.)

In strict mode, the identifiers eval and arguments are treated like keywords, and you are not allowed to change their value. You cannot assign a value to these identifiers, declare them as variables, use them as function names, use them as function parameter names, or use them as the identifier of a catch block.

In strict mode, the ability to examine the call stack is restricted. arguments.caller and arguments.callee both throw a TypeError within a strict mode function. Strict mode functions also have caller and arguments properties that throw TypeError when read. (Some implementations define these nonstandard properties on non-strict functions.)

Summary of JavaScript Statements

This chapter introduced each of the JavaScript language’s statements. Table 5-1 summarizes them, listing the syntax and purpose of each.

Table 5-1. JavaScript statement syntax

StatementSyntaxPurpose

break break [label]; Exit from the innermost loop or switch or from named enclosing statement

case case expression: Label a statement within a switch

continue continue [label]; Begin next iteration of the innermost loop or the named loop

debugger debugger; Debugger breakpoint

default default: Label the default statement within a switch

do/while do statement while (expression); An alternative to the while loop

empty ; Do nothing

for for(init; test; incr) statement An easy-to-use loop

for/in for (var in object) statement Enumerate the properties of object

function function name([param[,...]]) { body } Declare a function named name

if/else if (expr) statement1 [else statement2] Execute statement1 or statement2

label label: statement Give statement the name label

return return [expression]; Return a value from a function

switch switch (expression) { statements } Multiway branch to case or default: labels

throw throw expression; Throw an exception

try try { statements }

[catch { handler statements }]

[finally { cleanup statements }]

Handle exceptions

use strict "use strict"; Apply strict mode restrictions to script or function

var var name [ = expr] [ ,... ]; Declare and initialize one or more variables

while while (expression) statement A basic loop construct

with with (object) statement Extend the scope chain (forbidden in strict mode)

Chapter 6. Objects

JavaScript’s fundamental datatype is the object. An object is a composite value: it aggregates multiple values (primitive values or other objects) and allows you to store and retrieve those values by name. An object is an unordered collection of properties, each of which has a name and a value. Property names are strings, so we can say that objects map strings to values. This string-to-value mapping goes by various names: you are probably already familiar with the fundamental data structure under the name「hash,」「hashtable,」「dictionary,」or「associative array.」An object is more than a simple string-to-value map, however. In addition to maintaining its own set of properties, a JavaScript object also inherits the properties of another object, known as its「prototype.」The methods of an object are typically inherited properties, and this「prototypal inheritance」is a key feature of JavaScript.

JavaScript objects are dynamic—properties can usually be added and deleted—but they can be used to simulate the static objects and「structs」of statically typed languages. They can also be used (by ignoring the value part of the string-to-value mapping) to represent sets of strings.

Any value in JavaScript that is not a string, a number, true, false, null, or undefined is an object. And even though strings, numbers, and booleans are not objects, they behave like immutable objects (see Wrapper Objects).

Recall from Immutable Primitive Values and Mutable Object References that objects are mutable and are manipulated by reference rather than by value. If the variable x refers to an object, and the code var y = x; is executed, the variable y holds a reference to the same object, not a copy of that object. Any modifications made to the object through the variable y are also visible through the variable x.

The most common things to do with objects are create them and to set, query, delete, test, and enumerate their properties. These fundamental operations are described in the opening sections of this chapter. The sections that follow cover more advanced topics, many of which are specific to ECMAScript 5.

A property has a name and a value. A property name may be any string, including the empty string, but no object may have two properties with the same name. The value may be any JavaScript value, or (in ECMAScript 5) it may be a getter or a setter function (or both). We’ll learn about getter and setter functions in Property Getters and Setters. In addition to its name and value, each property has associated values that we’ll call property attributes:

The writable attribute specifies whether the value of the property can be set.

The enumerable attribute specifies whether the property name is returned by a for/in loop.

The configurable attribute specifies whether the property can be deleted and whether its attributes can be altered.

Prior to ECMAScript 5, all properties in objects created by your code are writable, enumerable, and configurable. In ECMAScript 5, you can configure the attributes of your properties. Property Attributes explains how to do this.

In addition to its properties, every object has three associated object attributes:

An object’s prototype is a reference to another object from which properties are inherited.

An object’s class is a string that categorizes the type of an object.

An object’s extensible flag specifies (in ECMAScript 5) whether new properties may be added to the object.

We’ll learn more about prototypes and property inheritance in Prototypes and Inheritance, and we will cover all three attributes in more detail in Object Attributes.

Finally, here are some terms we’ll use to distinguish among three broad categories of JavaScript objects and two types of properties:

A native object is an object or class of objects defined by the ECMAScript specification. Arrays, functions, dates, and regular expressions (for example) are native objects.

A host object is an object defined by the host environment (such as a web browser) within which the JavaScript interpreter is embedded. The HTMLElement objects that represent the structure of a web page in client-side JavaScript are host objects. Host objects may also be native objects, as when the host environment defines methods that are normal JavaScript Function objects.

A user-defined object is any object created by the execution of JavaScript code.

An own property is a property defined directly on an object.

An inherited property is a property defined by an object’s prototype object.

Creating Objects

Objects can be created with object literals, with the new keyword, and (in ECMA Script 5 ) with the Object.create() function. The subsections below describe each technique.

Object Literals

The easiest way to create an object is to include an object literal in your JavaScript code. An object literal is a comma-separated list of colon-separated name:value pairs, enclosed within curly braces. A property name is a JavaScript identifier or a string literal (the empty string is allowed). A property value is any JavaScript expression; the value of the expression (it may be a primitive value or an object value) becomes the value of the property. Here are some examples:

var empty = {}; // An object with no properties var point = { x:0, y:0 }; // Two properties var point2 = { x:point.x, y:point.y+1 }; // More complex values var book = { "main title": "JavaScript", // Property names include spaces, 'sub-title': "The Definitive Guide", // and hyphens, so use string literals "for": "all audiences", // for is a reserved word, so quote author: { // The value of this property is firstname: "David", // itself an object. Note that surname: "Flanagan" // these property names are unquoted. } };

In ECMAScript 5 (and some ECMAScript 3 implementations), reserved words may be used as property names without quoting. In general, however, property names that are reserved words must be quoted in ECMAScript 3. In ECMAScript 5, a trailing comma following the last property in an object literal is ignored. Trailing commas are ignored in most ECMAScript 3 implementations, but IE considers them an error.

An object literal is an expression that creates and initializes a new and distinct object each time it is evaluated. The value of each property is evaluated each time the literal is evaluated. This means that a single object literal can create many new objects if it appears within the body of a loop in a function that is called repeatedly, and that the property values of these objects may differ from each other.

Creating Objects with new

The new operator creates and initializes a new object. The new keyword must be followed by a function invocation. A function used in this way is called a constructor and serves to initialize a newly created object. Core JavaScript includes built-in constructors for native types. For example:

var o = new Object(); // Create an empty object: same as {}. var a = new Array(); // Create an empty array: same as []. var d = new Date(); // Create a Date object representing the current time var r = new RegExp("js"); // Create a RegExp object for pattern matching.

In addition to these built-in constructors, it is common to define your own constructor functions to initialize newly created objects. Doing so is covered in Chapter 9.

Prototypes

Before we can cover the third object creation technique, we must pause for a moment to explain prototypes. Every JavaScript object has a second JavaScript object (or null, but this is rare) associated with it. This second object is known as a prototype, and the first object inherits properties from the prototype.

All objects created by object literals have the same prototype object, and we can refer to this prototype object in JavaScript code as Object.prototype. Objects created using the new keyword and a constructor invocation use the value of the prototype property of the constructor function as their prototype. So the object created by new Object() inherits from Object.prototype just as the object created by {} does. Similarly, the object created by new Array() uses Array.prototype as its prototype, and the object created by new Date() uses Date.prototype as its prototype.

Object.prototype is one of the rare objects that has no prototype: it does not inherit any properties. Other prototype objects are normal objects that do have a prototype. All of the built-in constructors (and most user-defined constructors) have a prototype that inherits from Object.prototype. For example, Date.prototype inherits properties from Object.prototype, so a Date object created by new Date() inherits properties from both Date.prototype and Object.prototype. This linked series of prototype objects is known as a prototype chain.

An explanation of how property inheritance works is in Inheritance. We’ll learn how to query the prototype of an object in The prototype Attribute. And Chapter 9 explains the connection between prototypes and constructors in more detail: it shows how to define new「classes」of objects by writing a constructor function and setting its prototype property to the prototype object to be used by the「instances」created with that constructor.

Object.create()

ECMAScript 5 defines a method, Object.create(), that creates a new object, using its first argument as the prototype of that object. Object.create() also takes an optional second argument that describes the properties of the new object. This second argument is covered in Property Attributes.

Object.create() is a static function, not a method invoked on individual objects. To use it, simply pass the desired prototype object:

var o1 = Object.create({x:1, y:2}); // o1 inherits properties x and y.

You can pass null to create a new object that does not have a prototype, but if you do this, the newly created object will not inherit anything, not even basic methods like toString() (which means it won’t work with the + operator either):

var o2 = Object.create(null); // o2 inherits no props or methods.

If you want to create an ordinary empty object (like the object returned by {} or new Object()), pass Object.prototype:

var o3 = Object.create(Object.prototype); // o3 is like {} or new Object().

The ability to create a new object with an arbitrary prototype (put another way: the ability to create an「heir」for any object) is a powerful one, and we can simulate it in ECMAScript 3 with a function like the one in Example 6-1.[7]

Example 6-1. Creating a new object that inherits from a prototype

// inherit() returns a newly created object that inherits properties from the // prototype object p. It uses the ECMAScript 5 function Object.create() if // it is defined, and otherwise falls back to an older technique. function inherit(p) { if (p == null) throw TypeError(); // p must be a non-null object if (Object.create) // If Object.create() is defined... return Object.create(p); // then just use it. var t = typeof p; // Otherwise do some more type checking if (t !== "object" && t !== "function") throw TypeError(); function f() {}; // Define a dummy constructor function. f.prototype = p; // Set its prototype property to p. return new f(); // Use f() to create an "heir" of p. }

The code in the inherit() function will make more sense after we’ve covered constructors in Chapter 9. For now, please just accept that it returns a new object that inherits the properties of the argument object. Note that inherit() is not a full replacement for Object.create(): it does not allow the creation of objects with null prototypes, and it does not accept the optional second argument that Object.create() does. Nevertheless, we’ll use inherit() in a number of examples in this chapter and again in Chapter 9.

One use for our inherit() function is when you want to guard against unintended (but nonmalicious) modification of an object by a library function that you don’t have control over. Instead of passing the object directly to the function, you can pass an heir. If the function reads properties of the heir, it will see the inherited values. If it sets properties, however, those properties will only affect the heir, not your original object:

var o = { x: "don't change this value" }; library_function(inherit(o)); // Guard against accidental modifications of o

To understand why this works, you need to know how properties are queried and set in JavaScript. These are the topics of the next section.

* * *

[7] Douglas Crockford is generally credited as the first to propose a function that creates objects in this way. See http://javascript.crockford.com/prototypal.html.

Querying and Setting Properties

To obtain the value of a property, use the dot (.) or square bracket ([]) operators described in Property Access Expressions. The left-hand side should be an expression whose value is an object. If using the dot operator, the right-hand must be a simple identifier that names the property. If using square brackets, the value within the brackets must be an expression that evaluates to a string that contains the desired property name:

var author = book.author; // Get the "author" property of the book. var name = author.surname // Get the "surname" property of the author. var title = book["main title"] // Get the "main title" property of the book.

To create or set a property, use a dot or square brackets as you would to query the property, but put them on the left-hand side of an assignment expression:

book.edition = 6; // Create an "edition" property of book. book["main title"] = "ECMAScript"; // Set the "main title" property.

In ECMAScript 3, the identifier that follows the dot operator cannot be a reserved word: you cannot write o.for or o.class, for example, because for is a language keyword and class is reserved for future use. If an object has properties whose name is a reserved word, you must use square bracket notation to access them: o["for"] and o["class"]. ECMAScript 5 relaxes this restriction (as do some implementations of ECMAScript 3) and allows reserved words to follow the dot.

When using square bracket notation, we’ve said that the expression inside the square brackets must evaluate to a string. A more precise statement is that the expression must evaluate to a string or a value that can be converted to a string. In Chapter 7, for example, we’ll see that it is common to use numbers inside the square brackets.

Objects As Associative Arrays

As explained above, the following two JavaScript expressions have the same value:

object.property object["property"]

The first syntax, using the dot and an identifier, is like the syntax used to access a static field of a struct or object in C or Java. The second syntax, using square brackets and a string, looks like array access, but to an array indexed by strings rather than by numbers. This kind of array is known as an associative array (or hash or map or dictionary). JavaScript objects are associative arrays, and this section explains why that is important.

In C, C++, Java, and similar strongly typed languages, an object can have only a fixed number of properties, and the names of these properties must be defined in advance. Since JavaScript is a loosely typed language, this rule does not apply: a program can create any number of properties in any object. When you use the . operator to access a property of an object, however, the name of the property is expressed as an identifier. Identifiers must be typed literally into your JavaScript program; they are not a datatype, so they cannot be manipulated by the program.

On the other hand, when you access a property of an object with the [] array notation, the name of the property is expressed as a string. Strings are JavaScript datatypes, so they can be manipulated and created while a program is running. So, for example, you can write the following code in JavaScript:

var addr = ""; for(i = 0; i < 4; i++) { addr += customer["address" + i] + '\n';

This code reads and concatenates the address0, address1, address2, and address3 properties of the customer object.

This brief example demonstrates the flexibility of using array notation to access properties of an object with string expressions. The code above could be rewritten using the dot notation, but there are cases in which only the array notation will do. Suppose, for example, that you are writing a program that uses network resources to compute the current value of the user’s stock market investments. The program allows the user to type in the name of each stock she owns as well as the number of shares of each stock. You might use an object named portfolio to hold this information. The object has one property for each stock. The name of the property is the name of the stock, and the property value is the number of shares of that stock. So, for example, if a user holds 50 shares of stock in IBM, the portfolio.ibm property has the value 50.

Part of this program might be a function for adding a new stock to the portfolio:

function addstock(portfolio, stockname, shares) { portfolio[stockname] = shares; }

Since the user enters stock names at runtime, there is no way that you can know the property names ahead of time. Since you can’t know the property names when you write the program, there is no way you can use the . operator to access the properties of the portfolio object. You can use the [] operator, however, because it uses a string value (which is dynamic and can change at runtime) rather than an identifier (which is static and must be hardcoded in the program) to name the property.

Chapter 5 introduced the for/in loop (and we’ll see it again shortly in Enumerating Properties). The power of this JavaScript statement becomes clear when you consider its use with associative arrays. Here’s how you’d use it when computing the total value of a portfolio:

function getvalue(portfolio) { var total = 0.0; for(stock in portfolio) { // For each stock in the portfolio: var shares = portfolio[stock]; // get the number of shares var price = getquote(stock); // look up share price total += shares * price; // add stock value to total value } return total; // Return total value. }

Inheritance

JavaScript objects have a set of「own properties,」and they also inherit a set of properties from their prototype object. To understand this, we must consider property access in more detail. The examples in this section use the inherit() function from Example 6-1 in order to create objects with specified prototypes.

Suppose you query the property x in the object o. If o does not have an own property with that name, the prototype object of o is queried for the property x. If the prototype object does not have an own property by that name, but has a prototype itself, the query is performed on the prototype of the prototype. This continues until the property x is found or until an object with a null prototype is searched. As you can see, the prototype attribute of an object creates a chain or linked list from which properties are inherited.

var o = {} // o inherits object methods from Object.prototype o.x = 1; // and has an own property x. var p = inherit(o); // p inherits properties from o and Object.prototype p.y = 2; // and has an own property y. var q = inherit(p); // q inherits properties from p, o, and Object.prototype q.z = 3; // and has an own property z. var s = q.toString(); // toString is inherited from Object.prototype q.x + q.y // => 3: x and y are inherited from o and p

Now suppose you assign to the property x of the object o. If o already has an own (noninherited) property named x, then the assignment simply changes the value of this existing property. Otherwise, the assignment creates a new property named x on the object o. If o previously inherited the property x, that inherited property is now hidden by the newly created own property with the same name.

Property assignment examines the prototype chain to determine whether the assignment is allowed. If o inherits a read-only property named x, for example, then the assignment is not allowed. (Details about when a property may be set are in Property Access Errors.) If the assignment is allowed, however, it always creates or sets a property in the original object and never modifies the prototype chain. The fact that inheritance occurs when querying properties but not when setting them is a key feature of JavaScript because it allows us to selectively override inherited properties:

var unitcircle = { r:1 }; // An object to inherit from var c = inherit(unitcircle); // c inherits the property r c.x = 1; c.y = 1; // c defines two properties of its own c.r = 2; // c overrides its inherited property unitcircle.r; // => 1: the prototype object is not affected

There is one exception to the rule that a property assignment either fails or creates or sets a property in the original object. If o inherits the property x, and that property is an accessor property with a setter method (see Property Getters and Setters), then that setter method is called rather than creating a new property x in o. Note, however, that the setter method is called on the object o, not on the prototype object that defines the property, so if the setter method defines any properties, it will do so on o, and it will again leave the prototype chain unmodified.

Property Access Errors

Property access expressions do not always return or set a value. This section explains the things that can go wrong when you query or set a property.

It is not an error to query a property that does not exist. If the property x is not found as an own property or an inherited property of o, the property access expression o.x evaluates to undefined. Recall that our book object has a「sub-title」property, but not a「subtitle」property:

book.subtitle; // => undefined: property doesn't exist

It is an error, however, to attempt to query a property of an object that does not exist. The null and undefined values have no properties, and it is an error to query properties of these values. Continuing the above example:

// Raises a TypeError exception. undefined doesn't have a length property var len = book.subtitle.length;

Unless you are certain that both book and book.subtitle are (or behave like) objects, you shouldn’t write the expression book.subtitle.length, since it might raise an exception. Here are two ways to guard against this kind of exception:

// A verbose and explicit technique var len = undefined; if (book) { if (book.subtitle) len = book.subtitle.length; } // A concise and idiomatic alternative to get subtitle length or undefined var len = book && book.subtitle && book.subtitle.length;

To understand why this idiomatic expression works to prevent TypeError exceptions, you might want to review the short-circuiting behavior of the && operator in Logical AND (&&).

Attempting to set a property on null or undefined also causes a TypeError, of course. Attempts to set properties on other values do not always succeed, either: some properties are read-only and cannot be set, and some objects do not allow the addition of new properties. Curiously, however, these failed attempts to set properties usually fail silently:

// The prototype properties of built-in constructors are read-only. Object.prototype = 0; // Assignment fails silently; Object.prototype unchanged

This historical quirk of JavaScript is rectified in the strict mode of ECMAScript 5. In strict mode, any failed attempt to set a property throws a TypeError exception.

The rules that specify when a property assignment succeeds and when it fails are intuitive but difficult to express concisely. An attempt to set a property p of an object o fails in these circumstances:

o has an own property p that is read-only: it is not possible to set read-only properties. (See the defineProperty() method, however, for an exception that allows configurable read-only properties to be set.)

o has an inherited property p that is read-only: it is not possible to hide an inherited read-only property with an own property of the same name.

o does not have an own property p; o does not inherit a property p with a setter method, and o’s extensible attribute (see The extensible Attribute) is false. If p does not already exist on o, and if there is no setter method to call, then p must be added to o. But if o is not extensible, then no new properties can be defined on it.

Deleting Properties

The delete operator (The delete Operator) removes a property from an object. Its single operand should be a property access expression. Surprisingly, delete does not operate on the value of the property but on the property itself:

delete book.author; // The book object now has no author property. delete book["main title"]; // Now it doesn't have "main title", either.

The delete operator only deletes own properties, not inherited ones. (To delete an inherited property, you must delete it from the prototype object in which it is defined. Doing this affects every object that inherits from that prototype.)

A delete expression evaluates to true if the delete succeeded or if the delete had no effect (such as deleting a nonexistent property). delete also evaluates to true when used (meaninglessly) with an expression that is not a property access expression:

o = {x:1}; // o has own property x and inherits property toString delete o.x; // Delete x, and return true delete o.x; // Do nothing (x doesn't exist), and return true delete o.toString; // Do nothing (toString isn't an own property), return true delete 1; // Nonsense, but evaluates to true

delete does not remove properties that have a configurable attribute of false. (Though it will remove configurable properties of nonextensible objects.) Certain properties of built-in objects are nonconfigurable, as are properties of the global object created by variable declaration and function declaration. In strict mode, attempting to delete a nonconfigurable property causes a TypeError. In non-strict mode (and in ECMAScript 3), delete simply evaluates to false in this case:

delete Object.prototype; // Can't delete; property is non-configurable var x = 1; // Declare a global variable delete this.x; // Can't delete this property function f() {} // Declare a global function delete this.f; // Can't delete this property either

When deleting configurable properties of the global object in non-strict mode, you can omit the reference to the global object and simply follow the delete operator with the property name:

this.x = 1; // Create a configurable global property (no var) delete x; // And delete it

In strict mode, however, delete raises a SyntaxError if its operand is an unqualified identifier like x, and you have to be explicit about the property access:

delete x; // SyntaxError in strict mode delete this.x; // This works

Testing Properties

JavaScript objects can be thought of as sets of properties, and it is often useful to be able to test for membership in the set—to check whether an object has a property with a given name. You can do this with the in operator, with the hasOwnProperty() and propertyIsEnumerable() methods, or simply by querying the property.

The in operator expects a property name (as a string) on its left side and an object on its right. It returns true if the object has an own property or an inherited property by that name:

var o = { x: 1 } "x" in o; // true: o has an own property "x" "y" in o; // false: o doesn't have a property "y" "toString" in o; // true: o inherits a toString property

The hasOwnProperty() method of an object tests whether that object has an own property with the given name. It returns false for inherited properties:

var o = { x: 1 } o.hasOwnProperty("x"); // true: o has an own property x o.hasOwnProperty("y"); // false: o doesn't have a property y o.hasOwnProperty("toString"); // false: toString is an inherited property

The propertyIsEnumerable() refines the hasOwnProperty() test. It returns true only if the named property is an own property and its enumerable attribute is true. Certain built-in properties are not enumerable. Properties created by normal JavaScript code are enumerable unless you’ve used one of the ECMAScript 5 methods shown later to make them nonenumerable.

var o = inherit({ y: 2 }); o.x = 1; o.propertyIsEnumerable("x"); // true: o has an own enumerable property x o.propertyIsEnumerable("y"); // false: y is inherited, not own Object.prototype.propertyIsEnumerable("toString"); // false: not enumerable

Instead of using the in operator it is often sufficient to simply query the property and use !== to make sure it is not undefined:

var o = { x: 1 } o.x !== undefined; // true: o has a property x o.y !== undefined; // false: o doesn't have a property y o.toString !== undefined; // true: o inherits a toString property

There is one thing the in operator can do that the simple property access technique shown above cannot do. in can distinguish between properties that do not exist and properties that exist but have been set to undefined. Consider this code:

var o = { x: undefined } // Property is explicitly set to undefined o.x !== undefined // false: property exists but is undefined o.y !== undefined // false: property doesn't even exist "x" in o // true: the property exists "y" in o // false: the property doesn't exists delete o.x; // Delete the property x "x" in o // false: it doesn't exist anymore

Note that the code above uses the !== operator instead of !=. !== and === distinguish between undefined and null. Sometimes, however, you don’t want to make this distinction:

// If o has a property x whose value is not null or undefined, double it. if (o.x != null) o.x *= 2; // If o has a property x whose value does not convert to false, double it. // If x is undefined, null, false, "", 0, or NaN, leave it alone. if (o.x) o.x *= 2;

Enumerating Properties

Instead of testing for the existence of individual properties, we sometimes want to iterate through or obtain a list of all the properties of an object. This is usually done with the for/in loop, although ECMAScript 5 provides two handy alternatives.

The for/in loop was covered in for/in. It runs the body of the loop once for each enumerable property (own or inherited) of the specified object, assigning the name of the property to the loop variable. Built-in methods that objects inherit are not enumerable, but the properties that your code adds to objects are enumerable (unless you use one of the functions described later to make them nonenumerable). For example:

var o = {x:1, y:2, z:3}; // Three enumerable own properties o.propertyIsEnumerable("toString") // => false: not enumerable for(p in o) // Loop through the properties console.log(p); // Prints x, y, and z, but not toString

Some utility libraries add new methods (or other properties) to Object.prototype so that they are inherited by, and available to, all objects. Prior to ECMAScript 5, however, there is no way to make these added methods nonenumerable, so they are enumerated by for/in loops. To guard against this, you might want to filter the properties returned by for/in. Here are two ways you might do so:

for(p in o) { if (!o.hasOwnProperty(p)) continue; // Skip inherited properties } for(p in o) { if (typeof o[p] === "function") continue; // Skip methods }

Example 6-2 defines utility functions that use for/in loops to manipulate object properties in helpful ways. The extend() function, in particular, is one that is commonly included in JavaScript utility libraries.[8]

Example 6-2. Object utility functions that enumerate properties

/* * Copy the enumerable properties of p to o, and return o. * If o and p have a property by the same name, o's property is overwritten. * This function does not handle getters and setters or copy attributes. */ function extend(o, p) { for(prop in p) { // For all props in p. o[prop] = p[prop]; // Add the property to o. } return o; } /* * Copy the enumerable properties of p to o, and return o. * If o and p have a property by the same name, o's property is left alone. * This function does not handle getters and setters or copy attributes. */ function merge(o, p) { for(prop in p) { // For all props in p. if (o.hasOwnProperty[prop]) continue; // Except those already in o. o[prop] = p[prop]; // Add the property to o. } return o; } /* * Remove properties from o if there is not a property with the same name in p. * Return o. */ function restrict(o, p) { for(prop in o) { // For all props in o if (!(prop in p)) delete o[prop]; // Delete if not in p } return o; } /* * For each property of p, delete the property with the same name from o. * Return o. */ function subtract(o, p) { for(prop in p) { // For all props in p delete o[prop]; // Delete from o (deleting a // nonexistent prop is harmless) } return o; } /* * Return a new object that holds the properties of both o and p. * If o and p have properties by the same name, the values from o are used. */ function union(o,p) { return extend(extend({},o), p); } /* * Return a new object that holds only the properties of o that also appear * in p. This is something like the intersection of o and p, but the values of * the properties in p are discarded */ function intersection(o,p) { return restrict(extend({}, o), p); } /* * Return an array that holds the names of the enumerable own properties of o. */ function keys(o) { if (typeof o !== "object") throw TypeError(); // Object argument required var result = []; // The array we will return for(var prop in o) { // For all enumerable properties if (o.hasOwnProperty(prop)) // If it is an own property result.push(prop); // add it to the array. } return result; // Return the array. }

In addition to the for/in loop, ECMAScript 5 defines two functions that enumerate property names. The first is Object.keys(), which returns an array of the names of the enumerable own properties of an object. It works just like the keys() utility function shown in Example 6-2.

The second ECMAScript 5 property enumeration function is Object.getOwnPropertyNames(). It works like Object.keys() but returns the names of all the own properties of the specified object, not just the enumerable properties. There is no way to write this function in ECMAScript 3, because ECMAScript 3 does not provide a way to obtain the nonenumerable properties of an object.

* * *

[8] The implementation of extend() shown here is correct but does not compensate for a well-known bug in Internet Explorer. We’ll see a more robust version of extend() in Example 8-3.

Property Getters and Setters

We’ve said that an object property is a name, a value, and a set of attributes. In ECMAScript 5[9] the value may be replaced by one or two methods, known as a getter and a setter. Properties defined by getters and setters are sometimes known as accessor properties to distinguish them from data properties that have a simple value.

When a program queries the value of an accessor property, JavaScript invokes the getter method (passing no arguments). The return value of this method becomes the value of the property access expression. When a program sets the value of an accessor property, JavaScript invokes the setter method, passing the value of the right-hand side of the assignment. This method is responsible for「setting,」in some sense, the property value. The return value of the setter method is ignored.

Accessor properties do not have a writable attribute as data properties do. If a property has both a getter and a setter method, it is a read/write property. If it has only a getter method, it is a read-only property. And if it has only a setter method, it is a write-only property (something that is not possible with data properties) and attempts to read it always evaluate to undefined.

The easiest way to define accessor properties is with an extension to the object literal syntax:

var o = { // An ordinary data property data_prop: value, // An accessor property defined as a pair of functions get accessor_prop() { /* function body here */ }, set accessor_prop(value) { /* function body here */ } };

Accessor properties are defined as one or two functions whose name is the same as the property name, and with the function keyword replaced with get and/or set. Note that no colon is used to separate the name of the property from the functions that access that property, but that a comma is still required after the function body to separate the method from the next method or data property. As an example, consider the following object that represents a 2D Cartesian point. It has ordinary data properties to represent the X and Y coordinates of the point, and it has accessor properties for the equivalent polar coordinates of the point:

var p = { // x and y are regular read-write data properties. x: 1.0, y: 1.0, // r is a read-write accessor property with getter and setter. // Don't forget to put a comma after accessor methods. get r() { return Math.sqrt(this.x*this.x + this.y*this.y); }, set r(newvalue) { var oldvalue = Math.sqrt(this.x*this.x + this.y*this.y); var ratio = newvalue/oldvalue; this.x *= ratio; this.y *= ratio; }, // theta is a read-only accessor property with getter only. get theta() { return Math.atan2(this.y, this.x); } };

Note the use of the keyword this in the getters and setter above. JavaScript invokes these functions as methods of the object on which they are defined, which means that within the body of the function this refers to the point object. So the getter method for the r property can refer to the x and y properties as this.x and this.y. Methods and the this keyword are covered in more detail in Method Invocation.

Accessor properties are inherited, just as data properties are, so you can use the object p defined above as a prototype for other points. You can give the new objects their own x and y properties, and they’ll inherit the r and theta properties:

var q = inherit(p); // Create a new object that inherits getters and setters q.x = 0, q.y = 0; // Create q's own data properties console.log(q.r); // And use the inherited accessor properties console.log(q.theta);

The code above uses accessor properties to define an API that provides two representations (Cartesian coordinates and polar coordinates) of a single set of data. Other reasons to use accessor properties include sanity checking of property writes and returning different values on each property read:

// This object generates strictly increasing serial numbers var serialnum = { // This data property holds the next serial number. // The $ in the property name hints that it is a private property. $n: 0, // Return the current value and increment it get next() { return this.$n++; }, // Set a new value of n, but only if it is larger than current set next(n) { if (n >= this.$n) this.$n = n; else throw "serial number can only be set to a larger value"; } };

Finally, here is one more example that uses a getter method to implement a property with「magical」behavior.

// This object has accessor properties that return random numbers. // The expression "random.octet", for example, yields a random number // between 0 and 255 each time it is evaluated. var random = { get octet() { return Math.floor(Math.random()*256); }, get uint16() { return Math.floor(Math.random()*65536); }, get int16() { return Math.floor(Math.random()*65536)-32768; } };

This section has shown only how to define accessor properties when creating a new object from an object literal. The next section shows how to add accessor properties to existing objects.

* * *

[9] And in recent ECMAScript 3 versions of major browsers other than IE.

Property Attributes

In addition to a name and value, properties have attributes that specify whether they can be written, enumerated, and configured. In ECMAScript 3, there is no way to set these attributes: all properties created by ECMAScript 3 programs are writable, enumerable, and configurable, and there is no way to change this. This section explains the ECMAScript 5 API for querying and setting property attributes. This API is particularly important to library authors because:

It allows them to add methods to prototype objects and make them nonenumerable, like built-in methods.

It allows them to「lock down」their objects, defining properties that cannot be changed or deleted.

For the purposes of this section, we are going to consider getter and setter methods of an accessor property to be property attributes. Following this logic, we’ll even say that the value of a data property is an attribute as well. Thus, we can say that a property has a name and four attributes. The four attributes of a data property are value, writable, enumerable, and configurable. Accessor properties don’t have a value attribute or a writable attribute: their writability is determined by the presence or absence of a setter. So the four attributes of an accessor property are get, set, enumerable, and configurable.

The ECMAScript 5 methods for querying and setting the attributes of a property use an object called a property descriptor to represent the set of four attributes. A property descriptor object has properties with the same names as the attributes of the property it describes. Thus, the property descriptor object of a data property has properties named value, writable, enumerable, and configurable. And the descriptor for an accessor property has get and set properties instead of value and writable. The writable, enumerable, and configurable properties are boolean values, and the get and set properties are function values, of course.

To obtain the property descriptor for a named property of a specified object, call Object.getOwnPropertyDescriptor():

// Returns {value: 1, writable:true, enumerable:true, configurable:true} Object.getOwnPropertyDescriptor({x:1}, "x"); // Now query the octet property of the random object defined above. // Returns { get: /*func*/, set:undefined, enumerable:true, configurable:true} Object.getOwnPropertyDescriptor(random, "octet"); // Returns undefined for inherited properties and properties that don't exist. Object.getOwnPropertyDescriptor({}, "x"); // undefined, no such prop Object.getOwnPropertyDescriptor({}, "toString"); // undefined, inherited

As its name implies, Object.getOwnPropertyDescriptor() works only for own properties. To query the attributes of inherited properties, you must explicitly traverse the prototype chain (see Object.getPrototypeOf() in The prototype Attribute).

To set the attributes of a property, or to create a new property with the specified attributes, call Object.defineProperty(), passing the object to be modified, the name of the property to be created or altered, and the property descriptor object:

var o = {}; // Start with no properties at all // Add a nonenumerable data property x with value 1. Object.defineProperty(o, "x", { value : 1, writable: true, enumerable: false, configurable: true}); // Check that the property is there but is nonenumerable o.x; // => 1 Object.keys(o) // => [] // Now modify the property x so that it is read-only Object.defineProperty(o, "x", { writable: false }); // Try to change the value of the property o.x = 2; // Fails silently or throws TypeError in strict mode o.x // => 1 // The property is still configurable, so we can change its value like this: Object.defineProperty(o, "x", { value: 2 }); o.x // => 2 // Now change x from a data property to an accessor property Object.defineProperty(o, "x", { get: function() { return 0; } }); o.x // => 0

The property descriptor you pass to Object.defineProperty() does not have to include all four attributes. If you’re creating a new property, then omitted attributes are taken to be false or undefined. If you’re modifying an existing property, then the attributes you omit are simply left unchanged. Note that this method alters an existing own property or creates a new own property, but it will not alter an inherited property.

If you want to create or modify more than one property at a time, use Object.defineProperties(). The first argument is the object that is to be modified. The second argument is an object that maps the names of the properties to be created or modified to the property descriptors for those properties. For example:

var p = Object.defineProperties({}, { x: { value: 1, writable: true, enumerable:true, configurable:true }, y: { value: 1, writable: true, enumerable:true, configurable:true }, r: { get: function() { return Math.sqrt(this.x*this.x + this.y*this.y) }, enumerable:true, configurable:true } });

This code starts with an empty object, then adds two data properties and one read-only accessor property to it. It relies on the fact that Object.defineProperties() returns the modified object (as does Object.defineProperty()).

We saw the ECMAScript 5 method Object.create() in Creating Objects. We learned there that the first argument to that method is the prototype object for the newly created object. This method also accepts a second optional argument, which is the same as the second argument to Object.defineProperties(). If you pass a set of property descriptors to Object.create(), then they are used to add properties to the newly created object.

Object.defineProperty() and Object.defineProperties() throw TypeError if the attempt to create or modify a property is not allowed. This happens if you attempt to add a new property to a nonextensible (see The extensible Attribute) object. The other reasons that these methods might throw TypeError have to do with the attributes themselves. The writable attribute governs attempts to change the value attribute. And the configurable attribute governs attempts to change the other attributes (and also specifies whether a property can be deleted). The rules are not completely straightforward, however. It is possible to change the value of a nonwritable property if that property is configurable, for example. Also, it is possible to change a property from writable to nonwritable even if that property is nonconfigurable. Here are the complete rules. Calls to Object.defineProperty() or Object.defineProperties() that attempt to violate them throw TypeError:

If an object is not extensible, you can edit its existing own properties, but you cannot add new properties to it.

If a property is not configurable, you cannot change its configurable or enumerable attributes.

If an accessor property is not configurable, you cannot change its getter or setter method, and you cannot change it to a data property.

If a data property is not configurable, you cannot change it to an accessor property.

If a data property is not configurable, you cannot change its writable attribute from false to true, but you can change it from true to false.

If a data property is not configurable and not writable, you cannot change its value. You can change the value of a property that is configurable but nonwritable, however (because that would be the same as making it writable, then changing the value, then converting it back to nonwritable).

Example 6-2 included an extend() function that copied properties from one object to another. That function simply copied the name and value of the properties and ignored their attributes. Furthermore, it did not copy the getter and setter methods of accessor properties, but simply converted them into static data properties. Example 6-3 shows a new version of extend() that uses Object.getOwnPropertyDescriptor() and Object.defineProperty() to copy all property attributes. Rather than being written as a function, this version is defined as a new Object method and is added as a nonenumerable property to Object.prototype.

Example 6-3. Copying property attributes

/* * Add a nonenumerable extend() method to Object.prototype. * This method extends the object on which it is called by copying properties * from the object passed as its argument. All property attributes are * copied, not just the property value. All own properties (even non- * enumerable ones) of the argument object are copied unless a property * with the same name already exists in the target object. */ Object.defineProperty(Object.prototype, "extend", // Define Object.prototype.extend { writable: true, enumerable: false, // Make it nonenumerable configurable: true, value: function(o) { // Its value is this function // Get all own props, even nonenumerable ones var names = Object.getOwnPropertyNames(o); // Loop through them for(var i = 0; i < names.length; i++) { // Skip props already in this object if (names[i] in this) continue; // Get property description from o var desc = Object.getOwnPropertyDescriptor(o,names[i]); // Use it to create property on this Object.defineProperty(this, names[i], desc); } } });

Legacy API for Getters and Setters

The object literal syntax for accessor properties described in Property Getters and Setters allows us to define accessor properties in new objects, but it doesn’t allow us to query the getter and setter methods or to add new accessor properties to existing objects. In ECMAScript 5 we can use Object.getOwnPropertyDescriptor() and Object.defineProperty() to do these things.

Most JavaScript implementations (with the major exception of the IE web browser) supported the object literal get and set syntax even before the adoption of ECMAScript 5. These implementations support a nonstandard legacy API for querying and setting getters and setters. This API consists of four methods available on all objects. __lookupGetter__() and __lookupSetter__() return the getter or setter method for a named property. And __defineGetter__() and __defineSetter__() define a getter or setter: pass the property name first and the getter or setter method second. The names of each of these methods begin and end with double underscores to indicate that they are nonstandard methods. These nonstandard methods are not documented in the reference section.

Object Attributes

Every object has associated prototype, class, and extensible attributes. The subsections that follow explain what these attributes do and (where possible) how to query and set them.

The prototype Attribute

An object’s prototype attribute specifies the object from which it inherits properties. (Review Prototypes and Inheritance for more on prototypes and property inheritance.) This is such an important attribute that we’ll usually simply say「the prototype of o」rather than「the prototype attribute of o.」Also, it is important to understand that when prototype appears in code font, it refers to an ordinary object property, not to the prototype attribute.

The prototype attribute is set when an object is created. Recall from Prototypes that objects created from object literals use Object.prototype as their prototype. Objects created with new use the value of the prototype property of their constructor function as their prototype. And objects created with Object.create() use the first argument to that function (which may be null) as their prototype.

In ECMAScript 5, you can query the prototype of any object by passing that object to Object.getPrototypeOf(). There is no equivalent function in ECMAScript 3, but it is often possible to determine the prototype of an object o using the expression o.constructor.prototype. Objects created with a new expression usually inherit a constructor property that refers to the constructor function used to create the object. And, as described above, constructor functions have a prototype property that specifies the prototype for objects created using that constructor. This is explained in more detail in Classes and Constructors, which also explains why it is not a completely reliable method for determining an object’s prototype. Note that objects created by object literals or by Object.create() have a constructor property that refers to the Object() constructor. Thus, constructor.prototype refers to the correct prototype for object literals, but does not usually do so for objects created with Object.create().

To determine whether one object is the prototype of (or is part of the prototype chain of) another object, use the isPrototypeOf() method. To find out if p is the prototype of o write p.isPrototypeOf(o). For example:

var p = {x:1}; // Define a prototype object. var o = Object.create(p); // Create an object with that prototype. p.isPrototypeOf(o) // => true: o inherits from p Object.prototype.isPrototypeOf(o) // => true: p inherits from Object.prototype

Note that isPrototypeOf() performs a function similar to the instanceof operator (see The instanceof Operator).

Mozilla’s implementation of JavaScript has (since the early days of Netscape) exposed the prototype attribute through the specially named __proto__ property, and you can use this property to directly query or set the prototype of any object. Using __proto__ is not portable: it has not been (and probably never will be) implemented by IE or Opera, although it is currently supported by Safari and Chrome. Versions of Firefox that implement ECMAScript 5 still support __proto__, but restrict its ability to change the prototype of nonextensible objects.

The class Attribute

An object’s class attribute is a string that provides information about the type of the object. Neither ECMAScript 3 nor ECMAScript 5 provide any way to set this attribute, and there is only an indirect technique for querying it. The default toString() method (inherited from Object.prototype) returns a string of the form:

[object class]

So to obtain the class of an object, you can invoke this toString() method on it, and extract the eighth through the second-to-last characters of the returned string. The tricky part is that many objects inherit other, more useful toString() methods, and to invoke the correct version of toString(), we must do so indirectly, using the Function.call() method (see The call() and apply() Methods). Example 6-4 defines a function that returns the class of any object you pass it.

Example 6-4. A classof() function

function classof(o) { if (o === null) return "Null"; if (o === undefined) return "Undefined"; return Object.prototype.toString.call(o).slice(8,-1); }

This classof() function works for any JavaScript value. Numbers, strings, and booleans behave like objects when the toString() method is invoked on them, and the function includes special cases for null and undefined. (The special cases are not required in ECMAScript 5.) Objects created through built-in constructors such as Array and Date have class attributes that match the names of their constructors. Host objects typically have meaningful class attributes as well, though this is implementation-dependent. Objects created through object literals or by Object.create have a class attribute of「Object」. If you define your own constructor function, any objects you create with it will have a class attribute of「Object」: there is no way to specify the class attribute for your own classes of objects:

classof(null) // => "Null" classof(1) // => "Number" classof("") // => "String" classof(false) // => "Boolean" classof({}) // => "Object" classof([]) // => "Array" classof(/./) // => "Regexp" classof(new Date()) // => "Date" classof(window) // => "Window" (a client-side host object) function f() {}; // Define a custom constructor classof(new f()); // => "Object"

The extensible Attribute

The extensible attribute of an object specifies whether new properties can be added to the object or not. In ECMAScript 3, all built-in and user-defined objects are implicitly extensible, and the extensibility of host objects is implementation defined. In ECMAScript 5, all built-in and user-defined objects are extensible unless they have been converted to be nonextensible, and the extensibility of host objects is again implementation defined.

ECMAScript 5 defines functions for querying and setting the extensibility of an object. To determine whether an object is extensible, pass it to Object.isExtensible(). To make an object nonextensible, pass it to Object.preventExtensions(). Note that there is no way to make an object extensible again once you have made it nonextensible. Also note that calling preventExtensions() only affects the extensibility of the object itself. If new properties are added to the prototype of a nonextensible object, the nonextensible object will inherit those new properties.

The purpose of the extensible attribute is to be able to「lock down」objects into a known state and prevent outside tampering. The extensible object attribute is often used in conjunction with the configurable and writable property attributes, and ECMAScript 5 defines functions that make it easy to set these attributes together.

Object.seal() works like Object.preventExtensions(), but in addition to making the object nonextensible, it also makes all of the own properties of that object nonconfigurable. This means that new properties cannot be added to the object, and existing properties cannot be deleted or configured. Existing properties that are writable can still be set, however. There is no way to unseal a sealed object. You can use Object.isSealed() to determine whether an object is sealed.

Object.freeze() locks objects down even more tightly. In addition to making the object nonextensible and its properties nonconfigurable, it also makes all of the object’s own data properties read-only. (If the object has accessor properties with setter methods, these are not affected and can still be invoked by assignment to the property.) Use Object.isFrozen() to determine if an object is frozen.

It is important to understand that Object.seal() and Object.freeze() affect only the object they are passed: they have no effect on the prototype of that object. If you want to thoroughly lock down an object, you probably need to seal or freeze the objects in the prototype chain as well.

Object.preventExtensions(), Object.seal(), and Object.freeze() all return the object that they are passed, which means that you can use them in nested function invocations:

// Create a sealed object with a frozen prototype and a nonenumerable property var o = Object.seal(Object.create(Object.freeze({x:1}), {y: {value: 2, writable: true}}));

Serializing Objects

Object serialization is the process of converting an object’s state to a string from which it can later be restored. ECMAScript 5 provides native functions JSON.stringify() and JSON.parse() to serialize and restore JavaScript objects. These functions use the JSON data interchange format. JSON stands for「JavaScript Object Notation,」and its syntax is very similar to that of JavaScript object and array literals:

o = {x:1, y:{z:[false,null,""]}}; // Define a test object s = JSON.stringify(o); // s is '{"x":1,"y":{"z":[false,null,""]}}' p = JSON.parse(s); // p is a deep copy of o

The native implementation of these functions in ECMAScript 5 was modeled very closely after the public-domain ECMAScript 3 implementation available at http://json.org/json2.js. For practical purposes, the implementations are the same, and you can use these ECMAScript 5 functions in ECMAScript 3 with this json2.js module.

JSON syntax is a subset of JavaScript syntax, and it cannot represent all JavaScript values. Objects, arrays, strings, finite numbers, true, false, and null are supported and can be serialized and restored. NaN, Infinity, and -Infinity are serialized to null. Date objects are serialized to ISO-formatted date strings (see the Date.toJSON() function), but JSON.parse() leaves these in string form and does not restore the original Date object. Function, RegExp, and Error objects and the undefined value cannot be serialized or restored. JSON.stringify() serializes only the enumerable own properties of an object. If a property value cannot be serialized, that property is simply omitted from the stringified output. Both JSON.stringify() and JSON.parse() accept optional second arguments that can be used to customize the serialization and/or restoration process by specifying a list of properties to be serialized, for example, or by converting certain values during the serialization or stringification process. Complete documentation for these functions is in the reference section.

Object Methods

As discussed earlier, all JavaScript objects (except those explicitly created without a prototype) inherit properties from Object.prototype. These inherited properties are primarily methods, and because they are universally available, they are of particular interest to JavaScript programmers. We’ve already seen the hasOwnProperty(), propertyIsEnumerable(), and isPrototypeOf() methods. (And we’ve also already covered quite a few static functions defined on the Object constructor, such as Object.create() and Object.getPrototypeOf().) This section explains a handful of universal object methods that are defined on Object.prototype, but which are intended to be overridden by other, more specialized classes.

The toString() Method

The toString() method takes no arguments; it returns a string that somehow represents the value of the object on which it is invoked. JavaScript invokes this method of an object whenever it needs to convert the object to a string. This occurs, for example, when you use the + operator to concatenate a string with an object or when you pass an object to a method that expects a string.

The default toString() method is not very informative (though it is useful for determining the class of an object, as we saw in The class Attribute). For example, the following line of code simply evaluates to the string「[object Object]」:

var s = { x:1, y:1 }.toString();

Because this default method does not display much useful information, many classes define their own versions of toString(). For example, when an array is converted to a string, you obtain a list of the array elements, themselves each converted to a string, and when a function is converted to a string, you obtain the source code for the function. These customized versions of the toString() method are documented in the reference section. See Array.toString(), Date.toString(), and Function.toString(), for example.

Standard Conversion Methods describes how to define a custom toString() method for your own classes.

The toLocaleString() Method

In addition to the basic toString() method, objects all have a toLocaleString(). The purpose of this method is to return a localized string representation of the object. The default toLocaleString() method defined by Object doesn’t do any localization itself: it simply calls toString() and returns that value. The Date and Number classes define customized versions of toLocaleString() that attempt to format numbers, dates, and times according to local conventions. Array defines a toLocaleString() method that works like toString() except that it formats array elements by calling their toLocaleString() methods instead of their toString() methods.

The toJSON() Method

Object.prototype does not actually define a toJSON() method, but the JSON.stringify() method (see Serializing Objects) looks for a toJSON() method on any object it is asked to serialize. If this method exists on the object to be serialized, it is invoked, and the return value is serialized, instead of the original object. See Date.toJSON() for an example.

The valueOf() Method

The valueOf() method is much like the toString() method, but it is called when JavaScript needs to convert an object to some primitive type other than a string—typically, a number. JavaScript calls this method automatically if an object is used in a context where a primitive value is required. The default valueOf() method does nothing interesting, but some of the built-in classes define their own valueOf() method (see Date.valueOf(), for example). Standard Conversion Methods explains how to define a valueOf() method for custom object types you define.

Chapter 7. Arrays

An array is an ordered collection of values. Each value is called an element, and each element has a numeric position in the array, known as its index. JavaScript arrays are untyped: an array element may be of any type, and different elements of the same array may be of different types. Array elements may even be objects or other arrays, which allows you to create complex data structures, such as arrays of objects and arrays of arrays. JavaScript arrays are zero-based and use 32-bit indexes: the index of the first element is 0, and the highest possible index is 4294967294 (232−2), for a maximum array size of 4,294,967,295 elements. JavaScript arrays are dynamic: they grow or shrink as needed and there is no need to declare a fixed size for the array when you create it or to reallocate it when the size changes. JavaScript arrays may be sparse: the elements need not have contiguous indexes and there may be gaps. Every JavaScript array has a length property. For nonsparse arrays, this property specifies the number of elements in the array. For sparse arrays, length is larger than the index of all elements.

JavaScript arrays are a specialized form of JavaScript object, and array indexes are really little more than property names that happen to be integers. We’ll talk more about the specializations of arrays elsewhere in this chapter. Implementations typically optimize arrays so that access to numerically indexed array elements is generally significantly faster than access to regular object properties.

Arrays inherit properties from Array.prototype, which defines a rich set of array manipulation methods, covered in Array Methods and ECMAScript 5 Array Methods. Most of these methods are generic, which means that they work correctly not only for true arrays, but for any「array-like object.」We’ll discuss array-like objects in Array-Like Objects. In ECMAScript 5, strings behave like arrays of characters, and we’ll discuss this in Strings As Arrays.

Creating Arrays

The easiest way to create an array is with an array literal, which is simply a comma-separated list of array elements within square brackets. For example:

var empty = []; // An array with no elements var primes = [2, 3, 5, 7, 11]; // An array with 5 numeric elements var misc = [ 1.1, true, "a", ]; // 3 elements of various types + trailing comma

The values in an array literal need not be constants; they may be arbitrary expressions:

var base = 1024; var table = [base, base+1, base+2, base+3];

Array literals can contain object literals or other array literals:

var b = [[1,{x:1, y:2}], [2, {x:3, y:4}]];

If you omit a value from an array literal, the omitted element is given the value undefined:

var count = [1,,3]; // An array with 3 elements, the middle one undefined. var undefs = [,,]; // An array with 2 elements, both undefined.

Array literal syntax allows an optional trailing comma, so [,,] has only two elements, not three.

Another way to create an array is with the Array() constructor. You can invoke this constructor in three distinct ways:

Call it with no arguments:

var a = new Array();

This method creates an empty array with no elements and is equivalent to the array literal [].

Call it with a single numeric argument, which specifies a length:

var a = new Array(10);

This technique creates an array with the specified length. This form of the Array() constructor can be used to preallocate an array when you know in advance how many elements will be required. Note that no values are stored in the array, and the array index properties「0」,「1」, and so on are not even defined for the array.

Explicitly specify two or more array elements or a single non-numeric element for the array:

var a = new Array(5, 4, 3, 2, 1, "testing, testing");

In this form, the constructor arguments become the elements of the new array. Using an array literal is almost always simpler than this usage of the Array() constructor.

Reading and Writing Array Elements

You access an element of an array using the [] operator. A reference to the array should appear to the left of the brackets. An arbitrary expression that has a non-negative integer value should be inside the brackets. You can use this syntax to both read and write the value of an element of an array. Thus, the following are all legal JavaScript statements:

var a = ["world"]; // Start with a one-element array var value = a[0]; // Read element 0 a[1] = 3.14; // Write element 1 i = 2; a[i] = 3; // Write element 2 a[i + 1] = "hello"; // Write element 3 a[a[i]] = a[0]; // Read elements 0 and 2, write element 3

Remember that arrays are a specialized kind of object. The square brackets used to access array elements work just like the square brackets used to access object properties. JavaScript converts the numeric array index you specify to a string—the index 1 becomes the string "1"—then uses that string as a property name. There is nothing special about the conversion of the index from a number to a string: you can do that with regular objects, too:

o = {}; // Create a plain object o[1] = "one"; // Index it with an integer

What is special about arrays is that when you use property names that are non-negative integers less than 232, the array automatically maintains the value of the length property for you. Above, for example, we created an array a with a single element. We then assigned values at indexes 1, 2, and 3. The length property of the array changed as we did so:

a.length // => 4

It is helpful to clearly distinguish an array index from an object property name. All indexes are property names, but only property names that are integers between 0 and 232–1 are indexes. All arrays are objects, and you can create properties of any name on them. If you use properties that are array indexes, however, arrays have the special behavior of updating their length property as needed.

Note that you can index an array using numbers that are negative or that are not integers. When you do this, the number is converted to a string, and that string is used as the property name. Since the name is not a non-negative integer, it is treated as a regular object property, not an array index. Also, if you index an array with a string that happens to be a non-negative integer, it behaves as an array index, not an object property. The same is true if you use a floating-point number that is the same as an integer:

a[-1.23] = true; // This creates a property named "-1.23" a["1000"] = 0; // This the 1001st element of the array a[1.000] // Array index 1. Same as a[1]

The fact that array indexes are simply a special type of object property name means that JavaScript arrays have no notion of an「out of bounds」error. When you try to query a nonexistent property of any object, you don’t get an error, you simply get undefined. This is just as true for arrays as it is for objects:

a = [true, false]; // This array has elements at indexes 0 and 1 a[2] // => undefined. No element at this index. a[-1] // => undefined. No property with this name.

Since arrays are objects, they can inherit elements from their prototype. In ECMAScript 5, they can even have array elements defined by getter and setter methods (Property Getters and Setters). If an array does inherit elements or use getters and setters for elements, you should expect it to use a nonoptimized code path: the time to access an element of such an array would be similar to regular object property lookup times.

Sparse Arrays

A sparse array is one in which the elements do not have contiguous indexes starting at 0. Normally, the length property of an array specifies the number of elements in the array. If the array is sparse, the value of the length property is greater than the number of elements. Sparse arrays can be created with the Array() constructor or simply by assigning to an array index larger than the current array length.

a = new Array(5); // No elements, but a.length is 5. a = []; // Create an array with no elements and length = 0. a[1000] = 0; // Assignment adds one element but sets length to 1001.

We’ll see later that you can also make an array sparse with the delete operator.

Arrays that are sufficiently sparse are typically implemented in a slower, more memory-efficient way than dense arrays are, and looking up elements in such an array will take about as much time as regular object property lookup.

Note that when you omit value in an array literal, you are not creating a sparse array. The omitted element exists in the array and has the value undefined. This is subtly different than array elements that do not exist at all. You can detect the difference between these two cases with the in operator:

var a1 = [,,,]; // This array is [undefined, undefined, undefined] var a2 = new Array(3); // This array has no values at all 0 in a1 // => true: a1 has an element with index 0 0 in a2 // => false: a2 has no element with index 0

The difference between a1 and a2 is also apparent when you use a for/in loop. See Iterating Arrays.

Understanding sparse arrays is an important part of understanding the true nature of JavaScript arrays. In practice, however, most JavaScript arrays you will work with will not be sparse. And, if you do have to work with a sparse array, your code will probably treat it just as it would treat a nonsparse array with undefined elements.

Array Length

Every array has a length property, and it is this property that makes arrays different from regular JavaScript objects. For arrays that are dense (i.e., not sparse), the length property specifies the number of elements in the array. Its value is one more than the highest index in the array:

[].length // => 0: the array has no elements ['a','b','c'].length // => 3: highest index is 2, length is 3

When an array is sparse, the length property is greater than the number of elements, and all we can say about it is that length is guaranteed to be larger than the index of every element in the array. Or, put another way, an array (sparse or not) will never have an element whose index is greater than or equal to its length. In order to maintain this invariant, arrays have two special behaviors. The first was described above: if you assign a value to an array element whose index i is greater than or equal to the array’s current length, the value of the length property is set to i+1.

The second special behavior that arrays implement in order to maintain the length invariant is that if you set the length property to a non-negative integer n smaller than its current value, any array elements whose index is greater than or equal to n are deleted from the array:

a = [1,2,3,4,5]; // Start with a 5-element array. a.length = 3; // a is now [1,2,3]. a.length = 0; // Delete all elements. a is []. a.length = 5; // Length is 5, but no elements, like new Array(5)

You can also set the length property of an array to a value larger than its current value. Doing this does not actually add any new elements to the array, it simply creates a sparse area at the end of the array.

In ECMAScript 5, you can make the length property of an array read-only with Object.defineProperty() (see Property Attributes):

a = [1,2,3]; // Start with a 3-element array. Object.defineProperty(a, "length", // Make the length property {writable: false}); // readonly. a.length = 0; // a is unchanged.

Similarly, if you make an array element nonconfigurable, it cannot be deleted. If it cannot be deleted, then the length property cannot be set to less than the index of the nonconfigurable element. (See Property Attributes and the Object.seal() and Object.freeze() methods in The extensible Attribute.)

Adding and Deleting Array Elements

We’ve already seen the simplest way to add elements to an array: just assign values to new indexes:

a = [] // Start with an empty array. a[0] = "zero"; // And add elements to it. a[1] = "one";

You can also use the push() method to add one or more values to the end of an array:

a = []; // Start with an empty array a.push("zero") // Add a value at the end. a = ["zero"] a.push("one", "two") // Add two more values. a = ["zero", "one", "two"]

Pushing a value onto an array a is the same as assigning the value to a[a.length]. You can use the unshift() method (described in Array Methods) to insert a value at the beginning of an array, shifting the existing array elements to higher indexes.

You can delete array elements with the delete operator, just as you can delete object properties:

a = [1,2,3]; delete a[1]; // a now has no element at index 1 1 in a // => false: no array index 1 is defined a.length // => 3: delete does not affect array length

Deleting an array element is similar to (but subtly different than) assigning undefined to that element. Note that using delete on an array element does not alter the length property and does not shift elements with higher indexes down to fill in the gap that is left by the deleted property. If you delete an element from an array, the array becomes sparse.

As we saw above, you can also delete elements from the end of an array simply by setting the length property to the new desired length. Arrays have a pop() method (it works with push()) that reduces the length of an array by 1 but also returns the value of the deleted element. There is also a shift() method (which goes with unshift()) to remove an element from the beginning of an array. Unlike delete, the shift() method shifts all elements down to an index one lower than their current index. pop() and shift() are covered in Array Methods and in the reference section.

Finally, splice() is the general-purpose method for inserting, deleting, or replacing array elements. It alters the length property and shifts array elements to higher or lower indexes as needed. See Array Methods for details.

Iterating Arrays

The most common way to loop through the elements of an array is with a for loop (for):

var keys = Object.keys(o); // Get an array of property names for object o var values = [] // Store matching property values in this array for(var i = 0; i < keys.length; i++) { // For each index in the array var key = keys[i]; // Get the key at that index values[i] = o[key]; // Store the value in the values array }

In nested loops, or other contexts where performance is critical, you may sometimes see this basic array iteration loop optimized so that the array length is only looked up once rather than on each iteration:

for(var i = 0, len = keys.length; i < len; i++) { // loop body remains the same }

These examples assume that the array is dense and that all elements contain valid data. If this is not the case, you should test the array elements before using them. If you want to exclude null, undefined, and nonexistent elements, you can write this:

for(var i = 0; i < a.length; i++) { if (!a[i]) continue; // Skip null, undefined, and nonexistent elements // loop body here }

If you only want to skip undefined and nonexistent elements, you might write:

for(var i = 0; i < a.length; i++) { if (a[i] === undefined) continue; // Skip undefined + nonexistent elements // loop body here }

Finally, if you only want to skip indexes for which no array element exists but still want to handle existing undefined elements, do this:

for(var i = 0; i < a.length; i++) { if (!(i in a)) continue ; // Skip nonexistent elements // loop body here }

You can also use a for/in loop (for/in) with sparse arrays. This loop assigns enumerable property names (including array indexes) to the loop variable one at a time. Indexes that do not exist will not be iterated:

for(var index in sparseArray) { var value = sparseArray[index]; // Now do something with index and value }

As noted in Enumerating Properties, a for/in loop can return the names of inherited properties, such as the names of methods that have been added to Array.prototype. For this reason you should not use a for/in loop on an array unless you include an additional test to filter out unwanted properties. You might use either of these tests:

for(var i in a) { if (!a.hasOwnProperty(i)) continue; // Skip inherited properties // loop body here } for(var i in a) { // Skip i if it is not a non-negative integer if (String(Math.floor(Math.abs(Number(i)))) !== i) continue; }

The ECMAScript specification allows the for/in loop to iterate the properties of an object in any order. Implementations typically iterate array elements in ascending order, but this is not guaranteed. In particular, if an array has both object properties and array elements, the property names may be returned in the order they were created, rather than in numeric order. Implementations differ in how they handle this case, so if iteration order matters for your algorithm, it is best to use a regular for loop instead of for/in.

ECMAScript 5 defines a number of new methods for iterating array elements by passing each one, in index order, to a function that you define. The forEach() method is the most general of these methods:

var data = [1,2,3,4,5]; // This is the array we want to iterate var sumOfSquares = 0; // We want to compute the sum of the squares of data data.forEach(function(x) { // Pass each element of data to this function sumOfSquares += x*x; // add up the squares }); sumOfSquares // =>55 : 1+4+9+16+25

forEach() and related iteration methods enable a simple and powerful functional programming style for working with arrays. They are covered in ECMAScript 5 Array Methods, and we’ll return to them in Functional Programming, when we cover functional programming.

Multidimensional Arrays

JavaScript does not support true multidimensional arrays, but you can approximate them with arrays of arrays. To access a value in an array of arrays, simply use the [] operator twice. For example, suppose the variable matrix is an array of arrays of numbers. Every element in matrix[x] is an array of numbers. To access a particular number within this array, you would write matrix[x][y]. Here is a concrete example that uses a two-dimensional array as a multiplication table:

// Create a multidimensional array var table = new Array(10); // 10 rows of the table for(var i = 0; i < table.length; i++) table[i] = new Array(10); // Each row has 10 columns // Initialize the array for(var row = 0; row < table.length; row++) { for(col = 0; col < table[row].length; col++) { table[row][col] = row*col; } } // Use the multidimensional array to compute 5*7 var product = table[5][7]; // 35

Array Methods

ECMAScript 3 defines a number of useful array manipulation functions on Array.prototype, which means that they are available as methods of any array. These ECMAScript 3 methods are introduced in the subsections below. As usual, complete details can be found under Array in the client-side reference section. ECMAScript 5 adds new array iteration methods; those methods are covered in ECMAScript 5 Array Methods.

join()

The Array.join() method converts all the elements of an array to strings and concatenates them, returning the resulting string. You can specify an optional string that separates the elements in the resulting string. If no separator string is specified, a comma is used. For example, the following lines of code produce the string「1,2,3」:

var a = [1, 2, 3]; // Create a new array with these three elements a.join(); // => "1,2,3" a.join(" "); // => "1 2 3" a.join(""); // => "123" var b = new Array(10); // An array of length 10 with no elements b.join('-') // => '---------': a string of 9 hyphens

The Array.join() method is the inverse of the String.split() method, which creates an array by breaking a string into pieces.

reverse()

The Array.reverse() method reverses the order of the elements of an array and returns the reversed array. It does this in place; in other words, it doesn’t create a new array with the elements rearranged but instead rearranges them in the already existing array. For example, the following code, which uses the reverse() and join() methods, produces the string「3,2,1」:

var a = [1,2,3]; a.reverse().join() // => "3,2,1" and a is now [3,2,1]

sort()

Array.sort() sorts the elements of an array in place and returns the sorted array. When sort() is called with no arguments, it sorts the array elements in alphabetical order (temporarily converting them to strings to perform the comparison, if necessary):

var a = new Array("banana", "cherry", "apple"); a.sort(); var s = a.join(", "); // s == "apple, banana, cherry"

If an array contains undefined elements, they are sorted to the end of the array.

To sort an array into some order other than alphabetical, you must pass a comparison function as an argument to sort(). This function decides which of its two arguments should appear first in the sorted array. If the first argument should appear before the second, the comparison function should return a number less than zero. If the first argument should appear after the second in the sorted array, the function should return a number greater than zero. And if the two values are equivalent (i.e., if their order is irrelevant), the comparison function should return 0. So, for example, to sort array elements into numerical rather than alphabetical order, you might do this:

var a = [33, 4, 1111, 222]; a.sort(); // Alphabetical order: 1111, 222, 33, 4 a.sort(function(a,b) { // Numerical order: 4, 33, 222, 1111 return a-b; // Returns &lt; 0, 0, or &gt; 0, depending on order }); a.sort(function(a,b) {return b-a}); // Reverse numerical order

Note the convenient use of unnamed function expressions in this code. Since the comparison functions are used only once, there is no need to give them names.

As another example of sorting array items, you might perform a case-insensitive alphabetical sort on an array of strings by passing a comparison function that converts both of its arguments to lowercase (with the toLowerCase() method) before comparing them:

a = ['ant', 'Bug', 'cat', 'Dog'] a.sort(); // case-sensitive sort: ['Bug','Dog','ant',cat'] a.sort(function(s,t) { // Case-insensitive sort var a = s.toLowerCase(); var b = t.toLowerCase(); if (a < b) return -1; if (a > b) return 1; return 0; }); // => ['ant','Bug','cat','Dog']

concat()

The Array.concat() method creates and returns a new array that contains the elements of the original array on which concat() was invoked, followed by each of the arguments to concat(). If any of these arguments is itself an array, then it is the array elements that are concatenated, not the array itself. Note, however, that concat() does not recursively flatten arrays of arrays. concat() does not modify the array on which it is invoked. Here are some examples:

var a = [1,2,3]; a.concat(4, 5) // Returns [1,2,3,4,5] a.concat([4,5]); // Returns [1,2,3,4,5] a.concat([4,5],[6,7]) // Returns [1,2,3,4,5,6,7] a.concat(4, [5,[6,7]]) // Returns [1,2,3,4,5,[6,7]]

slice()

The Array.slice() method returns a slice, or subarray, of the specified array. Its two arguments specify the start and end of the slice to be returned. The returned array contains the element specified by the first argument and all subsequent elements up to, but not including, the element specified by the second argument. If only one argument is specified, the returned array contains all elements from the start position to the end of the array. If either argument is negative, it specifies an array element relative to the last element in the array. An argument of -1, for example, specifies the last element in the array, and an argument of -3 specifies the third from last element of the array. Note that slice() does not modify the array on which it is invoked. Here are some examples:

var a = [1,2,3,4,5]; a.slice(0,3); // Returns [1,2,3] a.slice(3); // Returns [4,5] a.slice(1,-1); // Returns [2,3,4] a.slice(-3,-2); // Returns [3]

splice()

The Array.splice() method is a general-purpose method for inserting or removing elements from an array. Unlike slice() and concat(), splice() modifies the array on which it is invoked. Note that splice() and slice() have very similar names but perform substantially different operations.

splice() can delete elements from an array, insert new elements into an array, or perform both operations at the same time. Elements of the array that come after the insertion or deletion point have their indexes increased or decreased as necessary so that they remain contiguous with the rest of the array. The first argument to splice() specifies the array position at which the insertion and/or deletion is to begin. The second argument specifies the number of elements that should be deleted from (spliced out of) the array. If this second argument is omitted, all array elements from the start element to the end of the array are removed. splice() returns an array of the deleted elements, or an empty array if no elements were deleted. For example:

var a = [1,2,3,4,5,6,7,8]; a.splice(4); // Returns [5,6,7,8]; a is [1,2,3,4] a.splice(1,2); // Returns [2,3]; a is [1,4] a.splice(1,1); // Returns [4]; a is [1]

The first two arguments to splice() specify which array elements are to be deleted. These arguments may be followed by any number of additional arguments that specify elements to be inserted into the array, starting at the position specified by the first argument. For example:

var a = [1,2,3,4,5]; a.splice(2,0,'a','b'); // Returns []; a is [1,2,'a','b',3,4,5] a.splice(2,2,[1,2],3); // Returns ['a','b']; a is [1,2,[1,2],3,3,4,5]

Note that, unlike concat(), splice() inserts arrays themselves, not the elements of those arrays.

