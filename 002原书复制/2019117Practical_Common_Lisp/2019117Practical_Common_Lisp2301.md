2There has since been some disagreement over whether the technique Graham described was actually "Bayesian." However, the name has stuck and is well on its way to becoming a synonym for "statistical" when talking about spam filters.

3It would, however, be poor form to distribute a version of this application using a package starting with com.gigamonkeys since you don't control that domain.

4A version of CL-PPCRE is included with the book's source code available from the book's Web site. Or you can download it from Weitz's site at http://www.weitz.de/cl-ppcre/.

5The main reason to use PRINT-UNREADABLE-OBJECT is that it takes care of signaling the appropriate error if someone tries to print your object readably, such as with the ~S FORMAT directive.

6PRINT-UNREADABLE-OBJECT also signals an error if it's used when the printer control variable *PRINT-READABLY* is true. Thus, a PRINT-OBJECT method consisting solely of a PRINT-UNREADABLE-OBJECT form will correctly implement the PRINT-OBJECT contract with regard to *PRINT-READABLY*.

7If you decide later that you do need to have different versions of increment-feature for different classes, you can redefine increment-count as a generic function and this function as a method specialized on word-feature.

8Technically, the key in each clause of a CASE or ECASE is interpreted as a list designator, an object that designates a list of objects. A single nonlist object, treated as a list designator, designates a list containing just that one object, while a list designates itself. Thus, each clause can have multiple keys; CASE and ECASE will select the clause whose list of keys contains the value of the key form. For example, if you wanted to make good a synonym for ham and bad a synonym for spam, you could write increment-count like this:

(defun increment-count (feature type) (ecase type ((ham good) (incf (ham-count feature))) ((spam bad) (incf (spam-count feature)))))

9Speaking of mathematical nuances, hard-core statisticians may be offended by the sometimes loose use of the word probability in this chapter. However, since even the pros, who are divided between the Bayesians and the frequentists, can't agree on what a probability is, I'm not going to worry about it. This is a book about programming, not statistics.

10Robinson's articles that directly informed this chapter are "A Statistical Approach to the Spam Problem" (published in the Linux Journal and available at http://www.linuxjournal.com/ article.php?sid=6467 and in a shorter form on Robinson's blog at http://radio.weblogs.com/ 0101454/stories/2002/09/16/spamDetection.html) and "Why Chi? Motivations for the Use of Fisher's Inverse Chi-Square Procedure in Spam Classification" (available at http://garyrob.blogs.com/ whychi93.pdf). Another article that may be useful is "Handling Redundancy in Email Token Probabilities" (available at http://garyrob.blogs.com//handlingtokenredundancy94.pdf). The archived mailing lists of the SpamBayes project (http://spambayes.sourceforge.net/) also contain a lot of useful information about different algorithms and approaches to testing spam filters.

11Techniques that combine nonindependent probabilities as though they were, in fact, independent, are called naive Bayesian. Graham's original proposal was essentially a naive Bayesian classifier with some "empirically derived" constant factors thrown in.

12Several spam corpora including the SpamAssassin corpus are linked to from http://nexp.cs.pdx.edu/~psam/cgi-bin/view/PSAM/CorpusSets.

13If you wanted to conduct a test without disturbing the existing database, you could bind *feature-database*, *total-spams*, and *total-hams* with a LET, but then you'd have no way of looking at the database after the fact--unless you returned the values you used within the function.

14This algorithm is named for the same Fisher who invented the method used for combining probabilities and for Frank Yates, his coauthor of the book Statistical Tables for Biological, Agricultural and Medical Research (Oliver & Boyd, 1938) in which, according to Knuth, they provided the first published description of the algorithm.

Copyright © 2003-2005, Peter Seibel

24. Practical: Parsing Binary Files

In this chapter I'll show you how to build a library that you can use to write code for reading and writing binary files. You'll use this library in Chapter 25 to write a parser for ID3 tags, the mechanism used to store metadata such as artist and album names in MP3 files. This library is also an example of how to use macros to extend the language with new constructs, turning it into a special-purpose language for solving a particular problem, in this case reading and writing binary data. Because you'll develop the library a bit at a time, including several partial versions, it may seem you're writing a lot of code. But when all is said and done, the whole library is fewer than 150 lines of code, and the longest macro is only 20 lines long.

Binary Files

At a sufficiently low level of abstraction, all files are "binary" in the sense that they just contain a bunch of numbers encoded in binary form. However, it's customary to distinguish between text files, where all the numbers can be interpreted as characters representing human-readable text, and binary files, which contain data that, if interpreted as characters, yields nonprintable characters.1

Binary file formats are usually designed to be both compact and efficient to parse--that's their main advantage over text-based formats. To meet both those criteria, they're usually composed of on-disk structures that are easily mapped to data structures that a program might use to represent the same data in memory.2

The library will give you an easy way to define the mapping between the on-disk structures defined by a binary file format and in-memory Lisp objects. Using the library, it should be easy to write a program that can read a binary file, translating it into Lisp objects that you can manipulate, and then write back out to another properly formatted binary file.

Binary Format Basics

The starting point for reading and writing binary files is to open the file for reading or writing individual bytes. As I discussed in Chapter 14, both OPEN and WITH-OPEN-FILE accept a keyword argument, :element-type, that controls the basic unit of transfer for the stream. When you're dealing with binary files, you'll specify (unsigned-byte 8). An input stream opened with such an :element-type will return an integer between 0 and 255 each time it's passed to READ-BYTE. Conversely, you can write bytes to an (unsigned-byte 8) output stream by passing numbers between 0 and 255 to WRITE-BYTE.

Above the level of individual bytes, most binary formats use a smallish number of primitive data types--numbers encoded in various ways, textual strings, bit fields, and so on--which are then composed into more complex structures. So your first task is to define a framework for writing code to read and write the primitive data types used by a given binary format.

To take a simple example, suppose you're dealing with a binary format that uses an unsigned 16-bit integer as a primitive data type. To read such an integer, you need to read the two bytes and then combine them into a single number by multiplying one byte by 256, a.k.a. 2^8, and adding it to the other byte. For instance, assuming the binary format specifies that such 16-bit quantities are stored in big-endian3 form, with the most significant byte first, you can read such a number with this function:

(defun read-u2 (in) (+ (* (read-byte in) 256) (read-byte in)))

However, Common Lisp provides a more convenient way to perform this kind of bit twiddling. The function LDB, whose name stands for load byte, can be used to extract and set (with SETF) any number of contiguous bits from an integer.4 The number of bits and their position within the integer is specified with a byte specifier created with the BYTE function. BYTE takes two arguments, the number of bits to extract (or set) and the position of the rightmost bit where the least significant bit is at position zero. LDB takes a byte specifier and the integer from which to extract the bits and returns the positive integer represented by the extracted bits. Thus, you can extract the least significant octet of an integer like this:

(ldb (byte 8 0) #xabcd) ==> 205 ; 205 is #xcd

To get the next octet, you'd use a byte specifier of (byte 8 8) like this:

(ldb (byte 8 8) #xabcd) ==> 171 ; 171 is #xab

You can use LDB with SETF to set the specified bits of an integer stored in a SETFable place.

CL-USER> (defvar *num* 0) *NUM* CL-USER> (setf (ldb (byte 8 0) *num*) 128) 128 CL-USER> *num* 128 CL-USER> (setf (ldb (byte 8 8) *num*) 255) 255 CL-USER> *num* 65408

Thus, you can also write read-u2 like this:5

(defun read-u2 (in) (let ((u2 0)) (setf (ldb (byte 8 8) u2) (read-byte in)) (setf (ldb (byte 8 0) u2) (read-byte in)) u2))

To write a number out as a 16-bit integer, you need to extract the individual 8-bit bytes and write them one at a time. To extract the individual bytes, you just need to use LDB with the same byte specifiers.

(defun write-u2 (out value) (write-byte (ldb (byte 8 8) value) out) (write-byte (ldb (byte 8 0) value) out))

Of course, you can also encode integers in many other ways--with different numbers of bytes, with different endianness, and in signed and unsigned format.

Strings in Binary Files

Textual strings are another kind of primitive data type you'll find in many binary formats. When you read files one byte at a time, you can't read and write strings directly--you need to decode and encode them one byte at a time, just as you do with binary-encoded numbers. And just as you can encode an integer in several ways, you can encode a string in many ways. To start with, the binary format must specify how individual characters are encoded.

To translate bytes to characters, you need to know both what character code and what character encoding you're using. A character code defines a mapping from positive integers to characters. Each number in the mapping is called a code point. For instance, ASCII is a character code that maps the numbers from 0-127 to particular characters used in the Latin alphabet. A character encoding, on the other hand, defines how the code points are represented as a sequence of bytes in a byte-oriented medium such as a file. For codes that use eight or fewer bits, such as ASCII and ISO-8859-1, the encoding is trivial--each numeric value is encoded as a single byte.

Nearly as straightforward are pure double-byte encodings, such as UCS-2, which map between 16-bit values and characters. The only reason double-byte encodings can be more complex than single-byte encodings is that you may also need to know whether the 16-bit values are supposed to be encoded in big-endian or little-endian format.

Variable-width encodings use different numbers of octets for different numeric values, making them more complex but allowing them to be more compact in many cases. For instance, UTF-8, an encoding designed for use with the Unicode character code, uses a single octet to encode the values 0-127 while using up to four octets to encode values up to 1,114,111.6

Since the code points from 0-127 map to the same characters in Unicode as they do in ASCII, a UTF-8 encoding of text consisting only of characters also in ASCII is the same as the ASCII encoding. On the other hand, texts consisting mostly of characters requiring four bytes in UTF-8 could be more compactly encoded in a straight double-byte encoding.

Common Lisp provides two functions for translating between numeric character codes and character objects: CODE-CHAR, which takes an numeric code and returns as a character, and CHAR-CODE, which takes a character and returns its numeric code. The language standard doesn't specify what character encoding an implementation must use, so there's no guarantee you can represent every character that can possibly be encoded in a given file format as a Lisp character. However, almost all contemporary Common Lisp implementations use ASCII, ISO-8859-1, or Unicode as their native character code. Because Unicode is a superset ofISO-8859-1, which is in turn a superset of ASCII, if you're using a Unicode Lisp, CODE-CHAR and CHAR-CODE can be used directly for translating any of those three character codes.7

In addition to specifying a character encoding, a string encoding must also specify how to encode the length of the string. Three techniques are typically used in binary file formats.

The simplest is to not encode it but to let it be implicit in the position of the string in some larger structure: a particular element of a file may always be a string of a certain length, or a string may be the last element of a variable-length data structure whose overall size determines how many bytes are left to read as string data. Both these techniques are used in ID3 tags, as you'll see in the next chapter.

The other two techniques can be used to encode variable-length strings without relying on context. One is to encode the length of the string followed by the character data--the parser reads an integer value (in some specified integer format) and then reads that number of characters. Another is to write the character data followed by a delimiter that can't appear in the string such as a null character.

The different representations have different advantages and disadvantages, but when you're dealing with already specified binary formats, you won't have any control over which encoding is used. However, none of the encodings is particularly more difficult to read and write than any other. Here, as an example, is a function that reads a null-terminated ASCII string, assuming your Lisp implementation uses ASCII or one of its supersets such as ISO-8859-1 or full Unicode as its native character encoding:

(defconstant +null+ (code-char 0)) (defun read-null-terminated-ascii (in) (with-output-to-string (s) (loop for char = (code-char (read-byte in)) until (char= char +null+) do (write-char char s))))

The WITH-OUTPUT-TO-STRING macro, which I mentioned in Chapter 14, is an easy way to build up a string when you don't know how long it'll be. It creates a STRING-STREAM and binds it to the variable name specified, s in this case. All characters written to the stream are collected into a string, which is then returned as the value of the WITH-OUTPUT-TO-STRING form.

To write a string back out, you just need to translate the characters back to numeric values that can be written with WRITE-BYTE and then write the null terminator after the string contents.

(defun write-null-terminated-ascii (string out) (loop for char across string do (write-byte (char-code char) out)) (write-byte (char-code +null+) out))

As these examples show, the main intellectual challenge--such as it is--of reading and writing primitive elements of binary files is understanding how exactly to interpret the bytes that appear in a file and to map them to Lisp data types. If a binary file format is well specified, this should be a straightforward proposition. Actually writing functions to read and write a particular encoding is, as they say, a simple matter of programming.

Now you can turn to the issue of reading and writing more complex on-disk structures and how to map them to Lisp objects.

Composite Structures

Since binary formats are usually used to represent data in a way that makes it easy to map to in-memory data structures, it should come as no surprise that composite on-disk structures are usually defined in ways similar to the way programming languages define in-memory structures. Usually a composite on-disk structure will consist of a number of named parts, each of which is itself either a primitive type such as a number or a string, another composite structure, or possibly a collection of such values.

For instance, an ID3 tag defined in the 2.2 version of the specification consists of a header made up of a three-character ISO-8859-1 string, which is always "ID3"; two one-byte unsigned integers that specify the major version and revision of the specification; eight bits worth of boolean flags; and four bytes that encode the size of the tag in an encoding particular to the ID3 specification. Following the header is a list of frames, each of which has its own internal structure. After the frames are as many null bytes as are necessary to pad the tag out to the size specified in the header.

If you look at the world through the lens of object orientation, composite structures look a lot like classes. For instance, you could write a class to represent an ID3 tag.

(defclass id3-tag () ((identifier :initarg :identifier :accessor identifier) (major-version :initarg :major-version :accessor major-version) (revision :initarg :revision :accessor revision) (flags :initarg :flags :accessor flags) (size :initarg :size :accessor size) (frames :initarg :frames :accessor frames)))

An instance of this class would make a perfect repository to hold the data needed to represent an ID3 tag. You could then write functions to read and write instances of this class. For example, assuming the existence of certain other functions for reading the appropriate primitive data types, a read-id3-tag function might look like this:

(defun read-id3-tag (in) (let ((tag (make-instance 'id3-tag))) (with-slots (identifier major-version revision flags size frames) tag (setf identifier (read-iso-8859-1-string in :length 3)) (setf major-version (read-u1 in)) (setf revision (read-u1 in)) (setf flags (read-u1 in)) (setf size (read-id3-encoded-size in)) (setf frames (read-id3-frames in :tag-size size))) tag))

The write-id3-tag function would be structured similarly--you'd use the appropriate write-* functions to write out the values stored in the slots of the id3-tag object.

It's not hard to see how you could write the appropriate classes to represent all the composite data structures in a specification along with read-foo and write-foo functions for each class and for necessary primitive types. But it's also easy to tell that all the reading and writing functions are going to be pretty similar, differing only in the specifics of what types they read and the names of the slots they store them in. It's particularly irksome when you consider that in the ID3 specification it takes about four lines of text to specify the structure of an ID3 tag, while you've already written eighteen lines of code and haven't even written write-id3-tag yet.

What you'd really like is a way to describe the structure of something like an ID3 tag in a form that's as compressed as the specification's pseudocode yet that can also be expanded into code that defines the id3-tag class and the functions that translate between bytes on disk and instances of the class. Sounds like a job for a macro.

Designing the Macros

Since you already have a rough idea what code your macros will need to generate, the next step, according to the process for writing a macro I outlined in Chapter 8, is to switch perspectives and think about what a call to the macro should look like. Since the goal is to be able to write something as compressed as the pseudocode in the ID3 specification, you can start there. The header of an ID3 tag is specified like this:

ID3/file identifier "ID3" ID3 version $02 00 ID3 flags %xx000000 ID3 size 4 * %0xxxxxxx

In the notation of the specification, this means the "file identifier" slot of an ID3 tag is the string "ID3" in ISO-8859-1 encoding. The version consists of two bytes, the first of which--for this version of the specification--has the value 2 and the second of which--again for this version of the specification--is 0. The flags slot is eight bits, of which all but the first two are 0, and the size consists of four bytes, each of which has a 0 in the most significant bit.

Some information isn't captured by this pseudocode. For instance, exactly how the four bytes that encode the size are to be interpreted is described in a few lines of prose. Likewise, the spec describes in prose how the frame and subsequent padding is stored after this header. But most of what you need to know to be able to write code to read and write an ID3 tag is specified by this pseudocode. Thus, you ought to be able to write an s-expression version of this pseudocode and have it expanded into the class and function definitions you'd otherwise have to write by hand--something, perhaps, like this:

(define-binary-class id3-tag ((file-identifier (iso-8859-1-string :length 3)) (major-version u1) (revision u1) (flags u1) (size id3-tag-size) (frames (id3-frames :tag-size size))))

The basic idea is that this form defines a class id3-tag similar to the way you could with DEFCLASS, but instead of specifying things such as :initarg and :accessors, each slot specification consists of the name of the slot--file-identifier, major-version, and so on--and information about how that slot is represented on disk. Since this is just a bit of fantasizing, you don't have to worry about exactly how the macro define-binary-class will know what to do with expressions such as (iso-8859-1-string :length 3), u1, id3-tag-size, and (id3-frames :tag-size size); as long as each expression contains the information necessary to know how to read and write a particular data encoding, you should be okay.

Making the Dream a Reality

Okay, enough fantasizing about good-looking code; now you need to get to work writing define-binary-class--writing the code that will turn that concise expression of what an ID3 tag looks like into code that can represent one in memory, read one off disk, and write it back out.

To start with, you should define a package for this library. Here's the package file that comes with the version you can download from the book's Web site:

(in-package :cl-user) (defpackage :com.gigamonkeys.binary-data (:use :common-lisp :com.gigamonkeys.macro-utilities) (:export :define-binary-class :define-tagged-binary-class :define-binary-type :read-value :write-value :*in-progress-objects* :parent-of-type :current-binary-object :+null+))

The COM.GIGAMONKEYS.MACRO-UTILITIES package contains the with-gensyms and once-only macros from Chapter 8.

Since you already have a handwritten version of the code you want to generate, it shouldn't be too hard to write such a macro. Just take it in small pieces, starting with a version of define-binary-class that generates just the DEFCLASS form.

If you look back at the define-binary-class form, you'll see that it takes two arguments, the name id3-tag and a list of slot specifiers, each of which is itself a two-item list. From those pieces you need to build the appropriate DEFCLASS form. Clearly, the biggest difference between the define-binary-class form and a proper DEFCLASS form is in the slot specifiers. A single slot specifier from define-binary-class looks something like this:

(major-version u1)

But that's not a legal slot specifier for a DEFCLASS. Instead, you need something like this:

(major-version :initarg :major-version :accessor major-version)

Easy enough. First define a simple function to translate a symbol to the corresponding keyword symbol.

(defun as-keyword (sym) (intern (string sym) :keyword))

Now define a function that takes a define-binary-class slot specifier and returns a DEFCLASS slot specifier.

(defun slot->defclass-slot (spec) (let ((name (first spec))) `(,name :initarg ,(as-keyword name) :accessor ,name)))

You can test this function at the REPL after switching to your new package with a call to IN-PACKAGE.

BINARY-DATA> (slot->defclass-slot '(major-version u1)) (MAJOR-VERSION :INITARG :MAJOR-VERSION :ACCESSOR MAJOR-VERSION)

Looks good. Now the first version of define-binary-class is trivial.

(defmacro define-binary-class (name slots) `(defclass ,name () ,(mapcar #'slot->defclass-slot slots)))

This is simple template-style macro--define-binary-class generates a DEFCLASS form by interpolating the name of the class and a list of slot specifiers constructed by applying slot->defclass-slot to each element of the list of slots specifiers from the define-binary-class form.

To see exactly what code this macro generates, you can evaluate this expression at the REPL.

(macroexpand-1 '(define-binary-class id3-tag ((identifier (iso-8859-1-string :length 3)) (major-version u1) (revision u1) (flags u1) (size id3-tag-size) (frames (id3-frames :tag-size size)))))

The result, slightly reformatted here for better readability, should look familiar since it's exactly the class definition you wrote by hand earlier:

(defclass id3-tag () ((identifier :initarg :identifier :accessor identifier) (major-version :initarg :major-version :accessor major-version) (revision :initarg :revision :accessor revision) (flags :initarg :flags :accessor flags) (size :initarg :size :accessor size) (frames :initarg :frames :accessor frames)))

Reading Binary Objects

Next you need to make define-binary-class also generate a function that can read an instance of the new class. Looking back at the read-id3-tag function you wrote before, this seems a bit trickier, as the read-id3-tag wasn't quite so regular--to read each slot's value, you had to call a different function. Not to mention, the name of the function, read-id3-tag, while derived from the name of the class you're defining, isn't one of the arguments to define-binary-class and thus isn't available to be interpolated into a template the way the class name was.

You could deal with both of those problems by devising and following a naming convention so the macro can figure out the name of the function to call based on the name of the type in the slot specifier. However, this would require define-binary-class to generate the name read-id3-tag, which is possible but a bad idea. Macros that create global definitions should generally use only names passed to them by their callers; macros that generate names under the covers can cause hard-to-predict--and hard-to-debug--name conflicts when the generated names happen to be the same as names used elsewhere.8

You can avoid both these inconveniences by noticing that all the functions that read a particular type of value have the same fundamental purpose, to read a value of a specific type from a stream. Speaking colloquially, you might say they're all instances of a single generic operation. And the colloquial use of the word generic should lead you directly to the solution to your problem: instead of defining a bunch of independent functions, all with different names, you can define a single generic function, read-value, with methods specialized to read different types of values.

That is, instead of defining functions read-iso-8859-1-string and read-u1, you can define read-value as a generic function taking two required arguments, a type and a stream, and possibly some keyword arguments.

(defgeneric read-value (type stream &key) (:documentation "Read a value of the given type from the stream."))

By specifying &key without any actual keyword parameters, you allow different methods to define their own &key parameters without requiring them to do so. This does mean every method specialized on read-value will have to include either &key or an &rest parameter in its parameter list to be compatible with the generic function.

Then you'll define methods that use EQL specializers to specialize the type argument on the name of the type you want to read.

(defmethod read-value ((type (eql 'iso-8859-1-string)) in &key length) ...) (defmethod read-value ((type (eql 'u1)) in &key) ...)

Then you can make define-binary-class generate a read-value method specialized on the type name id3-tag, and that method can be implemented in terms of calls to read-value with the appropriate slot types as the first argument. The code you want to generate is going to look like this:

(defmethod read-value ((type (eql 'id3-tag)) in &key) (let ((object (make-instance 'id3-tag))) (with-slots (identifier major-version revision flags size frames) object (setf identifier (read-value 'iso-8859-1-string in :length 3)) (setf major-version (read-value 'u1 in)) (setf revision (read-value 'u1 in)) (setf flags (read-value 'u1 in)) (setf size (read-value 'id3-encoded-size in)) (setf frames (read-value 'id3-frames in :tag-size size))) object))

So, just as you needed a function to translate a define-binary-class slot specifier to a DEFCLASS slot specifier in order to generate the DEFCLASS form, now you need a function that takes a define-binary-class slot specifier and generates the appropriate SETF form, that is, something that takes this:

(identifier (iso-8859-1-string :length 3))

and returns this:

(setf identifier (read-value 'iso-8859-1-string in :length 3))

However, there's a difference between this code and the DEFCLASS slot specifier: it includes a reference to a variable in--the method parameter from the read-value method--that wasn't derived from the slot specifier. It doesn't have to be called in, but whatever name you use has to be the same as the one used in the method's parameter list and in the other calls to read-value. For now you can dodge the issue of where that name comes from by defining slot->read-value to take a second argument of the name of the stream variable.

(defun slot->read-value (spec stream) (destructuring-bind (name (type &rest args)) (normalize-slot-spec spec) `(setf ,name (read-value ',type ,stream ,@args))))

The function normalize-slot-spec normalizes the second element of the slot specifier, converting a symbol like u1 to the list (u1) so the DESTRUCTURING-BIND can parse it. It looks like this:

(defun normalize-slot-spec (spec) (list (first spec) (mklist (second spec)))) (defun mklist (x) (if (listp x) x (list x)))

You can test slot->read-value with each type of slot specifier.

BINARY-DATA> (slot->read-value '(major-version u1) 'stream) (SETF MAJOR-VERSION (READ-VALUE 'U1 STREAM)) BINARY-DATA> (slot->read-value '(identifier (iso-8859-1-string :length 3)) 'stream) (SETF IDENTIFIER (READ-VALUE 'ISO-8859-1-STRING STREAM :LENGTH 3))

With these functions you're ready to add read-value to define-binary-class. If you take the handwritten read-value method and strip out anything that's tied to a particular class, you're left with this skeleton:

(defmethod read-value ((type (eql ...)) stream &key) (let ((object (make-instance ...))) (with-slots (...) object ... object)))

All you need to do is add this skeleton to the define-binary-class template, replacing ellipses with code that fills in the skeleton with the appropriate names and code. You'll also want to replace the variables type, stream, and object with gensymed names to avoid potential conflicts with slot names,9 which you can do with the with-gensyms macro from Chapter 8.

Also, because a macro must expand into a single form, you need to wrap some form around the DEFCLASS and DEFMETHOD. PROGN is the customary form to use for macros that expand into multiple definitions because of the special treatment it gets from the file compiler when appearing at the top level of a file, as I discussed in Chapter 20.

So, you can change define-binary-class as follows:

(defmacro define-binary-class (name slots) (with-gensyms (typevar objectvar streamvar) `(progn (defclass ,name () ,(mapcar #'slot->defclass-slot slots)) (defmethod read-value ((,typevar (eql ',name)) ,streamvar &key) (let ((,objectvar (make-instance ',name))) (with-slots ,(mapcar #'first slots) ,objectvar ,@(mapcar #'(lambda (x) (slot->read-value x streamvar)) slots)) ,objectvar)))))

Writing Binary Objects

Generating code to write out an instance of a binary class will proceed similarly. First you can define a write-value generic function.

(defgeneric write-value (type stream value &key) (:documentation "Write a value as the given type to the stream."))

Then you define a helper function that translates a define-binary-class slot specifier into code that writes out the slot using write-value. As with the slot->read-value function, this helper function needs to take the name of the stream variable as an argument.

(defun slot->write-value (spec stream) (destructuring-bind (name (type &rest args)) (normalize-slot-spec spec) `(write-value ',type ,stream ,name ,@args)))

Now you can add a write-value template to the define-binary-class macro.

(defmacro define-binary-class (name slots) (with-gensyms (typevar objectvar streamvar) `(progn (defclass ,name () ,(mapcar #'slot->defclass-slot slots)) (defmethod read-value ((,typevar (eql ',name)) ,streamvar &key) (let ((,objectvar (make-instance ',name))) (with-slots ,(mapcar #'first slots) ,objectvar ,@(mapcar #'(lambda (x) (slot->read-value x streamvar)) slots)) ,objectvar)) (defmethod write-value ((,typevar (eql ',name)) ,streamvar ,objectvar &key) (with-slots ,(mapcar #'first slots) ,objectvar ,@(mapcar #'(lambda (x) (slot->write-value x streamvar)) slots))))))

Adding Inheritance and Tagged Structures

While this version of define-binary-class will handle stand-alone structures, binary file formats often define on-disk structures that would be natural to model with subclasses and superclasses. So you might want to extend define-binary-class to support inheritance.

A related technique used in many binary formats is to have several on-disk structures whose exact type can be determined only by reading some data that indicates how to parse the following bytes. For instance, the frames that make up the bulk of an ID3 tag all share a common header structure consisting of a string identifier and a length. To read a frame, you need to read the identifier and use its value to determine what kind of frame you're looking at and thus how to parse the body of the frame.

The current define-binary-class macro has no way to handle this kind of reading--you could use define-binary-class to define a class to represent each kind of frame, but you'd have no way to know what type of frame to read without reading at least the identifier. And if other code reads the identifier in order to determine what type to pass to read-value, then that will break read-value since it's expecting to read all the data that makes up the instance of the class it instantiates.

You can solve this problem by adding inheritance to define-binary-class and then writing another macro, define-tagged-binary-class, for defining "abstract" classes that aren't instantiated directly but that can be specialized on by read-value methods that know how to read enough data to determine what kind of class to create.

The first step to adding inheritance to define-binary-class is to add a parameter to the macro to accept a list of superclasses.

(defmacro define-binary-class (name (&rest superclasses) slots) ...

Then, in the DEFCLASS template, interpolate that value instead of the empty list.

(defclass ,name ,superclasses ...)

However, there's a bit more to it than that. You also need to change the read-value and write-value methods so the methods generated when defining a superclass can be used by the methods generated as part of a subclass to read and write inherited slots.

The current way read-value works is particularly problematic since it instantiates the object before filling it in--obviously, you can't have the method responsible for reading the superclass's fields instantiate one object while the subclass's method instantiates and fills in a different object.

You can fix that problem by splitting read-value into two parts--one responsible for instantiating the correct kind of object and another responsible for filling slots in an existing object. On the writing side it's a bit simpler, but you can use the same technique.

So you'll define two new generic functions, read-object and write-object, that will both take an existing object and a stream. Methods on these generic functions will be responsible for reading or writing the slots specific to the class of the object on which they're specialized.

(defgeneric read-object (object stream) (:method-combination progn :most-specific-last) (:documentation "Fill in the slots of object from stream.")) (defgeneric write-object (object stream) (:method-combination progn :most-specific-last) (:documentation "Write out the slots of object to the stream."))

Defining these generic functions to use the PROGN method combination with the option :most-specific-last allows you to define methods that specialize object on each binary class and have them deal only with the slots actually defined in that class; the PROGN method combination will combine all the applicable methods so the method specialized on the least specific class in the hierarchy runs first, reading or writing the slots defined in that class, then the method specialized on next least specific subclass, and so on. And since all the heavy lifting for a specific class is now going to be done by read-object and write-object, you don't even need to define specialized read-value and write-value methods; you can define default methods that assume the type argument is the name of a binary class.

