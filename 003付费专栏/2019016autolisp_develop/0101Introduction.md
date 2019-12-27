# 0101. Introduction (AutoLISP)

For years, AutoLISP ® has set the standard for customizing and extending the AutoCAD ® program while Visual LISP ® (VLISP) extends the functionality of AutoLISP by adding significantly more capabilities. Some of the functionality of Visual LISP extends the core functionality of the standard AutoLISP programming language available on Windows and Mac OS, but much of the functionality is available on Windows only as it requires the Microsoft ActiveX ® Automation interface. Visual LISP isn't just an extension of AutoLISP, but is also a complete and integrated development environment (IDE) that includes a compiler, debugger, and other tools to increase productivity when developing custom programs.

Note: The Visual LISP IDE is only available on Windows.

## 01. About Getting Organized (AutoLISP)

AutoLISP programs can be very simple in nature, executing a few commands that you might commonly use throughout the a day.

They can also be very complex, extracting and formatting information from blocks, and constructing the extracted information into a table. When you first get started, keep things simple and then once you feel comfortable with AutoLISP then start looking at conditional and looping statements.

When you begin to develop an AutoLISP program, you should keep the following steps in mind:

1. Think about which tasks you want to accomplish.

2. Design the program.

3. Write the code.

4. Add comments and format the code for readability.

5. Test and debug the program.

## 02. AutoLISP and Visual LISP (AutoLISP)

AutoLISP is a programming language designed for extending and customizing AutoCAD product functionality.

It is based on the LISP programming language, whose origins date back to the late 1950s. LISP was originally designed for use in Artificial Intelligence (AI) applications, and is still the basis for many AI applications.

Autodesk introduced AutoLISP as an application programming interface (API) in Release 2.1, in the mid-1980s. LISP was chosen as the initial AutoCAD API because it was uniquely suited for the unstructured design process of AutoCAD projects, which involved repeatedly trying different solutions to design problems.

AutoLISP programs are developed using a basic ASCII text editor, such as NotePad on Windows or TextEdit on Mac OS, or the Visual LISP (VLISP) integrated development environment (IDE) on Windows only. The Visual LISP integrated development environment (IDE) provides features to help ease the tasks of source-code creation and modification, program testing, and debugging.

After an AutoLISP program is written, it must loaded into the product before it can be used or debugged. Debugging your program allows you to evaluate and verify the code is working as expected, and if not identify what might be going wrong. The basics of debugging involve adding statements to the code and reviewing the contents of variables at strategic points in the program. If you discover you still do not have enough information to determine the error, you change the code again by adding additional debugging points. And finally, when you get the program working, you can either comment out or remove the debugging code.

## 03. About AutoLISP Documentation (AutoLISP)

This documentation introduces the constructs of the AutoLISP language, and explains how to write and run AutoLISP programs.

If you have developed AutoLISP programs in earlier releases of AutoCAD, it is important that you refer to the "New and Changed AutoLISP Functions Reference (AutoLISP)" topic for information on additions and changes to AutoLISP that may affect your programs.

The AutoLISP documentation is broken down into three types of content:

1. Reference documentation describes what every AutoLISP function does and provides basic samples to see how a function can be used.

2. Tutorial documentation contains step-by-step instructions guiding you toward writing a working AutoLISP program.

3. Developer's documentation assumes you have some experience with AutoCAD. Prior experience with AutoLISP is not required.

2『上面的这 3 个大文档要去看完。』

The following is covered by the AutoLISP Developer's documentation:

1. Details on the concepts and structures of the AutoLISP language.

2. Provides a summary of all AutoLISP functions by category and information on AutoLISP error codes.

3. Describes how to develop and test AutoLISP programs.

4. Explains how to design and implement dialog boxes with AutoLISP applications. (Windows only)

## 04. Related Developer References (AutoLISP)

In addition to the AutoLISP reference and tutorial topics, several other AutoCAD documentation resources might be required for building and deploying applications.

You might need to use these resources when working with AutoLISP:

1. AutoCAD ActiveX Reference and Developer's Guides contain information on accessing ActiveX methods, properties, objects, and events. If you develop AutoLISP applications that use ActiveX automation to reference AutoCAD objects, you will need to refer to these guides. The help files can be accessed from %ProgramFiles%\Common Files\Autodesk Shared. (AutoCAD for Mac does not support ActiveX)
AutoCAD Customization topics contain basic information on creating and modifying customizable files. For example, they include information on customizing the user interface, and creating custom linetypes and hatch patterns. These topics can be found in the AutoCAD product help.

2. The DXF Reference describes the drawing interchange format (DXF™) and the DXF group codes that identify attributes of AutoCAD objects. You might need to refer to the DXF Reference when working with association lists describing entity data. The DXF Reference is available through the AutoCAD product help or the Autodesk website (www.autodesk.com/dxf).

4. The ObjectARX Reference and Developer's Guides contain information on using ObjectARX® to develop custom AutoCAD applications. AutoCAD reactor functionality is implemented through ObjectARX. If you develop AutoLISP applications that implement reactor functions, you may want to refer to the ObjectARX Reference . The ObjectARX Reference and Developer's Guides are not installed with the AutoCAD program. To obtain this documentation, download the ObjectARX SDK (Software Development Kit) from the www.autodesk.com/objectarx.

5. The Managed .NET Reference and Developer's Guides contain information on using the Managed .NET API to develop custom AutoCAD applications. The Managed .NET Reference is not installed with the AutoCAD program. To obtain this documentation, download the ObjectARX SDK (Software Development Kit) from the www.autodesk.com/objectarx. The Managed .NET Developer's Guide is available from the AutoCAD product help. (AutoCAD for Mac does not support Managed .NET development)

## 05. New and Changed AutoLISP Functions Reference (AutoLISP)

Additions and changes made to AutoLISP.

### AutoCAD 2018

No new or changed functions.

### AutoCAD 2017

No new or changed functions.

### AutoCAD 2016

Changed:

osnap - Returns a 3D point that is the result of applying an Object Snap mode to a specified point. The function no longer accepts the qui mode. Using the qui mode results in a value of nil to be returned, even if other modes are specified.

Obsolete:

getcfg - Retrieves application data from the AppData section of the acad20xx.cfg file.

setcfg - Writes application data to the AppData section of the acad20xx.cfg file.

Note: getcfg and setcfg are still available for compatibility, but might be removed in a future release. It is recommended to use the vl-registry-read and vl-registry-write functions as replacements.

### AutoCAD 2015

No new or changed functions.

### AutoCAD 2014

New:

findtrustedfile - Searches the AutoCAD trusted file paths for the specified file.

showHTMLModalWindow - Displays a modal window with a HTML document; use in conjunction with the new JavaScript API.

Changed:

findfile - Searches the AutoCAD support and trusted file paths. Function was updated to search the new trusted applications paths.

### AutoCAD 2013

New:

vlax-machine-product-key - Returns the AutoCAD Windows registry path in the HKLM (HKEY_LOCAL_MACHINE).

Obsolete:

vlax-product-key - Returns the AutoCAD Windows registry path.

### AutoCAD 2012

New:

command-s - Executes an AutoCAD command and the supplied input.

*pop-error-mode* - Error-handling function that ends the previous call to *push-error-using-command* or *push-error-using-stack*.

*push-error-using-command* - Error-handling function that indicates the use of the command function within a custom *error* handler.

*push-error-using-stack* - Error-handling function that indicates the use of variables from the AutoLISP stack within a custom *error* handler.

### AutoCAD 2011

New:

dumpallproperties - Retrieves an entity’s supported properties.

getpropertyvalue - Returns the current value of an entity’s property.

ispropertyreadonly - Returns the read-only state of an entity’s property.

setpropertyvalue - Sets the property value for an entity.

### AutoCAD 2010

Changes:

help - Invokes the Help facility. Function was updated to add support for HTML documentation.

### AutoCAD 2009

New:

initcommandversion - Forces the next command to run with the specified version.
