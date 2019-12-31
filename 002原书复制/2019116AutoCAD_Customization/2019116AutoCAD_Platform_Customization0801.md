

# Chapter 8 Automating Repetitive Tasks

In Chapters 2 through 7, I discussed how to create custom elements and tools that could be accessed from the user interface. These elements and tools make it easy to execute command macros, which are often designed to start and pass values to the current command.

While a command macro can help you combine multiple commands into a single action, two features of the Autodesk® AutoCAD® program are specifically designed to help reduce and automate repetitive tasks: scripts and action macros. You'll learn how to work with both scripts and action macros in this chapter.

NOTE

Action macros and the Action Recorder are supported in AutoCAD on Windows only.

Creating and Running Scripts

Scripts are one of the oldest methods that you can use to automate repetitive tasks in AutoCAD. For example, scripts can open, save, and close a drawing file—an AutoLISP® program can't. You can use scripts for a number of different purposes; here are a few of the most common uses for script files:

Update the CAD standards in one or more drawings

Change the settings and nongraphical objects in the drawings that you receive from a client

Execute a series of commands with specific values in a drawing

The following list outlines the known limitations of scripts:

Unlike command macros, scripts do not support a way to pause execution and prompt a user for input directly. You can use AutoLISP expressions to request input for a command.

Dialog boxes should be avoided with scripts. Starting a command that displays a dialog box suspends the script that is executing when the dialog box opens and then resumes the script when the dialog box is dismissed. The problem with displaying a dialog box is that the responses a user provides might not produce the results that were originally intended when the script was written.

AutoCAD can execute only a single script file at a time, so a script file can't start the script command to execute another script.

What Is a Script?

A script file is an ASCII text file that can contain AutoCAD commands, values, and AutoLISP expressions. You can create a script file using a text editor, such as Notepad on Windows or TextEdit on Mac OS. After you create a script file, you must save it with the ANSI encoding and the .scr file extension.

The content of a script file mimics the commands and values that you would enter at the AutoCAD command prompt. For example, the following command sequence controls some of the settings in model space, creates a new layer, and then adds a rectangle and a single-line text object:

Command: grid Specify grid spacing(X) or [ON/OFF/Snap/Major/aDaptive/Limits/Follow/Aspect] <0.5000>: off Command: ltscale Enter new linetype scale factor <1.0000>: 48 Regenerating model. Command: -layer Current layer: "0" Enter an option [?/Make/Set/New/Rename/ON/OFF/Color/Ltype/LWeight/TRansparency/ MATerial/Plot/Freeze/Thaw/LOck/Unlock/stAte/Description/rEconcile]: new Enter name list for new layer(s): border Enter an option [?/Make/Set/New/Rename/ON/OFF/Color/Ltype/LWeight/TRansparency/ MATerial/Plot/Freeze/Thaw/LOck/Unlock/stAte/Description/rEconcile]: color New color [Truecolor/COlorbook] : 9 Enter name list of layer(s) for color 9 <0>: border Enter an option [?/Make/Set/New/Rename/ON/OFF/Color/Ltype/LWeight/TRansparency/ MATerial/Plot/Freeze/Thaw/LOck/Unlock/stAte/Description/rEconcile]: Command: rectang Specify first corner point or [Chamfer/Elevation/Fillet/Thickness/Width]: 0,0 Specify other corner point or [Area/Dimensions/Rotation]: 1056,816 Command: -text Current text style: "Standard" Text height: 0.2000 Annotative: No Justify: Left Specify start point of text or [Justify/Style]: 20,20 Specify height <0.2000>: 12 Specify rotation angle of text <0>: 0 Enter text: This is a sample startup script. Command: zoom Specify corner of window, enter a scale factor (nX or nXP), or [All/Center/Dynamic/Extents/Previous/Scale/Window/Object] <real time>: extents Regenerating model.

An example script containing the same commands and values as those entered at the command prompt might look something like Listing 8.1.

Listing 8.1: Startup Script example

; Created 10/1/2013 by Lee Ambrosius - Startup Script grid off ltscale 48 -layer new border color 9 border set border rectang 0,0 1056,816 -text 20,20 12 0 This is a sample startup script. zoom extents

NOTE

You can find the Startup Script example script in the file startup.scr that is part of the sample files for this book. The sample files can be downloaded from www.sybex.com/go/autocadcustomization.

Special Characters in a Script

You should be aware of a few special characters when it comes to writing scripts. These characters include the following:

Semicolon (;) A semicolon denotes a comment; everything to the right of the semicolon is ignored. The first line of the Startup Script example shows what a comment looks like in a script. You can use comments to identify who created a script or when a script was created, as well as the purpose of the script.

Space A space in a script has two different meanings; it can represent either the press of the Enter or Return key or an actual space in a text string. The action a space represents is the same as it would be if you pressed the spacebar at the AutoCAD command prompt.

Carriage Return/Hard Return A carriage return is added when the Enter or Return key is pressed. It is just like pressing Enter or Return when typing commands and values at the AutoCAD command prompt.

NOTE

A script needs to end with a space or hard return to process the last value of the last line.

As an alternative, the commands and values in a script can be placed on separate lines. Listing 8.2 shows what the Alternative Startup Script example might look like if each command and value were placed on separate lines.

Listing 8.2: Alternative Startup Script example

; Created 10/1/2013 by Lee Ambrosius - Alternative Startup Script grid off ltscale 48 -layer new border color 9 border set border rectang 0,0 1056,816 -text 20,20 12 0 This is a sample startup script. zoom extents

NOTE

You can find the Alternative Startup Script example in the file setup_alt.scr in the sample files for this book. The sample files can be downloaded from www.sybex.com/go/autocadcustomization.

Alternatives to Dialog Boxes

As I mentioned earlier, you should avoid the use of commands that display dialog boxes with scripts. Table 8.1 and Table 8.2 show many of the commands that start dialog boxes, as well as the commands or system variables that you should use instead when writing scripts.

Table 8.1 Command-line equivalent commands (Windows and Mac OS)

Command Command-Line Equivalent Command Command-Line Equivalent

array -array bhatch -bhatch

attach -attach block -block

attdef -attdef boundary -boundary

attedit -attedit color -color

bedit -bedit cvrebuild -cvrebuild

ddptype pdmode, pdsize diminspect -diminspect

dimstyle -dimstyle dsettings autosnap, dynmode, dynprompt, grid, isoplane, ortho, snap, snaptype

etransmit -etransmit export -export

group -group hatch -hatch

hatchedit -hatchedit image -image

imageadjust -imageadjust insert -insert

interfere -interfere layer -layer

linetype -linetype lweight -lweight

mtext -mtext objectscale -objectscale

open filedia, saveas opensheetset -opensheetset

osnap -osnap overkill -overkill

pan -pan plot -plot

plotstamp -plotstamp plotstyle -plotstyle

properties celtscale, celtype, change, chprop, clayer, -color, elev, -layer, -linetype, thickness psetupin -psetupin

refedit -refedit rename -rename

render -render saveas filedia, saveas

scalelistedit -scalelistedit style -style

text -text units -units

vports -vports wblock -wblock

xbind -xbind xref -xref

Table 8.2 Command-line equivalent commands (Windows only)

Command Command-Line Equivalent Command Command-Line Equivalent

3dconfig -3dconfig, -graphicsconfig actusermessage -actusermessage

actstop -actsop attext -attext

archive -archive dataextraction -dataextraction

copytolayer -copytolayer dgnadjust -dgnadjust

ddvpoint vpoint dgnexport -dgnexport

dgnattach -dgnattach dwfadjust -dwfadjust

dgnimport -dgnimport eattext -eattext

dwfattach -dwfattach fbximport -fbximport

fbxexport -fbxexport inputsearchoptions -inputsearchoptions

hyperlink -hyperlink laymch -laymch

laydel -laydel mledit -mledit

laymrg -laymrg partiaload -partiaload

parameters -parameters publish -publish, +publish

pointcloudattach -pointcloudattach renderpresets -renderpresets

purge -purge toolbar -toolbar

table -table visualstyles -visualstyles, vscurrent, vssave

view -view

wssave -wssave

Creating a Script

Since a script file is a plain ASCII text file, you can create and edit it with Notepad on Windows or TextEdit on Mac OS.

NOTE

The examples in this section assume that you created a folder named MyCustomFiles in your Documents (or My Documents) folder on your local drive. If you have not created this folder, do so now. If you created the folder in a different location, make sure you adjust the steps accordingly.

The following explains how to create a script file named startup.scr on Windows:

Do one of the following: On Windows XP or Windows 7, click the Start button [All] Programs Accessories Notepad.

On Windows 8, on the Start Screen, type note and then click Notepad.

In Notepad, click File Save As.

In the Save As dialog box, browse to the MyCustomFiles folder that you created under the Documents (or My Documents) folder, or the location where you want to store the script file.

In the File Name text box, type startup.scr.

Click the Encoding drop-down list and select ANSI. Click Save.

In the editor, type a semicolon to start a comment line. Follow the semicolon with the current date and your name. If you want, feel free to add comments to explain what the script is used for. The following is an example of how your comment might look: ; Created 10/1/2013 by Lee Ambrosius - Startup Script

In the editor, type the following. Be sure to press Enter after each line, even after the last line of the script. Press the spacebar instead of typing {SPACE} near the end of the third line of the script. grid off ltscale 48 -layer new border color 9 border set border{SPACE} rectang 0,0 1056,816 -text 20,20 12 0 This is a sample startup script. zoom extents

Click File Save.

If you are running AutoCAD on Mac OS, use the following steps to create a script file named startup.scr:

In the Mac OS Finder, click Go Applications. In the Finder window, double-click TextEdit.

In TextEdit, click TextEdit Preferences. In the Preferences dialog box, on the New Document tab click Plain Text and then close the dialog box.

Click File New to create a plain ASCII text file.

Click File Save and type startup.scr in the Save As text box. From the sidebar on the left, click Documents MyCustomFiles, or the location you want to store the script file in, and then click Save.

In the editor, type a semicolon to start a comment line. Follow the semicolon with the current date and your name. If you want, feel free to add comments to explain what the script is used for. The following is an example of how your comment might look: ; Created 10/1/2013 by Lee Ambrosius - Startup Script

In the editor, type the following. Be sure to press Enter after each line, even after the last line of the script. Press the spacebar instead of typing {SPACE} near the end of the third line of the script. grid off ltscale 48 -layer new border color 9 border set border{SPACE} rectang 0,0 1056,816 -text 20,20 12 0 This is a sample startup script. zoom extents

Click File Save.

Running a Script

After you create a script file, you can run it using the script command. You can also run a script when AutoCAD first starts up using the /b and -b command-line switches. I covered command-line switches in Chapter 4,「Manipulating the Drawing Environment.」

The following explains how to run a script file named startup.scr at the AutoCAD command prompt. You can create the script file by completing the example under the「Creating a Script」section earlier in this chapter, or you can obtain the file by downloading the book's sample files from www.sybex.com/go/autocadcustomization. Once downloaded, extract the files to a folder named MyCustomFiles under the Documents (or My Documents) folder of your user profile, or a folder of your choice.

Do one of the following:

On the ribbon, click Manage tab Applications panel Run Script (Windows).

At the command prompt, type script and press Enter. (You could also use the -script command to enter the location and name of the script you want to run at the command prompt instead of using the Select Script File dialog box—on Windows and Mac OS.)

In the Select Script File dialog box, browse to and select the startup.scr file. Click Open.

While a script is executing, you can press the Esc or Backspace key to pause it. After a script is paused, you can start running the script where it left off by issuing the resume command. Once a script is finished, you can run the script again using the rscript command. An additional command that is related to working with scripts is the delay command, which is used to pause a script for a specified duration of time that is expressed in milliseconds.

TIP

On Windows only, you can run a script file across multiple drawings in a batch process using Script Pro, which can be downloaded for free from the Autodesk website:

http://usa.autodesk.com/adsk/servlet/item?siteID=123112&id=4091678&linkID=9240618

Recording Action Macros (Windows Only)

Action macros were first introduced with AutoCAD 2009 and are the next evolution of script files. Scripts and action macros share some similarities, but as I demonstrate in this section, action macros are easier to create because you create them interactively from the AutoCAD user interface instead of using Notepad.

An action macro is created using the Action Recorder on the ribbon, and then saved to a file with the.actm extension. Once an action macro is saved, you can edit the values in the recorded actions and the behavior of the action macro using the Action tree of the Action Recorder. Playing back an action macro is as simple as starting a standard AutoCAD command.



What Is an Action?

An action is the smallest user interaction or task that can be recorded from the AutoCAD user interface with the Action Recorder. An action might be the result of starting a command, entering a value at the command prompt, specifying a point in the drawing area, or even changing an object's property value with the Properties palette.

NOTE

While you can use commands that display dialog boxes when recording an action macro, I recommended not doing this. The Action Recorder can't record the changes that are made within a dialog box and can produce unexpected results during the playback of an action macro. Instead, you should use commands that display options at the command prompt; see Table 8.1 and Table 8.2 under the section「Alternatives to Dialog Boxes」earlier in this chapter for more information.

While the command prompt will serve as your main method for starting commands and specifying command options and values, you can also use a variety of other methods for starting commands and providing input. The following lists most of the other ways that you can start a command or change a value using the user interface when recording an action macro:

Application menu and Quick Access toolbar

Ribbon panels, toolbars, and pull-down and shortcut menus

Application and drawing-window status bars

Properties and Quick Properties palettes

Tool Palettes window

Input provided with the input device (coordinate values and selection sets)

There are some other types of commands that you should avoid in addition to ones that display dialog boxes. These commands are related to opening, creating, and closing drawings, as they (along with a few other commands) can't be recorded with the Action Recorder. If you attempt to enter a command that can't be used while the Action Recorder is in recording mode, the following message will be displayed in the Command Line History window:

** ACTRECORD command not allowed during recording an action macro **

Using the Action Recorder

The Action Recorder is a panel on the ribbon, as shown in Figure 8.1, which you use to record actions so they can be played back later to automate a repetitive task. You also use the Action Recorder panel to modify and manage previously recorded action macros. You can display the Action Recorder by clicking the Manage tab on the ribbon.

Figure 8.1 Action Recorder panel on the ribbon

The following explains the various components of the Action Recorder panel:

Record/Stop The Record button starts the recording of actions (actrecord command). After you are done recording actions, clicking the Stop button displays the Action Macros dialog box (actstop command). From the Action Macros dialog box, you can choose to save or discard the recorded actions. Saving the recorded actions results in the creation of an ACTM file.

Insert Message The Insert Message button allows you to add to the current action macro in the Action Tree an action that displays a message box with a custom message during playback. When clicked, the Insert User Message dialog box is displayed. You can also use the actmessage command when you are recording an action macro.

Play The Play button starts the playback of the action macro shown in the Action Macros drop-down list. An action macro can also be played back by entering its name (without the file extension) at the command prompt.

Preference The Preference button displays the Action Recorder Preferences dialog box, which allows you to control the settings that affect the Action Recorder panel when creating or playing back an action macro.

Manage Action Macros The Manage Action Macros button displays the Action Macro Manager, which allows you to copy, rename, modify, and delete the action macro files found in the locations specified on the Files tab of the Options dialog box. You can also use the actmanager command to display the Action Macro Manager.

Action Macros List The Action Macros drop-down list displays all of the action macros that are available for playback, beginning with the ones you have most recently played back. Recently played action macros are located at the top of the list. Below the separator bar, all available action macros are listed. Clicking the Manage Action Macros item at the bottom of the drop-down list displays the Action Macro Manager.

Action Tree The Action Tree displays all of the actions and values that make up a currently selected action macro or the action macro that is currently being recorded.

Insert Base Point The Insert Base Point button adds a base point-action to the current action macro in the Action Tree. A base point action establishes a new absolute coordinate point that the next relative point uses as its reference point. You can also use the actbasepoint command when you are recording an action macro.

Pause For User Input The Pause For User Input button allows you to prompt the user to specify a new value for an action during playback. This button acts like a toggle for the selected action value in the Action Tree; it switches a value from static to interactive or an interactive value back to a static value. You can also use the actuserinput command when you are recording an action macro.

Recording Actions for Playback

Recording actions in AutoCAD to create an action macro is similar to recording your favorite movie or TV show using a digital video recorder. You click the Record button (actrecord command) to start recording actions that are performed in the AutoCAD user interface. Once recording has started, the button changes from Record to Stop. After you are done recording actions, click the Stop button (actstop command) and then save or discard the recorded actions.

The following example explains how to record an action macro that creates a layer named Hardware and inserts a block from the Tool Palettes window.

Display the Tool Palettes window. (On the ribbon, click View tab Palettes panel Tool Palettes.) You want to display the Tool Palettes window before you start recording; otherwise the action that opens the window will be recorded as part of the action macro.

On the ribbon, click Manage tab Action Recorder panel Record.

At the command prompt, type -layer and press Enter. You should now see a new node in the Action Tree that shows it has recorded the start of the -layer command; see Figure 8.2.

At the Enter an option [?/Make/Set/New/Rename/ON/OFF/Color/Ltype/LWeight/TRansparency/MATerial/Plot/Freeze/Thaw/LOck/Unlock/stAte/Description/rEconcile]: prompt, type m and press Enter.

At the Enter name for new layer (becomes the current layer) <0>: prompt, type Hardware and press Enter.

At the Enter an option [?/Make/Set/New/Rename/ON/OFF/Color/Ltype/LWeight/TRansparency/MATerial/Plot/Freeze/Thaw/LOck/Unlock/stAte/Description/rEconcile]: prompt, type c and press Enter.

At the New color [Truecolor/COlorbook]: prompt, type 5 and press Enter.

At the Enter name list of layer(s) for color 5 (blue) <Hardware>: prompt, press Enter. In the Action Macro - Value Not Recorded dialog box, click Use The Value That Is Current At Playback.

At the Enter an option [?/Make/Set/New/Rename/ON/OFF/Color/Ltype/LWeight/TRansparency/MATerial/Plot/Freeze/Thaw/LOck/Unlock/stAte/Description/rEconcile]: prompt, press Enter to end the -layer command. Figure 8.3 shows all of the values recorded by the Action Recorder for the -layer command.

In the Tool Palettes window, right-click the title bar and click Manufacturing.

On the Mechanical tab, click the Hex Nut - Metric tool.

At the Specify insertion point or [Basepoint/Scale/X/Y/Z/Rotate]: prompt, click in the drawing area.

On the ribbon, click Manage tab Action Recorder panel Stop.

When the Action Macro dialog box (see Figure 8.4) is opened, in the Action Macro Command Name text box type HexNut.

In the Description text box, type Inserts the HexNut block on the Hardware layer.

Optionally, in the Restore Pre-playback View section, choose the options you want to use during the playback of your action macro.

Optionally, check (or clear) Check For Inconsistencies When Playback Begins. When this option is selected, AutoCAD checks a set of predefined conditions in the current drawing against those that were used when the action macro was created. If differences are identified that could affect the playback of the action macro, a message box is displayed.

Click OK to create a file named HexNut.actm.

Figure 8.2 The Action Tree shows recently recorded actions.

Figure 8.3 Recorded actions and values used to create a new layer named Hardware with the color blue

Figure 8.4 Saving recorded actions to an action macro

Now that you have created an action macro file, you can play it back by doing one of the following:

At the command prompt, enter the name of the action macro you want to execute. (The name of the action macro is the same as the action macro's file, but without its file extension.)

On the Action Recorder panel, select from the Action Macros list the action macro you want to play back, and click Play.

Right-click in the drawing area, and then click Action Recorder Play and the action macro you want to execute from the submenu.

The following example explains how to execute the HexNut action macro you just created:

Create a new drawing. While you can play back an action macro in the drawing you used to record the action macro, you will not be able to see if the block is inserted or the layer is created.

At the command prompt, type hexnut and press Enter. Playback of the action macro, which creates the Hardware layer and then inserts the HexNut block at the same point specified by the action macro, is started.

In the Action Macro - Playback Complete message box, click Close. If the message box is not displayed, it is because someone previously checked the Do Not Show Me This Message Again option before they clicked Close.

TIP

You can redisplay a message box that you previously clicked the Do Not Show option to dismiss. To redisplay the message box, display the Options dialog box (options command), and click the System tab. On the System tab, click Hidden Message Settings. In the Hidden Message Settings dialog box, select the message box you want to redisplay the next time it is called, and then click OK twice to save the changes.

The following explains how to change the action macro to prompt for an insertion point when the block is being inserted:

On the ribbon, click Manage tab Action Recorder panel, and then click the panel's title bar to expand it.

In the Action Tree, right-click the coordinate value below the EXECUTETOOL action node. Click Pause For User Input.

At the command prompt, type hexnut and press Enter.

At the Specify insertion point or [Basepoint/Scale/X/Y/Z/Rotate]: prompt, specify a coordinate value in the drawing window.

I will discuss other ways that you can modify an action macro in the next section.

NOTE

You can find the completed action macro from this section as part of the sample files for this book at www.sybex.com/go/autocadcustomization. Once downloaded, place the HexNut.actm file in the folder that is stored in the actrecpath system variable.

Modifying Action Macros

After an action macro has been created and saved, you can modify its properties or the actions that make it up. You can perform the following tasks to modify an action macro:

Pause an action macro for input

Edit the value of an action

Toggle a coordinate or all coordinates between relative and absolute

Insert a user message into an action macro

Insert a base point

Remove an action from an action macro

Pausing for Input

You can have an action macro request a new value for a previously recorded value by doing the following:

On the ribbon, click Manage tab Action Recorder panel, and then click the panel's title bar to expand it.

In the Action Tree, select the action value node that you want the action macro to pause at and prompt for a new value.

Do one of the following:

In the main area of the Action Recorder panel, click Pause For User Input.

In the Action Tree, right-click a node and click Pause For User Input.

Editing a Recorded Value

A recoded value can be changed by following these steps:

On the ribbon, click Manage tab Action Recorder panel, and then click the panel's title bar to expand it.

In the Action Tree, right-click a value and click Edit.

In the in-place editor, type a new value and press Enter.

Toggling between Absolute and Relative Coordinate Values

Recorded coordinate values are all relative to the first coordinate point that is specified when recording actions. You can toggle a relative coordinate value to an absolute coordinate that you specified in the drawing window while the value was being recorded. Use the following example to toggle a coordinate value from relative to absolute or absolute to relative:

On the ribbon, click Manage tab Action Recorder panel, and then click the panel's title bar to expand it.

In the Action Tree, right-click a coordinate value and click Relative To Previous. When checked, the coordinate value is relative to the previous coordinate value in the action macro.

If you want to make all coordinates absolute or relative with the exception of the first coordinate value, do the following:

On the ribbon, click Manage tab Action Recorder panel, and then click the panel's title bar to expand it.

In the Action Tree, right-click the topmost node and click All Points Are Relative. When checked, the first coordinate value is absolute and all others are relative to the previous coordinate value.

Inserting a User Message

You can display a message box during the playback of an action macro by doing the following:

On the ribbon, click Manage tab Action Recorder panel, and then click the panel's title bar to expand it.

In the Action Tree, select a node where you would like to display a user message before the action is executed. If you select the topmost node, the user message is inserted as the first action of the action macro.

Do one of the following:

In the main area of the Action Recorder panel, click Insert Message.

In the Action Tree, right-click a node and click Insert User Message.

When the Insert User Message dialog box opens, type the message you want to display in the message box and then click OK.

Inserting a Base Point

A base point in an action macro allows you to establish an absolute coordinate point that the next relative coordinate point references. The following steps explain how to insert a base point into an action macro:

On the ribbon, click Manage tab Action Recorder panel, and then click the panel's title bar to expand it.

In the Action Tree, select the node that you want to insert a base point before. If you select the topmost node, the base point is inserted as the first action of the action macro.

Do one of the following:

In the main area of the Action Recorder panel, click Insert Base Point.

In the Action Tree, right-click a node and click Insert Base Point.

At the Specify a base point: prompt, specify a coordinate value in the drawing window.

Removing an Action

Actions, base points, and user messages can be removed from an action macro, but an individual recorded value can't be removed. For example, if you recorded the Color option of the layer command, you can't remove the Color value that was entered. However, you can remove the action that contains the recording of the layer command and any responses to the layer command. You can remove an action, base point, or user message by doing the following:

On the ribbon, click Manage tab Action Recorder panel, and then click the panel's title bar to expand it.

In the Action Tree, right-click an action, base point, or user message node and click Delete.

In the Action Macro - Confirm Deletion of Action Node message box, click Delete.

Managing Action Macros

After action macros have been saved to ACTM files, you can manage the files with the Action Macro Manager (actmanager command). The following tasks can be performed from the Action Macro Manager:

Copy an action macro

Rename an action macro

Delete an action macro

Edit the properties of an action macro

Creating a Copy of an Action Macro

You can create a copy of an existing action macro by doing the following:

On the ribbon, click Manage tab Action Recorder panel Manage Action Macros.

When the Action Macro Manager opens, in the Action Macros list, select the action macro you want to copy. Click Copy.

When the Action Macro dialog box is opened, in the Action Macro Command Name text box enter a new name.

Optionally, change the other settings in the dialog box as desired.

Click OK to finish copying the action macro.

Click Close to return to the drawing window.

TIP

You can also copy an ACTM file using Windows Explorer or File Explorer. When copying a file in Windows Explorer or File Explorer, make sure the name of the new file does not contain spaces or special characters and contains fewer than 31 characters. If the name of the file is invalid, the action macro cannot be loaded into AutoCAD.

Renaming an Action Macro

You can rename an existing action macro by doing the following:

On the ribbon, click Manage tab Action Recorder panel Manage Action Macros.

When the Action Macro Manager opens, in the Action Macros list select the action macro you want to rename. Click Rename.

In the in-place editor, type the new name and press Enter.

Click Close to return to the drawing window.

Deleting an Action Macro

You can delete an existing action macro by doing the following:

On the ribbon, click Manage tab Action Recorder panel Manage Action Macros.

When the Action Macro Manager opens, in the Action Macros list select the action macro you want to remove. Click Delete.

In the Action Macro - Confirm Deletion message box, click Delete.

TIP

An ACTM file also can be deleted in Windows Explorer or File Explorer.

Changing the Properties of an Action Macro

After an action macro has been saved, you can change its properties by doing the following:

On the ribbon, click Manage tab Action Recorder panel and click the panel's title bar to expand it.

In the Action Tree, right-click the topmost node and click Properties.

When the Action Macro dialog box opens, make the changes to the action macro and click OK.

Sharing and Specifying Paths for Action Macros

Action macro files can be shared with others by simply copying ACTM files from one workstation to another, or posting them to a shared location. While copying an ACTM file is straightforward, all workstations that the action macro will be played back on must have access to the following:

Commands that were used during the recording of the action macro

Files that were used by the commands in the action macro

AutoCAD loads any ACTM files it finds in the folders listed under the Action Recorder Settings node on the Files tab of the Options dialog box (options command). The Action Recorder Settings node contains two child nodes:

Actions Recording File Location The folder listed under this node is used to store newly recorded ACTM files. Files located in the folder can also be edited and played back. You can also use the actrecpath system variable to query and set the folder used by the Action Recorder.

Additional Actions Reading File Location The folders listed under this node are searched for additional ACTM files that can be played back only. This node is where you might specify a network location that contains all of the ACTM files that are shared with everyone in your company or department. You can also use the actpath system variable to query and set the folders used by the Action Recorder.
