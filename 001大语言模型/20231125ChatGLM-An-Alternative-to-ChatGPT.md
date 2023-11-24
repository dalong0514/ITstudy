## ChatGLM: An Alternative to ChatGPT

Jie Tang

KEG, Tsinghua University

Slides available at: http://keg.cs.tsinghua.edu.cn/jietang/

or Google Jie Tang

[THUDM/GLM-130B: GLM-130B: An Open Bilingual Pre-Trained Model (ICLR 2023)](https://github.com/THUDM/GLM-130B)

[THUDM/ChatGLM3: ChatGLM3 series: Open Bilingual Chat LLMs | 开源双语对话语言模型](https://github.com/THUDM/ChatGLM3)

### 01. What is ChatGLM

• ChatGPT and GPT4 has gained enormous popularity – However, techniques behind GPT become a secret to all.

• ChatGLM, an open-source ChatGPT alternative, toward unclosing the secret.

– GLM-130B: an open-source LLM base model

– ChatGLM-6B: a lightweight open-source ChatGPT alternative

– ChatGLM-130B: not open-sourced, but available through API

### 02. ChatGLM-6B: An Open-Source Alternative

• ChatGLM-6B: 6.2Bparameters, INT4 
quantization (only need 6G memory)
• >50,000 stars on github
• >10,000,000 downloads on Huggingface
• No. 1 on Github Trending (2 week)
• No. 1 on Huggingface Trending (2 weeks)

>600 Open-Sourced 
Apps developed based 
on ChatGLM

https://github.com/THUDM/GLM-130B

https://github.com/THUDM/ChatGLM3

3

ChatGPT vs. ChatGLM

GPT

VS

t

GLM

ChatGPT

DALL.E

Codex

WebGPT

GPT-4V

ChatGLM

CogView

CodeGeeX

WebGLM

GLM-4V on the way
(CogVLM, Agent…)

4

chatglm.ai

GLM

XDAI

GLM-130B

CodeGeeX

QAGLM

ChatGLM

Welcome to try

5

Story generation

6

Applied Math

7

Coding

8

GLM-4V (pre-release)

9

「draw a dog with a hat」

10

大模型驱动的知识推理

GPT-1

GPT-2

1B

GPT-3
davinci
100B

GPT-3 +
RLHF

2018

6

2019

2

2020

5

Codex

GitHub
Copilot

2021

7

GPT

code-davinci-002

代码数据预训练
text-davinci-002
InstructGPT
Supervised FT
text-davinci-003

(RLHF)

RLHF

GPT-3.5

ChatGPT
（RLHF)

New Bing
(GPT-4)

GPT-4

WebGPT (RLHF)

2021
12

2022
11

2023

2

2023

3

3.14

1. 100B Base model

2. Supervised FT

3. RLHF

读书

受教育

社会接轨

OpenAI's GPT

GPT-1

GPT-2
十亿模型

GPT-3
davinci
100B

GPT-3 +
RLHF

code-davinci-002

text-davinci-002
InstructGPT
Supervised FT
text-davinci-003

(RLHF)

WebGPT (RLHF)

Codex

GitHub
Copilot

RLHF

GPT-3.5

ChatGPT
（RLHF)

New Bing
(GPT-4)

GPT-4

2018

6

2019

2

2020

5

2020
11

2021

5

2021

7

2021
12

2022

8

2022
11

2023

2

2023

3

3.14

GLM-
10B
ACL'22

mGLM

Multi-lingual

ICLR'23
KDD'23

GLM-130B

100B

CodeGeeX

QAGLM

WebGLM
KDD'23

THU&Zhipu AI's GLM

VS Code/JetBrains
CodeGeeX Plugin

读书

受教育

社会接轨

ChatGLM

（SFT + RLHF）
ChatGLM-6B
(SFT + RLHF）

NeurIPS'21
NeurIPS'22

ICLR'23

VisualGLM
CogVLM

General Language Model (GLM)

Framework

NLU

Cond. Gen.

Uncond. Gen.

Autoregressive (GPT)

Autoencoding (BERT)

Encoder-Decoder (T5)

Autoregressive Blank-Infilling

(GLM)

—

√

—

√

—

×

√

√

√

×

—

√

Du and Qian et al. All NLP Tasks are Generation Tasks. ACL'22. arxiv: 2103.10360

General Language Model (GLM)

General Language Model (GLM)

Du and Qian et al. All NLP Tasks are Generation Tasks. ACL'22.

Du and Qian et al. All NLP Tasks are Generation Tasks. ACL'22. arxiv: 2103.10360

16

General Language Model (GLM)

LAMBADA

Zeng, Liu, et al. GLM-130B: An Open Bilingual Pre-trained Model. ICLR'23

17

Results on Natural Language Understanding

• Better than BERT, T5, RoBERTa

18

Resutls on Generation

• The most important thing is that one model can do all the things

19

Why 100B-scale model?

• What is 16 mod 12?
• 16 divided by 12 
equals 1 remainder 
4. So the answer is 4!

1. J Wei, et al. Emergent Abilities of Large Language Models. arXiv: 2206.07682

GPT-3 (OpenAI)

LaMDA (谷歌)

Why 100B-scale model?

1. J Wei, et al. Emergent Abilities of Large Language Models. arXiv: 2206.07682

Scaling Law

Scaling Law introduces complicated reasoning abilities

Model scale (# parameters in billions)

22

「Emergent abilities」

• OpenAI

• GPT-3 175B

• Google

• LaMDA 137B
• PaLM 540B

• Microsoft

• Turing-NLG 530B

• DeepMind

• Gopher 260B

Gif Credit: Google

How to train a 100B–scale LLM?

•

8 months have witnessed numerous challenges
o Engineering: How to train 100B-scale models from scratch?

§ Hygon DCU, NVIDIA A100, Ascend 910, Sunway
§ Frequent & random hardware failures, Megatron-DeepSpeed 3D pipeline, CUDA kernel

efficiency, GPU memory overflow, 10K+ threads TCP init & comms…
o Algorithm: How to stabilize the training of 100B-scale models?

§ The gradient norms of embeddings, Post-LN / Pre-LN stability, dataloader state seeds,

computation precision in Softmax / Attention

Project
Conceived

System
Debug

Data

Large-Scale Tests

Hygon, NVIDIA
Ascend, Sunway

Algo/Sys

Tests

Training

Stability Issues

Evaluations
Quantization

2021.12

2022.1

2022.2

2022.3

2022.5
http://keg.cs.tsinghua.edu.cn/glm-130b/

2022.4

2022.6

2022.7

To be
continued
24

Training Stability of 100B-Scale Models

p Tradeoff: Stability (Slow) or Efficiency (Instable)
p Existing Solutions

p OPT-175B: manually adjust LR & skip data when collapses (performance drop)
p BLOOM 176B: embedding norm & BF16（performance drop, few platform）

Sources: OPT / BLOOM / GLM-130B

GLM-130B: Training Stability

pAttention score: Softmax in 32 to avoid overflow