## 20231125ChatGLM-An-Alternative-to-ChatGPT

ChatGLM: An Alternative to ChatGPT

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

Challenge 1: Simple NLP task vs. Complex task

• Simple NLP task => Complex task (e.g., logic reasoning)

Challenge 2: Static NLP vs. Dynamic knowledge

• GPT-3’s knowledge can be limited, obsolete, and uninterpretable

– Limited: Limited long-tailed knowledge

Example: what is the sixth highest mountain in the world? (Answer: Mount K2)

– Obsolete: GPT-3’s knowledge is before 2020

– Uninterpretable: No reference for answers that require knowledge

Challenge 3: Traditional NLP vs. Align with Human

• Case Study: Explain the moon landing to a 6 year old in a few sentences.

– Without proper `prompt engineering`, GPT-3 and GLM-130B won’t return satisfying answers, either

Augmenting Code, Alignment, Web, Image understanding…

CodeGeeX

Relay Diffusion Model (RDM)

https://github.com/THUDM/RelayDiffusion

• RDM transfers a low-resolution image into an equivalent high-resolution one via blurring diffusion and block noise.

• RDM achieved state-of-the-art FID on CelebA-HQ and sFID ImageNet-256 (FID=1.87)!

CogVLM

• CogVLM connects pretrained language model and image encoder by a trainable visual expert model

GLM-4V (pre-release)

WebGLM = GLM + Search

LLM Agent

AgentTuning: Enabling Generalized Agent Abilities For LLMs

### 15. ChatGLM-6B

https://github.com/THUDM/ChatGLM3

• Download from Huggingface

git clone https://huggingface.co/THUDM/chatglm3

• Download demo

git clone https://github.com/THUDM/ChatGLM3

cd ChatGLM-6B

• Install demo

pip install gradio

python web_demo.py

• Run the demo

python cli_demo.py

• Install the api

pip install fastapi uvicorn

python api.py

• Run ChatGLM on your own MAC (w/ Apple Silicon)

model = AutoModel.from_pretrained("your local path", trust_remote_code=True).half().to('mps')

### 16. What's the next?

Abstraction and Reasoning

Generative Agent

• Generative agents: computational software agents that simulate believable human behavior

– A “Westworld” with 25 agents; Auto-GPT; AgentGPT…

OpenAI:

Introducing Superalignment

We need scientific and technical breakthroughs to steer and control Al systems much smarter than us. To solve this problem within four years, we're starting a new team, co-led by llya Sutskever and Jan Leike, and dedicating 20% of the compute we've secured to date to this effort. We're looking for excellent ML researchers and engineers to join us.

### 17. Summary

• GPT vs GLM

– ChatGPT vs. ChatGLM

– DALL.E vs. CogView

– Codex vs. CodeGeeX

– WebGPT vs. WebGLM

– GPT-4V vs. GLM-4V (CogVLM, AgentTuning…)

• 2024-toward AGI

### 18. References

• Qinkai Zheng, Xiao Xia, Xu Zou, Yuxiao Dong, Shan Wang, Yufei Xue, Lei Shen, Zihan Wang, Andi Wang, Yang Li, Teng Su, Zhilin Yang, and Jie Tang. CodeGeeX: A Pre-Trained Model for Code Generation with Multilingual Benchmarking on HumanEval-X. KDD’23.

• Xiao Liu, Hanyu Lai, Yu Hao, Yifan Xu, Aohan Zeng, Zhengxiao Du, Peng Zhang, Yuxiao Dong, and Jie Tang. WebGLM: Towards An Efficient Web-enhanced Question Answering System with Human Preference. KDD’23.

• Jing Zhang, Xiaokang Zhang, Daniel Zhang-Li, Jifan Yu, Zijun Yao, Zeyao Ma, Yiqi Xu, Haohua Wang, Xiaohan Zhang, Nianyi Lin, Sunrui Lu, Jie Tang, and Juanzi Li. GLM-Dialog: Noise-tolerant Pre-Training for Knowledge-grounded Dialogue Generation. KDD’23.

• Aohan Zeng, Xiao Liu, Zhengxiao Du, Zihan Wang, Hanyu Lai, Ming Ding, Zhuoyi Yang, Yifan Xu, Wendi Zheng, Xiao Xia, Weng Lam Tam, Zixuan Ma, Yufei Xue, Jidong Zhai, Wenguang Chen, Zhiyuan Liu, Peng Zhang, Yuxiao Dong, and Jie Tang. GLM-130B: An Open Bilingual Pre-trained Model. ICLR’23.

• Wenyi Hong, Ming Ding, Wendi Zheng, Xinghan Liu, and Jie Tang. CogVideo: Large-scale Pretraining for Text-to-Video Generation via Transformers. ICLR’23.

• Ming Ding, Wendi Zheng, Wenyi Hong, and Jie Tang. CogView2: Faster and Better Text-to-Image Generation via Hierarchical Transformers. NeurIPS’22.

• Jifan Yu, Xiaohan Zhang, Yifan Xu, Xuanyu Lei, Xinyu Guan, Jing Zhang, Lei Hou, Juanzi Li, and Jie Tang. XDAI: A Tuning-free Framework for Exploiting Pre-trained Language Models in Knowledge Grounded Dialogue Generation. KDD’22.

• Zhengxiao Du, Yujie Qian, Xiao Liu, Ming Ding, Jiezhong Qiu, Zhilin Yang, and Jie Tang. GLM: General Language Model Pretraining with Autoregressive Blank Infilling. ACL’21.

• Zixuan Ma, Jiaao He, Jiezhong Qiu, Huanqi Cao, Yuanwei Wang, Zhenbo Sun, Liyan Zheng, Haojie Wang, Shizhi Tang, Tianyu Zheng, Junyang Lin, Guanyu Feng, Zeqiang Huang, Jie Gao, Aohan Zeng, JianWei Zhang, Runxin Zhong, Tianhui Shi, Sha Liu, Weimin Zheng, Jie Tang, Hongxia Yang, Xin Liu, Jidong Zhai, and Wenguang Chen. BAGUALU: Targeting Brain Scale Pretrained Models with over 37 Million Cores. PPOPP’22.

• Ming Ding, Zhuoyi Yang, Wenyi Hong, Wendi Zheng, Chang Zhou, Da Yin, Junyang Lin, Xu Zou, Zhou Shao, Hongxia Yang, and Jie Tang. CogView: Mastering Text-to-Image Generation via Transformers. NeurIPS’21.

• Junyang Lin, Rui Men, An Yang, Chang Zhou, Yichang Zhang, Peng Wang, Jingren Zhou, Jie Tang, and Hongxia Yang. M6: MultiModality-to-Multi-Modality Multitask Mega-transformer for Unified Pretraining. KDD’21.