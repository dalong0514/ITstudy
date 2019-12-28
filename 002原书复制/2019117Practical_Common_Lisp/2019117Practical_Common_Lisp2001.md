Now you can switch to the new package using IN-PACKAGE.10 Notice how the prompt changes--the exact form is determined by the development environment, but in SLIME the default prompt consists of an abbreviated version of the package name.

CL-USER> (in-package :com.gigamonkeys.email-db) #<The COM.GIGAMONKEYS.EMAIL-DB package> EMAIL-DB>

You can define a new hello-world in this package:

EMAIL-DB> (defun hello-world () (format t "hello from EMAIL-DB package~%")) HELLO-WORLD

And test it, like this:

EMAIL-DB> (hello-world) hello from EMAIL-DB package NIL

Now switch back to CL-USER.

EMAIL-DB> (in-package :cl-user) #<The COMMON-LISP-USER package> CL-USER>

And the old function is undisturbed.

CL-USER> (hello-world) hello, world NIL

Packaging Reusable Libraries

While working on the e-mail database, you might write several functions related to storing and retrieving text that don't have anything in particular to do with e-mail. You might realize that those functions could be useful in other programs and decide to repackage them as a library. You should define a new package, but this time you'll export certain names to make them available to other packages.

(defpackage :com.gigamonkeys.text-db (:use :common-lisp) (:export :open-db :save :store))

Again, you use the COMMON-LISP package, because you'll need access to standard functions within COM.GIGAMONKEYS.TEXT-DB. The :export clause specifies names that will be external in COM.GIGAMONKEYS.TEXT-DB and thus accessible in packages that :use it. Therefore, after you've defined this package, you can change the definition of the main application package to the following:

(defpackage :com.gigamonkeys.email-db (:use :common-lisp :com.gigamonkeys.text-db))

Now code written in COM.GIGAMONKEYS.EMAIL-DB can use unqualified names to refer to the exported symbols from both COMMON-LISP and COM.GIGAMONKEYS.TEXT-DB. All other names will continue to be interned directly in the COM.GIGAMONKEYS.EMAIL-DB package.

Importing Individual Names

Now suppose you find a third-party library of functions for manipulating e-mail messages. The names used in the library's API are exported from the package COM.ACME.EMAIL, so you could :use that package to get easy access to those names. But suppose you need to use only one function from this library, and other exported symbols conflict with names you already use (or plan to use) in our own code.11 In this case, you can import the one symbol you need with an :import-from clause in the DEFPACKAGE. For instance, if the name of the function you want to use is parse-email-address, you can change the DEFPACKAGE to this:

(defpackage :com.gigamonkeys.email-db (:use :common-lisp :com.gigamonkeys.text-db) (:import-from :com.acme.email :parse-email-address))

Now anywhere the name parse-email-address appears in code read in the COM.GIGAMONKEYS.EMAIL-DB package, it will be read as the symbol from COM.ACME.EMAIL. If you need to import more than one symbol from a single package, you can include multiple names after the package name in a single :import-from clause. A DEFPACKAGE can also include multiple :import-from clauses in order to import symbols from different packages.

Occasionally you'll run into the opposite situation--a package may export a bunch of names you want to use and a few you don't. Rather than listing all the symbols you do want to use in an :import-from clause, you can instead :use the package and then list the names you don't want to inherit in a :shadow clause. For instance, suppose the COM.ACME.TEXT package exports a bunch of names of functions and classes used in text processing. Further suppose that most of these functions and classes are ones you'll want to use in your code, but one of the names, build-index, conflicts with a name you've already used. You can make the build-index from COM.ACME.TEXT inaccessible by shadowing it.

(defpackage :com.gigamonkeys.email-db (:use :common-lisp :com.gigamonkeys.text-db :com.acme.text) (:import-from :com.acme.email :parse-email-address) (:shadow :build-index))

The :shadow clause causes a new symbol named BUILD-INDEX to be created and added directly to COM.GIGAMONKEYS.EMAIL-DB's name-to-symbol map. Now if the reader reads the name BUILD-INDEX, it will translate it to the symbol in COM.GIGAMONKEYS.EMAIL-DB's map, rather than the one that would otherwise be inherited from COM.ACME.TEXT. The new symbol is also added to a shadowing symbols list that's part of the COM.GIGAMONKEYS.EMAIL-DB package, so if you later use another package that also exports a BUILD-INDEX symbol, the package system will know there's no conflict--that you want the symbol from COM.GIGAMONKEYS.EMAIL-DB to be used rather than any other symbols with the same name inherited from other packages.

A similar situation can arise if you want to use two packages that export the same name. In this case the reader won't know which inherited name to use when it reads the textual name. In such situations you must resolve the ambiguity by shadowing the conflicting names. If you don't need to use the name from either package, you could shadow the name with a :shadow clause, creating a new symbol with the same name in your package. But if you actually want to use one of the inherited symbols, then you need to resolve the ambiguity with a :shadowing-import-from clause. Like an :import-from clause, a :shadowing-import-from clause consists of a package name followed by the names to import from that package. For instance, if COM.ACME.TEXT exports a name SAVE that conflicts with the name exported from COM.GIGAMONKEYS.TEXT-DB, you could resolve the ambiguity with the following DEFPACKAGE:

(defpackage :com.gigamonkeys.email-db (:use :common-lisp :com.gigamonkeys.text-db :com.acme.text) (:import-from :com.acme.email :parse-email-address) (:shadow :build-index) (:shadowing-import-from :com.gigamonkeys.text-db :save))

Packaging Mechanics

That covers the basics of how to use packages to manage namespaces in several common situations. However, another level of how to use packages is worth discussing--the raw mechanics of how to organize code that uses different packages. In this section I'll discuss a few rules of thumb about how to organize code--where to put your DEFPACKAGE forms relative to the code that uses your packages via IN-PACKAGE.

Because packages are used by the reader, a package must be defined before you can LOAD or COMPILE-FILE a file that contains an IN-PACKAGE expression switching to that package. Packages also must be defined before other DEFPACKAGE forms can refer to them. For instance, if you're going to :use COM.GIGAMONKEYS.TEXT-DB in COM.GIGAMONKEYS.EMAIL-DB, then COM.GIGAMONKEYS.TEXT-DB's DEFPACKAGE must be evaluated before the DEFPACKAGE of COM.GIGAMONKEYS.EMAIL-DB.

The best first step toward making sure packages exist when they need to is to put all your DEFPACKAGEs in files separate from the code that needs to be read in those packages. Some folks like to create a foo-package.lisp file for each individual package, and others create a single packages.lisp that contains all the DEFPACKAGE forms for a group of related packages. Either approach is reasonable, though the one-file-per-package approach also requires that you arrange to load the individual files in the right order according to the interpackage dependencies.

Either way, once all the DEFPACKAGE forms have been separated from the code that will be read in the packages they define, you can arrange to LOAD the files containing the DEFPACKAGEs before you compile or load any of the other files. For simple programs you can do this by hand: simply LOAD the file or files containing the DEFPACKAGE forms, possibly compiling them with COMPILE-FILE first. Then LOAD the files that use those packages, again optionally compiling them first with COMPILE-FILE. Note, however, that the packages don't exist until you LOAD the package definitions, either the source or the files produced by COMPILE-FILE. Thus, if you're compiling everything, you must still LOAD all the package definitions before you can COMPILE-FILE any files to be read in the packages.

Doing these steps by hand will get tedious after a while. For simple programs you can automate the steps by writing a file, load.lisp, that contains the appropriate LOAD and COMPILE-FILE calls in the right order. Then you can just LOAD that file. For more complex programs you'll want to use a system definition facility to manage loading and compiling files in the right order.12

The other key rule of thumb is that each file should contain exactly one IN-PACKAGE form, and it should be the first form in the file other than comments. Files containing DEFPACKAGE forms should start with (in-package "COMMON-LISP-USER"), and all other files should contain an IN-PACKAGE of one of your packages.

If you violate this rule and switch packages in the middle of a file, you'll confuse human readers who don't notice the second IN-PACKAGE. Also, many Lisp development environments, particularly Emacs-based ones such as SLIME, look for an IN-PACKAGE to determine the package they should use when communicating with Common Lisp. Multiple IN-PACKAGE forms per file may confuse these tools as well.

On the other hand, it's fine to have multiple files read in the same package, each with an identical IN-PACKAGE form. It's just a matter of how you like to organize your code.

The other bit of packaging mechanics has to do with how to name packages. Package names live in a flat namespace--package names are just strings, and different packages must have textually distinct names. Thus, you have to consider the possibility of conflicts between package names. If you're using only packages you developed yourself, then you can probably get away with using short names for your packages. But if you're planning to use third-party libraries or to publish your code for use by other programmers, then you need to follow a naming convention that will minimize the possibility of name collisions between different packages. Many Lispers these days are adopting Java-style names, like the ones used in this chapter, consisting of a reversed Internet domain name followed by a dot and a descriptive string.

Package Gotchas

Once you're familiar with packages, you won't spend a bunch of time thinking about them. There's just not that much to them. However, a couple of gotchas that bite most new Lisp programmers make the package system seem more complicated and unfriendly than it really is.

The number-one gotcha arises most commonly when playing around at the REPL. You'll be looking at some library that defines certain interesting functions. You'll try to call one of the functions like this:

CL-USER> (foo)

and get dropped into the debugger with this error:

attempt to call `FOO' which is an undefined function. [Condition of type UNDEFINED-FUNCTION] Restarts: 0: [TRY-AGAIN] Try calling FOO again. 1: [RETURN-VALUE] Return a value instead of calling FOO. 2: [USE-VALUE] Try calling a function other than FOO. 3: [STORE-VALUE] Setf the symbol-function of FOO and call it again. 4: [ABORT] Abort handling SLIME request. 5: [ABORT] Abort entirely from this (lisp) process.

Ah, of course--you forgot to use the library's package. So you quit the debugger and try to USE-PACKAGE the library's package in order to get access to the name FOO so you can call the function.

CL-USER> (use-package :foolib)

But that drops you back into the debugger with this error message:

Using package `FOOLIB' results in name conflicts for these symbols: FOO [Condition of type PACKAGE-ERROR] Restarts: 0: [CONTINUE] Unintern the conflicting symbols from the `COMMON-LISP-USER' package. 1: [ABORT] Abort handling SLIME request. 2: [ABORT] Abort entirely from this (lisp) process.

Huh? The problem is the first time you called foo, the reader read the name foo and interned it in CL-USER before the evaluator got hold of it and discovered that this newly interned symbol isn't the name of a function. This new symbol then conflicts with the symbol of the same name exported from the FOOLIB package. If you had remembered to USE-PACKAGE FOOLIB before you tried to call foo, the reader would have read foo as the inherited symbol and not interned a foo symbol in CL-USER.

However, all isn't lost, because the first restart offered by the debugger will patch things up in just the right way: it will unintern the foo symbol from COMMON-LISP-USER, putting the CL-USER package back to the state it was in before you called foo, allowing the USE-PACKAGE to proceed and allowing for the inherited foo to be available in CL-USER.

This kind of problem can also occur when loading and compiling files. For instance, if you defined a package, MY-APP, for code that was going to use functions with names from the FOOLIB package, but forgot to :use FOOLIB, when you compile the files with an (in-package :my-app) in them, the reader will intern new symbols in MY-APP for the names that were supposed to be read as symbols from FOOLIB. When you try to run the compiled code, you'll get undefined function errors. If you then try to redefine the MY-APP package to :use FOOLIB, you'll get the conflicting symbols error. The solution is the same: select the restart to unintern the conflicting symbols from MY-APP. You'll then need to recompile the code in the MY-APP package so it will refer to the inherited names.

The next gotcha is essentially the reverse of the first gotcha. In this case, you'd have defined a package--again, let's say it's MY-APP--that uses another package, say, FOOLIB. Now you start writing code in the MY-APP package. Although you used FOOLIB in order to be able to refer to the foo function, FOOLIB may export other symbols as well. If you use one of those exported symbols--say, bar--as the name of a function in your own code, Lisp won't complain. Instead, the name of your function will be the symbol exported by FOOLIB, which will clobber the definition of bar from FOOLIB.

This gotcha is more insidious because it doesn't cause an error--from the evaluator's point of view it's just being asked to associate a new function with an old name, something that's perfectly legal. It's suspect only because the code doing the redefining was read with a different value for *PACKAGE* than the name's package. But the evaluator doesn't necessarily know that. However, in most Lisps you'll get an warning about "redefining BAR, originally defined in?". You should heed those warnings. If you clobber a definition from a library, you can restore it by reloading the library code with LOAD.13

The last package-related gotcha is, by comparison, quite trivial, but it bites most Lisp programmers at least a few times: you define a package that uses COMMON-LISP and maybe a few libraries. Then at the REPL you change to that package to play around. Then you decide to quit Lisp altogether and try to call (quit). However, quit isn't a name from the COMMON-LISP package--it's defined by the implementation in some implementation-specific package that happens to be used by COMMON-LISP-USER. The solution is simple--change packages back to CL-USER to quit. Or use the SLIME REPL shortcut quit, which will also save you from having to remember that in certain Common Lisp implementations the function to quit is exit, not quit.

You're almost done with your tour of Common Lisp. In the next chapter I'll discuss the details of the extended LOOP macro. After that, the rest of the book is devoted to "practicals": a spam filter, a library for parsing binary files, and various parts of a streaming MP3 server with a Web interface.

* * *

1The kind of programming that relies on a symbol data type is called, appropriately enough, symbolic computation. It's typically contrasted to numeric programming. An example of a primarily symbolic program that all programmers should be familiar with is a compiler--it treats the text of a program as symbolic data and translates it into a new form.

2Every package has one official name and zero or more nicknames that can be used anywhere you need to use the package name, such as in package-qualified names or to refer to the package in a DEFPACKAGE or IN-PACKAGE form.

3COMMON-LISP-USER is also allowed to provide access to symbols exported by other implementation-defined packages. While this is intended as a convenience for the user--it makes implementation-specific functionality readily accessible--it can also cause confusion for new Lispers: Lisp will complain about an attempt to redefine some name that isn't listed in the language standard. To see what packages COMMON-LISP-USER inherits symbols from in a particular implementation, evaluate this expression at the REPL:

(mapcar #'package-name (package-use-list :cl-user))

And to find out what package a symbol came from originally, evaluate this:

(package-name (symbol-package 'some-symbol))

with some-symbol replaced by the symbol in question. For instance:

(package-name (symbol-package 'car)) ==> "COMMON-LISP" (package-name (symbol-package 'foo)) ==> "COMMON-LISP-USER"

Symbols inherited from implementation-defined packages will return some other value.

4This is different from the Java package system, which provides a namespace for classes but is also involved in Java's access control mechanism. The non-Lisp language with a package system most like Common Lisp's packages is Perl.

5All the manipulations performed by DEFPACKAGE can also be performed with functions that man- ipulate package objects. However, since a package generally needs to be fully defined before it can be used, those functions are rarely used. Also, DEFPACKAGE takes care of performing all the package manipulations in the right order--for instance, DEFPACKAGE adds symbols to the shadowing list before it tries to use the used packages.

6In many Lisp implementations the :use clause is optional if you want only to :use COMMON-LISP--if it's omitted, the package will automatically inherit names from an implementation-defined list of packages that will usually include COMMON-LISP. However, your code will be more portable if you always explicitly specify the packages you want to :use. Those who are averse to typing can use the package's nickname and write (:use :cl).

7Using keywords instead of strings has another advantage--Allegro provides a "modern mode" Lisp in which the reader does no case conversion of names and in which, instead of a COMMON-LISP package with uppercase names, provides a common-lisp package with lowercase names. Strictly speaking, this Lisp isn't a conforming Common Lisp since all the names in the standard are defined to be uppercase. But if you write your DEFPACKAGE forms using keyword symbols, they will work both in Common Lisp and in this near relative.

8Some folks, instead of keywords, use uninterned symbols, using the #: syntax.

(defpackage #:com.gigamonkeys.email-db (:use #:common-lisp))

This saves a tiny bit of memory by not interning any symbols in the keyword package--the symbol can become garbage after DEFPACKAGE (or the code it expands into) is done with it. However, the difference is so slight that it really boils down to a matter of aesthetics.

9The reason to use IN-PACKAGE instead of just SETFing *PACKAGE* is that IN-PACKAGE expands into code that will run when the file is compiled by COMPILE-FILE as well as when the file is loaded, changing the way the reader reads the rest of the file during compilation.

10In the REPL buffer in SLIME you can also change packages with a REPL shortcut. Type a comma, and then enter change-package at the Command: prompt.

11During development, if you try to :use a package that exports a symbol with the same name as a symbol already interned in the using package, Lisp will signal an error and typically offer you a restart that will unintern the offending symbol from the using package. For more on this, see the section "Package Gotchas."

12The code for the "Practical" chapters, available from this book's Web site, uses the ASDF system definition library. ASDF stands for Another System Definition Facility.

13Some Common Lisp implementations, such as Allegro and SBCL, provide a facility for "locking" the symbols in a particular package so they can be used in defining forms such as DEFUN, DEFVAR, and DEFCLASS only when their home package is the current package.

Copyright © 2003-2005, Peter Seibel

22. LOOP for Black Belts

In Chapter 7 I briefly discussed the extended LOOP macro. As I mentioned then, LOOP provides what is essentially a special-purpose language just for writing iteration constructs.

This might seem like a lot of bother--inventing a whole language just for writing loops. But if you think about the ways loops are used in programs, it actually makes a fair bit of sense. Any program of any size at all will contain quite a number of loops. And while they won't all be the same, they won't all be unique either; patterns will emerge, particularly if you include the code immediately preceding and following the loops--patterns of how things are set up for the loop, patterns in what gets done in the loop proper, and patterns in what gets done after the loop. The LOOP language captures these patterns so you can express them directly.

The LOOP macro has a lot of parts--one of the main complaints of LOOP's detractors is that it's too complex. In this chapter, I'll tackle LOOP head on, giving you a systematic tour of the various parts and how they fit together.

The Parts of a LOOP

You can do the following in a LOOP:

Step variables numerically and over various data structures

Collect, count, sum, minimize, and maximize values seen while looping

Execute arbitrary Lisp expressions

Decide when to terminate the loop

Conditionally do any of these

Additionally, LOOP provides syntax for the following:

Creating local variables for use within the loop

Specifying arbitrary Lisp expressions to run before and after the loop proper

The basic structure of a LOOP is a set of clauses, each of which begins with a loop keyword.1 How each clause is parsed by the LOOP macro depends on the keyword. Some of the main keywords, which you saw in Chapter 7, are for, collecting, summing, counting, do, and finally.

Iteration Control

Most of the so-called iteration control clauses start with the loop keyword for, or its synonym as,2 followed by the name of a variable. What follows after the variable name depends on the type of for clause.

The subclauses of a for clause can iterate over the following:

Ranges of numbers, up or down, by specified intervals

The individual items of a list

The cons cells that make up a list

The elements of a vector, including subtypes such as strings and bit vectors

The pairs of a hash table

The symbols in a package

The results of repeatedly evaluating a given form

A single loop can have multiple for clauses with each clause naming its own variable. When a loop has multiple for clauses, the loop terminates as soon as any for clause reaches its end condition. For instance, the following loop:

(loop for item in list for i from 1 to 10 do (something))

will iterate at most ten times but may stop sooner if list contains fewer than ten items.

Counting Loops

Arithmetic iteration clauses control the number of times the loop body will be executed by stepping a variable over a range of numbers, executing the body once per step. These clauses consist of from one to three of the following prepositional phrases after the for (or as): the from where phrase, the to where phrase, and the by how much phrase.

The from where phrase specifies the initial value of the clause's variable. It consists of one of the prepositions from, downfrom, or upfrom followed by a form, which supplies the initial value (a number).

The to where phrase specifies a stopping point for the loop and consists of one of the prepositions to, upto, below, downto, or above followed by a form, which supplies the stopping point. With upto and downto, the loop body will be terminated (without executing the body again) when the variable passes the stopping point; with below and above, it stops one iteration earlier.The by how much phrase consists of the prepositions by and a form, which must evaluate to a positive number. The variable will be stepped (up or down, as determined by the other phrases) by this amount on each iteration or by one if it's omitted.

You must specify at least one of these prepositional phrases. The defaults are to start at zero, increment the variable by one at each iteration, and go forever or, more likely, until some other clause terminates the loop. You can modify any or all of these defaults by adding the appropriate prepositional phrases. The only wrinkle is that if you want decremental stepping, there's no default from where value, so you must specify one with either from or downfrom. So, the following:

(loop for i upto 10 collect i)

collects the first eleven integers (zero to ten), but the behavior of this:

(loop for i downto -10 collect i) ; wrong

is undefined. Instead, you need to write this:

(loop for i from 0 downto -10 collect i)

Also note that because LOOP is a macro, which runs at compile time, it has to be able to determine the direction to step the variable based solely on the prepositions--not the values of the forms, which may not be known until runtime. So, the following:

(loop for i from 10 to 20 ...)

works fine since the default is incremental stepping. But this:

(loop for i from 20 to 10 ...)

won't know to count down from twenty to ten. Worse yet, it won't give you an error--it will just not execute the loop since i is already greater than ten. Instead, you must write this:

(loop for i from 20 downto 10 ...)

or this:

(loop for i downfrom 20 to 10 ...)

Finally, if you just want a loop that repeats a certain number of times, you can replace a clause of the following form:

for i from 1 to number-form

with a repeat clause like this:

repeat number-form

These clauses are identical in effect except the repeat clause doesn't create an explicit loop variable.

Looping Over Collections and Packages

The for clauses for iterating over lists are much simpler than the arithmetic clauses. They support only two prepositional phrases, in and on.

A phrase of this form:

for var in list-form

steps var over all the elements of the list produced by evaluating list-form.

(loop for i in (list 10 20 30 40) collect i) ==> (10 20 30 40)

Occasionally this clause is supplemented with a by phrase, which specifies a function to use to move down the list. The default is CDR but can be any function that takes a list and returns a sublist. For instance, you could collect every other element of a list with a loop like this:

(loop for i in (list 10 20 30 40) by #'cddr collect i) ==> (10 30)

An on prepositional phrase is used to step var over the cons cells that make up a list.

(loop for x on (list 10 20 30) collect x) ==> ((10 20 30) (20 30) (30))

This phrase too can take a by preposition:

(loop for x on (list 10 20 30 40) by #'cddr collect x) ==> ((10 20 30 40) (30 40))

Looping over the elements of a vector (which includes strings and bit vectors) is similar to looping over the elements of a list except the preposition across is used instead of in.3 For instance:

(loop for x across "abcd" collect x) ==> (#\a #\b #\c #\d)

Iterating over a hash table or package is slightly more complicated because hash tables and packages have different sets of values you might want to iterate over--the keys or values in a hash table and the different kinds of symbols in a package. Both kinds of iteration follow the same pattern. The basic pattern looks like this:

(loop for var being the things in hash-or-package ...)

For hash tables, the possible values for things are hash-keys and hash-values, which cause var to be bound to successive values of either the keys or the values of the hash table. The hash-or-package form is evaluated once to produce a value, which must be a hash table.

