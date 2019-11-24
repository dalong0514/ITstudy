# 0201. 插件汇总

官方插件汇总：[plugins [Zotero Documentation]](https://www.zotero.org/support/plugins)

## 01. Zotfile

### 1. 基本信息

官网：[ZotFile - Advanced PDF management for Zotero](http://zotfile.com/)

GitHub：[jlegewie/zotfile](https://github.com/jlegewie/zotfile)

Zotfile is a Zotero plugin to manage your attachments: automatically rename, move, and attach PDFs (or other files) to Zotero items, sync PDFs from your Zotero library to your (mobile) PDF reader (e.g. an iPad, Android tablet, etc.) and extract annotations from PDF files.

#### ★ Attach New Files to Zotero Items

ZotFile can rename and add the most recently modified file from the Firefox download or a user specified folder as a new attachment to the currently selected Zotero item. It renames the file using metadata from the selected Zotero item (user configurable), and stores the file as a Zotero attachment to this item (or alternatively, moves it to a custom location).

#### ★ (Batch) Rename and Move Attachments based on Zotero Metadata

The user can also select any number of Zotero items and automatically rename and move all attachments of these items according to the user defined rules using metadata of the respective zotero item (batch processing).

#### ★ Sync PDFs with your iPad or Android tablet

To read and annotate PDF attachments on your mobile device, zotfile can sync PDFs from your Zotero library to your (mobile) PDF reader (e.g. an iPad, Android tablet, etc.). Zotfile sends files to a location on your PC or Mac that syncs with your PDF reader App (PDF Expert, iAnnotate, GoodReader etc.), allows you to configure custom subfolders for easy access, and even extracts the annotations and highlighted text to Zotero notes when you get the files back from your tablet. Instructions are below.

#### ★ Extract Annotations from PDF Files

After highlighting and annotating pdfs on your tablet (or with the PDF reader application on your computer), ZotFile can automatically extract the highlighted text and note annotations from the pdf. The extracted text is saved in a Zotero note. Thanks to Joe Devietti, this feature is now available on all platforms based on the pdf.js library.

### 2. 下载安装

官网下载好匹配版本的插件后「zotfile-5.0.14-fx.xpi」。

Tools >> Add-ons，进下面的 Plugins 面板，点右上角的设置进去，install add-on from File，加载安装插件。然后进上面的 Extensions 面板，会看到插件生效需要重启 Zotero。

在 Drobox 目录下面，创建一个 tablet 目录。

进入 Zotfile 的 Preferences，在「Tablet Settings」里：

1. 勾选「Use Zotfile to send and get files from tablet」

2. Base Folder 里填写之前创建的 tablet 目录途径「/Users/Daglas/Dropbox/tablet」

3. 勾选「Create subfolders from zotero collections」

在「General Settings」里：

1. 勾选「Watch for new files in source folder」

2. Custom 里填写「/Users/Daglas/Downloads」

1『

General Settings 里的设置目前没操作，感觉对我无用，待确认。

这个文件夹位置是你指定 Zotfile 要时常识别的。后来定位到了：/Users/Daglas/Documents/KnowledgeText

』

回到 Zotero 主界面后，会发现多了 2 个文件夹「Tablet Files」和「Tablet Files(modified)」。

1『无意中误操作，取消了「Use Zotfile to send and get files from tablet」，然后再勾选了，回到朱界面后发现上面的 2 个文件夹出现了双份。另外，阳志平的有很多其他名称的文件夹，目前不清楚是如何设置的。』

### 3. 使用

批量选中文件后，右键 >> Manage Attachments >> Rename Attachments，文件就会按照「作者名-发表年份-论文名」格式批量被命名。

批量选中文件后，右键 >> Manage Attachments >> Send to Tablet，就会将这些 PDF 文件发送到一个单独的 tablets 目录下面。

批注完了，右键 >> Manage Attachments >> Get from Tablet，可以取回所有 PDF。

1『目前获得的信息（待确认）：先把要批注的发送到 Tablet 里，用 Skim 这种工具批注完之后，返还回 Zotero。』

## 02. Markdown here

### 1. 下载安装

[fei0810/markdownhere4zotero: markdown here zotero 插件](https://github.com/fei0810/markdownhere4zotero)

[奶牛快传 | CowTransfer | 文件传输服务](https://kaopubear.cowtransfer.com/s/3c191f9a3ebf42)

安装下载了上面的插件。

[adam-p/markdown-here: Google Chrome, Firefox, and Thunderbird extension that lets you write email in Markdown and render it before sending.](https://github.com/adam-p/markdown-here)

1『上面的这个应该是浏览器里写邮件用的，目前下载了 Google 插件，还没使用。但感觉这个插件也能在 Zotero 里加载。』

### 2. 使用

找到条目，然后新建一笔记，然后快捷键「control+option+M」即可生成效果。

## 03. Paper Machines

[papermachines/papermachines: [UNMAINTAINED] A Zotero extension for analysis and visualization in the digital humanities.](https://github.com/papermachines/papermachines)

[Install | Paper Machines](http://papermachines.org/install/)

版本不匹配，目前装不了。

## 04. zotero-scholar-citations

Google 学术里自动、批量更新引用次数的插件。

[beloglazov/zotero-scholar-citations: Zotero plugin for auto-fetching numbers of citations from Google Scholar](https://github.com/beloglazov/zotero-scholar-citations)

下载插件「zotero-scholar-citations-1.9.3-fx」。

该插件开发者为了避免将你条目自带的【引用次数】字段与【Google学术引用次数】冲突，所以，他将其保存在【其它】那个字段里面去了。点属性面板，把「其他」勾选一下。

加载后，点击右键，更新一下引用即可在「其他」里看到数据。

## 05. Altmetric

[Discover the attention surrounding your research – Altmetric](https://www.altmetric.com/)

这个不是插件，配套使用的。如何知道全世界关于这篇文献的意见呢？Altmetric 就是拿来干这个的！将这个页面的「Altmetric it!」书签拖到 Chrome 菜单栏上即可。现在需要填写个人信息那个蓝色的书签才显示出来。
