;;-----------------------------=={  Mastermind  }==------------------------------;;
;;                                                                               ;;
;;  Based on the classic code-breaking 1970 board game, the user has 8 attempts  ;;
;;  to guess a 4 element code based on feedback from each unsuccessful attempt.  ;;
;;                                                                               ;;
;;  Instructions:-                                                               ;;
;;  ----------------                                                             ;;
;;  The first user decides a code of 4 colours from a choice of 6 colours for    ;;
;;  second user to break. The code may be set by pressing the 'Change' button    ;;
;;  at the top of the program. Duplicate colours are allowed.                    ;;
;;                                                                               ;;
;;  When the code is set, the second users begins his attempt to determine the   ;;
;;  sequence of colours. Attempts are made by pressing the buttons located       ;;
;;  beneath each of six available colours, then using the 'Check' button to      ;;
;;  receive a coded feedback depending on how close his attempt was to the       ;;
;;  correct code.                                                                ;;
;;                                                                               ;;
;;  Feedback:-                                                                   ;;
;;  ----------------                                                             ;;
;;  A Black Marker  -  A Correct Colour in the Correct Position                  ;;
;;  A White Marker  -  A Correct Colour in the Wrong Position                    ;;
;;  No Marker       -  Incorrect Colour                                          ;;
;;                                                                               ;;
;;  Note:-  The position of the Feedback Markers bears no relation to the        ;;
;;          position of the colours in the code attempt                          ;;
;;                                                                               ;;
;;  After either all attempts are made or the correct code is determined, the    ;;
;;  solution is revealed at the top of the program, and the user has a choice    ;;
;;  of either Exiting, Resetting to play again, or changing the code for another ;;
;;  game.                                                                        ;;
;;                                                                               ;;
;;-------------------------------------------------------------------------------;;
;;                                                                               ;;
;;  FUNCTION SYNTAX:  Mastermind                                                 ;;
;;                                                                               ;;
;;-------------------------------------------------------------------------------;;
;;                                                                               ;;
;;  Author: Lee Mac, Copyright © July 2010 - www.lee-mac.com                     ;;
;;                                                                               ;;
;;-------------------------------------------------------------------------------;;

(defun c:mastermind ( / *error* SavePath tmp dclfname dc i j lst )

  (defun *error* ( msg )
    (and ofile (eq 'file (type ofile)) (close ofile))
    (and dc (unload_dialog dc))
    (or (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*")
        (princ (strcat "\n** Error: " msg " **")))
    (princ)
  )

  (setq SavePath

    (cond
      
      ( (setq tmp (getvar 'ROAMABLEROOTPREFIX))

        (or (eq "\\" (substr tmp (strlen tmp)))
            (setq tmp (strcat tmp "\\")))

        (strcat tmp "Support\\")
      )
      ( (setq tmp (findfile "ACAD.pat"))

        (setq tmp (vl-filename-directory tmp))

        (or (eq "\\" (substr tmp (strlen tmp)))
            (setq tmp (strcat tmp "\\")))

        tmp
      )
      (t
        (popup "Warning" 16 "DCL Save Path not Valid")

        (exit)
      )
    )
  )

  (setq dclfname (strcat SavePath "LMAC_Mastermind.dcl"))

  (or *Win|Code* (setq *Win|Code* '(1 2 3 4)))

  (cond
    (
      (not (mm:dcl_write dclfname))

      (mm:Popup "Warning" 48 "DCL File could not be written to your Support Path.")
      (princ "\n** DCL File could not be written **")
    )        
    (
      (<= (setq dc (load_dialog dclfname)) 0)

      (mm:Popup "Warning" 48
        (strcat "Mastermind.dcl could not be Found"
                "\nPlease ensure this file resides in a Support Path."
        )
      )
      (princ "\n** Dialog File not Found **")
    )
    (
      (not (new_dialog "master" dc))

      (mm:Popup "Warning" 48 "Mastermind Dialog Definition not Found.")
      (princ "\n** Dialog Could not be Loaded **")
    )
    (t

      (
        (lambda ( c )
          (repeat 6 (mm:ColourTile (strcat "c" (itoa (setq c (1+ c)))) c))
        )
        0
      )

      (setq i 1 j 1)

      (mm:Reset)

      (action_tile "change_code" "(setq *Win|Code* (mm:NewCode dc *Win|Code*)) (mm:Reset)")

      (action_tile "clr"
        (vl-prin1-to-string
          (quote
            (progn            
              (if (and (= i 1) (< 1 j)) (setq j (1- j)))
              (setq i (mm:ClearRow j))
              (setq lst nil)
            )
          )
        )
      )

      (action_tile "reset" "(mm:Reset)")

      (action_tile "check"
        (vl-prin1-to-string
          (quote
            (progn
              (mm:CheckSolution (reverse lst) *Win|Code* (1- j))
              (setq lst nil)
            )
          )
        )
      )

      (action_tile "solve" "(mm:Reveal *Win|Code*)")

      (
        (lambda ( b )
          (while (< (setq b (1+ b)) 7)
            (action_tile
              (strcat "b" (itoa b))
              (strcat "(mm:UpdateTile " (itoa b) ") (setq lst (cons " (itoa b) " lst))")
            )
          )
        )
        0
      )

      (start_dialog)
      (setq dc (unload_dialog dc))
    )
  )
  
  (princ)
)

(defun mm:ModeTiles ( flag )
  (
    (lambda ( mode )
      (
        (lambda ( b )
          (while (< (setq b (1+ b)) 7)
            (mode_tile (strcat "b" (itoa b)) mode)
          )
        )
        0
      )
      (mode_tile "check" (- 1 mode))
    )
    (if flag 0 1)
  )
)

(defun mm:UpdateTile ( c )
  
  (mm:ColourTile (strcat "mm" (itoa j) (itoa i)) c)
  
  (cond
    ( (= i 1)
      (mode_tile "clr" 0)
      (setq i (1+ i))
    )     
    ( (< i 4)    
      (setq i (1+ i))
    )
    ( (= i 4)

      (mm:ModeTiles nil)
      (setq i 1 j (1+ j))
    )
  )
)

(defun mm:ClearRow ( r )
  (
    (lambda ( c )
      (repeat 4 (mm:ColourTile (strcat "mm" (itoa r) (itoa (setq c (1+ c)))) 255))
    )
    0
  )
  (mm:ModeTiles t)
  (mode_tile "clr" 1)
  1
)

(defun mm:Reset nil (setq i 1 j 1)
  (
    (lambda ( c )
      (repeat 4 (mm:ColourTile (strcat "v" (itoa (setq c (1+ c)))) -15))
      (mm:ModeTiles t)
      (mapcar 'mode_tile '("solve" "clr") '(0 1))
    )
    0
  )
  (
    (lambda ( i )
      (while (< (setq i (1+ i)) 9)
        (
          (lambda ( j )
            (while (< (setq j (1+ j)) 5)
              (mm:ColourTile (strcat "mm" (itoa i) (itoa j)) 255)
              (mm:ColourTile (strcat "cc" (itoa i) (itoa j)) -15)
            )
          )
          0
        )
      )
    )
    0
  )
)

(defun mm:RemoveFirst ( item lst )
  (if lst
    (if (equal (car lst) item)
      (cdr lst)
      (cons (car lst) (mm:RemoveFirst item (cdr lst)))
    )
  )
)

(defun mm:CheckSolution ( lst win r / tmp )

  (setq tmp
    (vl-remove 'nil
      (mapcar
        (function
          (lambda ( a b ) (if (/= a b) a))
        )
        win lst
      )
    )
  )

  (if (< j 9) (mm:ModeTiles t))
  (mode_tile "clr" 1)
  
  (
    (lambda ( data )
      (
        (lambda ( u )
          (mapcar
            (function
              (lambda ( c )                
                (mm:ColourTile (strcat "cc" (itoa r) (itoa (setq u (1+ u)))) c)
              )
            )
            (mapcar
              (function
                (lambda ( x ) (nth x data))
              )
              (vl-sort-i data '<)
            )
          )
        )
        0
      )
      (if (or (= j 9) (vl-every 'zerop data)) (mm:Reveal win))
    )
    (mapcar
      (function
        (lambda ( a b )
          (cond
            ( (= a b) 0 )
            ( (member a tmp) (setq tmp (mm:RemoveFirst a tmp)) 255 )
            ( -15 )
          ) 
        )
      )
      lst win
    )
  )
)

(defun mm:Reveal ( win )
  (
    (lambda ( v )
      (mapcar
        (function
          (lambda ( c )
            (mm:ColourTile (strcat "v" (itoa (setq v (1+ v)))) c)
          )
        )
        win
      )
      (mm:ModeTiles nil)
      (mapcar 'mode_tile '("check" "solve") '(1 1))
    )
    0
  )
)

(defun mm:NewCode ( handle code / n tmp )
  (cond
    (
      (not (new_dialog "change" handle))

      (mm:Popup "Warning" 48 "Change Code Dialog Definition not Found.")
      (princ "\n** Change Code Dialog Could not be Loaded **")
    )
    (t

      (setq n 1)
      (mode_tile "nclr" 1)

      (
        (lambda ( c )
          (while (< (setq c (1+ c)) 7)
            (mm:ColourTile (strcat "nco" (itoa c)) c)
          )
        )
        0
      )

      (mm:NewCodeClear)

      (action_tile "nclr"
        (vl-prin1-to-string
          (quote
            (progn
              (mm:NewCodeClear) (setq n 1) (mode_tile "nclr" 1)              
              (mm:NewCodeModeTiles t)
              (setq tmp nil)
            )
          )
        )
      )

      (
        (lambda ( p )
          (while (< (setq p (1+ p)) 7)
            (action_tile (strcat "nb" (itoa p))
              (strcat "(mm:NewCodeUpdateTile " (itoa p) ") (setq tmp (cons " (itoa p) " tmp))")
            )
          )
        )
        0
      )

      (action_tile "luck"   "(setq code (mapcar 'mm:rnd '(1 1 1 1) '(6 6 6 6))) (done_dialog)")

      (action_tile "accept" "(setq code (reverse tmp)) (done_dialog)")
     
      (start_dialog)
    )
  )
  code
)

(defun mm:NewCodeUpdateTile ( c )
  (mm:ColourTile (strcat "nc" (itoa n)) c)

  (cond
    ( (= 1 n)
      (mode_tile "nclr" 0)
      (setq n (1+ n))
    )
    ( (< n 4)
      (setq n (1+ n))
    )     
    ( (= 4 n)
      (mode_tile "accept" 0)
      (mm:NewCodeModeTiles nil)
      (setq n 1)
    )
  )
)

(defun mm:NewCodeModeTiles ( flag )
  (
    (lambda ( mode )
      (
        (lambda ( v )
          (while (< (setq v (1+ v)) 7)
            (mode_tile (strcat "nb" (itoa v)) mode)
          )
        )
        0
      )
    )
    (if flag 0 1)
  )
)

(defun mm:NewCodeClear nil
  (
    (lambda ( c )
      (while (< (setq c (1+ c)) 5)
        (mm:ColourTile (strcat "nc" (itoa c)) 255)
      )
      (mode_tile "accept" 1)
    )
    0
  )
)

(defun mm:rnd ( minN maxN / rand )

  (defun rand ( / modulus multiplier increment )
    (if (not seed) (setq seed (getvar 'DATE)))

    (setq modulus 65536 multiplier 25173 increment 13849)

    (setq seed (rem (+ (* multiplier seed) increment) modulus))

    (/ seed modulus)
  )

  (fix (+ minN (* (rand) (- (1+ maxN) minN))))
)

(defun mm:ColourTile ( key colour )
  (start_image key)
  (fill_image 0 0 (dimx_tile key) (dimy_tile key) (if (= -15 colour) -15 0))
  (fill_image 1 1 (1- (dimx_tile key)) (1- (dimy_tile key)) colour)
  (end_image)
)

(defun mm:Popup ( title flags msg / WSHShell result )    
  (setq WSHShell (vlax-create-object "WScript.Shell"))
  (setq result   (vlax-invoke WSHShell 'Popup msg 0 title flags))
  (vlax-release-object WSHShell)
  
  result
)

(defun mm:dcl_write ( fname / ofile )

  (if (not (findfile fname))
    
    (if (setq ofile (open fname "w"))
      (progn
        
        (foreach str
           
           '(
              "//-----------=={ Mastermind Dialog Definition }==-------------//"
              "//                                                            //"
              "//  Mastermind.dcl for use in conjunction with Mastermind.lsp //"
              "//------------------------------------------------------------//"
              "//  Author: Lee Mac, Copyright © 2010 - www.lee-mac.com       //"
              "//------------------------------------------------------------//"
              ""
              "//  --=={ Sub-Assembly Definitions }==--"
              ""
              "cbox : image  { height = 1.0; fixed_height = true; width = 4.7; fixed_width = true; alignment = centered; }"
              "cbut : button { height = 1.0; fixed_height = true; width = 4.0; fixed_width = true; alignment = centered; }"
              "sbox : image  { height = 0.5; fixed_height = true; width = 2.0; fixed_width = true; alignment = centered; }"
              ""
              "mbut : button { width = 15;  fixed_width = true; alignment = centered; }"
              "spc  : spacer { width = 0.1; fixed_width = true; height = 0.1; fixed_height = true; }"
              ""
              "//------------------------------------------------------------//"
              "//                    Main Dialog Definition                  //"
              "//------------------------------------------------------------//"
              ""
              "master : dialog { label = \"Mastermind by Lee Mac 2010\";"
              "  spacer;"
              "  "
              "  : boxed_column { label = \"M A S T E R M I N D\";"
              "  "
              "    : boxed_column { label = \"Solution\";"
              ""
              "      : row {"
              ""
              "        : cbox { key = \"v1\"; }"
              "        : cbox { key = \"v2\"; }"
              "        : cbox { key = \"v3\"; }"
              "        : cbox { key = \"v4\"; }"
              "        "
              "        : button { label = \"Change\"; key = \"change_code\"; width = 5; fixed_width = true; }"
              ""
              "      }"
              "      "
              "      spacer;"
              ""
              "    }"
              "    "
              "    : row {"
              ""
              "      : boxed_row { label = \"Attempt 1\";"
              ""
              "        : cbox { key = \"mm11\"; }"
              "        : cbox { key = \"mm12\"; }"
              "        : cbox { key = \"mm13\"; }"
              "        : cbox { key = \"mm14\"; }"
              "        "
              "      }"
              ""
              "      : boxed_column {"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc11\"; }"
              "          : sbox { key = \"cc12\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc13\"; }"
              "          : sbox { key = \"cc14\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        spacer;"
              ""
              "      }"
              "      "
              "    }"
              ""
              "    : row {"
              ""
              "      : boxed_row { label = \"Attempt 2\";"
              ""
              "        : cbox { key = \"mm21\"; }"
              "        : cbox { key = \"mm22\"; }"
              "        : cbox { key = \"mm23\"; }"
              "        : cbox { key = \"mm24\"; }"
              "        "
              "      }"
              ""
              "      : boxed_column {"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc21\"; }"
              "          : sbox { key = \"cc22\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc23\"; }"
              "          : sbox { key = \"cc24\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        spacer;"
              ""
              "      }"
              "      "
              "    }"
              ""
              "    : row {"
              ""
              "      : boxed_row { label = \"Attempt 3\";"
              ""
              "        : cbox { key = \"mm31\"; }"
              "        : cbox { key = \"mm32\"; }"
              "        : cbox { key = \"mm33\"; }"
              "        : cbox { key = \"mm34\"; }"
              "        "
              "      }"
              ""
              "      : boxed_column {"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc31\"; }"
              "          : sbox { key = \"cc32\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc33\"; }"
              "          : sbox { key = \"cc34\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        spacer;"
              ""
              "      }"
              "      "
              "    }"
              ""
              "    : row {"
              ""
              "      : boxed_row { label = \"Attempt 4\";"
              ""
              "        : cbox { key = \"mm41\"; }"
              "        : cbox { key = \"mm42\"; }"
              "        : cbox { key = \"mm43\"; }"
              "        : cbox { key = \"mm44\"; }"
              "        "
              "      }"
              ""
              "      : boxed_column {"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc41\"; }"
              "          : sbox { key = \"cc42\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc43\"; }"
              "          : sbox { key = \"cc44\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        spacer;"
              ""
              "      }"
              "      "
              "    }"
              ""
              "    : row {"
              ""
              "      : boxed_row { label = \"Attempt 5\";"
              ""
              "        : cbox { key = \"mm51\"; }"
              "        : cbox { key = \"mm52\"; }"
              "        : cbox { key = \"mm53\"; }"
              "        : cbox { key = \"mm54\"; }"
              "        "
              "      }"
              ""
              "      : boxed_column {"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc51\"; }"
              "          : sbox { key = \"cc52\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc53\"; }"
              "          : sbox { key = \"cc54\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        spacer;"
              ""
              "      }"
              "      "
              "    }"
              ""
              "    : row {"
              ""
              "      : boxed_row { label = \"Attempt 6\";"
              ""
              "        : cbox { key = \"mm61\"; }"
              "        : cbox { key = \"mm62\"; }"
              "        : cbox { key = \"mm63\"; }"
              "        : cbox { key = \"mm64\"; }"
              "        "
              "      }"
              ""
              "      : boxed_column {"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc61\"; }"
              "          : sbox { key = \"cc62\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc63\"; }"
              "          : sbox { key = \"cc64\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        spacer;"
              ""
              "      }"
              "      "
              "    }"
              ""
              "    : row {"
              ""
              "      : boxed_row { label = \"Attempt 7\";"
              ""
              "        : cbox { key = \"mm71\"; }"
              "        : cbox { key = \"mm72\"; }"
              "        : cbox { key = \"mm73\"; }"
              "        : cbox { key = \"mm74\"; }"
              "        "
              "      }"
              ""
              "      : boxed_column {"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc71\"; }"
              "          : sbox { key = \"cc72\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc73\"; }"
              "          : sbox { key = \"cc74\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        spacer;"
              ""
              "      }"
              "      "
              "    }"
              ""
              "    : row {"
              ""
              "      : boxed_row { label = \"Final Attempt\";"
              ""
              "        : cbox { key = \"mm81\"; }"
              "        : cbox { key = \"mm82\"; }"
              "        : cbox { key = \"mm83\"; }"
              "        : cbox { key = \"mm84\"; }"
              "        "
              "      }"
              ""
              "      : boxed_column {"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc81\"; }"
              "          : sbox { key = \"cc82\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        : row { spacer;"
              ""
              "          : sbox { key = \"cc83\"; }"
              "          : sbox { key = \"cc84\"; }"
              ""
              "          spacer;"
              ""
              "        }"
              ""
              "        spacer;"
              ""
              "      }"
              "      "
              "    }"
              ""
              "    : boxed_column { label = \"Controls\";"
              ""
              "      : row { spc;"
              ""
              "        : cbox { key = \"c1\"; }"
              "        : cbox { key = \"c2\"; }"
              "        : cbox { key = \"c3\"; }"
              "        : cbox { key = \"c4\"; }"
              "        : cbox { key = \"c5\"; }"
              "        : cbox { key = \"c6\"; }"
              ""
              "        spc;"
              "      }"
              ""
              "      : row { spc;"
              ""
              "        : cbut { key = \"b1\"; }"
              "        : cbut { key = \"b2\"; }"
              "        : cbut { key = \"b3\"; }"
              "        : cbut { key = \"b4\"; }"
              "        : cbut { key = \"b5\"; }"
              "        : cbut { key = \"b6\"; }"
              ""
              "        spc;"
              "      }"
              ""
              "      spacer;"
              ""
              "    }"
              ""
              "    : row { spacer;"
              ""
              "      : mbut { label = \"Clear Row\"; key = \"clr\"; }"
              "      : mbut { label = \"Check\";   key = \"check\"; }"
              ""
              "      spacer;"
              ""
              "    }"
              ""
              "    spacer;"
              ""
              "  }"
              ""
              "  : row {"
              ""
              "    : mbut { label = \"Give Up\"; key = \"solve\"; }"
              "    : mbut { label = \"Exit\"; key = \"accept\"; is_default = true; is_cancel = true; }"
              "    : mbut { label = \"Reset\"; key = \"reset\"; }"
              "    "
              "  }"
              ""
              "}"
              ""
              "//-------------------------------------------------------------------------------//"
              "                    //  --=={ Code Change Dialog Definition }==--  //"
              "//-------------------------------------------------------------------------------//"
              ""
              "change : dialog { label = \"Enter New Code\";"
              "  spacer;"
              ""
              "  : boxed_column { label = \"Code\";"
              ""
              "    : row {"
              ""
              "      spacer;"
              ""
              "      : cbox { key = \"nc1\"; }"
              "      : cbox { key = \"nc2\"; }"
              "      : cbox { key = \"nc3\"; }"
              "      : cbox { key = \"nc4\"; }"
              ""
              "      : button { label = \"Clear\"; key = \"nclr\"; width = 12; fixed_width = true; }"
              ""
              "    }"
              ""
              "    spacer;"
              ""
              "  }"
              ""
              "  : boxed_column {"
              ""
              "    : row { spc;"
              ""
              "      : cbox { key = \"nco1\"; }"
              "      : cbox { key = \"nco2\"; }"
              "      : cbox { key = \"nco3\"; }"
              "      : cbox { key = \"nco4\"; }"
              "      : cbox { key = \"nco5\"; }"
              "      : cbox { key = \"nco6\"; }"
              ""
              "      spc;"
              "    }"
              ""
              "    : row { spc;"
              ""
              "      : cbut { key = \"nb1\"; }"
              "      : cbut { key = \"nb2\"; }"
              "      : cbut { key = \"nb3\"; }"
              "      : cbut { key = \"nb4\"; }"
              "      : cbut { key = \"nb5\"; }"
              "      : cbut { key = \"nb6\"; }"
              ""
              "      spc;"
              "    }"
              ""
              "    spacer;"
              ""
              "  }"
              ""
              "  spacer;"
              ""
              "  : row {"
              ""
              "    : mbut { label = \"OK\";     key = \"accept\"; is_default = true; }"
              "    : mbut { label = \"Lucky Dip!\"; key = \"luck\";                  }"
              "    : mbut { label = \"Cancel\"; key = \"cancel\"; is_cancel = true;  }"
              ""
              "  }"
              ""
              "  spacer;"
              "}"
              ""
              "//-------------------------------------------------------------------------------//"
              "//                                 End of File                                   //"
              "//-------------------------------------------------------------------------------//"
             )
          
          (write-line str ofile)
        )        
        (setq ofile (close ofile))

        t
      )
      nil
    )
    t
  )
)

(vl-load-com)
(princ "\n:: MASTERMIND | © Lee Mac 2010 www.lee-mac.com ::")
(princ)

;;-------------------------------------------------------------------------------;;
;;                                 End of File                                   ;;
;;-------------------------------------------------------------------------------;;