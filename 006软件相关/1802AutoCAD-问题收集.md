## 问题收集

### 01. 即使调了样式，打印出来的还是浅颜色的

这是因为使用了命名打印样式，输入命令 CONVERTPSTYLES，显示「打印样式图形转化为使用颜色相关打印样式」可转化。

### 02. 去「教育」打印的方法

方法 1：

先修复，文件 => 图形实用工具 => 核查；另存为 dxf 格式，再另存为 dwg 格式；很多时候转成 dxf 后打不开，目前的解决方法是先用 AcmeCADConverter 转换成 R14，应该是 14 版的 dxf 格式，接着用 CAD 打开该 R14 文件，另存为 dwg 就 OK 了。

方法 2：直接用插件。

### 03. 如何删除已经定义了的块

首先把块的那个图像给删了，接着 purge，清理掉要删除的块。

### 04. 布局的背景颜色改为黑色后还是白色

改完后在显示面板中，布局元素里把显示图纸背景勾掉就行了。

### 05. 启动 CAD 时 CADWORX 插件自动加载

命令 OP 进选项 => 配置 => 重置。

### 06. XA 插入外部参照的时候总是跑偏

那是因为基点不知道什么原因偏了，输入命令 base，指定基点为 0，0，0 就 OK 了。

### 07. CAD 用着用着总是容易死机

网上说到一复制就死机的情况，说是因为图形文件内部存在大量的注释性比例，当粘贴新的对象到文件时 CAD 会自检一遍这些比例设置，当比例有成百上千条时，这个过程就需要很长时间，CAD 程序也就会出现反应中止的现象了。

解决的办法如下：

方法 1：命令:  `-scalelistedit`，然后选项里选重置；该方法试过还是没有解决问题。

方法 2：把动态输入关了。

目前试过以上 2 中方法都不行。

### 08. 带基点复制就是拷不进目标文件里，可以拷进一个空白的文件

说明目标文件有问题，先把目标文件存为 dxf 格式的，就可以拷进 dxf 格式的文件里了，做完再存为 dwg 格式。发现存为 dxf 格式这一招屡试不爽。

### 09. 镜像命令后文字和图形总是倒着的

输入命令 MIRRTEXT，把值从 1 改为 0。

### 10. autolisp 打开后自动消失

VLIDE.DSK 出错。

`C:\Users\Administrator\AppData\Roaming\Autodesk\AutoCAD 2012 - Simplified Chinese\R18.2\chs\VLIDE.DSK` 文件，关闭 CAD，接着改为「VLIDE.DSK.BAK」，重启 CAD 和 VLIDE 即可。

### 11. CAD 打出来颜色很淡

后来发现 CAD 打印样式表无法选择 .ctb 样式（带颜色的），输入 convertpstyles，转换打印样式 stb 为 ctb，就可以选择了。

### 12. 双击打不开图纸

装完「天正电气」后出现的问题。

解决办法：输入命令「taskbar」设置为 0，然后右键 CAD 的快捷方式点属性，选择以兼容性运行，把「以管理员身份运行此程序」打勾去掉。

### 13. lsp 文件加载错误

报错信息：

错误：文件加载已取消。

CAD 安全设置的问题。解决方案：op 进入设置面板 => 系统 => 安全选项，进去后：1）关闭安全级别，不显示警告。2）自动加载里选择，打开每个图形时加载。

### 14. 输入的是绝对坐标点自定切换成了相对坐标点

CAD 系统设置的问题。捕捉那边，右键，进入草图设置 => 动态输入 => 左上角的启用指南输入 => 设置 => 相对坐标更改为绝对坐标。

### 15. 设置全局线型比例

命令 Ltscale 可以打开线型管理器，设置全局比例。

