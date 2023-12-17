[mlx-examples/llama at main · dalong0514/mlx-examples](https://github.com/dalong0514/mlx-examples/tree/main/llama)

[‍⁢​⁢‍⁡⁢231206 MLX - 飞书云文档](https://xnboqt31tz.feishu.cn/wiki/D5RMwkGZpiQLjrkSC1icF47Enfb)

[‌⁣⁢​​​​‌‬‬⁤‌⁣⁡‬​​‌231026 llama.cpp 极简 - 飞书云文档](https://xnboqt31tz.feishu.cn/wiki/NOxqwfLrMispPokB6HccY2xznOc)


### mlx 上运行 Phi-2






### 问题汇总

1、mlx 包装不上。

pip install mlx

报错：

Could not find a version that satisfies the requirement mlx (from versions: none)

接着搜索仓库 issues 里有人提这个问题，最后被闭口了。

['pip install mlx' does not seem to work correctly · Issue #10 · ml-explore/mlx](https://github.com/ml-explore/mlx/issues/10)

he install docs are updated to include the issues brought up in this thread. I am going to close this for now, but feel free to reopen if there are new issues with installation.

意思是，mlx 的官方文档里，安装说明里有解决方案。接着去了官方文档：

[Build and Install — MLX 0.0.5 documentation](https://ml-explore.github.io/mlx/build/html/install.html)

Troubleshooting

My OS and Python versions are in the required range but pip still does not find a matching distribution.

Probably you are using a non-native Python. The output of

python -c "import platform; print(platform.processor())"

should be arm. If it is i386 (and you have M series machine) then you are using a non-native Python. Switch your Python to a native Python. A good way to do this is with Conda.

运行了上面的命令，返回的果然是 i386。给的方法是要重新装个 native Python 的环境。给了一个链接：

[anaconda - How to specify the architecture or platform for a new conda environment? (Apple Silicon) - Stack Overflow --- anaconda - 如何为新的 conda 环境指定架构或平台？ （苹果芯片） - 堆栈内存溢出](https://stackoverflow.com/questions/65415996/how-to-specify-the-architecture-or-platform-for-a-new-conda-environment-apple)

里面的问题闭口信息：

CONDA_SUBDIR=osx-arm64 conda create -n native numpy -c conda-forge will get you a osx-arm64 native env.

CONDA_SUBDIR=osx-arm64 conda create -n native numpy -c conda-forge 将为您提供一个 osx-arm64 本机环境。

运行 CONDA_SUBDIR=osx-arm64 conda create -n native numpy -c conda-forge 确实可以装一个名为 native 的虚拟环境，说明走的通。

先把原来的 mlx 环境删了：

conda env remove --name mlx

然后依葫芦画瓢：

CONDA_SUBDIR=osx-arm64 conda create --name mlx python=3.10

为什么去掉 conda-forge，期间问了 GPT，-c conda-forge 的意义，得到的回复：

在 Conda 命令中，参数 - c 后面跟的是一个 channel 的名称。Conda channels 是存放 conda 包的服务器位置，你可以把它们理解为软件仓库。使用 - c 参数可以指定在创建环境或安装包时，conda 应该从哪个 channel 下载包。

conda-forge 是一个由社区维护的 Conda channel，它提供了大量的 conda 包。这个 channel 是由社区驱动，通常包含了最新版本的包和那些在默认的 Anaconda 仓库中不可用的包。

因此，-c conda-forge 的意思是在创建新的 conda 环境时，从 conda-forge 这个 channel 中获取 numpy 包以及任何其他的依赖包。这通常是为了确保你能够安装到最新版本的包，或者安装到 Anaconda 默认 channel 中没有的包。


