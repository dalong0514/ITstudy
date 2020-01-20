NaN — the not-a-number property

Synopsis

NaN

Description

NaN is a global property that refers to the special numeric not-a-number value. The NaN property is not enumerated by for/in loops and cannot be deleted with the delete operator. Note that NaN is not a constant and can be set to any other value, something that you should take care not to do.

To determine if a value is not a number, use isNaN(), because NaN always compares as nonequal to any other value, including itself!

See Also

Infinity, isNaN(), Number.NaN

Name

Number — support for numbers

Inherits from

Object → Number

Constructor

new Number(value) Number(value)

Arguments

value

The numeric value of the Number object being created or a value to be converted to a number.

Returns

When Number() is used with the new operator as a constructor, it returns a newly constructed Number object. When Number() is invoked as a function without the new operator, it converts its argument to a primitive numeric value and returns that value (or NaN if the conversion failed).

Constants

Number.MAX_VALUE

The largest representable number.

Number.MIN_VALUE

The smallest representable number.

Number.NaN

Not-a-number value.

Number.NEGATIVE_INFINITY

Negative infinite value; returned on overflow.

Number.POSITIVE_INFINITY

Infinite value; returned on overflow.

Methods

toString()

Converts a number to a string using a specified radix (base).

toLocaleString()

Converts a number to a string using local number-formatting conventions.

toFixed()

Converts a number to a string that contains a specified number of digits after the decimal place.

toExponential()

Converts a number to a string using exponential notation with the specified number of digits after the decimal place.

toPrecision()

Converts a number to a string using the specified number of significant digits. Uses exponential or fixed-point notation depending on the size of the number and the number of significant digits specified.

valueOf()

Returns the primitive numeric value of a Number object.

Description

Numbers are a basic, primitive datatype in JavaScript. JavaScript also supports the Number object, which is a wrapper object around a primitive numeric value. JavaScript automatically converts between the primitive and object forms as necessary. You can explicitly create a Number object with the Number() constructor, although there is rarely any need to do so.

The Number() constructor can also be used without the new operator, as a conversion function. When invoked in this way, it attempts to convert its argument to a number and returns the primitive numeric value (or NaN) that results from the conversion.

The Number() constructor is also used as a placeholder for five useful numeric constants: the largest and smallest representable numbers, positive and negative infinity, and the special NaN value. Note that these values are properties of the Number() constructor function itself, not of individual number objects. For example, you can use the MAX_VALUE property as follows:

var biggest = Number.MAX_VALUE

but not like this:

var n = new Number(2); var biggest = n.MAX_VALUE

By contrast, the toString() and other methods of the Number object are methods of each Number object, not of the Number() constructor function. As noted earlier, JavaScript automatically converts from primitive numeric values to Number objects whenever necessary. This means that you can use the Number methods with primitive numeric values as well as with Number objects.

var value = 1234; var binary_value = n.toString(2);

See Also

Infinity, Math, NaN

Name

Number.MAX_VALUE — the maximum numeric value

Synopsis

Number.MAX_VALUE

Description

Number.MAX_VALUE is the largest number representable in JavaScript. Its value is approximately 1.79E+308.

Name

Number.MIN_VALUE — the minimum numeric value

Synopsis

Number.MIN_VALUE

Description

Number.MIN_VALUE is the smallest (closest to zero, not most negative) number representable in JavaScript. Its value is approximately 5E-324.

Name

Number.NaN — the special not-a-number value

Synopsis

Number.NaN

Description

Number.NaN is a special value that indicates that the result of some mathematical operation (such as taking the square root of a negative number) is not a number. parseInt() and parseFloat() return this value when they cannot parse the specified string, and you might use Number.NaN in a similar way to indicate an error condition for some function that normally returns a valid number.

JavaScript prints the Number.NaN value as NaN. Note that the NaN value always compares as unequal to any other number, including NaN itself. Thus, you cannot check for the not-a-number value by comparing to Number.NaN; use the isNaN() function instead. In ECMAScript v1 and later, you can also use the predefined global property NaN instead of Number.NaN.

See Also

isNaN(), NaN

Name

Number.NEGATIVE_INFINITY — negative infinity

Synopsis

Number.NEGATIVE_INFINITY

Description

Number.NEGATIVE_INFINITY is a special numeric value that is returned when an arithmetic operation or mathematical function generates a negative value greater than the largest representable number in JavaScript (i.e., more negative than -Number.MAX_VALUE).

JavaScript displays the NEGATIVE_INFINITY value as -Infinity. This value behaves mathematically like infinity; for example, anything multiplied by infinity is infinity, and anything divided by infinity is zero. In ECMAScript v1 and later, you can also use -Infinity instead of Number.NEGATIVE_INFINITY.

See Also

Infinity, isFinite()

Name

Number.POSITIVE_INFINITY — infinity

Synopsis

Number.POSITIVE_INFINITY

Description

Number.POSITIVE_INFINITY is a special numeric value returned when an arithmetic operation or mathematical function overflows or generates a value greater than the largest representable number in JavaScript (i.e., greater than Number.MAX_VALUE). Note that when numbers「underflow,」or become less than Number.MIN_VALUE, JavaScript converts them to zero.

JavaScript displays the POSITIVE_INFINITY value as Infinity. This value behaves mathematically like infinity; for example, anything multiplied by infinity is infinity, and anything divided by infinity is zero. In ECMAScript v1 and later, you can also use the predefined global property Infinity instead of Number.POSITIVE_INFINITY.

See Also

Infinity, isFinite()

Name

Number.toExponential() — format a number using exponential notation

Synopsis

number.toExponential(digits)

Arguments

digits

The number of digits that appears after the decimal point. This may be a value between 0 and 20, inclusive, and implementations may optionally support a larger range of values. If this argument is omitted, as many digits as necessary are used.

Returns

A string representation of number, in exponential notation, with one digit before the decimal place and digits digits after the decimal place. The fractional part of the number is rounded, or padded with zeros, as necessary, so that it has the specified length.

Throws

RangeError

If digits is too small or too large. Values between 0 and 20, inclusive, will not cause a RangeError. Implementations are allowed to support larger and smaller values as well.

TypeError

If this method is invoked on an object that is not a Number.

Example

var n = 12345.6789; n.toExponential(1); // Returns 1.2e+4 n.toExponential(5); // Returns 1.23457e+4 n.toExponential(10); // Returns 1.2345678900e+4 n.toExponential(); // Returns 1.23456789e+4

See Also

Number.toFixed(), Number.toLocaleString(), Number.toPrecision(), Number.toString()

Name

Number.toFixed() — format a number using fixed-point notation

Synopsis

number.toFixed(digits)

Arguments

digits

The number of digits to appear after the decimal point; this may be a value between 0 and 20, inclusive, and implementations may optionally support a larger range of values. If this argument is omitted, it is treated as 0.

Returns

A string representation of number that does not use exponential notation and has exactly digits digits after the decimal place. The number is rounded if necessary, and the fractional part is padded with zeros if necessary so that it has the specified length. If number is greater than 1e+21, this method simply calls Number.toString() and returns a string in exponential notation.

Throws

RangeError

If digits is too small or too large. Values between 0 and 20, inclusive, will not cause a RangeError. Implementations are allowed to support larger and smaller values as well.

TypeError

If this method is invoked on an object that is not a Number.

Example

var n = 12345.6789; n.toFixed(); // Returns 12346: note rounding, no fractional part n.toFixed(1); // Returns 12345.7: note rounding n.toFixed(6); // Returns 12345.678900: note added zeros (1.23e+20).toFixed(2); // Returns 123000000000000000000.00 (1.23e-10).toFixed(2) // Returns 0.00

See Also

Number.toExponential(), Number.toLocaleString(), Number.toPrecision(), Number.toString()

Name

Number.toLocaleString() — convert a number to a locally formatted string

Synopsis

number.toLocaleString()

Returns

An implementation-dependent string representation of the number, formatted according to local conventions, which may affect such things as the punctuation characters used for the decimal point and the thousands separator.

Throws

TypeError

If this method is invoked on an object that is not a Number.

See Also

Number.toExponential(), Number.toFixed(), Number.toPrecision(), Number.toString()

Name

Number.toPrecision() — format the significant digits of a number

Synopsis

number.toPrecision(precision)

Arguments

precision

The number of significant digits to appear in the returned string. This may be a value between 1 and 21, inclusive. Implementations are allowed to optionally support larger and smaller values of precision. If this argument is omitted, the toString() method is used instead to convert the number to a base-10 value.

Returns

A string representation of number that contains precision significant digits. If precision is large enough to include all the digits of the integer part of number, the returned string uses fixed-point notation. Otherwise, exponential notation is used with one digit before the decimal place and precision−1 digits after the decimal place. The number is rounded or padded with zeros as necessary.

Throws

RangeError

If digits is too small or too large. Values between 1 and 21, inclusive, will not cause a RangeError. Implementations are allowed to support larger and smaller values as well.

TypeError

If this method is invoked on an object that is not a Number.

Example

var n = 12345.6789; n.toPrecision(1); // Returns 1e+4 n.toPrecision(3); // Returns 1.23e+4 n.toPrecision(5); // Returns 12346: note rounding n.toPrecision(10); // Returns 12345.67890: note added zero

See Also

Number.toExponential(), Number.toFixed(), Number.toLocaleString(), Number.toString()

Name

Number.toString() — convert a number to a string

Inherits from

Overrides Object.toString()

Synopsis

number.toString(radix)

Arguments

radix

An optional argument that specifies the radix, or base, between 2 and 36, in which the number should be represented. If omitted, base 10 is used. Note, however, that the ECMAScript specification allows an implementation to return any value if this argument is specified as any value other than 10.

Returns

A string representation of the number, in the specified base.

Throws

TypeError

If this method is invoked on an object that is not a Number.

Description

The toString() method of the Number object converts a number to a string. When the radix argument is omitted or is specified as 10, the number is converted to a base-10 string. Although the ECMAScript specification does not require implementations to honor any other values for radix, all implementations in common use accept values between 2 and 36.

See Also

Number.toExponential(), Number.toFixed(), Number.toLocaleString(), Number.toPrecision()

Name

Number.valueOf() — return the primitive number value

Inherits from

Overrides Object.valueOf()

Synopsis

number.valueOf()

Returns

The primitive number value of this Number object. It is rarely necessary to call this method explicitly.

Throws

TypeError

If this method is invoked on an object that is not a Number.

See Also

Object.valueOf()

Name

Object — a superclass that contains features of all JavaScript objects

Constructor

new Object() new Object(value)

Arguments

value

This optional argument specifies a primitive JavaScript value—a number, boolean, or string—that is to be converted to a Number, Boolean, or String object.

Returns

If no value argument is passed, this constructor returns a newly created Object instance. If a primitive value argument is specified, the constructor creates and returns a Number, Boolean, or String object wrapper for the primitive value. When the Object() constructor is called as a function, without the new operator, it behaves just as it does when used with the new operator.

Properties

constructor

A reference to the JavaScript function that was the constructor for the object.

Methods

hasOwnProperty()

Checks whether an object has a locally defined (noninherited) property with a specified name.

isPrototypeOf()

Checks whether this object is the prototype object of a specified object.

propertyIsEnumerable()

Checks whether a named property exists and would be enumerated by a for/in loop.

toLocaleString()

Returns a localized string representation of the object. The default implementation of this method simply calls toString(), but subclasses may override it to provide localization.

toString()

Returns a string representation of the object. The implementation of this method provided by the Object class is quite generic and does not provide much useful information. Subclasses of Object typically override this method by defining their own toString() method, which produces more useful output.

valueOf()

Returns the primitive value of the object, if any. For objects of type Object, this method simply returns the object itself. Subclasses of Object, such as Number and Boolean, override this method to return the primitive value associated with the object.

Static Methods

In ECMAScript 5, the Object constructor serves as a namespace for the following global functions:

Object.create()

Create a new object with specified prototype and properties.

Object.defineProperties()

Create or configure one or more properties of a specified object.

Object.defineProperty()

Create or configure a property of a specified object.

Object.freeze()

Make the specified object immutable.

Object.getOwnPropertyDescriptor()

Query the attributes of the specified property of the specified object.

Object.getOwnPropertyNames()

Return an array of the names of all non-inherited properties of the specified object, including non-enumerable properties.

Object.getPrototypeOf()

Return the prototype of the specified object.

Object.isExtensible()

Determine whether new properties can be added to the specified object.

Object.isFrozen()

Determine whether the specified object is frozen.

Object.isSealed()

Determine whether the specified object is sealed.

Object.keys()

Return an array of the names of the non-inherited enumerable properties of the specified object.

Object.preventExtensions()

Prevent the future addition of properties to the specified object.

Object.seal()

Prevent the addition of new properties and the deletion of existing properties for the specified object.

Description

The Object class is a built-in datatype of the JavaScript language. It serves as the superclass for all other JavaScript objects; therefore, methods and behavior of the Object class are inherited by all other objects. The basic behavior of objects in JavaScript is explained in Chapter 6.

In addition to the Object() constructor shown above, objects can also be created and initialized using the Object literal syntax described in Creating Objects.

See Also

Array, Boolean, Function, Function.prototype, Number, String; Chapter 6

Name

Object.constructor — an object’s constructor function

Synopsis

object.constructor

Description

The constructor property of any object is a reference to the function that was used as the constructor for that object. For example, if you create an array a with the Array() constructor, a.constructor is an Array:

a = new Array(1,2,3); // Create an object a.constructor == Array // Evaluates to true

One common use of the constructor property is to determine the type of unknown objects. Given an unknown value, you can use the typeof operator to determine whether it is a primitive value or an object. If it is an object, you can use the constructor property to determine what type of object it is. For example, the following function determines whether a given value is an array:

function isArray(x) { return ((typeof x == "object") && (x.constructor == Array)); }

Note, however, that while this technique works for the objects built into core JavaScript, it is not guaranteed to work with host objects such as the Window object of client-side JavaScript. The default implementation of the Object.toString() method provides another way to determine the type of an unknown object.

See Also

Object.toString()

Name

Object.create() — create an object with specified prototype and properties

Availability

ECMAScript 5

Synopsis

Object.create(proto) Object.create(proto, descriptors)

Arguments

proto

The prototype of the newly-created object, or null.

descriptors

An optional object that maps property names to property descriptors.

Returns

A newly created object that inherits from proto and has the properties described by descriptors.

Throws

TypeError

If proto is not an object or null, or if descriptors is specified and causes Object.defineProperties() to throw a TypeError.

Description

Object.create() creates and returns a new object with proto as its prototype. This means that the new object inherits properties from proto.

If the optional descriptors argument is specified, Object.create() adds properties to the new object as if by calling Object.defineProperties(). That is the two-argument invocation Object.create(p,d) is equivalent to:

Object.defineProperties(Object.create(p), d);

See Object.defineProperties() for more on the descriptors argument, and see Object.getOwnPropertyDescriptor() for an explanation of property descriptor objects.

Note that this is not a method to be invoked on an object: it is a global function and you must pass an object to it.

Example

// Create an object that has own properties x and y and inherits property z var p = Object.create({z:0}, { x: { value: 1, writable: false, enumerable:true, configurable: true}, y: { value: 2, writable: false, enumerable:true, configurable: true}, });

See Also

Object.defineProperty(), Object.defineProperties(), Object.getOwnPropertyDescriptor(), Creating Objects, Property Attributes

Name

Object.defineProperties() — create or configure multiple object properties

Availability

ECMAScript 5

Synopsis

Object.defineProperties(o, descriptors)

Arguments

o

The object on which properties are to be created or configured.

descriptors

An object that maps property names to property descriptors.

Returns

The object o.

Throws

TypeError

If o is not an object, or if any of the specified properties cannot be created or configured. This function is not atomic: it may create or configure certain properties and then throw an error, before even attempting to create or configure other properties. See Property Attributes for a list of property configuration errors that can cause a TypeError.

Description

Object.defineProperties() creates or configures on the object o the properties named and described by descriptors. The names of the properties in descriptors are the names of the properties to be created or configured on o, and the values of those properties are the property descriptor objects that specify the attributes of the properties to be created or configured.

Object.defineProperties() works much like Object.defineProperty() does; see that function for more details. See Object.getOwnPropertyDescriptor() for more on property descriptor objects.

Example

// Add read-only properties x and y to a newly-created object var p = Object.defineProperties({}, { x: { value: 0, writable: false, enumerable:true, configurable: true}, y: { value: 1, writable: false, enumerable:true, configurable: true}, });

See Also

Object.create(), Object.defineProperty(), Object.getOwnPropertyDescriptor(), Property Attributes

Name

Object.defineProperty() — create or configure an object property

Availability

ECMAScript 5

Synopsis

Object.defineProperty(o, name, desc)

Arguments

o

The object on which a property is to be created or configured.

name

The name of the property to be created or configured.

desc

A property descriptor object that describes the new property or describes the changes to be made to an existing property.

Returns

The object o.

Throws

TypeError

If o is not an object, or if the property cannot be created (because o is not extensible) or configured (because it already exists and is non-configurable, for example). See Property Attributes for a list of property configuration errors that can cause this function to throw a TypeError.

Description

Object.defineProperty() creates or configures the property named name of the object o, using the property descriptor desc. See Object.getOwnPropertyDescriptor() for an explanation of property descriptor objects.

If o does not already have a property named name, then this function simply creates a new property with the attributes and value specified in desc. If any properties are missing from desc, then the corresponding attributes are set to false or null.

If name is the name of an existing property of o, then Object.defineProperty() configures that property by altering its value or attributes. In this case, desc only needs to contain the attributes to be changed: attributes not mentioned in desc will not be altered.

Note that this is not a method to be invoked on an object: it is a global function and you must pass an object to it.

Example

function constant(o, n, v) { // Define a constant o.n with value v Object.defineProperty(o, n, { value: v, writable: false enumerable: true, configurable:false}); }

See Also

Object.create(), Object.defineProperties(), Object.getOwnPropertyDescriptor(), Property Attributes

Name

Object.freeze() — make an object immutable

Availability

ECMAScript 5

Synopsis

Object.freeze(o)

Arguments

o

The object to be frozen

Returns

The now-frozen argument object o.

Description

Object.freeze() makes o non-extensible (see Object.preventExtensions()) and makes all of its own properties non-configurable, like Object.seal() does. In addition, however, it also makes all non-inherited data properties read-only. This means that new properties cannot be added to o and that existing properties cannot be set or deleted. Freezing an object is a permanent change: once frozen and object cannot be unfrozen.

Note that Object.freeze() only sets the writable attribute of data properties. Properties that have a setter function defined are not affected. Also note that Object.freeze() does not affect inherited properties.

Note that this is not a method to be invoked on an object: it is a global function and you must pass an object to it.

See Also

Object.defineProperty(), Object.isFrozen(), Object.preventExtensions(), Object.seal(), The extensible Attribute

Name

Object.getOwnPropertyDescriptor() — query property attributes

Availability

ECMAScript 5

Synopsis

Object.getOwnPropertyDescriptor(o, name)

Arguments

o

The object that is to have its property attributes queried.

name

The name of the property (or index of the array element) to query.

Returns

A property descriptor object for the specified property of the specified object, or undefined if no such property exists.

Description

Object.getOwnPropertyDescriptor() returns a property descriptor for the specified property of the specified object. A property descriptor is an object that describes the attributes and value of a property. See the sub-section below for complete details. Note that this is not a method to be invoked on an object: it is a global function and you must pass an object to it.

Property Descriptors

A property descriptor is an ordinary JavaScript object that describes the attributes (and sometimes the value) of a property. There are two kinds of JavaScript properties. A data property has a value and three attributes: enumerable, writable, and configurable. An accessor property has a getter and/or a setter method as well as enumerable and configurable attributes.

The descriptor for a data property looks like this:

{ value: /* any JavaScript value */, writable: /* true or false */, enumerable: /* true or false */, configurable: /* true or false */ }

The descriptor for an accessor property looks like this:

{ get: /* function or undefined: replaces the property value */, set: /* function or undefined: replaces the writable attribute */, enumerable: /* true or false */, configurable: /* true or false */ }

See Also

Object.defineProperty(), Property Attributes

Name

Object.getOwnPropertyNames() — return the names of non-inherited properties

Availability

ECMAScript 5

Synopsis

Object.getOwnPropertyNames(o)

Arguments

o

An object

Returns

An array that contains the names of all non-inherited properties of o, including non-enumerable properties.

Description

Object.getOwnPropertyNames() returns an array that contains the names of all non-inherited properties of o, including non-enumerable properties. See Object.keys() for a function that returns only the names of enumerable properties.

Note that this is not a method to be invoked on an object: it is a global function and you must pass an object to it.

Example

Object.getOwnPropertyNames([]) // => ["length"]: "length" is non-enumerable

See Also

Object.keys(), Enumerating Properties

Name

Object.getPrototypeOf() — return the prototype of an object

Availability

ECMAScript 5

Synopsis

