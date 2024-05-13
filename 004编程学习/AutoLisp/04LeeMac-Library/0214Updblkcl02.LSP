;****************************************************************************************
;	UPDATE BLOCK LAYER (updblkly.lsp)
;	PRE-INSERTED BLOCK DEFINITION CLEAN-UP UTILITY
;
;	This routine is especially usefull to redefine pre-inserted blocks whose
;	colors and layers need to be changed to layer 0 and color BYLAYER.
;
;       This routine allows the user to update the layer of
;	all entities within a block to a single layer (exam: layer=0)
;	without the user having to explode the symbol.  By default the color of
;	all entities are changed to BYLAYER. The routine changes the original
;	definition of the block within the current drawing.
;
;	To use this routine the user is asked to specify a single
;	layer to place all entities of a selected block(s).
;
;	The user is next prompted to select one or more blocks to update. The routine
;	then redefines all entities of the block to the layer specified.
;
;	When the user regenerates the drawing she/he will find that all
;	occurances of the block have been redefined.  This is because the
;	original definition of the block is changed!!!
;
;	IF YOU FIND THIS ROUTINE USEFUL PLEASE E-MAIL ME AT lindseycc@aol.com
;       by CAREN LINDSEY, June 1993
;****************************************************************************************
;

;INTERNAL ERROR HANDLER
(defun err-ubc (s)				; If an error (such as CTRL-C) occurs
						; while this command is active...
	(if (/= s "Function cancelled")
  		(princ (strcat "\nError: " s))
	)
	(setq *error* olderr)			; Restore old *error* handler
	(princ)
);err-ubc

(DEFUN C:UPDBLKLY (/ BLK CBL CBL2 C ACL ALY L NLY NCL YN)

	(setq olderr *error* *error* err-ubc)
        (while (null L)
		(setq L (strcase (getstring "\nEnter new layer name: ")))
		(cond
			((= L "")(setq L nil))
			((null (tblsearch "LAYER" L))
				(princ (strcat "\nLayer " L " does not exists!"))
				(initget "YES yes NO no")
				(setq yn (strcase (getstring "\nCreate new layer (y/n)? ")))
				(if (= yn "Y")(command ".layer" "m" L "")(setq L nil)))
		);cond
	);while

	(PROMPT "\nPick blocks to update. ")
	(SETQ SS (SSGET '((0 . "INSERT"))))
	(SETQ K 0)
	(WHILE (< K (SSLENGTH SS))
        	(setq CBL (tblsearch "BLOCK" (CDR (ASSOC 2 (ENTGET (SETQ BLK (SSNAME SS K)))))))
        	(SETQ CBL2 (CDR (ASSOC -2 CBL)))
		(WHILE (BOUNDP 'CBL2)
			(SETQ EE (ENTGET CBL2))

			;Update layer value
 			(SETQ NLY (CONS 8 L))
			(SETQ ALY (ASSOC 8 EE))
			(SETQ NEWE (SUBST NLY ALY EE))
			(ENTMOD NEWE)

			(SETQ CBL2 (ENTNEXT CBL2))
		);end while
		(ENTUPD BLK)
		(SETQ K (1+ K))
	);end while
	(setq *error* olderr)
	(princ)
);end updblkly
        
