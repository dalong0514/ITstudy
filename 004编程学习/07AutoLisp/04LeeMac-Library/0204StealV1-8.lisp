;;-----------------------------------------=={ Steal }==-----------------------------------------;;
;;                                                                                               ;;
;;                                                                                               ;;
;;                       --------------------------------------------------                      ;;
;;                                        Program Overview                                       ;;
;;                       --------------------------------------------------                      ;;
;;                                                                                               ;;
;;  Allows the user to import (humourously: 'steal') items from another drawing into the active  ;;
;;  drawing.                                                                                     ;;
;;                                                                                               ;;
;;  Upon running the program with 'Steal' at the AutoCAD command-line, the user is prompted to   ;;
;;  select a drawing to steal from (dwg/dwt/dws). Upon selection, if the selected drawing        ;;
;;  contains items not already present in the current drawing, a dialog will appear detailing    ;;
;;  items available for import.                                                                  ;;
;;                                                                                               ;;
;;  The user may choose multiple items from a list of:                                           ;;
;;                                                                                               ;;
;;    -  Blocks                                                                                  ;;
;;    -  Layers                                                                                  ;;
;;    -  Linetypes                                                                               ;;
;;    -  Dimension Styles                                                                        ;;
;;    -  Text Styles                                                                             ;;
;;    -  Table Styles                                                                            ;;
;;    -  MLeader Styles                                                                          ;;
;;    -  MLine Styles                                                                            ;;
;;    -  Layouts                                                                                 ;;
;;    -  Page Setups                                                                             ;;
;;    -  User Coordinate Systems                                                                 ;;
;;    -  Groups                                                                                  ;;
;;    -  Views                                                                                   ;;
;;    -  Layer States                                                                            ;;
;;    -  Scales                                                                                  ;;
;;    -  Materials                                                                               ;;
;;    -  Viewports                                                                               ;;
;;    -  Drawing Properties                                                                      ;;
;;    -  Custom Properties                                                                       ;;
;;                                                                                               ;;
;;  The above collections are listed in the left-hand list panel of the dialog, and items        ;;
;;  within each selected collection are listed to the right.                                     ;;
;;                                                                                               ;;
;;  The user may import multiple items from several collections without exiting or restarting    ;;
;;  the program, since the dialog will remain until either the user presses the 'Done' button,   ;;
;;  or there is nothing left to import from the selected drawing.                                ;;
;;                                                                                               ;;
;;  The user may update the data displayed in the dialog by pressing the 'Refresh' button        ;;
;;  located in the top-left corner of the dialog. This may be required when importing such       ;;
;;  items as blocks since layers, linetypes, and other block definitions dependent upon the      ;;
;;  constituent objects of the imported block may also be imported to the active drawing.        ;;
;;                                                                                               ;;
;;  The user may also search the collections for a specific item to import using the search      ;;
;;  panel to the bottom of the dialog. The search is not case-sensitive and may use wildcards.   ;;
;;                                                                                               ;;
;;                                                                                               ;;
;;                       --------------------------------------------------                      ;;
;;                                       Available Commands                                      ;;
;;                       --------------------------------------------------                      ;;
;;                                                                                               ;;
;;  Steal                                                                                        ;;
;;  --------------------------------------                                                       ;;
;;  The standard program. The user is prompted to select a drawing file (dwg/dwt/dws) and may    ;;
;;  proceed to select from a list of items  to import to the active drawing.                     ;;
;;                                                                                               ;;
;;                                                                                               ;;
;;  Steal All                                                                                    ;;
;;  --------------------------------------                                                       ;;
;;  The program may also be called with the command 'StealAll' which will prompt the user to     ;;
;;  select a drawing file then proceed to automatically steal everything from the selected       ;;
;;  drawing.                                                                                     ;;
;;                                                                                               ;;
;;                                                                                               ;;
;;  Steal Template                                                                               ;;
;;  --------------------------------------                                                       ;;
;;  Another command: 'StealTemplate' will attempt to locate and interface with the QNew          ;;
;;  template file, or, if the QNew template is not set, will allow the user to select from a     ;;
;;  list of template files residing in the template drawing path. If no template files are       ;;
;;  found, the file selection dialog will appear as per the standard command.                    ;;
;;                                                                                               ;;
;;                                                                                               ;;
;;  Steal Templates                                                                              ;;
;;  --------------------------------------                                                       ;;
;;  The 'StealTemplates' command allows the user to import items from a specific template file   ;;
;;  selected from a list of template files found in the template drawing path. If no template    ;;
;;  files are found, the file selection dialog will appear as per the standard command.          ;;
;;                                                                                               ;;
;;                                                                                               ;;
;;  Steal Last                                                                                   ;;
;;  --------------------------------------                                                       ;;
;;  The 'StealLast' command allows the user to steal items from the last selected drawing, if    ;;
;;  a last drawing exists and can be located, else the user is prompted to select a drawing as   ;;
;;  per the standard command.                                                                    ;;
;;                                                                                               ;;
;;                                                                                               ;;
;;                       --------------------------------------------------                      ;;
;;                              Calling the Program as a Subfunction                             ;;
;;                       --------------------------------------------------                      ;;
;;                                                                                               ;;
;;  The program may also be called with optional parameters so that users may bypass the dialog  ;;
;;  interface or file selection dialog, or perhaps call the function from other programs or      ;;
;;  from an ACADDOC.lsp to import items automatically.                                           ;;
;;                                                                                               ;;
;;  Function Format:                                                                             ;;
;;  --------------------------------------                                                       ;;
;;                                                                                               ;;
;;      (Steal <dwg> <lst>)                                                                      ;;
;;                                                                                               ;;
;;  Arguments:                                                                                   ;;
;;  --------------------------------------                                                       ;;
;;                                                                                               ;;
;;   -  dwg  [STR]  [Optional]                                                                   ;;
;;      ----------------------------------                                                       ;;
;;      The full filename of the drawing from which items are to be imported.                    ;;
;;                                                                                               ;;
;;   -  lst  [LIST]  [Optional]                                                                  ;;
;;      ----------------------------------                                                       ;;
;;      A list of items to be imported, in the following format:                                 ;;
;;                                                                                               ;;
;;      (                                                                                        ;;
;;          (                                                                                    ;;
;;              <Collection 1>                                                                   ;;
;;              (<Item 1> <Item 2>  ...  <Item N>)                                               ;;
;;          )                                                                                    ;;
;;          (   <Collection 2>                                                                   ;;
;;              (<Item 1> <Item 2>  ...  <Item N>)                                               ;;
;;          )                                                                                    ;;
;;          ...                                                                                  ;;
;;          (   <Collection N>                                                                   ;;
;;              (<Item 1> <Item 2>  ...  <Item N>)                                               ;;
;;          )                                                                                    ;;
;;      )                                                                                        ;;
;;                                                                                               ;;
;;      Where 'Collection' is the name of a collection of items, and may be one of:              ;;
;;                                                                                               ;;
;;           "Blocks"                                                                            ;;
;;           "Layers"                                                                            ;;
;;           "Linetypes"                                                                         ;;
;;           "Text Styles"                                                                       ;;
;;           "Dimension Styles"                                                                  ;;
;;           "Layouts"                                                                           ;;
;;           "Views"                                                                             ;;
;;           "Materials"                                                                         ;;
;;           "Viewports"                                                                         ;;
;;           "Page Setups"                                                                       ;;
;;           "User Coordinate Systems"                                                           ;;
;;           "Groups"                                                                            ;;
;;           "Drawing Properties"                                                                ;;
;;           "Custom Properties"                                                                 ;;
;;           "Multileader Styles"                                                                ;;
;;           "Multiline Styles"                                                                  ;;
;;           "Table Styles"                                                                      ;;
;;           "Scales"                                                                            ;;
;;           "Layer States"                                                                      ;;
;;                                                                                               ;;
;;      Note that the collection keyword is *not* case-sensitive.                                ;;
;;                                                                                               ;;
;;      'Item 1' ... 'Item N' are the names of specific items or wildcard patterns to match a    ;;
;;      number of items to be imported into the current drawing.                                 ;;
;;                                                                                               ;;
;;      Note that these are also *not* case-sensitive.                                           ;;
;;                                                                                               ;;
;;                                                                                               ;;
;;                       --------------------------------------------------                      ;;
;;                                           Examples                                            ;;
;;                       --------------------------------------------------                      ;;
;;                                                                                               ;;
;;  The following example will attempt to import Layers: 'Layer1' & 'Layer2', and all Dimension  ;;
;;  Styles beginning with 'DimStyle' (not case-sensitive) from the drawing:                      ;;
;;  'C:\My Folder\MyDrawing.dwg' into the current drawing.                                       ;;
;;                                                                                               ;;
;;  (Steal "C:\\My Folder\\MyDrawing.dwg"                                                        ;;
;;     '(                                                                                        ;;
;;          (                                                                                    ;;
;;              "Layers"                                                                         ;;
;;              ("Layer1" "Layer2")                                                              ;;
;;          )                                                                                    ;;
;;          (                                                                                    ;;
;;              "Dimension Styles"                                                               ;;
;;              ("DimStyle*")                                                                    ;;
;;          )                                                                                    ;;
;;      )                                                                                        ;;
;;  )                                                                                            ;;
;;                                                                                               ;;
;;  Note that both arguments are optional, hence the program may be called...                    ;;
;;                                                                                               ;;
;;  (Steal nil                                                                                   ;;
;;     '(                                                                                        ;;
;;          (                                                                                    ;;
;;              "Layers"                                                                         ;;
;;              ("Layer1" "Layer2")                                                              ;;
;;          )                                                                                    ;;
;;          (                                                                                    ;;
;;              "Dimension Styles"                                                               ;;
;;              ("DimStyle*")                                                                    ;;
;;          )                                                                                    ;;
;;      )                                                                                        ;;
;;  )                                                                                            ;;
;;                                                                                               ;;
;;  ...to prompt for a drawing from which to extract specific items, or...                       ;;
;;                                                                                               ;;
;;  (Steal "C:\\My Folder\\MyDrawing.dwg" nil)                                                   ;;
;;                                                                                               ;;
;;  ...to prompt for items to extract from a specific drawing.                                   ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;;                                                                                               ;;
;;  Function Syntax:                                                                             ;;
;;                                                                                               ;;
;;      Steal                                                                                    ;;
;;      StealAll                                                                                 ;;
;;      StealTemplate                                                                            ;;
;;      StealTemplates                                                                           ;;
;;      StealLast                                                                                ;;
;;      (Steal <dwg> <lst>)                                                                      ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;;                                                                                               ;;
;;  Author:                                                                                      ;;
;;                                                                                               ;;
;;  Copyright © 2012 Lee Mac  -  www.lee-mac.com                                                 ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;;                                                                                               ;;
;;  TERMS AND CONDITIONS OF USE                                                                  ;;
;;                                                                                               ;;
;;  This license and disclaimer statement constitutes a legal agreement between you (either as   ;;
;;  an individual or a single entity) and Lee Mac (the "Author"), for this software product      ;;
;;  (the "Software").                                                                            ;;
;;                                                                                               ;;
;;  By downloading, installing, copying, or otherwise using the software, you agree to be bound  ;;
;;  by all of the following terms and conditions of this license and disclaimer agreement.       ;;
;;                                                                                               ;;
;;  If you do not agree with all the terms and conditions of this agreement, you must            ;;
;;  immediately cease use of the Software and destroy all copies of the Software and all of its  ;;
;;  component or constituent parts in your possession or under your control.                     ;;
;;                                                                                               ;;
;;  The Software is freeware. You may use it royalty free for private use.                       ;;
;;                                                                                               ;;
;;  You may redistribute the Software providing you have written consent from the Author, and    ;;
;;  that no modifications are made to the original content.                                      ;;
;;                                                                                               ;;
;;  You may not charge any fees for the redistribution or use of this Software.                  ;;
;;                                                                                               ;;
;;  The Software is provided "as is", and with all faults. All warranties, expressed or implied, ;;
;;  including, but not limited to implied warranties of fitness for a particular use or purpose  ;;
;;  are hereby disclaimed. There is no guarantee that the operation of this Software will be     ;;
;;  uninterrupted or error free.                                                                 ;;
;;                                                                                               ;;
;;  You acknowledge and agree that your use of the Software is at your own risk.                 ;;
;;                                                                                               ;;
;;  The Software is a copyrighted work and is protected by copyright law and international       ;;
;;  copyright treaty.                                                                            ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;;                                                                                               ;;
;;  Version History:                                                                             ;;
;;  --------------------------------------                                                       ;;
;;                                                                                               ;;
;;  1.0:  16/01/2011  -  First Release.                                                          ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;;                                                                                               ;;
;;  1.1:  16/01/2011  -  Added Layouts & Page Setups to list of Collections.                     ;;
;;                    -  Added ability to import multiple items until dialog is closed.          ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;;                                                                                               ;;
;;  1.2:  18/01/2011  -  Omitted XRef items from collection lists.                               ;;
;;                    -  Added Search bar to search for specific items.                          ;;
;;                    -  Added Named Views & UCS to list of collections.                         ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;;                                                                                               ;;
;;  1.3:  18/01/2011  -  Accounted for Nested blocks.                                            ;;
;;                    -  Added LayerStates to list of collections.                               ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;;                                                                                               ;;
;;  1.4:  19/01/2011  -  Added dwt/dws compatibility.                                            ;;
;;                    -  Added command-line functionality.                                       ;;
;;                    -  Added Scales to list of collections.                                    ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;;                                                                                               ;;
;;  1.5:  07/09/2011  -  Added ability to use Wildcard patterns in lst argument to import all    ;;
;;                       items matching the pattern.                                             ;;
;;                    -  Added Materials & Viewports to list of collections.                     ;;
;;                    -  Added 'StealAll' command to quickly steal everything from a drawing.    ;;
;;                    -  Added 'StealTemplate' command to quickly steal items from the           ;;
;;                       QNewTemplate or other Template file.                                    ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;;                                                                                               ;;
;;  1.6:  29/04/2012  -  Fixed bug causing the program to crash for versions in which some       ;;
;;                       collections are not available.                                          ;;
;;                    -  Expanded program header and removed local functions to improve program  ;;
;;                       performance.                                                            ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;;                                                                                               ;;
;;  1.7:  16/09/2012  -  Steal file selection dialog will now remember the directory of the      ;;
;;                       last selected drawing between drawing sessions.                         ;;
;;                    -  Main error handler completely rewritten.                                ;;
;;                    -  'ItemList' parameter renamed to 'lst' and parameter list structure      ;;
;;                       modified to separate items from collection keywords.                    ;;
;;                    -  Added Groups to list of collections.                                    ;;
;;                    -  Added Drawing Properties to list of collections.                        ;;
;;                    -  Added Custom Properties to list of collections.                         ;;
;;                    -  Incorporated a 'Refresh' button to enable the user to refresh the       ;;
;;                       drawing data upon importing items such as blocks with object            ;;
;;                       dependencies (e.g. layers, linetypes, nested blocks).                   ;;
;;                    -  Exchanged 'Search' button for an appropriate bitmap icon and replaced   ;;
;;                       alert dialogs with dialog error tile.                                   ;;
;;                    -  'StealTemplate' command rewritten to call new 'StealTemplates' command  ;;
;;                       if the QNew template is not available.                                  ;;
;;                    -  Added 'StealTemplates' command to allow the user to import items from   ;;
;;                       a selected template file from the template drawing path.                ;;
;;                    -  Added 'StealLast' command to allow the user to steal from the last      ;;
;;                       selected drawing, if available.                                         ;;
;;                    -  Implemented a workaround to overcome a bug pertaining to deep-cloning   ;;
;;                       Plot Configuration objects using the CopyObjects method wherein the     ;;
;;                       associated entry in the ACAD_PLOTSETTINGS dictionary becomes anonymous. ;;
;;                    -  Majority of program rewritten to improve code performance and           ;;
;;                       readability.                                                            ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;;                                                                                               ;;
;;  1.8:  18/09/2012  -  Fixed bug causing the program to error when all items in a collection   ;;
;;                       are deselected using the Ctrl key, and the 'Import' button is pressed.  ;;
;;                    -  The active drawing will now only be regenerated after program           ;;
;;                       completion when one or more items have been imported.                   ;;
;;                                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;

(setq stealversionnumber "1.8")

;;-----------------------------------------------------------------------------------------------;;
;;                                        Program Commands                                       ;;
;;-----------------------------------------------------------------------------------------------;;

;;-----------------------------------------------------------------------------------------------;;
;; Steal                                                                                         ;;
;;-----------------------------------------------------------------------------------------------;;
;; Standard program. User is prompted to select a drawing and then select from a list of items   ;;
;; to import to the active drawing.                                                              ;;
;;-----------------------------------------------------------------------------------------------;;

(defun c:Steal nil (Steal nil nil))

;;-----------------------------------------------------------------------------------------------;;
;; Steal All                                                                                     ;;
;;-----------------------------------------------------------------------------------------------;;
;; Will import everything from the selected drawing.                                             ;;
;;-----------------------------------------------------------------------------------------------;;

(defun c:StealAll nil
    (Steal nil
       '(
            ("Blocks"                  ("*"))
            ("Layers"                  ("*"))
            ("Linetypes"               ("*"))
            ("Text Styles"             ("*"))
            ("Dimension Styles"        ("*"))
            ("Layouts"                 ("*"))
            ("Views"                   ("*"))
            ("Materials"               ("*"))
            ("Viewports"               ("*"))
            ("Page Setups"             ("*"))
            ("User Coordinate Systems" ("*"))
            ("Groups"                  ("*"))
            ("Drawing Properties"      ("*"))
            ("Custom Properties"       ("*"))
            ("Multileader Styles"      ("*"))
            ("Multiline Styles"        ("*"))
            ("Table Styles"            ("*"))
            ("Scales"                  ("*"))
            ("Layer States"            ("*"))
        )
    )
)

;;-----------------------------------------------------------------------------------------------;;
;; Steal Template                                                                                ;;
;;-----------------------------------------------------------------------------------------------;;
;; Allows the user to import items from the QNew Template if present, else prompts user to       ;;
;; select a template from the template drawing path.                                             ;;
;;-----------------------------------------------------------------------------------------------;;

(defun c:StealTemplate ( / tmp )
    (if (= ""
            (setq tmp
                (vla-get-qnewtemplatefile
                    (vla-get-files
                        (vla-get-preferences (vlax-get-acad-object))
                    )
                )
            )
        )
        (c:StealTemplates)
        (Steal tmp nil)
    )
)

;;-----------------------------------------------------------------------------------------------;;
;; Steal Templates                                                                               ;;
;;-----------------------------------------------------------------------------------------------;;
;; Allows the user to import items from a selected template from the template drawing path.      ;;
;;-----------------------------------------------------------------------------------------------;;

(defun c:StealTemplates ( / pth tmp )
    (if (setq tmp
            (vl-directory-files
                (setq pth
                    (vla-get-templatedwgpath
                        (vla-get-files
                            (vla-get-preferences (vlax-get-acad-object))
                        )
                    )
                )
                "*.dwt" 1
            )
        )
        (if (setq tmp (car (steal:listbox "Select Template File" tmp)))
            (Steal (strcat (vl-string-right-trim "\\" pth) "\\" tmp) nil)
            (princ "\n*Cancel*")
        )
        (Steal nil nil)
    )
    (princ)
)

;;-----------------------------------------------------------------------------------------------;;
;; Steal Last                                                                                    ;;
;;-----------------------------------------------------------------------------------------------;;
;; Allows the user to import items from the last selected drawing, if possible.                  ;;
;;-----------------------------------------------------------------------------------------------;;

(defun c:StealLast nil
    (Steal
        (if (setq dwg (getenv "LMac\\StealLast"))
            (findfile dwg)
        )
        nil
    )
)

;;-----------------------------------------------------------------------------------------------;;
;;                                      Steal Subfunction                                        ;;
;;-----------------------------------------------------------------------------------------------;;

(defun Steal

    (
        dwg
        lst

        /

        *error*
        _search
        acdata
        acdic
        acdoc
        acext
        cln
        col
        collection
        collections
        dbdata
        dbdic
        dbdoc
        dbext
        dcf
        dcl
        des
        dir
        flg
        grp
        idx
        item
        items
        itm
        lay
        obj
        pair
        search
        tmp
    )
  
    (defun *error* ( msg )
        (if (and (= 'vla-object (type dbdoc)) (not (vlax-object-released-p dbdoc)))
            (vlax-release-object dbdoc)
        )
        (if (= 'file (type des))
            (close des)
        )
        (if (and (= 'str (type dcf)) (findfile dcf))
            (vl-file-delete dcf)
        )
        (if (< 0 dcl)
            (unload_dialog dcl)
        )
        (if (null (wcmatch (strcase msg t) "*break,*cancel*,*exit*"))
            (princ (strcat "\nError: " msg))
        )
        (princ)
    )

;;-----------------------------------------------------------------------------------------------;;
;;                                         Main Function                                         ;;
;;-----------------------------------------------------------------------------------------------;;
  
    (cond
        (   (null
                (or dwg
                    (setq dwg
                        (getfiled "Select Drawing to Steal From"
                            (cond
                                (   (and
                                        (setq dir (getenv "LMac\\StealLast"))
                                        (setq dir (strcat (vl-filename-directory dir) "\\"))
                                        (vl-file-directory-p dir)
                                    )
                                    dir
                                )
                                (   ""   )
                            )
                            "dwg;dwt;dws"
                            16
                        )
                    )
                )
            )
            (princ "\n*Cancel*")
        )
        (   (and
                (= 1 (getvar 'dwgtitled))
                (= (strcase dwg) (strcase (strcat (getvar 'dwgprefix) (getvar 'dwgname))))
            )
            (princ "\nCannot Steal from the Current Drawing.")
        )
        (   (null (setq dbdoc (steal:getdocumentobject dwg)))
            (princ (strcat "\nUnable to Interface with drawing: " dwg))
        )
        (   (null
                (setq
                    acdoc (vla-get-activedocument (vlax-get-acad-object))
                    acdic (vla-get-dictionaries acdoc)
                    dbdic (vla-get-dictionaries dbdoc)
                    acext (if (= :vlax-true (vla-get-hasextensiondictionary (vla-get-layers acdoc)))
                              (vla-getextensiondictionary (vla-get-layers acdoc))
                          )
                    dbext (if (= :vlax-true (vla-get-hasextensiondictionary (vla-get-layers dbdoc)))
                              (vla-getextensiondictionary (vla-get-layers dbdoc))
                          )
                    acdata
                    (list
                        (list "Blocks"                  (steal:getprop acdoc 'blocks)                (steal:getprop dbdoc 'blocks))
                        (list "Layers"                  (Steal:getprop acdoc 'layers)                (steal:getprop dbdoc 'layers))
                        (list "Linetypes"               (steal:getprop acdoc 'linetypes)             (steal:getprop dbdoc 'linetypes))
                        (list "Text Styles"             (steal:getprop acdoc 'textstyles)            (steal:getprop dbdoc 'textstyles))
                        (list "Dimension Styles"        (steal:getprop acdoc 'dimstyles)             (steal:getprop dbdoc 'dimstyles))
                        (list "Layouts"                 (steal:getprop acdoc 'layouts)               (steal:getprop dbdoc 'layouts))
                        (list "Views"                   (steal:getprop acdoc 'views)                 (steal:getprop dbdoc 'views))
                        (list "Materials"               (steal:getprop acdoc 'materials)             (steal:getprop dbdoc 'materials))
                        (list "Viewports"               (steal:getprop acdoc 'viewports)             (steal:getprop dbdoc 'viewports))
                        (list "Page Setups"             (steal:getprop acdoc 'plotconfigurations)    (steal:getprop dbdoc 'plotconfigurations))
                        (list "User Coordinate Systems" (steal:getprop acdoc 'usercoordinatesystems) (steal:getprop dbdoc 'usercoordinatesystems))
                        (list "Groups"                  (steal:getprop acdoc 'groups)                (steal:getprop dbdoc 'groups))
                        (list "Drawing Properties"      (steal:getprop acdoc 'summaryinfo)           (steal:getprop dbdoc 'summaryinfo))
                        (list "Custom Properties"       (steal:getprop acdoc 'summaryinfo)           (steal:getprop dbdoc 'summaryinfo))
                        (list "Multileader Styles"      (steal:getitem acdic "ACAD_MLEADERSTYLE")    (steal:getitem dbdic "ACAD_MLEADERSTYLE"))
                        (list "Multiline Styles"        (steal:getitem acdic "ACAD_MLINESTYLE"  )    (steal:getitem dbdic "ACAD_MLINESTYLE"  ))
                        (list "Table Styles"            (steal:getitem acdic "ACAD_TABLESTYLE"  )    (steal:getitem dbdic "ACAD_TABLESTYLE"  ))
                        (list "Scales"                  (steal:getitem acdic "ACAD_SCALELIST"   )    (steal:getitem dbdic "ACAD_SCALELIST"   ))
                        (list "Layer States"            (steal:getitem acext "ACAD_LAYERSTATES" )    (steal:getitem dbext "ACAD_LAYERSTATES" ))
                    )
                    dbdata (vl-remove 'nil (mapcar '(lambda ( x ) (apply 'steal:getdata x)) acdata))
                )
            )
            (princ "\nNo items found to import.")
        )
        (   lst
            (setq dbdata (mapcar '(lambda ( x ) (cons (strcase (car x)) (cdr x))) dbdata)
                  acdata (mapcar '(lambda ( x ) (cons (strcase (car x)) (cdr x))) acdata)
            )
            (while (setq grp (car lst))
                (setq col (assoc (strcase  (car  grp)) acdata)
                      itm (mapcar 'strcase (cadr grp))
                      cln (car  col)
                      col (cadr col)
                      lst (cdr  lst)
                      tmp nil
                )
                (cond
                    (   (or (null col)
                            (null itm)
                            (null (assoc cln dbdata))
                        )
                    )
                    (   (= "LAYER STATES" cln)
                        (if layerstate-importfromdb
                            (foreach pair (cdr (assoc cln dbdata))
                                (if (vl-some '(lambda ( pat ) (wcmatch (strcase (car pair)) pat)) itm)
                                    (layerstate-importfromdb (car pair) dwg)
                                )
                            )
                        )
                    )
                    (   (= "GROUPS" cln)
                        (foreach pair (cdr (assoc cln dbdata))
                            (if (vl-some '(lambda ( pat ) (wcmatch (strcase (car pair)) pat)) itm)
                                (progn
                                    (setq tmp nil)
                                    (vlax-for obj (cdr pair)
                                        (setq tmp (cons obj tmp))
                                    )
                                    (setq lay
                                        (vla-get-name
                                            (vla-get-layout
                                                (vla-objectidtoobject dbdoc (vla-get-ownerid (car tmp)))
                                            )
                                        )
                                    )
                                    (vla-appenditems (vla-add col (car pair))
                                        (vla-copyobjects dbdoc
                                            (vlax-make-variant
                                                (vlax-safearray-fill
                                                    (vlax-make-safearray vlax-vbobject (cons 0 (1- (length tmp))))
                                                    (reverse tmp)
                                                )
                                            )
                                            (vla-get-block
                                                (cond
                                                    (   (steal:getitem (cadr (assoc "LAYOUTS" acdata)) lay)   )
                                                    (   (vla-add       (cadr (assoc "LAYOUTS" acdata)) lay)   )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                    (   (= "DRAWING PROPERTIES" cln)
                        (foreach pair (cdr (assoc cln dbdata))
                            (if (vl-some '(lambda ( pat ) (wcmatch (strcase (car pair)) pat)) itm)
                                (vlax-put-property col (car pair) (cdr pair))
                            )                                
                        )
                    )
                    (   (= "CUSTOM PROPERTIES" cln)
                        (foreach pair (cdr (assoc cln dbdata))
                            (if (vl-some '(lambda ( pat ) (wcmatch (strcase (car pair)) pat)) itm)
                                (if (vl-catch-all-error-p (vl-catch-all-apply 'vla-setcustombykey (list col (car pair) (cdr pair))))
                                    (vla-addcustominfo col (car pair) (cdr pair))
                                )
                            )
                        )
                    )
                    (   (progn
                            (foreach pair (cdr (assoc cln dbdata))
                                (if
                                    (setq obj
                                        (vl-some
                                            (function
                                                (lambda ( pat )
                                                    (if (wcmatch (strcase (car pair)) pat)
                                                        (cdr pair)
                                                    )
                                                )
                                            )
                                            itm
                                        )
                                    )
                                    (setq tmp (cons obj tmp))
                                )
                            )
                            tmp
                        )
                        (vla-copyobjects dbdoc
                            (vlax-make-variant
                                (vlax-safearray-fill
                                    (vlax-make-safearray vlax-vbobject (cons 0 (1- (length tmp))))
                                    tmp
                                )
                            )
                            col
                        )
                        (if (= "PAGE SETUPS" cln) ;; Bug with ACAD_PLOTSETTINGS Dictionary
                            (
                                (lambda ( dic )
                                    (entmod
                                        (mapcar
                                            (function
                                                (lambda ( a b )
                                                    (if
                                                        (and
                                                            (= 003 (car a))
                                                            (= 350 (car b))
                                                        )
                                                        (cons 3 (cdr (assoc 1 (entget (cdr b)))))
                                                        a
                                                    )
                                                )
                                            )
                                            dic
                                            (append (cdr dic) '( nil ))
                                        )
                                    )
                                )
                                (dictsearch (namedobjdict) "ACAD_PLOTSETTINGS")
                            )
                        )
                    )
                )
            )
        )
        (   (not
                (and
                    (setq dcf (vl-filename-mktemp nil nil ".dcl"))
                    (setq des (open dcf "w"))
                    (progn
                        (foreach x
                           '(
                                "box : list_box"
                                "{"
                                "    width  = 30.0;"
                                "    height = 20.0;"
                                "    fixed_width  = true;"
                                "    fixed_height = true;"
                                "    alignment = centered;"
                                "}"
                                "but : button"
                                "{"
                                "    width =  15.0;"
                                "    height =  2.5;"
                                "    fixed_width  = true;"
                                "    fixed_height = true;"
                                "}"
                                "img24b : image_button"
                                "{"
                                "    fixed_width = true;"
                                "    fixed_height = true;"
                                "    width = 4.13;"
                                "    aspect_ratio = 1.0;"
                                "}"
                                "steal : dialog"
                                "{"
                                "    key = \"dctitle\";"
                                "    spacer;"
                                "    : row"
                                "    {"
                                "         fixed_width = true;"
                                "         alignment = left;"
                                "         : img24b { key = \"refresh\"; mnemonic = \"R\"; }"
                                "         : text   { label = \"&Refresh Drawing Data\"; }"
                                "         : column"
                                "         {"
                                "             : text { label = \"Copyright (c) Lee Mac 2012\"; alignment = right; }"
                                "         }"
                                "    }"
                                "    : row"
                                "    {"
                                "        : box { key = \"l1\"; }"
                                "        : box { key = \"l2\"; multiple_select = true; allow_accept = true; }"
                                "    }"
                                "    : row"
                                "    {"
                                "         alignment = centered;"
                                "         : edit_box { key = \"search1\"; }"
                                "         : img24b   { key = \"search2\"; }"
                                "    }"
                                "    errtile;"
                                "    : row"
                                "    {"
                                "        spacer;"
                                "        : but { key = \"accept\"; is_default = true; label = \"Import\"; }"
                                "        : but { key = \"cancel\"; is_cancel  = true; label = \"Done\";   }"
                                "        spacer;"
                                "    }"
                                "    spacer;"
                                "}"
                            )
                            (write-line x des)
                        )
                        (setq des (close des))
                        (< 0 (setq dcl (load_dialog dcf)))
                    )
                    (new_dialog "steal" dcl)
                )
            )
            (princ "\nUnable to Load Dialog.")
        )
        (   t
            (setenv "LMac\\StealLast" dwg)
 
            (set_tile "dctitle" (strcat "Steal V" StealVersionNumber))

            (steal:image "refresh"
               '(
                    -15 -15 -15 -15 -15 -15 -15 -15 -15 009 163 165 165 173 163 009 -15 -15 -15 -15 -15 -15 -15 -15 -15 161 -15 -15 -15 -15 -15 161
                    175 164 164 154 175 173 171 171 163 161 -15 -15 -15 -15 -15 -15 -15 154 153 -15 -15 254 175 166 166 166 166 164 164 175 173 171
                    161 161 163 254 -15 -15 -15 -15 -15 154 154 163 254 164 166 166 166 166 166 166 164 154 175 152 171 161 151 163 254 -15 -15 -15
                    -15 154 154 154 164 166 166 166 166 166 164 165 153 009 009 161 173 173 161 151 163 254 -15 -15 -15 154 162 154 164 166 166 166
                    166 165 254 -15 -15 -15 -15 -15 -15 254 163 171 151 163 -15 -15 -15 152 152 162 154 164 166 166 153 -15 -15 -15 -15 -15 -15 -15
                    -15 -15 -15 153 171 161 009 -15 -15 152 152 152 154 154 164 164 254 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 153 161 163 -15
                    -15 152 152 152 152 154 154 164 164 151 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 163 171 -15 -15 152 150 150 152 152 154 164
                    166 156 153 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 151 163 254 -15 152 152 152 152 152 154 154 154 177 164 009 -15 -15 -15 -15
                    -15 -15 -15 -15 -15 -15 173 009 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 165 009
                    254 154 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 254 152 254 -15 -15 -15 -15 -15
                    -15 -15 -15 -15 254 154 175 175 175 175 175 165 173 173 173 -15 -15 152 153 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 161 164 166
                    166 166 164 175 173 173 173 -15 -15 152 152 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 254 164 166 166 166 177 175 173 173 -15
                    -15 153 150 163 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 254 156 166 166 164 175 173 173 -15 -15 254 152 150 163 -15 -15 -15
                    -15 -15 -15 -15 -15 -15 -15 009 156 166 166 166 164 175 173 -15 -15 -15 163 150 150 173 254 -15 -15 -15 -15 -15 -15 -15 163 156
                    166 166 166 166 166 175 165 -15 -15 -15 -15 152 150 150 152 173 161 009 009 161 163 154 156 166 166 166 166 166 164 177 165 -15
                    -15 -15 -15 254 152 150 150 152 152 162 154 154 154 164 156 156 166 166 156 151 173 164 175 -15 -15 -15 -15 -15 254 152 152 152
                    152 162 162 162 154 154 164 156 156 156 009 -15 -15 173 175 -15 -15 -15 -15 -15 -15 -15 161 152 152 152 152 152 162 154 154 154
                    163 -15 -15 -15 -15 -15 173 -15 -15 -15 -15 -15 -15 -15 -15 -15 009 163 165 152 165 163 161 -15 -15 -15 -15 -15 -15 -15 -15 -15
                )
            )
            (steal:image "search2"
               '(
                    -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 009 253 252 251 251 252 253 009 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15
                    -15 254 252 253 009 254 -15 -15 254 009 253 252 254 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 009 252 009 009 253 252 008 008
                    252 253 009 009 252 009 -15 -15 -15 -15 -15 -15 -15 -15 -15 254 252 009 253 252 253 254 254 254 254 253 252 253 009 252 254 -15
                    -15 -15 -15 -15 -15 -15 -15 252 009 253 252 009 -15 -15 -15 -15 -15 -15 009 252 253 009 252 -15 -15 -15 -15 -15 -15 -15 009 253
                    253 252 009 254 -15 -15 -15 -15 -15 -15 254 009 252 253 253 009 -15 -15 -15 -15 -15 -15 253 253 252 153 254 254 254 254 254 254
                    254 254 254 254 153 252 253 253 -15 -15 -15 -15 -15 -15 008 009 252 253 254 254 254 254 254 254 254 254 254 254 253 252 009 008
                    -15 -15 -15 -15 -15 -15 251 253 252 253 254 254 254 254 254 254 254 254 254 254 253 252 253 251 -15 -15 -15 -15 -15 -15 251 253
                    252 253 009 254 254 254 254 254 254 254 254 009 253 252 253 251 -15 -15 -15 -15 -15 -15 008 252 252 253 009 254 254 254 254 254
                    254 254 254 009 253 252 252 008 -15 -15 -15 -15 -15 -15 252 252 253 253 009 254 254 254 254 254 254 254 254 009 253 253 252 252
                    -15 -15 -15 -15 -15 -15 253 008 253 153 253 254 254 254 254 254 254 254 254 253 153 253 008 253 -15 -15 -15 -15 -15 -15 254 250
                    253 253 153 009 254 254 254 254 254 254 009 153 253 253 008 254 -15 -15 -15 -15 -15 -15 250 254 250 009 253 153 009 254 254 254
                    254 009 153 253 009 251 253 -15 -15 -15 -15 -15 -15 251 250 008 252 250 253 009 253 153 153 153 153 253 009 253 251 253 -15 -15
                    -15 -15 -15 -15 251 008 250 250 250 252 008 252 009 254 254 254 254 009 252 008 253 -15 -15 -15 -15 -15 -15 251 008 250 250 250
                    254 -15 254 253 008 251 251 251 251 008 253 254 -15 -15 -15 -15 -15 -15 251 008 250 250 250 254 -15 -15 -15 -15 254 254 254 254
                    254 254 -15 -15 -15 -15 -15 -15 -15 251 008 250 250 250 254 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15
                    251 008 250 250 250 254 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 250 250 250 018 254 -15 -15 -15
                    -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 251 018 250 254 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15
                    -15 -15 -15 -15 -15 -15 -15 -15 254 254 254 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15 -15
                )
            )

            (steal:dclist "l1" (setq collections (acad_strlsort (mapcar 'car dbdata))))
            (set_tile     "l1" (setq collection "0"))
           
            (steal:dclist "l2" (setq items (mapcar 'car (cdr (assoc (car collections) dbdata)))))
            (set_tile     "l2" (setq item "0"))

            (defun _search nil
                (cond
                    (   (or (= "" search) (not search))
                        (set_tile "error" "Please Enter a Search String")
                    )
                    (   (not (setq pair (steal:search (strcat "*" search "*") dbdata)))
                        (set_tile "error" "No Items Found")
                    )
                    (   t
                        (setq collection (set_tile "l1" (itoa (vl-position (car pair) collections))))
                        (steal:dclist "l2"
                            (setq items
                                (mapcar 'car (cdr (assoc (car pair) dbdata)))
                            )
                        )
                        (setq item (set_tile "l2" (itoa (vl-position (cdr pair) items))))
                    )
                )
                (setq search (set_tile "search1" ""))
            )

            (action_tile "search1" "(set_tile \"error\" \"\") (setq search (strcase $value)) (if (= 1 $reason) (_search))")
         
            (action_tile "search2" "(set_tile \"error\" \"\") (_search)")

            (action_tile "refresh"
                (vl-prin1-to-string
                    (quote
                        (progn
                            (set_tile "error" "")
                            (if (setq dbdata (vl-remove 'nil (mapcar '(lambda ( x ) (apply 'steal:getdata x)) acdata)))
                                (progn
                                    (steal:dclist "l1" (setq collections (acad_strlsort (mapcar 'car dbdata))))
                                    (setq collection
                                        (set_tile "l1"
                                            (if (< (atoi collection) (length collections))
                                                collection
                                                "0"
                                            )
                                        )
                                    )
                                    (steal:dclist "l2"
                                        (setq items
                                            (mapcar 'car
                                                (cdr (assoc (nth (atoi collection) collections) dbdata))
                                            )
                                        )
                                    )
                                    (setq item (set_tile "l2" "0"))
                                )
                                (progn
                                    (alert "No items found to import.")
                                    (done_dialog 1)
                                )
                            )
                        )
                    )
                )
            )
                                    
            (action_tile "l1"
                (vl-prin1-to-string
                    (quote
                        (progn
                            (set_tile "error" "")
                            (steal:dclist "l2"
                                (setq items
                                    (mapcar 'car
                                        (cdr
                                            (assoc
                                                (nth (atoi (setq collection $value)) collections)
                                                dbdata
                                            )
                                        )
                                    )
                                )
                            )
                            (setq item
                                (set_tile "l2"
                                    (vl-string-trim "()"
                                        (vl-princ-to-string
                                            (cond
                                                (
                                                    (
                                                        (lambda ( _max )
                                                            (vl-remove-if-not (function (lambda ( x ) (< x _max)))
                                                                (read (strcat "(" item ")"))
                                                            )
                                                        )
                                                        (length items)
                                                    )
                                                )
                                                ( '("0") )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )

            (action_tile "l2" "(set_tile \"error\" \"\") (setq item $value)")

            (action_tile "accept"
                (vl-prin1-to-string
                    (quote
                        (progn
                            (set_tile "error" "")
                            (if (and (= 'str (type item)) (/= "" item))
                                (progn
                                    (setq col (assoc (nth (atoi collection) collections) acdata)
                                          cln (car  col)
                                          col (cadr col)
                                          idx (read (strcat "(" item ")"))
                                          lst (cdr (assoc cln dbdata))
                                          lst (mapcar '(lambda ( n ) (nth n lst)) idx)
                                          flg t
                                    )
                                    (cond
                                        (   (= "Layer States" cln)
                                            (if layerstate-importfromdb
                                                (foreach itm lst
                                                    (layerstate-importfromdb (car itm) dwg)
                                                )
                                            )
                                        )
                                        (   (= "Groups" cln)
                                            (foreach itm lst
                                                (vlax-for obj (cdr itm)
                                                    (setq tmp (cons obj tmp))
                                                )
                                                (setq lay
                                                    (vla-get-name
                                                        (vla-get-layout
                                                            (vla-objectidtoobject dbdoc (vla-get-ownerid (car tmp)))
                                                        )
                                                    )
                                                )
                                                (vla-appenditems (vla-add col (car itm))
                                                    (vla-copyobjects dbdoc
                                                        (vlax-make-variant
                                                            (vlax-safearray-fill
                                                                (vlax-make-safearray vlax-vbobject (cons 0 (1- (length tmp))))
                                                                (reverse tmp)
                                                            )
                                                        )
                                                        (vla-get-block
                                                            (cond
                                                                (   (steal:getitem (cadr (assoc "Layouts" acdata)) lay)   )
                                                                (   (vla-add       (cadr (assoc "Layouts" acdata)) lay)   )
                                                            )
                                                        )
                                                    )
                                                )
                                                (setq tmp nil)
                                            )
                                        )
                                        (   (= "Drawing Properties" cln)
                                            (foreach itm lst
                                                (vlax-put-property col (car itm) (cdr itm))
                                            )
                                        )
                                        (   (= "Custom Properties" cln)
                                            (foreach itm lst
                                                (if (vl-catch-all-error-p (vl-catch-all-apply 'vla-setcustombykey (list col (car itm) (cdr itm))))
                                                    (vla-addcustominfo col (car itm) (cdr itm))
                                                )
                                            )
                                        )
                                        (   t
                                            (vla-copyobjects dbdoc
                                                (vlax-make-variant
                                                    (vlax-safearray-fill
                                                        (vlax-make-safearray vlax-vbobject (cons 0 (1- (length lst))))
                                                        (mapcar 'cdr lst)
                                                    )
                                                )
                                                col
                                            )
                                            (if (= "Page Setups" cln) ;; Bug with ACAD_PLOTSETTINGS Dictionary
                                                (
                                                    (lambda ( dic )
                                                        (entmod
                                                            (mapcar
                                                                (function
                                                                    (lambda ( a b )
                                                                        (if
                                                                            (and
                                                                                (= 003 (car a))
                                                                                (= 350 (car b))
                                                                            )
                                                                            (cons 3 (cdr (assoc 1 (entget (cdr b)))))
                                                                            a
                                                                        )
                                                                    )
                                                                )
                                                                dic
                                                                (append (cdr dic) '( nil ))
                                                            )
                                                        )
                                                    )
                                                    (dictsearch (namedobjdict) "ACAD_PLOTSETTINGS")
                                                )
                                            )
                                        )
                                    )
                                    (if (setq tmp (steal:removeitems idx (cdr (assoc cln dbdata))))
                                        (setq dbdata (subst (cons cln tmp) (assoc cln dbdata) dbdata))
                                        (setq dbdata (vl-remove (assoc cln dbdata) dbdata))
                                    )
                                    (if dbdata
                                        (progn
                                            (steal:dclist  "l1" (setq collections (acad_strlsort (mapcar 'car dbdata))))
                                            (setq collection
                                                (set_tile "l1"
                                                    (if (< (atoi collection) (length collections))
                                                        collection
                                                        "0"
                                                    )
                                                )
                                            )
                                            (steal:dclist "l2"
                                                (setq items
                                                    (mapcar 'car
                                                        (cdr (assoc (nth (atoi collection) collections) dbdata))
                                                    )
                                                )
                                            )
                                            (setq item (set_tile "l2" "0"))
                                        )
                                        (done_dialog 1)
                                    )
                                )
                            )
                        )
                    )
                )
            )
            (start_dialog)
            (if flg (vla-regen acdoc acallviewports))
        )
    )
    (if (< 0 dcl)
        (setq dcl (unload_dialog dcl))
    )
    (if (and (= 'str (type dcf)) (findfile dcf))
        (vl-file-delete dcf)
    )
    (if (and (= 'vla-object (type dbdoc)) (not (vlax-object-released-p dbdoc)))
        (vlax-release-object dbdoc)
    )
    (princ)
)

;;-----------------------------------------------------------------------------------------------;;

(defun steal:image ( key lst / i j s x y )
    (setq s (fix (sqrt (length lst))))
    (repeat (setq i s)
        (setq j 1)
        (repeat s
            (setq x (cons j x)
                  y (cons i y)
                  j (1+ j)
            )
        )
        (setq i (1- i))
    )
    (start_image key)
    (fill_image 0 0 (dimx_tile key) (dimy_tile key) -15)
    (mapcar 'vector_image x y x y lst)
    (end_image)
)

;;-----------------------------------------------------------------------------------------------;;

(defun steal:getprop ( object property )
    (if (vlax-property-available-p object property)
        (vlax-get-property object property)
    )
)

;;-----------------------------------------------------------------------------------------------;;

(defun steal:getdata ( cln cl1 cl2 / exs itm key lst nme val )
    (cond
        (   (not (and cl1 cl2))
            nil
        )
        (   (= "Scales" cln)
            (vlax-for itm cl1
                (setq exs (cons (cdr (assoc 300 (entget (vlax-vla-object->ename itm)))) exs))
            )
            (vlax-for itm cl2
                (if (not (member (setq nme (cdr (assoc 300 (entget (vlax-vla-object->ename itm))))) exs))
                    (setq lst (cons (cons nme itm) lst))
                )
            )
            (if (setq lst (vl-sort lst '(lambda ( a b ) (< (strcase (car a)) (strcase (car b))))))
                (cons cln lst)
            )
        )
        (   (= "Drawing Properties" cln)
            (foreach prp '("Author" "Comments" "HyperlinkBase" "Keywords" "Subject" "Title")
                (if
                    (and
                        (vlax-property-available-p   cl2 prp)
                        (vlax-property-available-p   cl1 prp t)
                        (setq itm (vlax-get-property cl2 prp))
                        (/= "" itm)
                        (/= (vlax-get-property cl1 prp) itm)
                    )
                    (setq lst (cons (cons prp itm) lst))
                )
            )
            (if (setq lst (vl-sort lst '(lambda ( a b ) (< (strcase (car a)) (strcase (car b))))))
                (cons cln lst)
            )
        )
        (   (= "Custom Properties" cln)
            (repeat (setq idx (vla-numcustominfo cl2))
                (vla-getcustombyindex cl2 (setq idx (1- idx)) 'key 'itm)
                (if
                    (and itm
                        (/= "" itm)
                        (or (vl-catch-all-error-p (vl-catch-all-apply 'vla-getcustombykey (list cl1 key 'val)))
                            (/= val itm)
                        )
                    )
                    (setq lst (cons (cons key itm) lst))
                )
            )
            (if (setq lst (vl-sort lst '(lambda ( a b ) (< (strcase (car a)) (strcase (car b))))))
                (cons cln lst)
            )
        )
        (   (progn
                (vlax-for itm cl2
                    (if
                        (and
                            (setq nme
                                (cond
                                    (   (vlax-property-available-p itm 'name)
                                        (vla-get-name itm)
                                    )
                                    (   (cdr (assoc 2 (entget (vlax-vla-object->ename itm))))   )
                                )
                            )
                            (not
                                (or
                                    (= nme "")
                                    (wcmatch nme "`**,*|*,ACAD_*")
                                    (steal:getitem cl1 nme)
                                    (and
                                        (vlax-property-available-p itm 'isxref)
                                        (= :vlax-true (vla-get-isxref itm))
                                    )
                                    (and
                                        (vlax-property-available-p itm 'islayout)
                                        (= :vlax-true (vla-get-islayout itm))
                                    )
                                )
                            )
                        )
                        (setq lst (cons (cons nme itm) lst))
                    )
                )
                (setq lst (vl-sort lst '(lambda ( a b ) (< (strcase (car a)) (strcase (car b))))))
            )
            (cons cln lst)
        )              
    )
)

;;-----------------------------------------------------------------------------------------------;;

(defun steal:getitem ( collection item )
    (if
        (not
            (vl-catch-all-error-p
                (setq item
                    (vl-catch-all-apply 'vla-item (list collection item))
                )
            )
        )
        item
    )
)

;;-----------------------------------------------------------------------------------------------;;

(defun steal:dclist ( key lst )
    (start_list key)
    (mapcar 'add_list lst)
    (end_list)
)

;;-----------------------------------------------------------------------------------------------;;

(defun steal:removeitems ( items lst / i )
    (setq i -1)
    (vl-remove-if (function (lambda ( x ) (member (setq i (1+ i)) items))) lst)
)

;;-----------------------------------------------------------------------------------------------;;

(defun steal:search ( phrase data )
    (vl-some
        (function
            (lambda ( collection )
                (vl-some
                    (function
                        (lambda ( item )
                            (if (wcmatch (strcase (car item)) phrase)
                                (cons (car collection) (car item))
                            )
                        )
                    )
                    (cdr collection)
                )
            )
        )
        data
    )
)

;;-----------------------------------------------------------------------------------------------;;

(defun steal:getdocumentobject ( filename / acdocs dbdoc vers )
    (vlax-map-collection (vla-get-documents (vlax-get-acad-object))
        (function
            (lambda ( doc )
                (setq acdocs (cons (cons (strcase (vla-get-fullname doc)) doc) acdocs))
            )
        )
    )
    (cond
        (   (null (setq filename (findfile filename)))
            nil
        )
        (   (cdr (assoc (strcase filename) acdocs))
        )
        (   (null
                (vl-catch-all-error-p
                    (vl-catch-all-apply 'vla-open
                        (list
                            (setq dbdoc
                                (vla-getinterfaceobject (vlax-get-acad-object)
                                    (if (< (setq vers (atoi (getvar 'acadver))) 16)
                                        "ObjectDBX.AxDbDocument"
                                        (strcat "ObjectDBX.AxDbDocument." (itoa vers))
                                    )
                                )
                            )
                            filename
                        )
                    )
                )
            )
            dbdoc
        )
    )
)

;;-----------------------------------------------------------------------------------------------;;

(defun steal:listbox ( title lst / *error* dch des tmp res )

    (defun *error* ( msg )
        (if (< 0 dch)
            (unload_dialog dch)
        )
        (if (= 'file (type des))
            (close des)
        )
        (if (and (= 'str (type tmp)) (setq tmp (findfile tmp)))
            (vl-file-delete tmp)
        )
        (if (not (wcmatch (strcase msg t) "*break,*cancel*,*exit*"))
            (princ (strcat "\nError: " msg))
        )
        (princ)
    )
    
    (cond
        (   (not
                (and
                    (setq tmp (vl-filename-mktemp nil nil ".dcl"))
                    (setq des (open tmp "w"))
                    (write-line
                        (strcat
                            "listbox : dialog { label = \""
                            title
                            "\"; spacer; : list_box { key = \"list\"; multiple_select = false"
                            "; } spacer; ok_cancel; }"
                        )
                        des
                    )
                    (not (close des))
                    (< 0 (setq dch (load_dialog tmp)))
                    (new_dialog "listbox" dch)
                )
            )
            (prompt "\nError loading Steal list box.")
        )
        (   t     
            (start_list "list")
            (foreach item lst (add_list item))
            (end_list)
            (setq res (set_tile "list" "0"))
            (action_tile "list" "(setq res $value)")
            (setq res
                (if (= 1 (start_dialog))
                    (mapcar '(lambda ( x ) (nth x lst)) (read (strcat "(" res ")")))
                )
            )
        )
    )
    (if (< 0 dch)
        (setq dch (unload_dialog dch))
    )
    (if (and (= 'str (type tmp)) (setq tmp (findfile tmp)))
        (vl-file-delete tmp)
    )
    res
)

;;-----------------------------------------------------------------------------------------------;;

(vl-load-com)
(princ
    (strcat
        "\n:: Steal.lsp | Version "
        stealversionnumber
        " | © Lee Mac "
        (menucmd "m=$(edtime,$(getvar,DATE),YYYY)")
        " www.lee-mac.com ::"
        "\n:: Available Commands:"
        "\n::    \"Steal\"           -  Standard program."
        "\n::    \"StealAll\"        -  Steals everything from a selected drawing."
        "\n::    \"StealTemplate\"   -  Steals from the QNew template."
        "\n::    \"StealTemplates\"  -  Steals from a selected template."
        "\n::    \"StealLast\"       -  Steals from the last selected drawing."
    )
)
(princ)

;;-----------------------------------------------------------------------------------------------;;
;;                                          End of File                                          ;;
;;-----------------------------------------------------------------------------------------------;;