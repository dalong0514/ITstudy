## Qwen-Chat

### 下载

[YeungNLP/firefly-mixtral-8x7b at main](https://huggingface.co/YeungNLP/firefly-mixtral-8x7b/tree/main)

huggingface-cli download --resume-download --local-dir-use-symlinks False YeungNLP/firefly-mixtral-8x7b --local-dir firefly-mixtral-8x7b

注意事项：每次下载之前都需要设置下环境变量：

export HF_ENDPOINT=https://hf-mirror.com

应该也可以设置为全部变量，现在就按这种模式，先别设全部环境变量。

[Qwen/Qwen1.5-72B-Chat-GGUF at main](https://huggingface.co/Qwen/Qwen1.5-72B-Chat-GGUF/tree/main)

下载单个文件：

huggingface-cli download Qwen/Qwen1.5-72B-Chat-GGUF qwen1_5-72b-chat-q5_k_m.gguf.a --local-dir . --local-dir-use-symlinks False

huggingface-cli download Qwen/Qwen1.5-72B-Chat-GGUF qwen1_5-72b-chat-q5_k_m.gguf.b --local-dir . --local-dir-use-symlinks False

huggingface-cli download Qwen/Qwen1.5-72B-Chat-GGUF qwen1_5-72b-chat-q8_0.gguf.a --local-dir . --local-dir-use-symlinks False

huggingface-cli download Qwen/Qwen1.5-72B-Chat-GGUF qwen1_5-72b-chat-q8_0.gguf.c --local-dir . --local-dir-use-symlinks False



下载整个文件夹：

huggingface-cli download --resume-download --local-dir-use-symlinks False Qwen/Qwen1.5-72B-Chat-GGUF --local-dir Qwen1.5-72B-Chat

合并文件：

cat qwen1_5-72b-chat-q5_k_m.gguf.* > qwen1_5-72b-chat-q5_k_m.gguf


cat qwen1_5-72b-chat-q8_0.gguf.* > qwen1_5-72b-chat-q8_0.gguf


### api 调用

curl -X POST "http://127.0.0.1:8000/v1/chat/completions" \
-H "Content-Type: application/json" \
-d "{\"model\": \"Qwen-14B-Chat\", \"messages\": [{\"role\": \"system\", \"content\": \"You are Qwen-14B-Chat, a large language model trained by ali. Follow the user's instructions carefully. Respond using markdown.\"}, {\"role\": \"user\", \"content\": \"你好，给我讲一个故事，大概100字\"}], \"stream\": false, \"max_tokens\": 100, \"temperature\": 0.8, \"top_p\": 0.8}"


curl -X POST "http://192.168.28.58:8000/v1/chat/completions" \
-H "Content-Type: application/json" \
-d "{\"model\": \"Qwen-14B-Chat\", \"messages\": [{\"role\": \"system\", \"content\": \"You are Qwen-14B-Chat, a large language model trained by ali. Follow the user's instructions carefully. Respond using markdown.\"}, {\"role\": \"user\", \"content\": \"你好，给我讲一个故事，大概100字\"}], \"stream\": false, \"max_tokens\": 100, \"temperature\": 0.8, \"top_p\": 0.8}"




### 问题汇总

2023-12-05

1、跑不起来。




TypeError: BFloat16 is not supported on MPS

开始一直找不到原因。

问了 GPT：

用mac 的 m 芯片跑大语言模型（LLM）的量化模型，比如Int4量化模型，需要做哪些额外处理。比如部署运行大语言模型Qwen-Chat (Int4)。请搜索相关信息

它给了一篇文章：

[挖掘 M2 Pro 32G UMA 内存潜力：在 Mac 上本地运行清华大模型 ChatGLM2-6B - 掘金](https://juejin.cn/post/7250730877372792887)

里面提到：模型加载使用 to('mps') 方式

tokenizer = AutoTokenizer.from_pretrained("修改为第 2 步中存放 Huggingface 模型的路径", trust_remote_code=True)
model = AutoModel.from_pretrained("修改为第 2 步中存放 Huggingface 模型的路径", trust_remote_code=True).to('mps')
model = model.eval()

然后就改了下 cli_demo.py 的代码：

    model = AutoModelForCausalLM.from_pretrained(
        args.checkpoint_path,
        device_map="cpu",
        trust_remote_code=True,
        resume_download=True,
    ).to('mps').eval()

发现可以跑了。

接着去改 openai_api.py 里的代码，发现报错。试着把 .to('mps') 去掉，发现竟然可以跑。

所以定位的根子原因：直接用 "cpu"，不要用原代码里的 "auto"。


### 量化模型

[QwenLM/qwen.cpp: C++ implementation of Qwen-LM](https://github.com/QwenLM/qwen.cpp)

2023-12-04

1、clone 仓库。

git clone --recursive https://github.com/QwenLM/qwen.cpp && cd qwen.cpp

新建一个自己的分支，看操作后的变化：

origin/hotfix/dalong

2、安装三方包。

python -m pip install torch tabulate tqdm transformers accelerate sentencepiece

核查了 torch、tqdm、transformers、accelerate、sentencepiece，之前环境都有了，那么只需：

pip install tabulate

3、量化。

python qwen_cpp/convert.py -i /Users/Daglas/dalong.datasets/Qwen-14B-Chat -t q4_0 -o qwen14b-ggml.bin

成功后的提示：

GGML model saved to qwen14b-ggml.bin

4、构建。

cmake -B build
cmake --build build -j --config Release

5、跑模型。

./build/bin/main -m qwen14b-ggml.bin --tiktoken /Users/Daglas/dalong.datasets/Qwen-14B-Chat/qwen.tiktoken -i

补充：量化后跑起来，明显速度快了好多倍。（2023-12-02）

跑下面的帮助可以看到更多的玩法。

./build/bin/main -h

针对 ChatGLM3-6B 的更多玩法，包括 Chat mode、Function call 等。

### 官方示例跑量化模型

2023-12-05

尝试用官方的 cli_demo.py 跑量化模型，失败了。目前还没解决。

改动的地方：

from transformers import AutoModelForCausalLM, AutoTokenizer, TextGenerationPipeline
from auto_gptq import AutoGPTQForCausalLM, BaseQuantizeConfig

    tokenizer = AutoTokenizer.from_pretrained(
        args.checkpoint_path, trust_remote_code=True, resume_download=True,
    )
    # tokenizer = AutoTokenizer.from_pretrained(DEFAULT_CKPT_PATH, use_fast=True)
    config = BaseQuantizeConfig(
        bits=4,  # 将模型量化为 4-bit 数值类型
        group_size=128,  # 一般推荐将此参数的值设置为 128
        desc_act=False,  # 设为 False 可以显著提升推理速度，但是 ppl 可能会轻微地变差
    )
    model = AutoGPTQForCausalLM.from_pretrained(args.checkpoint_path, config, trust_remote_code=True).eval()




