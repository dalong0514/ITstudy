### 01. 信息资源

[mlx-examples/phi2 at main · ml-explore/mlx-examples --- mlx-examples/phi2 位于 main · ml-explore/mlx-examples](https://github.com/ml-explore/mlx-examples/tree/main/phi2)

[microsoft/phi-2 · Hugging Face --- microsoft/phi-2 · 拥抱脸](https://huggingface.co/microsoft/phi-2)

### 运行

python phi2.py --prompt "Prove that sqrt(2) is rational number"

python phi2.py --prompt "Prove that sqrt(2) is rational number" --max_tokens 2048

python phi2.py --prompt <your prompt here> --max_tokens 2048


### 部署记录

1、转化模型。

python convert.py

This will make the weights.npz file which MLX can read.

convert.py 里将模型的路径，以及生成的 npz 文件路径都改了。

```py
def convert():
    model = AutoModelForCausalLM.from_pretrained(
        "/Users/Daglas/dalong.datasets/phi-2", torch_dtype="auto", trust_remote_code=True
    )
    state_dict = model.state_dict()
    weights = {replace_key(k): v.numpy() for k, v in state_dict.items()}
    np.savez("/Users/Daglas/dalong.datasets/phi-2_weights.npz", **weights)
```

2、跑模型。

python phi2.py

phi2.py 修改的内容，主要是模型的路径：

```py
def load_model():
    model = Phi2(ModelArgs())
    weights = mx.load("/Users/Daglas/dalong.datasets/phi-2_weights.npz")
    model.update(tree_unflatten(list(weights.items())))
    tokenizer = AutoTokenizer.from_pretrained("/Users/Daglas/dalong.datasets/phi-2", trust_remote_code=True)
    return model, tokenizer
```

还有默认的最大 token 数，从默认的 100 改成了 2048，最大是支持 2048 的。


### 下载模型

[phi-2 · 模型库](https://www.modelscope.cn/models/mengzhao/phi-2/summary)

[microsoft/phi-2 · Hugging Face --- microsoft/phi-2 · 拥抱脸](https://huggingface.co/microsoft/phi-2)

Model  模型
Architecture: a Transformer-based model with next-word prediction objective
架构：具有下一个单词预测目标的基于 Transformer 的模型

Context length: 2048 tokens
上下文长度：2048 个标记

Dataset size: 250B tokens, combination of NLP synthetic data created by AOAI GPT-3.5 and filtered web data from Falcon RefinedWeb and SlimPajama, which was assessed by AOAI GPT-4.
数据集大小：250B token，结合了 AOAI GPT-3.5 创建的 NLP 合成数据以及来自 Falcon RefinedWeb 和 SlimPajama 的过滤网络数据，并由 AOAI GPT-4 评估。

Training tokens: 1.4T tokens
训练代币：1.4T代币

GPUs: 96xA100-80G GPU：96xA100-80G

Training time: 14 days
培训时间：14天