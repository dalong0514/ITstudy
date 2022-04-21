## 2022007. AutoCAD-Customization-Boot-Camp

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

AS197468-L

AutoCAD Customization Boot Camp: Basic (No Experience Required)

Learning Objectives

1 Learn how to create custom desktop icons.

2 Learn how to create command aliases.

3 Discover tools and tool palettes.

4 Learn how to modify the Quick Access toolbar and ribbon.

Description

You can extend AutoCAD software several ways, but many users are unsure of where or how to get started. In this lab, you'll create custom desktop icons, create and modify command aliases that you can use to start commands, define tools and tool palettes, and modify the Quick Access toolbar and ribbon to reduce repetitive drawing tasks. This lab will give you a solid foundation in some of the available customization features that AutoCAD offers to increase your productivity upon your return to the office. This session will feature AutoCAD and AutoCAD LT software.

### 01. Introduction

The AutoCAD software is an extensive 2D drafting and 3D modeling program that has grown in functionality since it was first introduced almost 35 years ago back in 1982. What sets AutoCAD apart from many other CAD programs is its expansive customization and automation capabilities. The customization and programming features of AutoCAD allow individuals and companies to simplify everyday workflows, such as:

1 Initial drawing setup; establish drawing units and format, create layers, insert a title block and populate attribute values.

2 Extraction of design data for use downstream in a bill of materials or order entry system.

3 Consumption of project information from a data source such as a spreadsheet or database.

This lab will provide you with the opportunity to roll-up your sleeves and get some hands-on experience with customizing AutoCAD which will prepare you to apply the techniques covered in your everyday workflows. While knowing how to program isn't a requirement to customize AutoCAD, learning how to program does provide you with a greater set of resources to automate tasks in AutoCAD.

### 02. Which Customization and Programming Options are Available

Not all customization and programming options are created equally, some options are easy to learn and are well integrated into the AutoCAD program that many don't even realize they are customizing the program. For example, creating new layers and named styles are forms of customization that are performed frequently. There are two types for customization and programming that are available; drawing and application.

The following lists many of the customization and programming options available:

Basic 

Drawing

• Layers

• Blocks

• Annotation styles (text, dimensions, multileaders, and tables)

• Materials and visual styles

• Drawing templates

Application

• Desktop shortcut

• Command aliases

• Tool palettes

• Workspaces

• User profiles

• Plot styles

Intermediate

• Dynamic blocks

Application

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

### 03. What You Need to Get Started

Many of the customization and programming options available for use within the AutoCAD program are supported through utilities or commands found inside the program, or applications installed with the operating system (Windows or Mac OS). It is when you want to extend the functionality of the AutoCAD program using ActiveX, Managed .NET, or ObjectARX that you will need to purchase, download, and/or install additional software.

### 04. Supplemental Content

See the separate AS197468-L-Ambrosius-Supplement-AU2018.pdf for the supplemental content in the dataset related to this session.

### 05. Exercises

This section contains all the exercises that will be covered during this lab or when you get back to the office.

E1 Create a Desktop Shortcut

This exercise explains how to create a custom desktop shortcut to launch AutoCAD, create the default drawing based on a specific drawing template file, and set the '3D Basic' workspace current.

1 Open Windows Explorer or File Explorer.

Tip: If you have a keyboard with a Windows key, press Explorer or File Explorer.

Windows Explorer or File Explorer can also be started from Windows by doing one of the following:

• On the Windows 7 taskbar, click the Start Menu button Accessories ➢ Windows Explorer.

• On the Windows 8 or Windows 10 Start Screen, type explorer. In the Search charm, click File Explorer. You can also right-click in the lower-left corner of the screen and choose File Explorer.

2 In Windows Explorer or File Explorer, in the Address Bar, type c:\d and select the C:\Datasets entry in the list.

3 Navigate to the dataset folder specific for this session which should be at

C:\DATASETS\AS197468-L AutoCAD Customization Boot `Camp_ Basic` (No Experience Required) 

4 In the AS197468-L folder, double-click the EX1 - Command Switches.txt file to open it in Notepad.

5 In Notepad, select the text under Target as shown in the following image. Right-click over the selected text and choose Copy.

6 Minimize all open applications until you can see the Windows Desktop.

Tip: If you have a keyboard with a Windows key, press Windows. win + M to minimize all open.

7 Right-click in an empty area of the desktop and choose New Shortcut.

8 In the Create Shortcut dialog box, in the Type the Location of the Item text box, type C:\ and then click Browse.

9 In the Browse for Files or Folders dialog box, navigate to C:\Program Files\Autodesk\AutoCAD 2019 and select acad.exe. Click OK.

10 In the Create Shortcut dialog box, click in the Type the Location of the Item text box and press the End key followed by pressing the Spacebar once.

11 Right-click in the Type the Location of the Item text box and choose Paste.

Note: If the dataset was placed in a different location, update the text C:\DATASETS\AS197468-L AutoCAD Customization Boot Camp_ Basic (No Experience Required) to match the location of the dataset for this session.

12 Click Next.

13 In Notepad, copy the text under Name and replace the text in the Type a Name for this Shortcut text box of the Create Shortcut dialog box with the copied text.

14 Click Finish to create the new shortcut.

15 If a message box is displayed informing you that the shortcut already exists, click Yes.

Normally, you would click No to avoid losing the existing customized shortcut.

16 Double-click the My AutoCAD Icon shortcut to test it.

When the AutoCAD program starts, you should notice that no splash screen is displayed, the default drawing created is based on the C-size.dwt drawing template file, and the 3D Basic workspace is set current.

Note: If the drawing template file isn't found, no default drawing will be created or the one created won't be based on the C-size.dwt drawing template file.

After a shortcut has been created, it can be modified by right-clicking over it and choosing Properties. When the Properties dialog box is displayed, you can modify the application and command line switches previously added in the Target text box.

E2 Define Custom Command Aliases

This exercise explains how to define a command alias to start the REVCLOUD command, override the C command alias to start the COPY command rather than the CIRCLE command, and create a new alias for the CIRCLE command.

E3 Create a Tool Palette and Tools

This exercise explains how to create a new tool palette with tools based on existing geometry in a drawing and a command tool defined in the acad.cuix file.

The following steps explain how to create a new tool palette:

1 In AutoCAD, open the Sample Drawing.dwg file from the C:\DATASETS\AS197468-L AutoCAD Customization Boot Camp_ Basic (No Experience Required) folder or the folder in which the dataset for this session is stored.

2 On the ribbon, click View tab => Palettes panel Palettes window if it isn't already displayed.

3 On the Tool Palettes window, right-click over a tab and choose New Palette.

4 In the in-place editor, type My Tools and press Enter.

Note: If the in-place editor closes and the default name is accepted, right-click the new tool palette's tab and choose Rename Palette. Type the new name and press Enter. In these steps, you add new tools to the My Tools tool palette:

1 Zoom to the extents of the drawing.

2 Select the hatch object located in the walls along the right side of the drawing. Press and hold down the right mouse button, and then drag the cursor over the My Tools palette.

3 Release the mouse button to create a new hatch tool based on the properties of the selected hatch object.

4 Select and drag the dimension from the left side of the drawing and drop it onto the My Tools palette.

You should now have two tools on the My Tools palette.

5 In an empty area of the My Tools palette or over the title bar of the Tool Palette window, right-click and choose Customize Commands.

6 In the Customize User Interface editor, Command List pane, click in the Search Command List text box and type revision.

7 In the Commands list, select the Rectangular Revision Cloud command.

8 Press and hold down the left mouse button over the selected command and drag the command over the My Tools palette.

Note: You might need to move the Customize User Interface (CUI) Editor to see the Tool Palettes window.

9 Release the mouse button to add the Command tool.

10 Click Cancel (or OK) to close the CUI Editor.

The following steps explain how to modify the properties of a tool:

1 On the Tool Palettes window, right-click over the Rectangular Revision Cloud tool and choose Properties.

2 In the Tool Properties dialog box, General section, click the RevCloud from the drop-down list.

3 Click OK to apply the change.

Layer field and select

Note: The Command String field in the Tool Properties dialog box contains a copy of the command macro string from the original command defined in the acad.cuix file.

The following steps explain how to create tools from drawing files:

1 Switch to or open Windows Explorer or File Explorer.

Tip: You can open Windows Explorer or File Explorer from inside AutoCAD by entering explorer at the Command prompt.

2 In Windows Explorer or File Explorer, navigate to the C:\DATASETS\AS197468-L AutoCAD Customization Boot Camp_ Basic (No Experience Required) folder or the folder in which the dataset for this session is stored.

3 Select the Conference Table.dwg file, and then drag and drop the file onto the My Tools palette.

4 Repeat the previous step for the C-Size Title Block.dwg file.

5 Switch back to AutoCAD and try each of the tools you added to the My Tools palette.

Some tools work differently when clicked versus dragged and dropped into the drawing area, such as hatch and block tools.

Tip: Pressing the Spacebar after using a tool from the Tool Palettes window repeats that tool.

6 Create a new drawing and try the tools again.

When the hatch, dimension, or Rectangular Revision Cloud tools are used, the layers in which the tools were assigned are automatically created in the new drawing. This happens because each tool remembers the properties of the layer from which the geometry was originally assigned when the tool was created or last modified.

E4 Create a Quick Access Toolbar (QAT)

This exercise explains how to create a new Quick Access toolbar (QAT) and assign it to a workspace.

In these steps, you create a new QAT and modify the commands that are to be displayed:

1 In AutoCAD, on the ribbon, click Manage tab ➢ Customization panel ➢ User Interface.

2 In the Customize User Interface (CUI) Editor, Customizations In pane, right-click the Quick Access Toolbars node and choose New Quick Access Toolbar.

3 Rename the new toolbar by typing My QAT and pressing Enter.

Note: If you can't change the toolbar's name, right-click the new toolbar and choose Rename.

4 Click the plus-sign next to the new Quick Access toolbar to reveal the default set of commands.

5 Right-click the Plot command and choose Remove. Click Yes to confirm the deletion of the element.

6 In the Command List pane, Search Command List text box, type spell.

7 Click and drag the Spell Check command from the Command List and drop it onto the My QAT toolbar below the Redo command.

8 In the Search Command List text box, clear the current text and type publish.

9 Add the Publish… command above the Spell Check command on the My QAT toolbar.

10 Click the Command List drop-down list and choose Ribbon Control Elements.

11 In the Search Command List text box, clear the current text and type layer.

12 Select the Layer List Combo Box control and add it below Spell Check on the My QAT toolbar.

The completed Quick Access toolbar should now look like the following in the CUI Editor:

13 Click Apply to save the changes made.

Once the Quick Access toolbar has been created, it must be added to a workspace before it can be displayed in the AutoCAD user interface.

These steps explain how to create a new workspace from an existing workspace and display the My QAT toolbar:

1 In the Customize User Interface (CUI) Editor, Customizations In pane, click the plus-sign next to the Workspaces node to expand it if it isn't already expanded.

2 Right-click over the Drafting & Annotation workspace and choose Duplicate.

3 Right-click over the new workspace named Copy Of Drafting & Annotation1 and choose Rename.

4 In the in-place editor, type My Workspace and press Enter.

5 Right-click over the new workspace named My Workspace and choose Set Current.

6 In the Workspace Contents pane, click Customize Workspace.

7 In the Customizations In pane, expand the Quick Access Toolbars node and click the checkbox next to My QAT (which should now be checked).

8 In the Workspace Contents pane, click Done.

9 Click OK to save the changes and exit the CUI Editor.

Note: If any message boxes are displayed, click OK to continue loading the changes to the CUIx file.

E5 Create a Ribbon Panel and Tab

This exercise explains how to create and add commands to a new ribbon panel, create a new ribbon tab to display a ribbon panel, and control the display of a ribbon tab with a workspace.

1 In AutoCAD, on the ribbon, click Manage tab => Customization panel => User Interface.

2 In the Customize User Interface (CUI) Editor, Customizations In pane, click the plus-sign next to the Ribbon node to expand it. Right-click the Panels node and choose New Panel.

3 In the in-place text editor, type My Panel and press Enter.

Note: If you cannot change the panel's name, right-click the new ribbon panel and choose Rename.

4 In the Command List pane, Search Command List text box, type rectang.

5 In the Command List pane, select the Rectangular Revision Cloud command and drag it to Row 1 under the My Panel ribbon panel. Release the mouse button to add the command.

6 If the Rectangular Revision Cloud command you just added to Row 1 isn't selected, select it now.

7 In the Properties pane, on the right, click the Button Style field and select Large with Text (Vertical) from the drop-down list.

8 Click in the text box to the right of the Name field, and then type Rectangular\nRevcloud and press Enter.

Note: The \n forces the label to be displayed on two lines; the \n disappears once the field loses focus but that is by design.

9 Add a few of your favorite commands from the Command List pane to the My Panel ribbon panel and adjust their names and button styles as desired.

10 Click Apply to save the changes.

The following steps explain how to create a custom command and add it to the ribbon panel:

1 In the Command List pane, click Clear to remove any text in the Search Command List text box.

2 Click Create a New Command.

3 In the Properties pane, change the following values:

Name: Revision Number Macro: ^C^C-LAYER;M;RevNums;C;1;;;-INSERT;REVNUM;\1;;0; Note: Rather than typing all the text, you can copy and paste the name and macro string from the EX5 - Create a Ribbon Tab and Panel.txt file located in the C:\DATASETS\AS197468-L AutoCAD Customization Boot Camp_ Basic (No Experience Required) folder or the folder in which the dataset has been stored.

4 Click Apply to save the changes to the command.

5 In the Properties pane, click in the Small Image field and then click the Ellipsis button […].

6 In the Select Image File dialog box, browse to C:\DATASETS\AS197468-L AutoCAD Customization Boot Camp_ Basic (No Experience Required) and select the RevNum.bmp file. Click Open.

Note: As a reminder, you might need to browse to a different location based on where the dataset files are stored.

7 Click in the Large Image field and type RevNum.bmp.

8 Click Apply to save the current changes.

9 In the Command List pane, select the Revision Number command and drag it to Row 1 under the My Panel ribbon panel.

10 Select the Revision Number command you just added to Row 1 of the My Panel ribbon panel and set its Button Style to Large with Text (Vertical) in the Properties pane.

11 Click in the text box to the right of the Name field, then type Revision\nNumber and press Enter.

12 Click Apply to save the changes.

The ribbon panel should include the Rectangular Revision Cloud and Revision Number commands along with any additional commands that you chose to add.

The following explains how to create and customize a ribbon tab:

1 In the Customize User Interface (CUI) Editor, Customizations In pane, click the plus-sign next to the Ribbon node to expand it if it isn't already expanded. Right-click the Tabs node and choose New Tab.

2 In the in-place text editor, type My Tab and press Enter.

Note: If you cannot change the tab's name, right-click the new ribbon tab and choose Rename.

3 Expand the Panels node under the Ribbon node if it isn't already expanded.

4 Under the Panels node, right-click over the My Panel node and choose Copy.

5 Under the Tabs node, right-click over the My Tab node and choose Paste.

A reference of the My Panel ribbon panel is added to the My Tab ribbon tab.

6 Click Apply to save the changes.

The following explains how to add the My Tab ribbon tab to the current workspace:

1 In the Customize User Interface (CUI) Editor, Customizations In pane, click the plus-sign next to the Workspaces node to expand it if it isn't already expanded.

2 Select the My Workspace (current) workspace and click Customize Workspace.

3 In the Customizations In pane, expand the Ribbon next to My Tab.

Tabs node and click the checkbox

My Tab should now be checked and added to the Ribbon Tabs node in the Workspace Contents pane.

4 In the Workspace Contents pane, click Done.

5 Click OK to save the changes and exit the CUI Editor.

Note: If any message boxes are displayed, click OK to continue loading the changes to the CUIx file.

6 On the ribbon, click My Tab to see My Panel and its commands.

E6 Modify a Workspace

This exercise explains how to modify a workspace directly in the user interface and save the changes to the current workspace.

1 On the Quick Access toolbar, click the Customize button and then choose Show Menu Bar.

2 On the menu bar, click Tools => Toolbars => AutoCAD => Layers.

The Layers toolbar should now be displayed.

3 On the Quick Access toolbar, click the Customize button and then choose Hide Menu Bar.

4 On the ribbon, right-click over a ribbon tab and choose Show Tabs the Parametric ribbon tab.

Parametric to hide

The Parametric ribbon tab should now be hidden.

5 On the ribbon, click the Annotate tab to set it current.

6 Click and hold the left mouse button over an empty area of the Dimensions panel and drag it to the left of the Text panel. Release the mouse button to reposition the Dimensions panel.

7 On the ribbon, click View tab => Palettes panel => Properties.

The Properties palette should now be displayed. 8. On the status bar, click Workspace Switching => Save Current As.

9 In the Save Workspace dialog box, click the drop-down list and select My Workspace.

10 Click Save. When prompted to replace the workspace, click Replace.

11 On the status bar, click Workspace Switching Drafting & Annotation.

Your custom QAT and ribbon tab should no longer be displayed along with the Layers toolbar and Properties palette, and the Parametric tab should be displayed on the ribbon once again.

12 On the status bar, click Workspace Switching => My Workspace.

Your custom QAT and ribbon tab should be restored along with the other changes you made to the My Workspace.

E7 Reset the AutoCAD Program

This exercise explains how to reset AutoCAD 2019 back to its default settings and files.

1 Close all instances of AutoCAD 2019.

2 Do one of the following:

• On the Windows 7 taskbar, click the Start button ➢ All Programs ➢ Autodesk AutoCAD 2019 - English ➢ Reset Settings to Default.

• On the Windows 8 or Windows 10 Start Screen, under the AutoCAD 2019 English category, click Reset Settings to Default.

3 In the Reset Settings - Backup dialog box, click Reset Custom Settings.

When you are back at the office, you might want to click Back Up and Reset Custom Settings to create a ZIP file containing all your custom settings and files before resetting the program.

4 When the Reset Settings - Confirmation message box is displayed, click OK.