# Chapter 18 Working with the Operating System and External Files

The AutoLISP® programming language can be used to reach beyond the boundaries of the Autodesk® AutoCAD® application window and objects in the current open drawing. Using AutoLISP, you can access settings managed by the operating system and installed applications on Windows or by the application-level settings of AutoCAD on both Windows and Mac OS. You can access operating system– and application-level settings from the Windows Registry. On Mac OS, you can access application-level settings for AutoCAD from the Plist (property list) files.

Along with accessing operating system and application settings, you can read and write ASCII (plain text) files that are stored on a local or network drive. You can use content in an ASCII file to populate project information in a title block or as a means to export information from a drawing. Exported information can be used to create or update objects in a drawing or to generate a quote based on the values of attributes in blocks placed within a drawing. In addition to reading and writing ASCII files, you can use AutoLISP to manage and get general information about the files and directories on a local or network drive. In this chapter, you'll learn to persist values between AutoCAD sessions, write to and read from external files, and work with files in the operating system.

Storing Information in the Windows Registry or a Plist File

AutoCAD stores information and setting values using many different methods. Some are proprietary; others are industry standard. Most setting values are stored as part of the drawing using system variables, extended data, or custom dictionaries. Those settings that aren't stored with the drawing are, for the most part, stored with the AutoCAD user profile.

Sending Information Downstream

After much praise about the furniture layout that you did for the new office space, your boss has come back from lunch with a local furniture reseller who has a new request. During his lunch meeting, the reseller mentioned that they could create a pricing quote from the BOM information if it was provided in a comma-separated values (CSV) file.

You begin to ponder the situation, and then the lightbulb goes on. The AutoLISP program you wrote has already tabulated the BOM information in a list. Using AutoLISP, you can write the values from that tabulated list to a CSV file. Once again, AutoLISP helped you step up your game and get the job done more efficiently.

The AutoCAD user profile on Windows is maintained in the Windows Registry, while Plist files are used on Mac OS. Both provide the same fundamental functionality, with one difference: Plist files are application specific and are not centralized like the Windows Registry.

I discussed how to work with system variables using AutoLISP in Chapter 12,「Understanding AutoLISP.」Extended data (Xdata) was explored in Chapter 16,「Creating and Modifying Graphical Objects,」and Chapter 17,「Creating and Modifying Nongraphical Objects,」covered working with custom dictionaries.

Creating and Querying Entries

On Windows, you can create and query values in the Windows Registry. The values that you can access in the Registry aren't just related to AutoCAD but are those managed by Windows and other installed applications. If you are developing custom programs on Mac OS, you can access the information stored in the AutoCAD-related Plist files.

You can work with two main areas (known as keys) in the Windows Registry: HKEY_LOCAL_MACHINE and HKEY_CURRENT_USER. On Mac OS, the Plist files that correspond to these Windows Registry keys are HKLM.plist and HKCU.plist, respectively.

Values in HKEY_LOCAL_MACHINE are typically set by an application installer and changing them might require administrator rights, which AutoLISP can't obtain. You should treat the values of HKEY_LOCAL_MACHINE as read-only since most users won't have the rights to change the values in this key. You can create and query values in the HKEY_CURRENT_USER area without any limitations, and this is the preferred area for adding new values when you want your programs to have access between AutoCAD sessions.

You can add values under the Software/AutoCAD key, but I recommend adding any custom values to a key that is specific to your company under the Software key. This will ensure that you don't accidentally overwrite or remove values used by another program.

The vl-registry-write function is used to create a key and assign a value to a key. It is also used to verify whether a key or value can be modified. The value you assign can be of the string or integer data type. The vl-registry-read function is used to access a value assigned to a key. If the key and value exist, the data returned can be a string, integer, or list (which represents a binary value). If the key or value doesn't exist, nil is returned.

The following shows the syntax of the vl-registry-write and vl-registry-read functions:

(vl-registry-write key [value_name data]) (vl-registry-read key [value_name])

The arguments are as follows:

key The key argument is a string that specifies the key in the Windows Registry or Plist file that you want to access.

value_name The value_name argument is an optional string that specifies the name of the value under the key specified by the key argument. If the value_name and data arguments aren't provided, T is returned if the key supports read/write access or nil if read-only access is permitted. Use "" to access the value (Default) under a key.

Data The data argument is an optional string or integer that is used to specify the data to assign to the value under the key specified by the value_name argument. A string data type when working with the Registry is known as a REG_SZ type, and an integer can be either a REG_DWORD (32-bit integer) or REG_QWORD (64-bit integer). Use "" to specify an empty string.

Here are some examples of writing and reading values to and from the Windows Registry or a Plist file:

; Checks to see if the key can be modified (vl-registry-write "HKEY_CURRENT_USER\\Software\\CompanyABC123") T ; Creates the entry Integer under CompanyABC123 and assigns it 123 (vl-registry-write "HKEY_CURRENT_USER\\Software\\CompanyABC123" "Integer" 123) 123 ; Creates the entry String under CompanyABC123 and assigns it "AutoLISP" (vl-registry-write "HKEY_CURRENT_USER\\Software\\CompanyABC123" "String" "AutoLISP") "AutoLISP" ; Reads the entry Integer under CompanyABC123 (vl-registry-read "HKEY_CURRENT_USER\\Software\\CompanyABC123" "Integer") 123

The vl-registry-read function requires you to know the name of the value you want to read, but you might want to read all values under a key. You can use the vl-registry-descendents function to get the names of all the values under a key. After you have a list of the values under a key, you can then step through the list returned by vl-registry-descendents and get the data assigned to each value with vl-registry-read.

Here is the syntax of the vl-registry-descendents function:

(vl-registry-descendents key [mode])

The key argument is the same as I previously described for the vl-registry-write and vl-registry-read functions. The mode argument is optional and can be a value of T. When T isn't passed to the mode argument, a list of the subkeys is provided, whereas a value of T instructs vl-registry-descendents to return a list of values under the specified key.

The following are examples of the vl-registry-descendents function and the values they return:

; Returns the entries under CompanyABC123 (vl-registry-descendents "HKEY_CURRENT_USER\\Software\\CompanyABC123" T) ("String" "Integer") ; Returns a list of the AutoCAD releases installed (vl-registry-descendents "HKEY_CURRENT_USER\\Software\\Autodesk\\AutoCAD") ("R20.0" "R19.1")

NOTE

On Windows, you can use the vlax-user-product-key and vlax-machine-product-key functions to return the key associated with the AutoCAD release executing the AutoLISP program. For example, vlax-machine-product-key returns「Software\\Autodesk\\AutoCAD\\R20.0\\ACAD-E001:409」from the English version of AutoCAD 2015. For more information on these two functions, see the AutoCAD Help system.

Editing and Removing Entries

You can update the data of a value under a key or remove a key or value that is no longer needed. Updating a value is done using the vl-registry-write function, whereas the vl-registry-delete function can be used to remove a key or value. vl-registry-delete returns T if the key or value is successfully removed; otherwise, nil is returned.

The following shows the syntax of the vl-registry-delete function:

(vl-registry-delete key [value_name])

Here are examples of the vl-registry-delete function:

; Removes the Integer value from the CompanyABC123 key (vl-registry-delete "HKEY_CURRENT_USER\\Software\\CompanyABC123" "Integer") T ; Removes the String value from the CompanyABC123 key (vl-registry-delete "HKEY_CURRENT_USER\\Software\\CompanyABC123" "Integer") nil ; Removes the CompanyABC123 key and all values under it (vl-registry-delete "HKEY_CURRENT_USER\\Software\\CompanyABC123") T

Using Configuration Files for Storing Custom Information

On Windows, before there was the Windows Registry, most applications used initialization (INI) files to store custom settings. Earlier AutoCAD releases used INI files and configuration (CFG) files to store device- and application-related settings. Recent AutoCAD releases still use CFG files for a few features, but mainly to support older custom programs that use CFG files for storing custom information.

The getcfg and setcfg functions allow you to read from and write to the "AppData" section of the CFG file. The first argument of both functions is a string that represents an entry name under "AppData" in the CFG file, which is similar to the key and value name used with the vl-registry-write function. For example, the following sets the value of "AutoLISP" to the entity name "CompanyABC123/String" in the CFG file:

(setcfg "AppData/CompanyABC123/String" "AutoLISP")

The following gets the data from the "String" entity name:

(getcfg "AppData/CompanyABC123/String")

The setcfg and getcfg functions accept and return data of the string type only.

Accessing Data from External Files

AutoLISP supports the ability to read and write ASCII plain text, not binary files. You can read data stored in an ASCII file with AutoLISP and use that data to create general notes, add disclaimers, or even populate the values of the attributes in a title block. In addition to reading files, AutoLISP can be used to write data to an ASCII file, which might represent an exported BOM or the properties of the layers in a drawing. ASCII files can be used to define any number of file types, such as CSV, text (TXT), HTM/HTML, or even XML.

NOTE

On Windows, you can use ActiveX/COM to access files that can be opened from a Microsoft Office application. I explain how to use ActiveX/COM with AutoLISP in Chapter 22,「Working with ActiveX/COM Libraries (Windows only).」

Opening and Creating an External File

AutoLISP can open an existing or create a new ASCII file that is currently stored on a local or network drive. Use the AutoLISP open function to open a file for read or write. The open function returns a file pointer that is expressed as a FILE data type or nil if the file couldn't be opened. The file pointer returned by the open function is required to read from and write to the file, as well as to save and close the file. I explain how to read text from a file in the next section, and how to write text in the「Writing Characters and Lines from a File」section later in this chapter. I discuss how to save and close a file in the「Closing an Open File」section.

NOTE

Trying to open a file that is read-only or that is stored in a read-only location with the write or append access mode results in the open function returning a value of nil, which indicates that the file couldn't be opened. Be sure to check the return value of the open function before trying to write to a file.

The following shows the syntax of the open function:

(open filename mode)

Its arguments are as follows:

filename The filename argument is a string that represents the file you want to open or create.

mode The mode argument is a single character that represents the access mode you want to use to open or create the file. Valid values are "r", "w", and "a", as Table 18.1 shows later in this chapter.

Table 18.1 ASCII file access modes

Access mode Description

read ( "r") Read-only; changes to the file aren't allowed. If the file doesn't exist, nil is returned, indicating the file couldn't be opened.

write ( "w") Read and write; changes to the file are allowed. If a file with the same name exists, the file is overwritten. The file is created if it doesn't already exist.

append ( "a") Read and write; changes to the file are allowed. If a file with the same name exists, the file is opened but not overwritten like with the write access mode. Any data written to the file is simply appended to the end. The file is created if it doesn't already exist.

Here is an example of opening a file with the open function:

; Opens a file named data.txt in C:\Dataset (Windows) (setq file_ptr (open "c:\\dataset\\data.txt" "r")) #<file "c:\\dataset\\data.txt"> ; Opens a file named data.txt in /Dataset (Mac OS) (setq file_ptr (open "/dataset/data.txt" "r")) #<file "/dataset/data.txt">

NOTE

File paths require the use of a single forward slash (Mac and Windows) or two backward slashes (Windows only) to separate drive and directory paths.

While the filename argument can specify any ASCII file on a local or network drive, the name of the file and path you choose can affect the sustainability of your custom program. When you specify the filename argument for the open function, consider the following:

Static Filenames When you read text from a file, using a static filename might be ideal, but static filenames don't work well when you want to write data to a file. When creating a file, either allow the user to specify a filename with the getfiled function or use the vl-filename-mktemp function to get a unique temporary filename.

Hard-Coded Paths I recommend against placing specific file paths in a custom program. Rather than hard-coding (typing the actual path to a particular file) a path or drive as part of a filename, use paths stored in system or environment variables related to the operating system or returned by the findfile function. For example, you can get the paths to My Documents (or Documents) or the temporary files directory with the mydocumentsprefix and tempprefix system variables.

I explain how to use the getfiled and findfile functions in the「Locating and Listing Files and Directories」section later in this chapter.

The mode argument of the open function supports three different options. Table 18.1 lists and describes the file access modes that the open function supports.

The following shows the syntax of the vl-filename-mktemp function:

(vl-filename-mktemp [base_filename file_directory file_extension])

Its arguments are as follows:

base_filename The base_filename argument is an optional string that represents the base filename of the temporary file you want to create. AutoLISP appends a numeric value to the end of the file, or between the filename and file extension if a file extension is provided. If a value is not passed to the base_filename argument, AutoLISP creates a file that starts with $VL˜˜ and doesn't append a file extension unless a value for the file_extension argument is provided.

file_directory The file_directory argument is an optional string that represents the directory in which the temporary file should be created. If no value is provided for the file_directory argument, the directory is determined by the current AutoCAD user profile and operating system.

file_extension The file_extension argument is an optional string that represents the extension that should be applied to the filename if one wasn't provided as part of the base_filename argument.

NOTE

You can specify a filename, path, and extension as part of the base_filename argument and not provide any additional values for the file_directory and file_extension arguments.

Here are examples of creating temporary filenames with the vl-filename-mktemp function:

(vl-filename-mktemp) "C:\\Users\\Lee\\AppData\\Local\\Temp\\$VL˜˜001" ; Windows "/Users/leeambrosius/Documents/$VL˜˜001" ; Mac OS (vl-filename-mktemp "data.txt") "C:\\Users\\Lee\\AppData\\Local\\Temp\\data002.txt" ; Windows "/Users/leeambrosius/Documents/data002.txt" ; Mac OS (vl-filename-mktemp "data" (getvar "mydocumentsprefix") ".txt") "C:\\Users\\Lee\\Documents\\data003.txt" ; Windows "/Users/leeambrosius/Documents/data003.txt" ; Mac OS

If you write to a temporary file and want to keep the file with a more meaningful name or move it to a different directory, you can use the vl-file-copy and vl-file-rename functions. I mention these functions in the「Managing Files and Directories」section later in this chapter.

Reading Characters and Lines from a File

Once a file has been opened for reading, you can step through the data stored in the file one character or line at a time. The read-char function allows you to read the first character in a file and returns the ASCII value of the character as an integer. Each successive call to the function gets the next character in the file and returns the ASCII value of that character. nil is returned when there are no additional characters to be read from the file.

Reading one character at a time isn't always a practical way of reading data from a file. Instead, you can read an entire line of text. A line is defined as a text string that ends with a new linefeed character, which has an ASCII code value of 10. You use the read-line function to read a line of text from a file. Similar to the read-char function, each successive call to the read-line function gets the next line in the file, and the function returns nil when there are no additional lines of text in the file to read.

The following shows the syntax of the read-char and read-line functions:

(read-char [file_pointer]) (read-line [file_pointer])

The file_pointer argument is optional and must be of the FILE data type when provided. The value must be one that was returned by the open function. If the file_pointer argument isn't provided, AutoCAD will allow you to enter one or more characters at the Command prompt. When the read-char function is used, the return value is the ASCII code value for the text entered; otherwise, a string containing the entered text is returned if the read-line function was used.

Here are examples of reading content from a file with the read-char and read-line functions:

(read-char file_ptr) 66 (read-line file_ptr) "BLOCK\tTAG\tPART\tDESCRIPTION"

Listing 18.1 shows how to read all lines in a text file.

Listing 18.1: Custom function that reads all lines in a text file

; Custom function opens the file for read and outputs each line (defun ReadFile (filename / fileptr cnt) (setq file_ptr (open filename "r")) (if file_ptr (progn (setq cnt 1) (while (setq text_line (read-line file_ptr)) (prompt (strcat "\nLine " (itoa cnt) ": " text_line)) (setq cnt (1+ cnt)) ) (close file_ptr) ) ) (princ) ) ; Function usage example (ReadFile "C:\\Dataset\data.txt") ; Windows (ReadFile "/Dataset/data.txt") ; Mac OS

NOTE

If you read a character from a file with the read-char function and then call read-line, the line of text returned will include only characters that have not yet been returned by the read-char function. Be careful when using both functions in the same file; I recommend using either read-char or read-line, and not both, in a custom program.

Writing Characters and Lines from a File

Writing data to a file is similar to reading data from a file. You can write a single character or a line of text to a file. The write-char function is used to write a single character to a file (the character is based on its ASCII code value), whereas the write-line function is used to write a line of text to a file. When you write individual characters to a file and want to end a line, you pass the write-char function an ASCII code value of 10—the linefeed character. A linefeed character is added to the end of the text that is written with the write-line function.

The following shows the syntax of the write-char and write-line functions:

(write-char number [file_pointer]) (write-line string [file_pointer])

The arguments are as follows:

number The number argument is an integer that represents the ASCII code value of the character to be written to the file specified by the file_pointer argument.

string The string argument is a string that represents the line of text to be written to the file specified by the file_pointer argument.

file_pointer The file_pointer argument is optional and must be of the FILE data type when provided. The value must be one that was returned by the open function. If the file_pointer argument isn't provided, AutoCAD displays the character or text in the command-line window, similar to the prompt function.

Here are examples of writing content to a file with the write-char and write-line functions:

(write-char 66 file_ptr) C (write-line "4\tP366\tPNL3666" file_ptr) 4 P366 PNL3666

Closing an Open File

Each file that you open or create with the open function must be closed using the close function. Closing the file removes it from memory, thereby making it available to other applications, and commits any changes to the file that were made with the write-char and write-line functions. Files that aren't closed remain open in memory and unavailable to other applications until AutoCAD is closed. Closing AutoCAD closes the file, since AutoLISP is executed in the AutoCAD memory space. However, you shouldn't rely on AutoCAD to close the file because it is possible that the file could remain locked in memory until Windows or Mac OS is restarted.

The following is the syntax of the close function:

(close file_pointer)

The file_pointer argument that the close function expects is the same value that was returned by the open function.

Here is an example of the close function:

(close file_ptr) nil

Working with Directories and Files in the Operating System

In addition to the ability to create, read, and write ASCII files, AutoLISP supports a wide range of file- and directory-management functions. Many of these file-management functions were added in AutoCAD 2000. The AutoLISP functions that are available for file-management tasks allow you to do the following:

Locate a file in the AutoCAD support file search paths or in a directory on a local or network drive

Prompt the user for a filename or path

Rename, copy, and delete files

Create directories

Get information about a file: size, system time, filename, file path, and file extension

Locating and Listing Files and Directories

As I mentioned earlier, I don't recommend hard-coding file paths in a custom program. AutoLISP provides several functions that can be used to locate a file or directory in the AutoCAD support file search paths or even outside AutoCAD in the operating system.

Locating Files in the AutoCAD Support File Search Paths

AutoCAD uses a set of locations defined with the options command, known as support file search paths. These locations are used by AutoCAD to find blocks to insert, AutoLISP files to load, customization files to control the user interface, and much more. You can use the AutoLISP findfile function to locate the first instance of a file within the AutoCAD support file search paths. The findfile function returns either the full path of the file it is passed or nil if the file isn't located in one of the directories that are part of the AutoCAD support file search paths.

The following shows the syntax of the findfile function:

(findfile filename)

The filename argument is a string that represents the name of the file you want to locate within the AutoCAD support file search paths.

Here is an example of the findfile function and the value it returned:

; Windows example (findfile "acad.pgp") "C:\\Users\\Lee\\appdata\\roaming\\autodesk\\autocad 2015\\ R20.0\\enu\\support\\acad.pgp" ; Mac OS example (findfile "acad.pgp") "/Users/leeambrosius/Library/Application Support/Autodesk/ roaming/AutoCAD 2015/R20.0/enu/support/acad.pgp" (findfile "ral classic.acb") nil

Where's My File?

The findfile function doesn't search subdirectories, but you can add a relative path to a file that is contained in a subdirectory of one of the AutoCAD support file search paths. For example, on a Windows system the AutoCAD install directory is listed as a support file search path (C:\Program Files\Autodesk\AutoCAD 2015). The AutoCAD install folder contains a subdirectory named Sample, which isn't part of the AutoCAD support file search paths. Under the Sample subdirectory is the VBA subdirectory, and it contains a file named attext.dvb (C:\Program Files\Autodesk\AutoCAD 2015\Sample\VBA\attext.dvb). So, if you enter the following, the findfile function returns nil:

(findfile "attext.dvb")

nil is returned because the attext.dvb file isn't contained in one of the directories listed in the AutoCAD support file search paths; it's hiding in a subdirectory.

You could locate the file attext.dvb by using the following example:

(findfile "sample\\vba\\attext.dvb") "C:\\Program Files\\Autodesk\\AutoCAD 2015\\sample\\vba\\attext.dvb"

In addition to the findfile function, you can use the findtrustedfile function to locate a custom program that is in the AutoCAD support file search and trusted paths. The findtrustedfile function accepts a filename and returns the location of the file if it is trusted or nil if the file isn't trusted. You'll learn about trusted paths in Chapter 20,「Authoring, Managing, and Loading AutoLISP Programs.」

Browsing for a File

There might be times when you or the user of your custom program want to choose a particular ASCII file. Although you could use the getstring function and ask the user for a filename and path, the AutoLISP getfiled function does provide you with a basic file-navigation dialog box. Figure 18.1 shows an example of a dialog box that is titled Create BOM File; this dialog box allows the user to specify the location of an ASCII file with the .bom file extension. The getfiled function returns either a string containing the filename and path specified or nil if the user clicks Cancel.

Figure 18.1 File-navigation dialog box displayed with the getfiled function

The following shows the syntax of the getfiled function:

(getfiled title filename file_extension mode)

Its arguments are as follows:

title Use the title argument to specify a string that represents the title for the dialog box. An empty string ("") indicates that the title should be set based on the value specified by the mode argument. If you don't want to display a title, provide a string with a space (" ").

filename The filename argument is a string that represents the default filename and path that you want the dialog box to use. An empty string ("") opens the dialog box to the default directory, which is typically My Documents on Windows and Documents on Mac OS.

file_extension The file_extension argument is a string that represents the default file extension for filtering the files list or creating new files. You can specify multiple file extensions by separating the entries with a semicolon, such as "bom;txt" to support BOM and TXT files. An empty string ("") or asterisk (*) sets the file type support for the dialog box to All Files (*.*), which displays all file types.

mode The mode argument is an integer that represents a bitcoded value that can contain one or more bitcodes. Table 18.2 lists a few of the available bitcodes.You can learn about the other available modes by searching on the getfiled function in the AutoCAD Help system.

Table 18.2 File-browsing mode argument bitcodes

Code Description

1 Indicates that a new file is being created; the Save button is displayed instead of Open.

4 Allows the user to enter a filename with or without a file extension.

16 Allows you to specify only a file path as part of the filename argument.

32 Indicates that the user shouldn't be prompted when overwriting a file with the same name; the existing file is replaced with the new file.

128 URLs are not allowed.

The following code shows the code statement that was used to display the dialog boxes in Figure 18.1:

(getfiled "Create BOM File" "" "bom" 1) "C:\\Users\\Lee\\Documents\\MyCustomFiles\\Drawing1.bom" ; Windows "/Users/leeambrosius/Documents/MyCustomFiles/Drawing1.bom" ; Mac OS

NOTE

On Windows, if you have Express Tools installed you can use the acet-ui-pickdir function to display a Browse For Folder dialog box, which allows the user to select a directory only. This function is not documented and might be removed in the future, so use it at your own risk.

Listing the Files in a Directory

The findfile and findtrustedfile functions are limited to searching for files in the AutoCAD support file search and trusted paths. You can use the vl-directory-files function to get a list of the files or subdirectories in a specified path, you can then step through the list returned to get the subdirectories and files in a directory. The vl-file-directory-p function can be used to determine if a string contains a valid filename or directory. The vl-file-directory-p function returns T if the string it is passed is of a valid directory path; otherwise, nil is returned.

The following shows the syntax of the vl-directory-files function:

(vl-directory-files [directory filter mode])

The arguments are as follows:

directory The directory argument is an optional string that represents the directory that you want to get subdirectories or files from in the form of a list.

filter The filter argument is an optional string that represents the file pattern for filtering out the subdirectories and files that shouldn't be in the list returned by the function.

mode The mode argument is an optional integer that controls the list returned by the function: subdirectories only (–1), files and subdirectories (0), or files only (1).

The following shows the syntax of the vl-file-directory-p function:

(vl-file-directory-p directory)

The directory argument is a string that represents the directory path you want to verify.

Here are some examples of the vl-directory-files and vl-file-directory-p functions:

; Returns the DOCX files in the My Documents or Documents folder (vl-directory-files (getvar "mydocumentsprefix") "*.docx" 1) ("Agreement 2014.docx") ; Determines if the Temp directory exists on the main drive (Windows) (vl-file-directory-p "c:/temp") nil ; Determines if the Temp directory exists on the main drive (Mac OS) (vl-file-directory-p "/temp") nil

Listing 18.2 shows an example of how you recursively list all the subdirectories contained within a directory. Although this example scans for subdirectories only, you could use the vl-directory-files function to get a list of the files under each directory to locate a specific file that isn't part of the AutoCAD support search paths.

Listing 18.2: Custom function that outputs subdirectory names under a specified directory

; Recursive function used to step into each subdirectory (defun return-nested (parent_dir indent / dir) ; Step through each value in the first returned (foreach dir (vl-directory-files parent_dir "*.*" -1) (if (and (/= dir ".")(/= dir "..")) (progn (terpri) ; Output level indenting (setq indent (strcat indent "|-> ")) (prompt (strcat indent dir)) (setq indent (substr indent 1 (- (strlen indent) 4))) ; Subdirectory found, recurse it as well (if (vl-file-directory-p (strcat parent_dir "\\" dir)) (return-nested (strcat parent_dir "\\" dir) (strcat indent "| ")) ) ) ) ) (princ) ) ; Main function that accepts the top directory to search (defun RecurseDirectory (dir / indent) (setq indent "") ; Check to see if the value passed is a valid directory (if (vl-file-directory-p dir) (progn (terpri) (prompt dir) ; Begin recursing (return-nested dir indent) ) ) (princ) ) ; Function usage example (RecurseDirectory "C:\\Program Files\\Autodesk\\AutoCAD 2015\\Sample") ; Sample output C:\Program Files\Autodesk\AutoCAD 2015\Sample |-> ActiveX | |-> ExtAttr | |-> ExternalCall |-> Database Connectivity | |-> CAO |-> en-us | |-> DesignCenter | |-> Dynamic Blocks |-> Mechanical Sample |-> Sheet Sets | |-> Architectural | | |-> Res | |-> Civil | |-> Manufacturing |-> VBA | |-> VBAIDEMenu

Getting File Locations Using OS Environment Variables

Both Windows and Mac OS support environment variables. These are values that are specific to each operating system (OS), and some of them can be useful in gathering information about the OS and current user. Some OS environment variables contain paths that point to the location of the current user's profile directory. From the user's directory, you can get to the user's AppData directory on Windows or the Library directory on Mac OS, which are used to store local and roaming files specific to the user. The getenv variable is used to obtain the value of an environment variable.

For example, you can use the userprofile variable on a Windows OS to get the current user's home directory; on a Mac OS, you can use the home environment variable to do the same. The following two examples show how to use the getenv function to get the value of an environment variable:

(getenv "userprofile") ; Windows "C:\\Users\\Lee" (getenv "home") ; Mac OS "/Users/leeambrosius"

The getenv function can also be used to get some of the AutoCAD application settings that are stored in the Windows Registry. You learned about the getenv function in Chapter 12. For more information about the environment variables that are supported by your OS, refer to the OS documentation or use your favorite online search engine.

Managing Files and Directories

In addition to the functions that can be used to locate and list files, AutoLISP offers several functions that can be used to manage files that are stored on a local or network drive. These file-management functions are listed in Table 18.3.

Table 18.3 AutoLISP file-management functions

Function Description

vl-file-rename Changes the name of an existing file. Can be used to copy a file whose name was assigned using the vl-filename-mktemp function.

vl-file-copy Creates a copy of an existing file with a new name.

vl-file-delete Removes an existing file; can't be used to remove a directory.

vl-mkdir Creates a new directory.

For more information on these functions, see the AutoCAD Help system.

NOTE

Although there are no AutoLISP functions that allow you to rename or remove a directory, you could use AutoLISP to write a BAT or SH file, which could then be executed from the Windows Command prompt or Terminal on Mac OS with the startapp function. See the AutoCAD Help system for information on the startapp function.

Getting Information about a File

Getting information about a file can be useful, even if it might be only to get the path in which a file resides or its file extension. Table 18.4 lists the functions that can be used either to get information about a file or to extract specific pieces of information from a file path.

Table 18.4 AutoLISP file-related functions

Function Description

vl-file-size Returns the size of the file in bytes

vl-file-systime Returns the last modification date and time for the file

vl-filename-base Returns the name of the file without the path and file extension

vl-filename-directory Returns the path to the file

vl-filename-extension Returns the file's extension

For more information on these functions, see the AutoCAD Help system.

NOTE

On Windows, you can access a File System Object using ActiveX/COM, which can be used to access and manage files in the Windows operating system. I discuss how to use ActiveX with AutoLISP in Chapter 22.

Exercise: Reading and Writing Data

In this section, you will create two new functions that read data from and write data to external files. The first function reads information from a data file and uses that information to add new layers to a drawing. The second function is an extension of the BOM program that you created in Chapter 17. Instead of adding a table grid to a drawing, this new function exports the BOM content to a comma-delimited file that can be imported into a database or spreadsheet program.

The key concepts I cover in this exercise are as follows:

Storing Custom Information Information obtained during the execution of a custom program can be written to the Windows Registry or a Plist file on Mac OS. The information, once stored, can then be read back the next time the program is executed, and used as needed.

Locating and Prompting for External Files Files that a custom program might rely on can be located in the AutoCAD support file search paths before they are used, or the user can be prompted for a filename and location.

Opening, Reading, and Writing Data in External Files Data files can be opened before the data in the file can be read or data can be written to. Once file access is no longer needed, the file should be closed.

NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Creating and Incrementing Room Labels」section of Chapter 17. If you didn't complete the steps, do so now or start with the ch18_building_plan.dwg, ch18_layers.dat, ch18_furntools.lsp, and ch18_utility.lsp sample files available for download from www.sybex.com/go/autocadcustomization. These sample files should be placed in the MyCustomFiles folder under the Documents (or My Documents) folder, or the location you are using to store the LSP files. After the files are saved to the location you are using to store LSP files, remove ch18_ from the filenames.

Creating Layers Based on Data Stored in an External File

Often you start a drawing from a drawing template, which contains a default set of layers, but any layers not used can accidentally be removed with the purge or -purge command. To restore the missing layers, you could create a drawing that contains your default layers and insert it into your drawing. As an alternative on Windows, you could restore the layers using the Content Explorer or the AutoCAD DesignCenter™ palette. An additional approach to restoring layers or named standards is through the use of external data files and AutoLISP.



The ch18_layers.dat file (part of the sample files supplied with this book) contains information that can be used to create layers in a drawing. The createlayer function is defined in the utility.lsp file. The DAT file is tab-delimited and contains three pieces of information about a layer. The information in each line is a layer name, color, and linetype:

; AutoCAD Customization Platform ; Layer data file used to setup layers Plan_Cabinets 6 Continuous Plan_Dimensions 3 Continuous

In these steps, you'll create a custom function named loadlayers that reads and uses the data stored in the file named ch18_layers.dat to create new layers in a drawing:

Create a new LSP file named loadlayers.lsp with Notepad on Windows or TextEdit on Mac OS.

In the text editor area of the loadlayers.lsp file, type the following; the comments are here for your information and don't need to be typed:; Creates layers based on the values in the ch18_layers.dat file. (defun c:LoadLayers ( / layerDataFile lastLoc file_ptr line tabLoc layerList lineTemp) ; Select the layer data file, if not found ; in the AutoCAD support file seach paths (if (= (setq layerDataFile (findfile "ch18_layers.dat")) nil) (progn ; Get the location of the previously selected DAT file ; from the Windows Registry/PLIST file (setq lastLoc (vl-registry-read "HKEY_CURRENT_USER\\Software\\Sybex\\ACP" "LastLayerDataFile")) ; Make sure the value in the Windows Registry/PLIST file is valid (if (= (type lastLoc) 'STR) (setq lastLoc (findfile lastLoc)) ) ; If the file is not valid, prompt for the file (if (= lastLoc nil) (progn (setq lastLoc "") (setq layerDataFile (getfiled "Select Layer Data File" lastLoc "dat" 8)) ) (setq layerDataFile lastLoc) ) ; Store the last location to the Windows Registry/PLIST file (if layerDataFile (vl-registry-write "HKEY_CURRENT_USER\\Software\\Sybex\\ACP" "LastLayerDataFile" layerDataFile) ) ) ) ; Check to see if the user selected a file (if layerDataFile (progn ; Open the file for read-only (setq file_ptr (open layerDataFile "r")) ; Step through the file (while (setq line (read-line file_ptr)) (if (/= (substr line 1 1) ";") (progn ; Reset the variables (setq layerList nil lineTemp line) ; Split the line into elements of a list based on tab characters (while (setq tabLoc (vl-string-search (chr 9) line)) (setq layerList (append layerList (list (setq lineTemp (substr line 1 tabLoc))) )) (setq line (substr line (+ tabLoc 2))) ) ; Add the last part of the line to the list (setq layerList (append layerList (list line))) ; If the list is not empty, use the info to create a new layer (if layerList (createlayer (car layerList) (atoi (cadr layerList))) ) ) ) ) ; Close the file (close file_ptr) ) ) (princ) )

Click File Save.

Adding Layers to a Drawing with the loadlayers Function

The loadlayers.lsp file contains the main loadlayers function, which uses the createlayer function defined in the utility.lsp file.

NOTE

The following steps require a data file named ch18_layers.dat. If you didn't download the sample files previously, download them now from www.sybex.com/go/autocadcustomization. Place these sample files in the MyCustomFiles folder under the Documents (or My Documents) folder.

The following steps explain how to use the loadlayers function that is in the loadlayers.lsp file:

Create a new drawing.

Start the appload command. Load the LSP files loadlayers.lsp and utility.lsp. If the File Loading - Security Concerns message box is displayed, click Load.

At the Command prompt, type loadlayers and press Enter.

If the Select Layer Data File dialog box opens, browse to and select the ch18_layers.dat file, which you should have copied to the MyCustomFiles folder under the Documents (or My Documents) folder. The Select Layer Data File dialog box is displayed only if the AutoLISP program couldn't locate the ch18_layers.dat file.

Click Open.

Do one of the following and review the layers that have been added: On the ribbon, click the Home tab Layers panel Layer Properties (Windows).

On the Layers palette, click the Layers drop-down list (Mac OS).

Open the ch18_layers.dat file in Notepad on Windows or TextEdit on Mac OS using the same process you follow to open an LSP file.

Click at the end of the last line; it starts with Plan_Walls.

In the text editor area, type the following (press the Tab key rather than typing the text <tab>):Title_Block<tab>7<tab>Continuous

Save the changes to the ch18_layers.dat file.

In AutoCAD, run the loadlayers function again; notice that the layer Title_Block is now added to the drawing.

Writing the Bill of Materials to an External File

In Chapter 17, you created a set of functions that allowed you to extract the attributes of a block and then quantify the results before creating the BOM in the drawing. Here, you will create a function named furnbomexport that allows you to export the BOM data generated with the extAttsFurnBOM function output to an external file instead of adding it to the drawing as a table grid as you did with the furnbom function.

Using these steps, you will create the custom function named furnbomexport in the file furntools.lsp, which you created in Chapter 16.

Open the furntools.lsp file with Notepad (Windows) or TextEdit (Mac OS).

In the text editor area of the furntools.lsp file, click at the end of the last line in the file and press Enter twice.

Type the following:; Exports the extracted attribute information to an external data file (defun c:FurnBOMExport ( / ssFurn eaList bomDataFile file_ptr item) ; Get the blocks to extract (setq ssFurn (ssget '((0. "INSERT")))) ; If ssFurn is not nil proceed (if ssFurn (progn (setq bomDataFile (getfiled "Create CSV File" "" "csv" 1)) ; Check to see if the user selected a file (if bomDataFile (progn ; Extract and quantify the parts in the drawing (setq eaList (extAttsFurnBOM ssFurn)) ; Open the file for read-only (setq file_ptr (open bomDataFile "w")) ; Write the header line to the file (write-line "QTY,LABELS,PARTS" file_ptr) ; Step through the list (foreach item eaList (write-line (strcat (car item) "," (cadr item) "," (caddr item)) file_ptr) ) ; Close the file (close file_ptr) ) ) ) ) (princ) )

Click File Save.

Using the furnbomexport Function

The furntools.lsp file contains the main furnbomexport function, but some of the helper functions in furntools.lsp use functions defined in the utility.lsp file.

NOTE

The following steps require a drawing file named ch18_building_plan.dwg. If you didn't download the sample files previously, download them now from www.sybex.com/go/autocadcustomization. Place these sample files in the MyCustomFiles folder under the Documents (or My Documents) folder.

The following steps explain how to use the furnbomexport function that is in the furntools.lsp file:

Open ch18_building_plan.dwg.

Start the appload command. Load the LSP files furntools.lsp and utility.lsp. If the File Loading - Security Concerns message box is displayed, click Load.

At the Command prompt, type furnbomexport and press Enter.

At the Select objects: prompt, select the furniture blocks in the plan and press Enter.

When the Create CSV File dialog box opens, browse to the MyCustomFiles folder or the folder in which you want to create the CSV file.

In the File Name text box, type furnbom and click Save.

Open Windows Explorer or File Explorer on Windows, or Finder on Mac OS.

Browse to the location of the furnbom.csv file and open the file in Notepad, TextEdit, or even an application like Microsoft Excel.Figure 18.2 shows the results of opening the furnbom.csv file in Excel.

Figure 18.2 BOM content in Excel