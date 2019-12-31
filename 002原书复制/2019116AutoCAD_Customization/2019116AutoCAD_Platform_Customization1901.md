

# Chapter 19 Catching and Handling Errors

As a veteran AutoLISP® programmer looking back over the past 15 years, I realize writing a custom program wasn't always the difficult part for me. The part of application development that didn't come so naturally was predicting the unexpected. Programs are written based on a set of known criteria, which might include the current values assigned to system variables when the program was created, a specific set of steps that the user should follow, and what the end result should be. However, as in life, your program will have to handle a curve ball every now and then.

As a programmer, you must learn to locate problems—errors or bugs, as programmers commonly refer to them. If you hang around programmers, you might have heard the term debugging, which is the industry-standard term used for the process of locating and resolving problems in a program. Conditional statements can be used to identify and work around potential problems by validating values and data types used in a program. As a last resort, a custom error handler can be used to catch an error and exit a program cleanly.

Identifying and Tracking Down Errors

Writing a program takes time, but what can often take more time is identifying why a program is not working correctly—or at all. Figuring out a problem within a custom program can drive you crazy; after all, the problem is right there in the code you wrote.

NOTE

Sometimes finding a peer, or someone else in the industry, who can review your code can be helpful in finding the problem. If you don't know a specific individual who is willing to review your code, try visiting sites such as www.theswamp.org, www.augi.com, and forums.autodesk.com for some help.

Debugging is a skill that is honed over time, and it is something you start learning on your first day of writing AutoLISP—or any programming language, for that matter. These basic techniques can be useful in debugging an AutoLISP program:

Executing a program one line at a time by pasting code at the Command prompt

Displaying messages at the command line during execution

Tracing a function and the values it is passed

TIP

On Windows, the Visual LISP Integrated Development Environment (VLIDE) that comes with AutoCAD provides additional tools that can be helpful when debugging an AutoLISP program. I cover the VLIDE in Chapter 21,「Using the Visual LISP Editor (Windows only).」

Putting Your Code Under the Microscope

Errors in an AutoLISP program aren't specific to any particular type of programmer; even the most veteran AutoLISP programmer can miss something in their code. The advantage a veteran programmer does have over those who are new to AutoLISP programming is an understanding of what to look for. When your program won't load, there are several things you should look at to try to fix the error. The following common errors are often responsible when your program does not load:

Missing Closing Parenthesis It is common to miss one or more closing parentheses when you are working on a program. AutoLISP displays (_> or ; error: malformed list on input at the Command prompt to let you know you have more opening than closing parentheses. One opening parenthesis is displayed for each closing parenthesis that is needed when(_> is displayed. For example, (((_> indicates you need to add three closing parentheses to your program. The closing parentheses that are missing might or might not be together in the code. The resolution is to go through your code line by line, add the correct number of missing closing parentheses, and then try reloading the program.

Missing Opening Parenthesis Much less common is a missing opening parenthesis, but it can happen. If you move lines of code around, a parenthesis could be overlooked. AutoLISP displays the error message ; error: extra right paren on input when there are more closing parentheses than opening in your program. The resolution again is to go through your code line by line, add the missing opening parentheses or remove the extra closing parentheses, and then try reloading the program.

Missing Quotation Mark Strings that are missing a beginning or ending quotation mark will cause a problem when trying to load a program. AutoLISP will display (("_> at the Command prompt when this condition is encountered. If you are trying to display a quotation mark in a string, make sure you add the correct control sequence of \". The resolution is to find and add the missing quotation mark and then try reloading the program.

Bad Argument Type One of the most obscure problems to track down in an AutoLISP program that won't load is related to a bad value. Typically, AutoLISP displays the error message ; error: bad argument type: consp or ; error: extra cdrs in dotted pair on input when you have dotted pairs in your program that aren't structured correctly. The resolution is to locate the dotted pairs in your program and verify that they are structured correctly.

TIP

When adding a new function or line of code to an AutoLISP program, consider adding an opening and closing parenthesis right away before typing a function or argument value. If you are adding a string, add both the beginning and ending quotation marks to ensure you don't forget one of them. Following these tips will help to keep your parentheses and quotation marks balanced and avoid some of the errors I previously described.

Figure 19.1 shows a logic tree or analysis flowchart that you can refer to when troubleshooting and debugging problems in an AutoLISP file that won't load.

Figure 19.1 Troubleshooting and debugging loading problems

Once your program is loaded, you might still encounter problems. AutoLISP doesn't validate whether a function exists or is being passed an appropriate value when it loads a program; it just checks for a valid structure and proper syntax. The following are common problems that you might encounter when executing a program:

Bad Function AutoLISP displays the message ; error: bad function: <function_name> at the Command prompt when it encounters a function name it doesn't understand. This could be the result of a misspelled name or a space missing between a function name and the first argument. The resolution is to search on the value after the colon in the AutoLISP program to locate the bad function name, and fix the name before reloading the program. If the function name is spelled correctly and the syntax is correct (no missing spaces), make sure that the program file that defines the function is loaded into AutoCAD.

Bad Argument Type Unlike when you load an AutoLISP program and get the ; error: bad argument type message, this problem is often the result of trying to pass a function an unexpected value. The best technique to use is to display multiple messages throughout your custom program to isolate just where the error occurs. I explain how to add messages to a program for debugging purposes in the next section.

Too Few/Too Many Arguments Functions expect a specific number of arguments; too few or too many results in an error. When AutoLISP displays the message ; error: too few arguments or ; error: too many arguments, check the number of arguments that is being passed to each function. Adding messages to a program can be helpful in identifying which statement is causing the error. I explain how to add messages to a program for debugging purposes in the next section.

Figure 19.2 shows a logic tree or analysis flowchart that you can refer to when troubleshooting and debugging problems in an AutoLISP file that loads, but doesn't execute.

Figure 19.2 Troubleshooting and debugging execution problems

Displaying Messages During Execution

Using messaging functions to locate which statements in a custom program might be causing an error during execution may not make sense at first, but you can think of it like a game of Marco Polo between you and the program. Adding messaging functions is the equivalent of you calling out「Marco」and when a function is executed, the program calls back to you with「Polo.」You know when you are near the statement producing the error because the program doesn't display the next debugging message.

Place the message functions used for debugging about every 5 to 10 statements in a program; place them too frequently or infrequently, and they will not be as useful. The following is an example of a custom program that contains two errors that will cause some problems and shows how messaging functions can be used to help identify the bad statements:

(defun c:BadCode ( / ) ; Prompt for string (setq str (getstring "\nEnter a string: ")) ; If str is not nil, continue (if str (progn (princ "DEBUG: Inside IF") (prompt "\nValue entered: " str) ; Error 1, too many arguments ; Prompt for integer (setq int (getint "\nEnter an integer: ")) (princ "DEBUG: Ready to divide") ; Divide number by 2 (if int (prompt (strcat "\nDivisor" (itoa (/ 2 int))))) ; Error 2 (possible) if user types 0 ) (princ "DEBUG: IF ELSE") ) (princ "DEBUG: Inside IF") (princ) )

The princ function in the previous example is used to display debugging-related messages during the execution of the program. The statement containing the prompt function causes an error because it doesn't accept two arguments, and the / function causes an error if it tries to divide 2 by 0.

TIP

I recommend starting debugging messages with \nDEBUG: to make it easy to locate them in a program. By doing so, you can use the Find and Replace tools of Notepad (Windows) or TextEdit (Mac OS) to comment out debugging messages before you publish the finished program. Replace (princ "\nDEBUG: with ;(princ "\nDEBUG: to comment the statement out.

The following functions can be used to display messages during the execution of a custom program:

alert

prin1

princ

print

prompt

These message functions were covered in Chapter 15,「Requesting Input and Using Conditional and Looping Expressions.」

NOTE

The steps in the following exercise depend on the ch19_debuggingex.lsp sample file available for download from www.sybex.com/go/autocadcustomization. The sample file should be placed in the MyCustomFiles folder within the Documents (or My Documents) folder, or the location you are using to store the LSP files.

In this exercise, you will look at a custom program that has seen better days; it contains several errors that need to be identified and fixed. Some of the errors prevent the program from loading, whereas others cause the program to generate errors during execution. The following steps explain how to fix the errors in the file:

Load Ch19_DebuggingEx.lsp into AutoCAD with the appload command. If the File Loading - Security Concern warning message is displayed, click Load to continue. AutoLISP displays the error message ; error: malformed string on input at the Command prompt.

Open the Ch19_DebuggingEx.lsp file in Notepad (Windows) or TextEdit (Mac OS). In the text editor area, you see the following code:

(defun c:BadCode ( / str int) ; Prompt for string (setq str (getstring "\nEnter a string: )) ; If str is not nil, continue (if str (progn (prompt "\nValue entered: " str) ; Prompt for integer (setq int (getint "\nEnter an integer: ")) ; Divide 2 by a number (if int (prompt (strcat "\nDivisor: " (rtos (/ 2.0 int)))) ) ) (princ) )

Scan the code for the missing quotation mark (「). Do you see it? It is missing at the end of the prompt string in the getstring function.

Change "\nEnter a string: to "\nEnter a string: ".

Save the file and reload it into AutoCAD.

Scan the code line by line and count the number of opening and closing parentheses. Do you see it? A missing closing parenthesis can be much harder to locate than a missing quotation mark, but there is a technique you can use.

Copy and paste one line at a time from the LSP file to the AutoCAD Command prompt and look to the left side of the command-line window. Evaluate the number of open parentheses each time you paste a new line until you see an extra open parenthesis.

NOTE

Instead of copying one line at a time, you can copy a whole AutoLISP function and paste it at the Command prompt as well; just don't paste a command as the first line.

The following shows the results of pasting each code statement to the Command prompt. The problem is not that there's an extra opening parenthesis, but rather that a closing parenthesis is missing (as the last line here makes clear). The statement that is causing the error is (if int (prompt (strcat "\nDivisor: " (rtos (/ 2.0 int)))).

Command: (defun c:BadCode ( / str int) (_> ; Prompt for string (_> (setq str (getstring "\nEnter a string: ")) (_> (_> ; If str is not nil, continue (_> (if str ((_> (progn (((_> (prompt "\nValue entered: " str) (((_> (((_> ; Prompt for integer (((_> (setq int (getint "\nEnter an integer: ")) (((_> (((_> ; Divide 2 by a number (((_> (if int (prompt (strcat "\nDivisor: " (rtos (/ 2.0 int)))) ((((_> ) (((_> ) ((_> ((_> (princ) ((_> )

In the text editor area, add the missing closing parenthesis to the end of the following statement: (if int (prompt (strcat "\nDivisor: " (rtos (/ 2.0 int))))

Save the file and reload it into AutoCAD. The file loads without any problems.

In this exercise, you will test the custom program and fix any problems that might be encountered:

At the Command prompt, type badcode and press Enter.

At the Enter a string: prompt, type test and press Enter. AutoCAD displays the error message ; error: too many arguments at the Command prompt.

In the text editor area, add the statements in bold to the file:(defun c:BadCode ( / ) ; Prompt for string (setq str (getstring "\nEnter a string: ")) ; If str is not nil, continue (if str (progn (princ "\nDEBUG: Inside IF") (prompt "\nValue entered: " str) ; Prompt for integer (setq int (getint "\nEnter an integer: ")) (princ "\nDEBUG: Ready to divide") ; Divide 2 by a number (if int (prompt (strcat "\nDivisor: " (rtos (/ 2 int))))) ) (princ "\nDEBUG: IF ELSE") ) (princ "\nDEBUG: Inside IF") (princ) )

Save the file and reload it into AutoCAD. The last message that AutoCAD displays before the error message is DEBUG: Inside IF. Look at the next statement after the message that contains the prompt function. Do you see the problem? The prompt function accepts only a single argument.

Change the statement containing the prompt function to the following:(prompt (strcat "\nValue entered: " str))

Save the file and reload it into AutoCAD.

At the Command prompt, type badcode and press Enter.

At the Enter a string: prompt, type test and press Enter.

At the Enter an integer: prompt, type 4 and press Enter. The custom function completes as expected and the following messages are displayed at the Command prompt.

Command: BADCODE Enter a string: test DEBUG: Inside IF Value entered: test Enter an integer: 4 DEBUG: Ready to divide Divisor: 0.5000 DEBUG: Inside IF

Run the badcode function again. When prompted for an integer value, type 0 and press Enter. The last message that is displayed is DEBUG: Ready to divide before the error message ; error: divide by zero. To avoid the error related to dividing by 0, you should add a test condition to the program.

The previous exercises demonstrate how the AutoLISP error messages are helpful in figuring out why a program doesn't load or what is happening during execution. You also saw how adding messages to a function can be helpful in figuring out where an error is occurring in a custom program.

Tracing Functions

AutoLISP provides a feature known as function tracing that allows you to be notified when a function is about to be executed and what it returns. You use the trace function to enable the tracing of a function and the untrace function to stop tracing a function. When tracing is enabled for a function, a message stating that the function is about to be executed is displayed at the Command prompt along with the arguments it was passed. Once the function is done executing, a message with the function's return value is displayed at the Command prompt. You can trace both custom and standard AutoLISP functions.

The following shows the syntax of the trace and untrace functions:

(trace [function_name …]) (untrace [function_name …])

The function_name argument is the name of the function you want to enable tracing for (or that you no longer want to trace). The argument is optional, and when no function name is provided, the function doesn't do anything. If you want to trace more than one function, enter additional function names and separate them with a space; don't provide the function names in a list.

Here is an example of tracing a custom function named OddOrEven:

; Function returns ODD or EVEN based on the number it is passed (defun OddOrEven (cnt / ) (if (= (rem cnt 2) 1) "ODD" "EVEN" ) ) ; Enable tracing of the OddorEven function (trace OddOrEven) ; Function that loops 5 times and calls the OddOrEven function (defun c:TraceUntrace ( / ) (setq cnt 5) (while (> cnt 0) (OddOrEven cnt) (setq cnt (1- cnt)) ) (princ) ) ; Output from the tracing of the OddOrEven function Entering (ODDOREVEN 5) Result: "ODD" Entering (ODDOREVEN 4) Result: "EVEN" Entering (ODDOREVEN 3) Result: "ODD" Entering (ODDOREVEN 2) Result: "EVEN" Entering (ODDOREVEN 1) Result: "ODD" ; Disable tracing of the OddorEven function (untrace OddOrEven)

Catching Errors in a Program

Even with all the effort put into identifying and locating errors in a custom program, an error can still occur during the execution. It is just in the nature of some functions to always return an error instead of nil when something unexpected happens. For example, dividing a number by 0 always produces an error; the same goes for times when a custom function isn't loaded when your program tries to call it.

The vl-catch-all-apply function can be used to catch and then handle the error without it causing your program to suddenly end. The arguments passed to the vl-catch-all-apply function are evaluated before the function returns a value. If no error occurs, either the expected value or a value of the Catch-All-Apply-Error data type is returned.

The following shows the syntax of the vl-catch-all-apply function:

(vl-catch-all-apply 'function_name 'argument_list)

Here are its arguments:

function_name The function_name argument is the name of the function you want to execute. The name must be prefixed with an apostrophe.

argument_list The argument_list argument is a list that contains the arguments that should be passed to the function specified by the function_name argument. The argument list must be prefixed with an apostrophe.

Here's an example that shows how to catch an error with the vl-catch-all-apply function:

; Divide 2 by 0 (setq div (/ 2 0)) ; error: divide by zero !div nil ; Divide 2 by 1 (setq div (vl-catch-all-apply '/ '(2 1))) 2 ; Divide 2 by 0 (setq div (vl-catch-all-apply '/ '(2 0))) #<%catch-all-apply-error%> !div #<%catch-all-apply-error%>

When you use the vl-catch-all-apply function, you can use the vl-catch-all-error-p function to determine if an error was returned.

The following shows the syntax of the vl-catch-all-error-p function:

(vl-catch-all-error-p value)

The value argument is a value of any supported data type. If the value is of the Catch-All-Apply-Error data type, T is returned and indicates that the return contains an error and not an expected data type, or nil if a value other than an error was returned.

Here are examples of the vl-catch-all-error-p function:

; Divide 2 by 1 (vl-catch-all-error-p (setq div (vl-catch-all-apply '/ '(2 1)))) nil ; Divide 2 by 0 (vl-catch-all-error-p (setq div (vl-catch-all-apply '/ '(2 0)))) T

The type of error returned by the vl-catch-all-apply function can be obtained with the vl-catch-all-error-message function. The vl-catch-all-error-message function returns a string value that represents the error, which you can use in a conditional statement to determine how the program should continue. Perhaps you will ask the user for a new value, substitute a default value, or not execute any further statements.

The following shows the syntax of the vl-catch-all-error-message function:

(vl-catch-all-error-message value)

The value argument should contain a value of the Catch-All-Apply-Error data type. If an error is passed to the function, a string containing the error type is returned. Any value passed to the function results in the return of a new error.

Here's an example of the vl-catch-all-error-message function:

; Divide 2 by 0 (vl-catch-all-error-message (setq div (vl-catch-all-apply '/ '(2 0)))) "divide by zero"

NOTE

The apply function is similar to vl-catch-all-apply; you can pass a single function a list of values to use as the function's arguments. However, the apply function will still result in the ending of the program if an error occurs. For more information on the apply function, see the AutoCAD Help system.

Defining and Using a Custom Error Handler

Debugging and eradicating errors in a custom program (and catching those errors that might happen during execution) helps to ensure a great experience for the end user. However, even with all of this planning there are some situations you can't handle using the techniques described so far in this chapter. As a last-ditch effort to handle any errors that might come up, AutoLISP provides the ability to implement a custom error handler that will give you a chance to clean up any changes to the AutoCAD environment.

No! Not the Esc Key!

Here's a situation that will always end with an error. You can't catch it while you're programming because nobody is supposed to do that. When an end user presses Esc while being prompted for a value, AutoLISP cancels the current function and starts the current error handler. The standard AutoLISP error handler simply returns a message about the most recent error, but you can override the standard AutoLISP error handler with your own error handler. I'll show you how to use a custom error handler to catch the error and then respond accordingly.

A custom error handler is a function defined with the defun function and should accept a single argument. The argument passed to the error handler is of the string data type, and it represents the error that occurred.

The standard error handler is represented by the function named *error*. You don't directly call this function, but you do override it with your own custom error handler once it is defined. The *error* function is overwritten using the setq function, but before you do override it, I recommend that you store the current *error* function so it can be restored after your custom program ends. If you don't restore the previous *error* function, it might cause problems with other custom AutoLISP programs.

The following is an example of a basic custom error handler that doesn't return an error message when the user presses Esc while being prompted for input with one of the getxxx functions:

(defun *my_error* ( msg / ) (if (/= (strcase msg T) "function cancelled") (alert (strcat "\nERROR: " msg)) ) (setq *error* old_err) )

The following stores the current *error* function in the old_err variable, and then sets the *my_error* function as the current error handler that AutoLISP calls when an error occurs:

(setq old_err *error* *error* *my_error*)

This statement restores the previous error handler that was assigned to the old_err variable:

(setq *error* old_err)

The following function prompts the user for an integer and then divides 2 by that number. This is designed to deal with errors that occur if the user presses Esc instead of entering a number or if 0 is entered.

(defun c:TestEsc ( / int) (setq int (getint "\nEnter a whole number: ")) (alert (strcat "Value: " (itoa (/ 2 int)))) )

As an alternative to the previous example, you could use a custom error handler to catch the error that might be generated by the function and then respond accordingly. The following function implements a custom error handler and displays an error message only when the user doesn't press Esc:

(defun c:TestEscErr ( / int) ; Define the custom error handler (defun *my_error* ( msg / ) (if (/= (strcase msg T) "function cancelled") (alert (strcat "\nERROR: " msg)) ) (setq *error* old_err) ) ; Store the current error handler and set the custom error handler (setq old_err *error* *error* *my_error*) (setq int (getint "\nEnter a whole number: ")) (alert (strcat "Value: " (itoa (/ 2 int)))) ; Restore the previous error handler (setq *error* old_err) (princ) )

NOTE

A custom error handler has access to the local variables of the function in which the error occurred.

Grouping Functions into a Single Undo Action

Standard AutoCAD commands support the ability to be undone with a single action using the u or undo command. Using the undo command, you can wrap all the functions in a custom AutoLISP program to act like a single operation. This makes it easier to roll back changes that are made by a custom program and restore the drawing to the state it was in before the program was executed when an error is encountered or for the end user's convenience.

If you don't use the undo command to wrap the functions in a custom AutoLISP program, the undo command might need to be executed several (maybe even hundreds of) times to roll back the changes that were made. Objects created or modified with the command function would need to be rolled back one command at a time. However, objects created or modified without the use of the command function don't support individual undoing, but rather are undone only after the changes made by the last individual command are undone.

Figure 19.3 illustrates how commands are undone by default—one at a time—and also shows how objects created with the entmake function are undone when undo grouping is not used. The top of the illustration shows the circle command used twice and the line command used once; executing the u command three times would get you back to the drawing's previous state. The bottom of the illustration shows the creation of a circle with the circle command, and then a line and circle created with the entmake function. Notice that the objects created with entmake are grouped with the previous command; in this case it was the circle command. Executing the u command will undo the line and circle created with the entmake function, along with the circle command.

Figure 19.3 Rolling back changes made with commands and the entmake function

The BEgin suboption of the undo command is used to start a new undo grouping, whereas the End suboption marks the end of the undo grouping. Once a grouping is defined, the u or undo command will then roll back all the changes that were made as part of that grouping. Figure 19.4 illustrates the same object-creation operations shown in Figure 19.3, but here the operations are wrapped in undo groupings. Undoing the changes now requires the end user to execute the u command only once to roll back all the changes included in the undo grouping.

Figure 19.4 Wrapping functions with undo groupings to create a single undo action

The following example demonstrates how to begin and end an undo grouping:

; Create concentric circles (defun c:CCircs ( / cenPt rad) ; Start the undo grouping (command "._undo" "_be") ; Prompt for center point (setq cenPt (getpoint "\nSpecify center point: ")) (entmake (list (cons 0 "CIRCLE") (cons 10 cenPt) (cons 40 0.75))) ; Prompt for radius (setq rad (getdist cenPt "\nSpecify radius of second circle: ")) (entmake (list (cons 0 "CIRCLE") (cons 10 cenPt) (cons 40 rad))) ; End the undo grouping (command "._undo" "_e") (princ) )

Here's an example of using undo grouping with a custom error handler:

; Create concentric circles (defun c:CCircs ( / cenPt rad) ; Custom error handler (defun *my_error* ( msg / ) ; Ends the previous undo grouping (command "._undo" "_e") ; Roll back the changes (command "._u") (setq *error* old_err) ) ; Store the current error handler and set the custom error handler (setq old_err *error* *error* *my_error*) ; Start the undo grouping (command "._undo" "_be") ; Prompt for center point (setq cenPt (getpoint "\nSpecify center point: ")) (entmake (list (cons 0 "CIRCLE") (cons 10 cenPt) (cons 40 0.75))) ; Prompt for radius (setq rad (getdist cenPt "\nSpecify radius of second circle: ")) (entmake (list (cons 0 "CIRCLE") (cons 10 cenPt) (cons 40 rad))) ; End the undo grouping (command "._undo" "_e") ; Restore the previous error handler (setq *error* old_err) (princ) )

With the previous example, if the user presses Esc while being prompted for the radius, the program ends and undoes the drawing of the first circle.

Starting with AutoCAD 2012, the way commands are called within a custom error handler was changed. If you are using the command-s function within a custom error handler, you must call the *push-error-using-stack* function before the *error* handler might be called. Then, after the last use of the command-s function, you must call the *pop-error-mode* function.

The *push-error-using-command* function is similar to *push-error-using-stack*, but should be called when the command function is used in a custom error handler. When neither is called, AutoLISP assumes it is using *push-error-using-command* and it is okay to use the command function; this is the legacy behavior of AutoCAD 2011 and earlier releases.

The *push-error-using-command*, *push-error-using-stack*, and *pop-error-mode* functions don't accept any arguments. I show how to use the *push-error-using-command* and *pop-error-mode* functions in the next section. For an example of the *push-error-using-stack* function, see the AutoCAD Help system.

TIP

Examples of custom error handlers using the command and command-s functions can be found in the ch19_errhandlers.lsp sample file available for download from www.sybex.com/go/autocadcustomization.

Exercise: Handling Errors in the drawplate Function

In this section, you will continue to work with the drawplate function that was originally introduced in Chapter 12,「Understanding AutoLISP.」The key concepts I cover in this exercise are as follows:

Using Undo Grouping Wrapping functions into an undo grouping allows any changes that are made by a custom program to be rolled back and restores the drawing to the state it was in before it was executed.

Adding a Custom *error* Handler Custom *error* handlers make it easy to determine when a program encounters an error and then to respond accordingly.

NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Creating, Querying, and Modifying Objects」section of Chapter 16,「Creating and Modifying Graphical Objects.」If you didn't complete the steps, do so now or start with the ch19_drawplate.lsp and ch19_utility.lsp sample files available for download from www.sybex.com/go/autocadcustomization. These sample files should be placed in the MyCustomFiles folder within the Documents (or My Documents) folder, or the location you are using to store the LSP files. Once the sample files are stored on your system, remove the characters ch19_ from the name of each file.

Using the drawplate Function

Chapter 16 was the last chapter in which any changes were made to the drawplate function. At that time, the function drew a plate and added holes based on user input, which defined the overall size of the plate. But what if you made a mistake? Did you try to undo the changes that were made by the drawplate function or press Esc to cancel the function when being prompted for input? If you did, you found that the plate that was drawn remained in the drawing or the changes that were made to the drawing didn't exactly roll back as expected. Typically when you cancel a command before it completes, all of the changes are undone, but not so with the drawplate function. Use the following steps to see for yourself:

Create a new drawing.

Start the appload command. Load the LSP files drawplate.lsp and utility.lsp. If the File Loading - Security Concerns message box is displayed, click Load.

At the Command prompt, type drawplate and press Enter.

At the Specify base point for the plate or [Width/Height]: prompt, pick a point in the drawing area to draw the plate and holes based on the width and height values specified.

At the Specify label insertion point: prompt, press Esc. The plate that was drawn remains in the drawing. Typically, when you cancel a command before it completes all of its changes are undone.

Run the drawplate function again. Specify a point for the plate and the label.

At the Command prompt, type u and press Enter. Both the incomplete and complete plates are undone, not just the most recently drawn objects.

Implementing a Custom *error* Handler and Undo Grouping

As you revise the functions, notice how easy it can be to change the underlying functionality of your programs when they are divided into several smaller functions. Smaller functions are easier not only to change, but to retest if a problem is encountered.

The following steps explain how to update the drawplate function to include a custom *error* handler and undo grouping:

Open the drawplate.lsp file in Notepad (Windows) or TextEdit (Mac OS).

In the text editor area, add the text in bold:; Custom error handler with command functions (defun err_drawplate (msg) (if (/= msg "Function cancelled") (alert (strcat "\nError: " msg)) ) (command "._undo" "_e") (command "._u") ; Restore previous error handler (setq *error* old_err) (princ) ) ; Draws a rectangular plate that is 5x2.75 (defun c:drawplate ( / pt1 pt2 pt3 pt4 width height insPt textValue cenPt1 cenPt2 cenPt3 cenPt4 old_vars hole_list) (setq old_err *error* *error* err_drawplate) ; Command function being used in custom error handler (*push-error-using-command*) (command "._undo" "_be") ; Store and change the value of the system variables (setq old_vars (get-sysvars '("osmode" "clayer" "cmdecho"))) (set-sysvars '("osmode" "clayer" "cmdecho") '(0 "0" 0)) ; <Code break…> ; Save previous values to global variables (setq *drawplate_width* width) (setq *drawplate_height* height) (command "._undo" "_e") ; Restore previous error handler (setq *error* old_err) ; End using *push-error-using-command* (*pop-error-mode*) ; Exit "quietly" (princ) )

Click File Save.

Testing the Changes to the drawplate Function

The following steps explain how to test the changes that were made to the drawplate function:

Create a new drawing.

Start the appload command. Load the LSP files drawplate.lsp and utility.lsp. If the File Loading - Security Concerns message box is displayed, click Load.

At the Command prompt, type drawplate and press Enter.

At the Specify base point for the plate or [Width/Height]: prompt, pick a point in the drawing area to draw the plate and holes based on the width and height values specified.

At the Specify label insertion point: prompt, press Esc. The plate that was drawn is removed from the drawing, thereby restoring the drawing to its previous state.

Run the drawplate function again. Specify a point for the plate and label.

At the Command prompt, type u and press Enter. The completed plate is undone as expected.

# Chapter 20 Authoring, Managing, and Loading AutoLISP Programs

Entering AutoLISP® expressions directly at the Autodesk® AutoCAD® Command prompt is a great way to start learning AutoLISP programming. However, if you want to use expressions multiple times or in different drawings, you will need to enter them over and over again.

Instead of entering AutoLISP expressions at the Command prompt, you can store them in an ASCII text file with a .lsp extension. In addition to entering AutoLISP expressions in a LSP file, you can add nonexecutable expressions known as comments, which allow you to make notes to yourself in the code. After you create a LSP file, you must load it into AutoCAD before any of the expressions stored in the file can be executed.

Before loading a LSP file, you need to let AutoCAD know where it is located and that the location it is stored in is safe to load executable (LSP/ARX/DVB) files from. Once AutoCAD knows where your LSP files are located, you can then load them manually as needed, automatically at startup, or on demand.

Storing AutoLISP Expressions

Although you can enter AutoLISP expressions at the AutoCAD Command prompt, as part of a script file, or as a command macro used in the user interface, the most common method is to type them into a text editor and store them in a LSP file. AutoLISP programs are commonly stored in LSP files, but they can also be stored in menu AutoLISP (MNL) files. Menu AutoLISP files have the .mnl file extension.

MNL files contain AutoLISP programs that are used by command macros defined in a CUI/CUIx file. When a CUI/CUIx file is loaded into AutoCAD, AutoCAD looks for and loads an MNL file with the same name as the CUI/CUIx file being loaded. For example, if the acad.cuix file is loaded, AutoCAD looks for and loads the acad.mnl file if a file named acad.mnl? is found within the support file search paths defined in the Options dialog box (Windows) or Application Preferences dialog box (Mac OS).

NOTE

A LSP or MNL file must be saved to an ASCII text file, and it cannot include any special characters like a Rich Text or Microsoft Word document can.

Once a LSP file has been created, the code stored in the file can then be loaded into the AutoCAD program when it is needed. I discuss the text editors that can be used to create a LSP file in the next section, and you'll learn how to load a LSP file later, in the「Loading AutoLISP Files」section.

Selecting an Editing Environment

You don't have to buy additional software to create and edit AutoLISP program files, regardless of whether you are using Windows or Mac OS. Any of the following applications can be used to create or edit AutoLISP expressions stored in a LSP or MNL file:

Notepad (Windows Only) Notepad allows you to create and edit plain ASCII text files and is installed with Windows. Although Notepad isn't designed specifically for AutoLISP programming, it is the choice of many veteran AutoLISP developers. Notepad is the application you will primarily use with this book if you are using AutoCAD on Windows.

Visual LISP® Editor (Windows Only) The Visual LISP Editor is a specialized development environment that is designed for working with AutoLISP programs stored in LSP or MNL files. This editor supports colored syntax and tools that help you identify missing parentheses. Additionally, this editor allows you to load, format, check, and debug AutoLISP programs. I cover the Visual LISP Editor and its features in Chapter 21,「Using the Visual LISP Editor (Windows only).」

TextEdit (Mac OS Only) TextEdit allows you to create and edit plain ASCII text files and is installed with Mac OS. Like Notepad on Windows, TextEdit isn't designed specifically for AutoLISP programming, but it does contain all the basic editing features you want in an editor. TextEdit is the application you will primarily use with this book if you are using AutoCAD on Mac OS.

Throughout most of this book, I focus primarily on the core concepts of the AutoLISP programming language; for that, I decided to keep things simple by using Notepad and TextEdit. However, once you are comfortable with AutoLISP and if you are on Windows, I strongly recommend that you eventually make the transition to the Visual LISP Editor. If you are on Mac OS, the Visual LISP Editor isn't available unless you install Windows and AutoCAD on Boot Camp or Parallels. If you do lots of AutoLISP development, the Visual LISP Editor can save you time writing and debugging.

Creating an AutoLISP File

As I previously mentioned, a LSP file is a plain ASCII text file. You can use Notepad on Windows or TextEdit on Mac OS to create a LSP file, but since both of these applications commonly are used to work with TXT files, you will need to be sure to add the .lsp file extension to the files you create with these applications. If you are on Windows and want to use the Visual LISP Editor, consult the instructions in Chapter 21 for creating a LSP file.

NOTE

The examples in this section assume that you created a folder named MyCustomFiles in your Documents (or My Documents) folder on your local drive. If you have not created this folder, do so now, or if you created the folder in a different location, be sure you adjust the steps accordingly.

The following exercise explains how to create an AutoLISP file named mylisp.lsp on Windows:

Do one of the following: On Windows XP or Windows 7, click the Start button [All] Programs Accessories Notepad.

On Windows 8, on the Start Screen, type notepad and then click Notepad when it appears in the search results.

In Notepad, click File Save As.

In the Save As dialog box, browse to the MyCustomFiles folder that you created under the Documents (or My Documents) folder, or to the location where you want to store the LSP file.

In the File Name text box, type mylisp.lsp.

Click the Save As Type drop-down list and select All Files (*.*).

Click the Encoding drop-down list and select ANSI. Click Save.

In the text editor area, type the following expressions.(defun c:MSG () (alert "First AutoLISP file.")) (prompt "\nVersion 1.0 – My AutoLISP Programs")

The AutoLISP alert function displays a message box; the prompt function displays a message at the AutoCAD Command prompt.

Click File Save.

NOTE

I discussed the AutoLISP alert and prompt functions in Chapter 15,「Requesting Input and Using Conditional and Looping Expressions.」

If you are running AutoCAD on Mac OS, use the following steps to create a LSP file named mylisp.lsp:

In the Mac OS Finder, click Go Applications. In the Finder window, double-click TextEdit.

In TextEdit, click TextEdit Preferences. In the Preferences dialog box, on the New Document tab click Plain Text and deselect Smart Quotes. Close the dialog box. If a document was open when you first started TextEdit, close it now. Changes to the settings affect only future documents, those you create or open after the changes were made.

Click File New to create a plain ASCII text file.

Click File Save and type mylisp.lsp in the Save As text box. From the sidebar on the left, click Documents MyCustomFiles, or browse to the location where you want to store the LSP file. Click Save.

If prompted to use the .lsp extension, click Use.Lsp.

In the text editor area, type the following expressions:(defun c:MSG () (alert "First AutoLISP file.")) (prompt "\nVersion 1.0 – My AutoLISP Programs")

The AutoLISP alert function displays a message box; the prompt function displays a message at the AutoCAD Command prompt.

Click File Save.

After saving the file, you can load it into AutoCAD using one of the techniques explained in the section「Using the Load/Unload Applications Dialog Box to Load a LSP File」later in this chapter. Figure 20.1 shows the results of loading the mylisp.lsp file in AutoCAD and then executing the MSG function at the Command prompt.

Figure 20.1 Loading a custom program

Editing an AutoLISP File

You can edit LSP files using any of the applications described in the section「Selecting an Editing Environment」or any other application that supports editing plain ASCII text files. If the .lsp file extension has been associated with an ASCII text editor, you can simply double-click the file to open it in the associated editor. When no editor is associated with the LSP file type and you double-click on a file of that type, you are prompted to select an editor to open the file. Associate an editor with the LSP file type and make the changes to the file. Save the file as a plain ASCII text file and reload it in AutoCAD to test the code changes in the file.

Writing Modular Code

When you first start writing AutoLISP programs, you may tend to create large self-contained functions. As you write, you will notice similarities in the functions that you create, whether it is creating or modifying graphical and nongraphical objects, or working with system variables.

Instead of writing large functions that contain every expression required to solve a problem or complete a task, I recommend breaking large functions into smaller, more manageable, task-oriented functions. By breaking your functions down, you gain the following benefits:

Code can be reused across many different functions, thereby reducing the size of your programs when they are loaded into memory.

Code can be revised to take advantage of newer techniques or desired code changes without having to make the same changes in one or many locations in a single file or across multiple files.

Potential errors in a function are easier to identify and fix because there are fewer expressions to debug and evaluate.

Smaller functions make great building blocks to introduce new functionality.

The following is an AutoLISP function containing expressions that create and set as current a new layer named Object (or set the layer as current if it already exists) and draws a rectangle that is 6 × 3 units using the AutoCAD line command:

(defun c:drawrectangle ( / ) (command "._-layer" "_m" "Object" "_c" 2 "" "") (command "._line" '(0 0 0) '(6 0 0) '(6 3 0) '(0 3 0) "_c") )

Layers are common nongraphical objects in a drawing that are used to organize and control the display of graphical objects, such as lines and circles. Since layers are so common, you might consider creating a set of functions that are used to create a new layer or set a layer as current instead of repeating the same expressions in each of your functions.

The following shows how you might break down the expressions in the drawrectangle function into two functions named createlayer and createrectangle. You can then reuse them in other custom functions.

(defun createlayer (name color / ) (command "._-layer" "_m" name "_c" color "" "") ) (defun createrectangle (pt1 pt2 pt3 pt4 / ) (command "._line" pt1 pt2 pt3 pt4 "_c") )

The revised drawrectangle function would look like this:

(defun c:drawRectangle ( / ) (createLayer "Object" 2) (createRectangle '(0 0 0) '(6 0 0) '(6 3 0) '(0 3 0)) )

As I mentioned, creating smaller functions lets you reuse them fairly easily. The following shows a function named drawcircle that uses the function named createlayer to create and set a layer as current before drawing a circle:

(defun c:drawcircle ( / ) (createLayer "Object" 2) (command "._circle" '(3 1.5 0) 1) )

The drawrectangle and drawcircle functions in the previous examples use the createlayer function. Since these functions reference the same createlayer function, any changes to the createlayer function affect both of the functions. For example, it isn't ideal to create a new layer or modify that layer if it already exists in a drawing when you might simply want to just set the layer as current. The following is a revised version of the createlayer function that first tests to see whether the layer exists using the AutoLISP functions tblsearch and if:

(defun createlayer (name color / ) (if (/= (tblsearch "layer" name) nil) (setvar "clayer" name) (command "._-layer" "_m" name "_c" color "" "") ) )

If the layer already exists, it is set as current by assigning the name of the layer to the clayer system variable. If the layer doesn't exist in the drawing, it is then created and set as current. As you can see, proper planning of your code and using smaller functions makes it fairly easy to update your functions. I discuss the tblsearch function in Chapter 17,「Creating and Modifying Nongraphical Objects,」and the if function in Chapter 15.

Adding Comments

As a veteran programmer of over 16 years, I can honestly say that I formed my fair share of bad habits early on when first learning to program. One of the habits that I had to correct was adding very few comments (or not adding any) to my code. Comments are nonexecutable expressions that are stored as part of a LSP file. The concept of comments is not specific to AutoLISP alone but is part of most modern programming languages. The syntax used to indicate a comment varies from language to language.

The following are common reasons why you might want to add comments to a LSP file:

To document when the file was created and who created it.

To maintain a history of changes made to the program—what changes were made, when, and by whom.

To indicate copyright or legal statements related to the code contained in the file.

To explain how to use a custom function—if any arguments are expected and the type of data they might expect.

To explain what a set of AutoLISP expressions might be doing—you might remember what expressions are used for today, but it can become more of a challenge to remember what they are doing months or years later.

To mask an AutoLISP expression that you currently don't want to execute—during testing or while making changes to a program, you might want to temporarily not execute an expression but want to keep the original expressions for historical purposes.

Comments in AutoLISP programs are typically denoted with the use of a semicolon and are referred to as the single-line comment style. Expressions and text to the right of the semicolon are not executed; this allows you to add comments on a line by themselves or even after an AutoLISP expression.

The following example demonstrates the use of the single-line comment style to add comments that explain the purpose of a function or what the expressions in the function are used for:

; Createlayer function creates/modifies a layer and ; expects two argument values. ; ; Arguments: ; name – A string that represents the name of the layer to create or modify ; color – A numeric value (1 – 255) that represents the color of the layer ; ; Usage: (createlayer "Doors" 2) (defun createlayer (name color / ) ; Check to see if the layer exists before creating/modifying it (if (= (tblsearch "layer" name) nil) (command "._-layer" "_m" name "_c" color "" "") (setvar "clayer" name) ) )

The single-line comment style can also be used after an AutoLISP expression. The following demonstrates the use of comments after or before an AutoLISP expression:

(defun c:drawplate ( / pt1 pt2 pt3 pt4) ; Create the layer named Plate or set it current (createlayer "Plate" 5) ; Set the coordinates to draw the rectangle (setq pt1 '(0 0 0)) ; lower-left corner (setq pt2 '(5 0 0)) ; lower-right corner (setq pt3 '(5 2.75 0)) ; upper-right corner (setq pt4 '(0 2.75 0)) ; upper-left corner ; Draw the rectangle (createrectangle pt1 pt2 pt3 pt4) ; Display message to the user (prompt "\nRectangle drawn.") )

In the previous example, all of the comments provide information about an individual or set of AutoLISP expressions, with the exception of the last comment. The last comment is an AutoLISP expression that would normally be executed, but it won't be executed as part of the program because the expression is located to the right of the semicolon. This isn't the same situation with the comments placed after the AutoLISP expressions that define and assign values to the pt1, pt2, pt3, and pt4 user-defined variables since the semicolon is placed after each expression.

Although most comments will fit on a single line, there will be times when you might want to have a comment that spans more than one line. Such is the case with the comments that were shown before createlayer. Long comments that span multiple lines are often broken up into individual comments for readability, but this does require you to break a long line and place a semicolon in front of each individual line. However, there is a second comment style that you can use with longer comments or even inside an AutoLISP expression that might start and end on the same line. This second comment style is known as inline.

The inline comment style starts and ends with a semicolon but also requires two pipe symbols ( | ), which are used to mark the beginning and end of the comment. Unlike the use of the semicolon by itself, which affects all the text after it on the same line, the expressions and text inside an inline comment are not executed but anything after it will be.

The following demonstrates the use of both the inline comment style and the single-line comment style:

;| Createlayer function creates/modifies a layer and expects two argument values. Arguments: name – A string that represents the name of the layer to create or modify color – A numeric value (1 – 255) that represents the color of the layer Usage: (createlayer "Doors" 2) |; (defun createlayer (name color / ) ; Check to see if the layer exists before creating/modifying it (if (= (tblsearch "layer" name) nil) (command "._-layer" "_m" name "_c" color "" "") (setvar "clayer" name) ) ) (defun c:drawplate ( / pt1 pt2 pt3 pt4) ; Create or modify the layer named Plate (createlayer "Plate" 5) ; Set the coordinates to draw the rectangle (setq pt1 '(0 0 0) ;| lower-left corner |; ) (setq pt2 '(5 0 0) ;| lower-right corner |; ) (setq pt3 '(5 2.75 0) ;| upper-right corner |; ) (setq pt4 '(0 2.75 0) ;| upper-left corner |; ) ; Draw the rectangle (createrectangle pt1 pt2 pt3 pt4) ; Display message to the user (prompt "\nRectangle drawn.") )

NOTE

Single-line and inline comments are the primary comment styles used in a LSP file, but the Visual LISP Integrated Development Environment (VLIDE) does support a few additional comment styles. I discuss these comment styles in Chapter 21.

Undefining and Redefining Standard AutoCAD Commands

When you create custom functions, they typically introduce new functionality. However, you can also disable or override the functionality of a standard AutoCAD command using the undefine and redefine commands. When undefining commands, you want to make sure that you document this properly, as it can affect scripts, AutoLISP programs, menu macros, and much more. The documentation that you create should include comments in the LSP file that redefines the command, along with external documentation such as a ReadMe or Help file related to your custom programs.

The following example creates a user-defined function named explode, which prevents users from exploding a hatch or dimension object, and then undefines the standard AutoCAD explode command using the undefine command:

; Create a new Explode function (defun c:explode ( / ss) ; See if Pick First is enabled and if so, get the current objects (if (> (getvar "pickfirst") 0) (setq ss (ssget "_I" '((-4. "<OR")(0. "INSERT")(0. "POLYLINE") (0. "LWPOLYLINE")(-4. "OR>")))) ) ; If objects were not selected, prompt now (if (= ss nil) (setq ss (ssget '((-4. "<OR")(0. "INSERT")(0. "POLYLINE") (0. "LWPOLYLINE")(-4. "OR>")))) ) ; Use current implementation of the Explode command (initcommandversion 2) ; If objects were selected, explode them (if (/= ss nil) (command "._explode" ss "") ) (princ) ) ; Undefine the Explode command (command "._undefine" "explode")

A command is undefined in a drawing while it remains open after the use of the undefine command; the standard functionality of a command is restored when a drawing is created or opened. You can use the redefine command to restore an undefined command while a drawing remains open. Here is an example statement that restores the standard explode command, which was undefined in the previous example:

(command "._redefine" "explode")

Defining a Startup Function

In AutoLISP you can define a special function named s::startup. This function is executed when you create or open a drawing in AutoCAD, as long as it has been defined in a loaded LSP file. Although more than one LSP file can contain an s::startup function, only the last loaded definition of the function is retained. The s::startup function is typically used to initialize system variables, insert title blocks, or draw and modify objects in the current drawing upon opening.

Here is an example of the s::startup function:

(defun s::startup ( / old_attreq) (setvar "osmode" 39) ; END, MID, CEN, and INT (setvar "pickfirst" 1) ; Create layer for title block (command "._-layer" "_m" "titleblk" "_c" "7" "" "") ; Insert title block at 0,0 (setq old_attreq (getvar "attreq")) (setvar "attreq" 0) (command "._insert" "tb-c_size" "0,0" "1" "1" "0") (setvar "attreq" old_attreq) ; zoom to extents (command "._zoom" "_e") )

Loading AutoLISP Files

AutoLISP programs that are stored in a LSP file must be loaded into AutoCAD before they can be used. A number of methods can be used to load a LSP file. These fall into one of two categories: manual or automatic. Most LSP files are loaded using one of the manual techniques.

Manually Loading an AutoLISP File

AutoCAD is a graphics- and resource-intensive application, and it loads components into memory only as each is needed. LSP files are typically rather small in size, but loading a large number of them into AutoCAD can impact performance. For this reason, you should load a LSP file only as it is needed. Once a LSP file is loaded into memory, it is not removed from memory until you close AutoCAD or the drawing from which the LSP file was loaded.

Use the following techniques to manually load a LSP file into AutoCAD:

Load/Unload Applications Dialog Box (appload Command) The Load/Unload Applications dialog box allows you to browse to where your LSP files are stored and select which files you want to load. After selecting a LSP file, you click Load to load the file into memory. I explain how to load a LSP file with the Load/Unload Applications dialog box in the「Using the Load/Unload Applications Dialog Box to Load a LSP File」section later in this chapter.

Drag and Drop (Windows Only) LSP and other types of files can be dragged and dropped onto either the application or drawing windows of AutoCAD on Windows. When you drop a LSP file onto an open drawing window, AutoCAD loads the LSP file into memory for that drawing only.

AutoLISP load Function The AutoLISP load function allows you to load a LSP file from a script file, from a command macro defined in a CUI/CUIx file, at the AutoCAD Command prompt, or even from another LSP file. When you use the load function, it searches the paths that are listed under the Support File Search Path node in the Options dialog box (Windows) or Application Preferences dialog box (Mac OS). You should avoid using absolute file paths with the load function; if your drive mappings or folder structure change, the LSP file will fail to load.

TIP

The load function can be used in a menu macro—applied to a ribbon or toolbar button on Windows or a toolset button or menu item on Mac OS—to load a LSP file and start a function from the AutoCAD user interface. I explained how to customize the user interface in Chapter 5,「Customizing the AutoCAD User Interface for Windows」and Chapter 6,「Customizing the AutoCAD User Interface for Mac.」

The following is an example of loading a LSP file named utility.lsp with the load function:

(load "utility.lsp")

NOTE

LSP files that are loaded using one of the manual techniques described here are loaded only into the current drawing. You must load the LSP file into each and every drawing file where you want to use it. However, you can use the vl-load-all function to load a LSP file into all open and subsequently opened drawings for the current AutoCAD session.

Automatically Loading an AutoLISP File

Manually loading LSP files doesn't always create the best user experience, especially if you want certain functions to be available in each drawing file that is opened or created. Keep in mind, though, you don't want all of your LSP files to be loaded at startup because it takes away some of the computing resources from the operating system and AutoCAD.

You can use the following techniques to automatically load a LSP file into AutoCAD:

Startup Suite—(appload Command) The Startup Suite is part of the Load/Unload Applications dialog box (appload command). When a LSP file is added to the Startup Suite, the file is loaded after a drawing is opened. Removing a file from the Startup Suite causes the file not to be loaded in any future drawings that are opened but does not unload it from any drawing files that the LSP file was loaded into during the current session. If you want to use the Startup Suite to load LSP files, you must add the files to the Startup Suite on each workstation and AutoCAD user profile. I discuss how to add LSP files to the Startup Suite in the「Using the Load/Unload Applications Dialog Box to Load a LSP File」section later in this chapter.

Specific File Naming When you start AutoCAD or open a drawing, LSP files with specific names are automatically loaded if they are found in the support file search paths. Table 20.1 lists the filenames and order in which these files are loaded into AutoCAD (files are listed in the order they are loaded by AutoCAD; acad.rx is loaded first and then on down the list).

In addition to the files listed in Table 20.1, the LSP files you added to the Startup Suite in the Load/Unload Applications dialog box are loaded after each MNL file with the same name as a CUI/CUIx file being loaded into AutoCAD. After the files in the Startup Suite are loaded, the function (s::startup) is executed. The last file that is executed is the script file that is loaded with the /b or -b command-line switch. You learned about command-line switches in Chapter 4,「Manipulating the Drawing Environment.」

NOTE

On Windows, LSP files can also be loaded when a CUI/CUIx file is loaded. When a CUI/CUIx file is being edited with the Customize User Interface Editor (cui command), you can add LSP files to the LISP Files node.

AutoLISP autoload Function The AutoLISP autoload function allows you to load a LSP file based on the use of a function defined with the C: prefix in the file. When you use the autoload function, it searches the paths that are listed under the Support File Search Path node in the Options dialog box (Windows) or Application Preferences dialog box (Mac OS) for the LSP file and then loads the file before executing the function. You should avoid using absolute file paths with the autoload function, because if your drive mappings or folder structure change, the LSP file will fail to load. The expressions that use the autoload function should be loaded at startup. Consider adding these expressions to a LSP file and loading the file using a file like acaddoc.lsp or an MNL file.




