## 20250108Byte-Latent-Transformer-Changing-How-We-Train-LLMs

Byte Latent Transformer: Changing How We Train LLMs

2025-01-06

Vishal Rajput

Published in AIGuys

We all know that computers can't read text, what they read are numbers. All the text is converted into numbers using different strategies and fed to the computers. But what about AI, can't LLMs read and write a text? No, they read and write tokens. Tokens are a way to represent text, which are the fundamental units of text used to process and generate language. Tokens can represent characters, subwords, words, or even punctuation, depending on how the language model's tokenizer works.

我们都知道，计算机本身无法直接理解文本，它们处理的是数字。所有的文本都需要通过不同的方法转换成数字，才能被计算机读取。那么，AI，特别是大语言模型（LLM），难道可以直接读取和书写文本吗？ 答案是否定的，它们实际上读取和书写的是 Token（Token）。Token 是一种文本的表示方式，是用于处理和生成语言的基本单元。根据语言模型所使用的分词器（tokenizer）的不同，Token 可以代表字符、子词、单词，甚至是标点符号。

However, new work from Meta's FAIR lab is challenging the well-established paradigm of tokens in LLM space, and it has developed a thing called Patches and Byte Latent Transformer. So, without further ado, let's go deep into this new paper.

不过，Meta 公司 FAIR 实验室的最新研究正在挑战大语言模型（LLM）领域中已被广泛接受的 Token 机制，他们开发了一种名为 Patches 和 Byte Latent Transformer 的新方法。接下来，让我们深入探讨这篇新论文。

### Tokens and Tokenization

A token is a segment of text that the model processes as a single unit.

一个 Token 是模型将其视为一个单独单元进行处理的文本片段。

For example:

Word-based tokenization: "Artificial Intelligence" → ["Artificial", "Intelligence"]

基于词的 Token 化：「Artificial Intelligence」转换为 [「人工智能」]

Subword tokenization: "Artificial Intelligence" → ["Art", "ificial", "Int", "elligence"]

Character-based tokenization: "Artificial Intelligence" → ["A", "r", "t", "i", ...]

子词标记化（Subword tokenization)："Artificial Intelligence」变为 ["Art」，"ificial」，"Int」，"elligence"]

基于字符的标记化（Character-based tokenization)："Artificial Intelligence」变为 ["A」，"r」，"t」，"i」，...]

Most modern LLMs like GPT, Claude, or any other Transformer model use subword tokenization (e.g., Byte Pair Encoding or SentencePiece) to handle out-of-vocabulary words efficiently.

大多数现代大语言模型（LLM），例如 GPT、Claude 或者其他任何 Transformer 模型，都采用子词分词（subword tokenization）技术（例如，字节对编码（Byte Pair Encoding）或 SentencePiece），以便高效地处理词汇表中未出现的词。

Example (using GPT-like tokenization):

Input: "Hello, world!"

你好，世界！

Tokenized Output: [15496, 11, 995]

"Hello" → 15496

Token 序列：[15496，11，995]

"Hello」对应 15496

"," → 11

"world" → 995

未找到意译内容

Input Representation: To do any processing, the model converts raw text into tokens. These tokens are later mapped to embeddings (numerical representations) for computation.

输入数据的表示方式：为了进行处理，模型会将原始文本分解成 Token（Token）。这些 Token 会被进一步转换成嵌入（用数值表示），以便进行计算。

Output Generation: When generating text, LLMs produce tokens in an autoregressive fashion (one at a time), which are then decoded back into human-readable text.

输出生成：在生成文本时，LLM 以自回归的方式（每次生成一个）生成 Token，然后将这些 Token 解码为人类可读的文本。

### Tokenization Algorithms

Byte Pair Encoding (BPE)

### 文本标记化算法字节对编码（Byte Pair Encoding，BPE)

Breaks words into subwords based on frequency. Suppose the data to be encoded is

aaabdaaabac

根据词频将单词拆分成子词。例如，待编码的数据如下：

aaabdaaabac

The byte pair "aa" occurs most often, so it will be replaced by a byte that is not used in the data, such as "Z". Now there is the following data and replacement table:

字节对「aa」出现的频率最高，所以会被替换成一个数据中未使用的字节，比如「Z」。现在，我们有以下的数据和替换表：

ZabdZabac

Z=aa

ZabdZabac

Z=aa

Then the process is repeated with byte pair "ab", replacing it with "Y":

ZYdZYac

接下来，针对字符串「ZYdZYac」，重复上述过程，将字节对「ab」替换为「Y"：

ZYdZYac

Y=ab

Z=aa

Y=ab

Z=aa

The only literal byte pair left occurs only once, and the encoding might stop here. Alternatively, the process could continue with recursive byte pair encoding, replacing "ZY" with "X":

剩下的唯一一个原始字节对仅出现一次，编码到此可能就结束了。或者，这个过程可以继续进行递归的字节对编码，也就是将「ZY」替换为「X」：

XdXac

X=ZY

XdXac

X=ZY

Y=ab

Z=aa

Y=ab

Z=aa

This data cannot be compressed further by byte pair encoding because there are no pairs of bytes that occur more than once.

To decompress the data, simply perform the replacements in the reverse order.

当前数据无法通过字节对编码（byte pair encoding）进一步压缩，因为其中不存在重复出现的字节对。

要解压缩数据，只需按照替换的逆序执行即可。

So, what's the problem with BPE? It can have instances where there is more than one way to encode a particular word. It then gets difficult for the algorithm to choose subword tokens as there is no way to prioritize which one to use first. Hence, the same input can be represented by different encodings impacting the accuracy of the learned representations.

那么，字节对编码（BPE）有什么问题呢？它可能会出现一个单词有多种编码方式的情况。这时，算法就难以选择合适的子词 Token，因为没有明确的规则来决定优先使用哪一个。因此，同样的输入可能会被编码成不同的形式，这会影响模型学习到的特征表示的准确性。

WordPiece

Similar to BPE but optimized for maximum likelihood estimation.

WordPiece

与 BPE 类似，但它针对最大似然估计进行了优化。

The only difference between WordPiece and BPE is the way in which symbol pairs are added to the vocabulary. At each iterative step, WordPiece chooses a symbol pair which will result in the largest increase in likelihood upon merging. Maximizing the likelihood of the training data is equivalent to finding the symbol pair whose probability divided by the probability of the first followed by the probability of the second symbol in the pair is greater than any other symbol pair.

WordPiece 和 BPE 之间唯一的区别在于如何将符号对添加到词汇表中。在每次迭代中，WordPiece 会选择合并后能使似然性增加最大的符号对。最大化训练数据的似然性，等价于找到这样一个符号对：它的概率除以该对中第一个符号的概率和第二个符号的概率的乘积，得到的结果要大于任何其他符号对。

WordPiece starts with a fixed initial vocabulary. This usually includes:

Single characters: ["u", "n", "h", "a", "p", "i", "e", "s"]

WordPiece 从一个固定的初始词汇表开始。例如，它通常包括：

单个字符：["u」，"n」，"h」，"a」，"p」，"i」，"e」，"s"]

A special symbol to indicate subword continuation: ## (e.g., ##ness)

Common words or frequent subwords: ["happy", "un", "##ness"]

用特殊符号 ## 来表示子词的延续，例如 ##ness。

一些常用词或者高频出现的子词包括：["happy」，"un」，"##ness"]，其中「##ness」表示「ness」是一个子词，它通常会和前面的词组合在一起使用。

Tokenization Process

The tokenization breaks the word into subwords using the vocabulary.

Token 化过程

Token 化过程会使用词汇表将单词分解为子词。

For "unhappiness":

Start with the whole word: WordPiece tries to match the longest possible token in the vocabulary.

对于「unhappiness」：

从整个单词开始：WordPiece 尝试在词汇表中匹配最长的 Token 。

un is in the vocabulary, so it's selected.

Remaining part: happiness.

'un' 这个词在词汇表中，因此被选中。

剩余部分是：'happiness'。

Continue with the next part:

The next longest match is happy (from happiness).

接下来，最长的匹配是 happy（它来自 happiness）。

Remaining part: ness.

Handle the rest:

剩余部分：功能性。

ness is in the vocabulary, but because it's a suffix, it's tokenized as ##ness.

Final Tokens

「ness」这个词缀存在于词汇中，但因为它是一个后缀，所以被 Token 化为 ##ness。

最终的 Token 结果

["un", "happy", "##ness"]

SentencePiece

["un」，"happy」，"##ness"]

SentencePiece

Works directly with raw text, handling languages with complex scripts (e.g., Japanese, Chinese).

Character-Based Tokenization: SentencePiece works directly on raw text, bypassing language-specific preprocessing (e.g., no need to split the text into words).

直接处理原始文本，包括日语、中文等复杂文字的语言。

基于字符的 Tokenization（Character-Based Tokenization)：SentencePiece 直接对原始文本进行处理，无需进行特定的语言预处理（例如，不需要将文本拆分成单词）。

Subword Units: It breaks text into subword units (like WordPiece) but doesn't rely on spaces as word boundaries.

Model-Based Tokenization: Uses algorithms like Byte Pair Encoding (BPE) or Unigram Language Model for tokenization.

子词（subword）单元：它将文本分解为子词单元（例如 WordPiece），但不依赖空格作为词的边界。

使用模型进行 Token 化：使用例如字节对编码（Byte Pair Encoding，BPE）或 Unigram 语言模型等算法进行 Token 化（tokenization）。

Input: "I like to learn SentencePiece."

Handling spaces "_I_like_to_learn_SentencePiece."

我喜欢学习 SentencePiece 。

SentencePiece 通过在词的开头添加下划线 `_` 来表示空格，例如「_I_like_to_learn_SentencePiece.」。

SentencePiece builds a vocabulary using subword units based on frequency in the corpus. It might include:

Characters: ["I", "l", "k", "t", "o", "e", "n", "c", "P", "S"]

SentencePiece 通过分析语料库中词汇的频率，使用子词单元来构建词汇表。其中可能包含以下字符：

字符：["I」，"l」，"k」，"t」，"o」，"e」，"n」，"c」，"P」，"S"]

Common subwords: ["I", "like", "to", "_learn", "Sentence", "Piece"]

Special tokens: ["_", "##"]

常用子词：[「我」，「喜欢」，「去」，「_学习（learn)」，「句子」，「片段」]

特殊 tokens：[「_（表示词的开头)」，「##（表示子词)」]

Final result: ["_I", "_like", "_to", "_learn", "_Sentence", "Piece"]

Byte-Level Tokenization

输出结果为：["_I」，"_like」，"_to」，"_learn」，"_Sentence」，"Piece"]

字节级 Token 化（Byte-Level Tokenization)

Operates at the byte level for flexibility with various scripts and encodings.

Text to Bytes:

以字节为单位进行操作，从而灵活地支持各种文字和编码格式。

文本转换为字节：

"unhappiness" → [117, 110, 104, 97, 112, 112, 105, 110, 101, 115, 115]

Map Bytes to Tokens:

「unhappiness」→ [117，110，104，97，112，112，105，110，101，115，115]

** 字节到 Token 的映射：**

Byte Mapping: [117 → 32, 110 → 45, 104 → 67, ...]

Result: [32, 45, 67, 90, 103, 103, 104, 45, 23, 8

字节对应关系：[117 → 32，110 → 45，104 → 67，等等]

转换后的结果：[32，45，67，90，103，103，104，45，23，8]

Tokens to Bytes to Text:

[32, 45, 67, 90, 103, 103, 104, 45, 23, 88, 88] → [117, 110, 104, 97, 112, 112, 105, 110, 101, 115, 115] → `"unhappiness"`

Token 到字节到文本的转换：

[32，45，67，90，103，103，104，45，23，88，88] 转换为 [117，110，104，97，112，112，105，110，101，115，115] 转换为 `"unhappiness"` （不快乐）。

Multilingual and Cross-Language Models (handling scripts from different languages in one model).

Handling Rare, Special, or Out-of-Vocabulary Tokens (URLs, emojis, code snippets).

多语言和跨语言模型（Multilingual and Cross-Language Models)： 在同一个模型中处理来自不同语言的文本。

处理稀有、特殊或词汇表外的 Token（Token）： 应对或识别 URL、表情符号、代码片段等在词汇表中不常见的特殊 Token。

Text Compression and Flexibility (fewer vocabulary requirements, but still retaining the ability to reconstruct the original input).

### The Problem

文本压缩和灵活性（降低词汇量的要求，但仍能完整还原原始输入）。

### 问题

Standard LLM training pipeline

We can easily see how different tokenization algorithm treats the same piece of text.

大语言模型（LLM/Large Language Model）的标准训练流程我们可以很轻易地观察到，不同的分词（Tokenization）算法是如何处理同一文本的。

Patches end when H(xi) exceeds the global threshold eg, shown as a red horizontal line. The start of new patches is shown with vertical gray lines. For example, the entropies of "G" and "e" in "George R.R. Martin" exceed Og, so "G" is the start of a single byte patch and "e" of a larger patch extending to the end of the named entity as the entropy H(xi) stays low, resulting in no additional patches.

当 H（xi）的值超过全局阈值时，数据块（patch）就结束了，这在图中用红色水平线表示。新的数据块起始位置用灰色垂直线标出。例如，在「George R.R. Martin」这个字符串中，"G」和「e」的熵值都超过了 Og （全局熵阈值），所以「G」标志着一个单字节数据块的开始，而「e」则标志着一个更大的数据块的开始，这个数据块一直延伸到该命名实体的末尾。因为熵值 H（xi）一直保持在较低水平，所以没有产生额外的数据块。

This patching process is important because, in large language models, the way text is divided into chunks can significantly impact both processing efficiency and the model's understanding of the text. Different patching schemes offer different tradeoffs between computational efficiency and maintaining meaningful linguistic units.

这种分块处理过程非常重要，因为在大语言模型中，文本分块方式会显著影响处理效率和模型对文本的理解。不同的分块方案在计算效率和保留语义完整性之间进行了不同的权衡。

Directly training LLMs on Bytes is prohibitively costly at scale due to long sequence length.

### Dynamic Tokenization

直接在大语言模型（LLM）上用字节（Bytes）进行训练，由于序列长度过长，会导致训练规模扩大，成本高得令人难以承受。

### 动态 Token（Token）化

Dynamic tokenization: a way to dynamically decide on token boundaries based on the input text via a subword-merging algorithm inspired by byte-pair encoding. We merge frequent subword sequences in batch, then apply a pre-trained embedding-prediction hypernetwork to compute the token embeddings on the fly.

动态 Token 划分：这是一种根据输入文本，利用受字节对编码（byte-pair encoding）启发的子词合并方法，动态确定 Token 边界的技术。我们批量合并频繁出现的子词序列，然后应用预训练的嵌入预测超网络（embedding-prediction hypernetwork）来实时计算 Token 嵌入。

Just look at how dynamic token reduced how many tokens are used. (https://arxiv.org/pdf/2411.18553)

"Tokens" to refer to byte-groups drawn from a finite vocabulary, determined prior to training.

不妨看看动态 Token（Token）如何减少了所使用的 Token 数量。(https://arxiv.org/pdf/2411.18553)

这里的「Token」指的是从一个预先确定的有限词汇表中提取的字节组合，这个词汇表是在模型训练之前就定义好的。

"Patches" which refer to dynamically grouped sequences without a fixed vocabulary.

For both token-based and patch-based models, the computational cost of processing data is primarily determined by the number of steps executed by the main Transformer.

「补丁」(Patches）指的是动态组合的序列，它们不依赖于固定的词汇表。

无论是基于 Token 的模型还是基于补丁的模型，处理数据所需的计算量主要取决于主 Transformer 执行的步骤数量。

In Byte Latent Transformer (BLT), this is the number of patches needed to encode the data with a given patching function. Consequently, the average size of a patch, or simply patch size, is the main factor for determining the cost of processing data during both training and inference with a given patching function.

在字节潜在 Transformer（Byte Latent Transformer，BLT）中，分块的数量取决于如何使用给定的分块函数对数据进行编码。因此，分块的平均大小，也就是通常所说的块大小，是决定使用给定的分块函数在训练和推理过程中处理数据成本的主要因素。

BLT processes raw text as a continuous stream of bytes, dynamically grouping them into variable-sized "patches" based on the complexity of the data. This dynamic patching allows BLT to allocate computational resources more efficiently, focusing more on complex parts of the text and less on simpler ones. The architecture is divided into three stages:

BLT 将原始文本视为连续的字节流进行处理，并根据数据复杂程度，动态地将这些字节流划分为大小不一的「区块」(patches）。这种动态区块划分方法使得 BLT 能够更有效地分配计算资源，将更多的算力集中在文本中较为复杂的部分，而对简单的部分则投入较少的算力。整个架构可以分为三个阶段：

1. Local Encoder

Function: The Local Encoder processes raw byte sequences, converting them into initial patch representations that capture local contextual information.

1. 局部信息编码器功能：局部信息编码器处理原始字节数据，将它们转换为初步的局部特征表示，这些表示能够提取局部相关的上下文信息。

Operation:

Byte Embeddings: Each byte in the input sequence is transformed into a continuous vector representation.

操作：

字节嵌入（Byte Embeddings)：输入序列中的每个字节都被转换成一个连续的向量表示（vector representation）。简单来说，就是将每个字节都用一个数值向量来表示，以便计算机更好地理解和处理。

Initial Patch Sequence: An initial sequence of patch representations is created.

Cross-Attention Mechanism: The byte embeddings and initial patch sequence interact through cross-attention, enabling the model to dynamically group bytes into variable-sized patches based on the complexity of the data.

初始补丁序列：首先会生成一个初始的补丁表示序列。

交叉注意力机制：字节嵌入和初始补丁序列通过交叉注意力机制进行交互，这使得模型能够根据数据的复杂程度，动态地将字节分组为大小可变的补丁。

Purpose: This module ensures that local patterns and dependencies within the byte sequence are effectively captured, facilitating efficient processing in subsequent stages.

目的：这个模块旨在有效地捕捉字节序列中的局部模式和依赖关系，以便在后续阶段中进行高效处理。

2. Latent Transformer

Function: Serving as the core component, the Latent Transformer processes the patch representations to model global context and dependencies across the entire sequence.

2. 隐式 Transformer（Latent Transformer)

功能：作为核心组件，隐式 Transformer 处理图像块（patch）的特征表示，从而对整个序列的全局上下文和依赖关系进行建模。

Operation:

Input: Receives the patch representations from the Local Encoder.

操作：

输入：接收来自局部特征编码器的图像块特征。

Transformer Layers: Employs multiple layers of self-attention and feed-forward networks to capture intricate relationships and dependencies between patches.

Output: Generates refined patch representations that encapsulate both local and global contextual information.

Transformer 层：利用多层自注意力（self-attention）机制和前馈网络，来捕捉图像块之间复杂的关系和依赖。

输出：生成更完善的图像块特征，这些特征包含了局部和整体的背景信息。

Purpose: This module enables the model to understand and generate coherent outputs by effectively integrating information across different parts of the input sequence.

目的：这个模块让模型可以有效地整合输入序列中不同部分的信息，从而理解并生成流畅的输出。

3. Local Decoder

Function: The Local Decoder translates the processed patch representations back into byte sequences, facilitating accurate text generation.

3. 局部解码器功能：局部解码器将处理后的图像块的特征表示转换回字节序列，从而实现准确的文本生成。

Operation:

Input: Takes the refined patch representations from the Latent Transformer.

操作：

输入：从隐空间 Transformer 中获取优化后的图像块特征。

Residual Connection: Incorporates a residual connection with the output of the Local Encoder, providing direct access to the original byte-level information.

Cross-Attention Mechanism: Utilizes cross-attention between the refined patch representations and the original byte embeddings to reconstruct the byte sequence.

残差连接：通过与局部编码器的输出建立残差连接，可以直接获取原始的字节级别信息。

交叉注意力机制：利用精炼后的图像块（patch）表示和原始字节嵌入之间的交叉注意力，来重建字节序列。

Byte-Level Transformer: A lightweight byte-level transformer is employed to predict the next byte in the sequence, ensuring accurate and coherent text generation.

字节级 Transformer（Byte-Level Transformer)：我们使用一种轻量级的字节级 Transformer 来预测文本序列中的下一个字节，从而保证生成文本的准确性和连贯性。

Purpose: This module ensures that the final output maintains fidelity to the original input, allowing for precise and contextually appropriate text generation.

By integrating these three modules, the BLT architecture effectively processes raw byte sequences into meaningful outputs without relying on traditional tokenization methods, enhancing efficiency and scalability in language modeling.

目的：这个模块确保最终的输出忠实于原始输入，从而实现精确且符合上下文的文本生成。

通过整合这三个模块，BLT 架构能够高效地将原始字节序列转化为有意义的输出，并且不依赖传统的 Token 化（Tokenization）方法，这提高了语言建模的效率和可扩展性。

Writing articles like this takes considerable effort and time. Please subscribe and follow me if my content adds any value to you.

创作这样的文章需要投入大量的精力和时间。如果我的内容对您有所帮助，请订阅并关注我。

Newsletter: https://medium.com/aiguys/newsletter

𝕏: https://x.com/RealAIGuys

## 原文

Byte Latent Transformer: Changing How We Train LLMs

2025-01-06

Vishal Rajput

Published in AIGuys

We all know that computers can’t read text, what they read are numbers. All the text is converted into numbers using different strategies and fed to the computers. But what about AI, can’t LLMs read and write a text? No, they read and write tokens. Tokens are a way to represent text, which are the fundamental units of text used to process and generate language. Tokens can represent characters, subwords, words, or even punctuation, depending on how the language model’s tokenizer works.

However, new work from Meta’s FAIR lab is challenging the well-established paradigm of tokens in LLM space, and it has developed a thing called Patches and Byte Latent Transformer. So, without further ado, let’s go deep into this new paper.

Table of Contents:
Tokens and Tokenization
Tokenization Algorithms
The Problem
Dynamic Tokenization
Tokens and Tokenization
A token is a segment of text that the model processes as a single unit.

For example:

Word-based tokenization: “Artificial Intelligence” → ["Artificial", "Intelligence"]
Subword tokenization: “Artificial Intelligence” → ["Art", "ificial", "Int", "elligence"]
Character-based tokenization: “Artificial Intelligence” → ["A", "r", "t", "i", ...]
Most modern LLMs like GPT, Claude, or any other Transformer model use subword tokenization (e.g., Byte Pair Encoding or SentencePiece) to handle out-of-vocabulary words efficiently.

Example (using GPT-like tokenization):

Input: “Hello, world!”

Tokenized Output: [15496, 11, 995]

“Hello” → 15496
“,” → 11
“world” → 995
Input Representation: To do any processing, the model converts raw text into tokens. These tokens are later mapped to embeddings (numerical representations) for computation.

Output Generation: When generating text, LLMs produce tokens in an autoregressive fashion (one at a time), which are then decoded back into human-readable text.

Tokenization Algorithms
Byte Pair Encoding (BPE)
Breaks words into subwords based on frequency. Suppose the data to be encoded is

aaabdaaabac
The byte pair “aa” occurs most often, so it will be replaced by a byte that is not used in the data, such as “Z”. Now there is the following data and replacement table:

ZabdZabac
Z=aa
Then the process is repeated with byte pair “ab”, replacing it with “Y”:

ZYdZYac
Y=ab
Z=aa
The only literal byte pair left occurs only once, and the encoding might stop here. Alternatively, the process could continue with recursive byte pair encoding, replacing “ZY” with “X”:

XdXac
X=ZY
Y=ab
Z=aa
This data cannot be compressed further by byte pair encoding because there are no pairs of bytes that occur more than once.

To decompress the data, simply perform the replacements in the reverse order.

So, what’s the problem with BPE? 🤔 It can have instances where there is more than one way to encode a particular word. It then gets difficult for the algorithm to choose subword tokens as there is no way to prioritize which one to use first. Hence, the same input can be represented by different encodings impacting the accuracy of the learned representations. 🤦‍♀️

WordPiece
Similar to BPE but optimized for maximum likelihood estimation.

The only difference between WordPiece and BPE is the way in which symbol pairs are added to the vocabulary. At each iterative step, WordPiece chooses a symbol pair which will result in the largest increase in likelihood upon merging. Maximizing the likelihood of the training data is equivalent to finding the symbol pair whose probability divided by the probability of the first followed by the probability of the second symbol in the pair is greater than any other symbol pair.

WordPiece starts with a fixed initial vocabulary. This usually includes:

Single characters: ["u", "n", "h", "a", "p", "i", "e", "s"]
A special symbol to indicate subword continuation: ## (e.g., ##ness)
Common words or frequent subwords: [“happy”, “un”, “##ness”]
Tokenization Process
The tokenization breaks the word into subwords using the vocabulary.

For "unhappiness":

Start with the whole word: WordPiece tries to match the longest possible token in the vocabulary.

un is in the vocabulary, so it’s selected.
Remaining part: happiness.
Continue with the next part:

The next longest match is happy (from happiness).
Remaining part: ness.
Handle the rest:

ness is in the vocabulary, but because it's a suffix, it’s tokenized as ##ness.
Final Tokens

["un", "happy", "##ness"]

SentencePiece
Works directly with raw text, handling languages with complex scripts (e.g., Japanese, Chinese).

Character-Based Tokenization: SentencePiece works directly on raw text, bypassing language-specific preprocessing (e.g., no need to split the text into words).
Subword Units: It breaks text into subword units (like WordPiece) but doesn’t rely on spaces as word boundaries.
Model-Based Tokenization: Uses algorithms like Byte Pair Encoding (BPE) or Unigram Language Model for tokenization.
Input: “I like to learn SentencePiece.”

Handling spaces “_I_like_to_learn_SentencePiece.”

SentencePiece builds a vocabulary using subword units based on frequency in the corpus. It might include:

Characters: ["I", "l", "k", "t", "o", "e", "n", "c", "P", "S"]
Common subwords: ["I", "like", "to", "_learn", "Sentence", "Piece"]
Special tokens: ["_", "##"]
Final result: [“_I”, “_like”, “_to”, “_learn”, “_Sentence”, “Piece”]

Byte-Level Tokenization
Operates at the byte level for flexibility with various scripts and encodings.

Text to Bytes:

"unhappiness" → [117, 110, 104, 97, 112, 112, 105, 110, 101, 115, 115]

Map Bytes to Tokens:

Byte Mapping: [117 → 32, 110 → 45, 104 → 67, ...] 
Result: [32, 45, 67, 90, 103, 103, 104, 45, 23, 8
Tokens to Bytes to Text:

[32, 45, 67, 90, 103, 103, 104, 45, 23, 88, 88] → [117, 110, 104, 97, 112, 112, 105, 110, 101, 115, 115] → `"unhappiness"`

Multilingual and Cross-Language Models (handling scripts from different languages in one model).
Handling Rare, Special, or Out-of-Vocabulary Tokens (URLs, emojis, code snippets).
Text Compression and Flexibility (fewer vocabulary requirements, but still retaining the ability to reconstruct the original input).
The Problem

Standard LLM training pipeline

Src
We can easily see how different tokenization algorithm treats the same piece of text.


Src
Patches end when H(xi) exceeds the global threshold eg, shown as a red horizontal line. The start of new patches is shown with vertical gray lines. For example, the entropies of “G” and “e” in “George R.R. Martin” exceed Og, so “G” is the start of a single byte patch and “e” of a larger patch extending to the end of the named entity as the entropy H(xi) stays low, resulting in no additional patches.

This patching process is important because, in large language models, the way text is divided into chunks can significantly impact both processing efficiency and the model’s understanding of the text. Different patching schemes offer different tradeoffs between computational efficiency and maintaining meaningful linguistic units.

Directly training LLMs on Bytes is prohibitively costly at scale due to long sequence length.


Dynamic Tokenization
Dynamic tokenization: a way to dynamically decide on token boundaries based on the input text via a subword-merging algorithm inspired by byte-pair encoding. We merge frequent subword sequences in batch, then apply a pre-trained embedding-prediction hypernetwork to compute the token embeddings on the fly.


Just look at how dynamic token reduced how many tokens are used. (https://arxiv.org/pdf/2411.18553)
“Tokens” to refer to byte-groups drawn from a finite vocabulary, determined prior to training.

“Patches” which refer to dynamically grouped sequences without a fixed vocabulary.

For both token-based and patch-based models, the computational cost of processing data is primarily determined by the number of steps executed by the main Transformer.

In Byte Latent Transformer (BLT), this is the number of patches needed to encode the data with a given patching function. Consequently, the average size of a patch, or simply patch size, is the main factor for determining the cost of processing data during both training and inference with a given patching function.


BLT processes raw text as a continuous stream of bytes, dynamically grouping them into variable-sized “patches” based on the complexity of the data. This dynamic patching allows BLT to allocate computational resources more efficiently, focusing more on complex parts of the text and less on simpler ones. The architecture is divided into three stages:

1. Local Encoder
Function: The Local Encoder processes raw byte sequences, converting them into initial patch representations that capture local contextual information.

Operation:

Byte Embeddings: Each byte in the input sequence is transformed into a continuous vector representation.
Initial Patch Sequence: An initial sequence of patch representations is created.
Cross-Attention Mechanism: The byte embeddings and initial patch sequence interact through cross-attention, enabling the model to dynamically group bytes into variable-sized patches based on the complexity of the data.
Purpose: This module ensures that local patterns and dependencies within the byte sequence are effectively captured, facilitating efficient processing in subsequent stages.

2. Latent Transformer
Function: Serving as the core component, the Latent Transformer processes the patch representations to model global context and dependencies across the entire sequence.

Operation:

Input: Receives the patch representations from the Local Encoder.
Transformer Layers: Employs multiple layers of self-attention and feed-forward networks to capture intricate relationships and dependencies between patches.
Output: Generates refined patch representations that encapsulate both local and global contextual information.
Purpose: This module enables the model to understand and generate coherent outputs by effectively integrating information across different parts of the input sequence.

3. Local Decoder
Function: The Local Decoder translates the processed patch representations back into byte sequences, facilitating accurate text generation.

Operation:

Input: Takes the refined patch representations from the Latent Transformer.
Residual Connection: Incorporates a residual connection with the output of the Local Encoder, providing direct access to the original byte-level information.
Cross-Attention Mechanism: Utilizes cross-attention between the refined patch representations and the original byte embeddings to reconstruct the byte sequence.
Byte-Level Transformer: A lightweight byte-level transformer is employed to predict the next byte in the sequence, ensuring accurate and coherent text generation.
Purpose: This module ensures that the final output maintains fidelity to the original input, allowing for precise and contextually appropriate text generation.

By integrating these three modules, the BLT architecture effectively processes raw byte sequences into meaningful outputs without relying on traditional tokenization methods, enhancing efficiency and scalability in language modeling.

Writing articles like this takes considerable effort and time. Please subscribe and follow me if my content adds any value to you.

Newsletter: https://medium.com/aiguys/newsletter

𝕏: https://x.com/RealAIGuys