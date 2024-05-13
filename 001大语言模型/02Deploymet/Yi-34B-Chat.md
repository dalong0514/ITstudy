### 跑服务

跑 API：

./server -m /Users/Daglas/dalong.datasets/yi-34b-chat-q5_k_m.gguf -c 4096 --host 0.0.0.0


./server -m /Users/Daglas/dalong.datasets/yi-34b-chat.gguf -c 4096 --host 0.0.0.0


2023-12-19

目前完全不能用，总是串词，串英文，全乱的。


### 资源

[Yi-34B-Chat · 模型库](https://www.modelscope.cn/models/01ai/Yi-34B-Chat/files)

[01-ai/Yi-34B-Chat · Hugging Face --- 01-ai/Yi-34B-Chat · Hugging Face](https://huggingface.co/01-ai/Yi-34B-Chat)

[01-ai (01-ai)](https://huggingface.co/01-ai)

### llama.cpp 部署

1、先 buid 项目。

直接在仓库文件根目录下面运行：

make

2、转为 gguf 文件。

\# convert to F16 GGUF
python convert.py /Users/Daglas/dalong.datasets/Yi-34B-Chat \
         --outfile /Users/Daglas/dalong.datasets/yi-34b-chat.gguf \
         --outtype f16

3、量化。

Allowed quantization types:
   2  or  Q4_0   :  3.56G, +0.2166 ppl @ LLaMA-v1-7B
   3  or  Q4_1   :  3.90G, +0.1585 ppl @ LLaMA-v1-7B
   8  or  Q5_0   :  4.33G, +0.0683 ppl @ LLaMA-v1-7B
   9  or  Q5_1   :  4.70G, +0.0349 ppl @ LLaMA-v1-7B
  10  or  Q2_K   :  2.63G, +0.6717 ppl @ LLaMA-v1-7B
  12  or  Q3_K   : alias for Q3_K_M
  11  or  Q3_K_S :  2.75G, +0.5551 ppl @ LLaMA-v1-7B
  12  or  Q3_K_M :  3.07G, +0.2496 ppl @ LLaMA-v1-7B
  13  or  Q3_K_L :  3.35G, +0.1764 ppl @ LLaMA-v1-7B
  15  or  Q4_K   : alias for Q4_K_M
  14  or  Q4_K_S :  3.59G, +0.0992 ppl @ LLaMA-v1-7B
  15  or  Q4_K_M :  3.80G, +0.0532 ppl @ LLaMA-v1-7B
  17  or  Q5_K   : alias for Q5_K_M
  16  or  Q5_K_S :  4.33G, +0.0400 ppl @ LLaMA-v1-7B
  17  or  Q5_K_M :  4.45G, +0.0122 ppl @ LLaMA-v1-7B
  18  or  Q6_K   :  5.15G, -0.0008 ppl @ LLaMA-v1-7B
   7  or  Q8_0   :  6.70G, +0.0004 ppl @ LLaMA-v1-7B
   1  or  F16    : 13.00G              @ 7B
   0  or  F32    : 26.00G              @ 7B
          COPY   : only copy tensors, no quantizing


\# quantize to Q4_0
./quantize /Users/Daglas/dalong.datasets/yi-34b-chat.gguf \
           /Users/Daglas/dalong.datasets/yi-34b-chat-q4_0.gguf \
           q4_0

\# quantize to Q5_k_m
./quantize /Users/Daglas/dalong.datasets/yi-34b-chat.gguf \
           /Users/Daglas/dalong.datasets/yi-34b-chat-q5_k_m.gguf \
           q5_k_m

4、运行。

./main -m /Users/Daglas/dalong.datasets/yi-34b-chat-q5_k_m.gguf -n 4096 --color -i -cml -f prompts/chat-with-qwen.txt

./main -m /Users/Daglas/dalong.datasets/yi-34b-chat-q5_k_m.gguf -n 4096 --color -i -cml


