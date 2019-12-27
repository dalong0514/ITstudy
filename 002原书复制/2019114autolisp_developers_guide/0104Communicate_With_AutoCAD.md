# 0104. About Using AutoLISP to Communicate With AutoCAD (AutoLISP)

[Pomoc: Introduction (AutoLISP)](http://help.autodesk.com/view/OARX/2018/PLK/?guid=GUID-A0E9D801-8BE9-4BF1-85E8-3807E15F3B71)

Query and command functions provide direct access to AutoCAD commands and drawing services.

AutoLISP ® provides various functions for examining the contents of the currently loaded drawing. This chapter introduces these functions and describes how to use them in conjunction with other functions.

## 01. About Accessing Commands and Services (AutoLISP)

The query and command functions described in this section provide direct access to AutoCAD ® commands and drawing services. Their behavior depends on the current state of the AutoCAD system and environment variables, and on the drawing that is currently loaded. See Query and Command Functions (AutoLISP) in AutoLISP Function Synopsis (AutoLISP), for a complete list of query and command functions.

### 1. About Using AutoCAD Commands (AutoLISP)

AutoLISP can execute a built-in AutoCAD command or one that is defined in a loaded ObjectARX or Managed .NET application.

Note: AutoCAD for Mac does not support Managed .NET applications.
The command and command-s functions allow you to start and pass values to an AutoCAD command. The command and command-s functions have a variable-length argument list. The first argument of these functions must be the command you want to execute. All other arguments must correspond to the types and values expected by that command's prompt sequence; these may be strings, real values, integers, points, entity names, or selection set names. Data such as angles, distances, and points can be passed either as strings or as the values themselves (as integer or real values, or as point lists). An empty string ("") is equivalent to pressing the Spacebar or Enter on the keyboard.

The command-s function is faster and more efficient than the command function, but the command being executed within the command-s function must be completed within the same statement. This means that an argument must be provided for each of the command’s prompts, and that it cannot execute any more AutoLISP statements until the function has completed. Unlike the command-s function, you can use AutoLISP functions within the command function and the command that is being executed does not need to be completed to continue execution of the program.

There are some restrictions on the commands that you can use with the command and command-s functions.

The following code fragment shows representative calls to command.

(defun c:CircC ()
  (command "._circle" "0,0" "3,3")
  (command "._thickness" 1)
  (command "._circle" PAUSE PAUSE)
 (princ)
)
When the CircC command is loaded and executed at the AutoCAD Command prompt, the following actions occur:

The first call to command passes points to the CIRCLE command as strings (draws a circle centered at 0.0,0.0 and passes through 3.0,3.0).
The second call to command passes an integer to the THICKNESS system variable (changes the current thickness to 1.0).
The last call to command prompts the user for a center point and then the radius of the circle.
The following code fragment shows representative calls to command-s.

(defun c:CircCS ( / p1 rad)
  (command-s "._circle" "0,0" "3,3")
  (command-s "._thickness" 1)
  (setq p1 (getpoint "\nEnter a center point: "))
  (setq rad (getdist p1 "\nEnter a radius: "))
  (command-s "._circle" p1 rad)
 (princ)
)
The CircCS command is similar to CircC except it prompts the user for a center point and radius before making the last call to the command-s function. With the command-s function, you should avoid the use of the PAUSE token.

Topics in this section
About Foreign Language or International Support (AutoLISP)
AutoLISP programs can be used in an AutoCAD release that supports a language other than the original language the program was developed for.
About Pausing for User Input During an AutoCAD Command (AutoLISP)
The PAUSE symbol can be used in the command function to interrupt the execution of an AutoCAD command and have the user provide input.
About Passing Pick Points to AutoCAD Commands (AutoLISP)
Some AutoCAD commands (such as TRIM, EXTEND, and FILLET) require the user to specify a pick point as well as the object itself.
About Undoing Changes Made by a Routine (AutoLISP)
Grouping multiple AutoLISP statements together under a single UNDO group allows you to rollback all the actions performed by using either the AutoCAD U or UNDO commands.

#### 01. About Foreign Language or International Support (AutoLISP)

AutoLISP programs can be used in an AutoCAD release that supports a language other than the original language the program was developed for.

The standard AutoCAD commands and keywords used in an AutoLISP program can be automatically translated if you precede each command or keyword with an underscore (_).

(command "_line" pt1 pt2 pt3 "_c")
If you are using the dot prefix (to avoid using redefined commands), you can place the dot and underscore in either order. Both "._line" and "_.line" are valid.

Note: It is recommended to always add an underscore (_) in front of a command name or keyword when using the command or command-s functions; this will help your program to work as expected when executed in a language other than it was originally targeted for.

#### 02. About Pausing for User Input During an AutoCAD Command (AutoLISP)

The PAUSE symbol can be used in the command function to interrupt the execution of an AutoCAD command and have the user provide input.

If an AutoCAD command is in progress and the predefined symbol PAUSE is encountered as an argument to command, the command is suspended to allow direct user input (usually point selection or dragging). This is similar to the backslash pause mechanism provided for menus.

The PAUSE symbol is defined as a string consisting of a single backslash. When you use a backslash ( \ ) in a string, you must precede it by another backslash ( \\ ).

Note: You can use two backslashes ( \\ ) instead of the PAUSE symbol. However, it is recommended that you always use the PAUSE symbol rather than the explicit use of two backslashes. Also, if the command function is invoked from a menu item, the backslash suspends the reading of the menu item, which results in partial evaluation of the AutoLISP expression.
For example, the following code begins the CIRCLE command, sets the center point at (5,5), and then pauses to let the user drag the circle's radius. When the user specifies the desired point (or types in the desired radius), the function resumes, and a line is drawn from (5,5) to (7,5), as follows:

(command "._circle" "5,5" pause "._line" "5,5" "7,5" "")
If PAUSE is encountered when a command is expecting input of a text string or an attribute value, AutoCAD pauses for input only if the AutoCAD TEXTEVAL system variable is nonzero. Otherwise, AutoCAD does not pause for user input but uses the value of the PAUSE symbol (a single backslash).

When the command function pauses for user input, the function is considered active, so the user cannot enter another AutoLISP expression to be evaluated.

The following example code uses the PAUSE symbol to allow the user to specify the block’s insertion point. The layer NEW_LAY and block MY_BLOCK must exist in the drawing prior to testing this code.

(setq blk "MY_BLOCK")
(setq old_lay (getvar "clayer"))
(command "._-layer" "set" "NEW_LAY" "")
(command "._-insert" blk PAUSE "" "" PAUSE)
(command "._-layer" "set" old_lay "")
The preceding code fragment sets the current layer to NEW_LAY, pauses for an insertion point for the block MY_BLOCK (which is inserted with X and Y scale factors of 1), and pauses again for a rotation angle. The current layer is then reset to the previous layer.

If the command function specifies a PAUSE with the AutoCAD SELECT command and the AutoCAD PICKFIRST system variable set is active, the SELECT command obtains the objects selected before the command is executed and does not pause for the user to select objects.

Note: The Radius and Diameter subcommands of the AutoCAD DIM command issue additional prompts in some situations. This can cause a failure of AutoLISP programs written prior to Release 11 that use these subcommands.
Using Transparent Commands
If you issue a transparent command while a command function is suspended, the command function remains suspended. Therefore, users can 'ZOOM and 'PAN while a command is at a pause. The pause remains in effect until AutoCAD gets valid input, and transparent command ends.

The following shows the results of using the ZOOM command transparently when the command function allows the user to provide a radius for the circle:

Command: (command "._circle" "5,5" PAUSE "._line" "5,5" "7,5" "")

circle

Specify center point for circle or [3P/2P/Ttr (tan tan radius)]: 5,5

Specify radius of circle or [Diameter]: 'zoom

>>Specify corner of window, enter a scale factor (nX or nXP), or [All/Center/Dynamic/Extents/Previous/Scale/Window/Object] <real time>:

>>Press ESC or ENTER to exit, or right-click to display shortcut menu.

Resuming CIRCLE command.

Specify radius of circle or [Diameter]:

Command: line

Specify first point: 5,5

Specify next point or [Undo]: 7,5

Specify next point or [Undo]:

Command: nil

Accepting Menu Input
Menu input is not suspended when PAUSE is used by the command function. If a menu item is active when the command function pauses for input, that input request can be satisfied by the menu. If you want the menu item to be suspended as well, you must provide a backslash in the menu item. When valid input is provided, both the command function and the menu item resume.

#### 03. About Passing Pick Points to AutoCAD Commands (AutoLISP)

Some AutoCAD commands (such as TRIM, EXTEND, and FILLET) require the user to specify a pick point as well as the object itself.

Object and point data can be passed to the command and command-s functions without the use of a PAUSE, but requires you to first store the values as variables. Points can be passed as strings within the command and command-s functions, or can be defined outside the function and passed as variables, as shown in the following example.

The following example code demonstrates one method of passing an entity name and a pick point to the command function.

(command "._circle" "5,5" "2")    ;Draws a circle
(command "._line" "3,5" "7,5" "") ;Draws a line
(setq el (entlast))               ;Gets the last entity 
                                  ;  added to the drawing
(setq pt '(5 7))                  ;Sets the trim point
(command "._trim" el "" pt "")    ;Performs the trim
If AutoCAD is at an idle Command prompt when these statements are called, AutoCAD performs the following actions:

Draws a circle centered at (5,5) with a radius of 2.
Draws a line from (3,5) to (7,5).
Creates a variable el that is the name of the last object added to the database.
Creates a pt variable that is a point on the circle. (This point selects the portion of the circle to be trimmed.)
Performs the TRIM command by selecting the el object (the line) and by selecting the point specified by pt.

#### 04. About Undoing Changes Made by a Routine (AutoLISP)

Grouping multiple AutoLISP statements together under a single UNDO group allows you to rollback all the actions performed by using either the AutoCAD U or UNDO commands.

Each command executed with the command and command-s functions explicitly creates its own UNDO group. If a user enters U (or UNDO) at the AutoCAD Command prompt after running an AutoLISP routine, only the last command will be undone. Additional uses of UNDO will step backward further through the commands used in that routine. Users of your routine will expect that all of the operations that it performs can be undone in a single operation, instead of having to undo multiple operations to get back to the previous state of the drawing.

It is recommended to group the commands and operations performed by an AutoLISP routine into a single UNDO group, or if your routine allows the user to repeat operations you might even create UNDO groups for each time the user’s response affects the drawing. You can define an UNDO group by using the Begin and End options of the AutoCAD UNDO command.

The following example code demonstrates how each command executed with the command function has its own UNDO group.

(defun c:NoUndo ( / old_osmode el pt)
  (setq old_osmode (getvar "OSMODE"))
  (setvar "OSMODE" 0)
  (command "._circle" "5,5" "2")    ;Draws a circle
  (command "._line" "3,5" "7,5" "") ;Draws a line
  (setq el (entlast))               ;Gets the last entity added 
                                    ; to the drawing
  (setq pt '(5 7))                  ;Sets the trim point
  (command "._trim" el "" pt "")    ;Performs the trim
  (setvar "OSMODE" old_osmode)
)
After running the c:NoUndo routine, you will see a semi-circle. Issuing the U or UNDO command after running the c:NoUndo routine results in the AutoCAD TRIM command being undone; you should now see a full circle with a line running through its center. Executing the U or UNDO command again results in the line being undone that was created with the AutoCAD LINE command. A third use of the U or UNDO command results in the AutoCAD CIRCLE command being undone.

The following example code demonstrates how the AutoCAD UNDO command can be used to create an UNDO group that allows the user to rollback all changes back with a single U (or UNDO) command.

```
(defun c:YesUndo ( / old_osmode el pt)
  (command "._UNDO" "_Begin")
  (setq old_osmode (getvar "OSMODE"))
  (setvar "OSMODE" 0)
  (command "._circle" "5,5" "2")    ;Draws a circle
  (command "._line" "3,5" "7,5" "") ;Draws a line
  (setq el (entlast))               ;Gets the last entity added
                                    ; to the drawing
  (setq pt '(5 7))                  ;Sets the trim point
  (command "._trim" el "" pt "")    ;Performs the trim
  (setvar "OSMODE" old_osmode)
  (command "._UNDO" "_End")
)
```

After running the c:YesUndo routine, you will see a semi-circle just like with the c:NoUndo routine. Issuing the U or UNDO command after running the c:YesUndo routine results in the AutoCAD TRIM, LINE, and CIRCLE commands being undone.

### 2. About System and Environment Variables (AutoLISP)

AutoLISP applications can inspect and change the value of AutoCAD system variables with the getvar and setvar functions.

These functions use a string to specify the variable name. The setvar function requires a second argument that specifies the new value the system variable. AutoCAD system variables accept and return various data types: integers, reals, strings, 2D points, and 3D points.

Values supplied as arguments to setvar must be of the expected type. If an invalid type is supplied, an AutoLISP error is generated.

The following example code demonstrates how to get and set the value of the AutoCAD FILLETRAD system variable:

(if (< (getvar "filletrad") 1)
  (setvar "filletrad" 1)
)
Additional functions, getenv and setenv, provide AutoLISP routines with access to the currently defined operating system environment variables. Unlike system variable names, environment variable names are case specific. For example, MaxHatch and MAXHATCH are not the same. When using the setenv function, you always supply the new value as a string even if it might be a numeric value.

The following example code demonstrates how to set the MaxHatch environment variable:

(setq curMaxHatch (getenv "MaxHatch"))
(prompt (strcat "\nCurrent value of MaxHatch: " curMaxHatch))
(setenv "MaxHatch" "50000")
(prompt (strcat "\nNew value of MaxHatch: " (getenv "MaxHatch")))
(setenv "MaxHatch" curMaxHatch)

### 3. About Configuration Files (AutoLISP)

AutoCAD uses a configuration file with the name acadxxxx.cfg to store device and application information.

The xxxx in the file name refers to the AutoCAD release number. The AppData section of this file is provided for users and developers to store configuration information pertaining to their applications. The getcfg and setcfg functions allow AutoLISP applications to inspect and change the value of parameters in the AppData section.

The setcfg function requires two strings that represent the section and parameter, and the value to assign. The value returned by setcfg is nil if the value could not be stored or the value that was being assigned to the parameter. The getcfg function requires the section and parameter to retrieve a value from and returns the value if the parameter exists.

The following code creates a section under AppData named ArchStuff with a parameter titled WallThk. The value of ”8” is then assigned to WallThk.

(setcfg "AppData/ArchStuff/WallThk" "8")
"8"
The following code returns the value assigned to the specified section and parameter.

(getcfg "AppData/ArchStuff/WallThk")
"8"
Note: It is recommend to store values in the Windows Registry or the AutoCAD property list (HKCU.plist and HKLM.plist) files on Mac OS. This can be done using the vl-registry-read and vl-registry-write functions.

