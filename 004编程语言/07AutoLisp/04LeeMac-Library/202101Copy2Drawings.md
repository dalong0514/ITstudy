# 202101Copy2Drawings

[Free LISP Programs | Lee Mac Programming](http://www.lee-mac.com/programs.html)

[Copy to Drawings | Lee Mac Programming](http://www.lee-mac.com/copytodrawing.html)

## Program Description

This program enables the user to copy a selection of objects to a selected set of drawings, without opening the drawings in the AutoCAD Editor.

Upon issuing the command syntax c2dwg at the AutoCAD command-line, the program will first prompt the user to make a selection of objects residing in the active drawing layout that are to be copied.

Following a valid selection of the objects, the program utilises my Get Files Dialog function and will present the user with a dialog interface where the user may compile a list of drawings (dwg/dwt/dws) to which the selected objects will be copied.

The program will then proceed to copy every object in the selection to each selected drawing, using an ObjectDBX interface if the drawing unopened.

The program will retain all information associated with each copied object, including the position, scale, rotation, etc. Properties such as layers & linetypes will be imported if not already present in the external drawing. Similarly, the drawing layout in which the source objects reside will be created if not already present in the external drawing.

The program is compatible for use with all drawing objects (including XRefs, Attributed Blocks & Dynamic Blocks) with the exception of Viewports.

After copying the set of objects to each drawing, the program will save the external drawing. Due to a restriction on the saveas method when invoked through an ObjectDBX interface, all drawings will be saved to the native format, i.e. the latest version available — this is unfortunately unavoidable.

Note that when saving drawings through ObjectDBX, drawing file thumbnails will be lost until the next manual save.