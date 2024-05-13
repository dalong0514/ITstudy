;;-------------------=={ Attribute Colour }==-----------------;;
;;                                                            ;;
;;  Prompts for a selection of attributed blocks and displays ;;
;;  a dialog interface enabling the user to change the colour ;;
;;  of specific attribute tags.                               ;;
;;------------------------------------------------------------;;
;;  Author: Lee Mac, Copyright © 2011 - www.lee-mac.com       ;;
;;------------------------------------------------------------;;
;;  Version 1.0    -    24-02-2011                            ;;
;;                                                            ;;
;;  First Release.                                            ;;
;;------------------------------------------------------------;;

(defun c:AttCol ( / *error* _StartUndo _EndUndo _unique _dclsel _dclimg doc l s ss ) (vl-load-com)
  ;; © Lee Mac 2011

  (or *attcolour* (setq *attcolour* 1)) ;; First time default colour

  (defun *error* ( msg )
    (if doc (_EndUndo doc))
    (or (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*")
        (princ (strcat "\n** Error: " msg " **")))
    (princ)
  )

  (defun _StartUndo ( doc ) (_EndUndo doc)
    (vla-StartUndoMark doc)
  )

  (defun _EndUndo ( doc )
    (if (= 8 (logand 8 (getvar 'UNDOCTL)))
      (vla-EndUndoMark doc)
    )
  )
  
  (defun _unique ( l ) (if l (cons (car l) (_unique (vl-remove (car l) (cdr l))))))

  (defun _dclsel ( l / file tmp dch return )
    (cond
      (
        (not
          (and (setq file (open (setq tmp (vl-filename-mktemp nil nil ".dcl")) "w"))
            (write-line
              (strcat
                "attcol : dialog { label = \"Attribute Colour\"; spacer;"
                "  : list_box { label = \"Select Tags\"; key = \"tags\"; fixed_width = false; multiple_select = true ; alignment = centered; }"
                "  : boxed_column { label = \"Colour\";"
                "    : row { spacer;"
                "      : button { key = \"but\"; width = 12; fixed_width = true; label = \"Select Colour\"; }"
                "      : image_button { key = \"img\"; alignment = centered; height = 1.5; width = 4.0;"
                "                       fixed_width = true; fixed_height = true; color = 2; }"
                "      spacer;"
                "    }"
                "    spacer;"
                "  }"
                "  spacer; ok_cancel;"
                "}"
              )
              file
            )
            (not (close file)) (< 0 (setq dch (load_dialog tmp))) (new_dialog "attcol" dch)
          )
        )
      )
      (t
        (start_list "tags") (mapcar 'add_list l) (end_list)

        (setq return (set_tile "tags" "0"))
        (_dclimg "img" *attcolour*)

        (action_tile "img"  "(_dclimg \"img\" (setq *attcolour* (cond ( (acad_colordlg *attcolour*) ) ( *attcolour* ))))")
        (action_tile "but"  "(_dclimg \"img\" (setq *attcolour* (cond ( (acad_colordlg *attcolour*) ) ( *attcolour* ))))")
        (action_tile "tags" "(setq return $value)")

        (setq return
          (if (= 1 (start_dialog))
            (mapcar '(lambda ( x ) (nth x l)) (read (strcat "(" return ")")))
          )
        )
      )
    )
  
    (if (< 0 dch) (unload_dialog dch))
    (if (setq tmp (findfile tmp)) (vl-file-delete tmp))

    return
  )
  
  (defun _dclimg ( k c )
    (start_image k) (fill_image 0 0 (dimx_tile k) (dimy_tile k) c) (end_image)
  )

  (setq doc (vla-get-ActiveDocument (vlax-get-acad-object)))

  (if
    (and (ssget "_:L" '((0 . "INSERT") (66 . 1)))
      (progn
        (vlax-for obj (setq ss (vla-get-ActiveSelectionSet doc))          
          (foreach att
            (append (vlax-invoke obj 'GetAttributes) (vlax-invoke obj 'GetConstantAttributes))
            (setq l (cons (cons (vla-get-TagString att) att) l))
          )
        )
        (vla-delete ss)
        (setq s (_dclsel (acad_strlsort (_unique (mapcar 'car l)))))
      )
    )
    (progn
      (_StartUndo doc)
      (foreach pair l (if (vl-position (car pair) s) (vla-put-color (cdr pair) *attcolour*)))
      (_EndUndo doc)
    )
    (princ "\n*Cancel*")
  )

  (princ)
)

(princ)
(princ "\n:: AttributeColour.lsp | Version 1.0 | © Lee Mac 2011 www.lee-mac.com ::")
(princ "\n:: Type \"AttCol\" to Invoke ::")
(princ)

;;------------------------------------------------------------;;
;;                         End of File                        ;;
;;------------------------------------------------------------;;