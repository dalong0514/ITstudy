;; Dump Object  -  Lee Mac
;; Lists the ActiveX properties & methods of a supplied VLA-Object
;; or VLA-Object equivalent of a supplied ename, handle, or DXF data list
;; obj - [vla/ent/lst/str] VLA-Object, Entity Name, DXF List, or Handle

(defun c:dump  nil (LM:dump (car (entsel))))
(defun c:dumpn nil (LM:dump (car (nentsel))))

(defun LM:dump ( arg )
    (cond
        (   (= 'vla-object (type arg))
            (vlax-dump-object arg t)
        )
        (   (= 'ename (type arg))
            (LM:dump (vlax-ename->vla-object arg))
        )
        (   (= 'list (type arg))
            (LM:dump (cdr (assoc -1 arg)))
        )
        (   (= 'str  (type arg))
            (LM:dump (handent arg))
        )
    )
    (princ)
)
(vl-load-com) (princ)