## 20240616ORPO微调优于SFT加DPO

[ORPO Outperforms SFT+DPO | Train Phi-2 with ORPO | by Zain ul Abideen | Medium](https://medium.com/@zaiinn440/orpo-outperforms-sft-dpo-train-phi-2-with-orpo-3ee6bf18dbf2)

ORPO Outperforms SFT+DPO | Train Phi-2 with ORPO

Train Phi-2 with ORPO with LazyOrpo

Zain ul Abideen

Mar 22, 2024

ORPO 优于 SFT+DPO | 使用 ORPO 训练 Phi-2

使用 LazyOrpo 训练 Phi-2

### Introduction

Before jumping into ORPO, I am going to assume that you are well-acquainted with the process of fine-tuning LLMs for optimal performance. One of the most common technique used for fine-tuning is the Supervised Fine-Tuning (SFT). The most common way for doing SFT is to load the model in 4-bit and apply the config to the model for Lora training. Then we use TRL's SFTTrainer to fine-tune models. That's one way of reaching an optimal LLM. Another technique that has been here for some time now is the DPO (Direct Preference Optimization). For DPO, the dataset should be in a specific format i.e. it should contain a chosen response and a rejected response along with the instruction. DPO has shown great results in aligning the model while requiring less compute for the training process. To further improve the model's performance, recently people have adopted to SFT followed by DPO on the same model. This combination of SFT+DPO has proved to be quite effective but at the same time requires more compute resources.

What if I tell you, there is another better fine-tuning technique that can replace both SFT+DPO and have shown promising results. I am referring to ORPO (Odds Ratio Preference Optimization). The main highlight is its loss function. It incorporates an odds ratio-based penalty to the conventional negative log-likelihood (NLL) loss for differentiating the generation styles between favored and disfavored responses.

引言

在介绍 ORPO 之前，假设你已经熟悉了微调大语言模型（LLMs）以获取最佳性能的流程。最常见的微调技术之一是监督微调（SFT)。通常，我们会将模型加载到 4 位，并应用 Lora 训练的配置，然后使用 TRL 的 SFTTrainer 来微调模型。这是一种达到最佳 LLM 的方法。另一种已经存在一段时间的技术是直接偏好优化（DPO)。对于 DPO，数据集必须包含一个选择的响应和一个被拒绝的响应以及指令。DPO 已经在对齐模型方面展示了出色的效果，同时需要较少的计算资源。为了进一步提高模型性能，最近人们开始在同一个模型上先进行 SFT，然后再进行 DPO。这种 SFT+DPO 的组合被证明非常有效，但也需要更多的计算资源。

如果我告诉你，有一种新方法可以取代 SFT+DPO，并且已经显示出良好的效果呢？这种方法是赔率比偏好优化（ORPO)。它的主要亮点在于其损失函数，它结合了基于赔率比的惩罚与传统的负对数似然（NLL）损失，以区分偏好和非偏好响应的生成风格。

### Can ORPO redefine how we train and align LLMs for RLHF?

State-of-the-art LLMs followed the process of Base Model → Supervised Fine-tuning → RLHF (PPO/DPO). This is very resource-intensive and complex. Odds Ratio Preference Optimization (ORPO) proposes a new method to train LLMs by combining SFT and Alignment into a new objective (loss function), achieving state of the art results. DPO not only reduces the cost of the training but also outperforms the results from first fine-tuning the model and then doing RLHF (DPO) on the fine-tuned version. ORPO does not require a reference model, unlike RLHF and DPO. In that sense, ORPO is computationally more efficient than RLHF and DPO in two perspectives:

Memory allocation

Fewer FLOPs per batch.

So, in my opinion the answer to the above question is most probably a "Yes". It can certainly influence the way how we train our models in the future or may have an impact on future research work regarding fine-tuning LLMs.

ORPO 能否重新定义我们如何为 RLHF 训练和对齐 LLMs？

目前最先进的大语言模型（LLM）的训练方法通常遵循以下步骤：基础模型 → 监督微调 → RLHF（PPO/DPO)。这种方法非常耗费资源且复杂。Odds Ratio Preference Optimization（ORPO）提出了一种新的训练方法，通过将监督微调（SFT）和对齐（Alignment）结合到一个新的目标（损失函数）中，从而实现了最先进的结果。相比之下，DPO 不仅降低了训练成本，还优于先微调模型然后在微调版本上进行 RLHF（DPO）的结果。而 ORPO 不需要参考模型，这使得它在以下两个方面比 RLHF 和 DPO 更高效：

- 内存分配
- 每批次的浮点运算次数（FLOPs）更少因此，我认为上述问题的答案很可能是「是」。ORPO 确实有可能影响我们未来的模型训练方法，或对未来关于大语言模型微调的研究产生影响。

### ORPO details

🏆 ORPO Outperforms SFT, SFT+DPO on PHI-2, Llama 2, and Mistral

📊 Mistral ORPO achieves 12.20% on AlpacaEval2.0, 66.19% on IFEval, and 7.32 on MT-Bench Zephyr Beta

Results from the ORPO paper are impressive and to test verify the results of this paper, I decided to try it out on Phi-2 with Argilla's dpo-mix-7k dataset. Some results from the paper are shown below.

AlpacaEvals from ORPO paper

The reason for choosing Phi-2 is that because it shows an insane amount of improvement on this technique as compare to SFT+DPO.

ORPO 详情

🏆 ORPO 在 PHI-2、Llama 2 和 Mistral 上的表现优于 SFT 和 SFT+DPO

📊 根据 ORPO 论文，Mistral ORPO 在 AlpacaEval2.0 上达到了 12.20%，在 IFEval 上达到了 66.19%，在 MT-Bench Zephyr Beta 上达到了 7.32

ORPO 论文的结果非常令人印象深刻。为了验证这些结果，我决定在 Phi-2 上使用 Argilla 的 dpo-mix-7k 数据集进行测试。以下是论文中的一些结果。

图：来自 ORPO 论文的 AlpacaEvals

选择 Phi-2 的原因是它在这项技术上比 SFT+DPO 显示了显著的改进。

### Training process

1️⃣ For implementing ORPO, we will require a dataset that is in DPO format i.e. it should have a chosen and rejected responses. Fot this experiment, we will opt for Argilla's dpo-mix-7k preference dataset.

2️⃣ Make sure the dataset doesn't contain instances where the chosen and rejected responses are the same, or one is empty.

3️⃣ Select a pre-trained LLM (e.g., Llama-2, Mistral). In this case, I have selected Phi-2 as the base model.

4️⃣ Train the Base model with ORPO objective on preference dataset

There is no extra SFT step that is directly applied to base model. The model was trained for 1 epoch on 1x A40 for almost 6 hours. The training parameters used are below:

Learning Rate: 5e-6

Warmup Steps: 100

Model Name: microsoft/phi-2

Data Name: argilla/dpo-mix-7k

Number of Training Epochs: 1

Maximum Length of Prompt: 128

Maximum Length of Response: 2048

Per Device Training Batch Size: 4

Per Device Evaluation Batch Size: 4

Gradient Accumulation Steps: 1

Number of Processes: 1

The training process has also been logged to Weights and Biases. Some of the graphs are shown below:

训练过程

1、要实现 ORPO，我们需要一个 DPO 格式的数据集，也就是包含选择和拒绝响应的数据集。对于这个实验，我们选择 Argilla 的 dpo-mix-7k 偏好数据集。

[argilla/dpo-mix-7k · Datasets at Hugging Face](https://huggingface.co/datasets/argilla/dpo-mix-7k?row=0)

2、确保数据集中没有选定和拒绝响应相同或为空的实例。

3、选择一个预训练的大语言模型（例如 Llama-2, Mistral)。在这个实验中，我选择了 Phi-2 作为基础模型。

4、用偏好数据集上的 ORPO 目标训练基础模型。

基础模型没有直接进行额外的 SFT 步骤。该模型在一块 A40 GPU 上训练了 1 个 epoch，耗时将近 6 个小时。训练参数如下：

- 学习率：5e-6
- 预热步骤：100
- 模型名称：microsoft/phi-2
- 数据名称：argilla/dpo-mix-7k
- 训练周期数：1
- 提示的最大长度：128
- 响应的最大长度：2048
- 每设备训练批次大小：4
- 每设备评估批次大小：4
- 梯度累积步骤：1
- 进程数：1

训练过程记录在 Weights and Biases 上。以下是一些图表：

### LazyORPO

LazyORPO (Automated tool to train your model with ORPO). ORPO is a new technique that replaces SFT+DPO. I gave ORPO a shot with Phi-2 and Argilla dpo-mix-7k yielding Phi2-pro.

Since Odds Ratio Preference Optimization (ORPO) proposes a new method to train LLMs by combining SFT and Alignment into a new objective (loss function), achieving state-of-the-art results, Orpo is not yet included in HF's TRL, so in order to make the training phase much easier, I have made a notebook that automates the entire training process with ORPO. Just mention the base model, dataset, epochs, and learning rate to shoot the training. One thing to notice is that ORPO required more memory VRAM as I was not able to fit an 8B Gemma model on A40 48GB VRAM. So, do your calculations accordingly.

A colab notebook is available for you to try it out. You can access the GPUs using RunPod.

LazyORPO

LazyORPO 是一个用 ORPO 自动训练模型的工具。ORPO 是一种新技术，替代了 SFT+DPO。我尝试用 ORPO 结合 Phi-2 和 Argilla dpo-mix-7k，得到了 Phi2-pro。

由于 Odds Ratio Preference Optimization（ORPO）提出了一种新方法，通过将 SFT 和 Alignment 结合成一个新的目标（损失函数）来训练大语言模型（LLM)，并取得了最先进的成果。目前 ORPO 还没有包含在 Hugging Face 的 TRL 中。为了简化训练过程，我制作了一个自动化训练的笔记本，只需指定基础模型、数据集、训练周期和学习率即可开始训练。需要注意的是，ORPO 需要更多的显存 VRAM，因为我无法在 A40 48GB VRAM 上适配 8B Gemma 模型。因此，请根据需要进行计算。

你可以在 colab 笔记本上尝试这个方法，并通过 RunPod 访问 GPU。

1『

目前官方训练工具 AutoTrain 已经支持 ORPO 训练了。（2024-06-16）

[AutoTrain Configs](https://huggingface.co/docs/autotrain/config)

[How to Finetune phi-3 on MacBook Pro](https://huggingface.co/blog/abhishek/phi3-finetune-macbook)

』

LazyORPO

💥 LazyORPO: https://colab.research.google.com/drive/19ci5XIcJDxDVPY2xC1ftZ5z1kc2ah_rx?usp=sharing

🤗 Model: https://huggingface.co/abideen/phi2-pro

📝 Paper: https://arxiv.org/abs/2403.07691

[[2403.07691] ORPO: Monolithic Preference Optimization without Reference Model](https://arxiv.org/abs/2403.07691)
