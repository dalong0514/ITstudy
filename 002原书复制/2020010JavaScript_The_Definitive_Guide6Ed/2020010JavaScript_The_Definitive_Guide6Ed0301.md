The in operator expects a left-side operand that is or can be converted to a string. It expects a right-side operand that is an object. It evaluates to true if the left-side value is the name of a property of the right-side object. For example:

var point = { x:1, y:1 }; // Define an object "x" in point // => true: object has property named "x" "z" in point // => false: object has no "z" property. "toString" in point // => true: object inherits toString method var data = [7,8,9]; // An array with elements 0, 1, and 2 "0" in data // => true: array has an element "0" 1 in data // => true: numbers are converted to strings 3 in data // => false: no element 3

The instanceof Operator

The instanceof operator expects a left-side operand that is an object and a right-side operand that identifies a class of objects. The operator evaluates to true if the left-side object is an instance of the right-side class and evaluates to false otherwise. Chapter 9 explains that, in JavaScript, classes of objects are defined by the constructor function that initializes them. Thus, the right-side operand of instanceof should be a function. Here are examples:

var d = new Date(); // Create a new object with the Date() constructor d instanceof Date; // Evaluates to true; d was created with Date() d instanceof Object; // Evaluates to true; all objects are instances of Object d instanceof Number; // Evaluates to false; d is not a Number object var a = [1, 2, 3]; // Create an array with array literal syntax a instanceof Array; // Evaluates to true; a is an array a instanceof Object; // Evaluates to true; all arrays are objects a instanceof RegExp; // Evaluates to false; arrays are not regular expressions

Note that all objects are instances of Object. instanceof considers the「superclasses」when deciding whether an object is an instance of a class. If the left-side operand of instanceof is not an object, instanceof returns false. If the right-hand side is not a function, it throws a TypeError.

In order to understand how the instanceof operator works, you must understand the「prototype chain.」This is JavaScript’s inheritance mechanism, and it is described in Inheritance. To evaluate the expression o instanceof f, JavaScript evaluates f.prototype, and then looks for that value in the prototype chain of o. If it finds it, then o is an instance of f (or of a superclass of f) and the operator returns true. If f.prototype is not one of the values in the prototype chain of o, then o is not an instance of f and instanceof returns false.

Logical Expressions

The logical operators &&, ||, and ! perform Boolean algebra and are often used in conjunction with the relational operators to combine two relational expressions into one more complex expression. These operators are described in the subsections that follow. In order to fully understand them, you may want to review the concept of「truthy」and「falsy」values introduced in Boolean Values.

Logical AND (&&)

The && operator can be understood at three different levels. At the simplest level, when used with boolean operands, && performs the Boolean AND operation on the two values: it returns true if and only if both its first operand and its second operand are true. If one or both of these operands is false, it returns false.

&& is often used as a conjunction to join two relational expressions:

x == 0 && y == 0 // true if, and only if x and y are both 0

Relational expressions always evaluate to true or false, so when used like this, the && operator itself returns true or false. Relational operators have higher precedence than && (and ||), so expressions like these can safely be written without parentheses.

But && does not require that its operands be boolean values. Recall that all JavaScript values are either「truthy」or「falsy.」(See Boolean Values for details. The falsy values are false, null, undefined, 0, -0, NaN, and "". All other values, including all objects, are truthy.) The second level at which && can be understood is as a Boolean AND operator for truthy and falsy values. If both operands are truthy, the operator returns a truthy value. Otherwise, one or both operands must be falsy, and the operator returns a falsy value. In JavaScript, any expression or statement that expects a boolean value will work with a truthy or falsy value, so the fact that && does not always return true or false does not cause practical problems.

Notice that the description above says that the operator returns「a truthy value」or「a falsy value,」but does not specify what that value is. For that, we need to describe && at the third and final level. This operator starts by evaluating its first operand, the expression on its left. If the value on the left is falsy, the value of the entire expression must also be falsy, so && simply returns the value on the left and does not even evaluate the expression on the right.

On the other hand, if the value on the left is truthy, then the overall value of the expression depends on the value on the right-hand side. If the value on the right is truthy, then the overall value must be truthy, and if the value on the right is falsy, then the overall value must be falsy. So when the value on the left is truthy, the && operator evaluates and returns the value on the right:

var o = { x : 1 }; var p = null; o && o.x // => 1: o is truthy, so return value of o.x p && p.x // => null: p is falsy, so return it and don't evaluate p.x

It is important to understand that && may or may not evaluate its right-side operand. In the code above, the variable p is set to null, and the expression p.x would, if evaluated, cause a TypeError. But the code uses && in an idiomatic way so that p.x is evaluated only if p is truthy—not null or undefined.

The behavior of && is sometimes called「short circuiting,」and you may sometimes see code that purposely exploits this behavior to conditionally execute code. For example, the following two lines of JavaScript code have equivalent effects:

if (a == b) stop(); // Invoke stop() only if a == b (a == b) && stop(); // This does the same thing

In general, you must be careful whenever you write an expression with side effects (assignments, increments, decrements, or function invocations) on the right-hand side of &&. Whether those side effects occur depends on the value of the left-hand side.

Despite the somewhat complex way that this operator actually works, it is most commonly used as a simple Boolean algebra operator that works on truthy and falsy values.

Logical OR (||)

The || operator performs the Boolean OR operation on its two operands. If one or both operands is truthy, it returns a truthy value. If both operands are falsy, it returns a falsy value.

Although the || operator is most often used simply as a Boolean OR operator, it, like the && operator, has more complex behavior. It starts by evaluating its first operand, the expression on its left. If the value of this first operand is truthy, it returns that truthy value. Otherwise, it evaluates its second operand, the expression on its right, and returns the value of that expression.

As with the && operator, you should avoid right-side operands that include side effects, unless you purposely want to use the fact that the right-side expression may not be evaluated.

An idiomatic usage of this operator is to select the first truthy value in a set of alternatives:

// If max_width is defined, use that. Otherwise look for a value in // the preferences object. If that is not defined use a hard-coded constant. var max = max_width || preferences.max_width || 500;

This idiom is often used in function bodies to supply default values for parameters:

// Copy the properties of o to p, and return p function copy(o, p) { p = p || {}; // If no object passed for p, use a newly created object. // function body goes here }

Logical NOT (!)

The ! operator is a unary operator; it is placed before a single operand. Its purpose is to invert the boolean value of its operand. For example, if x is truthy !x evaluates to false. If x is falsy, then !x is true.

Unlike the && and || operators, the ! operator converts its operand to a boolean value (using the rules described in Chapter 3) before inverting the converted value. This means that ! always returns true or false, and that you can convert any value x to its equivalent boolean value by applying this operator twice: !!x (see Explicit Conversions).

As a unary operator, ! has high precedence and binds tightly. If you want to invert the value of an expression like p && q, you need to use parentheses: !(p && q). It is worth noting two theorems of Boolean algebra here that we can express using JavaScript syntax:

// These two equalities hold for any values of p and q !(p && q) === !p || !q !(p || q) === !p && !q

Assignment Expressions

JavaScript uses the = operator to assign a value to a variable or property. For example:

i = 0 // Set the variable i to 0. o.x = 1 // Set the property x of object o to 1.

The = operator expects its left-side operand to be an lvalue: a variable or object property (or array element). It expects its right-side operand to be an arbitrary value of any type. The value of an assignment expression is the value of the right-side operand. As a side effect, the = operator assigns the value on the right to the variable or property on the left so that future references to the variable or property evaluate to the value.

Although assignment expressions are usually quite simple, you may sometimes see the value of an assignment expression used as part of a larger expression. For example, you can assign and test a value in the same expression with code like this:

(a = b) == 0

If you do this, be sure you are clear on the difference between the = and == operators! Note that = has very low precedence and parentheses are usually necessary when the value of an assignment is to be used in a larger expression.

The assignment operator has right-to-left associativity, which means that when multiple assignment operators appear in an expression, they are evaluated from right to left. Thus, you can write code like this to assign a single value to multiple variables:

i = j = k = 0; // Initialize 3 variables to 0

Assignment with Operation

Besides the normal = assignment operator, JavaScript supports a number of other assignment operators that provide shortcuts by combining assignment with some other operation. For example, the += operator performs addition and assignment. The following expression:

total += sales_tax

is equivalent to this one:

total = total + sales_tax

As you might expect, the += operator works for numbers or strings. For numeric operands, it performs addition and assignment; for string operands, it performs concatenation and assignment.

Similar operators include -=, *=, &=, and so on. Table 4-2 lists them all.

Table 4-2. Assignment operators

OperatorExampleEquivalent

+= a += b a = a + b

-= a -= b a = a - b

*= a *= b a = a * b

/= a /= b a = a / b

%= a %= b a = a % b

<<= a <<= b a = a << b

>>= a >>= b a = a >> b

>>>= a >>>= b a = a >>> b

&= a &= b a = a & b

|= a |= b a = a | b

^= a ^= b a = a ^ b

In most cases, the expression:

a op= b

where op is an operator, is equivalent to the expression:

a = a op b

In the first line, the expression a is evaluated once. In the second it is evaluated twice. The two cases will differ only if a includes side effects such as a function call or an increment operator. The following two assignments, for example, are not the same:

data[i++] *= 2; data[i++] = data[i++] * 2;

Evaluation Expressions

Like many interpreted languages, JavaScript has the ability to interpret strings of JavaScript source code, evaluating them to produce a value. JavaScript does this with the global function eval():

eval("3+2") // => 5

Dynamic evaluation of strings of source code is a powerful language feature that is almost never necessary in practice. If you find yourself using eval(), you should think carefully about whether you really need to use it.

The subsections below explain the basic use of eval() and then explain two restricted versions of it that have less impact on the optimizer.

Is eval() a Function or an Operator?

eval() is a function, but it is included in this chapter on expressions because it really should have been an operator. The earliest versions of the language defined an eval() function, and ever since then language designers and interpreter writers have been placing restrictions on it that make it more and more operator-like. Modern JavaScript interpreters perform a lot of code analysis and optimization. The problem with eval() is that the code it evaluates is, in general, unanalyzable. Generally speaking, if a function calls eval(), the interpreter cannot optimize that function. The problem with defining eval() as a function is that it can be given other names:

var f = eval; var g = f;

If this is allowed, then the interpreter can’t safely optimize any function that calls g(). This issue could have been avoided if eval was an operator (and a reserved word). We’ll learn below (in Global eval() and Strict eval()) about restrictions placed on eval() to make it more operator-like.

eval()

eval() expects one argument. If you pass any value other than a string, it simply returns that value. If you pass a string, it attempts to parse the string as JavaScript code, throwing a SyntaxError if it fails. If it successfully parses the string, then it evaluates the code and returns the value of the last expression or statement in the string or undefined if the last expression or statement had no value. If the string throws an exception, the eval() propagates that expression.

The key thing about eval() (when invoked like this) is that it uses the variable environment of the code that calls it. That is, it looks up the values of variables and defines new variables and functions in the same way that local code does. If a function defines a local variable x and then calls eval("x"), it will obtain the value of the local variable. If it calls eval("x=1"), it changes the value of the local variable. And if the function calls eval("var y = 3;"), it has declared a new local variable y. Similarly a function can declare a local function with code like this:

eval("function f() { return x+1; }");

If you call eval() from top-level code, it operates on global variables and global functions, of course.

Note that the string of code you pass to eval() must make syntactic sense on its own—you cannot use it to paste code fragments into a function. It makes no sense to write eval("return;"), for example, because return is only legal within functions, and the fact that the evaluated string uses the same variable environment as the calling function does not make it part of that function. If your string would make sense as a standalone script (even a very short one like x=0 ), it is legal to pass to eval(). Otherwise eval() will throw a SyntaxError.

Global eval()

It is the ability of eval() to change local variables that is so problematic to JavaScript optimizers. As a workaround, however, interpreters simply do less optimization on any function that calls eval(). But what should a JavaScript interpreter do, however, if a script defines an alias for eval() and then calls that function by another name? In order to simplify the job of JavaScript implementors, the ECMAScript 3 standard declared that interpreters did not have to allow this. If the eval() function was invoked by any name other than「eval」, it was allowed to throw an EvalError.

In practice, most implementors did something else. When invoked by any other name, eval() would evaluate the string as if it were top-level global code. The evaluated code might define new global variables or global functions, and it might set global variables, but it could not use or modify any variables local to the calling function, and would not, therefore, interfere with local optimizations.

ECMAScript 5 deprecates EvalError and standardizes the de facto behavior of eval(). A「direct eval」is a call to the eval() function with an expression that uses the exact, unqualified name「eval」(which is beginning to feel like a reserved word). Direct calls to eval() use the variable environment of the calling context. Any other call—an indirect call—uses the global object as its variable environment and cannot read, write, or define local variables or functions. The following code demonstrates:

var geval = eval; // Using another name does a global eval var x = "global", y = "global"; // Two global variables function f() { // This function does a local eval var x = "local"; // Define a local variable eval("x += 'changed';"); // Direct eval sets local variable return x; // Return changed local variable } function g() { // This function does a global eval var y = "local"; // A local variable geval("y += 'changed';"); // Indirect eval sets global variable return y; // Return unchanged local variable } console.log(f(), x); // Local variable changed: prints "localchanged global": console.log(g(), y); // Global variable changed: prints "local globalchanged":

Notice that the ability to do a global eval is not just an accommodation to the needs of the optimizer, it is actually a tremendously useful feature: it allows you to execute strings of code as if they were independent, top-level scripts. As noted at the beginning of this section, it is rare to truly need to evaluate a string of code. But if you do find it necessary, you are more likely to want to do a global eval than a local eval.

Before IE9, IE differs from other browsers: it does not do a global eval when eval() is invoked by a different name. (It doesn’t throw an EvalError either: it simply does a local eval.) But IE does define a global function named execScript() that executes its string argument as if it were a top-level script. (Unlike eval(), however, execScript() always returns null.)

Strict eval()

ECMAScript 5 strict mode (see「use strict」) imposes further restrictions on the behavior of the eval() function and even on the use of the identifier「eval」. When eval() is called from strict mode code, or when the string of code to be evaluated itself begins with a「use strict」directive, then eval() does a local eval with a private variable environment. This means that in strict mode, evaluated code can query and set local variables, but it cannot define new variables or functions in the local scope.

Furthermore, strict mode makes eval() even more operator-like by effectively making「eval」into a reserved word. You are not allowed to overwrite the eval() function with a new value. And you are not allowed to declare a variable, function, function parameter, or catch block parameter with the name「eval」.

Miscellaneous Operators

JavaScript supports a number of other miscellaneous operators, described in the following sections.

The Conditional Operator (?:)

The conditional operator is the only ternary operator (three operands) in JavaScript and is sometimes actually called the ternary operator. This operator is sometimes written ?:, although it does not appear quite that way in code. Because this operator has three operands, the first goes before the ?, the second goes between the ? and the :, and the third goes after the :. It is used like this:

x > 0 ? x : -x // The absolute value of x

The operands of the conditional operator may be of any type. The first operand is evaluated and interpreted as a boolean. If the value of the first operand is truthy, then the second operand is evaluated, and its value is returned. Otherwise, if the first operand is falsy, then the third operand is evaluated and its value is returned. Only one of the second and third operands is evaluated, never both.

While you can achieve similar results using the if statement (if), the ?: operator often provides a handy shortcut. Here is a typical usage, which checks to be sure that a variable is defined (and has a meaningful, truthy value) and uses it if so or provides a default value if not:

greeting = "hello " + (username ? username : "there");

This is equivalent to, but more compact than, the following if statement:

greeting = "hello "; if (username) greeting += username; else greeting += "there";

The typeof Operator

typeof is a unary operator that is placed before its single operand, which can be of any type. Its value is a string that specifies the type of the operand. The following table specifies the value of the typeof operator for any JavaScript value:

x typeof x

undefined "undefined"

null "object"

true or false "boolean"

any number or NaN "number"

any string "string"

any function "function"

any nonfunction native object "object"

any host object An implementation-defined string, but not「undefined」,「boolean」,「number」, or「string」.

You might use the typeof operator in an expression like this:

(typeof value == "string") ? "'" + value + "'" : value

The typeof operator is also useful when used with the switch statement (switch). Note that you can place parentheses around the operand to typeof, which makes typeof look like the name of a function rather than an operator keyword:

typeof(i)

Note that typeof returns「object」if the operand value is null. If you want to distinguish null from objects, you’ll have to explicitly test for this special-case value. typeof may return a string other than「object」for host objects. In practice, however, most host objects in client-side JavaScript have a type of「object」.

Because typeof evaluates to「object」for all object and array values other than functions, it is useful only to distinguish objects from other, primitive types. In order to distinguish one class of object from another, you must use other techniques, such as the instanceof operator (see The instanceof Operator), the class attribute (see The class Attribute), or the constructor property (see The prototype Attribute and The constructor Property).

Although functions in JavaScript are a kind of object, the typeof operator considers functions to be sufficiently different that they have their own return value. JavaScript makes a subtle distinction between functions and「callable objects.」All functions are callable, but it is possible to have a callable object—that can be invoked just like a function—that is not a true function. The ECMAScript 3 spec says that the typeof operator returns「function」for all native object that are callable. The ECMAScript 5 specification extends this to require that typeof return「function」for all callable objects, whether native objects or host objects. Most browser vendors use native JavaScript function objects for the methods of their host objects. Microsoft, however, has always used non-native callable objects for their client-side methods, and before IE 9 the typeof operator returns「object」for them, even though they behave like functions. In IE9 these client-side methods are now true native function objects. See Callable Objects for more on the distinction between true functions and callable objects.

The delete Operator

delete is a unary operator that attempts to delete the object property or array element specified as its operand.[3] Like the assignment, increment, and decrement operators, delete is typically used for its property deletion side effect, and not for the value it returns. Some examples:

var o = { x: 1, y: 2}; // Start with an object delete o.x; // Delete one of its properties "x" in o // => false: the property does not exist anymore var a = [1,2,3]; // Start with an array delete a[2]; // Delete the last element of the array a.length // => 2: array only has two elements now

Note that a deleted property or array element is not merely set to the undefined value. When a property is deleted, the property ceases to exist. Attempting to read a nonexistent property returns undefined, but you can test for the actual existence of a property with the in operator (The in Operator).

delete expects its operand to be an lvalue. If it is not an lvalue, the operator takes no action and returns true. Otherwise, delete attempts to delete the specified lvalue. delete returns true if it successfully deletes the specified lvalue. Not all properties can be deleted, however: some built-in core and client-side properties are immune from deletion, and user-defined variables declared with the var statement cannot be deleted. Functions defined with the function statement and declared function parameters cannot be deleted either.

In ECMAScript 5 strict mode, delete raises a SyntaxError if its operand is an unqualified identifier such as a variable, function, or function parameter: it only works when the operand is a property access expression (Property Access Expressions). Strict mode also specifies that delete raises a TypeError if asked to delete any nonconfigurable property (see Property Attributes). Outside of strict mode, no exception occurs in these cases and delete simply returns false to indicate that the operand could not be deleted.

Here are some example uses of the delete operator:

var o = {x:1, y:2}; // Define a variable; initialize it to an object delete o.x; // Delete one of the object properties; returns true typeof o.x; // Property does not exist; returns "undefined" delete o.x; // Delete a nonexistent property; returns true delete o; // Can't delete a declared variable; returns false. // Would raise an exception in strict mode. delete 1; // Argument is not an lvalue: returns true this.x = 1; // Define a property of the a global object without var delete x; // Try to delete it: returns true in non-strict mode // Exception in strict mode. Use 'delete this.x' instead x; // Runtime error: x is not defined

We’ll see the delete operator again in Deleting Properties.

The void Operator

void is a unary operator that appears before its single operand, which may be of any type. This operator is unusual and infrequently used: it evaluates its operand, then discards the value and returns undefined. Since the operand value is discarded, using the void operator makes sense only if the operand has side effects.

The most common use for this operator is in a client-side javascript: URL, where it allows you to evaluate an expression for its side effects without the browser displaying the value of the evaluated expression. For example, you might use the void operator in an HTML <a> tag as follows:

<a href="javascript:void window.open();">Open New Window</a>

This HTML could be more cleanly written using an onclick event handler rather than a javascript: URL, of course, and the void operator would not be necessary in that case.

The Comma Operator (,)

The comma operator is a binary operator whose operands may be of any type. It evaluates its left operand, evaluates its right operand, and then returns the value of the right operand. Thus, the following line:

i=0, j=1, k=2;

evaluates to 2 and is basically equivalent to:

i = 0; j = 1; k = 2;

The left-hand expression is always evaluated, but its value is discarded, which means that it only makes sense to use the comma operator when the left-hand expression has side effects. The only situation in which the comma operator is commonly used is with a for loop (for) that has multiple loop variables:

// The first comma below is part of the syntax of the var statement // The second comma is the comma operator: it lets us squeeze 2 // expressions (i++ and j--) into a statement (the for loop) that expects 1. for(var i=0,j=10; i < j; i++,j--) console.log(i+j);

* * *

[3] If you are a C++ programmer, note that the delete keyword in JavaScript is nothing like the delete keyword in C++. In JavaScript, memory deallocation is handled automatically by garbage collection, and you never have to worry about explicitly freeing up memory. Thus, there is no need for a C++-style delete to delete entire objects.

Chapter 5. Statements

Chapter 4 described expressions as JavaScript phrases. By that analogy, statements are JavaScript sentences or commands. Just as English sentences are terminated and separated from each other with periods, JavaScript statements are terminated with semicolons (Optional Semicolons). Expressions are evaluated to produce a value, but statements are executed to make something happen.

One way to「make something happen」is to evaluate an expression that has side effects. Expressions with side effects, such as assignments and function invocations, can stand alone as statements, and when used this way they are known as expression statements. A similar category of statements are the declaration statements that declare new variables and define new functions.

JavaScript programs are nothing more than a sequence of statements to execute. By default, the JavaScript interpreter executes these statements one after another in the order they are written. Another way to「make something happen」is to alter this default order of execution, and JavaScript has a number of statements or control structures that do just this:

Conditionals are statements like if and switch that make the JavaScript interpreter execute or skip other statements depending on the value of an expression.

Loops are statements like while and for that execute other statements repetitively.

Jumps are statements like break, return, and throw that cause the interpreter to jump to another part of the program.

The sections that follow describe the various statements in JavaScript and explain their syntax. Table 5-1, at the end of the chapter, summarizes the syntax. A JavaScript program is simply a sequence of statements, separated from one another with semicolons, so once you are familiar with the statements of JavaScript, you can begin writing JavaScript programs.

Expression Statements

The simplest kinds of statements in JavaScript are expressions that have side effects. (But see「use strict」for an important expression statement without side effects.) This sort of statement was shown in Chapter 4. Assignment statements are one major category of expression statements. For example:

greeting = "Hello " + name; i *= 3;

The increment and decrement operators, ++ and --, are related to assignment statements. These have the side effect of changing a variable value, just as if an assignment had been performed:

counter++;

The delete operator has the important side effect of deleting an object property. Thus, it is almost always used as a statement, rather than as part of a larger expression:

delete o.x;

Function calls are another major category of expression statements. For example:

alert(greeting); window.close();

These client-side function calls are expressions, but they have side effects that affect the web browser and are used here as statements. If a function does not have any side effects, there is no sense in calling it, unless it is part of a larger expression or an assignment statement. For example, you wouldn’t just compute a cosine and discard the result:

Math.cos(x);

But you might well compute the value and assign it to a variable for future use:

cx = Math.cos(x);

Note that each line of code in each of these examples is terminated with a semicolon.

Compound and Empty Statements

Just as the comma operator (The Comma Operator (,)) combines multiple expressions into a single expression, a statement block combines multiple statements into a single compound statement. A statement block is simply a sequence of statements enclosed within curly braces. Thus, the following lines act as a single statement and can be used anywhere that JavaScript expects a single statement:

{ x = Math.PI; cx = Math.cos(x); console.log("cos(π) = " + cx); }

There are a few things to note about this statement block. First, it does not end with a semicolon. The primitive statements within the block end in semicolons, but the block itself does not. Second, the lines inside the block are indented relative to the curly braces that enclose them. This is optional, but it makes the code easier to read and understand. Finally, recall that JavaScript does not have block scope and variables declared within a statement block are not private to the block (see Function Scope and Hoisting for details).

Combining statements into larger statement blocks is extremely common in JavaScript programming. Just as expressions often contain subexpressions, many JavaScript statements contain substatements. Formally, JavaScript syntax usually allows a single substatement. For example, the while loop syntax includes a single statement that serves as the body of the loop. Using a statement block, you can place any number of statements within this single allowed substatement.

A compound statement allows you to use multiple statements where JavaScript syntax expects a single statement. The empty statement is the opposite: it allows you to include no statements where one is expected. The empty statement looks like this:

;

The JavaScript interpreter takes no action when it executes an empty statement. The empty statement is occasionally useful when you want to create a loop that has an empty body. Consider the following for loop (for loops will be covered in for):

// Initialize an array a for(i = 0; i < a.length; a[i++] = 0) ;

In this loop, all the work is done by the expression a[i++] = 0, and no loop body is necessary. JavaScript syntax requires a statement as a loop body, however, so an empty statement—just a bare semicolon—is used.

Note that the accidental inclusion of a semicolon after the right parenthesis of a for loop, while loop, or if statement can cause frustrating bugs that are difficult to detect. For example, the following code probably does not do what the author intended:

if ((a == 0) || (b == 0)); // Oops! This line does nothing... o = null; // and this line is always executed.

When you intentionally use the empty statement, it is a good idea to comment your code in a way that makes it clear that you are doing it on purpose. For example:

for(i = 0; i < a.length; a[i++] = 0) /* empty */ ;

Declaration Statements

The var and function are declaration statements—they declare or define variables and functions. These statements define identifiers (variable and function names) that can be used elsewhere in your program and assign values to those identifiers. Declaration statements don’t do much themselves, but by creating variables and functions they, in an important sense, define the meaning of the other statements in your program.

The subsections that follow explain the var statement and the function statement, but do not cover variables and functions comprehensively. See Variable Declaration and Variable Scope for more on variables. And see Chapter 8 for complete details on functions.

var

The var statement declares a variable or variables. Here’s the syntax:

var name_1 [ = value_1] [ ,..., name_n [= value_n]]

The var keyword is followed by a comma-separated list of variables to declare; each variable in the list may optionally have an initializer expression that specifies its initial value. For example:

var i; // One simple variable var j = 0; // One var, one value var p, q; // Two variables var greeting = "hello" + name; // A complex initializer var x = 2.34, y = Math.cos(0.75), r, theta; // Many variables var x = 2, y = x*x; // Second var uses the first var x = 2, // Multiple variables... f = function(x) { return x*x }, // each on its own line y = f(x);

If a var statement appears within the body of a function, it defines local variables, scoped to that function. When var is used in top-level code, it declares global variables, visible throughout the JavaScript program. As noted in Variables As Properties, global variables are properties of the global object. Unlike other global properties, however, properties created with var cannot be deleted.

If no initializer is specified for a variable with the var statement, the variable’s initial value is undefined. As described in Function Scope and Hoisting, variables are defined throughout the script or function in which they are declared—their declaration is「hoisted」up to the start of the script or function. Initialization, however, occurs at the location of the var statement, and the value of the variable is undefined before that point in the code.

Note that the var statement can also appear as part of the for and for/in loops. (These variables are hoisted, just like variables declared outside of a loop.) Here are examples repeated from Variable Declaration:

for(var i = 0; i < 10; i++) console.log(i); for(var i = 0, j=10; i < 10; i++,j--) console.log(i*j); for(var i in o) console.log(i);

Note that it is harmless to declare the same variable multiple times.

function

The function keyword is used to define functions. We saw it in function definition expressions in Function Definition Expressions. It can also be used in statement form. Consider the following two functions:

var f = function(x) { return x+1; } // Expression assigned to a variable function f(x) { return x+1; } // Statement includes variable name

A function declaration statement has the following syntax:

function funcname([arg1 [, arg2 [..., argn]]]) { statements }

funcname is an identifier that names the function being declared. The function name is followed by a comma-separated list of parameter names in parentheses. These identifiers can be used within the body of the function to refer to the argument values passed when the function is invoked.

The body of the function is composed of any number of JavaScript statements, contained within curly braces. These statements are not executed when the function is defined. Instead, they are associated with the new function object for execution when the function is invoked. Note that the curly braces are a required part of the function statement. Unlike statement blocks used with while loops and other statements, a function body requires curly braces, even if the body consists of only a single statement.

Here are some more examples of function declarations:

function hypotenuse(x, y) { return Math.sqrt(x*x + y*y); // return is documented in the next section } function factorial(n) { // A recursive function if (n <= 1) return 1; return n * factorial(n - 1); }

Function declaration statements may appear in top-level JavaScript code, or they may be nested within other functions. When nested, however, function declarations may only appear at the top level of the function they are nested within. That is, function definitions may not appear within if statements, while loops, or any other statements. Because of this restriction on where function declarations may appear, the ECMAScript specification does not categorize function declarations as true statements. Some JavaScript implementations do allow function declarations to appear anywhere a statement can appear, but different implementations handle the details differently and placing function declarations within other statements is nonportable.

Function declaration statements differ from function definition expressions in that they include a function name. Both forms create a new function object, but the function declaration statement also declares the function name as a variable and assigns the function object to it. Like variables declared with var, functions defined with function definition statements are implicitly「hoisted」to the top of the containing script or function, so that they are visible throughout the script or function. With var, only the variable declaration is hoisted—the variable initialization code remains where you placed it. With function declaration statements, however, both the function name and the function body are hoisted: all functions in a script or all nested functions in a function are declared before any other code is run. This means that you can invoke a JavaScript function before you declare it.

Like the var statement, function declaration statements create variables that cannot be deleted. These variables are not read-only, however, and their value can be overwritten.

Conditionals

Conditional statements execute or skip other statements depending on the value of a specified expression. These statements are the decision points of your code, and they are also sometimes known as「branches.」If you imagine a JavaScript interpreter following a path through your code, the conditional statements are the places where the code branches into two or more paths and the interpreter must choose which path to follow.

The subsections below explain JavaScript’s basic conditional, the if/else statement, and also cover switch, a more complicated multiway branch statement.

if

The if statement is the fundamental control statement that allows JavaScript to make decisions, or, more precisely, to execute statements conditionally. This statement has two forms. The first is:

if (expression) statement

In this form, expression is evaluated. If the resulting value is truthy, statement is executed. If expression is falsy, statement is not executed. (See Boolean Values for a definition of truthy and falsy values.) For example:

if (username == null) // If username is null or undefined, username = "John Doe"; // define it

Or similarly:

// If username is null, undefined, false, 0, "", or NaN, give it a new value if (!username) username = "John Doe";

Note that the parentheses around the expression are a required part of the syntax for the if statement.

JavaScript syntax requires a single statement after the if keyword and parenthesized expression, but you can use a statement block to combine multiple statements into one. So the if statement might also look like this:

if (!address) { address = ""; message = "Please specify a mailing address."; }

The second form of the if statement introduces an else clause that is executed when expression is false. Its syntax is:

if (expression) statement1 else statement2

This form of the statement executes statement1 if expression is truthy and executes statement2 if expression is falsy. For example:

if (n == 1) console.log("You have 1 new message."); else console.log("You have " + n + " new messages.");

When you have nested if statements with else clauses, some caution is required to ensure that the else clause goes with the appropriate if statement. Consider the following lines:

i = j = 1; k = 2; if (i == j) if (j == k) console.log("i equals k"); else console.log("i doesn't equal j"); // WRONG!!

In this example, the inner if statement forms the single statement allowed by the syntax of the outer if statement. Unfortunately, it is not clear (except from the hint given by the indentation) which if the else goes with. And in this example, the indentation is wrong, because a JavaScript interpreter actually interprets the previous example as:

if (i == j) { if (j == k) console.log("i equals k"); else console.log("i doesn't equal j"); // OOPS! }

The rule in JavaScript (as in most programming languages) is that by default an else clause is part of the nearest if statement. To make this example less ambiguous and easier to read, understand, maintain, and debug, you should use curly braces:

if (i == j) { if (j == k) { console.log("i equals k"); } } else { // What a difference the location of a curly brace makes! console.log("i doesn't equal j"); }

Although it is not the style used in this book, many programmers make a habit of enclosing the bodies of if and else statements (as well as other compound statements, such as while loops) within curly braces, even when the body consists of only a single statement. Doing so consistently can prevent the sort of problem just shown.

else if

The if/else statement evaluates an expression and executes one of two pieces of code, depending on the outcome. But what about when you need to execute one of many pieces of code? One way to do this is with an else if statement. else if is not really a JavaScript statement, but simply a frequently used programming idiom that results when repeated if/else statements are used:

if (n == 1) { // Execute code block #1 } else if (n == 2) { // Execute code block #2 } else if (n == 3) { // Execute code block #3 } else { // If all else fails, execute block #4 }

There is nothing special about this code. It is just a series of if statements, where each following if is part of the else clause of the previous statement. Using the else if idiom is preferable to, and more legible than, writing these statements out in their syntactically equivalent, fully nested form:

if (n == 1) { // Execute code block #1 } else { if (n == 2) { // Execute code block #2 } else { if (n == 3) { // Execute code block #3 } else { // If all else fails, execute block #4 } } }

switch

An if statement causes a branch in the flow of a program’s execution, and you can use the else if idiom to perform a multiway branch. This is not the best solution, however, when all of the branches depend on the value of the same expression. In this case, it is wasteful to repeatedly evaluate that expression in multiple if statements.

The switch statement handles exactly this situation. The switch keyword is followed by an expression in parentheses and a block of code in curly braces:

switch(expression) { statements }

However, the full syntax of a switch statement is more complex than this. Various locations in the block of code are labeled with the case keyword followed by an expression and a colon. case is like a labeled statement, except that instead of giving the labeled statement a name, it associates an expression with the statement. When a switch executes, it computes the value of expression and then looks for a case label whose expression evaluates to the same value (where sameness is determined by the === operator). If it finds one, it starts executing the block of code at the statement labeled by the case. If it does not find a case with a matching value, it looks for a statement labeled default:. If there is no default: label, the switch statement skips the block of code altogether.

switch is a confusing statement to explain; its operation becomes much clearer with an example. The following switch statement is equivalent to the repeated if/else statements shown in the previous section:

switch(n) { case 1: // Start here if n == 1 // Execute code block #1. break; // Stop here case 2: // Start here if n == 2 // Execute code block #2. break; // Stop here case 3: // Start here if n == 3 // Execute code block #3. break; // Stop here default: // If all else fails... // Execute code block #4. break; // stop here }

Note the break keyword used at the end of each case in the code above. The break statement, described later in this chapter, causes the interpreter to jump to the end (or「break out」) of the switch statement and continue with the statement that follows it. The case clauses in a switch statement specify only the starting point of the desired code; they do not specify any ending point. In the absence of break statements, a switch statement begins executing its block of code at the case label that matches the value of its expression and continues executing statements until it reaches the end of the block. On rare occasions, it is useful to write code like this that「falls through」from one case label to the next, but 99 percent of the time you should be careful to end every case with a break statement. (When using switch inside a function, however, you may use a return statement instead of a break statement. Both serve to terminate the switch statement and prevent execution from falling through to the next case.)

Here is a more realistic example of the switch statement; it converts a value to a string in a way that depends on the type of the value:

function convert(x) { switch(typeof x) { case 'number': // Convert the number to a hexadecimal integer return x.toString(16); case 'string': // Return the string enclosed in quotes return '"' + x + '"'; default: // Convert any other type in the usual way return String(x); } }

Note that in the two previous examples, the case keywords are followed by number and string literals, respectively. This is how the switch statement is most often used in practice, but note that the ECMAScript standard allows each case to be followed by an arbitrary expression.

The switch statement first evaluates the expression that follows the switch keyword and then evaluates the case expressions, in the order in which they appear, until it finds a value that matches.[4] The matching case is determined using the === identity operator, not the == equality operator, so the expressions must match without any type conversion.

Because not all of the case expressions are evaluated each time the switch statement is executed, you should avoid using case expressions that contain side effects such as function calls or assignments. The safest course is simply to limit your case expressions to constant expressions.

As explained earlier, if none of the case expressions match the switch expression, the switch statement begins executing its body at the statement labeled default:. If there is no default: label, the switch statement skips its body altogether. Note that in the examples above, the default: label appears at the end of the switch body, following all the case labels. This is a logical and common place for it, but it can actually appear anywhere within the body of the statement.

* * *

[4] The fact that the case expressions are evaluated at run-time makes the JavaScript switch statement much different from (and less efficient than) the switch statement of C, C++, and Java. In those languages, the case expressions must be compile-time constants of the same type, and switch statements can often compile down to highly efficient jump tables.

Loops

To understand conditional statements, we imagined the JavaScript interpreter following a branching path through your source code. The looping statements are those that bend that path back upon itself to repeat portions of your code. JavaScript has four looping statements: while, do/while, for, and for/in. The subsections below explain each in turn. One common use for loops is to iterate over the elements of an array. Iterating Arrays discusses this kind of loop in detail and covers special looping methods defined by the Array class.

while

Just as the if statement is JavaScript’s basic conditional, the while statement is JavaScript’s basic loop. It has the following syntax:

while (expression) statement

To execute a while statement, the interpreter first evaluates expression. If the value of the expression is falsy, then the interpreter skips over the statement that serves as the loop body and moves on to the next statement in the program. If, on the other hand, the expression is truthy, the interpreter executes the statement and repeats, jumping back to the top of the loop and evaluating expression again. Another way to say this is that the interpreter executes statement repeatedly while the expression is truthy. Note that you can create an infinite loop with the syntax while(true).

Usually, you do not want JavaScript to perform exactly the same operation over and over again. In almost every loop, one or more variables change with each iteration of the loop. Since the variables change, the actions performed by executing statement may differ each time through the loop. Furthermore, if the changing variable or variables are involved in expression, the value of the expression may be different each time through the loop. This is important; otherwise, an expression that starts off truthy would never change, and the loop would never end! Here is an example of a while loop that prints the numbers from 0 to 9:

var count = 0; while (count < 10) { console.log(count); count++; }

As you can see, the variable count starts off at 0 and is incremented each time the body of the loop runs. Once the loop has executed 10 times, the expression becomes false (i.e., the variable count is no longer less than 10), the while statement finishes, and the interpreter can move on to the next statement in the program. Many loops have a counter variable like count. The variable names i, j, and k are commonly used as loop counters, though you should use more descriptive names if it makes your code easier to understand.

do/while

The do/while loop is like a while loop, except that the loop expression is tested at the bottom of the loop rather than at the top. This means that the body of the loop is always executed at least once. The syntax is:

do statement while (expression);

The do/while loop is less commonly used than its while cousin—in practice, it is somewhat uncommon to be certain that you want a loop to execute at least once. Here’s an example of a do/while loop:

function printArray(a) { var len = a.length, i = 0; if (len == 0) console.log("Empty Array"); else { do { console.log(a[i]); } while (++i < len); } }

There are a couple of syntactic differences between the do/while loop and the ordinary while loop. First, the do loop requires both the do keyword (to mark the beginning of the loop) and the while keyword (to mark the end and introduce the loop condition). Also, the do loop must always be terminated with a semicolon. The while loop doesn’t need a semicolon if the loop body is enclosed in curly braces.

for

The for statement provides a looping construct that is often more convenient than the while statement. The for statement simplifies loops that follow a common pattern. Most loops have a counter variable of some kind. This variable is initialized before the loop starts and is tested before each iteration of the loop. Finally, the counter variable is incremented or otherwise updated at the end of the loop body, just before the variable is tested again. In this kind of loop, the initialization, the test, and the update are the three crucial manipulations of a loop variable. The for statement encodes each of these three manipulations as an expression and makes those expressions an explicit part of the loop syntax:

for(initialize ; test ; increment) statement

initialize, test, and increment are three expressions (separated by semicolons) that are responsible for initializing, testing, and incrementing the loop variable. Putting them all in the first line of the loop makes it easy to understand what a for loop is doing and prevents mistakes such as forgetting to initialize or increment the loop variable.

The simplest way to explain how a for loop works is to show the equivalent while loop[5]:

initialize; while(test) { statement increment; }

In other words, the initialize expression is evaluated once, before the loop begins. To be useful, this expression must have side effects (usually an assignment). JavaScript also allows initialize to be a var variable declaration statement so that you can declare and initialize a loop counter at the same time. The test expression is evaluated before each iteration and controls whether the body of the loop is executed. If test evaluates to a truthy value, the statement that is the body of the loop is executed. Finally, the increment expression is evaluated. Again, this must be an expression with side effects in order to be useful. Generally, either it is an assignment expression, or it uses the ++ or -- operators.

We can print the numbers from 0 to 9 with a for loop like the following. Contrast it with the equivalent while loop shown in the previous section:

for(var count = 0; count < 10; count++) console.log(count);

Loops can become a lot more complex than this simple example, of course, and sometimes multiple variables change with each iteration of the loop. This situation is the only place that the comma operator is commonly used in JavaScript; it provides a way to combine multiple initialization and increment expressions into a single expression suitable for use in a for loop:

var i,j; for(i = 0, j = 10 ; i < 10 ; i++, j--) sum += i * j;

In all our loop examples so far, the loop variable has been numeric. This is quite common but is not necessary. The following code uses a for loop to traverse a linked list data structure and return the last object in the list (i.e., the first object that does not have a next property):

function tail(o) { // Return the tail of linked list o for(; o.next; o = o.next) /* empty */ ; // Traverse while o.next is truthy return o; }

Note that the code above has no initialize expression. Any of the three expressions may be omitted from a for loop, but the two semicolons are required. If you omit the test expression, the loop repeats forever, and for(;;) is another way of writing an infinite loop, like while(true).

for/in

The for/in statement uses the for keyword, but it is a completely different kind of loop than the regular for loop. A for/in loop looks like this:

for (variable in object) statement

variable typically names a variable, but it may be any expression that evaluates to an lvalue (Lvalues) or a var statement that declares a single variable—it must be something suitable as the left side of an assignment expression. object is an expression that evaluates to an object. As usual, statement is the statement or statement block that serves as the body of the loop.

It is easy to use a regular for loop to iterate through the elements of an array:

for(var i = 0; i < a.length; i++) // Assign array indexes to variable i console.log(a[i]); // Print the value of each array element

The for/in loop makes it easy to do the same for the properties of an object:

for(var p in o) // Assign property names of o to variable p console.log(o[p]); // Print the value of each property

To execute a for/in statement, the JavaScript interpreter first evaluates the object expression. If it evaluates to null or undefined, the interpreter skips the loop and moves on to the next statement.[6] If the expression evaluates to a primitive value, that value is converted to its equivalent wrapper object (Wrapper Objects). Otherwise, the expression is already an object. The interpreter now executes the body of the loop once for each enumerable property of the object. Before each iteration, however, the interpreter evaluates the variable expression and assigns the name of the property (a string value) to it.

Note that the variable in the for/in loop may be an arbitrary expression, as long as it evaluates to something suitable for the left side of an assignment. This expression is evaluated each time through the loop, which means that it may evaluate differently each time. For example, you can use code like the following to copy the names of all object properties into an array:

var o = {x:1, y:2, z:3}; var a = [], i = 0; for(a[i++] in o) /* empty */;

JavaScript arrays are simply a specialized kind of object and array indexes are object properties that can be enumerated with a for/in loop. For example, following the code above with this line enumerates the array indexes 0, 1, and 2:

for(i in a) console.log(i);

The for/in loop does not actually enumerate all properties of an object, only the enumerable properties (see Property Attributes). The various built-in methods defined by core JavaScript are not enumerable. All objects have a toString() method, for example, but the for/in loop does not enumerate this toString property. In addition to built-in methods, many other properties of the built-in objects are nonenumerable. All properties and methods defined by your code are enumerable, however. (But in ECMAScript 5, you can make them nonenumerable using techniques explained in Property Attributes.) User-defined inherited properties (see Inheritance) are also enumerated by the for/in loop.

If the body of a for/in loop deletes a property that has not yet been enumerated, that property will not be enumerated. If the body of the loop defines new properties on the object, those properties will generally not be enumerated. (Some implementations may enumerate inherited properties that are added after the loop begins, however.)

Property enumeration order

The ECMAScript specification does not specify the order in which the for/in loop enumerates the properties of an object. In practice, however, JavaScript implementations from all major browser vendors enumerate the properties of simple objects in the order in which they were defined, with older properties enumerated first. If an object was created as an object literal, its enumeration order is the same order that the properties appear in the literal. There are sites and libraries on the Web that rely on this enumeration order, and browser vendors are unlikely to change it.

The paragraph above specifies an interoperable property enumeration order for「simple」objects. Enumeration order becomes implementation dependent (and noninteroperable) if:

The object inherits enumerable properties;

the object has properties that are integer array indexes;

you have used delete to delete existing properties of the object; or

you have used Object.defineProperty() (Property Attributes) or similar methods to alter property attributes of the object.

Typically (but not in all implementations), inherited properties (see Inheritance) are enumerated after all the noninherited「own」properties of an object, but are also enumerated in the order in which they were defined. If an object inherits properties from more than one「prototype」(see Prototypes)—i.e., if it has more than one object in its「prototype chain」—then the properties of each prototype object in the chain are enumerated in creation order before enumerating the properties of the next object. Some (but not all) implementations enumerate array properties in numeric order rather than creation order, but they revert to creation order if the array is given other non-numeric properties as well or if the array is sparse (i.e., if some array indexes are missing).

* * *

[5] When we consider the continue statement in continue, we’ll see that this while loop is not an exact equivalent of the for loop.

[6] ECMAScript 3 implementations may instead throw a TypeError in this case.

Jumps

Another category of JavaScript statements are jump statements. As the name implies, these cause the JavaScript interpreter to jump to a new location in the source code. The break statement makes the interpreter jump to the end of a loop or other statement. continue makes the interpreter skip the rest of the body of a loop and jump back to the top of a loop to begin a new iteration. JavaScript allows statements to be named, or labeled, and the break and continue can identify the target loop or other statement label.

The return statement makes the interpreter jump from a function invocation back to the code that invoked it and also supplies the value for the invocation. The throw statement raises, or「throws,」an exception and is designed to work with the try/catch/finally statement, which establishes a block of exception handling code. This is a complicated kind of jump statement: when an exception is thrown, the interpreter jumps to the nearest enclosing exception handler, which may be in the same function or up the call stack in an invoking function.

Details of each of these jump statements are in the sections that follow.

Labeled Statements

Any statement may be labeled by preceding it with an identifier and a colon:

identifier: statement

By labeling a statement, you give it a name that you can use to refer to it elsewhere in your program. You can label any statement, although it is only useful to label statements that have bodies, such as loops and conditionals. By giving a loop a name, you can use break and continue statements inside the body of the loop to exit the loop or to jump directly to the top of the loop to begin the next iteration. break and continue are the only JavaScript statements that use statement labels; they are covered later in this chapter. Here is an example of a labeled while loop and a continue statement that uses the label.

mainloop: while(token != null) { // Code omitted... continue mainloop; // Jump to the next iteration of the named loop // More code omitted... }

The identifier you use to label a statement can be any legal JavaScript identifier that is not a reserved word. The namespace for labels is different than the namespace for variables and functions, so you can use the same identifier as a statement label and as a variable or function name. Statement labels are defined only within the statement to which they apply (and within its substatements, of course). A statement may not have the same label as a statement that contains it, but two statements may have the same label as long as neither one is nested within the other. Labeled statements may themselves be labeled. Effectively, this means that any statement may have multiple labels.

break

The break statement, used alone, causes the innermost enclosing loop or switch statement to exit immediately. Its syntax is simple:

break;

Because it causes a loop or switch to exit, this form of the break statement is legal only if it appears inside one of these statements.

You’ve already seen examples of the break statement within a switch statement. In loops, it is typically used to exit prematurely when, for whatever reason, there is no longer any need to complete the loop. When a loop has complex termination conditions, it is often easier to implement some of these conditions with break statements rather than trying to express them all in a single loop expression. The following code searches the elements of an array for a particular value. The loop terminates in the normal way when it reaches the end of the array; it terminates with a break statement if it finds what it is looking for in the array:

for(var i = 0; i < a.length; i++) { if (a[i] == target) break; }

JavaScript also allows the break keyword to be followed by a statement label (just the identifier, with no colon):

break labelname;

When break is used with a label, it jumps to the end of, or terminates, the enclosing statement that has the specified label. It is a syntax error to use break in this form if there is no enclosing statement with the specified label. With this form of the break statement, the named statement need not be a loop or switch: break can「break out of」any enclosing statement. This statement can even be a statement block grouped within curly braces for the sole purpose of naming the block with a label.

A newline is not allowed between the break keyword and the labelname. This is a result of JavaScript’s automatic insertion of omitted semicolons: if you put a line terminator between the break keyword and the label that follows, JavaScript assumes you meant to use the simple, unlabeled form of the statement and treats the line terminator as a semicolon. (See Optional Semicolons.)

You need the labeled form of the break statement when you want to break out of a statement that is not the nearest enclosing loop or a switch. The following code demonstrates:

var matrix = getData(); // Get a 2D array of numbers from somewhere // Now sum all the numbers in the matrix. var sum = 0, success = false; // Start with a labeled statement that we can break out of if errors occur compute_sum: if (matrix) { for(var x = 0; x < matrix.length; x++) { var row = matrix[x]; if (!row) break compute_sum; for(var y = 0; y < row.length; y++) { var cell = row[y]; if (isNaN(cell)) break compute_sum; sum += cell; } } success = true; } // The break statements jump here. If we arrive here with success == false // then there was something wrong with the matrix we were given. // Otherwise sum contains the sum of all cells of the matrix.

Finally, note that a break statement, with or without a label, can not transfer control across function boundaries. You cannot label a function definition statement, for example, and then use that label inside the function.

continue

The continue statement is similar to the break statement. Instead of exiting a loop, however, continue restarts a loop at the next iteration. The continue statement’s syntax is just as simple as the break statement’s:

continue;

The continue statement can also be used with a label:

continue labelname;

The continue statement, in both its labeled and unlabeled forms, can be used only within the body of a loop. Using it anywhere else causes a syntax error.

When the continue statement is executed, the current iteration of the enclosing loop is terminated, and the next iteration begins. This means different things for different types of loops:

In a while loop, the specified expression at the beginning of the loop is tested again, and if it’s true, the loop body is executed starting from the top.

In a do/while loop, execution skips to the bottom of the loop, where the loop condition is tested again before restarting the loop at the top.

In a for loop, the increment expression is evaluated, and the test expression is tested again to determine if another iteration should be done.

In a for/in loop, the loop starts over with the next property name being assigned to the specified variable.

Note the difference in behavior of the continue statement in the while and for loops: a while loop returns directly to its condition, but a for loop first evaluates its increment expression and then returns to its condition. Earlier we considered the behavior of the for loop in terms of an「equivalent」while loop. Because the continue statement behaves differently for these two loops, however, it is not actually possible to perfectly simulate a for loop with a while loop alone.

The following example shows an unlabeled continue statement being used to skip the rest of the current iteration of a loop when an error occurs:

for(i = 0; i < data.length; i++) { if (!data[i]) continue; // Can't proceed with undefined data total += data[i]; }

Like the break statement, the continue statement can be used in its labeled form within nested loops, when the loop to be restarted is not the immediately enclosing loop. Also, like the break statement, line breaks are not allowed between the continue statement and its labelname.

return

Recall that function invocations are expressions and that all expressions have values. A return statement within a function specifies the value of invocations of that function. Here’s the syntax of the return statement:

return expression;

A return statement may appear only within the body of a function. It is a syntax error for it to appear anywhere else. When the return statement is executed, the function that contains it returns the value of expression to its caller. For example:

function square(x) { return x*x; } // A function that has a return statement square(2) // This invocation evaluates to 4

With no return statement, a function invocation simply executes each of the statements in the function body in turn until it reaches the end of the function, and then returns to its caller. In this case, the invocation expression evaluates to undefined. The return statement often appears as the last statement in a function, but it need not be last: a function returns to its caller when a return statement is executed, even if there are other statements remaining in the function body.

The return statement can also be used without an expression to make the function return undefined to its caller. For example:

function display_object(o) { // Return immediately if the argument is null or undefined. if (!o) return; // Rest of function goes here... }

Because of JavaScript’s automatic semicolon insertion (Optional Semicolons), you cannot include a line break between the return keyword and the expression that follows it.

throw

An exception is a signal that indicates that some sort of exceptional condition or error has occurred. To throw an exception is to signal such an error or exceptional condition. To catch an exception is to handle it—to take whatever actions are necessary or appropriate to recover from the exception. In JavaScript, exceptions are thrown whenever a runtime error occurs and whenever the program explicitly throws one using the throw statement. Exceptions are caught with the try/catch/finally statement, which is described in the next section.

The throw statement has the following syntax:

throw expression;

expression may evaluate to a value of any type. You might throw a number that represents an error code or a string that contains a human-readable error message. The Error class and its subclasses are used when the JavaScript interpreter itself throws an error, and you can use them as well. An Error object has a name property that specifies the type of error and a message property that holds the string passed to the constructor function (see the Error class in the reference section). Here is an example function that throws an Error object when invoked with an invalid argument:

function factorial(x) { // If the input argument is invalid, throw an exception! if (x < 0) throw new Error("x must not be negative"); // Otherwise, compute a value and return normally for(var f = 1; x > 1; f *= x, x--) /* empty */ ; return f; }

When an exception is thrown, the JavaScript interpreter immediately stops normal program execution and jumps to the nearest exception handler. Exception handlers are written using the catch clause of the try/catch/finally statement, which is described in the next section. If the block of code in which the exception was thrown does not have an associated catch clause, the interpreter checks the next highest enclosing block of code to see if it has an exception handler associated with it. This continues until a handler is found. If an exception is thrown in a function that does not contain a try/catch/finally statement to handle it, the exception propagates up to the code that invoked the function. In this way, exceptions propagate up through the lexical structure of JavaScript methods and up the call stack. If no exception handler is ever found, the exception is treated as an error and is reported to the user.

try/catch/finally

The try/catch/finally statement is JavaScript’s exception handling mechanism. The try clause of this statement simply defines the block of code whose exceptions are to be handled. The try block is followed by a catch clause, which is a block of statements that are invoked when an exception occurs anywhere within the try block. The catch clause is followed by a finally block containing cleanup code that is guaranteed to be executed, regardless of what happens in the try block. Both the catch and finally blocks are optional, but a try block must be accompanied by at least one of these blocks. The try, catch, and finally blocks all begin and end with curly braces. These braces are a required part of the syntax and cannot be omitted, even if a clause contains only a single statement.

The following code illustrates the syntax and purpose of the try/catch/finally statement:

try { // Normally, this code runs from the top of the block to the bottom // without problems. But it can sometimes throw an exception, // either directly, with a throw statement, or indirectly, by calling // a method that throws an exception. } catch (e) { // The statements in this block are executed if, and only if, the try // block throws an exception. These statements can use the local variable // e to refer to the Error object or other value that was thrown. // This block may handle the exception somehow, may ignore the // exception by doing nothing, or may rethrow the exception with throw. } finally { // This block contains statements that are always executed, regardless of // what happens in the try block. They are executed whether the try // block terminates: // 1) normally, after reaching the bottom of the block // 2) because of a break, continue, or return statement // 3) with an exception that is handled by a catch clause above // 4) with an uncaught exception that is still propagating }

Note that the catch keyword is followed by an identifier in parentheses. This identifier is like a function parameter. When an exception is caught, the value associated with the exception (an Error object, for example) is assigned to this parameter. Unlike regular variables, the identifier associated with a catch clause has block scope—it is only defined within the catch block.

Here is a realistic example of the try/catch statement. It uses the factorial() method defined in the previous section and the client-side JavaScript methods prompt() and alert() for input and output:

try { // Ask the user to enter a number var n = Number(prompt("Please enter a positive integer", "")); // Compute the factorial of the number, assuming the input is valid var f = factorial(n); // Display the result alert(n + "! = " + f); } catch (ex) { // If the user's input was not valid, we end up here alert(ex); // Tell the user what the error is }

This example is a try/catch statement with no finally clause. Although finally is not used as often as catch, it can be useful. However, its behavior requires additional explanation. The finally clause is guaranteed to be executed if any portion of the try block is executed, regardless of how the code in the try block completes. It is generally used to clean up after the code in the try clause.

In the normal case, the JavaScript interpreter reaches the end of the try block and then proceeds to the finally block, which performs any necessary cleanup. If the interpreter left the try block because of a return, continue, or break statement, the finally block is executed before the interpreter jumps to its new destination.

If an exception occurs in the try block and there is an associated catch block to handle the exception, the interpreter first executes the catch block and then the finally block. If there is no local catch block to handle the exception, the interpreter first executes the finally block and then jumps to the nearest containing catch clause.

If a finally block itself causes a jump with a return, continue, break, or throw statement, or by calling a method that throws an exception, the interpreter abandons whatever jump was pending and performs the new jump. For example, if a finally clause throws an exception, that exception replaces any exception that was in the process of being thrown. If a finally clause issues a return statement, the method returns normally, even if an exception has been thrown and has not yet been handled.

try and finally can be used together without a catch clause. In this case, the finally block is simply cleanup code that is guaranteed to be executed, regardless of what happens in the try block. Recall that we can’t completely simulate a for loop with a while loop because the continue statement behaves differently for the two loops. If we add a try/finally statement, we can write a while loop that works like a for loop and that handles continue statements correctly:

// Simulate for( initialize ; test ; increment ) body; initialize ; while( test ) { try { body ; } finally { increment ; } }

Note, however, that a body that contains a break statement behaves slightly differently (causing an extra increment before exiting) in the while loop than it does in the for loop, so even with the finally clause, it is not possible to completely simulate the for loop with while.

Miscellaneous Statements

This section describes the remaining three JavaScript statements—with, debugger, and use strict.

with

In The Scope Chain, we discussed the scope chain—a list of objects that are searched, in order, to perform variable name resolution. The with statement is used to temporarily extend the scope chain. It has the following syntax:

with (object) statement

This statement adds object to the front of the scope chain, executes statement, and then restores the scope chain to its original state.

The with statement is forbidden in strict mode (see「use strict」) and should be considered deprecated in non-strict mode: avoid using it whenever possible. JavaScript code that uses with is difficult to optimize and is likely to run more slowly than the equivalent code written without the with statement.

The common use of the with statement is to make it easier to work with deeply nested object hierarchies. In client-side JavaScript, for example, you may have to type expressions like this one to access elements of an HTML form:

document.forms[0].address.value

If you need to write expressions like this a number of times, you can use the with statement to add the form object to the scope chain:

with(document.forms[0]) { // Access form elements directly here. For example: name.value = ""; address.value = ""; email.value = ""; }

This reduces the amount of typing you have to do: you no longer need to prefix each form property name with document.forms[0]. That object is temporarily part of the scope chain and is automatically searched when JavaScript needs to resolve an identifier such as address. It is just as simple, of course, to avoid the with statement and write the code above like this:

var f = document.forms[0]; f.name.value = ""; f.address.value = ""; f.email.value = "";

Keep in mind that the scope chain is used only when looking up identifiers, not when creating new ones. Consider this code:

with(o) x = 1;

If the object o has a property x, then this code assigns the value 1 to that property. But if x is not defined in o, this code is the same as x = 1 without the with statement. It assigns to a local or global variable named x, or creates a new property of the global object. A with statement provides a shortcut for reading properties of o, but not for creating new properties of o.

debugger

The debugger statement normally does nothing. If, however, a debugger program is available and is running, then an implementation may (but is not required to) perform some kind of debugging action. In practice, this statement acts like a breakpoint: execution of JavaScript code stops and you can use the debugger to print variables’ values, examine the call stack, and so on. Suppose, for example, that you are getting an exception in your function f() because it is being called with an undefined argument, and you can’t figure out where this call is coming from. To help you in debugging this problem, you might alter f() so that it begins like this:

function f(o) { if (o === undefined) debugger; // Temporary line for debugging purposes ... // The rest of the function goes here. }

Now, when f() is called with no argument, execution will stop, and you can use the debugger to inspect the call stack and find out where this incorrect call is coming from.

debugger was formally added to the language by ECMAScript 5, but it has been implemented by major browser vendors for quite some time. Note that it is not enough to have a debugger available: the debugger statement won’t start the debugger for you. If a debugger is already running, however, this statement will cause a breakpoint. If you use the Firebug debugging extension for Firefox, for example, you must have Firebug enabled for the web page you want to debug in order for the debugger statement to work.

「use strict」

