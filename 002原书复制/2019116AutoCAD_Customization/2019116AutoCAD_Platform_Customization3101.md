Multileader styles are not accessed directly through a collection object like AcadTextStyles for text styles and AcadDimStyles for dimension styles. Named multileader styles stored in a drawing are stored in the ACAD_MLEADERSTYLE dictionary, which is accessed from the AcadDictionaries collection object. Each multileader style in the ACAD_MLEADERSTYLE dictionary is represented by an AcadMLeaderStyle object.

Use the AddObject function to create a new multileader style and the GetObject function to get an existing object that is in the dictionary. When using the AddObject function, you must specify two strings: the first is the name of the style you want to create and the second is the class name of AcDbMLeaderStyle. You can learn more about working with dictionaries in Chapter 32.

The following code statements create a multileader style named Callouts if it doesn't already exist:

On Error Resume Next ' Gets the multileader styles dictionary Dim oDict As AcadDictionary Set oDict = ThisDrawing.Dictionaries.Item("ACAD_MLEADERSTYLE") ' If no error, continue If Not oDict Is Nothing Then ' Gets the multileader style named Callouts Dim oMLStyle As AcadMLeaderStyle Set oMLStyle = oDict.GetObject("Callouts") ' If an error is returned, create the multileader style If Err Then Err.Clear ' Creates a new dimension style Set oStyle = oDict.AddObject("Callouts", "AcDbMLeaderStyle") End If ' Defines the landing settings for the multileader style oMLStyle.EnableLanding = True oMLStyle.LandingGap = 0.1 End If

A multileader style that is no longer needed can be removed with the Remove method of the AcadDictionary object. For more information on the properties and methods of the AcadMLeaderStyle object, see the AutoCAD Help system or the Object Browser in the VBA Editor.

Assigning a Multileader Style

The active multileader style is assigned to a multileader when it is first added to a drawing, but the style assigned can be changed using the StyleName property. The StyleName property returns or accepts a string that represents the name of the current or multileader style to be assigned. When a new multileader object is created, the multileader style applied is inherited from the cmleaderstyle system variable of the drawing. You can use the SetVariable and GetVariable methods of an AcadDocument or a ThisDrawing object.

The following code statement assigns the multileader style named Callouts to the cmleaderstyle system variable:

' Sets the Callouts multileader style active ThisDrawing.SetVariable "cmleaderstyle", "callouts"

Creating and Modifying Legacy Leaders

Legacy leader objects are represented by an AcadLeader object and are added to a drawing with the AddLeader function. The AddLeader method is available from an AcadModelSpace, AcadPaperSpace, or AcadBlock collection object. When you create a leader with the AddLeader function, you can choose to add an attachment object or no attachment. The types of objects you can attach to an AcadLeader object are AcadMText, AcadTolerance, and AcadBlockReference. If you don't want to add an attachment to a leader object, pass the value of Nothing to the AddLeader function instead of the object that represents the attachment object.

Unlike multileader objects, legacy leader objects inherit their format and appearance from a dimension style. Use the StyleName property of the AcadLeader object to assign a dimension style to the leader. The properties of the leader object can also be used to create an override.

The leader object shown in Figure 29.7 can be created with the following code statements:

' Defines the points of the leader line Dim points(0 To 8) As Double points(0) = 0: points(1) = 0: points(2) = 0 points(3) = 0.717: points(4) = 1.0239: points(5) = 0 points(6) = 1.217: points(7) = 1.0239: points(8) = 0 ' Defines the insertion point and height for the text object Dim dInsPt(2) As Double, dHeight As Double dInsPt(0) = points(6): dInsPt(1) = points(7): dInsPt(2) = points(8) ' Creates a new text object Dim oMText As AcadMText Set oMText = ThisDrawing.ModelSpace.AddMText(dInsPt, 4#, _ "TYP (4) Drill Holes") ' Sets the justification of the text to middle left oMText.AttachmentPoint = acAttachmentPointMiddleLeft ' Moves the alignment point of the justified text ' to the original insertion point oMText.InsertionPoint = dInsPt Dim annotationObject As AcadObject Set annotationObject = oMText ' Creates the leader object in model space Dim leaderObj As AcadLeader Set leaderObj = ThisDrawing.ModelSpace.AddLeader(points, _ annotationObject, acLineWithArrow)

Figure 29.7 Legacy leader created with the AddLeader function

For more information on legacy leaders, search on AcadLeader in the AutoCAD Help system.

Organizing Data with Tables

Data in a drawing can often be presented in a tabular form with a table. Tables can be helpful in creating schedules or a bill of materials (BOM), which provides a quantitative listing of the objects in a drawing. Tables were introduced in AutoCAD 2005 to simplify the process of creating tables, which commonly had been made up of lines and single-line text objects. A table object is represented by the AcadTable object and the initial appearance is controlled by a table style.

The methods and properties of an AcadTable object allow you to add and modify the content of a table object. Just like other graphical objects, the AcadTable object inherits some of its properties and methods from an AcadEntity object.

Inserting and Modifying a Table

A table object is represented by the AcadTable object. The AddTable function allows you to create a table object based on an insertion point, number of rows and columns, as well as a row height and column width. The AddTable method is available from an AcadModelSpace, AcadPaperSpace, or AcadBlock collection object and returns an AcadTable object.

The appearance of a table is defined by a table style and cell styles. The default table style assigned to a new table is based on the active table style of a drawing. I explain how to define and manage table styles in the「Formatting Tables」section later in this chapter. You can learn to apply a named table style in the「Assigning a Table Style」section.

The following code statements add a table with five rows and three columns, and add labels to the header rows (see Figure 29.8):

' Defines the insertion point of the table Dim dInsPt(2) As Double dInsPt(0) = 5: dInsPt(1) = 2.5: dInsPt(2) = 0 ' Adds the new table object Dim oTable As AcadTable Set oTable = ThisDrawing.ModelSpace.AddTable(dInsPt, 5, 3, 0.25, 2) ' Supresses the Title row and unmerge the cells in the first row oTable.TitleSuppressed = True oTable.UnmergeCells 0, 0, 0, 2 ' Sets the values of the header row oTable.SetCellValue 0, 0, "Qty" oTable.SetCellValue 0, 1, "Part" oTable.SetCellValue 0, 2, "Description" ' Sets the width of the third column oTable.SetColumnWidth 2, 10

Figure 29.8 Empty BOM table

Due to the complexities of tables, it isn't practical to cover everything that is possible. You can merge cells, add block references to a cell, and control the formatting of individual cells with the AutoCAD Object library and VBA. If you need to work with tables, I recommend referring to the AutoCAD Help system.

Formatting Tables

Table styles—like multileader styles—are not accessed directly through a collection object like AcadTextStyles for text styles and AcadDimStyles for dimension styles. Table styles are stored in the ACAD_TABLESTYLE dictionary, which is accessed from the AcadDictionaries collection object. Each table style in the ACAD_TABLESTYLE dictionary is represented by an AcadTableStyle object.

New table styles are created with the AddObject function and the GetObject function is used to obtain an existing table style in a drawing. When using the AddObject function, you must specify two strings: the first is the name of the style you want to create and the second is the class name of AcDbTableStyle. You can learn more about working with dictionaries in Chapter 32.

The following code statements create a table style named BOM if it doesn't already exist:

On Error Resume Next ' Gets the table styles dictionary Dim oDict As AcadDictionary Set oDict = ThisDrawing.dictionaries.Item("ACAD_TABLESTYLE") ' If no error, continue If Not oDict Is Nothing Then ' Gets the table style named BOM Dim oTblStyle As AcadTableStyle Set oTblStyle = oDict.GetObject("BOM") ' If an error is returned, create the multileader style If Err Then Err.Clear ' Creates a new table style Set oTblStyle = oDict.AddObject("BOM", "AcDbTableStyle") End If ' Supresses the title row and displays the header row of the table style oTblStyle.TitleSuppressed = True oTblStyle.HeaderSuppressed = False ' Creates a new cell style oTblStyle.CreateCellStyle "BOM_Header" oTblStyle.SetCellClass "BOM_Header", 1 ' Sets the background color of the new cell style Dim oClr As AcadAcCmColor Set oClr = oTblStyle.GetBackgroundColor2("BOM_Header") oClr.ColorMethod = acColorMethodByACI oClr.ColorIndex = 9 oTblStyle.SetBackgroundColor2 "BOM_Header", oClr ' Sets the color of the text for the cell style oClr.ColorIndex = acBlue oTblStyle.SetColor2 "BOM_Header", oClr End If

A table style that is no longer needed can be removed with the Remove method of the AcadDictionary object. For more information on the properties and methods of the AcadTableStyle object, see the AutoCAD Help system or the Object Browser in the VBA Editor.

Assigning a Table Style

You can change the style of a table once it has been added to a drawing with the StyleName property. The StyleName property returns or accepts a string that represents the name of the current or table style to be assigned. When a new table object is created, the style applied is inherited from the ctablestyle system variable. You can use the SetVariable and GetVariable methods of an AcadDocument or a ThisDrawing object.

The following code statement assigns the table style named BOM to the ctablestyle system variable:

' Sets the BOM style active ThisDrawing.SetVariable "ctablestyle", "BOM"

Creating Fields

Fields are used to add dynamic values to a text object based on the current value of an object's property, a drawing file property, date, system variable, table cell, and many other types of values stored in a drawing. A field can be added to a stand-alone text object, dimension, table cell, and even block attributes. Fields are implemented with the use of control codes. Typically, a field is added to a drawing using the Field dialog box displayed with the field command. In the lower-left corner of the Field dialog box is an area labeled Field Expression. The Field Expression area displays the text that you can assign to the TextString property of an annotation object or pass to the SetCellValue method of an AcadTable object to assign a value to a table cell. For example, the following is an example of the field expression used to add today's date to the drawing in an MText object with the MM/dd/yyyy format:

%<\AcVar Date \f "MM/dd/yyyy">%

To create a new MText object with the example field expression, the VBA code statements might look like the following:

' Defines the insertion point and width for the text object Dim dInsPt(2) As Double, dWidth As Double dInsPt(0) = 0: dInsPt(1) = 0: dInsPt(2) = 0 dWidth = 2.5 ' Creates a new MText object with a field Dim oMText As AcadMText Set oMText = ThisDrawing.ModelSpace.AddMText(dInsPt, dWidth, _ "%<\AcVar Date \f ""MM/dd/yyyy"">%")

NOTE

The fieldeval and fielddisplay system variables affect when fields are evaluated and if fields are displayed with a gray background in the drawing. For more information on these system variables, see the AutoCAD Help system.

Exercise: Adding a Label to the Plate

In this section, you will continue to build on the DrawPlate project that was introduced in Chapter 27. Here is the key concept I cover in this exercise:

Creating an MText Object Simple and complex text strings can be added to a drawing with an MText object. A single-line text object can also be used to add descriptive text or a label to a drawing.

NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Getting Input from the User to Draw the Plate」section of Chapter 28,「Interacting with the User and Controlling the Current View.」If you didn't complete the steps, do so now or start with the ch29_drawplate.dvb sample file available for download from www.sybex.com/go/autocadcustomization. Place the sample file in the MyCustomFiles folder within the Documents (or My Documents) folder, or the location where you are storing the DVB files. Also, remove ch29_ from the filename before you begin working.

Revising the CLI_DrawPlate Function

These changes to the CLI_DrawPlate function add an MText object to display a basic label for the plate drawn. In the following steps you will update code statements in the CLI_DrawPlate function of the drawplate.dvb project file:

Load the drawplate.dvb file into the AutoCAD drawing environment and display the VBA Editor.

In the VBA Editor, in the Project Explorer, double-click the basDrawPlate component.

In the code editor window, scroll to the bottom of the CLI_DrawPlate function, locate the following code statements, and add the code statements shown in boldface: ' Calculate and place the circle in the upper-left ' corner of the rectangle. dAng = myUtilities.Atn2(dPtList(6) - dPtList(0), _ dPtList(7) - dPtList(1)) cenPt4 = ThisDrawing.Utility.PolarPoint(cenPt1, dAng, dDist - 1) myUtilities.CreateCircle cenPt4, 0.1875 ' Get the insertion point for the text label Dim insPt As Variant insPt = Null insPt = ThisDrawing.Utility.GetPoint(, _ removeCmdPrompt & "Specify label insertion point " & _ "<or press Enter to cancel placement>: ") ' If a point was specified, placed the label If IsNull(insPt) = False Then ' Define the label to add Dim sTextVal As String sTextVal = "Plate Size: " & _ Format(ThisDrawing.Utility. _ RealToString(width, acDecimal, 4), "0.0###") & _ "x" & _ Format(ThisDrawing.Utility. _ RealToString(height, acDecimal, 4), "0.0###") ' Create label Set oLyr = myUtilities.CreateLayer("Label", acWhite) ThisDrawing.ActiveLayer = oLyr myUtilities.CreateText insPt, acAttachmentPointMiddleCenter, _ 0.5, 0#, sTextVal End If End If Loop Until IsNull(basePt) = True And sKeyword = "" ' Restore the saved system variable values myUtilities.SetSysvars sysvarNames, sysvarVals

Click File Save.

Revising the Utilities Class

These changes to the Utilities class introduce a new function named CreateText. The CreateText function consolidates the creation of an MText object and the setting of specific properties and returns an AcadMText object. In the following steps you will add the constant value and two functions to the clsUtilities class module:

In the VBA Editor, in the Project Explorer, double-click the clsUtilities component.

Scroll to the bottom of the code editor window and click to the right of the last code statement. Press Enter twice.

Type the following code statements; the comments are here for your information and don't need to be typed:' CreateText function draws a MText object. ' Function expects an insertion point, attachment style, ' text height and rotation, and a string. Public Function CreateText(insPoint As Variant, _ attachmentPt As AcAttachmentPoint, _ textHeight As Double, _ textRotation As Double, _ textString As String) As AcadMText Set CreateText = ThisDrawing.ActiveLayout.Block. _ AddMText(insPoint, 0, textString) ' Sets the text height, attachment point, and rotation of the MText object CreateText.height = textHeight CreateText.AttachmentPoint = attachmentPt CreateText.insertionPoint = insPoint CreateText.rotation = textRotation End Function

Click File Save.

Export the clsUtilities class model from the drawplate.dvb file to a file named clsUtilities.cls in the MyCustomFiles folder, as explained in Chapter 28.

Using the Revised drawplate Function

Now that the drawplate.dvb project file has been revised, you can test the changes that have been made. The following steps explain how to use the revised drawplate function:

Switch to AutoCAD by clicking on its icon in the Windows taskbar or click View AutoCAD from the menu bar in the Visual Basic Editor.

In AutoCAD, at the Command prompt, type vbarun and press Enter.

When the Macros dialog box opens, select the DrawPlate.dvb!basDrawPlate.CLI_DrawPlate macro from the list and click Run.

At the Specify base point for the plate or [Width/Height]: prompt, pick a point in the drawing area to draw the plate and holes based on the width and height values specified.

At the Specify label insertion point <or press Enter to cancel placement>: prompt, pick a point below the plate to place the label.

Press Enter to exit the macro when you are done.

Chapter 30

Working with Blocks and External References

Most designs created with the AutoCAD® program start off with simple geometric objects, such as lines, circles, and arcs. The geometric objects are used to represent holes, bolts, motors, and even the outside of a building. As a design grows in complexity, elements often are repeated many times. For example, you might use several lines and circles to represent a bolt head or a desk with a grommet.

AutoCAD allows you to reuse geometry by creating what is known as a block. A block is a named grouping of objects that can be inserted in a drawing multiple times. Each insertion creates a block reference that displays the objects stored in the block at the insertion point. If the block is changed, each block reference based on that block is updated.

Blocks aren't the only method for reusing geometry or other data in a drawing. A drawing file can also include external references (xrefs) to geometry stored in another drawing file. External references can include blocks, raster images, and other documents. When you reference another document, such as a PDF or DWF file, it is known as an underlay. In this chapter, I explain how to use VBA to work with blocks and external referenced files.

Managing Block Definitions

Blocks make it possible to logically group basic geometry together with a unique name and then create instances of that geometry within a drawing. Blocks are implemented as two separate objects: block definitions and block references. Block definitions are nongraphical objects that are stored in the AcadBlocks collection object. Each block definition is represented by an AcadBlock object, which contains the geometry and attribute definitions that define how the block should appear and behave when it is inserted into the drawing area. A block definition can contain either static or dynamic properties.

Figure 30.1 shows the relationship between a block definition and a block reference and how the attributes of the block are used to bring the geometry into model space.

Figure 30.1 Block-definition-to-block-reference relationship

You can think of a block definition much like a cookie recipe. The recipe lists the ingredients (which determines how the cookie should taste) and provides instructions for combining those ingredients and baking the dough. What the recipe doesn't control is how much dough is placed on any particular spot on the cookie sheet before baking. The exact placement and amount of the cookie dough on the tray is determined by the baker. Similarly, an end user uses a block reference in a drawing to determine the exact placement, size, and number of geometries to be displayed. I explain how to insert and work with block references in the「Inserting and Working with Block References」section later in this chapter.

Creating a Block Definition

A new block definition can be added to a drawing using the Add function of the AcadBlocks collection object. The Add function expects two argument values and returns an AcadBlock object. Before adding a new block definition, you should use the Item method with an error handler to check to see if a block definition with the specific name you want to use already exists in the drawing. The Item method can also be used to get a specific block definition in the AcadBlocks collection object and, as with other collections, a For statement can be used to step through the block definitions in a drawing.

The following shows the syntax of the Add function:

retVal = object.Add(origin, blockName)

Its arguments are as follows:

retVal The retVal argument represents the new AcadBlock collection object returned by the Add function.

object The object argument specifies the AcadBlocks collection object that is used to add a new block definition.

origin The origin argument is an array of three doubles that defines the origin of the new block definition; think insertion point for the block reference.

blockName The blockName argument is a string that specifies the unique name to be assigned to the new block definition.

The following code statements add a new block definition named RoomNum:

' Defines the origin of the block Dim dOrigin(2) As Double dOrigin(0) = 5: dOrigin(1) = 2.5: dOrigin(2) = 0 Dim oBlkDef As AcadBlock Set oBlkDef = ThisDrawing.Blocks.Add(dOrigin, "RoomNum")

Here is an example that checks for the existence of a block definition named RoomNum:

On Error Resume Next Dim oBlkDef As AcadBlock Set oBlkDef = ThisDrawing.Blocks("RoomNum") If Err Then MsgBox "Block definition doesn't exist." Else MsgBox "Block definition exists." End If

After an AcadBlock object has been obtained using the Item or Add method of the AcadBlocks collection object, you can step through the objects of the block using a For statement or the Item method of the AcadBlock object. You can use the same functions to add new objects to a block definition as you would to add objects to model space or paper space. I explained how to add objects to and step through the objects of model space in Chapter 27,「Creating and Modifying Drawing Objects.」

The following code statements add a closed lightweight polyline to the block definition named RoomNum:

On Error Resume Next ' Gets the RoomNum block definition Dim oBlkDef As AcadBlock Set oBlkDef = ThisDrawing.Blocks("RoomNum") ' If the block doesn't exist, an error is generated If Err Then ' Defines the origin of the block Dim dOrigin(2) As Double dOrigin(0) = 5: dOrigin(1) = 2.5: dOrigin(2) = 0 ' Adds the block definition Set oBlkDef = ThisDrawing.Blocks.Add(dOrigin, "RoomNum") ' Defines the vertex points for the ' lightweight polyline Dim dPts(7) As Double dPts(0) = 0: dPts(1) = 0 dPts(2) = 10: dPts(3) = 0 dPts(4) = 10: dPts(5) = 5 dPts(6) = 0: dPts(7) = 5 ' Adds a new lightweight polyline to the block Dim oLWPoly As AcadLWPolyline Set oLWPoly = oBlkDef.AddLightWeightPolyline(dPts) ' Closes the lightweight polyline oLWPoly.Closed = True ' Sets the layer of the lightweight polyline to 0 oLWPoly.Layer = "0" End If

NOTE

I recommend placing objects in a block definition on layer 0 when the object should inherit its properties from the layer that the block reference is inserted onto. The appearance of objects in a block definition can be controlled ByBlock or ByLayer when you insert a block definition as a block reference. For information on the ByBlock and ByLayer values, see the AutoCAD Help system.

When a block definition is no longer needed, it can be removed from the drawing using the Delete method of an AcadBlock object. A block definition can't be deleted if a block reference associated with the block definition is inserted into the drawing.

NOTE

Dynamic blocks—block definitions with dynamic properties—can't be created with the AutoCAD Object library. However, you can modify the dynamic properties of a block reference using the AutoCAD Object library. I explain how to work with blocks that contain dynamic properties in the「Working with Dynamic Properties」section later in this chapter.

Adding Attribute Definitions

A block definition can contain what is known as an attribute. An attribute is similar to a text object, except its value can be changed after a block reference has been inserted into a drawing. Attributes allow you to store string values and then extract their values later. There are two types of attributes that are part of the block creation and insertion process: attribute definitions and attribute references. Attribute definitions can be added to a block definition, and attribute references are part of each block reference inserted into a drawing that is associated with a block definition that has one or more attribute definitions.

The AddAttribute function is used to add an attribute definition to a block definition and returns an AcadAttribute object. The following shows the syntax of the AddAttribute function:

retVal = object.AddAttribute(height, mode, prompt, insertionPoint, tag, value)

Its arguments are as follows:

retVal The retVal argument represents the new AcadAttribute object returned by the AddAttribute function.

object The object argument specifies the AcadBlock object to add the attribute definition.

height The height argument is a double that represents the height of the attribute.

mode The mode argument is an integer that represents the behavior of the attribute reference added to a block reference when the block is inserted into the drawing. Instead of using an integer value, I recommend that you use the constant values of the AcAttributeMode enumerator. Table 30.1 lists each of the constant values of the AcAttributeMode enumerator. You can specify more than one constant by separating each constant with a plus symbol, such as acAttributeModeInvisible + acAttributeModeNormal.

prompt The prompt argument is a string that represents the text that provides a hint for the value that's expected when the block reference is inserted.

insertionPoint The insertionPoint argument is an array of three doubles that defines the insertion point of the attribute definition.

tag The tag argument is a string that represents the text that's displayed in the drawing if the block reference is exploded after being inserted and the value used to extract the attribute's value from a block reference. A tag cannot contain spaces.

value The value argument is a string that represents the default value of the attribute when the block reference is inserted.

Table 30.1 Constant values of the AcAttributeMode enumerator

Constant Description

acAttributeModeConstant Indicates the value of the attribute can't be changed.

acAttributeModeInvisible Attribute is marked as invisible. The attmode system variable controls the display of all invisible attributes.

acAttributeModeLockPosition Position of the attribute can't be adjusted using grip editing.

acAttributeModeMultipleLine Attribute supports multiple lines of text instead of the standard single line of text.

acAttributeModeNormal Default display behavior of the attribute is maintained when the block is inserted using the insert command.

acAttributeModePreset Value of the attribute is preset. When the block is inserted using the insert command, the user isn't prompted to enter a value for the attribute.

acAttributeModeVerify User is prompted to verify the value they provide for the attribute when inserting the block reference with the insert command.

Table 30.1 lists the constant values of the AcAttributeMode enumerator that can be passed to the mode argument of the AddAttribute function or assigned to the Mode property of an AcadAttribute object.

The following code statements add an attribute definition to the block definition assigned to the oBlkDef variable:

' Defines the insertion point of the attribute definition Dim dInsPt(2) As Double dInsPt(0) = 5: dInsPt(1) = 2.5: dInsPt(2) = 0 ' Adds the attribute definition to the block Dim oAttDef As AcadAttribute Set oAttDef = oBlkDef.AddAttribute(2.5, acAttributeModeNormal, _ "Room#", dInsPt, "Room#", "101") ' Sets the alignment for the attribute's text oAttDef.Alignment = acAlignmentMiddleCenter oAttDef.TextAlignmentPoint = dInsPt

After adding an attribute definition to a block definition, you can modify its appearance and behavior using the properties and methods of the AcadAttribute object. The properties and methods of an AcadAttribute object are similar to those of an AcadText object. I discussed the AcadText object in Chapter 29,「Annotating Objects.」

Table 30.2 lists the properties of the AcadAttribute object that are unique to the object and are different from those of an AcadText object.

NOTE

If you change the MTextAttributeContent, MTextBoundaryWidth, or MTextDrawingDirection property, you must execute the UpdateMTextAttribute method of the AcadAttribute object. The UpdateMTextAttribute method updates the display of the multiline attribute in the drawing.

Table 30.2 Properties related to an AcadAttribute object

Property Description

Constant Returns True if the attribute is set to the constant mode.

Invisible Returns True if the attribute should be invisible when the block reference is inserted.

LockPosition Returns True if the attribute can't be modified using grip editing when the block reference is inserted.

MTextAttribute Returns True if the attribute should be multiline instead of single-line text.

MTextAttributeContent Specifies the content for the multiline text when the MTextAttribute property is True.

MTextBoundaryWidth Specifies the width of the multiline text when the MTextAttribute property is True.

MTextDrawingDirection Specifies the direction in which the text should be drawn when the MTextAttribute property is True.

Preset Returns True if the user shouldn't be prompted to enter a value for the attribute when the block is inserted.

PromptString Specifies the prompt string that is displayed for the attribute when the block is inserted.

TagString Specifies the tag for the attribute that is displayed in the drawing if the block reference is exploded after being inserted. The tag can also be useful when trying to identify which attribute's value to extract when generating a BOM.

TextString Specifies the default text for the attribute to use when the block is inserted.

Verify Returns True if the user should be prompted to verify the value of the attribute when the block is inserted.

Modifying and Redefining a Block Definition

You can add new objects or modify existing objects of a block definition, much like you can in model space or paper space. The Item method of the AcadBlock object can be used to get a specific object or a For statement to step through all objects in a block definition.

In addition to modifying the objects in a block definition, the origin—the insertion point of a block—can be modified using the Origin property. The Origin property of an AcadBlock object allows you to get or set the origin for the block definition. The origin of a block definition is defined as a double array with three elements.

Besides modifying the objects and origin of a block, you can specify whether a block reference created from a block can be exploded, set the units that control the scaling of a block, and make other changes. Table 30.3 lists the properties that control the behavior of and provide information about an AcadBlock object.

Table 30.3 Properties related to an AcadBlock object

Property Description

BlockScaling Specifies if the block can only be scaled uniformly (acUniform) or the block can be assigned a different scale factor for each axis (acAny).

Comments Specifies a string that describes the block definition.

Count Returns an integer value that contains the number of block references that have been inserted into the drawing based on the block definition.

Explodable Returns True if the block reference inserted into the drawing can be exploded.

Name Specifies a string that contains the name of the block definition.

Units Specifies the units of measurement for the block. A constant value from the AcInsertUnits enumerator is returned by or can be assigned to this property. See the Object Browser in the VBA Editor for a list of possible values. The units specified affect the insertion scale of the block.

After a block definition has been updated, you should use the Regen method of the AcadApplication object to regenerate the display of the drawing. You can also update the display of an individual block reference using the Update method. I explained the Regen and Update methods in Chapter 27. If you add or remove an AcadAttribute object in a block definition, the block references inserted into model space or paper space aren't updated to reflect the change unless the attribute being changed is defined as a constant.

To reflect the changes in the attributes between a block definition and the block references inserted into a drawing, you will need to do the following:

Insert a new block reference into the drawing.

Update the attribute values of the new block reference with those from the existing block reference.

Remove the old block reference.

I discuss more about working with block references in the「Inserting and Working with Block References」section later in this chapter.

Determining the Type of Block Definition

Block definitions stored in the AcadBlocks collection object of a drawing aren't only used to insert block references. Model space and paper space are also block definitions with special names along with external references (xrefs) and layouts. You can determine a block definition's type using the properties in Table 30.4. I discuss xrefs in the「Working with Xrefs」section later in this chapter and layouts in Chapter 31,「Outputting Drawings.」

Table 30.4 Properties used to determine a block definition's type

Property Description

IsDynamicBlock Returns True if the block definition contains dynamic properties.

IsLayout Returns True if the block definition is for a layout. You can use the Layout property of an AcadBlock, AcadModelSpace, or AcadPaperSpace object to get the object's associated AcadLayout object.

IsXref Returns True if the block definition is for an external reference.

Inserting and Working with Block References

A block reference is an instance—not a copy—of the geometry from a block definition; the geometry only exists as part of the block definition, with the exception of attributes. Attribute definitions that are part of a block definition are added to a block reference as attribute references unless the attribute definition is defined as a constant attribute. Constant attributes are part of the geometry that is inherited from a block definition and are not part of the block reference.

Inserting a Block Reference

The InsertBlock function is used to insert a reference of a block definition in model space, paper space, or another block definition and expects seven argument values that define the block definition you want to insert, as well as the placement and size of the block reference. After a block reference has been inserted, an AcadBlockReference object is returned.

The following shows the syntax of the InsertBlock function:

retVal = object.InsertBlock(insertionPoint, blockName, xScale, yScale, zScale, rotation [, password])

Its arguments are as follows:

retVal The retVal argument represents the new AcadBlockReference object returned by the InsertBlock function.

object The object argument specifies the AcadBlock, AcadModelSpace, or AcadPaperSpace object where the block reference is to be inserted.

insertionPoint The insertionPoint argument is an array of doubles that represents the insertion point of the block reference.

blockName If you wish to insert the reference into a block definition, use the blockName argument (a string) to specify the name of that block definition. The block must already be defined in the drawing before the insertion can be executed. If you wish to insert a DWG file as a reference into a drawing, specify the full path of a DWG file. When a DWG file is specified, an AcadBlock object based on the objects in model space of the DWG file specified is created, and then the block reference is inserted.

NOTE

An error is generated if the block definition being inserted doesn't already exist in the drawing. You can catch the error and use the Add method to create the block definition or specify a DWG file to insert that might contain the objects for the block you want to use.

For example, the following inserts a block named grid.dwg from the location c:\symbols:

Set oBlkRef = ThisDrawing.ModelSpace.InsertBlock( _ insPt, "c:\symbols\grid.dwg", 1, 1, 1, 0)

xScale, yScale, and zScale The xScale, yScale, and zScale arguments are doubles that represent the scale factors of the block reference.

rotation The rotation argument is a double that represents the rotation angle of the block reference. The rotation angle must be expressed in radians.

password The password argument is an optional string that represents the password assigned to restrict the drawing file from being opened or inserted into by unapproved users. This argument is only required if you are inserting a block based on a DWG file that is password protected.

The following code statements insert a block reference based on a block named RoomNum at 15,27. (Remember, the block you name in code like this must already be defined in your drawing before the code can be executed. Be sure to use an error handler to add the block if it doesn't exist.)

' Defines the insertion point Dim insPt(2) As Double insPt(0) = 15: insPt(1) = 27: insPt(2) = 0 ' Defines the name of the block Dim blkName As String blkName = "RoomNum" ' Inserts the block reference Dim oBlkRef As AcadBlockReference Set oBlkRef = ThisDrawing.ModelSpace.InsertBlock( _ insPt, blkName, 1, 1, 1, 0)

Modifying a Block Reference

Once a block reference, an AcadBlockReference object, is inserted into a drawing, you can modify it using the methods and properties inherited from the AcadEntity object and those specific to the AcadBlockReference object. I explained how to use the methods and properties of the AcadEntity object in Chapter 27. Table 30.5 lists the properties that are used to change the placement, rotation, and scale of a block reference.

Table 30.5 Properties used to affect a block reference

Property Description

InsertionPoint Specifies the insertion point of the block reference in the drawing and is an array of doubles

InsUnits Returns a string that represents the insertion units saved with the block

InsUnitsFactor Returns the insertion factor that is based on the insertion units of the block and those of the drawing

Rotation Specifies the rotation of the block reference

XEffectiveScaleFactor Specifies the effective scale factor along the X-axis for the block reference

XScaleFactor Specifies the scale factor along the X-axis for the block reference

YEffectiveScaleFactor Specifies the effective scale factor along the Y-axis for the block reference

YScaleFactor Specifies the scale factor along the Y-axis for the block reference

ZEffectiveScaleFactor Specifies the effective scale factor along the Z-axis for the block reference

ZScaleFactor Specifies the scale factor along the Z-axis for the block reference

Block references also support the ability to be exploded. The Explode method is used to explode a block reference and it returns an array of the objects added to the drawing as a result of exploding the block reference. The objects in the array are copies of the objects from the block definition associated with the block reference. When the Explode method is executed, the block reference isn't removed from the drawing. You must decide what to do with the block reference. Typically, the block reference is removed using the Delete method, while the objects from the Explode method are kept.

The following code statements explode the first block reference located in model space and then list the block definition name and the objects that make up the block definition:

Sub ExplodeFirstBlkRef() Dim oBlkRef As AcadBlockReference Dim oObj As Object ' Step through model space For Each oObj In ThisDrawing.ModelSpace ' If a block reference is found, explode it If TypeOf oObj Is AcadBlockReference Then Set oBlkRef = oObj ' Explode the block reference Dim vObjArray As Variant vObjArray = oBlkRef.Explode ' List the objects that were added ThisDrawing.Utility.Prompt vbLf & "Block exploded: " & _ oBlkRef.Name & vbLf ThisDrawing.Utility.Prompt vbLf & "Objects added: " & _ vbLf ' Remove the block reference oBlkRef.Delete Dim oAcadObj As AcadObject Dim oObjFromBlkRef As Variant For Each oObjFromBlkRef In vObjArray Set oAcadObj = oObjFromBlkRef ThisDrawing.Utility.Prompt " " & oAcadObj.ObjectName & _ vbLf Next oObjFromBlkRef ' Exit the For statement since we are interested ' in the first block reference only Exit For End If Next oObj End Sub

Here is an example of the output from the previous example code:

Block exploded: 2x4x8 Objects added: AcDbPolyline AcDbLine AcDbLine

Accessing the Attributes of a Block

When a block reference is first inserted into a drawing, the default values of all attributes are used. The value of each nonconstant attribute of a block reference can be changed. Before you access the attributes of a block reference, you should make sure the block reference has attributes. The HasAttributes property of an AcadBlockReference object returns True if a block reference has attributes, either constant or nonconstant.

The GetAttributes and GetConstantAttributes functions of an AcadBlockReference object are used to access the attributes of a block reference. Neither function accepts any arguments. The GetAttributes function returns an array of AcadAttributeReference objects that aren't defined as constant attributes attached to a block reference, whereas the GetConstantAttributes function returns an array of AcadAttribute objects.

Listing 30.1 is a custom procedure that demonstrates how to get both the attributes and constant attributes attached to a block reference.

Listing 30.1: Lists attribute tags and values of a block reference

Sub ListBlockAtts() ' Prompt the user to select a block reference Dim oObj As Object Dim vPtPicked As Variant ThisDrawing.Utility.GetEntity oObj, vPtPicked, vbLf & _ "Select a block reference: " ' Check to see if the entity selected is a ' block reference If TypeOf oObj Is AcadBlockReference Then Dim oBlkRef As AcadBlockReference Set oBlkRef = oObj ' Output information about the block ThisDrawing.Utility.Prompt vbLf & "*Block Reference*" & _ vbLf & " Block name: " & _ oBlkRef.Name & vbLf ' Check to see if the block reference has attributes If oBlkRef.HasAttributes = True Then Dim oAttRef As AcadAttributeReference Dim oAttDef As AcadAttribute Dim vObj As Variant ' Gets the nonconstant attributes ThisDrawing.Utility.Prompt vbLf & "*Nonconstant Attributes*" Dim vArAtts As Variant vArAtts = oBlkRef.GetAttributes ' Steps through the nonconstant attributes If UBound(vArAtts) > -1 Then For Each vObj In vArAtts Set oAttRef = vObj ' Outputs the tag and text of the attribute ThisDrawing.Utility.Prompt vbLf & " Tag: " & _ oAttRef.TagString & _ vbLf & " Value: " & _ oAttRef.TextString Next vObj Else ThisDrawing.Utility.Prompt vbLf & " None" End If ' Gets the nonconstant attributes ThisDrawing.Utility.Prompt vbLf & "*Constant Attributes*" ' Gets the constant attributes vArAtts = oBlkRef.GetConstantAttributes ' Steps through the constant attributes If UBound(vArAtts) > -1 Then For Each vObj In vArAtts Set oAttDef = vObj ' Outputs the tag and text of the attribute ThisDrawing.Utility.Prompt vbLf & " Tag: " & _ oAttDef.TagString & _ vbLf & " Value: " & _ oAttDef.TextString Next vObj Else ThisDrawing.Utility.Prompt vbLf & " None" End If ThisDrawing.Utility.Prompt vbLf End If End If End Sub

Here is an example of the output generated by the custom ListBlockAtts procedure from Listing 30.1:

*Block Reference* Block name: RoomNumber *Nonconstant Attributes* Tag: ROOM# Value: 101 *Constant Attributes* None

In addition to listing the values of the attributes attached to a block reference, you can modify the appearance and placement of the attribute references returned by the GetAttributes function. If you make changes to an attribute reference, make sure to execute the Update method and regenerate the display of the object. The AcadAttributeReference and AcadAttribute objects are nearly identical. However, the AcadAttributeReference object doesn't support the Mode, Preset, PromptString, or Verify property.

Working with Dynamic Properties

Most block references display a single set of geometry, meaning that the objects that are included in the block definition are the only ones that can be shown in the drawing. Starting with AutoCAD 2006, block definitions were extended to support what are known as dynamic properties. Block definitions with dynamic properties are known as dynamic blocks. You can't create dynamic blocks with the AutoCAD Object library, but you can modify the custom properties of a dynamic block after it is inserted into a drawing. For information on how to create a dynamic block, see the topic「About Dynamic Blocks」in the AutoCAD Help system.

The IsDynamicBlock property of the AcadBlockReference object can be used to determine whether a block reference has dynamic properties. When the IsDynamicBlock property returns True, the block reference has dynamic properties that can be queried and modified.

Once you have verified that a block reference has dynamic properties, you use the GetDynamicBlockProperties function to get an array of AcadDynamicBlockReferenceProperty objects. The Value property of an AcadDynamicBlockReferenceProperty object is used to get and set the value of a dynamic property, whereas the PropertyName property returns a string that represents the name of the dynamic property.

Listing 30.2 is a custom procedure that demonstrates how to get the custom properties and their values of a block reference named Door - Imperial. You can insert the Door - Imperial block reference using the block tool on the Architectural tab of the Tool Palettes window (displayed using the toolpalettes command).

Listing 30.2: Listing custom properties and values of a block reference

Sub ListCustomProperties() ' Prompt the user to select a block reference Dim oObj As Object Dim vPtPicked As Variant ThisDrawing.Utility.GetEntity oObj, vPtPicked, vbLf & _ "Select a block reference: " ' Check to see if the entity selected is a ' block reference If TypeOf oObj Is AcadBlockReference Then Dim oBlkRef As AcadBlockReference Set oBlkRef = oObj ' Output information about the block ThisDrawing.Utility.Prompt vbLf & "*Block Reference*" & _ vbLf & " Block name: " & _ oBlkRef.Name & vbLf ' Check to see if the block reference has dynamic properties If oBlkRef.IsDynamicBlock = True Then Dim oDynProp As AcadDynamicBlockReferenceProperty Dim vObj As Variant ' Gets the block reference's dynamic properties ThisDrawing.Utility.Prompt vbLf & "*Dynamic Properties*" Dim vDynProps As Variant vDynProps = oBlkRef.GetDynamicBlockProperties ' Steps through the dynamic properties If UBound(vDynProps) > -1 Then For Each vObj In vDynProps Set oDynProp = vObj ' Outputs the property name and value Dim sValue As String If IsArray(oDynProp.Value) = False Then sValue = CStr(oDynProp.Value) Else For Each vVal In oDynProp.Value If sValue <> "" Then sValue = sValue & "," sValue = sValue & CStr(vVal) Next vVal End If ThisDrawing.Utility.Prompt vbLf & " Property Name: " & _ oDynProp.PropertyName & _ vbLf & " Value: " & _ sValue sValue = "" Next vObj Else ThisDrawing.Utility.Prompt vbLf & " None" End If ThisDrawing.Utility.Prompt vbLf End If End If End Sub

Here is an example of the output generated by the custom ListCustomProperties procedure from Listing 30.2:

*Block Reference* Block name: *U3 *Dynamic Properties* Property Name: Door Size Value: 40 Property Name: Origin Value: 0,0 Property Name: Wall Thickness Value: 6 Property Name: Origin Value: 0,0 Property Name: Hinge Value: 0 Property Name: Swing Value: 0 Property Name: Opening Angle Value: Open 30°

When a user manipulates a grip associated with a dynamic property, onscreen it looks like the user is manipulating the block reference through a stretching, arraying, moving, or other action. The action that is performed by the user results in the creation of a new anonymous block definition. An anonymous block is a block that can't be inserted into a drawing but that is used as a way to let AutoCAD create and manage unique blocks.

NOTE

The name of a block reference is typically obtained using the Name property, but with dynamic blocks the Name property might return an anonymous block name such as *U8. An anonymous block name is created as a result of manipulating one of the grips associated with a dynamic property on a block reference. To get the original name of the block definition for a dynamic block, you use the EffectiveName property.

You can convert a dynamic block to an anonymous block without dynamic properties using the ConvertToAnonymousBlock method or a new block definition using the ConvertToStaticBlock method. The ConvertToStaticBlock method expects a string that represents the name of the new block definition.

The appearance and custom properties of a dynamic block can be reset to their default values. To reset the appearance and custom properties of a dynamic block, you use the ResetBlock method of an AcadBlockReference object. The ResetBlock method doesn't accept any argument values and doesn't return a value.

Managing External References

AutoCAD allows you to create what is known as an external reference. An external reference is a reference to a file that is stored outside of a drawing file. The contents in an external file can be another drawing, a raster or vector image, or even a file that supports Object Linking and Embedding (OLE). OLE allows you to embed, among other things, a Word document or an Excel spreadsheet into a drawing file. In addition to referencing a file, you can import objects into a drawing using OLE. An OLE object is represented by the AcadOle object in the AutoCAD Object library. You can modify, but not create, an OLE object with the AutoCAD Object library. I discuss how to import objects or a file in Chapter 31.

You can see which files are externally referenced to a file by accessing the items of the AcadFileDependencies collection object. Each file that a drawing is dependent on to correctly display objects is part of the AcadFileDependencies collection object. I mention the AcadFileDependencies collection object in the「Listing File Dependencies」section later in this chapter.

Working with Xrefs

An external drawing file referenced into a drawing is known as an xref. Xrefs are similar to blocks because they allow for the reuse of geometry in any drawing with one distinct difference. The difference that sets blocks and xrefs apart is that any changes made to the objects in the external drawing file are reflected in any drawings that reference the file. Xrefs are frequently used in architectural and civil engineering drawings to reference a floor plan or survey drawing. An xref is represented by an AcadExternalReference object and is similar to an AcadBlockReference object except in the way that the object can be modified and managed.

Attaching an Xref

An xref is attached to a drawing, not inserted like a block or added like other graphical objects. The AttachExternalReference function returns an AcadExternalReference object and expects nine argument values that define which file to attach, as well as the placement and size of the xref. When an xref is attached to a drawing, an AcadBlock object is created. The AcadBlock object contains the geometry that is in the referenced drawing file, but objects can't be added or modified in that AcadBlock object. Figure 30.2 shows the flow of data that takes place when a drawing file is attached to a drawing and an xref is placed in model space.

Figure 30.2 Xref attachment flow

The following shows the syntax of the AttachExternalReference function:

retVal = object.AttachExternalReference(fileName, xrefName, insertionPoint, xScale, yScale, zScale, rotation, overlay [, password])

Its arguments are as follows:

retVal The retVal argument represents the new AcadExternalReference object returned by the AttachExternalReference function.

object The object argument specifies the AcadBlock, AcadModelSpace, or AcadPaperSpace object where you wish to attach the xref.

fileName The fileName argument is a string that represents the name of the external DWG file you want to reference.

xrefName The xrefName argument is a string that represents the name you want to assign to the AcadBlock object that is added to the drawing.

insertionPoint The insertionPoint argument is an array of doubles that represents the insertion point of the xref.

xScale, yScale, zScale The xScale, yScale, and zScale arguments are doubles that represent the scale factors of the xref.

rotation The rotation argument is a double that represent the rotation angle of the xref. The rotation angle must be expressed in radians.

overlay The overlay argument is a Boolean that represents the reference type for the xref. There are two reference types: attachment and overlay. The reference types don't affect the current drawing unless the drawing is referenced into another drawing. An attachment reference type allows the xref to be displayed in other drawings that reference the drawing that contains the xref, whereas an overlay reference restricts the xref to be displayed only in the drawing to which it is attached. Use a value of True to specify an overlay reference type.

password The password argument is an optional string that represents the password assigned to restrict the drawing file from being opened or referenced by unapproved users.

The following code statements add an xref based on the Ch30_Building_Plan.dwg file at 0,0 and set the reference type to attachment:

' Defines the insertion point Dim insPt(2) As Double insPt(0) = 0: insPt(1) = 0: insPt(2) = 0 ' Defines the path to the drawing file Dim dwgName As String dwgName = ThisDrawing.GetVariable("MyDocumentsPrefix") & _ "\MyCustomFiles\Ch30_Building_Plan.dwg" ' Adds the xref Dim oXref As AcadExternalReference Set oXref = ThisDrawing.ModelSpace.AttachExternalReference( _ dwgName, "Building_Plan", insPt, 1, 1, 1, 0, False)

TIP

The objects of all attached xrefs can be faded using the xdwgfadectl and xfadectl system variables. Use the SetVariable method of an AcadDocument or ThisDrawing object to change the values of the system variables, or the GetVariable function to get their current values.

Getting Information About and Modifying an Xref

Once an xref has been attached to a drawing, you can access information about the instance of the xref. As I previously mentioned, an xref is similar to a block reference that has been inserted into a drawing, and even the AcadExternalReference and AcadBlockReference objects share many of the same properties and methods. For information on how to access information about and modify a block reference, see the「Modifying a Block Reference」section earlier in this chapter.

Although an AcadExternalReference and AcadBlockReference object have much in common, there are a few differences:

Xrefs do not support attributes.

Xrefs do not support dynamic block properties.

Xrefs can't be exploded unless they have been bound to the drawing first.

The path to the external file can be modified.

The objects in the external referenced file can be accessed.

Although there are a number of differences between xrefs and block references, in the AutoCAD Object library the AcadExternalReference and AcadBlockReference objects are similar. The only difference between the two object types is the Path property. The Path property of an AcadExternalReference object can be used to get and specify the path that AutoCAD should look in for the externally referenced drawing file. I show an example of using the Path property in the next section.

For each externally referenced file that is attached to a drawing, AutoCAD creates an in-memory database for that file. The database is represented by an AcadDatabase object and contains access to the nongraphical and graphical objects stored in the externally referenced file. The database of an xref can be accessed with the XRefDatabase property of an AcadBlock object.

Objects in the database of an xref returned by the XRefDatabase property can't be directly modified. However, it is possible to open the externally referenced drawing file into memory with the AutoCAD/ObjectDBX Common Type library. After a drawing file is opened in memory with the AutoCAD/ObjectDBX Common Type library, the objects in the file can then be modified. Once changes have been made to the drawing, you use the Reload method of an AcadBlock object in the drawing to which the xref is attached to update its display. I mention the Reload method in the next section and how to reference other object libraries in Chapter 35,「Communicating with Other Applications.」

Changing the Layers of an Xref

Although you can't make changes to the geometry of an AcadBlock object that references an external file, you can affect the layers of an xref. To change a layer in an xref, set the visretain system variable to 1 with the SetVariable method of an AcadDocument or ThisDrawing object. After the visretain system variable has been enabled, you can use the XRefDatabase property of the AcadBlock object and access its AcadLayers collection, which contains the layers used by the objects of the xref. Any changes made to the layers are maintained in the drawing file that contains the xref and not the externally referenced file.

When locating an item in a collection object of the xref database, you must add the name of the xref with a pipe symbol as a prefix to the item's name. For example, to get the Surfaces layer in the xref named Building_Plan, you use the value Building_Plan|Surfaces.

The following code statements change the color of the layer named Surfaces to yellow:

' Enable the visretain system variable ThisDrawing.SetVariable "visretain", 1 ' Defines the name of the xref to locate Dim sXrefName As String sXrefName = "Building_Plan" ' Gets the name of the block Dim oBlkDef As AcadBlock Set oBlkDef = ThisDrawing.Blocks(sXrefName) ' Change the Surface layer in the xref to yellow oBlkDef.XRefDatabase.Layers(sXrefName & "|" _ & "Surfaces").color = acYellow

Managing an Attached Xref

The management of the reference between an external drawing file and an xref is handled through an AcadBlock object. The name of the AcadBlock object used by an xref can be obtained with the Name property of the AcadExternalReference object. Once the name of the block has been obtained, you can use the Item method of the AcadBlocks collection object to get the AcadBlock object associated with the xref.

In addition to using the Item method, you can use a For statement to step through all the blocks in a drawing and see which ones are associated with an external file. While stepping through the AcadBlocks collection object, the IsXref property of the AcadBlock object returns True if the block represents an external referenced file.

The following code statements get the AcadBlock object for a block named Building_Plan and then use the IsXref property to see if it is an xref. If the block is an xref, a message box with the path to the external referenced file is displayed.

' Defines the name of the xref to locate Dim sXrefName As String sXrefName = "Building_Plan" ' Gets the name of the block Dim oBlkDef As AcadBlock Set oBlkDef = ThisDrawing.Blocks(sXrefName) ' Check to see if the block is an xref If oBlkDef.IsXRef Then ' Display information about the xref MsgBox "Block name: " & sXrefName & _ vbLf & "Path: " & oBlkDef.Path End If

The Path property shown in the previous sample code is used to get the current path to the external referenced file, but it can also be used to update the default location for the externally referenced drawing file. After an AcadBlock object containing an external reference has been obtained, you can then manage the reference between the drawing and the external referenced file stored outside of AutoCAD. Table 30.6 lists the four functions that can be used to manage an xref.

Table 30.6 Methods used to manage an xref

Method Description

Bind Removes the reference to the external file, and all xrefs attached to the drawing are converted to blocks and stored as part of the drawing. Changes made to the external file no longer affect the objects in the drawing. The method expects a Boolean value; use True if you do not want to add a prefix to the symbol names that are created from the external reference or use False to add a prefix to the symbol name. Use a value of False to maintain the appearance of objects in the xref. Specifying a value of True indicates that the objects from the xref being merged will use the nongraphical objects defined in the drawing to which the xref is attached. If the nongraphical objects don't exist in the drawing to which the xref is attached and True is specified, the nongraphical object is copied from the xref's database.

Detach Removes the reference to the external referenced file, and all xrefs attached to the drawing are removed. This method doesn't accept any arguments.

Reload Updates the geometry in the drawing by reading the objects from the external referenced file. This method doesn't accept any arguments.

Unload Maintains the reference to the external referenced file, and all xrefs remain in the drawing. The file isn't loaded into the drawing, which results in the objects contained in the file not being displayed. This method doesn't accept any arguments.

The following code statements reload the external reference named Building_Plan:

' Defines the name of the xref to locate Dim sXrefName As String sXrefName = "Building_Plan" ' Gets the name of the block Dim oBlkDef As AcadBlock Set oBlkDef = ThisDrawing.Blocks(sXrefName) ' Reload the xref oBlkDef.Reload

Attaching and Modifying Raster Images

A raster image stored in an external file can be attached to a drawing. You might want to reference an external image file to place a company logo on a title block, display a watermark, or reference a topography map. An image file that has been added to a drawing is represented by an AcadRasterImage object.

NOTE

Before attaching an image to a drawing file, keep in mind that large image files can increase the amount of time it takes to open a drawing and even change the display of a drawing.

A raster image can be added to model space or paper space using the AddRaster function. The AddRaster function returns an AcadRasterImage object and expects four argument values that specify the image file you want to add and then the placement and size of the image.

The following shows the syntax of the AddRaster function:

retVal = object.AddRaster(fileName, insertionPoint, scaleFactor, rotation)

Its arguments are as follows:

retVal The retVal argument represents the new AcadRasterImage object returned by the AddRaster function.

object The object argument specifies the AcadBlock, AcadModelSpace, or AcadPaperSpace object and indicates where you want to add the raster image.

fileName The fileName argument is a string that represents the name of the image file.

insertionPoint The insertionPoint argument is an array of doubles that represents the insertion point of the raster image.

scaleFactor The scaleFactor argument is a double that represents the scale factor of the raster image.

rotation The rotation argument is a double that represents the rotation angle of the raster image. The rotation angle must be expressed in radians.

The following code statements add a raster image based on the acp_logo.png filename to 5,5 and set the background of the image to transparent:

' Defines the insertion point Dim insPt(2) As Double insPt(0) = 5: insPt(1) = 5: insPt(2) = 0 ' Defines the path to the image Dim imageName As String imageName = ThisDrawing.GetVariable("MyDocumentsPrefix") & _ "\MyCustomFiles\acp_logo.png" ' Adds the raster image Dim oRaster As AcadRasterImage Set oRaster = ThisDrawing.ModelSpace. _ AddRaster(imageName, insPt, 1, 0) ' Sets the background of the image to transparent oRaster.Transparency = True

After a raster image has been added to a drawing, you can control its appearance using the object properties and methods. A raster image supports the same general properties and methods as all graphical objects in a drawing, along with additional object-specific properties. Table 30.7 lists the properties that are specific to a raster image.

Table 30.7 Raster image–related properties and methods

Property/Method Description

Brightness Specifies the brightness applied to the raster image; the valid range is 0 to 100.

ClippingEnabled Returns True if the raster image is clipped.

ClipBoundary Specifies the clipping boundary of the raster image. The ClipBoundary method expects an array of doubles that form a closed region. The array must contain a minimum of six elements; each element pairing specifies a 2D coordinate value.

Contrast Specifies the contrast applied to the raster image; the valid range is 0 to 100.

Fade Specifies the fade value applied to the raster image; the valid range is 0 to 100. The greater the value, the more transparent the object.

Height Returns the height, in pixels, for the raster image. This property is read-only.

ImageFile Specifies the full path to the external file for the raster image.

ImageHeight Specifies the height, in pixels, for the raster image.

ImageVisibility Returns True if the raster image is visible.

ImageWidth Specifies the width, in pixels, for the raster image.

Name Specifies the name of the raster image.

Origin Specifies the insertion point of the raster image in the drawing and is an array of doubles.

Rotation Specifies the rotation of the raster image.

ScaleFactor Specifies the scale factor applied to the raster image.

ShowRotation Returns True if the raster image is displayed at its specified rotation.

Transparency Returns True if the background of the raster image is displayed as transparent.

Width Returns the width, in pixels, for the underlay. This property is read-only.

Masking Objects with Wipeouts

A wipeout object is used to mask or hide other objects in a drawing. For example, you can place a wipeout behind the text or extension line of a dimension to make the text easier to read and make it easier to identify the objects that are dimensioned. An AcadWipeout object is used to represent a wipeout object that was created in a drawing.

There is no method to create a new wipeout, but you can use the wipeout command with the SendCommand or PostCommand method. The properties of an AcadWipeout object are the same as an AcadRasterImage object. I explained how to work with raster images in the「Attaching and Modifying Raster Images」section earlier in this chapter.

Working with Underlays

Underlays consist of geometry and annotation that is referenced into a drawing file from a drawing web (DWF/DWFx) file, MicroStation design (DGN) file, or an Adobe portable document (PDF) file. The geometry in an underlay is less accurate than that of a drawing because of the source applications that created the objects. Even though an underlay is less accurate, the accuracy might be enough for many designs created in the architectural and civil engineering industries.

When an underlay is attached to a drawing, its objects can be controlled using the layer information embedded in the underlay. As users create new objects in a drawing, they can use object snaps to snap to geometry that is part of an underlay.

The AutoCAD Object library doesn't provide support for attaching or detaching an underlay, but it does provide some support for querying and modifying an underlay that has already been attached to a drawing. If you want to attach an underlay, you can use the -dgnattach, -dwfattach, or -pdfattach commands with the SendCommand or PostCommand method.

The following objects represent the underlays that can be attached to a drawing:

AcadDgnUnderlay—DGN underlay

AcadDwfUnderlay—DWF/DWFx underlay

AcadPdfUnderlay—PDF underlay

The following code statements demonstrate how the ObjectName property can be used to determine the type of an underlay object. The first two code statements get the first object in model space and expect the object to be an underlay.

Dim oEnt As AcadEntity Set oEnt = ThisDrawing.ModelSpace(0) Select Case oEnt.ObjectName Case "AcDbDgnReference" MsgBox "Underlay is a DGN file." Case "AcDbDwfReference" MsgBox "Underlay is a DWF file." Case "AcDbPdfReference" MsgBox "Underlay is a PDF file." End Select

An underlay shares many properties in common with an AcadRaster object. The following properties are shared between underlays and raster images:

