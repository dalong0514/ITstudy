shift() is similar to Array.pop(), except it operates on the beginning of an array rather than the end. shift() is often used in conjunction with unshift().

Example

var a = [1, [2,3], 4] a.shift(); // Returns 1; a = [[2,3], 4] a.shift(); // Returns [2,3]; a = [4]

See Also

Array.pop(), Array.unshift()

Name

Array.slice() — return a portion of an array

Synopsis

array.slice(start, end)

Arguments

start

The array index at which the slice is to begin. If negative, this argument specifies a position measured from the end of the array. That is, −1 indicates the last element, −2 indicates the next from the last element, and so on.

end

The array index immediately after the end of the slice. If not specified, the slice includes all array elements from the start to the end of the array. If this argument is negative, it specifies an array element measured from the end of the array.

Returns

A new array that contains the elements of array from the element specified by start, up to, but not including, the element specified by end.

Description

slice() returns a slice, or subarray, of array. The returned array contains the element specified by start and all subsequent elements up to, but not including, the element specified by end. If end is not specified, the returned array contains all elements from the start to the end of array.

Note that slice() does not modify the array. If you want to actually remove a slice of an array, use Array.splice().

Example

var a = [1,2,3,4,5]; a.slice(0,3); // Returns [1,2,3] a.slice(3); // Returns [4,5] a.slice(1,-1); // Returns [2,3,4] a.slice(-3,-2); // Returns [3]; buggy in IE 4: returns [1,2,3]

Bugs

start can’t be a negative number in Internet Explorer 4. This is fixed in later versions of IE.

See Also

Array.splice()

Name

Array.some() — test whether a predicate is true for any element

Availability

ECMAScript 5

Synopsis

array.some(predicate) array.some(predicate, o)

Arguments

predicate

A predicate function to test array elements

o

The optional this value for invocations of predicate.

Returns

true if predicate returns true (or a truthy value) for at least one element of array or false if the predicate returns false (or a falsy value) for all elements.

Description

The some() method tests whether a condition holds for at least one element of an array. It loops through the elements of array, in ascending order, and invokes the specified predicate function on each element in turn. If predicate returns true (or a value that converts to true), then some() stops looping and returns true immediately. If every invocation of predicate returns false (or a value that converts to false), then some() returns false. When invoked on an empty array, some() returns false.

This method is very much like every(). See Array.every() and Array.forEach() for further details.

Example

[1,2,3].some(function(x) { return x > 5; }) // => false: no elts are > 5 [1,2,3].some(function(x) { return x > 2; }) // => true: some elts are > 3 [].some(function(x) { return true; }); // => false: always false for []

See Also

Array.every(), Array.filter(), Array.forEach()

Name

Array.sort() — sort the elements of an array

Synopsis

array.sort() array.sort(orderfunc)

Arguments

orderfunc

An optional function used to specify the sorting order.

Returns

A reference to the array. Note that the array is sorted in place, and no copy is made.

Description

The sort() method sorts the elements of array in place: no copy of the array is made. If sort() is called with no arguments, the elements of the array are arranged in alphabetical order (more precisely, the order determined by the character encoding). To do this, elements are first converted to strings, if necessary, so that they can be compared.

If you want to sort the array elements in some other order, you must supply a comparison function that compares two values and returns a number indicating their relative order. The comparison function should take two arguments, a and b, and should return one of the following:

A value less than zero, if, according to your sort criteria, a is less than b and should appear before b in the sorted array.

Zero, if a and b are equivalent for the purposes of this sort.

A value greater than zero, if a is greater than b for the purposes of the sort.

Note that undefined elements of an array are always sorted to the end of the array. This is true even if you provide a custom ordering function: undefined values are never passed to the orderfunc you supply.

Example

The following code shows how you might write a comparison function to sort an array of numbers in numerical, rather than alphabetical order:

// An ordering function for a numerical sort function numberorder(a, b) { return a - b; } a = new Array(33, 4, 1111, 222); a.sort(); // Alphabetical sort: 1111, 222, 33, 4 a.sort(numberorder); // Numerical sort: 4, 33, 222, 1111

Name

Array.splice() — insert, remove, or replace array elements

Synopsis

array.splice(start, deleteCount, value, ...)

Arguments

start

The array element at which the insertion and/or deletion is to begin.

deleteCount

The number of elements, starting with and including start, to be deleted from array. Specify 0 to insert elements without deleting any.

value, ...

Zero or more values to be inserted into array, beginning at the index specified by start.

Returns

An array containing the elements, if any, deleted from array.

Description

splice() deletes zero or more array elements starting with and including the element start and replaces them with zero or more values specified in the argument list. Array elements that appear after the insertion or deletion are moved as necessary so that they remain contiguous with the rest of the array. Note that, unlike the similarly named slice(), splice() modifies array directly.

Example

The operation of splice() is most easily understood through an example:

var a = [1,2,3,4,5,6,7,8] a.splice(1,2); // Returns [2,3]; a is [1,4] a.splice(1,1); // Returns [4]; a is [1] a.splice(1,0,2,3); // Returns []; a is [1 2 3]

See Also

Array.slice()

Name

Array.toLocaleString() — convert an array to a localized string

Inherits from

Overrides Object.toLocaleString()

Synopsis

array.toLocaleString()

Returns

A localized string representation of array.

Throws

TypeError

If this method is invoked on an object that is not an Array.

Description

The toLocaleString() method of an array returns a localized string representation of an array. It does this by calling the toLocaleString() method of all of the array elements, then concatenating the resulting strings using a locale-specific separator character.

See Also

Array.toString(), Object.toLocaleString()

Name

Array.toString() — convert an array to a string

Inherits from

Overrides Object.toString()

Synopsis

array.toString()

Returns

A string representation of array.

Throws

TypeError

If this method is invoked on an object that is not an Array.

Description

The toString() method of an array converts an array to a string and returns the string. When an array is used in a string context, JavaScript automatically converts it to a string by calling this method. On some occasions, however, you may want to call toString() explicitly.

toString() converts an array to a string by first converting each array element to strings (by calling its toString() method). Once each element is converted to a string, toString() outputs them in a comma-separated list. This return value is the same string that would be returned by the join() method with no arguments.

See Also

Array.toLocaleString(), Object.toString()

Name

Array.unshift() — insert elements at the beginning of an array

Synopsis

array.unshift(value, ...)

Arguments

value, ...

One or more values that are inserted at the start of array.

Returns

The new length of the array.

Description

unshift() inserts its arguments at the beginning of array, shifting the existing elements to higher indexes to make room. The first argument to shift() becomes the new element 0 of the array; the second argument, if any, becomes the new element 1; and so on. Note that unshift() does not create a new array; it modifies array directly.

Example

unshift() is often used in conjunction with shift(). For example:

var a = []; // a:[] a.unshift(1); // a:[1] Returns: 1 a.unshift(22); // a:[22,1] Returns: 2 a.shift(); // a:[1] Returns: 22 a.unshift(33,[4,5]); // a:[33,[4,5],1] Returns: 3

See Also

Array.shift()

Name

Boolean — support for boolean values

Inherits from

Object → Boolean

Constructor

new Boolean(value) // Constructor function Boolean(value) // Conversion function

Arguments

value

The value to be held by the Boolean object or to be converted to a boolean value.

Returns

When invoked as a constructor with the new operator, Boolean() converts its argument to a boolean value and returns a Boolean object that contains that value. When invoked as a function, without the new operator, Boolean() simply converts its argument to a primitive boolean value and returns that value.

The values 0, NaN, null, the empty string "", and the undefined value are all converted to false. All other primitive values, except false (but including the string「false」), and all objects and arrays are converted to true.

Methods

toString()

Returns「true」or「false」, depending on the boolean value represented by the Boolean object.

valueOf()

Returns the primitive boolean value contained in the Boolean object.

Description

Boolean values are a fundamental datatype in JavaScript. The Boolean object is an object wrapper around the boolean value. This Boolean object type exists primarily to provide a toString() method to convert boolean values to strings. When the toString() method is invoked to convert a boolean value to a string (and it is often invoked implicitly by JavaScript), JavaScript internally converts the boolean value to a transient Boolean object, on which the method can be invoked.

See Also

Object

Name

Boolean.toString() — convert a boolean value to a string

Inherits from

Overrides Object.toString()

Synopsis

b.toString()

Returns

The string「true」or「false」, depending on the value of the primitive boolean value or Boolean object b.

Throws

TypeError

If this method is invoked on an object that is not a Boolean.

Name

Boolean.valueOf() — the boolean value of a Boolean object

Inherits from

Overrides Object.valueOf()

Synopsis

b.valueOf()

Returns

The primitive boolean value held by the Boolean object b.

Throws

TypeError

If this method is invoked on an object that is not a Boolean.

Name

Date — manipulate dates and times

Inherits from

Object → Date

Constructor

new Date() new Date(milliseconds) new Date(datestring) new Date(year, month, day, hours, minutes, seconds, ms)

With no arguments, the Date() constructor creates a Date object set to the current date and time. When one numeric argument is passed, it is taken as the internal numeric representation of the date in milliseconds, as returned by the getTime() method. When one string argument is passed, it is a string representation of a date, in the format accepted by the Date.parse() method. Otherwise, the constructor is passed between two and seven numeric arguments that specify the individual fields of the date and time. All but the first two arguments—the year and month fields—are optional. Note that these date and time fields are specified using local time, not Coordinated Universal Time (UTC) (which is similar to Greenwich Mean Time [GMT]). See the static Date.UTC() method for an alternative.

Date() may also be called as a function, without the new operator. When invoked in this way, Date() ignores any arguments passed to it and returns a string representation of the current date and time.

Arguments

milliseconds

The number of milliseconds between the desired date and midnight on January 1, 1970 (UTC). For example, passing the argument 5000 creates a date that represents five seconds past midnight on 1/1/70.

datestring

A single argument that specifies the date and, optionally, the time as a string. The string should be in a format accepted by Date.parse().

year

The year, in four-digit format. For example, specify 2001 for the year 2001. For compatibility with early implementations of JavaScript, if this argument is between 0 and 99, 1900 is added to it.

month

The month, specified as an integer from 0 (January) to 11 (December).

day

The day of the month, specified as an integer from 1 to 31. Note that this argument uses 1 as its lowest value, while other arguments use 0 as their lowest value. Optional.

hours

The hour, specified as an integer from 0 (midnight) to 23 (11 p.m.). Optional.

minutes

The minutes in the hour, specified as an integer from 0 to 59. Optional.

seconds

The seconds in the minute, specified as an integer from 0 to 59. Optional.

ms

The milliseconds in the second, specified as an integer from 0 to 999. Optional.

Methods

The Date object has no properties that can be read and written directly; instead, all access to date and time values is done through methods. Most methods of the Date object come in two forms: one that operates using local time and one that operates using universal (UTC or GMT) time. If a method has「UTC」in its name, it operates using universal time. These pairs of methods are listed together below. For example, the listing for get[UTC]Day() refers to both the methods getDay() and getUTCDay().

Date methods may be invoked only on Date objects, and they throw a TypeError exception if you attempt to invoke them on any other type of object:

get[UTC]Date()

Returns the day of the month of a Date object, in local or universal time.

get[UTC]Day()

Returns the day of the week of a Date object, in local or universal time.

get[UTC]FullYear()

Returns the year of the date in full four-digit form, in local or universal time.

get[UTC]Hours()

Returns the hours field of a Date object, in local or universal time.

get[UTC]Milliseconds()

Returns the milliseconds field of a Date object, in local or universal time.

get[UTC]Minutes()

Returns the minutes field of a Date object, in local or universal time.

get[UTC]Month()

Returns the month field of a Date object, in local or universal time.

get[UTC]Seconds()

Returns the seconds field of a Date object, in local or universal time.

getTime()

Returns the internal, millisecond representation of a Date object. Note that this value is independent of time zone, and therefore, there is not a separate getUTCTime() method.

getTimezoneOffset()

Returns the difference, in minutes, between the local and UTC representations of this date. Note that the value returned depends on whether daylight saving time is or would be in effect at the specified date.

getYear()

Returns the year field of a Date object. Deprecated in favor of getFullYear().

set[UTC]Date()

Sets the day of the month field of the date, using local or universal time.

set[UTC]FullYear()

Sets the year (and optionally month and day) field of the date, using local or universal time.

set[UTC]Hours()

Sets the hour field (and optionally the minutes, seconds, and milliseconds fields) of the date, using local or universal time.

set[UTC]Milliseconds()

Sets the milliseconds field of a date, using local or universal time.

set[UTC]Minutes()

Sets the minutes field (and optionally the seconds and milliseconds fields) of a date, using local or universal time.

set[UTC]Month()

Sets the month field (and optionally the day of the month) of a date, using local or universal time.

set[UTC]Seconds()

Sets the seconds field (and optionally the milliseconds field) of a date, using local or universal time.

setTime()

Sets the fields of a Date object using the millisecond format.

setYear()

Sets the year field of a Date object. Deprecated in favor of setFullYear().

toDateString()

Returns a string that represents the date portion of the date, expressed in the local time zone.

toGMTString()

Converts a Date to a string, using the GMT time zone. Deprecated in favor of toUTCString().

toISOString()

Converts a Date to a string, using the ISO-8601 standard combined date/time format and UTC.

toJSON()

JSON serializes a Date object, using toISOString().

toLocaleDateString()

Returns a string that represents the date portion of the date, expressed in the local time zone, using the local date formatting conventions.

toLocaleString()

Converts a Date to a string, using the local time zone and the local date formatting conventions.

toLocaleTimeString()

Returns a string that represents the time portion of the date, expressed in the local time zone, using the local time formatting conventions.

toString()

Converts a Date to a string using the local time zone.

toTimeString()

Returns a string that represents the time portion of the date, expressed in the local time zone.

toUTCString()

Converts a Date to a string, using universal time.

valueOf()

Converts a Date to its internal millisecond format.

Static Methods

In addition to the many instance methods listed previously, the Date object also defines three static methods. These methods are invoked through the Date() constructor itself, not through individual Date objects:

Date.now()

Returns the current time, as milliseconds since the epoch.

Date.parse()

Parses a string representation of a date and time and returns the internal millisecond representation of that date.

Date.UTC()

Returns the millisecond representation of the specified UTC date and time.

Description

The Date object is a datatype built into the JavaScript language. Date objects are created with the new Date() syntax shown earlier.

Once a Date object is created, a number of methods allow you to operate on it. Most methods simply allow you to get and set the year, month, day, hour, minute, second, and millisecond fields of the object, using either local time or UTC (universal, or GMT) time. The toString() method and its variants convert dates to human-readable strings. getTime() and setTime() convert to and from the internal representation of the Date object—the number of milliseconds since midnight (GMT) on January 1, 1970. In this standard millisecond format, a date and time are represented by a single integer, which makes date arithmetic particularly easy. The ECMAScript standard requires the Date object to be able to represent any date and time, to millisecond precision, within 100 million days before or after 1/1/1970. This is a range of plus or minus 273,785 years, so the JavaScript clock will not「roll over」until the year 275755.

Examples

Once you create a Date object, there are a variety of methods you can use to operate on it:

d = new Date(); // Get the current date and time document.write('Today is: " + d.toLocaleDateString() + '. '); // Display date document.write('The time is: ' + d.toLocaleTimeString()); // Display time var dayOfWeek = d.getDay(); // What weekday is it? var weekend = (dayOfWeek == 0) || (dayOfWeek == 6); // Is it a weekend?

Another common use of the Date object is to subtract the millisecond representations of the current time from some other time to determine the difference between the two times. The following client-side example shows two such uses:

<script language="JavaScript"> today = new Date(); // Make a note of today's date christmas = new Date(); // Get a date with the current year christmas.setMonth(11); // Set the month to December... christmas.setDate(25); // and the day to the 25th // If Christmas hasn't already passed, compute the number of // milliseconds between now and Christmas, convert this // to a number of days and print a message if (today.getTime() < christmas.getTime()) { difference = christmas.getTime() - today.getTime(); difference = Math.floor(difference / (1000 * 60 * 60 * 24)); document.write('Only ' + difference + ' days until Christmas!<p>'); } </script> // ... rest of HTML document here ... <script language="JavaScript"> // Here we use Date objects for timing // We divide by 1000 to convert milliseconds to seconds now = new Date(); document.write('<p>It took ' + (now.getTime()-today.getTime())/1000 + 'seconds to load this page.'); </script>

See Also

Date.parse(), Date.UTC()

Name

Date.getDate() — return the day-of-the-month field of a Date

Synopsis

date.getDate()

Returns

The day of the month of the specified Date object date, using local time. Return values are between 1 and 31.

Name

Date.getDay() — return the day-of-the-week field of a Date

Synopsis

date.getDay()

Returns

The day of the week of the specified Date object date, using local time. Return values are between 0 (Sunday) and 6 (Saturday).

Name

Date.getFullYear() — return the year field of a Date

Synopsis

date.getFullYear()

Returns

The year that results when date is expressed in local time. The return value is a full four-digit year, including the century, not a two-digit abbreviation.

Name

Date.getHours() — return the hours field of a Date

Synopsis

date.getHours()

Returns

The hours field, expressed in local time, of the specified Date object date. Return values are between 0 (midnight) and 23 (11 p.m.).

Name

Date.getMilliseconds() — return the milliseconds field of a Date

Synopsis

date.getMilliseconds()

Returns

The milliseconds field, expressed in local time, of date.

Name

Date.getMinutes() — return the minutes field of a Date

Synopsis

date.getMinutes()

Returns

The minutes field, expressed in local time, of the specified Date object date. Return values are between 0 and 59.

Name

Date.getMonth() — return the month field of a Date

Synopsis

date.getMonth()

Returns

The month field, expressed in local time, of the specified Date object date. Return values are between 0 ( January) and 11 (December).

Name

Date.getSeconds() — return the seconds field of a Date

Synopsis

date.getSeconds()

Returns

The seconds field, expressed in local time, of the specified Date object date. Return values are between 0 and 59.

Name

Date.getTime() — return a Date in milliseconds

Synopsis

date.getTime()

Returns

The millisecond representation of the specified Date object date—that is, the number of milliseconds between midnight (GMT) on 1/1/1970 and the date and time specified by date.

Description

getTime() converts a date and time to a single integer. This is useful when you want to compare two Date objects or to determine the time elapsed between two dates. Note that the millisecond representation of a date is independent of the time zone, so there is no getUTCTime() method in addition to this one. Don’t confuse this getTime() method with the getDay() and getDate() methods, which return the day of the week and the day of the month, respectively.

Date.parse() and Date.UTC() allow you to convert a date and time specification to a millisecond representation without going through the overhead of first creating a Date object.

See Also

Date, Date.parse(), Date.setTime(), Date.UTC()

Name

Date.getTimezoneOffset() — determine the offset from GMT

Synopsis

date.getTimezoneOffset()

Returns

The difference, in minutes, between GMT and local time.

Description

getTimezoneOffset() returns the number of minutes difference between the GMT or UTC time and the local time. In effect, this function tells you what time zone the JavaScript code is running in and whether or not daylight saving time is (or would be) in effect at the specified date.

The return value is measured in minutes, rather than hours, because some countries have time zones that are not at even one-hour intervals.

Name

Date.getUTCDate() — return the day-of-the-month field of a Date (universal time)

Synopsis

date.getUTCDate()

Returns

The day of the month (a value between 1 and 31) that results when date is expressed in universal time.

Name

Date.getUTCDay() — return the day-of-the-week field of a Date (universal time)

Synopsis

date.getUTCDay()

Returns

The day of the week that results when date is expressed in universal time. Return values are between 0 (Sunday) and 6 (Saturday).

Name

Date.getUTCFullYear() — return the year field of a Date (universal time)

Synopsis

date.getUTCFullYear()

Returns

The year that results when date is expressed in universal time. The return value is a full four-digit year, not a two-digit abbreviation.

Name

Date.getUTCHours() — return the hours field of a Date (universal time)

Synopsis

date.getUTCHours()

Returns

The hours field, expressed in universal time, of date. The return value is an integer between 0 (midnight) and 23 (11 p.m.).

Name

Date.getUTCMilliseconds() — return the milliseconds field of a Date (universal time)

Synopsis

date.getUTCMilliseconds()

Returns

The milliseconds field, expressed in universal time, of date.

Name

Date.getUTCMinutes() — return the minutes field of a Date (universal time)

Synopsis

date.getUTCMinutes()

Returns

The minutes field, expressed in universal time, of date. The return value is an integer between 0 and 59.

Name

Date.getUTCMonth() — return the month-of-the-year field of a Date (universal time)

Synopsis

date.getUTCMonth()

Returns

The month of the year that results when date is expressed in universal time. The return value is an integer between 0 ( January) and 11 (December). Note that the Date object represents the first day of the month as 1 but represents the first month of the year as 0.

Name

Date.getUTCSeconds() — return the seconds field of a Date (universal time)

Synopsis

date.getUTCSeconds()

