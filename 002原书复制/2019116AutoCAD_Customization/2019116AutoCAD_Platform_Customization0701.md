# Chapter 7 Creating Tools and Tool Palettes

The Autodesk® AutoCAD® user interface has changed and evolved over the years to make it easier to access your favorite tools and allow you to create new custom tools. First introduced with AutoCAD 2004, tool palettes allow you to create tools dynamically, on the fly, based on the objects you create in a drawing or the files stored on a local/shared drive. AutoCAD comes with a number of predefined tool palettes that show the wide range of tools that a tool palette can contain.

Tools are organized on a tool palette and displayed using the Tool Palettes window. The Tool Palettes window is a modeless window, or dockable palette, with tabs along its left or right side; each tab represents one of the available tool palettes. Tool palettes can be organized into groups, allowing you to display only the tools you need based on the current task you are performing, and they can also be shared with other users.

NOTE

Tool palettes are available in AutoCAD on Windows only.

What Is a Tool Palette?

A tool palette is a container for user-defined content, and each is stored in a file with the extension .atc. ATC files are based on the Extensible Markup Language (XML). You create and edit these files when customizing tool palettes from the AutoCAD user interface with the Tool Palettes window or Customize dialog box.

TIP

ATC files can also be edited with caution from outside of AutoCAD using either an ASCII text editor, such as Notepad, or a specialized editor that is designed for XML files. Editing ATC files outside of AutoCAD can make it easy to update the paths used to reference several content types, such as blocks, raster images, and external references.

Figure 7.1 shows what several of the default tool palettes look like in the Tool Palettes window.

Figure 7.1 Tool palettes in the Tool Palettes window

Each tool palette can contain a number of different tools that are based on geometry in a drawing or an external file. A tool can also execute a command macro, an action macro, or an AutoLISP® expression. Once a tool is added to a tool palette, you can customize its properties. Most of the tools support two classifications of properties: those specific to the tool's type and those that are general to most objects in a drawing, such as color, linetype, and lineweight.

Using the Tool Palettes Window

The Tool Palettes window is the interface that is used to access the tools and tool palettes that come with AutoCAD, as well as those that you create yourself. Some of the functionality of the window should have a familiar feel to it for a couple of reasons. First, it shares a common framework with other palettes in AutoCAD, such as the Properties palette and the Layer Properties Manager. Second, tools can be displayed using Icon and Detail views, similar to the way files can be displayed in Windows Explorer or File Explorer.

You can display the Tool Palettes window using one of the following methods:

On the ribbon, click View tab Palettes panel Tool Palettes.

At the command prompt, type toolpalettes or tp and press Enter.

Figure 7.2 shows the main components of the Tool Palettes window. An explanation of each component follows.

Close Button Click the Close button to close the Tool Palettes window.

Tool Button A tool button represents one of the available tools on the current tool palette. The icon displayed for each tool varies by tool type. Click a button, or click and drag a tool into the drawing area to activate the tool. Right-click a button to display a menu that allows you to edit the tool.

Tool Button with Flyout When there is a flyout, the tool button represents a tool with more than one option; these are available on geometry- and dimension-related tools. Click the arrow next to the tool to display the additional tools.

Text Label A text label provides additional information about the tools on a tool palette.

Separator A separator is a horizontal bar that allows you to visually group related tools on a tool palette.

Tool Palette (Tab) Each tab represents one of the ATC files found in one of the designated locations in the Options dialog box (options command). Click a tab to switch tool palettes. Right-click a tab or in an empty area of a tool palette to customize it.

Additional Tool Palettes (Stacked Tabs) Stacked tabs indicate that there are additional tool palettes besides those currently visible as tabs in the Tool Palettes window. Click the stack of tabs to display a menu with all available tool palettes; select a tool palette from the list to set it as current.

Scroll Bar The scroll bar is displayed when there are tools on the current tool palette that are not visible. Click or drag the scroll bar to see the tools that are not currently visible. You can also click and drag in an empty area of the tool palette to scroll the listing of tools.

Title Bar The title bar displays the name of the palette and current tool-palette group. Click and drag the title bar to move the Tool Palettes window, or right-click it to display a menu to anchor or customize the Tool Palettes window.

TIP

You can resize the Tool Palettes window by positioning the cursor along its top or bottom edge. When the double-sided arrow cursor appears, click and drag to change the height and/or width of the palette. You can also enable resizing mode by right-clicking over the title bar and clicking Size. When the cursor changes to a multidirection cursor, click and drag over the Tool Palettes window to resize the palette.

Auto-Hide Toggle The Auto-Hide control collapses the Tool Palettes window down to its title bar only, resulting in more available screen real estate than when the window is not collapsed and docked. Passing the cursor over the title bar expands the Tool Palettes window temporarily.

Properties Button The Properties button displays a menu of options that allow you to anchor or customize the Tool Palettes window, create a new tool palette, add new command tools, or set a tool-palette group as current, among other tasks.

Figure 7.2 Components of the Tool Palettes window

Defining Tool Palettes

Now that you are familiar with the Tool Palettes window and how it works, it's time to dig in and take a closer look at how to customize tool palettes. As mentioned earlier, tool palettes are the containers used to store user-defined content—also known as tools. Most of the options that you will need to create and manage tool palettes are accessed from the Tool Palettes window.

Creating a Tool Palette

When creating your own tools, I recommend not using any of the default tool palettes that come with AutoCAD, and instead creating your own tool palettes. When you create your own tool palettes, you make it easier to share your tools with others and migrate your tools forward to a new release.

The following steps explain how to create a new tool palette called My Tools:

On the ribbon, click View tab Palettes panel Tool Palettes (or at the command prompt, type toolpalettes and press Enter).

In the Tool Palettes window, right-click a tool palette tab or in an empty area of the current tool palette. Click New Palette.

In the in-place editor, type My Tools and press Enter. The new tab is set as current and is ready for you to add tools to it.

New tool palettes are created in the first writable folder AutoCAD finds under the Tool Palettes File Locations node on the Files tab of the Options dialog box (options command). You can modify the paths AutoCAD uses to locate tool palette files by using the *_toolpalettepath system variable.

Modifying Tool Palettes

After a tool palette has been created, you can add tools to or modify the palette. I discuss adding tools later in this chapter in the section「Adding and Modifying Tools.」You can perform the following tasks to modify a tool palette:

Rename a tool palette

Delete a tool palette that is no longer needed

Reorder a tool palette in the Tool Palettes window

Control the view style for the tools on a tool palette

Renaming a Tool Palette

You can rename a tool palette by doing the following:

In the Tool Palettes window, right-click the tool palette's tab you want to rename and click Rename Palette.

In the in-place editor, type a new name and press Enter.

Deleting a Tool Palette

A tool palette can be removed by following these steps when it is no longer needed:

In the Tool Palettes window, right-click the tool palette's tab you want to remove and click Delete Palette.

In the Confirm Palette Deletion message box, click OK to remove the palette.

TIP

If you think you might want to restore a tool palette later, export the tool palette before removing it. I discuss how to export and import a tool palette in the section「Sharing Tool Palettes and Tool-Palette Groups」later in this chapter.

Reordering a Tool Palette in the Tool Palettes window

You can adjust the order in which a tool palette is displayed in the Tool Palettes window by following these steps:

In the Tool Palettes window, right-click the tool palette's tab you want to change the order of.

Click Move Up or Move Down.

Controlling the View of Tools on a Tool Palette

The image size and view style of the tools on a tool palette can be adjusted by doing the following:

In the Tool Palettes window, right-click the tool palette's tab whose view options you want to change and click View Options.

When the View Options dialog box (see Figure 7.3) opens, change the Image Size and View Style options.

From the Apply To drop-down list, select Current Palette to change the view options for the current palette only. Select All Palettes to apply the change to all of the palettes available from the Tool Palettes window (not just those in the current tool-palette group).

Click OK.

Figure 7.3 Controlling the image size and style for tools

Adding and Modifying Tools

Tools are the main component of any tool palette. For the most part, the tools on a tool palette are based on the same objects that you would add to a drawing. These objects can be both graphical and nongraphical. Some types of tools can execute a command macro or use files that are stored externally of a drawing file. Once a tool is added to a tool palette, you can change its properties to align with your established CAD standards.

The types of tools that you can add to a tool palette are as follows:

Geometry

Dimensions, leaders, and geometric tolerances

Annotation tools (text, tables, and wipeouts)

Blocks (static and dynamic)

Hatch-pattern and gradient fills

External references and raster images

Lights

Visual styles

Materials


Cameras

Commands

NOTE

If you are using an AutoCAD-based product, such as AutoCAD® Architecture, you might have access to additional types of tools that can be added to a tool palette.

Creating a Tool

The tool-creation process that you need to follow depends on the type of tool you want to create. As I previously mentioned, most of the source information used to create a tool comes from the objects in a drawing, but in some cases the information also comes from external files that are stored outside of a drawing.

The following steps show how to create a Geometric tool based on a graphical object within a drawing file:

Create a new drawing file.

Create a new layer named Objs and assign it the color Red (1).

Create a second new layer named Lines and assign it the color Green (3).

Set the Objs layer as current.

On the Objs layer, draw a line object using the line command.

On the ribbon, click View tab Palettes panel Tool Palettes.

Click the My Tools tab to set it as current. (If you do not have a My Tools tab in the Tool Palettes window, go back to the section「Creating a Tool Palette」earlier in the chapter and follow the steps to create the tool palette.)

Select the line object that you drew in step 5. Press and hold down the right pointer button, and drag the line object over the My Tools tool palette in the Tool Palettes window (see Figure 7.4). Do not click over one of the grips. Release the pointer button to create the tool (see Figure 7.5).

Set layer 0 as current.

In the Tool Palettes window, click the new Line tool. The line command starts; specify a start and endpoint for the command; then end the command. The new line object is added to the Objs layer even though layer 0 was current.

Click the arrow on the right side of the Line tool. On the flyout (see Figure 7.6), click the Circle tool. The circle command is started and any new circles you create with the tool are placed on the Objs layer.

Right-click the Line tool and click Properties.

When the Tool Properties dialog box (see Figure 7.7) is opened, you can edit the tool's properties. In the General section, select the Layer property and then click the drop-down list that is displayed. Select Lines from the list of available layers in the current drawing.

In the Command section, select the Flyout Options property and then click the ellipsis […] button. In the Flyout Options dialog box (see Figure 7.8), clear all check boxes except Line, Arc, and Polyline. Click OK.

Click OK again to save the changes to the tool and close the Tool Properties dialog box.

Try the Line tool again. Any lines drawn with the tool now are placed on the Lines layer.

Click the arrow on the right side of the Line tool. The only tools that are displayed on the flyout this time are Line, Arc, and Polyline (see Figure 7.9).

Figure 7.4 Adding a new tool based on a line object from the drawing area

Figure 7.5 New Line tool on a custom tool palette

Figure 7.6 A flyout offers additional related geometric tools.

Figure 7.7 Changing the properties of a tool

Figure 7.8 Controlling which tools are displayed on the flyout

Figure 7.9 Revised tool and flyout

Geometric Tool

You can create a Geometric tool based on objects in one of your drawings by doing the following:

Display the Tool Palettes window.

Select one of the following objects from the current drawing: Line

Arc

Circle

Ellipse

Polyline

Ray

Spline

Xline (Construction line)

Drag and drop the object onto a tool palette.

Right-click the new tool and click Properties. Edit the properties in the Command section. Change the Use Flyout property to No if you wish to disable the flyout for the tool, or change which tools are displayed on the flyout by editing the Flyout Options property. Click OK to save the changes to the tool.

Dimension Tool

You can create a Dimension tool based on the dimension objects in one of your drawings by following these steps:

Display the Tool Palettes window.

Select one of the following objects from the current drawing: Aligned dimension

Linear dimension

Arc Length dimension

Jogged dimension

Radius dimension

Diameter dimension

Angular dimension

Ordinate dimension

Quick leader

Geometric tolerance

Drag and drop the object onto a tool palette.

Right-click the new tool and click Properties. Edit the properties in the Command section. Change the Use Flyout property to No if you wish to disable the flyout for the tool, or change which tools are displayed on the flyout by editing the Flyout Options property. Click OK to save the changes to the tool.

Multileader Tool

You can create a Multileader tool based on existing multileader objects in one of your drawings by doing the following:

Display the Tool Palettes window.

Select a multileader object in the current drawing.

Drag and drop the object onto a tool palette.

Annotation Tools

You can create an Annotation tool in one of your drawings with these steps:

Display the Tool Palettes window.

Select one of the following objects in the current drawing: Single-line text

Multiline text

Table

Wipeout

Drag and drop the object onto a tool palette.

Hatch Tool

You can create a Hatch tool based on a hatch pattern or gradient fill object in one of your drawings by doing the following:

Display the Tool Palettes window.

Select a hatch pattern or gradient fill object in the current drawing.

Drag and drop the object onto a tool palette.

A Hatch tool can also be created from a hatch pattern in a PAT (pattern image) file by doing the following:

Display the Tool Palettes window.

On the ribbon, click View tab Palettes panel DesignCenter (adcenter command).

On the DesignCenter™ palette, click the Search button along the top.

When the Search dialog box (see Figure 7.10) opens, click the Look For drop-down list and select Hatch Pattern Files.

Click the In drop-down list and select My Computer.

On the Hatch Pattern Files tab, in the Search For The Name text box, type *.pat and click Search Now.

In the Results list, double-click the file acad.pat. The acad.pat file is loaded into DesignCenter, and a thumbnail is displayed for each hatch pattern present in the file.

Drag and drop a hatch-pattern thumbnail from DesignCenter onto a tool palette. (If you want to create a gradient fill, you can create a Hatch tool based on any pattern and then change the tool's Tool Type property from Hatch to Gradient with the Tool Properties dialog box.)

Figure 7.10 Searching for named objects and support files

Block Tool

You can create a Block tool based on a block reference object inserted into one of your drawings by doing the following:

Save the current drawing.

Display the Tool Palettes window.

Select a block reference object in the current drawing.

Drag and drop the object onto a tool palette.

You can also create a Block tool from a DWG file:

Display the Tool Palettes window.

Open Windows Explorer (Windows XP and Windows 7) or File Explorer (Windows 8), and browse to the drawing (DWG) file you want to create a Block tool from.

In Windows Explorer or File Explorer, click and drag the drawing file and drop it onto a tool palette.

As an additional alternative, a Block tool can also be created with DesignCenter by doing the following:

Display the Tool Palettes window.

On the ribbon, click View tab Palettes panel DesignCenter (adcenter command).

On the DesignCenter palette, browse to the drawing (DWG) file or drawing file that contains the block definition you want to create a Block tool from.

Do one of the following: Click and drag the drawing file, and drop it onto a tool palette to create a Block tool based on all the objects contained in the drawing file's model space.

Double-click the drawing file to see all the named objects within it. Double-click the Blocks item to view all blocks in the drawing file. Click and drag a block definition, and drop it onto a tool palette to create a Block tool.

NOTE

The definition of the block does not become part of the Block tool, but the tool maintains information about where the block definition exists: the drawing file and the block name.

External Reference or Raster Image Tool

You can create an External Reference (xref) or Raster Image tool based on an xref or raster image attached to a drawing by doing the following:

Save the current drawing.

Display the Tool Palettes window.

Select an xref or raster image object in the current drawing.

Drag and drop the object onto a tool palette.

You can also create an xref or Raster Image tool from a DWG or supported image file by doing the following:

Display the Tool Palettes window.

Open Windows Explorer (Windows XP and Windows 7) or File Explorer (Windows 8), and browse to the drawing or supported image file you want to create a tool from.

In Windows Explorer or File Explorer, click and drag the file, and drop it onto a tool palette.

If you created the tool by dragging and dropping a DWG file, right-click the tool and click Properties.

When the Tool Properties dialog box opens, select the Insert As property. Click the drop-down list and select Xref. Click OK.

As an additional alternative, an xref or Raster Image tool can be created with DesignCenter by doing the following:

Display the Tool Palettes window.

On the ribbon, click View tab Palettes panel DesignCenter (adcenter command).

On the DesignCenter palette, browse to the drawing or supported image file you want to create a tool from.

Click and drag the file, and drop it onto a tool palette.

3D Visualization Tools

You can create a Light or Camera tool based on a light or camera object in one of your drawings with these steps:

Display the Tool Palettes window.

Select a light or camera object in the current drawing.

Drag and drop the object onto a tool palette.

The following explains how to create a Visual Style tool based on a saved visual style in a drawing:

Display the Tool Palettes window.

On the ribbon, click View tab Palettes panel Visual Styles Manager (visualstyles command).

On the Visual Styles Manager, click and drag one of the thumbnails along the top of the window, and drop it onto a tool palette.

You can create a Material tool based on a material stored in one of your drawings or your library by doing the following:

Display the Tool Palettes window.

On the ribbon, click View tab Palettes panel Materials Browser (matbrowseropen command).

In the Materials Browser, click and drag one of the materials listed in the Document Materials or current library list, and drop it onto a tool palette.

Command Tool

You can create a Command tool that executes a command macro by following these steps:

Display the Tool Palettes window.

In the Tool Palettes window, right-click in an empty area of the current tool palette or the Tool Palettes window's title bar. Click Customize Commands.

In the Customize User Interface (CUI) Editor, from the Command List pane, click and drag one of the commands and drop it onto a tool palette. I explain how to work with the CUI Editor and define commands in Chapter 5,「Customizing the AutoCAD User Interface for Windows.」

Using a Tool

A tool can be started with a single left click, but some can also be started by being dragged and dropped into the drawing area. When supported, the two actions often invoke slightly different responses. For example, if you click a Hatch tool, you are prompted for an insertion point, which is used to identify the closed boundary that should be filled. If you drag a Hatch tool into the drawing area and drop it into a closed boundary, you are not prompted to specify an insertion point or to click inside a closed boundary. When you drop the Hatch tool, AutoCAD uses the current position of the cursor as the point it should try to use to create the hatch-pattern fill.

Modifying Tools

After a tool has been created, you can manage the tool on a tool palette or change its properties. You can perform the following tasks to modify a tool:

Change a tool's properties

Specify a new image for a tool

Delete a tool that is no longer needed

Copy or duplicate a tool

Move a tool on a tool palette or to a different tool palette

Sort tools on a tool palette

Changing the Properties and Image of a Tool

After a tool has been created, you can change its properties and image:

In the Tool Palettes window, right-click the tool you wish to change and click Properties.

In the Tool Properties dialog box, do any of the following: Edit the values of the properties for the tool, enter a value in the text boxes, or select a value from the drop-down lists.

Right-click over the image to the left of the Name and Description text boxes and click Specify Image. In the Select Image File dialog box, browse to and select the image file you want to use.

Click OK to save the changes you made.

TIP

You can also right-click over a tool and click Specify Image to choose a new image for the tool.

Deleting a Tool

When a tool is no longer needed, you can remove it:

In the Tool Palettes window, right-click the tool you wish to remove and click Delete.

In the AutoCAD message box, click OK to remove the tool.

TIP

If you think you might want to restore the tool later, export the tool palette that the tool is on before removing it. I discuss how to export a tool palette in the section「Sharing Tool Palettes and Tool-Palette Groups」later in this chapter.

Copying/Duplicating a Tool

If you want to create a new tool that is similar to a tool that already exists on a tool palette, do the following:

In the Tool Palettes window, right-click the tool to duplicate and click Copy.

Optionally, click a tool palette tab to add the copied tool to a different tool palette.

Right-click in an empty area of the tool palette and click Paste.

Click and drag the tool to reposition it on the tool palette.

Moving a Tool

You can change the position of a tool on the current palette or move it to a different palette by doing one of the following:

In the Tool Palettes window, click and drag a tool to move it on the current palette. Release the pointer button when the tool is where you want to place it.

In the Tool Palettes window, right-click the tool you want to move to a different palette and click Cut. Click one of the other tool-palette tabs. Right-click in an empty area of the tool palette and click Paste. Click and drag the tool to reposition it on the tool palette.

Sorting Tools

The tools on a tool palette can be sorted by type or name by doing the following:

In the Tool Palettes window, right-click in an empty area of the tool palette.

Click Sort Name or Type.

Adding Text Labels or Separators

Text labels and separators allow you to provide information about the tools on a tool palette and to group related tools together. You can create either of these by doing the following:

Display the Tool Palettes window.

In the Tool Palettes window, right-click in an empty area of the current tool palette and click Add Text or Add Separator.

If you clicked Add Text, type a text message in the in-place editor that is displayed and press Enter.

Click and drag the new item on the tool palette to change its current placement as needed.

Organizing Tool Palettes with Tool-Palette Groups

Tool-palette groups allow you to control which tool palettes are displayed in the Tool Palettes window. By default, all tool palettes are displayed. You can tell which tool-palette group is active because its name is displayed on the Tool Palettes window's title bar. When all tool palettes are displayed, the title bar displays the text「Tool Palettes - All Palettes.」

You can switch tool-palette groups by clicking the Properties button in the Tool Palettes window (see Figure 7.2) and selecting the name of the tool-palette group to make it current. The available tool-palette groups are listed at the bottom of the menu. For the tool palettes you create, consider adding your own tool-palette group; this ensures that only your tool palettes are visible when using the Tool Palettes window.

In the following steps, you'll create a new tool-palette group named My Group and add tool palettes to it:

On the ribbon, click Manage tab Customization panel Tool Palettes (or at the command prompt, type customize and press Enter).

When the Customize dialog box (see Figure 7.11) opens, scroll to the bottom of the tree view on the right side.

Right-click near the bottom of the tree view on the right side, as shown in Figure 7.11. Click New Group. (Do not right-click over one of the existing groups or palettes in a group; that creates a nested group. Right-clicking to the right or left of an item in the tree view does not work either.)

In the in-place editor, type My Group and press Enter.

In the Palettes list, on the left click and drag the My Tools tool palette, and drop it on the My Group tool-palette group.

Right-click the My Group tool-palette group and click Set Current.

Click Close to save the changes and exit the Customize dialog box.

Figure 7.11 Creating and managing tool-palette groups

You can also perform the following tasks from the Customize dialog box:

Rename a tool palette

Create a new tool palette

Delete a tool palette that is no longer needed

Export and import tool palettes

Rename a tool-palette group

Delete a tool-palette group

Reorder a tool palette within a tool-palette group

Export and import tool-palette groups

Sharing Tool Palettes and Tool-Palette Groups

Tool palettes by default are stored and created on the local drive of your workstation. It is possible to share the tool palettes you create by doing one of two things:

Create your tool palettes in a shared location by adding that location as the first writable folder AutoCAD finds under the Tool Palettes File Locations node on the Files tab of the Options dialog box (options command). By creating tool palettes in a shared location and having all users point to that location, you ensure that users will not need to import the tool palettes on their workstations.

Export tool palettes to XTP (Exported Tool Palettes) files with the Customize dialog box (customize command), and then import them on another workstation with the Customize dialog box. In the Customize dialog box, from the Palettes list select a tool palette and right-click. Then click Export or Import, and specify or select an XTP file based on the option you choose.

NOTE

Autodesk does not recommend sharing tool palettes with users on older releases or across different products. Doing so could result in some tools not working properly—or at all.

Tool-palette groups also are stored on your local drive of your workstation as part of your AutoCAD user profile. You can share with others any tool-palette groups that you create by exporting them from one workstation and importing them onto another. Tool-palette groups can be exported or imported using the Customize dialog box. In the Customize dialog box, in the Palette Groups tree view select a tool-palette group and right-click. Then click Export or Import, and specify or select an XPG file based on the option you chose.

NOTE

Before you import a tool-palette group, you must import all tool palettes that are referenced by the group.