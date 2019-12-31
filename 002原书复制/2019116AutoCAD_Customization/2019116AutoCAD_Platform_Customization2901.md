object The object argument represents the AcadModelSpace collection object.

vecList The vecList argument is an array of doubles that defines the vectors of the polyline. For the AddLightWeightPolyline function, the array must contain an even number of elements since each vertex is defined by two elements. Specify an array in three-element increments when using the AddPolyline function since each vertex is defined by three elements.

The following code statements add a new lightweight polyline object to model space (see Figure 27.6):

' Adds a lightweight polyline Dim oLWPoly As AcadLWPolyline Set oLWPoly = ThisDrawing.ModelSpace.AddLightWeightPolyline(dVecList)

Figure 27.6 Polyline with three vertices

Using the AcadLWPolyline or AcadPolyline object returned by the AddLightWeightPolyline or AddPolyline function, you can obtain information about and modify the polyline's properties. In addition to the properties that the AcadLWPolyline or AcadPolyline object share in common with the AcadEntity object, you can use the properties listed in Table 27.8 when working with an AcadLWPolyline or AcadPolyline object.

Table 27.8 Properties related to an AcadLWPolyline or AcadPolyline object

Property Description

Area Returns a double that represents the calculated area of the polyline.

Closed Specifies whether the polyline is open or closed. A value of True closes the polyline if the object contains more than two vertices.

ConstantWidth Specifies the global width for all segments of the polyline.

Coordinate Specifies the coordinate value of a specific vertex in the polyline.

Coordinates Specifies the coordinate values for all vertices of the polyline.

Elevation Specifies the elevation at which the polyline is drawn.

Length Returns a double that represents the length of the polyline.

LinetypeGeneration Specifies whether the linetype pattern assigned to the polyline is generated across the polyline as one continuous pattern, or whether the pattern begins and ends at each vertex. A value of True indicates that the linetype pattern should be generated across the polyline as one continuous pattern.

Normal Specifies the normal vector of the polyline. The normal vector is an array of three doubles that defines the positive Z-axis for the polyline.

Thickness Specifies the thickness assigned to the polyline; the value must be numeric. The default is 0; anything greater than 0 results in the creation of a 3D planar object.

In addition to the properties listed in Table 27.8, an AcadLWPolyline or AcadPolyline object contains methods that are specific to polylines. Table 27.9 lists the methods that are unique to polylines.

TIP

You use the AddVertex or AppendVertex method to add a new vertex to a polyline, but it isn't exactly obvious how you might remove a vertex. To remove a vertex from a polyline, use the Coordinates property to get the vertices of the polyline. Then create a new vertices list of the points you want to keep and assign the new vertices list to the Coordinates property.

Table 27.9 Methods related to an AcadLWPolyline or AcadPolyline object

Method Description

AddVertex Adds a new 2D point at the specified vertex in the LWPolyline (supported by AcadLWPolyline objects only).

AppendVertex Appends a new 3D point to the polyline (supported by AcadPolyline objects only).

Explode Explodes the polyline and returns an array of the objects added to the drawing as a result of exploding the polyline.

GetBulge Gets the bulge–curve–value at the specified vertex. The bulge is a value of the double data type.

GetWidth Gets the width of the segment at the specified vertex. The width is a value of the double data type.

SetBulge Sets the bulge–curve–value at the specified vertex.

SetWidth Sets the width of the segment at the specified vertex.

Defining Parallel Line Segments

Polylines make it easy to create parallel straight and curved segments. Parallel line segments can also be created with an AcadMLine object. Multilines (or mlines) allow you to create multiple parallel line segments and each parallel line can have a different format. The formatting of an mline is inherited from an mline style. You can use mlines to draw the walls of a building and even the foundation in plan view where the outermost lines might represent the footing and the inner lines represent the actual foundation walls. Although mlines have their use, they aren't common in drawings because they can be hard to edit. Mlines are added to a drawing with the AddMLine function. You can learn more about the AddMLine function and AcadMLine object in the AutoCAD Help system.

Getting an Object in the Drawing

Modifying an object after it has been added to a drawing is fairly straightforward; you use the properties and methods of the object that is returned by one of the Add* functions described in the previous sections. If you want to modify an existing object in a drawing, you must locate it in the AcadModelSpace or AcadPaperSpace collection object or a block definition represented by an AcadBlock object. I explain how to work with block definitions in Chapter 30 and with paper space in Chapter 31.

The Item method and a For statement are the most common ways to access an object in the AcadModelSpace collection object. I explained how to use the Item method and For statement in Chapter 25,「Understanding Visual Basic for Applications.」Use the Item method when you want to access a specific object in model space based on its index value; the first object in model space has an index of 0. Here are example code statements that get the handle and object type name of the first object in model space:

Dim oEnt As AcadEntity Set oEnt = ThisDrawing.ModelSpace(0) MsgBox "Handle: " & oEnt.Handle & vbLf & _ "ObjectID: " & CStr(oEnt.ObjectID) & vbLf & _ "Object Name: " & oEnt.ObjectName

The values displayed in the message box by the example code will vary from drawing to drawing. Figure 27.7 shows an example of a message box with the values from a first object in model space; the values reflected are of a point object.

Figure 27.7 Message box containing the handle and object ID of an object

A For statement is the most efficient way to step through all the objects in model space or any other collection object you might need to work with. The following code statements step through model space and return the center point and radius of each circle object:

Dim oEnt As AcadEntity Dim oCircle As AcadCircle ' Displays a general message ThisDrawing.Utility.Prompt vbLf & "Circles in model space" ' Steps through model space For Each oEnt In ThisDrawing.ModelSpace ' Checks to see if the object is a circle If TypeOf oEnt Is AcadCircle Then Set oCircle = oEnt ' outputs the center point and radius of the circle ThisDrawing.Utility.Prompt vbLf & "Center point: " & _ CStr(oCircle.Center(0)) & "," & _ CStr(oCircle.Center(1)) & "," & _ CStr(oCircle.Center(2)) & _ vbLf & "Radius: " & _ CStr(oCircle.Radius) End If Next oEnt ThisDrawing.Utility.Prompt vbLf

Here is an example of the output created by the previous code statements:

Circles in model space Center point: 5,2,0 Radius: 2.5 Center point: 6,2.5,0 Radius: 0.125 Center point: 3,1,0 Radius: 5

NOTE

The Item method and For statement are useful when stepping through all objects in model space or paper space, but they don't allow the user to interactively select an object. I discuss how to prompt a user for objects in Chapter 28.

Modifying Objects

Adding new objects is critical to completing a design, but more time is often spent by a drafter or engineer modifying existing objects than adding new objects. The AutoCAD Object library contains methods that are similar to many of the standard AutoCAD commands used to modify objects. The modifying methods of the AutoCAD Object library can be used to erase, move, scale, mirror, and rotate objects, among other tasks. I explain how to erase, copy, move, and rotate graphical objects in the following sections using the methods that are inherited by the AcadEntity object. I discuss how to scale, mirror, offset, array, and control the visibility of objects in Bonus Chapter 1 on the companion website at .www.sybex.com/go/autocadcustomization.

When a change is made to an object, I recommend that you update the display of that object. The AutoCAD command regen is used to regenerate the display of all objects in the current space, but with the AutoCAD Object library you can update the display of a single graphical object or all objects in a drawing. Use the Update method to update the display of a single graphical object. The Update method doesn't accept any argument values.

If you want to update the display of all objects in a drawing, use the Regen method of the AcadDocument or ThisDrawing object. The Regen method expects a constant value from the AcRegenType enumerator. You use the acActiveViewport constant to regenerate the objects in the current viewport or the acAllViewports constant to regenerate all objects in a drawing.

The following code statements show how to update the display of the first object in model space and all objects in the current viewport:

' Update the first object in model space ThisDrawing.ModelSpace(0).Update ' Update all objects in the current viewport Thisdrawing.Regen acActiveViewport

Deleting Objects

All graphical and most nongraphical objects can be removed from a drawing when they are no longer needed. The only objects that can't be removed are any nongraphical objects that are referenced by a graphical object, such as a text or dimension style, and nongraphical objects that represent symbol tables, such as the Layers and Blocks symbol tables. The Delete method is used to remove—or erase—an object. The method doesn't accept any arguments. If an object can't be removed, an error is generated. I explain how to trap and handle errors in Chapter 36,「Handling Errors and Deploying VBA Projects.」

The following code statement removes the first object in model space:

' Removes the first object in model space ThisDrawing.ModelSpace(0).Delete

Removing All Unreferenced Nongraphical Objects

Although the Delete method can be used to remove a nongraphical object that isn't currently being referenced by a graphical object in a drawing, the PurgeAll method can be used to purge all unreferenced nongraphical objects. The PurgeAll method is a member of the AcadDocument or ThisDrawing object, and it doesn't accept any argument values.

Here's an example of the PurgeAll method:

ThisDrawing.PurgeAll

Copying and Moving Objects

The copy and move commands are used to duplicate and relocate objects in a drawing. When working with the AutoCAD Object library, use the Copy function to duplicate an object. The Copy function doesn't accept any arguments, but it does return a reference to the new duplicate object. The Move method can be used to relocate an object. It expects two arrays of three doubles that define the base and destination points to control the distance and angle at which the object should be moved.

The following code statements draw a circle, duplicate the circle, and then move the duplicated circle 5 units along the X-axis in the positive direction:

' Defines the center point for the circle Dim dCenPt(2) As Double dCenPt(0) = 5: dCenPt(1) = 5: dCenPt(2) = 0 ' Adds a new circle to model space Dim oCirc As AcadCircle Set oCirc = ThisDrawing.ModelSpace.AddCircle(dCenPt, 2) ' Creates a copy of the circle Dim oCircCopy As AcadCircle Set oCircCopy = oCirc.Copy ' Moves the circle 5 units along the X axis Dim dToPt(2) As Double dToPt(0) = oCircCopy.Center(0) + 5 dToPt(1) = oCircCopy.Center(1) dToPt(2) = oCircCopy.Center(2) oCircCopy.Move dCenPt, dToPt

Rotating Objects

The angle and orientation of an object can be changed by rotating the object around a base point or axis. Rotating an object around a base point is performed with the Rotate method, whereas rotating an object around an axis is performed with the Rotate3D method. I discuss the Rotate3D method in Bonus Chapter 2 on the companion website. The base point you pass to the Rotate method must be defined as an array of three doubles. The angle in which the object is rotated must be expressed in radians.

The following code statements draw a line from 5,5 to 7,9 and then create a copy of the line. The new line object that is copied is then rotated 90 degrees to a value of 1.570796325 radians (see Figure 27.8):

' Defines the start and endpoints of the line Dim dStartPt(2) As Double, dEndPt(2) As Double dStartPt(0) = 5: dStartPt(1) = 5: dStartPt(2) = 0 dEndPt(0) = 7: dEndPt(1) = 9: dEndPt(2) = 0 ' Adds a new line to model space Dim oLine As AcadLine Set oLine = ThisDrawing.ModelSpace.AddLine(dStartPt, dEndPt) ' Copies the line Dim oLineCopy As AcadLine Set oLineCopy = oLine.Copy ' Rotates the copied line by 1.570796325 radians oLineCopy.Rotate dStartPt, 1.570796325

Figure 27.8 Rotated line object around a base point

The angular measurement of radians isn't as frequently used as degrees, but all angular values in a drawing are stored as radians; this is why the Rotate method expects radians. Radians are also expected or returned by most methods or properties in the AutoCAD Object library. Listing 27.1 shows two custom functions that can be used to convert degrees to radians and radians to degrees.

Listing 27.1: Converting angular measurements

Const PI As Double = 3.14159265 Private Function Degrees2Radians(dDegrees As Double) Degrees2Radians = dDegrees * PI / 180 End Function Private Function Radians2Degrees(dRadians As Double) Radians2Degrees = dRadians * 180 / PI End Function

Here are a few examples of using the custom functions in Listing 27.1:

Dim dAngle As Double ' Converts 1.570796325 radians to 90 degrees dAngle = Radians2Degrees(PI / 2) ' Converts 180 degrees to 3.14159265 radians dAngle = Degrees2Radians(180)

Changing Object Properties

All graphical objects are derived from the AcadEntity object—that is, all graphical objects inherit the properties and methods of the AcadEntity object. For example, even though the AcadLine object represents a single line segment and the AcadCircle object represents a circle, they share the properties named Layer and Linetype, among many others.

The properties that all graphical objects have in common are known as the general properties of an object. In the AutoCAD user interface, an object's general properties can be modified from the Properties panel on the ribbon or the Properties palette (displayed with the properties command). The general properties shared by all graphical objects were listed in Table 27.2.

The following code statements assign the layer named TitleBlk to the first object in model space and override the color of the layer by directly assigning the color 3 (green) to the object:

' Assigns the TitleBlk layer to the first object in model space ThisDrawing.ModelSpace(0).Layer = "TitleBlk" ' Assigns the ACI color Green to the first object in model space Dim oClr As AcadAcCmColor Set oClr = ThisDrawing.ModelSpace(0).TrueColor oClr.ColorMethod = acColorMethodByACI oClr.ColorIndex = acGreen ThisDrawing.ModelSpace(0).TrueColor = oClr

I explain how to work with and manage layers and linetypes in Bonus Chapter 1 on the companion website. In addition to working with layers and linetypes, I explain how to work with true and color book colors, along with assigning a plot style and transparency to a layer or object.

Exercise: Creating, Querying, and Modifying Objects

In this section, you will create two new projects that create, query, and modify objects. One project will define a macro that allows you to draw a mounting plate with 2D objects, and the second project will use a similar set of logic to create a 3D model of a mounting plate. Along with the two projects, you will create a utility class that contains common functions that can be used across both projects and even in other projects later in this book.

The key concepts I cover in this exercise are as follows:

Creating and Modifying Graphical Objects Graphical objects are the backbone of any design; they are used to communicate what the building or product should look like when built or manufactured. When you want to add or modify graphical objects, you must decide whether to work with model space or paper space, or even a custom block definition.

Working with Layers All graphical objects are placed on a layer. Layers are used to organize graphical objects and control many of the general properties that all graphical objects have in common.

Creating and Using a Custom Class The VBA programming language supports the ability to create a custom class. Custom classes can be used to organize functions and manage global variables. A custom class when created in a project can be exported and used across many projects.

NOTE

The steps in this exercise don't rely on the completion of an earlier exercise in this book. Later exercises in this book will rely on the completion of this exercise, though. If you don't complete this exercise, you can obtain the completed files from www.sybex.com/go/autocadcustomization.

Creating the DrawPlate Project

The following steps explain how to create a project named DrawPlate and to save it to a file named drawplate.dvb:

On the ribbon, click Manage tab Applications panel title bar and then click VBA Manager (or at the Command prompt, type vbaman and press Enter).

When the VBA Manager opens, click New. The new project is added to the list with a default name of ACADProject and a location of Global1, Global2, and so on based on how many projects have been created in the current AutoCAD session.

Select the new project from the Projects list and click Save As.

When the Save As dialog box opens, browse to the MyCustomFiles folder within the Documents (or My Documents) folder, or the location you are using to store custom program files.

In the File Name text box, type drawplate and click Save.

In the VBA Manager dialog box, click Visual Basic Editor.

The next steps explain how to change the project name from ACADProject to DrawPlate:

When the VBA Editor opens, select the project node labeled ACADProject from the Project Explorer.

In the Properties window, select the field named (Name) and double-click in the text box adjacent to the field.

In the text box, type DrawPlate and press Enter.

On the menu bar, click File Save.

Creating the Utilities Class

Separating the custom functions you create into logical groupings can make debugging code statements easier and allow you to reuse code in other products. Custom classes are one way of sharing functions and protecting global variables from the functions of your main project. One of the benefits of using a custom class over just a code module is that you gain the advantage of type-ahead in the Visual Basic Editor, which reduces the amount of text you need to type.

In these steps, you add a new custom class module named clsUtilities to the DrawPlate project:

On the menu bar, click Insert Class Module.

In the Project Explorer, select the new module named Class1.

In the Properties window, change the current value of the (Name) property to clsUtilities.

On the menu bar, click File Save.

The clsUtilities class module will contain functions that define common and reusable functions for use with the main function of the DrawPlate project along with other projects later in this book. The following steps add two functions to the clsUtilities class that are used to work with system variables.

Working with one system variable at a time isn't always efficient when you need to set or restore the values of multiple system variables. You will define two functions named GetSysvars and SetSysvars. The GetSysvars function will return an array of the current values for multiple system variables, and the SetSysvars function will be used to set the values of multiple system variables.

The following steps explain how to add the GetSysvars and SetSysvars functions:

In the Project Explorer, double-click the clsUtilities component.

In the text editor area of the clsUtilities component, type the following. (The comments are here for your information and don't need to be typed.)' GetSysvars function returns an array of the current values ' for each system variable in the array it is passed. Public Function GetSysvars(sysvarNames) As Variant Dim nIdxTotal As Integer nIdxTotal = UBound(sysvarNames) Dim aVals() As Variant ReDim aVals(UBound(sysvarNames) - LBound(sysvarNames)) Dim nCnt As Integer For nCnt = LBound(sysvarNames) To UBound(sysvarNames) aVals(nCnt) = ThisDrawing.GetVariable(sysvarNames(nCnt)) Next GetSysvars = aVals End Function ' SetSysvars function sets the values of the system variables ' in the array that the function is passed. ' Function expects two arrays. Public Sub SetSysvars(sysvarNames, sysvarValues) Dim nCnt As Integer For nCnt = LBound(sysvarNames) To UBound(sysvarNames) ThisDrawing.SetVariable sysvarNames(nCnt), sysvarValues(nCnt) Next End Sub

Click File Save.

New graphical objects must be added to model space, paper space, or a block definition. In most situations, you want to add new objects to the current layout. You can create custom functions to combine multiple code statements and reduce the amount of code that needs to be otherwise entered. The following steps add three functions to the clsUtilities class that can be used to create a closed polyline and circle in the current layout, and a new layer.

In the text editor area of the clsUtilities component, type the following. (The comments are here for your information and don't need to be typed.)' CreateRectangle function draws a closed LWPolyline object. ' Function expects an array that represents four points, ' but can accept more points. Public Function CreateRectangle(ptList As Variant) As AcadLWPolyline Set CreateRectangle = ThisDrawing.ActiveLayout.Block. _ AddLightWeightPolyline(ptList) CreateRectangle.Closed = True End Function ' CreateCircle function draws a Circle object. ' Function expects a center point and radius. Public Function CreateCircle(cenPt As Variant, circRadius) As AcadCircle Set CreateCircle = ThisDrawing.ActiveLayout.Block. _ AddCircle(cenPt, circRadius) End Function ' CreateLayer function creates a layer and returns an AcadLayer object. ' Function expects a layer name and color. Public Function CreateLayer(sName As String, _ nClr As ACAD_COLOR) As AcadLayer On Error Resume Next ' Try to get the layer first and return it if it exists Set CreateLayer = ThisDrawing.Layers(sName) ' If layer doesn't exist create it If Err Then Err.Clear Set CreateLayer = ThisDrawing.Layers.Add(sName) CreateLayer.color = nClr End If End Function

Click File Save.

Defining the CLI_DrawPlate Function

The main function of the DrawPlate project draws a rectangular mounting plate with four bolt holes. The outside edge of the mounting plate is defined using a closed lightweight polyline that is drawn using the CreateRectangle function defined in the clsUtilities class. Each of the bolt holes is drawn using the CreateCircle function of the clsUtilities class. Since objects in a drawing are organized using layers, you will place the rectangle and circles on different layers; the layers will be added to the drawing with the CreateLayer function.

In these steps, you add a new custom module named basDrawPlate to the DrawPlate project:

On the menu bar, click Insert Module.

In the Project Explorer, select the new module named Module1.

In the Properties window, change the current value of the (Name) property to basDrawPlate.

On the menu bar, click File Save.

The following steps explain how to add the CLI_DrawPlate function, which is the macro users will use to create the mounting plate:

In the Project Explorer, double-click the basDrawPlate component.

In the text editor area of the basDrawPlate component, type the following: Private myUtilities As New clsUtilities

The clsUtilities.cls file code statement defines a global variable named myUtilities. The myUtilities variable is then assigned a new instance of the clsUtilities class that you defined earlier. When you want to reference a function defined in the clsUtilities class, you will use the myUtilities variable.

In the text editor area of the basDrawPlate component, press Enter and type the following. (The comments are here for your information and don't need to be typed.)Public Sub CLI_DrawPlate() Dim oLyr As AcadLayer On Error Resume Next ' Store the current value of the system variables to be restored later Dim sysvarNames As Variant, sysvarVals As Variant sysvarNames = Array("nomutt", "clayer", "textstyle") sysvarVals = myUtilities.GetSysvars(sysvarNames) ' Set the current value of system variables myUtilities.SetSysvars sysvarNames, Array(0, "0", "STANDARD") ' Define the width and height for the plate Dim dWidth As Double, dHeight As Double dWidth = 5# dHeight = 2.75 Dim basePt(2) As Double basePt(0) = 0: basePt(1) = 0: basePt(2) = 0 ' Create the layer named Plate or set it current Set oLyr = myUtilities.CreateLayer("Plate", acBlue) ThisDrawing.ActiveLayer = oLyr ' Create the array that will hold the point list ' used to draw the outline of the plate Dim dPtList(7) As Double dPtList(0) = basePt(0): dPtList(1) = basePt(1) dPtList(2) = basePt(0) + dWidth: dPtList(3) = basePt(1) dPtList(4) = basePt(0) + dWidth: dPtList(5) = basePt(1) + dHeight dPtList(6) = basePt(0): dPtList(7) = basePt(1) + dHeight ' Draw the rectangle myUtilities.CreateRectangle dPtList ' Create the layer named Holes or set it current Set oLyr = myUtilities.CreateLayer("Holes", acRed) ThisDrawing.ActiveLayer = oLyr ' Define the center points of the circles Dim cenPt1(2) As Double, cenPt2(2) As Double Dim cenPt3(2) As Double, cenPt4(2) As Double cenPt1(0) = 0.5: cenPt1(1) = 0.5: cenPt1(2) = 0 cenPt2(0) = 4.5: cenPt2(1) = 0.5: cenPt2(2) = 0 cenPt3(0) = 0.5: cenPt3(1) = 2.25: cenPt3(2) = 0 cenPt4(0) = 4.5: cenPt4(1) = 2.25: cenPt4(2) = 0 ' Draw the four circles myUtilities.CreateCircle cenPt1, 0.1875 myUtilities.CreateCircle cenPt2, 0.1875 myUtilities.CreateCircle cenPt3, 0.1875 myUtilities.CreateCircle cenPt4, 0.1875 ' Restore the saved system variable values myUtilities.SetSysvars sysvarNames, sysvarVals End Sub

Click File Save.

Running the CLI_DrawPlate Function

Now that the CLI_DrawPlate function has been defined with the necessary code statements to draw the mounting plate, it can be executed from the AutoCAD user interface. In these steps, you run the CLI_DrawPlate function from the Macros dialog box.

Switch to AutoCAD by clicking on its icon in the Windows taskbar or by clicking View AutoCAD from the menu bar in the Visual Basic Editor.

In AutoCAD, at the Command prompt, type vbarun and press Enter.

When the Macros dialog box opens, select the DrawPlate.dvb!basDrawPlate.CLI_DrawPlate macro from the list and click Run. The new mounting plate is drawn, as shown in Figure 27.9. The mounting plate measures 5×2.75, which was defined in the CLI_DrawPlate function. In Chapter 28, you will learn to accept user input to control the size of the mounting plate that should be drawn.

If you don't see the mounting plate, use the zoom command and zoom to the extents of the drawing area.

Figure 27.9 New mounting plate

Exporting the Utilities Class

The functions in the clsUtilities class can be used in other projects. By exporting the class module out of the DrawPlate project, you can then import it into other projects. Class modules aren't the only components that can be exported from a project; you can export code modules and User Forms that define dialog boxes in a project as well.

The following steps explain how to export the clsUtilities class module from the drawplate.dvb file:

In the VBA Editor, in the Project Explorer, right-click the clsUtilities component and choose Export File.

When the Export File dialog box opens, browse to the MyCustomFiles folder.

Keep the default filename of clsUtilities.cls and click Save. The clsUtilities.cls file is exported from the DrawPlate project.

Chapter 28

Interacting with the User and Controlling the Current View

Static values in a custom program are helpful in executing a set of code statements consistently each time the program is run. However, using static values only prevents the user from providing input during execution. Your users might need to specify the location of the corner of a mounting plate, an insertion point for a block reference, or which objects to modify. The AutoCAD® Object library provides a variety of functions that allow you to request input at the Command prompt or with controls in a user form. I cover working with user forms in Chapter 34,「Creating and Displaying User Forms.」

Some values obtained from a user can be directly assigned to an object without any changes, whereas other values might need to be manipulated first. The AutoCAD Object library contains functions that can be used to manipulate coordinate and angular values. I discussed converting values from one data type to another in Chapter 25,「Understanding Visual Basic for Applications.」

Getting input from a user will be helpful in creating dynamic and flexible programs, but so will the manipulation of the current view. The programs you write can pan and change the zoom factor or area that is visible in the drawing window. In addition to panning and zooming, you can work with named views, tiled viewports, and visual styles. In this chapter, I explain how to request input from the user at the Command prompt, calculate geometric values, and manipulate the current view in model space.

Interacting with the User

There are times when you will want users to provide a value instead of simply deciding which values a program should use each time it is executed. The AutoCAD Object library contains functions that can be used to request input from the user. The values returned by the user can then be validated using test conditions before the values are passed as arguments to a function. I explained how to use test conditions with comparison and logical grouping operators in Chapter 25.

In addition to getting input from the user, a custom program can provide textual feedback to the user, letting the user know the current state of a program or when an error occurs. Textual feedback can be provided at the Command prompt or in a message box. Whether getting input from the user or providing textual messages at the Command prompt, you will need to work with the AcadUtility object. The AcadUtility object can be accessed from the Utility property of an AcadDocument or ThisDrawing object.

The following code statements get the AcadUtility object of the ThisDrawing object:

Dim oUtil as AcadUtility Set oUtil = ThisDrawing.Utility

Requesting Input at the Command Prompt

With the functions of the AcadUtility object, you can request input from the user at the Command prompt. Input requested can be any of the following:

Integer or double (real) numeric value

Distance or angular value

String or keyword

2D or 3D point

Before requesting input from the user, you will want to define a prompt. A prompt is a short text message that provides the user with an idea of the input expected and whether any options are available. I discuss recommended etiquette for creating a prompt in the sidebar「Guidelines for Prompts.」

TIP

Use the On Error Resume Next statement before using the Getxxx functions mentioned in this section. An error is generated by most of the functions if the user presses Enter without providing a value or presses Esc. After a Getxxx function, be sure to check the value of the Err object. I explain more about error handling in Chapter 36,「Handling Errors and Deploying VBA Projects.」

Getting Numeric Values

Numbers play an important role in creating and modifying objects in a drawing, whether it is the radius of a circle, part of a coordinate value, or the number of rows in a rectangular array. VBA supports two types of numbers: integers and doubles (or reals). Integers are whole numbers without a decimal value, and doubles are numbers that support a decimal value. You can use the GetInteger and GetReal functions to request a numeric value from the Command prompt. The number entered by the user is the value returned by the function, but if the user presses the spacebar or Enter without providing a value, an error is generated. When an incorrect value is provided, the function re-prompts the user to try again.

The following shows the syntax of the GetInteger and GetReal functions:

retVal = object.GetInteger([msg]) retVal = object.GetReal([msg])

Their arguments are as follows:

retVal The retVal argument represents the integer or double value returned.

object The object argument represents the AcadUtility object.

msg The msg argument is an optional string that defines the prompt message to display at the Command prompt. The msg argument is optional, but I recommend always providing one.

The following are examples of the GetInteger and GetReal functions, and the values that are returned:

nRetVal = oUtil.GetInteger(vblf & "Enter number of line segments: ") oUtil.Prompt vbLf & "Value=" & CStr(nRetVal) & vbLf Enter number of line segments: Type 3.5 and press Enter Requires an integer value. Enter number of line segments: Type 3 and press Enter 3 dRetVal = oUtil.GetReal(vblf & "Enter angle of rotation: ") oUtil.Prompt vbLf & "Value=" & CStr(dRetVal) & vbLf Enter number of line segments: Type 22.5 and press Enter 22.5

NOTE

When the user is prompted for a double value with the GetReal function and enters a whole number, a double value is returned. For example, entering 1 results in 1.0 being returned.

Acquiring a Point Value

The GetPoint function allows the user to specify a point in the drawing area based on an optional base point. When an optional base point is provided, a rubber-band line is drawn from the base point to the current position of the cursor. Figure 28.1 shows the rubber-band line effect used when getting a point based on the optional base point. A variant containing an array of three doubles, representing a point, is returned by the GetPoint function if the user successfully specifies a point in the drawing area. If the user presses the spacebar or Enter without specifying a point, an error is generated.

Figure 28.1 Rubber-band line effect used when specifying a point from a base point

In addition to the GetPoint function, the GetCorner function can be used to request a point. There are differences between the GetPoint and GetCorner functions:

The GetCorner function requires a base point.

The GetPoint function draws a rubber-band line from a base point to the cursor, whereas the GetCorner function draws a rectangle from the base point to the cursor, as shown in Figure 28.2.

Figure 28.2 The rubber-band effect used when specifying the opposite corner with the GetCorner function

The following shows the syntax of the GetPoint and GetCorner functions:

retVal = object.GetPoint([basePoint], [msg]) retVal = object.GetCorner(basePoint, [msg])

Their arguments are as follows:

retVal The retVal argument represents the variant value returned by the function. This variant is an array of three doubles representing the point specified.

object The object argument represents the AcadUtility object.

basePoint The basePoint argument specifies the base point from which a rubber-band line or rectangle is drawn to the current position of the cursor. This argument value must be an array of three doubles and is optional for the GetPoint function.

msg The msg argument is an optional string that defines the prompt message to display at the Command prompt. The msg argument is optional, but I recommend always providing one.

The following are examples of the GetPoint and GetCorner functions:

Dim vPt As Variant vPt = oUtil.GetPoint(, vbLf & "Specify first corner: ") oUtil.Prompt vbLf & "X=" & CStr(vPt(0)) & _ " Y=" & CStr(vPt(1)) & _ " Z=" & CStr(vPt(2)) & vbLf Dim vCornerPt As Variant vCornerPt = oUtil.GetCorner(vPt, vbLf & "Specify opposite corner: ") oUtil.Prompt vbLf & "X=" & CStr(vCornerPt(0)) & _ " Y=" & CStr(vCornerPt(1)) & _ " Z=" & CStr(vCornerPt(2)) & vbLf

Here is an example of values entered at the prompts displayed for the previous example code statements and the values returned:

Specify first corner: 0,0 X=0 Y=0 Z=0 Specify opposite corner: @5,5 X=5 Y=5 Z=0

Getting the Distance Between Points

Although the GetReal function can be used to request a value that might represent a distance or angular value, the AutoCAD Object library contains several functions that are better suited for acquiring distance or angular values. (I explain how to get angular values in the next section.) The GetDistance function can be used to get a distance between two points. The distance between the two points is returned as a double value. Optionally, the user can type a double value instead of specifying two points. If the user presses the spacebar or Enter without providing a value, an error is generated.

The following shows the syntax of the GetDistance function:

retVal = object.GetDistance([basePoint], [msg])

Its arguments are as follows:

retVal The retVal argument represents the double that is the result of the function calculating the distance between the two points specified.

object The object argument represents the AcadUtility object.

basePoint The basePoint argument is an optional argument that determines if a rubber-band line is drawn from the current position of the cursor to the coordinate value specified by the basePoint argument. This argument value must be an array of three doubles. If a base point isn't provided, the user must specify two points instead of one.

msg The msg argument is an optional string that defines the prompt message to display at the Command prompt. The msg argument is optional, but I recommend always providing one.

The following are examples of the GetDistance function and the values that are returned:

Dim dRetVal as Double dRetVal = oUtil.GetDistance(, vblf & "Enter or specify a width: ") oUtil.Prompt vbLf & "Distance=" & CStr(dRetVal) & vbLf Enter or specify a width: Pick a point in the drawing area, enter a coordinate value, or enter a distance Specify second point: If a point was specified, pick or enter a second point Distance=6.25 Dim vPt As Variant, dRetVal As Double vPt = oUtil.GetPoint(, vbLf & "Specify first point: ") dRetVal = oUtil.GetDistance(vPt, vbLf & "Specify second point: ") oUtil.Prompt vbLf & "Distance=" & CStr(dRetVal) & vbLf Specify first point: Pick a point in the drawing area Specify second point: Pick a point in the drawing area Distance=7.0

TIP

The lunits system variable affects the formatting of the linear distance that can be entered when the GetDistance function is executed. For example, when lunits is set to 2, the user can enter only decimal values and not values formatted in inches and feet. If lunits is set to 4, the user can enter either decimal or architectural formats for linear distances.

A double value can be converted to a string that reflects the formatting of a supported linear distance with the RealToString function. The RealToString function accepts a double value of the distance to format as a string, a constant value from the AcUnits enumerator to specify the linear format to apply, and an integer that indicates the precision in which the double should be formatted.

It is also possible to convert a string that is formatted as a supported linear distance to a double value with the DistanceToReal function. The DistanceToReal function accepts a string value and a constant value from the AcUnits enumerator that indicates the linear formatting of the string. For more information about the RealToString and DistanceToReal functions, see the AutoCAD Help system.

Getting the Angular Difference Between Points

The GetAngle and GetOrientation functions are used to obtain the angular difference between a vector defined by two points and the positive X-axis. The angular difference is expressed in radians, not decimal degrees or other angular measurement, and is returned as a double. If the user presses the spacebar or Enter without providing a value, an error is generated. The angular value returned by both functions is affected by the current value of the angdir system variable, which defines the direction in which positive angles are measured: counterclockwise or clockwise.

The GetOrientation function is also affected by the angbase system variables. The angular value returned by GetOrientation is calculated by adding the value specified by the user and that of the angbase system variable. For example, changing angbase to 45 and entering a value of 0 for the GetOrientation function returns a value of 0.785398, which is the current value of angbase. 0.785398 is the radians equivalent of 45 decimal degrees.

The following shows the syntax of the GetAngle and GetOrientation functions:

retVal = object.GetAngle([basePoint], [msg]) retVal = object.GetOrientation([basePoint], [msg])

The arguments of the two functions are the same as those of the GetDistance function explained in the previous section. The following are examples of the GetAngle function, and the values that are returned:

Dim dRetVal as Double dRetVal = oUtil.GetAngle(, vblf & "Enter or specify an angle: ") oUtil.Prompt vbLf & "Angle=" & CStr(dRetVal) & vbLf Enter or specify an angle: Pick a point in the drawing area, enter a coordinate value, or enter an angle Specify second point: If a point was specified, pick or enter a second point Angle= 0.785398 Dim vPt As Variant, dRetVal As Double vPt = oUtil.GetPoint(, vbLf & "Specify first point: ") dRetVal = oUtil.GetAngle(vPt, vbLf & "Specify second point: ") oUtil.Prompt vbLf & "Angle=" & CStr(dRetVal) & vbLf Specify first point: Pick a point in the drawing area Specify second point: Pick a point in the drawing area Angle=3.14159

Although AutoCAD uses and stores values in radians, users often think in decimal degrees. Listing 28.1 is a set of custom functions that can be used to convert radians to decimal degrees and decimal degrees to radians.

Listing 28.1: Decimal degrees to radians and radians to decimal degrees

Const PI = 3.14159265358979 ' Convert Radians to Decimal Degrees ' Usage: dRetval = rtd(0.785398) Private Function rtd(dRadius As Double) As Double rtd = (dRadius / PI) * 180 End Function ' Convert Decimal Degrees to Radians ' Usage: dRetval = dtr(45.0) Private Function dtr(dDegrees As Double) As Double dtr = (PI / 180) * dDegrees End Function

A double that represents an angular value can be converted to a string that reflects the formatting of a supported angular measurement with the AngleToString function. The AngleToString function accepts a double value of the angle to format as a string, a constant value from the AcAngleUnits enumerator to specify the angular format to apply, and an integer that sets the precision in which the string should be formatted.

You can also convert a string that is formatted with a supported angular measurement to a double value with the AngleToReal function. The AngleToReal function accepts a string value and a constant value from the AcAngleUnits enumerator to specify the angular formatting of the string. For more information about the AngleToString and AngleToReal functions, see the AutoCAD Help system.

Guidelines for Prompts

Prompts explain the type of data that is being requested along with how that data might be used. Most of the commands you start in the AutoCAD program that don't open a dialog box will display a prompt that follows a common structure. I recommend structuring your prompts like the ones displayed by AutoCAD commands to make your prompts feel familiar to the user. Prompts commonly have two or more of the following elements:

Message The message is typically formatted as a statement that begins with a verb, such as specify or enter. I recommend using Specify when the user can pick one or more points in the drawing area to define a value or enter a value, and using Enter when the user can only type a value at the Command prompt. Messages can also be formatted as questions, but this is much less common. I recommend avoiding a conversational tone, which might use words such as please and thanks, in the message. Special character constants can also be used as part of a message; vbLf forces the text that follows it onto a new line, and vbTab and """ represent the Tab and quotation mark characters, respectively. The vbBack constant can be useful in removing the Command: text from the Command prompt; use 9 vbBack constants in a row to remove Command:. The exercise at the end of this chapter demonstrates how to create a constant and remove Command: from the Command prompt. For a full list of supported constants that can be used in strings, search on the「Miscellaneous Constants」topic in the Microsoft VBA Help system. In the VBA Editor, click Help Microsoft Visual Basic For Applications Help.

Option List The option list identifies which keywords are available in addition to the main data type of the Getxxx function. An opening ([) and a closing (]) square bracket denote the start and end of the option list. Each keyword in the option list should be separated by a forward slash (/), and the capitalization should match that of the keywords listing in the InitializeUserInput method that is evaluated just prior to the next Getxxx function. The option list should come after the main message of the prompt. I discuss the InitializeUserInput method in the「Initializing User Input and Keywords」section later in this chapter.

Default Value The default value that should be used if the user doesn't provide a value before pressing Enter is commonly displayed in a set of angle brackets (<>). The Getxxx function doesn't automatically return the value in the angle brackets if Enter is pressed before a value is provided. You must check for an error and return the desired default value. I demonstrate how to implement a prompt with a default value in the exercise at the end of this chapter.

Colon A colon should be the last character in a prompt, followed by a space to provide some separation between the prompt and value entered.

The following is the recommended structure of a prompt:

Message [Option list] <Default value>:

The following are examples of different prompts that follow my recommendations:

"Specify next point: " "Specify rotation or [Reference] <45.000>: " "Enter a number or press Backspace to clear: " "Enter color option [Blue/Green/Red] <Blue>: "

The following are examples of prompts that shouldn't be used:

"Next point: " "Pick a color (blue green black):" "Specify next point" "Enter color option or <Blue> [Blue/Green/Red]: "

Prompting for String Values

String values are used to represent the prompts that should be displayed when requesting input, a block name, or path, and even the text to be added to an annotation object. You can use the GetString function to request a string value at the Command prompt and control whether spaces are allowed in the string returned. The entered string is returned by the function, but if the user presses Enter without providing a value, an empty string ("") is returned.

The following shows the syntax of the GetString function:

retVal = object.GetString(allow_spaces, [msg])

Its arguments are as follows:

retVal The retVal argument represents the string that is returned by the function.

object The object argument represents the AcadUtility object.

allow_spaces The allow_spaces argument determines whether the spacebar acts like the Enter key or if it allows the entering of a space character. By default, pressing the spacebar is the same as pressing Enter. Provide a value of True to allow the user to enter a space character, or use False to not allow spaces in the text entered. A conditional expression that evaluates to True or False can also be used.

msg The msg argument is an optional string that defines the prompt message to display at the Command prompt. The msg argument is optional, but I recommend always providing one.

The following is an example of the GetString function and the value that is returned:

Dim sRetVal As String sRetVal = oUtil.GetString(True, vbLf & "Enter your name: ") oUtil.Prompt vbLf & "Value=" & sRetVal & vbLf Type your first and last (or family) name, then press Enter "Lee Ambrosius"

Initializing User Input and Keywords

The behavior of the Getxxx functions can be modified with the InitializeUserInput method of the AcadUtility object. When you want to enable one or more of the alternate behaviors of a Getxxx function, you include the InitializeUserInput method before the Getxxx function. In addition to controlling the alternate behaviors of the Getxxx functions, InitializeUserInput can be used to set up keyword usage for a function.

The following shows the syntax of the InitializeUserInput method:

object.InitializeUserInput(flags, [keywords_list])

The flags argument represents a bit-coded value that controls the type of input a Getxxx function can accept. The flags argument can contain one or more of the bits described in Table 28.1. Additional bits are available and described in the AutoCAD Help system; search on the keywords「InitializeUserInput method.」

Table 28.1 Bit codes available for the InitializeUserInput method

Bit code Description

1 User is not allowed to press Enter without first providing a value. Not supported for use with the GetString function.

2 Zero can't be entered when requesting a numeric value.

4 A negative value can't be entered when requesting a numeric value.

32 Rubber-band lines and rectangular boxes are shown as dashed instead of the default setting as solid.

64 Coordinate input is restricted to 2D points.

128 Arbitrary input is allowed; text values can be entered when using any of the Getxxx functions.

The keywords_list argument represents the keywords that the next Getxxx function can support. The keywords must be placed in a string and each keyword separated by a space. The letters you want a user to be able to enter without typing the full keyword must be in uppercase, and I recommend that they be consecutive; all other letters in a keyword must be lowercase. The keywords_list argument is optional. Examples of keyword lists are "Blue Green Red" and "Azul Verde Rojo_Blue Green Red". The second example represents a keyword list that supports both localized and global languages; here the localized language is Spanish and the global language is typically English.

The global language value is used when an underscore is placed in front of a letter combination at the Command prompt. For example, typing A for the Azul option when the Spanish-language version of your program is loaded would work just fine but would fail if the English version was loaded. Entering _B instead would work with either the Spanish or English version of the program.

When a user enters a value that represents a keyword, an error is generated. Use the On Error Resume Next statement to keep the VBA environment from displaying an error message. After the Getxxx function is executed, check the value of the Err object to determine if the user entered a keyword, pressed Enter without providing a value, or pressed Esc. If a keyword is entered, the name of the keyword can be obtained with the GetInput function. The GetInput function doesn't accept any arguments and returns a string that represents the keyword the user choose.

The following is an example of the InitializeUserInput method that forces the user to provide a numeric value or enter a keyword option of Diameter with the GetDistance function. The If statement is used to determine if an error occurred and, if so, which error. Was the error caused by entering the keyword or by pressing Esc? The GetInput function is used to return the keyword value.

On Error Resume Next ' Disables pressing Enter without first ' entering a number or Diameter keyword oUtil.InitializeUserInput 1, "Diameter" Dim vRetVal As Variant vRetVal = oUtil.GetDistance(, vbLf & "Specify radius or [Diameter]: ") ' Check to see if the user entered a value or option If Err.Number = -2145320928 Then oUtil.Prompt vbLf & "Option=" & oUtil.GetInput & vbLf ElseIf Err.Number = -2147352567 Then oUtil.Prompt vbLf & "User pressed Esc" & vbLf Else oUtil.Prompt vbLf & "Distance=" & CStr(vRetVal) & vbLf End If

Here are examples of values entered at the prompt displayed for the previous example code statement and the values returned:

Specify radius or [Diameter]: Type D and press Enter Option=Diameter Specify radius or [Diameter]: Type 7.5 and press Enter Distance=7.5

The following is an example of the InitializeUserInput method that restricts the user's input to positive and nonzero values:

On Error Resume Next ' Disables pressing Enter without first entering a number, ' and limits input to positive and nonzero values oUtil.InitializeUserInput 7 Dim vRetVal As Variant vRetVal = oUtil.GetInteger(vbLf & "Enter a number: ") ' Check to see if the user entered a value If Not Err Then oUtil.Prompt vbLf & "Value=" & CStr(vRetVal) & vbLf End If

Here are examples of values entered at the prompt displayed for the previous example code statement, and the values returned:

Enter a number: Type -1 and press Enter Value must be positive and nonzero. Enter a number: Type 4 and press Enter 4

In addition to using keywords with the Getxxx functions, you can use the GetKeyword function to prompt the user for just keyword values. The GetKeyword function accepts input only in the form of a keyword value unless arbitrary input is enabled with the 128 bit-code of the InitializeUserInput method; in that case, the function can accept any string input. The GetKeyword function can return only a string value—it can't return numbers or arrays representing coordinate values. The InitializeUserInput method must be used to set up the keywords that the GetKeyword function can accept.

NOTE

All Getxxx functions except the GetString function support keywords.

The following shows the syntax of the GetKeyword function:

retVal = object.GetKeyword([msg])

The msg argument represents the textual message to display at the Command prompt. The msg argument is optional, but I recommend always providing one.

The following is an example of the GetKeyword function and the value that is returned:

On Error Resume Next ' Sets up the keywords for the GetKeyword function oUtil.InitializeUserInput 0, "Color LTYpe LWeight LTScale" Dim vRetVal As Variant vRetVal = oUtil.GetKeyword( _ vbLf & "Enter option [Color/LTYpe/LWeight/LTScale] <Color>: ") ' Check to see if the user specified an option If Err.Number = -2145320928 Then oUtil.Prompt vbLf & "Option=" & oUtil.GetInput & vbLf ElseIf Err.Number = -2147352567 Then oUtil.Prompt vbLf & "User pressed Esc" & vbLf Else If vRetVal = "" Then oUtil.Prompt vbLf & "Enter pressed w/o an option" & vbLf Else oUtil.Prompt vbLf & "Value=" & vRetVal & vbLf End If End If

Here are examples of values entered at the prompt displayed for the previous example code statement, and the values returned:

Enter option [Color/LTYpe/LWeight/LTScale] <Color>: Type C and press Enter Option=Color Enter option [Color/LTYpe/LWeight/LTScale] <Color>: Type L and press Enter Ambiguous response, please clarify… LTYpe or LWeight or LTScale? Type LW and press Enter Option=LWeight

Providing Feedback to the User

Although a program can simply request information from users and go on its way, it is best to acknowledge users and provide them with some feedback. Now this doesn't mean you need to make small talk with the person on the other side of the screen; it also doesn't mean you should share your life story. Based on the tasks your program might perform, you may want to provide information to the user when a macro does one of the following:

Starts Consider displaying the default settings or options that your program will be using, similar to the informational text that is displayed before the first prompt when using the fillet or style command.

Executes When processing a large dataset or number of objects, consider displaying a counter that helps the user know that something is still happening.

Causes an Error If something happens internally in your program, you should let users know what went wrong so they can let you (the programmer) know or try to fix the problem themselves.

Completes In most cases, you don't need to display information when a macro is done executing. However, you might want to let the user know if the information from a set of objects was successfully extracted or how many objects were modified.

Displaying Messages at the Command Prompt

In the「Requesting Input at the Command Prompt」section earlier, you learned how to display a message when requesting input from the user with one of the Getxxx functions. Messages can also be displayed at the Command prompt with the Prompt method of the AcadUtility object.

The following shows the syntax of the Prompt method:

object.Prompt(msg)

The msg argument represents the textual message to display at the Command prompt. As part of the textual message, you can use the constant vbLf to force the message on a new line, vbTab to add a Tab character, and """ to represent a quotation mark character. The vbBack constant, which emulates a press of the Backspace key, can also be useful in removing the Command: text from the Command prompt, thereby giving you a completely clean Command prompt. Use nine vbBack constants in a row to remove Command:. For a full list of supported constants that can be used in strings, search on the「Miscellaneous Constants」topic in the Microsoft VBA Help system. In the VBA Editor, click Help Microsoft Visual Basic For Applications Help.

The following are examples of the Prompt method and the values that are returned:

Dim oUtil As AcadUtility Set oUtil = ThisDrawing.Utility oUtil.Prompt vbLf & "Current OSMODE value: " & _ CStr(ThisDrawing.GetVariable("OSMODE")) & vbLf Current OSMODE value: 4133 oUtil.Prompt vbLf & "Drawing Name: " oUtil.Prompt CStr(ThisDrawing.GetVariable("DWGNAME")) & vbLf Drawing Name: Drawing1.dwg

TIP

I recommend adding a vbLf constant to the start and end of all messages displayed with the Prompt function. The vbLf constant ensures that your message is displayed on a new line and that the user is always returned to a clean Command prompt.

Displaying Messages in a Message Box

A message at the Command prompt is a common way of displaying information to the user when you don't want to interrupt the user's workflow. However, you can also display information in a message box (which the user must acknowledge before the program continues).

The MsgBox function of the VBA programming language can display a simple message box with a custom message and only an OK button. Message boxes can also contain a standard icon and button configuration that contains more than just an OK button. The MsgBox function returns a value that you can use to determine which button the user clicked. You can learn about the icons and button configurations that the MsgBox function supports in the Microsoft VBA Help system. In the VBA Editor, click Help Microsoft Visual Basic For Applications Help.

NOTE

You can create a user form that displays additional information to the user that cannot be displayed with the MsgBox function. For example, you could display a picture or allow the user to click a link in the message displayed.

The following is an example of displaying a message with the MsgBox function and how to determine which button the user pressed. Figure 28.3 shows the first message box that is displayed when the example code is executed.

Dim nRetVal As Integer nRetVal = MsgBox("Do you want to continue?", _ vbYesNoCancel + vbQuestion, "Continue") Select Case nRetVal Case vbYes MsgBox "Yes was clicked" Case vbNo MsgBox "No was clicked" Case vbCancel MsgBox "Cancel was clicked" End Select

Figure 28.3 Message displayed with the MsgBox function

Selecting Objects

The AutoCAD Object library enables you to step through all of the objects in a drawing or allow the user to interactively select objects in the drawing area. I explained how to get an object from model space without user input in Chapter 27,「Creating and Modifying Drawing Objects.」Using the selection techniques supported by the AutoCAD Object library, the user can be prompted to select a single object or a selection set can be created and the user allowed to select multiple objects.

Selecting an Individual Object

The user can be prompted to select a single object in the drawing area with the GetEntity method of the AcadUtility object. The GetEntity method returns two values: the selected object and the center point of the pick box when the object was selected. If no object is selected, an error is generated that must be handled to continue execution.

The following shows the syntax of the GetEntity method:

object.GetEntity(selectedObject, pickPoint, [msg])

Its arguments are as follows:

object The object argument represents the AcadUtility object.

selectedObject The selectedObject argument represents the variable that will be assigned the object that the user selected. The value assigned to the variable is of the Object data type.

pickPoint The pickPoint argument represents the variable that will be assigned the center point of the pick box when the object was selected. The value assigned to the variable is an array of three doubles.

msg The msg argument is an optional string that defines the prompt message to display at the Command prompt. The msg argument is optional, but I recommend always providing one.

NOTE

The GetEntity method supports the use of keywords with the InitializeUserInput method. See the「Initializing User Input and Keywords」section earlier in this chapter for more information on using keywords.

The following is an example of the GetEntity method. The example prompts the user for an object and displays a message with the name of the object selected or a general message if no object was selected.

' Continue on error On Error Resume Next ' Prompt the user for an object Dim vObj As Object, vPt As Variant ThisDrawing.Utility.GetEntity vObj, vPt, vbLf & "Select an object: " ' If an object was selected, display its object name If Not vObj Is Nothing Then MsgBox "Type of object selected: " & vObj.ObjectName Else MsgBox "No object selected." End If

TIP

If you want the user to select a specific type of object, you must use a selection method that supports selection filtering. I describe how to use selection filtering in the「Filtering Objects」section later in this chapter. The TypeOf statement can be used to validate the type of object selected. If the user selected the wrong type of object with the GetEntity method, you could use a While statement to continue prompting the user for an object until they select the correct type of object, select nothing, or press Enter.

The GetEntity method allows you to select an object as a whole, but not an entity inside of an object known as a subentity. The GetSubEntity method is similar to GetEntity except that GetSubEntity allows you to select an entire object or a subentity within an object such as an old-style polyline, dimension, or block. When the GetSubEntity method is used, it expects four arguments and can accept an optional prompt message. The four values that the GetSubEntity method returns are (in this order):

The object that represents the subentity selected by the user; a value of the Object data type is returned

The center point of where the pick box was positioned when the user selected the object; an array of three doubles

A transformation matrix for the subentity; a multi-element array of doubles

The object IDs of the subentities in the selected object or subentity; an array of long integers that represent the object IDs

For more information on the GetSubEntity method, see the AutoCAD Help system.

Working with Selection Sets

A grouping of selected objects in the AutoCAD drawing environment is known as a selection set. A selection set is a named container that holds references to objects in a drawing and exists only while a drawing remains open. From the AutoCAD user interface, a selection set is created when a user selects one or more objects at the Select objects: prompt.

In the AutoCAD Object library, a selection set is represented by an AcadSelectionSet object and all selection sets in a drawing are stored in the AcadSelectionSets collection object. The AcadSelectionSets collection object of a drawing is accessed using the SelectionSets property of an AcadDocument or ThisDrawing object.

In addition to the SelectionSets property, an AcadDocument or ThisDrawing object has two other properties that are related to selection sets: ActiveSelectionSet and PickfirstSelectionSet. Both properties are read-only. The ActiveSelectionSet property returns an AcadSelectionSet object that represents the active selection set of the drawing. The PickfirstSelectionSet property returns an AcadSelectionSet object that contains a selection set of the objects contained in the pickfirst selection. The pickfirst selection is made up of the objects that were selected before the execution of the VBA macro.

Managing Selection Sets

A selection set must be created or obtained before a user can be requested to select objects. The Add function of the AcadSelectionSets collection object creates a new selection set with the provided name and returns an AcadSelectionSet object. If you want to work with an existing selection set, use the Item method or a For statement on the AcadSelectionSets collection object to obtain an AcadSelectionSet object. When a selection set is no longer needed, use the Delete method of the AcadSelectionSet object to be removed.

NOTE

When you try to create most nongraphical objects, such as a layer or linetype, with the Add function, the existing object with the same name is returned by the function. However, the same doesn't happen when creating a selection set. An error is generated by the Add function of the AcadSelectionSets collection object if you try to create a selection set with a name that already exists. When the error occurs, use the Item function to get the selection set. If you want to reuse an existing named selection set, clear the items that are contained in the set with the Clear method before adding new objects. By clearing the selection set, you can use a selection set with the same name across many different functions. This can be helpful for keeping your code simple and for cleaning up afterward. For example, you might create a selection set named SSBlocks that is used to keep a running record in memory of all blocks in a drawing.

The following example creates a new selection set or returns an existing selection if one already exists with the same name:

On Error Resume Next ' Create a new selection set named NewSS Dim oSSet As AcadSelectionSet Set oSSet = ThisDrawing.SelectionSets.Add("NewSS") ' Check for an error, if so get the existing selection set If Err Then Err.Clear Set oSSet = ThisDrawing.SelectionSets.Item("NewSS") ' Reset the selection set oSSet.Clear End If ' Perform selection tasks here and work with the objects selected ' When done with a selection set, it is best to remove it oSSet.Delete

Adding and Removing Objects in a Selection Set

After a selection set has been created or an existing one obtained from the AcadSelectionSets collection object, you can work with the objects in the selection set or prompt the user to select objects in a drawing. The AddItems method of an AcadSelectionSet object allows you to add an array of objects to a selection set. Table 28.2 lists additional methods that can be used to manually add objects to a selection set by their placement in the drawing area.

Table 28.2 Object selection methods

Method Description

