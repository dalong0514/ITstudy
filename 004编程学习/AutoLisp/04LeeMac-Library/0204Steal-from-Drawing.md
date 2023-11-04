# 202102. Steal from Drawing

[已解决: Insert block from external dwg - Autodesk Community - AutoCAD](https://forums.autodesk.com/t5/visual-lisp-autolisp-and-general/insert-block-from-external-dwg/m-p/8884063#M386988)

[Import Block | Lee Mac Programming](http://www.lee-mac.com/copyblockfromdrawing.html)

[Copy or Rename Block Reference | Lee Mac Programming](http://www.lee-mac.com/copyblock.html)

[Steal from Drawing | Lee Mac Programming](http://www.lee-mac.com/steal.html)

## Program Overview

This program allows the user to import (humourously: 'steal') items from another drawing into the current drawing.

Upon running the program with the command syntax 'Steal' at the AutoCAD command-line, the user is prompted to select a drawing file (dwg/dwt/dws) from which to steal items. Following a valid selection, if the selected drawing contains items not already present in the current drawing, a dialog will appear displaying items available for import.

The user may choose multiple items from a list of:

```
Blocks
Layers
Linetypes
Dimension Styles
Text Styles
Table Styles
MLeader Styles
MLine Styles
Layouts
Page Setups
User Coordinate Systems
Named Groups
Views
Layer States
Scales
Materials
Named Viewports
Drawing Properties
Custom Properties
```

The above collections are listed in the left-hand list panel of the dialog, and items within each selected collection are listed to the right.

The interface allows the user to import multiple items from several collections without exiting or restarting the program, since the dialog will remain until either the user presses the Done button, or there is nothing left to import from the selected drawing.

The user may update the data displayed in the dialog by pressing the Refresh button located in the top-left corner of the dialog. A refresh of the drawing data may be required after importing items such as blocks since these items may have object dependencies (such as layers, linetypes, and other block definitions dependent upon the constituent objects of the imported block) which are also be imported to the active drawing.

The user may also search the collections for a specific item to import using the search panel to the bottom of the dialog. The search is not case-sensitive and may use wildcards.

## Available Commands

Steal — The standard program. The user is prompted to select a drawing file (dwg/dwt/dws) and may proceed to select from a list of items to import to the active drawing.

Steal All — The program may also be called with the command `StealAll` which will prompt the user to select a drawing file then proceed to automatically steal everything from the selected drawing.

Steal Last — The `StealLast` command allows the user to steal items from the last selected drawing, if a last drawing exists and can be located, else the user is prompted to select a drawing as per the standard command.

Steal Template — Another command: `StealTemplate` will attempt to locate and interface with the QNew template file, or, if the QNew template is not set, will allow the user to select from a list of template files residing in the template drawing path. If no template files are found, the file selection dialog will appear as per the standard command.

Steal Templates — The `StealTemplates` command allows the user to import items from a specific template file selected from a list of template files found in the template drawing path. If no template files are found, the file selection dialog will appear as per the standard command.

## Dialog Preview

## Calling the Program as a Subfunction

Function Syntax	

```c
(Steal <Drawing Filename> <Item List>)
```

dwg — String, Filename of drawing from which to import items.

lst — List, List of items or wildcard patterns to import from drawing, in the format described below.

returns — The return of this function is undefined.

A list of items to be imported, in the following format:

```c
(
    (   <Collection 1>
        (<Item 1> <Item 2>  ...  <Item N>)
    )
    (   <Collection 2>
        (<Item 1> <Item 2>  ...  <Item N>)
    )
    ...
    (   <Collection N>
        (<Item 1> <Item 2>  ...  <Item N>)
    )
)
```

Where Collection is the name of a collection of items, and may be one of the following keywords:

```
"Blocks"
"Layers"
"Linetypes"
"Text Styles"
"Dimension Styles"
"Layouts"
"Views"
"Materials"
"Viewports"
"Page Setups"
"User Coordinate Systems"
"Groups"
"Drawing Properties"
"Custom Properties"
"Multileader Styles"
"Multiline Styles"
"Table Styles"
"Scales"
"Layer States"
```

Note that the collection keyword is not case-sensitive.

'Item 1' ... 'Item N' are the names of specific items or wildcard patterns to match a number of items to be imported into the current drawing. Note that these are also not case-sensitive.

## Examples

The following example will attempt to import Layers: 'Layer1' & 'Layer2', and all Dimension Styles beginning with DimStyle from the drawing: 'C:\My Folder\MyDrawing.dwg' into the current drawing.

```c
(Steal "C:\\My Folder\\MyDrawing.dwg"
   '(
        (
            "Layers"
            ("Layer1" "Layer2")
        )
        (
            "Dimension Styles"
            ("DimStyle*")
        )
    )
)
```

Note that both arguments are optional, hence the program may be called...

```c
(Steal nil
   '(
        (
            "Layers"
            ("Layer1" "Layer2")
        )
        (
            "Dimension Styles"
            ("DimStyle*")
        )
    )
)
```

...to prompt for a drawing from which to extract specific items, or...

```c
(Steal "C:\\My Folder\\MyDrawing.dwg" nil)
```

...to prompt for items to extract from a specific drawing.
