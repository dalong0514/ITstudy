# 202107. Polyline Programs

[Polyline Programs | Lee Mac Programming](http://www.lee-mac.com/polylineprograms.html)

Here I offer a selection of short, useful programs for manipulating polylines in AutoCAD.

The program available for download above defines three custom commands which enable the user to manipulate a set of selected polylines in various ways.

Each command is described in more detail below, with an accompanying animation to demonstrate the program.

## Polyline Join

This program is effectively a wrapper for the standard AutoCAD PEDIT command, allowing the user to join multiple sets of lines, arcs & polylines without needing to traverse the various prompts issued by the standard command.

Upon issuing the command syntax PJ at the AutoCAD command-line, the program will prompt the user for a selection of lines, arcs and/or polylines; following any necessary conversion to polylines, the program will attempt to join the selected objects to form continuous polylines.

The progam is configured to use the JOIN option of the PEDIT command with a zero fuzz distance, however, this may be easily altered if necessary.

## Polyline Close

Upon issuing the command syntax PC at the AutoCAD command-line, this simple program will prompt the user for a selection of open polylines and will proceed to close all polylines in the selection.

## Polyline Width

Upon issuing the command syntax PW at the AutoCAD command-line, this program will first prompt the user for a selection of polylines, followed by a width to be applied to all segments of each polyline in the selection.

At this prompt, a default zero-width value is offered.

