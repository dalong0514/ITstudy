CharacterMeaning

i Perform case-insensitive matching.

g Perform a global match—that is, find all matches rather than stopping after the first match.

m Multiline mode. ^ matches beginning of line or beginning of string, and $ matches end of line or end of string.

* * *

[17] Perl regular expression features that are not supported by ECMAScript include the s (single-line mode) and x (extended syntax) flags; the \a, \e, \l, \u, \L, \U, \E, \Q, \A, \Z, \z, and \G escape sequences; the (?<= positive look-behind anchor and the (?<! negative look-behind anchor; and the (?# comment and the other extended (? syntaxes.

[18] Except within a character class (square brackets), where \b matches the backspace character.

String Methods for Pattern Matching

Until now, this chapter has discussed the grammar used to create regular expressions, but it hasn’t examined how those regular expressions can actually be used in JavaScript code. This section discusses methods of the String object that use regular expressions to perform pattern matching and search-and-replace operations. The sections that follow this one continue the discussion of pattern matching with JavaScript regular expressions by discussing the RegExp object and its methods and properties. Note that the discussion that follows is merely an overview of the various methods and properties related to regular expressions. As usual, complete details can be found in Part III.

Strings support four methods that use regular expressions. The simplest is search(). This method takes a regular-expression argument and returns either the character position of the start of the first matching substring or −1 if there is no match. For example, the following call returns 4:

"JavaScript".search(/script/i);

If the argument to search() is not a regular expression, it is first converted to one by passing it to the RegExp constructor. search() does not support global searches; it ignores the g flag of its regular expression argument.

The replace() method performs a search-and-replace operation. It takes a regular expression as its first argument and a replacement string as its second argument. It searches the string on which it is called for matches with the specified pattern. If the regular expression has the g flag set, the replace() method replaces all matches in the string with the replacement string; otherwise, it replaces only the first match it finds. If the first argument to replace() is a string rather than a regular expression, the method searches for that string literally rather than converting it to a regular expression with the RegExp() constructor, as search() does. As an example, you can use replace() as follows to provide uniform capitalization of the word「JavaScript」throughout a string of text:

// No matter how it is capitalized, replace it with the correct capitalization text.replace(/javascript/gi, "JavaScript");

replace() is more powerful than this, however. Recall that parenthesized subexpressions of a regular expression are numbered from left to right and that the regular expression remembers the text that each subexpression matches. If a $ followed by a digit appears in the replacement string, replace() replaces those two characters with the text that matches the specified subexpression. This is a very useful feature. You can use it, for example, to replace straight quotes in a string with curly quotes, simulated with ASCII characters:

// A quote is a quotation mark, followed by any number of // nonquotation-mark characters (which we remember), followed // by another quotation mark. var quote = /"([^"]*)"/g; // Replace the straight quotation marks with curly quotes, // leaving the quoted text (stored in $1) unchanged. text.replace(quote, '「$1」');

The replace() method has other important features as well, which are described in the String.replace() reference page in Part III. Most notably, the second argument to replace() can be a function that dynamically computes the replacement string.

The match() method is the most general of the String regular-expression methods. It takes a regular expression as its only argument (or converts its argument to a regular expression by passing it to the RegExp() constructor) and returns an array that contains the results of the match. If the regular expression has the g flag set, the method returns an array of all matches that appear in the string. For example:

"1 plus 2 equals 3".match(/\d+/g) // returns ["1", "2", "3"]

If the regular expression does not have the g flag set, match() does not do a global search; it simply searches for the first match. However, match() returns an array even when it does not perform a global search. In this case, the first element of the array is the matching string, and any remaining elements are the parenthesized subexpressions of the regular expression. Thus, if match() returns an array a, a[0] contains the complete match, a[1] contains the substring that matched the first parenthesized expression, and so on. To draw a parallel with the replace() method, a[ n ] holds the contents of $ n.

For example, consider parsing a URL with the following code:

var url = /(\w+):\/\/([\w.]+)\/(\S*)/; var text = "Visit my blog at http://www.example.com/~david"; var result = text.match(url); if (result != null) { var fullurl = result[0]; // Contains "http://www.example.com/~david" var protocol = result[1]; // Contains "http" var host = result[2]; // Contains "www.example.com" var path = result[3]; // Contains "~david" }

It is worth noting that passing a nonglobal regular expression to the match() method of a string is actually the same as passing the string to the exec() method of the regular expression: the returned array has index and input properties, as described for the exec() method below.

The last of the regular-expression methods of the String object is split(). This method breaks the string on which it is called into an array of substrings, using the argument as a separator. For example:

"123,456,789".split(","); // Returns ["123","456","789"]

The split() method can also take a regular expression as its argument. This ability makes the method more powerful. For example, you can now specify a separator character that allows an arbitrary amount of whitespace on either side:

"1, 2, 3, 4, 5".split(/\s*,\s*/); // Returns ["1","2","3","4","5"]

The split() method has other features as well. See the String.split() entry in Part III for complete details.

The RegExp Object

As mentioned at the beginning of this chapter, regular expressions are represented as RegExp objects. In addition to the RegExp() constructor, RegExp objects support three methods and a number of properties. RegExp pattern-matching methods and properties are described in the next two sections.

The RegExp() constructor takes one or two string arguments and creates a new RegExp object. The first argument to this constructor is a string that contains the body of the regular expression—the text that would appear within slashes in a regular-expression literal. Note that both string literals and regular expressions use the \ character for escape sequences, so when you pass a regular expression to RegExp() as a string literal, you must replace each \ character with \\. The second argument to RegExp() is optional. If supplied, it indicates the regular-expression flags. It should be g, i, m, or a combination of those letters.

For example:

// Find all five-digit numbers in a string. Note the double \\ in this case. var zipcode = new RegExp("\\d{5}", "g");

The RegExp() constructor is useful when a regular expression is being dynamically created and thus cannot be represented with the regular-expression literal syntax. For example, to search for a string entered by the user, a regular expression must be created at runtime with RegExp().

RegExp Properties

Each RegExp object has five properties. The source property is a read-only string that contains the text of the regular expression. The global property is a read-only boolean value that specifies whether the regular expression has the g flag. The ignoreCase property is a read-only boolean value that specifies whether the regular expression has the i flag. The multiline property is a read-only boolean value that specifies whether the regular expression has the m flag. The final property is lastIndex, a read/write integer. For patterns with the g flag, this property stores the position in the string at which the next search is to begin. It is used by the exec() and test() methods, described below.

RegExp Methods

RegExp objects define two methods that perform pattern-matching operations; they behave similarly to the String methods described earlier. The main RegExp pattern-matching method is exec(). It is similar to the String match() method described in String Methods for Pattern Matching, except that it is a RegExp method that takes a string, rather than a String method that takes a RegExp. The exec() method executes a regular expression on the specified string. That is, it searches the string for a match. If it finds none, it returns null. If it does find one, however, it returns an array just like the array returned by the match() method for nonglobal searches. Element 0 of the array contains the string that matched the regular expression, and any subsequent array elements contain the substrings that matched any parenthesized subexpressions. Furthermore, the index property contains the character position at which the match occurred, and the input property refers to the string that was searched.

Unlike the match() method, exec() returns the same kind of array whether or not the regular expression has the global g flag. Recall that match() returns an array of matches when passed a global regular expression. exec(), by contrast, always returns a single match and provides complete information about that match. When exec() is called on a regular expression that has the g flag, it sets the lastIndex property of the regular-expression object to the character position immediately following the matched substring. When exec() is invoked a second time for the same regular expression, it begins its search at the character position indicated by the lastIndex property. If exec() does not find a match, it resets lastIndex to 0. (You can also set lastIndex to 0 at any time, which you should do whenever you quit a search before you find the last match in one string and begin searching another string with the same RegExp object.) This special behavior allows you to call exec() repeatedly in order to loop through all the regular expression matches in a string. For example:

var pattern = /Java/g; var text = "JavaScript is more fun than Java!"; var result; while((result = pattern.exec(text)) != null) { alert("Matched '" + result[0] + "'" + " at position " + result.index + "; next search begins at " + pattern.lastIndex); }

The other RegExp method is test(). test() is a much simpler method than exec(). It takes a string and returns true if the string contains a match for the regular expression:

var pattern = /java/i; pattern.test("JavaScript"); // Returns true

Calling test() is equivalent to calling exec() and returning true if the return value of exec() is not null. Because of this equivalence, the test() method behaves the same way as the exec() method when invoked for a global regular expression: it begins searching the specified string at the position specified by lastIndex, and if it finds a match, it sets lastIndex to the position of the character immediately following the match. Thus, you can loop through a string using the test() method just as you can with the exec() method.

The String methods search(), replace(), and match() do not use the lastIndexproperty as exec() and test() do. In fact, the String methods simply reset lastIndex to 0. If you use exec() or test() on a pattern that has the g flag set, and you are searching multiple strings, you must either find all the matches in each string so that lastIndex is automatically reset to zero (this happens when the last search fails), or you must explicitly set the lastIndex property to 0 yourself. If you forget to do this, you may start searching a new string at some arbitrary position within the string rather than from the beginning. If your RegExp doesn’t have the g flag set, then you don’t have to worry about any of this, of course. Keep in mind also that in ECMAScript 5 each evaluation of a regular expression literal creates a new RegExp object with its own lastIndex property, and this reduces the risk of accidentally using a「leftover」lastIndex value.

Chapter 11. JavaScript Subsets and Extensions

Until now, this book has described the complete and official JavaScript language, as standardized by ECMAScript 3 and ECMAScript 5. This chapter instead describes subsets and supersets of JavaScript. The subsets have been defined, for the most part, for security purposes: a script written using only a secure language subset can be executed safely even if it comes from an untrusted source such as an ad server. JavaScript Subsets describes a few of these subsets.

The ECMAScript 3 standard was published in 1999 and a decade elapsed before the standard was updated to ECMAScript 5 in 2009. Brendan Eich, the creator of JavaScript, continued to evolve the language during that decade (the ECMAScript specification explicitly allows language extensions) and, with the Mozilla project, released JavaScript versions 1.5, 1.6, 1.7, 1.8, and 1.8.1 in Firefox 1.0, 1.5, 2, 3, and 3.5. Some of the features of these extensions to JavaScript have been codified in ECMAScript 5, but many remain nonstandard. Future versions of ECMAScript are expected to standardize at least some of the remaining nonstandard features.

The Firefox browser supports these extensions, as does the Spidermonkey JavaScript interpreter that Firefox is based on. Mozilla’s Java-based JavaScript interpreter, Rhino, (see Scripting Java with Rhino) also supports most of the extensions. Because these language extensions are nonstandard, however, they will not be useful to web developers who require language compatibility across all browsers. They are documented in this chapter because:

they are quite powerful;

they may become standard in the future;

they can be used to write Firefox extensions;

they can be used in server-side JavaScript programming, when the underlying JavaScript engine is Spidermonkey or Rhino (see Scripting Java with Rhino).

After a preliminary section on language subsets, the rest of this chapter describes these language extensions. Because they are nonstandard, they are documented in tutorial style with less rigor than the language features described elsewhere in the book.

JavaScript Subsets

Most language subsets are defined to allow the secure execution of untrusted code. There is one interesting subset defined for different reasons. We’ll cover that one first, and then cover secure language subsets.

The Good Parts

Douglas Crockford’s short book JavaScript: The Good Parts (O’Reilly) describes a JavaScript subset that consists of the parts of the language that he thinks are worth using. The goal of this subset is to simplify the language, hide quirks and imperfections, and ultimately, make programming easier and programs better. Crockford explains his motivation:

Most programming languages contain good parts and bad parts. I discovered that I could be a better programmer by using only the good parts and avoiding the bad parts.

Crockford’s subset does not include the with and continue statements or the eval() function. It defines functions using function definition expressions only and does not include the function definition statement. The subset requires the bodies of loops and conditionals to be enclosed in curly braces: it does not allow the braces to be omitted if the body consists of a single statement. It requires any statement that does not end with a curly brace to be terminated with a semicolon.

The subset does not include the comma operator, the bitwise operators, or the ++ and -- operators. It also disallows == and != because of the type conversion they perform, requiring use of === and !== instead.

Since JavaScript does not have block scope, Crockford’s subset restricts the var statement to appear only at the top level of a function body and requires programmers to declare all of a function’s variables using a single var as the first statement in a function body. The subset discourages the use of global variables, but this is a coding convention rather than an actual language restriction.

Crockford’s online code-quality checking tool at http://jslint.com includes an option to enforce conformance to The Good Parts. In addition to ensuring that your code uses only the allowed features, the JSLint tool also enforces coding style rules, such as proper indentation.

Crockford’s book was written before the strict mode of ECMAScript 5 was defined, but many of the「bad parts」of JavaScript he seeks to discourage in his book are prohibited by the use of strict mode. With the adoption of the ECMAScript 5 standard, the JSLint tool now requires programs to include a「use strict」directive when「The Good Parts」option is selected.

Subsets for Security

The Good Parts is a language subset designed for aesthetic reasons and with a desire to improve programmer productivity. There is a larger class of subsets that have been designed for the purpose of safely running untrusted JavaScript in a secure container or「sandbox.」Secure subsets work by disallowing all language features and APIs that can allow code to break out of its sandbox and affect the global execution environment. Each subset is coupled with a static verifier that parses code to ensure that it conforms to the subset. Since language subsets that can be statically verified tend to be quite restrictive, some sandboxing systems define a larger, less restrictive subset and add a code transformation step that verifies that code conforms to the larger subset, transforms it to use a smaller language subset, and adds runtime checks where static analysis of the code is not sufficient to ensure security.

In order to allow JavaScript to be statically verified to be safe, a number of features must be removed:

eval() and the Function() constructor are not allowed in any secure subset because they allow the execution of arbitrary strings of code, and these strings cannot be statically analyzed.

The this keyword is forbidden or restricted because functions (in non-strict mode) can access the global object through this. Preventing access to the global object is one of the key purposes of any sandboxing system.

The with statement is often forbidden in secure subsets because it makes static code verification more difficult.

Certain global variables are not allowed in secure subsets. In client-side JavaScript, the browser window object does double-duty as the global object, so code is not allowed to refer to the window object. Similarly, the client-side document object defines methods that allow complete control over page content. This is too much power to give to untrusted code. Secure subsets can take two different approaches to global variables like document. They can forbid them entirely, and instead define a custom API that sandboxed code can use to access the limited portion of the web page that has been alloted to it. Alternatively, the「container」in which the sandboxed code is run can define a facade or proxy document object that implements only the safe parts of the standard DOM API.

Certain special properties and methods are forbidden in secure subsets because they give too much power to the sandboxed code. These typically include the caller and callee properties of the arguments object (though some subsets do not allow the arguments object to be used at all), the call() and apply() methods of functions, and the constructor and prototype properties. Nonstandard properties such as __proto__ are also forbidden. Some subsets blacklist unsafe properties and globals. Others whitelist a specific set of properties know to be safe.

Static analysis is sufficient to prevent access to special properties when the property access expression is written using the . operator. But property access with [] is more difficult because arbitrary string expressions within the square brackets cannot be statically analyzed. For this reason, secure subsets usually forbid the use of square brackets unless the argument is a numeric or string literal. Secure subsets replace the [] operators with global functions for querying and setting object properties—these functions perform runtime checks to ensure that they aren’t used to access forbidden properties.

Some of these restrictions, such as forbidding the use of eval() and the with statement, are not much of a burden for programmers, since these features are not commonly used in JavaScript programming. Others, such as the restriction on the use of square brackets for property access are quite onerous, and this is where code translation comes in. A translator can automatically transform the use of square brackets, for example, into a function call that includes runtime checks. Similar transformations can allow the safe use of the this keyword. There is a tradeoff, of course, between the safety of these runtime checks and execution speed of the sandboxed code.

A number of secure subsets have been implemented. Although a complete description of any subset is beyond the scope of this book, we’ll briefly describe some of the most important:

ADsafe

ADsafe (http://adsafe.org) was one of the first security subsets proposed. It was created by Douglas Crockford (who also defined The Good Parts subset). ADsafe relies on static verification only, and it uses JSLint (http://jslint.org) as its verifier. It forbids access to most global variables and defines an ADSAFE variable that provides access to a secure API, including special-purpose DOM methods. ADsafe is not in wide use, but it was an influential proof-of-concept that influenced other secure subsets.

dojox.secure

The dojox.secure subset (http://www.sitepen.com/blog/2008/08/01/secure-mashups-with-dojoxsecure/) is an extension to the Dojo toolkit (http://dojotoolkit.org) that was inspired by ADsafe. Like ADsafe, it is based on static verification of a restrictive language subset. Unlike ADsafe, it allows use of the standard DOM API. Also, it includes a verifier written in JavaScript, so that untrusted code can be dynamically verified before being evaluated.

Caja

Caja (http://code.google.com/p/google-caja/) is Google’s open-source secure subset. Caja (Spanish for「box」) defines two language subsets. Cajita (「little box」) is a narrow subset like that used by ADsafe and dojox.secure. Valija (「suitcase」or「baggage」) is a much broader language that is close to regular ECMAScript 5 strict mode (with the removal of eval()). Caja itself is the name of the compiler that transforms (or「cajoles」) web content (HTML, CSS, and JavaScript code) into secure modules that can be safely hosted on a web page without being able to affect the page as a whole or other modules on the page.

Caja is part of the OpenSocial API (http://code.google.com/apis/opensocial/) and has been adopted by Yahoo! for use on its websites. The content available at the portal http://my.yahoo.com, for example, is organized into Caja modules.

FBJS

FBJS is the variant of JavaScript used by Facebook (http://facebook.com) to allow untrusted content on users’ profile pages. FBJS relies on code transformation to ensure security. The transformer inserts runtime checks to prevent access to the global object through the this keyword. And it renames all top-level identifiers by adding a module-specific prefix. Any attempt to set or query global variables or variables belonging to another module is prevented because of this renaming. Furthermore, any calls to eval() are transformed by this identifier prefixing into calls to a nonexistent function. FBJS emulates a safe subset of the DOM API.

Microsoft Web Sandbox

Microsoft’s Web Sandbox (http://websandbox.livelabs.com/) defines a broad subset of JavaScript (plus HTML and CSS) and makes it secure through radical code rewriting, effectively reimplementing a secure JavaScript virtual machine on top of nonsecure JavaScript.

Constants and Scoped Variables

We now leave language subsets behind and transition to language extensions. In JavaScript 1.5 and later, you can use the const keyword to define constants. Constants are like variables except that assignments to them are ignored (attempting to alter a constant does not cause an error) and attempts to redeclare them cause errors:

const pi = 3.14; // Define a constant and give it a value. pi = 4; // Any future assignments to it are silently ignored. const pi = 4; // It is an error to redeclare a constant. var pi = 4; // This is also an error.

The const keyword behaves much like the var keyword: there is no block scope, and constants are hoisted to the top of the enclosing function definition. (See Function Scope and Hoisting)

The lack of block scope for variables in JavaScript has long been considered a shortcoming of the language, and JavaScript 1.7 addresses it by adding the let keyword to the language. The keyword const has always been a reserved (but unused) word in JavaScript, so constants can be added without breaking any existing code. The let keyword was not reserved, so it is not recognized unless you explicitly opt-in to version 1.7 or later.

JavaScript Versions

In this chapter, when we refer to a specific JavaScript version number, we’re referring specifically to Mozilla’s version of the language, as implemented in the Spidermonkey and Rhino interpreters and the Firefox web browser.

Some of the language extensions here define new keywords (such as let) and to avoid breaking existing code that uses that keyword, JavaScript requires you to explicitly request the new version of the language in order to use the extension. If you are using Spidermonkey or Rhino as a stand-alone interpreter, you can specify the desired language version with a command-line option or by calling the built-in version() function. (It expects the version number times ten. Pass 170 to select JavaScript 1.7 and enable the let keyword.) In Firefox, you can opt in to language extensions using a script tag like this:

<script type="application/javascript; version=1.8">

The let keyword can be used in four ways:

as a variable declaration like var;

in a for or for/in loop, as a substitute for var;

as a block statement, to define new variables and explicitly delimit their scope; and

to define variables that are scoped to a single expression.

The simplest way to use let is as a drop-in replacement for var. Variables declared with var are defined throughout the enclosing function. Variables declared with let are defined only within the closest enclosing block (and any blocks nested within it, of course). If you declare a variable with let inside the body of a loop, for example, it does not exist outside the loop:

function oddsums(n) { let total = 0, result=[]; // Defined throughout the function for(let x = 1; x <= n; x++) { // x is only defined in the loop let odd = 2*x-1; // odd only defined in this loop total += odd; result.push(total); } // Using x or odd here would cause a ReferenceError return result; } oddsums(5); // Returns [1,4,9,16,25]

Notice that this code also uses let as a replacement for var in the for loop. This creates a variable whose scope is the body of the loop plus the condition and increment clauses of the loop. You can also use let in this way in for/in (and for each; see The for/each Loop) loops:

o = {x:1,y:2}; for(let p in o) console.log(p); // Prints x and y for each(let v in o) console.log(v); // Prints 1 and 2 console.log(p) // ReferenceError: p is not defined

There is an interesting difference between let used as a declaration statement and let used as a loop initializer. Used as a declaration, the variable initializer expressions are evaluated in the scope of the variable. But in a for loop, the initializer expression is evaluated outside the scope of the new variable. This matters only when the new variable is shadowing a new variable by the same name:

let x = 1; for(let x = x + 1; x < 5; x++) console.log(x); // Prints 2,3,4 { // Begin a block to create a new variable scope let x = x + 1; // x is undefined, so x+1 is NaN console.log(x); // Prints NaN }

Variables declared with var exist throughout the function in which they are declared, but they are not initialized until the var statement actually runs. That is, the variable exists (i.e., no ReferenceError will be thrown) but is undefined if you attempt to use it before the var statement. Variables declared with let are similar: if you attempt to use a variable before its let statement (but within the same block as the let statement), the variable will exist but its value will be undefined.

Notice that this problem doesn’t exist when you use let to declare a loop variable—the syntax simply doesn’t allow you to use the variable before it is initialized. There is another way to use let that avoids this problem of using variables before they are initialized. A let block statement (as opposed to the let declaration statements shown above) combines a block of code with a set of variables for the block and the initialization expressions for those variables. In this form, the variables and their initializers are placed within parentheses and are followed by a block of statements within curly braces:

let x=1, y=2; let (x=x+1,y=x+2) { // Note that we're shadowing variables console.log(x+y); // Prints 5 }; console.log(x+y); // Prints 3

It is important to understand that the variable initializer expressions of a let block are not part of the block and are interpreted in the outer scope. In the code above, we are creating a new variable x and assigning it a value one larger than the value of the existing variable x.

The final use of the let keyword is a variant on the let block, in which a parenthesized list of variables and initializers is followed by a single expression rather than a block of statements. This is called a let expression, and the code above could be rewritten to use one like this:

let x=1, y=2; console.log(let (x=x+1,y=x+2) x+y); // Prints 5

Some form of const and let (not necessarily all four forms described here) are likely to be included in a future version of the ECMAScript standard.

Destructuring Assignment

Spidermonkey 1.7 implements a kind of compound assignment known as destructuring assignment. (You may have seen destructuring assignment before, in Python or Ruby, for example.) In a destructuring assignment, the value on the right-hand side of the equals sign is an array or object (a「structured」value) and the left-hand side specifies one or more variable names using a syntax that mimics array and object literal syntax. When a destructuring assignment occurs, one or more values are extracted (「destructured」) from the value on the right and stored into the variables named on the left. In addition to its use with the regular assignment operator, destructuring assignment can also be used when initializing newly declared variables with var and let.

Destructuring assignment is simple and powerful when working with arrays, and is particularly useful with functions that return arrays of values. It can become confusing and complex when used with objects and nested objects, however. Examples demonstrating both simple and complex uses follow.

Here are simple destructuring assignments using arrays of values:

let [x,y] = [1,2]; // Same as let x=1, y=2 [x,y] = [x+1,y+1]; // Same as x = x + 1, y = y+1 [x,y] = [y,x]; // Swap the value of the two variables console.log([x,y]); // Prints [3,2]

Notice how destructuring assignment makes it easy to work with functions that return arrays of values:

// Convert [x,y] coordinates to [r,theta] polar coordinates function polar(x,y) { return [Math.sqrt(x*x+y*y), Math.atan2(y,x)]; } // Convert polar to Cartesian coordinates function cartesian(r,theta) { return [r*Math.cos(theta), r*Math.sin(theta)]; } let [r,theta] = polar(1.0, 1.0); // r=Math.sqrt(2), theta=Math.PI/4 let [x,y] = cartesian(r,theta); // x=1.0, y=1.0

The number of variables on the left of a destructuring assignment does not have to match the number of array elements on the right. Extra variables on the left are set to undefined, and extra values on the right are ignored. The list of variables on the left can include extra commas to skip certain values on the right:

let [x,y] = [1]; // x = 1, y = undefined [x,y] = [1,2,3]; // x = 1, y = 2 [,x,,y] = [1,2,3,4]; // x = 2, y = 4

There is no syntax to assign all unused or remaining values (as an array) to a variable. In the second line of code above, for example, there is no way to assign [2,3] to y.

The value of a destructuring assignment is the complete data structure on the right-hand side, not the individual values that are extracted from it. Thus, it is possible to「chain」assignments like this:

let first, second, all; all = [first,second] = [1,2,3,4]; // first=1, second=2, all=[1,2,3,4]

Destructuring assignment can even be used with nested arrays. In this case, the left-hand side of the assignment should look like a nested array literal:

let [one, [twoA, twoB]] = [1, [2,2.5], 3]; // one=1, twoA=2, twoB=2.5

Destructuring assignment can also be performed when the right-hand side is an object value. In this case, the left-hand side of the assignment looks something like an object literal: a comma-separated and brace delimited list of property name and variable name pairs. The name to the left of each colon is a property name, and the name to the right of each colon is a variable name. Each named property is looked up in the object on the right-hand side of the assignment, and its value (or undefined) is assigned to the corresponding variable. This type of destructuring assignment can get confusing, especially because it is often tempting to use the same identifier for both property and variable name. In the example below, be sure that you understand that r, g, and b are property names and red, green, and blue are variable names:

let transparent = {r:0.0, g:0.0, b:0.0, a:1.0}; // A RGBA color let {r:red, g:green, b:blue} = transparent; // red=0.0,green=0.0,blue=0.0

The next example copies global functions of the Math object into variables, which might simplify code that does a lot of trigonometry:

// Same as let sin=Math.sin, cos=Math.cos, tan=Math.tan let {sin:sin, cos:cos, tan:tan} = Math;

Just as destructuring assignment can be used with nested arrays, it can be used with nested objects. In fact, the two syntaxes can be combined to describe arbitrary data structures. For example:

// A nested data structure: an object that contains an array of objects let data = { name: "destructuring assignment", type: "extension", impl: [{engine: "spidermonkey", version: 1.7}, {engine: "rhino", version: 1.7}] }; // Use destructuring assignment to extract four values from the data structure let ({name:feature, impl: [{engine:impl1, version:v1},{engine:impl2}]} = data) { console.log(feature); // Prints "destructuring assignment" console.log(impl1); // Prints "spidermonkey" console.log(v1); // Prints 1.7 console.log(impl2); // Prints "rhino" }

Note that nested destructuring assignments like this may make your code harder to read rather than simplifying it. There is an interesting regularity that can help you to make sense of the complex cases, however. Think first about a regular (single-value) assignment. After the assignment is done, you can take the variable name from the left-hand side of the assignment and use it as an expression in your code, where it will evaluate to whatever value you assigned it. In destructuring assignment, we’ve said that the left-hand side uses a syntax like array literal syntax or like object literal syntax. But notice that after the destructuring assignment is done, the code that looks like an array literal or object literal from the left-hand side will actually work as a valid array literal or object literal elsewhere in your code: all the necessary variables have been defined so that you can cut-and-paste the text on the left of the equals sign and use it as an array or object value in your code.

Iteration

Mozilla’s JavaScript extensions introduce new iteration techniques, including the for each loop and Python-style iterators and generators. They are detailed in the subsections below.

The for/each Loop

The for/each loop is a new looping statement standardized by E4X. E4X (ECMAScript for XML) is a language extension that allows XML tags to appear literally in JavaScript programs and adds syntax and API for operating on XML data. E4X has not been widely implemented in web browsers, but it is supported by Mozilla’s JavaScript 1.6 (released in Firefox 1.5). In this section, we’ll cover only the for/each loop and its use with non-XML objects. See E4X: ECMAScript for XML for details on the rest of E4X.

The for each loop is much like the for/in loop. Instead of iterating through the properties of an object, however, it iterates through the values of those properties:

let o = {one: 1, two: 2, three: 3} for(let p in o) console.log(p); // for/in: prints 'one', 'two', 'three' for each (let v in o) console.log(v); // for/each: prints 1, 2, 3

When used with an array, the for/each loop iterates through the elements (rather than the indexes) of the loop. It typically enumerates them in numerical order, but this is not actually standardized or required:

a = ['one', 'two', 'three']; for(let p in a) console.log(p); // Prints array indexes 0, 1, 2 for each (let v in a) console.log(v); // Prints array elts 'one', 'two', 'three'

Note that the for/each loop does not limit itself to the array elements of an array—it will enumerate the value of any enumerable property of the array including enumerable methods inherited by the array. For this reason, the for/each loop is usually not recommended for use with arrays. This is particularly true for code that must interoperate with versions of JavaScript before ECMAScript 5 in which it is not possible to make user-defined properties and methods non-enumerable. (See Iterating Arrays for a similar discussion of the for/in loop.)

Iterators

JavaScript 1.7 enhances the for/in loop with more general behavior. JavaScript 1.7’s for/in loop is more like Python’s for/in and allows it iterate over any iterable object. In order to understand this, some definitions are required.

An iterator is an object that allows iteration over some collection of values and maintains whatever state is necessary to keep track of the current「position」in the collection. An iterator must have a next() method. Each call to next() returns the next value from the collection. The counter() function below, for example, returns an iterator that returns successively larger integers on each call to next(). Note the use of the function scope as a closure that holds the current state of the counter:

// A function that returns an iterator; function counter(start) { let nextValue = Math.round(start); // Private state of the iterator return { next: function() { return nextValue++; }}; // Return iterator obj } let serialNumberGenerator = counter(1000); let sn1 = serialNumberGenerator.next(); // 1000 let sn2 = serialNumberGenerator.next(); // 1001

Iterators that work on finite collections throw StopIteration from their next() method when there are no more values to iterate. StopIteration is a property of the global object in JavaScript 1.7. Its value is an ordinary object (with no properties of its own) that is reserved for this special purpose of terminating iterations. Note, in particular, that StopIteration is not a constructor function like TypeError() or RangeError(). Here, for example, is a rangeIter() method that returns an iterator that iterates the integers in a given range:

// A function that returns an iterator for a range of integers function rangeIter(first, last) { let nextValue = Math.ceil(first); return { next: function() { if (nextValue > last) throw StopIteration; return nextValue++; } }; } // An awkward iteration using the range iterator. let r = rangeIter(1,5); // Get an iterator object while(true) { // Now use it in a loop try { console.log(r.next()); // Try to call its next() method } catch(e) { if (e == StopIteration) break; // Exit the loop on StopIteration else throw e; } }

Note how awkward it is to use an iterator object in a loop where the StopIteration method must be handled explicitly. Because of this awkwardness, we don’t often use iterator objects directly. Instead we use iterable objects. An iterable object represents a collection of values that can be iterated. An iterable object must define a method named __iterator__() (with two underscores at the start and end of the name) which returns an iterator object for the collection.

The JavaScript 1.7 for/in loop has been extended to work with iterable objects. If the value to the right of the in keyword is iterable, then the for/in loop will automatically invoke its __iterator__() method to obtain an iterator object. It then calls the next() method of the iterator, assigns the resulting value to the loop variable, and executes the loop body. The for/in loop handles the StopIteration exception itself, and it is never visible to your code. The code below defines a range() function that returns an iterable object (not an iterator) that represents a range of integers. Notice how much easier it is to use a for/in loop with an iterable range than it is to use a while loop with a range iterator.

// Return an iterable object that represents an inclusive range of numbers function range(min,max) { return { // Return an object representing a range. get min() { return min; }, // The range's bounds are immutable. get max() { return max; }, // and stored in the closure. includes: function(x) { // Ranges can test for membership. return min <= x && x <= max; }, toString: function() { // Ranges have a string representation. return "[" + min + "," + max + "]"; }, __iterator__: function() { // The integers in a range are iterable. let val = Math.ceil(min); // Store current position in closure. return { // Return an iterator object. 	 next: function() { // Return next integer in the range. 	 if (val > max) // If we're past the end then stop. 	 throw StopIteration; 	 return val++; // Otherwise return next and increment. 	 } }; } }; } // Here's how we can iterate over a range: for(let i in range(1,10)) console.log(i); // Prints numbers from 1 to 10

Note that that although you must write an __iterator__() method and throw a StopIteration exception to create iterable objects and their iterators, you are not expected (in normal use) to call the __iterator__() method nor to handle the StopIteration exception—the for/in loop does this for you. If for some reason you want to explicitly obtain an iterator object from an iterable object, call the Iterator() function. (Iterator() is a global function that is new in JavaScript 1.7.) If the argument to this function is an iterable object, it simply returns the result of a call to the __iterator__() method, keeping your code cleaner. (If you pass a second argument to Iterator(), it will pass that argument on to the __iterator__() method.)

There is another important purpose for the Iterator() function, however. When you call it on an object (or array) that does not have an __iterator__() method, it returns a custom iterable iterator for the object. Each call to this iterator’s next() method returns an array of two values. The first array element is a property name, and the second is the value of the named property. Because this object is an iterable iterator, you can use it with a for/in loop instead of calling its next() method directly, and this means that you can use the Iterator() function along with destructuring assignment to conveniently loop through the properties and values of an object or array:

for(let [k,v] in Iterator({a:1,b:2})) // Iterate keys and values console.log(k + "=" + v); // Prints "a=1" and "b=2"

There are two other important features of the iterator returned by the Iterator() function. First, it ignores inherited properties and only iterates「own」properties, which is usually what you want. Second, if you pass true as the second argument to Iterator(), the returned iterator will iterate only property names, not property values. The following code demonstrates these two features:

o = {x:1, y:2} // An object with two properties Object.prototype.z = 3; // Now all objects inherit z for(p in o) console.log(p); // Prints "x", "y", and "z" for(p in Iterator(o, true)) console.log(p); // Prints only "x" and "y"

Generators

Generators are a JavaScript 1.7 feature (borrowed from Python) that use a new yield keyword, which means that code that uses them must explicitly opt in to version 1.7, as described in Constants and Scoped Variables. The yield keyword is used in a function and functions something like return to return a value from the function. The difference between yield and return, however, is that a function that yields a value to its caller retains its internal state so that it is resumable. This resumability makes yield a perfect tool for writing iterators. Generators are a very powerful language feature, but they can be tricky to understand at first. We’ll begin with some definitions.

Any function that uses the yield keyword (even if the yield is unreachable) is a generator function. Generator functions return values with yield. They may use the return statement with no value to terminate before reaching the end of the function body, but they may not use return with a value. Except for their use of yield, and this restriction on the use of return, generator functions are pretty much indistinguishable from regular functions: they are declared with the function keyword, the typeof operator returns「function」, and they inherit from Function.prototype just as ordinary functions do. When invoked, however, a generator function behaves completely differently than a regular function: instead of executing the body of the generator function, the invocation instead returns a generator object.

A generator is an object that represents the current execution state of a generator function. It defines a next() method that resumes execution of the generator function and allows it to continue running until its next yield statement is encountered. When that happens, the value of the yield statement in the generator function becomes the return value of the next() method of the generator. If a generator function returns (by executing a return statement or reaching the end of its body), the next() method of the generator throws StopIteration.

The fact that generators have a next() method that can throw StopIteration should make it clear that they are iterator objects.[19] In fact, they are iterable iterators, which means that they can be used with for/in loops. The following code demonstrates just how easy it is to write generator functions and iterate over the values they yield:

// Define a generator function for iterating over a range of integers function range(min, max) { for(let i = Math.ceil(min); i <= max; i++) yield i; } // Invoke the generator function to obtain a generator, then iterate it. for(let n in range(3,8)) console.log(n); // Prints numbers 3 through 8.

Generator functions need never return. In fact, a canonical example is the use of a generator to yield the Fibonacci numbers:

// A generator function that yields the Fibonacci sequence function fibonacci() { let x = 0, y = 1; while(true) { yield y; [x,y] = [y,x+y]; } } // Invoke the generator function to obtain a generator. f = fibonacci(); // Use the generator as an iterator, printing the first 10 Fibonacci numbers. for(let i = 0; i < 10; i++) console.log(f.next());

Notice that the fibonacci() generator function never returns. For this reason, the generator it returns will never throw StopIteration. Rather than using it as an iterable object in a for/in loop and looping forever, we use it as an iterator and explicitly call its next() method ten times. After the code above runs, the generator f still retains the execution state of the generator function. If we won’t be using it anymore, we can release that state by calling the close() method of f:

f.close();

When you call the close method of a generator, the associated generator function terminates as if there was a return statement at the location where its execution was suspended. If this location is inside one or more try blocks, any finally clauses are run before close() returns. close() never has a return value, but if a finally block raises an exception it will propagate from the call to close().

Generators are often useful for sequential processing of data—elements of a list, lines of text, tokens from a lexer, and so on. Generators can be chained in a way that is analogous to a Unix-style pipeline of shell commands. What is interesting about this approach is that it is lazy: values are「pulled」from a generator (or pipeline of generators) as needed, rather than being processed in multiple passes. Example 11-1 demonstrates.

Example 11-1. A pipeline of generators

// A generator to yield the lines of the string s one at a time. // Note that we don't use s.split(), because that would process the entire // string at once, allocating an array, and we want to be lazy instead. function eachline(s) { let p; while((p = s.indexOf('\n')) != -1) { yield s.substring(0,p); s = s.substring(p+1); } if (s.length > 0) yield s; } // A generator function that yields f(x) for each element x of the iterable i function map(i, f) { for(let x in i) yield f(x); } // A generator function that yields the elements of i for which f(x) is true function select(i, f) { for(let x in i) { if (f(x)) yield x; } } // Start with a string of text to process let text = " #comment \n \n hello \nworld\n quit \n unreached \n"; // Now build up a pipeline of generators to process it. // First, break the text into lines let lines = eachline(text); // Next, trim whitespace from the start and end of each line let trimmed = map(lines, function(line) { return line.trim(); }); // Finally, ignore blank lines and comments let nonblank = select(trimmed, function(line) { return line.length > 0 && line[0] != "#" }); // Now pull trimmed and filtered lines from the pipeline and process them, // stopping when we see the line "quit". for (let line in nonblank) { if (line === "quit") break; console.log(line); }

Typically generators are initialized when they are created: the values passed to the generator function are the only input that the generator receives. It is possible, however, to provide additional input to a running generator. Every generator has a send() method, which works to restart the generator like the next() method does. The difference is that you can pass a value to send(), and that value becomes the value of the yield expression. (In most generator functions that do not accept additional input, the yield keyword looks like a statement. In fact, however, yield is an expression and has a value.) In addition to next() and send(), another way to restart a generator is with throw(). If you call this method, the yield expression raises the argument to throw() as an exception. The following code demonstrates:

// A generator function that counts from an initial value. // Use send() on the generator to specify an increment. // Use throw("reset") on the generator to reset to the initial value. // This is for example only; this use of throw() is bad style. function counter(initial) { let nextValue = initial; // Start with the initial value while(true) { try { let increment = yield nextValue; // Yield a value and get increment if (increment) // If we were sent an increment... nextValue += increment; // ...then use it. else nextValue++; // Otherwise increment by 1 } catch (e) { // We get here if someone calls if (e==="reset") // throw() on the generator nextValue = initial; else throw e; } } } let c = counter(10); // Create the generator at 10 console.log(c.next()); // Prints 10 console.log(c.send(2)); // Prints 12 console.log(c.throw("reset")); // Prints 10

Array Comprehensions

An array comprehension is another feature that JavaScript 1.7 borrowed from Python. It is a technique for initializing the elements of an array from or based on the elements of another array or iterable object. The syntax of array comprehensions is based on the mathematical notation for defining the elements of a set, which means that expressions and clauses are in different places than JavaScript programmers would expect them to be. Be assured, however, that it doesn’t take long to get used to the unusual syntax and appreciate the power of array comprehensions.

Here’s an array comprehension that uses the range() function developed above to initialize an array to contain the even square numbers up to 100:

let evensquares = [x*x for (x in range(0,10)) if (x % 2 === 0)]

It is roughly equivalent to the following five lines:

let evensquares = []; for(x in range(0,10)) { if (x % 2 === 0) evensquares.push(x*x); }

In general, an array comprehension looks like this:

[ expression for ( variable in object ) if ( condition ) ]

Notice that there are three main parts within the square brackets:

A for/in or for/each loop with no body. This piece of the comprehension includes a variable (or, with destructuring assignment, multiple variables) that appears to the left of the in keyword, and an object (which may be a generator, an iterable object, or an array, for example) to the right of the in. Although there is no loop body following the object, this piece of the array comprehension does perform an iteration and assign successive values to the specified variable. Note that neither the var nor the let keyword is allowed before the variable name—a let is implicit and the variable used in the array comprehension is not visible outside of the square brackets and does not overwrite existing variables by the same name.

An if keyword and a conditional expression in parentheses may appear after the object being iterated. If present, this conditional is used to filter iterated values. The conditional is evaluated after each value is produced by the for loop. If it is false, that value is skipped and nothing is added to the array for that value. The if clause is optional; if omitted, the array comprehension behaves as if if (true) were present.

An expression that appears before the for keyword. This expression can be thought of as the body of the loop. After a value is returned by the iterator and assigned to the variable, and if that value passes the conditional test, this expression is evaluated and the resulting value is inserted into the array that is being created.

Here are some more concrete examples to clarify the syntax:

data = [2,3,4, -5]; // An array of numbers squares = [x*x for each (x in data)]; // Square each one: [4,9,16,25] // Now take the square root of each non-negative element roots = [Math.sqrt(x) for each (x in data) if (x >= 0)] // Now we'll create arrays of property names of an object o = {a:1, b:2, f: function(){}} let allkeys = [p for (p in o)] let ownkeys = [p for (p in o) if (o.hasOwnProperty(p))] let notfuncs = [k for ([k,v] in Iterator(o)) if (typeof v !== "function")]

Generator Expressions

In JavaScript 1.8,[20] you can replace the square brackets around an array comprehension with parentheses to produce a generator expression. A generator expression is like an array comprehension (the syntax within the parentheses is exactly the same as the syntax within the square brackets), but its value is a generator object rather than an array. The benefits of using a generator expression instead of an array comprehension are that you get lazy evaluation—computations are performed as needed rather than all at once—and that you can work with potentially infinite sequences. The disadvantage of using a generator instead of an array is that generators allow only sequential access to their values rather than random access. Generators, that is, are not indexable the way arrays are: to obtain the nth value, you must iterate through all n-1 values that come before it.

Earlier in this chapter we wrote a map() function like this:

function map(i, f) { // A generator that yields f(x) for each element of i for(let x in i) yield f(x); }

Generator expressions make it unnecessary to write or use such a map() function. To obtain a new generator h that yields f(x) for each x yielded by a generator g, just write this:

let h = (f(x) for (x in g));

In fact, given the eachline() generator from Example 11-1, we can trim whitespace and filter out comments and blank lines like this:

let lines = eachline(text); let trimmed = (l.trim() for (l in lines)); let nonblank = (l for (l in trimmed) if (l.length > 0 && l[0]!='#'));

* * *

[19] Generators are sometimes called「generator iterators」to clearly distinguish them from the generator functions by which they are created. In this chapter, we’ll use the term「generator」to mean「generator iterator.」In other sources, you may find the word「generator」used to refer to both generator functions and generator iterators.

[20] Generator expressions are not supported in Rhino at the time of this writing.

Shorthand Functions

JavaScript 1.8 [21] introduces a shorthand (called「expression closures」) for writing simple functions. If a function evaluates a single expression and returns its value, you can omit the return keyword and also the curly braces around the function body, and simply place the expression to be evaluated immediately after the argument list. Here are some examples:

let succ = function(x) x+1, yes = function() true, no = function() false;

This is simply a convenience: functions defined in this way behave exactly like functions defined with curly braces and the return keyword. This shorthand syntax is particularly convenient when passing functions to other functions, however. For example:

// Sort an array in reverse numerical order data.sort(function(a,b) b-a); // Define a function that returns the sum of the squares of an array of data let sumOfSquares = function(data) Array.reduce(Array.map(data, function(x) x*x), function(x,y) x+y);

* * *

[21] Rhino does not implement this feature at the time of this writing.

Multiple Catch Clauses

In JavaScript 1.5, the try/catch statement has been extended to allow multiple catch clauses. To use this feature, follow the name of the catch clause parameter with the if keyword and a conditional expression:

try { // multiple exception types can be thrown here throw 1; } catch(e if e instanceof ReferenceError) { // Handle reference errors here } catch(e if e === "quit") { // Handle the thrown string "quit" } catch(e if typeof e === "string") { // Handle any other thrown strings here } catch(e) { // Handle anything else here } finally { // The finally clause works as normal }

When an exception occurs, each catch clause is tried in turn. The exception is assigned to the named catch clause parameter, and the conditional is evaluated. If true, the body of that catch clause is evaluated, and all other catch clauses are skipped. If a catch clause has no conditional, it behaves as if it has the conditional if true, and it is always triggered if no clause before it was triggered. If all catch clauses have a conditional, and none of those conditionals are true, the exception propagates uncaught. Notice that since the conditionals already appear within the parentheses of the catch clause, they are not required to be directly enclosed in parentheses as they would be in a regular if statement.

E4X: ECMAScript for XML

ECMAScript for XML, better known as E4X, is a standard extension[22] to JavaScript that defines a number of powerful features for processing XML documents. E4X is supported by Spidermonkey 1.5 and Rhino 1.6. Because it is not widely supported by browser vendors, E4X may perhaps be best considered a server-side technology for script engines based on Spidermonkey or Rhino.

E4X represents an XML document (or an element or attribute of an XML document) as an XML object and represents XML fragments (more than one XML element not included in a common parent) with the closely related XMLList object. We’ll see a number of ways to create and work with XML objects throughout this section. XML objects are a fundamentally new kind of object, with (as we’ll see) much special-purpose E4X syntax supporting them. As you know, the typeof operator returns「object」for all standard JavaScript objects other than functions. XML objects are as different from ordinary JavaScript objects as functions are, and the typeof operator returns「xml」. It is important to understand that XML objects are unrelated to the DOM (Document Object Model) objects used in client-side JavaScript (see Chapter 15). The E4X standard defines optional features for converting between the E4X and DOM representations of XML documents and elements, but Firefox does not implement these. This is another reason that E4X may be best considered a server-side technology.

This section presents a quick tutorial on E4X but does not attempt to document it comprehensively. In particular, the XML and XMLList objects have a number of methods that are not mentioned here. Neither are they covered in the reference section. Readers who want to use E4X will need to refer to the specification for definitive documentation.

E4X defines quite a bit of new language syntax. The most striking bit of new syntax is that XML markup becomes part of the JavaScript language, and you can include XML literals like these directly in your JavaScript code:

// Create an XML object var pt = <periodictable> <element id="1"><name>Hydrogen</name></element> <element id="2"><name>Helium</name></element> <element id="3"><name>Lithium</name></element> </periodictable>; // Add a new element to the table pt.element += <element id="4"><name>Beryllium</name></element>;

The XML literal syntax of E4X uses curly braces as escape characters that allow you to place JavaScript expressions within XML. This, for example, is another way to create the XML element just shown:

pt = <periodictable></periodictable>; // Start with empty table var elements = ["Hydrogen", "Helium", "Lithium"]; // Elements to add // Create XML tags using array contents for(var n = 0; n < elements.length; n++) { pt.element += <element id={n+1}><name>{elements[n]}</name></element>; }

In addition to this literal syntax, you can also work with XML parsed from strings. The following code adds another element to your periodic table:

pt.element += new XML('<element id="5"><name>Boron</name></element>');

When working with XML fragments, use XMLList() instead of XML():

pt.element += new XMLList('<element id="6"><name>Carbon</name></element>' + '<element id="7"><name>Nitrogen</name></element>');

Once you have an XML document defined, E4X defines an intuitive syntax for accessing its content:

var elements = pt.element; // Evaluates to a list of all <element> tags var names = pt.element.name; // A list of all <name> tags var n = names[0]; // "Hydrogen": content of <name> tag 0.

E4X also adds new syntax for working with XML objects. The .. operator is the descendant operator; you can use it in place of the normal . member-access operator:

// Here is another way to get a list of all <name> tags var names2 = pt..name;

E4X even has a wildcard operator:

// Get all descendants of all <element> tags. // This is yet another way to get a list of all <name> tags. var names3 = pt.element.*;

Attribute names are distinguished from tag names in E4X using the @ character (a syntax borrowed from XPath). For example, you can query the value of an attribute like this:

// What is the atomic number of Helium? var atomicNumber = pt.element[1].@id;

The wildcard operator for attribute names is @*:

// A list of all attributes of all <element> tags var atomicNums = pt.element.@*;

E4X even includes a powerful and remarkably concise syntax for filtering a list using an arbitrary predicate expression:

// Start with a list of all elements and filter it so // it includes only those whose id attribute is < 3 var lightElements = pt.element.(@id < 3); // Start with a list of all <element> tags and filter so it includes only // those whose names begin with "B". Then make a list of the <name> tags // of each of those remaining <element> tags. var bElementNames = pt.element.(name.charAt(0) == 'B').name;

The for/each loop we saw earlier in this chapter (see The for/each Loop) is generally useful, but it was defined by the E4X standard for iterating through lists of XML tags and attributes. Recall that for/each is like the for/in loop, except that instead of iterating through the properties of an object, it iterates through the values of the properties of an object:

// Print the names of each element in the periodic table for each (var e in pt.element) { console.log(e.name); } // Print the atomic numbers of the elements for each (var n in pt.element.@*) console.log(n);

E4X expressions can appear on the left side of an assignment. This allows existing tags and attributes to be changed and new tags and attributes to be added:

// Modify the <element> tag for Hydrogen to add a new attribute // and a new child element so that it looks like this: // // <element id="1" symbol="H"> // <name>Hydrogen</name> // <weight>1.00794</weight> // </element> // pt.element[0].@symbol = "H"; pt.element[0].weight = 1.00794;

Removing attributes and tags is also easy with the standard delete operator:

delete pt.element[0].@symbol; // delete an attribute delete pt..weight; // delete all <weight> tags

E4X is designed so that you can perform most common XML manipulations using language syntax. E4X also defines methods you can invoke on XML objects. Here, for example, is the insertChildBefore() method:

pt.insertChildBefore(pt.element[1], <element id="1"><name>Deuterium</name></element>);

E4X is fully namespace-aware and includes language syntax and APIs for working with XML namespaces:

// Declare the default namespace using a "default xml namespace" statement: default xml namespace = "http://www.w3.org/1999/xhtml"; // Here's an xhtml document that contains some svg tags, too: d = <html> <body> 	This is a small red square: 	<svg xmlns="http://www.w3.org/2000/svg" width="10" height="10"> 	 <rect x="0" y="0" width="10" height="10" fill="red"/> 	</svg> </body> </html> // The body element and its namespace uri and its local name var tagname = d.body.name(); var bodyns = tagname.uri; var localname = tagname.localName; // Selecting the <svg> element is trickier because it is not in the // default namespace. So create a Namespace object for svg, and use the // :: operator to add a namespace to a tagname var svg = new Namespace('http://www.w3.org/2000/svg'); var color = d..svg::rect.@fill // "red"

* * *

[22] E4X is defined by the ECMA-357 standard. You can find the official specification at http://www.ecma-international.org/publications/standards/Ecma-357.htm.

Chapter 12. Server-Side JavaScript

The previous chapters have covered the core JavaScript language in detail, and we’re about to start Part II of the book, which explains how JavaScript is embedded in web browsers and covers the sprawling client-side JavaScript API. JavaScript is the programming language of the Web, and most JavaScript code is written for web browsers. But JavaScript is a fast and capable general-purpose language, and there is no reason that JavaScript cannot be used for other programming tasks. So before we transition to client-side JavaScript, we’ll take a quick look at two other JavaScript embeddings. Rhino is a Java-based JavaScript interpreter that gives JavaScript programs access to the entire Java API. Rhino is covered in Scripting Java with Rhino. Node is a version of Google’s V8 JavaScript interpreter with low-level bindings for the POSIX (Unix) API—files, processes, streams, sockets, and so on—and a particular emphasis on asynchronous I/O, networking, and HTTP. Node is covered in Asynchronous I/O with Node.

The title of this chapter says that it is about「server-side」JavaScript, and Node and Rhino are both commonly used to create or to script servers. But the phrase「server-side」can also be taken to mean「anything outside of the web browser.」Rhino programs can create graphical UIs with Java’s Swing framework. And Node can run JavaScript programs that manipulate files the way shell scripts do.

This is a short chapter, intended only to highlight some of the ways that JavaScript can be used outside of web browsers. It does not attempt to cover Rhino or Node comprehensively, and the APIs discussed here are not covered in the reference section. Obviously, this chapter cannot document the Java platform or the POSIX API, so the section on Rhino assumes some familiarity with Java and the section on Node assumes some familiarity with low-level Unix APIs.

Scripting Java with Rhino

Rhino is a JavaScript interpreter written in Java and designed to make it easy to write JavaScript programs that leverage the power of the Java platform APIs. Rhino automatically handles the conversion of JavaScript primitives to Java primitives, and vice versa, so JavaScript scripts can set and query Java properties and invoke Java methods.

Obtaining Rhino

Rhino is free software from Mozilla. You can download a copy from http://www.mozilla.org/rhino/. Rhino version 1.7r2 implements ECMAScript 3 plus a number of the language extensions described in Chapter 11. Rhino is mature software and new versions are not released often. At the time of this writing, a prerelease version of 1.7r3 is available from the source repository and includes a partial implementation of ECMAScript 5.

Rhino is distributed as a JAR archive. Start it with a command line like this:

java -jar rhino1_7R2/js.jar program.js

If you omit program.js, Rhino starts an interactive shell, which is useful for trying out simple programs and one-liners.

Rhino defines a handful of important global functions that are not part of core JavaScript:

// Embedding-specific globals: Type help() at the rhino prompt for more print(x); // Global print function prints to the console version(170); // Tell Rhino we want JS 1.7 language features load(filename,...); // Load and execute one or more files of JavaScript code readFile(file); // Read a text file and return its contents as a string readUrl(url); // Read the textual contents of a URL and return as a string spawn(f); // Run f() or load and execute file f in a new thread runCommand(cmd, // Run a system command with zero or more command-line args [args...]); quit() // Make Rhino exit

Notice the print() function: we’ll use it in this section instead of console.log(). Rhino represents Java packages and classes as JavaScript objects:

// The global Packages is the root of the Java package hierarchy Packages.any.package.name // Any package from the Java CLASSPATH java.lang // The global java is a shortcut for Packages.java javax.swing // And javax is a shortcut for Packages.javax // Classes: accessed as properties of packages var System = java.lang.System; var JFrame = javax.swing.JFrame;

Because packages and classes are represented as JavaScript objects, you can assign them to variables to give them shorter names. But you can also more formally import them, if you want to:

var ArrayList = java.util.ArrayList; // Create a shorter name for a class importClass(java.util.HashMap); // Same as: var HashMap = java.util.HashMap // Import a package (lazily) with importPackage(). // Don't import java.lang: too many name conflicts with JavaScript globals. importPackage(java.util); importPackage(java.net); // Another technique: pass any number of classes and packages to JavaImporter() // and use the object it returns in a with statement var guipkgs = JavaImporter(java.awt, java.awt.event, Packages.javax.swing); with (guipkgs) { /* Classes like Font, ActionListener and JFrame defined here */ }

Java classes can be instantiated using new, just like JavaScript classes can:

// Objects: instantiate Java classes with new var f = new java.io.File("/tmp/test"); // We'll use these objects below var out = new java.io.FileWriter(f);

Rhino allows the JavaScript instanceof operator to work with Java objects and classes:

f instanceof java.io.File // => true out instanceof java.io.Reader // => false: it is a Writer, not a Reader out instanceof java.io.Closeable // => true: Writer implements Closeable

As you can see, in the object instantiation examples above, Rhino allows values to be passed to Java constructors and the return value of those constructors to be assigned to JavaScript variables. (Note the implicit type conversion that Rhino performs in this example: the JavaScript string「/type/test」is automatically converted into a Java java.lang.String value.) Java methods are much like Java constructors, and Rhino allows JavaScript programs to invoke Java methods:

// Static Java methods work like JavaScript functions java.lang.System.getProperty("java.version") // Return Java version var isDigit = java.lang.Character.isDigit; // Assign static method to variable isDigit("٢") // => true: Arabic digit 2 // Invoke instance methods of the Java objects f and out created above out.write("Hello World\n"); out.close(); var len = f.length();

Rhino also allows JavaScript code to query and set the static fields of Java classes and the instance fields of Java objects. Java classes often avoid defining public fields in favor of getter and setter methods. When getter and setter methods exist, Rhino exposes them as JavaScript properties:

// Read a static field of a Java class var stdout = java.lang.System.out; // Rhino maps getter and setter methods to single JavaScript properties f.name // => "/tmp/test": calls f.getName() f.directory // => false: calls f.isDirectory()

Java allows overloaded methods that have the same name but different signatures. Rhino can usually figure out which version of a method you mean to invoke based on the type of the arguments you pass. Occasionally, you need to specifically identify a method by name and signature:

// Suppose the Java object o has a method named f that expects an int or // a float. In JavaScript, you must specify the signature explicitly: o['f(int)'](3); // Call the int method o['f(float)'](Math.PI); // Call the float method

You can use a for/in loop to iterate through the methods, fields, and properties of Java classes and objects:

importClass(java.lang.System); for(var m in System) print(m); // Print static members of the java.lang.System for(m in f) print(m); // Print instance members of java.io.File // Note that you cannot enumerate the classes in a package this way for (c in java.lang) print(c); // This does not work

Rhino allows JavaScript programs to get and set the elements of Java arrays as if they were JavaScript arrays. Java arrays are not the same as JavaScript arrays, of course: they are fixed length, their elements are typed, and they don’t have JavaScript methods like slice(). There is no natural JavaScript syntax that Rhino can extend to allow JavaScript programs to create new Java arrays, so you have to do that using the java.lang.reflect.Array class:

// Create an array of 10 strings and an array of 128 bytes var words = java.lang.reflect.Array.newInstance(java.lang.String, 10); var bytes = java.lang.reflect.Array.newInstance(java.lang.Byte.TYPE, 128); // Once arrays are created, you can use them much like JavaScript arrays: for(var i = 0; i < bytes.length; i++) bytes[i] = i;

Java programming often involves implementing interfaces. This is particularly common in GUI programing, where each event handler must implement an event listener interface, and the following examples demonstrate how to implement Java event listeners:

// Interfaces: Implement interfaces like this: var handler = new java.awt.event.FocusListener({ focusGained: function(e) { print("got focus"); }, focusLost: function(e) { print("lost focus"); } }); // Extend abstract classes in the same way var handler = new java.awt.event.WindowAdapter({ windowClosing: function(e) { java.lang.System.exit(0); } }); // When an interface has just one method, you can just use a function instead button.addActionListener(function(e) { print("button clicked"); }); // If all methods of an interface or abstract class have the same signature, // then you can use a single function as the implementation, and Rhino will // pass the method name as the last argument frame.addWindowListener(function(e, name) { if (name === "windowClosing") java.lang.System.exit(0); }); // If you need one object that implements multiple interfaces, use JavaAdapter: var o = new JavaAdapter(java.awt.event.ActionListener, java.lang.Runnable, { run: function() {}, // Implements Runnable actionPerformed: function(e) {} // Implements ActionListener });

When a Java method throws an exception, Rhino propagates it as a JavaScript exception. You can obtain the original Java java.lang.Exception object through the javaException property of the JavaScript Error object:

try { java.lang.System.getProperty(null); // null is not a legal argument } catch(e) { // e is the JavaScript exception print(e.javaException); // it wraps a java.lang.NullPointerException }

One final note about Rhino type conversion is necessary here. Rhino automatically converts primitive numbers and booleans and the null value as needed. Java’s char type is treated as a JavaScript number, since JavaScript doesn’t have a character type. JavaScript strings are automatically converted to Java strings but (and this can be a stumbling block) Java strings left as java.lang.String objects are not converted back to JavaScript strings. Consider this line of code from earlier:

var version = java.lang.System.getProperty("java.version");

After calling this code, the variable version holds a java.lang.String object. This usually behaves like a JavaScript string, but there are important differences. First, a Java string has a length() method rather than a length property. Second, the typeof operator returns「object」for a Java string. You can’t convert a Java string to a JavaScript string by calling its toString() method, because all Java objects have their own Java toString() method that returns a java.lang.String. To convert a Java value to a string, pass it to the JavaScript String() function:

var version = String(java.lang.System.getProperty("java.version"));

Rhino Example

Example 12-1 is a simple Rhino application that demonstrates many of the features and techniques described above. The example uses the javax.swing GUI package, the java.net networking package, the java.io streaming I/O package, and Java’s multithreading capabilities to implement a simple download manager application that downloads URLs to local files and displays download progress while it does so. Figure 12-1 shows what the application looks like when two downloads are pending.

Figure 12-1. A GUI created with Rhino

Example 12-1. A download manager application with Rhino

/* * A download manager application with a simple Java GUI */ // Import the Swing GUI components and a few other classes importPackage(javax.swing); importClass(javax.swing.border.EmptyBorder); importClass(java.awt.event.ActionListener); importClass(java.net.URL); importClass(java.io.FileOutputStream); importClass(java.lang.Thread); // Create some GUI widgets var frame = new JFrame("Rhino URL Fetcher"); // The application window var urlfield = new JTextField(30); // URL entry field var button = new JButton("Download"); // Button to start download var filechooser = new JFileChooser(); // A file selection dialog var row = Box.createHorizontalBox(); // A box for field and button var col = Box.createVerticalBox(); // For the row & progress bars var padding = new EmptyBorder(3,3,3,3); // Padding for rows // Put them all together and display the GUI row.add(urlfield); // Input field goes in the row row.add(button); // Button goes in the row col.add(row); // Row goes in the column frame.add(col); // Column goes in the frame row.setBorder(padding); // Add some padding to the row frame.pack(); // Set to minimum size frame.visible = true; // Make the window visible // When anything happens to the window, call this function. frame.addWindowListener(function(e, name) { // If the user closes the window, exit the application. if (name === "windowClosing") // Rhino adds the name argument java.lang.System.exit(0); }); // When the user clicks the button, call this function button.addActionListener(function() { try { // Create a java.net.URL to represent the source URL. // (This will check that the user's input is well-formed) var url = new URL(urlfield.text); // Ask the user to select a file to save the URL contents to. var response = filechooser.showSaveDialog(frame); // Quit now if they clicked Cancel if (response != JFileChooser.APPROVE_OPTION) return; // Otherwise, get the java.io.File that represents the destination file var file = filechooser.getSelectedFile(); // Now start a new thread to download the url new java.lang.Thread(function() { download(url,file); }).start(); } catch(e) { // Display a dialog box if anything goes wrong JOptionPane.showMessageDialog(frame, e.message, "Exception", JOptionPane.ERROR_MESSAGE); } }); // Use java.net.URL, etc. to download the content of the URL and use // java.io.File, etc. to save that content to a file. Display download // progress in a JProgressBar component. This will be invoked in a new thread. function download(url, file) { try { // Each time we download a URL we add a new row to the window // to display the url, the filename, and the download progress var row = Box.createHorizontalBox(); // Create the row row.setBorder(padding); // Give it some padding var label = url.toString() + ": "; // Display the URL row.add(new JLabel(label)); // in a JLabel var bar = new JProgressBar(0, 100); // Add a progress bar bar.stringPainted = true; // Display filename in bar.string = file.toString(); // the progress bar row.add(bar); // Add bar to this new row col.add(row); // Add row to the column frame.pack(); // Resize window // We don't yet know the URL size, so bar starts just animating bar.indeterminate = true; // Now connect to the server and get the URL length if we can var conn = url.openConnection(); // Get java.net.URLConnection conn.connect(); // Connect and wait for headers var len = conn.contentLength; // See if we have URL length if (len) { // If length known, then bar.maximum = len; // set the bar to display bar.indeterminate = false; // the percent downloaded } // Get input and output streams var input = conn.inputStream; // To read bytes from server var output = new FileOutputStream(file); // To write bytes to file // Create an array of 4k bytes as an input buffer var buffer = java.lang.reflect.Array.newInstance(java.lang.Byte.TYPE, 4096); var num; while((num=input.read(buffer)) != -1) { // Read and loop until EOF output.write(buffer, 0, num); // Write bytes to file bar.value += num; // Update progress bar } output.close(); // Close streams when done input.close(); } catch(e) { // If anything goes wrong, display error in progress bar if (bar) { bar.indeterminate = false; // Stop animating bar.string = e.toString(); // Replace filename with error } } }

Asynchronous I/O with Node

Node is a fast C++-based JavaScript interpreter with bindings to the low-level Unix APIs for working with processes, files, network sockets, etc., and also to HTTP client and server APIs. Except for some specially named synchronous methods, Node’s bindings are all asynchronous, and by default Node programs never block, which means that they typically scale well and handle high loads effectively. Because the APIs are asynchronous, Node relies on event handlers, which are often implemented using nested functions and closures.[23]

This section highlights some of Node’s most important APIs and events, but the documentation is by no means complete. See Node’s online documentation at http://nodejs.org/api/.

Obtaining Node

Node is free software that you can download from http://nodejs.org. At the time of this writing, Node is still under active development, and binary distributions are not available—you have to build your own copy from source. The examples in this section were written and tested using Node version 0.4. The API is not yet frozen, but the fundamentals illustrated here are unlikely to change very much in the future.

Node is built on top of Google’s V8 JavaScript engine. Node 0.4 uses V8 version 3.1, which implements all of ECMAScript 5 except for strict mode.

Once you have downloaded, compiled, and installed Node, you can run node programs with commands like this:

node program.js

We began the explanation of Rhino with its print() and load() functions. Node has similar features under different names:

// Node defines console.log() for debugging output like browsers do. console.log("Hello Node"); // Debugging output to console // Use require() instead of load(). It loads and executes (only once) the // named module, returning an object that contains its exported symbols. var fs = require("fs"); // Load the "fs" module and return its API object

Node implements all of the standard ECMAScript 5 constructors, properties, and functions in its global object. In addition, however, it also supports the client-side timer functions set setTimeout(), setInterval(), clearTimeout(), and clearInterval():

// Say hello one second from now. setTimeout(function() { console.log("Hello World"); }, 1000);

These client-side globals are covered in Timers. Node’s implementation is compatible with web browser implementations.

Node defines other important globals under the process namespace. These are some of the properties of that object:

process.version // Node version string process.argv // Command-line args as an array argv[0] is "node" process.env // Enviroment variables as an object. e.g.: process.env.PATH process.pid // Process id process.getuid() // Return user id process.cwd() // Return current working directory process.chdir() // Change directory process.exit() // Quit (after running shutdown hooks)

Because Node’s functions and methods are asynchronous, they do not block while waiting for operations to complete. The return value of a nonblocking method cannot return the result of an asynchronous operation to you. If you need to obtain results, or just need to know when an operation is complete, you have to provide a function that Node can invoke when the results are ready or when the operation is complete (or when an error occurs). In some cases (as in the call to setTimeout() above), you simply pass the function as an argument and Node will call it at the appropriate time. In other cases, you can rely on Node’s event infrastructure. Node objects that generate events (known as event emitters) define an on() method for registering handlers. Pass the event type (a string) as the first argument, and pass the handler function as the second argument. Different types of events pass different arguments to the handler function, and you may need to refer to the API documentation to know exactly how to write your handlers:

emitter.on(name, f) // Register f to handle name events from emitter emitter.addListener(name, f) // Ditto: addListener() is a synonym for on() emitter.once(name, f) // One-time only, then f is automatically removed emitter.listeners(name) // Return an array of handler functions emitter.removeListener(name, f) // Deregister event handler f emitter.removeAllListeners(name) // Remove all handlers for name events

The process object shown above is an event emitter. Here are example handlers for some of its events:

// The "exit" event is sent before Node exits. process.on("exit", function() { console.log("Goodbye"); }); // Uncaught exceptions generate events, if any handlers are registered. // Otherwise, the exception just makes Node print an error and exit. process.on("uncaughtException", function(e) { console.log(Exception, e); });// POSIX signals like SIGINT, SIGHUP and SIGTERM generate events process.on("SIGINT", function() { console.log("Ignored Ctrl-C"); });

Since Node is designed for high-performance I/O, its stream API is a commonly used one. Readable streams trigger events when data is ready. In the code below, assume s is a readable stream, obtained elsewhere. We’ll see how to get stream objects for files and network sockets below:

// Input stream s: s.on("data", f); // When data is available, pass it as an argument to f() s.on("end", f); // "end" event fired on EOF when no more data will arrive s.on("error", f); // If something goes wrong, pass exception to f() s.readable // => true if it is a readable stream that is still open s.pause(); // Pause "data" events. For throttling uploads, e.g. s.resume(); // Resume again // Specify an encoding if you want strings passed to "data" event handler s.setEncoding(enc); // How to decode bytes: "utf8", "ascii", or "base64"

Writable streams are less event-centric than readable streams. Use the write() method to send data and use the end() method to close the stream when all the data has been written. The write() method never blocks. If Node cannot write the data immediately and has to buffer it internally, the write() method returns false. Register a handler for「drain」events if you need to know when Node’s buffer has been flushed and the data has actually been written:

// Output stream s: s.write(buffer); // Write binary data s.write(string, encoding) // Write string data. encoding defaults to "utf-8" s.end() // Close the stream. s.end(buffer); // Write final chunk of binary data and close. s.end(str, encoding) // Write final string and close all in one s.writeable; // true if the stream is still open and writeable s.on("drain", f) // Call f() when internal buffer becomes empty

As you can see in the code above, Node’s streams can work with binary data or textual data. Text is transferred using regular JavaScript strings. Bytes are manipulated using a Node-specific type known as a Buffer. Node’s buffers are fixed-length array-like objects whose elements must be numbers between 0 and 255. Node programs can often treat buffers as opaque chunks of data, reading them from one stream and writing them to another. But the bytes in a buffer can be accessed as array elements, and there are methods for copying bytes from one buffer to another, for obtaining slices of an underlying buffer, for writing strings into a buffer using a specified encoding, and for decoding a buffer or a portion of a buffer back to a string:

var bytes = new Buffer(256); // Create a new buffer of 256 bytes for(var i = 0; i < bytes.length; i++) // Loop through the indexes bytes[i] = i; // Set each element of the buffer var end = bytes.slice(240, 256); // Create a new view of the buffer end[0] // => 240: end[0] is bytes[240] end[0] = 0; // Modify an element of the slice bytes[240] // => 0: underlying buffer modified, too var more = new Buffer(8); // Create a separate new buffer end.copy(more, 0, 8, 16); // Copy elements 8-15 of end[] into more[] more[0] // => 248 // Buffers also do binary <=> text conversion // Valid encodings: "utf8", "ascii" and "base64". "utf8" is the default. var buf = new Buffer("2πr", "utf8"); // Encode text to bytes using UTF-8 buf.length // => 3 characters take 4 bytes buf.toString() // => "2πr": back to text buf = new Buffer(10); // Start with a new fixed-length buffer var len = buf.write("πr²", 4); // Write text to it, starting at byte 4 buf.toString("utf8",4, 4+len) // => "πr²": decode a range of bytes

Node’s file and filesystem API is in the「fs」module:

var fs = require("fs"); // Load the filesystem API

This module provides synchronous versions of most of its methods. Any method whose name ends with「Sync」is a blocking method that returns a value or throws an exception. Filesystem methods that do not end with「Sync」are nonblocking methods that pass their result or error to the callback function you specify. The following code shows how to read a text file using a blocking method and how to read a binary file using the nonblocking method:

// Synchronously read a file. Pass an encoding to get text instead of bytes. var text = fs.readFileSync("config.json", "utf8"); // Asynchronously read a binary file. Pass a function to get the data fs.readFile("image.png", function(err, buffer) { if (err) throw err; // If anything went wrong process(buffer); // File contents are in buffer });

Similar writeFile() and writeFileSync() functions exist for writing files:

fs.writeFile("config.json", JSON.stringify(userprefs));

The functions shown above treat the contents of the file as a single string or Buffer. Node also defines a streaming API for reading and writing files. The function below copies one file to another:

// File copy with streaming API. // Pass a callback if you want to know when it is done function fileCopy(filename1, filename2, done) { var input = fs.createReadStream(filename1); // Input stream var output = fs.createWriteStream(filename2); // Output stream input.on("data", function(d) { output.write(d); }); // Copy in to out input.on("error", function(err) { throw err; }); // Raise errors input.on("end", function() { // When input ends output.end(); // close output if (done) done(); // And notify callback }); }

The「fs」module also includes a number of methods for listing directories, querying file attributes, and so on. The Node program below uses synchronous methods to list the contents of a directory, along with file size and modification date:

#! /usr/local/bin/node var fs = require("fs"), path = require("path"); // Load the modules we need var dir = process.cwd(); // Current directory if (process.argv.length > 2) dir = process.argv[2]; // Or from the command line var files = fs.readdirSync(dir); // Read directory contents process.stdout.write("Name\tSize\tDate\n"); // Output a header files.forEach(function(filename) { // For each file name var fullname = path.join(dir,filename); // Join dir and name var stats = fs.statSync(fullname); // Get file attributes if (stats.isDirectory()) filename += "/"; // Mark subdirectories process.stdout.write(filename + "\t" + // Output file name plus stats.size + "\t" + // file size plus stats.mtime + "\n"); // modification time });

Note the #! comment on the first line above. This is a Unix「shebang」comment used to make a script file like this self-executable by specifying what language interpreter to run it with. Node ignores lines like this when they appear as the first line of the file.

The「net」module is an API for TCP-based networking. (See the「dgram」module for datagram-based networking.) Here’s a very simple TCP server in Node:

// A simple TCP echo server in Node: it listens for connections on port 2000 // and echoes the client's data back to it. var net = require('net'); var server = net.createServer(); server.listen(2000, function() { console.log("Listening on port 2000"); }); server.on("connection", function(stream) { console.log("Accepting connection from", stream.remoteAddress); stream.on("data", function(data) { stream.write(data); }); stream.on("end", function(data) { console.log("Connection closed"); }); });

In addition to the basic「net」module, Node has built-in support for the HTTP protocol using the「http」module. The examples that follow demonstrate it in more detail.

Node Example: HTTP Server

Example 12-2 is a simple HTTP server in Node. It serves files from the current directory and also implements two special-purpose URLs that it handles specially. It uses Node’s「http」module and also uses the file and stream APIs demonstrated earlier. Example 18-17 in Chapter 18 is a similar specialized HTTP server example.

Example 12-2. An HTTP server in Node

// This is a simple NodeJS HTTP server that can serve files from the current // directory and also implements two special URLs for testing. // Connect to the server at http://localhost:8000 or http://127.0.0.1:8000 // First, load the modules we'll be using var http = require('http'); // HTTP server API var fs = require('fs'); // For working with local files var server = new http.Server(); // Create a new HTTP server server.listen(8000); // Run it on port 8000. // Node uses the "on()" method to register event handlers. // When the server gets a new request, run this function to handle it. server.on("request", function (request, response) { // Parse the requested URL var url = require('url').parse(request.url); // A special URL that just makes the server wait before sending the // response. This can be useful to simulate a slow network connection. if (url.pathname === "/test/delay") { // Use query string for delay amount, or 2000 milliseconds var delay = parseInt(url.query) || 2000; // Set the response status code and headers response.writeHead(200, {"Content-Type": "text/plain; charset=UTF-8"}); // Start writing the response body right away response.write("Sleeping for " + delay + " milliseconds..."); // And then finish it in another function invoked later. setTimeout(function() { response.write("done."); response.end(); }, delay); } // If the request was for "/test/mirror", send back the request verbatim. // Useful when you need to see the request headers and body. else if (url.pathname === "/test/mirror") { // Response status and headers response.writeHead(200, {"Content-Type": "text/plain; charset=UTF-8"}); // Begin the response body with the request response.write(request.method + " " + request.url + " HTTP/" + request.httpVersion + "\r\n"); // And the request headers for(var h in request.headers) { response.write(h + ": " + request.headers[h] + "\r\n"); } response.write("\r\n"); // End headers with an extra blank line // We complete the response in these event handler functions: // When a chunk of the request body, add it to the response. request.on("data", function(chunk) { response.write(chunk); }); // When the request ends, the response is done, too. request.on("end", function(chunk) { response.end(); }); } // Otherwise, serve a file from the local directory. else { // Get local filename and guess its content type based on its extension. var filename = url.pathname.substring(1); // strip leading / var type; switch(filename.substring(filename.lastIndexOf(".")+1)) { // extension case "html": case "htm": type = "text/html; charset=UTF-8"; break; case "js": type = "application/javascript; charset=UTF-8"; break; case "css": type = "text/css; charset=UTF-8"; break; case "txt" : type = "text/plain; charset=UTF-8"; break; case "manifest": type = "text/cache-manifest; charset=UTF-8"; break; default: type = "application/octet-stream"; break; } // Read the file asynchronously and pass the content as a single // chunk to the callback function. For really large files, using the // streaming API with fs.createReadStream() would be better. fs.readFile(filename, function(err, content) { if (err) { // If we couldn't read the file for some reason response.writeHead(404, { // Send a 404 Not Found status "Content-Type": "text/plain; charset=UTF-8"}); response.write(err.message); // Simple error message body response.end(); // Done } else { // Otherwise, if the file was read successfully. response.writeHead(200, // Set the status code and MIME type {"Content-Type": type}); response.write(content); // Send file contents as response body response.end(); // And we're done } }); } });

Node Example: HTTP Client Utilities Module

Example 12-3 uses the「http」module to define utility functions for issuing HTTP GET and POST requests. The example is structured as an「httputils」module, which you might use in your own code like this:

var httputils = require("./httputils"); // Note no ".js" suffix httputils.get(url, function(status, headers, body) { console.log(body); });

The require() function does not execute module code with an ordinary eval(). Modules are evaluated in a special environment so that they cannot define any global variables or otherwise alter the global namespace. This special module evaluation environment always includes a global object named exports. Modules export their API by defining properties in this object.[24]

Example 12-3. Node「httputils」module

// // An "httputils" module for Node. // // Make an asynchronous HTTP GET request for the specified URL and pass the // HTTP status, headers and response body to the specified callback function. // Notice how we export this method through the exports object. exports.get = function(url, callback) { // Parse the URL and get the pieces we need from it url = require('url').parse(url); var hostname = url.hostname, port = url.port || 80; var path = url.pathname, query = url.query; if (query) path += "?" + query; // Make a simple GET request var client = require("http").createClient(port, hostname); var request = client.request("GET", path, { "Host": hostname // Request headers }); request.end(); // A function to handle the response when it starts to arrive request.on("response", function(response) { // Set an encoding so the body is returned as text, not bytes response.setEncoding("utf8"); // Save the response body as it arrives var body = "" response.on("data", function(chunk) { body += chunk; }); // When response is complete, call the callback response.on("end", function() { if (callback) callback(response.statusCode, response.headers, body); }); }); }; // Simple HTTP POST request with data as the request body exports.post = function(url, data, callback) { // Parse the URL and get the pieces we need from it url = require('url').parse(url); var hostname = url.hostname, port = url.port || 80; var path = url.pathname, query = url.query; if (query) path += "?" + query; // Figure out the type of data we're sending as the request body var type; if (data == null) data = ""; if (data instanceof Buffer) // Binary data type = "application/octet-stream"; else if (typeof data === "string") // String data type = "text/plain; charset=UTF-8"; else if (typeof data === "object") { // Name=value pairs data = require("querystring").stringify(data); type = "application/x-www-form-urlencoded"; } // Make a POST request, including a request body var client = require("http").createClient(port, hostname); var request = client.request("POST", path, { "Host": hostname, "Content-Type": type }); request.write(data); // Send request body request.end(); request.on("response", function(response) { // Handle the response response.setEncoding("utf8"); // Assume it is text var body = "" // To save the response body response.on("data", function(chunk) { body += chunk; }); response.on("end", function() { // When done, call the callback if (callback) callback(response.statusCode, response.headers, body); }); }); };

* * *

[23] Client-side JavaScript is also highly asynchronous and event-based, and the examples in this section may be easier to understand once you have read Part II and have been exposed to client-side JavaScript programs.

[24] Node implements the CommonJS module contract, which you can read about at http://www.commonjs.org/specs/modules/1.0/.

Part II. Client-Side JavaScript

This part of the book, Chapters 13 through 22, documents JavaScript as it is implemented in web browsers. These chapters introduce a variety of scriptable objects that represent web browser windows, documents and document content. They also explain important web application APIs for networking, storing and retrieving data, and drawing graphics:

Chapter 13, JavaScript in Web Browsers

Chapter 14, The Window Object

Chapter 15, Scripting Documents

Chapter 16, Scripting CSS

Chapter 17, Handling Events

Chapter 18, Scripted HTTP

Chapter 19, The jQuery Library

Chapter 20, Client-Side Storage

Chapter 21, Scripted Media and Graphics

Chapter 22, HTML5 APIs

Chapter 13. JavaScript in Web Browsers

The first part of this book described the core JavaScript language. We now move on to JavaScript as used within web browsers, commonly called client-side JavaScript. Most of the examples we’ve seen so far, while legal JavaScript code, have no particular context; they are JavaScript fragments that run in no specified environment. This chapter provides that context.

Before we begin talking about JavaScript, it is worth thinking about the web pages we display in web browsers. Some pages present static information and can be called documents. (The presentation of that static information may be fairly dynamic—because of JavaScript—but the information itself is static.) Other web pages feel more like applications than documents. These pages might dynamically load new information as needed, they might be graphical rather than textual, and they might operate offline and save data locally so they can restore your state when you visit them again. Still other web pages sit somewhere in the middle of the spectrum and combine features of both documents and applications.

This chapter begins with an overview of client-side JavaScript. It includes a simple example and a discussion of the role of JavaScript in both web documents and web applications. That first introductory section also explains what is coming in the Part II chapters that follow. The sections that follow explain some important details about how JavaScript code is embedded and executed within HTML documents, and then they introduce the topics of compatibility, accessibility, and security.

Client-Side JavaScript

The Window object is the main entry point to all client-side JavaScript features and APIs. It represents a web browser window or frame, and you can refer to it with the identifier window. The Window object defines properties like location, which refers to a Location object that specifies the URL currently displayed in the window and allows a script to load a new URL into the window:

// Set the location property to navigate to a new web page window.location = "http://www.oreilly.com/";

The Window object also defines methods like alert(), which displays a message in a dialog box, and setTimeout(), which registers a function to be invoked after a specified amount of time:

// Wait 2 seconds and then say hello setTimeout(function() { alert("hello world"); }, 2000);

Notice that the code above does not explicitly use the window property. In client-side JavaScript, the Window object is also the global object. This means that the Window object is at the top of the scope chain and that its properties and methods are effectively global variables and global functions. The Window object has a property named window that always refers to itself. You can use this property if you need to refer to the window object itself, but it is not usually necessary to use window if you just want to refer to access properties of the global window object.

There are a number of other important properties, methods, and constructors defined by the Window object. See Chapter 14 for complete details.

One of the most important properties of the Window object is document: it refers to a Document object that represents the content displayed in the window. The Document object has important methods such as getElementById(), which returns a single document element (representing an open/close pair of HTML tags and all of the content between them) based on the value of its id attribute:

// Find the element with id="timestamp" var timestamp = document.getElementById("timestamp");

The Element object returned by getElementById() has other important properties and methods that allow scripts to get its content, set the value of its attributes, and so on:

// If the element is empty, then insert the current date and time into it if (timestamp.firstChild == null) timestamp.appendChild(document.createTextNode(new Date().toString()));

Techniques for querying, traversing, and modifying document content are covered in Chapter 15.

Each Element object has style and className properties that allow scripts to specify CSS styles for a document element or to alter the CSS class names that apply to the element. Setting these CSS-related properties alters the presentation of the document element:

// Explicitly alter the presentation of the heading element timestamp.style.backgroundColor = "yellow"; // Or just change the class and let the stylesheet specify the details: timestamp.className = "highlight";

The style and className properties, as well as other techniques for scripting CSS, are covered in Chapter 16.

Another set of important properties on Window, Document, and Element objects are the event handler properties. These allow scripts to specify functions that should be invoked asynchronously when certain events occur. Event handlers allow JavaScript code to alter the behavior of windows, of documents, and of the elements that make up those documents. Event handler properties have names that begin with the word「on」, and you might use them like this:

// Update the content of the timestamp element when the user clicks on it timestamp.onclick = function() { this.innerHTML = new Date().toString(); }

One of the most important event handlers is the onload handler of the Window object. It is triggered when the content of the document displayed in the window is stable and ready to be manipulated. JavaScript code is commonly wrapped within an onload event handler. Events are the subject of Chapter 17. Example 13-1 demonstrates the onload handler and shows more client-side JavaScript code that queries document elements, alters CSS classes, and defines event handlers. The HTML <script> element holds the JavaScript code of this example and is explained in Embedding JavaScript in HTML. Note that the code includes a function defined within another function. Nested functions are common in client-side JavaScript, because of its extensive use of event handlers.

Example 13-1. Simple client-side JavaScript for revealing content

<!DOCTYPE html> <html> <head> <style> /* CSS styles for this page */ .reveal * { display: none; } /* Children of class="reveal" are not shown */ .reveal *.handle { display: block;} /* Except for the class="handle" child */ </style> <script> // Don't do anything until the entire document has loaded window.onload = function() { // Find all container elements with class "reveal" var elements = document.getElementsByClassName("reveal"); for(var i = 0; i < elements.length; i++) { // For each one... var elt = elements[i]; // Find the "handle" element with the container var title = elt.getElementsByClassName("handle")[0]; // When that element is clicked, reveal the rest of the content title.onclick = function() { if (elt.className == "reveal") elt.className = "revealed"; else if (elt.className == "revealed") elt.className = "reveal"; } } }; </script> </head> <body> <div class="reveal"> <h1 class="handle">Click Here to Reveal Hidden Text</h1> <p>This paragraph is hidden. It appears when you click on the title.</p> </div> </body> </html>

We noted in the introduction to this chapter that some web pages feel like documents and some feel like applications. The two subsections that follow explore the use of JavaScript in each kind of web page.

JavaScript in Web Documents

A JavaScript program can traverse and manipulate document content through the Document object and the Element objects it contains. It can alter the presentation of that content by scripting CSS styles and classes. And it can define the behavior of document elements by registering appropriate event handlers. The combination of scriptable content, presentation, and behavior is called Dynamic HTML or DHTML, and techniques for creating DHTML documents are explained in Chapters 15, 16, and 17.

The use of JavaScript in web documents should usually be restrained and understated. The proper role of JavaScript is to enhance a user’s browsing experience, making it easier to obtain or transmit information. The user’s experience should not be dependent on JavaScript, but JavaScript can help to facilitate that experience, for example by:

Creating animations and other visual effects to subtly guide a user and help with page navigation

Sorting the columns of a table to make it easier for a user to find what she needs

Hiding certain content and revealing details progressively as the user「drills down」into that content

JavaScript in Web Applications

Web applications use all of the JavaScript DHTML features that web documents do, but they also go beyond these content, presentation, and behavior manipulation APIs to take advantage of other fundamental services provided by the web browser environment.

To really understand web applications, it is important to realize that web browsers have grown well beyond their original role as tools for displaying documents and have transformed themselves into simple operating systems. Consider: a traditional operating system allows you to organize icons (which represent files and applications) on the desktop and in folders. A web browser allows you to organize bookmarks (which represent documents and web applications) in a toolbar and in folders. An OS runs multiple applications in separate windows; a web browser displays multiple documents (or applications) in separate tabs. An OS defines low-level APIs for networking, drawing graphics, and saving files. Web browsers define low-level APIs for networking (Chapter 18), saving data (Chapter 20), and drawing graphics (Chapter 21).

With this notion of web browser as simplified OS in mind, we can define web applications as web pages that use JavaScript to access the more advanced services (such as networking, graphics, and data storage) offered by browsers. The best known of these advanced services is the XMLHttpRequest object, which enables networking through scripted HTTP requests. Web apps use this service to obtain new information from the server without a page reload. Web applications that do this are commonly called Ajax applications and they form the backbone of what is known as「Web 2.0.」XMLHttpRequest is covered in detail in Chapter 18.

The HTML5 specification (which, at the time of this writing, is still in draft form) and related specifications are defining a number of other important APIs for web apps. These include the data storage and graphics APIs of Chapters 21 and 20 as well as APIs for a number of other features, such as geolocation, history management, and background threads. When implemented, these APIs will enable a further evolution of web application capabilities. They are covered in Chapter 22.

JavaScript is more central to web applications than it is to web documents, of course. JavaScript enhances web documents, but a well-designed document will continue to work with JavaScript disabled. Web applications are, by definition, JavaScript programs that use the OS-type services provided by the web browser, and they would not be expected to work with JavaScript disabled.[25]

* * *

[25] Interactive web pages that communicate with server-side CGI scripts through HTML form submissions were the original「web application」and can be written without the use of JavaScript. This is not the kind of web application that we’ll be discussing in this book, however.

Embedding JavaScript in HTML

Client-side JavaScript code is embedded within HTML documents in four ways:

Inline, between a pair of <script> and </script> tags

From an external file specified by the src attribute of a <script> tag

In an HTML event handler attribute, such as onclick or onmouseover

In a URL that uses the special javascript: protocol.

The subsections that follow explain each of these four JavaScript embedding techniques. It is worth noting, however, that HTML event handler attributes and javascript: URLs are rarely used in modern JavaScript code (they were somewhat common in the early days of the Web). Inline scripts (those without a src attribute) are also less common than they once were. A programming philosophy known as unobtrusive JavaScript argues that content (HTML) and behavior (JavaScript code) should as much as possible be kept separate. According to this programming philosophy, JavaScript is best embedded in HTML documents using <script> elements with src attributes.

The <script> Element

