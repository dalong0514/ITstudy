# 0103ACADDOC.lsp Creator

[ACADDOC.lsp Creator | Lee Mac Programming](http://www.lee-mac.com/acaddoccreator.html)

## Program Description

I designed this program to aid a user in the construction of an ACADDOC.lsp to load, on startup, programs residing in a particular directory.

The procedure implemented by the program is relatively simple: attempt to find an existing ACADDOC.lsp file, if found, append all following information to the contents contained therein, else create a new ACADDOC.lsp file in an AutoCAD Support Directory.

The program will then proceed to prompt for the selection of a directory in which the program files (.lsp/.vlx/.fas) reside. Should program files be found in the selected directory, loading statements are written to the ACADDOC.lsp to load each program on startup.

The resultant load expression written to the ACADDOC.lsp utilises the standard AutoLISP load function, with a relevant 'OnFailure' argument to notify the user should the program fail to load.

Example of Load Expression
(load "C:\\MyFolder\\MyLISP.lsp" "--> Failed to Load: MyLISP")
This loading method is sufficient for a relatively small number of programs loading upon drawing startup, however, for those looking to load a larger number of program files may prefer to use a demand load procedure such as the AutoLoad function, else the time taken to open a drawing may be noticeably increased.

Note that the program will, by default, solely look for program files in the top level of the directory selected - i.e. any subfolders located within the selected directory will not be probed. This behaviour may easily be altered upon a quick inspection of how the DirectoryDialog subfunction is used within the program.