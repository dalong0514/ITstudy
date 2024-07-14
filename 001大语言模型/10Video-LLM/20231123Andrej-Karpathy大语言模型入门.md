## 20231123Andrej-Karpathy大语言模型入门

[The Busy Person's Introduction to Large Language Models](https://ppaolo.substack.com/p/introduction-to-large-language-models-llms)

[[1hr Talk] Intro to Large Language Models - YouTube](https://www.youtube.com/watch?v=zjkBMFhNj_g)

[为忙碌人士准备的大语言模型（LLM）速览 [译] | 宝玉的分享](https://baoyu.io/translations/llm/introduction-to-large-language-models-llms)

This blog takes its full inspiration from Andrej Karpathy's YouTube video "The busy person's intro to Large Language Models", in my opinion the best explanation out there of Large Language Models (LLMs). For those who prefer reading over watching, this post is an ideal alternative.

This is not a summary. In creating this blog, I first generated the full transcript of the talk and then specifically prompted ChatGPT to retain as much of the original content as possible. Andrej's presentation style is so compelling that I felt it crucial to maintain the integrity of his explanations. His skill in breaking down complex ideas into simple, digestible concepts is something I admire and aimed to preserve in this written format.

The process wasn't without its challenges and required significant manual intervention. Working with ChatGPT, I encountered issues with handling long texts, analyzing the transcript file, and continuing to follow instructions in extended conversations – but that's maybe feedback material to OpenAI.

I believe you'll find this blog as informative and insightful as Andrej's talk. It's designed to extend his knowledge to a broader audience and to shed some light on the fascinating world of large language models.

基于 Andrej Karpathy 2023 年 11 月的演讲

PAOLO PERAZZO

2023 年 12 月 5 日

这篇博客的灵感完全来自 Andrej Karpathy 在 YouTube 上的视频「忙碌人士的大语言模型速览」。在我看来，这是对大语言模型的最精彩解释。对于更喜欢阅读而不是观看的朋友，这篇文章是你的理想之选。

这不仅仅是个摘要。在编撰这篇博客时，我首先完整转录了演讲内容，接着我引导 ChatGPT 尽量保留原始演讲的精髓。Andrej 的讲述方式极具吸引力，我觉得保持他的原始解释风格至关重要。他将复杂概念简化为浅显易懂的观点的能力非常令人敬佩，我也力求在这篇文字作品中保持这种风格。

完成这项工作并非易事，需要大量的人工介入。在与 ChatGPT 合作时，我遇到了一些挑战，比如处理长篇文本、分析演讲记录，以及在持续的对话中遵循指令 —— 但这也许可以作为对 OpenAI 的一些反馈。

我相信您会发现，这篇博客像 Andrej 的演讲一样充满了信息和洞察。它的目的是将他的知识传递给更广泛的读者，让大家更加深入了解大语言模型这个迷人的领域。

### 01. What Exactly is a Large Language Model?

A large language model is simpler than you might think. Essentially, a large language model boils down to just two files on a computer.

Let's look, for instance, at the Llama2-70b model, a large language model from Meta AI, part of the Llama series. The Llama2-70b is the second iteration in the Llama series and boasts a whopping 70 billion parameters. This series has several models, with 7 billion, 13 billion, 34 billion, and 70 billion parameters.

Llama2-70b is very popular because, as of now, it's probably the most powerful model with open weights available. Meta AI didn't just release the model; they made the weights, the architecture, and even a paper on it publicly available. This openness is quite different from other language models you might have heard of, like ChatGPT, where the architecture is proprietary to OpenAI. With ChatGPT, you can use the model via a web interface, but you don't actually have access to the model itself.

01 大语言模型是什么？

大语言模型其实比大家想的还要简单，它本质上就是计算机里的两个文件。

举个例子，来看看 Meta AI 的 Llama2-70b 模型。这是 Llama 系列中的一款大语言模型。Llama2-70b 是该系列的第二代产品，它有着高达 700 亿 (70 billion) 个参数。Llama 系列包括多款不同参数量的模型，有 70 亿 (7 billion)，130 亿 (13 billion)，340 亿 (34 billion) 以及 700 亿 (70 billion) 参数的。

Llama2-70b 如此受欢迎，主要是因为它可能是目前公开可用的最强大的模型。Meta AI 不只是发布了这个模型，他们还把模型的权重、架构乃至相关论文都公开了。这种做法与其他一些语言模型（比如 OpenAI 的 ChatGPT）大相径庭。虽然你可以通过网页界面使用 ChatGPT，但你并不能真正接触到模型本身。

#### The Core Components: Parameters and Run Files

As said, the Llama2-70b model is really just two files on your file system: the parameters file and the Run file. The parameters file contains what you can think of as the model's brain – the weights or parameters of the neural network that is the language model. The run.c file is some kind of a code that runs those parameters.

Fig: The core components of a large language model

Each parameter in this model is stored as two bytes, so the total size of the parameters file is a hefty 140 gigabytes. They're stored as two bytes because they're float16 numbers. Besides these parameters, you also need something to run the neural network, and that's where the Run file comes in. This could be a C file, a Python file, or really any programming language, but let's say it's C for simplicity. You'd only need about 500 lines of C code, with no other dependencies, to implement the neural network architecture using these parameters.

So, in essence, to get the Llama2-70b up and running, you just need these two files on your MacBook – that's your entire setup, a fully self-contained package. You don't need an internet connection or anything else. Just compile your C code, get a binary, and you're all set to interact with this language model. Say you want to test its creativity – you could ask it to write a poem about a specific topic. The model will start generating text in response, following your directions, and voilà, you have your poem.

The model inference, i.e. the process of running the Llama2-70b model described in the run.c file, might seem like a complex task, but it's surprisingly straightforward. The run.c file contains the code for operating the neural network: it includes the implementation of the architecture and the forward pass of the neural network, all of which are algorithmically understood and openly accessible. But the real magic of the model is nestled within its parameters. It's these parameters that embody the model's ability to understand and generate language, and obtaining them is where the real challenge and complexity lie. These parameters are the result of an extensive and complex process known as model training.

This is where the model truly comes to life and differentiates from model inference.

核心组件：参数和运行文件

就像我们所知的，Llama2-70b 模型其实只由两个文件组成，存在于你的电脑文件系统中：参数文件和运行文件。参数文件可以说是包含了模型的「大脑」—— 也就是构成语言模型的神经网络的权重或参数。而 run.c 文件则是一种代码，负责让这些参数发挥作用。

图片：大语言模型的核心组成部分

这个模型的每个参数都是用两个字节来储存的，所以整个参数文件的大小高达 140 GB。之所以用两个字节，是因为它们是 16 位浮点数（float16）。除了这些参数外，你还需要一些代码来运行这个神经网络，这就是运行文件的用处。这个文件可以是 C 语言文件、Python 文件或者任何其他编程语言的文件，但简单起见，我们假设它是用 C 语言编写的。你大概只需要大约 500 行的 C 语言代码，不依赖于其他任何东西，就能利用这些参数来实现神经网络的架构。

所以，要启动和运行 Llama2-70b 模型，你的 MacBook 上只需要这两个文件 —— 这就是你需要的全部配置，一个完整独立的套件。你不需要连接互联网或其他任何设备。只需编译你的 C 语言代码，生成一个二进制文件，你就可以开始与这个语言模型进行交互了。例如，如果你想测试它的创造力，你可以让它围绕一个特定主题写一首诗。模型会根据你的指示开始生成文本，很快，一首诗就呈现在你面前了。

模型推理，也就是运行 run.c 文件里所描述的 Llama2-70b 模型，看起来可能很复杂，但其实意外地简单。run.c 文件包含操作神经网络的代码，涵盖了架构的实施和神经网络的前向传播，这些都是可以通过算法来理解并且开放获取的。但模型的神奇之处真正蕴藏在它的参数里。这些参数赋予了模型理解和生成语言的能力，而获取这些参数才是真正的挑战和复杂之所在。这些参数是通过一种广泛而复杂的过程得到的，那就是模型训练。

正是在这个阶段，模型才真正展现出生命力，与模型推理形成鲜明对比。

### 02. Training a Large Language Model

Training a large language model like Llama2-70b is a complex task. It's like to compressing a significant portion of the internet. Thanks to Meta AI's openness with the Llama2-70b, we have a clear picture of the training process from their published information.

02 训练一个大语言模型

训练像 Llama2-70b 这种大语言模型是一项艰巨的任务，就像是在压缩互联网的一个重要部分。多亏了 Meta AI 对 Llama2-70b 的开放性，我们可以通过他们发布的信息，清楚地了解到训练过程的全貌。

#### Pre-training, The First Stage of Training

To give you an idea, the training starts with around 10 terabytes of text, usually gathered from a comprehensive crawl of the internet. Imagine hoarding a vast array of text from countless websites – that's the scale of data we're talking about.

This data is then fed into a GPU cluster, a group of specialized computers designed for intense computational tasks like training neural networks. For the Llama2-70b, you'd need about 6,000 GPUs running continuously for approximately 12 days, costing around $2 million. This process effectively compresses that enormous chunk of internet data into the 140 gigabytes parameters file, a condensed 'zip file' of the internet, albeit in a lossy compression format. The compression ratio here is roughly like 100x, but this is not exactly a zip file because a zip file is lossless compression. So unlike a zip file, which is a perfect copy, these parameters are more about capturing the essence of the text we trained on, not an exact replica.

Fig: Compressing the internet to compute the LLM parameters

It's important to note that the numbers we're discussing here, impressive as they are, are actually considered modest by today's standards. When we look at state-of-the-art neural networks like ChatGPT, Claude, or Bard, the scale of parameters, computational resources, and costs are significantly higher – often by an order of magnitude or more. Modern training runs can cost tens or even hundreds of millions of dollars, involving much larger data sets and computational clusters. However, once you have these parameters, running the neural network becomes relatively inexpensive computationally.

训练的首阶段：预训练

想象一下，训练过程从大约 10 TB（TB = 10 亿 GB）的文本开始，这些文本大多来自于对互联网的全面抓取。想象一下，这就像从无数网站搜集了一座巨大的文本山。

接着，这些数据会被输入到一个 GPU 集群中，这是一组专门用于处理如神经网络训练等高强度计算任务的电脑。以 Llama2-70b 为例，需要约 6000 个 GPU 持续运转约 12 天，耗资约 200 万美元。通过这一过程，我们将这庞大的互联网数据压缩成一个 140 GB 的参数文件，有点像互联网的「zip 文件」，尽管它是有损压缩的。这种压缩的比例大约是 100 倍，但它并非真正的 zip 文件，因为 zip 是无损的。与 zip 文件不同，它不是完美的复制品，这些参数更多地是捕捉我们训练文本的精髓，而不是精确复制。

图片：为计算大语言模型的参数而对互联网进行压缩

值得一提的是，尽管这些数字听起来很惊人，但按照当今的标准，它们实际上还算是中等水平。当我们看到 ChatGPT、Claude 或 Bard 这样的前沿神经网络时，它们的参数规模、计算资源和成本通常要高得多，有时甚至是原来的十倍或更多。现代的训练过程可能耗资数千万甚至数亿美元，涉及更大的数据集和计算集群。但一旦拥有了这些参数，运行这些神经网络在计算上就相对便宜了。

#### The Predictive Power of Neural Networks

What is this neural network actually doing? It primarily focuses on predicting the next word in a sequence. Imagine feeding a sequence of words, such as "cat sat on a", into the neural network. This network is loaded with parameters, encompassing neurons interconnected in various ways, all responding to the input. The result is a prediction of the next word. For example, in our case, the neural network might predict "mat" as the next word with a 97% probability.

Fig: Next word prediction in a neural network

You can show mathematically that this prediction task is closely linked to compression, which is why training the neural network can be compared to compressing a significant portion of the internet. Because if you can predict the next word very accurately, you can use that to compress the data set. So it's just a next word prediction neural network: you give it some words, it gives you the next word.

The outcome of this training process is quite remarkable. The task of next-word prediction, although seemingly straightforward, is incredibly powerful. It compels the neural network to absorb extensive knowledge about the world within its parameters. Consider a web page about Ruth Handler as an example. For the neural network to predict the next word, it needs to understand various details about Ruth Handler, when she was born and when she died, who she was, what she's done, and so on.

Through next-word prediction, the network learns extensively about the world, compacting this knowledge into its parameters.

神经网络的预测魔力

神经网络到底有何神奇之处呢？它的核心功能是预测文本序列中的下一个词。想象一下，把一串词，比如「cat sat on a」（猫坐在一个），输入这个网络。这个网络包含了众多参数，由不同方式连接的神经元组成，对输入的词汇进行响应。最终，它会预测出下一个词。例如，在我们的例子中，神经网络可能会以 97% 的概率预测下一个词是「mat」（垫子）。

图片：神经网络中的下一词预测过程

从数学角度来看，这种预测任务与数据压缩有着密切的关联。这就是为什么我们说训练神经网络就像是在压缩互联网的大量信息。如果你能精准预测下一个词，就可以用这个能力来压缩数据集。换句话说，这就是一个下一个词预测的神经网络：输入一些词，它就会告诉你接下来的词。

这个训练过程带来的成果非常惊人。表面上简单的下一个词预测任务，实则拥有巨大的能力。它促使神经网络吸收大量关于世界的知识，并存储在其参数中。例如，考虑一下关于 Ruth Handler 的网页。为了预测下一个词，神经网络需要理解 Ruth Handler 的各种信息，包括她的生卒年月、身份、成就等等。

通过预测下一个词的方式，神经网络深入学习了关于世界的信息，并将这些知识密集地储存在其参数里。

#### The Generative Nature of Neural Networks

Once we've trained these neural networks, using them becomes a fascinating process. Model inference, or what we might call using the model, is relatively straightforward. We start by generating what comes next, sampling from the model's predictions. You pick a word, feed it back into the model, and get the next word. This process repeats, creating a chain of words. It's like the network is dreaming up internet documents.

Imagine running the neural network, or performing inference. The results can be quite intriguing, almost as if the network is dreaming up web pages. This happens because the network was trained on web pages, and when you let it loose, it starts mimicking those documents. In the example below, you might see it generating something that looks like Java code on the left side; in the middle, it could be producing text resembling an Amazon product listing, and on the right, something akin to a Wikipedia article.

Fig: Generative examples of a neural network

Take the example in the middle: everything from the title to the author and the ISBN number is entirely fabricated by the network. It's creating text based on the distribution of data it was trained on, essentially hallucinating these documents. For instance, the ISBN number it generates likely doesn't exist in reality. The network understands that after "ISBN" and a colon, there should be a number of a certain length, and it fills in what seems plausible.

One interesting aspect is how the network handles facts. For example, in the piece on the right about a fish named 'blacknose dace,' the information isn't lifted verbatim from a training document. Instead, the network has learned about this fish and can produce text that's roughly accurate, even if it's not a direct copy from its training. It's this 'lossy compression' of the internet at work. The network retains the gist of the information, weaving its knowledge into the generated text.

What's important to know is that you can't always be sure if the output is accurate or a bit of a hallucination. Some of it could be memorized from the training data, while some might not be. This ambiguity is part of what makes interacting with these models so interesting. For the most part, they're dreaming up internet text based on their vast data distribution, producing content that's a blend of learned knowledge and creative extrapolation.

神经网络的生成魔法

在训练完这些神经网络后，使用它们的过程变得极为有趣。模型推理（model inference），也就是我们通常所说的使用模型，其过程相对简单。我们首先生成下一个可能的内容，从模型的预测中进行采样。你选择一个词，将其输入模型，然后获得下一个词。这个过程不断重复，形成一串词链。这就像网络在自主创造互联网文档一样。

想象一下运行神经网络或执行模型推理的场景。结果往往令人惊叹，仿佛网络在自主创造网页内容。这是因为神经网络是基于网页数据训练的，当我们让它自由发挥时，它就开始模仿这些文档。在下面的例子中，你可能会看到左侧生成的类似 Java 代码的内容；中间部分可能是类似 Amazon 产品列表的文本；而右侧则可能是类似维基百科文章的内容。

图 1：神经网络生成的示例

以中间的例子为例：从标题到作者，再到 ISBN 号，所有内容都是神经网络凭空创造的。它根据训练数据的分布生成文本，本质上是在「想象」这些文档。例如，它生成的 ISBN 号在现实中可能并不存在。神经网络理解在「ISBN」和冒号之后应该跟随一个特定长度的数字，于是它填入了看似合理的内容。

神经网络处理事实的方式也很有趣。比如，右侧关于一种名为「blacknose dace」（黑鼻鲦鱼）的鱼的文章，其中的信息并非直接从训练文档中复制。相反，网络已经学习了关于这种鱼的知识，能够生成大致准确的文本，即使这些文本并非直接来自其训练数据。这就是互联网信息「有损压缩」（lossy compression）的效果。神经网络保留了信息的核心，将其知识巧妙地融入生成的文本中。

需要注意的是，我们无法总是确定输出的内容是准确的还是神经网络的「想象」。其中一些信息可能是从训练数据中直接记忆的，而另一些则可能是神经网络自行推断的。这种不确定性正是与这些模型互动如此有趣的原因之一。大多数情况下，它们是基于庞大的数据分布来「创造」互联网文本，产生的内容是学习到的知识和创造性推断的独特结合。

#### Understanding How Neural Networks Work

Let's shift focus to how neural networks function, particularly when it comes to performing next-word prediction. This is the point where the process becomes a bit more complex. To better understand, let's consider a simplified diagram of a neural network's inner mechanics. What we're examining here is the Transformer neural network architecture, which is fundamental to these sophisticated models.

Fig: The Transformer neural network architecture

The fascinating thing about these neural networks is that we fully understand their architecture. We know the exact mathematical operations that occur at every stage. However, the challenge lies in the sheer number of parameters – we're talking about hundreds of billions dispersed throughout the network. These parameters are the key players in the network, and while we know how to iteratively adjust them to improve the network's performance in next-word prediction, their exact role and collaboration in this process remain somewhat mysterious.

We know how to optimize these parameters, we know how to adjust them over time to get a better next word prediction, but how these parameters work together to achieve this is not entirely clear. We have models and theories that suggest they build and maintain a type of knowledge database, but even this is not straightforward. The knowledge within these networks can be peculiar and one-dimensional.

A viral example that illustrates this is the 'reversal course' observed in ChatGPT and GPT-4 interactions. For instance, if you ask who Tom Cruise's mother is, it correctly identifies Marilyn Lee Pfeiffer. But, when the question is reversed to who Marilyn Lee Pfeiffer's son is, the model draws a blank. This kind of one-dimensional knowledge is intriguing and highlights the unique nature of these models.

Fig: Reversal course example (Note that this is fixed with LLM browsing)

In essence, large language models (LLMs) are mostly inscrutable artifacts, unlike anything else in traditional engineering. They don't resemble a car, where each part is understood and fits into a clear structure. Instead, they are the outcome of a lengthy optimization process, and our understanding of their inner workings is still evolving. There's a field called interpretability, or mechanistic interpretability, dedicated to deciphering what each part of the neural net does. While we can gain some insights, a complete understanding is still out of reach.

Currently, we treat these neural networks as empirical artifacts. We input data, observe the outputs, and measure their behavior based on the text they generate in various situations. Therefore, working with these models requires sophisticated evaluations due to their empirical nature. It's a journey of exploration and understanding, one step at a time.

理解神经网络的工作原理

让我们把重点转向神经网络的运作方式，特别是在进行下一个词预测（next-word prediction）时。这个过程变得稍微复杂一些。为了更好地理解，我们来看一个简化的神经网络内部机制图。这里我们研究的是 Transformer 神经网络架构（一种用于序列处理的深度学习模型），它是这些复杂模型的基础。

图 1：Transformer 神经网络架构

这些神经网络最令人着迷的一点是，我们完全理解它们的架构。我们知道每个阶段发生的具体数学运算。然而，挑战在于参数的庞大数量 —— 我们谈论的是数百亿个分布在整个网络中的参数。这些参数是网络的关键组成部分。虽然我们知道如何通过迭代来调整它们以提高网络在下一个词预测中的表现，但它们在这个过程中的具体作用和协作方式仍然有些神秘。

我们知道如何优化这些参数，知道如何随时间调整它们以获得更好的词语预测效果，但这些参数如何协同工作以实现这一目标并不完全清楚。我们有一些模型和理论，认为它们构建和维护了某种知识数据库，但即使这个过程也不是简单直接的。这些网络中的知识可能呈现出奇特和单向的特性。

一个广为流传的例子很好地说明了这一点，就是在 ChatGPT 和 GPT-4 的交互中观察到的「反向查询」现象。比如，如果你问 Tom Cruise 的母亲是谁，它能正确地回答是 Marilyn Lee Pfeiffer。但是，当你反过来问 Marilyn Lee Pfeiffer 的儿子是谁时，模型却无法回答。这种单向知识很有趣，也凸显了这些模型的独特性质。

图 2：反向查询示例（注：这个问题在使用大语言模型（LLM）浏览功能后已得到解决）

本质上，大语言模型（Large Language Models，LLMs）大多是难以解析的人工制品，与传统工程中的任何东西都不同。它们不像汽车，每个部件的功能都清晰可知，并能组成一个明确的结构。相反，它们是长期优化过程的结果，我们对它们的内部运作机制的理解仍在不断发展。有一个称为可解释性（interpretability）或机制可解释性（mechanistic interpretability）的研究领域，致力于解密神经网络每个部分的作用。虽然我们能获得一些洞见，但完全理解仍然遥不可及。

目前，我们将这些神经网络视为经验性的产物。我们输入数据，观察输出，并根据它们在各种情况下生成的文本来评估它们的行为。因此，由于这些模型的经验性质，使用它们需要复杂的评估方法。这是一个探索和理解的过程，我们正在一步一步地推进。

### 03. Fine Tuning, The Second Stage of Training

In our exploration of neural networks, we've mainly discussed their role as internet document generators. But there's more to these models. We're now entering the second stage of training, known as fine-tuning, which transforms these networks from mere generators of content into something far more practical: AI assistants.

So far, we've seen how neural networks can churn out text similar to what you might find across the internet. We called this stage pre-training. However, for many tasks, simply generating documents isn't enough. What's truly valuable is an assistant model, one that can answer questions and provide information based on those queries.

The process to develop these assistant models is intriguing. The optimization process, focused on the next-word prediction task, remains the same. What changes, however, is the data set. Instead of training on a vast array of internet documents, the focus shifts to manually collected, more specific data sets.

How do we create these new training sets? It involves a lot of people. Typically, companies hire teams to curate these data sets. These teams are given detailed labeling instructions and tasked with coming up with questions and crafting appropriate responses.

Here's a simple example of what this training data might look like: a user asks, "Can you write a short introduction about the relevance of the term 'monopsony' in economics?" Then, based on the labeling instructions, someone writes the ideal response that an assistant should give. The nature and quality of these responses are guided by detailed documentation provided by the engineers at companies like OpenAI or Anthropic.

Fig: ~100,000 conversations written by people used to fine-tune the model

While the pre-training stage is about processing a large quantity of text, albeit of variable quality from the internet, the fine-tuning stage prioritizes quality over quantity. Here, the focus might be on fewer documents – say, 100,000 – but each one is a part of a high-quality conversation, carefully crafted based on labeling instructions. This stage is crucial in transforming a neural network from a general document generator to a specialized AI assistant, capable of understanding and responding to specific queries.

深入训练，走向实用化的第二阶段

在我们深入了解神经网络的过程中，我们大多关注它们在互联网文档生成方面的作用。但其实，这些模型的能力远不止于此。现在，我们正步入训练的关键第二阶段 —— 精调，这一阶段将把这些网络从简单的内容生成器转变成更具实用性的 AI 助手。

目前为止，我们观察到神经网络能够生成类似互联网上的文本内容，这被称为预训练阶段。但对于许多任务来说，仅仅生成文本是远远不够的。更有价值的是，能够回答问题并基于这些问题提供信息的 AI 助手模型。

开发这类 AI 助手的过程非常有趣。优化过程依然聚焦于下一个单词预测任务，但数据集发生了变化。与其在海量的互联网文档上进行训练，不如转向更为专门且手动收集的数据集。

那么，这些新训练集是如何构建的呢？这需要很多人的参与。通常，公司会组建专门团队来整理这些数据集。这些团队按照详细的标注指引工作，负责提出问题并设计合适的答案。

比如，训练数据可能是这样的：一个用户问，「能否写一段关于经济学中‘垄断性买方市场'重要性的简介？」然后，根据标注指引，有人会编写 AI 助手应给出的理想答案。这些答案的性质和质量都受到了像 OpenAI 或 Anthropic 这样的公司工程师提供的详细指导文件的影响。

图片：~100,000 条由人工编写的对话，用于对模型进行精调

如果说预训练阶段是处理大量互联网上参差不齐的文本，那么精调阶段则更注重质量而非数量。在这里，我们可能只关注少量的文档 —— 比如说 100,000 条 —— 但每一条都是精心制作的高质量对话，严格遵循标注指引。这一阶段对于将神经网络从泛泛的文档生成器转化为能够精确理解和回应特定问题的专业 AI 助手来说，至关重要。

#### From Document Generators to AI Assistants

In the journey of evolving neural networks into AI assistants, the key lies in the process of fine-tuning. This is where we make a crucial swap in the training dataset. Instead of the general internet text used in pre-training, we now focus on question-and-answer (Q&A) documents. This shift in training material is what enables us to develop what we call an assistant model.

During fine-tuning, the neural network learns to adapt to the format of these new training documents. For example, if you present a question like, "Can you help me with this code? It seems like there's a bug: print("Hello World)", the model, post-fine-tuning, understands that it should respond in the style of a helpful assistant. This ability is remarkable, especially considering that this specific question might not have been part of its training set. The model generates a response word by word, crafting a reply that aligns with the query.

What's remarkable, and not entirely understood, is how these models manage to shift their output format from generating general internet content to acting as helpful assistants. They achieve this transformation by absorbing the style and structure of the Q&A documents encountered in the fine-tuning stage. Yet, impressively, they still retain and utilize the vast knowledge they acquired during the pre-training phase.

To put it simply, the pre-training stage involves training on a vast amount of internet data, focusing on accumulating knowledge. In contrast, the fine-tuning stage is about alignment – it's about reshaping the model's output from generic internet documents to specific question-and-answer formats in a helpful, assistant-like manner.

从文档生成器到 AI 助手的转变

在神经网络向 AI 助手演变的过程中，微调 (fine-tuning) 是一个关键步骤。这个步骤的核心是改变训练数据集的内容。我们不再使用预训练 (pre-training) 阶段的普通互联网文本，而是转向专注于问答 (Q&A) 文档。正是这种训练材料的改变，让我们得以构建所谓的助手模型。

在微调过程中，神经网络学习如何适应这些新的训练文档格式。比如，当你问：「能帮我看看这段代码吗？似乎有个 bug：print("Hello World)」，微调后的模型会理解它应当以一个助手的身份提供帮助。这种能力非常惊人，尤其是当这个具体问题可能并未出现在其训练集中时。模型能够逐字逐句地生成回答，制造出与问题相匹配的答复。

这些模型如何能够从制造普通互联网内容转变为一个有帮助的助手，这一点仍然充满神奇。它们通过在微调阶段吸收问答文档的风格和结构来实现这种转变。更令人印象深刻的是，它们依然保持并运用了在预训练阶段积累的丰富知识。

简单来说，预训练阶段是在大量互联网数据上进行训练，主要目的是知识积累。而微调阶段则专注于对齐和调整，把模型的输出从普通的互联网文本转变为更具针对性、更像助手的问答格式。

#### The Mechanics of Fine-Tuning

To summarize, the process of creating something like ChatGPT has two major stages. The first stage is pre-training, where the network is fed a ton of internet text. This requires a cluster of GPUs, specialized computers designed for such parallel processing workloads. These aren't your everyday computers; they are high-end, expensive machines. In this stage, the internet text is compressed into the neural network's parameters, typically costing millions of dollars. This gives us the base model, a part of the process that is highly computationally expensive and usually carried out by companies maybe once a year or even less frequently due to the costs involved.

After developing the base model, the second phase is the fine-tuning stage, which is significantly less computationally intensive. In this stage, the focus shifts to defining how the AI assistant should behave. This involves writing specific labeling instructions and then employing people to create documents that align with these instructions. An example task might be collecting 100,000 high-quality, ideal question-and-answer responses for fine-tuning the base model. This process is not only more affordable but also faster – it might take just a day compared to several months in the pre-training stage. The outcome of this stage is an effective assistant model.

Once the assistant model is ready, it undergoes evaluations, deployment, and continuous monitoring. Misbehaviors are identified, and for each, a corrective action is initiated. The process involves taking conversations where the assistant gave incorrect responses and having a person rewrite them with the correct ones. These corrected responses are then incorporated into the training data, so the next time the fine-tuning process is run, the model improves in those specific scenarios. Because fine-tuning is less expensive, it allows for frequent iterations, enabling companies to update and improve their AI models more regularly compared to the pre-training stage.

It's worth noting the approach taken by Meta with their Llama 2 series. When Meta released this series, they included both the base models and the assistant models. While the base models aren't directly usable for answering questions (they tend to generate more questions or unrelated content as they are essentially internet document samplers), they are valuable. Meta has undertaken the expensive and resource-intensive part of the process, the first stage, providing a solid foundation for others to build upon. This offers a great deal of freedom for further fine-tuning. Additionally, Meta also released assistant models, ready for immediate use in Q&A applications.

This iterative process of improvement and the ability to fine-tune models offer significant flexibility and efficiency in evolving AI assistants. By regularly updating and refining these models, companies can continuously enhance their AI's performance, making them more responsive and accurate in their interactions.

精调机制的原理

总结来说，打造像 ChatGPT 这样的产品，包含了两个关键阶段。首先是预训练阶段，这时网络被大量互联网文本所充斥。此过程需要用到 GPU 集群，这些专业计算机专为并行处理任务而设计。它们远非日常电脑，而是价格高昂的高端设备。在此阶段，互联网文本被压缩进神经网络的参数中，通常耗资上百万美元。这样，我们就得到了基础模型，一个计算成本极高的过程，通常由公司每年甚至更少频率进行，主要因为涉及的成本。

基础模型开发完毕后，接下来是精调阶段，这个阶段的计算需求相对较低。重点转向如何定义 AI 助理的行为。这包括编写具体的标注指令，并雇用人员制作符合这些指令的文档。例如，可能需要收集 10 万条高质量的理想问答，用于对基础模型进行精调。这个过程不仅成本更低，而且速度更快 —— 可能只需一天，而预训练阶段则需几个月。其成果是一款高效的助理模型。

一旦助理模型准备就绪，它就会经历评估、部署和持续监控。针对每一次不当行为，都会采取相应的纠正措施。这一过程包括对助理给出错误回应的对话进行改写，以正确的回应取代。这些改正后的回应随后纳入训练数据，使得下一轮精调时，模型能在这些特定场景下得到改善。由于精调成本较低，它让公司能够更频繁地迭代更新，使 AI 模型相较于预训练阶段能够更加规律地得到优化。

值得一提的是 Meta 在其 Llama 2 系列中采取的策略。Meta 发布此系列时，不仅包含了基础模型，还有可直接用于问答应用的助理模型。尽管基础模型不适合直接回答问题（它们更多生成问题或无关内容，因为本质上是互联网文档采样器），但它们仍具有重要价值。Meta 承担了开发过程中成本高昂、资源密集的第一阶段，为其他人提供了坚实的基础，进一步精调提供了广阔的自由度。此外，Meta 还发布了可立即用于问答应用的助理模型。

这一不断进步的迭代过程以及微调模型的能力，极大地提高了发展 AI 助手的灵活性和效率。公司通过定期更新和精细化这些模型，可以持续提高 AI 的性能，使其在交互中更加迅速、精准。

### 04. Reinforcement Learning from Human Feedback, The Third Stage of Training

After pre-training and fine-tuning, we can have an additional, optional, third stage: Reinforcement Learning from Human Feedback or RLHF, as called at OpenAI. This stage introduces a unique approach - the use of comparison labels - which brings a different dimension to refining AI models.

Here's how it works: Often, for human labelers, it's easier to compare potential answers than to generate them from scratch. Let's take a practical example. Imagine the task is to write a haiku about paperclips. For a labeler, creating a haiku from nothing can be daunting. However, if they are presented with several haikus already generated by the assistant model from Stage 2, their job becomes much simpler. They can then evaluate these options and pick the one that best fits the criteria. This comparison approach is at the heart of Stage 3 fine-tuning, enabling further refinement of the model by choosing between pre-generated alternatives.

Fig: Selecting a good haiku is easier than creating one

The technicalities of the RHLF process are complex, but the essence is using these comparison labels for additional performance gains in language models. To give you an idea of the human aspect in this, consider the 'Instruct GPT' paper by OpenAI. It outlines the labeling instructions provided to human evaluators. While these instructions are to be helpful, truthful, and harmless, the full documentation can extend to dozens or even hundreds of pages, reflecting the depth and complexity of the task.

Fig: RHLF labeling instructions sample

This third stage of fine-tuning, employing comparisons, adds an interesting layer to the training process, allowing for nuanced improvements and adjustments based on human judgment and preferences.

基于人类反馈的强化学习：训练的第三阶段

在完成预训练和微调后，我们还可以进行一个额外的、可选的第三阶段：基于人类反馈的强化学习（Reinforcement Learning from Human Feedback，RLHF），这是 OpenAI 公司提出的概念。这个阶段引入了一种独特的方法 —— 使用比较标签，为 AI 模型的优化带来了新的维度。

这个过程是这样工作的：对于人类标注者来说，比较几个可能的答案通常比从头创造答案要容易得多。让我们看一个具体的例子。假设任务是写一首关于回形针的俳句（一种日本短诗，通常由 17 个音节组成）。对于标注者来说，从零开始创作一首俳句可能会很困难。但是，如果给他们展示几首由第二阶段训练的 AI 助手模型生成的俳句，他们的工作就会变得简单许多。他们只需要评估这些选项，并选出最符合要求的一首。这种比较方法是第三阶段微调的核心，通过在预先生成的多个选项中进行选择，实现了模型的进一步优化。

图 1：选择一首好的俳句比创作一首更容易

RLHF 过程的技术细节很复杂，但其核心是利用这些比较标签来进一步提升语言模型的性能。为了让你了解其中涉及的人为因素，我们可以参考 OpenAI 的「Instruct GPT」（指令 GPT）论文。该论文概述了提供给人类评估者的标注指南。这些指南要求模型的输出要有帮助、诚实且无害，但完整的文档可能长达几十甚至上百页，反映了这项任务的深度和复杂性。

图 2：RLHF 标注指南示例

这第三阶段的微调采用了比较的方法，为训练过程增加了一个有趣的维度。它允许基于人类的判断和偏好对模型进行精细的改进和调整。

#### Streamlining AI Development: Human-Machine Collaboration and Competing Language Models

As we delve deeper into the process of developing large language models, it's important to note that the role of humans in creating these models is evolving. Initially, it might seem like a process heavily reliant on manual, human effort. However, as these language models improve, the dynamics are shifting towards a more collaborative approach between humans and machines.

Increasingly, the process of generating labels and responses involves both human oversight and machine intelligence. For instance, language models can be used to sample answers, and then human labelers might cherry-pick parts of these answers to create the best possible response. Alternatively, humans might use these models to verify their work, or even to generate comparisons where they simply act in an oversight capacity. This evolving dynamic is like adjusting a slider – as the models become more capable, we can increasingly rely on them, moving the slider further towards machine-generated content.

优化 AI 开发流程：人机协作与语言模型的良性竞争

在深入探讨大语言模型（Large Language Model）的开发过程时，我们不得不注意到人类在这个领域中的角色正在发生有趣的变化。起初，这个过程看起来似乎高度依赖人工操作。然而，随着语言模型的不断进步，我们正在见证一种新的趋势：人类和机器之间的协作正变得越来越紧密。

如今，生成标签和回答的过程越来越多地融合了人工监督和机器智能。举个例子，我们可以先用语言模型生成一批候选答案，然后让人类标注员从中挑选出最优秀的部分，组合成一个完美的回答。另一种方式是，人类可以借助这些模型来检查自己的工作成果，甚至让模型生成多个答案供人类比较和选择，此时人类更多地扮演了一个监督者的角色。这种不断演进的协作模式，就像是在调节一个精密的控制旋钮。随着模型变得越来越强大，我们可以逐渐将这个旋钮转向机器生成的内容，越来越多地依赖 AI 的能力。这不仅提高了效率，也为 AI 开发带来了新的可能性。

### 05. The Competitive Landscape of AI Language Models: Proprietary vs. Open Source

To illustrate the advancements in this field, let's look at the competitive landscape of large language models. Consider the 'Chatbot Arena' managed by a team at Berkeley. Here, different language models are ranked by their Elo rating, a system similar to that used in chess to rank players based on win rates. In this arena, users can enter questions and receive responses from two different models, without knowing which models generated the responses. They then pick the winner, and based on these outcomes, the models' Elo scores are calculated, with higher scores indicating better performance.

Fig: LLMs ranked by their Elo rating in the Chatbot Arena

This leaderboard is a fascinating way to see how various language models stack up against each other and provides insight into their evolving capabilities in real-world scenarios.

As we dive deeper into the world of AI language models, it's interesting to observe the current landscape and how different models stack up against each other. At the top of the performance ladder, you'll find proprietary models. These are closed models, meaning their weights aren't accessible to the public. They're typically available behind a web interface. The GPT series from OpenAI and the Claude series from Anthropic are prime examples of such models. Additionally, there are other series from various companies also occupying this top tier.

Just below these top performers are the models with open weights. These models are more transparent, with more information publicly available, often accompanied by detailed research papers. An example of this category is the Llama 2 series from Meta. Further down, you might come across models like Zephyr 7b beta, part of the Mistral series from a French startup.

The current ecosystem shows a clear trend: the closed, proprietary models tend to perform better. However, the catch is that you can't directly work with them in terms of fine-tuning, downloading, etc. Your access is usually limited to a web interface. Following these are the open-source models and their ecosystem. While these models generally don't perform as well as their closed counterparts, they might be sufficient depending on the application's requirements.

Right now, the open-source community is focused on enhancing performance to catch up with the proprietary models. This dynamic creates an interesting scenario in the AI industry, where open-source efforts are continually evolving to match the standards set by proprietary models.

05 AI 语言模型的竞争格局：专有模型与开源模型的较量

为了更好地理解人工智能领域的最新进展，让我们一起来看看大语言模型（Large Language Model，LLM）的竞争格局。有一个有趣的项目叫做「聊天机器人竞技场」（Chatbot Arena），它由伯克利大学的一个研究团队管理。这个竞技场采用了一种叫做 Elo 评分系统的方法来给不同的语言模型排名，这个系统的原理类似于国际象棋中用来根据选手胜率进行排名的方法。

在这个虚拟竞技场中，用户可以提出问题，然后获得来自两个不同模型的回答，但用户并不知道具体是哪个模型给出的回答。用户选择他们认为更好的回答，基于大量用户的选择结果，系统会计算出每个模型的 Elo 分数。分数越高，就意味着模型的表现越好。

图：在聊天机器人竞技场中按 Elo 评分排名的大语言模型

这个排行榜为我们提供了一个绝佳的窗口，让我们能够直观地比较各种语言模型的表现，并了解它们在真实场景中的实际能力。

当我们深入探索 AI 语言模型的世界时，我们会发现一个有趣的现象：在性能排行榜的顶端，往往是一些专有模型。这些模型是封闭的，也就是说，它们的核心技术（比如模型权重）并不对外公开。用户通常只能通过网页界面来使用这些模型。比如，OpenAI 开发的 GPT 系列和 Anthropic 公司的 Claude 系列就是这类顶级专有模型的代表。除此之外，还有其他科技公司开发的模型也占据了性能排行榜的前列。

紧随其后的是一些开放权重的模型。这些模型相对更加透明，有更多公开可用的技术信息，通常还会发布详细的研究论文。Meta 公司的 Llama 2 系列就是这类模型的典型代表。再往后，你可能会看到一些相对较新的模型，比如来自法国初创公司的 Mistral 系列中的 Zephyr 7b beta。

目前的 AI 生态系统呈现出一个明显的趋势：封闭的专有模型往往表现更好。但是，这些模型也有一个明显的缺点：用户无法直接对其进行定制化操作，比如微调（fine-tuning）或下载到本地使用。用户通常只能通过网页接口来使用这些模型。相比之下，开源模型及其生态系统则提供了更多的灵活性。虽然这些开源模型的表现通常不如顶级专有模型，但对于许多应用场景来说，它们的性能可能已经足够了。

目前，开源社区正在全力以赴地提升模型性能，试图赶上专有模型的水平。这种竞争态势在 AI 行业中创造了一个有趣的局面：开源阵营不断进步，努力缩小与专有模型之间的差距，这无疑会推动整个行业的快速发展。

#### The Role of Scaling Laws in the Advancement of Language Models

Let's now delve into how language models are improving and the trajectory of these improvements. A key concept in understanding the advancement of large language models is what we call scaling laws. These laws reveal that the performance of these models, particularly in next-word prediction accuracy, is surprisingly predictable. It's based on just two variables: the number of parameters in the network (N) and the amount of text used for training (D).

Fig: Source: Training Compute-Optimal Large Language Models

With these two figures – N and D – we can accurately predict the performance of a language model in its next-word prediction task. What's truly remarkable is that there seems to be no ceiling to this trend. A larger model trained on more text consistently leads to improvements. This means that algorithmic progress, while beneficial, isn't the only path to more powerful models. We can achieve significant advancements by simply scaling up – using bigger computers and more data.

In practice, next-word prediction accuracy might not be our end goal, but this accuracy correlates with many other aspects we do care about. For instance, as we move up in the GPT series, from GPT-3.5 to GPT-4, we observe improvements across a variety of tests. The implication is clear: as we train larger models on more data, we can expect a rise in overall performance, almost effortlessly.

Fig: Source: Sparks of Artificial General Intelligence: Early experiments with GPT-4, Bubuck et al. 2023

This understanding has sparked a kind of gold rush in the computing world, where the focus is on acquiring bigger GPU clusters and more extensive datasets. There's a strong belief that these investments will yield better models. While algorithmic advancements are a welcome bonus, the true driving force is the guaranteed success offered by scaling. This approach has become the primary strategy for many organizations in the AI space, as they invest in scaling their resources to build increasingly powerful language models.

规模定律：推动语言模型飞速进步的秘密武器

让我们来探讨语言模型是如何不断进步的，以及这些进步的发展轨迹。要理解大语言模型（Large Language Model）的进步，一个关键概念是我们所说的「规模定律」。这些定律揭示了一个令人惊讶的事实：模型的性能，尤其是在预测下一个词的准确性方面，是高度可预测的。这种可预测性仅仅基于两个变量：网络中的参数数量（N）和用于训练的文本量（D）。

图 1：来源：训练计算最优大语言模型

有了这两个数字 N 和 D，我们就能准确预测语言模型在预测下一个词任务中的表现。更加令人惊叹的是，这种趋势似乎没有上限。更大的模型在更多文本上训练，始终能带来性能的提升。这意味着虽然算法的进步很重要，但它并不是提升模型能力的唯一途径。我们可以通过简单地扩大规模 —— 使用更强大的计算机和更多的数据 —— 来实现显著的进步。

实际上，预测下一个词的准确性可能不是我们的最终目标，但这个指标与我们关心的许多其他方面都有关联。例如，随着 GPT（Generative Pre-trained Transformer）系列模型的升级，从 GPT-3.5 到 GPT-4，我们可以观察到各种测试中的性能都有所提升。这清楚地表明：当我们在更多数据上训练更大的模型时，我们可以期待整体性能几乎是自然而然地提高。

图 2：来源：通用人工智能的火花：GPT-4 的早期实验，Bubuck 等人，2023

这种认识在计算领域引发了一场类似淘金热的竞赛，重点转向获取更大的 GPU（图形处理单元）集群和更庞大的数据集。业界普遍认为，这些投资将带来更强大的模型。虽然算法的突破也是值得欢迎的额外收获，但真正的驱动力是通过扩大规模来获得几乎可以保证的成功。这种方法已经成为 AI 领域许多组织的主要策略，它们纷纷投资于扩大资源规模，以构建越来越强大的语言模型。

### 06. Enhancing Large Language Model with External Tools - A demo

Let's take a closer look at the evolving capabilities of language models through a concrete example, moving beyond abstract descriptions. For this, I turned to ChatGPT with a specific task: to gather information about a company, Scale, and its funding rounds, including dates, amounts, and valuations, and organize it into a table.

ChatGPT, thanks to its fine-tuning stage training, understands that for such queries, it should not just rely on its built-in language model capabilities. Instead, it recognizes the need to use external tools to aid in task completion. In this scenario, a reasonable tool to use is a web browser to perform a search. Just as you or I would search online for this information, ChatGPT does something similar: it emits special words, indicative of the need to perform a search. These words can be interpreted and transformed into a query for a search engine like Bing.

Fig: ChatGPT using tools

Once the search is executed, just like we would browse through search results, ChatGPT processes the returned text. From this text, it then generates a response, mimicking the way humans research using browsing tools.

Fig: ChatGPT using Bing Search

The result from ChatGPT is organized and informative. It presents a table with funding rounds Series A through E, listing the date, amount raised, and implied valuation for each series. Notably, it provides citation links at the bottom, allowing users to verify the accuracy of the information. ChatGPT also transparently indicates where information was unavailable, such as the valuations for Series A and B, marking these as "not available" in the table.

This example illustrates how language models like ChatGPT are not just text generators but can effectively utilize external tools and resources to perform more complex research tasks, reflecting a significant evolution in their capabilities.

Continuing our exploration of large language models like ChatGPT, let's look into how they handle practical problem-solving by integrating various tools. To illustrate this, I interacted with ChatGPT, posing a challenge: to estimate the valuation for Series A and B of a company, Scale AI, using the data from Series C, D, and E.

In this task, we notice that ChatGPT recognizes its limitations, much like us humans when faced with complex math. It understands that for accurate calculations, it needs a calculator. So, ChatGPT signals this need, and proceeds to calculate ratios from the available data to estimate the missing valuations. This approach mirrors how we would tackle the problem, relying on tools to manage complex computations.

Fig: ChatGPT using calculator

Next, I asked ChatGPT to create a 2D plot of Scale AI's valuation over time. The instructions were specific: use a logarithmic scale for the y-axis, make it professional-looking with grid lines. ChatGPT responded by employing a Python interpreter and the Matplotlib library to craft the plot. The result? A precise graph that met the requested specifications, showing ChatGPT's ability to not just understand the task but to use coding tools to achieve it.

Fig: ChatGPT using Python interpreter

The tasks didn't stop there. I requested further analysis: adding a linear trend line to the plot and extrapolating Scale AI's valuation to the end of 2025. ChatGPT seamlessly wrote the necessary code and provided an analysis based on the fit. According to its calculations, Scale AI's valuation today stands at around $150 billion, with an expected rise to $2 trillion by the end of 2025.

Fig: ChatGPT writing code

I then challenged ChatGPT with a creative task: "Based on the information above, generate an image to represent the company Scale AI." Utilizing the context provided in our earlier conversation, ChatGPT demonstrated an understanding of Scale AI, potentially recalling details about the company stored in its network. For this task, it employed DALL·E, a tool developed by OpenAI, known for transforming natural language descriptions into images. The result was an image created by DALL·E, showcasing ChatGPT's ability to extend beyond text processing and collaborate with other AI tools for visual content generation.

Fig: ChatGPT using DALL·E

This demonstration practically illustrates the use of tools involved in problem solving by large language models. They're not just word samplers anymore; they're becoming sophisticated problem solvers, integrating various tools and computing infrastructure to handle complex tasks, much like humans do. This tool integration is a significant factor in the growing capabilities of these models, allowing them to perform comprehensive analyses, write code, and even create artistic representations.

06 用外部工具增强大语言模型：一个实例演示

我们通过一个实际案例来探索语言模型的先进能力，跳出理论性的讨论。在这个例子中，我利用 ChatGPT 完成一个特别的任务：搜集关于一家名为 Scale 的公司及其多轮融资的详细信息，包括融资时间、金额和估值，并整理成一张表格。

ChatGPT 在经过微调训练后，明白对于这类问题，它不能仅仅依赖内置的大语言模型（Large Language Model）能力。它知道要借助外部工具来完成任务。在此情境下，一个理想的选择是使用网络浏览器进行搜索。就像我们平时上网查找信息一样，ChatGPT 也会发出特定的指令，来表明需要进行网络搜索。这些指令能被转化成向搜索引擎（如 Bing）发出的查询。

图片：ChatGPT 正在使用外部工具

进行搜索后，就像我们浏览网页搜索结果一样，ChatGPT 会处理搜索回来的文本信息。然后，它会根据这些信息生成回答，仿照人类使用网络浏览器搜索和研究信息的方式。

图片：ChatGPT 使用 Bing 搜索

ChatGPT 的输出结果既有条理又充满信息。它制作了一张表格，列出了 Scale 公司从 A 轮到 E 轮的融资情况，包括每轮的日期、筹资金额和估值。特别的是，它在表格底部提供了引用链接，便于用户核实信息的真实性。此外，ChatGPT 也很透明地标明了某些信息的缺失，例如 A 轮和 B 轮的估值信息未提供，表格中标为「无法获取」。

这个示例展现了 ChatGPT 这类语言模型的非凡之处：它们不只是简单的文字生成器，还能有效运用外部工具和资源来完成更为复杂的研究任务，这标志着它们能力的显著演进。

当我们深入了解像 ChatGPT 这样的大语言模型时，可以发现它们在处理实际问题时如何巧妙地整合了各种工具。为了证明这一点，我向 ChatGPT 提出了一个挑战：利用 Series C、D 和 E 的数据来估算 Scale AI 公司的 Series A 和 B 的市值。

在这个任务中，我们可以看到 ChatGPT 也像我们人类一样，能够认识到自己在面对复杂数学问题时的局限。它明白为了进行精确计算，需要借助计算器。于是，ChatGPT 明确表示了这一需求，并利用手头的数据来计算比率，以此估算那些未知的市值。这个过程很像我们在处理难题时的方式：依赖工具来处理复杂的运算。

图片：ChatGPT 正在使用计算器

随后，我请求 ChatGPT 制作一个展示 Scale AI 市值随时间变化的二维图表。具体要求是：y 轴使用对数刻度，并且图表要有专业的外观，包括网格线。ChatGPT 应用了 Python 解释器和 Matplotlib 库来绘制这张图表。结果是什么？一个精准、符合所有要求的图表，不仅展现了 ChatGPT 对任务的理解，还体现了它运用编程工具实现目标的能力。

图片：ChatGPT 正在使用 Python 解释器

任务并没有就此结束。我接着要求对数据进行更深入的分析：在图表中加入一条线性趋势线，并预测 Scale AI 的估值直到 2025 年底的变化。ChatGPT 顺畅地编写出了所需代码，并根据趋势线分析提供了相应解读。据其计算，Scale AI 当前的市值大约是 1500 亿美元，预期到 2025 年底将增长至 2 万亿美元。

图片：ChatGPT 编写代码

随后，我向 ChatGPT 提出了一个更具创造性的挑战：「根据上述信息，设计一张能够代表 Scale AI 公司的图像。」ChatGPT 利用我们之前交谈中的信息，表现出对 Scale AI 的深刻理解，可能还回忆起了其网络中存储的有关该公司的细节。在这个任务中，它运用了 OpenAI 开发的 DALL·E 工具，这个工具擅长将文字描述转化为图像。DALL·E 创作出的这张图像，不仅展示了 ChatGPT 超越文字处理的能力，还体现了它与其他 AI 工具协作创造视觉内容的能力。

图片：ChatGPT 使用 DALL·E

通过这次展示，我们可以看到大语言模型在解决问题时如何运用各种工具。它们已经不仅仅是简单的文字处理工具，而是在像人类一样，通过整合多种工具和计算资源来处理复杂的任务。这种工具的整合是这些模型能力不断增强的关键，让它们不仅能进行深入的分析和编程，还能创作出具有艺术感的作品。

### 07. Multimodality in Large Language Models: From Vision to Audio

ChatGPT's ability to generate images marks a significant step in its journey towards multimodality. Multimodality is actually a significant axis along which large language models are improving. This isn't just about text anymore; it's about integrating various forms of media for a richer interaction. ChatGPT, for instance, has demonstrated its capability to not only generate images but also to interpret them.

A standout example of this is from a demo by Greg Brockman, one of OpenAI's founders. He showed ChatGPT a simple pencil-drawn sketch of a website layout. Remarkably, ChatGPT could understand this image and write functional HTML and JavaScript code for the website. Visiting the 'My joke' website, you can find a joke that can be clicked to reveal punchline, showcasing ChatGPT's ability to convert a visual sketch into a working web interface.

Fig: From sketch to working website

This development opens up a world where images can be seamlessly integrated into language models. ChatGPT can now process and utilize visual information alongside text, a capability expected to become more common in language models.

But multimodality goes beyond images. It also encompasses audio. ChatGPT's advancements now include the ability to 'hear' and 'speak', enabling speech-to-speech communication. This feature has been integrated into the ChatGPT iOS app, where you can engage in a conversation with ChatGPT in a manner reminiscent of the movie 'Her'. It's a truly unique and somewhat surreal experience, where typing is no longer necessary, and the AI responds verbally. It's an innovation that brings us closer to a more natural and human-like interaction with AI, and it's definitely worth trying out to experience its magic firsthand.

Fig: Speech interaction with AI as in the science fiction movie Her

07 大语言模型的多模态能力：从视觉到语音

ChatGPT 生成图像的能力标志着它在多模态发展道路上迈出的重要一步。多模态能力（Multimodality）实际上是大语言模型（Large Language Model）正在快速发展的一个重要方向。这种能力不再局限于处理文本，而是将各种形式的媒体整合在一起，实现更丰富的交互。例如，ChatGPT 不仅能生成图像，还能理解和解释图像。

OpenAI 创始人之一 Greg Brockman 的演示就是一个很好的例子。他向 ChatGPT 展示了一个简单的手绘网站布局草图。令人惊叹的是，ChatGPT 能够理解这个图像，并为其编写功能完整的 HTML（超文本标记语言）和 JavaScript（一种网页编程语言）代码。在生成的「My joke」网站中，用户可以看到一个笑话，点击后会显示笑点。这个例子生动地展示了 ChatGPT 将视觉草图转换为实际可用的网页界面的能力。

图 1：从草图到可用的网站

这一突破性进展为图像与语言模型的无缝集成开辟了新的可能性。ChatGPT 现在能够同时处理和利用视觉信息和文本，这种能力预计将在未来的语言模型中变得越来越普遍。

然而，多模态能力并不仅限于处理图像。它还包括了音频处理。ChatGPT 的最新进展包括了「听」和「说」的能力，实现了语音对话功能。这个功能已经被整合到 ChatGPT 的 iOS 应用中。用户可以与 ChatGPT 进行语音对话，这种体验让人联想到科幻电影《Her》中人类与 AI 助手的交互场景。这是一种独特而略显超现实的体验 —— 用户不需要打字，AI 会直接用语音回应。这项创新让我们离与 AI 进行更自然、更类人的交互更近了一步。我强烈建议大家亲身体验这种神奇的交互方式。

图 2：如科幻电影《Her》中的 AI 语音交互

### 08. Exploring Future Directions in Large Language Model Development

As we shift our focus to the future of large language models, it's essential to understand the current academic and research interests in this field. This isn't about specific product announcements or plans from OpenAI, but rather a broader perspective on where the development of these models is headed, based on academic research and publications.

One intriguing concept gaining attention is the distinction between 'System 1' and 'System 2' thinking, as popularized by the book "Thinking, Fast and Slow." This concept explores two distinct modes of brain function. System 1 represents the quick, instinctive, and automatic thinking processes. For instance, when asked "What is 2 plus 2?" the response "4" comes almost instantly, without conscious calculation. This answer is cached, ready to be retrieved instinctively.

Fig: Thinking Fast and Slow: System 1 vs. System 2 thinking

In contrast, System 2 involves a more rational, slower, and conscious mode of thinking, typically engaged for more complex decision-making. Take the question "What is 17 times 24?" for instance. Unlike the simple arithmetic of 2 plus 2, this problem doesn't have an instant answer. It requires conscious, effortful calculation to arrive at the correct result.

Another example can be found in chess. Speed chess relies on quick, instinctive moves without much time for deep thought, illustrating System 1 thinking in action. However, in a standard competition setting, players have more time to consider their moves, exploring various tree of possibilities and planning strategies. This is where System 2 thinking comes into play, involving a conscious and deliberate effort to analyze and make decisions.

Fig: System 1 vs. System 2 in chess

Understanding these two systems of thinking provides valuable insights into the potential development and evolution of large language models. As these models become more advanced, the integration of both instinctive (system one) and analytical (system two) capabilities could be a key area of focus, mirroring the complex decision-making processes of the human brain.

06 探索大语言模型未来发展的新方向

当我们将目光投向大语言模型（Large Language Models）的未来时，了解当前学术界和研究领域的关注焦点变得尤为重要。这里我们不讨论 OpenAI 等公司的具体产品发布或规划，而是要从学术研究和发表的文献中，获取一个更宏观的视角，探讨这些模型的发展方向。

这种宏观视角能帮助我们更好地理解大语言模型技术的整体发展趋势，而不仅仅局限于某个公司或产品的具体实现。通过关注学术界的研究重点，我们可以预见未来可能出现的突破性进展，以及这些进展可能带来的影响。

一个引人深思的概念正在学术界和大众中引发热议，这就是由畅销书《思考，快与慢》（Thinking，Fast and Slow）著名的「系统 1」和「系统 2」思维模式。这个理论探讨了人类大脑中两种截然不同的思考方式。其中，「系统 1」（System 1）代表了我们快速、直觉性和自动化的思维过程。举个简单的例子，当有人问你「2 加 2 等于多少？」时，「4」这个答案几乎是瞬间就蹦到你的脑海中，无需经过刻意的计算过程。这是因为这个答案已经被我们的大脑「存储」起来，可以随时快速调用。

图：思考快与慢：系统 1 与系统 2 思维的对比

相比之下，系统 2（System 2）思考涉及一种更加理性、缓慢且需要意识参与的思考方式，通常在面对更复杂的决策时会启动这种模式。让我们举个例子：「17 乘以 24 等于多少？」不同于 2 加 2 这样的简单算术，这个问题并不能立即得出答案。要得到正确结果，我们需要进行深思熟虑的运算，这个过程需要付出努力并且是有意识的。

国际象棋也提供了一个很好的例子。快棋比赛中，棋手需要凭直觉快速走子，几乎没有时间进行深入思考，这正是系统 1 思维（System 1 thinking，指快速、自动化的思维过程）在实际操作中的体现。相比之下，在标准比赛环境下，棋手有充足的时间思考每一步棋，他们可以探索各种可能的变化树，制定周密的战略。这时，系统 2 思维（System 2 thinking，指缓慢、需要努力的分析性思维）就开始发挥作用，涉及有意识和深思熟虑的分析与决策过程。

图：国际象棋中的系统 1 与系统 2 思维对比

理解这两种思考系统，为大型语言模型（large language models）的潜在发展和演变提供了宝贵的见解。随着这些模型变得越来越先进，将直觉性（系统一）和分析性（系统二）的能力整合在一起可能成为一个关键的研究方向。这种整合过程，正如人类大脑中复杂的决策机制一样，展现了人工智能向着更高层次进化的潜力。

#### Advancing Large Language Models: Toward Analytical Thinking and Self-Improvement

Currently, large language models operate primarily on what we might call a System 1 mode of thinking. They function instinctively, processing words and generating the next word in a sequence without the capability for deeper, analytical reasoning. This operation is akin to the cartoon analogy where different words are processed in rapid succession – "chunk, chunk, chunk" – each one taking approximately the same amount of time. This is essentially how these models work in a System 1 setting.

However, the idea of endowing large language models with a System 2 capability is an exciting and inspiring prospect for many in the field. Imagine a scenario where these models could convert time into accuracy. You could pose a question to ChatGPT, for instance, and allow it 30 minutes to think it over, rather than expecting an immediate response. Currently, no language model has this ability, but the concept of models taking their time to process, reflect, and then respond with a well-thought-out answer is a goal many are working towards.

Fig: System 1 vs. System 2 large language models

The objective is to create a kind of 'tree of thoughts,' where the model can ponder over a problem, reconsider, rephrase, and then deliver a response with greater confidence. Ideally, when plotting time (x axis) against the accuracy of a response (y axis), we'd expect to see a monotonically increasing function – a capability not yet realized but one that is generating significant interest.

推动大语言模型前进：走向分析性思维和自我提升

目前，大语言模型（Large Language Models）主要以我们可以称之为「系统 1 思维模式」的方式运作。这种模式类似于人类的直觉思考：模型本能地处理输入的词语，并快速生成下一个词，而不具备进行深度分析推理的能力。

这一过程可以比喻为卡通中的场景：不同的词语快速连续地被处理，就像「嗖嗖嗖」一样，每个词所需的处理时间大致相同。这就是大语言模型在「系统 1 设置」下的基本工作方式。

在心理学中，「系统 1」指的是快速、自动、直觉的思考过程。大语言模型目前的运作方式与此类似，它们能够快速处理和生成文本，但缺乏深入思考和推理的能力。这种工作模式使得模型能够高效地完成许多语言任务，但也限制了它们处理需要复杂逻辑推理的问题的能力。

然而，让大语言模型（Large Language Models）具备深度思考能力的想法，正在激发该领域许多研究者的灵感和热情。这种被称为「系统 2 能力」的特性，可以让 AI 模型像人类一样进行缜密的推理和分析。想象一下，如果这些模型能够通过更长的思考时间来提高回答的准确性，那将会是一个多么令人兴奋的突破。例如，你可以向 ChatGPT（一种由 OpenAI 开发的对话型 AI）提出一个复杂的问题，然后给它 30 分钟的时间来深入思考，而不是要求它立即给出答案。

目前，还没有任何语言模型真正具备这种能力。但是，让 AI 模型能够像人类一样，花时间仔细思考问题，权衡各种因素，然后给出一个经过深思熟虑的回答，这已经成为了许多研究者正在努力追求的目标。这种能力将使 AI 不再局限于快速但可能肤浅的回应，而是能够进行更深入、更有洞察力的分析。

图 1：系统 1 vs. 系统 2 大语言模型

这个目标是要创建一种「思维树」（tree of thoughts）结构，让模型能够深入思考问题，反复推敲，重新组织语言，最终给出一个更有把握的回答。理想情况下，如果我们把时间放在横轴，回答的准确度放在纵轴，我们希望能看到一条持续上升的曲线。虽然这种能力目前还没有实现，但它已经引起了研究界的广泛关注。

#### Self-Improvement in Language Models to Surpass Human Limits

Another exciting direction for these models is the concept of self-improvement, inspired by the success of DeepMind's AlphaGo. AlphaGo's development included two major stages. In the initial stage, the program learned by imitating human expert players, absorbing strategies from games played by top-level human competitors. This approach led to a competent Go-playing program, but it was limited to the capabilities of the best human players it learned from.

Fig: Mastering the game of Go with deep neural networks and reward function

So DeepMind figured out a way to surpass human capabilities in the game of Go through a breakthrough called self-improvement. In this closed sandbox environment, the game itself provided a straightforward reward function – winning. This clear, binary feedback made it possible to play countless games, refining strategies based purely on the likelihood of winning, without the need to imitate human gameplay. This process allowed the system to eventually exceed human performance.

Fig: AlphaGo self-improvement

The graph showcases the Elo rating and how AlphaGo, within just 40 days, managed to surpass some of the best human Go players through self-improvement. This success raises a compelling question: "What is the equivalent of this step two for large language models?"

Currently, in language modeling, we're primarily at step one – imitating human responses. Humans label and write answers, and models learn to mimic these. While this can lead to high-quality responses, it inherently limits the models to human-level accuracy. So the big question is: what is the step two equivalent in the domain of open language modeling?

The major challenge in translating this approach to open language modeling is the lack of a clear reward criterion. Language is vast and varied, encompassing numerous tasks, and lacks a simple, universally applicable metric to judge the quality of a model's output. Unlike Go, where winning provides immediate feedback, language tasks don't have an easily assessable criterion to determine whether a response is 'good' or 'bad.' However, the possibility remains that in more narrowly defined domains, such a reward function could be established, potentially paving the way for self-improvement in language models. Yet, as it stands, this remains an open question in the field, a frontier yet to be fully explored.

语言模型自我提升：突破人类极限

受 DeepMind 公司 AlphaGo 项目成功的启发，语言模型的另一个激动人心的发展方向是自我提升。AlphaGo 的发展经历了两个主要阶段。在初始阶段，程序通过模仿人类专家棋手来学习，从顶级人类选手的对局中吸收策略。这种方法培养出了一个水平不俗的围棋程序，但其能力仅限于它所学习的最优秀人类棋手的水平。

图 1：利用深度神经网络和奖励函数掌握围棋

为了在围棋领域超越人类能力，DeepMind 开创性地提出了自我提升的方法。在这个封闭的沙盒环境（sandbox environment）中，游戏本身提供了一个简单直接的奖励函数 —— 获胜。这种明确的二元反馈机制使得系统能够进行海量对弈，纯粹基于获胜的可能性来优化策略，而无需模仿人类的下棋方式。通过这个过程，系统最终超越了人类的表现。

图 2：AlphaGo 的自我提升过程

上图展示了 Elo 评分（一种用于计算棋类游戏选手相对技能水平的方法）的变化，以及 AlphaGo 如何在短短 40 天内通过自我提升成功超越了一些世界顶级围棋选手。这一成就引发了一个引人深思的问题：对于大语言模型（Large Language Models）来说，这样的第二阶段等价于什么？

目前，在语言模型领域，我们主要停留在第一阶段 —— 模仿人类的回应。人类标注和撰写答案，模型学习模仿这些内容。虽然这种方法可以产生高质量的回应，但它本质上将模型的准确性限制在了人类水平。因此，一个重要的问题是：在开放式语言模型领域，第二阶段的突破点在哪里？

将这种方法应用到开放式语言模型的主要挑战在于缺乏明确的奖励标准。语言是广泛而多样的，涉及众多任务，缺乏一个简单、普遍适用的标准来评判模型输出的质量。与围棋中胜负分明的即时反馈不同，语言任务没有一个容易评估的标准来判定回应的好坏。然而，在一些定义更加明确的特定领域，建立这样一个奖励函数可能是可行的，这可能为语言模型的自我提升铺平道路。不过，就目前而言，这仍然是该领域的一个悬而未决的问题，一个尚待深入探索的前沿领域。

#### Customizing Language Models: Tailoring AI for Niche Tasks

Another significant area of improvement for large language models lies in customization. The diversity of tasks in various sectors of the economy suggests a need for these models to become experts in specific domains. A recent development in this direction is the ChatGPT app store, announced by Sam Altman of OpenAI. This initiative represents an effort to add a layer of customization to large language models.

Through the ChatGPT App Store, users have the opportunity to create their version of GPT. The customization options currently available include setting specific instructions or enhancing the model's knowledge base by uploading files. These files enable a feature known as Retrieval Augmented Generation (RAG), where ChatGPT references text chunks from the uploaded files to enhance its responses. This is akin to ChatGPT browsing through these files, using them as reference material to inform its answers, similar to how it would use internet browsing for information gathering.

Fig: Custom GPT configuration

Currently, customization is limited to these two primary avenues. However, the future may allow for further personalization, such as fine-tuning these models with unique training data or other bespoke modifications. The goal is to develop a range of language models, each specialized in different tasks, moving away from the one-size-fits-all model to a more specialized, task-focused approach.

量身定制语言模型：为特定任务打造专用 AI

大型语言模型的另一个重要改进方向是定制化。考虑到经济各行各业的任务需求多种多样，这些模型需要在特定领域中成为专家。最近，OpenAI 的 Sam Altman 宣布推出 ChatGPT 应用商店（ChatGPT App Store），这是朝着为大语言模型增加定制化功能迈出的一大步。

通过 ChatGPT 应用商店，用户可以创建属于自己的 GPT 版本。目前，定制选项主要包括两种：设置特定指令，或通过上传文件来扩充模型的知识库。这些上传的文件能够支持一种叫做检索增强生成（Retrieval Augmented Generation，RAG）的功能。使用这个功能时，ChatGPT 会参考上传文件中的相关文本片段来增强其回答。你可以将这个过程想象成 ChatGPT 在翻阅这些文件并将其作为参考资料，就像它通过浏览互联网来收集信息一样。

图 1：自定义 GPT 的配置界面

目前，定制化功能仅限于上述两种主要方式。不过，未来可能会开放更多个性化选项，比如使用独特的训练数据对这些模型进行微调，或是进行其他定制化修改。这样做的目标是开发出一系列专门用于不同任务的语言模型，从通用型模型逐步转向更专业化、更针对特定任务的模型。

#### Large Language Models as an Emerging Operating System

In an attempt to synthesize all that we've discussed about large language models, it's useful to think of them not just as chatbots or word generators, but as something much more expansive and foundational. I like to think of them as the kernel process of an emerging type of operating system. This operating system coordinates a variety of resources, from memory to computational tools, all geared towards efficient problem-solving.

Fig: Large language model as kernel process of a new operating system

Let's consider, based on all the aspects we've discussed, how a large language model might look like in the coming years. It is capable of reading and generating text, possessing a breadth of knowledge that surpasses any single human. It can browse the internet or refer to local files through retrieval augmented generation. It can seamlessly interact with existing software infrastructure, like calculators and Python. It can process and produce images and videos, understand and create music, and even engage in extended thinking using a system two approach. In some narrow domains, it might even have the ability to self-improve, provided there's a suitable reward function.

Further, we could see these models becoming highly customized and fine-tuned for specific tasks. Imagine a virtual 'App Store' of LLM experts, each specializing in different areas, ready to collaborate on problem-solving tasks. This conceptualization aligns LLMs with today's operating systems, serving as a multifaceted digital brain.

In this analogy, the memory hierarchy of a computer finds its parallel in LLMs. The internet or local disk storage can be accessed through browsing, similar to how an operating system accesses data from a hard drive. For LLMs, the equivalent of random access memory (RAM) would be their context window, the maximum number of words they can consider to predict the next word in a sequence.

I've only touched on the basics here, but it's crucial to understand that the context window acts much like a finite and valuable working memory of a large language model. You can then think the LLM trying to page relevant information in and out of its context window to perform your task, as the kernel process in an operating system manages its resources.

Further parallels can be drawn between traditional operating system features and the capabilities of LLMs. Concepts such as multi-threading, multi-processing, and speculative execution find their equivalents in the world of LLMs. Similarly, in the language model's context window, we can see parallels to user space and kernel space found in conventional operating systems.

Another compelling reasons I favor this analogy is its relevance to the current landscape of both operating systems and language models. Just as the desktop operating system space comprises proprietary systems like Windows and MacOS, alongside an open-source ecosystem based on Linux, the world of language models mirrors this structure. Proprietary models like the GPT series, Claude series, or Google's Bard series coexist with an expanding open-source ecosystem, currently led by models such as the Llama series.

We can further draw many parallels from the traditional computing stack to this new stack, fundamentally centered around large language models. These models are orchestrating various tools for problem-solving, accessible through a natural language interface. They are not just digital assistants but the core of a potential new operating system, handling tasks and managing resources much like the operating systems we use today.

大语言模型：新兴操作系统的核心

让我们基于之前讨论的所有方面，来展望一下大语言模型（Large Language Model）在未来几年可能的发展方向。这种模型将具备阅读和生成文本的能力，拥有超越任何单个人类的广博知识。它可以通过检索增强生成（Retrieval Augmented Generation）技术浏览互联网或访问本地文件。它能够与现有的软件基础设施无缝对接，比如计算器和 Python 环境。不仅如此，它还能处理和生成图像和视频，理解和创作音乐，甚至能够使用系统二（System 2）方法进行深度思考。在某些特定领域，如果有合适的奖励函数，它甚至可能具备自我改进的能力。

此外，我们可以预见这些模型将变得高度个性化，并为特定任务量身定制。想象一下，未来可能会出现一个虚拟的「大语言模型（LLM）专家商店」，就像我们现在的手机应用商店一样。在这个商店里，每个 LLM 专家都精通不同领域，随时准备协作解决各种问题。这种构想将 LLM 塑造成类似于现代操作系统的角色，成为一个多功能的数字大脑。

如果我们将 LLM 比作计算机，那么它们的结构也有相似之处。就像计算机通过操作系统从硬盘访问数据一样，LLM 可以通过浏览来访问互联网或本地存储的信息。在这个类比中，LLM 的「上下文窗口」就相当于计算机的随机存取存储器（RAM）。上下文窗口指的是 LLM 在预测下一个词时能够考虑的最大词数范围，这决定了模型能够理解和处理的信息量。

在这里，我只是触及了一些基础知识，但理解上下文窗口（context window）的作用至关重要。它实际上就像是大语言模型（Large Language Model，LLM）的一个有限但极其宝贵的工作记忆。你可以把 LLM 执行任务的过程想象成这样：它不断地将相关信息载入上下文窗口或从中移出，这个过程很像操作系统中内核进程管理其资源的方式。

我们还可以在传统操作系统的特性和 LLM 的能力之间找到更多的相似之处。例如，在操作系统中常见的多线程、多进程和推测执行（一种通过预测来提高性能的技术）等概念，在 LLM 的世界里都能找到对应的功能。同样，LLM 的上下文窗口中也存在类似于传统操作系统中用户空间和内核空间的概念划分。

我之所以青睐这个类比，另一个有力的原因是它与当前操作系统和语言模型的现状高度相关。就像桌面操作系统领域包含 Windows 和 MacOS 这样的专有系统，以及基于 Linux 的开源生态系统一样，语言模型的世界也呈现出类似的格局。专有模型（如 GPT 系列、Claude 系列或 Google 的 Bard 系列）与日益壮大的开源生态系统并存，其中后者目前以 Llama 系列等模型为代表。

我们可以从传统的计算机系统架构进一步类比到这个新的人工智能系统架构，其核心是围绕大语言模型（Large Language Model）构建的。这些模型正在协调各种工具来解决问题，而且我们可以通过自然语言界面与之交互。它们不仅仅是智能助理，更可能成为新型操作系统的核心，能够像我们今天使用的操作系统一样处理任务和管理资源。

这种新的系统架构代表了计算范式的重大转变。传统的计算机系统通过图形界面和命令行来接收指令，而这个新系统则通过自然语言来理解和执行用户的需求。大语言模型在这个系统中扮演着核心角色，就像传统操作系统的内核一样，负责协调各种功能和资源，以完成复杂的任务。