;;----------------------=={ Add Objects to Block }==--------------------;;
;;                                                                      ;;
;;  This program enables the user to add a selection of objects to the  ;;
;;  definition of a selected block.                                     ;;
;;                                                                      ;;
;;  Upon issuing the command syntax 'addtoblock' at the AutoCAD         ;;
;;  command line, the program prompts the user for a selection of       ;;
;;  objects residing on unlocked layers to be added to a chosen block   ;;
;;  definition.                                                         ;;
;;                                                                      ;;
;;  Following a valid selection, the program prompts the user to select ;;
;;  a reference of a block whose definition is to be modified to        ;;
;;  incorporate all objects in the selection.                           ;;
;;                                                                      ;;
;;  At this prompt, the program will permit selection of any standard   ;;
;;  (non-dynamic) uniformly scaled block reference which is not         ;;
;;  referenced within the selection (as a block reference cannot be     ;;
;;  added to its own definition).                                       ;;
;;                                                                      ;;
;;  Every object in the selection will then be transformed relative to  ;;
;;  the position, scale, rotation, and orientation of the selected      ;;
;;  block reference, before being copied to the definition of the       ;;
;;  block and removed from the drawing.                                 ;;
;;----------------------------------------------------------------------;;
;;  Author:  Lee Mac, Copyright © 2011  -  www.lee-mac.com              ;;
;;----------------------------------------------------------------------;;
;;  Version 1.1    -    2011-05-31                                      ;;
;;                                                                      ;;
;;  - First release.                                                    ;;
;;----------------------------------------------------------------------;;
;;  Version 1.2    -    2020-11-15                                      ;;
;;                                                                      ;;
;;  - Program completely rewritten to incorporate a check for           ;;
;;    references of the target block within the selected objects.       ;;
;;----------------------------------------------------------------------;;

(defun c:addtoblock ( / *error* bln bnl btr def ent enx idx lst sel tmp )

    (defun *error* ( msg )
        (LM:endundo (LM:acdoc))
        (if (not (wcmatch (strcase msg t) "*break,*cancel*,*exit*"))
            (princ (strcat "\nError: " msg))
        )
        (princ)
    )

    (LM:startundo (LM:acdoc))
    (cond
        (   (not (setq sel (LM:ssget "\nSelect objects to add to block: " '("_:L")))))
        (   (progn
                (repeat (setq idx (sslength sel))
                    (setq idx (1- idx)
                          ent (ssname sel idx)
                          enx (entget ent)
                          lst (cons (vlax-ename->vla-object ent) lst)
                    )
                    (if (and (= "INSERT" (cdr (assoc 0 enx)))
                             (not (member (setq bln (strcase (cdr (assoc 2 enx)))) bnl))
                        )
                        (setq bnl (cons bln bnl))
                    )
                )
                (while (setq def (tblnext "block" (not def)))
                    (setq ent (tblobjname "block" (cdr (assoc 2 def))))
                    (while (setq ent (entnext ent))
                        (if (= "INSERT" (cdr (assoc 0 (setq enx (entget ent)))))
                            (setq tmp (cons (strcase (cdr (assoc 2 enx))) tmp))
                        )
                    )
                    (if tmp
                        (setq btr (cons (cons (strcase (cdr (assoc 2 def))) tmp) btr)
                              tmp nil
                        )
                    )
                )
                (while
                    (progn (setvar 'errno 0) (setq ent (car (entsel "\nSelect block: ")))
                        (cond
                            (   (= 7 (getvar 'errno))
                                (princ "\nMissed, try again.")
                            )
                            (   (null ent)
                                nil
                            )
                            (   (/= "INSERT" (cdr (assoc 0 (setq enx (entget ent)))))
                                (princ "\nThe selected object is not a block.")
                            )
                            (   (not
                                    (and
                                        (equal (abs (cdr (assoc 41 enx))) (abs (cdr (assoc 42 enx))) 1e-8)
                                        (equal (abs (cdr (assoc 41 enx))) (abs (cdr (assoc 43 enx))) 1e-8)
                                    )
                                )
                                (princ "\nThis program is not currently compatible with non-uniformly scaled blocks - sorry.")
                            )
                            (   (= :vlax-true (vla-get-isdynamicblock (vlax-ename->vla-object ent)))
                                (princ "\nThis program is not currently compatible with dynamic blocks - sorry.")
                            )
                            (   (vl-some '(lambda ( bln ) (member bln bnl))
                                    (
                                        (lambda ( / rtn )
                                            (setq bln (strcase (cdr (assoc 2 enx))))
                                            (foreach def btr
                                                (cond
                                                    (   (= bln (car def)))
                                                    (   (member (car def) rtn))
                                                    (   (addtoblock:referenced-p bln (cdr def) btr) (setq rtn (cons (car def) rtn)))
                                                )
                                            )
                                            (cons bln rtn)
                                        )
                                    )
                                )
                                (princ "\nThe selected block is referenced by a block in the selection.")
                            )
                        )
                    )
                )
                ent
            )
            (   (lambda ( mat )
                    (foreach obj lst (vla-transformby obj mat))
                    (vla-copyobjects (LM:acdoc)
                        (vlax-make-variant
                            (vlax-safearray-fill
                                (vlax-make-safearray vlax-vbobject (cons 0 (1- (length lst))))
                                lst
                            )
                        )
                        (vla-item (vla-get-blocks (LM:acdoc)) (cdr (assoc 2 (entget ent))))
                    )
                    (foreach obj lst (vla-delete obj))
                    (vla-regen (LM:acdoc) acallviewports)
                )
                (apply
                    (function
                        (lambda ( mat vec )
                            (vlax-tmatrix
                                (append
                                    (mapcar
                                        (function
                                            (lambda ( x v )
                                                (append x (list v))
                                            )
                                        )
                                        mat vec
                                    )
                                   '((0.0 0.0 0.0 1.0))
                                )
                            )
                        )
                    )
                    (revrefgeom ent)
                )
            )
        )
    )
    (LM:endundo (LM:acdoc))
    (princ)
)

(defun addtoblock:referenced-p ( bln def lst )
    (or (member bln def)
        (vl-some '(lambda ( nst ) (addtoblock:referenced-p bln (cdr (assoc nst lst)) lst)) def)
    )
)

;; RevRefGeom (gile)
;; The inverse of RefGeom

(defun revrefgeom ( ent / ang enx mat ocs )
    (setq enx (entget ent)
          ang (cdr (assoc 050 enx))
          ocs (cdr (assoc 210 enx))
    )
    (list
        (setq mat
            (mxm
                (list
                    (list (/ 1.0 (cdr (assoc 41 enx))) 0.0 0.0)
                    (list 0.0 (/ 1.0 (cdr (assoc 42 enx))) 0.0)
                    (list 0.0 0.0 (/ 1.0 (cdr (assoc 43 enx))))
                )
                (mxm
                    (list
                        (list (cos ang)     (sin ang) 0.0)
                        (list (- (sin ang)) (cos ang) 0.0)
                       '(0.0 0.0 1.0)
                    )
                    (mapcar '(lambda ( v ) (trans v ocs 0 t))
                        '(
                             (1.0 0.0 0.0)
                             (0.0 1.0 0.0)
                             (0.0 0.0 1.0)
                         )
                    )
                )
            )
        )
        (mapcar '- (cdr (assoc 10 (tblsearch "block" (cdr (assoc 2 enx)))))
            (mxv mat (trans (cdr (assoc 10 enx)) ocs 0))
        )
    )
)

;; Matrix Transpose  -  Doug Wilson
;; Args: m - nxn matrix

(defun trp ( m )
    (apply 'mapcar (cons 'list m))
)

;; Matrix x Matrix  -  Vladimir Nesterovsky
;; Args: m,n - nxn matrices

(defun mxm ( m n )
    ((lambda ( a ) (mapcar '(lambda ( r ) (mxv a r)) m)) (trp n))
)

;; Matrix x Vector  -  Vladimir Nesterovsky
;; Args: m - nxn matrix, v - vector in R^n

(defun mxv ( m v )
    (mapcar '(lambda ( r ) (apply '+ (mapcar '* r v))) m)
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

;;----------------------------------------------------------------------;;

(vl-load-com)
(princ
    (strcat
        "\n:: AddObjectsToBlock.lsp | Version 1.2 | \\U+00A9 Lee Mac "
        ((lambda ( y ) (if (= y (menucmd "m=$(edtime,0,yyyy)")) y (strcat y "-" (menucmd "m=$(edtime,0,yyyy)")))) "2011")
        " www.lee-mac.com ::"
        "\n:: Type \"addtoblock\" to Invoke ::"
    )
)
(princ)

;;----------------------------------------------------------------------;;
;;                             End of File                              ;;
;;----------------------------------------------------------------------;;