# Add Objects to Block

[Add Objects to Block | Lee Mac Programming](http://www.lee-mac.com/addobjectstoblock.html)

## Program Description

This program enables the user to add a selection of objects to the definition of a selected block.

Upon issuing the command syntax addtoblock at the AutoCAD command line, the program prompts the user for a selection of objects residing on unlocked layers to be added to a chosen block definition.

Following a valid selection, the program prompts the user to select a reference of a block whose definition is to be modified to incorporate all objects in the selection. At this prompt, the program will permit selection of any standard (non-dynamic) uniformly scaled block reference which is not referenced within the selection (as a block reference cannot be added to its own definition).

Every object in the selection is then transformed relative to the position, scale, rotation, and orientation of the selected block reference, before being copied to the definition of the block and removed from the drawing.

