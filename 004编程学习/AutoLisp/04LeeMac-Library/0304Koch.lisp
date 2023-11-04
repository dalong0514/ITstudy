;;------------------------=={ Koch Snowflake  }==-----------------------;;
;;                                                                      ;;
;;  The Koch Snowflake, devised by Swedish mathematician Helge von Koch ;;
;;  in 1904, is one of the earliest and perhaps most familiar fractal   ;;
;;  curves. It is created by arranging three individual Koch Curves to  ;;
;;  form an equilateral triangle.                                       ;;
;;                                                                      ;;
;;  The Koch Curve itself is created by first dividing a straight line  ;;
;;  into three equal segments and then constructing an equilateral      ;;
;;  triangle whose base is the middle segment of the line, before       ;;
;;  finally removing the base of the triangle:                          ;;
;;                                                                      ;;
;;          1.  ____________________                                    ;;
;;                                                                      ;;
;;          2.  ______|______|______                                    ;;
;;                                                                      ;;
;;          3.           /\                                             ;;
;;                      /  \                                            ;;
;;                     /    \                                           ;;
;;              ______/______\______                                    ;;
;;                                                                      ;;
;;          4.           /\                                             ;;
;;                      /  \                                            ;;
;;                     /    \                                           ;;
;;              ______/      \______                                    ;;
;;                                                                      ;;
;;  This procedure is then repeated on each of the four resulting line  ;;
;;  segments - the infinite limit of this process is the Koch Curve.    ;;
;;                                                                      ;;
;;  As a consequence of its fractal nature, the Koch Snowflake has some ;;
;;  very intriguing & surprising geometrical properties.                ;;
;;                                                                      ;;
;;  If the initial equilateral triangle has side length 's', then the   ;;
;;  initial area enclosed by the Koch Snowflake at the 0th iteration    ;;
;;  is:                                                                 ;;
;;        A[0]  =  s/2·s·cos(pi/6)  =  (s^2·sqrt(3))/4                  ;;
;;                                                                      ;;
;;  The perimeter of the Koch Snowflake at the 0th iteration is hence:  ;;
;;                                                                      ;;
;;        P[0]  =  3·s                                                  ;;
;;                                                                      ;;
;;  Three new triangles are added at the first iteration, and, for      ;;
;;  every iteration after, 4 times as many triangles are added to the   ;;
;;  Snowflake, and so at the nth stage there are 3·4^(n-1) triangles.   ;;
;;                                                                      ;;
;;  With every iteration, the side length of each triangle is a third   ;;
;;  the length of the previous side, meaning that the area of the       ;;
;;  triangles reduces by a factor of 9 at each iteration.               ;;
;;                                                                      ;;
;;  Therefore, at the nth stage, the Koch Snowflake has an Area of:     ;;
;;                                                                      ;;
;;        A[n]  =  A[n-1] + (3·4^(n-1)/9^n)·A[0]    (n >= 2)            ;;
;;        A[1]  =  4/3·A[0]                                             ;;
;;        A[0]  =  (s^2·sqrt(3))/4                                      ;;
;;                                                                      ;;
;;  In the limit as n goes to infinity, this iteration formula          ;;
;;  converges to:                                                       ;;
;;                                                                      ;;
;;        A[n]  =  8/5·A[0]  =  2/5·s^2·sqrt(3)                         ;;
;;                                                                      ;;
;;  ...which is clearly finite.                                         ;;
;;                                                                      ;;
;;  However, with every iteration there are four times as many line     ;;
;;  segments, with each line segment a third as long as the previous    ;;
;;  iteration.                                                          ;;
;;                                                                      ;;
;;  Hence, at the nth stage, the perimeter is:                          ;;
;;                                                                      ;;
;;        P[n]  =  (4/3)^n·P[0]  =  3·(4/3)^n·s                         ;;
;;                                                                      ;;
;;  Since 4/3 > 1, this goes to infinity as n goes to infinity.         ;;
;;                                                                      ;;
;;  Therefore, we have the surprising conclusion that the Koch          ;;
;;  Snowflake is an infinitely long curve bounding a finite area.       ;;
;;                                                                      ;;
;;----------------------------------------------------------------------;;
;;  Author:  Lee Mac, Copyright © 2012  -  www.lee-mac.com              ;;
;;----------------------------------------------------------------------;;
;;  Version 1.0    -    24-12-2012                                      ;;
;;                                                                      ;;
;;  First release.                                                      ;;
;;----------------------------------------------------------------------;;

(defun c:koch ( / 3p a0 an d1 en l1 l2 no p1 p2 p3 p4 r1 r2 )
    (setq p1 (cond ((getpoint "\nSpecify Center <0,0,0>: ")) ('(0.0 0.0 0.0)))
          r1 (cond ((getdist p1 "\nSpecify Radius <1.0>: ")) (1.0))
          l1 (list
                 (cons 10 (polar p1 (/ (*  3.0 pi) 6.0) r1))
                 (cons 10 (polar p1 (/ (*  7.0 pi) 6.0) r1))
                 (cons 10 (polar p1 (/ (* 11.0 pi) 6.0) r1))
             )
          en (koch:poly l1)
          r2 (* r1 (sqrt 3.0))
          3p (/ pi 3.0)
          a0 (/ (* r2 r2 (sqrt 3.0)) 4.0)
          no 0
    )
    (while
        (progn
            (princ
                (strcat
                    "\nIteration: " (itoa no)
                    "\tVertices: "  (itoa (* 3 (expt 4 no)))
                    "\tLength: "    (rtos (* 3 (expt (/ 4.0 3.0) no) r2) 2)
                    "\tArea: "
                    (cond
                        (   (= 0 no)
                            (rtos a0 2)
                        )
                        (   (= 1 no)
                            (rtos (setq an (/ (* 4.0 a0) 3.0)) 2)
                        )
                        (   (rtos (setq an (+ an (/ (* 3 a0 (expt 4 (1- no))) (expt 9 no)))) 2))
                    )
                )
            )
            (initget "Yes No")
            (/= "No" (getkword "\nContinue? [Yes/No] <Yes>: "))
        )
        (setq l1 (cons (last l1) l1))
        (while
            (setq p1 (cdar l1)
                  l1 (cdr  l1)
                  p2 (cdar l1)
            )
            (setq a1 (angle p1 p2)
                  d1 (/ (distance p1 p2) 3.0)
                  p3 (polar p1 a1 d1)
                  p4 (cons 10 (polar p2 a1 (- d1)))
                  l2 (vl-list* (cons 10 p2) p4 (cons 10 (polar p3 (- a1 3p) d1)) (cons 10 p3) l2)
            )
        )
        (entdel en)
        (setq l1 (reverse l2)
              l2 nil
              en (koch:poly l1)
              no (1+ no)
        )
    )
    (princ)
)

(defun koch:poly ( l )
    (entmakex
        (append
            (list
               '(000 . "LWPOLYLINE")
               '(100 . "AcDbEntity")
               '(100 . "AcDbPolyline")
                (cons 90 (length l))
               '(70 . 1)
            )
            l
        )
    )
)

;;----------------------------------------------------------------------;;

(princ
    (strcat
        "\n:: Koch.lsp | Version 1.0 | © Lee Mac "
        (menucmd "m=$(edtime,$(getvar,DATE),YYYY)")
        " www.lee-mac.com ::"
        "\n:: Type \"koch\" to Invoke ::"
    )
)
(princ)

;;----------------------------------------------------------------------;;
;;                             End of File                              ;;
;;----------------------------------------------------------------------;;