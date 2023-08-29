;;-------------------=={ Match Attribs }==--------------------;;
;;                                                            ;;
;;  Prompts for selection of source attribute, then proceeds  ;;
;;  to match the listed properties for subsequently picked    ;;
;;  attributes.                                               ;;
;;------------------------------------------------------------;;
;;  Author: Lee Mac, Copyright © 2010 - www.lee-mac.com       ;;
;;------------------------------------------------------------;;

(defun c:MatchAttribs ( / properties source )
  (vl-load-com)
  ;; © Lee Mac 2010

;; List of Properties to Match, may be edited to suit
;;------------------------------------------------------------;;
  
  (setq properties
   '(
     Backward
     Height
     Layer
     Linetype
     LinetypeScale
     Lineweight
     ObliqueAngle
     Rotation
     ScaleFactor
     StyleName
     Thickness
     UpsideDown
    )
  )

;;------------------------------------------------------------;;

  (if (setq source
        (LM:Selectif
          (lambda ( x )
            (eq "ATTRIB" (cdr (assoc 0 (entget x))))
          )
          nentsel "\nSelect Source Attribute: "
        )
      )
    (
      (lambda ( properties values / dest )
        (while
          (setq dest
            (LM:Selectif
              (lambda ( x )
                (eq "ATTRIB" (cdr (assoc 0 (entget x))))
              )
              nentsel "\nSelect Destination Attributes: "
            )
          )
          (setq dest (vlax-ename->vla-object dest))

          (mapcar
            (function
              (lambda ( property value )
                (vlax-put-property dest property value)
              )
            )
            properties values
          )
        )
      )
      properties
      (progn (setq source (vlax-ename->vla-object source))
        (mapcar
          (function
            (lambda ( property ) (vlax-get-property source property))
          )
          properties
        )
      )
    )
  )

  (princ)
)

;;---------------------=={ Select if }==----------------------;;
;;                                                            ;;
;;  Continuous selection prompts until the predicate function ;;
;;  foo is validated                                          ;;
;;------------------------------------------------------------;;
;;  Author: Lee Mac, Copyright © 2010 - www.lee-mac.com       ;;
;;------------------------------------------------------------;;
;;  Arguments:                                                ;;
;;  foo - optional predicate function taking ename argument   ;;
;;  fun - selection function to invoke                        ;;
;;  str - prompt string                                       ;;
;;------------------------------------------------------------;;
;;  Returns:  selected entity ename if successful, else nil   ;;
;;------------------------------------------------------------;;

(defun LM:Selectif ( foo fun str / e )
  ;; © Lee Mac 2010
  (while
    (progn (setq e (car (fun str)))      
      (cond
        ( (eq 'ENAME (type e))

          (if (and foo (not (foo e)))
            (princ "\n** Invalid Object Selected **")
          )
        )
      )
    )
  )
  e
)