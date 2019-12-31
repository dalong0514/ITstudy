Select Adds objects to a selection set by selection mode: all objects, crossing window, last object added to a drawing, previous selected objects, or window. The method expects a selection mode that is a constant value from the AcSelect enumerator, and two optional arrays of three doubles that represent points in the drawing area.

SelectAtPoint Adds an object to a selection set at a point in the drawing; the object selected is the topmost in the draw order at that point. The method expects an array of three doubles that represents a point in the drawing area.

SelectByPolygon Adds objects to a selection set by selection mode: crossing polygon, fence, or window polygon. The method expects a selection mode that is a constant value from the AcSelect enumerator, and an array of doubles that represents multiple point values in the drawing area.

The Select, SelectAtPoint, and SelectByPolygon methods support object selection filtering with two optional arguments. I discuss object selection filtering in the next section. For more information on adding objects to a selection set with the Select, SelectAtPoint, and SelectByPolygon methods, see the AutoCAD Help system.

Although adding objects manually to a selection set has its benefits, it is more common to prompt the user to select the objects that should be modified or queried. The SelectOnScreen method of an AcadSelectionSet object allows the user to interactively select objects in the drawing area using the standard selection methods. The SelectOnScreen method also supports object selection filtering.

The following shows the syntax of the SelectOnScreen method:

object.SelectOnScreen([filterType, filterData])

Its arguments are as follows:

object The object argument represents the AcadSelectionSet object.

filterType The filterType argument is an optional array of integers that represents the DXF code groups that you want to filter objects on.

filterData The filterData argument is an optional array of variants that represents the values that you want to filter objects on.

I explain how to define the arrays used to filter objects during selection in the「Filtering Objects」section later in this chapter.

Objects are typically only added to a selection set, but they can also be removed from a selection set. You might want to remove one or more objects from a selection set that don't meet certain criteria. One or more objects can be removed from a selection set with the RemoveItems method. The RemoveItems method is similar to the AddItems method, and it accepts an array of objects that should be removed from the selection set.

The following example prompts the user to select objects using the SelectOnScreen method, and adds the first and last objects in the drawing to the selection set named NewSS with the AddItems and Select methods. The last object is also removed to demonstrate the use of the RemoveItems method.

' Prompt the user for objects ThisDrawing.Utility.Prompt vbLf & "Select objects to list: " oSSet.SelectOnScreen ' Add the first object in model space to the selection set Dim arObj(0) As AcadEntity Set arObj(0) = ThisDrawing.ModelSpace(0) oSSet.AddItems arObj ' Add the last object in the drawing to the selection set oSSet.Select acSelectionSetLast ' Remove the last object in model space from ' the selection set Set arObj(0) = ThisDrawing.ModelSpace( _ ThisDrawing.ModelSpace.Count - 1) oSSet.RemoveItems arObj

Accessing Objects in a Selection Set

A selection set isn't any different than any other collection object. You can use the Item function of an AcadSelectionSet object to get a specific object in a selection set or a For statement to step through all the objects in a selection set. In addition to the Item function and For statement, you can use a While statement in combination with the Item function to step through all the objects in a selection set. The Count property of an AcadSelectionSet object lets you know how many objects are in a selection set; this value can be helpful when you are using the Item function or a While statement.

The following example steps through all the objects in a selection set and outputs the object name for each object to the command-line window:

' Step through each object in the selection set and output ' the name of each object with the Prompt method Dim oEnt As AcadEntity ThisDrawing.Utility.Prompt vbLf & "Objects in " & _ oSSet.Name & " selection set:" For Each oEnt In oSSet ThisDrawing.Utility.Prompt vbLf & " " & oEnt.ObjectName Next oEnt ' Return the user to a blank Command prompt ThisDrawing.Utility.Prompt vbLf & ""

Here is an example of the output that might be displayed in the command-line window:

Objects in NewSS selection set: AcDbLine AcDbLine AcDbLine AcDbLine AcDbCircle AcDbArc

NOTE

In most cases, you can step through a selection set and make changes to each object one at a time. However, there are three methods of an AcadSelectionSet object that can be used to manipulate all objects in a selection set. The Erase method can be used to remove all objects in a selection set from a drawing. The Highlight method can be used to highlight or unhighlight an object. The Update method is used to regenerate all the objects in the selection set.

Filtering Objects

The particular objects that are added to a selection set can be affected through the use of an optional selection filter. A selection filter can be used to limit the objects added to a selection set by type and property values. Filtering is defined by the use of two arrays with the same number of elements. Selection filters are supported by the Select, SelectAtPoint, SelectByPolygon, and SelectOnScreen methods of the AcadSelectionSet object. The two arrays are passed to the filterType and filterData arguments of the methods.

The first array of a selection filter contains only integer values that represent DXF group codes and the types of data that will be used to restrict object selection. The second array defines the actual values for the selection filter. The type of data to filter on can be a string, integer, or double, among other data types. When selection filter is used, objects are only selected when all conditions of the selection set are True.

For example, if you filter on circles that are placed on the Holes layer, only circles placed on the Holes layer will be added to the selection set. Lines and other objects placed on the layer named Holes will not be selected; circles on other layers will not be selected.

The following is an example of a selection filter that can be used to select the circles placed on the layer named Holes:

Dim arDXFCodes(1) As Integer, arValues(1) As Variant ' Object type arDXFCodes(0) = 0: arValues(0) = "circle" ' Object layer arDXFCodes(1) = 8: arValues(1) = "Holes" ' Prompt for and restrict the selection of objects with a selection filter ThisDrawing.Utility.Prompt vbLf & "Select circles with a radius between 1 and 5: " oSSet.SelectOnScreen arDXFCodes, arValues

In the previous example, the arDXFCodes variable contains an array of integer values that includes two DXF group codes. The DXF group code 0 represents an object's type, and the DXF group code 8 represents the name of the layer which an object is placed. For more information on DXF group codes, use the AutoCAD Help system and search on the keywords「dxf codes.」

Object types and properties are not the only values that can be used to filter objects—a filter can also include logical grouping and comparison operators. Logical grouping and comparison operators allow for the selection of several object types, such as both text and MText objects, or allow for the selection of circles with a radius in a given range. Logical grouping and comparison operators are specified by string values with the DXF group code -4. For example, the following filter allows for the selection of circles with a radius in the range of 1 to 5:

Dim arDXFCodes(6) As Integer, arValues(6) As Variant ' Object type arDXFCodes(0) = 0: arValues(0) = "circle" ' Start AND grouping arDXFCodes(1) = -4: arValues(1) = "<and" ' Select circles with a radius between 1 and 5 arDXFCodes(2) = -4: arValues(2) = "<=" arDXFCodes(3) = 40: arValues(3) = 5# arDXFCodes(4) = -4: arValues(4) = ">=" arDXFCodes(5) = 40: arValues(5) = 1# ' End AND grouping arDXFCodes(6) = -4: arValues(6) = "and>"

Selection filters support four logical grouping operators: and, or, not, and xor. Each logical grouping operator used in a selection filter must have a beginning and ending operator. Beginning operators start with the character < and ending operators end with the character >. In addition to logical operators, you can use seven different comparison operators in a selection filter to evaluate the value of a property: = (equal to), != (not equal to), < (less than), > (greater than), <= (less than or equal to), >= (greater than or equal to), and * (wildcard for string comparisons).

In addition to object types and property values, selection filters can filter on objects with attached extended data (Xdata). Xdata is used to add custom information to an object in a drawing. I discuss working with and selecting objects that have attached Xdata in Chapter 32,「Storing and Retrieving Custom Data.」

Performing Geometric Calculations

The math functions of the VBA programming language are great for calculating numeric values based on other numeric values, but they aren't specifically designed to work with geometric values. With the AutoCAD Object library and standard math formulas, you can calculate the following:

A new coordinate value based on a starting point, and at a specific angle and distance

The distance value between two points

An angular value from the X-axis

Calculating a Coordinate Value

When you create or modify an object, you frequently need to calculate a new point based on another point on or near an existing graphical object. Although you could prompt the user to specify a point you might need, that could lead to unnecessary steps in a workflow, so it is always best to calculate any and all points that you can with minimal input from the user.

The PolarPoint function returns a 2D or 3D point in the current UCS, based on an angle and distance from a point. The result of the PolarPoint function is similar to specifying a relative polar coordinate from the AutoCAD user interface.

The following shows the syntax of the PolarPoint function:

retVal = object.PolarPoint(point, angle, distance)

Its arguments are as follows:

retVal The retVal argument represents the variant value that contains the new coordinate point that was calculated as an array of two or three doubles.

object The object argument represents the AcadUtility object.

point The point argument represents the coordinate point in the drawing that you want to calculate the new point from. If a 2D point is specified, a 2D point is returned; specifying a 3D point results in a 3D point being returned.

angle The angle argument represents the angle, in radians, by which the new point should be separated from the coordinate point specified with the point argument.

distance The distance argument represents the distance at which the new point should be calculated from the point argument and along the angle specified by the angle argument.

The following is an example of the PolarPoint function:

Dim oUtil As AcadUtility Set oUtil = ThisDrawing.Utility Dim pt1(2) As Double pt1(0) = 0: pt1(1) = 0: pt1(2) = 0 Dim vPt As Variant vPt = oUtil.PolarPoint(pt1, 0.785398, 5#) ' Returns the calculated coordinate value oUtil.Prompt vbLf & "X=" & CStr(vPt(0)) & _ " Y=" & CStr(vPt(1)) & _ " Z=" & CStr(vPt(2)) & vbLf X=3.53553448362991 Y=3.53553332823547 Z=0

NOTE

A coordinate value can be translated from one coordinate system to another with the TranslateCoordinates function. For example, you can convert a coordinate value from the World Coordinate System (WCS) to a User Coordinate System (UCS). Refer to the AutoCAD Help system for information on the TranslateCoordinates function.

Measuring the Distance Between Two Points

The AutoCAD Object library doesn't provide a function to calculate the distance between two points; instead you must rely on a geometric formula. The geometric formula is shown in Figure 28.4, and the VBA equivalent is as follows:

' Distance of 3D points Sqr((X2 - X1) ^ 2 + (Y2 - Y1) ^ 2 + (Z2 - Z1) ^ 2)

Figure 28.4 Formula for calculating the distance between two points

If you need to calculate the distance between 2D points, the code statement in VBA might be as follows:

' Distance of 2D points Sqr((X2 - X1) ^ 2 + (Y2 - Y1) ^ 2)

Listing 28.2 shows a custom function named Distance that can be used to calculate the distance between two points in the drawing area. The value returned is a double number.

Listing 28.2: Calculating the distance between two points

Private Function Distance(Point1 As Variant, Point2 As Variant) As Double ' Check to see if the points are 2D or 3D If UBound(Point1) - LBound(Point1) = 1 Then ' Distance of 2D points Distance = Sqr((Point1(0) - Point2(0)) ^ 2 + _ (Point1(1) - Point2(1)) ^ 2) Else ' Distance of 3D points Distance = Sqr((Point1(0) - Point2(0)) ^ 2 + _ (Point1(1) - Point2(1)) ^ 2 + _ (Point1(2) - Point2(2)) ^ 2) End If End Function

Here is an example of using the custom Distance function from Listing 28.2:

Dim pt1(2) As Double, pt2(2) As Double pt1(0) = 0: pt1(1) = 0: pt1(2) = 0 pt2(0) = 2: pt2(1) = 2: pt2(2) = 2 ThisDrawing.Utility.Prompt vbLf & _ "Distance=" & CStr(Distance(pt1, pt2)) & vbLf Distance=3.46410161513775

Calculating an Angle

When you draw or modify an object, you commonly need to know the angle at which an object should be drawn in relationship to the X-axis or other objects in a drawing. The AngleFromXAxis function accepts two arrays of three elements that define the line from which you want to calculate the angular value.

The following shows the syntax of the AngleFromXAxis function:

retVal = object.AngleFromXAxis(fromPoint, toPoint)

Its arguments are as follows:

retVal The retVal argument represents the angular value expressed in radians from the X-axis. The value is returned as a double.

object The object argument represents the AcadUtility object.

fromPoint The fromPoint argument is an array of three doubles that defines the start point of the line.

toPoint The toPoint argument is an array of three doubles that defines the end point of the line.

The following is an example of the AngleFromXAxis function:

Dim oUtil As AcadUtility Set oUtil = ThisDrawing.Utility Dim pt1(2) As Double, pt2(2) As Double pt1(0) = 0: pt1(1) = 0: pt1(2) = 0 pt2(0) = 5: pt2(1) = 5: pt2(2) = 0 oUtil.Prompt vbLf & _ "Angle=" & CStr(oUtil.AngleFromXAxis(pt1, pt2)) & vbLf Angle=0.785398163397448

Changing the Current View

The view of model space can be adjusted to show a specific area of a drawing or the full extents of all objects in model space. You can adjust the area and magnification of the current view, and store a view that can later be restored in model space or applied to a floating viewport on a named layout. In addition to managing named views, you can divide model space into multiple viewports known as tiled viewports. Each tiled viewport can display a different view of model space and can be helpful when modeling in 3D. Visual styles can also be used to affect the way objects appear in a view or viewport.

Zooming and Panning the Current View

You can manipulate the current model space view by adjusting its scale and center in which objects should be displayed; this is typically known as zooming and panning. When you want to zoom or pan the current view, you will use the zoom-related methods of the AcadApplication object. You can get a reference to the AcadApplication object with the Application property of an AcadDocument or ThisDrawing object. Table 28.3 lists the different zoom-related methods that are available from the AcadApplication object.

Table 28.3 Zoom-related methods

Method Description

ZoomAll Fills the current view with the extents of the drawing limits or all graphical objects depending on which is largest.

ZoomCenter Defines the center point of the current view, and increases or decreases the objects based on a specified magnification.

ZoomExtents Fills the current view with the extents of all graphical objects.

ZoomPickWindow Prompts the user for two points. The points define the area of the drawing and magnification in which the objects should be displayed.

ZoomPrevious Restores the most recent view.

ZoomScaled Increases or decreases the magnification of the current view; the center point of the view remains unchanged.

ZoomWindow Defines the area of the drawing and magnification in which the objects should be displayed.

For specifics on the arguments that each of the methods listed in Table 28.3 expects, see the AutoCAD Help system. The following is an example of the ZoomExtents method:

' Set model space current ThisDrawing.ActiveSpace = acModelSpace Dim dPt1(2) As Double, dPt2(2) As Double dPt1(0) = 1: dPt1(1) = 5: dPt1(2) = 0 dPt2(0) = 7: dPt2(1) = 3: dPt2(2) = 0 ' Add a line to model space ThisDrawing.ModelSpace.AddLine dPt1, dPt2 ' Zoom to the extents of model space ThisDrawing.Application.ZoomExtents

Although it might not seem obvious, you can use the ZoomCenter method to pan the current view. The following example gets the center point and magnification of the current view with the viewctr and viewsize system variables. Once the center point is obtained from the viewctr system variable, the point is adjusted to pan the current view 10 units to the right. The new center point and current magnification are passed to the ZoomCenter method to cause the current view to be panned and not zoomed.

' Get the current values of the viewctr ' and viewsize system variables Dim vViewPt As Variant, dViewSize As Double vViewPt = ThisDrawing.GetVariable("viewctr") dViewSize = ThisDrawing.GetVariable("viewsize") ' Pan the viewport 10 drawing units to the right vViewPt(0) = vViewPt(0) - 10 ThisDrawing.Application.ZoomCenter vViewPt, dViewSize

Zooming to an Object

There are times when you might want to zoom to a specific object in a drawing. Maybe you want to update the information in a table or dimension text. There is no ZoomObject method like there is an Object option for the zoom command. However, you can use a combination of the ZoomWindow and ZoomScaled methods to zoom to the extents of an object. The extents of an object can be obtained using the GetBoundingBox method that all graphical objects have in common. I discuss the GetBoundingBox method in Bonus Chapter 1,「Working with 2D Objects and Object Properties.」

The following code statements zoom to the extents of the first object in model space:

' Gets the first object in model space Dim oEnt As AcadEntity Set oEnt = ThisDrawing.ModelSpace(0) ' Gets the extents of the objects' bounding box Dim vExtMin As Variant, vExtMax As Variant oEnt.GetBoundingBox vExtMin, vExtMax ' Zooms to the extents of the object ThisDrawing.Application.ZoomWindow vExtMin, vExtMax ' Zooms out by 5% ThisDrawing.Application.ZoomScaled 0.95, acZoomScaledRelative

Working with Model Space Viewports

The Model tab in the AutoCAD user interface is used to view and interact with the graphical objects of the model space block. By default, the objects in model space are displayed in a single tiled viewport named *Active. Tiled viewports aren't the same as the viewports displayed on a named layout tab; they do share some properties and methods in common, though. You use tiled viewports to view different areas or angles of the same drawing, whereas you use viewports on a named layout to control which model space objects are plotted, the angle in which objects are viewed, and at which scale. I discuss the viewports that can be added to a named layout in Chapter 31,「Outputting Drawings.」

Each tiled viewport in model space can be split into two or more smaller viewports, but only one viewport can be active at a time. Unlike with the AutoCAD user interface, you can't join viewports back together again once they have been split; instead, you need to create a new configuration that reflects the desired layout and set it as current. Use the name of the active viewport to determine which viewports are part of the active viewport configuration.

You can access the active model space viewport with the ActiveViewport property of an AcadDocument or Thisdrawing object. The ActiveViewport property returns an AcadViewport object that represents a tiled viewport in model space. Not only is the ActiveViewport property used to get the active viewport, but it is also used to set a viewport configuration as active. Once you have the active viewport, you can modify the drafting aids that are viewport specific along with the current model view.

In addition to working with the active viewport, you can create and manage named viewport configurations with the AcadViewports collection object. You use the Add function of the AcadViewports collection object to create a new viewport configuration, and the Item function or a For statement to step through all the viewports of a viewport configuration. Named viewport configurations that are no longer needed can be removed using the DeleteConfiguration method on the AcadViewports collection object, not the Delete method of the AcadViewport object like other collection objects.

The following code statements split the current active viewport vertically into two viewports and then change some of the drafting aids related to the active viewport:

' Get the name of the current viewport configuration Dim sVpName As String sVpName = ThisDrawing.ActiveViewport.Name ' Create a new viewport with the same name ' as the active viewport Dim oVPort As AcadViewport Set oVPort = ThisDrawing.Viewports.Add(sVpName) ' Split the active viewport vertically oVPort.Split acViewport2Vertical ' Turn off the grid and snap in the new viewport oVPort.GridOn = False oVPort.SnapOn = False ' Turn on Ortho mode oVPort.OrthoOn = True ' Set the viewport active ThisDrawing.ActiveViewport = oVPort ' Set snap style to rectangular ThisDrawing.SetVariable "snapstyl", 0

Using the AcadViewport object returned by the Add function of the AcadViewports collection object or the ActiveViewport property, you can obtain information about the current view and some of the drafting aids that are enabled. Table 28.4 lists the properties of the AcadViewport object.

Table 28.4 Properties related to an AcadViewport object

Property Description

ArcSmoothness Specifies the smoothness for curved model space objects. Enter a value from 1 to 20,000.

Center Specifies an array of three double values that represents the center point of the view in the viewport.

Direction Specifies the view direction of the model space objects. View direction is expressed as an array of three double values.

GridOn Specifies whether grid display is enabled. A Boolean value of True indicates the grid display is on.

Height Specifies the height of the view in drawing units, not pixels. This value corresponds to the magnification factor of the current view. The value returned or expected is a double.

LowerLeftCorner Specifies an array of two double values that represents the lower-left corner of the viewport.

Name Specifies the name of the configuration in which the viewport is associated.

OrthoOn Specifies whether Ortho mode is enabled. A Boolean value of True indicates Ortho mode is on.

SnapBasePoint Specifies an array of two double values that represents the base point of the snap grid for the viewport.

SnapOn Specifies whether snapping is enabled. A Boolean value of True indicates snapping is on.

SnapRotationAngle Specifies the angle in which the snap grid is rotated. The value returned or expected is a double that represents the angle in radians.

Target Specifies the target point of the current view in the viewport. View direction is expressed as an array of three double values.

UCSIconAtOrigin Specifies whether the UCS icon is displayed at the origin of the drawing. A Boolean value of True indicates the UCS icon is displayed at the drawing's origin, or in the lower-left corner of the drawing area if the origin is off the screen.

UCSIconOn Specifies whether the UCS icon is displayed in the drawing area. A Boolean value of True indicates the UCS icon is displayed.

UpperRightCorner Specifies an array of two double values that represents the upper-right corner of the viewport.

Width Specifies the width of the view in drawing units, not pixels. This value corresponds to the magnification factor of the current view. The value returned or expected is a double.

In addition to the GridOn and SnapOn properties that allow you to turn on grid display and enable snapping to grid, you can use the GetGridSpacing and GetSnapSpacing methods to get the current grid and snap spacing. Both of the methods expect two arguments that are used to return the X and Y spacing values for the grid or snap. To change the spacing of the grid and snap, use the SetGridSpacing and SetSnapSpacing methods, which expect two double values that represent the X and Y spacing values for the grid or snap.

A named view can be assigned to a model space viewport using the SetView function. I explain how to work with named views in the next section. For more information on working with tiled viewports, see the AutoCAD Help system.

Creating and Managing Named Views

Named views are areas in a drawing with a user-defined name that can later be restored to improve navigation around a large drawing and even help to output various areas of a drawing with viewports on a named layout. Many users associate named views with 3D modeling, but they can be just as helpful with designs that consist of just 2D objects. Named views are stored in the AcadViews collection object, which you can access from the Views property of the AcadDocument or ThisDrawing object. Each view stored in the AcadViews collection object is represented by an AcadView object.

You can create a new named view with the Add function of the AcadViews collection object. If you want to work with an existing view, use the Item function of the AcadViews collection object or a For statement to get the AcadView object that represents the named view you want to modify or query. Once a named view has been created, you can pass the AcadView object to the SetView method of an AcadViewport or AcadPViewport object to restore the view. If you no longer need a named view, you can use the Delete method of the AcadView object to be removed.

Table 28.5 lists the properties of an AcadView object that can be used to modify or query a named view.

Table 28.5 Properties related to an AcadView object

Property Description

CategoryName Specifies a category name for the view. The category name is used to group multiple views on the ShowMotion bar when it is pinned and controls how named views are organized in sheet sets.

Center Specifies an array of three double values that represents the center point of the view.

Direction Specifies the direction from which the objects in the model space should be viewed. View direction is expressed as an array of three double values.

HasVpAssociation Specifies whether the view is associated with a viewport. A Boolean value of True indicates that the view is associated with a viewport placed from the Sheet Set Manager.

Height Specifies the height of the view in drawing units, not pixels. The value returned or expected is a double.

LayerState Specifies the name of the layer state that should be restored when the view is restored. I discussed layer states in Chapter 27.

LayoutId Specifies the object ID of the layout that the view is associated with. Model space views can't be used on a named layout and a named layout can't be used on the Model tab.

Name Specifies the name of the named view.

Target Specifies the target point of the view. The target is expressed as an array of three double values.

Width Specifies the width of the view in drawing units, not pixels. This value corresponds to the magnification factor of the view. The value returned or expected is a double.

For more information on working with named views, see the AutoCAD Help system.

Applying Visual Styles

Visual styles affect the way 2D and 3D objects are displayed on screen and how they are plotted. The AutoCAD Object library offers very limited support when it comes to managing visual styles. Using the AutoCAD Object library, you can obtain a listing of which visual styles are stored in a drawing by accessing the ACAD_VisualStyles dictionary. I explain how to work with dictionaries in Chapter 32.

If you need to create or update a visual style using the AutoCAD Object library, set as current the visual style that you want to base the new visual style on or modify with the vscurrent command. Once the visual style is current, modify the values of the system variables related to visual styles. Many of the system variables that are related to visual styles begin with the prefix VS.

Use the SetVariable and GetVariable methods to work with the system variables. After the variables have been updated, use the vssave command to save the new visual style or overwrite an existing visual style with the same name. You can assign a visual style to model space with the vscurrent command, or use the VisualStyle property of an AcadPViewport object, which represents a floating viewport on a named layout. I explain how to work with floating viewports in Chapter 31.

Exercise: Getting Input from the User to Draw the Plate

In this section, you will continue to build on the DrawPlate project that was introduced in Chapter 27. The key concepts I cover in this exercise are as follows:

Requesting Input Input functions can be used to get values from the user at the Command prompt.

Creating a New Point Value Values from different point lists can be used to create new coordinate values.

Using Conditional Statements Conditional statements are a great way to check the data provided by a user.

Looping Until a Condition Is Met Loops allow you to execute a set of expressions a specific number of times or while a condition remains True. You can use a loop to keep allowing the user to provide input.

NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Creating, Querying, and Modifying Objects」section of Chapter 27. If you didn't complete the steps, do so now or start with the ch28_drawplate.dvb sample file available for download from www.sybex.com/go/autocadcustomization. Place the sample file in the MyCustomFiles folder within the Documents (or My Documents) folder, or the location where you are storing the DVB files. Also, remove ch28_ from the filename before you begin working.

Revising the CLI_DrawPlate Function

The changes to the CLI_DrawPlate function implement the use of user input to get points and distances. The points and distances provided by the user are used to specify the size and location of the plate in the drawing. The following steps have you replace the CLI_DrawPlate function with a newer version in the drawplate.dvb project file:

Load the drawplate.dvb file into the AutoCAD drawing environment and display the VBA Editor.

In the VBA Editor, in the Project Explorer, double-click the basDrawPlate component.

In the code editor window, replace all of the code statements in the code module with the following code statements; the comments are here for your information and don't need to be typed:Private myUtilities As New clsUtilities Private g_drawplate_width As Double Private g_drawplate_height As Double ' Constants for PI and removal of the "Command: " prompt msg Const PI As Double = 3.14159265358979 Const removeCmdPrompt As String = vbBack & vbBack & vbBack & _ vbBack & vbBack & vbBack & _ vbBack & vbBack & vbBack & vbLf Public Sub CLI_DrawPlate() Dim oLyr As AcadLayer On Error Resume Next Dim sysvarNames As Variant, sysvarVals As Variant sysvarNames = Array("nomutt", "clayer", "textstyle") ' Store the current value of system variables to be restored later sysvarVals = myUtilities.GetSysvars(sysvarNames) ' Set the current value of system variables myUtilities.SetSysvars sysvarNames, Array(0, "0", "STANDARD") ' Define the width and height for the plate If g_drawplate_width = 0 Then g_drawplate_width = 5# If g_drawplate_height = 0 Then g_drawplate_height = 2.75 ' Get recently used values from the global variables Dim width As Double, height As Double width = g_drawplate_width height = g_drawplate_height ' Prompt for the current values ThisDrawing.Utility.Prompt removeCmdPrompt & "Current width: " & _ Format(ThisDrawing.Utility. _ RealToString(width, acDecimal, 4), _ "0.0000") & _ " Current height: " & _ Format(ThisDrawing.Utility. _ RealToString(height, acDecimal, 4), _ "0.0000") & _ vbLf Dim basePt As Variant ' Continue to ask for input until a point is provided Do Dim sKeyword As String sKeyword = "" basePt = Null ' Set up default keywords ThisDrawing.Utility.InitializeUserInput 0, "Width Height" ' Prompt for a base point, width, or height value basePt = ThisDrawing.Utility.GetPoint(, _ removeCmdPrompt & _ "Specify base point for plate or [Width/Height]: ") ' If an error occurs, the user entered a keyword or pressed Enter If Err Then Err.Clear sKeyword = ThisDrawing.Utility.GetInput Select Case sKeyword Case "Width" width = ThisDrawing.Utility. _ GetDistance(, removeCmdPrompt & _ "Specify the width of the plate <" & _ Format(ThisDrawing.Utility. _ RealToString(width, acDecimal, 4), _ "0.0000") & _ ">: ") Case "Height" height = ThisDrawing.Utility. _ GetDistance(, removeCmdPrompt & _ "Specify the height of the plate <" & _ Format(ThisDrawing.Utility. _ RealToString(height, acDecimal, 4), _ "0.0000") & _ ">: ") End Select End If ' If a base point was specified, then draw the plate If IsNull(basePt) = False Then ' Create the layer named Plate or set it current Set oLyr = myUtilities.CreateLayer("Plate", acBlue) ThisDrawing.ActiveLayer = oLyr ' Create the array that will hold the point list ' used to draw the outline of the plate Dim dPtList(7) As Double dPtList(0) = basePt(0): dPtList(1) = basePt(1) dPtList(2) = basePt(0) + width: dPtList(3) = basePt(1) dPtList(4) = basePt(0) + width: dPtList(5) = basePt(1) + height dPtList(6) = basePt(0): dPtList(7) = basePt(1) + height ' Draw the rectangle myUtilities.CreateRectangle dPtList ' Create the layer named Holes or set it current Set oLyr = myUtilities.CreateLayer("Holes", acRed) ThisDrawing.ActiveLayer = oLyr Dim cenPt1 As Variant, cenPt2 As Variant Dim cenPt3 As Variant, cenPt4 As Variant Dim dAng As Double, dDist As Double ' Calculate the placement of the circle in the lower-left corner. ' Calculate a new point at 45 degrees and distance of 0.7071 from ' the base point of the rectangle. cenPt1 = ThisDrawing.Utility.PolarPoint(basePt, PI / 4, 0.7071) myUtilities.CreateCircle cenPt1, 0.1875 ' Calculate the distance between the first ' and second corners of the rectangle. dDist = myUtilities.Calc2DDistance(dPtList(0), dPtList(1), _ dPtList(2), dPtList(3)) ' Calculate and place the circle in the lower-right ' corner of the rectangle. dAng = myUtilities.Atn2(dPtList(2) - dPtList(0), _ dPtList(3) - dPtList(1)) cenPt2 = ThisDrawing.Utility.PolarPoint(cenPt1, dAng, dDist - 1) myUtilities.CreateCircle cenPt2, 0.1875 ' Calculate the distance between the second ' and third corners of the rectangle. dDist = myUtilities.Calc2DDistance(dPtList(2), dPtList(3), _ dPtList(4), dPtList(5)) ' Calculate and place the circle in the upper-right ' corner of the rectangle. dAng = myUtilities.Atn2(dPtList(4) - dPtList(2), _ dPtList(5) - dPtList(3)) cenPt3 = ThisDrawing.Utility.PolarPoint(cenPt2, dAng, dDist - 1) myUtilities.CreateCircle cenPt3, 0.1875 ' Calculate and place the circle in the upper-left ' corner of the rectangle. dAng = myUtilities.Atn2(dPtList(6) - dPtList(0), _ dPtList(7) - dPtList(1)) cenPt4 = ThisDrawing.Utility.PolarPoint(cenPt1, dAng, dDist - 1) myUtilities.CreateCircle cenPt4, 0.1875 End If Loop Until IsNull(basePt) = True And sKeyword = "" ' Restore the saved system variable values myUtilities.SetSysvars sysvarNames, sysvarVals ' Save previous values to global variables g_drawplate_width = width g_drawplate_height = height End Sub

Click File Save.

Revising the Utilities Class

The changes to the Utilities class add a new constant named PI that holds the mathematical value of PI and introduce two new functions: Calc2DDistance and Atn2. The Calc2DDistance function returns a double value that is the distance between two 2D points, and the Atn2 function returns an angular value in radians between two points. The following steps have you adding the constant value and two functions to the clsUtilities class module:

In the VBA Editor, in the Project Explorer, double-click the clsUtilities component.

In the code editor window, click to the left of the first comment or code statement and press Enter twice.

Click in the first blank line of the code module and type the following code statement:Const PI As Double = 3.14159265358979

Scroll to the bottom of the code editor window and click to the right of the last code statement. Press Enter twice.

Type the following code statements; the comments are here for your information and don't need to be typed:' Returns the 2D distance between two points. ' Function expects four double numbers that represent the ' X and Y values of the two points. Public Function Calc2DDistance(X1, Y1, X2, Y2) As Double Calc2DDistance = Sqr((X2 - X1) ^ 2 + (Y2 - Y1) ^ 2) End Function ' Returns the radians angular value between the differences of the ' X and Y delta values. ' Function expects the X and Y delta differences between two points. Function Atn2(dDeltaX As Double, dDeltaY As Double) As Double Select Case dDeltaX Case Is > 0 Atn2 = Atn(dDeltaY / dDeltaX) Case Is < 0 Atn2 = Atn(dDeltaY / dDeltaX) + PI * Sgn(dDeltaY) If dDeltaY = 0 Then Atn2 = Atn2 + PI Case Is = 0 Atn2 = (PI / 2) * Sgn(dDeltaY) End Select End Function

Click File Save.

The following steps explain how to export the clsUtilities class module from the drawplate.dvb file:

In the VBA Editor, in the Project Explorer, right-click the clsUtilities component and choose Export File.

When the Export File dialog box opens, browse to the MyCustomFiles folder.

Keep the default filename of clsUtilities.cls and click Save. The clsUtilities.cls file is exported from the DrawPlate project.

In the Confirm Save As dialog box, click Yes to replace the previously exported version of the Utilities class.

Using the Revised drawplate Function

Now that that the drawplate.dvb project file has been revised, you can test the changes that have been made. The following steps explain how to use the revised drawplate function:

Switch to AutoCAD by clicking on its icon in the Windows taskbar or click View AutoCAD from the menu bar in the Visual Basic Editor.

In AutoCAD, at the Command prompt, type vbarun and press Enter.

When the Macros dialog box opens, select the DrawPlate.dvb!basDrawPlate.CLI_DrawPlate macro from the list and click Run.

Press F2 to expand the command-line window. The current width and height values for the plate are displayed in the command-line history.Current width: 5.0000 Current height: 2.7500

At the Specify base point for the plate or [Width/Height]: prompt, type w and press Enter.

At the Specify the width of the plate <5.0000>: prompt, type 3 and press Enter.

At the Specify base point for the plate or [Width/Height]: prompt, type h and press Enter.

At the Specify the height of the plate <2.7500>: prompt, type 4 and press Enter.

At the Specify base point for the plate or [Width/Height]: prompt, pick a point in the drawing area to draw the plate and holes based on the width and height values specified.

Type 'zoom and press Enter, and then type e and press Enter. Figure 28.5 shows a number of different plates that were drawn at various sizes with the CLI_DrawPlate macro.

Continue trying the CLI_DrawPlate macro with different input values.

Press Enter to exit the macro when you are done.

Figure 28.5 Completed plates

Chapter 29

Annotating Objects

Annotation plays an important role in most designs; it is used to communicate measurements and design features that might require explanation. The Autodesk® AutoCAD® program offers a variety of annotation objects that include stand-alone text, dimensions, leaders, and tables. Each annotation object type is affected by specially named styles that control its appearance. Blocks can also include attributes, which are a form of annotation that can be updated when an instance of a block reference is inserted into a drawing. I discuss blocks and attributes in Chapter 30,「Working with Blocks and External References.」

In this chapter, you will learn to create and modify stand-alone text objects and other types of annotation objects, such as dimensions, leaders, and tables. Along with creating and modifying annotation objects, you will also learn to control the appearance of annotation objects with named styles and create field values that can be used in multiline text objects and table cells.

Working with Text

Stand-alone text is often used for adding labels below a viewport and detail, general disclaimers, and revision comments. You can create two types of stand-alone text: single-line and multiline. Single-line text (Text) is used when you only need to add a few words or a short comment to a drawing, whereas multiline text (MText) is used when you want to create a bullet list or a paragraph of text.

MText supports a wider range of formatting options and features than single-line text. Even though MText is designed for formatting text in paragraphs, it can be used in place of single-line text. The appearance of stand-alone text is controlled by its assigned text style.

Creating and Modifying Text

Single-line text and MText is represented by the AcadText and AcadMText objects. The AddText function allows you to create a single-line text object based on a text string, an insertion point, and text height. The text height passed to the AddText function is used only if the Height property of the text style assigned to the text object is set to 0. I discuss text styles in the「Controlling Text with Text Styles」section later in this chapter. You use the AddMText function to create a new MText. The AddMText function is similar to the AddText function with one exception: the AddMText function expects a value that defines the width of the bounding box of the text area instead of a value that defines the height of the text object. The following shows the syntax of the AddText and AddMText functions:

retVal = object.AddText(textString, insertionPoint, height) retVal = object.AddMText(insertionPoint, width, textString)

Their arguments are as follows:

retVal The retVal argument represents the new AcadText or AcadMText object returned by the function.

object The object argument represents an AcadModelSpace, AcadpaperSpace, or AcadBlock collection object.

textString The textString argument is a string that contains the text that should be added to the text object. The text string can contain special character sequences to format text and insert special characters; see the「Formatting a Text String」section later in this chapter for some of the supported character sequences.

insertionPoint The insertionPoint argument is an array of three doubles that defines the insertion point of the text object.

height or width The height and width arguments are doubles that define the height of the text for an AcadText object or overall width of the boundary box of an AcadMText object.

The following code statements add two new single-line text objects to model space (see Figure 29.1):

' Defines the insertion point and height for the text object Dim dInsPt(2) As Double, dHeight As Double dInsPt(0) = 0: dInsPt(1) = 0: dInsPt(2) = 0 dHeight = 0.25 ' Creates a new text object Dim oText As AcadText Set oText = ThisDrawing.ModelSpace.AddText( _ "NOTE: ADA requires a minimum turn radius of", dInsPt, dHeight) ' Adjusts the insertion point for the second text object dInsPt(0) = 0: dInsPt(1) = dHeight * -1.6065: dInsPt(2) = 0 Set oText = ThisDrawing.ModelSpace.AddText( _ "60"" (1525mm) diameter for wheelchairs.", dInsPt, dHeight)

Figure 29.1 Basic note created with single-line text

The following code statements add an MText object to model space (see Figure 29.2):

' Defines the insertion point and width for the text object Dim dInsPt(2) As Double, dWidth As Double dInsPt(0) = 0: dInsPt(1) = 0: dInsPt(2) = 0 dWidth = 5.5 ' Creates a new text object Dim oMText As AcadMText Set oMText = ThisDrawing.ModelSpace.AddMText(dInsPt, dWidth, _ "NOTE: ADA requires a minimum turn radius of " & _ "60"" (1525mm) diameter for wheelchairs.")

Figure 29.2 Basic note created with an MText object

The properties of the AcadText and AcadMText objects can be used to adjust the justification of the text, the direction in which the text is drawn, and much more. For information on the properties of the two text objects, see the AutoCAD Help system or the Object Browser in the VBA Editor. Like other graphical objects, the AcadText and AcadMText objects also inherit the properties and methods of an AcadEntity object, which I discussed in Chapter 27,「Creating and Modifying Drawing Objects.」

The following code statements add a new single-line text object to model space and center the text:

' Defines the insertion point and height for the text object Dim dInsPt(2) As Double, dHeight As Double dInsPt(0) = 5: dInsPt(1) = 5: dInsPt(2) = 0 dHeight = 0.25 ' Creates a new text object Dim oText As AcadText Set oText = ThisDrawing.ModelSpace.AddText( _ "Center Justified", dInsPt, dHeight) ' Sets the justification of the text to middle center oText.Alignment = acAlignmentMiddleCenter ' Moves the alignment point of the justified text ' to the original insertion point oText.TextAlignmentPoint = dInsPt

NOTE

After changing the justification of an AcadText object, you will need to update the TextAlignmentPoint property to move the location to the correct position.

In addition to the methods the AcadText and AcadMText objects inherit from an AcadEntity object, the objects also support a function named FieldCode. I explain the FieldCode function in the「Creating Fields」section later in this chapter.

Formatting a Text String

Alphanumeric characters are used to create the text string that an AcadText object displays, but how those characters are arranged can impact how the text appears. The use of the percent symbol has a special meaning in a text string. You use a percent symbol to indicate the use of special control codes and field values. Special control codes can be used to toggle underlining or overscoring for part or all of a text string and to insert special symbols. Table 29.1 lists the control codes that are supported in the text string of an AcadText object.

Table 29.1 Control codes for AcadText objects

Control code Description

%%c Adds a diameter symbol to the text.

%%d Adds a degree symbol to the text.

%%nnn Adds the ASCII character represented by the character value nnn. For example, %%169 adds the Copyright symbol.

%%o Toggles the use of overscoring. The first instance of %%o in a text string turns overscoring on, and the second turns it off.

%%p Adds a plus or minus symbol ( ± ) to the text.

%%u Toggles the use of underscoring. The first instance of %%u in a text string turns underscoring on, and the second turns it off.

%%% Adds a percent symbol to the text.

%< and >% Defines the start and end of a field value. I discuss working with field values in in the「Creating Fields」section later in this chapter.

The text string of an AcadMText object can be very basic, but it can be very complex as well. You can control the formatting of each character in a text string with special control codes. Unlike the special control codes that are supported by an AcadText object, those used by an AcadMText object are much more complicated and harder to figure out at first. However, the AutoCAD list command will be your friend if you want to create complexly formatted text strings.

The best process for learning how to format the text string of an AcadMText object is to use the mtext command in AutoCAD and create a sample text string that you want to create with your VBA macro. Once the MText object is added to the drawing, use the list command and look at the value after the Contents label in the output. For example, the following is an example of the output displayed by the list command for an MText object that contains a numbered list with three items (see Figure 29.3):

Contents: Numbered List\P\pxi-3,l3,t3;1. Item 1\P2. Item 2\P3. Item 3

Figure 29.3 Numbered list in an MText object

The long spaces in the example are actually tab characters. To create the numbered list shown in Figure 29.3 with VBA, the code statements would look like the following:

' Defines the insertion point and width for the MText object Dim dInsPt(2) As Double, dWidth As Double dInsPt(0) = 0: dInsPt(1) = 0: dInsPt(2) = 0 dWidth = 5.5 ' Creates a new MText object with a numbered list Dim oMText As AcadMText Set oMText = ThisDrawing.ModelSpace.AddMText(dInsPt, dWidth, _ "Numbered List\P\pxi-3,l3,t3;1." & vbTab & _ "Item 1\P2." & vbTab & "Item 2\P3." & vbTab & "Item 3")

Most of the control codes you will need to use take a combination of the list and mtext commands to initially figure out, but there a few control codes that are much easier to add to the text string of MText. The AcadMText object supports the %%d, %%c, and %%p control codes that are also supported by the AcadText object. If you want to add a special character to a text string of an AcadMText object, use the control sequence of \U+nnn, which adds a character based on its Unicode value instead of the %%nnn that an AcadText object supports. For example, to insert the Copyright symbol you would use the sequence of \U+00A9.

TIP

You can use the Windows Character Map to get the Unicode value of a character for a specific font. If you need to use a character from the font that isn't assigned to the text style applied to the MText object, you must provide the proper control codes to indicate the font you want to use for that character. For example, the following indicates that the Copyright symbol of the Arial font should be added:

{\fArial|b0|i0|c186|p34;\U+00A9}

As I mentioned before, it is best to use the mtext command to first create an MText object and then use the list command to see the contents of that object. Then you will know the code control codes and sequences required.

Checking Spelling

The AutoCAD Object library doesn't support the ability to check the spelling or grammar of a text string. However, with some help from the Microsoft Word Object library you can check the spelling and grammar of a text string. The following outlines an approach you can take using the Word Object library to check the spelling or grammar of a text string:

Create a Word Document object.

Add the text you want to check.

Perform the spelling and grammar check.

Update the text in the drawing.

Close and discard the changes to the Word Document object.

I introduce how to work with the Word Object library in Chapter 35,「Communicating with Other Applications.」

Controlling Text with Text Styles

Text styles are used to control the appearance of the characters in a text string for an AcadText or AcadMText object. Some of the characteristics that are controlled by a text style are font filename, bold and italic font faces, and character sets. A text style is represented by the AcadTextStyle object, and the text styles stored in a drawing are accessed from the AcadTextStyles collection object. Use the TextStyles property of an AcadDocument or ThisDrawing object to get a reference to the AcadTextStyles collection object.

Creating and Managing Text Styles

New text styles are created with the Add method of the AcadTextStyles collection object. The Add method of the AcadTextStyles collection object requires you to provide the name of the new text style and returns an AcadTextStyle object. The Item method of the AcadTextStyles collection object is used to get an existing text style in the drawing; if the text style doesn't exist, an error is generated. I discuss how to handle errors in Chapter 36,「Handling Errors and Deploying VBA Projects.」

The Item method accepts a string that represents the name of the text style you want to work with or an integer value. The integer value represents the index of the text style in the AcadTextStyles collection object you want to return. The index of the first text style in the drawing starts with 0, and the highest index is one less than the number of text styles in the AcadTextStyles collection object returned by the Count property. If you want to step through all the text styles in the drawing, you can use a For statement.

The following sample code statements check for the existence of a text style named General; if the text style doesn't exist, it is created:

On Error Resume Next ' Gets the TextStyles collection Dim oStyles As AcadTextStyles Set oStyles = ThisDrawing.TextStyles ' Gets the text style named General Dim oStyle As AcadTextStyle Set oStyle = oStyles("General") ' If an error is returned, create the text style If Err Then Err.Clear ' Creates a new text style Set oStyle = oStyles.Add("General") End If

NOTE

Although the Add method won't return an error if a text style with the same name already exists, I recommend using the Item method of the AcadTextStyles collection object to check whether a text style already exists.

After you have an AcadTextStyle object, you can get its current font and character set with the GetFont method. The SetFont method is used to set the font and character set among other settings of the text style. In addition to the GetFont and SetFont methods, you can use the fontFile and BigFontFile properties of the AcadTextStyle object to specify the TrueType font (TTF) and Shape (SHX) file that should be used by the text style. The BigFontFile property is helpful if you need to support the double-byte characters that are used mainly for Asian languages.

If you want text to be drawn at a specific height each time the text style is used, you set the height value to the Height property of the text style. Other properties of a text style allow you to specify the oblique angle and direction in which the text should be drawn, among other settings with the properties of the AcadTextStyle object. For information on the properties of the two text objects, see the AutoCAD Help system or the Object Browser in the VBA Editor.

NOTE

Text styles are used by dimension, mleader, and table styles. If a text style will be used by other named annotation styles, I recommend that you set the Height property of the text style to 0. When you use a height of 0, the referencing named annotation style has control over the final text height.

If you don't need a text style anymore, remove it from a drawing with the Delete method of the AcadTextStyle object and not the Delete method of the AcadTextStyles collection object. The PurgeAll method of an AcadDocument or ThisDrawing object can also be used to remove all unused text styles from a drawing. I discussed the PurgeAll method in Chapter 27.

The following sample code statements set the font of the text style assigned to the oStyle variable, enable boldface, and set the oblique angle to 10:

Dim sFont As String Dim bBold As Boolean, bItalic As Boolean Dim nCharSet As Long Dim nPitchandFamily As Long ' Sets the font, enables boldface, and assigns an ' oblique angle to the style based on the active style ThisDrawing.ActiveTextStyle.GetFont sFont, bBold, _ bItalic, nCharSet, nPitchandFamily oStyle.SetFont "Arial", True, False, nCharSet, nPitchandFamily oStyle.ObliqueAngle = 10

Assigning a Text Style

A text style can be assigned to an object directly or inherited by the active text style of the drawing. You assign a text style to an AcadText or AcadMText object with the StyleName property. The StyleName property returns or accepts a string that represents the name of current or the text style to be assigned. When a new text object is created, the text style applied is inherited from the ActiveTextStyle property of the AcadDocument or ThisDrawing object. The ActiveTextStyle property returns and expects an AcadTextStyle object.

NOTE

As an alternative to the ActiveTextStyle property, you can use the textstyle system variable. The textstyle system variable accepts a string that represents the name of the text style to be inherited by each newly created text object.

The following code statements assign the text style named General to the ActiveTextStyle property:

' Sets the General text style as the active text style Dim oStyle As AcadTextStyle Set oStyle = ThisDrawing.TextStyles("GENERAL") ThisDrawing.ActiveTextStyle = oStyle

Dimensioning Objects

Dimensions are annotation objects that show a measurement value in a drawing. The value in which a dimension displays depends on the type of dimension object created. A dimension can measure the linear distance between two points, the radial value of a circle or an arc, the X or Y value of a coordinate, the angle between two vectors, or the length of an angle. Similar to text objects, the appearance of a dimension is controlled by a dimension style. Dimension objects are graphical objects just like lines and circles, so they inherit properties and methods from AcadEntity. Dimensions also inherit properties from a class named AcadDimension.

Creating Dimensions

Nine types of dimensions can be created with the AutoCAD Object library and VBA. When you want to add a dimension object to a drawing, use one of the functions that begin with the name AddDim. The functions used to add a dimension object can be accessed from an AcadModelSPace, AcadPaperSpace, or AcadBlock collection object. Table 29.2 lists the functions that can be used to add a new dimension object.

Table 29.2 Functions used to create new dimensions

Function Description

AddDim3PointAngular Adds an angular dimension based on three points; same as that created with the dimangular command.

AddDimAligned Adds a linear dimension that is parallel to the two points specified; same as the dimaligned command.

AddDimAngular Adds an angular dimension based on two vectors; same as that created with the dimangular command.

AddDimArc Adds an arc length dimension based on the center of an arc and two points along the arc; same as that created with the dimarc command.

AddDimDiametric Adds a diametric dimension that reflects the diameter of a circle or an arc; same as that created with the dimdiameter command.

AddDimOrdinate Adds an ordinate dimension that displays the X or Y value of a coordinate; same as that created with the dimordinate command.

AddDimRadial Adds a radial dimension that reflects the radius of a circle or an arc; same as that created with the dimradius command.

AddDimRadialLarge Adds a radial dimension with a jogged line that indicates the radius of a circle or arc, but the dimension doesn't start at the center of the object dimensioned; same as that created with the dimjogged command.

AddDimRotated Adds a linear dimension that measures the distance between two points, but the dimension line of the dimension is rotated at a specified value; same as that created with the dimrotated command.

For specifics on the arguments that are required to add a dimension object, see the AutoCAD Help system or the Object Browser in the VBA Editor.

The following code statements add two circles, add a linear dimension between the center points of the two circles with the AddDimRotated function, and finally, add a diameter dimension to one of the circles with the AddDiametric function (see Figure 29.4):

' Defines the center point of the circles Dim dCenPt1(2) As Double, dCenPt2(2) As Double dCenPt1(0) = 2.5: dCenPt1(1) = 1: dCenPt1(2) = 0 dCenPt2(0) = 5.5: dCenPt2(1) = 2: dCenPt2(2) = 0 ' Adds the two circles ThisDrawing.ModelSpace.AddCircle dCenPt1, 0.5 ThisDrawing.ModelSpace.AddCircle dCenPt2, 0.5 ' Adds the linear dimension Dim dDimPlace(2) As Double dDimPlace(0) = dCenPt2(0) - dCenPt1(0) dDimPlace(1) = dCenPt2(1) + 1: dDimPlace(2) = 0 Dim oDimRot As AcadDimRotated Set oDimRot = ThisDrawing.ModelSpace.AddDimRotated( _ dCenPt1, dCenPt2, dDimPlace, 0) ' Adds the diametric dimension Dim vDimChordPt1 As Variant vDimChordPt1 = ThisDrawing.Utility.PolarPoint( _ dCenPt1, -0.7854, 0.5) Dim vDimChordPt2 As Variant vDimChordPt2 = ThisDrawing.Utility.PolarPoint( _ dCenPt1, 0.7854 * 3, 0.5) Dim oDimDia As AcadDimDiametric Set oDimDia = ThisDrawing.ModelSpace.AddDimDiametric( _ vDimChordPt2, vDimChordPt1, 1)

Figure 29.4 Aligned and diametric dimensions showing the measurement values of two circles

After you create a dimension object, you can modify its properties. However, based on the properties that you modify, a dimension override might be applied. For example, if you change the value of the DimensionLineColor property and later make a change to the dimension style applied to the dimension, the color of the dimension line will not be updated unless you remove the override from the dimension.

NOTE

Dimensions created with the AutoCAD Object library are not associative; the dimension isn't updated if the objects that the dimension measures are changed. If you want to create associative dimensions, consider using the SendCommand or PostCommand method with the appropriate command sequence.

Formatting Dimensions with Styles

Dimension styles are stored in and accessed from the AcadDimStyles collection object. Each dimension style in a drawing is represented by an AcadDimStyle object. A new dimension style can be added to a drawing with the Add method of the collection object. The Add method expects a string that contains the name of the new dimension type to be created and returns an AcadDimStyle object. The Item method of the AcadDimStyles collection object is used to get an existing dimension style in the drawing; if the dimension style doesn't exist, an error is generated. I discuss how to handle errors in Chapter 36.

The Item method accepts a string that represents the name of the dimension style you want to work with or an integer value. The integer value represents the index of the dimension style in the AcadDimStyles collection object you want to return. The index of the first dimension style in the drawing starts with 0, and the highest index is one less than the number of dimension styles in the AcadDimStyles collection object returned by the Count property. If you want to step through all the dimension styles in the drawing, you can use a For statement.

The following sample code statements check for the existence of a dimension style named Arch24; if the dimension style doesn't exist, it is created:

On Error Resume Next ' Gets the DimStyles collection Dim oStyles As AcadDimStyles Set oStyles = ThisDrawing.DimStyles ' Gets the dimension style named Arch24 Dim oStyle As AcadDimStyle Set oStyle = oStyles("Arch24") ' If an error is returned, create the dimension style If Err Then Err.Clear ' Creates a new dimension style Set oStyle = oStyles.Add("Arch24") End If

NOTE

Although the Add method won't return an error if a text style with the same name already exists, I recommend using the Item method of the AcadDimStyles collection object to check to see whether a dimension style already exists.

After you create or decide to modify an AcadDimStyle object, how to go about modifying the dimension style might not be immediately obvious. From the AutoCAD user interface, you commonly would use the Dimension Style Manager (displayed with the ddim command), but at the Command prompt, you could use the -dimstyle command.

Although you could use the -dimstyle command, the workflow with VBA is to modify the values of dimension-related system variables with the SetVariable method of an AcadDocument or a ThisDrawing object, and then use the CopyFrom method of the AcadDimStyle object to copy the values of the dimension system variables to the dimension style. Modifying the dimension system variables of a drawing will result in the creation of drawing-level dimension overrides. When creating a new dimension variable, I recommend storing the name of the current dimension style so it can be restored after you modify your dimension style.

Now, there is a problem that isn't easy to resolve: the preservation of drawing-level dimension overrides when modifying an existing dimension style. The reason is that when a dimension style is set as active, the previous drawing-level dimension variable overrides are lost. It is always best to restore the previous state of a drawing if you don't want to affect the current settings for the user.

The only way to preserve drawing-level dimension variable overrides is to create an array containing the current value of all dimension variables and then restore the values after the previous style has been set as active. An example of storing and restoring system variables for a number of system variables is shown in the「Setting the Values of Drafting-Related System Variables and Preferences」section of Chapter 26,「Interacting with the Application and Documents Objects.」

Here are code statements that demonstrate how to change the values of the dimblk and dimscale dimension system variables, copy the values of the dimension variables of the drawing to the dimension style named Arch24, and then restore the previous dimension style and dimension values:

' Store the current dimension style Dim oCurDimStyle As AcadDimStyle Set oCurDimStyle = ThisDrawing.ActiveDimStyle ' Store current values to override Dim vValues(1) As Variant vValues(0) = ThisDrawing.GetVariable("DIMBLK") vValues(1) = ThisDrawing.GetVariable("DIMSCALE") ' Change the DIMBLK and DIMSCALE system variable for the drawing ThisDrawing.SetVariable "DIMBLK", "ARCHTICK" ThisDrawing.SetVariable "DIMSCALE", 24# ' Create the new dimension style and copy the variable values from the drawing oStyle.CopyFrom ThisDrawing ' Restore the previous style Set ThisDrawing.ActiveDimStyle = oCurDimStyle ' Restore the values of the overridden variables If vValues(0) = "" Then ThisDrawing.SetVariable "DIMBLK", "." Else ThisDrawing.SetVariable "DIMBLK", vValues(0) End If ThisDrawing.SetVariable "DIMSCALE", vValues(1)

If you don't need a dimension style anymore, remove it from a drawing with the Delete method of the AcadDimStyle object and not the Delete method of the AcadDimStyles collection object. The PurgeAll method of an AcadDocument or ThisDrawing object can also be used to remove all unused dimension styles from a drawing. I discussed the PurgeAll method in Chapter 27.

Assigning a Dimension Style

You can change the dimension style of a dimension object after it has been added to a drawing with the StyleName property. The StyleName property returns or accepts a string that represents the name of the current or dimension style to be assigned. When a new dimension object is created, the dimension style applied is inherited from the ActiveDimStyle property of the AcadDocument or ThisDrawing object. The ActiveDimStyle property returns and expects an AcadDimStyle object.

NOTE

Unlike other Active* properties, the ActiveDimStyle property doesn't have a system variable alternative that can be used to set the default dimension style for new dimension objects. The dimstyle system variable can be used to get the name of the current dimension style.

The following code statements assign the dimension style named Arch24 to the ActiveDimStyle property:

' Sets the Arch24 text style as the active dimension style Dim oStyle As AcadDimStyle Set oStyle = ThisDrawing.DimStyles("ARCH24") ThisDrawing.ActiveDimStyle = oStyle

Creating and Modifying Geometric Tolerances

Geometric tolerances, also referred to as control frames, are used to display acceptable deviations of a form, location, or other measurements in mechanical designs. A geometric tolerance is represented by an AcadTolerance object. Similar to AcadMText objects, AcadTolerance objects accept text strings with control codes in them to define the appearance of the final object that is displayed in the drawing. The control codes that an AcadTolerance object accepts define the symbols, tolerance, and datum values that are displayed in the geometric tolerance object. I recommend using the AutoCAD tolerance and list commands to learn the control codes and text sequences that go into defining a geometric tolerance object.

The following is an example of the output displayed by the list command for a geometric tolerance object that contains a Parallelism symbol, with a tolerance value of 0.00125 and a datum value of B (see Figure 29.5).

Text {\Fgdt;f}%%v{\Fgdt;n}.00125%%v%%vB%%v%%v

Figure 29.5 Geometric tolerance object created with the AddTolerance function

To create a geometric tolerance value, use the AddTolerance function of an AcadModelSpace, AcadPaperSpace, or AcadBlock collection object. The geometric tolerance object shown in Figure 29.5 can be created with the following code statements:

' Defines the insertion point and direction vector ' for the Tolerance object Dim dInsPt(2) As Double, dDirVec(2) As Double dInsPt(0) = 2.5: dInsPt(1) = 2.5: dInsPt(2) = 0 dDirVec(0) = 1: dDirVec(1) = 0: dDirVec(2) = 0 ' Creates a new Tolerance object Dim oTol As AcadTolerance Set oTol = ThisDrawing.ModelSpace.AddTolerance( _ "{\Fgdt;f}%%v{\Fgdt;n}.00125%%v%%vB%%v%%v", dInsPt, dDirVec)

The text string, insertion point, and direction among other characteristics of a geometric object can be queried or modified using the properties and methods of the AcadTolerance object. Like AcadDimension objects, an AcadTolerance object inherits the way it looks by the dimension style it is assigned. When initially created, the geometric tolerance object is assigned the dimension style that is assigned to the ActiveDimStyle property, and the StyleName property of an AcadTolerance object can be used to assign the object a specific dimension style.

If you need to use geometric tolerance objects in your drawings, see the AutoCAD Help system or Object Browser in the VBA Editor for more information.

Adding Leaders

Leaders, also known as callouts, are used to bring attention to a feature in a drawing. A leader starts with an arrowhead that is connected to multiple straight segments or a spline. The end of a leader often includes an attachment: a text object that contains a label or descriptive text. An attachment could also be a geometric tolerance object or block reference. AutoCAD supports two types of leaders: multileader and legacy.

Multileaders are leaders that can be made up of multiple leader lines and one or more attachments. The attachment and leader lines behave as a single object with multileaders. Legacy leaders don't provide as much flexibility as multileaders. Leader lines and the attachment of a legacy leader can be connected to or separate from the leader object.

Working with Multileaders

Multileaders were introduced in AutoCAD 2008 to improve the workflow when working with leaders. A multileader object is represented by the AcadMLeader object in a drawing file. Their initial appearance is controlled by a multileader style. The methods and properties of an AcadMLeader object allow you to add and modify leader lines and the content of a multileader object.

In addition to modifying a multileader object as a whole, you can modify the appearance of each leader line attached to the multileader object. Along with methods and properties specific to the AcadMLeader object, an AcadMLeader object inherits properties and methods from an AcadEntity.

Placing and Modifying Multileaders

A multileader object is created with the AddMLeader function. The AddMLeader method is available from an AcadModelSpace, AcadPaperSpace, or AcadBlock collection object and returns an AcadMLeader object. When you create a leader with the AddMLeader function, you specify the vertices of the initial leader line for the multileader. The AddMLeader function also returns an index for the leader line. which is represented by an AcadMLeaderLeader.

When a multileader is added to a drawing, its appearance is inherited by the active multileader style. I explain how to define and manage multileader styles in the next section,「Defining Multileader Styles.」You will learn to apply a named multileader style in the「Assigning a Multileader Style」section.

The following code statements add a multileader with two leader lines and an attachment object of MText (see Figure 29.6):

' Defines the points of the first leader Dim dLeader1Pts(0 To 5) As Double dLeader1Pts(0) = 0.1326: dLeader1Pts(1) = 0.1326: dLeader1Pts(2) = 0 dLeader1Pts(3) = 1.1246: dLeader1Pts(4) = 2.1246: dLeader1Pts(5) = 0 ' Defines the points of the second leader Dim dLeader2Pts(0 To 5) As Double dLeader2Pts(0) = 0.1847: dLeader2Pts(1) = 1.7826: dLeader2Pts(2) = 0 dLeader2Pts(3) = 1.1246: dLeader2Pts(4) = 2.1246: dLeader2Pts(5) = 0 ' Adds the new multileader object Dim lLeaderIdx As Long Dim oMLeader As AcadMLeader Set oMLeader = ThisDrawing.ModelSpace.AddMLeader(dLeader1Pts, lLeaderIdx) ' Adds the second leader line oMLeader.AddLeaderLine lLeaderIdx, dLeader2Pts ' Attaches the MText object oMLeader.ContentType = acMTextContent oMLeader.TextString = "3/16""R"

Figure 29.6 Multileader with two leader lines

After placing a multileader object, you can refine the leader lines, content, and appearance of the object using its methods and properties. However, depending on the properties that you modify, a style override might be applied. For example, if you change the value of the ArrowheadBlock property and later make a change to the multileader style applied to the object, the arrowhead of the leader lines will not be updated unless you remove the Xdata attached to the multileader that represents the data associated with the override. I explain more about Xdata in Chapter 32,「Storing and Retrieving Custom Data.」

Defining Multileader Styles

