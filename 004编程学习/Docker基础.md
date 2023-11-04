## 0101. 基础

### 资源

[Docker Hub](https://hub.docker.com/)

[Overview of Docker Desktop | Docker Docs](https://docs.docker.com/desktop/)

### 操作记录

你是一名计算机科学家、资深编程开发人员，并且精通 docker 相关的操作。我想让你担任指导老师，指导我在软件开发过程中遇到的一系列问题。我的第一个问题是

Q1：

在 mac 中如何进入 docker 环境，并查看docker 环境中是否安装有 Python

GPT：

如果您想进入一个特定的 Docker 容器，您可以使用 docker exec 命令。例如：

docker exec -it [容器ID或名称] /bin/bash

这里，-it 标志允许您以交互模式进入容器，/bin/bash 会启动 bash shell。

如果您还没有任何 Docker 容器，但想快速检查一个带有 Python 的 Docker 环境，您可以使用一个预构建的 Python Docker 镜像。例如：

docker run -it python:3.8 /bin/bash

补充：跑完之后，就会给我新建一个名称是 keen_tharp 的容器（docker desktop 界面里可以看到）。命令 exit 可以直接退出容器，而且把容器关闭了。后续直接用：docker exec -it keen_tharp /bin/bash 是跑不起来的，比如要现在 docker desktop 把容器启动起来，才能在 iterm 用上面的命令跑。

Q1：

进入 docker 环境后，如何安装镜像{registry.cn-hangzhou.aliyuncs.com/modelscope-repo/modelscope:ubuntu20.04-py38-torch1.11.0-tf1.15.5-1.8.0}

补充：主要是为了安装 ModelScope 镜像。

GPT：

docker pull registry.cn-hangzhou.aliyuncs.com/modelscope-repo/modelscope:ubuntu20.04-py38-torch1.11.0-tf1.15.5-1.8.0

补充：拉完之后，安装官网里的操作。可以做个安装验证：安装成功后，即可使用对应领域模型进行推理，训练等操作。这里我们以 NLP 领域为例。安装后，可执行如下命令，运行中文分词任务，来验证安装是否正确：

python -c "from modelscope.pipelines import pipeline;print(pipeline('word-segmentation')('今天天气不错，适合 出去游玩'))"

[环境安装 · 文档中心](https://www.modelscope.cn/docs/%E7%8E%AF%E5%A2%83%E5%AE%89%E8%A3%85)

Q1：

在 mac 中如何查看 docker 目前有多少个镜像

GPT：

docker images



### 问题

1、镜像（image）和容器（container）的概念。

docker exec -it priceless_hellman /bin/bash

场景：重新进 ModelScope 镜像，发现之前里面的 GitHub 项目仓库没了。开始以为每次进镜像都会被初始化，后面发现我用 docker run 命令进镜像，其实帮我新建了一个容器，我进的是一个新容器。

docker run -it registry.cn-hangzhou.aliyuncs.com/modelscope-repo/modelscope:ubuntu20.04-py38-torch1.11.0-tf1.15.5-1.8.0 /bin/bash

上面命令，那个名字是镜像名，它就以该镜像为基础又给我新建了一个容器。其实我是想进原来的容器。此时发现自己对镜像和容器的概念不清楚。问了 GPT，获得的信息如下。


GPT 的问答：

docker exec 命令用于在已经运行的容器内执行命令，而不是用于运行一个新的容器。这个命令通常用于进入一个已经运行的容器或在其中运行某个特定命令。

下面是一个典型的例子：

1、首先，使用 docker run 启动一个新的容器（或找到一个已经在运行的容器）：

docker run -d --name my_container ubuntu sleep infinity

这里，-d 参数让容器在后台运行，--name my_container 为容器命名为 my_container，sleep infinity 使容器持续运行。

2、然后，使用 docker exec 进入该容器：

docker exec -it my_container /bin/bash

这里，-it 参数允许你以交互模式进入容器，my_container 是你想要进入的容器的名称或 ID，/bin/bash 启动了一个 bash shell。

这样，你就可以在已经运行的 my_container 容器内执行 bash 命令了。如果你想要退出，可以在容器内的 bash shell 中输入 exit。





