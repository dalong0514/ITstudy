## 2022012. Writing Better, Stronger, More Stable .NET AutoCAD Add-Ins

[Writing Better, Stronger, More Stable .NET AutoCAD Add-Ins | Autodesk University](https://www.autodesk.com/autodesk-university/class/Writing-Better-Stronger-More-Stable-NET-AutoCAD-Add-Ins-2017#downloads)

SD125743

Jerry Winters VB CAD, Inc.

Learning Objectives:

1 Learn how to simplify, inherit, encapsulate, and expand.

2 Learn about when and how to use dictionaries, lists, and arrays.

3 Learn how to use all of the .NET Framework and be creative once in a while.

4 Learn how to identify and consolidate your code into these tidy little units.

Description:

When we look back 10 years, we can easily identify how much we've learned and how much growth we've experienced. If only we knew 10 years ago what we know now, how much better would we be? This session hopes to provide the top lessons learned over the last 10 years of .NET development for AutoCAD software. Add your class description.

Speaker(s):

Jerry Winters has taught at nearly every U.S.-based Autodesk University over the past 17 years primarily on topics of AutoCAD software customization using Microsoft Visual Basic for Applications (VBA) and VB.NET. He brings a unique blend of education and entertainment as he tackles what would otherwise be a dry topic. And while he reserves the week before Thanksgiving for meeting with and enjoying the company of his Autodesk friends, the rest of the year is spent with his beautiful wife of 26 years and his 9 (yes, that's 9) children in rural Lake Point, Utah, where they are occasionally found singing at community events and senior centers.

### 01. Learn how to simplify, inherit, encapsulate, and expand

I loved VBA. One of the primary reasons was that it was simple.

1『这是 VBA 的代码，以后再研读。（2022-03-22）』





Do you want to draw a line in ModelSpace? Use the AddLine method of the ModelSpace Class. Simple. What does VB.NET look like?

Typing that much code every time I want to draw a simple line in AutoCAD is far from ideal. I’d much rather use something like this:

How do we get there? By writing code, of course.

That’s a lot of code. I get it. But let’s take a look at why it is designed the way it is.

First Parameter: DBIn as Database—this allows us to add a line to any database we can supply. This means it can be used against the current database or against a DWG file that was read into a Database but without opening in AutoCAD. This can be used with Core Console applications because the Database is a parameter.

Params 2-7: Point parameters are individualized instead of having an array (as in VBA) which makes it easier to work with in many circumstances.

Param 8: LayoutName allows us to specify either “Model” for ModelSpace or the name of the PaperSpace Layout we want to draw into.

This code is not a recommendation for all situations. However, there are times when rather than always creating a new Transaction, using an existing Transaction makes more sense. So, in this example, we are using the TopTransaction if it exists. Otherwise we start a new Transaction.

We want to be able to specify the Layout to draw in. If a specific layoutName is not provided, we draw in ModelSpace. Otherwise, we attempt to draw to the specified Layout. If the layout does not exist, we draw in ModelSpace. A Function named “LayoutNameToBTRid” was created to simplify determining the BlockTableRecord to draw to if a LayoutName is specified. Here’s that code:

There are many ways to accomplish the same task. This is just one of them. Once again, we pass in the Layout’s Database so this Function can be used in many ways.

OK. Back to our code:

We create the new Line Entity, append it to the BlockTableRecord, add it to the Transaction, and commit the Transaction ONLY if we created a new Transaction. If, however, we used a Transaction that was already open, we don’t want to commit it because that could cause other problems where that open Transaction is being used.

We return the ObjectID of the Line because we can do a lot with an ObjectID.

• An ObjectID can be passed around without needing an active Transaction.

• The ObjectID has a Database property which allows us to, from the ObjectID, start a new Transaction to read and/or write to other elements in the ObjectID’s database.

Let’s not forget why we have all of that code. It’s because we want to be able to use one line of code to add a line to a DWG file.

Simplifying our code means writing ‘big code’ once and using this simplified code any time we want to draw a line in all future applications. Think about it. 10 minutes or so to write a Function that allows us to write 1-liners for the next 10 years.

As this Wikipedia entry describes, Encapsulation is defined differently by different people. The first definition talks about ‘restricting direct access’. That sounds like a security matter but encapsulation is also a way to ‘hide’ complexity. It goes hand in hand with simplifying our code.

Inheritance

Implementing Inheritance does not necessarily make our applications more powerful. It can, however, help us as we create more powerful applications. It takes some planning as we will see.

We want to create our own Classes to be used anytime we want to work with Lines, Circles, Arcs, etc. We do this by identifying properties all of these entities have in common.

All entities have an ObjectID.

All entities have a Layer.

All entities have a Color.

All entities have a Handle.

There are other properties shared by all entities but we will stick with these

The name of the Class is “vbcEntity”. We have implemented the ObjectID, Handle, Layer, and Color properties. Two of these (ObjectID and Handle) can be used by simply declaring them as Properties. The Color and Layer, however, need to be implemented with custom ‘Set’s.

The SetLayer Function is used to set an Entity’s Layer. If the specified Layer does not exist, we want to create it. This allows us to create Entities and specify their Layer as a Property while Encapsulating all of the code required into a simple call that requires an ObjectID and a LayerName.

SetColor is used to set an Entity’s Color. It’s fairly straight forward. Though it is not as ‘complex’ as SetLayer, it still allows us to set an Entity’s Color with one line of code when we use it.

Let’s take another look at the Full vbcEntity Class:

Now let’s take a look at the vbcLine Class:

Notice the “Inherits vbcEntity” line of code. This means that not only does the vbcLine have a StartPoint, EndPoint, and MidPoint property, but it also has the 4 properties of the vbcEntity.

Let’s take a look at the full code of the vbcLine Class:

Imports Autodesk.AutoCAD.DatabaseServices Imports Autodesk.AutoCAD.Geometry Public Class vbcLine Inherits vbcEntity

Public Sub New(DBIn As Database, X1 As Double, Y1 As Double, Z1 As Double, X2 As Double, Y2 As Double, Z2 As Double, Optional layoutName As String = "")

eObjectID = DrawLine(DBIn, X1, Y1, Z1, X2, Y2, Z2, layoutName)

eHandle = eObjectID.Handle.ToString End Sub

Public Sub New(dbin As Database, BlockName As String, X1 As Double, Y1 As Double, Z1 As Double, X2 As Double, Y2 As Double, Z2 As Double)

eObjectID = DrawLine(dbin, BlockName, X1, Y1, Z1, X2, Y2, Z2)

eHandle = eObjectID.Handle.ToString End Sub

Public Property StartPoint As Point3d Get Using myTrans As Transaction = eObjectID.Database.TransactionManager.StartTransaction Dim myLine As Line = eObjectID.GetObject(OpenMode.ForRead) Return (myLine.StartPoint) End Using End Get Set(value As Point3d) Using myTrans As Transaction = eObjectID.Database.TransactionManager.StartTransaction Dim myLine As Line = eObjectID.GetObject(OpenMode.ForWrite) myLine.StartPoint = value myTrans.Commit() End Using End Set End Property

Public Property EndPoint As Point3d Get Using myTrans As Transaction = eObjectID.Database.TransactionManager.StartTransaction Dim myLine As Line = eObjectID.GetObject(OpenMode.ForRead) Return (myLine.EndPoint) End Using End Get Set(value As Point3d) Using myTrans As Transaction = eObjectID.Database.TransactionManager.StartTransaction Dim myLine As Line = eObjectID.GetObject(OpenMode.ForWrite) myLine.EndPoint = value myTrans.Commit() End Using End Set End Property

Public Property MidPoint As Point3d Get Using myTrans As Transaction = eObjectID.Database.TransactionManager.StartTransaction Dim myLine As Line = eObjectID.GetObject(OpenMode.ForRead) Dim myLS As New LineSegment3d(myLine.StartPoint, myLine.EndPoint) Return (myLS.MidPoint) End Using

End Get

Set(value As Point3d) Using myTrans As Transaction = eObjectID.Database.TransactionManager.StartTransaction Dim myLine As Line = eObjectID.GetObject(OpenMode.ForWrite) Dim myLS As New LineSegment3d(myLine.StartPoint, myLine.EndPoint) myLine.TransformBy(Matrix3d.Displacement(myLS.MidPoint.GetVectorTo(value))) myTrans.Commit() End Using

End Set

End Property End Class

You may have noticed there are 2 ways to create our vbcLine.

The first ‘New’ takes the Database, XYZ Coordinates, and allows us to optionally specify a Layout Name.

The second ‘New’ takes the Database, BlockName, and XYZ Coordinates. Why the difference?

If we want to draw a Line into a Block Definition that can be inserted as a Block Reference, it needs to be created differently than if we are drawing in ModelSpace. In this example, if a BlockName is given and that Block does not currently exist in the Database specified, we need to create the Block Definition (BlockTableRecord).

The first ‘New’ uses the DrawLine Function we already looked at. Let’s take a look at the second ‘New’s DrawLine Function:

The BlockNameToBTRid Function is used to return the ObjectID of a BlockTableRecord if it exists. Otherwise, it creates a new BlockTableRecord and returns its ObjectID.

Let’s take a look at a little code that makes use of the vbcLine Class now.

Here we can see the vbcLine Class being created both ways we just discussed. In the first use, the Line is placed on the “Electrical” Layout if that Layout exists. If the Layout does not exist, it is placed in ModelSpace. We also set the Layer Property to “Ground”. Please ignore the MidPoint property for now. We will get to that in a minute.

Inside the For I . . . Next loop, we can see that each Line created is placed in a Block named “grid”.

We can see the Line created in ModelSpace and the “grid” block drawn with the For I . . . Next loops.

Let’s talk about the MidPoint Property of the vbcLine Object.

In the AutoCAD .NET API, a Line does not have a MidPoint Property. We want to Extend/Expand our vbcLine Class to include this property. To add to that, the MidPoint property of most objects is a read-only property. We want to be able to ‘move’ our vbcLine to a specified MidPoint.

Let’s take a look at the StartPoint, EndPoint, and MidPoint properties we have implemented:

Extend / Expand

StartPoint and MidPoint are easy. The MidPoint is a little different. We use the LineSegment3d Class (build-into AutoCAD’s .NET API) to get a MidPoint property. This is in the Geometry Namespace. But the Line Entity (DatabaseServices Namespace) does not have a MidPoint Property. The Get is easy. The Set is also fairly easy but we Transform (move) the Line to the specified MidPoint by getting a Vector from the existing LinePoint’s MidPoint to the specified new MidPoint.

The MidPoint Property we have implemented is just the beginning. We can overload the ‘New’ Constructor. Here are a couple of thoughts:

• Specify Database, MidPoint, Length, Rotation

• Specify Database, StartPoint, Length, Rotation

Additional Properties and Methods can also be added to make it easy to work with Lines in our programming.


Learning about when and how to use Dictionaries, Lists, and Arrays

Dictionaries, Lists, and Arrays allow us to ‘hold’ multiple items in a single ‘container’. They are usually used to ‘hold’ multiple objects of the same type.

Dictionaries are not just for String, String pairs. Take a look:

Keys can be any Type and Values can be any Type (or at least any type I have tried). The above code shows a variety of Keys and Values.

Once in a Dictionary, the Key/Value Pairs can be stepped through with code such as:

SortedDictionaries and SortedLists

SortedDictionaries and SortedLists automatically sort the elements based on the keys. The SortedList has a sort Key and a Value just like the Dictionary. There is a difference in the way the Dictionary and List is sorted so it may be good to do a little testing to see which works best in each given situation.

So, when do we use a Dictionary, List, or Array? If something needs to be sorted, either a SortedDictionary or SortedList is used, of course. If we just only need items, not ‘named’ items, the List is best. If we need ‘named’ items, the Dictionary is what should be used. Where does the Array come in? Arrays of various objects are used as return values of Functions from a variety of sources. The great thing is that Lists can be ‘converted’ to an Array by using the ToArray method if an Array is needed. The same can be said of Values and Keys of Dictionaries.

Learn how to use all of the .NET Framework and be creative once in a while

The .NET Framework is massive. There are a lot of things that can be done. If we take a look at the .NET Framework References we can add to our projects, we may become overwhelmed.

That’s a lot to work with. Let’s try using a couple of them.

This example uses the System.Drawing namespace to get the Thumbnail Bitmap from the supplied Database, then writes the name of the .dwg file at the bottom of the preview bitmap.

System.IO.Compression.FileSystem

If you have ever wanted to read an Excel file without having Excel load the file, the ExtractToDirectory call can be used to ‘extract’ the Excel file components into directories and XML files.

If you are planning on using this code, keep in mind that most of the values found in Excel files are in the sharedStrings.xml file.

Learn how to identify and consolidate your code into these tidy little units

While writing 10,000 lines of code in one CommandMethod will run and get things done, there are usually better ways to do things. Here are some things to consider in identifying what to ‘break out’ and how to break them out.

1 Is this code a one-off or will it be useful in other projects?

2 Can a group of code be considered a ‘Step’? Could you call it ‘Step 1’, ‘Step 2’, ‘Step 3’, etc.?

3 What can be ‘parameterized’ versus hard-coded values?

4 Will adding additional parameters make the Method or Function more useful?

5 ByVal vs ByRef—what should the Parameters be declared as?

6 ParamArray—Not used greatly but is perfect once in a while.

7 Can/Should a Call be Overloaded?

The next question is, how is this code ‘stored’ for future use?

A. Store it in a Class?

B. Store it in a Module?

C. Store it in a Code Snippet?

D. Store it in other Code Storage Mechanism?

One more thought—What is the code worth?

If 10 years are spent creating a library of Functions and Methods, Classes, Collections, etc. and we can now write a fully functional program with a few lines of code, is it worth 10 minutes of programming?

### Review

Our AutoCAD Add-Ins can be Better, Stronger, and More Stable if we take time to consider how to best write our code. Taking time during each project to write code that will be useful in future projects also results in code that is easier to debug and maintain. Making use of the .NET Framework can give our applications powerful features.

I hope your time here at Autodesk University is helpful you.

Thank you for your time.

Jerry Winters VB CAD, Inc. Jerryw@vbcad.com