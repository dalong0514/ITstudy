# 0212Areas2Field

[Areas to Field | Lee Mac Programming](http://www.lee-mac.com/areastofield.html)

## Program Description
This program allows a user to create an MText object containing a Field Expression referencing the area, or sum of areas, of one or more selected objects.

Upon issuing the command syntax A2F at the AutoCAD command-line, the user is prompted to make a selection of objects for which to retrieve the area; if more than one object is selected, the cumulative area for all objects will be displayed by the resultant MText Field.

Following object selection, the user is prompted to pick a point at which to create the MText Field. If the specified point resides within an AutoCAD table cell, the program will populate the table cell with the appropriate Field Expression.

The Field will display the sum of the areas of the selected objects, formatted using the Field formatting code specified at the top of the program - this formatting code may be altered to suit the user's requirements and is described in more detail below.


## Area Format
The field formatting code indicated at the top of the program source code (line 14) may be altered to display the area in a desired format:

(setq fmt "%lu6%qf1") ;; Field Formatting
To determine the correct formatting code to be used, perform the following steps:

Type FIELD at the AutoCAD command-line and press ENTER to open the Field dialog.
Select Objects from the 'Field Category' drop-down menu.
Select Object from the 'Field Names' section.
Select an object (with area) from the drawing by clicking the object selection button adjacent to the 'Object Type' box.
Select the Area property from the 'Property' panel.
Configure the formatting options as desired.
Click OK and pick a point in the drawing to create a temporary MText Field.
Download & load my Field Formatting Code program.
Type fieldformat to run the program and select the temporary MText Field created earlier.
Following a valid selection, the field formatting code will be printed to the command-line, e.g.:
Formatting code: "%lu4%ds44%th39"
Copy the formatting code (including the quotation marks) to the program source code where noted:
(setq fmt "%lu4%ds44%th39") ;; Field Formatting
Save and load the modified program file.
See also Length & Area Field.

1-2『发现示例里，图形的大小改变后面积数值自动更新了，这个源码里可能有实现「监听」的线索，待研究。（2021-06-24）』—— 已完成