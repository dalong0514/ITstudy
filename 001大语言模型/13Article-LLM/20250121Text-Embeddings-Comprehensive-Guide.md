## Text-Embeddings-Comprehensive-Guide

[Text Embeddings: Comprehensive Guide | by Mariya Mansurova | Towards Data Science](https://towardsdatascience.com/text-embeddings-comprehensive-guide-afd97fce8fb5)

Evolution, visualisation, and applications of text embeddings

Mariya Mansurova

Published in Towards Data Science

Feb 13, 2024

As human beings, we can read and understand texts (at least some of them). Computers in opposite “think in numbers”, so they can’t automatically grasp the meaning of words and sentences. If we want computers to understand the natural language, we need to convert this information into the format that computers can work with — vectors of numbers.

作为人类，我们能够阅读和理解文本（至少是部分文本）。与之相反，计算机是「以数字为基础进行思考」的，因此它们无法自动理解单词和句子的含义。如果我们想让计算机理解自然语言，就需要将文本信息转换为计算机可以处理的格式 —— 数字向量。

People learned how to convert texts into machine-understandable format many years ago (one of the first versions was ASCII). Such an approach helps render and transfer texts but doesn’t encode the meaning of the words. At that time, the standard search technique was a keyword search when you were just looking for all the documents that contained specific words or N-grams.

人们很早之前就学会了如何将文本转换为机器可理解的格式（最早的版本之一是 ASCII）。这种方法有助于呈现和传输文本，但并没有赋予词语意义。当时，标准的搜索技术是关键词搜索，也就是查找所有包含特定词语或 N-gram 的文档。

Then, after decades, embeddings have emerged. We can calculate embeddings for words, sentences, and even images. Embeddings are also vectors of numbers, but they can capture the meaning. So, you can use them to do a semantic search and even work with documents in different languages.

随后，经过数十年的发展，嵌入（embeddings）技术应运而生。我们现在可以计算单词、句子乃至图像的嵌入。嵌入本质上是数字向量，但它们能够捕捉到其中的语义信息。因此，你可以利用它们进行语义搜索，甚至处理不同语言的文档。

In this article, I would like to dive deeper into the embedding topic and discuss all the details:

在本文中，我将深入探讨嵌入这个主题，并详细讨论以下内容：

what preceded the embeddings and how they evolved,

嵌入的起源与演变，

how to calculate embeddings using OpenAI tools,

如何使用 OpenAI 工具计算嵌入，

how to define whether sentences are close to each other,

如何判断句子之间的相似性，

how to visualise embeddings,

如何可视化嵌入，

the most exciting part is how you could use embeddings in practice.

以及最令人兴奋的，如何在实践中使用嵌入。

Let’s move on and learn about the evolution of embeddings.

接下来，让我们一起了解嵌入的演变历程。

### 01. Evolution of Embeddings

We will start our journey with a brief tour into the history of text representations.

文本向量表示的演变我们将首先简要回顾文本表示的历史。

Bag of Words

The most basic approach to converting texts into vectors is a bag of words. Let’s look at one of the famous quotes of Richard P. Feynman “We are lucky to live in an age in which we are still making discoveries”. We will use it to illustrate a bag of words approach.

词袋将文本转换为向量最基本的方法是词袋（bag of words）模型。我们以理查德·费曼（Richard P. Feynman）的一句名言「我们很幸运生活在一个我们仍在进行发现的时代」为例。我们将使用这句话来阐述词袋方法。





The first step to get a bag of words vector is to split the text into words (tokens) and then reduce words to their base forms. For example, “running” will transform into “run”. This process is called stemming. We can use the NLTK Python package for it.

要得到词袋向量，第一步是将文本拆分成词语（Token），然后将词语转换为它们的基本形式。例如，「running」会变成「run」。这个过程叫做词干提取（stemming）。我们可以使用 NLTK Python 包来完成这个操作。

Now, we have a list of base forms of all our words. The next step is to calculate their frequencies to create a vector.

Actually, if we wanted to convert our text into a vector, we would have to take into account not only the words we have in the text but the whole vocabulary. Let’s assume we also have “i”, “you” and ”study” in our vocabulary and let’s create a vector from Feynman’s quote.

现在，我们已经有了所有单词的词根列表。下一步是计算它们的词频，从而创建一个向量。

实际上，如果想要将文本转化为向量，我们不仅要考虑文本中出现的单词，还要考虑整个词汇表。假设我们的词汇表中还包括「i」、「you」和「study」这几个词，现在让我们用费曼的引言创建一个向量。

This approach is quite basic, and it doesn’t take into account the semantic meaning of the words, so the sentences “the girl is studying data science” and “the young woman is learning AI and ML” won’t be close to each other.

这种方法非常基础，而且没有考虑词语的语义，因此「这个女孩正在学习数据科学」和「这个年轻的女人正在学习人工智能和机器学习」这两个句子之间的关联性不大。

TF-IDF
A slightly improved version of the bag of the words approach is TF-IDF (Term Frequency — Inverse Document Frequency). It’s the multiplication of two metrics.

TF-IDF
TF-IDF（词频 - 逆文档频率）是对词袋方法的一种改进。它通过将两个指标相乘得到。


Term Frequency shows the frequency of the word in the document. The most common way to calculate it is to divide the raw count of the term in this document (like in the bag of words) by the total number of terms (words) in the document. However, there are many other approaches like just raw count, boolean “frequencies”, and different approaches to normalisation. You can learn more about different approaches on Wikipedia.

词频（Term Frequency） 表示一个词在文档中出现的频率。最常见的计算方法是将该词在文档中的原始计数（就像在词袋模型中一样）除以文档中词的总数。当然，还有许多其他计算方法，比如直接使用原始计数、布尔频率，以及各种不同的归一化方法。您可以在 Wikipedia 上找到更多关于这些方法的详细信息。

Inverse Document Frequency denotes how much information the word provides. For example, the words “a” or “that” don’t give you any additional information about the document’s topic. In contrast, words like “ChatGPT” or “bioinformatics” can help you define the domain (but not for this sentence). It’s calculated as the logarithm of the ratio of the total number of documents to those containing the word. The closer IDF is to 0 — the more common the word is and the less information it provides.

逆文档频率（Inverse Document Frequency，IDF）衡量一个词所携带的信息量。例如，像「a」或「that」这样的词，并不能提供关于文档主题的额外信息。相反，像「ChatGPT」或「生物信息学」这样的词则有助于我们确定文档所属的领域（当然，这里指的不是本句话）。它的计算方法是：先求出文档总数与包含该词的文档数的比值，再取该比值的对数。IDF 的值越接近 0，表示该词越常见，它所携带的信息量就越少。

So, in the end, we will get vectors where common words (like “I” or “you”) will have low weights, while rare words that occur in the document multiple times will have higher weights. This strategy will give a bit better results, but it still can’t capture semantic meaning.

因此，最终我们会得到一些向量，其中像「我」或「你」这样的常用词权重较低，而文档中多次出现的稀有词权重较高。这种策略能带来略微提升的效果，但仍然无法理解语义。

The other challenge with this approach is that it produces pretty sparse vectors. The length of the vectors is equal to the corpus size. There are about 470K unique words in English (source), so we will have huge vectors. Since the sentence won’t have more than 50 unique words, 99.99% of the values in vectors will be 0, not encoding any info. Looking at this, scientists started to think about dense vector representation.

这种方法还面临一个挑战，那就是它会生成非常稀疏的向量。这些向量的长度与语料库的大小相同。例如，英语中大约有 47 万个不同的单词（来源），这意味着我们会得到维度非常高的向量。由于一个句子通常不会包含超过 50 个不同的单词，因此这些向量中 99.99% 的数值都会是 0， 并没有编码任何有用的信息。正是考虑到这一点，科学家们开始探索使用密集向量来表示文本。

Word2Vec
One of the most famous approaches to dense representation is word2vec, proposed by Google in 2013 in the paper “Efficient Estimation of Word Representations in Vector Space” by Mikolov et al.

Word2Vec
在众多密集表示方法中，最著名的方法之一是 word2vec。它由 Google 在 2013 年提出，相关研究发表在 Mikolov 等人的论文《矢量空间中词表示的有效估计》中。

There are two different word2vec approaches mentioned in the paper: Continuous Bag of Words (when we predict the word based on the surrounding words) and Skip-gram (the opposite task — when we predict context based on the word).

论文中提到了两种不同的 word2vec 方法：连续词袋模型（Continuous Bag of Words），它根据周围的词语来预测目标词；以及 Skip-gram 模型，它执行相反的任务，即根据给定的词语来预测其上下文。

Figure from the paper by Mikolov et al. 2013 | source
The high-level idea of dense vector representation is to train two models: encoder and decoder. For example, in the case of skip-gram, we might pass the word “christmas” to the encoder. Then, the encoder will produce a vector that we pass to the decoder expecting to get the words “merry”, “to”, and “you”.

图来自 Mikolov 等人 2013 年的论文 | 来源密集向量表示的核心思想是训练两个模型，即编码器和解码器。以 skip-gram 模型为例，我们可以把单词「christmas」输入到编码器中。然后，编码器会生成一个向量。我们将这个向量传递给解码器，期望解码器输出单词「merry」、「to」和「you」。

This model started to take into account the meaning of the words since it’s trained on the context of the words. However, it ignores morphology (information we can get from the word parts, for example, that “-less” means the lack of something). This drawback was addressed later by looking at subword skip-grams in GloVe.

这个模型之所以能够理解词义，是因为它在训练时学习了单词的上下文信息。但是，它忽略了词法结构 —— 也就是从单词的组成部分获取的信息，比如「-less」表示缺少某种东西。后来，通过在 GloVe 模型中引入子词 skip-gram 的方法，解决了这个缺陷。

Also, word2vec was capable of working only with words, but we would like to encode whole sentences. So, let’s move on to the next evolutional step with transformers.

另外，word2vec 只能分析单词，但我们希望对整个句子进行编码（encode）。所以，让我们继续探索，看看 Transformer 是如何在此基础上发展的。

Transformers and Sentence Embeddings
The next evolution was related to the transformers approach introduced in the “Attention Is All You Need” paper by Vaswani et al. Transformers were able to produce information-reach dense vectors and become the dominant technology for modern language models.

Transformer 和句子嵌入接下来的演变与 Vaswani 等人在论文「Attention Is All You Need」中提出的 Transformer 方法密切相关。Transformer 能够生成包含丰富信息的稠密向量，并逐渐成为现代语言模型的核心技术。

I won’t cover the details of the transformers’ architecture since it’s not so relevant to our topic and would take a lot of time. If you’re interested in learning more, there are a lot of materials about transformers, for example, “Transformers, Explained” or “The Illustrated Transformer”.

我不会详细介绍 Transformer 的架构，因为它和我们现在讨论的主题关系不大，而且会占用大量时间。如果您有兴趣深入了解，有很多关于 Transformer 的学习资料，例如《Transformers，Explained》或《The Illustrated Transformer》。

Transformers allow you to use the same “core” model and fine-tune it for different use cases without retraining the core model (which takes a lot of time and is quite costly). It led to the rise of pre-trained models. One of the first popular models was BERT (Bidirectional Encoder Representations from Transformers) by Google AI.

Transformer 技术使得我们可以使用同一个「核心」模型，并针对不同的应用场景进行微调，而无需耗费大量时间和成本重新训练这个核心模型。这促使了预训练模型的兴起。其中，由 Google AI 开发的 BERT（Bidirectional Encoder Representations from Transformers）是最早一批广受欢迎的模型之一。

Internally, BERT still operates on a token level similar to word2vec, but we still want to get sentence embeddings. So, the naive approach could be to take an average of all tokens’ vectors. Unfortunately, this approach doesn’t show good performance.

在内部，BERT 仍然像 word2vec 一样以 Token 为单位进行操作，但我们仍然希望获得句子嵌入。因此，一个简单的方法可能是取所有 Token 向量的平均值。不幸的是，这种方法的效果并不好。

This problem was solved in 2019 when Sentence-BERT was released. It outperformed all previous approaches to semantic textual similarity tasks and allowed the calculation of sentence embeddings.

这个问题随着 2019 年 Sentence-BERT 的发布而被解决。它在语义文本相似性任务中性能优于以往的所有方法，并使得计算句子嵌入成为可能。

It’s a huge topic so we won’t be able to cover it all in this article. So, if you’re really interested, you can learn more about the sentence embeddings in this article.

这是一个非常庞大的主题，我们无法在本文中面面俱到。如果您对此有浓厚的兴趣，可以参考这篇文章，深入了解句子嵌入（sentence embeddings）。

We’ve briefly covered the evolution of embeddings and got a high-level understanding of the theory. Now, it’s time to move on to practice and lear how to calculate embeddings using OpenAI tools.

我们已经简单了解了嵌入（embeddings）的发展历程，并且对相关理论有了初步的认识。现在，让我们开始实践，学习如何使用 OpenAI 的工具来计算嵌入。

Calculating embeddings
In this article, we will be using OpenAI embeddings. We will try a new model text-embedding-3-small that was released just recently. The new model shows better performance compared to text-embedding-ada-002:

计算向量表示本文中，我们将使用 OpenAI 提供的嵌入（embeddings）技术。具体来说，我们会尝试一个名为 text-embedding-3-small 的新模型，它刚刚发布不久。这个新模型相较于之前的 text-embedding-ada-002 模型，展现出了更优秀的性能。

The average score on a widely used multi-language retrieval (MIRACL) benchmark has risen from 31.4% to 44.0%.
The average performance on a frequently used benchmark for English tasks (MTEB) has also improved, rising from 61.0% to 62.3%.
OpenAI also released a new larger model text-embedding-3-large. Now, it’s their best performing embedding model.

在广泛使用的 MIRACL 多语言检索基准测试中，平均得分已从 31.4% 上升至 44.0%。
在常用的 MTEB 英语任务基准测试中的平均性能也有所提高，从 61.0% 上升至 62.3%。
OpenAI 还发布了一个新的更大的模型 text-embedding-3-large（text-embedding-3-large）。目前，这是他们性能最好的嵌入模型。

As a data source, we will be working with a small sample of Stack Exchange Data Dump — an anonymised dump of all user-contributed content on the Stack Exchange network. I’ve selected a bunch of topics that look interesting to me and sample 100 questions from each of them. Topics range from Generative AI to coffee or bicycles so that we will see quite a wide variety of topics.

作为数据来源，我们将使用 Stack Exchange 数据集的一个小样本 —— 它是 Stack Exchange 网络上所有用户贡献内容的匿名数据导出。我选择了若干个我感兴趣的主题，并从每个主题中选取了 100 个问题。主题涵盖了从生成式 AI（Generative AI）到咖啡、自行车等，因此我们将看到非常广泛的主题。

First, we need to calculate embeddings for all our Stack Exchange questions. It’s worth doing it once and storing results locally (in a file or vector storage). We can generate embeddings using the OpenAI Python package.

首先，我们需要计算所有 Stack Exchange 上的问题的嵌入（embeddings）。这样做是值得的，并且将结果存储在本地（存储在本地文件或向量数据库中）。我们可以使用 OpenAI 提供的 Python 工具包生成嵌入。

As a result, we got a 1536-dimension vector of float numbers. We can now repeat it for all our data and start analysing the values.

The primary question you might have is how close the sentences are to each other by meaning. To uncover answers, let’s discuss the concept of distance between vectors.

最终，我们获得了一个 1536 维的浮点数向量。现在，我们可以对所有数据重复这个步骤，并开始分析这些数值。

你可能首先会问，这些句子在意思上有多相似？为了解答这个问题，我们来探讨一下向量之间距离的概念。

Distance between vectors
Embeddings are actually vectors. So, if we want to understand how close two sentences are to each other, we can calculate the distance between vectors. A smaller distance would be equivalent to a closer semantic meaning.

向量之间的距离嵌入（Embeddings）本质上是向量。因此，为了解两个句子在语义上的相似程度，我们可以计算它们对应向量之间的距离。距离越小，则表示语义越接近。

Different metrics can be used to measure the distance between two vectors:

Euclidean distance (L2),
Manhattant distance (L1),
Dot product,
Cosine distance.
Let’s discuss them. As a simple example, we will be using two 2D vectors.

可以使用不同的方法来衡量两个向量之间的距离：

欧几里得距离（Euclidean distance）(L2），
曼哈顿距离（Manhattan distance）(L1），
点积（Dot product），
余弦距离（Cosine distance）。
下面我们来讨论一下这些方法。为了方便理解，我们先用两个二维向量作为例子。

vector1 = [1, 4]
vector2 = [2, 2]

Euclidean distance (L2)
The most standard way to define distance between two points (or vectors) is Euclidean distance or L2 norm. This metric is the most commonly used in day-to-day life, for example, when we are talking about the distance between 2 towns.

vector1 = [1，4]
vector2 = [2，2]

欧几里得距离（L2 范数)
定义两个点（或向量）之间距离最常用的方法是欧几里得距离或 L2 范数。这个度量是日常生活中最常用的，例如，当我们说两个城镇之间的距离时。

Here’s a visual representation and formula for L2 distance.

We can calculate this metric using vanilla Python or leveraging the numpy function.

这里展示了 L2 距离的视觉呈现和计算公式。

我们可以使用原生的 Python 代码或者借助 numpy 库中的函数来计算 L2 距离。

Manhattant distance (L1)
The other commonly used distance is the L1 norm or Manhattan distance. This distance was called after the island of Manhattan (New York). This island has a grid layout of streets, and the shortest routes between two points in Manhattan will be L1 distance since you need to follow the grid.

曼哈顿距离（L1)
另一个常用的距离是 L1 范数，也称为曼哈顿距离。之所以这样命名，是因为它与纽约的曼哈顿岛有关。曼哈顿岛的街道呈网格状分布，因此，岛上两点之间的最短路径就是 L1 距离，因为你必须沿着网格行走。


We can also implement it from scratch or use the numpy function.

Dot product
Another way to look at the distance between vectors is to calculate a dot or scalar product. Here’s a formula and we can easily implement it.

我们也可以从零开始实现它，或者使用 numpy 函数。

点积另一种衡量向量之间距离的方法是计算点积（也称为标量积）。下面是一个公式，我们可以很容易地实现它。

This metric is a bit tricky to interpret. On the one hand, it shows you whether vectors are pointing in one direction. On the other hand, the results highly depend on the magnitudes of the vectors. For example, let’s calculate the dot products between two pairs of vectors:

这个指标的解读有些复杂。一方面，它显示向量是否大致指向同一方向。另一方面，结果很大程度上受到向量长度的影响。例如，我们来计算一下两组向量的点积：

(1, 1) vs (1, 1)
(1, 1) vs (10, 10).

In both cases, vectors are collinear, but the dot product is ten times bigger in the second case: 2 vs 20.

(1，1）与（1，1)
(1，1）与（10，10）。

在这两种情况下，向量都是共线的，但第二种情况的向量点积是第一种情况的十倍：分别为 2 和 20。

Cosine similarity
Quite often, cosine similarity is used. Cosine similarity is a dot product normalised by vectors’ magnitudes (or normes).

We can either calculate everything ourselves (as previously) or use the function from sklearn.

余弦相似度通常会使用余弦相似度。余弦相似度是指向量点积除以向量的模长（或范数）后得到的值。

我们可以自己计算所有内容（如前所述），或者使用 sklearn 库中的函数。

The function cosine_similarity expects 2D arrays. That’s why we need to reshape the numpy arrays.

Let’s talk a bit about the physical meaning of this metric. Cosine similarity is equal to the cosine between two vectors. The closer the vectors are, the higher the metric value.

`cosine_similarity` 函数需要输入二维数组， 这就是为什么我们需要对 numpy 数组进行变形（reshape）。

现在我们来聊聊这个指标的物理含义。余弦相似度实际上是计算两个向量之间夹角的余弦值。向量之间的方向越接近，这个指标的数值就越高。

We can even calculate the exact angle between our vectors in degrees. We get results around 30 degrees, and it looks pretty reasonable.

What metric to use?
We’ve discussed different ways to calculate the distance between two vectors, and you might start thinking about which one to use.

我们甚至可以计算出向量之间精确的角度，单位是度。我们计算得到的角度在 30 度左右，看起来相当合理。

使用什么度量标准？
我们已经讨论了计算两个向量之间距离的不同方法，你可能开始考虑用哪种方法。

You can use any distance to compare the embeddings you have. For example, I calculated the average distances between the different clusters. Both L2 distance and cosine similarity show us similar pictures:

你可以使用任何距离度量来比较你得到的嵌入（embeddings）。例如，我计算了不同聚类之间的平均距离。L2 距离和余弦相似度都呈现出相似的结果：

Objects within a cluster are closer to each other than to other clusters. It’s a bit tricky to interpret our results since for L2 distance, closer means lower distance, while for cosine similarity — the metric is higher for closer objects. Don’t get confused.
We can spot that some topics are really close to each other, for example, “politics” and “economics” or “ai” and “datascience”.

在同一个集群内的物体，彼此之间的距离比与其他集群的物体更近。在解读结果时需要注意，对于 L2 距离而言，距离越近数值越小；而对于余弦相似度来说，距离越近数值则越高，请注意区分。
我们能观察到，有些主题之间的联系非常紧密，例如「政治」和「经济」，或者「AI（Artificial Intelligence）」和「数据科学（Data Science）」。

However, for NLP tasks, the best practice is usually to use cosine similarity. Some reasons behind it:

Cosine similarity is between -1 and 1, while L1 and L2 are unbounded, so it’s easier to interpret.
From the practical perspective, it’s more effective to calculate dot products than square roots for Euclidean distance.
Cosine similarity is less affected by the curse of dimensionality (we will talk about it in a second).
OpenAI embeddings are already normed, so dot product and cosine similarity are equal in this case.

然而，对于自然语言处理任务（NLP），最佳实践通常是使用余弦相似度。原因如下：

余弦相似度介于 -1 和 1 之间，而 L1 和 L2 的取值范围是无界的，因此更方便理解。
在实际应用中，计算点积比计算欧几里得距离的平方根更加高效。
余弦相似度受维度灾难的影响更小（我们将在稍后讨论）。
OpenAI 的嵌入向量已经做了归一化处理，因此这种情况下，点积和余弦相似度的结果是相同的。

You might spot in the results above that the difference between inter- and intra-cluster distances is not so big. The root cause is the high dimensionality of our vectors. This effect is called “the curse of dimensionality”: the higher the dimension, the narrower the distribution of distances between vectors. You can learn more details about it in this article.

您或许会注意到，在上面的结果中，簇间距离和簇内距离的区分度并不高。这主要是因为我们的向量维度很高。这种现象被称为「维度诅咒（the curse of dimensionality）」：维度越高，向量之间的距离就越趋于集中。您可以通过这篇文章了解更多细节。

I would like to briefly show you how it works so that you get some intuition. I calculated a distribution of OpenAI embedding values and generated sets of 300 vectors with different dimensionalities. Then, I calculated the distances between all the vectors and draw a histogram. You can easily see that the increase in vector dimensionality makes the distribution narrower.

我想简单地向您展示一下它的工作原理，让您对此有个直观的了解。我统计了 OpenAI 嵌入值的分布情况，并生成了 300 个不同维度的向量集合。然后，我计算了所有向量之间的距离，并绘制了直方图。可以明显看出，随着向量维度的增加，分布变得更窄。

We’ve learned how to measure the similarities between the embeddings. With that we’ve finished with a theoretical part and moving to more practical part (visualisations and practical applications). Let’s start with visualisations since it’s always better to see your data first.

我们已经了解了如何衡量嵌入向量之间的相似度。至此，我们完成了理论部分的学习，接下来将进入更具实践性的环节，包括可视化和实际应用。让我们先从可视化开始，因为通常情况下，先直观地观察数据会更有帮助。

Visualising embeddings
The best way to understand the data is to visualise it. Unfortunately, embeddings have 1536 dimensions, so it’s pretty challenging to look at the data. However, there’s a way: we could use dimensionality reduction techniques to project vectors in two-dimensional space.

嵌入的可视化要理解数据，最好的方法莫过于将其可视化呈现出来。不过，嵌入向量通常高达 1536 维，直接查看这些数据几乎是不可能的。但是，我们有办法解决这个问题： 可以利用降维技术，将这些高维向量投影到二维空间中进行观察。

PCA
The most basic dimensionality reduction technique is PCA (Principal Component Analysis). Let’s try to use it.

First, we need to convert our embeddings into a 2D numpy array to pass it to sklearn.

PCA
最基本的降维技术是 PCA（Principal Component Analysis）。让我们尝试应用此方法。

首先，我们需要将我们的嵌入向量转换为 2D numpy 数组，以便将其传递给 sklearn（一个常用的机器学习库）。

Then, we need to initialise a PCA model with n_components = 2 (because we want to create a 2D visualisation), train the model on the whole data and predict new values.

然后，我们需要创建一个 PCA 模型，并设置 n_components = 2（因为我们想要创建一个 2D 可视化），使用全部数据训练模型并预测新的数据点。

As a result, we got a matrix with just two features for each question, so we could easily visualise it on a scatter plot.

We can see that questions from each topic are pretty close to each other, which is good. However, all the clusters are mixed, so there’s room for improvement.

最终，我们得到了一个矩阵，其中每个问题仅用两个特征表示，这使得我们能够轻松地在散点图上将其可视化。

我们可以看到，同一主题的问题彼此非常接近，这是一个好现象。但是，所有主题的分布都混杂在一起，这表明还有改进的余地。

t-SNE
PCA is a linear algorithm, while most of the relations are non-linear in real life. So, we may not be able to separate the clusters because of non-linearity. Let’s try to use a non-linear algorithm t-SNE and see whether it will be able to show better results.

t-SNE
主成分分析（PCA）是一种线性算法，然而在现实世界中，大部分关系都是非线性的。因此，受到非线性的影响，我们可能无法有效地分离数据中的各个集群。现在，让我们尝试使用一种非线性算法，即 t-SNE，来看看它是否能呈现出更好的聚类效果。

The code is almost identical. I just used the t-SNE model instead of PCA.

The t-SNE result looks way better. Most of the clusters are separated except “genai”, “datascience” and “ai”. However, it’s pretty expected — I doubt I could separate these topics myself.

代码几乎完全一样，我只是将 PCA 换成了 t-SNE 模型。

t-SNE 的结果看起来明显更好。除了「genai」、「datascience」和「ai」这几个类别之外，大部分类别都分开了。不过，这也在意料之中 —— 我估计自己也很难区分这些主题。


Looking at this visualisation, we see that embeddings are pretty good at encoding semantic meaning.

Also, you can make a projection to three-dimensional space and visualise it. I’m not sure whether it would be practical, but it can be insightful and engaging to play with the data in 3D.

观察这个可视化结果，我们可以发现， 嵌入（embeddings）在编码语义信息方面表现非常出色。

此外，还可以将数据投影到三维空间并进行可视化。我并不确定这种做法是否实用，但在三维空间中探索数据可能会带来新的见解，并让人更感兴趣。

Barcodes
The way to understand the embeddings is to visualise a couple of them as bar codes and see the correlations. I picked three examples of embeddings: two are closest to each other, and the other is the farthest example in our dataset.

条形码要理解嵌入（embeddings），一种方法是将其中几个可视化为条形码，并观察它们之间的相关性。我选择了三个嵌入作为示例：其中两个彼此最为接近，另一个则是在我们的数据集中距离最远的。

It’s not easy to see whether vectors are close to each other in our case because of high dimensionality. However, I still like this visualisation. It might be helpful in some cases, so I am sharing this idea with you.

由于高维度的存在，我们很难直观地判断向量之间是否彼此接近。不过，我依然很喜欢这种可视化的方式。在某些情况下，它可能会有所帮助，因此我在这里分享这个想法。

We’ve learned how to visualise embeddings and have no doubts left about their ability to grasp the meaning of the text. Now, it’s time to move on to the most interesting and fascinating part and discuss how you can leverage embeddings in practice.

我们已经了解了如何将嵌入可视化，并且确信它们能够把握文本的含义。现在，我们将进入最激动人心和引人入胜的部分，探讨如何在实际应用中利用嵌入。

Practical applications
Of course, embeddings’ primary goal is not to encode texts as vectors of numbers or visualise them just for the sake of it. We can benefit a lot from our ability to capture the texts’ meanings. Let’s go through a bunch of more practical examples.

实际应用当然，嵌入的主要目标不是为了将文本编码为数字向量或者仅仅为了可视化而进行可视化。我们能够捕捉文本的含义，并从中获得很多好处。下面来看一些更实际的例子。

Clustering
Let’s start with clustering. Clustering is an unsupervised learning technique that allows you to split your data into groups without any initial labels. Clustering can help you understand the internal structural patterns in your data.

聚类让我们从聚类开始。聚类是一种无监督学习技术，它可以让你在没有任何初始标签的情况下，将数据分成不同的组。聚类可以帮助你理解数据内部的结构性规律。

We will use one of the most basic clustering algorithms — K-means. For the K-means algorithm, we need to specify the number of clusters. We can define the optimal number of clusters using silhouette scores.

我们将使用最基本的聚类算法之一 ——K - 均值（K-means）算法。对于 K - 均值算法，我们需要指定簇的数量。我们可以使用轮廓系数来定义最合适的簇数量。

Let’s try k (number of clusters) between 2 and 50. For each k, we will train a model and calculate silhouette scores. The higher silhouette score — the better clustering we got.

让我们尝试将聚类数量 k 设置在 2 到 50 之间。对于每个 k 值，我们将训练一个模型并计算轮廓系数。轮廓系数越高，聚类效果越好。

In our case, the silhouette score reaches a maximum when k = 11. So, let’s use this number of clusters for our final model.

Let’s visualise the clusters using t-SNE for dimensionality reduction as we already did before.

在我们的例子中，当 k = 11 时，轮廓系数达到最大。因此，我们选择使用 11 个簇来构建最终模型。

为了可视化这些簇，我们像之前一样使用 t-SNE 进行降维。

Visually, we can see that the algorithm was able to define clusters quite well — they are separated pretty well.


We have factual topic labels, so we can even assess how good clusterisation is. Let’s look at the topics’ mixture for each cluster.

从视觉上看，我们可以发现该算法能够很好地识别出不同的聚类，并且这些聚类之间有明显的区分。

因为我们有实际的主题标签，所以可以评估聚类效果的好坏。接下来，让我们分析一下每个聚类中包含的主题分布情况。

In most cases, clusterisation worked perfectly. For example, cluster 5 contains almost only questions about bicycles, while cluster 6 is about coffee. However, it wasn’t able to distinguish close topics:

在大多数情况下，聚类分析的效果都很好。例如，第 5 类几乎只包含关于自行车的问题，而第 6 类则关于咖啡。但是，它无法区分相近的主题：

“ai”, “genai” and “datascience” are all in one cluster,
the same store with “economics” and “politics”.
We used only embeddings as the features in this example, but if you have any additional information (for example, age, gender or country of the user who asked the question), you can include it in the model, too.

「人工智能（AI）」，「生成式人工智能（GenAI）」和「数据科学（Data Science）」都在一个集群中，与「经济学」和「政治学」被归为一类。在这个例子中，我们只使用了嵌入（embeddings）作为特征，但是如果你有任何额外的信息（例如，提问用户的年龄、性别和国家 / 地区），也可以将这些信息加入模型中。

Classification
We can use embeddings for classification or regression tasks. For example, you can do it to predict customer reviews’ sentiment (classification) or NPS score (regression).

分类我们可以使用嵌入（embeddings）技术来进行分类或回归任务。例如，可以使用嵌入技术来预测客户评论的情绪（分类），或者预测 NPS 分数（回归）。

Since classification and regression are supervised learning, you will need to have labels. Luckily, we know the topics for our questions and can fit a model to predict them.

由于分类和回归是监督学习，你需要有标签。幸运的是，我们知道我们问题的主题（Topic），并且可以训练一个模型来预测它们。

I will use a Random Forest Classifier. If you need a quick refresher about Random Forests, you can find it here. To assess the classification model’s performance correctly, we will split our dataset into train and test sets (80% vs 20%). Then, we can train our model on a train set and measure the quality on a test set (questions that the model hasn’t seen before).

我将使用随机森林分类器（Random Forest Classifier）。如果您需要快速回顾随机森林，可以在这里找到相关资料。为了正确评估分类模型的性能表现，我们将数据集划分为训练集和测试集（80% vs 20%）。之后，我们可以在训练集上训练模型，并在测试集上评估其性能（模型之前未接触过的数据）。

To estimate the model’s performance, let’s calculate a confusion matrix. In an ideal situation, all non-diagonal elements should be 0.

We can see similar results to clusterisation: some topics are easy to classify, and accuracy is 100%, for example, “bicycles” or “travel”, while some others are difficult to distinguish (especially “ai”).

为了评估模型的表现，我们可以计算一个混淆矩阵。在最理想的情况下，混淆矩阵中除了对角线上的元素外，其他元素都应该为 0。

我们可以看到与聚类结果相似的情况：一些主题很容易分类，准确率达到 100%，例如「自行车」或「旅行」，而另一些则难以区分，特别是「ai（AI）」。

However, we achieved 91.8% overall accuracy, which is quite good.

Finding anomalies
We can also use embedding to find anomalies in our data. For example, at the t-SNE graph, we saw that some questions are pretty far from their clusters, for instance, for the “travel” topic. Let’s look at this theme and try to find anomalies. We will use the Isolation Forest algorithm for it.

不过，我们取得了 91.8% 的整体准确率，表现相当出色。

异常检测我们还可以利用嵌入（embedding）技术来检测数据中的异常情况。例如，在 t-SNE 图中，我们观察到某些问题，特别是关于「旅行」主题的问题，明显偏离了它们所属的聚类。接下来，我们将聚焦于这个主题，尝试找出其中的异常之处。为此，我们将采用隔离森林（Isolation Forest）算法。

So, here we are. We’ve found the most uncommon comment for the travel topic (source).

Is it safe to drink the water from the fountains found all over 
the older parts of Rome?

好了，现在我们来聊聊。我们找到了一个关于旅行话题的非常少见的提问（来源）。

在罗马老城区随处可见的喷泉里，水可以直接喝吗？

When I visited Rome and walked around the older sections, I saw many 
different types of fountains that were constantly running with water. 
Some went into the ground, some collected in basins, etc.

当我访问罗马并在较老的区域漫步时，我看到了许多不同类型的喷泉，它们的水流源源不断。有些水流向地面，有些则汇集在水池中等等。

Is the water coming out of these fountains potable? Safe for visitors 
to drink from? Any etiquette regarding their use that a visitor 
should know about?
Since it talks about water, the embedding of this comment is close to the coffee topic where people also discuss water to pour coffee. So, the embedding representation is quite reasonable.

这些喷泉的水能喝吗？ 游客可以放心饮用吗？ 使用这些喷泉有什么需要注意的吗？
由于这段话谈论的是水，它与人们讨论冲泡咖啡用水的咖啡话题在语义上比较接近。因此，这种嵌入表示是合理的。

We could find it on our t-SNE visualisation and see that it’s actually close to the coffee cluster.

RAG — Retrieval Augmented Generation
With the recently increased popularity of LLMs, embeddings have been broadly used in RAG use cases.

在 t-SNE 可视化图中，我们可以发现它，并且它实际上与咖啡集群邻近。

RAG — 检索增强生成（Retrieval Augmented Generation)
随着近期大语言模型（LLM）的普及，嵌入技术已被广泛应用于 RAG 用例中。

We need Retrieval Augmented Generation when we have a lot of documents (for example, all the questions from Stack Exchange), and we can’t pass them all to an LLM because

当有大量文档（例如，来自 Stack Exchange 的所有问题）时，我们需要使用检索增强式生成（Retrieval Augmented Generation）技术。这是因为我们无法将所有文档都传递给大语言模型，因为

LLMs have limits on the context size (right now, it’s 128K for GPT-4 Turbo).
We pay for tokens, so it’s more expensive to pass all the information all the time.
LLMs show worse performance with a bigger context. You can check Needle In A Haystack — Pressure Testing LLMs to learn more details.
To be able to work with an extensive knowledge base, we can leverage the RAG approach:

大语言模型（LLM）的上下文窗口大小是有限制的（目前，GPT-4 Turbo 的限制是 128K Token）。
由于我们需要为 Token 付费，因此每次都传递所有信息会显著增加成本。
此外，大语言模型在处理较长上下文时，性能也会下降。您可以参考论文《Needle In A Haystack — Pressure Testing LLMs》以了解更多细节。
为了能够利用庞大的知识库，我们可以采用检索增强生成（Retrieval-Augmented Generation，RAG）方法：

Compute embeddings for all the documents and store them in vector storage.
When we get a user request, we can calculate its embedding and retrieve relevant documents from the storage for this request.
Pass only relevant documents to LLM to get a final answer.
To learn more about RAG, don’t hesitate to read my article with much more details here.

计算所有文档的嵌入（embeddings），并将其存储在向量数据库中。这里的「嵌入」可以理解为将文档转换成计算机可以理解的向量形式。
当收到用户请求时，我们同样会计算该请求的嵌入，并从向量数据库中检索出与该请求最相关的文档。
接下来，仅将这些相关的文档提供给大语言模型（LLM），以生成最终答案。
如果您想深入了解 RAG 技术，欢迎阅读我的文章，其中有更详细的介绍。

Summary
In this article, we’ve discussed text embeddings in much detail. Hopefully, now you have a complete and deep understanding of this topic. Here’s a quick recap of our journey:

总结在本文中，我们深入探讨了文本嵌入（text embeddings）的相关内容。希望现在大家对这一主题有了全面而深入的理解。下面是对我们所讲内容的快速回顾：

Firstly, we went through the evolution of approaches to work with texts.
Then, we discussed how to understand whether texts have similar meanings to each other.
After that, we saw different approaches to text embedding visualisation.
Finally, we tried to use embeddings as features in different practical tasks such as clustering, classification, anomaly detection and RAG.
Thank you a lot for reading this article. If you have any follow-up questions or comments, please leave them in the comments section.


首先，我们梳理了文本处理方法的发展历程。
然后，我们探讨了如何判断文本之间的语义相似性。
之后，我们了解了多种文本嵌入可视化的方法。
最后，我们尝试将文本嵌入作为特征，应用于各种实际任务，例如聚类、分类、异常检测和 RAG。
感谢您阅读本文。如果您有任何后续问题或意见，请将其留在评论区。




### Reference

In this article, I used a dataset from Stack Exchange Data Dump, which is available under the Creative Commons license.

This article was inspired by the following courses:

“Understanding and Applying Text Embeddings” by DeepLearning.AI in collaboration with Google Cloud,

“Vector Databases: From Embeddings to Applications” by DeepLearning.AI in collaboration with Weaviate.

## 原文

Text Embeddings: Comprehensive Guide
Evolution, visualisation, and applications of text embeddings
Mariya Mansurova

Published in Towards Data Science

Feb 13, 2024

As human beings, we can read and understand texts (at least some of them). Computers in opposite “think in numbers”, so they can’t automatically grasp the meaning of words and sentences. If we want computers to understand the natural language, we need to convert this information into the format that computers can work with — vectors of numbers.

People learned how to convert texts into machine-understandable format many years ago (one of the first versions was ASCII). Such an approach helps render and transfer texts but doesn’t encode the meaning of the words. At that time, the standard search technique was a keyword search when you were just looking for all the documents that contained specific words or N-grams.

Then, after decades, embeddings have emerged. We can calculate embeddings for words, sentences, and even images. Embeddings are also vectors of numbers, but they can capture the meaning. So, you can use them to do a semantic search and even work with documents in different languages.

In this article, I would like to dive deeper into the embedding topic and discuss all the details:

what preceded the embeddings and how they evolved,
how to calculate embeddings using OpenAI tools,
how to define whether sentences are close to each other,
how to visualise embeddings,
the most exciting part is how you could use embeddings in practice.
Let’s move on and learn about the evolution of embeddings.

Evolution of Embeddings
We will start our journey with a brief tour into the history of text representations.

Bag of Words
The most basic approach to converting texts into vectors is a bag of words. Let’s look at one of the famous quotes of Richard P. Feynman“We are lucky to live in an age in which we are still making discoveries”. We will use it to illustrate a bag of words approach.

The first step to get a bag of words vector is to split the text into words (tokens) and then reduce words to their base forms. For example, “running” will transform into “run”. This process is called stemming. We can use the NLTK Python package for it.

from nltk.stem import SnowballStemmer
from nltk.tokenize import word_tokenize

text = 'We are lucky to live in an age in which we are still making discoveries'

\# tokenization - splitting text into words
words = word_tokenize(text)
print(words)
\# ['We', 'are', 'lucky', 'to', 'live', 'in', 'an', 'age', 'in', 'which',
\#  'we', 'are', 'still', 'making', 'discoveries']

stemmer = SnowballStemmer(language = "english")
stemmed_words = list(map(lambda x: stemmer.stem(x), words))
print(stemmed_words)
\# ['we', 'are', 'lucki', 'to', 'live', 'in', 'an', 'age', 'in', 'which', 
\#  'we', 'are', 'still', 'make', 'discoveri']
Now, we have a list of base forms of all our words. The next step is to calculate their frequencies to create a vector.

import collections
bag_of_words = collections.Counter(stemmed_words)
print(bag_of_words)
\# {'we': 2, 'are': 2, 'in': 2, 'lucki': 1, 'to': 1, 'live': 1, 
\# 'an': 1, 'age': 1, 'which': 1, 'still': 1, 'make': 1, 'discoveri': 1}
Actually, if we wanted to convert our text into a vector, we would have to take into account not only the words we have in the text but the whole vocabulary. Let’s assume we also have “i”, “you” and ”study” in our vocabulary and let’s create a vector from Feynman’s quote.


Graph by author
This approach is quite basic, and it doesn’t take into account the semantic meaning of the words, so the sentences “the girl is studying data science” and “the young woman is learning AI and ML” won’t be close to each other.

TF-IDF
A slightly improved version of the bag of the words approach is TF-IDF (Term Frequency — Inverse Document Frequency). It’s the multiplication of two metrics.


Term Frequency shows the frequency of the word in the document. The most common way to calculate it is to divide the raw count of the term in this document (like in the bag of words) by the total number of terms (words) in the document. However, there are many other approaches like just raw count, boolean “frequencies”, and different approaches to normalisation. You can learn more about different approaches on Wikipedia.

Inverse Document Frequency denotes how much information the word provides. For example, the words “a” or “that” don’t give you any additional information about the document’s topic. In contrast, words like “ChatGPT” or “bioinformatics” can help you define the domain (but not for this sentence). It’s calculated as the logarithm of the ratio of the total number of documents to those containing the word. The closer IDF is to 0 — the more common the word is and the less information it provides.

So, in the end, we will get vectors where common words (like “I” or “you”) will have low weights, while rare words that occur in the document multiple times will have higher weights. This strategy will give a bit better results, but it still can’t capture semantic meaning.

The other challenge with this approach is that it produces pretty sparse vectors. The length of the vectors is equal to the corpus size. There are about 470K unique words in English (source), so we will have huge vectors. Since the sentence won’t have more than 50 unique words, 99.99% of the values in vectors will be 0, not encoding any info. Looking at this, scientists started to think about dense vector representation.

Word2Vec
One of the most famous approaches to dense representation is word2vec, proposed by Google in 2013 in the paper “Efficient Estimation of Word Representations in Vector Space” by Mikolov et al.

There are two different word2vec approaches mentioned in the paper: Continuous Bag of Words (when we predict the word based on the surrounding words) and Skip-gram (the opposite task — when we predict context based on the word).


Figure from the paper by Mikolov et al. 2013 | source
The high-level idea of dense vector representation is to train two models: encoder and decoder. For example, in the case of skip-gram, we might pass the word “christmas” to the encoder. Then, the encoder will produce a vector that we pass to the decoder expecting to get the words “merry”, “to”, and “you”.


Scheme by author
This model started to take into account the meaning of the words since it’s trained on the context of the words. However, it ignores morphology (information we can get from the word parts, for example, that “-less” means the lack of something). This drawback was addressed later by looking at subword skip-grams in GloVe.

Also, word2vec was capable of working only with words, but we would like to encode whole sentences. So, let’s move on to the next evolutional step with transformers.

Transformers and Sentence Embeddings
The next evolution was related to the transformers approach introduced in the “Attention Is All You Need” paper by Vaswani et al. Transformers were able to produce information-reach dense vectors and become the dominant technology for modern language models.

I won’t cover the details of the transformers’ architecture since it’s not so relevant to our topic and would take a lot of time. If you’re interested in learning more, there are a lot of materials about transformers, for example, “Transformers, Explained” or “The Illustrated Transformer”.

Transformers allow you to use the same “core” model and fine-tune it for different use cases without retraining the core model (which takes a lot of time and is quite costly). It led to the rise of pre-trained models. One of the first popular models was BERT (Bidirectional Encoder Representations from Transformers) by Google AI.

Internally, BERT still operates on a token level similar to word2vec, but we still want to get sentence embeddings. So, the naive approach could be to take an average of all tokens’ vectors. Unfortunately, this approach doesn’t show good performance.

This problem was solved in 2019 when Sentence-BERT was released. It outperformed all previous approaches to semantic textual similarity tasks and allowed the calculation of sentence embeddings.

It’s a huge topic so we won’t be able to cover it all in this article. So, if you’re really interested, you can learn more about the sentence embeddings in this article.

We’ve briefly covered the evolution of embeddings and got a high-level understanding of the theory. Now, it’s time to move on to practice and lear how to calculate embeddings using OpenAI tools.

Calculating embeddings
In this article, we will be using OpenAI embeddings. We will try a new model text-embedding-3-small that was released just recently. The new model shows better performance compared to text-embedding-ada-002:

The average score on a widely used multi-language retrieval (MIRACL) benchmark has risen from 31.4% to 44.0%.
The average performance on a frequently used benchmark for English tasks (MTEB) has also improved, rising from 61.0% to 62.3%.
OpenAI also released a new larger model text-embedding-3-large. Now, it’s their best performing embedding model.

As a data source, we will be working with a small sample of Stack Exchange Data Dump — an anonymised dump of all user-contributed content on the Stack Exchange network. I’ve selected a bunch of topics that look interesting to me and sample 100 questions from each of them. Topics range from Generative AI to coffee or bicycles so that we will see quite a wide variety of topics.

First, we need to calculate embeddings for all our Stack Exchange questions. It’s worth doing it once and storing results locally (in a file or vector storage). We can generate embeddings using the OpenAI Python package.

from openai import OpenAI
client = OpenAI()

def get_embedding(text, model="text-embedding-3-small"):
   text = text.replace("\n", " ")
   return client.embeddings.create(input = [text], model=model)\
       .data[0].embedding

get_embedding("We are lucky to live in an age in which we are still making discoveries.")
As a result, we got a 1536-dimension vector of float numbers. We can now repeat it for all our data and start analysing the values.

The primary question you might have is how close the sentences are to each other by meaning. To uncover answers, let’s discuss the concept of distance between vectors.

Distance between vectors
Embeddings are actually vectors. So, if we want to understand how close two sentences are to each other, we can calculate the distance between vectors. A smaller distance would be equivalent to a closer semantic meaning.

Different metrics can be used to measure the distance between two vectors:

Euclidean distance (L2),
Manhattant distance (L1),
Dot product,
Cosine distance.
Let’s discuss them. As a simple example, we will be using two 2D vectors.

vector1 = [1, 4]
vector2 = [2, 2]
Euclidean distance (L2)
The most standard way to define distance between two points (or vectors) is Euclidean distance or L2 norm. This metric is the most commonly used in day-to-day life, for example, when we are talking about the distance between 2 towns.

Here’s a visual representation and formula for L2 distance.


Image by author
We can calculate this metric using vanilla Python or leveraging the numpy function.

import numpy as np

sum(list(map(lambda x, y: (x - y) ** 2, vector1, vector2))) ** 0.5
\# 2.2361

np.linalg.norm((np.array(vector1) - np.array(vector2)), ord = 2)
\# 2.2361
Manhattant distance (L1)
The other commonly used distance is the L1 norm or Manhattan distance. This distance was called after the island of Manhattan (New York). This island has a grid layout of streets, and the shortest routes between two points in Manhattan will be L1 distance since you need to follow the grid.


Image by author
We can also implement it from scratch or use the numpy function.

sum(list(map(lambda x, y: abs(x - y), vector1, vector2)))
\# 3

np.linalg.norm((np.array(vector1) - np.array(vector2)), ord = 1)
\# 3.0
Dot product
Another way to look at the distance between vectors is to calculate a dot or scalar product. Here’s a formula and we can easily implement it.


Image by author
sum(list(map(lambda x, y: x*y, vector1, vector2)))
\# 11

np.dot(vector1, vector2)
\# 11
This metric is a bit tricky to interpret. On the one hand, it shows you whether vectors are pointing in one direction. On the other hand, the results highly depend on the magnitudes of the vectors. For example, let’s calculate the dot products between two pairs of vectors:

(1, 1) vs (1, 1)
(1, 1) vs (10, 10).
In both cases, vectors are collinear, but the dot product is ten times bigger in the second case: 2 vs 20.

Cosine similarity
Quite often, cosine similarity is used. Cosine similarity is a dot product normalised by vectors’ magnitudes (or normes).


Image by author
We can either calculate everything ourselves (as previously) or use the function from sklearn.

dot_product = sum(list(map(lambda x, y: x*y, vector1, vector2)))
norm_vector1 = sum(list(map(lambda x: x ** 2, vector1))) ** 0.5
norm_vector2 = sum(list(map(lambda x: x ** 2, vector2))) ** 0.5

dot_product/norm_vector1/norm_vector2

\# 0.8575

from sklearn.metrics.pairwise import cosine_similarity

cosine_similarity(
  np.array(vector1).reshape(1, -1), 
  np.array(vector2).reshape(1, -1))[0][0]

\# 0.8575
The function cosine_similarity expects 2D arrays. That’s why we need to reshape the numpy arrays.

Let’s talk a bit about the physical meaning of this metric. Cosine similarity is equal to the cosine between two vectors. The closer the vectors are, the higher the metric value.


Image by author
We can even calculate the exact angle between our vectors in degrees. We get results around 30 degrees, and it looks pretty reasonable.

import math
math.degrees(math.acos(0.8575))

\# 30.96
What metric to use?
We’ve discussed different ways to calculate the distance between two vectors, and you might start thinking about which one to use.

You can use any distance to compare the embeddings you have. For example, I calculated the average distances between the different clusters. Both L2 distance and cosine similarity show us similar pictures:

Objects within a cluster are closer to each other than to other clusters. It’s a bit tricky to interpret our results since for L2 distance, closer means lower distance, while for cosine similarity — the metric is higher for closer objects. Don’t get confused.
We can spot that some topics are really close to each other, for example, “politics” and “economics” or “ai” and “datascience”.

Image by author

Image by author
However, for NLP tasks, the best practice is usually to use cosine similarity. Some reasons behind it:

Cosine similarity is between -1 and 1, while L1 and L2 are unbounded, so it’s easier to interpret.
From the practical perspective, it’s more effective to calculate dot products than square roots for Euclidean distance.
Cosine similarity is less affected by the curse of dimensionality (we will talk about it in a second).
OpenAI embeddings are already normed, so dot product and cosine similarity are equal in this case.

You might spot in the results above that the difference between inter- and intra-cluster distances is not so big. The root cause is the high dimensionality of our vectors. This effect is called “the curse of dimensionality”: the higher the dimension, the narrower the distribution of distances between vectors. You can learn more details about it in this article.

I would like to briefly show you how it works so that you get some intuition. I calculated a distribution of OpenAI embedding values and generated sets of 300 vectors with different dimensionalities. Then, I calculated the distances between all the vectors and draw a histogram. You can easily see that the increase in vector dimensionality makes the distribution narrower.


Graph by author
We’ve learned how to measure the similarities between the embeddings. With that we’ve finished with a theoretical part and moving to more practical part (visualisations and practical applications). Let’s start with visualisations since it’s always better to see your data first.

Visualising embeddings
The best way to understand the data is to visualise it. Unfortunately, embeddings have 1536 dimensions, so it’s pretty challenging to look at the data. However, there’s a way: we could use dimensionality reduction techniques to project vectors in two-dimensional space.

PCA
The most basic dimensionality reduction technique is PCA (Principal Component Analysis). Let’s try to use it.

First, we need to convert our embeddings into a 2D numpy array to pass it to sklearn.

import numpy as np
embeddings_array = np.array(df.embedding.values.tolist())
print(embeddings_array.shape)
\# (1400, 1536)
Then, we need to initialise a PCA model with n_components = 2 (because we want to create a 2D visualisation), train the model on the whole data and predict new values.

from sklearn.decomposition import PCA

pca_model = PCA(n_components = 2)
pca_model.fit(embeddings_array)

pca_embeddings_values = pca_model.transform(embeddings_array)
print(pca_embeddings_values.shape)
\# (1400, 2)

As a result, we got a matrix with just two features for each question, so we could easily visualise it on a scatter plot.

fig = px.scatter(
    x = pca_embeddings_values[:,0], 
    y = pca_embeddings_values[:,1],
    color = df.topic.values,
    hover_name = df.full_text.values,
    title = 'PCA embeddings', width = 800, height = 600,
    color_discrete_sequence = plotly.colors.qualitative.Alphabet_r
)

fig.update_layout(
    xaxis_title = 'first component', 
    yaxis_title = 'second component')
fig.show()

Image by author
We can see that questions from each topic are pretty close to each other, which is good. However, all the clusters are mixed, so there’s room for improvement.

t-SNE
PCA is a linear algorithm, while most of the relations are non-linear in real life. So, we may not be able to separate the clusters because of non-linearity. Let’s try to use a non-linear algorithm t-SNE and see whether it will be able to show better results.

The code is almost identical. I just used the t-SNE model instead of PCA.

from sklearn.manifold import TSNE
tsne_model = TSNE(n_components=2, random_state=42)
tsne_embeddings_values = tsne_model.fit_transform(embeddings_array)

fig = px.scatter(
    x = tsne_embeddings_values[:,0], 
    y = tsne_embeddings_values[:,1],
    color = df.topic.values,
    hover_name = df.full_text.values,
    title = 't-SNE embeddings', width = 800, height = 600,
    color_discrete_sequence = plotly.colors.qualitative.Alphabet_r
)

fig.update_layout(
    xaxis_title = 'first component', 
    yaxis_title = 'second component')
fig.show()
The t-SNE result looks way better. Most of the clusters are separated except “genai”, “datascience” and “ai”. However, it’s pretty expected — I doubt I could separate these topics myself.


Looking at this visualisation, we see that embeddings are pretty good at encoding semantic meaning.

Also, you can make a projection to three-dimensional space and visualise it. I’m not sure whether it would be practical, but it can be insightful and engaging to play with the data in 3D.

tsne_model_3d = TSNE(n_components=3, random_state=42)
tsne_3d_embeddings_values = tsne_model_3d.fit_transform(embeddings_array)

fig = px.scatter_3d(
    x = tsne_3d_embeddings_values[:,0], 
    y = tsne_3d_embeddings_values[:,1],
    z = tsne_3d_embeddings_values[:,2],
    color = df.topic.values,
    hover_name = df.full_text.values,
    title = 't-SNE embeddings', width = 800, height = 600,
    color_discrete_sequence = plotly.colors.qualitative.Alphabet_r,
    opacity = 0.7
)
fig.update_layout(xaxis_title = 'first component', yaxis_title = 'second component')
fig.show()

Barcodes
The way to understand the embeddings is to visualise a couple of them as bar codes and see the correlations. I picked three examples of embeddings: two are closest to each other, and the other is the farthest example in our dataset.

embedding1 = df.loc[1].embedding
embedding2 = df.loc[616].embedding
embedding3 = df.loc[749].embedding
import seaborn as sns
import matplotlib.pyplot as plt
embed_len_thr = 1536

sns.heatmap(np.array(embedding1[:embed_len_thr]).reshape(-1, embed_len_thr),
    cmap = "Greys", center = 0, square = False, 
    xticklabels = False, cbar = False)
plt.gcf().set_size_inches(15,1)
plt.yticks([0.5], labels = ['AI'])
plt.show()

sns.heatmap(np.array(embedding3[:embed_len_thr]).reshape(-1, embed_len_thr),
    cmap = "Greys", center = 0, square = False, 
    xticklabels = False, cbar = False)
plt.gcf().set_size_inches(15,1)
plt.yticks([0.5], labels = ['AI'])
plt.show()

sns.heatmap(np.array(embedding2[:embed_len_thr]).reshape(-1, embed_len_thr),
    cmap = "Greys", center = 0, square = False, 
    xticklabels = False, cbar = False)
plt.gcf().set_size_inches(15,1)
plt.yticks([0.5], labels = ['Bioinformatics'])
plt.show()

Graph by author
It’s not easy to see whether vectors are close to each other in our case because of high dimensionality. However, I still like this visualisation. It might be helpful in some cases, so I am sharing this idea with you.

We’ve learned how to visualise embeddings and have no doubts left about their ability to grasp the meaning of the text. Now, it’s time to move on to the most interesting and fascinating part and discuss how you can leverage embeddings in practice.

Practical applications
Of course, embeddings’ primary goal is not to encode texts as vectors of numbers or visualise them just for the sake of it. We can benefit a lot from our ability to capture the texts’ meanings. Let’s go through a bunch of more practical examples.

Clustering
Let’s start with clustering. Clustering is an unsupervised learning technique that allows you to split your data into groups without any initial labels. Clustering can help you understand the internal structural patterns in your data.

We will use one of the most basic clustering algorithms — K-means. For the K-means algorithm, we need to specify the number of clusters. We can define the optimal number of clusters using silhouette scores.

Let’s try k (number of clusters) between 2 and 50. For each k, we will train a model and calculate silhouette scores. The higher silhouette score — the better clustering we got.

from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score
import tqdm

silhouette_scores = []
for k in tqdm.tqdm(range(2, 51)):
    kmeans = KMeans(n_clusters=k, 
                    random_state=42, 
                    n_init = 'auto').fit(embeddings_array)
    kmeans_labels = kmeans.labels_
    silhouette_scores.append(
        {
            'k': k,
            'silhouette_score': silhouette_score(embeddings_array, 
                kmeans_labels, metric = 'cosine')
        }
    )

fig = px.line(pd.DataFrame(silhouette_scores).set_index('k'),
       title = '<b>Silhouette scores for K-means clustering</b>',
       labels = {'value': 'silhoutte score'}, 
       color_discrete_sequence = plotly.colors.qualitative.Alphabet)
fig.update_layout(showlegend = False)
In our case, the silhouette score reaches a maximum when k = 11. So, let’s use this number of clusters for our final model.


Graph by author
Let’s visualise the clusters using t-SNE for dimensionality reduction as we already did before.

tsne_model = TSNE(n_components=2, random_state=42)
tsne_embeddings_values = tsne_model.fit_transform(embeddings_array)

fig = px.scatter(
    x = tsne_embeddings_values[:,0], 
    y = tsne_embeddings_values[:,1],
    color = list(map(lambda x: 'cluster %s' % x, kmeans_labels)),
    hover_name = df.full_text.values,
    title = 't-SNE embeddings for clustering', width = 800, height = 600,
    color_discrete_sequence = plotly.colors.qualitative.Alphabet_r
)
fig.update_layout(
    xaxis_title = 'first component', 
    yaxis_title = 'second component')
fig.show()
Visually, we can see that the algorithm was able to define clusters quite well — they are separated pretty well.


We have factual topic labels, so we can even assess how good clusterisation is. Let’s look at the topics’ mixture for each cluster.

df['cluster'] = list(map(lambda x: 'cluster %s' % x, kmeans_labels))
cluster_stats_df = df.reset_index().pivot_table(
    index = 'cluster', values = 'id', 
    aggfunc = 'count', columns = 'topic').fillna(0).applymap(int)

cluster_stats_df = cluster_stats_df.apply(
  lambda x: 100*x/cluster_stats_df.sum(axis = 1))

fig = px.imshow(
    cluster_stats_df.values, 
    x = cluster_stats_df.columns,
    y = cluster_stats_df.index,
    text_auto = '.2f', aspect = "auto",
    labels=dict(x="cluster", y="fact topic", color="share, %"), 
    color_continuous_scale='pubugn',
    title = '<b>Share of topics in each cluster</b>', height = 550)

fig.show()

In most cases, clusterisation worked perfectly. For example, cluster 5 contains almost only questions about bicycles, while cluster 6 is about coffee. However, it wasn’t able to distinguish close topics:

“ai”, “genai” and “datascience” are all in one cluster,
the same store with “economics” and “politics”.
We used only embeddings as the features in this example, but if you have any additional information (for example, age, gender or country of the user who asked the question), you can include it in the model, too.

Classification
We can use embeddings for classification or regression tasks. For example, you can do it to predict customer reviews’ sentiment (classification) or NPS score (regression).

Since classification and regression are supervised learning, you will need to have labels. Luckily, we know the topics for our questions and can fit a model to predict them.

I will use a Random Forest Classifier. If you need a quick refresher about Random Forests, you can find it here. To assess the classification model’s performance correctly, we will split our dataset into train and test sets (80% vs 20%). Then, we can train our model on a train set and measure the quality on a test set (questions that the model hasn’t seen before).

from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
class_model = RandomForestClassifier(max_depth = 10)

\# defining features and target
X = embeddings_array
y = df.topic

\# splitting data into train and test sets
X_train, X_test, y_train, y_test = train_test_split(
    X, y, random_state = 42, test_size=0.2, stratify=y
)

\# fit & predict 
class_model.fit(X_train, y_train)
y_pred = class_model.predict(X_test)
To estimate the model’s performance, let’s calculate a confusion matrix. In an ideal situation, all non-diagonal elements should be 0.

from sklearn.metrics import confusion_matrix
cm = confusion_matrix(y_test, y_pred)

fig = px.imshow(
  cm, x = class_model.classes_,
  y = class_model.classes_, text_auto='d', 
  aspect="auto", 
  labels=dict(
      x="predicted label", y="true label", 
      color="cases"), 
  color_continuous_scale='pubugn',
  title = '<b>Confusion matrix</b>', height = 550)

fig.show()

We can see similar results to clusterisation: some topics are easy to classify, and accuracy is 100%, for example, “bicycles” or “travel”, while some others are difficult to distinguish (especially “ai”).

However, we achieved 91.8% overall accuracy, which is quite good.

Finding anomalies
We can also use embedding to find anomalies in our data. For example, at the t-SNE graph, we saw that some questions are pretty far from their clusters, for instance, for the “travel” topic. Let’s look at this theme and try to find anomalies. We will use the Isolation Forest algorithm for it.

from sklearn.ensemble import IsolationForest

topic_df = df[df.topic == 'travel']
topic_embeddings_array = np.array(topic_df.embedding.values.tolist())

clf = IsolationForest(contamination = 0.03, random_state = 42) 
topic_df['is_anomaly'] = clf.fit_predict(topic_embeddings_array)

topic_df[topic_df.is_anomaly == -1][['full_text']]
So, here we are. We’ve found the most uncommon comment for the travel topic (source).

Is it safe to drink the water from the fountains found all over 
the older parts of Rome?

When I visited Rome and walked around the older sections, I saw many 
different types of fountains that were constantly running with water. 
Some went into the ground, some collected in basins, etc.

Is the water coming out of these fountains potable? Safe for visitors 
to drink from? Any etiquette regarding their use that a visitor 
should know about?
Since it talks about water, the embedding of this comment is close to the coffee topic where people also discuss water to pour coffee. So, the embedding representation is quite reasonable.

We could find it on our t-SNE visualisation and see that it’s actually close to the coffee cluster.


Graph by author
RAG — Retrieval Augmented Generation
With the recently increased popularity of LLMs, embeddings have been broadly used in RAG use cases.

We need Retrieval Augmented Generation when we have a lot of documents (for example, all the questions from Stack Exchange), and we can’t pass them all to an LLM because

LLMs have limits on the context size (right now, it’s 128K for GPT-4 Turbo).
We pay for tokens, so it’s more expensive to pass all the information all the time.
LLMs show worse performance with a bigger context. You can check Needle In A Haystack — Pressure Testing LLMs to learn more details.
To be able to work with an extensive knowledge base, we can leverage the RAG approach:

Compute embeddings for all the documents and store them in vector storage.
When we get a user request, we can calculate its embedding and retrieve relevant documents from the storage for this request.
Pass only relevant documents to LLM to get a final answer.
To learn more about RAG, don’t hesitate to read my article with much more details here.

Summary
In this article, we’ve discussed text embeddings in much detail. Hopefully, now you have a complete and deep understanding of this topic. Here’s a quick recap of our journey:

Firstly, we went through the evolution of approaches to work with texts.
Then, we discussed how to understand whether texts have similar meanings to each other.
After that, we saw different approaches to text embedding visualisation.
Finally, we tried to use embeddings as features in different practical tasks such as clustering, classification, anomaly detection and RAG.
Thank you a lot for reading this article. If you have any follow-up questions or comments, please leave them in the comments section.

Reference
In this article, I used a dataset from Stack Exchange Data Dump, which is available under the Creative Commons license.

This article was inspired by the following courses:

“Understanding and Applying Text Embeddings” by DeepLearning.AI in collaboration with Google Cloud,
“Vector Databases: From Embeddings to Applications” by DeepLearning.AI in collaboration with Weaviate.