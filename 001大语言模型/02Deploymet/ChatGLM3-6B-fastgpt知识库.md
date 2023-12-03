### 部署记录

1、下载 m3e 模型文件。

[M3E Models · 模型库](https://www.modelscope.cn/models/xrunda/m3e-base/files)

[moka-ai/m3e-base at main](https://huggingface.co/moka-ai/m3e-base/tree/main)

git lfs install
git clone https://huggingface.co/moka-ai/m3e-base

huggingface 上太慢了，下载不下来。还是在 modelscope 上下载的。

git lfs install
git clone https://www.modelscope.cn/xrunda/m3e-base.git

2、下载 FastGPT 仓库。（参考代码用）

git clone https://github.com/labring/FastGPT.git

3、修改 openai_api_demo。

几个注意点：

1）更改本地模型数据 chatglm3-6b 和 m3e-base 的路径。

2）期间有 3 个包要新安装：

import tiktoken
from sentence_transformers import SentenceTransformer
from sklearn.preprocessing import PolynomialFeatures

pip install tiktoken sentence_transformers scikit-learn

4、部署 FastGPT。

把文件

docker compose up -d

http://localhost:3000/

root

1234



curl --location --request POST 'http://127.0.0.1:8000/v1/embeddings' \
--header 'Authorization: Bearer sk-aaabbbcccdddeeefffggghhhiiijjjkkk' \
--header 'Content-Type: application/json' \
--data-raw '{
  "model": "m3e",
  "input": ["laf是什么"]
}'

curl -X POST "http://127.0.0.1:8000/v1/chat/completions" \
-H "Content-Type: application/json" \
-d "{\"model\": \"chatglm3-6b\", \"messages\": [{\"role\": \"system\", \"content\": \"You are ChatGLM3, a large language model trained by Zhipu.AI. Follow the user's instructions carefully. Respond using markdown.\"}, {\"role\": \"user\", \"content\": \"你好，给我讲一个故事，大概100字\"}], \"stream\": false, \"max_tokens\": 100, \"temperature\": 0.8, \"top_p\": 0.8}"



docker compose up -d




192.168.31.208

公司：
  
192.168.28.58



1、IP 地址的卡点。

ifconfig

取 en0 里的 inet 192.168.28.58 