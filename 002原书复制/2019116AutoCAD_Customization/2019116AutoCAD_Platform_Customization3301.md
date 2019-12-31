NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Setting Up a Project」section of Chapter 26. If you didn't complete the steps, do so now or start with the ch31_drawingsetup.dvb sample file available for download from www.sybex.com/go/autocadcustomization. Place this sample file in the MyCustomFiles folder under the Documents (or My Documents) folder, or the location you are using to store the DVB files. After the files are saved to the location you are using to store DVB files, remove ch31_ from the filename. You will also need the sample files ch31_building_plan.dwg, ch31_clsUtilities.cls, and b-tblk.dwg for this exercise.

Creating the Layout

A layout is used to organize objects from model space and the annotation required to communicate the design within viewports. Depending on the type of drawings you work with, there can be benefits to creating layouts dynamically as they are needed instead of manually adding them to your drawings. The following steps explain how to create a procedure named AddCheckPlotLayout to the drawingsetup.dvb project:

Open the VBA Editor and load the drawingsetup.dvb file.

In the VBA Editor Project Explorer, double-click the code module named basDrawingSetup.

When the code editor window opens, scroll to the bottom and click after the last End Sub statement. Press Enter twice.

Type the following; the comments are included for your information and don't need to be typed:' Adds a new layout based on the name passed to the function Private Function AddLayout(sLayoutName As String) As AcadLayout On Error Resume Next ' Get the layout Set AddLayout = ThisDrawing.Layouts(sLayoutName) ' If an error is generated, the layout doesn't exist If Err Then Err.Clear ' Add the layout Set AddLayout = ThisDrawing.Layouts.Add(sLayoutName) End If End Function

On the menu bar, click File Save.

Adding and Modifying a Plot Configuration

Plot settings control how a layout is output to a device (printer, plotter, or file). You can modify the plot settings of a layout directly or create a named plot configuration and then copy those plot settings to a layout.

The following steps define a procedure named AddPlotConfig, which is a helper function used to create a plot configuration based on a device and media size. You will use this function later to create a new plot configuration or return the plot configuration if it already exists in the drawing. The function returns an AcadPlotConfiguration object that represents the new plot configuration.

In the code editor window, scroll to the bottom and click after the last End Function statement. Press Enter twice.

Type the following; the comments are here for your information and don't need to be typed:' Adds a plot configuration based on the name and values ' passed to the function Private Function AddPlotConfig(sPltConfigName As String, _ sDeviceName As String, _ sMediaName As String, _ sPlotStyleName As String, _ bModelType As Boolean, _ nPlotType As AcPlotType, _ nPlotRotation As AcPlotRotation, _ ) As AcadPlotConfiguration On Error Resume Next ' Get the plot configuration Set AddPlotConfig = ThisDrawing. _ PlotConfigurations(sPltConfigName) ' If an error is generated, the plot configuration doesn't exist If Err Then Err.Clear ' Add the plot configuration Set AddPlotConfig = ThisDrawing. _ PlotConfigurations. _ Add(sPltConfigName, bModelType) ' Assign a device name AddPlotConfig.ConfigName = sDeviceName ' Assign a media name AddPlotConfig.CanonicalMediaName = sMediaName ' Assign a plot style name AddPlotConfig.StyleSheet = sPlotStyleName ' Assign the layout plot type AddPlotConfig.PlotType = nPlotType ' Assign the plot rotation AddPlotConfig.PlotRotation = nPlotRotation End If End Function

On the menu bar, click File Save.

Inserting a Title Block

Title blocks are a form of annotation that is used to help identify and communicate the project with which the drawing is associated. Depending on your design, a title block might display the location of a building, the model number of a new part to be manufactured, revision history, and much more. In the exercises in Chapter 26, you inserted the title block b-tblk.dwg into a drawing using the insert command with the SendCommand method, but as I explained earlier in the book, using commands for this kind of operation has drawbacks.

In the next steps, you will create a new procedure named AddBlkReference that will insert a title block onto a specified layout with a known location, rotation, and scale. The procedure will then be used later to insert that same block.

In the code editor window, scroll to the bottom and click after the last End Function statement. Press Enter twice.

Type the following; the comments are here for your information and don't need to be typed:' Insert a block onto a specified layout Private Function AddBlkReference(oLayout As AcadLayout, _ sBlkName As String, _ vInsPoint As Variant, _ dRotation As Double, _ dScale As Double _ ) As AcadBlockReference On Error Resume Next ' Insert the block Set AddBlkReference = oLayout.Block. _ InsertBlock(vInsPoint, _ sBlkName, _ dScale, dScale, dScale, _ dRotation) ' If an error is generated, return Nothing If Err Then Err.Clear Set AddBlkReference = Nothing End If End Function

On the menu bar, click File Save.

Displaying Model Space Objects with a Viewport

The most common objects placed on a layout after annotation objects are viewports. Viewports are used to display model space objects at a specific scale.

In the next steps, you will create a new procedure named AddFloatingViewport that adds a floating viewport to the specified paper space block with a known center, width, and height.

In the code editor window, scroll to the bottom and click after the last End Function statement. Press Enter twice.

Type the following; the comments are here for your information and don't need to be typed:' Add a floating viewport to a layout Private Function AddFloatingViewport(oPSpace As AcadPaperSpace, _ vCenterPoint As Variant, _ dWidth As Double, _ dHeight As Double _ ) As AcadPViewport On Error Resume Next ' Add the Viewport Set AddFloatingViewport = oPSpace. _ AddPViewport(vCenterPoint, _ dWidth, _ dHeight) ' If an error is generated, return Nothing If Err Then Err.Clear Set AddFloatingViewport = Nothing End If End Function

On the menu bar, click File Save.

Putting It All Together

Now that you have defined functions that create a layout and plot configuration, insert a block, and add a floating viewport, it is time to put them all to work. In addition to using the functions defined in this exercise, you will use the createlayer function from the clsUtilities class to create a few new layers if they aren't present in the drawing file.

In these steps, you'll import the class module named clsUtilities.cls and define a global variable, which will be used to access the procedures defined in the clsUtilities class:

In the VBA Editor, in the Project Explorer, right-click the DrawingSetup project and choose Import File.

When the Import File dialog box opens, browse to and select the clsUtilities.cls file in the MyCustomFiles folder. Click Open. The clsUtilities.cls file contains the utility procedures that you created as part of the DrawPlate project or downloaded as part of the sample files for this book.

In the Project Explorer, double-click the code module named basDrawingSetup.

In the text editor area of the basDrawingSetup component, scroll to the top and add the following on a new line: Private myUtilities As New clsUtilities

The createlayer function is now available for use in the basDrawingSetup code module.

In the next steps, you will create a new procedure named CheckPlot. This will be the main procedure that the end user executes from the AutoCAD user interface. This new procedure creates a layout and plot configuration named CheckPlot, inserts the title block stored in the drawing file named b-tblk.dwg, creates a new floating viewport, and outputs the layout using the assigned device to a file named checkplot.dwf.

In the code editor window, scroll to the bottom and click after the last End Function statement. Press Enter twice.

Type the following; the comments are here for your information and don't need to be typed:' Creates a function that creates a new layout named CheckPlot, ' sets the output device for the layout to the DWF ePlot.pc3 file, ' inserts a title block for a ANSI B size sheet of paper and ' plots the layout. Public Sub CheckPlot() On Error Resume Next ' Check to see if the CheckPlot layout already exists, ' and if so set it current Dim oLayout As AcadLayout Set oLayout = ThisDrawing.Layouts("CheckPlot") If Err Then Err.Clear ' Store and change the default for creating a viewport ' when a new layout is created Dim bFlag As Boolean bFlag = ThisDrawing.Application. _ Preferences.Display.LayoutCreateViewport ThisDrawing.Application. _ Preferences.Display.LayoutCreateViewport = False ' Use the AddLayout function to create ' the CheckPlot layout Set oLayout = AddLayout("CheckPlot") ' Set the new layout current ThisDrawing.ActiveLayout = oLayout ' Use the AddPlotConfig function to create ' the CheckPlot plot configuration Dim oPltConfig As AcadPlotConfiguration Set oPltConfig = AddPlotConfig("CheckPlot", "DWF6 ePlot.pc3", _ "ANSI_B_(17.00_x_11.00_Inches)", _ False, "acad.ctb", _ acLayout, ac0degrees) ' Assign the plot configuration to the layout oLayout.CopyFrom oPltConfig ' Use the AddBlkReference function to insert ' the title block named b-tblk.dwg onto the layout Dim sTitleBlkName As String sTitleBlkName = ThisDrawing.GetVariable("mydocumentsprefix") & _ "\MyCustomFiles\b-tblk.dwg" Dim dInsPt(2) As Double dInsPt(0) = 0: dInsPt(1) = 0: dInsPt(2) = 0 Dim oBlkRef As AcadBlockReference Set oBlkRef = AddBlkReference(oLayout, sTitleBlkName, _ dInsPt, 0, 1) ' If a block reference was returned, place it on the Tblk layer If Not oBlkRef Is Nothing Then ' Add the layer for the title block oBlkRef.Layer = myUtilities.CreateLayer("TBLK", 8).Name End If ' Add a viewport to the layout Dim dCPt(2) As Double dCPt(0) = 6.375: dCPt(1) = 4.875: dCPt(2) = 0 Dim oVport As AcadPViewport Set oVport = AddFloatingViewport(ThisDrawing.PaperSpace, _ dCPt, 12.55, 9.55) ' If a floating viewport was returned, place it on the Vport layer If Not oVport Is Nothing Then ' Turn the viewport On oVport.Display True ' Add the layer for the viewport and set it to not plottable Dim oLayer As AcadLayer Set oLayer = myUtilities.CreateLayer("Vport", 9) oLayer.Plottable = False ' Assign the layer for the viewport oVport.Layer = oLayer.Name ' Set the scale of the viewport to Fit oVport.StandardScale = acVpScaleToFit Else MsgBox "Warning: The viewport couldn't be created." End If ' Restore viewport creation for new layouts ThisDrawing.Application. _ Preferences.Display.LayoutCreateViewport = bFlag Else ' Set the new layout current ThisDrawing.ActiveLayout = oLayout End If ' Zoom to the extents of the layout ThisDrawing.Application.ZoomExtents ' Regen the drawing ThisDrawing.Regen acActiveViewport ' Re-establish the area to plot is the layout ThisDrawing.ActiveLayout.PlotType = acLayout ' Prompt the user if the check plot should be created now If MsgBox("Do you want to create the check plot?", _ vbYesNo) = vbYes Then With ThisDrawing.Plot ' Assign the CheckPlot layout for plotting .SetLayoutsToPlot Array(oLayout) ' Define the name of the DXF file to create Dim sDWFName As String sDWFName = ThisDrawing.GetVariable("mydocumentsprefix") & _ "\MyCustomFiles\checkplot.dwf" ' Plot the DWF file and display a message if the ' plot was unsuccessful If.PlotToFile(sDWFName) = False Then MsgBox "The CheckPlot layout couldn't be output." & _ vbLf & "Check the device and plot settings." End If End With End If End Sub

On the menu bar, click File Save.

Testing the CheckPlot Procedure

The following steps explain how to test the CheckPlot procedure:

Switch to the AutoCAD application window.

Open Ch31_Building_Plan.dwg.

At the Command prompt, type vbarun and press Enter.

When the Macros dialog box opens, select the RoolLabel.dvb!basDrawingsetup.CheckPlot macro from the list and click Run. The new layout named CheckPlot is set as current, as shown in Figure 31.1.

When the message box opens, click Yes to create the DWF file in the MyCustomFiles folder. Open the checkplot.dwf file that is generated with the Autodesk Design Review program (http://usa.autodesk.com/design-review/) or a similar program.

Figure 31.1 New layout with a title block

Chapter 32

Storing and Retrieving Custom Data

There are times when it would be nice to have a custom program store values and then retrieve them at a later time. Although you can use a global variable to temporarily store a value while the custom program remains in memory, global variables do not persist across multiple sessions. Using the AutoCAD® Object library and VBA, you can store values so that they persist between drawing or AutoCAD sessions.

If you want a value to be available when a drawing is open, you can use extended data (Xdata) or a custom dictionary. (I introduced the use of dictionaries in Chapter 29,「Annotating Objects,」and how they are used for storing annotation styles such as table and multileader styles.) Xdata can be attached to an object as a way to differentiate one object from another or, in some cases, to affect the way an object might look in the drawing area.

Values can be stored in the Windows Registry and retrieved from any AutoCAD session that your custom program is loaded into. The values stored in the Windows Registry can represent strings, 2D or 3D points, integers, and doubles. As an alternative, the values can be written to a text file and read at a later time. (I discuss how to work with external files in Chapter 35,「Communicating with Other Applications.」)

Extending Object Information

Each object in a drawing has a preestablished set of properties that define how that object should appear or behave. For example, these properties are used to define the size of a circle or the location of a line within a drawing. Although you can't use VBA to add a new property to an object, you can append custom information to an object. The custom information that is appended to an object is known as Xdata.

Xdata is structured using two arrays. The first array contains the data types for the values to be stored (DXF group codes); the second array contains the values to be stored. The two arrays must contain the same number of elements. As part of the values to be stored, the first value must be an application name to identify the custom program that added the Xdata. After the application name, the array can contain any supported values. Supported values are strings, integers, doubles, and entity names, among others.

The values that make up the Xdata and what they represent is up to you, the creator of the data. Data in the Xdata arrays can be used to identify where an object should be placed or which layer it should be on, to store information about an external database record that is related to an object, or to build relationships between objects in a drawing. The way data is used or enforced is up to you as the programmer.

In addition to Xdata, graphical and nongraphical objects support what are known as extension dictionaries. Extension dictionaries are kind of like record tables that can be attached to an object. For example, you could store revision history of a drawing in an extension dictionary that is attached to model space, and then populate the drawing title block with that information. Even AutoCAD uses extension dictionaries to implement features, such as Layer States and Filters, which are attached to the Layer symbol table. I discuss creating custom dictionaries in greater detail in the「Creating and Modifying a Custom Dictionary」section later in this chapter.

Working with Xdata

Attaching Xdata to an object requires you to do some initial planning and perform several steps.

Appending Xdata

The following list outlines the steps that you must perform in order to attach Xdata to an object:

Check to see if the object already has Xdata attached and with what application name. If Xdata is already attached with the application name you planned to use, skip to the「Replacing Xdata」section.

Define and register an application name for your custom program.

Define the array that will hold the DXF group codes that will specify the data types for the data values array; the first element in the array should be 1001, which represents the DXF group code for the application name.

Define the array that will hold the data values for the Xdata; the first element in the array should be a string that represents the application name.

Get the object to which you wish to append the Xdata.

Append the Xdata to the object with the SetXData method.

Replacing Xdata

Prior to appending Xdata, you should check to see if the object already has Xdata with your custom program's application name attached to it. If that's the case, you should replace the current Xdata with the new. Follow these steps to modify the Xdata previously attached to an object:

Define the values that will make up the Xdata.

Define the array that will hold the DXF group codes that will be used to represent the data types of the data values array; the first element in the array should be 1001, which represents the DXF group code for the application name.

Define the array that will hold the data values for the Xdata; the first element in the array should be a string that represents the application name.

Get the object for which you wish to replace the Xdata.

Use the GetXData method to check for the existence of Xdata for the application name.

Substitute the current Xdata attached to an object with the new Xdata.

Update the object.

Defining and Registering an Application Name

Before you can attach Xdata to an object, you must decide on an application name and then register that name with the current drawing. The application name you choose should be unique to avoid conflicts with other Xdata that could potentially be attached to an object. After you choose an application name, register the name with the Add method of the AcadRegisteredApplications collection object. The Add method accepts a single string argument that is the name of the application you want to register, and it returns the new AcadRegisteredApplication object.

The following example demonstrates how to register an application:

' Registers the application named MyApp Dim sAppName as String sAppName = "MyApp" Dim oRegApp As AcadRegisteredApplication Set oRegApp = ThisDrawing.RegisteredApplications.Add(sAppName)

Attaching Xdata to an Object

Once you have defined and registered an application name, you can attach Xdata to an object within that drawing. Xdata is made up of two arrays and has a total size limit of 16 KB per object. (See the「Monitoring the Memory Used by Xdata for an Object」sidebar for more information.) The first array defines the data types of the values to be stored using DXF group codes, whereas the second array defines the actual values. The two arrays are used for what is known as a dotted pair. A dotted pair in AutoCAD is a relationship of a data type and value that has the format of (dxftype. value) to programming languages such as the AutoLISP® and ObjectARX® languages.

The DXF group codes used in the data type array of Xdata must be within the range of 1000 to 1071. Each DXF group code value in that range represents a different type of data, and you can use each DXF group code more than once in the data type array for Xdata. Table 32.1 lists some of the commonly used DXF group codes for Xdata.

Table 32.1 Xdata-related DXF group codes

DXF group code Description

1000 String value

1001 Application name

1010 3D point

1040 Real numeric value

1070 16-bit (unsigned or signed) integer value

1071 32-bit signed integer value

The following arrays define Xdata that contains the application name MyApp, a string value with the text「My custom application,」and a double that represents the current date:

' Define the data types array for the Xdata Dim nXdTypes(2) As Integer nXdTypes(0) = 1001 nXdTypes(1) = 1000 nXdTypes(2) = 1071 ' Define the data values array for the Xdata Dim vXdVals(2) As Variant vXdVals(0) = "MyApp" vXdVals(1) = "My custom application" vXdVals(2) = CLng(ThisDrawing.GetVariable("cdate"))

The array that defines the data types of the values in the Xdata must be defined as the integer data type, whereas the data values array for the Xdata should be defined as the variant data type. Once the arrays that will make up the Xdata have been defined, the Xdata can be attached to an object with the SetXData method.

The following shows the syntax of the SetXData method:

object.SetXData dataTypes, dataValues

Its arguments are as follows:

object The object argument represents the AutoCAD object that you want to attach Xdata to.

dataTypes The dataTypes argument is an array of integers that represent the types of data values to be stored with the object's Xdata.

dataValues The dataValues argument is an array of variants that represent the data values to be stored with the object's Xdata.

After the Xdata has been attached to an object, you might need to execute the object's Update method to refresh the object if the Xdata affects the appearance of the object. I explained how to use the Update method in Chapter 28,「Interacting with the User and Controlling the Current View.」

This exercise shows how to attach Xdata to a circle:

At the AutoCAD Command prompt, type vbaman and press Enter.

When the VBA Manager opens, click New.

Click Visual Basic Editor.

In the VBA Editor, in the Project Explorer, double-click the ThisDrawing component.

In the code editor window, type the following:Sub AddXDataToCircle() ' Registers the application named MyApp Dim sAppName As String sAppName = "MyApp" Dim oRegApp As AcadRegisteredApplication Set oRegApp = ThisDrawing.RegisteredApplications.Add(sAppName) ' Define the data types array for the Xdata Dim nXdTypes(2) As Integer nXdTypes(0) = 1001 nXdTypes(1) = 1000 nXdTypes(2) = 1071 ' Define the data values array for the Xdata Dim vXdVals(2) As Variant vXdVals(0) = "MyApp" vXdVals(1) = "My custom application" vXdVals(2) = CLng(ThisDrawing.GetVariable("cdate")) ' Define center point for the circle Dim dCenPt(2) As Double dCenPt(0) = 2: dCenPt(1) = 2: dCenPt(2) = 0 ' Add a circle object to model space Dim oCirc As AcadCircle Set oCirc = ThisDrawing.ModelSpace.AddCircle(dCenPt, 1) ' Assign the Xdata to the circle object oCirc.SetXData nXdTypes, vXdVals End Sub

Switch to AutoCAD.

At the Command prompt, type vbarun and press Enter.

When the Macros dialog box opens, select the GlobalN!ThisDrawing.AddXDataToCircle macro and click Run.

Save the project if you want, but don't close it as you will continue with the project in the next exercise.

A new circle with a center point of 2,2 and radius of 1 is added to model space along with the Xdata attached to it. The circle won't look any different than a circle without the Xdata attached to it because the Xdata doesn't affect the way the AutoCAD program draws the object. However, you can now identify this circle from those that might be created with the circle command. For example, you could use Xdata to tag a circle that represents a drill hole in your drawing. By identifying the circle as a drill hole, you make it easier to locate and update the circles that represent drill holes as needed in the drawing.

Monitoring the Memory Used by Xdata for an Object

Each object in a drawing can have a maximum of 16 KB of Xdata attached to it. The 16 KB is the total of all Xdata attached to an object, and not just for one application. If the limit of Xdata is close and you attach additional Xdata that exceeds the limit, the Xdata won't be attached. AutoLISP provides two functions that help to determine the size of the Xdata being attached to an object and the amount of space already being used by the Xdata attached to an object.

The AutoCAD Object library doesn't support any functions that can be used to manage Xdata, but when the limit is exceeded an error is generated. You can use the VBA error-handling features to catch and respond to the error accordingly.

Querying and Modifying the Xdata Attached to an Object

Xdata that has been previously attached to an object can be queried and modified by following a process that is similar to the one used to attach Xdata to an object. The GetXData method of an object is used to get the Xdata attached to an object for a specific application or all applications. Two arrays are returned by the GetXData method. You can use the IsArray function to check whether the values returned by the GetXData method are empty. If a value of True is returned by the IsArray function, the object has Xdata attached to it for the specified application name.

The following shows the syntax of the GetXData function:

object.GetXData appName, dataTypes, dataValues

Its arguments are as follows:

object The object argument represents the AutoCAD object that you want to retrieve Xdata from.

appName The appName argument is a string that represents the application name of the Xdata you want to retrieve. Using an empty string returns the Xdata for all applications that have Xdata attached to the object.

dataTypes The dataTypes argument must be a variant and is assigned the current types of data that are stored with the object's Xdata. The variant that is returned contains an array of integer values.

dataValues The dataValues argument must be a variant and is assigned the current data values that are stored with the object's Xdata.

The following code statements return the Xdata for the application named MyApp if attached to the last object in model space:

' Get the last object added to model space Dim oAcadObj As AcadObject Set oAcadObj = ThisDrawing.ModelSpace(ThisDrawing.ModelSpace.Count - 1) ' Get the Xdata for the MyApp application name Dim vXdTypes As Variant, vXdVals As Variant oAcadObj.GetXData "MyApp", vXdTypes, vXdVals

Using an empty string instead of an actual application name returns the Xdata for all applications attached to an object, as shown here:

' Get the Xdata for all applications Dim vXdTypes As Variant, vXdVals As Variant oAcadObj.GetXData "", vXdTypes, vXdVals

This exercise shows how to list the Xdata attached to a dimension with a dimension override:

At the AutoCAD Command prompt, type dli press Enter.

At the Specify first extension line origin or <select object>: prompt, specify a point in the drawing.

At the Specify second extension line origin: prompt, specify a second point in the drawing.

At the Specify dimension line location or [Mtext/Text/Angle/Horizontal/Vertical/Rotated]: prompt, specify a point in the drawing to place the linear dimension.

Select the linear dimension that you created, right-click, and then click Properties.

In the Properties palette, click the Arrow 1 field under the Lines & Arrows section. Select None from the drop-down list. The first arrowhead of the linear dimension is suppressed as a result of a dimension override being created.

In the VBA Editor, open the code editor window for the ThisDrawing component of the project you created in the previous exercise. Type the following:Sub RetreiveXDataForLastObject() ' Get the last object added to model space Dim oAcadObj As AcadObject Set oAcadObj = ThisDrawing.ModelSpace(ThisDrawing.ModelSpace.Count - 1) ' Get the Xdata attached to the object Dim vXdTypes As Variant, vXdVals As Variant oAcadObj.GetXData "", vXdTypes, vXdVals ' Check to see whether the value returned is an array ' An array means Xdata is present If IsArray(vXdTypes) Then Dim sMsg As String sMsg = "Xdata Values" & vbLf Dim nCnt As Integer ' Append the values of the Xdata to the sMsg variable For nCnt = 0 To UBound(vXdVals) sMsg = sMsg & "Value (" & CStr(nCnt) & ") " & vXdVals(nCnt) & vbLf Next nCnt ' Display the value of the sMsg variable MsgBox sMsg End If End Sub

Switch to AutoCAD.

At the Command prompt, type vbarun and press Enter.

When the Macros dialog box opens, select the GlobalN!ThisDrawing. RetreiveXDataForLastObject macro and click Run. Attaching Xdata to the linear dimension is how the AutoCAD program handles dimension overrides for individual dimensions. Figure 32.1 shows what the Xdata attached to the linear dimension looks like as a result of changing the Arrow 1 property in step 6.

Save the project if you want, but don't close it, as you will continue with the project in the next exercise.

NOTE

I mentioned earlier that Xdata doesn't affect the appearance of an object, and that is still true even when used as we did in the previous exercise. Xdata itself doesn't affect the object, but AutoCAD does look for its own Xdata and uses it to control the way an object might be drawn. If you implement an application with the ObjectARX application programming interface, you could use ObjectARX and Xdata to control how an object is drawn onscreen. You could also control the way an object looks using object overrules with Managed.NET and Xdata. ObjectARX and Managed.NET are the two advanced programming options that Autodesk supports for AutoCAD development. You can learn more about ObjectARX and Managed.NET at www.objectarx.com.

Figure 32.1 Message box displaying the data values of Xdata that represent a dimension override

As shown in the previous exercise, the IsArray function can be used to determine whether Xdata for a specific application is already attached to an object by getting the values returned by the GetXData method. If Xdata is already attached to an object for a specific application name, assigning new values with the same application will overwrite the previous Xdata that was attached. Modifying Xdata that is already attached requires you to get the current Xdata with the GetXData method and then re-dimension the array using the ReDim and Preserve statements. Which approach you use depends on whether you need to replace or modify the existing Xdata.

This exercise shows how to modify the Xdata of the dimension you created in the previous exercise. You will append values that will assign ACI 40 to the dimension line and ACI 7 to the extension lines overriding the colors assigned to the dimension by its assigned dimension style.

In the VBA Editor, open the code editor window for the ThisDrawing component of the project you created earlier in this chapter. Type the following:Sub ReplaceXDataForDimOverride() On Error Resume Next ' Prompt the user to select an object Dim oAcadObj As AcadObject ThisDrawing.Utility.GetEntity oAcadObj, Nothing, _ vbLf & "Select dimension to add overrides: " Dim nXdTypesFinal() As Integer Dim vXdValsFinal() As Variant ' Check to see if an object was selected If Not oAcadObj Is Nothing Then ' Check to see if the selected object is a dimension If TypeOf oAcadObj Is AcadDimension Then ' Get the Xdata attached to the object Dim vXdTypes As Variant, vXdVals As Variant oAcadObj.GetXData "ACAD", vXdTypes, vXdVals ' Check to see whether the value returned is an array ' An array means Xdata is present If IsArray(vXdTypes) Then Dim nCnt As Integer, nNewCnt As Integer nCnt = 0: nNewCnt = 0 ' Append the values of the Xdata to the sMsg variable For nCnt = 0 To UBound(vXdVals) ' If "{", append the previous value and new values If vXdVals(nCnt) = "{" Then ' Increase the arrays by 4 additional values to make ' room for the new overrides ReDim Preserve nXdTypesFinal(nNewCnt + 4) ReDim Preserve vXdValsFinal(nNewCnt + 4) ' Add the existing Xdata value of "{" nXdTypesFinal(nNewCnt) = vXdTypes(nCnt) vXdValsFinal(nNewCnt) = vXdVals(nCnt) ' Add the data types and values for the new overrides ' Dimension line color nXdTypesFinal(nNewCnt + 1) = 1070 vXdValsFinal(nNewCnt + 1) = 176 nXdTypesFinal(nNewCnt + 2) = 1070 vXdValsFinal(nNewCnt + 2) = 40 ' Extension line color nXdTypesFinal(nNewCnt + 3) = 1070 vXdValsFinal(nNewCnt + 3) = 177 nXdTypesFinal(nNewCnt + 4) = 1070 vXdValsFinal(nNewCnt + 4) = 200 ' Increment the array counter by 5 since we added 5 elements nNewCnt = nNewCnt + 5 Else ' Not the "{" value, so append the previous value ReDim Preserve nXdTypesFinal(nNewCnt) ReDim Preserve vXdValsFinal(nNewCnt) ' Add the previous values of the Xdata to the new arrays nXdTypesFinal(nNewCnt) = vXdTypes(nCnt) vXdValsFinal(nNewCnt) = vXdVals(nCnt) ' Increment the array counter by 1 nNewCnt = nNewCnt + 1 End If Next nCnt Else ' The following is executed if no Xdata is already applied. ' The two arrays define color overrides for the dimension ' and extension lines. ' Define the data types array for the Xdata ReDim nXdTypesFinal(7) nXdTypesFinal(0) = 1001: nXdTypesFinal(1) = 1000 nXdTypesFinal(2) = 1002: nXdTypesFinal(3) = 1070 nXdTypesFinal(4) = 1070: nXdTypesFinal(5) = 1070 nXdTypesFinal(6) = 1070: nXdTypesFinal(7) = 1002 ' Define the data values array for the Xdata ReDim vXdValsFinal(7) vXdValsFinal(0) = "ACAD": vXdValsFinal(1) = "DSTYLE" vXdValsFinal(2) = "{": vXdValsFinal(3) = 176 vXdValsFinal(4) = 40: vXdValsFinal(5) = 177 vXdValsFinal(6) = 200: vXdValsFinal(7) = "}" End If ' Assign the Xdata to the dimension oAcadObj.SetXData nXdTypesFinal, vXdValsFinal oAcadObj.Update End If End If End Sub

Switch to AutoCAD.

At the Command prompt, type vbarun and press Enter.

When the Macros dialog box opens, select the GlobalN!ThisDrawing. ReplaceXDataForDimOverride macro and click Run.

At the Select dimension to add overrides: prompt, select the linear dimension you created in the previous exercise. The colors of the dimension and extension lines of the dimension object inherited from the dimension style are now overridden while preserving the first arrow of the dimension being set to None. This is similar to what happens when you select a dimension, right-click, and choose Precision.

Save the project if you want, but don't close it as you will continue with the project in the next exercise.

Removing Xdata from an Object

Xdata can be removed from an object when it is no longer needed. You do so by replacing the Xdata attached to an object with a data value array that contains only an application name. When AutoCAD evaluates Xdata with only an application name and no additional data values, it removes the Xdata from the object. Here is an example of Xdata that can be used to remove the Xdata associated with the MyApp application:

' Define the data types array for the Xdata Dim nXdTypes(0) As Integer nXdTypes(0) = 1001 ' Define the data values array for the Xdata Dim vXdVals(0) As Variant vXdVals(0) = "MyApp"

The following example removes the Xdata list associated with an application named ACAD from a dimension, which removes all overrides assigned to the dimension:

Sub RemoveDimOverride() On Error Resume Next ' Define the data types array for the Xdata Dim nXdTypes(0) As Integer nXdTypes(0) = 1001 ' Define the data values array for the Xdata Dim vXdVals(0) As Variant vXdVals(0) = "Acad" Dim oAcadObj As AcadObject ThisDrawing.Utility.GetEntity oAcadObj, Nothing, _ vbLf & "Select dimension to remove overrides: " ' Check to see if an object was selected If Not oAcadObj Is Nothing Then ' Check to see if the selected object is a dimension If TypeOf oAcadObj Is AcadDimension Then ' Assign the Xdata to the circle object oAcadObj.SetXData nXdTypes, vXdVals End If End If End Sub

Selecting Objects Based on Xdata

You can use the Xdata attached to an object as a way to select or filter out specific objects with the selection-related functions of the AcadSelectionSet object. (I explained how to use the optional filterType and filterData arguments with the selection-related functions of the AcadSelectionSet object in Chapter 27,「Creating and Modifying Drawing Objects.」) If you want to filter on the Xdata attached to an object, you use the DXF group code 1001 along with the application name from the Xdata.

Here are example code statements that use the SelectOnScreen method to allow the user to select objects in the drawing but keep in the selection set those that have Xdata attached to them with the ACAD application name:

Sub SelectObjectsByXdata() On Error Resume Next ' Define the data types array for the Xdata Dim nXdTypes(0) As Integer nXdTypes(0) = 1001 ' Define the data values array for the Xdata Dim vXdVals(0) As Variant ' Get the selection set named SSAcad Dim oSSAcad As AcadSelectionSet Set oSSAcad = ThisDrawing.SelectionSets("SSAcad") ' If SSMyApp isn't found, add it If Err Then Err.Clear Set oSSAcad = ThisDrawing.SelectionSets.Add("SSAcad") Else ' Clear the objects in the selection set oSSAcad.Clear End If ' Selects objects containing Xdata ' with the application name of ACAD. vXdVals(0) = "ACAD" oSSAcad.SelectOnScreen nXdTypes, vXdVals ' Display the number of objects in the selection set MsgBox "Objects that contain Xdata for MyApp are: " & CStr(oSSAcad.Count) ' Remove the SSAcad selection set oSSAcad.Delete End Sub

Creating and Modifying a Custom Dictionary

Dictionaries are used to store custom information and objects in a drawing and can be thought of as an extension of symbol tables. Dictionaries were introduced with AutoCAD R13 as a way to introduce new symbol-table-like objects without the need to change the drawing file format with each release. Although there is only one type of dictionary in a drawing, dictionaries can be stored in two different ways: per drawing or per object.

The main dictionary—also known as the named object dictionary—of a drawing contains nested dictionaries that store multileader and table styles, and even the layouts used to organize and output a drawing. Dictionaries can also be attached to an object, and those are known as extension dictionaries, which I explained earlier this chapter.

Custom dictionaries are great for storing custom program settings so that they persist across drawing sessions. You might also use a custom dictionary as a way to store drawing revision history or project information that can be used to track a drawing and populate a title block. In this section, you'll learn how to access, create, query, and modify information stored in a dictionary.

Accessing and Stepping through Dictionaries

The main dictionary of a drawing is accessed using the Dictionaries property of the ThisDrawing or an AcadDocument object. The Dictionaries property returns the AcadDictionaries collection object, which contains all the dictionaries that aren't attached to an object as an extension dictionary. Dictionaries are similar to working with symbol tables. Once you have the AcadDictionaries collection object, use the object's Item method or a For statement to get an individual dictionary that is represented by an AcadDictionary object.

A dictionary can store an object or extended record—also known as an Xrecord. An Xrecord is similar to the Xdata that can be attached to an object, which I explain in the「Storing Information in a Custom Dictionary」section later in this chapter. The only difference is that Xrecord data types are in the range of 1–369 instead of more than 1,000 like Xdata. Although VBA can be used to get any dictionary stored in a drawing, not all entries in a dictionary can be accessed with VBA and the AutoCAD Object library. The reason that not all entries in a dictionary are accessible is that some objects aren't part of the AutoCAD Object library.

For example, you can access the dictionaries that store plot and visual styles in a drawing but not the individual entries themselves. The entries of the dictionaries used to store layouts, table styles, and multileader styles are accessible from VBA because the objects in those dictionaries are defined in the AutoCAD Object library.

NOTE

If you need to access the entries of other dictionaries, you will need to use the AutoLISP programming language, ObjectARX, or Managed.NET. I discussed how to work with dictionaries using the AutoLISP programming language in Part II,「AutoLISP: Productivity through Programming.」

The following example code statements step through and list the names of each table style in the drawing that is stored in the ACAD_TABLESTYLE dictionary. The code is followed by sample output.

' Lists the table styles in the current drawing Sub ListTableStyles() ' Get the ACAD_TABLESTYLE dictionary Dim oDictTblStyle As AcadDictionary Set oDictTblStyle = ThisDrawing.Dictionaries("ACAD_TABLESTYLE") If Not oDictTblStyle Is Nothing Then Dim sMsg As String sMsg = "Table styles in this drawing:" & vbLf ' Append the names of each table style to the sMsg variable Dim oTblStyleEntry As AcadTableStyle For Each oTblStyleEntry In oDictTblStyle sMsg = sMsg & oTblStyleEntry.Name & vbLf Next oTblStyleEntry ' Display the table style names in the Command Line history ThisDrawing.Utility.Prompt vbLf & sMsg Else ThisDrawing.Utility.Prompt vbLf & _ "Drawing doesn't contain the ACAD_TABLESTYLE dictionary." End If End Sub Table styles in this drawing: BOM - Architectural BOM - Mechanical Standard Title Sheet

The existence of an entry in a dictionary can be validated with the Item method of the AcadDictionary object and an If conditional statement or by using the For statement to get each entry in the dictionary. If the name of the entry in the dictionary exists, the object is returned; otherwise, an error is generated.

The following shows how to get the Standard table style entry from the ACAD_TABLESTYLE dictionary:

' Gets the Standard table style in the current drawing Sub GetStandardTableStyle() On Error Resume Next ' Get the ACAD_TABLESTYLE dictionary Dim oDictTblStyle As AcadDictionary Set oDictTblStyle = ThisDrawing.Dictionaries("ACAD_TABLESTYLE") If TypeOf oDictTblStyle Is AcadDictionary Then ' Get the Standard table style Dim oTblStyleEntry As AcadTableStyle Set oTblStyleEntry = oDictTblStyle("Standard") If Not oTblStyleEntry Is Nothing Then MsgBox "Standard table style found." End If End If End Sub

Creating a Custom Dictionary

As I mentioned earlier, one of the benefits of dictionaries is that you can store custom information or settings related to the programs you create in a drawing. Before a custom dictionary can be used and entries added to it, it must first be created. The Add method of the AcadDictionaries collection object is used to create a new named object dictionary. When you create a dictionary with the Add method, you must pass the method a string that represents the name of the dictionary you wish to create. The Add method of the AcadDictionaries collection object returns an AcadDictionary object.

Here's an example that creates a dictionary named MY_CUSTOM_DICTIONARY and adds it to the named object dictionary:

' Creates a custom dictionary named MY_CUSTOM_DICTIONARY Dim oDict As AcadDictionary Set oDict = ThisDrawing.Dictionaries.Add("MY_CUSTOM_DICTIONARY")

In addition to adding a dictionary to the named object dictionary, you can create an extension dictionary on any object that is based on AcadObject, which includes most nongraphical and graphical objects in an AutoCAD drawing. Since an AcadDictionary object is based on an AcadObject, it can also have an extension dictionary, which can make for some interesting and complex data models.

An extension dictionary is similar to the named object dictionary of a drawing, and it can hold nested dictionaries of extended records. If you want to create an extension dictionary, you must first get the extension dictionary of an object with the GetExtensionDictionary method. This method returns an AcadDictionary object. The HasExtensionDictionary property of an object can be used to check whether an object has an extension dictionary attached to it.

These example code statements check whether an extension dictionary exists on the last object in model space:

Sub AddExtensionDictionary() On Error Resume Next ' Get the last object added to model space Dim oAcadObj As AcadObject Set oAcadObj = ThisDrawing.ModelSpace(ThisDrawing.ModelSpace.Count - 1) If Err.Number = 0 Then Dim oExDict As AcadDictionary ' Check whether an extension dictionary already exists If oAcadObj.HasExtensionDictionary Then Set oExDict = oAcadObj.GetExtensionDictionary MsgBox "Extension dictionary attached." & vbLf & _ "Number of entries in the extension dictionary: " & _ oExDict.Count Else MsgBox "No extension dictionary attached." ' If the extension dictionary doesn't exist, it is added Set oExDict = oAcadObj.GetExtensionDictionary End If End If End Sub

If the example code is executed, a message box is displayed, indicating whether an extension dictionary exists for the last object in model space. If the extension dictionary exists, the number of entries in the extension dictionary is returned; otherwise, the extension dictionary is added by the GetExtensionDictionary method. Once the extension dictionary is attached to the object, you can then add an Xrecord or nested dictionary to the object's extension dictionary. You'll learn how to add information to a custom dictionary in the next section.

Storing Information in a Custom Dictionary

After a custom dictionary has been created, you add entries to that custom dictionary using the AddObject or AddXrecord method of the AcadDictionary object. The AddObject method allows you to add an object based on the AcDbDictionaryRecord class that is part of the ObjectARX and Managed.NET APIs, which Autodesk supports for AutoCAD. The AcDbDictionaryRecord class or AcadDictionaryRecord object isn't available from the AutoCAD Object library. In Chapter 29, I explained how to use the AddObject method to create a new table style.

When storing information in a dictionary, use the AddXrecord method to add a new Xrecord to the dictionary. The AddXrecord method accepts a string that represents the name of the entry to add and returns an AcadXrecord object. The name of the entry must be unique to the dictionary.

The following code statements add an Xrecord with the name XR1 to the dictionary named MY_CUSTOM_DICTIONARY. The data assigned to the Xrecord contains a string (DXF group code 1), a coordinate value (DXF group code 10), and an integer (DXF group code 71).

; Add the Xrecord to the dictionary Dim oXRec As AcadXRecord Set oXRec = oDict.AddXRecord("XR1") ' Define the data types array for the Xrecord Dim nXdTypes(2) As Integer nXdTypes(0) = 1: nXdTypes(1) = 10: nXdTypes(2) = 71 ' Define a point list Dim dPT(2) As Double dPT(0) = 5: dPT(1) = 5: dPT(2) = 0 ' Define the data values array for the Xrecord Dim vXdVals(2) As Variant vXdVals(0) = "Custom string" vXdVals(1) = dPT vXdVals(2) = 11 ' Add the arrays to the Xrecord oXRec.SetXRecordData nXdTypes, vXdVals

If you need to make a change to the data contained in an Xrecord, you use the GetXRecordData method of the AcadXrecord object to get the data type and value arrays of the data stored in the Xrecord. Once you have the two arrays, you can modify their values by using the same steps you used to modify Xdata in the「Querying and Modifying the Xdata Attached to an Object」section earlier in this chapter.

Managing Custom Dictionaries and Entries

After a dictionary or Xrecord has been created and attached, you can change its name, remove it, or replace it. You can freely rename and remove the dictionaries you create; those created by AutoCAD can also be renamed and removed. I recommend being cautious about renaming or removing dictionaries created by other features in the AutoCAD program because doing so could cause problems. Not all dictionaries and entries of a dictionary can be removed; if an entry is referenced by another object, it can't be removed.

The name of an AcadDictionary object can be changed using its Name property, and the name of an entry in a dictionary can be changed using the Rename method of the AcadDictionary object. The Rename method expects two strings: the current name and the new name. The following shows the syntax of the Rename method:

object.Rename oldName, newName

An AcadDictionary object can be removed using its Delete method, and the Remove method of the AcadDictionary object can be used to remove an entry from a dictionary. The Remove method expects a string that represents the name of the entry you want to remove from the dictionary. An AcadObject object is returned by the Remove method that contains the object or Xrecord that is being removed. The following shows the syntax of the Remove method:

retVal = object.Remove(entryName)

Here are examples that rename and remove a custom dictionary:

' Renames MY_CUSTOM_DICTIONARY to MY_DICTIONARY Dim oDict As AcadDictionary Set oDict = ThisDrawing.Dictionaries("MY_CUSTOM_DICTIONARY") oDict.Name = "MY_DICTIONARY" ' Removes MY_DICTIONARY Dim oDict As AcadDictionary Set oDict = ThisDrawing.Dictionaries("MY_DICTIONARY") oDict.Delete

Here are examples that rename and remove a dictionary entry:

' Gets the dictionary MY_CUSTOM_DICTIONARY Dim oDict As AcadDictionary Set oDict = ThisDrawing.Dictionaries("MY_CUSTOM_DICTIONARY") ' Renames the entry XR1 to XR_1 oDict.Rename "XR1", "XR_1" ' Removes the entry XR_1 oDict.Remove "XR_1"

If you are storing objects and not Xrecords in a dictionary, you can use the Replace method of the AcadDictionary object to replace an object in an entry. The Replace method expects a string that represents the name of the entry you want to replace in the dictionary, and it also expects the new object that should replace the existing object. The following shows the syntax of the Replace method:

object.Replace entryName, newObject

Storing Information in the Windows Registry

The AutoCAD program stores information and setting values using many different methods. Some are proprietary; others are industry standard. Most setting values are stored as part of the drawing using system variables, Xdata, or custom dictionaries. Those settings that aren't stored with the drawing are, for the most part, stored with the AutoCAD user profile. The AutoCAD user profile is maintained in the Windows Registry.

You learned how to work with system variables in Chapter 26,「Interacting with the Application and Documents Objects.」I covered Xdata and custom dictionaries earlier in this chapter.

Creating and Querying Keys and Values

You can create and query values in the Windows Registry. The values that you can access in the Windows Registry aren't just related to AutoCAD but are those managed by Windows and other installed applications. The Windows Registry is organized into three main areas (known as hive keys but most commonly just keys). These keys are as follows:

HKEY_CLASSES_ROOT The HKEY_CLASSES_ROOT key contains settings related to file extensions and ActiveX libraries that are registered with the local machine. The settings are available to any user logged on to the machine and require elevated or administrative rights to change.

HKEY_LOCAL_MACHINE The HKEY_LOCAL_MACHINE key contains settings related to the software or hardware configuration of the local machine. The settings are available to any user logged on to the machine and require elevated or administrative rights to change.

HKEY_CURRENT_USER The HKEY_CURRENT_USER key contains settings related to software and hardware that don't impact the installation of software or the hardware configuration of the local machine. Typically, the settings in this key are driven by the choices made while using a software program. These settings are available only to the user who is currently logged into Windows.

You might occasionally query values in the HKEY_CLASSES_ROOT and HKEY_LOCAL_MACHINE keys, but the programs you create should treat the values under these keys as read-only. The values in these keys are typically set by an application installer. The HKEY_CURRENT_USER key is where you should store any values you want to access between AutoCAD sessions. The values of the HKEY_CURRENT_USER key can be queried and added as needed by your programs.

There are three approaches to accessing values in the Windows Registry. The simplest is to use the SaveSetting and GetSetting functions that are part of the VBA programming language. These methods access values under the following location in the Windows Registry:

HKEY_CURRENT_USER\Software\VB and VBA Program Settings

The SaveSetting function allows you to save a string to the Windows Registry under a user-specified application, section, and key name. Once a value has been stored, you use the GetSetting function, which expects the application, section, and key name of the value you want to query.

The following shows the syntax of the SaveSetting and GetSetting functions:

SaveSetting appName, section, key, value retVal = GetSetting(appName, section, key [, defaultValue])

The arguments are as follows:

appName The appName argument is a string that specifies the subkey under the VB and VBA Program Settings in the Windows Registry that you want to access.

section The section argument is a string that specifies the key under the key represented by the appName argument.

key The key argument is a string that specifies the key under the key represented by the section argument.

value The value argument is the string value that you want to store under the key specified. Use an empty string ("") to access the value of the key named (Default).

defaultValue The defaultValue argument is an optional string value that should be returned if the key specified doesn't exist.

Here are some examples of writing and reading values to and from the Windows Registry:

' Creates a new key with the value of 5.5 under the application ' named CompanyABC123, in a section named HexBolt, and a key named Width SaveSetting "CompanyABC123", "HexBolt", "Width", "5.5" ' Gets the value of the key CompanyABC123\HexBolt\Width ' If the key doesn't exist, a default value of 5.0 is returned Dim sWidth As String sWidth = GetSetting("CompanyABC123", "HexBolt", "Width", "5.0")

The GetSetting function requires you to know the name of the value you want to read, but there are times when you might want to read all values under a key. You can use the GetAllSettings function to get the names of all the values under a key. The GetAllSettings function returns a two-dimensional array that contains the key names and their values.

Here is the syntax of the GetAllSettings function:

retVal = GetAllSettings(appName, section)

The appName and section arguments are the same as previously described for the SaveSetting and GetSetting functions.

The following code statements list the keys and their values under HKEY_CURRENT_USER\Software\VB and VBA Program Settings \CompanyABC123\HexBolt:

Dim vKeys As Variant, nCnt As Integer ' Query the settings under CompanyABC123\HexBolt vKeys = GetAllSettings("CompanyABC123", "HexBolt") ' Step through the two-dimensional array For nCnt = LBound(vKeys, 1) To UBound(vKeys, 1) MsgBox "Key: " & CStr(vKeys(nCnt, 0)) & vbLf & _ "Value: " & CStr(vKeys(nCnt, 1)) Next nCnt

If you need to query or create values in other areas of the Windows Registry, you can use the Windows Script Host Object Model, which is an external programming library that can be referenced into your VBA project. The WshShell object contained in the library has the functions RegRead, RegWrite, and RegDelete. In addition to the Windows Script Host Object Model programming library, the Win32 API contains a range of Windows Registry functions that can be used to create, read, and delete keys in any area. You can learn more about the Win32 API functions that are related to the Windows Registry at http://support.microsoft.com/kb/145679. I explain how to work with additional programming libraries and the Win32 API in Chapter 35.

TIP

You can access the settings stored in the Windows Registry for the AutoCAD programs installed on your workstation by reading the keys under HKEY_CURRENT_USER\Software\Autodesk\AutoCAD.

Editing and Removing Keys and Values

You can update the data of a value under a key or remove a key or value that is no longer needed. You update a value by using the SaveSetting function, whereas you use the DeleteSetting function to remove a key or value.

Here is the syntax of the DeleteSetting function:

DeleteSetting appName [, section] [, key]

The appName, section, and key arguments are the same as previously described for the SaveSetting and GetSetting functions. The section and key arguments are optional for the DeleteSetting function.

The following code statement deletes the sections and keys under HKEY_CURRENT_USER\Software\VB and VBA Program Settings \CompanyABC123:

' Removes the settings under the key CompanyABC123 DeleteSetting "CompanyABC123" ' Removes the Width value from under key CompanyABC123\HexBolt DeleteSetting "CompanyABC123", "HexBolt", "Width"

Exercise: Storing Custom Values for the Room Labels Program

In this section, you will modify the VBA project named RoomLabel that was introduced in Chapter 30,「Working with Blocks and External References.」The RoomLabel project creates and inserts a room label block into a drawing. The modifications that you will make to the project will allow you to identify the room label block in the drawing and to store values in the Windows Registry and in a custom dictionary.

When the room label block is inserted, Xdata is attached to the block reference and allows you to use it as a way to locate the room label blocks in the drawing. The program lets you choose a starting (or next) number and a prefix. These values are stored as part of the drawing, allowing the program to continue where it last left off, and they can be stored in the Windows Registry as the default values to use when the program is executed for the first time in a drawing.

The key concepts covered in this exercise are as follows:

Attaching Xdata to an Object Extended data (or Xdata) can be used to store custom information with a graphical or nongraphical object. Once attached, the information can be used to filter out objects with specific Xdata values and even manage objects differently through custom programs.

Setting and Querying Information in the Windows Registry The Windows Registry allows you to store values so they can be persisted between AutoCAD sessions and accessed no matter which drawing is current.

Creating and Storing Information in a Custom Dictionary Values assigned to variables in a drawing are temporary, but you can use custom dictionaries to persist values across drawing sessions. The values stored in a drawing can then be recovered by your programs after the drawing is closed and reopened, similar to how system variables work.

NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Creating and Querying Blocks」section of Chapter 30. If you didn't complete these exercises, do so now or start with the ch32_roomlabel.dvb and ch32_building_plan.dwg sample files available for download from www.sybex.com/go/autocadcustomization. These sample files should be placed in the MyCustomFiles folder within the Documents (or My Documents) folder, or in the location you are using to store the custom program files. Once the files are stored on your system, remove ch32_ from the name of the DVB file.

Attaching Xdata to the Room Label Block after Insertion

Chapter 30 was the last chapter in which any changes were made to the RoomLabel project. At that time, you implemented functionality that created and inserted the room label block, and even set the label value for the attribute in the block. Here you'll modify the RoomLabel_InsertBlkRef procedure so that it attaches some Xdata to the block reference that is inserted into the drawing. The Xdata will help you identify the room label blocks inserted with the RoomLabel project.

The following steps show how to modify the RoomLabel_InsertBlkRef procedure:

Load the RoomLabel.dvb file into the AutoCAD drawing environment and display the VBA Editor.

In the VBA Editor, in the Project Explorer, double-click the basRoomLabel component.

In the code editor window, scroll to the code statement that starts with Private Sub RoomLabel_InsertBlkRef.

Type the code shown in bold; the comments are here for your information and don't need to be typed: ' Changes the attribute value of the "ROOM#" ChangeAttValue oBlkRef, vInsPt, "ROOM#", sLabelValue ' Create and attach Xdata to assist in selecting Room Labels ' Define the data types array for the Xdata Dim nXdTypes(1) As Integer nXdTypes(0) = 1001: nXdTypes(1) = 1000 ' Define the data values array for the Xdata Dim vXdVals(1) As Variant vXdVals(0) = "ACP_RoomLabel": vXdVals(1) = "Room label block" ' Attach the Xdata to the block reference oBlkRef.SetXData nXdTypes, vXdVals End Sub

Click File Save.

Revising the Main RoomLabel Procedure to Use the Windows Registry

The changes you make to the RoomLabel procedure determine which values are used when the procedure is initialized the first time it is executed in a drawing. Previously, the default values were defined in the procedure, but with the changes they can be stored in the Windows Registry.

Follow these steps to update the Global declaration in the basRoomLabel component:

In the VBA Editor, in the Project Explorer, double-click the basRoomLabel component.

In the code editor window, scroll to the top of the code editor window.

Remove the code shown in bold:Private myUtilities As New clsUtilities ' Constant for the removal of the "Command: " prompt msg Const removeCmdPrompt As String = vbBack & vbBack & vbBack & _ vbBack & vbBack & vbBack & _ vbBack & vbBack & vbBack & vbLf Private g_nLastNumber As Integer Private g_sLastPrefix As String

Click File Save.

The following steps explain how to get the last number and prefix from the Windows Registry:

In the code editor window, scroll to the code statement that starts with Public Sub RoomLabel().

In the procedure, locate and select the code statements shown in bold:On Error Resume Next ' Set the default values Dim nLastNumber As Integer, sLastPrefix As String If g_nLastNumber <> 0 Then nLastNumber = g_nLastNumber sLastPrefix = g_sLastPrefix Else nLastNumber = 101 sLastPrefix = "L" End If ' Display current values ThisDrawing.Utility.Prompt removeCmdPrompt & _ "Prefix: " & sLastPrefix & _ vbTab & "Number: " & CStr(nLastNumber)

Type the bold code that follows; the comments are here for your information and don't need to be typed:Dim nLastNumber As Integer, sLastPrefix As String ' Check to see if the defaults have been previously ' stored in the Windows Registry nLastNumber = CInt(GetSetting("ACP_Settings", "RoomLabel", _ "FirstNumber", "101")) sLastPrefix = GetSetting("ACP_Settings", "RoomLabel", _ "Prefix", "L")

In the code editor window, still in the RoomLabel procedure, scroll down and locate the following code statement:ThisDrawing.Utility.InitializeUserInput 0, "Number Prefix"

Revise the code statements in bold; you are adding a new option named Save:basePt = Null ' Set up default keywords ThisDrawing.Utility.InitializeUserInput 0, "Number Prefix Save" ' Prompt for a base point, number, or prefix value basePt = ThisDrawing.Utility.GetPoint(, _ removeCmdPrompt & "Specify point for room label (" & _ sLastPrefix & CStr(nLastNumber) & _ ") or change [Number/Prefix/Save]: ") ' If an error occurs, the user entered a keyword or pressed Enter

In the code editor window, still in the RoomLabel procedure, scroll down a few lines to the Select Case sKeyword code statement.

Type the code shown in bold; the comments are here for your information and don't need to be typed: Case "Prefix" sLastPrefix = ThisDrawing.Utility. _ GetString(False, removeCmdPrompt & _ "Enter new room number prefix <" & _ sLastPrefix & ">: ") Case "Save" ThisDrawing.Utility.InitializeUserInput 0, "Yes No" Dim sSaveToDefaults As String sSaveToDefaults = ThisDrawing.Utility. _ GetKeyword(removeCmdPrompt & _ "Save current number and prefix " & _ "as defaults [Yes/No] <Yes>: ") If UCase(sSaveToDefaults) = "YES" Or _ sSaveToDefaults = "" Then ' Save the current room number SaveSetting "ACP_Settings", "RoomLabel", _ "FirstNumber", CStr(nLastNumber) ' Save the current prefix SaveSetting "ACP_Settings", "RoomLabel", _ "Prefix", sLastPrefix End If End Select

In the code editor window, still in the RoomLabel procedure, scroll to the End Sub code statement at the end of the RoomLabel procedure.

Remove the bold text that follows: Loop Until IsNull(basePt) = True And sKeyword = "" ' Store the latest values in the global variables g_nLastNumber = nLastNumber g_sLastPrefix = sLastPrefix End Sub

Click File Save.

Testing the Changes to the RoomLabel Procedure

The following steps explain how to use the changes made to the RoomLabel procedure:

Switch to the AutoCAD application window.

Open Ch32_Building_Plan.dwg. Figure 32.2 shows the plan drawing of the office building that is in the drawing.

At the Command prompt, type vbarun and press Enter.

When the Macros dialog box opens, select the RoolLabel.dvb!basRoomLabel.RoomLabel macro from the list and click Run.

At the Specify point for room label (L101) or change [Number/Prefix/Save]: prompt, specify a point inside the room in the lower-left corner of the building. The room label definition block, Plan_RoomLabel_Anno layer, and My_Custom_Program_Settings custom dictionary are created the first time the RoomLabel procedure is used. The RoomLabel block definition should look like Figure 32.3 when inserted into the drawing.

At the Specify point for room label (L101) or change [Number/Prefix/Save]: prompt, type n and press Enter.

At the Enter new room number <102>: prompt, type 105 and press Enter.

At the Specify point for room label (L105) or change [Number/Prefix/Save]: prompt, type p and press Enter.

At the Enter new room number prefix <L>: prompt, type R and press Enter.

At the Specify point for room label (R105) or change [Number/Prefix/Save]: prompt, specify a point in the large open area in the middle of the building. The new room label is marked as R105.

Figure 32.2 Plan view of the office building

Figure 32.3 Inserted RoomLabel block

These steps show how to save a new default prefix and starting number:

At the Specify point for room label (R105) or change [Number/Prefix/Save]: prompt, type n and press Enter.

At the Enter new room number <105>: prompt, type 101 and press Enter.

At the Specify point for room label (R101) or change [Number/Prefix/Save]: prompt, type p and press Enter.

At the Enter new room number prefix <P>: prompt, type F and press Enter.

At the Specify point for room label (F101) or change [Number/Prefix/Save]: prompt, type s and press Enter.

At the Save current number and prefix as defaults [Yes/No] <Yes>: prompt, press Enter.

Press Enter again to exit the RoomLabel procedure.

Create a new drawing and execute the RoomLabel procedure. The starting value is F101. You can change the prefix and number without affecting the default values used each time the program is started.

Execute the RoomLabel procedure again. You should notice that the program starts numbering once again with the default values stored in the Windows Registry. This is as expected since you removed the use of the global variables to hold the last number and prefix. You will address this problem in the next section by writing the last number and prefix to a custom dictionary to persist values in the drawing.

Discard the changes to Ch32_Building_Plan.dwg and the new drawing file.

Persisting Values for the Room Label Procedure with a Custom Dictionary

Instead of using global variables that are lost after a drawing is closed, sometimes it is beneficial to persist values in a drawing for use when the program is executed again. A custom dictionary will be used to persist the last number and prefix used between drawing sessions.

The following steps explain how to add support for storing values in a custom dictionary:

Switch to the VBA Editor.

In the VBA Editor, in the Project Explorer double-click the basRoomLabel component.

In the code editor window, scroll up to the code statement that starts with Public Sub RoomLabel().

In the procedure, type the bold text that follows; the comments are here for your information and don't need to be typed:nLastNumber = CInt(GetSetting("ACP_Settings", "RoomLabel", _ "FirstNumber", "101")) sLastPrefix = GetSetting("ACP_Settings", "RoomLabel", _ "Prefix", "L") ' Gets the custom dictionary "My_Custom_Program_Settings" if it exists Dim oDict As AcadDictionary Set oDict = ThisDrawing.Dictionaries("My_Custom_Program_Settings") Dim oXrecRL As AcadXRecord Dim nXdType(1) As Integer, vXdValues(1) As Variant ' If the dictionary exists, get the previous values If Not oDict Is Nothing Then Set oXrecRL = oDict("RoomLabel") If Not oXrecRL Is Nothing Then Dim vXdType As Variant, vXdValue As Variant oXrecRL.GetXRecordData vXdType, vXdValue Dim nCnt As Integer For nCnt = 0 To UBound(vXdType) Select Case vXdType(nCnt) Case 1 sLastPrefix = vXdValue(nCnt) Case 71 nLastNumber = vXdValue(nCnt) End Select Next End If Else ' Create the dictionary Set oDict = ThisDrawing.Dictionaries.Add("My_Custom_Program_Settings") ' Add the default record Set oXrecRL = oDict.AddXRecord("RoomLabel") nXdType(0) = 1: vXdValues(0) = sLastPrefix nXdType(1) = 71: vXdValues(1) = nLastNumber oXrecRL.SetXRecordData nXdType, vXdValues End If Err.Clear ' Display current values ThisDrawing.Utility.Prompt removeCmdPrompt & _ "Prefix: " & sLastPrefix & _ vbTab & "Number: " & CStr(nLastNumber)

In the code editor window, still in the RoomLabel procedure, scroll to the End Sub code statement at the end of the RoomLabel procedure.

Type the bold text that follows; the comments are here for your information and don't need to be typed: End If ' If a base point was specified, then insert a block reference If IsNull(basePt) = False Then RoomLabel_InsertBlkRef basePt, sLastPrefix & CStr(nLastNumber) ' Increment number by 1 nLastNumber = nLastNumber + 1 ' Update the Xrecord nXdType(0) = 1: vXdValues(0) = sLastPrefix nXdType(1) = 71: vXdValues(1) = nLastNumber oXrecRL.SetXRecordData nXdType, vXdValues End If Loop Until IsNull(basePt) = True And sKeyword = "" End Sub

Click File Save.

Retesting the RoomLabel Procedure

Follow these steps to test the changes made to the RoomLabel procedure:

Switch to the AutoCAD application window.

Open Ch32_Building_Plan.dwg.

At the Command prompt, type vbarun and press Enter.

When the Macros dialog box opens, select the RoolLabel.dvb!basRoomLabel.RoomLabel macro from the list and click Run.

At the Specify point for room label (F101) or change [Number/Prefix/Save]: prompt, specify a point inside the room in the lower-left corner of the building.

Place two other room label blocks.

Save the drawing with the name RoomLabel Test - VBA.dwg , and then close the file.

Reopen the RoomLabel Test - VBA.dwg file.

Execute the RoomLabel procedure and press F2. Notice the current values being used are 104 for the number and a prefix of F, which were the current values before closing the drawing.

Add additional room labels. Keep the drawing file open when done.

Selecting Room Label Blocks

As I mentioned earlier, Xdata can be used to select the room label blocks placed with the RoomLabel procedure. Here, you'll create a new procedure named SelectRoomLabels, which creates a selection set with only the selected room label blocks. The room label blocks can then be selected using the Previous selection option at any Select objects: prompt.

The following steps show how to add the SelectRoomLabels procedure:

Switch to the VBA Editor.

In the VBA Editor, in the Project Explorer double-click the basRoomLabel component.

In the code editor window, scroll to the end of the code editor window and click after the last code statement. Press Enter twice.

Type the following text; the comments are here for your information and don't need to be typed:Sub SelectRoomLabels() On Error Resume Next ' Get the select set named SSRoomLabel if it exists Dim oSSet As AcadSelectionSet Set oSSet = ThisDrawing.SelectionSets("SSRoomLabel") If Err Then Set oSSet = ThisDrawing.SelectionSets.Add("SSRoomLabel") End If ' Define the data types array for the Xdata Dim nXdTypes(0) As Integer nXdTypes(0) = 1001 ' Define the data values array for the Xdata Dim vXdVals(0) As Variant vXdVals(0) = "ACP_RoomLabel" ThisDrawing.Utility.Prompt _ removeCmdPrompt & _ "Select objects to filter on room labels: " ' Prompt the user to select objects to filter oSSet.SelectOnScreen nXdTypes, vXdVals ThisDrawing.Utility.Prompt _ removeCmdPrompt & _ "Use the Previous selection method to select room labels." & _ vbLf ' Remove the selection set oSSet.Delete End Sub

Click File Save.

The following steps explain how to test the SelectRoomLabels procedure:

Switch to the AutoCAD application window.

If you closed the RoomLabel Test - VBA.dwg file from the previous section, reopen it now.

At the Command prompt, type vbarun and press Enter.

