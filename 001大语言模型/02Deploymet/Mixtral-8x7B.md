### 01. llama.cpp 部署

#### 跑服务

跑 API：

./server -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf -c 4096 --host 0.0.0.0



make -j && ./server -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf -c 4096 --host 0.0.0.0



跑 CLI：

./main -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf -n 4096 --color -i -cml -f prompts/chat-with-qwen.txt

./main -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf -n 4096 --color -i -cml


提示词举例：

Prove that sqrt(2) is rational number



#### 下载模型文件

2023-12-04

下载模型文件。

注意事项：下载模型的时候把代理推出来。

[Mixtral-8x7B-Instruct-v0.1 · 模型库](https://www.modelscope.cn/models/AI-ModelScope/Mixtral-8x7B-Instruct-v0.1/files)

[mistralai/Mixtral-8x7B-Instruct-v0.1 at main](https://huggingface.co/mistralai/Mixtral-8x7B-Instruct-v0.1/tree/main)

[YeungNLP/firefly-mixtral-8x7b at main](https://huggingface.co/YeungNLP/firefly-mixtral-8x7b/tree/main)

[TheBloke/dolphin-2.6-mixtral-8x7b-GGUF at main](https://huggingface.co/TheBloke/dolphin-2.6-mixtral-8x7b-GGUF/tree/main)

中文训练版：

[HIT-SCIR/Chinese-Mixtral-8x7B: 中文Mixtral-8x7B（Chinese-Mixtral-8x7B）](https://github.com/HIT-SCIR/Chinese-Mixtral-8x7B?tab=readme-ov-file)

[HIT-SCIR/Chinese-Mixtral-8x7B at main](https://huggingface.co/HIT-SCIR/Chinese-Mixtral-8x7B/tree/main)




####  部署过程

2024-01-24

python convert.py /Users/Daglas/dalong.datasets/chinese-mixtral-8x7b \
         --outfile /Users/Daglas/dalong.datasets/chinese-mixtral-8x7b.gguf \
         --outtype f16
 
\# quantize to Q5_k_m
./quantize /Users/Daglas/dalong.datasets/chinese-mixtral-8x7b.gguf \
           /Users/Daglas/dalong.datasets/chinese-mixtral-8x7b-q5_k_m.gguf \
           q5_k_m	 


python convert-hf-to-gguf.py /Users/Daglas/dalong.datasets/chinese-mixtral-8x7b \
         --outfile /Users/Daglas/dalong.datasets/chinese-mixtral-8x7b.gguf \
         --outtype f16






1、先 buid 项目。

直接在仓库文件根目录下面运行：

make

2、转为 gguf 文件。

\# convert to F16 GGUF
python convert.py /Users/Daglas/dalong.datasets/mixtral-8x7b-32kseqlen \
         --outfile /Users/Daglas/dalong.datasets/mixtral-8x7b-32kseqlen.gguf \
         --outtype f16


/Users/Daglas/dalong.datasets/mixtral-8x7b-32kseqlen


python convert.py /Users/Daglas/dalong.datasets/Mixtral-8x7B-Instruct-v0.1 \
         --outfile /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b.gguf \
         --outtype f16



python convert.py /Users/Daglas/dalong.datasets/Mistral-7B-Instruct-v0.2 \
         --outfile /Users/Daglas/dalong.datasets/mixtral-7b-instruct-v0.2.gguf \
         --outtype f16

3、量化。

\# quantize to Q4_0
./quantize /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b.gguf \
           /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf \
           q4_0

\# quantize to Q5_k_m
./quantize /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b.gguf \
           /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q5_k_m.gguf \
           q5_k_m


4、运行。

./main -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf -n 4096 --color -i -cml -f prompts/chat-with-qwen.txt

./main -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf -n 4096 --color -i -cml

./main \
  -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf \
  --repeat_penalty 1 \
  --no-penalize-nl \
  --color --temp 0 -c 4096 -n -1 


./main \
  -m /Users/Daglas/dalong.datasets/mixtral-instruct-8x7b-q4_0.gguf \
  -p "[INST] Prove that sqrt(2) is rational number. [/INST]" \
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


### 02. mlx 部署

[mlx-examples/mixtral at main · ml-explore/mlx-examples](https://github.com/ml-explore/mlx-examples/tree/main/mixtral)





#### 跑服务




#### 下载模型文件

2023-12-14

目前 modelscope 上没有权重模型文件的下载资源，只能在 huggingface 上下载，花费的是代理的流量。

[someone13574/mixtral-8x7b-32kseqlen at main](https://huggingface.co/someone13574/mixtral-8x7b-32kseqlen/tree/main)

已经帮忙转好的文件下载：

[mlx-community/Mixtral-8x7B-Instruct-v0.1 at main](https://huggingface.co/mlx-community/Mixtral-8x7B-Instruct-v0.1/tree/main)

####  部署过程

1、安装依赖包。

mlx
sentencepiece
torch
numpy

只有 sentencepiece 没装，补装一下。

2、合并模型文件。

cd mixtral-8x7b-32kseqlen/

cat consolidated.00.pth-split0 consolidated.00.pth-split1 consolidated.00.pth-split2 consolidated.00.pth-split3 consolidated.00.pth-split4 consolidated.00.pth-split5 consolidated.00.pth-split6 consolidated.00.pth-split7 consolidated.00.pth-split8 consolidated.00.pth-split9 consolidated.00.pth-split10 > consolidated.00.pth


python convert.py --model_path /Users/Daglas/dalong.datasets/mixtral-8x7b-32kseqlen/

