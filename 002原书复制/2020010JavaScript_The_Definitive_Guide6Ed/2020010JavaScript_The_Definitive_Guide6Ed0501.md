push() and pop()

The push() and pop() methods allow you to work with arrays as if they were stacks. The push() method appends one or more new elements to the end of an array and returns the new length of the array. The pop() method does the reverse: it deletes the last element of an array, decrements the array length, and returns the value that it removed. Note that both methods modify the array in place rather than produce a modified copy of the array. The combination of push() and pop() allows you to use a JavaScript array to implement a first-in, last-out stack. For example:

var stack = []; // stack: [] stack.push(1,2); // stack: [1,2] Returns 2 stack.pop(); // stack: [1] Returns 2 stack.push(3); // stack: [1,3] Returns 2 stack.pop(); // stack: [1] Returns 3 stack.push([4,5]); // stack: [1,[4,5]] Returns 2 stack.pop() // stack: [1] Returns [4,5] stack.pop(); // stack: [] Returns 1

unshift() and shift()

The unshift() and shift() methods behave much like push() and pop(), except that they insert and remove elements from the beginning of an array rather than from the end. unshift() adds an element or elements to the beginning of the array, shifts the existing array elements up to higher indexes to make room, and returns the new length of the array. shift() removes and returns the first element of the array, shifting all subsequent elements down one place to occupy the newly vacant space at the start of the array. For example:

var a = []; // a:[] a.unshift(1); // a:[1] Returns: 1 a.unshift(22); // a:[22,1] Returns: 2 a.shift(); // a:[1] Returns: 22 a.unshift(3,[4,5]); // a:[3,[4,5],1] Returns: 3 a.shift(); // a:[[4,5],1] Returns: 3 a.shift(); // a:[1] Returns: [4,5] a.shift(); // a:[] Returns: 1

Note the possibly surprising behavior of unshift() when it’s invoked with multiple arguments. Instead of being inserted into the array one at a time, arguments are inserted all at once (as with the splice() method). This means that they appear in the resulting array in the same order in which they appeared in the argument list. Had the elements been inserted one at a time, their order would have been reversed.

toString() and toLocaleString()

An array, like any JavaScript object, has a toString() method. For an array, this method converts each of its elements to a string (calling the toString() methods of its elements, if necessary) and outputs a comma-separated list of those strings. Note that the output does not include square brackets or any other sort of delimiter around the array value. For example:

[1,2,3].toString() // Yields '1,2,3' ["a", "b", "c"].toString() // Yields 'a,b,c' [1, [2,'c']].toString() // Yields '1,2,c'

Note that the join() method returns the same string when it is invoked with no arguments.

toLocaleString() is the localized version of toString(). It converts each array element to a string by calling the toLocaleString() method of the element, and then it concatenates the resulting strings using a locale-specific (and implementation-defined) separator string.

ECMAScript 5 Array Methods

ECMAScript 5 defines nine new array methods for iterating, mapping, filtering, testing, reducing, and searching arrays. The subsections below describe these methods.

Before we cover the details, however, it is worth making some generalizations about these ECMAScript 5 array methods. First, most of the methods accept a function as their first argument and invoke that function once for each element (or some elements) of the array. If the array is sparse, the function you pass is not invoked for nonexistent elements. In most cases, the function you supply is invoked with three arguments: the value of the array element, the index of the array element, and the array itself. Often, you only need the first of these argument values and can ignore the second and third values. Most of the ECMAScript 5 array methods that accept a function as their first argument accept an optional second argument. If specified, the function is invoked as if it is a method of this second argument. That is, the second argument you pass becomes the value of the this keyword inside of the function you pass. The return value of the function you pass is important, but different methods handle the return value in different ways. None of the ECMAScript 5 array methods modify the array on which they are invoked. If you pass a function to these methods, that function may modify the array, of course.

forEach()

The forEach() method iterates through an array, invoking a function you specify for each element. As described above, you pass the function as the first argument to forEach(). forEach() then invokes your function with three arguments: the value of the array element, the index of the array element, and the array itself. If you only care about the value of the array element, you can write a function with only one parameter—the additional arguments will be ignored:

var data = [1,2,3,4,5]; // An array to sum // Compute the sum of the array elements var sum = 0; // Start at 0 data.forEach(function(value) { sum += value; }); // Add each value to sum sum // => 15 // Now increment each array element data.forEach(function(v, i, a) { a[i] = v + 1; }); data // => [2,3,4,5,6]

Note that forEach() does not provide a way to terminate iteration before all elements have been passed to the function. That is, there is no equivalent of the break statement you can use with a regular for loop. If you need to terminate early, you must throw an exception, and place the call to forEach() within a try block. The following code defines a foreach() function that calls the forEach() method within such a try block. If the function passed to foreach() throws foreach.break, the loop will terminate early:

function foreach(a,f,t) { try { a.forEach(f,t); } catch(e) { 	if (e === foreach.break) return; 	else throw e; } } foreach.break = new Error("StopIteration");

map()

The map() method passes each element of the array on which it is invoked to the function you specify, and returns an array containing the values returned by that function. For example:

a = [1, 2, 3]; b = a.map(function(x) { return x*x; }); // b is [1, 4, 9]

The function you pass to map() is invoked in the same way as a function passed to forEach(). For the map() method, however, the function you pass should return a value. Note that map() returns a new array: it does not modify the array it is invoked on. If that array is sparse, the returned array will be sparse in the same way: it will have the same length and the same missing elements.

filter()

The filter() method returns an array containing a subset of the elements of the array on which it is invoked. The function you pass to it should be predicate: a function that returns true or false. The predicate is invoked just as for forEach() and map(). If the return value is true, or a value that converts to true, then the element passed to the predicate is a member of the subset and is added to the array that will become the return value. Examples:

a = [5, 4, 3, 2, 1]; smallvalues = a.filter(function(x) { return x < 3 }); // [2, 1] everyother = a.filter(function(x,i) { return i%2==0 }); // [5, 3, 1]

Note that filter() skips missing elements in sparse arrays, and that its return value is always dense. To close the gaps in a sparse array, you can do this:

var dense = sparse.filter(function() { return true; });

And to close gaps and remove undefined and null elements you can use filter like this:

a = a.filter(function(x) { return x !== undefined && x != null; });

every() and some()

The every() and some() methods are array predicates: they apply a predicate function you specify to the elements of the array, and then return true or false.

The every() method is like the mathematical「for all」quantifier ∀: it returns true if and only if your predicate function returns true for all elements in the array:

a = [1,2,3,4,5]; a.every(function(x) { return x < 10; }) // => true: all values < 10. a.every(function(x) { return x % 2 === 0; }) // => false: not all values even.

The some() method is like the mathematical「there exists」quantifier ∃: it returns true if there exists at least one element in the array for which the predicate returns true, and returns false if and only if the predicate returns false for all elements of the array:

a = [1,2,3,4,5]; a.some(function(x) { return x%2===0; }) // => true a has some even numbers. a.some(isNaN) // => false: a has no non-numbers.

Note that both every() and some() stop iterating array elements as soon as they know what value to return. some() returns true the first time your predicate returns true, and only iterates through the entire array if your predicate always returns false. every() is the opposite: it returns false the first time your predicate returns false, and only iterates all elements if your predicate always returns true. Note also that by mathematical convention, every() returns true and some returns false when invoked on an empty array.

reduce(), reduceRight()

The reduce() and reduceRight() methods combine the elements of an array, using the function you specify, to produce a single value. This is a common operation in functional programming and also goes by the names「inject」and「fold.」Examples help illustrate how it works:

var a = [1,2,3,4,5] var sum = a.reduce(function(x,y) { return x+y }, 0); // Sum of values var product = a.reduce(function(x,y) { return x*y }, 1); // Product of values var max = a.reduce(function(x,y) { return (x>y)?x:y; }); // Largest value

reduce() takes two arguments. The first is the function that performs the reduction operation. The task of this reduction function is to somehow combine or reduce two values into a single value, and to return that reduced value. In the examples above, the functions combine two values by adding them, multiplying them, and choosing the largest. The second (optional) argument is an initial value to pass to the function.

Functions used with reduce() are different than the functions used with forEach() and map(). The familiar value, index, and array values are passed as the second, third, and fourth arguments. The first argument is the accumulated result of the reduction so far. On the first call to the function, this first argument is the initial value you passed as the second argument to reduce(). On subsequent calls, it is the value returned by the previous invocation of the function. In the first example above, the reduction function is first called with arguments 0 and 1. It adds these and returns 1. It is then called again with arguments 1 and 2 and it returns 3. Next it computes 3+3=6, then 6+4=10, and finally 10+5=15. This final value, 15, becomes the return value of reduce().

You may have noticed that the third call to reduce() above has only a single argument: there is no initial value specified. When you invoke reduce() like this with no initial value, it uses the first element of the array as the initial value. This means that the first call to the reduction function will have the first and second array elements as its first and second arguments. In the sum and product examples above, we could have omitted the initial value argument.

Calling reduce() on an empty array with no initial value argument causes a TypeError. If you call it with only one value—either an array with one element and no initial value or an empty array and an initial value—it simply returns that one value without ever calling the reduction function.

reduceRight() works just like reduce(), except that it processes the array from highest index to lowest (right-to-left), rather than from lowest to highest. You might want to do this if the reduction operation has right-to-left precedence, for example:

var a = [2, 3, 4] // Compute 2^(3^4). Exponentiation has right-to-left precedence var big = a.reduceRight(function(accumulator,value) { return Math.pow(value,accumulator); });

Note that neither reduce() nor reduceRight() accepts an optional argument that specifies the this value on which the reduction function is to be invoked. The optional initial value argument takes its place. See the Function.bind() method if you need your reduction function invoked as a method of a particular object.

It is worth noting that the every() and some() methods described above perform a kind of array reduction operation. They differ from reduce(), however, in that they terminate early when possible, and do not always visit every array element.

The examples shown so far have been numeric for simplicity, but reduce() and reduceRight() are not intended solely for mathematical computations. Consider the union() function from Example 6-2. It computes the「union」of two objects and returns a new object that has the properties of both. This function expects two objects and returns another object, so it works as a reduction function, and we can use reduce() to generalize it and compute the union of any number of objects:

var objects = [{x:1}, {y:2}, {z:3}]; var merged = objects.reduce(union); // => {x:1, y:2, z:3}

Recall that when two objects have properties with the same name, the union() function uses the value of that property from the first argument. Thus reduce() and reduceRight() may give different results when used with union():

var objects = [{x:1,a:1}, {y:2,a:2}, {z:3,a:3}]; var leftunion = objects.reduce(union); // {x:1, y:2, z:3, a:1} var rightunion = objects.reduceRight(union); // {x:1, y:2, z:3, a:3}

indexOf() and lastIndexOf()

indexOf() and lastIndexOf() search an array for an element with a specified value, and return the index of the first such element found, or –1 if none is found. indexOf() searches the array from beginning to end, and lastIndexOf() searches from end to beginning.

a = [0,1,2,1,0]; a.indexOf(1) // => 1: a[1] is 1 a.lastIndexOf(1) // => 3: a[3] is 1 a.indexOf(3) // => -1: no element has value 3

Unlike the other methods described in this section, indexOf() and lastIndexOf() do not take a function argument. The first argument is the value to search for. The second argument is optional: it specifies the array index at which to begin the search. If this argument is omitted, indexOf() starts at the beginning and lastIndexOf() starts at the end. Negative values are allowed for the second argument and are treated as an offset from the end of the array, as they are for the splice() method: a value of –1, for example, specifies the last element of the array.

The following function searches an array for a specified value and returns an array of all matching indexes. This demonstrates how the second argument to indexOf() can be used to find matches beyond the first.

// Find all occurrences of a value x in an array a and return an array // of matching indexes function findall(a, x) { var results = [], // The array of indexes we'll return len = a.length, // The length of the array to be searched pos = 0; // The position to search from while(pos < len) { // While more elements to search... pos = a.indexOf(x, pos); // Search if (pos === -1) break; // If nothing found, we're done. results.push(pos); // Otherwise, store index in array pos = pos + 1; // And start next search at next element } return results; // Return array of indexes }

Note that strings have indexOf() and lastIndexOf() methods that work like these array methods.

Array Type

We’ve seen throughout this chapter that arrays are objects with some special behavior. Given an unknown object, it is often useful to be able to determine whether it is an array or not. In ECMAScript 5, you can do this with the Array.isArray() function:

Array.isArray([]) // => true Array.isArray({}) // => false

Prior to ECMAScript 5, however, distinguishing arrays from nonarray objects was surprisingly difficult. The typeof operator does not help here: it returns「object」for arrays (and for all objects other than functions). The instanceof operator works in simple cases:

[] instanceof Array // => true ({}) instanceof Array // => false

The problem with using instanceof is that in web browsers, there can be more than one window or frame open. Each has its own JavaScript environment, with its own global object. And each global object has its own set of constructor functions. Therefore an object from one frame will never be an instance of a constructor from another frame. While interframe confusion does not arise often, it is enough of a problem that the instanceof operator is not deemed a reliable test for arrays.

The solution is to inspect the class attribute (see The class Attribute) of the object. For arrays, this attribute will always have the value「Array」, and we can therefore write an isArray() function in ECMAScript 3 like this:

var isArray = Function.isArray || function(o) { return typeof o === "object" && 	Object.prototype.toString.call(o) === "[object Array]"; };

This test of the class attribute is, in fact, exactly what the ECMAScript 5 Array.isArray() function does. The technique for obtaining the class of an object using Object.prototype.toString() is explained in The class Attribute and demonstrated in Example 6-4.

Array-Like Objects

As we’ve seen, JavaScript arrays have some special features that other objects do not have:

The length property is automatically updated as new elements are added to the list.

Setting length to a smaller value truncates the array.

Arrays inherit useful methods from Array.prototype.

Arrays have a class attribute of「Array」.

These are the features that make JavaScript arrays distinct from regular objects. But they are not the essential features that define an array. It is often perfectly reasonable to treat any object with a numeric length property and corresponding non-negative integer properties as a kind of array.

These「array-like」objects actually do occasionally appear in practice, and although you cannot directly invoke array methods on them or expect special behavior from the length property, you can still iterate through them with the same code you’d use for a true array. It turns out that many array algorithms work just as well with array-like objects as they do with real arrays. This is especially true if your algorithms treat the array as read-only or if they at least leave the array length unchanged.

The following code takes a regular object, adds properties to make it an array-like object, and then iterates through the「elements」of the resulting pseudo-array:

var a = {}; // Start with a regular empty object // Add properties to make it "array-like" var i = 0; while(i < 10) { a[i] = i * i; i++; } a.length = i; // Now iterate through it as if it were a real array var total = 0; for(var j = 0; j < a.length; j++) total += a[j];

The Arguments object that’s described in Variable-Length Argument Lists: The Arguments Object is an array-like object. In client-side JavaScript, a number of DOM methods, such as document.getElementsByTagName(), return array-like objects. Here’s a function you might use to test for objects that work like arrays:

// Determine if o is an array-like object. // Strings and functions have numeric length properties, but are // excluded by the typeof test. In client-side JavaScript, DOM text // nodes have a numeric length property, and may need to be excluded // with an additional o.nodeType != 3 test. function isArrayLike(o) { if (o && // o is not null, undefined, etc. typeof o === "object" && // o is an object isFinite(o.length) && // o.length is a finite number o.length >= 0 && // o.length is non-negative o.length===Math.floor(o.length) && // o.length is an integer o.length < 4294967296) // o.length < 2^32 return true; // Then o is array-like else return false; // Otherwise it is not }

We’ll see in Strings As Arrays that ECMAScript 5 strings behave like arrays (and that some browsers made strings indexable before ECMAScript 5). Nevertheless, tests like the one above for array-like objects typically return false for strings—they are usually best handled as strings, not as arrays.

The JavaScript array methods are purposely defined to be generic, so that they work correctly when applied to array-like objects in addition to true arrays. In ECMAScript 5, all array methods are generic. In ECMAScript 3, all methods except toString() and toLocaleString() are generic. (The concat() method is an exception: although it can be invoked on an array-like object, it does not property expand that object into the returned array.) Since array-like objects do not inherit from Array.prototype, you cannot invoke array methods on them directly. You can invoke them indirectly using the Function.call method, however:

var a = {"0":"a", "1":"b", "2":"c", length:3}; // An array-like object Array.prototype.join.call(a, "+") // => "a+b+c" Array.prototype.slice.call(a, 0) // => ["a","b","c"]: true array copy Array.prototype.map.call(a, function(x) { return x.toUpperCase(); }) // => ["A","B","C"]:

We’ve seen this call() technique before in the isArray() method of Array Type. The call() method of Function objects is covered in more detail in The call() and apply() Methods.

The ECMAScript 5 array methods were introduced in Firefox 1.5. Because they were written generically, Firefox also introduced versions of these methods as functions defined directly on the Array constructor. With these versions of the methods defined, the examples above can be rewritten like this:

var a = {"0":"a", "1":"b", "2":"c", length:3}; // An array-like object Array.join(a, "+") Array.slice(a, 0) Array.map(a, function(x) { return x.toUpperCase(); })

These static function versions of the array methods are quite useful when working with array-like objects, but since they are nonstandard, you can’t count on them to be defined in all browsers. You can write code like this to ensure that the functions you need exist before you use them:

Array.join = Array.join || function(a,sep) { return Array.prototype.join.call(a,sep); }; Array.slice = Array.slice || function(a,from,to) { return Array.prototype.slice.call(a,from,to); }; Array.map = Array.map || function(a, f, thisArg) { return Array.prototype.map.call(a, f, thisArg); }

Strings As Arrays

In ECMAScript 5 (and in many recent browser implementations—including IE8—prior to ECMAScript 5), strings behave like read-only arrays. Instead of accessing individual characters with the charAt() method, you can use square brackets:

var s = test; s.charAt(0) // => "t" s[1] // => "e"

The typeof operator still returns「string」for strings, of course, and the Array.isArray() method returns false if you pass it a string.

The primary benefit of indexable strings is simply that we can replace calls to charAt() with square brackets, which are more concise and readable, and potentially more efficient. The fact that strings behave like arrays also means, however, that we can apply generic array methods to them. For example:

s = "JavaScript" Array.prototype.join.call(s, " ") // => "J a v a S c r i p t" Array.prototype.filter.call(s, // Filter the characters of the string function(x) { return x.match(/[^aeiou]/); // Only match nonvowels }).join("") // => "JvScrpt"

Keep in mind that strings are immutable values, so when they are treated as arrays, they are read-only arrays. Array methods like push(), sort(), reverse(), and splice() modify an array in place and do not work on strings. Attempting to modify a string using an array method does not, however, cause an error: it simply fails silently.

Chapter 8. Functions

A function is a block of JavaScript code that is defined once but may be executed, or invoked, any number of times. You may already be familiar with the concept of a function under a name such as subroutine or procedure. JavaScript functions are parameterized: a function definition may include a list of identifiers, known as parameters, that work as local variables for the body of the function. Function invocations provide values, or arguments, for the function’s parameters. Functions often use their argument values to compute a return value that becomes the value of the function-invocation expression. In addition to the arguments, each invocation has another value—the invocation context—that is the value of the this keyword.

If a function is assigned to the property of an object, it is known as a method of that object. When a function is invoked on or through an object, that object is the invocation context or this value for the function. Functions designed to initialize a newly created object are called constructors. Constructors were described in Creating Objects and will be covered again in Chapter 9.

In JavaScript, functions are objects, and they can be manipulated by programs. JavaScript can assign functions to variables and pass them to other functions, for example. Since functions are objects, you can set properties on them, and even invoke methods on them.

JavaScript function definitions can be nested within other functions, and they have access to any variables that are in scope where they are defined. This means that JavaScript functions are closures, and it enables important and powerful programming techniques.

Defining Functions

Functions are defined with the function keyword, which can be used in a function definition expression (Function Definition Expressions) or in a function declaration statement (function). In either form, function definitions begin with the keyword function followed by these components:

An identifier that names the function. The name is a required part of function declaration statements: it is used as the name of a variable, and the newly defined function object is assigned to the variable. For function definition expressions, the name is optional: if present, the name refers to the function object only within the body of the function itself.

A pair of parentheses around a comma-separated list of zero or more identifiers. These identifiers are the parameter names for the function, and they behave like local variables within the body of the function.

A pair of curly braces with zero or more JavaScript statements inside. These statements are the body of the function: they are executed whenever the function is invoked.

Example 8-1 shows some function definitions using both statement and expression forms. Notice that a function defined as an expression is only useful if it is part of a larger expression, such as an assignment or invocation, that does something with the newly defined function.

Example 8-1. Defining JavaScript functions

// Print the name and value of each property of o. Return undefined. function printprops(o) { for(var p in o) console.log(p + ": " + o[p] + "\n"); } // Compute the distance between Cartesian points (x1,y1) and (x2,y2). function distance(x1, y1, x2, y2) { var dx = x2 - x1; var dy = y2 - y1; return Math.sqrt(dx*dx + dy*dy); } // A recursive function (one that calls itself) that computes factorials // Recall that x! is the product of x and all positive integers less than it. function factorial(x) { if (x <= 1) return 1; return x * factorial(x-1); } // This function expression defines a function that squares its argument. // Note that we assign it to a variable var square = function(x) { return x*x; } // Function expressions can include names, which is useful for recursion. var f = function fact(x) { if (x <= 1) return 1; else return x*fact(x-1); }; // Function expressions can also be used as arguments to other functions: data.sort(function(a,b) { return a-b; }); // Function expressions are sometimes defined and immediately invoked: var tensquared = (function(x) {return x*x;}(10));

Note that the function name is optional for functions defined as expressions. A function declaration statement actually declares a variable and assigns a function object to it. A function definition expression, on the other hand, does not declare a variable. A name is allowed for functions, like the factorial function above, that need to refer to themselves. If a function definition expression includes a name, the local function scope for that function will include a binding of that name to the function object. In effect, the function name becomes a local variable within the function. Most functions defined as expressions do not need names, which makes their definition more compact. Function definition expressions are particularly well suited for functions that are used only once, as in the last two examples above.

Function Names

Any legal JavaScript identifier can be a function name. Try to choose function names that are descriptive but concise. Striking the right balance is an art that comes with experience. Well-chosen function names can make a big difference in the readability (and thus maintainability) of your code.

Function names are often verbs or phrases that begin with verbs. It is a common convention to begin function names with a lowercase letter. When a name includes multiple words, one convention is to separate words with underscores like_this(); another convention is to begin all words after the first with an uppercase letter likeThis(). Functions that are supposed to be internal or hidden (and not part of a public API) are sometimes given names that begin with an underscore.

In some styles of programming, or within well-defined programming frameworks, it can be useful to give frequently used functions very short names. The client-side JavaScript framework jQuery (covered in Chapter 19), for example, makes heavy use in its public API of a function named $() (yes, just the dollar sign). (Recall from Identifiers and Reserved Words that dollar signs and underscores are the two characters besides letters and numbers that are legal in JavaScript identifiers.)

As described in function, function declaration statements are「hoisted」to the top of the enclosing script or the enclosing function, so that functions declared in this way may be invoked from code that appears before they are defined. This is not true for functions defined as expressions, however: in order to invoke a function, you must be able to refer to it, and you can’t refer to a function defined as an expression until it is assigned to a variable. Variable declarations are hoisted (see Function Scope and Hoisting, but assignments to those variables are not hoisted, so functions defined with expressions cannot be invoked before they are defined.

Notice that most, but not all, of the functions in Example 8-1 contain a return statement (return). The return statement causes the function to stop executing and to return the value of its expression (if any) to the caller. If the return statement does not have an associated expression, it returns the undefined value. If a function does not contain a return statement, it simply executes each statement in the function body and returns the undefined value to the caller.

Most of the functions in Example 8-1 are designed to compute a value, and they use return to return that value to their caller. The printprops() function is different: its job is to output the names and values of an object’s properties. No return value is necessary, and the function does not include a return statement. The value of an invocation of the printprops() function is always undefined. (Functions with no return value are sometimes called procedures.)

Nested Functions

In JavaScript, functions may be nested within other functions. For example:

function hypotenuse(a, b) { function square(x) { return x*x; } return Math.sqrt(square(a) + square(b)); }

The interesting thing about nested functions is their variable scoping rules: they can access the parameters and variables of the function (or functions) they are nested within. In the code above, for example, the inner function square() can read and write the parameters a and b defined by the outer function hypotenuse(). These scope rules for nested functions are very important, and we’ll consider them again in Closures.

As noted in function, function declaration statements are not true statements, and the ECMAScript specification only allows them as top-level statements. They can appear in global code, or within other functions, but they cannot appear inside of loops, conditionals, or try/catch/finally or with statements.[10] Note that this restriction applies only to functions declared as statements. Function definition expressions may appear anywhere in your JavaScript code.

* * *

[10] Some JavaScript implementations relax this rule. Firefox, for example, allows「conditional function declarations」that appear within if statements.

Invoking Functions

The JavaScript code that makes up the body of a function is not executed when the function is defined but when it is invoked. JavaScript functions can be invoked in four ways:

as functions,

as methods,

as constructors, and

indirectly through their call() and apply() methods.

Function Invocation

Functions are invoked as functions or as methods with an invocation expression (Invocation Expressions). An invocation expression consists of a function expression that evaluates to a function object followed by an open parenthesis, a comma-separated list of zero or more argument expressions, and a close parenthesis. If the function expression is a property-access expression—if the function is the property of an object or an element of an array—then it is a method invocation expression. That case will be explained below. The following code includes a number of regular function invocation expressions:

printprops({x:1}); var total = distance(0,0,2,1) + distance(2,1,3,5); var probability = factorial(5)/factorial(13);

In an invocation, each argument expression (the ones between the parentheses) is evaluated, and the resulting values become the arguments to the function. These values are assigned to the parameters named in the function definition. In the body of the function, a reference to a parameter evaluates to the corresponding argument value.

For regular function invocation, the return value of the function becomes the value of the invocation expression. If the function returns because the interpreter reaches the end, the return value is undefined. If the function returns because the interpreter executes a return, the return value is the value of the expression that follows the return or undefined if the return statement has no value.

For function invocation in ECMAScript 3 and nonstrict ECMAScript 5, the invocation context (the this value) is the global object. In strict mode, however, the invocation context is undefined.

Functions written to be invoked as functions do not typically use the this keyword at all. It can be used, however, to determine whether strict mode is in effect:

// Define and invoke a function to determine if we're in strict mode. var strict = (function() { return !this; }());

Method Invocation

A method is nothing more than a JavaScript function that is stored in a property of an object. If you have a function f and an object o, you can define a method named m of o with the following line:

o.m = f;

Having defined the method m() of the object o, invoke it like this:

o.m();

Or, if m() expects two arguments, you might invoke it like this:

o.m(x, y);

The code above is an invocation expression: it includes a function expression o.m and two argument expressions, x and y. The function expression is itself a property access expression (Property Access Expressions), and this means that the function is invoked as a method rather than as a regular function.

The arguments and return value of a method invocation are handled exactly as described above for regular function invocation. Method invocations differ from function invocations in one important way, however: the invocation context. Property access expressions consist of two parts: an object (in this case o) and a property name (m). In a method invocation expression like this, the object o becomes the invocation context, and the function body can refer to that object by using the keyword this. Here is a concrete example:

var calculator = { // An object literal operand1: 1, operand2: 1, add: function() { // Note the use of the this keyword to refer to this object. this.result = this.operand1 + this.operand2; } }; calculator.add(); // A method invocation to compute 1+1. calculator.result // => 2

Most method invocations use the dot notation for property access, but property access expressions that use square brackets also cause method invocation. The following are both method invocations, for example:

o["m"](x,y); // Another way to write o.m(x,y). a[0](z) // Also a method invocation (assuming a[0] is a function).

Method invocations may also involve more complex property access expressions:

customer.surname.toUpperCase(); // Invoke method on customer.surname f().m(); // Invoke method m() on return value of f()

Methods and the this keyword are central to the object-oriented programming paradigm. Any function that is used as a method is effectively passed an implicit argument—the object through which it is invoked. Typically, a method performs some sort of operation on that object, and the method-invocation syntax is an elegant way to express the fact that a function is operating on an object. Compare the following two lines:

rect.setSize(width, height); setRectSize(rect, width, height);

The hypothetical functions invoked in these two lines of code may perform exactly the same operation on the (hypothetical) object rect, but the method-invocation syntax in the first line more clearly indicates the idea that it is the object rect that is the primary focus of the operation.

Method Chaining

When methods return objects, you can use the return value of one method invocation as part of a subsequent invocation. This results in a series (or「chain」or「cascade」) of method invocations as a single expression. When working with the jQuery library (Chapter 19), for example, it is common to write code like this:

// Find all headers, map to their ids, convert to an array and sort them $(":header").map(function() { return this.id }).get().sort();

When you write a method that does not have a return value of its own, consider having the method return this. If you do this consistently throughout your API, you will enable a style of programming known as method chaining[11] in which an object can be named once and then multiple methods can be invoked on it:

shape.setX(100).setY(100).setSize(50).setOutline("red").setFill("blue").draw();

Don’t confuse method chaining with constructor chaining, which is described in Constructor and Method Chaining.

Note that this is a keyword, not a variable or property name. JavaScript syntax does not allow you to assign a value to this.

Unlike variables, the this keyword does not have a scope, and nested functions do not inherit the this value of their caller. If a nested function is invoked as a method, its this value is the object it was invoked on. If a nested function is invoked as a function then its this value will be either the global object (non-strict mode) or undefined (strict mode). It is a common mistake to assume that a nested function invoked as a function can use this to obtain the invocation context of the outer function. If you want to access the this value of the outer function, you need to store that value into a variable that is in scope for the inner function. It is common to use the variable self for this purpose. For example:

var o = { // An object o. m: function() { // Method m of the object. var self = this; // Save the this value in a variable. console.log(this === o); // Prints "true": this is the object o. f(); // Now call the helper function f(). function f() { // A nested function f console.log(this === o); // "false": this is global or undefined console.log(self === o); // "true": self is the outer this value. } } }; o.m(); // Invoke the method m on the object o.

Example 8-5, in The bind() Method, includes a more realistic use of the var self=this idiom.

Constructor Invocation

If a function or method invocation is preceded by the keyword new, then it is a constructor invocation. (Constructor invocations were introduced in Object Creation Expressions and Creating Objects with new, and constructors will be covered in more detail in Chapter 9.) Constructor invocations differ from regular function and method invocations in their handling of arguments, invocation context, and return value.

If a constructor invocation includes an argument list in parentheses, those argument expressions are evaluated and passed to the function in the same way they would be for function and method invocations. But if a constructor has no parameters, then JavaScript constructor invocation syntax allows the argument list and parentheses to be omitted entirely. You can always omit a pair of empty parentheses in a constructor invocation and the following two lines, for example, are equivalent:

var o = new Object(); var o = new Object;

A constructor invocation creates a new, empty object that inherits from the prototype property of the constructor. Constructor functions are intended to initialize objects and this newly created object is used as the invocation context, so the constructor function can refer to it with the this keyword. Note that the new object is used as the invocation context even if the constructor invocation looks like a method invocation. That is, in the expression new o.m(), o is not used as the invocation context.

Constructor functions do not normally use the return keyword. They typically initialize the new object and then return implicitly when they reach the end of their body. In this case, the new object is the value of the constructor invocation expression. If, however, a constructor explicitly used the return statement to return an object, then that object becomes the value of the invocation expression. If the constructor uses return with no value, or if it returns a primitive value, that return value is ignored and the new object is used as the value of the invocation.

Indirect Invocation

JavaScript functions are objects and like all JavaScript objects, they have methods. Two of these methods, call() and apply(), invoke the function indirectly. Both methods allow you to explicitly specify the this value for the invocation, which means you can invoke any function as a method of any object, even if it is not actually a method of that object. Both methods also allow you to specify the arguments for the invocation. The call() method uses its own argument list as arguments to the function and the apply() method expects an array of values to be used as arguments. The call() and apply() methods are described in detail in The call() and apply() Methods.

* * *

[11] The term was coined by Martin Fowler. See http://martinfowler.com/dslwip/MethodChaining.html.

Function Arguments and Parameters

JavaScript function definitions do not specify an expected type for the function parameters, and function invocations do not do any type checking on the argument values you pass. In fact, JavaScript function invocations do not even check the number of arguments being passed. The subsections that follow describe what happens when a function is invoked with fewer arguments than declared parameters or with more arguments than declared parameters. They also demonstrate how you can explicitly test the type of function arguments if you need to ensure that a function is not invoked with inappropriate arguments.

Optional Parameters

When a function is invoked with fewer arguments than declared parameters, the additional parameters are set to the undefined value. It is often useful to write functions so that some arguments are optional and may be omitted when the function is invoked. To do this, you must be able to assign a reasonable default value to parameters that are omitted. Here is an example:

// Append the names of the enumerable properties of object o to the // array a, and return a. If a is omitted, create and return a new array. function getPropertyNames(o, /* optional */ a) { if (a === undefined) a = []; // If undefined, use a new array for(var property in o) a.push(property); return a; } // This function can be invoked with 1 or 2 arguments: var a = getPropertyNames(o); // Get o's properties into a new array getPropertyNames(p,a); // append p's properties to that array

Instead of using an if statement in the first line of this function, you can use the || operator in this idiomatic way:

a = a || [];

Recall from Logical OR (||) that the || operator returns its first argument if that argument is truthy and otherwise returns its second argument. In this case, if any object is passed as the second argument, the function will use that object. But if the second argument is omitted (or null or another falsy value is passed), a newly created empty array will be used instead.

Note that when designing functions with optional arguments, you should be sure to put the optional ones at the end of the argument list so that they can be omitted. The programmer who calls your function cannot omit the first argument and pass the second: she would have to explicitly pass undefined the first argument. Also note the use of the comment /* optional */ in the function definition to emphasize the fact that the parameter is optional.

Variable-Length Argument Lists: The Arguments Object

When a function is invoked with more argument values than there are parameter names, there is no way to directly refer to the unnamed values. The Arguments object provides a solution to this problem. Within the body of a function, the identifier arguments refers to the Arguments object for that invocation. The Arguments object is an array-like object (see Array-Like Objects) that allows the argument values passed to the function to be retrieved by number, rather than by name.

Suppose you define a function f that expects to be passed one argument, x. If you invoke this function with two arguments, the first argument is accessible within the function by the parameter name x or as arguments[0]. The second argument is accessible only as arguments[1]. Furthermore, like true arrays, arguments has a length property that specifies the number of elements it contains. Thus, within the body of the function f, invoked with two arguments, arguments.length has the value 2.

The Arguments object is useful in a number of ways. The following example shows how you can use it to verify that a function is invoked with the expected number of arguments, since JavaScript doesn’t do this for you:

function f(x, y, z) { // First, verify that the right number of arguments was passed if (arguments.length != 3) { throw new Error("function f called with " + arguments.length + "arguments, but it expects 3 arguments."); } // Now do the actual function... }

Note that it is often unnecessary to check the number of arguments like this. JavaScript’s default behavior is fine in most cases: missing arguments are undefined and extra arguments are simply ignored.

One important use of the Arguments object is to write functions that operate on any number of arguments. The following function accepts any number of numeric arguments and returns the value of the largest argument it is passed (see also the built-in function Math.max(), which behaves the same way):

function max(/* ... */) { var max = Number.NEGATIVE_INFINITY; // Loop through the arguments, looking for, and remembering, the biggest. for(var i = 0; i < arguments.length; i++) if (arguments[i] > max) max = arguments[i]; // Return the biggest return max; } var largest = max(1, 10, 100, 2, 3, 1000, 4, 5, 10000, 6); // => 10000

Functions like this one that can accept any number of arguments are called variadic functions, variable arity functions, or varargs functions. This book uses the most colloquial term, varargs, which dates to the early days of the C programming language.

Note that varargs functions need not allow invocations with zero arguments. It is perfectly reasonable to use the arguments[] object to write functions that expect some fixed number of named and required arguments followed by an arbitrary number of unnamed optional arguments.

Remember that arguments is not really an array; it is an Arguments object. Each Arguments object defines numbered array elements and a length property, but it is not technically an array; it is better to think of it as an object that happens to have some numbered properties. See Array-Like Objects for more on array-like objects.

The Arguments object has one very unusual feature. In non-strict mode, when a function has named parameters, the array elements of the Arguments object are aliases for the parameters that hold the function arguments. The numbered elements of the Arguments object and the parameter names are like two different names for the same variable. Changing the value of an argument with an argument name changes the value that is retrieved through the arguments[] array. Conversely, changing the value of an argument through the arguments[] array changes the value that is retrieved by the argument name. Here is an example that clarifies this:

function f(x) { console.log(x); // Displays the initial value of the argument arguments[0] = null; // Changing the array element also changes x! console.log(x); // Now displays "null" }

This is emphatically not the behavior you would see if the Arguments object were an ordinary array. In that case, arguments[0] and x could refer initially to the same value, but a change to one would have no effect on the other.

This special behavior of the Arguments object has been removed in the strict mode of ECMAScript 5. There are other strict-mode differences as well. In non-strict functions, arguments is just an identifier. In strict mode, it is effectively a reserved word. Strict-mode functions cannot use arguments as a parameter name or as a local variable name, and they cannot assign values to arguments.

The callee and caller properties

In addition to its array elements, the Arguments object defines callee and caller properties. In ECMAScript 5 strict mode, these properties are guaranteed to raise a TypeError if you try to read or write them. Outside of strict mode, however, the ECMAScript standard says that the callee property refers to the currently running function. caller is a nonstandard but commonly implemented property that refers to the function that called this one. The caller property gives access to the call stack, and the callee property is occasionally useful to allow unnamed functions to call themselves recursively:

var factorial = function(x) { if (x <= 1) return 1; return x * arguments.callee(x-1); };

Using Object Properties As Arguments

When a function has more than three parameters, it becomes difficult for the programmer who invokes the function to remember the correct order in which to pass arguments. To save the programmer the trouble of consulting the documentation each time she uses the function, it can be nice to allow arguments to be passed as name/value pairs in any order. To implement this style of method invocation, define your function to expect a single object as its argument and then have users of the function pass an object that defines the required name/value pairs. The following code gives an example and also demonstrates that this style of function invocation allows the function to specify defaults for any arguments that are omitted:

// Copy length elements of the array from to the array to. // Begin copying with element from_start in the from array // and copy that element to to_start in the to array. // It is hard to remember the order of the arguments. function arraycopy(/* array */ from, /* index */ from_start, /* array */ to, /* index */ to_start, /* integer */ length) { // code goes here } // This version is a little less efficient, but you don't have to // remember the order of the arguments, and from_start and to_start // default to 0. function easycopy(args) { arraycopy(args.from, args.from_start || 0, // Note default value provided args.to, args.to_start || 0, args.length); } // Here is how you might invoke easycopy(): var a = [1,2,3,4], b = []; easycopy({from: a, to: b, length: 4});

Argument Types

JavaScript method parameters have no declared types, and no type checking is performed on the values you pass to a function. You can help to make your code self-documenting by choosing descriptive names for function arguments and also by including argument types in comments, as in the arraycopy() method just shown. For arguments that are optional, you can include the word「optional」in the comment. And when a method can accept any number of arguments, you can use an ellipsis:

function max(/* number... */) { /* code here */ }

As described in Type Conversions, JavaScript performs liberal type conversion as needed. So if you write a function that expects a string argument and then call that function with a value of some other type, the value you passed will simply be converted to a string when the function tries to use it as a string. All primitive types can be converted to strings, and all objects have toString() methods (if not necessarily useful ones), so an error never occurs in this case.

This is not always true, however. Consider again the arraycopy() method shown earlier. It expects an array as its first argument. Any plausible implementation will fail if that first argument is anything but an array (or possibly an array-like object). Unless you are writing a「throwaway」function that will be called only once or twice, it may be worth adding code to check the types of arguments like this. It is better for a function to fail immediately and predictably when passed bad values than to begin executing and fail later with an error message that is likely to be unclear. Here is an example function that performs type-checking. Note that it uses the isArrayLike() function from Array-Like Objects:

// Return the sum of the elements of array (or array-like object) a. // The elements of a must all be numbers or null and undefined are ignored. function sum(a) { if (isArrayLike(a)) { var total = 0; for(var i = 0; i < a.length; i++) { // Loop though all elements var element = a[i]; if (element == null) continue; // Skip null and undefined if (isFinite(element)) total += element; else throw new Error("sum(): elements must be finite numbers"); } return total; } else throw new Error("sum(): argument must be array-like"); }

This sum() method is fairly strict about the argument it accepts and throws suitably informative errors if it is passed bad values. It does offer a bit of flexibility, however, by working with array-like objects as well as true arrays and by ignoring null and undefined array elements.

JavaScript is a very flexible and loosely typed language, and sometimes it is appropriate to write functions that are flexible about the number and type of arguments they are passed. The following flexisum() method takes this approach (probably to an extreme). For example, it accepts any number of arguments but recursively processes any arguments that are arrays. In this way, it can be used as a varargs method or with an array argument. Furthermore, it tries its best to convert nonnumeric values to numbers before throwing an error:

function flexisum(a) { var total = 0; for(var i = 0; i < arguments.length; i++) { var element = arguments[i], n; if (element == null) continue; // Ignore null and undefined arguments if (isArray(element)) // If the argument is an array n = flexisum.apply(this, element); // compute its sum recursively else if (typeof element === "function") // Else if it's a function... n = Number(element()); // invoke it and convert. else n = Number(element); // Else try to convert it if (isNaN(n)) // If we couldn't convert to a number, throw an error throw Error("flexisum(): can't convert " + element + " to number"); total += n; // Otherwise, add n to the total } return total; }

Functions As Values

The most important features of functions are that they can be defined and invoked. Function definition and invocation are syntactic features of JavaScript and of most other programming languages. In JavaScript, however, functions are not only syntax but also values, which means they can be assigned to variables, stored in the properties of objects or the elements of arrays, passed as arguments to functions, and so on.[12]

To understand how functions can be JavaScript data as well as JavaScript syntax, consider this function definition:

function square(x) { return x*x; }

This definition creates a new function object and assigns it to the variable square. The name of a function is really immaterial; it is simply the name of a variable that refers to the function object. The function can be assigned to another variable and still work the same way:

var s = square; // Now s refers to the same function that square does square(4); // => 16 s(4); // => 16

Functions can also be assigned to object properties rather than variables. When you do this, they’re called methods:

var o = {square: function(x) { return x*x; }}; // An object literal var y = o.square(16); // y equals 256

Functions don’t even require names at all, as when they’re assigned to array elements:

var a = [function(x) { return x*x; }, 20]; // An array literal a[0](a[1]); // => 400

The syntax of this last example looks strange, but it is still a legal function invocation expression!

Example 8-2 demonstrates the kinds of things that can be done when functions are used as values. This example may be a little tricky, but the comments explain what is going on.

Example 8-2. Using functions as data

// We define some simple functions here function add(x,y) { return x + y; } function subtract(x,y) { return x - y; } function multiply(x,y) { return x * y; } function divide(x,y) { return x / y; } // Here's a function that takes one of the above functions // as an argument and invokes it on two operands function operate(operator, operand1, operand2) { return operator(operand1, operand2); } // We could invoke this function like this to compute the value (2+3) + (4*5): var i = operate(add, operate(add, 2, 3), operate(multiply, 4, 5)); // For the sake of the example, we implement the simple functions again, // this time using function literals within an object literal; var operators = { add: function(x,y) { return x+y; }, subtract: function(x,y) { return x-y; }, multiply: function(x,y) { return x*y; }, divide: function(x,y) { return x/y; }, pow: Math.pow // Works for predefined functions too }; // This function takes the name of an operator, looks up that operator // in the object, and then invokes it on the supplied operands. Note // the syntax used to invoke the operator function. function operate2(operation, operand1, operand2) { if (typeof operators[operation] === "function") return operators[operation](operand1, operand2); else throw "unknown operator"; } // Compute the value ("hello" + " " + "world") like this: var j = operate2("add", "hello", operate2("add", " ", "world")); // Using the predefined Math.pow() function: var k = operate2("pow", 10, 2);

As another example of functions as values, consider the Array.sort() method. This method sorts the elements of an array. Because there are many possible orders to sort by (numerical order, alphabetical order, date order, ascending, descending, and so on), the sort() method optionally takes a function as an argument to tell it how to perform the sort. This function has a simple job: for any two values it is passed, it returns a value that specifies which element would come first in a sorted array. This function argument makes Array.sort() perfectly general and infinitely flexible; it can sort any type of data into any conceivable order. Examples are shown in sort().

Defining Your Own Function Properties

Functions are not primitive values in JavaScript, but a specialized kind of object, which means that functions can have properties. When a function needs a「static」variable whose value persists across invocations, it is often convenient to use a property of the function, instead of cluttering up the namespace by defining a global variable. For example, suppose you want to write a function that returns a unique integer whenever it is invoked. The function must never return the same value twice. In order to manage this, the function needs to keep track of the values it has already returned, and this information must persist across function invocations. You could store this information in a global variable, but that is unnecessary, because the information is used only by the function itself. It is better to store the information in a property of the Function object. Here is an example that returns a unique integer whenever it is called:

// Initialize the counter property of the function object. // Function declarations are hoisted so we really can // do this assignment before the function declaration. uniqueInteger.counter = 0; // This function returns a different integer each time it is called. // It uses a property of itself to remember the next value to be returned. function uniqueInteger() { return uniqueInteger.counter++; // Increment and return counter property }

As another example, consider the following factorial() function that uses properties of itself (treating itself as an array) to cache previously computed results:

// Compute factorials and cache results as properties of the function itself. function factorial(n) { if (isFinite(n) && n>0 && n==Math.round(n)) { // Finite, positive ints only if (!(n in factorial)) // If no cached result factorial[n] = n * factorial(n-1); // Compute and cache it return factorial[n]; // Return the cached result } else return NaN; // If input was bad } factorial[1] = 1; // Initialize the cache to hold this base case.

* * *

[12] This may not seem like a particularly interesting point unless you are familiar with languages such as Java, in which functions are part of a program but cannot be manipulated by the program.

Functions As Namespaces

Recall from Function Scope and Hoisting that JavaScript has function scope: variables declared within a function are visible throughout the function (including within nested functions) but do not exist outside of the function. Variables declared outside of a function are global variables and are visible throughout your JavaScript program. JavaScript does not define any way to declare variables that are hidden within a single block of code, and for this reason, it is sometimes useful to define a function simply to act as a temporary namespace in which you can define variables without polluting the global namespace.

Suppose, for example, you have a module of JavaScript code that you want to use in a number of different JavaScript programs (or, for client-side JavaScript, on a number of different web pages). Assume that this code, like most code, defines variables to store the intermediate results of its computation. The problem is that since this module will be used in many different programs, you don’t know whether the variables it creates will conflict with variables used by the programs that import it. The solution, of course, is to put the code into a function and then invoke the function. This way, variables that would have been global become local to the function:

function mymodule() { // Module code goes here. // Any variables used by the module are local to this function // instead of cluttering up the global namespace. } mymodule(); // But don't forget to invoke the function!

This code defines only a single global variable: the function name「mymodule」. If defining even a single property is too much, you can define and invoke an anonymous function in a single expression:

(function() { // mymodule function rewritten as an unnamed expression // Module code goes here. }()); // end the function literal and invoke it now.

This technique of defining and invoking a function in a single expression is used frequently enough that it has become idiomatic. Note the use of parentheses in the code above. The open parenthesis before function is required because without it, the JavaScript interpreter tries to parse the function keyword as a function declaration statement. With the parenthesis, the interpreter correctly recognizes this as a function definition expression. It is idiomatic to use the parentheses, even when they are not required, around a function that is to be invoked immediately after being defined.

Example 8-3 demonstrates this namespace technique. It defines an anonymous function that returns an extend() function like the one shown in Example 6-2. The code in the anonymous function tests whether a well-known Internet Explorer bug is present and, if so, returns a patched version of the function. In addition, the anonymous function’s namespace serves to hide an array of property names.

Example 8-3. The extend() function, patched if necessary

// Define an extend function that copies the properties of its second and // subsequent arguments onto its first argument. // We work around an IE bug here: in many versions of IE, the for/in loop // won't enumerate an enumerable property of o if the prototype of o has // a nonenumerable property by the same name. This means that properties // like toString are not handled correctly unless we explicitly check for them. var extend = (function() { // Assign the return value of this function // First check for the presence of the bug before patching it. for(var p in {toString:null}) { // If we get here, then the for/in loop works correctly and we return // a simple version of the extend() function return function extend(o) { for(var i = 1; i < arguments.length; i++) { var source = arguments[i]; for(var prop in source) o[prop] = source[prop]; } return o; }; } // If we get here, it means that the for/in loop did not enumerate // the toString property of the test object. So return a version // of the extend() function that explicitly tests for the nonenumerable // properties of Object.prototype. return function patched_extend(o) { for(var i = 1; i < arguments.length; i++) { var source = arguments[i]; // Copy all the enumerable properties for(var prop in source) o[prop] = source[prop]; // And now check the special-case properties for(var j = 0; j < protoprops.length; j++) { prop = protoprops[j]; if (source.hasOwnProperty(prop)) o[prop] = source[prop]; } } return o; }; // This is the list of special-case properties we check for var protoprops = ["toString", "valueOf", "constructor", "hasOwnProperty", "isPrototypeOf", "propertyIsEnumerable","toLocaleString"]; }());

Closures

Like most modern programming languages, JavaScript uses lexical scoping. This means that functions are executed using the variable scope that was in effect when they were defined, not the variable scope that is in effect when they are invoked. In order to implement lexical scoping, the internal state of a JavaScript function object must include not only the code of the function but also a reference to the current scope chain. (Before reading the rest of this section, you may want to review the material on variable scope and the scope chain in Variable Scope and The Scope Chain.) This combination of a function object and a scope (a set of variable bindings) in which the function’s variables are resolved is called a closure in the computer science literature.[13]

Technically, all JavaScript functions are closures: they are objects, and they have a scope chain associated with them. Most functions are invoked using the same scope chain that was in effect when the function was defined, and it doesn’t really matter that there is a closure involved. Closures become interesting when they are invoked under a different scope chain than the one that was in effect when they were defined. This happens most commonly when a nested function object is returned from the function within which it was defined. There are a number of powerful programming techniques that involve this kind of nested function closures, and their use has become relatively common in JavaScript programming. Closures may seem confusing when you first encounter them, but it is important that you understand them well enough to use them comfortably.

The first step to understanding closures is to review the lexical scoping rules for nested functions. Consider the following code (which is similar to code you’ve already seen in Variable Scope):

var scope = "global scope"; // A global variable function checkscope() { var scope = "local scope"; // A local variable function f() { return scope; } // Return the value in scope here return f(); } checkscope() // => "local scope"

The checkscope() function declares a local variable and then defines and invokes a function that returns the value of that variable. It should be clear to you why the call to checkscope() returns「local scope」. Now let’s change the code just slightly. Can you tell what this code will return?

var scope = "global scope"; // A global variable function checkscope() { var scope = "local scope"; // A local variable function f() { return scope; } // Return the value in scope here return f; } checkscope()() // What does this return?

In this code, a pair of parentheses has moved from inside checkscope() to outside of it. Instead of invoking the nested function and returning its result, checkscope() now just returns the nested function object itself. What happens when we invoke that nested function (with the second pair of parentheses in the last line of code) outside of the function in which it was defined?

Remember the fundamental rule of lexical scoping: JavaScript functions are executed using the scope chain that was in effect when they were defined. The nested function f() was defined under a scope chain in which the variable scope was bound to the value「local scope」. That binding is still in effect when f is executed, wherever it is executed from. So the last line of code above returns「local scope」, not「global scope」. This, in a nutshell, is the surprising and powerful nature of closures: they capture the local variable (and parameter) bindings of the outer function within which they are defined.

Implementing Closures

Closures are easy to understand if you simply accept the lexical scoping rule: functions are executed using the scope chain that was in effect when they were defined. Some programmers find closures confusing, however, because they get caught up in implementation details. Surely, they think, the local variables defined in the outer function cease to exist when the outer function returns, so how can the nested function execute using a scope chain that does not exist anymore? If you’re wondering about this yourself, then you have probably been exposed to low-level programming languages like C and to stack-based CPU architectures: if a function’s local variables are defined on a CPU stack, then they would indeed cease to exist when the function returned.

But remember our definition of scope chain from The Scope Chain. We described it as a list of objects, not a stack of bindings. Each time a JavaScript function is invoked, a new object is created to hold the local variables for that invocation, and that object is added to the scope chain. When the function returns, that variable binding object is removed from the scope chain. If there were no nested functions, there are no more references to the binding object and it gets garbage collected. If there were nested functions defined, then each of those functions has a reference to the scope chain, and that scope chain refers to the variable binding object. If those nested functions objects remained within their outer function, however, then they themselves will be garbage collected, along with the variable binding object they referred to. But if the function defines a nested function and returns it or stores it into a property somewhere, then there will be an external reference to the nested function. It won’t be garbage collected, and the variable binding object it refers to won’t be garbage collected either.

In Defining Your Own Function Properties we defined a uniqueInteger() function that used a property of the function itself to keep track of the next value to be returned. A shortcoming of that approach is that buggy or malicious code could reset the counter or set it to a noninteger, causing the uniqueInteger() function to violate the「unique」or the「integer」part of its contract. Closures capture the local variables of a single function invocation and can use those variables as private state. Here is how we could rewrite the uniqueInteger() function using closures:

var uniqueInteger = (function() { // Define and invoke var counter = 0; // Private state of function below return function() { return counter++; }; }());

In order to understand this code, you have to read it carefully. At first glance, the first line of code looks like it is assigning a function to the variable uniqueInteger. In fact, the code is defining and invoking (as hinted by the open parenthesis on the first line) a function, so it is the return value of the function that is being assigned to uniqueInteger. Now, if we study the body of the function, we see that its return value is another function. It is this nested function object that gets assigned to uniqueInteger. The nested function has access to the variables in scope, and can use the counter variable defined in the outer function. Once that outer function returns, no other code can see the counter variable: the inner function has exclusive access to it.

Private variables like counter need not be exclusive to a single closure: it is perfectly possible for two or more nested functions to be defined within the same outer function and share the same scope chain. Consider the following code:

function counter() { var n = 0; return { count: function() { return n++; }, reset: function() { n = 0; } }; } var c = counter(), d = counter(); // Create two counters c.count() // => 0 d.count() // => 0: they count independently c.reset() // reset() and count() methods share state c.count() // => 0: because we reset c d.count() // => 1: d was not reset

The counter() function returns a「counter」object. This object has two methods: count() returns the next integer, and reset() resets the internal state. The first thing to understand is that the two methods share access to the private variable n. The second thing to understand is that each invocation of counter() creates a new scope chain and a new private variable. So if you call counter() twice, you get two counter objects with different private variables. Calling count() or reset() on one counter object has no effect on the other.

It is worth noting here that you can combine this closure technique with property getters and setters. The following version of the counter() function is a variation on code that appeared in Property Getters and Setters, but it uses closures for private state rather than relying on a regular object property:

function counter(n) { // Function argument n is the private variable return { // Property getter method returns and increments private counter var. get count() { return n++; }, // Property setter doesn't allow the value of n to decrease set count(m) { 	 if (m >= n) n = m; 	 else throw Error("count can only be set to a larger value"); } }; } var c = counter(1000); c.count // => 1000 c.count // => 1001 c.count = 2000 c.count // => 2000 c.count = 2000 // => Error!

Note that this version of the counter() function does not declare a local variable, but just uses its parameter n to hold the private state shared by the property accessor methods. This allows the caller of counter() to specify the initial value of the private variable.

Example 8-4 is a generalization of the shared private state through closures technique we’ve been demonstrating here. This example defines an addPrivateProperty() function that defines a private variable and two nested functions to get and set the value of that variable. It adds these nested functions as methods of the object you specify:

Example 8-4. Private property accessor methods using closures

// This function adds property accessor methods for a property with // the specified name to the object o. The methods are named get<name> // and set<name>. If a predicate function is supplied, the setter // method uses it to test its argument for validity before storing it. // If the predicate returns false, the setter method throws an exception. // // The unusual thing about this function is that the property value // that is manipulated by the getter and setter methods is not stored in // the object o. Instead, the value is stored only in a local variable // in this function. The getter and setter methods are also defined // locally to this function and therefore have access to this local variable. // This means that the value is private to the two accessor methods, and it // cannot be set or modified except through the setter method. function addPrivateProperty(o, name, predicate) { var value; // This is the property value // The getter method simply returns the value. o["get" + name] = function() { return value; }; // The setter method stores the value or throws an exception if // the predicate rejects the value. o["set" + name] = function(v) { if (predicate && !predicate(v)) throw Error("set" + name + ": invalid value " + v); else value = v; }; } // The following code demonstrates the addPrivateProperty() method. var o = {}; // Here is an empty object // Add property accessor methods getName and setName() // Ensure that only string values are allowed addPrivateProperty(o, "Name", function(x) { return typeof x == "string"; }); o.setName("Frank"); // Set the property value console.log(o.getName()); // Get the property value o.setName(0); // Try to set a value of the wrong type

We’ve now seen a number of examples in which two closures are defined in the same scope chain and share access to the same private variable or variables. This is an important technique, but it is just as important to recognize when closures inadvertently share access to a variable that they should not share. Consider the following code:

// This function returns a function that always returns v function constfunc(v) { return function() { return v; }; } // Create an array of constant functions: var funcs = []; for(var i = 0; i < 10; i++) funcs[i] = constfunc(i); // The function at array element 5 returns the value 5. funcs[5]() // => 5

When working with code like this that creates multiple closures using a loop, it is a common error to try to move the loop within the function that defines the closures. Think about the following code, for example:

// Return an array of functions that return the values 0-9 function constfuncs() { var funcs = []; for(var i = 0; i < 10; i++) funcs[i] = function() { return i; }; return funcs; } var funcs = constfuncs(); funcs[5]() // What does this return?

The code above creates 10 closures, and stores them in an array. The closures are all defined within the same invocation of the function, so they share access to the variable i. When constfuncs() returns, the value of the variable i is 10, and all 10 closures share this value. Therefore, all the functions in the returned array of functions return the same value, which is not what we wanted at all. It is important to remember that the scope chain associated with a closure is「live.」Nested functions do not make private copies of the scope or make static snapshots of the variable bindings.

Another thing to remember when writing closures is that this is a JavaScript keyword, not a variable. As discussed earlier, every function invocation has a this value, and a closure cannot access the this value of its outer function unless the outer function has saved that value into a variable:

var self = this; // Save this value in a variable for use by nested funcs.

The arguments binding is similar. This is not a language keyword, but it is automatically declared for every function invocation. Since a closure has its own binding for arguments, it cannot access the outer function’s arguments array unless the outer function has saved that array into a variable by a different name:

var outerArguments = arguments; // Save for use by nested functions

Example 8-5, later in this chapter, defines a closure that uses these techniques to refer to both the this and arguments values of the outer function.

* * *

[13] This is an old term that refers to the fact that the function’s variables have bindings in the scope chain and that therefore the function is「closed over」its variables.

Function Properties, Methods, and Constructor

We’ve seen that functions are values in JavaScript programs. The typeof operator returns the string「function」when applied to a function, but functions are really a specialized kind of JavaScript object. Since functions are objects, they can have properties and methods, just like any other object. There is even a Function() constructor to create new function objects. The subsections that follow document function properties and methods and the Function() constructor. You can also read about these in the reference section.

The length Property

Within the body of a function, arguments.length specifies the number of arguments that were passed to the function. The length property of a function itself, however, has a different meaning. This read-only property returns the arity of the function—the number of parameters it declares in its parameter list, which is usually the number of arguments that the function expects.

The following code defines a function named check() that is passed the arguments array from another function. It compares arguments.length (the number of arguments actually passed) to arguments.callee.length (the number expected) to determine whether the function was passed the right number of arguments. If not, it throws an exception. The check() function is followed by a test function f() that demonstrates how check() can be used:

// This function uses arguments.callee, so it won't work in strict mode. function check(args) { var actual = args.length; // The actual number of arguments var expected = args.callee.length; // The expected number of arguments if (actual !== expected) // Throw an exception if they differ. throw Error("Expected " + expected + "args; got " + actual); } function f(x, y, z) { check(arguments); // Check that the actual # of args matches expected #. return x + y + z; // Now do the rest of the function normally. }

The prototype Property

Every function has a prototype property that refers to an object known as the prototype object. Every function has a different prototype object. When a function is used as a constructor, the newly created object inherits properties from the prototype object. Prototypes and the prototype property were discussed in Prototypes and will be covered again in Chapter 9.

The call() and apply() Methods

call() and apply() allow you to indirectly invoke (Indirect Invocation) a function as if it were a method of some other object. (We used the call() method in Example 6-4 to invoke Object.prototype.toString on an object whose class we wanted to determine, for example.) The first argument to both call() and apply() is the object on which the function is to be invoked; this argument is the invocation context and becomes the value of the this keyword within the body of the function. To invoke the function f() as a method of the object o (passing no arguments), you could use either call() or apply():

f.call(o); f.apply(o);

Either of the lines of code above are similar to the following (which assume that o does not already have a property named m):

o.m = f; // Make f a temporary method of o. o.m(); // Invoke it, passing no arguments. delete o.m; // Remove the temporary method.

In ECMAScript 5 strict mode the first argument to call() or apply() becomes the value of this, even if it is a primitive value or null or undefined. In ECMAScript 3 and non-strict mode, a value of null or undefined is replaced with the global object and a primitive value is replaced with the corresponding wrapper object.

Any arguments to call() after the first invocation context argument are the values that are passed to the function that is invoked. For example, to pass two numbers to the function f() and invoke it as if it were a method of the object o, you could use code like this:

f.call(o, 1, 2);

The apply() method is like the call() method, except that the arguments to be passed to the function are specified as an array:

f.apply(o, [1,2]);

If a function is defined to accept an arbitrary number of arguments, the apply() method allows you to invoke that function on the contents of an array of arbitrary length. For example, to find the largest number in an array of numbers, you could use the apply() method to pass the elements of the array to the Math.max() function:

var biggest = Math.max.apply(Math, array_of_numbers);

Note that apply() works with array-like objects as well as true arrays. In particular, you can invoke a function with the same arguments as the current function by passing the arguments array directly to apply(). The following code demonstrates:

// Replace the method named m of the object o with a version that logs // messages before and after invoking the original method. function trace(o, m) { var original = o[m]; // Remember original method in the closure. o[m] = function() { // Now define the new method. console.log(new Date(), "Entering:", m); // Log message. var result = original.apply(this, arguments); // Invoke original. console.log(new Date(), "Exiting:", m); // Log message. return result; // Return result. }; }

This trace() function is passed an object and a method name. It replaces the specified method with a new method that「wraps」additional functionality around the original method. This kind of dynamic alteration of existing methods is sometimes called「monkey-patching.」

The bind() Method

The bind() method was added in ECMAScript 5, but it is easy to simulate in ECMAScript 3. As its name implies, the primary purpose of bind() is to bind a function to an object. When you invoke the bind() method on a function f and pass an object o, the method returns a new function. Invoking the new function (as a function) invokes the original function f as a method of o. Any arguments you pass to the new function are passed to the original function. For example:

function f(y) { return this.x + y; } // This function needs to be bound var o = { x : 1 }; // An object we'll bind to var g = f.bind(o); // Calling g(x) invokes o.f(x) g(2) // => 3

It is easy to accomplish this kind of binding with code like the following:

// Return a function that invokes f as a method of o, passing all its arguments. function bind(f, o) { if (f.bind) return f.bind(o); // Use the bind method, if there is one else return function() { // Otherwise, bind it like this return f.apply(o, arguments); }; }

The ECMAScript 5 bind() method does more than just bind a function to an object. It also performs partial application: any arguments you pass to bind() after the first are bound along with the this value. Partial application is a common technique in functional programming and is sometimes called currying. Here are some examples of the bind() method used for partial application:

var sum = function(x,y) { return x + y }; // Return the sum of 2 args // Create a new function like sum, but with the this value bound to null // and the 1st argument bound to 1. This new function expects just one arg. var succ = sum.bind(null, 1); succ(2) // => 3: x is bound to 1, and we pass 2 for the y argument function f(y,z) { return this.x + y + z }; // Another function that adds var g = f.bind({x:1}, 2); // Bind this and y g(3) // => 6: this.x is bound to 1, y is bound to 2 and z is 3

We can bind the this value and perform partial application in ECMAScript 3. The standard bind() method can be simulated with code like that shown in Example 8-5. Note that we save this method as Function.prototype.bind, so that all function objects inherit it. This technique is explained in detail in Augmenting Classes.

Example 8-5. A Function.bind() method for ECMAScript 3

if (!Function.prototype.bind) { Function.prototype.bind = function(o /*, args */) { // Save the this and arguments values into variables so we can // use them in the nested function below. var self = this, boundArgs = arguments; // The return value of the bind() method is a function return function() { // Build up an argument list, starting with any args passed // to bind after the first one, and follow those with all args // passed to this function. var args = [], i; for(i = 1; i < boundArgs.length; i++) args.push(boundArgs[i]); for(i = 0; i < arguments.length; i++) args.push(arguments[i]); // Now invoke self as a method of o, with those arguments return self.apply(o, args); }; }; }

Notice that the function returned by this bind() method is a closure that uses the variables self and boundArgs declared in the outer function, even though that inner function has been returned from the outer function and is invoked after the outer function has returned.

The bind() method defined by ECMAScript 5 does have some features that cannot be simulated with the ECMAScript 3 code shown above. First, the true bind() method returns a function object with its length property properly set to the arity of the bound function minus the number of bound arguments (but not less than zero). Second, the ECMAScript 5 bind() method can be used for partial application of constructor functions. If the function returned by bind() is used as a constructor, the this passed to bind() is ignored, and the original function is invoked as a constructor, with some arguments already bound. Functions returned by the bind() method do not have a prototype property (the prototype property of regular functions cannot be deleted) and objects created when these bound functions are used as constructors inherit from the prototype of the original, unbound constructor. Also, a bound constructor works just like the unbound constructor for the purposes of the instanceof operator.

The toString() Method

Like all JavaScript objects, functions have a toString() method. The ECMAScript spec requires this method to return a string that follows the syntax of the function declaration statement. In practice most (but not all) implementations of this toString() method return the complete source code for the function. Built-in functions typically return a string that includes something like「[native code]」as the function body.

The Function() Constructor

Functions are usually defined using the function keyword, either in the form of a function definition statement or a function literal expression. But functions can also be defined with the Function() constructor. For example:

var f = new Function("x", "y", "return x*y;");

This line of code creates a new function that is more or less equivalent to a function defined with the familiar syntax:

var f = function(x, y) { return x*y; }

The Function() constructor expects any number of string arguments. The last argument is the text of the function body; it can contain arbitrary JavaScript statements, separated from each other by semicolons. All other arguments to the constructor are strings that specify the parameters names for the function. If you are defining a function that takes no arguments, you simply pass a single string—the function body—to the constructor.

Notice that the Function() constructor is not passed any argument that specifies a name for the function it creates. Like function literals, the Function() constructor creates anonymous functions.

There are a few points that are important to understand about the Function() constructor:

The Function() constructor allows JavaScript functions to be dynamically created and compiled at runtime.

The Function() constructor parses the function body and creates a new function object each time it is called. If the call to the constructor appears within a loop or within a frequently called function, this process can be inefficient. By contrast, nested functions and function definition expressions that appear within loops are not recompiled each time they are encountered.

A last, very important point about the Function() constructor is that the functions it creates do not use lexical scoping; instead, they are always compiled as if they were top-level functions, as the following code demonstrates:

var scope = "global"; function constructFunction() { var scope = "local"; return new Function("return scope"); // Does not capture the local scope! } // This line returns "global" because the function returned by the // Function() constructor does not use the local scope. constructFunction()(); // => "global"

The Function() constructor is best thought of as a globally-scoped version of eval() (see Global eval()) that defines new variables and functions in its own private scope. You should rarely need to use this constructor in your code.

Callable Objects

We learned in Array-Like Objects that there are「array-like」objects that are not true arrays but can be treated like arrays for most purposes. A similar situation exists for functions. A callable object is any object that can be invoked in a function invocation expression. All functions are callable, but not all callable objects are functions.

Callable objects that are not functions are encountered in two situations in today’s JavaScript implementations. First, the IE web browser (version 8 and before) implements client-side methods such as Window.alert() and Document.getElementsById() using callable host objects rather than native Function objects. These methods work the same in IE as they do in other browsers, but they are not actually Function objects. IE9 switches to using true functions, so this kind of callable object will gradually become less common.

The other common form of callable objects are RegExp objects—in many browsers, you can invoke a RegExp object directly as a shortcut for invoking its exec() method. This is a completely nonstandard feature of JavaScript that was introduced by Netscape and copied by other vendors for compatibility. Do not write code that relies on the callability of RegExp objects: this feature is likely to be deprecated and removed in the future. The typeof operator is not interoperable for callable RegExps. In some browsers it returns「function」and in others it returns「object」.

If you want to determine whether an object is a true function object (and has function methods) you can test its class attribute (The class Attribute) using the technique shown in Example 6-4:

function isFunction(x) { return Object.prototype.toString.call(x) === "[object Function]"; }

Note that this isFunction() function is quite similar to the isArray() function shown in Array Type.

Functional Programming

JavaScript is not a functional programming language like Lisp or Haskell, but the fact that JavaScript can manipulate functions as objects means that we can use functional programming techniques in JavaScript. The ECMAScript 5 array methods such as map() and reduce() lend themselves particularly well to a functional programming style. The sections that follow demonstrate techniques for functional programming in JavaScript. They are intended as a mind-expanding exploration of the power of JavaScript’s functions, not as a prescription for good programming style.[14]

Processing Arrays with Functions

Suppose we have an array of numbers and we want to compute the mean and standard deviation of those values. We might do that in nonfunctional style like this:

var data = [1,1,3,5,5]; // This is our array of numbers // The mean is the sum of the elements divided by the number of elements var total = 0; for(var i = 0; i < data.length; i++) total += data[i]; var mean = total/data.length; // The mean of our data is 3 // To compute the standard deviation, we first sum the squares of // the deviation of each element from the mean. total = 0; for(var i = 0; i < data.length; i++) { var deviation = data[i] - mean; total += deviation * deviation; } var stddev = Math.sqrt(total/(data.length-1)); // The standard deviation is 2

We can perform these same computations in concise functional style using the array methods map() and reduce() like this (see ECMAScript 5 Array Methods to review these methods):

// First, define two simple functions var sum = function(x,y) { return x+y; }; var square = function(x) { return x*x; }; // Then use those functions with Array methods to compute mean and stddev var data = [1,1,3,5,5]; var mean = data.reduce(sum)/data.length; var deviations = data.map(function(x) {return x-mean;}); var stddev = Math.sqrt(deviations.map(square).reduce(sum)/(data.length-1));

What if we’re using ECMAScript 3 and don’t have access to these newer array methods? We can define our own map() and reduce() functions that use the built-in methods if they exist:

// Call the function f for each element of array a and return // an array of the results. Use Array.prototype.map if it is defined. var map = Array.prototype.map ? function(a, f) { return a.map(f); } // Use map method if it exists : function(a,f) { // Otherwise, implement our own var results = []; for(var i = 0, len = a.length; i < len; i++) { if (i in a) results[i] = f.call(null, a[i], i, a); } return results; }; // Reduce the array a to a single value using the function f and // optional initial value. Use Array.prototype.reduce if it is defined. var reduce = Array.prototype.reduce ? function(a, f, initial) { // If the reduce() method exists. if (arguments.length > 2) return a.reduce(f, initial); // If an initial value was passed. else return a.reduce(f); // Otherwise, no initial value. } : function(a, f, initial) { // This algorithm from the ES5 specification var i = 0, len = a.length, accumulator; // Start with the specified initial value, or the first value in a if (arguments.length > 2) accumulator = initial; else { // Find the first defined index in the array if (len == 0) throw TypeError(); while(i < len) { if (i in a) { accumulator = a[i++]; break; } else i++; } if (i == len) throw TypeError(); } // Now call f for each remaining element in the array while(i < len) { if (i in a) accumulator = f.call(undefined, accumulator, a[i], i, a); i++; } return accumulator; };

With these map() and reduce() functions defined, our code to compute the mean and standard deviation now looks like this:

var data = [1,1,3,5,5]; var sum = function(x,y) { return x+y; }; var square = function(x) { return x*x; }; var mean = reduce(data, sum)/data.length; var deviations = map(data, function(x) {return x-mean;}); var stddev = Math.sqrt(reduce(map(deviations, square), sum)/(data.length-1));

Higher-Order Functions

A higher-order function is a function that operates on functions, taking one or more functions as arguments and returning a new function. Here is an example:

// This higher-order function returns a new function that passes its // arguments to f and returns the logical negation of f's return value; function not(f) { return function() { // Return a new function var result = f.apply(this, arguments); // that calls f return !result; // and negates its result. }; } var even = function(x) { // A function to determine if a number is even return x % 2 === 0; }; var odd = not(even); // A new function that does the opposite [1,1,3,5,5].every(odd); // => true: every element of the array is odd

The not() function above is a higher-order function because it takes a function argument and returns a new function. As another example, consider the mapper() function below. It takes a function argument and returns a new function that maps one array to another using that function. This function uses the map() function defined earlier, and it is important that you understand how the two functions are different:

// Return a function that expects an array argument and applies f to // each element, returning the array of return values. // Contrast this with the map() function from earlier. function mapper(f) { return function(a) { return map(a, f); }; } var increment = function(x) { return x+1; }; var incrementer = mapper(increment); incrementer([1,2,3]) // => [2,3,4]

Here is another, more general, example that takes two functions f and g and returns a new function that computes f(g()):

// Return a new function that computes f(g(...)). // The returned function h passes all of its arguments to g, and then passes // the return value of g to f, and then returns the return value of f. // Both f and g are invoked with the same this value as h was invoked with. function compose(f,g) { return function() { // We use call for f because we're passing a single value and // apply for g because we're passing an array of values. return f.call(this, g.apply(this, arguments)); }; } var square = function(x) { return x*x; }; var sum = function(x,y) { return x+y; }; var squareofsum = compose(square, sum); squareofsum(2,3) // => 25

The partial() and memoize() functions defined in the sections that follow are two more important higher-order functions.

Partial Application of Functions

The bind() method of a function f (The bind() Method) returns a new function that invokes f in a specified context and with a specified set of arguments. We say that it binds the function to an object and partially applies the arguments. The bind() method partially applies arguments on the left—that is, the arguments you pass to bind() are placed at the start of the argument list that is passed to the original function. But it is also possible to partially apply arguments on the right:

// A utility function to convert an array-like object (or suffix of it) // to a true array. Used below to convert arguments objects to real arrays. function array(a, n) { return Array.prototype.slice.call(a, n || 0); } // The arguments to this function are passed on the left function partialLeft(f /*, ...*/) { var args = arguments; // Save the outer arguments array return function() { // And return this function var a = array(args, 1); // Start with the outer args from 1 on. a = a.concat(array(arguments)); // Then add all the inner arguments. return f.apply(this, a); // Then invoke f on that argument list. }; } // The arguments to this function are passed on the right function partialRight(f /*, ...*/) { var args = arguments; // Save the outer arguments array return function() { // And return this function var a = array(arguments); // Start with the inner arguments. a = a.concat(array(args,1)); // Then add the outer args from 1 on. return f.apply(this, a); // Then invoke f on that argument list. }; } // The arguments to this function serve as a template. Undefined values // in the argument list are filled in with values from the inner set. function partial(f /*, ... */) { var args = arguments; // Save the outer arguments array return function() { var a = array(args, 1); // Start with an array of outer args var i=0, j=0; // Loop through those args, filling in undefined values from inner for(; i < a.length; i++) if (a[i] === undefined) a[i] = arguments[j++]; // Now append any remaining inner arguments a = a.concat(array(arguments, j)) return f.apply(this, a); }; } // Here is a function with three arguments var f = function(x,y,z) { return x * (y - z); }; // Notice how these three partial applications differ partialLeft(f, 2)(3,4) // => -2: Bind first argument: 2 * (3 - 4) partialRight(f, 2)(3,4) // => 6: Bind last argument: 3 * (4 - 2) partial(f, undefined, 2)(3,4) // => -6: Bind middle argument: 3 * (2 - 4)

These partial application functions allow us to easily define interesting functions out of functions we already have defined. Here are some examples:

var increment = partialLeft(sum, 1); var cuberoot = partialRight(Math.pow, 1/3); String.prototype.first = partial(String.prototype.charAt, 0); String.prototype.last = partial(String.prototype.substr, -1, 1);

Partial application becomes even more interesting when we combine it with other higher-order functions. Here, for example, is a way to define the not() function shown above using composition and partial application:

var not = partialLeft(compose, function(x) { return !x; }); var even = function(x) { return x % 2 === 0; }; var odd = not(even); var isNumber = not(isNaN)

We can also use composition and partial application to redo our mean and standard deviation calculations in extreme functional style:

var data = [1,1,3,5,5]; // Our data var sum = function(x,y) { return x+y; }; // Two elementary functions var product = function(x,y) { return x*y; }; var neg = partial(product, -1); // Define some others var square = partial(Math.pow, undefined, 2); var sqrt = partial(Math.pow, undefined, .5); var reciprocal = partial(Math.pow, undefined, -1); // Now compute the mean and standard deviation. This is all function // invocations with no operators, and it starts to look like Lisp code! var mean = product(reduce(data, sum), reciprocal(data.length)); var stddev = sqrt(product(reduce(map(data, compose(square, partial(sum, neg(mean)))), sum), reciprocal(sum(data.length,-1))));

Memoization

In Defining Your Own Function Properties we defined a factorial function that cached its previously computed results. In functional programming, this kind of caching is called memoization. The code below shows a higher-order function, memoize() that accepts a function as its argument and returns a memoized version of the function:

// Return a memoized version of f. // It only works if arguments to f all have distinct string representations. function memoize(f) { var cache = {}; // Value cache stored in the closure. return function() { // Create a string version of the arguments to use as a cache key. var key = arguments.length + Array.prototype.join.call(arguments,","); if (key in cache) return cache[key]; else return cache[key] = f.apply(this, arguments); }; }

The memoize() function creates a new object to use as the cache and assigns this object to a local variable, so that it is private to (in the closure of) the returned function. The returned function converts its arguments array to a string, and uses that string as a property name for the cache object. If a value exists in the cache, it returns it directly. Otherwise, it calls the specified function to compute the value for these arguments, caches that value, and returns it. Here is how we might use memoize():

// Return the Greatest Common Divisor of two integers, using the Euclidian // algorithm: http://en.wikipedia.org/wiki/Euclidean_algorithm function gcd(a,b) { // Type checking for a and b has been omitted var t; // Temporary variable for swapping values if (a < b) t=b, b=a, a=t; // Ensure that a >= b while(b != 0) t=b, b = a%b, a=t; // This is Euclid's algorithm for GCD return a; } var gcdmemo = memoize(gcd); gcdmemo(85, 187) // => 17 // Note that when we write a recursive function that we will be memoizing, // we typically want to recurse to the memoized version, not the original. var factorial = memoize(function(n) { return (n <= 1) ? 1 : n * factorial(n-1); }); factorial(5) // => 120. Also caches values for 4, 3, 2 and 1.

* * *

[14] If this piques your interest, you may be interested in using (or at least reading about) Oliver Steele’s Functional JavaScript library. See http://osteele.com/sources/javascript/functional/.

Chapter 9. Classes and Modules

JavaScript objects were covered in Chapter 6. That chapter treated each object as a unique set of properties, different from every other object. It is often useful, however, to define a class of objects that share certain properties. Members, or instances, of the class have their own properties to hold or define their state, but they also have properties (typically methods) that define their behavior. This behavior is defined by the class and is shared by all instances. Imagine a class named Complex to represent and perform arithmetic on complex numbers, for example. A Complex instance would have properties to hold the real and imaginary parts (state) of the complex number. And the Complex class would define methods to perform addition and multiplication (behavior) of those numbers.

In JavaScript, classes are based on JavaScript’s prototype-based inheritance mechanism. If two objects inherit properties from the same prototype object, then we say that they are instances of the same class. JavaScript prototypes and inheritance were covered in Prototypes and Inheritance, and you must be familiar with the material in those sections to understand this chapter. This chapter covers prototypes in Classes and Prototypes.

If two objects inherit from the same prototype, this typically (but not necessarily) means that they were created and initialized by the same constructor function. Constructors have been covered in Object Creation Expressions, Creating Objects with new, and Constructor Invocation, and this chapter has more in Classes and Constructors.

If you’re familiar with strongly-typed object-oriented programming languages like Java or C++, you’ll notice that JavaScript classes are quite different from classes in those languages. There are some syntactic similarities, and you can emulate many features of「classical」classes in JavaScript, but it is best to understand up front that JavaScript’s classes and prototype-based inheritance mechanism are substantially different from the classes and class-based inheritance mechanism of Java and similar languages. Java-Style Classes in JavaScript demonstrates classical classes in JavaScript.

One of the important features of JavaScript classes is that they are dynamically extendable. Augmenting Classes explains how to do this. Classes can be thought of as types, and Classes and Types explains several ways to test or determine the class of an object. That section also covers a programming philosophy known as「duck-typing」that de-emphasizes object type in favor of object capability.

After covering all of these fundamentals of object-oriented programming in JavaScript, the chapter shifts to more practical and less architectural matters. Object-Oriented Techniques in JavaScript includes two nontrivial example classes and demonstrates a number of practical object-oriented techniques for improving those classes. Subclasses demonstrates (with many examples) how to extend or subclass other classes and how to define class hierarchies in JavaScript. Classes in ECMAScript 5 covers some of the things you can do with classes using the new features of ECMAScript 5.

Defining classes is a way of writing modular, reusable code, and the last section of this chapter talks about JavaScript modules more generally.

Classes and Prototypes

In JavaScript, a class is a set of objects that inherit properties from the same prototype object. The prototype object, therefore, is the central feature of a class. In Example 6-1 we defined an inherit() function that returns a newly created object that inherits from a specified prototype object. If we define a prototype object, and then use inherit() to create objects that inherit from it, we have defined a JavaScript class. Usually, the instances of a class require further initialization, and it is common to define a function that creates and initializes the new object. Example 9-1 demonstrates this: it defines a prototype object for a class that represents a range of values and also defines a「factory」function that creates and initializes a new instance of the class.

Example 9-1. A simple JavaScript class

// range.js: A class representing a range of values. // This is a factory function that returns a new range object. function range(from, to) { // Use the inherit() function to create an object that inherits from the // prototype object defined below. The prototype object is stored as // a property of this function, and defines the shared methods (behavior) // for all range objects. var r = inherit(range.methods); // Store the start and end points (state) of this new range object. // These are noninherited properties that are unique to this object. r.from = from; r.to = to; // Finally return the new object return r; } // This prototype object defines methods inherited by all range objects. range.methods = { // Return true if x is in the range, false otherwise // This method works for textual and Date ranges as well as numeric. includes: function(x) { return this.from <= x && x <= this.to; }, // Invoke f once for each integer in the range. // This method works only for numeric ranges. foreach: function(f) { for(var x = Math.ceil(this.from); x <= this.to; x++) f(x); }, // Return a string representation of the range toString: function() { return "(" + this.from + "..." + this.to + ")"; } }; // Here are example uses of a range object. var r = range(1,3); // Create a range object r.includes(2); // => true: 2 is in the range r.foreach(console.log); // Prints 1 2 3 console.log(r); // Prints (1...3)

There are a few things worth noting in the code of Example 9-1. This code defines a factory function range() for creating new range objects. Notice that we use a property of this range() function range.methods as a convenient place to store the prototype object that defines the class. There is nothing special or idiomatic about putting the prototype object here. Second, notice that the range() function defines from and to properties on each range object. These are the unshared, noninherited properties that define the unique state of each individual range object. Finally, notice that the shared, inherited methods defined in range.methods all use these from and to properties, and in order to refer to them, they use the this keyword to refer to the object through which they were invoked. This use of this is a fundamental characteristic of the methods of any class.

Classes and Constructors

Example 9-1 demonstrates one way to define a JavaScript class. It is not the idiomatic way to do so, however, because it did not define a constructor. A constructor is a function designed for the initialization of newly created objects. Constructors are invoked using the new keyword as described in Constructor Invocation. Constructor invocations using new automatically create the new object, so the constructor itself only needs to initialize the state of that new object. The critical feature of constructor invocations is that the prototype property of the constructor is used as the prototype of the new object. This means that all objects created with the same constructor inherit from the same object and are therefore members of the same class. Example 9-2 shows how we could alter the range class of Example 9-1 to use a constructor function instead of a factory function:

Example 9-2. A Range class using a constructor

// range2.js: Another class representing a range of values. // This is a constructor function that initializes new Range objects. // Note that it does not create or return the object. It just initializes this. function Range(from, to) { // Store the start and end points (state) of this new range object. // These are noninherited properties that are unique to this object. this.from = from; this.to = to; } // All Range objects inherit from this object. // Note that the property name must be "prototype" for this to work. Range.prototype = { // Return true if x is in the range, false otherwise // This method works for textual and Date ranges as well as numeric. includes: function(x) { return this.from <= x && x <= this.to; }, // Invoke f once for each integer in the range. // This method works only for numeric ranges. foreach: function(f) { for(var x = Math.ceil(this.from); x <= this.to; x++) f(x); }, // Return a string representation of the range toString: function() { return "(" + this.from + "..." + this.to + ")"; } }; // Here are example uses of a range object var r = new Range(1,3); // Create a range object r.includes(2); // => true: 2 is in the range r.foreach(console.log); // Prints 1 2 3 console.log(r); // Prints (1...3)

It is worth comparing Example 9-1 and Example 9-2 fairly carefully and noting the differences between these two techniques for defining classes. First, notice that we renamed the range() factory function to Range() when we converted it to a constructor. This is a very common coding convention: constructor functions define, in a sense, classes, and classes have names that begin with capital letters. Regular functions and methods have names that begin with lowercase letters.

Next, notice that the Range() constructor is invoked (at the end of the example) with the new keyword while the range() factory function was invoked without it. Example 9-1 uses regular function invocation (Function Invocation) to create the new object and Example 9-2 uses constructor invocation (Constructor Invocation). Because the Range() constructor is invoked with new, it does not have to call inherit() or take any action to create a new object. The new object is automatically created before the constructor is called, and it is accessible as the this value. The Range() constructor merely has to initialize this. Constructors do not even have to return the newly created object. Constructor invocation automatically creates a new object, invokes the constructor as a method of that object, and returns the new object. The fact that constructor invocation is so different from regular function invocation is another reason that we give constructors names that start with capital letters. Constructors are written to be invoked as constructors, with the new keyword, and they usually won’t work properly if they are invoked as regular functions. A naming convention that keeps constructor functions distinct from regular functions helps programmers to know when to use new.

Another critical difference between Example 9-1 and Example 9-2 is the way the prototype object is named. In the first example, the prototype was range.methods. This was a convenient and descriptive name, but arbitrary. In the second example, the prototype is Range.prototype, and this name is mandatory. An invocation of the Range() constructor automatically uses Range.prototype as the prototype of the new Range object.

Finally, also note the things that do not change between Example 9-1 and Example 9-2: the range methods are defined and invoked in the same way for both classes.

Constructors and Class Identity

As we’ve seen, the prototype object is fundamental to the identity of a class: two objects are instances of the same class if and only if they inherit from the same prototype object. The constructor function that initializes the state of a new object is not fundamental: two constructor functions may have prototype properties that point to the same prototype object. Then both constructors can be used to create instances of the same class.

Even through constructors are not as fundamental as prototypes, the constructor serves as the public face of a class. Most obviously, the name of the constructor function is usually adopted as the name of the class. We say, for example, that the Range() constructor creates Range objects. More fundamentally, however, constructors are used with the instanceof operator when testing objects for membership in a class. If we have an object r and want to know if it is a Range object, we can write:

