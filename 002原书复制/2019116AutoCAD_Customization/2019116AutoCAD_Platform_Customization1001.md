# Chapter 10 Using, Loading, and Managing Custom Files

Throughout this book, I discuss how to define a set of CAD standards that can be applied to all your drawings so they have a consistent look. I show you how to customize the Autodesk® AutoCAD® program on systems running on Windows and Mac OS. Being able to customize the files for AutoCAD on your local workstation is a great start, but in the end you want to make sure that you can deploy or share any customized files with others in your company.

Customizing AutoCAD, as you have read and seen thus far in this book, is a great way to increase your productivity, but you can also download custom programs from the Internet or the Autodesk Exchange store to introduce new functionality and commands. You can also create your own custom programs that improve your company's workflows, but doing so is beyond the scope of this book.

After you spend the time to customize AutoCAD, you will want to make sure you back up your files. How you back up your custom files will vary based on if you are on Windows or Mac OS. Last but not least, recent releases of AutoCAD provide a few utilities that allow you to migrate your customized files to a newer release.

Deploying Your Custom Files

Now that you have taken the time to learn how to customize AutoCAD, you probably can't wait to share what you have learned with others to increase their productivity. Before you start passing files around to everyone in your company, you might want to take a step back and formulate a long-term plan for maintaining any customized files.

Consider the following:

Where will you store and maintain your customized files? The answer to this question will be based on how your environment is configured. Chances are you have a network available to you that most users in your company can access, but you can also use a local drive or a cloud-based file service to share customized files.

Who needs access to your customized files? Usually, customized files are shared within a company, but you might also want to consider sharing your customized files with your subcontractors. This can make it easier to share project files and even complete projects faster. When sharing customized files, consider marking them read-only to avoid accidental changes to the files. Placing files on a network for those in your company is the ideal solution, because that makes the files more secure and easier to manage. But for those outside your company, a cloud-based file service or an FTP site might be the best choice.

How often do you plan on making changes? The method used to host customized files can impact how many updates you might make on a daily, weekly, or monthly basis. No matter how large or small the changes, you want to create a log of the changes so you can identify any errors that are encountered. This approach also gives your users an idea of what functionality is available to them over time.

Organizing Your Customized Files

As I have mentioned throughout this book, I recommend creating your own or creating a copy of a customizable file over directly modifying the files that come with AutoCAD. Then, once the files are customized, you should place those files in their own location. In the exercises and samples in this book, we used the MyCustomFolders folder under the Documents (or My Documents) folder. This approach has these advantages:

It lowers the risk of losing your customization during a reset or reinstall of AutoCAD.

Sharing of customized files is made easier. You can add the folders in which AutoCAD can locate your files as part of the Support File Search Path node in the Options (Windows) or Application Preferences (Mac OS) dialog box.

Upgrading to a newer release is streamlined, since you know exactly where your customized files reside.

Backing up customized files is simplified, because you know which files have been customized and where those files reside.

Where to Place Customized Files

I recommend placing all the customized and support files you want to share with others in your organization in a common and shared location instead of manually copying files between workstations. Manually copying files takes extra time and planning that might not be necessary when changes are made to the files. If you place the files on the network, you just need to copy any changed files to a single location, and AutoCAD will load them as long as you have identified the location of the customized files using the Options (Windows) or Application Preferences (Mac OS) dialog box.

No matter whether you store your files on a network or local drive, I recommend defining a folder structure that allows you to use or organize your files by type instead of just placing them all in a single folder. The following is a sample folder structure I have used for my customized files and the environments I have configured for other companies:

<company_name> <release> Blocks Plotting PC3 Plot Styles Support Actions Custom Programs Icons Palettes Templates

The value <company_name> in the sample folder structure represents your company's name to help ensure your files are separate from those that come with AutoCAD or even other third-party utilities that might be installed. The value <release> represents the AutoCAD release you have installed. If you have more than one release installed, you will want to have a folder structure for each release to avoid potential conflicts between older and newer releases. Customizable files are commonly designed to be forward compatible, but they are not always backward compatible.

Where you create your folder structure depends on the storage option you choose for your customized files. Here are some suggestions based on various storage options:

Network Drive Map a drive letter to the root of the folder structure. This helps ensure that you don't create long folder paths that will cause problems when AutoCAD tries to access the files.

Cloud-Based File-Sharing Service Use the location in which the cloud-based file-sharing service stores local copies of the files that are synchronized from the remote server. For example, Microsoft SkyDrive synchronizes files locally to the SkyDrive folder and Dropbox uses the Dropbox folder. Both of these folders are located under your user profile.

Removable Drive Create a folder for the customized files on the removable drive at the root level.

Local Drive Create a folder for the customized files on the local drive at the root level, the ProgramData folder on Windows, or the Library folder on Mac OS.

NOTE

Although you could use a folder that is part of a user's Roaming profile for your company's custom files, I recommend not doing that. It requires the user to be logged in to receive any updated files, and it creates duplications of the files under each user's profile. In addition, the files that make up a user's profile should be only the ones that they create or manage themselves.

Maintaining Files Offline

In a perfect world, your customized files would never need to be updated and would only need to be accessible from the company's network. However, Internet connections are not available everywhere and not all connections are fast, stable, or secure. Instead of hoping for an Internet connection, you will want to plan ahead and ensure that remote users have access to the files they need.

For individuals working from home or on a laptop in the field, local access to the most recent files is critical. The same advantages still apply about having your customized files separated from those that come with AutoCAD, but you need to take an extra step to ensure the user has the latest files. You could use any of the following techniques based on your skill level to maintain a local copy of the customized files that might normally be posted on the network:

Copying files manually is a low-cost way of getting your files from a network to a local drive. However, it does require someone to remember to do it before they log out and hit the road.

Using a cloud-based file-sharing service can be a nice and easy-to-set-up solution for taking customized files offline with you. File-sharing platforms like Dropbox, SkyDrive, Google Drive, and others allow you to create a company account and grant read-only access to the files. Since many of the cloud-based services are available on both Windows and Mac OS, they can be useful in mixed environments.

Creating a batch or shell script that is executed at startup or as part of a Group Policy can be ideal and gives you the most control over where the files are placed and when the synchronization takes place.

There are additional options that are specific to a given operating system, so feel free to experiment and use the solutions that might work best for you to keep your users' local files in sync with those on the network. I have used Robocopy, Offline Files, and Task Scheduler on Windows in the past. You can use rsync or FileSync on Mac OS. These days, I tend to lean toward cloud-based approaches, so I have my customized files available on both my Windows and Mac OS workstations with very little effort.

Customizing the Folders Used by AutoCAD

The folders that AutoCAD looks in for its support files and your customized files are defined as part of the current AutoCAD profile. You can modify the current user profile or create a new one by using the options command. AutoCAD doesn't search the subfolders of the folders that are listed as part of the current user profile. Each folder that contains custom program files you want AutoCAD to use must be listed as part of a user profile. I explain managing user profiles in Chapter 4,「Manipulating the Drawing Environment.」

NOTE

New user profiles can be created only in AutoCAD on Windows.

Based on the locations in which your customized files are stored, you might need to add the folders under the following nodes of the Files tab in the Options dialog box (Windows) or the Application tab in the Application Preferences dialog box (Mac OS). For information about other nodes on the Files or Application tab, see the AutoCAD Help system.

NOTE

While you can change the paths listed in the current user profile, be careful. Do not remove the folders that contain the AutoCAD core application and support files. Unexpected results might occur if those folders are removed.

Support File Search Path The Support File Search Path node contains the folders that AutoCAD looks in for its own support files and most of your customized files. Here are some of the file types that should be listed in the folders under this node: AutoLISP® (LSP/FAS/VLX)

Blocks (DWG)

Compiled shapes (SHX)

Hatch patterns (PAT)

Linetype definitions (LIN)

Managed.NET (DLL) (Windows only)

ObjectARX® (ARX/CRX/BUNDLE)

ObjectDBX™ (DBX)

Program parameter (PGP)

Scripts (SCR)


