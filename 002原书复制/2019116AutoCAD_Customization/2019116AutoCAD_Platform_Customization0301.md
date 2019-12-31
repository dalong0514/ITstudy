# Chapter 3 Building the Real World One Block at a Time

Drawings are made of geometry that is arranged in specific ways to represent a part to be manufactured, a building to be constructed, or even the land on which a new highway might be built. No matter what type of drawings you create, your drawings most likely consist of many object groupings that represent objects in the physical world.

Instead of dedicating time to re-create the geometry each time, you can create the objects once and store them as a block definition. Block definitions are another type of nongraphical object that can be in a drawing, much like text and dimension styles.

In addition to geometric objects, block definitions can contain attribute definitions, which allow you to embed information into a block. The information stored in attributes can be extracted to an external file or added to a table in a drawing. When the insert command or one of the programming languages is used, the Autodesk® AutoCAD® program creates a block reference object that specifies where and how the objects from the block definition should be drawn onscreen or plotted.

## 1. Defining and Editing a Block Definition

Block definitions must be defined in a drawing before you can create (or, as commonly known, insert) a block reference. A block reference object specifies where and how the objects from a block definition should be drawn onscreen or plotted. You typically create block definitions by first adding the geometry for your block in model space and then using the block command to define which objects will make up the block definition. AutoCAD also offers a special environment called the Block Editor (bedit command) for working with block definitions. Once a block definition is defined, you can use the insert command to create a block reference of a block definition.

### 1. Defining a Block Definition

You do not have to learn a lot of new skills before creating a block definition since the process leverages many skills that you should already have, such as creating geometry and using nongraphical objects like layers and text styles. However, when defining a block you must consider the following:

1. Name 

    The name of a block definition is used to differentiate one from another; each block definition in a drawing must have a unique name. Drawings can easily contain hundreds and even thousands of block definitions. When naming block definitions, use descriptive names, but don't make them so long that the user must carefully read a sentence-long name. I discussed naming blocks and other nongraphical objects in Chapter 2,「Working with Nongraphical Objects.」

2. Base (or Insertion) 

    Point The base point for a block definition is similar to a drawing's origin. This point is used as a block reference's insertion point, the same point that is used to drag a preview of the block onscreen with the insert command. You typically specify the base point of a block on one of the objects in the block definition, such as an endpoint or intersection of two objects.

3. Objects 

    The objects that make up the block definition determine how the block references inserted into a drawing will look and behave. Objects within a drawing include geometry objects such as lines, circles, arcs, and even other blocks. Blocks can also include special objects known as attribute definitions, which allow you to add to a block information such as a project name or part number. I discuss attributes in the section「Embedding Information in a Block Definition with Attributes」later in this chapter.

The following steps can be used to create a block definition from objects in your current drawing:

1. Draw the geometry that you want to use when defining the block definition in model space or paper space. The object properties used to create the geometry determine how those objects will look when the block definition is used to insert a block reference. I explain the impact of object property values in the sidebar「Assigning Object Properties By Layer, By Block, or By Object.」










Do one of the following: On the ribbon, click Insert tab Block Definition panel Create Block drop-down menu Create Block (Windows).

Click Draw menu Block Make (Mac OS).

At the command prompt, enter block and press Enter (Windows and Mac OS).

When the Block Definition (Windows) or Define Block (Mac OS) dialog box opens, enter a name for the block definition in the Name text box (see Figure 3.1). You can select the name of an existing block definition from the Name or Blocks drop-down list to redefine the geometry and base point of a block definition. I discuss redefining blocks in the section「Editing a Block Definition」later in this chapter.

In the Base Point section, click Pick Point and specify a coordinate point in the drawing, or enter coordinate values directly into the text boxes. I recommend using object snaps to specify a point on one of the geometric objects that is part of the block.

In the Objects/Source Objects section, click Select Objects and select the objects that will make up the block definition. Press Enter to complete object selection and return to the dialog box.

In the Objects/Source Objects section, choose one of the following: Retain/Retain Objects: When you click Retain/Retain Objects, the selected objects are not removed from the drawing when the block definition is created, nor are they replaced with a block reference.

Convert To Block: If you select Convert To Block, the selected objects are removed from the drawing and replaced by a block reference based on the new block definition.

Delete/Delete Objects: When Delete/Delete Objects is enabled, the selected objects are removed from the drawing and not replaced with a block reference based on the new block definition.

In the Behavior/Block Behavior section, choose any of the following options to control the behavior of the block references that are based on the block definition: Annotative: When Annotative is enabled, the block definition is designated as being annotative. Annotative block references are scaled based on the current annotation scale of the current viewport or model space (Model tab). I discussed annotative objects and annotation scaling in Chapter 2.

Match Block Orientation To Layout: When this option is enabled and the block reference is displayed in a viewport on a named layout, the orientation of the block reference changes to match that of the named layout. The Annotative check box needs to be enabled to use this option.

Scale Uniformly: When Scale Uniformly is enabled, the block reference is forced to be scaled equally across all axes. If the Annotative check box is enabled, this option is enabled and cannot be disabled.

Allow Exploding: When Allow Exploding is enabled, it allows the block reference that is inserted into a drawing to be exploded. Exploding a block reference removes it from the drawing and it is replaced with a copy of the geometry from the block definition. Attribute values are lost when you use the explode command, but they can be preserved if you are working on Windows by using the burst Express Tool.

In the Settings/Units section, choose one of these options: Block Unit: Specifies the units in which the block should be assigned. The unit value chosen affects the scale at which the block is inserted into a drawing. For example, if the block is defined using inches and it is inserted into a drawing that is set to use millimeters, the block is scaled automatically so that it is displayed at the correct size. The drawing units used to scale blocks when they are inserted is determined by the insunits system variable. The insunitsdefsource and insunitsdefsource system variables also impact how blocks are scaled when inserted into a drawing when they are defined as Unitless.

Hyperlink (Windows only): Allows you to add a hyperlink to a block. When a block is inserted with a hyperlink, you can hold the Ctrl key and click the block to open the associated file, drawing view, or URL.

Optionally, in the Description section, enter a description that can provide some information about the block.

Optionally, click the Open In Block Editor check box to open the new block definition in the Block Editor. I discuss the Block Editor in the section「Using the Block Editor」later in this chapter.

Click OK (Windows) or Create Block (Mac OS).

Figure 3.1 Defining a block

Assigning Object Properties By Layer, By Block, or By Object

Layers and object properties play an important role in how the objects of a block definition appear when inserted as a block reference into model space or paper space. The general properties of an object in a block can be controlled using one of the following methods:

By Layer An object's properties are controlled by the layer the object is on. For an object to inherit a property value from a layer, the property must be set to ByLayer.

By Object An object's properties values can be set directly, and they are not affected by the layer the object is on or the properties of the inserted block reference.

By Block An object's properties are controlled by the block reference that is inserted into model space or paper space. For an object to inherit a property value from a block reference, the object's property must be set to ByBlock.

### 2. Editing a Block Definition

A block definition can be edited (or redefined, as you might hear some say), but the editing process is not as simple as just selecting an object and making changes to it. Since a block definition and its objects do not exist in model space or paper space, you need to do one of the following:

Create a block reference with the insert command in either model space or paper space, and then explode it with the explode command. Once it's exploded, you can modify the objects that were created by exploding the block reference and then use the block command to define the block definition again with the same name.

Open a block reference in the drawing area with the In-Place Reference Editor (refedit command). This allows you to add and modify the objects of the block definition and use the other objects in your drawing as reference objects.

Open a block definition in the Block Editor (bedit command). This provides a separate environment for creating and modifying geometry and custom dynamic properties, and for testing your block definition.

If the block definition was originally stored as a separate drawing, you can open that drawing, make changes to it, and then reinsert it into your drawing with the same name using the Insert/Insert Block dialog box (insert command). You can export a block to a separate drawing by using the Write Block dialog box (wblock command).

NOTE

When you edit or redefine the geometry of a block definition, all block references that use the block definition in the current drawing are updated to reflect the changes. If you want only a few block references to be different, you can use the Block Editor's bsaveas command to create a new block definition from an existing one, and then replace the block references that should be different.

Follow these steps to edit the geometry of a block definition without the In-Place Reference Editor or Block Editor:

Do one of the following: On the ribbon, click Insert tab Block panel Insert (Windows).

Click Insert menu Block (Mac OS).

At the command prompt, enter insert and press Enter (Windows and Mac OS).

When the Insert/Insert Block dialog box opens, select a block definition from the Name Or Blocks drop-down list. Check Explode/Explode Block, and then click OK or Insert. Make sure the rotation of the block reference is set to 0 and the scale of the block reference is set to 1 and scaled uniformly. For more information on the Insert/Insert Block dialog box, see the section「Inserting or Replacing a Block Reference」later in this chapter.

In the drawing area, modify the objects that were added as a result of exploding the block reference.

Use the block command to create a block definition with the same name. Make sure to select the name of the block definition you are updating from the Name Or Blocks drop-down list. Make sure that you assign the same base point as before, because the new value will impact all block references that use the block definition you are updating. Block units is also important for all future block references being inserted.

### 3. Using the Block Editor

The Block Editor (shown in Figure 3.2) allows you to create and modify the block definitions in the current drawing. You have a choice to open the Block Editor when you create a new block definition with the Block Definition (Windows) or Define Block (Mac OS) dialog box, or when you want to modify an existing block definition with the bedit command. The Block Editor makes the process of updating a block definition much easier than having to insert a block reference, then explode it, and finally define a block definition from the modified objects.

Figure 3.2 Block editing environment

When a block definition is open for editing in the Block Editor, you can perform the following tasks:

Add new, remove, and modify existing geometry and its properties

Manage attribute definitions

Add parameters and actions (Windows only)

Work with lookup tables and visibility states (Windows only)

While the Block Editor is open, there are some commands that you can't use. Some of those are block, refedit, and plot. When a command can't be used, the message ** <name> command not allowed in block editor. ** is displayed in the command-line history.

### 3. Components of the Block Editor

The Block Editor is similar to the normal drawing window, but it offers several additional tools that are specific to working with objects in a block definition. When the Block Editor is active, the Block Editor tab (see Figure 3.3, top) is displayed on the ribbon in AutoCAD on Windows and the Block Editor visor (see Figure 3.3, bottom) is displayed in AutoCAD for Mac.

Figure 3.3 Tools available for modifying the objects and behavior of a block definition

The following describes the tools on the Block Editor tab in AutoCAD on Windows:

Open/Save These tools allow you to open a block definition in the Block Editor (bedit command), save changes to the open block definition (bsave command), create a new block definition (bsaveas command), or test a block definition (btestblock command).

Geometric These tools allow you to create and modify geometric constraints and control the display of the constraint bars for the geometric constraints placed in the block definition (constraintbar command). Geometric constraints can be placed automatically with the AutoConstrain tool (autoconstrain command) as you create new geometry or manually as needed (geomconstraint command). The settings used for the AutoConstrain tool can be adjusted with the Constraint Settings dialog box (constraintsettings command).

Dimensional These tools allow you to create and modify constraint parameters. Constraint parameters can be applied to selected objects, or you can convert a dimensional constraint to a parameter (bcparamter command). The display of dimensional constraints can be controlled with the Constraint Settings dialog box (constraintsettings command). You can also create a Block Properties table (btable command) that can be used to define variations of a block reference.

Manage These tools are used to delete (delconstraint command) and control the display of constraints (bconstatusmode system variable), as well as convert geometry to construction objects (bconstruction command). You can also display the Parameters Manager (parameters command) and the Block Authoring palette (bauthorpalette command), in addition to controlling the display settings of the Block Editor (bsettings command).

Action Parameters The tools here allow you to create actions (bactiontool command) and parameters (bparameter command) to define a dynamic block. You can use the Attribute Definition button to display the Attribute Definition dialog box to add an attribute definition to the block definition (attdef command). I discuss actions and parameters in the section「Adding Dynamic Properties to a Block Definition」and attributes in the section「Embedding Information in a Block Definition with Attributes」later in this chapter.

Visibility These tools allow you to create and manage visibility states (bvstate command), and control the visibility of the geometry of a visibility state (the bvhide and bvshow commands and the bvmode system variable). I discuss visibility states in the section「Adding Dynamic Properties to a Block Definition」later in the chapter.

Close The Close Block Editor button closes the Block Editor and prompts you to save or discard the changes made to the block definition (bclose command). The following describes the tools on the Block Editor visor in AutoCAD on Mac OS:

Block Definition Name This tool displays the name of the block definition open in the Block Editor.

Attribute Definition The Attribute Definition tool displays the Attribute Definition dialog box and allows you to add a new attribute definition to the block definition (attdef command). I discuss attributes in detail in the section「Embedding Information in a Block Definition with Attributes」later in this chapter.

Save Click this button to save the changes made to the block definition (bsave command).

Save New Click Save New to open the Save Block Definition As dialog box and create a new block definition based on the one open in the Block Editor (bsaveas command). Enter a new name for the block and click Save Block. If you want to export the new block definition to a new drawing file, check Save Block As Drawing before clicking Save Block.

Close This button closes the Block Editor and prompts you to save or discard the changes made to the block definition (bclose command).

### 4. Creating or Editing a Block Definition

The Block Editor simplifies the creation and editing process of a block definition, but it does not allow you to use other geometry in your drawing as reference objects. If you are using AutoCAD on Windows, the Block Editor is the only way to add actions and parameters to a block definition. I discuss actions and parameters for block definitions in the section「Adding Dynamic Properties to a Block Definition」later in this chapter.

You can use the following steps to create a new block definition or edit an existing one with the Block Editor:

Do one of the following: On the ribbon, click Insert tab Block Definition panel Block Editor (Windows).

Click Tools menu Block Editor (Mac OS).

At the command prompt, enter bedit and press Enter (Windows and Mac OS).

In the Edit Block Definition dialog box, do one of the following: Create a new block definition: Enter a name in the Block To Create Or Edit text box in the upper-left corner.

Edit an existing block definition: Select a name from the Block Definition list or click <Current Drawing> to edit the objects in model space in the Block Editor.

Click OK or Edit Block to open the block definition in the Block Editor.

In the Block Editor, add or modify the geometry of the block definition as needed.

Do one of the following: On the ribbon, click Block Editor tab Close panel Close Block Editor (Windows).

On the Block Editor visor, click Close (Mac OS).

At the command prompt, enter bclose and press Enter (Windows and Mac OS).

In the Block - Changes Not Saved message box, click Save The Changes To <definition name>.

NOTE

The blockeditlock system variable controls whether you can use the Block Editor to edit block definitions. A value of 0 disables the use of the Block Editor.

## 02. Using and Managing Block Definitions

After a block definition has been created in a drawing, you can place a block reference for that definition in model space or paper space with the insert command. In addition to inserting block references, you can replace a block reference with a different block definition, rename and purge unused block definitions, import a drawing file as a block definition, or export a block definition to a drawing file.

NOTE

The insert command does not create a copy of the objects contained in the block definition before placing them in model space or paper space. This can be seen by making a change to a block definition; all block references that point to a particular block definition are updated with the changes made to the block definition.

Inserting or Replacing a Block Reference

You can insert a drawing file or block definition in the current drawing as a block reference using the Insert (Windows) or Insert Block (Mac OS) dialog box, which is displayed with the insert command. In addition to the insert command, you can insert block references using the following:

The AutoCAD DesignCenter palette on Windows (adcenter command)

The Content Explorer palette on Windows (contentexplorer command)

The Tool Palettes window on Windows (toolpalettes command)

Drag and drop, which you can use to move a drawing from Windows Explorer or File Explorer onto a drawing window when using AutoCAD on Windows

The Content window on Mac OS (content command)

The -insert command, which you can use to insert commands from the command prompt using scripts, menu or action macros, and even AutoLISP® programming language

Follow these steps to insert a block reference into a drawing with the insert command:

Do one of the following: On the ribbon, click Insert tab Block panel Insert (Windows).

Click Insert menu Block (Mac OS).

At the command prompt, enter insert and press Enter (Windows and Mac OS).

In the Insert or Insert Block dialog box (see Figure 3.4), do one of the following: Insert a drawing file: Click Browse. When the Select Drawing File dialog box opens, browse to and select the drawing file that you want to insert. Click Open.

Insert a block definition: From the Name (Windows) or Blocks (Mac OS) drop-down list, select the block definition you want to insert.

If you are using AutoCAD for Mac, click the disclosure triangle to the left of Show Insertion Options.

In the Insertion Point, Scale, or Rotation section, enter the values you want to use when inserting the block reference, or choose Specify On-Screen for the values you want to provide at the command prompt when inserting the block reference.

Optionally, enable any of the following: Explode/Explode Block: Explodes the block reference into its individual objects once it is inserted into the drawing.

Uniform Scale/Scale Uniformly: Sets the Y and Z scale factors to be the same as the X scale factor

Locate Using Geographic Data (Windows only): Inserts the selected drawing and locates it based on the geographic data in the current drawing and in the drawing file you are inserting

Click OK (Windows) or Insert (Mac OS) to insert the block reference. Specify the insertion point, scale, or rotation in the drawing area based on the options you chose in step 4.

NOTE

As a block reference is being inserted (dragged onscreen) into the drawing area, you can use the Properties palette in AutoCAD on Windows to control the block reference's properties, attribute values, and custom dynamic properties.

Figure 3.4 Inserting a block definition

After a block reference is inserted, at times you will want to replace one or all block references with another block. You can use one of the following methods to replace one or all block references in a drawing:

Replace a Block Definition with Another You can replace a block definition with another by using either the -insert command or the Replace Block Express Tool (blockreplace command) in AutoCAD on Windows. For more information on the Replace Block Express Tool, look up「blockreplace」in the product's help.

The following example explains how to replace a block definition with the geometry from a drawing file using the -insert command:

At the command prompt, enter -insert and press Enter.

At the Enter block name or [?]: prompt, enter blockdef1=blockdef2 and press Enter. Replace blockdef1 with the name of the block definition you want to replace and blockdef2 with the name of the block definition you want to replace it with.

At the Block「<blockdef1>」already exists. Redefine it? [Yes/No] <N>: prompt, enter y and press Enter.

At the Specify insertion point: prompt, press Esc to exit the -insert command.

NOTE

You can export a block definition from a drawing to a drawing file using the Write Block dialog box (wblock command). I discuss the wblock command later in this chapter in the section「Importing or Exporting a Block Definition.」

Replace an Individual Block Reference with Another The -insert and blockreplace commands allow you to replace a block definition with another, but not to replace a block reference with another block reference. You can use one of the available programming languages to create a basic routine that allows you to do that. The following AutoLISP code demonstrates a basic routine for swapping one block reference for another. (defun c:ReplaceBlk ( / ed newBlk) (setq ed (entget (car (entsel "\nSelect block to replace: ")))) (if (setq newBlk (getstring "\nEnter name of new block to use: ")) (progn (setq ed (subst (cons 2 newBlk) (assoc 2 ed) ed )) (entmod ed) ) ) )

Renaming and Purging Unused Block Definitions

Block definitions can be renamed and purged from a drawing just like other nongraphical objects stored in a drawing. As you'll recall, you can rename a block definition using the rename command. I discussed renaming nongraphical objects in Chapter 2. Block definitions that are no longer needed in a drawing can be removed using the purge command. Before removing a block definition, you might want to consider using the wblock command to export the block definition to a drawing file just in case you need it later and it does not exist elsewhere. I discuss exporting a block definition to a drawing file in the next section, and you learned about purging nongraphical objects in Chapter 2.

Importing or Exporting a Block Definition

You can import a drawing file into a drawing as a block definition by using the Insert (Windows) or Insert Block (Mac OS) dialog box (insert command), or if you are using AutoCAD on Windows, you can import a block definition from another drawing using DesignCenter (adCenter command), Content Explorer (contentexplorer command), or the Tool Palettes window (toolpalettes command). In AutoCAD for Mac, you can use the insert command or Content palette (content command). After selecting a drawing file or block definition to insert with one of the previously mentioned commands, press Esc when prompted for an insertion point. The block definition is imported, but the block reference is not inserted into model space or paper space.

If you defined a block definition in a drawing, you can use the Write Block dialog box (wblock command) to save the block definition to a separate drawing file. The new drawing file can then be used to import a block definition into another drawing. In addition to exporting a block definition, you can save all the objects in model space or select which objects to save to a drawing file when using the wblock command.

## 03. Embedding Information in a Block Definition with Attributes

Block definitions can contain attributes that allow you to add custom information to a block reference when it is inserted into a drawing. Using attributes allows you to use a single block definition but represent several items that might be the same size and a different color or style. A common use for attributes is to store project, date, and revision information in a title block, or a model number and description with a window or bolt block. After you insert a block reference with attributes, you can extract the values stored in the attributes to an external file or table object.

There are two types of attributes in a drawing. Those in a block definition are known as attribute definitions. The other type of attribute is known as an attribute reference, which can be found attached to a block reference that has been inserted into a drawing whose block definition contains attribute definitions.

Adding an Attribute Definition

You can create attribute definitions by using the Attribute Definition dialog box (attdef command). You can add an attribute definition to model space or paper space before you define your block definition by using the Block Definition (Windows) or Define Block (Mac OS) dialog box (block command), or after a block definition is created in the Block Editor (bedit command).

The following steps explain how to add an attribute definition, whether you are working in the drawing window or the Block Editor:

Do one of the following: On the ribbon, click Insert tab Block Definition panel Define Attributes (Windows). When the Block Editor is active, on the ribbon, click Block Editor tab Action Parameters panel Attribute Definition.

Click Insert menu Block Define Attributes (Mac OS). When the Block Editor is active, on the Block Editor visor, click Attribute Definition.

At the command prompt, enter attdef and press Enter (Windows and Mac OS).

In the Attribute Definition dialog box (see Figure 3.5), in the Attribute section's Tag text box, enter a text string that doesn't contain any spaces. The Tag value is shown in the drawing and the Block Editor when modifying a block definition, and it is the internal identifier of the attribute within the block. You should use a different tag value for each attribute in a block definition so that you can accurately extract the attribute values you might be interested in later.

Optionally, in the Attribute section enter a text string in the Prompt and Default text boxes. The text string you enter in the Prompt text box is displayed after you insert a block reference with the insert command or while you are editing the attribute values of a block reference. The text string in the Default text box is the default value that an attribute is assigned when a block reference is inserted. You can also use the Insert Field button to add a field as the attribute definition's default value instead of a static text string.

In the Mode section, set one or more options that define how the attribute reference should behave when inserting the block reference. On Mac OS, click the disclosure triangle next to Show Advanced Options to see the Mode section. The following explains what each mode does: Invisible: The attribute is invisible when a block reference is inserted into the drawing. All invisible attributes can be displayed by setting the attmode system variable to a value of 2.

Constant: The text string entered in the Value text box of the attribute is fixed and is the same for all block references that are inserted based on the block definition that contains this type of attribute.

Verify: You are prompted to verify the value of the attribute when the block reference is inserted.

Preset: The Default value is assigned to the attribute when the block reference is inserted, and you are not prompted to change the value. You can change the value using the attedit or eattedit command or the Properties palette (Windows) or Properties Inspector (Mac OS).

Lock Position: Restricts the attribute from being moved using grips. This mode is helpful if you want to control the placement of an attribute with parameters and actions in a dynamic block.

Multiple Lines: The attribute supports multiple lines of text similar to a multiline text (MText) object, instead of the default single line of text. You can control whether multiline attributes can be created or which Text Formatting toolbar is displayed by using the attmulti and attipe system variables.

NOTE

While AutoCAD remains open, the Mode options you choose are stored as a sum of different bitcode values in the aflags system variable. The value of aflags is used as the default option for the next attribute definition you create.

In the Insertion Point section, choose Specify On-Screen to specify a point in the drawing area after you create the attribute definition or enter a coordinate value. After a block reference with an attribute is inserted, you can use grips or the -attedit command to move an attribute as long as it is not set to the Invisible mode.

In the Text Settings section, change any of the following: Justification: The Justification setting controls how the text string assigned to the Value property of an attribute appears in relation to the attribute's insertion point.

Text Style: This setting specifies the text style that should be used for the attribute. I discussed creating text styles in Chapter 2.

Annotative: This setting controls whether the attribute is annotative. If it's enabled and the block is annotative, the attribute matches the orientation of the block. I discussed annotative objects and styles in Chapter 2.

Text Height: This setting specifies the height at which the attribute should be created. The height of the attribute scales up or down when it and the block definition it is in are annotative.

Rotation/Text Rotation: Using this setting, you can specify the rotation angle at which the attribute appears when the block reference is inserted into a drawing. After a block reference with an attribute is inserted, you can use the -attedit command to rotate an attribute as long as it is not set to the Invisible mode.

Boundary Width/Multiline Text Width: When the Multiple Lines mode is enabled, you can specify the width of the boundary box for the multiline attribute object. Additional lines of text are created vertically based on the length of the text string assigned to the attribute's Value property.

Optionally in AutoCAD on Windows, click Align Below Previous Attribute Definition if you have created another attribute definition and want to align the new and previous attribute definitions vertically.

Click OK (Windows) or Save (Mac OS) to create the attribute definition. Specify the insertion point in the drawing area based on the option you chose in step 5.

Repeat steps 1–8 for each attribute definition you want to add to a block.

Create a block definition or save the changes in the Block Editor as I discussed in the sections「Defining and Editing a Block Definition」and「Creating or Editing a Block Definition」earlier in this chapter.

NOTE

When you are selecting objects to define a block definition, the order in which you select your attribute definitions affects how AutoCAD prompts for each attribute value. I recommend selecting all your graphical objects first, and then selecting each attribute definition in the order you want its value to be prompted for. Prompting order can have an impact on your block's usage with scripts, menu macros, and other custom programs. You can also change the prompting order of the attributes in a block by using the Block Attribute Manager (battman command).

Figure 3.5 Defining an attribute definition

Inserting a Block Definition with Attributes

Inserting a block reference with attributes follows the same process as inserting a block reference without attributes, with one difference: you might need to accept the default values or enter a new value for the attributes being added after the block reference has been placed in a drawing. When you insert a block reference with attributes, the Edit Attributes dialog box (see Figure 3.6) is displayed and allows you to provide new values for the attribute references in the block reference. Attributes that have Constant mode enabled are not displayed in the dialog box.

Figure 3.6 You can edit attribute values after inserting a block reference.

The display of the Edit Attributes dialog box and prompting for attribute values is controlled with the attdia and attreq system variables. The attdia system variable controls the display of the Edit Attributes dialog box. If the dialog box does not appear after you insert a block, you are instead prompted to enter attribute values at the command prompt. The attreq system variable enables or disables the prompt for attribute values after you insert a block reference.

Editing Attribute Values and Properties in a Block Reference

After a block reference with attributes has been inserted into a drawing, you can change the value assigned to an attribute using one of the following methods:

Edit Attributes Dialog Box The attedit or ddedit commands allow you to edit the values of the attributes in a block reference with the Edit Attributes dialog box.

Properties Palette or Properties Inspector You can modify an attribute's value by selecting a block reference and then displaying the Properties palette (Windows) or Properties Inspector (Mac OS). The attributes and their editable values are listed in the Attributes section. You can display the Properties palette or Properties Inspector by using the properties command.

Enhanced Attribute Editor The values and properties of an attribute in a block reference can be modified using the Enhanced Attribute Editor (eattedit command). You can also double-click a block reference with attributes to open the Enhanced Attribute Editor.

-attedit Command If you plan to write scripts, action macros, or custom programs that edit the values and properties of the attributes in a block reference, you can use the -attedit command. This command allows you to perform a global find and replace on a text string in an attribute value and edit the properties of an attribute.

Redefining Block Definitions with Attribute Definitions

Just as it is not uncommon to make changes to the way a block looks over time, you might decide to update the attribute definitions in a block definition. There are a few things you need to consider when adding, modifying, or removing attribute definitions from a block definition. Although it is true that the geometry of a block definition is the same for each and every block reference that uses a specific block definition, the same is not true for attribute definitions and references unless all your attribute definitions are defined as Constant.

Some blocks based on the same block definition may not have all the attributes defined in that block definition. This situation often occurs when attributes in a block definition are updated but the block references themselves are not synchronized to include the same changes, or when a custom application has decided not to add an attribute reference to a block reference for some reason.

After you update the attributes of a block definition, you want to run the attredef or attsync command or use the Block Attribute Manager (battman command). These utilities synchronize the attribute definitions in a block definition with the attribute references in each of the block references that have been inserted in a drawing by adding and removing attributes as needed. Those attributes in the block reference that are contained in the block definition are not changed; their current values are retained.

The Block Attribute Manager (battman command) can also be helpful in updating the properties and prompting order of the attribute definitions in a block definition, as well as editing and removing attribute definitions. These three commands can also affect any formatting or property changes made to attributes in a block reference with the attedit and eattedit commands. If you need to just change the prompting order of the attributes within a block definition, you can use the battorder command while the block definition is open in the Block Editor (bedit command).

Using Fields with Attributes

Fields allow you to place information in your drawing based on a graphical or nongraphical drawing object, the current value of a system variable, a property of a sheet set or project, the current date or the date when the current drawing was created, and much more. Fields can be used to construct the string value of a single-line or multiline text object, which can be a standalone object or in another object such as a table or dimension. In addition to text objects, attributes can use fields to define the value that they hold.

Use the following steps to define an attribute definition with a field:

Create an attribute definition as explained in the earlier section「Adding an Attribute Definition.」

Instead of adding a static default value to the Default text box, click Insert Field (located to the right of the text box).

In the Field (Windows) or Insert Field (Mac OS) dialog box, select a Field Name from the leftmost column.

Select any options for the selected field.

Click OK (Windows) or Choose (Mac OS) to add the field definition to the Default text box. If you need to make a change to the field, double-click the shaded text in the text box. Click before or after the field definition to add some static text as needed.

Finish creating the attribute as you normally would.

When you insert a block reference with an attribute, you can specify a field value in the Edit Attributes dialog box by right-clicking in the text box to the right of the attribute prompt and clicking Insert Field. You can edit an existing field by double-clicking the shaded text in the text box, or you can convert it to static text by selecting and right-clicking the shaded text that represents the field and clicking Convert Field To Text.

BlockPlaceholder Field Type

In AutoCAD on Windows while the Block Editor is active, you have access to an additional field type: BlockPlaceholder. The BlockPlaceholder field type allows you to access the properties of the block reference when it is placed in a drawing. For example, you could list the name of the block as part of a description in an attribute field or even access the current value of one of the parameters used for a custom dynamic property.

## 04. Adding Dynamic Properties to a Block Definition

Dynamic properties when added to a block definition allow you to rotate, move, stretch, and perform other actions on the objects within a block reference. A block definition that contains dynamic properties is known as a dynamic block. Parameters and actions are used to implement dynamic properties. You can only add dynamic properties to a block definition using the Block Editor in AutoCAD on Windows. Although you can't create or modify dynamic properties in AutoCAD for Mac OS, you can insert blocks that have these properties already implemented.

When a block with dynamic properties is inserted into a drawing, additional grips are displayed for the block reference when it is selected. These additional grips allow you to interactively change the values of the custom actions rather than selecting values from a predefined list. Figure 3.7 shows a block reference selected in the drawing and a linear distance being modified with grips.

Figure 3.7 Modifying a block's dynamic properties with grips (left: in the drawing window; right: in the Block Editor)

Using Parameters to Modify Geometry in a Block Definition (Windows Only)

Parameters in a dynamic block define how geometry within a block reference can be modified. There are 10 different parameters that you can add to a block definition, and most of them must be paired with an action before they can modify the objects in a block reference. You create parameters by using the bparameter command, and the command can only be used when the Block Editor is active. While the bparameter command works from the command prompt, you can modify many of the properties of a parameter by using grips and the Properties palette (properties command).

The following lists the available parameters along with the actions they can be paired with:

Point The Point parameter defines a point in the block that can be used to move or stretch the geometry associated with that coordinate value. Actions: Move and Stretch.

Linear This parameter is used to modify geometry along a linear path. Actions: Array, Move, Scale, and Stretch.

Polar The Polar parameter is used to modify geometry along a polar path. Actions: Array, Move, Scale, Stretch, and Polar Stretch.

XY Use the XY parameter to modify geometry in both a horizontal and vertical direction. Actions: Array, Move, Scale, and Stretch.

Rotation This parameter rotates geometry around a given point. Action: Rotation.

Alignment Use this parameter to align a block perpendicular or tangent to the objects it is inserted near. Action: No action required.

Flip The Flip parameter mirrors the block reference and all objects in it. Action: Flip.

Visibility When you need to control the use of visibility states for the geometry within a block reference, add the Visibility parameter. Action: No action required.

Lookup The Lookup parameter creates a mapping table between a list of values and custom properties. Action: Lookup.

Base Point The Base Point parameter redefines the block definition's insertion point. Action: No action required.

Adding a Parameter to a Block Definition

The following example explains how to add a Linear parameter to a block definition:

Create or open an existing block definition, as I discussed in the「Creating or Editing a Block Definition」section earlier in this chapter.

On the Block Authoring Palettes window, click the Parameters tab, and then click Linear. If the Block Authoring Palettes window is not displayed, on the ribbon click Block Editor tab Manage panel Authoring Palettes.

At the Specify start point or [Name/Label/Chain/Description/Base/Palette/Value set]: prompt, specify a point in the drawing. Typically, this point is located using an object snap, such as an Endpoint, Intersection, or Center.

At the Specify endpoint: prompt, specify the endpoint for the parameter. Typically, this point is located using an object snap, such as an Endpoint, Intersection, or Center.

At the Specify label location: prompt, specify a location for the label for the parameter. You should notice a small yellow icon displayed near the parameter; this indicates that the parameter requires an action. The label is displayed in the Block Editor, Properties palette (Windows), and Properties Inspector (Mac OS) when you are modifying the block definition or a block reference. The label is also used when you want to reference the custom property with a field.

In the drawing window, select the parameter that you just placed. In the Properties palette, change the properties in the Property Labels, Geometry, Value Set, and Misc areas to control the behavior of the parameter. If the Properties palette is not displayed, select the parameter, right-click in the drawing window, and click Properties.

On the ribbon, click Block Editor tab Open/Save panel Save Block.

If the Block - Save Parameter Changes task dialog box is displayed, click Save The Changes.

Associating an Action with a Parameter (Windows Only)

Actions define which objects are controlled by a parameter and how those objects should be modified. You must add a parameter to a block definition before you can assign an action. There are eight different actions that you can pair with seven different parameters; some actions only work with one type of parameter whereas other actions can be used with several types of parameters. Refer to the earlier section「Adding Parameters to a Block Definition (Windows Only)」for information about which actions can be used with each parameter.

Actions are created using the bactiontool command; the command can only be used when the Block Editor is active. While the bactiontool command works from the command prompt, you can modify the properties of an action by using grips or the Properties palette (properties command).

Adding an Action to a Parameter in a Block Definition

The following steps explain how to add a Stretch action to a Linear parameter in a block definition:

Open an existing block definition that contains a Linear parameter. I explained how to add a Linear parameter to a block definition in the section「Adding Parameters to a Block Definition (Windows Only)」earlier in this chapter.

In the Block Authoring Palettes window, click the Actions tab and then click Scale. (If the Block Authoring Palettes window is not displayed, on the ribbon click Block Editor tab Manage panel Authoring Palettes.)

At the Select parameter: prompt, select the linear parameter.

At the Specify parameter point to associate with action or enter [sTart point/Second point] <Second>: prompt, select the grip point on the Linear parameter that should be associated with the Stretch action.

At the Specify first corner of stretch frame or [CPolygon]: prompt, specify the first corner of the crossing window for the Stretch action.

At the Specify opposite corner: prompt, specify the second corner of the crossing window for the Stretch action.

At the prompt Specify objects to stretch Select objects:

specify the objects inside or that cross the Stretch frame you want to stretch or move. Stretch behavior is just like that of the stretch command. Press Enter to end object selection.

In the drawing window, select the action that you just added.

On the Properties palette, change the properties in the Stretch Frame, Overrides, and Misc areas to control the behavior of the action. (If the Properties palette is not displayed, select the parameter, right-click in the drawing window, and click Properties.)

On the ribbon, click Block Editor tab Open/Save panel Test Block.

In the drawing window, select the block and click the grip on the Linear parameter. Notice that you can stretch objects that cross the Stretch frame and move those that are completely inside the frame.

On the ribbon, click <current> tab Close panel Close Test Block Window to return to the Block Editor.

You can remove an action by right-clicking over its icon that is displayed on the action bar in the drawing and clicking Delete. The objects associated with an action can also be updated by using the options under the Action Selection Set submenu that is displayed when you right-click an action's icon on the action bar. An action's selection set can also be updated from the Misc area of the Properties palette. If an action's icon is not displayed in the drawing area, make sure the bactionbarmode system variable is set to 1. You might also need to use the bactionbar command and select the parameter that contains the action you want to modify.

NOTE

The Parameter Sets tab of the Block Authoring Palettes window contains commonly used parameter and action groupings. These tools allow you to place a parameter and an action as a single operation instead of starting multiple commands.

Creating a Lookup Table (Windows Only)

Lookup tables allow you to map the values of one or more parameters to a more meaningful label. For example, you might have a listing of bolt-head sizes or lengths, or maybe a number of different sizes for doors and windows that you use in your drawings. Choosing an item from a lookup list sets the parameter values accordingly based on the value mappings instead of you having to specify multiple parameter values individually.

Creating a lookup table requires you to have one or more parameters already defined in your block definition, and then a Lookup parameter and action must be added to a block definition with the Block Editor. You add items to a lookup table using the Property Lookup Table dialog box (see Figure 3.8). After a block reference is inserted that contains a lookup table, you can choose an item from the Lookup grip, or use the drop-down list that is displayed in the Custom area of the Properties palette (Windows) or Properties Inspector (Mac OS) when a block reference is selected.

Figure 3.8 Defining a lookup table for a dynamic block

Adding a Lookup Table to a Block Definition

You can use these steps to create a lookup table and map parameter values to textual values for a block definition:

Open an existing block definition that contains one or more parameters. I explained how to add a Linear parameter to a block definition in the section「Adding Parameters to a Block Definition (Windows Only)」earlier in this chapter.

In the Block Authoring Palettes window, click the Parameter Sets tab, and scroll down to and click Lookup Set. (If the Block Authoring Palettes window is not displayed, on the ribbon click Block Editor tab Manage panel Authoring Palettes.)

At the Specify parameter location or [Name/Label/Description/Palette]: prompt, specify a point on or near the geometry of the block. Make sure not to place the parameter at the origin of the block or in the same location as another parameter.

Right-click over the new Lookup action icon and click Display Lookup Table to display the Property Lookup Table dialog box (blookuptable command).

In the Property Lookup Table dialog box, click Add Properties.

In the Add Parameter Properties dialog box, select the parameter you want to use with the lookup table and click OK. The Property section at the bottom of the dialog box filters out the parameters that are available to be added or that are already in use with the lookup table.

In the Input Properties area, in the column of the parameter you just added, enter the parameter value that the lookup item should be mapped to. For example, if the parameter represents the width of a door or window, you would enter the width for that item, such as 32.000 or 36.000.

In the the Lookup Properties area, in the column of the lookup parameter you are working with, enter a textual value for each parameter value you entered. For example, if 32.000 and 36.000 were entered for door widths you might enter the textual strings 32″W Door and 36″W Door.

Click OK to return to the Block Editor.

On the ribbon, click Block Editor tab Open/Save panel Test Block.

In the drawing area, select the block and click the grip for the Lookup parameter. Notice the values that are listed. Select one or more of the options from the list to make sure your parameters are being updated correctly.

On the ribbon, click <current> tab Close panel Close Test Block Window to return to the Block Editor.

Defining Visibility States (Windows Only)

The geometry of a block definition, as you have previously read, can be resized, rotated, stretched, flipped, arrayed, and moved using parameters and actions; visibility states do not modify the objects in a block reference, but rather control which objects are displayed based on which state is current. For example, you could have a single block definition with multiple visibility states that allow you to display an open or closed valve based on which option you choose. You could also use visibility states to toggle the view of a bolt; plan and side views could be different visibility states of the same block.

Creating a visibility state requires you to add a Visibility parameter to a block definition with the Block Editor, and then you can modify which visibility states are available using the Visibility States dialog box (see Figure 3.9). A visibility state can be chosen from the Visibility grip of a block reference in a drawing, or you can select a value from the drop-down list that is displayed in the Custom area of the Properties palette when a block reference is selected.

Figure 3.9 Defining a lookup table for a dynamic block

The following steps explain how to add a Visibility parameter to a block definition and control the objects of a visibility state:

Create or open an existing block definition as I discussed in the「Creating or Editing a Block Definition」section earlier in this chapter.

On the Block Authoring Palettes window, click the Parameters tab and then click Visibility. (If the Block Authoring Palettes window is not displayed, on the ribbon click Block Editor tab Manage panel Authoring Palettes.)

At the Specify parameter location or [Name/Label/Description/Palette]: prompt, specify a point on or near the geometry of the block. Do not place the parameter at the origin of the block or in the same location as another parameter.

Double-click the new Visibility parameter to display the Visibility States dialog box (bvstate command).

In the Visibility States dialog box, click Rename to change the name of the default visibility state, VisibilityState0. Enter a new name for the visibility state.

Click New to display the New Visibility State dialog box.

In the New Visibility State dialog box, enter a name for the new visibility state in the Visibility State Name text box. Choose an option in the Visibility Options For New States section to control the default visibility of the objects in the block definition for the new visibility state. Click OK.

In the Visibility States dialog box, select the visibility state that you want to work with in the Block Editor. You can also click Move Up or Move Down after selecting a visibility state to control its order in the drop-down list on the Visibility panel of the Block Editor tab on the ribbon or in the Visibility parameter's list when a block reference is inserted.

On the ribbon, click Block Editor tab Visibility panel, and then click Make Visible (bvshow command) or Make Invisible (bvhide command) to control the visibility of the geometry in the block definition for the current visibility state. You can also click Visibility Mode (bvmode system variable) to show all hidden objects in the current visibility state so they can be shown using the Make Visible button.

On the ribbon, click Block Editor tab Open/Save panel Test Block.

In the drawing window, select the block and click the grip for the Visibility parameter. Notice the values that are listed. Select one or more of the options from the list to make sure the objects in each visibility state are being displayed correctly.

On the ribbon, click <current> tab Close panel Close Test Block Window to return to the Block Editor.

Inserting and Modifying Dynamic Blocks

Blocks with dynamic properties, or dynamic blocks, can be inserted using the same methods that are used to insert any other block definition into a drawing. All of the methods that I mentioned earlier, in the section「Inserting or Replacing a Block Reference,」can be used to insert a dynamic block.

I have a few favorite tricks that you might find helpful when inserting dynamic blocks:

In AutoCAD on Windows, when you use the insert command, you can control the custom properties of a dynamic block while it is being inserted with the Properties palette.

While the Block Editor is active and a dynamic block is being inserted, you can press Ctrl to cycle through grips of the parameters in the block and use those locations as possible insertion points of the block reference. The order in which the grips are cycled through is controlled by the Insertion Cycle Order dialog box (bcycleorder command).

In AutoCAD on Windows, if you add a dynamic block as a tool on a tool palette for the Tool Palettes window, you can control the default values used for the block's custom properties by right-clicking over the tool and clicking Properties. When the Tool Properties dialog box opens, you can set the desired values.

After a dynamic block has been inserted into a drawing, you commonly change its custom properties interactively using the grips that are displayed in the drawing area when the block reference is selected. If grips for the dynamic properties are not displayed, make sure the grips system variable is set to a value of 1 or 2. You can also use the Properties palette (Windows) or Properties Inspector (Mac OS) to change the custom properties of the dynamic block and the other general properties of the block reference.

If the dynamic block contains attribute definitions, they behave just like they do in standard blocks with attributes. The only differences might be that the placement of an attribute within a block reference might change based on the way the actions in the dynamic block were defined. You can use the Lock Position mode for an attribute definition to force that attribute to be ignored by any actions that might have the attribute definition in their selection set. The Default property value of attribute definitions might also be assigned a BlockPlaceholder field type; this allows the attribute to inherit the current value of any custom property within the block reference.

## 05. Extracting Properties and Values from a Block Reference

One of the benefits of using attributes with your blocks is that you can extract the information and then use it in your drawing or an external program. If all of your blocks contain attributes, you could generate a bill of materials on demand or even help prepare an estimate for a project. The attribute values and the properties of the blocks containing attributes can be extracted from a drawing using the Attribute Extraction dialog box (attext command) or Data Extraction Wizard (attext command) (in AutoCAD on Windows only) or by using the -attext command at the command prompt in AutoCAD both on Windows and Mac OS.

The following steps explain how to extract the attributes from a drawing using the Data Extraction Wizard in AutoCAD on Windows:

At the command prompt, enter dataextraction and press Enter.

If the Data Extraction - Unsaved Drawing message is displayed, click Save to continue.

On the Begin page in the Data Extraction Wizard, click Create A New Data Extraction to create a new data extraction (DXE) file. Click Next. When creating a new file, you can choose an existing DXE file to use as a template if you have one available. You can also use an existing DXE file instead of starting from scratch.

In the Save Data Extraction As dialog box, enter a name for the new DXE file in the File Name text box. Click Save.

In the Data Source section on the Define Data Source page, click Drawings/Sheet Set, and then click one of the following: Drawings/Sheet Set: This option allows you to extract attributes from the current drawing, one or more additional drawings, or all drawing files in a folder. Click Add Folder to add all drawings from a folder or click Add Drawings to select specific additional drawings.

Select Objects In The Current Drawing: This selection allows you to extract attributes from specific objects in the current drawing. Click the Select Objects In The Current Drawing button to select the objects in the drawing and press Enter to end object selection.

Click Settings to display the Data Extraction - Additional Settings dialog box. Specify the extraction options you want to use and click OK. Click Next.

In the Objects section on the Select Objects page, clear the check boxes for the objects you do not want to include in the extraction process. You can also use the options in the Display Options section to filter the Objects list to only blocks or non-block objects. Clear Display All Object Types, and check both Display Blocks Only and Display Blocks With Attributes to extract block attribute information only. Click Next.

In the Properties section on the Select Properties page, clear the check boxes for the properties you do not want to include in the extraction process. You can remove an entire category of properties by clearing check boxes in the Category Filter section. Click Next.

On the Refine Data page, choose how you want the information to be extracted. Right-click over the data grid for additional data-formatting options, the ability to sort and filter data in columns, and the ability to rename or hide columns. Click Full Preview to see a preview of the extracted attributes and the options specified. Close the preview window. Click Next.

On the Choose Output page, click Insert Data Extraction Table Into Drawing to create a table object that contains the extracted attributes or click Output Data To External File to export the extracted attributes to a file that can be imported into another application. If you click Output Data To External File, you can click the ellipsis […] button to specify a name and format for the external file. Click Next.

If you checked Insert Data Extraction Table Into Drawing, the Table Style page is displayed. Specify the table style you want to use and how the table should be structured. Click Next.

On the Finish page, click Finish. If you checked Insert Data Extraction Table Into Drawing, specify an insertion point for the table. If you checked Output Data To External File, the external file is created.

NOTE

After you place a table using the Data Extraction Wizard, a Data Link icon that looks like two chain links appears in the application's status-bar tray. Right-click the icon or the table in the drawing, and click Update All Data Links to ensure the information displayed in the table is up to date.

If you are using AutoCAD for Mac, you can extract attribute values only with the -attext command; the command is also available in AutoCAD on Windows. The -attext command allows you to extract attribute values to an external file, which can then be imported into any application that can read data from a comma- or space-delimited file. It is also possible to use an AutoLISP program to generate a table object and populate it with the exported attribute information. You first need to create an attribute-extraction template, which is a TXT file that defines the data structure to be extracted.

Each line in an attribute-extraction template file must follow one of these syntaxes:

<Block Property Name or Attribute Tag> Nwwwddd <Block Property Name or Attribute Tag> Cwww000

The following explains the syntax used in an attribute-extraction template file:

<Block Property Name or Attribute Tag> This variable specifies the name of the block property or attribute tag you want to extract information from in your drawing. If a block does not contain the attribute tag specified, no error is generated and AutoCAD continues to look for blocks that have attributes that match those defined in the template.

N Use N to specify that the extracted value should be formatted as a numeric value.

C Use C to specify that the extracted value should be formatted as a character string value.

www Replace the www variable with a fixed length (number of characters) for the extracted value. Add 000 (three zeros) after the fixed length value. 000 doesn't impact how attribute values are extracted or formatted, but does affect how the attribute-extraction template file is parsed. Not including 000 could result in unexpected problems.

ddd Replace the ddd variable with the number of decimal places to use for extracted numeric values. The attribute can't contain non-numeric values, such as quotation marks. If an attribute value is not numeric, the message ** Bad numeric value for field <name>, record n is displayed in the command-line window.

Table 3.1 lists the block properties that can be used in an attribute-extraction template and describes each.

Table 3.1 Block properties available for use in an attribute-extraction template

Block Property Description

BL:NAME Name of the block reference

BL:LEVEL Nesting level of the block reference

BL:X, BL:Y, and BL:Z X, Y, and Z coordinate values of the block reference

BL:NUMBER Counter for the block reference

BL:HANDLE Handle for the block reference

BL:LAYER Layer the block reference is placed on

BL:ORIENT Rotation of the block reference

BL:XSCALE, BL:YSCALE, and BL:ZSCALE X, Y, and Z scale-factor values of the block reference

BL:XEXTRUDE, BL:YEXTRUDE, and BL:ZEXTRUDE X, Y, and Z extrusion-direction values of the block reference

The following steps explain how to define an attribute-extraction template:

In the Mac OS Finder, click Go Applications. In the Finder window, double-click TextEdit.

In TextEdit, click TextEdit Preferences. In the Preferences dialog box, on the New Document tab click Plain Text and then close the dialog box.

Click File New to create a plain ASCII text file.

Click File Save and enter a name for the file in the Save As text box. Specify a location for the file and click Save. Keep the file extension as .txt.

In the TextEdit window, enter the data-structure elements for the attribute-extraction template. For example, the following extracts the name of each block reference and the attribute tags WIDTH and DESCRIPTION: BL:NAME C015000 WIDTH N010000 DESCRIPTION C050000

Click File Save to save the changes to the attribute-extraction template.

NOTE

If you are using AutoCAD on Windows, you can use Notepad instead of TextEdit to create an attribute-extraction template.

The following steps explain how to extract attribute values using an attribute extraction template and the -attext command:

In AutoCAD, open the drawing that contains the blocks and attribute values you want to extract.

At the command prompt, enter -attext and press Enter.

At the Enter extraction type or enable object selection [Cdf/Sdf/Dxf/Objects] <C>: prompt, enter c and press Enter.

In the Select Template File dialog box, browse to and select the attribute-extraction template you want to use. Click Open.

In the Create Extract File dialog box, enter a name and specify a location for the file. Click Save.

In Finder, browse to and open the file created in the previous step. The following shows what some of the extracted data might look like for a drawing that contains a block named RDESK: 'RDESK', 30, 'Rectangular Desk with Beveled Edging' 'RDESK', 24, 'Rectangular Desk with Beveled Edging' 'RDESK', 24, 'Rectangular Desk with Beveled Edging' 'RDESK', 30, 'Rectangular Desk with Beveled Edging'



