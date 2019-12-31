# Chapter 17 Creating and Modifying Nongraphical Objects

Nongraphical objects represent the block definitions, named styles, and other objects that are stored in a drawing but aren't present in model space or one of the named layouts. These objects can and typically do affect the display of graphical objects placed in model space or a named layout, though. While model space and named layouts are typically not thought of as nongraphical objects, they are. Model space is a special block definition, whereas a layout is an object that is based on a plot configuration—commonly called a page setup—with a reference to a block definition.

A drawing file can contain two types of nongraphical objects: symbol tables and named dictionaries. Symbol tables represent the original named objects that were available in the AutoCAD® R12 release and earlier ones. Support for named dictionaries was added with AutoCAD R13 to handle new and custom objects without the need for a new drawing file format. In this chapter, you will learn to create, manage, and use symbol table and dictionary entries.

Working with Symbol Tables

Symbol tables are the oldest form of nongraphical objects used in drawing files and have been unchanged since AutoCAD R12. Although the features that use symbol tables have changed since AutoCAD R12, the additional information that those features use in later releases is attached as either XData or an extension dictionary on an entry or the symbol table.

The Hidden Value of Nongraphical Objects

Have you opened a drawing from a client to find what seems like a spaghetti mess of layers, linetypes, and text styles that just don't work well with your standards? Maybe the Standard text style in the client's drawings uses a fixed height and different font than your company uses, which would affect the way your blocks and annotation might look like in the drawing. Using the AutoLIS® programming language, you can create or change nongraphical objects stored in symbol tables or dictionaries so they align with your company's standards. Aligning the standards in the drawings received from a client ensure that the objects you create and those in the drawings plot with a consistent appearance.

For example, the transparency level and description of a layer is attached as XData to a layer table entry, and both layer states and filters are attached as extension dictionaries to the layer table. I covered XData in Chapter 16,「Creating and Modifying Graphical Objects」and will discuss dictionaries in the section「Working with Dictionaries」later in this chapter.

Table 17.1 lists the symbol-table names that are supported in all drawing files created with AutoCAD R12 and later.

Table 17.1 Symbol-table names

Table name Description

appid Registered applications

block Block definitions

dimstyle Dimension styles

layer Layers

ltype Linetypes

style Text styles

ucs User coordinate systems

view Named views

vport Viewports

Accessing and Stepping through Symbol Tables

AutoLISP provides three functions that allow you to access the entries of a symbol table or determine if a specific entry exists in a symbol table. The tblnext function returns either the first or next entry in a specified symbol table. The tblnext function is similar to the entnext function that I discussed in Chapter 16.

The following shows the syntax of the tblnext function:

(tblnext sym_table [next])

Its arguments are as follows:

sym_table The sym_table argument is a string used to specify the symbol table which you want to query, and it must be one of the values listed in the first column of Table 17.1.

next The next argument is optional, and specifies whether you want to get the first entry of a symbol table or the next symbol-table entry after the previous entry that was returned. Use a value of T to return the first value. When no argument or nil is provided, an entity data list of the next symbol table entry is returned.

The following example code shows the tblnext function and the resulting list of layer names in a drawing:

; Lists the layers in the drawing (defun c:listlayers ( / entityData) (prompt "\nLayers in this drawing:") (setq entityData (tblnext "layer" T)) (while entityData (prompt (strcat "\n" (cdr (assoc 2 entityData)))) (setq entityData (tblnext "layer")) ) (princ) ) Layers in this drawing: 0 Labels Panels Surfaces Storage Defpoints Dimensions BOM

To check for the existence of or get the entity data list of an entry in a symbol table, you can use the tblsearch function. If the name of the entry in the specified table exists, an entity data list is returned for the entry; otherwise, nil is returned. The tblobjname function can also be used to check for the existence of a symbol table entry, but unlike the tblsearch function, tblobjname returns the entity name (ename) of the entry if it is found; otherwise, it returns nil.

The following shows the syntax of the tblsearch and tblobjname functions:

(tblsearch sym_table entry [next]) (tblobjname sym_table entry)

The arguments are as follows:

sym_table The sym_table argument is a string that represents the symbol table you want to query, and it must be one of the values in the first column of Table 17.1.

entry The entry argument is a string that represents the entry you want to check for in the symbol table specified by the sym_table argument.

next The next argument is optional and represents whether the next call to tblnext uses the results of the tblsearch function to determine its starting entry. Use a value of T to not affect the next call of the tblnext function in the current drawing. When no argument or nil is provided, the tblnext function bases the entity it returns on the position of the entry provided by the entry argument.

Here are some examples of the tblobjname and tblsearch functions, and their results:

; Get the entity data list for layer 0 (tblsearch "layer" "0") ((0. "LAYER") (2. "0") (70. 0) (62. 7) (6. "Continuous")) ; Get the entity data list for the layer BOM (tblsearch "layer" "BOM") nil ; Get the entity name of layer 0 (tblobjname "layer" "0") <Entity name: 7ff6cde08900> ; Get the entity name of the BOM layer (tblobjname "layer" "BOM") nil ; Check for the existence of the BOM layer (if (tblobjname "layer" "BOM") (alert "BOM layer already exists in the current drawing.") )

Adding and Modifying Entries in a Symbol Table

Most symbol table entries are inherited from the drawing template that was used to create a drawing file or are created as a result of inserting a block into a drawing. A drawing template should contain most of the layers, linetypes, and other nongraphical objects you might want to use in your drawing, but you can use AutoLISP to create and modify any additional system table entries you might need. The methods you use to create and modify nongraphical objects are the same as those for graphical objects (which I explained in Chapter 16).

The symbol table entries you create or modify should follow your company's established CAD standards or those of the industry in which you work. Modifying existing table entries should be done with care, because the changes you make could have an adverse effect on existing objects in a drawing. For example, changing the height of a text style could affect dimensions and tables in your drawing.

An Ounce of Prevention

It is 3:00 p.m., and your boss just let you know that a set of drawings needs to be sent out by 6:00 p.m. for an initial bid. You output all of the drawings, only to discover that objects in some of the drawings weren't placed on the correct layers and text styles don't use the correct fonts. Everyone decided to take a half day today because they have been working frantically for the past two weeks on this project. Getting the project across the finish line now rests on your shoulders. The drawings need to be sent out for the initial bid, but their current state is less than ideal for a first impression to the new client.

What to do?

Take a deep breath and channel your inner AutoLISP to create a program that can be executed in each drawing to change the text styles to use the correct fonts—one problem down. Now, on to the layer issues.

Using AutoLISP, you can verify whether the correct layer exists and, if not, create the new layer. With selection filters that you learned about in Chapter 16, you can select and move objects to their appropriate layers based on object type or current property values.

Now that the drawings have been fixed, you output the revised drawings with minutes to spare. This battle is won, but the war for CAD excellence is not over yet. Custom programs created with AutoLISP can help you to enforce CAD standards in your office. Using the programs you create, a drafter can focus more on the elements of a design and less on switching to the correct layer and style before adding new objects.

Adding an Entry

You can add a new style table entry using the appropriate AutoCAD command with the command function. For example, you can use the -layer command to create a new layer, -block to create a new block, or -linetype to create or load a linetype pattern.

As you learned in Chapter 16, you can use the command function with AutoCAD commands, but I recommend using the entmake or entmakex function to create new objects instead. Creating new objects with entity data lists gives you more control over the object that you create, but it requires you to learn the DXF group codes and values that each object expects. For information on the entmake and entmakex functions, see the「Adding Objects to a Drawing」section in Chapter 16.

TIP

You can use the tblobjname and entget functions to return the entity data list of an existing symbol table entry that you want to reproduce using AutoLISP. For example, (entget (tblobjname "ltype" "center")) returns the entity data list for the Center linetype if it is loaded in the current drawing.

This next code example attempts to create a new layer named Centerlines with the linetype Center:

(entmake (list (cons 0 "LAYER") (cons 100 "AcDbSymbolTableRecord") (cons 100 "AcDbLayerTableRecord") (cons 2 "Centerlines") (cons 70 0) (cons 62 3) (cons 6 "Center"))) Error: Undefined line type Center in LayerTableRecord Centernil

An error message and nil is returned if the Center linetype doesn't exist in the drawing prior to creating the layer. Before you create symbol table entries, you must make sure that all of the objects they depend on are present in the drawing. For example, a linetype must exist in a drawing before a layer that uses the linetype can be created. The same is true of dimension styles; the text style and linetypes that a dimension style might reference must exist in the drawing before you create the dimension style.

This example checks for the Center linetype and, if it doesn't exist, the linetype is created using the entmake function:

(if (= (tblsearch "ltype" "center") nil) (entmake (list (cons 0 "LTYPE")(cons 100 "AcDbSymbolTableRecord") (cons 100 "AcDbLinetypeTableRecord") (cons 2 "CENTER") (cons 70 0) (cons 3 "Center ____ _ ____ _ ____ _ ____ _ ____ _ ____") (cons 72 65) (cons 73 4) (cons 40 2.0) (cons 49 1.25) (cons 74 0) (cons 49 -0.25) (cons 74 0) (cons 49 0.25) (cons 74 0) (cons 49 -0.25) (cons 74 0)) ) ) ((0. "LTYPE") (100. "AcDbSymbolTableRecord") (100. "AcDbLinetypeTableRecord") (2. "CENTER") (70. 0) (3. "Center ____ _ ____ _ ____ _ ____ _ ____ _ ____") (72. 65) (73. 4) (40. 2.0) (49. 1.25) (74. 0) (49. -0.25) (74. 0) (49. 0.25) (74. 0) (49. -0.25) (74. 0))

Using the previous example, you can ensure that the Center linetype exists in the drawing before you try to create the Centerlines layer. Now if you try to create the Centerlines layer with the following example, the new layer is created since the Center linetype is defined in the drawing.

(entmake (list (cons 0 "LAYER") (cons 100 "AcDbSymbolTableRecord") (cons 100 "AcDbLayerTableRecord") (cons 2 "Centerlines") (cons 70 0) (cons 62 3) (cons 6 "Center"))) ((0. "LAYER") (100. "AcDbSymbolTableRecord") (100. "AcDbLayerTableRecord") (2. "Centerlines") (70. 0) (62. 3) (6. "Center"))

Before creating a new symbol table entry with entmake or entmakex, you should verify that it doesn't already exist. If the symbol table entry already exists, entmake or entmakex will return nil. I also recommend checking the name of the symbol table entry you are trying to add with the snvalid function. The snvalid function verifies that the name doesn't contain any invalid characters and follows the naming rules based on the current value of the extnames system variable. For more information on the extnames system variable, see the AutoCAD Help system.

The following shows the syntax of the snvalid function:

(snvalid name [flag])

Here are its arguments:

name The name argument is a string that represents the name of the symbol table entry you want to verify.

flag The flag argument is an optional integer that determines whether the symbol table entry name can contain a vertical bar. 0 indicates that a vertical bar is not allowed, whereas 1 indicates that the vertical bar is a valid character as long as it isn't the first character in the entry name.

Here are some examples of using the snvalid function and the values that are returned:

(snvalid "Centerlines") T (snvalid "Centerlines?") nil (snvalid "Detail|Centerlines" 0) nil (snvalid " Detail|Centerlines " 1) T

Modifying and Renaming an Entry

Symbol table entries can be modified and renamed using the same techniques that you learned in Chapter 16 for modifying graphical objects. You can use the AutoLISP functions listed in Table 17.2 to modify symbol table entries.

Table 17.2 Functions that can be used to modify symbol table entries

Function name Description

entget Returns the entity data list for an object

entmod Commits an entity data list to an object

dumpallproperties Outputs the property names and their current values for an object

getpropertyvalue Returns an object's property value

ispropertyreadonly Determines whether an object's property is read-only

setpropertyvalue Sets an object's property value

When modifying symbol table entries, you should understand that not all entries can be renamed or modified. For example, you can modify layer 0 but you can't rename the layer. The layers that you create, with the exception of those in an attached external reference, can be modified and renamed. Table 17.3 lists the symbol table entries that you can't rename and/or modify.

Table 17.3 Symbol table entry name and modification limits

Table name Entry name Description

appid Nothing specific Entries can't be renamed, but they can be removed.

block *model_space and

*paper_space Model space and paper space block definitions can't be renamed or removed. Drawings can have more than one paper space block; these additional blocks have a numeric suffix starting at 1.

dimstyle standard Can be modified but not renamed or removed.

layer 0 Can be modified but not renamed or removed.

ltype continuous Can't be modified, renamed, or removed.

style standard Can be modified but not renamed or removed.

ucs *active Can be modified but not renamed or removed.

vport *active Can be modified but not renamed or removed.

Here's an example that shows how to rename a layer and its current color by using its entity data list. The name of a symbol table entry is designated with the dotted pair that has the DXF group code 2 key element.

; Get the layer named "BOM" (setq entityName (tblobjname "layer" "BOM")) ; Get the entity data for the layer (setq entityData (entget entityName)) ; Rename the layer from "BOM" to "Bill of Materials" (setq entityData (subst (cons 2 "Bill of Materials") (assoc 2 entityData) entityData)) ; Change the layers color to 5 (setq entityData (subst (cons 62 5) (assoc 62 entityData) entityData)) ; Update the layer (entmod entityData)

The following example renames the layer「Bill of Materials」back to「BOM」and changes the layer color to 8 with the setpropertyvalue function:

; Get the layer named "Bill of Materials" (setq entityName (tblobjname "layer" "Bill of Materials")) ; Rename the layer from "Bill of Materials" to "BOM" (setpropertyvalue entityName "name" "BOM") ; Change the layer's color to 8 (setpropertyvalue entityName "color" 8)

Using an Object

After a symbol table entry is created, you can use that entry in a number of ways based on the type of object it represents. The most common is to set it as current using a system variable before creating a new object so that the new object inherits the properties of the symbol table entry when possible. For example, you can use the clayer system variable to set the active layer in the drawing, or use celtype to indicate the linetype that new objects should inherit. You should refer to the setvar command and the AutoCAD Help system to identify the system variables your AutoCAD release supports and the properties they might affect.

In addition to system variables, you can change the name of a symbol table entry assigned to an object using entity data lists with the entmod function or directly with the getpropertyvalue and setpropertyvalue functions. If you created a new named view, you can use the setview function to set the view current in a viewport. For more information on the setview function, see the AutoCAD Help system.

Removing an Entry That Is No Longer Needed

Since the same techniques can be used to create and modify both graphical and symbol table entries, you might think that removing a symbol table entry and a graphical object would also be the same in AutoLISP. The entdel function is used to remove graphical objects, but it cannot be used to remove symbol table entries. This is one of the very few times that you can't use「classic」AutoLISP to do something. Instead of using a specific AutoLISP function, you must use the command function with the -purge command to remove a symbol-table object.

You can use the tblobjname and tblsearch functions to determine whether a specific symbol table entry exists in a drawing, and then use the -purge command to remove it. If the symbol table entry doesn't exist or cannot be removed because it is being used, the -purge command will end gracefully without any significant error messages that require user interaction to dismiss. Here's an example of how to remove a block named roomlabel from a drawing with the -purge command:

(command "._-purge" "_b" "roomlabel" "_n")

NOTE

On Windows only, you can use the AutoLISP vla-delete function after loading the AutoCAD ActiveX/COM interface with the vl-load-com function. I discuss the basics of using ActiveX with AutoLISP in Chapter 22,「Working with ActiveX/COM Libraries (Windows only).」

Creating and Modifying Block Definitions

Although some symbol table entries can seem complex at first, blocks are probably at the top of the list when it comes to complexity. When you initially create a block entry, the block entry contains no graphical objects. You add graphical objects to a block entry similar to how you add objects to a drawing with the entmake or entmakex function.

A block definition has a beginning (header) of the block object type and an ending sequence of the endblk object type. The beginning sequence tells AutoCAD that a block definition is being created along with the following information (at minimum):

Block name (DXF group code 2)

Block-type flags as a bitcode (DXF group code 70)

Base point (DXF group code 10)

The block-type flag is typically set to a value of 0 (which indicates that the block doesn't contain attribute definitions or that all of the attribute definitions are constant) or to a value of 2 (which indicates that the block contains nonconstant attributes). Once the block definition is started, use the entmake or entmakex function to add objects to the block definition. You can't add an attribute reference (attrib) object to a block definition. Instead, add attribute definition (attdef) objects to a block definition. These are used to define the attribute references that should be added to a block reference when it is inserted into model space or paper space with the insert command.

Here's a basic representation of the entity data lists that you need to create to define a block without any attributes or graphical objects. Passing the entity data lists to the entmake function will create an empty block.

; Start block definition ((0. "BLOCK") (2. "some_block_name") (10 0.0 0.0 0.0) (70. 0)) ; Objects here with entmake ; End block definition ((0. "ENDBLK"))

If you want to revise the content of a block definition (also known as redefining a block), there are a couple of different processes. Choose the process you need based on how the block definition should be revised:

Updating or Removing Objects Step through the objects of a block definition when you need to change the properties of or remove an existing object in a block definition. Get the entity name of the block definition with the tblobjname function and step through the block definition with the entnext function. Change the objects in the block definition as you would those in a model space or paper space. Use the entdel function to remove objects from a block definition.

Adding Objects You must re-create the block definition by going through the process used to create the block. That is, to start the block definition, add the objects and then add the end block-definition marker. If you don't want to re-create all of the objects as part of the block definition, you can create a block reference in the drawing and explode it. Once it's exploded, you can add the new objects you want to add to the block in model space and then use the -block command to redefine the block definition.

NOTE

On Windows only, you can use AutoLISP vla-add<object> functions to add objects directly to an existing block definition. I discuss the basics of using ActiveX with AutoLISP in Chapter 22.

In the following exercise, you'll create a new block definition and layer. The new block definition is named circ and it contains a single circle object with a base point of 0,0. The new layer is named hardware and has a color value of 3 (green).

Create a new drawing.

At the AutoCAD Command prompt, type the following and then press Enter to start the block definition for the circ block:(entmake (list (cons 0 "block")(cons 2 "circ") (cons 10 (list 0.0 0.0 0.0))(cons 70 0)))

Type the following and press Enter to add the circle at 0,0 with a radius of 2. The circle is placed on layer 0 so that it inherits the properties of the layer on which the block is placed.(entmake (list (cons 0 "circle")(cons 10 (list 0.0 0.0 0.0)) (cons 40 2)(cons 8 "0")))

Type the following and press Enter to end the circ block definition:(entmake (list (cons 0 "endblk")))

Type the following and press Enter to create the layer named hardware with a color of 3 and a linetype of Continuous:(entmake (list (cons 0 "layer") (cons 100 "AcDbSymbolTableRecord") (cons 100 "AcDbLayerTableRecord") (cons 2 "hardware") (cons 70 0) (cons 62 3) (cons 6 "Continuous")))

Type the following and press Enter to set the hardware layer as current:(setvar "clayer" "hardware")

Type insert and press Enter to display the Insert (Windows) or Insert Block (Mac OS) dialog box.

When the Insert dialog box opens, click the Name drop-down list and select circ.

Deselect all the check boxes under the Insert Point, Scale, and Rotation sections. Click OK (Windows) or Insert (Mac OS) to insert the block into the drawing.

Zoom to the extents of the drawing.

Select the new object in the drawing. Right-click and choose Properties.

In the Properties palette (Windows) or Properties Inspector (Mac OS), you should notice that the object is a block named circ and that it has been placed on the hardware layer.

Working with Dictionaries

Dictionaries are used to store custom information and objects in a drawing and can be thought of as symbol tables 2.0. Dictionaries were introduced with AutoCAD R13 as a way to introduce new symbol tables like objects without the need to change the drawing file format with each release. Although there is only one type of dictionary in a drawing, dictionaries can be stored in two different ways: per drawing or per object.






















The main dictionary of a drawing contains nested dictionaries that store multileader and table styles, and even the layouts used to output a drawing. Dictionaries attached to an object are known as extension dictionaries. Extension dictionaries are similar to XData but allow you to attach more information to a single object. AutoCAD uses extension dictionaries attached to the layer symbol table to store the information used for layer states and filters.

Custom dictionaries are great for storing custom program settings so that they persist across drawing sessions. You might also use a custom dictionary as a way to store drawing revision history or project information that can be used to track a drawing and populate a title block. In this section, you'll learn how to access, create, query, and modify information stored in a dictionary.

Accessing and Stepping through Dictionaries

The dictionary-related AutoLISP functions are similar to those used when working with symbol tables. Before you can access the entries in a dictionary, you must first get a dictionary. The namedobjdict function returns the entity name of the drawing's named-object dictionary. This is the main dictionary that contains all the dictionaries that aren't attached to an object as an extension dictionary. The namedobjdict function doesn't require any arguments.

Once you have the entity name of the named object dictionary, use the entget function to get an entity data list that contains the key entries and entity names for each dictionary. Each entry in the named object dictionary is represented by two dotted pairs. The first dotted pair represents the unique name of a dictionary and DXF group code 3. The second dotted pair contains the entity name for the dictionary and DXF group code 350.

Here's an example of an entity data list for a named object dictionary:

((-1. <Entity name: 7ff6646038c0>) (0. "DICTIONARY") (330. <Entity name: 0>) (5. "C") (100. "AcDbDictionary") (280. 0) (281. 1) (3. "ACAD_COLOR") (350. <Entity name: 7ff664603c30>) (3. "ACAD_GROUP") (350. <Entity name: 7ff6646038d0>) (3. "ACAD_VISUALSTYLE") (350. <Entity name: 7ff6646039a0>) (3. "ACAD_MATERIAL") (350. <Entity name: 7ff664603c20>))

The third dictionary entry in the example entity data list is (3. "ACAD_VISUALSTYLE") (350. <Entity name: 7ff6646039a0>), and this entry allows you to access the visual styles of the current drawing. The code in Listing 17.1 returns the entity name for a ACAD_VISUALSTYLE dictionary.

Listing 17.1: Custom function that returns the Visual Styles dictionary

; Custom function that returns the entity name of a specific dictionary entry (defun GetDictionaryByKeyEntry (dictionaryEntity dKeyEntry / entityData dKeyEntry dEntityName cnt) (setq entityData (entget dictionaryEntity)) (setq dEntityName nil) (setq cnt 0) (while (and (= dEntityName nil)(< cnt (length entityData))) (if (and (= (car (nth cnt entityData)) 3) (= (cdr (nth cnt entityData)) dKeyEntry)) (progn (setq dEntityName (cdr (nth (1+ cnt) entityData))) ) ) (setq cnt (1+ cnt)) ) dEntityName ) ; Example of using the custom function (GetDictionaryByKeyEntry (namedobjdict) "ACAD_VISUALSTYLE")

After you have the entity name for the dictionary you want to work with, you can use the dictnext function to return either the first or next item attached to the dictionary. The dictnext function is similar to the tblnext function, which I discussed earlier in this chapter.

The following shows the syntax of the dictnext function:

(dictnext ename [next])

Its arguments are as follows:

ename The ename argument is an entity name that represents the dictionary you want to step through.

next The next argument is optional, and it specifies whether you want to get the first entry of a dictionary or the entry after the one that was returned by the last use of the dictnext function. Use a value of T to return the entity name of the first entry in the dictionary. When no argument or nil is provided, the entity name of the next entry is returned.

The following example code uses the AutoLISP dictnext function and the GetDictionaryByKeyEntry function in Listing 17.1 to step through and list the names of each visual style in the drawing. The code is followed by an output listing from one of my drawings.

; Lists the visual styles in the drawing (defun c:listvisualstyles ( / entityData dictionaryName) (setq dictionaryName (GetDictionaryByKeyEntry (namedobjdict) "ACAD_VISUALSTYLE")) (prompt "\nVisual styles in this drawing:") (setq entityData (dictnext dictionaryName T)) (while entityData (prompt (strcat "\n" (cdr (assoc 2 entityData)))) (setq entityData (dictnext dictionaryName)) ) (princ) ) Visual styles in this drawing: 2dWireframe Basic Brighten ColorChange Conceptual Dim EdgeColorOff Facepattern Flat FlatWithEdges Gouraud GouraudWithEdges Hidden JitterOff Linepattern OverhangOff Realistic Shaded Shaded with edges Shades of Gray Sketchy Thicken Wireframe X-Ray

If you know (or want to check for the existence of) a key entry in a dictionary, you can use the dictsearch function. If the name of the key entry in the dictionary exists, the entity data list of the key entry is returned; otherwise, nil is returned. Here's an example of using the dictsearch function to get the entity data list associated with the ACAD_TABLESTYLE dictionary:

(setq entityData (dictsearch (namedobjdict) "ACAD_TABLESTYLE")) ((-1. <Entity name: 7ff664603ce0>) (0. "DICTIONARY") (5. "86") (102. "{ACAD_REACTORS") (330. <Entity name: 7ff6646038c0>) (102. "}") (330. <Entity name: 7ff6646038c0>) (100. "AcDbDictionary") (280. 0) (281. 1) (3. "Standard") (350. <Entity name: 7ff664603cf0>))

Once you have the entity data list for the dictionary, you can use the assoc function to get the dictionary's entity name, which is associated with the DXF group code –1. After you get the entity name for the dictionary, you can then pass it to the dictsearch function to locate a specific key entry in the dictionary. The following shows how to get the Standard table style entry from the entity data list of the ACAD_TABLESTYLE dictionary:

(setq entityNameTS (cdr (assoc -1 entityData))) (setq entityDataTS (dictsearch entityNameTS "STANDARD")) ((-1. <Entity name: 7ff664603cf0>) (0. "TABLESTYLE") (5. "87") (102. "{ACAD_XDICTIONARY") (360. <Entity name: 7ff664605340>) (102. "}") (102. "{ACAD_REACTORS") (330. <Entity name: 7ff664603ce0>) (102. "}") (330. <Entity name: 7ff664603ce0>) (100. "AcDbTableStyle") (280. 0) (3. "Standard") … (68. 0) (279. -2) (289. 1) (69. 0))

Here's the syntax of the dictsearch function:

(dictsearch ename entry)

Its arguments are as follows:

ename The ename argument is an entity name that represents the dictionary you want to query to check for the existence of the key entry specified by the entry argument.

entry The entry argument is a string that represents the entry you want to check for in the dictionary specified by the ename argument.

NOTE

You can use the layoutlist function to get a list of the named layouts in the current drawing. For more information on this function, see the AutoCAD Help system.

Creating a Custom Dictionary

As I mentioned earlier, one of the benefits of dictionaries is that you can store custom information or settings related to the programs you create in a drawing. Before a custom dictionary can be used and entries added to it, it must first be created. The entmakex function, not entmake, is used to create a dictionary. Once created, the new dictionary can be attached to either the named object dictionary or an object as an extension dictionary. You attach the new dictionary to the drawing's named object dictionary with the dictadd function.

The following shows the syntax of the dictadd function:

(dictadd ename key_entry dictionary)

Its arguments are as follows:

ename The ename argument is an entity name that represents the object (named or object's extension dictionary). The dictionary that is specified by the dictionary argument is attached to the object.

key_entry The key_entry argument is a string that represents the unique key entry name that you want to associate with the dictionary that is specified by the dictionary argument.

dictionary The dictionary argument is an entity name that represents the dictionary that you want to attach to the entity name specified by the ename argument.

Here's an example that creates a dictionary named MY_CUSTOM_DICTIONARY and adds it to the named object dictionary:

; Create dictionary object (setq entityName (entmakex (list (cons 0 "DICTIONARY") (cons 100 "AcDbDictionary")))) ; Add the dictionary to the named object dictionary (setq newdictionary (dictadd (namedobjdict) "MY_CUSTOM_DICTIONARY" entityName))

In addition to adding a dictionary to the named object dictionary that is returned by the namedobjdict function, you can create an extension dictionary on a graphical object. The extension dictionary is similar to the named object dictionary of a drawing, and it can hold nested dictionaries of extended records. I discuss extended records (Xrecords) in the next section.

This example adds an extension dictionary to the last object in a drawing:

; Creates a new dictionary (setq dictionary (entmakex (list (cons 0 "DICTIONARY")(cons 100 "AcDbDictionary")))) ; Entity Data list of the extension dictionary (setq exDictionary (list (cons 102 "{ACAD_XDICTIONARY") (cons 360 dictionary)(cons 102 "}"))) ; Attach the extension dictionary to the last object (setq entityData (append (entget (entlast)) exDictionary)) (entmod entityData)

Once the extension dictionary is attached to the object, you can use the DXF group code 360 to get the entity name of the extension dictionary. With the entity name, you can then add dictionaries or Xrecords to the object's extension dictionary.

This example gets the entity name of the extension dictionary attached to the last object in the drawing:

(cdr (assoc 360 (entget (entlast))))

nil is returned if no extension dictionary has been added to the object.

Storing Information in a Custom Dictionary

After a custom dictionary has been created, you add entries to a custom dictionary using the dictadd function. Entries of a custom dictionary are often of the extended record (also known as an Xrecord) object type. An Xrecord is similar to XData and can be attached to an object, but it contains DXF group codes that are in the same range as graphical objects. You create an Xrecord with the entmakex function before attaching it to the dictionary.

The following code creates an Xrecord and attaches it to MY_CUSTOM_DICTIONARY, which can be created using the example from the previous section, with the XR1 key entry. The Xrecord contains a string (DXF group code 1), a coordinate value (DXF group code 10), and an integer (DXF group code 71).

; Add the Xrecord to the dictionary (dictadd newdictionary "XR1" (entmakex (list (cons 0 "XRECORD")(cons 100 "AcDbXrecord") (cons 1 "Custom string")(cons 10 (list 5.0 5.0 0.0)) (cons 71 11))))

If you need to make a change to the data contained in an Xrecord that has been attached to a dictionary, use the dictsearch function to get the entry's entity data list. The dotted pairs in the entity data list can be replaced with the assoc function as needed, just like updating a graphical object or symbol table entry. Entries can also be renamed from a custom dictionary; you'll learn how to rename and remove entries in the next section.

Managing Custom Dictionaries and Entries

After a dictionary or Xrecord object has been created and attached, you can change its key entry or remove it as needed. Although you can freely rename and remove the dictionaries and Xrecords you create, those created by AutoCAD can also be renamed and removed. I recommend being cautious about renaming or removing those created by AutoCAD, because doing so could cause problems. Not all dictionaries and objects attached to a dictionary can be removed since they may be referenced by other objects. When a dictionary is successfully renamed, the new name of the dictionary is returned (or nil is returned when the dictionary couldn't be renamed). Similarly, the ename of a dictionary is returned when a dictionary is removed or nil is returned if it couldn't be removed.

You can use the dictrename function to change the current key entry to a new key entry value. The dictremove function can be used to remove a dictionary or an entry in a dictionary.

The following shows the syntax of the dictrename function:

(dictrename ename old_key_entry new_key_entry)

Its arguments are as follows:

ename The ename argument is an entity name that represents the dictionary or entry whose current key entry name (old_key_entry argument) you want to change to the new key entry name (new_key_entry argument).

old_key_entry The old_key_entry argument is a string that represents the current unique key entry name associated with the dictionary or entry that is specified by the ename argument.

new_key_entry The new_key_entry argument is a string that represents the new unique key entry name that should replace the key entry specified by the old_key_entry argument.

The following shows the syntax of the dictremove function:

(dictremove ename key_entry)

Its arguments are as follows:

ename The ename argument is an entity name that represents the dictionary that has the dictionary or entry you want to remove.

key_entry The key_entry argument is a string that represents the unique key entry name of the dictionary or entry you want to remove from the object specified by the ename argument.

Here are examples that rename and remove a custom dictionary:

; Renames the key entry of a dictionary (dictrename (namedobjdict) "MY_CUSTOM_DICTIONARY" "MY_DICTIONARY") ; Removes the custom dictionary with the key entry "MY_DICTIONARY" (dictremove (namedobjdict) "MY_DICTIONARY")

Exercise: Creating and Incrementing Room Labels

In this section, you will create several new functions that will be used to define and insert room-label blocks into a drawing. Room labels are used to identify areas in architectural drawings, but the same concept can be applied to callouts in mechanical drawings.

As you insert a room label block with the custom program, a counter increments by 1 so you can place the next room label without having to manually enter a new value. Before the room-labeling program ends, the last calculated value is stored in a custom dictionary so it can be retrieved the next time the program is started (instead of using global variables). The key concepts covered in this exercise are as follows:

Creating and Modifying Symbol Table Entries Symbol table entries in a drawing can affect the display of graphical objects in a drawing. Each drawing that you create contains a set number of symbol tables you can access using AutoLISP. You can then create or manipulate any of the entries that are in one of the symbol tables.

Using Symbol Table Entries As new objects are created, you can assign the names of symbol table entries to various properties of an object so that it inherits the symbol table entries' properties. You can change the value associated with the DXF group code 8 of an object to move the object between layers, or even change the value associated to the DXF group code 2 of a block reference to change which block definition it inherits its geometry from.

Creating and Storing Information in a Custom Dictionary Values assigned to variables in a drawing are temporary, but you can use custom dictionaries to persist values across drawing sessions. The values stored in a drawing can then be recovered by your programs after the drawing is closed and reopened, similar to how system variables work.

NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Creating, Querying, and Modifying Objects」section of Chapter 16. If you didn't complete these exercises, do so now or start with the ch17_building_plan.dwg and ch17_utility.lsp sample files available for download from www.sybex.com/go/autocadcustomization. These sample files should be placed in the MyCustomFiles folder within the Documents (or My Documents) folder, or the location you are using to store the LSP files. Once the files are stored on your system, remove ch17_ from the name of the LSP file.

Revising the createlayer Function in utility.lsp

The changes you will make to the utility.lsp file update the createlayer function so that the function checks to see if the layer already exists before it creates the layer, instead of the current behavior of automatically creating/modifying the layer. With these changes, the function checks for the existence of the layer with the tblobjname function and creates the new layer (if it doesn't already exist) using the entmake function.

The following steps explain how to update the various functions in the utility.lsp file:

Open the utility.lsp file in Notepad on Windows or TextEdit on Mac OS.

In the text editor area, update the createrlayer function to match the code that follows:; CreateLayer function creates a layer and ; expects two argument values. (defun createlayer (name color / ) (if (= (tblobjname "layer" name) nil) (entmake (list (cons 0 "LAYER") (cons 100 "AcDbSymbolTableRecord") (cons 100 "AcDbLayerTableRecord") (cons 2 name) (cons 70 0) (cons 62 color) (cons 6 "Continuous"))) ) )

Click File Save.

Creating the Room Label Block Definition

Creating separate drawing files that your custom programs depend on has its advantages and disadvantages. The advantage of creating a separate drawing file is that you can use the AutoCAD user interface to create the block file. However, AutoCAD will need to know where the drawing file is stored so the custom program can use the file. The advantage of creating the block definition through code is that no separate drawing file needs to be maintained, making it easier to share your custom application with your clients or subcontractors.

In these steps, you create a custom function named roomlabel_createblkdef that will be used to create the block definition for the room label block if it doesn't already exist in the drawing.

Create a new LSP file named roomlabel.lsp using Notepad (on Windows) or TextEdit (on Mac OS).

In the text editor area of the roomlabel.lsp file, type the following:; Creates the block definition roomlabel (defun RoomLabel_CreateBlkDef ( / ) (setvar "clayer" "0") ; Start block definition (entmake (list (cons 0 "BLOCK") (cons 2 "roomlabel") (cons 10 (list 18.0 9.0 0.0)) (cons 70 2))) ; Create the rectangle for around the block attribute (createrectangle (list 0.0 0.0 0.0) (list 36.0 0.0 0.0) (list 36.0 18.0 0.0) (list 0.0 18.0 0.0)) ; Add the attribute definition (entmake (list (cons 0 "ATTDEF") (cons 100 "AcDbEntity") (cons 8 "Plan_RoomLabel_Anno") (cons 100 "AcDbText") (cons 10 (list 18.0 9.0 0.0)) (cons 40 9.0) (cons 1 "L000") (cons 7 "Standard") (cons 72 1) (cons 11 (list 18.0 9.0 0.0)) (cons 100 "AcDbAttributeDefinition") (cons 280 0) (cons 3 "ROOM#") (cons 2 "ROOM#") (cons 70 0) (cons 74 2) (cons 280 1))) ; End block definition (entmake (list (cons 0 "ENDBLK"))) (princ) )

Click File Save. The block definition that will be created when the code is executed is shown in Figure 17.1.

Figure 17.1 RoomLabel block definition

Inserting a Block Reference Based on the Room Label Block Definition

Once the block definition has been created and added to the block symbol table, it can be inserted into the drawing with the insert command or even used to define a block reference with the entmake function.

In the next exercise steps, you will create three custom functions: addattrefs, changeattvalue, and roomlabel_insertblkref. The addattrefs function is a helper function used to add attribute references to a block reference based on the attribute definitions that are part of a block definition. The changeattvalue function allows you to revise the insertion point and value of an attribute reference attached to a block reference based on the attribute's tag. The roomlabel_insertblkref function creates a block reference based on the RoomLabel block definition that we created with the roomlabel_createblkdef function.

Open the roomlabel.lsp file with Notepad (Windows) or TextEdit (Mac OS), if it is not already open.

In the text editor area of the roomlabel.lsp file, type the following:; Adds attribute references from a block definition to a block reference (defun AddAttRefs (blockName / entityName entityData) ; Gets the entity name for the block definition (setq entityName (tblobjname "block" blockName)) ; Steps through the block definition (while entityName ; Gets the entity data list for the entity (setq entityData (entget entityName)) ; Checks to see if the entity is an attribute definition (if (= (strcase (cdr (assoc 0 entityData))) "ATTDEF") ; Checks to see if the attribute definition is constant or not (if (/= (logand 2 (cdr (assoc 70 entityData)))) (progn ; Converts the object type from ATTDEF to ATTRIB (setq entityData (subst (cons 0 "ATTRIB") (assoc 0 entityData) entityData)) (setq entityData (subst (cons 100 "AcDbAttribute") (cons 100 "AcDbAttributeDefinition") entityData)) ; Removes the Handle, entity name, and owner from ; the entity data list (foreach dxfGroupCode (list -1 5 330 3) ; 67 210 (setq list_begin (reverse (cdr (member (assoc dxfGroupCode entityData) (reverse entityData))))) (setq list_end (cdr (member (assoc dxfGroupCode entityData) entityData))) (setq entityData (append list_begin list_end)) ) ; Creates the new attribute reference based on ; the attribute definition (entmake entityData) ) ) ) ; Gets the next block in the block definition (setq entityName (entnext entityName)) ) (princ) ) ; Changes the value of an attribute reference in a block reference (defun ChangeAttValue (blkRefEntityName insPt attTag newValue / entityName entityData) ; Gets the first object in a block reference (setq entityName (entnext blkRefEntityName)) ; Steps through the block reference (while entityName ; Gets the entity data list for the entity (setq entityData (entget entityName)) ; Checks to see if the entity is an attribute definition (if (= (strcase (cdr (assoc 0 entityData))) "ATTRIB") ; Checks to see if the attribute definition is constant or not (if (= (strcase (cdr (assoc 2 entityData))) (strcase attTag)) (progn ; Update the attribute value (entmod (setq entityData (subst (cons 1 newValue) (assoc 1 entityData) entityData))) ; Changes the position of the attribute (if (/= insPt nil) (progn (entmod (setq entityData (subst (cons 10 insPt) (assoc 10 entityData) entityData))) (entmod (setq entityData (subst (cons 11 insPt) (assoc 11 entityData) entityData))) ) ) (entupd entityName) ) ) ) ; Gets the next block in the block reference (setq entityName (entnext entityName)) ) (princ) ) ; Creates the block definition roomlabel (defun RoomLabel_InsertBlkRef (insPoint labelValue / blkLayer) (setq blkLayer "Plan_RoomLabel_Anno") ; Creates the "Plan_RoomLabel_Anno" layer (createlayer blkLayer 150) ; Checks to see if the block definition exists in the drawing; ; if not, the block definition is added (if (= (tblobjname "block" "roomlabel") nil) (RoomLabel_CreateBlkDef) ) ; Creates the block reference (entmake (list (cons 0 "INSERT") (cons 8 blkLayer) (cons 100 "AcDbEntity") (cons 100 "AcDbBlockReference") (cons 66 1) (cons 2 "roomlabel") (cons 10 insPoint))) ; Adds the attribute references to the block reference (AddAttRefs "roomlabel") ; Ends block reference (entmake (list (cons 0 "SEQEND") (cons 100 "AcDbEntity"))) ; Changes the attribute value of the "ROOM#" (ChangeAttValue (entlast) insPoint "ROOM#" labelValue) (princ) )

Click File Save.

Prompting the User for an Insertion Point and Room Number

Now that you have defined the functions for creating the block definition and inserting the block reference into a drawing, you need a function that prompts the user for input. The roomlabel function will allow the user to specify a point in the drawing, provide a new room number, or provide a new prefix. The roomlabel function uses the default number of 101 and a prefix of L.

As you use the roomlabel function, it creates and uses a custom dictionary named My_Custom_Program_Settings with an entry RoomLabel. If the RoomLabel entry exists, it writes the number and prefix of the last room label that you placed. Closing and reopening the drawing results in the program picking up where you left off.

In these steps, you'll create the custom function roomlabel that uses all the functions that you defined in this exercise to place a RoomLabel block each time you specify a point in the drawing:

Open the roomlabel.lsp file with Notepad (Windows) or TextEdit (Mac OS), if it is not already open.

In the text editor area of the roomlabel.lsp file, type the following:; Prompts the user for an insertion point and room number (defun c:RoomLabel ( / lastNumber lastPrefix entityName roomLabelEntry val newNumber newPrefix roomLabelEntry mySettings) ; Gets the custom dictionary "My_Custom_Program_Settings" if it exists (setq mySettings (cdr (assoc -1 (dictsearch (namedobjdict) "My_Custom_Program_Settings")))) ; Defines initial values (setq lastNumber 101 lastPrefix "L") ; If the dictionary exists, gets the last used room number (if (/= mySettings nil) (progn ; Gets the last room number from the "RoomLabel" key entry (if (/= (setq roomLabelEntry (dictsearch mySettings "RoomLabel")) nil) (progn ; Gets the previously stored number and prefix (setq lastNumber (cdr (assoc 71 roomLabelEntry))) (setq lastPrefix (cdr (assoc 1 roomLabelEntry))) ) ) ) (progn ; Creates the new "My_Custom_Program_Settings" (setq entityName (entmakex (list (cons 0 "DICTIONARY") (cons 100 "AcDbDictionary")))) (setq mySettings (dictadd (namedobjdict) "My_Custom_Program_Settings" entityName)) ) ) ; If no "RoomLabel" entry exists, creates one based on the defaults (if (= roomLabelEntry nil) (progn (dictadd mySettings "RoomLabel" (entmakex (list (cons 0 "XRECORD")(cons 100 "AcDbXrecord") (cons 1 lastPrefix)(cons 71 lastNumber)))) ) ) ; Displays current values (prompt (strcat "\nPrefix: " lastPrefix "\tNumber: " (itoa lastNumber))) (initget "Number Prefix") ; Prompts the user for an insertion point (while (setq val (getpoint (strcat "\nSpecify point for room label (" lastPrefix (itoa lastNumber) ") or change [Number/Prefix]: "))) ; Checks to see if the user provided a keyword or insertion point ; User provided a string (cond ((= (type val) 'STR) (if (= (strcase val) "NUMBER") ; User specified to enter a number (progn (setq newNumber (getint (strcat "\nEnter new room number <" (itoa lastNumber) ">: "))) (if newNumber (setq lastNumber newNumber)) ) ; User specified to enter a new prefix (progn (setq newPrefix (getstring (strcat "\nEnter new room number prefix <" lastPrefix ">: "))) (if newPrefix (setq lastPrefix newPrefix)) ) ) ) ; User provided a point: insert room label block based on values ((= (type val) 'LIST) (RoomLabel_InsertBlkRef val (strcat lastPrefix (itoa lastNumber))) ; Increments number by 1 (setq lastNumber (1+ lastNumber)) ) ) ; Removes and re-creates the "RoomLabel" dictionary entry (dictremove mySettings "RoomLabel") (dictadd mySettings "RoomLabel" (entmakex (list (cons 0 "XRECORD")(cons 100 "AcDbXrecord") (cons 1 lastPrefix)(cons 71 lastNumber)))) ; Displays current values (prompt (strcat "\nPrefix: " lastPrefix "\tNumber: " (itoa lastNumber))) (initget "Number Prefix") ) (princ) )

Click File Save.

Adding Room Labels to a Drawing

The roomlabel.lsp file contains the main roomlabel function, but some of the helper functions you defined in roomlabel.lsp use functions defined in the utility.lsp file.

NOTE

The following steps require a drawing file named ch17_building_plan.dwg. If you didn't download the sample files previously, download them now from this book's web page. Place these sample files in the MyCustomFiles folder within the Documents (or My Documents) folder.

The following steps explain how to use the roomlabel function that is in the roomlabel.lsp file:

Open Ch17_Building_Plan.dwg. Figure 17.2 shows the plan drawing of the office building.

Start the appload command. Load the LSP files roomlabel.lsp and utility.lsp. If the File Loading - Security Concerns message box is displayed, click Load.

At the Command prompt, type roomlabel then press Enter.

At the Specify point for room label (L101) or change [Number/Prefix]: prompt, specify a point inside the room in the lower-left corner of the building. The room-label definition block, Plan_RoomLabel_Anno layer, and My_Custom_Program_Settings custom dictionary are created the first time the roomlabel function is used. The RoomLabel block definition should look like Figure 17.3 when inserted into the drawing.

At the Specify point for room label (L101) or change [Number/Prefix]: prompt, type n and press Enter.

At the Enter new room number <102>: prompt, type 105 and press Enter.

At the Specify point for room label (L105) or change [Number/Prefix]: prompt, type p and press Enter.

At the Enter new room number prefix <L>: prompt, type R and press Enter.

At the Specify point for room label (R105) or change [Number/Prefix]: prompt, specify a point in the large open area in the middle of the building.

Press Enter to end roomlabel.

Save the drawing with the name RoomLabel Test.dwg , and then close the file.

Open RoomLabel Test.dwg, and load the roomlabel.lsp and utility.lsp files.

Start the roomlabel function. Press F2 on Windows or Fn-F2 on Mac OS. Notice the current values being used are 106 for the number and a prefix of R, which are the values you used before closing the drawing.

Add additional room labels and close the drawing when done.

Figure 17.2 Plan view of the office building

Figure 17.3 Inserted RoomLabel block