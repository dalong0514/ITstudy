;;----------------------=={ Sierpinski Triangle }==---------------------;;
;;                                                                      ;;
;;  This program allows the user to construct a 2D Sierpinski Triangle  ;;
;;  or 3D Sierpinski Tetrahedron (triangular-based Pyramid) in the      ;;
;;  active drawing, and watch the fractal develop as they step through  ;;
;;  each recursive iteration.                                           ;;
;;                                                                      ;;
;;  Upon calling the 'sierpinski' command at the AutoCAD command-line,  ;;
;;  the program prompts the user to specify three distinct              ;;
;;  non-collinear points defining an arbitrary triangle. At this prompt ;;
;;  the user may alternatively select the 'Center' option in order to   ;;
;;  generate the fractal from an equilateral triangle defined by a      ;;
;;  center & radius.                                                    ;;
;;                                                                      ;;
;;  The user may then press 'ENTER' or 'SPACE' to step through each     ;;
;;  iteration, with the program reporting the number of objects         ;;
;;  to be created by the program at each step, and an estimated time    ;;
;;  to complete the iteration, based on an extrapolation of the time    ;;
;;  taken to generate the previous iteration.                           ;;
;;                                                                      ;;
;;  The user may also construct a 3D variant using the 'sierpinski3D'   ;;
;;  command. Upon issuing this command at the AutoCAD command-line,     ;;
;;  the program prompts the user to specify four distinct,              ;;
;;  non-collinear & non-coplanar points defining an arbitrary           ;;
;;  tetrahedron, or alternatively, the user may select the 'Center'     ;;
;;  option in order to generate a regular tetrahedron with a given      ;;
;;  center & radius.                                                    ;;
;;                                                                      ;;
;;  The user may then step through each iteration of the construction   ;;
;;  in the same manner as the 2D command, with the program again        ;;
;;  reporting the number of objects to be created at each iteration,    ;;
;;  and an estimated time for the construction.                         ;;
;;                                                                      ;;
;;  The resulting Sierpinski Tetrahedron is constructed from 3D Faces.  ;;
;;----------------------------------------------------------------------;;
;;  Author:  Lee Mac, Copyright © 2016  -  www.lee-mac.com              ;;
;;----------------------------------------------------------------------;;
;;  Version 1.0    -    2016-03-08                                      ;;
;;                                                                      ;;
;;  - First release.                                                    ;;
;;----------------------------------------------------------------------;;

(defun c:sierpinski ( / itr lst pts tmp )
    (if (setq pts (sierpinski:getnpoints 3))
        (progn
            (setq tmp (getvar 'millisecs)
                  lst (apply 'sierpinski:2D (cons 1 pts))
                  tmp (- (getvar 'millisecs) tmp)
                  itr 2
            )
            (while
                (progn (initget "Yes No")
                    (/= "No"
                        (getkword
                            (strcat
                                "\nThe next iteration will generate "
                                (rtos (expt 3.0 itr) 2 0)
                                " objects in approx. "
                                (rtos (* tmp 0.006) 2 3)
                                " seconds.\nProceed? [Yes/No] <Yes>: "
                            )
                        )
                    )
                )
                (setq tmp (getvar 'millisecs))
                (foreach ent lst (entdel ent))
                (setq lst (apply 'sierpinski:2D (cons itr pts))
                      tmp (- (getvar 'millisecs) tmp)
                      itr (1+ itr)
                )
            )
        )
    )
    (princ)
)

(defun c:sierpinski3D ( / itr lst pts tmp )
    (if (setq pts (sierpinski:getnpoints 4))
        (progn
            (setq tmp (getvar 'millisecs)
                  lst (apply 'sierpinski:3D (cons 1 pts))
                  tmp (- (getvar 'millisecs) tmp)
                  itr 2
            )
            (while
                (progn (initget "Yes No")
                    (/= "No"
                        (getkword
                            (strcat
                                "\nThe next iteration will generate "
                                (rtos (expt 4.0 (1+ itr)) 2 0)
                                " objects in approx. "
                                (rtos (* tmp 0.006) 2 3)
                                " seconds.\nProceed? [Yes/No] <Yes>: "
                            )
                        )
                    )
                )
                (setq tmp (getvar 'millisecs))
                (foreach ent lst (entdel ent))
                (setq lst (apply 'sierpinski:3D (cons itr pts))
                      tmp (- (getvar 'millisecs) tmp)
                      itr (1+ itr)
                )
            )
        )
	)
    (princ)
)

(defun sierpinski:getnpoints ( num / flg len pt1 rad rtn tmp )
    (while
        (progn
            (initget (if flg "Points Exit" "Center Exit"))
            (setq pt1 (getpoint (if flg "\nSpecify center point [Points/Exit]: " "\nSpecify first point [Center/Exit]: ")))
            (cond
                (   (or (not pt1) (= "Exit" pt1))
                    (setq rtn nil)
                )
                (   (= "Center" pt1)
                    (setq flg t)
                )
                (   (= "Points" pt1)
                    (setq flg nil) t
                )
                (   (and flg (listp pt1))
                    (initget 6)
                    (not
                        (and
                            (setq rad (getdist pt1 "\nSpecify radius <back>: "))
                            (setq rtn
                                (if (= num 3)
                                    (sierpinski:get3points pt1 rad 0.0)
                                    (cons
                                        (trans (list (car pt1) (cadr pt1) (+ (caddr pt1) rad)) 1 0)
                                        (sierpinski:get3points pt1 (* rad (/ (sqrt 3.0) 2.0)) (- (caddr pt1) (/ rad 2.0)))
                                    )
                                )
                            )
                        )
                    )
                )
                (   (setq rtn (list pt1))
                    (while
                        (and (< (setq len (length rtn)) num) (setq tmp (getpoint pt1 "\nSpecify next point <back>: "))
                            (cond
                                (   (and (= 1 len) (equal tmp (car rtn) 1e-8))
                                    (princ "\nPoints must be distinct.")
                                )
                                (   (and (= 2 len) (apply 'sierpinski:collinear-p (cons tmp rtn)))
                                    (princ "\nPoints cannot be collinear.")
                                )
                                (   (and (= 3 len) (apply 'sierpinski:coplanar-p  (cons tmp rtn)))
                                    (princ "\nPoints cannot be coplanar.")
                                )
                                (   (setq rtn (cons tmp rtn)))
                            )
                        )
                    )
                    (setq rtn (mapcar '(lambda ( x ) (trans x 1 0)) rtn))
                    (< len num)
                )
            )
        )
    )
    rtn
)

(defun sierpinski:get3points ( cen rad elv )
    (mapcar
       '(lambda ( a / p )
            (   (lambda ( p ) (trans (list (car p) (cadr p) elv) 1 0))
                (polar cen (/ (* a pi) 6.0) rad)
            )
        )
       '(3.0 7.0 11.0)
    )
)

(defun sierpinski:collinear-p ( p1 p2 p3 )
    (   (lambda ( a b c )
            (or
                (equal (+ a b) c 1e-8)
                (equal (+ b c) a 1e-8)
                (equal (+ c a) b 1e-8)
            )
        )
        (distance p1 p2) (distance p2 p3) (distance p1 p3)
    )
)

(defun sierpinski:coplanar-p ( p1 p2 p3 p4 )
    (   (lambda ( n )
            (equal
                (last (trans p3 0 n))
                (last (trans p4 0 n))
                1e-8
            )
        )
        (sierpinski:v^v (mapcar '- p1 p2) (mapcar '- p1 p3))
    )
)

(defun sierpinski:v^v ( u v )
    (list
        (- (* (cadr u) (caddr v)) (* (cadr v) (caddr u)))
        (- (* (car  v) (caddr u)) (* (car  u) (caddr v)))
        (- (* (car  u) (cadr  v)) (* (car  v) (cadr  u)))
    )
)

(defun sierpinski:2D ( itr pt1 pt2 pt3 )
    (if (< itr 1)
        (list (sierpinski:solid pt1 pt2 pt3))
        (   (lambda ( md1 md2 md3)
                (apply 'append
                    (mapcar '(lambda ( a b c ) (sierpinski:2D (1- itr) a b c))
                        (list pt1 md1 md2)
                        (list md1 pt2 md3)
                        (list md2 md3 pt3)
                    )
                )
                
            )
            (sierpinski:mid pt1 pt2)
            (sierpinski:mid pt1 pt3)
            (sierpinski:mid pt2 pt3)
        )
    )
)

(defun sierpinski:3D ( itr pt1 pt2 pt3 pt4 )
    (if (< itr 1)
        (mapcar 'sierpinski:3dface
            (list pt1 pt1 pt1 pt2)
            (list pt2 pt3 pt2 pt3)
            (list pt3 pt4 pt4 pt4)
        )
        (   (lambda ( md1 md2 md3 md4 md5 md6 )
                (apply 'append
                    (mapcar '(lambda ( a b c d ) (sierpinski:3D (1- itr) a b c d))
                        (list pt1 md1 md2 md3)
                        (list md1 pt2 md4 md5)
                        (list md2 md4 pt3 md6)
                        (list md3 md5 md6 pt4)
                    )
                )
            )
            (sierpinski:mid pt1 pt2)
            (sierpinski:mid pt1 pt3)
            (sierpinski:mid pt1 pt4)
            (sierpinski:mid pt2 pt3)
            (sierpinski:mid pt2 pt4)
            (sierpinski:mid pt3 pt4)
        )
    )
)

(defun sierpinski:mid ( a b )
    (mapcar '(lambda ( a b ) (/ (+ a b) 2.0)) a b)
)

(defun sierpinski:3dface ( a b c )
    (entmakex (cons '(0 . "3DFACE") (mapcar 'cons '(10 11 12 13) (list a b c c))))
)

(defun sierpinski:solid ( a b c )
    (entmakex (cons '(0 . "SOLID")  (mapcar 'cons '(10 11 12 13) (list a b c c))))
)

;;----------------------------------------------------------------------;;

(princ
    (strcat
        "\n:: Sierpinski.lsp | Version 1.0 | \\U+00A9 Lee Mac "
        (menucmd "m=$(edtime,0,yyyy)")
        " www.lee-mac.com ::"
        "\n:: \"sierpinski\" - 2D Triangle | \"sierpinski3d\" - 3D Tetrahedron ::"
    )
)
(princ)

;;----------------------------------------------------------------------;;
;;                             End of File                              ;;
;;----------------------------------------------------------------------;;