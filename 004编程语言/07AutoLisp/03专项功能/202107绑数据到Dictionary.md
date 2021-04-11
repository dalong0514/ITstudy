# 202107. 绑数据到 Dictionary

1、先创建自定义字典或全局字典。设计流里用到的是自定义字典。

```
; 2021-03-29
(defun CreateCustomDictionaryByEntityNameUtils (entityName / dictionary exDictionary)
  ; Creates a new dictionary
  (setq dictionary (entmakex (list (cons 0 "DICTIONARY") (cons 100 "AcDbDictionary"))))
  (setq exDictionary (list (cons 102 "{ACAD_XDICTIONARY") (cons 360 dictionary)(cons 102 "}"))) 
  ; Attach the extension dictionary to the last object 
  (setq entityData (append (entget entityName) exDictionary)) 
  (entmod entityData) 
  (entupd entityName)
  (princ)
)

; 2021-03-29
(defun CreateDictionaryByEntityNameUtils (entityName / dictionary exDictionary)
  ; Creates a new dictionary
  (setq dictionary (entmakex (list (cons 0 "DICTIONARY") (cons 100 "AcDbDictionary"))))
  (setq newdictionary (dictadd (namedobjdict) "DATAFLOW_GS" dictionary))
)
```

2、对一个实体对象创建完「字典」对象后，可以对其进行绑定数据的操作。

```
; 2021-03-29
(defun BindStringDictionaryDataToObjectUtils (entityName stringData dKeyEntry /) 
  (if (GetDictionaryEntityNameUtils entityName) 
    (dictadd (GetDictionaryEntityNameUtils entityName) dKeyEntry 
      (entmakex (list (cons 0 "XRECORD")(cons 100 "AcDbXrecord") 
                      (cons 1 stringData))
      )
    ) 
    (princ "no Dictionary!")
  )
  (princ)
)

; 2021-03-29
(defun BindDictDictionaryDataToObjectUtils (entityName dictData dKeyEntry /)
  (BindStringDictionaryDataToObjectUtils 
    entityName 
    (DictListToJsonStringUtils dictData) 
    dKeyEntry)
)
```

3、获取绑定的信息。

```
; 2021-03-29
(defun GetStringDictionaryDataByEntityNameUtils (entityName dKeyEntry / entityData) 
  (setq entityData 
    (entget (GetDictionaryByKeyEntryUtils (GetDictionaryEntityNameUtils entityName) dKeyEntry))
  )
  (cdr (assoc 1 entityData))
)

; 2021-03-29
(defun GetDictDictionaryDataByEntityNameUtils (entityName dKeyEntry /) 
  (ParseJSONToListUtils (GetStringDictionaryDataByEntityNameUtils entityName dKeyEntry))
)
```

4、更新绑定的信息。



如果一个积木里的数据绑一个字典里太多的话，可以分散绑到多个字典上。

```
((-1 . <图元名: 7ff4a6726130>) (0 . "DICTIONARY") (330 . <图元名: 7ff4a6726110>) (5 . "50B") (100 . "AcDbDictionary") (280 . 1) (281 . 1) (3 . "DATAFLOW_GS") (360 . <图元名: 7ff4a6726140>) (3 . "DATAFLOW_NS") (360 . <图元名: 7ff4a67261a0>))
```

