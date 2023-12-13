### 跑服务

跑 API：

make -j && ./server -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf -c 4096 --host 0.0.0.0

./server -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf -c 4096 --host 0.0.0.0

跑 CLI：

./main -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf -n 4096 --color -i -cml -f prompts/chat-with-qwen.txt

./main -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf -n 4096 --color -i -cml

### 下载模型文件

2023-12-04

下载模型文件。

注意事项：下载模型的时候把代理推出来。

[Mixtral-8x7B-Instruct-v0.1 · 模型库](https://www.modelscope.cn/models/AI-ModelScope/Mixtral-8x7B-Instruct-v0.1/files)

[mistralai/Mixtral-8x7B-Instruct-v0.1 at main](https://huggingface.co/mistralai/Mixtral-8x7B-Instruct-v0.1/tree/main)

###  量化

1、先 buid 项目。

直接在仓库文件根目录下面运行：

make

2、转为 gguf 文件。

\# convert to F16 GGUF
python convert.py /Users/Daglas/dalong.datasets/Mixtral-8x7B-Instruct-v0.1 \
         --outfile /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b.gguf \
         --outtype f16

3、量化。

\# quantize to Q4_0
./quantize /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b.gguf \
           /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf \
           q4_0

4、运行。

./main -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf -n 4096 --color -i -cml -f prompts/chat-with-qwen.txt

./main -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf -n 4096 --color -i -cml

./main \
  -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf \
  --repeat_penalty 1 \
  --no-penalize-nl \
  --color --temp 0 -c 4096 -n -1 

Few notes:

make sure to have enough context (-c 4096, can be even more, but note that default is only 512)
disable the repeat penalty (--repeat_penalty 1), without this you can see typos, misspellings and early EOS
disable the newline penalty (--no-penalize-nl), this might be important for code generation
use -p "[INST] some instruction [/INST]", this should match the prompt template specified in the official repo

信息源：

[llama : add Mixtral support by slaren · Pull Request #4406 · ggerganov/llama.cpp](https://github.com/ggerganov/llama.cpp/pull/4406)