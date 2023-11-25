## ChatGLM: An Alternative to ChatGPT

Jie Tang

KEG, Tsinghua University

Slides available at: http://keg.cs.tsinghua.edu.cn/jietang/

or Google Jie Tang

[THUDM/GLM-130B: GLM-130B: An Open Bilingual Pre-Trained Model (ICLR 2023)](https://github.com/THUDM/GLM-130B)

[THUDM/ChatGLM3: ChatGLM3 series: Open Bilingual Chat LLMs | 开源双语对话语言模型](https://github.com/THUDM/ChatGLM3)

1『备注：这份资料还是要去看原文 PDF，因为很多信息是以图表、框架图的形式呈现的。（2023-11-25）』

### 01. What is ChatGLM

• ChatGPT and GPT4 has gained enormous popularity – However, techniques behind GPT become a secret to all.

• ChatGLM, an open-source ChatGPT alternative, toward unclosing the secret.

– GLM-130B: an open-source LLM base model

– ChatGLM-6B: a lightweight open-source ChatGPT alternative

– ChatGLM-130B: not open-sourced, but available through API

### 02. ChatGLM-6B: An Open-Source Alternative

• ChatGLM-6B: 6.2Bparameters, INT4 quantization (only need 6G memory)

• >50,000 stars on github

• >10,000,000 downloads on Huggingface

• No. 1 on Github Trending (2 week)

• No. 1 on Huggingface Trending (2 weeks)

>600 Open-Sourced Apps developed based on ChatGLM

### 03. ChatGPT vs. ChatGLM

GPT VS GLM

ChatGPT <=> ChatGLM

DALL.E <=> CogView

Codex <=> CodeGeeX

WebGPT <=> WebGLM

GPT-4V <=> GLM-4V on the way (CogVLM, Agent…)

### 04. chatglm.ai

GLM => XDAI => GLM-130B => CodeGeeX => QAGLM => ChatGLM

### 05. Story generation

### 06. Applied Math

### 07. Coding

### 08. GLM-4V (pre-release)

draw a dog with a hat」

### 09. GPT

1 100B Base model

2 Supervised FT

3 RLHF

### 10. General Language Model (GLM)

### 11. Why 100B-scale model?

• What is 16 mod 12?

• 16 divided by 12 equals 1 remainder 4. So the answer is 4!

1 J Wei, et al. Emergent Abilities of Large Language Models. arXiv: 2206.07682

[[2206.07682] Emergent Abilities of Large Language Models](https://arxiv.org/abs/2206.07682)

GPT-3 (OpenAI)

LaMDA (谷歌)

Scaling Law

Scaling Law introduces complicated reasoning abilities

Emergent abilities

• OpenAI

• GPT-3 175B

• Google

• LaMDA 137B

• PaLM 540B

• Microsoft

• Turing-NLG 530B

• DeepMind

• Gopher 260B

### 12. How to train a 100B–scale LLM?

8 months have witnessed numerous challenges

Engineering: How to train 100B-scale models from scratch?

§ Hygon DCU, NVIDIA A100, Ascend 910, Sunway

§ Frequent & random hardware failures, Megatron-DeepSpeed 3D pipeline, CUDA kernel efficiency, GPU memory overflow, 10K+ threads TCP init & comms…

Algorithm: How to stabilize the training of 100B-scale models?

§ The gradient norms of embeddings, Post-LN / Pre-LN stability, dataloader state seeds, computation precision in Softmax / Attention

[GLM-130B: An Open Bilingual Pre-Trained Model | GLM-130B](http://keg.cs.tsinghua.edu.cn/glm-130b/)

Tradeoff: Stability (Slow) or Efficiency (Instable)

Existing Solutions

§ OPT-175B: manually adjust LR & skip data when collapses (performance drop)

§ BLOOM 176B: embedding norm & BF16（performance drop, few platform）

### 13. GLM-130B: Training Stability

Zeng, Liu, et al. GLM-130B: An Open Bilingual Pre-trained Model. ICLR’23

Embedding Layer Gradient Shrink (EGS)

word_embedding =word_embedding *alpha+word_embedding .detach()*(1ˊ alpha)

Embedding Layer gradients can be magnitudes larger than others

图 2 中的 GLM-130B 时间轴，涵盖了截至目前我们所遇到和解决的大部分问题。

[GLM-130B：开源的双语预训练模型 | GLM-130B](https://keg.cs.tsinghua.edu.cn/glm-130b/zh/posts/glm-130b/)

### 14. Develop ChatGLM based on GLM-130B



