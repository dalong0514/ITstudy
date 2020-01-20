Returns

The seconds field, expressed in universal time, of date. The return value is an integer between 0 and 59.

Name

Date.getYear() — return the year field of a Date

Availability

deprecated

Synopsis

date.getYear()

Returns

The year field of the specified Date object date minus 1900.

Description

getYear() returns the year field of a specified Date object minus 1900. As of ECMAScript v3, it is not required in conforming JavaScript implementations; use getFullYear() instead.

Name

Date.now() — return the current time in milliseconds

Availability

ECMAScript 5

Synopsis

Date.now()

Returns

The current time, in milliseconds since midnight GMT on January 1, 1970.

Description

Prior to ECMAScript 5, you can implement this method like this:

Date.now = function() { return (new Date()).getTime(); }

See Also

Date, Date.getTime()

Name

Date.parse() — parse a date/time string

Synopsis

Date.parse(date)

Arguments

date

A string containing the date and time to be parsed.

Returns

The number of milliseconds between the specified date and time and midnight GMT on January 1, 1970.

Description

Date.parse()is a static method of Date. It parses the date specified by its single string argument returns it as the number of milliseconds since the epoch. This return value can be used directly, used to create a new Date object, or used to set the date in an existing Date object with Date.setTime().

ECMAScript 5 requires this method to be able to parse strings returned by the Date.toISOString() method. In ECMAScript 5 and before, this method is also required to be able to parse the implementation-dependent strings returned by the toUTCString() and toString() methods.

See Also

Date, Date.setTime(), Date.toISOString(), Date.toString()

Name

Date.setDate() — set the day-of-the-month field of a Date

Synopsis

date.setDate(day_of_month)

Arguments

day_of_month

An integer between 1 and 31 that is used as the new value (in local time) of the day-of-the-month field of date.

Returns

The millisecond representation of the adjusted date. Prior to ECMAScript standardization, this method returns nothing.

Name

Date.setFullYear() — set the year and, optionally, the month and date fields of a Date

Synopsis

date.setFullYear(year) date.setFullYear(year, month) date.setFullYear(year, month, day)

Arguments

year

The year, expressed in local time, to be set in date. This argument should be an integer that includes the century, such as 1999; it should not be an abbreviation, such as 99.

month

An optional integer between 0 and 11 that is used as the new value (in local time) of the month field of date.

day

An optional integer between 1 and 31 that is used as the new value (in local time) of the day-of-the-month field of date.

Returns

The internal millisecond representation of the adjusted date.

Name

Date.setHours() — set the hours, minutes, seconds, and milliseconds fields of a Date

Synopsis

date.setHours(hours) date.setHours(hours, minutes) date.setHours(hours, minutes, seconds) date.setHours(hours, minutes, seconds, millis)

Arguments

hours

An integer between 0 (midnight) and 23 (11 p.m.) local time that is set as the new hours value of date.

minutes

An optional integer, between 0 and 59, that is used as the new value (in local time) of the minutes field of date. This argument is not supported prior to ECMAScript standardization.

seconds

An optional integer, between 0 and 59, that is used as the new value (in local time) of the seconds field of date. This argument is not supported prior to ECMAScript standardization.

millis

An optional integer, between 0 and 999, that is used as the new value (in local time) of the milliseconds field of date. This argument is not supported prior to ECMAScript standardization.

Returns

The millisecond representation of the adjusted date. Prior to ECMAScript standardization, this method returns nothing.

Name

Date.setMilliseconds() — set the milliseconds field of a Date

Synopsis

date.setMilliseconds(millis)

Arguments

millis

The milliseconds field, expressed in local time, to be set in date. This argument should be an integer between 0 and 999.

Returns

The millisecond representation of the adjusted date.

Name

Date.setMinutes() — set the minutes, seconds, and milliseconds fields of a Date

Synopsis

date.setMinutes(minutes) date.setMinutes(minutes, seconds) date.setMinutes(minutes, seconds, millis)

Arguments

minutes

An integer between 0 and 59 that is set as the minutes value (in local time) of the Date object date.

seconds

An optional integer, between 0 and 59, that is used as the new value (in local time) of the seconds field of date. This argument is not supported prior to ECMAScript standardization.

millis

An optional integer, between 0 and 999, that is used as the new value (in local time) of the milliseconds field of date. This argument is not supported prior to ECMAScript standardization.

Returns

The millisecond representation of the adjusted date. Prior to ECMAScript standardization, this method returns nothing.

Name

Date.setMonth() — set the month and day fields of a Date

Synopsis

date.setMonth(month) date.setMonth(month, day)

Arguments

month

An integer between 0 (January) and 11 (December) that is set as the month value (in local time) for the Date object date. Note that months are numbered beginning with 0, while days within the month are numbered beginning with 1.

day

An optional integer between 1 and 31 that is used as the new value (in local time) of the day-of-the-month field of date. This argument is not supported prior to ECMAScript standardization.

Returns

The millisecond representation of the adjusted date. Prior to ECMAScript standardization, this method returns nothing.

Name

Date.setSeconds() — set the seconds and milliseconds fields of a Date

Synopsis

date.setSeconds(seconds) date.setSeconds(seconds, millis)

Arguments

seconds

An integer between 0 and 59 that is set as the seconds value for the Date object date.

millis

An optional integer, between 0 and 999, that is used as the new value (in local time) of the milliseconds field of date. This argument is not supported prior to ECMAScript standardization.

Returns

The millisecond representation of the adjusted date. Prior to ECMAScript standardization, this method returns nothing.

Name

Date.setTime() — set a Date in milliseconds

Synopsis

date.setTime(milliseconds)

Arguments

milliseconds

The number of milliseconds between the desired date and time and midnight GMT on January 1, 1970. A millisecond value of this type may also be passed to the Date() constructor and may be obtained by calling the Date.UTC() and Date.parse() methods. Representing a date in this millisecond format makes it independent of time zone.

Returns

The milliseconds argument. Prior to ECMAScript standardization, this method returns nothing.

Name

Date.setUTCDate() — set the day-of-the-month field of a Date (universal time)

Synopsis

date.setUTCDate(day_of_month)

Arguments

day_of_month

The day of the month, expressed in universal time, to be set in date. This argument should be an integer between 1 and 31.

Returns

The internal millisecond representation of the adjusted date.

Name

Date.setUTCFullYear() — set the year, month, and day fields of a Date (universal time)

Synopsis

date.setUTCFullYear(year) date.setSeconds(seconds, millis) date.setUTCFullYear(year, month, day)

Arguments

year

The year, expressed in universal time, to be set in date. This argument should be an integer that includes the century, such as 1999, not an abbreviation, such as 99.

month

An optional integer between 0 and 11 that is used as the new value (in universal time) of the month field of date. Note that months are numbered beginning with 0, while days within the month are numbered beginning with 1.

day

An optional integer between 1 and 31 that is used as the new value (in universal time) of the day-of-the-month field of date.

Returns

The internal millisecond representation of the adjusted date.

Name

Date.setUTCHours() — set the hours, minutes, seconds, and milliseconds fields of a Date (universal time)

Synopsis

date.setUTCHours(hours) date.setUTCHours(hours, minutes) date.setUTCHours(hours, minutes, seconds) date.setUTCHours(hours, minutes, seconds, millis)

Arguments

hours

The hours field, expressed in universal time, to be set in date. This argument should be an integer between 0 (midnight) and 23 (11 p.m.).

minutes

An optional integer, between 0 and 59, that is used as the new value (in universal time) of the minutes field of date.

seconds

An optional integer, between 0 and 59, that is used as the new value (in universal time) of the seconds field of date.

millis

An optional integer, between 0 and 999, that is used as the new value (in universal time) of the milliseconds field of date.

Returns

The millisecond representation of the adjusted date.

Name

Date.setUTCMilliseconds() — set the milliseconds field of a Date (universal time)

Synopsis

date.setUTCMilliseconds(millis)

Arguments

millis

The milliseconds field, expressed in universal time, to be set in date. This argument should be an integer between 0 and 999.

Returns

The millisecond representation of the adjusted date.

Name

Date.setUTCMinutes() — set the minutes, seconds, and milliseconds fields of a Date (universal time)

Synopsis

date.setUTCMinutes(minutes) date.setUTCMinutes(minutes, seconds) date.setUTCMinutes(minutes, seconds, millis)

Arguments

minutes

The minutes field, expressed in universal time, to be set in date. This argument should be an integer between 0 and 59.

seconds

An optional integer between 0 and 59 that is used as the new value (in universal time) of the seconds field of date.

millis

An optional integer between 0 and 999 that is used as the new value (in universal time) of the milliseconds field of date.

Returns

The millisecond representation of the adjusted date.

Name

Date.setUTCMonth() — set the month and day fields of a Date (universal time)

Synopsis

date.setUTCMonth(month) date.setUTCMonth(month, day)

Arguments

month

The month, expressed in universal time, to be set in date. This argument should be an integer between 0 (January) and 11 (December). Note that months are numbered beginning with 0, while days within the month are numbered beginning with 1.

day

An optional integer between 1 and 31 that is used as the new value (in universal time) of the day-of-the-month field of date.

Returns

The millisecond representation of the adjusted date.

Name

Date.setUTCSeconds() — set the seconds and milliseconds fields of a Date (universal time)

Synopsis

date.setUTCSeconds(seconds) date.setUTCSeconds(seconds, millis)

Arguments

seconds

The seconds field, expressed in universal time, to be set in date. This argument should be an integer between 0 and 59.

millis

An optional integer between 0 and 999 that is used as the new value (in universal time) of the milliseconds field of date.

Returns

The millisecond representation of the adjusted date.

Name

Date.setYear() — set the year field of a Date

Availability

deprecated

Synopsis

date.setYear(year)

Arguments

year

An integer that is set as the year value (in local time) for the Date object date. If this value is between 0 and 99, inclusive, 1900 is added to it and it is treated as a year between 1900 and 1999.

Returns

The millisecond representation of the adjusted date. Prior to ECMAScript standardization, this method returns nothing.

Description

setYear() sets the year field of a specified Date object, with special behavior for years between 1900 and 1999.

As of ECMAScript v3, this function is no longer required in conforming JavaScript implementations; use setFullYear() instead.

Name

Date.toDateString() — return the date portion of a Date as a string

Synopsis

date.toDateString()

Returns

An implementation-dependent, human-readable string representation of the date portion of date, expressed in the local time zone.

See Also

Date.toString()

Date.toTimeString()

Name

Date.toGMTString() — convert a Date to a universal time string

Availability

deprecated

Synopsis

date.toGMTString()

Returns

A string representation of the date and time specified by the Date object date. The date is converted from the local time zone to the GMT time zone before being converted to a string.

Description

toGMTString() is deprecated in favor of the identical method Date.toUTCString().

As of ECMAScript v3, conforming implementations of JavaScript are no longer required to provide this method; use toUTCString() instead.

See Also

Date.toUTCString()

Name

Date.toISOString() — convert a Date to an ISO8601-formatted string

Availability

ECMAScript 5

Synopsis

date.toISOString()

Returns

A string representation of date, formatted according to the ISO-8601 standard and expressed as a full-precision combined date and time in UTC with a timezone of「Z」. The returned string has this format:

yyyy-mm-ddThh:mm:ss.sssZ

See Also

Date.parse(), Date.toString()

Name

Date.toJSON — JSON-serialize a Date object

Availability

ECMAScript 5

Synopsis

date.toJSON(key)

Arguments

key

JSON.stringify() passes this argument, but the toJSON() method ignores it.

Returns

A string representation of the date, obtained by calling its toISOString() method.

Description

This method is used by JSON.stringify() to convert a Date object to a string. It is not intended for general use.

See Also

Date.toISOString(), JSON.stringify()

Name

Date.toLocaleDateString() — return the date portion of a Date as a locally formatted string

Synopsis

date.toLocaleDateString()

Returns

An implementation-dependent, human-readable string representation of the date portion of date, expressed in the local time zone and formatted according to local conventions.

See Also

Date.toDateString(), Date.toLocaleString(), Date.toLocaleTimeString(), Date.toString(), Date.toTimeString()

Name

Date.toLocaleString() — convert a Date to a locally formatted string

Synopsis

date.toLocaleString()

Returns

A string representation of the date and time specified by date. The date and time are represented in the local time zone and formatted using locally appropriate conventions.

Usage

toLocaleString() converts a date to a string, using the local time zone. This method also uses local conventions for date and time formatting, so the format may vary from platform to platform and from country to country. toLocaleString() returns a string formatted in what is likely the user’s preferred date and time format.

See Also

Date.toISOString(), Date.toLocaleDateString(), Date.toLocaleTimeString(), Date.toString(), Date.toUTCString()

Name

Date.toLocaleTimeString() — return the time portion of a Date as a locally formatted string

Synopsis

date.toLocaleTimeString()

Returns

An implementation-dependent, human-readable string representation of the time portion of date, expressed in the local time zone and formatted according to local conventions.

See Also

Date.toDateString(), Date.toLocaleDateString(), Date.toLocaleString(), Date.toString(), Date.toTimeString()

Name

Date.toString() — convert a Date to a string

Inherits from

Overrides Object.toString()

Synopsis

date.toString()

Returns

A human-readable string representation of date, expressed in the local time zone.

Description

toString() returns a human-readable, implementation-dependent string representation of date. Unlike toUTCString(), toString() expresses the date in the local time zone. Unlike toLocaleString(), toString() may not represent the date and time using locale-specific formatting.

See Also

Date.parse()

Date.toDateString()

Date.toISOString()

Date.toLocaleString()

Date.toTimeString()

Date.toUTCString()

Name

Date.toTimeString() — return the time portion of a Date as a string

Synopsis

date.toTimeString()

Returns

A implementation-dependent, human-readable string representation of the time portion of date, expressed in the local time zone.

See Also

Date.toString(), Date.toDateString(), Date.toLocaleTimeString()

Name

Date.toUTCString() — convert a Date to a string (universal time)

Synopsis

date.toUTCString()

Returns

A human-readable string representation, expressed in universal time, of date.

Description

toUTCString() returns an implementation-dependent string that represents date in universal time.

See Also

Date.toISOString(), Date.toLocaleString(), Date.toString()

Name

Date.UTC() — convert a Date specification to milliseconds

Synopsis

Date.UTC(year, month, day, hours, minutes, seconds, ms)

Arguments

year

The year in four-digit format. If this argument is between 0 and 99, inclusive, 1900 is added to it and it is treated as a year between 1900 and 1999.

month

The month, specified as an integer from 0 (January) to 11 (December).

day

The day of the month, specified as an integer from 1 to 31. Note that this argument uses 1 as its lowest value, while other arguments use 0 as their lowest value. This argument is optional.

hours

The hour, specified as an integer from 0 (midnight) to 23 (11 p.m.). This argument is optional.

minutes

The minutes in the hour, specified as an integer from 0 to 59. This argument is optional.

seconds

The seconds in the minute, specified as an integer from 0 to 59. This argument is optional.

ms

The number of milliseconds, specified as an integer from 0 to 999. This argument is optional and is ignored prior to ECMAScript standardization.

Returns

The millisecond representation of the specified universal time. That is, this method returns the number of milliseconds between midnight GMT on January 1, 1970 and the specified time.

Description

Date.UTC() is a static method; it is invoked through the Date() constructor, not through an individual Date object.

The arguments to Date.UTC() specify a date and time and are understood to be in UTC; they are in the GMT time zone. The specified UTC time is converted to the millisecond format, which can be used by the Date() constructor method and by the Date.setTime() method.

The Date() constructor method can accept date and time arguments identical to those that Date.UTC() accepts. The difference is that the Date() constructor assumes local time, while Date.UTC() assumes universal time (GMT). To create a Date object using a UTC time specification, you can use code like this:

d = new Date(Date.UTC(1996, 4, 8, 16, 30));

See Also

Date, Date.parse(), Date.setTime()

Name

Date.valueOf() — convert a Date to millisecond representation

Inherits from

Overrides Object.valueOf()

Synopsis

date.valueOf()

Returns

The millisecond representation of date. The value returned is the same as that returned by Date.getTime().

Name

decodeURI() — unescape characters in a URI

Synopsis

decodeURI(uri)

Arguments

uri

A string that contains an encoded URI or other text to be decoded.

Returns

A copy of uri, with any hexadecimal escape sequences replaced with the characters they represent.

Throws

URIError

Indicates that one or more of the escape sequences in uri is malformed and cannot be correctly decoded.

Description

decodeURI() is a global function that returns a decoded copy of its uri argument. It reverses the encoding performed by encodeURI(); see that function’s reference page for details.

See Also

decodeURIComponent(), encodeURI(), encodeURIComponent(), escape(), unescape()

Name

decodeURIComponent() — unescape characters in a URI component

Synopsis

decodeURI(s)

Arguments

s

A string that contains an encoded URI component or other text to be decoded.

Returns

A copy of s, with any hexadecimal escape sequences replaced with the characters they represent.

Throws

URIError

Indicates that one or more of the escape sequences in s is malformed and cannot be correctly decoded.

Description

