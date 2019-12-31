# Chapter 15 Requesting Input and Using Conditional and Looping Expressions

Using static values in a custom AutoLISP® program can be helpful in automating tasks, but it also limits the functionality that can be introduced by custom AutoLISP programs. Using static values doesn't give the user the ability to specify a custom value, such as the insertion point of a block or which objects to modify. AutoLISP provides many functions that allow you to request input at the Command prompt or with controls in a dialog box. I cover working with dialog boxes in Chapter 23,「Implementing Dialog Boxes (Windows only).」

When requesting input from a user, you should verify the input provided from the user before acting upon it. Comparison and logical grouping operators can be used to create test conditions and validate a value or grouping of values. Test conditions can be used to control which expressions are executed or specify the number of times a set of AutoLISP expressions might be executed as part of a looping expression.

In this chapter, you will learn to get input at the Command prompt and provide information back to the user in the form of messages. Additionally, you will learn to use conditional and looping expressions to perform actions based on the result of a test condition.

Interacting with the User

You've learned that you can use the PAUSE predefined variable with the command function to allow the user to provide a value. PAUSE works great for providing a response to the current prompt of the active command, but it is also a limitation. Any value provided in response to PAUSE is passed directly to the command and can't be captured or manipulated by your AutoLISP program.

There will be times when using PAUSE with the command function isn't enough for your programs. The AutoLISP programming language contains several functions that are available for requesting input. The values returned by the user can then be validated using test conditions. I explain how to create test conditions with comparison and logical grouping operators later, in the「Conditionalizing and Branching Expressions」section.

In addition to getting input from the user, a custom program can provide feedback to the user, letting them know the current state of a program or when an error occurred. Feedback can be of two different types: textual and graphical. Textual feedback can be in the form of messages at the Command prompt or in a message box, whereas graphical feedback might be temporary graphics drawn in the drawing area.

Requesting Input at the Command Prompt

AutoLISP provides functions that allow you to request input from the user at the Command prompt. Input requested can be any of the following:

Integer

Real

String or keyword

2D point or 3D point list

Object or entity name (see Chapter 16,「Creating and Modifying Graphical Objects」)

Before requesting input from the user, you want to define a prompt that should be displayed with the request for input. Prompts are short text messages that give the user an idea what type of input is expected and whether any options are available. I discuss recommended etiquette to use when creating a prompt in the sidebar「Guidelines for Prompts.」

This exercise shows how to draw a plan-view representation of a window based on input from the user:

At the AutoCAD Command prompt, type (setq cur_osmode (getvar "osmode")) and press Enter to store the current value of the osmode system variable.

Type (setvar "osmode" 0) and press Enter.

Type (setq width (getreal "\nEnter window width: ")) and press Enter.

At the Enter window width: prompt, type 36 and press Enter to specify the width for the window that will be drawn.

Type (setq wall_thickness (getreal "\nEnter wall thickness: ")) and press Enter.

At the Enter wall thickness: prompt, type 6 and press Enter to set the depth of the window.

Type (setq base (getpoint "\nSpecify base point: ")) and press Enter.

At the Specify base point: prompt, specify a point in the drawing area at which to start drawing the window.

Type (setq ang (getangle base "\nSpecify rotation: ")) and press Enter.

At the Specify rotation: prompt, specify an angle of rotation for the window.

Type (setq strPt (polar base (+ ang (/ PI 2)) (/ wall_thickness 2))) and press Enter to calculate the midpoint of the window for the start point of the line that will represent the class in the window.

Type (setq endPt (polar strPt ang width)) and press Enter to calculate the endpoint of the line that will represent the class in the window.

Type (command "._rectang" base "_r" (* (/ ang PI) 180) "_d" width wall_thickness endPt) and press Enter to draw the outline of the window in plan view.

Type (command "._line" strPt endPt "") and press Enter to draw the line that represents the glass in the window.

Type (setvar "osmode" cur_osmode) and press Enter to restore the previous value of the osmode system variable. Figure 15.1 shows the results after you complete all the steps in this exercise.

Figure 15.1 Window drawn based on user input

Getting Numeric Values

Numbers play an important role in creating and modifying objects in a drawing, whether it is the radius of a circle or the number of rows in a rectangular array. As I mentioned in Chapter 12,「Understanding AutoLISP,」AutoLISP supports two types of numbers: integers and reals. Integers are whole numbers without a decimal value, and reals are numbers that support a decimal value. You can use the AutoLISP getint and getreal functions to request either an integer or real number value at the Command prompt. The entered number is the value returned by the function, but if the user presses the spacebar or Enter without providing a value, nil is returned. When an incorrect value is provided, the function re-prompts the user to enter a correct value.

The following shows the syntax of the getint and getreal functions:

(getint [prompt]) (getreal [prompt])

The prompt argument represents the textual message to display at the Command prompt when the expression is evaluated. The prompt argument is optional, but I recommend always providing one.

The following are examples of the getint and getreal functions, and the values that are returned:

(getint) Type 1.25 and press Enter Requires an integer value. Type 1 and press Enter 1 (getint) Press Enter nil (setq segments (getint "\nEnter number of line segments: ")) Enter number of line segments: Type 3 and press Enter 3 (getreal) Type 1.25 and press Enter 1.25 (getreal) Type 1 and press Enter 1.0 (setq rotation (getreal "\nEnter angle of rotation: ")) Enter angle of rotation: Type 22.5 and press Enter 22.5

Getting Point List Values

Point lists are used to represent 2D and 3D coordinate values in a drawing. The AutoLISP getpoint function allows the user to pick a point in the drawing area based on an optional base point or type a coordinate value at the Command prompt. When an optional base point is provided, a rubber-band line is drawn from the base point to the current position of the cursor. Figure 15.2 shows the rubber-band line effect used when getting a point based on the optional base point. The specified point is returned by the function, but if the user presses the spacebar or Enter without providing a value, nil is returned.

Figure 15.2 Rubber-band line effect used when specifying a point from a base point

The following shows the syntax of the getpoint function:

(getpoint [base_point] [prompt])

Its arguments are as follows:

base_point The base_point argument determines if a rubber-band line is drawn from the current position of the cursor to the coordinate value specified by the base_point argument. The base_point argument is optional.

prompt The prompt argument represents the textual message to display at the Command prompt when the expression is evaluated. The prompt argument is optional, but I recommend always providing one.

The following are examples of the getpoint function and the values that are returned:

(getpoint) Pick a point in the drawing area or enter a coordinate value (12.5 10.0 0.0) (setq pt1 (getpoint "\nSpecify first point: ")) Specify first point: Pick a point in the drawing area (4.5 9.5 0.0) (setq pt2 (getpoint pt1 "\nSpecify next point: ")) Specify next point: Pick a point in the drawing area (11.0 13.5 0.0)

In addition to the AutoLISP getpoint function, the getcorner function can be used to request a point. There are differences between the getpoint and getcorner functions, though, which are as follows:

The getcorner function requires a base point.

The getpoint function draws a rubber-band line from a base point to the cursor, whereas the getcorner function draws a rectangle from the base point to the cursor, as shown in Figure 15.3.

Figure 15.3 The rubber-band effect used when specifying the opposite corner with the getcorner function

The following shows the syntax of the getcorner function:

(getcorner base_point [prompt])

Its arguments are as follows:

base_point The base_point argument specifies the base point, which is used to define one corner of the rectangle that is displayed when dragging the cursor.

prompt The prompt argument represents the textual message to display at the Command prompt when the expression is evaluated. The prompt argument is optional, but I recommend always providing one.

The following is an example of the getcorner function and the value that is returned:

(setq pt1 (getpoint "\nSpecify first corner: ")) Specify first corner: Pick a point in the drawing area (3.5 6.0 0.0) (setq pt2 (getcorner pt1 "\nSpecify opposite corner: ")) Specify opposite corner: Pick a point in the drawing area (12.5 12.5 0.0)

Getting Distance and Angular Values

While the AutoLISP getreal function can be used to request a distance or angular value, AutoLISP contains several functions to acquire a distance or angular value from the drawing area. The following explains the functions that can be used to request a distance or angular value from the Command prompt.

getdist

The getdist function accepts an optional base point and prompt, just like the getpoint function does. Instead of returning a point list like the getpoint function, getdist returns a real number that represents the distance between the two points or the value the user typed. If the user presses Enter without providing a value, the getdist function returns nil.

The following are examples of the getdist function:

(getdist) Pick a point in the drawing area, enter a coordinate value, or enter a distance Specify second point: If a point was specified, pick or enter a second point 6.80074 (setq pt1 (getpoint "\nSpecify first point: ")) Specify first point: Pick a point in the drawing area (8.0 8.0 0.0) (setq dist (getdist pt1 "\nSpecify second point: ")) Specify second point: Pick a point in the drawing area 7.0

NOTE

The current value of the lunits system variable affects the values the getdist function can accept from the user when entered at the Command prompt instead of specifying two points. The getdist function always accepts decimal values and the formatting expressed by the value of lunits.

The following examples show how the lunits system variable affects the value returned by the getdist function:

; Set LUNITS to 2 (decimal units) (setvar "lunits" 2) (getdist) Type 15 and press Enter 15.0 (getdist) Type 1'-3" or 1'3", and press Enter Requires numeric distance or two points. ; Set LUNITS to 4 (archiectural units) (setvar "lunits" 4) (getdist) Type 1'-3" and press Enter 15.0

TIP

You can use the distof function to convert to a real number a string that is formatted as one of the supported linear distance formats. You can also use the rtos function to convert a real number to a formatted linear distance string when you want to add a real value that is stored in a variable to a prompt or message. For example, if you want the previous value to be displayed in a prompt, you must convert the value to a string before concatenating the value with a long string. I discussed the distof and rtos functions in Chapter 13,「Calculating and Working with Values.」

getangle

The getangle function accepts an optional base point and prompt, just like the getpoint and getdist functions do. Instead of returning a point list or a distance value, getangle returns a real number that represents the angle of measurement expressed in radians between two points. The user can also enter an angular value based on the current units of the drawing; the entered value is converted to and returned as radians. The aunits system variable determines the current angular units for the drawing.

The value returned by the getangle function, whether specified by picking points or entered directly at the Command prompt, is affected by the angdir system variable. If the user presses Enter without providing a value, the getangle function returns nil.

The following are examples of the getangle function:

(getangle) Pick a point in the drawing area, enter a coordinate value, or enter an angle Specify second point: If a point was specified, pick or enter a second point 0.605545 (getangle "\nEnter angle: ") Enter angle: Type 45 and press Enter 0.785398 (setq pt1 (getpoint "\nSpecify first point: ")) Specify first point: Pick a point in the drawing area (5.5 6.5 0.0) (setq rad (getangle pt1 "\nSpecify second point: ")) Specify second point: Pick a point in the drawing area 0.885067

NOTE

The current value of the aunits system variable affects the value that can be entered at the Command prompt by the user—not specified by two points—when the getangle and getorient functions are used. For example, entering 45 is not the same for decimal, gradian, and radian angular units.

The following examples show how the aunits system variable affects the value returned by the getangle function:

; Set AUNITS to 0 (decimal degrees) (setvar "aunits" 0) (getangle) Type 45 and press Enter 0.785398 ; Set AUNITS to 2 (gradian units) (setvar "aunits" 2) (getangle) Type 45 (45 decimal degrees) and press Enter 0.706858 (getangle) Type 50g (45 degrees) and press Enter 0.785398

TIP

You can use the angtof function to convert a string that is formatted as one of the supported angular formats to a real number. You can also use the angtos function to convert a real number to a formatted angular string so the value can be displayed as part of a prompt or message to the user. I discussed the angtof and angtos functions in Chapter 13.

getorient

The getorient function accepts an optional base point and prompt, and it's similar to the getangle function. The value returned by the getorient function is a real number that represents the angle of measurement expressed in radians between two points. The returned value can also be based on an angular value entered in the current units of the drawing; the entered value is converted to radians. The aunits system variable determines the current angular units for the drawing.

The value returned by the getorient function is affected by the angdir and angbase system variables. The angle returned by getorient is the value provided by the user plus the value of the angbase system variable. For example, changing angbase to 45 and entering a value of 0 for the getorient function returns a value of 0.785398, which is the current value of angbase. If the user presses Enter without providing a value, the getorient function returns nil.

The following are examples of the getorient function:

(getorient) Pick a point in the drawing area, enter a coordinate value, or enter an angle Specify second point: If a point was specified, pick or enter a second point 0.785398 (getorient "\nEnter angle: ") Enter angle: Type 45 and press Enter 0.785398 (setq pt1 (getpoint "\nSpecify first point: ")) Specify first point: Pick a point in the drawing area (5.5 6.5 0.0) (setq rad (getorient pt1 "\nSpecify second point: ")) Specify second point: Pick a point in the drawing area 0.885067

The following steps demonstrate the effect of the angdir and angbase system variables on the getangle and getorient functions:

At the AutoCAD Command prompt, type (setq cur_angdir (getvar "angdir")) and press Enter.

Type (setq cur_angbase (getvar "angbase")) and press Enter.

Type angdir and press Enter, and then type 0 and press Enter.

Type angbase and press Enter, and then type 0 and press Enter.

Type (getangle) and press Enter.

Type 45 and press Enter.0.785398 is returned, which is the same as 45 degrees in radians.

Type (getorient) and press Enter, and then type 45 and press Enter.0.785398 is returned.

Type angdir and press Enter, and then type 1 and press Enter.Changing angdir switches the direction in which angles are calculated, from counterclockwise to clockwise.

Type (getangle) and press Enter, and then type 45 and press Enter.5.49779 is returned because the direction in which angles are measured has been changed. Typing 315 would be the same as entering 45 degrees in step 6.

Type (getorient) and press Enter, and then type 45 and press Enter.5.49779 is returned.

Type angdir and press Enter, and then type 0 and press Enter.

Type angbase and press Enter, and then type 45 and press Enter.

Type (getangle) and press Enter, and then type 45 and press Enter.0.785398 is returned because the value returned by the getangle function is always based on the x-axis of the world coordinate system (WCS).

Type (getorient) and press Enter, and then type 45 and press Enter.1.5708 is returned because the value returned by the getorient function is always based on the snapbase system variable.

Type (setvar "angdir" cur_angdir) and press Enter.

Type (setvar "angbase" cur_angbase) and press Enter.

Listing 15.1 is a set of custom functions that can be used to convert radians to degrees and degrees to radians.

Listing 15.1: Radians to degrees and degrees to radians

; Convert Radians to Degrees ; Usage: (rtd 0.785398) (defun rtd (rad) (* (/ rad PI) 180) ) ; Convert Degrees to Radians ; Usage: (dtr 45.0) (defun dtr (deg) (* deg (/ PI 180)) )

Guidelines for Prompts

Prompts are used to help explain the type of data that is being requested along with how that data might be used. Most of the commands you start in AutoCAD that don't open a dialog box display a prompt that follows a common structure. I recommend structuring your prompts list like the ones you see in AutoCAD commands to make your prompts feel familiar to the user. Prompts commonly have two or more of the following elements:

Message The message is typically formatted as a statement that begins with a verb, such as specify or enter. I recommend using Specify when the user can pick one or more points in the drawing area to define a value or enter a value, and using Enter when the user can only type a value at the Command prompt. Messages can also be formatted as questions, but this is much less common. I recommend avoiding a conversational tone in the message, which means avoiding words such as please and thanks. Control sequences can also be used as part of a message; \n forces the text that follows it onto a new line, and \\ and \" represent the backslash and quotation mark characters, respectively. For a full list of supported control sequences, search on the「prin1 function」in the AutoLISP Help system.

Option List The option list identifies which keywords are available in addition to the main data type of the getxxx function. An opening ( [ ) and a closing ( ] ) square bracket denote the start and end of the option list. Each keyword in the option list should be separated by a forward slash (/), and the capitalization should match that of the keywords listing in the initget function that is evaluated just prior to the next getxxx function. The option list should come after the main message of the prompt. I discuss the initget function in the「Initializing User Input and Keywords」section later in this chapter.

Default Value The default value that should be used if the user doesn't provide a value before pressing Enter is commonly displayed in a set of angle brackets (<> ). The getxxx function doesn't automatically return the value in the angle brackets if Enter is pressed before a value is provided. You must handle checking for a nil or empty string ("") value and return the desired default value instead. I demonstrate how to implement a prompt with a default value in the「Testing Multiple Conditions」section later in this chapter.

Colon A colon should be the last character in a prompt, followed by a space to provide some separation between the prompt and the value entered by the user.

The following is the recommend structure of a prompt:

Message [Option list] <Default value>:

The following are examples of different prompts that follow my recommendations:

"\nSpecify next point: " "\nSpecify rotation or [Reference] <45.000>: " "\nEnter a number or press Backspace to clear: " "\nEnter color option [Blue/Green/Red] <Blue>: "

The following are examples of prompts that shouldn't be used:

"\nNext point: " "\nPick a color (blue green black):" "\nSpecify next point" "\nEnter color option or <Blue> [Blue/Green/Red]: "

Getting String Values

String values are used to represent the prompts that should be displayed when requesting input, a block name or path, and even the text to be added to an annotation object. You can use the getstring function to request a string value at the Command prompt and specify whether spaces are allowed in the string returned. The entered string is returned by the function, but if the user presses Enter without providing a value, an empty string ("") is returned.

The following shows the syntax of the getstring function:

(getstring [allow_spaces] [prompt])

Its arguments are as follows:

allow_spaces The allow_spaces argument determines if the spacebar acts like the Enter key or if it allows the entering of a space character. By default, pressing the spacebar is the same as pressing Enter. You can provide a value of T to allow the user to enter a space character, or nil to not allow spaces in the text entered. A conditional expression that evaluates to T or nil can also be used. The allow_spaces argument is optional and the argument defaults to nil when a value isn't provided.

prompt The prompt argument represents the textual message to display at the Command prompt when the expression is evaluated. The prompt argument is optional, but I recommend always providing one.

The following are examples of the getstring function and the values that are returned:

(getstring) Type 1.25 and press Enter "1.25" (getstring) Press spacebar "" (getstring T "\nEnter your name: ") Type your first and last (or family) name, then press Enter "Lee Ambrosius"

Initializing User Input and Keywords

The behavior of the getxxx functions can be modified with the initget function. When you want to enable one or more of the alternate behaviors of a getxxx function, you include the initget function before getxxx. In addition to alternate behaviors that can be enabled, many of the getxxx functions can accept keywords that you set up using the initget function as well.

The following shows the syntax of the initget function:

(initget [flags] [keyword_list])

The flags argument represents a bitcoded value that controls the type of input a getxxx function can accept. The flags argument is optional, but when provided can contain one or more of the bits described in Table 15.1.

Table 15.1 initget flags argument bitcodes

Bitcode Description

1 User is not allowed to press Enter without first providing a value.

2 Zero can't be entered when requesting a numeric value.




4 A negative value can't be entered when requesting a numeric value.

8 The point can be specified outside of the drawing's limits; determined by the limcheck system variable.

16 This bitcode is no longer in use.

32 Rubber-band lines and rectangular boxes are shown as dashed instead of the default setting as solid.

64 Coordinate input is restricted to 2D points.

128 Arbitrary input is allowed; text values can be entered when using any of the getxxx functions.

256 Direct distance input takes precedence over arbitrary input.

512 Allows the use of temporary user coordinate systems (USCs) when the cursor passes over the edge of a face on a solid that is planar.

1024 Z-coordinate values are disabled.

For more information on the flags that are available, search on the keywords「initget function」in the AutoCAD Help system.

The keywords_list argument represents the keywords that the next getxxx function can support. The keywords must be placed in a string and each separated by a space. The letters you want a user to be able to enter without typing the full keyword must be in uppercase, and I recommend that they be consecutive; all other letters in a keyword must be lowercase. The keywords_list argument is optional. Examples of keyword lists are "Blue Green Red" and "Azul Verde Rojo_Blue Green Red". The second list represents a keyword list that supports both a localized language and a global language; here the localized language is Spanish and typically the global language is English.

The global language value is used when an underscore is placed in front of a letter combination or command name at the Command prompt. Global language support typically is important for supporting a single command macro in user-interface elements and when others use your custom functions with their own custom programs. For example, typing A for the Azul option when the Spanish-language version of your program was loaded would work just fine but would fail if the English version was loaded. Entering _B instead would work with either the Spanish or English version of the program.

The following are examples of the initget function used with some of the getxxx functions, and the values that are returned:

; Disables pressing Enter without first entering a number or Diameter keyword (initget 1 "Diameter") (setq val (getdist "\nSpecify radius or [Diameter]: ")) Specify radius or [Diameter]: Type D and press Enter "Diameter" (initget 1 "Diameter") (setq val (getdist "\nSpecify radius or [Diameter]: ")) Specify radius or [Diameter]: Type 2.75 and press Enter 2.75 (initget 32) (setq pt1 '(0 0 0)) (setq pt2 (getcorner pt1 "\nSpecify opposite corner: ")) Specify opposite corner: Pick a point in the drawing area (12.5 12.5 0.0) (initget 7) (setq num (getint "\nEnter a number: ")) Enter a number: Type -1 and press Enter Value must be positive and nonzero. Enter a number: Type 4 and press Enter 4

NOTE

All getxxx functions except the getstring function support keywords, and the bitcode 1 value of the initget function doesn't apply to getstring.

In addition to using keywords with the getxxx functions, you can use the getkword function. The getkword function accepts input only in the form of a keyword value unless arbitrary input is enabled with the 128 bitcode of the initget function; in that case, the function can accept any string input. The getkword function can return only a string value—it can't return numbers or point lists. The initget function must be used to set up the keywords that the getkword function can accept.

The following shows the syntax of the getkword function:

(getkword [prompt])

The prompt argument represents the textual message to display at the Command prompt when the expression is evaluated. The prompt argument is optional, but I recommend always providing one.

The following are examples of the getkword function and the values that are returned:

(initget "Yes No") (getkword "\nErase all block references [Yes/No]: ") Erase all block references [Yes/No]: Type H and press Enter Invalid option keyword. Erase all block references [Yes/No]: Type Y and press Enter "Yes" (initget "LTYpe LWeight LTScale") (getkword "\nChange object property [LTYpe/LWeight/LTScale]: ") Enter option [LTYpe/LWeight/LTScale]: Type L and press Enter Ambiguous response, please clarify… LTYpe or LWeight or LTScale? Type LW and press Enter "LWeight"

NOTE

When supporting keywords, you will need to use test conditions and conditional statements to determine how your program should handle the keyword the user chose. I discuss these concepts in the「Conditionalizing and Branching Expressions」section later in this chapter.

Defining Custom User-Input Functions

The AutoLISP getxxx functions should cover most input needs from the Command prompt, but there might be times when you want more control over the type of input and return value. The grread function provides access to the raw input values that are provided with the keyboard (physical or virtual) or pointing device (mouse, trackpad, touchscreen, tablet, and other supported devices). Raw input includes, but is not limited to, keypresses, the current location of the crosshairs, or which button is pressed on the pointing device.

The grread function returns a list with the input that is represented by the device. The first value in the list that grread returns represents the type of input that the user provided, and the second value represents the input collected. The input collected might be a list or integer value. Table 15.2 presents a few examples of values returned by the grread function and their meaning.

Table 15.2 Example grread returns

Values Description

(2 65) 2 indicates that the user pressed a key on the keyboard; the remaining value indicates that the key that was pressed is represented by the ASCII value of 65, capital A.

(3 (11.0 9.5 0.0)) 3 indicates that the user clicked in the drawing area; the remaining values indicate that at the time of the click the cursor was located at the coordinate value of 11,9.5.

(25 380) 25 indicates that the user right-clicked or secondary-clicked in the drawing area, and at the time of the click the cursor was located 380 pixels from the left side of the screen.

You can learn more about the return values of the grread function by doing a search on「grread function」in the AutoCAD Help system.

The following shows the syntax of the grread function:

(grread [tracking [input_type [cursor_type]]])

Its arguments are as follows:

tracking The tracking argument determines if coordinates are returned when the cursor is moved. Use a value of T to enable tracking when the cursor is moved; otherwise, provide nil. The tracking argument is optional.

input_type The input_type argument represents a bitcoded value that controls the type of input grread can accept. The input_type argument is optional.

cursor_type The cursor_type argument represents the type of cursor that should be active while the grread function is waiting for input. The input_type argument must contain the 2 bitcode value to change the cursor to the one specified by the cursor_type argument. The cursor_type argument is optional.

For more information on the values that can be used with the input_type and cursor_type arguments, search on「grread function」in the AutoCAD Help system.

The following are examples of the grread function and the values that are returned:

(grread) Click the pick (left) button in the drawing area (3 (22.704 7.70166 0.0)) (grread) Press the P key on the keyboard (2 112)

Listing 15.2 shows a custom function that gets raw input from the keyboard and continues prompting for input as long as neither the spacebar nor the Enter key has been pressed. The way the input and conditionals are set up, only the number and the Backspace key are valid input. When valid input is provided, the number pressed is stored as a string in a user variable named number and an * (asterisk) is displayed at the Command prompt in its place.

Listing 15.2: PIN or search code input function

; Function limits input to number, Backspace, Enter, and spacebar keys. ; Valid input is also masked with the use of the * (asterisk) character. (defun c:MyPINCode ( / number code ch) ; Display a prompt to the user since ; grread does not display a prompt (prompt "\nEnter number [backspace to clear]: ") ; Request input from the user (setq code (grread) number "") ; Check to see if the user pressed a key on the keyboard ; and continue requesting characters until Enter or spacebar is pressed, ; or a non-keypress occurs. (while (and (= 2 (car code)) (and (/= 13 (cadr code)) (/= 32 (cadr code)))) (if (and (>= (cadr code) 48) (<= (cadr code) 57)) (progn (setq ch (chr (cadr code))) (setq number (strcat number ch)) (princ "*") ) ) ; Enables the use of Backspace to clear the current ; value entered and the number of *s displayed at ; the command-line window. (if (= (cadr code) 8) (progn (repeat (strlen number) (princ (chr 8)) ) (setq number "") ) ) ;; Ask for more input if the user did not press Enter or Space (if (or (/= 13 (cadr code))(/= 32 (cadr code))) (setq code (grread)) ) ) ; Display the actual numbers entered (prompt (strcat "\nPIN entered was: " number)) (princ) )

I explain more about the prompt and princ functions in the next section, and I discuss the if and while functions along with comparison and logical grouping operators later in this chapter.

Providing Feedback to the User

Although a program can simply request information and then go on its way, it is best to acknowledge the user and provide them with some feedback. Now, this doesn't mean you need to make small talk with the person on the other side of the screen, but it also doesn't mean you should share your life story. Based on the tasks your AutoLISP program might perform, you may want to provide information to the user when the function does any of the following:

Starts Consider displaying the default settings or options that your program will be using, similar to the informational text that is displayed before the first prompt when using the fillet or style command.

Executes When processing a large data set or number of objects, consider displaying a counter that helps the user know that something is still happening.

Causes an Error If something happens internally in your program, you should let the user know what went wrong so they can report the problem or try to fix it themselves.

Completes In most cases, you don't need to display information when your function is done executing, simply because the user is returned to an empty Command prompt. However, you might want to let the user know if the information from a set of objects was successfully extracted or how many objects were modified.

The following sections cover the AutoLISP functions that can be used to display messages to the user at the Command prompt, in a message box, or at the status bar.

Displaying Messages at the Command Prompt

In the「Requesting Input at the Command Prompt」section earlier, you learned how to display a message when requesting input from the user with one of the getxxx functions. Using the AutoLISP prompt function, you can also display messages to the user without requesting input. The prompt function simply displays a message at the Command prompt.

The following shows the syntax of the prompt function:

(prompt message)

The message argument represents the textual message to display at the Command prompt. As part of the textual message, you can use the control sequence \n to force the message on a new line and use the control sequences \\ and \" to represent a backslash and quotation mark characters, respectively. For a full list of supported control sequences, search on「prin1 function」in the AutoCAD Help system.

The following are examples of the prompt function and the values that are returned:

(prompt (strcat "\nCurrent OSMODE value: " (itoa (getvar "OSMODE")))) Current OSMODE value: 4133 (prompt "\nDrawing Name: ")(prompt (getvar "DWGNAME")) Drawing Name: Drawing1.dwg

Optionally, you can use the terpri function to force messages displayed at the command-line window to a new line. The results are just like using the \n control sequence as part of the textual message passed to the prompt function. The terpri function doesn't accept any arguments.

The following is an example of the terpri function:

(prompt "\nDrawing Name: ") (terpri) (prompt (getvar "DWGNAME")) Drawing Name: Drawing1.dwg

In addition to the prompt function, the princ, prin1, and print functions can be used to display the values of any type of data, not just strings, at the command-line window. These three functions are similar to each other, but have the following differences:

The princ and prin1 functions are similar, with the exception of how control sequences are handled, such as \n and \\. Control sequences in messages aren't expanded with the princ function, but they are with the prin1 function.

The prin1 and print functions are similar, with the exception of a space character being placed before the value that is returned by the function. The prin1 function doesn't include a space character before the value that is returned, but the value returned by the print function does.

The following shows the syntax of the princ, prin1, and print functions:

(princ [atom [file_descriptor]]) (prin1 [atom [file_descriptor]]) (print [atom [file_descriptor]])

The arguments are as follows:

atom The atom argument represents the value to output to the Command prompt or the external file. The atom argument is optional.

file_descriptor The file_descriptor argument represents the pointer to the file that has been opened with the open function. You'll learn how to work with external files in Chapter 18,「Working with the Operating System and External Files.」

The following are examples of using the princ, prin1, and print functions, and the values that they return:

(princ "\nSample message") Sample message"\nSample message" (prin1 "\nSample message") "\nSample message""\nSample message" (print "\nSample message") "\nSample message" "\nSample message"

TIP

The princ function can be used to exit a custom function quietly. Exiting a function quietly means that the function doesn't return the value of its last expression. I explained how to exit quietly from a custom function in Chapter 13.

Displaying Messages in a Message Box or at the Status Bar

Displaying messages at the Command prompt or command-line window are the most common ways to display information back to the user with AutoLISP. However, you can also display messages in a message box (which the user must acknowledge before the AutoLISP program continues) or on the status bar.

The AutoLISP alert function displays a simple message box with a custom message and only an OK button. If you are developing AutoLISP programs for AutoCAD on Windows, you can use Dialog Control Language (DCL) to create a custom error message that lets you display both an OK and a Cancel button. Chapter 23 discusses DCL.

The following shows the syntax of the alert function:

(alert message)

The message argument represents the textual message you want to display in the message box.

The following is an example of the alert function. Figure 15.4 displays the results of the example code.

(alert "Error: No value provided.")

Figure 15.4 Message displayed with the alert function

On Windows, if you have Express Tools installed, you can use the AutoLISP acet-ui-message function to display a message box with more options than the alert function. Figure 15.5 shows an example of a message box displayed with the acet-ui-message function. The acet-ui-message function returns an integer value based on the button the user clicks in the message box.

Figure 15.5 Custom message displayed with the acet-ui-message function

The AutoLISP expression that displays the message box shown in Figure 15.5 is as follows:

(acet-ui-message "Custom message using ACET-UI-MESSAGE" "AutoCAD Platform Customization" 1)

If you are using AutoCAD on Windows, you can also display a message in the status bar. The messages you display in the status bar should be kept short and simple. A message can be displayed in the status bar using the grtext function.

The following shows the syntax of the grtext function:

(grtext location message)

Its arguments are as follows:

location The location argument represents where the textual message should be displayed. In early AutoCAD releases on Windows, location allowed you to display text in a user interface called the Screen menu, which has since been discontinued. Use the -1 value to specify the status bar as the location for the textual message.

message The message argument represents the textual message to display at the status bar.

The following is an example of the grtext function. Figure 15.6 displays the results of the example code.

(grtext -1 "Error: No value provided.")

Figure 15.6 Message displayed in the status bar with the grtext function

Pass the grtext function an empty string ("") to remove the recent message from the status bar:

(grtext -1 "")

NOTE

On Mac OS, the grtext function doesn't cause an error when used; it also does not display the message that was passed to the function.

Expanding or Showing the Command-Line History

The command-line window normally displays three lines of history, which isn't ideal for long prompts or messages. The AutoLISP textscr or textpage functions allow you to expand the command-line window or show the AutoCAD Text window, similar to using the ? option of the setvar command, to make it easier to view long messages. The AutoCAD Text window is available in AutoCAD on Windows only when the command-line window is docked; it is not available when the command-line window is in its default floating state. The textscr and textpage functions don't accept any arguments.

Working with the Graphics Windows

Feedback to the user doesn't need to be limited to just textual messages; you can draw temporary graphics in the drawing area to communicate problems or show where permanent graphical objects might be created. Temporary graphics aren't created using the standard AutoCAD commands, and there is no way to convert temporary graphics to permanent graphical objects that can be stored with a drawing. Since the temporary graphics aren't part of the drawing, changing the view with the zoom or pan command, or regenerating (regen command) or redrawing (redraw command) the display removes any temporary graphics that were drawn.

Displaying Temporary Vectors in the Drawing Area

Temporary graphics allow you to visually communicate to the user how large an object is or where it might be placed prior to adding the object to a drawing. The graphics that you can draw in the graphics area are limited to line segments only; curves aren't supported. If you need to draw a curve, you must calculate the points along an arc or circle, and then draw the object using line segments. Individual line segments can be drawn using the AutoLISP grdraw function.

The following shows the syntax of the grdraw function:

(grdraw vec_from vec_to vec_color [vec_highlight])

Its arguments are as follows:

vec_from The vec_from argument represents the coordinate value that the vector should start at.

vec_to The vec_to argument represents the coordinate value that the vector should be drawn to.

vec_color The vec_color argument represents the AutoCAD Color Index (ACI) color value that the vector should be assigned. Individual vectors can be removed from the display by drawing a new vector with the color value of -1 over the top of the vector you want to remove.

vec_highlight The vec_highlight argument represents the highlighting of the vector (which is normally dashed). The vec_highlight argument is optional and it is an integer value. Typically, a value of 1 is used to display the vector as a dashed line. In AutoCAD on Windows or Mac OS, only dashed lines are supported; earlier AutoCAD releases designed for other platforms supported different highlighting behaviors.

The following are examples of drawing vectors in the drawing area with the grdraw function. The results of the examples are shown in Figure 15.7.

; Draws a vector from 0,0 to 5,5 with a ACI color of 32 and dashed (grdraw '(0 0) '(5 5) 32 1) nil ; Draws a vector from 5,0 to 0,5 with a ACI color of 150 (grdraw '(5 0) '(0 5) 150) nil

Figure 15.7 Drawing individual vectors with the grdraw function

In addition to drawing vectors one at a time, you can draw multiple vectors using the AutoLISP grvecs function. The following shows the syntax of the grvecs function:

(grvecs vectors [trans_matrix])

Its arguments are as follows:

vectors The vectors argument represents a list of the vectors that should be drawn and their colors. The formatting of each vector is (vec_color vec_from vec_to …). The ACI value of the vec_color argument represents the vector's color, and the vec_from and vec_to arguments represent the coordinate values to draw the vector.

trans_matrix The trans_matrix argument represents the transformation matrix that should be applied to the coordinate values of the vectors being drawn. The trans_matrix argument is optional. For more information on transformation matrices, see Chapter 14,「Working with Lists.」

The following is an example of drawing vectors in the drawing area with the grvecs function. The results of the example are shown in Figure 15.8.

; Draws rectangle that is 8x11 units in size with an ACI color of 6 (grvecs '(6 (0 0) (8 0) 6 (8 0) (8 11) 6 (8 11) (0 11) 6 (0 11) (0 0) ) ) nil

TIP

Changing the current view clears the temporary graphics, but you can use reactors in AutoCAD on Windows to redraw the vectors after a view change occurs. You'll learn about reactors in Chapter 22,「Working with ActiveX/COM Libraries (Windows only).」

NOTE

If you are modifying an existing program that draws temporary vectors, you might need to use the grclear function to clear the display of the current viewport. The grclear function is not needed in recent releases but might be required if you are using an earlier release.

Figure 15.8 Drawing multiple vectors with the grvecs function

Setting Focus to the Graphics Window (Windows Only)

Earlier releases of AutoCAD supported two different screens, two physical monitors: graphics and text. More recent releases use a modern user interface that has a graphics and a text window. The AutoLISP graphscr function collapses the history of the command-line window or hides the AutoCAD Text Window, which are expanded or shown with the textscr or textpage function. I discussed the textscr or textpage functions earlier in the「Expanding or Showing the Command-Line History」section. The graphscr function doesn't accept any arguments.

Conditionalizing and Branching Expressions

The expressions that make up an AutoLISP program are executed sequentially; this is commonly known as a linear program. In a linear program, execution starts with the first expression and continues until the last expression is executed. Although expressions are executed in a linear order, AutoLISP programs can contain branches. Think of a branch as being no different than a fork in the road.

Branches allow a program to make a choice as to which expressions should be executed next based on the results of a test condition. A test condition is an expression that evaluates to true or false; in AutoLISP, that would be T or nil, respectively. AutoLISP provides a wide range of operators and functions that can be used individually or with a logical grouping operator to see if more than one test condition evaluates to T or nil. The AutoLISP expressions if and cond are used to branch the expressions in your programs.

Comparing Values

As the complexity of a program grows, so does the need to use test conditions (that is, to perform conditional tests). Test conditions are used to compare values or settings in the AutoCAD environment against a known condition. AutoLISP operators and functions that are used to test conditions return T (if the condition being tested evaluates to true) or nil (if the condition evaluates to false). The AutoLISP operators and functions used to test a condition allow you to

Compare two values for equality

Determine if a value is numeric, zero, or negative

Compare two values to see if one is greater than, less than, or equal to the other

Check for a value being bound to a variable

Check for a variable that contains a list

This exercise shows how to work with some basic test conditions:

At the AutoCAD Command prompt, type (setq num1 5 num2 3.5) and press Enter.

Type (= num1 num2) and press Enter.nil is returned as the two numbers are not equal to each other.

Type (not (= num1 num2)) and press Enter.T is returned because the not function returns T if the argument it is passed is nil. Essentially it inverts the value it is passed; T becomes nil and nil becomes T.

Type (= num1 (+ num2 1.5)) and press Enter.T is returned as the value assigned to num1 is equal to the value of the num2 variable and 1.5 after they are added together.

Type (<= num1 num2) and press Enter.nil is returned as the value assigned to the num1 variable is not less than or equal to the value assigned to the num2 variable.

Type (<= num1 (+ num2 2.5)) and press Enter.T is returned as the value assigned to the num1 variable is less than or equal to the value assigned to the num2 variable.

Testing Values for Equality

Testing for equality is probably the most common test condition you will perform. For example, you might want to see if the user provided any input with one of the getxxxx functions that I mentioned in the「Requesting Input at the Command Prompt」section earlier or if the user just pressed Enter. In this case, you would be checking to see if the value returned by the function was equal to nil. The AutoLISP = (equal to) and /= (not equal to) operators are how values are commonly compared to each other.

The following shows the syntax of the = and /= operators:

(= atom1 [atomN …]) (/= atom1 [atomN …])

Here are the arguments:

atom1 The atom1 argument represents the atom you want to compare against the atoms represented by the atomN arguments. If all the atoms provided to the operator evaluate to the same value, T is returned; otherwise, nil is returned.

atomN The atomN argument represents the second or any other values you want to compare.

The following are examples of checking for equality with the = and /= operators, and the values that are returned:

(= 1 1.0) T (= 1 2) nil (/= 1 2) T (/= nil (getpoint "\nSpecify point: ")) Specify point: Press Enter nil (/= nil (getpoint "\nSpecify point: ")) Specify point: Pick a point in the drawing area T (= 1 1.0 1) T (= 1 1.0 2) nil

When comparing more than two atoms, the atoms are compared in pairs from left to right. For example, (= 1 1.0 1) is compared as (= 1 1.0) and (= 1.0 1). Since both pairings evaluate to T, the = operator returns T. The expression (= 1 1.0 2) is evaluated as (= 1 1.0) and (= 1.0 2). Since both pairings don't evaluate to T, the = operator returns nil.

The AutoLISP eq and equal functions can be used to check a variable or the value of a variable for equality. The eq function checks to see if two variables point to the same location in memory and if the values are the same, whereas the equal function tests to see if two values are within a provided threshold or fuzzy factor. If the variables or values that are being tested with the eq and equal functions are equal, then T is returned; otherwise nil is returned.

The following shows the syntax of the eq function:

(eq var1 var2)

Here are the arguments:

var1 The var1 argument represents the first variable you want to compare. The variable is defined with the setq function.

Var2 The var2 argument represents the second variable to compare. The variable is defined with the setq function.

The following shows the syntax of the equal function:

(equal value1 value2 [fuzz_factor])

These are the arguments:

value1 The value1 argument represents the first value you want to compare.

value2 The value2 argument represents the second value you want to compare.

fuzz_factor The fuzz_factor argument represents the tolerance or difference between the two compared values in order for the function to return T. If the two values are outside of the tolerance specified with the fuzz_factor argument, nil is returned.

The following are examples of checking for equality with the eq and equal functions, and the values that are returned:

; v1 is set to '(0 0 5), v2 is set to '(0 0 5), and v3 is set to variable v2 (setq v1 '(0 0 5) v2 '(0 0 5) v3 v2) (0 0 5) (eq v1 v3) nil (eq v2 v3) T ; Compares two values with a fuzz factor of 0.0625 (equal 0.25 0.20 0.0625) T (equal 0.25 0.1875 0.0625) nil

Determining if a Value Is Greater or Less than Another

The values that a user provides or the settings that define the AutoCAD environment aren't always easily comparable for equality. Values such as the radius of a circle or the length of a line are often compared to see if a value is greater or less than another. The AutoLISP > (greater than) and < (less than) operators can be used to ensure that a value is—or isn't—greater than or less than another value.

These two operators are great for limiting the value a user might enter with the getint, getreal, getdist, getangle, or getorient functions mentioned earlier, in the「Requesting Input at the Command Prompt」section. You can also use the > and < operators with looping expressions to count down or up, and to make sure that while incrementing or decrementing a value you don't exceed a specific value. You might also use the > and < operators with a logical grouping operator to make sure a value is within a specific range of values. I discuss logical groupings in the「Grouping Comparisons」section later in this chapter.

The > (greater than) operator returns T if the first number is greater than the second number; otherwise, nil is returned. The < (less than) operator returns T if the first number is less than the second number; otherwise, nil is returned. If the values being compared are equal, then nil is returned. The > and < functions can also be used with strings. When a string is provided, the sum of each character's ASCII value is compared.

The following shows the syntax of the > and < operators:

(> value1 [valueN …]) (< value1 [valueN …])

The arguments are as follows:

value1 The value1 argument represents the first value you want to compare.

valueN The valueN argument represents the two or more values you want to compare.

The following are examples of comparing values with the > and < operators, and the values that are returned:

(> 1 1.0) nil (> 2 1) T (> "ab" "ac") nil (> 1 3 2) nil (> 4 3 2) T (> 4 (getint "\nEnter a number less than 4: ")) Enter a number less than 4: 3 T Enter a number less than 4: 4 nil (< 1 1.0) nil (< 2 1) nil (< "ab" "ac") T (< 1 2 3) T (< 1 3 2) nil

When comparing more than two values, the values are compared in pairs from left to right. For example, (< 1 2 3) is compared as (< 1 2) and (< 2 3). Since both pairings evaluate to T, the < operator returns T. The expression (< 1 3 2) is evaluated as (< 1 3) and (< 3 2). Since both pairings don't evaluate to T, the < operator returns nil.

In addition to comparing to see if a value is greater or less than another, you can check for equality. The >= (greater than or equal to) and <= (less than or equal to) operators allow you to check to see if a value is greater or less than another or if the two values are equal. The syntax and return values for the >= and <= operators are the same as the > and < operators, except T is returned if the values being compared are equal to each other.

Here are examples of comparing values with the >= and <= operators, and the values that are returned:

(>= 1 1.0) T (>= 1 2) nil (<= 1 1.0) T (<= 1 2) T

TIP

You can compare a value within a range of values by using logical groupings, which I cover in the「Grouping Comparisons」section later in this section.

Checking for a Value of nil

A value, variable, or expression can be checked to see if it evaluates to nil. The AutoLISP not function returns T if a value, variable, or expression normally returns nil. If nil is normally returned, T is returned instead. You can think of the not function as a way to invert the values T and nil.

The following shows the syntax of the not function:

(not atom)

The atom argument represents the expression to evaluate, and then returns a value of T if atom evaluates to nil, or nil if atom evaluates to T.

The following are examples of the not function and the values that are returned:

(= 1 1.0) T (not (= 1 1.0)) nil (not (> 4 (getint "\nEnter a number less than 4: "))) Enter a number less than 4: 3 nil Enter a number less than 4: 4 T

Grouping Comparisons

There are many times when one test condition is not enough to verify a value. One of the best examples of when you want to use more than one test condition is to see if a value is within a specific numeric range. Logical grouping operators are used to determine if the result of one or more test conditions evaluates to T.

The AutoLISP and and or operators are the two logical grouping operators that can be used to test two or more test conditions. The and operator returns T if all the test conditions in a grouping return T; otherwise, nil is returned. The or operator returns T if at least one test condition in a grouping returns T; otherwise it returns nil.

The following shows the syntax of the and and or operators:

(and [test_conditionN …]) (or [test_conditionN …])

The test_conditionN argument represents the test conditions that you want to group together and evaluate.

The following shows examples of the and and or operators and the values that are returned:

; Check to see if the number is between 1 and 5 (setq num (getint "\nEnter a number between 1 and 5: ")) (and (>= 5 num)(<= 1 num)) Enter a number between 1 and 5: 3 T Enter a number between 1 and 5: 6 nil ; Checks to see if the value of the num1 and num2 variables is a numeric value (setq num1 1.5 num2 "1.5") (or (= (type num1) 'REAL)(= (type num1) 'INT)) T (or (= (type num2) 'REAL)(= (type num2) 'INT)) nil

Chapter 12 discussed the type function.

Validating Values

Prior to using a variable, you should test to see if the variable holds the type of value that you might expect. Although they do increase the complexity of a program, the additional expressions used to test variables are worth the effort as they help to protect your programs from unexpected values. Table 15.3 lists some of the functions that can be used to test the values of a variable.

Table 15.3 AutoLISP functions for testing the values of a variable

Function Description

boundp Checks to see if a symbol is bound to a variable; returns T or nil.

numberp Determines if a value is numeric; returns T or nil.

minusp Checks to see if a numeric value is positive or negative; T is returned if the value is negative.

zerop Determines if a value is 0 or not; returns T or nil.

Null Determines if a symbol is bound to the value of nil; returns T or nil.

For more information on these and other validation functions, see the AutoCAD Help system.

Evaluating if a Condition Is Met

The AutoLISP operators and functions discussed in the previous sections allow a program to compare and test values to determine which expressions to execute by using a programming technique called branching. The most common branching method in most programming languages is what is referred to as an If … Then … Else expression. In an If … Then … Else expression, different sets of expressions are executed if the test condition is evaluated as true (or T) or false (or nil).

In AutoLISP, the if function is used to define an If … Then … Else expression. The following shows the syntax of the if function:

(if test_condition then_expression [else_expression])

The arguments are as follows:

test_condition The test_condition argument represents the test condition that you want to evaluate and determine which expression to execute. If test_condition evaluates to T, the expression represented by then_expression is evaluated; otherwise, the expression represented by else_expression is evaluated if provided.

then_expression The then_expression argument represents the expression to evaluate if the test_condition argument evaluates to T.

else_expression The else_expression argument represents the expression to evaluate if the test_condition argument evaluates to nil. The else_expression argument is optional.

The following are examples of the if function:

; Checks to see if the value entered is greater than 4 (setq num (getint "\nEnter a number: ")) (if (>= num 4) (prompt "\nNumber is 4 or greater") (prompt "\nNumber is less than 4") ) Enter a number: 3 Number is less than 4 nil Enter a number: 5 Number is 4 or greater nil ; Checks to see if the user specified a point (if (setq pt (getpoint "\nSpecify a point: ")) (prompt (strcat "\nUser specified a point of: " (vl-princ-to-string pt))) (prompt "\nNo point specified") ) Specify a point: Press Enter without specifying a point No point selectednil Specify a point: Pick a point in the drawing area User specified a point of: (15.0089 11.0815 0.0)nil

Without any extra help, the AutoLISP if function can only accept a single expression for the then_expression or else_expression argument. If you pass more than two expressions to the if function and try to execute your program, AutoLISP replies with the message ; error: syntax error.

(if (setq pt (getpoint "\nSpecify a point: ")) (prompt (strcat "\nUser specified a point of: " (vl-princ-to-string pt))) (command "._circle" pt 2) (prompt "\nNo point specified") ) ; error: syntax error

It isn't uncommon that you will want to execute more than one expression based on the value returned by the test condition of the if function. When you want to use more than one expression, use the progn function to group more than one expression into a single expression. The syntax of the if expression is as follows:

(if test_condition (progn then_expressions ) (progn else_expressions ) )

NOTE

You need to use the progn function only when more than one expression is being passed to the then_expression or else_expression argument of the if function. You can use the progn function, though, when only one expression is being used.

The following is an example of the if and progn functions that are used to draw a circle only after a valid point is specified:

; Prompts for a point and then draws a circle and ; sets its color to ACI 3 if a point was specified. (if (setq pt (getpoint "\nSpecify center point: ")) (progn (command "._circle" pt 2) (command "._change" (entlast) "" "_p" "_c" "3" "") ) )

The following is an example of nested if and progn functions that allow the user to draw a circle or hexagon based on the keyword provided:

; Prompts for a keyword, and then draws either a circle or hexagon ; on different layers based on a specified center point. (initget "Circle Hexagon") (if (setq kword (getkword "\nEnter object to create [Circle/Hexagon]: ")) (if (= kword "Circle") (progn (command "._layer" "_m" "Circles" "_c" "30" "" "") (command "._circle" PAUSE 1.5) ) (progn (command "._layer" "_m" "Hexagons" "_c" "150" "" "") (command "._polygon" "6" PAUSE "_i" 1.65) ) ) (prompt "\nNo option specified.") )

Testing Multiple Conditions

The if function allows for programs to execute one of two possible sets of expressions based on the results of a single test condition. However, there are times when multiple test conditions are needed to interpret a value or user input. Although it is possible to use multiple if expressions to evaluate more than one test condition, the AutoLISP programming language contains the cond function, which allows for the evaluation of more than one test condition.

The test conditions of the cond function are evaluated one at a time in a top-down order. When evaluation of the cond function begins, the first test condition is evaluated; if it returns true (T), the expressions associated with it are evaluated and the evaluation of the cond function ends. If the first test condition doesn't return true (T), the next test condition is evaluated and so on until all test conditions have been evaluated or one test condition returned true (T) before reaching the last test condition. Optionally, a set of expressions can be executed if none of the other test conditions of the cond function evaluate to true (T).

The following shows the syntax of the cond function:

(cond [(test_conditionN then_expressionN) … [(else_expressionN)]] )

Its arguments are as follows:

test_conditionN The test_conditionN argument represents the test condition to be evaluated. If test_conditionN evaluates to T, the expressions represented by then_expressionN are executed.

then_expressionN The then_expressionN argument represents the expressions to evaluate if the test_conditionN argument evaluates to T.

else_expressionN The else_expressionN argument represents the expressions to evaluate if none of the test conditions represented by the test_conditionN argument evaluates to T. The else_expressionN argument is optional.

The following are examples of the cond function:

; Gets the current value of the IMAGEFRAME system variable ; and returns a textual description of that value. (setq cur_imgfrm (getvar "imageframe")) (cond ((= cur_imgfrm 0)(prompt "\nImage frame not displayed or plotted.")) ((= cur_imgfrm 1)(prompt "\nImage frame displayed or plotted.")) ((= cur_imgfrm 2)(prompt "\nImage frame not plotted.")) ) ; Prompts the user for a keyword and if they press Enter ; without a value the nil value should be interpreted as Blue. (initget "Blue Green Red") (setq kword (getkword "\nEnter color option [Blue/Green/Red] <Blue>: ")) (cond ((or (= kword nil)(= kword "Blue"))(prompt "\nSelected Blue")) ((= kword "Red")(prompt "\nSelected Red")) ((= kword "Green")(prompt "\nSelected Green")) ) Enter color option [Blue/Green/Red] <Blue>: Press Enter without a value Selected Blue Enter color option [Blue/Green/Red] <Blue>: g Selected Green ; Prompts the user for a keyword or a numeric value (initget "A B C") (setq num (getreal "\nEnter a number or [A/B/C]: ")) (cond ((and (= (type num) 'REAL)(> num 0))(prompt "\nGreater than 0")) ((and (= (type num) 'REAL)(= num 0))(prompt "\nValue is 0")) ((and (= (type num) 'REAL)(< num 0))(prompt "\nLess than 0")) ((and (= (type num) 'REAL)(> num 0))(prompt "\nGreater than 0")) ((= num nil)(prompt "\nNo value or option provided")) (T (prompt "\nAn option was selected. ") (prompt (strcat "\nOption chosen: " (vl-princ-to-string num))) ) ) Enter a number or [A/B/C]: 1 Greater than 0 Enter a number or [A/B/C]: B An option was selected. Option chosen: B Enter a number or [A/B/C]: Press Enter without a value No value or option provided

Repeating and Looping Expressions

Early in my career as a drafter, I learned one key fact about myself: I don't handle repetition well at all. This discovery is what led me to AutoCAD customization and eventually AutoLISP programming. AutoLISP—and most programming languages, for that matter—have no problem with repetition, as they support a concept known as loops. Loops allow for a set of expressions to be executed either a finite number of times or infinitely while a condition is met.

The AutoLISP programming language contains four functions that can be used to repeat or loop a set of expressions, or even iterate through the items of a list or collection object. Table 15.4 describes these functions.

Table 15.4 AutoLISP looping functions

Function Description

repeat Executes a set of expressions a finite number of times. For more information, see the next section.

while Executes a set of expressions as long as a test condition returns T. For more information, see the「Performing a Task While a Condition Is Met」section.

foreach Iterates through a list and assigns each element to a variable one at a time, and the variables can then be used by a set of expressions. I discussed the foreach function in Chapter 14.

vlax-for Iterates through a collection object and assigns each object to a variable one at a time, and the variables can then be used by a set of expressions. Chapter 22 discusses the vlax-for function.

Repeating Expressions a Set Number of Times

The easiest way to loop through a set of expressions in AutoLISP is to use the repeat function. The first argument of the repeat function determines the number of times you want to loop through the set of AutoLISP expressions. Looping through a set of expressions a known number of times is a great way to iterate the objects of a selection set or to prompt the user a finite number of times. The repeat function returns the value of the last expression in the loop.

TIP

When working with a large number of loops, consider keeping track of the current loop that is being executed by incrementing the value of a user-defined variable. Then, at a set interval, let the user know that something is still happening so they know that AutoCAD hasn't stopped responding.

The following shows the syntax of the repeat function:

(repeat loop_count [expressionN])

Its arguments are as follows:

loop_count The loop_count argument represents the number of times you want to loop through the expressions specified by the expressionN argument.

expressionN The expressionN argument represents the expressions that should be executed each time the loop is started.

The following are examples of the repeat function:

; Loops the expressions 5 times, the variable ; cnt is incremented by 1 with each loop (setq cnt 0) (repeat 5 (terpri) (princ (setq cnt (1+ cnt))) (princ) ) 1 2 3 4 5 ; Loop restricts the user to specifying three ; points to draw a closed object (defun c:3SF ( / old_cmdecho) (setq old_cmdecho (getvar "cmdecho")) (setvar "cmdecho" 0) (command "._line") (repeat 3 (command (getpoint "\nSpecify a point: ")) ) (command "_c") (setvar "cmdecho" old_cmdecho) (princ) ) C:3SF Specify a point: Specify a point: Specify a point:

Performing a Task While a Condition Is Met

The repeat function, as I mentioned in the previous section, can be used to execute a set of expressions a finite number of times. However, it isn't always easy to know just how many times a set of expressions might need to be executed to get the desired results. When you are unsure of the number of times a set of expressions might need to be executed, you can use the while function. The while function uses a test condition, just like the if and cond functions, to determine whether the set of expressions should be executed. The set of expressions is executed as long as the test condition returns T. The test conditions that can be used are the same ones that I mentioned earlier in the「Comparing Values」and「Grouping Comparisons」sections. The while function returns the value of the last expression in the loop.

The following shows the syntax of the while function:

(while test_condition [expressionN])

Its arguments are as follows:

test_condition The test_condition argument represents the expression that should be used to determine if the expressions represented by the expressionN argument should be executed. If test_condition evaluates to T, one loop occurs and then test_condition is evaluated again. Looping continues as long as test_condition evaluates to T.

expressionN The expressionN argument represents the expressions that should be executed each time the loop is started.

The following are examples of the while function:

; Loops the expressions 5 times, the variable ; cnt is decremented by 1 with each loop (setq cnt 5) (while (> cnt 0) (terpri) (princ (setq cnt (1- cnt))) (princ) ) 4 3 2 1 0 ; Loop continues prompting for points until ; the user presses Esc or Enter (defun c:C25 ( / old_cmdecho) (setq old_cmdecho (getvar "cmdecho")) (setvar "cmdecho" 0) (prompt "\nSpecify center point or <enter> to exit: ") (while (setq pt (getpoint)) (command "._circle" pt 0.25) ) (setvar "cmdecho" old_cmdecho) (princ) ) C:C25 Specify center point: ; Custom function prompts the user for a number between 1 and 5. ; If the user enters an incorrect value, it prompts the user again, or ; ends if the user presses Enter (defun c:NumberRange ( / askForNumber msg num) (setq askForNumber '(getint "\nEnter a number between 1 and 5: ")) (setq msg '(prompt (strcat "\nUser Entered: " (itoa num)))) (setq num (eval askForNumber)) (if (/= num nil) (progn (while (and (/= num nil) (not (and (>= 5 num)(<= 1 num))) ) (prompt "\nTry again. Number must be between 1 and 5.") (setq num (eval askForNumber)) ) ) ) (if (/= num nil)(eval msg)) (princ) ) Enter a number between 1 and 5: 0 Try again. Number must be between 1 and 5. Enter a number between 1 and 5: 6 Try again. Number must be between 1 and 5. Enter a number between 1 and 5: 3 User Entered: 3

Listing 15.3 shows a set of custom functions that display an animated progress message in the status bar area. The custom functions can be helpful when processing a large number of objects or when writing/reading values to/from an external file. Instead of using the princ function, the grtext function is used to display the text whereas the vl-string-subst function is used to give the appearance of an animated progress message by replacing one character with another before redisplaying the new message.

Figure 15.9 shows what the progress bar looks like. Underscores are changed to equal symbols in the first pass and then the equals symbols are changed to underscores in the next. Once the functions are all loaded, start the progress-test function by entering it at the Command prompt to see it in action.

Figure 15.9 Custom animated progress message

Listing 15.3: Animated progress message in the status bar (Windows only)

; Initializes the variables and the status bar ; Usage: (progress-start) (defun progress-start ( / ) (setq *global-progress-value* nil *global-progress-increment* nil *global-progress-replace* nil) (grtext -1 "") (princ) ) (defun progress (prefixText / temp) (setq increment 10) ; Check to see if the global variable is initialized (if (= *global-progress-value* nil) (progn (setq *global-progress-value* prefixText *global-progress-increment* 0 *global-progress-replace* (list "_" "=")) (repeat 10 (setq *global-progress-value* (strcat *global-progress-value* "=")) ) ) ) ; Pause for 1/20 of a second to allow ; AutoCAD time to paint the application window (command "._delay" 50) ; Setup replacement character order (if (> *global-progress-increment* increment) (progn (setq *global-progress-replace* (reverse *global-progress-replace*) *global-progress-increment* 0) ) ) ; Display custom message in the status bar (grtext -1 (setq *global-progress-value* (vl-string-subst (nth 0 *global-progress-replace*) (nth 1 *global-progress-replace*) *global-progress-value*))) (setq *global-progress-increment* (1+ *global-progress-increment*)) (princ) ) ; Clear the global variable and the value posted to the status bar ; Usage: (progress-end) (defun progress-end ( / ) (setq *global-progress-value* nil *global-progress-increment* nil *global-progress-replace* nil) (grtext -1 "") (princ) ) (defun c:progress-test ( / count) (setvar "cmdecho" 0) (setq count 50) (progress-start) (while (> (setq count (1- count)) 0) (progress "Working: ") (princ) ) (progress-end) (setvar "cmdecho" 1) (princ) )

Exercise: Getting Input from the User to Draw the Plate

In this section, you will continue to build on the drawplate function that was originally introduced in Chapter 12. The key concepts I cover in this exercise are as follows:

Requesting Input Input functions can be used to get values from the user at the Command prompt.

Creating New Point Lists Values from different point lists can be used to create new coordinate values.

Using Conditional Statements Conditional statements are a great way to check the data provided by a user.

Looping Until a Condition Is Met Loops allow you to execute a set of expressions a specific number of times or while a condition remains true (T). You can use a loop to keep allowing the user to provide input.

NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Adding Holes to the Plate」section of Chapter 14. If you didn't complete the steps, do so now or start with the ch15_drawplate.lsp and ch15_utility.lsp sample files available for download from www.sybex.com/go/autocadcustomization. The sample files should be placed in the MyCustomFiles folder within the Documents (or My Documents) folder, or the location where you are storing the LSP files. Also, remove the ch15_ from the name of each file to match the filenames used in the steps.

Revising the drawplate Function

The changes to the drawplate function implement the use of user input to get points and distances, which are then used to draw the plate at various sizes and locations in the drawing. The following steps explain how to update the drawplate.lsp file with the revised drawplate function:

Open the drawplate.lsp file by doing one of the following: On Windows, browse to and double-click the drawplate.lsp file to open it in Notepad. If the file doesn't open, start Notepad and click File Open. From the Files Of Type drop-down list, select All Files (*.*). Then browse to and select the drawplate.lsp file, and then click Open.

On Mac OS, browse to and double-click the drawplate.lsp file to open it in TextEdit. If the file doesn't open, start TextEdit and click File Open. Browse to and select the drawplate.lsp file, and then click Open.

In the text editor area, locate the drawplate function and insert the following code snippet (or modify the text in the file to match what is formatted in bold):; Draws a rectangular plate (defun c:drawplate ( / pt1 pt2 pt3 pt4 width height basePt insPt textValue) ; Create the layer named Plate or set it current (createlayer "Plate" 5) ; Define the width and height for the plate (if (= *drawplate_width* nil)(setq *drawplate_width* 5.0)) (if (= *drawplate_height* nil)(setq *drawplate_height* 2.75)) ; Get recently used values from the global variables (setq width *drawplate_width*) (setq height *drawplate_height*) ; Prompt the current values (prompt (strcat "\nCurrent width: " (rtos *drawplate_width* 2) " Current height: " (rtos *drawplate_height* 2))) ; Set up default keywords (initget "Width Height") ; Continue to ask for input until a point is provided (while (/= (type (setq basePt (getpoint "\nSpecify base point for plate or [Width/Height]: ")) ) 'LIST ) (cond ; Prompt for the width of the plate ((= basePt "Width") (setq width (getdist (strcat "\nSpecify the width of the plate <" (rtos *drawplate_width* 2) ">: "))) ; If nil is returned, use the previous value from the global variable (if (/= width nil)(setq *drawplate_width* width)) ) ; Prompt for the height of the plate ((= basePt "Height") (setq height (getdist (strcat "\nSpecify the height of the plate <" (rtos *drawplate_height* 2) ">: "))) ; If nil is returned, use the previous value from the global variable (if (/= height nil)(setq *drawplate_height* height)) ) ) ; Set up default keywords again (initget "Width Height") ) ; Set the coordinates to draw the rectangle (setq pt1 basePt ;| lower-left corner |; pt2 (list (+ (car basePt) width) (cadr basePt) 0) ;| lower-right corner |; pt3 (list (+ (car basePt) width) (+ (cadr basePt) height) 0) ;| upper-right corner |; pt4 (list (car basePt) (+ (cadr basePt) height) 0) ;| upper-left corner |; ) ; Draw the rectangle (createrectangle pt1 pt2 pt3 pt4) ; Create the layer named Holes or set it as current (createlayer "Holes" 1) ; Draw the first circle (createcircle (polar pt1 (/ PI 4) 0.7071) 0.1875) ; Array the circle to create the other bolt holes (command "._-array" (entlast) "" "_r" 2 2 (- height 1) (- width 1)) ; Set the insertion point for the text label (setq insPt (getpoint "\nSpecify label insertion point: ")) ; Define the label to add (setq textValue (strcat "PLATE SIZE: " (vl-string-right-trim ".0" (rtos width 2 2)) "x" (vl-string-right-trim ".0" (rtos height 2 2)) ) ) ; Create label (createlayer "Label" 7) (createtext insPt "_c" 0.5 0.0 textValue) ; Save previous values to global variables (setq *drawplate_width* width) (setq *drawplate_height* height) ; Exit "quietly" (princ) )

Click File Save.

Using the Revised drawplate Function

Now that that the drawplate.lsp file has been revised, you must load the file into AutoCAD along with the utility.lsp file before you can use the changes made.

The following steps explain how to load the LSP files into AutoCAD and then start the drawplate function:

Do one of the following:

On the ribbon, click the Manage tab Customization panel Load Application (Windows).

On the menu bar, click Tools Load Application (Mac OS).

At the Command prompt, type appload and press Enter (Windows and Mac OS).

When the Load/Unload Applications dialog box opens, browse to the MyCustomFiles folder and select the drawplate.lsp file.

Press and hold the Ctrl key on Windows or the Command key on Mac OS, and select the utility.lsp file. Click Load.

If the File Loading - Security Concerns message box is displayed, click Load.

Click Close to return to the drawing area.

At the Command prompt, type drawplate and press Enter.

Press F2 on Windows or Fn-F2 on Mac OS to expand the command-line window. The current width and height values for the plate are displayed in the command-line history.Current width: 5.0000 Current height: 2.7500

At the Specify base point for the plate or [Width/Height]: prompt, type w and press Enter.

At the Specify the width of the plate <5.0000>: prompt, type 3 and press Enter.

At the Specify base point for the plate or [Width/Height]: prompt, type h and press Enter.

At the Specify the height of the plate <2.7500>: prompt, type 4 and press Enter.

At the Specify base point for the plate or [Width/Height]: prompt, pick a point in the drawing area to draw the plate and holes based on the width and height values specified.

At the Specify label insertion point: prompt, pick a point in the drawing area below the plate to place the text label.

Type zoom and press Enter, and then type e and press Enter.Figure 15.10 shows a number of different plates that were drawn at different sizes with the drawplate function.

Execute the drawplate function again, and pick a point in the drawing without changing the current width and height values. The plate should be drawn using the previous value.

Continue trying the drawplate function with different input values.

Figure 15.10 Completed plate





