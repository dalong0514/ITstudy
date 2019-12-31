When the Macros dialog box opens, click the Macros In drop-down list and choose ch24_hexbolt.dvb. Figure 24.9 shows the macro that is stored in and can be executed from the ch24_hexbolt.dvb file with the Macros dialog box.

In the Macros list, choose basHexBolt.HexBolt and click Run. The Draw Hex Bolt View dialog box, shown in Figure 24.10, is displayed.

In the Diameter list box, choose 3/8 and click Insert.

At the Specify center of bolt head: prompt, specify a point in the drawing area to draw the top view of the hex bolt.

When the Draw Hex Bolt View dialog box reappears, in the View section click the Side option or image. Click Insert.

At the Specify middle of bolt head: prompt, specify a point in the drawing area to draw the side view of the hex bolt.

When the Draw Hex Bolt View dialog box reappears again, click Cancel. Figure 24.11 shows the top and side views of the hex bolt that were drawn with the macro.

Figure 24.9 Edit, debug, and execute macros from the Macros dialog box.

Figure 24.10 Custom dialog box used to draw a top or side view of a hex bolt

Figure 24.11 Views of the completed hex bolt

Accessing the AutoCAD VBA Documentation

The AutoCAD VBA documentation is available from the AutoCAD product Help landing page and the VBA Editor. The documentation is composed of two documentation sets: the AutoCAD Object Library Reference and the ActiveX Developer's Guide. Although this book is designed to make it easy to learn how to use the AutoCAD Object library and the VBA programming language, you will want to refer to the documentation that is provided with the AutoCAD product too, as it just isn't possible to cover every function and technique here.

The topics of the AutoCAD Object Library Reference explain the classes, methods, properties, and constants that make up the AutoCAD Object library. The ActiveX Developer's Guide topics can be used to explore advanced techniques and features that aren't covered in this book.

You can see the AutoCAD VBA and ActiveX documentation written for AutoCAD 2015 here:

http://help.autodesk.com/view/ACD/2015/ENU/

On the Autodesk AutoCAD 2015 Help landing page, click the Developer Home Page link. On the AutoCAD Developer Help Home Page, use the AutoCAD Object Library Reference and Developer's Guide links under the ActiveX/VBA section to access the AutoCAD VBA and ActiveX documentation.

When working in the VBA Editor, you can access the AutoCAD Object Library Reference and Microsoft Visual Basic for Applications Help by doing the following:

In a code editor window, highlight the keyword, statement, data type, method, property, or constant that you want to learn more about.

Press F1.

Help can also be accessed from the Object Browser. In the Object Browser, select a class, method, property, or constant and then press F1 to open the associated help topic. I discussed the Object Browser earlier, in the「Exploring Loaded Libraries with the Object Browser」section.

Chapter 25

Understanding Visual Basic for Applications

The Visual Basic for Applications (VBA) programming language is a variant of the Visual Basic 6 (VB6) programming language that was introduced in 1998. Though similar, VB6 isn't exactly the same as the current version of Visual Basic (known as VB.NET). Unlike VB6, which allows you to develop stand-alone applications, VBA programs require a host application. The host application provides the framework in which the VBA program can be executed; Microsoft Word and the Autodesk® AutoCAD® program are examples of host applications.

VBA was first introduced as a preview technology and modern programming alternative to AutoLISP® and ObjectARX® with AutoCAD Release 14 back in 1997. It was not until after the release of AutoCAD R14.01 that VBA was officially supported. The implementation of VBA in the AutoCAD program at that time was huge to the industry, as the learning curve between AutoLISP and C++ was steep, and the number of developers who knew VBA was growing rapidly.

Here are some of the reasons I recommend using VBA for your custom programs:

Individuals with VB/VBA experience often can be found in-house (check in your company's IS/IT department); finding someone fluent in AutoLISP or ObjectARX is much rarer.

VB/VBA resources are easier to locate—on the Internet or at your local library.

Connecting to external applications and data sources is simpler using VB/VBA.

VBA programs are relatively low maintenance; programs written for the last release of the AutoCAD program (even those written a decade ago) often run in the latest release with little to no change.

Learning the Fundamentals of the VBA Language

Before you learn to use VBA to automate the AutoCAD drawing environment, it is essential to have a basic understanding of the VBA or VB6 programming language. If you are not familiar with the VBA or VB6 programming language, I recommend reading this chapter before moving on.

In addition to this chapter, the Microsoft Visual Basic for Applications Help from the Help menu on the VBA Editor's menu bar and your favorite Internet search engine can be great resources for information on the VBA programming language. The following are a couple of web resources that can help you get started on locating additional information on VBA and VB6:

Microsoft's Programming Resources for Visual Basic for Applications page (http://support.microsoft.com/kb/163435)

Microsoft Developer Network: Visual Basic 6.0 Language Reference (http://msdn.microsoft.com/en-us/library/aa338033(v=vs.60).aspx)

Creating a Procedure

Most of the code you write in VBA will be grouped into a named code block called a procedure. If you are familiar with AutoLISP or another programming language, you might be familiar with the terms function or method. VBA supports two types of procedures:

Subroutine (or Sub) A named code block that doesn't return a value

Function A named code block that does return a value

The definition of a procedure always starts with the keyword Sub or Function followed by its designated name. The procedure name should be descriptive and should give you a quick idea of the purpose of the procedure. The naming of a procedure is personal preference—I like to use title casing for the names of the functions I define to help identify misspelled function names. For example, I use the name CreateLayer for a function that creates a new layer. If I enter createlayer in the VBA Editor window, the VBA Editor will change the typed text to CreateLayer to match the procedure's definition.

After the procedure name is a balanced set of parentheses that contains the arguments that the procedure expects. Arguments aren't required for a procedure, but the parentheses must be present. The End Sub or End Function keywords (depending on the type of procedure defined) must be placed after the last code statement of the procedure to indicate where the procedure ends.

The following shows the basic structures of a Sub procedure:

Sub ProcedureName() End Sub Sub ProcedureName(Arg1 As DataType, ArgN As DataType) End Sub

Here's an example of a custom procedure named MyDraftingAids that changes the values of two system variables—osmode to 35 and orthomode to 1.

Sub MyDraftingAids() ThisDrawing.SetVariable "osmode", 35 ThisDrawing.SetVariable "orthomode", 1 End Sub

When defining a procedure of the Function type, you must indicate the type of data that the procedure will return. In addition to indicating the type of data to return, at least one code statement in the procedure must return a value. You return a value by assigning the value to the procedure's name.

The following shows the basic structures of a Function procedure:

Function ProcedureName() As DataType ProcedureName = Value End Function Function ProcedureName(Arg1 As DataType, ArgN As DataType) As DataType ProcedureName = Value End Function

The arguments and return values you specify as part of a procedure follow the structure of dimensioning a variable. I explain how to dimension a variable in the next section.

Arguments can be prefixed with one of three optional keywords: Optional, ByRef, or ByVal. The Optional keyword can be used to pass a value to a procedure that might be needed only occasionally. You can learn more about these keywords from the VBA Editor Help system. The following demonstrates the definition of a function named CreateLayer that accepts an optional color argument using the Optional keyword:

Function CreateLayer(lyrName As String, _ Optional lyrColor As ACAD_COLOR = acGreen) As AcadLayer Dim objLayer As AcadLayer Set objLayer = ThisDrawing.Layers.Add(lyrName) objLayer.color = lyrColor Set CreateLayer = objLayer End Function

The value returned by that function is the new layer created by the Add method based on the name passed to the lyrName argument. The Add method returns an object of the AcadLayer type. After the layer is created, the color passed to lyrColor is assigned to the new layer's Color property. Finally, the new layer is returned by the assigning the value to CreateLayer. Since an object is being returned, the Set statement must be placed to the left of the variable name to assign the object to the variable. I discuss the Set statement in the「Working with Objects」section later in this chapter.

The following demonstrates how to use the CreateLayer procedure:

Dim newLayer as AcadLayer Set newLayer = CreateLayer("Object", acWhite)

Another concept that can be used when defining an optional argument is setting a default value. A default value is assigned to an argument using the equal symbol ( = ). In the previous example, the default value of the lyrColor argument is assigned the value of acGreen, which is a constant in the AutoCAD COM library that represents the integer value of 3. The optional value is used if no color value is passed to the CreateLayer function.

NOTE

The keywords Public and Private can be added in front of the Sub and Function keywords used to define a procedure. The Public keyword allows a procedure to be accessed across most code modules in a VBA project, whereas the Private keyword limits the procedure to be accessed only from the module in which it is defined. I explain these keywords further in the「Controlling the Scope of a Procedure or Variable」section later in this chapter.

You Want Me to Measure Hungary? Really?

No, I really don't. However, as you learn about VBA, you'll be exposed to some new (and seemingly strange) terms.

When instructions in a procedure want you to declare and define a variable in VBA, you'll be asked to dimension the variable. This will be accomplished using a Dim statement that looks something like this: Dim objLayer As AcadLayer.

When you begin working with user forms and variables, you'll be asked to add a Hungarian notation prefix, which helps you to identify UserForm objects and controls or the data type that variables are declared. Hungarian notation is a shorthand used by programmers to quickly provide identifying information. Here are a few common prefixes and their uses:

c or str: string data d: double i: integer o or obj: object btn: button cbo or cmb: combo box lbl: label txt: text box

Just remember, you're learning a new language. I'll do my best to explain the new terms in plain English in context as I use them, although you might have to wait until later in the chapter or book to get all the details.

Declaring and Using Variables

Variables are used to allocate space in memory to store a value, which can then be retrieved later using the name assigned to the variable. You can declare variables to have a specific value or assign it a new value as a program is being executed. I explain the basics of working with variables in the following sections.

Declaring a Variable

VBA by default allows you to dynamically create a variable the first time it is used within a procedure, but I don't recommend using this approach. Although it can save you time, the VBA Editor isn't able to assist in catching issues related to incorrect data types in a code statement.

The proper approach to declaring a variable is to use the Dim keyword and follow the keyword with the name of the variable to dimension. The Option statement can be helpful in ensuring that all variables are declared before being used. I mention the Option statement in the「Forcing the Declaration of Variables」sidebar.

Unlike procedure names, the industry uses Hungarian notation as a standard for naming variables in VBA programs. For example, you would add c or str in front of a variable name to represent a string or d for a double. The variable name for a layer name might look like cName or strLayerName, whereas a variable name that holds a double number for the radius of a circle might be dRadius.

The following shows the minimal syntax used to declare a variable:

Dim VariableName

That syntax would declare a variable of the variant data type. The variant data type can hold a value of any type; though that might sound convenient, the VBA Editor isn't able to assist in catching issues related to the usage of an incorrect data type. It is good practice to use the As keyword and follow it with a specific type of data. The following shows the syntax used to declare a variable:

Dim VariableName As DataType

The following declares a variable named strName as a string and iRow as an integer:

Dim strName As String Dim iRow As Integer

I discuss the general types of data that VBA supports in the「Exploring Data Types」section.

NOTE

The Dim keyword is used when defining a variable as part of a procedure, but in the General Declaration of a VBA code module you must use the Public, Global, and Private keywords. The General Declaration is located at the very top of a code module before the first procedure definition. The Public and Global keywords allow a variable to be accessed across all code modules in a VBA project, whereas the Private keyword limits the access of a variable to the module where it is defined. I explain these keywords further in the「Controlling the Scope of a Procedure or Variable」section.

Assigning a Value to and Retrieving a Value from a Variable

After a variable has been declared, a value can be assigned to or retrieved from a variable using the = symbol. A value can be assigned to a variable by placing the name of the variable on the left side of the = symbol and placing the value to be assigned on the right. The value could be a static value or a value returned by a procedure.

For example, the following shows how to assign a string value of「Error: Bad string」to a variable named strMsg and the value of 5 to the variable named iRow.

strMsg = "Error: Bad string" iRow = 5

The value of a variable can be retrieved by using it as one of the arguments that a procedure expects. The following demonstrates how to display the value of the strMsg variable in a message box with the MsgBox function:

MsgBox strMsg

The MsgBox function is part of the VBA programming language and is used to display a basic message box with a string and set of predefined buttons and icons. I cover providing feedback to the user in Chapter 28,「Interacting with the User and Controlling the Current View.」You can also learn more about the MsgBox function from the Microsoft VBA Help system. In the VBA Editor, click Help Microsoft Visual Basic For Applications Help.

Declaring Constant Variables

There are special variables known as constants that can only be assigned a value in the editor window and cannot be changed when the VBA program is executed. A constant variable is declared using the Const statement; the Const statement is used instead of the Dim statement. After the data type is assigned to the variable, you then assign the value to the constant variable using the = symbol. I recommend adding a prefix of c_ to the name of a constant variable. Adding the prefix can be a helpful reminder that the value of the variable can't be updated.

The following shows the syntax to declare a constant variable:

Const VariableName As DataType = Value

Here's an example of declaring a constant variable named c_PI of the double data type and then assigning it the value of 3.14159:

Const c_PI as Double = 3.14159

Forcing the Declaration of Variables

The VBA environment supports a statement named Option. The Option statement is used to control several coding practices at the code module level. For example, entering the Option statement with the Explicit keyword in the General Declaration of a module forces you to declare all variables before they can be used. To force the declaration of variables, you type Option Explicit in the General Declaration; the keyword always follows the Option statement. The Option statement also supports the following keywords:

Base—Specifies if the lower limit of an array should be 0 or 1. By default, arrays start at index 0 in VBA. I discuss arrays in the "Storing Data in Arrays" section. Example statement: Option Base 1 Compare—Specifies the default string comparison method used within a code module. Valid values are Binary, Database, or Text. Example statement: Option Compare Text Private—All procedures that are declared with the Public keyword in a code module are available only within the current project and are not accessible when the project is referenced by other projects.

Controlling the Scope of a Procedure or Variable

Procedures and variables can be designated as being global in scope or local to a VBA project, component, or procedure. Global scope in VBA is referred to as public, whereas local scope is referred to as private. By default, a procedure that is defined with the Sub or Function statement is declared as public and is accessible from any module in the VBA project; in the case of a class module, the procedure can be used when an instance of the class is created.

You typically want to limit the procedures that are public because a public procedure can be executed by a user from the AutoCAD user interface with the vbarun or -vbarun command. The Public and Private keywords can be added in front of a Sub or Function statement to control the scope of the variable. Since all procedures have a public scope by default, the use of the Public keyword is optional. However, if you want to make a procedure only accessible from the module in which it is defined, use the Private keyword.

The following shows how to define a public Sub and private Function procedure:

Public Sub HelloWorld() CustomMsg "Hello World!" End Sub Private Function CustomMsg(strMsg As String) _ As VbMsgBoxResult CustomMsg = MsgBox(strMsg) End Function

The CustomMsg function is executed from the Hello subroutine. Because the CustomMsg function is private, it cannot be executed from the AutoCAD user interface with the vbarun or -vbarun command.

All variables declared within a procedure are local to that procedure and can't be accessed from another procedure or component. If you want to define a public variable, the variable must be declared in a module's General Declarations at the very top of a module. When declaring a variable that can be accessed from any module in a project or just all procedures in a module, use the Public or Private keyword, respectively, instead of Dim.

A Dim statement in the General Declarations can be used to declare a public variable, though. The Public or Private keyword can also be placed in front of the Const statement to declare a public or private constant variable, which by default is declared as private and is accessible only from the module in which it is defined. The Public keyword can be used only in a code module, not in a class module or user form, when declaring a constant variable.

NOTE

When you're defining a variable in the General Declaration, I recommend adding a prefix of g_ to help you identify that the variable is in the global scope of a code module or VBA project.

The following example shows how to declare a public variable that can hold the most recent generated error:

Public g_lastErr As ErrObject

The next example shows how to declare a private constant variable that holds a double value of 3.14159:

Private Const c_PI As Double = 3.14159

This last example shows how to declare a private variable that holds a layer object:

Private objLyr As AcadLayer

If you want to make a value accessible to multiple projects or between AutoCAD sessions, you can write values to a custom dictionary or the Windows Registry. I explain how to work with custom dictionaries and use the Windows Registry in Chapter 32,「Storing and Retrieving Custom Data.」

Continuing Long Statements

A code statement is typically a single line in the editor window that can result in relatively long and harder-to-read code statements. The underscore character can be placed anywhere within a code statement to let the VBA environment know a code statement continues to the next line. A space must be placed in front of the underscore character as well—otherwise the VBA editor will display an error message.

The following shows a code statement presented on a single line:

Set objCircle = ThisDrawing.ModelSpace.AddCircle(dCenPt, 2)

The following shows several ways the underscore character can be used to continue the statement to the next line:

Set objCircle = _ ThisDrawing.ModelSpace.AddCircle(dCenPt, 2) Set objCircle = ThisDrawing.ModelSpace. _ AddCircle(dCenPt, 2) Set objCircle = ThisDrawing.ModelSpace.AddCircle(dCenPt, _ 2)

Adding Comments

As a veteran programmer of more than 16 years, I can honestly say that I formed my fair share of bad habits early on. One of the habits that I had to correct was adding very few comments (or not adding any) to my code. Comments are nonexecutable statements that are stored as part of code in a VBA project. The concept of comments is not specific to VBA; it is part of most modern programming languages. The syntax used to indicate a comment does vary from programming language to programing language.

The following are common reasons why and when you might want to add comments to your code:

To document when the program or component was created and who created it.

To maintain a history of changes made to the program—what changes were made, when, and by whom.

To indicate copyright or legal statements related to the code contained in a code module.

To explain how to use a procedure, the values each argument might expect.

To explain what several code statements might be doing; you might remember the task several code statements perform today, but it can become more of a challenge to remember what they are doing months or years later.

To mask a code statement that you currently don't want to execute; during testing or while making changes to a program, you might want to temporarily not execute a code statement but keep the expression for historical purposes.

Comments in VBA are typically denoted with the use of an apostrophe (‘) or the Rem keyword added to the beginning of a code statement. When using the Rem keyword, the keyword must be followed by a space. Although a space isn't required after the use of the apostrophe character, I recommend adding one. Code statements and text to the right of the apostrophe or Rem keyword are not executed; this allows you to add comments on a line by themselves or even on the same line after a code statement.

The following example demonstrates the use of the comments in a code module. The comments are used to explain when the procedure was added and what the procedure does.

' Last updated: 7/13/14 ' Updated by: Lee Ambrosius ' Revision History: ' HYP1 (7/13/14) - Added optional color argument ' Module Description: ' Shared utility code module that contains many ' procedures that are reusable across VBA projects. ' Creates a new layer and returns the AcadLayer object ' that was created. ' Revision(s): HYP1 Function CreateLayer(strLyrName As String, _ Optional nLyrColor As ACAD_COLOR = acGreen) _ As AcadLayer ' Create a variable to hold the new layer Dim objLayer As AcadLayer ' Create the new layer Set objLayer = ThisDrawing.Layers.Add(strLyrName) objLayer.color = nLyrColor ' Assign the color to the new layer 'MsgBox "Layer created." ' Return the new layer Set CreateLayer = objLayer End Function

Understanding the Differences Between VBA 32- and 64-Bit

The VBA programming language is supported on both Windows 32-bit and 64-bit systems, but there are a few differences that you will need to consider. The following outlines a few of these differences:

The LongLong data type is supported on 64-bit systems to allow larger numbers compared to the Long data type. I recommend using the LongPtr data type when possible to allow your program to use either the Long or LongLong data type based on the system it is executing on.

Not all third-party libraries and UserForm controls work on both 32-bit and 64-bit systems. Some third-party libraries and controls are only supported on 32-bit systems, so be sure to test your programs on both 32-bit and 64-bit systems if possible.

Prior to the AutoCAD 2014 release, the AutoCAD COM library had separate procedures that were required when working on a 32-bit or 64-bit system.

Because of potential problems with library and control references, I recommend creating a 32-bit and 64-bit version of your VBA projects. Then when you make changes in one project, export and import the changed code modules and UserForms between projects. The examples and exercises shown in this book are designed to work on 32-bit and 64-bit systems.

Exploring Data Types

Programming languages use data types to help you identify the type of data:

Required by a procedure's argument

Returned by a procedure defined as a function

Table 25.1 lists the basic data types that VBA supports. The Data Type column lists the name of a data type and the Hungarian notation that is commonly added as a prefix to a variable that is declared with that data type. I mentioned the purpose of Hungarian notation earlier in this chapter. The Range column gives a basic understanding of the values a data type supports, and the Description column offers a brief introduction to the data type.

NOTE

The double data type in VBA is referred to as a real or a float in other programming languages.

Table 25.1 VBA data types

Data Type

(Hungarian Notation) Range Description

Byte (by) 0 to 255 Binary data or small integer

Boolean (b) True or False True or False value; used to condition code statements

Date (dt) January 1, 100 to December 31, 9999 Date and time as a double value

Double (d) 1.80 × 10308 to –4.94 × 10–324 for negative numbers and 4.94 × 10–324 to 1.80 × 10308 for positive numbers Large decimal number with an accuracy of up to 16 places

Integer (n) -32,768 to 32,767 Numeric value without a decimal point

Long (l) -2,147,483,648 to 2,147,483,647 Large numeric value without a decimal point

String (c or str) 0 to 65,400 for fixed-length strings, or 0 to approximately 2 billion for variable-length strings One or more characters enclosed in quotation marks

Variant (v) Same as the data type of the value assigned to the variable Value of any data type

Objects and arrays are two other data types that are commonly found in a VBA program. I cover these two data types in the next sections.

You can use the TypeName and VarType functions to identify the type of data returned by a function or assigned to a variable. These two procedures are commonly used to determine how to handle the data assigned to a variable with conditionalized expressions, which I discuss in the「Conditionalizing and Branching Statements」section. The TypeName function returns a string value, and the VarType function returns an integer that represents the data type of a value.

The following shows the syntax of the TypeName and VarType functions:

retVal = TypeName(value) retVal = VarType(value)

The value argument represents any valid procedure that returns a value or variable name. The string or integer value returned by the TypeName or VarType function is represented by the retVal variable. The variable name you use in your programs doesn't need to be named retVal.

NOTE

Each integer value returned by the VarType function has a specific meaning. For example, a value of 2 represents an integer data type, whereas a value of 8 represents a string data type. You can learn about the meaning of each integer value that is returned by looking up the VbVarType constant in the Object Browser of the VBA Editor. I explained how to use the Object Browser in the Chapter 24,「Understanding the AutoCAD VBA Environment.」

Here are examples of the TypeName and VarType functions:

' Displays a message box with the text String MsgBox TypeName("Hello World!") ' Displays a message box with the text Double MsgBox TypeName(1.0) ' Displays a message box with the text Integer MsgBox TypeName(1) ' Displays a message box with the text 8 MsgBox VarType("Hello World!") ' Displays a message box with the text 5 MsgBox VarType(1.0) ' Displays a message box with the text 2 MsgBox VarType(1)

I explain more about the MsgBox procedure and other ways of providing feedback to the user in Chapter 28.

Working with Objects

An object represents an instance of a class from a referenced library, which might be a layer in a drawing or a control on a user form. A class is a template from which an object can be created, and it defines the behavior of an object. A new object can be created with

A procedure, such as Add or AddObject. (The procedure you use depends on the object being created.)

The New keyword when declaring a variable.

The following syntax creates a new object of the specific object data type with the New keyword:

Dim VariableName As New ObjectType

An object can't simply be assigned to a variable with the = symbol like a string or integer value can be. The Set statement must precede the name of the variable when you want to assign an object to a variable. The following shows the syntax of assigning an object to a variable:

Set VariableName = object

The following example shows how to create a new circle object in model space and assign the new circle to a variable named objCircle:

Dim dCenPt(0 To 2) As Double dCenPt(0) = 0: dCenPt(1) = 0: dCenPt(2) = 0 Dim objCircle As AcadCircle Set objCircle = ThisDrawing.ModelSpace.AddCircle(dCenPt, 2)

Once a reference to an object is obtained, you can query and modify the object using its properties and methods. Place a period after a variable name that contains a reference to an object to access one of the object's properties or methods. The following shows the syntax for accessing a property or method of an object:

VariableName.PropertyName VariableName.MethodName

You can assign a new value to a property using the same approach as assigning a value to a variable. The following shows how to assign the string Objects-Light to the Layer property of a circle:

objCircle.Layer = "Objects-Light"

The current value assigned to a property can be retrieved by placing the object and its property name on the right side of the = symbol. The following shows how to retrieve the current value of the Name property of a circle object and assign it to a variable that was declared as a string:

Dim strLayerName as String strLayerName = objCircle.Layer

When you create a new object with the New keyword, you should release the object from memory when it is no longer needed. The VBA environment will automatically free up system resources when it can, but it is best to assign the Nothing keyword to a variable that contains an object before the end of the procedure where the object was created. It is okay to assign Nothing to variables that contain an object reference; the value of the variable will be cleared but might not free up any system memory. The following shows how to free up the memory allocated for the creation of a new AutoCAD Color Model object:

Dim objColor As New AcadAcCmColor Set objColor = Nothing

Using an Object Across Multiple Statements

The With statement can be used to work with a referenced object across multiple statements and can help to reduce the amount of code that needs to be written. The following shows the syntax of the With statement:

With variable statementsN End With

The variable argument represents the object that can be referenced throughout the With statement. You type a period between the With and End With statements to access the object's methods or properties. Here is an example of using the ThisDrawing object with the With statement to set the value of multiple system variables:

With ThisDrawing .SetVariable "BLIPMODE", 0 .SetVariable "OSMODE", 32 .SetVariable "ORTHOMODE", 1 End With

Exploring the AutoCAD Object Model

The AutoCAD Object library is designed to have a hierarchical structure, with the AutoCAD Application object at the top. From the AutoCAD Application object, you can access and open drawing files in the AutoCAD drawing environment. Once you have a reference to a drawing file, you can then access its settings, as well as the graphical and nongraphical objects stored in the drawing.

You can use the Object Browser to explore the classes and their members of the AutoCAD Object library, but it simply provides you with a flat listing of the available classes. The AutoCAD VBA documentation offers an object model map (shown in the following graphic) that allows you to graphically see the relationship between each object in the AutoCAD Object library. Clicking a node on the object model displays the object's topic in the Autodesk AutoCAD: ActiveX Reference Guide.

You can display the AutoCAD Object Model by following these steps:

Open your web browser and navigate to http://help.autodesk.com/view/ACD/2015/ENU/. If you are using AutoCAD 2015, display the AutoCAD product Help system.

On the Autodesk AutoCAD 2015 Help landing page, click the Developer Home Page link.

On the AutoCAD Developer Help home page, use the AutoCAD Object Model link under the ActiveX/VBA section.

If you open the Autodesk AutoCAD: ActiveX Reference Guide, scroll to the top of the Contents list and expand the Object Model node to access the Object Model topic.

Accessing Objects in a Collection

A collection is a container object that holds one or more objects of the same type. For example, the AutoCAD Object library contains collections named Layers and DimStyles. The Layers collection provides access to all the layers in a drawing, whereas DimSyles provides access to the dimension styles stored in a drawing. Since collections are objects, they have properties and methods as well, which are accessed using a period, as I explained in the previous section.

Objects in a collection have a unique index or key value assigned to them. Most collections start with an index of 0, but some start with an index of 1; you will need to refer to the documentation for the collection type to know the index of its first item. The following example shows how to set the first layer in the Layers collection and set it as the current layer:

ThisDrawing.ActiveLayer = ThisDrawing.Layers.Item(0)

The Item method returns the layer object at the index of 0 and the layer is then assigned to the ActiveLayer property. The Item method is the default method of most collections, so the previous code example could be written as follows:

ThisDrawing.ActiveLayer = ThisDrawing.Layers(0)

A key value is a string that is unique to the object in the collection. The Item method can accept a key value in addition to an integer that represents an index, as shown in the following examples:

ThisDrawing.ActiveLayer = ThisDrawing.Layers.Item("Objects-Light") ThisDrawing.ActiveLayer = ThisDrawing.Layers("Objects-Light")

In addition to the Item method, the exclamation point (!) can be used to reference a key value in a collection. When using the ! symbol, a key value that contains spaces must be enclosed in square brackets. The following shows how to access a key value in the Layers collection using the ! symbol:

ThisDrawing.ActiveLayer = ThisDrawing.Layers!CenterLine ThisDrawing.ActiveLayer = ThisDrawing.Layers![Center Line]

The Item method and examples I have shown in this section return a specific object from a collection. If you want to step through all the objects in a collection, you can use the For statement. I introduce the For statement in the「Repeating and Looping Expressions」section. To learn about using collections in the AutoCAD Object library, see the following chapters:

Chapter 26,「Interacting with the Application and Documents Objects,」for working with the Documents collection

Chapter 28,「Interacting with the User and Controlling the Current View,」for working with the Views collection

Chapter 29,「Annotating Objects,」for working with the DimStyles and TextStyles collections

Bonus Chapter 1,「Working with 2D Objects and Object Properties,」for working with the Layers and Linetypes collections in AutoCAD Platform Customization: User Interface, AutoLISP, VBA, and Beyond

Bonus Chapter 2,「Modeling in 3D Space,」for working with the UCSs and Materials collections in AutoCAD Platform Customization: User Interface, AutoLISP, VBA, and Beyond

Storing Data in Arrays

An array is not really a data type but a data structure that can contain multiple values. Unlike the objects in a collection, the elements of an array can be of different data types and do not all need to be of the same data type. The first element in an array typically starts at an index of 0, but you can specify the index of the first element using a range. Arrays are used to represent a coordinate value in a drawing, to specify the objects used to define a closed boundary when creating a Region or Hatch object, or to specify the data types and values that make up the XData attached to an object.

The processes for declaring an array and variable are similar—with one slight difference. When declaring an array, you add opening and closing parentheses after the variable name. The value in the parentheses determines whether you declare a fixed-length or dynamic array.

NOTE

The Option Base 1 statement can be used to change the default index of 0 to 1 for the lower limit of an array. I explained the Option statement earlier in the「Forcing the Declaration of Variables」sidebar.

Declaring a Fixed-Length Array

A fixed-length array, as its name implies, is an array that can hold a specific number of values. When declaring a fixed-length array, you can specify a single- or multidimensional array. You define a single-dimensional array by specifying the number of rows, whereas you typically define a multidimensional array by specifying the number of rows and columns for the array. Rows and columns are based on the first row or column having an index of 0, the second one having an index of 1, and so on. The first row or column in an array is known as the lower limit, and the last row or column is known as the upper limit of the array.

Entering a single integer value within the parentheses when declaring an array specifies the upper limit of the rows in the array. Remember, the first row is 0, so specifying an upper limit of 1 declares an array of two rows. The following shows how to declare a fixed-length array with two rows, a single column, and a starting index of 0:

Dim names(1) As String

As an alternative, you can specify the lower and upper limit of an array. Enter the starting and ending index of the array separated by the To keyword. The following shows how to declare a fixed-length array with three rows, a single column, and a starting index of 1:

Dim centerPt(1 To 3) As Double

An array with a single dimension is the most common, but a multidimensional array can be used to create an in-memory data grid of values. You can specify the upper limit or range of the columns in the array. The following three examples show how to declare a fixed-length array that is four rows by four columns with a starting index of 0:

Dim matrix(3, 3) As Double Dim matrix(0 To 3, 1 To 4) As Double

Declaring a Dynamic Array

A dynamic array is an array that isn't declared with a specific lower or upper limit, so it isn't initialized with any elements. Unlike a fixed-length array, the lower and upper limit of a dynamic array can be changed as needed. Typically, the upper limit of an array is increased to allow additional values to be added to the array. The ReDim statement, short for redimension, is used to decrease or increase the number of elements in an array by changing the lower and upper limits of the array. The following shows how to declare a dynamic array and then redimension the array to five elements:

Dim names() As String ReDim names(4)

When you use the ReDim statement, all values that have been assigned to the array are lost. The current values of the elements remaining from the original array can be retained by using the Preserve keyword. The following shows how to increase an array to seven elements and retain any current values:

ReDim Preserve names(6)

The following shows how to decrease an array to four elements and retain any current values:

ReDim Preserve names(3)

In the previous example, any values in elements 4 through 6 are lost, but all other values would be retained. It is possible to dynamically resize an array by starting with the array's current lower and upper limits. I explain how to get the lower and upper limits of an array in the「Getting the Size of an Array」section.

Working with Array Elements

After an array has been declared and the number of elements established, you can assign a value to and retrieve a value from an element. Working with an element in an array is similar to working with a variable with the exception of needing to specify an element index.

The following shows how to declare a three-element array that represents a coordinate value of 0,5,0:

Dim dCenPt(0 To 2) As Double dCenPt(0) = 0 dCenPt(1) = 5 dCenPt(2) = 0

You retrieve the value of an element by using it as an argument of a procedure or placing it to the right of the = symbol. The following shows how to get the current value of the element in the dCenPt with an index of 0 and display it in a message box with the MsgBox procedure:

MsgBox dCenPt(0)

If you want to step through all the elements in an array, you can use a For statement. I introduce the For statement in the「Repeating and Looping Expressions」section.

Getting the Size of an Array

When you want to resize an array or step through all the elements of an array, you need to know how many elements are in an array. The LBound and UBound procedures are used to return an integer that represents the lower and upper limits of an array, respectively.

The following shows the syntax of the LBound and UBound procedures:

LBound array [, dimension] UBound array [, dimension]

Here are the arguments:

array The array argument represents the variable that contains the array of the lower or upper limit you want to return.

dimension The dimension argument is optional and represents the dimension in a multidimensional array that you want to query. When no argument value is provided, the upper limit of the first dimension is queried. The first dimension in an array has an index of 1 and not 0 like the elements of an array.

The following shows examples of the LBound and UBound procedures:

' Declares a single dimension array Dim dCenPt(0 To 2) As Double ' Displays 0 Debug.Print LBound(dCenPt) ' Displays 2 Debug.Print UBound(dCenPt) ' Declares a multi-dimensional array Dim matrix(0 To 3, 1 To 4) As Double ' Displays 3 which is the upper-limit of the first dimension Debug.Print UBound(matrix, 1) ' Displays 4 which is the upper-limit of the second dimension Debug.Print UBound(matrix, 2)

The output is displayed in the Output window of the VBA Editor with the Print procedure of the Debug object. You'll learn more about using the Debug object in Chapter 36,「Handling Errors and Deploying VBA Projects.」

Calculating Values with Math Functions and Operators

When working with AutoCAD, you must consider the accuracy with which objects are placed and the precision with which objects are created in a drawing. The same is true with using VBA. You must consider both accuracy and precision when creating and modifying objects. The VBA math functions allow you to perform a variety of basic and complex calculations. You can add or multiply two numbers, or even calculate the sine or arctangent of an angle.

Table 25.2 lists many of the math functions and operators that you will use with VBA in this book.

Table 25.2 VBA math functions and operators

Function/Operator Description

+ Returns the sum of two numeric values.

Syntax: retVal = number + number

- Returns the difference between two numeric values.

Syntax: retVal = number - number

* Returns the product of two numeric values.

Syntax: retVal = number * number

/ Returns the quotient after dividing two numeric values. A double value is returned.

Syntax: retVal = number / number

\ Returns the quotient after dividing two numeric values. A double value is returned.

Syntax: retVal = number \ number

Mod Returns the remainder after dividing two numeric values.

Syntax: retVal = number Mod number

Atn Calculates the arctangent of an angular value expressed in radians.

Syntax: retVal = Atn(number)

Cos Returns the cosine of an angular value expressed in radians.

Syntax: retVal = Cos(number)

Exp Returns a numeric value that has been raised to its natural antilogarithm.

Syntax: retVal = Exp(number)

Log Calculates the natural logarithm of a numeric value.

Syntax: retVal = Log(number)

Rnd Generates a random value of the single data type, which is similar to a double data value with less precision.

Syntax: retVal = Rnd([seed])

The optional seed argument is used to generate the same random number.

Sin Returns the sine of an angular value expressed in radians.

Syntax: retVal = Sin(number)

Sqr Gets the square root of a numeric value.

Syntax: retVal = Sqr(number)

Tan Calculates the tangent of an angular value expressed in radians.

Syntax: retVal = Tan(number)

For more information on these functions, see the Microsoft Visual Basic for Applications Help system.

Manipulating Strings

Strings are used for a variety of purposes in VBA, from displaying command prompts and messages to creating annotation objects in a drawing. String values in a VBA program can have a static or fixed value that never changes during execution, or a value that is more dynamic and is changed by the use of string manipulation functions.

Table 25.3 lists many of the string manipulation functions and operators that you will use with VBA in this book.

Table 25.3 VBA string manipulation functions and operators

Function/Operator Description

+ Concatenates two strings together.

Syntax: retVal = string + string

& Concatenates two strings together.

Syntax: retVal = string & string

LCase Converts the characters in a string to all lowercase.

Syntax: retVal = UCase(string)

Left Returns a substring based on a specified number of characters from the left side of a string.

Syntax: retVal = Left(string, length)

Len Returns an integer that represents the number of characters in a string.

Syntax: retVal = Len(string)

LTrim Removes leading spaces from a string.

Syntax: retVal = LTrim(string)

Mid Returns a substring based on a starting position from the left side of a string and going to the right for a specified number of characters.

Syntax: retVal = Mid(string, start,length)

A starting position of 1 indicates the substring should start at the first character of the string.

Right Returns a substring based on a specified number of characters from the right side of a string.

Syntax: retVal = Right(string, length)

RTrim Removes trailing spaces from a string.

Syntax: retVal = RTrim(string)

Space Returns a string containing the specified number of spaces.

Syntax: retVal = Space(number)

Split Returns an array of strings based on the delimited character.

Syntax: retVal = Split(string [, delimiter [, limit [, comparison]]])

StrConv Returns a string based on a specified conversion option.

Syntax: retVal = StrConv(string, mode,localeID)

For a list of supported conversion modes and locale IDs, see the StrConv Function topic in the Microsoft Visual Basic for Applications Help system.

String Returns a string containing a character repeated a specified number of times.

Syntax: retVal = String(number, character)

StrReverse Inverts the characters in a string and returns a new string.

Syntax: retVal = StrReverse(string)

Trim Removes leading and trailing spaces from a string.

Syntax: retVal = Trim(string)

UCase Converts the characters in a string to all uppercase.

Syntax: retVal = UCase(string)

For more information on these functions, see the Microsoft Visual Basic for Applications Help system.

The + and & operators are used to concatenate two strings together into a single string. In addition to concatenating two strings, you can concatenate special constants that represent an ASCII value to a string. For example, you can add a tab or linefeed character. Table 25.4 lists the special constants that the VBA programming language supports.

Table 25.4 Special constants with ASCII values

Constant Description

vbBack Backspace character equal to Chr(8)

vbCr Carriage return character equal to Chr(13)

vbCrLf Carriage return and linefeed characters equal to Chr(13) + Chr(10)

vbLf Linefeed character equal to Chr(10)

vbTab Tab character equal to Chr(9)

The Chr function is used to return the character equivalent of the ASCII code value that is passed to the function. I introduce the Chr function and other data conversion functions in the next section.

The following code statements use the vbLf constant to break a string into two lines before displaying it in a message box with the MsgBox function:

' Displays information about the active linetype MsgBox "Name: " & ThisDrawing.ActiveLinetype.Name & vbLf & _ "Description: " & ThisDrawing.ActiveLinetype.Description

Converting Between Data Types

