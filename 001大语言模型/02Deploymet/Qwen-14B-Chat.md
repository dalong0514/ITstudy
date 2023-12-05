2023-12-04

下载模型文件。

注意事项：下载模型的时候把代理推出来。

[通义千问-14B-Chat · 模型库](https://modelscope.cn/models/qwen/Qwen-14B-Chat/files)

git lfs install
git clone https://www.modelscope.cn/qwen/Qwen-14B-Chat.git



git remote add upstream https://github.com/QwenLM/Qwen.git


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