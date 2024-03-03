## 20231210Making-LLMs-lighter-with-AutoGPTQ-and-transformers

[Making LLMs lighter with AutoGPTQ and transformers](https://huggingface.co/blog/gptq-integration)

[使用 AutoGPTQ 和 transformers 让大语言模型更轻量化](https://huggingface.co/blog/zh/gptq-integration)

[blog/gptq-integration.md at main · huggingface/blog](https://github.com/huggingface/blog/blob/main/gptq-integration.md)

Making LLMs lighter with AutoGPTQ and transformers

Published August 23, 2023

This article is also available in Chinese 简体中文.

Large language models have demonstrated remarkable capabilities in understanding and generating human-like text, revolutionizing applications across various domains. However, the demands they place on consumer hardware for training and deployment have become increasingly challenging to meet.

🤗 Hugging Face's core mission is to democratize good machine learning, and this includes making large models as accessible as possible for everyone. In the same spirit as our bitsandbytes collaboration, we have just integrated the AutoGPTQ library in Transformers, making it possible for users to quantize and run models in 8, 4, 3, or even 2-bit precision using the GPTQ algorithm (Frantar et al. 2023). There is negligible accuracy degradation with 4-bit quantization, with inference speed comparable to the fp16 baseline for small batch sizes. Note that GPTQ method slightly differs from post-training quantization methods proposed by bitsandbytes as it requires to pass a calibration dataset.

This integration is available both for Nvidia GPUs, and RoCm-powered AMD GPUs.

大语言模型在理解和生成人类水平的文字方面所展现出的非凡能力，正在许多领域带来应用上的革新。然而，在消费级硬件上训练和部署大语言模型的需求也变得越来越难以满足。

🤗 Hugging Face 的核心使命是让优秀的机器学习普惠化，而这正包括了尽可能地让所有人都能够使用上大模型。本着与 bitsandbytes 合作一样的精神，我们将 AutoGPTQ 代码库集成到了 Transformers 中，让用户使用 GPTQ 算法 (Frantar et al. 2023) 在 8 位、4 位、3 位，甚至是 2 位精度下量化和运行模型成为可能。当使用 int4 量化时，精度的下降可以忽略不计，同时在小批量推理上保持着与 fp16 基线相当的速度。需要注意的是，GPTQ 方法与 bitsandbytes 提出的训练后量化方法有所不同：它需要在量化阶段提供一个校准数据集。

本次集成支持英伟达 GPU 和基于 RoCm 的 AMD GPU。

### 01. Table of contents

Resources

A gentle summary of the GPTQ paper

AutoGPTQ library – the one-stop library for efficiently leveraging GPTQ for LLMs

Native support of GPTQ models in 🤗 Transformers

Quantizing models with the Optimum library

Running GPTQ models through Text-Generation-Inference

Fine-tune quantized models with PEFT

Room for improvement

Supported models

Conclusion and final words

Acknowledgements

相关资源

GPTQ 论文总结

AutoGPTQ 代码库 —— 一站式地将 GPTQ 方法应用于大语言模型

🤗 Transformers 对 GPTQ 模型的本地化支持

使用 Optimum 代码库量化模型

通过 Text-Generation-Inference 使用 GPTQ 模型

使用 PEFT 微调量化后的模型

改进空间

已支持的模型

结论和结语

致谢

### 02. Resources

This blogpost and release come with several resources to get started with GPTQ quantization:

01 Original Paper

[[2210.17323] GPTQ: Accurate Post-Training Quantization for Generative Pre-trained Transformers](https://arxiv.org/abs/2210.17323)

02 Basic usage Google Colab notebook - This notebook shows how to quantize your transformers model with GPTQ method, how to do inference, and how to do fine-tuning with the quantized model.

[AutoGPTQ-transformers.ipynb - Colaboratory](https://colab.research.google.com/drive/1_TIrmuKOFhuRRiTWN94iLKUFu6ZX4ceb?usp=sharing)

03 Transformers integration documentation

[Quantization](https://huggingface.co/docs/transformers/main/en/main_classes/quantization)

04 Optimum integration documentation

[Quantization](https://huggingface.co/docs/optimum/llm_quantization/usage_guides/quantization)

05 The Bloke repositories with compatible GPTQ models.

[TheBloke (Tom Jobbins)](https://huggingface.co/TheBloke?sort_models=likes#models)

### 03. A gentle summary of the GPTQ paper

Quantization methods usually belong to one of two categories:

Post-Training Quantization (PTQ): We quantize a pre-trained model using moderate resources, such as a calibration dataset and a few hours of computation.

Quantization-Aware Training (QAT): Quantization is performed before training or further fine-tuning.

GPTQ falls into the PTQ category and this is particularly interesting for massive models, for which full model training or even fine-tuning can be very expensive.

Specifically, GPTQ adopts a mixed int4/fp16 quantization scheme where weights are quantized as int4 while activations remain in float16. During inference, weights are dequantized on the fly and the actual compute is performed in float16.

The benefits of this scheme are twofold:

Memory savings close to x4 for int4 quantization, as the dequantization happens close to the compute unit in a fused kernel, and not in the GPU global memory.

Potential speedups thanks to the time saved on data communication due to the lower bitwidth used for weights.

The GPTQ paper tackles the layer-wise compression problem:

Once this is solved per layer, a solution to the global problem can be obtained by combining the layer-wise solutions.

In order to solve this layer-wise compression problem, the author uses the Optimal Brain Quantization framework (Frantar et al 2022). The OBQ method starts from the observation that the above equation can be written as the sum of the squared errors, over each row of Wl.

This means that we can quantize each row independently. This is called per-channel quantization. For each row XX, OBQ quantizes one weight at a time while always updating all not-yet-quantized weights, in order to compensate for the error incurred by quantizing a single weight. The update on selected weights has a closed-form formula, utilizing Hessian matrices.

The GPTQ paper improves this framework by introducing a set of optimizations that reduces the complexity of the quantization algorithm while retaining the accuracy of the model.

Compared to OBQ, the quantization step itself is also faster with GPTQ: it takes 2 GPU-hours to quantize a BERT model (336M) with OBQ, whereas with GPTQ, a Bloom model (176B) can be quantized in less than 4 GPU-hours.

To learn more about the exact algorithm and the different benchmarks on perplexity and speedups, check out the original paper.

GPTQ 论文总结

通常，量化方法可以分为以下两类：

1、训练后量化 (Post Training Quantization, PTQ)：适度地使用一些资源来量化预训练好的模型，如一个校准数据集和几小时的算力。

2、量化感知训练 (Quantization Aware Training, QAT)：在训练或进一步微调之前执行量化。

GPTQ 属于训练后量化，这对于大模型而言格外有趣且有意义，因为对其进行全参数训练以及甚至仅仅是微调都十分昂贵。

具体而言，GPTQ 采用 int4/fp16 (W4A16) 的混合量化方案，其中模型权重被量化为 int4 数值类型，而激活值则保留在 float16。在推理阶段，模型权重被动态地反量化回 float16 并在该数值类型下进行实际的运算。

该方案有以下两方面的优点：

1、int4 量化能够节省接近 4 倍的内存，这是因为反量化操作发生在算子的计算单元附近，而不是在 GPU 的全局内存中。

2、由于用于权重的位宽较低，因此可以节省数据通信的时间，从而潜在地提升了推理速度。

GPTQ 论文解决了分层压缩的问题：

给定一个拥有权重矩阵 XX 和输入 XX 的网络层，我们期望获得一个量化版本的权重矩阵：

以最小化均方误差 (MSE)：

一旦每层都实现了上述目标，就可以通过组合各网络层量化结果的方式来获得一个完整的量化模型。

为解决这一分层压缩问题，论文作者采用了最优脑量化 (Optimal Brain Quantization, OBQ) 框架 (Frantar et al 2022) 。OBQ 方法的出发点在于其观察到：以上等式可以改写成权重矩阵 XX 每一行的平方误差之和：

这意味着我们可以独立地对每一行执行量化。即所谓的 per-channel quantization。对每一行 XX，OBQ 在每一时刻只量化一个权重，同时更新所有未被量化的权重，以补偿量化单个权重所带来的误差。所选权重的更新采用一个闭环公式，并利用了海森矩阵 (Hessian Matrices)。

GPTQ 论文通过引入一系列优化措施来改进上述量化框架，在降低量化算法复杂度的同时保留了模型的精度。

相较于 OBQ，GPTQ 的量化步骤本身也更快：OBQ 需要花费 2 个 GPU 时来完成 BERT 模型 (336M) 的量化，而使用 GPTQ，量化一个 Bloom 模型 (176B) 则只需不到 4 个 GPU 时。

为了解算法的更多细节以及在困惑度 (perplexity, PPL) 指标和推理速度上的不同测评数据，可查阅原始论文。

### 04. AutoGPTQ library – the one-stop library for efficiently leveraging GPTQ for LLMs

The AutoGPTQ library enables users to quantize 🤗 Transformers models using the GPTQ method. While parallel community efforts such as GPTQ-for-LLaMa, Exllama and llama.cpp implement quantization methods strictly for the Llama architecture, AutoGPTQ gained popularity through its smooth coverage of a wide range of transformer architectures.

Since the AutoGPTQ library has a larger coverage of transformers models, we decided to provide an integrated 🤗 Transformers API to make LLM quantization more accessible to everyone. At this time we have integrated the most common optimization options, such as CUDA kernels. For more advanced options like Triton kernels or fused-attention compatibility, check out the AutoGPTQ library.

AutoGPTQ 代码库 —— 一站式地将 GPTQ 方法应用于大语言模型

AutoGPTQ 代码库让用户能够使用 GPTQ 方法量化 🤗 Transformers 中支持的大量模型，而社区中的其他平行工作如 GPTQ-for-LLaMa 、Exllama 和 llama.cpp 则主要针对 Llama 模型架构实现量化策略。相较之下，AutoGPTQ 因其对丰富的 transformers 架构的平滑覆盖而广受欢迎。

正因为 AutoGPTQ 代码库覆盖了大量的 transformers 模型，我们决定提供一个 🤗 Transformers 的 API 集成，让每个人都能够更容易地使用大语言模型量化技术。截止目前，我们已经集成了包括 CUDA 算子在内的最常用的优化选项。对于更多高级选项如使用 Triton 算子和（或）兼容注意力的算子融合，请查看 AutoGPTQ 代码库。

### 05. Native support of GPTQ models in 🤗 Transformers

After installing the AutoGPTQ library and optimum (pip install optimum), running GPTQ models in Transformers is now as simple as:

from transformers import AutoModelForCausalLM

model = AutoModelForCausalLM.from_pretrained("TheBloke/Llama-2-7b-Chat-GPTQ", torch_dtype=torch.float16, device_map="auto")

Check out the Transformers documentation to learn more about all the features.

Our AutoGPTQ integration has many advantages:

Quantized models are serializable and can be shared on the Hub.

GPTQ drastically reduces the memory requirements to run LLMs, while the inference latency is on par with FP16 inference.

AutoGPTQ supports Exllama kernels for a wide range of architectures.

The integration comes with native RoCm support for AMD GPUs.

Finetuning with PEFT is available.

You can check on the Hub if your favorite model has already been quantized. TheBloke, one of Hugging Face top contributors, has quantized a lot of models with AutoGPTQ and shared them on the Hugging Face Hub. We worked together to make sure that these repositories will work out of the box with our integration.

This is a benchmark sample for the batch size = 1 case. The benchmark was run on a single NVIDIA A100-SXM4-80GB GPU. We used a prompt length of 512, and generated exactly 512 new tokens. The first row is the unquantized fp16 baseline, while the other rows show memory consumption and performance using different AutoGPTQ kernels.

gptq	act_order	bits	group_size	kernel	Load time (s)	Per-token latency (ms)	Throughput (tokens/s)	Peak memory (MB)

False	None	None	None	None	26.0	36.958	27.058	29152.98

True	False	4	128	exllama	36.2	33.711	29.663	10484.34

True	False	4	128	autogptq-cuda-old	36.2	46.44	21.53	10344.62

A more comprehensive reproducible benchmark is available here.

Quantizing models with the Optimum library

To seamlessly integrate AutoGPTQ into Transformers, we used a minimalist version of the AutoGPTQ API that is available in Optimum, Hugging Face's toolkit for training and inference optimization. By following this approach, we achieved easy integration with Transformers, while allowing people to use the Optimum API if they want to quantize their own models! Check out the Optimum documentation if you want to quantize your own LLMs.

Quantizing 🤗 Transformers models with the GPTQ method can be done in a few lines:

from transformers import AutoModelForCausalLM, AutoTokenizer, GPTQConfig

model_id = "facebook/opt-125m"

tokenizer = AutoTokenizer.from_pretrained(model_id)

quantization_config = GPTQConfig(bits=4, dataset = "c4", tokenizer=tokenizer)

model = AutoModelForCausalLM.from_pretrained(model_id, device_map="auto", quantization_config=quantization_config)

Quantizing a model may take a long time. Note that for a 175B model, at least 4 GPU-hours are required if one uses a large dataset (e.g. `"c4"``). As mentioned above, many GPTQ models are already available on the Hugging Face Hub, which bypasses the need to quantize a model yourself in most use cases. Nevertheless, you can also quantize a model using your own dataset appropriate for the particular domain you are working on.

Running GPTQ models through Text-Generation-Inference

In parallel to the integration of GPTQ in Transformers, GPTQ support was added to the Text-Generation-Inference library (TGI), aimed at serving large language models in production. GPTQ can now be used alongside features such as dynamic batching, paged attention and flash attention for a wide range of architectures.

As an example, this integration allows to serve a 70B model on a single A100-80GB GPU! This is not possible using a fp16 checkpoint as it exceeds the available GPU memory.

You can find out more about the usage of GPTQ in TGI in the documentation.

Note that the kernel integrated in TGI does not scale very well with larger batch sizes. Although this approach saves memory, slowdowns are expected at larger batch sizes.

Fine-tune quantized models with PEFT

You can not further train a quantized model using the regular methods. However, by leveraging the PEFT library, you can train adapters on top! To do that, we freeze all the layers of the quantized model and add the trainable adapters. Here are some examples on how to use PEFT with a GPTQ model: colab notebook and finetuning script.

Room for improvement

Our AutoGPTQ integration already brings impressive benefits at a small cost in the quality of prediction. There is still room for improvement, both in the quantization techniques and the kernel implementations.

First, while AutoGPTQ integrates (to the best of our knowledge) with the most performant W4A16 kernel (weights as int4, activations as fp16) from the exllama implementation, there is a good chance that the kernel can still be improved. There have been other promising implementations from Kim et al. and from MIT Han Lab that appear to be promising. Moreover, from internal benchmarks, there appears to still be no open-source performant W4A16 kernel written in Triton, which could be a direction to explore.

On the quantization side, let's emphasize again that this method only quantizes the weights. There have been other approaches proposed for LLM quantization that can quantize both weights and activations at a small cost in prediction quality, such as LLM-QAT where a mixed int4/int8 scheme can be used, as well as quantization of the key-value cache. One of the strong advantages of this technique is the ability to use actual integer arithmetic for the compute, with e.g. Nvidia Tensor Cores supporting int8 compute. However, to the best of our knowledge, there are no open-source W4A8 quantization kernels available, but this may well be an interesting direction to explore.

On the kernel side as well, designing performant W4A16 kernels for larger batch sizes remains an open challenge.

Supported models

In this initial implementation, only large language models with a decoder or encoder only architecture are supported. This may sound a bit restrictive, but it encompasses most state of the art LLMs such as Llama, OPT, GPT-Neo, GPT-NeoX.

Very large vision, audio, and multi-modal models are currently not supported.

Conclusion and final words

In this blogpost we have presented the integration of the AutoGPTQ library in Transformers, making it possible to quantize LLMs with the GPTQ method to make them more accessible for anyone in the community and empower them to build exciting tools and applications with LLMs.

This integration is available both for Nvidia GPUs, and RoCm-powered AMD GPUs, which is a huge step towards democratizing quantized models for broader GPU architectures.

The collaboration with the AutoGPTQ team has been very fruitful, and we are very grateful for their support and their work on this library.

We hope that this integration will make it easier for everyone to use LLMs in their applications, and we are looking forward to seeing what you will build with it!

Do not miss the useful resources shared above for better understanding the integration and how to quickly get started with GPTQ quantization.

Original Paper

Basic usage Google Colab notebook - This notebook shows how to quantize your transformers model with GPTQ method, how to do inference, and how to do fine-tuning with the quantized model.

Transformers integration documentation

Optimum integration documentation

The Bloke repositories with compatible GPTQ models.

Acknowledgements

We would like to thank William for his support and his work on the amazing AutoGPTQ library and for his help in the integration. We would also like to thank TheBloke for his work on quantizing many models with AutoGPTQ and sharing them on the Hub and for his help with the integration. We would also like to aknowledge qwopqwop200 for his continuous contributions on AutoGPTQ library and his work on extending the library for CPU that is going to be released in the next versions of AutoGPTQ.

Finally, we would like to thank Pedro Cuenca for his help with the writing of this blogpost.

### 中文


🤗 Transformers 对 GPTQ 模型的本地化支持

在安装 AutoGPTQ 代码库和 optimum (pip install optimum) 之后，在 Transformers 中运行 GPTQ 模型将非常简单：

from transformers import AutoModelForCausalLM

model = AutoModelForCausalLM.from_pretrained("TheBloke/Llama-2-7b-Chat-GPTQ", torch_dtype=torch.float16, device_map="auto")

请查阅 Transformers 的说明文档以了解有关所有特性的更多信息。

我们的 AutoGPTQ 集成有以下诸多优点：

量化模型可被序列化并在 Hugging Face Hub 上分享。

GPTQ 方法大大降低运行大语言模型所需的内存，同时保持着与 FP16 相当的推理速度。

AutoGPTQ 在更广泛的 transformers 架构上支持 Exllama 算子。

该集成带有基于 RoCm 的 AMD GPU 的本地化支持。

能够使用 PEFT 微调量化后的模型 。

你可以在 Hugging Face Hub 上查看你所喜爱的模型是否已经拥有 GPTQ 量化版本。TheBloke，Hugging Face 的顶级贡献者之一，已经使用 AutoGPTQ 量化了大量的模型并分享在 Hugging Face Hub 上。在我们的共同努力下，这些模型仓库都将可以与我们的集成一起开箱即用。

以下是一个使用 batch size = 1 的测评结果示例。该测评结果通过在英伟达 A100-SXM4-80GB GPU 上运行得到。我们使用长度为 512 个词元的提示文本，并精确地生成 512 个新词元。表格的第一行展示的是未量化的 fp16 基线，另外两行则展示使用 AutoGPTQ 不同算子的内存开销和推理性能。

gptq	act_order	bits	group_size	kernel	Load time (s)	Per-token latency (ms)	Throughput (tokens/s)	Peak memory (MB)

False	None	None	None	None	26.0	36.958	27.058	29152.98

True	False	4	128	exllama	36.2	33.711	29.663	10484.34

True	False	4	128	autogptq-cuda-old	36.2	46.44	21.53	10344.62

一个更全面的、可复现的测评结果可以在这里取得。

使用 Optimum 代码库量化模型

为了将 AutoGPTQ 无缝集成到 Transformers 中，我们使用了 AutoGPTQ API 的一个极简版本，其可在 Optimum 中获得 —— 这是 Hugging Face 针对训练和推理优化而开发的一个工具包。通过这种方式，我们轻松地实现了与 Transformers 的集成，同时，如果人们想要量化他们自己的模型，他们也完全可以单独使用 Optimum 的 API！如果想要量化你自己的大语言模型，请查阅 Optimum 的说明文档 。

只需数行代码，即可使用 GPTQ 方法量化 🤗 Transformers 的模型：

from transformers import AutoModelForCausalLM, AutoTokenizer, GPTQConfig

model_id = "facebook/opt-125m"

tokenizer = AutoTokenizer.from_pretrained(model_id)

quantization_config = GPTQConfig(bits=4, dataset = "c4", tokenizer=tokenizer)

model = AutoModelForCausalLM.from_pretrained(model_id, device_map="auto", quantization_config=quantization_config)

量化一个模型可能花费较长的时间。对于一个 175B 参数量的模型，如果使用一个大型校准数据集（如「c4」），至少需要 4 个 GPU 时。正如上面提到的那样，许多 GPTQ 模型已经可以在 Hugging Face Hub 上被取得，这让你在大多数情况下无需自行量化模型。当然，你仍可以使用你所专注的特定领域的数据集来量化模型。

通过 Text-Generation-Inference 使用 GPTQ 模型

在将 GPTQ 集成到 Transformers 中的同时，Text-Generation-Inference 代码库 (TGI) 已经添加了 GPTQ 的支持，旨在为生产中的大语言模型提供服务。现在，GPTQ 已经可以与动态批处理、paged attention、flash attention 等特性一起被应用于广泛的 transformers 模型架构 。

例如，这一集成允许在单个 A100-80GB GPU 上服务 70B 模型！而这在使用 fp16 的模型权重时是不可能的，因为它超出了最大可用的 GPU 内存。

你可以在 TGI 的说明文档中找到更多有关 GPTQ 的用法。

需要注意的时，TGI 中集成的算子不能很好地扩展到较大的批处理大小。因此，这一方式虽然节省了内存，但在较大的批处理大小上发生速度的下降是符合预期的。

使用 PEFT 微调量化后的模型

在常规的方法下，你无法进一步微调量化后的模型。然而，通过使用 PEFT 代码库，你可以在量化后的模型之上训练适应性网络！为实现这一目标，我们冻结了量化过的基座模型的所有网络层，并额外添加可训练的适应性网络。这里是一些关于如何使用 PEFT 训练 GPTQ 模型的例子：Colab 笔记本和微调脚本 。

改进空间

虽然我们的 AutoGPTQ 集成在极小的预测质量损失代价下，带来了引人瞩目的优势。但在量化技术应用和算子实现方面仍有提升的空间。

首先，尽管 AutoGPTQ （在我们的认知范围内）已经集成了 exllama 中所实现的最佳性能的 W4A16 算子（权重为 int4 数值类型，激活值为 fp16 数值类型），其仍有很大的改进空间。来自 Kim 等人的实现和 MIT Han Lab 的方法似乎十分可靠。此外，根据我们的内部测评，似乎暂未有开源的高性能的 Triton 版本的 W4A16 算子实现，这也是一个值得探索的方向。

在量化层面，我们需要再次强调 GPTQ 方法只对模型权重进行量化。而针对大语言模型的量化，存在其他的方法，提供了以较小的预测质量损失为代价，同时量化权重和激活值的方案。如 LLM-QAT 采用 int4/int8 的混合精度方案，同时还对 KV Cache 施行量化。这一技术的强大优点是能实际使用整数运算算法来进行计算，一个例子是英伟达的张量核心支持 int8 计算 。然而，据我们所知，目前暂无开源的 W4A8 量化算子，但这可能是一个值得探索的方向 。

在算子层面，为更大的批处理大小设计高性能的 W4A16 算子仍然是一大挑战。

已支持的模型

在初始实现中，暂时只支持纯编码器或纯解码器架构的大语言模型。这听起来似乎有较大的局限性，但其实已经涵盖了当前绝大多数最先进的大语言模型，如 Llama、OPT、GPT-Neo、GPT-NeoX 等。

大型的视觉、语音和多模态模型在现阶段暂不被支持。

结论和结语

本文中，我们介绍了 Transformers 对 AutoGPTQ 代码库的集成，使得社区中的任何人都可以更方便地利用 GPTQ 方法量化大语言模型，助力令人激动的大语言模型工具和应用的构建。

这一集成支持英伟达 GPU 和基于 RoCm 的 AMD GPU，这是向支持更广泛 GPU 架构的量化模型的普惠化迈出的一大步。

与 AutoGPTQ 团队的合作非常富有成效，我们非常感谢他们的支持和他们在该代码库上的工作。

我们希望本次集成将使每个人都更容易地在他们的应用程序中使用大语言模型，我们迫不及待地想要看到大家即将使用它所创造出的一切！

再次提醒不要错过文章开头分享的有用资源，以便更好地理解本次集成的特性以及如何快速开始使用 GPTQ 量化。

原始论文

运行于 Google Colab 笔记本上的基础用例 —— 该笔记本上的用例展示了如何使用 GPTQ 方法量化你的 transformers 模型、如何进行量化模型的推理，以及如何使用量化后的模型进行微调。

Transformers 中集成 GPTQ 的说明文档

Optimum 中集成 GPTQ 的说明文档

TheBloke 模型仓库中的 GPTQ 模型。

致谢

感谢潘其威对杰出的 AutoGPTQ 代码库的支持和所作的工作，以及他对本次集成的帮助。感谢 TheBloke 使用 AutoGPTQ 量化大量的模型并分享在 Hugging Face Hub 上，以及他在本次集成中所提供的帮助。感谢 qwopqwop200 对 AutoGPTQ 代码库的持续贡献，目前，他正致力于将该代码库的使用场景拓展至 CPU ，这一特性将在 AutoGPTQ 的下一版本中发布。

最后，我们还要感谢 Pedro Cuenca 对本文的撰写所提供的帮助。


