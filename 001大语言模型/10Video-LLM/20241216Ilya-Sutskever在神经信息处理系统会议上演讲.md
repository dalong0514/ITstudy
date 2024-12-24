## 20241216Ilya-Sutskever在神经信息处理系统会议上演讲

I want to thank the organizers for choosing a paper for this award. It was very nice. And I also want to thank my incredible co-authors and collaborators, Oriel Vinyals and Kwok Lee, who stood right before you a moment ago.

我要感谢组织者为这个奖项选择了我的论文，这真是令人愉快。同时，我也要感谢我的杰出合著者和合作者 Oriel Vinyals 和 Kwok Lee，他们刚才就站在大家面前。

What you have here is an image, a screenshot, from a similar talk 10 years ago at New Rips in 2014 in Montreal. It was a much more innocent time. Here we are shown in the photos. This is the before. Here's the after, by the way. And now we've got my experienced, hopefully visor.

这是一张图片的截图，来自十年前 2014 年在蒙特利尔举行的 New Rips 会议上的一个类似演讲。那时是个比较单纯的年代。这里我们在照片中展示。这是「之前」的样子。顺便说，这是「之后」的样子。希望现在我能成为一个经验丰富的指导者。






But here I'd like to talk a little bit about the work itself and maybe a 10-year retrospective on it. Because a lot of the things in this work were correct, but some not so much. We can review them and we can see what happened and how it gently flowed to where we are today.

在这里，我想稍微谈谈这项工作的内容，并回顾一下过去十年的发展历程。在这项工作中，很多事情都是正确的，但也有一些并不是完全正确。我们可以回顾这些内容，看看它们的变化过程，以及是如何逐步发展到今天的状况的。

Let's begin by talking about what we did. The way we'll do it is by showing slides from the same talk we gave 10 years ago. The summary of what we did can be boiled down to the following three bullet points. It's an autoregressive model trained on text. It's a large neural network. And it's a large data set. And that's it.

我们来回顾一下我们所做的工作。为此，我们将展示与 10 年前相同演讲的幻灯片。我们的工作可以总结为以下三点：第一，这是一个在文本上训练的自回归模型。第二，它是一个大型神经网络。第三，它使用了大型数据集。

Now let's dive into the details a little bit more. So, this was a slide from 10 years ago. Not too bad. The deep learning hypothesis. What we said here is that if you have a large neural network with 10 layers, then it can do anything that a human being can do in a fraction of a second.

现在让我们更深入地探讨一下细节。这是一张 10 年前的幻灯片，效果还不错。这里讨论的是深度学习假设。我们提到，如果拥有一个由 10 层组成的大型神经网络，那么它可以在不到一秒的时间内完成任何人类能够做到的事情。

Why did we have this emphasis on things that human beings can do in a fraction of a second? Why this thing specifically? Well, if you believe the deep learning dogma, so to say, that artificial neurons and...

我们为什么要特别关注那些人类能在瞬间完成的任务呢？为什么会特别选择这一点？如果你相信所谓的深度学习信条，也就是说，人工神经元和...

Biological neurons are similar, or at least not too different, and you believe that real neurons are slow, then anything that we can do quickly, by we, I mean human beings. I even mean just one human in the entire world. If there is one human in the entire world that can do some task in a fraction of a second, then a 10-layer neural network can do it too, right? It follows.

生物神经元彼此相似，或者至少没有太大差异。如果假设你认为真实的神经元反应缓慢，那么任何人类能够快速完成的事情，即便全世界只有一个人能在瞬间完成某个任务，那么一个 10 层的神经网络也应该能够做到。这是一个合理的推论。

You just take their connections and you embed them inside your neural net, the artificial one. So this was the motivation. Anything that a human being can do in a fraction of a second, a big 10-layer neural network can do too.

你只需要将这些连接嵌入到人工神经网络中。这就是背后的动机。任何人类能在一秒内完成的任务，一个拥有 10 层的大型神经网络也能做到。

We focused on 10-layer neural networks because this was the neural networks we knew how to train back in the day. If you could go beyond in your layers somehow, then you could do more. But back then, we were just starting to understand the possibilities.

我们专注于 10 层神经网络，因为当时我们只知道如何训练这种网络。如果能增加层数，就可以实现更多功能。但在那时，我们才刚刚开始了解其中的可能性。

Then, we could only do 10 layers, which is why we emphasized whatever human beings can do in a fraction of a second. A different slide from the talk, a slide which says our main idea. And you may be able to recognize two things, or at least one thing. You might be able to recognize that something autoregressive is going on here.

当时，我们的技术只能实现 10 层，因此我们强调了人类可以在瞬间完成的任务。在演讲中有一张幻灯片展示了我们的主要理念。您可能会识别出两件事，或者至少一件。其中一个是这里涉及到自回归的过程。

What is it saying really? What does this slide really say? This slide says that if you have an autoregressive model, and it predicts the next token well enough, then it will in fact grab and capture and grasp the correct distribution over sequences that come next. And this was a relatively new thing.

这段内容实际上是想说，如果你有一个自回归模型，它可以很好地预测下一个 Token，那么它就能够掌握接下来序列的正确分布。这是一个相对较新的研究发现。

It wasn't literally the first ever autoregressive neural network, but I would argue it was the first autoregressive neural network where we really believed that if you...

尽管它并不是第一个自回归神经网络，但我认为它是第一个让我们真正相信其潜力的自回归神经网络。

Train it really well, then you will get whatever you want. In our case, back then it was the humble, today humble, then incredibly audacious task of translation.

未找到意译内容

Now I'm going to show you some ancient history that many of you may have never seen before. It's called the LSTM. To those unfamiliar, an LSTM is the thing that poor deep learning researchers did before transformers. It's basically a ResNet, but rotated 90 degrees.

现在我将向你展示一些许多人可能从未见过的过去的技术。这就是 LSTM。对于那些不太了解的人来说，LSTM 是在 Transformer 出现之前，深度学习研究人员曾经使用的一种方法。可以这样理解：它和 ResNet 有点类似，但在处理方式上有些不同。

So that's an LSTM. It came before, it's like a slightly more complicated ResNet. You can see there is your integrator, which is now called the residual stream, but you've got some multiplication going on. It's a little bit more complicated, but that's what we did; it was a ResNet.

这就是 LSTM。它出现在 ResNet 之前，结构上稍微复杂一些。你可以看到，有一个类似积分器的部分，现在被称为残差流，同时还包含一些乘法运算。虽然稍微复杂一些，但这就是我们当时的做法；它实际上是一个 ResNet。

Rotated 90 degrees, another cool feature from that old talk that I want to highlight is that we used parallelization. But not just any parallelization, we used pipelining as witnessed by this one layer per GPU. Was it wise to pipeline? As we now know, pipelining is not wise. But we were not as wise back then. So we used that and we got a 3.5x speedup using eight GPUs.

在那次旧演讲中，我想强调的另一个很酷的特性是我们实现了并行化处理。我们不仅仅是一般的并行化，而是采用了流水线处理，因为每个 GPU 上都只处理一层。后来我们了解到，流水线处理并不是最佳选择，但当时我们并没有这样的认识。因此，我们当时采用了这种方法，并使用八个 GPU 实现了 3.5 倍的加速。

And the conclusion slide, in some sense, the conclusion slide from the talk from back then is the most important slide because it spelled out what could arguably be the beginning of the scaling hypothesis, right? That if you have a very big data set and you train a very big neural network, then success is guaranteed. And one can argue, if one is charitable, that this indeed has been what's been happening.

在某种意义上，当时演讲的结论幻灯片是最为关键的，因为它明确指出了规模假设的初步想法。也就是说，拥有一个巨大的数据集并训练一个庞大的神经网络，理论上可以确保成功。可以说，这一理念确实在逐步实现。

I want to mention one...

The other idea, and this is, I claim, the idea that truly stood the test of time, is the core idea of deep learning itself. It's the idea of connectionism. It's the idea that if you allow yourself to believe that an artificial neuron is kind of sort of like a biological neuron, right?

我想提到一个重要的理念……

另一个深刻的理念，我认为，这个理念真正经受住了时间的考验，就是深度学习的核心理念 —— 连接主义。这个理念的核心在于，如果我们愿意相信人工神经元类似于生物神经元，那么就可以理解深度学习的基础。

If you believe that one is kind of sort of like the other, then it gives you the confidence to believe that very large neural networks, they don't need to be literally human brain scale. They might be a little bit smaller, but you could configure them to do pretty much all the things that we do as human beings.

如果你认为某个事物与另一个有一定程度的相似性，这种想法可以让你相信，非常大的神经网络不必达到人类大脑的规模。虽然它们的规模可能较小，但通过适当配置，也能够执行我们人类几乎所有的任务。

There's still a difference, oh I forgot the then, there is still a difference because the human brain also figures out how to reconfigure itself. Whereas we are using the best learning algorithms that we have developed so far.

尽管如此，仍然存在差异，因为人类大脑能够自我重构，而我们则依赖于迄今为止所开发的最佳学习算法。

We have, which require as many data points as there are parameters. Human beings are still better in this regard. But what this led, so I claim, arguably, is to the age of pre-training. 

我们需要的数据点数量通常与参数数量相等。在这方面，人类的表现仍然略胜一筹。但我认为，这种情况无疑促成了预训练时代的到来。

And the age of pre-training is what we might say the GPT-2 model, the GPT-3 model, the scaling laws. I want to specifically call out my former collaborators, Alec Radford, also Jared Kaplan, Dario Amode, for really making this work. But that led to the age of pre-training. 

我们可以说，像 GPT-2 和 GPT-3 模型，以及缩放定律，代表了预训练的时代。我想特别感谢我以前的合作者 Alec Radford、Jared Kaplan 和 Dario Amode，他们的贡献使这些工作成为可能，这也开启了预训练的时代。

And this is what's been the driver of all of progress, all the progress that we see today. Extra-large neural networks, extraordinarily large neural networks train on huge data sets. But pre-training as we know it will unquestionably end. 

这就是推动我们如今所见所有进步的原因：超大型神经网络，它们在庞大的数据集上进行训练。然而，传统意义上的预训练无疑将会结束。

Pre-training will end. Why will it end? Because while compute is growing through better hardware,

Better algorithms and larger clusters; all those things keep increasing your compute. The data is not growing because we have but one internet. We have but one internet. You could even go as far as to say that data is the fossil fuel of AI. It was created somehow, and now we use it, and we've achieved peak data, and there'll be no more. We have to deal with the data that we have.

预训练的时代可能即将结束。为什么会这样呢？尽管我们的计算能力正在不断提升，这是因为硬件性能的提升、更优化的算法和更大规模的计算集群共同作用，这些都在推动计算能力的增长。然而，数据量却没有相应地增加，因为我们的数据来源基本上就是唯一的互联网。可以把数据比作 AI 的「化石燃料」：它们以某种方式生成，如今被我们广泛使用，然而我们似乎已经达到了「数据峰值」，再难获得更多新数据。因此，我们需要更好地利用现有的数据资源。

Now, it still lets us go quite far, but this is only one internet. So here I'll take a bit of liberty to speculate about what comes next. Actually, I don't need to speculate because many people are speculating too, and I'll mention their speculations.

如今，互联网仍然给予我们很大的探索空间，但这毕竟只是一个互联网。因此，我想稍微畅想一下未来的发展。其实，我并不需要自己去猜测，因为许多人已经在进行这样的推测，我会分享一些他们的观点。

You may have heard the phrase "agents." It's common, and I'm sure you are familiar with it.

Sure that eventually something will happen, but people feel like something agents is the future. More concretely, but also a little bit vaguely, synthetic data. But what does synthetic data mean? Figuring this out is a big challenge. I'm sure that different people have all kinds of interesting progress there.

你可能听说过「智能体」这个词。这是一个常见的术语，我相信你对此并不陌生。

人们普遍认为智能体代表着未来，虽然具体的情况尚不明确，但合成数据的概念逐渐引起关注。那么，什么是合成数据呢？弄清楚合成数据的意义是一个巨大的挑战。我相信在这一领域，不同的人都取得了各种有趣的进展。

An inference time compute, or maybe what's been most recently, most vividly seen in O1, the O1 model, these are all examples of things of people trying to figure out what to do after pre-training. Those are all very good things to do.

推理时间计算，或者说是最近在 O1 模型中被生动展示的内容，都是人们在预训练之后探索下一步行动的例子。这些尝试都是非常有价值的。

I want to mention one other example from biology, which I think is really cool. And the example is this. So about many, many years ago, at this conference also, I saw a talk where someone presented this graph. But the graph showed the relationship...

我想和大家分享一个我认为非常有趣的生物学例子。这个例子是这样的。许多年前，我在一次会议上看到一位演讲者展示了一张图。这张图展示了某种关系……

In the study of biology, there's often a fascinating relationship between the size of a mammal's body and the size of its brain, measured in mass. I vividly remember a talk where this rare example of a tight correlation was highlighted, amidst the usual complexities of biological systems. It piqued my curiosity.

在生物学研究中，哺乳动物的身体大小和大脑大小（以质量计算）之间通常有一种有趣的关系。我记得一次演讲中提到这种罕见的相关性，在复杂的生物系统中显得特别突出。这激起了我的好奇心。

Randomly intrigued by this graph they discussed, I decided to delve deeper. I turned to Google, seeking out this graph for further exploration. As I searched through Google Images, I stumbled upon an interesting image.

因为对他们讨论的图表产生了好奇，我决定深入研究一下。我在 Google 上搜索这个图表，希望能进一步探索。在浏览 Google 图片时，我意外地发现了一张有趣的图片。

In this image, you could see a variety of mammals. It was quite engaging to observe the diverse range of mammals depicted. Interestingly, I wondered if the mouse functionality was active. Thankfully, it was, allowing me to interact with the image and explore these mammals further.

在这张图片中，展示了各种哺乳动物。观察这些多样化的哺乳动物非常有趣。我好奇鼠标功能是否已激活。幸运的是，它已激活，这让我能够与图片互动，进一步探索这些哺乳动物。

Alright, so we have all the different mammals. Then you've got non-human primates, which are basically the same thing. But then, you have the hominids. To my knowledge, hominids are like close relatives to humans in evolution, like the Neanderthals. There's a bunch of them, including Homo habilis, maybe. There's a whole bunch, and they're all here.

好吧，哺乳动物有很多种类。再来是非人类灵长类动物，它们与哺乳动物有很多相似之处。接着是人科动物（hominids），据我所知，它们是人类在进化上的近亲，例如尼安德特人。有许多种类，包括能人（Homo habilis）等，它们都属于这一类。

What's interesting is that they have a different slope on their brain-to-body scaling exponent. So that's pretty cool. What that means is there is a precedent, an example of biology figuring out some kind of different scaling. Something clearly is different, so I think that is cool.

有趣的是，它们在大脑和身体比例的变化上表现出不同的趋势。这意味着生物学上存在一种不同的比例调整方式，这是一个很好的例子。显然，情况确实有所不同，这确实很有意思。

By the way, I want to highlight that this x-axis is a log scale. You see, this is 100, this is 1,000, 10,000, 100,000, and likewise in grams: 1 gram, 10 grams, 100 grams.

需要注意的是，这个 x 轴采用了对数刻度。可以看到，数值从 100 到 1,000，再到 10,000 和 100,000；对于克的单位也是如此，从 1 克到 10 克，再到 100 克。

So it is possible for things to be different. The things that we are doing, the things that we've been scaling so far is actually the first thing that we figured out how to scale. Without a doubt, the field, everyone who's working here, will figure out what to do.

因此，情况可能会有所不同。我们目前所做的，以及迄今为止扩展的工作，实际上是我们首次掌握如何进行扩展的项目。毫无疑问，所有在这一领域工作的人都将找到解决方案。

But I want to talk here, I want to take a few minutes and speculate about the longer term. The longer term. Where are we all headed? Right? We're making all this progress. It's astounding progress. It's really, I mean, those of you who've been in the field 10 years ago and you remember just how incapable everything has been.

我想在这里花几分钟时间来畅想一下未来的发展方向。我们正在取得令人惊叹的进步，真的，想想 10 年前在这个领域工作的人们，那时候我们是多么的力不从心。

Even if you kind of say, of course, deep learning, still to see it is just unbelievable. It's completely, I can't convey that feeling to you. You know, if you've joined this journey, you've seen the transformation.

即便你可能已经听说过深度学习，但亲眼见证它的发展仍然令人难以置信。这种感受是难以用语言传达的。如果你参与了这段旅程，你一定见证了它的巨大转变。

In the field in the last two years, of course, you speak to computers, and they talk back to you and they disagree. That's what computers are. But it hasn't always been the case.

在过去的两年里，我们与计算机的互动变得越发自然。你可以与计算机对话，它们会回应你，甚至有时候会持不同意见。然而，并不是一直以来都是这样的。

I want to talk a little bit about superintelligence, just a bit. Because that is obviously where this field is headed. This is obviously what's being built here. The thing about superintelligence is that it will be different qualitatively from what we have.

我想简单谈谈超级智能。因为这个领域显然正在朝这个方向发展。这正是我们正在构建的东西。超级智能的问题在于，它在质量上将不同于我们现有的智能。

My goal in the next minute is to try to give you some concrete intuition of how it will be different so that you yourself could reason about it. Right now, we have our incredible language models. They're unbelievable chatbots, and they can even do things, but they're also kind.

在接下来的这一分钟里，我希望能让你对这种变化有一个具体的感受，以便你自己能够进行推理。目前，我们拥有强大的大语言模型。这些模型作为聊天机器人表现非常出色，甚至能完成一些任务，同时也表现得很友好。

The systems we're discussing are strangely unreliable and often get confused, yet they also exhibit dramatically superhuman performance in evaluations. This presents a challenge in understanding how to reconcile these contradictions. However, eventually, sooner or later, we will achieve a new milestone.

我们正在讨论的系统表现出奇怪的不可靠性，并且经常出现困惑，但在评估中却展现出超越人类的表现。这使得我们面临如何协调这些矛盾的挑战。然而，最终，我们将达到新的里程碑。

These systems are actually going to become agentic in significant ways. Right now, they are not agents in any meaningful sense. Well, that might be a bit too strong. They are very, very slightly agentic, just beginning to show signs of agency.

这些系统实际上将在某些重要方面变得更像智能体。目前，它们在任何有实际意义的情况下都称不上是智能体。不过，这可能说得有些过分。它们只是非常轻微地表现出智能体特性，刚刚开始显示出智能体的迹象。

Moreover, they will actually start to reason. Speaking of reasoning, I want to mention that the more a system reasons, the more unpredictable it becomes. This unpredictability is a key characteristic. Up until now, all the deep learning we're familiar with has been very predictable because it focused on replicating human intuition.

此外，这些系统实际上将开始具备推理能力。谈到推理，我想指出，系统的推理能力越强，其行为就越难以预测。这种不可预测性是其一个重要特征。迄今为止，我们所熟知的深度学习一直是可预测的，因为它主要专注于模仿人类的直觉。

It's like the gut feel. If you come back to the 0.1 second reaction time, what kind of processing we do in our brains, well, it's our intuition. So we've endowed our AIs with some of that intuition.

这就像我们的直觉。如果你考虑到 0.1 秒的反应时间，我们的大脑会进行某种快速处理，这其实就是我们的直觉。因此，我们也为我们的 AI 赋予了一些这样的直觉能力。

But reasoning, and you're seeing some early signs of that, reasoning is unpredictable. One reason to see that is because the chess AIs, the really good ones, are unpredictable to the best human chess players. So we will have to be dealing with AI systems that are incredibly unpredictable.

推理能力是不可预测的，而我们已经看到了其中的一些早期迹象。一个例子是国际象棋 AI，那些非常优秀的 AI 对于顶尖的人类国际象棋选手来说，行为往往是不可预测的。因此，我们将面临处理极其不可预测的 AI 系统的挑战。

They will understand things from limited data. They will not get confused, all the things which are really big limitations. I'm not saying how, by the way, and I'm not saying when. I'm saying that it will.

他们将能够从有限的数据中理解事物，而不会感到困惑，这些能力是当前技术的重大限制。不过，我并没有说明具体的实现方法或时间。我只是在说，这种情况终将发生。

And when all those things will happen together with self-awareness, because why not? Self-awareness.

This is useful. It is part, you, ourselves, are parts of our own world models. When all those things come together, we will have systems of radically different qualities and properties that exist today. And of course, they will have incredible and amazing capabilities. 

当所有这些特性与自我意识结合在一起时，为什么不呢？自我意识是非常有价值的。

这是非常有用的，因为我们自己就是我们世界模型的一部分。当所有这些元素汇聚在一起时，我们将拥有在质量和特性上与当今截然不同的系统。这些系统当然会具备令人难以置信和惊人的能力。

But the kind of issues that come up with systems like this, and I'll just leave it as an exercise to imagine, it's very different from what we're used to. And I would say that it's definitely also impossible to predict the future. Really, all kinds of stuff is possible. 

至于这样的系统会出现哪些问题，我就留给大家自行想象了，这与我们通常所见的情况非常不同。我认为，预测未来是不可能的。事实上，任何事情都有可能发生。

But on this uplifting note, I will conclude. Thank you so much. Thank you. Thank you. Thank you. 

Now in 2024, are there other biological structures that are part of human cognition that you think are worth exploring in a similar way or that you're interested in?

说到这里，我想以积极的态度来结束。非常感谢大家的聆听。

那么，到了 2024 年，是否有其他生物结构作为人类认知的一部分，值得我们以类似的方式进行探索，或者是你感兴趣的呢？

Anyway, so, the way I'd answer this question is that if you are, or someone is, a person who has a specific insight about, "Hey, we are all being extremely silly because clearly the brain does something and we are not," and that's something that can be done, they should pursue it. I personally don't.

无论如何，我会这样回答：如果你或其他人对某事有独到的见解，比如说，「我们其实很傻，因为显然大脑能做到一些我们无法做到的事情」，那么他们应该去追求这个方向。我个人没有这种见解。

Well, it depends on the level of abstraction you're looking at. Maybe I'll answer it this way: there's been a lot of desire to make biologically inspired AI. And you could argue on some level that biologically inspired AI is incredibly successful, which is all of the plonin is biologically inspired AI.

这取决于你从哪个抽象层次来看待这个问题。可以这样说：许多人一直希望创造受生物学启发的 AI。从某种角度来看，这类 AI 已经非常成功，因为所有被称为 plonin 的东西都是受生物学启发的 AI。

But on the other hand, the biological inspiration was very, very, very modest. It's like, "Let's use neurons." This is the full extent.

The concept of biological inspiration, such as using neurons, has been discussed extensively. More detailed biological inspiration has been very hard to come by. But I wouldn't rule it out completely. I think if someone has a special insight, they might be able to see something, and that would be useful.

但另一方面，生物学灵感极其有限。就像是，「我们来使用神经元吧。」仅此而已。

虽然使用神经元这样的生物学灵感已经被广泛讨论，但更详细的生物学灵感仍然难以获取。不过，我不会完全否定这种可能性。我认为如果有人有特别的见解，他们可能会看到一些有价值的东西。

I have a question for you about sort of autocorrect. So here's the question. You mentioned reasoning as being one of the core aspects of maybe the modeling in the future and maybe a differentiator.

未找到意译内容

What we saw in some of the poster sessions is that hallucinations in today's models, the way we're analyzing, I mean, maybe you correct me, you're the expert on this, but the way we're analyzing whether a model is hallucinating today, without, because we know of the dangers of models not being able to reason, that we're using a statistical analysis.

我们在一些海报展示会上观察到，目前我们在分析模型中的幻觉现象时，使用的是统计分析方法。由于我们知道模型无法进行推理存在的风险，所以用这种方法来判断模型是否出现幻觉现象。也许在这方面你是专家，可以更正我的看法。

Let's say some amount of standard deviations or whatever away from the mean. In the future, do you think that a model given reasoning will be able to correct itself, sort of auto-correct itself? That will be a core feature of future models, so there won't be as many hallucinations because the model will recognize when, maybe that's too esoteric of a question, but the model will be able to reason and understand when a hallucination is occurring. Does the question make sense?

假设有一些数据点偏离均值若干标准差。在未来，你认为具有推理能力的模型是否能够自动纠正自身错误，就像自动修正一样？这种功能将成为未来模型的核心特点，这样一来，模型产生错误信息的情况会减少，因为模型能够识别并理解何时出现错误信息（可能这个问题有些复杂）。这个问题的表达是否清楚？

Yes, and the answer is also yes. I think what you described is extremely highly plausible. I mean, you should check. I wouldn't rule out that it might already be happening with some of the early reasoning models of today. I don't know. But longer term, why not?

是的，我认为你所描述的情况是非常可能的。你应该检查一下，或许这种情况已经在一些早期的推理模型中出现了。从长远来看，为什么不可能呢？

It's a core feature of Microsoft Word, like autocorrect. Yeah, I just, I mean, I think calling it autocorrect is really doing a disservice. I think you are, when you say autocorrect, you evoke like, it's far grander than autocorrect, but this point aside, the answer is yes. Thank you.

这是 Microsoft Word 的一个核心功能，可以与自动更正功能相提并论。虽然我觉得把它叫做自动更正有些低估了它的强大功能，但答案仍然是肯定的。谢谢。

Hi, Elia. I loved the ending, mysteriously leaving out, do they replace us or are they superior? Do they need rights? It's a new species of homo sapien spawned intelligence. So maybe they need, I mean, I think the RL guy thinks they think, you know, we need rights for these things.

嗨，Elia。我喜欢这个结尾，神秘地留下了悬念：他们会取代我们吗？还是他们更优秀？他们需要权利吗？这是一种由智人衍生出的新型智能生命。所以也许他们需要 —— 我的意思是，我觉得那个强化学习（RL）的专家认为我们应该为这些存在赋予权利。

I have an unrelated question to that. How do you create the right incentive mechanisms for humanity to actually create it in a way that gives it the freedoms that we have as homo sapiens?

未找到意译内容

Mo sapiens? You know, I feel like this, in some sense, those are the kind of questions that people should be reflecting on more. But... To your question about what incentive structure should we create, I don't feel that I know. I don't feel confident answering questions like this because it's like you're talking about creating some kind of a top-down structure, government thing, I don't know. 

关于「莫智人」的问题，我觉得这确实是人们应该多加反思的。然而，至于我们该设计怎样的激励结构，我并没有明确的答案。我对回答这种问题没有信心，因为这涉及到创建某种自上而下的结构，类似政府的体系，而我对此并不清楚。

It could be a cryptocurrency, too. Yeah. I mean, tensor you know there's things I don't feel like I am the right person to comment on cryptocurrency but, but you know there is a chance by the way with what you're describing will happen, that indeed we will have... 

未找到意译内容

You know, in some sense, it's not a bad end result. If you have AIs and all they want is to coexist with us and also just to have rights, may.

Be that will be fine. It's... But I don't know. I mean, I think things are so incredibly unpredictable. I hesitate to comment, but I encourage the speculation. Thank you.

你知道，从某种角度来看，这样的结果其实也不错。如果 AI 只希望与我们和平共存，并且只是想要拥有一些权利，也许这并不坏。只是…… 我不太确定。我只是觉得事情真的太不可预测了。我虽然犹豫要不要发表评论，但我还是鼓励大家去猜测。谢谢。

And yeah, thank you for the talk. It's really awesome. Hiya there. Thank you for the great talk. My name is Shalev Lifshitz from University of Toronto, working with Sheila. Thanks for all the work you've done.

未找到意译内容

I wanted to ask, do you think LLMs generalize multi-hop reasoning out of distribution? So okay, the question assumes that the answer is yes or no, but the question should not be answered with yes or no. Because what does it mean out of distribution generalization? What does it mean? What does it mean in distribut...

未找到意译内容

What does it mean to generalize? And what does it mean out of distribution? Because it's a test of time talk, I'll say that long, long ago, before people were using deep learning, they were using things like string matching, n-grams. For machine translation, people were using statistical phrase tables. Can you imagine? They had tens of thousands of lines of code of complexity, which was, I mean, it was truly unfathomable.

什么是泛化？什么是分布外？在讨论这个历经时间考验的话题时，我们可以回忆起很久以前，那时人们还没有使用深度学习，而是依赖于字符串匹配和 n-grams。对于机器翻译，使用的是统计短语表。你能想象吗？当时的代码复杂到成千上万行，实在让人难以想象。

Back then, generalization meant, is it literally not the same phrasing as in a data set? Now we may say, well, sure, my model achieves this high score on, I don't know, math competitions, but maybe the math, maybe some discussion in some forum on the internet was about the same ideas, and therefore it's memorized.

在过去，泛化指的是模型生成的内容是否与数据集中的措辞不完全相同。而现在，我们可能会说，我的模型在数学竞赛中取得了很高的分数，但也许这些数学题或者互联网论坛上的一些讨论涉及相同的概念，因此模型只是将其记忆下来。

Well, okay, you could say maybe it's in distribution, maybe it's memorization, but I also think...

I think that our standards for what counts as generalization have increased really quite substantially, dramatically, unimaginably, if you keep track. And so I think the answer is, to some degree, probably not as well as human beings. I think it is true that human beings generalize much better. But at the same time, they definitely generalize out of distribution to some degree. I hope it's a useful tautological answer.

好吧，你也许会说这可能是因为分布，或者是因为记忆，但我认为……

如果你一直关注的话，会发现我们对什么算作泛化的标准提升得非常快、非常大，甚至难以想象。因此，我认为在某种程度上，答案可能是这些系统还不如人类。人类的确在泛化方面表现得更好。然而，它们确实在某种程度上超出了原有分布进行泛化。我希望这是一个有用的答案。

Thank you. Unfortunately, we're out of time for this session. I have a feeling we could go on for the next six hours. But thank you so much, Ilya, for the talk. Thank you. It was wonderful.

谢谢大家。很遗憾，我们这次交流的时间到了。我感觉我们还能继续聊上六个小时。非常感谢你，Ilya，感谢你的精彩演讲。谢谢，真的很棒。