ClippingEnabled

Contrast

FadeHeight

Rotation

ScaleFactor

Width

Table 30.8 lists the properties specific to an underlay. These properties can be used to control the display of the object and get information about the referenced file.

Table 30.8 Underlay-related properties

Property Description

AdjustForBackground Returns True if the colors in the underlay are adjusted for the current background color of the viewport.

File Specifies the full path to the external file that contains the objects for the underlay.

ItemName Specifies the sheet or design model name in the underlay file you want to display. A sheet or design model is one of the pages or designs stored in the underlay file. For example, a PDF file can contain several pages, and you use ItemName to specify which page you want to display.

Monochrome Returns True if the colors of the underlay are displayed as monochromatic.

Position Specifies the insertion point of the underlay in the drawing and is an array of doubles.

UnderlayLayerOverrideApplied Specifies whether layer overrides are applied to the underlay; a constant value of acNoOverrides means no overrides are applied, whereas acApplied indicates overrides are applied.

UnderlayName Specifies the name of the underlay file.

UnderlayVisibility Returns True if the objects in the underlay should be visible.

Listing File Dependencies

A drawing file relies on a number of support files to display objects accurately. These support files might be font files, plot styles, external referenced files, and much more. You can use the AcadFileDependencies collection object to access a listing of the files that need to be included when sharing your files with a subcontractor or archiving your designs. Each dependency in the AcadFileDependencies collection object is represented by an AcadFileDependency object.

Although it is possible to directly add new entries for file dependencies to a drawing, I recommend letting the AutoCAD application and AutoCAD Object library do the work for you. Incorrectly defining a file dependency could have unexpected results on a drawing; objects might not display correctly or at all. Methods such as AttachExternalReference and AddRaster will add the appropriate file dependency entries to a drawing.

If you want, you can use the CreateEntry, RemoveEntry, and UpdateEntry methods to manage the file dependencies of a drawing. See the AutoCAD Help system for information on the methods used to manage file dependencies. In most cases, you will simply want to query the file dependencies of a drawing to learn which files might be missing and help the user locate them if possible. Use the Item method or a For statement to step through the file dependencies of the AcadFileDependencies collection object.

The following code statements display information about each file dependency at the Command prompt:

Sub ListDependencies() Dim oFileDep As AcadFileDependency For Each oFileDep In ThisDrawing.FileDependencies ThisDrawing.Utility.Prompt _ vbLf & "Affects graphics: " & CStr(oFileDep.AffectsGraphics) & _ vbLf & "Feature: " & oFileDep.Feature & _ vbLf & "File name: " & oFileDep.FileName & _ vbLf & "File size (Bytes): " & CStr(oFileDep.FileSize) & _ vbLf & "Found path: " & oFileDep.FoundPath & _ vbLf Next oFileDep End Sub

NOTE

A drawing file must have been saved once before you access its file dependency entries with the AcadFileDependencies collection object. Using the file path returned by the FileName and FoundPath properties of an AcadFileDependency object, you can use the FileSystemObject object to get more information about the referenced file. I explain how to use the FileSystemObject object in Chapter 35.

Here is an example of the output produced for a file dependency:

Affects graphics: True Feature: Acad:Text File name: arial.ttf File size (Bytes): 895200 Found path: C:\WINDOWS\FONTS\

Exercise: Creating and Querying Blocks

In this section, you will create several new procedures that create and insert room label blocks into a drawing, move the blocks to specific layers based on their names, and extract the attributes of the blocks to produce a bill of materials (BOM). Room labels and blocks with attributes are often used in architectural drawings, but the same concepts can be applied to callouts and parts in mechanical drawings.

As you insert a room label block with the custom program, a counter increments by 1 so you can place the next room label without needing to manually enter a new value. The last calculated value is stored in a custom dictionary so it can be retrieved the next time the program is started. The key concepts I cover in this exercise are:

Creating and Modifying Block Definitions Block definitions are used to store a grouping of graphical objects that can be inserted into a drawing. Inserting a block definition creates a block reference that creates an instance of the objects defined in a block definition and not a copy of the objects.

Modify and Extracting Attributes The attributes attached to a block reference can be modified to hold different values per block reference, and those values can be extracted to a database or even a table within the drawing. Attribute values can represent project information, part numbers and descriptions of the parts required to assemble a new project, and so on.

NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Creating, Querying, and Modifying Objects」section of Chapter 27. If you didn't complete the steps, do so now or start with the ch30_clsUtilities.cls sample file available for download from www.sybex.com/go/autocadcustomization. Place these sample files in the MyCustomFiles folder under the Documents (or My Documents) folder, or the location you are using to store the DVB files. Also, remove the ch30_ prefix from the name of the CLS file. You will also be working with the ch30_building_plan.dwg from this chapter's sample files.

Creating the RoomLabel Project

The RoomLabel project will contain functions and a main procedure that allow you to create and insert a room label block based on end-user input. The number applied to the block is incremented each time the block is placed in the current drawing. The following steps explain how to create a project named RoomLabel and to save it to a file named roomlabel.dvb:

Create a new VBA project with the name RoomLabel. Make sure to change the default project name (ACADProject) to RoomLabel in the VBA Editor.

In the VBA Editor, in the Project Explorer, right-click the new project and choose Import File.

When the Import File dialog box opens, browse to and select the clsUtilities.cls file in the MyCustomFiles folder. Click Open.The clsUtilities.cls file contains the utility procedures that you created as part of the DrawPlate project.

In the Project Explorer, right-click the new project and choose Insert Module. Change the default name of the new module to basRoomLabel.

On the menu bar, click File Save.

Creating the RoomLabel Block Definition

Creating separate drawing files that your custom programs depend on has advantages and disadvantages. One advantage of creating a separate drawing file is that you can use the AutoCAD user interface to create the block file. However, AutoCAD must be able to locate the drawing file so that the custom program can use the file. If AutoCAD can't locate the file, the custom program will have problems. Creating a block definition through code allows you to avoid the need of maintaining separate files for your blocks, thus making it easier to share a custom application with your clients or subcontractors. A disadvantage of using code to create your blocks is the time it takes to write the code for all your blocks and then having to maintain the code once it has been written.

In these steps, you create a custom function named roomlabel_createblkdef that will be used to create the block definition for the room label block if it doesn't already exist in the drawing.

In the Project Explorer, double-click the basRoomLabel component.

In the text editor area of the basRoomLabel component, type the following. (The comments are here for your information and don't need to be typed.)Private myUtilities As New clsUtilities ' Constant for the removal of the "Command: " prompt msg Const removeCmdPrompt As String = vbBack & vbBack & vbBack & _ vbBack & vbBack & vbBack & _ vbBack & vbBack & vbBack & vbLf Private g_nLastNumber As Integer Private g_sLastPrefix As String ' Creates the block definition roomlabel Private Sub RoomLabel_CreateBlkDef() On Error Resume Next ' Check for the existence of the roomlabel block definition Dim oBlkDef As AcadBlock Set oBlkDef = ThisDrawing.Blocks("roomlabel") ' If an error was generated, create the block definition If Err Then Err.Clear ' Define the block's origin Dim dInsPt(2) As Double dInsPt(0) = 18: dInsPt(1) = 9: dInsPt(2) = 0 ' Create the block definition Set oBlkDef = ThisDrawing.Blocks.Add(dInsPt, "roomlabel") ' Add a rectangle to the block Dim dPtList(7) As Double dPtList(0) = 0: dPtList(1) = 0 dPtList(2) = 36: dPtList(3) = 0 dPtList(4) = 36: dPtList(5) = 18 dPtList(6) = 0: dPtList(7) = 18 Dim oLWPline As AcadLWPolyline Set oLWPline = oBlkDef.AddLightWeightPolyline(dPtList) oLWPline.Closed = True ' Add the attribute definition to the block Dim oAttDef As AcadAttribute Set oAttDef = oBlkDef.AddAttribute(9, acAttributeModeLockPosition, _ "ROOM#", dInsPt, "ROOM#", "L000") oAttDef.Layer = "Plan_RoomLabel_Anno" ' Set the alignment of the attribute oAttDef.Alignment = acAlignmentMiddleCenter oAttDef.TextAlignmentPoint = dInsPt End If End Sub

Click File Save.

Figure 30.3 shows the block definition that is created by this procedure. To see the contents of the block definition, use the bedit command and select the RoomLabel block. As an alternative, you can insert the RoomLabel block into the drawing and explode it.

Figure 30.3 RoomLabel block definition

Inserting a Block Reference Based on the RoomLabel Block Definition

Once you've created the block definition and added it to the AcadBlocks collection object, you can insert it into the drawing by using the insert command or the InsertBlock function in the AutoCAD Object library.

In these steps, you create two custom functions named changeattvalue and roomlabel_insertblkref. The changeattvalue function allows you to revise the insertion point and value of an attribute reference attached to a block reference based on the attribute's tag. The roomlabel_insertblkref function creates a block reference based on the RoomLabel block definition that was created with the roomlabel_createblkdef function.

In the text editor area of the basRoomLabel component, scroll to the bottom of the last procedure and press Enter a few times. Then, type the following. (The comments are here for your information and don't need to be typed.)' Changes the value of an attribute reference in a block reference Private Sub ChangeAttValue(oBlkRef As AcadBlockReference, _ vInsPt As Variant, sAttTag As String, _ sNewValue As String) ' Check to see if the block reference has attribute references If oBlkRef.HasAttributes Then ' Get the attributes of the block reference Dim vAtts As Variant vAtts = oBlkRef.GetAttributes Dim nCnt As Integer ' Step through the attributes in the block reference Dim oAttRef As AcadAttributeReference For nCnt = 0 To UBound(vAtts) Set oAttRef = vAtts(nCnt) ' Compare the attributes tag with the tag ' passed to the function If UCase(oAttRef.TagString) = UCase(sAttTag) Then oAttRef.InsertionPoint = vInsPt oAttRef.TextAlignmentPoint = vInsPt oAttRef.textString = sNewValue ' Exit the For statement Exit For End If Next End If End Sub ' Creates the block definition roomlabel Private Sub RoomLabel_InsertBlkRef(vInsPt As Variant, _ sLabelValue As String) ' Add the layer Plan_RoomLabel_Anno myUtilities.CreateLayer "Plan_RoomLabel_Anno", 150 ' Create the "roomlabel" block definition RoomLabel_CreateBlkDef ' Insert the block into model space Dim oBlkRef As AcadBlockReference Set oBlkRef = ThisDrawing.ModelSpace. _ InsertBlock(vInsPt, "roomlabel", _ 1, 1, 1, 0) ' Changes the attribute value of the "ROOM#" ChangeAttValue oBlkRef, vInsPt, "ROOM#", sLabelValue End Sub

Click File Save.

Prompting the User for an Insertion Point and a Room Number

Now that you have defined the functions to create the block definition and inserted the block reference into a drawing, the last function creates the main procedure that will prompt the user for input. The roomlabel procedure will allow the user to specify a point in the drawing, provide a new room number, or provide a new prefix. The roomlabel procedure uses the default number of 101 and prefix of L. As you use the roomlabel procedure, it increments the counter by 1 so that you can continue placing room labels.

In these steps, you create the custom procedure named roomlabel that uses all of the functions that you defined in this exercise to place a RoomLabel block each time you specify a point in the drawing.

In the text editor area of the basRoomLabel component, scroll to the bottom of the last procedure and press Enter a few times. Then, type the following. (The comments are here for your information and don't need to be typed.)' Prompts the user for an insertion point and room number Public Sub RoomLabel() On Error Resume Next ' Set the default values Dim nLastNumber As Integer, sLastPrefix As String If g_nLastNumber <> 0 Then nLastNumber = g_nLastNumber sLastPrefix = g_sLastPrefix Else nLastNumber = 101 sLastPrefix = "L" End If ' Display current values ThisDrawing.Utility.Prompt removeCmdPrompt & _ "Prefix: " & sLastPrefix & _ vbTab & "Number: " & CStr(nLastNumber) Dim basePt As Variant ' Continue to ask for input until a point is provided Do Dim sKeyword As String sKeyword = "" basePt = Null ' Setup default keywords ThisDrawing.Utility.InitializeUserInput 0, "Number Prefix" ' Prompt for a base point, number, or prefix value basePt = ThisDrawing.Utility.GetPoint(, _ removeCmdPrompt & "Specify point for room label (" & _ sLastPrefix & CStr(nLastNumber) & _ ") or change [Number/Prefix]: ") ' If an error occurs, the user entered a keyword or pressed Enter If Err Then Err.Clear sKeyword = ThisDrawing.Utility.GetInput Select Case sKeyword Case "Number" nLastNumber = ThisDrawing.Utility. _ GetInteger(removeCmdPrompt & _ "Enter new room number <" & _ CStr(nLastNumber) & ">: ") Case "Prefix" sLastPrefix = ThisDrawing.Utility. _ GetString(False, removeCmdPrompt & _ "Enter new room number prefix <" & _ sLastPrefix & ">: ") End Select End If ' If a base point was specified, then insert a block reference If IsNull(basePt) = False Then RoomLabel_InsertBlkRef basePt, sLastPrefix & CStr(nLastNumber) ' Increment number by 1 nLastNumber = nLastNumber + 1 End If Loop Until IsNull(basePt) = True And sKeyword = "" ' Store the latest values in the global variables g_nLastNumber = nLastNumber g_sLastPrefix = sLastPrefix End Sub

Click File Save.

Adding Room Labels to a Drawing

The roomlabel.dvb file contains the main roomlabel procedure and some helper functions defined in the clsUtilities.cls file to define new layers.

NOTE

The following steps require a drawing file named ch30_building_plan.dwg. If you didn't download the sample files previously, download them now from www.sybex.com/go/autocadcustomization. Place these sample files in the MyCustomFiles folder under the Documents (or My Documents) folder.

The following steps explain how to use the roomlabel procedure that is in the roomlabel.lsp file:

Open Ch30_Building_Plan.dwg. Figure 30.4 shows the plan drawing of the office building.

At the Command prompt, type vbarun and press Enter.

When the Macros dialog box opens, select the RoomLabel.dvb!basRoomLabel.RoomLabel macro from the list and click Run.

At the Specify point for room label (L101) or change [Number/Prefix]: prompt, specify a point inside the room in the lower-left corner of the building.The room label definition block and Plan_RoomLabel_Anno layer are created the first time the roomlabel procedure is used. The RoomLabel block definition should look like Figure 30.5 when inserted into the drawing.

At the Specify point for room label (L101) or change [Number/Prefix]: prompt, type n and press Enter.

At the Enter new room number <102>: prompt, type 105 and press Enter.

At the Specify point for room label (L105) or change [Number/Prefix]: prompt, type p and press Enter.

At the Enter new room number prefix <L>: prompt, type R and press Enter.

At the Specify point for room label (R105) or change [Number/Prefix]: prompt, specify a point in the large open area in the middle of the building.

Press Enter to end roomlabel.

Close and discard the changes to the drawing file.

Figure 30.4 Plan view of the office building

Figure 30.5 Inserted RoomLabel block

Creating the FurnTools Project

The FurnTools project will contain several functions and main procedures that modify the properties and extract the attribute values of block references that have been inserted into a drawing. The following steps explain how to create a project named FurnTools and save it to a file named furntools.dvb:

Create a new VBA project with the name FurnTools. Make sure to also change the default project name (ACADProject) to FurnTools in the VBA Editor.

In the VBA Editor, in the Project Explorer, right-click the new project and choose Import File.

When the Import File dialog box opens, browse to and select the clsUtilities.cls file in the MyCustomFiles folder. Click Open.The clsUtilities.cls file contains the utility procedures that you created as part of the DrawPlate project.

In the Project Explorer, right-click the new project and choose Insert Module. Change the name of the new module to basFurnTools.

On the menu bar, click File Save.

Moving Objects to Correct Layers

Not everyone will agree on the naming conventions, plot styles, and other various aspects of layers, but there are two things drafters can agree on when it comes to layers:

Objects should inherit their properties, for the most part, from the objects in which they are placed.

Objects should only be placed on layer 0 when creating blocks.

Although I would like to think that all of the drawings I have ever created are perfect, I know they aren't. Rushed deadlines, changing project parameters, and other distractions impede perfection. Objects may have been placed on the wrong layer, or maybe it wasn't my fault and standards simply changed during the course of a project. With VBA and the AutoCAD Object library, you can identify potential problems in a drawing and let the user know about them so they can be fixed. You might even be able to fix the problems automatically without user input.

In these steps, you will create a custom procedure named furnlayers that will be used to identify objects by type and value to ensure they are placed on the correct layer. This is achieved by using selection sets and entity data lists, along with looping and conditional statements.

In the Project Explorer, double-click the basFurnTools component.

In the text editor area of the basFurnTools component, type the following. (The comments are here for your information and don't need to be typed.)Private myUtilities As New clsUtilities ' Constants for PI Const PI As Double = 3.14159265358979 ' Moves objects to the correct layers based on a set of established rules Sub FurnLayers() On Error Resume Next ' Get the blocks to extract Dim oSSFurn As AcadSelectionSet Set oSSFurn = ThisDrawing.SelectionSets.Add("SSFurn") ' If an error is generated, selection set already exists If Err Then Err.Clear Set oSSFurn = ThisDrawing.SelectionSets("SSFurn") End If ' Define the selection set filter to select only blocks Dim nDXFCodes(3) As Integer, nValue(3) As Variant nDXFCodes(0) = -4: nValue(0) = "<OR": nDXFCodes(1) = 0: nValue(1) = "INSERT" nDXFCodes(2) = 0: nValue(2) = "DIMENSION" nDXFCodes(3) = -4: nValue(3) = "OR>" Dim vDXFCodes As Variant, vValues As Variant vDXFCodes = nDXFCodes vValues = nValue ' Allow the user to select objects in the drawing oSSFurn.SelectOnScreen vDXFCodes, vValues ' Proceed if oSSFurn is greater than 0 If oSSFurn.Count > 0 Then ' Step through each object in the selection set Dim oEnt As AcadEntity For Each oEnt In oSSFurn ' Check to see if the object is a block reference If oEnt.ObjectName = "AcDbBlockReference" Then Dim oBlkRef As AcadBlockReference Set oBlkRef = oEnt ' Get the name of the block, use EffectiveName because ' the block could be dynamic Dim sBlkName As String sBlkName = oBlkRef.EffectiveName ' If the block name starts with RD or CD, ' then place it on the surfaces layer If sBlkName Like "RD*" Or _ sBlkName Like "CD*" Then oBlkRef.Layer = "Surfaces" ' If the block name starts with PNL, PE, and PX, ' then place it on the panels layer ElseIf sBlkName Like "PNL*" Or _ sBlkName Like "PE*" Or _ sBlkName Like "PX*" Then oBlkRef.Layer = "Panels" ' If the block name starts with SF, ' then place it on the panels layer ElseIf sBlkName Like "SF*" Or _ sBlkName Like "FF*" Then oBlkRef.Layer = "Storage" End If ElseIf oEnt.ObjectName Like "AcDb*Dim*" Then oEnt.Layer = "Dimensions" End If Next oEnt ' Remove the selection set oSSFurn.Delete End If End Sub

Click File Save.

Creating a Basic Block Attribute Extraction Program

The designs you create take time and often are a source of income or savings for your company. Based on the types of objects in a drawing, you can step through a drawing and get attribute information from blocks or even geometric values such as lengths and radii of circles. You can use the objects in a drawing to estimate the potential cost of a project or even provide information to manufacturing.

In these steps, you create four custom functions named ExtAttsFurnBOM, SortArray, TableFurnBOM, and RowValuesFurnBOM. The ExtAttsFurnBOM function extracts the values of the attributes in the selected blocks and then uses the SortArray function to sort the attribute values before quantifying them. The TableFurnBOM and RowValuesFurnBOM functions are used to create a grid of lines containing the extracted values.

In the text editor area of the basFurnTools component, scroll to the bottom of the last procedure and press Enter a few times. Then, type the following. (The comments are here for your information and don't need to be typed.)' ExtAttsFurnBOM - Extracts, sorts, and quantifies the attribute information Private Function ExtAttsFurnBOM(oSSFurn As AcadSelectionSet) As Variant Dim sList() As String Dim sPart As String, sLabel As String ' Step through each block in the selection set Dim oBlkRef As AcadBlockReference Dim nListCnt As Integer nListCnt = 0 For Each oBlkRef In oSSFurn ' Step through the objects that appear after ' the block reference, looking for attributes Dim vAtts As Variant vAtts = oBlkRef.GetAttributes ' Check to see if the block has attributes If oBlkRef.HasAttributes = True Then ' Get the attributes of the block reference Dim vAttRefs As Variant vAttRefs = oBlkRef.GetAttributes Dim oAttRef As AcadAttributeReference Dim nAttCnt As Integer For nAttCnt = LBound(vAttRefs) To UBound(vAttRefs) Set oAttRef = vAttRefs(nAttCnt) If UCase(oAttRef.TagString) = "PART" Then sPart = oAttRef.textString ElseIf UCase(oAttRef.TagString) = "LABEL" Then sLabel = oAttRef.textString End If Next End If ' Resize the array ReDim Preserve sList(nListCnt) ' Add the part and label values to the array sList(nListCnt) = sLabel & vbTab & sPart ' Increment the counter nListCnt = nListCnt + 1 Next oBlkRef ' Sort the array of parts and labels Dim vFurnListSorted As Variant vFurnListSorted = SortArray(sList) ' Quantify the list of parts and labels ' Step through each value in the sorted array Dim sFurnList() As String Dim vCurVal As Variant, sPreVal As String Dim sItems As Variant nCnt = 0: nListCnt = 0 For Each vCurVal In vFurnListSorted ' Check to see if the previous value is the same as the current value If CStr(vCurVal) = sPreVal Or sPreVal = "" Then ' Increment the counter by 1 nCnt = nCnt + 1 ' Values weren't the same, so record the quantity Else ' Split the values of the item sItems = Split(sPreVal, vbTab) ' Resize the array ReDim Preserve sFurnList(nListCnt) ' Add the part and label values to the array sFurnList(nListCnt) = CStr(nCnt) & vbTab & sItems(0) & vbTab & sItems(1) ' Increment the array counter nListCnt = nListCnt + 1 ' Reset the counter nCnt = 1 End If sPreVal = CStr(vCurVal) Next vCurVal ' Append the last item ' Split the values of the item sItems = Split(sPreVal, vbTab) ' Resize the array ReDim Preserve sFurnList(nListCnt) ' Add the part and label values to the array sFurnList(nListCnt) = CStr(nCnt) & vbTab & sItems(0) & vbTab & sItems(1) ' Return the sorted and quantified array ExtAttsFurnBOM = sFurnList End Function ' Performs a basic sort on the string values in an array, ' and returns the newly sorted array. Private Function SortArray(vArray As Variant) As Variant Dim nFIdx As Integer, nLIdx As Integer nFIdx = LBound(vArray): nLIdx = UBound(vArray) Dim nOuterCnt As Integer, nInnerCnt As Integer Dim sTemp As String For nOuterCnt = nFIdx To nLIdx - 1 For nInnerCnt = nOuterCnt + 1 To nLIdx If vArray(nOuterCnt) > vArray(nInnerCnt) Then sTemp = vArray(nInnerCnt) vArray(nInnerCnt) = vArray(nOuterCnt) vArray(nOuterCnt) = sTemp End If Next nInnerCnt Next nOuterCnt SortArray = vArray End Function ' Create the bill of materials table/grid Private Sub TableFurnBOM(vQtyList As Variant, dInsPt() As Double) ' Define the sizes of the table and grid Dim dColWidths(3) As Double dColWidths(0) = 0: dColWidths(1) = 15 dColWidths(2) = 45: dColWidths(3) = 50 Dim dTableWidth As Double, dTableHeight As Double dTableWidth = 0: dTableHeight = 0 Dim nRow As Integer nRow = 1 Dim dRowHeight As Double, dTextHeight As Double dRowHeight = 4: dTextHeight = dRowHeight - 1 ' Get the table width by adding all column widths Dim vColWidth As Variant For Each vColWidth In dColWidths dTableWidth = dTableWidth + CDbl(vColWidth) Next vColWidth ' Define the standard table headers Dim sHeaders(2) As String sHeaders(0) = "QTY": sHeaders(1) = "LABELS": sHeaders(2) = "PARTS" ' Create the top of the table Dim vInsPtRight As Variant vInsPtRight = ThisDrawing.Utility.PolarPoint( _ dInsPt, 0, dTableWidth) Dim oLine As AcadLine Set oLine = ThisDrawing.ModelSpace.AddLine(dInsPt, vInsPtRight) ' Get the bottom of the header row Dim vBottomRow As Variant vBottomRow = ThisDrawing.Utility.PolarPoint( _ dInsPt, ((PI / 2) * -1), dRowHeight) ' Add headers to the table RowValuesFurnBOM sHeaders, vBottomRow, dColWidths, dTextHeight ' Step through each item in the list Dim vItem As Variant For Each vItem In vQtyList nRow = nRow + 1 vBottomRow = ThisDrawing.Utility.PolarPoint( _ dInsPt, ((PI / 2) * -1), dRowHeight * nRow) RowValuesFurnBOM Split(vItem, vbTab), vBottomRow, dColWidths, dTextHeight Next vItem ' Create the vertical lines for each column dColWidthTotal = 0 For Each vColWidth In dColWidths ' Calculate the placement of each vertical line (left to right) dColWidthTotal = CDbl(vColWidth) + dColWidthTotal Dim vColBasePt As Variant vColBasePt = ThisDrawing.Utility.PolarPoint( _ dInsPt, 0, dColWidthTotal) Dim vColBottomPt As Variant vColBottomPt = ThisDrawing.Utility.PolarPoint( _ vColBasePt, ((PI / 2) * -1), _ myUtilities.Calc2DDistance(dInsPt(0), _ dInsPt(1), _ vBottomRow(0), _ vBottomRow(1))) ' Draw the vertical line Set oLine = ThisDrawing.ModelSpace.AddLine(vColBasePt, vColBottomPt) Next vColWidth End Sub ' Create a row and populate the data for the table Private Sub RowValuesFurnBOM(vItems As Variant, _ vBottomRow As Variant, _ vColWidths As Variant, _ dTextHeight As Double) ' Calculate the insertion point for the header text Dim dRowText(2) As Double dRowText(0) = 0.5 + vBottomRow(0) dRowText(1) = 0.5 + vBottomRow(1) dRowText(2) = vBottomRow(2) Dim dTableWidth As Double dTableWidth = 0 ' Get the table width by adding all column widths Dim vColWidth As Variant For Each vColWidth In vColWidths dTableWidth = dTableWidth + CDbl(vColWidth) Next vColWidth ' Lay out the text in each row Dim nCol As Integer, dColWidthTotal As Double nCol = 0: dColWidthTotal = 0 Dim vItem As Variant For Each vItem In vItems ' Calculate the placement of each text object (left to right) dColWidthTotal = dColWidthTotal + vColWidths(nCol) Dim vInsTextCol As Variant vInsTextCol = ThisDrawing.Utility.PolarPoint( _ dRowText, 0, dColWidthTotal) ' Draw the single-line text object Dim oText As AcadText Set oText = ThisDrawing.ModelSpace.AddText(CStr(vItem), _ vInsTextCol, dTextHeight) ' Create the row line Dim vBottomRowRight As Variant vBottomRowRight = ThisDrawing.Utility.PolarPoint( _ vBottomRow, 0, dTableWidth) Dim oLine As AcadLine Set oLine = ThisDrawing.ModelSpace.AddLine(vBottomRow, vBottomRowRight) ' Increment the counter nCol = nCol + 1 Next vItem End Sub ' Extracts, aggregates, and counts attributes from the furniture blocks Sub FurnBOM() On Error Resume Next ' Get the blocks to extract Dim oSSFurn As AcadSelectionSet Set oSSFurn = ThisDrawing.SelectionSets.Add("SSFurn") ' If an error is generated, selection set already exists If Err Then Err.Clear Set oSSFurn = ThisDrawing.SelectionSets("SSFurn") End If ' Define the selection set filter to select only blocks Dim nDXFCodes(0) As Integer, nValue(0) As Variant nDXFCodes(0) = 0 nValue(0) = "INSERT" Dim vDXFCodes As Variant, vValues As Variant vDXFCodes = nDXFCodes vValues = nValue ' Allow the user to select objects in the drawing oSSFurn.SelectOnScreen vDXFCodes, vValues ' Use the ExtAttsFurnBOM to extract and quantify the attributes in the blocks ' If a selection set was created, then look for attributes If oSSFurn.Count > 0 Then ' Extract and quantify the parts in the drawing Dim vAttList As Variant vAttList = ExtAttsFurnBOM(oSSFurn) ' Create the layer named BOM and set it current Dim oLayer As AcadLayer Set oLayer = myUtilities.CreateLayer("BOM", 8) Set ThisDrawing.ActiveLayer = oLayer.Name ' Prompt the user for the point to create the BOM Dim vInsPt As Variant vInsPt = ThisDrawing.Utility.GetPoint(, vbLf & _ "Specify upper-left corner of BOM: ") ' Start the function that creates the table grid Dim dInsPt(2) As Double dInsPt(0) = vInsPt(0): dInsPt(1) = vInsPt(1): dInsPt(2) = vInsPt(2) TableFurnBOM vAttList, dInsPt ' Remove the selection set oSSFurn.Delete End If End Sub

Click File Save.

Using the Procedures of the FurnTools Project

The procedures you added to FurnTools project leverage some of the functions defined in clsUtilities.cls. These tools allow you to change the layers of objects in a drawing and extract information from the objects in a drawing as well. More specifically, they allow you to work with blocks that represent an office furniture layout.

Although you might be working in a civil engineering– or mechanical design–related field, these concepts can and do apply to the work you do—just in different ways. Instead of extracting information from a furniture block, you could get and set information in a title block, a callout, or even an elevation marker. Making sure hatching is placed on the correct layers along with dimensions can improve the quality of output for the designs your company creates.

NOTE

The following steps require a drawing file named ch30_building_plan.dwg. If you didn't download the sample files previously, download them now from www.sybex.com/go/autocadcustomization. Place these sample files in the MyCustomFiles folder under the Documents (or My Documents) folder.

The following steps explain how to use the FurnLayers procedure:

Open ch30_building_plan.dwg.

At the Command prompt, type vbarun and press Enter.

When the Macros dialog box opens, select the FurnTools.dvb!basFurnTools.FurnLayers macro from the list and click Run.

At the Select objects: prompt, select all the objects in the drawing and press Enter. The objects in the drawing are placed on the correct layers, and this can be seen as the objects were all previously placed on layer 0 and had a color of white (or black based on the background color of the drawing area).

The following steps explain how to use the FurnBom procedure:

At the Command prompt, type vbarun and press Enter.

When the Macros dialog box opens, select the FurnTools.dvb!basFurnTools.FurnBOM macro from the list and click Run.

At the Select objects: prompt, select all the objects in the drawing. Don't press Enter yet. Notice that the dimension objects aren't highlighted. As a result of the selection set filter being applied with the SelectOnScreen function, the SelectOnScreen function only allows block references (insert object types) to be selected.

Press Enter to end the object selection.

At the Specify upper-left corner of BOM: prompt, specify a point to the right of the furniture layout in the drawing. The bill of materials that represents the furniture blocks is placed in a table grid, as shown Figure 30.6.

Close and discard the changes to the drawing file.

Figure 30.6 Bill of materials generated from the office furniture layout

Chapter 31

Outputting Drawings

Autodesk® AutoCAD® drawing files are the living documents that an engineer or a drafter creates to communicate the product or building being designed. Typically before a design is brought from the digital to the physical world, it goes through a series of reviews and then final sign-off with the customer. As part of the review and sign-off process, it is common practice to output a drawing file to an electronic file or hardcopy—known as paper.

Plotting is the most common way of outputting a drawing, whether to an electronic file or to a hardcopy. You indicate which layouts to plot and plot settings to use. Plot settings can be assigned directly to an individual layout or assigned to multiple layouts using a page setup. A layout typically contains one or more viewports that display objects from model space and a title block that provides information about the objects in the viewport, such as project location and recent revisions.

In addition to plotting a layout, you can use the information contained in a drawing with another application by exporting or importing other file types. For example, you might use an external structural analysis or sun study application to complete some of the tasks you perform or even insert an image of the drawing into a presentation.

Creating and Managing Layouts

A layout—also known as paper space—is used to organize and control which objects should be output to an electronic file or hardcopy, and how. Layouts are the digital equivalent of a physical sheet of paper in which objects from model space are displayed using floating viewports. A floating viewport allows you to specify which area of model space to display and at which scale to display it on a layout. Each floating viewport can display a separate area of model space and have a different scale. I explain how to create and modify floating viewports in the「Displaying Model Space Objects with Viewports」section later in this chapter.

Floating viewports aren't the only objects typically found on a layout. A layout commonly has a title block that provides information about the objects being plotted and which project they are associated with. Dimensions and notes can also be found on a layout. In addition to the graphical objects I mentioned, each layout contains a set of plot settings. The plot settings are used to control how the objects on the layout are output, and which device and paper size should be used when outputting the layout. I discuss plot settings in the「Controlling the Output of a Layout」section later in this chapter.

From the perspective of the AutoCAD Object library, a layout is represented by an AcadLayout object that is stored in the AcadLayouts collection object. You access the AcadLayouts collection object with the Layouts property of the AcadDocument or ThisDrawing object. Unlike most objects in the AutoCAD Object library, a layout is a container object made up of two different object types: AcadBlock and AcadPlotConfiguration.

Creating a Layout

A new layout can be added to a drawing using the Add method of the AcadLayouts collection object. The Add method expects a string that represents the name of the new layout to add and returns an AcadLayout object of the new layout added. Each layout must have a unique name. You can use the Item method with an error handler to check to see if a layout with a specific name already exists in the drawing or to get a specific layout in the AcadLayouts collection object. Just like other collections, a For statement can be used to step through the layouts in a drawing.

The following code statements add a new layout named Demolition:

Dim oLayout As AcadLayout Set oLayout = ThisDrawing.Layouts.Add("Demolition")

Here are example code statements that check for the existence of a layout named Demolition:

On Error Resume Next Dim oLayout As AcadLayout Set oLayout = ThisDrawing.Layouts("Demolition") If Err Then MsgBox "Layout isn't in the drawing." Else MsgBox "Layout was found." End If

When a layout is no longer needed, it can be removed from the drawing using the Delete method of an AcadLayout object.

NOTE

After you create a new layout, you can copy the plot settings from an existing layout to another layout with the CopyFrom method. I explain the CopyFrom method in the「Creating and Managing Named Page Setups」section.

Working with a Layout

Once a layout has been created, it can be set as current or objects can be added to it, like adding objects to model space. The ActiveLayout property of the AcadDocument object is used to set a layout as current. The ActiveLayout property expects an object of the AcadLayout type, which can be obtained by the Add or Item method of the AcadLayouts collection object. You can also use the ActiveLayout property to get the AcadLayout object of the current layout.

The following code statement sets a layout named Demolition as current:

ThisDrawing.ActiveLayout = ThisDrawing.Layouts("Demolition")

NOTE

When a layout is set as current using the ActiveLayout property or the layout tabs along the bottom of a drawing window in the AutoCAD user interface, an event named LayoutSwitched is triggered, if it has been defined. You can use this event to control the display of objects on a layout after it is set as current or to change the values of system variables as needed. The LayoutSwitched event is a member of the AcadDocument object. I explain how to use events for the AcadDocument object in Chapter 33,「Modifying the Application and Working with Events.」

The Block property of an AcadLayout object returns the AcadBlock object, which contains the graphical objects on a layout. I explained how to work with blocks in Chapter 30,「Working with Blocks and External References.」In addition to using the Block property to get the objects on a layout, the PaperSpace property of an AcadDocument or a ThisDrawing object can be used to access the objects on a layout. The PaperSpace property returns an AcadPaperSpace object, which is the only way to add a floating viewport to a layout. A floating viewport displays the objects in model space on a layout. I explain how to add and modify floating viewports in the「Displaying Model Space Objects with Viewports」section.

The following code statements insert a drawing file named c-tblk.dwg onto the layout named Demolition:

' Gets the layout named Demolition Dim oLayout As AcadLayout Set oLayout = ThisDrawing.Layouts("Demolition") ' Defines the title block name and location Dim sTitleBlk As String sTitleBlk = ThisDrawing.GetVariable("MyDocumentsPrefix") & _ "\c-tblk.dwg" ' Inserts the drawing at 0,0,0 Dim dInsPt(2) As Double dInsPt(0) = 0: dInsPt(1) = 0: dInsPt(2) = 0 oLayout.Block.InsertBlock dInsPt, sTitleBlk, 1, 1, 1, 0

Controlling the Display of Layout Tabs

The layouts of an open drawing are typically accessed by the user with the tabs displayed along the bottom of a drawing window. The display of the layout tabs can be toggled with the DisplayLayoutTabs property of the AcadPreferencesDisplay object. I explained how to access the preferences of the AutoCAD application and an open drawing in Chapter 26,「Interacting with the Application and Documents Objects.」

Along with controlling the display of the layout tabs, you can control the order in which layouts appear. The TabOrder property of the AcadLayout object can be used to get or set the order of a layout. The leftmost tab has an order of 0 and is always the Model tab. The order of the Model tab can't be changed, but that of a named layout can. You assign the TabOrder property an integer value that specifies the new location of the tab; the order of all other layouts is automatically updated.

Displaying Model Space Objects with Viewports

The objects added to a layout fall into one of two categories: annotation or viewports. Annotation can be in the form of general notes, dimensions, tables, and even a title block. You place annotation on a layout to help communicate your design. Although a title block isn't typically thought of as annotation, in the general sense any object that isn't part of the actual design in a drawing is annotation.

Viewports are windows into model space that control the objects to be displayed on a layout; not only do they control the display of objects; viewports also control the scale at which the objects are displayed. The viewport on a layout, other than the Model tab, is represented by the AcadPViewport object and shouldn't be confused with the AcadViewport object, which represents a tiled viewport in model space. You learned about tiled viewports in Chapter 28,「Interacting with the User and Controlling the Current View.」

Adding a Floating Viewport

A floating viewport can be added to a layout using the AddPViewport function. The AddPViewport function returns an AcadPViewport object and expects three argument values that define the placement and size of the floating viewport. Once the floating viewport has been created, you then define the area of model space that should be displayed and at which scale. I explain how to modify a viewport in the「Modifying a Floating Viewport」section later in this chapter.

The following shows the syntax of the AddPViewport function:

retVal = object.AddPViewport(centerPoint, width, height)

Its arguments are as follows:

object The object argument represents the AcadPaperSpace object returned by the PaperSpace property of an AcadDocument object.

centerPoint The centerPoint argument is an array of doubles that represents the center of the viewport on the layout.

Width and height The width and height arguments are doubles that represent the width and height of the viewport.

The following code statements create a new viewport that is 200 units wide by 190 units high and centered at 102,97.5:

' Get the active paper space block Dim oPSpace As AcadPaperSpace Set oPSpace = ThisDrawing.PaperSpace ' Define the center point of the viewport Dim dCenPt(2) As Double dCenPt(0) = 102: dCenPt(1) = 97.5: dCenPt(2) = 0 ' Add the viewport to the layout Dim oPVport As AcadPViewport Set oPVport = oPSpace.AddPViewport(dCenPt, 200, 190)

NOTE

Viewports added with the AddPViewport function are off by default. When a viewport is turned off, the objects in model space aren't displayed. You use the Display method of an AcadPViewport object to turn on the display of objects in model space. The Display method accepts a single Boolean value: True to turn on a viewport or False to turn it off. The ViewportOn property of an AcadPViewport object can be used to determine the current display state of a viewport. The following code statement turns on a viewport:

object.Display True

Setting a Viewport as Current

The ActivePViewport property of an AcadDocument object is used to determine which viewport is current or to set a viewport as current. Before you set a viewport as current, model space must be active. Model space can be set as active using the MSpace property of an AcadDocument object. When the MSpace property is True, objects in model space can be edited. The changes made through a viewport on a layout are the same as if they were made on the Model tab or in model space directly.

The following code statements make the viewport object assigned to the oVPort variable active and enable model space:

ThisDrawing.ActivePViewport = oVPort ThisDrawing.MSpace = True

As an alternative to the MSpace property, you can use the ActiveSpace property to determine which space is active and to switch between model space and paper space while a layout is active. The MSpace property can't be used from the Model tab, but the ActiveSpace property can be. You can use ActiveSpace to switch to paper space if paper space isn't currently active. ActiveSpace behaves similar to the tilemode system variable.

The following code statement sets paper space active on a layout or switches from the Model tab to the most recently used named layout:

ThisDrawing.ActiveSpace = acPaperSpace

Modifying a Floating Viewport

Once a viewport has been added to a layout or a reference to an AcadPViewport object has been obtained, you can modify its properties. The properties of a viewport allow you to do the following:

Control which area of model space is visible and the scale at which objects are displayed

Specify the general visibility settings for the objects in model space

Determine whether a viewport represents a view in a sheet set

Specifying the Display Settings for a Viewport

The objects that are displayed in a viewport vary based on the features of a design being communicated. For example, in some drawings you might want to display all objects, whereas in others you might only want to show a small area to be detailed.

Table 31.1 lists the properties of an AcadPViewport object that control the display of objects from model space objects. The following code statements change the arc smoothness and display locking status for a floating viewport assigned to the oPVport:

oPVport.ArcSmoothness = 1500 oPVport.DisplayLocked = True

Table 31.1 Display-related properties of an AcadPViewport object

Property Description

ArcSmoothness Specifies the smoothness for curved model space objects. Enter a value from 1 to 20,000.

Clipped Returns True if the viewport is clipped. There is no method for clipping a viewport; you must use the vpclip command.

Direction Specifies the view direction of the model space objects. View direction is expressed as an array of three double values.

DisplayLocked Specifies the lock state of the viewport's display. When the display is locked, the user isn't able to change the viewport's view.

LayerPropertyOverrides Returns True if the viewport has layer overrides applied. There is no method for applying or modifying layer overrides; you must use the -vport command.

LensLength Specifies the lens length applied to the viewport when perspective viewing is enabled; use the perspective system variable to enable perspective view in the current viewport.

ModelView Specifies the AcadView object that defines the area of model space that should be displayed in the viewport. After assigning an AcadView object, you must execute the SyncModelView method to update the view in the viewport to match the AcadView object.

ShadePlot Specifies the visual style that should be applied to the model space objects displayed in the viewport.

Target Specifies the target point of the current view in the viewport.

TwistAngle Specifies the twist angle to be applied to the current view in the viewport.

You can learn more about the properties listed in Table 31.1 from the AutoCAD Help system.

Scaling Objects in a Viewport

In addition to defining which area of model space to display in a viewport, the scale at which the objects are displayed is critical to outputting a design. When you produce a drawing, the objects displayed are commonly output at a specific scale so the recipient of the hardcopy can do measurements in the field. The StandardScale and CustomScale properties allow you to set the scale for the objects in model space.

The StandardScale property lets you specify a standard scale value from a set of constant values. The constant values include many standard plot scales used in Imperial and metric drawings in addition to the values that fit all objects in model space to the viewport or that use a custom scale. When using the acVpScaleToFit constant value, the extents of all the objects in model space are displayed and a custom scale is applied to the viewport.

An example of a constant value that represents a standard scale is acVp1_4in_1ft, which assigns a scale of ¼″ = 1′-0″ to a viewport. You can get a full list of the constant values that are supported by searching on AcViewportScale in the Object Browser of the VBA Editor.

Unlike the StandardScale property, the CustomScale property accepts and returns a double value that defines the scale factor for the objects displayed in a viewport. For example, the scale factor of ¼″ = 1′-0″ is 0.02083, which is calculated by dividing 0.25 by 12. To use a custom scale, the StandardScale property must be assigned the constant value of acVpCustomScale.

The following code statement sets the scale factor of ½″ = 1′-0″ using the constant value acVp1_2in_1ft to a viewport assigned to the variable oVPort:

oVPort.StandardScale = acVp1_2in_1ft

Establishing the Settings for Drafting Aids in a Viewport

Although viewports are commonly used to display objects from model space, an end user can work in model space from a viewport. Double-clicking over a viewport enters model space from that viewport. When a viewport is activated, many of the drafting aids available in model space are also available for use from within a viewport. Each viewport stores the current state and settings for several drafting aids.

Table 31.2 lists the properties of an AcadPViewport object that enable and control drafting aids related to model space objects in a viewport. The following code statements disable the grid and snap modes for a floating viewport assigned to the oPVport:

oPVport.Grid = False oPVport.SnapOn = False

Table 31.2 Drafting aids–related properties of an AcadPViewport object

Property Description

GridOn Displays the grid in a viewport

SnapBasePoint Specifies the base point of snap mode in a viewport; the base point is an array of three double values

SnapOn Enables snap mode in a viewport

SnapRotationAngle Specifies the rotation angle of snap mode in a viewport

UCSIconAtOrigin Displays the user coordinate system (UCS) icon at the origin of the drawing when the origin is visible in a viewport

UCSIconOn Displays the UCS icon in a viewport

UCSPerViewport Enables the ability to change the orientation of the UCS icon in a viewport

The GridOn and SnapOn properties are used to enable or disable the use of the grid or snap modes but don't affect the grid or snap spacing. The GetGridSpacing and GetSnapSpacing methods return the current X and Y spacing values of the grid and snap modes of a viewport. Typically, the grid and snap spacing values are the same, but they don't need to be. To change the current spacing values of the grid and snap modes, use the SetGridSpacing and SetSnapSpacing methods. The SetGridSpacing and SetSnapSpacing methods accept two double values: the first sets the X spacing value of the grid or snap mode, and the second sets the Y spacing value.

You can learn more about the properties listed in Table 31.2 from the AutoCAD Help system.

Getting Information about a Sheet View

A sheet view is a viewport with some additional information. The drawings are part of a sheet set and contain layouts with named views in model space. The AutoCAD Object library doesn't allow you to create or manage sheet views created with the Sheet Set Manager.

NOTE

You can use the Sheet Set Object library to create and manage sheet views. I explain how to reference other libraries in Chapter 35,「Communicating with Other Applications.」

Table 31.3 lists the properties of an AcadPViewport object that allow you to obtain information about a sheet view.

Table 31.3 Sheet view–related properties of an AcadPViewport object

Property Description

HasSheetView Returns True if the viewport is associated with a sheet view

LabelBlockId Specifies the object ID of the AcadBlock object that is used as the label block for the viewport

SheetView Specifies the AcadView object that represents the sheet view associated with the viewport

You can learn more about the properties listed in Table 31.3 from the AutoCAD Help system.

Controlling the Output of a Layout

In addition to organizing graphical objects for output, a layout also includes a set of properties known as plot settings. The plot settings of a layout specify the device, paper size, scale, and orientation for output. Other settings control the output of a layout to an electronic file or hardcopy. Plot settings can be stored in what is known as a plot configuration. In the AutoCAD user interface, a plot configuration is referred to as a page setup.

A plot configuration or page setup allows you to apply the same plot settings to multiple layouts. The AcadPlotConfiguration object represents one of the page setups stored in a drawing. All page setups in a drawing are accessed from the AcadPlotConfigurations collection object. You obtain the AcadPlotConfigurations collection object of a drawing by using the PlotConfigurations property of an AcadDocument object.

Creating and Managing Named Page Setups

The Add function of the AcadPlotConfigurations collection object creates a new page setup and returns an AcadPlotConfiguration object. When adding a new page setup with the Add function, you must provide a string that contains a unique name for the page setup. The Add function also accepts a second optional argument of the Boolean data type that specifies the model type for the page setup.

A Boolean value of True creates a page setup that can only be applied to the Model tab or False for a page setup that can be applied to a named layout. If no model type is specified, the model type is determined by the active layout tab. When working with an existing page setup, you can check its model type by using the ModelType property of an AcadPlotConfiguration object.

The following code statements create a new page setup named CheckPlot that can be applied to a named layout:

Dim oPltConfig As AcadPlotConfiguration Set oPltConfig = ThisDrawing.PlotConfigurations. _ Add("CheckPlot", False)

If you want to modify an existing page setup, use the Item method of the AcadPlotConfigurations collection object or a For statement to obtain an AcadPlotConfiguration object. Once an AcadPlotConfiguration object has been obtained, you can then modify the individual properties of the page setup or copy the properties of another page setup. The CopyFrom method of an AcadPlotConfiguration object copies the plot settings from one page setup to another. It accepts a single argument that specifies an AcadPlotConfiguration object type.

TIP

The CopyFrom method can be used to apply plot settings between two AcadLayout or AcadPlotConfiguration objects. The objects don't need to be of the same type, so you can copy the plot settings between a layout and a page setup.

When a page setup is no longer needed, it can be removed from the drawing using the Delete method of an AcadPlotConfiguration object. Even if an AcadPlotConfiguration object was applied to a layout, it can be removed from the drawing, as the plot settings of a plot configuration are copied to a layout and not referenced by a layout. This is unlike other named objects. For example, a dimension style is referenced to a dimension object.

Specifying an Output Device and a Paper Size

Plot settings contain two main properties that control the device and paper size to use when outputting a layout. The name of the device to use when outputting a layout is specified by the ConfigName property of an AcadPlotConfiguration object. A device name can be a system printer configured in Windows or a PC3 file that is created and managed with the AutoCAD Plotter Manager (started with the plottermanager command).

The devices you can assign to the plot settings of a layout or page setup are the same ones listed in the Printer/Plotter drop-down list of the Plot and Page Setup dialog boxes. Although you can use the Printer/Plotter drop-down list to get an idea of which devices are available to your programs, the actual name of a device might be different. Use the GetPlotDeviceNames function to obtain an array of the names for the available output devices that can be assigned to the ConfigName property.

NOTE

Before you can use the GetPlotDeviceNames function, you must execute the RefreshPlotDeviceInfo method. The RefreshPlotDeviceInfo method updates the information on the available devices. You must also execute the RefreshPlotDeviceInfo method before using the GetCanonicalMediaNames function.

The paper size—physical or virtual—used to output a layout is known as a canonical media name. A canonical media name is a unique string used to identify a paper size supported by the device assigned to the ConfigName property. You specify a canonical media name for the plot settings with the CanonicalMediaName property of an AcadPlotConfiguration object. The GetCanonicalMediaNames function is used to obtain an array of all canonical media names of the device specified by the ConfigName property.

In addition to a canonical media name, each paper size has a locale media name. The locale media name is the name of a paper size that is displayed in the Paper Size drop-down list of the Plot and Page Setup dialog boxes. You can get the locale media name of a paper size by passing a canonical media name to the GetLocaleMediaName function.

The paper sizes that a device supports have a fixed size and margin, you can get the dimensions of the paper size assigned to the CanonicalMediaName property with the GetPaperSize method. The GetPaperSize method can be used to return two double values that represent the width and height of the paper size, whereas the GetPaperMargins method returns two arrays of two double values that represent the number of millimeters from the lower-left and upper-right corners of the paper.

The following code statements display a message box with the paper size and plottable area assigned to the current layout. The plottable area is calculated by the subtracting the margin from the paper size.

Dim vLowerLeft As Variant, vUpperRight As Variant Dim oLayout As AcadLayout Dim dHeight As Double, dWidth As Double ' Gets the active layout Set oLayout = ThisDrawing.ActiveLayout ' Gets the margin and paper size oLayout.GetPaperMargins vLowerLeft, vUpperRight oLayout.GetPaperSize dWidth, dHeight MsgBox "Layout paper size: " & CStr(dWidth) & " x " & _ CStr(dHeight) & vbLf & _ "Plottable area: " & _ CStr(dWidth - vUpperRight(0) - vLowerLeft(0)) & _ " x " & CStr(dHeight - vUpperRight(1) - vLowerLeft(1))

TIP

The canonical media name specified indicates the orientation of the paper to output the plot, but the PlotRotation property of an AcadPlotConfiguration object can be used to rotate the paper in 90-degree increments. The PlotRotation property expects a constant value of ac0degrees, ac90degrees, ac180degrees, or ac270degrees.

The following code statements assign the DWF6 ePlot.pc3 device and a paper size of ANSI B to a page setup assigned to the oPltConfig variable:

' Set the plot device to DWF6 ePlot oPltConfig.ConfigName = "DWF6 ePlot.pc3" ' Set the paper size to ANSI B oPltConfig.CanonicalMediaName = "ANSI_B_(17.00_x_11.00_Inches)"

The following code statements list all available devices, and the canonical and locale media names of the first paper size of the DWF6 ePlot.pc3 device:

Sub ListDevicesAndPaperSizes() Dim oPltConfig As AcadPlotConfiguration Set oPltConfig = ThisDrawing.PlotConfigurations.Add("Check") ' Display introduction text ThisDrawing.Utility.Prompt vbLf + "Available devices:" ' Update device and paper size information oPltConfig.RefreshPlotDeviceInfo ' Get the available plot devices Dim vDevices As Variant vDevices = oPltConfig.GetPlotDeviceNames ' Output the names of each device For Each sDeviceName In vDevices ThisDrawing.Utility.Prompt vbLf + " " + sDeviceName Next sDeviceName ' Get the first canonical media name of the DWF6 ePlot device oPltConfig.ConfigName = "DWF6 ePlot.pc3" Dim vMediaNames As Variant vMediaNames = oPltConfig.GetCanonicalMediaNames ' Display first canonical media name ThisDrawing.Utility.Prompt vbLf + "Canonical media name: " + _ vMediaNames(0) ' Display first locale media name ThisDrawing.Utility.Prompt vbLf + "Locale media name: " + _ oPltConfig.GetLocaleMediaName(vMediaNames(0)) + _ vbLf End Sub

Here is an example of the output that is created by the sample code:

Available devices: None Snagit 11 Send To OneNote 2013 Microsoft XPS Document Writer HP ePrint Fax Default Windows System Printer.pc3 DWF6 ePlot.pc3 DWFx ePlot (XPS Compatible).pc3 DWG To PDF.pc3 PublishToWeb JPG.pc3 PublishToWeb PNG.pc3 Canonical media name: ISO_full_bleed_B5_(250.00_x_176.00_MM) Locale media name: ISO full bleed B5 (250.00 x 176.00 MM)

NOTE

The PaperUnits property controls the units used to represent the scale factor and plot offset settings of a layout or page setup. Use the constant value of acInches to set inches as the paper units, acMillimeters for millimeters, or acPixels for pixels. Pixels are typically used when outputting to a raster image.

Setting a Plot Style as Current

Plot styles are used to control the color, linetype, lineweight, screening, and many other settings that affect the way graphical objects are output. A plot style can be one of two types: color-dependent or named. Color-dependent plot styles are stored in CTB files, and named plot styles are stored in STB files. Plot style files are created and managed with the AutoCAD Plot Style Manager (displayed with the stylesmanager command). The name of the plot style to use when outputting a layout is specified by the StyleSheet property of an AcadPlotConfiguration object.

A drawing file can support only one plot style type at a time, either color-dependent or named. The pstylemode system variable indicates whether a drawing is configured to use color-dependent or named plot styles. When the pstylemode system variable returns a value of 1, the drawing is configured to use color-dependent plot styles and CTB files. A value of 0 indicates that a drawing can use named plot styles and STB files. Assigning a plot style of the wrong type to a layout causes an error.

The plot styles you can assign to the plot settings of a layout or page setup are the same ones displayed in the Plot Style Table drop-down list of the Plot and Page Setup dialog boxes. The GetPlotStyleTableNames function is used to obtain an array of the names for the available plot styles that can be assigned to the StyleSheet property.

TIP

Before you can use the GetPlotStyleTableNames function, you must execute the RefreshPlotDeviceInfo method. The RefreshPlotDeviceInfo method updates the information on the available plot styles.

The following code statements assign the monochrome.ctb or monochrome.stb file to a plot configuration assigned to a variable named oPltConfig :

' If pstylemode = 0, then drawing is using named plot styles ' Assign the correct monochrome plot style If ThisDrawing.GetVariable("pstylemode") = 0 Then oPltConfig.StyleSheet = "monochrome.stb" Else oPltConfig.StyleSheet = "monochrome.ctb" End If

The following code statements list all available plot styles:

Sub ListPlotStyles() Dim oPltConfig As AcadPlotConfiguration Set oPltConfig = ThisDrawing.PlotConfigurations.Add("CheckPlot") ' Display introduction text ThisDrawing.Utility.Prompt vbLf + "Available plot styles:" ' Update plot style information oPltConfig.RefreshPlotDeviceInfo ' Get the available plot styles Dim vPStyles As Variant vPStyles = oPltConfig.GetPlotStyleTableNames ' Output the name of each plot style For Each sPSName In vPStyles ThisDrawing.Utility.Prompt vbLf + " " + sPSName Next sPSName ThisDrawing.Utility.Prompt vbLf End Sub

Here is an example of the output that is created by the sample code:

Available plot styles: acad.stb Autodesk-Color.stb Autodesk-MONO.stb monochrome.stb acad.ctb DWF Virtual Pens.ctb Fill Patterns.ctb Grayscale.ctb monochrome.ctb Screening 100%.ctb Screening 25%.ctb Screening 50%.ctb Screening 75%.ctb

Even when a plot style has been assigned to a layout, the plot style isn't used when outputting a layout unless the PlotWithPlotStyles property is set to True. Although a plot style can be assigned to a layout or page setup, it can also be used to affect the appearance of graphical objects onscreen. The ShowPlotStyles property must be set to True before the plot style assigned to a layout affects objects onscreen.

Defining the Area to Output

When plotting a layout, you typically specify the entire layout and not an area within the layout. However, when plotting from the Model tab it is common to plot a small area or the extents of all objects. The PlotType property of an AcadPlotConfiguration object specifies what should be plotted. The values of the PlotType property are the same as those in the What To Plot drop-down list in the Plot Area section of the Plot or Page Setup dialog boxes.

Table 31.4 lists the constant values of the AcPlotType enumerator that can be assigned to or returned by the PlotType property. The following code statements set the plot type to the extents of the layout:

oPltConfig.PlotType = acExtents

Table 31.4 Constant values of the AcPlotType enumerator

Constant Description

acDisplay Plot area matches what is shown onscreen.

acExtents The extents of the drawing objects on the layout define the area to plot.

acLayout Margins of the active named layout are used to define the area to plot. Applies only to named layouts.

acLimits Drawing limits of the Model tab define the area to plot. The limits of model space are set with the limits command. Applies only to the Model tab.

acView Defines the area to plot with a named view. The named view to plot is set with the ViewToPlot property. The ViewToPlot property accepts and returns an AcadView object. I discussed how to create named views and the AcadView object in Chapter 28,「Interacting with the User and Controlling the Current View.」

acWindow Two points are used to define a window that sets the area to plot. The GetWindowToPlot and SetWindowToPlot methods get and set the corners of the window to plot, respectively. Each corner of the window is represented by an array of two double values.

The PlotOrigin property of an AcadPlotConfiguration object specifies the lower-left corner of the area to plot. The value assigned to or returned by the PlotOrigin property is an array of two double values. A plot origin of 0,0 is the most common value. Adjusting the origin shifts the geometry in the output. For example, to shift the geometry 2 units to the right and 1 unit up, use an origin of 2,1. If you are plotting a view or a window, you might want to center the plot on the paper. To center a plot, set the CenterPlot property of an AcadPlotConfiguration object to True.

Changing Other Related Output Settings

Based on the area being plotted, you might want to use lineweights or generate a hidden line view of 3D objects. Table 31.5 lists additional properties you might need to specify when configuring plot settings. The following code statements disable the plotting of viewport borders and enable the plotting of lineweights for the plot configuration assigned to oPltConfig:

oPltConfig.PlotViewportBorders = False oPltConfig.PlotWithLineweights = True

Table 31.5 Additional plot settings of an AcadPlotConfiguration object

Constant Description

PlotHidden Specifies whether the hidden line view is applied to the objects being plotted.

PlotViewportBorders Specifies whether the border of the viewports on a named layout should be plotted.

PlotViewportsFirst Specifies whether viewports on a named layout should be plotted first.

PlotWithLineweights Specifies whether lineweights assigned to an object are used to affect the appearance of the objects in the drawing when plotted.

ScaleLineweights Specifies whether the lineweights on a layout are scaled.

SetCustomScale Specifies the custom plot scale to apply to the objects being plotted. Set the UseStandardScale property to False when using a custom scale.

StandardScale Specifies the standard plot scale to apply to the objects being plotted. Set the UseStandardScale property to True when using a standard scale.

UseStandardScale Specifies whether a custom or standard scale should be used when plotting the specified area.

You can learn more about the properties listed in Table 31.5 from the AutoCAD Help system.

Plotting and Previewing a Layout

Now that you have organized objects on a layout, displayed objects from model space in a floating viewport, and specified the plot settings to use when outputting a layout, you are ready to plot a layout. The AcadPlot object, which is obtained using the Plot property of the AcadDocument object, contains the methods for plotting a layout. Before you can plot, you must add the names of the layouts to be plotted to an array of string values. Once you've defined the array, you pass it to the SetLayoutsToPlot method, which lets AutoCAD know the layouts to be plotted next.

Plot Today, Print Tomorrow

Plotting is often associated with large output devices, but it can also mean to print using a system printer—a small inkjet or laser printer that uses letter, A4, and even legal- or tabloid-size paper. The GetPlotDeviceNames function returns not only the plotters configured for AutoCAD, but also the system printers available. As with plotters, you assign a system printer to a layout or plot configuration with the ConfigName property. The media sizes supported by the system printer can be retrieved using the GetCanonicalMediaNames function and specifying the media size to use with the CanonicalMediaName property.

For example, if a printer named First Floor Copy Room Printer is configured in Windows and you use it to print your Microsoft Word documents, you can assign the same name to the ConfigName property of the layout or plot configuration in an AutoCAD drawing. The values of Letter and A4 represent two of the possible paper sizes that can be assigned to the CanonicalMediaName property.

As a programmer, you'll find that configuring a layout or plot configuration can be challenging. After all, you don't have control over which devices or media sizes a user has access to. The best solution is to prompt the user to select the device and media size your program should use via a user form. I explain how to work with user forms and controls in Chapter 34,「Creating and Displaying User Forms.」After the user provides you with the device and media size to use, you can store the values in the Windows Registry and retrieve the values when needed. Using this approach, your program can be adapted for use in different environments.

The following code statements create an array of two layout names and set them to be plotted:

' Assign the names of layouts to plot Dim sLayoutNames(1) As String sLayoutNames(0) = "Layout1" sLayoutNames(1) = "Layout2" ' Set the layouts to plot ThisDrawing.Plot.SetLayoutsToPlot sLayoutNames

After the layouts to be plotted have been specified with the SetLayoutsToPlot method, they can be plotted to a hardcopy using the PlotToDevice method or to an electronic file using the PlotToFile method. When you're using the PlotToDevice or PlotToFile method, each layout specified can be plotted using its own plot settings, or the plot settings of each layout can be overridden with the settings of an AcadPlotConfiguration object. The PlotToDevice and PlotToFile methods return a Boolean value of True if all layouts are successfully plotted; otherwise, False is returned.

TIP

The BeginPlot and EndPlot events can be used to monitor the start and end of the plot process. These events are members of the AcadDocument object. I explain how to use events for the AcadDocument object in Chapter 33.

The following shows the syntax of the PlotToDevice and PlotToFile methods:

object.PlotToDevice [plotConfig] object.PlotToFile fileName [, plotConfig]

Their arguments are as follows:

object The object argument represents the variable assigned the AcadPlot object that you will be working with.

fileName The fileName argument is a string that specifies the full path of the file to be created.

plotConfig The plotConfig argument is optional and of the AcadPlotConfiguration object type. The AcadPlotConfiguration object overrides the plot settings of the layouts specified by the SetLayoutsToPlot method.

The PlotToDevice and PlotToFile methods are affected by the backgroundplot system variable. When the backgroundplot system variable is set to 2 or 3, plotting occurs in the background; the plotting can take longer, but the VBA program completes sooner.

NOTE

When you're plotting a layout with the PlotToDevice and PlotToFile methods, any errors that are generated while plotting are displayed in message boxes. The QuietErrorMode property of the AcadPlot object can be used to disable the error message displays during plotting; a plot log is generated instead. Set the QuietErrorMode property to True to log plot errors and disable the error message boxes when plotting.

The following code statements plot the layouts specified by the SetLayoutsToPlot method and each layout's plot settings:

' Plot the layouts quietly ThisDrawing.Plot.QuietErrorMode = True If ThisDrawing.Plot.PlotToDevice Then MsgBox "Layouts successfully plotted." End If

As an alternative to immediately plotting a layout, you can display a layout in the Preview window and let the user decide whether to plot the layout based on the preview. The DisplayPlotPreview method displays the current layout in the Preview window, which is the same as the one opened with the Preview button in the Plot dialog box or when the preview command is executed. The execution of the VBA macro is suspended until the Preview window is dismissed.

NOTE

An error is generated if you call the SetLayoutsToPlot method before calling the DisplayPlotPreview method.

Exporting and Importing File Formats

Although the objects on a layout can be plotted to an electronic file with a configured device, you can also export the objects of a drawing to a supported file format. An exported file can be used in a presentation, imported into an analysis software package, or even used to print a prototype in a 3D printer. The Export method of the AcadDocument object allows you to export specified objects from a drawing. Exporting objects from a drawing requires you to specify the name and location of the file, a file extension, and the objects to export.

The filename and location you pass to the Export method can't include a file extension; the file type is determined by the file extension specified. The file extensions .wmf, .sat, .eps, .dxf, and .bmp are supported. The graphical objects you want to export must be passed to the Export method using an AcadSelectionSet object. As an alternative, you can allow the user to select which objects to export by passing an AcadSelectionSet object with no objects or specify a value of Nothing to export all objects in a drawing.

A previously exported or supported file created by another application can be imported into a drawing with the Import method, which is a member of the AcadDocument object. The Import method requires you to specify the full filename and location of the file you want to import, as well as an insertion point and scale factor to control the placement and size of the imported objects.

The following code statements export all objects in a drawing to a DXF file and then import them back into the current drawing at half of their original scale:

' Export objects to a DXF file Dim sDXFFile As String, sFileExt As String sDXFFile = ThisDrawing.GetVariable("MyDocumentsPrefix") & _ "\ACP_Sample" sFileExt = "DXF" ThisDrawing.Export sDXFFile, sFileExt, Nothing ' Import a DXF file Dim dInsPt(2) As Double dInsPt(0) = 0: dInsPt(1) = 0: dInsPt(2) = 0 ThisDrawing.Import sDXFFile & "." & sFileExt, dInsPt, 0.5

Exercise: Adding a Layout to Create a Check Plot

As part of the design process, many companies create what is known as a check plot. A check plot is a hardcopy of a layout that is used by an engineer to review a design that was created in AutoCAD. During the review, comments and markups are handwritten on the hardcopy and then passed back to the drafter for corrections. Over time, the review process has been slowly moving from an analog process (hardcopy) to being digitally done on a workstation.

In this section, you will continue to work with the DrawingSetup project that you created in Chapter 26. As part of the existing project, you will create several new procedures that create and configure an output device so a check plot can be output. The key concepts that are covered in this exercise are as follows:

Creating and Working with a Layout Layouts allow you to organize objects in a drawing for output. Once a layout has been created, annotation and viewports can be added to help communicate a design.

Configuring the Plot Settings of a Layout Configuring the Plot Settings of a Layout Before a layout can be output, you must specify the device and paper size you want to use, among other settings that control the appearance of the objects on the layout.

Adding and Modifying Viewports Viewports are used to control which objects from model space you want to display as part of a layout. Each viewport can be assigned a different scale to control the size at which the objects from model space are displayed.

Plotting a Layout Plotting a layout allows you to output a design to hardcopy or an electronic file to share with others.

