### 部署记录

1、下载 m3e 模型文件。

[M3E Models · 模型库](https://www.modelscope.cn/models/xrunda/m3e-base/files)

[moka-ai/m3e-base at main](https://huggingface.co/moka-ai/m3e-base/tree/main)

git lfs install
git clone https://huggingface.co/moka-ai/m3e-base

huggingface 上太慢了，下载不下来。还是在 modelscope 上下载的。

git lfs install
git clone https://www.modelscope.cn/xrunda/m3e-base.git

2、下载 FastGPT 仓库。

git clone https://github.com/labring/FastGPT.git

3、修改 openai_api_demo。

几个注意点：

1）更改本地模型数据 chatglm3-6b 和 m3e-base 的路径。

2）期间有 3 个包要新安装：

import tiktoken
from sentence_transformers import SentenceTransformer
from sklearn.preprocessing import PolynomialFeatures

pip install tiktoken sentence_transformers scikit-learn



docker compose up -d

http://localhost:3000/

root

1234

