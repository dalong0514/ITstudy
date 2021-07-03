;;------------------------=={ Areas to Field }==------------------------;;
;;                                                                      ;;
;;  This program allows a user to create an MText object containing a   ;;
;;  Field Expression referencing the area, or sum of areas, of one or   ;;
;;  more selected objects.                                              ;;
;;                                                                      ;;
;;  Upon issuing the command syntax 'A2F' at the AutoCAD command-line,  ;;
;;  the user is prompted to make a selection of objects for which to    ;;
;;  retrieve the area; if more than one object is selected, the         ;;
;;  cumulative area for all objects will be displayed by the resultant  ;;
;;  MText Field.                                                        ;;
;;                                                                      ;;
;;  Following object selection, the user is prompted to pick a point    ;;
;;  at which to create the MText Field. If the specified point resides  ;;
;;  within an AutoCAD table cell, the program will populate the table   ;;
;;  cell with the appropriate Field Expression.                         ;;
;;                                                                      ;;
;;  The Field will display the sum of the areas of the selected         ;;
;;  objects, formatted using the Field formatting code specified at     ;;
;;  the top of the program - this formatting code may be altered to     ;;
;;  suit the user's requirements.                                       ;;
;;                                                                      ;;
;;----------------------------------------------------------------------;;
;;  Author:  Lee Mac, Copyright © 2014  -  www.lee-mac.com              ;;
;;----------------------------------------------------------------------;;
;;  Version 1.3    -    2014-07-17                                      ;;
;;----------------------------------------------------------------------;;

(defun c:a2f ( / *error* fmt inc ins lst sel str )

    (setq fmt "%lu6%qf1") ;; Field Formatting

    (defun *error* ( msg )
        (LM:endundo (LM:acdoc))
        (if (not (wcmatch (strcase msg t) "*break,*cancel*,*exit*"))
            (princ (strcat "\nError: " msg))
        )
        (princ)
    )

    (if (and (setq sel (ssget '((0 . "ARC,CIRCLE,ELLIPSE,HATCH,*POLYLINE,REGION,SPLINE"))))
             (setq ins (getpoint "\nPick point or cell for field: "))
        )
        (progn
            (if (setq tmp
                    (ssget "_X"
                        (list '(0 . "ACAD_TABLE")
                            (if (= 1 (getvar 'cvport))
                                (cons 410 (getvar 'ctab))
                               '(410 . "Model")
                            )
                        )
                    )
                )
                (repeat (setq idx (sslength tmp))
                    (setq tab (cons (vlax-ename->vla-object (ssname tmp (setq idx (1- idx)))) tab))
                )
            )
            (if (= 1 (sslength sel))
                (setq str
                    (strcat
                        "%<\\AcObjProp Object(%<\\_ObjId "
                        (LM:ObjectID (vlax-ename->vla-object (ssname sel 0)))
                        ">%).Area \\f \"" fmt "\">%"
                    )
                )
                (progn
                    (repeat (setq idx (sslength sel))
                        (setq lst
                            (vl-list*
                                "%<\\AcObjProp Object(%<\\_ObjId "
                                (LM:ObjectID (vlax-ename->vla-object (ssname sel (setq idx (1- idx)))))
                                ">%).Area>%" " + "
                                lst
                            )
                        )
                    )
                    (setq str
                        (strcat
                            "%<\\AcExpr "
                            (apply 'strcat (reverse (cdr (reverse lst))))
                            " \\f \"" fmt "\">%"
                        )
                    )
                )
            )
            (LM:startundo (LM:acdoc))
            (if (setq tmp (LM:getcell tab (trans ins 1 0)))
                (apply 'vla-settext (append tmp (list str)))
                (vla-addmtext
                    (vlax-get-property (LM:acdoc) (if (= 1 (getvar 'cvport)) 'paperspace 'modelspace))
                    (vlax-3D-point (trans ins 1 0))
                    0.0
                    str
                )
            )
            (LM:endundo (LM:acdoc))
        )
    )
    (princ)
)

;; ObjectID  -  Lee Mac
;; Returns a string containing the ObjectID of a supplied VLA-Object
;; Compatible with 32-bit & 64-bit systems
 
(defun LM:ObjectID ( obj )
    (eval
        (list 'defun 'LM:ObjectID '( obj )
            (if
                (and
                    (vl-string-search "64" (getenv "PROCESSOR_ARCHITECTURE"))
                    (vlax-method-applicable-p (vla-get-utility (LM:acdoc)) 'getobjectidstring)
                )
                (list 'vla-getobjectidstring (vla-get-utility (LM:acdoc)) 'obj ':vlax-false)
               '(itoa (vla-get-objectid obj))
            )
        )
    )
    (LM:ObjectID obj)
)

;; Get Cell  -  Lee Mac
;; If the supplied point lies within a cell boundary,
;; returns a list of: (<VLA Table Object> <Row> <Col>)

(defun LM:getcell ( lst pnt / dir )
    (setq dir (vlax-3D-point (trans (getvar 'viewdir) 1 0))
          pnt (vlax-3D-point pnt)
    )
    (vl-some
       '(lambda ( tab / row col )
            (if (= :vlax-true (vla-hittest tab pnt dir 'row 'col))
                (list tab row col)
            )
        )
        lst
    )
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
 
;;----------------------------------------------------------------------;;
;;                             End of File                              ;;
;;----------------------------------------------------------------------;;