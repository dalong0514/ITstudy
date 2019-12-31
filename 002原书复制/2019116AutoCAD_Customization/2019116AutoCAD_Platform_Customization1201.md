# Chapter 12 Understanding AutoLISP

The AutoLISP® programming language allows you to automate workflows in the Autodesk® AutoCAD® drawing environment. At first glance, AutoLISP can feel more than a bit intimidating because of its syntax and use of parentheses. This is not an uncommon feeling for those who are new to AutoLISP and it's why some claim that LISP stands for「Lost in Stupid Parentheses」instead of its true meaning,「LISt Processing.」Although AutoLISP and even programming in general can take time to learn and understand, venturing down a path that is often less traveled can prove to be the difference that makes you and the company you work for stand out from others.

Here are some of the reasons I recommend AutoLISP:

The programs can be entered directly at the AutoCAD Command prompt and can be used in a script or CUI/CUIx files.

AutoLISP leverages your existing understanding of AutoCAD commands and system variables.

AutoLISP programs can be executed on Windows or Mac OS with no changes based on the functions used.

AutoLISP programs are low maintenance; programs written last week or even a decade ago often run with few to no changes in the latest release.

Getting Started with AutoLISP

I recommend that anyone who wants to create custom programs for AutoCAD consider AutoLISP as their first language to learn unless they have previous experience with another supported programming language, such as Visual Basic, VB.NET, C#, or C++. Even if you do know a programming language, you can use AutoLISP to quickly create a new custom program.

AutoLISP was the first programming language I learned, and it took me a bit of time to grasp not only AutoLISP but general computation logic as well. However, once I got some traction with AutoLISP and programming concepts, things started to click for me. Even to this day, AutoLISP is still very near and dear to me as a programming option when it comes to creating custom programs for AutoCAD.

When learning a programming language like AutoLISP, consider approaching it how you might learn a spoken language. First you need to learn some key fundamentals about the language and then spend time practicing to get good at it. As you start to learn AutoLISP, you will want to learn how to do the following:

Construct an AutoLISP expression

Execute an AutoLISP expression

Select an environment to create and edit AutoLISP programs

Store AutoLISP expressions in a file to reuse

I have no doubt that with time and practice you too can be successful in leveraging AutoLISP to be more productive in your daily work.

Understanding the Syntax of an Expression

An AutoLISP expression is the formation of one or more items known as atoms. An atom represents a function or variable name, operator, or value. A valid AutoLISP expression must start with one of the following characters:

( —Opening Parenthesis An opening parenthesis indicates the beginning of an AutoLISP expression and must be paired with a closing parenthesis [ ) ] to indicate the end of an AutoLISP expression. The opening and closing parentheses do not need to be on the same lines in an AutoLISP program, but each AutoLISP program must contain the same number of opening and closing parentheses.

! —Exclamation Point An exclamation point is used to retrieve the current value assigned to a variable. The exclamation point must be placed in front of the variable's name and can only be used at the AutoCAD Command prompt. I discuss variables later, in the「Storing and Retrieving Values」section.

Table 12.1 shows various AutoLISP expressions and a description of what happens when the expression is evaluated at the AutoCAD Command prompt.

Table 12.1 AutoLISP expressions

Expression Description

!cenPT Returns the current value of a user-defined variable named cenPT, which by default is nil.

(setq cenPT '(5 5 0)) Defines a user-defined variable named cenPT and assigns it a list that represents a coordinate point of 5,5,0 in a drawing.

(command "._circle" cenPT 6.25) Executes the AutoCAD circle command with the AutoLISP command function and draws a circle at the coordinate point assigned to the user-defined variable cenPT with a radius of 6.25 units.

(- 10 (/ 6 3)) Returns a value of 8. When AutoLISP expressions are nested, the AutoLISP interpreter evaluates the innermost expression first. Then the next expression works its way to the outermost expression. (/ 6 3) is evaluated first and returns a value of 2. The outermost expression is then seen as being (- 10 2), which evaluates to the final value of 8.

(setq msg (strcat "Hello " "World!")) The AutoLISP strcat function concatenates multiple string values into a single string value. The value of「Hello World!」is returned by the strcat function and assigned to the user-defined variable msg.

Now that you have a basic understanding of what an AutoLISP expression looks like, the next step is to look at the inner workings of an AutoLISP expression's structure. A valid AutoLISP expression must start with an opening parenthesis and end with a closing one. Typically, between the two parentheses you will find the atoms that should be evaluated; remember that an atom represents a function name and the values that a function should perform an action on. There are two exceptions to this, though. The first exception is an exclamation point, which I mentioned earlier. The other exception is when an apostrophe is used instead of the AutoLISP list function. Figure 12.1 explains the structure of an AutoLISP expression.

Figure 12.1 Structure of an AutoLISP expression

When you type an AutoLISP expression, make sure that you have at least one space between each atom. You can have more than one space, but at least one space must be present. A space lets AutoCAD know where the name of the function or operator ends and the first value (if one is provided) begins. The following expression demonstrates what happens when a space after an operator is missing; the space is missing after the / operator.

(- 10 (/6 3))

When the function is evaluated by AutoLISP, it thinks you are trying to use a function named /6 instead of the / operator. You'll see this error:

; error: no function definition:

/6 is displayed as a result of the missing space.

NOTE

The AutoLISP programming language, unlike other popular programming languages such as C# or C++, is not case sensitive. This means that the functions and user-defined variables are evaluated in exactly the same way, regardless of how you enter them—uppercase, lowercase, or mixed case. For example, COMMAND and command have the same meaning. The only time case matters is when you're using string values, which must start and end with quotation marks (").

Executing Expressions

AutoCAD supports a variety of ways to execute an AutoLISP expression. When first learning AutoLISP, you'll find being able to enter an AutoLISP expression directly at the AutoCAD Command prompt a huge benefit; you can see in real time the results of an entered expression. When you type an opening parenthesis or exclamation point at the Command prompt, AutoCAD passes control to the AutoLISP interpreter, which carries out the evaluation of the expression. After the expression is evaluated, control is then returned to AutoCAD and the standard Command prompt is displayed.

The following exercise creates a circle with a center point of 5,5,0 and a radius of 6.25 units using AutoLISP expressions at the Command prompt:

Launch AutoCAD, if it is not already running.

At the AutoCAD Command prompt, type (setq cenPT '(5 5 0)) and press Enter. This defines a variable named cenPt and assigns it the coordinate value of 5,5,0. AutoLISP returns (5 5 0) to the Command prompt because the AutoLISP setq function returns the value it assigned to the variable.

Type !cenPT and press Enter.

Verify that the expected result, the value (5 5 0), is returned. If you see a value of nil, the expression you executed in step 2 was mistyped. Before continuing, repeat step 2 if a value of nil was returned.

Type (command "._circle" cenPt "6.25") and press Enter. The AutoLISP command function starts the circle command and draws a circle with a center point of 5,5,0 (or the current value assigned to the user-defined variable cenPt) and a radius of 6.25 units. I explain more about the command function in the section「Using the command Function」later in this chapter.

Type (command "._zoom" "_e") and press Enter. The AutoLISP command function starts the zoom command and then uses the Extents option.

NOTE

The exclamation point is required only when you want to see the current value assigned to a variable. As you saw in step 5, variables can be used in an AutoLISP expression without first entering an exclamation point.

In addition to executing AutoLISP expressions at the AutoCAD Command prompt, you can use the following:

Scripts and Command Macros AutoLISP expressions can be used in script (SCR) files and command macros that are defined for use with a user-interface element in a customization (CUIx/CUI) file, just as you enter expressions at the Command prompt. I discussed SCR files in Chapter 8,「Automating Repetitive Tasks,」and you learned about CUIx/CUI files in Chapter 5,「Customizing the AutoCAD User Interface for Windows,」and Chapter 6,「Customizing the AutoCAD User Interface for Mac.」

A File You can store AutoLISP expressions in an ASCII text file and then load that file into AutoCAD. Entering expressions at the Command prompt is a great way to learn AutoLISP and is useful when only a few expressions need to be executed, but it is not ideal for complex programs or when you want to reuse the same expressions several times. I explain how to create and manage AutoLISP files in Chapter 20,「Authoring, Managing, and Loading AutoLISP Programs.」

Accessing the AutoLISP Documentation

The AutoLISP documentation is part of the AutoCAD Help system. The help system includes the AutoLISP Reference and AutoLISP Developer's Guide topics. Although this book is designed to make it easy to learn the AutoLISP programming language and doubles as a reference that you can refer to time and time again when working with AutoLISP, it just is not possible to cover every function and technique here.

The AutoLISP Reference topics explain what each function does in the AutoLISP programming language. The AutoLISP Developer's Guide topics explore advanced techniques and features that are not covered in this book.

You can see the AutoLISP documentation written for AutoCAD 2015 here:

http://help.autodesk.com/view/ACD/2015/ENU/

On the Autodesk AutoCAD 2015 Help landing page, click the Developer Home Page link. On the AutoCAD Developer Help Home Page, use the Function Listing (By Name And Feature) and AutoLISP Developer's Topic Map links to access the AutoLISP documentation. The URL points to the AutoCAD 2015 on Windows documentation, but the AutoLISP documentation is designed for cross-platform development.

Storing and Retrieving Values

Programs—and programming languages, for that matter—are typically designed with one of two basic concepts in mind: to receive/consume or return/give. Most AutoLISP functions are designed to receive one or more values in the form of arguments, and then return a single value that can then be used by another function or returned to the user. When a function returns a value, you can store that value for future use—in the current custom function that is executing or even between different AutoCAD sessions. After a value has been stored, you can then retrieve the value for use by your program when it is needed.

You can store and retrieve values using these techniques:

User-Defined Variables User-defined variables allow you to temporarily store a value within a function or globally while a drawing remains open. A variable is defined using the AutoLISP setq function. For example, you can use the expression (setq msg "Hello AutoLISP! ") to define a variable named msg and assign it the text string「Hello AutoLISP!」I discuss user-defined variables in the next section.

System Variables System variables store values that are often used to control the behavior of AutoCAD commands or the drawing environment, and even allow access to the values that are calculated by some AutoCAD commands, such as area or distance. Unlike with user-defined variables, you can't create your own system variables. The system variable might represent a value that is stored in the current drawing or as part of the current AutoCAD user profile. See the section「Working with System Variables」later in this chapter.

Environment Variables Similar to system variables, environment variables are used to control the behavior of AutoCAD commands or the drawing environment. You can access the values of environment variables that are defined by AutoCAD or even create your own as needed. Environment variables are stored as part of the AutoCAD user profile and as part of the Windows Registry or as a property list (Plist) file on Mac OS. I discuss accessing environment variables later in this chapter in the「Accessing Environment Variables」section.

Windows Registry (Windows Only) The Windows Registry is used to store settings that can be retrieved across different drawings and between application sessions. You can access the settings that AutoCAD reads and writes, and the Windows Registry is also a perfect place to store your own settings for your custom programs. I explain how to work with the Windows Registry in Chapter 18,「Working with the Operating System and External Files.」

Property List File (Mac OS Only) Similar to the Windows Registry, Plist files are used to store settings that can be retrieved across different drawings and between application sessions. As with the Window Registry, you can access the settings that AutoCAD reads and writes, and the Plist files are also a perfect place to store your own settings for your custom programs. I explain in Chapter 18 how to work with the Plist files.

Extended Data and Records Extended data (XData) and records (XRecords) allow you to attach custom information to a graphical object or create a custom dictionary in a drawing that can be used to store multiple entries containing custom information. XData is a great way to add unique information to an object in a drawing. AutoCAD uses XData to help facilitate dimension overrides, implement some multiline text features, and provide other features. You'll learn about XData in Chapter 16,「Creating and Modifying Graphical Objects,」and XRecords in Chapter 17,「Creating and Modifying Nongraphical Objects.」

External Data Files AutoLISP allows you to write values to and read values from an ASCII text file that can be stored outside of AutoCAD on a local or network drive. I explain how to access external files in Chapter 18. If you are using Windows and have Microsoft Office installed, you can also access information that can be created and modified using an application that is part of Microsoft Office—ActiveX/COM. I discuss using COM with AutoLISP in Chapter 22,「Working with ActiveX/COM Libraries (Windows Only).」

Configuration Files Configuration (CFG) files are used to store settings that can be retrieved across different drawings and between application sessions. Storing values in a CFG file is not as common as it once was, but you should be familiar with storing and retrieving values from a CFG file just in case you are working on an older program. I recommend using one of the other techniques for storing values that can be accessed across multiple drawings or between application sessions, such as the Windows Registry, Plist files, or even external data files. You'll learn how to work with CFG files in Chapter 18.

Setting and Using Variables

In an AutoLISP program, it is not uncommon to want to use the same value more than once or to use a value returned by one function as a value for an argument in another function. Variables allow you to define a named location in memory to temporarily store a value. AutoLISP supports two types of variables: user-defined and predefined.

User-defined variables are those that you or another developer create for use in an AutoLISP program.

Predefined variables are those that are automatically defined and assigned a specific value by the AutoLISP environment for each drawing that is created or opened.

Defining and Using User-Defined Variables

You can define a variable, called a user-defined variable, by using the AutoLISP setq function. By default each user-defined variable exists only in the context of the drawing in which it is defined; once the drawing is closed, the variable and its value are lost.

NOTE

If you need to retain the value assigned to a variable beyond the drawing it was defined in, consider using a custom dictionary object to store the value in a drawing, or use the Registry (Windows) or Plist file (Mac OS). I discussed these and other ways of storing values earlier, in the「Storing and Retrieving Values」section.

The following shows the syntax of the setq function:

(setq var_name value)

var_name The var_name argument represents the name of the user-defined variable you want to define and assign a value to.

value The value argument represents the data that you want to assign to the variable specified by the var_name argument.

The setq function always returns the value that is assigned to the last variable in the expression.

The following AutoLISP expressions assign a coordinate value of 2,2,0 and numeric value of 6.25 to user-defined variables named pt and dia:

(setq pt '(2 2 0)) (setq dia 6.25)

Although the setq function is commonly used to define a variable and then assign that variable a value, it can also be used to define multiple variable and value pairings. The following AutoLISP expression defines multiple variables and then assigns them a value:

(setq pt '(2 2 0) dia 6.25)

Once a variable has been defined and a value assigned, you can use it as an argument with another AutoLISP expression or return its current value at the AutoCAD Command prompt. There is nothing special you need to do in order to use a variable in an AutoLISP expression, but you need to include an exclamation point before the variable name in order to return its current value at the AutoCAD Command prompt. For example, to return the value of the variable dia at the AutoCAD Command prompt you would type !dia and press Enter. (The exclamation point isn't necessary when you're using the variable inside an AutoLISP expression that begins and ends with parentheses.)

The following exercise demonstrates how to define two variables and use their values at the AutoCAD Command prompt:

At the AutoCAD Command prompt, type !cenpt and press Enter. nil should be returned, unless the variable was previously defined.

Type (setq cenpt '(1 2 0)) and press Enter. The variable cenpt is defined and assigned the coordinate value 1,2,0. (1 2 0) is returned by the setq function.

Type !cenpt and press Enter. The value of the cenpt variable is returned, which should be (1 2 0).

Type (setq rad 3.125) and press Enter. The variable rad is defined and assigned the real numeric value 3.125.

Type circle and press Enter. The circle command is started.

At the Specify center point for circle or [3P/2P/Ttr (tan tan radius)]: prompt, type !cenpt and press Enter. The value of the cenpt variable is returned and used for the circle's center point.

At the Specify radius of circle or [Diameter]: prompt, type !rad and press Enter. The value of the rad variable is returned and used for the circle's radius. The circle command ends and the circle is drawn.

Using Predefined Variables





VBA projects (DVB) (Windows only)(Windows only)

Trusted Locations The Trusted Locations node contains the folders of the custom programs that AutoCAD should trust. For files loaded from these locations, AutoCAD does not display a security warning message. I discuss loading custom program files later, in the「Loading a Custom Program」section.

Customization Files The Customization Files node contains the folders where the CUIx or CUI files that define many of the tools in the user interface are stored. You can also define the location that AutoCAD looks in for icons used by your custom tools in the user interface. I discussed customizing the AutoCAD user interface in Chapter 5,「Customizing the AutoCAD User Interface for Windows,」and Chapter 6,「Customizing the AutoCAD User Interface for Mac.」

Printer Support File Path The Printer Support File Path node contains the folders where the printer configuration (PC3/PCM), printer description (PMP), and plot style (CTB/STB) files are stored. I discussed printer configuration and plot styles in Chapter 1,「Establishing the Foundation for Drawing Standards.」

Template Settings The Template Settings node contains the folders where the drawing (DWT) and sheet set/project (DST) template files are stored. I discussed drawing templates in Chapter 1.

Tool Palettes File Locations (Windows Only) The Tool Palettes File Locations node contains the folders where the tool palette (ATC) files are stored for the Tool Palettes window. I discussed tool palettes and the Tool Palettes window in Chapter 7,「Creating Tools and Tool Palettes.」

Action Recorder Settings (Windows Only) The Action Recorder Settings node contains the folders where action macro (ACTM) files that AutoCAD can edit and play back are stored. I discussed action macros and the Action Recorder in Chapter 8,「Automating Repetitive Tasks.」

The following steps explain how to add the MyCustomFiles folder to the Support File Search Path node in the Options dialog box on Windows. This folder is the expected location for the files created as a result of completing the exercises in this book.

Click the Application menu button Options (or at the command prompt, type options and press Enter).

When the Options dialog box opens, click the Files tab.

Select the Support File Search Path node and click Add, and then click Browse.

In the Browse For Folder dialog box, browse to the MyCustomFiles folder that you created for this book in the Documents (or My Documents) folder, or browse to the folder that contains your customized files.

Select the folder that contains your customized files and click OK.

Click OK to save the changes to the Options dialog box.

If you are using AutoCAD on Mac OS, use these steps:

On the menu bar, click AutoCAD <release> Preferences (or at the command prompt, type options and press Enter).

When the Application Preferences dialog box opens, click the Application tab.

Select the Support File Search Path node.

Near the bottom of the dialog box, click the plus sign (+).

In the Open dialog box, browse to the MyCustomFiles folder that you created for this book in the Documents folder, or browse to the folder that contains your customized files.

Select the folder that contains your customized files and click Open.

Click OK to save the changes to the Application Preferences dialog box.

You can change an existing folder in the Options or Application Preferences dialog box by expanding a node and then selecting the node you want to edit. After selecting the folder to edit, click Browse on Windows and select the new folder, or double-click the folder on Mac OS and then select the new folder.

Using and Loading Custom Programs

Everything that I have discussed in this book until now has primarily focused on customizing AutoCAD. While customizing AutoCAD is a great way to increase your productivity, customization does have its limitations when you are trying to automate or simplify complex workflows.

Leveraging one or more of the programming languages that AutoCAD supports with the customization features that you have learned about in this book will help you further increase your productivity. You do not need to learn how to program, but you should be familiar with the programming languages available so you can take advantage of the many custom programs that are available for free (or for a small fee) on the Internet.

What Are Custom Programs?

Custom programs are applications that extend the functionality of AutoCAD through the inclusion of new commands or custom objects, or the extension of a supported programming language. The programming languages that AutoCAD supports allow for a wide range of skills, from basic to advanced. Even if you do not want to learn to be a programmer, having a basic understanding of a language can be beneficial if you download programs from the Internet. If you do decide to learn a programming language, consider AutoLISP and Visual Basic for Applications (VBA), which are fairly easy to learn with no or little previous experience. Here are the programming languages that AutoCAD supports:

AutoLISP AutoLISP is often the first programming language that a drafter or nonprogrammer learns to extend the functionality of AutoCAD. You can write an AutoLISP program using Notepad on Windows or TextEdit on Mac OS, or the Visual LISP® development environment built into the Windows release of AutoCAD. AutoLISP programs have the file extension .lsp. AutoLISP files, which can be compiled, have the file extensions .fas and .vlx. (VLX files are supported on Windows only.) You can load an AutoLISP file by using the appload command or the load AutoLISP function.

VBA (Windows Only) VBA is an extension of the Visual Basic (VB) programming language. VBA is an object-oriented programming language that uses the concept of interactive objects defined with properties, methods, and events. When creating VBA programs, you communicate with AutoCAD using the AutoCAD Object Library to create and modify objects in a drawing or the AutoCAD environment. VBA programs are stored in project files with a .dvb file extension. DVB files can be loaded and executed using the vbaman or vbarun command or with the vl-vbaload or vl-vbarun AutoLISP function.

VB.NET and C# (Windows Only) VB.NET and C# are two of the modern programming languages that AutoCAD supports. Both of these languages require the installation of the.NET Framework, as well as access to specific libraries that are installed with AutoCAD or as part of the ObjectARX software development kit (SDK). Applications created with VB.NET or C# require you to use Microsoft Visual Studio (Express is free, or you can purchase a license for Professional or higher). VB.NET and C# programs must be compiled with the .dll file extension and loaded into AutoCAD using the netload command.

JavaScript (Windows Only) JavaScript (JS), the most recent programming language that AutoCAD supports, was first introduced with AutoCAD 2014. A JS program can be either a standalone file with the .js file extension and loaded with the webload command, or part of an HTML file and displayed with the showhtmlmodalwindow AutoLISP function. You can create a JS or HTML file using Notepad or a specialized editor.

C++ and Objective-C C++ (Windows) and Objective-C (Mac OS) are two programming languages that are based on the C programming language. Both of these languages require you to download and obtain the ObjectARX SDK, which contains the libraries required to communicate with AutoCAD. An ObjectARX application must be compiled before it can be loaded into AutoCAD. If you want to develop applications with C++, you need to install Microsoft Visual Studio. (Again, Express is free, or you can purchase a license for Professional or higher.) If you are developing applications with Objective-C, you will need to install Xcode. Both languages support the development of graphical user interfaces with MFC (Windows) or Cocoa (Mac OS). ObjectARX programs must be compiled with the .arx (Windows) or .bundle (Mac OS) file extension. ARX and BUNDLE files can be loaded into AutoCAD using the appload command or with the arxload AutoLISP function.

NOTE

You can download the ObjectARX SDK (which you can use to develop a program using VB.NET, C#, C++, or Objective-C) from www.objectarx.com.

Loading a Custom Program

As I previously mentioned, AutoCAD supports a variety of programming languages and each has its own method of being loaded into AutoCAD. The most common types of custom files that you will encounter are AutoLISP (LSP) and ObjectARX (ARX/BUNDLE). Understanding how to load an LSP, ARX, or BUNDLE file allows you to take advantage of the many free routines that others have created and made available for download from the Internet over the past two decades.

Starting with AutoCAD 2013 Service Pack 1 and AutoCAD 2014, Autodesk implemented an additional layer of security that you should be aware of that restricts the loading and execution of custom programs without some user interaction. Prior to those two releases, there were no restrictions on loading and executing custom programs. The following list explains the settings and options that affect the loading and execution of custom programs in AutoCAD 2013 and AutoCAD 2014:

AutoCAD 2013 with Service Pack 1 (Windows Only) The system variables and the command-line switch that affect the loading of custom programs in AutoCAD 2013 are as follows: autoload, which specifies whether AutoCAD can automatically load custom files with specific names at startup

autoloadpath, which specifies the folders from which AutoCAD can automatically load custom files with specific names at startup

lispenabled, which indicates whether AutoLISP has been disabled in the current session

/nolisp, which disables the execution of AutoLISP (LSP/FAS/VLX) (Windows only) files in the current session

AutoCAD 2014 The system variables and command-line switches that affect the loading of custom programs in AutoCAD 2014 are as follows: secureload, which specifies whether AutoCAD can load executable files from any folder with or without a warning, or whether it can load files only from the folders specified by the trustedpaths system variable.

trustedpaths, which specifies the folders from which AutoLISP, VBA, Managed.NET, and ObjectARX files can be loaded without user interaction. VBA and Managed.NET are supported on Windows only.

trusteddomains, which specifies the domains and URLs from which JS files can be loaded without user interaction (Windows only).

safemode, which indicates whether executable files can be loaded and executed in the current session.

/safemode, which disables the execution of executable files in the current session (Windows only).

-safemode, which disables the execution of executable files in the current session (Mac OS only).

The following steps explain how to load an AutoLISP or ObjectARX application:

Do one of the following: On the ribbon, click the Manage tab Applications panel Load Application (Windows).

On the menu bar, click Tools Load Application (Mac OS).

At the command prompt, type appload and press Enter (Windows and Mac OS).

When the Load/Unload Application dialog box (see Figure 10.1) opens, browse to and select the AutoLISP or ObjectARX file you want to load. Click Load.

If the File Loading - Security Concerns message box is displayed, click Load. See the topics on the secureload and trustedpaths system variables in the AutoCAD 2014 Help system for information on how to avoid this message each time you load a custom program.

Click Close to return to the drawing area.

Execute any new command that is made available after the custom program file is loaded.

Figure 10.1 Loading a custom program

You can use the Startup Suite section of the Load/Unload Applications dialog box to automatically load custom program files each time AutoCAD starts. For information on using the Startup Suite, see the appload command in the AutoCAD Help system.

Locating Custom Programs on the Internet

Custom programs can be found on the Internet by performing a search using your favorite search engine. You can find some custom program files by doing a search on a combination of the keywords autolisp, objectarx, programs, files, sample, download, and free. An example keyword search might be autolisp files; the results in Bing are shown in Figure 10.2.

WARNING

With any files that you download from the Internet, make sure you scan the files with virus software. Also, download files from a reputable website whenever possible. If you are unsure about a website that contains free custom program files for AutoCAD, check whether someone on the Autodesk (forums.autodesk.com) or AUGI (forums.augi.com) forums has downloaded files from the website.

Figure 10.2 Internet search results on AutoLISP files

The following lists my website (HyperPics) and other reputable sites that offer free custom programs that can be used with AutoCAD:

AfraLISP: www.afralisp.net

DotSoft: www.dotsoft.com

HyperPics: www.hyperpics.com/customization/

JTB World: www.jtbworld.com

ManuSoft: www.manusoft.com

If you are using AutoCAD 2013 or AutoCAD 2014 on Windows, you can also download and install custom programs through the Autodesk Exchange App Store (http://apps.exchange.autodesk.com/). The Autodesk Exchange App Store contains a variety of apps not only for AutoCAD, but also for AutoCAD-based vertical applications and other Autodesk products. You can find both free and paid for apps in the store.

Backing Up and Migrating Customization

Backing up your custom settings and files is often one of the last tasks you perform after customizing AutoCAD, but it is also an important one if something were to go wrong. I recommend backing up frequently—that comes out of habit after forgetting to back up a few times over the years and having to redo several days of customization work. While backing up files is often one of the last tasks you perform, migrating is one of the first tasks you will perform when upgrading to a new release.

The most basic way to back up and migrate your files on either Windows or Mac OS is to manually copy your files between folders. The following lists the folders that AutoCAD uses by default to store the customized files it can make changes to:

%AppData%\Autodesk\<product_name>\<release>\<language> (Windows)

%LOCALAPPDATA%\Autodesk\<product_name>\<release>\<language> (Windows)

˜Library/Application Support/Autodesk/roaming/<product_name>/<release>/<language> (Mac OS)

˜Library/Application Support/Autodesk/local/<product_name>/<release>/<language> (Mac OS)

As I discussed earlier in this chapter, I strongly recommend storing your customization in separate folders and files from those that AutoCAD creates after installation. If you follow my recommendation, be sure to back up the folders and files in those locations in addition to the ones that AutoCAD updates.

If you are using AutoCAD on Windows, there are some additional utilities available for backing up custom settings and files, synchronizing custom settings with your Autodesk 360 account, and helping to migrate custom settings to a new release. These utilities include the following:

Export AutoCAD <release> Settings The Export AutoCAD <release> Settings option on the Windows Start menu or Start screen allows you to export the custom settings and files of AutoCAD to a ZIP file.

Import AutoCAD <release> Settings The Import AutoCAD <release> Settings option on the Windows Start menu or Start screen allows you to import the custom settings and files that were previously exported using Export AutoCAD <release> Settings.

Synchronize Custom Settings The Synchronize Custom Settings feature allows you to back up your custom settings and files to your Autodesk 360 account. These settings can then be restored on another workstation or on the same workstation they were backed up from. You can control whether you want to use this feature, and the types of settings and files that can be backed up, on the Online tab of the Options dialog box (options command).

Migrate From A Previous Release The Migrate From A Previous Release option on the Windows Start menu or Start screen allows you to migrate your custom settings and files from a previous release to a newer release. For example, you can migrate your settings from AutoCAD 2012 to AutoCAD 2014. Both releases need to be installed in order to migrate the custom settings and files.

Customize User Interface, Transfer Tab The Transfer tab of the Customize User Interface (CUI) Editor allows you to transfer user-interface elements between two different CUIx files. This can be helpful if you want to migrate only some of the elements in your user interface to a new release. I discussed the CUI Editor in Chapter 5.

For more information on these utilities, see the AutoCAD Help system.

TIP

For additional information on issues that could affect migrating custom settings and files, or using custom program files from an earlier release, see the CAD Administration Guide in the AutoCAD Help system (docs.autodesk.com/ACD/2014/ENU/).






In addition to the user-defined variables that you might create and use in AutoLISP expressions, the AutoLISP environment defines three variables that are assigned a specific value and are accessible from all drawing files that are opened. The variables that are predefined by the AutoLISP environment are as follows:

PI The PI variable is assigned the value of 3.141592653589793, which is a constant value that represents the ratio of a circle's diameter to its circumference.

T The T variable always returns a value. This variable is commonly used when you test whether a condition returns True.

PAUSE The PAUSE variable is assigned the string「\\」. The PAUSE variable is used in combination with the command function to suspend the execution of an AutoLISP expression and allow the user to respond to a command's request for input.

WARNING

You should never change the value of a predefined variable; doing so could affect the execution of the AutoLISP programs that use them.

Controlling the Scope of a Variable

Variables can be accessed from the global or local scope of the AutoLISP environment. By default, all variables defined with the setq function are accessible globally. Each of the predefined variables that are defined by the AutoLISP environment are accessible from the global scope of the AutoLISP environment. However, you typically want to limit the number of such variables in the current drawing. Variables that are defined with the global scope continue to consume system resources until you set the variable to the value of nil, whereas those defined as local variables have their system resources freed up when the execution of the function in which they are defined ends.

Another reason to limit global variables is what I refer to as unexpected data. Unexpected data occurs when a variable is assigned one value by your program and changed to another value by a different program. For example, say you assigned a global variable the value of 6.25, but another program (one written by you or even a third-party program) is using that same variable name and assigns the variable the value of (1「A」). Based on how your program is designed, it might be using the variable as a way to persist the last value chosen by the user, much the same way the AutoCAD circle command remembers the last radius used. When your program goes to use the value, it gets a list instead of a numeric value, which must be handled differently and doesn't even hold a value that is useful to you any longer.

Unique Function and Global Variable Names

AutoLISP is kind of like the Wild West—at times it can feel lawless since you have the ability to stake a claim to a name and still have someone come in and take it from you. For example, you can create a function named MakeLayer or a user-defined global variable named pt. A third party could do the same. If the third-party LSP file contains the same function or it defines a variable with the same name, your loaded function and defined variable are replaced.

To help protect your functions and variables, I recommend adding a unique prefix to their names. Typically, the unique prefix you create is derived from a company name. For example, you might use the unique prefix of mc3 if your company was My Cool CAD Company. In addition to adding the unique prefix to a variable name, I recommend prefixing and suffixing the names of any global variables with an asterisk to make it easier to identify which variables are defined globally.

Instead of creating a function named MakeLayer, you would use the name mc3_MakeLayer and for a variable named size (which might store the size of a bolt) you would use *mc3_size*. Another consideration when naming global variables is whether they need to be program or function specific. For function-specific global variables, consider including the name of the function that defines the variable. For example, the two functions DrawBolt and DrawScrew were originally written to use a global variable named *mc3_size*, which stores the recent size the user selects when using either of the functions. The size is then used the next time the function is executed; AutoLISP offers users their previous selection, which (based on the current naming of the variable) would be a potential problem. By using the variable names *mc3_drawbolt_size* and *mc3_drawscrew_size*, you ensure that both functions have their own global variable.

The following explains the differences between global and local variables, and shows you how to define a variable in the local scope of a custom function:

A global variable is accessible to all AutoLISP programs that are loaded into the drawing and to those expressions that are executed in the drawing from which the variable was defined. By default, all variables are defined with a global scope.

A local variable is accessible only from the function in which it is defined. You define the variable using the setq function, but the name of the variable is also added to the local_var argument of the defun function to restrict its use to just that function. I discuss the defun function later in this chapter in the section「Defining and Using Custom Functions.」If a variable is not added to this argument, it remains a global variable.

Although a variable can be defined with a global scope, a variable with the same name can exist in the local scope of a function. When this happens, the expressions inside your function are aware only of the local variable. The following steps show how a variable defined in the local scope of a custom function takes precedence over a variable defined with a global scope:

At the AutoCAD Command prompt, type the following and press Enter:(setq *apc_var* "Global")

Type the following and press Enter to define the GlobalVar function:(defun c:GlobalVar ( / )(alert *apc_var*))

Type the following and press Enter to define the LocalVar function: (defun c:LocalVar ( / *apc_var*) (setq *apc_var* "Local") (alert *apc_var*) )

Type globalvar and press Enter. Click OK to exit the alert message box. The alert message box displays the text string assigned to the *apc_var* variable in the global scope, which is the value Global.

Type localvar and press Enter. Click OK to exit the alert message box. The variable *apc_var* is assigned the value of the string "Local" and then an alert message box displays the text string assigned to the *apc_var* variable in the local scope, which is the value Local.

Type globalvar and press Enter. Click OK to exit the alert message box. The alert message box displays the text string assigned to the *apc_var* variable in the global scope, which is the value Global. When the localvar function was executed in step 5, the*apc_var* variable was assigned a value that existed only while the function was executing; it did not overwrite the value of the globally defined *apc_var* variable.

TIP

User-defined variables are normally accessible only from the drawing in which they are defined, but you can use the AutoLISP vl-bb-ref and vl-bb-set functions to define variables on what is known as the blackboard. The blackboard is a centralized location for defining variables that can be accessed from any open drawing. The AutoLISP vl-propagate function can also be used to define a variable with a specific value in all open drawings and any drawings that are subsequently opened in the AutoCAD session. You can learn more about these functions in the AutoCAD Help system.

Working with System Variables

System variables are used to alter the way commands work, describe the current state of a drawing or AutoCAD environment, and even specify where the support files are for your custom programs. Many of the settings that are exposed by system variables are associated with controls in dialog boxes and palettes; other settings are associated with various command options. For example, many of the settings in the Options (Windows) or Application Preferences (Mac OS) dialog box are accessible from system variables and even environment variables (which I discuss in the next section).

A system variable can store any one of the basic data types that AutoLISP supports (see「Exploring Data Types」later in this chapter). You can see the hundreds of system variables and the type of data each system variable holds by using the AutoCAD Help system. Whereas you might normally use the setvar command to list or change the value of a system variable at the AutoCAD Command prompt, with AutoLISP you use the getvar and setvar functions to query and set the value of a system variable.

Here's the syntax of the getvar and setvar functions:

(getvar sysvar_name) (setvar sysvar_name value)

sysvar_name The sysvar_name argument represents the name of the system variable you want to query or set.

value The value argument represents the data that you want to assign to the system variable.

The next exercise demonstrates how to query and set the value of the osmode system variable, which controls the running object snap drafting aid. This setting is available in the Drafting Settings dialog box (dsettings command).

At the AutoCAD Command prompt, type (setq *apc_cur_osmode* (getvar "osmode")) and press Enter. The function returns the current value of the osmode system variable and assigns it to the user-defined variable *apc_cur_osmode* with the setq function.

Type (setvar "osmode" 33) and press Enter. The osmode system variable is assigned the integer value of 33, which represents the Endpoint and Intersection running object snap modes.

Type osnap and press Enter. In the Drafting Settings dialog box, select the Object Snap tab and verify that the Endpoint and Intersection options are checked and all other options are unchecked. Click Cancel to return to the Command prompt.

Type (setvar "osmode" *apc_cur_osmode*) and press Enter. The previous value of the system variable is restored.

Type osnap and press Enter. In the Drafting Settings dialog box, you will notice that the options checked will represent those of the restored running object snap settings value. Click Cancel to return to the Command prompt.

TIP

The AutoCAD Help system is a great resource for learning about system variables. However, if you need to support multiple AutoCAD releases you will need to reference the documentation for each release. To make it easier to identify which system variables are supported in the recent and past AutoCAD releases, I created a list of system variables that spans a large number of AutoCAD releases; you can view the list here: www.hyperpics.com/system_variables/.

Accessing Environment Variables

Environment variables allow you to access settings that are, at times, accessible only from the Options (Windows) or Application Preferences (Mac OS) dialog box and not through system variables or from the Command prompt. Unlike with system variables, though, there is no official documentation that explains which environment variables are available or what values they can be assigned.

Many of the environment variables that I am aware of can be found stored in the Windows Registry or a Plist file on Mac OS. Both of these storage locations include a General Configurations section for the AutoCAD program, and it is in this section that you will find the environment variables you can manipulate. You use the AutoLISP getenv and setenv functions to retrieve and set the value of an environment variable.

WARNING

Unlike system variables, environment variable names are case sensitive. For example, MaxHatch is not the same as maxhatch or MAXHATCH.

The following shows the syntax of the getenv and setenv functions:

(getenv envvar_name) (setenv envvar_name "value")

envvar_name The envvar_name argument represents the name of the environment variable you want to query or set.

value The value argument represents the string value that you want to assign to the environment variable. Environment variables can only be assigned a string value, but that string could contain a number or even a list of values.

Both the getenv and setenv functions return the current value of the environment variable or the value that was successfully assigned to an environment variable.

The following steps show how to retrieve and set the value of the DefaultFormatForSave environment variable, which controls the default format for saving drawings. This setting is available in the Options dialog box on Windows, but not in the Application Preferences dialog box on AutoCAD 2013 and earlier on Mac OS. It does affect the behavior of saving a drawing file on both Windows and Mac OS.

At the AutoCAD Command prompt, type (setq *apc_cur_val* (getenv "DefaultFormatForSave")) and press Enter. The function returns the current value of the environment variable and assigns it to the user-defined variable *apc_cur_val* with the setq function.

Type (setenv "DefaultFormatForSave" "48") and press Enter. The DefaultFormatForSave environment variable is assigned the value of 48, which represents the AutoCAD 2010 drawing file format. If you are using an earlier release, you may need to use a different value to set a previous drawing file format as current.

Type saveas and press Enter. In the SaveAs dialog box, notice that the Files Of Type drop-down list will list AutoCAD 2010/LT2010 Drawing (*.dwg) as the current option. Click Cancel to return to the Command prompt.

Type (setenv "DefaultFormatForSave" *apc_cur_val*) and press Enter. The previous value of the environment variable is restored.

Type saveas and press Enter. In the SaveAs dialog box, notice that the Files Of Type drop-down list now lists the previous default drawing file format. Click Cancel to return to the Command prompt.

TIP

I created a list (though not complete or up to date) of the environment variables available in a number of earlier releases of AutoCAD. You can find this list here:

http://www.hyperpics.com/downloads/resources/customization/autolisp/AutoCAD%20Environment%20Variables.pdf

Exploring Data Types

Programming languages use data types to help you identify the following:

The type of data required by a function's argument

The type of data that might be returned by a function

AutoLISP on Windows and Mac OS support the following data types:

Integer An integer is a numeric value without a decimal point. The numeric value must be in the range of –32,768 to 32,767 and can be optionally prefixed with a plus sign (+) for positive numbers. You can use an integer value to represent an angular or linear distance or the number of columns or rows in an array or table, or to specify whether a system variable is enabled or disabled. Examples include -10, 0, 1, +45, and 400. You'll learn about using integer values with mathematical functions in Chapter 13,「Calculating and Working with Values.」

Real A real value is numeric with a decimal point. The numeric value must be in the range of 1.80 × 10308 to –4.94 × 10–324 for negative numbers and 4.94 × 10–324 to 1.80 × 10308 for positive numbers. A positive number can optionally be prefixed with a plus sign and be expressed in exponential notation; 10e4 is the same as 100000.0. When using a value between –1.0 and 1.0, you must use a leading zero before the decimal;.5 is not a valid real number but 0.5 is. You might use a real number to represent an angular or linear distance or part of a coordinate. Examples of a real number are –10.01, 0.0, 1.125, +45.0, and 400.00001. Chapter 13 discusses using real values with mathematical functions.

NOTE

The real data type in AutoLISP is commonly referred to as a double or float in other programming languages.

String A string is a value that contains one or more characters enclosed in quotation marks. You might use a string value for a command or system variable name, a file path and name, messages and prompts that are displayed to the user, or even a real or integer number converted to a string. Examples of a string value are「Hello AutoLISP!", "._line", "\nSpecify next point: ", and "6.25". You'll learn more about working with string values in Chapter 13.

List A list is an expression of one or more atoms enclosed in parentheses. All AutoLISP expressions are known as lists, but lists often represent 2D points, 3D points, and data groupings. Examples of a list are (1.5 2.75), (1.5 2.75 0.5), ("Model" "Layout1" "Layout2"), (1 "A" 2 "B"), and (). () represents an empty list. When you're assigning a list to a variable, either the list must be preceded by an apostrophe, as in (setq pt '(1 2 0)), or you must use the AutoLISP list function, as in (setq pt (list 1 2 0)). Chapter 14,「Working with Lists,」explores creating and manipulating lists.

NOTE

The list data type in AutoLISP is similar to an array in other programming languages.

Dotted Pair A dotted pair is a list of two values separated by a period. Dotted pairs are commonly used to represent property values for an object. The first value of a dotted pair is sometimes referred to as a DXF group code. For example, (40.2.0) represents the radius of a circle; DXF group code value 40 indicates the radius property, and 2.0 is the actual radius value for the circle. When you're assigning a dotted pair to a variable, either the pair must be preceded by an apostrophe, as in (setq dxf_40 '(40. 2)), or you must use the AutoLISP cons function, as in (setq dxf_40 (cons 40 2)). You'll learn more about creating and manipulating dotted pairs in Chapter 16.

Entity Name An entity name is an in-memory numeric label used to reference an object stored in a drawing. You will often work with an entity name to modify an object's properties or after a request to select objects in a drawing has been completed. See Chapters 16 and 17 to learn how to work with entity names.

AutoLISP on Windows supports a few additional data types, and I discuss these additional data types in depth and how they are used in Chapter 22. The data types that are specifically used for working with ActiveX libraries are as follows:

VLA-Object A VLA-Object represents an ActiveX object that is used when working with methods and properties imported from the AutoCAD Object Library or another ActiveX library. An ActiveX object can be an object stored in a drawing, an open drawing, or the AutoCAD application itself.

Variant A variant is a generic data type that can hold any type of data supported by the Component Object Model (COM) interface.

Safearray A safearray is not really a data type, but rather a data structure that can contain multiple values similar to the list data type. You use a safearray when you need to represent a coordinate value, specify the objects used to define a closed boundary when creating a Region or Hatch object, or specify the data types and values that make up the XData attached to an object.

You can use the AutoLISP type function to identify the type of data retuned by a function or assigned to a variable. The following shows the syntax of the type function:

(type value)

value The value argument represents any valid atom; an AutoLISP expression, a value, or a variable.

The type function returns a symbol that can be used to determine if the value returned by a function or assigned to a variable is the type of data you are expecting. The following AutoLISP expressions define a custom function named IsString, which uses the type function to determine whether a value is of the string data type:

(defun IsString (val / ) (if (= (type val) 'STR) T nil) )

You can use the IsString function by entering it at the AutoCAD Command prompt or loading it as part of an AutoLISP (LSP) file. When the function is executed, it will return T if the value it is passed is a string data type or nil for all other data types. The following shows several examples of the IsString function along with the values they return:

(IsString "2") T (IsString 2) nil (IsString PAUSE) T (IsString PI) nil

Leveraging AutoCAD and Third-Party Commands

The AutoLISP command and command-s functions allow you to leverage the functionality of a standard AutoCAD command or a command defined by a loaded third-party application. Because these functions allow you to use a command, they are often some of the first functions that many new to AutoLISP learn.

NOTE

When using the command and command-s functions, keep in mind that the command being executed in most cases behaves similar to when you use it from the AutoCAD Command prompt. That means you can use many system variables to control a command's behavior or outcome. For example, you can use the clayer system variable to set a layer as current before an object is drawn or even disable running object snaps with the osmode system variable before using the line and circle commands. After you make a call to the last command and command-s function in your AutoLISP programs, be sure to restore any changed system variables to their previous values.

In Chapters 5 and 6 you learned about creating command macros. Some of the special characters used in command macros also apply to the command and command-s functions. Table 12.2 lists the special characters that can prefix a command name.

Table 12.2 Special characters that can prefix a command name

Special character Description

. (period) Accesses an AutoCAD command's standard definition even when a command might have been undefined with the undefine command.

_ (underscore) Instructs AutoCAD to use the global command name or option value instead of the localized name or value provided. This allows the macro to function as expected when used with a different language of the AutoCAD release.

Using the command Function

The command function passes each argument it receives to the AutoCAD Command prompt. The first argument is the name of the command to execute. After the command name are the arguments that reflect the options and values that should be executed by the command. If a command is already active when the command function is evaluated, the arguments are passed to the current command.

TIP

Before using the command function, you should test to see if a command is active by querying the current value of the cmdactive system variable with the AutoLISP getvar function. A value greater than 0 indicates a command is active. You can issue the command function without any arguments to simulate pressing Esc to get to a clean Command prompt.

The following shows the syntax of the command function:

(command [cmdname [argN …]])

cmdname The cmdname argument represents the name of the command to execute. cmdname is optional.

argN The argN argument represents the options and values that should be executed at the AutoCAD Command prompt. argN is optional. Arguments are also known as command tokens.

The following AutoLISP example assigns the coordinate values of 2,2,0 and 5,6,0 to the user-defined variables named *apc_pt1* and *apc_pt2*. The line command is then used to draw a line between the coordinate values assigned to the user-defined variables *apc_pt1* and *apc_pt2*.

(setq *apc_pt1* '(2 2 0) *apc_pt2* '(5 6 0)) (command "._line" *apc_pt1* *apc_pt2* "")

NOTE

The arguments that you might pass to the command function can span multiple expressions. The following produces the same results as the previous AutoLISP example code:

(setq *apc_pt1* '(2 2 0) *apc_pt2* '(5 6 0)) (command "._line") (command *apc_pt1* *apc_pt2* "")

When the command function is used, you can suspend the execution of an AutoLISP program and allow the user to provide input at the Command prompt. You use the predefined PAUSE variable or the "\\" ASCII character sequence to allow the user to provide a value. The following AutoLISP expression starts the circle command and then allows the user to specify a center point. Once a center point is specified, the circle's diameter is set to 3 units.

(command "._circle" PAUSE "_d" 3)

Controlling a Command's Version

Internally each standard AutoCAD command is assigned a new version number when a change is made that affects an AutoLISP program, script, or command macro. You use the initcommandversion function to control which version of a command is used by the next use of the command or command-s function. The initcommandversion function doesn't require a value, but when one is provided it must be an integer value that represents the version of the command you want to use.

The following example uses version 1 of the color command:

(initcommandversion 1) (command "._color")

Version 1 of the color command displays options at the Command prompt; version 2 or later displays the Select Color dialog box instead. The -insert command is another command that is affected by the initcommandversion function. When using version 2 of the -insert command, the user can interact with the AutoCAD Properties palette in Windows while a preview of the block is being dragged in the drawing area.

Using the command-s Function

The command-s function is similar to the command function, with a few differences. Like the command function, the command-s function passes each argument it receives to the AutoCAD Command prompt. The first argument that is passed to the command-s function is the name of the command you want to execute. This is followed by the arguments that reflect the options and values you want executed.

When you use the command-s function, you must supply all values to complete the command that you want to execute. Unlike with the command function, you can't do either of these things:

Suspend the execution of an AutoLISP program and allow the user to provide input at the Command prompt with the predefined PAUSE variable.

Start the execution of a command in one expression and finish the command in another expression. The following is not a valid use of the command-s function: (command-s "._circle") (command-s '(5 5) 2)

The following shows the syntax of the command-s function:

(command-s [cmdname [argN …]])

cmdname The cmdname argument represents the name of the command to execute. cmdname is optional.

argN The argN argument represents the options and values that should be executed at the AutoCAD Command prompt. argN is optional. Arguments are also known as command tokens.

The following AutoLISP example assigns the coordinate value of 5,5,0 to the user-defined variable named *apc_cpt*. The circle command is then used to draw a circle using the coordinate value assigned to the user-defined variables *apc_cpt* and a radius of 5.

(setq *apc_cpt* '(5 5 0)) (command-s "._circle" *apc_cpt* 5)

Working with Commands That Display a Dialog Box

When using the command and command-s functions, avoid commands that display a dialog box because doing so can lead to inconsistencies when your AutoLISP program is executed. Instead, you should use the alternative command-line equivalent of a command, or use the system and environment variables that might be changed with the dialog box. In most cases, adding a hyphen (-) in front of a command that normally displays a dialog box will cause the command to display a series of command prompts instead. For more information, see Chapter 8 or the AutoCAD Help system.

If you need to use the dialog box that a command normally displays, you must use the AutoLISP initdia function. This function indicates to AutoCAD that the next command executed with the command or command-s function should display a dialog box, if it is supported. Using the initdia function before a command that doesn't display a dialog box has no effect on the command. The initdia function doesn't accept any arguments.

The following exercise demonstrates how the initdia function affects the use of the command function when using the plot command:

At the AutoCAD Command prompt, type (command "._plot") and press Enter. The plot command starts and the Detailed plot configuration? [Yes/No] <No>: prompt is displayed.

Press Esc to end the plot command.

Type (initdia) and press Enter. It will seem like nothing happens, but rest assured a flag has been set in the background for AutoCAD to check with the next use of the command function.

Type (command "._plot") and press Enter. The plot command starts and the Plot dialog box is displayed.

When the Plot dialog box opens, click Cancel.

Defining and Using Custom Functions

Although you can execute AutoLISP expressions one at a time at the Command prompt, doing so makes it hard to repeat or use more than a few AutoLISP expressions at a time. You can group AutoLISP expressions together into a new custom function and then execute all of the expressions in the group by using the function name you specify.

Defining a Custom Function

The AutoLISP defun function is used to define a custom function. A custom function defined with defun behaves similar to a standard AutoLISP function, but it can also mimic a command that can be entered directly at the AutoCAD Command prompt or used in a script or command macro. Typically, a function is defined when you want to make it easier to execute and repeat a specific set of AutoLISP expressions.

The following shows the syntax of the defun function that you should follow when defining a function that doesn't need to mimic an AutoCAD command:

(defun function_name ([argN] / [local_varN]) expressionN )

function_name The function_name argument represents the name of the function you want to define.

argN The argN argument represents a list of arguments that the function can accept and then act upon. argN is optional.

local_varN The local_varN argument represents a list of user-defined variables defined in the function that should be restricted to the local scope of the function. local_varN is optional. Variables defined within a function have a global scope if they aren't added to the local_varN argument.

expressionN The expressionN argument represents the AutoLISP expressions that should be executed by the function when it is used.

The following shows the syntax of the defun function when you want to define a function that can be accessed from the AutoCAD Command prompt, similar to a standard AutoCAD command:

(defun c:function_name ( / [local_varN]) expressionN )

NOTE

Custom functions that have the C: prefix shouldn't accept any arguments. If your function requires any values, those values should be requested from the user with the getxxx functions. Chapter 15,「Requesting Input and Using Conditional and Looping Expressions,」discusses getting input from the user.

The following steps show how to define two custom functions: a function named dtr that converts an angular value in degrees to radians, and another named c:zw, which executes the zoom command with the Window option. These functions can be executed at the AutoCAD Command prompt.

At the AutoCAD Command prompt, type (defun dtr (deg / ) and press Enter. The defun function defines a function named dtr, which accepts a single argument named deg. In this example the dtr function will use no local user-defined variables, but if you decided to, you'd list them after the forward slash.

Type (* deg (/ PI 180)) and press Enter. The value assigned to the variable PI will be divided by 180 and then multiplied by the value passed into the dtr function that is assigned to the deg variable.

Type ) and press Enter. The AutoLISP interpreter returns the name of the function that is defined; in this case DTR is returned. This parenthesis closes the AutoLISP expression that was started with the defun function.

Type (dtr 45) and press Enter. The value 0.785398 is returned.

Type (defun c:zw ( / ) and press Enter. The defun function defines a function named zw and it is prefixed with C:, indicating it can be entered at the AutoCAD Command prompt. This function doesn't accept any arguments and there are no variables that should be limited locally to this function.

Type (command "._zoom" "_w")) and press Enter. The AutoLISP interpreter returns C:ZW. The AutoLISP expression that uses the command function will be executed when the zw function is used. The command function starts the zoom command and then uses the Window option. The last closing parenthesis ends the AutoLISP expression that was started with the defun function.

Type zw and press Enter. You will be prompted to specify the corners of the window in which the drawing should be zoomed.

Using a Custom Function

After you define a custom AutoLISP function with the defun function, you can execute it at either the AutoCAD Command prompt or from an AutoLISP program. Chapter 20 discusses creating AutoLISP programs. In the previous section, you defined two functions: dtr and c:zw. The following rules explain how you can execute a custom AutoLISP function defined with the defun function:

If a function name does not have the C: prefix, you must place the name of the function and any arguments that it accepts between opening and closing parentheses. It doesn't matter whether you are calling the function from the AutoCAD Command prompt or an AutoLISP program. For example, to call the dtr function defined in the previous section you would use (dtr 45) to call the dtr function with an argument value of 45.

If a function name has the C: prefix, you can enter the name of the function directly at the AutoCAD Command prompt without entering the C: prefix first. However, if you want to use a function that has the C: prefix from an AutoLISP program, you don't use the command or command-s function since it is not a true, natively defined AutoCAD command. Instead you must place the name of the function along with the C: prefix between opening and closing parentheses. For example, to call the C:ZW function defined in the previous section you would use (c:zw).

Functions used in a script or command macro for a user-interface element must follow the same syntax that can be entered at the AutoCAD Command prompt.

TIP

Although custom AutoLISP functions that have the C: prefix aren't recognized as native AutoCAD commands, you can use the AutoLISP vlax-add-cmd and vlax-remove-cmd functions to register a custom AutoLISP function as a built-in AutoCAD command. (These functions are available only on Windows.) There are a couple reasons you might want to do so. The first is so that your custom functions trigger events or reactors related to when a command starts or ends. The other reason is so that your custom function can be called with the command or command-s function. You can learn more about these functions in the AutoCAD Help system.

Example: Drawing a Rectangle

I don't introduce any new functions or techniques in this section, but I want to explain how to use many of the AutoLISP functions explored in this chapter to define a custom function that creates a new layer and draws a rectangle. I will break down each AutoLISP expression of the function in more detail in Table 12.3.

Create a new AutoCAD drawing.

At the AutoCAD Command prompt, type the following and press Enter after eac (defun c:drawplate ( / old_osmode pt1 pt2 pt3 pt4) (setq old_osmode (getvar "osmode")) (setvar "osmode" 0) (command "._-layer" "_m" "Plate" "_c" 5 "" "") (setq pt1 '(0 0 0)) (setq pt2 '(5 0 0)) (setq pt3 '(5 2.75 0)) (setq pt4 '(0 2.75 0)) (command "._line" pt1 pt2 pt3 pt4 "_c") (setvar "osmode" old_osmode) )

The drawplate function draws a rectangle that is 5 × 2.75 units in size, starting at the coordinate 0,0,0.

Type drawplate and press Enter. Once the drawplate function completes, you'll have a rectangular object made up of four line segments on a new layer named Plate; see Figure 12.2.

Create a new AutoCAD drawing.

At the AutoCAD Command prompt, type drawplate and press Enter. The message Unknown command "DRAWPLATE". Press F1 for help. is displayed. This message is the expected result because AutoLISP entered or loaded into one drawing is accessible only to that drawing. Chapter 20 shows you how to create and load AutoLISP files.

Table 12.3 AutoLISP expressions used to define the drawplate function

Expression Description

(defun c:drawplate ( / old_osmode pt1 pt2 pt3 pt4) Uses the defun function to define the custom function drawplate, which has the prefix C: and can be executed directly at the AutoCAD Command prompt. The argument list of the defun function is empty because a function that can be entered directly at the Command prompt should not accept arguments. The forward slash character separates the argument and local variable lists. The local variable list contains five variables; these variables are added to the list so they aren't defined as global variables.

(setq old_osmode (getvar "osmode")) Assigns the current value of the osmode system variable to the variable named old_osmode.

(setvar "osmode" 0) Sets the osmode system variable to a value of 0.

(command "._-layer" "_m" "Plate" "_c" 5 "" "") Executes the -layer command with the Make option to create a layer with the name Plate. Once the layer is created (or if it already existed), the Make option sets the layer as current. The layer is also assigned the AutoCAD Color Index (ACI) value of 5.

(setq pt1 '(0 0 0)) Assigns a list of three values that represent the coordinate value 0,0,0 to the variable named pt1.

(setq pt2 '(5 0 0)) Assigns a list of three values that represent the coordinate value 5,0,0 to the variable named pt2.

(setq pt3 '(5 2.75 0)) Assigns a list of three values that represent the coordinate value 5,2.75,0 to the variable named pt3.

(setq pt4 '(0 2.75 0)) Assigns a list of three values that represent the coordinate value 0,2.75,0 to the variable named pt4.

(command "._line" pt1 pt2 pt3 pt4 "_c") Executes the line command and uses the values assigned to the variables pt1, pt2, pt3, and pt4 to draw three sides of a rectangle. Once the first three segments are drawing, the Close option draws the fourth and final line segment to create a closed object.

(setvar "osmode" old_osmode) Sets the osmode system variable to the current value of the old_osmode variable.

) Closes the defun function.

Figure 12.2 Result of the drawplate custom function

Now that you have seen the drawplate function in action, Table 12.3 provides a breakdown of what each expression is doing in the function.


