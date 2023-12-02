### 跑 LLm 环境配置标准动作

1、新建一个干净的虚拟环境。

conda create --name llm

conda create --name llm python=3.10

conda create --name modelscope python=3.10

2、为 M3 的 Mac 单独安装 PyTorch。

pip install --pre torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/nightly/cpu

### 量化方案

[li-plus/chatglm.cpp: C++ implementation of ChatGLM-6B & ChatGLM2-6B & ChatGLM3 & more LLMs](https://github.com/li-plus/chatglm.cpp)

2023-12-02

1、clone 仓库。

git clone --recursive https://github.com/li-plus/chatglm.cpp.git && cd chatglm.cpp

新建一个自己的分支，看操作后的变化：

origin/hotfix/dalong

2、安装三方包。

python -m pip install torch tabulate tqdm transformers accelerate sentencepiece

核查了 torch、tqdm、transformers、accelerate、sentencepiece，之前环境都有了，那么只需：

pip install tabulate

3、量化。

python chatglm_cpp/convert.py -i /Users/Daglas/dalong.chatglm/chatglm3-6b -t q4_0 -o chatglm-ggml.bin

The original model (-i <model_name_or_path>) can be a Hugging Face model name or a local path to your pre-downloaded model. Currently supported models are:

ChatGLM-6B: THUDM/chatglm-6b, THUDM/chatglm-6b-int8, THUDM/chatglm-6b-int4
ChatGLM2-6B: THUDM/chatglm2-6b, THUDM/chatglm2-6b-int4
ChatGLM3-6B: THUDM/chatglm3-6b
CodeGeeX2: THUDM/codegeex2-6b, THUDM/codegeex2-6b-int4
Baichuan & Baichuan2: baichuan-inc/Baichuan-13B-Chat, baichuan-inc/Baichuan2-7B-Chat, baichuan-inc/Baichuan2-13B-Chat
You are free to try any of the below quantization types by specifying -t <type>:

q4_0: 4-bit integer quantization with fp16 scales.
q4_1: 4-bit integer quantization with fp16 scales and minimum values.
q5_0: 5-bit integer quantization with fp16 scales.
q5_1: 5-bit integer quantization with fp16 scales and minimum values.
q8_0: 8-bit integer quantization with fp16 scales.
f16: half precision floating point weights without quantization.
f32: single precision floating point weights without quantization.
For LoRA model, add -l <lora_model_name_or_path> flag to merge your LoRA weights into the base model.

4、构建。

cmake -B build
cmake --build build -j --config Release

5、跑模型。

./build/bin/main -m chatglm-ggml.bin -i

补充：量化后跑起来，明显速度快了好多倍。（2023-12-02）

跑下面的帮助可以看到更多的玩法。

./build/bin/main -h

针对 ChatGLM3-6B 的更多玩法，包括 Chat mode、Function call、

### 部署记录

1、为 M3 的 Mac 单独安装 PyTorch。

Mac 部署

对于搭载了 Apple Silicon 或者 AMD GPU 的 Mac，可以使用 MPS 后端来在 GPU 上运行 ChatGLM3-6B。需要参考 Apple 的 官方说明 安装 PyTorch-Nightly（正确的版本号应该是2.x.x.dev2023xxxx，而不是 2.x.x）。

目前在 MacOS 上只支持从本地加载模型。将代码中的模型加载改为从本地加载，并使用 mps 后端：

model = AutoModel.from_pretrained("your local path", trust_remote_code=True).to('mps')
加载半精度的 ChatGLM3-6B 模型需要大概 13GB 内存。内存较小的机器（比如 16GB 内存的 MacBook Pro），在空余内存不足的情况下会使用硬盘上的虚拟内存，导致推理速度严重变慢。

[Accelerated PyTorch training on Mac - Metal - Apple Developer](https://developer.apple.com/metal/pytorch/)

pip install --pre torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/nightly/cpu

2、安装其他 Python 包。

pip install -r requirements.txt

另外，发现漏了一个包：mdtex2html

requirements.txt 文件内容：

protobuf
transformers>=4.30.2
cpm_kernels
`#` torch>=2.0 # need install PyTorch-Nightly
gradio~=3.39
sentencepiece
accelerate
sse-starlette
streamlit>=1.24.0
fastapi>=0.104.1
uvicorn~=0.24.0
loguru~=0.7.2
latex2mathml
mdtex2html

3、下载本地大模型。

[chatglm3-6b · 模型库](https://modelscope.cn/models/ZhipuAI/chatglm3-6b/summary)

在 HuggingFace 上下载：

GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/THUDM/chatglm3-6b
cd chatglm3-6b
wget "https://huggingface.co/THUDM/chatglm3-6b/resolve/main/pytorch_model-00001-of-00007.bin"
wget "https://huggingface.co/THUDM/chatglm3-6b/resolve/main/pytorch_model-00002-of-00007.bin"
...

发现太慢了，改成了从 modelscope 上下载：

[chatglm3-6b · 模型库](https://modelscope.cn/models/ZhipuAI/chatglm3-6b/summary)

git lfs install
git clone https://www.modelscope.cn/ZhipuAI/chatglm3-6b.git

4、实现本地跑模型。

参考放在 basic_demo 下面的 test.py，实现了基本的跑本地模型的功能。

5、综合 web。

pip install -r requirements.txt

ipython kernel install --name chatglm3-demo --user

export MODEL_PATH=/Users/Daglas/dalong.chatglm/chatglm3-6b

补充：上面的命令只是临时性的将 MODEL_PATH 环境变量更改为本地模型路径，shell 关了后就重置了。

永久性的更改：

client.py 中将模型的路径（THUDM/chatglm3-6b）更改为：/Users/Daglas/dalong.datasets/chatglm3-6b

然后跑：

streamlit run main.py





部署时参考的资料：

我现在想要在苹果 M3 芯片的 MacBook 上部署大语言模型{HUDM/chatglm3-6b}，其在  Hugging Face 上的 url 地址为{https://huggingface.co/THUDM/chatglm3-6b}。

请搜索具体的部署操作步骤，越详细越好，请一步一步来

[ChatGLM3-6B 部署指南 - Hacker and Geeker's Way](https://zhaozhiming.github.io/2023/10/31/chatglm3-deploy/#:~:text=,r%20requirements.txt)

[使用 FastChat 部署 LLM - Hacker and Geeker's Way](https://zhaozhiming.github.io/2023/08/22/use-fastchat-deploy-llm/)

在苹果 M3 芯片的 MacBook 上部署 ChatGLM3-6B 模型的步骤如下：

1. **环境安装**：
   - 克隆 ChatGLM3 的代码仓库并安装相关依赖：
     ```
     git clone https://github.com/THUDM/ChatGLM3
     cd ChatGLM3
     pip install -r requirements.txt
     ```
   【39†source】。

2. **模型下载**：
   - 使用 Hugging Face 下载 ChatGLM3-6B 的模型文件：
     ```
     GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/THUDM/chatglm3-6b
     cd chatglm3-6b
     wget "https://huggingface.co/THUDM/chatglm3-6b/resolve/main/pytorch_model-00001-of-00007.bin"
     wget "https://huggingface.co/THUDM/chatglm3-6b/resolve/main/pytorch_model-00002-of-00007.bin"
     ...
     ```
   【40†source】。

3. **设置 Gradio 服务**：
   - 修改 `web_demo.py` 文件中的模型地址为本地地址：
     ```
     -tokenizer = AutoTokenizer.from_pretrained("THUDM/chatglm3-6b", trust_remote_code=True)
     -model = AutoModel.from_pretrained("THUDM/chatglm3-6b", trust_remote_code=True).cuda()
     +tokenizer = AutoTokenizer.from_pretrained("/root/autodl-tmp/chatglm3-6b", trust_remote_code=True)
     +model = AutoModel.from_pretrained("/root/autodl-tmp/chatglm3-6b", trust_remote_code=True).cuda()
     ```
   - 启动 Gradio 服务：
     ```
     python web_demo.py
     ```
   【41†source】【42†source】。

4. **设置 Streamlit 服务**：
   - 修改 `web_demo2.py` 文件中的模型地址为本地地址：
     ```
     -model_path = "THUDM/chatglm3-6b"
     +model_path = "/root/autodl-tmp/chatglm3-6b"
     ```
   - 启动 Streamlit 服务：
     ```
     streamlit run web_demo2.py
     ```
   【43†source】。

5. **启动 API 服务**：
   - 启动 API 服务（默认端口为 7861）并使用 OpenAI 接口调用方式：
     ```
     python openai_api.py
     ```
   - 通过 API 发送请求：
     ```
     curl -X 'POST' \
       'https://localhost:7861/v1/chat/completions' \
       -H 'accept: application/json' \
       -H 'Content-Type: application/json' \
       -d '{
         "model": "gpt-3.5-turbo",
         "messages": [
           {
             "role": "user",
             "content": "你好"
           }
         ]
       }'
     ```
   【44†source】。

以上步骤提供了在苹果 M3 芯片的 MacBook 上部署 ChatGLM3-6B 大语言模型的详细指南。请确保在执行这些步骤之前，您的系统已经安装了所有必要的依赖项和工具。

### 问题汇总

1、跑 chat 页面 web_demo.py 时，输出框里的输出内容总是无法显示出来。

打断点明确了，输出数据是没问题的，就是显示不出来。

目前还是没解决。（2023-12-01）

chmod 755 /var/folders/yg/v6bk_km13z7c5pzfk9pkq7_c0000gn/T


sudo chmod -R 755 /var/folders/yg/v6bk_km13z7c5pzfk9pkq7_c0000gn/T

tempfile.tempdir = "~/.tmp"

tempfile.tempdir = "/var/folders/yg/v6bk_km13z7c5pzfk9pkq7_c0000gn/T"

GPT:

关于ChatGLM3-6B项目中web_demo.py文件无法显示文字内容的问题，以下是一些可能的解决方法：

代码调整：确保你的代码正确设置了Gradio模块和模型。这包括正确地导入AutoModel和AutoTokenizer，以及使用正确的预训练模型路径。确保使用model.eval()设置模型为评估模式，并正确实现预测函数​​。

CPU和内存检查：检查你的系统资源是否足够。运行ChatGLM模型可能需要较高的CPU和内存资源。有些用户报告需要至少32GB的内存，如果CPU计算慢，也可能会影响性能​​​​。

使用量化模型：如果内存不足，考虑使用量化模型，如chatglm-6b-int4。量化模型可能需要更少的内存资源​​。

Gradio模块权限调整：有些用户发现，Gradio模块在使用服务器暂存临时文件时可能会出现权限问题。更改Gradio模块的权限或临时文件存储位置可能有助于解决问题​​。

查看相关问题解决方案：查阅相关GitHub讨论和解决方案，这可能会提供特定于你遇到的问题的解决方法。例如，查看与类似问题相关的GitHub问题链接，如THUDM/VisualGLM-6B#29，可能有助于找到解决方案​​。

总的来说，解决这个问题可能需要对代码进行调整，检查和优化你的系统资源，以及参考类似问题的解决方案。

[运行web\_demo\_hf.py时遇到tmp文件写入被拒的问题 · Issue #29 · THUDM/VisualGLM-6B](https://github.com/THUDM/VisualGLM-6B/issues/29)


### 资源记录

2023-11-30


[安装 Git Large File Storage - GitHub 文档](https://docs.github.com/zh/repositories/working-with-files/managing-large-files/installing-git-large-file-storage)


2023-11-27

智谱的技术文档：

[⁡⁣‍​⁣‍​​​⁣⁤ChatGLM3 技术文档 - 飞书云文档](https://lslfd0slxc.feishu.cn/wiki/WvQbwIJ9tiPAxGk8ywDck6yfnof)



2023-11-26

最源头的信息：

[THUDM (Knowledge Engineering Group (KEG) & Data Mining at Tsinghua University)](https://huggingface.co/THUDM)

[THUDM/chatglm3-6b · Hugging Face](https://huggingface.co/THUDM/chatglm3-6b)

然后转到 GitHub：

[THUDM/ChatGLM3: ChatGLM3 series: Open Bilingual Chat LLMs | 开源双语对话语言模型](https://github.com/THUDM/ChatGLM3)

GitHub 提及的配套工具：

[li-plus/chatglm.cpp: C++ implementation of ChatGLM-6B & ChatGLM2-6B & ChatGLM3 & more LLMs](https://github.com/li-plus/chatglm.cpp)

哔站上看到智普的专栏，有一篇讲 ChatGLM-6B 的：

[低配置部署 ChatGLM3-6B | 智谱 × 魔搭社区\_哔哩哔哩\_bilibili](https://www.bilibili.com/video/BV11N4y1D7HC/?spm_id_from=333.999.0.0&vd_source=280fc27368a92928cafc2cb72c54a549)

前面一个老师讲在魔塔上部署，获得的信息有限。21min 的时候换了另一个老师讲训练相关的东西。

