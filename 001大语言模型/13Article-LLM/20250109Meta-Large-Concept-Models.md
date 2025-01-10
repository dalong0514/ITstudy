## 20250109Meta-Large-Concept-Models

[Meta Large Concept Models (LCM): End of LLMs? | by Mehul Gupta | Data Science in your pocket | Jan, 2025 | Medium](https://medium.com/data-science-in-your-pocket/meta-large-concept-models-lcm-end-of-llms-68cb0c5cd5cf)

What are LCMs and how is LCM different from LLMs

Mehul Gupta

Published in Data Science in your pocket

2025-01-05

Since ChatGPT’s inception in late 2022, it’s a Generative AI era we’ve been living in with the word “LLMs” becoming the core of everyone’s life.

自从 ChatGPT 在 2022 年底问世以来，我们就进入了生成式 AI（Generative AI）时代，「大语言模型」（LLM）这个词也逐渐成为人们生活中不可或缺的一部分。

But recently, you must have heard of some “big tech guys” mentioning that LLM growth is plateauing.

但是最近，你可能已经听到一些「大型科技公司」提到，大语言模型（LLM）的发展速度正在放缓。

[Meta Large Concept Models (LCMs) - YouTube](https://www.youtube.com/watch?v=GY-UGAsRF2g)

So, what’s next? Meta has an answer

那么，接下来会如何发展？Meta 给出了答案。

Meta recently introduced LCMs, Large Concept Models, which looks to be the next big step, a major upgrade to LLMs.

Meta 近期发布了大型概念模型（Large Concept Models），简称 LCM。这被视为继大语言模型（LLMs）之后，人工智能领域的又一重大进展。LCM 代表着对大语言模型（LLMs）的一次重要升级。

### 01. What are Large Concept Models?

什么是大型概念模型？

Meta’s Large Concept Models (LCMs) represent a novel approach to language modelling that operates at a higher level of abstraction compared to traditional Large Language Models (LLMs).

Meta 公司的大型概念模型（LCM）代表了一种新的语言建模方法，与传统的大语言模型（LLM）相比，它在理解语言概念时，抽象程度更高。

Instead of processing text at the token level, LCMs work with concepts, which are language- and modality-agnostic representations of higher-level ideas or actions.

LCM（Latent Concept Model）不在 Token（Token）级别处理文本，而是处理概念，这些概念是更高层级的想法或动作的、与语言和不同类型的数据无关的表示。

In Meta’s LCM framework, a concept is defined as an abstract, atomic idea. In practice, a concept often corresponds to a sentence in text or an equivalent speech utterance. This allows the model to reason at a higher semantic level, independent of the specific language or modality (e.g., text, speech, or images).

在 Meta 的 LCM 框架中，一个概念被定义为一个抽象且不可再分割的基本想法。实际应用中，一个概念通常对应于文本中的一个句子，或者一段意思相同的语音。这使得模型可以从更高层次的语义层面进行理解和推理，不受具体语言或表达形式（例如，文本、语音或图像）的限制。

What does this even mean?

这到底是什么意思呢？

Let’s see an example

我们来看一个例子

Traditional Language Models (LLMs): Word-by-Word Prediction

传统大语言模型（LLM)：像接龙一样预测下一个词

Imagine you’re writing a story, and you’re using a traditional language model like ChatGPT. It works by predicting the next word (or “token”) based on the words you’ve already written. For example:

假设你正在用像 ChatGPT 这样的大语言模型写故事。它的工作方式就像接龙游戏，根据你已经写好的词语，预测下一个最有可能出现的词（或者叫做「Token」）。例如：

You write: “The cat sat on the…”

The model predicts: “mat.”

It’s like filling in the blanks one word at a time. This works well, but it’s very focused on individual words and doesn’t always think about the bigger picture or the overall meaning of the sentence.

这就像在做填空题，一次只填写一个词。这种逐词填充的方式虽然有效，但它过于关注单个词语，而没有充分考虑上下文的整体结构或句子的完整意思。

Meta’s Large Concept Models (LCMs): Idea-by-Idea Prediction

Meta 公司的大型概念模型（LCM)：按想法逐个预测

Now, imagine instead of predicting the next word, the model predicts the next idea or concept. A concept is like a complete thought or sentence, not just a single word. For example:

现在，想象一下，模型不是预测下一个词，而是预测下一个想法或概念。概念就像一个完整的想法或语句，而不仅仅是一个单独的词。例如：

You write: “The cat sat on the mat. It was a sunny day. Suddenly…”

The model predicts: “a loud noise came from the kitchen.”

Here, the model isn’t just guessing the next word; it’s thinking about the entire idea that should come next. It’s like planning the next part of the story in chunks, not word by word.

在这里，模型并非仅仅是猜测下一个词，而是在思考接下来应该表达的完整概念。这就像是以段落为单位规划故事的后续发展，而非逐字逐句地进行。

This is just crazy !!

这简直令人难以置信！！

Why is this cool?

这为什么如此吸引人？

Language-Independent:

不依赖于特定语言：

The model doesn’t care if the input is in English, French, or any other language. It works with the meaning of the sentence, not the specific words. For example:

该模型并不在意输入内容是英语、法语或其他任何语言。它关注的是句子的含义，而非具体的词汇。例如：

Input in English: “The cat is hungry.”

Input in French: “Le chat a faim.”

Both sentences mean the same thing, so the model treats them as the same concept.

这两句话表达的是同一个意思，模型会将其理解为相同的概念。

Multimodal (Works with Text, Speech, etc.):

多模态（可以处理文本、语音等多种信息)：

The model can also work with speech or even images. For example:

该模型不仅能处理文本，还能处理语音，甚至是图像。例如：

If you say, “The cat is hungry,” or show a picture of a hungry cat, the model understands the same concept: “A cat needs food.”

如果你说，「猫饿了」，或者展示一张饥饿的猫的图片，模型理解的是相同的概念：「猫需要食物。」

Better for Long-Form Content:

更适用于长篇内容：

When writing a long story or essay, the model can plan the flow of ideas instead of getting stuck on individual words. For example:

在撰写长篇故事或论文时，模型可以帮助规划思路的脉络，避免在个别字句上纠缠。例如：

If you’re writing a research paper, the model can help you outline the main points (concepts) and then expand on them.

如果你正在撰写一篇研究论文，模型可以先帮你梳理出主要论点（概念），然后再对这些论点进行详细阐述。

### 03. Architecture

模型架构

Input Processing:

输入数据处理：

1 The input text is first segmented into sentences, and each sentence is encoded into a fixed-size embedding using a pre-trained sentence encoder (e.g., SONAR). SONAR supports up to 200 languages and can handle both text and speech inputs.

首先，输入的文本会被分割成一个个句子，然后，每个句子都会通过预训练的句子编码器（例如 SONAR）转换成固定大小的向量表示，也就是嵌入（embedding）。SONAR 支持多达 200 种语言，并且可以处理文本和语音两种输入。

2 These embeddings represent the concepts in the input sequence.

这些嵌入（embedding）就代表了输入序列中蕴含的概念。

Large Concept Model (LCM):

大型概念模型（Large Concept Model，LCM)：

1 The LCM processes the sequence of concept embeddings and predicts the next concept in the sequence. The model is trained to perform autoregressive sentence prediction in the embedding space.

LCM 模型接收一系列概念嵌入，并预测序列中的下一个概念。该模型经过训练，在概念嵌入空间中，通过自回归的方式预测句子。

2 The output of the LCM is a sequence of concept embeddings, which can then be decoded back into text or speech using the SONAR decoder.

LCM 输出的是一系列概念嵌入，这些概念嵌入随后通过 SONAR 解码器被转换回文本或语音。

Output Generation:

输出生成过程：

1 The generated concept embeddings are decoded into text or speech, producing the final output. Since the LCM operates at the concept level, the same reasoning process can be applied to different languages or modalities without retraining.

生成的概念嵌入会被解码成文本或语音，从而得到最终的输出。由于 LCM 是在概念层面进行操作，相同的推理过程可以不经重新训练，直接应用于不同的语言或模态。

2 The LCM supports zero-shot generalization, meaning it can be applied to languages or modalities it was not explicitly trained on, as long as the SONAR encoder and decoder support them.

LCM 支持零样本（Zero-shot）泛化，这意味着只要 SONAR 编码器和解码器支持，LCM 就可以应用于它没有明确训练过的语言或模态。

A few key points to understand here are:

这里有几个关键点需要理解：

SONAR Embedding Space:

SONAR 嵌入表示空间：

SONAR is a multilingual and multimodal sentence embedding space that supports 200 languages for text and 76 languages for speech.

SONAR 是一个多语言和多模态的句子嵌入空间，支持文本的 200 种语言和语音的 76 种语言。

SONAR’s embeddings are fixed-size vectors that capture the semantic meaning of sentences, making them suitable for concept-level reasoning.

SONAR 的嵌入向量是固定维度的向量，它捕捉句子的语义含义，使其适用于基于概念的推理。

Diffusion & Quantized Based Generation:

基于扩散和量化的生成方法：

Meta explored several approaches for training the LCM, including diffusion-based generation. Diffusion models are used to predict the next concept embedding by learning a conditional probability distribution over the continuous embedding space.

Meta 公司探索了几种训练 LCM 的方法，其中一种是基于扩散模型的生成方式。扩散模型通过学习连续嵌入空间上的条件概率分布，来预测下一个概念的嵌入（embedding）。

Another approach involves quantizing the SONAR embeddings into discrete units and training the LCM to predict the next quantized concept. This allows for more controlled generation and sampling, similar to how LLMs sample tokens from a vocabulary.

另一种方法是将 SONAR 嵌入转换成离散的单元，然后训练 LCM 来预测下一个转换后的概念。这使得生成和采样过程更易于控制， 类似于大语言模型从词汇表中选择 Token 的方式。

LCM vs LLMs

1 Level of Abstraction

抽象级别

LLM: Works at the token level, predicting the next word or subword in a sequence.

大语言模型（LLM)：工作在 Token（可以理解为文本的基本单元，例如一个词或一个词的一部分）级别，预测序列中下一个 Token。

LCM: Works at the concept level, predicting the next sentence or idea in a sequence.

LCM：工作在概念级别，预测序列中下一个句子或想法。

2 Input Representation

输入数据的形式

LLM: Processes individual tokens (words or subwords) in a specific language.

大语言模型（LLM)：处理特定语言中的单个 Token（词或子词单元）。

LCM: Processes sentence embeddings (concepts) that are language- and modality-agnostic.

LCM：处理不依赖于特定语言和数据形式的句子嵌入（语义概念）。

3 Output Generation

输出生成

LLM: Generates text word by word, focusing on local coherence.

大语言模型（LLM)：像写字一样，一个字一个字地生成文本，更关注前后词语之间的流畅衔接。

LCM: Generates text sentence by sentence, focusing on global coherence and higher-level reasoning.

LCM：像写文章一样，一句一句地生成文本，更关注整段话的连贯和逻辑性，以及更深层次的思考。

4 Language and Modality Support

语言和模态支持

LLM: Typically trained for specific languages and modalities (e.g., text). Though, multi-modal LLMs can support multiple modalities.

大语言模型（LLM)：大语言模型（LLM）通常是针对特定语言和模态进行训练的，比如文本。不过，多模态大语言模型可以支持多种模态。

LCM: Designed to handle multiple languages and modalities (e.g., text, speech, images) through a shared concept space.

LCM：LCM 的设计目标是通过一个共享的概念空间来处理多种语言和模态，例如文本、语音和图像。

5 Training Objective

训练目标

LLM: Trained to minimize token prediction error (e.g., cross-entropy loss).

大语言模型（LLM)：通过训练来最小化 Token 的预测误差，例如使用交叉熵损失函数。

LCM: Trained to minimize concept prediction error (e.g., mean squared error in embedding space).

LCM：通过训练来最小化概念的预测误差，例如在嵌入空间中使用均方误差。这里的嵌入空间指的是将概念映射到向量表示的空间。

6 Reasoning and Planning

推理与规划

LLM: Implicitly learns hierarchical reasoning but operates locally (token by token).

大语言模型（LLM)：它在训练过程中隐式地学习分层推理，但实际运作时，它是一次处理一个 Token。

LCM: Explicitly models hierarchical reasoning, planning at the sentence or idea level.

LCM：它明确地建立分层推理的模型，并在句子或想法的层面进行规划。

7 Zero-Shot Generalization

零样本泛化

LLM: Struggles with zero-shot tasks in languages or modalities it wasn’t trained on.

大语言模型（Large Language Model)：在未训练过的语言或模态的零样本任务中表现不佳。

LCM: Excels at zero-shot generalization across languages and modalities due to its concept-based approach.

LCM：归因于其基于概念的方法，在跨语言和模态的零样本推广方面表现出色。

8 Efficiency with Long Contexts

处理长文本的效率

LLM: Struggles with long contexts due to quadratic complexity in attention mechanisms.

大语言模型（LLM）：由于其注意力机制的计算复杂度呈平方级增长，因此在处理长文本时会遇到困难。

LCM: More efficient with long contexts as it processes sequences of sentence embeddings, which are shorter than token sequences.

潜在一致性模型（LCM）：在处理长文本时效率更高，因为它处理的是句子嵌入（sentence embedding）序列，这些序列比标记（Token）序列更短。

9 Applications

应用

LLM: Best for word-level tasks like text completion, translation, and question answering.

大语言模型（Large Language Model)：最适合处理词语层面的任务，例如文本补全、翻译和问答。

LCM: Best for sentence-level tasks like summarization, story generation, and multimodal reasoning.

LCM（Latent Consistency Model)：最适合处理句子层面的任务，例如摘要生成、故事创作和多模态推理（涉及多种数据类型的推理）。

10 Flexibility

灵活性

LLM: Limited to text-based tasks and requires retraining for new languages or modalities.

大语言模型：仅限文本任务，并且对于新的语言或模态需要重新训练。

LCM: Flexible across languages and modalities without retraining, thanks to its concept-based design.

LCM：得益于其基于概念的设计，在语言和模态上具有灵活性，无需再训练。

In conclusion, Meta’s Large Concept Models (LCMs) represent a significant leap forward in language modelling. By operating at the concept level, LCMs offer a more abstract, language-agnostic, and multimodal approach to reasoning and generation. While LLMs excel at word-by-word tasks, LCMs shine in higher-level applications like summarization, story generation, and cross-modal understanding. As AI continues to evolve, LCMs could pave the way for more intuitive, human-like interactions with machines, transforming industries from education to entertainment.

总而言之，Meta 的大型概念模型（LCMs）代表了语言建模领域的一次重大飞跃。通过在概念层面工作，LCMs 为推理和生成提供了一种更抽象、不依赖特定语言且支持多模态的方法。与擅长处理逐字任务的大语言模型（LLMs）不同，LCMs 在更高阶的应用中表现卓越，例如文本摘要、故事创作以及跨模态信息理解。随着人工智能（AI）的持续发展，LCMs 有望为更直观、更接近人类的机器交互方式奠定基础，从而深刻改变教育和娱乐等多个行业。

The future of AI is not just about predicting the next word — it’s about understanding the next idea!

人工智能的未来，不仅仅在于预测下一个词语，更在于理解下一个概念！

## 原文

Meta Large Concept Models (LCM): End of LLMs?

What are LCMs and how is LCM different from LLMs
Mehul Gupta

Published in Data Science in your pocket

2025-01-05

Photo by Luis Tosta on Unsplash
Since ChatGPT’s inception in late 2022, it’s a Generative AI era we’ve been living in with the word “LLMs” becoming the core of everyone’s life.

But recently, you must have heard of some “big tech guys” mentioning that LLM growth is plateauing.

So, what’s next? Meta has an answer

Meta recently introduced LCMs, Large Concept Models, which looks to be the next big step, a major upgrade to LLMs.

Subscribe to datasciencepocket on Gumroad
On a Mission to teach AI to everyone !
datasciencepocket.gumroad.com

What are Large Concept Models?
Meta’s Large Concept Models (LCMs) represent a novel approach to language modelling that operates at a higher level of abstraction compared to traditional Large Language Models (LLMs).

Instead of processing text at the token level, LCMs work with concepts, which are language- and modality-agnostic representations of higher-level ideas or actions.

In Meta’s LCM framework, a concept is defined as an abstract, atomic idea. In practice, a concept often corresponds to a sentence in text or an equivalent speech utterance. This allows the model to reason at a higher semantic level, independent of the specific language or modality (e.g., text, speech, or images).

What does this even mean?
Let’s see an example

Traditional Language Models (LLMs): Word-by-Word Prediction
Imagine you’re writing a story, and you’re using a traditional language model like ChatGPT. It works by predicting the next word (or “token”) based on the words you’ve already written. For example:

You write: “The cat sat on the…”

The model predicts: “mat.”

It’s like filling in the blanks one word at a time. This works well, but it’s very focused on individual words and doesn’t always think about the bigger picture or the overall meaning of the sentence.

Meta’s Large Concept Models (LCMs): Idea-by-Idea Prediction
Now, imagine instead of predicting the next word, the model predicts the next idea or concept. A concept is like a complete thought or sentence, not just a single word. For example:

You write: “The cat sat on the mat. It was a sunny day. Suddenly…”

The model predicts: “a loud noise came from the kitchen.”

Here, the model isn’t just guessing the next word; it’s thinking about the entire idea that should come next. It’s like planning the next part of the story in chunks, not word by word.

This is just crazy !!

Why is this cool?
Language-Independent:

The model doesn’t care if the input is in English, French, or any other language. It works with the meaning of the sentence, not the specific words. For example:

Input in English: “The cat is hungry.”

Input in French: “Le chat a faim.”

Both sentences mean the same thing, so the model treats them as the same concept.
Multimodal (Works with Text, Speech, etc.):

The model can also work with speech or even images. For example:

If you say, “The cat is hungry,” or show a picture of a hungry cat, the model understands the same concept: “A cat needs food.”

Better for Long-Form Content:

When writing a long story or essay, the model can plan the flow of ideas instead of getting stuck on individual words. For example:

If you’re writing a research paper, the model can help you outline the main points (concepts) and then expand on them.

Architecture

Input Processing:

The input text is first segmented into sentences, and each sentence is encoded into a fixed-size embedding using a pre-trained sentence encoder (e.g., SONAR). SONAR supports up to 200 languages and can handle both text and speech inputs.
These embeddings represent the concepts in the input sequence.
Large Concept Model (LCM):

The LCM processes the sequence of concept embeddings and predicts the next concept in the sequence. The model is trained to perform autoregressive sentence prediction in the embedding space.
The output of the LCM is a sequence of concept embeddings, which can then be decoded back into text or speech using the SONAR decoder.
Output Generation:

The generated concept embeddings are decoded into text or speech, producing the final output. Since the LCM operates at the concept level, the same reasoning process can be applied to different languages or modalities without retraining.
The LCM supports zero-shot generalization, meaning it can be applied to languages or modalities it was not explicitly trained on, as long as the SONAR encoder and decoder support them.
A few key points to understand here are:

SONAR Embedding Space:

SONAR is a multilingual and multimodal sentence embedding space that supports 200 languages for text and 76 languages for speech.

SONAR’s embeddings are fixed-size vectors that capture the semantic meaning of sentences, making them suitable for concept-level reasoning.

Diffusion & Quantized Based Generation:

Meta explored several approaches for training the LCM, including diffusion-based generation. Diffusion models are used to predict the next concept embedding by learning a conditional probability distribution over the continuous embedding space.

Another approach involves quantizing the SONAR embeddings into discrete units and training the LCM to predict the next quantized concept. This allows for more controlled generation and sampling, similar to how LLMs sample tokens from a vocabulary.

LCM vs LLMs
1. Level of Abstraction
LLM: Works at the token level, predicting the next word or subword in a sequence.
LCM: Works at the concept level, predicting the next sentence or idea in a sequence.
2. Input Representation
LLM: Processes individual tokens (words or subwords) in a specific language.
LCM: Processes sentence embeddings (concepts) that are language- and modality-agnostic.
3. Output Generation
LLM: Generates text word by word, focusing on local coherence.
LCM: Generates text sentence by sentence, focusing on global coherence and higher-level reasoning.
4. Language and Modality Support
LLM: Typically trained for specific languages and modalities (e.g., text). Though, multi-modal LLMs can support multiple modalities.
LCM: Designed to handle multiple languages and modalities (e.g., text, speech, images) through a shared concept space.
5. Training Objective
LLM: Trained to minimize token prediction error (e.g., cross-entropy loss).
LCM: Trained to minimize concept prediction error (e.g., mean squared error in embedding space).
6. Reasoning and Planning
LLM: Implicitly learns hierarchical reasoning but operates locally (token by token).
LCM: Explicitly models hierarchical reasoning, planning at the sentence or idea level.
7. Zero-Shot Generalization
LLM: Struggles with zero-shot tasks in languages or modalities it wasn’t trained on.
LCM: Excels at zero-shot generalization across languages and modalities due to its concept-based approach.
8. Efficiency with Long Contexts
LLM: Struggles with long contexts due to quadratic complexity in attention mechanisms.
LCM: More efficient with long contexts as it processes sequences of sentence embeddings, which are shorter than token sequences.
9. Applications
LLM: Best for word-level tasks like text completion, translation, and question answering.
LCM: Best for sentence-level tasks like summarization, story generation, and multimodal reasoning.
10. Flexibility
LLM: Limited to text-based tasks and requires retraining for new languages or modalities.
LCM: Flexible across languages and modalities without retraining, thanks to its concept-based design.
In conclusion, Meta’s Large Concept Models (LCMs) represent a significant leap forward in language modelling. By operating at the concept level, LCMs offer a more abstract, language-agnostic, and multimodal approach to reasoning and generation. While LLMs excel at word-by-word tasks, LCMs shine in higher-level applications like summarization, story generation, and cross-modal understanding. As AI continues to evolve, LCMs could pave the way for more intuitive, human-like interactions with machines, transforming industries from education to entertainment.

The future of AI is not just about predicting the next word — it’s about understanding the next idea!