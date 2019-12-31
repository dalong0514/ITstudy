# Chapter 14 Working with Lists

In the AutoLISP® programming language, an atom can be a function name, string, integer, real number, or another supported data type or symbol. A list is an expression that contains one or more atoms enclosed in parentheses. Each AutoLISP expression is a list, with the exception of those that start with an exclamation point. Lists often represent the following:

2D points or 3D points

Entity data that defines an object and its properties, commonly referred to as an association list containing dotted pairs

An object transformation matrix

A grouping of related data, such as all the layers or layouts in a drawing

In this chapter, you will learn to create and modify lists that represent coordinate values (points) and general data lists that contain one or more values. You will also learn to use geometric calculation functions that allow you to create new coordinate values from an existing coordinate values.

What Are Lists?

Lists are a data structure that can contain one or more elements that are placed between opening and closing parentheses. A list is comparable to an array in other programming languages. The elements in a list can be an AutoLISP function name or values based on one of the supported data types that you learned about in Chapter 12,「Understanding AutoLISP.」The values in a list can be of the same or different data types. Although each AutoLISP expression is technically a list, in this chapter the lists referred to are those expressions that contain any number of values.

The two most common AutoLISP lists are point lists and entity data lists. A point list contains either two or three numeric values that represent the X and Y coordinate values along with an optional Z coordinate value for a point in a drawing. The following code shows a point list that represents the coordinate value of 2.25, 6.5, 0.0:

(2.25 6.5 0.0)

Another common use for lists in AutoLISP is to represent an object and its properties through the use of entity data lists and dotted pairs. The following code is an example of a list that creates a new circle at the coordinate value of 5, 6.5 with a radius of 2:

((0. "CIRCLE") (10 5.0 6.5 0.0) (40. 2.0))

In Chapter 16,「Creating and Modifying Graphical Objects,」you'll learn how to create and work with entity data lists and dotted pairs.

Lists can improve the way you do your job, depending on what tasks you are trying to automate with AutoLISP. Point lists can be used with commands executed by a command function, and entity data lists can be used to create and modify objects without a command function.

Although I have nothing against command functions, I learned after a few years of writing AutoLISP programs that there was a downside to relying on such functions. As AutoCAD evolves and new releases are issued, commands can change in ways that cause custom programs to no longer work correctly after you upgrade to the latest release. By relying less on standard commands, my programs require fewer changes between releases and are more flexible.

Creating and modifying objects directly with entity data lists can add some complexity to a program, but can also reduce the impact that system variables have on custom programs. For example, when you're using a command, running object snaps need to be disabled; when you're working with entity data lists, they don't. Based on the number of objects you need to create, directly working with entity data can also be faster.

Learning to work with entity data lists also allows you to create or modify objects that you normally can't manipulate from the Command prompt. For example, tables can't be created, populated, or modified easily (or at all) from the Command prompt. You can't create and modify table styles from the Command prompt. You can do all that and more using entity data lists.

Lists to the Rescue

Ever have one of those days when you wish you hadn't opened your email? Imagine that the first message you read today contained the results from a drop test that showed the chassis bolts. Results from a drop test showed that the chassis bolts in your latest design are too small; several sheared off. Not only do you need to update the bill of materials (BOM) for all six models, but hole sizes need changing in 24 drawings. And now, corporate wants BOMs presented on each drawing—in alphabetical order, no less! Three headaches in less than five minutes. Thank goodness for AutoLISP.

First, you set up a custom program. Use filter lists to create selection filters that allow you to select all of those circles that represent the bolt holes. You can also use filter lists to select objects on a specific layer or even blocks with a specific name. Once the circles are selected, changing the size is a snap.

Now, on to the BOM. You create a BOM program that tabulates the objects and values in the drawings and places the results in a table. Lists can be created of the circles and other graphical objects, attribute values from the blocks, or the names of all the blocks inserted into a drawing. Once the list is populated, you then sort and count similar values. Finally, you place the results into each drawing as lines and text or a table object.

For today, AutoLISP lists are your best friend.

Creating a List

When you want to define a point list, use the list function. The following code creates a 2D point list that represents the point 2.25, 6.5 in a drawing:

(list 2.25 6.5) (2.25 6.5)

If you were to enter (2.25 6.5) at the AutoCAD Command prompt, the message error: bad function: 2.25 would be displayed. Remember that the first atom or element entered after an opening parenthesis must be a function. The error message is letting you know AutoLISP doesn't know anything about the function named 2.25.

The following shows the syntax of the list function:

(list atomN)

The atomN argument represents the values or expressions that should be combined to create a list.

Here are some examples of lists created with the list function and the values that are returned:

; 2D Point - Coordinate 5,2.25 (list 5.0 2.25) (5.0 2.25) ; 3D Point - Coordinate 5,2.25,1 (list 5 2.25 1) (5 2.25 1) ; Appends two lists to create a point list (setq Z 0.0) (append (list 5 2.25) (list Z)) (5 2.25 0.0)

In addition to the list function, you can use the quote function to define a list. As an alternative to the quote function, you can use an apostrophe ('). Although the list and quote functions are similar, there is one main difference between the two functions: The list function evaluates all variables and expressions that it is passed before returning a list, whereas the quote function doesn't evaluate any of the variables or nested expressions it is passed before returning a list.

The following expression shows the syntax of the quote function expressed with and without the apostrophe:

'(expressionN) or (quote expressionN)

The expressionN argument represents the expressions that should be combined to create a list.

The following are examples of lists created with the quote ( ‘ ) function and the values that are returned:

; 2D Point - Coordinate 5,2.25 '(5.0 2.25) (5.0 2.25) ; 3D Point - Coordinate 5,2.25,1 (quote (5 2.25 1)) (5 2.25 1) ; Appends two lists without evaluating the variables (append '(5 2.25) (quote (Z))) (5 2.25 Z)

In addition to the AutoLISP list and quote (‘) functions, you can use the cons and vl-list* functions. I discuss how to use the cons function in Chapter 16. The vl-list* function combines the functionality of the list and cons functions; see the AutoCAD Help system for more information on the vl-list* function.

This exercise shows how to create two point lists that represent the opposite corners of a desk's top:

At the AutoCAD Command prompt, type (setq width 60 depth 30) and press Enter.The user-defined variables width and depth are assigned the values 60 and 30, respectively.

Type (setq LL '(0 0 0)) and press Enter.(0 0 0) is assigned to the LL user-defined variable. The apostrophe before (0 0 0) results in the list not being evaluated, which is fine in this case because the list is made up of all static numeric values.

Type (setq UR '(width depth 0)) and press Enter.(WIDTH DEPTH 0) is assigned to the UR user-defined variable. The value of (WIDTH DEPTH 0) is as expected because the apostrophe tells AutoLISP not to evaluate the values before returning the list. Remember, when using variables in a list you usually want them to be evaluated so that the values that are assigned are used.

Type (setq UR (list width depth 0)) and press Enter.(60 30 0) is assigned to the UR user-defined variable. Since the list function does evaluate the variables in a list, a value point list is assigned to the UR user-defined variable.

Type (command "._line" LL UR "" "._zoom" "_e") and press Enter.The line command draws a line between the points specified by the LL and UR user-defined variables. The zoom command with the e option zooms to the extents of the objects in the drawing.

Getting an Element from a List

A value in a list is known as an element. You can retrieve a specific element from a list by referencing the element's index, or step through a list and perform an action on each element. The first element of a list is not located at 1 as you might think, but rather at 0. The second element is at index 1, and so on. For example, in a 2D point list (X Y), the X coordinate value is located at index 0, whereas the Y coordinate value is located at index 1.

Retrieving a Specific Element

You can retrieve a specific element from a list based on a known index or get the position of an element within a list based on the element's value. Getting a specific element in a list allows you to pass that value to an AutoLISP function or add the value to a new list. For example, a new point list can be created from the elements in one or more point lists.

The AutoLISP car function can be used to return the first element of a list, whereas its companion function, cdr, returns a new list with the first element removed. The following shows the syntax of the car and cdr functions:

(car list) (cdr list)

The list argument represents the list from which you want to retrieve a value.

The following are examples of the car and cdr functions, and the values that are returned:

; 3D Point list - Coordinate 5,2.25,1 (setq pt '(5.0 2.25 1)) (5 2.25 1) ; Return the X coordinate value (car pt) 5 ; Return the Y and Z coordinate values (cdr pt) (2.25 1)

Although the car function can be used to get the first element of a list, you can use the car and cdr functions in a nested AutoLISP expression to get other elements from a list. The following shows how to get the second and third elements (Y and Z coordinate values) of a point list:

; Return the Y coordinate value (car (cdr pt)) 2.25 ; Return the Z coordinate value (car (cdr (cdr pt))) 1

Using multiple car and cdr functions to retrieve elements from large lists can become overwhelming. To make it easier to access specific elements within a list, AutoLISP provides a number of functions that combine the functionality of the car and cdr functions. For example, you can use the functions cadr and caddr to retrieve the first and second elements of a list. The following shows how to get the first and second elements (Y and Z coordinate values) of a point list:

; Return the Y coordinate value (cadr pt) 2.25 ; Return the Z coordinate value (caddr pt) 1

NOTE

AutoLISP supports combinations of the car and cdr functions up to four levels. These functions start with the letter c and end with r. Between the c and r , you add an a when you want to use the car function and d when you want to use the cdr function. The combination functions are read from right to left. For example, the caddr function performs a cdr on the list passed to the function first, a second cdr is performed on the listed returned, and then that is followed by a car function. For a full listing of the supported combinations, search on the keywords「point lists」in the AutoCAD Help system.

This exercise shows how to create two point lists based on the current values assigned to other point lists:

At the AutoCAD Command prompt, type (setq UR (list 60 30)) and press Enter.

Type !UR and press Enter.(60 30), which is the value assigned to the UR user-defined variable, is returned.

Type (car UR) and press Enter.60 is returned because the car function returns the first element of a list.

Type (cadr UR) and press Enter.30 is returned because the cadr function returns the second element of a list.

Type (setq LL (list 0 0)) and press Enter.(0 0) is assigned to the LL user-defined variable.

Type (setq UL (list (car LL) (cadr UR))) and press Enter.(0 30) is assigned to the UL user-defined variable. The new list is created by the first element of the list assigned to the LL user-defined variable and the second element of the list assigned to the UR user-defined variable.

Type (setq LR (list (car UR) (cadr LL))) and press Enter.(60 0) is assigned to the LR user-defined variable. The new list is created by the first element of the list assigned to the UR user-defined variable and the second element of the list assigned to the LL user-defined variable.

Type (command "._pline" LL LR UR UL "_c" "._zoom" "_e") and press Enter.The pline command draws a four-segment polyline that forms a rectangle. The zoom command with the e option zooms to the extents of the objects in the drawing.

Instead of using just the car, cdr, or a combination of the two functions to retrieve an element from a large list, you can use the AutoLISP nth function. The nth function returns an element from a list based on a specific index value, starting with 0. If an element exists at the specified index, the value of the element is returned; otherwise, if the list doesn't contain enough elements based on the index value passed to the nth function, the function returns nil.

The following shows the syntax of the nth function:

(nth index list)

Here are the arguments:

index The index argument represents the position in the list for the element you want to retrieve; 0 is the first element in a list.

list The list argument represents the list from which you want to retrieve a value.

The following are examples of the nth function and the values that are returned:

; 3D Point - Coordinate 5.0,2.25,1 (setq pt '(5.0 2.25 1)) (5.0 2.25 1) ; Return the X coordinate value (nth 0 pt) 5.0 ; Return the Y coordinate value (nth 1 pt) 2.25 ; Return the Z coordinate value (nth 2 pt) 1

In addition to the AutoLISP car, cdr, and nth functions, you can use the last function to get the last element of a list or the vl-position function to get the index of a specific value within a list. The following examples demonstrate the use of the last and vl-position functions:

; Create a list with system variable names (setq vars '("osmode" "cmedecho" "filedia")) ("osmode" "cmedecho" "filedia") ; Return the last element of the list (last vars) "filedia" ; Return the index of the value in the list (vl-position "cmdecho" vars) 1 (vl-position "cmddia" vars) nil

For more information on the last and vl-position functions, see the AutoCAD Help system.

This exercise has you working with a list containing several string values that represent the seven standard AutoCAD colors. You will use the nth function to retrieve a specific element from the list and get the last element in the list with the last function:

At the AutoCAD Command prompt, type (setq namedColors (list "Yellow" "Red" "Green" "Cyan" "Blue" "Magenta" "White")) and press Enter.

Type (nth 0 namedColors) and press Enter."Yellow" is returned because it is in the first position of the list, which as I previously mentioned is at index 0.

Type (nth 4 namedColors) and press Enter."Blue" is returned because it is the fifth element in the list or the element at index 4.

Type (nth 7 namedColors) and press Enter.nil is returned because it is outside the length of the list.

Type (last namedColors) and press Enter."White" is returned since it is the last element in the list.

Stepping Through a List

Lists commonly don't have a fixed number of elements like a point list, which has either two or three elements. When you're working with graphical and nongraphical objects, the data list for an object might have fewer than 10 elements for one object, whereas it could have dozens of elements for another object. Getting each element of a point list with the car, cdr, or nth functions is fairly straightforward since you have to work with only two or three elements. Instead of getting each element with its own expression, you can use a looping expression to step through the list one element at a time. As you step through a list, you can use an element in an expression and then proceed to the next element in the list until you have accessed all of the elements in the list.

The AutoLISP foreach function is designed specifically for stepping through the elements of a list. There are other functions that could be used to step through a list or even execute a series of AutoLISP expressions until a condition is met. I cover other functions that can be used to create looping expressions in Chapter 15,「Requesting Input and Using Conditional and Looping Expressions.」

The following is the syntax of the foreach function:

(foreach variable list [expressionN …])

Here are the arguments:

variable The variable argument represents the user-defined variable that each element of the list argument will be assigned as the list is processed.

list The list argument represents the list that you want to step through.

expressionN The expressionN argument represents the expressions that should be executed for each element in the list argument. The value of the list element is accessed with the name in the variable argument.

The following is an example of the foreach function, which steps through a list that contains the name of each named layout in a drawing:

; List of standard AutoCAD colors (setq namedColors (list "Yellow" "Red" "Green" "Cyan" "Blue" "Magenta" "White")) Returns: ("Yellow" "Red" "Green" "Cyan" "Blue" "Magenta" "White") ; Step through and output the name of each element in the list (prompt "\nColors: ") (foreach color namedColors (prompt (strcat "\n " color)) ) Returns: Colors: Yellow Red Green Cyan Blue Magenta White nil

The previous example uses the AutoLISP prompt function, which is used to display a string in the command-line window. I will discuss this and other functions that can be used to provide feedback to the user in Chapter 15.

Knowing the number of items in a list can be helpful when you want to step through a list using the AutoLISP while or repeat function, described in Chapter 15. The following shows the syntax of the length function:

(length list)

The list argument represents the list for which you want to know the number of elements.

The following are examples of the length function and the values that are returned:

(setq namedColors (list "Yellow" "Red" "Green" "Cyan" "Blue" "Magenta" "White")) ("Yellow" "Red" "Green" "Cyan" "Blue" "Magenta" "White") (length namedColors) 7 (length '(0 3 0)) 3 (length '()) 0

TIP

You can also use the AutoLISP vl-list-length function to return the number of elements in a list. However, unlike the length function, the vl-list-length function doesn't produce an error if a list represents a dotted pair. You'll learn about dotted pairs in Chapter 16.

Appending, Substituting, and Removing Elements

The AutoLISP list and quote functions allow you to create a list based on a set of known values. However, there will be times when you want to create a list based on a set of unknown values. For example, you might want to create a list of objects that your program created in a drawing while the drawing remains open, or a list of the system variables that you have recently changed so they can be restored.

Appending Elements

You can append an atom to an existing list using the AutoLISP append function. You must ensure that the atom is contained in a list before you pass it to the append function. After the lists are appended together, a new list is returned with the elements of all the lists passed to the append function.

The following shows the syntax of the append function:

(append [listN …])

The listN argument represents the lists that you want to append together. nil can be passed as a list for the listN argument. The order in which lists are passed to the append function is the same order in which they are appended. The listN argument is optional. If no list is passed to the listN argument, the append function returns nil.

The following are examples of the append function and the values that are returned:

(append) nil (append '("X") '("Y" "Z")) ("X" "Y" "Z") (append nil '("1" "2")) ("1" "2") (setq Z 5) (append (list 0 0) (list Z)) (0 0 5)

Much of the time you will likely be working at the current elevation, so you will only need to work with points that need an X and Y coordinate value. However, you might need to place objects at different elevations; this requires you to supply a Z coordinate value as part of the point list. This exercise shows how to add a Z coordinate value to a 2D point list:

At the AutoCAD Command prompt, type (setq LL '(0 0) UR '(60 30)) and press Enter.

Type (command "._rectang" LL UR) and press Enter.The rectang command draws a four-sided rectangle on the current working plane.






Type (setq Z '(5)) and press Enter.

Type (setq LL (append LL Z)) and press Enter.(0 0 5) is returned. The append function returns the results of combining the two lists, (0 0) and (5), together.

Type (setq UR (append UR Z)) and press Enter.(60 30 5) is returned.

Type (command "._rectang" LL UR "._-view" "_swiso" "._zoom" "_e") and press Enter.The rectang command draws a rectangle at an elevation of five units above the current working place. The -view command with the swiso option sets the southwest isometric view as current, whereas the zoom command with the e option zooms to the extents of the objects in the drawing.

Substituting Elements

An element in a list can be replaced with a new element or list. Substituting an element for another can be done with the AutoLISP subst (short for substitution) function. The subst function returns either a new list containing the updated element or nil. A new list is returned only when the old element is successfully found and the substitution occurs.

The following shows the syntax of the append function:

(subst new_element old_element list)

Here are the arguments:

new_element The new_element argument represents the element that should be used to replace the element specified by the old_element argument if found in the list argument.

old_element The old_element argument represents the element that is to be replaced if found in the list argument by the element specified with the new_element argument.

list The list argument represents the list that contains the element you want to replace.

The following are examples of the subst function and the values that are returned:

(subst "A1" "A?" '("A?" "B1" "C1")) ("A1" "B1" "C1") (subst "A1" "A!" '("A?" "B1" "C1")) ("A?" "B1" "C1") (subst '(1 2 0) '(0 0 0) '((0 0 0) (5 5 0))) ((1 2 0) (5 5 0))

The AutoLISP subst function is very useful when you're creating and modifying entity data lists that represent the properties of an object. You'll learn how to create and modify the values of an entity data list with the subst function in Chapter 16.

Removing Elements

Elements located in a list can be removed when they are no longer needed. Earlier you saw how the AutoLISP cdr function can be used to remove the first element from a list, but often you will want to remove an element based on its current value. You can also step through a list using the foreach function, and then evaluate the value of each element in the list and determine which elements should be removed. An element can be more efficiently removed using the AutoLISP vl-remove function.

The following shows the syntax of the vl-remove function:

(vl-remove element list)

Here are the arguments:

element The element argument represents the element that should be removed from the list specified by the list argument. If more than one element in the list is matched, all matched elements are removed.

list The list argument represents the list that contains the element you want to remove.

The following are examples of the vl-remove function and the values that are returned:

(vl-remove "A?" '("A?" "B1" "C1")) ("B1" "C1") (setq lst (list "A1" "B1" "A1" "C1")) (vl-remove (nth 3 lst) lst) ("A1" "B1" "A1") (setq lst (list "A1" "B1" "A1" "C1")) (vl-remove (nth 2 lst) lst) ("B1" "C1") (vl-remove '(0 0 0) '((0 0 0) (1 2 0) (2 4 0) (5 5 0))) ((1 2 0) (2 4 0) (5 5 0))

In addition to removing an element by its value, you can remove from a list all elements that don't match a test function. The test function that is used must return T or nil. For example, you could remove all the numbers from or keep all the numbers in a list. The AutoLISP functions that allow you to filter elements by their value from a list are as follows:

vl-remove-if Removes from a list all elements that result in the test function returning T

vl-remove-if-not Removes from a list all elements that result in the test function returning nil

The following are examples of the vl-remove-if and vl-remove-if-not functions, and the values that are returned:

(vl-remove-if 'numberp '("A?" 1 1.5 T PI (0 0 0))) ("A?" T PI (0 0 0)) (vl-remove-if-not 'numberp '("A?" 1 1.5 T PI (0 0 0))) (1 1.5)

For more information on the AutoLISP vl-remove-if and vl-remove-if-not functions, see the AutoCAD Help system.

Determining Whether an Item Exists in a List

When creating and modifying a list, you might want to search the list for the existence of an element with a specific value before trying to add or remove an element that would contain the same value. Although you could step through a list to determine whether an element with a specific value already exists, the AutoLISP member function is a more efficient way to search for a value in a list. The member function returns a list containing the element that matches the test expression along with all the elements after it; otherwise nil is returned.

The following is the syntax of the member function:

(member expression list)

Here are the arguments:

expression The expression argument represents the element that you want to search for in the list specified by the list argument.

list The list argument represents the list that contains the element you want to search for.

The following are examples of the member function and the values that are returned:

(member "B1" '("A?" "B1" "C1")) ("B1" "C1") (member "D1" '("A?" "B1" "C1")) nil (member '(2 4 0) '((0 0 0) (1 2 0) (2 4 0) (5 5 0))) ((2 4 0) (5 5 0))

You can also search all elements in a list and return the element that matches the result of a test function in addition to all elements after it. The test function that is used must return T or nil. For example, you could search for a number or non-numeric value in a list, and return the first element that matches the test condition and all the elements after it in the list. The AutoLISP functions that allow you to search for elements in a list are as follows:

vl-member-if Searches the elements in a list and returns the first element that causes the test function to return T. All elements after the first element that results in a match are also returned.

vl-member-if-not Searches the elements in a list and returns the first element that causes the test function to return nil. All elements after the first element that results in a failed match are also returned.

The following are examples of the vl-member-if and vl-member-if-not functions, and the values that are returned:

(vl-member-if 'numberp '("A?" 1 1.5 T PI (0 0 0))) (1 1.5 T PI (0 0 0)) (vl-member-if-not 'numberp '("A?" 1 1.5 T PI (0 0 0))) ("A?" 1 1.5 T PI (0 0 0))

Although the vl-member-if and vl-member-if-not functions can be used to search for the first element that does or doesn't match the test function, you can also check to see if one or all of the elements in a list match a test function. The AutoLISP functions that allow you to test the elements in a list are as follows:

vl-some Tests to see if one or more elements in a list causes the test function to return T. If at least one element causes the test function to return T, the vl-some function returns T; otherwise, nil is returned.

vl-every Tests to see if all elements in a list cause the test function to return T. If all elements cause the test function to return T, the vl-element function returns T; otherwise, nil is returned.

The following are examples of the vl-some and vl-every functions, and the values that are returned:

(vl-some 'numberp '("A?" 1 1.5 T PI (0 0 0))) T (vl-some 'numberp '("A?" "B1" "C1")) nil (vl-every 'numberp '("A?" 1 1.5 T PI (0 0 0))) nil

For more information on the AutoLISP vl-member-if, vl-member-if-not, vl-some, and vl-every functions, see the AutoCAD Help system.

Sorting the Elements of a List

Elements in a list often don't need to be in any specific order except when the list represents a coordinate or the list will be used to present information to the user. Lists can be stored alphabetically or numerically. It is even possible to sort nested values within a list.

Table 14.1 provides an overview of the functions that can be used to sort a list.

Table 14.1 AutoLISP list sorting functions

Function Description

acad_strlsort Accepts a list and sorts the elements in the list alphabetically. If the elements could be sorted, a new list is returned; otherwise the function returns nil.

vl-sort Accepts a list and sorts the elements in the list based on the results of a comparison function. A new list of the sorted elements is returned.

vl-sort-i Accepts a list and sorts the elements in the list based on the results of a comparison function. A new list containing the indexes of the sorted elements is returned.

The following are examples of the acad_strlsort, vl-sort, and vl-sort-i functions, and the values they return:

(acad_strlsort '("BC" "A2" "A1" "BB" "B1")) ("A1" "A2" "B1" "BB" "BC") (vl-sort '("BC" "A2" "A1" "BB" "B1") '>) ("BC" "BB" "B1" "A2" "A1") (vl-sort-i '("BC" "A2" "A1" "BB" "B1") '>) (0 3 4 1 2)

For more information on the AutoLISP acad_strlsort, vl-sort, and vl-sort-i functions, see the AutoCAD Help system.

TIP

The acad_ strlsort function sorts all elements of a list in an ascending or alphabetic order. You can reverse the order of a list using the AutoLISP reverse function, which returns a new list of the items presented in the opposite order. If the list was previously sorted, this would give you a list that is now sorted in descending order.

Using Point Lists to Calculate Geometric Values

The math functions discussed in Chapter 13,「Calculating and Working with Values,」are great for calculating numeric values based on other numeric values, but they aren't specifically designed to work with point lists. Although you can use the functions described in the previous section to get the values of a point list and then manipulate the values with the math functions, AutoLISP does provide a set of functions that are designed specifically for working with point lists and other geometric values. AutoLISP contains functions that allow you to

Calculate an angular or distance value between two points

Return a new coordinate based on a starting point, in a specified direction, and along a specified angle

Calculate the intersection between two lines

Return a coordinate value at a point using an object snap

Translate a coordinate value from one user coordinate system (UCS) to another

Convert values between measurement units

Access the AutoCAD calculator

Measuring Angular and Distance Values

When you draw or modify an object, you commonly need to know either where that object should be created or its geospatial relationship to other objects in a drawing. Almost all objects created in a drawing require you to calculate angular or distance values, if not both, so you can properly locate the object. You can use the AutoLISP angle and distance functions to calculate an angle or 3D distance between two points. The angle function returns a 2D angle in radians between two points as a real number, and the distance function returns a 3D distance as a real number between the two points.

The following shows the syntax of the angle and distance functions:

(angle point1 point2) (distance point1 point2)

Here are the arguments:

point1 The point1 argument represents the first coordinate.

point2 The point2 argument represents the second coordinate on which the angular or distance value should be calculated. The angular value is calculated in only two dimensions; the Z coordinate value is ignored for the angle function.

The following are examples of the angle and distance functions, and the values that are returned:

(angle '(0 0 0) '(0 4 4)) 1.5708 (angle '(0 0 0) '(0 4 0)) 1.5708 (distance '(0 0 0) '(0 4 4)) 5.65685 (distance '(0 0 0) '(0 4 0)) 4.0

Calculating Points

When you create or modify an object, you frequently need to calculate a point based on another point on or near an object to accurately place the new object or modify the existing graphical object. While you could prompt the user to specify all the points you might need in the drawing, that can lead to unnecessary steps in a workflow. It is always best to calculate any and all points that you can with minimal input from the user.

The AutoLISP polar function returns a 2D or 3D point in the current UCS, based on an angle and distance from a point. The result of a polar function is similar to specifying a relative polar coordinate through the AutoCAD user interface.

The following is the syntax of the polar function:

(polar point angle distance)

Here are the arguments:

point The point argument represents the coordinate point in the drawing that you want to calculate the new point from. If a 2D point is specified, a 2D point is returned; specifying a 3D point results in a 3D point being returned.

angle The angle argument represents the angle in radians that the new point should be located from the coordinate point specified with the point argument.

distance The distance argument represents the distance at which the new point should be calculated from the point argument and along the angle specified by the angle argument.

The following are examples of the polar function and the values that are returned:

(polar '(0 0 0) (/ PI 4) 3) (2.12132 2.12132 0.0) (polar '(1 2) PI 1) (0.0 2.0)

Finding and Snapping to Points

The AutoLISP polar function allows you to calculate a new coordinate point in the current UCS based on an angle and distance from a point. However, you will often want to work with existing points in a drawing as well. Since objects drawn in a drawing should be accurately placed, you should use object snaps to make sure a point is located on an object.

The AutoLISP osnap function allows you to acquire a point on an object using an Object Snap mode. The point must be within the aperture of the crosshairs. The aperture is the box at the intersection of the crosshairs, and the size of the aperture can be adjusted with the aperture system variable. If a point on an object can't be acquired with a specified Object Snap mode, nil is returned; otherwise the acquired point is returned. The Object Snap modes available are the same that you can enter at the Command prompt when you're prompted for a point; see the osnap command topic in the AutoCAD Help system for a full list of Object Snap modes.

The following shows the syntax of the osnap function:

(osnap point osnap_mode)

Here are the arguments:

point The point argument represents the coordinate near an object that you want use to acquire a point on an object with the Object Snap mode set by the osnap_mode argument.

osnap_mode The osnap_mode argument represents the Object Snap modes you want to use. Object Snap modes are passed as a comma-delimited string.

The following are examples of the osnap function and the values that are returned:

; Draw a line and circle (command "._line" '(0 0 0) '(2.5 4 0) "") (command "._circle" '(1.25 2 0) 2) ; Check for intersection point of the line and circle (osnap '(0.188 0.302 0) "_INT") (0.190002 0.304003 0.0) ; Check for center point (osnap '(1 1.6 0) "_CEN") nil ; Check for endpoint and midpoint, and return the object snap point found (osnap '(0 0 0) "_END,_MID") (0.0 0.0 0.0) ; Check for endpoint and midpoint, and return the object snap point found (osnap '(1 1.6 0) "_END,_MID") (1.25 2.0 0.0)

The INTersection Object Snap mode with the osnap function can be used to check for the intersection of two or more objects, but the geometry must exist in the drawing first. The AutoLISP inters function allows you to calculate the intersection between two lines or vectors without actually creating the objects in the drawing first. If the lines or vectors don't intersect, nil is returned; otherwise the intersection point is returned. The following shows the syntax for the inters function:

(inters point1 point2 point3 point4 [on_segments])

Here are the arguments:

point1 The point1 argument represents the first coordinate of the first line segment.

point2 The point2 argument represents the second coordinate of the first line segment.

point3 The point3 argument represents the first coordinate of the second line segment.

point4 The point4 argument represents the second coordinate of the second line segment.

on_segments The on_segements argument indicates if the intersecting point must lie on the line segments or off the line segments by projecting the lines to infinity in both directions. The on_segments argument is optional, but it is enabled by default. Providing a value of nil indicates that vectors should be drawn to infinite lengths.

The following are examples of the inters function and the values that are returned:

(inters '(0 0 0) '(4 4 0) '(1 2 0) '(2 0 0)) (1.33333 1.33333 0.0) (inters '(2 3 0) '(0 3 0) '(1 0 0) '(1 1 0)) nil (inters '(2 3 0) '(0 3 0) '(1 0 0) '(1 1 0) nil) (1.0 3.0 0.0)

Translating Points

A drawing contains several different coordinate systems, and it is possible to draw objects using coordinate systems other than the current one. Commands used with the command function work only in the current coordinate system, but when working with existing objects you might need to translate a point between two different coordinate systems.

You can use the AutoLISP trans function to translate a coordinate value between the world coordinate system (WCS), current UCS, or display coordinate system. The following shows the syntax of the trans function:

(trans point current_coordsystem new_coordsystem displacement)

Here are the arguments:

point The point argument represents the 2D or 3D point that you want to translate.

current_coordsystem The current_coordsystem argument represents the coordinate system of the point argument being translated.

new_coordsystem The new_coordsystem argument represents the coordinate system that the point argument is being translated to.

displacement The displacement argument indicates if the point argument should be treated as a 3D displacement instead of a 3D point. The displacement argument is optional. Providing a value of T indicates that the point argument should be converted as a 3D displacement value.

The following are examples of the trans function and the values that are returned:

; Change the current UCS by rotating the X axis (command "._ucs" "_x" -90) nil ; Convert the point from WCS to the current UCS (trans '(1 2 0) 0 1) (1.0 -4.44089e-016 2.0) (trans '(1.0 -4.44089e-016 2.0) 1 0) (1.0 2.0 -2.0985e-022) ; Change the current UCS back to the WCS (command "._ucs" "_w") nil

For more information on the AutoLISP trans function, search on the keywords「trans AutoLISP」in the AutoCAD Help system.

Converting Measurement Units

AutoCAD is used by many large and small companies around the world. Although it would be nice if there were a universal system of measurements, the fact is that there are still countries that use the imperial system of weights and measurements, whereas most of the world uses the metric system. AutoLISP can't resolve the measurement-unit problem in the world, but it can help you convert from one unit of measurement to another.

The AutoLISP cvunit function allows you to convert values between different linear, angular, weight, volume, and other unit types. The unit types that are available for use are listed in the acad.unt file, which can be found in the support file search paths of AutoCAD.

The following explains the syntax of the cvunit function:

(cvunit value current_unit new_unit)

Here are the arguments:

value The value argument represents the numeric or coordinate (2D or 3D) point that you want to convert.

current_unit The current_unit argument represents the unit type of the value argument being converted.

new_unit The new_unit argument represents the unit type that the value argument is being converted to.

The following are examples of the cvunit function and the values that are returned:

(cvunit 3.75 "m" "ft") 12.3031 (cvunit 15.0 "inch" "ft") 1.25 (cvunit '(1.0 2.0) "m" "ft") (3.28084 6.56168)

Accessing the AutoCAD Calculator

AutoCAD contains two built-in calculators that can be used to perform math and geometric calculations: the AutoCAD quickcalc command (on Windows only) and the AutoCAD cal command. The AutoCAD quickcalc command displays either a palette or dialog box, which is less than ideal for AutoLISP programs because the choices a user might make are hard to predict and can produce unexpected results.

The AutoCAD cal command is available from the Command prompt or as an AutoLISP function with the same name. The AutoLISP cal function can be very useful if your programs need to perform complex math and geometric calculations. The functions that are available to the cal function are the same as those available to the cal command. For information on the functions available to the cal command, search on the keywords「cal command」in the AutoCAD Help system.

NOTE

The geomcal.arx or geomcal.crx file must be loaded into AutoCAD before the AutoLISP cal function can be used. You can use the AutoLISP arxload function to load one of the geomcal files from the LSP file that uses the cal function. For example, (arxload "geomcal") will load the geomcal.arx or goamcal.crx file based on which one is found in the support file search paths for AutoCAD.

The following explains the syntax of the cal function:

(cal expression)

The expression argument represents the string that contains the values and functions that should be executed by the cal function.

The following are examples of the cal function, and the values that are returned:

(cal "1 + 2") 3 ; Calculates the midpoint between two user-specified ; points using the endpoint object snap (cal "(END+END)/2") Specify two endpoints on objects in the drawing area; the returned point list will be different than the following (8.2857 13.7603 0.0) ; Calculates the midpoint between the coordinates 0,0,0 and 3,3,0 (cal "([0,0,0]+[3,3,0])/2") (1.5 1.5 0.0)

Converting Lists to Strings and Strings to Lists

Lists are commonly used for coordinates, but they can also be used to represent the data that makes up an object or the characters that make up a string. A list of ASCII codes can be used to create a string, or a string can be converted into a list of ASCII codes. An ASCII code is an integer value equivalent to a character in a string. You saw how to work with and convert strings in Chapter 13.

The following explains the functions that can be used to convert a list to a string or string to a list:

vl-string->list The vl-string->list function accepts a string and returns a list that contains the ASCII codes for all characters in the string.

vl-list->string The vl-list->string function accepts a list of integer values that represent ASCII codes and returns a string based on the ASCII codes in the list.

The following are examples of the vl-string->list and vl-list->string functions, and the values that are returned:

(vl-string->list "Project address") (80 114 111 106 101 99 116 32 97 100 100 114 101 115 115) (vl-list->string '(80 114 111 106 101 99 116 32 97 100 100 114 101 115 115)) "Project address"

For more information on these functions, see the AutoCAD Help system.

Exercise: Adding Holes to the Plate

In this section, I expand on the drawplate and utility functions that were introduced in Chapter 13. I also apply some of the concepts that were introduced in this chapter. The key concepts that are covered in this exercise are as follows:

Calculating Numeric Values Basic math functions can be used to calculate new distances or increase an angle.

Calculating New Coordinates Coordinate values can be calculated using the AutoLISP polar function.

Creating and Manipulating Lists Lists can be used to store multiple values in a variable. A list can be created using the AutoLISP list, quote, or cons function, and elements within a list can be retrieved using the nth function. The append function can be used to add a new element to a list, whereas the assoc function can be used to verify whether an element already exists in a list. If an element is in a list, the subst function can be used to replace one element with another.

Stepping Through a List Each element in a list can be retrieved and processed using the AutoLISP foreach function.

NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Drawing a Rectangle (Revisited)」section of Chapter 13. If you didn't complete the steps, do so now or start with the ch14_drawplate.lsp and ch14_utility.lsp sample files available for download from www.sybex.com/go/autocadcustomization. You should place these sample files in the MyCustomFiles folder under the Documents (or My Documents) folder, or the location you are using to store the LSP files. Also, remove the「ch14_」from the name of each file.

Defining the New Get-Sysvars and Set-Sysvars Utility Functions

When using AutoLISP, you should always consider your end user and be mindful of the current AutoCAD environment. This is why I have you store the current value of a system variable in a local variable before you change the system variable's value. Then, before a function ends, you restore the previous value of each system variable that you changed.

To take this approach, you have to write three expressions each time you want to store, set, and restore the value of a system variable. You can use expressions that look similar to the following code to store, set, and restore the osmode and cmdecho system variables in a custom function:

(defun <function_name> (/ old_osmode old_cmdecho) ; Store and change the value of the OSMODE and CMDECHO system variables (setq old_osmode (getvar "osmode") old_cmdecho (getvar "cmdecho")) (setvar "osmode" 0) (setvar "cmdecho" 0) […] ; Restore the value of the OSMODE and CMDECHO system variables (setvar "osmode" old_osmode) (setvar "cmdecho" old_cmdecho) )

You should never feel that storing and restoring the values of the system variables is not worth the effort; it improves the experience that users have with your custom programs and AutoCAD. However, it is a bit of extra work for you as a programmer; especially if you are changing three or more system variables.

As a programmer, I am almost always looking for easier and more efficient ways to write code. As an alternative to writing multiple expressions to store, set, and restore each system variable in a function, you can create custom functions that wrap and simplify the functionality for you.

The following exercise shows how to define two custom functions that allow you to store and then set the values of system variables that are part of a list. The functions you will be defining are named Get-Sysvars and Set-Sysvars.

Open the utility.lsp file in Notepad on Windows or TextEdit on Mac OS.

In the text editor area, position the cursor after the last expression in the file and press Enter twice. Then type the following; the comments are here for your information and don't need to be typed:; Get-Sysvars function returns a list of the current values ; of the list of system variables it is passed. ; ; Arguments: ; sysvar-list - A list of system variables ; ; Usage: (get-sysvars (list "clayer" "osmode")) ; (defun get-sysvars (sysvar-list / values-list) ; Creates a new list based on the values of the ; system variables in sysvar-list (foreach sysvar sysvar-list ; Get the value of the system variable and add it to the list (setq values-list (append values-list (list (getvar sysvar)))) ) ; List to return values-list ) ; Set-Sysvars function sets the system variables in the ; sysvar-list to the values in values-list. ; ; Arguments: ; sysvar-list - A list of system variables ; values-list - A list of values to set to the system variables ; ; Usage: (set-sysvars (list "clayer" "osmode") (list "Plate" 0)) ; (defun set-sysvars (sysvar-list values-list / cnt) ; Set the counter to 0 (setq cnt 0) ; Step through each variable and set its value. (foreach sysvar sysvar-list (setvar sysvar (nth cnt values-list)) ; Increment the counter (setq cnt (1+ cnt)) ) (princ) )

Click File Save.

Defining the New createcircle Utility Function

In Chapter 13, you learned how to modularize the drawplate function into smaller functions that can be reused with other functions. These smaller functions were stored in the files named drawplate.lsp and utility.lsp.

The following steps explain how to define a createcircle function that will be used to draw a circle near each corner of the rectangle that is drawn with the createrectangle function:

If the utility.lsp file isn't already open, open the file now in Notepad on Windows or TextEdit on Mac OS.

In the text editor area, position the cursor after the last expression in the file and press Enter twice. Then type the following; the comments are here for your information and don't need to be typed:; CreateCircle function draws a circle object. ; ; Arguments: ; cenpt - A string or list that represents the center point of the circle ; rad - A string, integer, or real number that represents the circle's radius ; ; Usage: (createcircle "0,0" 0.25) ; (defun createcircle (cenpt rad / old_vars) ; Store and change the value of the OSMODE and CMDECHO system variables (setq old_vars (get-sysvars '("osmode" "cmdecho"))) ; Disable both OSMODE and CMDECHO (set-sysvars '("osmode" "cmdecho") '(0 0)) ; Draw a circle (command "._circle" cenpt rad) ; Restore the value of the OSMODE and CMDECHO system variables (set-sysvars '("osmode" "cmdecho") old_vars) )

Click File Save.

Close Notepad or TextEdit.

Revising the drawplate Function

Now that you have defined the createcircle function in the utility.lsp file, you can update the drawplate function to add circles that will represent the bolt holes to the plate. The following steps explain how to update the drawplate.lsp file with the revised drawplate function:

Open the drawplate.lsp file in Notepad on Windows or TextEdit on Mac OS.

In the text editor area, locate the drawplate function and insert the text in bold font; the comments are here for your information and don't need to be typed:; Draws a rectangular plate that is 5x2.75 (defun c:drawplate ( / pt1 pt2 pt3 pt4 width height insPt textValue cenPt1 cenPt2 cenPt3 cenPt4 old_vars hole_list) ; Store and change the value of the system variables (setq old_vars (get-sysvars '("osmode" "clayer" "cmdecho"))) (set-sysvars '("osmode" "clayer" "cmdecho") '(0 "0" 0)) ; Create the layer named Plate or set it current (createlayer "Plate" 5) ; Define the width and height for the plate (setq width 5 height 2.75) ; Set the coordinates to draw the rectangle (setq pt1 '(0 0 0) ;| lower-left corner |; pt2 (list width 0 0) ;| lower-right corner |; pt3 (list width height 0) ;| upper-right corner |; pt4 (list 0 height 0)) ;| upper-left corner |; ; Draw the rectangle (createrectangle pt1 pt2 pt3 pt4) ; Create the layer named Holes or set it current (createlayer "Holes" 1) ; Calculate the placement of the circle in the lower-left corner ; Calculate a new point at 45 degrees and distance of 0.7071 from pt1 (setq cenPt1 (polar pt1 (/ PI 4) 0.7071)) ; Calculate the next point from cenPt along the same angle ; as the line drawn between pt1 and pt2, and 1 unit less ; than the distance between pt1 and pt2 (setq cenPt2 (polar cenPt1 (angle pt1 pt2) (- (distance pt1 pt2) 1))) ; Calculate the final two points based on cenPt1 and cenPt2 (setq cenPt3 (polar cenPt2 (angle pt2 pt3) (- height 1)) cenPt4 (polar cenPt1 (angle pt1 pt4) (- height 1))) ; Append all the calculated center points to a single list (setq hole_list (append (list cenPt1) (list cenPt2) (list cenPt3) (list cenPt4))) ; Execute the createcircle function for each point ; list in the in the hole_list variable (foreach cenPt hole_list (createcircle cenPt 0.1875) ) ; Set the insertion point for the text label (setq insPt (list (/ width 2.0) (+ height 0.75) 0)) ; Define the label to add (setq textValue (strcat "PLATE SIZE: " (vl-string-right-trim ".0" (rtos width 2 2)) "x" (vl-string-right-trim ".0" (rtos height 2 2)) ) ) ; Create label (createlayer "Label" 7) (createtext insPt "_c" 0.5 0.0 textValue) ; Restore the value of the system variables (set-sysvars '("osmode" "clayer" "cmdecho") old_vars) )

Click File Save.

Close Notepad or TextEdit.

Using the Revised drawplate Function

Now that that the drawplate.lsp and utility.lsp files have been revised, you must load them into AutoCAD before the changes can be used.

The following steps explain how to load the LSP files into AutoCAD and then start the drawplate function:

Load the drawplate.lsp and utility.lsp files from the MyCustomFiles folder, or the folder you have them stored in.

At the Command prompt, type osmode press Enter. Make note of the current running object snap value that is returned.

Check the current value of the clayer and cmdecho system variables, and write down their current value.

Type drawplate press Enter.

Type zoom and press Enter, and then type e and press Enter. Figure 14.1 shows what the objects should look like in the drawing. A rectangle should be drawn starting at the coordinate 0,0 with a width of 5 units and height of 2.75 units. You should notice that four circles have also been drawn near each corner of the rectangle.

Check the values of the osmode, clayer, and cmdecho system variables. Their values should be restored to the values you recorded as part of steps 2 and 3.

Figure 14.1 Completed plate