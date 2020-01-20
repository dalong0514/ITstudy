A string representation of regexp.

Throws

TypeError

If this method is invoked on an object that is not a RegExp.

Description

The RegExp.toString() method returns a string representation of a regular expression in the form of a regular-expression literal.

Note that implementations are not required to add escape sequences to ensure that the returned string is a legal regular-expression literal. Consider the regular expression created by the expression new RegExp("/","g"). An implementation of RegExp.toString() could return ///g for this regular expression; it could also add an escape sequence and return /\//g.

Name

String — support for strings

Inherits from

Object → String

Constructor

new String(s) // Constructor function String(s) // Conversion function

Arguments

s

The value to be stored in a String object or converted to a primitive string.

Returns

When String() is used as a constructor with the new operator, it returns a String object, which holds the string s or the string representation of s. When the String() constructor is used without the new operator, it simply converts s to a primitive string and returns the converted value.

Properties

length

The number of characters in the string.

Methods

charAt()

Extracts the character at a given position from a string.

charCodeAt()

Returns the encoding of the character at a given position in a string.

concat()

Concatenates one or more values to a string.

indexOf()

Searches the string for a character or substring.

lastIndexOf()

Searches the string backward for a character or substring.

localeCompare()

Compares strings using locale-specific ordering.

match()

Performs pattern matching with a regular expression.

replace()

Performs a search-and-replace operation with a regular expression.

search()

Searches a string for a substring that matches a regular expression.

slice()

Returns a slice or substring of a string.

split()

Splits a string into an array of strings, breaking at a specified delimiter string or regular expression.

substr()

Extracts a substring of a string; a variant of substring().

substring()

Extracts a substring of a string.

toLowerCase()

Returns a copy of the string, with all characters converted to lowercase.

toString()

Returns the primitive string value.

toUpperCase()

Returns a copy of the string, with all characters converted to uppercase.

trim()

Returns a copy of the string with all leading and trailing whitespace removed.

valueOf()

Returns the primitive string value.

Static Methods

String.fromCharCode()

Creates a new string using the character codes passed as arguments.

HTML Methods

Since the earliest days of JavaScript, the String class has defined a number of methods that return a string modified by placing it within HTML tags. These methods have never been standardized by ECMAScript but can be useful in both client- and server-side JavaScript code that dynamically generates HTML. If you are willing to use nonstandard methods, you might create the HTML source for a bold, red hyperlink with code like this:

var s = "click here!"; var html = s.bold().link("javascript:alert('hello')").fontcolor("red");

Because these methods are not standardized, they do not have individual reference entries in the pages that follow:

anchor( name )

Returns a copy of the string, in an <a name=> environment.

big()

Returns a copy of the string, in a <big> environment.

blink()

Returns a copy of the string, in a <blink> environment.

bold()

Returns a copy of the string, in a <b> environment.

fixed()

Returns a copy of the string, in a <tt> environment.

fontcolor( color )

Returns a copy of the string, in a <font color=> environment.

fontsize( size )

Returns a copy of the string, in a <font size=> environment.

italics()

Returns a copy of the string, in an <i> environment.

link( url )

Returns a copy of the string, in an <a href=> environment.

small()

Returns a copy of the string, in a <small> environment.

strike()

Returns a copy of the string, in a <strike> environment.

sub()

Returns a copy of the string, in a <sub>

sup()

Returns a copy of the string, in a <sup> environment.

Description

Strings are a primitive datatype in JavaScript. The String class type exists to provide methods for operating on primitive string values. The length property of a String object specifies the number of characters in the string. The String class defines a number of methods for operating on strings; for example, there are methods for extracting a character or a substring from the string or searching for a character or a substring. Note that JavaScript strings are immutable: none of the methods defined by the String class allows you to change the contents of a string. Instead, methods such as String.toUpperCase() return an entirely new string, without modifying the original.

In ECMAScript 5, and in many JavaScript implementations prior to ES5, strings behave like read-only arrays in which each element is a single-character string. For example, to extract the third character from a string s, you can write s[2] instead of s.charAt(2). When the for/in statement is applied to a string, it enumerates these array indexes for each character in the string.

See Also

Chapter 3

Name

String.charAt() — get the ‘n’th character from a string

Synopsis

string.charAt(n)

Arguments

n

The index of the character that should be returned from string.

Returns

The nth character of string.

Description

String.charAt() returns the nth character of the string string. The first character of the string is numbered 0. If n is not between 0 and string.length−1, this method returns an empty string. Note that JavaScript does not have a character data type that is distinct from the string type, so the returned character is a string of length 1.

See Also

String.charCodeAt(), String.indexOf(), String.lastIndexOf()

Name

String.charCodeAt() — get the nth character code from a string

Synopsis

string.charCodeAt(n)

Arguments

n

The index of the character whose encoding is to be returned.

Returns

The Unicode encoding of the nth character within string. This return value is a 16-bit integer between 0 and 65535.

Description

charCodeAt() is like charAt(), except that it returns the character encoding at a specific location, rather than returning a substring that contains the character itself. If n is negative or greater than or equal to the string length, charCodeAt() returns NaN.

See String.fromCharCode() for a way to create a string from Unicode encodings.

See Also

String.charAt(), String.fromCharCode()

Name

String.concat() — concatenate strings

Synopsis

string.concat(value, ...)

Arguments

value, ...

One or more values to be concatenated to string.

Returns

A new string that results from concatenating each of the arguments to string.

Description

concat() converts each of its arguments to a string (if necessary) and appends them, in order, to the end of string. It returns the resulting concatenation. Note that string itself is not modified.

String.concat() is an analog to Array.concat(). Note that it is often easier to use the + operator to perform string concatenation.

See Also

Array.concat()

Name

String.fromCharCode() — create a string from character encodings

Synopsis

String.fromCharCode(c1, c2, ...)

Arguments

c1, c2, ...

Zero or more integers that specify the Unicode encodings of the characters in the string to be created.

Returns

A new string containing characters with the specified encodings.

Description

This static method provides a way to create a string by specifying the individual numeric Unicode encodings of its characters. Note that as a static method, fromCharCode() is a property of the String() constructor and is not actually a method of strings or String objects.

String.charCodeAt() is a companion instance method that provides a way to obtain the encodings of the individual characters of a string.

Example

// Create the string "hello" var s = String.fromCharCode(104, 101, 108, 108, 111);

See Also

String.charCodeAt()

Name

String.indexOf() — search a string

Synopsis

string.indexOf(substring) string.indexOf(substring, start)

Arguments

substring

The substring that is to be searched for within string.

start

An optional integer argument that specifies the position within string at which the search is to start. Legal values are 0 (the position of the first character in the string) to string .length−1 (the position of the last character in the string). If this argument is omitted, the search begins at the first character of the string.

Returns

The position of the first occurrence of substring within string that appears after the start position, if any, or −1 if no such occurrence is found.

Description

String.indexOf() searches the string string from beginning to end to see if it contains an occurrence of substring. The search begins at position start within string, or at the beginning of string if start is not specified. If an occurrence of substring is found, String.indexOf() returns the position of the first character of the first occurrence of substring within string. Character positions within string are numbered starting with zero.

If no occurrence of substring is found within string, String.indexOf() returns −1.

See Also

String.charAt(), String.lastIndexOf(), String.substring()

Name

String.lastIndexOf() — search a string backward

Synopsis

string.lastIndexOf(substring) string.lastIndexOf(substring, start)

Arguments

substring

The substring to be searched for within string.

start

An optional integer argument that specifies the position within string where the search is to start. Legal values are from 0 (the position of the first character in the string) to string .length−1 (the position of the last character in the string). If this argument is omitted, the search begins with the last character of the string.

Returns

The position of the last occurrence of substring within string that appears before the start position, if any, or −1 if no such occurrence is found within string.

Description

String.lastIndexOf() searches the string from end to beginning to see if it contains an occurrence of substring. The search begins at position start within string, or at the end of string if start is not specified. If an occurrence of substring is found, String.lastIndexOf() returns the position of the first character of that occurrence. Since this method searches from end to beginning of the string, the first occurrence found is the last one in the string that occurs before the start position.

If no occurrence of substring is found, String.lastIndexOf() returns −1.

Note that although String.lastIndexOf() searches string from end to beginning, it still numbers character positions within string from the beginning. The first character of the string has position 0, and the last has position string .length−1.

See Also

String.charAt(), String.indexOf(), String.substring()

Name

String.length — the length of a string

Synopsis

string.length

Description

The String.length property is a read-only integer that indicates the number of characters in the specified string. For any string s, the index of the last character is s .length−1. The length property of a string is not enumerated by a for/in loop and may not be deleted with the delete operator.

Name

String.localeCompare() — compare one string to another, using locale-specific ordering

Synopsis

string.localeCompare(target)

Arguments

target

A string to be compared, in a locale-sensitive fashion, with string.

Returns

A number that indicates the result of the comparison. If string is「less than」target, localeCompare() returns a number less than zero. If string is「greater than」target, the method returns a number greater than zero. And if the strings are identical or indistinguishable according to the locale ordering conventions, the method returns 0.

Description

When the < and > operators are applied to strings, they compare those strings using only the Unicode encodings of those characters and do not consider the collation order of the current locale. The ordering produced in this way is not always correct. Consider Spanish, for example, in which the letters「ch」are traditionally sorted as if they were a single letter that appeared between the letters「c」and「d」.

localeCompare() provides a way to compare strings that does take the collation order of the default locale into account. The ECMAScript standard does not specify how the locale-specific comparison is done; it merely specifies that this function utilize the collation order provided by the underlying operating system.

Example

You can use code like the following to sort an array of strings into a locale-specific ordering:

var strings; // The array of strings to sort; initialized elsewhere strings.sort(function(a,b) { return a.localeCompare(b) });

Name

String.match() — find one or more regular-expression matches

Synopsis

string.match(regexp)

Arguments

regexp

A RegExp object that specifies the pattern to be matched. If this argument is not a RegExp, it is first converted to one by passing it to the RegExp() constructor.

Returns

An array containing the results of the match. The contents of the array depend on whether regexp has the global「g」attribute set. Details on this return value are given in the Description.

Description

match() searches string for one or more matches of regexp. The behavior of this method depends significantly on whether regexp has the「g」attribute or not (see Chapter 10 for full details on regular expressions).

If regexp does not have the「g」attribute, match() searches string for a single match. If no match is found, match() returns null. Otherwise, it returns an array containing information about the match that it found. Element 0 of the array contains the matched text. The remaining elements contain the text that matches any parenthesized subexpressions within the regular expression. In addition to these normal array elements, the returned array also has two object properties. The index property of the array specifies the character position within string of the start of the matched text. Also, the input property of the returned array is a reference to string itself.

If regexp has the「g」flag, match() does a global search, searching string for all matching substrings. It returns null if no match is found, and it returns an array if one or more matches are found. The contents of this returned array are quite different for global matches, however. In this case, the array elements contain each of the matched substrings within string. The returned array does not have index or input properties in this case. Note that for global matches, match() does not provide information about parenthesized subexpressions, nor does it specify where within string each match occurred. If you need to obtain this information for a global search, you can use RegExp.exec().

Example

The following global match finds all numbers within a string:

"1 plus 2 equals 3".match(/\d+/g) // Returns ["1", "2", "3"]

The following nonglobal match uses a more complex regular expression with several parenthesized subexpressions. It matches a URL, and its subexpressions match the protocol, host, and path portions of the URL:

var url = /(\w+):\/\/([\w.]+)\/(\S*)/; var text = "Visit my home page at http://www.isp.com/~david"; var result = text.match(url); if (result != null) { var fullurl = result[0]; // Contains "http://www.isp.com/~david" var protocol = result[1]; // Contains "http" var host = result[2]; // Contains "www.isp.com" var path = result[3]; // Contains "~david" }

See Also

RegExp, RegExp.exec(), RegExp.test(), String.replace(), String.search(); Chapter 10

Name

String.replace() — replace substring(s) matching a regular expression

Synopsis

string.replace(regexp, replacement)

Arguments

regexp

The RegExp object that specifies the pattern to be replaced. If this argument is a string, it is used as a literal text pattern to be searched for; it is not first converted to a RegExp object.

replacement

A string that specifies the replacement text, or a function that is invoked to generate the replacement text. See the Description section for details.

Returns

A new string, with the first match, or all matches, of regexp replaced with replacement.

Description

replace() performs a search-and-replace operation on string. It searches string for one or more substrings that match regexp and replaces them with replacement. If regexp has the global「g」attribute specified, replace() replaces all matching substrings. Otherwise, it replaces only the first matching substring.

replacement may be a string or a function. If it is a string, each match is replaced by the string. Note that the $ character has special meaning within the replacement string. As shown in the following table, it indicates that a string derived from the pattern match is used in the replacement.

Characters

Replacement

$1, $2, ..., $99

The text that matched the 1st through 99th parenthesized subexpression within regexp

$&

The substring that matched regexp

$'

The text to the left of the matched substring

$'

The text to the right of the matched substring

$$

A literal dollar sign

ECMAScript v3 specifies that the replacement argument to replace() may be a function instead of a string. In this case, the function is invoked for each match, and the string it returns is used as the replacement text. The first argument to the function is the string that matches the pattern. The next arguments are the strings that match any parenthesized subexpressions within the pattern; there may be zero or more of these arguments. The next argument is an integer that specifies the position within string at which the match occurred, and the final argument to the replacement function is string itself.

Example

To ensure that the capitalization of the word「JavaScript」is correct:

text.replace(/javascript/i, "JavaScript");

To convert a single name from「Doe, John」format to「John Doe」format:

name.replace(/(\w+)\s*,\s*(\w+)/, "$2 $1");

To replace all double quotes with double back and forward single quotes:

text.replace(/"([^"]*)"/g, "''$1''");

To capitalize the first letter of all words in a string:

text.replace(/\b\w+\b/g, function(word) { return word.substring(0,1).toUpperCase() + word.substring(1); });

See Also

RegExp, RegExp.exec(), RegExp.test(), String.match(), String.search(); Chapter 10

Name

String.search() — search for a regular expression

Synopsis

string.search(regexp)

Arguments

regexp

A RegExp object that specifies the pattern to be searched for in string. If this argument is not a RegExp, it is first converted to one by passing it to the RegExp() constructor.

Returns

The position of the start of the first substring of string that matches regexp, or −1 if no match is found.

Description

search() looks for a substring matching regexp within string and returns the position of the first character of the matching substring, or −1 if no match was found.

search() does not do global matches; it ignores the g flag. It also ignores the lastIndex property of regexp and always searches from the beginning of the string, which means that it always returns the position of the first match in string.

Example

var s = "JavaScript is fun"; s.search(/script/i) // Returns 4 s.search(/a(.)a/) // Returns 1

See Also

RegExp, RegExp.exec(), RegExp.test(), String.match(), String.replace(); Chapter 10

Name

String.slice() — extract a substring

Synopsis

string.slice(start, end)

Arguments

start

The string index where the slice is to begin. If negative, this argument specifies a position measured from the end of the string. That is, −1 indicates the last character, −2 indicates the second from last character, and so on.

end

The string index immediately after the end of the slice. If not specified, the slice includes all characters from start to the end of the string. If this argument is negative, it specifies a position measured from the end of the string.

Returns

A new string that contains all the characters of string from and including start, and up to but not including end.

Description

slice() returns a string containing a slice, or substring, of string. It does not modify string.

The String methods slice(), substring(), and the deprecated substr() all return specified portions of a string. slice() is more flexible than substring() because it allows negative argument values. slice() differs from substr() in that it specifies a substring with two character positions, while substr() uses one position and a length. Note also that String.slice() is an analog of Array.slice().

Example

var s = "abcdefg"; s.slice(0,4) // Returns "abcd" s.slice(2,4) // Returns "cd" s.slice(4) // Returns "efg" s.slice(3,-1) // Returns "def" s.slice(3,-2) // Returns "de" s.slice(-3,-1) // Should return "ef"; returns "abcdef" in IE 4

Bugs

Negative values for start do not work in Internet Explorer 4 (but they do in later versions of IE). Instead of specifying a character position measured from the end of the string, they specify character position 0.

See Also

Array.slice(), String.substring()

Name

String.split() — break a string into an array of strings

Synopsis

string.split(delimiter, limit)

Arguments

delimiter

The string or regular expression at which the string splits.

limit

This optional integer specifies the maximum length of the returned array. If specified, no more than this number of substrings will be returned. If not specified, the entire string will be split, regardless of its length.

Returns

An array of strings, created by splitting string into substrings at the boundaries specified by delimiter. The substrings in the returned array do not include delimiter itself, except in the case noted in the Description.

Description

The split() method creates and returns an array of as many as limit substrings of the specified string. These substrings are created by searching the string from start to end for text that matches delimiter and breaking the string before and after that matching text. The delimiting text is not included in any of the returned substrings, except as noted at the end of this section. Note that if the delimiter matches the beginning of the string, the first element of the returned array will be an empty string—the text that appears before the delimiter. Similarly, if the delimiter matches the end of the string, the last element of the array (assuming no conflicting limit) will be the empty string.

If no delimiter is specified, the string is not split at all, and the returned array contains only a single, unbroken string element. If delimiter is the empty string or a regular expression that matches the empty string, the string is broken between each character, and the returned array has the same length as the string does, assuming no smaller limit is specified. (Note that this is a special case because the empty strings before the first character and after the last character are not matched.)

As noted earlier, the substrings in the array returned by this method do not contain the delimiting text used to split the string. However, if delimiter is a regular expression that contains parenthesized subexpressions, the substrings that match those parenthesized subexpressions (but not the text that matches the regular expression as a whole) are included in the returned array.

Note that the String.split() method is the inverse of the Array.join() method.

Example

The split() method is most useful when you are working with highly structured strings. For example:

"1:2:3:4:5".split(":"); // Returns ["1","2","3","4","5"] "|a|b|c|".split("|"); // Returns ["", "a", "b", "c", ""]

Another common use of the split() method is to parse commands and similar strings by breaking them down into words delimited by spaces:

var words = sentence.split(' ');

It is easier to split a string into words using a regular expression as a delimiter:

var words = sentence.split(/\s+/);

To split a string into an array of characters, use the empty string as the delimiter. Use the limit argument if you only want to split a prefix of the string into an array of characters:

"hello".split(""); // Returns ["h","e","l","l","o"] "hello".split("", 3); // Returns ["h","e","l"]

If you want the delimiters or one or more portions of the delimiter included in the returned array, use a regular expression with parenthesized subexpressions. For example, the following code breaks a string at HTML tags and includes those tags in the returned array:

var text = "hello <b>world</b>"; text.split(/(<[^>]*>)/); // Returns ["hello ","<b>","world","</b>",""]

See Also

Array.join(), RegExp; Chapter 10

Name

String.substr() — extract a substring

Availability

deprecated

Synopsis

string.substr(start, length)

Arguments

start

The start position of the substring. If this argument is negative, it specifies a position measured from the end of the string: −1 specifies the last character, −2 specifies the second-to-last character, and so on.

length

The number of characters in the substring. If this argument is omitted, the returned substring includes all characters from the starting position to the end of the string.

Returns

A copy of the portion of string starting at and including the character specified by start and continuing for length characters, or to the end of the string if length is not specified.

Description

substr() extracts and returns a substring of string. It does not modify string.

Note that substr() specifies the desired substring with a character position and a length. This provides a useful alternative to String.substring() and String.splice(), which specify a substring with two character positions. Note, however, that this method has not been standardized by ECMAScript and is therefore deprecated.

Example

var s = "abcdefg"; s.substr(2,2); // Returns "cd" s.substr(3); // Returns "defg" s.substr(-3,2); // Should return "ef"; returns "ab" in IE 4

Bugs

Negative values for start do not work in IE. Instead of specifying a character position measured from the end of the string, they specify character position 0.

See Also

String.slice(), String.substring()

Name

String.substring() — return a substring of a string

Synopsis

string.substring(from, to)

Arguments

from

A nonnegative integer that specifies the position within string of the first character of the desired substring.

to

A nonnegative optional integer that is one greater than the position of the last character of the desired substring. If this argument is omitted, the returned substring runs to the end of the string.

Returns

A new string, of length to-from, which contains a substring of string. The new string contains characters copied from positions from to to−1 of string.

Description

String.substring() returns a substring of string consisting of the characters between positions from and to. The character at position from is included, but the character at position to is not included.

If from equals to, this method returns an empty (length 0) string. If from is greater than to, this method first swaps the two arguments and then returns the substring between them.

It is important to remember that the character at position from is included in the substring but that the character at position to is not included in the substring. While this may seem arbitrary or counterintuitive, a notable feature of this system is that the length of the returned substring is always equal to to-from.

Note that String.slice() and the nonstandard String.substr() can also extract substrings from a string. Unlike those methods, String.substring() does not accept negative arguments.

See Also

String.charAt(), String.indexOf(), String.lastIndexOf(), String.slice(), String.substr()

Name

String.toLocaleLowerCase() — convert a string to lowercase

Synopsis

string.toLocaleLowerCase()

Returns

A copy of string, converted to lowercase letters in a locale-specific way. Only a few languages, such as Turkish, have locale-specific case mappings, so this method usually returns the same value as toLowerCase().

See Also

String.toLocaleUpperCase(), String.toLowerCase(), String.toUpperCase()

Name

String.toLocaleUpperCase() — convert a string to uppercase

Synopsis

string.toLocaleUpperCase()

Returns

A copy of string, converted to uppercase letters in a locale-specific way. Only a few languages, such as Turkish, have locale-specific case mappings, so this method usually returns the same value as toUpperCase().

See Also

String.toLocaleLowerCase(), String.toLowerCase(), String.toUpperCase()

Name

String.toLowerCase() — convert a string to lowercase

Synopsis

string.toLowerCase()

Returns

A copy of string, with each uppercase letter converted to its lowercase equivalent, if it has one.

Name

String.toString() — return the string

Inherits from

Overrides Object.toString()

Synopsis

string.toString()

