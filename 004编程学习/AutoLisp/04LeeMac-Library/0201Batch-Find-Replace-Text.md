## Batch Find & Replace Text

[Batch Find & Replace Text - AutoLISP, Visual LISP & DCL - AutoCAD Forums](https://www.cadtutor.net/forum/topic/19484-batch-find-amp-replace-text/)

This program uses ObjectDBX to perform multiple text replacements on the current drawing or a complete directory (and subdirectories) of drawings. The program has the ability to search Text, MText, Block Attributes, Multileader Text, Table Cell Text and Dimension Override Text.

The user may replace multiple search strings, and load & save lists of search strings for future use, saving time in program data entry.

Users may perform a complete Find & Replace operation, or merely search for potential replacements using the 'Search Only' option. Following a search operation, a report is displayed informing the user of the replacements which would be performed should the user proceed with the replacement. The report also displays the object containing the text to be replaced, along with the entity handle of such object, and the drawing filename in which the object resides.

The program provides the user additional refinement options, as displayed in the Options Dialog. This enables the user to control which objects are searched, whether locked layers are included in the replacement, search item case-sensitivity and whether the search item must appear as a complete word to be replaced.

The generation of a report following a text replacement may also be controlled within the Options Dialog (the report will always be created following a search operation).

[Batch Find & Replace Text - AutoLISP, Visual LISP & DCL - AutoCAD Forums](https://www.cadtutor.net/forum/topic/19484-batch-find-amp-replace-text/)

### 01. Program Description

This program uses ObjectDBX to perform multiple text replacements in the current drawing, all open drawings, or across a complete directory (and optionally subdirectories) of drawings. The program has the ability to search Text, MText, Block Attributes, Multileader Text, Table Cell Text, Dimension Override Text and all of these items within Block Definitions.

The user may replace multiple search strings, and load & save lists of search strings for future use, saving time in program data entry.

Users may perform a complete Find & Replace operation, or merely search for potential replacements using the 'Search Only' option. Following a search operation, a report is displayed informing the user of the replacements which would be performed should the user proceed with the replacement. The report also displays the object containing the text to be replaced, along with the entity handle of the object, and the drawing filename in which the object resides.

The program provides the user with additional refinement options, as displayed in the Options Dialog. This enables the user to control which objects are searched, whether locked layers are included in the replacement, search item case-sensitivity and whether the search item must appear as a complete word to be replaced. The user can also restrict the search to Model space, Layout space or both.

The generation of a report following a text replacement may also be controlled within the Options Dialog (the report will always be created following a search operation).

### 02. Dialog Preview

### 03. Known Restrictions

Please be aware that the BFind application is not entirely bug-free, and I would advise against its usage in conjunction with MText objects to which multiple style overrides have been applied through the MText Editor. However, it should, in most cases, perform successfully.

Below is an incomplete list of known issues:

#### Save Format

All drawings processed by the application will be saved to 'native' format (that is, the highest version available in the host application - i.e. running the program in AutoCAD 2011 will cause all drawings to be saved to 2010 format, or running in AutoCAD 2013 will save drawings to 2013 format).

The ActiveX save method (equivalent to the AutoCAD QSAVE command) is unavailable when interfacing with drawings through ObjectDBX, and so programs must use the saveas method to save any changes performed to the drawing database. Usually this method accepts a drawing version parameter which allows the method to save the drawing in the same format as configured in the AutoCAD 'Options' menu, however, due to a bug with this method when used in conjunction with ObjectDBX, the method will not accept the version parameter.

#### Position of Non-Left Justified Attributes

When using an ObjectDBX interface to modify the content of attribute references which do not have justification set to 'Left', there is a known bug which results in the attribute position not being updated following a change to the text field length (e.g. extending the text content of middle-center justified attributes will cause the attributes to become positioned off-center to the right).

A function has been included in the application which attempts to adjust the attribute position to account for this issue, however, this function is not 100% effective and a slight change in attribute position may be apparent. Note that the attribute position will be correctly updated when the attribute is next edited manually.

To modify attribute values without encountering this issue, please use my script-based Batch Attribute Editor program.

#### Drawing Thumbnails

Due to another known bug with the ObjectDBX interface, drawing thumbnails are lost when drawings are saved by the application. Drawing file thumbnails are fully restored following the next 'manual' save.

#### Curly Braces

The application is unable to search for the curly brace characters { and }.

#### Wildcards

The program does not currently support the use of wildcard patterns in search terms.