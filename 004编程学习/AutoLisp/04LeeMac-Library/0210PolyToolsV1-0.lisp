;; Polyline Close  -  Lee Mac
;; Closes all polylines in a selection.

(defun c:pc ( / *error* idx sel )

    (defun *error* ( msg )
        (LM:endundo (LM:acdoc))
        (if (and msg (not (wcmatch (strcase msg t) "*break,*cancel*,*exit*")))
            (princ (strcat "\nError: " msg))
        )
        (princ)
    )

    (LM:startundo (LM:acdoc))
    (if
        (setq sel
            (LM:ssget "\nSelect open polylines: "
               '(   "_:L"
                    (
                        (0 . "LWPOLYLINE")
                        (-4 . "<NOT")
                            (-4 . "&=") (70 . 1)
                        (-4 . "NOT>")
                    )
                )
            )
        )
        (repeat (setq idx (sslength sel))
            (vla-put-closed (vlax-ename->vla-object (ssname sel (setq idx (1- idx)))) :vlax-true)
        )
    )
    (*error* nil)
    (princ)
)

;; Polyline Join  -  Lee Mac
;; Attempts to join all lines, arcs and polylines in a selection.

(defun c:pj ( / *error* sel val var )
    
    (defun *error* ( msg )
        (mapcar '(lambda ( a b ) (if b (setvar a b))) var val)
        (LM:endundo (LM:acdoc))
        (if (and msg (not (wcmatch (strcase msg t) "*break,*cancel*,*exit*")))
            (princ (strcat "\nError: " msg))
        )
        (princ)
    )

    (LM:startundo (LM:acdoc))
    (if
        (setq sel
            (LM:ssget "\nSelect lines, arcs & polylines: "
               '(    "_:L"
                    (
                        (-4 . "<OR")
                             (0 . "LINE,ARC")
                             (-4 . "<AND")
                                 (0 . "LWPOLYLINE")
                                 (-4 . "<NOT")
                                     (-4 . "&=") (70 . 1)
                                 (-4 . "NOT>")
                             (-4 . "AND>")
                         (-4 . "OR>")
                    )
                )
            )
        )
        (progn
            (setq var '(cmdecho peditaccept)
                  val  (mapcar 'getvar var)
            )
            (mapcar '(lambda ( a b c ) (if a (setvar b c))) val var '(0 1))
            (command "_.pedit" "_m" sel "" "_j" "" "")
        )
    )
    (*error* nil)
    (princ)
)

;; Polyline Width  -  Lee Mac
;; Applies a given constant width to all segments in a selection of polylines.

(defun c:pw ( / *error* idx sel wid )

    (defun *error* ( msg )
        (LM:endundo (LM:acdoc))
        (if (and msg (not (wcmatch (strcase msg t) "*break,*cancel*,*exit*")))
            (princ (strcat "\nError: " msg))
        )
        (princ)
    )

    (LM:startundo (LM:acdoc))
    (if (setq sel (LM:ssget "\nSelect polylines: " '("_:L" ((0 . "LWPOLYLINE")))))
        (progn
            (initget 4)
            (setq wid (cond ((getdist "\nSpecify width for all segments <0.0>: ")) (0.0)))
            (repeat (setq idx (sslength sel))
                (vla-put-constantwidth (vlax-ename->vla-object (ssname sel (setq idx (1- idx)))) wid)
            )
        )
    )
    (*error* nil)
    (princ)
)

;; ssget  -  Lee Mac
;; A wrapper for the ssget function to permit the use of a custom selection prompt
;; msg - [str] selection prompt
;; arg - [lst] list of ssget arguments

(defun LM:ssget ( msg arg / sel )
    (princ msg)
    (setvar 'nomutt 1)
    (setq sel (vl-catch-all-apply 'ssget arg))
    (setvar 'nomutt 0)
    (if (not (vl-catch-all-error-p sel)) sel)
)

;; Start Undo  -  Lee Mac
;; Opens an Undo Group.

(defun LM:startundo ( doc )
    (LM:endundo doc)
    (vla-startundomark doc)
)

;; End Undo  -  Lee Mac
;; Closes an Undo Group.

(defun LM:endundo ( doc )
    (while (= 8 (logand 8 (getvar 'undoctl)))
        (vla-endundomark doc)
    )
)

;; Active Document  -  Lee Mac
;; Returns the VLA Active Document Object

(defun LM:acdoc nil
    (eval (list 'defun 'LM:acdoc 'nil (vla-get-activedocument (vlax-get-acad-object))))
    (LM:acdoc)
)
(vl-load-com) (princ)