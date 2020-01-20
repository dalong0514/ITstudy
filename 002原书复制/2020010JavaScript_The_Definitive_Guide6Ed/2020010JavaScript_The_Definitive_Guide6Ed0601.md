r instanceof Range // returns true if r inherits from Range.prototype

The instanceof operator does not actually check whether r was initialized by the Range constructor. It checks whether it inherits from Range.prototype. Nevertheless, the instanceof syntax reinforces the use of constructors as the public identity of a class. We’ll see the instanceof operator again later in this chapter.

The constructor Property

In Example 9-2 we set Range.prototype to a new object that contained the methods for our class. Although it was convenient to express those methods as properties of a single object literal, it was not actually necessary to create a new object. Any JavaScript function can be used as a constructor, and constructor invocations need a prototype property. Therefore, every JavaScript function (except functions returned by the ECMAScript 5 Function.bind() method) automatically has a prototype property. The value of this property is an object that has a single nonenumerable constructor property. The value of the constructor property is the function object:

var F = function() {}; // This is a function object. var p = F.prototype; // This is the prototype object associated with it. var c = p.constructor; // This is the function associated with the prototype. c === F // => true: F.prototype.constructor==F for any function

The existence of this predefined prototype object with its constructor property means that objects typically inherit a constructor property that refers to their constructor. Since constructors serve as the public identity of a class, this constructor property gives the class of an object:

var o = new F(); // Create an object o of class F o.constructor === F // => true: the constructor property specifies the class

Figure 9-1 illustrates this relationship between the constructor function, its prototype object, the back reference from the prototype to the constructor, and the instances created with the constructor.

Figure 9-1. A constructor function, its prototype, and instances

Notice that Figure 9-1 uses our Range() constructor as an example. In fact, however, the Range class defined in Example 9-2 overwrites the predefined Range.prototype object with an object of its own. And the new prototype object it defines does not have a constructor property. So instances of the Range class, as defined, do not have a constructor property. We can remedy this problem by explicitly adding a constructor to the prototype:

Range.prototype = { constructor: Range, // Explicitly set the constructor back-reference includes: function(x) { return this.from <= x && x <= this.to; }, foreach: function(f) { for(var x = Math.ceil(this.from); x <= this.to; x++) f(x); }, toString: function() { return "(" + this.from + "..." + this.to + ")"; } };

Another common technique is to use the predefined prototype object with its constructor property, and add methods to it one at a time:

// Extend the predefined Range.prototype object so we don't overwrite // the automatically created Range.prototype.constructor property. Range.prototype.includes = function(x) { return this.from<=x && x<=this.to; }; Range.prototype.foreach = function(f) { for(var x = Math.ceil(this.from); x <= this.to; x++) f(x); }; Range.prototype.toString = function() { return "(" + this.from + "..." + this.to + ")"; };

Java-Style Classes in JavaScript

If you have programmed in Java or a similar strongly-typed object-oriented language, you may be accustomed to thinking about four kinds of class members:

Instance fields

These are the per-instance properties or variables that hold the state of individual objects.

Instance methods

These are methods that are shared by all instances of the class that are invoked through individual instances.

Class fields

These are properties or variables associated with the class rather than the instances of the class.

Class methods

These are methods that are associated with the class rather than with instances.

One way JavaScript differs from Java is that its functions are values, and there is no hard distinction between methods and fields. If the value of a property is a function, that property defines a method; otherwise, it is just an ordinary property or「field.」Despite this difference, we can simulate each of Java’s four categories of class members in JavaScript. In JavaScript, there are three different objects involved in any class definition (see Figure 9-1), and the properties of these three objects act like different kinds of class members:

Constructor object

As we’ve noted, the constructor function (an object) defines a name for a JavaScript class. Properties you add to this constructor object serve as class fields and class methods (depending on whether the property values are functions or not).

Prototype object

The properties of this object are inherited by all instances of the class, and properties whose values are functions behave like instance methods of the class.

Instance object

Each instance of a class is an object in its own right, and properties defined directly on an instance are not shared by any other instances. Nonfunction properties defined on instances behave as the instance fields of the class.

We can reduce the process of class definition in JavaScript to a three-step algorithm. First, write a constructor function that sets instance properties on new objects. Second, define instance methods on the prototype object of the constructor. Third, define class fields and class properties on the constructor itself. We can even implement this algorithm as a simple defineClass() function. (It uses the extend() function of Example 6-2 as patched in Example 8-3):

// A simple function for defining simple classes function defineClass(constructor, // A function that sets instance properties methods, // Instance methods: copied to prototype statics) // Class properties: copied to constructor { if (methods) extend(constructor.prototype, methods); if (statics) extend(constructor, statics); return constructor; } // This is a simple variant of our Range class var SimpleRange = defineClass(function(f,t) { this.f = f; this.t = t; }, { includes: function(x) { return this.f <= x && x <= this.t;}, toString: function() { return this.f + "..." + this.t; } }, { upto: function(t) { return new SimpleRange(0, t); } });

Example 9-3 is a longer class definition. It creates a class that represents complex numbers and demonstrates how to simulate Java-style class members using JavaScript. It does this「manually」—without relying on the defineClass() function above.

Example 9-3. Complex.js: A complex number class

/* * Complex.js: * This file defines a Complex class to represent complex numbers. * Recall that a complex number is the sum of a real number and an * imaginary number and that the imaginary number i is the square root of -1. */ /* * This constructor function defines the instance fields r and i on every * instance it creates. These fields hold the real and imaginary parts of * the complex number: they are the state of the object. */ function Complex(real, imaginary) { if (isNaN(real) || isNaN(imaginary)) // Ensure that both args are numbers. throw new TypeError(); // Throw an error if they are not. this.r = real; // The real part of the complex number. this.i = imaginary; // The imaginary part of the number. } /* * The instance methods of a class are defined as function-valued properties * of the prototype object. The methods defined here are inherited by all * instances and provide the shared behavior of the class. Note that JavaScript * instance methods must use the this keyword to access the instance fields. */ // Add a complex number to this one and return the sum in a new object. Complex.prototype.add = function(that) { return new Complex(this.r + that.r, this.i + that.i); }; // Multiply this complex number by another and return the product. Complex.prototype.mul = function(that) { return new Complex(this.r * that.r - this.i * that.i, this.r * that.i + this.i * that.r); }; // Return the real magnitude of a complex number. This is defined // as its distance from the origin (0,0) of the complex plane. Complex.prototype.mag = function() { return Math.sqrt(this.r*this.r + this.i*this.i); }; // Return a complex number that is the negative of this one. Complex.prototype.neg = function() { return new Complex(-this.r, -this.i); }; // Convert a Complex object to a string in a useful way. Complex.prototype.toString = function() { return "{" + this.r + "," + this.i + "}"; }; // Test whether this Complex object has the same value as another. Complex.prototype.equals = function(that) { return that != null && // must be defined and non-null that.constructor === Complex && // and an instance of Complex this.r === that.r && this.i === that.i; // and have the same values. }; /* * Class fields (such as constants) and class methods are defined as * properties of the constructor. Note that class methods do not * generally use the this keyword: they operate only on their arguments. */ // Here are some class fields that hold useful predefined complex numbers. // Their names are uppercase to indicate that they are constants. // (In ECMAScript 5, we could actually make these properties read-only.) Complex.ZERO = new Complex(0,0); Complex.ONE = new Complex(1,0); Complex.I = new Complex(0,1); // This class method parses a string in the format returned by the toString // instance method and returns a Complex object or throws a TypeError. Complex.parse = function(s) { try { // Assume that the parsing will succeed var m = Complex._format.exec(s); // Regular expression magic return new Complex(parseFloat(m[1]), parseFloat(m[2])); } catch (x) { // And throw an exception if it fails throw new TypeError("Can't parse '" + s + "' as a complex number."); } }; // A "private" class field used in Complex.parse() above. // The underscore in its name indicates that it is intended for internal // use and should not be considered part of the public API of this class. Complex._format = /^\{([^,]+),([^}]+)\}$/;

With the Complex class of Example 9-3 defined, we can use the constructor, instance fields, instance methods, class fields, and class methods with code like this:

var c = new Complex(2,3); // Create a new object with the constructor var d = new Complex(c.i,c.r); // Use instance properties of c c.add(d).toString(); // => "{5,5}": use instance methods // A more complex expression that uses a class method and field Complex.parse(c.toString()). // Convert c to a string and back again, add(c.neg()). // add its negative to it, equals(Complex.ZERO) // and it will always equal zero

Although JavaScript classes can emulate Java-style class members, there are a number of significant Java features that JavaScript classes do not support. First, in the instance methods of Java classes, instance fields can be used as if they were local variables—there is no need to prefix them with this. JavaScript does not do this, but you could achieve a similar effect using a with statement (this is not recommended, however):

Complex.prototype.toString = function() { with(this) { return "{" + r + "," + i + "}"; } };

Java allows fields to be declared final to indicate that they are constants, and it allows fields and methods to be declared private to specify that they are private to the class implementation and should not be visible to users of the class. JavaScript does not have these keywords, and Example 9-3 uses typographical conventions to provide hints that some properties (whose names are in capital letters) should not be changed and that others (whose names begin with an underscore) should not be used outside of the class. We’ll return to both of these topics later in the chapter: private properties can be emulated using the local variables of a closure (see Private State) and constant properties are possible in ECMAScript 5 (see Defining Immutable Classes).

Augmenting Classes

JavaScript’s prototype-based inheritance mechanism is dynamic: an object inherits properties from its prototype, even if the prototype changes after the object is created. This means that we can augment JavaScript classes simply by adding new methods to their prototype objects. Here is code that adds a method for computing the complex conjugate to the Complex class of Example 9-3:

// Return a complex number that is the complex conjugate of this one. Complex.prototype.conj = function() { return new Complex(this.r, -this.i); };

The prototype object of built-in JavaScript classes is also「open」like this, which means that we can add methods to numbers, strings, arrays, functions, and so on. We did this in Example 8-5 when we added a bind() method to the function class in ECMAScript 3 implementations where it did not already exist:

if (!Function.prototype.bind) { Function.prototype.bind = function(o /*, args */) { // Code for the bind method goes here... }; }

Here are some other examples:

// Invoke the function f this many times, passing the iteration number // For example, to print "hello" 3 times: // var n = 3; // n.times(function(n) { console.log(n + " hello"); }); Number.prototype.times = function(f, context) { var n = Number(this); for(var i = 0; i < n; i++) f.call(context, i); }; // Define the ES5 String.trim() method if one does not already exist. // This method returns a string with whitespace removed from the start and end. String.prototype.trim = String.prototype.trim || function() { if (!this) return this; // Don't alter the empty string return this.replace(/^\s+|\s+$/g, ""); // Regular expression magic }; // Return a function's name. If it has a (nonstandard) name property, use it. // Otherwise, convert the function to a string and extract the name from that. // Returns an empty string for unnamed functions like itself. Function.prototype.getName = function() { return this.name || this.toString().match(/function\s*([^(]*)\(/)[1]; };

It is possible to add methods to Object.prototype, making them available on all objects. This is not recommended, however, because prior to ECMAScript 5, there is no way to make these add-on methods nonenumerable, and if you add properties to Object.prototype, those properties will be reported by all for/in loops. In Making Properties Nonenumerable we’ll see an example of using the ECMAScript 5 method Object.defineProperty() to safely augment Object.prototype.

It is implementation-dependent whether classes defined by the host environment (such as the web browser) can be augmented in this way. In many web browsers, for example, you can add methods to HTMLElement.prototype and those methods will be inherited by the objects that represent the HTML tags in the current document. This does not work in current versions of Microsoft’s Internet Explorer, however, which severely limits the utility of this technique for client-side programming.

Classes and Types

Recall from Chapter 3 that JavaScript defines a small set of types: null, undefined, boolean, number, string, function, and object. The typeof operator (The typeof Operator) allows us to distinguish among these types. Often, however, it is useful to treat each class as its own type and to be able to distinguish objects based on their class. The built-in objects of core JavaScript (and often the host objects of client-side JavaScript) can be distinguished on the basis of their class attribute (The class Attribute) using code like the classof() function of Example 6-4. But when we define our own classes using the techniques shown in this chapter, the instance objects always have a class attribute of「Object」, so the classof() function doesn’t help here.

The subsections that follow explain three techniques for determining the class of an arbitrary object: the instanceof operator, the constructor property, and the name of the constructor function. None of these techniques is entirely satisfactory, however, and the section concludes with a discussion of duck-typing, a programming philosophy that focuses on what an object can do (what methods it has) rather than what its class is.

The instanceof operator

The instanceof operator was described in The instanceof Operator. The left-hand operand should be the object whose class is being tested, and the right-hand operand should be a constructor function that names a class. The expression o instanceof c evaluates to true if o inherits from c.prototype. The inheritance need not be direct. If o inherits from an object that inherits from an object that inherits from c.prototype, the expression will still evaluate to true.

As noted earlier in this chapter, constructors act as the public identity of classes, but prototypes are the fundamental identity. Despite the use of a constructor function with instanceof, this operator is really testing what an object inherits from, not what constructor was used to create it.

If you want to test the prototype chain of an object for a specific prototype object and do not want to use the constructor function as an intermediary, you can use the isPrototypeOf() method. For example, we could test whether an object r was a member of the range class defined in Example 9-1 with this code:

range.methods.isPrototypeOf(r); // range.methods is the prototype object.

One shortcoming of the instanceof operator and the isPrototypeOf() method is that they do not allow us to query the class of an object, only to test an object against a class we specify. A more serious shortcoming arises in client-side JavaScript where a web application uses more than one window or frame. Each window or frame is a distinct execution context, and each has its own global object and its own set of constructor functions. Two arrays created in two different frames inherit from two identical but distinct prototype objects, and an array created in one frame is not instanceof the Array() constructor of another frame.

The constructor property

Another way to identify the class of an object is to simply use the constructor property. Since constructors are the public face of classes, this is a straightforward approach. For example:

function typeAndValue(x) { if (x == null) return ""; // Null and undefined don't have constructors switch(x.constructor) { case Number: return "Number: " + x; // Works for primitive types case String: return "String: '" + x + "'"; case Date: return "Date: " + x; // And for built-in types case RegExp: return "Regexp: " + x; case Complex: return "Complex: " + x; // And for user-defined types } }

Note that the expressions following the case keyword in the code above are functions. If we were using the typeof operator or extracting the class attribute of the object, they would be strings instead.

This technique of using the constructor property is subject to the same problem as instanceof. It won’t always work when there are multiple execution contexts (such as multiple frames in a browser window) that share values. In this situation, each frame has its own set of constructor functions: the Array constructor in one frame is not the same as the Array constructor in another frame.

Also, JavaScript does not require that every object have a constructor property: this is a convention based on the default prototype object created for each function, but it is easy to accidentally or intentionally omit the constructor property on the prototype. The first two classes in this chapter, for example, were defined in such a way (in Examples 9-1 and 9-2) that their instances did not have constructor properties.

The Constructor Name

The main problem with using the instanceof operator or the constructor property for determining the class of an object occurs when there are multiple execution contexts and thus multiple copies of the constructor functions. These functions may well be identical, but they are distinct objects and are therefore not equal to each other.

One possible workaround is to use the name of the constructor function as the class identifier rather than the function itself. The Array constructor in one window is not equal to the Array constructor in another window, but their names are equal. Some JavaScript implementations make the name of a function available through a nonstandard name property of the function object. For implementations without a name property, we can convert the function to a string and extract the name from that. (We did this in Augmenting Classes when we showed how to add a getName() method to the Function class.)

Example 9-4 defines a type() function that returns the type of an object as a string. It handles primitive values and functions with the typeof operator. For objects, it returns either the value of the class attribute or the name of the constructor. The type() function uses the classof() function from Example 6-4 and the Function.getName() method from Augmenting Classes. The code for that function and method are included here for simplicity.

Example 9-4. A type() function to determine the type of a value

/** * Return the type of o as a string: * -If o is null, return "null", if o is NaN, return "nan". * -If typeof returns a value other than "object" return that value. * (Note that some implementations identify regexps as functions.) * -If the class of o is anything other than "Object", return that. * -If o has a constructor and that constructor has a name, return it. * -Otherwise, just return "Object". **/ function type(o) { var t, c, n; // type, class, name // Special case for the null value: if (o === null) return "null"; // Another special case: NaN is the only value not equal to itself: if (o !== o) return "nan"; // Use typeof for any value other than "object". // This identifies any primitive value and also functions. if ((t = typeof o) !== "object") return t; // Return the class of the object unless it is "Object". // This will identify most native objects. if ((c = classof(o)) !== "Object") return c; // Return the object's constructor name, if it has one if (o.constructor && typeof o.constructor === "function" && (n = o.constructor.getName())) return n; // We can't determine a more specific type, so return "Object" return "Object"; } // Return the class of an object. function classof(o) { return Object.prototype.toString.call(o).slice(8,-1); }; // Return the name of a function (may be "") or null for nonfunctions Function.prototype.getName = function() { if ("name" in this) return this.name; return this.name = this.toString().match(/function\s*([^(]*)\(/)[1]; };

This technique of using the constructor name to identify the class of an object has one of the same problems as using the constructor property itself: not all objects have a constructor property. Furthermore, not all functions have a name. If we define a constructor using an unnamed function definition expression, the getName() method will return an empty string:

// This constructor has no name var Complex = function(x,y) { this.r = x; this.i = y; } // This constructor does have a name var Range = function Range(f,t) { this.from = f; this.to = t; }

Duck-Typing

None of the techniques described above for determining the class of an object are problem-free, at least in client-side JavaScript. An alternative is to sidestep the issue: instead of asking「what is the class of this object?」we ask instead,「what can this object do?」This approach to programming is common in languages like Python and Ruby and is called duck-typing after this expression (often attributed to poet James Whitcomb Riley):

When I see a bird that walks like a duck and swims like a duck and quacks like a duck, I call that bird a duck.

For JavaScript programmers, this aphorism can be understood to mean「if an object can walk and swim and quack like a Duck, then we can treat it as a Duck, even if it does not inherit from the prototype object of the Duck class.」

The Range class of Example 9-2 serves as an example. This class was designed with numeric ranges in mind. Notice, however, that the Range() constructor does not check its arguments to ensure that they are numbers. It does use the > operator on them, however, so it assumes that they are comparable. Similarly, the includes() method uses the <= operator but makes no other assumptions about the endpoints of the range. Because the class does not enforce a particular type, its includes() method works for any kind of endpoint that can be compared with the relational operators:

var lowercase = new Range("a", "z"); var thisYear = new Range(new Date(2009, 0, 1), new Date(2010, 0, 1));

The foreach() method of our Range class doesn’t explicitly test the type of the range endpoints either, but its use of Math.ceil() and the ++ operator means that it only works with numeric endpoints.

As another example, recall the discussion of array-like objects from Array-Like Objects. In many circumstances, we don’t need to know whether an object is a true instance of the Array class: it is enough to know that it has a nonnegative integer length property. The existence of an integer-valued length is how arrays walk, we might say, and any object that can walk in this way can (in many circumstances) be treated as an array.

Keep in mind, however, that the length property of true arrays has special behavior: when new elements are added, the length is automatically updated, and when the length is set to a smaller value, the array is automatically truncated. We might say that this is how arrays swim and quack. If you are writing code that requires swimming and quacking, you can’t use an object that only walks like an array.

The examples of duck-typing presented above involve the response of objects to the < operator and the special behavior of the length property. More typically, however, when we talk about duck-typing, we’re talking about testing whether an object implements one or more methods. A strongly-typed triathlon() function might require its argument to be an TriAthlete object. A duck-typed alternative could be designed to accept any object that has walk(), swim(), and bike() methods. Less frivolously, we might redesign our Range class so that instead of using the < and ++ operators, it uses the compareTo() and succ() (successor) methods of its endpoint objects.

One approach to duck-typing is laissez-faire: we simply assume that our input objects implement the necessary methods and perform no checking at all. If the assumption is invalid, an error will occur when our code attempts to invoke a nonexistent method. Another approach does check the input objects. Rather than check their class, however, it checks that they implement methods with the appropriate names. This allows us to reject bad input earlier and can result in more informative error messages.

Example 9-5 defines a quacks() function (「implements」would be a better name, but implements is a reserved word) that can be useful when duck-typing. quacks() tests whether an object (the first argument) implements the methods specified by the remaining arguments. For each remaining argument, if the argument is a string, it checks for a method by that name. If the argument is an object, it checks whether the first object implements methods with the same names as the methods of that object. If the argument is a function, it is assumed to be a constructor, and the function checks whether the first object implements methods with the same names as the prototype object.

Example 9-5. A function for duck-type checking

// Return true if o implements the methods specified by the remaining args. function quacks(o /*, ... */) { for(var i = 1; i < arguments.length; i++) { // for each argument after o var arg = arguments[i]; switch(typeof arg) { // If arg is a: case 'string': // string: check for a method with that name if (typeof o[arg] !== "function") return false; continue; case 'function': // function: use the prototype object instead // If the argument is a function, we use its prototype object arg = arg.prototype; // fall through to the next case case 'object': // object: check for matching methods for(var m in arg) { // For each property of the object if (typeof arg[m] !== "function") continue; // skip non-methods if (typeof o[m] !== "function") return false; } } } // If we're still here, then o implements everything return true; }

There are a couple of important things to keep in mind about this quacks() function. First, it only tests that an object has one or more function-valued properties with specified names. The existence of these properties doesn’t tell us anything about what those functions do or how many and what kind of arguments they expect. This, however, is the nature of duck-typing. If you define an API that uses duck-typing rather than a stronger version of type checking, you are creating a more flexible API but also entrusting the user of your API with the responsibility to use the API correctly. The second important point to note about the quacks() function is that it doesn’t work with built-in classes. For example, you can’t write quacks(o, Array) to test that o has methods with the same names as all Array methods. This is because the methods of the built-in classes are nonenumerable and the for/in loop in quacks() does not see them. (Note that this can be remedied in ECMAScript 5 with the use of Object.getOwnPropertyNames().)

Object-Oriented Techniques in JavaScript

So far in this chapter we’ve covered the architectural fundamentals of classes in JavaScript: the importance of the prototype object, its connections to the constructor function, how the instanceof operator works, and so on. In this section we switch gears and demonstrate a number of practical (though not fundamental) techniques for programming with JavaScript classes. We begin with two nontrivial example classes that are interesting in their own right but also serve as starting points for the discussions that follow.

Example: A Set Class

A set is a data structure that represents an unordered collection of values, with no duplicates. The fundamental operations on sets are adding values and testing whether a value is a member of the set, and sets are generally implemented so that these operations are fast. JavaScript’s objects are basically sets of property names, with values associated with each name. It is trivial, therefore, to use an object as a set of strings. Example 9-6 implements a more general Set class in JavaScript. It works by mapping any JavaScript value to a unique string, and then using that string as a property name. Objects and functions do not have a concise and reliably unique string representation, so the Set class must define an identifying property on any object or function stored in the set.

Example 9-6. Set.js: An arbitrary set of values

function Set() { // This is the constructor this.values = {}; // The properties of this object hold the set this.n = 0; // How many values are in the set this.add.apply(this, arguments); // All arguments are values to add } // Add each of the arguments to the set. Set.prototype.add = function() { for(var i = 0; i < arguments.length; i++) { // For each argument var val = arguments[i]; // The value to add to the set var str = Set._v2s(val); // Transform it to a string if (!this.values.hasOwnProperty(str)) { // If not already in the set this.values[str] = val; // Map string to value this.n++; // Increase set size } } return this; // Support chained method calls }; // Remove each of the arguments from the set. Set.prototype.remove = function() { for(var i = 0; i < arguments.length; i++) { // For each argument var str = Set._v2s(arguments[i]); // Map to a string if (this.values.hasOwnProperty(str)) { // If it is in the set delete this.values[str]; // Delete it this.n--; // Decrease set size } } return this; // For method chaining }; // Return true if the set contains value; false otherwise. Set.prototype.contains = function(value) { return this.values.hasOwnProperty(Set._v2s(value)); }; // Return the size of the set. Set.prototype.size = function() { return this.n; }; // Call function f on the specified context for each element of the set. Set.prototype.foreach = function(f, context) { for(var s in this.values) // For each string in the set if (this.values.hasOwnProperty(s)) // Ignore inherited properties f.call(context, this.values[s]); // Call f on the value }; // This internal function maps any JavaScript value to a unique string. Set._v2s = function(val) { switch(val) { case undefined: return 'u'; // Special primitive case null: return 'n'; // values get single-letter case true: return 't'; // codes. case false: return 'f'; default: switch(typeof val) { case 'number': return '#' + val; // Numbers get # prefix. case 'string': return '"' + val; // Strings get " prefix. default: return '@' + objectId(val); // Objs and funcs get @ } } // For any object, return a string. This function will return a different // string for different objects, and will always return the same string // if called multiple times for the same object. To do this it creates a // property on o. In ES5 the property would be nonenumerable and read-only. function objectId(o) { var prop = "|**objectid**|"; // Private property name for storing ids if (!o.hasOwnProperty(prop)) // If the object has no id o[prop] = Set._v2s.next++; // Assign it the next available return o[prop]; // Return the id } }; Set._v2s.next = 100; // Start assigning object ids at this value.

Example: Enumerated Types

An enumerated type is a type with a finite set of values that are listed (or「enumerated」) when the type is defined. In C and languages derived from it, enumerated types are declared with the enum keyword. enum is a reserved (but unused) word in ECMAScript 5 which leaves open the possibility that JavaScript may someday have native enumerated types. Until then, Example 9-7 shows how you can define your own enumerated types in JavaScript. Note that it uses the inherit() function from Example 6-1 .

Example 9-7 consists of a single function enumeration(). This is not a constructor function, however: it does not define a class named「enumeration」. Instead, this is a factory function: each invocation creates and returns a new class. Use it like this:

// Create a new Coin class with four values: Coin.Penny, Coin.Nickel, etc. var Coin = enumeration({Penny: 1, Nickel:5, Dime:10, Quarter:25}); var c = Coin.Dime; // This is an instance of the new class c instanceof Coin // => true: instanceof works c.constructor == Coin // => true: constructor property works Coin.Quarter + 3*Coin.Nickel // => 40: values convert to numbers Coin.Dime == 10 // => true: more conversion to numbers Coin.Dime > Coin.Nickel // => true: relational operators work String(Coin.Dime) + ":" + Coin.Dime // => "Dime:10": coerce to string

The point of this example is to demonstrate that JavaScript classes are much more flexible and dynamic than the static classes of languages like C++ and Java.

Example 9-7. Enumerated types in JavaScript

// This function creates a new enumerated type. The argument object specifies // the names and values of each instance of the class. The return value // is a constructor function that identifies the new class. Note, however // that the constructor throws an exception: you can't use it to create new // instances of the type. The returned constructor has properties that // map the name of a value to the value itself, and also a values array, // a foreach() iterator function function enumeration(namesToValues) { // This is the dummy constructor function that will be the return value. var enumeration = function() { throw "Can't Instantiate Enumerations"; }; // Enumerated values inherit from this object. var proto = enumeration.prototype = { constructor: enumeration, // Identify type toString: function() { return this.name; }, // Return name valueOf: function() { return this.value; }, // Return value toJSON: function() { return this.name; } // For serialization }; enumeration.values = []; // An array of the enumerated value objects // Now create the instances of this new type. for(name in namesToValues) { // For each value var e = inherit(proto); // Create an object to represent it e.name = name; // Give it a name e.value = namesToValues[name]; // And a value enumeration[name] = e; // Make it a property of constructor enumeration.values.push(e); // And store in the values array } // A class method for iterating the instances of the class enumeration.foreach = function(f,c) { for(var i = 0; i < this.values.length; i++) f.call(c,this.values[i]); }; // Return the constructor that identifies the new type return enumeration; }

The「hello world」of enumerated types is to use an enumerated type to represent the suits in a deck of cards. Example 9-8 uses the enumeration() function in this way and also defines classes to represents cards and decks of cards.[15]

Example 9-8. Representing cards with enumerated types

// Define a class to represent a playing card function Card(suit, rank) { this.suit = suit; // Each card has a suit this.rank = rank; // and a rank } // These enumerated types define the suit and rank values Card.Suit = enumeration({Clubs: 1, Diamonds: 2, Hearts:3, Spades:4}); Card.Rank = enumeration({Two: 2, Three: 3, Four: 4, Five: 5, Six: 6, Seven: 7, Eight: 8, Nine: 9, Ten: 10, Jack: 11, Queen: 12, King: 13, Ace: 14}); // Define a textual representation for a card Card.prototype.toString = function() { return this.rank.toString() + " of " + this.suit.toString(); }; // Compare the value of two cards as you would in poker Card.prototype.compareTo = function(that) { if (this.rank < that.rank) return -1; if (this.rank > that.rank) return 1; return 0; }; // A function for ordering cards as you would in poker Card.orderByRank = function(a,b) { return a.compareTo(b); }; // A function for ordering cards as you would in bridge Card.orderBySuit = function(a,b) { if (a.suit < b.suit) return -1; if (a.suit > b.suit) return 1; if (a.rank < b.rank) return -1; if (a.rank > b.rank) return 1; return 0; }; // Define a class to represent a standard deck of cards function Deck() { var cards = this.cards = []; // A deck is just an array of cards Card.Suit.foreach(function(s) { // Initialize the array Card.Rank.foreach(function(r) { cards.push(new Card(s,r)); }); }); } // Shuffle method: shuffles cards in place and returns the deck Deck.prototype.shuffle = function() { // For each element in the array, swap with a randomly chosen lower element var deck = this.cards, len = deck.length; for(var i = len-1; i > 0; i--) { var r = Math.floor(Math.random()*(i+1)), temp; // Random number temp = deck[i], deck[i] = deck[r], deck[r] = temp; // Swap } return this; }; // Deal method: returns an array of cards Deck.prototype.deal = function(n) { if (this.cards.length < n) throw "Out of cards"; return this.cards.splice(this.cards.length-n, n); }; // Create a new deck of cards, shuffle it, and deal a bridge hand var deck = (new Deck()).shuffle(); var hand = deck.deal(13).sort(Card.orderBySuit);

Standard Conversion Methods

Object to Primitive Conversions and Object Methods described important methods used for type conversion of objects, some of which are invoked automatically by the JavaScript interpreter when conversion is necessary. You do not need to implement these methods for every class you write, but they are important methods, and if you do not implement them for your classes, it should be a conscious choice not to implement them rather than mere oversight.

The first, and most important, method is toString(). The purpose of this method is to return a string representation of an object. JavaScript automatically invokes this method if you use an object where a string is expected—as a property name, for example, or with the + operator to perform string concatenation. If you don’t implement this method, your class will inherit the default implementation from Object.prototype and will convert to the useless string「[object Object]」. A toString() method might return a human-readable string suitable for display to end users of your program. Even if this is not necessary, however, it is often useful to define toString() for ease of debugging. The Range and Complex classes in Examples 9-2 and 9-3 have toString() methods, as do the enumerated types of Example 9-7. We’ll define a toString() method for the Set class of Example 9-6 below.

The toLocaleString() is closely related to toString(): it should convert an object to a string in a locale-sensitive way. By default, objects inherit a toLocaleString() method that simply calls their toString() method. Some built-in types have useful toLocaleString() methods that actually return locale-dependent strings. If you find yourself writing a toString() method that converts other objects to strings, you should also define a toLocaleString() method that performs those conversions by invoking the toLocaleString() method on the objects. We’ll do this for the Set class below.

The third method is valueOf(). Its job is to convert an object to a primitive value. The valueOf() method is invoked automatically when an object is used in a numeric context, with arithmetic operators (other than +) and with the relational operators, for example. Most objects do not have a reasonable primitive representation and do not define this method. The enumerated types in Example 9-7 demonstrate a case in which the valueOf() method is important, however.

The fourth method is toJSON(), which is invoked automatically by JSON.stringify(). The JSON format is intended for serialization of data structures and can handle JavaScript primitive values, arrays, and plain objects. It does not know about classes, and when serializing an object, it ignores the object’s prototype and constructor. If you call JSON.stringify() on a Range or Complex object, for example, it returns a string like {"from":1, "to":3} or {"r":1, "i":-1}. If you pass these strings to JSON.parse(), you’ll obtain a plain object with properties appropriate for Range and Complex objects, but which do not inherit the Range and Complex methods.

This kind of serialization is appropriate for classes like Range and Complex, but for other classes you may want to write a toJSON() method to define some other serialization format. If an object has a toJSON() method, JSON.stringify() does not serialize the object but instead calls toJSON() and serializes the value (either primitive or object) that it returns. Date objects, for example, have a toJSON() method that returns a string representation of the date. The enumerated types of Example 9-7 do the same: their toJSON() method is the same as their toString() method. The closest JSON analog to a set is an array, so we’ll define a toJSON() method below that converts a Set object to an array of values.

The Set class of Example 9-6 does not define any of these methods. A set has no primitive representation, so it doesn’t make sense to define a valueOf() method, but the class should probably have toString(), toLocaleString(), and toJSON() methods. We can do that with code like the following. Note the use of the extend() function (Example 6-2) to add methods to Set.prototype:

// Add these methods to the Set prototype object. extend(Set.prototype, { // Convert a set to a string toString: function() { var s = "{", i = 0; this.foreach(function(v) { s += ((i++ > 0)?", ":"") + v; }); return s + "}"; }, // Like toString, but call toLocaleString on all values toLocaleString : function() { var s = "{", i = 0; this.foreach(function(v) { if (i++ > 0) s += ", "; if (v == null) s += v; // null & undefined else s += v.toLocaleString(); // all others }); return s + "}"; }, // Convert a set to an array of values toArray: function() { var a = []; this.foreach(function(v) { a.push(v); }); return a; } }); // Treat sets like arrays for the purposes of JSON stringification. Set.prototype.toJSON = Set.prototype.toArray;

Comparison Methods

JavaScript equality operators compare objects by reference, not by value. That is, given two object references, they look to see if both references are to the same object. They do not check to see if two different objects have the same property names and values. It is often useful to be able to compare two distinct objects for equality or even for relative order (as the < and > operators do). If you define a class and want to be able to compare instances of that class, you should define appropriate methods to perform those comparisons.

The Java programming language uses methods for object comparison, and adopting the Java conventions is a common and useful thing to do in JavaScript. To enable instances of your class to be tested for equality, define an instance method named equals(). It should take a single argument and return true if that argument is equal to the object it is invoked on. Of course it is up to you to decide what「equal」means in the context of your own class. For simple classes you can often simply compare the constructor properties to ensure that the two objects are of the same type and then compare the instance properties of the two objects to ensure that they have the same values. The Complex class in Example 9-3 has an equals() method of this sort, and we can easily write a similar one for the Range class:

// The Range class overwrote its constructor property. So add it now. Range.prototype.constructor = Range; // A Range is not equal to any nonrange. // Two ranges are equal if and only if their endpoints are equal. Range.prototype.equals = function(that) { if (that == null) return false; // Reject null and undefined if (that.constructor !== Range) return false; // Reject non-ranges // Now return true if and only if the two endpoints are equal. return this.from == that.from && this.to == that.to; }

Defining an equals() method for our Set class is somewhat trickier. We can’t just compare the values property of two sets but must perform a deeper comparison:

Set.prototype.equals = function(that) { // Shortcut for trivial case if (this === that) return true; // If the that object is not a set, it is not equal to this one. // We use instanceof to allow any subclass of Set. // We could relax this test if we wanted true duck-typing. // Or we could strengthen it to check this.constructor == that.constructor // Note that instanceof properly rejects null and undefined values if (!(that instanceof Set)) return false; // If two sets don't have the same size, they're not equal if (this.size() != that.size()) return false; // Now check whether every element in this is also in that. // Use an exception to break out of the foreach if the sets are not equal. try { this.foreach(function(v) { if (!that.contains(v)) throw false; }); return true; // All elements matched: sets are equal. } catch (x) { if (x === false) return false; // An element in this is not in that. throw x; // Some other exception: rethrow it. } };

It is sometimes useful to compare objects according to some ordering. That is, for some classes, it is possible to say that one instance is「less than」or「greater than」another instance. You might order Range object based on the value of their lower bound, for example. Enumerated types could be ordered alphabetically by name, or numerically by the associated value (assuming the associated value is a number). Set objects, on the other hand, do not really have a natural ordering.

If you try to use objects with JavaScript’s relation operators, such as < and <=, JavaScript first calls the valueOf() method of the objects and, if this method returns a primitive value, compares those values. The enumerated types returned by the enumeration() method of Example 9-7 have a valueOf() method and can be meaningfully compared using the relational operators. Most classes do not have a valueOf() method, however. To compare objects of these types according to an explicitly defined ordering of your own choosing, you can (again, following Java convention) define a method named compareTo().

The compareTo() method should accept a single argument and compare it to the object on which the method is invoked. If the this object is less than the argument, compareTo() should return a value less than zero. If the this object is greater than the argument object, the method should return a value greater than zero. And if the two objects are equal, the method should return zero. These conventions about the return value are important, and they allow you to substitute the following expressions for relational and equality operators:

Replace thisWith this

a < b a.compareTo(b) < 0

a <= b a.compareTo(b) <= 0

a > b a.compareTo(b) > 0

a >= b a.compareTo(b) >= 0

a == b a.compareTo(b) == 0

a != b a.compareTo(b) != 0

The Card class of Example 9-8 defines a compareTo() method of this kind, and we can write a similar method for the Range class to order ranges by their lower bound:

Range.prototype.compareTo = function(that) { return this.from - that.from; };

Notice that the subtraction performed by this method correctly returns a value less than zero, equal to zero, or greater than zero, according to the relative order of the two Ranges. Because the Card.Rank enumeration in Example 9-8 has a valueOf() method, we could have used this same idiomatic trick in the compareTo() method of the Card class.

The equals() methods above perform type checking on their argument and return false to indicate inequality if the argument is of the wrong type. The compareTo() method does not have any return value that indicates「those two values are not comparable,」so a compareTo() method that does type checking should typically throw an error when passed an argument of the wrong type.

Notice that the compareTo() method we defined for the Range class above returns 0 when two ranges have the same lower bound. This means that as far as compareTo() is concerned, any two ranges that start at the same spot are equal. This definition of equality is inconsistent with the definition used by the equals() method, which requires both endpoints to match. Inconsistent notions of equality can be a pernicious source of bugs, and it is best to make your equals() and compareTo() methods consistent. Here is a revised compareTo() method for the Range class. It is consistent with equals() and also throws an error if called with an incomparable value:

// Order ranges by lower bound, or upper bound if the lower bounds are equal. // Throws an error if passed a non-Range value. // Returns 0 if and only if this.equals(that). Range.prototype.compareTo = function(that) { if (!(that instanceof Range)) throw new Error("Can't compare a Range with " + that); var diff = this.from - that.from; // Compare lower bounds if (diff == 0) diff = this.to - that.to; // If equal, compare upper bounds return diff; };

One reason to define a compareTo() method for a class is so that arrays of instances of that class can be sorted. The Array.sort() method accepts as an optional argument a comparison function that uses the same return-value conventions as the compareTo() method. Given the compareTo() method shown above, it is easy to sort an array of Range objects with code like this:

ranges.sort(function(a,b) { return a.compareTo(b); });

Sorting is important enough that you should consider defining this kind of two-argument comparison function as a class method for any class for which you define a compareTo() instance method. One can easily be defined in terms of the other. For example:

Range.byLowerBound = function(a,b) { return a.compareTo(b); };

With a method like this defined, sorting becomes simpler:

ranges.sort(Range.byLowerBound);

Some classes can be ordered in more than one way. The Card class, for example, defines one class method that orders cards by suit and another that orders them by rank.

Borrowing Methods

There is nothing special about methods in JavaScript: they are simply functions assigned to object properties and invoked「through」or「on」an object. A single function can be assigned to two properties, and it then serves as two methods. We did this for our Set class, for example, when we copied the toArray() method and made it do dual-duty as a toJSON() method as well.

A single function can even be used as a method of more than one class. Most of the built-in methods of the Array class, for example, are defined generically, and if you define a class whose instances are array-like objects, you can copy functions from Array.prototype to the prototype object of your class. If you view JavaScript through the lens of classical object-oriented languages, the use of methods of one class as methods of another class can be thought of as a form of multiple inheritance. JavaScript is not a classical object-oriented language, however, and I prefer to describe this kind of method reuse using the informal term borrowing.

It is not only Array methods that can be borrowed: we can write our own generic methods. Example 9-9 defines generic toString() and equals() methods that are suitable for use by simple classes like our Range, Complex, and Card classes. If the Range class did not have an equals() method, we could borrow the generic equals() like this:

Range.prototype.equals = generic.equals;

Note that the generic.equals() method does only a shallow comparison, and it is not suitable for use with classes whose instance properties refer to objects with their own equals() methods. Also notice that this method includes special case code to handle the property added to objects when they are inserted into a Set (Example 9-6).

Example 9-9. Generic methods for borrowing

var generic = { // Returns a string that includes the name of the constructor function // if available and the names and values of all noninherited, nonfunction // properties. toString: function() { var s = '['; // If the object has a constructor and the constructor has a name, // use that class name as part of the returned string. Note that // the name property of functions is nonstandard and not supported // everywhere. if (this.constructor && this.constructor.name) s += this.constructor.name + ": "; // Now enumerate all noninherited, nonfunction properties var n = 0; for(var name in this) { if (!this.hasOwnProperty(name)) continue; // skip inherited props var value = this[name]; if (typeof value === "function") continue; // skip methods if (n++) s += ", "; s += name + '=' + value; } return s + ']'; }, // Tests for equality by comparing the constructors and instance properties // of this and that. Only works for classes whose instance properties are // primitive values that can be compared with ===. // As a special case, ignore the special property added by the Set class. equals: function(that) { if (that == null) return false; if (this.constructor !== that.constructor) return false; for(var name in this) { if (name === "|**objectid**|") continue; // skip special prop. if (!this.hasOwnProperty(name)) continue; // skip inherited if (this[name] !== that[name]) return false; // compare values } return true; // If all properties matched, objects are equal. } };

Private State

In classical object-oriented programming, it is often a goal to encapsulate or hide the state of an object within the object, allowing access to that state only through the methods of the object, and now allowing the important state variables to be read or written directly. To achieve this goal, languages like Java allow the declaration of「private」instance fields of a class that are only accessible to the instance method of the class and cannot be seen outside of the class.

We can approximate private instance fields using variables (or arguments) captured in the closure of the constructor invocation that creates an instance. To do this, we define functions inside the constructor (so they have access to the constructor’s arguments and variables) and assign those functions to properties of the newly created object. Example 9-10 shows how we can do this to create an encapsulated version of our Range class. Instead of having from and to properties that give the endpoints of the range, instances of this new version of the class have from and to methods that return the endpoints of the range. These from() and to() methods are defined on the individual Range object and are not inherited from the prototype. The other Range methods are defined on the prototype as usual, but modified to call the from() and to() methods rather than read the endpoints directly from properties.

Example 9-10. A Range class with weakly encapsulated endpoints

function Range(from, to) { // Don't store the endpoints as properties of this object. Instead // define accessor functions that return the endpoint values. // These values are stored in the closure. this.from = function() { return from; }; this.to = function() { return to; }; } // The methods on the prototype can't see the endpoints directly: they have // to invoke the accessor methods just like everyone else. Range.prototype = { constructor: Range, includes: function(x) { return this.from() <= x && x <= this.to(); }, foreach: function(f) { for(var x=Math.ceil(this.from()), max=this.to(); x <= max; x++) f(x); }, toString: function() { return "(" + this.from() + "..." + this.to() + ")"; } };

This new Range class defines methods for querying the endpoints of a range, but no methods or properties for setting those endpoints. This gives instances of this class a kind of immutability: if used correctly, the endpoints of a Range object will not change after it has been created. Unless we use ECMAScript 5 features (see Encapsulating Object State), however, the from and to properties are still writable, and Range objects aren’t really immutable at all:

var r = new Range(1,5); // An "immutable" range r.from = function() { return 0; }; // Mutate by replacing the method

Keep in mind that there is an overhead to this encapsulation technique. A class that uses a closure to encapsulate its state will almost certainly be slower and larger than the equivalent class with unencapsulated state variables.

Constructor Overloading and Factory Methods

Sometimes we want to allow objects to be initialized in more than one way. We might want to create a Complex object initialized with a radius and an angle (polar coordinates) instead of real and imaginary components, for example, or we might want to create a Set whose members are the elements of an array rather than the arguments passed to the constructor.

One way to do this is to overload the constructor and have it perform different kinds of initialization depending on the arguments it is passed. Here is an overloaded version of the Set constructor, for example:

function Set() { this.values = {}; // The properties of this object hold the set this.n = 0; // How many values are in the set // If passed a single array-like object, add its elements to the set // Otherwise, add all arguments to the set if (arguments.length == 1 && isArrayLike(arguments[0])) this.add.apply(this, arguments[0]); else if (arguments.length > 0) this.add.apply(this, arguments); }

Defining the Set() constructor this way allows us to explicitly list set members in the constructor call or to pass an array of members to the constructor. The constructor has an unfortunate ambiguity, however: we cannot use it to create a set that has an array as its sole member. (To do that, we’d have to create an empty set and then call the add() method explicitly.)

In the case of complex numbers initialized to polar coordinates, constructor overloading really isn’t viable. Both representations of complex numbers involve two floating-point numbers and, unless we add a third argument to the constructor, there is no way for the constructor to examine its arguments and determine which representation is desired. Instead, we can write a factory method—a class method that returns an instance of the class. Here is a factory method for returning a Complex object initialized using polar coordinates:

Complex.polar = function(r, theta) { return new Complex(r*Math.cos(theta), r*Math.sin(theta)); };

And here is a factory method for initializing a Set from an array:

Set.fromArray = function(a) { s = new Set(); // Create a new empty set s.add.apply(s, a); // Pass elements of array a to the add method return s; // Return the new set };

The appeal of factory methods here is that you can give them whatever name you want, and methods with different names can perform different kinds of initializations. Since constructors serve as the public identity of a class, however, there is usually only a single constructor per class. This is not a hard-and-fast rule, however. In JavaScript it is possible to define multiple constructor functions that share a single prototype object, and if you do this, objects created by any of the constructors will be of the same type. This technique is not recommended, but here is an auxiliary constructor of this type:

// An auxiliary constructor for the Set class. function SetFromArray(a) { // Initialize new object by invoking Set() as a function, // passing the elements of a as individual arguments. Set.apply(this, a); } // Set the prototype so that SetFromArray creates instances of Set SetFromArray.prototype = Set.prototype; var s = new SetFromArray([1,2,3]); s instanceof Set // => true

In ECMAScript 5, the bind() method of functions has special behavior that allows it to create this kind of auxiliary constructor. See The bind() Method.

* * *

[15] This example is based on a Java example by Joshua Bloch, available at http://jcp.org/aboutJava/communityprocess/jsr/tiger/enum.html.

Subclasses

In object-oriented programming, a class B can extend or subclass another class A. We say that A is the superclass and B is the subclass. Instances of B inherit all the instance methods of A. The class B can define its own instance methods, some of which may override methods of the same name defined by class A. If a method of B overrides a method of A, the overriding method in B may sometimes want to invoke the overridden method in A: this is called method chaining. Similarly, the subclass constructor B() may sometimes need to invoke the superclass constructor A(). This is called constructor chaining. Subclasses can themselves have subclasses, and when working with hierarchies of classes, it can sometimes be useful to define abstract classes. An abstract class is one that defines one or more methods without an implementation. The implementation of these abstract methods is left to the concrete subclasses of the abstract class.

The key to creating subclasses in JavaScript is proper initialization of the prototype object. If class B extends A, then B.prototype must be an heir of A.prototype. Then instances of B will inherit from B.prototype which in turn inherits from A.prototype. This section demonstrates each of the subclass-related terms defined above, and also covers an alternative to subclassing known as composition.

Using the Set class of Example 9-6 as a starting point, this section will demonstrate how to define subclasses, how to chain to constructors and overridden methods, how to use composition instead of inheritance, and finally, how to separate interface from implementation with abstract classes. The section ends with an extended example that defines a hierarchy of Set classes. Note that the early examples in this section are intended to demonstrate basic subclassing techniques. Some of these examples have important flaws that will be addressed later in the section.

Defining a Subclass

JavaScript objects inherit properties (usually methods) from the prototype object of their class. If an object O is an instance of a class B and B is a subclass of A, then O must also inherit properties from A. We arrange this by ensuring that the prototype object of B inherits from the prototype object of A. Using our inherit() function (Example 6-1), we write:

B.prototype = inherit(A.prototype); // Subclass inherits from superclass B.prototype.constructor = B; // Override the inherited constructor prop.

These two lines of code are the key to creating subclasses in JavaScript. Without them, the prototype object will be an ordinary object—an object that inherits from Object.prototype—and this means that your class will be a subclass of Object like all classes are. If we add these two lines to the defineClass() function (from Java-Style Classes in JavaScript), we can transform it into the defineSubclass() function and the Function.prototype.extend() method shown in Example 9-11.

Example 9-11. Subclass definition utilities

// A simple function for creating simple subclasses function defineSubclass(superclass, // Constructor of the superclass constructor, // The constructor for the new subclass methods, // Instance methods: copied to prototype statics) // Class properties: copied to constructor { // Set up the prototype object of the subclass constructor.prototype = inherit(superclass.prototype); constructor.prototype.constructor = constructor; // Copy the methods and statics as we would for a regular class if (methods) extend(constructor.prototype, methods); if (statics) extend(constructor, statics); // Return the class return constructor; } // We can also do this as a method of the superclass constructor Function.prototype.extend = function(constructor, methods, statics) { return defineSubclass(this, constructor, methods, statics); };

Example 9-12 demonstrates how to write a subclass「manually」without using the defineSubclass() function. It defines a SingletonSet subclass of Set. A SingletonSet is a specialized set that is read-only and has a single constant member.

Example 9-12. SingletonSet: a simple set subclass

// The constructor function function SingletonSet(member) { this.member = member; // Remember the single member of the set } // Create a prototype object that inherits from the prototype of Set. SingletonSet.prototype = inherit(Set.prototype); // Now add properties to the prototype. // These properties override the properties of the same name from Set.prototype. extend(SingletonSet.prototype, { // Set the constructor property appropriately constructor: SingletonSet, // This set is read-only: add() and remove() throw errors add: function() { throw "read-only set"; }, remove: function() { throw "read-only set"; }, // A SingletonSet always has size 1 size: function() { return 1; }, // Just invoke the function once, passing the single member. foreach: function(f, context) { f.call(context, this.member); }, // The contains() method is simple: true only for one value contains: function(x) { return x === this.member; } });

Our SingletonSet class has a very simple implementation that consists of five simple method definitions. It implements these five core Set methods, but inherits methods such as toString(), toArray() and equals() from its superclass. This inheritance of methods is the reason for defining subclasses. The equals() method of the Set class (defined in Comparison Methods), for example, works to compare any Set instance that has working size() and foreach() methods with any Set that has working size() and contains() methods. Because SingletonSet is a subclass of Set, it inherits this equals() implementation automatically and doesn’t have to write its own. Of course, given the radically simple nature of singleton sets, it might be more efficient for SingletonSet to define its own version of equals():

SingletonSet.prototype.equals = function(that) { return that instanceof Set && that.size()==1 && that.contains(this.member); };

Note that SingletonSet does not statically borrow a list of methods from Set: it dynamically inherits the methods of the Set class. If we add a new method to Set.prototype, it immediately becomes available to all instances of Set and of SingletonSet (assuming SingletonSet does not already define a method by the same name).

Constructor and Method Chaining

The SingletonSet class in the last section defined a completely new set implementation, and completely replaced the core methods it inherited from its superclass. Often, however, when we define a subclass, we only want to augment or modify the behavior of our superclass methods, not replace them completely. To do this, the constructor and methods of the subclass call or chain to the superclass constructor and the superclass methods.

Example 9-13 demonstrates this. It defines a subclass of Set named NonNullSet: a set that does not allow null and undefined as members. In order to restrict the membership in this way, NonNullSet needs to test for null and undefined values in its add() method. But it doesn’t want to reimplement the add() method completely, so it chains to the superclass version of the method. Notice also that the NonNullSet() constructor doesn’t take any action of its own: it simply passes its arguments to the superclass constructor (invoking it as a function, not as a constructor) so that the superclass constructor can initialize the newly created object.

Example 9-13. Constructor and method chaining from subclass to superclass

/* * NonNullSet is a subclass of Set that does not allow null and undefined * as members of the set. */ function NonNullSet() { // Just chain to our superclass. // Invoke the superclass constructor as an ordinary function to initialize // the object that has been created by this constructor invocation. Set.apply(this, arguments); } // Make NonNullSet a subclass of Set: NonNullSet.prototype = inherit(Set.prototype); NonNullSet.prototype.constructor = NonNullSet; // To exclude null and undefined, we only have to override the add() method NonNullSet.prototype.add = function() { // Check for null or undefined arguments for(var i = 0; i < arguments.length; i++) if (arguments[i] == null) throw new Error("Can't add null or undefined to a NonNullSet"); // Chain to the superclass to perform the actual insertion return Set.prototype.add.apply(this, arguments); };

Let’s generalize this notion of a non-null set to a「filtered set」: a set whose members must pass through a filter function before being added. We’ll define a class factory function (like the enumeration() function from Example 9-7) that is passed a filter function and returns a new Set subclass. In fact, we can generalize even further and define our class factory to take two arguments: the class to subclass and the filter to apply to its add() method. We’ll call this factory method filteredSetSubclass(), and we might use it like this:

// Define a set class that holds strings only var StringSet = filteredSetSubclass(Set, function(x) {return typeof x==="string";}); // Define a set class that does not allow null, undefined or functions var MySet = filteredSetSubclass(NonNullSet, function(x) {return typeof x !== "function";});

The code for this class factory function is in Example 9-14. Notice how this function performs the same method and constructor chaining as NonNullSet did.

Example 9-14. A class factory and method chaining

/* * This function returns a subclass of specified Set class and overrides * the add() method of that class to apply the specified filter. */ function filteredSetSubclass(superclass, filter) { var constructor = function() { // The subclass constructor superclass.apply(this, arguments); // Chains to the superclass }; var proto = constructor.prototype = inherit(superclass.prototype); proto.constructor = constructor; proto.add = function() { // Apply the filter to all arguments before adding any for(var i = 0; i < arguments.length; i++) { var v = arguments[i]; if (!filter(v)) throw("value " + v + " rejected by filter"); } // Chain to our superclass add implementation superclass.prototype.add.apply(this, arguments); }; return constructor; }

One interesting point to note about Example 9-14 is that by wrapping a function around our subclass creation code, we are able to use the superclass argument in our constructor and method chaining code rather than hard-coding the name of the actual superclass. This means that if we wanted to change the superclass, we would only have to change it in one spot, rather than searching our code for every mention of it. This is arguably a technique that is worth using, even if we’re not defining a class factory. For example, we could rewrite our NonNullSet using a wrapper function and the Function.prototype.extend() method (of Example 9-11) like this:

var NonNullSet = (function() { // Define and invoke function var superclass = Set; // Only specify the superclass once. return superclass.extend( function() { superclass.apply(this, arguments); }, // the constructor { // the methods add: function() { // Check for null or undefined arguments for(var i = 0; i < arguments.length; i++) if (arguments[i] == null) throw new Error("Can't add null or undefined"); // Chain to the superclass to perform the actual insertion return superclass.prototype.add.apply(this, arguments); } }); }());

Finally, it is worth emphasizing that the ability to create class factories like this one arises from the dynamic nature of JavaScript. Class factories are a powerful and useful feature that has no analog in languages like Java and C++.

Composition Versus Subclassing

In the previous section, we wanted to define sets that restricted their members according to certain criteria, and we used subclassing to accomplish this, creating a custom subclass of a specified set implementation that used a specified filter function to restrict membership in the set. Each combination of superclass and filter function required the creation of a new class.

There is a better way to accomplish this, however. A well-known principle in object-oriented design is「favor composition over inheritance.」[16] In this case we can use composition by defining a new set implementation that「wraps」another set object and forwards requests to it, after filtering out prohibited members. Example 9-15 shows how it is done.

Example 9-15. Composing sets instead of subclassing them

/* * A FilteredSet wraps a specified set object and applies a specified filter * to values passed to its add() method. All of the other core set methods * simply forward to the wrapped set instance. */ var FilteredSet = Set.extend( function FilteredSet(set, filter) { // The constructor this.set = set; this.filter = filter; }, { // The instance methods add: function() { // If we have a filter, apply it if (this.filter) { for(var i = 0; i < arguments.length; i++) { var v = arguments[i]; if (!this.filter(v)) throw new Error("FilteredSet: value " + v + " rejected by filter"); } } // Now forward the add() method to this.set.add() this.set.add.apply(this.set, arguments); return this; }, // The rest of the methods just forward to this.set and do nothing else. remove: function() { this.set.remove.apply(this.set, arguments); return this; }, contains: function(v) { return this.set.contains(v); }, size: function() { return this.set.size(); }, foreach: function(f,c) { this.set.foreach(f,c); } });

One of the benefits of using composition in this case is that only a single FilteredSet subclass is required. Instances of this class can be created to restrict the membership of any other set instance. Instead of using the NonNullSet class defined earlier, for example, we can do this:

var s = new FilteredSet(new Set(), function(x) { return x !== null; });

We can even filter a filtered set:

var t = new FilteredSet(s, { function(x} { return !(x instanceof Set); });

Class Hierarchies and Abstract Classes

In the previous section you were urged to「favor composition over inheritance.」But to illustrate this principle, we created a subclass of Set. We did this so that the resulting class would be instanceof Set, and so that it could inherit the useful auxiliary Set methods like toString() and equals(). These are valid pragmatic reasons, but it still would have been nice to be able to do set composition without subclassing a concrete implementation like the Set class. A similar point can be made about our SingletonSet class from Example 9-12—that class subclassed Set, so that it could inherit the auxiliary methods, but its implementation was completely different than its superclass. SingletonSet is not a specialized version of the Set class, but a completely different kind of Set. SingletonSet should be a sibling of Set in the class hierarchy, not a descendant of it.

The solution in classical OO languages and also in JavaScript is to separate interface from implementation. Suppose we define an AbstractSet class which implements the auxiliary methods like toString() but does not implement the core methods like foreach(). Then, our set implementations, Set, SingletonSet, and FilteredSet, can all be subclasses of AbstractSet. FilteredSet and SingletonSet no longer subclass an unrelated implementation.

Example 9-16 takes this approach further and defines a hierarchy of abstract set classes. AbstractSet defines only a single abstract method, contains(). Any class that purports to be a set must define at least this one method. Next, we subclass AbstractSet to define AbstractEnumerableSet. That class adds abstract size() and foreach() methods, and defines useful concrete methods (toString(), toArray(), equals(), and so on) on top of them. AbstractEnumerableSet does not define add() or remove() methods and represents read-only sets. SingletonSet can be implemented as a concrete subclass. Finally, we define AbstractWritableSet as a subclass of AbstractEnumerableSet. This final abstract set defines the abstract methods add() and remove(), and implements concrete methods like union() and intersection() that use them. AbstractWritableSet is the appropriate superclass for our Set and FilteredSet classes. They are omitted from this example, however, and a new concrete implementation named ArraySet is included instead.

Example 9-16 is a long example, but worth reading through in its entirety. Note that it uses Function.prototype.extend() as a shortcut for creating subclasses.

Example 9-16. A hierarchy of abstract and concrete Set classes

// A convenient function that can be used for any abstract method function abstractmethod() { throw new Error("abstract method"); } /* * The AbstractSet class defines a single abstract method, contains(). */ function AbstractSet() { throw new Error("Can't instantiate abstract classes");} AbstractSet.prototype.contains = abstractmethod; /* * NotSet is a concrete subclass of AbstractSet. * The members of this set are all values that are not members of some * other set. Because it is defined in terms of another set it is not * writable, and because it has infinite members, it is not enumerable. * All we can do with it is test for membership. * Note that we're using the Function.prototype.extend() method we defined * earlier to define this subclass. */ var NotSet = AbstractSet.extend( function NotSet(set) { this.set = set; }, { contains: function(x) { return !this.set.contains(x); }, toString: function(x) { return "~" + this.set.toString(); }, equals: function(that) { return that instanceof NotSet && this.set.equals(that.set); } } ); /* * AbstractEnumerableSet is an abstract subclass of AbstractSet. * It defines the abstract methods size() and foreach(), and then implements * concrete isEmpty(), toArray(), to[Locale]String(), and equals() methods * on top of those. Subclasses that implement contains(), size(), and foreach() * get these five concrete methods for free. */ var AbstractEnumerableSet = AbstractSet.extend( function() { throw new Error("Can't instantiate abstract classes"); }, { size: abstractmethod, foreach: abstractmethod, isEmpty: function() { return this.size() == 0; }, toString: function() { var s = "{", i = 0; this.foreach(function(v) { if (i++ > 0) s += ", "; s += v; }); return s + "}"; }, toLocaleString : function() { var s = "{", i = 0; this.foreach(function(v) { if (i++ > 0) s += ", "; if (v == null) s += v; // null & undefined else s += v.toLocaleString(); // all others }); return s + "}"; }, toArray: function() { var a = []; this.foreach(function(v) { a.push(v); }); return a; }, equals: function(that) { if (!(that instanceof AbstractEnumerableSet)) return false; // If they don't have the same size, they're not equal if (this.size() != that.size()) return false; // Now check whether every element in this is also in that. try { this.foreach(function(v) {if (!that.contains(v)) throw false;}); return true; // All elements matched: sets are equal. } catch (x) { if (x === false) return false; // Sets are not equal throw x; // Some other exception occurred: rethrow it. } } }); /* * SingletonSet is a concrete subclass of AbstractEnumerableSet. * A singleton set is a read-only set with a single member. */ var SingletonSet = AbstractEnumerableSet.extend( function SingletonSet(member) { this.member = member; }, { contains: function(x) { return x === this.member; }, size: function() { return 1; }, foreach: function(f,ctx) { f.call(ctx, this.member); } } ); /* * AbstractWritableSet is an abstract subclass of AbstractEnumerableSet. * It defines the abstract methods add() and remove(), and then implements * concrete union(), intersection(), and difference() methods on top of them. */ var AbstractWritableSet = AbstractEnumerableSet.extend( function() { throw new Error("Can't instantiate abstract classes"); }, { add: abstractmethod, remove: abstractmethod, union: function(that) { var self = this; that.foreach(function(v) { self.add(v); }); return this; }, intersection: function(that) { var self = this; this.foreach(function(v) { if (!that.contains(v)) self.remove(v);}); return this; }, difference: function(that) { var self = this; that.foreach(function(v) { self.remove(v); }); return this; } }); /* * An ArraySet is a concrete subclass of AbstractWritableSet. * It represents the set elements as an array of values, and uses a linear * search of the array for its contains() method. Because the contains() * method is O(n) rather than O(1), it should only be used for relatively * small sets. Note that this implementation relies on the ES5 Array methods * indexOf() and forEach(). */ var ArraySet = AbstractWritableSet.extend( function ArraySet() { this.values = []; this.add.apply(this, arguments); }, { contains: function(v) { return this.values.indexOf(v) != -1; }, size: function() { return this.values.length; }, foreach: function(f,c) { this.values.forEach(f, c); }, add: function() { for(var i = 0; i < arguments.length; i++) { var arg = arguments[i]; if (!this.contains(arg)) this.values.push(arg); } return this; }, remove: function() { for(var i = 0; i < arguments.length; i++) { var p = this.values.indexOf(arguments[i]); if (p == -1) continue; this.values.splice(p, 1); } return this; } } );

* * *

[16] See Design Patterns by Erich Gamma et al. or Effective Java by Joshua Bloch, for example.

Classes in ECMAScript 5

ECMAScript 5 adds methods for specifying property attributes (getters, setters, enumerability, writability, and configurability) and for restricting the extensibility of objects. These methods were described in Property Getters and Setters, Property Attributes, and The extensible Attribute, but turn out to be quite useful when defining classes. The subsections that follow demonstrate how to use these ECMAScript 5 capabilities to make your classes more robust.

Making Properties Nonenumerable

The Set class of Example 9-6 used a trick to store objects as set members: it defined an「object id」property on any object added to the set. Later, if other code uses that object in a for/in loop, this added property will be returned. ECMAScript 5 allows us to avoid this by making properties nonenumerable. Example 9-17 demonstrates how to do this with Object.defineProperty() and also shows how to define a getter function and how to test whether an object is extensible.

Example 9-17. Defining nonenumerable properties

// Wrap our code in a function so we can define variables in the function scope (function() { // Define objectId as a nonenumerable property inherited by all objects. // When this property is read, the getter function is invoked. // It has no setter, so it is read-only. // It is nonconfigurable, so it can't be deleted. Object.defineProperty(Object.prototype, "objectId", { get: idGetter, // Method to get value enumerable: false, // Nonenumerable configurable: false // Can't delete it }); // This is the getter function called when objectId is read function idGetter() { // A getter function to return the id if (!(idprop in this)) { // If object doesn't already have an id if (!Object.isExtensible(this)) // And if we can add a property throw Error("Can't define id for nonextensible objects"); Object.defineProperty(this, idprop, { // Give it one now. value: nextid++, // This is the value writable: false, // Read-only enumerable: false, // Nonenumerable configurable: false // Nondeletable }); } return this[idprop]; // Now return the existing or new value }; // These variables are used by idGetter() and are private to this function var idprop = "|**objectId**|"; // Assume this property isn't in use var nextid = 1; // Start assigning ids at this # }()); // Invoke the wrapper function to run the code right away

Defining Immutable Classes

In addition to making properties nonenumerable, ECMAScript 5 allows us to make properties read-only, which is handy if we want to define classes whose instances are immutable. Example 9-18 is an immutable version of our Range class that does this using Object.defineProperties() and with Object.create(). It also uses Object.defineProperties() to set up the prototype object for the class, making the instance methods nonenumerable, like the methods of built-in classes. In fact, it goes further than this and makes those instance methods read-only and nondeletable, which prevents any dynamic alterations (「monkey-patching」) to the class. Finally, as an interesting trick, Example 9-18 has a constructor function that works as a factory function when invoked without the new keyword.

Example 9-18. An immutable class with read-only properties and methods

// This function works with or without 'new': a constructor and factory function function Range(from,to) { // These are descriptors for the read-only from and to properties. var props = { from: {value:from, enumerable:true, writable:false, configurable:false}, to: {value:to, enumerable:true, writable:false, configurable:false} }; if (this instanceof Range) // If invoked as a constructor Object.defineProperties(this, props); // Define the properties else // Otherwise, as a factory return Object.create(Range.prototype, // Create and return a new props); // Range object with props } // If we add properties to the Range.prototype object in the same way, // then we can set attributes on those properties. Since we don't specify // enumerable, writable, or configurable, they all default to false. Object.defineProperties(Range.prototype, { includes: { value: function(x) { return this.from <= x && x <= this.to; } }, foreach: { value: function(f) { for(var x = Math.ceil(this.from); x <= this.to; x++) f(x); } }, toString: { value: function() { return "(" + this.from + "..." + this.to + ")"; } } });

Example 9-18 uses Object.defineProperties() and Object.create() to define immutable and nonenumerable properties. These are powerful methods, but the property descriptor objects they require can make the code difficult to read. An alternative is to define utility functions for modifying the attributes of properties that have already been defined. Example 9-19 shows two such utility functions.

Example 9-19. Property descriptor utilities

// Make the named (or all) properties of o nonwritable and nonconfigurable. function freezeProps(o) { var props = (arguments.length == 1) // If 1 arg ? Object.getOwnPropertyNames(o) // use all props : Array.prototype.splice.call(arguments, 1); // else named props props.forEach(function(n) { // Make each one read-only and permanent // Ignore nonconfigurable properties if (!Object.getOwnPropertyDescriptor(o,n).configurable) return; Object.defineProperty(o, n, { writable: false, configurable: false }); }); return o; // So we can keep using it } // Make the named (or all) properties of o nonenumerable, if configurable. function hideProps(o) { var props = (arguments.length == 1) // If 1 arg ? Object.getOwnPropertyNames(o) // use all props : Array.prototype.splice.call(arguments, 1); // else named props props.forEach(function(n) { // Hide each one from the for/in loop // Ignore nonconfigurable properties if (!Object.getOwnPropertyDescriptor(o,n).configurable) return; Object.defineProperty(o, n, { enumerable: false }); }); return o; }

Object.defineProperty() and Object.defineProperties() can be used to create new properties and also to modify the attributes of existing properties. When used to define new properties, any attributes you omit default to false. When used to alter existing properties, however, the attributes you omit are left unchanged. In the hideProps() function above, for example, we specify only the enumerable attribute because that is the only one we want to modify.

With these utility functions defined, we can take advantage of ECMAScript 5 features to write an immutable class without dramatically altering the way we write classes. Example 9-20 shows an immutable Range class that uses our utility functions.

Example 9-20. A simpler immutable class

function Range(from, to) { // Constructor for an immutable Range class this.from = from; this.to = to; freezeProps(this); // Make the properties immutable } Range.prototype = hideProps({ // Define prototype with nonenumerable properties constructor: Range, includes: function(x) { return this.from <= x && x <= this.to; }, foreach: function(f) {for(var x=Math.ceil(this.from);x<=this.to;x++) f(x);}, toString: function() { return "(" + this.from + "..." + this.to + ")"; } });

Encapsulating Object State

Private State and Example 9-10 showed how you can use variables or arguments of a constructor function as private state for the objects created by that constructor. The shortcoming of this technique is that in ECMAScript 3, the accessor methods that provide access to that state can be replaced. ECMAScript 5 allows us to encapsulate our state variables more robustly by defining property getter and setter methods that cannot be deleted. Example 9-21 demonstrates.

Example 9-21. A Range class with strongly encapsulated endpoints

// This version of the Range class is mutable but encapsulates its endpoint // variables to maintain the invariant that from <= to. function Range(from, to) { // Verify that the invariant holds when we're created if (from > to) throw new Error("Range: from must be <= to"); // Define the accessor methods that maintain the invariant function getFrom() { return from; } function getTo() { return to; } function setFrom(f) { // Don't allow from to be set > to if (f <= to) from = f; else throw new Error("Range: from must be <= to"); } function setTo(t) { // Don't allow to to be set < from if (t >= from) to = t; else throw new Error("Range: to must be >= from"); } // Create enumerable, nonconfigurable properties that use the accessors Object.defineProperties(this, { from: {get: getFrom, set: setFrom, enumerable:true, configurable:false}, to: { get: getTo, set: setTo, enumerable:true, configurable:false } }); } // The prototype object is unchanged from previous examples. // The instance methods read from and to as if they were ordinary properties. Range.prototype = hideProps({ constructor: Range, includes: function(x) { return this.from <= x && x <= this.to; }, foreach: function(f) {for(var x=Math.ceil(this.from);x<=this.to;x++) f(x);}, toString: function() { return "(" + this.from + "..." + this.to + ")"; } });

Preventing Class Extensions

It is usually considered a feature of JavaScript that classes can be dynamically extended by adding new methods to the prototype object. ECMAScript 5 allows you to prevent this, if you want to. Object.preventExtensions() makes an object nonextensible (The extensible Attribute), which means that no new properties can be added to it. Object.seal() takes this a step further: it prevents the addition of new properties and also makes all current properties nonconfigurable, so that they cannot be deleted. (A nonconfigurable property can still be writable, however, and can still be converted into a read-only property.) To prevent extensions to Object.prototype, you can simply write:

Object.seal(Object.prototype);

Another dynamic feature of JavaScript is the ability to replace (or「monkey-patch」) methods of an object:

var original_sort_method = Array.prototype.sort; Array.prototype.sort = function() { var start = new Date(); original_sort_method.apply(this, arguments); var end = new Date(); console.log("Array sort took " + (end - start) + " milliseconds."); };

You can prevent this kind of alteration by making your instance methods read-only. The freezeProps() utility function defined above is one way to accomplish this. Another way is with Object.freeze(), which does everything that Object.seal() does, but also makes all properties read-only and nonconfigurable.

There is a feature of read-only properties that is important to understand when working with classes. If an object o inherits a read-only property p, an attempt to assign to o.p will fail and will not create a new property in o. If you want to override an inherited read-only property, you have to use Object.defineProperty() or Object.defineProperties() or Object.create() to create the new property. This means that if you make the instance methods of a class read-only, it becomes significantly more difficult for subclasses to override those methods.

It is not usually necessary to lock down prototype objects like this, but there are some circumstances where preventing extensions to an object can be useful. Think back to the enumeration() class factory function of Example 9-7. That function stored the instances of each enumerated type in properties of the constructor object, and also in the values array of the constructor. These properties and array serve as the official list of instances of the enumerated type, and it is worth freezing them, so that new instances cannot be added and existing instances cannot be deleted or altered. In the enumeration() function we can simply add these lines of code:

Object.freeze(enumeration.values); Object.freeze(enumeration);

Notice that by calling Object.freeze() on the enumerated type, we prevent the future use of the objectId property defined in Example 9-17. A solution to this problem is to read the objectId property (calling the underlying accessor method and setting the internal property) of the enumerated type once before freezing it.

Subclasses and ECMAScript 5

Example 9-22 demonstrates subclassing using ECMAScript 5 features. It defines a StringSet class as a subclass of the AbstractWritableSet class from Example 9-16. The main feature of this example is the use of Object.create() to create a prototype object that inherits from the superclass prototype and also define the properties of the newly created object. The difficulty with this approach, as mentioned earlier, is that it requires the use of awkward property descriptors.

Another interesting point about this example is that it passes null to Object.create() to create an object that inherits nothing. This object is used to store the members of the set, and the fact that it has no prototype allows us to use the in operator with it instead of the hasOwnProperty() method.

Example 9-22. StringSet: a set subclass using ECMAScript 5

function StringSet() { this.set = Object.create(null); // Create object with no proto this.n = 0; this.add.apply(this, arguments); } // Note that with Object.create we can inherit from the superclass prototype // and define methods in a single call. Since we don't specify any of the // writable, enumerable, and configurable properties, they all default to false. // Readonly methods makes this class trickier to subclass. StringSet.prototype = Object.create(AbstractWritableSet.prototype, { constructor: { value: StringSet }, contains: { value: function(x) { return x in this.set; } }, size: { value: function(x) { return this.n; } }, foreach: { value: function(f,c) { Object.keys(this.set).forEach(f,c); } }, add: { value: function() { for(var i = 0; i < arguments.length; i++) { if (!(arguments[i] in this.set)) { this.set[arguments[i]] = true; this.n++; } } return this; } }, remove: { value: function() { for(var i = 0; i < arguments.length; i++) { if (arguments[i] in this.set) { delete this.set[arguments[i]]; this.n--; } } return this; } } });

Property Descriptors

Property Attributes described the property descriptors of ECMAScript 5 but didn’t include many examples of their use. We conclude this section on ECMAScript 5 with an extended example that will demonstrate many operations on ECMAScript 5 properties. Example 9-23 will add a properties() method (nonenumerable, of course) to Object.prototype. The return value of this method is an object that represents a list of properties and defines useful methods for displaying the properties and attributes (useful for debugging), for obtaining property descriptors (useful when you want to copy properties along with their attributes), and for setting attributes on the properties (useful alternatives to the hideProps() and freezeProps() functions defined earlier). This one example demonstrates most of the property-related features of ECMAScript 5, and also uses a modular coding technique that will be discussed in the next section.

Example 9-23. ECMAScript 5 properties utilities

/* * Define a properties() method in Object.prototype that returns an * object representing the named properties of the object on which it * is invoked (or representing all own properties of the object, if * invoked with no arguments). The returned object defines four useful * methods: toString(), descriptors(), hide(), and show(). */ (function namespace() { // Wrap everything in a private function scope // This is the function that becomes a method of all object function properties() { var names; // An array of property names if (arguments.length == 0) // All own properties of this names = Object.getOwnPropertyNames(this); else if (arguments.length == 1 && Array.isArray(arguments[0])) names = arguments[0]; // Or an array of names else // Or the names in the argument list names = Array.prototype.splice.call(arguments, 0); // Return a new Properties object representing the named properties return new Properties(this, names); } // Make it a new nonenumerable property of Object.prototype. // This is the only value exported from this private function scope. Object.defineProperty(Object.prototype, "properties", { value: properties, enumerable: false, writable: true, configurable: true }); // This constructor function is invoked by the properties() function above. // The Properties class represents a set of properties of an object. function Properties(o, names) { this.o = o; // The object that the properties belong to this.names = names; // The names of the properties } // Make the properties represented by this object nonenumerable Properties.prototype.hide = function() { var o = this.o, hidden = { enumerable: false }; this.names.forEach(function(n) { if (o.hasOwnProperty(n)) Object.defineProperty(o, n, hidden); }); return this; }; // Make these properties read-only and nonconfigurable Properties.prototype.freeze = function() { var o = this.o, frozen = { writable: false, configurable: false }; this.names.forEach(function(n) { if (o.hasOwnProperty(n)) Object.defineProperty(o, n, frozen); }); return this; }; // Return an object that maps names to descriptors for these properties. // Use this to copy properties along with their attributes: // Object.defineProperties(dest, src.properties().descriptors()); Properties.prototype.descriptors = function() { var o = this.o, desc = {}; this.names.forEach(function(n) { if (!o.hasOwnProperty(n)) return; desc[n] = Object.getOwnPropertyDescriptor(o,n); }); return desc; }; // Return a nicely formatted list of properties, listing the // name, value and attributes. Uses the term "permanent" to mean // nonconfigurable, "readonly" to mean nonwritable, and "hidden" // to mean nonenumerable. Regular enumerable, writable, configurable // properties have no attributes listed. Properties.prototype.toString = function() { var o = this.o; // Used in the nested function below var lines = this.names.map(nameToString); return "{\n " + lines.join(",\n ") + "\n}"; function nameToString(n) { var s = "", desc = Object.getOwnPropertyDescriptor(o, n); if (!desc) return "nonexistent " + n + ": undefined"; if (!desc.configurable) s += "permanent "; if ((desc.get && !desc.set) || !desc.writable) s += "readonly "; if (!desc.enumerable) s += "hidden "; if (desc.get || desc.set) s += "accessor " + n else s += n + ": " + ((typeof desc.value==="function")?"function" :desc.value); return s; } }; // Finally, make the instance methods of the prototype object above // nonenumerable, using the methods we've defined here. Properties.prototype.properties().hide(); }()); // Invoke the enclosing function as soon as we're done defining it.

Modules

An important reason to organize code into classes is to make that code more modular and suitable for reuse in a variety of situations. Classes are not the only kind of modular code, however. Typically, a module is a single file of JavaScript code. A module file might contain a class definition, a set of related classes, a library of utility functions, or just a script of code to execute. Any chunk of JavaScript code can be a module, as long as it is written in a modular way. JavaScript does not define any language constructs for working with modules (it does reserve the keywords imports and exports, however, so future versions of the language might), which means that writing modular JavaScript is largely a matter of following certain coding conventions.

Many JavaScript libraries and client-side programming frameworks include some kind of module system. Both the Dojo toolkit and Google’s Closure library, for example, define provide() and require() functions for declaring and loading modules. And the CommonJS server-side JavaScript standardization effort (see http://commonjs.org) has created a modules specification that also uses a require() function. Module systems like this often handle module loading and dependency management for you and are beyond the scope of this discussion. If you use one of these frameworks, then you should use and define modules following the conventions appropriate to that framework. In this section we’ll discuss very simple module conventions.

The goal of modules is to allow large programs to be assembled using code from disparate sources, and for all of that code to run correctly even in the presence of code that the module authors did not anticipate. In order for this to work, the various modules must avoid altering the global execution environment, so that subsequent modules are allowed to run in the pristine (or near pristine) environment that it expects. As a practical matter, this means that modules should minimize the number of global symbols they define—ideally, no module should define more than one. The subsections that follow describe simple ways to accomplish this. You’ll see that writing modular code in JavaScript is not at all tricky: we’ve seen examples of the techniques described here throughout this book.

Objects As Namespaces

One way for a module to avoid the creation of global variables is to use an object as its namespace. Instead of defining global functions and variables, it stores the functions and values as properties of an object (which may be referenced by a global variable). Consider the Set class of Example 9-6. It defines a single global constructor function Set. It defines various instance methods for the class, but it stores them as properties of Set.prototype so they are not globals. That example also defines a _v2s() utility function, but instead of making it a global function, it stores it as a property of Set.

Next, consider Example 9-16. That example defined a number of abstract and concrete set classes. Each class had only a single global symbol, but the whole module (the single file of code) defined quite a few globals. From the standpoint of a clean global namespace, it would be better if this module of set classes defined a single global:

var sets = {};

This sets object is the namespace for the module, and we define each of the set classes as a property of this object:

sets.SingletonSet = sets.AbstractEnumerableSet.extend(...);

When we want to use a class defined like this, we simply include the namespace when we refer to the constructor:

var s = new sets.SingletonSet(1);

The author of a module cannot know what other modules their module will be used with and must guard against name collisions by using namespaces like this. The programmer who uses the module, however, knows what modules are in use and what names are defined. This programmer doesn’t have to keep using the namespaces rigidly, and can import frequently used values into the global namespace. A programmer who was going to make frequent use of the Set class from the sets namespace might import the class like this:

var Set = sets.Set; // Import Set to the global namespace var s = new Set(1,2,3); // Now we can use it without the sets prefix.

Sometimes module authors use more deeply nested namespaces. If the sets module was part of a larger group of collections modules, it might use collections.sets as a namespace, and the module would begin with code like this:

var collections; // Declare (or re-declare) the single global variable if (!collections) // If it doesn't already exist collections = {}; // Create a toplevel namespace object collections.sets = {} // And create the sets namespace within that. // Now start defining our set classes inside collections.sets collections.sets.AbstractSet = function() { ... }

Sometimes the top-level namespace is used to identify the person or organization that created the modules and prevent name collisions between namespace names. The Google Closure library, for example, defines its Set class in the namespace goog.structs. Individuals can reverse the components of an Internet domain name to create a globally unique namespace prefix that is unlikely to be in use by any other module authors. Since my website is at davidflanagan.com, I could publish my sets module in the namespace com.davidflanagan.collections.sets.

With namespaces this long, importing values becomes important for any user of your module. Rather than importing individual classes, however, a programmer might import the entire module to the global namespace:

var sets = com.davidflanagan.collections.sets;

By convention, the filename of a module should match its namespace. The sets module should be stored in a file named sets.js. If that module uses the namespace collections.sets, then this file should be stored in a directory named collections/ (this directory might also include a file named maps.js). And a module that used the namespace com.davidflanagan.collections.sets would be in com/davidflanagan/collections/sets.js.

Function Scope As a Private Namespace

Modules have a public API that they export: these are the functions, classes, properties, and methods that are intended to be used by other programmers. Often, however, module implementations require additional functions or methods that are not intended for use outside of the module. The Set._v2s() function of Example 9-6 is an example—we don’t want users of the Set class to ever call that function, so it would be better if it was inaccessible.

We can do that by defining our module (the Set class in this case) inside a function. As described in Functions As Namespaces, variables and functions defined within another function are local to that function and not visible outside of it. In effect, we can use the scope of a function (sometimes called a「module function」) as a private namespace for our module. Example 9-24 shows what this might look like for our Set class.

Example 9-24. A Set class in a module function

// Declare a global variable Set and assign it the return value of this function // The open parenthesis and the function name below hint that the function // will be invoked immediately after being defined, and that it is the function // return value, not the function itself, that is being assigned. // Note that this is a function expression, not a statement, so the name // "invocation" does not create a global variable. var Set = (function invocation() { function Set() { // This constructor function is a local variable. this.values = {}; // The properties of this object hold the set this.n = 0; // How many values are in the set this.add.apply(this, arguments); // All arguments are values to add } // Now define instance methods on Set.prototype. // For brevity, code has been omitted here Set.prototype.contains = function(value) { // Note that we call v2s(), not the heavily prefixed Set._v2s() return this.values.hasOwnProperty(v2s(value)); }; Set.prototype.size = function() { return this.n; }; Set.prototype.add = function() { /* ... */ }; Set.prototype.remove = function() { /* ... */ }; Set.prototype.foreach = function(f, context) { /* ... */ }; // These are helper functions and variables used by the methods above // They're not part of the public API of the module, but they're hidden // within this function scope so we don't have to define them as a // property of Set or prefix them with underscores. function v2s(val) { /* ... */ } function objectId(o) { /* ... */ } var nextId = 1; // The public API for this module is the Set() constructor function. // We need to export that function from this private namespace so that // it can be used on the outside. In this case, we export the constructor // by returning it. It becomes the value of the assignment expression // on the first line above. return Set; }()); // Invoke the function immediately after defining it.

Note that this function definition followed by immediate invocation is idiomatic in JavaScript. Code that is to run in a private namespace is prefixed by「(function() {」and followed by「}());」. The open parenthesis at the start ensures that this is a function expression, not a function definition statement, so any function name that clarifies your code can be added to the prefix. In Example 9-24 we used the name「invocation」to emphasize that the function would be invoked immediately after being defined. The name「namespace」could also be used to emphasize that the function was serving as a namespace.

Once module code has been sealed up inside a function, it needs some way to export its public API so that it can be used from outside the module function. In Example 9-24, the module function returned the constructor, which we then assigned to a global variable. The fact that the value is returned makes it very clear that it is being exported outside of the function scope. Modules that have more than one item in their API can return a namespace object. For our sets module, we might write code that looks something like this:

// Create a single global variable to hold all collection-related modules var collections; if (!collections) collections = {}; // Now define the sets module collections.sets = (function namespace() { // Define the various set classes here, using local variables and functions // ... Lots of code omitted... // Now export our API by returning a namespace object return { // Exported property name : local variable name AbstractSet: AbstractSet, NotSet: NotSet, AbstractEnumerableSet: AbstractEnumerableSet, SingletonSet: SingletonSet, AbstractWritableSet: AbstractWritableSet, ArraySet: ArraySet }; }());

A similar technique is to treat the module function as a constructor, invoke it with new, and export values by assigning them to this:

var collections; if (!collections) collections = {}; collections.sets = (new function namespace() { // ... Lots of code omitted... // Now export our API to the this object this.AbstractSet = AbstractSet; this.NotSet = NotSet; // And so on.... // Note no return value. }());

As an alternative, if a global namespace object has already been defined, the module function can simply set properties of that object directly, and not bother returning anything at all:

var collections; if (!collections) collections = {}; collections.sets = {}; (function namespace() { // ... Lots of code omitted... // Now export our public API to the namespace object created above collections.sets.AbstractSet = AbstractSet; collections.sets.NotSet = NotSet; // And so on... // No return statement is needed since exports were done above. }());

Frameworks that define module loading systems may have other methods of exporting a module’s API. There may be a provides() function for modules to register their API, or an exports object into which modules must store their API. Until JavaScript has module management features of its own, you should choose the module creation and exporting system that works best with whatever framework or toolkit you use.

Chapter 10. Pattern Matching with Regular Expressions

A regular expression is an object that describes a pattern of characters. The JavaScript RegExp class represents regular expressions, and both String and RegExp define methods that use regular expressions to perform powerful pattern-matching and search-and-replace functions on text. JavaScript’s regular expression grammar is a fairly complete subset of the regular-expression syntax used by Perl 5, so if you are an experienced Perl programmer, you already know how to describe patterns in JavaScript.[17]

This chapter begins by defining the syntax that regular expressions use to describe textual patterns. It then moves on to describe the String and RegExp methods that use regular expressions.

Defining Regular Expressions

In JavaScript, regular expressions are represented by RegExp objects. RegExp objects may be created with the RegExp() constructor, of course, but they are more often created using a special literal syntax. Just as string literals are specified as characters within quotation marks, regular expression literals are specified as characters within a pair of slash (/) characters. Thus, your JavaScript code may contain lines like this:

var pattern = /s$/;

This line creates a new RegExp object and assigns it to the variable pattern. This particular RegExp object matches any string that ends with the letter「s.」This regular expression could have equivalently been defined with the RegExp() constructor like this:

var pattern = new RegExp("s$");

RegExp Literals and Object Creation

Literals of primitive type, like strings and numbers, evaluate (obviously) to the same value each time they are encountered in a program. Object literals (or initializers) such as {} and [] create a new object each time they are encountered. If you write var a = [] in the body of a loop, for example, each iteration of the loop will create a new empty array.

Regular expression literals are a special case. The ECMAScript 3 specification says that a RegExp literal is converted to a RegExp object when the code is parsed, and each evaluation of the code returns the same object. The ECMAScript 5 specification reverses this and requires that each evaluation of a RegExp return a new object. IE has always implemented the ECMAScript 5 behavior and most current browsers have now switched to it, even before they fully implement the standard.

Regular-expression pattern specifications consist of a series of characters. Most characters, including all alphanumeric characters, simply describe characters to be matched literally. Thus, the regular expression /java/ matches any string that contains the substring「java」. Other characters in regular expressions are not matched literally but have special significance. For example, the regular expression /s$/ contains two characters. The first,「s」, matches itself literally. The second,「$」, is a special metacharacter that matches the end of a string. Thus, this regular expression matches any string that contains the letter「s」as its last character.

The following sections describe the various characters and metacharacters used in JavaScript regular expressions.

Literal Characters

As noted earlier, all alphabetic characters and digits match themselves literally in regular expressions. JavaScript regular-expression syntax also supports certain nonalphabetic characters through escape sequences that begin with a backslash (\). For example, the sequence \n matches a literal newline character in a string. Table 10-1 lists these characters.

Table 10-1. Regular-expression literal characters

CharacterMatches

Alphanumeric character Itself

\0 The NUL character (\u0000)

\t Tab (\u0009)

\n Newline (\u000A)

\v Vertical tab (\u000B)

\f Form feed (\u000C)

\r Carriage return (\u000D)

\x nn The Latin character specified by the hexadecimal number nn; for example, \x0A is the same as \n

\u xxxx The Unicode character specified by the hexadecimal number xxxx; for example, \u0009 is the same as \t

\c X The control character ^ X; for example, \cJ is equivalent to the newline character \n

A number of punctuation characters have special meanings in regular expressions. They are:

^ $ . * + ? = ! : | \ / ( ) [ ] { }

The meanings of these characters are discussed in the sections that follow. Some of these characters have special meaning only within certain contexts of a regular expression and are treated literally in other contexts. As a general rule, however, if you want to include any of these punctuation characters literally in a regular expression, you must precede them with a \. Other punctuation characters, such as quotation marks and @, do not have special meaning and simply match themselves literally in a regular expression.

If you can’t remember exactly which punctuation characters need to be escaped with a backslash, you may safely place a backslash before any punctuation character. On the other hand, note that many letters and numbers have special meaning when preceded by a backslash, so any letters or numbers that you want to match literally should not be escaped with a backslash. To include a backslash character literally in a regular expression, you must escape it with a backslash, of course. For example, the following regular expression matches any string that includes a backslash: /\\/.

Character Classes

Individual literal characters can be combined into character classes by placing them within square brackets. A character class matches any one character that is contained within it. Thus, the regular expression /[abc]/ matches any one of the letters a, b, or c. Negated character classes can also be defined; these match any character except those contained within the brackets. A negated character class is specified by placing a caret (^) as the first character inside the left bracket. The regexp /[^abc]/ matches any one character other than a, b, or c. Character classes can use a hyphen to indicate a range of characters. To match any one lowercase character from the Latin alphabet, use /[a-z]/ and to match any letter or digit from the Latin alphabet, use /[a-zA-Z0-9]/.

Because certain character classes are commonly used, the JavaScript regular-expression syntax includes special characters and escape sequences to represent these common classes. For example, \s matches the space character, the tab character, and any other Unicode whitespace character; \S matches any character that is not Unicode whitespace. Table 10-2 lists these characters and summarizes character-class syntax. (Note that several of these character-class escape sequences match only ASCII characters and have not been extended to work with Unicode characters. You can, however, explicitly define your own Unicode character classes; for example, /[\u0400-\u04FF]/ matches any one Cyrillic character.)

Table 10-2. Regular expression character classes

CharacterMatches

[...] Any one character between the brackets.

[^...] Any one character not between the brackets.

. Any character except newline or another Unicode line terminator.

\w Any ASCII word character. Equivalent to [a-zA-Z0-9_].

\W Any character that is not an ASCII word character. Equivalent to [^a-zA-Z0-9_].

\s Any Unicode whitespace character.

\S Any character that is not Unicode whitespace. Note that \w and \S are not the same thing.

\d Any ASCII digit. Equivalent to [0-9].

\D Any character other than an ASCII digit. Equivalent to [^0-9].

[\b] A literal backspace (special case).

Note that the special character-class escapes can be used within square brackets. \s matches any whitespace character, and \d matches any digit, so /[\s\d]/ matches any one whitespace character or digit. Note that there is one special case. As you’ll see later, the \b escape has a special meaning. When used within a character class, however, it represents the backspace character. Thus, to represent a backspace character literally in a regular expression, use the character class with one element: /[\b]/.

Repetition

With the regular expression syntax you’ve learned so far, you can describe a two-digit number as /\d\d/ and a four-digit number as /\d\d\d\d/. But you don’t have any way to describe, for example, a number that can have any number of digits or a string of three letters followed by an optional digit. These more complex patterns use regular-expression syntax that specifies how many times an element of a regular expression may be repeated.

The characters that specify repetition always follow the pattern to which they are being applied. Because certain types of repetition are quite commonly used, there are special characters to represent these cases. For example, + matches one or more occurrences of the previous pattern. Table 10-3 summarizes the repetition syntax.

Table 10-3. Regular expression repetition characters

CharacterMeaning

{ n , m } Match the previous item at least n times but no more than m times.

{ n ,} Match the previous item n or more times.

{ n } Match exactly n occurrences of the previous item.

? Match zero or one occurrences of the previous item. That is, the previous item is optional. Equivalent to {0,1}.

+ Match one or more occurrences of the previous item. Equivalent to {1,}.

* Match zero or more occurrences of the previous item. Equivalent to {0,}.

The following lines show some examples:

/\d{2,4}/ // Match between two and four digits /\w{3}\d?/ // Match exactly three word characters and an optional digit /\s+java\s+/ // Match "java" with one or more spaces before and after /[^(]*/ // Match zero or more characters that are not open parenthesis

Be careful when using the * and ? repetition characters. Since these characters may match zero instances of whatever precedes them, they are allowed to match nothing. For example, the regular expression /a*/ actually matches the string「bbbb」because the string contains zero occurrences of the letter a!

Nongreedy repetition

The repetition characters listed in Table 10-3 match as many times as possible while still allowing any following parts of the regular expression to match. We say that this repetition is「greedy.」It is also possible to specify that repetition should be done in a nongreedy way. Simply follow the repetition character or characters with a question mark: ??, +?, *?, or even {1,5}?. For example, the regular expression /a+/ matches one or more occurrences of the letter a. When applied to the string「aaa」, it matches all three letters. But /a+?/ matches one or more occurrences of the letter a, matching as few characters as necessary. When applied to the same string, this pattern matches only the first letter a.

Using nongreedy repetition may not always produce the results you expect. Consider the pattern /a+b/, which matches one or more a’s, followed by the letter b. When applied to the string「aaab」, it matches the entire string. Now let’s use the nongreedy version: /a+?b/. This should match the letter b preceded by the fewest number of a’s possible. When applied to the same string「aaab」, you might expect it to match only one a and the last letter b. In fact, however, this pattern matches the entire string, just like the greedy version of the pattern. This is because regular-expression pattern matching is done by finding the first position in the string at which a match is possible. Since a match is possible starting at the first character of the string, shorter matches starting at subsequent characters are never even considered.

Alternation, Grouping, and References

The regular-expression grammar includes special characters for specifying alternatives, grouping subexpressions, and referring to previous subexpressions. The | character separates alternatives. For example, /ab|cd|ef/ matches the string「ab」or the string「cd」or the string「ef」. And /\d{3}|[a-z]{4}/ matches either three digits or four lowercase letters.

Note that alternatives are considered left to right until a match is found. If the left alternative matches, the right alternative is ignored, even if it would have produced a「better」match. Thus, when the pattern /a|ab/ is applied to the string「ab」, it matches only the first letter.

Parentheses have several purposes in regular expressions. One purpose is to group separate items into a single subexpression so that the items can be treated as a single unit by |, *, +, ?, and so on. For example, /java(script)?/ matches「java」followed by the optional「script」. And /(ab|cd)+|ef/ matches either the string「ef」or one or more repetitions of either of the strings「ab」or「cd」.

Another purpose of parentheses in regular expressions is to define subpatterns within the complete pattern. When a regular expression is successfully matched against a target string, it is possible to extract the portions of the target string that matched any particular parenthesized subpattern. (You’ll see how these matching substrings are obtained later in the chapter.) For example, suppose you are looking for one or more lowercase letters followed by one or more digits. You might use the pattern /[a-z]+\d+/. But suppose you only really care about the digits at the end of each match. If you put that part of the pattern in parentheses (/[a-z]+(\d+)/), you can extract the digits from any matches you find, as explained later.

A related use of parenthesized subexpressions is to allow you to refer back to a subexpression later in the same regular expression. This is done by following a \ character by a digit or digits. The digits refer to the position of the parenthesized subexpression within the regular expression. For example, \1 refers back to the first subexpression, and \3 refers to the third. Note that, because subexpressions can be nested within others, it is the position of the left parenthesis that is counted. In the following regular expression, for example, the nested subexpression ([Ss]cript) is referred to as \2:

/([Jj]ava([Ss]cript)?)\sis\s(fun\w*)/

A reference to a previous subexpression of a regular expression does not refer to the pattern for that subexpression but rather to the text that matched the pattern. Thus, references can be used to enforce a constraint that separate portions of a string contain exactly the same characters. For example, the following regular expression matches zero or more characters within single or double quotes. However, it does not require the opening and closing quotes to match (i.e., both single quotes or both double quotes):

/['"][^'"]*['"]/

To require the quotes to match, use a reference:

/(['"])[^'"]*\1/

The \1 matches whatever the first parenthesized subexpression matched. In this example, it enforces the constraint that the closing quote match the opening quote. This regular expression does not allow single quotes within double-quoted strings or vice versa. It is not legal to use a reference within a character class, so you cannot write:

/(['"])[^\1]*\1/

Later in this chapter, you’ll see that this kind of reference to a parenthesized subexpression is a powerful feature of regular-expression search-and-replace operations.

It is also possible to group items in a regular expression without creating a numbered reference to those items. Instead of simply grouping the items within ( and ), begin the group with (?: and end it with ). Consider the following pattern, for example:

/([Jj]ava(?:[Ss]cript)?)\sis\s(fun\w*)/

Here, the subexpression (?:[Ss]cript) is used simply for grouping, so the ? repetition character can be applied to the group. These modified parentheses do not produce a reference, so in this regular expression, \2 refers to the text matched by (fun\w*).

Table 10-4 summarizes the regular-expression alternation, grouping, and referencing operators.

Table 10-4. Regular expression alternation, grouping, and reference characters

CharacterMeaning

| Alternation. Match either the subexpression to the left or the subexpression to the right.

(...) Grouping. Group items into a single unit that can be used with *, +, ?, |, and so on. Also remember the characters that match this group for use with later references.

(?:...) Grouping only. Group items into a single unit, but do not remember the characters that match this group.

\ n Match the same characters that were matched when group number n was first matched. Groups are subexpressions within (possibly nested) parentheses. Group numbers are assigned by counting left parentheses from left to right. Groups formed with (?: are not numbered.

Specifying Match Position

As described earlier, many elements of a regular expression match a single character in a string. For example, \s matches a single character of whitespace. Other regular expression elements match the positions between characters, instead of actual characters. \b, for example, matches a word boundary—the boundary between a \w (ASCII word character) and a \W (nonword character), or the boundary between an ASCII word character and the beginning or end of a string.[18] Elements such as \b do not specify any characters to be used in a matched string; what they do specify, however, are legal positions at which a match can occur. Sometimes these elements are called regular-expression anchors because they anchor the pattern to a specific position in the search string. The most commonly used anchor elements are ^, which ties the pattern to the beginning of the string, and $, which anchors the pattern to the end of the string.

For example, to match the word「JavaScript」on a line by itself, you can use the regular expression /^JavaScript$/. If you want to search for「Java」as a word by itself (not as a prefix, as it is in「JavaScript」), you can try the pattern /\sJava\s/, which requires a space before and after the word. But there are two problems with this solution. First, it does not match「Java」at the beginning or the end of a string, but only if it appears with space on either side. Second, when this pattern does find a match, the matched string it returns has leading and trailing spaces, which is not quite what’s needed. So instead of matching actual space characters with \s, match (or anchor to) word boundaries with \b. The resulting expression is /\bJava\b/. The element \B anchors the match to a location that is not a word boundary. Thus, the pattern /\B[Ss]cript/ matches「JavaScript」and「postscript」, but not「script」or「Scripting」.

You can also use arbitrary regular expressions as anchor conditions. If you include an expression within (?= and ) characters, it is a lookahead assertion, and it specifies that the enclosed characters must match, without actually matching them. For example, to match the name of a common programming language, but only if it is followed by a colon, you could use /[Jj]ava([Ss]cript)?(?=\:)/. This pattern matches the word「JavaScript」in「JavaScript: The Definitive Guide」, but it does not match「Java」in「Java in a Nutshell」, because it is not followed by a colon.

If you instead introduce an assertion with (?!, it is a negative lookahead assertion, which specifies that the following characters must not match. For example, /Java(?!Script)([A-Z]\w*)/ matches「Java」followed by a capital letter and any number of additional ASCII word characters, as long as「Java」is not followed by「Script」. It matches「JavaBeans」but not「Javanese」, and it matches「JavaScrip」but not「JavaScript」or「JavaScripter」.

Table 10-5 summarizes regular-expression anchors.

Table 10-5. Regular-expression anchor characters

CharacterMeaning

^ Match the beginning of the string and, in multiline searches, the beginning of a line.

$ Match the end of the string and, in multiline searches, the end of a line.

\b Match a word boundary. That is, match the position between a \w character and a \W character or between a \w character and the beginning or end of a string. (Note, however, that [\b] matches backspace.)

\B Match a position that is not a word boundary.

(?= p ) A positive lookahead assertion. Require that the following characters match the pattern p, but do not include those characters in the match.

(?! p ) A negative lookahead assertion. Require that the following characters do not match the pattern p.

Flags

There is one final element of regular-expression grammar. Regular-expression flags specify high-level pattern-matching rules. Unlike the rest of regular-expression syntax, flags are specified outside the / characters; instead of appearing within the slashes, they appear following the second slash. JavaScript supports three flags. The i flag specifies that pattern matching should be case-insensitive. The g flag specifies that pattern matching should be global—that is, all matches within the searched string should be found. The m flag performs pattern matching in multiline mode. In this mode, if the string to be searched contains newlines, the ^ and $ anchors match the beginning and end of a line in addition to matching the beginning and end of a string. For example, the pattern /java$/im matches「java」as well as「Java\nis fun」.

These flags may be specified in any combination. For example, to do a case-insensitive search for the first occurrence of the word「java」(or「Java」,「JAVA」, etc.), you can use the case-insensitive regular expression /\bjava\b/i. And to find all occurrences of the word in a string, you can add the g flag: /\bjava\b/gi.

Table 10-6 summarizes these regular-expression flags. Note that you’ll see more about the g flag later in this chapter, when the String and RegExp methods are used to actually perform matches.

Table 10-6. Regular-expression flags

