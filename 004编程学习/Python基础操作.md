## 0201. Python 基础

2023-11-28

在Conda中创建一个新的虚拟环境非常简单。您只需要打开终端（在Windows上是命令提示符或Anaconda Prompt），然后使用以下命令：

```sh
conda create --name study
```

这将创建一个名为 `llm` 的新虚拟环境。如果您希望在此环境中安装特定的Python版本或其他包，您可以在创建环境时指定它们，如下所示：

```sh
conda create --name llm python=3.9
```

这将创建一个包含Python 3.8的新环境。或者，如果您想安装其他包，可以这样做：

```sh
conda create --name llm python=3.9 numpy pandas
```

这将创建一个环境，其中包括Python 3.9、NumPy和Pandas。

创建环境后，您可以使用以下命令激活该环境：

```sh
conda activate study
```

当您完成工作并想要退出虚拟环境时，可以使用以下命令：

```sh
conda deactivate
```

这将返回您到基础环境或之前的工作环境。

要查看Conda中所有可用的虚拟环境，您可以在终端中使用以下命令：

```sh
conda env list
```

或者

```sh
conda info --envs
```

这两个命令都会列出您的机器上存在的所有Conda虚拟环境，以及它们各自的路径。当前激活的环境会在其名称旁边有一个星号(*)标记。

要删除一个名为 `gpt` 的Conda虚拟环境，您可以使用以下命令：

```sh
conda env remove --name gpt
```

在执行此命令后，Conda将删除该环境及其包含的所有包。如果您想确认环境已被删除，可以再次运行 `conda env list` 来查看当前的环境列表。如果删除成功，`gpt` 环境将不再列出。

### 细节汇总

1、注释。以 # 开头的语句是注释，注释是给人看的，可以是任意内容，解释器会忽略掉注释。

2、每一行都是一个语句，当语句以冒号 : 结尾时，缩进的语句视为代码块。

3、缩进。缩进有利有弊，好处是强迫你写出格式化的代码，但没有规定缩进是几个空格还是 Tab。按照约定俗成的管理，应该始终坚持使用 4 个空格的缩进。在文本编辑器中，需要设置把 Tab 自动转换为 4 个空格，确保不混用 Tab 和空格；

4、Python 程序是大小写敏感的，如果写错了大小写，程序会报错。

5、Mac 上安装 3.0 版本的话，在 shell 里直接输入 python3 进入交互界面（前面有个 >>>），输入命令 exit() 或者 control D 可以退出交互界面。

6、在 shell 里可以执行 python3 hello.py 运行一个 .py 文件。目前常规的做法就是 vim 里写程序，再运行 .py 文件。

7、重复上一个语句的话用快捷键 control+P。

8、2 的 10 次方的语句是 2**10。

9、mac 的 shell 里把程序的结果输出为文本格式。

python script1.py > saveit.txt 

10、获取数据类型的内置函数。

type() 函数，比如 type(1) 返回的是 int；另一个更常用的是 isinstance() 函数，isinstance(1,int) 返回的是 true。

11、转化数据类型。用内置函数，把对象转化为字符串的话是 str()；转化为整数的话是 int()。

12、中文编码不了。

代码的第 1 行或者第 2 行添加 #-*- coding: utf-8 -*- 

13、输入函数 input()。

14、python 编码 encode 和 decode。计算机里面，编码方法有很多种，英文的一般用 ascii，而中文有 unicode，utf-8,gbk,utf-16 等等。

unicode 是 utf-8,gbk,utf-16 这些的父编码，这些子编码都能转换成 unicode 编码，然后转化成子编码，例如 utf8 可以转成 unicode，再转 gbk，但不能直接从 utf8 转 gbk。所以，python 中就有两个方法用来解码（decode）与编码（encode），解码是子编码转 unicode，编码就是 unicode 转子编码。

###  问题

#### 01

问题：在包里写 print(‘大龙’)，运行包总是显示代码错误。（2017-12-02）

报错：SyntaxError: (unicode error) 'utf-8' codec can't decode byte 0xb4 in position 0:invalid start byte

基本知识：在 python 中默认的编码格式是 utf-8，所以怎么会报不能按 utf-8 来解码？后来发现 hello.py 这个文件就不是用 utf-8 编码的。

问题的解决：在 Vim 中可以直接查看文件编码。

	:set fileencoding

在 Vim 中直接进行转换文件编码，比如将一个文件转换成 utf-8 格式。

	:set fileencoding=utf-8

也利用 shell 自带的 iconv 命令进行编码转换文件内容编码转换。

#### 02

问题：在 vim 中敲 python 的代码自动补全插件 YouCompleteMe 不起作用了。（2017-12-28）

因为目前 YouCompleteMe 仅支持 python2 的，自从安装 anaconda 后，python3 成了 vim（或者可以说是系统里）中默认的 python 版本了，所以补全插件不起作用了。如何查看，在 shell 里输入命令 which python 看看返回的是哪个版本就是哪个。

那么只要将 python2 设为默认的即可，在 shell 配置文件 .vimrc 中把全局变量中的路径 /Applications/anaconda3/bin 放到改行的最后即可，重启 iTerm 即可。

###  其他

1、main 入口函数的作用。

```py
if __name__ == '__main__':
    main()
```

每个 py 文件用 main 入口函数这种结构，那么当执行 py 文件时，无论是主文件还是被载入的模块文件，后台都会自动去识别。

