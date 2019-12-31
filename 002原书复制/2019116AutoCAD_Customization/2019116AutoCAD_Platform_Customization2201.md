The following is an example that loads a LSP file named maincmds.lsp with the autoload function when either the drawrectangle, drawcircle, loadlayers, or inserttitleblock function is typed at the Command prompt by the user:

(autoload "maincmds" '("drawrectangle" "drawcircle" "loadlayers" "inserttitleblock"))

Plug-in Bundles Plug-in bundles allow you to load LSP and other custom files in AutoCAD 2013 or later. A plug-in bundle is a folder structure with a special name and metadata file that describes the files contained in the bundle. I discuss plug-in bundles in the「Defining a Plug-in Bundle」section later in this chapter.

Table 20.1 Automatically loaded LSP files

Filename Description

acad.rx Lists each ObjectARX application (ARX) file that should be loaded. This file is not created by default; it is a file that you must create. Most ARX files are loaded on demand using special entries in the Windows Registry or property list (Plist) files on Mac OS.

acad<release>.lsp A release-specific LSP file that is loaded once per AutoCAD session, at startup. <release> is a value that represents the release of AutoCAD. For example, AutoCAD 2015 looks for the file named acad2015.lsp, AutoCAD 2014 looks for the file named acad2014.lsp, AutoCAD 2013 looks for the file named acad2013.lsp, and so on.

acad.lsp A LSP file that is loaded once per AutoCAD session, at startup. If the acadlspasdoc system variable is set to 1, the file is loaded with each drawing just like acaddoc.lsp. The acad.lsp file must be created if you want to use it since it is not part of the AutoCAD installation. I discussed how to create a LSP file in the「Creating an AutoLISP File」section earlier in this chapter.

acad<release>doc.lsp A release-specific LSP file that is loaded with each drawing file that is opened. <release> is a value that represents the release of AutoCAD. For example, AutoCAD 2015 looks for the file named acad2015doc.lsp, AutoCAD 2014 looks for the file named acad2014doc.lsp, AutoCAD 2013 looks for the file named acad2013doc.lsp, and so on.

acaddoc.lsp A LSP file that is loaded with each drawing file that is opened. The file acaddoc.lsp must be created if you want to use it since it is not part of the AutoCAD installation.

<filename>.mnl MNL files are associated with CUI/CUIx files that are used to define the AutoCAD user interface. When a CUI/CUIx file is loaded, AutoCAD looks for an MNL file with the same name and loads it if found. MNL files are loaded in the same order that CUI/CUIx files are. CUI/CUIx files are loaded in the order of partial files to the Main CUI/CUIx file, Main CUI/CUIx file, partial files to the Enterprise CUI/CUIx file, and then the Enterprise CUI/CUIx file.

Using the Load/Unload Applications Dialog Box to Load a LSP File

The Load/Unload Applications dialog box (appload command) is the easiest way to load a LSP file into AutoCAD on Windows or Mac OS. Many of the other methods provide better integration into a user's workflow, but they require you to define where the LSP files are located. I describe in the next section how to set up and identify the folders AutoCAD should look in for custom files.

The following steps explain how to load the mylisp.lsp file that you created in the「Creating an AutoLISP File」section earlier.

NOTE

If you did not complete the steps in the「Creating an AutoLISP File」section, you can use the ch20_mylisp_complete.lsp file that is part of the samples files for this book (available from this book's web page at www.sybex.com/go/autocadcustomization) that you copied to a folder named MyCustomFiles in your Documents (or My Documents) folder. Once the sample file is stored on your system, remove the characters ch20_ from the filename. If you placed the sample files in a different folder, you will need to make the appropriate changes to the file selected in step 2.

Do one of the following:

On the ribbon, click the Manage tab Customization panel Load Application (Windows).

On the menu bar, click Tools Load Application (Mac OS).

At the Command prompt, type appload and press Enter (Windows and Mac OS).

When the Load/Unload Applications dialog box (see Figure 20.2) opens, browse to the MyCustomFiles folder and select the mylisp.lsp file. Click Load.

TIP

If the Add To History check box is selected when you click Load, AutoCAD adds the selected file to a list box on the History tab. Click the History tab and then select the file you want to load. Then click Load to load the file.

If the File Loading - Security Concern message box is displayed, click Load. You'll learn which paths contain custom files that should be trusted in the「Identifying Trusted Locations」section and the sidebar「Restricting Custom Applications」later in this chapter.

Click Close to return to the drawing area.

At the Command prompt, type msg and press Enter. A message box with the text First AutoLISP file is displayed (see Figure 20.1).

Click OK to close the message box.

Press F2 on Windows or Fn-F2 on Mac OS. You should see the message Version 1.0 – My AutoLISP Programs displayed in the command-line window.

Create a new drawing.

At the Command prompt, type msg and press Enter. The message Unknown command "MSG". Press F1 for help. is displayed.

NOTE

If you are using AutoCAD 2014 or later, typing msg in step 9 might start the mspace or another command. If you don't see the Unknown command message, you will need to disable AutoCorrect. To disable AutoCorrect, at the AutoCAD Command prompt type -inputsearchoptions and press Enter. Then type r and press Enter. Type n and press Enter twice. Repeat step 9 and you should see the expected results.

Figure 20.2 Loading a custom program

You can use the following steps to add the LSP file named mylisp.lsp to the Startup Suite you created in the「Creating an AutoLISP File」section.

Do one of the following:

On the ribbon, click the Manage tab Customization panel Load Application (Windows).

On the menu bar, click Tools Load Application (Mac OS).

At the Command prompt, type appload and press Enter (Windows and Mac OS).

When the Load/Unload Applications dialog box opens, in the Startup Suite section, click Contents.

When the Startup Suite dialog box (see Figure 20.3) opens, click Add (Windows) or + (Mac OS).

In the Add File to Startup Suite dialog box, browse to the MyCustomFiles folder and select the mylisp.lsp file. Click Open.

In the Startup Suite dialog box, click Close.

In the Load/Unload Applications dialog box, click Close.

At the Command prompt, type msg and press Enter. A message box with the text First AutoLISP file is displayed.

Click OK to close the message box.

Create a new drawing.

At the Command prompt, type msg and press Enter. A message box with the text First AutoLISP file is displayed. This is expected because the mylisp.lsp file is loaded into the new drawing as a result of being added to the Startup Suite.

Click OK to close the message box.

Figure 20.3 Adding a LSP file to the Startup Suite

Managing the Locations of AutoLISP Files

The LSP files that you create or download from the Internet can be placed in any folder on your local or network drive. I recommend placing all your custom LSP files in a single folder on a network drive so they can be accessed by anyone in your company who might need them. You might consider using the name LSP Files or AutoLISP Files for the folder that contains your LSP files.

I also recommend marking any folder(s) that contains custom files on the network as read-only for everyone except for those designated to make updates to the files. Marking the folders as read-only helps prevent undesired or accidental changes. Chapter 10,「Using, Loading, and Managing Custom Files,」discussed file management.

Regardless of which folder name you use or where you choose to place your LSP files, you need to let AutoCAD know where these files are located. To do so, add each folder that contains LSP files to the Support File Search Path and Trusted Locations settings of the Options dialog box (Windows) or Application Preferences dialog box (Mac OS).

NOTE

The following sections assume you have created a folder named MyCustomFiles in the Documents (or My Documents) folder for the exercises and sample files that are part of this book. (If you haven't already, you can download the files from www.sybex.com/go/autocadcustomization.) If you placed the sample files in a different folder or are using your own folder, select that folder instead when prompted to browse to a folder as part of the steps.

Specifying Support File Search Paths

The support file search paths are used by AutoCAD to locate custom files, such as those that contain block definitions, linetype patterns, and AutoLISP programs. Use the Options dialog box on Windows and the Application Preferences dialog box on Mac OS to add the folders that contain LSP files to the support file search paths of AutoCAD.

The following steps explain how to add the folder named MyCustomFiles to the support file search paths used by AutoCAD:

Click the Application menu button Options (or at the Command prompt, type options and press Enter).

When the Options dialog box opens, click the Files tab.

Select the Support File Search Path node. Click Add and then click Browse.

In the Browse For Folder dialog box, browse to the MyCustomFiles folder that you created for this book in the Documents (or My Documents) folder, or browse to the folder that contains the LSP files.

Select the folder that contains your LSP files and click OK.

Click OK to save the changes to the Options dialog box.

If you are using AutoCAD on Mac OS, use these steps:

On the menu bar, click AutoCAD <release> Preferences (or at the Command prompt, type options and press Enter).

When the Application Preferences dialog box opens, click the Application tab.

Select the Support File Search Path node.

Near the bottom of the dialog box, click the plus sign (+).

In the Open dialog box, browse to the MyCustomFiles folder that you created for this book in the Documents folder, or browse to the folder that contains the LSP files.

Select the folder that contains the LSP files and click Open.

Click OK to save the changes to the Application Preferences dialog box.

You can edit an existing folder in the Options or Application Preferences dialog box by expanding the Support File Search Path node and selecting the folder you want to edit. After selecting the folder to edit, click Browse in Windows or double-click the folder on Mac OS, and then select the new folder.

TIP

You can test to see whether AutoCAD can locate a file that might be in the support file search paths by using the AutoLISP findfile function. For example, type (findfile "mylisp.lsp") at the AutoCAD Command prompt to see if the file named mylisp.lsp is in one of the support file search paths. The location of the file is returned if it is found or nil if the file is not found.

It is possible with AutoLISP to get a listing of which folders have been added to the Support File Search Paths setting using the acadprefix system variable. The acadprefix system variable can return a listing of folders, but it doesn't allow you to update which folders should be used. However, you can use the ACAD environment variable to update which folders are used.

The following code shows an example of adding a folder named lsp files (which is at the root level of the C: drive on Windows) to the support file search paths using the ACAD environment variable:

(setenv "ACAD" (strcat (getenv "ACAD") ";c:\\lsp files;"))

If you are using AutoCAD on Mac OS, the same sample would look like this:

(setenv "ACAD" (strcat (getenv "ACAD") ";/lsp files;"))

You must place a semicolon before the location you are adding; including a semicolon after the location is not required. Typically, a semicolon is provided by AutoCAD after the last location, but you should check to see whether there is one. If you add the location with a semicolon before the path and a semicolon is provided by AutoCAD, resulting in back-to-back semicolons, the second semicolon is removed by AutoCAD.

NOTE

If the location added with the ACAD environment variable is invalid, AutoCAD doesn't remove the invalid location. You might receive a message when you make changes to the Options or Application Preferences dialog box. Although it is possible to add the same location more than once with the ACAD environment variable, AutoCAD removes the duplicate entries in most cases. You should avoid adding duplicate locations, since it can increase the time it takes AutoCAD to locate a file.

Identifying Trusted Locations

If you are using AutoCAD 2013 SP1 or later on Windows or AutoCAD 2014 on Mac OS, when you try to load a LSP file, AutoCAD checks to see if that LSP file is being loaded from a trusted location. A folder that you identify as a trusted location contains LSP files that are safe to be loaded without user interaction. Any LSP file that isn't loaded from a trusted location results in the File Loading - Security Concern message box (see Figure 20.4) being displayed.

Figure 20.4 This security warning informs you of a LSP file being loaded from an untrusted location.

The File Loading - Security Concern message box indicates why it might not be a good idea to load the file if its origins aren't known. While the message box is displayed, the user can decide to either load or not load the file that AutoCAD is attempting to load. When adding new trusted locations, you want to make sure you limit the number of folders you trust, and those that are trusted should be marked as read-only to avoid the introduction of unknown LSP files to the folders. For more information on trusted paths, see the trustedpaths system variable in the AutoCAD Help system.

NOTE

A folder that you identify as a trusted location must also be listed in the Support File Search Paths setting of the Options or Application Preferences dialog box.

The following steps explain how to add the folder named MyCustomFiles to the trusted locations that AutoCAD can use to safely load LSP and other custom programs.

Click the Application menu button Options (or at the Command prompt, type options and press Enter).

When the Options dialog box opens, click the Files tab.

Select the Trusted Locations node and click Add, and then click Browse.

In the Browse For Folder dialog box, browse to the MyCustomFiles folder that you created for this book in the Documents (or My Documents) folder, or browse to the folder that contains your LSP files.

Select the folder that contains your LSP files and click OK.

If the selected folder is not marked as read-only, the Trusted File Search Path - Security Concern dialog box is displayed. Click Continue to add the folder.

Click OK to save the changes to the Options dialog box.

If you are using AutoCAD on Mac OS, use these steps:

At the AutoCAD Command prompt, type (setq mydocs (getvar "mydocumentsprefix")) and press Enter. The location of the My Documents folder is assigned to the user-defined variable mydocs.

At the Command prompt, type (setq trustedpath (strcat mydocs "/MyCustomFiles/")) and press Enter. The path to the MyCustomFiles folder is assigned to the user-defined variable trustedpath. Use a different folder name or location here if the LSP files are stored in a different folder.

At the Command prompt, type (setq trustedpaths (strcat (getvar "trustedpaths") ";" trustedpath ";")) and press Enter. The path you provided and those that are already trusted are appended together and assigned to the user-defined variable trustedpaths.

At the Command prompt, type (setvar "trustedpaths" trustedpaths) and press Enter. The paths in the user-defined variable trustedpaths are assigned to the trustedpaths system variable.

You can also use these steps for adding a trusted location in AutoCAD on Mac OS with AutoCAD on Windows. Instead of using forward slashes in step 2, use two backward slashes to be consistent with the value returned by the mydocumentsprefix system variable in step 1. For step 2, you would type (setq trustedpath (strcat mydocs "\\MyCustomFiles\\")).

TIP

You can test to see whether AutoCAD can locate a file in a trusted location by using the AutoLISP findtrustedfile function. For example, type (findtrustedfile "mylisp.lsp") at the AutoCAD Command prompt to see if the file named mylisp.lsp is in a trusted location and the AutoCAD support file search paths. The location of the file is returned if it is found or nil if the file is not found.

Restricting Custom Applications

Starting with AutoCAD 2013 SP1, Autodesk introduced some new security measures to help reduce potential threats or viruses that could affect AutoCAD and the drawing files you create. These security measures allow you to do the following:

Disable the loading of executable code when AutoCAD is started using the /nolisp (AutoCAD 2013 SP1 on Windows), /safemode (AutoCAD 2014 on Windows), or -safemode (AutoCAD 2014 on Mac OS) command-line switch.

Automatically load and execute specially named files: acad.lsp, acad.fas, acad.vlx, acaddoc.lsp, acaddoc.fas, acaddoc.vlx, and acad.dvb.

In AutoCAD 2014, you can use the secureload system variable to control whether AutoCAD will load files only from trusted locations or allow you to load custom files from any location. I recommend setting secureload to 2 and loading custom files only from a secure and trusted location. However, the default value of 1 for secureload is also fine since it displays a message box when AutoCAD tries to load a file from a nontrusted location. Don't set secureload to 0, thereby disabling the security feature, because it could result in your system loading a malicious program.

Deploying AutoLISP Files

Deployment is the process or processes used to allow others to access the LSP and custom files that you create. You might only need to worry about getting your files into the hands of those working at your company, but you might also want to send your files out to the subcontractors that your company works with. Sharing your custom files with subcontractors can help shorten turnaround times and makes it easier to share drawings back and forth.

Deploying custom programs internally and externally are similar processes, but you may encounter some issues. Here are some issues that you need to consider when you are ready to deploy LSP files to others, either internally or externally:

Locating Any file or folder paths used in your LSP files should be dynamic and not static. Never assume that there will always be a C drive or a specific network drive and folder structure on the workstation on which the LSP files will be loaded. Your programs should be designed to look for any files it needs as part of the Support File Search Path setting in the Options or Application Preferences dialog box. You learned how to add a folder to the Support File Search Path setting in the「Managing the Locations of AutoLISP Files」section earlier in this chapter.

Naming Autodesk recommends, although it is completely optional, adding a unique prefix to the beginning of your custom functions, even to global variables. This unique prefix will help you avoid potential conflicts when your LSP files are loaded into AutoCAD on a workstation that could have unknown custom programs loaded as well. For example, I use hypr_ as my prefix of choice (it's a shortened version of HyperPics). A function name of c:drawplate would become c:hypr_drawplate. You could then create a custom (CUI/CUIX) file that adds your functions to the user interface or an alias-like LSP file that makes it easier to access your functions. Though not necessary—nor does it stop others from using your prefix—you can register the prefix you want to use at usa.autodesk.com/adsk/servlet/index?id=1075006&siteID=123112.

Testing Testing is a must when you begin deploying your files. I can't overemphasize how important testing is when you deploy your LSP files. You want to make sure your programs execute as expected on various workstations running AutoCAD. I discuss some common testing techniques in Chapter 19,「Catching and Handling Errors.」

Documenting Documentation is a key element you should consider providing for those who will install or use your LSP files. You should offer some basic documentation so end users understand the functions that are exposed. Explain how to resolve any common problems they might have with your LSP files. I mention how to register help to custom functions in the「Implementing Help for Custom Functions」section later in this chapter.

Distributing Make sure you have the rights to redistribute all support files that the LSP files might need. Typically, the only files that are commonly licensed are TrueType font (TTF) files, but licensing can extend to any files that you or your company have purchased or maybe even downloaded for free from the Internet.

Updating Create a plan to keep files up to date. Updating is something you need to consider before you deploy your custom files the first time.

Deployment Methods (Local vs. External)

Releasing custom and LSP files to others in your company is often fairly straightforward because the files were developed around a set of known conditions; where files are located and which files are available is known, along with how AutoCAD was installed and configured. Internally, you can simply push your files to a location on the network and configure AutoCAD to look for the files there, as you learned earlier, in the「Managing the Locations of AutoLISP Files」section.

Once you post the files, users can load them manually as they are needed, or you can use one of the methods from the section「Loading AutoLISP Files.」You can also create and post a CUI/CUIx file for AutoCAD to load so that the user can load and access the functions in the LSP files without understanding how to load a LSP file. You learned about customizing the user interface in Chapters 5 and 6.

Once a user can access and load the LSP files, I recommend providing basic instructions or even an informal training session to help them use the custom programs that you created. Making it as easy as possible for users to learn your custom programs will go a long way—it can mean the difference between a successful or a failed deployment. If users are confused, they are less likely to embrace the custom programs and the benefits they provide.

If you plan to deploy your custom programs to individuals outside your company, ask yourself the following questions:

How will the user obtain your custom programs? Will you post them on a website or deliver them as an Autodesk® Exchange app that can be used with AutoCAD on Windows? Posting the files directly on a website does allow you to support both Windows and Mac OS.

How will the user set up your custom programs? If a utility is free, users are usually a little more open to doing some work to get it recognized and loaded into AutoCAD. However, if you are expecting a user to pay for a program, their expectations change and you should consider using a plug-in bundle or creating an installer to make the deployment as easy and as error-free as possible.

How will the user get help or support when there is a problem? A website is often the best solution when it comes to providing troubleshooting information or explaining how to use a program since it can be updated frequently. However, not all users have access to the Internet from their workstation. As shocking as it might be, it is not uncommon to have no connection or a limited connection at some companies. The level of support and documentation that you provide should be a direct representation of how simple or complex a program is to learn, along with the fee you are charging. A simple program will commonly require far less documentation than one that offers a lot of functionality or is complex. Users often expect less documentation when a custom program is free compared to when they are paying for it.

You can use one of three main methods to deploy your custom programs externally (or even internally):

Manually A manual deployment is conducted when a user follows a detailed set of written instructions that explain how to set up the folder structure necessary for your custom program and then configures AutoCAD to look for the custom programs. After creating the folder structure and copying the files, the user commonly adds the necessary folders to the AutoCAD Support File Search Path and Trusted Locations settings, as explained in the「Managing the Locations of AutoLISP Files」section earlier in this chapter. Then they load the LSP files as necessary, as discussed in the「Loading AutoLISP Files」section. This approach is used frequently for many free AutoLISP programs found on the Internet. Although this is a low-cost approach, it can be error prone and is not ideal when the program needs to be set up on dozens of workstations.

Plug-in Bundle A plug-in bundle is a folder structure that contains a manifest file that defines all the files making up the bundle and how AutoCAD should load the files within the bundle. A bundle can contain LSP, CUIx, MNL, help/documentation, and many other types of files. Because the manifest file tells AutoCAD how to load the files contained in the bundle, you don't need to provide much in the form of instructions that explain how your custom programs need to be set up. To use a plug-in bundle, after you create the manifest file and set up the desired folder structure, you simply copy all folders and files that make up the bundle to the ApplicationAddins or ApplicationPlugins folder on each workstation the bundle should be available on. Plug-in bundles were first supported in AutoCAD 2013 on Windows and Mac OS, and you can develop them so that they work across multiple AutoCAD releases, AutoCAD-based products, and operating systems. You'll learn the basics of defining a plug-in bundle in the upcoming section,「Defining a Plug-in Bundle.」

Installer An installer provides you with a professional-looking front end that can automate the same steps that a user might follow to manually set up your custom program. Many different types of applications are available that you can use to create an installer, such as InstallAware Studio, InstallShield, Setup Factory, and even Microsoft Visual Studio Professional or higher on Windows. If you are using Mac OS, you can use an application such as PackageMaker or Disk Utility. You can use an installer to copy and remove files related to a plug-in bundle, or you can design it to perform a variety of tasks that can help users configure AutoCAD. You can configure many installers to allow for maintenance releases or to provide a way for a user to upgrade an existing installation to a newer release.

NOTE

If you are using any of the specially named files—such as acad.lsp or acaddoc.lsp—that AutoCAD looks for at startup to load your custom LSP files, you will need to figure out a different way to get them loaded before deploying the files outside your company. You don't want to affect another company's custom programs when they try to use your custom programs, so consider using a bundle plug-in or CUI/CUIx with/without an MNL file to get your LSP files loaded into AutoCAD.

Defining a Plug-in Bundle

A plug-in bundle, as I previously mentioned, is one of the methods that can be used to deploy your LSP files. Fundamentally, a bundle is simply a folder structure with its topmost folder having .bundle appended to its name and a manifest file with the filename PackageContents.xml located in the topmost folder. You can use Windows Explorer or File Explorer on Windows, or Finder on Mac OS, to define and name the folder structure of a bundle. The PackageContents.xml file can be created with a plain ASCII text editor, such as Notepad on Windows or TextEdit on Mac OS.

The following is an example PackageContents.xml file that defines the contents of a bundle named DrawPlate.bundle that contains three files: a help file named DrawPlate.htm, and two LSP files named DrawPlate.lsp and Utility.lsp:

<?xml version="1.0" encoding="utf-8"?><!DOCTYPE component PUBLIC "-//JWS//DTD WileyML 20110801 Vers 3Gv2.0//EN" "Wileyml3gv20-flat.dtd"><Components Description="All OSs"> <RuntimeRequirements OS="Win32|Win64|Mac" SeriesMin="R19.0" Platform="AutoCAD*" SupportPath="./Contents/" /> <ComponentEntry Description="Main LSP file" AppName="DrawPlateMain" Version="1.0" ModuleName="./Contents/DrawPlate.lsp"> </ComponentEntry> <ComponentEntry Description="Utility LSP file" AppName="UtilityFunctions" Version="1.0" ModuleName="./Contents/Utility.lsp"> </ComponentEntry> </Components> </ApplicationPackage>

The folder structure of the bundle that the PackageContents.xml file refers to looks like this:

DrawPlate.bundle PackageContents.xml Contents DrawPlate.lsp DrawPlate.htm Utility.lsp

I have provided the DrawPlate.bundle as part of the sample files for this book, but you will also learn how to create the DrawPlate.bundle yourself later in this chapter. To use the bundle with AutoCAD, copy the DrawPlate.bundle folder and all of its contents to one of the following locations so that all users can access the files:

%ALLUSERSPROFILE%\Application Data\Autodesk\ApplicationPlugIns (Windows XP)

%ALLUSERSPROFILE%\Autodesk\ApplicationPlugIns (Windows 7 or Windows 8)

/Applications/Autodesk/ApplicationAddIns (Mac OS)

If you want a bundle to be accessible only by a specific user, place that bundle into one of the following locations under that user's profile:

%APPDATA%\Autodesk\ApplicationPlugIns (Windows)

˜/Autodesk/ApplicationAddIns (Mac OS)

For additional information on the elements used to define a PackageContents.xml file, perform a search in the AutoCAD Help system on the keyword「PackageContents.xml.」

NOTE

The appautoload system variable controls when bundles are loaded into AutoCAD. By default, bundles are loaded at startup, when a new drawing is opened, and when a plug-in is added to the ApplicationPlugins or ApplicationAddIns folder. You can use the appautoloader command to list which bundles are loaded or reload all the bundles that are available to AutoCAD.

Implementing Help for Custom Functions

Earlier in this chapter, I discussed the importance of using comments to document the AutoLISP expressions that make up your custom functions and AutoLISP programs. In addition to comments, when you create new functionality using AutoLISP you should create documentation for the users; the importance of user documentation is often overlooked by developers. Documentation can range from being as basic as a few sentences to something that is much more comprehensive and explains how to use all the functions that are exposed as part of your LSP files when they are loaded.

The AutoLISP help and setfunhelp functions are used to access the AutoCAD Help facility. Based on the release or platform on which you are developing, these functions support some or all of the following file types:

HTM/HTML

Plain ASCII text (TXT)

Microsoft Help (CHM) – Windows only

WinHelp (HLP) – Windows only

The following shows the syntax for the AutoLISP help function:

(help [filename [help_topic [chm_window_cmd]]])

Its arguments are as follows:

filename The filename argument is a string that represents the name of the HTM, HTML, CHM, HLP, or TXT file that is to be opened by the AutoCAD Help facility. You must specify both the filename and path. This argument is optional, and AutoCAD opens the Help system if it is not provided.

help_topic The help_topic argument is a string that represents the standard AutoCAD Help topic to open or the topic file to open when a CHM file is specified by the filename argument. This argument is optional and only used when a CHM file is specified.

chm_window_cmd The chm_window_cmd argument is an integer used to control the behavior of the HTML Help window that is opened for a CHM file. This argument is optional and available only when a CHM file is specified.

Here are some example expressions that demonstrate the use of the AutoLISP help function:

; Opens the AutoCAD Help system with no topic (help) ; Opens the reference topic for the AutoCAD Rectang command (help "" "rectang") ; Opens the specified URL in the system's default web browser (help "http://www.sybex.com/go/autocadcustomization") ; Opens a local HTML file on Windows (help "C:\\Program Files\\Autodesk\\AutoCAD 2015\\Help\\augi.htm") ; Opens a local HTML file on Mac OS (help "/Applications/Autodesk/AutoCAD 2015/AutoCAD 2015.app/Contents/Resources/ExtendedResources.htm") ; Opens a CHM file named acadauto to the topic idh_lightweightpolyline_object (help "C:\\Program Files\\Common Files\\Autodesk Shared\\acadauto.chm" "idh_lightweightpolyline_object")

The following shows the syntax for the AutoLISP setfunhelp function:

(setfunhelp function_name [filename [help_topic [chm_window_cmd]]])

Its arguments are as follows:

function_name The function_name argument represents the user-defined function prefixed with C: with which you want to associate a help file or topic.

filename The filename argument is a string that represents the name of the HTM, HTML, CHM, HLP, or TXT file that is to be opened by the AutoCAD Help facility. You must specify both the filename and path. This argument is optional, and AutoCAD opens the Help system if it is not provided.

help_topic The help_topic argument is a string that represents the standard AutoCAD Help topic to open or the topic file to open when a CHM file is specified by the filename argument. This argument is optional and used only when a CHM file is specified.

chm_window_cmd The chm_window_cmd argument is an integer used to control the behavior of the HTML Help window that is opened for a CHM file. This argument is optional and available only when a CHM file is specified.

Here are some examples that demonstrate the use of the AutoLISP setfunhelp function. These examples are based on the existence of an AutoLISP function named c:drawplate. When the c:drawplate function is active or its name is entered at the Command prompt, the topic associated with the function is displayed when the user presses F1.

; Launches the the AutoCAD help system with no topic (setfunhelp "c:drawplate") ; Opens the reference topic for the AutoCAD Rectang command (setfunhelp "c:drawplate" "" "rectang") ; Opens the specified URL in the system's default web browser (setfunhelp "c:drawplate" "http://www.sybex.com/go/autocadcustomization") ; Opens a local HTML file on Windows (setfunhelp "c:drawplate" "C:\\Program Files\\Autodesk\\AutoCAD 2015\\Help\\augi.htm") ; Opens a local HTML file on Mac OS (setfunhelp "c:drawplate" "/Applications/Autodesk/AutoCAD 2015/ AutoCAD 2015.app/Contents/Resources/ExtendedResources.htm") ; Opens a CHM file named acadauto to the topic idh_lightweightpolyline_object (setfunhelp "c:drawplate" "C:\\Program Files\\Common Files\\Autodesk Shared\\acadauto.chm" "idh_lightweightpolyline_object")

Exercise: Deploying the drawplate Function

In this section, you will continue to work with the drawplate function that was originally introduced in Chapter 12,「Understanding AutoLISP.」You worked with the drawplate function in Chapter 19 and added error handling and undo grouping to the function. The key concepts I cover in this exercise are as follows:

Identifying the Locations of Your LSP Files AutoCAD needs to know where your LSP files are so that it can locate them and know which locations are trusted.

Loading a LSP File on Demand and by Reference AutoLISP files should be loaded only as they are needed whenever possible to help save on system resources.

Connecting Custom Help Supporting basic help files is something many developers overlook, but this support can help give your programs a polished and professional look. Users also appreciate when there is some form of self-help that might aid them in solving a problem they are having or learning about a feature.

Creating and Deploying Plug-in Bundles Plug-in bundles can make deploying AutoLISP programs easier than having to set up support file search paths and trusted locations on multiple machines, and it allows you to support multiple releases of a program with much greater ease.

NOTE

The steps in this exercise depend on the completion of the steps in the「Exercise: Handling Errors in the drawplate Function」section of Chapter 19. If you didn't complete the steps, do so now or start with the ch20_drawplate.lsp and ch20_utility.lsp sample files available for download from www.sybex.com/go/autocadcustomization. You will also need the packagecontents.xml and drawplate.htm sample files. Place these sample files in the MyCustomFiles folder under the Documents (or My Documents) folder or in the location you are using to store the LSP files. Once you've stored the sample files on your system, remove the characters ch20_ from the name of each file.

Loading the utility.lsp File by Reference

When an AutoLISP program relies on the functions defined in another LSP file, it is common practice to use the load function to ensure that the functions in the LSP file are made available. Up until now, you have been manually loading the utility.lsp file each time you wanted to use the functions that are defined in the file.

The following steps explain how to load the utility.lsp file when drawplate.lsp is loaded into AutoCAD:

Open the drawplate.lsp file in Notepad on Windows or TextEdit on Mac OS.

In the text editor area, add the following before any other comments or AutoLISP expressions in the file:; Load the utility.lsp file (load "utility.lsp")

Click File Save.

NOTE

The load function can be used with a menu macro to load a LSP file from the AutoCAD user interface.

Loading the drawplate.lsp File on Demand

Loading all your AutoLISP programs at startup is an option using load statements in a LSP file such as acad.lsp or acaddoc.lsp, but you should load only the files when they are needed. The autoload function is a way to inform AutoCAD that you have a set of custom functions that are standing by and ready for use. Instead of using multiple load statements in acad.lsp or acaddoc.lsp, I recommend using autoload statements to make your functions available and load the associated LSP file upon the function's first use.

In these steps, you create a new LSP file named myautoloader.lsp that will load the drawplate.lsp file when the user enters drawplate at the Command prompt:

Create a new LSP file named myautoloader.lsp with Notepad on Windows or TextEdit on Mac OS.

In the text editor area of the myautoloader.lsp file, type the following:; Demand loads the drawplate.lsp file (autoload "drawplate" '("drawplate"))

Click File Save.

NOTE

If your company doesn't already have an acad.lsp file, you could rename myautoloader.lsp to acad.lsp and let AutoCAD load the file automatically. Use the statement (findfile "acad.lsp") to determine whether a file named acad.lsp already exists in the support file search paths of your AutoCAD installation. If nil is returned, AutoCAD couldn't locate an instance of the acad.lsp file.

Enabling Help Support for the drawplate Function

Providing basic help support for your programs can go a long way, especially if you leave the company someday or want to eventually sell your custom program.

In these steps, you enable contextual help for the drawplate function:

Open the drawplate.lsp file in Notepad on Windows or TextEdit on Mac OS, if it isn't open from the earlier exercise.

In the text editor area, scroll to the end of the file and add a few blank lines. Add the following to the end of the file: ; Register the help file for F1/contextual help support (setfunhelp "c:drawplate" (findfile "DrawPlate.htm"))

Click File Save.

Configuring the AutoCAD Support and Trusted Paths

In order for the AutoLISP load and findfile functions to locate the files for your custom programs, AutoCAD needs to know where the files are located. To locate a custom file, AutoCAD uses the paths that have been added to the Support File Search Path and Trusted Locations settings in the Options dialog box (Windows) or the Application Preferences dialog box (Mac OS).

The following steps explain how to add the folder named MyCustomFiles to the support file search paths and trusted locations used by AutoCAD:

Click the Application menu button Options (or at the Command prompt, type options and press Enter).

When the Options dialog box opens, click the Files tab.

Select the Support File Search Path node. Click Add and then click Browse.

In the Browse For Folder dialog box, browse to the MyCustomFiles folder that you created for this book in the Documents (or My Documents) folder, or browse to the folder that contains your LSP files.

Select the folder that contains your LSP files and click OK.

With the new path still highlighted, press F2. Press Ctrl+C, or right-click and choose Copy.

Select the Trusted Locations node. Click Add.

With focus on the in-place text editor, press Ctrl+V, or right-click and choose Paste. Then press Enter to accept the pasted path.

If the Trusted File Search Path - Security Concern message box appears, click Continue.

Click OK to save the changes to the Options dialog box.

If you are using AutoCAD on Mac OS, use these steps:

On the menu bar, click AutoCAD <release> Preferences (or at the Command prompt, type options and press Enter).

When the Application Preferences dialog box opens, click the Application tab.

Select the Support File Search Path node.

Near the bottom of the dialog box, click the plus sign (+).

In the Open dialog box, browse to the MyCustomFiles folder that you created for this book in the Documents folder, or browse to the folder that contains your customized files.

Select the folder that contains your customized files and click Open.

Click OK to save the changes to the Application Preferences dialog box.

WARNING

Executing the AutoLISP expressions in step 8 more than once will result in the folder being added multiple times to the Trusted Locations setting. You should make sure the folder you are adding is not already listed as part of the trustedpaths system variable. I don't know whether listing the folder more than once is a problem, but ideally you should not list the same folder multiple times.

At the Command prompt, type (prompt (getvar "trustedpaths")) and press Enter. If the MyCustomFiles folder or the location of the drawplate.lsp file is listed, type one of the following and press Enter:(setq trustedpath (strcat (getvar "trustedpaths") ";" (vl-filename-directory (findfile "drawplate.lsp")) "/;"))

or

(setvar "trustedpaths" trustedpath)

Testing the Deployment of the drawplate Function

The time has come to put in motion everything that you have done up to this point. You have added statements that load the utility.lsp file from drawplate.lsp, defined an autoloader program, enabled contextual help for the drawplate function, and configured the support file search and trusted location paths. It is now time to see all of it in action. If all goes well, it will feel like you are hearing the climax of a movement being played by an orchestra. If something doesn't go right, you will have that meh moment, but don't feel discouraged; we have all been there.

The following steps explain how to use the load function to add the myautoloader.lsp file into AutoCAD from the Command prompt. Once it's loaded, you will then start the drawplate function and test the help file with which it has been associated.

At the Command prompt, type (load "myautoloader") and press Enter. If you see the error message ; error: LOAD failed: "myautoloader", make sure that the file was placed in the MyCustomFiles folder and that the folder is part of the Support File Search Path setting. A return value of nil is expected by the load function.

Type drawplate and press Enter. You should see the familiar Specify base point for plate or [Width\Height]: prompt. Remember, you didn't load the drawplate.lsp or utility.lsp file yourself. You simply loaded myautoloader.lsp and it loaded drawplate.lsp when you started the drawplate function. Upon loading, the drawplate.lsp file then loaded utility.lsp.

With the drawplate function still active, press F1 on Windows or Fn-F1 on Mac OS. The custom help documentation associated with the drawplate function is shown. Figure 20.5 shows what the document looks like in the AutoCAD Help window on Windows. On Mac OS, the topic is opened in your system's default browser.

Press Esc to end the drawplate function.

Figure 20.5 Custom help for a custom function

Creating DrawPlate.bundle

Plug-in bundles are a relatively new concept in AutoCAD, but they make deploying your custom programs much easier. After all, a bundle is simply a folder structure that you can copy between machines no matter which operating system you are using.

The following steps explain how to create a bundle named DrawPlate.bundle.

On Windows, do one of the following: Launch Windows Explorer or File Explorer, depending on your version of the operating system. (Right-click the Windows Start button on Windows XP or Windows 7, or right-click in the lower-left corner of the screen on Windows 8. Click Windows Explorer or File Explorer.)

Browse to the MyCustomFiles folder under the Documents (or My Documents) folder. Right-click in an empty area and choose New Folder.

On Mac OS, do one of the following: Launch Finder. (On the Desktop, click Go Documents.)

Browse to the MyCustomFiles folder under the Documents (or My Documents) folder. Click Settings (the gear icon) near the top center of the Finder window and choose New Folder.

Type DrawPlate.bundle and press Enter.

Do one of the following: On Windows, double-click the DrawPlate.bundle folder.

On Mac OS, secondary-click DrawPlate.bundle and choose Show Package Contents.

Create a new folder under the DrawPlate.bundle folder and name the new folder Contents.

From the sample files that are available with this book and those that you created, copy the following files into the appropriate folder (see Table 20.2).

Table 20.2 Files for DrawPlate.bundle

Filename Folder

packagecontents.xml DrawPlate.bundle

utility.lsp Contents

drawplate.lsp Contents

drawplate.htm Contents

Deploying and Testing the DrawPlate.bundle

Plug-in bundles must be placed within a specific folder before they can be used. You learned which folders a bundle can be placed in earlier, in the section「Defining a Plug-in Bundle.」

The following steps explain how to deploy a bundle named DrawPlate.bundle on Windows:

In Windows Explorer or File Explorer, browse to the DrawPlate.bundle folder you created in the previous exercise.

Select the DrawPlate.bundle folder and right-click. Choose Copy.

In the Location/Address bar of Windows Explorer or File Explorer, type one of the following and press Enter: On Windows XP, type %ALLUSERSPROFILE%\Application Data\Autodesk\ApplicationPlugIns.

On Windows 7 or Windows 8, type %ALLUSERSPROFILE%\Autodesk\ApplicationPlugIns.

Right-click in the file list and choose Paste.

The following steps explain how to deploy a bundle named DrawPlate.bundle on Mac OS:

In Finder, browse to the DrawPlate.bundle folder you created in the previous exercise.

Select the DrawPlate.bundle folder and secondary-click. Choose Copy「DrawPlate.bundle.」

In Finder, click Go Go To Folder, type /Applications/Autodesk/ApplicationAddIns , and click Go.

Secondary-click in the files list and choose Paste Item.

The following steps explain how to test DrawPlate.bundle:

In AutoCAD, create a new drawing.

At the Command prompt, type drawplate and press Enter.You should see the familiar Specify base point for plate or [Width\Height]: prompt. Before, you had to load the drawplate.lsp, utility.lsp, or myautoloader.lsp file to access the functionality.

Press Esc to end the drawplate function.

NOTE

If the drawplate function isn't available in the drawing, check the current value of the appautoload system variable. The appautoload system variable controls when a bundle should be loaded. The default value of the appautoload system variable is 14, which indicates a bundle should be loaded at startup, when a new drawing is opened, or when a new bundle has been added to one of the plug-in folders.

Chapter 21

Using the Visual LISP Editor (Windows only)

Up until now, when working with LSP files you have been using Notepad, which is designed primarily for creating and editing plain ASCII text files—not LSP files. The Autodesk® AutoCAD® program on Windows supports an integrated development environment (IDE) used to develop custom AutoLISP® applications. The IDE used to work with AutoLISP is called the Visual LISP® Editor and is often referred to as the VLIDE. Unlike Notepad, the Visual LISP Editor offers a range of tools that are designed specifically for working with LSP files.

In this chapter, you'll learn how to create and manage LSP files with the Visual LISP Editor. You'll also learn how to format AutoLISP statements in the editor and debug a loaded program. After a program has been debugged, it can be compiled into an FAS or VLX file to prevent someone from making changes to the original LSP file.

NOTE

If you are using Mac OS, I recommend installing Windows and AutoCAD on Boot Camp or Parallels so that you can use the Visual LISP Editor when creating or editing LSP files.

Accessing the Visual LISP Editor

You access the Visual LISP Editor from within AutoCAD by entering vlide at the Command prompt. You can also start the vlide command by clicking the Manage tab Applications panel Visual LISP Editor. Figure 21.1 shows the initial state of the Visual LISP Editor after the vlide command is started.

Figure 21.1 The Visual LISP Editor with a new LSP file open in an editor window

The Visual LISP Editor is similar to many Windows-based applications. It has a menu bar displayed along the top with toolbars placed below it that allow access to many of the tools commonly used to create, format, and debug LSP files. The large area in the middle is where you access windows for editing open LSP files and other tool-related windows.

When you display the Visual LISP Editor, any files not closed during the previous editing session are reopened automatically. The reopening of files makes it easy to pick up where you left off working on custom programs. Along with previously opened files, the Visual LISP Console and Trace windows are also displayed in a minimized state near the bottom of the Visual LISP Editor. The Visual LISP Console and Trace windows might be hidden behind one of the other opened editor windows and can be brought to the foreground using the Window pull-down menu.

Managing AutoLISP Files with the Visual LISP Editor

Creating new files in the Visual LISP Editor is similar to creating a new file in many other Windows-based programs. You create a new file by clicking the New button on the Standard toolbar or by choosing File New File. The new file is a general text file and is not assigned a specific file extension, so the new file could be used to store custom linetype definitions, hatch patterns, or AutoLISP programs. An extension is added to the filename when it is saved the first time.

You can save the file by clicking Save File on the Standard toolbar or by choosing File Save or File Save As. If the Save-as dialog box is displayed, you can specify a name and location for the file and append the desired file extension to the filename. As an alternative, you can choose a file format from the Save As Type drop-down list. Click Save to store the file to disk. Choose File Save All to save any open and changed files back to disk.

If you want to edit an existing file, click Open on the Standard toolbar or choose File Open File. When the Open File To Edit/View dialog box is displayed, browse to and select the file you want to open, and then click Open. You can use the File Of Types drop-down list to filter the files that are displayed in the Files list. Choose File Reopen and then an item from the menu to reopen a file that was previously opened.

NOTE

Choose File Revert if you want to reload a file based on the content that is in the version of the file on disk instead of in memory.

When you are done working with a file, save any changes and then click the Close button in the upper-right corner of the editor window or choose File Close. Choose File Close All to close all open files in the current editing session.

TIP

If you think you might want to continue to work with a LSP file later, leave it open in the Visual LISP Editor and simply close the editor without first closing the file. The next time the Visual LISP Editor is loaded, it reopens the file for you if it is found in its previous known location.

As you work in the Visual LISP Editor, you can take advantage of the tools on the Edit and Search menus to assist in editing and finding code in the current editor window. Many of the available tools are similar to those found in Notepad, with the exception of the Parentheses Matching and Extra Commands options on the Edit menu. I'll explain some of the items on these two submenus later in this chapter.

Although the Visual LISP Editor offers many tools that differentiate it from Notepad, one of my favorite tools is the Apropos window (see Figure 21.2, on the left). The Apropos window allows you to obtain a listing of the AutoLISP functions and variables that are defined in the current drawing. Display the Apropos window by clicking Apropos on the View toolbar or by choosing View Apropos Window. After the window is displayed, enter a text string that matches part of the function or variable names you want to list and click OK. The matching results are displayed in the Apropos Results window (see Figure 21.2, on the right).

Figure 21.2 Searching for defined functions and variables

Formatting an AutoLISP File

Editor formatting is one of the key advantages of using the Visual LISP Editor over Notepad. The Visual LISP Editor supports the following features that help you to author and format code:

Color syntax

Automatic indenting

Ability to format code by selection or in the editor window

Comments

Coloring Syntax

The Visual LISP Editor supports color syntax, which helps to distinguish function names from argument values. Color is also used to help distinguish values based on the data type; strings are displayed in magenta, integers are displayed in green, and real numbers are displayed in teal. Many modern development environments, such as Microsoft Visual Studio, also support color syntax. Figure 21.3 shows the badcode function from Chapter 19,「Catching and Handling Errors,」open in the Visual LISP Editor.

Figure 21.3 Color syntax allows you to quickly identify functions, argument values, and problems in a program.

Although the color of the characters doesn't come through in black and white, you should notice that the second statement shown in Figure 21.3 is a comment and its background is shaded to help you visually distinguish it from other statements in the program. When the Visual LISP Editor detects an error in the syntax within an open LSP file, the color syntax applied to code can be affected. The change in the color syntax indicates an error.

In Figure 21.3, a quotation mark is missing from the (princ "DEBUG: Inside IF) statement. The missing quotation mark affects the color syntax of all the statements that are after it. Notice most of the statements after the missing quotation mark are also displayed in a gray color, such as the string of the (setq str (getstring "\nEnter a string: ")) statement. As you can see, color syntax can also be helpful in identifying problems in a program and thereby it reduces the amount of debugging that you have to perform.

You can adjust the colors that the Visual LISP Editor applies to the editor window by choosing Tools Window Attributes Configure Current. In the Window Attributes dialog box (see Figure 21.4), click the element drop-down list and choose the element you want to format. Then select a foreground (top row) and background (bottom row) color to apply to the element. Choose Transparent FG or Transparent BG to match the background color of the editor window. Clear the Lexical Colors check box to remove the color from all text elements.

Figure 21.4 Setting element colors to be used in the editor window

You can also set the number of characters that a tab character represents and the left margin of the editor window (in pixels) by changing the values of the Tab Width and Left Margin text boxes in the Window Attributes dialog box.

Formatting Code

Code formatting isn't something you have to do; AutoCAD and AutoLISP don't care whether all code is placed on a single line or is nicely formatted. Formatting code is a benefit for you, the programmer, because it makes code easier to read and helps you identify missing or extra parentheses. When writing code in Notepad, you have to manually add spaces and indents to make your code easier to follow.

The Visual LISP Editor provides several features designed to format code as you type it in the editor window, or you can specify that you'd like to base the formatting on the code that was previously entered. When you start a statement by typing an opening parenthesis and then press Enter without adding the closing parenthesis on the same line, the Visual LISP Editor indents the next line to signal that the new line is a continuation of the current expression. You can specify the size of the indent with the Narrow Style Indentation value in the Format Options dialog box (see Figure 21.5). To open this dialog box, choose Tools Environment Options Visual LISP Format Options.

Figure 21.5 Specifying the settings to format code in the editor window

In the Format Options dialog box, specify the settings for the Visual LISP Editor formatting tools. Click the More Options button to access additional formatting settings. Once the formatting options are set, click Format Edit Window on the Tools toolbar or choose Tools Format Code In Editor to format all the code in the current editor window. If you want to format only some of the code, select the code you want to format and click Format Selection on the Tools toolbar or choose Tools Format Code In Selection.

NOTE

When you format all of the code in the editor window, the Visual LISP Editor will notify you if it finds a problem with a missing or extra parenthesis.

Commenting Code

Comments are commonly added by you as the programmer, as I explained in Chapter 20,「Authoring, Managing, and Loading AutoLISP Programs.」The Visual LISP Editor can format the comments that have been added to an AutoLISP program based on the settings in the Format Options dialog box, and it can also add what are called form-closing comments.

Form-closing comments are added after the closing parentheses of specific functions, such as defun, if, and progn. The comments let you know the location in the code of the closing parenthesis for functions to assist you in the debugging of a program. Select the Insert Form-Closing Comment option and type the prefix for the comment in the Form-Closing Comment Prefix text box of the Format Options dialog box (choose Tools Environment Options Visual LISP Format Options). Form-closing comments are added when you use the Format Edit Window or Format Selection tool discussed in the previous section.

In addition to adding form-closing comments, you can mark selected statements in the current window as comments. Select the statements to be marked as comments, and then click Comment Block on the Tools toolbar or choose Edit Extra Commands Comment Block. The Visual LISP Editor places three semicolons (;;;) in front of each of the selected statements. Click Uncomment Block or choose Edit Extra Commands Comment Block to uncomment selected statements. The Uncomment Block tool removes only the semicolons that are located at the left margin of the editor window—indented comments are ignored.

Validating and Debugging Code

The benefits of the Visual LISP Editor extend beyond being able to view code in color, use automatic formatting, and insert comments based on the way your code was written. Since the Visual LISP Editor was designed to be a proper development environment, it offers the following functionality that can be used to validate, load, and debug code:

Execute AutoLISP statements without returning to the AutoCAD Command prompt

Load and check the code in a LSP file

Debug the code in the current editor window

Executing Code from the Visual LISP Editor

The Console window (see Figure 21.6) is an extension of the AutoCAD Command prompt; it allows AutoLISP statements to be executed in real time from the Visual LISP Editor. When you type an AutoLISP statement in the Console window and press Enter, the value of the last evaluated function is returned to the Console window and not the AutoCAD Command prompt. AutoLISP statements entered in the Console window follow the same rules as statements entered at the AutoCAD Command prompt, with one exception: user-defined variables don't need to be prefixed with an exclamation point to get the current value.

Figure 21.6 Use the Console window to execute AutoLISP statements.

The Console window is opened in a minimized state by default, but you can choose Window Visual LISP Console to bring the window to the foreground. At the _$ prompt, type the statement you want to execute and press Enter. You can press Shift+Enter to move input to the next line, but the statements won't be executed until you press Enter. Right-click in the Console window to clear the window or to enable logging.

NOTE

Focus is shifted away from the Visual LISP Editor and to AutoCAD when you execute a function from the Console window that requires user input.

Checking and Loading Code in the Current Editor Window

