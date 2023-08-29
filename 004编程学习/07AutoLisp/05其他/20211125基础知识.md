## 01. AutoLISP

[AutoLISP - Wikipedia](https://en.wikipedia.org/wiki/AutoLISP)

AutoLISP is a dialect of the programming language Lisp built specifically for use with the full version of AutoCAD and its derivatives, which include AutoCAD Map 3D, AutoCAD Architecture and AutoCAD Mechanical.[1] Neither the application programming interface (API) nor the interpreter to execute AutoLISP code are included in the AutoCAD LT product line.[2]

### 1.1 Features

AutoLISP is a small, dynamically scoped, dynamically typed Lisp language dialect with garbage collection, immutable list structure, and settable symbols, lacking in such regular Lisp features as macro system, records definition facilities, arrays, functions with variable number of arguments or let bindings. Aside from the core language, most of the primitive functions are for geometry, accessing AutoCAD's internal DWG database, or manipulation of graphical entities in AutoCAD. The properties of these graphical entities are revealed to AutoLISP as association lists in which values are paired with AutoCAD group codes that indicate properties such as definitional points, radii, colors, layers, linetypes, etc. AutoCAD loads AutoLISP code from .LSP files.[3]

AutoLISP code can interact with the user through AutoCAD's graphical editor by use of primitive functions that allow the user to pick points, choose objects on screen, and input numbers and other data. AutoLisp also has a built-in graphical user interface (GUI) mini- or domain-specific language (DSL), the Dialog Control Language, for creating modal dialog boxes with automated layout, within AutoCAD.[3]

### 1.2 History

AutoLISP was derived from an early version of XLISP, which was created by David Betz.[4] The language was introduced in AutoCAD Version 2.18 in January 1986, and continued to be enhanced in successive releases up to release 13 in February 1995. After that, its development was neglected by Autodesk in favor of more fashionable development environments like Visual Basic for Applications (VBA), .NET Framework, and ObjectARX. However, it has remained AutoCAD's main user customizing language.

Vital-LISP, a considerably enhanced version of AutoLISP including an integrated development environment (IDE), debugger, compiler, and ActiveX support, was developed and sold by third party developer Basis Software. Vital LISP was a superset of the existing AutoLISP language that added VBA-like access to the AutoCAD object model, reactors (event handling for AutoCAD objects), general ActiveX support, and some other general Lisp functions. Autodesk purchased this, renamed it Visual LISP, and briefly sold it as an add-on to AutoCAD release 14 released in May 1997. It was incorporated into AutoCAD 2000 released in March 1999, as a replacement for AutoLISP. Since then, Autodesk has ceased major enhancements to Visual LISP and focused more effort on VBA and .NET, and C++. As of January 31, 2014, Autodesk no longer supports VBA versions older than 7.1. This is part of a long-term process of changing from VBA to .NET for user customizing.[5][6]

AutoLISP has such a strong following that other computer-aided design (CAD) application vendors add it to their products. Bricscad, IntelliCAD and others have AutoLISP functionality, so that AutoLISP users can consider using them as an alternative to AutoCAD. Most development involving AutoLISP since AutoCAD 2000 is performed within Visual LISP since the original AutoLISP engine was replaced with the Visual LISP engine. There are thousands of utilities and applications that have been developed using AutoLISP or Visual LISP (distributed as LSP, FAS and VLX files).[7][8]

## 02. 相关资料

[AutoLISP Developer's Guide (AutoLISP) | Search | Autodesk Knowledge Network](https://knowledge.autodesk.com/search-result/caas/CloudHelp/cloudhelp/2018/ENU/AutoCAD-AutoLISP/files/GUID-265AADB3-FB89-4D34-AA9D-6ADF70FF7D4B-htm.html)

[How to write AutoLISP programs - YouTube](https://www.youtube.com/watch?v=bBep15gyTl0)

[AutoLISP Developer's Guide](http://entercad.ru/acad_alg.en/)

[Pomoc: Overview of ObjectARX](http://help.autodesk.com/view/OARX/2018/PLK/?guid=GUID-9B4F6629-8B7D-460B-802B-6D2C25966994)

## 03. 细节

1、用 brew 安装 sbcl，然后输入命令 sbcl 可以进入交互器。

2、CAD 里快捷键 F2 进入文本命令编辑器。可以直接在文本命令编辑器输入 autolisp 命令。

## 04. 测试框架

### FiveAM

初步选择使用 FiveAM 框架，目前还没整的跑过。（2020-10-15）

[CLiki: Test Framework](https://www.cliki.net/test%20framework)

[CLiki: FiveAM](https://www.cliki.net/FiveAM)

[FiveAM](https://common-lisp.net/project/fiveam/)

[FiveAM](https://common-lisp.net/project/fiveam/docs/index.html)