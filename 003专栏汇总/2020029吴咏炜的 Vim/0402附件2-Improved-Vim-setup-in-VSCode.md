# Improved Vim setup in Visual Studio Code
Sebastian Hoitz
Sebastian Hoitz
Follow
Jan 14 · 4 min read





Okay, I admit it: I’m a huge Vim fan. Usually the first thing I do when using any kind of text editor is to check, if there is a Vim module available. The keys and motions have just been ingrained into my brain.
VS Code has a very active community that writes a ton of plugins. There are also several Vim emulations. By far the most popular is this: VSCode Vim.
The README contains a lot of useful configurations that you can add to your settings.json . However, to simulate Vim behavior everywhere you also have to add some additional keybindings in the keybindings.json.
Below I want to give a list of my favorite configurations. I hope you find them useful. In order to make it more clear, which file we are currently talking about, I have commented this in every code block. You can get to these files by pressing CMD + Shift + P and then executing the command Preferences: Open settings (JSON) or Preferences: Open keyboard shortcuts (JSON) .
Image for post
Map space to save file (when in normal mode)
// settings.json
"vim.normalModeKeyBindingsNonRecursive": [
  {
    "before": ["<space>"],
    "commands": ["workbench.action.files.save"]
  }
]
This is very handy. If you want to save the current file, just press the space key when in Insert mode.
Split the current editor and easy moving around
// File: settings.json
"vim.normalModeKeyBindingsNonRecursive": [
  {
    "before": ["<leader>", "w"],
    "commands": ["workbench.action.splitEditor"]
  }
]
This adds a new vertical window. Also, for easier moving around than pressing CTRL + W -> HJKL , add this to your keybindings.json:
// File: keybindings.json
{
  "key": "ctrl+h", 
  "command": "workbench.action.focusLeftGroup", 
  "when": "editorTextFocus && vim.active && vim.mode != 'Insert'"
},
{
  "key": "ctrl+l", 
  "command": "workbench.action.focusRightGroup", 
  "when": "editorTextFocus && vim.active && vim.mode != 'Insert'"
},
{
  "key": "ctrl+k", 
  "command": "workbench.action.focusAboveGroup", 
  "when": "editorTextFocus && vim.active && vim.mode != 'Insert'"
},
{
  "key": "ctrl+j", 
  "command": "workbench.action.focusBelowGroup", 
  "when": "editorTextFocus && vim.active && vim.mode != 'Insert'"
},
This allows you to just press CTRL + HJKL to focus the editor next to the current.
Improving the file explorer usage
I’m a huge fan of NERDTree, but sadly most of the functionality is hard to replicate in VSCode. However, these settings were quite helpful:
// File: settings.json
"vim.normalModeKeyBindingsNonRecursive": [
  {
    "before": ["<leader>", "t"],
    "commands": ["workbench.action.toggleSidebarVisibility"]
  },
  {
    "before": ["<leader>", "f"],
    "commands": [ "revealInExplorer" ],
  },
  {
    "before": ["<leader>", "r", "f"],
    "commands": [ "fileutils.renameFile" ]
  }
]
Now, you can easily toggle the explorer by pressing <Leader> + t , but you can also search the currently active file in the explorer or rename the current file.
However, this alone does not cut it. The command only gets picked up if you are in an Editor that is Vim-enabled. This means, if the currently active window is the Explorer, you are out of luck closing the Explorer. That is, unless you add this to your keybindings:
// File: keybindings.json
{
  "key": ", t", 
  "command": "workbench.action.toggleSidebarVisibility", 
  "when": "!editorTextFocus"
}
If you also want to use your keyboard to move around in the file tree, these might be handy:
// File: keybindings.json
{ 
  "key": "ctrl+h",
  "command": "list.collapse",
  "when": "listFocus && !inputFocus"
},
{ 
  "key": "ctrl+l",
  "command": "list.expand",
  "when": "listFocus && !inputFocus"
},
{ 
  "key": "ctrl+k",
  "command": "list.focusUp",
  "when": "listFocus && !inputFocus"
},
{ 
  "key": "ctrl+j",
  "command": "list.focusDown",
  "when": "listFocus && !inputFocus"
}
Using these, you can move around in the file tree, pressing CTRL + JK to move up and down and CTRL + HL to expand and collapse entries.
Bonus: In my oppinion, the default behavior of pressing Enter in the file tree is off. I would much prefer to use Enter to open a file and CMD + Enter to rename a file. Here is how to do this:
// File: keybindings.json
{
  "key": "cmd+enter",
  "command": "renameFile",
  "when": "explorerViewletVisible && filesExplorerFocus"
},
{
  "key": "enter",
  "command": "-renameFile",
  "when": "explorerViewletVisible && filesExplorerFocus"
},
{
  "key": "enter",
  "command": "list.select",
  "when": "listFocus && !inputFocus"
}
Navigating Autosuggest and Quick Open entries
Image for post
Use the home row keys (CTRL+J, CTRL+K) to navigate up and down
It always bothered me that I had to use the normal arrow keys or the mouse to select an entry from the autosuggest or quick-open menu. Luckily, we can remap keys for that as well:
// File: keybindings.json
{
  "key": "ctrl+j",
  "command": "selectNextSuggestion",
  "when": "suggestWidgetVisible"
},
{
  "key": "ctrl+k",
  "command": "selectPrevSuggestion",
  "when": "suggestWidgetVisible"
},
{
  "key": "ctrl+j",
  "command": "workbench.action.quickOpenSelectNext",
  "when": "inQuickOpen"
},
{
  "key": "ctrl+k",
  "command": "workbench.action.quickOpenSelectPrevious",
  "when": "inQuickOpen"
}
Summary
I think we can agree that is quite amazing, just how much of the functionality you can modify and adapt to your liking. If you are interested in my whole configuration, you can find them here:

181

4

Vim
Vscode
How To
Software Development
Best Practices
181 claps

4 responses





Sebastian Hoitz
WRITTEN BY

Sebastian Hoitz
Follow
As an entrepreneur and software engineer I am passionate about digital business models, quick value delivery, agile organizations and resilient teams.
More From Medium
Related reads
The Programming Language I’m Looking For
Gal Schlezinger
Gal Schlezinger in HackerNoon.com
Sep 24, 2018 · 9 min read
3.4K

Related reads
A better NerdTree setup
Victor Mours
Victor Mours
Jun 4, 2015 · 2 min read
1.3K

Related reads
Building my first keyboard (and you can too)
Sasha Solomon
Sasha Solomon
Mar 26, 2019 · 14 min read
1.8K

Discover Medium
Welcome to a place where words matter. On Medium, smart voices and original ideas take center stage - with no ads in sight. Watch
Make Medium yours
Follow all the topics you care about, and we’ll deliver the best stories for you to your homepage and inbox. Explore
Explore your membership
Thank you for being a member of Medium. You get unlimited access to insightful stories from amazing thinkers and storytellers. Browse
About
Help
Legal