By default the key given is compared to the keys in the alist using EQL, but you can change that with the standard combination of :key and :test keyword arguments. For instance, if you wanted to use string keys, you might write this:

CL-USER> (assoc "a" '(("a" . 1) ("b" . 2) ("c" . 3)) :test #'string=) ("a" . 1)

Without specifying :test to be STRING=, that ASSOC would probably return NIL because two strings with the same contents aren't necessarily EQL.

CL-USER> (assoc "a" '(("a" . 1) ("b" . 2) ("c" . 3))) NIL

Because ASSOC searches the list by scanning from the front of the list, one key/value pair in an alist can shadow other pairs with the same key later in the list.

CL-USER> (assoc 'a '((a . 10) (a . 1) (b . 2) (c . 3))) (A . 10)

You can add a pair to the front of an alist with CONS like this:

(cons (cons 'new-key 'new-value) alist)

However, as a convenience, Common Lisp provides the function ACONS, which lets you write this:

(acons 'new-key 'new-value alist)

Like CONS, ACONS is a function and thus can't modify the place holding the alist it's passed. If you want to modify an alist, you need to write either this:

(setf alist (acons 'new-key 'new-value alist))

or this:

(push (cons 'new-key 'new-value) alist)

Obviously, the time it takes to search an alist with ASSOC is a function of how deep in the list the matching pair is found. In the worst case, determining that no pair matches requires ASSOC to scan every element of the alist. However, since the basic mechanism for alists is so lightweight, for small tables an alist can outperform a hash table. Also, alists give you more flexibility in how you do the lookup. I already mentioned that ASSOC takes :key and :test keyword arguments. When those don't suit your needs, you may be able to use the ASSOC-IF and ASSOC-IF-NOT functions, which return the first key/value pair whose CAR satisfies (or not, in the case of ASSOC-IF-NOT) the test function passed in the place of a specific item. And three functions--RASSOC, RASSOC-IF, and RASSOC-IF-NOT--work just like the corresponding ASSOC functions except they use the value in the CDR of each element as the key, performing a reverse lookup.

The function COPY-ALIST is similar to COPY-TREE except, instead of copying the whole tree structure, it copies only the cons cells that make up the list structure, plus the cons cells directly referenced from the CARs of those cells. In other words, the original alist and the copy will both contain the same objects as the keys and values, even if those keys or values happen to be made up of cons cells.

Finally, you can build an alist from two separate lists of keys and values with the function PAIRLIS. The resulting alist may contain the pairs either in the same order as the original lists or in reverse order. For example, you may get this result:

CL-USER> (pairlis '(a b c) '(1 2 3)) ((C . 3) (B . 2) (A . 1))

Or you could just as well get this:

CL-USER> (pairlis '(a b c) '(1 2 3)) ((A . 1) (B . 2) (C . 3))

The other kind of lookup table is the property list, or plist, which you used to represent the rows in the database in Chapter 3. Structurally a plist is just a regular list with the keys and values as alternating values. For instance, a plist mapping A, B, and C, to 1, 2, and 3 is simply the list (A 1 B 2 C 3). In boxes-and-arrows form, it looks like this:

However, plists are less flexible than alists. In fact, plists support only one fundamental lookup operation, the function GETF, which takes a plist and a key and returns the associated value or NIL if the key isn't found. GETF also takes an optional third argument, which will be returned in place of NIL if the key isn't found.

Unlike ASSOC, which uses EQL as its default test and allows a different test function to be supplied with a :test argument, GETF always uses EQ to test whether the provided key matches the keys in the plist. Consequently, you should never use numbers or characters as keys in a plist; as you saw in Chapter 4, the behavior of EQ for those types is essentially undefined. Practically speaking, the keys in a plist are almost always symbols, which makes sense since plists were first invented to implement symbolic "properties," arbitrary mappings between names and values.

You can use SETF with GETF to set the value associated with a given key. SETF also treats GETF a bit specially in that the first argument to GETF is treated as the place to modify. Thus, you can use SETF of GETF to add a new key/value pair to an existing plist.

CL-USER> (defparameter *plist* ()) *PLIST* CL-USER> *plist* NIL CL-USER> (setf (getf *plist* :a) 1) 1 CL-USER> *plist* (:A 1) CL-USER> (setf (getf *plist* :a) 2) 2 CL-USER> *plist* (:A 2)

To remove a key/value pair from a plist, you use the macro REMF, which sets the place given as its first argument to a plist containing all the key/value pairs except the one specified. It returns true if the given key was actually found.

CL-USER> (remf *plist* :a) T CL-USER> *plist* NIL

Like GETF, REMF always uses EQ to compare the given key to the keys in the plist.

Since plists are often used in situations where you want to extract several properties from the same plist, Common Lisp provides a function, GET-PROPERTIES, that makes it more efficient to extract multiple values from a single plist. It takes a plist and a list of keys to search for and returns, as multiple values, the first key found, the corresponding value, and the head of the list starting with the found key. This allows you to process a property list, extracting the desired properties, without continually rescanning from the front of the list. For instance, the following function efficiently processes--using the hypothetical function process-property--all the key/value pairs in a plist for a given list of keys:

(defun process-properties (plist keys) (loop while plist do (multiple-value-bind (key value tail) (get-properties plist keys) (when key (process-property key value)) (setf plist (cddr tail)))))

The last special thing about plists is the relationship they have with symbols: every symbol object has an associated plist that can be used to store information about the symbol. The plist can be obtained via the function SYMBOL-PLIST. However, you rarely care about the whole plist; more often you'll use the functions GET, which takes a symbol and a key and is shorthand for a GETF of the same key in the symbols SYMBOL-PLIST.

(get 'symbol 'key) === (getf (symbol-plist 'symbol) 'key)

Like GETF, GET is SETFable, so you can attach arbitrary information to a symbol like this:

(setf (get 'some-symbol 'my-key) "information")

To remove a property from a symbol's plist, you can use either REMF of SYMBOL-PLIST or the convenience function REMPROP.4

(remprop 'symbol 'key) === (remf (symbol-plist 'symbol key))

Being able to attach arbitrary information to names is quite handy when doing any kind of symbolic programming. For instance, one of the macros you'll write in Chapter 24 will attach information to names that other instances of the same macros will extract and use when generating their expansions.

DESTRUCTURING-BIND

One last tool for slicing and dicing lists that I need to cover since you'll need it in later chapters is the DESTRUCTURING-BIND macro. This macro provides a way to destructure arbitrary lists, similar to the way macro parameter lists can take apart their argument list. The basic skeleton of a DESTRUCTURING-BIND is as follows:

(destructuring-bind (parameter*) list body-form*)

The parameter list can include any of the types of parameters supported in macro parameter lists such as &optional, &rest, and &key parameters.5 And, as in macro parameter lists, any parameter can be replaced with a nested destructuring parameter list, which takes apart the list that would otherwise have been bound to the replaced parameter. The list form is evaluated once and should return a list, which is then destructured and the appropriate values are bound to the variables in the parameter list. Then the body-forms are evaluated in order with those bindings in effect. Some simple examples follow:

(destructuring-bind (x y z) (list 1 2 3) (list :x x :y y :z z)) ==> (:X 1 :Y 2 :Z 3) (destructuring-bind (x y z) (list 1 (list 2 20) 3) (list :x x :y y :z z)) ==> (:X 1 :Y (2 20) :Z 3) (destructuring-bind (x (y1 y2) z) (list 1 (list 2 20) 3) (list :x x :y1 y1 :y2 y2 :z z)) ==> (:X 1 :Y1 2 :Y2 20 :Z 3) (destructuring-bind (x (y1 &optional y2) z) (list 1 (list 2 20) 3) (list :x x :y1 y1 :y2 y2 :z z)) ==> (:X 1 :Y1 2 :Y2 20 :Z 3) (destructuring-bind (x (y1 &optional y2) z) (list 1 (list 2) 3) (list :x x :y1 y1 :y2 y2 :z z)) ==> (:X 1 :Y1 2 :Y2 NIL :Z 3) (destructuring-bind (&key x y z) (list :x 1 :y 2 :z 3) (list :x x :y y :z z)) ==> (:X 1 :Y 2 :Z 3) (destructuring-bind (&key x y z) (list :z 1 :y 2 :x 3) (list :x x :y y :z z)) ==> (:X 3 :Y 2 :Z 1)

One kind of parameter you can use with DESTRUCTURING-BIND and also in macro parameter lists, though I didn't mention it in Chapter 8, is a &whole parameter. If specified, it must be the first parameter in a parameter list, and it's bound to the whole list form.6 After a &whole parameter, other parameters can appear as usual and will extract specific parts of the list just as they would if the &whole parameter weren't there. An example of using &whole with DESTRUCTURING-BIND looks like this:

(destructuring-bind (&whole whole &key x y z) (list :z 1 :y 2 :x 3) (list :x x :y y :z z :whole whole)) ==> (:X 3 :Y 2 :Z 1 :WHOLE (:Z 1 :Y 2 :X 3))

You'll use a &whole parameter in one of the macros that's part of the HTML generation library you'll develop in Chapter 31. However, I have a few more topics to cover before you can get to that. After two chapters on the rather Lispy topic of cons cells, you can now turn to the more prosaic matter of how to deal with files and filenames.

* * *

1It's possible to build a chain of cons cells where the CDR of the last cons cell isn't NIL but some other atom. This is called a dotted list because the last cons is a dotted pair.

2It may seem that the NSUBST family of functions can and in fact does modify the tree in place. However, there's one edge case: when the "tree" passed is, in fact, an atom, it can't be modified in place, so the result of NSUBST will be a different object than the argument: (nsubst 'x 'y 'y) X.

3UNION takes only one element from each list, but if either list contains duplicate elements, the result may also contain duplicates.

4It's also possible to directly SETF SYMBOL-PLIST. However, that's a bad idea, as different code may have added different properties to the symbol's plist for different reasons. If one piece of code clobbers the symbol's whole plist, it may break other code that added its own properties to the plist.

5Macro parameter lists do support one parameter type, &environment parameters, which DESTRUCTURING-BIND doesn't. However, I didn't discuss that parameter type in Chapter 8, and you don't need to worry about it now either.

6When a &whole parameter is used in a macro parameter list, the form it's bound to is the whole macro form, including the name of the macro.

Copyright © 2003-2005, Peter Seibel

14. Files and File I/O

Common Lisp provides a rich library of functionality for dealing with files. In this chapter I'll focus on a few basic file-related tasks: reading and writing files and listing files in the file system. For these basic tasks, Common Lisp's I/O facilities are similar to those in other languages. Common Lisp provides a stream abstraction for reading and writing data and an abstraction, called pathnames, for manipulating filenames in an operating system-independent way. Additionally, Common Lisp provides other bits of functionality unique to Lisp such as the ability to read and write s-expressions.

Reading File Data

The most basic file I/O task is to read the contents of a file. You obtain a stream from which you can read a file's contents with the OPEN function. By default OPEN returns a character-based input stream you can pass to a variety of functions that read one or more characters of text: READ-CHAR reads a single character; READ-LINE reads a line of text, returning it as a string with the end-of-line character(s) removed; and READ reads a single s-expression, returning a Lisp object. When you're done with the stream, you can close it with the CLOSE function.

The only required argument to OPEN is the name of the file to read. As you'll see in the section "Filenames," Common Lisp provides a couple of ways to represent a filename, but the simplest is to use a string containing the name in the local file-naming syntax. So assuming that /some/file/name.txt is a file, you can open it like this:

(open "/some/file/name.txt")

You can use the object returned as the first argument to any of the read functions. For instance, to print the first line of the file, you can combine OPEN, READ-LINE, and CLOSE as follows:

(let ((in (open "/some/file/name.txt"))) (format t "~a~%" (read-line in)) (close in))

Of course, a number of things can go wrong while trying to open and read from a file. The file may not exist. Or you may unexpectedly hit the end of the file while reading. By default OPEN and the READ-* functions will signal an error in these situations. In Chapter 19, I'll discuss how to recover from such errors. For now, however, there's a lighter-weight solution: each of these functions accepts arguments that modify its behavior in these exceptional situations.

If you want to open a possibly nonexistent file without OPEN signaling an error, you can use the keyword argument :if-does-not-exist to specify a different behavior. The three possible values are :error, the default; :create, which tells it to go ahead and create the file and then proceed as if it had already existed; and NIL, which tells it to return NIL instead of a stream. Thus, you can change the previous example to deal with the possibility that the file may not exist.

(let ((in (open "/some/file/name.txt" :if-does-not-exist nil))) (when in (format t "~a~%" (read-line in)) (close in)))

The reading functions--READ-CHAR, READ-LINE, and READ--all take an optional argument, which defaults to true, that specifies whether they should signal an error if they're called at the end of the file. If that argument is NIL, they instead return the value of their third argument, which defaults to NIL. Thus, you could print all the lines in a file like this:

(let ((in (open "/some/file/name.txt" :if-does-not-exist nil))) (when in (loop for line = (read-line in nil) while line do (format t "~a~%" line)) (close in)))

Of the three text-reading functions, READ is unique to Lisp. This is the same function that provides the R in the REPL and that's used to read Lisp source code. Each time it's called, it reads a single s-expression, skipping whitespace and comments, and returns the Lisp object denoted by the s-expression. For instance, suppose /some/file/name.txt has the following contents:

(1 2 3) 456 "a string" ; this is a comment ((a b) (c d))

In other words, it contains four s-expressions: a list of numbers, a number, a string, and a list of lists. You can read those expressions like this:

CL-USER> (defparameter *s* (open "/some/file/name.txt")) *S* CL-USER> (read *s*) (1 2 3) CL-USER> (read *s*) 456 CL-USER> (read *s*) "a string" CL-USER> (read *s*) ((A B) (C D)) CL-USER> (close *s*) T

As you saw in Chapter 3, you can use PRINT to print Lisp objects in "readable" form. Thus, whenever you need to store a bit of data in a file, PRINT and READ provide an easy way to do it without having to design a data format or write a parser. They even--as the previous example demonstrated--give you comments for free. And because s-expressions were designed to be human editable, it's also a fine format for things like configuration files.1

Reading Binary Data

By default OPEN returns character streams, which translate the underlying bytes to characters according to a particular character-encoding scheme.2 To read the raw bytes, you need to pass OPEN an :element-type argument of '(unsigned-byte 8).3 You can pass the resulting stream to the function READ-BYTE, which will return an integer between 0 and 255 each time it's called. READ-BYTE, like the character-reading functions, also accepts optional arguments to specify whether it should signal an error if called at the end of the file and what value to return if not. In Chapter 24 you'll build a library that allows you to conveniently read structured binary data using READ-BYTE.4

Bulk Reads

One last reading function, READ-SEQUENCE, works with both character and binary streams. You pass it a sequence (typically a vector) and a stream, and it attempts to fill the sequence with data from the stream. It returns the index of the first element of the sequence that wasn't filled or the length of the sequence if it was able to completely fill it. You can also pass :start and :end keyword arguments to specify a subsequence that should be filled instead. The sequence argument must be a type that can hold elements of the stream's element type. Since most operating systems support some form of block I/O, READ-SEQUENCE is likely to be quite a bit more efficient than filling a sequence by repeatedly calling READ-BYTE or READ-CHAR.

File Output

To write data to a file, you need an output stream, which you obtain by calling OPEN with a :direction keyword argument of :output. When opening a file for output, OPEN assumes the file shouldn't already exist and will signal an error if it does. However, you can change that behavior with the :if-exists keyword argument. Passing the value :supersede tells OPEN to replace the existing file. Passing :append causes OPEN to open the existing file such that new data will be written at the end of the file, while :overwrite returns a stream that will overwrite existing data starting from the beginning of the file. And passing NIL will cause OPEN to return NIL instead of a stream if the file already exists. A typical use of OPEN for output looks like this:

(open "/some/file/name.txt" :direction :output :if-exists :supersede)

Common Lisp also provides several functions for writing data: WRITE-CHAR writes a single character to the stream. WRITE-LINE writes a string followed by a newline, which will be output as the appropriate end-of-line character or characters for the platform. Another function, WRITE-STRING, writes a string without adding any end-of-line characters. Two different functions can print just a newline: TERPRI--short for "terminate print"--unconditionally prints a newline character, and FRESH-LINE prints a newline character unless the stream is at the beginning of a line. FRESH-LINE is handy when you want to avoid spurious blank lines in textual output generated by different functions called in sequence. For example, suppose you have one function that generates output that should always be followed by a line break and another that should start on a new line. But assume that if the functions are called one after the other, you don't want a blank line between the two bits of output. If you use FRESH-LINE at the beginning of the second function, its output will always start on a new line, but if it's called right after the first, it won't emit an extra line break.

Several functions output Lisp data as s-expressions: PRINT prints an s-expression preceded by an end-of-line and followed by a space. PRIN1 prints just the s-expression. And the function PPRINT prints s-expressions like PRINT and PRIN1 but using the "pretty printer," which tries to print its output in an aesthetically pleasing way.

However, not all objects can be printed in a form that READ will understand. The variable *PRINT-READABLY* controls what happens if you try to print such an object with PRINT, PRIN1, or PPRINT. When it's NIL, these functions will print the object in a special syntax that's guaranteed to cause READ to signal an error if it tries to read it; otherwise they will signal an error rather than print the object.

Another function, PRINC, also prints Lisp objects, but in a way designed for human consumption. For instance, PRINC prints strings without quotation marks. You can generate more elaborate text output with the incredibly flexible if somewhat arcane FORMAT function. I'll discuss some of the more important details of FORMAT, which essentially defines a mini-language for emitting formatted output, in Chapter 18.

To write binary data to a file, you have to OPEN the file with the same :element-type argument as you did to read it: '(unsigned-byte 8). You can then write individual bytes to the stream with WRITE-BYTE.

The bulk output function WRITE-SEQUENCE accepts both binary and character streams as long as all the elements of the sequence are of an appropriate type for the stream, either characters or bytes. As with READ-SEQUENCE, this function is likely to be quite a bit more efficient than writing the elements of the sequence one at a time.

Closing Files

As anyone who has written code that deals with lots of files knows, it's important to close files when you're done with them, because file handles tend to be a scarce resource. If you open files and don't close them, you'll soon discover you can't open any more files.5 It might seem straightforward enough to just be sure every OPEN has a matching CLOSE. For instance, you could always structure your file using code like this:

(let ((stream (open "/some/file/name.txt"))) ;; do stuff with stream (close stream))

However, this approach suffers from two problems. One is simply that it's error prone--if you forget the CLOSE, the code will leak a file handle every time it runs. The other--and more significant--problem is that there's no guarantee you'll get to the CLOSE. For instance, if the code prior to the CLOSE contains a RETURN or RETURN-FROM, you could leave the LET without closing the stream. Or, as you'll see in Chapter 19, if any of the code before the CLOSE signals an error, control may jump out of the LET to an error handler and never come back to close the stream.

Common Lisp provides a general solution to the problem of how to ensure that certain code always runs: the special operator UNWIND-PROTECT, which I'll discuss in Chapter 20. However, because the pattern of opening a file, doing something with the resulting stream, and then closing the stream is so common, Common Lisp provides a macro, WITH-OPEN-FILE, built on top of UNWIND-PROTECT, to encapsulate this pattern. This is the basic form:

(with-open-file (stream-var open-argument*) body-form*)

The forms in body-forms are evaluated with stream-var bound to a file stream opened by a call to OPEN with open-arguments as its arguments. WITH-OPEN-FILE then ensures the stream in stream-var is closed before the WITH-OPEN-FILE form returns. Thus, you can write this to read a line from a file:

(with-open-file (stream "/some/file/name.txt") (format t "~a~%" (read-line stream)))

To create a new file, you can write something like this:

(with-open-file (stream "/some/file/name.txt" :direction :output) (format stream "Some text."))

You'll probably use WITH-OPEN-FILE for 90-99 percent of the file I/O you do--the only time you need to use raw OPEN and CLOSE calls is if you need to open a file in a function and keep the stream around after the function returns. In that case, you must take care to eventually close the stream yourself, or you'll leak file descriptors and may eventually end up unable to open any more files.

Filenames

So far you've used strings to represent filenames. However, using strings as filenames ties your code to a particular operating system and file system. Likewise, if you programmatically construct names according to the rules of a particular naming scheme (separating directories with /, say), you also tie your code to a particular file system.

To avoid this kind of nonportability, Common Lisp provides another representation of filenames: pathname objects. Pathnames represent filenames in a structured way that makes them easy to manipulate without tying them to a particular filename syntax. And the burden of translating back and forth between strings in the local syntax--called namestrings--and pathnames is placed on the Lisp implementation.

Unfortunately, as with many abstractions designed to hide the details of fundamentally different underlying systems, the pathname abstraction introduces its own complications. When pathnames were designed, the set of file systems in general use was quite a bit more variegated than those in common use today. Consequently, some nooks and crannies of the pathname abstraction make little sense if all you're concerned about is representing Unix or Windows filenames. However, once you understand which parts of the pathname abstraction you can ignore as artifacts of pathnames' evolutionary history, they do provide a convenient way to manipulate filenames.6

Most places a filename is called for, you can use either a namestring or a pathname. Which to use depends mostly on where the name originated. Filenames provided by the user--for example, as arguments or as values in configuration files--will typically be namestrings, since the user knows what operating system they're running on and shouldn't be expected to care about the details of how Lisp represents filenames. But programmatically generated filenames will be pathnames because you can create them portably. A stream returned by OPEN also represents a filename, namely, the filename that was originally used to open the stream. Together these three types are collectively referred to as pathname designators. All the built-in functions that expect a filename argument accept all three types of pathname designator. For instance, all the places in the previous section where you used a string to represent a filename, you could also have passed a pathname object or a stream.

How We Got Here

The historical diversity of file systems in existence during the 70s and 80s can be easy to forget. Kent Pitman, one of the principal technical editors of the Common Lisp standard, described the situation once in comp.lang.lisp (Message-ID: sfwzo74np6w.fsf@world.std.com) thusly:

The dominant file systems at the time the design [of Common Lisp] was done were TOPS-10, TENEX, TOPS-20, VAX VMS, AT&T Unix, MIT Multics, MIT ITS, not to mention a bunch of mainframe [OSs]. Some were uppercase only, some mixed, some were case-sensitive but case- translating (like CL). Some had dirs as files, some not. Some had quote chars for funny file chars, some not. Some had wildcards, some didn't. Some had :up in relative pathnames, some didn't. Some had namable root dirs, some didn't. There were file systems with no directories, file systems with non-hierarchical directories, file systems with no file types, file systems with no versions, file systems with no devices, and so on.

If you look at the pathname abstraction from the point of view of any single file system, it seems baroque. However, if you take even two such similar file systems as Windows and Unix, you can already begin to see differences the pathname system can help abstract away--Windows filenames contain a drive letter, for instance, while Unix filenames don't. The other advantage of having the pathname abstraction designed to handle the wide variety of file systems that existed in the past is that it's more likely to be able to handle file systems that may exist in the future. If, say, versioning file systems come back into vogue, Common Lisp will be ready.

How Pathnames Represent Filenames

A pathname is a structured object that represents a filename using six components: host, device, directory, name, type, and version. Most of these components take on atomic values, usually strings; only the directory component is further structured, containing a list of directory names (as strings) prefaced with the keyword :absolute or :relative. However, not all pathname components are needed on all platforms--this is one of the reasons pathnames strike many new Lispers as gratuitously complex. On the other hand, you don't really need to worry about which components may or may not be used to represent names on a particular file system unless you need to create a new pathname object from scratch, which you'll almost never need to do. Instead, you'll usually get hold of pathname objects either by letting the implementation parse a file system-specific namestring into a pathname object or by creating a new pathname that takes most of its components from an existing pathname.

For instance, to translate a namestring to a pathname, you use the PATHNAME function. It takes a pathname designator and returns an equivalent pathname object. When the designator is already a pathname, it's simply returned. When it's a stream, the original filename is extracted and returned. When the designator is a namestring, however, it's parsed according to the local filename syntax. The language standard, as a platform-neutral document, doesn't specify any particular mapping from namestring to pathname, but most implementations follow the same conventions on a given operating system.

On Unix file systems, only the directory, name, and type components are typically used. On Windows, one more component--usually the device or host--holds the drive letter. On these platforms, a namestring is parsed by first splitting it into elements on the path separator--a slash on Unix and a slash or backslash on Windows. The drive letter on Windows will be placed into either the device or the host component. All but the last of the other name elements are placed in a list starting with :absolute or :relative depending on whether the name (ignoring the drive letter, if any) began with a path separator. This list becomes the directory component of the pathname. The last element is then split on the rightmost dot, if any, and the two parts put into the name and type components of the pathname.7

You can examine these individual components of a pathname with the functions PATHNAME-DIRECTORY, PATHNAME-NAME, and PATHNAME-TYPE.

(pathname-directory (pathname "/foo/bar/baz.txt")) ==> (:ABSOLUTE "foo" "bar") (pathname-name (pathname "/foo/bar/baz.txt")) ==> "baz" (pathname-type (pathname "/foo/bar/baz.txt")) ==> "txt"

Three other functions--PATHNAME-HOST, PATHNAME-DEVICE, and PATHNAME-VERSION--allow you to get at the other three pathname components, though they're unlikely to have interesting values on Unix. On Windows either PATHNAME-HOST or PATHNAME-DEVICE will return the drive letter.

Like many other built-in objects, pathnames have their own read syntax, #p followed by a double-quoted string. This allows you to print and read back s-expressions containing pathname objects, but because the syntax depends on the namestring parsing algorithm, such data isn't necessarily portable between operating systems.

(pathname "/foo/bar/baz.txt") ==> #p"/foo/bar/baz.txt"

To translate a pathname back to a namestring--for instance, to present to the user--you can use the function NAMESTRING, which takes a pathname designator and returns a namestring. Two other functions, DIRECTORY-NAMESTRING and FILE-NAMESTRING, return a partial namestring. DIRECTORY-NAMESTRING combines the elements of the directory component into a local directory name, and FILE-NAMESTRING combines the name and type components.8

(namestring #p"/foo/bar/baz.txt") ==> "/foo/bar/baz.txt" (directory-namestring #p"/foo/bar/baz.txt") ==> "/foo/bar/" (file-namestring #p"/foo/bar/baz.txt") ==> "baz.txt"

Constructing New Pathnames

You can construct arbitrary pathnames using the MAKE-PATHNAME function. It takes one keyword argument for each pathname component and returns a pathname with any supplied components filled in and the rest NIL.9

(make-pathname :directory '(:absolute "foo" "bar") :name "baz" :type "txt") ==> #p"/foo/bar/baz.txt"

However, if you want your programs to be portable, you probably don't want to make pathnames completely from scratch: even though the pathname abstraction protects you from unportable filename syntax, filenames can be unportable in other ways. For instance, the filename /home/peter/foo.txt is no good on an OS X box where /home/ is called /Users/.

Another reason not to make pathnames completely from scratch is that different implementations use the pathname components slightly differently. For instance, as mentioned previously, some Windows-based Lisp implementations store the drive letter in the device component while others store it in the host component. If you write code like this:

(make-pathname :device "c" :directory '(:absolute "foo" "bar") :name "baz")

it will be correct on some implementations but not on others.

Rather than making names from scratch, you can build a new pathname based on an existing pathname with MAKE-PATHNAME's keyword parameter :defaults. With this parameter you can provide a pathname designator, which will supply the values for any components not specified by other arguments. For example, the following expression creates a pathname with an .html extension and all other components the same as the pathname in the variable input-file:

(make-pathname :type "html" :defaults input-file)

Assuming the value in input-file was a user-provided name, this code will be robust in the face of operating system and implementation differences such as whether filenames have drive letters in them and where they're stored in a pathname if they do.10

You can use the same technique to create a pathname with a different directory component.

(make-pathname :directory '(:relative "backups") :defaults input-file)

However, this will create a pathname whose whole directory component is the relative directory backups/, regardless of any directory component input-file may have had. For example:

(make-pathname :directory '(:relative "backups") :defaults #p"/foo/bar/baz.txt") ==> #p"backups/baz.txt"

Sometimes, though, you want to combine two pathnames, at least one of which has a relative directory component, by combining their directory components. For instance, suppose you have a relative pathname such as #p"foo/bar.html" that you want to combine with an absolute pathname such as #p"/www/html/" to get #p"/www/html/foo/bar.html". In that case, MAKE-PATHNAME won't do; instead, you want MERGE-PATHNAMES.

MERGE-PATHNAMES takes two pathnames and merges them, filling in any NIL components in the first pathname with the corresponding value from the second pathname, much like MAKE-PATHNAME fills in any unspecified components with components from the :defaults argument. However, MERGE-PATHNAMES treats the directory component specially: if the first pathname's directory is relative, the directory component of the resulting pathname will be the first pathname's directory relative to the second pathname's directory. Thus:

(merge-pathnames #p"foo/bar.html" #p"/www/html/") ==> #p"/www/html/foo/bar.html"

The second pathname can also be relative, in which case the resulting pathname will also be relative.

(merge-pathnames #p"foo/bar.html" #p"html/") ==> #p"html/foo/bar.html"

To reverse this process and obtain a filename relative to a particular root directory, you can use the handy function ENOUGH-NAMESTRING.

(enough-namestring #p"/www/html/foo/bar.html" #p"/www/") ==> "html/foo/bar.html"

You can then combine ENOUGH-NAMESTRING with MERGE-PATHNAMES to create a pathname representing the same name but in a different root.

(merge-pathnames (enough-namestring #p"/www/html/foo/bar/baz.html" #p"/www/") #p"/www-backups/") ==> #p"/www-backups/html/foo/bar/baz.html"

MERGE-PATHNAMES is also used internally by the standard functions that actually access files in the file system to fill in incomplete pathnames. For instance, suppose you make a pathname with just a name and a type.

(make-pathname :name "foo" :type "txt") ==> #p"foo.txt"

If you try to use this pathname as an argument to OPEN, the missing components, such as the directory, must be filled in before Lisp will be able to translate the pathname to an actual filename. Common Lisp will obtain values for the missing components by merging the given pathname with the value of the variable *DEFAULT-PATHNAME-DEFAULTS*. The initial value of this variable is determined by the implementation but is usually a pathname with a directory component representing the directory where Lisp was started and appropriate values for the host and device components, if needed. If invoked with just one argument, MERGE-PATHNAMES will merge the argument with the value of *DEFAULT-PATHNAME-DEFAULTS*. For instance, if *DEFAULT-PATHNAME-DEFAULTS* is #p"/home/peter/", then you'd get the following:

(merge-pathnames #p"foo.txt") ==> #p"/home/peter/foo.txt"

Two Representations of Directory Names

When dealing with pathnames that name directories, you need to be aware of one wrinkle. Pathnames separate the directory and name components, but Unix and Windows consider directories just another kind of file. Thus, on those systems, every directory has two different pathname representations.

