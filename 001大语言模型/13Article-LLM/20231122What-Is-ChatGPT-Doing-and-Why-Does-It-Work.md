## 20231122What-Is-ChatGPT-Doing-and-Why-Does-It-Work

What Is ChatGPT Doing … and Why Does It Work?

[What Is ChatGPT Doing … and Why Does It Work?—Stephen Wolfram Writings](https://writings.stephenwolfram.com/2023/02/what-is-chatgpt-doing-and-why-does-it-work/)

Stephen Wolfram

February 14, 2023

### 01. It's Just Adding One Word at a Time

That ChatGPT can automatically generate something that reads even superficially like human-written text is remarkable, and unexpected. But how does it do it? And why does it work? My purpose here is to give a rough outline of what's going on inside ChatGPT—and then to explore why it is that it can do so well in producing what we might consider to be meaningful text. I should say at the outset that I'm going to focus on the big picture of what's going on—and while I'll mention some engineering details, I won't get deeply into them. (And the essence of what I'll say applies just as well to other current "large language models" [LLMs] as to ChatGPT.)

The first thing to explain is that what ChatGPT is always fundamentally trying to do is to produce a "reasonable continuation" of whatever text it's got so far, where by "reasonable" we mean "what one might expect someone to write after seeing what people have written on billions of webpages, etc."

So let's say we've got the text "The best thing about AI is its ability to". Imagine scanning billions of pages of human-written text (say on the web and in digitized books) and finding all instances of this text—then seeing what word comes next what fraction of the time. ChatGPT effectively does something like this, except that (as I'll explain) it doesn't look at literal text; it looks for things that in a certain sense "match in meaning". But the end result is that it produces a ranked list of words that might follow, together with "probabilities":

And the remarkable thing is that when ChatGPT does something like write an essay what it's essentially doing is just asking over and over again "given the text so far, what should the next word be?"—and each time adding a word. (More precisely, as I'll explain, it's adding a "token", which could be just a part of a word, which is why it can sometimes "make up new words".)

But, OK, at each step it gets a list of words with probabilities. But which one should it actually pick to add to the essay (or whatever) that it's writing? One might think it should be the "highest-ranked" word (i.e. the one to which the highest "probability" was assigned). But this is where a bit of voodoo begins to creep in. Because for some reason—that maybe one day we'll have a scientific-style understanding of—if we always pick the highest-ranked word, we'll typically get a very "flat" essay, that never seems to "show any creativity" (and even sometimes repeats word for word). But if sometimes (at random) we pick lower-ranked words, we get a "more interesting" essay.

The fact that there's randomness here means that if we use the same prompt multiple times, we're likely to get different essays each time. And, in keeping with the idea of voodoo, there's a particular so-called "temperature" parameter that determines how often lower-ranked words will be used, and for essay generation, it turns out that a "temperature" of 0.8 seems best. (It's worth emphasizing that there's no "theory" being used here; it's just a matter of what's been found to work in practice. And for example the concept of "temperature" is there because exponential distributions familiar from statistical physics happen to be being used, but there's no "physical" connection—at least so far as we know.)

Before we go on I should explain that for purposes of exposition I'm mostly not going to use the full system that's in ChatGPT; instead I'll usually work with a simpler GPT-2 system, which has the nice feature that it's small enough to be able to run on a standard desktop computer. And so for essentially everything I show I'll be able to include explicit Wolfram Language code that you can immediately run on your computer. (Click any picture here to copy the code behind it.)

For example, here's how to get the table of probabilities above. First, we have to retrieve the underlying "language model" neural net:

Later on, we'll look inside this neural net, and talk about how it works. But for now we can just apply this "net model" as a black box to our text so far, and ask for the top 5 words by probability that the model says should follow:

This takes that result and makes it into an explicit formatted "dataset":

Here's what happens if one repeatedly "applies the model"—at each step adding the word that has the top probability (specified in this code as the "decision" from the model):

In[]:= NestList [StringJoin [#, model [#, "Decision"]] &,
"The best thing about Al is its ability to", 7]

Out[]= {The best thing about Al is its ability to,
The best thing about Al is its ability to learn,
The best thing about Al is its ability to learn from,
The best thing about Al is its ability to learn from experience, 
The best thing about Al is its ability to learn from experience., 
The best thing about Al is its ability to learn from experience. It, 
The best thing about Al is its ability to learn from experience. It's, 
The best thing about Al is its ability to learn from experience. It's not}

What happens if one goes on longer? In this ("zero temperature") case what comes out soon gets rather confused and repetitive:

But what if instead of always picking the "top" word one sometimes randomly picks "non-top" words (with the "randomness" corresponding to "temperature" 0.8)? Again one can build up text:

And every time one does this, different random choices will be made, and the text will be different—as in these 5 examples:

It's worth pointing out that even at the first step there are a lot of possible "next words" to choose from (at temperature 0.8), though their probabilities fall off quite quickly (and, yes, the straight line on this log-log plot corresponds to an n–1 "power-law" decay that's very characteristic of the general statistics of language):

So what happens if one goes on longer? Here's a random example. It's better than the top-word (zero temperature) case, but still at best a bit weird:

This was done with the simplest GPT-2 model (from 2019). With the newer and bigger GPT-3 models the results are better. Here's the top-word (zero temperature) text produced with the same "prompt", but with the biggest GPT-3 model:

And here's a random example at "temperature 0.8":

ChatGPT 能自动产生看似由人类撰写的文本，这本身就令人惊叹且出人意料。但它是如何实现的？为什么它能有效呢？本文旨在概述 ChatGPT 内部的工作原理，并探讨其在生成看似有意义的文本方面的出色表现。首先声明，我会着重于整体概念而不会深入技术细节。（我所述之内容同样适用于其他当前流行的「大型语言模型」[LLMs]，包括 ChatGPT。）

首先，ChatGPT 的基本目标是对已有文本生成一个「合理的继续」，其中「合理」指的是基于大量网络页面和数字化书籍中的内容，人们可能会如何继续写作。

例如，对于「人工智能最棒的地方在于它的能力」，ChatGPT 会扫描数十亿页文本，寻找这句话的所有出现，并观察接下来的词出现的频率。ChatGPT 实际上在执行类似的操作，但它不是直接查找文本，而是寻找在某种意义上「意义相匹配」的内容。最终，它会生成一个可能接续的单词列表及其「概率」：

当 ChatGPT 像撰写文章这样的任务时，它实际上在反复询问：「基于目前的文本，下一个词应该是什么？」然后逐个添加词汇。（更准确地说，它添加的是「标记」，这可能只是一个词的部分，这也是其有时能创造新词的原因。）

但问题来了：在每一步，它会得到一个带有概率的单词列表，但应该选择哪一个来继续撰写呢？直觉上，我们可能会选排名最高的单词。但这时就有些玄学的因素介入了。因为出于某种原因，如果我们总是选择排名最高的词，通常会得到内容单调、缺乏创造力的文章（有时甚至会原样重复）。但如果偶尔选择排名较低的词，文章则会更有趣。

这里的随机性意味着，即使是同一个提示，每次得到的文章也可能不同。而且有一个所谓的「温度」参数，它决定了低排名词的使用频率，在撰写文章时，0.8 的「温度」似乎是最佳选择。（值得一提的是，这里没有应用任何理论，而是基于实践中发现的最佳做法。例如，「温度」的概念源于统计物理学中的指数分布，但至少目前看来，它与物理学没有直接关联。）

在我们继续之前，我要说明，为了更好地说明问题，我大部分时间不会使用 ChatGPT 的完整系统。相反，我通常会使用一个更简单的 GPT-2 系统，它的优点是体积小，可以在标准桌面电脑上运行。因此，对于我展示的几乎所有内容，我都可以提供您可以立即在电脑上运行的 Wolfram 语言代码。（点击这里的任何图片可以复制背后的代码。）

比如，下面是获取上述概率表的方法。首先，我们需要检索底层的「语言模型」神经网络：

稍后我们将深入了解这个神经网络及其工作原理。但现在，我们可以把这个「网络模型」当作一个黑盒子，应用到我们目前的文本上，询问模型认为应该接下来的前 5 个词的概率：

这将把结果转换为一个明确格式化的「数据集」：

如果一个人反复「应用这个模型」，在每一步加入概率最高的词语（在这段代码中定义为模型的「决策」），会发生什么：

如果继续进行会怎样？在这个（零温度）案例中，输出的内容很快就会变得混乱和重复：

但如果不总是挑选「最顶端」的词，而是有时随机选择「非顶端」的词（与「温度」0.8 的「随机性」相对应），会怎样？可以再次构建文本：

每次进行这个过程时，都会做出不同的随机选择，文本也将不同 —— 如这 5 个示例所示：

值得指出的是，即使是在第一步，也有许多可能的「下一个词」可供选择（在温度 0.8 时），尽管它们的概率很快就会下降（是的，这个对数 —— 对数图上的直线对应于一个 n-1 的「幂律」衰减，这是语言统计中非常典型的特性）：

那么如果继续下去会怎样呢？这是一个随机示例。它比顶词（零温度）情况更好，但最多也只是有些奇怪：

这是使用最简单的 2019 年版 GPT-2 模型完成的。使用更新且更大的 GPT-3 模型，结果会更好。这是使用相同的「提示」，但用最大的 GPT-3 模型生成的顶词（零温度）文本：

这是「温度 0.8」下的一个随机示例：

### 02. Where Do the Probabilities Come From?

OK, so ChatGPT always picks its next word based on probabilities. But where do those probabilities come from? Let's start with a simpler problem. Let's consider generating English text one letter (rather than word) at a time. How can we work out what the probability for each letter should be?

A very minimal thing we could do is just take a sample of English text, and calculate how often different letters occur in it. So, for example, this counts letters in the Wikipedia article on "cats":

And this does the same thing for "dogs":

The results are similar, but not the same ("o" is no doubt more common in the "dogs" article because, after all, it occurs in the word "dog" itself). Still, if we take a large enough sample of English text we can expect to eventually get at least fairly consistent results:

Here's a sample of what we get if we just generate a sequence of letters with these probabilities:

We can break this into "words" by adding in spaces as if they were letters with a certain probability:

We can do a slightly better job of making "words" by forcing the distribution of "word lengths" to agree with what it is in English:

We didn't happen to get any "actual words" here, but the results are looking slightly better. To go further, though, we need to do more than just pick each letter separately at random. And, for example, we know that if we have a "q", the next letter basically has to be "u".

Here's a plot of the probabilities for letters on their own:

And here's a plot that shows the probabilities of pairs of letters ("2-grams") in typical English text. The possible first letters are shown across the page, the second letters down the page:

And we see here, for example, that the "q" column is blank (zero probability) except on the "u" row. OK, so now instead of generating our "words" a single letter at a time, let's generate them looking at two letters at a time, using these "2-gram" probabilities. Here's a sample of the result—which happens to include a few "actual words":

With sufficiently much English text we can get pretty good estimates not just for probabilities of single letters or pairs of letters (2-grams), but also for longer runs of letters. And if we generate "random words" with progressively longer n-gram probabilities, we see that they get progressively "more realistic":

But let's now assume—more or less as ChatGPT does—that we're dealing with whole words, not letters. There are about 40,000 reasonably commonly used words in English. And by looking at a large corpus of English text (say a few million books, with altogether a few hundred billion words), we can get an estimate of how common each word is. And using this we can start generating "sentences", in which each word is independently picked at random, with the same probability that it appears in the corpus. Here's a sample of what we get:

Not surprisingly, this is nonsense. So how can we do better? Just like with letters, we can start taking into account not just probabilities for single words but probabilities for pairs or longer n-grams of words. Doing this for pairs, here are 5 examples of what we get, in all cases starting from the word "cat":

It's getting slightly more "sensible looking". And we might imagine that if we were able to use sufficiently long n-grams we'd basically "get a ChatGPT"—in the sense that we'd get something that would generate essay-length sequences of words with the "correct overall essay probabilities". But here's the problem: there just isn't even close to enough English text that's ever been written to be able to deduce those probabilities.

In a crawl of the web there might be a few hundred billion words; in books that have been digitized there might be another hundred billion words. But with 40,000 common words, even the number of possible 2-grams is already 1.6 billion—and the number of possible 3-grams is 60 trillion. So there's no way we can estimate the probabilities even for all of these from text that's out there. And by the time we get to "essay fragments" of 20 words, the number of possibilities is larger than the number of particles in the universe, so in a sense they could never all be written down.

So what can we do? The big idea is to make a model that lets us estimate the probabilities with which sequences should occur—even though we've never explicitly seen those sequences in the corpus of text we've looked at. And at the core of ChatGPT is precisely a so-called "large language model" (LLM) that's been built to do a good job of estimating those probabilities.

那么，ChatGPT 总是根据概率来挑选它的下一个词。但这些概率是怎么来的呢？我们不妨从一个更简单的问题开始：尝试一次生成一个字母（而不是一个单词）来构成英文文本。我们怎样才能确定每个字母的概率呢？

一个非常基本的做法是选取一些英文文本样本，然后计算其中不同字母出现的频率。比如，以下是统计维基百科「猫」条目中字母出现频率的例子：

对「狗」条目做同样的统计：

结果相似，但有所不同（例如，「o」在「狗」条目中更常见，因为它出现在单词「dog」中）。然而，如果我们取足够大的英文文本样本，我们至少可以期待最终得到相对一致的结果：

以下是我们仅使用这些概率生成的一系列字母样本：

我们可以通过添加空格（把它们当作有一定概率出现的字母）来把这些字母分成「单词」：

通过强制「单词长度」分布与英语中的分布一致，我们可以稍微更好地构造「单词」：

虽然我们这里没有碰巧生成任何「真正的单词」，但结果看起来稍微好一些。然而，要进一步提高，我们需要做的不仅仅是随机选择每个字母。比如，我们知道如果有一个「q」，下一个字母几乎必定是「u」。

这是单独一个字母的概率图：

这是展示典型英文文本中字母对（2-gram）概率的图表。可能的首字母在页面上展示，第二个字母在页面下方展示：

例如，我们可以看到在「q」列中，除了「u」行外，其他都是零概率。好的，现在我们不再一次只生成一个字母的「单词」，而是尝试使用这些「2-gram」概率，一次考虑两个字母来生成它们。这是所得结果的一个样本 —— 偶然包含了一些「真正的单词」：

有了足够多的英文文本，我们不仅可以准确估计单个字母或字母对（2-grams）的概率，还可以估计更长字母串的概率。如果我们用逐渐增长的 n-gram 概率生成「随机单词」，我们会发现它们逐渐变得「更加真实」：

但现在，让我们像 ChatGPT 那样假设我们处理的是完整的单词，而不是字母。英语中大约有 40,000 个常见单词。通过分析大量英文文本（例如几百万本书，总共几百亿个单词），我们可以估算出每个单词的普遍性。利用这个数据，我们可以开始生成「句子」，其中每个单词都是独立随机挑选的，其概率与它在语料库中出现的频率一致。以下是我们得到的样本：

不出所料，这些文本毫无意义。那我们怎么能做得更好呢？就像处理字母一样，我们可以开始考虑不仅仅是单个单词的概率，还要考虑单词对或更长的 n-gram 的概率。采用这种方法生成单词对，以下是我们从「cat」这个词开始得到的 5 个例子：

看起来稍微更有意义了。我们可能会想象，如果我们能使用足够长的 n-gram，我们基本上可以「创造出一个 ChatGPT」—— 意味着我们将得到能够生成具有「正确的整体文章概率」的长篇单词序列的工具。但问题是：迄今为止写过的英文文本远远不够，无法用来推断这些概率。

在网络上爬取的文本可能有几百亿个单词；在已经数字化的书籍中可能还有另外几百亿个单词。但是，在 40,000 个常用词的情况下，即使是 2-gram 的可能性也已经达到了 16 亿，而 3-gram 的可能性则达到了 60 万亿。因此，我们不可能仅凭已有的文本来估算所有这些概率。而到了 20 个单词的「文章片段」，可能性的数量已经超过了宇宙中的粒子总数，所以从某种意义上说，这些文本是不可能全部被写出来的。

那么我们能做些什么呢？一个关键的想法是建立一个模型，即使我们从未在所研究的文本语料库中明确见过这些序列，也能估算出序列出现的概率。而 ChatGPT 的核心就是一个被精心构建用于有效估算这些概率的所谓的「大型语言模型」（LLM）。

### 03. What Is a Model?

Say you want to know (as Galileo did back in the late 1500s) how long it's going to take a cannon ball dropped from each floor of the Tower of Pisa to hit the ground. Well, you could just measure it in each case and make a table of the results. Or you could do what is the essence of theoretical science: make a model that gives some kind of procedure for computing the answer rather than just measuring and remembering each case.

Let's imagine we have (somewhat idealized) data for how long the cannon ball takes to fall from various floors:

How do we figure out how long it's going to take to fall from a floor we don't explicitly have data about? In this particular case, we can use known laws of physics to work it out. But say all we've got is the data, and we don't know what underlying laws govern it. Then we might make a mathematical guess, like that perhaps we should use a straight line as a model:

We could pick different straight lines. But this is the one that's on average closest to the data we're given. And from this straight line we can estimate the time to fall for any floor.

How did we know to try using a straight line here? At some level we didn't. It's just something that's mathematically simple, and we're used to the fact that lots of data we measure turns out to be well fit by mathematically simple things. We could try something mathematically more complicated—say a + b x + c x2—and then in this case we do better:

Things can go quite wrong, though. Like here's the best we can do with a + b/x + c sin(x):

It is worth understanding that there's never a "model-less model". Any model you use has some particular underlying structure—then a certain set of "knobs you can turn" (i.e. parameters you can set) to fit your data. And in the case of ChatGPT, lots of such "knobs" are used—actually, 175 billion of them.

But the remarkable thing is that the underlying structure of ChatGPT—with "just" that many parameters—is sufficient to make a model that computes next-word probabilities "well enough" to give us reasonable essay-length pieces of text.

[Fasti consolari dell'Accademia fiorentina di Salvino Salvini consolo della medesima e rettore generale dello Studio di Firenze. All'altezza reale del serenissimo Gio. Gastone gran principe di Toscana : Salvini, Salvino : Free Download, Borrow, and Streaming : Internet Archive](https://archive.org/details/bub_gb_49d42xp-USMC/page/404/mode/2up)

想象一下，如果你像伽利略在 16 世纪末那样，想知道从比萨斜塔的每一层掉落的炮弹到达地面需要多长时间。你可以在每种情况下测量并制作一张结果表。或者，你可以做理论科学的本质所在：创建一个模型，提供一种计算答案的方法，而不是仅仅测量和记住每个案例。

让我们假设我们有关于炮弹从各个楼层落下所需时间的（有些理想化的）数据：

我们如何确定从我们没有明确数据的楼层落下需要多长时间？在这种特定情况下，我们可以使用已知的物理定律来计算出来。但假设我们只有数据，并不知道控制它的基本规律是什么。那么我们可能会做出一个数学猜测，比如说我们可能应该使用一条直线作为模型：

我们可以选择不同的直线。但这条直线平均而言最接近我们所给的数据。根据这条直线，我们可以估算任何楼层的落地时间。

我们怎么知道要尝试使用直线呢？在某种程度上，我们并不知道。这只是数学上简单的东西，我们习惯于许多我们测量的数据能够被数学上简单的模型很好地拟合。我们可以尝试更复杂的数学模型 —— 比如 a + b x + c x²—— 然后在这种情况下我们可能会做得更好：

不过，情况有时也可能出错。例如，用 a + b/x + c sin (x) 得出的最佳结果可能是这样的：

值得理解的是，从来没有「无模型的模型」。你使用的任何模型都有一定的基础结构，然后有一系列「可以调整的旋钮」（即你可以设置的参数）来拟合你的数据。在 ChatGPT 的情况下，使用了许多这样的「旋钮」—— 实际上有 1750 亿个。

但值得注意的是，ChatGPT 的基础结构 —— 仅用这么多参数 —— 就足以构建一个模型，这个模型能够「足够好地」计算下一个词的概率，从而产生合理长度的文章文本。

### 04. Models for Human-Like Tasks

The example we gave above involves making a model for numerical data that essentially comes from simple physics—where we've known for several centuries that "simple mathematics applies". But for ChatGPT we have to make a model of human-language text of the kind produced by a human brain. And for something like that we don't (at least yet) have anything like "simple mathematics". So what might a model of it be like?

Before we talk about language, let's talk about another human-like task: recognizing images. And as a simple example of this, let's consider images of digits (and, yes, this is a classic machine learning example):

One thing we could do is get a bunch of sample images for each digit:

Then to find out if an image we're given as input corresponds to a particular digit we could just do an explicit pixel-by-pixel comparison with the samples we have. But as humans we certainly seem to do something better—because we can still recognize digits, even when they're for example handwritten, and have all sorts of modifications and distortions:

When we made a model for our numerical data above, we were able to take a numerical value x that we were given, and just compute a + b x for particular a and b. So if we treat the gray-level value of each pixel here as some variable xi is there some function of all those variables that—when evaluated—tells us what digit the image is of? It turns out that it's possible to construct such a function. Not surprisingly, it's not particularly simple, though. And a typical example might involve perhaps half a million mathematical operations.

But the end result is that if we feed the collection of pixel values for an image into this function, out will come the number specifying which digit we have an image of. Later, we'll talk about how such a function can be constructed, and the idea of neural nets. But for now let's treat the function as black box, where we feed in images of, say, handwritten digits (as arrays of pixel values) and we get out the numbers these correspond to:

But what's really going on here? Let's say we progressively blur a digit. For a little while our function still "recognizes" it, here as a "2". But soon it "loses it", and starts giving the "wrong" result:

But why do we say it's the "wrong" result? In this case, we know we got all the images by blurring a "2". But if our goal is to produce a model of what humans can do in recognizing images, the real question to ask is what a human would have done if presented with one of those blurred images, without knowing where it came from.

And we have a "good model" if the results we get from our function typically agree with what a human would say. And the nontrivial scientific fact is that for an image-recognition task like this we now basically know how to construct functions that do this.

Can we "mathematically prove" that they work? Well, no. Because to do that we'd have to have a mathematical theory of what we humans are doing. Take the "2" image and change a few pixels. We might imagine that with only a few pixels "out of place" we should still consider the image a "2". But how far should that go? It's a question of human visual perception. And, yes, the answer would no doubt be different for bees or octopuses—and potentially utterly different for putative aliens.

[LeNet - Wolfram Neural Net Repository](https://resources.wolframcloud.com/NeuralNetRepository/resources/LeNet-Trained-on-MNIST-Data/)

在上面的例子中，我们制作了一个基于简单物理学的数值数据模型 —— 在这方面，我们已经知道了几个世纪的「简单数学适用」。但对于 ChatGPT，我们必须为人类大脑产生的人类语言文本制作模型。对于这样的任务，我们（至少目前）还没有像「简单数学」这样的东西。那么，它的模型可能是什么样的呢？

在我们讨论语言之前，让我们先谈谈另一项类似人类的任务：识别图像。作为一个简单的例子，让我们考虑数字图像（是的，这是一个经典的机器学习示例）：

我们可以做的一件事是为每个数字获取一堆样本图像：

然后，为了确定我们作为输入得到的图像是否对应于特定的数字，我们可以与我们拥有的样本进行逐像素的显式比较。但作为人类，我们显然似乎做得更好 —— 因为即使数字是手写的，并且有各种修改和扭曲，我们仍然可以识别出来：

当我们为上述数值数据制作模型时，我们可以取给定的数值 x，并计算特定的 a + b x。那么，如果我们将这里每个像素的灰度值视为某个变量 xi，是否有一些函数 —— 当求值时 —— 告诉我们图像是哪个数字的？事实证明，可以构造这样的函数。不出所料，它并不特别简单。一个典型的例子可能涉及大约 50 万个数学运算。

但最终结果是，如果我们将图像的像素值集合输入到这个函数中，输出的将是指定我们拥有哪个数字图像的数字。稍后，我们将讨论如何构建这样的函数以及神经网络的概念。但现在让我们将该函数视为黑盒，我们在其中输入例如手写数字的图像（作为像素值数组），我们得到这些对应的数字：

但这里究竟发生了什么呢？假设我们逐渐模糊一个数字。有一段时间我们的函数仍然「识别」出它，这里是「2」。但很快它就「失去了」，开始给出「错误」的结果：

但我们为什么说这是「错误」的结果呢？在这种情况下，我们知道所有的图像都是通过模糊「2」获得的。但如果我们的目标是制作一个模型，来模拟人类在识别图像方面的能力，那么真正应该问的问题是，如果人类面对这些模糊的图像，而不知道它们来自哪里，会怎么做。

如果我们从函数中得到的结果通常与人类的说法一致，那么我们就有了一个「好的模型」。值得注意的是，对于像这样的图像识别任务，我们现在基本上知道如何构建能够实现这一点的函数。

我们能「数学证明」它们有效吗？嗯，不能。因为要做到这一点，我们必须拥有一个关于我们人类在做什么的数学理论。拿「2」的图像，改变几个像素。我们可能会想象，即使只有几个像素「不在位」，我们仍然应该认为图像是「2」。但这应该进行多远呢？这是一个关于人类视觉感知的问题。是的，对于蜜蜂或章鱼来说答案无疑会不同 —— 对于假设的外星人来说可能完全不同。

### 05. Neural Nets

OK, so how do our typical models for tasks like image recognition actually work? The most popular—and successful—current approach uses neural nets. Invented—in a form remarkably close to their use today—in the 1940s, neural nets can be thought of as simple idealizations of how brains seem to work.

In human brains there are about 100 billion neurons (nerve cells), each capable of producing an electrical pulse up to perhaps a thousand times a second. The neurons are connected in a complicated net, with each neuron having tree-like branches allowing it to pass electrical signals to perhaps thousands of other neurons. And in a rough approximation, whether any given neuron produces an electrical pulse at a given moment depends on what pulses it's received from other neurons—with different connections contributing with different "weights".

When we "see an image" what's happening is that when photons of light from the image fall on ("photoreceptor") cells at the back of our eyes they produce electrical signals in nerve cells. These nerve cells are connected to other nerve cells, and eventually the signals go through a whole sequence of layers of neurons. And it's in this process that we "recognize" the image, eventually "forming the thought" that we're "seeing a 2" (and maybe in the end doing something like saying the word "two" out loud).

The "black-box" function from the previous section is a "mathematicized" version of such a neural net. It happens to have 11 layers (though only 4 "core layers"):

There's nothing particularly "theoretically derived" about this neural net; it's just something that—back in 1998—was constructed as a piece of engineering, and found to work. (Of course, that's not much different from how we might describe our brains as having been produced through the process of biological evolution.)

OK, but how does a neural net like this "recognize things"? The key is the notion of attractors. Imagine we've got handwritten images of 1's and 2's:

We somehow want all the 1's to "be attracted to one place", and all the 2's to "be attracted to another place". Or, put a different way, if an image is somehow "closer to being a 1" than to being a 2, we want it to end up in the "1 place" and vice versa.

As a straightforward analogy, let's say we have certain positions in the plane, indicated by dots (in a real-life setting they might be positions of coffee shops). Then we might imagine that starting from any point on the plane we'd always want to end up at the closest dot (i.e. we'd always go to the closest coffee shop). We can represent this by dividing the plane into regions ("attractor basins") separated by idealized "watersheds":

We can think of this as implementing a kind of "recognition task" in which we're not doing something like identifying what digit a given image "looks most like"—but rather we're just, quite directly, seeing what dot a given point is closest to. (The "Voronoi diagram" setup we're showing here separates points in 2D Euclidean space; the digit recognition task can be thought of as doing something very similar—but in a 784-dimensional space formed from the gray levels of all the pixels in each image.)

So how do we make a neural net "do a recognition task"? Let's consider this very simple case:

Our goal is to take an "input" corresponding to a position {x,y}—and then to "recognize" it as whichever of the three points it's closest to. Or, in other words, we want the neural net to compute a function of {x,y} like:

So how do we do this with a neural net? Ultimately a neural net is a connected collection of idealized "neurons"—usually arranged in layers—with a simple example being:

Each "neuron" is effectively set up to evaluate a simple numerical function. And to "use" the network, we simply feed numbers (like our coordinates x and y) in at the top, then have neurons on each layer "evaluate their functions" and feed the results forward through the network—eventually producing the final result at the bottom:

In the traditional (biologically inspired) setup each neuron effectively has a certain set of "incoming connections" from the neurons on the previous layer, with each connection being assigned a certain "weight" (which can be a positive or negative number). The value of a given neuron is determined by multiplying the values of "previous neurons" by their corresponding weights, then adding these up and adding a constant—and finally applying a "thresholding" (or "activation") function. In mathematical terms, if a neuron has inputs x = {x1, x2 …} then we compute f[w.x + b], where the weights w and constant b are generally chosen differently for each neuron in the network; the function f is usually the same.

Computing w.x + b is just a matter of matrix multiplication and addition. The "activation function" f introduces nonlinearity (and ultimately is what leads to nontrivial behavior). Various activation functions commonly get used; here we'll just use Ramp (or ReLU):

For each task we want the neural net to perform (or, equivalently, for each overall function we want it to evaluate) we'll have different choices of weights. (And—as we'll discuss later—these weights are normally determined by "training" the neural net using machine learning from examples of the outputs we want.)

Ultimately, every neural net just corresponds to some overall mathematical function—though it may be messy to write out. For the example above, it would be:

W511f(w311f(b11+xW111+yw112)+W312f(b12+xW121+yw122)+
W313f(b13+xW131+yW132)+W314f(b14+xW141+yW142)+b31)+
Ws12f(W321f(b11+xW111+yW112)+W322f(b12+xW121+yW122)+
W323f(b13+xW131+yW132)+W324f(b14+xW141+yW142)+b32)+
W513f(w331f(b11+xW111+yw112)+W332f(b12+xW121+yW122)+
W333f(b13+xW131+yw132)+W334f(b14+xW141+yw142)+b33)+b51

The neural net of ChatGPT also just corresponds to a mathematical function like this—but effectively with billions of terms.

But let's go back to individual neurons. Here are some examples of the functions a neuron with two inputs (representing coordinates x and y) can compute with various choices of weights and constants (and Ramp as activation function):

But what about the larger network from above? Well, here's what it computes:

It's not quite "right", but it's close to the "nearest point" function we showed above.

Let's see what happens with some other neural nets. In each case, as we'll explain later, we're using machine learning to find the best choice of weights. Then we're showing here what the neural net with those weights computes:

Bigger networks generally do better at approximating the function we're aiming for. And in the "middle of each attractor basin" we typically get exactly the answer we want. But at the boundaries—where the neural net "has a hard time making up its mind"—things can be messier.

With this simple mathematical-style "recognition task" it's clear what the "right answer" is. But in the problem of recognizing handwritten digits, it's not so clear. What if someone wrote a "2" so badly it looked like a "7", etc.? Still, we can ask how a neural net distinguishes digits—and this gives an indication:

Can we say "mathematically" how the network makes its distinctions? Not really. It's just "doing what the neural net does". But it turns out that that normally seems to agree fairly well with the distinctions we humans make.

Let's take a more elaborate example. Let's say we have images of cats and dogs. And we have a neural net that's been trained to distinguish them. Here's what it might do on some examples:

Now it's even less clear what the "right answer" is. What about a dog dressed in a cat suit? Etc. Whatever input it's given the neural net will generate an answer, and in a way reasonably consistent with how humans might. As I've said above, that's not a fact we can "derive from first principles". It's just something that's empirically been found to be true, at least in certain domains. But it's a key reason why neural nets are useful: that they somehow capture a "human-like" way of doing things.

Show yourself a picture of a cat, and ask "Why is that a cat?". Maybe you'd start saying "Well, I see its pointy ears, etc." But it's not very easy to explain how you recognized the image as a cat. It's just that somehow your brain figured that out. But for a brain there's no way (at least yet) to "go inside" and see how it figured it out. What about for an (artificial) neural net? Well, it's straightforward to see what each "neuron" does when you show a picture of a cat. But even to get a basic visualization is usually very difficult.

In the final net that we used for the "nearest point" problem above there are 17 neurons. In the net for recognizing handwritten digits there are 2190. And in the net we're using to recognize cats and dogs there are 60,650. Normally it would be pretty difficult to visualize what amounts to 60,650-dimensional space. But because this is a network set up to deal with images, many of its layers of neurons are organized into arrays, like the arrays of pixels it's looking at.

And if we take a typical cat image

then we can represent the states of neurons at the first layer by a collection of derived images—many of which we can readily interpret as being things like "the cat without its background", or "the outline of the cat":

By the 10th layer it's harder to interpret what's going on:

But in general we might say that the neural net is "picking out certain features" (maybe pointy ears are among them), and using these to determine what the image is of. But are those features ones for which we have names—like "pointy ears"? Mostly not.

Are our brains using similar features? Mostly we don't know. But it's notable that the first few layers of a neural net like the one we're showing here seem to pick out aspects of images (like edges of objects) that seem to be similar to ones we know are picked out by the first level of visual processing in brains.

But let's say we want a "theory of cat recognition" in neural nets. We can say: "Look, this particular net does it"—and immediately that gives us some sense of "how hard a problem" it is (and, for example, how many neurons or layers might be needed). But at least as of now we don't have a way to "give a narrative description" of what the network is doing. And maybe that's because it truly is computationally irreducible, and there's no general way to find what it does except by explicitly tracing each step. Or maybe it's just that we haven't "figured out the science", and identified the "natural laws" that allow us to summarize what's going on.

We'll encounter the same kinds of issues when we talk about generating language with ChatGPT. And again it's not clear whether there are ways to "summarize what it's doing". But the richness and detail of language (and our experience with it) may allow us to get further than with images.

[Stephen Wolfram: A New Kind of Science | Online—Table of Contents](https://www.wolframscience.com/nks/)

[Note (a) for Human Thinking: A New Kind of Science | Online by Stephen Wolfram [Page 1099]](https://www.wolframscience.com/nks/notes-10-12--history-of-ideas-about-thinking/)

2『已下载原文书籍「2023047A-New-Kind-of-Science」。（2023-11-23）』

在典型的任务如图像识别中，我们通常使用的模型是怎样工作的呢？目前最流行且成功的方法是使用神经网络。神经网络最初是在 20 世纪 40 年代发明的，其形式与今天使用的惊人地接近，可以被看作是对大脑工作方式的简单理想化。

在人类大脑中，大约有 1000 亿个神经元（神经细胞），每个神经元都能产生电脉冲，频率高达每秒上千次。这些神经元通过复杂的网络相连，每个神经元都有树状分支，可以将电信号传递给其他数千个神经元。在一个粗略的近似中，任何给定神经元在特定时刻是否产生电脉冲取决于它从其他神经元接收到的脉冲 —— 不同的连接以不同的「权重」贡献。

当我们「看到一个图像」时，发生的事情是，来自图像的光子落在我们眼睛后部的（感光）细胞上时，它们会在神经细胞中产生电信号。这些神经细胞与其他神经细胞相连，最终信号会通过一系列神经元层。正是在这个过程中，我们「识别」了图像，最终「形成了思维」，我们正在「看到一个 2」（也许最终做的是像大声说出「二」这个词）。

前一部分中提到的「黑盒」功能是这样一个神经网络的「数学化」版本。它恰好有 11 层（尽管只有 4 个「核心层」）：

这个神经网络并没有什么特别的「理论导出」，它只是一种 —— 早在 1998 年 —— 作为工程设计构建出来并发现有效的东西。（当然，这与我们描述我们的大脑通过生物进化过程产生的方式并没有太大不同。）

那么，这样的神经网络是如何「识别事物」的呢？关键是吸引子的概念。假设我们有手写的数字 1 和数字 2 的图像：

我们希望所有的 1 都「被吸引到一个地方」，所有的 2 都「被吸引到另一个地方」。或者换种方式说，如果一个图像在某种程度上「更接近于 1 而不是 2」，我们希望它最终到达「1 的位置」，反之亦然。

为了提供一个直接的类比，假设我们在平面上有一些点（在现实生活中，它们可能是咖啡店的位置）。那么我们可以想象，从平面上的任何一点出发，我们总是希望最终到达最近的点（即我们总是去最近的咖啡店）。我们可以通过将平面划分为区域（吸引盆地），这些区域由理想化的「分水岭」分隔开来：

我们可以将这看作是实施一种「识别任务」，在这种任务中，我们不是在识别给定图像「最像哪个数字」，而是直接看给定点离哪个点最近。（这里展示的「Voronoi 图」设置将 2D 欧几里得空间中的点分开；数字识别任务可以被认为是在 784 维空间中进行的，这个空间由每个图像中所有像素的灰度级别构成。）

那么我们如何让神经网络「执行识别任务」呢？让我们考虑这个非常简单的例子：

我们的目标是接受一个对应于位置 {x,y} 的「输入」—— 然后将其「识别」为最接近的三个点中的任何一个。换句话说，我们希望神经网络计算出一个像 {x,y} 这样的函数：

那么我们如何使用神经网络来实现这一点呢？从根本上说，神经网络是一组相互连接的理想化的「神经元」—— 通常按层排列 —— 一个简单的例子是：

每个「神经元」实际上都被设置为评估一个简单的数值函数。要「使用」网络，我们只需将数字（如我们的坐标 x 和 y）从顶部输入，然后让每一层的神经元「计算它们的函数」并将结果通过网络向前传递 —— 最终在底部产生最终结果：

在传统的（受生物启发的）设置中，每个神经元实际上都有一定的「传入连接」，这些连接来自前一层的神经元，每个连接都被分配了一定的「权重」（可以是正数或负数）。给定神经元的值是通过将「前面的神经元」的值与它们对应的权重相乘，然后加在一起并加上一个常数 —— 最后应用一个「阈值」（或「激活」）函数来确定的。用数学术语来说，如果一个神经元有输入 x = {x1, x2 …}，那么我们计算 f[w.x + b]，其中权重 w 和常数 b 通常对网络中的每个神经元选择不同；函数 f 通常是相同的。

计算 w.x + b 只是矩阵乘法和加法的问题。「激活函数」f 引入了非线性（最终导致非平凡行为）。通常使用各种激活函数；在这里，我们将只使用 Ramp（或 ReLU）：

对于我们希望神经网络执行的每个任务（或者说，对于我们希望它评估的每个总体函数），我们将有不同的权重选择。（并且 —— 我们稍后将讨论 —— 这些权重通常通过使用我们想要的输出的例子对神经网络进行「训练」来确定。）

最终，每个神经网络都对应于某种整体数学函数 —— 尽管写出来可能很复杂。对于上面的例子，它将是：

W511f(w311f(b11+xW111+yw112)+W312f(b12+xW121+yw122)+
W313f(b13+xW131+yW132)+W314f(b14+xW141+yW142)+b31)+
Ws12f(W321f(b11+xW111+yW112)+W322f(b12+xW121+yW122)+
W323f(b13+xW131+yW132)+W324f(b14+xW141+yW142)+b32)+
W513f(w331f(b11+xW111+yw112)+W332f(b12+xW121+yW122)+
W333f(b13+xW131+yw132)+W334f(b14+xW141+yw142)+b33)+b51

ChatGPT 的神经网络也只是对应于类似这样的数学函数 —— 但实际上包含数十亿个项。

但让我们回到单个神经元。以下是具有两个输入（代表坐标 x 和 y）的神经元可以计算的一些函数示例，这里采用了不同的权重和常数选择（以及 Ramp 作为激活函数）：

那么上面的更大网络计算了什么呢？好吧，这是它计算的结果：

它不是完全「正确的」，但接近我们之前展示的「最近点」函数。

让我们看看其他一些神经网络的情况。在每种情况下，正如我们稍后将解释的，我们使用机器学习来找到最佳的权重选择。然后我们在这里展示了这些权重的神经网络计算的结果：

更大的网络通常更擅长近似我们所追求的函数。在「每个吸引盆地的中心」，我们通常得到完全我们想要的答案。但在边界处 —— 神经网络「难以做出决定」—— 情况可能会更混乱。

在这个简单的数学风格的「识别任务」中，很清楚什么是「正确答案」。但在识别手写数字的问题中就不那么清楚了。如果有人写的「2」太糟糕，看起来像「7」，等等怎么办？不过，我们仍然可以询问神经网络如何区分数字 —— 这可以给出一个指示：

我们能否「数学上」说出网络是如何做出区分的？并不真的可以。它只是「做神经网络所做的事」。但事实证明，这通常似乎与我们人类所做的区分相当吻合。

让我们看一个更复杂的例子。假设我们有猫和狗的图像。我们有一个经过训练以区分它们的神经网络。以下是它在一些例子上可能做的事情：

现在，什么是「正确答案」甚至更不清楚了。穿着猫装的狗怎么办？等等。无论给出什么输入，神经网络都会生成一个答案，并且在某种程度上与人类可能做出的判断相符。正如我上面所说的，这不是我们可以「从第一原理推导出来」的事实。这只是经验上被发现为真实的，至少在某些领域是这样。但这是神经网络有用的一个关键原因：它们以某种「类人」的方式进行操作。

给自己看一张猫的照片，问「为什么那是一只猫？」你可能会开始说「嗯，我看到它尖尖的耳朵，等等。」但解释你是如何识别出这是一只猫的图像并不容易。只是你的大脑不知怎的弄清楚了。但对于大脑，目前还没有办法（至少还没有）「深入」查看它是如何弄清楚的。那么对于（人造的）神经网络呢？查看展示猫图片时每个「神经元」做了什么是很简单的。但即使是获得基本的可视化通常也非常困难。

在我们用于上述「最近点」问题的最终网络中有 17 个神经元。在用于识别手写数字的网络中有 2190 个。在我们用来识别猫和狗的网络中有 60,650 个。通常来说，可视化相当于 60,650 维空间是相当困难的。但因为这是一个用于处理图像的网络，它的许多神经元层被组织成阵列，就像它所观察的像素阵列一样。

1『

一直没弄清楚：参数、千维向量维度里的这个维度、神经元，这几个核心概念的关系。上面这段信息的意思是，神经元数量是等价于向量维度的。向量维度自己是清楚，维度简单说就是表示一个物体（对象）所用的属性数量。老阳一直说的 GPT 用的是千维向量也应该指这个意思，每个文字被分解为千维来表示的。但这里提到的 6W 多个神经元又感觉对应于参数的，比如 Llama2-70B 模型里的 700 亿参数。如果神经元=参数=维度，感觉又不对了，应该不是 700 亿维度的概念。参数应该是指训练时微调神经网络的阀门开关数量（这个隐喻来自于收录的文章 20231121Understanding-AI）。总结下来，目前这 3 个概念还是没理清楚。（2023-11-23）

补充：下面第 6 小节，有关训练神经网络的知识里又提到相关的信息：

上面的图片展示了我们可能需要在只有 2 个权重的不切实际简单情况下进行的最小化。但事实证明，即使有更多的权重（ChatGPT 使用 1750 亿个），仍然可以进行最小化，至少在某种程度的近似中。实际上，「深度学习」在 2011 年左右发生的重大突破与发现在某种意义上，当涉及许多权重时，进行（至少是近似的）最小化可能比只涉及相对较少的权重时更容易。

所以说，三个核心概念里的「参数」即神经网络中的「权重」。（2023-11-23）

GPTs-42master-Geoffrey Hinton（2023-11-23）

您的问题涉及到深度学习中的几个基本概念：参数、向量维度、神经元。我将逐一解释这些概念，并阐述它们之间的关系。

1、参数 (Parameters):

- 在神经网络中，参数通常指的是网络中的权重（weights）和偏置（biases）。

- 权重决定了输入数据的特征如何影响网络的输出，而偏置是一个调整输出的附加值。

- 例如，在一个简单的神经网络层中，每个输入与其对应的权重相乘，加上偏置，然后通过激活函数以产生输出。

- 参数的总数取决于网络的大小和复杂性。例如，在一个有多层和每层有多个神经元的网络中，参数的数量会很大。

2、向量维度 (Vector Dimensions):

- 向量维度指的是表示数据的属性或特征的数量。

- 在深度学习中，输入数据（如文本、图像等）通常被转换为向量形式，每个维度代表数据的一个特征或属性。

- 例如，文本数据可以通过词嵌入（word embeddings）转换为高维空间中的向量，每个维度代表某种语义或语法特性。

3、神经元 (Neurons):

- 神经元是构成神经网络的基本单位。

- 每个神经元接收来自前一层的输入，通过权重加权，加上偏置，然后通常通过一个非线性激活函数来产生输出。

- 神经元的数量通常指的是网络中的激活单元的总数。

关于这些概念之间的关系和区别：

1、神经元数量与向量维度:

- 神经元的数量并不直接等同于向量的维度。一个神经网络层的输出可以是一个多维向量，其中每个维度对应于该层中的一个神经元的输出。

- 在某些上下文中，比如在处理文本时，神经元的输出可能与词嵌入的维度相关，但这两者不是同一概念。

2、神经元与参数:

- 神经元数量并不等同于参数数量。每个神经元可能有多个参数（每个输入一个权重加一个偏置），因此，整个网络的参数数量通常远远超过神经元的数量。

- 例如，Llama2-70B 模型中的 700 亿参数指的是整个网络中所有权重和偏置的总和，而不是神经元的数量。

3、参数、神经元与网络复杂度:

- 网络的复杂度通常与其参数数量相关。更多的参数意味着网络可以学习更复杂的函数或表示更复杂的数据模式。

- 神经元数量也对网络的复杂度有影响，但主要是通过决定网络的宽度（每层的神经元数量）和深度（层数）。

总的来说，这些概念虽然相互关联，但它们描述了神经网络的不同方面。参数描述了网络可以调整的元素，向量维度描述了输入和输出数据的复杂性，而神经元数量描述了网络的规模和结构。

』

如果我们拿一个典型的猫图像

那么我们可以用一组派生图像来表示第一层神经元的状态 —— 其中许多我们可以轻易地解释为诸如「没有背景的猫」或「猫的轮廓」之类的东西：

到了第 10 层，解释发生了什么就更难了：

但一般来说，我们可能会说神经网络正在「挑选出某些特征」（可能尖耳朵就是其中之一），并利用这些来确定图像的内容。但这些特征是我们有名字的特征吗 —— 比如「尖耳朵」？大部分不是。

我们的大脑是否使用类似的特征？我们大多数时候不知道。但值得注意的是，像我们在这里展示的这样的神经网络的前几层似乎会挑选出图像的某些方面（比如物体的边缘），这些方面类似于我们知道大脑视觉处理的第一级所挑选出的内容。

但假设我们想要一个关于神经网络中的「猫识别理论」。我们可以说：「看，这个特定网络就是这样做的」—— 这立刻给了我们一些关于「这是多么难的问题」的感觉（例如，可能需要多少神经元或层数）。但至少到目前为止，我们没有办法「叙述性地描述」网络在做什么。也许这是因为它确实在计算上不可约简，没有一般的方法来发现它的作用，除了明确地追踪每一步。或者也许只是因为我们还没有「弄清楚科学」，没有识别出让我们总结发生了什么的「自然规律」。

当我们讨论使用 ChatGPT 生成语言时，我们也会遇到同样的问题。同样不清楚是否有方法可以「总结它在做什么」。但语言的丰富性和细节（以及我们对它的经验）可能会让我们比对图像更进一步。

### 06. Machine Learning, and the Training of Neural Nets

We've been talking so far about neural nets that "already know" how to do particular tasks. But what makes neural nets so useful (presumably also in brains) is that not only can they in principle do all sorts of tasks, but they can be incrementally "trained from examples" to do those tasks.

When we make a neural net to distinguish cats from dogs we don't effectively have to write a program that (say) explicitly finds whiskers; instead we just show lots of examples of what's a cat and what's a dog, and then have the network "machine learn" from these how to distinguish them.

And the point is that the trained network "generalizes" from the particular examples it's shown. Just as we've seen above, it isn't simply that the network recognizes the particular pixel pattern of an example cat image it was shown; rather it's that the neural net somehow manages to distinguish images on the basis of what we consider to be some kind of "general catness".

So how does neural net training actually work? Essentially what we're always trying to do is to find weights that make the neural net successfully reproduce the examples we've given. And then we're relying on the neural net to "interpolate" (or "generalize") "between" these examples in a "reasonable" way.

Let's look at a problem even simpler than the nearest-point one above. Let's just try to get a neural net to learn the function:

For this task, we'll need a network that has just one input and one output, like:

But what weights, etc. should we be using? With every possible set of weights the neural net will compute some function. And, for example, here's what it does with a few randomly chosen sets of weights:

And, yes, we can plainly see that in none of these cases does it get even close to reproducing the function we want. So how do we find weights that will reproduce the function?

The basic idea is to supply lots of "input → output" examples to "learn from"—and then to try to find weights that will reproduce these examples. Here's the result of doing that with progressively more examples:

At each stage in this "training" the weights in the network are progressively adjusted—and we see that eventually we get a network that successfully reproduces the function we want. So how do we adjust the weights? The basic idea is at each stage to see "how far away we are" from getting the function we want—and then to update the weights in such a way as to get closer.

To find out "how far away we are" we compute what's usually called a "loss function" (or sometimes "cost function"). Here we're using a simple (L2) loss function that's just the sum of the squares of the differences between the values we get, and the true values. And what we see is that as our training process progresses, the loss function progressively decreases (following a certain "learning curve" that's different for different tasks)—until we reach a point where the network (at least to a good approximation) successfully reproduces the function we want:

Alright, so the last essential piece to explain is how the weights are adjusted to reduce the loss function. As we've said, the loss function gives us a "distance" between the values we've got, and the true values. But the "values we've got" are determined at each stage by the current version of neural net—and by the weights in it. But now imagine that the weights are variables—say wi. We want to find out how to adjust the values of these variables to minimize the loss that depends on them.

For example, imagine (in an incredible simplification of typical neural nets used in practice) that we have just two weights w1 and w2. Then we might have a loss that as a function of w1 and w2 looks like this:

Numerical analysis provides a variety of techniques for finding the minimum in cases like this. But a typical approach is just to progressively follow the path of steepest descent from whatever previous w1, w2 we had:

Like water flowing down a mountain, all that's guaranteed is that this procedure will end up at some local minimum of the surface ("a mountain lake"); it might well not reach the ultimate global minimum.

It's not obvious that it would be feasible to find the path of the steepest descent on the "weight landscape". But calculus comes to the rescue. As we mentioned above, one can always think of a neural net as computing a mathematical function—that depends on its inputs, and its weights. But now consider differentiating with respect to these weights. It turns out that the chain rule of calculus in effect lets us "unravel" the operations done by successive layers in the neural net. And the result is that we can—at least in some local approximation—"invert" the operation of the neural net, and progressively find weights that minimize the loss associated with the output.

The picture above shows the kind of minimization we might need to do in the unrealistically simple case of just 2 weights. But it turns out that even with many more weights (ChatGPT uses 175 billion) it's still possible to do the minimization, at least to some level of approximation. And in fact the big breakthrough in "deep learning" that occurred around 2011 was associated with the discovery that in some sense it can be easier to do (at least approximate) minimization when there are lots of weights involved than when there are fairly few.

In other words—somewhat counterintuitively—it can be easier to solve more complicated problems with neural nets than simpler ones. And the rough reason for this seems to be that when one has a lot of "weight variables" one has a high-dimensional space with "lots of different directions" that can lead one to the minimum—whereas with fewer variables it's easier to end up getting stuck in a local minimum ("mountain lake") from which there's no "direction to get out".

It's worth pointing out that in typical cases there are many different collections of weights that will all give neural nets that have pretty much the same performance. And usually in practical neural net training there are lots of random choices made—that lead to "different-but-equivalent solutions", like these:

But each such "different solution" will have at least slightly different behavior. And if we ask, say, for an "extrapolation" outside the region where we gave training examples, we can get dramatically different results:

But which of these is "right"? There's really no way to say. They're all "consistent with the observed data". But they all correspond to different "innate" ways to "think about" what to do "outside the box". And some may seem "more reasonable" to us humans than others.

到目前为止，我们讨论的是那些「已经知道」如何执行特定任务的神经网络。但神经网络之所以有用（在大脑中也可能是这样），在于它们不仅原则上可以执行各种任务，而且还可以通过「示例训练」逐步学会执行这些任务。

当我们制作一个用于区分猫和狗的神经网络时，我们实际上不需要编写一个程序来（例如）显式地找到胡须；相反，我们只需展示大量猫和狗的示例，然后让网络通过「机器学习」来区分它们。

关键在于，经过训练的网络能够「概括」它所展示的特定示例。正如我们上面看到的，网络并不仅仅是识别出它被展示的特定猫图像的像素模式；而是神经网络以某种方式成功地区分了图像，基于我们认为的某种「一般的猫性」。

那么神经网络训练实际上是如何工作的呢？本质上，我们始终在尝试找到让神经网络成功复现我们给出的示例的权重。然后我们依赖于神经网络以一种「合理」的方式在这些示例「之间」进行「插值」（或「概括」）。

让我们看一个比上述最近点问题更简单的问题。让我们尝试让一个神经网络学会以下函数：

对于这个任务，我们需要一个只有一个输入和一个输出的网络，比如：

但我们应该使用哪些权重等呢？对于每一组可能的权重，神经网络都会计算某个函数。例如，以下是它使用一些随机选择的权重集所做的事情：

是的，我们可以清楚地看到，在这些情况中没有一个接近于复现我们想要的函数。那么我们如何找到能够复现该函数的权重呢？

基本思想是提供大量的「输入→输出」示例来「学习」，然后尝试找到能够复现这些示例的权重。以下是使用逐渐增多的示例所做的结果：

在这个「训练」的每个阶段，网络中的权重逐渐调整，并且我们看到最终我们得到了一个成功复现我们想要的函数的网络。那么我们如何调整权重呢？基本思想是在每个阶段看看我们离想要的函数有多远，然后以这样的方式更新权重，以便更接近目标。

为了找出「我们离目标有多远」，我们计算通常称为「损失函数」（或有时称为「成本函数」）的东西。在这里，我们使用一个简单的（L2）损失函数，即我们获得的值与真实值之间差异的平方和。我们看到，随着我们的训练过程的进行，损失函数逐渐减少（遵循特定的「学习曲线」，对于不同的任务是不同的）—— 直到我们达到网络（至少在很好的近似程度上）成功复现我们想要的函数的点：

好的，那么最后一个需要解释的关键部分是如何调整权重以减少损失函数。正如我们所说，损失函数给了我们一个关于我们得到的值与真实值之间的「距离」。但「我们得到的值」在每个阶段都由当前版本的神经网络和其中的权重决定。但现在想象权重是变量 —— 比如说 wi。我们想要找出如何调整这些变量的值以最小化依赖于它们的损失。

例如，想象一下（在实际使用中典型神经网络的难以置信的简化中），我们只有两个权重 w1 和 w2。那么我们可能有一个关于 w1 和 w2 的损失函数，看起来像这样：

数值分析提供了各种技术来找到像这样情况下的最小值。但典型的方法就是逐步跟随从之前的 w1、w2 开始的最陡下降路径：

就像水流下山一样，这个程序保证的只是它最终会在表面的某个局部最小值（山间湖泊）结束；它可能无法达到最终的全局最小值。

找到「权重景观」上的最陡下降路径是否可行并不明显。但微积分来拯救。如上所述，可以一直将神经网络视为计算一个依赖于其输入和权重的数学函数。但现在考虑相对于这些权重求导。事实证明，微积分的链式法则实际上让我们能够「展开」神经网络中连续层的操作。结果是，我们可以 —— 至少在某种局部近似中 ——「反转」神经网络的操作，并逐渐找到最小化与输出相关的损失的权重。

上面的图片展示了我们可能需要在只有 2 个权重的不切实际简单情况下进行的最小化。但事实证明，即使有更多的权重（ChatGPT 使用 1750 亿个），仍然可以进行最小化，至少在某种程度的近似中。实际上，「深度学习」在 2011 年左右发生的重大突破与发现在某种意义上，当涉及许多权重时，进行（至少是近似的）最小化可能比只涉及相对较少的权重时更容易。

换句话说，有点违反直觉地，使用神经网络解决更复杂的问题比解决更简单的问题可能更容易。大致原因似乎是当一个人有很多的「权重变量」时，一个人拥有一个高维空间，其中有「许多不同的方向」可以引导一个人到达最小值 —— 而较少的变量则更容易最终被困在局部最小值（山间湖泊）中，从那里没有「走出去的方向」。

值得指出的是，在典型情况下，有许多不同的权重集合都会给神经网络带来几乎相同的表现。而且在实际神经网络训练中通常会做出许多随机选择 —— 这导致了「不同但等效的解决方案」，如下所示：

但每种「不同的解决方案」至少会有稍微不同的行为。如果我们要求在我们提供训练示例的区域之外的「外推」，我们可能会得到截然不同的结果：

但哪一个是「正确的」？真的没有办法说。它们都是「与观察到的数据一致的」。但它们都对应于不同的「天生的」方式来「思考」如何「走出框架」。有些可能对我们人类来说看起来「更合理」一些。

### 07. The Practice and Lore of Neural Net Training

Particularly over the past decade, there've been many advances in the art of training neural nets. And, yes, it is basically an art. Sometimes—especially in retrospect—one can see at least a glimmer of a "scientific explanation" for something that's being done. But mostly things have been discovered by trial and error, adding ideas and tricks that have progressively built a significant lore about how to work with neural nets.

There are several key parts. First, there's the matter of what architecture of neural net one should use for a particular task. Then there's the critical issue of how one's going to get the data on which to train the neural net. And increasingly one isn't dealing with training a net from scratch: instead a new net can either directly incorporate another already-trained net, or at least can use that net to generate more training examples for itself.

One might have thought that for every particular kind of task one would need a different architecture of neural net. But what's been found is that the same architecture often seems to work even for apparently quite different tasks. At some level this reminds one of the idea of universal computation (and my Principle of Computational Equivalence), but, as I'll discuss later, I think it's more a reflection of the fact that the tasks we're typically trying to get neural nets to do are "human-like" ones—and neural nets can capture quite general "human-like processes".

In earlier days of neural nets, there tended to be the idea that one should "make the neural net do as little as possible". For example, in converting speech to text it was thought that one should first analyze the audio of the speech, break it into phonemes, etc. But what was found is that—at least for "human-like tasks"—it's usually better just to try to train the neural net on the "end-to-end problem", letting it "discover" the necessary intermediate features, encodings, etc. for itself.

There was also the idea that one should introduce complicated individual components into the neural net, to let it in effect "explicitly implement particular algorithmic ideas". But once again, this has mostly turned out not to be worthwhile; instead, it's better just to deal with very simple components and let them "organize themselves" (albeit usually in ways we can't understand) to achieve (presumably) the equivalent of those algorithmic ideas.

That's not to say that there are no "structuring ideas" that are relevant for neural nets. Thus, for example, having 2D arrays of neurons with local connections seems at least very useful in the early stages of processing images. And having patterns of connectivity that concentrate on "looking back in sequences" seems useful—as we'll see later—in dealing with things like human language, for example in ChatGPT.

But an important feature of neural nets is that—like computers in general—they're ultimately just dealing with data. And current neural nets—with current approaches to neural net training—specifically deal with arrays of numbers. But in the course of processing, those arrays can be completely rearranged and reshaped. And as an example, the network we used for identifying digits above starts with a 2D "image-like" array, quickly "thickening" to many channels, but then "concentrating down" into a 1D array that will ultimately contain elements representing the different possible output digits:

But, OK, how can one tell how big a neural net one will need for a particular task? It's something of an art. At some level the key thing is to know "how hard the task is". But for human-like tasks that's typically very hard to estimate. Yes, there may be a systematic way to do the task very "mechanically" by computer. But it's hard to know if there are what one might think of as tricks or shortcuts that allow one to do the task at least at a "human-like level" vastly more easily. It might take enumerating a giant game tree to "mechanically" play a certain game; but there might be a much easier ("heuristic") way to achieve "human-level play".

When one's dealing with tiny neural nets and simple tasks one can sometimes explicitly see that one "can't get there from here". For example, here's the best one seems to be able to do on the task from the previous section with a few small neural nets:

And what we see is that if the net is too small, it just can't reproduce the function we want. But above some size, it has no problem—at least if one trains it for long enough, with enough examples. And, by the way, these pictures illustrate a piece of neural net lore: that one can often get away with a smaller network if there's a "squeeze" in the middle that forces everything to go through a smaller intermediate number of neurons. (It's also worth mentioning that "no-intermediate-layer"—or so-called "perceptron"—networks can only learn essentially linear functions—but as soon as there's even one intermediate layer it's always in principle possible to approximate any function arbitrarily well, at least if one has enough neurons, though to make it feasibly trainable one typically has some kind of regularization or normalization.)

OK, so let's say one's settled on a certain neural net architecture. Now there's the issue of getting data to train the network with. And many of the practical challenges around neural nets—and machine learning in general—center on acquiring or preparing the necessary training data. In many cases ("supervised learning") one wants to get explicit examples of inputs and the outputs one is expecting from them. Thus, for example, one might want images tagged by what's in them, or some other attribute. And maybe one will have to explicitly go through—usually with great effort—and do the tagging. But very often it turns out to be possible to piggyback on something that's already been done, or use it as some kind of proxy. And so, for example, one might use alt tags that have been provided for images on the web. Or, in a different domain, one might use closed captions that have been created for videos. Or—for language translation training—one might use parallel versions of webpages or other documents that exist in different languages.

How much data do you need to show a neural net to train it for a particular task? Again, it's hard to estimate from first principles. Certainly the requirements can be dramatically reduced by using "transfer learning" to "transfer in" things like lists of important features that have already been learned in another network. But generally neural nets need to "see a lot of examples" to train well. And at least for some tasks it's an important piece of neural net lore that the examples can be incredibly repetitive. And indeed it's a standard strategy to just show a neural net all the examples one has, over and over again. In each of these "training rounds" (or "epochs") the neural net will be in at least a slightly different state, and somehow "reminding it" of a particular example is useful in getting it to "remember that example". (And, yes, perhaps this is analogous to the usefulness of repetition in human memorization.)

But often just repeating the same example over and over again isn't enough. It's also necessary to show the neural net variations of the example. And it's a feature of neural net lore that those "data augmentation" variations don't have to be sophisticated to be useful. Just slightly modifying images with basic image processing can make them essentially "as good as new" for neural net training. And, similarly, when one's run out of actual video, etc. for training self-driving cars, one can go on and just get data from running simulations in a model videogame-like environment without all the detail of actual real-world scenes.

How about something like ChatGPT? Well, it has the nice feature that it can do "unsupervised learning", making it much easier to get it examples to train from. Recall that the basic task for ChatGPT is to figure out how to continue a piece of text that it's been given. So to get it "training examples" all one has to do is get a piece of text, and mask out the end of it, and then use this as the "input to train from"—with the "output" being the complete, unmasked piece of text. We'll discuss this more later, but the main point is that—unlike, say, for learning what's in images—there's no "explicit tagging" needed; ChatGPT can in effect just learn directly from whatever examples of text it's given.

OK, so what about the actual learning process in a neural net? In the end it's all about determining what weights will best capture the training examples that have been given. And there are all sorts of detailed choices and "hyperparameter settings" (so called because the weights can be thought of as "parameters") that can be used to tweak how this is done. There are different choices of loss function (sum of squares, sum of absolute values, etc.). There are different ways to do loss minimization (how far in weight space to move at each step, etc.). And then there are questions like how big a "batch" of examples to show to get each successive estimate of the loss one's trying to minimize. And, yes, one can apply machine learning (as we do, for example, in Wolfram Language) to automate machine learning—and to automatically set things like hyperparameters.

But in the end the whole process of training can be characterized by seeing how the loss progressively decreases (as in this Wolfram Language progress monitor for a small training):

And what one typically sees is that the loss decreases for a while, but eventually flattens out at some constant value. If that value is sufficiently small, then the training can be considered successful; otherwise it's probably a sign one should try changing the network architecture.

Can one tell how long it should take for the "learning curve" to flatten out? Like for so many other things, there seem to be approximate power-law scaling relationships that depend on the size of neural net and amount of data one's using. But the general conclusion is that training a neural net is hard—and takes a lot of computational effort. And as a practical matter, the vast majority of that effort is spent doing operations on arrays of numbers, which is what GPUs are good at—which is why neural net training is typically limited by the availability of GPUs.

In the future, will there be fundamentally better ways to train neural nets—or generally do what neural nets do? Almost certainly, I think. The fundamental idea of neural nets is to create a flexible "computing fabric" out of a large number of simple (essentially identical) components—and to have this "fabric" be one that can be incrementally modified to learn from examples. In current neural nets, one's essentially using the ideas of calculus—applied to real numbers—to do that incremental modification. But it's increasingly clear that having high-precision numbers doesn't matter; 8 bits or less might be enough even with current methods.

With computational systems like cellular automata that basically operate in parallel on many individual bits it's never been clear how to do this kind of incremental modification, but there's no reason to think it isn't possible. And in fact, much like with the "deep-learning breakthrough of 2012" it may be that such incremental modification will effectively be easier in more complicated cases than in simple ones.

Neural nets—perhaps a bit like brains—are set up to have an essentially fixed network of neurons, with what's modified being the strength ("weight") of connections between them. (Perhaps in at least young brains significant numbers of wholly new connections can also grow.) But while this might be a convenient setup for biology, it's not at all clear that it's even close to the best way to achieve the functionality we need. And something that involves the equivalent of progressive network rewriting (perhaps reminiscent of our Physics Project) might well ultimately be better.

But even within the framework of existing neural nets there's currently a crucial limitation: neural net training as it's now done is fundamentally sequential, with the effects of each batch of examples being propagated back to update the weights. And indeed with current computer hardware—even taking into account GPUs—most of a neural net is "idle" most of the time during training, with just one part at a time being updated. And in a sense this is because our current computers tend to have memory that is separate from their CPUs (or GPUs). But in brains it's presumably different—with every "memory element" (i.e. neuron) also being a potentially active computational element. And if we could set up our future computer hardware this way it might become possible to do training much more efficiently.

在过去的十年中，神经网络训练领域取得了许多进展。而且，是的，这基本上是一门艺术。有时 —— 尤其是事后看来 —— 可以看到某些正在进行的事情至少有一丝「科学解释」的曙光。但大多数情况下，这些都是通过试错发现的，逐渐增加的想法和技巧构建了一套关于如何使用神经网络的重要知识。

其中有几个关键部分。首先，对于特定任务应该使用哪种架构的神经网络。然后是如何获得用于训练神经网络的数据这一关键问题。而且越来越多的情况下，我们不是在从零开始训练一个网络，而是新网络可以直接整合另一个已经训练好的网络，或至少可以使用那个网络为自己生成更多训练示例。

人们可能曾经认为对于每一种特定类型的任务都需要不同架构的神经网络。但发现的是，即使对于看起来相当不同的任务，同样的架构似乎也经常有效。在某种程度上，这让人想起通用计算的概念（以及我的计算等价原理），但正如我稍后将讨论的，我认为这更多地反映了我们通常试图让神经网络执行的任务是「类人」的这一事实 —— 神经网络可以捕捉相当通用的「类人过程」。

在神经网络的早期发展中，人们倾向于认为应该「让神经网络尽可能少做事」。例如，在将语音转换为文本时，人们认为应该首先分析语音的音频，将其分解为音素等。但发现的是，至少对于「类人任务」，通常最好只是尝试在「端到端问题」上训练神经网络，让它自己「发现」必要的中间特征、编码等。

还有一种想法是，应该在神经网络中引入复杂的单个组件，以便让它实际上「显式实现特定的算法思想」。但再次，这大多数时候被证明是不值得的；相反，最好只是处理非常简单的组件，并让它们「自行组织」（尽管通常以我们无法理解的方式），以实现（可能）那些算法思想的等效物。

这并不是说没有与神经网络相关的「结构化思想」。因此，例如，在处理图像的早期阶段，具有 2D 神经元阵列和局部连接似乎至少非常有用。而且，拥有集中于「在序列中向后看」的连接模式似乎有用 —— 正如我们稍后将看到的，在处理诸如 ChatGPT 中的人类语言等事物时。

神经网络的一个重要特点是，就像计算机一般，它们最终只是处理数据。目前的神经网络 —— 以及当前的神经网络训练方法 —— 特别是处理数字数组。但在处理过程中，这些数组可以被完全重排和重塑。例如，我们用于识别数字的网络开始时使用的是一个类似于图像的 2D 数组，很快「加厚」成多个通道，但随后「浓缩」成一个 1D 数组，这个数组最终将包含表示不同可能输出数字的元素：

但好吧，如何判断执行特定任务需要多大的神经网络呢？这有点像艺术。在某种程度上，关键是知道「任务有多难」。但对于类人的任务来说，这通常很难估计。是的，可能存在一种非常「机械化」的系统方法来用计算机执行任务。但很难知道是否有人可能认为的技巧或捷径，允许人们以至少「类人水平」的方式更容易地执行任务。机械地列举一个巨大的游戏树来玩某个游戏可能很耗时；但可能有一种更简单的（启发式）方法来实现「人类水平的游戏」。

当处理微型神经网络和简单任务时，有时可以明确看到「无法从这里到达那里」。例如，以下是在上一节中的任务上使用几个小型神经网络所能做到的最好情况：

我们看到的是，如果网络太小，它就无法复现我们想要的函数。但只要超过某个大小，它就没有问题 —— 至少如果训练足够长时间，有足够多的示例。顺便说一句，这些图片展示了神经网络的一个经验：如果中间有一个「挤压」部分，迫使所有东西通过较少的中间神经元，那么通常可以使用较小的网络。（还值得一提的是，「无中间层」—— 或所谓的「感知器」—— 网络只能学习基本上线性的函数，但只要有一个中间层，理论上总是可能任意好地近似任何函数，至少如果有足够多的神经元，尽管为了使其易于训练，通常需要某种形式的正则化或归一化。）

好的，假设已经确定了某种神经网络架构。现在就是获取用于训练网络的数据的问题。围绕神经网络和机器学习的许多实际挑战都集中在获取或准备所需的训练数据上。在许多情况下（有监督学习），人们希望获得输入及其期望输出的明确示例。因此，例如，可能需要通过标记来标识图像中的内容或其他属性。而且可能不得不明确地经过大量努力进行标记。但很多时候，似乎可以依靠已经完成的工作，或将其作为某种代理。因此，例如，可以使用为网络上的图像提供的替代文本。或者，在不同领域，可能使用为视频创建的字幕。或者，对于语言翻译训练，可以使用以不同语言存在的网页或其他文档的平行版本。

要训练神经网络执行特定任务，需要向其展示多少数据？再次强调，从基本原理出发很难估计。当然，通过使用「迁移学习」将例如已在另一个网络中学到的重要特征列表「迁移进来」，可以显著减少所需数据量。但通常神经网络需要「看到大量示例」才能训练得好。至少对于某些任务而言，重要的神经网络知识是示例可以极其重复。实际上，反复向神经网络展示所有拥有的示例是一种标准策略。在这些「训练轮次」（或「迭代」）中，神经网络至少会处于略有不同的状态，而以某种方式「提醒」它特定示例对于让其「记住该示例」是有用的。（是的，这可能类似于重复在人类记忆中的用处。）

但仅仅反复重复相同的示例并不够。还需要向神经网络展示示例的变体。神经网络知识的一个特点是，这些「数据增强」变体不必复杂就能有用。通过基本的图像处理技术稍微修改图像，可以使它们对神经网络训练来说基本上「就像新的」一样。同样，当为训练自动驾驶汽车耗尽实际视频等资源时，可以继续从模型视频游戏环境中运行模拟获得数据，而不需要实际现实世界场景中的所有细节。

像 ChatGPT 这样的系统呢？它具有可以进行「无监督学习」的优点，使得从中获取训练示例变得更容易。回想一下，ChatGPT 的基本任务是找出如何继续已给出的文本。因此，为了获取「训练示例」，所有需要做的就是获取一段文本，然后屏蔽掉它的结尾，然后将这个用作「训练输入」——「输出」则是完整的、未屏蔽的文本。我们稍后将更多讨论这一点，但主要是，与例如学习图像中的内容不同，不需要「显式标记」；ChatGPT 实际上可以直接从给定的任何文本示例中学习。

那么，神经网络中的实际学习过程呢？最终，这一切都是关于确定最能捕获所给训练示例的权重。存在各种详细的选择和「超参数设置」（因为权重可以被视为「参数」），这些可以用来调整这一过程。有不同的损失函数选择（平方和、绝对值和等）。有不同的损失最小化方法（每一步在权重空间中移动多远等）。然后还有问题，比如要展示多大一批示例才能获得连续估计所要最小化的损失。而且，是的，可以应用机器学习（例如我们在 Wolfram 语言中所做的那样）来自动化机器学习，并自动设置像超参数这样的东西。

但最终，整个训练过程可以通过观察损失如何逐渐减少来表征（如 Wolfram 语言中这个小型训练的进度监控所示）：

我们通常看到的是，损失会降低一段时间，但最终会在某个常数值处趋于平稳。如果该值足够小，那么训练可以被认为是成功的；否则，这可能是一个信号，表明应该尝试更改网络架构。

能否判断「学习曲线」变平需要多长时间？像许多其他事情一样，似乎存在大致的幂律缩放关系，这取决于神经网络的大小和使用的数据量。但总的结论是，训练神经网络是困难的，并且需要大量的计算工作。而且在实际操作中，绝大多数工作是在对数字数组进行操作，这是 GPU 擅长的 —— 这就是为什么神经网络训练通常受到 GPU 可用性的限制。

将来是否会有更好的方法来训练神经网络，或通常做神经网络所做的事情？我认为几乎可以肯定。神经网络的基本思想是使用大量简单（基本相同）的组件创建一个灵活的「计算织物」，并使这种「织物」能够逐渐修改以从示例中学习。在当前的神经网络中，人们基本上是使用微积分的思想 —— 应用于实数 —— 来进行这种逐步修改。但越来越清楚的是，高精度的数字并不重要；即使使用当前方法，8 位或更少可能就足够了。

对于像元胞自动机这样的计算系统，它们基本上并行地在许多单独的位上操作，从来不清楚如何做到这种逐步修改，但没有理由认为这是不可能的。实际上，就像「2012 年的深度学习突破」一样，这种逐步修改在更复杂的情况下可能比简单情况下更容易实现。

神经网络 —— 可能有点像大脑 —— 被设置为具有基本固定的神经元网络，所修改的是它们之间连接的强度（权重）。（至少在年轻的大脑中，可能也会生长大量全新的连接。）但虽然这对于生物学来说可能是一个方便的设置，但目前还不清楚这是否接近于实现我们需要的功能的最佳方式。涉及逐渐网络重写的某种东西（可能让人想起我们的物理项目）最终可能会更好。

但即使在现有神经网络的框架内，目前也存在一个关键的限制：目前所做的神经网络训练基本上是顺序的，每一批示例的效果都被传递回来更新权重。实际上，即使考虑到 GPU，大部分神经网络在训练期间大部分时间都是「闲置」的，一次只更新一部分。在某种意义上，这是因为我们当前的计算机倾向于拥有与它们的 CPU（或 GPU）分离的内存。但在大脑中可能就不同了 —— 每个「记忆元素」（即神经元）也是一个潜在的主动计算元素。如果我们能够以这种方式设置我们未来的计算机硬件，可能会变得更加高效地进行训练。

### 08. Surely a Network That's Big Enough Can Do Anything!

The capabilities of something like ChatGPT seem so impressive that one might imagine that if one could just "keep going" and train larger and larger neural networks, then they'd eventually be able to "do everything". And if one's concerned with things that are readily accessible to immediate human thinking, it's quite possible that this is the case. But the lesson of the past several hundred years of science is that there are things that can be figured out by formal processes, but aren't readily accessible to immediate human thinking.

Nontrivial mathematics is one big example. But the general case is really computation. And ultimately the issue is the phenomenon of computational irreducibility. There are some computations which one might think would take many steps to do, but which can in fact be "reduced" to something quite immediate. But the discovery of computational irreducibility implies that this doesn't always work. And instead there are processes—probably like the one below—where to work out what happens inevitably requires essentially tracing each computational step:

The kinds of things that we normally do with our brains are presumably specifically chosen to avoid computational irreducibility. It takes special effort to do math in one's brain. And it's in practice largely impossible to "think through" the steps in the operation of any nontrivial program just in one's brain.

But of course for that we have computers. And with computers we can readily do long, computationally irreducible things. And the key point is that there's in general no shortcut for these.

Yes, we could memorize lots of specific examples of what happens in some particular computational system. And maybe we could even see some ("computationally reducible") patterns that would allow us to do a little generalization. But the point is that computational irreducibility means that we can never guarantee that the unexpected won't happen—and it's only by explicitly doing the computation that you can tell what actually happens in any particular case.

And in the end there's just a fundamental tension between learnability and computational irreducibility. Learning involves in effect compressing data by leveraging regularities. But computational irreducibility implies that ultimately there's a limit to what regularities there may be.

As a practical matter, one can imagine building little computational devices—like cellular automata or Turing machines—into trainable systems like neural nets. And indeed such devices can serve as good "tools" for the neural net—like Wolfram|Alpha can be a good tool for ChatGPT. But computational irreducibility implies that one can't expect to "get inside" those devices and have them learn.

Or put another way, there's an ultimate tradeoff between capability and trainability: the more you want a system to make "true use" of its computational capabilities, the more it's going to show computational irreducibility, and the less it's going to be trainable. And the more it's fundamentally trainable, the less it's going to be able to do sophisticated computation.

(For ChatGPT as it currently is, the situation is actually much more extreme, because the neural net used to generate each token of output is a pure "feed-forward" network, without loops, and therefore has no ability to do any kind of computation with nontrivial "control flow".)

Of course, one might wonder whether it's actually important to be able to do irreducible computations. And indeed for much of human history it wasn't particularly important. But our modern technological world has been built on engineering that makes use of at least mathematical computations—and increasingly also more general computations. And if we look at the natural world, it's full of irreducible computation—that we're slowly understanding how to emulate and use for our technological purposes.

Yes, a neural net can certainly notice the kinds of regularities in the natural world that we might also readily notice with "unaided human thinking". But if we want to work out things that are in the purview of mathematical or computational science the neural net isn't going to be able to do it—unless it effectively "uses as a tool" an "ordinary" computational system.

But there's something potentially confusing about all of this. In the past there were plenty of tasks—including writing essays—that we've assumed were somehow "fundamentally too hard" for computers. And now that we see them done by the likes of ChatGPT we tend to suddenly think that computers must have become vastly more powerful—in particular surpassing things they were already basically able to do (like progressively computing the behavior of computational systems like cellular automata).

But this isn't the right conclusion to draw. Computationally irreducible processes are still computationally irreducible, and are still fundamentally hard for computers—even if computers can readily compute their individual steps. And instead what we should conclude is that tasks—like writing essays—that we humans could do, but we didn't think computers could do, are actually in some sense computationally easier than we thought.

In other words, the reason a neural net can be successful in writing an essay is because writing an essay turns out to be a "computationally shallower" problem than we thought. And in a sense this takes us closer to "having a theory" of how we humans manage to do things like writing essays, or in general deal with language.

If you had a big enough neural net then, yes, you might be able to do whatever humans can readily do. But you wouldn't capture what the natural world in general can do—or that the tools that we've fashioned from the natural world can do. And it's the use of those tools—both practical and conceptual—that have allowed us in recent centuries to transcend the boundaries of what's accessible to "pure unaided human thought", and capture for human purposes more of what's out there in the physical and computational universe.

确实，像 ChatGPT 这样的系统看起来如此令人印象深刻，以至于人们可能会想象，如果只是继续训练越来越大的神经网络，那么它们最终可能会「做到一切」。如果关注的是人类直接思维容易接触到的事物，这可能是有可能的。但过去几百年的科学教训表明，有些东西可以通过形式化过程来解决，但并不容易被直接的人类思维所理解。

非平凡的数学是一个很大的例子。但一般情况实际上是计算。最终的问题是计算不可约简性的现象。有些计算可能看起来需要很多步骤，但实际上可以被「简化」为一些相当直接的东西。但计算不可约简性的发现表明，这并不总是有效。相反，有些过程 —— 可能像下面所示 —— 要弄清楚发生了什么，不可避免地需要实际追踪每一个计算步骤：

我们大脑通常做的那些事情，可能是特意避免计算不可约简性的。在大脑中做数学需要特别的努力。而在实践中，仅凭大脑「思考」任何非平凡程序的操作步骤几乎是不可能的。

但当然，为此我们有计算机。有了计算机，我们可以轻松地做长时间、计算上不可约简的事情。关键点是，这些事情通常没有捷径。

是的，我们可以记住在某个特定计算系统中发生的许多具体示例。也许我们甚至可以看到一些（计算上可约简的）模式，让我们能做一些概括。但关键是，计算不可约简性意味着我们永远无法保证意外不会发生 —— 只有通过显式地做计算，你才能知道在任何特定情况下实际发生了什么。

归根结底，学习性和计算不可约简性之间存在着根本的张力。学习实际上涉及通过利用规律性来压缩数据。但计算不可约简性意味着最终存在着可能存在的规律性的限制。

就实际情况而言，人们可以想象将小型计算设备 —— 如元胞自动机或图灵机 —— 嵌入到像神经网络这样的可训练系统中。实际上，这样的设备可以作为神经网络的好「工具」，就像 Wolfram|Alpha 可以成为 ChatGPT 的好工具一样。但计算不可约简性意味着人们不能期望「深入」这些设备并让它们学习。

换句话说，存在着能力和可训练性之间的终极权衡：你希望一个系统越多地「真正利用」其计算能力，它就越会表现出计算不可约简性，从而越难以训练。而它越是基本上可训练的，它就越难以进行复杂计算。

对于目前的 ChatGPT 而言，情况实际上更加极端，因为用于生成每个输出标记的神经网络是一个纯粹的「前馈」网络，没有循环，因此无法执行具有非平凡「控制流」的任何类型的计算。

当然，人们可能会怀疑进行不可约简计算的能力是否真的重要。的确，在人类历史的大部分时间里，这并不特别重要。但我们现代的技术世界是建立在至少使用数学计算的工程基础上的 —— 并且越来越多地使用更通用的计算。如果我们观察自然世界，它充满了不可约简的计算 —— 我们正在慢慢地了解如何模仿和用于我们的技术目的。

是的，神经网络当然可以注意到自然世界中的规律性，这些规律性我们也可能通过「未辅助的人类思维」轻易地注意到。但如果我们想要弄清楚数学或计算科学范围内的事物，神经网络是无法做到的 —— 除非它有效地「作为工具使用」一个「普通」的计算系统。

但所有这些都有一些可能令人困惑的地方。在过去，包括写作文在内的许多任务，我们认为它们在某种程度上是「对于计算机来说根本太难了」。现在我们看到像 ChatGPT 这样的系统完成了这些任务，我们往往会突然认为计算机必须已经变得强大得多 —— 特别是超越了它们已经基本能够做到的事情（如逐步计算像元胞自动机这样的计算系统的行为）。

但这不是我们应该得出的结论。计算上不可约简的过程仍然是计算上不可约简的，对计算机来说仍然是根本性的困难 —— 即使计算机可以轻松地计算它们的单个步骤。相反，我们应该得出的结论是，像写作文这样的任务 —— 我们人类可以做，但我们认为计算机做不到的任务，实际上在某种意义上比我们想象的计算上更简单。

换句话说，神经网络能够成功写作文的原因是因为写作文事实证明是一个比我们想象的「计算上更浅」的问题。在某种意义上，这让我们更接近于「拥有一个理论」，了解我们人类是如何做到像写作文这样的事情，或者总体上处理语言的。

如果你有足够大的神经网络，是的，你可能能够做任何人类可以轻松做到的事情。但你不会捕捉到自然界一般能够做到的事情 —— 或者我们从自然界中塑造的工具能够做到的事情。正是使用这些工具 —— 无论是实用的还是概念上的 —— 使我们在近几个世纪超越了「纯粹未辅助人类思维」所能接触到的界限，为人类目的捕捉了更多存在于物理和计算宇宙中的东西。

### 09. The Concept of Embeddings

Neural nets—at least as they're currently set up—are fundamentally based on numbers. So if we're going to to use them to work on something like text we'll need a way to represent our text with numbers. And certainly we could start (essentially as ChatGPT does) by just assigning a number to every word in the dictionary. But there's an important idea—that's for example central to ChatGPT—that goes beyond that. And it's the idea of "embeddings". One can think of an embedding as a way to try to represent the "essence" of something by an array of numbers—with the property that "nearby things" are represented by nearby numbers.

And so, for example, we can think of a word embedding as trying to lay out words in a kind of "meaning space" in which words that are somehow "nearby in meaning" appear nearby in the embedding. The actual embeddings that are used—say in ChatGPT—tend to involve large lists of numbers. But if we project down to 2D, we can show examples of how words are laid out by the embedding:

And, yes, what we see does remarkably well in capturing typical everyday impressions. But how can we construct such an embedding? Roughly the idea is to look at large amounts of text (here 5 billion words from the web) and then see "how similar" the "environments" are in which different words appear. So, for example, "alligator" and "crocodile" will often appear almost interchangeably in otherwise similar sentences, and that means they'll be placed nearby in the embedding. But "turnip" and "eagle" won't tend to appear in otherwise similar sentences, so they'll be placed far apart in the embedding.

But how does one actually implement something like this using neural nets? Let's start by talking about embeddings not for words, but for images. We want to find some way to characterize images by lists of numbers in such a way that "images we consider similar" are assigned similar lists of numbers.

How do we tell if we should "consider images similar"? Well, if our images are, say, of handwritten digits we might "consider two images similar" if they are of the same digit. Earlier we discussed a neural net that was trained to recognize handwritten digits. And we can think of this neural net as being set up so that in its final output it puts images into 10 different bins, one for each digit.

But what if we "intercept" what's going on inside the neural net before the final "it's a ‘4'" decision is made? We might expect that inside the neural net there are numbers that characterize images as being "mostly 4-like but a bit 2-like" or some such. And the idea is to pick up such numbers to use as elements in an embedding.

So here's the concept. Rather than directly trying to characterize "what image is near what other image", we instead consider a well-defined task (in this case digit recognition) for which we can get explicit training data—then use the fact that in doing this task the neural net implicitly has to make what amount to "nearness decisions". So instead of us ever explicitly having to talk about "nearness of images" we're just talking about the concrete question of what digit an image represents, and then we're "leaving it to the neural net" to implicitly determine what that implies about "nearness of images".

So how in more detail does this work for the digit recognition network? We can think of the network as consisting of 11 successive layers, that we might summarize iconically like this (with activation functions shown as separate layers):

At the beginning we're feeding into the first layer actual images, represented by 2D arrays of pixel values. And at the end—from the last layer—we're getting out an array of 10 values, which we can think of saying "how certain" the network is that the image corresponds to each of the digits 0 through 9.

Feed in the image and the values of the neurons in that last layer are:

In other words, the neural net is by this point "incredibly certain" that this image is a 4—and to actually get the output "4" we just have to pick out the position of the neuron with the largest value.

But what if we look one step earlier? The very last operation in the network is a so-called softmax which tries to "force certainty". But before that's been applied the values of the neurons are:

The neuron representing "4" still has the highest numerical value. But there's also information in the values of the other neurons. And we can expect that this list of numbers can in a sense be used to characterize the "essence" of the image—and thus to provide something we can use as an embedding. And so, for example, each of the 4's here has a slightly different "signature" (or "feature embedding")—all very different from the 8's:

Here we're essentially using 10 numbers to characterize our images. But it's often better to use much more than that. And for example in our digit recognition network we can get an array of 500 numbers by tapping into the preceding layer. And this is probably a reasonable array to use as an "image embedding".

If we want to make an explicit visualization of "image space" for handwritten digits we need to "reduce the dimension", effectively by projecting the 500-dimensional vector we've got into, say, 3D space:

We've just talked about creating a characterization (and thus embedding) for images based effectively on identifying the similarity of images by determining whether (according to our training set) they correspond to the same handwritten digit. And we can do the same thing much more generally for images if we have a training set that identifies, say, which of 5000 common types of object (cat, dog, chair, …) each image is of. And in this way we can make an image embedding that's "anchored" by our identification of common objects, but then "generalizes around that" according to the behavior of the neural net. And the point is that insofar as that behavior aligns with how we humans perceive and interpret images, this will end up being an embedding that "seems right to us", and is useful in practice in doing "human-judgement-like" tasks.

OK, so how do we follow the same kind of approach to find embeddings for words? The key is to start from a task about words for which we can readily do training. And the standard such task is "word prediction". Imagine we're given "the ___ cat". Based on a large corpus of text (say, the text content of the web), what are the probabilities for different words that might "fill in the blank"? Or, alternatively, given "___ black ___" what are the probabilities for different "flanking words"?

How do we set this problem up for a neural net? Ultimately we have to formulate everything in terms of numbers. And one way to do this is just to assign a unique number to each of the 50,000 or so common words in English. So, for example, "the" might be 914, and " cat" (with a space before it) might be 3542. (And these are the actual numbers used by GPT-2.) So for the "the ___ cat" problem, our input might be {914, 3542}. What should the output be like? Well, it should be a list of 50,000 or so numbers that effectively give the probabilities for each of the possible "fill-in" words. And once again, to find an embedding, we want to "intercept" the "insides" of the neural net just before it "reaches its conclusion"—and then pick up the list of numbers that occur there, and that we can think of as "characterizing each word".

OK, so what do those characterizations look like? Over the past 10 years there've been a sequence of different systems developed (word2vec, GloVe, BERT, GPT, …), each based on a different neural net approach. But ultimately all of them take words and characterize them by lists of hundreds to thousands of numbers.

In their raw form, these "embedding vectors" are quite uninformative. For example, here's what GPT-2 produces as the raw embedding vectors for three specific words:

If we do things like measure distances between these vectors, then we can find things like "nearnesses" of words. Later we'll discuss in more detail what we might consider the "cognitive" significance of such embeddings. But for now the main point is that we have a way to usefully turn words into "neural-net-friendly" collections of numbers.

But actually we can go further than just characterizing words by collections of numbers; we can also do this for sequences of words, or indeed whole blocks of text. And inside ChatGPT that's how it's dealing with things. It takes the text it's got so far, and generates an embedding vector to represent it. Then its goal is to find the probabilities for different words that might occur next. And it represents its answer for this as a list of numbers that essentially give the probabilities for each of the 50,000 or so possible words.

(Strictly, ChatGPT does not deal with words, but rather with "tokens"—convenient linguistic units that might be whole words, or might just be pieces like "pre" or "ing" or "ized". Working with tokens makes it easier for ChatGPT to handle rare, compound and non-English words, and, sometimes, for better or worse, to invent new words.)

神经网络 —— 至少在目前的设置中 —— 基本上是基于数字的。因此，如果我们要使用它们来处理像文本这样的东西，我们需要一种用数字表示文本的方法。当然，我们可以开始（基本上就像 ChatGPT 所做的）为字典中的每个单词分配一个数字。但有一个重要的概念 —— 例如对于 ChatGPT 至关重要 —— 超越了这一点。这就是「嵌入」（embeddings）的概念。可以将嵌入视为一种尝试通过数字数组来表示某物的「本质」的方式 —— 具有这样的特性：「邻近的事物」由邻近的数字表示。

例如，我们可以将单词嵌入视为试图在某种「意义空间」中布局单词，其中在意义上「相近」的单词在嵌入中也相近。实际上在 ChatGPT 中使用的嵌入往往涉及大量的数字。但如果我们投影到 2D，我们可以展示单词在嵌入中的布局示例：

的确，我们看到的确实很好地捕捉了典型的日常印象。但我们如何构建这样的嵌入呢？大致的想法是查看大量的文本（这里是来自网络的 50 亿个单词），然后看看不同单词出现的「环境」有多「相似」。例如，「鳄鱼」和「鳄鱼」通常会在其他相似的句子中几乎可互换地出现，这意味着它们将在嵌入中被放置在附近。但「萝卜」和「鹰」不会倾向于出现在其他相似的句子中，因此它们将在嵌入中被放置得很远。

但我们如何实际使用神经网络来实现这样的事情呢？让我们从讨论图像的嵌入而不是单词的嵌入开始。我们想要找到一种方式来用数字列表来描述图像，以便「我们认为相似的图像」被分配给相似的数字列表。

我们如何判断是否应该「认为图像相似」？好吧，如果我们的图像是手写数字，我们可能会「认为两个图像相似」，如果它们是同一个数字。之前我们讨论了一个被训练来识别手写数字的神经网络。我们可以将这个神经网络看作是设置成在最终输出中将图像分成 10 个不同的箱子，每个数字一个。

但如果我们在做出「它是‘4'」的最终决定之前「截获」神经网络内部正在发生的事情呢？我们可能期望神经网络内部有一些数字，将图像描述为「主要像 4 但有点像 2」或类似的东西。想法是捕捉这样的数字来用作嵌入中的元素。

所以这是概念。我们不是直接试图描述「哪个图像靠近哪个图像」，而是考虑一个明确定义的任务（在这种情况下是数字识别），我们可以获得明确的训练数据 —— 然后利用神经网络在执行此任务时隐含地必须做出的相当于「接近决策」。因此，我们不必明确讨论「图像的接近性」，我们只是讨论图像表示什么数字这个具体问题，然后「让神经网络来决定」这对「图像的接近性」意味着什么。

对于数字识别网络，这个过程如何更详细地工作呢？我们可以将网络视为由 11 个连续层组成，可以象征性地总结如下（将激活函数显示为单独的层）：

一开始，我们向第一层输入实际图像，由 2D 像素值数组表示。在最后一层，我们得到一个包含 10 个值的数组，我们可以认为这表示网络对图像对应于数字 0 到 9 的「确定程度」。

输入图像后，最后一层神经元的值是：

换句话说，此时神经网络「非常确定」这个图像是 4 —— 要实际得到输出「4」，我们只需找出数值最大的神经元的位置。

但如果我们再往前看一步呢？网络中的最后一个操作是所谓的 softmax，它试图「强制确定性」。但在应用 softmax 之前，神经元的值是：

代表「4」的神经元仍然具有最高的数值。但其他神经元的值中也包含信息。我们可以期望这个数字列表在某种意义上可以用来表征图像的「本质」，因此可以提供我们可以用作嵌入的东西。因此，例如，这里的每个 4 都有一个略微不同的「签名」（或「特征嵌入」）—— 与 8 的完全不同：

这里我们本质上使用 10 个数字来表征我们的图像。但通常使用的数字远不止这些。例如，在我们的数字识别网络中，我们可以通过访问前一层获得 500 个数字的数组。这可能是作为「图像嵌入」的合理数组。

如果我们想对手写数字的「图像空间」进行显式可视化，我们需要「降低维度」，有效地将我们获得的 500 维向量投影到比如说 3D 空间中：

我们刚刚讨论了如何基于识别图像的相似性（根据我们的训练集，确定它们是否对应于同一个手写数字）来为图像创建表征（因此嵌入）。如果我们有一个识别图像属于哪种常见物体类型（猫、狗、椅子等 5000 种类型之一）的训练集，我们可以对图像进行更广泛的相同处理。通过这种方式，我们可以创建一个以我们对常见物体的识别为「锚点」的图像嵌入，然后根据神经网络的行为进行「概括」。重点是，只要这种行为与我们人类感知和解释图像的方式一致，这将成为一个对我们来说「看起来合理」的嵌入，并在实际中执行「类似人类判断」的任务时有用。

那么，我们如何采用类似的方法来找到单词的嵌入呢？关键是从一个我们可以轻松进行训练的关于单词的任务开始。标准的这种任务是「单词预测」。假设我们得到「the ___ cat」。基于大量文本（比如网络的文本内容），填补空白的不同单词的概率是多少？或者，给定「___ black ___」，不同的「两边单词」的概率是多少？

我们如何为神经网络设置这个问题？最终我们必须用数字来表达一切。一种方法是为英语中大约 50,000 个常用单词中的每一个分配一个唯一的数字。例如，「the」可能是 914，「cat」（前面有一个空格）可能是 3542。（这些是 GPT-2 实际使用的数字。）所以对于「the ___ cat」问题，我们的输入可能是 {914, 3542}。输出应该是什么样的？好吧，它应该是一个包含大约 50,000 个数字的列表，这些数字有效地给出了每个可能的「填空」单词的概率。再次，为了找到嵌入，我们希望「截取」神经网络的「内部」，就在它「得出结论」之前 —— 然后捕获在那里出现的数字列表，我们可以将其视为「表征每个单词」。

那么这些表征看起来是什么样的呢？在过去的 10 年中，已经开发了一系列不同的系统（word2vec、GloVe、BERT、GPT 等），每个系统都基于不同的神经网络方法。但最终，它们都采用单词，并通过数百到数千个数字的列表对其进行表征。

这些「嵌入向量」的原始形式相当不具信息性。例如，以下是 GPT-2 为三个特定单词生成的原始嵌入向量：

如果我们做诸如测量这些向量之间的距离之类的事情，那么我们可以发现诸如单词的「接近性」。稍后我们将更详细地讨论这些嵌入的「认知」意义。但现在的主要观点是，我们有一种将单词有效地转换为「神经网络友好」的数字集合的方法。

但实际上，我们可以做的不仅仅是通过数字集合来表征单词；我们还可以这样做序列的单词，甚至整个文本块。在 ChatGPT 内部，它就是这样处理事情的。它采用到目前为止的文本，并生成一个嵌入向量来表示它。然后它的目标是找到不同单词接下来出现的概率。它以一个数字列表表示其答案，这些数字基本上给出了大约 50,000 个可能单词中每一个的概率。

（严格来说，ChatGPT 并不处理单词，而是处理「词元」—— 方便的语言单位，可能是完整的单词，也可能只是像「pre」或「ing」或「ized」这样的片段。使用词元使 ChatGPT 更容易处理罕见、复合和非英语单词，并且有时，无论好坏，都可以创造新单词。）

### 10. Inside ChatGPT

OK, so we're finally ready to discuss what's inside ChatGPT. And, yes, ultimately, it's a giant neural net—currently a version of the so-called GPT-3 network with 175 billion weights. In many ways this is a neural net very much like the other ones we've discussed. But it's a neural net that's particularly set up for dealing with language. And its most notable feature is a piece of neural net architecture called a "transformer".

In the first neural nets we discussed above, every neuron at any given layer was basically connected (at least with some weight) to every neuron on the layer before. But this kind of fully connected network is (presumably) overkill if one's working with data that has particular, known structure. And thus, for example, in the early stages of dealing with images, it's typical to use so-called convolutional neural nets ("convnets") in which neurons are effectively laid out on a grid analogous to the pixels in the image—and connected only to neurons nearby on the grid.

The idea of transformers is to do something at least somewhat similar for sequences of tokens that make up a piece of text. But instead of just defining a fixed region in the sequence over which there can be connections, transformers instead introduce the notion of "attention"—and the idea of "paying attention" more to some parts of the sequence than others. Maybe one day it'll make sense to just start a generic neural net and do all customization through training. But at least as of now it seems to be critical in practice to "modularize" things—as transformers do, and probably as our brains also do.

OK, so what does ChatGPT (or, rather, the GPT-3 network on which it's based) actually do? Recall that its overall goal is to continue text in a "reasonable" way, based on what it's seen from the training it's had (which consists in looking at billions of pages of text from the web, etc.) So at any given point, it's got a certain amount of text—and its goal is to come up with an appropriate choice for the next token to add.

It operates in three basic stages. First, it takes the sequence of tokens that corresponds to the text so far, and finds an embedding (i.e. an array of numbers) that represents these. Then it operates on this embedding—in a "standard neural net way", with values "rippling through" successive layers in a network—to produce a new embedding (i.e. a new array of numbers). It then takes the last part of this array and generates from it an array of about 50,000 values that turn into probabilities for different possible next tokens. (And, yes, it so happens that there are about the same number of tokens used as there are common words in English, though only about 3000 of the tokens are whole words, and the rest are fragments.)

A critical point is that every part of this pipeline is implemented by a neural network, whose weights are determined by end-to-end training of the network. In other words, in effect nothing except the overall architecture is "explicitly engineered"; everything is just "learned" from training data.

There are, however, plenty of details in the way the architecture is set up—reflecting all sorts of experience and neural net lore. And—even though this is definitely going into the weeds—I think it's useful to talk about some of those details, not least to get a sense of just what goes into building something like ChatGPT.

First comes the embedding module. Here's a schematic Wolfram Language representation for it for GPT-2:

The input is a vector of n tokens (represented as in the previous section by integers from 1 to about 50,000). Each of these tokens is converted (by a single-layer neural net) into an embedding vector (of length 768 for GPT-2 and 12,288 for ChatGPT's GPT-3). Meanwhile, there's a "secondary pathway" that takes the sequence of (integer) positions for the tokens, and from these integers creates another embedding vector. And finally the embedding vectors from the token value and the token position are added together—to produce the final sequence of embedding vectors from the embedding module.

Why does one just add the token-value and token-position embedding vectors together? I don't think there's any particular science to this. It's just that various different things have been tried, and this is one that seems to work. And it's part of the lore of neural nets that—in some sense—so long as the setup one has is "roughly right" it's usually possible to home in on details just by doing sufficient training, without ever really needing to "understand at an engineering level" quite how the neural net has ended up configuring itself.

Here's what the embedding module does, operating on the string hello hello hello hello hello hello hello hello hello hello bye bye bye bye bye bye bye bye bye bye:

The elements of the embedding vector for each token are shown down the page, and across the page we see first a run of "hello" embeddings, followed by a run of "bye" ones. The second array above is the positional embedding—with its somewhat-random-looking structure being just what "happened to be learned" (in this case in GPT-2).

OK, so after the embedding module comes the "main event" of the transformer: a sequence of so-called "attention blocks" (12 for GPT-2, 96 for ChatGPT's GPT-3). It's all pretty complicated—and reminiscent of typical large hard-to-understand engineering systems, or, for that matter, biological systems. But anyway, here's a schematic representation of a single "attention block" (for GPT-2):

Within each such attention block there are a collection of "attention heads" (12 for GPT-2, 96 for ChatGPT's GPT-3)—each of which operates independently on different chunks of values in the embedding vector. (And, yes, we don't know any particular reason why it's a good idea to split up the embedding vector, or what the different parts of it "mean"; this is just one of those things that's been "found to work".)

OK, so what do the attention heads do? Basically they're a way of "looking back" in the sequence of tokens (i.e. in the text produced so far), and "packaging up the past" in a form that's useful for finding the next token. In the first section above we talked about using 2-gram probabilities to pick words based on their immediate predecessors. What the "attention" mechanism in transformers does is to allow "attention to" even much earlier words—thus potentially capturing the way, say, verbs can refer to nouns that appear many words before them in a sentence.

At a more detailed level, what an attention head does is to recombine chunks in the embedding vectors associated with different tokens, with certain weights. And so, for example, the 12 attention heads in the first attention block (in GPT-2) have the following ("look-back-all-the-way-to-the-beginning-of-the-sequence-of-tokens") patterns of "recombination weights" for the "hello, bye" string above:

After being processed by the attention heads, the resulting "re-weighted embedding vector" (of length 768 for GPT-2 and length 12,288 for ChatGPT's GPT-3) is passed through a standard "fully connected" neural net layer. It's hard to get a handle on what this layer is doing. But here's a plot of the 768×768 matrix of weights it's using (here for GPT-2):

Taking 64×64 moving averages, some (random-walk-ish) structure begins to emerge:

What determines this structure? Ultimately it's presumably some "neural net encoding" of features of human language. But as of now, what those features might be is quite unknown. In effect, we're "opening up the brain of ChatGPT" (or at least GPT-2) and discovering, yes, it's complicated in there, and we don't understand it—even though in the end it's producing recognizable human language.

OK, so after going through one attention block, we've got a new embedding vector—which is then successively passed through additional attention blocks (a total of 12 for GPT-2; 96 for GPT-3). Each attention block has its own particular pattern of "attention" and "fully connected" weights. Here for GPT-2 are the sequence of attention weights for the "hello, bye" input, for the first attention head:

And here are the (moving-averaged) "matrices" for the fully connected layers:

Curiously, even though these "matrices of weights" in different attention blocks look quite similar, the distributions of the sizes of weights can be somewhat different (and are not always Gaussian):

So after going through all these attention blocks what is the net effect of the transformer? Essentially it's to transform the original collection of embeddings for the sequence of tokens to a final collection. And the particular way ChatGPT works is then to pick up the last embedding in this collection, and "decode" it to produce a list of probabilities for what token should come next.

So that's in outline what's inside ChatGPT. It may seem complicated (not least because of its many inevitably somewhat arbitrary "engineering choices"), but actually the ultimate elements involved are remarkably simple. Because in the end what we're dealing with is just a neural net made of "artificial neurons", each doing the simple operation of taking a collection of numerical inputs, and then combining them with certain weights.

The original input to ChatGPT is an array of numbers (the embedding vectors for the tokens so far), and what happens when ChatGPT "runs" to produce a new token is just that these numbers "ripple through" the layers of the neural net, with each neuron "doing its thing" and passing the result to neurons on the next layer. There's no looping or "going back". Everything just "feeds forward" through the network.

It's a very different setup from a typical computational system—like a Turing machine—in which results are repeatedly "reprocessed" by the same computational elements. Here—at least in generating a given token of output—each computational element (i.e. neuron) is used only once.

But there is in a sense still an "outer loop" that reuses computational elements even in ChatGPT. Because when ChatGPT is going to generate a new token, it always "reads" (i.e. takes as input) the whole sequence of tokens that come before it, including tokens that ChatGPT itself has "written" previously. And we can think of this setup as meaning that ChatGPT does—at least at its outermost level—involve a "feedback loop", albeit one in which every iteration is explicitly visible as a token that appears in the text that it generates.

But let's come back to the core of ChatGPT: the neural net that's being repeatedly used to generate each token. At some level it's very simple: a whole collection of identical artificial neurons. And some parts of the network just consist of ("fully connected") layers of neurons in which every neuron on a given layer is connected (with some weight) to every neuron on the layer before. But particularly with its transformer architecture, ChatGPT has parts with more structure, in which only specific neurons on different layers are connected. (Of course, one could still say that "all neurons are connected"—but some just have zero weight.)

In addition, there are aspects of the neural net in ChatGPT that aren't most naturally thought of as just consisting of "homogeneous" layers. And for example—as the iconic summary above indicates—inside an attention block there are places where "multiple copies are made" of incoming data, each then going through a different "processing path", potentially involving a different number of layers, and only later recombining. But while this may be a convenient representation of what's going on, it's always at least in principle possible to think of "densely filling in" layers, but just having some weights be zero.

If one looks at the longest path through ChatGPT, there are about 400 (core) layers involved—in some ways not a huge number. But there are millions of neurons—with a total of 175 billion connections and therefore 175 billion weights. And one thing to realize is that every time ChatGPT generates a new token, it has to do a calculation involving every single one of these weights. Implementationally these calculations can be somewhat organized "by layer" into highly parallel array operations that can conveniently be done on GPUs. But for each token that's produced, there still have to be 175 billion calculations done (and in the end a bit more)—so that, yes, it's not surprising that it can take a while to generate a long piece of text with ChatGPT.

But in the end, the remarkable thing is that all these operations—individually as simple as they are—can somehow together manage to do such a good "human-like" job of generating text. It has to be emphasized again that (at least so far as we know) there's no "ultimate theoretical reason" why anything like this should work. And in fact, as we'll discuss, I think we have to view this as a—potentially surprising—scientific discovery: that somehow in a neural net like ChatGPT's it's possible to capture the essence of what human brains manage to do in generating language.

好的，我们终于准备好讨论 ChatGPT 内部的构造了。是的，归根结底，它是一个巨大的神经网络 —— 目前是所谓的 GPT-3 网络的一个版本，拥有 1750 亿个权重。在许多方面，这个神经网络非常类似于我们之前讨论过的其他网络。但它是一个专门为处理语言而设置的神经网络。它最显著的特征是一种被称为「变换器」（transformer）的神经网络架构。

在我们上面讨论的第一个神经网络中，任何给定层上的每个神经元基本上都与前一层上的每个神经元相连（至少有一些权重）。但如果处理的数据具有特定的、已知的结构，这种完全连接的网络（可能）就过于复杂了。因此，例如，在处理图像的早期阶段，通常使用所谓的卷积神经网络（卷积网），在这种网络中，神经元有效地按照类似于图像中像素的网格布局，并且只与网格上附近的神经元相连。

变换器的想法是为构成一段文本的词元序列做类似的事情。但变换器不是定义序列中可以建立连接的固定区域，而是引入了「注意力」的概念 —— 以及「更多关注」序列中某些部分而不是其他部分的想法。也许有一天只启动一个通用神经网络并通过训练进行所有定制是有意义的。但至少目前看来，在实践中「模块化」事物 —— 就像变换器所做的那样，也可能像我们的大脑所做的那样 —— 似乎是至关重要的。

那么 ChatGPT（或者说，它所基于的 GPT-3 网络）实际上做了什么呢？回想一下，它的总体目标是基于从训练中看到的内容（包括查看来自网络等地方的数十亿页面文本）以一种「合理」的方式继续文本。因此，在任何给定时刻，它都有一定量的文本 —— 它的目标是提出一个适当的选择，以添加下一个词元。

它有三个基本阶段。首先，它获取到目前为止文本对应的词元序列，并找到一个嵌入（即一组数字）来代表这些词元。然后它对这个嵌入进行操作 —— 以「标准神经网络方式」，通过连续层在网络中「传播」值 —— 以产生一个新的嵌入（即新的一组数字）。它接着获取这个数组的最后一部分，并从中生成一个大约包含 50,000 个值的数组，这些值转化为不同可能下一个词元的概率。（是的，巧合的是，使用的词元数量大约与英语中常用单词的数量相同，尽管只有大约 3000 个词元是完整的单词，其余的是片段。）

每个环节都是由神经网络实现的，这一点至关重要，而神经网络的权重是通过网络的端到端训练来确定的。换句话说，实际上除了整体架构之外，没有任何东西是「显式工程化」的；一切都是从训练数据中「学习」而来的。

然而，在架构的设置方式上有许多细节 —— 反映了各种经验和神经网络的知识。而且 —— 尽管这绝对是深入细节 —— 我认为讨论其中一些细节是有用的，至少可以让人了解构建像 ChatGPT 这样的东西需要投入什么。

首先是嵌入模块。以下是 Wolfram 语言对 GPT-2 的嵌入模块的示意性表示：

输入是 n 个词元的向量（如上一节所述，用大约 1 到 50,000 的整数表示）。这些词元中的每一个都被转换（通过单层神经网络）为嵌入向量（GPT-2 的长度为 768，ChatGPT 的 GPT-3 为 12,288）。与此同时，有一个「次要路径」获取词元的（整数）位置序列，并从这些整数创建另一个嵌入向量。最后，来自词元值和词元位置的嵌入向量被相加在一起 —— 产生来自嵌入模块的最终嵌入向量序列。

为什么要将词元值嵌入向量和词元位置嵌入向量相加在一起？我认为这没有任何特别的科学依据。这只是尝试了各种不同的方法，这是一种似乎有效的方法。这是神经网络知识的一部分，在某种意义上 —— 只要所拥有的设置是「大致正确的」，通常只需进行足够的训练就可以找到细节，而无需真正「在工程层面上理解」神经网络最终是如何配置自身的。

以下是嵌入模块对字符串 hello hello hello hello hello hello hello hello hello hello bye bye bye bye bye bye bye bye bye bye 的操作：

每个词元的嵌入向量的元素沿页面显示，页面上我们首先看到一连串的「hello」嵌入，然后是「bye」嵌入。上面的第二个数组是位置嵌入 —— 其有些随机的外观结构只是「碰巧学到的」（在这种情况下是 GPT-2）。

好的，嵌入模块之后是变换器的「主要事件」：一系列所谓的「注意力块」（GPT-2 有 12 个，ChatGPT 的 GPT-3 有 96 个）。这一切都相当复杂 —— 让人想起典型的大型难以理解的工程系统，或者说，生物系统。但无论如何，这里是一个单个「注意力块」的示意性表示（对于 GPT-2）：

在每个注意力块内，有一系列的「注意力头」（GPT-2 有 12 个，ChatGPT 的 GPT-3 有 96 个），每个都独立地在嵌入向量的不同块上操作。（是的，我们不知道将嵌入向量分割开来的具体原因，或者它的不同部分「意味着什么」；这只是那些被「发现有效」的东西之一。）

那么，注意力头做什么呢？基本上，它们是一种「回顾」词元序列（即到目前为止产生的文本）的方式，并以一种对于找到下一个词元有用的形式「打包过去」。在上面的第一部分中，我们谈到了使用 2-gram 概率来根据它们的直接前驱选择单词。变换器中的「注意力」机制允许甚至对更早的词语进行「关注」—— 从而潜在地捕捉到，比如，动词如何可以指涉在句子中它们之前出现的许多词的名词。

在更详细的层面上，一个注意力头所做的是重新组合与不同词元相关的嵌入向量中的块，附有特定的权重。因此，例如，GPT-2 中第一个注意力块的 12 个注意力头对于上面的「hello, bye」字符串具有以下「从序列开头一直回溯」的「重组权重」模式：

经过注意力头处理后，所得到的「重新加权嵌入向量」（对于 GPT-2 长度为 768，对于 ChatGPT 的 GPT-3 长度为 12,288）通过标准的「全连接」神经网络层。很难了解这一层在做什么。但这里是它使用的 768×768 权重矩阵的图（这里是 GPT-2 的）：

取 64×64 的移动平均后，一些（随机游走式的）结构开始显现：

这种结构是由什么决定的？最终这可能是某种「神经网络编码」的人类语言特征。但就目前而言，这些特征可能是什么还不得而知。实际上，我们正在「打开 ChatGPT 的大脑」（或至少是 GPT-2），发现里面确实很复杂，我们还不了解它 —— 即使最终它产生了可识别的人类语言。

好的，经过一个注意力块后，我们得到了一个新的嵌入向量 —— 然后依次传递给其他注意力块（GPT-2 总共有 12 个；GPT-3 有 96 个）。每个注意力块都有自己特定的「注意力」和「全连接」权重模式。以下是 GPT-2 的「hello, bye」输入的注意力权重序列，对于第一个注意力头：

这里是全连接层的（移动平均后的）「矩阵」：

确实，尽管不同注意力块中的「权重矩阵」看起来非常相似，但权重的大小分布可能有所不同（并不总是高斯分布）：

经过所有这些注意力块后，变换器的净效果是什么呢？本质上，它将词元序列的原始嵌入集合转换为最终集合。ChatGPT 的特定工作方式是接着提取这个集合中的最后一个嵌入，并「解码」它以生成下一个词元可能是什么的概率列表。

所以这就是 ChatGPT 内部的大致情况。这可能看起来很复杂（不仅因为其许多不可避免的某种程度上任意的「工程选择」），但实际上涉及的最终元素非常简单。因为最终我们处理的只是一个由「人工神经元」组成的神经网络，每个神经元执行的简单操作就是接收一组数值输入，然后用特定的权重将它们结合起来。

ChatGPT 的原始输入是一个数字数组（到目前为止的词元的嵌入向量），当 ChatGPT「运行」以产生新词元时，这些数字只是「在神经网络的层中波动」，每个神经元「做它的事情」并将结果传递给下一层的神经元。没有循环或「回溯」。一切都只是「向前推进」通过网络。

这与典型的计算系统 —— 如图灵机 —— 非常不同，在图灵机中，结果被同一计算元素反复「重新处理」。在这里 —— 至少在生成给定词元的输出时 —— 每个计算元素（即神经元）只使用一次。

但在 ChatGPT 中，即使是在某种意义上仍然存在一个「外部循环」来重复使用计算元素。因为当 ChatGPT 将要生成一个新词元时，它总是「读取」（即作为输入）在其之前的整个词元序列，包括 ChatGPT 自己之前「写下」的词元。我们可以将这种设置视为意味着 ChatGPT 确实在其最外层至少涉及一个「反馈循环」，尽管每次迭代都以文本中出现的词元的形式明确可见。

但让我们回到 ChatGPT 的核心：用来重复生成每个词元的神经网络。在某种程度上，它非常简单：一整套相同的人工神经元。网络的某些部分仅由神经元的（全连接）层组成，在这些层中，给定层上的每个神经元都与前一层的每个神经元相连（具有一定的权重）。但特别是在其变换器架构中，ChatGPT 有更多结构的部分，在这些部分中，不同层的特定神经元才相连。（当然，人们仍然可以说「所有神经元都相连」—— 但有些神经元的权重只是零。）

此外，ChatGPT 中的神经网络还有一些方面，最自然的看法不仅仅是由「同质」层组成。例如，如上面的图标总结所示，在一个注意力块内部，有些地方会对传入的数据「制作多个副本」，每个副本随后经过不同的「处理路径」，可能涉及不同数量的层，然后才重新组合。但虽然这可能是对正在发生的事情的一个方便的表示，至少在原理上总是有可能考虑「密集填充」层，只是让一些权重为零。

如果看一下 ChatGPT 中最长的路径，大约有 400 个（核心）层涉及 —— 在某些方面并不是一个巨大的数字。但有数百万个神经元 —— 共有 1750 亿个连接，因此有 1750 亿个权重。需要认识到的一点是，每次 ChatGPT 生成一个新词元时，它必须进行涉及这些权重的每一个的计算。在实现上，这些计算可以在某种程度上按层组织成高度并行的数组操作，可以方便地在 GPU 上完成。但对于生成的每个词元，仍然必须进行 1750 亿次计算（最终还要更多一些）—— 所以，是的，生成一段长文本的 ChatGPT 可能需要一段时间并不奇怪。

但最终，令人惊奇的是，所有这些操作 —— 尽管每个操作都很简单 —— 却可以一起做得如此出色地「像人类一样」生成文本。必须再次强调的是，（至少据我们所知）没有任何「终极理论原因」可以解释为什么类似这样的事情会有效。实际上，正如我们将讨论的，我认为我们必须将这视为一项（可能令人惊讶的）科学发现：即某种方式下，像 ChatGPT 这样的神经网络能够捕捉到人类大脑在生成语言时设法做到的本质。

### 11. The Training of ChatGPT

OK, so we've now given an outline of how ChatGPT works once it's set up. But how did it get set up? How were all those 175 billion weights in its neural net determined? Basically they're the result of very large-scale training, based on a huge corpus of text—on the web, in books, etc.—written by humans. As we've said, even given all that training data, it's certainly not obvious that a neural net would be able to successfully produce "human-like" text. And, once again, there seem to be detailed pieces of engineering needed to make that happen. But the big surprise—and discovery—of ChatGPT is that it's possible at all. And that—in effect—a neural net with "just" 175 billion weights can make a "reasonable model" of text humans write.

In modern times, there's lots of text written by humans that's out there in digital form. The public web has at least several billion human-written pages, with altogether perhaps a trillion words of text. And if one includes non-public webpages, the numbers might be at least 100 times larger. So far, more than 5 million digitized books have been made available (out of 100 million or so that have ever been published), giving another 100 billion or so words of text. And that's not even mentioning text derived from speech in videos, etc. (As a personal comparison, my total lifetime output of published material has been a bit under 3 million words, and over the past 30 years I've written about 15 million words of email, and altogether typed perhaps 50 million words—and in just the past couple of years I've spoken more than 10 million words on livestreams. And, yes, I'll train a bot from all of that.)

But, OK, given all this data, how does one train a neural net from it? The basic process is very much as we discussed it in the simple examples above. You present a batch of examples, and then you adjust the weights in the network to minimize the error ("loss") that the network makes on those examples. The main thing that's expensive about "back propagating" from the error is that each time you do this, every weight in the network will typically change at least a tiny bit, and there are just a lot of weights to deal with. (The actual "back computation" is typically only a small constant factor harder than the forward one.)

With modern GPU hardware, it's straightforward to compute the results from batches of thousands of examples in parallel. But when it comes to actually updating the weights in the neural net, current methods require one to do this basically batch by batch. (And, yes, this is probably where actual brains—with their combined computation and memory elements—have, for now, at least an architectural advantage.)

Even in the seemingly simple cases of learning numerical functions that we discussed earlier, we found we often had to use millions of examples to successfully train a network, at least from scratch. So how many examples does this mean we'll need in order to train a "human-like language" model? There doesn't seem to be any fundamental "theoretical" way to know. But in practice ChatGPT was successfully trained on a few hundred billion words of text.

Some of the text it was fed several times, some of it only once. But somehow it "got what it needed" from the text it saw. But given this volume of text to learn from, how large a network should it require to "learn it well"? Again, we don't yet have a fundamental theoretical way to say. Ultimately—as we'll discuss further below—there's presumably a certain "total algorithmic content" to human language and what humans typically say with it. But the next question is how efficient a neural net will be at implementing a model based on that algorithmic content. And again we don't know—although the success of ChatGPT suggests it's reasonably efficient.

And in the end we can just note that ChatGPT does what it does using a couple hundred billion weights—comparable in number to the total number of words (or tokens) of training data it's been given. In some ways it's perhaps surprising (though empirically observed also in smaller analogs of ChatGPT) that the "size of the network" that seems to work well is so comparable to the "size of the training data". After all, it's certainly not that somehow "inside ChatGPT" all that text from the web and books and so on is "directly stored". Because what's actually inside ChatGPT are a bunch of numbers—with a bit less than 10 digits of precision—that are some kind of distributed encoding of the aggregate structure of all that text.

Put another way, we might ask what the "effective information content" is of human language and what's typically said with it. There's the raw corpus of examples of language. And then there's the representation in the neural net of ChatGPT. That representation is very likely far from the "algorithmically minimal" representation (as we'll discuss below). But it's a representation that's readily usable by the neural net. And in this representation it seems there's in the end rather little "compression" of the training data; it seems on average to basically take only a bit less than one neural net weight to carry the "information content" of a word of training data.

When we run ChatGPT to generate text, we're basically having to use each weight once. So if there are n weights, we've got of order n computational steps to do—though in practice many of them can typically be done in parallel in GPUs. But if we need about n words of training data to set up those weights, then from what we've said above we can conclude that we'll need about n2 computational steps to do the training of the network—which is why, with current methods, one ends up needing to talk about billion-dollar training efforts.

好的，现在我们已经概述了一旦设置好之后 ChatGPT 是如何工作的。但它是如何设置的呢？它神经网络中所有这 1750 亿个权重是如何确定的？基本上，它们是基于大规模训练的结果，这些训练基于大量由人类编写的文本 —— 在网络上、书籍中等。正如我们所说，即使有了所有这些训练数据，神经网络能够成功地生成「类人」的文本也并不明显。而且，再次强调，似乎需要详细的工程部分来实现这一点。但 ChatGPT 的一个大惊喜和发现是，这是可能的。而且，实际上，「仅仅」1750 亿个权重的神经网络可以构建一个「合理的模型」来模拟人类写的文本。

在现代，有大量的数字形式的人类编写的文本。公共网络上至少有数十亿个由人类编写的页面，总共可能有大约一万亿个文本词。如果包括非公共网页，这些数字可能至少是 100 倍更大。到目前为止，已经有超过 500 万本数字化书籍可用（出版过的大约 1 亿本书中的一部分），提供了另外大约 1000 亿个文本词。这还没有提到从视频中的语音等衍生的文本。（作为个人比较，我一生发表的材料总量不到 300 万个词，在过去 30 年中，我写了大约 1500 万个词的电子邮件，总共大约敲打了 5000 万个词 —— 而仅在过去几年中，我在直播中说了超过 1000 万个词。而且，是的，我将用所有这些来训练一个机器人。）

但好吧，鉴于所有这些数据，如何训练一个神经网络呢？基本过程非常类似于我们在上面的简单示例中讨论的。您呈现一批示例，然后调整网络中的权重，以最小化网络在这些示例上犯的错误（损失）。关于「从错误中反向传播」的主要代价是，每次这样做时，网络中的每个权重通常都会至少稍微改变一点，而且有很多权重要处理。（实际的「反向计算」通常只比前向计算难一点。）

有了现代 GPU 硬件，可以轻松地并行计算成千上万个示例的结果。但是，当涉及到实际更新神经网络中的权重时，当前的方法要求基本上逐批进行。（而且，是的，这可能是实际大脑 —— 它们结合了计算和记忆元素 —— 至少目前在架构上具有的优势。）

即使在我们之前讨论的关于学习数值函数的看似简单的情况中，我们发现，至少从零开始，我们通常需要使用数百万个示例来成功训练一个网络。那么，为了训练一个「类人的语言」模型，这意味着我们需要多少个示例呢？似乎没有任何基础的「理论」方法可以知道。但实际上，ChatGPT 是通过几千亿个文本词成功训练的。

有些文本被多次喂入，有些只喂入一次。但不知怎么的，它从所看到的文本中「得到了所需的内容」。但鉴于学习的文本量，它需要多大的网络才能「很好地学习」？同样，我们还没有一种基本的理论方法来回答这个问题。最终 —— 正如我们将在下面进一步讨论的 —— 人类语言及其典型用法可能有一定的「总体算法内容」。但下一个问题是，神经网络在基于该算法内容实现模型方面的效率有多高。我们也不知道 —— 尽管 ChatGPT 的成功表明它相当高效。

最终，我们只能注意到，ChatGPT 使用几百亿个权重来做它所做的事情 —— 与它所接受的总训练数据量（或词元）的数量相当。在某些方面，令人惊讶的是（尽管在 ChatGPT 的较小类似物中也通过实证观察到），似乎「有效的网络大小」与「训练数据的大小」如此相当。毕竟，当然不是因为「在 ChatGPT 内部」所有来自网络、书籍等的所有文本「直接存储」。因为实际上在 ChatGPT 内部的是一堆数字 —— 精度略低于 10 位数 —— 这是对所有这些文本的总体结构的某种分布式编码。

换句话说，我们可能会问人类语言及其典型用途的「有效信息内容」是什么。有原始的语言示例语料库。然后是 ChatGPT 神经网络中的表示。这种表示很可能远非「算法上最小」的表示（正如我们将在下面讨论的）。但这是神经网络容易使用的表示。在这种表示中，最终对训练数据似乎几乎没有多少「压缩」；平均来看，它似乎基本上只需要不到一个神经网络权重来携带一个训练数据词的「信息内容」。

当我们运行 ChatGPT 生成文本时，我们基本上需要使用每个权重一次。所以如果有 n 个权重，我们大约需要进行 n 个计算步骤 —— 尽管实际上其中的许多通常可以在 GPU 中并行完成。但如果我们需要大约 n 个词的训练数据来设置这些权重，那么根据我们上面所说，我们可以得出结论，我们将需要大约 n^2 个计算步骤来进行网络训练 —— 这就是为什么，使用目前的方法，我们最终需要谈论数十亿美元的训练费用。

### 12. Beyond Basic Training

The majority of the effort in training ChatGPT is spent "showing it" large amounts of existing text from the web, books, etc. But it turns out there's another—apparently rather important—part too.

As soon as it's finished its "raw training" from the original corpus of text it's been shown, the neural net inside ChatGPT is ready to start generating its own text, continuing from prompts, etc. But while the results from this may often seem reasonable, they tend—particularly for longer pieces of text—to "wander off" in often rather non-human-like ways. It's not something one can readily detect, say, by doing traditional statistics on the text. But it's something that actual humans reading the text easily notice.

And a key idea in the construction of ChatGPT was to have another step after "passively reading" things like the web: to have actual humans actively interact with ChatGPT, see what it produces, and in effect give it feedback on "how to be a good chatbot". But how can the neural net use that feedback? The first step is just to have humans rate results from the neural net. But then another neural net model is built that attempts to predict those ratings. But now this prediction model can be run—essentially like a loss function—on the original network, in effect allowing that network to be "tuned up" by the human feedback that's been given. And the results in practice seem to have a big effect on the success of the system in producing "human-like" output.

In general, it's interesting how little "poking" the "originally trained" network seems to need to get it to usefully go in particular directions. One might have thought that to have the network behave as if it's "learned something new" one would have to go in and run a training algorithm, adjusting weights, and so on.

But that's not the case. Instead, it seems to be sufficient to basically tell ChatGPT something one time—as part of the prompt you give—and then it can successfully make use of what you told it when it generates text. And once again, the fact that this works is, I think, an important clue in understanding what ChatGPT is "really doing" and how it relates to the structure of human language and thinking.

There's certainly something rather human-like about it: that at least once it's had all that pre-training you can tell it something just once and it can "remember it"—at least "long enough" to generate a piece of text using it. So what's going on in a case like this? It could be that "everything you might tell it is already in there somewhere"—and you're just leading it to the right spot. But that doesn't seem plausible. Instead, what seems more likely is that, yes, the elements are already in there, but the specifics are defined by something like a "trajectory between those elements" and that's what you're introducing when you tell it something.

And indeed, much like for humans, if you tell it something bizarre and unexpected that completely doesn't fit into the framework it knows, it doesn't seem like it'll successfully be able to "integrate" this. It can "integrate" it only if it's basically riding in a fairly simple way on top of the framework it already has.

It's also worth pointing out again that there are inevitably "algorithmic limits" to what the neural net can "pick up". Tell it "shallow" rules of the form "this goes to that", etc., and the neural net will most likely be able to represent and reproduce these just fine—and indeed what it "already knows" from language will give it an immediate pattern to follow. But try to give it rules for an actual "deep" computation that involves many potentially computationally irreducible steps and it just won't work. (Remember that at each step it's always just "feeding data forward" in its network, never looping except by virtue of generating new tokens.)

Of course, the network can learn the answer to specific "irreducible" computations. But as soon as there are combinatorial numbers of possibilities, no such "table-lookup-style" approach will work. And so, yes, just like humans, it's time then for neural nets to "reach out" and use actual computational tools. (And, yes, Wolfram|Alpha and Wolfram Language are uniquely suitable, because they've been built to "talk about things in the world", just like the language-model neural nets.)

在训练 ChatGPT 的过程中，大部分工作都花费在「向它展示」来自网络、书籍等的大量现有文本上。但事实证明，还有另一个看似相当重要的部分。

一旦它完成了从最初显示的文本语料库进行的「原始训练」，ChatGPT 内部的神经网络就准备好开始生成自己的文本，从提示等内容继续。但尽管这样产生的结果常常看起来合理，它们往往倾向于以一种通常并不像人类的方式「游荡」，特别是对于较长的文本。这不是通过传统的文本统计方法就能容易检测到的。但这是实际阅读文本的人们很容易注意到的。

在构建 ChatGPT 时的一个关键想法是，在「被动阅读」网络等之后，有另一个步骤：让实际的人与 ChatGPT 积极互动，看它产生的内容，并实际给予它「如何成为一个好的聊天机器人」的反馈。但神经网络怎样使用这些反馈呢？第一步就是让人类对神经网络的结果进行评分。但接着构建另一个神经网络模型，试图预测这些评分。但现在这个预测模型可以运行 —— 本质上像一个损失函数 —— 在原始网络上，实际上允许通过已给出的人类反馈「调优」该网络。实际上，这些结果似乎对系统产生「类人」输出的成功有很大影响。

总的来说，有趣的是，「原始训练」的网络似乎需要很少的「调整」就能有用地朝着特定方向发展。人们可能会认为，要让网络表现得像是「学到了新东西」，就必须进入并运行训练算法，调整权重等。

但事实并非如此。相反，似乎只需告诉 ChatGPT 一次就足够了 —— 作为你给出的提示的一部分 —— 然后它就可以在生成文本时成功地利用你告诉它的信息。再次，这种工作方式，我认为，是理解 ChatGPT「真正做了什么」以及它与人类语言和思维结构的关系的重要线索。

的确，这在某种程度上很像人类：至少一旦经过了所有的预训练，你可以告诉它一些事情，它就可以「记住它」—— 至少「足够长的时间」来使用它生成一段文本。那么，在这种情况下发生了什么呢？可能是「你可能告诉它的一切已经在那里某个地方」—— 你只是在引导它到正确的位置。但这似乎不太可能。相反，看起来更可能的是，是的，元素已经在那里，但具体细节是由类似于「在这些元素之间的轨迹」定义的，而这正是你在告诉它某事时所引入的。

实际上，就像对于人类一样，如果你告诉它一些奇怪和意想不到的完全不适合其所知框架的事情，它似乎不会成功地能够「整合」这些信息。只有当它基本上在已有框架的基础上以相当简单的方式运作时，它才能「整合」它。

同样值得再次指出的是，神经网络能够「捕捉」的内容不可避免地存在「算法限制」。告诉它「浅层」的规则，例如「这变成那」，等等，神经网络很可能能够很好地表示和复制这些内容 —— 实际上它通过语言「已经知道」的内容会给它提供一个立即的模式。但尝试给它一个涉及许多可能计算上不可约步骤的实际「深层」计算的规则，它就不会起作用。（记住，每一步它总是在网络中「向前推送数据」，除了通过生成新词元之外，从不循环。）

当然，网络可以学习特定「不可约」计算的答案。但一旦存在组合数量的可能性，就不会有这种「查表式」方法可行。因此，是的，就像人类一样，到了那时，神经网络需要「求助于」实际的计算工具。（而且，是的，Wolfram|Alpha 和 Wolfram 语言非常合适，因为它们已经构建为「像神经网络一样的语言模型那样谈论世界中的事物」。）

### 13. What Really Lets ChatGPT Work?

Human language—and the processes of thinking involved in generating it—have always seemed to represent a kind of pinnacle of complexity. And indeed it's seemed somewhat remarkable that human brains—with their network of a "mere" 100 billion or so neurons (and maybe 100 trillion connections) could be responsible for it. Perhaps, one might have imagined, there's something more to brains than their networks of neurons—like some new layer of undiscovered physics. But now with ChatGPT we've got an important new piece of information: we know that a pure, artificial neural network with about as many connections as brains have neurons is capable of doing a surprisingly good job of generating human language.

And, yes, that's still a big and complicated system—with about as many neural net weights as there are words of text currently available out there in the world. But at some level it still seems difficult to believe that all the richness of language and the things it can talk about can be encapsulated in such a finite system. Part of what's going on is no doubt a reflection of the ubiquitous phenomenon (that first became evident in the example of rule 30) that computational processes can in effect greatly amplify the apparent complexity of systems even when their underlying rules are simple. But, actually, as we discussed above, neural nets of the kind used in ChatGPT tend to be specifically constructed to restrict the effect of this phenomenon—and the computational irreducibility associated with it—in the interest of making their training more accessible.

So how is it, then, that something like ChatGPT can get as far as it does with language? The basic answer, I think, is that language is at a fundamental level somehow simpler than it seems. And this means that ChatGPT—even with its ultimately straightforward neural net structure—is successfully able to "capture the essence" of human language and the thinking behind it. And moreover, in its training, ChatGPT has somehow "implicitly discovered" whatever regularities in language (and thinking) make this possible.

The success of ChatGPT is, I think, giving us evidence of a fundamental and important piece of science: it's suggesting that we can expect there to be major new "laws of language"—and effectively "laws of thought"—out there to discover. In ChatGPT—built as it is as a neural net—those laws are at best implicit. But if we could somehow make the laws explicit, there's the potential to do the kinds of things ChatGPT does in vastly more direct, efficient—and transparent—ways.

But, OK, so what might these laws be like? Ultimately they must give us some kind of prescription for how language—and the things we say with it—are put together. Later we'll discuss how "looking inside ChatGPT" may be able to give us some hints about this, and how what we know from building computational language suggests a path forward. But first let's discuss two long-known examples of what amount to "laws of language"—and how they relate to the operation of ChatGPT.

The first is the syntax of language. Language is not just a random jumble of words. Instead, there are (fairly) definite grammatical rules for how words of different kinds can be put together: in English, for example, nouns can be preceded by adjectives and followed by verbs, but typically two nouns can't be right next to each other. Such grammatical structure can (at least approximately) be captured by a set of rules that define how what amount to "parse trees" can be put together:

ChatGPT doesn't have any explicit "knowledge" of such rules. But somehow in its training it implicitly "discovers" them—and then seems to be good at following them. So how does this work? At a "big picture" level it's not clear. But to get some insight it's perhaps instructive to look at a much simpler example.

Consider a "language" formed from sequences of ('s and )'s, with a grammar that specifies that parentheses should always be balanced, as represented by a parse tree like:

Can we train a neural net to produce "grammatically correct" parenthesis sequences? There are various ways to handle sequences in neural nets, but let's use transformer nets, as ChatGPT does. And given a simple transformer net, we can start feeding it grammatically correct parenthesis sequences as training examples. A subtlety (which actually also appears in ChatGPT's generation of human language) is that in addition to our "content tokens" (here "(" and ")") we have to include an "End" token, that's generated to indicate that the output shouldn't continue any further (i.e. for ChatGPT, that one's reached the "end of the story").

If we set up a transformer net with just one attention block with 8 heads and feature vectors of length 128 (ChatGPT also uses feature vectors of length 128, but has 96 attention blocks, each with 96 heads) then it doesn't seem possible to get it to learn much about parenthesis language. But with 2 attention blocks, the learning process seems to converge—at least after 10 million or so examples have been given (and, as is common with transformer nets, showing yet more examples just seems to degrade its performance).

So with this network, we can do the analog of what ChatGPT does, and ask for probabilities for what the next token should be—in a parenthesis sequence:

And in the first case, the network is "pretty sure" that the sequence can't end here—which is good, because if it did, the parentheses would be left unbalanced. In the second case, however, it "correctly recognizes" that the sequence can end here, though it also "points out" that it's possible to "start again", putting down a "(", presumably with a ")" to follow. But, oops, even with its 400,000 or so laboriously trained weights, it says there's a 15% probability to have ")" as the next token—which isn't right, because that would necessarily lead to an unbalanced parenthesis.

Here's what we get if we ask the network for the highest-probability completions for progressively longer sequences of ('s:

And, yes, up to a certain length the network does just fine. But then it starts failing. It's a pretty typical kind of thing to see in a "precise" situation like this with a neural net (or with machine learning in general). Cases that a human "can solve in a glance" the neural net can solve too. But cases that require doing something "more algorithmic" (e.g. explicitly counting parentheses to see if they're closed) the neural net tends to somehow be "too computationally shallow" to reliably do. (By the way, even the full current ChatGPT has a hard time correctly matching parentheses in long sequences.)

So what does this mean for things like ChatGPT and the syntax of a language like English? The parenthesis language is "austere"—and much more of an "algorithmic story". But in English it's much more realistic to be able to "guess" what's grammatically going to fit on the basis of local choices of words and other hints. And, yes, the neural net is much better at this—even though perhaps it might miss some "formally correct" case that, well, humans might miss as well. But the main point is that the fact that there's an overall syntactic structure to the language—with all the regularity that implies—in a sense limits "how much" the neural net has to learn. And a key "natural-science-like" observation is that the transformer architecture of neural nets like the one in ChatGPT seems to successfully be able to learn the kind of nested-tree-like syntactic structure that seems to exist (at least in some approximation) in all human languages.

Syntax provides one kind of constraint on language. But there are clearly more. A sentence like "Inquisitive electrons eat blue theories for fish" is grammatically correct but isn't something one would normally expect to say, and wouldn't be considered a success if ChatGPT generated it—because, well, with the normal meanings for the words in it, it's basically meaningless.

But is there a general way to tell if a sentence is meaningful? There's no traditional overall theory for that. But it's something that one can think of ChatGPT as having implicitly "developed a theory for" after being trained with billions of (presumably meaningful) sentences from the web, etc.

What might this theory be like? Well, there's one tiny corner that's basically been known for two millennia, and that's logic. And certainly in the syllogistic form in which Aristotle discovered it, logic is basically a way of saying that sentences that follow certain patterns are reasonable, while others are not. Thus, for example, it's reasonable to say "All X are Y. This is not Y, so it's not an X" (as in "All fishes are blue. This is not blue, so it's not a fish."). And just as one can somewhat whimsically imagine that Aristotle discovered syllogistic logic by going ("machine-learning-style") through lots of examples of rhetoric, so too one can imagine that in the training of ChatGPT it will have been able to "discover syllogistic logic" by looking at lots of text on the web, etc. (And, yes, while one can therefore expect ChatGPT to produce text that contains "correct inferences" based on things like syllogistic logic, it's a quite different story when it comes to more sophisticated formal logic—and I think one can expect it to fail here for the same kind of reasons it fails in parenthesis matching.)

But beyond the narrow example of logic, what can be said about how to systematically construct (or recognize) even plausibly meaningful text? Yes, there are things like Mad Libs that use very specific "phrasal templates". But somehow ChatGPT implicitly has a much more general way to do it. And perhaps there's nothing to be said about how it can be done beyond "somehow it happens when you have 175 billion neural net weights". But I strongly suspect that there's a much simpler and stronger story.

人类语言及其在生成过程中涉及的思维过程，一直似乎代表着一种复杂性的顶峰。的确，人脑 —— 拥有「仅仅」大约 1000 亿个神经元（或许 1 万亿个连接）的网络 —— 能够承担这一责任，这似乎有些不可思议。或许，人们可能想象，大脑除了它们的神经元网络之外，还有其他更多元素 —— 比如一些未被发现的新物理层面。但现在有了 ChatGPT，我们得到了一个重要的新信息：我们知道，一个纯粹的人工神经网络，拥有与大脑神经元数量相当的连接，能够在生成人类语言方面做得出奇地好。

是的，这仍然是一个大型而复杂的系统 —— 拥有与当前世界上可用文本词汇数量大致相当的神经网络权重。但在某种程度上，所有语言的丰富性及其所能表达的内容都能被封装在这样一个有限的系统中，这仍然难以置信。部分原因无疑是因为普遍现象（最早在规则 30 的例子中变得明显）表明，即使底层规则简单，计算过程也可以在效果上大大增加系统的表面复杂性。但实际上，如我们上面讨论的，ChatGPT 中使用的神经网络类型通常被特别构建以限制这种现象及与之相关的计算不可约性的影响，以便使它们的训练更易于接近。

那么，像 ChatGPT 这样的东西如何在语言方面走得如此远呢？我认为基本的答案是，从根本上来说，语言比它看起来更简单。这意味着 ChatGPT —— 即使拥有最终直接的神经网络结构 —— 成功地「捕捉到」了人类语言及其背后的思维的本质。而且，在它的训练过程中，ChatGPT 似乎「隐含地发现了」使这成为可能的语言（和思维）中的任何规律性。

我认为，ChatGPT 的成功正在向我们提供一项基础且重要的科学证据：它表明我们可以期待发现新的重要的「语言法则」—— 实际上是「思维法则」。在 ChatGPT 中 —— 正如它作为神经网络所建立的 —— 这些法则最多是隐含的。但如果我们能以某种方式使这些法则显式化，就有潜力以更直接、高效和透明的方式做 ChatGPT 所做的事情。

但好吧，那么这些法则可能是什么样的呢？它们最终必须给我们提供一些关于如何构建语言及我们用它说的话的规定。稍后我们将讨论如何「查看 ChatGPT 内部」可能为此提供一些线索，以及我们从构建计算语言中所了解的内容如何指明一条前进的道路。但首先，让我们讨论两个长期已知的相当于「语言法则」的例子，以及它们如何与 ChatGPT 的运作相关。

第一个例子是语言的句法。语言不仅仅是一堆杂乱无章的单词。相反，有（相当）明确的语法规则来规定不同种类的单词如何组合：例如，在英语中，名词可以被形容词前置和动词后置，但通常两个名词不能紧挨着放置。这样的语法结构可以（至少近似地）被一组规则捕捉到，这些规则定义了如何组合「解析树」：

ChatGPT 没有任何关于这些规则的显式「知识」。但在训练中，它似乎隐含地「发现」了这些规则，并且似乎擅长遵循它们。那么，这是如何工作的呢？从「大图景」角度来看，这还不清楚。但要获得一些洞察力，看一个简单得多的例子可能是有指导意义的。

考虑由 '(' 和 ')' 组成的「语言」，这种语言的语法规定括号必须始终平衡，如解析树所示：

我们可以训练一个神经网络来产生「语法正确」的括号序列吗？在神经网络中处理序列有各种方法，但让我们使用变换器网络，就像 ChatGPT 所做的那样。并且给定一个简单的变换器网络，我们可以开始向它喂养语法正确的括号序列作为训练示例。一个细微之处（实际上也出现在 ChatGPT 生成人类语言时）是，除了我们的「内容词元」（这里是 '(' 和 ')' ）外，我们还必须包含一个「结束」词元，它被生成以指示输出不应该继续进行（即对于 ChatGPT，表示已经到达「故事的结尾」）。

如果我们用一个有 8 个头和长度为 128 的特征向量的注意力块（ChatGPT 也使用长度为 128 的特征向量，但有 96 个注意力块，每个块有 96 个头）来设置一个变换器网络，那么似乎不可能让它学会关于括号语言的太多知识。但是使用 2 个注意力块后，学习过程似乎开始收敛 —— 至少在提供了大约 1000 万个示例后（而且，就像变换器网络常见的那样，展示更多示例似乎只会降低其性能）。

因此，有了这个网络，我们可以做类似于 ChatGPT 所做的事情，并询问下一个词元应该是什么的概率 —— 在一个括号序列中：

在第一个例子中，网络「非常确定」序列不能在这里结束 —— 这是好事，因为如果结束了，括号将会留下不平衡。然而，在第二个例子中，它「正确地认识到」序列可以在这里结束，尽管它也「指出」有可能「重新开始」，放下一个 '('，大概是跟着一个 ')'。但是，即使经过辛苦训练的大约 40 万个权重，它说下一个词元是 ')' 的概率有 15％ —— 这不对，因为那将必然导致括号不平衡。

如果我们向网络询问以越来越长的 '(' 序列为开始的最高概率完成情况，我们会得到如下结果：

是的，直到一定长度，网络做得很好。但之后它开始失败。这是在神经网络（或通常的机器学习）中像这样「精确」的情况下看到的非常典型的情况。人类「一瞥即可解决」的案例，神经网络也可以解决。但需要做一些「更多算法化」的事情的案例（例如，明确计算括号以看它们是否关闭），神经网络往往「计算能力太浅」而无法可靠地做到。（顺便说一下，即使是完整的当前版本的 ChatGPT 也很难在长序列中正确匹配括号。）

那么，这对像 ChatGPT 这样的东西和像英语这样的语言句法意味着什么呢？括号语言是「简朴的」，并且更多地是一个「算法故事」。但在英语中，基于单词的局部选择和其他提示来「猜测」什么在语法上将适合是更现实的。是的，神经网络在这方面做得更好 —— 即使它可能错过一些「正式正确」的情况，好吧，人类也可能错过。但主要的一点是，语言存在整体句法结构 —— 以及所有随之而来的规律性 —— 在某种意义上限制了神经网络必须学习的「多少」。一个关键的「自然科学式」的观察是，像 ChatGPT 中那样的变换器架构的神经网络似乎成功地能够学习嵌套树状的句法结构，这种结构似乎（至少在某种近似中）存在于所有人类语言中。

句法为语言提供了一种约束。但显然还有更多。像「好奇的电子吃蓝色理论用于鱼类」这样的句子在语法上是正确的，但不是人们通常会期望说的，如果 ChatGPT 生成了这样的句子也不会被认为是成功的 —— 因为，嗯，用其中单词的正常含义来说，它基本上是毫无意义的。

但是否有一种通用的方法来判断一个句子是否有意义呢？目前没有一个传统的总体理论来解释这一点。但这是可以想象的，经过数十亿个（假设有意义的）网页等来源的句子训练后，ChatGPT 隐含地「为此发展了一种理论」。

这个理论可能是什么样的？好吧，有一个很小的角落基本上已经为人所知两千年，那就是逻辑学。当然，在亚里士多德发现的三段论形式中，逻辑基本上是一种表明遵循某些模式的句子是合理的，而其他句子则不合理的方式。例如，合理地说「所有 X 都是 Y。这不是 Y，所以它不是 X」（如「所有鱼都是蓝色的。这不是蓝色的，所以它不是鱼。」）。就像人们可以有点幽默地想象亚里士多德通过审查（机器学习风格）大量的修辞例子来发现三段论逻辑一样，人们也可以想象，在 ChatGPT 的训练中，它能够通过查看大量的网络文本等来「发现三段论逻辑」。（是的，因此可以期望 ChatGPT 产生包含基于三段论逻辑等的「正确推理」的文本，但当涉及到更复杂的形式逻辑时，情况就完全不同了 —— 我认为可以预期它会因为同样的原因（无法匹配括号）而失败。）

但除了逻辑这一狭窄的例子之外，关于如何系统地构建（或识别）甚至看似有意义的文本，还有什么可以说的呢？是的，有像 Mad Libs 那样使用非常特定的「短语模板」的东西。但不知怎的，ChatGPT 隐含地有一种更通用的方法来做到这一点。也许除了「当你有 1750 亿个神经网络权重时，不知怎的就发生了」，没有什么可以说的。但我强烈怀疑有一个更简单、更有力的故事。

### 14. Meaning Space and Semantic Laws of Motion

We discussed above that inside ChatGPT any piece of text is effectively represented by an array of numbers that we can think of as coordinates of a point in some kind of "linguistic feature space". So when ChatGPT continues a piece of text this corresponds to tracing out a trajectory in linguistic feature space. But now we can ask what makes this trajectory correspond to text we consider meaningful. And might there perhaps be some kind of "semantic laws of motion" that define—or at least constrain—how points in linguistic feature space can move around while preserving "meaningfulness"?

So what is this linguistic feature space like? Here's an example of how single words (here, common nouns) might get laid out if we project such a feature space down to 2D:

We saw another example above based on words representing plants and animals. But the point in both cases is that "semantically similar words" are placed nearby.

As another example, here's how words corresponding to different parts of speech get laid out:

Of course, a given word doesn't in general just have "one meaning" (or necessarily correspond to just one part of speech). And by looking at how sentences containing a word lay out in feature space, one can often "tease apart" different meanings—as in the example here for the word "crane" (bird or machine?):

OK, so it's at least plausible that we can think of this feature space as placing "words nearby in meaning" close in this space. But what kind of additional structure can we identify in this space? Is there for example some kind of notion of "parallel transport" that would reflect "flatness" in the space? One way to get a handle on that is to look at analogies:

And, yes, even when we project down to 2D, there's often at least a "hint of flatness", though it's certainly not universally seen.

So what about trajectories? We can look at the trajectory that a prompt for ChatGPT follows in feature space—and then we can see how ChatGPT continues that:

There's certainly no "geometrically obvious" law of motion here. And that's not at all surprising; we fully expect this to be a considerably more complicated story. And, for example, it's far from obvious that even if there is a "semantic law of motion" to be found, what kind of embedding (or, in effect, what "variables") it'll most naturally be stated in.

In the picture above, we're showing several steps in the "trajectory"—where at each step we're picking the word that ChatGPT considers the most probable (the "zero temperature" case). But we can also ask what words can "come next" with what probabilities at a given point:

And what we see in this case is that there's a "fan" of high-probability words that seems to go in a more or less definite direction in feature space. What happens if we go further? Here are the successive "fans" that appear as we "move along" the trajectory:

Here's a 3D representation, going for a total of 40 steps:

And, yes, this seems like a mess—and doesn't do anything to particularly encourage the idea that one can expect to identify "mathematical-physics-like" "semantic laws of motion" by empirically studying "what ChatGPT is doing inside". But perhaps we're just looking at the "wrong variables" (or wrong coordinate system) and if only we looked at the right one, we'd immediately see that ChatGPT is doing something "mathematical-physics-simple" like following geodesics. But as of now, we're not ready to "empirically decode" from its "internal behavior" what ChatGPT has "discovered" about how human language is "put together".

我们之前讨论过，在 ChatGPT 内部，任何一段文本实际上都是由一系列数字表示的，我们可以将其视为某种「语言特征空间」中点的坐标。因此，当 ChatGPT 继续一段文本时，这相当于在语言特征空间中追踪出一条轨迹。但现在我们可以问，是什么使这条轨迹对应于我们认为有意义的文本。是否也许存在某种「语义运动定律」，定义或至少限制语言特征空间中的点如何移动，同时保持「有意义」？

那么，这个语言特征空间是什么样的呢？下面是一个例子，展示了如果我们将这样的特征空间投影到二维空间，单个单词（这里是常见名词）可能如何布局：

我们在上面看到了另一个基于代表植物和动物的词汇的例子。但在这两种情况中，关键点是「语义上相似的词汇」被放置在附近。

作为另一个例子，这里是不同词性的单词如何布局：

当然，一个给定的单词通常不只有「一个意义」（或者不一定只对应一个词性）。通过查看包含某个单词的句子在特征空间中的布局，人们通常可以「分辨出」不同的含义 —— 就像这里的单词「crane」（鹤或机器？）的例子：

好的，至少我们可以设想这个特征空间将「意义上接近的词汇」放置在空间中的靠近位置。但我们能在这个空间中识别出什么额外的结构呢？例如，是否存在某种「平行转移」的概念，反映空间的「平坦性」？了解这一点的一种方法是查看类比：

是的，即使我们将其投影到二维空间，通常也至少会有一种「平坦性的暗示」，尽管这种情况当然并非普遍存在。

那么轨迹呢？我们可以观察 ChatGPT 提示在特征空间中的轨迹，然后我们可以看到 ChatGPT 如何继续这个轨迹：

在这里并没有看到「几何上明显」的运动规律。这并不令人惊讶；我们完全预期这是一个更复杂的故事。例如，即使确实存在「语义运动定律」，用哪种嵌入（或实际上是哪种「变量」）来自然陈述它也远非明显。

在上图中，我们展示了「轨迹」的几个步骤 —— 在每个步骤中，我们选择 ChatGPT 认为最可能的词（「零温度」情况）。但我们也可以问，在某一点上哪些词可以「接下来出现」，以及相应的概率是多少：

在这种情况下，我们看到的是一个在特征空间中似乎朝着一个或多或少明确方向的高概率词汇「扇形」。如果我们走得更远会发生什么？这里是我们在「沿着」轨迹「移动」时出现的连续「扇形」：

这里是一个总共 40 步的 3D 表示：

1『所以之前看那个评测 M3 的哔站视频，UP 跑贪吃蛇的时候说，跑了多少步。（2023-11-24）』

是的，这看起来很乱，并没有特别鼓励人们认为可以通过实证研究「ChatGPT 内部在做什么」来确定「类似数学物理的」「语义运动定律」。但也许我们只是在看「错误的变量」（或错误的坐标系），如果我们看到正确的变量，我们会立即看到 ChatGPT 在做一些「数学物理上简单」的事情，比如遵循测地线。但截至目前，我们还没有准备好通过其「内部行为」来「实证解码」ChatGPT 所「发现」的关于人类语言是如何「组合在一起」的。

### 15. Semantic Grammar and the Power of Computational Language

What does it take to produce "meaningful human language"? In the past, we might have assumed it could be nothing short of a human brain. But now we know it can be done quite respectably by the neural net of ChatGPT. Still, maybe that's as far as we can go, and there'll be nothing simpler—or more human understandable—that will work. But my strong suspicion is that the success of ChatGPT implicitly reveals an important "scientific" fact: that there's actually a lot more structure and simplicity to meaningful human language than we ever knew—and that in the end there may be even fairly simple rules that describe how such language can be put together.

As we mentioned above, syntactic grammar gives rules for how words corresponding to things like different parts of speech can be put together in human language. But to deal with meaning, we need to go further. And one version of how to do this is to think about not just a syntactic grammar for language, but also a semantic one.

For purposes of syntax, we identify things like nouns and verbs. But for purposes of semantics, we need "finer gradations". So, for example, we might identify the concept of "moving", and the concept of an "object" that "maintains its identity independent of location". There are endless specific examples of each of these "semantic concepts". But for the purposes of our semantic grammar, we'll just have some general kind of rule that basically says that "objects" can "move". There's a lot to say about how all this might work (some of which I've said before). But I'll content myself here with just a few remarks that indicate some of the potential path forward.

It's worth mentioning that even if a sentence is perfectly OK according to the semantic grammar, that doesn't mean it's been realized (or even could be realized) in practice. "The elephant traveled to the Moon" would doubtless "pass" our semantic grammar, but it certainly hasn't been realized (at least yet) in our actual world—though it's absolutely fair game for a fictional world.

When we start talking about "semantic grammar" we're soon led to ask "What's underneath it?" What "model of the world" is it assuming? A syntactic grammar is really just about the construction of language from words. But a semantic grammar necessarily engages with some kind of "model of the world"—something that serves as a "skeleton" on top of which language made from actual words can be layered.

Until recent times, we might have imagined that (human) language would be the only general way to describe our "model of the world". Already a few centuries ago there started to be formalizations of specific kinds of things, based particularly on mathematics. But now there's a much more general approach to formalization: computational language.

And, yes, that's been my big project over the course of more than four decades (as now embodied in the Wolfram Language): to develop a precise symbolic representation that can talk as broadly as possible about things in the world, as well as abstract things that we care about. And so, for example, we have symbolic representations for cities and molecules and images and neural networks, and we have built-in knowledge about how to compute about those things.

And, after decades of work, we've covered a lot of areas in this way. But in the past, we haven't particularly dealt with "everyday discourse". In "I bought two pounds of apples" we can readily represent (and do nutrition and other computations on) the "two pounds of apples". But we don't (quite yet) have a symbolic representation for "I bought".

It's all connected to the idea of semantic grammar—and the goal of having a generic symbolic "construction kit" for concepts, that would give us rules for what could fit together with what, and thus for the "flow" of what we might turn into human language.

But let's say we had this "symbolic discourse language". What would we do with it? We could start off doing things like generating "locally meaningful text". But ultimately we're likely to want more "globally meaningful" results—which means "computing" more about what can actually exist or happen in the world (or perhaps in some consistent fictional world).

Right now in Wolfram Language we have a huge amount of built-in computational knowledge about lots of kinds of things. But for a complete symbolic discourse language we'd have to build in additional "calculi" about general things in the world: if an object moves from A to B and from B to C, then it's moved from A to C, etc.

Given a symbolic discourse language we might use it to make "standalone statements". But we can also use it to ask questions about the world, "Wolfram|Alpha style". Or we can use it to state things that we "want to make so", presumably with some external actuation mechanism. Or we can use it to make assertions—perhaps about the actual world, or perhaps about some specific world we're considering, fictional or otherwise.

Human language is fundamentally imprecise, not least because it isn't "tethered" to a specific computational implementation, and its meaning is basically defined just by a "social contract" between its users. But computational language, by its nature, has a certain fundamental precision—because in the end what it specifies can always be "unambiguously executed on a computer". Human language can usually get away with a certain vagueness. (When we say "planet" does it include exoplanets or not, etc.?) But in computational language we have to be precise and clear about all the distinctions we're making.

It's often convenient to leverage ordinary human language in making up names in computational language. But the meanings they have in computational language are necessarily precise—and might or might not cover some particular connotation in typical human language usage.

How should one figure out the fundamental "ontology" suitable for a general symbolic discourse language? Well, it's not easy. Which is perhaps why little has been done since the primitive beginnings Aristotle made more than two millennia ago. But it really helps that today we now know so much about how to think about the world computationally (and it doesn't hurt to have a "fundamental metaphysics" from our Physics Project and the idea of the ruliad).

But what does all this mean in the context of ChatGPT? From its training ChatGPT has effectively "pieced together" a certain (rather impressive) quantity of what amounts to semantic grammar. But its very success gives us a reason to think that it's going to be feasible to construct something more complete in computational language form. And, unlike what we've so far figured out about the innards of ChatGPT, we can expect to design the computational language so that it's readily understandable to humans.

When we talk about semantic grammar, we can draw an analogy to syllogistic logic. At first, syllogistic logic was essentially a collection of rules about statements expressed in human language. But (yes, two millennia later) when formal logic was developed, the original basic constructs of syllogistic logic could now be used to build huge "formal towers" that include, for example, the operation of modern digital circuitry. And so, we can expect, it will be with more general semantic grammar. At first, it may just be able to deal with simple patterns, expressed, say, as text. But once its whole computational language framework is built, we can expect that it will be able to be used to erect tall towers of "generalized semantic logic", that allow us to work in a precise and formal way with all sorts of things that have never been accessible to us before, except just at a "ground-floor level" through human language, with all its vagueness.

We can think of the construction of computational language—and semantic grammar—as representing a kind of ultimate compression in representing things. Because it allows us to talk about the essence of what's possible, without, for example, dealing with all the "turns of phrase" that exist in ordinary human language. And we can view the great strength of ChatGPT as being something a bit similar: because it too has in a sense "drilled through" to the point where it can "put language together in a semantically meaningful way" without concern for different possible turns of phrase.

So what would happen if we applied ChatGPT to underlying computational language? The computational language can describe what's possible. But what can still be added is a sense of "what's popular"—based for example on reading all that content on the web. But then—underneath—operating with computational language means that something like ChatGPT has immediate and fundamental access to what amount to ultimate tools for making use of potentially irreducible computations. And that makes it a system that can not only "generate reasonable text", but can expect to work out whatever can be worked out about whether that text actually makes "correct" statements about the world—or whatever it's supposed to be talking about.

生成「有意义的人类语言」需要什么？在过去，我们可能会认为这不亚于一个人脑的工作。但现在我们知道，ChatGPT 的神经网络也能相当体面地完成这项工作。尽管如此，也许这就是我们能走的极限，不会有更简单或更易于人类理解的方法。但我强烈怀疑，ChatGPT 的成功隐含地揭示了一个重要的「科学」事实：有意义的人类语言实际上比我们所知的有更多的结构和简单性，并且最终可能存在相当简单的规则来描述这种语言是如何组合在一起的。

正如我们上面提到的，句法语法为不同词性的单词在人类语言中的组合提供了规则。但要处理意义，我们需要更进一步。做这件事的一种方法是考虑不仅仅是语言的句法语法，还有语义语法。

为了句法，我们识别诸如名词和动词等。但为了语义，我们需要更「细微的区分」。例如，我们可能会识别「移动」的概念，以及「独立于位置保持其身份」的「物体」的概念。这些「语义概念」有无数具体例子。但对于我们的语义语法来说，我们只需要一些大致的规则，基本上说「物体」可以「移动」。关于这一切如何工作有很多要说的（我之前说过一些）。但在这里，我将满足于只提几点，表明一些可能的前进道路。

值得一提的是，即使一个句子完全符合语义语法，也并不意味着它在实践中已经实现（或甚至能够实现）。「大象去了月球」无疑会通过我们的语义语法，但它当然尚未在我们的实际世界中实现（至少目前还没有）—— 尽管它绝对适用于一个虚构的世界。

当我们开始讨论「语义语法」时，我们很快就会问「它的底层是什么？」它假设了什么样的「世界模型」？句法语法实际上只是关于如何从单词构建语言。但语义语法必然涉及某种「世界模型」—— 这个模型作为一个「骨架」，实际单词构成的语言可以在其上层叠。

直到最近，我们可能会想象（人类）语言将是描述我们的「世界模型」的唯一通用方式。几个世纪前，特别是基于数学，就开始有了特定事物的形式化。但现在有了一种更通用的形式化方法：计算语言。

是的，这已经是我四十多年来的重大项目（现在体现在 Wolfram 语言中）：开发一种精确的符号表示，尽可能广泛地讨论世界上的事物，以及我们关心的抽象事物。因此，例如，我们有城市、分子、图像和神经网络的符号表示，并且我们内置了关于如何计算这些事物的知识。

经过几十年的工作，我们以这种方式涵盖了许多领域。但在过去，我们并没有特别处理「日常对话」。在「我买了两磅苹果」中，我们可以轻松地表示（并对）「两磅苹果」进行营养和其他计算。但我们还没有（完全）为「我买了」制作符号表示。

这一切都与语义语法的概念相关 —— 目标是拥有一个通用的符号「概念构建工具包」，为我们提供什么能与什么相匹配的规则，从而为我们可能转化为人类语言的「流程」提供规则。

但假设我们拥有这种「符号话语语言」。我们会用它做什么呢？我们可以从生成「局部有意义的文本」开始。但最终我们可能会希望更「全球意义上」的结果 —— 这意味着要更多地「计算」关于在世界中（或某些一致的虚构世界中）实际存在或发生的事物。

目前在 Wolfram 语言中，我们拥有大量关于许多种事物的内置计算知识。但对于完整的符号话语语言，我们必须建立额外的关于世界上一般事物的「计算规则」：如果一个物体从 A 移动到 B，然后从 B 移动到 C，那么它就从 A 移动到了 C，等等。

鉴于符号话语语言，我们可以用它来做「独立陈述」。但我们也可以用它来询问有关世界的问题，「Wolfram|Alpha 风格」。或者我们可以用它来陈述我们「想要实现的事物」，大概是通过某种外部驱动机制。或者我们可以用它来做出断言 —— 也许是关于实际世界的，或者也许是关于我们正在考虑的某个特定世界，无论是虚构的还是其他。

人类语言从根本上来说是不精确的，不仅因为它不是「锚定」在特定的计算实现上，而且其含义基本上仅由其使用者之间的「社会契约」定义。但计算语言，由于其本质，具有一定的基本精确性 —— 因为最终它所指定的内容总是可以「在计算机上明确执行」。人类语言通常可以容忍一定程度的模糊性。（当我们说「行星」时，它包括系外行星吗？等等）但在计算语言中，我们必须对我们所做的所有区分都精确而清晰。

利用普通人类语言来构造计算语言中的名称通常很方便。但它们在计算语言中的含义必然是精确的 —— 可能涵盖或可能不涵盖典型人类语言使用中的某些特定含义。

弄清楚适合通用符号话语语言的基本「本体论」应该如何界定并不容易。这也许就是为什么自从亚里士多德两千多年前的初步尝试以来，几乎没有进展。但今天我们对如何以计算方式思考世界的了解已经大大增强，这无疑是一个巨大的帮助（我们的物理项目和 ruliad 的「基本形而上学」概念也起到了作用）。

那么，这一切在 ChatGPT 的背景下意味着什么呢？通过它的训练，ChatGPT 实际上已经「拼凑」了相当多的等同于语义语法的内容。但它的成功给了我们一个理由，让我们相信构建更完整的计算语言形式是可行的。而且，与我们目前对 ChatGPT 内部了解的情况不同，我们可以期望设计计算语言，使其容易被人类理解。

当我们讨论语义语法时，我们可以类比于三段论逻辑。起初，三段论逻辑基本上是关于用人类语言表达的陈述的一系列规则。但（是的，两千年后）当形式逻辑被发展出来后，三段论逻辑的原始基本构造就可以用来构建包括现代数字电路运作等在内的巨大的「形式化建筑物」。我们也可以期望，对于更广泛的语义语法也将是如此。一开始，它可能只能处理简单的模式，例如以文本形式表达的。但一旦整个计算语言框架建立起来，我们可以期待它将能够被用来建立「通用语义逻辑」的高塔，使我们能够以精确和形式化的方式处理以前除了通过人类语言在「底层」上，带有所有其模糊性的情况下，从未能够接触到的各种事物。

我们可以将计算语言和语义语法的构建视为代表一种最终的压缩，用以代表事物。因为它使我们能够谈论可能发生的事物的本质，而不需要处理普通人类语言中存在的所有「转述」。我们可以将 ChatGPT 的巨大优势视为类似的东西：因为它也以某种意义上「穿透了」，达到了一个点，在这个点上，它可以「以有语义意义的方式组合语言」，而不用关心不同可能的措辞。

那么，如果我们将 ChatGPT 应用于底层的计算语言会发生什么呢？计算语言可以描述可能发生的事情。但仍然可以增加的是基于阅读网络上所有内容的「流行度」的感觉。但在此之下，使用计算语言意味着像 ChatGPT 这样的系统可以直接并基本地使用潜在的不可约简计算的终极工具。这使它不仅能够「生成合理文本」，而且可以预期弄清楚该文本是否对世界或其所讨论的任何事物做出了「正确」的陈述。

### 16. So … What Is ChatGPT Doing, and Why Does It Work?

The basic concept of ChatGPT is at some level rather simple. Start from a huge sample of human-created text from the web, books, etc. Then train a neural net to generate text that's "like this". And in particular, make it able to start from a "prompt" and then continue with text that's "like what it's been trained with".

As we've seen, the actual neural net in ChatGPT is made up of very simple elements—though billions of them. And the basic operation of the neural net is also very simple, consisting essentially of passing input derived from the text it's generated so far "once through its elements" (without any loops, etc.) for every new word (or part of a word) that it generates.

But the remarkable—and unexpected—thing is that this process can produce text that's successfully "like" what's out there on the web, in books, etc. And not only is it coherent human language, it also "says things" that "follow its prompt" making use of content it's "read". It doesn't always say things that "globally make sense" (or correspond to correct computations)—because (without, for example, accessing the "computational superpowers" of Wolfram|Alpha) it's just saying things that "sound right" based on what things "sounded like" in its training material.

The specific engineering of ChatGPT has made it quite compelling. But ultimately (at least until it can use outside tools) ChatGPT is "merely" pulling out some "coherent thread of text" from the "statistics of conventional wisdom" that it's accumulated. But it's amazing how human-like the results are. And as I've discussed, this suggests something that's at least scientifically very important: that human language (and the patterns of thinking behind it) are somehow simpler and more "law like" in their structure than we thought. ChatGPT has implicitly discovered it. But we can potentially explicitly expose it, with semantic grammar, computational language, etc.

What ChatGPT does in generating text is very impressive—and the results are usually very much like what we humans would produce. So does this mean ChatGPT is working like a brain? Its underlying artificial-neural-net structure was ultimately modeled on an idealization of the brain. And it seems quite likely that when we humans generate language many aspects of what's going on are quite similar.

When it comes to training (AKA learning) the different "hardware" of the brain and of current computers (as well as, perhaps, some undeveloped algorithmic ideas) forces ChatGPT to use a strategy that's probably rather different (and in some ways much less efficient) than the brain. And there's something else as well: unlike even in typical algorithmic computation, ChatGPT doesn't internally "have loops" or "recompute on data". And that inevitably limits its computational capability—even with respect to current computers, but definitely with respect to the brain.

It's not clear how to "fix that" and still maintain the ability to train the system with reasonable efficiency. But to do so will presumably allow a future ChatGPT to do even more "brain-like things". Of course, there are plenty of things that brains don't do so well—particularly involving what amount to irreducible computations. And for these both brains and things like ChatGPT have to seek "outside tools"—like Wolfram Language.

But for now it's exciting to see what ChatGPT has already been able to do. At some level it's a great example of the fundamental scientific fact that large numbers of simple computational elements can do remarkable and unexpected things. But it also provides perhaps the best impetus we've had in two thousand years to understand better just what the fundamental character and principles might be of that central feature of the human condition that is human language and the processes of thinking behind it.

ChatGPT 的基本概念在某种程度上相当简单。从网络、书籍等收集大量人类创造的文本样本开始。然后训练一个神经网络，使其生成「类似于这些」的文本。特别是，使其能够从一个「提示」开始，然后继续生成「与其训练内容相似」的文本。

正如我们所见，ChatGPT 中的实际神经网络由非常简单的元素组成，尽管它们有数十亿个。神经网络的基本操作也非常简单，本质上是将其生成的文本的输入「单次通过其元素」（没有任何循环等），以产生它生成的每个新单词（或单词的一部分）。

但令人惊讶且出乎意料的是，这个过程可以产生与网络上、书籍中等地方的文本「相似」的文本。这不仅是连贯的人类语言，它还「说出」了「根据提示」并利用它「阅读过」的内容的东西。它并不总是说出「全局上有意义」的事情（或对应于正确的计算）—— 因为（例如，未能访问 Wolfram|Alpha 的「计算超能力」）它只是说出一些基于其训练材料中的「听起来正确」的事情。

ChatGPT 的具体工程设计使其非常引人注目。但归根结底（至少在它能使用外部工具之前），ChatGPT 只是从它积累的「传统智慧统计」中提取出一些「连贯的文本线索」。但它的结果令人惊讶地类似于人类，正如我所讨论的，这表明至少在科学上非常重要的一点：人类语言（及其背后的思维模式）在其结构上比我们认为的要简单得多，更具有「法则性」。ChatGPT 已经隐含地发现了这一点。但我们可以通过语义语法、计算语言等显式地展示出来。

ChatGPT 在生成文本方面的表现令人印象深刻，其结果通常非常类似于我们人类所产生的内容。那么，这是否意味着 ChatGPT 的运作方式类似于大脑？它的基础人工神经网络结构最初是基于对大脑的理想化模型。当我们人类生成语言时，很可能许多正在进行的活动在很多方面都是相似的。

当涉及到训练（也就是学习）时，大脑和当前计算机的不同「硬件」（以及可能一些未开发的算法思想）迫使 ChatGPT 使用一种可能与大脑相当不同（在某些方面效率远低）的策略。还有另外一个因素：与典型的算法计算不同，ChatGPT 在内部并没有「循环」或「重新计算数据」。这不可避免地限制了它的计算能力 —— 即使与当前计算机相比也是如此，但与大脑相比更是如此。

目前尚不清楚如何「解决这个问题」，同时仍然保持合理效率地训练系统的能力。但为了做到这一点，将使未来的 ChatGPT 能够做更多「类脑的事情」。当然，有很多大脑不擅长的事情 —— 特别是涉及到实质上不可约简的计算。在这些方面，无论是大脑还是像 ChatGPT 这样的系统都需要寻求「外部工具」—— 比如 Wolfram 语言。

但目前看到 ChatGPT 已经能够做到的事情是令人兴奋的。在某种程度上，它是一个伟大的科学事实的绝佳示例，即大量简单的计算元素可以做出惊人且意想不到的事情。但它也可能是我们在两千年里最好的动力，以更好地理解人类语言及其背后的思维过程的基本特征和原则，这是人类条件的核心特征。

### Thanks

I've been following the development of neural nets now for about 43 years, and during that time I've interacted with many people about them. Among them—some from long ago, some from recently, and some across many years—have been: Giulio Alessandrini, Dario Amodei, Etienne Bernard, Taliesin Beynon, Sebastian Bodenstein, Greg Brockman, Jack Cowan, Pedro Domingos, Jesse Galef, Roger Germundsson, Robert Hecht-Nielsen, Geoff Hinton, John Hopfield, Yann LeCun, Jerry Lettvin, Jerome Louradour, Marvin Minsky, Eric Mjolsness, Cayden Pierce, Tomaso Poggio, Matteo Salvarezza, Terry Sejnowski, Oliver Selfridge, Gordon Shaw, Jonas Sjöberg, Ilya Sutskever, Gerry Tesauro and Timothee Verdier. For help with this piece, I'd particularly like to thank Giulio Alessandrini and Brad Klee.

我已经关注神经网络的发展大约 43 年了，在这段时间里，我与许多人就这个话题进行了交流。其中一些人是很久以前的，一些是最近的，还有一些是跨越多年的，包括：Giulio Alessandrini、Dario Amodei、Etienne Bernard、Taliesin Beynon、Sebastian Bodenstein、Greg Brockman、Jack Cowan、Pedro Domingos、Jesse Galef、Roger Germundsson、Robert Hecht-Nielsen、Geoff Hinton、John Hopfield、Yann LeCun、Jerry Lettvin、Jerome Louradour、Marvin Minsky、Eric Mjolsness、Cayden Pierce、Tomaso Poggio、Matteo Salvarezza、Terry Sejnowski、Oliver Selfridge、Gordon Shaw、Jonas Sjöberg、Ilya Sutskever、Gerry Tesauro 和 Timothee Verdier。在撰写这篇文章时，我特别感谢 Giulio Alessandrini 和 Brad Klee 的帮助。

### Additional Resources

[Machine Learning for Middle Schoolers—Stephen Wolfram Writings](https://writings.stephenwolfram.com/2017/05/machine-learning-for-middle-schoolers/)

[Introduction to Machine Learning](https://www.wolfram.com/language/introduction-machine-learning/)

[Wolfram U Classes and Courses](https://www.wolfram.com/wolfram-u/courses/catalog/?topic=machine-learning)