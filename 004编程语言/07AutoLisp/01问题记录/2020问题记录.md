## 问题记录2020

### 01. 编码问题

最大的问题是编码，导出的无论是 txt 还 csv 电脑里打开是好的，上到服务器中文是乱码，cad 默认出来的是 gb2312 编码的，弄了好久好久才解决。

[用 lisp 调用 vb 把 ANSI 编码的文件转换成 UTF-8 - AutoLISP/Visual LISP 编程技术](http://bbs.mjtd.com/thread-82886-1-1.html)

### 02. VLAX-GET-ACAD-OBJECT

自己电脑上跑没问题，但在公司电脑上跑（包括公司里其他人的电脑），报错：

```
error: no function definition: VLAX-GET-ACAD-OBJECT
```

解决方案：[error: no function definition: VLAX-GET-ACAD-OBJECT - AutoLISP, Visual LISP & DCL - AutoCAD Forums](https://www.cadtutor.net/forum/topic/19261-error-no-function-definition-vlax-get-acad-object/)

文件开始的地方（函数之外）加下面一行代码：

```
(vl-load-com)
```

目前放在命令说明的语句下面的。

回复：看到官方文档才明白为什么会出现这个 bug。因为自己的代码里会用到 ActiveX 相关的支持，得靠这个语句来加载关联上。

[Pomoc: vl-load-com (AutoLISP/ActiveX)](http://help.autodesk.com/view/OARX/2018/PLK/?guid=GUID-6C7A8632-C12F-42BD-909E-68D804863AE2)

Loads the extended AutoLISP functions related to ActiveX support.

```c
(vl-load-com)
```

No arguments.

Return Values. Type: nil. Always returns nil.

Remarks. This function loads the extended functions that implement ActiveX and AutoCAD reactor support for AutoLISP, and also provide ActiveX utility and data conversion, dictionary handling, and curve measurement functions. If the extensions are already loaded, vl-load-com does nothing.

### 03. 仪表属性块内增加安装位置尺寸和方向属性后无法提取

弄了半天才解决，奇怪的是发现仅仅是因为顺序的问题，把之前最后的正常流量拿到前面去，必须先安装尺寸再安装的方向。

回复：目前找到的原因（不是很确定），lisp 里提取各个属性的顺序只要保持跟 cad 块中各属性的顺序相同即可。（2020-07-27）

### 04. 有关生成单行文字实体对象的问题

```c
(defun GenerateTextByPositionAndContent (insPt textContent /)
  (entmake (list (cons 0 "TEXT") (cons 100 "AcDbEntity") (cons 67 0) (cons 410 "Model") (cons 8 "管道编号") (cons 100 "AcDbText") 
                  (cons 10 insPt) (cons 11 '(0.0 0.0 0.0)) (cons 40 3.0) (cons 1 textContent) (cons 50 1.5708) (cons 41 0.7) (cons 51 0.0) 
                  (cons 7 "HZTXT") (cons 71 0) (cons 72 0) (cons 73 0) (cons 210 '(0.0 0.0 1.0)) (cons 100 "AcDbText") 
             )
  )(princ)
)

(defun GenerateEquipTagText (insPt textContent /)
  (entmake (list (cons 0 "TEXT") (cons 100 "AcDbEntity") (cons 67 0) (cons 410 "Model") (cons 8 "设备位号") (cons 100 "AcDbText") 
                  (cons 10 '(0.0 0.0 0.0)) (cons 11 insPt) (cons 40 3.0) (cons 1 textContent) (cons 50 0.0) (cons 41 0.7) (cons 51 0.0) 
                  (cons 7 "HZTXT") (cons 71 0) (cons 72 1) (cons 73 0) (cons 210 '(0.0 0.0 1.0)) (cons 100 "AcDbText") 
             )
  )(princ)
)
```

第一个函数是自动生成辅助流程时写文字的，竖直方向的、左对齐的。第二个函数是自动生成设备位号时用的，水平方向的、居中的。目前自己的理解。dxf code 71-73 是跟对其方式有关的：1）71、72、73 都为 0 的为左对齐；2）72 为 1，其余为 0 时为居中对齐；3）73 为 1，其余为 0 时为左下对齐。4）71 为 0，72、73 为 1 时为中下。那么其他对齐方式应该都可以通过这 3 个方式来组合实现。值得注意的时，对齐方式要跟插入点匹配。比如左对齐的时候，10 为插入点，11 设为 0 坐标，居中对其的时候，10 为 0 坐标，而 11 作为插入点。其中的规律目前没弄明白。（2020-10-30）

### 05. 条件语句注意事项

if 判断，结果为真后的语句有多个，经常忘记写 `progn` 语句。

### 06. 函数返回值的问题

场景：获取仪表、设备、管道等选择集的时候想把这些选择集封装在一起，通过传入一个参数来返回特定的选择集。结果发现多个 if 语句后，导致一直返回 nil。

解决方法：印象中是在书籍里「2019116AutoCAD-Platform-CustomizationR00」里看到过，可以人为的设置一个变量作为该函数的返回值。一个小插曲，开始的时候把该变量放在每个 if 语句内的，发现无效，还是要拿到 if 语句之外来。

```c
; get the select set
(defun GetBlockSS (blockSSName / ss)
  ; need to refactor
  (if (= blockSSName "Pipe")
    (progn
      (setq ss (ssget '((0 . "INSERT") 
            (-4 . "<OR")
              (2 . "PipeArrowLeft")
              (2 . "PipeArrowUp")
            (-4 . "OR>")
          )
        )
      )
    )
  )
  (if (= blockSSName "Instrument")
    (progn
      (setq ss (ssget '((0 . "INSERT") 
            (-4 . "<OR")
              (2 . "InstrumentP")
              (2 . "InstrumentL")
            (-4 . "OR>")
          )
        )
      )
    )
  )
  ss
)
```

### 07. 弹窗里下拉列表的第一个默认值自动获取不了数据

场景：数据流开发时，发现弹窗里下拉列表的第一个默认值（流程图号），自动获取不了数据，必须切换到其他选项后再切换回来才行。

解决方法：发现 `list_box` 或者 `popup_list` 这两个 tile，默认值不做任何动作时，它就是返回 nil，目前不知道是啥原因。加了一个 if 语句，是 nil 的话人为返回第一个选项的值（即 `"0"`）。

```c
(defun modifyBlockProperty (tileName blockSSName / dcl_id property_name property_value status selectedName ss)
  (setq dcl_id (load_dialog (strcat "D:\\dataflowcad\\" "dataflow.dcl")))
  (if (not (new_dialog tileName dcl_id))
    (exit)
  )
  ; optional setting for the popup_list tile
  (set_tile "property_name" "0")
  ;the default value of input box
  (set_tile "property_value" "")
  (mode_tile "property_name" 2)
  (mode_tile "property_value" 2)
  (action_tile "property_name" "(setq property_name $value)")
  (action_tile "property_value" "(setq property_value $value)")
  ; the solution code for the bug
  (if (= nil property_name)
    (setq property_name "0")
  )

  (setq status (start_dialog))
  (unload_dialog dcl_id)
  
  (if (= status 1)
    (progn 
      (setq selectedName (GetPropertyName property_name blockSSName))
      (setq ss (GetBlockSS blockSSName))
      (ModifyPropertyValue ss selectedName property_value)
      (alert "更新数据成功")(princ)
    )
    ;(alert "取消选择")
  )
)
```