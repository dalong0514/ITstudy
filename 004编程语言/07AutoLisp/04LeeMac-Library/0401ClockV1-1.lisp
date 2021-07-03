;;-----------------------------=={ Clock }==----------------------------;;
;;                                                                      ;;
;;  This novelty application will display a chronograph-style clock     ;;
;;  interface powered by a Visual LISP Command Reactor. The clock will  ;;
;;  display a traditional analog dial, including a 24-hour dial,        ;;
;;  day-of-the-week dial, the date, month & year and a digital display. ;;
;;                                                                      ;;
;;  The clock face may be enabled & disabled using the 'clock' command  ;;
;;  toggle. Upon issuing this command at the AutoCAD command-line, the  ;;
;;  user will be prompted to supply an insertion point for the clock.   ;;
;;                                                                      ;;
;;  The clock hands will then update automatically to reflect the       ;;
;;  current time after an AutoCAD command has been used.                ;;
;;                                                                      ;;
;;  The 'runclock' command will continuously update the clock display   ;;
;;  as the user moves the mouse until the user clicks or presses any    ;;
;;  key to exit. However, to enable a continuous animation, the         ;;
;;  'runclock' command will take precedence over all other actions      ;;
;;  whilst running.                                                     ;;
;;----------------------------------------------------------------------;;
;;  Author:  Lee Mac, Copyright © 2013  -  www.lee-mac.com              ;;
;;----------------------------------------------------------------------;;
;;  Version 1.1    -    15-06-2013                                      ;;
;;----------------------------------------------------------------------;;

(setq
    clock:layer  "LMAC-Clock"
    clock:second "LMAC-Second"
    clock:minute "LMAC-Minute"
    clock:hour   "LMAC-Hour"
    clock:day    "LMAC-Day"
    clock:24hr   "LMAC-24hr"
    clock:05pi   (/ pi 2.0)
)

;;----------------------------------------------------------------------;;

(defun c:clock ( / *error* ins )

    (defun *error* ( msg )
        (clock:purgeclock)
        (if (not (wcmatch (strcase msg t) "*break,*cancel*,*exit*"))
            (princ (strcat "\nError: " msg))
        )
        (princ)
    )

    (if (= 'vlr-command-reactor (type clock:reactor))
        (clock:purgeclock)
        (if (setq ins (getpoint "\nPick Point for Clock: "))
            (progn
                (vlr-set-notification
                    (setq clock:reactor
                        (vlr-command-reactor (clock:makeclock ins) '((:vlr-commandended . clock:callback)))
                    )
                    'active-document-only
                )
                (command "_.redraw")
                (princ "\nClock running.")
            )
        )
    )
    (princ)
)

;;----------------------------------------------------------------------;;

(defun c:runclock ( / *error* cmd grr )

    (defun *error* ( msg )
        (if (= 'int (type cmd))
            (setvar 'cmdecho cmd)
        )
        (if (not (wcmatch (strcase msg t) "*break,*cancel*,*exit*"))
            (princ (strcat "\nError: " msg))
        )
        (princ)
    )

    (if (= 'vlr-command-reactor (type clock:reactor))
        (progn
            (setq cmd (getvar 'cmdecho))
            (setvar 'cmdecho 0)
            (princ "\nMove mouse to run clock, press any key to exit.")
            (while
                (and
                    (not (vl-catch-all-error-p (setq grr (vl-catch-all-apply 'grread '(t 15 1)))))
                    (= 5 (car grr))
                )
                (command "_.redraw" "_.delay" 1000)
            )
            (setvar 'cmdecho cmd)
        )
        (princ "\nClock doesn't exist, type \"Clock\" to create the clock.")
    )
    (princ)
)

;;----------------------------------------------------------------------;;

(defun clock:callback ( obj arg / 24h )
    (if (not (wcmatch (strcase (car arg)) "U,UNDO"))
        (progn
            (mapcar
                (function
                    (lambda ( han rot )
                        (if (entget (handent han))
                            (vla-put-rotation (vlax-ename->vla-object (handent han)) (* rot -2 pi))
                            ;; entmod causes lock up with redraw command
                        )
                    )
                )
                (vlr-data obj)
                (list
                    (setq 24h (rem (getvar 'date) 1))
                    (* 2 24h)
                    (rem (* 24h 0024) 1)
                    (/ (fix (rem (* 24h 86400) 60)) 60.0)
                    (/ (fix (rem (getvar 'date) 7))  7.0)
                )
            )
            (mapcar
                (function
                    (lambda ( han str )
                        (if (entget (handent han))
                            (vla-put-textstring (vlax-ename->vla-object (handent han)) str)
                        )
                    )
                )
                (reverse (vlr-data obj))
                (list
                    (menucmd "m=$(edtime,$(getvar,date),DD)")
                    (menucmd "m=$(edtime,$(getvar,date),HH:MM)")
                    (menucmd "m=$(edtime,$(getvar,date),MONTH YYYY)")
                )
            )
        )
    )
    (princ)
)

;;----------------------------------------------------------------------;;

(defun clock:makeclock ( ins / ang cen han inc ocs rad )

    (if (not (tblsearch "layer" clock:layer))
        (entmake
            (list
               '(000 . "LAYER")
               '(100 . "AcDbSymbolTableRecord")
               '(100 . "AcDbLayerTableRecord")
               '(070 . 0)
                (cons 002 clock:layer)
               '(062 . 80)
               '(290 . 0)
            )
        )
    )

    (setq ocs (trans '(0.0 0.0 1.0) 1 0 t)
          ins (trans ins 1 ocs)
    )
    (clock:lwpoly
        (list
            (list 10 (+ (car ins) 0.09) (cadr ins))
           '(42 . 1.0)
            (list 10 (- (car ins) 0.09) (cadr ins))
           '(42 . 1.0)
        )
        0.18 1 ocs
    )
    (clock:circle ins 0.5 ocs)
    (setq inc 0)
    (repeat 60
        (setq ang (* inc (/ pi 30.0)))
        (clock:lwpoly
            (list
                (cons 10 (polar ins ang 10.0))
                (cons 10 (polar ins ang  9.0))
            )
            0.0 0 ocs
        )
        (if (zerop (rem inc 5))
            (clock:lwpoly
                (list
                    (cons 10 (polar ins ang 10.0))
                    (cons 10 (polar ins ang  8.4))
                )
                0.2 0 ocs
            )
        )
        (setq inc (1+ inc))
    )
    (setq ang clock:05pi)
    (repeat 2
        (setq rad 2.5)
        (repeat 2
            (clock:circle (polar ins ang 4.45) rad ocs)
            (setq rad (- 2.7 rad))
        )
        (setq ang (+ ang ang))
    )
    (setq cen (mapcar '+ ins '(0.00 4.45))
          inc 0
    )
    (foreach str '("Mon" "Sun" "Sat" "Fri" "Thu" "Wed" "Tue")
        (setq ang (+ clock:05pi (* inc pi (/ 2.0 7.0))))
        (clock:lwpoly
            (list
                (cons 10 (polar cen ang 2.5))
                (cons 10 (polar cen ang 2.0))
            )
            0.1 0 ocs
        )
        (clock:mtext (polar cen ang 1.65) str 0.3 (- ang clock:05pi) ocs)
        (setq inc (1+ inc))
    )
    (setq cen (mapcar '- ins '(4.45 0.0))
          inc 0
    )
    (repeat 24
        (setq ang (* inc (/ pi 12.0)))
        (clock:lwpoly
            (list
                (cons 10 (polar cen ang 2.50))
                (cons 10 (polar cen ang 2.15))
            )
            0.0 0 ocs
        )
        (if (zerop (rem inc 2))
            (clock:lwpoly
                (list
                    (cons 10 (polar cen ang 2.5))
                    (cons 10 (polar cen ang 2.0))
                )
                0.1 0 ocs
            )
        )
        (if (zerop (rem inc 6))
            (clock:mtext (polar cen ang 1.65) (nth (/ inc 6) '("6" "24" "18" "12")) 0.3 0.0 ocs)
        )
        (setq inc (1+ inc))
    )
    (clock:lwpoly
        (list
            (cons 10 (mapcar '+ ins '(5.0 -0.9)))
           '(42 . 0.201387)
            (cons 10 (mapcar '+ ins '(7.8 -0.9)))
           '(42 . 0.0)
            (cons 10 (mapcar '+ ins '(7.8  0.9)))
           '(42 . 0.201387)
            (cons 10 (mapcar '+ ins '(5.0  0.9)))
           '(42 . 0.0)
        )
        0.0 1 ocs
    )
    (clock:mtext (mapcar '+ ins '(5.04  2.31)) "By Lee Mac" 0.5 0.0 ocs)
    (setq han
        (mapcar (function (lambda ( ent ) (cdr (assoc 5 (entget ent)))))
            (append
                (mapcar
                    (function
                        (lambda ( blk lst wid ins )
                            (if (not (tblsearch "block" blk))
                                (progn
                                    (entmake
                                        (list
                                           '(00 . "BLOCK")
                                           '(08 . "0")
                                            (cons 02 blk)
                                           '(10 0.0 0.0 0.0)
                                           '(70 . 0)
                                        )
                                    )
                                    (clock:lwpoly lst wid 0 '(0.0 0.0 1.0))
                                    (entmake '((0 . "ENDBLK") (8 . "0")))
                                )
                            )
                            (entmakex
                                (list
                                   '(000 . "INSERT")
                                    (cons 008 clock:layer)
                                    (cons 002 blk)
                                    (cons 010 ins)
                                    (cons 210 ocs)
                                )
                            )
                        )
                    )
                    (list clock:24hr clock:hour clock:minute clock:second clock:day)
                   '(
                        ((10 0.0 0.2) (10 0.0 1.3))
                        ((10 0.0 0.5) (10 0.0 4.5))
                        ((10 0.0 0.5) (10 0.0 8.0))
                        ((10 0.0 0.5) (10 0.0 8.0))
                        ((10 0.0 0.2) (10 0.0 1.3))
                        
                    )
                   '(0.1 0.2 0.2 0.0 0.1)
                    (list
                        (mapcar '- ins '(4.45 0.00))
                        ins ins ins
                        (mapcar '+ ins '(0.00 4.45))
                    )
                )
                (mapcar
                    (function
                        (lambda ( vec fmt )
                            (clock:mtext (mapcar '+ ins vec) (menucmd (strcat "m=$(edtime,$(getvar,date)," fmt ")")) 1.0 0.0 ocs)
                        )
                    )
                   '((0.00 -4.15) (0.00 -2.50) (6.40 0.00))
                   '("MONTH YYYY" "HH:MM" "DD")
                )
            )
        )
    )
    (setq clock:fillmode (getvar 'fillmode))
    (setvar 'fillmode 1)
    (vla-zoomwindow (vlax-get-acad-object)
        (vlax-3D-point (trans (polar ins (* clock:05pi 2.5) (+ 3.0 (sqrt 200.0))) ocs 0))
        (vlax-3D-point (trans (polar ins (* clock:05pi 0.5) (+ 3.0 (sqrt 200.0))) ocs 0))
    )
    han
)

;;----------------------------------------------------------------------;;

(defun clock:purgeclock ( / blk doc inc sel )
    (setq doc (vla-get-activedocument (vlax-get-acad-object))
          blk (vla-get-blocks doc)
    )
    (if (= 'vlr-command-reactor (type clock:reactor))
        (progn
            (vlr-remove clock:reactor)
            (setq clock:reactor nil)
        )
    )
    (if (= 'int (type clock:fillmode))
        (progn
            (setvar 'fillmode clock:fillmode)
            (setq clock:fillmode nil)
        )
    )
    (if (setq sel (ssget "_X" (list (cons 8 clock:layer))))
        (repeat (setq inc (sslength sel))
            (entdel (ssname sel (setq inc (1- inc))))
        )
    )
    (foreach bln (list clock:second clock:minute clock:hour clock:day clock:24hr)
        (if (tblsearch "block" bln)
            (vl-catch-all-apply 'vla-delete (list (vla-item blk bln)))
        )
    )
    (if (tblsearch "layer" clock:layer)
        (vl-catch-all-apply 'vla-delete (list (vla-item (vla-get-layers doc) clock:layer)))
    )
    (princ)
)

;;----------------------------------------------------------------------;;

(defun clock:lwpoly ( lst wid flg ocs )
    (entmakex
        (append
            (list
               '(000 . "LWPOLYLINE")
               '(100 . "AcDbEntity")
               '(100 . "AcDbPolyline")
                (cons 008 clock:layer)
                (cons 090 (length (vl-remove-if-not '(lambda ( x ) (= 10 (car x))) lst)))
                (cons 070 flg)
                (cons 043 wid)
               '(038 . 0.0)
               '(062 . 256)
            )
            lst
            (list (cons 210 ocs))
        )
    )
)

;;----------------------------------------------------------------------;;

(defun clock:circle ( cen rad ocs )
    (entmakex
        (list
           '(0 . "CIRCLE")
            (cons 008 clock:layer)
            (cons 010 cen)
            (cons 040 rad)
           '(062 . 256)
            (cons 210 ocs)
        )
    )
)

;;----------------------------------------------------------------------;;

(defun clock:mtext ( ins str hgt rot ocs )
    (entmakex
        (list
           '(000 . "MTEXT")
           '(100 . "AcDbEntity")
           '(100 . "AcDbMText")
            (cons 008 clock:layer)
            (cons 010 (trans ins ocs 0))
            (cons 011 (trans (list (cos rot) (sin rot) 0.0) ocs 0 t))
            (cons 040 hgt)
            (cons 001 str)
           '(071 . 5)
           '(062 . 2)
            (cons 210 ocs)
        )
    )
)

;;----------------------------------------------------------------------;;

(vl-load-com)
(princ
    (strcat
        "\n:: Clock.lsp | Version 1.1 | \\U+00A9 Lee Mac "
        (menucmd "m=$(edtime,$(getvar,date),YYYY)")
        " www.lee-mac.com ::"
        "\n:: Available commands:"
        "\n::    \"clock\"     -  Toggle clock display."
        "\n::    \"runclock\"  -  Run clock continuously."
    )
)
(princ)

;;----------------------------------------------------------------------;;
;;                             End of File                              ;;
;;----------------------------------------------------------------------;;