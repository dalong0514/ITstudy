;;-------------------------=={  Batch Find & Replace  }==------------------------;;
;;                                                                               ;;
;;  Will Find and Replace multiple strings entered by the user within Text,      ;;
;;  MText, Block Attributes, MLeader Text, Table Text and Dimensions within the  ;;
;;  current drawing, all currently open drawings and/or a directory              ;;
;;  (and subdirectories) of drawings.                                            ;;
;;                                                                               ;;
;;  If the 'Block Definitions' option is selected, all instances of the          ;;
;;  aforementioned text objects residing within block definitions are included   ;;
;;  in the search domain.                                                        ;;
;;                                                                               ;;
;;  Furthermore the user may choose which objects to search, whether the find    ;;
;;  string is case sensitive, and whether to restrict the search to whole words  ;;
;;  only.                                                                        ;;
;;                                                                               ;;
;;                       ----------------------------------                      ;;
;;  Example:                                                                     ;;
;;  ------------                                                                 ;;
;;  Find:         "is"                                                           ;;
;;  Replace With: "be"                                                           ;;
;;  String:       "This Is a test"                                               ;;
;;                                                                               ;;
;;  |  [x] Match Case        |  [ ] Match Case         |                         ;;
;;  |  [ ] Whole words only  |  [ ] Whole words only   |                         ;;
;;  |  This Is a test        |  This Is a test         |                         ;;
;;  |  Thbe Is a test        |  Thbe be a test         |                         ;;
;;  |------------------------|-------------------------|                         ;;
;;  |  [x] Match Case        |  [ ] Match Case         |                         ;;
;;  |  [x] Whole words only  |  [x] Whole words only   |                         ;;
;;  |  This Is a test        |  This Is a test         |                         ;;
;;  |  This Is a test        |  This be a test         |                         ;;
;;                                                                               ;;
;;                       ----------------------------------                      ;;
;;                                                                               ;;
;;  The user can also choose to 'Ignore Locked Layers'; with this option set,    ;;
;;  all objects residing on Locked Layers are excluded from the search.          ;;
;;                                                                               ;;
;;  The 'Where to Search' panel offers the ability to perform the find & replace ;;
;;  operation througout the entire drawing, or restrict the search to model      ;;
;;  space or layout space only.                                                  ;;
;;                                                                               ;;
;;  If 'Search Only' is checked, drawings will be searched for each 'Find'       ;;
;;  string in the list, but no replacements will be made. Upon completion of     ;;
;;  the search, a CSV report will be displayed should a match be found.          ;;
;;                                                                               ;;
;;  When performing replacements, the creation of a 'Replacement Report' may be  ;;
;;  toggled using the relevant setting on the 'Options' dialog.                  ;;
;;                                                                               ;;
;;  Note that a Regen may be required to view changes to open drawings.          ;;
;;  This could be accomplished programmatically, but has been omitted for better ;;
;;  performance.                                                                 ;;
;;                                                                               ;;
;;-------------------------------------------------------------------------------;;
;;                                                                               ;;
;;  FUNCTION SYNTAX:  BFind                                                      ;;
;;                                                                               ;;
;;  Notes:                                                                       ;;
;;  ---------                                                                    ;;
;;  As expected, the known bug with ObjectDBX arises with regards to attribute   ;;
;;  alignment following modification. A sub-function has been included in an     ;;
;;  attempt to correct the change in position, however, a slight shift in        ;;
;;  position may be noticed. The attribute is realigned when the block is moved  ;;
;;  manually.                                                                    ;;
;;                                                                               ;;
;;  Also, when using the Batch Find and Replace, drawing thumbnails are lost     ;;
;;  upon saving with ObjectDBX. These return when the drawing is saved manually. ;;
;;                                                                               ;;
;;-------------------------------------------------------------------------------;;
;;                                                                               ;;
;;  Author: Lee Mac, Copyright © 2011 - www.lee-mac.com                          ;;
;;                                                                               ;;
;;-------------------------------------------------------------------------------;;
;;                                                                               ;;
;;  With additional thanks to Joe Burke for his tremendous help towards using    ;;
;;  Regular Expressions to eliminate the problem of MText formatting codes when  ;;
;;  performing replacements.                                                     ;;
;;                                                                               ;;
;;-------------------------------------------------------------------------------;;
;;  Version:                                                                     ;;
;;                                                                               ;;
;;  1.0:  24/05/2010  -  First Release                                           ;;
;;-------------------------------------------------------------------------------;;
;;  1.1:  26/05/2010  -  Added Options Button.                                   ;;
;;                    -  Updated String Replacement functions to allow for case  ;;
;;                       sensitivity options.                                    ;;
;;                    -  Upgraded StringRep function to allow replacement string ;;
;;                       to contain find string.                                 ;;
;;                    -  Fixed bug causing an unsaved drawing to be saved.       ;;
;;-------------------------------------------------------------------------------;;
;;  1.2:  29/05/2010  -  Added ability to perform multiple replacements.         ;;
;;-------------------------------------------------------------------------------;;
;;  1.3:  31/05/2010  -  Added ability to edit find and replace entry by         ;;
;;                       double-clicking.                                        ;;
;;                    -  Added 'Table Text' object to Options Dialog.            ;;
;;                    -  Added 'Find Whole Words Only' option to Options Dialog. ;;
;;                    -  Redesigned Options Dialog to accommodate new toggles,   ;;
;;                       added mnemonics.                                        ;;
;;-------------------------------------------------------------------------------;;
;;  1.4:  27/04/2010  -  Replaced 'StringRep' function with functions utilising  ;;
;;                       Regular Expressions to allow for MText formatting.      ;;
;;-------------------------------------------------------------------------------;;
;;  1.5:  29/09/2010  -  Reformatted code.                                       ;;
;;                    -  Drawings only saved if a replacement is made.           ;;
;;-------------------------------------------------------------------------------;;
;;  1.6:  03/10/2010  -  Added pick buttons to select text for Find/Replace      ;;
;;                       strings.                                                ;;
;;                    -  Added 'Match Case' option                               ;;
;;                    -  Added 'Find Whole Words Only' option                    ;;
;;-------------------------------------------------------------------------------;;
;;  1.7:  05/10/2010  -  Added 'Search Only' option in which the program will    ;;
;;                       search for multiple strings within the current drawing  ;;
;;                       and/or a directory (and subdirectories) of drawings,    ;;
;;                       subsequently producing a report detailing the number    ;;
;;                       of occurrences of each string and list of possible      ;;
;;                       changes should a replacement be performed.              ;;
;;                    -  Added error trap to drawing processing loop to prevent  ;;
;;                       crash should one drawing error.                         ;;
;;                    -  Added delay to DCL creation.                            ;;
;;-------------------------------------------------------------------------------;;
;;  1.8:  08/10/2010  -  Added Load & Save buttons to allow a set of search      ;;
;;                       items to be loaded and saved.                           ;;
;;-------------------------------------------------------------------------------;;
;;  1.9:  09/10/2010  -  Fixed bug involving capital 'S' being removed from      ;;
;;                       textstring during stacking formatting code removal.     ;;
;;                    -  Added code to allow 'special' characters to be used in  ;;
;;                       Find string.                                            ;;
;;-------------------------------------------------------------------------------;;
;;  2.0:  22/07/2011  -  Majority of program rewritten and reformatted to        ;;
;;                       include the following enhancements:                     ;;
;;                    -  Fixed tab stops in dialog to allow the user to use the  ;;
;;                       tab key to navigate between edit boxes.                 ;;
;;                    -  Added 'Where to Search' panel to allow the user to      ;;
;;                       restrict the search to Modelspace, Layout space or Both.;;
;;                    -  Added 'Block Definitions' to list of objects to search  ;;
;;                       to allow users to search text objects in blocks.        ;;
;;                    -  Added 'Current Directory' toggle to allow the user to   ;;
;;                       quickly select the current working directory to be      ;;
;;                       processed.                                              ;;
;;                    -  Added ability to add items to find/replace list by      ;;
;;                       pressing Enter from within either edit box.             ;;
;;                    -  Added ability to press Enter after entering Save        ;;
;;                       Reference without needing to click the OK button.       ;;
;;                    -  Added ability to press Enter after editing entry        ;;
;;                       without needing to click the OK button.                 ;;
;;                    -  Changed format of Saved Searches file for easier        ;;
;;                       manual editing.                                         ;;
;;                    -  Added ability to process 'All Open Drawings'.           ;;
;;-------------------------------------------------------------------------------;;

(defun c:BFind

;;-------------------------------------------------------------------------------;;

  (
    /

    ;;         --=={ Local Functions }==--          ;

    *error*
    _calcinspt
    _directorydialog
    _directorymode
    _directorytext
    _endundo
    _entryedit
    _formatdate
    _generatereport
    _getallfiles
    _getsavepath
    _gettextstring
    _list->value
    _loaddialog
    _locklayers
    _logo
    _lst->str
    _makelist
    _objectdbxdocument
    _openfile
    _optionsdialog
    _populatelistbox
    _popup
    _readconfig
    _readsearchitems
    _regexexecute
    _regexreplace
    _releaseobject
    _removeitems
    _replace
    _replaceobject
    _replacetext
    _savedialog
    _sortbyfirst
    _startundo
    _substatn
    _unlocklayers
    _value->list
    _writeconfig
    _writedcl
    _writesearchitems
    
    ;;         --=={ Local Variables }==--          ;

    *bfind_cur*
    *bfind_lst*
    *bfind_opn*
    *bfind_opt*
    *bfind_pat*
    *bfind_ser*
    *bfind_sub*
    *bfind_whr*
    *replaceflag*
    acapp
    acdoc
    bit
    cdir
    cfgfname
    dbdoc
    dcedititle
    dcflag
    dcfname
    dcopttitle
    dctitle
    dir
    doc
    doclst
    dwg
    dwlst
    elist
    err
    express
    filepath
    filetype
    flag
    flags
    fn
    fo
    fold
    folder
    fs
    fstr
    i
    id
    items
    l
    lst
    mode
    msg
    ns
    obj
    os
    path
    progbar
    ptr
    rep
    reportlst
    res
    rname
    row
    rs
    rstr
    savelist
    savepath
    savfname
    self
    shell
    str
    string
    sym
    symlist
    title
    tmp1
    tmp2
    val
    vallist
    versionnumber
    where
    wsh
   
    ;;         --=={ Global Variables }==--         ;

    ; --None--

  )
  
  (setq VersionNumber "2-0")
  
;;-------------------------------------------------------------------------------;;
;;                           --=={  Local Functions  }==--                       ;;
;;-------------------------------------------------------------------------------;;

  (defun *error* ( msg )
    (if acdoc (_EndUndo acdoc))
    (if (< 0 id) (setq id (unload_dialog id)))
    (if (and fo  (eq 'FILE (type fo))) (setq fo (close fo)))
    (and Express ProgBar (acet-ui-progress))
    (mapcar '_ReleaseObject (list acapp acdoc shell wsh dbdoc doc))
    (_ReleaseObject (vl-bb-ref '*REX*))
    (vl-bb-set '*REX* nil)
    (if (not (wcmatch (strcase msg) "*BREAK,*CANCEL*,*EXIT*"))
      (princ (strcat "\n** Error: " msg " **"))
    )
    (princ)
  )

;;-------------------------------------------------------------------------------;;

  (defun _StartUndo ( doc ) (_EndUndo doc)
    (vla-StartUndoMark doc)
  )

;;-------------------------------------------------------------------------------;;

  (defun _EndUndo ( doc )
    (if (= 8 (logand 8 (getvar 'UNDOCTL)))
      (vla-EndUndoMark doc)
    )
  )

;;-------------------------------------------------------------------------------;;

  (defun _GetSavePath ( / tmp )
    (cond      
      ( (setq tmp (getvar 'ROAMABLEROOTPREFIX))
        (strcat (vl-string-right-trim "\\" (vl-string-translate "/" "\\" tmp)) "\\Support")
      )
      ( (setq tmp (findfile "ACAD.pat"))
        (vl-string-right-trim "\\" (vl-string-translate "/" "\\" (vl-filename-directory tmp)))
      )
      ( (vl-string-right-trim "\\" (vl-filename-directory (vl-filename-mktemp))) )
    )
  )

;;-------------------------------------------------------------------------------;;

  (defun _WriteConfig ( fn lst / fo )
    (if (setq fo (open fn "w")) 
      (progn
        (foreach x lst (write-line (vl-prin1-to-string x) fo))
        (setq fo (close fo))
        T
      )
    )
  )

;;-------------------------------------------------------------------------------;;

  (defun _ReadConfig ( fn lst / fo )
    (if
      (and
        (setq fn (findfile fn))
        (setq fo (open fn "r"))
      )
      (progn
        (foreach x lst (set x (read (read-line fo))))
        (setq fo (close fo))
        T
      )
    )
  )

;;-------------------------------------------------------------------------------;;

  (defun _ReleaseObject ( obj )
    (and obj (eq 'VLA-OBJECT (type obj)) (not (vlax-object-released-p obj))
      (not
        (vl-catch-all-error-p
          (vl-catch-all-apply 'vlax-release-object (list obj))
        )
      )
    )
  )
  
;;-------------------------------------------------------------------------------;;

  (defun _DirectoryDialog ( msg dir flag / Shell Fold Self Path )
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

;;-------------------------------------------------------------------------------;;

  (defun _GetAllFiles ( Dir Subs Filetype / _GetSubFolders )
    
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

;;-------------------------------------------------------------------------------;;

  (defun _ObjectDBXDocument ( acapp / acVer )
    (vla-GetInterfaceObject acapp
      (if (< (setq acVer (atoi (getvar "ACADVER"))) 16)
        "ObjectDBX.AxDbDocument" (strcat "ObjectDBX.AxDbDocument." (itoa acVer))
      )
    )
  )

;;-------------------------------------------------------------------------------;;
  
  (defun _Popup ( title flags msg / wsh res )
    (vl-catch-all-apply
      (function
        (lambda nil
          (setq wsh (vlax-create-object "WScript.Shell"))
          (setq res (vlax-invoke-method wsh 'popup msg 0 title flags))
        )
      )
    )
    (if wsh (vlax-release-object wsh))
    res
  )

;;-------------------------------------------------------------------------------;;

  (defun _WriteDCL ( fn / fo )
    (cond
      ( (findfile fn)
      )      
      ( (setq fo (open fn "w"))
        (foreach str
         '(
            "//-------------------------=={  Batch Find & Replace  }==------------------------//"
            "//                                                                               //"
            "//  BFind.dcl to be used in conjunction with BFind.lsp.                          //"
            "//-------------------------------------------------------------------------------//"
            "//  Author: Lee Mac, Copyright © 2011 - www.lee-mac.com                          //"
            "//-------------------------------------------------------------------------------//"
            ""
            "//-------------------------------------------------------------------------------//"
            "//                        --=={ Sub-Assembly Definitions }==--                   //"
            "//-------------------------------------------------------------------------------//"
            ""
            "boxcol : boxed_column {  width =  60; fixed_width  = true; alignment = centered; }"
            "edit53 :     edit_box {  width =  53; fixed_width  = true; alignment = left;     }"
            "space1 :       spacer { height = 0.1; fixed_height = true;                       }"
            "butt10 :       button {  width =  10; fixed_width  = true; alignment = centered; }"
            "butt12 :       button {  width =  12; fixed_width  = true; alignment = centered; }"
            "butt20 :       button {  width =  20; fixed_width  = true; alignment = centered; }"
            "butt3  :       button {  width =   3; fixed_width  = true; alignment = centered; }"
            ""
            "//-------------------------------------------------------------------------------//"
            "//                         --=={ Main Dialog Definition }==--                    //"
            "//-------------------------------------------------------------------------------//"
            ""
            "bfind : dialog { key = \"dcl_title\";"
            "  spacer;"
            "  : text { label = \"Copyright (c) 2011 Lee Mac\"; alignment = right; }"
            ""
            "  : column {  "
            "    : text { label = \"Find &What:\"; }"
            "    : row {"
            "      : edit53 { key = \"fstr\"; mnemonic = \"W\"; }"
            "      : butt3  { key = \"fpick\"; label = \">>\"; is_tab_stop = false; }"
            "    }"
            "    spacer;"
            "    : text { label = \"&Replace With:\"; }"
            "    : row {"
            "      : edit53 { key = \"rstr\"; mnemonic = \"R\"; }"
            "      : butt3  { key = \"rpick\"; label = \">>\"; is_tab_stop = false; }"
            "    }"
            "    : toggle { key = \"search\"; label = \"Search Only\"; is_tab_stop = false; }"
            "    spacer;"
            "  }"
            "  spacer;"
            "  : row {"
            "    spacer;"
            "    : butt20 { key = \"add\"; label = \"Add\"; }"
            "    : butt10 { key = \"clr\"; label = \"Clear\"; }"
            "    : butt20 { key = \"rem\"; label = \"Remove\"; }"
            "    spacer;"
            "  }"
            "  spacer;"
            "  : list_box { key = \"rep_list\"; multiple_select = true;"
            "               fixed_width = false; alignment = centered; tabs = \"30\";"
            "  }"
            "  spacer;"
            "  : row { alignment = centered; fixed_width = true;"
            "    : butt20 { key = \"load\"; label = \"Load\"; }"
            "    : butt20 { key = \"save\"; label = \"Save\"; }"
            "  }"
            "  : text   { label = \"Double-Click to Edit Entry   \"; alignment = right; }"
            "  : boxcol { label = \"Drawing Directory\";"
            "    : row {"
            "      : column {"
            "        space1;"
            "        : text   { key = \"dir_text\"; alignment = left; }"
            "        space1;"
            "      }"
            "      : butt10 { label = \"Directory...\"; key = \"dir\"; }"
            "    }"
            "    : row {"
            "      : column {"
            "        : toggle { key = \"cur_dir\"; label = \"Current Directory\"      ; }"
            "        : toggle { key = \"sub_dir\"; label = \"Include Sub-Directories\"; }"
            "      }"
            "      : column {"
            "        : toggle { key = \"cur_dwg\"; label = \"Current Drawing Only\"   ; }"
            "        : toggle { key = \"opn_dwg\"; label = \"All Open Drawings\"      ; }"
            "      }"
            "    }"
            "  }"
            "  spacer;"
            "  : row {"
            "    : butt12 { key = \"option\"; label = \"Options\"; }"
            "    : butt12 { key = \"accept\"; label = \"OK\"; is_default = true; }"
            "    : butt12 { key = \"cancel\"; label = \"Cancel\"; is_cancel = true; }"
            "    : image  { key = \"logo\"; alignment = centered;"
            "               width = 16.06 ; fixed_width  = true;"
            "               height = 2.06 ; fixed_height = true; color = -15;"
            "    }"
            "  }"
            "}"
            ""
            "//-------------------------------------------------------------------------------//"
            "//                       --=={ Options Dialog Definition }==--                   //"
            "//-------------------------------------------------------------------------------//"
            ""
            "bfind_opt : dialog { key = \"dcl_title_opt\";"
            "  spacer;"
            "  : boxed_column { label = \"Search Options\";"
            "    : row {"
            "      : toggle { key = \"case\"; label = \" Match &Case\"; mnemonic = \"C\"; }"
            "      : toggle { key = \"whol\"; label = \" Find &Whole Words Only\" ; mnemonic = \"W\"; }"
            "    }"
            "    : toggle { key = \"lock\"; label = \" &Ignore Objects on Locked Layers\" ; mnemonic = \"I\"; }"
            "    spacer;"
            "  }"
            "  spacer;"
            "  : boxed_column { label = \"Objects to Search\";"
            "    : row {"
            "      : column {"
            "        : toggle { key = \"dtxt\"; label = \" &Single-line Text\" ; mnemonic = \"S\"; }"
            "        : toggle { key = \"mtxt\"; label = \" &Multiline Text\"   ; mnemonic = \"M\"; }"
            "        : toggle { key = \"att\" ; label = \" &Block Attributes\" ; mnemonic = \"B\"; }"
            "        : toggle { key = \"blk\" ; label = \" B&lock Definitions\"; mnemonic = \"l\"; }"
            "      }"
            "      : column {"
            "        : toggle { key = \"dim\" ; label = \" &Dimension Text\"   ; mnemonic = \"D\"; }"
            "        : toggle { key = \"mld\" ; label = \" M&ultileader Text\" ; mnemonic = \"u\"; }"
            "        : toggle { key = \"tab\" ; label = \" &Table Text\"       ; mnemonic = \"T\"; }"
            "        : spacer { height = 1.2; fixed_height = true; }"
            "      }"
            "    }"
            "    spacer;"
            "  }"
            "  spacer;"
            "  : boxed_column { label = \"Report Options\";"
            "    : toggle { key = \"report\"; label = \" Always Generate Replacement Report\"; mnemonic = \"A\"; }"
            "    spacer;"
            "  }"
            "  spacer;"
            "  : boxed_column { label = \"Where to Search\";"
            "    : popup_list { key = \"where\"; }"
            "    spacer;"
            "  }"
            "  spacer; ok_cancel;"
            "}"
            ""
            "//-------------------------------------------------------------------------------//"
            "//                   --=={ Entry Editing Dialog Definition }==--                 //"
            "//-------------------------------------------------------------------------------//"
            ""
            "bfind_edit : dialog { key = \"dcl_title_edi\";"
            "  spacer;"
            "  : column {"
            "    : text   { label = \"Find &What:\"; is_tab_stop = false; }"
            "    : edit53 { key = \"fstr\"; mnemonic = \"W\"; allow_accept = true; }"
            "    spacer;"
            "    : text   { label = \"&Replace With:\"; is_tab_stop = false; }"
            "    : edit53 { key = \"rstr\"; mnemonic = \"R\"; allow_accept = true; }"
            "    spacer;"
            "  }"
            "  spacer; ok_cancel;"
            "}"
            ""
            "//-------------------------------------------------------------------------------//"
            "//                       --=={ Save Dialog Definition }==--                      //"
            "//-------------------------------------------------------------------------------//"
            ""
            "bfind_save : dialog { label = \"Save As\"; initial_focus = \"saveas\";"
            "  spacer;"
            "  : text { label = \"Enter Reference for Search Items List:\"; }"
            "  : edit53 { key = \"saveas\"; allow_accept = true; }"
            "  spacer; ok_cancel;"
            "}"
            ""
            "//-------------------------------------------------------------------------------//"
            "//                        --=={ Load Dialog Definition }==--                     //"
            "//-------------------------------------------------------------------------------//"
            ""
            "bfind_load : dialog { label = \"Load Search Items List\";"
            "  spacer;"
            "  : list_box { key = \"items\"; alignment = centered; fixed_width =true;"
            "               multiple_select = false; width = 50;"
            "  }"
            "  spacer;"
            "  : row { fixed_width = true; alignment = centered;"
            "    : butt12 { label = \"Load\";   key = \"accept\"; is_default = true; }"
            "    : butt12 { label = \"Done\";   key = \"cancel\"; is_cancel  = true; }"
            "    : butt12 { label = \"Delete\"; key = \"delete\"; }"
            "  }"
            "}"
            ""
            "//-------------------------------------------------------------------------------//"
            "//                           End of Dialog Definition                            //"
            "//-------------------------------------------------------------------------------//"
          )
          (write-line str fo)
        )          
        (setq fo (close fo))
        (while (not (findfile fn)))
        fn
      )
    )
  )

;;-------------------------------------------------------------------------------;;

  (defun _Logo ( key )
    (start_image key)
    (mapcar 'vector_image
     '(022 021 001 000 000 000 000 007 000 000 000 000 001 006 006 006 006 007 043 036 027 036 030 021 021 021 022 022 022 022
       021 021 021 028 028 028 027 027 030 029 029 030 052 043 043 043 044 044 046 046 045 045 045 045 052 052 052 051 051 051
       051 051 052 062 065 066 068 068 068 068 067 067 075 075 075 074 074 073 066 058 058 059 059 059 059 052 057 057 056 056
       056 056 057 058 065 065 065 065 066 095 094 094 092 091 091 091 090 089 089 088 087 086 085 074 074 075 075 076 077 078
       079 080 081 082 083 084 085 086 087 088 088 089 090 091 092 093 094 095 074 073 073 072 072 071 071 071 071 071 071 071
       072 072 072 073 084 083 082 081 080 079 079 078 077 077 076 076 076 076 076 077 077 078 079 079 080 081 082 083 094 094
       095 083 083 082 081 080 079 078 077 076 075 074 084 085 086 087 088 089 089 090 091 091 091 091 092 095 094 093 092 091
       090 089 089 088 087 086 085 084)
     '(020 020 023 023 023 024 024 000 000 000 000 001 001 020 001 001 001 000 002 024 007 015 000 000 000 000 001 001 023 023
       023 024 024 024 024 024 023 023 002 001 001 000 000 000 000 000 001 001 007 023 023 023 024 024 024 024 024 023 023 001
       001 001 000 010 016 019 021 022 023 024 024 024 024 024 024 023 023 022 004 004 005 005 006 006 007 024 024 024 024 023
       023 022 019 016 007 007 006 005 005 022 022 022 017 017 018 018 019 020 020 020 021 021 021 021 022 023 023 023 024 024
       024 025 025 025 025 025 025 025 025 024 024 024 023 023 022 022 022 022 007 008 008 009 010 011 012 013 014 015 016 017
       018 019 019 020 021 021 021 021 020 020 019 019 018 017 016 015 014 013 012 012 011 010 009 009 008 008 008 007 007 007
       007 004 004 004 004 004 004 004 005 005 006 006 007 007 008 008 008 009 009 009 010 011 011 011 011 007 007 007 006 006
       005 005 004 004 004 004 004 004)
     '(021 006 000 000 000 000 021 000 000 000 000 001 001 006 006 006 007 007 036 046 036 030 021 021 021 022 022 022 022 021
       021 021 028 028 028 027 027 027 029 029 030 030 043 043 043 044 044 043 046 045 045 045 045 052 052 052 051 051 051 051
       051 052 052 065 058 068 068 068 068 067 067 075 075 075 074 074 073 065 058 058 059 059 059 059 051 057 057 056 056 056
       056 057 066 062 065 065 065 066 066 094 094 095 091 091 091 090 089 089 088 087 086 085 084 074 075 075 076 077 078 079
       080 081 082 083 084 085 086 087 088 088 089 090 091 092 093 094 095 092 073 073 072 072 071 071 071 071 071 071 071 072
       072 072 073 074 083 082 081 080 079 079 078 077 077 076 076 076 076 076 077 077 078 079 079 080 081 082 083 084 094 095
       094 083 082 081 080 079 078 077 076 075 074 074 085 086 087 088 089 089 090 091 091 091 091 092 095 094 093 092 091 090
       089 089 088 087 086 085 084 083)
     '(020 020 023 023 024 024 024 000 000 000 001 001 023 001 001 001 000 000 015 007 024 002 000 000 000 001 001 023 023 023
       024 024 024 024 024 023 023 007 001 001 000 000 000 000 000 001 001 002 023 023 023 024 024 024 024 024 023 023 001 001
       001 000 000 016 016 021 022 023 024 024 024 024 024 024 023 023 022 007 004 005 005 006 006 007 022 024 024 024 023 023
       022 019 019 010 007 006 005 005 004 022 022 022 017 018 018 019 020 020 020 021 021 021 021 022 023 023 023 024 024 024
       025 025 025 025 025 025 025 025 024 024 024 023 023 022 022 022 022 017 008 008 009 010 011 012 013 014 015 016 017 018
       019 019 020 021 021 021 021 020 020 019 019 018 017 016 015 014 013 012 012 011 010 009 009 008 008 008 007 007 007 007
       007 004 004 004 004 004 004 005 005 006 006 007 007 008 008 008 009 009 009 010 011 011 011 011 007 007 007 006 006 005
       005 004 004 004 004 004 004 004)
     '(178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178
       178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178
       178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178
       178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178
       178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178
       178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178
       178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178 178
       178 178 178 178 178 178 178 178)
    )    
    (end_image)
  )

;;-------------------------------------------------------------------------------;;
  
  (defun _DirectoryText ( key str )
    (set_tile key
      (if str
        (if (< 40 (strlen str))
          (strcat (substr str 1 37) "...") str
        )
        ""
      )
    )
  )

;;-------------------------------------------------------------------------------;;

  (defun _DirectoryMode ( cur opn / val )
    (if (or (eq "1" cur) (eq "1" opn))
      (setq val 1)
      (setq val 0)
    )
    (foreach x
      (cond
        ( (eq "1" cur)
         '("opn_dwg" "cur_dir" "sub_dir" "dir" "dir_text")
        )
        ( (eq "1" opn)
         '("cur_dwg" "cur_dir" "sub_dir" "dir" "dir_text")
        )
        ('("opn_dwg" "cur_dwg" "cur_dir" "sub_dir" "dir" "dir_text")
        )
      )
      (mode_tile x val)
    )
  )
  
;;-------------------------------------------------------------------------------;;

  (defun _SortByFirst ( lst )
    (vl-sort lst (function (lambda ( a b ) (< (car a) (car b)))))
  )

;;-------------------------------------------------------------------------------;;

  (defun _RemoveItems ( items lst / i )
    (setq i -1)
    (vl-remove-if (function (lambda ( x ) (vl-position (setq i (1+ i)) items))) lst)
  )
  
;;-------------------------------------------------------------------------------;;
  
  (defun _PopulateListBox ( key lst ) (start_list key)
    (foreach x lst
      (add_list
        (strcat
          (if (< 29 (strlen (car x)))
            (strcat (substr (car x) 1 26) "...") (car x)
          )
          "\t" (cdr x)
        )
      )
    )
    (end_list) lst
  )
  
;;-------------------------------------------------------------------------------;;

  (defun _GetTextString ( entity )
    (
      (lambda ( entity / _type elist )
        (cond
          ( (wcmatch (setq _type (cdr (assoc 0 (setq elist (entget entity))))) "TEXT,*DIMENSION")
            (cdr (assoc 1 (reverse elist)))
          )
          ( (eq "MULTILEADER" _type)
            (cdr (assoc 304 elist))
          )
          ( (wcmatch _type "ATTRIB,MTEXT")
            (
              (lambda ( string )
                (mapcar
                  (function
                    (lambda ( pair )
                      (if (member (car pair) '(1 3))
                        (setq string (strcat string (cdr pair)))
                      )
                    )
                  )
                  elist
                )
                string
              )
              ""
            )
          )
        )
      )
      (if (eq 'VLA-OBJECT (type entity))
        (vlax-vla-object->ename entity)
        entity
      )
    )
  )

;;-------------------------------------------------------------------------------;;

  (defun _CalcInsPt ( obj str / e a )
    (setq e (entget (vlax-vla-object->ename obj))
          a (cdr (assoc 72 e))
    )
    (polar
      (vlax-get obj 'InsertionPoint)
      (vla-get-Rotation obj)
      (*
        (apply '+
          (mapcar
            (function (lambda ( e1 e2 ) (- (car e1) (car e2))))
            (textbox e)
            (textbox (subst (cons 1 str) (assoc 1 e) e))
          )
        )
        (cond
          ( (or (= a 1) (= a 4)) 0.5)
          ( (= a 2) 1.0)
          ( 0.0 )
        )
      )
    )
  )

;;-------------------------------------------------------------------------------;;

  (defun _UnlockLayers ( doc / lst )
    (vlax-for l (vla-get-layers doc)
      (if (eq :vlax-true (vla-get-lock l))
        (vla-put-lock (car (setq lst (cons l lst))) :vlax-false)
      )
    )
    lst
  )

;;-------------------------------------------------------------------------------;;

  (defun _LockLayers ( lst )
    (foreach l lst (vla-put-lock l :vlax-true))
  )

;;-------------------------------------------------------------------------------;;

  (defun _OptionsDialog ( id mode where / tmp1 tmp2 i )
    (cond
      ( (not (new_dialog "bfind_opt" id))
        (_Popup "Warning" 16 "Batch Find Options Dialog could not be Loaded")
        (princ "\n** DCL could not be Loaded **")
      )
      ( t
        (set_tile "dcl_title_opt" dcopttitle)
        (_MakeList "where"
         '(
            "Entire Drawing"
            "Model Space Only"
            "Layout Space Only"
          )
        )            
        (setq tmp1 mode
              tmp2 where i 1
        )
        (foreach x '("case" "lock" "whol" "dtxt" "mtxt" "att" "dim" "mld" "tab" "report" "blk")
          (set_tile x (if (= i (logand i tmp1)) "1" "0"))
          (action_tile x (strcat "(setq tmp1 ((if (eq \"1\" $value) + -) tmp1 " (itoa i) "))"))
          (setq i (lsh i 1))
        )
        (set_tile "where" tmp2)
        (action_tile "where"  "(setq tmp2 $value)")
        (action_tile "accept" "(setq mode tmp1 where tmp2) (done_dialog)")
        (action_tile "cancel" "(done_dialog)")
        (start_dialog)
      )
    )
    (list mode where)
  )

;;-------------------------------------------------------------------------------;;

  (defun _EntryEdit ( id entry / fs rs )
    (cond
      ( (not (new_dialog "bfind_edit" id))
        (_Popup "Warning" 16 "Batch Find Edit Dialog could not be Loaded")
        (princ "\n** DCL could not be Loaded **")
      )      
      ( t
        (set_tile "dcl_title_edi" dcedititle)
        (mapcar 'set '(fs rs)
          (mapcar 'set_tile '("fstr" "rstr") (list (car entry) (cdr entry)))
        )        
        (mode_tile "fstr" 2)
        (action_tile "fstr" "(setq fs $value)")
        (action_tile "rstr" "(setq rs $value)")
        (action_tile "accept"
          (vl-prin1-to-string
            (quote
              (cond
                ( (or (not fs) (eq "" fs))
                  (_Popup "Information" 64 "Please Enter a String to Find")
                )                  
                ( (setq entry (cons fs rs))
                  (done_dialog)
                )
              )
            )
          )
        )
        (action_tile "cancel" "(done_dialog)")
        (start_dialog)
      )
    )
    entry
  )

;;-------------------------------------------------------------------------------;;

  (defun _GenerateReport ( fn data / fo )
    (cond
      ( (setq fo (open fn "a"))
        (write-line
          (strcat "Replacement Report,"
            (_FormatDate "DD.MO.YYYY HH:MM") (if (eq "1" *BFind_ser*) ",SEARCH ONLY" "")
          )
          fo
        )
        (write-line "" fo)
        (foreach l (cons '("Search String" . "Replace String") *BFind_lst*)
          (write-line (strcat (car l) "," (cdr l)) fo)
        )       
        (write-line "" fo)
        (write-line (strcat "Parent Directory," *BFind_pat*) fo)
        (write-line "" fo)
        (write-line
          (strcat "Drawing,Old String,New String,Object,Handle"
            (if (vl-some '(lambda ( x ) (= 6 (length x))) data) ",TagString" "")
          )
          fo
        )
        (foreach line data
          (write-line (_lst->str line ",") fo)
        )
        (write-line "" fo)
        (write-line (strcat "Total Replacements:," (itoa (length data))) fo)
        (write-line "" fo)
        (setq fo (close fo))
        T
      )
    )
  )

;;-------------------------------------------------------------------------------;;

  (defun _OpenFile ( fn / shell result )
    (setq result
      (vl-catch-all-apply
        (function
          (lambda nil
            (setq shell (vla-getInterfaceObject (vlax-get-acad-object) "Shell.Application"))
            (vlax-invoke shell 'open fn)
          )
        )
      )
    )
    (if shell (vlax-release-object shell))
    (not (vl-catch-all-error-p result))
  )

;;-------------------------------------------------------------------------------;;

  (defun _lst->str ( lst del )
    (if (cdr lst)
      (strcat (car lst) del (_lst->str (cdr lst) del))
      (car lst)
    )
  )
  
;;-------------------------------------------------------------------------------;;

  (defun _FormatDate ( format )
    (menucmd (strcat "m=$(edtime,$(getvar,DATE)," format ")"))
  )

;;-------------------------------------------------------------------------------;;

  (defun _value->list ( ptr ) (read (strcat "(" ptr ")")))

;;-------------------------------------------------------------------------------;;

  (defun _list->value ( lst ) (vl-string-trim "()" (vl-princ-to-string lst)))

;;-------------------------------------------------------------------------------;;

  (defun _MakeList ( key lst )
    (start_list key) (mapcar 'add_list lst) (end_list)
  )

;;-------------------------------------------------------------------------------;;

  (defun _SubstAtN ( lst item n )
    (if lst
      (if (zerop n)
        (cons item (cdr lst))
        (cons (car lst) (_SubstAtN (cdr lst) item (1- n)))
      )
    )
  )
  
;;-------------------------------------------------------------------------------;;

  (defun _WriteSearchItems ( fn lst / fo )
    (if (setq fo (open fn "w"))
      (progn
        (foreach ref lst
          (write-line (strcat "[" (car ref) "]") fo)
          (foreach item (cdr ref)
            (write-line (strcat (car item) "\t" (cdr item)) fo)
          )
          (write-line "" fo)
        )
        (setq fo (close fo))
        T
      )
    )
  )

;;-------------------------------------------------------------------------------;;

  (defun _ReadSearchItems ( fn / fo l1 l2 ln ps )
    (if
      (and
        (setq fn (findfile fn))
        (setq fo (open fn "r"))
      )
      (progn
        (while (setq ln (read-line fo))
          (cond
            ( (and (wcmatch ln "`[*`]") (not (wcmatch ln "*\t*")))
              (if l2
                (setq l1 (cons (reverse l2) l1))
              )
              (setq l2 (list (substr ln 2 (- (strlen ln) 2))))
            )
            ( (wcmatch ln "*\t*")
              (setq ps (vl-string-position 9 ln)
                    l2 (cons (cons (substr ln 1 ps) (substr ln (+ ps 2))) l2)
              )
            )
          )
        )
        (setq fo (close fo))
        (if l2
          (setq l1 (cons (reverse l2) l1))
        )
        (reverse l1)
      )
    )
  )

;;-------------------------------------------------------------------------------;;

  (defun _SaveDialog ( id lst / str )
    (cond
      ( (not (new_dialog "bfind_save" id))
        (_Popup "Warning" 16 "Save Dialog could not be Loaded")
        (princ "\n** DCL could not be Loaded **")
      )
      ( t
        (action_tile "saveas" "(setq str $value)")
        (action_tile "accept"
          (vl-prin1-to-string
            (quote
              (cond
                ( (or (not str) (eq "" str))
                  (_Popup "Information" 64 "Please Enter a Save Reference")
                )
                ( (member str lst)
                  (if (= 6 (_Popup "Information" 68 "Save Reference Already Exists\nOverwrite?"))
                    (done_dialog)
                  )
                )
                ( (done_dialog) )
              )
            )
          )
        )
        (action_tile "cancel" "(setq str nil) (done_dialog)")
        (start_dialog)
      )
    )
    str
  )

;;-------------------------------------------------------------------------------;;

  (defun _LoadDialog ( id lst / ptr item )
    (cond
      ( (not (new_dialog "bfind_load" id))
        (_Popup "Warning" 16 "Load Dialog could not be Loaded")
        (princ "\n** DCL could not be Loaded **")
      )
      ( t
        (_MakeList "items" (setq lst (acad_strlsort lst)))
        (setq ptr (set_tile "items" "0"))
       
        (action_tile "items" "(setq ptr $value)")
        (action_tile "delete"
          (vl-prin1-to-string
            (quote
              (progn
                (cond
                  ( (not ptr)
                    (_Popup "Information" 48 "Please Select a Reference to Delete")
                  )
                  ( (= 6
                      (_Popup "Information" 68
                        (strcat "About to Delete Saved Search: '"
                          (nth (atoi ptr) lst) "'\nThis action cannot be undone.\n\nProceed?"
                        )
                      )
                    )
                    (_MakeList "items" (setq lst (_RemoveItems (list (atoi ptr)) lst)))
                    (if lst
                      (setq ptr
                        (set_tile "items"
                          (if (< (atoi ptr) (length lst)) ptr "0")
                        )
                      )
                      (mapcar 'mode_tile '("delete" "accept") '(1 1))
                    )
                  )
                )
              )
            )
          )
        )
        (action_tile "accept"
          (vl-prin1-to-string
            (quote
              (progn
                (cond
                  ( (not ptr)
                    (_Popup "Information" 48 "Please Select a Reference to Load")
                  )
                  ( t
                    (setq item (nth (atoi ptr) lst))
                    (done_dialog)
                  )
                )
              )
            )
          )
        )
        (start_dialog)
      )
    )
    (list item lst)
  )
  
;;-------------------------------------------------------------------------------;;
;;                     --=={  String Replacement Engine  }==--                   ;;
;;-------------------------------------------------------------------------------;;

  (or (vl-bb-ref '*REX*)
      (vl-bb-set '*REX* (vlax-create-object "VBScript.RegExp")))

;;-------------------------------------------------------------------------------;;

  (defun _RegExReplace ( newstr pat string )
    (vlax-put    (vl-bb-ref '*REX*) 'Pattern pat)
    (vlax-put    (vl-bb-ref '*REX*) 'Global actrue)
    (vlax-put    (vl-bb-ref '*REX*) 'IgnoreCase acfalse)
    (vlax-invoke (vl-bb-ref '*REX*) 'Replace string newstr)
  )

;;-------------------------------------------------------------------------------;;

  (defun _RegExExecute ( pat string case / lst )
    (vlax-put    (vl-bb-ref '*REX*) 'Pattern pat)
    (vlax-put    (vl-bb-ref '*REX*) 'Global actrue)
    (vlax-put    (vl-bb-ref '*REX*) 'IgnoreCase (if case acfalse actrue))
    (vlax-for x  (vlax-invoke (vl-bb-ref '*REX*) 'Execute string)
      (setq lst
        (cons (list (vlax-get x 'Value) (vlax-get x 'FirstIndex)) lst)
      )
    )
    lst
  )

;;-------------------------------------------------------------------------------;;

  (defun _ReplaceText ( newstr oldstr str case whole / origstr oldlst lst s offset nlst res xstr replst origlen slashflag lbrace rbrace )
    
    ;; Temporarily replace literal backslashes with a unique string.
    ;; Literal backslashes are restored at end of function. By Steve Doman.
    (setq slashflag (strcat "<"  (substr (rtos (getvar "CDATE") 2 8) 14)  ">"))
    (setq str (_RegExReplace slashflag "\\\\\\\\" str))
    
    ;; Temporarily replace literal left curly brace.
    (setq lbrace    (strcat "<L" (substr (rtos (getvar "CDATE") 2 8) 14)  ">"))
    (setq str (_RegExReplace lbrace "\\\\{" str))
    
    ;; Temporarily replace literal right curly brace.
    (setq rbrace    (strcat "<"  (substr (rtos (getvar "CDATE") 2 8) 14) "R>"))
    (setq str (_RegExReplace rbrace "\\\\}" str))
        
    ;; Replace linefeeds using this format "\n" with the AutoCAD
    ;; standard format "\P". The "\n" format occurs when text is
    ;; copied to ACAD from some other application.
    
    (setq str  (_RegExReplace "\\P" "\\n" str) origstr str
          nlst (vl-string->list oldstr)
    )
    
    (foreach x (cdr (reverse nlst))
      (setq oldlst (cons x (cons 208 (cons 42 oldlst))))
    )

    (setq oldlst (append oldlst (list (last nlst)))
          oldstr (vl-list->string oldlst)
    )
    
    ;; oblique formatting in an mtext object
    (setq lst (_RegExExecute "\\\\Q[-]?[0-9]*?[.]?[0-9]+;" str t)
          ;; height
          lst (append lst (_RegExExecute "\\\\H[0-9]?[.]?[0-9]+x;" str t))
          ;; color
          lst (append lst (_RegExExecute "\\\\[Cc][0-9]?[.]?[0-9]+;" str t))
          ;; alignment
          lst (append lst (_RegExExecute "\\\\A[012];" str t))
          ;; font
          lst (append lst (_RegExExecute  "\\\\[Ff].*?;" str t))
          ;; overline
          lst (append lst (_RegExExecute "\\\\[Oo]" str t))
          ;; underline
          lst (append lst (_RegExExecute "\\\\[Ll]" str t))
          ;; width
          lst (append lst (_RegExExecute "\\\\W[0-9]?[.]?[0-9]+;" str t))
          ;; tracking
          lst (append lst (_RegExExecute "\\\\T[0-9]?[.]?[0-9]+;" str t))
          ;; stacking
          lst (append lst (_RegExExecute "\\\\S.*?;" str t))
          ;; linefeed
          lst (append lst (_RegExExecute "\\\\P" str t))
          ;; paragraph
          lst (append lst (_RegExExecute "\\\\p.*?;" str t))
          ;; tabs
          ;; from StripFormat
          ;; lst (append lst (_RegExExecute "\\\\P\\t|[0-9]+;\\t" str))
          lst (append lst (_RegExExecute "\\\\P\\t|[0-9]+;\\t|\\t" str t))
          ;; underline and overline formatting in a text object
          lst (append lst (_RegExExecute "%%[uUoO]" str t))
    )
        
    ;; Replace formatting codes with (chr 208) within str.
    (foreach x lst
      (setq str (vl-string-subst (_RegExReplace (chr 208) "(.)" (car x)) (car x) str (cadr x)))
    )
    
    ;; Replace curly braces with (chr 208) within str.
    (setq str (_RegExReplace (chr 208) "{|}" str))

    (foreach pattern '("\\\\" "\\^" "\\$" "\\+" "\\?" "\\." "\\(" "\\)" "\\|" "\\{" "\\}" "\\," "\\[" "\\]")
      (setq oldstr (_RegExReplace pattern pattern oldstr))
    )
    (setq oldstr (_RegExReplace "$1\\*" "([^Ð]|^)\\*" oldstr))
    
    (foreach x (reverse (_RegExExecute (if whole (strcat "\\b" oldstr "\\b") oldstr) str case))
      (setq xstr   (substr origstr (1+ (cadr x)) (strlen (car x)))
            replst (cons (list xstr (cadr x)) replst)
      )
    )
    
    (setq origlen (strlen origstr)
          offset  0
    )    
    (foreach x (reverse replst)
      (setq *ReplaceFlag* T)
      (setq res (vl-string-subst newstr (car x) origstr (+ offset (cadr x)))
            origstr res
            offset (- (strlen res) origlen)
      )
    )
    (if (not res) (setq res origstr))
    (setq res (_RegExReplace "\\\\" slashflag res)
          res (_RegExReplace "\\{"     lbrace res)
          res (_RegExReplace "\\}"     rbrace res)
    )
  )

;;-------------------------------------------------------------------------------;;

  (defun _Replace ( replacements string case whole )
    (foreach x replacements
      (setq string (_ReplaceText (cdr x) (car x) string case whole))
    )
    string
  )

;;-------------------------------------------------------------------------------;;

  (defun _ReplaceObject ( dwg obj lst bit lkl rep / nme os ns )
    (setq nme (vla-get-Objectname obj))
    (cond
      (
        (not
          (and (= 2 (logand 2 bit))
            (vl-position (strcase (vla-get-layer obj)) lkl)
          )
        )
        (cond
          (
            (and
              (eq "AcDbBlockReference" nme)
              (eq :vlax-true (vla-get-HasAttributes obj))
              (= 32 (logand 32 bit))
            )
            (foreach att (vlax-invoke obj 'GetAttributes)
              (if
                (not
                  (eq
                    (setq os (_GetTextString att))
                    (setq ns (_Replace lst os (= 1 (logand 1 bit)) (= 4 (logand 4 bit))))
                  )
                )
                (progn
                  (setq ReportLst
                    (cons
                      (list dwg os ns "Attribute" (vl-prin1-to-string (vla-get-Handle att)) (vla-get-TagString att))
                      ReportLst
                    )
                  )
                  (if rep
                    (progn
                      (vla-put-InsertionPoint att (vlax-3D-point (_CalcInsPt att ns)))
                      (vla-put-TextString att ns)
                    )
                  )
                )
              )
            )
          )
          (
            (and
              (wcmatch (strcase nme) "*DIMENSION*")
              (= 64 (logand 64 bit))
            )
            (if
              (and (not (eq "" (setq os (_GetTextString obj))))
                (not
                  (eq os
                    (setq ns (_Replace lst os (= 1 (logand 1 bit)) (= 4 (logand 4 bit))))
                  )
                )
              )
              (progn
                (setq ReportLst
                  (cons
                    (list dwg os ns "Dimension" (vl-prin1-to-string (vla-get-Handle obj)))
                    ReportLst
                  )
                )
                (if rep (vla-put-TextOverride obj ns))
              )
            )
          )
          (
            (or
              (and
                (eq "AcDbMText" nme)
                (= 16 (logand 16 bit))
              )
              (and
                (eq "AcDbText" nme)
                (= 8 (logand 8 bit))
              )
              (and
                (eq "AcDbMLeader" nme)
                (= 128 (logand 128 bit))
              )
            )
            (if
              (not
                (eq
                  (setq os (_GetTextString obj))
                  (setq ns (_Replace lst os (= 1 (logand 1 bit)) (= 4 (logand 4 bit))))
                )
              )
              (progn
                (setq ReportLst
                  (cons
                    (list dwg os ns
                      (cdr
                        (assoc nme
                         '(
                            ("AcDbMText"   . "MText")
                            ("AcDbText"    . "Text")
                            ("AcDbMLeader" . "Multileader")
                          )
                        )
                      )
                      (vl-prin1-to-string (vla-get-Handle obj))
                    )
                    ReportLst
                  )
                )
                (if rep (vla-put-TextString obj ns))
              )
            )
          )
          (
            (and
              (eq "AcDbTable" nme)
              (= 256 (logand 256 bit))
            )
            (
              (lambda ( row )
                (while (not (minusp (setq row (1- row))))
                  (
                    (lambda ( column )
                      (while (not (minusp (setq column (1- column))))
                        (if
                          (not
                            (eq
                              (setq os (vla-GetText obj row column))
                              (setq ns (_Replace lst os (= 1 (logand 1 bit)) (= 4 (logand 4 bit))))
                            )
                          )
                          (progn
                            (setq ReportLst
                              (cons
                                (list dwg os ns "Table" (vl-prin1-to-string (vla-get-Handle obj)))
                                ReportLst
                              )
                            )
                            (if rep (vla-SetText obj row column ns))
                          )
                        )
                      )
                    )
                    (vla-get-Columns obj)
                  )
                )
              )
              (vla-get-Rows obj)
            )
          )
        )
      )
    )
  )

;;-------------------------------------------------------------------------------;;
;;                           --=={  Preliminaries  }==--                         ;;
;;-------------------------------------------------------------------------------;;

  (if (not (vl-file-directory-p (setq SavePath (_GetSavePath))))
    (progn
      (_Popup "Warning" 16 "Save Path not Valid")
      (exit)
    )
  )  
  
  (setq dcfname    (strcat SavePath "\\LMAC_BFind_V" VersionNumber ".dcl")
        cfgfname   (strcat SavePath "\\LMAC_BFind_V" VersionNumber ".cfg")
        savfname   (strcat SavePath "\\LMAC_BFind_SavedSearches_V2-0.txt")
        dctitle    (strcat "Batch Find & Replace V" (vl-string-translate "-" "." VersionNumber))
        dcopttitle "Options"
        dcedititle "Edit Entry"
  )
  
  (setq acapp (vlax-get-acad-object)
        acdoc (vla-get-ActiveDocument acapp)
        cdir  (vl-string-right-trim "\\" (getvar 'DWGPREFIX))
  )

  (vlax-for doc (vla-get-documents acapp)
    (setq doclst
      (cons
        (cons
          (strcase
            (if (eq "" (vla-get-fullname doc))
              (strcat (vl-string-right-trim "\\" (vla-get-path doc)) "\\" (vla-get-name doc))
              (vla-get-fullname doc)
            )
          )
          doc
        )
        doclst
      )
    )
  )
  
  (setq Express
    (and (vl-position "acetutil.arx" (arx))
      (not
        (vl-catch-all-error-p
          (vl-catch-all-apply
            (function (lambda nil (acet-sys-shift-down)))
          )
        )
      )
    )
  )

;;-------------------------------------------------------------------------------;;
;;                           --=={  Main Function  }==--                         ;;
;;-------------------------------------------------------------------------------;;
  
  ;; Option Bit-Codes

  ;  Match Case            =    1
  ;  Ignore Locked Layers  =    2
  ;  Whole Words Only      =    4
  ;  Single-line Text      =    8
  ;  Multiline Text        =   16
  ;  Block Attributes      =   32
  ;  Dimension Text        =   64
  ;  Multileader Text      =  128
  ;  Table Text            =  256
  ;  Generate Report       =  512
  ;  Block Definitions     = 1024
    
;;-------------------------------------------------------------------------------;;
;;                          --=={  Setup Defaults  }==--                         ;;
;;-------------------------------------------------------------------------------;;

  (setq SymList '(*BFind_lst* *BFind_pat* *BFind_cur* *BFind_opn* *BFind_sub* *BFind_opt* *BFind_ser* *BFind_whr*)
        ValList  (list 'nil cdir "0" "0" "1" (+ 1 8 16 32 64 128 256 512) "0" "0"))

  (or (findfile cfgfname)
      (_WriteConfig cfgfname ValList)
  )  
  (_ReadConfig cfgfname SymList)

  (mapcar '(lambda ( sym val ) (or (boundp sym) (set sym val))) SymList ValList)

  (setq SaveList (_ReadSearchItems savfname))

;;-------------------------------------------------------------------------------;;
  
  (cond
    ( (not (_WriteDCL dcfname))
      (_Popup "Warning" 16 "Dialog Definition File could not be Written")
      (princ "\n** DCL File Could not be Written **")
    )
    ( (<= (setq id (load_dialog dcfname)) 0)
      (_Popup "Warning" 16 "Dialog Definition File could not be Found")
      (princ "\n** DCL File could not be Found **")
    )
    ( t
      (while (not (member dcFlag '(1 0)))
        (cond
          ( (not (new_dialog "bfind" id))
            (_Popup "Warning" 16 "Batch Find Dialog could not be Loaded")
            (princ "\n** DCL could not be Loaded **")
            (setq dcFlag 0)
          )
          ( t

            (if fstr (set_tile "fstr" fstr))
            (if rstr (set_tile "rstr" rstr))

            (set_tile  "dcl_title"      dcTitle)
            (set_tile  "sub_dir"    *BFind_sub*)
            (set_tile  "search"     *BFind_ser*)

            (_Logo "logo")

            (_DirectoryText  "dir_text"
              (setq *BFind_pat*
                (vl-string-right-trim "\\"
                  (if (vl-file-directory-p *BFind_pat*) *BFind_pat* cdir)
                )
              )
            )
            (_DirectoryMode (set_tile "cur_dwg" *BFind_cur*) (set_tile "opn_dwg" *BFind_opn*))

            (if (eq (strcase *BFind_pat*) (strcase cdir))
              (set_tile "cur_dir" "1")
            )
            (_PopulateListBox "rep_list" *BFind_lst*)

            (action_tile "cur_dir"
              (vl-prin1-to-string
                (quote
                  (if (= "1" $value)
                    (_DirectoryText "dir_text" (setq *BFind_pat* cdir))
                  )
                )
              )
            )

            (action_tile "cur_dwg"
              (vl-prin1-to-string
                (quote
                  (progn
                    (if (eq "1" (setq *BFind_cur* $value))
                      (set_tile "opn_dwg" (setq *BFind_opn* "0"))
                    )
                    (_DirectoryMode *BFind_cur* *BFind_opn*)
                  )
                )
              )
            )

            (action_tile "opn_dwg"
              (vl-prin1-to-string
                (quote
                  (progn
                    (if (eq "1" (setq *BFind_opn* $value))
                      (set_tile "cur_dwg" (setq *BFind_cur* "0"))
                    )
                    (_DirectoryMode *BFind_cur* *BFind_opn*)
                  )
                )
              )
            )

            (action_tile "dir"
              (vl-prin1-to-string
                (quote
                  (progn
                    (if (setq tmp (_DirectoryDialog "Select Directory of Drawings to Process..." nil (+ 1 64 256)))
                      (progn
                        (_DirectoryText "dir_text" (setq *BFind_pat* tmp))
                        (if (eq (strcase *BFind_pat*) (strcase cdir))
                          (set_tile "cur_dir" "1")
                          (set_tile "cur_dir" "0")
                        )
                      )
                    )
                  )
                )
              )
            )

            (action_tile "sub_dir" "(setq *BFind_sub* $value)")
           
            (action_tile "fstr"
              (vl-prin1-to-string
                (quote
                  (progn
                    (setq fstr $value)
                    (if (= 1 $reason)
                      (cond
                        ( (or (not fstr) (eq "" fstr))
                          (_Popup "Information" 64 "Please Enter a String to Find")
                        )
                        ( (or rstr (setq rstr ""))
                          (mapcar 'set_tile '("fstr" "rstr") '("" ""))
                          (setq *BFind_lst*
                            (_PopulateListBox "rep_list"
                              (_SortByFirst (cons (cons fstr rstr) *BFind_lst*))
                            )
                          )
                          (setq fstr nil rstr nil)
                        )
                      )
                    )
                  )
                )
              )
            )
           
            (action_tile "rstr"
              (vl-prin1-to-string
                (quote
                  (progn
                    (setq rstr $value)
                    (if (= 1 $reason)
                      (cond
                        ( (or (not fstr) (eq "" fstr))
                          (_Popup "Information" 64 "Please Enter a String to Find")
                        )
                        ( (or rstr (setq rstr ""))
                          (mapcar 'set_tile '("fstr" "rstr") '("" ""))
                          (setq *BFind_lst*
                            (_PopulateListBox "rep_list"
                              (_SortByFirst (cons (cons fstr rstr) *BFind_lst*))
                            )
                          )
                          (setq fstr nil rstr nil)
                        )
                      )
                    )
                  )
                )
              )
            )
           
            (action_tile "search"  "(setq *BFind_ser* $value)")
            (action_tile "option"
              (vl-prin1-to-string
                (quote
                  (setq tmp         (_OptionsDialog id *BFind_opt* *BFind_whr*)
                        *BFind_opt* (car  tmp)
                        *BFind_whr* (cadr tmp)
                  )
                )
              )
            )

            (action_tile "add"
              (vl-prin1-to-string
                (quote
                  (progn
                    (cond
                      ( (or (not fstr) (eq "" fstr))
                        (_Popup "Information" 64 "Please Enter a String to Find")
                      )
                      ( (or rstr (setq rstr ""))
                        (mapcar 'set_tile '("fstr" "rstr") '("" ""))
                        (setq *BFind_lst*
                          (_PopulateListBox "rep_list"
                            (_SortByFirst (cons (cons fstr rstr) *BFind_lst*))
                          )
                        )
                        (setq fstr nil rstr nil)
                      )
                    )
                  )
                )
              )
            )         

            (action_tile "rem"
              (vl-prin1-to-string
                (quote
                  (progn
                    (if *BFind_lst*
                      (if (and ptr (listp (setq items (_value->list ptr))))
                        (setq *BFind_lst*
                          (_PopulateListBox "rep_list" 
                            (_SortByFirst (_RemoveItems items *BFind_lst*))
                          )
                          ptr nil
                        )
                        (_Popup "Information" 48 "Please Select an Entry from the List to Remove")
                      )
                      (_Popup "Information" 64 "No Entries Found to Remove")
                    )
                  )
                )
              )
            )

            (action_tile "rep_list"
              (vl-prin1-to-string
                (quote
                  (progn
                    (setq ptr $value)
                    (if (and (= 4 $reason) (setq ptr (car (_value->list ptr))))
                      (progn
                        (_PopulateListBox "rep_list"
                          (setq *BFind_lst*
                            (_SortByFirst
                              (_SubstAtN *BFind_lst*
                                (_EntryEdit id (nth ptr *BFind_lst*)) ptr
                              )
                            )
                          )
                        )
                        (set_tile "rep_list" (setq ptr (itoa ptr)))
                      )
                    )
                  )
                )
              )
            )

            (action_tile "clr" "(_PopulateListBox \"rep_list\" (setq *BFind_lst* nil))")

            (action_tile "save"
              (vl-prin1-to-string
                (quote
                  (progn
                    (cond
                      ( (null *BFind_lst*)
                        (_Popup "Information" 48 "Please Enter a Search Item to Save")
                      )
                      ( (setq ref (_SaveDialog id (mapcar 'car SaveList)))
                        (setq SaveList
                          (if (assoc ref SaveList)
                            (subst (cons ref *BFind_lst*) (assoc ref SaveList) SaveList)
                            (cons  (cons ref *BFind_lst*) SaveList)
                          )
                        )
                        (_Popup "Information" 64 "Search Items Saved.")
                      )
                    )
                  )
                )
              )
            )

            (action_tile "load"
              (vl-prin1-to-string
                (quote
                  (progn
                    (cond
                      ( (null SaveList)
                        (_Popup "Information" 48 "No Saved Searches Found")
                      )
                      ( (setq ref (_LoadDialog id (mapcar 'car SaveList)))
                        (setq SaveList
                          (vl-remove-if-not
                            (function
                              (lambda ( x ) (member (car x) (cadr ref)))
                            )
                            SaveList
                          )
                        )
                        (if (car ref)
                          (_PopulateListBox "rep_list"
                            (setq *BFind_lst*
                              (_SortByFirst
                                (cdr
                                  (assoc (car ref) SaveList)
                                )
                              )
                            )
                          )
                        )
                      )
                    )
                  )
                )
              )
            )     

            (action_tile "fpick" "(done_dialog 2)")
            (action_tile "rpick" "(done_dialog 3)")

            (action_tile "accept"
              (vl-prin1-to-string
                (quote
                  (progn
                    (cond
                      ( (not *BFind_lst*)
                        (_Popup "Information" 48 "Please Add an Entry to the List")
                      )
                      ( t
                        (done_dialog 1)
                      )
                    )
                  )
                )
              )
            )
          
            (action_tile "cancel" "(done_dialog 0)")
            (setq dcFlag (start_dialog))
          )
        )

        (if (member dcFlag '(2 3))
          (
            (lambda ( / e )
              (while
                (progn (setvar 'ERRNO 0) (setq e (car (nentsel "\nSelect Object: ")))
                  (cond
                    ( (= 7 (getvar 'ERRNO))
                      (princ "\nMissed, Try Again.")
                    )
                    ( (eq 'ENAME (type e))
                      (if (wcmatch (cdr (assoc 0 (entget e))) "ATTRIB,TEXT,MTEXT,MULTILEADER")
                        (not
                          (set
                            (if (= 2 dcFlag) 'fstr 'rstr) (_GetTextString e)
                          )
                        )
                        (princ "\nObject Must Contain Text.")
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )

      (setq id (unload_dialog id))
      (_WriteSearchItems savfname SaveList)

;;-------------------------------------------------------------------------------;;

      (if (= 1 dcFlag)
        (progn
          (_StartUndo acdoc)
          (princ "\nWorking, Please Wait...") (princ)

          (setq dbdoc (_ObjectDBXDocument acapp))

          (setq dwLst
            (cond
              ( (eq "1" *BFind_cur*)
                (list
                  (cond
                    ( (eq "" (vla-get-FullName acdoc))
                      (strcat (vl-string-right-trim "\\" (vla-get-Path acdoc)) "\\" (vla-get-Name acdoc))
                    )
                    ( (vla-get-FullName acdoc) )
                  )
                )
              )
              ( (eq "1" *BFind_opn*)
                (vlax-for doc (vla-get-documents acapp)
                  (setq dwlst
                    (cons
                      (if (eq "" (vla-get-fullname doc))
                        (strcat (vl-string-right-trim "\\" (vla-get-path doc)) "\\" (vla-get-name doc))
                        (vla-get-fullname doc)
                      )
                      dwlst
                    )
                  )
                )
                dwlst
              )
              ( t
                (_GetAllFiles *BFind_pat* (eq "1" *BFind_sub*) "*.dwg")
              )
            )
          )

          (if Express
            (setq ProgBar (acet-ui-progress "Performing Replacement..." (length dwLst)))
          )
          (foreach dwg dwLst
            
            (setq *ReplaceFlag* nil)
            (princ ".")
            (if Express (acet-ui-progress -1))
            
            (if
              (setq doc
                (cond
                  ( (eq "1" *BFind_cur*)
                    acdoc
                  )
                  ( (cdr (assoc (strcase dwg) DocLst))
                  )
                  ( (not (vl-catch-all-error-p (vl-catch-all-apply 'vla-open (list dbdoc dwg))))
                    dbdoc
                  )
                )
              )
              (if
                (vl-catch-all-error-p
                  (setq err
                    (vl-catch-all-apply
                      (function
                        (lambda ( / lckd lckl dwgn )
                          (setq lckd (_UnlockLayers doc)
                                lckl (mapcar '(lambda ( l ) (strcase (vla-get-name l))) lckd)
                                dwgn (strcat (vl-filename-base dwg) ".dwg")
                          )
                          (vlax-for lay (vla-get-Layouts doc)
                            (if
                              (or
                                (eq "0" *BFind_whr*)
                                (and (eq "1" *BFind_whr*) (eq "MODEL" (strcase (vla-get-name lay))))
                                (and (eq "2" *Bfind_whr*) (not (eq "MODEL" (strcase (vla-get-name lay)))))
                              )
                              (vlax-for obj (vla-get-Block lay)
                                (_ReplaceObject dwgn obj *BFind_lst* *BFind_opt* lckl (eq "0" *BFind_ser*))
                              )
                            )
                          )
                          (if (= 1024 (logand 1024 *BFind_opt*))
                            (vlax-for blk (vla-get-blocks doc)
                              (if
                                (and
                                  (eq :vlax-false (vla-get-islayout blk))
                                  (eq :vlax-false (vla-get-isxref blk))
                                  (not (wcmatch (vla-get-name blk) "`*D*"))
                                )
                                (vlax-for obj blk
                                  (_ReplaceObject dwgn obj *BFind_lst* *BFind_opt* lckl (eq "0" *BFind_ser*))
                                )
                              )
                            )
                          )
                          (_LockLayers lckd)
                          (if
                            (and *ReplaceFlag* (eq "0" *BFind_ser*)
                              (not
                                (and
                                  (vlax-property-available-p doc 'FullName)
                                  (eq "" (vla-get-FullName doc))
                                )
                              )
                            )
                            (vla-saveas doc dwg)
                          )
                        )
                      )
                    )
                  )
                )
                (princ
                  (strcat
                    "\n** Error Processing Drawing: " (vl-filename-base dwg) ".dwg **"
                    "\n** Error Detail: " (vl-catch-all-error-message err) " **"
                  )
                )
              )
              (princ (strcat "\n** Error Opening File: " (vl-filename-base dwg)  ".dwg **"))
            )
          )
          (if Express (setq ProgBar (acet-ui-progress)))

          (if
            (and
              (eq "1" *BFind_cur*)
              (= 1024 (logand 1024 *BFind_opt*))
            )
            (vla-regen acdoc acallviewports)
          )

        ;;-------------------------------------------------------------------------------;;

          (princ (strcat "\n<< " (itoa (length dwLst)) " Drawings Processed >>"))

          (if ReportLst
            (if
              (and (or (eq "1" *BFind_ser*) (= 512 (logand 512 *BFind_opt*)))
                (_GenerateReport (setq rname (strcat *BFind_pat* "\\BFindReport" (_FormatDate "YYYYMODD") ".csv"))
                  (vl-sort
                    (vl-sort ReportLst
                      (function
                        (lambda ( a b ) (< (cadddr a) (cadddr b)))
                      )
                    )
                    (function (lambda ( a b ) (< (car a) (car b))))
                  )
                )
              )
              (if (null (_OpenFile rname))
                (princ "\n--> Error Opening Report.")
              )
            )
            (princ "\n<< No Replacements Made >>")
          )
          (_WriteConfig cfgfname (mapcar 'eval SymList))
          (_EndUndo acdoc)
        )
        (princ "\n*Cancel*")
      )
      (mapcar '_ReleaseObject (list dbdoc doc))
      (_ReleaseObject (vl-bb-ref '*REX*))
      (vl-bb-set '*REX* nil)
      (gc) (gc) (gc)
    )
  )
  (princ)
)

;;-------------------------------------------------------------------------------;;

(vl-load-com)
(princ)
(princ "\n:: BFind.lsp | Version 2.0 | © Lee Mac 2011 www.lee-mac.com ::")
(princ "\n:: Type \"BFind\" to Invoke ::")
(princ)

;;-------------------------------------------------------------------------------;;
;;                                  End of File                                  ;;
;;-------------------------------------------------------------------------------;;