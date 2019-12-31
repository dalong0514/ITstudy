The ability to check code and perform parentheses matching in code is an important feature that makes the Visual LISP Editor more efficient than Notepad. Once you are done checking the code in your programs, you can load all the code or just the code that is selected in the current editor window.

Checking Code

The code-checking tool validates that the code in the current editor window will load successfully into AutoCAD and even checks for too many or too few arguments being passed to the functions used in the code. However, the argument values being passed to a function aren't checked. You can use code checking in one of two ways:

To check the code in the current editor window, click Check Edit Window on the Tools toolbar or choose Tools Check Text In Editor.

If you don't want to check all of the code in the current editor, select the code you want to check and click Check Selection on the Tools toolbar or choose Tools Check Selection.

Checking stops when an error is encountered or when the file has been successfully checked. The Visual LISP Editor then displays the Build Output window. If an error was encountered during checking, an error message and the faulty code are displayed in highlighted text (see Figure 21.7). Double-clicking the highlighted text in the Build Output window causes Visual LISP to highlight the faulty code in the editor window as well.

Figure 21.7 The Build Output window indicates the type of error encountered during checking.

Matching Parentheses

Keeping parentheses balanced in AutoLISP programs is an ongoing challenge. The Visual LISP parentheses-matching tools can help you identify a missing parenthesis. You can either select code between two balanced parentheses or move the cursor between matching parentheses. If you suspect you are missing a parenthesis, you can step through the code, matching parentheses to see if (and where) an opening or closing parenthesis is missing. When you select a Parentheses Match option, Forward moves the cursor toward the end of the file, whereas Backward moves the cursor toward the beginning of the file. If Parentheses Match or Parentheses Select cannot find the balancing parenthesis, Visual LISP sounds an audible bing. The cursor is not moved; no code is selected.

Playground Disaster to Incomplete Code

To save time and typos, you are copying and pasting partial code statements from another program when you get a call from your child's school. Your daughter fell off the monkey bars and needs stitches. You save your work, go pick up your child, rush off to the emergency room, soothe her while she's being stitched up, take her home, and don't get back to work until the next day.

The fact that you pasted partial code statements and didn't get to adding balancing parentheses (or removing the excess ones) before the call came in has completely slipped your mind. Out of habit, you open Visual LISP and, before adding any more code, you select the code block you added last and run Check Selection. Since the copy and paste left your program with three extra closing parentheses, an error message appears in the Build Output window. Starting at the end of the new code block, the Parentheses Match tools allow you to quickly step backward through the code, identify the partial code statements, and repair your code to working order.

Here's how you can use the Visual LISP parentheses-matching tools:

To Find the Balancing Parenthesis for a Closing Parenthesis Click immediately before a closing parenthesis that you want to match. With the cursor positioned within the code in the current editor window, choose Edit Parentheses Match Match Backward. Visual LISP identifies the matching opening parenthesis.

To Find the Balancing Parenthesis for an Opening Parenthesis Click immediately after an opening parenthesis that you want to match. With the cursor positioned within the code in the current editor window, choose Edit Parentheses Match Match Forward. Visual LISP identifies the matching closing parenthesis.

To View the Code between Matching Parentheses Click immediately after a closing parenthesis and then choose Edit Parentheses Match Select Backward. Or click immediately before an opening parenthesis and then choose Edit Parentheses Match Select Forward. Visual LISP selects the matching parentheses and the code between.

TIP

You can double-click in front of or after a parenthesis to have the Visual LISP Editor select the code between the adjacent parenthesis and the balancing parenthesis (the same as choosing Edit Parentheses Select Forward or Select Backward).

Loading Code

You can load the code in the current Visual LISP Editor window directly into AutoCAD. There is no need to use one of the methods for loading LSP files that I discussed in Chapter 20; you don't need to copy and paste the code to the AutoCAD Command prompt. Click Load Active Edit Window on the Tools toolbar or choose Tools Load Text In Editor to load all of the code in the current editor window.

If you want to load only specific statements from the current editor window, select the code you want to load and click Load Selection on the Tools toolbar or choose Tools Load Selection. After the code is loaded, switch to AutoCAD and use the loaded code. You can switch to AutoCAD from the Visual LISP Editor by clicking Activate AutoCAD on the View toolbar, by choosing Window Activate AutoCAD, or by clicking the AutoCAD icon on the Windows taskbar.

Debugging Code

In addition to the formatting and checking tools that I have already covered in this chapter, the Visual LISP Editor supports a variety of debugging tools that can make locating and resolving problems easier within a program. The following explains several of the debugging tools that are available:

Breakpoints Breakpoints allow you to interrupt the execution of a program that is loaded into the Visual LISP Editor and being executed in AutoCAD. When execution is interrupted, you can evaluate the values that have been assigned to variables and step through the remainder of the statements in the program to identify problems in real time. Position the cursor where you want to insert a breakpoint (typically immediately before an opening parenthesis), right-click, and choose Toggle Breakpoint from the context menu. The parenthesis is highlighted in red at the point where the program will be interrupted. After the breakpoint is set, execute the program in AutoCAD. Breakpoints set by the Visual LISP Editor work only while the program is open in the Visual LISP Editor window.

Once execution is interrupted, you can use Step Into, Step Over, and Step Out on the Debug toolbar to step through a program statement by statement.

Choose Step Into when you want to step through and evaluate all expressions of a code statement, even nested expressions.

Use Step Over when you want to evaluate a code statement as a whole and are not interested in stepping through each nested expression one at a time.

The Step Out tool resumes normal execution and ignores any further breakpoints that are set.

When you are finished, click Continue to resume normal execution until the next breakpoint is set, if one has been set, or click Reset to stop execution and abort the function that is currently interrupted. Continue and Reset are also located on the Debug toolbar. The Step Into, Step Over, Step Out, Continue, and Reset (Quit) options can also be found on the Debug menu.

Watch Window The Watch window allows you to see the current value assigned to a global or local variable while code is being executed from the Visual LISP Editor. You can see only the current value of a local variable when execution is paused by a breakpoint. You can add to the Watch window the variables or statements, known as watches, for which you want to see the current value by selecting and right-clicking the code in the editor window and then choosing Add Watch. A watch can be added before execution is started or while execution is paused by a breakpoint. If the Watch window isn't displayed, click Watch Window on the View toolbar or choose View Watch Window.

Error Trace and Last Error Source Often when you are trying to debug a program, you aren't always sure where an error occurred. The Visual LISP Editor can help you identify the code that caused the error. Choose View Error Trace to get information about the last error that occurred. In the Error Trace window, double-click each entry in the window to learn more about the error that occurred. Use the Last Error Source option on the Debug menu to select the code that caused the error.

You will have a chance to use all three of these debugging features later in this chapter in the「Exercise: Working with the Visual LISP Editor」section.

Table 21.1 lists some of the other debugging tools that the Visual LISP Editor offers. You can learn more about these debugging tools in the AutoCAD Help system.

Table 21.1 Additional Visual LISP Editor debugging tools

Tool Description

Break On Error Suspends execution when an error occurs and allows you to evaluate variable values and code statements to identify the origin of the error. Choose Debug Break On Error to toggle the option.

Animate Slows the execution of a custom program so it can be watched in real time. Choose Debug Animate to toggle the option. You can adjust the delay between statements by choosing Tools Environment Options General Options, clicking the Diagnostics tab, and specifying a new value in the Animation Delay text box. When the program is executed, the execution is similar to what happens if you manually click Step Into all the way through a program.

Inspect Window Displays additional information about a symbol, value, or expression in a window.

Trace Stack Window Traces the use of a function during the execution of a program. Trace Stack Window is a modernized version of the trace and untrace functions discussed in Chapter 19.

Browsing the Objects in a Drawing

The Visual LISP Editor also provides a few tools that allow you to step through and evaluate the graphical and nongraphical objects in a current drawing. Access these tools by choosing View Browse Drawing Database and then selecting the option that lets you work with the objects you are interested in.

Creating a Visual LISP Project

The Visual LISP Editor supports a concept known as projects. Projects are a means of grouping related program and data files. Projects are optional, but they can make opening and managing multiple LSP and other resource files easy. You create a project by choosing Project New Project and then specifying a location and name for the project in the New Project dialog box.

In the Project Properties dialog box (see Figure 21.8), on the Project Files tab, you specify the files that you want to be part of the project and the order in which they should be loaded. Click the ellipsis button next to the Look In text box to specify the folder that contains the files you want to add to the project. Select a file from the list and click the > button to add the file to the project, or click the < button to remove a file from the project. Use the Top, Up, Down, and Bottom buttons to set the load order of the files in the project when compiled.

Figure 21.8 Organizing LSP files into a project

The Build Options tab allows you to control compilation, merge files, and specify message modes along with the output locations for the project when it is compiled into an FAS file. An FAS file is a secure and faster-loading alternative to LSP files that doesn't allow editing. AutoCAD will always try to load an FAS file in place of a LSP file, unless the LSP file is newer. A project can also be built into a standalone AutoCAD application known as a VLX file.

A VLX file is secure, like an FAS file, but it can also be used to combine multiple program and resource files in a single file that can be loaded into AutoCAD. (You can learn more about creating VLX files in the next section.) I recommend leaving the settings alone since they are the best options for most programs, but feel free to experiment with them. You can learn more about these settings in the AutoCAD Help system. Click OK to create the new project (PRJ) file. Once you create a new project or open one (by choosing Project Open Project), the project window opens (see Figure 21.9) with the name of the project displayed in the window's title bar.

Figure 21.9 Accessing files from the project window

The project window allows you to do the following:

Change the properties of a project

Open a file by double-clicking it from the Files list in the main area of the project window

Add files to a project

Load and check the syntax of a file

Load a selected LSP or FAS file

Build FAS files for each LSP file in the current project

Close and save a project

The toolbar displayed along the top of the project window gives you access to commonly used tools. Additional tools are available via context menus that open when you right-click a file or an empty area in the project window.

Once you've added files to your project and specified the project's settings, choose Project Build Project FAS to compile the LSP files into FAS files—one FAS file for each LSP file by default. Then, review the output locations in the Build Output window to determine where the generated files were placed. The Visual LISP Editor places the FAS files in the same folder as the PRJ file unless you specified a different location in the Project Properties dialog box. Once an FAS file has been built, you can load the file using the same methods described in Chapter 20 for loading a LSP file.

Compiling LSP and PRJ Files into a VLX File

You've seen that a LSP file can be compiled into an FAS file after it has been added to a PRJ file. You can also combine and compile LSP and PRJ files into a VLX file by using the New Application wizard. Unlike FAS files, VLX files can also contain the resource files that the LSP or FAS files require. Resource files can be TXT files (data sources) or DCL files, which are used to implement dialog boxes with an AutoLISP program. I cover creating dialog boxes for AutoLISP in Chapter 23,「Implementing Dialog Boxes (Windows only).」

NOTE

Check with your company's IT department before compiling and distributing your LSP files and projects as VLX files. Some companies don't allow VLX files on their network simply because of the associations they have with some computer viruses and the inability to see the code in the files. However, LSP and FAS files have also been known to be used to spread computer viruses. Use the security features Autodesk offers in the latest releases of AutoCAD, such as the Trusted Locations option in the Options dialog box, to help prevent the loading and execution of malicious code.

To generate a VLX file, choose File New Application Wizard. The New Application wizard offers two modes: Simple and Expert. The following steps describe how to create a VLX file using the Expert mode:

Start the New Application wizard in Expert mode.

On the Application Directory page, specify a location and name for the application. Click Next.

If you wish to protect your application's namespace, select the Separate Namespace option on the Application Options page. If not, leave the option unchecked. Click Next. When you select the Separate Namespace option, the wizard will create a separate namespace for the functions and variables in your custom program. That way, when you load the VLX file they are not overwritten by AutoCAD-defined functions and variables that have the same name.

On the LISP Files To Include page, select the LSP, FAS, or PRJ files that you want to add to the application and set the load order for the files. Click Next.

If you have LSP, FAS, PRJ, DCL, or TXT files that you want to add as resources for the application, select them on the Resource Files To Include page. Resources are optional; you do not need to select any files. When you are finished, click Next.

On the Application Compilation Options page, select Standard. Optionally, you can choose Optimize and Link, which might provide your program with better performance. When you are finished, click Next.

On the Review Selections/Build Applications page, select the Build Application check box and click Finish. The wizard saves the application make (PRV) file and builds the VLX file.

You can use the other options under File Make Application to load and rebuild a VLX file from an existing PRV file. The original files that were added to the PRV file must still be available, though. Once you've built a VLX file, you can load it using the same methods described in Chapter 20 for loading a LSP file.

Exercise: Working with the Visual LISP Editor

In this section, you will take another look at the badcode function from Chapter 19 to demonstrate some of the AutoLISP functions for debugging a program. You will also have an opportunity to continue to work with the drawplate function originally introduced in Chapter 12,「Understanding AutoLISP.」The key concepts I cover in this exercise are:

Formatting, Checking, and Debugging Code The Visual LISP Editor provides many great features that assist you in formatting and checking code. The formatting and checking tools also provide a basic level of debugging tools to ensure the structure of your code is sound.

Stepping Through and Inspecting Code Although the debugging techniques I described in Chapter 19 are essential, breakpoints—which allow you to interrupt and then step through your code—can be great time-saving tools. While a program is interrupted, the Visual LISP Editor also lets you inspect code and variable values in real time.

Organizing LSP Files into a Project Projects make accessing your LSP files much easier compared to having to browse for and open each file that you want to access. Files added to a project can also be compiled to secure your custom programs from users who shouldn't be making changes to them.

NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Handling Errors in the drawplate Function」section of Chapter 19. If you didn't complete the steps, do so now or start with the ch21_drawplate.lsp and ch21_utility.lsp sample files available for download from www.sybex.com/go/autocadcustomization. Place these sample files in the MyCustomFiles folder within the Documents (or My Documents) folder or in the location you are using to store the LSP files. Once you've stored the sample files on your system, remove the characters ch21_ from each filename.

Formatting, Checking, and Debugging the badcode Function

Often when you start a new project, formatting code takes a backseat to the actual problem you are trying to solve. However, once you encounter a problem within your code, you will understand why accomplished programmers spend time formatting their code. Once the code is formatted, checking it is much easier since you can visually determine where a parenthesis or quotation mark is missing.

The following steps explain how to format, check, and debug the badcode function for problems, and then fix those problems:

At the AutoCAD Command prompt, type vlide and press Enter.

In the Visual LISP Editor, choose File Open File.

When the Open File To Edit/View dialog box is displayed, browse to either the MyCustomFiles folder within the Documents (or My Documents) folder or the location of the exercise files for this book. Select the ch21_debuggingex.lsp file and click Open. The code in the editor window should look like the code shown on the left side of Figure 21.10. By the end of this exercise, it will look like the code on the right—and you won't have had to format each line one at a time.

Choose Tools Format Code In Editor. An Info message box appears with the message Formatting stopped:Unbalanced token. This is the result of a missing closing parenthesis. Click OK to close the message.

Figure 21.10 Unformatted and formatted code

The formatting tools available through the Visual LISP Editor work only with code that has valid structure and can be loaded into AutoCAD. Use the next steps to troubleshoot and repair the code so it can be properly formatted:

With the ch21_debuggingex.lsp file open in the current editor window, choose Tools Check Text In Editor.

In the Build Output window, double-click the highlighted error message ; error: malformed string on input. You are returned to the badcode function editor window, but the text it highlights is not exactly near the problem since the Visual LISP Editor simply counts quotation marks to determine balance. Most of the text in the editor window is displayed in the color (magenta is the default) applied to the string data type as a result of a missing quotation mark.

Find the code (getstring "\nEnter a string: ) and change it to (getstring "\nEnter a string: "). Notice that the text color changes as a result of adding the missing quotation mark.

Choose File Save.

In the next steps, you'll locate and add a missing parenthesis:

Choose Tools Check Text In Editor.

In the Build Output window, double-click the highlighted error message ; error: malformed list on input. You are returned to the badcode function editor window, and now all of the text is highlighted, indicating a closing parenthesis is missing.

Click after the last parenthesis of the badcode function and then choose Edit Parentheses Matching Select Forward. Notice the code is selected backward to the statement that starts with (if str instead of balancing the defun function. The missing parenthesis is somewhere inside the highlighted text.

Double-click to the right of the closing parenthesis that is located above the (princ) code statement. Notice the code is selected backward to the statement that starts with (progn instead of balancing the (if str statement.

Double-click to the right of the closing parenthesis that is located above the one you clicked to the right of in step 4. The (if int (prompt (strcat "\nDivisor: " (rtos (/ 2.0 int)))) code statement and the closing parenthesis are selected.

Double-click to the right of the (if int (prompt (strcat "\nDivisor: " (rtos (/ 2.0 int)))) code statement. Only part of the code statement is highlighted now: (prompt (strcat "\nDivisor: " (rtos (/ 2.0 int)))).

Add a closing parenthesis at the end of the (if int (prompt (strcat "\nDivisor" (rtos (/ 2.0 int)))) statement to balance out the statement.

Choose File Save.

In the next steps, you'll identify and address a problem related to passing too many arguments to a function:

Choose Tools Check Text In Editor.

In the Build Output window, double-click the highlighted error message ; warning: too many arguments: (PROMPT "\nValue entered: " STR). You are returned to the badcode function editor window and the bad statement is now selected.

Change (prompt "\nValue entered: " str) to (prompt (strcat "\nValue entered: " str)).

Choose Tools Check Text In Editor. No error is returned this time, so the code can now be formatted.

Close the Build Output window and choose Tools Format Code In Editor.

Choose File Save. The results you get should be similar to those shown on the right side of Figure 21.10.

Stepping Through and Inspecting the badcode Function

In this exercise, you'll continue to work with the ch21_debuggingex.lsp file that you checked, formatted, and performed some basic debugging on already in the previous section. Stepping through code line by line allows you to visually identify what is happening in your code, whether it is executing as expected or if an error occurs, and see which branches of a program are being followed based on the results of the logical tests. Additionally, you can view the current values of the variables in the program at specific times to ensure they have the correct data before they are passed to a function.

The following steps explain how to set a breakpoint, step through code, and view the current value of a variable:

Open the Visual LISP Editor and the ch21_debuggingex.lsp file if they are not already open.

In the editor window, locate and click immediately before the statement that starts with (setq str.

Right-click and choose Toggle Breakpoint to add a breakpoint to the opening parenthesis of the statement. The opening parenthesis should change color and appear in a colored background (white text on a red background is the default); this indicates that a breakpoint has been set (see Figure 21.11).

Locate and add a breakpoint to the opening parenthesis of the statement that starts with (if int.

Choose Tools Load Text In Editor.

Switch to AutoCAD.

At the Command prompt, type badcode and press Enter. Execution of the function starts and the Visual LISP Editor is brought back to the foreground when execution is interrupted at the first breakpoint. You can tell execution has been interrupted because the line of code with the first breakpoint is selected, but also because the tools on the left side of the Debug toolbar are now enabled, as shown in Figure 21.12.

Select the text str in the statement that starts with (setq str. Right-click and choose Add Watch. If the Add Watch dialog box is displayed, click OK. The Watch window is displayed and lists the str variable and its current value (see Figure 21.13).

NOTE

You can remove variables from the Watch window. Select the variable in the Watch window that you wish to remove, right-click, and choose Remove From Watch.

Select the text int in the statement that starts with (setq int and right-click. Choose Add Watch. If the Add Watch dialog box is displayed, click OK.

On the Debug toolbar, click Step Into (or choose Debug Step Into) twice. Evaluation of the statement is moved to the inner list, (getstring "\nEnter a string: "), and then the statement is evaluated. Focus shifts to AutoCAD; if it doesn't, you might not have clicked Step Into enough times.

At the Enter a string: prompt, type debug and press Enter.

The Visual LISP Editor becomes the focus. Click Step Into again. In the Watch window, the value of the str variable is now shown as debug instead of its previous value of nil.

On the Debug toolbar, click Continue (or choose Debug Continue).

At the Enter an integer: prompt, type 0 and press Enter.

On the Debug toolbar, click Step Over (or choose Debug Step Over). As a result of trying to divide 2 by 0, an error occurred and the program stopped executing. You can tell an error occurred because the text _1$ is displayed in the Visual LISP Console window. _1$ indicates that the program was left in debugging. The Reset button on the Debug toolbar is also still activated, another sign that debugging is still available and that the program didn't end successfully.

NOTE

Remember that Step Over evaluates all nested statements as a whole and doesn't step you through each nested statement one at a time. You could have clicked Step Into in the previous step, but it would take using Step Into more than 10 times to get through the code.

Choose View Error Trace. When the Error Trace window opens, information about the most recent error that occurred in AutoLISP is displayed (see Figure 21.14). Typically, the first entry represents the error message; it is followed by the statement and function name where the error occurred.

In the Error Trace window, double-click the first entry. A message box with the message :ERROR-BREAK: divide by zero is displayed. This is similar to the message you would see at the AutoCAD Command prompt. Click OK.

TIP

To resolve this problem, you should add an if statement to the code to ensure that the program never tries to divide by 0. Adding this code to the program is beyond the scope of this exercise.

In the Error Trace window, right-click the second entry; (/ 2.0 0). Choose Call Point Source. The statement that caused the error is highlighted.

Choose View Breakpoints Window. When the Breakpoints window is displayed, click Delete All. All the breakpoints you set earlier are removed.

Choose Window Activate AutoCAD and execute the badcode function again. Enter the values debug and 2 this time. The function completes as expected and the output from the function is displayed in the command-line window.

Figure 21.11 Breakpoint set in the editor window

Figure 21.12 Execution paused as a result of a breakpoint

Figure 21.13 Watching variable values with the Watch window

Figure 21.14 Viewing information about the recent error

Creating and Compiling a Project

Projects make it easy to access your LSP files or those that are related to a set of functions. Although creating a project is optional, doing so can save you some time managing complex programs by making everything available from a single place, especially since files need to be opened in the Visual LISP Editor to take advantage of the editor's debugging tools.

The following steps explain how to create a project for the drawplate function:

At the AutoCAD Command prompt, type vlide and press Enter.

In the Visual LISP Editor, choose Project New Project.

When the New Project dialog box is displayed, browse to either the MyCustomFiles folder within the Documents (or My Documents) folder or the location where you stored the exercise files for this book.

In the File Name text box, type drawplate and click Save.

When the Project Properties dialog box is displayed, click the ellipsis button to the right of the Look In text box. Browse to the folder you specified in step 3.

Choose Drawplate and Utility from the Files list box (located on the left, below the Look In text box) and click >.

Click OK.

In the DrawPlate project window, double-click the DrawPlate item. Notice the file is opened in an editor window and is ready for you to make changes.

In the editor window, change (load "utility.lsp") to (load "utility") so that AutoCAD loads the FAS or LSP file if either is found. You will remember that AutoCAD will always try to load an FAS file in place of a LSP file, unless the LSP file is newer.

On the toolbar of the DrawPlate project window, click Build Project FAS.

Switch to AutoCAD and create a new drawing. Load the drawplate.fas file with the appload command.

TIP

The FAS file should be placed in the same folder as the project. If you cannot find the file, return to the Visual LISP Editor and review the path location of the FAS file in the Build Output window.

At the Command prompt, type drawplate and press Enter. Follow the prompts that are displayed. The plate should be created as expected.

Chapter 22

Working with ActiveX/COM Libraries (Windows only)

The AutoLISP® functions you have learned up to this point have been, for the most part, platform neutral and are unofficially known as Classic AutoLISP or Core AutoLISP. Starting with the Autodesk® AutoCAD® 2000 program, AutoLISP saw an architecture change that allowed for the use of the Microsoft ActiveX technology. ActiveX is a technology that enables applications to communicate and exchange information. COM (Component Object Model) is a library of objects that let you make changes to or query exposed objects. COM is an example of ActiveX.

In this chapter, you will learn the basics of using ActiveX with AutoLISP and how to leverage the AutoCAD, Microsoft Windows, and Microsoft Office COM libraries. Although this chapter doesn't go into great depth, it will give you a starting point and a general understanding of the functions you need to become familiar with in order to use ActiveX and access COM libraries. The primary reasons to use COM are to monitor actions in AutoCAD with reactors, access external applications such as Microsoft Word or Excel, and work with complex objects, such as tables and multileaders.

Understanding the Basics of ActiveX

ActiveX is the technology that allows for the use of COM. It is often associated with Visual Basic for Applications (VBA) and Visual Basic (VB) scripting these days, but it can be used by many modern programming languages, such as VB.NET and C++. Although many people refer to ActiveX and COM as the same thing, they aren't. ActiveX is the technology that was developed by Microsoft to allow software developers to expose objects using COM, thereby letting programmers communicate with the programs in new ways.

In general, there are three concepts you need to understand about working with ActiveX in AutoLISP programs:

Classes, objects, and collections

Methods and properties

Variant and array data types

Accessing Classes, Objects, and Collections

Classes are the elements on which a COM library is built—think of them as a recipe. The AutoCAD COM library has classes for the AutoCAD application, a drawing (known as a document) file, and the graphical and nongraphical objects that are stored in a drawing. An object is an in-memory and unique instance of a class. Although a collection is also an object, it is a container for objects of the same type.

Working with Objects

The vla-object data type is used in AutoLISP to represent an object or collection. (You'll learn how to work with the AutoCAD COM library in the「Using the AutoCAD COM Library」section, and with the COM libraries related to Windows and Microsoft Office in the「Leveraging the Windows and Microsoft Office COM Libraries」section, later in this chapter.) Many of the objects you will want to work with can be accessed using properties and methods described in the next section. However, there are some objects that you must create or get an instance of before you can work with them.

For example, you can use the vlax-create-object function to create an instance of an application or secondary object that isn't accessible from an object that is already in memory. The vlax-get-object function can be used to get an instance of an object that is already in memory. When an object is in memory, it can be accessed and manipulated. The following shows the syntax of the vlax-create-object and vlax-get-object functions:

(vlax-create-object prog_id) (vlax-get-object prog_id)

The prog_id argument is a string that represents the program ID of the object you want to create or get. The program ID follows the syntax of vendor.component, and it can optionally have a version number as well, for a syntax of vendor.component.version. Typically, vendor is the name of the software or company that created the component, whereas component is commonly a class.

For example, if you wanted to create or check for an instance of AutoCAD you would use the program ID of AutoCAD.Application. The AutoCAD program ID optionally supports a version number that allows you to look for a specific AutoCAD release. The version number always consists of a major value, while some version numbers can contain both a major and a minor value. The major version of 19 is shared between AutoCAD 2013 and 2014, but if you want to refer to AutoCAD 2014 you use the minor number of 1. The program ID for AutoCAD 2014 is AutoCAD.Application.19.1. If you want to reference AutoCAD 2015, you use AutoCAD.Application.20 for the program ID. Refer to the AutoCAD Help system for the version number assigned to your AutoCAD installation.

The vlax-create-object and vlax-get-object functions return a vla-object if a new object is created or if an object with the program ID is already in memory; nil is returned if the object couldn't be created or retrieved from memory. The following shows how to create a new instance of the AutoCAD True Color (AcCmColor) and Microsoft Word (Application) objects. The AcCmColor object is used to manipulate the color value assigned to a drawing object.

; Creates an instance of an AutoCAD True Color object (setq clrObj (vlax-create-object (strcat "AutoCAD.AcCmColor." (substr (getvar "acadver") 1 2)))) #<VLA-OBJECT IAcadAcCmColor 000000002dcdd650> ; Creates an instance of the most recently used Microsoft Word application (setq wordObj (vlax-create-object "Word.Application")) #<VLA-OBJECT _Application 000000002f1e3c78> ; Attempts to create an instance of the Microsoft Word 2010 application ; but the application is not installed on this workstation (setq wordObj (vlax-create-object "Word.Application.14")) nil ; Creates an instance of the Microsoft Word 2013 application; installed (setq wordObj (vlax-create-object "Word.Application.15")) #<VLA-OBJECT _Application 000000002f1e3b98>

The following shows how to get an instance of the Microsoft Word application that has already been started:

; Gets an instance of a non-version-specific release of the ; Microsoft Word application that is in memory (setq wordObj (vlax-get-object "Word.Application")) #<VLA-OBJECT _Application 000000000a92e568>

Although you can use the vlax-get-object function to get an instance of an object in memory, or create a new instance of an object with the vlax-create-object function, the vlax-get-or-create-object function combines the functionality of both. If an object already exists, vlax-get-or-create-object returns the object and, if not, a new instance of the object is created. vlax-get-or-create-object has the same syntax as vlax-create-object.

; Gets/creates an instance of the most recently used Microsoft Word application (setq wordObj (vlax-get-or-create-object "Word.Application")) #<VLA-OBJECT _Application 000000000a92e568>

When an object is created with the vlax-create-object or vlax-get-or-create-object function, it must be released from memory when it is no longer used. You use the vlax-release-object function to release an object; the function must be passed the value returned by the vlax-create-object or vlax-get-or-create-object function. The vlax-release-object function returns a random integer value that has no specific meaning if the value it was passed is a valid object; an error is returned if the value passed wasn't a valid object that could be released.

The following code shows how to release an object created with the vlax-create-object or vlax-get-or-create-object function:

(vlax-release-object wordObj) 0 (vlax-release-object cObj) ; error: null interface pointer: #<VLA-OBJECT 0000000000000000>

Working with Collections

Collections are objects that can be queried and modified using properties and methods, but they are also containers that hold similar objects. A collection fundamentally is similar to a symbol table; you can work with a symbol table and add new objects to it, but you can't create a new symbol table. All the collections that you need in order to work with AutoCAD objects are defined as part of the AutoCAD ActiveX API. For example, a Layers collection contains all of the Layer objects in a drawing, and a Documents collection contains all the open drawings (or Document objects) in the current AutoCAD session. You can get an object from a collection using the Item method, add a new object to a collection using the Add method, and remove an object from a collection using the Delete method.

If you want to step through a collection and perform a set of statements on each object, you can use the vlax-for AutoLISP function, which is similar to the foreach function. The following shows the syntax of the vlax-for function:

(vlax-for var coll [expressionN …])

Here are its arguments:

var The var argument specifies the user-defined variable, which you use to reference the current item of the coll argument as the collection is being stepped through.

coll The coll argument specifies a collection object of the vla-object data type, which should be stepped through one item at a time.

expressionN The expressionN argument represents the expressions that should be executed when each object in the coll argument is found. The object is located using the name in the var argument.

The following is an example of the vlax-for function that steps through the Layouts collection and returns the name of each layout in a drawing:

; Imports the functions for the AutoCAD COM library, ; if not already available (vl-load-com) ; Gets the current drawing (setq curDoc (vla-get-activedocument (vlax-get-acad-object))) ; Gets the Layouts collection (setq layouts (vla-get-layouts curDoc)) ; Creates a report header (prompt (strcat "\nLayouts count: " (itoa (vla-get-count layouts)))) (prompt "\nLayouts: ") ; Steps through the objects in the collection (vlax-for layout layouts (prompt (strcat "\n " (vla-get-name layout))) ) ; The output from the previous expressions Layouts count: 3 Layouts: Layout1 Layout2 Model

You can use the vlax-map-collection function to execute a single AutoLISP function on each object in a collection. The following shows the syntax of the vlax-map-collection function:

(vlax-map-collection coll 'func)

Here are its arguments:

coll The coll argument specifies the collection object, of the vla-object data type, that should be stepped through one item at a time.

‘func The func argument represents the function you want to execute on each object in the coll argument. An apostrophe must be placed in front of the function name to let AutoLISP know it is a value that should not be evaluated.

Specifying Properties and Invoking Methods

A class uses two different approaches to expose itself to a programming language such as AutoLISP or VBA: properties and methods. They are available when an instance of a class is created in memory as an object. Properties are used to describe and query the characteristics of an object. For example, the Length and TrueColor properties of a Line object are used to specify that line's length and color. Properties can be designated as read-only.

Methods are used to manipulate and perform an action on an object. ActiveX allows you to define two types of methods: subroutines and functions. Subroutines never return a value; functions can return a single value. For example, the Delete and Copy methods are used to remove or duplicate an object in a drawing. The Delete method doesn't return a value, whereas the Copy method returns a new instance of an object.

The objects in a COM library are typically unique, so the vlax-dump-object function can be used to list the properties and methods that a particular object supports. The following shows the syntax of the vlax-dump-object function:

(vlax-dump-object obj [flag])

Here are its arguments:

obj The obj argument is a value of the vla-object type, which is returned by a method or property, or is available as the var argument of the vlax-for function.

flag The flag argument is an optional argument that allows you to specify whether the returned output lists only the properties or the properties and methods supported by an object. A value of T returns both supported properties and methods, whereas no value or a value of nil returns only the supported properties.

Here's an example that shows how to list the properties and methods of an object with the vlax-dump-object function:

(setq clrObj (vlax-create-object (strcat "AutoCAD.AcCmColor." (substr (getvar "acadver") 1 2)))) #<VLA-OBJECT IAcadAcCmColor 000000002dcdd650> (vlax-dump-object clrObj T) ; IAcadAcCmColor: AutoCAD AcCmColor Interface ; Property values: ; Blue (RO) = 0 ; BookName (RO) = "" ; ColorIndex = 0 ; ColorMethod = 195 ; ColorName (RO) = "" ; EntityColor = -1023410176 ; Green (RO) = 0 ; Red (RO) = 0 ; Methods supported: ; Delete () ; SetColorBookColor (2) ; SetNames (2) ; SetRGB (3) T

(RO) after a property name indicates that the property is read-only and the value cannot be changed. The number in the parentheses after each method listed in the Methods supported section of the output indicates the number of arguments that the method expects; no number in the parentheses indicates the method doesn't accept any argument values.

Getting and Specifying the Value of an Object's Property

The vlax-get-property and vlax-put-property functions are used to query and set the values of an object property. The vlax-get-property function returns the current value of the object property; the vlax-put-property function returns nil if the value was successfully assigned to the object's property. When the value of a property is changed with the vlax-put-property function, the object is updated immediately. Refer to the COM library's documentation for the type of value that will be returned or that the property expects. See the section「Using the AutoCAD COM Library」to learn how to access information on the AutoCAD COM library help.

The following shows the syntax of the vlax-get-property and vlax-put-property functions:

(vlax-get-property obj 'prop) (vlax-put-property obj 'prop val)

Here are their arguments:

obj The obj argument is a value of the vla-object type, which is returned by a method or property, or is available as the var argument of the vlax-for function.

‘prop The prop argument specifies the name of the particular property you want to query or set. The property name must be prefixed with an apostrophe. An apostrophe must be placed in front of the property name to let AutoLISP know it is a value that should not be evaluated.

val The val argument specifies the new value to be assigned to the property.

Here are some examples that show how to get and set a property value of an object. In these examples, you work with the ColorMethod and ColorIndex properties of an AutoCAD True Color object:

(setq clrObj (vlax-create-object (strcat "AutoCAD.AcCmColor." (substr (getvar "acadver") 1 2)))) ; Sets the value of the ColorMethod property to acColorMethodByACI ; acColorMethodByACI indicates that the color should ; be based on an ACI color value (vlax-put-property clrObj 'ColorMethod acColorMethodByACI) nil ; Gets the current value of the ColorIndex property ; A value of 256 specifies that the color represents ByLayer (vlax-get-property clrObj 'ColorIndex) 256 ; Releases the AutoCAD True Color object because it was created with ; the vlax-create-object (vlax-release-object clrObj)

In the previous example, acColorMethodByACI is a constant variable value that is exposed as part of the AutoCAD COM library. This constant value tells AutoCAD you want to work with one of the standard 255 ACI colors, and not a True or Color Book color.

You can determine whether an object supports a specific property by using the vlax-property-available-p function. A value of T is returned if the object supports the specified property. The following shows the syntax of the vlax-property-available-p function. See the argument descriptions of the vlax-get-property function earlier in this section:

(vlax-property-available-p obj 'prop)

Invoking an Object Method

The vlax-invoke-method function is used to execute an object method and pass to that method any argument values that are expected. A value can be returned by the method through the executed vlax-invoke-method function or by reference to the variables passed to the method. Refer to the particular method's documentation for the type of values that can be passed or for an explanation of the values returned by the method. (See the section「Using the AutoCAD COM Library」later in this chapter to learn how to access information on the AutoCAD COM library help.)

The following shows the syntax of the vlax-invoke-method function:

(vlax-invoke-method obj 'method [argN …])

Here are its arguments:

obj The obj argument is a value of the vla-object type, which is returned by a method or property or is available as the var argument of the vlax-for function.

‘method The method argument is the name of the method you want to execute. The method name must be prefixed with an apostrophe. An apostrophe must be placed in front of the method name to let AutoLISP know it is a value that should not be evaluated.

argN The argN argument is the value(s) to be passed to the method. If the argument you specify is meant to return a value, that argument must be prefixed with an apostrophe. The documentation in the AutoCAD Help system for the method will let you know if a value is passed back to the variable specified as an argument instead of returned by the function. For example, the GetBoundingBox method returns values to its two arguments that represent the minimum and maximum extents of an object. The code statement would look similar to (vlax-invoke-method lineObj 'GetBoundingBox 'min 'max). See the AutoCAD COM library documentation for additional information.

Here is an example that shows how to invoke a method. This example sets the Red element of the RGB color to a value of 255 and the Blue and Green elements of the object to 0. The result would be a pure color of red if the color object was assigned to an object. The Red, Green, and Blue properties of an AutoCAD True Color object are read-only; the SetRGB method is used to assign new values to the three color elements of the object:

(setq clrObj (vlax-create-object (strcat "AutoCAD.AcCmColor." (substr (getvar "acadver") 1 2)))) (vlax-invoke-method clrObj 'SetRGB 255 0 0) nil (vlax-release-object clrObj)

You can determine whether an object supports a method by using the vlax-method-applicable-p function. A value of T is returned if the object does support the specified method. The following shows the syntax of the vlax-method-applicable-p function. The arguments are the same as described earlier in this section:

(vlax-method-applicable-p obj 'method)

Working with Variants and Arrays

vla-object isn't the only new data type that you will have to understand when working with ActiveX. Many methods and properties use what is known as a variant. The variant data type is the chameleon of data types; it can represent any supported data type. A variant in AutoLISP is represented by the vla-variant data type. Arrays are yet another type of data that you will need to become familiar with. An array is represented by the vla-array data type and is similar to the AutoLISP list data type.

Making Variants

Most properties and methods return or expect values of a specific type, but there will be times when you will need to assign a property or pass a method a variant value. Some data structures can represent multiple values, such as a point or Xdata, and in these situations the AutoCAD COM library is designed to return or accept a variant value. You define a variant by using the vlax-make-variant function.

The following shows the syntax of the vlax-make-variant function:

(vlax-make-variant [val [type]])

Here are its arguments:

val The val argument is the value to be assigned to the variant and is optional.

type The type argument is an optional integer that specifies the data type that the value should represent. As an alternative, you can use a constant variable value that has the same meaning. Table 22.1 lists some of the most common data types and the integer and constant variable values you can use. Refer to the vlax-make-variant topic in the AutoCAD Help system for more supported values.

Table 22.1 Common data types used with the vlax-make-variant function

Data type Integer value Constant variable value

Integer 2 vlax-vbInteger

Double 5 vlax-vbDouble

String 8 vlax-vbString

Here is an example that shows how to make a variant that holds an integer value of 5:

(setq var (vlax-make-variant 5 vlax-vbInteger)) #<variant 2 5>

When neither the val nor the type argument is provided to the vlax-make-variant function, an empty variant is returned. The value and type of a variant can be returned using the vlax-variant-value and vlax-variant-type functions. The value assigned to a variant can't be changed, but the data type a variant represents can be changed using the vlax-variant-change-type function, making it possible to change an integer to a double or string. For example, you might want to change an integer or double value to a string so that it can be displayed to the user as part of a message or prompt string.

The following shows the syntax of the vlax-variant-value, vlax-variant-type, and vlax-variant-change-type functions:

(vlax-variant-value variant) (vlax-variant-type variant) (vlax-variant-change-type variant type)

Defining Arrays

The array data type is similar to the AutoLISP list data type, but typically an array is made up of a specified number of elements. You will remember that a list can hold any number of elements. A common use for arrays with the AutoCAD COM library is to represent a point list. Arrays can also be used to pass multiple objects to a method or for times when you want to return more than one value from a custom function.

The vlax-make-safearray function is used to create a new array based on a specific data type and number of elements. The following shows the syntax of the vlax-make-safearray function:

(vlax-make-safearray type '(lbound. ubound) ['(lbound. ubound)])

Here are its arguments:

type The type argument is an integer or equivalent constant variable that represents the data type of the elements within the array. These are the same data types that the vlax-make-variant function supports. Refer to the vlax-make-safearray topic in the AutoCAD Help system for supported values.

'(lbound. ubound) The lbound part of the argument is an integer that represents the lower element of the array, typically 0. The ubound part of the argument is an integer that represents the upper element of the array. If you want to specify an array of three elements, set lbound to 0 and ubound to 2.

NOTE 22.1

The optional ['(lbound. ubound)] argument allows you to define a matrix. For information on matrices, see the vlax-tmatrix function in the AutoCAD Help system and the TransformBy method in the AutoCAD COM library.

Here are examples that define arrays:

; Array of three strings (setq arStrs (vlax-make-safearray vlax-vbString '(0. 2))) #<safearray…> ; 2D point (array of two doubles) (setq pt2D (vlax-make-safearray vlax-vbDouble '(0. 1))) #<safearray…>

After an array has been defined, you can add values to the elements within the array by using the vlax-safearray-put-element function. You can retrieve values within an array by using the vlax-safearray-get-element function.

The following shows the syntax of the vlax-safearray-put-element and vlax-safearray-get-element functions:

(vlax-safearray-put-element array idx val) (vlax-safearray-get-element array idx)

Here are its arguments:

array The array argument is a value of the vla-array data type, such as that returned by the vlax-make-safearray function.

idx The idx argument is an integer that represents an element within the array. The value cannot be less than the lower or greater than the upper element of the array.

val The val argument is the value that is to be assigned to the element in the array.

Here are examples that assign values to and get values from the arrays defined in the earlier examples:

; Assign strings to a three-element array (vlax-safearray-put-element arStrs 0 "Qty") "Qty" (vlax-safearray-put-element arStrs 1 "Model") "Model" (vlax-safearray-put-element arStrs 2 "Description") "Description" ; Assign double/real values to a two-element array (vlax-safearray-put-element pt2D 0 0.0) 0.0 (vlax-safearray-put-element pt2D 1 5.25) 5.25 ; Get the first element in an array (vlax-safearray-get-element pt2D 0) 0.0

To create a 2D or 3D point array, you can use the vlax-3d-point function. Or you can assign multiple values to an array based on the values of a list with the vlax-safearray-fill function. Here are examples that use the vlax-3d-point and vlax-safearray-fill functions:

; 2D point (setq pt2D (vlax-3d-point 0.0 5.25)) ; 3D point (setq pt3D (vlax-3d-point 0.0 5.25 1.0)) ; Adds three strings to a three-element array (vlax-safearray-fill arStrs '("Qty" "Model" "Description"))

Table 22.2 lists some additional functions that can be helpful when working with arrays. For more information on the functions mentioned in the table, see the AutoCAD Help system.

Table 22.2 Additional array functions

Function Description

vlax-safearray-type Returns an integer that represents the data type of the values contained in an array

vlax-safearray-get-dim Returns an integer that represents the number of elements in an array

vlax-safearray-get-l-bound Returns an integer that represents the index of the lower element in an array

vlax-safearray-get-u-bound Returns an integer that represents the index of the upper element in an array

vlax-safearray->list Returns a list containing the values of all elements in an array

Importing COM Libraries

Although you can access the properties and methods of an object using the functions covered in the「Specifying Properties and Invoking Methods」section, importing a COM library can make coding easier. When you import a COM library, that library defines an AutoLISP function for the properties and methods of each class in the library. The newly defined functions that result from importing a COM library reduce the amount of code that needs to be written.

For example, the vla-get-red function can be used instead of the vlax-get-property function to get the current value of the Red property of an AutoCAD True Color object. The same is true with methods; vla-delete is the equivalent of using the vlax-invoke-method function with the Delete method name as an argument. The following two code statements produce the same result:

(vlax-get-property clrObj 'Red) (vla-get-red clrObj)

The properties and methods exposed by the AutoCAD COM library can be imported into a current drawing with the vl-load-com function. However, if you want to import the functions of another COM library for use with AutoLISP you must use the vlax-import-type-library function. The vlax-import-type-library function returns T if the COM library was successfully imported. An error is returned if the COM library couldn't be imported.

The following shows the syntax of the vlax-import-type-library function:

(vlax-import-type-library :tlb-filename filename [:methods-prefix me_prefix :properties-prefix prop_prefix :constants-prefix con_prefix] )

Here are its arguments:

filename The filename argument represents the path to and the filename of the COM library to be imported.

me_prefix, prop_prefix, and con_prefix These arguments are optional strings that represent the prefix to be appended to the property, method, and constant names in the COM library being imported to ensure the names are unique from other imported libraries.

Here is an example that shows how to import the COM library for the Windows Shell object:

(vlax-import-type-library :tlb-filename "c:\\windows\\system32\\wshom.ocx" :methods-prefix "wshm-" :properties-prefix "wshp-" :constants-prefix "wshk-" )

Although you can import a COM library more than once, you should avoid doing so, since multiple imports can add to the time it takes for a custom function to execute. The following example shows how you can use a global variable to determine whether the COM library associated with the Windows Shell object has already been imported into the current session:

; Imports the Windows Host Scripting Library (if (= wshLibImported nil) (progn (vlax-import-type-library :tlb-filename "c:\\windows\\system32\\wshom.ocx" :methods-prefix "wshm-" :properties-prefix "wshp-" :constants-prefix "wshk-" ) (setq wshLibImported T) ) (princ) )

Using the AutoCAD COM Library

Once the AutoCAD COM library has been imported, you can use the newly exposed functions to do the following:

Access the objects associated with the AutoCAD application and current drawing

Get the graphical and nongraphical objects stored in the current drawing

Perform geometric calculations

Register reactors and monitor changes made to a drawing or actions performed by the user

TIP

Before you use the AutoCAD COM library, make sure that you execute the vl-load-com function to ensure the library has been imported.

The classes in the AutoCAD COM library are organized using a hierarchy. The AutoCAD application is at the top, followed by the drawings (or documents) opened, and then the objects in a drawing. Once you have a drawing object, you can then access the nongraphical objects stored in the drawing. Graphical objects that have been placed in model space or on a layout are accessed through the special named blocks *ModelSpace and *PaperSpace0 of, which are stored in the Blocks or Layouts collection. A drawing can contain more than one *PaperSpace block; each successive paper space block name in the drawing is incremented by 1.

NOTE 22.3

You can access the AutoCAD application object from most objects in the AutoCAD COM library by using the Application property, which can be accessed with the vla-get-application function.

You can learn about the classes in the AutoCAD COM library by using the AutoCAD Object Model in the AutoCAD Help system. The AutoCAD Object Model can be found by going to http://help.autodesk.com/view/ACD/2015/ENU/files/homepage_dev.htm and clicking the AutoCAD Object Model link. The AutoCAD Object Model (see Figure 22.1) shows the hierarchy of the AutoCAD COM library structure.

Figure 22.1 Hierarchy of the AutoCAD COM library

When you click the object model, the reference topic for the associated class/object opens. The Help reference page provides information on how an object can be created, along with the properties and methods supported by the object. The content is intended primarily for the VBA programmer, but it is still very useful if you're working with the AutoCAD COM library in AutoLISP.

For the most part, adding vla- as a prefix for a method name or vla-put- or vla-get- as a prefix for a property name is all that is needed to convert the information contained in the VBA documentation for use with AutoLISP. (Remember that you must use vl-load-com to ensure that the AutoCAD COM library has been imported before you can use it.) A majority of the reference topics for object properties and methods also contain example code for use with AutoLISP. You can copy and modify the example code as needed. The ActiveX Developer's Guide can also help you learn more about the AutoCAD COM library.

You can access both the ActiveX Reference and ActiveX Developer's topics by using the AutoCAD Object Library Reference and Developer's Guide links in the ActiveX/VBA section of the Developer homepage in the AutoCAD Help system.

TIP

When you are using the Visual LISP® Editor, you can highlight the name of an imported function in the editor window and press Ctrl+F1 to open the related topic in the ActiveX Reference. Using this approach, you open the acadauto.chm file to the topic that discusses the object, method, or property.

Accessing the AutoCAD Application and Current Drawing Objects

Once the AutoCAD COM library has been imported with the vl-load-com function, you can use the vlax-get-acad-object function to get the AcadApplication object that represents the AutoCAD application. As I mentioned earlier, the AutoCAD application object is the topmost object in the hierarchy that is the AutoCAD COM library. To learn which methods and properties an AcadApplication object supports, you can use the vlax-dump-object function with the value returned by the vlax-get-acad-object function. Here is an example that shows how to use the vlax-get-acad-object function:

; Gets the AutoCAD application object (setq acad (vlax-get-acad-object))

The AcadApplication object contains a property named ActiveDocument, which returns an AcadDocument object that represents the current drawing. Use the vla-get-activedocument function to get the current drawing object. Here is an example:

; Gets the current drawing (setq curDoc (vla-get-activedocument acad))

Working with Graphical and Nongraphical Objects in the Current Drawing

The graphical and nongraphical objects stored in a drawing can be accessed using ActiveX. As defined by the drawing architecture, all graphical objects are stored in a Block object and can be accessed from the Blocks collection. Model space and paper space are special types of Block objects that you can manipulate without performing any special operation. The Blocks collection is just one of several collections that allow you to create and access nongraphical objects in a drawing.

NOTE 22.5

The vla-object data type isn't compatible with the ename data type. You can convert vla-object values to an entity name (ename) by using the vlax-vla-object->ename function. The vlax-ename->vla-object function converts an ename to a vla-object data type. Additionally, you can use the vla-get-handle function to get an object's handle and then use the handent function to get an object's ename based on a valid handle. These functions are helpful if you are mixing the use of Classic AutoLISP functions that work with the ename data type, such as entget or ssname, and those used to work with objects of the AutoCAD COM library. Examples of these functions, with the exception of vlax-vla-object->ename, can be found in the ch22_mswin_office.lsp file, which you can download from this book's web page, www.sybex.com/go/autocadcustomization.

In the previous section, you learned how to get the object that represents the active document. The next example shows how to get the ModelSpace or PaperSpace object based on the active space. You can determine the correct active space by using the ActiveSpace property of the current document.

; Get a reference to the current space in AutoCAD (if (= (vla-get-activespace curDoc) acModelSpace) (setq space (vla-get-modelspace curDoc)) (setq space (vla-get-paperspace curDoc)) )

When you want to add an object, such as a Layer object, to a collection, you can use one of the many Add methods available through the AutoCAD COM library. The following exercise shows how to create a function that checks for the existence of a layer and that creates the layer if it's not found; it then sets the layer as current by using the AutoCAD COM library and ActiveX. The function is similar to the createlayer function that you defined in the utility.lsp file in the various exercises throughout this book.

Create a LSP file named ActiveX.lsp in the MyCustomFolders folder within the Documents (or My Documents) folder, or in the location you are using to store the LSP files.

In Notepad (Windows) or TextEdit (Mac OS), type the following in the text editor area:; Creates a new layer and/or sets a layer current (defun CreateLayer-ActiveX (lyrName layColor docObj / layerObj) (if (= (vl-catch-all-error-p (vl-catch-all-apply 'vla-item '((vla-get-layers docObj) "Hatch")) ) T ) (progn ; Creates the layer (setq layerObj (vla-add (vla-get-layers docObj) lyrName)) ; Sets the color of the layer (vla-put-color layerObj layColor) ) ) ; Sets the layer current (vla-put-activelayer docObj (vla-item (vla-get-layers docObj) lyrName)) (princ) )

Save the file and then load it into AutoCAD.

At the Command prompt, type the following to test the function:(setq acad (vlax-get-acad-object)) (setq curDoc (vla-get-activedocument acad)) (createlayer-activex "NewLayer" 4 curDoc)

A new layer named NewLayer is added to the drawing, assigned the color 4 (Cyan), and set as current. You can see that the new layer has been created by using the layer command and the Layer Properties Manager.

Adding graphical objects to a drawing with ActiveX is different from what you have done previously when using the command, entmake, and entmakex functions. When using ActiveX, you must specify where an object should be created—the methods of the AutoCAD COM library are not contextually driven. You must explicitly work in model space or paper space.

