### 资源

[chatchat-space/Langchain-Chatchat: Langchain-Chatchat（原Langchain-ChatGLM）基于 Langchain 与 ChatGLM 等语言模型的本地知识库问答 | Langchain-Chatchat (formerly langchain-ChatGLM), local knowledge based LLM (like ChatGLM) QA app with langchain](https://github.com/chatchat-space/Langchain-Chatchat)

[开发环境部署 · chatchat-space/Langchain-Chatchat Wiki](https://github.com/chatchat-space/Langchain-Chatchat/wiki/%E5%BC%80%E5%8F%91%E7%8E%AF%E5%A2%83%E9%83%A8%E7%BD%B2#%E5%B8%B8%E8%A7%84%E6%A8%A1%E5%BC%8F%E6%9C%AC%E5%9C%B0%E9%83%A8%E7%BD%B2%E6%96%B9%E6%A1%88)

### 部署记录

1、安装依赖包。

pip install -r requirements.txt

过程记录：

unstructured[all-docs]==0.11.0 

xformers>=0.0.22.post7

安装不上，报错，上面 2 个包没装。

gradio 和 pydantic 冲突，卸载了 gradio。gradio 印象上开智 AI 装的包，用于 web 应用的，印象中当时安装的时候就有问题。

哎，安装完之后，发现会破坏原来的 llm 虚拟环境，只能新建一个虚拟环境部署了。

新建虚拟环境后，只需注释掉：

\# xformers>=0.0.22.post7
\# torch==2.1.0  ##on Windows system, install the cuda version manually from https://pytorch.org/
\# torchvision  #on Windows system, install the cuda version manually from https://pytorch.org/
\# torchaudio  #on Windows system, install the cuda version manually from https://pytorch.org/

xformers 是因为安装不上，后面三个 torch 因为自己装了 mac 专用版，不能装普通版的。

2、初始化知识库。

目前卡在了这一步。（2023-12-12）



当前项目的知识库信息存储在数据库中，在正式运行项目之前请先初始化数据库（我们强烈建议您在执行操作前备份您的知识文件）。

如果您已经有创建过知识库，可以先执行以下命令创建或更新数据库表：

python init_database.py --create-tables

如果可以正常运行，则无需再重建知识库。

如果您是第一次运行本项目，知识库尚未建立，或者之前使用的是低于最新master分支版本的框架，或者配置文件中的知识库类型、嵌入模型发生变化，或者之前的向量库没有开启 normalize_L2，需要以下命令初始化或重建知识库：

python init_database.py --recreate-vs

3、修改配置文件。

model_config.py 里的修改汇总：

第一处修改：模型文件的根目录。

MODEL_ROOT_PATH = "/Users/Daglas/dalong.datasets/"

第二处修改：向量化的模型更改为自己常用的 m3e-base。

EMBEDDING_MODEL = "m3e-base"

第三处修改：模型列表枚举里增加同义千问。

LLM_MODELS = ["chatglm3-6b", "zhipu-api", "openai-api", "qwen-api"] # "Qwen-1_8B-Chat",

第四处修改：更改千问的接口 API。

    # 阿里云通义千问 API，文档参考 https://help.aliyun.com/zh/dashscope/developer-reference/api-details
    "qwen-api": {
        "version": "qwen-turbo",  # 可选包括 "qwen-turbo", "qwen-plus"
        "api_base_url": "http://192.168.28.43:8000/v1",
        # "api_key": "",  # 请在阿里云控制台模型服务灵积API-KEY管理页面创建
        "provider": "QwenWorker",
    },


接着去 server_config.py 改 API 的端口。

    "qwen-api": {
        "port": 8000,
    },


server_config.py 里的修改汇总：

1、上面提及的改千问 API 的端口。



3、运行。

全部跑：

python startup.py -a

轻量化仅仅跑前端，本地不跑大模型，大模型通过调接口。

python startup.py -a --lite

### 问题汇总

1、安装仓库里得包导致原来的虚拟环境 llm 破坏。

解决方案：新建一个虚拟环境 langchain-chat。

1、运行时报错。

2023-12-12 12:06:18 | ERROR | stderr | AssertionError: Torch not compiled with CUDA enabled

知道原因，明细是因为调用了显卡跑，得改成调 mac 的 cpu 跑，找了半天没找到。

无意中找到在 server_config.py 里改。

原代码：

    "chatglm3-6b": {  # 使用default中的IP和端口
        "device": "cuda",
    },


更改为：

    "chatglm3-6b": {  # 使用default中的IP和端口
        "device": "cpu",
    },


2、在 0.0.0.0 里跑不起来。

http://0.0.0.0:8501/

更改为 local 即可：

local:8501/

### 细节汇总

1、量化模型加载设置。

信息源自：ChatChat 交流群。

startup.py 中，原代码（177 行）

args.load_8bit = False

量化模型的加在，可以更改为 ture。



