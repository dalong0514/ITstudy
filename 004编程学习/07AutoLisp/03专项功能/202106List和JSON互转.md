## 202106. List 和 JSON 互转

备注：经测试，CAD 里 List 数据里只能全部是字符串才行。这是一个很大的局限，待解决。

解决思路：设计流导出临时文件时，数字也可以转化为 json 的，从那边着手找解决方案。补充：其实只要在 `DictListToJsonStringUtils` 函数里改造一下即可，拼接 json 字符串时因为用的是 `strcat` 函数，入参只能是字符串。而又因为从块内提取的属性数据全部自动转成了字符串，所以这个函数的 bug 没暴露出来。那么只需在拼接之前转化为字符串即可。用函数 `vl-princ-to-string`。待测试。（2021-04-19）

### 01. JSON 转 List

通过第三方库函数：

[Parse JSON with AutoLisp / VisualLisp - Autodesk Community - AutoCAD](https://forums.autodesk.com/t5/visual-lisp-autolisp-and-general/parse-json-with-autolisp-visuallisp/td-p/9332756)

经测试可以解析多层嵌套的 json 成 list 数组，超级赞。（2021-03-28）

```
(defun c:foo ()
  (BindXDataToObjectUtils (CreateStringXDataUtils "{\"Tag\" : {\"subTag\" : \"subTagValue\" , \"Num\" : -123.4}, \"Num\" : -123.4}"))
)

(defun c:ssfoo (/ temp) 
  (setq temp 
    (ParseJSONToListUtils (GetStringXDataByEntityNameUtils (car (GetEntityNameListBySSUtils (ssget)))))
  )
  (GetDottedPairValueUtils "Tag" temp)
)
```

源码：

```
; 2021-03-28
(defun ParseJSONToListUtils (json / data newData inStr dPrev strPos)
  ; Converts json string to list. By Denon Deterding (VL2 - 20200924)
  ; NOTE: json object strings will be truncated to 2300 characters MAX ('read' function limitation)
  ; ----- (the 'json' input variable is NOT limited to the 2300 chr limit)
  ; json - string, as json data
  ; returns - list, of data from json
  (setq data (vl-string->list json))
  (foreach d data
    (cond
      ;if we're in a string, test length and continue
      (inStr
        (if (or (setq inStr (and (= 34 d) (/= 92 dPrev)))
                (<= strPos 2300)) ;[--- MAX string length is 2300 characters ---]
          (setq strPos (1+ strPos) newData (cons d newData))
        );if
        (setq instr (not inStr))
      );cond 1
      ;this signals that we're starting a string
      ((= 34 d)
        (setq inStr t strPos 1 newData (cons d newData))
      );cond 2
      ;replacing relevant characters Outside of json object strings
      ((member d '(44 58 91 93 123 125)) ; ("," ":" "[" "]" "{" "}")
        (foreach n (cond
                     ((= 44 d) '(41 32 40))             ; ") ("
                     ((= 58 d) '(32))                   ; " "
                     ((or (= 91 d) (= 123 d)) '(40 40)) ; "(("
                     ((or (= 93 d) (= 125 d)) '(41 41)) ; "))"
                   );cond
          (setq newData (cons n newData))
        );foreach
      );cond 3
      ;these will signal a "true" value
      ((or (= 116 d) (= 84 d)) ; ("t" "T")
        (setq newData (cons 116 newData)) ; "t"
      );cond 4
      ;these will signal a "null" or "false" value (both are nil in lisp)
      ((or (= 110 d) (= 102 d) (= 78 d) (= 70 d)) ; ("n" "f" "N" "F")
        (foreach n '(110 105 108) (setq newData (cons n newData))) ; "nil"
      );cond 5
      ;this handles numbers.. real/int, pos/neg
      ((member d '(45 46 48 49 50 51 52 53 54 55 56 57)) ; ("-" "." "0" "1" "2" "3" "4" "5" "6" "7" "8" "9")
        (setq newData (cons d newData))
      );cond 6
    );cond
    (setq dPrev d)
  );foreach
  (read (vl-list->string (reverse newData)))
)
```

已下载附件「202105ParseJSON-VL2」

其他参考资料：

[mbeloshitsky/autolisp-json: JSON formatter and parser written in AutoLISP](https://github.com/mbeloshitsky/autolisp-json)

上面的仓库已经 fork 了，存入「2021003autolisp-json」。

[How to read JSON file format via lisp?](https://www.theswamp.org/index.php?topic=52084.0)

上面的帖子里学到一个很有用的函数（匹配替换多个元素）：

```
(read (vl-string-translate "[]{}:," "()()  " str))
```

[vl-string-translate (AutoLISP)](https://help.autodesk.com/view/OARX/2018/CHS/?guid=GUID-57060085-C79D-4613-B438-506AC443BCE7)

### 02. List 转 JSON

供参考的帖子：[Parse AutoLISP List to JSON - Autodesk Community - AutoCAD](https://forums.autodesk.com/t5/visual-lisp-autolisp-and-general/parse-autolisp-list-to-json/td-p/9905124)

但是之前自己开发数据流的时候，导出临时性数据是 json，当时自己封装好了一个函数，但只能处理一层 list 数组的转化，可以在此基础上重构成可以转化的多层嵌套 List 的函数。

已经实现的源码（2021-03-28）：

```
; refactored at 2021-03-28
(defun DictListToJsonStringUtils (DictList / jsonPropertyString)
  (setq jsonPropertyString 
    (apply 'strcat 
      (mapcar '(lambda (x) 
                 (if (IsListDataTypeUtils (cdr x)) 
                   ; must has the , at the end - 2021-03-28
                   (strcat "\"" (strcase (car x) T) "\": " (DictListToJsonStringUtils (cdr x)) ",")
                   (strcat "\"" (strcase (car x) T) "\": \"" (cdr x) "\",")
                 )
              ) 
        DictList
      ) 
    )
  )
  (setq jsonPropertyString (RemoveLastNumCharForStringUtils jsonPropertyString 1))
  (setq jsonPropertyString (strcat "{" jsonPropertyString "}"))
)
```