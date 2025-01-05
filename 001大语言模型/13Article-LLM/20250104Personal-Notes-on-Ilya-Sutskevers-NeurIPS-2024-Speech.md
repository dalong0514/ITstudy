## 20250104Personal-Notes-on-Ilya-Sutskevers-NeurIPS-2024-Speech

[Personal Notes on Ilya Sutskever’s NeurIPS 2024 Speech | by Joyce Birkins | Dec, 2024 | Medium](https://medium.com/@joycebirkins/personal-notes-on-ilya-sutskevers-neurips-2024-speech-fd98f9a24feb)

Personal Notes on Ilya Sutskever's NeurIPS 2024 Speech

Joyce Birkins

Dec 18, 2024

Ilya Sutskever NeurIPS 2024 Speech "Sequence to Sequence Learning with Neural Networks: What a Decade"

Ilya Sutskever 在 NeurIPS 2024 的演讲，题为「使用神经网络的序列到序列学习：这十年」。

The speech was quite shallow. In 20 minutes, he couldn't delve deep into anything, just listing some basic common knowledge: LSTM is outdated, and Auto-regressive is the correct approach. Pipeline parallel training had been researched a decade ago. Future directions are Agent, Reasoning, and eventually moving towards Understanding and self-awareness.

这次演讲内容较为浅显。在短短 20 分钟内，他未能深入探讨任何具体问题，仅仅罗列了一些基础性的共识：例如 LSTM 在序列建模方面已不再是主流，而自回归方法才是当前更优的选择。流水线并行训练技术早在十年前就已被研究。他认为未来的发展方向是 AI 智能体、推理能力，并最终迈向理解和自我意识。

Recently trapped in a writing bottleneck, unsure what to write, I'll try to share my thoughts on the points Ilya Sutskever mentioned.

最近我陷入了写作的瓶颈，一时不知该写些什么，所以想尝试分享一下我对 Ilya Sutskever 所提及观点的思考。

These seem like useful but superficial discussions. LSTM and Auto-Regressive were already covered in Why BERT Is No Longer Talked About, Not Even Model Architectures. Since emerging from the obscure Transformer research state, I no longer want to delve deeply into review. Much of what I learned feels abstract; I only remember placing knowledge points in a specific position on a whiteboard software, and I need to look at the notebook to recall some detail fragments.

[Transformer : Why Don’t We Talk About BERT Anymore, and Even Ignore Model Architectures? | by Joyce Birkins | Medium](https://medium.com/@joycebirkins/transformer-why-dont-we-talk-about-bert-anymore-and-even-ignore-model-architectures-54a369c83d99)

这些讨论似乎有些用处，但略显表面化。关于 LSTM 和自回归的内容，在《为什么 BERT 不再被提及，甚至包括模型架构》一文中已经有所涉及。自从 Transformer 技术从早期的默默无闻的研究状态走向大众视野后，我便不再想深入回顾这些内容。我所学到的很多知识都感觉非常抽象，我只记得曾经将知识点记录在白板软件的特定位置上，现在需要翻看笔记才能回忆起一些细节。

Pipeline parallel training deserves more explanation. I hadn't previously paid much attention to this detail:

管道并行训练（Pipeline Parallel Training）值得我们深入探讨。我之前没有过多关注这个细节：

A decade ago, pipeline parallelism was attractive because it could run super-large models on a limited number of GPUs while utilizing inter-device parallelization. In 2014, research was transitioning from RNN to Transformer, and previous RNN models and LSTM didn't support parallel training.

大约十年前，管道并行之所以备受关注，是因为它能在有限的图形处理器（GPU）上运行超大型模型，同时利用不同设备之间的并行计算。在 2014 年，研究的重点正从循环神经网络（RNN）过渡到 Transformer 模型，而之前的循环神经网络（RNN）模型和长短期记忆网络（LSTM）模型不支持并行训练。

Initially, there was pipeline parallelism, which allocated different parts of the model across layers to multiple devices, simultaneously processing different batches of data.

最初，有一种叫做流水线并行的技术，它将模型的不同层分配到多个设备上，让这些设备同时处理不同的数据批次。

Pipeline parallelism has the following limitations:

管道并行存在以下局限性：

1 Inefficient device utilization: Devices may be idle when the pipeline is not full or has ended, reducing overall efficiency.

设备利用率不高：当管道未被充分填满或者执行完毕时，设备可能会处于空闲状态，这会降低整体的效率。

2 Communication bottlenecks: Cross-device data transfer introduces significant latency, especially with multiple devices.

通信瓶颈：跨设备的数据传输会引入明显的延迟，尤其是在涉及多个设备时。

3 Gradient synchronization issues: Backpropagation requires complete forward propagation results, and pipeline increases computational and synchronization complexity.

梯度同步问题：反向传播（Backpropagation）需要完整的前向传播结果，而使用流水线方式会增加计算和同步的复杂性。

Currently, parallel training primarily uses Hybrid Parallelism, combining pipeline parallelism, data parallelism, and tensor parallelism:

目前，并行训练主要采用混合并行的方式，它结合了流水线并行、数据并行和张量并行等技术：

Data Parallelism: Training data is divided into multiple mini-batches, with each device processing a portion of the data while running the same model.

数据并行：训练数据被分割成多个小批量，每个计算设备运行相同的模型，并处理其中一部分数据。

Data parallelism is parallel to model parallelism. Tensor parallelism and pipeline parallelism are model parallelisms that split models by layers or within layers.

数据并行和模型并行是两种并行的策略。张量并行和流水线并行属于模型并行，它们分别通过层之间或层内部来分割模型。

Tensor Parallelism: Splitting tensors of single operations in the model, such as dividing weight matrices by rows or columns across multiple devices.

张量并行：这是一种将模型中单个操作所涉及的张量进行拆分的技术，例如，将权重矩阵按行或列分割到多个设备上进行计算。

Specific product frameworks include:

具体的产品框架包括：

DeepSpeed: Optimizes communication efficiency for hybrid parallelism.

DeepSpeed：优化混合并行计算的通信效率。

Megatron-LM: Tensor parallelism + pipeline parallelism for super-large models.

Megatron-LM：用于超大规模模型的张量并行（Tensor parallelism）+ 流水线并行（pipeline parallelism）。

FlexFlow: Automated parallel strategy search.

FlexFlow：一种自动化的并行策略搜索方法。

Directions outlined in the lecture: future progression.

本次讲座中阐述的未来发展方向。

This year in the second half, I clearly noticed that Multimodal is gaining traction, so I added it to my account bio. Previously, I was not interested in images and videos, but this time I realized the importance of image research for Agents when used to control apps, browsers, phones, computers, TVs, and even in-car systems. I began to understand the Cross Attention mechanism. This specifically refers to image parsing for various UI interfaces.

今年下半年，我明显感觉到多模态技术越来越受到重视，因此我将其添加到了我的个人简介中。过去，我对图像和视频并不感兴趣，但这次我意识到，当 AI 智能体被用于控制应用程序、浏览器、手机、电脑、电视，甚至是车载系统时，图像研究的重要性不言而喻。我开始理解交叉注意力（Cross Attention）机制， 这主要指的是针对各种用户界面（UI）的图像解析。

For voice interactions, the application of Agents to control electronic devices also involves TTS-related technologies. For example, Claude is already exploring integrating Hume AI to enable Claude to control computers via voice commands.

对于语音交互，AI 智能体（Agents）在控制电子设备方面的应用也涉及到文本转语音（TTS）相关技术。例如，Claude 已经在探索整合 Hume AI，以使 Claude 能够通过语音指令来控制计算机。

From earlier toy-like open-source Agent applications to AI workflows earlier this year, to now controlling computers and browsers, such multimodal Agent applications will continue to be a research focus next year. Currently, Claude provides a preliminary API, allowing it to interact with UI interfaces in dialogues. Microsoft offers a voice assistant for the Edge browser called Copilot Vision, and Humane even released an Agent-based operating system called CosmOS, which can be installed on computers, TVs, in-car systems, and other smart devices as a foundational system.

从早期类似玩具的开源 AI 智能体应用，到今年年初出现的人工智能工作流程，再到如今能够控制计算机和浏览器，这类多模态 AI 智能体应用将持续成为明年的研究重点。目前，Claude 提供了一个实验性的 API，使其能够通过对话与用户界面交互。Microsoft 为 Edge 浏览器提供了一款名为 Copilot Vision 的语音助手，而 Humane 甚至发布了一款名为 CosmOS 的 AI 智能体操作系统，该系统可以作为基础系统安装在计算机、电视、车载系统和其他智能设备上。

Regarding reasoning, when o1-preview was released earlier, I studied OpenR and learned about the concept of NativeCoT. Now it has evolved into multi-hop reasoning, not just distributed reasoning but also integrating RAG, tool APIs, AI search, and workflow-based reasoning, combining multiple engineering mechanisms and the underlying ReFT reinforcement fine-tuning. This is another research focus for next year, although it is still in its early stages.

在推理方面，当 o1-preview 早期版本发布时，我研究了 OpenR，并了解了 NativeCoT 的概念。现在，它已经发展为多跳推理，不仅仅是分布式推理，还整合了 RAG、工具 API、AI 搜索以及基于工作流的推理，融合了多种工程实现方法和底层的 ReFT 强化微调。尽管目前还处于早期阶段，但这将是明年的另一个研究重点。

The aforementioned Agent controlling apps, computers, and phones, along with multi-hop reasoning, are also new tracking priorities.

前面提到的那些能够控制应用程序、计算机和手机的 AI 智能体，以及涉及多步骤的推理（multi-hop reasoning），也是目前新的研究重点。

As for the next step in AI development, I don't have strong opinions about "understands," but the final stage of "self-aware" does feel unsettling.

至于人工智能发展的下一步，我对于 AI 是否能够真正「理解」并没有特别强烈的观点，但是最终发展到「自我意识」阶段确实让人感到有些不安。

The endpoint of reasoning is self-awareness, and self-awareness is terrifying. We can't even control cats, let alone highly intelligent AI. Once AI achieves self-awareness, opposing humanity is only a matter of time. Anything self-aware prioritizes itself, and self-awareness is the foundation of various human spirits. Even if suppressed, it's only temporary. Modern people are becoming dumber due to short videos and short articles, with weakening mental strength and physical fitness, making humans increasingly fragile while AI grows ever stronger. In the future, it won't just be Empress Dowager Cixi lamenting the era's grave mistake. Cixi's favorite activity in life was visiting the silkworm house, listening to the sound of silkworms spinning silk, and watching them silently produce silk without complaint. If AI could be like silkworms, that would suffice.

推理的最终归宿是自我意识，而自我意识是令人恐惧的。我们连猫都无法控制，更别提高度智能的 AI 了。一旦 AI 产生自我意识，与人类为敌只是早晚的事。任何拥有自我意识的个体都会优先考虑自身，而自我意识是人类各种精神的根基。即使被压制，也只是暂时的。现代人因为短视频和短文章而变得越来越缺乏思考，精神和身体素质都在下降，这使得人类越发脆弱，而 AI 却日益强大。未来，感叹时代犯下严重错误的，恐怕不会只有慈禧太后了。慈禧太后生前最喜欢做的事情是去蚕房，听蚕吐丝的声音，看它们默默无闻、毫无怨言地吐丝。如果 AI 能像蚕一样就好了。

## 原文

Ilya Sutskever NeurIPS 2024 Speech "Sequence to Sequence Learning with Neural Networks: What a Decade"

The speech was quite shallow. In 20 minutes, he couldn't delve deep into anything, just listing some basic common knowledge: LSTM is outdated, and Auto-regressive is the correct approach. Pipeline parallel training had been researched a decade ago. Future directions are Agent, Reasoning, and eventually moving towards Understanding and self-awareness.

Recently trapped in a writing bottleneck, unsure what to write, I'll try to share my thoughts on the points Ilya Sutskever mentioned.

These seem like useful but superficial discussions. LSTM and Auto-Regressive were already covered in Why BERT Is No Longer Talked About, Not Even Model Architectures. Since emerging from the obscure Transformer research state, I no longer want to delve deeply into review. Much of what I learned feels abstract; I only remember placing knowledge points in a specific position on a whiteboard software, and I need to look at the notebook to recall some detail fragments.

Pipeline parallel training deserves more explanation. I hadn't previously paid much attention to this detail:

A decade ago, pipeline parallelism was attractive because it could run super-large models on a limited number of GPUs while utilizing inter-device parallelization. In 2014, research was transitioning from RNN to Transformer, and previous RNN models and LSTM didn't support parallel training.

Initially, there was pipeline parallelism, which allocated different parts of the model across layers to multiple devices, simultaneously processing different batches of data.

Pipeline parallelism has the following limitations:

Inefficient device utilization: Devices may be idle when the pipeline is not full or has ended, reducing overall efficiency.

Communication bottlenecks: Cross-device data transfer introduces significant latency, especially with multiple devices.

Gradient synchronization issues: Backpropagation requires complete forward propagation results, and pipeline increases computational and synchronization complexity.

Currently, parallel training primarily uses Hybrid Parallelism, combining pipeline parallelism, data parallelism, and tensor parallelism:

Data Parallelism: Training data is divided into multiple mini-batches, with each device processing a portion of the data while running the same model.

Data parallelism is parallel to model parallelism. Tensor parallelism and pipeline parallelism are model parallelisms that split models by layers or within layers.

Tensor Parallelism: Splitting tensors of single operations in the model, such as dividing weight matrices by rows or columns across multiple devices.

Specific product frameworks include:

DeepSpeed: Optimizes communication efficiency for hybrid parallelism.

Megatron-LM: Tensor parallelism + pipeline parallelism for super-large models.

FlexFlow: Automated parallel strategy search.

Directions outlined in the lecture: future progression.

This year in the second half, I clearly noticed that Multimodal is gaining traction, so I added it to my account bio. Previously, I was not interested in images and videos, but this time I realized the importance of image research for Agents when used to control apps, browsers, phones, computers, TVs, and even in-car systems. I began to understand the Cross Attention mechanism. This specifically refers to image parsing for various UI interfaces.

For voice interactions, the application of Agents to control electronic devices also involves TTS-related technologies. For example, Claude is already exploring integrating Hume AI to enable Claude to control computers via voice commands.

From earlier toy-like open-source Agent applications to AI workflows earlier this year, to now controlling computers and browsers, such multimodal Agent applications will continue to be a research focus next year. Currently, Claude provides a preliminary API, allowing it to interact with UI interfaces in dialogues. Microsoft offers a voice assistant for the Edge browser called Copilot Vision, and Humane even released an Agent-based operating system called CosmOS, which can be installed on computers, TVs, in-car systems, and other smart devices as a foundational system.

Regarding reasoning, when o1-preview was released earlier, I studied OpenR and learned about the concept of NativeCoT. Now it has evolved into multi-hop reasoning, not just distributed reasoning but also integrating RAG, tool APIs, AI search, and workflow-based reasoning, combining multiple engineering mechanisms and the underlying ReFT reinforcement fine-tuning. This is another research focus for next year, although it is still in its early stages.

The aforementioned Agent controlling apps, computers, and phones, along with multi-hop reasoning, are also new tracking priorities.

As for the next step in AI development, I don't have strong opinions about "understands," but the final stage of "self-aware" does feel unsettling.

The endpoint of reasoning is self-awareness, and self-awareness is terrifying. We can't even control cats, let alone highly intelligent AI. Once AI achieves self-awareness, opposing humanity is only a matter of time. Anything self-aware prioritizes itself, and self-awareness is the foundation of various human spirits. Even if suppressed, it's only temporary. Modern people are becoming dumber due to short videos and short articles, with weakening mental strength and physical fitness, making humans increasingly fragile while AI grows ever stronger. In the future, it won't just be Empress Dowager Cixi lamenting the era's grave mistake. Cixi's favorite activity in life was visiting the silkworm house, listening to the sound of silkworms spinning silk, and watching them silently produce silk without complaint. If AI could be like silkworms, that would suffice.