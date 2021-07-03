# 202108. MLines2PLines

## Program Description

This is quite a simple program, but having seen it requested quite frequently, I thought it best to include it on my site.

The program will prompt the user for a selection of Multilines (MLines) and proceed to convert these to LWPolylines. The method utilised by the program is to iterate through the selection set of MLine entities, and, for each entity in turn, explode the MLine and populate a selection set with the resultant Line entities to be used with the Polyline Join command.

1-3『这个功能的源码对照「202106MPlineV1-1」功能的源码一起看，后者是作者 2015 重构后的代码，有一部分的功能与此很相似，可以借鉴。（2021-06-23）』