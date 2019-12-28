One representation, which I'll call file form, treats a directory like any other file and puts the last element of the namestring into the name and type components. The other representation, directory form, places all the elements of the name in the directory component, leaving the name and type components NIL. If /foo/bar/ is a directory, then both of the following pathnames name it.

(make-pathname :directory '(:absolute "foo") :name "bar") ; file form (make-pathname :directory '(:absolute "foo" "bar")) ; directory form

When you create pathnames with MAKE-PATHNAME, you can control which form you get, but you need to be careful when dealing with namestrings. All current implementations create file form pathnames unless the namestring ends with a path separator. But you can't rely on user-supplied namestrings necessarily being in one form or another. For instance, suppose you've prompted the user for a directory to save a file in and they entered "/home/peter". If you pass that value as the :defaults argument of MAKE-PATHNAME like this:

(make-pathname :name "foo" :type "txt" :defaults user-supplied-name)

you'll end up saving the file in /home/foo.txt rather than the intended /home/peter/foo.txt because the "peter" in the namestring will be placed in the name component when user-supplied-name is converted to a pathname. In the pathname portability library I'll discuss in the next chapter, you'll write a function called pathname-as-directory that converts a pathname to directory form. With that function you can reliably save the file in the directory indicated by the user.

(make-pathname :name "foo" :type "txt" :defaults (pathname-as-directory user-supplied-name))

Interacting with the File System

While the most common interaction with the file system is probably OPENing files for reading and writing, you'll also occasionally want to test whether a file exists, list the contents of a directory, delete and rename files, create directories, and get information about a file such as who owns it, when it was last modified, and its length. This is where the generality of the pathname abstraction begins to cause a bit of pain: because the language standard doesn't specify how functions that interact with the file system map to any specific file system, implementers are left with a fair bit of leeway.

That said, most of the functions that interact with the file system are still pretty straightforward. I'll discuss the standard functions here and point out the ones that suffer from nonportability between implementations. In the next chapter you'll develop a pathname portability library to smooth over some of those nonportability issues.

To test whether a file exists in the file system corresponding to a pathname designator--a pathname, namestring, or file stream--you can use the function PROBE-FILE. If the file named by the pathname designator exists, PROBE-FILE returns the file's truename, a pathname with any file system-level translations such as resolving symbolic links performed. Otherwise, it returns NIL. However, not all implementations support using this function to test whether a directory exists. Also, Common Lisp doesn't provide a portable way to test whether a given file that exists is a regular file or a directory. In the next chapter you'll wrap PROBE-FILE with a new function, file-exists-p, that can both test whether a directory exists and tell you whether a given name is the name of a file or directory.

Similarly, the standard function for listing files in the file system, DIRECTORY, works fine for simple cases, but the differences between implementations make it tricky to use portably. In the next chapter you'll define a list-directory function that smoothes over some of these differences.

DELETE-FILE and RENAME-FILE do what their names suggest. DELETE-FILE takes a pathname designator and deletes the named file, returning true if it succeeds. Otherwise it signals a FILE-ERROR.11

RENAME-FILE takes two pathname designators and renames the file named by the first name to the second name.

You can create directories with the function ENSURE-DIRECTORIES-EXIST. It takes a pathname designator and ensures that all the elements of the directory component exist and are directories, creating them as necessary. It returns the pathname it was passed, which makes it convenient to use inline.

(with-open-file (out (ensure-directories-exist name) :direction :output) ... )

Note that if you pass ENSURE-DIRECTORIES-EXIST a directory name, it should be in directory form, or the leaf directory won't be created.

The functions FILE-WRITE-DATE and FILE-AUTHOR both take a pathname designator. FILE-WRITE-DATE returns the time in number of seconds since midnight January 1, 1900, Greenwich mean time (GMT), that the file was last written, and FILE-AUTHOR returns, on Unix and Windows, the file owner.12

To find the length of a file, you can use the function FILE-LENGTH. For historical reasons FILE-LENGTH takes a stream as an argument rather than a pathname. In theory this allows FILE-LENGTH to return the length in terms of the element type of the stream. However, since on most present-day operating systems, the only information available about the length of a file, short of actually reading the whole file to measure it, is its length in bytes, that's what most implementations return, even when FILE-LENGTH is passed a character stream. However, the standard doesn't require this behavior, so for predictable results, the best way to get the length of a file is to use a binary stream.13

(with-open-file (in filename :element-type '(unsigned-byte 8)) (file-length in))

A related function that also takes an open file stream as its argument is FILE-POSITION. When called with just a stream, this function returns the current position in the file--the number of elements that have been read from or written to the stream. When called with two arguments, the stream and a position designator, it sets the position of the stream to the designated position. The position designator must be the keyword :start, the keyword :end, or a non-negative integer. The two keywords set the position of the stream to the start or end of the file while an integer moves to the indicated position in the file. With a binary stream the position is simply a byte offset into the file. However, for character streams things are a bit more complicated because of character-encoding issues. Your best bet, if you need to jump around within a file of textual data, is to only ever pass, as a second argument to the two-argument version of FILE-POSITION, a value previously returned by the one-argument version of FILE-POSITION with the same stream argument.

Other Kinds of I/O

In addition to file streams, Common Lisp supports other kinds of streams, which can also be used with the various reading, writing, and printing I/O functions. For instance, you can read data from, or write data to, a string using STRING-STREAMs, which you can create with the functions MAKE-STRING-INPUT-STREAM and MAKE-STRING-OUTPUT-STREAM.

MAKE-STRING-INPUT-STREAM takes a string and optional start and end indices to bound the area of the string from which data should be read and returns a character stream that you can pass to any of the character-based input functions such as READ-CHAR, READ-LINE, or READ. For example, if you have a string containing a floating-point literal in Common Lisp's syntax, you can convert it to a float like this:

(let ((s (make-string-input-stream "1.23"))) (unwind-protect (read s) (close s)))

Similarly, MAKE-STRING-OUTPUT-STREAM creates a stream you can use with FORMAT, PRINT, WRITE-CHAR, WRITE-LINE, and so on. It takes no arguments. Whatever you write, a string output stream will be accumulated into a string that can then be obtained with the function GET-OUTPUT-STREAM-STRING. Each time you call GET-OUTPUT-STREAM-STRING, the stream's internal string is cleared so you can reuse an existing string output stream.

However, you'll rarely use these functions directly, because the macros WITH-INPUT-FROM-STRING and WITH-OUTPUT-TO-STRING provide a more convenient interface. WITH-INPUT-FROM-STRING is similar to WITH-OPEN-FILE--it creates a string input stream from a given string and then executes the forms in its body with the stream bound to the variable you provide. For instance, instead of the LET form with the explicit UNWIND-PROTECT, you'd probably write this:

(with-input-from-string (s "1.23") (read s))

The WITH-OUTPUT-TO-STRING macro is similar: it binds a newly created string output stream to a variable you name and then executes its body. After all the body forms have been executed, WITH-OUTPUT-TO-STRING returns the value that would be returned by GET-OUTPUT-STREAM-STRING.

CL-USER> (with-output-to-string (out) (format out "hello, world ") (format out "~s" (list 1 2 3))) "hello, world (1 2 3)"

The other kinds of streams defined in the language standard provide various kinds of stream "plumbing," allowing you to plug together streams in almost any configuration. A BROADCAST-STREAM is an output stream that sends any data written to it to a set of output streams provided as arguments to its constructor function, MAKE-BROADCAST-STREAM.14 Conversely, a CONCATENATED-STREAM is an input stream that takes its input from a set of input streams, moving from stream to stream as it hits the end of each stream. CONCATENATED-STREAMs are constructed with the function MAKE-CONCATENATED-STREAM, which takes any number of input streams as arguments.

Two kinds of bidirectional streams that can plug together streams in a couple ways are TWO-WAY-STREAM and ECHO-STREAM. Their constructor functions, MAKE-TWO-WAY-STREAM and MAKE-ECHO-STREAM, both take two arguments, an input stream and an output stream, and return a stream of the appropriate type, which you can use with both input and output functions.

In a TWO-WAY-STREAM every read you perform will return data read from the underlying input stream, and every write will send data to the underlying output stream. An ECHO-STREAM works essentially the same way except that all the data read from the underlying input stream is also echoed to the output stream. Thus, the output stream of an ECHO-STREAM stream will contain a transcript of both sides of the conversation.

Using these five kinds of streams, you can build almost any topology of stream plumbing you want.

Finally, although the Common Lisp standard doesn't say anything about networking APIs, most implementations support socket programming and typically implement sockets as another kind of stream, so you can use all the regular I/O functions with them.15

Now you're ready to move on to building a library that smoothes over some of the differences between how the basic pathname functions behave in different Common Lisp implementations.

* * *

1Note, however, that while the Lisp reader knows how to skip comments, it completely skips them. Thus, if you use READ to read in a configuration file containing comments and then use PRINT to save changes to the data, you'll lose the comments.

2By default OPEN uses the default character encoding for the operating system, but it also accepts a keyword parameter, :external-format, that can pass implementation-defined values that specify a different encoding. Character streams also translate the platform-specific end-of-line sequence to the single character #\Newline.

3The type (unsigned-byte 8) indicates an 8-bit byte; Common Lisp "byte" types aren't a fixed size since Lisp has run at various times on architectures with byte sizes from 6 to 9 bits, to say nothing of the PDP-10, which had individually addressable variable-length bit fields of 1 to 36 bits.

4In general, a stream is either a character stream or a binary stream, so you can't mix calls to READ-BYTE and READ-CHAR or other character-based read functions. However, some implementations, such as Allegro, support so-called bivalent streams, which support both character and binary I/O.

5Some folks expect this wouldn't be a problem in a garbage-collected language such as Lisp. It is the case in most Lisp implementations that a stream that becomes garbage will automatically be closed. However, this isn't something to rely on--the problem is that garbage collectors usually run only when memory is low; they don't know about other scarce resources such as file handles. If there's plenty of memory available, it's easy to run out of file handles long before the garbage collector runs.

6Another reason the pathname system is considered somewhat baroque is because of the inclusion of logical pathnames. However, you can use the rest of the pathname system perfectly well without knowing anything more about logical pathnames than that you can safely ignore them. Briefly, logical pathnames allow Common Lisp programs to contain references to pathnames without naming specific files. Logical pathnames could then be mapped to specific locations in an actual file system when the program was installed by defining a "logical pathname translation" that translates logical pathnames matching certain wildcards to pathnames representing files in the file system, so-called physical pathnames. They have their uses in certain situations, but you can get pretty far without worrying about them.

7Many Unix-based implementations treat filenames whose last element starts with a dot and don't contain any other dots specially, putting the whole element, with the dot, in the name component and leaving the type component NIL.

(pathname-name (pathname "/foo/.emacs")) ==> ".emacs" (pathname-type (pathname "/foo/.emacs")) ==> NIL

However, not all implementations follow this convention; some will create a pathname with "" as the name and emacs as the type.

8The name returned by FILE-NAMESTRING also includes the version component on file systems that use it.

9The host component may not default to NIL, but if not, it will be an opaque implementation-defined value.

10For absolutely maximum portability, you should really write this:

(make-pathname :type "html" :version :newest :defaults input-file)

Without the :version argument, on a file system with built-in versioning, the output pathname would inherit its version number from the input file which isn't likely to be right--if the input file has been saved many times it will have a much higher version number than the generated HTML file. On implementations without file versioning, the :version argument should be ignored. It's up to you if you care that much about portability.

11See Chapter 19 for more on handling errors.

12For applications that need access to other file attributes on a particular operating system or file system, libraries provide bindings to underlying C system calls. The Osicat library at http://common-lisp.net/project/osicat/ provides a simple API built using the Universal Foreign Function Interface (UFFI), which should run on most Common Lisps that run on a POSIX operating system.

13The number of bytes and characters in a file can differ even if you're not using a multibyte character encoding. Because character streams also translate platform-specific line endings to a single #\Newline character, on Windows (which uses CRLF as its line ending) the number of characters will typically be smaller than the number of bytes. If you really have to know the number of characters in a file, you have to bite the bullet and write something like this:

(with-open-file (in filename) (loop while (read-char in nil) count t))

or maybe something more efficient like this:

(with-open-file (in filename) (let ((scratch (make-string 4096))) (loop for read = (read-sequence scratch in) while (plusp read) sum read)))

14MAKE-BROADCAST-STREAM can make a data black hole by calling it with no arguments.

15The biggest missing piece in Common Lisp's standard I/O facilities is a way for users to define new stream classes. There are, however, two de facto standards for user-defined streams. During the Common Lisp standardization, David Gray of Texas Instruments wrote a draft proposal for an API to allow users to define new stream classes. Unfortunately, there wasn't time to work out all the issues raised by his draft to include it in the language standard. However, many implementations support some form of so-called Gray Streams, basing their API on Gray's draft proposal. Another, newer API, called Simple Streams, has been developed by Franz and included in Allegro Common Lisp. It was designed to improve the performance of user-defined streams relative to Gray Streams and has been adopted by some of the open-source Common Lisp implementations.

Copyright © 2003-2005, Peter Seibel

15. Practical: A Portable Pathname Library

As I discussed in the previous chapter, Common Lisp provides an abstraction, the pathname, that's supposed to insulate you from the details of how different operating systems and file systems name files. Pathnames provide a useful API for manipulating names as names, but when it comes to the functions that actually interact with the file system, things get a bit hairy.

The root of the problem, as I mentioned, is that the pathname abstraction was designed to represent filenames on a much wider variety of file systems than are commonly used now. Unfortunately, by making pathnames abstract enough to account for a wide variety of file systems, Common Lisp's designers left implementers with a fair number of choices to make about how exactly to map the pathname abstraction onto any particular file system. Consequently, different implementers, each implementing the pathname abstraction for the same file system, just by making different choices at a few key junctions, could end up with conforming implementations that nonetheless provide different behavior for several of the main pathname-related functions.

However, one way or another, all implementations provide the same basic functionality, so it's not too hard to write a library that provides a consistent interface for the most common operations across different implementations. That's your task for this chapter. In addition to giving you several useful functions that you'll use in future chapters, writing this library will give you a chance to learn how to write code that deals with differences between implementations.

The API

The basic operations the library will support will be getting a list of files in a directory and determining whether a file or directory with a given name exists. You'll also write a function for recursively walking a directory hierarchy, calling a given function for each pathname in the tree.

In theory, these directory listing and file existence operations are already provided by the standard functions DIRECTORY and PROBE-FILE. However, as you'll see, there are enough different ways to implement these functions--all within the bounds of valid interpretations of the language standard--that you'll want to write new functions that provide a consistent behavior across implementations.

*FEATURES* and Read-Time Conditionalization

Before you can implement this API in a library that will run correctly on multiple Common Lisp implementations, I need to show you the mechanism for writing implementation-specific code.

While most of the code you write can be "portable" in the sense that it will run the same on any conforming Common Lisp implementation, you may occasionally need to rely on implementation-specific functionality or to write slightly different bits of code for different implementations. To allow you to do so without totally destroying the portability of your code, Common Lisp provides a mechanism, called read-time conditionalization, that allows you to conditionally include code based on various features such as what implementation it's being run in.

The mechanism consists of a variable *FEATURES* and two extra bits of syntax understood by the Lisp reader. *FEATURES* is a list of symbols; each symbol represents a "feature" that's present in the implementation or on the underlying platform. These symbols are then used in feature expressions that evaluate to true or false depending on whether the symbols in the expression are present in *FEATURES*. The simplest feature expression is a single symbol; the expression is true if the symbol is in *FEATURES* and false if it isn't. Other feature expressions are boolean expressions built out of NOT, AND, and OR operators. For instance, if you wanted to conditionalize some code to be included only if the features foo and bar were present, you could write the feature expression (and foo bar).

The reader uses feature expressions in conjunction with two bits of syntax, #+ and #-. When the reader sees either of these bits of syntax, it first reads a feature expression and then evaluates it as I just described. When a feature expression following a #+ is true, the reader reads the next expression normally. Otherwise it skips the next expression, treating it as whitespace. #- works the same way except it reads the form if the feature expression is false and skips it if it's true.

The initial value of *FEATURES* is implementation dependent, and what functionality is implied by the presence of any given symbol is likewise defined by the implementation. However, all implementations include at least one symbol that indicates what implementation it is. For instance, Allegro Common Lisp includes the symbol :allegro, CLISP includes :clisp, SBCL includes :sbcl, and CMUCL includes :cmu. To avoid dependencies on packages that may or may not exist in different implementations, the symbols in *FEATURES* are usually keywords, and the reader binds *PACKAGE* to the KEYWORD package while reading feature expressions. Thus, a name with no package qualification will be read as a keyword symbol. So, you could write a function that behaves slightly differently in each of the implementations just mentioned like this:

(defun foo () #+allegro (do-one-thing) #+sbcl (do-another-thing) #+clisp (something-else) #+cmu (yet-another-version) #-(or allegro sbcl clisp cmu) (error "Not implemented"))

In Allegro that code will be read as if it had been written like this:

(defun foo () (do-one-thing))

while in SBCL the reader will read this:

(defun foo () (do-another-thing))

while in an implementation other than one of the ones specifically conditionalized, it will read this:

(defun foo () (error "Not implemented"))

Because the conditionalization happens in the reader, the compiler doesn't even see expressions that are skipped.1 This means you pay no runtime cost for having different versions for different implementations. Also, when the reader skips conditionalized expressions, it doesn't bother interning symbols, so the skipped expressions can safely contain symbols from packages that may not exist in other implementations.

Packaging the Library

Speaking of packages, if you download the complete code for this library, you'll see that it's defined in a new package, com.gigamonkeys.pathnames. I'll discuss the details of defining and using packages in Chapter 21. For now you should note that some implementations provide their own packages that contain functions with some of the same names as the ones you'll define in this chapter and make those names available in the CL-USER package. Thus, if you try to define the functions from this library while in the CL-USER package, you may get errors or warnings about clobbering existing definitions. To avoid this possibility, you can create a file called packages.lisp with the following contents:

(in-package :cl-user)

(defpackage :com.gigamonkeys.pathnames (:use :common-lisp) (:export :list-directory :file-exists-p :directory-pathname-p :file-pathname-p :pathname-as-directory :pathname-as-file :walk-directory :directory-p :file-p))

and LOAD it. Then at the REPL or at the top of the file where you type the definitions from this chapter, type the following expression:

(in-package :com.gigamonkeys.pathnames)

In addition to avoiding name conflicts with symbols already available in CL-USER, packaging the library this way also makes it easier to use in other code, as you'll see in several future chapters.

Listing a Directory

You can implement the function for listing a single directory, list-directory, as a thin wrapper around the standard function DIRECTORY. DIRECTORY takes a special kind of pathname, called a wild pathname, that has one or more components containing the special value :wild and returns a list of pathnames representing files in the file system that match the wild pathname.2 The matching algorithm--like most things having to do with the interaction between Lisp and a particular file system--isn't defined by the language standard, but most implementations on Unix and Windows follow the same basic scheme.

The DIRECTORY function has two problems that you need to address with list-directory. The main one is that certain aspects of its behavior differ fairly significantly between different Common Lisp implementations, even on the same operating system. The other is that while DIRECTORY provides a powerful interface for listing files, to use it properly requires understanding some rather subtle points about the pathname abstraction. Between these subtleties and the idiosyncrasies of different implementations, actually writing portable code that uses DIRECTORY to do something as simple as listing all the files and subdirectories in a single directory can be a frustrating experience. You can deal with those subtleties and idiosyncrasies once and for all, by writing list-directory, and forget them thereafter.

One subtlety I discussed in Chapter 14 is the two ways to represent the name of a directory as a pathname: directory form and file form.

To get DIRECTORY to return a list of files in /home/peter/, you need to pass it a wild pathname whose directory component is the directory you want to list and whose name and type components are :wild. Thus, to get a listing of the files in /home/peter/, it might seem you could write this:

(directory (make-pathname :name :wild :type :wild :defaults home-dir))

where home-dir is a pathname representing /home/peter/. This would work if home-dir were in directory form. But if it were in file form--for example, if it had been created by parsing the namestring "/home/peter"--then that same expression would list all the files in /home since the name component "peter" would be replaced with :wild.

To avoid having to worry about explicitly converting between representations, you can define list-directory to accept a nonwild pathname in either form, which it will then convert to the appropriate wild pathname.

To help with this, you should define a few helper functions. One, component-present-p, will test whether a given component of a pathname is "present," meaning neither NIL nor the special value :unspecific.3 Another, directory-pathname-p, tests whether a pathname is already in directory form, and the third, pathname-as-directory, converts any pathname to a directory form pathname.

(defun component-present-p (value) (and value (not (eql value :unspecific)))) (defun directory-pathname-p (p) (and (not (component-present-p (pathname-name p))) (not (component-present-p (pathname-type p))) p)) (defun pathname-as-directory (name) (let ((pathname (pathname name))) (when (wild-pathname-p pathname) (error "Can't reliably convert wild pathnames.")) (if (not (directory-pathname-p name)) (make-pathname :directory (append (or (pathname-directory pathname) (list :relative)) (list (file-namestring pathname))) :name nil :type nil :defaults pathname) pathname)))

Now it seems you could generate a wild pathname to pass to DIRECTORY by calling MAKE-PATHNAME with a directory form name returned by pathname-as-directory. Unfortunately, it's not quite that simple, thanks to a quirk in CLISP's implementation of DIRECTORY. In CLISP, DIRECTORY won't return files with no extension unless the type component of the wildcard is NIL rather than :wild. So you can define a function, directory-wildcard, that takes a pathname in either directory or file form and returns a proper wildcard for the given implementation using read-time conditionalization to make a pathname with a :wild type component in all implementations except for CLISP and NIL in CLISP.

(defun directory-wildcard (dirname) (make-pathname :name :wild :type #-clisp :wild #+clisp nil :defaults (pathname-as-directory dirname)))

Note how each read-time conditional operates at the level of a single expression After #-clisp, the expression :wild is either read or skipped; likewise, after #+clisp, the NIL is read or skipped.

Now you can take a first crack at the list-directory function.

(defun list-directory (dirname) (when (wild-pathname-p dirname) (error "Can only list concrete directory names.")) (directory (directory-wildcard dirname)))

As it stands, this function would work in SBCL, CMUCL, and LispWorks. Unfortunately, a couple more implementation differences remain to be smoothed over. One is that not all implementations will return subdirectories of the given directory. Allegro, SBCL, CMUCL, and LispWorks do. OpenMCL doesn't by default but will if you pass DIRECTORY a true value via the implementation-specific keyword argument :directories. CLISP's DIRECTORY returns subdirectories only when it's passed a wildcard pathname with :wild as the last element of the directory component and NIL name and type components. In this case, it returns only subdirectories, so you'll need to call DIRECTORY twice with different wildcards and combine the results.

Once you get all the implementations returning directories, you'll discover they can also differ in whether they return the names of directories in directory or file form. You want list-directory to always return directory names in directory form so you can differentiate subdirectories from regular files based on just the name. Except for Allegro, all the implementations this library will support do that. Allegro, on the other hand, requires you to pass DIRECTORY the implementation-specific keyword argument :directories-are-files NIL to get it to return directories in file form.

Once you know how to make each implementation do what you want, actually writing list-directory is simply a matter of combining the different versions using read-time conditionals.

(defun list-directory (dirname) (when (wild-pathname-p dirname) (error "Can only list concrete directory names.")) (let ((wildcard (directory-wildcard dirname))) #+(or sbcl cmu lispworks) (directory wildcard) #+openmcl (directory wildcard :directories t) #+allegro (directory wildcard :directories-are-files nil) #+clisp (nconc (directory wildcard) (directory (clisp-subdirectories-wildcard wildcard))) #-(or sbcl cmu lispworks openmcl allegro clisp) (error "list-directory not implemented")))

The function clisp-subdirectories-wildcard isn't actually specific to CLISP, but since it isn't needed by any other implementation, you can guard its definition with a read-time conditional. In this case, since the expression following the #+ is the whole DEFUN, the whole function definition will be included or not, depending on whether clisp is present in *FEATURES*.

#+clisp (defun clisp-subdirectories-wildcard (wildcard) (make-pathname :directory (append (pathname-directory wildcard) (list :wild)) :name nil :type nil :defaults wildcard))

Testing a File's Existence

To replace PROBE-FILE, you can define a function called file-exists-p. It should accept a pathname and return an equivalent pathname if the file exists and NIL if it doesn't. It should be able to accept the name of a directory in either directory or file form but should always return a directory form pathname if the file exists and is a directory. This will allow you to use file-exists-p, along with directory-pathname-p, to test whether an arbitrary name is the name of a file or directory.

In theory, file-exists-p is quite similar to the standard function PROBE-FILE; indeed, in several implementations--SBCL, LispWorks, and OpenMCL--PROBE-FILE already gives you the behavior you want for file-exists-p. But not all implementations of PROBE-FILE behave quite the same.

Allegro and CMUCL's PROBE-FILE functions are close to what you need--they will accept the name of a directory in either form but, instead of returning a directory form name, simply return the name in the same form as the argument it was passed. Luckily, if passed the name of a nondirectory in directory form, they return NIL. So with those implementations you can get the behavior you want by first passing the name to PROBE-FILE in directory form--if the file exists and is a directory, it will return the directory form name. If that call returns NIL, then you try again with a file form name.

CLISP, on the other hand, once again has its own way of doing things. Its PROBE-FILE immediately signals an error if passed a name in directory form, regardless of whether a file or directory exists with that name. It also signals an error if passed a name in file form that's actually the name of a directory. For testing whether a directory exists, CLISP provides its own function: probe-directory (in the ext package). This is almost the mirror image of PROBE-FILE: it signals an error if passed a name in file form or if passed a name in directory form that happens to name a file. The only difference is it returns T rather than a pathname when the named directory exists.

But even in CLISP you can implement the desired semantics by wrapping the calls to PROBE-FILE and probe-directory in IGNORE-ERRORS.4

(defun file-exists-p (pathname) #+(or sbcl lispworks openmcl) (probe-file pathname) #+(or allegro cmu) (or (probe-file (pathname-as-directory pathname)) (probe-file pathname)) #+clisp (or (ignore-errors (probe-file (pathname-as-file pathname))) (ignore-errors (let ((directory-form (pathname-as-directory pathname))) (when (ext:probe-directory directory-form) directory-form)))) #-(or sbcl cmu lispworks openmcl allegro clisp) (error "file-exists-p not implemented"))

The function pathname-as-file that you need for the CLISP implementation of file-exists-p is the inverse of the previously defined pathname-as-directory, returning a pathname that's the file form equivalent of its argument. This function, despite being needed here only by CLISP, is generally useful, so define it for all implementations and make it part of the library.

(defun pathname-as-file (name) (let ((pathname (pathname name))) (when (wild-pathname-p pathname) (error "Can't reliably convert wild pathnames.")) (if (directory-pathname-p name) (let* ((directory (pathname-directory pathname)) (name-and-type (pathname (first (last directory))))) (make-pathname :directory (butlast directory) :name (pathname-name name-and-type) :type (pathname-type name-and-type) :defaults pathname)) pathname)))

Walking a Directory Tree

Finally, to round out this library, you can implement a function called walk-directory. Unlike the functions defined previously, this function doesn't need to do much of anything to smooth over implementation differences; it just needs to use the functions you've already defined. However, it's quite handy, and you'll use it several times in subsequent chapters. It will take the name of a directory and a function and call the function on the pathnames of all the files under the directory, recursively. It will also take two keyword arguments: :directories and :test. When :directories is true, it will call the function on the pathnames of directories as well as regular files. The :test argument, if provided, specifies another function that's invoked on each pathname before the main function is; the main function will be called only if the test function returns true.

(defun walk-directory (dirname fn &key directories (test (constantly t))) (labels ((walk (name) (cond ((directory-pathname-p name) (when (and directories (funcall test name)) (funcall fn name)) (dolist (x (list-directory name)) (walk x))) ((funcall test name) (funcall fn name))))) (walk (pathname-as-directory dirname))))

Now you have a useful library of functions for dealing with pathnames. As I mentioned, these functions will come in handy in later chapters, particularly Chapters 23 and 27, where you'll use walk-directory to crawl through directory trees containing spam messages and MP3 files. But before we get to that, though, I need to talk about object orientation, the topic of the next two chapters.

* * *

1One slightly annoying consequence of the way read-time conditionalization works is that there's no easy way to write a fall-through case. For example, if you add support for another implementation to foo by adding another expression guarded with #+, you need to remember to also add the same feature to the or feature expression after the #- or the ERROR form will be evaluated after your new code runs.

2Another special value, :wild-inferiors, can appear as part of the directory component of a wild pathname, but you won't need it in this chapter.

3Implementations are allowed to return :unspecific instead of NIL as the value of pathname components in certain situations such as when the component isn't used by that implementation.

4This is slightly broken in the sense that if PROBE-FILE signals an error for some other reason, this code will interpret it incorrectly. Unfortunately, the CLISP documentation doesn't specify what errors might be signaled by PROBE-FILE and probe-directory, and experimentation seems to show that they signal simple-file-errors in most erroneous situations.

Copyright © 2003-2005, Peter Seibel

16. Object Reorientation: Generic Functions

Because the invention of Lisp predated the rise of object-oriented programming by a couple decades,1 new Lispers are sometimes surprised to discover what a thoroughly object-oriented language Common Lisp is. Common Lisp's immediate predecessors were developed at a time when object orientation was an exciting new idea and there were many experiments with ways to incorporate the ideas of object orientation, especially as manifested in Smalltalk, into Lisp. As part of the Common Lisp standardization, a synthesis of several of these experiments emerged under the name Common Lisp Object System, or CLOS. The ANSI standard incorporated CLOS into the language, so it no longer really makes sense to speak of CLOS as a separate entity.

The features CLOS contributed to Common Lisp range from those that can hardly be avoided to relatively esoteric manifestations of Lisp's language-as-language-building-tool philosophy. Complete coverage of all these features is beyond the scope of this book, but in this chapter and the next I'll describe the bread-and-butter features and give an overview of Common Lisp's approach to objects.

You should note at the outset that Common Lisp's object system offers a fairly different embodiment of the principles of object orientation than many other languages. If you have a deep understanding of the fundamental ideas behind object orientation, you'll likely appreciate the particularly powerful and general way Common Lisp manifests those ideas. On the other hand, if your experience with object orientation has been largely with a single language, you may find Common Lisp's approach somewhat foreign; you should try to avoid assuming that there's only one way for a language to support object orientation.2 If you have little object-oriented programming experience, you should have no trouble understanding the explanations here, though it may help to ignore the occasional comparisons to the way other languages do things.

Generic Functions and Classes

The fundamental idea of object orientation is that a powerful way to organize a program is to define data types and then associate operations with those data types. In particular, you want to be able to invoke an operation and have the exact behavior determined by the type of the object or objects on which the operation was invoked. The classic example used, seemingly by all introductions to object orientation, is an operation draw that can be applied to objects representing various geometric shapes. Different implementations of the draw operation can be provided for drawing circles, triangles, and squares, and a call to draw will actually result in drawing a circle, triangle, or square, depending on the type of the object to which the draw operation is applied. The different implementations of draw are defined separately, and new versions can be defined that draw other shapes without having to change the code of either the caller or any of the other draw implementations. This feature of object orientation goes by the fancy Greek name polymorphism, meaning "many forms," because a single conceptual operation, such as drawing an object, can take many different concrete forms.

Common Lisp, like most object-oriented languages today, is class-based; all objects are instances of a particular class.3 The class of an object determines its representation--built-in classes such as NUMBER and STRING have opaque representations accessible only via the standard functions for manipulating those types, while instances of user-defined classes, as you'll see in the next chapter, consist of named parts called slots.

Classes are arranged in a hierarchy, a taxonomy for all objects. A class can be defined as a subclass of other classes, called its superclasses. A class inherits part of its definition from its superclasses and instances of a class are also considered instances of the superclasses. In Common Lisp, the hierarchy of classes has a single root, the class T, which is a direct or indirect superclass of every other class. Thus, every datum in Common Lisp is an instance of T.4 Common Lisp also supports multiple inheritance--a single class can have multiple direct superclasses.

Outside the Lisp family, almost all object-oriented languages follow the basic pattern established by Simula of having behavior associated with classes through methods or member functions that belong to a particular class. In these languages, a method is invoked on a particular object, and the class of that object determines what code runs. This model of method invocation is called--after the Smalltalk terminology--message passing. Conceptually, method invocation in a message-passing system starts by sending a message containing the name of the method to run and any arguments to the object on which the method is being invoked. The object then uses its class to look up the method associated with the name in the message and runs it. Because each class can have its own method for a given name, the same message, sent to different objects, can invoke different methods.

Early Lisp object systems worked in a similar way, providing a special function SEND that could be used to send a message to a particular object. However, this wasn't entirely satisfactory, as it made method invocations different from normal function calls. Syntactically method invocations were written like this:

(send object 'foo)

rather than like this:

(foo object)

More significantly, because methods weren't functions, they couldn't be passed as arguments to higher-order functions such as MAPCAR; if one wanted to call a method on all the elements of a list with MAPCAR, one had to write this:

(mapcar #'(lambda (object) (send object 'foo)) objects)

rather than this:

