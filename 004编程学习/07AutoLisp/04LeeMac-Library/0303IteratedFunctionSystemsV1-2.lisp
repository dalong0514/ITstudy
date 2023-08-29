;;--------------=={ Iterated Function System }==--------------;;
;;                                                            ;;
;;  Recursively calculates point positions using a set of two ;;
;;  or three affine linear transformations as specified in    ;;
;;  the user interface; each with equal probability.          ;;
;;                                                            ;;
;;  Points are subsequently plotted in the specified colour   ;;
;;  to create a fractal image.                                ;;
;;------------------------------------------------------------;;
;;  Author: Lee Mac, Copyright © 2011 - www.lee-mac.com       ;;
;;------------------------------------------------------------;;

(defun c:ifs

    (
        /
        *error*
        _writedcl
        _imgtile
        _point
        _rand

        app col dcl file fun id lst no pt
    )

    (defun *error* ( msg )
        (if (and file (eq 'FILE (type file))) (close file))
        (if (< 0 id) (unload_dialog id))
        (if (and dcl (findfile dcl)) (vl-file-delete dcl))
        (if (not (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*"))
            (princ (strcat "\nError: " msg))
        )
        (princ)
    )

    (defun _writedcl ( / tmp file )
        (if (setq file (open (setq tmp (vl-filename-mktemp nil nil ".dcl")) "w"))
            (progn
                (foreach line
                   '(
                        "pop : popup_list   { alignment = centered; }"
                        "col : boxed_column { alignment = centered; fixed_width = true; width = 60; }"
                        "txt : text         { alignment = right; }"
                        "ed3 : edit_box     { alignment = centered; edit_width = 3; }"
                        "spc : spacer       { fixed_height = true; height = 0.1; }"
                        ""
                        "ifs : dialog { label = \"Iterated Function Systems\"; spacer;"
                        "    : text { label = \"Copyright (c) 2010 Lee Mac\"; alignment = right; }"
                        "    : col  { label = \"Rule 1\"; spacer;"
                        "        : row {"
                        "            : column { spc; : txt { label = \"Rotation:\"; } spc; }"
                        "            : pop { key = \"r1\"; }"
                        "            spacer_1;"
                        "            : column { spc; : txt { label = \"Translation:\"; } spc; }"
                        "            : column { spc; : txt { label = \"x:\"; } spc; }"
                        "            : ed3 { key = \"tx1\"; }"
                        "            : column { spc; : txt { label = \"y:\"; } spc; }"
                        "            : ed3 { key = \"ty1\"; }"
                        "        }"
                        "        spacer;"
                        "    }"
                        "    : col  { label = \"Rule 2\"; spacer;"
                        "        : row {"
                        "            : column { spc; : txt { label = \"Rotation:\"; } spc; }"
                        "            : pop { key = \"r2\"; }"
                        "            spacer_1;"
                        "            : column { spc; : txt { label = \"Translation:\"; } spc; }"
                        "            : column { spc; : txt { label = \"x:\"; } spc; }"
                        "            : ed3 { key = \"tx2\"; }"
                        "            : column { spc; : txt { label = \"y:\"; } spc; }"
                        "            : ed3 { key = \"ty2\"; }"
                        "        }"
                        "        spacer;"
                        "    }"
                        "    : col  { label = \"Rule 3\"; spacer;"
                        "        : row {"
                        "            : column { spc; : txt { label = \"Rotation:\"; } spc; }"
                        "            : pop { key = \"r3\"; }"
                        "            spacer_1;"
                        "            : column { spc; : txt { label = \"Translation:\"; } spc; }"
                        "            : column { spc; : txt { label = \"x:\"; } spc; }"
                        "            : ed3 { key = \"tx3\"; }"
                        "            : column { spc; : txt { label = \"y:\"; } spc; }"
                        "            : ed3 { key = \"ty3\"; }"
                        "        }"
                        "        spacer;"
                        "    }"
                        "    : col { label =  \"Options\";"
                        "        : row { spacer;"
                        "            : radio_row {"
                        "                : radio_button { label = \"2 Rules\"; key = \"2r\"; }"
                        "                : radio_button { label = \"3 Rules\"; key = \"3r\"; }"
                        "            }"
                        "            spacer;"
                        "            : column { spc; : txt { label = \"Colour:\"; } spc; }"
                        "            : image_button"
                        "            { alignment = centered; height = 1.5; width = 4.0; key = \"icol\";"
                        "              fixed_width = true; fixed_height = true; color = 2;"
                        "            }"
                        "            : button { key = \"col\"; label = \"Select\"; fixed_width = true; width = 12; }"
                        "            spacer;"
                        "        }"
                        "        spacer;"
                        "    }"
                        "    spacer; ok_cancel;"
                        "}"
                    )
                    (write-line line file)
                )
                (setq file (close file))
                (while (null (findfile tmp)))
                tmp
            )
        )
    )

    (defun _imgtile ( key color )
        (start_image key)
        (fill_image 0 0 (dimx_tile key) (dimy_tile key) color)
        (end_image)
    )  

    (defun _point ( x c )
        (entmake (list '(0 . "POINT") (cons 10 x) (cons 62 c)))
    )
    
    (defun _rand ( / m )
        (/
            (setq
                m 4294967296.0
                s (rem (1+ (* 1664525.0 (cond (s) ((getvar 'DATE))))) m)
            )
            m
        )
    ) 

    (setq lst
       '(
            (0 (( 0.5  0.0) ( 0.0  0.5)))
            (1 (( 0.5 -0.5) ( 0.5  0.5)))
            (2 (( 0.0 -0.5) ( 0.5  0.0)))
            (3 ((-0.5 -0.5) ( 0.5 -0.5)))
            (4 ((-0.5  0.0) ( 0.0 -0.5)))
            (5 ((-0.5  0.5) (-0.5 -0.5)))
            (6 (( 0.0  0.5) (-0.5  0.0)))
            (7 (( 0.5  0.5) (-0.5  0.5)))
        )
    )
    (cond
        (   (null (setq dcl (_writedcl)))
            (princ "\nError Writing DCL File.")
        )
        (   (<= (setq id (load_dialog dcl)) 0)
            (princ "\nDCL Definition File not Found.")
        )
        (   (null (new_dialog "ifs" id))
            (princ "\nDialog Could not be Loaded.")
        )
        (   t
            (set_tile "3r" "1")
            (setq no 3)
            (_imgtile "icol" (setq col 3))
         
            (foreach tile '("r1" "r2" "r3")
                (start_list tile)
                (foreach x '("0º" "45º" "90º" "135º" "180º" "225º" "270º" "315º") (add_list x))
                (end_list)
            )
            (foreach tile '("tx1" "tx2" "tx3" "ty1" "ty2" "ty3")
                (set_tile tile (set (read tile) "0.0"))
            )
            (foreach tile '("r1" "r2" "r3")
                (set_tile tile (set (read tile) "0"))
            )
            (foreach tile '("tx1" "tx2" "tx3" "ty1" "ty2" "ty3" "r1" "r2" "r3")
                (action_tile tile (strcat "(setq " tile " $value)"))
            )
            (action_tile "2r" "(setq no 2) (foreach tile '(\"r3\" \"tx3\" \"ty3\") (mode_tile tile 1))")
            (action_tile "3r" "(setq no 3) (foreach tile '(\"r3\" \"tx3\" \"ty3\") (mode_tile tile 0))")
            (action_tile "icol" "(_imgtile \"icol\" (setq col (cond ((acad_colordlg col nil)) (col))))")
            (action_tile "col"  "(_imgtile \"icol\" (setq col (cond ((acad_colordlg col nil)) (col))))")

            (action_tile "accept"
                (vl-prin1-to-string
                    (quote
                        (progn
                            (foreach sym '(tx1 tx2 tx3 ty1 ty2 ty3)
                                (if (eq "" (eval sym)) (set sym "0.0"))
                            )
                            (cond
                                (   (null (vl-every 'distof (list tx1 tx2 tx3 ty1 ty2 ty3)))
                                    (alert "Translation Vectors Must be Numerical!")
                                )
                                (   t
                                    (mapcar
                                       '(lambda ( a b c ) (set a (list (distof b) (distof c))))
                                       '(v1 v2 v3)
                                        (list tx1 tx2 tx3)
                                        (list ty1 ty2 ty3)
                                    )
                                    (done_dialog 1)
                                )
                            )
                        )
                    )
                )
            )

            (if (= 1 (start_dialog))
                (progn
                    (setvar 'pdmode 0)
                    (foreach x '(r1 r2 r3)
                        (set x (cadr (assoc (atoi (eval x)) lst)))
                    )
                    (setq pt '(0.0 0.0))
                    (setq app (vlax-get-acad-object))

                    (setq fun
                        (eval
                            (list 'lambda '( / p )
                                (list 'repeat 1000
                                    (list 'setq 'pt
                                        (if (= 3 no)
                                           '(cond
                                                (   (< (setq p (_rand)) 0.333)
                                                    (mapcar '+ (mxv r1 pt) v1)
                                                )
                                                (   (<= 0.333 p 0.666)
                                                    (mapcar '+ (mxv r2 pt) v2)
                                                )
                                                (   t
                                                    (mapcar '+ (mxv r3 pt) v3)
                                                )
                                            )
                                           '(cond
                                                (   (< (setq p (_rand)) 0.5)
                                                    (mapcar '+ (mxv r1 pt) v1)
                                                )
                                                (   t
                                                    (mapcar '+ (mxv r2 pt) v2)
                                                )
                                            )
                                        )
                                    )
                                   '(_point pt col)
                                )
                            )
                        )
                    )
                    
                    (while
                        (progn
                            (initget "Yes No")
                            (not (eq "No" (getkword "\nIterate System? [Yes/No] <Yes> : ")))
                        )
                        (fun)
                        (vla-zoomextents app)
                    )
                )
                (princ "\n*Cancel*")
            )
        )
    )
    (if (< 0 id) (unload_dialog id))
    (if (and dcl (findfile dcl)) (vl-file-delete dcl))
    (princ)
)

;; Matrix x Vector  -  Vladimir Nesterovsky
;; Args: m - nxn matrix, v - vector in R^n

(defun mxv ( m v )
    (mapcar '(lambda ( r ) (apply '+ (mapcar '* r v))) m)
)
(vl-load-com) (princ)