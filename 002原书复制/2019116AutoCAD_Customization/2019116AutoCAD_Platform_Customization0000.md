Copyright © 2015 by John Wiley & Sons, Inc., Indianapolis, Indiana

## About the Author

Lee Ambrosius first started working with AutoCAD R12 for DOS in 1994. As a drafter, he quickly discovered that every project included lots of repetition. Lee, not being one to just settle for「this is just the way things are,」set out on a path that would redefine his career. This new path would lead him into the wondrous world of customization and programming—which you might catch him referring to as「the rabbit hole.」

In 1996, Lee began learning the core concepts of customizing the AutoCAD user interface and AutoLISP. The introduction of VBA in AutoCAD R14 would once again redefine how Lee approached programming solutions for AutoCAD. VBA made it much easier to communicate with external databases and other applications that supported VBA. It transformed the way information could be moved between project management and manufacturing systems.

Not being content with VBA, in 1999 Lee attended his first Autodesk University and began to learn ObjectARX®. Autodesk University had a lasting impression on him. In 2001, he started helping as a lab assistant. He began presenting on customizing and programming AutoCAD at the event in 2004. Along the way he learned how to use the AutoCAD Managed.NET API.

In 2005, Lee decided cubicle life was no longer for him, so he ventured off into the CAD industry as an independent consultant and programmer with his own company, HyperPics, LLC. After he spent a couple of years as a consultant, Autodesk invited him to work on the AutoCAD team; he has been on the AutoCAD team since 2007. For most of his career at Autodesk, Lee has worked primarily on the customization and end-user documentation. Recently, he has been working on the AutoLISP, VBA, ObjectARX,.NET, and JavaScript programming documentation.

In addition to working on documentation, Lee has been involved as a technical editor or author for various editions of AutoCAD and AutoCAD LT Bible, AutoCAD for Dummies, AutoCAD & AutoCAD LT All-in-One Desk Reference for Dummies, AutoCAD 3D Modeling Workbook for Dummies, and Mastering AutoCAD for Mac. He has also written white papers on customization for Autodesk and a variety of articles on customization and programming for AUGIWorld, published by AUGI®.

## Introduction

Welcome to AutoCAD Platform Customization: User Interface, AutoLISP, VBA, and Beyond. Have you ever thought about customizing AutoCAD only to think it is not for you because you're not a programmer? If so, you are not alone, as there are many people that connect customization with programming. However, customization is not the same as programming, but programming can be considered a form of customization.

While using one of the supported programming languages can be useful in implementing custom workflows and new commands, there are many simpler ways to increase your drafting efficiency in a shorter period of time. AutoCAD supports a wide range of customization features that you can learn and begin to leverage in minutes, which can led to improved CAD standards and a decrease in the amount of time it takes to complete a task.

I, like many others, even yourself most likely, have customized AutoCAD without even realizing it. Have you ever created a new layer, text style, or block? Chances are pretty great that you have created one or more of those items before. You might have even stored those items in a drawing template (DWT) file so they would be available each time a new drawing was created. While you might not have thought about these as forms of customization, they are indeed a few of the basic drawing customization features that can be used to enhance the out-of-box AutoCAD experience.

Drawing customization affects the appearance of and settings in a drawing file or drawing template (DWT) file, and should form the cornerstone of your company's CAD standards. Often when people think of customization though, they commonly think of application customization, which contains the support files that AutoCAD uses as well as the tools in the application's user interface. Application customization is not dependent on which drawing is currently open, but which user profile or workspace might be current.

### 1. About This Book

The AutoCAD Platform Customization: User Interface, AutoLISP, VBA, and Beyond book covers many of the customization and programming features that can be found in AutoCAD on Windows and Mac OS X. This book covers most of the customization features available along with two of the easier to learn programming languages that AutoCAD supports. If any of the following are true, this book will be useful to you:

1. Want to learn about which customization and programming options are available in AutoCAD.

2. Want to customize the user interface or support files, such as linetypes and hatch patterns, that AutoCAD utilizes.

3. Want to automate repetitive tasks.

4. Want to create and manage CAD standards for your company.

5. Want to learn how to create custom programs with AutoLISP or Visual Basic for Applications (VBA).

### 2. Customization in AutoCAD

Customization is one of the feature areas that sets AutoCAD apart from many other CAD programs. Even though the product can be used out of the box, configuring the user interface and modifying the support files that come with the product can greatly improve your productivity. By customizing AutoCAD, you can streamline product workflows and create new ones that are a better fit with the way your company works. These workflows might range from importing layers and styles into a drawing to the extraction of drawing-based information into a spreadsheet or database.

Not all of the customization features require you to learn a new tool or skill set; chances are you might have customized AutoCAD and not even realized it. If you have ever created a layer or a block, you already understand some of the customization features of AutoCAD.

The following outlines many of the common customization and programming options available:

Basic

Layers

Annotation styles (text, dimensions, multileaders, and tables)

Layouts

Blocks

Plot styles

Plotters

Page setups

Materials, visual styles, and render presets

Drawing templates

Command aliases

User profiles (Windows only)

Workspaces (Windows only)

Desktop icon customization (Windows only)

Tool palettes (Windows only)

Intermediate

Scripts

User interface (CUIx) and DIESEL

Linetypes and hatch patterns

Shapes and text styles

Action macros (Windows only)

Dynamic blocks (Windows only)

Advanced

AutoLISP

ObjectARX

Visual Basic for Applications (Windows only)

ActiveX/COM (Windows only)

Database connectivity (Windows only)

Sheet Set Manager API (Windows only)

CAD Standards plug-ins (Windows only)

Transmittal API (Windows only)

Managed.NET (Windows only)

JavaScript (Windows only)

### 3. AutoLISP in AutoCAD

AutoLISP is the most popular, and is the original supported programming language for the AutoCAD program. The reason for its popularity with new (and even veteran) programmers is that it is a natural extension of the AutoCAD program. There is no additional software to purchase, and AutoLISP can leverage the commands that Autodesk and third-party developers expose at the Command prompt. For example, with a few simple lines of code you can set a layer current and insert a title block with a specific insertion point, scale, and rotation. The block is then inserted on the layer you specified. To perform the same tasks manually, the end user would have to first set a layer current, choose the block they want to insert, and specify the properties of the block, which in the case of a title block are almost always the same.

The AutoLISP programming language can be used to:

1. Create custom functions that can be executed from the AutoCAD Command prompt.

2. Create and manipulate graphical objects in a drawing, such as lines, circles, and arcs.

3. Create and manipulate nongraphical objects in a drawing, such as layers, dimension styles, and named views.

4. Perform mathematical and geometric calculations.

5. Request input from or display messages to the user at the Command prompt.

6. Interact with files and directories in the operating system.

7. Read from and write to external files.

8. Connect to applications that support ActiveX and COM.

9. Display dialog boxes and get input from the end user.

AutoLISP code can be entered directly at the Command prompt or loaded using a LSP file. Once an AutoLISP program has been loaded, you can execute the custom functions from the Command prompt. Functions executed from the Command prompt can be similar to standard AutoCAD commands, but the programmer determines the prompts that should be displayed. It is also possible to use AutoLISP code with a command macro that is activated from the AutoCAD user interface or a tool on a tool palette.

### 4. VBA in AutoCAD

VBA is often overlooked as one of the options available to extend the AutoCAD program. There is no additional software to purchase, but you must download and install a release-specific secondary component to use VBA. You can leverage VBA to perform simple tasks, such as inserting a title block with a specific insertion point, scale, and rotation and placing the block reference on a specific layer. To perform the same tasks manually, end users would have to first set a layer as current, choose the block they want to insert, and specify the properties of the block, which in the case of a title block are almost always the same.

The VBA programming language and AutoCAD Object library can be used to do the following:

1. Create and manipulate graphical objects in a drawing, such as lines, circles, and arcs.

2. Create and manipulate nongraphical objects in a drawing, such as layers, dimension styles, and named views.

3. Perform mathematical and geometric calculations.

4. Request input from or display messages to the user at the Command prompt.

5. Interact with files and directories in the operating system.

6. Read from and write to external files.

7. Connect to applications that support ActiveX and COM.

8. Display user forms and get input from the end user.

VBA code statements are entered into the Visual Basic Editor and stored in a DVB file. Once a VBA project has been loaded, you can execute the macros through the Macros dialog box. Unlike standard AutoCAD commands, macros cannot be executed from the Command prompt, but once executed, a macro can prompt users for values at the Command prompt or with a user form. It is possible to execute a macro from a command macro that is activated with a command button displayed in the AutoCAD user interface or as a tool on a tool palette.

### 5. What to Expect

This book is organized to help to customize AutoCAD, learn the fundamentals of AutoLISP, and how to use the objects in the AutoCAD Object library with the VBA programming language. Additional resources and files containing the example code found throughout this book can be found on the companion website, www.sybex.com/go/autocadcustomization.

[AutoCAD Platform Customization: User Interface, AutoLISP, VBA, and Beyond | Wiley](https://www.wiley.com/en-us/AutoCAD+Platform+Customization%3A+User+Interface%2C+AutoLISP%2C+VBA%2C+and+Beyond-p-9781118798904)

#### Part I: AutoCAD Customization: Increasing Productivity through Personalization

Chapter 1: Establishing the Foundation for Drawing Standards In this chapter, you'll learn how to establish drawing standards. Drawing standards allow you to enforce consistency across multiple drawings. By enforcing a set of standards, you can easily share your drawings and make them look the same when plotting them.

Chapter 2: Working with Nongraphical Objects In this chapter, you'll learn how nongraphical objects affect display and output of objects in a drawing. Nongraphical objects such as layers and text styles make it easy to update the look of all the objects that reference them.

Chapter 3: Building the Real World One Block at a Time In this chapter, you'll learn how to create and manage blocks. Blocks allow you to logically create object groupings that can be used several times in the same drawing. For example, you could create a small assembly of parts and insert it more than once in a drawing. If the assembly changes, you just need to update the block and all instances of that block are changed.

Chapter 4: Manipulating the Drawing Environment In this chapter, you'll learn how to change the AutoCAD drawing environment. During start up, you can control several of the settings that affect the AutoCAD program. These settings can affect the display of the user interface, behavior of tools in the drawing environment, and where AutoCAD looks for support files.

Chapter 5: Customizing the AutoCAD User Interface for Windows In this chapter, you'll learn how to customize the elements and display of the AutoCAD user interface on Windows. The Customize User Interface (CUI) Editor allows you to create and manage the tools that are displayed by the AutoCAD user interface.

Chapter 6: Customizing the AutoCAD User Interface for Mac In this chapter, you'll learn how to customize the elements and display of the AutoCAD user interface on Mac OS. The Customize dialog box allows you to create and manage the tools displayed by the AutoCAD user interface.

Chapter 7: Creating Tools and Tool Palettes In this chapter, you'll learn how to create and customize tool palettes in AutoCAD on Windows. Tool palettes allow you to create a visual set of tools that can be used to insert blocks, start commands, or even hatch a closed area. Tool palettes are available on Windows only.

Chapter 8: Automating Repetitive Tasks In this chapter, you will learn how to create scripts and action macros to automate repetitive tasks. Script files and action macros allow you to combine multiple commands into simple logical sequences without needing to know a programming language. Action macros are supported on Windows only.

Chapter 9: Defining Shapes, Linetypes, and Hatch Patterns In this chapter, you will learn how to create custom shapes, linetypes, and hatch patterns that you can use to control the way line work appears in a drawing. The AutoCAD install provides a limited number of standard shapes, linetypes, and hatch patterns. You can extend the standard definitions by creating your own shapes, linetypes, and hatch patterns for use in your drawings.

Chapter 10: Using, Loading, and Managing Custom Files In this chapter, you will learn how to use, manage, and migrate custom files. After you have spent the time customizing AutoCAD, all you have left to do is deploy and manage your files.

#### Part II: AutoLISP: Productivity through Programming

Chapter 11: Quick Start for New AutoLISP Programmers In this chapter, you'll get an introduction to the AutoLISP programming language. I begin by showing you how to enter AutoLISP expressions at the Command prompt and execute standard AutoCAD commands. After that, you are eased into some basic programming concepts that allow you to perform conditional tests and repeat expressions. The chapter wraps up with creating and loading an AutoLISP file into the AutoCAD program.

Chapter 12: Understanding AutoLISP In this chapter, you'll learn the fundamentals of the AutoLISP programming language. AutoLISP fundamentals include a look at the syntax and structure of an expression, how to use a function, and how to work with variables. Beyond just syntax and variables, you learn to use AutoCAD commands and group multiple AutoLISP expressions into custom functions.

Chapter 13: Calculating and Working with Values In this chapter, you'll learn to work with mathematical and string manipulation functions. Math functions allow you to perform basic and advanced calculations based on object values or a value that the user might provide, whereas string manipulation functions allow you to work with text-based values. Both numeric and textual values are used when creating or manipulating objects, adding annotations to a drawing, or displaying a message to the end user. Based on how the values are used, numeric values can be converted to strings and strings can be converted to numeric values.

Chapter 14: Working with Lists In this chapter, you'll learn to work with the list data type. Lists are used throughout AutoLISP to provide 2D or 3D coordinate values or to define an object stored in a drawing.

Chapter 15: Requesting Input, and Using Conditional and Looping Expressions In this chapter, you'll learn to request input from the user, use conditional statements, and repeat expressions. Requesting input allows you to get values from the user and then use those values to determine the end result of the program. Conditional statements enable a program to make choices based on known conditions in a drawing or input from a user. After you understand conditional statements, you will learn to use them in conjunction with looping expressions to execute a set of expressions until a condition is met.

Chapter 16: Creating and Modifying Graphical Objects In this chapter, you'll learn how to create, modify, and attach extended data to graphical objects using AutoCAD commands and AutoLISP functions. Graphical objects represent the drawing objects, such as a line, an arc, or a circle, that are displayed in model space or on a named layout. When modifying objects, you can choose to step through all the objects in a drawing or let the user select the objects to be modified. Extended data allows you to store information with an object that can be used to identify the objects your program creates or link objects to external database records.

Chapter 17: Creating and Modifying Nongraphical Objects In this chapter, you'll learn how to create and modify nongraphical objects using AutoCAD commands and AutoLISP functions. Nongraphical objects are used to control the appearance of graphical objects and store settings that affect the behavior of features in the AutoCAD program. Drawings support two different types of nongraphical objects: symbol table objects and dictionaries.

Chapter 18: Working with the Operating System and External Files In this chapter, you will learn how to work with settings and files stored outside of the AutoCAD program. Settings can be stored in the Windows Registry and Plist files on Mac OS, and they can be used to affect the behavior of the AutoCAD program or persist values for your custom programs between AutoCAD sessions. Files and folders stored in the operating system can be accessed and manipulated from the AutoCAD program, which allows you to set up project folders or populate project information in the title block of a drawing from an external file.

Chapter 19: Catching and Handling Errors In this chapter, you will learn how to catch and handle errors that are caused by an AutoLISP function and keep an AutoLISP program from terminating early. AutoLISP provides functions that allow you to trace a function, see arguments as they are passed, catch an error and determine how it should be handled, and group functions together so all the actions performed can be rolled back as a single operation.

Chapter 20: Authoring, Managing, and Loading AutoLISP Programs In this chapter, you will learn how to store AutoLISP code statements in a file, load and manage AutoLISP files, and deploy custom programs with plug-in bundles. Storing AutoLISP code in a file allows for its reuse in multiple drawings. When you load an AutoLISP file, all of the functions defined in the file are made available while the drawing remains open. Based on how you load or deploy an AutoLISP file, you might need to let the AutoCAD program know where your AutoLISP files are stored.

Chapter 21: Using the Visual LISP Editor (Windows only) In this chapter, you will learn how to use the Visual LISP® Editor. The editor provides tools for writing, formatting, validating, and debugging code in an AutoLISP file. Using the Visual LISP Editor, you can group AutoLISP files into project files, which make them easy to manage and compile. Compiling an AutoLISP file secures the source code contained in the file so that it can't be altered by others.

Chapter 22: Working with ActiveX/COM Libraries (Windows only) In this chapter, you will learn how to use ActiveX/COM libraries with AutoLISP. ActiveX provides access to additional functions, which allow for the creation and manipulation of drawing objects and AutoCAD application settings that aren't easily accessible with standard AutoLISP functions. External applications, such as Microsoft Word and Excel, can also be accessed from the AutoCAD program when using ActiveX.

Chapter 23: Implementing Dialog Boxes (Windows only) In this chapter, you will learn how to create and use dialog boxes with an AutoLISP program. Dialog boxes provide an alternative method of requesting input from the user and are implemented using Dialog Control Language (DCL).

#### Part III: AutoCAD VBA: Programming with VBA and ActiveX (Windows only)

Chapter 24: Understanding the AutoCAD VBA Environment In this chapter, you'll get an introduction to the Visual Basic Editor. I begin by showing you how to verify whether the VBA environment for AutoCAD has been installed and, if not, how to install it. After that, you are eased into navigating the Visual Basic Editor and managing VBA programs. The chapter wraps up with learning how to execute macros and access the help documentation.

Chapter 25: Understanding Visual Basic for Applications In this chapter, you'll learn the fundamentals of the VBA programming language and how to work with objects. VBA fundamentals include a look at the syntax and structure of a statement, how to use a function, and how to work with variables. Beyond syntax and variables, you learn to group multiple statements into custom procedure.

Chapter 26: Interacting with the Application and Documents Objects In this chapter, you'll learn to work with the AutoCAD application and manage documents. Many of the tasks you perform with an AutoCAD VBA program require you to work with either the application or a document. For example, you can get the objects in a drawing and even access end-user preferences. Although you typically work with the current document, VBA allows you to work with all open documents and create new documents. From the current document, you can execute commands and work with system variables from within a VBA program, which allows you to leverage and apply your knowledge of working with commands and system variables.

Chapter 27: Creating and Modifying Drawing Objects In this chapter, you'll learn to create and modify graphical objects in model space with VBA. Graphical objects represent the drawing objects, such as a line, an arc, or a circle. The methods and properties of an object are used to modify and obtain information about the object. When working with the objects in a drawing, you can get a single object or step through all objects in a drawing.

Chapter 28: Interacting with the User and Controlling the Current View In this chapter, you'll learn to request input from an end-user and manipulate the current view of a drawing. Based on the values provided by the end-user, you can then determine the end result of the program. You can evaluate the objects created or consider how a drawing will be output, and use that information to create named views and adjust the current view in which objects are displayed.

Chapter 29: Annotating Objects In this chapter, you'll learn how to create and modify annotation objects. Typically, annotation objects are not part of the final product that is built or manufactured based on the design in the drawing. Rather, annotation objects are used to communicate the features and measurements of a design. Annotation can be a single line of text that is used as a callout for a leader, a dimension that indicates the distance between two drill holes, or a table that contains quantities and information about the windows and doors in a design.

Chapter 30: Working with Blocks and External References In this chapter, you'll learn how to create, modify, and manage block definitions. Model space in a drawing is a special named block definition, so working with block definitions will feel familiar. Once you create a block definition, you will learn how to insert a block reference and work with attributes along with dynamic properties. You complete the chapter by learning how to work with externally referenced files.

Chapter 31: Outputting Drawings In this chapter, you will learn how to output the graphical objects in model space or on a named layout to a printer, plotter, or electronic file. Named layouts will be used to organize graphical objects for output, including title blocks, annotation, floating viewports, and many others. Floating viewports will be used to control the display of objects from model space on a layout at a specific scale. After you define and configure a layout, you learn to plot and preview a layout. The chapter wraps up with learning how to export and import file formats.

Chapter 32: Storing and Retrieving Custom Data In this chapter, you will learn how to store custom information in a drawing or in the Windows Registry. Using extended data (Xdata), you will be able to store information that can be used to identify a graphical object created by your program or define a link to a record in an external database. In addition to attaching information to an object, you can store data in a custom dictionary that isn't attached to a specific graphical object in a drawing. Both Xdata and custom dictionaries can be helpful in making information available between drawing sessions; the Windows Registry can persist data between sessions.

Chapter 33: Modifying the Application and Working with Events In this chapter, you will learn how to customize and manipulate the AutoCAD user interface. You also learn how to load and access externally defined custom programs and work with events. Events allow you to respond to an action that is performed by the end-user or the AutoCAD application. There are three main types of events that you can respond to: application, document, and object.

Chapter 34: Creating and Displaying User Forms In this chapter, you will learn how to create and display user forms. User forms provide a more visual approach to requesting input from the user.

Chapter 35: Communicating with Other Applications In this chapter, you will learn how to work with libraries provided by other applications. These libraries can be used to access features of the Windows operating system, read and write content in an external text or XML file, and even work with the applications that make up Microsoft Office.

Chapter 36: Handling Errors and Deploying VBA Projects In this chapter, you will learn how to catch and handle errors that are caused by the incorrect use of a function or the improper handling of a value that is returned by a function. The Visual Basic Editor provides tools that allow you to debug code statements, evaluate values assigned to user-defined variables, identify where within a program an error has occurred, and determine how errors should be handled. The chapter wraps everything up with learning how to deploy a VBA project on other workstations for use by individuals at your company.

Bonus Chapter 1: Working with 2D Objects and Object Properties In this chapter, you build on the concepts covered in Chapter 27,「Creating and Modifying Drawing Objects.」You will learn to create additional types of 2D objects and use advanced methods of modifying objects, you also learn to work with complex 2D objects, such as regions and hatch fills. The management of layers and linetypes and the control of the appearance of objects are also covered.

Bonus Chapter 2: Modeling in 3D Space In this chapter, you learn to work with objects in 3D space, and 3D objects. 3D objects can be used to create a model of a drawing which can be used to help visualize a design or detect potential design problems. 3D objects can be viewed from different angles and used to generate 2D views of a model that can be used to create assembly directions or shop drawings.

Bonus Chapter 3: Development Resources In this chapter, you discover resources that can help expand the skills you develop from this book or locate an answer to a problem you might encounter. I cover development resources, places you might be able to obtain instructor-led training, and interact with fellow users on extending AutoCAD. The online resources sites listed cover general customization, AutoLISP, and VBA programming in AutoCAD.

NOTE:

Bonus Chapters 1, 2, and 3 are located on the companion website.

Companion Website:

An online counterpart to this book, the companion web page contains the sample files required to complete the exercises found in this book, in addition to the sample code and project files used to demonstrate some of the programming concepts explained in this book. In addition, the web page contains resources that are not mentioned in this book, such as the bonus chapters. The companion web page can be found at www.sybex.com/go/autocadcustomization.

### 6. Other Information

This book assumes that you know the basics of your operating system—Windows or Mac OS X—and AutoCAD 2009 or later. When appropriate, I indicate when a feature does not apply to a specific operating system or release of AutoCAD. Most of the images in this book were taken using AutoCAD 2014 in Windows 8 and AutoCAD 2014 in Mac OS X 10.7. While the images were taken in AutoCAD 2014 for consistency across the book, the content still applies to AutoCAD 2015, which was the latest release available when the content was completed.

NOTE:

Part II doesn't apply to AutoCAD LT®, and Part III doesn't apply to either AutoCAD LT on Windows or Mac OS or AutoCAD running on Mac OS.

### 7. Styles and Conventions of This Book

This book uses a number of styles and character formats—bold, italic, monotype face, all uppercase or lowercase letters, among others—to help you distinguish between the text you read, sample code you can try, text that you need to enter at the AutoCAD Command prompt, or the name of an object class or method in one of the programming languages.

As you read through this book, keep the following conventions in mind:

1. User interface selections are represented by one of the following methods: Click Application button Options.

    On the Ribbon, click Manage tab Customization User Interface.

    On the menu bar, click Tools Customize Interface.

    In the drawing window, right-click and click Options.

2. Keyboard input is shown in bold (for example, type cui and press Enter).

3. Prompts that are displayed at the AutoCAD Command prompt are displayed as monospace font (for example, Specify a start point:).

4. AutoCAD command, system variable, and AutoLISP function names are displayed in all lowercase letters with a monospace font (for example, line or clayer).

5. VBA function and AutoCAD Object library member names are displayed in mixed case letters with a monospace font (for example, Length or SendCommand).

6. Example code and code statements that appear within a paragraph are displayed in monospace font. Code samples might look like one of the following: 

```
(command "._circle" PAUSE 3)

MsgBox "ObjectName: " & oFirstEnt.ObjectName

The MsgBox method can be used to display a text message to the user

' Gets the first object in model space
```

### 8. Contacting the Author

I hope that you enjoy AutoCAD Platform Customization: User Interface, AutoLISP, VBA, and Beyond, and that it changes the way you think about completing your day-to-day work. If you have any feedback about or ideas that could improve this book, you can contact me using the following address:

Lee Ambrosius: lee_ambrosius@hyperpics.com

On my blog and website, you'll find additional articles on customization and samples that I have written over the years. You'll find these resources here:

Beyond the UI: http://hyperpics.blogs.com

HyperPics: www.hyperpics.com

If you encounter any problems with this publication, please report them to the publisher. Visit the book's website, www.sybex.com/go/autocadcustomization, and click the Errata link to open a form and submit the problem you found.

## Table of Contents

Acknowledgments

About the Author

Introduction About This Book

Customization in AutoCAD

AutoLISP in AutoCAD

VBA in AutoCAD

What to Expect

Other Information

Styles and Conventions of This Book

Contacting the Author

Part I: AutoCAD Customization: Increasing Productivity through Personalization 

Chapter 1: Establishing the Foundation for Drawing Standards Naming Standards for Projects and Files

Chapter 2: Working with Nongraphical Objects Standardizing the Names of Nongraphical Objects

Chapter 3: Building the Real World One Block at a Time Defining and Editing a Block Definition

Chapter 4: Manipulating the Drawing Environment Getting Started with Drawing-Environment Customization

Chapter 5: Customizing the AutoCAD User Interface for Windows Getting Started with the CUI Editor

Chapter 6: Customizing the AutoCAD User Interface for Mac Getting Started with the Customize Dialog Box

Chapter 7: Creating Tools and Tool Palettes What Is a Tool Palette?

Chapter 8: Automating Repetitive Tasks Creating and Running Scripts

Chapter 9: Defining Shapes, Linetypes, and Hatch Patterns Creating and Compiling Shapes

Chapter 10: Using, Loading, and Managing Custom Files Deploying Your Custom Files

Part II: AutoLISP: Productivity through Programming 

Chapter 11: Quick Start for New AutoLISP Programmers Working with AutoLISP Expressions

Chapter 12: Understanding AutoLISP Getting Started with AutoLISP

Chapter 13: Calculating and Working with Values Calculating Values with Math Functions

Chapter 14: Working with Lists What Are Lists?

Chapter 15: Requesting Input and Using Conditional and Looping Expressions Interacting with the User

Chapter 16: Creating and Modifying Graphical Objects Working with Entity Names and Dotted Pairs

Chapter 17: Creating and Modifying Nongraphical Objects Working with Symbol Tables

Chapter 18: Working with the Operating System and External Files Storing Information in the Windows Registry or a Plist File

Chapter 19: Catching and Handling Errors Identifying and Tracking Down Errors

Chapter 20: Authoring, Managing, and Loading AutoLISP Programs Storing AutoLISP Expressions

Chapter 21: Using the Visual LISP Editor (Windows only) Accessing the Visual LISP Editor

Chapter 22: Working with ActiveX/COM Libraries (Windows only) Understanding the Basics of ActiveX

Chapter 23: Implementing Dialog Boxes (Windows only) What Is Dialog Control Language?

Part III: AutoCAD VBA: Programming with VBA and ActiveX (Windows only) 

Chapter 24: Understanding the AutoCAD VBA Environment What Makes Up an AutoCAD VBA Project?

Chapter 25: Understanding Visual Basic for Applications Learning the Fundamentals of the VBA Language

Chapter 26: Interacting with the Application and Documents Objects Working with the Application

Chapter 27: Creating and Modifying Drawing Objects Understanding the Basics of a Drawing-Based Object

Chapter 28: Interacting with the User and Controlling the Current View Interacting with the User

Chapter 29: Annotating Objects Working with Text

Chapter 30: Working with Blocks and External References Managing Block Definitions

Chapter 31: Outputting Drawings Creating and Managing Layouts

Chapter 32: Storing and Retrieving Custom Data Extending Object Information

Chapter 33: Modifying the Application and Working with Events Manipulating the AutoCAD User Interface

Chapter 34: Creating and Displaying User Forms Adding and Designing a User Form

Chapter 35: Communicating with Other Applications Referencing a Programming Library

Chapter 36: Handling Errors and Deploying VBA Projects Catching and Identifying Errors

## List of Illustrations

Chapter 1: Establishing the Foundation for Drawing Standards 

Figure 1.1 Possible project numbering structure

Figure 1.2 Possible file-naming structure

Figure 1.3 Drawing Units dialog box. The Windows version of the dialog box appears on the top the Mac OS version appears on the bottom.

Figure 1.4 Editing a plotter configuration file

Figure 1.5 Editing a plot style file. The Windows version of the dialog box appears on the top and the Mac OS version on the bottom.

Figure 1.6 Configuring drawing standards files

Figure 1.7 Enabling the plug-ins to use when validating drawing standards

Figure 1.8 Changing the notification and Check Standards settings

Figure 1.9 Access to CAD Standards notifications and settings is just a click away.

Figure 1.10 Standards violation found

Figure 1.11 The check for standards violations is complete.

Figure 1.12 Standards violation detected

Figure 1.13 Morethan one drawing can be checked for standards violations with the Batch Standards Checker.

Figure 1.14 Use this report to determine which files contain standards violations so they can be fixed.

Figure 1.15 Translating layers between CAD standards

Figure 1.16 Defining a new layer to use as part of the layer translation map

Figure 1.17 Changing the settings to use when translating layers

Chapter 2: Working with Nongraphical Objects 

Figure 2.1 Possible layer-naming structure

Figure 2.2 Renaming nongraphical objects

Figure 2.3 Organizing objects with layers

Figure 2.4 Setting the color of a layer

Figure 2.5 Managing linetypes and scales

Figure 2.6 Controlling the display of lineweights

Figure 2.7 Changing layer settings affects the way you work with layers in the drawing window and user interface.

Figure 2.8 Unreconciled layer notification balloon

Figure 2.9 Creating dynamic filters based on layer names and properties

Figure 2.10 Saving layer states allows you to later restore the visibility and properties of the layers in a drawing.

Figure 2.11 The appearance of text can be controlled with text styles.

Figure 2.12 Creating and defining dimension styles

Figure 2.13 Updating the properties of a table style

Figure 2.14 Modifying a multileader style

Chapter 3: Building the Real World One Block at a Time 

Figure 3.1 Defining a block

Figure 3.2 Block editing environment

Figure 3.3 Tools available for modifying the objects and behavior of a block definition

Figure 3.4 Inserting a block definition

Figure 3.5 Defining an attribute definition

Figure 3.6 You can edit attribute values after inserting a block reference.

Figure 3.7 Modifying a block's dynamic properties with grips (left: in the drawing window; right: in the Block Editor)

Figure 3.8 Defining a lookup table for a dynamic block

Figure 3.9 Defining a lookup table for a dynamic block

Chapter 4: Manipulating the Drawing Environment 

Figure 4.1 Setting the properties for the new shortcut

Figure 4.2 Switching workspaces

Figure 4.3 Setting application preferences

Figure 4.4 Elements of the drawing window

Figure 4.5 Customizing the input search options for the Command prompt

Figure 4.6 Accessing recently used commands and coordinate values

Figure 4.7 Controlling the behavior and appearance of dynamic input

Figure 4.8 Command suggestion list based on typed characters

Figure 4.9 AutoCorrect entry in the command suggestion list

Chapter 5: Customizing the AutoCAD User Interface for Windows 

Figure 5.1 The CUI Editor lets you create and modify user-interface elements.

Figure 5.2 Command-line history of the input you previously entered

Figure 5.3 Defining the properties of a command

Figure 5.12 Tooltip for the custom Wheelchair Note command

Figure 5.4 The properties of the completed command

Figure 5.5 Creating a custom image

Figure 5.6 Example custom image

Figure 5.7 Managing images in the loaded CUIx files

Figure 5.8 Accessing the customization options for the Quick Access toolbar

Figure 5.9 Adding a command to the QAT

Figure 5.10 Accessing the controls that can be placed on the QAT

Figure 5.11 Results of the customization to the QAT

Figure 5.13 The results of using the Wheelchair Note command

Figure 5.14 Command and control organization using the ribbon

Figure 5.15 Structure of the Home 2D - Draw panel

Figure 5.16 Structure for the new My Tools panel

Figure 5.17 The completed My Tools panel

Figure 5.18 Favorites tab with the My Tools panel

Figure 5.19 Customizing the current workspace

Figure 5.20 Adding the ribbon tab to the current workspace

Figure 5.21 Controlling the order of the ribbon tab with the workspace

Figure 5.22 The Favorites tab displayed on the ribbon

Figure 5.23 The custom Edit Text tab displayed when the multiline text object was selected

Figure 5.24 Structure of the Favorites pull-down menu in the CUI Editor

Figure 5.25 Favorites pull-down menu on the menu bar

Figure 5.26 Line Objects Menu in the drawing window

Figure 5.27 Structure of the Favorites toolbar in the CUI Editor and how it appears in the user interface

Figure 5.28 Rollover tooltip and Quick Properties panel displaying the properties for an arc

Figure 5.29 Controlling the appearance and behavior of the Quick Properties palette

Figure 5.30 Modifying the properties displayed on the rollover tooltip for a Hatch object

Figure 5.31 Controlling the display of tools on the status bar

Chapter 6: Customizing the AutoCAD User Interface for Mac 

Figure 6.1 You create and modify user-interface elements by using the Customize dialog box.

Figure 6.2 Command-line history of the input you previously entered

Figure 6.3 The properties of the completed command

Figure 6.4 Wheelchair command with the custom icon

Figure 6.5 Structure of the Favorites pull-down menu in the Customize dialog box

Figure 6.6 Favorites pull-down menu on the menu bar

Figure 6.7 The results of using the Wheelchair Note command

Figure 6.8 Structure of the Open Shapes tool group

Figure 6.9 Structure for the new Favorites toolset and the My Tools tool group

Figure 6.10 Completed Favorites toolset and My Tools tool group

Figure 6.11 Controlling the display of tools on the status bar

Chapter 7: Creating Tools and Tool Palettes 

Figure 7.1 Tool palettes in the Tool Palettes window

Figure 7.2 Components of the Tool Palettes window

Figure 7.3 Controlling the image size and style for tools

Figure 7.4 Adding a new tool based on a line object from the drawing area

Figure 7.5 New Line tool on a custom tool palette

Figure 7.6 A flyout offers additional related geometric tools.

Figure 7.7 Changing the properties of a tool

Figure 7.8 Controlling which tools are displayed on the flyout

Figure 7.9 Revised tool and flyout

Figure 7.10 Searching for named objects and support files

Figure 7.11 Creating and managing tool-palette groups

Chapter 8: Automating Repetitive Tasks 

Figure 8.1 Action Recorder panel on the ribbon

Figure 8.2 The Action Tree shows recently recorded actions.

Figure 8.3 Recorded actions and values used to create a new layer named Hardware with the color blue

Figure 8.4 Saving recorded actions to an action macro

Chapter 9: Defining Shapes, Linetypes, and Hatch Patterns 

Figure 9.1 Determining which value to use for vector angles (left) or octants (right)

Figure 9.2 BAT shape inserted into the drawing (top) along with a polyline with the Batting linetype assigned (bottom)

Figure 9.3 sBreakdown of the BAT shape

Figure 9.4 Inserted DMOND shape (left) and a breakdown of its shape definition (right)

Figure 9.5 Dash Dot Dash linetype assigned to a polyline

Figure 9.6 Plot Line linetype assigned to a polyline

Figure 9.7 Same object with different linetype scale factors

Figure 9.8 Breakdown of the AR-B816 hatch pattern

Figure 9.9 sDiamonds hatch pattern used to fill a rectangle

Figure 9.10 Diamonds hatch pattern in the Hatch Pattern gallery

Figure 9.11 Pattern button on the Hatch visor

Figure 9.12 Available hatch patterns in the hatch library

Chapter 10: Using, Loading, and Managing Custom Files

 Figure 10.1 Loading a custom program

Figure 10.2 Internet search results on AutoLISP files

Chapter 11: Quick Start for New AutoLISP Programmers 

Figure 11.1 Result of using AutoLISP expressions with the circle command

Figure 11.2 Drawing concentric circles with AutoLISP

Figure 11.3 Converting a rectangle to a revision cloud

Figure 11.4 Loading the acp_qs.lsp file

Chapter 12: Understanding AutoLISP 

Figure 12.1 Structure of an AutoLISP expression

Figure 12.2 Result of the drawplate custom function

Chapter 13: Calculating and Working with Values Figure 13.1 Multiline text object created from multiple string values

Chapter 16: Creating and Modifying Graphical Objects

Chapter 17: Creating and Modifying Nongraphical Objects

Chapter 18: Working with the Operating System and External Files

Chapter 19: Catching and Handling Errors

Chapter 20: Authoring, Managing, and Loading AutoLISP Programs

Chapter 21: Using the Visual LISP Editor (Windows only)

Chapter 22: Working with ActiveX/COM Libraries (Windows only)

Chapter 23: Implementing Dialog Boxes (Windows only) Figure

Chapter 24: Understanding the AutoCAD VBA Environment Figure

Chapter 26: Interacting with the Application and Documents Objects

Chapter 27: Creating and Modifying Drawing Objects Figure

Chapter 28: Interacting with the User and Controlling the Current View

Chapter 29: Annotating Objects

Chapter 30: Working with Blocks and External References

Chapter 31: Outputting Drawings Figure 31.1 New layout with a title block

Chapter 32: Storing and Retrieving Custom Data

Chapter 33: Modifying the Application and Working with Events

Chapter 34: Creating and Displaying User Forms

Chapter 35: Communicating with Other Applications

Chapter 36: Handling Errors and Deploying VBA Projects

## List of Tables

Chapter 1: Establishing the Foundation for Drawing Standards 

Table 1.1 System variables

Table 1.2 AutoCAD releases and drawing file formats

Chapter 2: Working with Nongraphical Objects 

Table 2.1 System variables used to set default property values

Chapter 3: Building the Real World One Block at a Time 

Table 3.1 Block properties available for use in an attribute-extraction template

Chapter 4: Manipulating the Drawing Environment 

Table 4.1 AutoCAD command-line switches

Table 4.2 Commonly used command aliases

Chapter 5: Customizing the AutoCAD User Interface for Windows 

Table 5.1 Meaning of macro components

Table 5.2 Special characters that can be used in macros

Table 5.3 Customizable shortcut menus

Table 5.4 Aliases and alias naming conventions for shortcut menus

Table 5.5 Special names used to identify types of block reference objects

Chapter 6: Customizing the AutoCAD User Interface for Mac 

Table 6.1 Macro components used in the circle example

Table 6.2 Special characters that can be used in macros

Chapter 8: Automating Repetitive Tasks 

Table 8.1 Command-line equivalent commands (Windows and Mac OS)

Table 8.2 Command-line equivalent commands (Windows only)

Chapter 9: Defining Shapes, Linetypes, and Hatch Patterns 

Table 9.1 Components of a shape header line

Table 9.2 Shape specification line codes

Table 9.3 Codes and values for a BAT shape

Table 9.4 Values of the Center linetype

Table 9.5 Text string and shape object values

Table 9.6 Pattern-definition line values

Table 9.7 Values of the AR-B816 hatch pattern

Chapter 12: Understanding AutoLISP 

Table 12.1 AutoLISP expressions

Table 12.2 Special characters that can prefix a command name

Table 12.3 AutoLISP expressions used to define the drawplate function

Chapter 13: Calculating and Working with Values 

Table 13.1 AutoLISP advanced math functions

Table 13.2 AutoLISP functions for converting numeric values to strings

Table 13.3 AutoLISP functions for converting strings to numeric values

Table 13.4 AutoLISP functions for converting numeric values

Chapter 14: Working with Lists 

Table 14.1 AutoLISP list sorting functions

Chapter 15: Requesting Input and Using Conditional and Looping Expressions 

Table 15.1 initget flags argument bitcodes

Table 15.2 Example grread returns

Table 15.3 AutoLISP functions for testing the values of a variable

Table 15.4 AutoLISP looping functions

Chapter 16: Creating and Modifying Graphical Objects 

Table 16.1 Common DXF group codes

Table 16.2 Automatically generated DXF group code values

Table 16.3 Optional DXF group code values

Table 16.4 Required DXF group code values

Table 16.5 ssget selection methods

Table 16.6 AutoLISP object property functions

Table 16.7 dumpallproperties Area property description

Table 16.8 XData-related DXF group codes

Chapter 17: Creating and Modifying Nongraphical Objects 

Table 17.1 Symbol-Table names

Table 17.2 Functions that can be used to modify symbol Table entries

Table 17.3 Symbol Table entry name and modification limits

Chapter 18: Working with the Operating System and External Files 

Table 18.1 ASCII file access modes

Table 18.2 File-browsing mode argument bitcodes

Table 18.3 AutoLISP file-management functions

Table 18.4 AutoLISP file-related functions

Chapter 20: Authoring, Managing, and Loading AutoLISP Programs 

Table 20.1 Automatically loaded LSP files

Table 20.2 Files for DrawPlate.bundle

Chapter 21: Using the Visual LISP Editor (Windows only) 

Table 21.1 Additional Visual LISP Editor debugging tools

Chapter 22: Working with ActiveX/COM Libraries (Windows only) 

Table 22.1 Common data types used with the vlax-make-variant function

Table 22.2 Additional array functions

Chapter 23: Implementing Dialog Boxes (Windows only) 

Table 23.1 Common attributes used with the dialog tile

Table 23.2 Interactive tiles available with the dialog tile

Table 23.3 Common attributes used with control tiles

Table 23.4 Tile subassemblies

Table 23.5 Cluster tiles

Table 23.6 Attributes used with aligning and sizing tiles

Table 23.7 Spacer tiles

Table 23.8 Modes available for use with the mode_tile function

Table 23.9 List-editing modes

Table 23.10 AutoLISP functions used to work with image and image_button tiles

Table 23.11 Predefined variables that contain information about the current tile

Chapter 25: Understanding Visual Basic for Applications 

Table 25.1 VBA data types

Table 25.2 VBA math functions and operators

Table 25.3 VBA string manipulation functions and operators

Table 25.4 Special constants with ASCII values

Table 25.5 VBA data conversion functions

Chapter 26: Interacting with the Application and Documents Objects 

Table 26.1 Application-related properties

Table 26.2 Application window–related properties

Table 26.3 Drawing file–related properties

Table 26.4 Drawing window–related properties

Table 26.5 Preference objects accessible from the application

Chapter 27: Creating and Modifying Drawing Objects 

Table 27.1 Properties related to the AcadObject object

Table 27.2 Properties related to the AcadEntity object

Table 27.3 Methods related to the AcadEntity object

Table 27.4 Properties used to access the collection objects of an AcadDocument object

Table 27.5 Properties related to an AcadLine object

Table 27.6 Properties related to an AcadCircle object

Table 27.7 Properties related to an AcadArc object

Table 27.8 Properties related to an AcadLWPolyline or AcadPolyline object

Table 27.9 Methods related to an AcadLWPolyline or AcadPolyline object

Chapter 28: Interacting with the User and Controlling the Current View 

Table 28.1 Bit codes available for the InitializeUserInput method

Table 28.2 Object selection methods

Table 28.3 Zoom-related methods

Table 28.4 Properties related to an AcadViewport object

Table 28.5 Properties related to an AcadView object

Chapter 29: Annotating Objects 

Table 29.1 Control codes for AcadText objects

Table 29.2 Functions used to create new dimensions

Chapter 30: Working with Blocks and External References 

Table 30.1 Constant values of the AcAttributeMode enumerator

Table 30.2 Properties related to an AcadAttribute object

Table 30.3 Properties related to an AcadBlock object

Table 30.4 Properties used to determine a block definition's type

Table 30.5 Properties used to affect a block reference

Table 30.6 Methods used to manage an xref

Table 30.7 Raster image–related properties and methods

Table 30.8 Underlay-related properties

Chapter 31: Outputting Drawings 

Table 31.1 Display-related properties of an AcadPViewport object

Table 31.2 Drafting aids–related properties of an AcadPViewport object

Table 31.3 Sheet view–related properties of an AcadPViewport object

Table 31.4 Constant values of the AcPlotType enumerator

Table 31.5 Additional plot settings of an AcadPlotConfiguration object

Chapter 32: Storing and Retrieving Custom Data 

Table 32.1 Xdata-related DXF group codes

Chapter 33: Modifying the Application and Working with Events 

Table 33.1 Properties that describe an AcadPopupMenu collection object

Table 33.2 Properties that describe an AcadPopupMenuItem object

Table 33.3 Methods used to manage pull-down menus on the menu bar

Table 33.4 Properties that describe an AcadToolbar collection object

Table 33.5 Properties that describe an AcadToolbarItem object

Table 33.6 Common events for the AcadApplication and AcadDocument objects

Chapter 34: Creating and Displaying User Forms 

Table 34.1 Common UserForm or control properties

Table 34.2 Common UserForm or control events

Chapter 35: Communicating with Other Applications 

Table 35.1 Common class IDs for the AutoCAD Object library Application object

Table 35.2 Drive-related methods of the FileSystemObject object

Table 35.3 Folder-related methods of the FileSystemObject object

Table 35.4 File-related methods of the FileSystemObject object

Table 35.5 File modes available for the OpenTextFile statement

Table 35.6 File formats available for the OpenTextFile statement

Chapter 36: Handling Errors and Deploying VBA Projects 

Table 36.1 Err object–related properties
