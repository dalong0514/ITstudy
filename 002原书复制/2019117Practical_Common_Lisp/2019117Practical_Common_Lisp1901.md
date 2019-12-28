CATCH and THROW are the dynamic counterparts of BLOCK and RETURN-FROM. That is, you wrap CATCH around a body of code and then use THROW to cause the CATCH form to return immediately with a specified value. The difference is that the association between a CATCH and THROW is established dynamically--instead of a lexically scoped name, the label for a CATCH is an object, called a catch tag, and any THROW evaluated within the dynamic extent of the CATCH that throws that object will unwind the stack back to the CATCH form and cause it to return immediately. Thus, you can write a version of the foo, bar, and baz functions from before using CATCH and THROW instead of BLOCK and RETURN-FROM like this:

(defparameter *obj* (cons nil nil)) ; i.e. some arbitrary object (defun foo () (format t "Entering foo~%") (catch *obj* (format t " Entering CATCH~%") (bar) (format t " Leaving CATCH~%")) (format t "Leaving foo~%")) (defun bar () (format t " Entering bar~%") (baz) (format t " Leaving bar~%")) (defun baz () (format t " Entering baz~%") (throw *obj* nil) (format t " Leaving baz~%"))

Notice how it isn't necessary to pass a closure down the stack--baz can call THROW directly. The result is quite similar to the earlier version.

CL-USER> (foo) Entering foo Entering CATCH Entering bar Entering baz Leaving foo NIL

However, CATCH and THROW are almost too dynamic. In both the CATCH and the THROW, the tag form is evaluated, which means their values are both determined at runtime. Thus, if some code in bar reassigned or rebound *obj*, the THROW in baz wouldn't throw to the same CATCH. This makes CATCH and THROW much harder to reason about than BLOCK and RETURN-FROM. The only advantage, which the version of foo, bar, and baz that use CATCH and THROW demonstrates, is there's no need to pass down a closure in order for low-level code to return from a CATCH--any code that runs within the dynamic extent of a CATCH can cause it to return by throwing the right object.

In older Lisp dialects that didn't have anything like Common Lisp's condition system, CATCH and THROW were used for error handling. However, to keep them manageable, the catch tags were usually just quoted symbols, so you could tell by looking at a CATCH and a THROW whether they would hook up at runtime. In Common Lisp you'll rarely have any call to use CATCH and THROW since the condition system is so much more flexible.

The last special operator related to controlling the stack is another one I've mentioned in passing before--UNWIND-PROTECT. UNWIND-PROTECT lets you control what happens as the stack unwinds--to make sure that certain code always runs regardless of how control leaves the scope of the UNWIND-PROTECT, whether by a normal return, by a restart being invoked, or by any of the ways discussed in this section.9 The basic skeleton of UNWIND-PROTECT looks like this:

(unwind-protect protected-form cleanup-form*)

The single protected-form is evaluated, and then, regardless of how it returns, the cleanup-forms are evaluated. If the protected-form returns normally, then whatever it returns is returned from the UNWIND-PROTECT after the cleanup forms run. The cleanup forms are evaluated in the same dynamic environment as the UNWIND-PROTECT, so the same dynamic variable bindings, restarts, and condition handlers will be visible to code in cleanup forms as were visible just before the UNWIND-PROTECT.

You'll occasionally use UNWIND-PROTECT directly. More often you'll use it as the basis for WITH- style macros, similar to WITH-OPEN-FILE, that evaluate any number of body forms in a context where they have access to some resource that needs to be cleaned up after they're done, regardless of whether they return normally or bail via a restart or other nonlocal exit. For example, if you were writing a database library that defined functions open-connection and close-connection, you might write a macro like this:10

(defmacro with-database-connection ((var &rest open-args) &body body) `(let ((,var (open-connection ,@open-args))) (unwind-protect (progn ,@body) (close-connection ,var))))

which lets you write code like this:

(with-database-connection (conn :host "foo" :user "scott" :password "tiger") (do-stuff conn) (do-more-stuff conn))

and not have to worry about closing the database connection, since the UNWIND-PROTECT will make sure it gets closed no matter what happens in the body of the with-database-connection form.

Multiple Values

Another feature of Common Lisp that I've mentioned in passing--in Chapter 11, when I discussed GETHASH--is the ability for a single form to return multiple values. I'll discuss it in greater detail now. It is, however, slightly misplaced in a chapter on special operators since the ability to return multiple values isn't provided by just one or two special operators but is deeply integrated into the language. The operators you'll most often use when dealing with multiple values are macros and functions, not special operators. But it is the case that the basic ability to get at multiple return values is provided by a special operator, MULTIPLE-VALUE-CALL, upon which the more commonly used MULTIPLE-VALUE-BIND macro is built.

The key thing to understand about multiple values is that returning multiple values is quite different from returning a list--if a form returns multiple values, unless you do something specific to capture the multiple values, all but the primary value will be silently discarded. To see the distinction, consider the function GETHASH, which returns two values: the value found in the hash table and a boolean that's NIL when no value was found. If it returned those two values in a list, every time you called GETHASH you'd have to take apart the list to get at the actual value, regardless of whether you cared about the second return value. Suppose you have a hash table, *h*, that contains numeric values. If GETHASH returned a list, you couldn't write something like this:

(+ (gethash 'a *h*) (gethash 'b *h*))

because + expects its arguments to be numbers, not lists. But because the multiple value mechanism silently discards the secondary return value when it's not wanted, this form works fine.

There are two aspects to using multiple values--returning multiple values and getting at the nonprimary values returned by forms that return multiple values. The starting points for returning multiple values are the functions VALUES and VALUES-LIST. These are regular functions, not special operators, so their arguments are passed in the normal way. VALUES takes a variable number of arguments and returns them as multiple values; VALUES-LIST takes a single list and returns its elements as multiple values. In other words:

(values-list x) === (apply #'values x)

The mechanism by which multiple values are returned is implementation dependent just like the mechanism for passing arguments into functions is. Almost all language constructs that return the value of some subform will "pass through" multiple values, returning all the values returned by the subform. Thus, a function that returns the result of calling VALUES or VALUES-LIST will itself return multiple values--and so will another function whose result comes from calling the first function. And so on.11

But when a form is evaluated in a value position, only the primary value will be used, which is why the previous addition form works the way you'd expect. The special operator MULTIPLE-VALUE-CALL provides the mechanism for getting your hands on the multiple values returned by a form. MULTIPLE-VALUE-CALL is similar to FUNCALL except that while FUNCALL is a regular function and, therefore, can see and pass on only the primary values passed to it, MULTIPLE-VALUE-CALL passes, to the function returned by its first subform, all the values returned by the remaining subforms.

(funcall #'+ (values 1 2) (values 3 4)) ==> 4 (multiple-value-call #'+ (values 1 2) (values 3 4)) ==> 10

However, it's fairly rare that you'll simply want to pass all the values returned by a function onto another function. More likely, you'll want to stash the multiple values in different variables and then do something with them. The MULTIPLE-VALUE-BIND macro, which you saw in Chapter 11, is the most frequently used operator for accepting multiple return values. Its skeleton looks like this:

(multiple-value-bind (variable*) values-form body-form*)

The values-form is evaluated, and the multiple values it returns are bound to the variables. Then the body-forms are evaluated with those bindings in effect. Thus:

(multiple-value-bind (x y) (values 1 2) (+ x y)) ==> 3

Another macro, MULTIPLE-VALUE-LIST, is even simpler--it takes a single form, evaluates it, and collects the resulting multiple values into a list. In other words, it's the inverse of VALUES-LIST.

CL-USER> (multiple-value-list (values 1 2)) (1 2) CL-USER> (values-list (multiple-value-list (values 1 2))) 1 2

However, if you find yourself using MULTIPLE-VALUE-LIST a lot, it may be a sign that some function should be returning a list to start with rather than multiple values.

Finally, if you want to assign multiple values returned by a form to existing variables, you can use VALUES as a SETFable place. For example:

CL-USER> (defparameter *x* nil) *X* CL-USER> (defparameter *y* nil) *Y* CL-USER> (setf (values *x* *y*) (floor (/ 57 34))) 1 23/34 CL-USER> *x* 1 CL-USER> *y* 23/34

EVAL-WHEN

A special operator you'll need to understand in order to write certain kinds of macros is EVAL-WHEN. For some reason, Lisp books often treat EVAL-WHEN as a wizards-only topic. But the only prerequisite to understanding EVAL-WHEN is an understanding of how the two functions LOAD and COMPILE-FILE interact. And understanding EVAL-WHEN will be important as you start writing certain kinds of more sophisticated macros, such as the ones you'll write in Chapters 24 and 31.

I've touched briefly on the relation between LOAD and COMPILE-FILE in previous chapters, but it's worth reviewing again here. The job of LOAD is to load a file and evaluate all the top-level forms it contains. The job of COMPILE-FILE is to compile a source file into a FASL file, which can then be loaded with LOAD such that (load "foo.lisp") and (load "foo.fasl") are essentially equivalent.

Because LOAD evaluates each form before reading the next, the side effects of evaluating forms earlier in the file can affect how forms later in the form are read and evaluated. For instance, evaluating an IN-PACKAGE form changes the value of *PACKAGE*, which will affect the way subsequent forms are read.12 Similarly, a DEFMACRO form early in a file can define a macro that can then be used by code later in the file.13

COMPILE-FILE, on the other hand, normally doesn't evaluate the forms it's compiling; it's when the FASL is loaded that the forms--or their compiled equivalents--will be evaluated. However, COMPILE-FILE must evaluate some forms, such as IN-PACKAGE and DEFMACRO forms, in order to keep the behavior of (load "foo.lisp") and (load "foo.fasl") consistent.

So how do macros such as IN-PACKAGE and DEFMACRO work when processed by COMPILE-FILE? In some pre-Common Lisp versions of Lisp, the file compiler simply knew it should evaluate certain macros in addition to compiling them. Common Lisp avoided the need for such kludges by borrowing the EVAL-WHEN special operator from Maclisp. This operator, as its name suggests, allows you to control when specific bits of code are evaluated. The skeleton of an EVAL-WHEN form looks like this:

(eval-when (situation*) body-form*)

There are three possible situations--:compile-toplevel, :load-toplevel, and :execute--and which ones you specify controls when the body-forms will be evaluated. An EVAL-WHEN with multiple situations is equivalent to several EVAL-WHEN forms, one per situation, each with the same body code. To explain the meaning of the three situations, I'll need to explain a bit about how COMPILE-FILE, which is also referred to as the file compiler, goes about compiling a file.

To explain how COMPILE-FILE compiles EVAL-WHEN forms, I need to introduce a distinction between compiling top-level forms and compiling non-top-level forms. A top-level form is, roughly speaking, one that will be compiled into code that will be run when the FASL is loaded. Thus, all forms that appear directly at the top level of a source file are compiled as top-level forms. Similarly, any forms appearing directly in a top-level PROGN are compiled as top-level forms since the PROGN itself doesn't do anything--it just groups together its subforms, which will be run when the FASL is loaded.14 Similarly, forms appearing directly in a MACROLET or SYMBOL-MACROLET are compiled as top-level forms because after the compiler has expanded the local macros or symbol macros, there will be no remnant of the MACROLET or SYMBOL-MACROLET in the compiled code. Finally, the expansion of a top-level macro form will be compiled as a top-level form.

Thus, a DEFUN appearing at the top level of a source file is a top-level form--the code that defines the function and associates it with its name will run when the FASL is loaded--but the forms within the body of the function, which won't run until the function is called, aren't top-level forms. Most forms are compiled the same when compiled as top-level and non-top-level forms, but the semantics of an EVAL-WHEN depend on whether it's being compiled as a top- level form, compiled as a non-top-level form, or simply evaluated, combined with what situations are listed in its situation list.

The situations :compile-toplevel and :load-toplevel control the meaning of an EVAL-WHEN compiled as a top-level form. When :compile-toplevel is present, the file compiler will evaluate the subforms at compile time. When :load-toplevel is present, it will compile the subforms as top-level forms. If neither of these situations is present in a top-level EVAL-WHEN, the compiler ignores it.

When an EVAL-WHEN is compiled as a non-top-level form, it's either compiled like a PROGN, if the :execute situation is specified, or ignored. Similarly, an evaluated EVAL-WHEN--which includes top-level EVAL-WHENs in a source file processed by LOAD and EVAL-WHENs evaluated at compile time because they appear as subforms of a top-level EVAL-WHEN with the :compile-toplevel situation--is treated like a PROGN if :execute is present and ignored otherwise.

Thus, a macro such as IN-PACKAGE can have the necessary effect at both compile time and when loading from source by expanding into an EVAL-WHEN like the following:

(eval-when (:compile-toplevel :load-toplevel :execute) (setf *package* (find-package "PACKAGE-NAME")))

*PACKAGE* will be set at compile time because of the :compile-toplevel situation, set when the FASL is loaded because of :load-toplevel, and set when the source is loaded because of the :execute.

There are two ways you're most likely to use EVAL-WHEN. One is if you want to write macros that need to save some information at compile time to be used when generating the expansion of other macro forms in the same file. This typically arises with definitional macros where a definition early in a file can affect the code generated for a definition later in the same file. You'll write this kind of macro in Chapter 24.

The other time you might need EVAL-WHEN is if you want to put the definition of a macro and helper functions it uses in the same file as code that uses the macro. DEFMACRO already includes an EVAL-WHEN in its expansion so the macro definition is immediately available to be used later in the file. But DEFUN normally doesn't make function definitions available at compile time. But if you use a macro in the same file as it's defined in, you need the macro and any functions it uses to be defined. If you wrap the DEFUNs of any helper functions used by the macro in an EVAL-WHEN with :compile-toplevel, the definitions will be available when the macro's expansion function runs. You'll probably want to include :load-toplevel and :execute as well since the macros will also need the function definitions after the file is compiled and loaded or if you load the source instead of compiling.

Other Special Operators

The four remaining special operators, LOCALLY, THE, LOAD-TIME-VALUE, and PROGV, all allow you to get at parts of the underlying language that can't be accessed any other way. LOCALLY and THE are part of Common Lisp's declaration system, which is used to communicate things to the compiler that don't affect the meaning of your code but that may help the compiler generate better code--faster, clearer error messages, and so on.15 I'll discuss declarations briefly in Chapter 32.

The other two, LOAD-TIME-VALUE and PROGV, are infrequently used, and explaining the reason why you might ever want to use them would take longer than explaining what they do. So I'll just tell you what they do so you know they're there. Someday you'll hit on one of those rare times when they're just the thing, and then you'll be ready.

LOAD-TIME-VALUE is used, as its name suggests, to create a value that's determined at load time. When the file compiler compiles code that contains a LOAD-TIME-VALUE form, it arranges to evaluate the first subform once, when the FASL is loaded, and for the code containing the LOAD-TIME-VALUE form to refer to that value. In other words, instead of writing this:

(defvar *loaded-at* (get-universal-time)) (defun when-loaded () *loaded-at*)

you can write the following:

(defun when-loaded () (load-time-value (get-universal-time)))

In code not processed by COMPILE-FILE, LOAD-TIME-VALUE is evaluated once when the code is compiled, which may be when you explicitly compile a function with COMPILE or earlier because of implicit compilation performed by the implementation in the course of evaluating the code. In uncompiled code, LOAD-TIME-VALUE evaluates its form each time it's evaluated.

Finally, PROGV creates new dynamic bindings for variables whose names are determined at runtime. This is mostly useful for implementing embedded interpreters for languages with dynamically scoped variables. The basic skeleton is as follows:

(progv symbols-list values-list body-form*)

where symbols-list is a form that evaluates to a list of symbols and values-list is a form that evaluates to a list of values. Each symbol is dynamically bound to the corresponding value, and then the body-forms are evaluated. The difference between PROGV and LET is that because symbols-list is evaluated at runtime, the names of the variables to bind can be determined dynamically. As I say, this isn't something you need to do often.

And that's it for special operators. In the next chapter, I'll get back to hard-nosed practical topics and show you how to use Common Lisp's package system to take control of your namespaces so you can write libraries and applications that can coexist without stomping on each other's names.

* * *

1Of course, if IF wasn't a special operator but some other conditional form, such as COND, was, you could build IF as a macro. Indeed, in many Lisp dialects, starting with McCarthy's original Lisp, COND was the primitive conditional evaluation operator.

2Well, technically those constructs could also expand into a LAMBDA expression since, as I mentioned in Chapter 6, LET could be defined--and was in some earlier Lisps--as a macro that expands into an invocation of an anonymous function.

3Surprising as it may seem, it actually is possible to make anonymous functions recurse. However, you must use a rather esoteric mechanism known as the Y combinator. But the Y combinator is an interesting theoretical result, not a practical programming tool, so is well outside the scope of this book.

4It's not required that WITH-SLOTS be implemented with SYMBOL-MACROLET--in some implementations, WITH-SLOTS may walk the code provided and generate an expansion with x, y, and z already replaced with the appropriate SLOT-VALUE forms. You can see how your implementation does it by evaluating this form:

(macroexpand-1 '(with-slots (x y z) obj (list x y z)))

However, walking the body is much easier for the Lisp implementation to do than for user code; to replace x, y, and z only when they appear in value positions requires a code walker that understands the syntax of all special operators and that recursively expands all macro forms in order to determine whether their expansions include the symbols in value positions. The Lisp implementation obviously has such a code walker at its disposal, but it's one of the few parts of Lisp that's not exposed to users of the language.

5One version of f2cl is available as part of the Common Lisp Open Code Collection (CLOCC): http://clocc.sourceforge.net/. By contrast, consider the tricks the authors of f2j, a FORTRAN-to-Java translator, have to play. Although the Java Virtual Machine (JVM) has a goto instruction, it's not directly exposed in Java. So to compile FORTRAN gotos, they first compile the FORTRAN code into legal Java source with calls to a dummy class to represent the labels and gotos. Then they compile the source with a regular Java compiler and postprocess the byte codes to translate the dummy calls into JVM-level byte codes. Clever, but what a pain.

6Since this algorithm depends on values returned by RANDOM, you may want to test it with a consistent random seed, which you can get by binding *RANDOM-STATE* to the value of (make-random-state nil) around each call to algorithm-s. For instance, you can do a basic sanity check of algorithm-s by evaluating this:

(let ((*random-state* (make-random-state nil))) (algorithm-s 10 200))

If your refactorings are all valid, this expression should evaluate to the same list each time.

7This is a pretty reasonable restriction--it's not entirely clear what it'd mean to return from a form that has already returned--unless, of course, you're a Scheme programmer. Scheme supports continuations, a language construct that makes it possible to return from the same function call more than once. But for a variety of reasons, few, if any, languages other than Scheme support this kind of continuation.

8If you're the kind of person who likes to know how things work all the way down to the bits, it may be instructive to think about how you might implement the condition system's macros using BLOCK, TAGBODY, closures, and dynamic variables.

9UNWIND-PROTECT is essentially equivalent to try/finally constructs in Java and Python.

10And indeed, CLSQL, the multi-Lisp, multidatabase SQL interface library, provides a similar macro called with-database. CLSQL's home page is at http://clsql.b9.com.

11A small handful of macros don't pass through extra return values of the forms they evaluate. In particular, the PROG1 macro, which evaluates a number of forms like a PROGN before returning the value of the first form, returns that form's primary value only. Likewise, PROG2, which returns the value of the second of its subforms, returns only the primary value. The special operator MULTIPLE-VALUE-PROG1 is a variant of PROG1 that returns all the values returned by the first form. It's a minor wart that PROG1 doesn't already behave like MULTIPLE-VALUE-PROG1, but neither is used often enough that it matters much. The OR and COND macros are also not always transparent to multiple values, returning only the primary value of certain subforms.

12The reason loading a file with an IN-PACKAGE form in it has no effect on the value of *PACKAGE* after LOAD returns is because LOAD binds *PACKAGE* to its current value before doing anything else. In other words, something equivalent to the following LET is wrapped around the rest of the code in LOAD:

(let ((*package* *package*)) ...)

Any assignment to *PACKAGE* will be to the new binding, and the old binding will be restored when LOAD returns. It also binds the variable *READTABLE*, which I haven't discussed, in the same way.

13In some implementations, you may be able to get away with evaluating DEFUNs that use undefined macros in the function body as long as the macros are defined before the function is actually called. But that works, if at all, only when LOADing the definitions from source, not when compiling with COMPILE-FILE, so in general macro definitions must be evaluated before they're used.

14By contrast, the subforms in a top-level LET aren't compiled as top-level forms because they're not run directly when the FASL is loaded. They will run, but it's in the runtime context of the bindings established by the LET. Theoretically, a LET that binds no variables could be treated like a PROGN, but it's not--the forms appearing in a LET are never treated as top-level forms.

15The one declaration that has an effect on the semantics of a program is the SPECIAL declaration mentioned in Chapter 6.

Copyright © 2003-2005, Peter Seibel

21. Programming in the Large: Packages and Symbols

In Chapter 4 I discussed how the Lisp reader translates textual names into objects to be passed to the evaluator, representing them with a kind of object called a symbol. It turns out that having a built-in data type specifically for representing names is quite handy for a lot of kinds of programming.1 That, however, isn't the topic of this chapter. In this chapter I'll discuss one of the more immediate and practical aspects of dealing with names: how to avoid name conflicts between independently developed pieces of code.

Suppose, for instance, you're writing a program and decide to use a third-party library. You don't want to have to know the name of every function, variable, class, or macro used in the internals of that library in order to avoid conflicts between those names and the names you use in your program. You'd like for most of the names in the library and the names in your program to be considered distinct even if they happen to have the same textual representation. At the same time, you'd like certain names defined in the library to be readily accessible--the names that make up its public API, which you'll want to use in your program.

In Common Lisp, this namespace problem boils down to a question of controlling how the reader translates textual names into symbols: if you want two occurrences of the same name to be considered the same by the evaluator, you need to make sure the reader uses the same symbol to represent each name. Conversely, if you want two names to be considered distinct, even if they happen to have the same textual name, you need the reader to create different symbols to represent each name.

How the Reader Uses Packages

In Chapter 4 I discussed briefly how the Lisp reader translates names into symbols, but I glossed over most of the details--now it's time to take a closer look at what actually happens.

I'll start by describing the syntax of names understood by the reader and how that syntax relates to packages. For the moment you can think of a package as a table that maps strings to symbols. As you'll see in the next section, the actual mapping is slightly more flexible than a simple lookup table but not in ways that matter much to the reader. Each package also has a name, which can be used to find the package using the function FIND-PACKAGE.

The two key functions that the reader uses to access the name-to-symbol mappings in a package are FIND-SYMBOL and INTERN. Both these functions take a string and, optionally, a package. If not supplied, the package argument defaults to the value of the global variable *PACKAGE*, also called the current package.

FIND-SYMBOL looks in the package for a symbol with the given string for a name and returns it, or NIL if no symbol is found. INTERN also will return an existing symbol; otherwise it creates a new symbol with the string as its name and adds it to the package.

Most names you use are unqualified, names that contain no colons. When the reader reads such a name, it translates it to a symbol by converting any unescaped letters to uppercase and passing the resulting string to INTERN. Thus, each time the reader reads the same name in the same package, it'll get the same symbol object. This is important because the evaluator uses the object identity of symbols to determine which function, variable, or other program element a given symbol refers to. Thus, the reason an expression such as (hello-world) results in calling a particular hello-world function is because the reader returns the same symbol when it reads the function call as it did when it read the DEFUN form that defined the function.

A name containing either a single colon or a double colon is a package-qualified name. When the reader reads a package-qualified name, it splits the name on the colon(s) and uses the first part as the name of a package and the second part as the name of the symbol. The reader looks up the appropriate package and uses it to translate the symbol name to a symbol object.

A name containing only a single colon must refer to an external symbol--one the package exports for public use. If the named package doesn't contain a symbol with a given name, or if it does but it hasn't been exported, the reader signals an error. A double-colon name can refer to any symbol from the named package, though it's usually a bad idea--the set of exported symbols defines a package's public interface, and if you don't respect the package author's decision about what names to make public and which ones to keep private, you're asking for trouble down the road. On the other hand, sometimes a package author will neglect to export a symbol that really ought to be public. In that case, a double-colon name lets you get work done without having to wait for the next version of the package to be released.

Two other bits of symbol syntax the reader understands are those for keyword symbols and uninterned symbols. Keyword symbols are written with names starting with a colon. Such symbols are interned in the package named KEYWORD and automatically exported. Additionally, when the reader interns a symbol in the KEYWORD, it also defines a constant variable with the symbol as both its name and value. This is why you can use keywords in argument lists without quoting them--when they appear in a value position, they evaluate to themselves. Thus:

(eql ':foo :foo) ==> T

The names of keyword symbols, like all symbols, are converted to all uppercase by the reader before they're interned. The name doesn't include the leading colon.

(symbol-name :foo) ==> "FOO"

Uninterned symbols are written with a leading #:. These names (minus the #:) are converted to uppercase as normal and then translated into symbols, but the symbols aren't interned in any package; each time the reader reads a #: name, it creates a new symbol. Thus:

(eql '#:foo '#:foo) ==> NIL

You'll rarely, if ever, write this syntax yourself, but will sometimes see it when you print an s-expression containing symbols returned by the function GENSYM.

(gensym) ==> #:G3128

A Bit of Package and Symbol Vocabulary

As I mentioned previously, the mapping from names to symbols implemented by a package is slightly more flexible than a simple lookup table. At its core, every package contains a name-to-symbol lookup table, but a symbol can be made accessible via an unqualified name in a given package in other ways. To talk sensibly about these other mechanisms, you'll need a little bit of vocabulary.

To start with, all the symbols that can be found in a given package using FIND-SYMBOL are said to be accessible in that package. In other words, the accessible symbols in a package are those that can be referred to with unqualified names when the package is current.

A symbol can be accessible in two ways. The first is for the package's name-to-symbol table to contain an entry for the symbol, in which case the symbol is said to be present in the package. When the reader interns a new symbol in a package, it's added to the package's name-to-symbol table. The package in which a symbol is first interned is called the symbol's home package.

The other way a symbol can be accessible in a package is if the package inherits it. A package inherits symbols from other packages by using the other packages. Only external symbols in the used packages are inherited. A symbol is made external in a package by exporting it. In addition to causing it to be inherited by using packages, exporting a symbol also--as you saw in the previous section--makes it possible to refer to the symbol using a single-colon qualified name.

To keep the mappings from names to symbols deterministic, the package system allows only one symbol to be accessible in a given package for each name. That is, a package can't have a present symbol and an inherited symbol with the same name or inherit two different symbols, from different packages, with the same name. However, you can resolve conflicts by making one of the accessible symbols a shadowing symbol, which makes the other symbols of the same name inaccessible. In addition to its name-to-symbol table, each package maintains a list of shadowing symbols.

An existing symbol can be imported into another package by adding it to the package's name-to-symbol table. Thus, the same symbol can be present in multiple packages. Sometimes you'll import symbols simply because you want them to be accessible in the importing package without using their home package. Other times you'll import a symbol because only present symbols can be exported or be shadowing symbols. For instance, if a package needs to use two packages that have external symbols of the same name, one of the symbols must be imported into the using package in order to be added to its shadowing list and make the other symbol inaccessible.

Finally, a present symbol can be uninterned from a package, which causes it to be removed from the name-to-symbol table and, if it's a shadowing symbol, from the shadowing list. You might unintern a symbol from a package to resolve a conflict between the symbol and an external symbol from a package you want to use. A symbol that isn't present in any package is called an uninterned symbol, can no longer be read by the reader, and will be printed using the #:foo syntax.

Three Standard Packages

In the next section I'll show you how to define your own packages, including how to make one package use another and how to export, shadow, and import symbols. But first let's look at a few packages you've been using already. When you first start Lisp, the value of *PACKAGE* is typically the COMMON-LISP-USER package, also known as CL-USER.2CL-USER uses the package COMMON-LISP, which exports all the names defined by the language standard. Thus, when you type an expression at the REPL, all the names of standard functions, macros, variables, and so on, will be translated to the symbols exported from COMMON-LISP, and all other names will be interned in the COMMON-LISP-USER package. For example, the name *PACKAGE* is exported from COMMON-LISP--if you want to see the value of *PACKAGE*, you can type this:

CL-USER> *package* #<The COMMON-LISP-USER package>

because COMMON-LISP-USER uses COMMON-LISP. Or you can use a package-qualified name.

CL-USER> common-lisp:*package* #<The COMMON-LISP-USER package>

You can even use COMMON-LISP's nickname, CL.

CL-USER> cl:*package* #<The COMMON-LISP-USER package>

But *X* isn't a symbol in COMMON-LISP, so you if type this:

CL-USER> (defvar *x* 10) *X*

the reader reads DEFVAR as the symbol from the COMMON-LISP package and *X* as a symbol in COMMON-LISP-USER.

The REPL can't start in the COMMON-LISP package because you're not allowed to intern new symbols in it; COMMON-LISP-USER serves as a "scratch" package where you can create your own names while still having easy access to all the symbols in COMMON-LISP.3 Typically, all packages you'll define will also use COMMON-LISP, so you don't have to write things like this:

(cl:defun (x) (cl:+ x 2))

The third standard package is the KEYWORD package, the package the Lisp reader uses to intern names starting with colon. Thus, you can also refer to any keyword symbol with an explicit package qualification of keyword like this:

CL-USER> :a :A CL-USER> keyword:a :A CL-USER> (eql :a keyword:a) T

Defining Your Own Packages

Working in COMMON-LISP-USER is fine for experiments at the REPL, but once you start writing actual programs you'll want to define new packages so different programs loaded into the same Lisp environment don't stomp on each other's names. And when you write libraries that you intend to use in different contexts, you'll want to define separate packages and then export the symbols that make up the libraries' public APIs.

However, before you start defining packages, it's important to understand one thing about what packages do not do. Packages don't provide direct control over who can call what function or access what variable. They provide you with basic control over namespaces by controlling how the reader translates textual names into symbol objects, but it isn't until later, in the evaluator, that the symbol is interpreted as the name of a function or variable or whatever else. Thus, it doesn't make sense to talk about exporting a function or a variable from a package. You can export symbols to make certain names easier to refer to, but the package system doesn't allow you to restrict how those names are used.4

With that in mind, you can start looking at how to define packages and tie them together. You define new packages with the macro DEFPACKAGE, which allows you to not only create the package but to specify what packages it uses, what symbols it exports, and what symbols it imports from other packages and to resolve conflicts by creating shadowing symbols.5

I'll describe the various options in terms of how you might use packages while writing a program that organizes e-mail messages into a searchable database. The program is purely hypothetical, as are the libraries I'll refer to--the point is to look at how the packages used in such a program might be structured.

The first package you'd need is one to provide a namespace for the application--you want to be able to name your functions, variables, and so on, without having to worry about name collisions with unrelated code. So you'd define a new package with DEFPACKAGE.

If the application is simple enough to be written with no libraries beyond the facilities provided by the language itself, you could define a simple package like this:

(defpackage :com.gigamonkeys.email-db (:use :common-lisp))

This defines a package, named COM.GIGAMONKEYS.EMAIL-DB, that inherits all the symbols exported by the COMMON-LISP package.6

You actually have several choices of how to represent the names of packages and, as you'll see, the names of symbols in a DEFPACKAGE. Packages and symbols are named with strings. However, in a DEFPACKAGE form, you can specify the names of packages and symbols with string designators. A string designator is either a string, which designates itself; a symbol, which designates its name; or a character, which designates a one-character string containing just the character. Using keyword symbols, as in the previous DEFPACKAGE, is a common style that allows you to write the names in lowercase--the reader will convert the names to uppercase for you. You could also write the DEFPACKAGE with strings, but then you have to write them in all uppercase, because the true names of most symbols and packages are in fact uppercase because of the case conversion performed by the reader.7

(defpackage "COM.GIGAMONKEYS.EMAIL-DB" (:use "COMMON-LISP"))

You could also use nonkeyword symbols--the names in DEFPACKAGE aren't evaluated--but then the very act of reading the DEFPACKAGE form would cause those symbols to be interned in the current package, which at the very least will pollute that namespace and may also cause problems later if you try to use the package.8

To read code in this package, you need to make it the current package with the IN-PACKAGE macro:

(in-package :com.gigamonkeys.email-db)

If you type this expression at the REPL, it will change the value of *PACKAGE*, affecting how the REPL reads subsequent expressions, until you change it with another call to IN-PACKAGE. Similarly, if you include an IN-PACKAGE in a file that's loaded with LOAD or compiled with COMPILE-FILE, it will change the package, affecting the way subsequent expressions in the file are read.9

With the current package set to the COM.GIGAMONKEYS.EMAIL-DB package, other than names inherited from the COMMON-LISP package, you can use any name you want for whatever purpose you want. Thus, you could define a new hello-world function that could coexist with the hello-world function previously defined in COMMON-LISP-USER. Here's the behavior of the existing function:

CL-USER> (hello-world) hello, world NIL

