Here are their arguments:

key The key argument is a string that specifies the value assigned to the key attribute of the tile to query.

attr The attr argument is a string value that specifies the name of the attribute to query.

The following code shows how to get the current value of the tile with the key of opt_circle using the get_tile function, and get the items assigned to the list attribute of a popup_list tile with the key of list_layers. These tiles are part of the ex_createLabelObject dialog definition you created in the「Creating and Previewing a Dialog in a DCL File」section.

; Gets the current value of the tile (get_tile "opt_circle") "1" ; Gets the current value of the list attribute (get_attr "list_layers" "list") "A-Door\nA-Window"

Terminating or Closing a Dialog Box

A dialog box must be terminated—or closed—when it is no longer needed and the end user wants to return to the drawing area. The done_dialog function is used to indicate that the dialog box can be terminated. You commonly add this function as the last part of the AutoLISP expression assigned to the action attribute of a button tile such as OK or Cancel that terminates a dialog box. Before done_dialog is executed, you want to make sure you get the value of any tiles or tile attribute values by using the get_tile or get_attr function.

NOTE

The OK and Cancel buttons defined in the predefined subassemblies automatically execute (done_dialog 1) and (done_dialog 0), respectively, when the button is clicked. done_dialog needs to be executed only for tiles that close a dialog box.

The done_dialog function returns a 2D point list that represents the current placement of the dialog box onscreen. You can store this value as part of the Windows Registry, and then, to restore the location the next time the dialog box is displayed, pass the 2D point list to the new_dialog function.

The following shows the syntax of the done_dialog function:

(done_dialog [status])

The status argument is an integer value that will be returned by the start_dialog function. Typically, 0 indicates that the user clicked Cancel or the dialog box was canceled, whereas 1 indicates that the user clicked OK or an equivalent tile. A value greater than 2 can be passed to the status argument.

The following code shows how to assign a custom action to the OK and Cancel buttons of a dialog box. The alert function is called before done_dialog to simply demonstrate that more than one AutoLISP function can be called from a tile's action.

; Assign an action to the OK button (action_tile "accept" "(alert \"OK clicked.\")(done_dialog 1)") ; Assign an action to the Cancel button (action_tile "cancel" "(alert \"Cancel clicked.\")(done_dialog 0)")

If you have more than one dialog box displayed, in the case of working with nested dialog boxes, the term_dialog function can be executed to close all open dialog boxes and return to the drawing area. The term_dialog function doesn't accept any argument values and always returns nil.

Hiding a Dialog Box Temporarily

When getting input from the user with a dialog box, it isn't uncommon to allow the user to specify a point or select objects in the drawing area. Before a user can interact with the drawing area, the dialog box must be temporarily hidden. The concept of hiding a dialog box involves creating a dialog box with new_dialog and then starting user interaction with start_dialog in a looping expression that uses the while function. The done_dialog function is then used to terminate the dialog box. The status value passed to the done_dialog function is returned by the start_dialog function and used to exit or continue looping with the while function. The button that should hide the dialog box should use a status value greater than 2 to distinguish the status values returned by the OK or Cancel buttons.

The following DCL syntax defines a sample dialog box named ch23_ex_hidden that will be used to demonstrate hiding and showing a dialog box:

ch23_ex_hidden : dialog { label = "Hide/Show Example"; key = "dlg_hide"; : text { key = "msg"; label = "Point: "; } : row { fixed_width = true; alignment = right; : button { key = "btn_PickPoint"; action = "pickPoint"; label = "Pick Point"; is_default = "true"; width = 12; } : spacer { width = 1; } cancel_button; } }

The following AutoLISP code defines a custom function named hiddendlg that loads the ex_hidden.dcl file and displays the ch23_ex_hidden dialog box:

; Display the ch23_ex_hidden.dcl file (defun c:hiddendlg (/ dialog_name id status pt) (setq dialog_name "ch23_ex_hidden") ; Load the DCL file named ex_hidden.dcl (setq id (load_dialog (strcat dialog_name ".dcl"))) (setq status 2) (while (>= status 2) ; Create the dialog box (new_dialog dialog_name id "" '(-1 -1)) ; Added the actions to the Cancel and Pick Point button (action_tile "cancel" "(done_dialog 0)") (action_tile "btn_PickPoint" "(done_dialog 2)") ; Display the point value picked (if (/= pt nil) (set_tile "msg" (strcat "Point: " (rtos (car pt)) ", " (rtos (cadr pt)) ", " (rtos (caddr pt)))) ) ; Check the status returned (if (= status (setq status (start_dialog))) (setq pt (getpoint "\nSpecify a point: ")) ) ) ; Unload the dialog box (unload_dialog id) (princ) )

NOTE

The sample DCL syntax and AutoLISP code can be found in the ch23_ex_hidden.dcl and ch23_ex_hidden.lsp files, which you can download from www.sybex.com/go/autocadcustomization. Place the files in the MyCustomFiles folder within the Documents (or My Documents) folder, or the location you are using to store the LSP files. Load the LSP file and then enter hiddendlg at the Command prompt. Click the Pick Point button and specify a point in the drawing area to see the dialog box in action.

Exercise: Implementing a Dialog Box for the drawplate Function

In this section, you will create a DCL file that defines a dialog box for use with a version of the drawplate function that was originally introduced in Chapter 12,「Understanding AutoLISP.」The dialog box replaces the width and height prompts and adds an option that controls the creation of the label. The key concepts I cover in this exercise are as follows:

Creating a DCL File A DCL file is used to hold a dialog box definition that can be displayed with the AutoLISP programming language.

Displaying a Dialog Box A dialog box contained in a DCL file can be loaded and displayed in the AutoCAD drawing environment. Once the dialog box has been displayed, the user can interact with the tiles (or controls) on the dialog box. The choices a user makes can then be used to control the behavior and output of a custom program.

NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Deploying the drawplate Function」section of Chapter 20,「Authoring, Managing, and Loading AutoLISP Programs.」If you didn't complete the steps, do so now or start with the ch23_drawplate.lsp and ch23_utility.lsp sample files available for download from www.sybex.com/go/autocadcustomization. Place these sample files in the MyCustomFiles folder under the Documents (or My Documents) folder, or the location you are using to store the LSP files. Once the sample files are stored on your system, remove the characters ch23_ from the name of each file.

Creating the drawplate Dialog Box

Chapter 20 was the last chapter in which any changes were made to the drawplate function. At that time, the changes included loading the utility.lsp file and implementing custom help. Here you will create a DCL file named drawplate.dcl and then display it in the new version of the drawplate function.

The following steps explain how to create the DCL file for the drawplate function:

In AutoCAD, click the Manage tab Applications panel Visual LISP Editor.

In the Visual LISP Editor, click File New File.

Click File Save As.

In the Save-as dialog box, browse to the MyCustomFiles folder within the Documents (or My Documents) folder, or the location you are using to store DCL files.

In the File Name text box, type drawplate.

Click the Save As Type drop-down list and choose DCL Source Files.

Click Save.

In the text editor window, type the following:/* Draw Plate dialog box Used by drawplate.lsp */ drawplate : dialog { label = "Draw Plate"; key = "dlg_drawplate"; // Width text box : edit_box { edit_width = 10; key = "txt_width"; label = "Width"; } // Height text box : edit_box { edit_width = 10; key = "txt_height"; label = "Height"; } // Check box for controlling addition of label : toggle { key = "chk_label"; label = " Add label"; } // Grouping for button tiles : row { fixed_width = true; alignment = right; // Create button : button { key = "btn_create_object"; action = "create_object"; label = "Create"; is_default = "true"; width = 12; } : spacer { width = 1; } // Cancel button cancel_button; } }

Click File Save.

Click Tools Interface Tools Preview DCL In Editor.

In the Enter The Dialog Name dialog box, choose drawplate and click OK.

Review the dialog box (see Figure 23.5), and click any control to return to the Visual LISP Editor.

Figure 23.5 New dialog box for the drawplate function

Renaming the Existing drawplate Function

AutoCAD has a few command-naming conventions, and one of those conventions includes prefixing command names with a hyphen. When an AutoCAD command displays a dialog box, often a second command has been created that carries the same name but is prefixed with a hyphen. Commands that are prefixed with a hyphen allow you to access most of the functionality of a dialog box from the Command prompt through a series of prompt options. Before implementing a new version of the drawplate function that displays a dialog box, you must rename the existing drawplate function to conform to the established AutoCAD command-naming standards.

The following steps explain how to rename the drawplate function to -drawplate:

In the Visual LISP Editor, click File Open File.

In the Open File To Edit/View dialog box, click the Files Of Type drop-down list, and choose Lisp Source Files.

Browse to and select the drawplate.lsp file and click Open.

In the text editor area, revise the boldface text:; Draws a rectangular plate that is 5x2.75 (defun c:-drawplate ( / pt1 pt2 pt3 pt4 width height insPt textValue cenPt1 cenPt2 cenPt3 cenPt4 old_vars hole_list)

Revise the boldface text:; Register the help file for F1/contextual help support (if (findfile "DrawPlate.htm") (setfunhelp "c:-drawplate" (findfile "DrawPlate.htm")) )

Click File Save.

Defining a New drawplate Function

Now that you have renamed the existing drawplate function to -drawplate and defined the drawplate.dcl file, it is time to implement a new version of the drawplate function.

The following steps explain how to add the new version of the drawplate function that will display the Draw Plate dialog box:

Open the Visual LISP Editor and the drawplate.lsp file if they are not currently open.

In the text editor area, scroll to the bottom of the file and add the following code:; Draws a rectangular plate and gets input from a dialog box (defun c:drawplate ( / dialog_name id status pt1 pt2 pt3 pt4 width height label insPt textValue cenPt1 cenPt2 cenPt3 cenPt4 old_vars hole_list) ; Define the width, height, and label for the plate (if (= *drawplate_width* nil)(setq *drawplate_width* 5.0)) (if (= *drawplate_height* nil)(setq *drawplate_height* 2.75)) (if (= *drawplate_label* nil)(setq *drawplate_label* "1")) ; Get recently used values from the global variables (setq width *drawplate_width*) (setq height *drawplate_height*) (setq label *drawplate_label*) (setq dialog_name "drawplate") ; Load the DCL file named ex_hidden.dcl (setq id (load_dialog (strcat dialog_name ".dcl"))) ; Create the dialog box (new_dialog dialog_name id "" '(-1 -1)) ; Set the default values of the width and height (set_tile "txt_width" (rtos width)) (set_tile "txt_height" (rtos height)) ; Set the default for the label (set_tile "chk_label" label) ; Add the actions to the Cancel and Create button (action_tile "cancel" "(done_dialog 0)") (action_tile "btn_create_object" "(setq width (atof (get_tile \"txt_width\"))) (setq height (atof (get_tile \"txt_height\"))) (setq label (get_tile \"chk_label\")) (done_dialog 1)" ) (setq status (start_dialog)) ; Unload the dialog box (unload_dialog id) ; Check the status returned (if (= status 1) (progn (setq old_err *error* *error* err_drawplate) ; Command function being used in custom error handler (*push-error-using-command*) ; Store and change the value of the system variables (setq old_vars (get-sysvars '("osmode" "clayer" "cmdecho"))) (set-sysvars '("osmode" "clayer" "cmdecho") '(0 "0" 0)) (command "._undo" "_be") ; Create the layer named Plate or set it current (createlayer "Plate" 5) (setvar "clayer" "Plate") (setq basePt (getpoint "\nSpecify base point for plate: ")) ; Set the coordinates to draw the rectangle (setq pt1 basePt ;| lower-left corner |; pt2 (list (+ (car basePt) width) (cadr basePt) 0) ;| lower-right corner |; pt3 (list (+ (car basePt) width) (+ (cadr basePt) height) 0) ;| upper-right corner |; pt4 (list (car basePt) (+ (cadr basePt) height) 0) ;| upper-left corner |; ) ; Draw the rectangle (createrectangle pt1 pt2 pt3 pt4) ; Create the layer named Holes or set it current (createlayer "Holes" 1) (setvar "clayer" "Holes") ; Calculate the placement of the circle in the lower-left corner ; Calculate a new point at 45 degrees and distance of 0.7071 from pt1 (setq cenPt1 (polar pt1 (/ PI 4) 0.7071)) ; Calculate the next point from cenPt along the same angle ; as the line drawn between pt1 and pt2, and 1 unit less ; than the distance between pt1 and pt2 (setq cenPt2 (polar cenPt1 (angle pt1 pt2) (- (distance pt1 pt2) 1))) ; Calculate the final two points based on cenPt1 and cenPt2 (setq cenPt3 (polar cenPt2 (angle pt2 pt3) (- height 1)) cenPt4 (polar cenPt1 (angle pt1 pt4) (- height 1))) ; Append all the calculated center points to a single list (setq hole_list (append (list cenPt1) (list cenPt2) (list cenPt3) (list cenPt4))) ; Execute the createcircle function for each point ; list in the in the hole_list variable (foreach cenPt hole_list (createcircle cenPt 0.1875) ) (if (= "1" label) (progn ; Set the insertion point for the text label (setq insPt (getpoint "\nSpecify label insertion point: ")) ; Define the label to add (setq textValue (strcat "Plate Size: " (vl-string-right-trim ".0" (rtos width 2 2)) "x" (vl-string-right-trim ".0" (rtos height 2 2)) ) ) ; Create label (createlayer "Label" 7) (setvar "clayer" "Label") (createtext insPt "_c" 0.5 0.0 textValue) ) ) ; Restore the value of the system variables (set-sysvars '("osmode" "clayer" "cmdecho") old_vars) ; Save previous values to global variables (setq *drawplate_width* width) (setq *drawplate_height* height) (setq *drawplate_label* label) (command "._undo" "_e") ; Restore previous error handler (setq *error* old_err) ; End using *push-error-using-command* (*pop-error-mode*) ) ) ; Exit "quietly" (princ) )

Click File Save.

Testing the drawplate.lsp Changes

The following steps explain how to test the -drawplate function in the drawplate.lsp file:

Create a new drawing.

Start the appload command. Load the LSP files drawplate.lsp and utility.lsp. If the File Loading - Security Concern message box is displayed, click Load.

At the Command prompt, type -drawplate and press Enter.

At the Specify base point for the plate or [Width/Height]: prompt, type w and press Enter.

At the Specify the width of the plate <5.0000>: prompt, type 3 and press Enter.

At the Specify base point for the plate or [Width/Height]: prompt, type h and press Enter.

At the Specify the height of the plate <2.7500>: prompt, type 4 and press Enter.

At the Specify base point for the plate or [Width/Height]: prompt, pick a point in the drawing area to draw the plate and holes based on the width and height values specified.

At the Specify label insertion point: prompt, pick a point in the drawing area below the plate to place the text label. AutoCAD draws the completed plate, as expected.

The following steps explain how to test the revised version of the drawplate function:

At the Command prompt, type drawplate and press Enter. The Draw Plate dialog box is displayed and uses the width and height values specified by the -drawplate function.

In the Draw Plate dialog box, in the Width text box, enter 5.

In the Height text box, enter 5.

Clear the Add Label check box.

Click Create.

At the Specify base point for the plate or [Width/Height]: prompt, pick a point in the drawing area to draw the plate and holes based on the width and height values specified. AutoCAD draws the completed plate without the label, as expected.

At the Command prompt, type drawplate and press Enter.

In the Draw Plate dialog box, select Add Label.

Click Create, and specify the insertion point for the plate and label. AutoCAD draws the completed plate with a label this time.

Part III

AutoCAD VBA: Programming with VBA and ActiveX (Windows only)

Chapter 24: Understanding the AutoCAD VBA Environment

Chapter 25: Understanding Visual Basic for Applications

Chapter 26: Interacting with the Application and Documents Objects

Chapter 27: Creating and Modifying Drawing Objects

Chapter 28: Interacting with the User and Controlling the Current View

Chapter 29: Annotating Objects

Chapter 30: Working with Blocks and External References

Chapter 31: Outputting Drawings

Chapter 32: Storing and Retrieving Custom Data

Chapter 33: Modifying the Application and Working with Events

Chapter 34: Creating and Displaying User Forms

Chapter 35: Communicating with Other Applications

Chapter 36: Handling Errors and Deploying VBA Projects

Chapter 24

Understanding the AutoCAD VBA Environment

More than 15 years ago, Visual Basic (VB) was the first modern programming language I learned. This knowledge was critical to taking my custom programs to a whole new level. VB allows you to develop stand-alone applications that can communicate with other programs using Microsoft's Object Linking and Embedding (OLE) and ActiveX technologies. Autodesk® AutoCAD® supports a variant of VB known as Visual Basic for Applications (VBA) that requires a host application to execute the programs you write; it can't be used to develop stand-alone executable files.

I found VB easier to learn than AutoLISP® for a couple of reasons. First, there are, in general, many more books and online resources dedicated to VB. Second, VB syntax feels more natural. By natural, I mean that VB syntax reads as if you are explaining a process to someone in your own words, and it doesn't contain lots of special characters and formatting like many other programming languages.

As with learning anything new, there will be a bit of hesitation on your part as you approach your first projects. This chapter eases you into the AutoCAD VBA environment and the VB programming language.

What Makes Up an AutoCAD VBA Project?

Custom programs developed with VBA implemented in the AutoCAD program are stored in a project that has a .dvb file extension. VBA projects contain various objects that define a custom program. These objects include the following:

Code modules that store the custom procedures and functions that define the primary functionality of a custom program

UserForms that define the dialog boxes to be displayed by a custom program

Class modules that store the definition of a custom object for use in a custom program

Program library references that contain the dependencies a custom program relies on to define some or all of the functionality

The AutoCAD VBA Editor is an integrated development environment (IDE) that allows for the creation and execution of macros stored in a project file. A macro is a named block of code that can be executed from the AutoCAD user interface or privately used within a project. You can also enter and execute a single VBA statement at the AutoCAD Command prompt using the vbastmt command.

The most recent generation of VB is known as VB.NET. Although VB and VB.NET have similar syntax, they are not the same. VBA, whether in AutoCAD or other programs such as Microsoft Word, is based on VB6 and not VB.NET. If you are looking for general information on VBA, search the Internet using the keywords VBA and VB6.

If You Have Conversations Like This, You Can Code Like This

The summer intern had one job—add a layer and a confidentiality note to a series of 260 production drawings. September arrived, the intern left for school, and now your manager is in your cubicle.

「Half of these drawings are missing that confidentiality note Purchasing asked for. I need you to add that new layer, name it Disclaimer, and then add the confidentiality note as multiline text to model space. The note should be located on the new Disclaimer layer at 0.25,0.1.75,0 with a height of 0.5, and the text should read Confidential: This drawing is for use by internal employees and approved vendors only. Be sure to check to see if paper space is active. If it is, then set model space active per the new standards before you save each drawing,」he says.

「I can do that,」you respond.

「Can you manage it by close of day tomorrow? The parts are supposed to go out for quote on Wednesday morning.」

「Sure,」you tell him, knowing that a few lines of VBA code will allow you to make the changes quickly.

So, you sit down and start to code. The conversation-to-code translation flows smoothly. (Notice how many of the words in the conversation flow right into the actual VBA syntax.)

With ThisDrawing .Layers.Add「Disclaimer」Dim objMText As AcadMText Dim insPt(2) As Double insPt(0) = 0.25: insPt(1) = 1.75: insPt(2) = 0 Set objMText =.ModelSpace.AddMText(insPt, 15, _「Confidential: This drawing is for use by internal「 & _「employees and approved vendors only」) objMText.Layer =「Disclaimer」objMText.Height = 0.5 If.ActiveSpace = acPaperSpace Then .ActiveSpace = acModelSpace End If .Save End With

What You'll Need to Start

To complete the exercises in this chapter and create and edit VBA project files, you must have the following:

AutoCAD 2006 or later

Autodesk AutoCAD VBA Enabler for AutoCAD 2010 or later

Beginning with AutoCAD 2010, the AutoCAD VBA Enabler is an additional component that must be downloaded and installed to enable VBA support in the AutoCAD drawing environment. (For AutoCAD 2000 through AutoCAD 2009, VBA capabilities were part of a standard install.)

NOTE

The Autodesk website (http://www.autodesk.com/vba-download) allows you to download the Autodesk AutoCAD VBA Enabler for AutoCAD 2014 and 2015 (Microsoft Visual Basic for Applications Module). If you need the VBA Enabler for AutoCAD 2010 through 2013, you will want to check with your local Autodesk Value Added Reseller.

Without the VBA Enabler, you won't have access to the VBA Editor and can't create or execute VBA code contained in a DVB file with AutoCAD 2010 and later releases. All of the VBA commands were available without an additional download and install. Changes in the later AutoCAD releases were made due to Microsoft's planned deprecation of the VBA technology and editor, only to eventually extend its life cycle because of its continued importance to Microsoft Office. Microsoft planned to move to Visual Studio Tools for Applications (VSTA) as the replacement for VBA, but the company backed off because there was no easy migration from VBA to VSTA.

NOTE

Although I mention AutoCAD 2006 or later, everything covered in this chapter should work without any problems going all the way back to AutoCAD 2000. The first release of the AutoCAD program that supported VBA was AutoCAD R14, and much has remained the same since then as well, with the exception of being able to work with multiple documents in AutoCAD 2000 and later.

Determine If the AutoCAD VBA Environment Is Installed

Prior to working with the AutoCAD VBA Editor, you must ensure that the VBA environment is installed on your workstation. The following steps explain how to determine whether VBA is installed and, if necessary, how to download the AutoCAD VBA environment for installation. These steps are important if you are using AutoCAD 2010 or later.

Launch AutoCAD if it isn't already running.

At the Command prompt, type vbaide and press Enter.

If the VBA - Not Installed message box is displayed, the AutoCAD VBA environment hasn't been installed. Continue to the next step.

Click the http://www.autodesk.com/vba-download link to open your system's default web browser to the download website.

Click the link for the AutoCAD VBA Enabler that matches the version of AutoCAD installed on your workstation.

Save the AutoCAD VBA Enabler to a folder on your local workstation.

Install the AutoCAD 2015 VBA Enabler

After downloading the AutoCAD 2015 VBA Enabler using the steps explained in the previous section, follow these steps to install it:

Close the AutoCAD program and double-click the downloaded self-extracting executable for the AutoCAD VBA module.

In the Extract To message, accept the default destination location and click OK.

When the AutoCAD VBA Enabler installer opens, click Install.

On the next page of the installer, accept the default destination location and click Install.

On the Installation Complete page, click Finish.

Launch AutoCAD.

At the Command prompt, type vbaide and press Enter. The VBA Editor is displayed, indicating that the AutoCAD VBA environment has been installed.

NOTE

If you downloaded the VBA Enabler for a different release of the AutoCAD program, follow the on-screen instructions for that release of the VBA Enabler.

Getting Started with the VBA Editor

The VBA Editor (see Figure 24.1) is the authoring environment used to create custom programs that are stored in a VBA project. The following tasks can be performed from the VBA Editor:

Access and identify the components in a VBA project

View and edit the code and components stored in a loaded VBA project

Debug the code of a procedure during execution

Reference programming libraries

Display contextual help based on the code or component being edited

Figure 24.1 The VBA Editor allows for the development of a VBA program

Any of the following methods can be used to display the VBA Editor:

On the ribbon, click the Manage tab Applications panel Visual Basic Editor.

At the Command prompt, type vbaide and press Enter.

When the VBA Manager is open, click Visual Basic Editor.

When loading a VBA project, in the Open VBA Project dialog box, check the Open Visual Basic Editor check box before clicking Open.

Identifying the Components of a VBA Project

VBA supports four types of components to define the functionality of a custom program. Each component can be used to store code, but the code in each component serves a distinct purpose within a VBA project. Before you begin learning the basic features of the VBA Editor, you should have a basic understanding of the component types in a VBA project.

The following provides an overview of the component types:

Code Module

Code modules, also referred to as standard code modules, are used to store procedures and define any global variables for use in the module or globally across the VBA project. I recommend using code modules to store procedures that can be executed from the AutoCAD user interface or used across multiple projects.

When you add a new code module to a VBA project, you should give the module a meaningful name and not keep the default name of Module1, Module2, and so on. Standard industry naming practice is to add the prefix of bas to the name of the module. For example, you might name a module that contains utility procedures as basUtilities. I explain how to define procedures and variables in the「Learning the Fundamentals of the VBA Language」section in Chapter 25,「Understanding Visual Basic for Applications.」

Class Module

Class modules are used to define a custom class—or object. Custom classes aren't as common as code modules in a VBA project, but they can be helpful in organizing and simplifying code. The variables and procedures defined in a class module are hidden from all other components in a VBA project, unless an instance of the class is created as part of a procedure in another component.

When you add a new class module to a VBA project, you should give the module a meaningful name and not keep the default name of Class1, Class2, and so on. Standard industry naming practice is to add the prefix of cls to the name of the module. For example, you might name a module that contains a custom class named employee as clsEmployee. I explain how to define procedures and variables and work with objects in the「Learning the Fundamentals of the VBA Language」section in Chapter 25.

ThisDrawing ThisDrawing is a specially named object that represents the current drawing and is contained in each VBA project. The ThisDrawing component can be used to define events that execute code based on an action performed by the user or the AutoCAD program. Variables and procedures can be defined in the ThisDrawing component, but I recommend storing only the variables and procedures related to the current drawing in the ThisDrawing component. All other code should be stored in a code module. I explain how to work with the current drawing and events in Chapter 26,「Interacting with the Application and Documents Objects,」and Chapter 33,「Modifying the Application and Working with Events.」

UserForm UserForms are used to define custom dialog boxes for use in a VBA program. A UserForm can contain controls that present messages to the user and allow the user to provide input. When you add a new UserForm to a VBA project, you should give the UserForm a meaningful name and not keep the default name of UserForm1, UserForm2, and so on. Standard industry naming practice is to add the prefix of frm to the name of the UserForm. For example, you might name a UserForm that contains a dialog box that draws a bolt as frmDrawBolt. I explain how to create and display a UserForm in Chapter 34,「Creating and Displaying User Forms.」

The following explains how to add a new component to a VBA project and change its name:

In the VBA Editor with a project loaded, on the menu bar, click Insert.

Click UserForm, Module, or Class Module to add a component of that type to the VBA project.

In the Project Explorer, select the new component.

In the Properties window, in the (Name) field, type a new name and press Enter.

Using Components in Multiple VBA Projects

A component added to a VBA project can be exported, and then imported into another VBA project. Exporting a component creates a copy of that component; any changes to the component in the original VBA project don't affect the exported copy of the component. Importing the component into a VBA project creates a copy of the component in that VBA project.

The following steps can be used to export a VBA component to a file:

In the VBA Editor, Project Explorer, select the component to export.

On the menu bar, click File Export File.

In the Export File dialog box, browse to the location to store the exported file and enter a filename. Click Save.

The following steps can be used to import an exported file into a VBA project:

In the VBA Editor, Project Explorer, select a loaded project to set it current.

On the menu bar, click File Import File.

In the Import File dialog box, browse to and select the exported file. Click Open.

Navigating the VBA Editor Interface

The VBA Editor interface contains a variety of tools and windows that are used to manage and edit the components and code stored in a VBA project. While all of the tools and windows in the VBA Editor will be important over time, there are four windows that you should have a basic understanding of when first getting started:

Project Explorer

Properties window

Code editor window

Object Browser

Accessing Components in a VBA Project with the Project Explorer

The Project Explorer window (see Figure 24.2) lists all of the VBA projects that are currently loaded into the AutoCAD drawing environment and the components of each loaded project. By default, the Project Explorer should be displayed in the VBA Editor, but if it isn't you can display it by clicking View Project Explorer or pressing Ctrl+R.

Figure 24.2 The Project Explorer lists loaded projects and components

When the Project Explorer is displayed, you can

Select a project to set it as the current project; the name of the current project is shown in bold. Some tools in the VBA Editor work on only the current project.

Expand a project to access its components.

Toggle the display style for components; alphabetically listed or grouped by type in folders.

Double-click a component to edit its code or UserForm in an editor window.

Right-click to export, import, or remove a component.

Using the Properties Window

The Properties window (see Figure 24.3) allows you to change the name of a component in a loaded VBA project or modify the properties of a control or UserForm. Select a component or UserForm from the Project Explorer, or a control to display its properties in the Properties window. Click in a property field, and enter or select a new value to change the current value of the property. The Properties window is displayed by default in the VBA Editor, but if it isn't you can display it by clicking View Properties Window or pressing F4.

Figure 24.3 Modify the properties of a component, UserForm, or control

Editing Code and Class Modules in Editor Windows

A code editor window (see Figure 24.4) is where you will write, edit, and debug code statements that are used to make up a custom program. You display a code editor window by doing one of the following in the Project Explorer:

Double-clicking a code or class module

Right-clicking a UserForm and then clicking View Code

Figure 24.4 Edit code statements stored in a code or class module.

The code editor window supports many common editing tools: copy and paste, find and replace, and many others. In addition to common editing tools, it supports tools that are designed specifically for working with VBA code statements, and some of these tools allow you to accomplish the following:

Autocomplete a word as you type

Find and replace text across all components in a VBA project

Comment and uncomment code statements

Add bookmarks to allow you to move between procedures and code statements

Set breakpoints for debugging

The text area is the largest area of the code editor window and where you will spend most of your time. The Object drop-down list typically is set to (General), which indicates you want to work with the General Declaration area of the code window. When working in the code editor window of a UserForm, you can select a control or the UserForm to work with from the Object drop-down list. The Object drop-down list is also used when working with events.

Once an object is selected, a list of available events or procedures for the selected object is displayed in the Procedure drop-down list. Select a procedure from the drop-down list to insert the basic structure of that procedure. Enter the code statements to execute when the procedure is executed. I explain how to work with events in Chapter 33 and UserForms in Chapter 34.

The margin indicator bar of the code editor window helps you know where a bookmark or breakpoint is inserted by displaying an oval for a bookmark or a circle for a breakpoint. I discuss more about breakpoints in Chapter 36,「Handling Errors and Deploying VBA Projects.」

Exploring Loaded Libraries with the Object Browser

The Object Browser (see Figure 24.5) allows you to view the classes and enumerated constants defined in a referenced programming library. Each AutoCAD VBA project contains a reference to the VBA and AutoCAD Object libraries. I discuss referencing other libraries in Chapter 35,「Communicating with Other Applications.」You can display the Object Browser by clicking View Object Browser or pressing F2.

Figure 24.5 Members of an object in a referenced library can be viewed in the Object Browser.

A class is used to create an instance of an object, which I discuss in the「Working with Objects」section in Chapter 25. An enumerated constant is a set of integer values with unique names that can be used in a code statement. Using a constant name makes the integer value easier to understand, and also protects your code when values change. For example, the constant name of acBlue is equal to an integer value of 5. If the meaning of 5 were changed to mean a different color than blue, the constant of acBlue would be updated with the new integer and no changes to your code would need to be made if you used the constant.

When the Object Browser is displayed, you can select a class or enumerated constant from the Classes list. The Classes list contains all the classes and enumerated constants of the referenced libraries in the VBA project. You can filter the list by selecting a referenced library from the Libraries drop-down list located at the top of the Object Browser. Select a class or enumerated constant from the Classes list to see its members, which are methods, properties, events, or constant values. Select a member to learn more about it and press F1 to display its associated help topic. I explain how to access the AutoCAD VBA documentation in the「Accessing the AutoCAD VBA Documentation」section later in this chapter.

Working with Other Windows

The four windows that I described in the previous sections are the main windows of the VBA Editor; they are used the most frequently. You will use some additional windows on occasion. These are primarily used for creating UserForms and debugging VBA statements. (I discuss creating UserForms in Chapter 34 and debugging in Chapter 36.)

Here are the windows you will use when creating UserForms and debugging:

Immediate Window The Immediate window allows you to execute code statements in real time, but those code statements are not saved. Not all code statements can be executed in the Immediate window, such as statements that define a procedure and declare variables. Text messages and values assigned to a variable can be output to the Immediate window for debugging purposes with the Print method of the Debug object. I discuss more about the Debug object and Immediate window in Chapter 36.

Watches Window The Watches window allows you to monitor the current value assigned to the variables used in the procedures of your VBA project as they are being executed. When an array or object is assigned to a variable, you can see the values assigned to each element in the array and the current property values of the object in the Watches window. In the code editor window, highlight the variable you want to watch, and right-click. Click Add Watch and then when the Add Watch dialog box opens click OK. I discuss more about the Watches window in Chapter 36.

UserForm Editor Window The UserForm editor window allows you to add controls and organize controls on a UserForm to create a custom dialog box that can be displayed from your VBA project. You add controls to a UserForm from the Toolbox window. While the UserForm editor window is current, the Format menu on the menu bar contains tools to lay out and align the controls on a UserForm. I explain how to create and work with UserForms in Chapter 34.

Toolbox Window The Toolbox window contains the controls that can be added to a UserForm when displayed in the UserForm editor window. Click a tool and then drag it into the UserForm editor window to place an instance of the control. Right-click over one of the tools on the window and click Additional Controls to display the Additional Controls dialog box. Click any of the available controls to make it available for use in a UserForm. I explain how to add controls to a UserForm in Chapter 34.

Setting the VBA Environment Options

There are several settings that affect the behavior of the AutoCAD VBA environment and not just the currently loaded VBA projects. These settings can be changed in the Option dialog box of the VBA environment (see Figure 24.6), which can be displayed using one of the following methods:

After the Macros dialog box has been opened with the vbarun command, click Options.

At the Command prompt, type vbapref and press Enter.

Figure 24.6 Changing the VBA environment settings

Here is an explanation of the settings in the Options dialog box:

Enable Auto Embedding The Enable Auto Embedding option creates a new empty VBA project each time a drawing file is opened and embeds that empty project into the drawing file. A new project is created and embedded only if the drawing opened doesn't already contain an embedded project. This option is disabled by default.

Allow Break On Errors The Allow Break On Errors option displays a message box that allows you to step into a procedure if an error is produced during execution. You can then use the debugging tools offered by the VBA Editor to locate and handle the error. I discuss debug procedures in Chapter 36. This option is enabled by default.

Enable Macro Virus Protection The Enable Macro Virus Protection option, when enabled, displays a message box during the loading of a DVB file. I recommend leaving this option enabled to ensure that a drawing file with an embedded VBA project isn't opened in the AutoCAD drawing environment. This reduces the risk of accidentally running malicious code. The option is enabled by default.

Managing VBA Programs

VBA programs developed in the AutoCAD VBA environment can be stored in a project file or embedded in a drawing file. VBA projects can also be embedded in a drawing template (DWT) or drawing standards (DWS) file. By default, VBA programs developed in the AutoCAD VBA environment are stored in a project file with a .dvb file extension and then are loaded into the AutoCAD drawing environment as needed.

DVB files can be managed externally from Windows Explorer or File Explorer, or from within AutoCAD whenever the file is loaded into the AutoCAD drawing environment. General file-management tasks on a DVB file can be performed using Windows Explorer or File Explorer. Once the DVB file is loaded into the AutoCAD drawing environment, you can manage it using the VBA Manager (see Figure 24.7). The VBA Manager allows you to do the following:

Create a new VBA project

Save a VBA project to a DVB file

Load a VBA project from a DVB file into the AutoCAD drawing environment

Unload a VBA project from the AutoCAD drawing environment

Edit the components and code stored in a VBA project

Embed or extract a VBA project from a drawing file

Figure 24.7 Managing loaded VBA programs

There are two ways to display the VBA Manager in AutoCAD:

On the ribbon, click the Manage tab Applications panel title bar and then click VBA Manager.

At the Command prompt, type vbaman and press Enter.

Creating a New VBA Project

A new VBA project can be created automatically by the AutoCAD program or manually as needed. When the VBA environment is initialized the first time during an AutoCAD session, a new VBA project is created automatically unless a VBA project has already been loaded into memory. If you want to create a new project after the VBA environment has been initialized, do one of the following:

When the VBA Manager is open, click New.

At the Command prompt, type vbanew and press Enter.

Each new VBA project is assigned two default names: a project name and a location name. The project name is an internal name used by the AutoCAD program to differentiate the procedures and components in each loaded VBA project. The default project name for a new VBA project is ACADProject; I recommend assigning a descriptive project name for each VBA project you create. A project name can contain alphanumeric characters and underscores, but can't start with a number or underscore character.

The location name of a VBA project is the same as a filename and is used to specify where the DVB file is stored. Since a new VBA project exists only in memory, it is assigned the default location name of Global1. The location name is incremented by one for each new VBA project created during an AutoCAD session; thus the second and third VBA projects have location names of Global2 and Global3, respectively. When you save VBA projects, they are stored in DVB files locally or on a network. To ensure that AutoCAD knows where the DVB files are located, you add the locations of your DVB files to the AutoCAD support file search and trusted paths. I discuss how to add a folder to the AutoCAD support file search and trusted paths in Chapter 36.

Saving a VBA Project

New VBA projects can be saved to disc using the Save As option in the VBA Manager or Save in the VBA Editor. When an existing project is loaded in memory, the Save As option can be used to create a copy of the project on disc or to overwrite an existing VBA project file. Typically, changes made to an existing project file that already has been loaded in the VBA environment are saved to the project file using the Save option in the VBA Editor. I discussed the VBA Editor earlier in the「Getting Started with the VBA Editor」section.

The following explains how to save a VBA project:

In the VBA Editor, click File Save. Alternatively, on the Standard toolbar click Save.

If the project hasn't been previously saved, the Save As dialog box is displayed. Otherwise, the changes to the VBA project are saved.

When the Save As dialog box opens, browse to the folder you wish to use to store the VBA project.

In the File Name text box, type a descriptive filename for the project and click Save.

NOTE

A DVB file can be password-protected to restrict the editing of the components and code stored in the file. I discuss how to assign a password to a VBA project in Chapter 36.

Loading and Unloading a VBA Project

Before a VBA project can be edited and before the code stored in the project can be executed, the project must be loaded into the AutoCAD VBA environment. The process for loading a project into the AutoCAD VBA environment is similar to opening a drawing file.

Manually Loading a VBA Project

A VBA project can be manually loaded using the VBA Manager or the vbaload command. The following explains how to manually load a VBA project:

On the ribbon, click the Manage tab and then click the Applications panel title bar. Click Load Project. (As an alternative, at the Command prompt, type vbaload and press Enter.)

When the Open VBA Project dialog box opens, browse to and select ch24_hexbolt.dvb.

Clear the Open Visual Basic Editor check box and click Open.

If the File Loading - Security Concern dialog box is displayed, click Load to load the file into memory. (You can click Do Not Load to cancel a load operation.)

If the AutoCAD dialog box is displayed, click Enable Macro to allow the execution of the code in the project. (You can click Disable Macros to load a file but not allow the execution of the code, or Do Not Load to cancel without loading the project into memory.)

NOTE

You can download the sample VBA project file ch24_hexbolt.dvb used in the following exercise from www.sybex.com/go/autocadcustomization.

Place the file in the MyCustomFiles folder within the Documents (or My Documents) folder or another location you are using to store custom program files.

As an alternative, DVB and other types of custom program files can be dragged and dropped onto an open drawing window in the AutoCAD drawing environment. When you drop a DVB file onto an open drawing window, AutoCAD prompts you to load the file and/or to enable the macros contained in the VBA project file.

Automatically Loading a VBA Project

The Load Project button in the VBA Manager and the vbaload command require input from the user to load a VBA project, which isn't ideal when you want to integrate your VBA projects as seamlessly as possible into the AutoCAD drawing environment. A script, custom AutoLISP program, or command macro from the AutoCAD user interface can all be used to load a VBA project without user input. The following outlines some of the methods that can be used to load a VBA project without user input:

Call the -vbaload command. The -vbaload command is the command-line version of the vbaload command. When the -vbaload command is started, the Open VBA Project: prompt is displayed. Provide the name of the DVB file as part of the macro or script file.

Call the AutoLISP vl-vbaload function. The AutoLISP vl-vbaload function can be used to load a DVB file from a custom AutoLISP program. If the DVB file that is passed to the vl-vbaload function isn't found, an error is returned that should be captured with the AutoLISP vl-catch-all-apply function.

Create a VBA project file named acad.dvb and place it in one of the AutoCAD support file search paths. AutoCAD looks for a file named acad.dvb during startup and if the file is found, that file is loaded automatically.

Use the Startup Suite (part of the Load/Unload Applications dialog box that opens with the appload command). When a DVB file is added to the Startup Suite, the file is loaded when the first drawing of a session is opened. Removing a file from the Startup Suite causes the file not to be loaded in any future drawings that are opened or in AutoCAD sessions. If you want to use the Startup Suite to load DVB files, you must add the files to the Startup Suite on each workstation and AutoCAD user profile.

Create a plug-in bundle. Plug-in bundles allow you to load DVB and other custom program files in AutoCAD 2013 or later. A plug-in bundle is a folder structure with a special name and metadata file that describes the files contained in the bundle.

I discuss each of these methods in greater detail in Chapter 36.

Manually Unloading a VBA Project

When a VBA project is no longer needed, it can be unloaded from memory to release system resources. A VBA project can be manually unloaded from memory using the VBA Manager or the vbaunload command. The following explains how to unload the ch24_hexbolt.dvb file with the VBA Manager:

On the ribbon, click the Manage tab and then click the Applications panel title bar to expand the panel. Click VBA Manager. (If the ribbon isn't displayed or the release of the AutoCAD program you are using doesn't support the ribbon, at the Command prompt type vbaman and press Enter.)

When the VBA Manager dialog box opens, in the Projects list select HexBolt and click Unload.

If prompted to save changes to the VBA project, click Yes if you made changes that you wish to save or No to discard any changes.

Automatically Unloading a VBA Project

If you want to unload a DVB file as part of a script, custom AutoLISP program, or command macro from the AutoCAD user interface, you will need to use the vbaunload command. When the vbaunload command starts, the Unload VBA Project: prompt is displayed. Provide the filename and full path of the DVB file you want to unload; the path you specify must exactly match the path for the DVB file that was loaded into the AutoCAD drawing environment. If it doesn't, the unload fails and an error message will be displayed. A failed execution of the vbaunload command doesn't cause the program calling the command to fail.

TIP

I recommend using the AutoLISP findfile function to locate the DVB file in the AutoCAD support file search paths when loading and unloading a DVB file to ensure that the correct path is provided.

Embedding or Extracting a VBA Project

A VBA project can be embedded in a drawing file to make the components and code in the project available when the drawing file is opened in the AutoCAD drawing environment. Only one VBA project can be embedded in a drawing file at a time. Embedding a VBA project in a file can be helpful to make specific tools available to anyone who opens the file, but there are potential problems using this approach. Here are the main two problems with embedding a VBA project file into a drawing:

Embedding a VBA project triggers a security warning each time a drawing file is opened, which could impact sharing drawing files. Many companies will not accept drawings with embedded VBA projects because of potential problems with viruses and malicious code.

Embedding a VBA project that is stored in a DVB file results in a copy of that project being created and stored in the drawing file. The embedded project and the original DVB file are kept separately. This can be a problem if the project is embedded in hundreds of drawing files and needs to be revised. Each drawing file would need to be opened, the project extracted, and the revised project re-embedded.

So, while you can embed a VBA project, I don't recommend doing it.

Embedding a VBA Project

The following explains how to embed a VBA project in a current drawing file:

On the ribbon, click the Manage tab Applications panel title bar and then click VBA Manager.

When the VBA Manager opens, select a VBA project to embed from the Projects list. Load the VBA project you want to embed if it isn't already loaded.

Click Embed.

Extracting a VBA Project

Extracting a VBA project reverses the embedding process. After a project is selected for extraction, you can either export the project to a DVB file or discard the project. The following explains how to extract a VBA project from a current drawing file:

On the ribbon, click the Manage tab and then click Applications panel title bar to expand the panel. Click VBA Manager.

When the VBA Manager opens, in the Drawing section click Extract. (If the Extract button is disabled, there is no VBA project embedded in the current drawing.)

In the AutoCAD message box, click Yes to remove and export the VBA project to a DVB file. Specify a filename and location for the project you wish to extract. Click No if you wish to remove the VBA project from the drawing file without saving the project.

Executing VBA Macros

VBA projects contain components that organize code and define user forms and custom classes. A component can contain one or more procedures that are used to perform a task on the objects in a drawing or request input from an end user. Most procedures are defined so they are executed from other procedures in a VBA project and not from the AutoCAD user interface. A procedure that can be executed from the AutoCAD user interface is known as a macro. I explain how to define a procedure in Chapter 25.

A macro can be executed using the Macros dialog box (see Figure 24.8). In addition to executing a macro, the Macros dialog box can also be used to do the following:

Execute and begin debugging a macro

Open the VBA Editor and scroll to a macro's definition

Create the definition of a new macro based on the name entered in the Macro Name text box

Remove a macro from a loaded project

Display the VBA Manager

Change the VBA environment options

Figure 24.8 Executing a macro stored in a VBA project

The following methods can be used to display the Macros dialog box:

On the ribbon, click the Manage tab Applications panel Run VBA Macro.

At the Command prompt, type vbarun and press Enter.

When the VBA Manager opens, click Macros.

The Macros dialog box requires input from the user to execute a macro in a loaded VBA project. If you want to execute a macro as part of a script, custom AutoLISP program, or command macro from the AutoCAD user interface you can use one of the following methods:

Command Line The -vbarun command is the command-line version of the vbarun command. When the -vbarun command is started, the Macro name: prompt is displayed.

AutoLISP The AutoLISP vl-vbarun function can be used to execute a macro in a loaded DVB file from a custom AutoLISP program. If the macro isn't found, an error message is displayed but the error doesn't cause the program to terminate.

The name of the macro to execute with the -vbarun command or vl-vbarun function must be in the following format:

DVBFilename.ProjectName!MacroName

For example, you would use the string value firstproject.dvb!ThisDrawing.CCircles to execute the CCircle macro in the ThisDrawing component of the firstproject.dvb file.

These steps explain how to execute the macro named hexbolt:

On the ribbon, click the Manage tab Applications panel Run VBA Macro (or at the Command prompt, type vbarun and press Enter).

