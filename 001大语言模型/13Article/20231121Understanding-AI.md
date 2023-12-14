## 20231121Understanding-AI

[Large language models, explained with a minimum of math and jargon](https://www.understandingai.org/p/large-language-models-explained-with)

Large language models, explained with a minimum of math and jargon

Want to really understand how large language models work? Here’s a gentle primer.

2023 年 7 月 27 日

Hi, it’s Tim Lee. I’m a journalist with a master’s degree in computer science. This post is the result of two months of in-depth research. If you find it helpful, please subscribe to get future articles delivered straight to your inbox.

Today’s post is co-authored with Sean Trott, a cognitive scientist at the University of California, San Diego. If you are interested in the intersection of cognitive science and AI, I recommend that you subscribe to his excellent Substack.

### 00

When ChatGPT was introduced last fall, it sent shockwaves through the technology industry and the larger world. Machine learning researchers had been experimenting with large language models (LLMs) for a few years by that point, but the general public had not been paying close attention and didn’t realize how powerful they had become.

Today almost everyone has heard about LLMs, and tens of millions of people have tried them out. But, still, not very many people understand how they work.

If you know anything about this subject, you’ve probably heard that LLMs are trained to “predict the next word,” and that they require huge amounts of text to do this. But that tends to be where the explanation stops. The details of how they predict the next word is often treated as a deep mystery.

One reason for this is the unusual way these systems were developed. Conventional software is created by human programmers who give computers explicit, step-by-step instructions. In contrast, ChatGPT is built on a neural network that was trained using billions of words of ordinary language.

As a result, no one on Earth fully understands the inner workings of LLMs. Researchers are working to gain a better understanding, but this is a slow process that will take years—perhaps decades—to complete.

Still, there’s a lot that experts do understand about how these systems work. The goal of this article is to make a lot of this knowledge accessible to a broad audience. We’ll aim to explain what’s known about the inner workings of these models without resorting to technical jargon or advanced math.

We’ll start by explaining word vectors, the surprising way language models represent and reason about language. Then we’ll dive deep into the transformer, the basic building block for systems like ChatGPT. Finally, we’ll explain how these models are trained and explore why good performance requires such phenomenally large quantities of data.

Direct Translation

当 ChatGPT 去年秋天推出时，它在科技行业和更广泛的世界中引起了震动。到那时为止，机器学习研究人员已经试验了几年大型语言模型（LLMs），但大众并没有密切关注，也没有意识到它们变得多么强大。

如今，几乎每个人都听说过 LLMs，数千万人尝试过它们。但是，仍然没有很多人理解它们是如何工作的。

如果你对这个主题有所了解，你可能听说过 LLMs 被训练来「预测下一个单词」，并且它们需要大量的文本来做到这一点。但这通常是解释的终点。它们如何预测下一个单词的细节通常被视为一个深奥的谜团。

这其中的一个原因是这些系统的开发方式不同寻常。传统软件是由人类程序员创建的，他们给计算机提供明确的、逐步的指令。相比之下，ChatGPT 是基于一个使用数十亿普通语言词汇训练的神经网络构建的。

因此，地球上没有人完全理解 LLMs 的内部工作原理。研究人员正在努力获得更好的理解，但这是一个缓慢的过程，可能需要数年甚至数十年才能完成。

尽管如此，专家们对这些系统的工作原理仍有很多了解。本文的目标是让更多人能够接触到这些知识。我们将致力于解释这些模型内部工作原理的已知内容，而不使用技术术语或高级数学。

我们将从解释词向量开始，这是语言模型表示和推理语言的惊人方式。然后我们将深入探讨变换器，这是像 ChatGPT 这样的系统的基本构建块。最后，我们将解释这些模型是如何训练的，并探索为什么良好的性能需要如此庞大数量的数据。

---

Rephrased Translation

当 ChatGPT 去年秋季面世时，它在科技界乃至更广泛的世界中引起了轰动。直到那时，尽管机器学习研究者们已经对大型语言模型（LLMs）进行了数年的实验，但大众并未过多关注，也没意识到这些模型变得如此强大。

现在，几乎每个人都对 LLMs 有所耳闻，有数千万人尝试使用过它们。但真正理解它们运作方式的人仍然不多。

如果你对这一领域略知一二，你可能听说过 LLMs 通过「预测下一个单词」来训练，并需要大量文本数据。但这通常是人们了解到的全部。关于它们如何预测下一个单词的具体细节常被视为一个深不可测的谜团。

这部分原因是由于这些系统的开发方式与众不同。传统软件由程序员编写，向计算机提供明确的逐步指令。而 ChatGPT 则是基于一个经过数十亿普通语言词汇训练的神经网络构建的。

因此，没有人能完全理解 LLMs 的内部运作机制。研究人员正在努力深入理解这一过程，但这是一个缓慢的过程，可能需要多年甚至数十年的时间。

尽管如此，专家们对这些系统的工作方式有很多了解。本文的目的是让更多人能够理解这些知识。我们将努力解释这些模型内部工作的已知部分，尽量不使用技术术语或复杂的数学概念。

我们将首先介绍词向量，这是语言模型表示和推理语言的一种令人惊讶的方式。接着，我们将深入讨论变换器，这是构建像 ChatGPT 这样的系统的基础模块。最后，我们会解释这些模型是如何训练的，并探讨为什么它们的高效性能需要大量的数据支持。

### 01. Word vectors

To understand how language models work, you first need to understand how they represent words. Human beings represent English words with a sequence of letters, like C-A-T for cat. Language models use a long list of numbers called a word vector. For example, here’s one way to represent cat as a vector:

[0.0074, 0.0030, -0.0105, 0.0742, 0.0765, -0.0011, 0.0265, 0.0106, 0.0191, 0.0038, -0.0468, -0.0212, 0.0091, 0.0030, -0.0563, -0.0396, -0.0998, -0.0796, …, 0.0002] 

(The full vector is 300 numbers long—to see it all click here and then click “show the raw vector.”)

Why use such a baroque notation? Here’s an analogy. Washington DC is located at 38.9 degrees North and 77 degrees West. We can represent this using a vector notation:

Washington DC is at [38.9, 77]

New York is at [40.7, 74]

London is at [51.5, 0.1]

Paris is at [48.9, -2.4]

This is useful for reasoning about spatial relationships. You can tell New York is close to Washington DC because 38.9 is close to 40.7 and 77 is close to 74. By the same token, Paris is close to London. But Paris is far from Washington DC.

Language models take a similar approach: each word vector1 represents a point in an imaginary “word space,” and words with more similar meanings are placed closer together. For example, the words closest to cat in vector space include dog, kitten, and pet. A key advantage of representing words with vectors of real numbers (as opposed to a string of letters, like “C-A-T”) is that numbers enable operations that letters don’t. 

Words are too complex to represent in only two dimensions, so language models use vector spaces with hundreds or even thousands of dimensions. The human mind can’t envision a space with that many dimensions, but computers are perfectly capable of reasoning about them and producing useful results.

Researchers have been experimenting with word vectors for decades, but the concept really took off when Google announced its word2vec project in 2013. Google analyzed millions of documents harvested from Google News to figure out which words tend to appear in similar sentences. Over time, a neural network trained to predict which words co-occur with which other words learned to place similar words (like dog and cat) close together in vector space.

Google’s word vectors had another intriguing property: you could “reason” about words using vector arithmetic. For example, Google researchers took the vector for biggest, subtracted big, and added small. The word closest to the resulting vector was smallest.

You can use vector arithmetic to draw analogies! In this case big is to biggest as small is to smallest. Google’s word vectors captured a lot of other relationships:

Swiss is to Switzerland as Cambodian is to Cambodia. (nationalities)

Paris is to France as Berlin is to Germany. (capitals)

Unethical is to ethical as possibly is to impossibly. (opposites)

Mouse is to mice as dollar is to dollars. (plurals)

Man is to woman as king is to queen. (gender roles)

Because these vectors are built from the way humans use words, they end up reflecting many of the biases that are present in human language. For example, in some word vector models, doctor minus man plus woman yields nurse. Mitigating biases like this is an area of active research.

Nevertheless, word vectors are a useful building block for language models because they encode subtle but important information about the relationships between words. If a language model learns something about a cat (for example: it sometimes goes to the vet), the same thing is likely to be true of a kitten or a dog. If a model learns something about the relationship between Paris and France (for example: they share a language) there’s a good chance that the same will be true for Berlin and Germany and for Rome and Italy.

[[1301.3781] Efficient Estimation of Word Representations in Vector Space](https://arxiv.org/abs/1301.3781)

Direct Translation

要理解语言模型是如何工作的，你首先需要了解它们是如何表示单词的。人类用一系列字母表示英语单词，比如用 C-A-T 表示 cat。而语言模型使用一长串数字，称为词向量。例如，这里有一种表示 cat 为向量的方式：

[0.0074, 0.0030, -0.0105, 0.0742, 0.0765, -0.0011, 0.0265, 0.0106, 0.0191, 0.0038, -0.0468, -0.0212, 0.0091, 0.0030, -0.0563, -0.0396, -0.0998, -0.0796, …, 0.0002]

（完整的向量有 300 个数字长 —— 要查看全部，请点击此处，然后点击「显示原始向量」。）

为什么使用如此复杂的表示法？这里有一个类比。华盛顿特区位于北纬 38.9 度和西经 77 度。我们可以用向量表示法表示这一点：

华盛顿特区位于 [38.9, 77]

纽约位于 [40.7, 74]

伦敦位于 [51.5, 0.1]

巴黎位于 [48.9, -2.4]

这对于推理空间关系很有用。你可以说纽约接近华盛顿特区，因为 38.9 接近 40.7，77 接近 74。同样，巴黎接近伦敦。但巴黎离华盛顿特区很远。

语言模型采用类似的方法：每个词向量表示一个在想象中的「词空间」中的点，意义更相近的词被放置得更近。例如，在向量空间中与 cat 最接近的词包括 dog、kitten 和 pet。用实数向量（而不是像「C-A-T」这样的字母串）表示单词的一个关键优势是数字允许进行字母无法进行的操作。

单词太复杂，无法仅用两个维度来表示，所以语言模型使用具有数百甚至数千维的向量空间。人类的大脑无法想象出这么多维度的空间，但计算机完全有能力对其进行推理并产生有用的结果。

研究人员已经对词向量进行了数十年的实验，但这一概念真正飞跃是在 2013 年谷歌宣布其 word2vec 项目时。谷歌分析了从谷歌新闻中收集的数百万文档，以确定哪些单词倾向于出现在类似的句子中。随着时间的推移，一个训练有素的神经网络能够预测哪些单词与哪些其他单词共同出现，从而学会在向量空间中将相似的单词（如 dog 和 cat）放在一起。

谷歌的词向量还具有另一个有趣的特性：你可以使用向量算术对单词进行「推理」。例如，谷歌研究人员取了 biggest 的向量，减去 big，再加上 small。结果向量最接近的单词是 smallest。

你可以使用向量算术进行类比！在这个例子中，big 之于 biggest，如同 small 之于 smallest。谷歌的词向量捕捉了很多其他关系：

Swiss（瑞士人）之于 Switzerland（瑞士），如同 Cambodian（柬埔寨人）之于 Cambodia（柬埔寨）。（国籍）

Paris（巴黎）之于 France（法国），如同 Berlin（柏林）之于 Germany（德国）。（首都）

Unethical（不道德的）之于 ethical（道德的），如同 possibly（可能）之于 impossibly（不可能）。（对立）

Mouse（鼠标）之于 mice（老鼠），如同 dollar（美元）之于 dollars（美元）。（复数）

Man（男人）之于 woman（女人），如同 king（国王）之于 queen（女王）。（性别角色）

由于这些向量是基于人类对单词的使用构建的，它们最终反映了人类语言中存在的许多偏见。例如，在某些词向量模型中，doctor（医生）减去 man（男人）加上 woman（女人）得到的是 nurse（护士）。减轻这类偏见是一个活跃的研究领域。

尽管如此，词向量对于语言模型来说是一个有用的构建块，因为它们编码了关于单词之间关系的微妙但重要的信息。如果一个语言模型了解了一些关于 cat（猫）的信息（例如：它有时去兽医），那么同样的事情很可能也适用于 kitten（小猫）或 dog（狗）。如果一个模型了解了 Paris（巴黎）和 France（法国）之间的关系（例如：它们共享一种语言），那么对于 Berlin（柏林）和 Germany（德国）以及 Rome（罗马）和 Italy（意大利）之间的关系也很可能是相同的。

---

Rephrased Translation

要弄懂语言模型的工作原理，首先要理解它们如何表示单词。人类通常使用字母序列来表示英文单词，例如用 C-A-T 表示「cat」。而语言模型则使用被称为词向量的一长串数字。比如，下面是将「cat」表示为向量的一种方式：

[0.0074, 0.0030, -0.0105, 0.0742, 0.0765, -0.0011, 0.0265, 0.0106, 0.0191, 0.0038, -0.0468, -0.0212, 0.0091, 0.0030, -0.0563, -0.0396, -0.0998, -0.0796, …, 0.0002]

（完整的向量长度为 300 个数字 —— 要查看完整内容，请点击这里并选择「显示原始向量」。）

为何采用这种复杂的表示法？让我们通过一个比喻来理解。华盛顿特区的位置是北纬 38.9 度，西经 77 度。我们可以使用向量表示法来描述这个位置：

华盛顿特区在 [38.9, 77]

纽约在 [40.7, 74]

伦敦在 [51.5, 0.1]

巴黎在 [48.9, -2.4]

这种表示法有助于推理空间关系。比如，由于 38.9 和 40.7 接近，77 和 74 接近，所以可以判断纽约与华盛顿特区相近。同样，巴黎与伦敦相近，但与华盛顿特区相距甚远。

语言模型采用了类似的方式：每个词向量代表了在想象中的「词空间」里的一个点，而意义相近的词在这个空间中位置更接近。例如，在向量空间里，与「cat」最接近的词包括「dog」（狗）、「kitten」（小猫）和「pet」（宠物）。使用实数向量（而不是像「C-A-T」这样的字母序列）来表示单词的一个主要优势是，数字可以进行一些字母无法进行的操作。

单词的复杂性使得它们无法仅通过两个维度来表示，因此语言模型使用数百甚至数千维的向量空间。人类难以想象这么多维度的空间，但计算机完全能够处理这些空间并得出有用的结果。

研究人员对词向量的研究已经持续了数十年，但这一概念在 2013 年谷歌宣布 word2vec 项目后真正开始流行。谷歌通过分析从谷歌新闻获取的数百万份文档，来识别哪些词语倾向于出现在相似的句子中。随着时间的推移，一个被训练用来预测哪些词语会共同出现的神经网络学会了将含义相似的词语（如「dog」和「cat」）放置在向量空间中的相近位置。

谷歌的词向量还有一个吸引人的特点：你可以使用向量算法对词语进行「推理」。例如，谷歌的研究者们取了「biggest」的向量，减去「big」，再加上「small」，最接近结果向量的词是「smallest」。

向量算法还可以用来进行类比！在这个例子中，big 与 biggest 的关系，就像 small 与 smallest 的关系一样。谷歌的词向量还捕捉到了许多其他关系：

Swiss（瑞士人）之于 Switzerland（瑞士），如同 Cambodian（柬埔寨人）之于 Cambodia（柬埔寨）。（国籍）

Paris（巴黎）之于 France（法国），如同 Berlin（柏林）之于 Germany（德国）。（首都）

Unethical（不道德的）之于 ethical（道德的），如同 possibly（可能）之于 impossibly（不可能）。（对立）

Mouse（鼠标）之于 mice（老鼠），如同 dollar（美元）之于 dollars（美元）。（复数）

Man（男人）之于 woman（女人），如同 king（国王）之于 queen（女王）。（性别角色）

由于这些向量是根据人类使用单词的方式构建的，它们最终反映出人类语言中的许多偏见。例如，在一些词向量模型中，从「doctor」（医生）中减去「man」（男性）再加上「woman」（女性），得到的结果是「nurse」（护士）。缓解这类偏见是一个活跃的研究领域。

尽管如此，词向量作为语言模型的一个重要构建块，因为它们编码了单词间关系的微妙但重要信息。比如，如果一个语言模型学会了一些关于「cat」（猫）的信息（例如：它有时会去看兽医），那么相同的信息很可能也适用于「kitten」（小猫）或「dog」（狗）。如果模型了解了「Paris」（巴黎）与「France」（法国）的关系（例如：它们使用相同的语言），那么对于「Berlin」（柏林）和「Germany」（德国）以及「Rome」（罗马）和「Italy」（意大利）之间的关系，很可能也是类似的。

### 02. Word meaning depends on context

A simple word vector scheme like this doesn’t capture an important fact about natural language: words often have multiple meanings.

For example, the word bank can refer to a financial institution or to the land next to a river. Or consider the following sentences:

John picks up a magazine.

Susan works for a magazine.

The meanings of magazine in these sentences are related but subtly different. John picks up a physical magazine, while Susan works for an organization that publishes physical magazines. 

When a word has two unrelated meanings, as with bank, linguists call them homonyms. When a word has two closely related meanings, as with magazine, linguists call it polysemy. 

LLMs like ChatGPT are able to represent the same word with different vectors depending on the context in which that word appears. There’s a vector for bank (financial institution) and a different vector for bank (of a river). There’s a vector for magazine (physical publication) and another for magazine (organization). As you might expect, LLMs use more similar vectors for polysemous meanings than for homonymous meanings.

So far we haven’t said anything about how language models do this—we’ll get into that shortly. But we’re belaboring these vector representations because it’s fundamental to understanding how language models work.

Traditional software is designed to operate on data that’s unambiguous. If you ask a computer to compute “2 + 3,” there’s no ambiguity about what 2, +, or 3 mean. But natural language is full of ambiguities that go beyond homonyms and polysemy:

In “the customer asked the mechanic to fix his car” does his refer to the customer or the mechanic?

In “the professor urged the student to do her homework” does her refer to the professor or the student?

In “fruit flies like a banana” is flies a verb (referring to fruit soaring across the sky) or a noun (referring to banana-loving insects)?

People resolve ambiguities like this based on context, but there are no simple or deterministic rules for doing this. Rather, it requires understanding facts about the world. You need to know that mechanics typically fix customers’ cars, that students typically do their own homework, and that fruit typically doesn’t fly.

Word vectors provide a flexible way for language models to represent each word’s precise meaning in the context of a particular passage. Now let’s look at how they do that.

[[2010.13057] Contextualized Word Embeddings Encode Aspects of Human-Like Word Sense Knowledge](https://arxiv.org/abs/2010.13057)

Direct Translation

像这样的简单词向量方案并没有捕捉到自然语言的一个重要事实：单词通常有多种含义。

例如，单词 bank 可以指代金融机构或河边的土地。或者考虑以下句子：

John 拿起一本杂志。

Susan 为一本杂志工作。

这些句子中的 magazine 含义相关但微妙不同。John 拿起的是一本实体杂志，而 Susan 为出版实体杂志的组织工作。

当一个单词具有两个不相关的含义时，如 bank，语言学家称它们为同形异义词。当一个单词具有两个密切相关的含义时，如 magazine，语言学家称之为多义性。

像 ChatGPT 这样的 LLMs 能够根据单词出现的上下文，用不同的向量表示同一个单词。有一个向量表示 bank（金融机构），另一个向量表示 bank（河岸）。有一个向量表示 magazine（实体出版物），另一个表示 magazine（组织）。正如你所预期的，LLMs 对于多义性含义使用更相似的向量，而对于同形异义词含义则使用更不同的向量。

到目前为止，我们还没有说语言模型是如何做到这一点的 —— 我们很快就会讲到。但我们详细讨论这些向量表示，是因为它对理解语言模型的工作原理至关重要。

传统软件被设计为处理不含糊的数据。如果你让计算机计算「2 + 3」，2、+ 和 3 的含义是没有任何歧义的。但自然语言充满了超出同形异义词和多义性之外的歧义：

在「顾客要求机械师修理他的车」中，his 是指顾客还是机械师？

在「教授敦促学生做她的家庭作业」中，her 是指教授还是学生？

在「水果苍蝇喜欢香蕉」中，flies 是动词（指的是飞过天空的水果）还是名词（指的是喜欢香蕉的昆虫）？

人们基于上下文来解决这些歧义，但没有简单或确定性的规则来做到这一点。相反，它需要对世界的了解。你需要知道机械师通常修理顾客的车，学生通常做自己的家庭作业，水果通常不会飞。

词向量为语言模型提供了一种灵活的方式，以表示每个单词在特定段落上下文中的确切含义。现在，让我们来看看它们是如何做到这一点的。

---

Rephrased Translation

像这种简单的词向量方案并未能捕捉到自然语言的一个重要特点：单词通常具有多重含义。

例如，「bank」这个词既可以指金融机构，也可以指河岸。再看这些句子：

John 拿起一本杂志。

Susan 在一家杂志社工作。

这些句子中「magazine」的含义虽有关联但略有不同。「John」拿起的是一本实体的杂志，而「Susan」则是在一家出版实体杂志的机构工作。

当一个词有两个不相关的含义时，如「bank」，语言学家将其称为同形异义词。当一个词有两个密

切相关的含义时，如「magazine」，语言学家称之为多义词。

像 ChatGPT 这样的大型语言模型能够根据单词出现的上下文，用不同的向量来表示同一个词。例如，「bank」（金融机构）和「bank」（河岸）就有不同的向量表示；「magazine」（实体出版物）和「magazine」（出版机构）也有不同的向量表示。正如预期，对于多义词，LLMs 使用的向量比对于同形异义词更为相似。

到目前为止，我们还没具体说明语言模型是如何实现这一点的 —— 我们很快会详细介绍。但我们深入讨论这些向量表示法，是因为它对理解语言模型如何工作至关重要。

传统软件被设计来处理明确无歧义的数据。比如，当你让计算机计算「2 + 3」时，2、+ 和 3 的含义是明确无误的。但自然语言充满了各种歧义，不仅仅是同形异义词和多义词这么简单：

在「顾客要求机械师修理他的车」中，「他」是指顾客还是机械师？

在「教授敦促学生做她的作业」中，「她」是指教授还是学生？

在「水果蝇喜欢香蕉」中，「flies」是动词（指的是飞翔的水果）还是名词（指的是喜欢香蕉的昆虫）？

人们根据上下文来解决这些歧义，但并没有简单或确定的规则可以依循。相反，这需要对世界有所了解。你需要知道，机械师通常修理顾客的车，学生通常做自己的作业，而水果通常不会飞翔。

词向量为语言模型提供了一种灵活的方式，来精确表达每个单词在特定语境中的具体含义。现在，我们来看看它们是如何做到这一点的。

### 03. Transforming word vectors into word predictions

GPT-3, the model behind the original version of ChatGPT2, is organized into dozens of layers. Each layer takes a sequence of vectors as inputs—one vector for each word in the input text—and adds information to help clarify the meaning of that word and better predict which word might come next.

Let’s start by looking at a stylized example:

Each layer of an LLM is a transformer, a neural network architecture that was first introduced by Google in a landmark 2017 paper.

The model’s input, shown at the bottom of the diagram, is the partial sentence “John wants his bank to cash the.” These words, represented as word2vec-style vectors, are fed into the first transformer. 

The transformer figures out that wants and cash are both verbs (both words can also be nouns). We’ve represented this added context as red text in parentheses, but in reality the model would store it by modifying the word vectors in ways that are difficult for humans to interpret. These new vectors, known as a hidden state, are passed to the next transformer in the stack.

The second transformer adds two other bits of context: it clarifies that bank refers to a financial institution rather than a river bank, and that his is a pronoun that refers to John. The second transformer produces another set of hidden state vectors that reflect everything the model has learned up to that point.

The above diagram depicts a purely hypothetical LLM, so don’t take the details too seriously. We’ll take a look at research into real language models shortly. Real LLMs tend to have a lot more than two layers. The most powerful version of GPT-3, for example, has 96 layers.

Research suggests that the first few layers focus on understanding the syntax of the sentence and resolving ambiguities like we’ve shown above. Later layers (which we’re not showing to keep the diagram a manageable size) work to develop a high-level understanding of the passage as a whole.

For example, as an LLM “reads through” a short story, it appears to keep track of a variety of information about the story’s characters: sex and age, relationships with other characters, past and current location, personalities and goals, and so forth.

Researchers don’t understand exactly how LLMs keep track of this information, but logically speaking the model must be doing it by modifying the hidden state vectors as they get passed from one layer to the next. It helps that in modern LLMs, these vectors are extremely large.

For example, the most powerful version of GPT-3 uses word vectors with 12,288 dimensions—that is, each word is represented by a list of 12,288 numbers. That’s 20 times larger than Google’s 2013 word2vec scheme. You can think of all those extra dimensions as a kind of “scratch space” that GPT-3 can use to write notes to itself about the context of each word. Notes made by earlier layers can be read and modified by later layers, allowing the model to gradually sharpen its understanding of the passage as a whole.

So suppose we changed our diagram above to depict a 96-layer language model interpreting a 1,000-word story. The 60th layer might include a vector for John with a parenthetical comment like “(main character, male, married to Cheryl, cousin of Donald, from Minnesota, currently in Boise, trying to find his missing wallet).” Again, all of these facts (and probably a lot more) would somehow be encoded as a list of 12,288 numbers corresponding to the word John. Or perhaps some of this information might be encoded in the 12,288-dimensional vectors for Cheryl, Donald, Boise, wallet, or other words in the story.

The goal is for the 96th and final layer of the network to output a hidden state for the final word that includes all of the information necessary to predict the next word.

[[1706.03762] Attention Is All You Need](https://arxiv.org/abs/1706.03762)

[[1905.05950] BERT Rediscovers the Classical NLP Pipeline](https://arxiv.org/abs/1905.05950)

1『上面的 Google 的 2017 年论文「Attention Is All You Need」，很多地方听过，重点研读。（2023-11-21）』

Direct Translation

GPT-3，ChatGPT2 原始版本背后的模型，由数十层组成。每一层都接收一系列向量作为输入 —— 输入文本中每个单词一个向量 —— 并添加信息以帮助澄清该词的含义，并更好地预测下一个可能出现的单词。

让我们从一个风格化的例子开始：

LLM 的每一层都是一个变换器，这是一种神经网络架构，最初由谷歌在 2017 年的一篇里程碑式论文中引入。

模型的输入，如图底部所示，是部分句子「John wants his bank to cash the。」这些单词以 word2vec 风格的向量表示，被送入第一个变换器。

变换器确定 wants 和 cash 都是动词（这两个词也可以是名词）。我们用括号中的红色文本表示这些添加的上下文，但实际上模型会通过修改词向量的方式来存储它，这些修改方式对人类来说难以解释。这些新向量，被称为隐藏状态，传递给堆栈中的下一个变换器。

第二个变换器添加了另外两个上下文信息：它澄清了 bank 指的是金融机构而不是河岸，以及 his 是指代 John 的代词。第二个变换器产生了另一组反映模型到目前为止所学内容的隐藏状态向量。

上面的图表描述了一个纯粹假设的 LLM，所以不要太认真对待细节。我们将很快看看关于真实语言模型的研究。真正的 LLMs 往往有两层以上。例如，GPT-3 最强大的版本有 96 层。

研究表明，前几层专注于理解句子的语法和解决我们上面展示的歧义。后面的层次（我们没有展示以保持图表的可管理大小）则致力于对整个段落进行高层次的理解。

例如，当 LLM「阅读」一篇短篇小说时，它似乎会跟踪关于故事角色的各种信息：性别和年龄、与其他角色的关系、过去和当前位置、个性和目标等等。

研究人员并不完全明白 LLMs 是如何跟踪这些信息的，但从逻辑上讲，模型必须是通过在从一层传递到下一层的过程中修改隐藏状态向量来实现的。在现代 LLMs 中，这些向量极其庞大，这一点是有帮助的。

例如，GPT-3 最强大的版本使用具有 12,288 维的词向量 —— 也就是说，每个单词由一个包含 12,288 个数字的列表表示。这比谷歌 2013 年的 word2vec 方案大 20 倍。你可以将所有这些额外的维度视为一种「划痕空间」，GPT-3 可以用它来记录关于每个词的上下文的笔记。前面层次做的笔记可以被后面的层次读取和修改，使得模型能逐渐加深对整个段落的理解。

所以假设我们改变上面的图表，描绘一个解释 1000 字故事的 96 层语言模型。第 60 层可能包括一个关于 John 的向量，附有类似（主角，男性，与 Cheryl 结婚，Donald 的表亲，来自明尼苏达，目前在博伊西，正在寻找他的遗失钱包）的括号内注释。再次强调，所有这些事实（可能还有更多）将以与单词 John 相对应的 12,288 个数字的列表的形式进行编码。或许，其中一些信息可能会编码在故事中的 Cheryl、Donald、Boise、wallet 或其他单词的 12,288 维向量中。

目标是网络的第 96 层和最后一层输出最后一个单词的隐藏状态，其中包含预测下一个单词所需的所有信息。

---

Rephrased Translation

GPT-3，即 ChatGPT2 原版背后的模型，由数十个层级构成。每个层级接收一系列向量作为输入 —— 每个单词在输入文本中各有一个向量 —— 并添加信息以帮助明确该词的含义，以及更准确地预测接下来可能出现的单词。

让我们先看一个简化的例子：

LLM 的每一层都是一个变换器，这是一种神经网络结构，最初由谷歌在 2017 年的一篇具有里程碑意义的论文中提出。

模型的输入显示在图表的底部，是一个部分句子：「John wants his bank to cash the。」这些单词以 word2vec 风格的向量表示，然后输入到第一个变换器中。

变换器识别出 wants 和 cash 都是动词（这两个词也可以是名词）。我们用括号内的红色文本表示这些新增的上下文，但实际上模型通过以难以被人类解释的方式修改词向量来存储这些信息。这些新向量，即隐藏状态，被传递到堆栈中的下一个变换器。

第二个变换器添加了两

个其他的上下文信息：明确 bank 是指金融机构而非河岸，以及 his 是指代 John 的代词。第二个变换器产生了另一组反映模型到目前为止学习的所有内容的隐藏状态向量。

上述图表描述了一个纯假设的 LLM，因此其细节不必过于认真对待。我们很快就会看看关于真实语言模型的研究。实际的 LLMs 通常有超过两层。比如，GPT-3 最强大的版本有 96 层。

研究显示，前几层主要专注于理解句子的语法和解决我们上面所示的歧义问题。后续层级（为了保持图表的简洁，我们未展示）则致力于对整个段落进行更高层次的理解。

例如，当 LLM「阅读」一篇短篇小说时，它似乎能够跟踪关于故事中角色的各种信息：性别和年龄、与其他角色的关系、过去和现在的位置、性格和目标等等。

研究人员并不完全清楚 LLMs 是如何跟踪这些信息的，但逻辑上来说，模型肯定是在从一个层级传递到下一个层级的过程中修改隐藏状态向量来实现的。在现代 LLMs 中，这些向量非常庞大，这是一个优势。

例如，GPT-3 最强大的版本使用 12,288 维的词向量 —— 也就是说，每个单词由一个含有 12,288 个数字的列表来表示。这比谷歌 2013 年的 word2vec 方案要大 20 倍。你可以把这些额外的维度看作是一种「草稿空间」，GPT-3 可以在其中记录关于每个单词上下文的注释。较早层的注释可以被后续层读取并修改，从而使模型逐渐深化对整个段落的理解。

因此，如果我们将上述图表改为描绘一个解释 1000 字故事的 96 层语言模型，第 60 层可能包含有关 John 的向量，其附注可能是（主角，男性，与 Cheryl 结婚，是 Donald 的表亲，来自明尼苏达，目前在博伊西，正在寻找他丢失的钱包）。再次说明，所有这些事实（可能还有更多）将以一系列与「John」这个词相对应的 12,288 个数字编码。或者，这些信息中的一部分可能被编码在故事中的 Cheryl、Donald、Boise、wallet 或其他单词的 12,288 维向量中。

目标是让网络的第 96 层和最后一层输出包含预测下一个单词所需全部信息的最后一个单词的隐藏状态。

### 04. Can I have your attention please

Now let’s talk about what happens inside each transformer. The transformer has a two-step process for updating the hidden state for each word of the input passage:

1 In the attention step, words “look around” for other words that have relevant context and share information with one another.

2 In the feed-forward step, each word “thinks about” information gathered in previous attention steps and tries to predict the next word.

Of course it’s the network, not the individual words, that performs these steps. But we’re phrasing things this way to emphasize that transformers treat words, rather than entire sentences or passages, as the basic unit of analysis. This approach enables LLMs to take full advantage of the massive parallel processing power of modern GPU chips. And it also helps LLMs to scale to passages with thousands of words. These are both areas where earlier language models struggled.

You can think of the attention mechanism as a matchmaking service for words. Each word makes a checklist (called a query vector) describing the characteristics of words it is looking for. Each word also makes a checklist (called a key vector) describing its own characteristics. The network compares each key vector to each query vector (by computing a dot product) to find the words that are the best match. Once it finds a match, it transfers information from the word that produced the key vector to the word that produced the query vector.

For example, in the previous section we showed a hypothetical transformer figuring out that in the partial sentence “John wants his bank to cash the,” his refers to John. Here’s what that might look like under the hood. The query vector for his might effectively say “I’m seeking: a noun describing a male person.” The key vector for John might effectively say “I am: a noun describing a male person.” The network would detect that these two vectors match and move information about the vector for John into the vector for his.

Each attention layer has several “attention heads,” which means that this information-swapping process happens several times (in parallel) at each layer. Each attention head focuses on a different task:

One attention head might match pronouns with nouns, as we discussed above.

Another attention head might work on resolving the meaning of homonyms like bank.

A third attention head might link together two-word phrases like “Joe Biden.”

And so forth.

Attention heads frequently operate in sequence, with the results of an attention operation in one layer becoming an input for an attention head in a subsequent layer. Indeed, each of the tasks we just listed above could easily require several attention heads rather than just one.

The largest version of GPT-3 has 96 layers with 96 attention heads each, so GPT-3 performs 9,216 attention operations each time it predicts a new word.

Direct Translation

现在请注意

现在让我们来谈谈每个变换器内部发生的事情。变换器有一个更新输入段落中每个单词隐藏状态的两步过程：

在注意力步骤中，单词「四处寻找」具有相关上下文的其他单词并相互分享信息。

在前馈步骤中，每个单词「思考」在先前注意力步骤中收集的信息，并尝试预测下一个单词。

请注意，Transformer 将单词，而不是整个句子或段落，作为分析的基本单位。这种方法使得大语言模型能够充分利用现代 GPU 芯片的大规模并行处理能力。并且，它还帮助大语言模型扩展到包含数千个单词的段落。这都是早期语言模型难以应对的领域。

你可以将注意力机制想象为单词的配对服务。每个单词都会制作一个清单（称为查询向量），描述它正在寻找的单词的特征。每个单词也会制作一个清单（称为键向量），描述自己的特征。网络通过计算点积将每个键向量与每个查询向量进行比较，以找到最佳匹配的单词。一旦找到匹配，它就会从生成键向量的单词传递信息到生成查询向量的单词。

例如，在上一节中，我们展示了一个假设的 Transformer 在解析部分句子 "John wants his bank to cash the," 中的 "his" 指的是 "John"。在底层，这可能是什么样子的呢？"his" 的查询向量可能有效地表示 "我正在寻找：描述男性的名词"。"John" 的键向量可能有效地表示 "我是：描述男性的名词"。网络会检测到这两个向量匹配，并将 "John" 的向量信息移动到 "his" 的向量。

每个注意力层都有几个 "注意力头"，这意味着在每个层级，这种信息交换过程都会发生几次（并行）。每个注意力头都专注于一个不同的任务：

一个注意力头可能会像我们上面讨论的那样，将代词与名词匹配。

另一个注意力头可能会努力解析像 "bank" 这样的同音词的含义。

第三个注意力头可能会将 "Joe Biden" 这样的两词短语联系起来。

等等。

注意力头经常按序操作，一个层级中的注意力操作的结果成为下一个层级中的注意力头的输入。实际上，我们刚刚列出的每个任务都可能需要多个注意力头，而不仅仅是一个。

GPT-3 的最大版本有 96 层，每层有 96 个注意力头，所以 GPT-3 在预测新单词时，每次都会执行 9,216 次注意力操作。

---

Rephrased Translation

请集中注意力

现在，让我们来谈谈每个变换器内部发生的事情。变换器通过一个两步过程来更新输入段落中每个单词的隐藏状态：

在注意力步骤中，单词「四处寻找」其他具有相关上下文的单词，并与之分享信息。

在前馈步骤中，每个单词「思考」在之前的注意力步骤中收集到的信息，并尝试预测下一个单词。

需要强调的是，Transformer 把单词，而非整个句子或者文章段落，作为分析的基础单位。这种处理方式使得大语言模型能够充分发挥现代 GPU 芯片的大规模并行处理能力，也使得大语言模型能够处理包含数千个单词的长文本，这些都是早期的语言模型所无法胜任的。

你可以把注意力机制理解为单词之间的「红娘」。每个单词都会制作一份清单（我们称之为查询向量），描述它在寻找什么样的单词。每个单词也会制作一份清单（我们称之为键向量），描述它自己的特性。然后，网络会通过计算点积把每个键向量和每个查询向量进行比较，找出最匹配的单词。一旦找到匹配的单词，就会把键向量所代表的单词的信息传递给查询向量所代表的单词。

比如，在前一节中，我们举了一个例子：在句子 "John wants his bank to cash the," 中，Transformer 能够判断出 "his" 指的是 "John"。那么在这个过程中，"his" 的查询向量可能就是在寻找 "描述男性的名词"，而 "John" 的键向量可能就是 "描述男性的名词"。网络会发现这两个向量匹配，然后把 "John" 的信息传递给 "his"。

每个注意力层都包含多个「注意力头」，这意味着在每一层，这种信息交换的过程都会并行进行多次。每个注意力头都在专注于不同的任务：

一个注意力头可能在匹配代词和名词，就像我们上面讨论的那样。

另一个注意力头可能在解析像 "bank" 这样的同音词的含义。

第三个注意力头可能在将像 "Joe Biden" 这样的两词短语联系起来。

等等。

注意力头经常会按照一定的顺序工作，一个层级中的注意力操作的结果会成为下一个层级中的注意力头的输入。实际上，我们刚刚列出的每个任务都可能需要多个注意力头来完成，而不仅仅是一个。

GPT-3 的最大版本拥有 96 层，每层有 96 个注意力头，所以 GPT-3 在预测新单词时，每次都会执行 9,216 次注意力操作。

### 05. A real-world example

In the last two sections we presented a stylized version of how attention heads work. Now let’s look at research on the inner workings of a real language model. Last year scientists at Redwood Research studied how GPT-2, a predecessor to ChatGPT, predicted the next word for the passage “When Mary and John went to the store, John gave a drink to.”

GPT-2 predicted that the next word was Mary. The researchers found that three types of attention heads contributed to this prediction:

Three heads they called Name Mover Heads copied information from the Mary vector to the final input vector (for the word to). GPT-2 uses the information in this rightmost vector to predict the next word.

How did the network decide Mary was the right word to copy? Working backwards through GPT-2’s computational process, the scientists found a group of four attention heads they called Subject Inhibition Heads that marked the second John vector in a way that blocked the Name Mover Heads from copying the name John.

How did the Subject Inhibition Heads know John shouldn’t be copied? Working further backwards, the team found two attention heads they called Duplicate Token Heads. They marked the second John vector as a duplicate of the first John vector, which helped the Subject Inhibition Heads to decide that John shouldn’t be copied.

In short, these nine attention heads enabled GPT-2 to figure out that “John gave a drink to John” doesn’t make sense and choose “John gave a drink to Mary” instead.

We love this example because it illustrates just how difficult it will be to fully understand LLMs. The five-member Redwood team published a 25-page paper explaining how they identified and validated these attention heads. Yet even after they did all that work, we are still far from having a comprehensive explanation for why GPT-2 decided to predict Mary as the next word.

For example, how did the model know the next word should be someone’s name and not some other kind of word? It’s easy to think of similar sentences where Mary wouldn’t be a good next-word prediction. For example, in the sentence “when Mary and John went to the restaurant, John gave his keys to,” the logical next words would be “the valet.”

Presumably, with enough research computer scientists could uncover and explain additional steps in GPT-2’s reasoning process. Eventually, they might be able to develop a comprehensive understanding of how GPT-2 decided that Mary is the most likely next word for this sentence. But it could take months or even years of additional effort just to understand the prediction of a single word.

The language models underlying ChatGPT—GPT-3.5 and GPT-4—are significantly larger and more complex than GPT-2. They are capable of more complex reasoning than the simple sentence-completion task the Redwood team studied. So fully explaining how these systems work is going to be a huge project that humanity is unlikely to complete any time soon.

[[2211.00593] Interpretability in the Wild: a Circuit for Indirect Object Identification in GPT-2 small](https://arxiv.org/abs/2211.00593)

Direct Translation

在过去的两个部分中，我们呈现了一个关于注意力头工作方式的风格化版本。现在，让我们来看看关于真实语言模型内部运作的研究。去年，Redwood Research 的科学家们研究了 GPT-2 是如何预测「当玛丽和约翰去商店时，约翰给了一个饮料给」这句话的下一个词的。GPT-2 预测下一个词是玛丽。研究人员发现有三种类型的注意力头对这个预测做出了贡献：

他们称之为「姓名移动头」的三个注意力头将信息从玛丽向量复制到最终输入向量（对于单词 to）。GPT-2 使用这个最右边的向量中的信息来预测下一个词。

网络是如何决定复制玛丽这个词的呢？通过逆向追踪 GPT-2 的计算过程，科学家们找到了一组他们称之为「主语抑制头」的四个注意力头，这些头以某种方式标记了第二个约翰向量，阻止了姓名移动头复制约翰这个名字。

主语抑制头是怎么知道不应该复制约翰的呢？进一步向后追踪，团队发现了他们称之为「重复 Token 头」的两个注意力头。它们将第二个约翰向量标记为第一个约翰向量的副本，这帮助主语抑制头决定不应该复制约翰。

简而言之，这九个注意力头使得 GPT-2 能够弄清楚「约翰给约翰一个饮料」是没有意义的，并选择「约翰给玛丽一个饮料」作为替代。

我们喜欢这个例子，因为它说明了要完全理解大型语言模型（LLMs）的难度。Redwood 团队的五名成员发表了一篇 25 页的论文，解释了他们如何识别并验证这些注意力头。然而，即使他们做了所有这些工作，我们仍然远未能全面解释为什么 GPT-2 决定预测下一个词是玛丽。

例如，模型是如何知道下一个词应该是某人的名字而不是其他类型的词？很容易想到类似的句子，其中玛丽不是一个好的下一个词预测。例如，在句子「当玛丽和约翰去餐厅时，约翰把他的钥匙给了」，逻辑上的下一个词应该是「代客泊车员」。

可以假设，如果计算机科学家进行足够的研究，他们可以揭示并解释 GPT-2 推理过程中的额外步骤。最终，他们可能能够全面理解 GPT-2 是如何决定玛丽是这个句子最可能的下一个词。但这可能需要数月甚至数年的额外努力，仅仅是为了理解单个词的预测。

ChatGPT 所依赖的语言模型 ——GPT-3.5 和 GPT-4 —— 比 GPT-2 大得多，也复杂得多。它们能够进行比 Redwood 团队研究的简单句子完成任务更复杂的推理。因此，完全解释这些系统是如何工作的将是一个巨大的项目，人类不太可能很快完成。

---

Rephrased Translation

在前面两部分，我们用一个简化的模型展示了注意力机制是如何运作的。现在，我们来看看有关真实大语言模型内部机制的研究。红木研究所的科学家们去年对 GPT-2 进行了研究，GPT-2 是 ChatGPT 的前身，他们研究了它是如何预测「当玛丽和约翰去商店，约翰给了一个饮料给......」这句话接下来的词。GPT-2 预测接下来的词是玛丽。研究人员发现，有三种类型的注意力机制对这个预测有重要贡献：

他们称为「姓名移动头」的三个注意力单元把「玛丽」的信息复制到了决定下一个词的关键向量中（即单词 to 的位置）。GPT-2 用这个最后的向量信息来预测接下来的词。

那么，网络是怎么判断应该复制「玛丽」这个词的呢？科学家们追溯 GPT-2 的计算流程，发现了他们所说的「主语抑制头」，这四个注意力单元以特定的方式标记了第二个「约翰」，阻止了「姓名移动头」复制这个名字。

那么「主语抑制头」怎么知道不该复制「约翰」呢？科学家们进一步追溯，找到了两个被称为「重复 Token 头」的注意力单元。它们把第二个「约翰」标记为重复项，这就帮助「主语抑制头」确定不应该再次复制「约翰」。

总的来说，这九个注意力单元使得 GPT-2 能够理解「约翰给约翰一个饮料」这句话不通顺，从而选择了更合理的「约翰给玛丽一个饮料」作为替代。

这个例子引人注目，因为它展示了要彻底理解大型语言模型（LLMs）的复杂性。Redwood 的五位团队成员发表了一份 25 页的研究报告，阐述了他们如何确定并验证了这些特殊的注意力单元。但即便他们付出了巨大努力，我们对于 GPT-2 如何决定预测「玛丽」作为下一个词的全面解释还有很长的路要走。

比如，模型怎么知道下一个词应该是一个人名而不是其他类型的词呢？我们可以想象，在某些类似的句子中，「玛丽」并不是一个合适的下一个词预测。例如，在「当玛丽和约翰去餐馆，约翰把他的钥匙给了……」这句话中，合乎逻辑的下一个词应该是「代客泊车员」。

可以推测，随着研究的深入，计算机科学家能够揭示并解释 GPT-2 推理过程中更多的步骤。他们可能最终能够全面理解 GPT-2 如何决定「玛丽」是这个句子中最有可能的下一个词。但这可能需要数月甚至数年的努力，仅仅为了理解单词预测。

ChatGPT 所基于的语言模型 ——GPT-3.5 和 GPT-4—— 比 GPT-2 要大得多，也更为复杂。它们能够执行比 Redwood 团队研究的简单句子补全任务更为复杂的推理。所以，要完全解释这些系统如何运作将是一个巨大的工程，而且人类不太可能在短时间内完成这项工程。

### 06. The feed-forward step

After the attention heads transfer information between word vectors, there’s a feed-forward network3 that “thinks about” each word vector and tries to predict the next word. No information is exchanged between words at this stage: the feed-forward layer analyzes each word in isolation. However, the feed-forward layer does have access to any information that was previously copied by an attention head. Here’s the structure of the feed-forward layer in the largest version of GPT-3:

The green and purple circles are neurons: mathematical functions that compute a weighted sum of their inputs.4

What makes the feed-forward layer powerful is its huge number of connections. We’ve drawn this network with three neurons in the output layer and six neurons in the hidden layer, but the feed-forward layers of GPT-3 are much larger: 12,288 neurons in the output layer (corresponding to the model’s 12,288-dimensional word vectors) and 49,152 neurons in the hidden layer.

So in the largest version of GPT-3, there are 49,152 neurons in the hidden layer with 12,288 inputs (and hence 12,288 weight parameters) for each neuron. And there are 12,288 output neurons with 49,152 input values (and hence 49,152 weight parameters) for each neuron. This means that each feed-forward layer has 49,152 * 12,288 + 12,288 * 49,152 = 1.2 billion weight parameters. And there are 96 feed-forward layers, for a total of 1.2 billion * 96 = 116 billion parameters! This accounts for almost two-thirds of GPT-3’s overall total of 175 billion parameters.

In a 2020 paper, researchers from Tel Aviv University found that feed-forward layers work by pattern matching: each neuron in the hidden layer matches a specific pattern in the input text. Here are some of the patterns that were matched by neurons in a 16-layer version of GPT-2:

A neuron in layer 1 matched sequences of words ending with “substitutes.”

A neuron in layer 6 matched sequences related to the military and ending with “base” or “bases.”

A neuron in layer 13 matched sequences ending with a time range such as “between 3 pm and 7” or “from 7:00 pm Friday until.”

A neuron in layer 16 matched sequences related to television shows such as “the original NBC daytime version, archived” or “time shifting viewing added 57 percent to the episode’s.”

As you can see, patterns got more abstract in the later layers. The early layers tended to match specific words, whereas later layers matched phrases that fell into broader semantic categories such as television shows or time intervals.

This is interesting because, as mentioned previously, the feed-forward layer examines only one word at a time. So when it classifies the sequence “the original NBC daytime version, archived” as related to television, it only has access to the vector for archived, not words like NBC or daytime. Presumably, the feed-forward layer can tell that archived is part of a television-related sequence because attention heads previously moved contextual information into the archived vector.

When a neuron matches one of these patterns, it adds information to the word vector. While this information isn’t always easy to interpret, in many cases you can think of it as a tentative prediction about the next word.

[[2012.14913] Transformer Feed-Forward Layers Are Key-Value Memories](https://arxiv.org/abs/2012.14913)

Direct Translation

前馈步骤

在注意力头将信息在词向量之间传递之后，有一个前馈网络 3 将「思考」每个词向量并尝试预测下一个词。在这个阶段，词与词之间不交换信息：前馈层独立分析每个词。然而，前馈层确实可以访问之前由注意力头复制的任何信息。以下是 GPT-3 最大版本中前馈层的结构：

绿色和紫色的圆圈是神经元：计算其输入的加权和的数学函数。4

前馈层之所以强大，是因为它巨大的连接数。我们画的这个网络在输出层有三个神经元，在隐藏层有六个神经元，但 GPT-3 的前馈层要大得多：输出层有 12,288 个神经元（对应于模型的 12,288 维词向量）和隐藏层有 49,152 个神经元。

因此，在 GPT-3 最大的版本中，隐藏层有 49,152 个神经元，每个神经元有 12,288 个输入（因此有 12,288 个权重参数）。还有 12,288 个输出神经元，每个神经元有 49,152 个输入值（因此有 49,152 个权重参数）。这意味着每个前馈层有 49,152 * 12,288 + 12,288 * 49,152 = 12 亿个权重参数。而且有 96 个前馈层，总共有 12 亿 * 96 = 1160 亿个参数！这几乎占了 GPT-3 总共 1750 亿参数的三分之二。

在 2020 年的一篇论文中，特拉维夫大学的研究人员发现前馈层通过模式匹配来工作：隐藏层中的每个神经元匹配输入文本中的特定模式。以下是一些在 GPT-2 的 16 层版本中，神经元匹配到的模式：

第 1 层的一个神经元匹配以「substitutes」结尾的词序列。

第 6 层的一个神经元匹配与军事相关且以「base」或「bases」结尾的词序列。

第 13 层的一个神经元匹配以时间范围结尾的词序列，例如「between 3 pm and 7」或「from 7:00 pm Friday until」。

第 16 层的一个神经元匹配与电视节目相关的词序列，例如「the original NBC daytime version, archived」或「time shifting viewing added 57 percent to the episode's」。

如你所见，模式在后续层中变得更加抽象。早期层次倾向于匹配特定的单词，而后期层次匹配的短语则属于更广泛的语义类别，如电视节目或时间间隔。

这一点很有趣，因为正如之前提到的，前馈层一次只检查一个词。所以当它将序列「the original NBC daytime version, archived」分类为与电视相关时，它只能访问到「archived」的向量，而不是像「NBC」或「daytime」这样的词。可以推测，前馈层能够知道「archived」是电视相关序列的一部分，是因为之前注意力头已经将上下文信息移入「archived」的向量中。

当一个神经元匹配到这些模式之一时，它会向词向量添加信息。虽然这些信息并不总是容易解释，但在许多情况下，你可以将其视为对下一个词的初步预测。

---

Rephrased Translation

前馈步骤

在注意力单元将信息在词向量之间传递之后，接下来是一个前馈网络 3，它会「思考」每个词向量并尝试预测下一个词。在这一阶段，词与词之间不会交换信息：前馈层单独分析每一个词。但是，前馈层可以访问之前由注意力单元复制的任何信息。以下是 GPT-3 最大版本中前馈层的结构：

绿色和紫色的圆形代表神经元：这些是计算输入加权和的数学函数。4

前馈层之所以强大，在于其庞大的连接数。我们画的网络示意图中输出层有三个神经元，隐藏层有六个神经元，但 GPT-3 的前馈层实际上要大得多：输出层有 12,288 个神经元（对应模型的 12,288 维词向量），隐藏层有 49,152 个神经元。

因此，在 GPT-3 最大版本中，隐藏层有 49,152 个神经元，每个神经元有 12,288 个输入（因此有 12,288 个权重参数）。输出层有 12,288 个神经元，每个神经元有 49,152 个输入值（因此有 49,152 个权重参数）。这意味着每一个前馈层有 49,152 * 12,288 + 12,288 * 49,152 = 12 亿个权重参数。而且有 96 个这样的前馈层，总共有 12 亿 * 96 = 1160 亿个参数！这差不多占了 GPT-3 总共 1750 亿参数的三分之二。

在特拉维夫大学 2020 年的一项研究中，科学家们发现，神经网络中的前馈层实际上是通过识别模式来工作的：每一个隐藏层的神经元都能识别输入文本中的特定模式。在 GPT-2 的一个 16 层模型中，研究人员发现了如下几种模式：

第 1 层的神经元能够识别出以「substitutes」结尾的词语序列。

第 6 层的神经元能够找出与军事有关，以「base」或「bases」结尾的词语序列。

第 13 层的神经元能够识别出以时间范围结尾的词语序列，比如「between 3 pm and 7」或者「from 7:00 pm Friday until」。

第 16 层的神经元能够匹配与电视节目有关的词语序列，如「the original NBC daytime version, archived」或者「time shifting viewing added 57 percent to the episode's」。

可以观察到，神经元匹配的模式在网络的后面几层变得更加抽象。前面几层更多地匹配具体的单词，而后面几层则能够识别出涵盖更广义语义类别的短语，例如电视节目名称或者时间段。

这个发现非常有趣，因为根据之前的介绍，前馈层在任何时候只处理一个单词。所以，当它判定「the original NBC daytime version, archived」这个序列与电视节目有关时，它仅仅是基于「archived」这个单词的信息，而无法看到「NBC」或者「daytime」这样的词。我们推测，前馈层之所以能判定「archived」与电视相关，是因为之前的注意力机制已经将相关的上下文信息融合到了「archived」的向量中。

当神经元识别出这些模式之一时，它会在词向量中加入新的信息。尽管这些信息不总是那么直观易懂，但在很多情况下，我们可以把它看作是对接下来可能出现词语的一种初步预测。

### 07. Feed-forward networks reason with vector math

Recent research from Brown University revealed an elegant example of how feed-forward layers help to predict the next word. Earlier we discussed Google’s word2vec research showing it was possible to use vector arithmetic to reason by analogy. For example, Berlin - Germany + France = Paris.

The Brown researchers found that feed-forward layers sometimes use this exact method to predict the next word. For example, they examined how GPT-2 responded to the following prompt: “Q: What is the capital of France? A: Paris Q: What is the capital of Poland? A:”

The team studied a version of GPT-2 with 24 layers. After each layer, the Brown scientists probed the model to observe its best guess at the next token. For the first 15 layers, the top guess was a seemingly random word. Between the 16th and 19th layer, the model started predicting that the next word would be Poland—not correct, but getting warmer. Then at the 20th layer, the top guess changed to Warsaw—the correct answer—and stayed that way in the last four layers.

The Brown researchers found that the 20th feed-forward layer converted Poland to Warsaw by adding a vector that maps country vectors to their corresponding capitals. Adding the same vector to China produced Beijing.

Feed-forward layers in the same model used vector arithmetic to transform lower-case words into upper-case words and present-tense words into their past-tense equivalents.

[[2305.16130] A Mechanism for Solving Relational Tasks in Transformer Language Models](https://arxiv.org/abs/2305.16130)

Direct Translation

前馈网络通过向量数学进行推理

布朗大学的最新研究揭示了一个优雅的例子，展示了前馈层如何帮助预测下一个单词。之前我们讨论了谷歌的 word2vec 研究，表明可以使用向量算术进行类比推理。例如，Berlin（柏林） - Germany（德国） + France（法国）= Paris（巴黎）。

布朗研究人员发现，前馈层有时会使用这种确切的方法来预测下一个单词。例如，他们研究了 GPT-2 对以下提示的反应：「Q: 法国的首都是什么？A: 巴黎 Q: 波兰的首都是什么？A:」

团队研究了一个具有 24 层的 GPT-2 版本。在每一层之后，布朗科学家探测了模型对下一个标记的最佳猜测。前 15 层，最高猜测是一个看似随机的单词。在第 16 到 19 层之间，模型开始预测下一个词将是 Poland（波兰）—— 虽然不正确，但接近了。然后在第 20 层，最高猜测变成了 Warsaw（华沙）—— 正确答案 —— 并在最后四层保持这种状态。

布朗研究人员发现，第 20 层的前馈层通过添加一个将国家向量转换为相应首都的向量，将 Poland（波兰）转换为 Warsaw（华沙）。将同一个向量添加到 China（中国）会得到 Beijing（北京）。

同一模型中的前馈层使用向量算术将小写单词转换为大写单词，以及将现在时单词转换为它们的过去时等价物。

---

Rephrased Translation

前馈网络使用向量数学进行推理

布朗大学的最新研究展示了一个优雅的例子，说明前馈层是如何帮助预测下一个单词的。我们之前讨论过谷歌的 word2vec 研究，表明可以使用向量算术进行类比推理。例如，Berlin（柏林）- Germany（德国）+ France（法国）= Paris（巴黎）。

布朗的研究人员发现，前馈层有时确实采用这种方法来预测下一个单词。例如，他们研究了 GPT-2 对以下提示的反应：「Q: 法国的首都是什么？A: 巴黎 Q: 波兰的首都是什么？A:」

该团队研究了一个有 24 层的 GPT-2 版本。在每一层之后，布朗的科学家们探查了模型对下一个标记的最佳猜测。在前 15 层，最高猜测是一个似乎随机的单词。在第 16 到 19 层之间，模型开始预测下一个词会是 Poland（波兰）—— 虽然不正确，但更接近了。然后在第 20 层，最高猜测变为 Warsaw（华沙）—— 正确答案 —— 并在最后四层保持这种状态。

布朗的研究人员发现，第 20 层的前馈层通过添加一个将国家向量转换为相应首都的向量，把 Poland（波兰）转换为 Warsaw（华沙）。对 China（中国）添加同样的向量会得出 Beijing（北京）。

同一模型中的前馈层使用向量算术将小写单词转换为大写单词，以及将现在时单词转换为过去时等价物。

### 08. The attention and feed-forward layers have different jobs

So far we’ve looked at two real-world examples of GPT-2 word predictions: attention heads helping to predict that John gave a drink to Mary, and a feed-forward layer helping to predict that Warsaw was the capital of Poland.

In the first case, Mary came from the user-provided prompt. But in the second case, Warsaw wasn’t in the prompt. Rather GPT-2 had to “remember” the fact that Warsaw was the capital of Poland—information it learned from training data.

When the Brown researchers disabled the feed-forward layer that converted Poland to Warsaw, the model no longer predicted Warsaw as the next word. But interestingly, if they then added the sentence “The capital of Poland is Warsaw” to the beginning of the prompt, then GPT-2 could answer the question again. This is probably because GPT-2 used attention heads to copy the name Warsaw from earlier in the prompt.

This division of labor holds more generally: attention heads retrieve information from earlier words in a prompt, whereas feed-forward layers enable language models to “remember” information that’s not in the prompt.

Indeed, one way to think about the feed-forward layers is as a database of information the model has learned from its training data. The earlier feed-forward layers are more likely to encode simple facts related to specific words, such as “Trump often comes after Donald.” Later layers encode more complex relationships like “add this vector to convert a country to its capital.”

Direct Translation

注意力层和前馈层有不同的任务

到目前为止，我们已经看到了 GPT-2 在单词预测方面的两个真实例子：注意力头帮助预测 John 给了 Mary 一杯饮料，前馈层帮助预测华沙是波兰的首都。

在第一个例子中，Mary 来自用户提供的提示。但在第二个例子中，华沙并不在提示中。相反，GPT-2 必须「记住」华沙是波兰首都的事实 —— 这是它从训练数据中学到的信息。

当布朗研究人员禁用了将 Poland（波兰）转换为 Warsaw（华沙）的前馈层时，模型不再预测华沙为下一个单词。但有趣的是，如果他们随后在提示的开头添加了「波兰的首都是华沙」的句子，那么 GPT-2 又能再次回答这个问题。这可能是因为 GPT-2 使用注意力头从提示的前面部分复制了 Warsaw（华沙）这个名字。

这种劳动分工更普遍地存在：注意力头从提示中较早的词语中检索信息，而前馈层使语言模型能够「记住」不在提示中的信息。

事实上，可以将前馈层视为模型从其训练数据中学到的信息数据库。较早的前馈层更有可能编码与特定单词相关的简单事实，如「Trump（特朗普）经常出现在 Donald（唐纳德）之后。」后面的层次则编码更复杂的关系，

如「添加这个向量以将一个国家转换为其首都。」

---

Rephrased Translation

注意力层和前馈层有不同的工作任务

到目前为止，我们已经看到了 GPT-2 在单词预测方面的两个真实例子：注意力头帮助预测 John 给 Mary 一杯饮料，前馈层帮助预测华沙是波兰的首都。

在第一个例子中，Mary 来自用户提供的提示。但在第二个例子中，华沙并不在提示中。相反，GPT-2 必须「记住」华沙是波兰首都的事实 —— 这是它从训练数据中学到的信息。

当布朗研究人员禁用了将 Poland（波兰）转换为 Warsaw（华沙）的前馈层时，模型不再预测华沙为下一个单词。但有趣的是，如果他们随后在提示的开头添加了「波兰的首都是华沙」的句子，那么 GPT-2 又能再次回答这个问题。这可能是因为 GPT-2 使用注意力头从提示的前面部分复制了 Warsaw（华沙）这个名字。

这种分工更普遍存在：注意力头从提示中早期的单词中检索信息，而前馈层使语言模型能够「记住」不在提示中的信息。

实际上，可以把前馈层看作是模型从其训练数据中学习到的信息的数据库。较早的前馈层往往编码与特定单词相关的简单事实，比如「Trump 经常跟在 Donald 之后」。而后续层次则编码更复杂的关系，例如「添加这个向量可以将一个国家转换成其首都。」

### 09. How language models are trained

Many early machine learning algorithms required training examples to be hand-labeled by human beings. For example, training data might have been photos of dogs or cats with a human-supplied label (“dog” or “cat”) for each photo. The need for humans to label data made it difficult and expensive to create large enough data sets to train powerful models.

A key innovation of LLMs is that they don’t need explicitly labeled data. Instead, they learn by trying to predict the next word in ordinary passages of text. Almost any written material—from Wikipedia pages to news articles to computer code—is suitable for training these models.

For example, an LLM might be given the input “I like my coffee with cream and” and be supposed to predict “sugar” as the next word. A newly-initialized language model will be really bad at this because each of its weight parameters—175 billion of them in the most powerful version of GPT-3—will start off as an essentially random number.

But as the model sees many more examples—hundreds of billions of words—those weights are gradually adjusted to make better and better predictions.

Here’s an analogy to illustrate how this works. Suppose you’re going to take a shower, and you want the temperature to be just right: not too hot, and not too cold. You’ve never used this faucet before, so you point the knob to a random direction and feel the temperature of the water. If it’s too hot, you turn it one way; if it’s too cold, you turn it the other way. The closer you get to the right temperature, the smaller the adjustments you make.

Now let’s make a couple of changes to the analogy. First, imagine that there are 50,257 faucets instead of just one. Each faucet corresponds to a different word like the, cat, or bank. Your goal is to have water only come out of the faucet corresponding to the next word in a sequence.

Second, there’s a maze of interconnected pipes behind the faucets, and these pipes have a bunch of valves on them as well. So if water comes out of the wrong faucet, you don’t just adjust the knob at the faucet. You dispatch an army of intelligent squirrels to trace each pipe backwards and adjust each valve they find along the way.

This gets complicated because the same pipe often feeds into multiple faucets. So it takes careful thought to figure out which valves to tighten and which ones to loosen, and by how much.

Obviously, this example quickly gets silly if you take it too literally. It wouldn’t be realistic or useful to build a network of pipes with 175 billion valves. But thanks to Moore’s Law, computers can and do operate at this kind of scale.

All the parts of LLMs we’ve discussed in this article so far—the neurons in the feed-forward layers and the attention heads that move contextual information between words—are implemented as a chain of simple mathematical functions (mostly matrix multiplications) whose behavior is determined by adjustable weight parameters. Just as the squirrels in my story loosen and tighten the valves to control the flow of water, so the training algorithm increases or decreases the language model’s weight parameters to control how information flows through the neural network.

The training process happens in two steps. First there’s a “forward pass,” where the water is turned on and you check if it comes out the right faucet. Then the water is turned off and there’s a “backwards pass” where the squirrels race along each pipe tightening and loosening valves. In digital neural networks, the role of the squirrels is played by an algorithm called backpropagation, which “walks backwards” through the network, using calculus to estimate how much to change each weight parameter.5

Completing this process—doing a forward pass with one example and then a backwards pass to improve the network’s performance on that example—requires hundreds of billions of mathematical operations. And training a model as big as GPT-3 requires repeating the process billions of times—once for each word of training data.6 OpenAI estimates that it took more than 300 billion trillion floating point calculations to train GPT-3—that’s months of work for dozens of high-end computer chips.

许多早期机器学习算法需要人工对训练样本进行标记。比如，训练数据可能是狗或猫的照片，每张照片都附有人工提供的标签（如「狗」或「猫」）。需要人工标记数据使得创建足够大的训练数据集变得既困难又昂贵。

LLMs 的一个关键创新在于它们不需要显式标记的数据。它们是通过尝试预测普通文本段落中的下一个单词来学习的。几乎所有的书面材料 —— 从维基百科页面到新闻文章，甚至计算机代码 —— 都适合用来训练这些模型。

例如，一个 LLM 可能会得到「I like my coffee with cream and」这样的输入，并应预测「sugar」作为下一个单词。一个新初始化的语言模型在这方面做得非常糟糕，因为其每个权重参数 —— 在 GPT-3 最强大版本中有 1750 亿个 —— 最初都是基本随机的数字。

但随着模型接触到更多示例 —— 数千亿词 —— 这些权重逐渐调整，从而做出越来越准确的预测。

这里有一个类比来说明这个过程。假设你要洗澡，想要水温恰到好处：不太热，也不太冷。你之前没用过这个水龙头，所以你随机转动旋钮并感受水温。如果水太热，你会向一个方向转；如果太冷，你会向另一个方向转。你离理想温度越近，调整的幅度就越小。

现在让我们对这个类比做一些修改。首先，想象不是一个水龙头，而是 50,257 个水龙头。每个水龙头对应一个不同的词，比如 the、cat 或 bank。你的目标是让水只从对应序列中下一个单词的水龙头流出。

其次，在这些水龙头后面，有一个错综复杂且相互连接的管道网，这些管道上也装有许多阀门。因此，如果水从错误的水龙头流出，你不只是调整水龙头上的旋钮。你会派出一群聪明的松鼠，沿着每条管道向后追踪，并沿途调整它们遇到的每一个阀门。

这个过程会变得复杂，因为同一管道通常会通向多个水龙头。因此，需要仔细考虑哪些阀门该拧紧，哪些该放松，以及调整的程度。

显然，如果过于字面地理解这个例子，它会变得荒谬。建造一个拥有 1750 亿个阀门的管道网络既不现实也无用。但得益于摩尔定律，计算机可以并且确实处理这种规模的运作。

本文讨论的所有 LLMs 部分 —— 前馈层中的神经元和在单词间移动上下文信息的注意力头 —— 都是通过一系列简单的数学函数（主要是矩阵乘法）实现的，其行为取决于可调节的权重参数。就像故事中的松鼠通过松紧阀门来控制水流一样，训练算法通过增加或减少语言模型的权重参数来控制信息在神经网络中的流动。

训练过程分为两个步骤。首先是「前向传递」，打开水龙头检查水是否从正确的水龙头流出。然后关闭水龙头进行「反向传递」，其中松鼠在每条管道上奔跑，调整阀门。在数字神经网络中，松鼠的角色由一种称为反向传播的算法扮演，该算法「向后穿越」网络，使用微积分来估计每个权重参数的调整幅度。

完成这个过程 —— 对一个示例进行前向传递，然后进行反向传递以提高网络在该示例上的表现 —— 需要数千亿次数学运算。训练像 GPT-3 这样大型的模型需要重复这个过程数十亿次 —— 针对训练数据的每个词各一次。OpenAI 估计，训练 GPT-3 需要超过 300 亿万次浮点计算 —— 这相当于几十个高端计算机芯片数月的工作量。

### 10. The surprising performance of GPT-3

You might find it surprising that the training process works as well as it does. ChatGPT can perform all sorts of complex tasks—composing essays, drawing analogies, and even writing computer code. So how does such a simple learning mechanism produce such a powerful model?

One reason is scale. It’s hard to overstate the sheer number of examples that a model like GPT-3 sees. GPT-3 was trained on a corpus of approximately 500 billion words. For comparison a typical human child encounters roughly 100 million words by age 10.

Over the last five years, OpenAI has steadily increased the size of its language models. In a widely-read 2020 paper, OpenAI reported that the accuracy of its language models scaled “as a power-law with model size, dataset size, and the amount of compute used for training, with some trends spanning more than seven orders of magnitude.”

The larger their models got, the better they were at tasks involving language. But this was only true if they increased the amount of training data by a similar factor. And to train larger models on more data, you need a lot more computing power.

OpenAI’s first LLM, GPT-1, was released in 2018. It used 768-dimensional word vectors and had 12 layers for a total of 117 million parameters. A few months later, OpenAI released GPT-2. Its largest version had 1,600-dimensional word vectors, 48 layers, and a total of 1.5 billion parameters.

In 2020, OpenAI released GPT-3, which featured 12,288-dimensional word vectors and 96 layers for a total of 175 billion parameters.

Finally, this year OpenAI released GPT-4. The company has not published any architectural details, but GPT-4 is widely believed to be significantly larger than GPT-3.

Each model not only learned more facts than its smaller predecessors, it also performed better on tasks requiring some form of abstract reasoning:

For example, consider the following story:

Here is a bag filled with popcorn. There is no chocolate in the bag. Yet, the label on the bag says “chocolate” and not “popcorn.” Sam finds the bag. She had never seen the bag before. She cannot see what is inside the bag. She reads the label.

You can probably guess that Sam believes the bag contains chocolate and will be surprised to discover popcorn inside. Psychologists call this capacity to reason about the mental states of other people “theory of mind.” Most people have this capacity from the time they’re in grade school. Experts disagree about whether any non-human animals (like chimpanzees) have theory of mind, but there’s general consensus that it is important for human social cognition.

Earlier this year, Stanford psychologist Michal Kosinski published research examining the ability of LLMs to solve theory-of-mind tasks. He gave various language models passages like the one we quoted above and then asked them to complete a sentence like “she believes that the bag is full of.” The correct answer is “chocolate,” but an unsophisticated language model might say “popcorn” or something else.

GPT-1 and GPT-2 flunked this test. But the first version of GPT-3, released in 2020, got it right almost 40 percent of the time—a level of performance Kosinski compares to a three-year-old. The latest version of GPT-3, released last November, improved this to around 90 percent—on par with a seven-year-old. GPT-4 answered about 95 percent of theory-of-mind questions correctly.

“Given that there is neither an indication that ToM-like ability was deliberately engineered into these models, nor research demonstrating that scientists know how to achieve that, ToM-like ability likely emerged spontaneously and autonomously, as a byproduct of models’ increasing language ability,” Kosinski wrote. 

It’s worth noting that researchers don’t all agree that these results indicate evidence of Theory of Mind: for example, small changes to the false-belief task led to much worse performance by GPT-3; and GPT-3 exhibits more variable performance across other tasks measuring theory of mind. As one of us (Sean) has written, it could be that successful performance is attributable to confounds in the task—a kind of “clever Hans” effect, only in language models rather than horses.

Nonetheless, the near-human performance of GPT-3 on several tasks designed to measure theory of mind would have been unthinkable just a few years ago—and is consistent with the idea that bigger models are generally better at tasks requiring high-level reasoning.

This is just one of many examples of language models appearing to spontaneously develop high-level reasoning capabilities. In April, researchers at Microsoft published a paper arguing that GPT-4 showed early, tantalizing hints of artificial general intelligence—the ability to think in a sophisticated, human-like way.

For example, one researcher asked GPT-4 to draw a unicorn using an obscure graphics programming language called TiKZ. GPT-4 responded with a few lines of code that the researcher then fed into the TiKZ software. The resulting images were crude, but they showed clear signs that GPT-4 had some understanding of what unicorns look like. 

The researchers thought GPT-4 might have somehow memorized code for drawing a unicorn from its training data, so they gave it a follow-up challenge: they altered the unicorn code to remove the horn and move some of the other body parts. Then they asked GPT-4 to put the horn back on. GPT-4 responded by putting the horn in the right spot:

GPT-4 was able to do this even though the training data for the version tested by the authors was entirely text-based. That is, there were no images in its training set. But GPT-4 apparently learned to reason about the shape of a unicorn’s body after training on a huge amount of written text.

At the moment, we don’t have any real insight into how LLMs accomplish feats like this. Some people argue that examples like this demonstrate that the models are starting to truly understand the meanings of the words in their training set. Others insist that language models are “stochastic parrots” that merely repeat increasingly complex word sequences without truly understanding them.

This debate points to a deep philosophical tension that may be impossible to resolve. Nonetheless, we think it is important to focus on the empirical performance of models like GPT-3. If a language model is able to consistently get the right answer for a particular type of question, and if researchers are confident that they have controlled for confounds (e.g., ensuring that the language model was not exposed to those questions during training), then that is an interesting and important result whether or not it understands language in exactly the same sense that people do.

Another possible reason that training with next-token prediction works so well is that language itself is predictable. Regularities in language are often (though not always) connected to regularities in the physical world. So when a language model learns about relationships among words, it’s often implicitly learning about relationships in the world too.

Further, prediction may be foundational to biological intelligence as well as artificial intelligence. In the view of philosophers like Andy Clark, the human brain can be thought of as a “prediction machine”, whose primary job is to make predictions about our environment that can then be used to navigate that environment successfully. Intuitively, making good predictions benefits from good representations—you’re more likely to navigate successfully with an accurate map than an inaccurate one. The world is big and complex, and making predictions helps organisms efficiently orient and adapt to that complexity.

Traditionally, a major challenge for building language models was figuring out the most useful way of representing different words—especially because the meanings of many words depend heavily on context. The next-word prediction approach allows researchers to sidestep this thorny theoretical puzzle by turning it into an empirical problem. It turns out that if we provide enough data and computing power, language models end up learning a lot about how human language works simply by figuring out how to best predict the next word. The downside is that we wind up with systems whose inner workings we don’t fully understand.

Tim Lee was on staff at Ars from 2017 to 2021. He recently launched a new newsletter, Understanding AI. It explores how AI works and how it's changing our world. You can subscribe to his newsletter here.

Sean Trott is an Assistant Professor at University of California, San Diego, where he conducts research on language understanding in humans and large language models. He writes about these topics, and others, in his newsletter The Counterfactual.

[2001.08361.pdf](https://arxiv.org/pdf/2001.08361.pdf)

[[2302.02083] Theory of Mind Might Have Spontaneously Emerged in Large Language Models](https://arxiv.org/abs/2302.02083)

[[2302.08399] Large Language Models Fail on Trivial Alterations to Theory-of-Mind Tasks](https://arxiv.org/abs/2302.08399)

[EPITOME: Experimental Protocol Inventory for Theory Of Mind Evaluation | OpenReview](https://openreview.net/forum?id=e5Yky8Fnvj)

[Do Large Language Models Know What Humans Know? - Trott - 2023 - Cognitive Science - Wiley Online Library](https://onlinelibrary.wiley.com/doi/full/10.1111/cogs.13309)

[[2303.12712] Sparks of Artificial General Intelligence: Early experiments with GPT-4](https://arxiv.org/abs/2303.12712)

Direct Translation

你可能会觉得令人惊讶的是，训练过程竟然如此有效。ChatGPT 能够执行各种复杂任务 —— 撰写文章、类比推理，甚至编写计算机代码。那么，这样一个简单的学习机制是如何产生如此强大的模型的呢？

一个原因是规模。很难夸大像 GPT-3 这样的模型所看到的实例数量。GPT-3 接受了大约 5000 亿个单词的训练。作为对比，一个典型的 10 岁儿童大约接触了 1 亿个单词。

在过去的五年中，OpenAI 不断增加其语言模型的规模。在一篇广受关注的 2020 年论文中，OpenAI 报告称，其语言模型的准确性「随着模型规模、数据集大小和用于训练的计算量的增加而呈幂律增长，有些趋势跨越了七个数量级以上。」

他们的模型越大，它们在涉及语言的任务上就越擅长。但这只有在他们以类似的因素增加训练数据量时才成立。而要在更多数据上训练更大的模型，你需要更多的计算能力。

OpenAI 的第一个 LLM，GPT-1，于 2018 年发布。它使用 768 维的词向量，拥有 12 层，总共有 1.17 亿个参数。几个月后，OpenAI 发布了 GPT-2。其最大版本拥有 1600 维的词向量，48 层，总共有 15 亿个参数。

2020 年，OpenAI 发布了 GPT-3，它拥有 12,288 维的词向量和 96 层，总共有 1750 亿个参数。

最后，今年 OpenAI 发布了 GPT-4。公司尚未公布任何架构细节，但普遍认为 GPT-4 比 GPT-3 要大得多。

每个模型不仅比其较小的前身学到了更多事实，而且在需要某种形式抽象推理的任务上表现得更好：

例如，考虑以下故事：

这是一个装满爆米花的袋子。袋子里没有巧克力。然而，袋子上的标签写着「巧克力」而不是「爆米花」。Sam 发现了这个袋子。她之前从未见过这个袋子。她看不见袋子里面是什么。她读了标签。

你可能会猜到 Sam 认为袋子里装的是巧克力，发现里面是爆米花时会感到惊讶。心理学家称这种推理其他人心理状态的能力为「心理理论」。大多数人从上小学时就拥有这种能力。专家们对于任何非人类动物（如黑猩猩）是否具有心理理论存在分歧，但普遍共识是它对人类社会认知很重要。

今年早些时候，斯坦福心理学家 Michal Kosinski 发表了研究，考察 LLMs 解决心理理论任务的能力。他给了各种语言模型类似上面引用的段落，然后要求它们完成像「她认为袋子里装满了。」这样的句子。正确答案是「巧克力」，但一个不成熟的语言模型可能会说「爆米花」或其他东西。

GPT-1 和 GPT-2 未通过这个测试。但 2020 年发布的 GPT-3 第一个版本几乎 40% 的时间都做对了 ——Kosinski 将这种表现与三岁儿童相比。去年 11 月发布的 GPT-3 最新版本将其提高到了大约 90%—— 与七岁儿童相当。GPT-4 回答了大约 95% 的心理理论问题。

Kosinski 写道：「鉴于没有迹象表明这些模型中有意地设计了类似心理理论的能力，也没有研究表明科学家们知道如何实现这一点，类似心理理论的能力可能是自发且自主出现的，是模型日益增长的语言能力的副产品。」

值得注意的是，并非所有研究人员都认为这些结果表明心理理论的证据：例如，对错误信念任务的微小改变导致 GPT-3 的表现大大下降；而 GPT-3 在衡量心理理论的其他任务中表现更为多变。正如我们（Sean）中的一位所写，成功的表现可能归因于任务中的混淆因素 —— 一种「聪明的汉斯」效应，只是在语言模型中而不是在马中。

尽管如此，GPT-3 在设计用来衡量心理理论的几项任务上接近人类的表现，在几年前还是难以想象的 —— 这与更大的模型通常在需要高级推理的任务上表现更好的想法一致。

这只是众多语言模型似乎自发发展高级推理能力的例子之一。今年四月，微软的研究人员发表了一篇论文，认为 GPT-4 显示出人工通用智能的早期、诱人的迹象 —— 即以复杂、类似人类的方式思考的能力。

例如，一位研究员要求 GPT-4 使用一种名为 TiKZ 的晦涩图形编程语言来绘制一只独角兽。GPT-4 回应了几行代码，研究员随后将其输入到 TiKZ 软件中。结果图像虽然粗糙，但显示出 GPT-4 对独角兽长什么样有一定的理解。

研究人员认为 GPT-4 可能在某种程度上从其训练数据中记住了绘制独角兽的代码，因此他们给出了一个后续挑战：他们更改了独角兽的代码，移除了角并移动了一些其他身体部分。然后他们要求 GPT-4 重新放上角。GPT-4 的回应是将角放在正确的位置：

GPT-4 能够做到这一点，即使作者测试的版本的训练数据完全是基于文本的。也就是说，它的训练集中没有图像。但 GPT-4 显然在训练大量书面文本后学会了推理独角兽身体的形状。

目前，我们对 LLMs 如何完成这样的壮举没有任何真正的洞察。有些人认为，像这样的例子表明这些模型开始真正理解它们训练集中的单词含义。其他人则坚持认为语言模型是「随机鹦鹉」，只是在不断重复越来越复杂的词序列，而没有真正理解它们。

这场辩论指向了一个深层的哲学张力，可能无法解决。尽管如此，我们认为关注像 GPT-3 这样的模型的实证表现是重要的。如果一个语言模型能够在特定类型的问题上一致得到正确答案，并且如果研究人员确信他们已经控制了混淆因素（例如，确保语言模型在训练期间没有接触到那些问题），那么无论它是否以与人类相同的方式理解语言，这都是一个有趣且重要的结果。

另一个可能的原因是，使用下一个词预测进行训练效果如此好的原因是，语言本身是可预测的。语言中的规律性通常（尽管不总是）与物理世界中的规律性相连。所以当语言模型学习单词之间的关系时，它通常也在隐式地学习世界中的关系。

此外，预测可能是生物智能和人工智能的基础。在像 Andy Clark 这样的哲学家看来，人类大脑可以被视为一个「预测机器」，其主要工作是对我们的环境做出预测，然后用这些预测来成功地导航环境。直觉上，做出好的预测需要好的表示 —— 你用准确的地图导航的可能性比用不准确的地图要高。世界是庞大而复杂的，做出预测有助于有机体有效地定位和适应这种复杂性。

传统上，构建语言模型的一个主要挑战是弄清楚表示不同单词的最有用方式 —— 特别是因为许多单词的含义严重依赖于上下文。下一个词预测方法允许研究人员绕过这个棘手的理论难题，将其转化为一个经验问题。事实证明，如果我们提供足够的数据和计算能力，语言模型最终会通过弄清楚如何最好地预测下一个词来学习很多关于人类语言如何运作的知识。缺点是我们最终得到了一些内部运作我们不完全理解的系统。

Tim Lee 于 2017 年至 2021 年在 Ars 工作。他最近推出了一份新的时事通讯《理解 AI》。它探讨了 AI 如何工作以及它是如何改变我们的世界的。你可以在这里订阅他的时事通讯。

Sean Trott 是加州大学圣地亚哥分校的助理教授，他在那里进行人类和大型语言模型的语言理解研究。他在他的时事通讯《反事实》中写了这些主题，以及其他主题。

---

Rephrased Translation

你可能会对训练过程的有效性感到惊讶。ChatGPT 能够完成各种复杂任务 —— 撰写文章、进行类比推理，甚至编写计算机代码。那么，这样一个简单的学习机制是如何培养出如此强大的模型的呢？

其中一个原因是规模。对于像 GPT-3 这样的模型所接触到的实例数量，几乎无法夸大其数量。GPT-3 训练了大约 5000 亿个单词。相比之下，一个典型的 10 岁儿童接触的单词量大约为 1 亿个。

在过去五年里，OpenAI 不断增加其语言模型的规模。在 2020 年的一篇广受关注的论文中，OpenAI 报告称，其语言模型的准确性随模型规模、数据集大小和训练计算量的增加而成幂律增长，有些趋势跨越七个数量级以上。

模型的规模越大，它们在涉及语言的任务上表现越好。但这只有在训练数据量以相似的因子增加时才适用。而要在更多的数据上训练更大的模型，你需要更强大的计算能力。

OpenAI 的第一个 LLM，GPT-1，于 2018 年发布。它使用 768 维词向量，有 12 层，总共有 1.17 亿个参数。几个月后，OpenAI 发布了 GPT-2。其最大版本有 1600 维

词向量，48 层，共有 15 亿个参数。

2020 年，OpenAI 发布了 GPT-3，该版本有 12,288 维词向量和 96 层，总共有 1750 亿个参数。

最后，今年 OpenAI 发布了 GPT-4。该公司尚未公布任何架构细节，但普遍认为 GPT-4 比 GPT-3 要大得多。

每个模型不仅学习到比其较小版本更多的事实，而且在需要某种形式的抽象推理的任务上表现更佳：

举个例子，考虑以下故事：

这是一个装满爆米花的袋子。袋子里没有巧克力。然而，袋子上的标签写着「巧克力」，而不是「爆米花」。Sam 找到了这个袋子。她之前从未见过这个袋子。她看不到袋子里是什么。她读了标签。

你可能会猜测 Sam 认为袋子里装的是巧克力，并且当她发现里面是爆米花时会感到惊讶。心理学家称这种推理出他人心理状态的能力为「心理理论」。大多数人从小学时就具备这种能力。关于非人类动物（如黑猩猩）是否拥有心理理论，专家意见不一，但普遍认为它对人类社会认知非常重要。

今年早些时候，斯坦福心理学家 Michal Kosinski 发表了一项研究，检验 LLMs 解决心理理论任务的能力。他给不同的语言模型提供了类似上述的段落，然后要求它们完成诸如「她认为袋子里装满了……」的句子。正确答案是「巧克力」，但一个不成熟的语言模型可能会说「爆米花」或其他东西。

GPT-1 和 GPT-2 在这个测试中失败了。但 2020 年发布的 GPT-3 第一个版本在大约 40% 的时间里做对了 ——Kosinski 将这种表现与三岁儿童相比较。去年 11 月发布的最新版 GPT-3 将其提高到了大约 90%—— 相当于七岁儿童的水平。GPT-4 正确回答了大约 95% 的心理理论问题。

Kosinski 写道：「鉴于没有迹象表明这些模型中有意地设计了类似心理理论的能力，也没有研究证明科学家们知道如何实现这一点，类似心理理论的能力可能是模型日益增长的语言能力的自发且自主的副产品。」

值得注意的是，并非所有研究人员都认同这些结果表明了心理理论的证据：例如，对错误信念任务的微小改动会导致 GPT-3 表现大幅下降；而 GPT-3 在衡量心理理论的其他任务中表现更为不稳定。正如我们（Sean）中的一位所写的，成功的表现可能归因于任务中的混淆因素 —— 一种「聪明的汉斯」效应，只不过是在语言模型中而非马匹中。

尽管如此，GPT-3 在设计用来测试心理理论的几项任务上接近人类水平的表现，在几年前还是难以想象的 —— 这与更大的模型通常在需要高级推理的任务上表现更好的观点一致。

这只是语言模型似乎自发发展高级推理能力的众多例子之一。今年四月，微软的研究人员发表了一篇论文，指出 GPT-4 展现了人工通用智能的早期迹象 —— 即以复杂、类似人类的方式进行思考的能力。

例如，一位研究员要求 GPT-4 使用一种名为

TiKZ 的复杂图形编程语言来绘制一只独角兽。GPT-4 回应了几行代码，研究员随后输入到 TiKZ 软件中。虽然结果图像很粗糙，但它们表明 GPT-4 对独角兽的样子有一定的理解。

研究人员认为 GPT-4 可能在某种程度上从其训练数据中记住了绘制独角兽的代码，因此他们提出了一个后续挑战：他们修改了独角兽的代码，移除了角并移动了一些其他身体部分。然后他们要求 GPT-4 重新添加角。GPT-4 将角放在了正确的位置：

GPT-4 能够做到这一点，即使作者测试的版本的训练数据完全基于文本。也就是说，它的训练集中没有图像。但 GPT-4 显然在训练了大量的书面文本后学会了推理出独角兽的身体形状。

目前，我们对 LLMs 如何完成这类壮举没有任何真正的洞见。有些人认为，这样的例子表明这些模型开始真正理解其训练集中的单词含义。其他人则坚持认为语言模型只是「随机鹦鹉」，仅仅重复越来越复杂的词序列，而没有真正的理解。

这种争论反映了一个深层的哲学矛盾，可能无法解决。尽管如此，我们认为关注像 GPT-3 这样的模型的实证表现非常重要。如果一个语言模型能够在特定类型的问题上一致得到正确答案，并且如果研究人员确信他们已经控制了混淆因素（例如，确保模型在训练期间没有接触到那些问题），那么无论它是否以与人类相同的方式理解语言，这都是一个有趣且重要的结果。

另一个可能原因是，下一个词预测训练如此有效，是因为语言本身具有可预测性。语言中的规律性通常（尽管并非总是）与物理世界中的规律性相关联。因此，当语言模型学习单词间的关系时，它们通常也在隐式地学习世界中的关系。

此外，预测或许是生物智能和人工智能的基础。在像 Andy Clark 这样的哲学家看来，人类大脑可以被看作是一个「预测机器」，其主要任务是对环境进行预测，然后利用这些预测成功地导航环境。直觉上，做出好的预测需要良好的表示 —— 你用准确的地图导航的可能性比用不准确的地图要高。世界既庞大又复杂，进行预测有助于生物高效地定位和适应这种复杂性。

传统上，构建语言模型的一个主要挑战是确定表示不同单词的最有效方式 —— 特别是因为许多单词的含义在很大

程度上取决于上下文。下一个词预测方法让研究人员绕开这个棘手的理论问题，将其转化为一个实证问题。事实证明，如果我们提供足够的数据和计算能力，语言模型会通过弄清楚如何最好地预测下一个词来学习大量关于人类语言运作方式的知识。不足之处是，我们最终得到了一些内部工作机制我们并不完全理解的系统。

Tim Lee 于 2017 年至 2021 年在 Ars 工作。他最近推出了一份新的通讯《理解 AI》，探讨 AI 如何工作及其如何改变我们的世界。你可以在这里订阅他的通讯。

Sean Trott 是加州大学圣地亚哥分校的助理教授，他在那里从事人类和大型语言模型的语言理解研究。他在他的通讯《反事实》中写了这些和其他主题。

1 Technically, LLMs operate on fragments of words called tokens, but we’re going to ignore this implementation detail to keep the article to a manageable length.

2 Technically, the original version of ChatGPT is based on GPT-3.5, a successor to GPT-3 that underwent a process called Reinforcement Learning with Human Feedback (RLHF). OpenAI hasn't released all the architectural details for this model, so in this piece we'll focus on GPT-3, the last version that OpenAI has described in detail.

3 The feed-forward network is also known as a multilayer perceptron. Computer scientists have been experimenting with this type of neural network since the 1960s.

4 Technically, after a neuron computes a weighted sum of its inputs, it passes the result to an activation function. We’re going to ignore this implementation detail, but you can read Tim’s 2018 explainer if you want a full explanation of how neurons work.

5 If you want to learn more about backpropagation, check out Tim’s 2018 explainer on how neural networks work.

6 In practice, training is often done in batches for the sake of computational efficiency. So the software might do the forward pass on 32,000 tokens before doing a backward pass.

Direct Translation

1 从技术上讲，LLMs 操作的是称为 token 的单词片段，但我们将忽略这个实现细节以保持文章长度可管理。

2 从技术上讲，ChatGPT 的原始版本是基于 GPT-3.5 的，这是 GPT-3 的后续版本，经历了一个称为「人类反馈强化学习」（RLHF）的过程。OpenAI 尚未发布这个模型的所有架构细节，所以在这篇文章中，我们将关注 GPT-3，这是 OpenAI 详细描述的最后一个版本。

3 前馈网络也被称为多层感知器。计算机科学家自 1960 年代以来一直在试验这种类型的神经网络。

4 从技术上讲，在神经元计算了其输入的加权和后，它会将结果传递给激活函数。我们将忽略这个实现细节，但如果你想完全了解神经元是如何工作的，可以阅读 Tim 的 2018 年解释器。

5 如果你想了解更多关于反向传播的信息，可以查看 Tim 的 2018 年关于神经网络如何工作的解释。

6 实际上，为了计算效率，训练通常是批量进行的。因此，软件可能会对 32,000 个 token 进行前向传递，然后进行反向传递。

---

Rephrased Translation

1 从技术角度来说，LLMs 处理的是被称为「token」的单词片段，但为了保持文章长度的可控性，我们将忽略这一实现细节。

2 从技术上讲，ChatGPT 的原始版本基于 GPT-3.5，它是 GPT-3 的后续版本，经过了一种名为「人类反馈强化学习」（RLHF）的过程。OpenAI 还没有公布这个模型的所有架构细节，因此在这篇文章中，我们将专注于 GPT-3，这是 OpenAI 详细描述的最新版本。

3 前馈网络也被称为多层感知机。计算机科学家从 20 世纪 60 年代以来一直在试验这种类型的神经网络。

4 从技术上讲，在神经元计算出其输入的加权和之后，它会将结果传递给一个激活函数。我们将忽略这个实现细节，但如果你想完全了解神经元的工作原理，可以阅读 Tim 在 2018 年的解释文章。

5 如果你想了解更多关于反向传播的信息，可以查阅 Tim 在 2018 年关于神经网络工作原理的解释文章。

6 实际上，为了计算效率，训练通常是以批量进行的。因此，软件可能会对 32,000 个 token 进行一次前向传递，然后进行一次反向传递。