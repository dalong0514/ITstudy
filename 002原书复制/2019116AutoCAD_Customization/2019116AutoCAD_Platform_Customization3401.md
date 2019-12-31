When the Macros dialog box opens, select the RoolLabel.dvb!basRoomLabel.SelectRoomLabels macro from the list and click Run.

At the Select objects: prompt, type all and press Enter twice.

At the Command prompt, type erase and press Enter.

At the Select objects: prompt, type p and press Enter twice. All of the room label blocks have been removed.

At the Command prompt, type u and press Enter.

Save and close the drawing file.

Chapter 33

Modifying the Application and Working with Events

The ability to automate the creation and modification of objects in a drawing can be a huge productivity boost to any organization. As a programmer, you should always try to seamlessly integrate your custom programs into existing workflows and make it feel as if they were native to the AutoCAD® application.

You can implement a custom user-interface element to make it easier to start a macro or frequently used AutoCAD command. The user interface elements you implement can start macros from different VBA projects and even custom commands defined in AutoLISP® (LSP) or ObjectARX® (ARX) files that are loaded into the AutoCAD drawing environment. A VBA project can load other custom programs it requires into the AutoCAD environment.

In addition to implementing custom user interface elements, you can use events to help enforce your organization's CAD standards when AutoCAD and third-party commands are used. Events are specially named procedures that can be used to monitor changes to the AutoCAD application, an open drawing, or a specific graphical or nongraphical object in a drawing.

Manipulating the AutoCAD User Interface

The AcadApplication and AcadDocument objects can be used to manipulate the AutoCAD user interface. The AcadMenuGroups collection object returned by the MenuGroups property of the AcadApplication object allows you to access the customization groups (also known as menu groups) of all loaded CUIx files. A CUIx file is stored externally from the AutoCAD program and contains the definitions of various user interface element types that make up many of the tools displayed in the AutoCAD application window. I explain how to work with the AcadMenuGroups collection and AcadMenuGroup objects in the next section.

Pull-down menus on the menu bar, toolbars, and tabs on the ribbon are a few of the user interface elements that are stored in CUIx files. Use the CUI Editor (accessed using the cui command) to create new CUIx files and modify the user interface elements stored in an existing CUIx file. As an alternative, pull-down menus and toolbars can be customized using the AutoCAD Object library.

Customizing Older Versions of AutoCAD

If you are using AutoCAD 2006 through 2009, customization files had the file extension of .cui and not .cuix. Prior to AutoCAD 2006, customization files were known as menu files and had the file extension of .mns. MNS files were customized using the Customize dialog box (accessed using the customize command). You can convert CUI and MNS files to the CUIx file format in the latest release of AutoCAD by using the cuiimport command. For more information on working with older customization and menu files, see the cuiimport command in the AutoCAD Help system.

Some user interfaces can't be customized, but their display can be toggled using system variables. You can set or get the values system variables using the SetVariable and GetVariable methods of the AcadDocument object. I discuss how to toggle the display of some user interface elements that can be affected by system variables in the「Controlling the Display of Other User Interface Elements」section later in this chapter.

Managing Menu Groups and Loading Customization Files

In recent AutoCAD releases, each CUIx file contains a special name known as the customization group name. (In AutoCAD 2005 and earlier, it is the menu group name.) The customization group name must be unique for each CUIx file that is loaded into the AutoCAD drawing environment; if the name is already used by a loaded CUIx file, the AutoCAD program won't allow the new CUIx file to be loaded. A loaded CUIx file is represented by an AcadMenuGroup object in the AcadMenuGroups collection object. You can get the AcadMenuGroups collection object of the AutoCAD application by using the MenuGroups property of the AcadApplication object.

As with other collection objects, you can use the Count property to get the number of objects in the collection and the Item method to retrieve a specific object. You can use a For statement to step through a collection one object at a time if you don't want to retrieve a specific object with the Item method.

A customization group (CUIx file) can be loaded either as a base menu group (acBaseMenuGroup) or as a partial menu group (acPartialMenuGroup). A base menu group forces all other CUIx files to be unloaded before the CUIx file is loaded. A partial menu group is loaded in addition to any CUIx files that are already loaded. You can use the example that follows to see what's currently loaded in your AutoCAD session and help you determine how you wish to load a customization group.

The following example displays a message box for each AcadMenuGroup object in the AcadMenuGroups collection object. The message box displays the customization group name, the full path to the CUIx file, and how the CUIx file is loaded (base or partial).

Sub InfoMenuGroups() Dim oMnuGrp As AcadMenuGroup For Each oMnuGrp In ThisDrawing.Application.MenuGroups With oMnuGrp MsgBox "MenuGroup Info: " & vbLf & _ "Name = " &.Name & vbLf & _ "FileName = " &.MenuFileName & vbLf & _ "Type = " & Switch(.Type = acBaseMenuGroup, "Base", _ .Type = acPartialMenuGroup, "Partial") End With Next oMnuGrp End Sub

To load a CUIx file into the AutoCAD drawing environment, use the Load method of the AcadMenuGroups collection object. A customization group, or more specifically a CUIx file, is unloaded using the Unload method for an AcadMenuGroup object.

The following shows the syntax of the Load method:

object.Load cuixFileName [, type]

Its arguments are as follows:

object The object argument represents the variable that contains a reference to the AcadMenuGroups collection object.

cuixFileName The cuixFileName argument is a string that specifies the full path to the CUIx file to load.

type The type argument is an optional integer that specifies how the CUIx should be loaded. A value of 0 indicates the CUIx file should be loaded as a base customization file, which forces all other CUIx files to be unloaded before the specified CUIx file is loaded. A value of 1 specifies that the CUIx file should be loaded as an additional partial menu. You can also use the constant values acBaseMenuGroup and acPartialMenuGroup instead of 0 and 1 (an approach I recommend).

The following statements load a CUIx file named acp.cuix and unload the customization group named ACP:

' Loads the acp.cuix file as a partial file ThisDrawing.Application.MenuGroups.Load "c:\acp.cuix", acPartialMenuGroup ' Unloads the menu group named ACP ThisDrawing.Application.MenuGroups("ACP").Unload

The properties of the AcadMenuGroup object can also give you information about pull-down menus and toolbars. Look at the Menus and Toolbars properties. I discuss how to access the pull-down menus and toolbars included in a loaded CUIx file in the next section.

Working with the Pull-Down Menus and Toolbars

In recent releases, the ribbon has been the primary focus for accessing tools from the out-of-the-box AutoCAD user interface, but pull-down menus and toolbars still play an important role in custom tool access. The pull-down menus on the menu bar and toolbars displayed in the AutoCAD application window can be customized. You can control the display of pull-down menus and toolbars and modify the items on a pull-down menu or toolbar to align with your customization needs. I explain how to work with pull-down menus and toolbars in the following sections.

NOTE

Changes made to a pull-down menu or toolbar can be saved to a CUIx file with the Save and SaveAs methods of the AcadMenuGroup object. The Save method saves changes back to the loaded CUIx file and expects a file type; specify a value of 0 for a compiled menu and 1 for a menu source file type. As an alternative, you can use the constant values acMenuFileCompiled and acMenuFileSource instead of 0 and 1 (and I recommend that you do). The SaveAs method saves changes to a specified CUIx file; you must specify a file type just as you do with the Save method. For more information on the Save and SaveAs methods, see the AutoCAD ActiveX Help system.

Customizing Pull-Down Menus and the Menu Bar

The menu bar is an area along the top of most Windows-based applications, and it's used to access a set of pull-down menus. A pull-down menu is displayed by clicking its caption on the menu bar. Each pull-down menu contains a set of items that are typically grouped by function. For example, the Draw pull-down menu contains items used to start a command that creates a new graphical object, as opposed to the Modify pull-down menu, which contains items related to changing an existing drawing object.

NOTE

In recent AutoCAD releases, the menu bar is hidden in favor of the ribbon, but you can display it by using the menubar system variable. Set the menubar system variable to 1 to display the menu bar or 0 to hide it.

Figure 33.1 shows a pull-down menu expanded on the AutoCAD menu bar and how the objects in the AutoCAD Object library are visually related.

Figure 33.1 Visual reference of the objects that make up a pull-down menu

The pull-down menus that are displayed on the AutoCAD menu bar can come from any one of the loaded CUIx files. You access the pull-down menus of a loaded CUIx file using the AcadMenuGroups collection object returned by the MenuGroups property of the AcadApplication, which I discussed earlier, in the section「Managing Menu Groups and Loading Customization Files.」

The Menus property of an AcadMenuGroup object returns an AcadPopupMenus collection object that represents the pull-down menus in the associated CUIx file. Use the Item method and a For statement to get an AcadPopupMenu collection object from an AcadPopupMenus collection object. You can add a new pull-down menu to an AcadPopupMenus collection object by using the Add method, which expects a string that represents the name of the new pull-down menu.

The following example code statements display a message box with a listing of the names for each pull-down menu in the acad.cuix file:

Sub ListAcadMenus() Dim sMsg As String sMsg = "List of pull-down menus in acad.cuix: " Dim oMenuGrp As AcadMenuGroup Set oMenuGrp = ThisDrawing.Application.MenuGroups("ACAD") Dim oPopMenu As AcadPopupMenu For Each oPopMenu In oMenuGrp.Menus If oPopMenu.ShortcutMenu = False Then sMsg = sMsg & vbLf & " " & oPopMenu.NameNoMnemonic End If Next oPopMenu MsgBox sMsg End Sub

Table 33.1 lists the properties that can be used to learn more about an AcadPopupMenu collection object.

Table 33.1 Properties that describe an AcadPopupMenu collection object

Property Description

Name Specifies the pull-down menu name with optional mnemonic characters. The mnemonic characters are used to access the pull-down menu from the keyboard and are displayed when the user holds the Alt key. Figure 33.1 has the mnemonic characters displayed for the pull-down menus and menu items.

NameOnMnemonic Returns the menu name without the mnemonic characters.

OnMenuBar Returns a Boolean value indicating whether the menu is displayed on the menu bar.

ShortcutMenu Returns a Boolean value indicating that the menu is designated as a context menu displayed in the drawing area and not on the menu bar.

TagString Returns the tags assigned to the pull-down menu. Tags are used to uniquely identify an item in a CUIx file.

The menu items on a pull-down menu can be organized into groups using separators and submenus. A submenu is an item that contains additional items; think along the lines of a folder inside of a folder. Menu items are represented by the AcadPopupMenuItem object. You can add new menu items to a pull-down menu by using the AddMenuItem, AddSeparator, and AddSubMenu methods of the AcadPopupMenu collection object. Existing menu items on a pull-down menu can be accessed by using the Item method and a For statement with an AcadPopupMenu collection object. You can remove a menu item or submenu from on a pull-down menu by using the Delete method.

When you use the AddMenuItem, AddSeparator, and AddSubMenu methods, you must use an index value to specify where in the pull-down menu the item should appear. An index of 0 is used to specify the topmost item. In addition to the index, you must use a string to specify the menu item label when using the AddMenuItem and AddSubMenu methods. A third value is required when using the AddMenuItem method: you must specify the macro that should be executed when the menu item is clicked. The AddMenuItem and AddSeparator methods return an AcadPopupMenuItem object, and the AddSubMenu method returns an AcadPopupMenu collection object.

The following code statements create a pull-down menu named ACP—short for AutoCAD Customization Platform—and add a few menu items to it. The ACP pull-down menu is added to the ACAD menu group—which represents the acad.cuix file—but not saved to the CUIx file. Closing the AutoCAD application will result in the removal of the ACP menu.

Sub AddACPMenu() On Error Resume Next Dim oMenuGrp As AcadMenuGroup Set oMenuGrp = ThisDrawing.Application.MenuGroups("ACAD") Dim oPopMenu As AcadPopupMenu Set oPopMenu = oMenuGrp.Menus("ACP") If Err Then Err.Clear Set oPopMenu = oMenuGrp.Menus.Add("ACP") oPopMenu.AddMenuItem 0, "Draw Plate", _ Chr(3) & Chr(3) & _ "(vl-vbaload (findfile ""drawplate.dvb""))" & _ "(vl-vbarun " & _ """DrawPlate.dvb!basDrawPlate.CLI_DrawPlate"") " oPopMenu.AddSeparator 1 Dim oPopSubMenu As AcadPopupMenu Set oPopSubMenu = oPopMenu.AddSubMenu(2, "Additional Tools") oPopSubMenu.AddMenuItem 0, "First Program", _ Chr(3) & Chr(3) & _ "(vl-vbaload (findfile ""firstproject.dvb""))" & _ "(vl-vbarun " & _ """firstproject.dvb!ThisDrawing.FirstMacro"") " oPopSubMenu.AddMenuItem 1, "BOM", _ Chr(3) & Chr(3) & _ "(vl-vbaload (findfile ""furntools.dvb""))" & _ "(vl-vbarun ""FurnTools.dvb!basFurnTools.FurnBOM"") " End If End Sub

Figure 33.2 shows what the ACP pull-down menu would look like if you added it to the menu bar.

Figure 33.2 ACP pull-down menu

Table 33.2 lists the properties that can be used to change or learn more about an AcadPopupMenuItem object.

Table 33.2 Properties that describe an AcadPopupMenuItem object

Property Description

Caption Returns a menu item's text as it appears on a pull-down menu.

Check Specifies a Boolean value indicating whether the menu item is checked. When the item is selected, a check mark is displayed to the left of its label. This is typically used to indicate a setting value, such as whether the UCS icon is displayed or the mode is enabled.

Enable Specifies a Boolean value indicating whether the menu item is enabled. When disabled, the menu item can't be clicked.

EndSubMenuLevel Specifies the nesting level in which the menu item appears on a submenu; the value is an integer.

HelpString Specifies the help string to be displayed in the status bar when the cursor is over the pull-down menu item.

Index Returns the index of the menu item (its location on the pull-down menu or submenu).

Label Specifies the complete label for the menu item. This includes the text that is displayed in the user interface, mnemonic characters, and the DIESEL (Direct Interpretively Evaluated String Expression Language) macro that can be used to control the behavior of the menu item. DIESEL can be used to check or disable the menu item.

Macro Specifies the macro that should be executed when the menu item is clicked. Use Chr(3) to represent the pressing of the Esc key to cancel the current command. Autodesk recommends that you use at least two instances of Chr(3) in a macro.

SubMenu Returns a Boolean value indicating whether the menu item is a submenu.

TagString Returns the tags assigned to the menu item. Tags are used to uniquely identify an item in a CUIx file.

Type Returns an integer based on the menu item's type: 0 (or acMenuItem) for a menu item, 1 (or acMenuSeparator) for a separator bar, or 2 (or acMenuSubMenu) for a submenu.

A pull-down menu from an AcadPopupMenus collection object can be added to or removed from the menu bar. The leftmost place on the AutoCAD menu bar is specified by passing the location argument 0. Table 33.3 lists the methods that can be used to manage pull-down menus on the menu bar.

Table 33.3 Methods used to manage pull-down menus on the menu bar

Method Description

InsertInMenuBar

InsertMenuInMenuBar Inserts an AcadPopupMenu collection object onto the AutoCAD menu bar.

The InsertInMenuBar method accepts a single argument that is an integer specifying the pull-down menu's location on the menu bar.

The InsertMenuInMenuBar method accepts a string that represents the name of the pull-down menu from the AcadPopupMenus collection object to insert onto the menu bar and an integer that specifies the pull-down menu's location on the menu bar.

RemoveFromMenuBar RemoveMenuFromMenuBar Removes an AcadPopupMenu collection object from the AutoCAD menu bar.

The RemoveFromMenuBar method doesn't require any argument values.

The RemoveMenuFromMenuBar method accepts an integer that specifies the location of the pull-down menu to remove from the menu bar.

The MenuBar property of the AcadApplication object returns an AcadMenuBar collection object that contains the pull-down menus displayed on the menu bar. You can step through the collection object to see which pull-down menus are on the menu bar before adding or removing a pull-down menu.

The following example code statements check to see whether the pull-down menu with the name ACP is on the menu bar. If the pull-down menu isn't on the menu bar, the ACP pull-down menu is inserted onto the menu bar from the ACAD customization group.

Sub InsertACPMenu() ' Get the menu bar from the application Dim oMenubar As AcadMenuBar Set oMenubar = ThisDrawing.Application.MenuBar ' Set the default test condition to False Dim bMenuFound As Boolean bMenuFound = False ' Step through the pull-down menus on the menubar for ACP Dim oPopMenu As AcadPopupMenu For Each oPopMenu In ThisDrawing.Application.MenuBar If UCase(oPopMenu.NameNoMnemonic) = "ACP" Then ' Exit if the ACP menu is already on the menu bar bMenuFound = True Exit For End If Next oPopMenu ' If not found on the menu bar, insert ACP If bMenuFound = False Then Dim oMenuGrp As AcadMenuGroup Set oMenuGrp = ThisDrawing.Application.MenuGroups("ACAD") On Error Resume Next ' Insert the ACP menu oMenuGrp.Menus("ACP").InsertInMenuBar oMenubar.Count End If End Sub

TIP

Since AutoCAD 2006, workspaces have been used to control the display of pull-down menus on the menu bar. However, using a combination of CUIx files and the AutoCAD Object library, you can ensure a pull-down menu is available from the menu bar no matter which workspace is current.

Customizing Toolbars

Toolbars were among the first visual user interfaces that most Windows-based applications implemented as an alternative to pull-down menus. In recent AutoCAD releases, the ribbon has replaced much of the functionality that is part of a toolbar. However, it is beneficial to use both the ribbon and toolbars at the same time. For example, using the Layers toolbar, you can switch layers or see which layer is current without needing to switch to the Home tab on the ribbon. Less switching of interface elements means you can spend more time on design-related tasks.

A toolbar can be docked along one of the edges between the application and drawing windows, or in a floating state. Since toolbars can take up a fair amount of space onscreen, the number of tools that they provide access to is typically a small subset of those found on a pull-down menu. Like a pull-down menu, all the tools on a toolbar typically perform related tasks.

TIP

By default, toolbars are hidden in recent AutoCAD releases. You can display a toolbar by using the Toolbars submenu on the Tools pull-down menu of the AutoCAD menu bar or the toolbar command. If the AutoCAD menu bar is hidden, set the menubar system variable to 1.

Figure 33.3 shows the Modify toolbar with the Array flyout expanded and shows how the objects in the AutoCAD Object library are visually related.

Figure 33.3 Visual reference of the objects that make up a toolbar

The toolbars that are displayed in the AutoCAD user interface can come from any one of the loaded CUIx files. You access the toolbars of a loaded CUIx file using the AcadMenuGroups collection object returned by the MenuGroups property of the AcadApplication, which I discussed earlier, in the section「Managing Menu Groups and Loading Customization Files.」

The Toolbars property of an AcadMenuGroup object returns an AcadToolbars collection object that represents the toolbars in the associated CUIx file. You use the Item method and a For statement to get an AcadToolbar collection object from an AcadToolbars collection object. A new toolbar can be added to an AcadToolbars collection object by using the Add method; a string that represents the name of the toolbar is expected.

The following example code statements display a message box with a listing of the names for each toolbar in the acad.cuix file:

Sub ListAcadToolbars() Dim sMsg As String sMsg = "List of toolbars in acad.cuix: " Dim oMenuGrp As AcadMenuGroup Set oMenuGrp = ThisDrawing.Application.MenuGroups("ACAD") Dim cnt As Integer, nPrevNameChars As Integer cnt = 0: nPrevNameChars = 0 Dim oTbar As AcadToolbar For Each oTbar In oMenuGrp.Toolbars ' Display the toolbar names in two columns If InStr(1, CStr(cnt / 2), ".") = 0 Then sMsg = sMsg & vbLf & " " & oTbar.Name Else sMsg = sMsg & vbTab ' If the previous toolbar name was greater than or ' equal to 9 characters add a second tab If nPrevNameChars <= 9 Then sMsg = sMsg & vbTab End If sMsg = sMsg & " " & oTbar.Name End If ' Get the number of characters in the toolbar name nPrevNameChars = Len(oTbar.Name) cnt = cnt + 1 Next oTbar MsgBox sMsg End Sub

Table 33.4 lists the properties that can be used to learn more about an AcadToolbar collection object. The toolbar must be visible before you can call many of its properties.

Table 33.4 Properties that describe an AcadToolbar collection object

Property Description

DockStatus Returns an integer that indicates where the toolbar is docked on the application window:

0 (or acToolbarDockTop) top

1 (or acToolbarDockBottom) bottom

2 (or acToolbarDockLeft) left

3 (or acToolbarDockRight) right

4 (or acToolbarFloating) floating

FloatingRows Specifies the number of rows that the toolbar should conform to when floating.

Height Returns the height of the toolbar in pixels when docked or floating.

HelpString Specifies the help string to be displayed in the status bar when the cursor is over the button item on the toolbar.

LargeButtons Returns a Boolean value that indicates whether the toolbar is shown using large or small button images. True is returned when large button images are being used.

Left Specifies the left edge of the toolbar in pixels. The value is calculated from the left edge of the screen; the leftmost position is 0.

Name Specifies the toolbar's name.

TagString Returns the tags assigned to the toolbar. Tags are used to uniquely identify an item in a CUIx file.

Top Specifies the top edge of the toolbar in pixels. The value is calculated from the top edge of the screen; the topmost position is 0.

Visible Specifies whether the toolbar is visible onscreen. True indicates the toolbar is visible.

Width Returns the width of the toolbar in pixels when docked or floating.

The button items on a toolbar can be organized into groups using separators and flyouts. A flyout is kind of like a submenu on a pull-down menu, but a flyout is a nested toolbar that is referenced by another toolbar and accessed from a button item. When the flyout is clicked, the most recent button on the flyout is used, but if the mouse cursor is over the button and the mouse button is held, the other button items of the nested toolbar can be selected.

Button items are represented by the AcadToolbarItem object. You can add new button items to a toolbar by using the AddSeparator and AddToolbarButton methods of the AcadToolbar collection object. Existing button items on a toolbar can be accessed by using the Item method and a For statement with an AcadToolbar collection object. You can remove a button item or flyout from a toolbar by using the Delete method.

When you use the AddSeparator and AddToolbarButton methods, you must specify an index location that specifies where the new item should appear on the toolbar. Index 0 is the leftmost item. In addition to an index, the AddToolbarButton method requires you to specify the following to add a button:

Name: string value

HelpString: string value

Macro: string value

Optionally, if the button should be a flyout: Boolean value

The AddSeparator and AddToolbarButton methods return an AcadToolbarItem object. When creating a flyout with the AddToolbarButton method, the Macro argument, although ignored, must have a value other than "", and True must be specified for the optional argument. After the flyout button is created, the AttachToolbarToFlyout method must be called on the AcadToolbarItem object returned by the AddToolbarButton method to attach a toolbar to the flyout button. The AttachToolbarToFlyout method expects the name of the customization group that the toolbar is part of and the toolbar name as assigned to its Name property.

A button item isn't very helpful without an image. You assign images to a button item by using the SetBitmaps method of an AcadToolbarItem object. If the image files are stored in the AutoCAD support file search paths, only the filenames of the small and large images need to be specified. If they are stored elsewhere, you must specify the full path to the images. You can use the GetBitmaps method on an existing button item to get the names of the small and large images used by a button item.

TIP

Controls such as the Layer drop-down list or the Quick Find Text text box can't be added to a toolbar using the AutoCAD Object library. These controls must be added to a toolbar in a CUIx file with the CUI Editor (accessed by calling the cui command). The CUIx file can then be loaded and the toolbar displayed using a VBA program.

The following code creates a new toolbar named ACP—short for AutoCAD Customization Platform—and adds a few button items to the new toolbar and a CAD Standards toolbar as a flyout button. The ACP toolbar is added to the ACAD customization group—which represents the acad.cuix file—but not saved to the CUIx file.

Sub AddACPToolbar() On Error Resume Next Dim oMenuGrp As AcadMenuGroup Set oMenuGrp = ThisDrawing.Application.MenuGroups("ACAD") Dim oTbar As AcadToolbar Set oTbar = oMenuGrp.Toolbars("ACP") If Err Then Err.Clear Set oTbar = oMenuGrp.Toolbars.Add("ACP") Dim oTbarItem As AcadToolbarItem Set oTbarItem = oTbar. _ AddToolbarButton(0, "Draw Plate", _ "Draws a plate with 4 bolt holes", _ Chr(3) & Chr(3) & _ "(vl-vbaload (findfile ""drawplate.dvb""))" & _ "(vl-vbarun " & _ """DrawPlate.dvb!basDrawPlate.CLI_DrawPlate"") ") oTbarItem.SetBitmaps "drawplate_16.bmp", "drawplate_32.bmp" Set oTbarItem = oTbar. _ AddToolbarButton(1, "BOM", _ "Creates a BOM for the furniture blocks", _ Chr(3) & Chr(3) & _ "(vl-vbaload (findfile ""furntools.dvb""))" & _ "(vl-vbarun ""FurnTools.dvb!basFurnTools.FurnBOM"") ") oTbarItem.SetBitmaps "bom_16.bmp", "bom_32.bmp" oTbarItem.AddSeparator 2 Set oTbarItem = oTbar. _ AddToolbarButton(3, "CAD Standards", _ "CAD Standards toolbar", _ "Flyout", _ True) oTbarItem.AttachToolbarToFlyout "ACAD", "CAD Standards" End If End Sub

Figure 33.4 shows what the new ACP toolbar would look like if created using the example code statements. The images shown for the first two button items are part of this chapter's sample files.

Figure 33.4 New ACP toolbar

Table 33.5 lists the properties that can be used to change or learn more about an AcadToolbarItem object.

Table 33.5 Properties that describe an AcadToolbarItem object

Property Description

CommandDisplayName Specifies the text that mentions which commands are being used by the macro.

Flyout Returns a Boolean value that indicates whether the button item is a flyout. True indicates the button is a flyout.

HelpString Specifies the help string to be displayed in the status bar when the cursor is over the button item on the toolbar.

Index Returns the index of the button item (its location on the toolbar).

Macro Specifies the macro that should be executed when the button item is clicked. Use Chr(3) to represent pressing the Esc key to cancel the current command. Autodesk recommends the use of at least two instances of Chr(3) in a macro.

Name Specifies the name for the button item.

TagString Returns the tags assigned to the button item. Tags are used to uniquely identify an item in a CUIx file.

Type Returns an integer based on the button item type:

0 (or acToolbarButton) button item

1 (or acToolbarSeparator) separator bar

2 (or acToolbarControl) control

3 (or acToolbarFlyout) flyout

A toolbar from an AcadToolbars collection object can be displayed and then docked or set to floating in the AutoCAD application window. A toolbar can be docked using the Dock method or set to floating with the Float method of the AcadToolbar collection object. The Dock method expects a single argument value of an integer between 0 and 3—the same values as the DockStatus property mentioned in Table 33.4. The Float method expects three integer values that represent the top and left edges of the toolbar and how many rows the toolbar should be displayed with.

Why Won't My Toolbars Stay Put?

The order in which toolbars are docked isn't very straightforward, and the AutoCAD Object library is somewhat limited in this area. If you want to control the order in which toolbars are displayed with the AutoCAD Object library, you must undock all the toolbars from an edge of the application window and then re-dock them in a right-to-left or bottom-to-top order. There is no equivalent to the AcadMenuBar collection object to determine which toolbars are visible, so you must step through the AcadMenuGroups collection object returned by the MenuGroups property of the AcadApplication object. Then use the AcadMenuGroup object's Toolbars property and step through each toolbar and see which toolbars are visible and the edge they are displayed along. If you need absolute control over the placement of toolbars, consider using a CUIx file to define a workspace and set the workspace as current.

The following example code statements hide all toolbars and then redisplay three toolbars. The toolbars displayed are the ACP toolbar that could be created with the previous example, and then the standard AutoCAD Layers and Draw toolbars. The ACP and Layers toolbars will be docked below the ribbon, and the Draw toolbar will be floating near the center of the AutoCAD application window.

Sub DisplayToolbars() On Error Resume Next Dim oMenuGrp As AcadMenuGroup Dim oTbar As AcadToolbar ' Hide all toolbars For Each oMenuGrp In ThisDrawing.Application.MenuGroups For Each oTbar In oMenuGrp.Toolbars oTbar.Visible = False Next oTbar Next oMenuGrp ' Display the ACP, Layers, and Draw toolbars in the ACAD menugroup Set oMenuGrp = ThisDrawing.Application.MenuGroups("ACAD") ' Display the ACP toolbar, if found Set oTbar = oMenuGrp.Toolbars("ACP") oTbar.Visible = True oTbar.Dock acToolbarDockTop ' Display the Layers toolbar Set oTbar = oMenuGrp.Toolbars("Layers") oTbar.Visible = True oTbar.Dock acToolbarDockTop ' Display the Draw toolbar near the center of the ' AutoCAD application window Set oTbar = oMenuGrp.Toolbars("Draw") oTbar.Visible = True oTbar.Float (ThisDrawing.Application.Height / 2) + _ ThisDrawing.Application.WindowTop, _ (ThisDrawing.Application.Width / 4) + _ ThisDrawing.Application.WindowLeft, _ 1 End Sub

TIP

Starting with AutoCAD 2006, workspaces are used to control the display of toolbars in the AutoCAD user interface. However, using a combination of CUIx files and the AutoCAD Object library, you can ensure a toolbar is displayed no matter which workspace is current.

Controlling the Display of Other User-Interface Elements

Not all user interface elements of the AutoCAD application can be customized using the AutoCAD Object library. However, you can affect the display of some user interface elements by using the properties of the AcadPreferencesDisplay object, system variables, or commands. I mentioned the AcadPreferencesDisplay object in Chapter 26,「Interacting with the Application and Documents Objects.」The following explains how you can control the display of some additional elements in the AutoCAD user interface:

Menu Bar You can control the display of the menu bar with the menubar system variable.

Layout Tabs The display of the layout tabs along the bottom of the drawing window can be toggled by setting the DisplayLayoutTabs property of the AcadPreferencesDisplay object to True or False. The following hides the layout tabs: ThisDrawing.Application.Preferences.Display. _ DisplayLayoutTabs = False

Scroll Bars The display of the scroll bars in the drawing window can be toggled by setting the DisplayScrollBars property of the AcadPreferencesDisplay object to True or False. The following hides the scroll bars: ThisDrawing.Application.Preferences.Display. _ DisplayScrollBars = False

Status Bars You can control the display of the drawing and application window status bars with the statusbar system variable.

TIP

Workspaces stored in a CUIx file control the display of many user interface elements in the AutoCAD application window. You can set a workspace as current that is defined in a loaded CUIx file by using the wscurrent system variable.

Using External Custom Programs

VBA projects can use macros defined in other VBA projects and third-party commands as long as they are loaded into the AutoCAD drawing environment. Macros and commands can also be executed from user interface elements, such as pull-down menus, toolbars, and the ribbon, as you saw in the「Manipulating the AutoCAD User Interface」section. You shouldn't rely on a custom program file being loaded when you need it—you should load the custom program file before you try to call the macro or command.

NOTE

If a custom program file is already loaded, loading a custom program file again typically doesn't affect the AutoCAD drawing environment or the current drawing. However, you will want to test what happens when reloading a custom program in your AutoCAD drawing environment, because some programs might execute code statements when a program is being loaded. The code statements that are executed could affect the objects and settings in the current drawing.

The following outlines how you can work with a custom program from a VBA project:

VBA Project The LoadDVB method of the AcadApplication object allows you to specify the full path of a DVB file you wish to load. Once loaded, the RunMacro method can be used to execute a macro in a DVB file from another VBA project. You must use the format filename.dvb![projectname.]modulename.macro to specify the macro to execute. For example, to execute the macro CLI_DrawPlate in the code module basDrawPlate of the DrawPlate.dvb, you would use DrawPlate.dvb!basDrawPlate.CLI_DrawPlate.

The UnloadDVB method lets you unload a DVB file when it is no longer needed. Be sure to specify the full path to the DVB file you wish to unload. If you are looking for information on getting your VBA program files loaded into the AutoCAD drawing environment, see Chapter 36,「Handling Errors and Deploying VBA Projects.」

ObjectARX (ARX) File The LoadARX method of the AcadApplication object allows you to specify the full path of the ARX file to load. Once the file is loaded, use the SendCommand or PostCommand method of the AcadDocument object to execute one of the defined commands. You can unload an ARX file when it is no longer needed with the UnloadARX method; you must specify the full path to the ARX file you want to unload. You can get an array of all loaded ARX files with the ListARX method and determine whether the ARX file you need is already loaded.

Managed.NET DLL (AutoCAD 2005 and Later) Use the netload command with the SendCommand or PostCommand method of the AcadDocument object to load a Managed.NET DLL. The following shows an example of how to load the file named layerutils.dll: ThisDrawing.SetVariable "filedia", 0 ThisDrawing.SendCommand "netload layerutils.dll" & vbCr ThisDrawing.SetVariable "filedia", 1

AutoLISP (LSP/VLX/FAS) File Use the AutoLISP load function with the SendCommand or PostCommand method of the AcadDocument object to load an AutoLISP file. The following shows an example of how to load the file named layerutils.lsp: ThisDrawing.SendCommand "(load ""layerutils.lsp"")" & vbCr

JavaScript (JS) File (AutoCAD 2014 and Later) Use the webload command with the SendCommand or PostCommand method of the AcadDocument object to load a JS file. The following shows an example of how to load the file named layerutils.js: ThisDrawing.SendCommand "webload layerutils.js" & vbCr

Working with Events

There are two types of programming paradigms: linear and event-driven. In linear programming, code statements are executed in a specific and known order, typically a first-to-last approach. In event-driven programming, events are triggered by the actions of the user or messages from an application. Most modern applications that get input from the user using a dialog box or controls of some sort rely on event-driven programming. From a programming perspective, events are specially named procedures that are triggered under specific conditions. I discuss dialog boxes—or UserForms as they are known in VBA—and controls in Chapter 34,「Creating and Displaying User Forms.」

Many of the objects in the AutoCAD Object library support event-driven programming. The AutoCAD application, document (or drawing), and graphical and nongraphical objects all support different types of events. Events can be used to monitor changes to the application and drawing windows, or even to enforce CAD standards for the objects in a drawing. For example, you can watch for the start of a dimension-related command or the hatch command and set a specific layer as current before the command accepts input from the user.

By default, the events of the current drawing are accessible from the ThisDrawing object in an AutoCAD VBA project. To use the events of other objects, such as the AcadApplication or a graphical object, you must declare a variable of the object type with the WithEvents keyword. The variable must be declared at the global level of ThisDrawing or within class and UserForm modules so that it persists beyond the current procedure.

The following are example code statements that declare an AcadApplication and AcadBlock object with events:

Public WithEvents oAcadApp As AcadApplication Private WithEvents oTitleBlk As AcadBlock

Once you declare a variable of an object type with the WithEvents keyword, you must assign the variable an object by using the Set keyword. The assignment of an object to the variable is typically done when the VBA project is loaded using the AcadStartup procedure or when a procedure is executed. AutoCAD looks for and automatically loads a VBA project named acad.dvb and executes the procedure AcadStartup after the VBA project is loaded. In Chapter 36, I explain techniques that can be used to automatically load a VBA project file when the AutoCAD program starts up.

The following is an example of an AcadStartup procedure that assigns the AcadApplication object of the current drawing to the oAcadApp variable:

Public Sub AcadStartup() Set oAcadApp = ThisDrawing.Application End Sub

Even though the procedure is named AcadStartup, it isn't executed automatically unless it is included in a DVB file named acad.dvb. Once you have declared a variable using the WithEvents keyword and assigned an object to the variable, you can then define a procedure that uses an exposed event of the object in your program.

The following steps explain how to add a procedure for an object event:

In the Project Explorer, double-click the ThisDrawing component. The code editor window opens. You will be working with the Object and Procedure drop-down lists (see Figure 33.5).

In the code editor window, click the Object drop-down list. Choose an object that you want to interact with when an event occurs. After you make a selection in the Object drop-down list, the event you select in the Procedure drop-down list will be added to the code editor window. You can remove the event if it isn't the one you want.

Click the Procedure drop-down list and choose the event you want to use in your program. A private procedure is added to the code editor window with the appropriate name and arguments. The following shows what the BeginCommand event looks like for a variable named g_oAcadApp that is of the AcadApplication object type:

Private Sub g_oAcadApp_BeginCommand(ByVal CommandName As String) End Sub

Figure 33.5 Selecting an object and event to add

After the procedure is added to your project, you then add the code statements that should be executed when the proper conditions are met in the AutoCAD drawing environment for the event to be triggered.

NOTE

Don't use the SendCommand or PostCommand method with an event-triggered procedure. The SendCommand and PostCommand methods are delayed and executed only after the AutoCAD program becomes idle, and the AutoCAD program typically doesn't enter an idle state until all the procedures triggered by events have been executed.

Table 33.6 lists some of the most commonly used events that the AcadApplication and AcadDocument objects support. For a full list of events, view the object's class in the Object Browser of the VBA Editor or the AutoCAD ActiveX Help system.

Table 33.6 Common events for the AcadApplication and AcadDocument objects

Events Supported objects Description

Activate

Deactivate AcadDocument Occurs when a drawing window receives (Activate) or loses (Deactivate) focus as a result of switching drawing windows.

AppActivate

AppDeactivate AcadApplication Occurs when the AutoCAD application window receives (AppActivate) or loses (AppDeactivate) focus as a result of switching applications.

BeginClose AcadDocument Occurs immediately after a request to close a drawing is made.

BeginCommand

EndCommand AcadApplication, AcadDocument Occurs when a command begins or ends. Useful in determining which command a user is using.

BeginDocClose AcadDocument Occurs before a drawing is completely closed. Useful if you don't want to allow the drawing to be closed.

BeginLisp

EndLisp AcadApplication, AcadDocument Occurs when the evaluation of an AutoLISP program or statement begins or ends. Useful in determining which AutoLISP programs a user is using.

BeginOpen

EndOpen AcadApplication Occurs before or after a drawing file is opened.

BeginPlot

EndPlot AcadApplication, AcadDocument Occurs before or after a layout is plotted.

BeginQuit AcadApplication Occurs before the application window is closed.

BeginSave

EndSave AcadApplication, AcadDocument Occurs before or after a drawing file is saved.

LayoutSwitched AcadDocument Occurs when focus is switched from one layout to another.

NewDrawing AcadApplication Occurs when a new drawing is being created.

ObjectAdded

ObjectErased

ObjectModified AcadDocument Occurs when an object is added to, erased from, or modified in a drawing.

SysVarChanged AcadApplication Occurs when a change to a system variable is being made. Not all system variables trigger this event. In the system variables database I maintain on my website, www.hyperpics.com/system_variables, I indicate whether or not a system variable triggers this event.

In addition to the events listed in Table 33.6, the AcadObject object supports an event named Modified. The AcadObject object is the base class used to implement graphical and nongraphical objects, such as AcadLine, AcadCircle, AcadLayers, and AcadLayer. You can use the Modified event to monitor changes to a specific object. However, instead of declaring a variable with events for a single object, it is often more efficient to use the ObjectModified event of the AcadDocument object.

Listing 33.1 shows an example program that logs the commands and first expressions of an AutoLISP program that are used after the BeginLog procedure is executed. Logging is disabled when the EndLog procedure is executed or when AutoCAD is closed. Using these two procedures, you can track the use of the custom programs and figure out which commands your users frequently use. I discuss how to write to a text file in Chapter 35,「Communicating with Other Applications.」

Listing 33.1: Custom command logging functionality using events

Private Sub AcadDocument_BeginCommand(ByVal CommandName As String) LogActivity CommandName End Sub Private Sub AcadDocument_BeginLisp(ByVal FirstLine As String) LogActivity FirstLine End Sub Private Sub LogActivity(sActivity As String) On Error Resume Next ' Create a new text file named Data.txt Dim ofsObj As FileSystemObject Set ofsObj = CreateObject("Scripting.FileSystemObject") sLogName = ThisDrawing.GetVariable("MyDocumentsPrefix") & _ "\cmdtracker.log" ' Open or create the log file If ofsObj.FileExists(sLogName) Then Set oTxtStreamData = ofsObj.OpenTextFile(sLogName, ForAppending) Else Set oTxtStreamData = ofsObj.CreateTextFile(sLogName, False) End If ' Write text to the log file oTxtStreamData.WriteLine sActivity oTxtStreamData.Close Set ofsObj = Nothing End Sub Public Sub DisplayLog() ' Open the log in NotePad Dim oShell As Object Set oShell = CreateObject("WScript.Shell") oShell.Run "Notepad.exe " & _ ThisDrawing.GetVariable("MyDocumentsPrefix") & _ "\cmdtracker.log" End Sub

The code in Listing 33.1 is in the sample file Ch33_CodeListings.dvb that is available from this book's website. When loaded, the code writes to a text file named cmdtracker.log in your My Documents (or Documents) folder. The following shows an example of the output containing commands and a single AutoLISP expression:

CIRCLE (alert "Hello ACP!") ERASE LINE ZOOM ZOOM

Exercise: Extending the User Interface and Using Events

In this section, you will create a new VBA project that loads a customization file named acp.cuix into the AutoCAD drawing environment and uses events to help enforce some basic layer standards. The acp.cuix file contains a custom ribbon tab, pull-down-menu, and toolbar, all named ACP. Using the AcadMenuGroups collection object, you will load the CUIx file and then use properties of the customization group to display the pull-down menu and toolbar in the AutoCAD user interface.

The ribbon tabs in one or more loaded CUIx files can be merged. For example, you can merge a custom ribbon tab named ACP with the standard Home tab. Merging ribbon tabs can make it easier to control where or when a custom ribbon tab is displayed on the ribbon. The process of merging two or more ribbon tabs requires you to assign the same alias value to the ribbon tabs you want to merge. To merge a custom ribbon tab with the Home tab, you would assign the custom ribbon tab the alias ID_TabHome.

The events that you define in this exercise will allow you to monitor the opening of a drawing file and instances of several different commands. The BeginCommand event allows you to perform tasks before a command is started, whereas the EndCommand event allows you to perform tasks after a command has been completed. The BeginCommand and EndCommand events will be used to watch for the use of hatch- and dimension-related commands; to check the current layer, when necessary; to set a specific layer as current before the command is started; and, when necessary, to restore the previous layer after the command has been completed.

The key concepts I cover in this exercise are as follows:

Loading a CUIx File CUIx files can be used to add new and arrange user interface elements in the AutoCAD drawing environment. Using the AutoCAD Object library, you can load a CUIx file and even control the display of some of the user interface elements defined in the CUIx file.

Implementing Application and Document Events Events are used to define how the user can interact with the controls on the UserForm and the code statements that the UserForm should execute when loading or unloading.

NOTE

The steps in this exercise depend on the Chapter 33 sample files (ch33_acp.cuix and ch33_hexbolt.dvb) available for download from www.sybex.com/go/autocadcustomization. If you completed all the exercises presented earlier in this book, you do not need to extract ch33_drawplate.dvb and ch33_furntools.dvb from the sample files archive. Place the sample files from the archive in the MyCustomFiles folder under the Documents (or My Documents) folder, or in the location you are using to store your custom program files. Once the sample files are extracted on your system, remove the characters ch33_ from the filenames.

Loading the acp.cuix File

Here you load a customization (CUIx) file that contains a ribbon tab, pull-down menu, and toolbar with a few of the tools you have created in various exercises throughout this book.

The following steps explain how to create a procedure that loads a CUIx file, and then controls the display of the pull-down menu and toolbar named ACP:

Create a new VBA project with the name Environment; make sure to also change the default project name of ACADProject to Environment in the VBA Editor.

In the VBA Editor, in the Project Explorer, double-click the ThisDrawing component.

In the code editor window, type the following code. Throughout this exercise, I've included the comments for your information, and you don't have to type them.Public Sub LoadACPMenu() On Error Resume Next ' Load the acp.cuix file ' Get the MenuGroups object of the application Dim oMenuGrps As AcadMenuGroups Set oMenuGrps = ThisDrawing.Application.MenuGroups ' Get the ACP menugroup if it is loaded Dim oMenuGrp As AcadMenuGroup Set oMenuGrp = oMenuGrps("ACP") ' If an error is returned, the ACP menugroup doesn't exist If Err Then Err.Clear oMenuGrps.Load ThisDrawing.GetVariable("MyDocumentsPrefix") & _ "\MyCustomFiles\acp.cuix", acPartialMenuGroup End If ' Display the ACP toolbar Dim oTbar As AcadToolbar Set oTbar = oMenuGrp.Toolbars("ACP") ' If an error is returned, the ACP toolbar wasn't found If Not Err Then If oTbar.Visible = False Then oTbar.Visible = True oTbar.Dock acToolbarDockTop End If End If ' Add the ACP menu to the menubar ' Display the menubar ThisDrawing.SetVariable "menubar", 1 ' Get the MenuBar object of the application Dim oMenuBar As AcadMenuBar Set oMenuBar = ThisDrawing.Application.MenuBar Dim oPopMenu As AcadPopupMenu Set oPopMenu = oMenuBar.Item("ACP") ' If an error is returned, the ACP menu isn't on the menubar If Err Then Err.Clear ' Add the ACP menu to the far right on the menubar oMenuGrp.Menus.InsertMenuInMenuBar "ACP", oMenuBar.Count End If End Sub

Click File Save.

Specifying the Location of DVB Files

The macros that are defined in the acp.cuix file expect that the AutoCAD program can locate the DVB files in its support file search paths. Chapter 36 explains more about setting up the AutoCAD support file search paths and the use of trusted paths in recent releases.

The following steps explain how to add the MyCustomFiles folder under the Documents (or My Documents) folder, or in the location you are using to store your custom program files to the AutoCAD support file search paths:

Click the Application menu button Options (or at the Command prompt, type options and press Enter).

When the Options dialog box opens, click the Files tab.

Select the Support File Search Path node. Click Add and then click Browse.

In the Browse For Folder dialog box, browse to the MyCustomFiles folder that you created for this book in the Documents (or My Documents) folder, or browse to the folder that contains your DVB files.

Select the folder that contains your DVB files and click OK.

Click OK to save the changes to the Options dialog box.

Adding the Document Events

Document events allow you to monitor changes that occur in the drawing window and the objects and other elements in the associated drawing file. Using the BeginCommand and EndCommand events, you can ensure that specific settings are in place—either before or after a command has been executed. In this exercise, you will be using these events to make sure a specific layer is set as current to ensure that dimensions are placed on the Dim layer and that hatch and gradient fills are placed on the Hatch layer. Using the same approach, you should warn users when they are about to draw on layer 0, which isn't ideal unless they are creating blocks.

The following steps explain how to add the BeginCommand and EndCommand events:

In the code editor window, scroll to the top and type the text shown in bold:Private g_sPrevLyr As String Public Sub LoadACPMenu()

In the code editor window, click the Object drop-down list and choose AcadDocument. The Object drop-down list is in the upper-left corner of the code editor window.

Click the Procedure drop-down list and choose BeginCommand.

If a procedure other than AcadDocument_BeginCommand was added before step 2, remove that procedure.

Type the code in bold that follows:Private Sub AcadDocument_BeginCommand(ByVal CommandName As String) On Error Resume Next ' Store the current layer g_sPrevLyr = ThisDrawing.ActiveLayer.Name ' Create and switch layers based on the command used Select Case CommandName Case "HATCH", "BHATCH", "GRADIENT" CreateSetLayer "Hatch", acRed Case "DIMLINEAR", "DIMDIAMETER", "DIMROTATED" CreateSetLayer "Dim", acGreen End Select End Sub

Add the EndCommand event and type the code in bold that follows:Private Sub AcadDocument_EndCommand(ByVal CommandName As String) On Error Resume Next ' Restore the previous layer if they are different If g_sPrevLyr <> "" Then ThisDrawing.ActiveLayer = ThisDrawing.Layers(g_sPrevLyr) End If End Sub

Click File Save.

The BeginCommand event uses a procedure named CreateSetLayer to create a particular layer or to set that particular layer as current. The following steps add the CreateSetLayer procedure:

In the code editor window, click after the End Sub statement of the EndCommand event procedure and press Enter twice.

Type the following code:Private Sub CreateSetLayer(sName As String, nColor As ACAD_COLOR) On Error Resume Next ' Get the layer if it exists Dim oLyr As AcadLayer Set oLyr = ThisDrawing.Layers(sName) ' If an error is returned, the layer doesn't exist If Err Then Err.Clear ' Create the layer and assign it a color Set oLyr = ThisDrawing.Layers.Add(sName) oLyr.color = nColor End If ' Set the layer current ThisDrawing.ActiveLayer = oLyr End Sub

Click File Save.

Implementing an Application Event

Application events allow you to monitor changes that are made to the application window, as well as some of the events that are available as document events. Using the EndOpen event, you can make sure specific settings and even applications are available before the user begins working in the drawing. In this exercise, you will be using the EndOpen event to make sure the drawing opens in model space by setting the system variable tilemode to 0 and then adjusting the view of the drawing to show the extents of the objects in model space. EndOpen can also be useful if you are trying to create a batch operation and want to know when it is safe to begin making changes to the drawing.

To define a variable of the AcadApplication object type with events, in the code editor window, scroll to the top and add the following code:

Private WithEvents g_oAcadApp As AcadApplication

Now that you have defined a variable with events in the global scope of the ThisDrawing component, you can access the variable from the Object drop-down list and add an available event:

In the code editor window, click the Object drop-down list and choose g_oAcad. The Object drop-down list is in the upper-left corner of the code editor window.

Click the Procedure drop-down list and choose EndOpen.

If a procedure other than g_oAcad_EndOpen was added after step 1 as a result of choosing g_oAcad from the Object drop-down list, remove that procedure. Choosing a different object adds a default procedure, if not already defined, which might not be the procedure you want to work with.

Type the code in bold that follows:Private Sub g_oAcadApp_EndOpen(ByVal FileName As String) On Error Resume Next ' Set the ModelSpace tab current ThisDrawing.SetVariable "tilemode", 1 ' Zoom to the extents of the drawing ThisDrawing.Application.ZoomExtents ' Zoom out a bit ThisDrawing.Application.ZoomScaled 0.8, acZoomScaledRelative End Sub

Click File Save.

Even though you added the EndOpen event, it won't be triggered until a reference to the AutoCAD application has been assigned to the g_oAcad variable. In the next section, you will add an AcadStartup procedure, which assigns the AutoCAD application object to the g_oAcad variable and executes the LoadACPMenu procedure.

Defining the AcadStartup Procedure

The AcadStartup procedure in this VBA project assigns the AcadApplication object of the current drawing to the global variable g_oAcad that was defined at the top of the code window of the ThisDrawing component. In addition to assigning the AcadApplication object to the g_oAcad variable, the AcadStartup procedure executes the LoadACPMenu procedure, which loads the acp.cuix file and displays the custom user interface elements in the AutoCAD drawing environment.

The following steps explain how to add the AcadStartup procedure:

In the code editor window, scroll to the bottom and click after the last code statement. Then press Enter twice.

Type the following code:Public Sub AcadStartup() ' Assign the current Application object to the g_oAcad variable Set g_oAcadApp = ThisDrawing.Application ' Load the ACP menu LoadACPMenu ' Execute the loading of the ACP menu a second time ' The ACP menu isn't always added the first time LoadACPMenu End Sub

Click File Save.

Testing the AcadStartup Procedure

Follow these steps to test the AcadStartup procedure in the Environment.dvb file:

Switch to the AutoCAD application and use the vbarun command to execute the environment.dvb!ThisDrawing.AcadStartup macro. The acp.cuix file is loaded and the custom user interface elements in the file are displayed, as you can see in Figure 33.6. The ACP menu is displayed on the menu bar, the ACP toolbar is docked below the ribbon, and the ACP ribbon tab is merged with the Home tab.

Click one of the custom tools on the ribbon, pull-down menu, or toolbar. If the File Loading - Security Concern message is displayed (AutoCAD 2013 or later), click Load. The DVB file in the macro is loaded and then a specific macro is executed. If the message「Macro not found」is displayed in the Command History window, make sure you added the correct folder to the AutoCAD support file search paths and renamed the DVB files as needed.

Press Esc to cancel the macro.

Figure 33.6 Custom user interface elements added by loading acp.cuix

Testing the Application and Document Events

To test the application and document events that are part of the Environment.dvb file, follow these steps:

Create a new drawing based on the acad.dwt drawing template file.

At the Command prompt, type layer and press Enter. Notice there is only one layer and it is named 0.

At the Command prompt, type rectang and press Enter. Draw a rectangle. The new rectangular object is drawn on layer 0.

At the Command prompt, type hatch and press Enter.

Follow the prompts of the hatch command and specify a point inside the rectangle to apply a hatch fill. The hatch object is added to the Hatch layer that was created and set as current when the hatch command was started. The previous layer is restored after the hatch command ends.

At the Command prompt, type dimlinear and press Enter.

Follow the prompts of the dimlinear command, and specify the lower corners of the rectangle to create the linear dimension. The dimension object is added to the Dim layer that was created and set as current when the dimlinear command was started. The previous layer is restored after the dimlinear command ends.

Click the Layout1 tab.

Save the drawing with the name ch33_exercise to the MyCustomFiles folder, or in the location you are using to store the exercise files from this book.

Close the drawing.

Reopen the ch33_exercise.dwg file. Notice the drawing opens in model space and the extents of the objects in the drawing are displayed. Figure 33.7 shows the results of the document and applications.

Figure 33.7 Layers created as a result of the BeginCommand event and the use of the hatch and dimlinear commands

Chapter 34

Creating and Displaying User Forms

Input from end users is either the key to a flexible and efficient program or its Achilles' heel. It all depends on how you gather and use that input. Up to this point, the input that you have been getting from the user has been requested at the AutoCAD® Command prompt. There is nothing bad about getting input only from the Command prompt, but it can be a limiting approach.

VBA programs support the ability to implement dialog boxes by adding a UserForm object to a project. Standard interactive controls that you are already familiar with from other Windows-based programs can be added to a user form to get input from the user. User forms allow a user to see values that might normally be hidden behind a set of prompts and provide input for only those options they are interested in changing. A user form can also be used to stitch multiple procedures together into a single, easy-to-use interface.

Adding and Designing a User Form

Many Windows-based programs use dialog boxes to get nonsequential input from the user and to provide feedback. A dialog box in a VBA project is known as a UserForm object. A user form, or dialog box, uses objects known as controls. A control can be of various types and sizes, and it usually accepts input from the mouse and/or keyboard that is attached to a workstation. In more recent years, input can come in the form of touch as well. Touch input is interpreted in a manner similar to mouse input. As a user clicks or types in a control, procedures known as events are executed. Events allow your program time to validate and manipulate the values provided through the control.

Adding a User Form to a VBA Project

With a VBA project loaded in the VBA Editor, a UserForm object can be added to the project. The default UserForm contains only a Close button in the upper-right corner, as shown in Figure 34.1. You can add a new UserForm object to a VBA project using one of the following methods:

On the menu bar, click Insert UserForm.

In the Project Explorer, right-click over the project and choose Insert UserForm.

Figure 34.1 Default UserForm displayed in the UserForm editor window

When a new UserForm object is added to a VBA project, it is displayed in the UserForm editor window. You can perform the following tasks with the UserForm editor window:

Add controls from the Toolbox window; see the「Placing a Control on a User Form」section later in this chapter for more information.

Reposition, resize, group, and align controls.

Use the Properties window to change the appearance of the user form or controls; see the「Changing the Appearance of a User Form or Control」section later in this chapter.

Define the behavior of the user form as it is being loaded or when the user interacts with controls; see the「Defining the Behavior of a User Form or Control」section later in this chapter.

As I explained with naming variables in Chapter 25,「Understanding Visual Basic for Applications.」Hungarian notation should be used to help identify a variable's data type. Hungarian notation is also typically used with UserForm objects and controls. The standard Hungarian notation used for a UserForm object name is frm.

TIP

If you have a UserForm in another project that you want to reuse, export the UserForm to a form (FRM) file and then import it into your project. Right-click over a UserForm in the Project Explorer and choose Export File to export the component. To import a previously exported component, right-click over a project and choose Import File.

Considering the Design of a User Form

A user form often provides your users with their first impression of your program. Users typically don't see the code that is running behind the scenes where all the real magic happens. As in real life, first impressions can be hard to shake. The user forms you create for your programs should have a familiar feel, as if the user has been using them forever.

When creating a user form, consider the following basic guidelines:

Controls with the most importance should be placed in the upper-left corner, whereas the least frequently used should be located in the lower area of the user form.

The flow in a user form should be top-down and left-to-right.

Controls should be aligned along the top edge when placed horizontally or along their left edge when placed vertically.

Controls of the same type should be of a similar size.

Organize and group related options together.

Don't crowd the controls on a user form—be sure to put some space between the controls. Be aware that too much space can make a user form feel empty.

Keep text labels and messages short and meaningful.

Buttons used to accept or cancel the changes made should be placed horizontally along the lower right or vertically along the right edge of the user form.

The button used to accept changes should be to the left of or above the button used to cancel the changes made.

