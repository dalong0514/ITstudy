;;-----------------=={ Logistic Map Study }==-----------------;;
;;                                                            ;;
;;  Visually iterates the Logistic Map:                       ;;
;;                                                            ;;
;;                 x[n+1] = rx[n](1-x[n])                     ;;
;;                                                            ;;
;;  For varying values of 0 <= r <= 4 and 0 <= x[0] <= 1      ;;
;;                                                            ;;
;;  Function maximum occurs at r/4, hence for 0 <= r <= 4,    ;;
;;  values of x in [0,1] remain in [0,1]. The function        ;;
;;  diverges for values of r outside of [0,4].                ;;
;;                                                            ;;
;;  For 0 <= r <= 1 we have a single fixed point at x=0       ;;
;;                                                            ;;
;;  For 1 <  r <= 3 we have two fixed points at               ;;
;;  x=0 (unstable, repellor) and x=r-1/r (attractor)          ;;
;;                                                            ;;
;;  As r approaches 3, convergence to the fixed point x=r-1/r ;;
;;  becomes increasingly slow, and a periodic point of period ;;
;;  2  appears when 3 < r < 1+sqrt(6) (approx. 3.45)          ;;
;;                                                            ;;
;;  From here we have a period-doubling cascade with the      ;;
;;  period doubling at a rate of approximately                ;;
;;  4.669 (the Feigenbaum Constant).                          ;;
;;                                                            ;;
;;  For r > 3.57 chaos emerges, with 'islands of stability'   ;;
;;  for various values of r at which periods of order 5,6,7   ;;
;;  emerge.                                                   ;;
;;                                                            ;;
;;  For r=4 the interval [0,1] is mapped to a set resembling  ;;
;;  a Cantor Set, with Hausdorff Dimension of about 0.538.    ;;
;;------------------------------------------------------------;;
;;  Author: Lee Mac, Copyright © 2011 - www.lee-mac.com       ;;
;;------------------------------------------------------------;;

(defun c:logistic ( / *error* _PlotFunction dch r x xi yi ) (setq r 1.0 x 0.3)

  (defun *error* ( msg )
    (if dch (unload_dialog dch))
    (or (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*")
        (princ (strcat "\n** Error: " msg " **")))
    (princ)
  )
  
  (defun _PlotFunction ( x r / f a b )
    (setq f (lambda ( x ) (* r x (- 1 x))))
    
    (start_image "f")
    (fill_image 1 1 (1- xi) (1- yi) 7)
    (vector_image 0 yi xi 0 0)

    (setq a -1)
    (repeat 200
      (vector_image (setq a (1+ a)) (setq b (- 200 (fix (* 200 (f (* 0.005 a)))))) a b 1)
    )
    (setq b 200)    
    (repeat 100
      (vector_image (setq a (fix (* 200 x))) b a (setq b (- 200 (fix (* 200 (setq x (f x)))))) 0)
      (vector_image a b (fix (* 200 x)) b 0)
    )
    (end_image)
  )

  (cond
    ( (<= (setq dch (load_dialog "logistic.dcl")) 0)

      (princ "\n** Dialog could not be found **")
    )
    ( (not (new_dialog "logistic" dch))

      (setq dch (unload_dialog dch))
      (princ "\n** Dialog could not be loaded **")
    )
    ( (setq xi (dimx_tile "f") yi (dimy_tile "f"))

      (mapcar 'set_tile '("r" "x" "re" "xe" "dctitle")
        (list (itoa (fix (* 100 r))) (itoa (fix (* 200 x))) (rtos r 2 2) (rtos x 2 2) "Logistic Map")
      )
      (_PlotFunction x r)

      (action_tile "r" "(_PlotFunction x (setq r (/ (atoi $value) 100.))) (set_tile \"re\" (rtos r 2 2))")
     
      (action_tile "x" "(_PlotFunction (setq x (/ (atoi $value) 200.)) r) (set_tile \"xe\" (rtos x 2 2))")

      (action_tile "xe"
        (strcat
          "(if (and (setq a (distof $value 2)) (<= 0 a 1))"
          "  (progn"
          "    (_PlotFunction (setq x a) r) (set_tile \"x\" (itoa (fix (* 200 x))))"
          "  )"
          "  (alert \"Value must be between 0 and 1\")"
          ")"
        )
      )
     
      (action_tile "re"
        (strcat
          "(if (and (setq a (distof $value 2)) (<= 0 a 4))"
          "  (progn"
          "    (_PlotFunction x (setq r a)) (set_tile \"r\" (itoa (fix (* 100 r))))"
          "  )"
          "  (alert \"Value must be between 0 and 4\")"
          ")"
        )
      )
     
      (start_dialog)
      (setq dch (unload_dialog dch))
    )
  )

  (princ)
)

(princ)

;;------------------------------------------------------------;;
;;                         End of File                        ;;
;;------------------------------------------------------------;;