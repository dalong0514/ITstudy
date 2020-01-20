Number

Boolean

Object

undefined

"undefined"

NaN

false

throws TypeError

null

"null"

0

false

throws TypeError

true

"true"

1

new Boolean(true)

false

"false"

0

new Boolean(false)

"" (empty string)

0

false

new String("")

"1.2" (nonempty, numeric)

1.2

true

new String("1.2")

"one" (nonempty, non-numeric)

NaN

true

new String("one")

0

"0"

false

new Number(0)

-0

"0"

false

new Number(-0)

NaN

"NaN"

false

new Number(NaN)

Infinity

"Infinity"

true

new Number(Infinity)

-Infinity

"-Infinity"

true

new Number(-Infinity)

1 (finite, non-zero)

"1"

true

new Number(1)

{} (any object)

see Object to Primitive Conversions

see Object to Primitive Conversions

true

[] (empty array)

""

0

true

[9] (1 numeric elt)

"9"

9

true

['a'] (any other array)

use join() method

NaN

true

function(){} (any function)

see Object to Primitive Conversions

NaN

true

The primitive-to-primitive conversions shown in the table are relatively straightforward. Conversion to boolean was already discussed in Boolean Values. Conversion to strings is well-defined for all primitive values. Conversion to numbers is just a little trickier. Strings that can be parsed as numbers convert to those numbers. Leading and trailing spaces are allowed, but any leading or trailing nonspace characters that are not part of a numeric literal cause the string-to-number conversion to produce NaN. Some numeric conversions may seem surprising: true converts to 1, and false and the empty string "" convert to 0.

Primitive-to-object conversions are straightforward: primitive values convert to their wrapper object (Wrapper Objects) as if by calling the String(), Number(), or Boolean() constructor. The exceptions are null and undefined: any attempt to use these values where an object is expected raises a TypeError exception rather than performing a conversion.

Object-to-primitive conversion is somewhat more complicated, and it is the subject of Object to Primitive Conversions.

Conversions and Equality

Because JavaScript can convert values flexibly, its == equality operator is also flexible with its notion of equality. All of the following comparisons are true, for example:

null == undefined // These two values are treated as equal. "0" == 0 // String converts to a number before comparing. 0 == false // Boolean converts to number before comparing. "0" == false // Both operands convert to numbers before comparing.

Equality and Inequality Operators explains exactly what conversions are performed by the == operator in order to determine whether two values should be considered equal, and it also describes the strict equality operator === that does not perform conversions when testing for equality.

Keep in mind that convertibility of one value to another does not imply equality of those two values. If undefined is used where a boolean value is expected, for example, it will convert to false. But this does not mean that undefined == false. JavaScript operators and statements expect values of various types, and perform conversions to those types. The if statement converts undefined to false, but the == operator never attempts to convert its operands to booleans.

Explicit Conversions

Although JavaScript performs many type conversions automatically, you may sometimes need to perform an explicit conversion, or you may prefer to make the conversions explicit to keep your code clearer.

The simplest way to perform an explicit type conversion is to use the Boolean(), Number(), String(), or Object() functions. We’ve already seen these functions as constructors for wrapper objects (in Wrapper Objects). When invoked without the new operator, however, they work as conversion functions and perform the conversions summarized in Table 3-2:

Number("3") // => 3 String(false) // => "false" Or use false.toString() Boolean([]) // => true Object(3) // => new Number(3)

Note that any value other than null or undefined has a toString() method and the result of this method is usually the same as that returned by the String() function. Also note that Table 3-2 shows a TypeError if you attempt to convert null or undefined to an object. The Object() function does not throw an exception in this case: instead it simply returns a newly created empty object.

Certain JavaScript operators perform implicit type conversions, and are sometimes used for the purposes of type conversion. If one operand of the + operator is a string, it converts the other one to a string. The unary + operator converts its operand to a number. And the unary ! operator converts its operand to a boolean and negates it. These facts lead to the following type conversion idioms that you may see in some code:

x + "" // Same as String(x) +x // Same as Number(x). You may also see x-0 !!x // Same as Boolean(x). Note double !

Formatting and parsing numbers are common tasks in computer programs and JavaScript has specialized functions and methods that provide more precise control over number-to-string and string-to-number conversions.

The toString() method defined by the Number class accepts an optional argument that specifies a radix, or base, for the conversion. If you do not specify the argument, the conversion is done in base 10. However, you can also convert numbers in other bases (between 2 and 36). For example:

var n = 17; binary_string = n.toString(2); // Evaluates to "10001" octal_string = "0" + n.toString(8); // Evaluates to "021" hex_string = "0x" + n.toString(16); // Evaluates to "0x11"

When working with financial or scientific data, you may want to convert numbers to strings in ways that give you control over the number of decimal places or the number of significant digits in the output, or you may want to control whether exponential notation is used. The Number class defines three methods for these kinds of number-to-string conversions. toFixed() converts a number to a string with a specified number of digits after the decimal point. It never uses exponential notation. toExponential() converts a number to a string using exponential notation, with one digit before the decimal point and a specified number of digits after the decimal point (which means that the number of significant digits is one larger than the value you specify). toPrecision() converts a number to a string with the number of significant digits you specify. It uses exponential notation if the number of significant digits is not large enough to display the entire integer portion of the number. Note that all three methods round the trailing digits or pad with zeros as appropriate. Consider the following examples:

var n = 123456.789; n.toFixed(0); // "123457" n.toFixed(2); // "123456.79" n.toFixed(5); // "123456.78900" n.toExponential(1); // "1.2e+5" n.toExponential(3); // "1.235e+5" n.toPrecision(4); // "1.235e+5" n.toPrecision(7); // "123456.8" n.toPrecision(10); // "123456.7890"

If you pass a string to the Number() conversion function, it attempts to parse that string as an integer or floating-point literal. That function only works for base-10 integers, and does not allow trailing characters that are not part of the literal. The parseInt() and parseFloat() functions (these are global functions, not methods of any class) are more flexible. parseInt() parses only integers, while parseFloat() parses both integers and floating-point numbers. If a string begins with「0x」or「0X」, parseInt() interprets it as a hexadecimal number.[2] Both parseInt() and parseFloat() skip leading whitespace, parse as many numeric characters as they can, and ignore anything that follows. If the first nonspace character is not part of a valid numeric literal, they return NaN:

parseInt("3 blind mice") // => 3 parseFloat(" 3.14 meters") // => 3.14 parseInt("-12.34") // => -12 parseInt("0xFF") // => 255 parseInt("0xff") // => 255 parseInt("-0XFF") // => -255 parseFloat(".1") // => 0.1 parseInt("0.1") // => 0 parseInt(".1") // => NaN: integers can't start with "." parseFloat("$72.47"); // => NaN: numbers can't start with "$"

parseInt() accepts an optional second argument specifying the radix (base) of the number to be parsed. Legal values are between 2 and 36. For example:

parseInt("11", 2); // => 3 (1*2 + 1) parseInt("ff", 16); // => 255 (15*16 + 15) parseInt("zz", 36); // => 1295 (35*36 + 35) parseInt("077", 8); // => 63 (7*8 + 7) parseInt("077", 10); // => 77 (7*10 + 7)

Object to Primitive Conversions

Object-to-boolean conversions are trivial: all objects (including arrays and functions) convert to true. This is so even for wrapper objects: new Boolean(false) is an object rather than a primitive value, and so it converts to true.

Object-to-string and object-to-number conversions are performed by invoking a method of the object to be converted. This is complicated by the fact that JavaScript objects have two different methods that perform conversions, and it is also complicated by some special cases described below. Note that the string and number conversion rules described here apply only to native objects. Host objects (defined by web browsers, for example) can convert to numbers and strings according to their own algorithms.

All objects inherit two conversion methods. The first is called toString(), and its job is to return a string representation of the object. The default toString() method does not return a very interesting value (though we’ll find it useful in Example 6-4):

({x:1, y:2}).toString() // => "[object Object]"

Many classes define more specific versions of the toString() method. The toString() method of the Array class, for example, converts each array element to a string and joins the resulting strings together with commas in between. The toString() method of the Function class returns an implementation-defined representation of a function. In practice, implementations usually convert user-defined functions to strings of JavaScript source code. The Date class defines a toString() method that returns a human-readable (and JavaScript-parsable) date and time string. The RegExp class defines a toString() method that converts RegExp objects to a string that looks like a RegExp literal:

[1,2,3].toString() // => "1,2,3" (function(x) { f(x); }).toString() // => "function(x) {\n f(x);\n}" /\d+/g.toString() // => "/\\d+/g" new Date(2010,0,1).toString() // => "Fri Jan 01 2010 00:00:00 GMT-0800 (PST)"

The other object conversion function is called valueOf(). The job of this method is less well-defined: it is supposed to convert an object to a primitive value that represents the object, if any such primitive value exists. Objects are compound values, and most objects cannot really be represented by a single primitive value, so the default valueOf() method simply returns the object itself rather than returning a primitive. Wrapper classes define valueOf() methods that return the wrapped primitive value. Arrays, functions, and regular expressions simply inherit the default method. Calling valueOf() for instances of these types simply returns the object itself. The Date class defines a valueOf() method that returns the date in its internal representation: the number of milliseconds since January 1, 1970:

var d = new Date(2010, 0, 1); // January 1st, 2010, (Pacific time) d.valueOf() // => 1262332800000

With the toString() and valueOf() methods explained, we can now cover object-to-string and object-to-number conversions. Do note, however, that there are some special cases in which JavaScript performs a different object-to-primitive conversion. These special cases are covered at the end of this section.

To convert an object to a string, JavaScript takes these steps:

If the object has a toString() method, JavaScript calls it. If it returns a primitive value, JavaScript converts that value to a string (if it is not already a string) and returns the result of that conversion. Note that primitive-to-string conversions are all well-defined in Table 3-2.

If the object has no toString() method, or if that method does not return a primitive value, then JavaScript looks for a valueOf() method. If the method exists, JavaScript calls it. If the return value is a primitive, JavaScript converts that value to a string (if it is not already) and returns the converted value.

Otherwise, JavaScript cannot obtain a primitive value from either toString() or valueOf(), so it throws a TypeError.

To convert an object to a number, JavaScript does the same thing, but it tries the valueOf() method first:

If the object has a valueOf() method that returns a primitive value, JavaScript converts (if necessary) that primitive value to a number and returns the result.

Otherwise, if the object has a toString() method that returns a primitive value, JavaScript converts and returns the value.

Otherwise, JavaScript throws a TypeError.

The details of this object-to-number conversion explain why an empty array converts to the number 0 and why an array with a single element may also convert to a number. Arrays inherit the default valueOf() method that returns an object rather than a primitive value, so array-to-number conversion relies on the toString() method. Empty arrays convert to the empty string. And the empty string converts to the number 0. An array with a single element converts to the same string that that one element does. If an array contains a single number, that number is converted to a string, and then back to a number.

The + operator in JavaScript performs numeric addition and string concatenation. If either of its operands is an object, JavaScript converts the object using a special object-to-primitive conversion rather than the object-to-number conversion used by the other arithmetic operators. The == equality operator is similar. If asked to compare an object with a primitive value, it converts the object using the object-to-primitive conversion.

The object-to-primitive conversion used by + and == includes a special case for Date objects. The Date class is the only predefined core JavaScript type that defines meaningful conversions to both strings and numbers. The object-to-primitive conversion is basically an object-to-number conversion (valueof() first) for all objects that are not dates, and an object-to-string conversion (toString() first) for Date objects. The conversion is not exactly the same as those explained above, however: the primitive value returned by valueOf() or toString() is used directly without being forced to a number or string.

The < operator and the other relational operators perform object-to-primitive conversions like == does, but without the special case for Date objects: any object is converted by trying valueOf() first and then toString(). Whatever primitive value is obtained is used directly, without being further converted to a number or string.

+, ==, != and the relational operators are the only ones that perform this special kind of string-to-primitive conversions. Other operators convert more explicitly to a specified type and do not have any special case for Date objects. The - operator, for example, converts its operands to numbers. The following code demonstrates the behavior of +, -, ==, and > with Date objects:

var now = new Date(); // Create a Date object typeof (now + 1) // => "string": + converts dates to strings typeof (now - 1) // => "number": - uses object-to-number conversion now == now.toString() // => true: implicit and explicit string conversions now > (now -1) // => true: > converts a Date to a number

* * *

[2] In ECMAScript 3, parseInt() may parse a string that begins with「0」(but not「0x」or「0X」) as an octal number or as a decimal number. Because the behavior is unspecified, you should never use parseInt() to parse numbers with leading zeros, unless you explicitly specify the radix to be used! In ECMAScript 5, parseInt() only parses octal numbers if you explicitly pass 8 as the second argument.

Variable Declaration

Before you use a variable in a JavaScript program, you should declare it. Variables are declared with the var keyword, like this:

var i; var sum;

You can also declare multiple variables with the same var keyword:

var i, sum;

And you can combine variable declaration with variable initialization:

var message = "hello"; var i = 0, j = 0, k = 0;

If you don’t specify an initial value for a variable with the var statement, the variable is declared, but its value is undefined until your code stores a value into it.

Note that the var statement can also appear as part of the for and for/in loops (introduced in Chapter 5), allowing you to succinctly declare the loop variable as part of the loop syntax itself. For example:

for(var i = 0; i < 10; i++) console.log(i); for(var i = 0, j=10; i < 10; i++,j--) console.log(i*j); for(var p in o) console.log(p);

If you’re used to statically typed languages such as C or Java, you will have noticed that there is no type associated with JavaScript’s variable declarations. A JavaScript variable can hold a value of any type. For example, it is perfectly legal in JavaScript to assign a number to a variable and then later assign a string to that variable:

var i = 10; i = "ten";

Repeated and Omitted Declarations

It is legal and harmless to declare a variable more than once with the var statement. If the repeated declaration has an initializer, it acts as if it were simply an assignment statement.

If you attempt to read the value of an undeclared variable, JavaScript generates an error. In ECMAScript 5 strict mode (「use strict」), it is also an error to assign a value to an undeclared variable. Historically, however, and in non-strict mode, if you assign a value to an undeclared variable, JavaScript actually creates that variable as a property of the global object, and it works much like (but not exactly the same as, see Variables As Properties) a properly declared global variable. This means that you can get away with leaving your global variables undeclared. This is a bad habit and a source of bugs, however, and you should always declare your variables with var.

Variable Scope

The scope of a variable is the region of your program source code in which it is defined. A global variable has global scope; it is defined everywhere in your JavaScript code. On the other hand, variables declared within a function are defined only within the body of the function. They are local variables and have local scope. Function parameters also count as local variables and are defined only within the body of the function.

Within the body of a function, a local variable takes precedence over a global variable with the same name. If you declare a local variable or function parameter with the same name as a global variable, you effectively hide the global variable:

var scope = "global"; // Declare a global variable function checkscope() { var scope = "local"; // Declare a local variable with the same name return scope; // Return the local value, not the global one } checkscope() // => "local"

Although you can get away with not using the var statement when you write code in the global scope, you must always use var to declare local variables. Consider what happens if you don’t:

scope = "global"; // Declare a global variable, even without var. function checkscope2() { scope = "local"; // Oops! We just changed the global variable. myscope = "local"; // This implicitly declares a new global variable. return [scope, myscope]; // Return two values. } checkscope2() // => ["local", "local"]: has side effects! scope // => "local": global variable has changed. myscope // => "local": global namespace cluttered up.

Function definitions can be nested. Each function has its own local scope, so it is possible to have several nested layers of local scope. For example:

var scope = "global scope"; // A global variable function checkscope() { var scope = "local scope"; // A local variable function nested() { var scope = "nested scope"; // A nested scope of local variables return scope; // Return the value in scope here } return nested(); } checkscope() // => "nested scope"

Function Scope and Hoisting

In some C-like programming languages, each block of code within curly braces has its own scope, and variables are not visible outside of the block in which they are declared. This is called block scope, and JavaScript does not have it. Instead, JavaScript uses function scope: variables are visible within the function in which they are defined and within any functions that are nested within that function.

In the following code, the variables i, j, and k are declared in different spots, but all have the same scope—all three are defined throughout the body of the function:

function test(o) { var i = 0; // i is defined throughout function if (typeof o == "object") { var j = 0; // j is defined everywhere, not just block for(var k=0; k < 10; k++) { // k is defined everywhere, not just loop console.log(k); // print numbers 0 through 9 } console.log(k); // k is still defined: prints 10 } console.log(j); // j is defined, but may not be initialized }

JavaScript’s function scope means that all variables declared within a function are visible throughout the body of the function. Curiously, this means that variables are even visible before they are declared. This feature of JavaScript is informally known as hoisting: JavaScript code behaves as if all variable declarations in a function (but not any associated assignments) are「hoisted」to the top of the function. Consider the following code:

var scope = "global"; function f() { console.log(scope); // Prints "undefined", not "global" var scope = "local"; // Variable initialized here, but defined everywhere console.log(scope); // Prints "local" }

You might think that the first line of the function would print「global」, because the var statement declaring the local variable has not yet been executed. Because of the rules of function scope, however, this is not what happens. The local variable is defined throughout the body of the function, which means the global variable by the same name is hidden throughout the function. Although the local variable is defined throughout, it is not actually initialized until the var statement is executed. Thus, the function above is equivalent to the following, in which the variable declaration is「hoisted」to the top and the variable initialization is left where it is:

function f() { var scope; // Local variable is declared at the top of the function console.log(scope); // It exists here, but still has "undefined" value scope = "local"; // Now we initialize it and give it a value console.log(scope); // And here it has the value we expect }

In programming languages with block scope, it is generally good programming practice to declare variables as close as possible to where they are used and with the narrowest possible scope. Since JavaScript does not have block scope, some programmers make a point of declaring all their variables at the top of the function, rather than trying to declare them closer to the point at which they are used. This technique makes their source code accurately reflect the true scope of the variables.

Variables As Properties

When you declare a global JavaScript variable, what you are actually doing is defining a property of the global object (The Global Object). If you use var to declare the variable, the property that is created is nonconfigurable (see Property Attributes), which means that it cannot be deleted with the delete operator. We’ve already noted that if you’re not using strict mode and you assign a value to an undeclared variable, JavaScript automatically creates a global variable for you. Variables created in this way are regular, configurable properties of the global object and they can be deleted:

var truevar = 1; // A properly declared global variable, nondeletable. fakevar = 2; // Creates a deletable property of the global object. this.fakevar2 = 3; // This does the same thing. delete truevar // => false: variable not deleted delete fakevar // => true: variable deleted delete this.fakevar2 // => true: variable deleted

JavaScript global variables are properties of the global object, and this is mandated by the ECMAScript specification. There is no such requirement for local variables, but you can imagine local variables as the properties of an object associated with each function invocation. The ECMAScript 3 specification referred to this object as the「call object,」and the ECMAScript 5 specification calls it a「declarative environment record.」JavaScript allows us to refer to the global object with the this keyword, but it does not give us any way to refer to the object in which local variables are stored. The precise nature of these objects that hold local variables is an implementation detail that need not concern us. The notion that these local variable objects exist, however, is an important one, and it is developed further in the next section.

The Scope Chain

JavaScript is a lexically scoped language: the scope of a variable can be thought of as the set of source code lines for which the variable is defined. Global variables are defined throughout the program. Local variables are defined throughout the function in which they are declared, and also within any functions nested within that function.

If we think of local variables as properties of some kind of implementation-defined object, then there is another way to think about variable scope. Every chunk of JavaScript code (global code or functions) has a scope chain associated with it. This scope chain is a list or chain of objects that defines the variables that are「in scope」for that code. When JavaScript needs to look up the value of a variable x (a process called variable resolution), it starts by looking at the first object in the chain. If that object has a property named x, the value of that property is used. If the first object does not have a property named x, JavaScript continues the search with the next object in the chain. If the second object does not have a property named x, the search moves on to the next object, and so on. If x is not a property of any of the objects in the scope chain, then x is not in scope for that code, and a ReferenceError occurs.

In top-level JavaScript code (i.e., code not contained within any function definitions), the scope chain consists of a single object, the global object. In a non-nested function, the scope chain consists of two objects. The first is the object that defines the function’s parameters and local variables, and the second is the global object. In a nested function, the scope chain has three or more objects. It is important to understand how this chain of objects is created. When a function is defined, it stores the scope chain then in effect. When that function is invoked, it creates a new object to store its local variables, and adds that new object to the stored scope chain to create a new, longer, chain that represents the scope for that function invocation. This becomes more interesting for nested functions because each time the outer function is called, the inner function is defined again. Since the scope chain differs on each invocation of the outer function, the inner function will be subtly different each time it is defined—the code of the inner function will be identical on each invocation of the outer function, but the scope chain associated with that code will be different.

This notion of a scope chain is helpful for understanding the with statement (with) and is crucial for understanding closures (Closures).

Chapter 4. Expressions and Operators

An expression is a phrase of JavaScript that a JavaScript interpreter can evaluate to produce a value. A constant embedded literally in your program is a very simple kind of expression. A variable name is also a simple expression that evaluates to whatever value has been assigned to that variable. Complex expressions are built from simpler expressions. An array access expression, for example, consists of one expression that evaluates to an array followed by an open square bracket, an expression that evaluates to an integer, and a close square bracket. This new, more complex expression evaluates to the value stored at the specified index of the specified array. Similarly, a function invocation expression consists of one expression that evaluates to a function object and zero or more additional expressions that are used as the arguments to the function.

The most common way to build a complex expression out of simpler expressions is with an operator. An operator combines the values of its operands (usually two of them) in some way and evaluates to a new value. The multiplication operator * is a simple example. The expression x * y evaluates to the product of the values of the expressions x and y. For simplicity, we sometimes say that an operator returns a value rather than「evaluates to」a value.

This chapter documents all of JavaScript’s operators, and it also explains expressions (such as array indexing and function invocation) that do not use operators. If you already know another programming language that uses C-style syntax, you’ll find that the syntax of most of JavaScript’s expressions and operators is already familiar to you.

Primary Expressions

The simplest expressions, known as primary expressions, are those that stand alone—they do not include any simpler expressions. Primary expressions in JavaScript are constant or literal values, certain language keywords, and variable references.

Literals are constant values that are embedded directly in your program. They look like these:

1.23 // A number literal "hello" // A string literal /pattern/ // A regular expression literal

JavaScript syntax for number literals was covered in Numbers. String literals were documented in Text. The regular expression literal syntax was introduced in Pattern Matching and will be documented in detail in Chapter 10.

Some of JavaScript’s reserved words are primary expressions:

true // Evalutes to the boolean true value false // Evaluates to the boolean false value null // Evaluates to the null value this // Evaluates to the "current" object

We learned about true, false, and null in Boolean Values and null and undefined. Unlike the other keywords, this is not a constant—it evaluates to different values in different places in the program. The this keyword is used in object-oriented programming. Within the body of a method, this evaluates to the object on which the method was invoked. See Invocation Expressions, Chapter 8 (especially Method Invocation), and Chapter 9 for more on this.

Finally, the third type of primary expression is the bare variable reference:

i // Evaluates to the value of the variable i. sum // Evaluates to the value of the variable sum. undefined // undefined is a global variable, not a keyword like null.

When any identifier appears by itself in a program, JavaScript assumes it is a variable and looks up its value. If no variable with that name exists, the expression evaluates to the undefined value. In the strict mode of ECMAScript 5, however, an attempt to evaluate a nonexistent variable throws a ReferenceError instead.

Object and Array Initializers

Object and array initializers are expressions whose value is a newly created object or array. These initializer expressions are sometimes called「object literals」and「array literals.」Unlike true literals, however, they are not primary expressions, because they include a number of subexpressions that specify property and element values. Array initializers have a slightly simpler syntax, and we’ll begin with those.

An array initializer is a comma-separated list of expressions contained within square brackets. The value of an array initializer is a newly created array. The elements of this new array are initialized to the values of the comma-separated expressions:

[] // An empty array: no expressions inside brackets means no elements [1+2,3+4] // A 2-element array. First element is 3, second is 7

The element expressions in an array initializer can themselves be array initializers, which means that these expressions can create nested arrays:

var matrix = [[1,2,3], [4,5,6], [7,8,9]];

The element expressions in an array initializer are evaluated each time the array initializer is evaluated. This means that the value of an array initializer expression may be different each time it is evaluated.

Undefined elements can be included in an array literal by simply omitting a value between commas. For example, the following array contains five elements, including three undefined elements:

var sparseArray = [1,,,,5];

A single trailing comma is allowed after the last expression in an array initializer and does not create an undefined element.

Object initializer expressions are like array initializer expressions, but the square brackets are replaced by curly brackets, and each subexpression is prefixed with a property name and a colon:

var p = { x:2.3, y:-1.2 }; // An object with 2 properties var q = {}; // An empty object with no properties q.x = 2.3; q.y = -1.2; // Now q has the same properties as p

Object literals can be nested. For example:

var rectangle = { upperLeft: { x: 2, y: 2 }, lowerRight: { x: 4, y: 5 } };

The expressions in an object initializer are evaluated each time the object initializer is evaluated, and they need not have constant values: they can be arbitrary JavaScript expressions. Also, the property names in object literals may be strings rather than identifiers (this is useful to specify property names that are reserved words or are otherwise not legal identifiers):

var side = 1; var square = { "upperLeft": { x: p.x, y: p.y }, 'lowerRight': { x: p.x + side, y: p.y + side}};

We’ll see object and array initializers again in Chapters 6 and 7.

Function Definition Expressions

A function definition expression defines a JavaScript function, and the value of such an expression is the newly defined function. In a sense, a function definition expression is a「function literal」in the same way that an object initializer is an「object literal.」A function definition expression typically consists of the keyword function followed by a comma-separated list of zero or more identifiers (the parameter names) in parentheses and a block of JavaScript code (the function body) in curly braces. For example:

// This function returns the square of the value passed to it. var square = function(x) { return x * x; }

A function definition expression can also include a name for the function. Functions can also be defined using a function statement rather than a function expression. Complete details on function definition are in Chapter 8.

Property Access Expressions

A property access expression evaluates to the value of an object property or an array element. JavaScript defines two syntaxes for property access:

expression . identifier expression [ expression ]

The first style of property access is an expression followed by a period and an identifier. The expression specifies the object, and the identifier specifies the name of the desired property. The second style of property access follows the first expression (the object or array) with another expression in square brackets. This second expression specifies the name of the desired property of the index of the desired array element. Here are some concrete examples:

var o = {x:1,y:{z:3}}; // An example object var a = [o,4,[5,6]]; // An example array that contains the object o.x // => 1: property x of expression o o.y.z // => 3: property z of expression o.y o["x"] // => 1: property x of object o a[1] // => 4: element at index 1 of expression a a[2]["1"] // => 6: element at index 1 of expression a[2] a[0].x // => 1: property x of expression a[0]

With either type of property access expression, the expression before the . or [ is first evaluated. If the value is null or undefined, the expression throws a TypeError, since these are the two JavaScript values that cannot have properties. If the value is not an object (or array), it is converted to one (see Wrapper Objects). If the object expression is followed by a dot and an identifier, the value of the property named by that identifier is looked up and becomes the overall value of the expression. If the object expression is followed by another expression in square brackets, that second expression is evaluated and converted to a string. The overall value of the expression is then the value of the property named by that string. In either case, if the named property does not exist, then the value of the property access expression is undefined.

The .identifier syntax is the simpler of the two property access options, but notice that it can only be used when the property you want to access has a name that is a legal identifier, and when you know then name when you write the program. If the property name is a reserved word or includes spaces or punctuation characters, or when it is a number (for arrays), you must use the square bracket notation. Square brackets are also used when the property name is not static but is itself the result of a computation (see Objects As Associative Arrays for an example).

Objects and their properties are covered in detail in Chapter 6, and arrays and their elements are covered in Chapter 7.

Invocation Expressions

An invocation expression is JavaScript’s syntax for calling (or executing) a function or method. It starts with a function expression that identifies the function to be called. The function expression is followed by an open parenthesis, a comma-separated list of zero or more argument expressions, and a close parenthesis. Some examples:

f(0) // f is the function expression; 0 is the argument expression. Math.max(x,y,z) // Math.max is the function; x, y and z are the arguments. a.sort() // a.sort is the function; there are no arguments.

When an invocation expression is evaluated, the function expression is evaluated first, and then the argument expressions are evaluated to produce a list of argument values. If the value of the function expression is not a callable object, a TypeError is thrown. (All functions are callable. Host objects may also be callable even if they are not functions. This distinction is explored in Callable Objects.) Next, the argument values are assigned, in order, to the parameter names specified when the function was defined, and then the body of the function is executed. If the function uses a return statement to return a value, then that value becomes the value of the invocation expression. Otherwise, the value of the invocation expression is undefined. Complete details on function invocation, including an explanation of what happens when the number of argument expressions does not match the number of parameters in the function definition, are in Chapter 8 .

Every invocation expression includes a pair of parentheses and an expression before the open parenthesis. If that expression is a property access expression, then the invocation is known as a method invocation. In method invocations, the object or array that is the subject of the property access becomes the value of the this parameter while the body of the function is being executed. This enables an object-oriented programming paradigm in which functions (known by their OO name,「methods」) operate on the object of which they are part. See Chapter 9 for details.

Invocation expressions that are not method invocations normally use the global object as the value of the this keyword. In ECMAScript 5, however, functions that are defined in strict mode are invoked with undefined as their this value rather than the global object. See「use strict」for more on strict mode.

Object Creation Expressions

An object creation expression creates a new object and invokes a function (called a constructor) to initialize the properties of that object. Object creation expressions are like invocation expressions except that they are prefixed with the keyword new:

new Object() new Point(2,3)

If no arguments are passed to the constructor function in an object creation expression, the empty pair of parentheses can be omitted:

new Object new Date

When an object creation expression is evaluated, JavaScript first creates a new empty object, just like the one created by the object initializer {}. Next, it invokes the specified function with the specified arguments, passing the new object as the value of the this keyword. The function can then use this to initialize the properties of the newly created object. Functions written for use as constructors do not return a value, and the value of the object creation expression is the newly created and initialized object. If a constructor does return an object value, that value becomes the value of the object creation expression and the newly created object is discarded.

Constructors are explained in more detail in Chapter 9.

Operator Overview

Operators are used for JavaScript’s arithmetic expressions, comparison expressions, logical expressions, assignment expressions, and more. Table 4-1 summarizes the operators and serves as a convenient reference.

Note that most operators are represented by punctuation characters such as + and =. Some, however, are represented by keywords such as delete and instanceof. Keyword operators are regular operators, just like those expressed with punctuation; they simply have a less succinct syntax.

Table 4-1 is organized by operator precedence. The operators listed first have higher precedence than those listed last. Operators separated by a horizontal line have different precedence levels. The column labeled A gives the operator associativity, which can be L (left-to-right) or R (right-to-left), and the column N specifies the number of operands. The column labeled Types lists the expected types of the operands and (after the → symbol) the result type for the operator. The subsections that follow the table explain the concepts of precedence, associativity, and operand type. The operators themselves are individually documented following that discussion.

Table 4-1. JavaScript operators

OperatorOperationANTypes

++ Pre- or post-increment R 1 lval→num

-- Pre- or post-decrement R 1 lval→num

- Negate number R 1 num→num

+ Convert to number R 1 num→num

~ Invert bits R 1 int→int

! Invert boolean value R 1 bool→bool

delete Remove a property R 1 lval→bool

typeof Determine type of operand R 1 any→str

void Return undefined value R 1 any→undef

*, /, % Multiply, divide, remainder L 2 num,num→num

+, - Add, subtract L 2 num,num→num

+ Concatenate strings L 2 str,str→str

<< Shift left L 2 int,int→int

>> Shift right with sign extension L 2 int,int→int

>>> Shift right with zero extension L 2 int,int→int

<, <=,>, >= Compare in numeric order L 2 num,num→bool

<, <=,>, >= Compare in alphabetic order L 2 str,str→bool

instanceof Test object class L 2 obj,func→bool

in Test whether property exists L 2 str,obj→bool

== Test for equality L 2 any,any→bool

!= Test for inequality L 2 any,any→bool

=== Test for strict equality L 2 any,any→bool

!== Test for strict inequality L 2 any,any→bool

& Compute bitwise AND L 2 int,int→int

^ Compute bitwise XOR L 2 int,int→int

| Compute bitwise OR L 2 int,int→int

&& Compute logical AND L 2 any,any→any

|| Compute logical OR L 2 any,any→any

?: Choose 2nd or 3rd operand R 3 bool,any,any→any

= Assign to a variable or property R 2 lval,any→any

*=, /=, %=, +=, Operate and assign R 2 lval,any→any

-=, &=, ^=, |=,

<<=, >>=, >>>=

, Discard 1st operand, return second L 2 any,any→any

Number of Operands

Operators can be categorized based on the number of operands they expect (their arity). Most JavaScript operators, like the * multiplication operator, are binary operators that combine two expressions into a single, more complex expression. That is, they expect two operands. JavaScript also supports a number of unary operators, which convert a single expression into a single, more complex expression. The − operator in the expression −x is a unary operator that performs the operation of negation on the operand x. Finally, JavaScript supports one ternary operator, the conditional operator ?:, which combines three expressions into a single expression.

Operand and Result Type

Some operators work on values of any type, but most expect their operands to be of a specific type, and most operators return (or evaluate to) a value of a specific type. The Types column in Table 4-1 specifies operand types (before the arrow) and result type (after the arrow) for the operators.

JavaScript operators usually convert the type (see Type Conversions) of their operands as needed. The multiplication operator * expects numeric operands, but the expression "3" * "5" is legal because JavaScript can convert the operands to numbers. The value of this expression is the number 15, not the string「15」, of course. Remember also that every JavaScript value is either「truthy」or「falsy,」so operators that expect boolean operands will work with an operand of any type.

Some operators behave differently depending on the type of the operands used with them. Most notably, the + operator adds numeric operands but concatenates string operands. Similarly, the comparison operators such as < perform comparison in numerical or alphabetical order depending on the type of the operands. The descriptions of individual operators explain their type-dependencies and specify what type conversions they perform.

Lvalues

Notice that the assignment operators and a few of the other operators listed in Table 4-1 expect an operand of type lval. lvalue is a historical term that means「an expression that can legally appear on the left side of an assignment expression.」In JavaScript, variables, properties of objects, and elements of arrays are lvalues. The ECMAScript specification allows built-in functions to return lvalues but does not define any functions that behave that way.

Operator Side Effects

Evaluating a simple expression like 2 * 3 never affects the state of your program, and any future computation your program performs will be unaffected by that evaluation. Some expressions, however, have side effects, and their evaluation may affect the result of future evaluations. The assignment operators are the most obvious example: if you assign a value to a variable or property, that changes the value of any expression that uses that variable or property. The ++ and -- increment and decrement operators are similar, since they perform an implicit assignment. The delete operator also has side effects: deleting a property is like (but not the same as) assigning undefined to the property.

No other JavaScript operators have side effects, but function invocation and object creation expressions will have side effects if any of the operators used in the function or constructor body have side effects.

Operator Precedence

The operators listed in Table 4-1 are arranged in order from high precedence to low precedence, with horizontal lines separating groups of operators at the same precedence level. Operator precedence controls the order in which operations are performed. Operators with higher precedence (nearer the top of the table) are performed before those with lower precedence (nearer to the bottom).

Consider the following expression:

w = x + y*z;

The multiplication operator * has a higher precedence than the addition operator +, so the multiplication is performed before the addition. Furthermore, the assignment operator = has the lowest precedence, so the assignment is performed after all the operations on the right side are completed.

Operator precedence can be overridden with the explicit use of parentheses. To force the addition in the previous example to be performed first, write:

w = (x + y)*z;

Note that property access and invocation expressions have higher precedence than any of the operators listed in Table 4-1. Consider this expression:

typeof my.functions[x](y)

Although typeof is one of the highest-priority operators, the typeof operation is performed on the result of the two property accesses and the function invocation.

In practice, if you are at all unsure about the precedence of your operators, the simplest thing to do is to use parentheses to make the evaluation order explicit. The rules that are important to know are these: multiplication and division are performed before addition and subtraction, and assignment has very low precedence and is almost always performed last.

Operator Associativity

In Table 4-1, the column labeled A specifies the associativity of the operator. A value of L specifies left-to-right associativity, and a value of R specifies right-to-left associativity. The associativity of an operator specifies the order in which operations of the same precedence are performed. Left-to-right associativity means that operations are performed from left to right. For example, the subtraction operator has left-to-right associativity, so:

w = x - y - z;

is the same as:

w = ((x - y) - z);

On the other hand, the following expressions:

x = ~-y; w = x = y = z; q = a?b:c?d:e?f:g;

are equivalent to:

x = ~(-y); w = (x = (y = z)); q = a?b:(c?d:(e?f:g));

because the unary, assignment, and ternary conditional operators have right-to-left associativity.

Order of Evaluation

Operator precedence and associativity specify the order in which operations are performed in a complex expression, but they do not specify the order in which the subexpressions are evaluated. JavaScript always evaluates expressions in strictly left-to-right order. In the expression w=x+y*z, for example, the subexpression w is evaluated first, followed by x, y, and z. Then the values of y and z are multiplied, added to the value of x, and assigned to the variable or property specified by expression w. Adding parentheses to the expressions can change the relative order of the multiplication, addition, and assignment, but not the left-to-right order of evaluation.

Order of evaluation only makes a difference if any of the expressions being evaluated has side effects that affect the value of another expression. If expression x increments a variable that is used by expression z, then the fact that x is evaluated before z is important.

Arithmetic Expressions

This section covers the operators that perform arithmetic or other numerical manipulations on their operands. The multiplication, division, and subtraction operators are straightforward and are covered first. The addition operator gets a subsection of its own because it can also perform string concatenation and has some unusual type conversion rules. The unary operators and the bitwise operators are also covered in subsections of their own.

The basic arithmetic operators are * (multiplication), / (division), % (modulo: remainder after division), + (addition), and - (subtraction). As noted, we’ll discuss the + operator in a section of its own. The other basic four operators simply evaluate their operands, convert the values to numbers if necessary, and then compute the product, quotient, remainder, or difference between the values. Non-numeric operands that cannot convert to numbers convert to the NaN value. If either operand is (or converts to) NaN, the result of the operation is also NaN.

The / operator divides its first operand by its second. If you are used to programming languages that distinguish between integer and floating-point numbers, you might expect to get an integer result when you divide one integer by another. In JavaScript, however, all numbers are floating-point, so all division operations have floating-point results: 5/2 evaluates to 2.5, not 2. Division by zero yields positive or negative infinity, while 0/0 evaluates to NaN: neither of these cases raises an error.

The % operator computes the first operand modulo the second operand. In other words, it returns the remainder after whole-number division of the first operand by the second operand. The sign of the result is the same as the sign of the first operand. For example, 5 % 2 evaluates to 1 and -5 % 2 evaluates to -1.

While the modulo operator is typically used with integer operands, it also works for floating-point values. For example, 6.5 % 2.1 evaluates to 0.2.

The + Operator

The binary + operator adds numeric operands or concatenates string operands:

1 + 2 // => 3 "hello" + " " + "there" // => "hello there" "1" + "2" // => "12"

When the values of both operands are numbers, or are both strings, then it is obvious what the + operator does. In any other case, however, type conversion is necessary, and the operation to be performed depends on the conversion performed. The conversions rules for + give priority to string concatenation: if either of the operands is a string or an object that converts to a string, the other operand is converted to a string and concatenation is performed. Addition is performed only if neither operand is string-like.

Technically, the + operator behaves like this:

If either of its operand values is an object, it converts it to a primitive using the object-to-primitive algorithm described in Object to Primitive Conversions: Date objects are converted by their toString() method, and all other objects are converted via valueOf(), if that method returns a primitive value. Most objects do not have a useful valueOf() method, however, so they are converted via toString() as well.

After object-to-primitive conversion, if either operand is a string, the other is converted to a string and concatenation is performed.

Otherwise, both operands are converted to numbers (or to NaN) and addition is performed.

Here are some examples:

1 + 2 // => 3: addition "1" + "2" // => "12": concatenation "1" + 2 // => "12": concatenation after number-to-string 1 + {} // => "1[object Object]": concatenation after object-to-string true + true // => 2: addition after boolean-to-number 2 + null // => 2: addition after null converts to 0 2 + undefined // => NaN: addition after undefined converts to NaN

Finally, it is important to note that when the + operator is used with strings and numbers, it may not be associative. That is, the result may depend on the order in which operations are performed. For example:

1 + 2 + " blind mice"; // => "3 blind mice" 1 + (2 + " blind mice"); // => "12 blind mice"

The first line has no parentheses, and the + operator has left-to-right associativity, so the two numbers are added first, and their sum is concatenated with the string. In the second line, parentheses alter this order of operations: the number 2 is concatenated with the string to produce a new string. Then the number 1 is concatenated with the new string to produce the final result.

Unary Arithmetic Operators

Unary operators modify the value of a single operand to produce a new value. In JavaScript, the unary operators all have high precedence and are all right-associative. The arithmetic unary operators described in this section (+, -, ++, and --) all convert their single operand to a number, if necessary. Note that the punctuation characters + and - are used as both unary and binary operators.

The unary arithmetic operators are the following:

Unary plus (+)

The unary plus operator converts its operand to a number (or to NaN) and returns that converted value. When used with an operand that is already a number, it doesn’t do anything.

Unary minus (-)

When - is used as a unary operator, it converts its operand to a number, if necessary, and then changes the sign of the result.

Increment (++)

The ++ operator increments (i.e., adds 1 to) its single operand, which must be an lvalue (a variable, an element of an array, or a property of an object). The operator converts its operand to a number, adds 1 to that number, and assigns the incremented value back into the variable, element, or property.

The return value of the ++ operator depends on its position relative to the operand. When used before the operand, where it is known as the pre-increment operator, it increments the operand and evaluates to the incremented value of that operand. When used after the operand, where it is known as the post-increment operator, it increments its operand but evaluates to the unincremented value of that operand. Consider the difference between these two lines of code:

var i = 1, j = ++i; // i and j are both 2 var i = 1, j = i++; // i is 2, j is 1

Note that the expression ++x is not always the same as x=x+1. The ++ operator never performs string concatenation: it always converts its operand to a number and increments it. If x is the string「1」, ++x is the number 2, but x+1 is the string「11」.

Also note that, because of JavaScript’s automatic semicolon insertion, you cannot insert a line break between the post-increment operator and the operand that precedes it. If you do so, JavaScript will treat the operand as a complete statement by itself and insert a semicolon before it.

This operator, in both its pre- and post-increment forms, is most commonly used to increment a counter that controls a for loop (for).

Decrement (--)

The -- operator expects an lvalue operand. It converts the value of the operand to a number, subtracts 1, and assigns the decremented value back to the operand. Like the ++ operator, the return value of -- depends on its position relative to the operand. When used before the operand, it decrements and returns the decremented value. When used after the operand, it decrements the operand but returns the undecremented value. When used after its operand, no line break is allowed between the operand and the operator.

Bitwise Operators

The bitwise operators perform low-level manipulation of the bits in the binary representation of numbers. Although they do not perform traditional arithmetic operations, they are categorized as arithmetic operators here because they operate on numeric operands and return a numeric value. These operators are not commonly used in JavaScript programming, and if you are not familiar with the binary representation of decimal integers, you can probably skip this section. Four of these operators perform Boolean algebra on the individual bits of the operands, behaving as if each bit in each operand were a boolean value (1=true, 0=false). The other three bitwise operators are used to shift bits left and right.

The bitwise operators expect integer operands and behave as if those values were represented as 32-bit integers rather than 64-bit floating-point values. These operators convert their operands to numbers, if necessary, and then coerce the numeric values to 32-bit integers by dropping any fractional part and any bits beyond the 32nd. The shift operators require a right-side operand between 0 and 31. After converting this operand to an unsigned 32-bit integer, they drop any bits beyond the 5th, which yields a number in the appropriate range. Surprisingly, NaN, Infinity, and -Infinity all convert to 0 when used as operands of these bitwise operators.

Bitwise AND (&)

The & operator performs a Boolean AND operation on each bit of its integer arguments. A bit is set in the result only if the corresponding bit is set in both operands. For example, 0x1234 & 0x00FF evaluates to 0x0034.

Bitwise OR (|)

The | operator performs a Boolean OR operation on each bit of its integer arguments. A bit is set in the result if the corresponding bit is set in one or both of the operands. For example, 0x1234 | 0x00FF evaluates to 0x12FF.

Bitwise XOR (^)

The ^ operator performs a Boolean exclusive OR operation on each bit of its integer arguments. Exclusive OR means that either operand one is true or operand two is true, but not both. A bit is set in this operation’s result if a corresponding bit is set in one (but not both) of the two operands. For example, 0xFF00 ^ 0xF0F0 evaluates to 0x0FF0.

Bitwise NOT (~)

The ~ operator is a unary operator that appears before its single integer operand. It operates by reversing all bits in the operand. Because of the way signed integers are represented in JavaScript, applying the ~ operator to a value is equivalent to changing its sign and subtracting 1. For example ~0x0F evaluates to 0xFFFFFFF0, or −16.

Shift left (<<)

The << operator moves all bits in its first operand to the left by the number of places specified in the second operand, which should be an integer between 0 and 31. For example, in the operation a << 1, the first bit (the ones bit) of a becomes the second bit (the twos bit), the second bit of a becomes the third, etc. A zero is used for the new first bit, and the value of the 32nd bit is lost. Shifting a value left by one position is equivalent to multiplying by 2, shifting two positions is equivalent to multiplying by 4, and so on. For example, 7 << 2 evaluates to 28.

Shift right with sign (>>)

The >> operator moves all bits in its first operand to the right by the number of places specified in the second operand (an integer between 0 and 31). Bits that are shifted off the right are lost. The bits filled in on the left depend on the sign bit of the original operand, in order to preserve the sign of the result. If the first operand is positive, the result has zeros placed in the high bits; if the first operand is negative, the result has ones placed in the high bits. Shifting a value right one place is equivalent to dividing by 2 (discarding the remainder), shifting right two places is equivalent to integer division by 4, and so on. For example, 7 >> 1 evaluates to 3, and −7 >> 1 evaluates to −4.

Shift right with zero fill (>>>)

The >>> operator is just like the >> operator, except that the bits shifted in on the left are always zero, regardless of the sign of the first operand. For example, −1 >> 4 evaluates to −1, but −1 >>> 4 evaluates to 0x0FFFFFFF.

Relational Expressions

This section describes JavaScript’s relational operators. These operators test for a relationship (such as「equals,」「less than,」or「property of」) between two values and return true or false depending on whether that relationship exists. Relational expressions always evaluate to a boolean value, and that value is often used to control the flow of program execution in if, while, and for statements (see Chapter 5). The subsections that follow document the equality and inequality operators, the comparison operators, and JavaScript’s other two relational operators, in and instanceof.

Equality and Inequality Operators

The == and === operators check whether two values are the same, using two different definitions of sameness. Both operators accept operands of any type, and both return true if their operands are the same and false if they are different. The === operator is known as the strict equality operator (or sometimes the identity operator), and it checks whether its two operands are「identical」using a strict definition of sameness. The == operator is known as the equality operator; it checks whether its two operands are「equal」using a more relaxed definition of sameness that allows type conversions.

JavaScript supports =, ==, and === operators. Be sure you understand the differences between these assignment, equality, and strict equality operators, and be careful to use the correct one when coding! Although it is tempting to read all three operators「equals,」it may help to reduce confusion if you read「gets or is assigned」for =,「is equal to」for ==, and「is strictly equal to」for ===.

The != and !== operators test for the exact opposite of the == and === operators. The != inequality operator returns false if two values are equal to each other according to == and returns true otherwise. The !== operator returns false if two values are strictly equal to each other and returns true otherwise. As you’ll see in Logical Expressions, the ! operator computes the Boolean NOT operation. This makes it easy to remember that != and !== stand for「not equal to」and「not strictly equal to.」

As mentioned in Immutable Primitive Values and Mutable Object References, JavaScript objects are compared by reference, not by value. An object is equal to itself, but not to any other object. If two distinct objects have the same number of properties, with the same names and values, they are still not equal. Two arrays that have the same elements in the same order are not equal to each other.

The strict equality operator === evaluates its operands, and then compares the two values as follows, performing no type conversion:

If the two values have different types, they are not equal.

If both values are null or both values are undefined, they are equal.

If both values are the boolean value true or both are the boolean value false, they are equal.

If one or both values is NaN, they are not equal. The NaN value is never equal to any other value, including itself! To check whether a value x is NaN, use x !== x. NaN is the only value of x for which this expression will be true.

If both values are numbers and have the same value, they are equal. If one value is 0 and the other is -0, they are also equal.

If both values are strings and contain exactly the same 16-bit values (see the sidebar in Text) in the same positions, they are equal. If the strings differ in length or content, they are not equal. Two strings may have the same meaning and the same visual appearance, but still be encoded using different sequences of 16-bit values. JavaScript performs no Unicode normalization, and a pair of strings like this are not considered equal to the === or to the == operators. See String.localeCompare() in Part III for another way to compare strings.

If both values refer to the same object, array, or function, they are equal. If they refer to different objects they are not equal, even if both objects have identical properties.

The equality operator == is like the strict equality operator, but it is less strict. If the values of the two operands are not the same type, it attempts some type conversions and tries the comparison again:

If the two values have the same type, test them for strict equality as described above. If they are strictly equal, they are equal. If they are not strictly equal, they are not equal.

If the two values do not have the same type, the == operator may still consider them equal. Use the following rules and type conversions to check for equality:

If one value is null and the other is undefined, they are equal.

If one value is a number and the other is a string, convert the string to a number and try the comparison again, using the converted value.

If either value is true, convert it to 1 and try the comparison again. If either value is false, convert it to 0 and try the comparison again.

If one value is an object and the other is a number or string, convert the object to a primitive using the algorithm described in Object to Primitive Conversions and try the comparison again. An object is converted to a primitive value by either its toString() method or its valueOf() method. The built-in classes of core JavaScript attempt valueOf() conversion before toString() conversion, except for the Date class, which performs toString() conversion. Objects that are not part of core JavaScript may convert themselves to primitive values in an implementation-defined way.

Any other combinations of values are not equal.

As an example of testing for equality, consider the comparison:

"1" == true

This expression evaluates to true, indicating that these very different-looking values are in fact equal. The boolean value true is first converted to the number 1, and the comparison is done again. Next, the string "1" is converted to the number 1. Since both values are now the same, the comparison returns true.

Comparison Operators

The comparison operators test the relative order (numerical or alphabetics) of their two operands:

Less than (<)

The < operator evaluates to true if its first operand is less than its second operand; otherwise it evaluates to false.

Greater than (>)

The > operator evaluates to true if its first operand is greater than its second operand; otherwise it evaluates to false.

Less than or equal (<=)

The <= operator evaluates to true if its first operand is less than or equal to its second operand; otherwise it evaluates to false.

Greater than or equal (>=)

The >= operator evaluates to true if its first operand is greater than or equal to its second operand; otherwise it evaluates to false.

The operands of these comparison operators may be of any type. Comparison can be performed only on numbers and strings, however, so operands that are not numbers or strings are converted. Comparison and conversion occur as follows:

If either operand evaluates to an object, that object is converted to a primitive value as described at the end of Object to Primitive Conversions: if its valueOf() method returns a primitive value, that value is used. Otherwise, the return value of its toString() method is used.

If, after any required object-to-primitive conversion, both operands are strings, the two strings are compared, using alphabetical order, where「alphabetical order」is defined by the numerical order of the 16-bit Unicode values that make up the strings.

If, after object-to-primitive conversion, at least one operand is not a string, both operands are converted to numbers and compared numerically. 0 and -0 are considered equal. Infinity is larger than any number other than itself, and -Infinity is smaller than any number other than itself. If either operand is (or converts to) NaN, then the comparison operator always returns false.

Remember that JavaScript strings are sequences of 16-bit integer values, and that string comparison is just a numerical comparison of the values in the two strings. The numerical encoding order defined by Unicode may not match the traditional collation order used in any particular language or locale. Note in particular that string comparison is case-sensitive, and all capital ASCII letters are「less than」all lowercase ASCII letters. This rule can cause confusing results if you do not expect it. For example, according to the < operator, the string「Zoo」comes before the string「aardvark」.

For a more robust string-comparison algorithm, see the String.localeCompare() method, which also takes locale-specific definitions of alphabetical order into account. For case-insensitive comparisons, you must first convert the strings to all lowercase or all uppercase using String.toLowerCase() or String.toUpperCase().

Both the + operator and the comparison operators behave differently for numeric and string operands. + favors strings: it performs concatenation if either operand is a string. The comparison operators favor numbers and only perform string comparison if both operands are strings:

1 + 2 // Addition. Result is 3. "1" + "2" // Concatenation. Result is "12". "1" + 2 // Concatenation. 2 is converted to "2". Result is "12". 11 < 3 // Numeric comparison. Result is false. "11" < "3" // String comparison. Result is true. "11" < 3 // Numeric comparison. "11" converted to 11. Result is false. "one" < 3 // Numeric comparison. "one" converted to NaN. Result is false.

Finally, note that the <= (less than or equal) and >= (greater than or equal) operators do not rely on the equality or strict equality operators for determining whether two values are「equal.」Instead, the less-than-or-equal operator is simply defined as「not greater than,」and the greater-than-or-equal operator is defined as「not less than.」The one exception occurs when either operand is (or converts to) NaN, in which case all four comparison operators return false.

The in Operator

