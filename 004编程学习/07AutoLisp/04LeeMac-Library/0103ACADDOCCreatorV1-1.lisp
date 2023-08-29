;;-----------------=={ ACADDOC.lsp Creator }==----------------;;
;;                                                            ;;
;;  Creates, or appends to, an ACADDOC.lsp file containing    ;;
;;  a series of load statements for all program files         ;;
;;  (lsp/vlx/fas) found in a selected directory.              ;;
;;------------------------------------------------------------;;
;;  Author: Lee Mac, Copyright © 2011 - www.lee-mac.com       ;;
;;------------------------------------------------------------;;
;;  Version 1.1    -    25-05-2011                            ;;
;;------------------------------------------------------------;;

(defun c:acaddoc ( / f p d l )
  (if
    (and
      (or (setq f (findfile "ACADDOC.lsp"))
        (and (setq p (LM:GetSavePath)) (setq f (strcat p "\\ACADDOC.lsp")))
      )
      (setq d (LM:DirectoryDialog "\nSelect Program File Directory" nil 512))
      (setq l
        (apply 'append
          (mapcar '(lambda ( typ ) (LM:GetAllFiles d nil typ)) '("*.vlx" "*.fas" "*.lsp"))
        )
      )
      (setq f (open f "a"))
    )
    (progn
      (foreach x l
        (write-line
          (strcat "(load "
            (vl-prin1-to-string x) " \"--> Failed to Load: " (vl-filename-base x) "\")"
          )
          f
        )
      )
      (close f)
      (princ (strcat "\n<<-- Written " (itoa (length l)) " Files to Load in ACADDOC.lsp -->>"))
    )
    (princ "\n*Cancel*")
  )
  (princ)
)

;;-------------------=={ Directory Dialog }==-----------------;;
;;                                                            ;;
;;  Displays a dialog prompting the user to select a folder   ;;
;;------------------------------------------------------------;;
;;  Author: Lee Mac, Copyright © 2011 - www.lee-mac.com       ;;
;;------------------------------------------------------------;;
;;  Arguments:                                                ;;
;;  msg  - message to display at top of dialog                ;;
;;  dir  - root directory (or nil)                            ;;
;;  flag - bit coded flag specifying dialog display settings  ;;
;;------------------------------------------------------------;;
;;  Returns:  Selected folder filepath, else nil              ;;
;;------------------------------------------------------------;;

(defun LM:DirectoryDialog ( msg dir flag / Shell Fold Self Path )
  (vl-catch-all-apply
    (function
      (lambda ( / ac HWND )
        (if
          (setq Shell (vla-getInterfaceObject (setq ac (vlax-get-acad-object)) "Shell.Application")
                HWND  (vl-catch-all-apply 'vla-get-HWND (list ac))
                Fold  (vlax-invoke-method Shell 'BrowseForFolder (if (vl-catch-all-error-p HWND) 0 HWND) msg flag dir)
          )
          (setq Self (vlax-get-property Fold 'Self)
                Path (vlax-get-property Self 'Path)
                Path (vl-string-right-trim "\\" (vl-string-translate "/" "\\" Path))
          )
        )
      )
    )
  )
  (if Self  (vlax-release-object  Self))
  (if Fold  (vlax-release-object  Fold))
  (if Shell (vlax-release-object Shell))
  Path
)

;;--------------------=={ Get All Files }==-------------------;;
;;                                                            ;;
;;  Retrieves all files or those of a specified filetype that ;;
;;  reside in a directory (and, optionally, subdirectories)   ;;
;;------------------------------------------------------------;;
;;  Author: Lee Mac, Copyright © 2011 - www.lee-mac.com       ;;
;;------------------------------------------------------------;;
;;  Arguments:                                                ;;
;;  Dir      - Directory to search                            ;;
;;  Subs     - Boolean, if T, subdirectories are included     ;;
;;  Filetype - (optional) Filter for filetype (DOS pattern)   ;;
;;------------------------------------------------------------;;
;;  Returns:  List of filenames, else nil if none are found   ;;
;;------------------------------------------------------------;;

(defun LM:GetAllFiles ( Dir Subs Filetype / _GetSubFolders )
  
  (defun _GetSubFolders ( folder )
    (apply 'append
      (mapcar
        (function
          (lambda ( f ) 
            (cons (setq f (strcat folder "\\" f)) (_GetSubFolders f))
          )
        )
        (vl-remove "." (vl-remove ".." (vl-directory-files folder nil -1)))
      )
    )
  )

  (apply 'append
    (mapcar
      (function
        (lambda ( Filepath )
          (mapcar
            (function
              (lambda ( Filename ) (strcat Filepath "\\" Filename))
            )
            (vl-directory-files Filepath Filetype 1)
          )
        )
      )
      (cons Dir (if subs (_GetSubFolders Dir)))
    )
  )
)

;;--------------------=={ Get Save Path }==-------------------;;
;;                                                            ;;
;;  Returns a save path in an AutoCAD Support Directory       ;;
;;------------------------------------------------------------;;
;;  Author: Lee Mac, Copyright © 2010 - www.lee-mac.com       ;;
;;------------------------------------------------------------;;
;;  Arguments: -None-                                         ;;
;;------------------------------------------------------------;;
;;  Returns: Save path in AutoCAD Support Directory, else nil ;;
;;------------------------------------------------------------;;

(defun LM:GetSavePath ( / path )
  (if
    (vl-file-directory-p
      (setq path
        (vl-string-right-trim "\\"
          (vl-string-translate "/" "\\"
            (substr (getenv "ACAD") 1 (vl-string-position 59 (getenv "ACAD")))
          )
        )
      )
    )
    path
  )
)

(princ) (vl-load-com) (princ)

