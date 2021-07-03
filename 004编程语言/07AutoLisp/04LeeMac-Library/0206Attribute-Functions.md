# Attribute Functions

[Attribute Functions | Lee Mac Programming](http://www.lee-mac.com/attributefunctions.html)

## 00. Introduction

Here are various functions which may be used to manipulate the values of block attributes using both Vanilla & Visual LISP. Information about the purpose, arguments and returns of each function is detailed in the code header.

## 01. Visual LISP

### Get Attribute Value

```c
;; Get Attribute Value  -  Lee Mac
;; Returns the value held by the specified tag within the supplied block, if present.
;; blk - [vla] VLA Block Reference Object
;; tag - [str] Attribute TagString
;; Returns: [str] Attribute value, else nil if tag is not found.

(defun LM:vl-getattributevalue ( blk tag )
    (setq tag (strcase tag))
    (vl-some '(lambda ( att ) (if (= tag (strcase (vla-get-tagstring att))) (vla-get-textstring att))) (vlax-invoke blk 'getattributes))
)
```

### Set Attribute Value

```c
;; Set Attribute Value  -  Lee Mac
;; Sets the value of the first attribute with the given tag found within the block, if present.
;; blk - [vla] VLA Block Reference Object
;; tag - [str] Attribute TagString
;; val - [str] Attribute Value
;; Returns: [str] Attribute value if successful, else nil.

(defun LM:vl-setattributevalue ( blk tag val )
    (setq tag (strcase tag))
    (vl-some
       '(lambda ( att )
            (if (= tag (strcase (vla-get-tagstring att)))
                (progn (vla-put-textstring att val) val)
            )
        )
        (vlax-invoke blk 'getattributes)
    )
)
```

### Get Attribute Values

```c
;; Get Attribute Values  -  Lee Mac
;; Returns an association list of attributes present in the supplied block.
;; blk - [vla] VLA Block Reference Object
;; Returns: [lst] Association list of ((<tag> . <value>) ... )

(defun LM:vl-getattributevalues ( blk )
    (mapcar '(lambda ( att ) (cons (vla-get-tagstring att) (vla-get-textstring att))) (vlax-invoke blk 'getattributes))
)
```

### Set Attribute Values

```c
;; Set Attribute Values  -  Lee Mac
;; Sets attributes with tags found in the association list to their associated values.
;; blk - [vla] VLA Block Reference Object
;; lst - [lst] Association list of ((<tag> . <value>) ... )
;; Returns: nil

(defun LM:vl-setattributevalues ( blk lst / itm )
    (foreach att (vlax-invoke blk 'getattributes)
        (if (setq itm (assoc (vla-get-tagstring att) lst))
            (vla-put-textstring att (cdr itm))
        )
    )
)
```

## 02. Vanilla LISP

### Get Attribute Value: Recursive Version

```c
;; Get Attribute Value  -  Lee Mac
;; Returns the value held by the specified tag within the supplied block, if present.
;; blk - [ent] Block (Insert) Entity Name
;; tag - [str] Attribute TagString
;; Returns: [str] Attribute value, else nil if tag is not found.

(defun LM:getattributevalue ( blk tag / enx )
    (if (and (setq blk (entnext blk)) (= "ATTRIB" (cdr (assoc 0 (setq enx (entget blk))))))
        (if (= (strcase tag) (strcase (cdr (assoc 2 enx))))
            (cdr (assoc 1 (reverse enx)))
            (LM:getattributevalue blk tag)
        )
    )
)
```

### Get Attribute Value: Iterative Version

```c
;; Get Attribute Value  -  Lee Mac
;; Returns the value held by the specified tag within the supplied block, if present.
;; blk - [ent] Block (Insert) Entity Name
;; tag - [str] Attribute TagString
;; Returns: [str] Attribute value, else nil if tag is not found.

(defun LM:getattributevalue ( blk tag / val enx )
    (while
        (and
            (null val)
            (setq blk (entnext blk))
            (= "ATTRIB" (cdr (assoc 0 (setq enx (entget blk)))))
        )
        (if (= (strcase tag) (strcase (cdr (assoc 2 enx))))
            (setq val (cdr (assoc 1 (reverse enx))))
        )
    )
)
```

### Set Attribute Value: Recursive Version

```c
;; Set Attribute Value  -  Lee Mac
;; Sets the value of the first attribute with the given tag found within the block, if present.
;; blk - [ent] Block (Insert) Entity Name
;; tag - [str] Attribute TagString
;; val - [str] Attribute Value
;; Returns: [str] Attribute value if successful, else nil.

(defun LM:setattributevalue ( blk tag val / enx )
    (if (and (setq blk (entnext blk)) (= "ATTRIB" (cdr (assoc 0 (setq enx (entget blk))))))
        (if (= (strcase tag) (strcase (cdr (assoc 2 enx))))
            (if (entmod (subst (cons 1 val) (assoc 1 (reverse enx)) enx))
                (progn
                    (entupd blk)
                    val
                )
            )
            (LM:setattributevalue blk tag val)
        )
    )
)
```

### Set Attribute Value: Iterative Version

```c
;; Set Attribute Value  -  Lee Mac
;; Sets the value of the first attribute with the given tag found within the block, if present.
;; blk - [ent] Block (Insert) Entity Name
;; tag - [str] Attribute TagString
;; val - [str] Attribute Value
;; Returns: [str] Attribute value if successful, else nil.

(defun LM:setattributevalue ( blk tag val / end enx )
    (while
        (and
            (null end)
            (setq blk (entnext blk))
            (= "ATTRIB" (cdr (assoc 0 (setq enx (entget blk)))))
        )
        (if (= (strcase tag) (strcase (cdr (assoc 2 enx))))
            (if (entmod (subst (cons 1 val) (assoc 1 (reverse enx)) enx))
                (progn
                    (entupd blk)
                    (setq end val)
                )
            )
        )
    )
)
```

### Get Attribute Values: Recursive Version

```
;; Get Attribute Values  -  Lee Mac
;; Returns an association list of attributes present in the supplied block.
;; blk - [ent] Block (Insert) Entity Name
;; Returns: [lst] Association list of ((<tag> . <value>) ... )

(defun LM:getattributevalues ( blk / enx )
    (if (and (setq blk (entnext blk)) (= "ATTRIB" (cdr (assoc 0 (setq enx (entget blk))))))
        (cons
            (cons
                (cdr (assoc 2 enx))
                (cdr (assoc 1 (reverse enx)))
            )
            (LM:getattributevalues blk)
        )
    )
)
```

### Get Attribute Values: Iterative Version

```c
;; Get Attribute Values  -  Lee Mac
;; Returns an association list of attributes present in the supplied block.
;; blk - [ent] Block (Insert) Entity Name
;; Returns: [lst] Association list of ((<tag> . <value>) ... )

(defun LM:getattributevalues ( blk / enx lst )
    (while (and (setq blk (entnext blk)) (= "ATTRIB" (cdr (assoc 0 (setq enx (entget blk))))))
        (setq lst
            (cons
                (cons
                    (cdr (assoc 2 enx))
                    (cdr (assoc 1 (reverse enx)))
                )
                lst
            )
        )
    )
    (reverse lst)
)
```

### Set Attribute Values: Recursive Version

```c
;; Set Attribute Values  -  Lee Mac
;; Sets attributes with tags found in the association list to their associated values.
;; blk - [ent] Block (Insert) Entity Name
;; lst - [lst] Association list of ((<tag> . <value>) ... )
;; Returns: nil

(defun LM:setattributevalues ( blk lst / enx itm )
    (if (and (setq blk (entnext blk)) (= "ATTRIB" (cdr (assoc 0 (setq enx (entget blk))))))
        (if (setq itm (assoc (cdr (assoc 2 enx)) lst))
            (progn
                (if (entmod (subst (cons 1 (cdr itm)) (assoc 1 (reverse enx)) enx))
                    (entupd blk)
                )
                (LM:setattributevalues blk lst)
            )
            (LM:setattributevalues blk lst)
        )
    )
)
```

### Set Attribute Values: Iterative Version

```c
;; Set Attribute Values  -  Lee Mac
;; Sets attributes with tags found in the association list to their associated values.
;; blk - [ent] Block (Insert) Entity Name
;; lst - [lst] Association list of ((<tag> . <value>) ... )
;; Returns: nil

(defun LM:setattributevalues ( blk lst / enx itm )
    (while (and (setq blk (entnext blk)) (= "ATTRIB" (cdr (assoc 0 (setq enx (entget blk))))))
        (if
            (and
                (setq itm (assoc (cdr (assoc 2 enx)) lst))
                (entmod (subst (cons 1 (cdr itm)) (assoc 1 (reverse enx)) enx))
            )
            (entupd blk)
        )
    )
    nil
)
```