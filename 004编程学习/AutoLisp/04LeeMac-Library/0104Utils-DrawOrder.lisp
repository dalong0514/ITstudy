;; Move to Top  -  Lee Mac
;; Moves a set of objects to the top of the draw order.
;; obs - [lst/sel] Selection set or list of objects with same owner
;; Returns: T if successful, else nil

(defun LM:movetotop ( obs / tab )
    (if (and (or (= 'list (type obs)) (setq obs (LM:ss->vla obs)))
             (setq tab (LM:sortentstable (LM:getowner (car obs))))
        )
        (not (vla-movetotop tab (LM:safearrayvariant vlax-vbobject obs)))
    )
)

;; Move to Bottom  -  Lee Mac
;; Moves a set of objects to the bottom of the draw order.
;; obs - [lst/sel] Selection set or list of objects with same owner
;; Returns: T if successful, else nil

(defun LM:movetobottom ( obs / tab )
    (if (and (or (= 'list (type obs)) (setq obs (LM:ss->vla obs)))
             (setq tab (LM:sortentstable (LM:getowner (car obs))))
        )
        (not (vla-movetobottom tab (LM:safearrayvariant vlax-vbobject obs)))
    )
)

;; Move Above  -  Lee Mac
;; Moves a set of objects above a supplied object in the draw order.
;; obs - [lst/sel] Selection set or list of objects with same owner
;; obj - [vla] Object above which to move supplied objects
;; Returns: T if successful, else nil

(defun LM:moveabove ( obs obj / tab )
    (if (and (or (= 'list (type obs)) (setq obs (LM:ss->vla obs)))
             (setq tab (LM:sortentstable (LM:getowner (car obs))))
        )
        (not (vla-moveabove tab (LM:safearrayvariant vlax-vbobject obs) obj))
    )
)

;; Move Below  -  Lee Mac
;; Moves a set of objects below a supplied object in the draw order.
;; obs - [lst/sel] Selection set or list of objects with same owner
;; obj - [vla] Object below which to move supplied objects
;; Returns: T if successful, else nil

(defun LM:movebelow ( obs obj / tab )
    (if (and (or (= 'list (type obs)) (setq obs (LM:ss->vla obs)))
             (setq tab (LM:sortentstable (LM:getowner (car obs))))
        )
        (not (vla-movebelow tab (LM:safearrayvariant vlax-vbobject obs) obj))
    )
)

;; Swap Order  -  Lee Mac
;; Swaps the draw order of two objects (may require regen).
;; ob1,ob2 - [vla] Objects to swap
;; Returns: T if successful, else nil

(defun LM:swaporder ( ob1 ob2 / tab )
    (if (setq tab (LM:sortentstable (LM:getowner ob1)))
        (not (vla-swaporder tab ob1 ob2))
    )
)

;; Get Owner -  Lee Mac
;; A wrapper for the objectidtoobject method & ownerid property to enable
;; compatibility with 32-bit & 64-bit systems

(defun LM:getowner ( obj )
    (eval
        (list 'defun 'LM:getowner '( obj )
            (if (vlax-method-applicable-p obj 'ownerid32)
                (list 'vla-objectidtoobject32 (LM:acdoc) '(vla-get-ownerid32 obj))
                (list 'vla-objectidtoobject   (LM:acdoc) '(vla-get-ownerid   obj))
            )
        )
    )
    (LM:getowner obj)
)

;; Catch Apply  -  Lee Mac
;; Applies a function to a list of parameters and catches any exceptions.
 
(defun LM:catchapply ( fnc prm / rtn )
    (if (not (vl-catch-all-error-p (setq rtn (vl-catch-all-apply fnc prm))))
        rtn
    )
)

;; Sortents Table  -  Lee Mac
;; Retrieves the Sortents Table object.
;; obj - [vla] Block Container Object

(defun LM:sortentstable ( obj / dic )
    (cond
        (   (LM:catchapply 'vla-item (list (setq dic (vla-getextensiondictionary obj)) "acad_sortents")))
        (   (LM:catchapply 'vla-addobject  (list dic "acad_sortents" "AcDbSortentsTable")))
    )
)

;; Selection Set to VLA Objects  -  Lee Mac
;; Converts a Selection Set to a list of VLA Objects
;; sel - [sel] Selection set (pickset)

(defun LM:ss->vla ( sel / idx lst )
    (if (= 'pickset (type sel))
        (repeat (setq idx (sslength sel))
            (setq lst (cons (vlax-ename->vla-object (ssname sel (setq idx (1- idx)))) lst))
        )
    )
)

;; Safearray Variant  -  Lee Mac
;; Returns a populated safearray variant of a specified data type
;; typ - [int] Variant type enum (e.g. vlax-vbdouble)
;; lst - [lst] List of static type data

(defun LM:safearrayvariant ( typ lst )
    (vlax-make-variant
        (vlax-safearray-fill
            (vlax-make-safearray typ (cons 0 (1- (length lst))))
            lst
        )
    )
)

;; Active Document  -  Lee Mac
;; Returns the VLA Active Document Object

(defun LM:acdoc nil
    (eval (list 'defun 'LM:acdoc 'nil (vla-get-activedocument (vlax-get-acad-object))))
    (LM:acdoc)
)

(vl-load-com) (princ)