## 提取暖通设备数据

目前已经实现的：

直接写字符串：

```c
Public Sub CreateTxtFile()
  Dim fso As Object
  Dim myTxt As Object
  Dim MyFName As String
  Dim i As Integer
  Dim nowDate As String
  Dim sht As Worksheet
  
  nowDate = CDate(Now())
  nowDate = Replace(nowDate, ":", "") 

  MyFName = "E:\2.txt" 
  Set fso = CreateObject("Scripting.FileSystemObject") 
  Set myTxt = fso.CreateTextFile(Filename:=MyFName, OverWrite:=True) 

  myTxt.Write "fengdalong"
  
  myTxt.Close
  Set myTxt = Nothing
  Set fso = Nothing
End Sub
```

遍历多个表单的：

```c
Public Sub CreateTxtFile()
  Dim fso As Object
  Dim myTxt As Object
  Dim MyFName As String
  Dim i As Integer
  Dim nowDate As String
  Dim sht As Worksheet
  
  nowDate = CDate(Now())
  nowDate = Replace(nowDate, ":", "") 

  MyFName = "E:\2.txt" 
  Set fso = CreateObject("Scripting.FileSystemObject") 
  Set myTxt = fso.CreateTextFile(Filename:=MyFName, OverWrite:=True) 

  For Each sht In ThisWorkbook.Worksheets 
    myTxt.Write sht.Name & vbCrLf 
  Next
  
  myTxt.Close
  Set myTxt = Nothing
  Set fso = Nothing
End Sub
```

获取到特定单元格内数据已经实现。（2021-03-16）

```c
Public Sub ExtractEquipDataToCSV()
  Dim fso As Object
  Dim myTxt As Object
  Dim MyFName As String
  Dim sht As Worksheet
  Dim extractedData As String
  
  MyFName = "D:\dataflowcad\NsTempData\equip.txt" 
  
  Set fso = CreateObject("Scripting.FileSystemObject") 
  Set myTxt = fso.CreateTextFile(Filename:=MyFName, OverWrite:=True) 

  extractedData = Range("K8").Value
  'Range("A4").Value = 200
  myTxt.Write extractedData
  
  myTxt.Close
  Set myTxt = Nothing
  Set fso = Nothing
End Sub
```

弄出成品了：（2021-03-16）

```c
Public Sub ExtractEquipDataToCSV()
  Dim fso As Object
  Dim myTxt As Object
  Dim MyFName As String
  Dim row As Integer, column As Integer
  Dim extractedData As String
  
  MyFName = "D:\nsequip.csv"
  
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set myTxt = fso.CreateTextFile(Filename:=MyFName, OverWrite:=True)

  row = 1
  column = 1
  Do While Range("B2:E60").Cells(row, 1).Value <> ""
    For column = 1 To 5
      myTxt.Write ","
      myTxt.Write Range("B2:E60").Cells(row, column).Value
      
    Next column
    myTxt.Write vbCr
    row = row + 1
  Loop

  myTxt.Close
  Set myTxt = Nothing
  Set fso = Nothing
  MsgBox "Extract Sucess!"
End Sub
```

注意点：

1、嵌套循环之前一直不对，卡在最外围循环的判断条件上，之前是 `Do While Range("B2:E60").Cells(row, column).Value <> ""`，这个判断条件第 `column+1` 列是为非空值才能获得正确的列数。其实我只需看第一列的第 N 行是否为空值即可。

2、字符串的换行符是通过 `vbCr` 实现的。

3、把表头作为提取的第一行，因为之前工艺的临时文件都是去掉了表头，直接拿已有的函数复用，保持一致。如果第一行是有效数据会被剔除掉的。

## 提取设备工程图数据

实践了提取不同表格表单的数据。

```c
' 2021-04-19
Public Sub ExtractBsGCTDataToCSV()
  Dim fso As Object
  Dim myTxt As Object
  Dim MyFName As String
  Dim row As Integer, column As Integer
  Dim extractedData As String
  
  MyFName = "D:\dataflowcad\bsdata\bsGCT.csv"
  
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set myTxt = fso.CreateTextFile(Filename:=MyFName, OverWrite:=True)

  row = 1
  column = 1
  Do While Sheet1.Range("B2:U100").Cells(row, 1).Value <> ""
    myTxt.Write ",design"
    For column = 1 To 20
      myTxt.Write ","
      myTxt.Write Sheet1.Range("B2:U100").Cells(row, column).Value
      
    Next column
    myTxt.Write vbCr
    row = row + 1
  Loop

  ' Extract the nozzle data
  row = 1
  column = 1
  Do While Sheet2.Range("B3:H3000").Cells(row, 1).Value <> ""
  myTxt.Write ",nozzle"
    For column = 1 To 7
      myTxt.Write ","
      myTxt.Write Sheet2.Range("B3:H3000").Cells(row, column).Value
      
    Next column
    myTxt.Write vbCr
    row = row + 1
  Loop

  myTxt.Close
  Set myTxt = Nothing
  Set fso = Nothing
  MsgBox "Extract Sucess!"
End Sub
```

1、自动填充检测率数据时用到了通配符匹配（结合了 Case 选择语句）。

```c
' Abandoned at 2021-06-13
Sub SetTankInspectRate(range, columnNum)
  Dim row As Integer
  row = 1
  ' weld_joint is the frist column of the range
  Do While range.Cells(row, 1).Value <> ""
    ' barrel inspect_rate is the 7th column of the range
    Select Case True
      Case (range.Cells(row, 1).Value like "0.85/*") 
        range.Cells(row, columnNum).Value = "20%"
      Case (range.Cells(row, 1).Value like "1.0/*") 
        range.Cells(row, columnNum).Value = "100%"
      Case else 
        range.Cells(row, columnNum).Value = "/"
    End Select
    ' head inspect_rate is the 7th column of the range
    Select Case True
      Case (range.Cells(row, 1).Value like "*/0.85") 
        range.Cells(row, columnNum+1).Value = "20%"
      Case (range.Cells(row, 1).Value like "*/1.0") 
        range.Cells(row, columnNum+1).Value = "100%"
      Case else 
        range.Cells(row, columnNum+1).Value = "/"
    End Select
    row = row + 1
  Loop
End Sub
```