## 20250110Beginners-Guide-to-Transformers-Understanding-the-Basic-Framework

[Beginner’s Guide to Transformers : Understanding the Basic Framework | by Joyce Birkins | Medium](https://medium.com/@joycebirkins/beginners-guide-to-transformers-understanding-the-basic-framework-75f2aef0b75b)

Beginner’s Guide to Transformers: Understanding the Basic Framework
Joyce Birkins

Jul 16, 2024

After finishing the last article, Monthly Salary Starting at 50K! Five Key Insights for AI Product Managers, I immediately downloaded over twenty AI papers and started reading the most classic and fundamental one in the AI field from recent years, Attention is All You Need.

完成上一篇《月薪 5 万起！AI 产品经理的五项关键洞察》之后，我随即下载了二十余篇 AI 论文，并开始研读近年来 AI 领域最经典和基础的论文之一：《Attention is All You Need》。

Previously, I had a confusing understanding of concepts like RNN, CNN, and Transformers. Through reading this paper and researching each point, I have gained a clearer understanding.

以前，我对循环神经网络（RNN)、卷积神经网络（CNN）和 Transformer 等概念的理解一直很模糊。但通过阅读这篇论文，并仔细研究了其中的每一个要点，我终于对这些概念有了更清晰的认识。

This article is based on my perspective as a humanities student to understand the various mechanisms related to Transformers. It provides a general understanding without complex mathematical formulas and abstract code.

这篇文章从我一个人文科学学生的角度出发，尝试理解 Transformer 的各种工作原理。文章会提供一个大致的理解，不涉及复杂的数学公式和抽象的代码。

[Monthly Salary Starting at 50K! Five Key Insights for AI Product Managers | by Joyce Birkins | Medium](https://medium.com/@joycebirkins/monthly-salary-starting-at-50k-five-key-insights-for-ai-product-managers-8c7a0a66582b)

### 01. Sequence Transduction

序列转换

Sequence Transduction tasks/models are comparable to the overarching concept of neural networks. Most AI models and the fields they are implemented in belong to Sequence Transduction.

序列转换任务/模型可以类比为神经网络的通用概念。大多数 AI 模型及其所应用的领域都属于序列转换。

In computer science and mathematics, transduction refers to the process of converting one form or state of something into another.

在计算机科学和数学中，转导（transduction）指的是将数据或信息的一种形式或状态转换为另一种形式或状态的过程。

In natural language processing, sequence transduction refers to converting one sequence into another, such as translating text from one language to another, machine translation, text to speech (TTS), video/image captioning, named entity recognition (NER), text summarization, question answering, and more. All of these fall under Sequence Transduction tasks.

在自然语言处理中，序列转导（sequence transduction）指的是将一个序列转换为另一个序列，例如：将文本从一种语言翻译成另一种语言（机器翻译），文本转语音（TTS），视频/图像字幕生成，命名实体识别（NER），文本摘要，问题解答等。这些都属于序列转导任务。

The common architecture of Sequence Transduction Models is the encoder-decoder structure. These models are autoregressive, meaning they use previously generated symbols as additional input when generating the next symbol. Sequence Transduction Models include those using the Attention mechanism like Transformers, RNN-based seq2seq, and some CNN-based models like ByteNet, SliceNet, ConvS2S.

序列转换模型（Sequence Transduction Models）的通用架构是编码器-解码器结构。这些模型是自回归的，也就是说，它们在生成下一个符号时，会把之前生成的符号作为额外的输入。序列转换模型包括使用了注意力机制（Attention mechanism）的模型，例如 Transformer、基于循环神经网络（RNN）的 seq2seq 模型（一种序列到序列的模型），以及一些基于卷积神经网络（CNN）的模型，例如 ByteNet、SliceNet 和 ConvS2S。

### 02. Transformer >> Attention

Transformer >> 注意力机制

Transformers use the Attention mechanism instead of RNN or CNN. Transformers are a type of model (including specific models like generative pre-trained Transformers, or GPT, and bidirectional encoding representative Transformers, or BERT), focusing on the model itself. The concept comparable to RNN and CNN is Attention.

Transformer 使用注意力机制（Attention mechanism）而不是 RNN 或 CNN。Transformer 是一种模型架构（包括像生成式预训练 Transformer，或 GPT，和双向编码代表 Transformer，或 BERT 这样的特定模型），它专注于模型本身。与 RNN 和 CNN 相当的概念是注意力机制（Attention mechanism）。

Other transformer models optimized for performance include DeiT, PVT, Swin, and Cswin.

其他为了优化性能而设计的 Transformer 模型包括 DeiT、PVT、Swin 和 Cswin。

After tracking AI for almost two years, I only recently understood these basic concepts.

在关注 AI 技术近两年后，我最近才理解了这些基本概念。

Before Google proposed Attention in 2017, most Sequence Transduction tasks were solved using RNNs, often combining RNN with the Attention mechanism.

在 Google 于 2017 年提出注意力机制之前，大多数序列转换任务都是使用 RNN 解决的，通常是 RNN 再加上注意力机制。

Transformers use only Attention without CNN or RNN to model the global dependencies between input and output, making training faster, more accurate, and less costly.

Transformer 仅使用注意力机制，而无需 CNN 或 RNN 来理解输入和输出之间的整体联系，这使得训练过程更快、结果更准确，也更省资源。

Unlike RNNs and CNNs, which compute the distance in input or output sequences, RNNs combine all previously processed vectors with the current word/vector because RNNs are cyclic, allowing information to circulate within the network. This structure enables RNNs to retain previous input information for current output computation. Self-Attention integrates the understanding of all relevant words into the word being processed.

与循环神经网络（RNN）和卷积神经网络（CNN）在输入或输出序列中计算距离的方式不同，循环神经网络会将之前处理过的所有向量与当前的词/向量结合起来。这是因为循环神经网络是循环结构，允许信息在网络内部循环传递。这种结构使得循环神经网络能够保留之前的输入信息，以便用于当前的输出计算。自注意力机制则会将所有相关词语的理解融入到当前正在处理的词语中。

Regarding cycles, a key concept is the feed forward network (FFN). Apart from RNN, all are linear FNNs, including CNNs, MLPs, and perceptrons. These don’t require cycles, and this network is an important module in the upcoming Transformer architecture diagram to enhance the model’s understanding of the information itself.

在循环方面，一个关键概念是前馈网络（feed forward network，FFN）。除了循环神经网络（RNN）之外，包括卷积神经网络（CNN)、多层感知器（MLP）和感知器在内的其他网络，都属于线性前馈网络。这些网络不需要循环结构。前馈网络是即将出现的 Transformer 架构中的一个重要模块，它能提升模型对信息本身的理解能力。

### 03. How Attention Works

注意力机制的工作原理

1 Calculate attention weights: Scores are computed for each input based on the hidden state vectors and the current decoder state, yielding attention weights.

计算注意力权重：基于隐藏状态向量和当前解码器状态，计算每个输入的得分，得到注意力权重。

2 Generate context vector: Using the attention weights, a weighted sum of the input hidden state vectors is computed to create a context vector.

生成上下文向量：使用注意力权重，对输入隐藏状态向量进行加权求和，以创建上下文向量。

Transformers primarily rely on self-attention and multi-head attention.

Transformer 主要使用自注意力机制和多头注意力机制。

Self-Attention: In self-attention, the model establishes relationships between different positions in the same sequence to capture dependencies and semantic information among words, focusing on relationships between words without intrinsic meaning.

自注意力（Self-Attention)：在自注意力机制中，模型会在同一序列的不同位置之间建立联系，从而捕捉单词之间的依赖关系和语义信息。它主要关注的是词与词之间的相互关系，而不是词本身固有的含义。

Multi-Head Attention: This key component in Transformer models applies multiple attention mechanisms in parallel to capture different relationships and features, combining these representations to form a comprehensive attention representation. Each “head” learns different representations and merges them for an integrated attention output.

多头注意力机制（Multi-Head Attention)：这是 Transformer 模型中的关键部分，它同时应用多个注意力机制，以捕捉不同方面的关系和特征，并将这些表示组合，形成一个更全面的注意力表示。每个「头」学习不同的信息表示，然后合并这些信息，得到最终的注意力输出。

Simply put, several self-attentions for a task form multi-head attention, with each mechanism called a head. These can be stacked in layers.

简单来说，对于一个任务，多个自注意力机制组合形成多头注意力，其中每个机制称为一个头。这些头可以逐层堆叠。

Attention is divided into additive attention (mainly for seq2seq) and multiplicative (dot product) attention (mainly for transformers), calculating different sequence elements’ relevance/weight.

注意力机制分为加性注意力（additive attention）(主要用于 seq2seq 模型）和乘性（点积）注意力（multiplicative（dot product）attention）(主要用于 Transformer），用于计算不同序列元素之间的相关性。

Dot Product: query·key·value

点积：query·key·value

In a sequence transduction task, there are inputs to be transduced and desired outputs. Input is query, and the output needs to calculate the model’s existing knowledge base’s key-value pairs. Multi-head Attention calculates multiple relevances as a whole before output.

在序列转换任务中，我们需要将输入转换为期望的输出。这里的输入是 query，而输出则需要根据模型已有的知识库中的 key-value 对来计算。多头注意力机制会在输出结果之前，综合计算多个 query 和 key 之间的相关性。

### 04. Transformer Architecture

The classic Transformer architecture diagram is from Google’s Attention is All You Need paper. I’ll explain the modules in this diagram.

Transformer 架构经典的 Transformer 架构图来自 Google 的《Attention is All You Need》论文。我将解释这个图表中的各个模块。

From bottom to top, the left side is the encoder module for the input, and the right side is the decoder module that looks up and outputs based on the input.

从下往上，左侧是处理输入的编码器模块，右侧是解码器模块，它根据输入进行查找并产生输出。

The first step is embedding, converting to hidden vectors, with position encoding added because Transformers inherently lack the ability to parse input sequence order. A module is needed to make Transformers understand input-output sequences, unlike RNN or CNN models that calculate input-output distance and come with sequence parsing capability.

第一步是嵌入（embedding），将输入转换为隐藏向量。由于 Transformer 本身不具备解析输入序列顺序的能力，因此需要添加位置编码（position encoding）。为了让 Transformer 理解输入输出序列，需要一个额外的模块。这与循环神经网络（RNN）或卷积神经网络（CNN）模型不同，后者可以通过计算输入输出的距离来解析序列信息。

Masked Multi-Head Attention: Prevents the decoder from parsing content beyond the i-th position, ensuring the i-th position’s output probability is based on content before the i-th position, requiring the previously mentioned positional encoding.

掩码多头注意力（Masked Multi-Head Attention）：它能防止解码器分析第 i 个位置之后的信息，从而确保第 i 个位置的输出概率仅取决于其之前的内容，这需要用到前面提到过的位置编码。

Specifically, when the model generates a word, it can only see the content before that word, not the content after. This ensures the model generates sentences step-by-step, seeing only the already generated parts and not the future parts.

具体来说，当模型生成一个词时，它只能看到这个词之前的内容，而无法看到之后的内容。这确保了模型逐词生成句子，在生成过程中，它只能访问已经生成的部分，而不能访问尚未生成的部分。

For instance, if you write a sentence: “I am Bojinsi.” When the model generates the first word “I,” it doesn’t know the rest. Generating the second word “am,” it only sees “I,” not the rest. This way, the model generates each word based on the previously generated content.

举个例子，如果你写下句子：「我是 Bojinsi」。当模型生成第一个词「我」时，它并不知道后面的内容。在生成第二个词「是」时，它只看到了「我」，而不知道后面的词。这样，模型就是根据已经生成的内容来逐个生成单词的。

The next word is a probability issue. The output probabilities for the next word follow the output at the top. The AI-generated content is probabilistic, as discussed in the previous article on AI’s probabilistic nature and differing requirements and standards between product managers and users.

接下来要讨论的是概率问题。AI 生成内容时，下一个词的输出概率会受到之前输出的影响。正如之前文章讨论的，AI 的本质是概率性的，这导致产品经理和用户对 AI 生成内容的要求和标准有所不同，而 AI 生成的内容也因此具有概率性。

The entire model consists of Multi-Head Attention and feed-forward networks. Attention handles the sequence’s relationships but doesn’t understand the sequence itself. Therefore, a feed-forward network is needed to understand the sequence’s intrinsic meaning. For example, if the input sequence is a sentence, the FFN needs to understand each character/word’s features, information, and meaning, while Attention handles relationships between these elements.

整个模型由多头注意力（Multi-Head Attention）和前馈网络（feed-forward networks）构成。注意力机制负责处理序列中各个元素之间的关联，但它本身并不理解序列的实际内容。因此，我们需要前馈网络来理解序列的内在含义。举例来说，如果输入的序列是一句话，那么前馈网络需要理解每个字或词的特点、信息和意义，而注意力机制则负责处理这些字词之间的相互关系。

The FFN here is fully connected layers, meaning all nodes from the previous multi-head attention mechanism are fully transmitted to the FFN, each network node connecting to the previous layer. This means multi-head attention learns sequence part relationships, followed by feed-forward understanding each part’s specific meaning.

这里的 FFN（Feed-Forward Network）是全连接层，意味着来自之前的多头注意力（multi-head attention）机制的所有节点都被完全传递到 FFN 中，每个网络节点都与前一层相连。这意味着多头注意力学习序列各部分之间的关系，然后通过前馈网络来理解每个部分的具体含义。

Both models have add&norm to create residual connections, reducing training issues like vanishing gradient problems. Both attention and feed-forward neural networks need this.

两个模型都使用了「加和归一化」（add&norm）来构建残差连接，这有助于减少训练过程中诸如梯度消失之类的问题。无论是 Attention 机制还是前馈神经网络，都需要使用这种残差连接。

After decoding, there are linear and softmax modules. These convert the decoder’s code/numbers/vectors into the desired output, such as natural language/text, images, or audio. In TTS, it converts to audio, and for video content summaries, it outputs text.

在解码过程之后，会使用线性模块和 softmax 模块（linear and softmax modules）。这些模块将解码器的输出转换成所需的格式，例如自然语言/文本、图像或音频。在文本转语音（TTS）中，解码器的输出会被转换成音频；对于视频内容摘要，则输出文本。

Details of linear and softmax:

线性和 softmax 的细节：

The linear transformation layer is a simple fully connected neural network projecting vectors from the decoding component into a much larger vector called logits. If our model learns 10,000 different English words from the training set (our model’s “output vocabulary”), the logits become a vector of 10,000 units, each corresponding to a word’s score.

线性变换层是一个简单的全连接神经网络，它将解码部分的向量投射到一个更大的向量，这个向量被称为 logits（也称为逻辑值）。如果我们的模型从训练集中学习了 10,000 个不同的英语单词（我们模型的「输出词汇表」），那么 logits 就变成一个具有 10,000 个单元的向量，其中每个单元代表一个单词的分数。

The Softmax layer turns these scores into probabilities (all positive, capped at 1.0). The highest probability unit is selected, and its corresponding word is the output for that time step.

Softmax 层（Softmax layer）将这些得分（score）转化为概率值（均为正值，最大值为 1.0）。选择概率值最高的那个单元，它对应的词就是该时间步的输出。

Softmax squares computation, slower but more effective. Linear computation is faster but less accurate.

Softmax 的平方计算方式，虽然较慢但效果更好。线性函数计算速度较快，但精度稍逊。

There are papers specifically on softmax and linear, proposing an Agent Attention to address their issues. However, this is beyond the scope of this article, so it’s only mentioned briefly.

有一些论文专门研究了 softmax 和线性计算，并提出了一种智能体注意力机制（Agent Attention）来解决它们各自存在的问题。不过，这超出了本文的讨论范围，因此这里仅做简单提及。

### 05. Neural Network

神经网络

The overarching concept is the Neural Network. Its basic components are shown in the diagram: input, output, and hidden layers.

神经网络是核心概念。它的基本组成部分包括：输入层、输出层和隐藏层。

Everything above falls within the neural network domain. RNN and CNN are traditional neural network mechanisms. Attention also belongs to this mechanism, dynamically assigning different weights based on the importance of different input parts to more effectively capture key information from the input data and output valid information.

以上这些都属于神经网络的范畴。循环神经网络（RNN）和卷积神经网络（CNN）是传统的神经网络机制。注意力机制也属于神经网络机制，它会根据不同输入部分的重要性动态分配不同的权重，以便更有效地从输入数据中捕获关键信息，并输出有效信息。

Isn’t this what is often discussed with large models — weights based on Attention? It mainly allocates attention to more important parts, involving training and fine-tuning.

这不正是大型模型中经常讨论的吗 —— 基于注意力机制（Attention Mechanism）的权重？其核心在于将注意力分配给更重要的部分，并且需要经过训练和微调。

The encoder and decoder in the previous section belong to the hidden layers here, starting computations through embedding hidden vectors.

前一节提到的编码器和解码器，实际上是这里的隐藏层，它们通过嵌入（embedding）隐藏向量来启动计算。

A brief introduction to RNN and CNN:

循环神经网络（RNN）和卷积神经网络（CNN）的简要介绍：

Recurrent Neural Networks (RNNs) are neural network structures particularly suitable for handling sequential data. RNNs introduce cyclic connections within the network, allowing information to be transmitted between different time steps in a sequence. This capability makes RNNs effective for processing time series data and sequence tasks.

循环神经网络（RNNs，Recurrent Neural Networks）是一种特别适合处理序列数据的神经网络结构。循环神经网络在网络中引入循环连接，使得信息可以在序列的不同时间步之间传递。这种特性使得循环神经网络在处理时间序列数据和序列任务时非常有效。

Sequence-to-Sequence (Seq2Seq) Models consist of two RNNs. Typically, an attention mechanism is added to the decoder, enabling it to flexibly focus on different parts of the input sequence.

Seq2Seq（Sequence-to-Sequence）模型由两个 RNN（Recurrent Neural Network）组成。通常，会在解码器中添加注意力机制（attention mechanism），使其能够灵活地关注输入序列的不同部分。

Convolutional Neural Networks (CNNs) appear less frequently in Sequence Transduction tasks compared to RNNs and Transformers, being more commonly used in AI image and video applications.

卷积神经网络（CNN）在序列转换任务中的应用不如循环神经网络（RNN）和 Transformer 广泛，它更常用于 AI 图像和视频处理。

CNNs are specialized for processing data with grid-like topology, such as images and videos. They introduce convolution and pooling layers to effectively capture local features in spatial structures, making them particularly suitable for handling two-dimensional image data.

CNN（Convolutional Neural Networks）专门用于处理具有网格状结构的数据，比如图像和视频。它们通过引入卷积层和池化层，有效地捕捉图像中相邻区域的特征，这使得 CNN 特别适合处理二维图像数据。

The hierarchical structure of CNNs allows them to progressively extract information from low-level features to high-level semantic features. This step-by-step feature extraction and combination have led to significant success in computer vision tasks. Variants of CNNs, such as ResNet and Inception, are widely used in various image processing tasks.

卷积神经网络（CNNs）的分层结构使其能够逐步地从低级特征中提取信息，并将其转化为高级语义特征。这种逐步的特征提取与组合已经在计算机视觉任务中取得了显著的成功。卷积神经网络的变体，例如 ResNet 和 Inception，被广泛应用于各种图像处理任务中。

### 06. Conclusion

To better understand and construct these foundational AI technologies, consider using a large whiteboard for free-form layout and content addition. I used Freeform to conceptualize this article’s material and structure, which is different from the traditional linear document writing.

为了更好地理解并构建这些基础 AI 技术，可以考虑使用大型白板来进行自由布局和添加内容。我使用 Freeform 来构思本文的材料和结构，这与传统的线性文档写作方式有所不同。

AI technology encompasses numerous concepts and products. A neural network alone involves many elements, making it essential to use a whiteboard for thorough structure organization to retain information.

人工智能技术涵盖了众多概念和产品。仅仅一个神经网络就包含了许多组成部分，因此需要借助白板进行详细的结构梳理，以便更好地理解和记忆相关信息。

## 原文

Beginner’s Guide to Transformers: Understanding the Basic Framework
Joyce Birkins

Jul 16, 2024

After finishing the last article, Monthly Salary Starting at 50K! Five Key Insights for AI Product Managers, I immediately downloaded over twenty AI papers and started reading the most classic and fundamental one in the AI field from recent years, Attention is All You Need.

Previously, I had a confusing understanding of concepts like RNN, CNN, and Transformers. Through reading this paper and researching each point, I have gained a clearer understanding.

This article is based on my perspective as a humanities student to understand the various mechanisms related to Transformers. It provides a general understanding without complex mathematical formulas and abstract code.


01 Sequence Transduction
Sequence Transduction tasks/models are comparable to the overarching concept of neural networks. Most AI models and the fields they are implemented in belong to Sequence Transduction.

In computer science and mathematics, transduction refers to the process of converting one form or state of something into another.

In natural language processing, sequence transduction refers to converting one sequence into another, such as translating text from one language to another, machine translation, text to speech (TTS), video/image captioning, named entity recognition (NER), text summarization, question answering, and more. All of these fall under Sequence Transduction tasks.

The common architecture of Sequence Transduction Models is the encoder-decoder structure. These models are autoregressive, meaning they use previously generated symbols as additional input when generating the next symbol. Sequence Transduction Models include those using the Attention mechanism like Transformers, RNN-based seq2seq, and some CNN-based models like ByteNet, SliceNet, ConvS2S.

Transformer >> Attention
Transformers use the Attention mechanism instead of RNN or CNN. Transformers are a type of model (including specific models like generative pre-trained Transformers, or GPT, and bidirectional encoding representative Transformers, or BERT), focusing on the model itself. The concept comparable to RNN and CNN is Attention.

Other transformer models optimized for performance include DeiT, PVT, Swin, and Cswin.

After tracking AI for almost two years, I only recently understood these basic concepts.

Before Google proposed Attention in 2017, most Sequence Transduction tasks were solved using RNNs, often combining RNN with the Attention mechanism.

Transformers use only Attention without CNN or RNN to model the global dependencies between input and output, making training faster, more accurate, and less costly.

Unlike RNNs and CNNs, which compute the distance in input or output sequences, RNNs combine all previously processed vectors with the current word/vector because RNNs are cyclic, allowing information to circulate within the network. This structure enables RNNs to retain previous input information for current output computation. Self-Attention integrates the understanding of all relevant words into the word being processed.

Regarding cycles, a key concept is the feed forward network (FFN). Apart from RNN, all are linear FNNs, including CNNs, MLPs, and perceptrons. These don’t require cycles, and this network is an important module in the upcoming Transformer architecture diagram to enhance the model’s understanding of the information itself.

How Attention Works
Calculate attention weights: Scores are computed for each input based on the hidden state vectors and the current decoder state, yielding attention weights.
Generate context vector: Using the attention weights, a weighted sum of the input hidden state vectors is computed to create a context vector.
Transformers primarily rely on self-attention and multi-head attention.

Self-Attention: In self-attention, the model establishes relationships between different positions in the same sequence to capture dependencies and semantic information among words, focusing on relationships between words without intrinsic meaning.

Multi-Head Attention: This key component in Transformer models applies multiple attention mechanisms in parallel to capture different relationships and features, combining these representations to form a comprehensive attention representation. Each “head” learns different representations and merges them for an integrated attention output.

Simply put, several self-attentions for a task form multi-head attention, with each mechanism called a head. These can be stacked in layers.

Attention is divided into additive attention (mainly for seq2seq) and multiplicative (dot product) attention (mainly for transformers), calculating different sequence elements’ relevance/weight.

Dot Product: query·key·value

In a sequence transduction task, there are inputs to be transduced and desired outputs. Input is query, and the output needs to calculate the model’s existing knowledge base’s key-value pairs. Multi-head Attention calculates multiple relevances as a whole before output.


Transformer Architecture
The classic Transformer architecture diagram is from Google’s Attention is All You Need paper. I’ll explain the modules in this diagram.

From bottom to top, the left side is the encoder module for the input, and the right side is the decoder module that looks up and outputs based on the input.

The first step is embedding, converting to hidden vectors, with position encoding added because Transformers inherently lack the ability to parse input sequence order. A module is needed to make Transformers understand input-output sequences, unlike RNN or CNN models that calculate input-output distance and come with sequence parsing capability.

Masked Multi-Head Attention: Prevents the decoder from parsing content beyond the i-th position, ensuring the i-th position’s output probability is based on content before the i-th position, requiring the previously mentioned positional encoding.

Specifically, when the model generates a word, it can only see the content before that word, not the content after. This ensures the model generates sentences step-by-step, seeing only the already generated parts and not the future parts.

For instance, if you write a sentence: “I am Bojinsi.” When the model generates the first word “I,” it doesn’t know the rest. Generating the second word “am,” it only sees “I,” not the rest. This way, the model generates each word based on the previously generated content.

The next word is a probability issue. The output probabilities for the next word follow the output at the top. The AI-generated content is probabilistic, as discussed in the previous article on AI’s probabilistic nature and differing requirements and standards between product managers and users.

The entire model consists of Multi-Head Attention and feed-forward networks. Attention handles the sequence’s relationships but doesn’t understand the sequence itself. Therefore, a feed-forward network is needed to understand the sequence’s intrinsic meaning. For example, if the input sequence is a sentence, the FFN needs to understand each character/word’s features, information, and meaning, while Attention handles relationships between these elements.

The FFN here is fully connected layers, meaning all nodes from the previous multi-head attention mechanism are fully transmitted to the FFN, each network node connecting to the previous layer. This means multi-head attention learns sequence part relationships, followed by feed-forward understanding each part’s specific meaning.

Both models have add&norm to create residual connections, reducing training issues like vanishing gradient problems. Both attention and feed-forward neural networks need this.


After decoding, there are linear and softmax modules. These convert the decoder’s code/numbers/vectors into the desired output, such as natural language/text, images, or audio. In TTS, it converts to audio, and for video content summaries, it outputs text.

Details of linear and softmax:

The linear transformation layer is a simple fully connected neural network projecting vectors from the decoding component into a much larger vector called logits. If our model learns 10,000 different English words from the training set (our model’s “output vocabulary”), the logits become a vector of 10,000 units, each corresponding to a word’s score.

The Softmax layer turns these scores into probabilities (all positive, capped at 1.0). The highest probability unit is selected, and its corresponding word is the output for that time step.


Softmax squares computation, slower but more effective. Linear computation is faster but less accurate.

There are papers specifically on softmax and linear, proposing an Agent Attention to address their issues. However, this is beyond the scope of this article, so it’s only mentioned briefly.

Neural Network
The overarching concept is the Neural Network. Its basic components are shown in the diagram: input, output, and hidden layers.


Everything above falls within the neural network domain. RNN and CNN are traditional neural network mechanisms. Attention also belongs to this mechanism, dynamically assigning different weights based on the importance of different input parts to more effectively capture key information from the input data and output valid information.

Isn’t this what is often discussed with large models — weights based on Attention? It mainly allocates attention to more important parts, involving training and fine-tuning.

The encoder and decoder in the previous section belong to the hidden layers here, starting computations through embedding hidden vectors.

A brief introduction to RNN and CNN:

Recurrent Neural Networks (RNNs) are neural network structures particularly suitable for handling sequential data. RNNs introduce cyclic connections within the network, allowing information to be transmitted between different time steps in a sequence. This capability makes RNNs effective for processing time series data and sequence tasks.

Sequence-to-Sequence (Seq2Seq) Models consist of two RNNs. Typically, an attention mechanism is added to the decoder, enabling it to flexibly focus on different parts of the input sequence.

Convolutional Neural Networks (CNNs) appear less frequently in Sequence Transduction tasks compared to RNNs and Transformers, being more commonly used in AI image and video applications.

CNNs are specialized for processing data with grid-like topology, such as images and videos. They introduce convolution and pooling layers to effectively capture local features in spatial structures, making them particularly suitable for handling two-dimensional image data.

The hierarchical structure of CNNs allows them to progressively extract information from low-level features to high-level semantic features. This step-by-step feature extraction and combination have led to significant success in computer vision tasks. Variants of CNNs, such as ResNet and Inception, are widely used in various image processing tasks.

Conclusion
To better understand and construct these foundational AI technologies, consider using a large whiteboard for free-form layout and content addition. I used Freeform to conceptualize this article’s material and structure, which is different from the traditional linear document writing.

AI technology encompasses numerous concepts and products. A neural network alone involves many elements, making it essential to use a whiteboard for thorough structure organization to retain information.