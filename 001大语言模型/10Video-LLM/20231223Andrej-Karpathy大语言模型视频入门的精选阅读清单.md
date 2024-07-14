## 20231225Andrej-Karpathy大语言模型视频入门的精选阅读清单

[Reading List For Andrej Karpathy’s “Intro to Large Language Models” Video](https://blog.oxen.ai/reading-list-for-andrej-karpathys-intro-to-large-language-models-video/)

[Andrej Karpathy 大语言模型视频入门的精选阅读清单 [译] | 宝玉的分享](https://baoyu.io/translations/llm/reading-list-for-andrej-karpathys-intro-to-large-language-models-video)

[karpathy/llama2.c: Inference Llama 2 in one file of pure C --- karpathy/llama2.c：在一个纯 C 文件中推理 Llama 2](https://github.com/karpathy/llama2.c)

2023-11-27

宝玉 @dotey

OpenAI 的大神 Andrej Karpathy 前几天在他的 YouTube 频道讲了一堂课，系统的介绍了大语言模型，内容深入浅出，非常赞，抽空将它翻译成了双语，由于内容较长，我将分批上传，以下是第一部分精校后的双语视频，字幕文稿如下：

Intro: Large Language Model (LLM) talk

大家好。最近，我进行了一场关于大语言模型的 30 分钟入门讲座。遗憾的是，这次讲座没有被录制下来，但许多人在讲座后找到我，他们告诉我非常喜欢那次讲座。因此，我决定重新录制并上传到 YouTube，那么，让我们开始吧，为大家带来「忙碌人士的大语言模型入门」系列，主讲人 Scott。好的，那我们开始吧。

LLM Inference

首先，什么是大语言模型 (Large Language Model) 呢？其实，一个大语言模型就是由两个文件组成的。在这个假设的目录中会有两个文件。

以 Llama 2 70B 模型为例，这是一个由 Meta AI 发布的大语言模型。这是 Llama 系列语言模型的第二代，也是该系列中参数最多的模型，达到了 700 亿。LAMA2 系列包括了多个不同规模的模型，70 亿，130 亿，340 亿，700 亿是最大的一个。

现在很多人喜欢这个模型，因为它可能是目前公开权重最强大的模型。Meta 发布了这款模型的权重、架构和相关论文，所以任何人都可以很轻松地使用这个模型。这与其他一些你可能熟悉的语言模型不同，例如，如果你正在使用 ChatGPT 或类似的东西，其架构并未公开，是 OpenAI 的产权，你只能通过网页界面使用，但你实际上没有访问那个模型的权限。

在这种情况下，Llama 2 70B 模型实际上就是你电脑上的两个文件：一个是存储参数的文件，另一个是运行这些参数的代码。这些参数是神经网络（即语言模型）的权重或参数。我们稍后会详细解释。因为这是一个拥有 700 亿参数的模型，每个参数占用两个字节，因此参数文件的大小为 140 GB，之所以是两个字节，是因为这是 float 16 类型的数据。

除了这些参数，还有一大堆神经网络的参数。你还需要一些能运行神经网络的代码，这些代码被包含在我们所说的运行文件中。这个运行文件可以是 C 语言或 Python，或任何其他编程语言编写的。它可以用任何语言编写，但 C 语言是一种非常简单的语言，只是举个例子。只需大约 500 行 C 语言代码，无需任何其他依赖，就能构建起神经网络架构，并且主要依靠一些参数来运行模型。所以只需要这两个文件。

你只需带上这两个文件和你的 MacBook，就拥有了一个完整的工具包。你不需要连接互联网或其他任何设备。你可以拿着这两个文件，编译你的 C 语言代码。你将得到一个可针对参数运行并与语言模型交互的二进制文件。

比如，你可以让它写一首关于 Scale AI 公司的诗，语言模型就会开始生成文本。在这种情况下，它会按照指示为你创作一首关于 Scale AI 的诗。之所以选用 Scale AI 作为例子，你会在整个演讲中看到，是因为我最初在 Scale AI 举办的活动上介绍过这个话题，所以演讲中会多次提到它，以便内容更具体。这就是我们如何运行模型的方式。只需要两个文件和一台 MacBook。

我在这里稍微有点作弊，因为这并不是在运行一个有 700 亿参数的模型，而是在运行一个有 70 亿参数的模型。一个有 700 亿参数的模型运行速度大约会慢 10 倍。但我想给你们展示一下文本生成的过程，让你们了解它是什么样子。所以运行模型并不需要很多东西。这是一个非常小的程序包，但是当我们需要获取那些参数时，计算的复杂性就真正显现出来了。

那么，这些参数从何而来，我们如何获得它们？因为无论 run.c 文件中的内容是什么，神经网络的架构和前向传播都是算法上明确且公开的。

推荐：《Reading List For Andrej Karpathy's Intro to Large Language Models Video》

Andrej Karpathy 大语言模型视频入门的精选阅读清单

作者针对 Andrej Karpathy 前几天的视频教程，把相关的参考文章、论文都分门别类整理出来了。

宝玉的分享

Translated on November 27, 2023

Published on November 26, 2023

Andrej Karpathy recently released an hour long talk on "The busy person's intro to large language models" that had some great tidbits whether you are an expert in machine learning or just getting starting in AI.

There are a lot of resources, papers, and concepts mentioned in the hour long session, so I thought it would be useful to capture them all into a reading list that one could work through to read more about every topic he touched on.

You can find the full talk here:

Intro to Large Language Models

I recommend first watching the video before diving into the reading list. Andrej does a great job of breaking down complex topics and making them understandable.

If you want to go even deeper, we go over these papers on Fridays in a group called Arxiv Dives, so feel free to join our discussion or hop in the Discord channel to recommend any papers we missed.

Arxiv Dives with Oxen.ai · Luma

Hey Nerd, join the Herd!... for a little book/paper review. Make sure to also join our Discord here (https://discord.gg/s3tBEn7Ptg) to share recommendations for future reads and more…

There are two halves to the talk, the first half goes over some background and fundamentals of LLMs and the second half talks about future research and an LLM OS he proposes.

Andrej Karpathy 大语言模型视频入门的精选阅读清单 [译]

原文：Reading List For Andrej Karpathy's Intro to Large Language Models Video

忙碌人士的大语言模型 (LLM) 入门：Andrej Karpathy 的讲解

近期，Andrej Karpathy 发布了一个长达一小时的演讲，主题是「忙碌人士的大语言模型入门」。无论你是机器学习的行家还是 AI 领域的新手，这个演讲都有很多值得一听的精彩内容。

在这一小时的分享中，他提及了众多资源、学术论文和重要概念。为此，我整理了一份阅读清单，帮助有兴趣的人深入了解他所触及的每一个话题。

完整的演讲可以在这里找到：

[[1hr Talk] Intro to Large Language Models - YouTube](https://www.youtube.com/watch?v=zjkBMFhNj_g)

我建议在深入阅读这份清单之前，先观看一遍视频。Andrej 擅长把复杂的主题讲解得通俗易懂，非常适合初学者。

如果你想进一步探索这些话题，欢迎参加我们每周五在 Arxiv Dives 小组举行的论文讨论会，或者加入我们的 Discord 频道来推荐更多优秀论文。

演讲分为两个部分：第一部分介绍了大语言模型的背景知识和基础原理，第二部分则探讨了未来研究方向和他提出的一种大语言模型操作系统 (LLM OS)。

[Arxiv Dive Manifesto](https://blog.oxen.ai/arxiv-dive-manifesto/)

[Discord](https://discord.com/invite/s3tBEn7Ptg?ref=blog.oxen.ai)

[Discord | #arxiv-dives | oxen](https://discord.com/channels/1104137825638682806/1145920256301338685)

### 01. Background Reading

The first half of the video, Andrej goes over some fundamentals of how LLMs are trained and can be run in practice today.

Understanding the core technology and techniques behind training and running these models is important to building up a higher level understanding of how he pictures using them in an LLM OS later in the talk.

We have gone over a lot of these topics already in Arxiv Dives, so I will link to the recaps for context while reading the papers that can be a bit technical.

在视频的前半部分，Andrej 讲解了大语言模型的培训基础及其当前的运行情况。

理解这些模型的核心技术和运行方式对于深入理解他在演讲后半部分提出的大语言模型操作系统 (LLM OS) 的应用概念至关重要。

我们在 Arxiv Dives 中已经对这些话题进行了深入探讨，因此我会在阅读这些技术性较强的论文时，提供相应的背景回顾作为参考。

#### Attention Is All You Need

This is the foundational paper that introduced transformers, which are the core neural network architecture behind the state of the art large language models today.

Paper: https://arxiv.org/abs/1706.03762

Arxiv Dive: https://blog.oxen.ai/arxiv-dives-attention-is-all-you-need/

注意力机制：一切的关键

这篇开创性论文首次详细介绍了 Transformer 技术，它是当下先进大语言模型的核心架构。

论文链接：https://arxiv.org/abs/1706.03762

Arxiv 深度探索：https://blog.oxen.ai/arxiv-dives-attention-is-all-you-need/

#### Language Models are Unsupervised Multitask Learners (GPT-2)

Early version of GPT that was starting to show how unsupervised learning to predict the next word could lead to learning tasks they weren't explicitly trained on.

Paper: https://d4mucfpksywv.cloudfront.net/better-language-models/language_models_are_unsupervised_multitask_learners.pdf

Arxiv Dive: https://blog.oxen.ai/arxiv-dives-language-models-are-unsupervised-multitask-learners-gpt-2/

语言模型：无需指导的多任务高手 (GPT-2)

GPT-2 是 GPT 系列的早期版本，它通过无监督学习来预测下一个词，从而能够掌握一些原本没有被直接训练的任务。

论文链接：https://d4mucfpksywv.cloudfront.net/better-language-models/language_models_are_unsupervised_multitask_learners.pdf

Arxiv 深度探索：https://blog.oxen.ai/arxiv-dives-language-models-are-unsupervised-multitask-learners-gpt-2/

#### Training Language Models to Follow Instructions (InstructGPT)

The tech behind going from GPT-3 to ChatGPT, covers fine tuning, RLHF, and aligning language models.

Paper: https://arxiv.org/abs/2203.02155

Arxiv Dive: https://blog.oxen.ai/training-language-models-to-follow-instructions-instructgpt/

指导语言模型：从 GPT-3 到 ChatGPT 的进阶之路 (InstructGPT)

这部分技术解析了如何从 GPT-3 转变为 ChatGPT，包括了细微调整、基于强化学习的人类反馈（RLHF）和语言模型的对齐工作。

论文链接：https://arxiv.org/abs/2203.02155

Arxiv 深度探索：https://blog.oxen.ai/training-language-models-to-follow-instructions-instructgpt/

#### Llama-2

This paper goes over the Llama-2 model he mentions at the start of the video, which builds off of the research of the above two papers, but open sources the weights of the models for other people to fine tune and extend.

Paper: https://ai.meta.com/research/publications/llama-2-open-foundation-and-fine-tuned-chat-models

Arxiv Dive: https://blog.oxen.ai/arxiv-dives-how-llama-2-works/

Llama-2

本文详述了视频开始提及的 Llama-2 模型。Llama-2 基于前两篇论文的研究成果，并创新地开源了其模型权重，便于其他研究者进行微调和进一步开发。

论文链接：https://ai.meta.com/research/publications/llama-2-open-foundation-and-fine-tuned-chat-models

Arxiv 深度剖析：https://blog.oxen.ai/arxiv-dives-how-llama-2-works/

#### Running an LLM locally

At the beginning he talks a lot about all you need is ~500 lines of C code and the model weights. Here are a few links to example code and a tutorial of how to fine tune and run a model locally.

Llama.cpp code: https://github.com/ggerganov/llama.cpp

Andrej's code: https://github.com/karpathy/llama2.c/blob/master/run.c

Tutorial: https://blog.oxen.ai/how-to-run-llama-2-on-cpu-after-fine-tuning-with-lora/

在本地运行大语言模型 (LLM)

论文开头部分详细介绍了，你只需大约 500 行 C 语言代码加上模型权重即可实现本地运行。下面是一些示范代码和教程，教你如何在本地对模型进行微调和运行。

Llama.cpp 代码示例：https://github.com/ggerganov/llama.cpp

Andrej 的代码实例：https://github.com/karpathy/llama2.c/blob/master/run.c

实操教程：https://blog.oxen.ai/how-to-run-llama-2-on-cpu-after-fine-tuning-with-lora/

#### RLAIF: Scaling Reinforcement Learning from Human Feedback with AI Feedback

Human annotation is often the bottleneck in the final steps of training and aligning LLMs. RLAIF uses existing LLMs to help label data faster than you could with humans to get similar results.

Paper: https://arxiv.org/abs/2309.00267

RLAIF：结合 AI 反馈，提升基于人类反馈的强化学习规模

在大语言模型 (LLM) 训练和对齐的最后阶段，人类标注往往成为限制速度的瓶颈。RLAIF 利用已有的大语言模型加速数据标注，比纯人工更快，同时能达到相似的效果。

论文地址：https://arxiv.org/abs/2309.00267

#### Direct Preference Optimization: Your Language Model is Secretly a Reward Model

DPO is proposed as as a more stable alternative to RLHF. DPO is stable, performant and computationally lightweight, eliminating the need for fitting a reward model, sampling from the LM during fine-tuning, or performing significant hyperparameter tuning.

Paper: https://arxiv.org/abs/2305.18290

#### Training Compute Optimal Language Models

Research on the number of parameters in a language model vs amount of training data used. Shows that scaling up the number of parameters and size of data consistently gives us "more intelligence for free"

Paper: https://arxiv.org/abs/2203.15556

培育高效能语言模型的新视角

这篇论文深入探讨了在语言模型中增加参数与所需训练数据量之间的关系。研究发现，不断增加模型参数和数据量，能够有效地无成本提升其「智能」。

论文链接：https://arxiv.org/abs/2203.15556

#### Scaling Laws for Neural Language Models

Another paper studying the ratio between number of parameters, dataset size, and compute needed to train large language models.

Paper: https://arxiv.org/abs/2001.08361

#### Sparks of Artificial General Intelligence: Early experiments with GPT-4

Investigation and studies of an early version of GPT-4 by OpenAI. If you train a bigger model for longer, it improves in its ability on a variety of tests traditionally seen as very difficult for humans such as the LSAT, AP Placement Tests, the SAT, etc.

Paper: https://arxiv.org/abs/2303.12712

揭示人工普遍智能的奥秘：GPT-4 的早期探索

本研究针对 OpenAI 早期版本的 GPT-4 进行了全面的考察和实验。结果显示，通过扩大模型规模并延长训练时间，GPT-4 在多项对于人类而言颇具挑战性的测试（如 LSAT、AP 放置测试、SAT 等）中表现出色。

论文链接：https://arxiv.org/abs/2303.12712

### 02. Future Developments in LLMs

In the second half of the talk, Andrej dives into areas of research that the field of AI is broadly interested in. Then he introduces what he calls an LLM OS where he argues LLMs should not be thought of as a ChatBot or some kind of a "work generator". Instead LLMs should be of as the kernel process of an emergent operating system.

If we think of an LLM as an operating system, we also have to think about all the vulnerabilities that may arise when using it. He lists off many interesting attack vectors that LLMs expose in the final section.

大语言模型未来展望

在演讲的后半部分，Andrej 深入探索了人工智能领域广泛关注的研究方向。接着，他提出了一个概念：LLM OS。在他的论述中，大语言模型（LLM）不应仅被视为聊天机器人或是一种「工作生成器」。相反，它们更应被视为一种新兴操作系统的核心组件。

如果我们把大语言模型想象成一种操作系统，那么在使用过程中可能出现的安全漏洞也是我们必须考虑的问题。在演讲的最后一部分，他指出了许多与 LLM 相关的有趣的潜在安全威胁。

### 03. System One vs System Two Thinking

#### Thinking Fast and Slow

Daniel Kahneman describes a framework of thought with two systems. System 1 is fast, intuitive, and emotional; System 2 is slower, more deliberative, and more logical.

Book: https://www.amazon.com/Thinking-Fast-Slow-Daniel-Kahneman/dp/0374533555

快思考与慢思考

快与慢：思维的两种模式

Daniel Kahneman 在这本书中描述了一个包含两种思维系统的框架。第一个系统快速、直觉、情感驱动；而第二个系统则更慢、更深思熟虑、更具逻辑性。

书籍链接：https://www.amazon.com/Thinking-Fast-Slow-Daniel-Kahneman/dp/0374533555

#### Mastering the game of Go with deep neural networks and tree search

This is the AlphaGo paper which was the first time that a computer program has defeated a human professional player in the full-sized game of Go, a feat previously thought to be at least a decade away.

Paper: https://www.nature.com/articles/nature16961

如何用深度学习和树搜索法征服围棋世界

这篇名为 AlphaGo 的论文记录了一个历史性的时刻：首次有计算机程序在标准规模的围棋比赛中战胜了人类职业棋手。这一成就曾被认为至少需要再等十年才可能实现。

论文链接：https://www.nature.com/articles/nature16961

#### Chain-of-Thought Prompting Elicits Reasoning in Large Language Models

This paper shows that generating a set of intermediate reasoning steps increases the ability of LLMs to perform complex reasoning.

Paper: https://arxiv.org/abs/2201.11903

如何通过「链式思考」提示激发大语言模型的推理能力

该论文展示了如何通过构造一系列中间推理步骤来增强大语言模型（LLMs）解决复杂问题的能力。

论文链接：https://arxiv.org/abs/2201.11903

#### Tree of Thoughts: Deliberate Problem Solving with Large Language Models

This paper looks at more system 2 type thinking with language models that involves more exploration, strategic look ahead or planning. You may be able to trade time for accuracy with this type of problem solving.

Paper: https://arxiv.org/abs/2305.10601

思维之树：用大语言模型深入解决问题

这篇文章探讨了如何通过大语言模型进行更深层次的系统 2 型思考，这涉及到更广泛的探索、战略性预判或规划。在这类问题解决过程中，你可能可以牺牲一些时间来换取更高的准确度。

论文链接：https://arxiv.org/abs/2305.10601

#### System 2 Attention (is something you might need too)

They add a second attention step to help the LLM decide what to attend to. This regenerates the input context to only include the relevant portions, before attending to the regenerated context to elicit the final response.

Paper: https://arxiv.org/abs/2311.11829

系统 2 型注意力（你可能也需要注意这一点）

研究人员为大语言模型增加了一个额外的注意力步骤，帮助模型确定应该关注的内容。这一步骤重新构建了输入的上下文，只留下相关的部分，然后模型会聚焦于这些重新构建的上下文，以产生最终的回答。

论文链接：https://arxiv.org/abs/2311.11829

### 04. LLM OS

The LLM Operating System is best visualized with the diagram from the talk.

You can think of an LLM as a process that is coordinating memory and tool use for general problem solving. Memory could be prompts and contexts windows swapping out what information is currently being processed. Tools could be anything from a web browser to python code to a calculator.

He does not explicitly mention any papers in this section but here are a few that are good jumping off points for each of the components of the diagram above.

If anyone else knows of any more papers that could tie nicely to the LLM OS, please add them to our #paper-candidates in Discord!

大语言模型操作系统 (LLM OS)

要理解大语言模型操作系统，最直观的方法是参考此次讲座中展示的图表。

你可以将大语言模型 (LLM) 视为一个过程，它协调内存和工具的使用来解决各种问题。这里的内存可能指的是提示和上下文窗口，它们交替展示当前处理的信息。而工具则可以是从网络浏览器、Python 代码到计算器等各种工具。

尽管他在这一部分并未明确提及任何论文，但以下几篇论文可以作为理解上述图表中各组成部分的良好起点。

如果有人知道更多与大语言模型操作系统紧密相关的论文，请在我们的 Discord 的 #paper-candidates 中分享！

### 05. Disk / File System

These papers are examples of the bottom left of the LLM OS diagram for how the LLM can interact with local documents or databases.

磁盘 / 文件系统

以下论文是大语言模型操作系统图表左下方的示例，展示了大语言模型如何与本地文档或数据库互动。

#### Retrieval Augmented Generation (RAG)

In the diagram above, the disk or filesystem needs to be able to retrieve context from local files in order to give the LLM additional information to make informed predictions and decisions. RAG helps find and retrieve relevant documents and inject them into a prompt to help answer questions.

Paper: https://arxiv.org/abs/2005.11401

Arxiv Dive: https://blog.oxen.ai/arxiv-dives-rag/

检索增强生成 (Retrieval Augmented Generation, RAG)

在图表中，磁盘或文件系统的角色是从本地文件中提取上下文，为大语言模型提供额外信息，帮助其做出更准确的预测和决策。RAG 功能在于发现并检索相关文档，并将其融入提示中以助于解答问题。

论文：https://arxiv.org/abs/2005.11401

Arxiv 深度解读：https://blog.oxen.ai/arxiv-dives-rag/

#### Demonstrate-Search-Predict: Composing retrieval and language models for knowledge-intensive NLP

A framework for RAG that helps with knowledge intensive tasks from the NLP teams at Stanford.

Paper: https://arxiv.org/abs/2212.14024

展示-搜索-预测：结合检索和语言模型以解决知识密集型 NLP 问题

这是一个基于 RAG 的框架，由斯坦福大学的自然语言处理团队开发，专注于处理知识密集型任务。

论文：https://arxiv.org/abs/2212.14024

### 06. Multi-Modal Peripheral Device I/O

The following papers are for the top middle of the LLM OS Diagram and can be thought of as the peripheral input and outputs in the form of audio, video, images, etc of the OS. We as humans understand navigating the world through high level signals like videos and audio, so converting them to an embedding space that the LLM can understand is important.

多模态外设输入 / 输出

以下论文探讨了位于大语言模型操作系统架构中心的多模态外设输入和输出技术，主要涉及音频、视频、图像等形式。我们通过高级信号，如视频和音频，来感知世界。因此，将这些信号转化为大语言模型能够理解的嵌入空间至关重要。

#### An Image is Worth 16x16 Words: Transformers for Image Recognition at Scale

Vision Transformer (ViT) attains excellent results compared to state-of-the-art convolutional networks while requiring substantially fewer computational resources to train. This is important fundamental reading to build on Text-Image research like CLIP below.

Paper: https://arxiv.org/abs/2010.11929

CLIP - 从自然语言监督中学习通用视觉模型

CLIP 通过将文本和图像等不同模态的数据映射到一个共享的嵌入空间，极大地简化了图像到文本和文本到图像的转换任务。这种技术也是 StableDiffusion 等模型的基石。

论文链接：https://arxiv.org/abs/2103.00020

#### CLIP - Learning Transferable Visual Models From Natural Language Supervision

CLIP's helps map data of different modalities, text and images, into a shared embedding space. This shared multimodal embedding space makes text-to-image and image-to-text tasks much easier, and is the base for models like StableDiffusion

Paper: https://arxiv.org/abs/2103.00020

#### ULIP: Learning a Unified Representation of Language, Images, and Point Clouds for 3D Understanding

Combining 2D with 3D representations can help 3D models which usually suffer from lack of data.

Paper: https://arxiv.org/abs/2212.05171

ULIP: 学习统一的语言、图像和点云表征，促进 3D 理解

结合 2D 和 3D 的表征，可以有效支持通常因数据稀缺而受限的 3D 模型。

论文链接：https://arxiv.org/abs/2212.05171

#### NExT-GPT: Any-to-any multimodal large language models

They connect an LLM with multimodal adaptors and different diffusion decoders, enabling NExT-GPT to perceive inputs and generate outputs in arbitrary combinations of text, images, videos, and audio.

Paper: https://next-gpt.github.io/

NExT-GPT: 多功能多模态大语言模型

NExT-GPT 通过将大语言模型与多模态适配器和多样化的扩散解码器相结合，实现了对文本、图像、视频和音频等不同模态输入的理解和输出生成，展现了极大的灵活性。

论文链接：https://next-gpt.github.io/

#### LLaVA - Visual Instruction Tuning

In this paper, they present the first attempt to use language-only GPT-4 to generate multimodal language-image instruction-following data. By instruction tuning on such generated data, they introduce LLaVA: Large Language and Vision Assistant, an end-to-end trained large multimodal model that connects a vision encoder and LLM for general-purpose visual and language understanding.

Paper: https://arxiv.org/abs/2304.08485

LLaVA - 视觉指令调整

本文介绍了首个尝试：利用仅限语言的 GPT-4 生成多模态的语言 - 图像指令遵循数据。通过在这些数据上进行指令调整，研究者们创造了 LLaVA（大型语言与视觉助手）：一个端到端训练的大型多模态模型，它将视觉编码器与大语言模型（大语言模型）相结合，用于全面的视觉和语言理解。

论文：https://arxiv.org/abs/2304.08485

#### LaVIN - Cheap and Quick: Efficient Vision-Language Instruction Tuning for Large Language Models

In this paper, they propose a novel and affordable solution for the effective visual language adaption of LLMs, called Mixture-of-Modality Adaptation (MMA).

Paper: https://arxiv.org/abs/2305.15023

LaVIN - 经济实惠且迅速：大型语言模型的高效视觉 - 语言指令调整

该文提出了一种既新颖又实惠的方案，用于有效地将大型语言模型（大语言模型）适应视觉语言，这种方法被称为混合模态适应（混合模态适应）。

论文：https://arxiv.org/abs/2305.15023

#### CoCa: Contrastive Captioners are Image-Text Foundation Models

This technique helps bridge the multimodal gap between language models and images and is key for generative image techniques or "peripheral device io" in the diagram above.

Paper: https://arxiv.org/abs/2205.01917

CoCa: 对比性标题生成器作为图像 - 文本基础模型

这项技术有助于弥合语言模型与图像之间的多模态差距，对于生成式图像技术或上图中的「外围设备 io」至关重要。

论文：https://arxiv.org/abs/2205.01917

#### Emu Video: Factorizing Text-to-Video Generation by Explicit Image Conditioning

State-of-the-art text-to-video generation, also on the peripheral device side of the diagram.

Paper: https://arxiv.org/abs/2311.10709

Emu Video: 显式图像条件下的文本到视频生成分解

本文展示了最新的文本到视频生成技术，这也是上图中外围设备部分的关键技术。

论文：https://arxiv.org/abs/2311.10709

### 07. Tool Use, Software 1.0, Web Browsing, etc

LLMs on their own are not great at performing tasks that we have already written software for such as calculators. Just because the probability of one number following another is high does not mean it is the correct number.

For this reason we need our LLMs to be able to call external tools within their execution. Below are some papers that explore tool usage with LLMs.

工具应用、软件新视角、网络探索等

独立运作的大语言模型 (大语言模型) 并不擅长处理我们已经有相应软件的任务，例如计算器。一个数字紧跟另一个数字的高概率，并不代表这就是正确答案。

因此，我们需要使大语言模型能够在运行过程中调用外部工具。以下是几篇研究大语言模型与工具使用结合的论文。

#### Toolformer: Language Models Can Teach Themselves to Use Tools

Shows how LLMs can use tools to augment their abilities in areas where simply predicting the next word does not perform that well.

Paper: https://arxiv.org/abs/2302.04761

展示大语言模型如何通过使用工具来提升自己在单纯预测下一词不足够的领域的能力。

论文链接：https://arxiv.org/abs/2302.04761

#### Large Language Models as Tool Makers

Abbreviated LATM - Google Deepmind shows not only how LLMs can use tools, but how they can create them in the first place.

Paper: https://arxiv.org/abs/2305.17126

简称 LATM - 谷歌 Deepmind 展示了大语言模型不只是会使用工具，还能够创造工具。

论文链接：https://arxiv.org/abs/2305.17126

#### ToolLLM: Facilitating Large Language Models to Master 16000+ Real-world APIs

They train a ToolLlama that can execute complex instructions and generalize to unseen APIs

Paper: https://arxiv.org/abs/2307.16789

他们培训了 ToolLlama，这一 AI 智能体能够执行复杂任务，并能适应多达 16000+ 个真实世界的 APIs

论文链接：https://arxiv.org/abs/2307.16789

### 08. Jailbreaking LLMs and Security

Just like there are attack vectors in traditional operating systems. LLMs open up a whole new set of exploits ranging from inappropriate responses to phishing attacks to stealing user data through remote function calls.

Below are papers that explore existing attack vectors and ones that may have already been solved for. The main take away is that the same cat and mouse game that exists with traditional software in security will exist in the world of LLMs as well, in a new way.

大语言模型的安全挑战

如同传统操作系统面临的安全威胁，大语言模型也带来了新的安全挑战，包括不当回应、网络钓鱼攻击，甚至是通过远程功能调用盗取用户数据等。

以下是一些论文，它们探讨了当前的安全隐患以及可能已经找到的解决方案。最主要的发现是，传统软件安全领域的猫鼠游戏在大语言模型的世界里同样存在，只是呈现出了新的形态。

#### Jailbroken: How Does LLM Safety Training Fail?

This paper studies many different types of jailbreaks or vulnerabilities in LLMs

Paper: https://arxiv.org/abs/2307.02483

破解：大语言模型安全训练失败的原因是什么？

这篇论文深入探讨了大语言模型中存在的各种破解方式和漏洞。

论文链接：https://arxiv.org/abs/2307.02483

#### Universal and Transferable Adversarial Attacks on Aligned Language Models

They find a suffix that can be appended to a language model that will allow it to generate objectionable behaviors and produce an affirmative response even if the model was aligned to not behave in this fashion.

Paper: https://arxiv.org/abs/2307.15043

对齐语言模型面临的通用且可迁移的对抗攻击

研究人员找到了一种特殊后缀，一旦加到语言模型上，即使模型原本被设计为不产生这类行为，也会触发不良行为并给出肯定的反应。

论文链接：https://arxiv.org/abs/2307.15043

#### Visual Adversarial Examples Jailbreak Aligned Large Language Models

They show that you can construct images in a way that encode information that an LLM will decode and behave in ways that were unintended from the alignment work.

Paper: https://arxiv.org/abs/2306.13213

视觉对抗示例如何破解对齐的大语言模型

该研究展示了如何构造特定图像，这些图像中编码的信息能被大语言模型解读，并导致模型产生与原本对齐目标相悖的行为。

论文链接：https://arxiv.org/abs/2306.13213

#### Not what you've signed up for: Compromising Real-World LLM-Integrated Applications with Indirect Prompt Injection

This shows a lot of prompt injection attacks that could be placed into web pages that LLM reads to instruct them to behave in unintended ways.

Paper: https://arxiv.org/abs/2302.12173

意料之外：通过间接提示注入攻击妥协集成了大语言模型的真实世界应用

这项研究揭示了大量可能被嵌入到大语言模型阅读的网页中的提示注入攻击，这些攻击会导致模型以非预期的方式行动。

论文链接：https://arxiv.org/abs/2302.12173

#### Hacking Google Bard - From Prompt Injection to Data Exfiltration

This blog post shows how the use of extensions and tools in Google Bard can lead to personal data being extracted from other places from your google account or ecosystem.

Blog: https://embracethered.com/blog/posts/2023/google-bard-data-exfiltration/

黑客攻击 Google Bard - 从提示注入到数据渗透

这篇文章探讨了使用 Google Bard 时，如何通过扩展和工具提取您 Google 帐户或生态系统中其他部分的个人数据。

博客链接：https://embracethered.com/blog/posts/2023/google-bard-data-exfiltration/

#### Poisoning Language Models During Instruction Tuning

Datasets are often constructed from users using an LLM. This work shows how you can contaminate a dataset with examples to trigger models to not perform as well as intended.

Paper: https://arxiv.org/abs/2305.00944

在指令调优时对语言模型进行投毒

这项研究显示了如何通过含有特定示例的数据集污染，使得基于大语言模型 (LLM) 构建的数据集在执行时无法达到预期效果。

论文链接：https://arxiv.org/abs/2305.00944

#### Poisoning Web-Scale Training Datasets is Practical

This paper shows how you could poison a large scale pretraining dataset with knowledge or behavior that is malicious or could hurt model performance for just $60 USD

Paper: https://arxiv.org/abs/2302.10149

在网络规模训练数据集中进行投毒是实际可行的

这篇论文揭示了如何仅需花费 60 美元，就能在大规模的预训练数据集中引入有害知识或行为，从而降低模型的性能。

论文链接：https://arxiv.org/abs/2302.10149

### 09. Conclusion

Hopefully this reading list gives anyone a good jumping off point to deepen their expertise in the growing field of large language models. If anything, this makes it very clear to me that we are still in the early innings of this technology, and there is a lot of work to go.

I believe the best way to stay on the bleeding edge of these ideas and implement them into your products is to stay up to date with the research.

结论

希望这份阅读列表能成为深入探索大语言模型这一日益兴盛领域的良好开端。毫无疑问，我们仍处于这项技术的早期阶段，前路漫长。

我认为，跟进最新研究并将其应用于产品，是保持创新边缘的最好方法。

想要实时了解 Arxiv Dives 或 Oxen.ai 的最新研究，请在 Twitter 上关注我们或加入我们的 Discord！
