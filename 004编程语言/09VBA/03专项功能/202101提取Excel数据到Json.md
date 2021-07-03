## 提取压力表临时文件数据成 json 数据

参考资料：

[Excel VBA Array - The Complete Guide - Excel Macro Mastery](https://excelmacromastery.com/excel-vba-array/)

[The Ultimate Guide to VBA String Functions - Excel Macro Mastery](https://excelmacromastery.com/vba-string-functions/#Replace_Part_of_a_String)

```c
' 2021-07-04
Sub ExtractKsPressureSupplyDataToCSV()
  Dim fso As Object
  Dim myTxt As Object
  Dim MyFName As String
  
  MyFName = "D:\dataflowcad\tempdata\ksPressureSupply.json"
  
  Set fso = CreateObject("Scripting.FileSystemObject")
  Set myTxt = fso.CreateTextFile(Filename:=MyFName, OverWrite:=True)

  ' the column in range could be wrong, still ok. eg [X100]
  Call ExtractRangeDataToJsonString(Sheet1.range("B3:C3"), Sheet1.range("B4:C4"), 1, 2, myTxt)
  Call ExtractRangeDataToJsonString(Sheet1.range("B6:AG6"), Sheet1.range("B8:AG500"), 1000, 32, myTxt)

  myTxt.Close
  Set myTxt = Nothing
  Set fso = Nothing

  MsgBox "Extract Sucess!"
End Sub

Sub ExtractRangeData(range, rowNum, columnNum, myTxt)
  Dim row As Integer, column As Integer
  row = 1
  column = 1
  For row = 1 To rowNum
    ' Only extract the row that have the data
    if range.Cells(row, 1).Value <> "" Then 
      For column = 1 To columnNum
        myTxt.Write ","
        myTxt.Write range.Cells(row, column).Value
      Next column
      myTxt.Write vbCr
    End if
  Next row
End Sub

Sub ExtractRangeDataToJsonString(keyRange, valueRange, rowNum, columnNum, myTxt)
  Dim row As Integer, column As Integer, jsonString As String, cellString As String, arr As Variant
  arr = ExtractOneRowDataToArray(keyRange)
  row = 1
  column = 1
  For row = 1 To rowNum
    ' Only extract the row that have the data
    if valueRange.Cells(row, 1).Value <> "" Then 
      myTxt.Write "{"
      jsonString = ""
      For column = 1 To columnNum
        cellString = Replace(valueRange.Cells(row, column).Value, ",", "，")
        jsonString = jsonString & chr(34) & arr(column-1) & chr(34) & ":" & chr(34) & cellString & chr(34) & ","
      Next column
      jsonString = Left(jsonString, Len(jsonString)-1)
      myTxt.Write jsonString
      myTxt.Write "}"
      myTxt.Write vbCr
    End if
  Next row
End Sub

Function ExtractOneRowDataToArray(range)
  Dim column As Integer, csvString As String, arr As Variant
  column = 1
  csvString = ""
  Do While range.Cells(1, column).Value <> ""
    csvString = csvString & range.Cells(1, column).Value & ","
    column = column + 1
  Loop
  arr = Split(csvString, ",")
  ExtractOneRowDataToArray = arr
End Function
```