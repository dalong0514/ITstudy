Variables in VBA hold a specific data type, which helps to enforce data integrity and communicate the type of data an argument expects or a function might return. As your programs become more complex and you start requesting input from the user, there will be times when a function returns a value of one data type and you want to use that value with a function that expects a different data type. VBA supports a wide range of functions that can convert a string to a number, a number to a string, and most common data types to a specific data type.

Table 25.5 lists many of the data conversion functions that you will use with VBA in this book.

Table 25.5 VBA data conversion functions

Function Description

Abs Returns the absolute value of a numeric value, integer, or double number. The absolute value is a positive value—never negative.

Syntax: retVal = Abs(number)

Asc Returns an integer that represents the ASCII code value of the string character that is passed to the function.

Syntax: retVal = Asc(string)

CBool Converts a value to a Boolean value.

Syntax: retVal = CBool(value)

CByte Converts a value to a byte value.

Syntax: retVal = CByte(value)

CCur Converts a value to a currency value.

Syntax: retVal = CCur(value)

CDate Converts a value to a date value.

Syntax: retVal = CDate(value)

CDbl Converts a value to a double value.

Syntax: retVal = CDbl(value)

CDec Converts a value to a decimal value.

Syntax: retVal = CDec(value)

Chr Returns the character equivalent of the ASCII code value that is passed to the function.

Syntax: retVal = Chr(number)

CInt Converts a value to an integer value.

Syntax: retVal = CInt(value)

CLng Converts a value to a long value.

Syntax: retVal = CLng(value)

CLngLng Converts a value to a LongLong value that is valid on 64-bit systems only.

Syntax: retVal = CLngLng(value)

CLngPtr Converts a value to a long value on 32-bit systems or a LongLong value on 64-bit systems.

Syntax: retVal = CLngPtr(value)

CSng Converts a value to a single value.

Syntax: retVal = CSng(value)

CStr Converts a value to a string value.

Syntax: retVal = CStr(value)

CVar Converts a value to a variant value.

Syntax: retVal = CVar(value)

Fix Returns the nearest integer of a double number after discarding the fractional value after the decimal. When a negative double value is passed to the function, the first negative number greater than or equal to the number passed is returned.

Syntax: retVal = Fix(number)

Format Returns a string that contains a formatted numeric or date value.

Syntax: retVal = Format(value[, format[,firstweekday[, firstweekofyear]]])

The optional format argument controls the number or date formatting, and the optional firstweekday and firstweekofyear specify the first day of the week or first week of the year.

Hex Returns a hexadecimal value as a string based on the number provided.

Syntax: retVal = Hex(number)

Int Returns the nearest integer of a double number after discarding the fractional value after the decimal. When a negative double value is passed to the function, the first negative number less than or equal to the number passed is returned.

Syntax: retVal = Int(number)

Oct Returns an octal value as a string based on the number provided.

Syntax: retVal = Oct(number)

For more information on these functions, see the Microsoft Visual Basic for Applications Help system.

Comparing Values

As the complexity of a program grows, so too does the need to perform conditional tests, also referred to as test conditions. Test conditions are used to compare values or settings in the AutoCAD environment against a known condition. VBA operators and functions that are used to test conditions return a Boolean value of True or False. The VBA operators and functions used to test a condition allow you to

Compare two values for equality

Determine if a value is numeric, zero, or negative

Compare two values to see which is greater or less than or equal to the other

Check for a value being Nothing, an array, or an object

Testing Values for Equality

Testing for equality is probably the most common test condition you will perform in most of your programs. For example, you might want to see if the user provided any input with one of the GetXXXX functions that are part of the AutoCAD COM library. In this case, you could check to see if the value returned is expected. The VBA = (equal to) and <> (not equal to) operators are how values are commonly compared to each other. The = operator returns True if the values are equal; otherwise, False is returned. The <> operator returns True if the values are not equal; False is returned if the values are equal.

The following shows the syntax of the = and <> operators:

value1 = value2 value1 <> value2

Here are examples of the = and <> operators:

' Returns True, numbers are equal 1 = 1 1 = 1.0 ' Returns True, strings are equal "ABC" = "ABC" ' Returns False, numbers are not equal 1 <> 2 ' Returns False, strings are not equal "ABC" = "abc"

In addition to the = operator, the Like operator can be used to compare string values. I discuss the Like operator in the next section.

TIP

The Not operator can be used to invert a Boolean value returned by an operator or function. A value of True is returned as False, whereas a value of False is returned as True.

The = operator isn't ideal for comparing to see if two objects are the same. If you want to compare two objects for equality, you use the Is operator. The syntax for using the Is operator is the same as for using the = operator. A value of True is returned if both objects are the same when using the Is operator; otherwise, False is returned.

Here are examples of the Is operator:

' Gets the current layer of the drawing Dim objCurLayer as AcadLayer Set objCurLayer = ThisDrawing.ActiveLayer ' Creates a new layer Dim objNewLayer as AcadLayer Set objNewLayer = ThisDrawing.Layers.Add("ABC") ' Returns True since both objects are the same objCurLayer Is ThisDrawing.ActiveLayer ' Returns False since both objects are not the same objCurLayer Is objNewLayer

Comparing String Values

The = operator isn't the only way to compare two string values. The Like operator allows you to compare a string value to a string pattern that can contain one or more wildcard characters. If the string matches the pattern, True is returned, and False is returned if the string doesn't match the pattern.

The following shows the syntax of the Like operator:

retVal = string Like pattern

Here are examples of the Like operator:

' Returns True since both strings match "ABC" Like "ABC" ' Returns False since both strings don't match "ABC" Like "AC" ' Returns True since both strings match the pattern "DOOR_DEMO" Like "DOOR*"

The StrComp and InStr functions can be used to compare two string values using an optional comparison mode. The StrComp and InStr functions don't return a Boolean value like the = operator; instead they return an integer value based on the comparison mode passed to the function. 0 is returned if the strings are equal, 1 is returned if the binary value of the first string is greater than the second string or the two strings are not equal when doing a textual comparison, and -1 is returned if the binary value of the first string is less than the second string.

The following shows the syntax of the StrComp function:

retVal = StrComp(string1, string2[, comparison])

For more information on the StrComp function and a list of values that the comparison argument expects, see the Microsoft Visual Basic for Applications Help.

The InStr function is similar to the StrComp function with one exception: it has an optional start argument, which specifies the location within the first string that the comparison should start. The following shows the syntax of the InStr function:

retVal = InStr([start, ][string1, ][string2, ][comparison])

Determining If a Value Is Greater or Less Than Another

The values that a user provides or the settings that define the AutoCAD environment aren't always easily comparable for equality. Values such as the radius of a circle or the length of a line are often compared to see if a value is greater or less than another. The VBA > (greater than) and < (less than) operators can be used to ensure that a value is or isn't greater than or less than another value.

These two operators are great for making sure a value is within a specific range, more than a value, or less than a value. You can also use the > and < operators with the Do and While statements to count down or up and make sure that while incrementing or decrementing a value you don't exceed a specific value. You might also use the > and < operators with a logical grouping operator to make sure a value is within a specific range of values. I discuss logical groupings in the「Grouping Comparisons」section.

The > (greater than) operator returns True if the first number is greater than the second number; otherwise, False is returned. The < (less than) operator returns True if the first number is less than the second number; otherwise, False is returned. If the values being compared are equal, then False is returned.

The following shows the syntax of the > and < operators:

value1 > value2 value1 < value2

In addition to comparing values to see if a value is greater or less than another, you can check for equality at the same time. The >= (greater than or equal to) and <= (less than or equal to) operators allow you to check to see if a value is greater or less than another or if the two values are equal. The syntax and return values for the >= and <= operators are the same as for the > and < operators, except True is returned if the values being compared are equal to each other.

Here are examples of comparing values with the >, <, >=, and <= operators, along with the values that are returned:

' Returns True as 2 is greater than 1 2 > 1 ' Returns False as the values are equal 1 > 1.0 ' Returns False as 2 is not less than 1 2 < 1 ' Returns False as the values are equal 1 < 1.0 ' Returns True as the values are equal 1 >= 1.0 ' Returns False as 1 is not greater than or equal to 2 1 >= 2 ' Returns True as the values are equal 1 <= 1.0 ' Returns True as 1 is less than or equal to 2 1 <= 2

TIP

You can compare a value within a range of values by using logical groupings, which I cover in the「Grouping Comparisons」section.

Checking for Null, Empty, or Nothing Values

Values assigned to a variable or returned by a statement can be checked to see whether they evaluate to null, empty, or nothing. A null value occurs when no valid data is assigned to a variable. The IsNull function returns True if a value is null; otherwise, False is returned. A variable can be set to a value of null using this syntax:

variable = Null

A variable declared with the variant data type can hold any type of data, but if it is not initialized and assigned a value, it is empty. The IsEmpty function returns True if a value is empty; otherwise, False is returned. A variable can be set to a value of empty using this syntax:

variable = Empty

Values that are of an object type can't be compared for a null or empty value, but rather you compare them against a value of nothing. Unlike checking for a null or empty value, there is no IsNothing function that can be used to check for a value of nothing. Checking for a Nothing value requires the use of the Is operator, which I mentioned in the「Testing Values for Equality」section. The following syntax shows how to compare an object for a value of nothing:

' Creates new variable of the AcadLayer object type Dim objCurLayer as AcadLayer ' Evaluates to True since no object has been assigned to the variable objCurLayer Is Nothing ' Gets the current layer of the drawing Set objCurLayer = ThisDrawing.ActiveLayer ' Evaluates to False since the current layer has been assigned to the variable Debug.Print objCurLayer Is Nothing

A variable can be set to a value of nothing using the syntax:

Set variable = Nothing

Validating Values

Prior to using a variable, I recommend testing to see if the variable holds the type of value that you might reasonably expect. Although it does increase the complexity of a program, the additional statements used to test variables are worth the effort; they help to protect your programs from unexpected values. The following lists some of the functions that can be used to test the values of a variable:

IsArray: Determines if a value represents a valid array; returns True or False.

IsDate: Determines if a value represents a valid calendar date or time; returns True or False.

IsMissing: Checks to see if an optional argument of a procedure was provided; returns True or False.

IsNumeric: Determines if a value is a number; returns True or False.

IsObject: Determines if a value is an object; returns True or False.

Sgn: Determines the sign of a numeric value; 1 is returned if the value is greater than zero, 0 is returned if equal to zero, or –1 is returned if the number is less than zero.

For more information on these functions, see the Microsoft Visual Basic for Applications Help system.

Grouping Comparisons

There are many times when one test condition isn't enough to verify a value. One of the best examples of when you want to use more than one test condition is to see if a value is within a specific numeric range. Logical grouping operators are used to determine if the results of one or more test conditions evaluates to True.

The And and Or operators are the two logical grouping operators that can be used to evaluate two or more test conditions. The And operator returns True if all test conditions in a grouping return True; otherwise, False is returned. The Or operator returns True if at least one test condition in a grouping returns True; otherwise it returns False.

The following shows the syntax of the And and Or operators:

test_condition1 And test_condition2 test_condition1 Or test_condition2

The test_condition1 and test_condition2 arguments represent the test conditions that you want to group together and evaluate.

Here are examples of the And and Or operators, along with the values that are returned:

' Checks to see if a number is between 1 and 5 Dim num as Integer ' Evaluates to and displays True since num is 3 and between 1 and 5 num = 3 MsgBox 5 >= num And 1 <= num ' Evaluates to and displays False since num is 6 and is not between 1 and 5 num = 6 MsgBox 5 >= num And 1 <= num ' Checks to see if values are numeric or strings Dim val1, val2 val1 = 1.5: val2 = "1.5" ' Evaluates to and displays True since va11 is a double or integer MsgBox VarType(val1) = vbDouble Or VarType(val1) = vbInteger ' Evaluates to and displays False since va12 is not a double or integer MsgBox VarType(val2) = vbDouble Or VarType(val2) = vbInteger

I discussed the VarType function in the「Exploring Data Types」section.

Conditionalizing and Branching Statements

The statements in a procedure are executed sequentially, in what is commonly known as a linear program. In a linear program, execution starts with the first statement and continues until the last statement is executed. Although statements are executed in a linear order, a procedure can contain branches. Think of a branch as a fork in the road.

Branches allow a procedure to make a choice as to which statements should be executed next based on the results of a test condition. I covered test conditions in the「Comparing Values」section. The If and Select Case statements are used to branch the statements in a procedure.

Evaluating If a Condition Is Met

The operators and functions discussed in the previous sections allow a program to compare and test values to determine which expressions to execute by using a programming technique called branching. The most common branching method is the If…Then statement. Using the If…Then statement, a set of statements can be executed if the test condition is evaluated as True.

The following shows the syntax of the If…Then statement:

If test_condition Then true_statementsN End If

Here are the arguments:

test_condition The test_condition argument represents the test condition that you want to evaluate and determine which statements to execute.

then_statementN The then_statementN argument represents the statements to evaluate if the test_condition argument evaluates to True.

The If…Then statement supports an optional Else statement, which can be used to execute a set of statements when the test condition is evaluated as False. The following shows the syntax of the If…Then statement with the Else statement:

If test_condition Then true_statementsN Else else_statementN End If

The else_statementN argument represents the statements that should be executed if the test_condition argument evaluates to False. In addition to the Else statement, the If…Then statement can support one or more optional ElseIf statements. An ElseIf statement allows for the evaluation of additional test conditions. The following shows the syntax of the If…Then statement with the inclusion of the ElseIf and Else statements:

If test_condition Then true_statementsN [ElseIf test_condition Then elseif_statementN] [Else else_statementN] End If

When the test_condition argument of the If…Then statement evaluates to a value of False, the test_condition of the ElseIf statement is evaluated. If the test_condition of the ElseIf statement evaluates to a value of True, the set of statements after it is executed. If the test_condition of the ElseIf statement evaluates to a value of False, the next ElseIf statement is evaluated if one is present. If no other ElseIf statements are present, the Else statement is executed if one is present.

The following is an example of an If…Then statement that uses the ElseIf and Else statements to compare the value of a number entered:

' Prompts the user for a number Dim num As Integer num = CInt(InputBox("Enter a number: ")) ' Checks to see if the number is greater than, less than, or equal to 4 If num > 4 Then MsgBox "Number is greater than 4" ElseIf num < 4 Then MsgBox "Number is less than 4" Else MsgBox "Number is equal to 4" End If

Validating for an Object of a Specific Type

You can use the TypeOf object Is objecttype clause of the If statement to determine an object's type. This can be helpful if your program expects the user to select or work with a specific type of object. Selection filters, discussed in Chapter 28, can be used to allow only the user to select an object of a specific type.

The following example displays one of two messages based on whether the first object in model space is a circle:

' Gets the first object in model space Dim oFirstEnt As AcadEntity Set oFirstEnt = ThisDrawing.ModelSpace(0) ' Display a message based on if the ' first object is a circle or not If TypeOf oFirstEnt Is AcadCircle Then MsgBox "Object is a circle." Else MsgBox "The object isn't a circle." End If

Testing Multiple Conditions

The If…Then statement allows a procedure to execute one or more possible sets of statements based on the use of the ElseIf and Else statements. In addition to the If…Then statement, the Select Case statement can be used to evaluate multiple test conditions. The Select Case statement is a more efficient approach to testing multiple conditions when compared to the If…Then statement.

Each test condition of a Select Case statement starts with the Case statement and can be used to compare more than one value. Similar to the If…Then statement, the Select Case statement also supports an optional statement if none of the test conditions are valued as True; the optional statement is named Case Else.

The following shows the syntax of the Select Case statement:

Select Case Case test_condition case_statementsN [Case test_condition case_statementsN] [Case Else else_statementN ] End Select

test_condition The test_condition argument represents the test condition that you want to evaluate and determine which statements to execute.

case_statementsN The case_statementsN argument represents the statements to evaluate if the test_condition argument evaluates to True.

else_statementsN The else_statementsN argument represents the expressions to evaluate if none of the test conditions represented by the Case statements evaluates to True. The Case Else statement must also be used.

The following is an example of the Select Case statement:

' Displays a message based on the number entered Select Case CInt(InputBox("Enter a number: ")) Case 1 MsgBox "1 was entered" Case 2 To 4 MsgBox "2 to 4 was entered" Case 5, 6 MsgBox "5 or 6 was entered" Case Is >= 7 MsgBox "7 or greater was entered" Case Else MsgBox "0 or less was entered" End Select

Repeating and Looping Expressions

Repetition helps to form habits and learn how to perform a task, but repetition can also be counterproductive. If you know a task is repeated many times a day and you know how to complete that task, it is ideal to automate and simplify the process as much as possible, if not eliminate the process altogether. VBA—and most programming languages, for that matter—have no problem with repetition because they support a concept known as loops. Loops allow for a set of expressions to be executed either a finite number of times or infinitely while a condition is met.

Repeating Expressions a Set Number of Times

The easiest way to loop a set of expressions in VBA is to use the For statement. The first argument of the For statement is known as the counter, which is a variable name that is incremented or decremented each time the For statement is executed. The initial value of the counter and number of times the For statement should be executed are determined by a range of two values.

Typically, the range starts with 0 or 1 and the difference between the start and ending of the range is used to specify how many times the For statement is executed. By default, the counter is incremented by 1 each time the For statement is executed. Optionally, the For statement supports the Step keyword, which can be used to specify a larger increment value than the default of 1 or a decrement value to count down instead of up.

The following shows the syntax of the For statement:

For counter = start To end [Step stepper] statementN Next [counter]

Its arguments are as follows:

counter The counter argument represents the variable name that is assigned to the current loop counter. The variable should be of a number data type, such as an integer or short. When the For statement is executed the first time, the counter variable is assigned the value passed to the start argument.

start The start argument represents the start of the numeric range.

end The end argument represents the end of the numeric range.

stepper The stepper argument is optional and represents the numeric value that counter should be stepped each time the For statement is executed. Use a positive number to increment counter or a negative number to decrement counter.

statementN The statementN argument represents the statements that should be executed each time the loop is started.

NOTE

The Exit For statement can be used to end a For statement before the counter reaches the end of the specified range.

The following is an example of using the For statement:

' Executes the statements 5 times, the variable ' cnt is incremented by 1 with each loop Dim cnt as Integer For cnt = 1 To 5 Debug.Print cnt Next cnt

Here is the output that the previous statements create:

1 2 3 4 5

Stepping Through an Array or Collection

The For Each statement is similar to the For statement described in the previous section. Instead of specifying a counter variable, a range, and an optional step, the For Each statement requires an element variable and a grouping, such as an array or a collection object. When the For Each statement is executed, the first value of the array or object of the collection is assigned to the element variable. As the For Each statement continues to be executed, the next value or object is assigned to the variable until all values or objects have been retrieved.

The following shows the syntax of the For Each statement:

For Each element In grouping statementN Next [element]

Its arguments are as follows:

element The element argument represents the variable name that is assigned to the current loop element. When the For Each statement is executed the first time, the element variable is assigned the first value or object of the grouping argument.

grouping The grouping argument represents the array or collection object that you want to step through one value or object at a time.

statementN The statementN argument represents the statements that should be executed each time the loop is started.

NOTE

The Exit For statement can be used to end a For statement before the last value or object in an array or a collection is retrieved.

The following is an example of using the For Each statement:

' Steps through all layer objects in the Layers collection ' of the current drawing and displays the names of each layer Dim objLayer as AcadLayer For Each objLayer In ThisDrawing.Layers Debug.Print objLayer.Name Next objLayer

Here is the output that the previous statements create:

0 Plan_Walls Plan_Doors Plan_Cabinets Plan_Furniture Labels Panels Surfaces Storage Defpoints Dimensions

The order in which values or objects are retrieved is the same in which they were added to the array or collection.

Performing a Task While or Until a Condition Is Met

The For and For Each statements, as I mentioned in the previous sections, can be used to execute a set of statements a finite number of times. However, it isn't always easy to know just how many times a set of statements might need to be executed to get the desired results. When you are unsure of the number of times a set of statements might need to be executed, you can use the Do or While statement.

The Do and While statements use a test condition, just like the If statement, to determine whether the set of statements should be executed. The set of statements are executed as long as the test condition returns True. The test conditions that can be used are the same ones mentioned earlier in the「Comparing Values」and「Grouping Comparisons」sections.

There are two uses for the Do statement. The first is to evaluate a test condition before it executes any statements, whereas the other executes a set of statements and then evaluates a test condition to determine whether the statements should be executed again. Which version you use simply depends on whether you want to execute the statements at least once each time the Do statement is executed.

A Do statement also requires the use of either the While or Until keyword. The While keyword indicates that the Do statement should execute until the test condition is no longer True, and the Until keyword indicates that the Do loop should execute while the test is False.

The following shows the syntax of the Do statement that evaluates a test condition to determine whether the set of statements should be executed:

Do [{While | Until} test_condition] statementN Loop

The next example shows the syntax of the Do statement that executes a set of statements before evaluating a test condition:

Do statementN Loop [{While | Until} test_condition]

Its arguments are as follows:

test_condition The test_condition argument represents the statement that should be used to determine if the expressions represented by the statementN argument should be executed or continue to be executed.

statementN The statementN argument represents the statements that should be executed each time the loop is started.

The following are examples of the Do function:

' Executes the statements 5 times, the variable ' cnt is decremented by 1 with each loop Dim cnt As Integer cnt = 5 Do While cnt > 0 Debug.Print cnt cnt = cnt - 1 Loop

Here is the output that the previous statements create:

5 4 3 2 1 ' Executes the statements once since the test condition ' only returns True while cnt is greater than 4 Dim cnt As Integer cnt = 5 Do Debug.Print cnt cnt = cnt + 1 Loop Until cnt > 4

Here is the output that the previous statements create:

5

NOTE

The Exit Do statement can be used to end a Do statement before the test condition returns True or False based on whether the While or Until keyword is used.

The While statement is similar to the Do statement with the While keyword when evaluating a test condition before it executes a set of statements. The one difference between the Do and While statements is that the While statement doesn't support the ability to end early with the use of the Exit statement. Ending a While statement early would require statements to manipulate the test condition being used to determine when to end the looping.

The following shows the syntax of the While statement:

While test_condition statementN Wend

The test_condition and statement arguments are the same as those in the Do statement. Here is an example of the While function:

' Executes the statements 5 times, the variable ' cnt is decremented by 1 with each loop Dim cnt As Integer cnt = 5 While cnt > 0 Debug.Print cnt cnt = cnt - 1 Wend

Here is the output that the previous statements create:

5 4 3 2 1

Chapter 26

Interacting with the Application and Documents Objects

The top object in the AutoCAD® Object library is the AcadApplication object, which allows you to access and manipulate the AutoCAD application window. From the AcadApplication object, you can also access the AcadDocuments collection, which allows you to work with not only the current drawing but all open drawings in the current AutoCAD session. As mentioned in earlier chapters, the ThisDrawing object can be used to access the current drawing.

Working with the Application

The AcadApplication object is the topmost object in the AutoCAD Object library. Although it isn't the most used object, it does provide access to the many features that you will use in VBA projects. All objects in the AutoCAD Object library provide access to the AcadApplication object with the object's Application property. You can access the AcadApplication object from the ThisDrawing object with the following code statement in the VBA Editor:

ThisDrawing.Application

You can also use the following code statement to access the AcadApplication object from a code, class, or UserForm module:

AcadApplication.Application

The following tasks can be performed once you have a reference to the AcadApplication object:

Get the current drawing or the AcadDocuments collection object to work with all open drawings (see the section「Managing Documents」later in this chapter for more information).

List, load, and unload ObjectARX® applications.

Load and unload VBA project files and execute a macro (see Chapter 36,「Handling Errors and Deploying VBA Projects」).

Manipulate the menus on the menu bar and toolbars in the user interface (see Chapter 33,「Modifying the Application and Working with Events」).

Monitor changes to the application, system variables, commands, and more using event handlers (see Chapter 36).

Update the display in the drawing window or zoom in the current viewport (see Chapter 28,「Interacting with the User and Controlling the Current View」).

Access application preferences (see the section「Querying and Setting Application and Document Preferences」later in this chapter for more information).

Get the name of and path to an application executable.

Manipulate the size and position of the application window.

The following shows a few code statements that allow you to query or manipulate an application:

' Gets and displays the caption of the application window MsgBox ThisDrawing.Application.Caption ' Zooms to the extents of all drawing objects in the current viewport AcadApplication.Application.ZoomExtents ' Maximizes the application window ThisDrawing.Application.WindowState = acMax

For a full list of the methods and properties that the AcadApplication object supports, look up the AcadApplication class in the Object Browser of the VBA Editor and the AutoCAD Help system.

Getting Information about the Current AutoCAD Session

The properties of the AcadApplication object can be used to access information about the current instance of the application. You can learn the application name and where the executable is stored, as well as which drawing is current or which drawings are open.

Table 26.1 lists the properties of the AcadApplication object that can be used to get information about the AutoCAD executable.

Table 26.1 Application-related properties

Property Description

FullName Returns a string that contains the full name of the executable file used to start the application. This property is read-only.

HWND Returns a long integer that contains the handle of the application in memory. A handle is a unique value assigned to an application by Windows while it is executing in memory. A different number is assigned to the application each time it is started. This property is read-only.

HWND32 Returns a long integer that contains the handle of the application in memory on a Windows 64-bit platform. This property is read-only and is available in AutoCAD 2014 and earlier releases that didn't support a true implementation of VBA 64-bit on the Windows 64-bit platform.

LocaleId Returns an integer that represents the locale or language being used in the current session. This property is read-only.

Name Returns a string that contains the name and file extension of the executable file used to start the application. This property is read-only.

Path Returns a string that contains the path of the executable file used to start the application. This property is read-only.

Version Returns a string that contains the version number of the application. This property is read-only.

The following demonstrates how to display a message box containing the name, path, and version number of the application:

Sub DisplayAppInfo() MsgBox "Name: " & ThisDrawing.Application.Name & vbLf & _ "Path: " & ThisDrawing.Application.Path & vbLf & _ "FullName : " & ThisDrawing.Application.FullName & vbLf & _ "Version : " & ThisDrawing.Application.Version, _ vbInformation, "Application Info" End Sub

TIP

The FullName and Path properties can be helpful in identifying whether the current AutoCAD session was started from a plain or from a vertical AutoCAD installation. For example, the installation path might be C:\Program Files\Autodesk\AutoCAD 2015\ACA, which lets you know that instance of AutoCAD 2015 should have access to the AutoCAD® Architecture features. You can also use the product system variable to check whether the current AutoCAD instance is a vertical-based product. I discuss working with system variables in the「Working with System Variables」section later in this chapter.

Manipulating the Placement of the Application Window

Some properties of the AcadApplication object can be used to resize, reposition, or even hide the AutoCAD application window from the user.

Table 26.2 lists the AcadApplication object properties that can be used to resize and get information about the application window.

Table 26.2 Application window–related properties

Property Description

Caption Returns a string that contains the title of the application window. This property is read-only.

Height Specifies the height of the application window. The value returned is an integer and represents the window height in pixels.

Visible Specifies the visibility of the application window. The value returned is Boolean. True indicates that the application window is visible, whereas False indicates the window is hidden.

Width Specifies the width of the application window. The value is an integer and represents the window width in pixels.

WindowLeft Specifies the location of the application window's left edge. The value is an integer. 0 sets the window to the leftmost visible position. A negative value moves the window to the left and off the screen, whereas a value greater than 0 moves the window to the right.

WindowState Returns an integer value that represents the current state of the application window. The integer values allowed are defined as part of the AcWindowState enumerator. A value of 1 (or acNorm) indicates the window is neither minimized nor maximized, whereas a value of 2 (or acMin) or 3 (or acMax) indicates the window is minimized or maximized, respectively.

WindowTop Specifies the location of the application window's top edge. The value is an integer. 0 sets the window to the topmost visible position. A negative value moves the window up and off the screen, whereas a value greater than 0 moves the window down.

For more information on these properties, use the Object Browser in the VBA Editor or check the AutoCAD Help system.

Managing Documents

When a drawing file is opened in the AutoCAD drawing environment, it is presented in a drawing window. A drawing window in the AutoCAD Object library is referred to as a document and is represented by an AcadDocument object. The AcadDocument object provides access to the objects in a drawing file and the window in which the drawing is displayed.

The AcadDocuments collection object is used to manage all the drawings open in the current AutoCAD session. You can access the AcadDocuments collection object with the Documents property of the AcadApplication object. In addition to working with drawings in the current session, you can create new and open existing drawing files, save and close open drawings, and get information from an open drawing.

NOTE

As I explained in Chapter 25,「Understanding Visual Basic for Applications,」the For statement can be used to step through and get each drawing in the AcadDocuments collection object. The Item method can also be used to get a specific document in the AcadDocuments collection object.

Working with the Current Drawing

The ThisDrawing object is the most common way to access the current drawing from a VBA project. ThisDrawing is equivalent to using the code statement AcadApplication.ActiveDocument.

From the current drawing, you can perform the following tasks:

Add, query, and modify graphical and nongraphical objects (see Chapter 27,「Creating and Modifying Drawing Objects,」Chapter 29,「Annotating Objects,」and Chapter 30,「Working with Blocks and External References」).

Set a nongraphical object as current (see Chapter 27, Chapter 29, and Chapter 30).

Use utility functions to get user input and perform geometric calculations (see Chapter 28).

Monitor changes to the drawing, commands, objects, and more using event handlers (see Chapter 36).

Select objects using selection sets (see Chapter 27).

Get the name and path to the drawing file stored on disc.

Access and modify drawing properties.

The following shows a few example code statements that access the properties of a current drawing:

' Sets the model space elevation to 10.0 ThisDrawing.ElevationModelSpace = 10# ' Displays a message box with the name of the current layer MsgBox ThisDrawing.ActiveLayer.Name ' Maximizes the drawing window ThisDrawing.WindowState = acMax

For a full list of the methods and properties that the ThisDrawing object supports, look up the AcadDocument class in the Object Browser of the VBA Editor or check the AutoCAD Help system.

Creating and Opening Drawings

Not only can you work with the current drawing, but you can create a new drawing or open an existing drawing file that had been stored on disc. The Add method of the AcadDocuments collection object can be used to create a new drawing from scratch or based on a drawing template (DWT) file. If you don't pass the name of a drawing template file to the Add method, the measurement units of the new drawing is determined by the current value of the measureinit system variable. A value of 0 for the measureinit system variable indicates the new drawing will use imperial units, whereas a value of 1 indicates the use of metric units. The Add method returns an AcadDocument object that represents the new drawing file that has been created in memory.

The following example code statements show how to create a new drawing that uses metric units from scratch or based on the Tutorial-iArch.dwt file that is installed with AutoCAD:

' Set the measurement system for new drawings to metric ThisDrawing.SetVariable "measureinit", 1 ' Create a new drawing from scratch Dim newDWG1 As AcadDocument Set newDWG1 = Application.Documents.Add ' Create a new drawing based on Tutorial-iArch.dwt Dim newDWG2 As AcadDocument Set newDWG2 = Application.Documents.Add("Tutorial-iArch.dwt")

NOTE

If the DWT file passed to the Add method isn't located in a path listed under the Drawing Template File Location node on the Files tab of the Options dialog box, you must specify the full path to the DWT file. The TemplateDwgPath property of the AcadPreferencesFiles object can be used to add additional paths for AutoCAD to look in for DWT files. I discuss application preferences later, in the「Querying and Setting Application and Document Preferences」section.

The New method of an AcadDocument object can also be used to create a new drawing file when the AutoCAD drawing environment is in single document interface (SDI) mode. Autodesk doesn't recommend using SDI mode; it affects the functionality of some features in the AutoCAD drawing environment. You can determine whether AutoCAD is in SDI mode by checking the value of the sdimode system variable or checking the SingleDocumentMode property of the AcadPreferencesSystem object. The New method returns an AcadDocument object that represents the new drawing file that has been created in memory.

When you want to work with an existing drawing file that is stored on a local or network drive, use the Open method of the AcadDocument or AcadDocuments collection object. Here's the syntax of the Open methods:

retVal = document.Open(fullname [, password]) retVal = documents.Open(fullname [, read-only] [, password])

The arguments are as follows:

fullname The fullname argument is a string that represents the DWG file you want to open. You can also open a DWS or DWT file.

password The password argument is an optional string that represents the password that is required to open a password-protected DWG file.

read-only The read-only argument is an optional Boolean that specifies whether the drawing should be open for read-write or read-only. A value of True indicates the drawing should be open for read-only access.

retVal The retVal argument specifies a user-defined variable that you want to assign the AcadDocument object that is returned by the Open method.

The following example code statements show how to open a DWG file named Building_Plan.dwg stored at C:\Drawings, first for read-write and then for read-only access:

' Open Building_Plan.dwg for read-write Dim objDoc1 As AcadDocument set objDoc1 = ThisDrawing.Open("c:\drawings\building_plan.dwg") ' Open Building_Plan.dwg for read-only Dim objDoc2 As AcadDocument set objDoc2 = Application.Documents.Open("c:\drawings\building_plan.dwg", True)

NOTE

Before you try to use a DWT file or open a DWG file, you should make sure the file exists on your workstation. The VBA Dir method can be used to check for the existence of a file or folder. I explain how to work with files in Windows in Chapter 35,「Communicating with Other Applications.」

Saving and Closing Drawings

After you create a new drawing or make changes to an existing drawing file, you most likely will want to save the drawing to a file. Saving a drawing can be accomplished with the Save or SaveAs method of the AcadDocument object. Similar to the user interface, the Save method should be used to save a drawing file that was opened from disc or was previously saved with the SaveAs method.

The Save method accepts no arguments and saves a drawing to the location it was opened from. If you use the Save method on a new drawing that wasn't previously saved, the Save method saves the drawing to the location stored in the Path property of the AcadDocument object. You can determine whether the drawing was previously saved by checking the FullName property of the AcadDocument object; if the property returns an empty string, the drawing hasn't been saved to disc yet.

When you want to save a new drawing, save an existing drawing with a new name or location or in a different file format, or change the password protection, save the drawing with the SaveAs method. Here's the syntax of the SaveAs method:

document.SaveAs(fullname [, SaveAsType] [,SecurityParams])

The arguments are as follows:

fullname The fullname argument is a string that represents the name and path of the drawing or drawing interchange file on disc.

SaveAsType The SaveAsType argument is an optional integer that represents one of the supported file formats. The supported values can be found in the Object Browser of the VBA Editor under the enumerator named AcSaveAsType or in the SaveAs Method topic in the AutoCAD Help system. When not provided, the default format (the native drawing file format for the AutoCAD release you are using) is used. For AutoCAD 2013 and later, the default file format is the AutoCAD 2013 DWG file format.

SecurityParams The SecurityParams argument is an optional AcadSecurityParams object that specifies the password or digital signature settings to apply to the drawing. For information on the AcadSecurityParams object, see the AutoCAD Help system.

Before saving a drawing, you should check to see if the file was opened as read-only or if the drawing already has been saved. The ReadOnly property returns a Boolean value of True when the drawing is opened for read-only access, and the Saved property returns a Boolean value of True if the drawing doesn't need to be saved.

The following example demonstrates how to save a DWG file named SampleVBASave.dwg to the Documents (or My Documents) folder:

' Check to see if the drawing is read-write If ThisDrawing.ReadOnly = False Then ' Check to see if the drawing file was previously saved If ThisDrawing.FullName = "" Then ' Drawing wasn't previously saved ThisDrawing.SaveAs ThisDrawing.GetVariable("MyDocumentsPrefix") & _ "\SampleVBASave.dwg" Else ' Drawing was previously saved to disc ' Check to see if the drawing has been modifed If ThisDrawing.Saved = False Then ThisDrawing.Save End If End If End If

Once a drawing file no longer needs to remain open in the AutoCAD drawing environment, you can close it using the Close method of the AcadDocument object. Alternatively, you can use the Close method of the AcadDocuments collection object, which will close all open drawings and ignore any changes that haven't previously been saved.

Here's the syntax of the Close methods:

document.Close([SaveChanges] [, fullname]) documents.Close

Here are the arguments:

SaveChanges The SaveChanges argument is an optional Boolean that specifies whether the changes made to the drawing should be saved or discarded.

fullname The fullname argument is an optional string that represents a new name and path to use when saving the drawing file if SaveChanges was passed a value of True.

TIP

If you want to close all open drawings, I recommend using the For statement with the AcadDocuments collection object and then close each drawing one at a time with the Close method of the AcadDocument object returned by the For statement. This approach will give you a chance to specify how changes are handled for each drawing as it is closed.

The following example demonstrates a procedure that mimics some of the functionality available with the AutoCAD closeall command:

Sub CloseAll() Dim oDoc As AcadDocument For Each oDoc In Application.Documents ' Activates the document window oDoc.Activate ' Close the drawing if no changes have been made since last save If oDoc.Saved = True Then oDoc.Close False Else Dim nRetVal As Integer nRetVal = MsgBox("Save changes to " & _ oDoc.Path & "\" & oDoc.Name & "?", vbYesNoCancel) Select Case nRetVal Case vbYes ' Save the drawing using its default name or last saved name ' if not open as read-only. If oDoc.ReadOnly = False Then oDoc.Save ' Close the drawing oDoc.Close Else ' Close file and discard changes if file is read-only If vbYes = MsgBox("File is read-only." & vbLf & vbLf & _ "Discard changes and close file?", vbYesNo) Then oDoc.Close False End If End If ' You should prompt the user here if the file was not previously ' saved to disc for a file name and path, or how read-only files ' should be handled. Case vbNo ' Close file and discard changes oDoc.Close False Case vbCancel ' Exit the procedure and return to AutoCAD Exit Sub End Select End If Next oDoc End Sub

NOTE

The previous example doesn't handle all situations that might be encountered when closing and saving changes to a drawing. The Ch26_ExSamples.dvb file, which you can download from www.sybex.com/go/autocadcustomization, contains a more comprehensive and complete solution. Place the file in the MyCustomFiles folder within the Documents (or My Documents) folder, or the location you are using to store the DVB files. Then load the VBA project into the AutoCAD drawing environment to use it. This sample file also contains a custom class that wraps two functions that can be used to display an open or save file-navigation dialog box.

Accessing Information about a Drawing

The properties of an AcadDocument object can be used to access information about the drawing file it represents. You can learn where the drawing file is stored, identify the graphical and nongraphical objects stored in a drawing file, and access the drawing properties that are used to identify a drawing file. I discuss how to access graphical and nongraphical objects later in this book.

Table 26.3 lists the properties of the AcadDocument object that can be used to get the name, location, and drawing properties of a drawing file open in the current AutoCAD session.

NOTE

Use the SaveAs method of the AcadDocument object to save a drawing file with a new name or location.

Table 26.3 Drawing file–related properties

Property Description

FullName Returns a string that contains the full name of the drawing file when it is stored on disc. If the drawing has not been saved yet, this property returns an empty string. This property is read-only.

Name Returns a string that contains the name and file extension of the drawing file. If the drawing has not been saved yet, it returns the default name assigned to the drawing file (that is, Drawing1.dwg, Drawing2.dwg, …). This property is read-only.

Path Returns a string that contains the path of the drawing file when it is stored on disc or the Documents (or My Documents) folder by default if the drawing has not been saved. This property is read-only.

SummaryInfo Returns a reference to an AcadSummaryInfo object, which represents the drawing properties that can be displayed and modified using the AutoCAD dwgprops command. This property is read-only.

The following demonstrates how to display a message box containing the path and name of the current drawing:

Sub DisplayDWGName() MsgBox "Name: " & ThisDrawing.Name & vbLf & _ "Path: " & ThisDrawing.Path & vbLf & _ "FullName : " & ThisDrawing.FullName, _ vbInformation, "File Name and Path" End Sub

To query and set the Author and Comments properties of the AcadSummaryInfo object for the current drawing, you'd use this code:

Sub DWGSumInfo() Dim oSumInfo As AcadSummaryInfo Set oSumInfo = ThisDrawing.SummaryInfo MsgBox "Author: " & oSumInfo.Author & vbLf & _ "Comments: " & oSumInfo.Comments, _ vbInformation, "Drawing Properties" oSumInfo.Author = "Drafter" oSumInfo.Comments = "Phase 1: Demolishion of first floor" MsgBox "Author: " & oSumInfo.Author & vbLf & _ "Comments: " & oSumInfo.Comments, _ vbInformation, "Drawing Properties" End Sub

For more information on the AcadSummaryInfo object, use the Object Browser in the VBA Editor or check the AutoCAD Help system.

