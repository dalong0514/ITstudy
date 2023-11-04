## 问题记录2021

### 01. 跨图复制实体对象

1、搜索相关知识。

Google 搜索信息汇总：

[Lisp to copy,paste from one to another drawing... - AutoLISP, Visual LISP & DCL - AutoCAD Forums](https://www.cadtutor.net/forum/topic/68799-lisp-to-copypaste-from-one-to-another-drawing/)

帖子里连接到：[Copy to Drawings | Lee Mac Programming](http://www.lee-mac.com/copytodrawing.html)

Lee Mac 实现功能更复杂，研究后可以截取部分功能满足自己的需要，待实现。（2021-02-25）

[Copy Method](https://www.afralisp.net/archive/methods/list/copy_method.htm)：这里提供了一个代码实现，自己重复了一遍，发现满足不了自己的需求。（2021-02-25）

2、autolisp 官方文档。

[CopyObjects Method (ActiveX)](http://help.autodesk.com/view/OARX/2018/CHS/?guid=GUID-D9E0A89C-2D81-4141-8B88-B9AC6EAABD62)

补充：目前还是通过原始的方法实现的，整个图形提炼成一个数据集，通过临时函数传递到另外一张图纸后，还原数据集成图形文件。具体详见数据流的源码。（2021-03-08）

### 02. 编码问题

2021-03-12

拆解文件时，只是做了代码的挪移，加载后总是报错：字符串不对之类的。

一点一点的挪移排查，后来发现是新建的文件「dataflowGsLc.lsp」默认的编码格式是 utf-8，但 lsp 文件这边不想其他高级语言，utf-8 编译不了中文的，之前所有的 lsp 文件都是 gb2312 编码的。编码格式改了下即可解决问题。