## 0101Utils-DumpObject

[Dump Object | Lee Mac Programming](http://www.lee-mac.com/dumpobject.html)

### Program Description

This is a very simple utility to enable the user to list the ActiveX properties & methods of a VLA-Object.

The function will accept as an argument a VLA-Object, Entity Name, Handle, or an Entity DXF List and will proceed to use the AutoLISP vlax-dump-object function to list the ActiveX properties & methods of the supplied object or VLA-Object equivalent of the supplied Entity, Handle, or DXF List.

The utility also permits the user to select primary or nested objects by typing dump or dumpn respectively at the AutoCAD command line.

### Example of Output

The following output was the result of supplying the LM:dump function with a VLA Circle Object constructed in the WCS plane at zero elevation, centered at the origin, with radius 1.