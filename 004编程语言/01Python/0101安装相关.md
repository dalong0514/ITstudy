# 0101. Python 安装相关

## 01. 安装 conda

[conda的安装与使用（2019-6-28更新） - 简书](https://www.jianshu.com/p/edaa744ea47d)

Conda 是一个开源的软件包管理系统和环境管理系统，用于安装多个版本的软件包及其依赖关系，并在它们之间轻松切换。 Conda 是为 Python 程序创建的，适用于 Linux，OS X 和 Windows，也可以打包和分发其他软件。

conda 分为 anaconda 和 miniconda。anaconda 是包含一些常用包的版本（这里的常用不代表你常用），miniconda 则是精简版，需要啥装啥，所以推荐使用 miniconda。

去官网下载[Miniconda — Conda documentation](https://docs.conda.io/en/latest/miniconda.html)，可以下载脚本版的 [Miniconda3 MacOSX 64-bit bash]，cd 进下载文件夹后，直接命令：

	sh Miniconda3 MacOSX 64-bit bash

注意，以前的教程都是教一路 yes 下来的，但是会有隐患，特别是当你的服务器之前有安装过软件的话，conda 会污染你原来的环境，把你原来设置好的东西进行更改。具体的惨痛教训请参见：[Anaconda is a snake.](https://mp.weixin.qq.com/s?__biz=MzAxMDkxODM1Ng==&mid=2247486380&idx=1&sn=9329fcd0a60ac5488607d359d6c28134&chksm=9b484b17ac3fc20153d25cbdefe5017c7aa9080d13b5473a05f79808244e848b0a45d2a6a735&scene=21#wechat_redirect)。

所以在询问是否将 conda 加入环境变量的时候选择 no。

1『我安装的时候没有让我选这个。』

在上一步选择 no 之后，输入 conda 是会报找不到此命令的。那要如何启动呢？

找到你刚才安装的 miniconda，如果没有更改过安装位置的话应该是在 /home 下面，cd 到 miniconda3 的 bin 目录下面，能看到有一个 activate。

这里需要给 activate 添加一下权限才能使用：

	chmod 777 activate 

接下来启动：

	source ./activate

当命令行前面出现 (base) 的时候说明现在已经在 conda 的环境中了。这时候输入 conda list 命令就有反应了。

添加频道。这个道理跟家里的电视机是一样一样的，安装 conda 就相当于买了一台电视机，但是有电视了不意味着你就能看节目了，你要手动添加频道才能看你想看的电视节目。

比如：

```
conda config --add channels bioconda
conda config --add channels conda-forge
```

### 退出 conda 环境

退出也很简单，之前我们是 . ./activate 或者 [. ~/miniconda3/bin/activate] 现在退出只要：

	. ./deactivate

1『这里的 . 相当于 source，shell 提示改用命令 conda deavtivate。那么逆向思维，直接命令 conda activte 即可激活 conda 环境。』

[miniconda的安装及使用 - weixin_42066885的博客 - CSDN博客](https://blog.csdn.net/weixin_42066885/article/details/80323173)

### 安装 ipython

直接用 conda 安装 ipython 取代原始的 Python 交互器。

	conda install ipython

安装完后直接命令 ipython 进入交互器。

## 02. 安装 Python

目前，Python 有两个版本，一个是 2.x 版，一个是 3.x 版，这两个版本是不兼容的。

如果使用 Mac，系统是 OS X 10.8~10.10，那么系统自带的 Python 版本是 2.7。要安装最新的 Python 3.5，有两个方法：

方法一：从 Python 官网下载 Python 3.5 的安装程序（网速慢的同学请移步国内镜像），双击运行并安装；

方法二：如果安装了 Homebrew，直接通过命令 brew install python3 安装即可；

看到提示符 >>> 就表示我们已经在 Python 交互式环境中了，可以输入任何 Python 代码，回车后会立刻得到执行结果。现在，输入 exit() 并回车，就可以退出 Python 交互式环境（直接关掉命令行窗口也可以）。

shell 里输入命令 python 是进入 2.X 的版本，目前 mac 上也不建议的，未来 2.X 的版本肯定是会被淘汰的。输入命令 python3 即可进入 3.X 版本的，目前自己的 mac 里的版本号是 3.7.2。

### 问题

目前在 mac 上只要同时安装 macvim 和 python 2.7.13，一打开 macvim 的话 python 就意外退出；目前还没找到解决的办法，只能同时卸载 macvim 和 python 2.7.13，用 vim 和 python 3.6。（20170809 记录）

找到了原因。（20171228）

vim 中 Python2 和 Python3 不能共存，当它们都支持时，它们必须是动态载入的方式；在 Linux/Unix 环境中，当导入全局符号时，会导致第二个 Python 版本崩溃。所以要么加载 global symbols 只激活一个 Python 版本，要么不导入全局符号，这会导致 Python 导入 vim 提供的全局符号的相关库的 import 出错。

1『目前还是不理解这个原因，2019-11-26』

输入命令 vi - -version 后可以查到系统自带的 vim 只支持 python2，但不支持 python3 的。

还有一种办法是在 vim 编辑器中输入命令 :echo has('python') 或者 :echo has('python3') 返回的结果是 1 的表示支持，0 的话表示不支持。

用 brew 安装 macvim 都是安装支持 Python2 版本的，安装的时候命令后面可以加一个什么选项即可让安装的 vim 支持 Python3。

### 安装 pip

shell 里输入命令 sudo easy_install pip 即可。

### 安装 MySQL 驱动

shell 里输入命令：

sudo pip install mysql-connector-python --allow-external mysql-connector-python

安装完发现用 python2 是可以连接 mysql 的；python3 不行；此问题待解决。

### 安装 anaconda

[官网](https://www.anaconda.com/download/#macos)上下载 python3.6 版本的，安装；安装目录没有选默认的 /，而是选了 /Applications/；结果发现进入 python 交互界面后没有载入 anaconda；

发现是环境变量设置的问题。

在 shell 里，命令:

	echo $PATH 

可以查看环境变量所有的路径，现在需要把安装的 anaconda 的路径 （/Applications/anaconda3/bin）添加进环境变量中。

~ 用户根下有个 .zshrc 文件，vi 进去把上面的路径添加进 PATH 里；然后用命令 source .zshrc 重载一下；接着在 shell 里可以直接用 anaconda 的命令 conda 了，比如 conda info -e 就可以得到你安装的 python 信息。

做完这些后发现原来命令 python 是进入 2.7 版本界面的，现在自动进入了 3.6.3 版本，可以自动加载 anaconda 了，python3 命令还是进入原来的 3.6.2 版本，还是无法加载 anaconda。

发现输入命令 python2.7 可以进入 2.7 版本界面；输入命令 python3.6 是进入 3.6.2 版本界面。

目前发现安装 anaconda 的时候应该本人用户的根目录下在新建的了文件 .bash_profile，里面增加了如下：

	export PATH=“/Applications/anaconda3/bin:$PATH”

输入命令 python 的时候先加载该文件，从这个环境变量里先加载，而 3.6.3 版本是在这个文件夹里，又因为只有 3.6.3 版本才能自动加载 anaconda3 所以造成了现在的局面。

20171208 日发现 3.6.3 版本是安装 anaconda3 的时候自动安装进去的，3.6.2 版本就可以删掉了，因为当时是用 brew 安装的，用命令 brew uninstall python3 将其卸载掉。

为什么的问题未解决。

### 环境变量的概念

使用场景 1，我们有一个程序 Java，需要读取某个文件（/data/file.txt），那么我们在运行的时候是不是需要做如下的步骤：

1、cd 到 Java 的目录下。

2、执行 Java 命令。
 但是，当我们需要同时使用多个工具的时候，比如又有 java、maven、git 等等，而且是多台机器的时候，我们通常需要很多繁琐的 cd 操作。而配置环境变量就可以使我们可以快速的运行这些脚本了。

使用场景 2，如果我们又有 JDK1.7，又有 JDK1.8，而且需要经常的切换，那么怎么办？ 

可以配置局部变量比如：

	export JDK1.7=/usr/apps/jdk1.7

	export JDK1.8=/usr/apps/jdk1.8

	export PATH=$JDK1.7/bin

这样，在改变的时候，就不需要去不到改变，而改变部分句可以了。

有了上面的介绍，我们大概就可以知道环境变量到底有什么用处了。用处就是可以在操作系统的各个目录下，都能访问到需要的工具目录内的内容，和 Windows 的桌面的思想十分相似，而且相当于在系统的各处都具有这个桌面的快捷方式。

### mac 里管理不同版本的 python

首先通过 homebrew 安装 pyenv，之后的所有 Python 安装和管理通过 pyenv 进行。

	brew install pyenv

根据提示需要添加

	if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
	
	export PYENV_ROOT=/usr/local/var/pyenv

这里注意了，如果使用的 zsh，务必不要在 zshrc 配置里面的插件开启 pyenv。会导致终端无限循环退出，只需要在你的 zshrc 结尾处追加上面两行就行了。我安装的时候没必要弄这一步。

查看可以安装的 Python 版本：

	pyenv install - -list

安装需要的 Python 版本：

	pyenv install 3.5.2

查看目前正在使用的 Python 版本：

	pyenv versions

如果需要在不同版本的 Python 间进行切换的话，使用以下命令：

	pyenv global 3.3.1

当然，你也可以让版本切换只对当前目录生效：

	pyenv local 2.7.5

目前查看版本没效果，推测是现在除了苹果自动的 2.7.10 版本 pyenv 识别不了，mac 里目前只有 3.6.3 这一个版本；待确认。
