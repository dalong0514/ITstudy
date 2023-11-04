;;---------------------=={ Entity List }==--------------------;;
;;                                                            ;;
;;  Displays the DXF Information for an entity, a variation   ;;
;;  of the program by Michael Puckett of the same name.       ;;
;;------------------------------------------------------------;;
;;  Author: Lee Mac - www.lee-mac.com                         ;;
;;------------------------------------------------------------;;
;;  Arguments: entity - entity (ename) / DXF list             ;;
;;------------------------------------------------------------;;

(defun elist ( entity / prin1x princx data xdata )

    (defun prin1x ( x i ) (repeat i (princ "  ")) (prin1 x))
    (defun princx ( x i ) (repeat i (princ "  ")) (princ x))

    (cond
        (   (or
                (and
                    (eq 'ENAME (type entity))
                    (setq data (entget entity))
                )
                (and
                    (listp entity)
                    (setq data entity)
                    (setq entity (cdr (assoc -1 data)))
                )
            )
            (princ "\n\n  (\n")
            (foreach pair data
                (prin1x pair 2)
                (princ "\n")
            )
            (if (setq xdata (assoc -3 (entget entity '("*"))))
                (progn
                    (princx "(" 2)
                    (prin1 (car xdata))
                    (princ "\n")
                    (foreach app (cdr xdata)
                        (princx "(" 3)
                        (princ "\n")
                        (foreach pair app (prin1x pair 4) (princ "\n"))
                        (princx ")" 3)
                        (princ "\n")
                    )
                    (princx ")" 2)
                    (princ "\n")
                )
            )
            (princ "  )")
            (if (= 1 (cdr (assoc 66 data)))
                (while
                    (progn
                        (elist (setq entity (entnext entity)))
                        (not (eq "SEQEND" (cdr (assoc 0 (entget entity)))))
                    )
                )
            )
        )
        (   (print entity)   )
    )
    (princ)
)

(defun c:ee  nil (elist (car (entsel))))
(defun c:eex nil (elist (car (nentsel))))