## 2022007. AutoCAD-Customization-Boot-Camp-Beyond-Basic

这个作者写了 2 个专栏，一个是基础版，一个是进阶版。作者创建于 2016 年。

[AutoCAD Customization Boot Camp—Basic (No Experience Required) | Autodesk University](https://www.autodesk.com/autodesk-university/class/AutoCAD-Customization-Boot-Camp-Basic-No-Experience-Required-2016#downloads)

[AutoCAD Customization Boot Camp—Beyond the Basics | Autodesk University](https://www.autodesk.com/autodesk-university/class/AutoCAD-Customization-Boot-Camp-Beyond-Basics-2016)

Lee Ambrosius:

Lee Ambrosius is a Principal Learning Experience Designer at Autodesk, Inc., for the AutoCAD and AutoCAD LT products on Windows and Mac. He works primarily on the customization, developer, and CAD administration documentation along with the user documentation. Lee has presented at Autodesk University for about 15 years on a range of topics, from general AutoCAD customization to programming with the ObjectARX technology. He has authored several AutoCAD-related books, with his most recent project being AutoCAD Platform Customization: User Interface, AutoLISP, VBA, and Beyond. When Lee isn't writing, you can find him roaming various AutoCAD community forums, posting articles on his or the AutoCAD blog, or tweeting information regarding the AutoCAD product.

Twitter: @leeambrosius Email: lee.ambrosius@autodesk.com

Blog: [HyperPics: Beyond the UI](https://hyperpics.blogs.com/)

1『发现他的博客是个宝藏。（2022-03-30）』

2017、2018 年作者又更新了一版：

[AutoCAD Customization Boot Camp—Basic (No Experience Required) | Autodesk University](https://www.autodesk.com/autodesk-university/class/AutoCAD-Customization-Boot-Camp-Basic-No-Experience-Required-2017)

[AutoCAD Customization Boot Camp—Beyond the Basics | Autodesk University](https://www.autodesk.com/autodesk-university/class/AutoCAD-Customization-Boot-Camp-Beyond-Basics-2017#downloads)

[AutoCAD Customization Boot Camp: Basic (No Experience Required) | Autodesk University](https://www.autodesk.com/autodesk-university/class/AutoCAD-Customization-Boot-Camp-Basic-No-Experience-Required-2018)

[AutoCAD Customization Boot Camp: Beyond the Basics | Autodesk University](https://www.autodesk.com/autodesk-university/class/AutoCAD-Customization-Boot-Camp-Beyond-Basics-2018)

AS197432-L

AutoCAD Customization Boot Camp: Beyond the Basics

Lee Ambrosius Autodesk, Inc.

Learning Objectives:

1 Learn how to write and run script files.

2 Learn how to record and play back action macros.

3 Learn how to create and load small AutoLISP programs.

4 Learn how to manage user settings with profiles.

Description:

AutoCAD software offers a variety of customization features that let you reduce repetitive tasks and improve workflows. In this lab, you'll write script files, create action macros, develop small and simple AutoLISP programs, and manage settings with user profiles. This lab will help broaden your understanding of the AutoCAD customization features and help you become more productive when you return to your office. This session will feature AutoCAD.

Twitter: @leeambrosius Email: lee.ambrosius@autodesk.com Blog: http://hyperpics.blogs.com

Blog: [HyperPics: Beyond the UI](https://hyperpics.blogs.com/)

1『发现他的博客是个宝藏。（2022-03-30）』

### 01. Introduction

The AutoCAD software is an extensive 2D drafting and 3D modeling program that has grown in functionality since it was first introduced almost 35 years ago back in 1982. What sets AutoCAD apart from many other CAD programs is its expansive customization and automation capabilities. The customization and programming features of AutoCAD allow individuals and companies to simplify everyday workflows, such as:

• Initial drawing setup; establish drawing units and format, create layers, insert a title block and populate attribute values

• Extraction of design data for use downstream in a bill of materials or order entry system

• Consumption of project information from a data source such as a spreadsheet or database

This lab will provide you with the opportunity to roll-up your sleeves and get some hands-on experience with customizing AutoCAD which will prepare you to apply the techniques covered in your everyday workflows. While knowing how to program isn’t a requirement to customize AutoCAD, learning how to program does provide you with a greater set of resources to automate tasks in AutoCAD.

2 Which Customization and Programming Options are Available

Not all customization and programming options are created equally, some options are easy to learn and are well integrated into the AutoCAD program that many don’t even realize they are customizing the program. For example, creating new layers and named styles are forms of customization that are preformed frequently. There are two types for customization and programming that are available; drawing and application.

The following lists many of the customization and programming options available:

Basic Drawing

Application

• Layers

• Blocks

• Annotation styles (text, dimensions, multileaders, and tables)

• Materials and visual styles

• Drawing templates

• Desktop shortcut

• Command aliases

• Tool palettes

• Workspaces

• User profiles

• Plot styles

Page 2 Intermediate Drawing

Application

• Dynamic blocks

• Scripts

• Action macros

• User interface (CUI Editor)

• DIESEL

• Custom linetypes and hatch patterns

• Custom shapes and text styles

Advanced (Application Only)

• AutoLISP / Visual LISP

• Visual Basic for Applications (VBA)

• ActiveX / COM (VBA, VBScript, VB.NET, C#, C++)

• Database connectivity

• Managed .NET (VB.NET, C#)

• ObjectARX (C++)

• JavaScript

• Sheet Set Manager API

• CAD Standards plug-ins

• Transmittal API

• Connectivity Automation API

• Forge Platform APIs

3

What You Need to Get Started

Many of the customization and programming options available for use within the AutoCAD program are supported through utilities or commands found inside the program, or applications installed with the operating system (Windows or Mac OS). It is when you want to extend the functionality of the AutoCAD program using ActiveX, Managed .NET, or ObjectARX that you will need to purchase, download, and/or install additional software.

4

Supplemental Content

See the separate AS197432-L-Ambrosius-Supplement-AU2018.pdf for the supplemental content in the dataset related to this session.

5

Exercises

This section contains all the exercises that will be covered during this lab or when you get back to the office.

E1

Create and Run a Script

This exercise explains how to create and run a script file. The script file inserts a title block and configures some basic drafting settings.

1. Start AutoCAD 2019 and create a new drawing.

2. In AutoCAD, at the Command prompt, type notepad and press Enter twice.

Notepad will open with an empty document.

Page 3 3. In Notepad, the editor area, type the proceeding text and press Enter after each line and make sure there is a blank line after the last line.

limits 0,0 408,264

-insert b-tblk 0,0 24 24 0 zoom extents orthomode 1 gridmode 0 snapmode 0 osmode 32 wscurrent Drafting & Annotation

4. On the menu bar, click File menu ➢ Save As.

5. In the Save As dialog box, browse to the dataset folder for this session.

The location and name of the dataset folder for this session should be C:\DATASETS\AS197432-L - AutoCAD Customization Boot Camp Beyond the Basics

6. In the File name text box, select the default text and type startup.scr.

7. Click the Save As Type drop-down list and choose All Files (*.*).

8. Click Save.

Page 4 Note: A completed version of the startup.scr file can be found in the Completed folder under the dataset for this session.

Before the script can be executed, AutoCAD needs to know where the b-tblk.dwg file is currently stored:

1. Switch back to AutoCAD.

2. In the drawing area, right-click and choose Options.

3. In the Options dialog box, Files tab, select the Support File Search Path node.

4. On the right side, click Add and then click Browse.

5. In the Browse for Folder dialog box, browse to and select the folder for this session.

The location and name of the dataset folder for this session should be C:\DATASETS\AS197432-L - AutoCAD Customization Boot Camp Beyond the Basics

6. Click OK twice to exit the two dialog boxes and save the changes.

Page 5 Now that AutoCAD knows where to locate the b-tblk.dwg file to be used in the script, the script can be executed. If AutoCAD can’t locate the file, the script will end with AutoCAD trying to execute the -INSERT command.

1. On the status bar, disable Orthomode and Object Snap.

2. On the ribbon, click Manage tab

➢

Applications panel

➢

Run Script.

3. In the Run Script dialog box, browse to the dataset folder for this session and select the startup.scr file that you created earlier.

The location and name of the dataset folder for this session should be C:\DATASETS\AS197432-L - AutoCAD Customization Boot Camp Beyond the Basics

4. Click Open.

After the script finishes running, you should notice these changes have been made:

• The drawing limits have been set

• The drawing grid is turned off and the drafting aids ortho and object snap modes have been enabled

• A title block has been inserted into Model Space and the drawing has been zoomed to the extents of the title block

• The Drafting & Annotation workspace has been set current, unless it already was current

Page 6 E2.A Record and Playback an Action Macro

This exercise explains how to create an action macro that creates a new layer and prompts for the points to define a rectangular revision cloud.

In these steps, you start the recording of an action macro and record the actions related to creating a new layer named A-Anno-RevCloud:

1. On the ribbon, click Manage tab ➢ Action Recorder panel ➢ Record.

2. At the Command prompt, type -layer and press Enter.

After you press Enter, you should notice that the command is added to the Action Tree.

3. At the Enter an Option prompt, type M and press Enter.

4. At the Enter name for new layer prompt, type A-Anno-RevCloud and press Enter.

5. At the Enter an Option prompt, type C and press Enter.

6. At the New Color [Truecolor/COlorbook]: prompt, type 1 and press Enter.

7. Press Enter again to assign the color 1 (red) to the A-Anno-RevCloud layer.

Page 7 8. In the Action Macro – Value Not Recorded dialog box, click at Playback.

9. Press Enter again to end the -LAYER command.

Use the Value that is Current

You are returned to a blank Command prompt, and the new layer is created and set current. The Action Tree should now look like the following image.

Page 8 In these steps, you create a rectangular revision cloud with the REVCLOUD command:

1. At the Command prompt, type revcloud and press Enter.

2. At the Specify first corner point or [Arc length/Object/Rectangular/Polygonal/Freehand/Style/Modify] <Object>: prompt, type S and press Enter.

3. At the Select arc style [Normal/Calligraphy] <Normal>: prompt, type C and press Enter.

4. At the Specify first corner point or [Arc length/Object/Rectangular/Polygonal/Freehand/Style/Modify] <Object>: prompt, type A and press Enter.

5. At the Specify minimum length of arc <0.5000>: prompt, type 2.5 and press Enter.

6. At the Specify maximum length of arc <2.5000>: prompt, type 2.5 and press Enter.

7. At the Specify first corner point or [Arc length/Object/Rectangular/Polygonal/Freehand/Style/Modify] <Object>: prompt, type R and press Enter.

8. Specify the first and opposite corner of the revision cloud anywhere in the drawing area.

The revision cloud that you create might look similar to the following image.

In these steps, you stop recording and save the actions to an action macro named REC-CLD:

1. On the ribbon, click Manage tab ➢ Action Recorder panel ➢ Stop.

2. In the Action Macro dialog box, Action Macro Command Name text box, type REC-CLD.

3. Optionally, in the Description text box, enter a description for the action macro.

4. Click OK.

Page 9 In these steps, you modify the action macro, so it prompts for the two corners of the rectangular revision cloud during playback:

1. On the Action Recorder panel, click the Action Recorder panel’s title to expand it if it isn’t already expanded.

2. Click the Pin to keep the Action Tree open if it isn’t already pinned.

3. In the Action Tree, right-click over the coordinate that represents the first corner of the rectangular revision cloud and choose Pause for User Input.

4. Repeat Step 3 for the opposite corner of the rectangular revision cloud.

The icons of the two values should now show a silhouette badge that indicates the user will be prompted for a value during playback.

Page 10 5. Click the Pin again to allow the Action Tree to close.

6. Create a new drawing.

7. On the ribbon, click Manage tab ➢ Action Recorder panel, select REC-CLD from the Action Macros drop-down list.

8. Click Play.

9. After playback of the action macro starts, specify two points in the drawing area.

10. In the Action Macro - Playback Complete message box, click Close.

Page 11 In these steps, you modify the action macro to use a different minimum and maximum arc length for the revision cloud during playback:

1. On the Action Recorder panel, click the Action Recorder panel’s title to expand it if it isn’t already expanded.

2. In the Action Tree, right-click over the first Distance (arc length) node under the REVCLOUD command and click Edit. Type 0.75 and press Enter.

3. Repeat Step 2 for the second Distance (arc length) node.

4. Playback the REC-CLD action macro again.

Notice that the arcs are smaller compared to the previous revision cloud created.

5. Close the new drawing and discard any changes made.

Page 12 E2.B Insert a Dynamic Block with an Action Macro

This exercise explains how to create an action macro that creates a new layer and inserts a dynamic block with a set of predefined property values.

In these steps, you start the recording of an action macro and record the actions related to creating a new layer named Doors:

1. In AutoCAD, open the Sample Drawing.dwg file from the dataset folder for this session.

The location and name of the dataset folder for this session should be C:\DATASETS\AS197432-L - AutoCAD Customization Boot Camp Beyond the Basics

2. On the ribbon, click View tab ➢ Palettes panel, and then

a. Click Tool Palettes to display the Tool Palettes window.

b. Click Properties to display the Properties window.

3. On the ribbon, click Manage tab

➢

Action Recorder panel

➢

Record.

Page 13 4. At the Command prompt, type -layer and press Enter.

After you press Enter, you should notice that the command is added to the Action tree.

5. At the Enter an Option prompt, type M and press Enter.

6. At the Enter name for new layer prompt, type A-Doors and press Enter.

7. At the Enter an Option prompt, type C and press Enter.

8. At the New Color [Truecolor/COlorbook]: prompt, type 5 and press Enter.

9. Press Enter again to assign the color 5 (blue) to the A-Doors layer.

10. In the Action Macro – Value Not Recorded dialog box, click Use the Value that is Current at Playback.

Page 14 11. Press Enter again to end the -LAYER command.

You are returned to a blank Command prompt, and the new layer is created and set current. The Action tree should now look like the following image.

In these steps, you record the actions related to inserting a dynamic block:

1. On the Tool Palettes window, Architectural tab, click the Door – Imperial tool.

2. On the Properties palette, under Custom, select 3’-0” (or 36.0000) from the Door Size drop-down list and select Open 90 o from the Opening Angle drop-down list.

3. In the drawing area, specify a point to insert the door block.

Page 15 In these steps, you stop recording and save the actions to an action macro named DR36-90:

1. On the ribbon, click Manage tab ➢ Action Recorder panel ➢ Stop.

2. In the Action macro dialog box, Action macro Command Name text box, type DR36-90.

3. Optionally, in the Description text box, enter a description for the action macro.

4. Click OK.

In these steps, you modify and test the action macro named DR36-90:

1. Create a new drawing.

2. On the ribbon, click Manage tab ➢ Action Recorder panel, select DR36-90 from the Action macros drop-down list.

3. Click Play.

4. If the Action Macro – Playback Complete dialog box is displayed, click Close.

5. Use the ZOOM command with the Extents option to zoom to the extents of the drawing.

Page 16 6. On the Action Recorder panel, click the Action Recorder panel’s title to expand it if it isn’t already expanded.

7. In the Action Tree, right-click over the coordinate value for the insertion point of the block and choose Pause for User Input.

During playback, you will now be able to specify a unique insertion point.

8. Playback the DR36-90 action macro again and specify a point in the drawing area.

Tip: While specifying an insertion point, you can specify a different rotation value and change other values using the Properties palette.

9. Close the new drawing and discard any changes made.

10. Close the Tool Palettes window and Properties palette.

Page 17 E3

Enter AutoLISP Expressions at the Command prompt

This exercise explains how to use some basic AutoLISP concepts and enter expressions at the AutoCAD Command prompt.

1. In AutoCAD, create a new drawing.

2. At the Command prompt, type ( and press Enter.

By entering a (, you indicate to AutoCAD that you want to work with AutoLISP. The (_> prompt that is displayed lets you know AutoLISP is standing by and waiting for a bit more information along with one or more balancing closing or right parentheses.

3. Type setvar "gridmode" 0) and press Enter to complete the AutoLISP expression.

The GRIDMODE system variable is set to 0, disabling the grid display in the drawing window.

4. Type (command "line" "0,0" "5,2" "") and press Enter.

5. Zoom to the extents of the drawing to see the new line object drawn from 0,0 to 5,2.

Page 18 6. Type !rad and press Enter.

The value of nil is returned and expected unless the user-defined variable rad was previously defined in the drawing. Press F2 to expand the Command Line window or display the AutoCAD Text Window, and see the Command Line window history.

7. Type (setq rad 3.5) and press Enter.

The user-defined variable rad is assigned the value of 3.5.

8. Type !rad and press Enter.

The value of 3.5 is returned to the Command Line window instead of nil this time.

9. Type (setq pt (list 5 2 0)) and press Enter.

The coordinate value of 5,2,0 is assigned to the user-defined variable pt.

10. Type circle and press Enter.

11. At the Specify center point for circle or [3P/2P/Ttr (tan tan radius)]: prompt, type !pt and press Enter.

12. At the Specify radius of circle or [Diameter]: prompt, type !rad and press Enter.

Page 19 13. Zoom out to see the new circle drawn at 5,2 with a radius of 3.5.

14. Type (command "circle" pt (/ rad 2)) and press Enter.

A new circle is drawn inside the previous circle with a radius that is 1/2 the value assigned to the user-defined variable rad.

E4

Create Custom AutoLISP Functions

This exercise explains how to create a basic AutoLISP function which can be executed from the AutoCAD Command prompt.

1. In AutoCAD, at the Command prompt, type C2 and press Enter.

The text Unknown command "C2". Press F1 for help. is displayed in the Command Line window history because no command is defined with the name C2.

2. Type (defun c:C2 ()(command "circle" PAUSE 1 "circle" "@" 2)) and press Enter.

AutoCAD responds with C:C2 letting you know the custom function has been defined.

3. Type (defun c:ZX () and press Enter.

AutoCAD responds with the prompt (_> letting you know you have one or more open AutoLISP expressions.

Page 20 4. Type (command "zoom" "e") and press Enter.

5. Type ) and press Enter.

AutoCAD responds with C:ZX letting you know the custom function has been defined.

6. Type C2 and press Enter.

7. At the Specify center point for circle or [3P/2P/Ttr (tan tan radius)]: prompt, specify a point in the drawing area.

Two concentric circles are drawn at the point specified.

8. Type ZX and press Enter.

The ZOOM command is executed with the Extents option resulting in the drawing being zoomed to the extents of all visible objects.

9. Create a new drawing.

10. Type C2 and press Enter.

The text Unknown command "C2". Press F1 for help. is displayed in the Command Line window history because no function with the name C2 is defined in the new drawing. Functions defined with AutoLISP are only available in the drawing which they were defined.

Page 21 E5

Create and Load a LSP File

This exercise explains how to create a LSP file and then load it into the AutoCAD program. In these steps, you create a new LSP file from an existing text file that contains several comments and AutoLISP statements:

1. In AutoCAD, at the Command prompt, type explorer and press Enter.

2. In Windows Explorer or File Explorer, in the Address Bar, type c:\d and select the Datasets folder.

3. Navigate to the dataset folder for this session.

The location and name of the dataset folder for this session should be C:\DATASETS\AS197432-L - AutoCAD Customization Boot Camp Beyond the Basics

4. In the AS197432-L folder, double-click the au2018-code_snippet.txt file. In these steps, you create a new LSP file named au2018.lsp:

1. In Notepad, on the menu bar, click File menu ➢ Save As.

2. In the File Name text box, select the existing name and type au2018.lsp.

3. In the Save As Type drop-down list, select All Files (*.*).

4. Click Save.

Page 22 In these steps, you add and define custom functions to the LSP file.

1. In Notepad, make sure the title bar reads au2018.lsp – Notepad to ensure you saved the file correct. If not, go back and resave au2018-code_snippet.txt to au2018.lsp.

2. In the text editor area, replace the text [Today’s Date] with the current date and replace [Your Name] with your name or a value of your choosing.

3. On the menu bar, click File menu ➢ Save.

4. In the text editor area, click after the last statement and press Enter twice to make sure you are on a blank line ready to type.

5. Enter the following text:

; Zoom extents shortcut (defun c:ZX ()(command "zoom" "e"))

; Draws concentric circles (defun c:C2 ()(command "circle" PAUSE 1 "circle" "@" 2))

The two functions should look familiar as they are the same ones you entered at the Command prompt earlier along with a comment before each function.

6. On the menu bar, click File menu ➢ Save.

Note: A completed version of the au2018.lsp file can be found in the Completed folder under the dataset for this session.

Page 23 In these steps, you learn how to load the au2018.lsp file into AutoCAD:

1. Switch back to AutoCAD and create a new drawing.

2. On the ribbon, click Manage tab ➢ Applications panel ➢ Load Application.

3. In the Load/Unload Applications dialog box, click the Look In drop-down list near the top and select C:.

4. Browse to the dataset folder for this session.

The location and name of the dataset folder for this session should be C:\DATASETS\AS197432-L - AutoCAD Customization Boot Camp Beyond the Basics

Page 24 5. In the AS197432-L folder, select the au2018.lsp file and click Load.

A message near the lower-left corner of the dialog box appears displaying the text “au2018.lsp successfully loaded.” which lets you know the file loaded.

6. In the Security – Unsigned Executable File message box, click Load Once.

7. In the Load/Unload Applications dialog box, click Close to exit the dialog box.

8. Press F2.

The message AU2018 AutoLISP Examples loading... should now be displayed in the Command Line window, which was added by the statement of (prompt "\nAU2018 AutoLISP Examples loading...") In these steps, you test the functions that were loaded as part of the au2018.lsp file:

1. On the ribbon, click the Home tab.

2. At the Command prompt, type DLI and press Enter.

The Dimensions layer is created and set current, which can be seen in the Layers dropdown list on the Layers panel, and then the DIMLINEAR command is started because of the DLI function defined in the au2018.lsp file.

Page 25 3. Specify three points in the drawing area.

The new linear dimension should be placed on the Dimensions layer and appear in green.

4. Try the C2 and ZX functions that you added to the au2018.lsp file.

5. Create a new drawing.

6. At the Command prompt, type C2 and press Enter.

The text Unknown command "C2". Press F1 for help. is displayed in the Command Line window history because no function with the name C2 is defined in the new drawing. You would need to load the au2018.lsp file into this new drawing for the function to be available.

7. Type DLI and press Enter and then specify three points in the drawing area to place the dimension.

Notice the standard DLI command alias defined by the AutoCAD program is executed which starts the DIMLINEAR command and places the dimension on the current layer.

Page 26 E6

Create a Basic Plug-in Bundle to Load an AutoLISP Program

This exercise explains how to define and deploy a custom plug-in bundle which can be used to load custom LSP files.

In these steps, you learn how to create a plug-in bundle named AS197432-L.bundle:

1. Switch to Windows Explorer or Windows Explorer, and the dataset folder for this session.

a. If it isn’t open from before, in AutoCAD, at the Command prompt, type explorer and press Enter.

b. In Windows Explorer or File Explorer, in the Address Bar, type c:\d and select the Datasets folder.

c. Navigate to the dataset folder for this session.

The location and name of the dataset folder for this session should be C:\DATASETS\AS197432-L - AutoCAD Customization Boot Camp Beyond the Basics 2. In the AS197432-L folder, click New Folder.

3. In the in-place editor, type AS197432-L.bundle and press Enter.

4. In Windows Explorer or File Explorer, select the au2018.lsp file you created earlier.

Page 27 5. Hold down the Ctrl key and select the following files in the AS197432-L folder:

• au2018ex.lsp

• PackageContents.xml

6. Right-click over one of the selected files and choose Copy.

7. Double-click the AS197432-L.bundle folder.

8. In the empty folder, right-click and choose Paste.

In these steps, you learn how to deploy the plug-in bundle named AS197432-L.bundle:

1. In Windows Explorer or Files Explorer, go back (or up) one folder so you are in the dataset folder for this session.

This can be done by doing one of the following:

• Click in an empty area of the files list and pressing Backspace

• Click the previous folder name in the Address bar

• Edit the folder path in the Address bar by removing the text AS197432-L.bundle and pressing Enter

2. Right-click over the AS197432-L.bundle folder and choose Copy.

3. In Windows Explorer or File Explorer, in the Address bar, type %ProgramData%\Autodesk and press Enter.

Note: It is recommended to add plug-in bundles to one of the following locations instead of the ProgramData folder:

• %ProgramFiles%\Autodesk\

• %ProgramFiles(x86)%\Autodesk\

Page 28 4. Double-click the ApplicationPlugins folder, right-click in an empty area, and choose Paste.

Note: The plug-in bundle is now deployed and ready for AutoCAD to load. While the bundle might be recognized by AutoCAD, the LSP files won’t be loaded into the current session. You will need to restart the AutoCAD program for the changes to take effect. If it doesn’t automatically load into the program, check the value of the APPAUTOLOAD system variable as it should be set to 14.

5. Close and restart AutoCAD 2019; discard the changes to all open drawings.

6. After AutoCAD 2019 restarts, create a new drawing.

7. In the Security – Unsigned Executable File dialog box, click Load Once.

This dialog box is displayed to let you know that the file hasn’t been digitally signed and isn’t placed in a trusted location.

Page 29 8. At the Command prompt, type C2 and press Enter. Specify a point in the drawing area.

9. Type DLI and press Enter. Specify three points to create the linear dimension.

10. Type ZX and press Enter to zoom to the extents of the drawing.

In these steps, you learn how to update the PackageContents.xml file for the AS197432L.bundle to load another LSP file:

1. In Windows Explorer or File Explorer, in the AS197432-L.bundle folder under %ProgramData%\Autodesk\ApplicationPlugins, right-click the PackageContents.xml file and choose Open With ➢ Notepad.

2. In Notepad, scroll down to the Components element and add the text in bold; you can copy and paste the existing ComponentEntry element just above the bold text instead of typing all the text in bold.

<ComponentEntry Description="Your custom file"

AppName="AU2018Examples" Version="1.0"

ModuleName="./au2018.lsp">

</ComponentEntry>

<ComponentEntry Description="Additional examples"

AppName="AU2018AdditionalExamples" Version="1.0"

ModuleName="./au2018ex.lsp">

</ComponentEntry>

</Components> </ApplicationPackage>

3. In Notepad, on the menu bar, click File menu ➢ Save.

4. Close and restart AutoCAD 2019; discard the changes made to the open drawing.

5. In AutoCAD, create a new drawing.

6. Click Load Once for each of the Security – Unsigned Executable File dialog boxes that are displayed.

7. At the Command prompt, type TB and press Enter.

The title block t-blk is inserted into the current space. The path of the block was setup as part of the exercise E1 Create and Run a Script.

8. Type ZX and press Enter.

9. Type ZP and press Enter.

The previous view is restored.

10. Type TAGBUBBLE and press Enter. Type C and press Enter for the circle bubble and then press Enter to accept the default text height of 3. Specify the center of the bubble and the endpoint of the leader line.

Page 30 E7

Create and Modify a New Profile

This exercise explains how profiles play a role in trusting executable files from specific locations. Profiles can also be used to control other settings that affect where AutoCAD searches for support files along with how the application behaves and looks. The following steps have you testing trusted locations, creating and setting a new profile current, and making changes to the new profile.

In these steps, you test the loading of LSP files outside of a trusted location:

1. In AutoCAD, at the Command prompt, type (load "au2018-trusted.lsp") and press Enter.

2. In the Security – Unsigned Executable File message box, click Load Once.

The message box informs you that the custom program file being loaded isn’t located in a trusted location and it hasn’t been previously digitally signed.

Note: It isn’t recommended to load custom programs from a location that hasn’t been previously trusted.

Upon the loading of the LSP file, an AutoCAD message box is displayed with the alert function.

3. In the AutoCAD message box, click OK.

4. At the Command prompt, type (load "au2018-trusted-signed.lsp") and press Enter.

5. If the Security – Signed File Not in Trusted Folder message box is displayed, click Do Not Load.

The message box informs you that the custom program file has been digitally signed but isn’t being loaded from a trusted folder. Even when digitally signed, you must be careful to know who is sending you the file as clicking Always Load will automatically trust all files signed by the same publisher.

In these steps, you create a new profile and set it current:

1. Right-click in the drawing area and click Options.

Page 31 2. In the Options dialog box, on the Profiles tab, click Add to List.

3. In the Add Profile dialog box,

• Profile Name text box, type My Profile

• Description text box, type This is my custom profile

4. Click Apply & Close.

5. From the Available Profiles list, select My Profile and click Set Current.

Tip: The /p command line switch can be used to set a profile current when AutoCAD is started from a desktop shortcut. For more information on the /p command line switch, search on the keywords “command line switch” in the AutoCAD Online Help system.

Page 32 In these steps, you modify a profile and add this session’s folder as a trusted location:

1. In the Options dialog box, on the Files tab, expand the Support File Search Path node and verify that the dataset folder for this session is listed.

The name of the dataset folder for this session should be C:\DATASETS\AS197432-L - AutoCAD Customization Boot Camp Beyond the Basics

The folder should have been inherited from the <<Unnamed Profile>> profile, you originally added the path as part of the exercise named E1 Create and Run a Script. 2. If the folder mentioned and shown in the previous step is missing, do the following otherwise go to Step 3:

a. Select the Support File Search Path node.

Page 33 b. On the right side of the dialog box, click Add and then click Browse.

c. In the Browse for Folder dialog box, browse to and select the folder for this session.

The name of the dataset folder for this session should be C:\DATASETS\AS197432-L - AutoCAD Customization Boot Camp Beyond the Basics

d. Click OK.

3. On the Files tab, select the Trusted Locations node.

Page 34 4. On the right side of the dialog box, click Add and then click Browse.

5. In the Browse for Folder dialog box, browse to and select the folder for this session.

The name of the dataset folder for this session should be C:\DATASETS\AS197432-L - AutoCAD Customization Boot Camp Beyond the Basics

6. Click OK.

7. In the Trusted File Search Path - Security Concern dialog box, click Continue.

The folders you specify as trusted locations should be read-only to avoid potential problems with programs modifying the custom files in that location.

Page 35 8. Repeat steps 4 through 7, and add the following folder to the trusted locations:

C:\ProgramData\Autodesk\ApplicationPlugins\AS197432-L.bundle

Note: It is recommended to digitally sign files in a plug-in bundle rather than trusting all files in that location since anyone can make changes to the files there.

9. On the Display tab, in the Window Elements section, click the Color Scheme drop-down list and select Light.

10. Click the Colors button.

Page 36 11. In the Drawing Window Colors dialog box, do the following:

a. In the Context list box, select 2D Model Space.

b. In the Interface Element list box, select Uniform Background.

c. Click the Color drop-down list and select White.

12. Click Apply & Close.

13. Click OK to close the Options dialog box.

In these steps, you test the changes to the profile’s trusted paths:

1. Close and restart AutoCAD 2019; discard any changes to the open drawing.

2. In AutoCAD, create a new drawing.

3. At the Command prompt, type (load "au2018-trusted.lsp") and press Enter.

4. Click OK to dismiss the message box.

Notice unlike earlier, the Security – Unsigned Executable File dialog box isn’t displayed this time when the au2018-trusted.lsp file is loaded. If the message box is displayed, verify that you added the correct dataset folder for this session to the Trusted Locations node in the Options dialog box.

5. Right-click in the drawing area and click Options.

Page 37 6. In the Options dialog box, Profiles tab, from the Available Profiles list box, select <<Unnamed Profile>> and click Set Current. Click OK.

7. Close and restart AutoCAD 2019.

8. In AutoCAD, create a new drawing.

9. Click Load Once each time the Security – Unsigned Executable File dialog box is displayed.

The Security – Unsigned Executable File dialog box is displayed once again because the trusted location for this session and plug-in bundle is no longer specified.

10. At the Command prompt, type (load "au2018-trusted.lsp") and press Enter.

The Security – Unsigned Executable File dialog box is displayed once again.

11. In the Security – Unsigned Executable File dialog box, click Load Once.

12. Click OK to dismiss the message box.

E8

Reset the AutoCAD Environment

This exercise explains how to reset AutoCAD back to its default settings and remove the custom plug-in bundle.

In these steps, you reset the AutoCAD program:

1. Close all instances of AutoCAD 2019.

2. Do one of the following:

• On the Windows 7 taskbar, click the Start button ➢ All Programs ➢ Autodesk ➢ AutoCAD 2019 - English ➢ Reset Settings to Default.

• On the Windows 8 or Windows 10 Start Screen, under the AutoCAD 2019 English category, click Reset Settings to Default.

3. In the Reset Settings - Backup dialog box, click Reset Custom Settings.

When you are back at the office, you might want to click Back Up and Reset Custom Settings to create a ZIP file containing all your custom settings and files before resetting the program.

4. When the Reset Settings - Confirmation message box is displayed, click OK.

Page 38 In these steps, you remove the custom plug-in bundle from the Program Data folder:

1. On the keyboard, press the key combination +E, or launch Windows Explorer or File Explorer using a different method.

2. In Windows Explorer or File Explorer, in the Address bar, type %ProgramData%\Autodesk and press Enter.

3. Double-click the ApplicationPlugins folder.

4. Select the AS197432-L.bundle folder and press Delete.

5. In the Delete Folder message box, click Yes.
