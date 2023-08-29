(defun ParseJSON->List (json / data newData inStr dPrev strPos)
  ;Converts json string to list. By Denon Deterding (VL2 - 20200924)
  ;NOTE: json object strings will be truncated to 2300 characters MAX ('read' function limitation)
  ;----- (the 'json' input variable is NOT limited to the 2300 chr limit)
  ;json - string, as json data
  ;returns - list, of data from json
  (setq data (vl-string->list json))
  (foreach d data
    (cond
      ;if we're in a string, test length and continue
      (inStr
        (if (or (setq inStr (and (= 34 d) (/= 92 dPrev)))
                (<= strPos 2300)) ;[--- MAX string length is 2300 characters ---]
          (setq strPos (1+ strPos) newData (cons d newData))
        );if
        (setq instr (not inStr))
      );cond 1
      ;this signals that we're starting a string
      ((= 34 d)
        (setq inStr t strPos 1 newData (cons d newData))
      );cond 2
      ;replacing relevant characters Outside of json object strings
      ((member d '(44 58 91 93 123 125)) ; ("," ":" "[" "]" "{" "}")
        (foreach n (cond
                     ((= 44 d) '(41 32 40))             ; ") ("
                     ((= 58 d) '(32))                   ; " "
                     ((or (= 91 d) (= 123 d)) '(40 40)) ; "(("
                     ((or (= 93 d) (= 125 d)) '(41 41)) ; "))"
                   );cond
          (setq newData (cons n newData))
        );foreach
      );cond 3
      ;these will signal a "true" value
      ((or (= 116 d) (= 84 d)) ; ("t" "T")
        (setq newData (cons 116 newData)) ; "t"
      );cond 4
      ;these will signal a "null" or "false" value (both are nil in lisp)
      ((or (= 110 d) (= 102 d) (= 78 d) (= 70 d)) ; ("n" "f" "N" "F")
        (foreach n '(110 105 108) (setq newData (cons n newData))) ; "nil"
      );cond 5
      ;this handles numbers.. real/int, pos/neg
      ((member d '(45 46 48 49 50 51 52 53 54 55 56 57)) ; ("-" "." "0" "1" "2" "3" "4" "5" "6" "7" "8" "9")
        (setq newData (cons d newData))
      );cond 6
    );cond
    (setq dPrev d)
  );foreach
  (read (vl-list->string (reverse newData)))
);defun