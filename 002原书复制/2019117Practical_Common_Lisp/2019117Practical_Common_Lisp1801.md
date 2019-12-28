where each error-clause is of the following form:

(condition-type ([var]) code)

If the expression returns normally, then its value is returned by the HANDLER-CASE. The body of a HANDLER-CASE must be a single expression; you can use PROGN to combine several expressions into a single form. If, however, the expression signals a condition that's an instance of any of the condition-types specified in any error-clause, then the code in the appropriate error clause is executed and its value returned by the HANDLER-CASE. The var, if included, is the name of the variable that will hold the condition object when the handler code is executed. If the code doesn't need to access the condition object, you can omit the variable name.

For instance, one way to handle the malformed-log-entry-error signaled by parse-log-entry in its caller, parse-log-file, would be to skip the malformed entry. In the following function, the HANDLER-CASE expression will either return the value returned by parse-log-entry or return NIL if a malformed-log-entry-error is signaled. (The it in the LOOP clause collect it is another LOOP keyword, which refers to the value of the most recently evaluated conditional test, in this case the value of entry.)

(defun parse-log-file (file) (with-open-file (in file :direction :input) (loop for text = (read-line in nil nil) while text for entry = (handler-case (parse-log-entry text) (malformed-log-entry-error () nil)) when entry collect it)))

When parse-log-entry returns normally, its value will be assigned to entry and collected by the LOOP. But if parse-log-entry signals a malformed-log-entry-error, then the error clause will return NIL, which won't be collected.

JAVA-STYLE EXCEPTON HANDLING

HANDLER-CASE is the nearest analog in Common Lisp to Java- or Python-style exception handling. Where you might write this in Java:

try { doStuff(); doMoreStuff(); } catch (SomeException se) { recover(se); }

or this in Python:

try: doStuff() doMoreStuff() except SomeException, se: recover(se)

in Common Lisp you'd write this:

(handler-case (progn (do-stuff) (do-more-stuff)) (some-exception (se) (recover se)))

This version of parse-log-file has one serious deficiency: it's doing too much. As its name suggests, the job of parse-log-file is to parse the file and produce a list of log-entry objects; if it can't, it's not its place to decide what to do instead. What if you want to use parse-log-file in an application that wants to tell the user that the log file is corrupted or one that wants to recover from malformed entries by fixing them up and re-parsing them? Or maybe an application is fine with skipping them but only until a certain number of corrupted entries have been seen.

You could try to fix this problem by moving the HANDLER-CASE to a higher-level function. However, then you'd have no way to implement the current policy of skipping individual entries--when the error was signaled, the stack would be unwound all the way to the higher-level function, abandoning the parsing of the log file altogether. What you want is a way to provide the current recovery strategy without requiring that it always be used.

Restarts

The condition system lets you do this by splitting the error handling code into two parts. You place code that actually recovers from errors into restarts, and condition handlers can then handle a condition by invoking an appropriate restart. You can place restart code in mid- or low-level functions, such as parse-log-file or parse-log-entry, while moving the condition handlers into the upper levels of the application.

To change parse-log-file so it establishes a restart instead of a condition handler, you can change the HANDLER-CASE to a RESTART-CASE. The form of RESTART-CASE is quite similar to a HANDLER-CASE except the names of restarts are just names, not necessarily the names of condition types. In general, a restart name should describe the action the restart takes. In parse-log-file, you can call the restart skip-log-entry since that's what it does. The new version will look like this:

(defun parse-log-file (file) (with-open-file (in file :direction :input) (loop for text = (read-line in nil nil) while text for entry = (restart-case (parse-log-entry text) (skip-log-entry () nil)) when entry collect it)))

If you invoke this version of parse-log-file on a log file containing corrupted entries, it won't handle the error directly; you'll end up in the debugger. However, there among the various restarts presented by the debugger will be one called skip-log-entry, which, if you choose it, will cause parse-log-file to continue on its way as before. To avoid ending up in the debugger, you can establish a condition handler that invokes the skip-log-entry restart automatically.

The advantage of establishing a restart rather than having parse-log-file handle the error directly is it makes parse-log-file usable in more situations. The higher-level code that invokes parse-log-file doesn't have to invoke the skip-log-entry restart. It can choose to handle the error at a higher level. Or, as I'll show in the next section, you can add restarts to parse-log-entry to provide other recovery strategies, and then condition handlers can choose which strategy they want to use.

But before I can talk about that, you need to see how to set up a condition handler that will invoke the skip-log-entry restart. You can set up the handler anywhere in the chain of calls leading to parse-log-file. This may be quite high up in your application, not necessarily in parse-log-file's direct caller. For instance, suppose the main entry point to your application is a function, log-analyzer, that finds a bunch of logs and analyzes them with the function analyze-log, which eventually leads to a call to parse-log-file. Without any error handling, it might look like this:

(defun log-analyzer () (dolist (log (find-all-logs)) (analyze-log log)))

The job of analyze-log is to call, directly or indirectly, parse-log-file and then do something with the list of log entries returned. An extremely simple version might look like this:

(defun analyze-log (log) (dolist (entry (parse-log-file log)) (analyze-entry entry)))

where the function analyze-entry is presumably responsible for extracting whatever information you care about from each log entry and stashing it away somewhere.

Thus, the path from the top-level function, log-analyzer, to parse-log-entry, which actually signals an error, is as follows:

Assuming you always want to skip malformed log entries, you could change this function to establish a condition handler that invokes the skip-log-entry restart for you. However, you can't use HANDLER-CASE to establish the condition handler because then the stack would be unwound to the function where the HANDLER-CASE appears. Instead, you need to use the lower-level macro HANDLER-BIND. The basic form of HANDLER-BIND is as follows:

(handler-bind (binding*) form*)

where each binding is a list of a condition type and a handler function of one argument. After the handler bindings, the body of the HANDLER-BIND can contain any number of forms. Unlike the handler code in HANDLER-CASE, the handler code must be a function object, and it must accept a single argument. A more important difference between HANDLER-BIND and HANDLER-CASE is that the handler function bound by HANDLER-BIND will be run without unwinding the stack--the flow of control will still be in the call to parse-log-entry when this function is called. The call to INVOKE-RESTART will find and invoke the most recently bound restart with the given name. So you can add a handler to log-analyzer that will invoke the skip-log-entry restart established in parse-log-file like this:5

(defun log-analyzer () (handler-bind ((malformed-log-entry-error #'(lambda (c) (invoke-restart 'skip-log-entry)))) (dolist (log (find-all-logs)) (analyze-log log))))

In this HANDLER-BIND, the handler function is an anonymous function that invokes the restart skip-log-entry. You could also define a named function that does the same thing and bind it instead. In fact, a common practice when defining a restart is to define a function, with the same name and taking a single argument, the condition, that invokes the eponymous restart. Such functions are called restart functions. You could define a restart function for skip-log-entry like this:

(defun skip-log-entry (c) (invoke-restart 'skip-log-entry))

Then you could change the definition of log-analyzer to this:

(defun log-analyzer () (handler-bind ((malformed-log-entry-error #'skip-log-entry)) (dolist (log (find-all-logs)) (analyze-log log))))

As written, the skip-log-entry restart function assumes that a skip-log-entry restart has been established. If a malformed-log-entry-error is ever signaled by code called from log-analyzer without a skip-log-entry having been established, the call to INVOKE-RESTART will signal a CONTROL-ERROR when it fails to find the skip-log-entry restart. If you want to allow for the possibility that a malformed-log-entry-error might be signaled from code that doesn't have a skip-log-entry restart established, you could change the skip-log-entry function to this:

(defun skip-log-entry (c) (let ((restart (find-restart 'skip-log-entry))) (when restart (invoke-restart restart))))

FIND-RESTART looks for a restart with a given name and returns an object representing the restart if the restart is found and NIL if not. You can invoke the restart by passing the restart object to INVOKE-RESTART. Thus, when skip-log-entry is bound with HANDLER-BIND, it will handle the condition by invoking the skip-log-entry restart if one is available and otherwise will return normally, giving other condition handlers, bound higher on the stack, a chance to handle the condition.

Providing Multiple Restarts

Since restarts must be explicitly invoked to have any effect, you can define multiple restarts, each providing a different recovery strategy. As I mentioned earlier, not all log-parsing applications will necessarily want to skip malformed entries. Some applications might want parse-log-file to include a special kind of object representing malformed entries in the list of log-entry objects; other applications may have some way to repair a malformed entry and may want a way to pass the fixed entry back to parse-log-entry.

To allow more complex recovery protocols, restarts can take arbitrary arguments, which are passed in the call to INVOKE-RESTART. You can provide support for both the recovery strategies I just mentioned by adding two restarts to parse-log-entry, each of which takes a single argument. One simply returns the value it's passed as the return value of parse-log-entry, while the other tries to parse its argument in the place of the original log entry.

(defun parse-log-entry (text) (if (well-formed-log-entry-p text) (make-instance 'log-entry ...) (restart-case (error 'malformed-log-entry-error :text text) (use-value (value) value) (reparse-entry (fixed-text) (parse-log-entry fixed-text)))))

The name USE-VALUE is a standard name for this kind of restart. Common Lisp defines a restart function for USE-VALUE similar to the skip-log-entry function you just defined. So, if you wanted to change the policy on malformed entries to one that created an instance of malformed-log-entry, you could change log-analyzer to this (assuming the existence of a malformed-log-entry class with a :text initarg):

(defun log-analyzer () (handler-bind ((malformed-log-entry-error #'(lambda (c) (use-value (make-instance 'malformed-log-entry :text (text c)))))) (dolist (log (find-all-logs)) (analyze-log log))))

You could also have put these new restarts into parse-log-file instead of parse-log-entry. However, you generally want to put restarts in the lowest-level code possible. It wouldn't, though, be appropriate to move the skip-log-entry restart into parse-log-entry since that would cause parse-log-entry to sometimes return normally with NIL, the very thing you started out trying to avoid. And it'd be an equally bad idea to remove the skip-log-entry restart on the theory that the condition handler could get the same effect by invoking the use-value restart with NIL as the argument; that would require the condition handler to have intimate knowledge of how the parse-log-file works. As it stands, the skip-log-entry is a properly abstracted part of the log-parsing API.

Other Uses for Conditions

While conditions are mainly used for error handling, they can be used for other purposes--you can use conditions, condition handlers, and restarts to build a variety of protocols between low- and high-level code. The key to understanding the potential of conditions is to understand that merely signaling a condition has no effect on the flow of control.

The primitive signaling function SIGNAL implements the mechanism of searching for an applicable condition handler and invoking its handler function. The reason a handler can decline to handle a condition by returning normally is because the call to the handler function is just a regular function call--when the handler returns, control passes back to SIGNAL, which then looks for another, less recently bound handler that can handle the condition. If SIGNAL runs out of condition handlers before the condition is handled, it also returns normally.

The ERROR function you've been using calls SIGNAL. If the error is handled by a condition handler that transfers control via HANDLER-CASE or by invoking a restart, then the call to SIGNAL never returns. But if SIGNAL returns, ERROR invokes the debugger by calling the function stored in *DEBUGGER-HOOK*. Thus, a call to ERROR can never return normally; the condition must be handled either by a condition handler or in the debugger.

Another condition signaling function, WARN, provides an example of a different kind of protocol built on the condition system. Like ERROR, WARN calls SIGNAL to signal a condition. But if SIGNAL returns, WARN doesn't invoke the debugger--it prints the condition to *ERROR-OUTPUT* and returns NIL, allowing its caller to proceed. WARN also establishes a restart, MUFFLE-WARNING, around the call to SIGNAL that can be used by a condition handler to make WARN return without printing anything. The restart function MUFFLE-WARNING finds and invokes its eponymous restart, signaling a CONTROL-ERROR if no such restart is available. Of course, a condition signaled with WARN could also be handled in some other way--a condition handler could "promote" a warning to an error by handling it as if it were an error.

For instance, in the log-parsing application, if there were ways a log entry could be slightly malformed but still parsable, you could write parse-log-entry to go ahead and parse the slightly defective entries but to signal a condition with WARN when it did. Then the larger application could choose to let the warning print, to muffle the warning, or to treat the warning like an error, recovering the same way it would from a malformed-log-entry-error.

A third error-signaling function, CERROR, provides yet another protocol. Like ERROR, CERROR will drop you into the debugger if the condition it signals isn't handled. But like WARN, it establishes a restart before it signals the condition. The restart, CONTINUE, causes CERROR to return normally--if the restart is invoked by a condition handler, it will keep you out of the debugger altogether. Otherwise, you can use the restart once you're in the debugger to resume the computation immediately after the call to CERROR. The function CONTINUE finds and invokes the CONTINUE restart if it's available and returns NIL otherwise.

You can also build your own protocols on SIGNAL--whenever low-level code needs to communicate information back up the call stack to higher-level code, the condition mechanism is a reasonable mechanism to use. But for most purposes, one of the standard error or warning protocols should suffice.

You'll use the condition system in future practical chapters, both for regular error handling and, in Chapter 25, to help in handling a tricky corner case of parsing ID3 files. Unfortunately, it's the fate of error handling to always get short shrift in programming texts--proper error handling, or lack thereof, is often the biggest difference between illustrative code and hardened, production-quality code. The trick to writing the latter has more to do with adopting a particularly rigorous way of thinking about software than with the details of any particular programming language constructs. That said, if your goal is to write that kind of software, you'll find the Common Lisp condition system is an excellent tool for writing robust code and one that fits quite nicely into Common Lisp's incremental development style.

Writing Robust Software

For information on writing robust software, you could do worse than to start by finding a copy of Software Reliability (John Wiley & Sons, 1976) by Glenford J. Meyers. Bertrand Meyer's writings on Design By Contract also provide a useful way of thinking about software correctness. For instance, see Chapters 11 and 12 of his Object-Oriented Software Construction (Prentice Hall, 1997). Keep in mind, however, that Bertrand Meyer is the inventor of Eiffel, a statically typed bondage and discipline language in the Algol/Ada school. While he has a lot of smart things to say about object orientation and software reliability, there's a fairly wide gap between his view of programming and The Lisp Way. Finally, for an excellent overview of the larger issues surrounding building fault-tolerant systems, see Chapter 3 of the classic Transaction Processing: Concepts and Techniques (Morgan Kaufmann, 1993) by Jim Gray and Andreas Reuter.

In the next chapter I'll give a quick overview of some of the 25 special operators you haven't had a chance to use yet, at least not directly.

* * *

1Throws or raises an exception in Java/Python terms

2Catches the exception in Java/Python terms

3In this respect, a condition is a lot like an exception in Java or Python except not all conditions represent an error or exceptional situation.

4In some Common Lisp implementations, conditions are defined as subclasses of STANDARD-OBJECT, in which case SLOT-VALUE, MAKE-INSTANCE, and INITIALIZE-INSTANCE will work, but it's not portable to rely on it.

5The compiler may complain if the parameter is never used. You can silence that warning by adding a declaration (declare (ignore c)) as the first expression in the LAMBDA body.

Copyright © 2003-2005, Peter Seibel

20. The Special Operators

In a way, the most impressive aspect of the condition system covered in the previous chapter is that if it wasn't already part of the language, it could be written entirely as a user-level library. This is possible because Common Lisp's special operators--while none touches directly on signaling or handling conditions--provide enough access to the underlying machinery of the language to be able to do things such as control the unwinding of the stack.

In previous chapters I've discussed the most frequently used special operators, but it's worth being familiar with the others for two reasons. First, some of the infrequently used special operators are used infrequently simply because whatever need they address doesn't arise that often. It's good to be familiar with these special operators so when one of them is called for, you'll at least know it exists. Second, because the 25 special operators--along with the basic rule for evaluating function calls and the built-in data types--provide the foundation for the rest of the language, a passing familiarity with them will help you understand how the language works.

In this chapter, I'll discuss all the special operators, some briefly and some at length, so you can see how they fit together. I'll point out which ones you can expect to use directly in your own code, which ones serve as the basis for other constructs that you use all the time, and which ones you'll rarely use directly but which can be handy in macro-generated code.

Controlling Evaluation

The first category of special operators contains the three operators that provide basic control over the evaluation of forms. They're QUOTE, IF, and PROGN, and I've discussed them all already. However, it's worth noting how each of these special operators provides one fundamental kind of control over the evaluation of one or more forms. QUOTE prevents evaluation altogether and allows you to get at s-expressions as data. IF provides the fundamental boolean choice operation from which all other conditional execution constructs can be built.1 And PROGN provides the ability to sequence a number of forms.

Manipulating the Lexical Environment

The largest class of special operators contains the operators that manipulate and access the lexical environment. LET and LET*, which I've already discussed, are examples of special operators that manipulate the lexical environment since they can introduce new lexical bindings for variables. Any construct, such as a DO or DOTIMES, that binds lexical variables will have to expand into a LET or LET*.2 The SETQ special operator is one that accesses the lexical environment since it can be used to set variables whose bindings were created by LET and LET*.

Variables, however, aren't the only thing that can be named within a lexical scope. While most functions are defined globally with DEFUN, it's also possible to create local functions with the special operators FLET and LABELS, local macros with MACROLET, and a special kind of macro, called a symbol macro, with SYMBOL-MACROLET.

Much like LET allows you to introduce a lexical variable whose scope is the body of the LET, FLET and LABELS let you define a function that can be referred to only within the scope of the FLET or LABELS form. These special operators are handy when you need a local function that's a bit too complex to define inline as a LAMBDA expression or that you need to use more than once. Both have the same basic form, which looks like this:

(flet (function-definition*) body-form*)

and like this:

(labels (function-definition*) body-form*)

where each function-definition has the following form:

(name (parameter*) form*)

The difference between FLET and LABELS is that the names of the functions defined with FLET can be used only in the body of the FLET, while the names introduced by LABELS can be used immediately, including in the bodies of the functions defined by the LABELS. Thus, LABELS can define recursive functions, while FLET can't. It might seem limiting that FLET can't be used to define recursive functions, but Common Lisp provides both FLET and LABELS because sometimes it's useful to be able to write local functions that can call another function of the same name, either a globally defined function or a local function from an enclosing scope.

Within the body of a FLET or LABELS, you can use the names of the functions defined just like any other function, including with the FUNCTION special operator. Since you can use FUNCTION to get the function object representing a function defined with FLET or LABELS, and since a FLET or LABELS can be in the scope of other binding forms such as LETs, these functions can be closures.

Because the local functions can refer to variables from the enclosing scope, they can often be written to take fewer parameters than the equivalent helper functions. This is particularly handy when you need to pass a function that takes a single argument as a functional parameter. For example, in the following function, which you'll see again in Chapter 25, the FLETed function, count-version, takes a single argument, as required by walk-directory, but can also use the variable versions, introduced by the enclosing LET:

(defun count-versions (dir) (let ((versions (mapcar #'(lambda (x) (cons x 0)) '(2 3 4)))) (flet ((count-version (file) (incf (cdr (assoc (major-version (read-id3 file)) versions))))) (walk-directory dir #'count-version :test #'mp3-p)) versions))

This function could also be written using an anonymous function in the place of the FLETed count-version, but giving the function a meaningful name makes it a bit easier to read.

And when a helper function needs to recurse, an anonymous function just won't do.3 When you don't want to define a recursive helper function as a global function, you can use LABELS. For example, the following function, collect-leaves, uses the recursive helper function walk to walk a tree and gather all the atoms in the tree into a list, which collect-leaves then returns (after reversing it):

(defun collect-leaves (tree) (let ((leaves ())) (labels ((walk (tree) (cond ((null tree)) ((atom tree) (push tree leaves)) (t (walk (car tree)) (walk (cdr tree)))))) (walk tree)) (nreverse leaves)))

Notice again how, within the walk function, you can refer to the variable, leaves, introduced by the enclosing LET.

FLET and LABELS are also useful operations to use in macro expansions--a macro can expand into code that contains a FLET or LABELS to create functions that can be used within the body of the macro. This technique can be used either to introduce functions that the user of the macro will call or simply as a way of organizing the code generated by the macro. This, for instance, is how a function such as CALL-NEXT-METHOD, which can be used only within a method definition, might be defined.

A near relative to FLET and LABELS is the special operator MACROLET, which you can use to define local macros. Local macros work just like global macros defined with DEFMACRO except without cluttering the global namespace. When a MACROLET form is evaluated, the body forms are evaluated with the local macro definitions in effect and possibly shadowing global function and macro definitions or local definitions from enclosing forms. Like FLET and LABELS, MACROLET can be used directly, but it's also a handy target for macro-generated code--by wrapping some user-supplied code in a MACROLET, a macro can provide constructs that can be used only within that code or can shadow a globally defined macro. You'll see an example of this latter use of MACROLET in Chapter 31.

Finally, one last macro-defining special operator is SYMBOL-MACROLET, which defines a special kind of macro called, appropriately enough, a symbol macro. Symbol macros are like regular macros except they can't take arguments and are referred to with a plain symbol rather than a list form. In other words, after you've defined a symbol macro with a particular name, any use of that symbol in a value position will be expanded and the resulting form evaluated in its place. This is how macros such as WITH-SLOTS and WITH-ACCESSORS are able to define "variables" that access the state of a particular object under the covers. For instance, the following WITH-SLOTS form:

(with-slots (x y z) foo (list x y z)))

might expand into this code that uses SYMBOL-MACROLET:

(let ((#:g149 foo)) (symbol-macrolet ((x (slot-value #:g149 'x)) (y (slot-value #:g149 'y)) (z (slot-value #:g149 'z))) (list x y z)))

When the expression (list x y z) is evaluated, the symbols x, y, and z will be replaced with their expansions, such as (slot-value #:g149 'x).4

Symbol macros are most often local, defined with SYMBOL-MACROLET, but Common Lisp also provides a macro DEFINE-SYMBOL-MACRO that defines a global symbol macro. A symbol macro defined with SYMBOL-MACROLET shadows other symbol macros of the same name defined with DEFINE-SYMBOL-MACRO or enclosing SYMBOL-MACROLET forms.

Local Flow of Control

The next four special operators I'll discuss also create and use names in the lexical environment but for the purposes of altering the flow of control rather than defining new functions and macros. I've mentioned all four of these special operators in passing because they provide the underlying mechanisms used by other language features. They're BLOCK, RETURN-FROM, TAGBODY, and GO. The first two, BLOCK and RETURN-FROM, are used together to write code that returns immediately from a section of code--I discussed RETURN-FROM in Chapter 5 as a way to return immediately from a function, but it's more general than that. The other two, TAGBODY and GO, provide a quite low-level goto construct that's the basis for all the higher-level looping constructs you've already seen.

The basic skeleton of a BLOCK form is this:

(block name form*)

The name is a symbol, and the forms are Lisp forms. The forms are evaluated in order, and the value of the last form is returned as the value of the BLOCK unless a RETURN-FROM is used to return from the block early. A RETURN-FROM form, as you saw in Chapter 5, consists of the name of the block to return from and, optionally, a form that provides a value to return. When a RETURN-FROM is evaluated, it causes the named BLOCK to return immediately. If RETURN-FROM is called with a return value form, the BLOCK will return the resulting value; otherwise, the BLOCK evaluates to NIL.

A BLOCK name can be any symbol, which includes NIL. Many of the standard control construct macros, such as DO, DOTIMES, and DOLIST, generate an expansion consisting of a BLOCK named NIL. This allows you to use the RETURN macro, which is a bit of syntactic sugar for (return-from nil ...), to break out of such loops. Thus, the following loop will print at most ten random numbers, stopping as soon as it gets a number greater than 50:

(dotimes (i 10) (let ((answer (random 100))) (print answer) (if (> answer 50) (return))))

Function-defining macros such as DEFUN, FLET, and LABELS, on the other hand, wrap their bodies in a BLOCK with the same name as the function. That's why you can use RETURN-FROM to return from a function.

TAGBODY and GO have a similar relationship to each other as BLOCK and RETURN-FROM: a TAGBODY form defines a context in which names are defined that can be used by GO. The skeleton of a TAGBODY is as follows:

(tagbody tag-or-compound-form*)

where each tag-or-compound-form is either a symbol, called a tag, or a nonempty list form. The list forms are evaluated in order and the tags ignored, except as I'll discuss in a moment. After the last form of the TAGBODY is evaluated, the TAGBODY returns NIL. Anywhere within the lexical scope of the TAGBODY you can use the GO special operator to jump immediately to any of the tags, and evaluation will resume with the form following the tag. For instance, you can write a trivial infinite loop with TAGBODY and GO like this:

(tagbody top (print 'hello) (go top))

Note that while the tag names must appear at the top level of the TAGBODY, not nested within other forms, the GO special operator can appear anywhere within the scope of the TAGBODY. This means you could write a loop that loops a random number of times like this:

(tagbody top (print 'hello) (when (plusp (random 10)) (go top)))

An even sillier example of TAGBODY, which shows you can have multiple tags in a single TAGBODY, looks like this:

(tagbody a (print 'a) (if (zerop (random 2)) (go c)) b (print 'b) (if (zerop (random 2)) (go a)) c (print 'c) (if (zerop (random 2)) (go b)))

This form will jump around randomly printing as, bs, and cs until eventually the last RANDOM expression returns 1 and the control falls off the end of the TAGBODY.

TAGBODY is rarely used directly since it's almost always easier to write iterative constructs in terms of the existing looping macros. It's handy, however, for translating algorithms written in other languages into Common Lisp, either automatically or manually. An example of an automatic translation tool is the FORTRAN-to-Common Lisp translator, f2cl, that translates FORTRAN source code into Common Lisp in order to make various FORTRAN libraries available to Common Lisp programmers. Since many FORTRAN libraries were written before the structured programming revolution, they're full of gotos. The f2cl compiler can simply translate those gotos to GOs within appropriate TAGBODYs.5

Similarly, TAGBODY and GO can be handy when translating algorithms described in prose or by flowcharts--for instance, in Donald Knuth's classic series The Art of Computer Programming, he describes algorithms using a "recipe" format: step 1, do this; step 2, do that; step 3, go back to step 2; and so on. For example, on page 142 of The Art of Computer Programming, Volume 2: Seminumerical Algorithms, Third Edition (Addison-Wesley, 1998), he describes Algorithm S, which you'll use in Chapter 27, in this form:

Algorithm S (Selection sampling technique). To select n records at random from a set of N, where 0 < n <= N.

S1. [Initialize.] Set t <-- 0, m <-- 0. (During this algorithm, m represents the number of records selected so far, and t is the total number of input records that we have dealt with.)

S2. [Generate U.] Generate a random number U, uniformly distributed between zero and one.

S3. [Test.] If (N - t)U >= n - m, go to step S5.

S4. [Select.] Select the next record for the sample, and increase m and t by 1. If m < n, go to step S2; otherwise the sample is complete and the algorithm terminates.

S5. [Skip.] Skip the next record (do not include it in the sample), increase t by 1, and go back to step S2.

This description can be easily translated into a Common Lisp function, after renaming a few variables, as follows:

(defun algorithm-s (n max) ; max is N in Knuth's algorithm (let (seen ; t in Knuth's algorithm selected ; m in Knuth's algorithm u ; U in Knuth's algorithm (records ())) ; the list where we save the records selected (tagbody s1 (setf seen 0) (setf selected 0) s2 (setf u (random 1.0)) s3 (when (>= (* (- max seen) u) (- n selected)) (go s5)) s4 (push seen records) (incf selected) (incf seen) (if (< selected n) (go s2) (return-from algorithm-s (nreverse records))) s5 (incf seen) (go s2))))

It's not the prettiest code, but it's easy to verify that it's a faithful translation of Knuth's algorithm. But, this code, unlike Knuth's prose description, can be run and tested. Then you can start refactoring, checking after each change that the function still works.6

After pushing the pieces around a bit, you might end up with something like this:

(defun algorithm-s (n max) (loop for seen from 0 when (< (* (- max seen) (random 1.0)) n) collect seen and do (decf n) until (zerop n)))

While it may not be immediately obvious that this code correctly implements Algorithm S, if you got here via a series of functions that all behave identically to the original literal translation of Knuth's recipe, you'd have good reason to believe it's correct.

Unwinding the Stack

Another aspect of the language that special operators give you control over is the behavior of the call stack. For instance, while you normally use BLOCK and TAGBODY to manage the flow of control within a single function, you can also use them, in conjunction with closures, to force an immediate nonlocal return from a function further down on the stack. That's because BLOCK names and TAGBODY tags can be closed over by any code within the lexical scope of the BLOCK or TAGBODY. For example, consider this function:

(defun foo () (format t "Entering foo~%") (block a (format t " Entering BLOCK~%") (bar #'(lambda () (return-from a))) (format t " Leaving BLOCK~%")) (format t "Leaving foo~%"))

The anonymous function passed to bar uses RETURN-FROM to return from the BLOCK. But that RETURN-FROM doesn't get evaluated until the anonymous function is invoked with FUNCALL or APPLY. Now suppose bar looks like this:

(defun bar (fn) (format t " Entering bar~%") (baz fn) (format t " Leaving bar~%"))

Still, the anonymous function isn't invoked. Now look at baz.

(defun baz (fn) (format t " Entering baz~%") (funcall fn) (format t " Leaving baz~%"))

Finally the function is invoked. But what does it mean to RETURN-FROM a block that's several layers up on the call stack? Turns out it works fine--the stack is unwound back to the frame where the BLOCK was established and control returns from the BLOCK. The FORMAT expressions in foo, bar, and baz show this:

CL-USER> (foo) Entering foo Entering BLOCK Entering bar Entering baz Leaving foo NIL

Note that the only "Leaving . . ." message that prints is the one that appears after the BLOCK in foo.

Because the names of blocks are lexically scoped, a RETURN-FROM always returns from the smallest enclosing BLOCK in the lexical environment where the RETURN-FROM form appears even if the RETURN-FROM is executed in a different dynamic context. For instance, bar could also contain a BLOCK named a, like this:

(defun bar (fn) (format t " Entering bar~%") (block a (baz fn)) (format t " Leaving bar~%"))

This extra BLOCK won't change the behavior of foo at all--the name a is resolved lexically, at compile time, not dynamically, so the intervening block has no effect on the RETURN-FROM. Conversely, the name of a BLOCK can be used only by RETURN-FROMs appearing within the lexical scope of the BLOCK; there's no way for code outside the block to return from the block except by invoking a closure that closes over a RETURN-FROM from the lexical scope of the BLOCK.

TAGBODY and GO work the same way, in this regard, as BLOCK and RETURN-FROM. When you invoke a closure that contains a GO form, if the GO is evaluated, the stack will unwind back to the appropriate TAGBODY and then jump to the specified tag.

BLOCK names and TAGBODY tags, however, differ from lexical variable bindings in one important way. As I discussed in Chapter 6, lexical bindings have indefinite extent, meaning the bindings can stick around even after the binding form has returned. BLOCKs and TAGBODYs, on the other hand, have dynamic extent--you can RETURN-FROM a BLOCK or GO to a TAGBODY tag only while the BLOCK or TAGBODY is on the call stack. In other words, a closure that captures a block name or TAGBODY tag can be passed down the stack to be invoked later, but it can't be returned up the stack. If you invoke a closure that tries to RETURN-FROM a BLOCK, after the BLOCK itself has returned, you'll get an error. Likewise, trying to GO to a TAGBODY that no longer exists will cause an error.7

It's unlikely you'll need to use BLOCK and TAGBODY yourself for this kind of stack unwinding. But you'll likely be using them indirectly whenever you use the condition system, so understanding how they work should help you understand better what exactly, for instance, invoking a restart is doing.8

CATCH and THROW are another pair of special operators that can force the stack to unwind. You'll use these operators even less often than the others mentioned so far--they're holdovers from earlier Lisp dialects that didn't have Common Lisp's condition system. They definitely shouldn't be confused with try/catch and try/except constructs from languages such as Java and Python.

