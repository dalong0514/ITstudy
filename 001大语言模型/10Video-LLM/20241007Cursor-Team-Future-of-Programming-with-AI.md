## 20241007Cursor-Team-Future-of-Programming-with-AI

发言人 1 00：52 And now，dear friends，here's Michael Sule，Arvid，and Aman. All right，this is awesome. We have Michael Aman Swale，Arvid here from

the cursor team. First up，big ridiculous question，what's the point of a codeeditor? 

现在，亲爱的朋友们，这是迈克尔·苏尔、阿维德和一个人。好吧，这太棒了。我们有来自 Cursor 团队的迈克尔·阿曼·斯维尔和阿尔维德。首先，一

个荒谬的大问题，代码编辑器的意义是什么？

发言人 2 01：10 So the code editor is largely the place where you build

software and today or for a long time，that's meant the place where you text，edit a formal programming language. And for people who aren't

programmers，the way to think of a code editor is like a really souped up

word processor for programmers，where the reason is it's souped up is

code has a lot of structure. And so the quote unquote word processor，the

code editor can actually do a lot for you that word processors，you know,

sort of in the writing space haven't been able to do for people editing text there. And so，you know，that's everything from giving you visual

differentiation of like the actual tokens in the code so you can scan it quickly to letting you navigate around the code base，sort of like you're navigating around the internet with like hyperlinks. You're going to sort of definitions of things that you're using to error checking，you know，to catch rudimentary

bugs. And so traditionally，that's what a code editor has meant. I think that

what a code editor is，is going to change a lot over the next 10 years as what it means to build software maybe starts to look a bit different. 因此，代码编辑器在很大程度上是您构建软件的地方，而今天或很长一段时间，它意味着您

编写文本，编辑正式编程语言的地方。对于非程序员来说，代码编辑器就像是

一个专为程序员设计的加强版字处理器，原因是代码有很多结构。因此，所谓

的文字处理器，即代码编辑器实际上可以为你做很多事情，而文字处理器，你

知道，在写作领域中，对于那些在那里编辑文本的人来说，是无法做到的。所

以，你知道，这包括从给你代码中实际标记的视觉区分，以便你可以快速扫描它，到让你在代码库中导航，有点像你使用超链接在互联网上导航一样。你将

会对你用来进行错误检查的东西进行分类定义，以捕捉基本的错误。传统上，

这就是代码编辑器的含义。我认为代码编辑器是什么，在未来 10 年中会发生很

大的变化，因为构建软件的意义可能开始看起来有些不同。

发言人 1 02：16 I think also coded should just be fun. 我认为编码也应该很有趣。

发言人 3 02：19 Yes，that is very important. That is very important. And it's

actually sort of an underrated aspect of how we decide what to build. Like a lot of the things we build，and then we try them out，we do an experiment，and then we actually throw them out because they're not fun. And so a big part of being fun is like being fast. A lot of the time，fast is fun. 是的，这非常重要。这非常重要。这实际上是我们如何决定建造什么的一个被低估的方面。

就像我们建造的很多东西一样，然后我们尝试一下，做一个实验，然后我们实

际上把它们扔掉了，因为它们不好玩。所以快乐的很大一部分就像是快速。很

多时候，快速是一种乐趣。

发言人 1 02：42 Yeah，that，yeah，that should be a T shirt. 是的，那应该是一件 T 恤。

发言人 2 02：48 Like fundamentally，I think one of the things that draws a lot of people to building stuff on computers is this like insane integration

speed where，you know，in other disciplines，you might be sort of gate

cappella by resources or the ability，even the ability，you know，to get a

large group together. And coding is this like amazing thing where it's you in the computer and that alone can you can build really cool stuff really

quickly. 从根本上讲，我认为吸引很多人在计算机上构建东西的原因之一就是

这种疯狂的集成速度，你知道，在其他学科中，你可能会因为资源或能力而被拒绝，甚至能力，你知道，聚集一大群人。而编码就是这样一件令人惊奇的事

情，你在电脑中，仅凭这一点，你就可以非常快速地构建出非常酷的东西。

发言人 1 03：09 So for people to know cursor is this super cool new editor

that's a fork of Vs code，it would be interesting to get your kind of

explanation of your own journey of editors. How did you? I think all of you or were big fans of Vs Code with Copilot，how did you arrive to Vs Code

and how did that lead to your journey with Cursor. 因此，为了让人们知道

Cursor 是这个超酷的新编辑器，它是 Cursor 的分支，获得您自己的编辑旅程的解释将会很有趣。你怎么了？我认为你们所有人都是 Cursor 和 Copilot 的忠实粉丝，你们是如何接触到 Cursor 的，以及这如何导致你的 Cursor 之旅的。

发言人 4 03：33 yeah? I think a lot of us，all of us were originally Vim users.

Pure，pure，pure vim. Yeah，no neo vim，just pure vim in a terminal. And at least，at least for myself，it was around the time that Copilot came out，so

2021 that I really wanted to try it. So I went into Vscode，the only platform，the only code editor in which it was available. And even though l，you know，really enjoyed using Vim，just the experience of Copilot with with Vs Code was more than good enough to convince me to switch. And so that kind of was the default until we started working on cursor. 是吗？我认为我们中的很多人，我们所有人最初都是 Vim 用户。纯净，纯净，纯净的 vim。是的，没有新

vim，只是终端中的纯 vim。至少对我自己来说，大约是 Copilot 出现的时候，

2021 年我真的很想尝试一下。所以我进入了 Vscode，这是唯一可用的平台，

唯一可用的代码编辑器。即使我真的很喜欢使用 Vim，只是 Copilot 与 Cursor 的体验足够好，足以说服我转换。所以在我们开始处理 Cursor 之前，这种情况是

默认的。

发言人 1 04：14 And maybe we should explain what Copilot does. It's like a really nice autocomplete. It suggests as you start writing a thing，it suggests one or two or three lines how to complete the thing. And there is a fun

experience in that，you know，like when you have a close friendship and

your friend completes your sentences，like when it's done well，there's an

intimate feeling，there's probably a better word than intimate，but there's a，there's a cool feeling of like，holy shit，it gets me . 也许我们应该解释一下

Copilot 是做什么的。这就像是一个非常好的自动补全。它建议当你开始写一件

事情时，它会建议一、两、三行如何完成这件事情。而且有一种有趣的经历，

就像当你有一个亲密的友谊，你的朋友完成你的句子时，就像当它做得好时，

有一种亲密的感觉，可能有一个比亲密更好的词，但是有一个，有一种很酷的

感觉，天啊，它得到了我。

发言人 304：44now. 现在。

发言人 1 04：44 And then there's an unpleasant feeling when it doesn't get

you. And so there's that that kind of friction，but the I would say for a lot of

people，the feeling that it gets me overpowers that it doesn't. 当它没有得到你时，会有一种不愉快的感觉。所以就有那种摩擦，但我会说很多人觉得它让

我压倒了它不会。

发言人 3 04：55 and I think actually one of the underrated aspects of GitHub Copilot is that even when it's wrong is it's like a little bit annoying，but it's not that bad because you just type another character and then maybe then it

gets you or you type another character，and then then it gets you. So even

when it's wrong is not that bad. 我认为 GitHub Copilot 被低估的一个方面是，

即使它是错误的，它也有点烦人，但它并不那么糟糕，因为你只是输入另一个

角色，然后它可能会得到你，或者你输入另一个角色，然后它会得到你。所以

即使它是错误的也不是那么糟糕。

发言人 5 05：09 Yeah，you can sort of iterate，iterate and fix it. I mean，the other underrated part of Copilot for me sort of was just the first real，real Al product. It's like the first language model，consumer product. 是的，你可以迭代，迭代并修复它。我的意思是，Copilot 中另一个被低估的部分就是第一个

真正的 A | 产品。这就像第一种语言模型，消费者产品。

发言人 1 05：21 So copil was kind of like the first killer app for LLMs. 所以

copil 有点像 LLMs 的第一个杀手级应用程序。

发言人 205：27 and like the beta was out in 2021. 就像测试版在 2021 年推出一样。

发言人 1 05：29 right? Okay，so what's the origin story of cursor? 对吗？好

的，那么 Cursor 的起源是什么？

发言人 2 05：34 So around 2020， the scaling loss papers came out from from OpenAl and that was a moment where this looked like clear，predictable

progress for the field，where even if we didn't have any more ideas，looks

like you can make these models a lot better if you had more computing,

more data. 因此，在 2020 年左右，OpenAl 发布了缩放损失论文，这是一个看起来清晰、可预测的领域进展的时刻，即使我们没有更多的想法，看起来如果

你有更多的计算和数据，你可以让这些模型变得更好。

发言人 1 05：49 By the way，we'l probably talk for 3 to 4 hours on the topic of scaling laws. But justjust to summarize，it's a paper and a set of papers，a set of ideas that say bigger might be better for model size and data size. In therealm of machine learning. 顺便说一句，我们可能会花 3 到 4 个小时讨论缩放

定律这个话题。但只是为了总结一下，这是一篇论文和一组论文，一组想法，

认为越大可能对模型大小和数据大小更好。在机器学习领域。

发言人 5 06：05 it's bigger and better，but predictably better. 它更大更好，但可以预见更好。

发言人 1 06：08 Okay，there's another topic of conversation. 好的，还有另一个话题。

发言人 2 06：10 But yeah，so around that time，for some of us，there were like a lot of conceptual conversations about what's this going to look like?

What's the story going to be for all these different rent knowledge worker fields about how they're going to be made better by this technology

getting better? And then I think there were a couple of moments where like the theoretical gains predicted in that paper started to feel really concrete，and it started to feel like a moment where you could actually go and not，you do a Phd if you wanted to work on do useful work in Al，actually felt like now there was this，this whole set of systems 1 could build that were really useful. And I think that the first moment we already talked about a little bit，which was playing with the early bit of Copilot，like that was awesome andmagical. 但是，是的，在那个时候，对于我们中的一些人来说，有很多概念性

的对话，关于这将会是什么样子？对于所有这些不同的知识工作者领域来说，

如何通过这项技术变得更好来使他们变得更好的故事是什么？然后我认为有几

个时刻，论文中预测的理论收益开始变得非常具体，开始感觉像是一个你可以

去的时刻，而不是，如果你想在 AI 方面做有用的工作，你就可以去做一个研

究，实际上感觉现在有一整套系统 1 可以构建，非常有用。我认为我们已经谈

了一点的第一个时刻，那就是玩早期的 Copilot，就像那样，非常棒和神奇。

发言人 2 06：51 I think that the next big moment where everything kind of clicked together was actually getting early access to GPT-4. So it was sort of end of 2022 was when we were tinkering with that model and the step up Inca felt enormous. And previous to that，we had been working on a couple of different projects. We had been because of Copilot，because of scaling odds，because of our prior interest in the technology，we had been

tinkering around with tools for programmers，but things that are like very

specific. So you know，we were building tools for financial professionals who have to work with a Jupiter notebook or like playing around with，can you

do static analysis with these models? And then the stuff up in GPT-4 felt like，look，that really made concrete create the theoretical gains that we had

predicted before，felt like you could build a lot more just immediately at thatpoint in time. 我认为下一个重要的时刻，所有事情都在一起，实际上是尽早获得 GPT-4。所以在 2022 年年底，当我们正在修补那个模型时，Inca 感觉迈出了巨大的一步。在此之前，我们一直在从事几个不同的项目。我们一直是因为

Copilot，因为扩展赔率，因为我们之前对技术感兴趣，我们一直在为程序员修

补工具，但是那些非常具体的东西。所以你知道，我们正在为需要使用 Jupiter

笔记本或喜欢玩弄的金融专业人士构建工具，你可以使用这些模型进行静态分

析吗？然后 GPT-4 中的东西感觉，看，这确实使我们之前预测的理论收益具体

化，感觉在那个时候你可以立即建立更多的东西。

发言人 207：40And. 而且。

发言人 407：41 also. 还有。

发言人 2 07：43 if we were being consistent，it really felt like this wasn't just

going to be a point solution thing. This was going to be all of programming was going to flow through these models. And it felt like that demanded a

different type of programming environment，a different type of

programming. And so we set off to build that，that sort of larger vision

around that. 如果我们保持一致性，真的感觉这不仅仅是一个点解决方案的事情。这将是所有编程都将流经这些模型。感觉这就需要一种不同类型的编程环

境，一种不同类型的编程。所以我们着手建立那个更大的愿景。发言人 508：00 There's one that I distinctly remember. So my roommate is an

Imo gold winner，and there's a competition in the us called the Putnam，which is sort of the Imo for college people. It's this math competition isis exceptionally good. So Sheng Tong and man，I remember it's sort of so JuneJune 2022 had this bet on whether the Mo like 2024 June or July，you

were going to win a gold medal in the Imo with the with like models imos. 有一个我清楚地记得。所以我的室友是一个国际移民组织的金牌得主，在美国

有一个叫做普特南的比赛，这是一种针对大学生的国际移民组织。这个数学竞

赛非常棒。所以 Sheng Tong 和 man，我记得它有点像 2022 年的月，押注于是像 2024 年的月还是七月，你将在 lmo 中获得像 imos 模型一样的金牌。

发言人 1 08：31 and international math Olympian. 和国际数学奥林匹克。

发言人 5 08：33 Yeah Imo international math Olympiad. And so Arvid and I are both，you know，also competed in it. So it was sort of personal and I remember thinking Matt just this is not going to happen this was like，like even though I sort of believed in progress，I thought，you know I'm a girl，just like a modest，just delusional. That was the，that was the，and to be

honest，I mean，I was to be clear，very wrong，but that was maybe the most prescient bet in the group. 是的，Imo 国际数学奥林匹克竞赛。所以你知道，阿尔维德和我也在其中竞争。所以这是有点个人的想法，我记得这不会发生，

就像即使我有点相信进步，我想，你知道我是一个女孩，就像一个谦虚的，只

是妄想。说实话，我的意思是，我说得很清楚，非常错误，但这可能是小组中

最有先见之明的赌注。

发言人 1 09：05 So the new results from DeepMind，it turned out that youwere correct. 因此，来自 DeepMind 的新结果证明你是正确的。

发言人 409：10 That's what technically not in Correctress. 这就是技术上在矫正中不正确的地方。

发言人 2 09：14 one point away. Oman was very enthusiastic about that stuff. And before Iman had this like scaling lost t.e.r.r.o.r.d.d. want，it had the like charts and like the formulas on it. 一点远。阿曼对那些东西非常热情。在 Iman 有这个像缩放一样失去了 t.e.r.o.r.d. 之前。想要，它上面有像图表和公式一样的东西。

发言人 1 09：25 So you like felt the A. 所以你喜欢感受 A。

发言人 4 09：27 or you felt the scale? Yeah，I distinctly remember there was this one conversation I had with Michael where before I hadn't thought

super deeply and critically about scaling laws. And he kind of posed the

question，why isn't scaling all you need? Or why isn't scaling going to result in massive gains in progress? And I think I went through like the like the

stages of grief. There is anger，denial，and then finally at the end，just

thinking about it，acceptance. And I think I've been quite hopeful and

optimistic about progress since. 还是你感觉到了规模？是的，我清楚地记得我和迈克尔有过一次谈话，以前我没有非常深入和批判性地思考过缩放定律。

他有点提出了一个问题，为什么不扩展你所需要的一切？或者为什么扩展不会

导致巨大的进展？我想我经历了悲伤的阶段。有愤怒，否认，最后在最后，只

是思考一下，接受。我认为从那以后我一直对进展充满希望和乐观。

发言人 4 10：03 I think one thing I'll caveat is I think it also depends on like which domains you're going to see progress. Math is a great domain

because especially like formal，they are improving because you get this

fantastic signal of actually verifying if the thing was correct. And so this

means something like RL can work really，really well. And I think like you

could have systems that are perhaps very superhuman at math and still nottechnically have AGI. 我认为需要提醒的一件事是，我认为这也取决于你将看到哪些领域取得了进展。数学是一个伟大的领域，因为特别像正式的一样，它

们正在改进，因为你得到了实际验证事物是否正确的奇妙信号。因此，这意味

着像 RL 这样的东西可以非常非常好地工作。我认为你可能拥有在数学上非常超

人的系统，但在技术上仍然没有 AGI。

发言人 1 10：27 Okay，so can we take it all the way to cursor? And what is

cursor? It's a fork of Vs Code，and Vs Code is one of the most popular

editors for a long time. Like everybody fell in love with it，everybody left

Vim，I left Dmax for it，sorry. So unified in some fundamental way，the

developer community. And then you look at the space of things. You look at the scaling laws. 好的，那么我们可以把它一直带到 Cursor 吗？Cursor 是什么？它是 Cursor 的一个分支，Cursor 长期以来一直是最受欢迎的编辑器之一。就像每个人都喜欢它一样，每个人都离开了 Vim，我离开了 Dmax，对不起。在

某种根本的方面，开发者社区是如此统一。然后你看事物的空间。你看看缩放

定律。

发言人 1 10：55 Al is becoming amazing and you decided，okay，it's not

enough to just write an extension fee Vs code because there's a lot of

limitations to that we need if Al is going to keep getting better and better and better，we need to really like rethink how the Al is going to be part of the editing process. And so he decided to fork Vs Code and start to build a lot of the amazing features，will be able to talk about，but what was that

decision like because there's a lot of extensions including Copilot of Vs

Code that are doing sort of Al type stuff. What was the decision like to justfork Vs Code? Al 正在变得越来越惊人，你决定，好吧，仅仅编写扩展费用和代码是不够的，因为如果 AI 要变得越来越好，我们需要很多限制。我们需要真

正重新思考 AI 将如何成为编辑过程的一部分。因此，他决定分叉 Cursor，并开

始构建许多惊人的功能，将能够谈论，但这个决定是什么样的，因为有很多扩展，包括做着 Al 类型的 Cursor 的 Copilot。只是分叉和代码的决定是什么样的？ 发言人 211：33 So the decision to do an editor seemed kind of self evident in to us for at least what we wanted to do and achieve because when we

started working on the editor，the idea was these models are going to get much better. Their capabilities are going to improve，and it's going to

entirely change how you build software，both in A，you will have big

productivity gains，but also radical and now like the active building software is going to change a lot. And so you're very limited in the control you have over a code editor if you're a plug into an existing coding environment. And we didn't want to get locked in by those limitations. We wanted to be able to just build the most useful stuff. 所以做编辑器的决定似乎在我们看来是不言而喻的，至少就我们想做和实现的事情而言，因为当我们开始开发编辑器时，

我们的想法是这些模型将变得更好。他们的能力将会提高，它将会彻底改变你

构建软件的方式，这不仅会极大地提高生产力，而且还会激进，现在主动构建

软件也将发生很大变化。因此，如果您是现有编码环境的插件，那么您对代码

编辑器的控制非常有限。我们不想被这些限制所束缚。我们希望能够构建最有

用的东西。

发言人 1 12：07 Okay，well then the natural question is，you know Vs Code is kind of with Copilot a competitor，so how do you win? Is it basically just the speed and the quality of the features? 好的，那么自然的问题是，你知道

Cursor 有点像 Copilot 和竞争对手，那么你怎么赢呢？它基本上只是功能的速度和质量吗？

发言人 4 12：20 Yeah，I mean，I think this is a space that is quite interesting，perhaps quite unique，where if you look at previous tech waves，maybe

there's kind of one major thing that happened and unlock a new wave of companies. But every single year，every single model capability or jump，you get model capabilities，you now unlock this new wave of features,

things that are possible，especially in programming. And so I think in Al

programming，being even just a few months ahead，let alone a year ahead，makes your product much，much，much more useful. I think the cursor a

year from now will need to make the cursor of today look obsolete. And I

think，you know，Microsoft，we've done a number of like fantastic things，but I don't think they're in a great place to really keep innovating and pushing on this in the way that a startup can . 是的，我的意思是，我认为这是一个非常有趣的空间，也许是非常独特的，如果你看看以前的科技浪潮，也许会发现

发生了一件重大的事情，并解锁了一个新的公司浪潮。但是每一年，每一个模

型能力或跳跃，你都可以获得模型能力，你现在可以解锁这一波新的功能，这

是可能的，特别是在编程方面。因此，我认为在人工智能编程中，即使只是提

前几个月，更不用说提前一年，也会使您的产品变得更加有用。我认为一年后

的 Cursor 需要让今天的 Cursor 看起来过时。我认为，你知道，微软，我们做了很多很棒的事情，但我不认为他们处于一个很好的位置，不能像初创公司那样

真正地继续创新和推进。

发言人 1 13：13 just rapidly implementing features. 只是快速实现功能。

发言人 4 13：15 and push，yeah，like and kind of doing the research

experimentation necessary to really push the ceiling. 并且推动，是的，像是在做必要的研究实验，以真正推动天花板。

发言人 5 13：23 I don't know if I think of it in terms of features that I think of it in terms of like capabilities for programmers，it's that like，you know，as you know，the new one model came out and I'm sure there are going to be

more more models of different types like longer context in maybe faster,

like there's all these crazy ideas that you can try and hopefully 10 of the

crazy ideas we will make it into something kind of cool and useful and we want people to have that sooner to rephrase. It's like an underrated fact

we're making it for ourself when we started cursor，you really felt this

frustration that you know models you could see models getting better，but the cobal experience had not changed it was like，man，these guys like the ceiling is getting higher like why are they not making you think like they

should be making you think? They should be like he like，like where，where's all the alpha features? There were no alpha features，it was like I'm sure it was selling，well I'm sure it was a great business，but I didn't feel I'm one of these people that really want to try and use new things and just there's no new thing for like a very long while. 我不知道我是否从特性的角度来看待它，我从程序员的能力的角度来看待它，就像你知道的那样，新模型出现了，我相

信会有更多不同类型的模型，比如更长的上下文，也许更快，就像所有这些疯

狂的你可以尝试的想法和希望的 10 个疯狂的想法，我们将把它变成很酷有用的

东西，我们希望人们尽快拥有它。改写。当我们开始创建 Cursor 时，这就像是

一个被低估的事实，你真的感到了这种挫败感，因为你知道模型可以看到模型

变得更好，但是全球的经验并没有改变它就像，这些人喜欢天花板越来越高，

为什么他们没有让你像他们应该让你思考一样思考？他们应该像他一样，像哪

里，所有的 alpha 特征在哪里？没有 alpha 功能，就像我确定它在销售，我相信

这是一项伟大的业务，但我并不觉得我是那些真正想尝试和使用新事物的人之

一，只是在很长一段时间内没有新事物。

发言人 1 14：35 Yeah，it's interesting，I don't know how you put that into

words，but when you compare a cursor with Copilot，Copilot pretty quickly became started to feel stale for some reason. 是的，这很有趣，我不知道你怎么用语言来表达，但是当你将 Cursor 和 Copilot 进行比较时，Copilot 很快就会因为某种原因开始感到陈旧。

发言人 3 14：45 Yeah，I think one thing that I think helps us is that we're sort of doing it all in one where we're developing the uux and the way you interact with the model. And at the same time as we're developing like how we

actually make the model give better answers or like how you build up the prompter or like how do you find the context? And for a cursor tab，like how do you train the model? So I think that helps us to have all of it，like sort of like the same people working on the entire experience end to end. 是的，我认为有一件事对我们有所帮助，那就是我们正在开发 uux 以及您与模型交互

的方式，从而完成所有工作。同时，随着我们的发展，比如我们如何让模型给

出更好的答案，或者你如何构建提示器，或者你如何找到上下文？对于 Cursor

选项卡，例如如何训练模型？所以我认为这有助于我们拥有所有这些，就像同

一个人在整个体验中进行端到端的工作一样。

发言人 515：17 Yeah，it's like the person making the Ul and the person

training the model，like sit to like 18 feet away. 是的，就像制作 UI 的人和训练模型的人一样，就像坐在 18 英尺之外一样。

发言人 4 15：23 So often the same person even. 甚至经常是同一个人。

发言人 5 15：25 yeah，often，often even the same person. So you can，you can create things that that are sort of not possible. If you're not，you're not

talking，you're not experimenting. 是的，经常甚至经常是同一个人。所以你可以，你可以创造一些不太可能的东西。如果你不是，你就不是在说话，你不

是在实验。

发言人 1 15：34 and you're using，like you said，cursor to write cursor. 就像你说的，你正在使用 Cursor 来写入 Cursor。

发言人 3 15：37 of course. Oh. 当然。哦。

发言人 415：37 yeah. 是的。发言人 1 15：38 Well，let's talk about some of these features. Let's talk about the all knowing，the all powerful praise be to the tab for the，you know,

autocomplete on stairways basically. So what，how does tab work? What istab. 好的，让我们来谈谈其中的一些功能。让我们谈谈对楼梯自动完成的全知

全能的赞美，你知道的，基本上是对自动完成的。那么，tab 是如何工作的呢？

什么是 tab。

发言人 2 15：53 to highlight and summarize? At a high level，I would say that there are two things that cursor is pretty good at right now. There，there are other things that it does，but two things that it helps programmers with，one is this idea of looking over your shoulder and being like a really fast

colleague who can kind of jump ahead of you and type and figure out what you're going to do next. And that was the original idea behind that was kind of the kernel. The idea behind good autocomplete was predicting what

you're going to do next，but you can make that concept even more

ambitious by not just predicting the characters after your cursor，we're

predicting the next entire change. You're going to make，the next D，next

place you're going to jump to，And the second thing cursor is，is pretty

good at right now too，is helping you sometimes jump ahead of the Al and tell it what to do and go from instructions to code and on both of those

we've done a lot of work on making the editing experience for those things ergonomic and also making those things smart and fast. 强调和总结？在高层次上，我想说 Cursor 现在在两件事情上做得相当不错。还有其他的事情，它

可以帮助程序员做两件事，一是超越你的肩膀，像一个非常快速的同事，可以

跳到你前面，输入并弄清楚你下一步要做什么。这就是它背后的最初想法，有

点像内核。好的自动完成背后的想法是预测你接下来要做什么，但你可以通过

不仅仅是预测 Cursor 后的字符，而是预测下一个整个变化，使这个概念更加雄

心勃勃。你将要做的，下一个 D，下一个你要跳转到的地方，第二件事 Cursor

现在也很擅长，正在帮助你有时超越 AI，告诉它该做什么，从指令到代码，在这两者上，我们做了很多工作，使这些东西的编辑体验符合人体工程学，并使

这些东西变得智能和快速。

发言人 5 16：54 One of the things we really wanted was we wanted the

model to be able to edit code for us that was kind of a wish and we had

multiple attempts at it before，before we had a sort of a good model that could edit code for you Then after，after we had a good model，I think

there'd been a lot of effort to，you know，make the inference fast for，you know，having，having a good，good experience and we've been starting to incorporate，I mean，Michael sort of mentioned this like ability to jump to different places and that jump to different places，I think came from a

feeling of，you know，once you，once you accept an edit，it was like，man，it should be just really obvious where to go next. 我们真正想要的一件事是，我们希望模型能够为我们编辑代码，这有点像一个愿望，我们之前有过多次尝

试，在我们有一个可以为你编辑代码的好模型之前，在我们有一个好的模型之

后，我认为我们已经付出了很多努力，让推断变得快速，因为我们拥有了良

好、良好的体验，我们已经开始整合，我的意思是，迈克尔提到了这种跳跃到

不同地方的能力，这种能力可以跳跃到不同的地方，我认为这是一种感觉，你

知道的，一旦你接受了一个编辑，就像是，伙计，应该很明显下一步去哪里。

发言人 5 17：37 It's like it's like I made this change，the model should just

know that like the next place to go to ISS like 18 lines down，like if you're if you're a Wim user，you could press 1，8 JJ or whatever. But like，why，why even，why am I doing this? Like the model，the model should just know it. And then so，so the idea was you just press tab，it would go 18 lines down and then make show you show you next edit and you would press tab，so it was just you as long as you could keep pressing tab then. So the internal competition was how many tabs can we make someone press once you

have like the idea more more sort of abstractly the thing to think about it sort of like once howhow，how are the edits sort of 0，0 entropy? So once you've sort of expressed your intent and the edit is there's no like new bits of information and you finish your thought，but you still have to type some characters to like make the computer understand what you're actually

thinking. Then maybe the model should just sort of read your mind and all the zero entropy bits should just be like tab delay，yeah's sort of abstract. There's this interesting thing where. 这就像我做了这个改变一样，模型应该知道下一个要去国际空间站的地方就像 18 行以下，如果你是一个 Wim 用户，你

可以按 1、8JJ 或其他键。但是，为什么，甚至为什么我要这样做？就像模型一

样，模型应该知道它。然后，这个想法是你只需按 tab 键，它将向下显示 18

行，然后向你展示下一个编辑，你只需按 tab 键，所以只要你能继续按 tab 键就

可以了。所以内部竞争是，一旦你有了更抽象的想法，我们可以让某人按下多

少个标签，思考一下，就像曾经如何，编辑如何排序为 0,0 熵？所以一旦你表

达了你的意图，编辑就没有新的信息了，你完成了你的想法，但你仍然需要输

入一些字符，让计算机理解你实际在想什么。那么也许这个模型应该只是读懂

你的思想，所有的零熵位应该就像 tab 延迟一样，是的，有点抽象。有一个有趣

的事情在哪里。

发言人 4 18：43 if you look at language model loss on on different domains，I believe the bits per by which is kind of character normalized loss for code lower than language，which means in general，there are a lot of tokens in code that are super predictable，a lot of characters that are super

predictable. And this is，I think，even magnified when you're not just trying to autocomplete code，but predicting what the user is going to do next in their editing of existing code. And so，you know，the goal cursor tabs，let's eliminate all the low entropy actions you take inside of the editor. When then 10 is effectively determined，let's just jump you forward in time，skip you forward. 如果你看一下不同域上的语言模型损失，我相信每比特是一种字符规范化损失，代码低于语言，这意味着一般来说，代码中有很多标记是超级可预测的，很多字符是超级可预测的。我认为，当你不仅仅是试图自动完成代

码，而是预测用户在编辑现有代码时下一步要做什么时，这一点甚至会被放

大。所以，你知道，目标 Cursor 选项卡，让我们消除你在编辑器内采取的所有

低熵操作。当 10 有效确定时，让我们让你向前跳，跳过你向前。

发言人 1 19：22 Well，well，what's the intuition and what's the technical details of how to do next? Cursor prediction，that jump，that's not，that's not so

intuitive. 好的，好的，直觉是什么，下一步怎么做的技术细节是什么？Cursor 预测，那个跳跃，那不是，那不是那么直观。

发言人 4 19：30 I think the people，yeah，I think I can speak to a few of the

details on how to make these things work. They're incredibly low latency，so you need to train small models on this，on this task in particular，they're

incredibly prefill token hungry. What that means is they have these really，really long prompt where they see a lot of your code and they're not

actually generating that many tokens. And so the perfect fit for that is using a sparse model，meaning an Moe model. So that was kind of 1，1 break，one breakthrough. We made that substantially improved performance at longer context，the other being a variant of speculative decoding that we kind of built out called speculative edits. These are 2，I think，important pieces of what make it quite high quality and very fast. 我认为人们，是的，我想我可以谈论一些关于如何使这些事情运作的细节。它们具有非常低的延迟，因此您需

要在此基础上训练小型模型，特别是在这个任务中，它们非常需要预填充

Token。这意味着他们有很长很长的提示，可以看到你的很多代码，但实际上

他们并没有生成那么多 Token。因此，最适合的方法是使用稀疏模型，即 Moe

模型。所以这有点像 1,1 个突破，一个突破。我们在较长的上下文环境下大幅

提高了性能，另一个是推测解码的变体，我们构建了称为推测编辑的算法。我

认为，这是使它高质量和非常快速的两个重要因素。发言人 1 20：20 Okay，so Moe mixture of experts，the input is huge，the

output is small. Yeah，okay，so like what，what，what else can you say about how to make like caching play a . 好的，所以专家混合在一起，投入是巨大的，产出是小的。是的，好的，那就像，关于如何让缓存发挥作用，你还能说

什么。

发言人 4 20：30 role in caching? Caching plays a huge role because you're dealing with this many input tokens. If every single keystroke that you're

typing in a given line，you had to rerun the model on all those tokens

passed in，you're just going to one significantly degrade latency. Two，you're going to kill your Gpu's with load. So you need to design the actual prompts you use for the model such that they're CA caching aware. And then，yeah，you need，you need to reuse the Kv cache across request just so that you're spending less work，less compute. 缓存中的角色？缓存起着巨大的作用，因为您正在处理这么多的输入 Token。如果您在给定行中输入的每一次按键都必

须对传入的所有 Token 重新运行模型，那么您只会显著降低延迟。第二，你要

加载杀死你的 Gpu。因此，您需要为模型设计实际的提示，使它们能够感知缓

存。然后，是的，你需要在请求中重复使用 Kv 缓存，这样你就可以花费更少的

工作，更少的计算。

发言人 1 21：04 Again，what are the things that tab is supposed to be able to do kind of in the near term just to like sort of linger on that generate code? Like fill empty space，also edit code across multiple lines and then jump to different locations inside the same file. 再说一遍，在短期内，tab 应该能够做什么事情，以便停留在生成代码上？像填充空白区域一样，还可以跨多行编辑

代码，然后跳转到同一文件中的不同位置。

发言人 5 21：24 And then I jump to different files also. So if you make an edit in one file，maybe you have to go，maybe you have to go to another file to finish your thought. It should go to the second file also. 然后我也跳转到不同的文件。所以如果你在一个文件中进行编辑，也许你必须去，也许你必须去另

一个文件来完成你的想法。它也应该转到第二个文件。

发言人 3 21：35 Yeah，And then the full generalization is like next，next action prediction. Like sometimes you need to run a command in the terminal and it should be able to suggest the command based on the code that you

wrote to，or sometimes you actually need to like it suggests something，but you，it's hard for you to know if it's correct. You actually need some more

information to learn，like you need to know the type to be able to verify that it's correct. And so maybe it should actually take you to a place that's like

the definition of something and then take you back so that you have all the requisite knowledge to be able to accept the next completion. 是的，然后完整的概括就像下一个，下一个行动预测。就像有时你需要在终端运行一个命

令，它应该能够根据你写的代码建议这个命令，或者有时你实际上需要喜欢它

建议一些东西，但是你很难知道它是否正确。你实际上需要更多的信息来学

习，比如你需要知道类型才能验证它是否正确。也许它应该带你到一个地方，

就像某个东西的定义一样，然后带你回去，这样你就有了所有必要的知识，能

够接受下一个完成。

发言人 1 22：13 So providing the human the knowledge，yes，right? Can you integrate，like I just gotten to know a guy named Prime Gen who I believe

has an SS? You can order coffee via SSH? 所以为人类提供知识，是的，对

吧？你能整合吗，就像我刚刚认识了一个叫 Prime Gen 的人，我相信他有一个

SS? 你可以通过 SSH 点咖啡吗？

发言人 5 22：28 Oh yeah，we did that，we did that. 是的，我们做到了，我们做到了。发言人 1 22：31 So can that also the model do that like you like yeah，and

provide you with caffeine，okay，so that's the general framework. 模型也可以像你喜欢的那样做，并为你提供咖啡因，好吗，这是一般框架。

发言人 2 22：39 And the magic moment would be if it is programming is this weird discipline where sometimes the next five minutes nets not always，but sometimes the next five minutes，what you're gon na do is actually

predictable from the stuff you've done recently. And so can you get to a

world where that next five minutes either happens by you disengaging and it taking you through，or maybe a little bit more of just you seeing next step what it's going to do? And you're like，okay，that's good，That's good，that's good，that's good. Tap，tap，tap through these big changes. 而神奇的时刻将是，如果编程是一种奇怪的纪律，有时接下来的五分钟并不总是如此，但有时

接下来的五分钟，你所做的事情实际上可以从你最近所做的事情中预测。所以

你能否进入一个这样的世界，在这个世界里，接下来的五分钟要么是你脱离并

带你完成，要么是你看到下一步会做什么？然后你会说，好吧，那很好，那很

好，那很好。点击，点击，点击这些大的变化。

发言人 1 23：08 As we're talking about this，I should mention one of the really cool and noticeable things about a cursor is that there's this whole diff

interface situation going on. So like the model suggests，with the red and the green of like，here's how we're going to modify the code. And in the

chat window，you can apply and it shows you the diff and you can accept the dif. So maybe can you speak to whatever direction of that? 当我们在谈论这个时，我应该提到 Cursor 的一个非常酷和引人注目的事情是，整个不同的

界面情况正在发生。就像模型所建议的那样，带有红色和绿色的 like，这是我

们将如何修改代码。在聊天窗口中，您可以申请，它会显示差异，您可以接受

差异。所以也许你能谈谈这个方向吗？ 发言人 5 23：32 We'll probably have like 4 or five different kinds of diffs. So we have optimized the diff for the autocomplete. So that has a different diff interface. Then then when you're reviewing larger blocks of code，and then we're trying to optimize another D thing for when you're doing multiple

different files. And sort of at a high level，the difference is for when you're doing all complete，it should be really，really fast to read. Actually，it should be really fast to read in all situations. But in auto complete，it sort of you're really like your eyes focused in one area. You can't be in too many.The

humans can't look in too many different places. 我们可能会有 4 到 5 种不同的差异。所以我们优化了自动完成的 diff。所以它有不同的 diff 界面。然后，当您

审查较大的代码块时，我们会尝试优化另一个 D 功能，以应对处理多个不同文

件的情况。而在高层次上，区别在于当你完成所有工作时，它应该非常快地阅

读。实际上，它应该在所有情况下都能快速阅读。但在自动完成中，你真的像

你的眼睛一样专注于一个区域。你不能太多。人类无法看到太多不同的地方。

发言人 1 24：15 So you're talking about on the interface side on the interface.

所以你在谈论接口方面的问题。

发言人 5 24：17 So it currently has this box on the side. So we have the

current box. And if it tries to delete code in some place and tries to add

other code，it tries to show you a box on the sound. 所以它目前在侧面有这个

盒子。所以我们有了现在的盒子。如果它试图删除某个地方的代码并尝试添加

其他代码，它会试图在声音上显示一个框。

发言人 4 24：28 You can maybe show it if we pull it up on cursor dot com dot.

如果我们在 Cursordot com dot 上拉起它，你也许可以显示它。

发言人 5 24：31 This is what we're talking so that it was like 3 or four different attempts at trying to make this，this thing work，where first the attempt was like these blue crossed outline. So before it was a box on the side. It's used to show you the code to delete by showing you like like Google DOC style，you would see like a line through it. Then you would see the new code and that was super distracting. And then we tried many different，you know,

there was，there was sort of deletions that was trying to red highlight. 这就是我们正在谈论的，所以尝试了 3 到 4 次不同的尝试来使这个东西工作，首先尝试

就像这些蓝色交叉的轮廓一样。以前它是旁边的一个盒子。它用于向您展示要

删除的代码，通过向您展示 Google 文档样式，您会看到一条穿过它的线。然后

你会看到新代码，这非常分散注意力。然后我们尝试了许多不同的，你知道，

有一些删除，试图以红色突出显示。

发言人 5 25：06 Then the next iteration of it，which is sort of funny，would you would hold the on Mac，the option button? So it would，it would sort of

highlight a region of code to show you that there might be something

coming. So maybe in this example，like the input and the value would get would all get blue and the blue，would you highlight that the Al had a

suggestion for you? So instead of directly showing you the thing，it would show you that the Al，it would just hint that the Al had a suggestion and if you really wanted to see it，you would hold the option button，and then you would see the new suggestion. And if you release the option button，you would then see your original code. 那么它的下一次迭代，有点有趣，你会按住 Mac 上的选项按钮吗？因此，它会在某种程度上突出显示一段代码，以显示

可能有什么东西要来。所以也许在这个例子中，像输入和获取的值都会得到蓝

色，蓝色，你会强调 AI 对你有建议吗？因此，它不会直接向您显示该事物，而

是会向您显示 AI，它只会暗示 AI 有建议，如果您真的想看到它，请按住选项按

钮，然后您会看到新的建议。如果你释放选项按钮，你就会看到你的原始代

码。

发言人 1 25：47 So that's，by the way，that's pretty nice，but you have to know to hold the option button. Yeah，I you，by the way I'm not a Mac user. 顺便说

一下，这很好，但你必须知道按住选项按钮。是的，顺便说一下，我不是 Mac

用户。

发言人 525：54 but I got it. 但我明白了。

发言人 1 25：55 It was，it's a button I guess you people have. 这是一个按钮，我猜你们有。

发言人 5 25：59 It's，you know，it's again，it's just，it's just not intuitive. I think that's the. 这，你知道的，再说一遍，这只是，这不是直觉。我认为就是这

样。

发言人 4 26：02 that's the key thing and there's a chance this，this is also not the final version of it. 这是关键的事情，有可能这也不是它的最终版本。

发言人 3 26：06 I am personally very excited for making a. Lot of

improvements in this area，like we often talk about it as the verification

problem where these diffs are great for small edits，for large edits，or like when it's multiple files or something，it's actually a little bit prohibitive to review these diffs. 我个人非常兴奋能够制作一个。这方面有很多改进，就像我

们经常谈论的验证问题一样，这些差异非常适合小的编辑，对于大的编辑，或

者当它是多个文件或其他东西时，实际上审查这些差异有点令人望而却步。

发言人 3 26：32 And so there are like a couple of different ideas here. Like，one idea that we have is，okay，you know，like parts of the diffs are

important. They have a lot of information，and then parts of the diff are just very low entropy. They're like like the same thing over and over again. And so maybe you can highlight the important pieces and then gray out the not so important pieces，or maybe you can have a model that looks at the diff and sees，oh，there's a likely bug here. I will like mark this with a little red squiggly and say like，you should probably like review this part of the diff. And ideas in that vein，I think are exciting. 所以这里有几个不同的想法。我们

的一个想法是，好的，你知道，部分差异很重要。它们有很多信息，然后差异

的一部分只是非常低的熵。他们一遍又一遍地像同一个东西。因此，也许你可

以突出重要的部分，然后灰显不那么重要的部分，或者你可以有一个模型来查

看差异并看到，哦，这里可能有一个错误。我会用一个小红色的曲折标记并

说，你可能应该喜欢回顾一下这部分的差异。这样的想法，我认为是令人兴奋

的。

发言人 1 27：11 Yeah，that's a really fascinating space of like uux design

engineering. So you're basically trying to guide the human programmer through all the things they need to read and nothing more. Yeah，like

optimally. 是的，那是一个非常迷人的领域，就像 uux 设计工程一样。所以你基

本上是在试图指导人类程序员完成他们需要阅读的所有内容，仅此而已。是

的，最佳情况下。

发言人 3 27：25 yeah. And you want an intelligent model to do it，like

currently diff algorithms. Algorithms are，they're like，like they're just like normal algorithms，there's no intelligence，there's like intelligence that went

into designing the algorithm，but then there，there's no like you don't care everything if it's about this thing or this thing as we want to model to dothis. 是的。你需要一个智能模型来完成它，就像当前的 diff 算法一样。算法就

像普通算法一样，没有智能，只有智能进入算法的设计，但是，没有像你不关

心一切一样，如果它是关于这件事或我们想要建模的这件事。

发言人 5 27：47 So I think the general question is like，but these models are going to get much smarter as the models get much smarter，the changes they will be able to propose are much bigger，so as the changes gets bigger and bigger and bigger，the humans have to do more and more and more verification work. It gets more and more and more hard，like it's just you need，you need to help them out. It sort of，I don't want to spend all mytime reviewing code. 所以我认为普遍的问题是，但是随着模型变得更加智

能，这些模型将变得更加智能，他们能够提出的变化将会更大，因此随着变化

越来越大，人类必须做越来越多的验证工作。它变得越来越难，就像这只是你

需要的，你需要帮助他们。有点，我不想把所有的时间都花在审查代码上。

发言人 1 28：15 Can you say a little more across multiple files div? 你能在多个文件的 div 中多说一点吗？

发言人 4 28：20 Yeah，I mean，so GitHub tries solve this，right? With code

review. When you're doing code review，you're reviewing multiple diffs

across multiple files. 是的，我的意思是，所以 GitHub 试图解决这个问题，对吧？代码审查。当你进行代码审查时，你正在审查多个文件中的多个差异。

发言人 4 28：29 But like Arvid said earlier，I think you can do much better than code review. You know，code review kind of sucks，Like you spend a lot of time trying to grok this code that's often quite unfamiliar to you and it often like doesn't even actually catch that many bugs. And I think you can

significant significantly improve that review experience using language

models，for example，using the kinds of tricks that ARP had described,

maybe pointing you towards the regions that actually matter. I think also，if the code is produced by these language models and it's not produced by someone else，like the code review experience is design for both the

reviewer and the person that produced the code. In the case where the

person that produced the code is the language model，you don't have to

care that much about their experience. And you can design the entire thing around the reviewer such that the reviewer's job is as fun，as easy，as productive as possible. And I think thatthat feels like the issue with just kind of naively trying to make these things look like code review. I think you can be a lot more creative and push the boundary on what's possible. 但就像阿尔维德之前说的，我认为你可以做得比代码审查更好。你知道，代码审查有点

糟糕，就像你花了很多时间试图理解这些你通常非常不熟悉的代码，而且通常

甚至没有真正捕捉到那么多 bug。我认为你可以使用语言模型显著提高审查体

验，例如，使用 ARP 所描述的技巧，也许可以指向真正重要的领域。我还认

为，如果代码是由这些语言模型生成的，而不是由其他人生成的，就像代码评

审体验是为审阅者和生成代码的人设计的。在生成代码的人是语言模型的情况

下，您不必太关心他们的经验。你可以围绕审稿人设计整个事情，使得审稿人

的工作尽可能有趣、简单、高效。我认为这感觉就像是天真地试图让这些东西

看起来像代码审查的问题。我认为你可以更有创意，突破可能性的界限。

发言人 3 29：43 Just 1， 1 idea there is，I think ordering matters. Generally

when you review APR，you have this list of files and you're reviewing them

from top to bottom，but actually like you actually want to understand this

part first because that came like logically first，and then you want to

understand the next part. You don't want to have to figure out that yourself. You want a model to guide you through the thing. 只有一个想法，我认为订购很重要。通常当你查看 APR 时，你有这个文件列表，并且你正在从上到下查

看它们，但实际上你实际上想首先理解这一部分，因为这在逻辑上是第一位

的，然后你想理解下一部分。你不希望自己去解决这个问题。你想要一个模型

来指导你完成这件事。

发言人 1 30：06 And is the step of creation going to be more and more in

natural language? Is the goal versus with actual. 创造的步骤会越来越多地采用自然语言吗？这是目标与实际的对比。

发言人 3 30：12 I think sometimes I don't think it's going to be the case that all of programming will be natural language. And the reason for that is，you know，if I'm pair programming with swans，while is that the computer and

the keyboard? And sometimes if I'm like driving，I want to say to wallet，hey，like implement this function and that that works. And then sometimes it's

just so annoying to explain to Wallet what I want him to do，as though I

actually take over the keyboard and I show him I write like part of the

example，and then it makes sense. And that's the easiest way to

communicate. And so I think that's also the case for Al. 我认为有时候我不认为所有的编程都会是自然语言。原因是，你知道，如果我用天鹅配对编程，那

么那是计算机和键盘吗？有时候，如果我喜欢开车，我想对钱包说，嘿，就像

实现这个功能一样，它可以工作。然后有时向钱包解释我想让他做什么真的很

烦人，就好像我实际上接管了键盘，向他展示我写的是示例的一部分，然后就

变得感知了。这是最简单的沟通方式。所以我认为 AI 也是如此。

发言人 3 30：49 Like sometimes the easiest way to communicate with Al will be to show an example，and then it goes and does the thing everywhere

else. Whereas sometimes，if you're making a website，for example，the

easiest way to show to the Al what you want is not to tell it what you do，but，you know，drag things around or draw things. And yeah，and like maybe

eventually we will get to like brain machine interfaces or whatever and kind of like understand what you're thinking. So I think natural language will have a place. I think it will not definitely not be the way most people program

most of the time. 有时与 Al 沟通的最简单方法是展示一个例子，然后它去其他地方做这件事。有时候，如果你正在制作一个网站，例如，向 AI 展示你想要什

么，最简单的方法不是告诉它你在做什么，而是拖动东西或画东西。是的，也

许最终我们会得到类似脑机接口或其他的东西，有点像理解你在想什么。所以

我认为自然语言会有一席之地。我认为这并不一定不是大多数人在大多数时候

编程的方式。发言人 1 31：20 I'm really feeling the AGI with this editor，feels like there's a

lot of machine learning going on underneath. Tell me about some of the ML stuff that makes it all work. 我真的感觉和这个编辑在一起，感觉下面有很多机器学习在发生。告诉我一些使这一切工作的 ML 东西。

发言人 4 31：31 recursor really works via this ensemble of custom models

that that we framed alongside，you know，the frontier models that are

fantastic at the reasoning intense things. And so cursor tab，for example，is a great example of where you can specialize this model to be even better

than even frontier models. If you look at Es on the task，we set it at the other domain，which it's kind of surprising that it requires custom models，but it's kind of necessary and works quite well，is in apply. I think these models are like the frontier models are quite good at sketching out plans for code and generating like rough sketches of like the change. But actually creating diffs is quite hard for frontier models，for your training models. Like you try to do this with Sonnet with 0，1，any frontier model，and it really messes up stupid things like counting line numbers，especially in super，super large files. And so what we've done to alleviate this is we let the model kind of sketch out

this rough code block that indicates what the change will be. And we train a model to then apply that change to the file. 递归器确实通过我们与前沿模型一起构建的定制模型来工作，这些模型在推理激烈的事物方面非常出色。例

如，Cursor 选项卡是一个很好的例子，可以将此模型专业化，使其甚至比前沿

模型更好。如果你看一下任务中的 Es，我们将其设置在另一个领域，这有点令

人惊讶，因为它需要自定义模型，但它是必要的，并且工作得很好，正在应用

中。我认为这些模型就像前沿模型一样，非常擅长勾画代码计划并生成类似变

化的草图。但实际上为前沿模型和训练模型创建差异非常困难。就像你在十四

行诗中尝试使用 0、1 或任何前沿模型一样，它真的会搞乱像计算行号这样的愚

蠢事情，特别是在超大文件中。因此，为了缓解这种情况，我们所做的是让模

型勾勒出这个粗略的代码块，以指示将会发生什么变化。我们训练一个模型，然后将该更改应用于文件。

发言人 1 32：42 And we should say that apply is the model looks at your

code. It gives you a really damn good suggestion of what new things to do. And the seemingly for humans，trivial step of combining the two you're

saying is not so trivial. 我们应该说，适用的是模型会查看您的代码。它会给你一个非常好的建议，告诉你该做什么新的事情。你所说的将两者结合起来的看

似对人类来说微不足道的步骤并不是那么微不足道。

发言人 5 32：59 Contrary to popular perception，it is not a deterministic

algorithm. 与普遍的看法相反，它不是一种确定性算法。

发言人 4 33：03 Yeah，I think like you see shallow copies of apply elsewhere and it just breaks like most of the time because you think you can kind of try to do some deterministic matching and then it fails you at least 40% of the time. And that just results in a terrible product experience. I think in general，this，this regime of you are going to get smarter and smarter models and

like，so one other thing that letscher is it letsgo use fewer tokens with the

most intelligent models. This is both expensive in terms of latency for

generating all these tokens and cost. So you can give this very，very rough

sketch and then have your small models go and implement it because it's a much easier task to implement this very，very sketched out code. And I think that this this regime will continue where you can use smarter and smarter

models to do the planning. And then maybe the implementation details can be handled by the less intelligent ones. Perhaps you'll have，you know,

maybe 0，1，maybe it'll be even more capable models given an even higher level plan that is kind of recursively applied by sonne and then apply

model. 是的，我认为你看到的浅层副本适用于其他地方，它就像大多数时候一

样崩溃，因为你认为你可以尝试做一些确定性匹配，但至少 40% 的时间它会让你失败。这只会导致糟糕的产品体验。我认为总的来说，你的这种模式将变得

越来越聪明，所以 letscher 的另一件事是，letsgo 使用更少的代币和最智能的模型。这在生成所有这些 Token 的延迟和成本方面都是昂贵的。所以你可以给出

这个非常粗略的草图，然后让你的小模型去实现它，因为实现这个非常非常粗

略的代码是一个更容易的任务。我认为这种制度将继续下去，你可以使用更智

能的模型来进行规划。然后，也许实施细节可以由不太聪明的人处理。也许你

会有的，你知道的，也许是 0，1，也许它会是更有能力的模型，给出一个更高

级别的计划，由 sonne 递归应用，然后再应用模型。

发言人 5 34:16 Maybe we should. We should talk about how to how to make it fast. Yeah， like yeah， fast is always an interesting game. Good. 也许我们应该。我们应该讨论如何使它更快。是的，就像，快总是一个有趣的游戏。很

好。

发言人 1 34:22 yeah， how do you make it fast? 是的，你是怎么做到快速的？ 发言人 4 34:24 Yeah， so one big component of making it fast is speculative edits. So speculative edits are a variant of speculative decoding and maybe be helpful to briefly describe speculative decoding. 是的，所以使其快速的一个重要组成部分是投机性编辑。因此推测性编辑是推测性解码的一种变体，

可能有助于简要描述推测性解码。

发言人 4 34:37 With speculative decoding， what you do is you can kind of take advantage of the fact that， you know， most of the time， and I＇ll add the caveat that it would be when you＇re memory bound in language model

generation， if you process multiple tokens at once， it is faster than

generating one token at a time. So this is like the same reason why if you look at tokens per second with prompt tokens versus generated tokens， it＇s much， much faster prompt tokens. 通过投机性解码，你可以利用这个事实，你知道，大多数情况下，我会添加警告，当你在语言模型生成中受到内存限制

时，如果你同时处理多个 Token，它比一次生成一个 Token 更快。因此，这就像

为什么如果你查看每秒 Token 与提示 Token 和生成的 Token 的原因一样，它更快，提示 Token 更快。

发言人 4 35：09 So what we do is instead of using what speculative decoding

normally does，which is using a really small model to predict these draft tokens that your larger model will then go in and verify with code edit it- savvy a very strong prior of what the existing code will look like. And that prior is literally the same exact code. 所以我们所做的是使用投机性解码通常使用的方法，也就是使用一个非常小的模型来预测这些草稿 Token，然后你的

更大的模型将进入并使用代码进行验证，编辑它 - 一个非常强大的先验现有代码

的外观。那个先验代码实际上是完全相同的代码。

发言人 4 35：29 So you can do is you can just feed chunks of the original

code back into the into the model，and then the model will just pretty much agree most of the time that okay? I'm just going to spit this code back out，and you can process all of those lines in parallel. And you just do this with sufficiently many chunks. And then eventually you'll reach a point of

disagreement where the model will now predict text that is different from the ground truth original code. It'll generate those tokens，and then we kind

of we'll decide after enough tokens match the original code to read，start speculating in chunks of code，what this actually ends up looking like is just a much faster version of normal editing code. So it's just like it looks like a much faster version of the model rewriting all the code. So just we can use the same exact interface that we use for diffs，but it will just stream down a lot faster and then. 所以你可以做的是，你可以只将原始代码块输入到模型中，然后模型在大多数情况下会基本同意，好吗？我只是要把这段代码吐出

来，你可以并行处理所有这些行。你只需用足够多的块来做这件事。然后最终你会达到一个分歧点，模型现在将预测与原始代码不同的文本。它将生成那些

Token，然后我们将决定在足够的 Token 匹配原始代码后读取，开始推测代码

块，这实际上最终看起来像一个更快的正常编辑代码版本。所以它看起来像是

一个更快的模型版本，重写所有代码。因此，我们可以使用与 diff 相同的完全接

口，但它只会以更快的速度流传下来。

发言人 5 36：22 and then the advantage is that wireless streaming，you can

just also be reviewing，start reviewing the code except beforebefore it's

done said there's no，no big loading screen. So maybe that is part of the

part of the advantage. 然后优点是无线流媒体，您也可以审查，开始审查代码，除了在完成之前说没有，没有大的加载屏幕。也许这就是优势的一部分。

发言人 1 36：36 So the human can start reading before the thing is done. 这样人类就可以在事情完成之前开始阅读。

发言人 5 36：39 I think the interesting riff here is something like like

speculation is a fairly common idea nowadays，like not only in language

models，I mean，there's obviously speculation and Cpu's，it's like speculation for databases and like speculation all over the place. 我认为这里有趣的即兴段是类似于推测现在是一个相当普遍的想法，不仅在语言模型中，我的意思

是，显然有推测和 Cpu，就像数据库的推测一样，到处都是推测。

发言人 1 36：54 Let me ask the sort of the ridiculous question of which all of them is better at coding GPT. Claude，who wins in the context of

programming? And I'm sure the answer is much more nuanced because it sounds like every single part of this involves a different model. 让我问一个荒谬的问题，他们都更擅长编写 GPT。Claude，在编程的背景下，谁赢了？我相

信答案更加微妙，因为听起来每个部分都涉及不同的模型。

发言人 4 37：11 Yeah，I think there，there's no model that Prado dominates. Others，meaning it is better in all categories that we think matter，the

categories being speed. Ability to edit code. Ability to process lots of code，long context，you know，a couple of other things and kind of coding

capabilities. 是的，我认为在那里，没有普拉多主导的模式。其他人，意思是在所有品类中，我们认为物质更好，品类是速度。编辑代码的能力。能够处理

大量代码，长上下文，你知道的，一些其他的事情和编码能力。

发言人 4 37：35 The one that I'd say right now is just kind of net best is

Sonnet. I think this is a consensus opinion. Our one's really interesting and it's really good at reasoning. So if you give it really hard programming

interview style problems or Le code problems，it can do quite，quite well on them. But it doesn't feel like it kind of understands your rough intent as wellas sonne. 我现在要说的最好的一种是十四行诗。我认为这是一个共识意见。我

们的一个非常有趣，而且非常擅长推理。所以，如果你给它提供了非常困难的

编程面试风格问题或代码问题，它可以在这些问题上做得非常好。但它感觉不

像 sonne 那样理解你的粗略意图。

发言人 4 38：01 Like if you look at a lot of the other frontier models. One

qualm I have is it feels like they're not necessarily over. I'm not saying they

train on benchmarks，but they perform really well in benchmarks relative to kind of everything that's kind of in the middle. So if you tried in all these

benchmarks and things that are in the distribution of the benchmarks

they're evaluated on，you know，they'll do really well. But when you push

them a little bit outside of that sonnets，I think the one that that kind of does best at kind of maintaining that same capability，like you kind of have the

same capability in the benchmark as when you try to instruct it to do

anything with coding. 就像你看很多其他前沿模型一样。我有一个疑虑，那就是感觉他们不一定结束了。我不是说他们在基准测试上训练，但相对于中间的

一切，他们在基准测试中表现得非常好。因此，如果您尝试了所有这些基准测试以及评估基准测试分布中的事物，您知道，它们会做得非常好。但是当你把

它们推到十四行诗之外时，我认为那种最擅长保持同样能力的人，就像你在基

准测试中拥有与指导它进行编码时相同的能力一样。

发言人 1 38：37 What another ridiculous question is the difference between the normal programming experience versus what benchmarks represent? Like where do benchmarks fall short? Do you think when we're evaluatingthese models. 另一个荒谬的问题是普通编程体验与基准测试代表的区别？比如基准测试的不足之处在哪里？当我们评估这些模型时，你认为呢？

发言人 5 38：49 by the way，that's like a really，really hard，like like critically

important detail，like how，how different like benchmarks are versus versus like real coding? With real coding? It's not interview style coding. It's you,

you're doing these，you know，humans are saying like half broken English sometimes and sometimes you're saying like，oh，do what I did before.

Sometimes you're saying，you know，go add this thing and then do this

other thing for me and then make this Ul element. And then，you know，it's just like a lot of things are sort of context dependent. You really want to like understand the human and do do what the human wants as opposed to

sort of this maybe the way to put it，it sort of abstractly is the interview

problems are very well bespeckled the. Lean A on a specification while the human stuff is less specified. 顺便说一下，这就像一个非常非常难的，像非常重要的细节，像基准与真正的编码有什么不同？真正的编码？这不是面试风格

的编码。是你，你正在做这些，你知道，人类有时会说一些蹩脚的英语，有时

你会说，哦，做我以前做过的。有时候你会说，你知道，去添加这个东西，然

后为我做另一件事，然后制作这个 UI 元素。然后，你知道的，很多事情都是依

赖于上下文的。你真的想理解人类并做人类想要做的事情，而不是这样说，抽

象地说，面试问题非常明显。倾向于规范，而人类的东西不太明确。发言人 2 39：49 Yeah，I think that this benchmark question is both

complicated by what? So all I just mentioned and then also to what Oman was getting into is that even if you like，you know，there's this problem of

like the skew between what can you actually model in a benchmark versusreal programming? 是的，我认为这个基准问题很复杂，因为什么？所以我刚才提到的，以及阿曼正在研究的是，即使你喜欢，你知道，存在这样的问题：

你实际上可以在基准中建模的东西与真正的编程之间存在偏差？

发言人 2 40：05 And that can be sometimes hard to encapsulate because it's like real programming is like very messy and sometimes things aren't super well specified what's correct or what isn't. But then it's also doubly hard

because of this public benchmark problem. And that's both because public benchmarks are sometimes kind of hill climbed on，but then it's like really，really hard to also get the data from the public benchmarks out of the

models. And so for instance，like one of the most popular like agent

benchmarks，suite bench is really，really contaminated. And the training

data of these foundation models. And so if you ask these foundation

models to do a sweep bench problem，but you actually don't give them the context of a code base，they can like hallucinate the right file pass. They can hallucinate the right function names. And so the it's also just the public

aspect of these things is tricky. 这有时很难封装，因为真正的编程就像非常混乱，有时事情并没有非常明确地说明什么是正确的，什么不是。但是由于这个

公共基准问题，这也加倍困难。这既是因为公共基准有时有点爬山，但从公共

基准模型中获取数据也非常非常困难。例如，就像最受欢迎的代理基准测试之

一一样，suite bench 真的非常受污染。以及这些基础模型的训练数据。因此，如果您要求这些基础模型执行扫描工作台问题，但实际上您没有为它们提供代

码库的上下文，它们可能会像幻觉一样正确的文件传递。他们能幻觉出正确的

函数名称。因此，这些事情的公共方面也很棘手。发言人 4 40：53 Yeah，like in that case，it could be trained on the literal issues or pull requests themselves and maybe the labs will start to do a better job or they've already done a good job at decontaminating those things，but

they're not going to emit the actual training data of the repository itself，Like these are all like some of the most popular Python repositories，like simpa is one example. I don't think they're going to handicap their models on simpa and all these popular Python repositories in order to get true evaluation

scores in these benchmarks. 是的，就像在那种情况下一样，它可以在文字问题或拉取请求本身上进行训练，也许实验室会开始做得更好，或者他们已经在

净化这些东西方面做得很好，但他们不会发出存储库本身的实际训练数据，像

这些都像一些最流行的 Python 存储库，像 simpa 就是一个例子。我认为他们不

会为了在这些基准测试中获得真正的评估分数而在 simpa 和所有这些流行的

Python 存储库上妨碍他们的模型。

发言人 2 41：24 I think that given the dearths and benchmarks，there have

been like a few interesting crutches that places that build systems with these models or build these models actually use. So you get a sense of，are they going in the right direction or not? And in a lot of places，people will

actually just have humans play with the things and give qualitative feedback on these，like one or two of the foundation model companies，they have

people who. So that's a big part of their role. And，you know，internally，we also，you know，qualitatively assess these models and actually lean on that a lot in addition to like private emails that we have. 我认为考虑到这些不足和基准，已经有一些有趣的拐杖，可以用来构建使用这些模型的系统或构建这些模

型的地方。所以你会感知，他们的方向是对的还是不对？在很多地方，人们实

际上只是让人类玩这些东西，并就这些东西提供定性的反馈，就像一两个基金

会模型公司，他们有人。所以这是他们角色的重要组成部分。而且，你知道，

在内部，我们也对这些模型进行定性评估，实际上除了我们拥有的私人电子邮

件之外，还会经常依赖于这些模型。发言人 5 41：56 It's like the vibe vibe. 这就像一种氛围。

发言人 1 41：58 the vibe，vibe. If I have benchmark，human benchmark，when you pull in the humans to do a vibe check. 氛围，氛围。如果我有基准，人类基准，当你把人类拉进来进行氛围检查时。

发言人 3 42：05 Yeah，okay，I mean，that's. 是的，好吧，我的意思是，那就是。发言人 1 42：06 that's kind of what I do like just like reading online forums and Reddit and X，just like，well，I don't know how to properly load in

people's opinions because they'll say things like I feel like Claude or GPT's gotten dumber or something. They'll say I feel like，and then I sometimes feel like that too，but I wonder if it's the model's problem or mine. 这就是我喜欢做的事情，就像阅读在线论坛、Reddit 和 X 一样，就像，好吧，我不知道

如何正确地加载人们的意见，因为他们会说像我觉得 Claude 或 GPT 变得愚蠢之

类的话。他们会说我觉得，然后有时我也有这样的感觉，但我想知道这是模型

的问题还是我的问题。

发言人 4 42：33 Yeah，with Claude，there is an interesting take I heard where l think AWS has different chips and I suspect they have slightly different

numerics than Nvidia Gpu's and someone speculated that Claude's

degraded performance had to do with maybe using the quantized version that existed on AWS Bedrock versus whatever was running on AnthropicsGpu's. I interview. 是的，和 Claude 一起，我听到一个有趣的观点，我认为 AWS 有不同的芯片，我怀疑它们的数字与英伟达 Gpu 略有不同，有人推测

Claude 的性能下降可能与使用 AWS 基岩上存在的量子化版本有关，而不是使用

人类 Gpu 上运行的任何东西。我采访了。

发言人 1 43：00 a bunch of people that have conspiracy theories I'm glad

spoke. 一群有阴谋论的人，我很高兴说出来了。发言人 5 43：04 spoke to this conspiracy. Well，it's not like conspiracy theory as much，they're just they're like they're，you know，humans，humans are

humans and they're these details and you know，you're doing like this

querying amount of flops and you know，chips are messy and man，you can just have bugs like bugs are. It's hard to hold overstate how hard bugs areto avoid . 谈到了这个阴谋。嗯，这不像阴谋论，它们只是它们就像，你知道，人类，人类就是人类，它们是这些细节，你知道，你正在做这样查询失败的数

量，你知道，芯片是凌乱的，男人。你可以像虫子一样拥有虫子。很难夸大

bug 有多难避免。

发言人 1 43：28 What's the role of a good prompt in all this? We mentioned that benchmarks have really structured well formulated problems，what

should a human be doing to maximize success and what's the importance of what the humans you wrote a blog post on? He called it prompt design. 一个好的提示在这一切中扮演什么角色？我们提到基准测试确实有组织良好的

问题，人类应该做些什么来最大化成功，以及你写的博客文章对人类的重要性

是什么？他称之为即时设计。

发言人 3 43：50 Yeah，I think it depends on which model you're using，and all of them are slightly different and they respond differently to different

prompts，but I think the original GPT-4 and the original is sort of bable

models last last year they were quite sensitive to the prompts and they also had a very small context window. And so we have all of these pieces of

information around the code base that would maybe be relevant in the

prompt，like you have the docs，you have the files that you add，you have

the conversation history，and then there's a problem like how do you decide what you actually put in the prompt end when you have a limited space?

And even for today's models，even when you have long context，filling out the entire context window means that it's slower. It means that sometimes the model actually gets confused，and some models get more confused

than others. And we have this one system internally that we call preamp,

which helps us with that a little bit. And I think it was built for the era before where we had 8000 token context windows. 是的，我认为这取决于你使用的模型，它们都略有不同，对不同提示的反应也不同。但我认为原始 GPT-4 和去

年的原始模型有点像 bable 模型，他们对提示非常敏感，并且他们也有一个非

常小的上下文窗口。因此，我们在代码库中拥有所有这些信息，这些信息可能

在提示中是相关的，就像您有文档，您有添加的文件，您有对话历史记录，然

后还有一个问题，比如当你的空间有限时，你如何决定你实际上在提示端放什

么？即使对于今天的模型，即使您有很长的上下文，填写整个上下文窗口也意

味着速度较慢。这意味着有时模型实际上会感到困惑，有些模型比其他模型更

加困惑。我们内部有一个系统，我们称之为前置放大器，这对我们有一些帮

助。我认为它是为之前拥有 8000 个 Token 上下文窗口的时代而构建的。

发言人 3 45：00 And it's a little bit similar to when you're making a website. You sort of you want it to work on mobile，you want it to work on a desktop screen，and you have this dynamic information which you don't have，for

example，if you're making like designing a print magazine，you have like,

you know，exactly where you can put stuff，but when you have a website or when you have a prompt，you have these inputs and then you need to

format them to always work，Even if the input is really big，then you might have to cut something down and so the idea was，okay，like，let's take some inspiration，what's the best way to design websites? 这有点类似于你制作网站时的情况。你有点希望它可以在移动设备上工作，你希望它可以在桌面屏幕

上工作，并且你拥有这些你没有的动态信息，例如，如果你正在制作像设计印

刷杂志这样的东西，你就有了，你知道，确切地说，你可以把东西放在哪里，

但是当你有一个网站或者有一个提示时，你有这些输入，然后你需要格式化它

们以始终工作，即使输入非常大，那么你可能需要减少一些东西，所以这个想

法是，好吧，让我们从中获得一些灵感，设计网站的最佳方式是什么？ 发言人 3 45：38 The thing that we really like is，is react and the declarative approach where you use Jsx in JavaScript and then you declare this is what I

want and I think this has higher priority or like this has higher Z index than something else. And then you have this rendering engine in webs and it，it's

like Chrome. And in our case，it's a preempted renderer，which then fits

everything onto the page. And as you declare that，we decide what you want，and then it figures out what you want，and as so we have found that to

be quite helpful，I think the role of it has sort of shifted over time，where initially was to fit to these smaller context windows. Now it's really useful because，you know，it helps us with splitting up the data that goes into the prompt and the actual rendering of it. And so it's E debug because you can change the rendering of the prompt and then try it on old prompts because

you have the raw data that went into their prompt. And then you can see，did my change actually improve it for like this entire E set? 我们真正喜欢的是反应和声明性方法，你在 JavaScript 中使用 Jsx，然后你声明这是我想要的，我认为它具有更高的优先级或像这样具有比其他东西更高的 Z 索引。然后你在

网络中有这个渲染引擎，它就像 Chrome 一样。在我们的例子中，它是一个抢

占式渲染器，然后将所有内容都放在页面上。当你声明这一点时，我们决定你

想要什么，然后它确定你想要什么，因此我们发现这非常有帮助，我认为它的

作用随着时间的推移已经发生了变化，最初是为了适应这些较小的上下文窗

口。现在它真的很有用，因为，你知道，它可以帮助我们分割进入提示和实际

呈现的数据。所以它是 E 调试，因为您可以更改提示符的呈现，然后在旧提示

符上尝试，因为您已经将原始数据输入到提示符中。然后你就可以看到，我的

改变真的改善了整个电子设备吗？

发言人 1 46：45 So you literally prompted Jsx，Yes. 所以你真的提示了 Jsx，是的。

发言人 3 46：47 yes，so it kind of looks like react. There are components like we have one component that's，file a component and it takes in like the

cursor，Like usually there's like one line where the cursor is in your file and

that's like probably the most important line because that's one you're

looking at. And so then you can give priorities. So like that line has the

highest priority，and then you subtract one for every line that is farther away，and then eventually when it's rendered it figure out how many lines can it

actually fit in its centers around . 是的，所以看起来有点像反应。有一些组

件，就像我们有一个组件，文件是一个组件，它像 Cursor 一样接收东西，就像

通常 Cursor 在文件中的一行一样，这可能是最重要的一行，因为这是你正在查

看的行。然后你可以确定优先事项。就像那条线具有最高的优先级，然后你为

距离更远的每一行减去一，然后最终在渲染它时，它会计算出它实际上可以在

其中心容纳多少行。

发言人 1 47：16 that thing. That's amazing. 那件事。这太神奇了。

发言人 4 47：17 yeah. And you can do like other fancy things where if you

have lots of code blocks from the entire code base，you could use retrieval and things like embedding and re-ranking scores to add priorities for each of these components. 是的。并且你可以做其他花哨的事情，如果你从整个代码库中有很多代码块，你可以使用检索和嵌入和重新排名分数等方法来为每个

组件添加优先级。

发言人 1 47：30 So should humans，when they ask questions also use try to

use something like that? Like，would it be beneficial to write Jsx And the,

and the problem with the whole idea is this should be loose and messy. 那么人类在问问题时，也应该尝试使用类似的东西吗？像，编写 Jsx 和是否有益，

整个想法的问题是这应该是松散和混乱的。

发言人 3 47：43 I think our goal is kind of that you should just do whatever is the most natural thing for you. And we，our job is to figure out sure，how do we actually like retrieve the relative event thing so that your thing actuallymakes sense? 我认为我们的目标是你应该做任何最自然的事情。而我们，我们的工作是确定，我们实际上如何检索相对事件的东西，以便你的东西实际上产

生感知？

发言人 1 47：56 Well，this is sort of the discussion ahead with Arvin of

perplexity is like his whole idea is like，you should let the person be as lazyas you. 好吧，这是与阿文的讨论，困惑就像他的整个想法是，你应该让这个人

像你一样懒惰。

发言人 248：05Yeah. 是的。

发言人 1 48：06 but like，yeah，that's a beautiful thing. But I feel like you're

allowed to ask more of programmers. So like，if you say，just do what you want，I mean，humans are lazy. There's a kind of tension between just being lazy versus like provide more as，be prompted，almost like the system

pressuring you or inspiring you to be articulate，not in terms of the grammar of the sentences，but in terms of the depth of thoughts that you convey

inside the problems. 但是，是的，这是一件美好的事情。但我觉得你可以问更多的程序员。就像，如果你说，做你想做的，我的意思是，人类是懒惰的。

在懒惰与提供更多的东西之间存在一种紧张关系，被提示，就像系统对你施加

压力或激励你要表达清楚，不是在句子的语法方面，而是在你在问题中传达的

思想深度方面。

发言人 4 48：38 I think even as the system gets closer to some level of

perfection，often when you ask the model for something，you just are not，Not enough intent is conveyed to know what to do. And there are like a few ways to resolve that intent. One is the simple thing of having models just ask you. I'm not sure how to do these parts based on your query. Could you clarify that? I think the other could be maybe if you there are 5 or six

possible generations given the uncertainty present in your query so far，why don't we just actually show you al of those and let you pick them? 我认为即使系统越来越接近完美的水平，通常当你向模型询问某些事情时，你仍然不

够，没有足够的意图传达出来知道该怎么做。有几种方法可以解决这个意图。

一个简单的事情就是让模型问你。我不确定根据您的查询如何完成这些部分。

你能澄清一下吗？我认为另一个可能是，如果你的查询到目前为止存在 5 到 6 个

可能的世代，为什么我们不直接向你展示所有这些世代，让你挑选它们呢？

发言人 1 49：19 How hard is it to for the model to choose to speak talk back sort That's that's hard to sort of like how to deal with the uncertainty? Do I

do I choose to ask for more information to reduce the ambiguity? 对于模型来说，选择说「回话」有多难？这就很难理解如何处理不确定性。我是否会选择

要求更多信息以减少歧义？

发言人 5 49：35 So I mean，one of the things we do is it's like a recent

addition is try to suggest files that you can add. 所以我的意思是，我们做的其中一件事就是像最近添加的一样，尝试建议您可以添加的文件。

发言人 5 49：44 So and while you're typing，one can guess what the

uncertainty is and maybe suggest that like，you know，maybe，maybe you're writing your API and we can guess using the commits that you've made

previously in the same file that the client and the server is super useful. And there's like a hard technical problem of how do you resolve it across all

commits? Which files are the most important given your current prompt?

And we're still sort of initial version is ruled out. And I'm sure we can make it much more accurate. It's very experimental. 因此，当你打字时，人们可以猜测不确定性是什么，也许你知道，也许你正在编写 API，我们可以用你之前在同一文件中所做的提交来猜测客户端和服务器非常有用。而且有一个很难的技术

问题，你如何在所有提交中解决它？根据您当前的提示，哪些文件最重要？我

们仍然排除初始版本的可能性。我相信我们可以让它更准确。这非常具有实验

性。

发言人 5 50：28 But then the idea is we show you like，do you just want to

add this file，this file，this file also to tell，you know，the model to edit those files for you'll Because if，if you're maybe you're making the APl，like you

should also edit the client and the server that is using the API and the other one resolving the API. So that'll be kind of close. But there's the phase

where you're writing a prompt and there's before you even click enter,

maybe we could help resolve some of the uncertainty. 但接下来的想法是我们向您展示，您是否只想添加这个文件，这个文件，这个文件也告诉您编辑这

些文件的模型，因为如果您正在制作 API，像这样，您还应该编辑使用 API 的客

户端和服务器，以及另一个解析 API 的客户端和服务器。这将是接近的。但是有

一个阶段，你在写一个提示，甚至在你点击进入之前，也许我们可以帮助解决

一些不确定性。

发言人 1 50：54 to what degree do use agentic approaches，how useful are

agents? 代理方法的使用程度如何？代理有多大用处？

发言人 3 50：59 We think agents are really，really cool. Like I think agents is

like，it's like resembles sort of like a human，It's sort of like the things like you can kind of feel that it like you're getting closer to AGI because you see a

demo where it act as a human would. And it's really，really cool. 我们认为代理人真的非常酷。就像我认为代理就像，有点像人类，有点像你可以感觉到你

正在接近 AGI，因为你看到一个演示，它表现得像人类一样。这真的非常酷。

发言人 3 51：19 I think agents are not yet super useful for many things. I think we're getting close to where they will actually be useful. And so I think there are certain types of tasks where having an agent would be really nice. Like，I would love to have an agent，for example，if like we have a bug where you

sometimes can't command C and command V inside our chat input box.

And that's a task that's super well specified. I just want to say like in two

sentences，this does not work. Please fix it. And then I would love to have an agent that just goes off，does it，and then a day I come back and I reviewedthe thing. 我认为代理对许多事情还没有超级有用。我认为我们正接近它们真

正有用的地方。所以我认为在某些类型的任务中，有一个代理会非常好。比

如，我很想有一个代理，例如，如果我们有一个错误，你有时无法在我们的聊

天输入框中命令 C 和命令 V。这是一个非常明确的任务。我只想用两句话来说，

这不起作用。请修复它。然后我很想有一个代理人，他就会离开，去做，然后

有一天我会回来审查这件事。

发言人 1 52：02 you mean it goes，finds the right file? 你的意思是它会找到正确的文件？

发言人 3 52：05 Yeah，it finds the right files. It like tries to reproduce the bug，it like fixes the bug，and then it verifies that it's correct. 是的，它会找到正确的文件。它就像是试图重现 bug，它就像是修复了 bug，然后它验证它是正确

的。

发言人 3 52：11 And this is could be a process that takes a long time. And so l think I would love to have had，and then I think a lot of programming like

there is often this belief that agents will take off over all of programming. I

don't think we think that that's the case because a lot of programming，a lot of the value is in iterating or you don't actually want to specify something up front because you don't really know what you want until you've seen an

initial version. And then you want to iterate on that. And then you provide more information. And so for a lot of programming，I think you actually want

a system that's instant，that gives you an initial version instantly back. And then you can iterate super，super quickly. 这可能是一个需要很长时间的过程。所以我想我会喜欢，然后我认为很多编程就像人们经常相信代理人会在所

有编程方面取得成功一样。我不认为我们认为是这种情况，因为很多编程，很

多价值都在迭代中，或者你实际上不想事先指定一些东西，因为你真的不知道

你想要什么，直到你看到一个初始版本。然后你想要迭代。然后你提供更多信

息。因此，对于很多编程，我认为你实际上想要一个即时的系统，它可以立即

给你一个初始版本。然后你可以超级快速地迭代。

发言人 1 52：52 What about something like that，rethinking redlin agent that does also like setting up the development environment，installing software packages，configuring everything，configuring the databases，and actually deploying the app. That also in the set of things you dream about? 这样的事

情怎么样，重新思考 redlin 代理，它也喜欢设置开发环境，安装软件包，配置

所有内容，配置数据库，以及实际部署应用程序。这也在你梦寐以求的事情中

吗？

发言人 3 53：09 I think. So I think that would be really cool. For certain typesof programming. 我认为。所以我觉得那真的很酷。对于某些类型的编程。发言人 1 53：14 it would be really cool. Is that within scope of cursor? 这将会非常酷。那是在 Cursor 的范围内吗？

发言人 3 53：17 Yeah，we're aren't actively working on it right now，but it's definitely like we want to make the programmer's life easier and more fun. And some things are just really tedious and you need to go through a

bunch of steps and you want to delegate that to an agent. And then some things，you can actually have an agent in the background while you're working. Like let's say you have a PR that's both backend and frontend and you're working on the front end，and then you can have a background

agent that doesn't work and figure out kind of what you're doing. And then when you get to the backend part of your PR，then you have some like initial piece of code that you can iterate on. And so that that would also be reallycool. 是的，我们现在并没有积极地工作，但我们肯定想让程序员的生活更轻

松、更有趣。有些事情真的很乏味，你需要经历一系列步骤，然后你想把它委

托给一个代理人。然后有些事情，你实际上可以在工作时在后台有一个代理。

就像假设你有一个既是后端又是前端的公关，你正在前端工作，然后你可以有

一个不起作用的后台代理，然后弄清楚你在做什么。然后当你到达公关的后端

部分时，你有一些像初始代码一样的代码可以迭代。这样也会很酷。

发言人 1 53：58 One of the things we already talked about is speed，but l

wonder if we could just linger on that some more in the various places that the technical details involved in making this thing really fast. So every single aspect of cursor，most aspects of cursor feel really fast. Like I mentioned，the apply is probably the slowest thing for me for，sorry，the pain. 我们已经谈过的一件事是速度，但我想知道我们是否可以在使这个东西真正快速的技术细节

中停留在各个地方。所以 Cursor 的每一个方面，Cursor 的大多数方面都感觉非

常快。就像我提到的，对于我来说，申请可能是最慢的事情，抱歉，疼痛。

发言人 3 54：22 It's a pain，it's a pain that we're feeling. We're rank and fixingit. 这是一种痛苦，这是我们正在感受的痛苦。我们正在排名和修复它。

发言人 454：27 Yeah. 是的。

发言人 1 54：27 I mean，it says something that something that feels，I don't know what it is，like one second or two seconds，that feels slow，That means that's actually shows that everything else is just really，really fast. So is there some technical details about how to make some of these models，to make the chat fast，how to make the DS fast? Is there something that just jumps tomind? 我的意思是，它说的是一些感觉，我不知道是什么，比如一秒钟或两秒

钟，感觉很慢，这意味着这实际上表明其他一切都非常非常快。那么，关于如

何制作这些模型，如何让聊天更快，如何让 DS 更快，有一些技术细节吗？有什

么东西会跳到脑海里吗？

发言人 4 54：49 Yeah，I mean，so we can go over a lot of the strategies that we use. One interesting thing is cash warming. And so what you can do is if as the user is typing，you can have，you're probably going to use some piece of context and you can know that before the user's done typing. So，you

know，as we discussed before，reusing the Kv cache results in lower latency，lower costs，cross requests. So as a user starts，I think you can immediately warm the cache with like，let's say，the current file contents. And then when they press enter，there's very few tokens，it actually has to prefill and

compute before starting the generation. This will significantly lower ttfd. 是的，我的意思是，我们可以回顾一下我们使用的许多策略。一个有趣的事情是

现金变暖。所以你可以做的是，如果当用户在打字时，你可能会使用一些上下

文，并且你可以在用户完成打字之前知道这一点。所以，你知道，正如我们之

前讨论的，重用 Kv 缓存可以降低延迟、降低成本、跨请求。因此，当用户开始

时，我认为您可以立即加热缓存，比如说当前文件内容。然后当他们按 enter 键

时，Token 非常少，实际上必须在开始生成之前进行预填充和计算。这将显著

降低 ttfd。

发言人 1 55：30 can you explain how Kv cache works? 你能解释一下 Kv 缓存是如何工作的吗？

发言人 4 55：32 Yeah，the transform his work，like I mean，like one of the

mechanisms that allow transformers to not just independently，like the mechanism that allows transformers to not just independently look at each token，but see previous tokens are the keys and values to 10 and generally the way attention works is you have at your current token some query，and then you've all the keys and values of all your previous tokens，which are some kind of representation that the model stores internally of all the

previous tokens in the prompt and like by default when you're doing a chat，the model has to for every single token do this four pass through the entire model. That's a lot of matrix multiplies that happen，and that is really，really slow instead if you have already done that and you stored the keys and

values and you keep that in the GPU，then when I'm，let's say I have to sort it for the last N tokens if I now want to compute the output token for the n

plus one token，I don't need to pass those first end tokens through the

entire model because I already have all those keys and values. And so you just need to do the forward pass through that last token. And then when

you're doing attention，you're reusing those keys and values that have been computed，which is the only kind of sequential part or sequentially

dependent part of the transformer. 是的，他的工作，就像我的意思一样，就像允许变压器不仅仅是独立的机制一样，就像允许变压器不仅仅是独立地查看

每个 Token 的机制一样，但是请参阅之前的 Token 是 10 的键和值，通常注意力

的工作方式是您在当前 Token 上进行一些查询，然后您拥有所有之前 Token 的所

有键和值，这是模型内部存储提示符中所有先前 Token 的某种表示，就像默认

情况下一样，当您进行聊天时，模型必须为每个 Token 执行此操作四个穿过整

个模型。这是发生了很多矩阵乘法，这真的非常慢，如果你已经这样做了，存

储了键和值并将其保存在 GPU 中，那么当我，假设我现在想要计算 N 加一

Token 的输出 Token，我必须对最后 n 个 Token 进行排序，我不需要通过整个模型传递这些第一个结束 Token，因为我已经有了所有这些键和值。所以你只需

要通过最后一个 Token 进行正向传递。然后当你集中注意力时，你正在重用那

些已经计算过的键和值，这是转换器唯一的顺序部分或顺序依赖的部分。发言人 1 56：59 Is there like higher level caching of like caching of the

prompts or that kind of stuff to help? 是否有更高级别的缓存、缓存提示之类

的东西可以提供帮助？

发言人 4 57：06 Yeah，that that there's other types of caching you can kind of

do? One interesting thing that you can do for cursor tab is you can basically

predict the head as if the user would have accepted the suggestion and then trigger another request. And so then you've cash，you've done the speculative. It's a mix of speculation and caching，right? Because you're speculating what would happen if they accepted it. And then you have this

value that is cash this，this suggestion. When they press tab，the next one would be waiting for them immediately. It's a kind of clever heuristic slash trick that uses a higher level caching and can give the it feels fast despite there not actually being any changes in the in the model. 是的，那还有其他

类型的缓存你可以做吗？你可以为 Cursor 标签做的一件有趣的事情是，你基本

上可以预测头部，就像用户会接受建议一样，然后触发另一个请求。然后你就

现金了，你已经做了投机。这是猜测和缓存的混合，对吧？因为你在猜测如果

他们接受了会发生什么。然后你就有了这个现金这个建议的值。当他们按下 tab

键时，下一个会立即等待他们。这是一种聪明的启发式斜线技巧，使用更高级

别的缓存，尽管模型中实际上没有任何变化，但可以给人以快速的感觉。

发言人 5 57：54 And if you can make the Kv cache smaller，one of the

advantages you get is like maybe，maybe speculate even more. Maybe you

can guess. Here's the 10 things that you could be useful，likelike predict the

next 10 and like it's possible the user hits the one of the 10，it's like much higher chance than the user hits like the exact one that you show them. Maybe they type another car current and when you sort of hits hit

something else in the cache. So there's there's al these tricks where. 如果你

能让 Kv 缓存更小，你得到的优势之一就是，也许可以推测更多。也许你可以猜到。以下是您可能有用的 10 件事，例如预测下一个 10，以及用户可能点击其中

一个，这比用户点击的确切机会要高得多，例如您向他们展示的那个。也许他

们会输入另一辆车的电流，当你击中缓存中的其他东西时。所以有所有这些技

巧在哪里。

发言人 5 58：22 The general phenomena here is，I think it's also super useful for our always，you know，maybe a single sample from the model isn't very good. But if you predict like 10 different things，turns out that one of the 10 that's right is the probability is much higher. 这里的一般现象是，我认为这对我们总是非常有用，你知道，也许模型中的一个样本不是很好。但是，如果你

预测了 10 个不同的事情，结果表明其中一个是正确的，概率要高得多。

发言人 5 58：42 There's these passive key curves and you know，part of RL try like what RL does is you can exploit this passive K phenomena to you to

make many different predictions. And one way to think about this，the

model sort of knows internally has like，has some uncertainty over like which of the key things is correct or like which of the key things does the human want? So when we are I-r，you know，cursory tab model，one of the things we're doing is we're predicting which like which of the 100 different

suggestions the model produces is more amenable for humans. Like which of them do humans more like than other things? Maybe，maybe like there's something where the modelle can predict very far ahead versus like a little bit and maybe somewhere in the middle and you know，just，and then you can give a reward to the things that humans would like more and sort of

punish the things that it would like and sort of then train the model to

output the suggestions that humans would like more. You have these like RL loops that are very useful that exploit these page at K curves. Oman maybe can can go into even more detail. 有这些被动的关键曲线，你知道，RL 的一部分尝试像 RL 所做的那样，你可以利用这种被动的 K 现象来做出许多不同的预测。有一种思考方式是，模型内部知道的东西有不确定性，比如哪个关键的东

西是正确的，或者人类想要哪个关键的东西？所以当我们使用 l-r，你知道，粗

略的标签模型时，我们正在做的一件事是预测模型产生的 100 个不同建议中哪

个更适合人类。人类比其他东西更像他们中的哪一个？也许，也许像有一些东

西，模型可以预测很远的前方，而不是像一点点，也许在中间的某个地方，你

知道，只是，然后你可以对人类想要的东西给予奖励，对人类想要的东西给予

惩罚，然后训练模型输出人类想要的建议。你有这些类似 RL 循环的循环，它们

非常有用，可以利用这些页面的 K 曲线。曼曼也许可以进入更多细节。

发言人 4 59:48 Yeah， it＇s a little， it is a little different than speed， but I mean， like technically you tie it back in because you can get away with the smaller model if you are all your smaller model and gets the same performances， that＇s the bigger one that＇s like， and while I was mentioning stuff about Kv， about reducing the size of your Kv cache， there are other techniques there as well. They＇re really helpful for speed. 是的，它有点，它和速度有点不同，但是我的意思是，从技术上讲，你把它绑定回去，因为如果你都是较小的模

型，并且得到相同的性能，你可以摆脱较小的模型，那就是更大的那个，就

像，当我提到关于 Kv 的东西时，关于减少 Kv 缓存的大小，还有其他技术。它们

对速度非常有帮助。

发言人 4 01:00:13 Kind of back in the day， like all the way two years ago，

people mainly used multihead attention. I think there＇s been a migration towards more efficient attention schemes like group query or multi query attention. And this is really helpful for then with larger batch sizes being

able to generate the tokens much faster. The interesting thing here is this now has no effect on that time to first token prefill speed. The thing this

matters for is now generating tokens. And why is that? Because when you＇re generating tokens， instead of being bottlenecked by doing this super

paralyzed matrix multiplies across all your tokens， your bottleneck by how quickly for long context with large batch sizes，by how quickly you can read those cache keys and values. And so then how that's memory bandwidth

and how can we make this faster? 有点回到过去，就像两年前一样，人们主要使用多点注意力。我认为已经转向更有效的关注方案，如群体查询或多查询关

注。这对于更大的批量规模能够更快地生成 Token 非常有帮助。有趣的是，现

在这对第一次 Token 预填充速度没有影响。现在重要的事情是生成代币。为什

么呢？因为当您生成 Token 时，您的瓶颈不是通过在所有 Token 上进行超级瘫痪矩阵乘法来实现的，而是通过在大容量的长上下文环境中快速读取这些缓存键

和值的速度来实现。那么这就是内存带宽，我们如何使它更快？

发言人 4 01：01：12 We can try to compress the size of these keyston values,

so multiqueue attention is the most aggressive of these，where normally

with multihead attention，you have some number of quote unquote

attention heads and some number of kind of query query heads,

multiqueue just preserves the query heads，gets rid of all the key value

heads. So there's only one kind of key value head and there's all the

remaining query heads. With group query，you instead preserve all the

query heads，and then your keys and values are kind of there are fewer

heads for the keys and values，but you're not reducing it to just one. But

anyways，like the whole point here is you're just reducing the size of your KDcache. 我们可以尝试压缩这些 keyston 值的大小，因此多队列关注是其中最具侵略性的，通常在使用多头关注时，您有一些数量的引号关注头和一些类型的

查询头，多队列只是保留查询头，摆脱所有关键价值头。因此，只有一种键值

头，还有所有剩余的查询头。使用组查询，您可以保留所有的查询头，然后您

的键和值有点像键和值的头更少，但您不会将其减少到只有一个。但无论如

何，这里的重点是你只是减少了 KD 缓存的大小。

发言人 3 01：02：00 And then there is Mla. 然后还有 Mla。发言人 401：02：02 Yeah，multi latent. That's a little more complicated. The

way that this works is it kind of turns the entirety of your keys and values

across all your heads into this kind of 1 latent vector that is then kind of

expanded inference time. 是的，多重潜伏。这有点复杂。它的工作方式是将你头脑中的整个键和值转化为这种潜在向量，然后扩展推理时间。

发言人 5 01：02：19 But Mla is from this company called Deep Seek. It's quite an interesting algorithm. Maybe the key idea is sort of in both MOA and in other places，what you're doing is sort of reducing the，like the number of Kv heads. The advantage you get from that is is，you know，there's less of

them，but maybe the theory is that you actually want a lot of different，like you want each of the keys and values to actually be different. So one way to reduce the sizes，you keep one big shared vector for all the keys and values，and then you have smaller vector is for every single token so that when you can store the only the smaller thing，there's some sort of like low rank

reduction. And the lower rank reduction was that. And at the end of the

time when you，when you eventually want to compute the final thing,

remember that like your memory band，which means that like you still have some compute left that you can use for these things in if you can expand

the latent vector back out and somehow like this is far more efficient

because just like you're reducing，like for example，maybe like reducing like 30 q or something like the size of the vector that you're keeping. 但 Mla 来自一家名为「深度寻找」的公司。这是一个相当有趣的算法。也许关键的想法是在

MQA 和其他地方，你正在做的是减少 Kv 头的数量。你从中得到的优势是，你知

道，它们比较少，但也许理论上你实际上想要很多不同的东西，就像你希望每

个键和值实际上都不同一样。因此，减少大小的一种方法是，为所有键和值保

留一个大的共享向量，然后为每个 Token 拥有较小的向量，这样当您可以存储

唯一较小的东西时，就会出现某种低秩减少。而较低的等级降低是这样的。当

你最终想要计算最终事物时，请记住，就像你的记忆带一样，这意味着，如果你可以将潜在向量扩展回来，你仍然有一些剩余的计算可以用于这些事情，以

某种方式这样更高效，因为就像你正在减少一样，例如，可能像减少 30 个 q 或

者类似你保持的向量大小的东西。

发言人 401：03：37 yeah，there's perhaps some richness and having a

separate set of keys and values and query that kind of pairwise matchup versus compressing that all into one and that interaction at least. 是的，也许有一些丰富性，拥有一组独立的键和值以及查询，这种成对匹配与将所有内

容压缩成一个，至少是交互作用。

发言人 1 01：03：51 okay，all of that is dealing with being memory bound,

Yeah，and what I mean ultimately how does that map to the user experience trying to get the yeah. 好的，所有这些都涉及内存限制，是的，我的意思是最终如何将其映射到用户体验中，试图获得 Yeah。

发言人 4 01：04：02 the two things that it maps to is you can now make your cache a lot larger because you've less space allocated for the kv cache，you can maybe cache a lot more aggressively and a lot more things you get

more cash hits which are helpful for reducing the time to first token for the reasons that were kind of described earlier and then the second being

when you start doing inference with more and more requests and larger and larger batch sizes，you don't see much of a slowdown in as it's

generating the tokens the speed of that. 它映射的两件事是，你现在可以让你的缓存变得更大，因为你为千伏缓存分配的空间更少了，你可以缓存更多的东

西，你会得到更多的现金点击，这有助于减少第一个 Token 的时间，原因之前

已经描述过了。第二，当你开始对越来越多的请求和越来越大的批量进行推理

时，你不会看到太多的放缓，因为它正在以这样的速度生成 Token。

发言人 5 01：04：31 but it also allows you to make your prompt bigger forsure. 但它也可以让你的提示更大。

发言人 4 01：04：34 Yeah，so basically the size of your kv cache is both the size of all your prompts multiplied by the number of prompts you processed in parallel，So you could increase either those dimensions the batch size or the size of your prompts without degrading the latency of generating tokens. 是的，所以基本上你的千伏缓存的大小是所有提示的大小乘以你并行处理的提示

数量，所以你可以增加批量大小或提示的大小，而不会降低生成 Token 的延

迟。

发言人 1 01：04：51 Arvid，you wrote a blog post Shadow of Workspace,

iterating on code in the background. So what's going on? Arvid，你写了一篇博客文章「工作区的影子」，在后台迭代代码。所以发生了什么？

发言人 3 01：04：58 So to be clear，we want there to be a lot of stuff，stuff

happening in the background，and we're experimenting with a lot of things right now，we don't have much stuff happening other than like the cash

warming or like，you know，figuring out the right context that goes into your command prompt，for example. But the idea is if you can actually spend

computation in the background，then you can help help the user，maybe

like at a slightly longer time horizon than just predicting the next few lines that you're going to make，but actually like in the next 10 minutes，whatever you're going to make. And by doing it in background，you can spend more computation doing that. And so the idea of the shadow workspace that we implemented，and we use it internally for like experiments is that to actually get advantage of doing stuff in the background，you want some kind of

feedback signal to give back to the model，because otherwise you can get higher performance by just letting the model think for longer. And so like O 1 is a good example of that. But another way you can improve performance is by letting the model iterate and get feedback. 所以为了明确，我们希望有

很多事情，一些事情在背景中发生，我们现在正在试验很多事情，除了现金变

暖或其他类似的事情，我们没有太多事情发生。例如，找出进入命令提示符的

正确上下文。但是这个想法是，如果你实际上可以在后台进行计算，那么你可

以帮助用户，也许可以在更长的时间范围内帮助用户，而不仅仅是预测接下来

的几行，但实际上可以在接下来的 10 分钟内，无论你要做什么。通过在后台进

行，您可以花费更多的计算来完成。因此，我们实现的阴影工作空间的想法，

我们在内部将其用于类似的实验，是为了真正利用在背景中做事情，你需要某

种反馈信号来反馈给模型，否则，你可以通过让模型思考更长时间来获得更高

的性能。所以像 O1 就是一个很好的例子。但另一种提高性能的方法是让模型

迭代并获得反馈。

发言人 3 01:06:07 And so one very important piece of feedback when you＇re

a programmer is the language server， which is this thing. It exists for most

different languages. And there＇s like a separate language over per

language. And it can tell you know， you＇re using the wrong type here and

then gives you an error， or it can allow you to go to definition. It sort of understands the structure of your code. So language servers are extensions

developed by like there＇s a TypeScript language server developed by the

TypeScript people， a Rus language survey developed by the Rus people，

and then they al interface over the language survey protocol to Vs Code. 当

你是一名程序员时，一个非常重要的反馈就是语言服务器，也就是这个东西。

它存在于大多数不同的语言中。每一种语言都有一种单独的语言。它可以告诉

你，你在这里使用了错误的类型，然后给你一个错误，或者它可以让你进入定

义。它有点理解你的代码结构。因此，语言服务器是由以下人员开发的扩展：

有一个打字稿语言服务器，一个由 Rus 人开发的 Rus 语言调查，然后它们都通过

语言调查协议与 Cursor 进行接口。

发言人 3 01:06:43 So that Vs Code doesn＇t need to have all of the different languages built into Vs Code，but rather you can use the existing compiler

infrastructure for linting purposes. It's for，it's for linting，it's for going to definition. And if we're like seeing the right types that you're using. 这样 Cursor 就不需要内置所有不同的语言，而是可以使用现有的编译器基础设施进

行 lint。这是为了，这是为了 lint，这是为了去定义。如果我们想要看到您正在

使用的正确类型。

发言人 1 01：06：59 I was doing like type checking also. 我也在做类型检查。发言人 3 01：07：01 Yes，type checking and going to references. And that's like when you're working in a big project，you kind of need that. If you，if you don't have that，it's like really hard to code in a big project. 是，键入检

查并转到引用。这就像当你在一个大项目中工作时，你需要它。如果你没有那

个，在一个大项目中编码就像真的很难。

发言人 1 01：07：12 Can you say again how that's being used inside cursor,

the language server protocol communication thing? 你能再说一遍 Cursor 内

是如何使用语言服务器协议通信的吗？

发言人 3 01：07：20 So it's being used in cursor to show to the programmer,

just like in V could，but then the idea is you want to show that same

information to the models，the IO models，and you want to do that in a way

that doesn't affect the user because you want to do it in background. And

so the idea behind the Chatter workspace was，okay，like one way we can

do this is we spawn a separate window of cursor that's hidden. And so you

can set this flag in Electron，it's hidden there is a window，but you don't actually see it and inside of this window，the Al agents can modify code however they want as long as they don't save it because it's still the same

folder and then can get feedback from from the linters and go to definition and iterate on their code. 所以它被用在 Cursor 处向程序员展示，就像在 V 中一样，但想法是你想向模型，IO 模型展示相同的信息，并且您希望以不影响用户

的方式执行此操作，因为您希望在后台执行此操作。所以聊天工作区背后的想

法是，好的，我们可以这样做的一种方法是生成一个隐藏的单独的 Cursor 窗

口。所以你可以在电子中设置这个标志，它是隐藏的，有一个窗口，但你实际

上看不到它，在这个窗口中，A | 代理可以修改他们想要的代码，只要他们不保

存代码，因为它仍然是相同的文件夹，然后可以从插件中获得反馈，然后进入

定义并迭代他们的代码。

发言人 1 01：08：04 So like literally run everything in the background like as if，right，yeah，maybe，maybe even run the code. 所以就像在后台运行一切一

样，对吧，是的，也许，甚至可能运行代码。

发言人 3 01：08：10 so that's the eventual version，okay，that's what you want. And a lot of the blog post is actually a bunch，how do you make that

happen? Because it's a little bit tricky，you want it to be on the user's

machine so that it exactly mirrors the user's environment，and then on Linux，you can do this cool thing where you can actually mirror the file system and have the Al makes changes to the files and it thinks that it's operating on the file level，but actually that's stored in memory. And you can create this

kernel extension to make it work. Whereas on Mac and Windows，it's a little bit more difficult. But it's a fun technical problem，so that's why. 所以这就是最终版本，好吧，这就是你想要的。很多博客帖子实际上是一堆，你如何做到

这一点？因为这有点棘手，你希望它在用户的机器上，以便完全镜像用户的环

境，然后在 Linux 上，你可以做这件很酷的事情，你可以实际镜像文件系统并让

A | 对文件进行更改，它认为它是在文件级别的操作，但实际上它是存储在内存

中的。你可以创建这个内核扩展来使其工作。而在 Mac 和 Windows 上，则稍微

困难一些。但这是一个有趣的技术问题，这就是原因。发言人 4 01：08：57 one maybe hacky，but interesting idea that I like is holding

a lock on saving. And so basically you can then have the language model kind of hold a lock on on saving to disk. And then instead of you operating in the ground truth version of the files that are saved to this，you actually are

operating what was the shadow workspace before. And these unsafe things

that only exist in memory that you still get linter errors for you code in. And then when you try to maybe run code，it's just like there's a small warning that there's a lock，and then you kind of will take back the lock from the

language server if you're trying to do things concurrently，or from the

Shadow workspace if you're trying to do things concurrently. 一个可能是黑客，但我喜欢的有趣的想法是锁定储蓄。因此，基本上你可以让语言模型在保

存到磁盘时保持锁定。然后，您不是在保存到这里的文件的地面真实版本中操

作，而是实际上在操作之前的影子工作空间。这些不安全的东西只存在于内存

中，你仍然会在代码中得到 linter 错误。然后当你尝试运行代码时，就像有一个

小警告说有一个锁，如果你试图并发执行操作，你会从语言服务器收回锁。或

者，如果您尝试同时执行操作，则从阴影工作区开始。

发言人 1 01：09：31 That's such an exciting future，by the way. It's a bit of a tangent，but like to allow a model to change files. It's scary for people，but like it's really cool to be able to just like let the agent do a set of tasks and you come back the next day and kind of observe like it's a colleague or

something like that. 顺便说一下，这是一个令人兴奋的未来。这有点相切，但

喜欢允许模型更改文件。这对人们来说是可怕的，但能够让代理人完成一组任

务，第二天回来观察同事或类似的事情，真的很酷。

发言人 4 01：09：51 Yeah，and I think there may be different versions of like run ability where for the simple things where you're doing things in the span

of a few minutes on behalf of the user as they're programming，it makes sense to make something work locally in their machine. I think for the more aggressive things where you're making larger changes that take longer

periods of time，you'll probably want to do this in some sandbox remote environment. And that's another incredibly tricky problem of how do you exactly reproduced or mostly reproduced to the point of it being effectively

equivalent for running code，the user's environment? What is remote,

remote. 是的，我认为可能有不同版本的像「运行能力」这样的东西，对于简单

的事情，即在用户编程时代表用户在几分钟的跨度内完成任务，这使得在他们

的机器上本地工作变得感知。我认为，对于更激进的事情，如果你进行更大的

更改，需要更长的时间，你可能会想在一些沙盒远程环境中这样做。这是另一

个非常棘手的问题，你如何准确地复制或大部分复制，以使其有效地等效于运

行代码，用户的环境？什么是远程，远程。

发言人 5 01：10：26 sandbox? I'm curious what kind of agency you want for coding? Did you want them to find bugs? Do you want them to like

implement new features，like what agents do you want? 沙箱？我很好奇你想

要什么样的机构编码？你想让他们发现 bug 吗？你希望他们喜欢实施新功能

吗，比如你想要什么代理？

发言人 1 01：10：36 So by the way，when I think about agents，I don't think just

about coding，I think so for the practices，this particular podcast，this video editing，and a lot of，if you look in Adobe，a lot of there's code behind，it's very poorly documented code，but you can interact with Premiere，for

example，using code and basically all the uploading，everything I do on YouTube，everything. As you could probably imagine，I do all of that

through code and including translation and overdubbing，all of this. So I envision all of those kinds of tasks. So automating many of the tasks that don't have to do directly with the editing. So that，okay，that's what I was thinking about. But in terms of coding，I would be fundamentally thinking about bug finding，like many levels of kind of bug finding，and also bug finding， like logical bugs， not logical like spiritual bugs or something. Ones sort of big directions of implementation， that kind of stuff . 顺便说一句，当我想到代理时，我不仅仅是想到编码，我认为对于实践，这个特定的播客，这

个视频编辑以及很多，如果你看一下 Adobe，很多背后都有代码，它的代码记

录非常糟糕，但是你可以与 Premiere 互动，例如使用代码和基本上所有的上

传，我在 YouTube 上做的一切。正如你可能想象的那样，我通过代码完成所有

这些，包括翻译和配音。所以我设想所有这些类型的任务。因此，自动化许多

与编辑不直接相关的任务。所以，好吧，那就是我在想的。但是在编码方面，

我会从根本上考虑错误发现，就像许多不同层次的错误发现一样，还有错误发

现，就像逻辑错误一样，而不是像精神错误一样。这些是一种大的实现方向，

诸如此类的东西。

发言人 501:11:38 that Joe Pine and bug-fixing. 那蔡崇信（Joe）松树和虫子修复。

发言人 4 01:11:39 Yeah， I mean， it＇s really interesting that these models are so bad at bug-fixing when just naively prompted to find a bug. They＇re

incredibly poorly calibrated. 是的，我的意思是，这真的很有趣，当天真地提示找到错误时，这些模型在修复错误方面非常糟糕。它们的校准非常糟糕。

发言人 3 01:11:51 even the smartest model. 即使是最聪明的模型。

发言人 401:11:52 exactly even， oh， even zero 1. 完全是偶数，哦，甚至是零至 1。

发言人 1 01:11:54 how do you explain that? Is there a good intuition? 你怎么解释？有好的直觉吗？

发言人 4 01:11:58 I think these models are really strong reflection of the

pretrained and， you know， I do think they generalize as the loss gets lower and lower，but I don't think the loss and the scale is quite or the loss is low enough such that they're like really fully generalizing in code like the things that we use these things for the frontier models that they're quite good at are really code generation and question answering. And these things exist in massive quantities and prey training-induced all of the code on GitHub on the scale of many，many trillions of tokens and questions and answers on things like stack overflow and maybe GitHub issues and so when you try to push into these things that really don't exist very much online，like for

example，the cursor tab objective of predicting the next edit given the edits done so far，the brittleness kind of shows. And then bug detection is

another great example where there aren't really that many examples of like actually detecting real bugs and then proposing fixes，and the models just kind of like really struggle at it. I think it's a question of transferring the

model，like in the same way that you get this fantastic transfer from

pretrained models just on code in general to the cursor tab objective，you'll see a very，very similar thing with generalized models that are really good at code to bug detection. It just takes like a little bit of kind of nudging in thatdirection. 我认为这些模型非常强烈地反映了预训练的结果，你知道，我认为

随着损失越来越低，它们会泛化。但我不认为损失和规模相当，或者损失足够

低，以至于他们在代码中完全概括，就像我们在前沿模型中使用的东西一样，

他们非常擅长代码生成和问题回答。而且这些东西大量存在，猎物训练引起的

GitHub 上的所有代码，规模高达数万亿个代币，以及有关堆栈溢出和 GitHub

问题的问题和答案，因此当您尝试推进这些在线上并不存在的东西时，例如，

根据到目前为止所做的编辑，Cursor 选项卡的目标是预测下一次编辑，显示脆

性。然后漏洞检测是另一个很好的例子，在这个例子中，并没有太多的例子能

够真正检测到真正的漏洞，然后提出修复建议，而这些模型只是真的很挣扎。

我认为这是一个转移模型的问题，就像你从一般代码上获得预训练模型到

Cursor 选项卡目标的奇妙转移一样，你会看到一个非常非常相似的事情，通用

模型非常擅长编码和缺陷检测。它只需要朝那个方向一点点的努力。发言人 5 01：13：25 Like to be clear，I think they sort of understand code really well，like while they're being pretrained，like the representation that's being built up，like almost certainly like，you know，somewhere in the stream,

there's the model knows that maybe there's，there's some something

sketchy going on，right? It sort of has some sketchiness，but actually eliciting the sketchiness cue. 我希望保持清晰，我认为他们对代码的理解非常好，就像在预先训练时，就像正在建立的表示一样，就像几乎可以肯定的是，你知道，

在流程中的某个地方，模型知道可能有，有一些不稳定的事情正在发生，对

吧？它有点粗略，但实际上却能引发粗略的暗示。

发言人 5 01：13：49 Like actually，like part，part of it is that humans are really calibrated on which bugs are really important. It's not just actually，it's not just actually saying like there's something sketchy. It's like it's just just a

sketchy trivial. It's just sketchy like you're going to take the server down. It's like，like part of it is maybe the cultural knowledge of like，why is it staff

engineer? 就像实际上一样，部分原因是人类真正校准了哪些虫子非常重要。

它不仅仅是实际上，它不仅仅是说有一些粗略的东西。就好像它只是一个粗略

的琐碎。这只是粗略的，就像你要关闭服务器一样。这就像是文化知识的一部

分，为什么它是员工工程师？

发言人 5 01：14：08 Staff engineer? Staff engineers is good because they

know that three years ago，like someone wrote a really，you know，sketchy piece of code that took took the server down and as opposed to like，yeah，supposed to maybe there's like，you know，you're just this thing is like an

experiment. So like a few bugs are fine，like you're just trying to experiment and get the feel of the thing. And so if the model gets really annoying when you're writing an experiment，that's really bad. But if you're writing

something for super production，you're like writing a database，right? You're writing code in Postgres or Linux or whatever，like your Linus，Torvald，you're，it's sort of unacceptable to have even in that case and just having the calibration of like，how paranoid is the user Like. 人事工程师？工程师是好

的，因为他们知道三年前，就像有人写了一个非常粗略的代码，把服务器取下

来，而不是像，是的，应该有，你知道，你只是这个东西就像一个实验。就像

一些虫子是可以的，就像你只是在尝试并获得事物的感觉。因此，如果当你写

一个实验时，模型变得非常烦人，那就非常糟糕了。但是如果你在为超级作品

写东西，你就像在写数据库，对吧？你用 Postgres 或 Linux 或其他东西编写代

码，就像你的 Linus,Torvald 一样，即使在这种情况下，仅仅使用像这样的校准也是不可接受的，用户是多么的偏执。

发言人 4 01：14：51 but even then，like if you're putting in a maximum

paranoia，it still just like doesn't quite get it. 但即使这样，就像你投入了最大的妄想症一样，它仍然不太明白。

发言人 501：14：57 Yeah. 是的。

发言人 1 01：14：58 I mean，but this is hard for humans to understand what

which line of code is important，which is not like you. I think when your

principles on a website says if a code can do a lot of damage，one should

add a comment that say this line of code is is dangerous. 我的意思是，但人类很难理解哪一行代码是重要的，哪一行代码不像你。我认为，当你在网站上

的原则说，如果一个代码可以造成很大的损害时，应该添加一条评论，说这一

行代码是危险的。

发言人 301：15：16 and all. 以及所有。

发言人 1 01：15：17 caps 10 times，no. And you say like for every single line of code inside the function，you have to，and that's quite profound that says

something about human beings because the engineers move on，even the same person might just forget how it can sync the Titanic. A single function like you don't，you might not intuit that quite clearly by looking at the single

piece of code. 盖帽 10 次，不是。你说像函数内的每一行代码一样，你必须这

样做，这非常深刻地说明了人类的一些事情，因为工程师继续前进，甚至同一

个人可能会忘记它是如何同步泰坦尼克号的。一个单一的函数，就像你不知道

的那样，你可能无法通过查看单个代码来清晰地直觉到它。

发言人 3 01：15：42 Yeah，and I think that that one is also，partially also for today's Al models where if you actually write dangerous，dangerous,

dangerous in every single line，like the models will pay more attention to that and will be more likely to find bucks in that region. 是的，我认为这也部

分适用于今天的 AI 模型，如果你在每一行中都写了危险的，危险的，像模型一

样会更加关注这一点，并且更有可能在那个地区找到资金。

发言人 1 01：16：00 That's actually just straight up a really good practice of labeling code of how much damage this can do. 这实际上只是一个非常好的

做法，标签代码可以造成多大的损害。

发言人 3 01：16：08 Yeah，I mean，it's controversial. People think it's ugly. 是的，我的意思是，这是有争议的。人们认为它很丑陋。

发言人 5 01：16：13 think it like in fact，I actually think it's one of the things I learned from our It is，you know，I sort of aesthetically，I don't like it，but I think there's certainly something where like it's useful for the models and humans just forget a lot and it's really easy to make a small mistake and cause like bring down，you know，like just bring down the server and like，like of course we like test a lot and whatever，but there's always these things

that you have to be very careful. 实际上，我认为这是我从我们那里学到的一

件事，你知道，我在美学上有点不喜欢它，但我认为肯定有一些东西，比如它

对模型很有用，人类只是忘记了很多，而且很容易犯一个小错误，就像击落服务器一样，当然我们喜欢测试很多东西，但是总是有这些事情你必须非常小

.

发言人 4 01：16：42 Yeah，like with just normal DOC strings，I think people will often just skim it when making a change and think，oh，I know how to do this

and you kind of really need to point it out to them so that that doesn't slipthrough. 是的，就像普通的文档字符串一样，我认为人们在做出改变时经常会

浏览一下，然后想，哦，我知道怎么做，你真的需要向他们指出来，这样就不

会溜走了。

发言人 1 01：16：55 Yeah，you have to be reminded that you can do a lot of damage. That's like，we don't really think about that. Like，yeah，you think about，okay，how do I figure out how this works so I can improve it? You don't think about the other direction. 是的，你必须被提醒，你可以造成很多伤害。就像，我们并没有真正考虑过这个问题。就像，是的，你想想，好吧，

我如何弄清楚这是如何工作的，以便我可以改进它？你不会想到另一个方向。

发言人 3 01：17：08 until until we have formal verification for everything，then you can do whatever you want. You know for certain that you have not

introduced a bug if the proof pass. 在我们对所有事情进行正式验证之前，你可以做任何你想做的事情。如果证明通过了，你可以肯定地知道你没有引入错

误。

发言人 401：17：18 But concretely，what do you think that future would looklike? 但具体来说，你认为未来会是什么样子？

发言人 3 01：17：21 I think people wil just not write tests anymore and the model will suggest like you write a function，the model will suggest a spec，and you review the spec，and in the meantime，smart reasoning model

computes a proof that the implementation follows this spec. And I think thathappens for most functions. 我认为人们不再编写测试了，模型会建议你编写一个函数，模型会建议一个规范，然后你审查规范，同时，智能推理模型会计

算实现遵循该规范的证明。我认为这种情况发生在大多数功能中。

发言人 2 01：17：44 You think this gets at a little bit some of the stuff you were talking about earlier with the difficulty of specifying intent for what you want with software，where sometimes it might be because the intent is really hard to specify it's also then going to be really hard to prove that it's actually

matching whatever your intent is. 你认为这有点像你之前谈到的一些东西，很难用软件来指定你想要的意图，有时候可能是因为意图真的很难具体说明，所

以也很难证明它实际上与你的意图相匹配。

发言人 3 01：17：58 like you think that spec is hard to generate rate. 就像你认为规范很难产生速率一样。

发言人 2 01：18：01 Yeah，or just like for a given spec，maybe you can. I think there is a question of like，can you actually do the formal verification，like

that's like，is that possible? I think that there's like more to dig into there. Butthen also. 是的，或者就像给定的规格一样，也许你可以。我认为有一个问

题，你真的可以进行形式验证吗？就像这样，这可能吗？我觉得还有更多可以

挖掘的地方。但接下来也是。

发言人 3 01：18：15 even if you have this. 即使你有这个。

发言人 401：18：17 if you have. 如果你有。

发言人 2 01：18：18 how do you even you have this? Is this in a natural. 你怎么会有这个？这是自然的。

发言人 4 01：18：20 language how no. 语言如何不。发言人 3 01：18：22 the spec spec would be formal. 规格将是正式的。

发言人 2 01：18：24 but how easy that be too? Then I think that you care about things that are not going to be easily well specified in the spec language. I see，I see. Would be，yeah，maybe an argument against formal verification is all you need? Yeah，the，but there's this massive replacing，replacing

something like unit test? 但这也有多容易？那么我认为你关心的是那些在规范语言中不容易明确指定的东西。我明白了，我明白了。也许你只需要反对形式

验证的论点？是的，但是有这种巨大的替换，替换像单元测试这样的东西？

发言人 3 01：18：40 Sure，yeah. Yeah，I think you can probably also evolve the spec languages，capture some of the things they don't really capture right now，but I don't know，I think it's very exciting . 当然，是的。是的，我认为你可能也可以发展规范语言，捕捉一些他们现在没有真正捕捉到的东西，但我不

知道，我认为这是非常令人兴奋的。

发言人 1 01：18：54 and you're speaking not just about like single functions,

you're speaking about entire code bases. 你说的不仅仅是单个函数，而是整个代码库。

发言人 3 01：19：00 I think entire codebase is harder，but that that is what I

would love to have and I think it should be possible. And because you can even there，there's like a lot of work recently where you can prove formally verify down to the hardware so like through the you formally verify the C

code，and then you formally verify through the GCC compiler is，and then

through the very log down to the hardware. And that's like incredibly big

system，but it actually works. And I think big code bases are sort of similar in that they're like multi-layered system and if you can decompose it and

formally verify each part，then I think it should be possible. I think thespecification problem is a real problem. 我认为整个代码库更难，但这正是我希望拥有的，我认为应该是可能的。因为你甚至可以在那里，最近有很多工作

可以证明正式验证到硬件，比如通过正式验证 C 代码，然后通过 GCC 编译器进

行正式验证，然后通过登录到硬件。这就像一个非常大的系统，但它实际上是

有效的。我认为大型代码库有点类似，因为它们就像多层系统，如果你可以分

解它并正式验证每个部分，那么我认为应该是可能的。我认为规格问题是一个

真正的问题。

发言人 4 01:19:38 But how do you handle side effects or how do you

handle， I guess， external dependencies like calling the Stripe APl? 但是你如何处理副作用或者我猜测你如何处理外部依赖项，比如调用 Stripe APl?

发言人 5 01:19:46 Maybe Stripe would write a spec for it. 也许 Stripe 会为它写一个规范。

发言人 4 01:19:48 but like you can＇t do this for everything， like can you do

this for everything you use， like how do you， how do you do it for if there＇s a language like maybe， maybe like people will use language models as

primitives in the program today， right? And there＇s like a dependence on it and like how， how do you now include that? 但是就像你不能对所有事情都这样做，就像你可以对你使用的所有事情都这样做，就像你怎么做，如果有一种

语言，可能会像人们现在在程序中使用语言模型作为原语，你怎么做呢？就像

对它的依赖一样，你现在如何包括它？

发言人 3 01:20:02 I think you might be able to prove prove that still. 我认为你可能还能证明这一点。

发言人 4 01:20:05 prove what about language models? 证明什么是语言模

型？ 发言人 3 01：20：07 I think if it feels possible that you could actually prove that a language model is aligned，for example，or like you can prove that it

actually gives the right answer，that's the dream. 我认为，如果你感觉有可能证明一个语言模型是一致的，或者你可以证明它确实给出了正确的答案，那就

是梦想。

发言人 1 01：20：21 Yeah，that is，I mean，that's yeah，if it's possible，that's your，I have a dream speech，if it's possible，that will certainly help with，you know,

making sure your code doesn't have bugs and making sure Al doesn't

destroy all of human civilization. So the full spectrum of Al safety to just bug finding. But so you said the models struggle with bug finding out what's thehope? 是的，我的意思是，如果可能的话，那是你的，我有一个梦想演讲，如

果可能的话，那肯定会有所帮助，你知道，确保你的代码没有 bug，并确保 Al

不会摧毁所有的人类文明。因此，从 AI 安全的全部范围到仅发现漏洞。但是你

说这些模型努力寻找错误，希望是什么？

发言人 5 01：20：43 You know，my hope initially is and I can let Michael

Michael chime in，but it was like there's，it should，you know，first help with the stupid bugs，like it should very，very quickly get the stupid bugs like off by one errors. Like sometimes you write something in a comment and do the other way. It's like very common. Like I do this，I write like less than in a comment and like I maybe write a greater than or something like that and the model is like，yeah，it looks sketchy. Like you，you're sure you won't want to do that，But eventually it should be able to catch 100 bucks to. 你知道，我最初的希望是，我可以让迈克尔·迈克尔插话，但就好像，你知道，它应该首

先帮助解决愚蠢的错误，就像它应该非常非常快地解决愚蠢的错误一样。有时

你在评论中写一些东西，然后用另一种方法。这很常见。就像我这样做，我写

得比评论少，就像我可能会写一个比那个更大的东西或类似的东西，模型就

像，是的，它看起来很粗略。就像你一样，你确定你不想这样做，但最终它应该能够获得 100 美元。

发言人 2 01：21：16 yeah. And I think that it's also important to note that this is having good bug finding models feels necessary to get to the highest

reaches of having Al do more and more programming for you where you're going to，you know，if the Al is building more and more of the system for

you need to not just generate，but also verify. And without that，some of the problems that we've talked about before with programming with these

models will just become untenable. So it's not just for humans like you write a bug，I write a bug，find the bug for me. But it's also being able to verify the Ai's code and check it is really important. 是的。我认为同样重要的是要注

意，拥有良好的错误发现模型是必要的，这样可以让 AI 为你做越来越多的编

程，你知道，如果 AI 正在构建越来越多的系统，你不仅需要生成，还需要验

证。如果没有这个，我们之前讨论过的使用这些模型编程的一些问题将变得站

不住脚。所以这不仅仅是为了像你这样的人写一个错误，我写一个错误，为我

找到这个错误。但它也能够验证 Ai 的代码并检查它非常重要。

发言人 3 01：21：52 Yeah，and then how do you actually do this? Like，we have had a lot of contentious dinner discussion and stuff，how do you actually

screen a bug model? But one very popular idea is，you know，it's kind of

potentially easier to introduce a bug than actually finding the bug. And so you can train a model to introduce bugs in existing code，and then you can train a reverse bug model then that I can findfind bugs using this synthetic data. So that's like one example. But yeah，there are lots of ideas for. 是的，那么你实际上是怎么做到的？比如，我们在晚宴上进行了很多有争议的讨论，

你实际上如何筛选一个 bug 模型？但有一个非常流行的想法是，你知道，引入

漏洞可能比实际发现漏洞更容易。因此，您可以训练模型以在现有代码中引入

错误，然后您可以训练反向错误模型，然后我可以使用此合成数据找到错误。

这就是一个例子。但是是的，有很多想法。发言人 2 01：22：21 how to you can also，you can also do a bunch of work，not

even at the model level of taking the biggest models and then maybe

giving them access to a lot of information that's not just the code，like it's kind of a hard problem to like stare at a file and be like，where's the bug? 如

何才能做到，你也可以做很多工作，甚至不在模型层面上获取最大的模型，然

后可能让他们访问许多信息，而不仅仅是代码，就像盯着文件看是一个困难的

问题，虫子在哪里？

发言人 2 01：22：35 And you know，that's hard for humans often，right? So often you have to run the code and being able to see things like traces and step through a debugger，there's another whole nother direction where it kind of tends toward that. And it could also be that there are kind of two different product form factors here. It could be that you have a really

specialty model that's quite fast，that's kind of running in the background and trying to spot bugs. And it might be that sometimes sort of，sort of

arvid's earlier example about，you know，some nefarious input box bug. It might be sometimes you want to like there's，you know，there's a bug. You're

not just like checking hypothesis free，you're like this is a problem. I really want to solve it and you zap that with tons and tons and tons of compute，and you're willing to put in $50 to solve that bug or something even more. 你知道，这对人类来说很难，对吧？因此，通常情况下，您必须运行代码并能

够看到跟踪和调试程序之类的内容，还有一个完全相反的方向，它有点倾向于

那个方向。也可能是这里有两种不同的产品形态因素。可能你有一个非常专业

的模型，它非常快，有点在后台运行并试图发现错误。有时可能是某种程度

上，有点像 arvid 之前关于一些邪恶的输入框错误的例子。有时你可能会喜欢

上，你知道，有一个 bug。你不仅仅是免费检查假设，你会觉得这是一个问

题。我真的很想解决它，你用大量的计算来解决它，你愿意投入 50 美元来解决

这个错误或者更多的东西。发言人 1 01：23：12 Have you thought about integrating money into this

whole thing? Like，I would pay probably a large amount of money for if you found a bug or even generated code that I really appreciated，like at a

moment a few days ago when I started using cursor where it generated. 你有没有想过把钱整合到这整个事情中？就像，如果你发现了一个错误，甚至生

成了我非常感激的代码，我可能会支付一大笔钱，就像几天前我开始使用

Cursor 来生成它一样。

发言人 1 01：23：28 Perfect，like perfect 3 functions for interacting with the

YouTube API to update captions and for localization，like different in

different languages. The API documentation is not very good and the code across，like if I googled it for a while，I couldn't find exactly. There's a lot of confusing information cursor generated perfectly，and I was like，I just said back，I read the code. I was like，this is correct. I tested it is correct. I was like，I want a tip on on a button that goes，there's 5 dollars one that's really good just to support the company and support what the its face is and the others that probably sends a strong signal like good job，right? So there's a much stronger signal than just accepting the code，right? You just actually send

like a strong good job that and for bug finding，obviously，like there's a lot of people，you know，that would pay a huge amount of money for a bug like a bug bug bounty thing，right? 完美的，就像完美的 3 个功能，用于与

YouTube API 交互以更新字幕和进行本地化，例如在不同的语言中有所不同。

API 文档不是很好，代码也很全面，就像我在谷歌上搜索了一段时间，找不到确

切的代码一样。有很多令人困惑的信息 Cursor 完美地生成，我就像，我只是

说，我读了代码。我当时想，这是正确的。我测试了它是正确的。我当时想，

我想在一个按钮上得到一个提示，5 美元的一个真的很好，只是为了支持公

司，支持它的脸和其他可能发出强烈信号的东西，比如好工作，对吧？所以有

一个比接受代码更强的信号，对吧？你实际上只是发送了一份强大的好工作，

并且为了发现漏洞，显然，就像有很多人一样，你知道，他们会为漏洞这样的漏洞支付巨额资金，对吧？

发言人 1 01：24：31 Is that you guys think about that. 你们考虑一下。

发言人 3 01：24：33 Yeah，it's a controversial idea inside the company. I think it

sort of depends on how much，you believe in humanity home，you know，like，I think it would be really cool if like you spend nothing to try to find a bug and if it doesn't find a bug，you spend 0 dollars and then if it does find a bug and you click accept，then it also shows like in parentheses，like 1 dollar and you spend 1 dollar to accept the bug. And then of course there's

a worry like，okay，we spent a lot of computation，like maybe people will just

copy paste. I think that's a worry and then there is also the worry that like introducing money into the product makes it like kind of，you know，like it doesn't feel as fun anymore，Like you have to like think about money and you all you want to think about is like the code. And so maybe it actually makes more sense to separate it out and like you pay some fee like every month and then you get all of these things for free. 是的，这是公司内部一个

有争议的想法。我认为这有点取决于你相信人类家园的程度，你知道，就像，

我认为如果你不花一分钱去尝试找到一只虫子，如果它没有找到一个虫子，那

就真的很酷。你花了 0 美元，如果它确实发现了一个 bug，然后你点击接受，那

么它也会显示在括号中，比如 1 美元，你花了 1 美元接受这个 bug。然后当然会

有一个担心，好吧，我们花了很多计算，也许人们只会复制粘贴。我认为这是

一个担忧，还有一种担心，就是像将钱引入产品会让它感觉不再有趣了，就像

你必须喜欢考虑钱，而你想要考虑的只是代码。因此，也许将其分开实际上会

产生更多的感知，就像你每个月支付一些费用，然后你可以免费获得所有这些

东西。

发言人 1 01：25：29 But there could be a tipping component，which is not like

it. 但可能存在小费成分，这并不像它那样。发言人 3 01：25：32 Yes，it still has that like dollar symbol. I think it's fine，But I also see the point where like maybe you don't want to introduce it. 是的，它仍然像美元符号一样。我认为这很好，但我也看到了一点，也许你不想介绍

它。

发言人 4 01：25：40 Yeah，I was gonna say the moment that feels like people do this is when they share it when they have a fantastic example，they just kind of share it with their friends. 是的，我想说人们感觉这样做的那一刻是当他们有一个很棒的例子时分享它，他们只是与他们的朋友分享。

发言人 2 01：25：46 There is also a potential world where there's a technical solution to this，like on our system problem too，where if we can get to a

place where we understand the output of the system more，I mean，to the stuff we were talking about with like，you know，error tracking with the LSP and then also running the code. But if you could get to a place where you could actually somehow verify，oh，I have fixed the bug，maybe then the

bounty system，it doesn't need to rely on the on our system too. 还有一个潜在的世界，在这个世界里，有一个技术解决方案，就像在我们的系统问题上一

样，如果我们能够到达一个地方，更多地了解系统的输出，我的意思是，我们

谈论的东西，你知道的，使用 LSP 进行错误跟踪，然后同时运行代码。但是如

果你能到达一个地方，你可以以某种方式验证，哦，我已经修复了这个错误，

也许赏金系统也不需要依赖我们的系统。

发言人 1 01：26：09 How much interaction is there between the terminal and the code，like how much information is gained from you if you run the code in the terminal? Like can you use，can you do like a loop where it runs，runs the code and suggest how to change the code if the code and runtime

gives an error is right now they're separate worlds completely like I know you can do CR K inside the terminal to help you write the code. 终端和代码之间有多少交互作用，就像在终端中运行代码会从您那里获得多少信息一样？

像你可以使用吗，你可以像循环一样运行代码并建议如何更改代码，如果代码

和运行时出错，现在它们是完全独立的世界，就像我知道你可以在终端内做 CR

K 来帮助你编写代码。

发言人 4 01：26：35 you can use terminal context as well inside of check

Mank，kind of everything. We don't have the looping part yet though. We expect something like this could make a lot of sense. There's a question of whether it happens in the foreground too or if it happens in the background

like what we've been discussing. 您也可以在 check Mank 中使用终端上下文，几乎所有东西。但是，我们还没有循环部分。我们预计这样的事情可能会带来

很多感知。还有一个问题，它是发生在前台，还是发生在后台，就像我们一直

在讨论的那样。

发言人 1 01：26：52 sure the background is pretty cool like can we do running the code in different ways? Plus，there's a database side to this，which how do you protect it from not modifying the database? 确定背景很酷，就像我们

可以以不同的方式运行代码吗？另外，还有一个数据库方面，你如何保护它不

修改数据库？

发言人 501：27：02 But okay，I mean，there's，there's certainly cool solutions there，there's there's new API that it's being developed for，it's not in AWS，but you know，it's certainly I think it's in planet scale，I don't know if planet scale was the first one to add it，disability，sort of add branches to a

database widget，like if you're working on a feature and you want to test against a broad database，but you don't actually want to test against a

broad database，you could sort of add a branch to the database and the way they do that is to add a branch to the right，a head log. And there's

obviously a lot of technical complexity in doing it correctly. I guess database companies need new things to do. They have good databases now. And I

think Turbo Buffer，which is one of the databases we use，is going to add

maybe branching to the right，a log. And so，so maybe，maybe the Al agents will use will use branching like test against them branch. And it's sort of

going to be a requirement for the database，actually，like support branching or something. 但是好吧，我的意思是，那里肯定有很酷的解决方案，它正在开发新的 API，它不在 AWS 中，但你知道，我认为它在行星尺度上。我不知道

是否行星尺度是第一个添加它的，残疾，向数据库小部件添加分支，就像如果

你正在开发一个功能并且想要在广泛的数据库上进行测试，但实际上你并不想

在广泛的数据库上进行测试，你可以在数据库中添加一个分支，他们的方法是

在右边添加一个分支，头部日志。而且正确地做这件事显然有很多技术上的复

杂性。我想数据库公司需要新的东西去做。他们现在有很好的数据库。我认为

我们使用的数据库之一 Turbo Buffer 将在右侧添加分支日志。因此，也许，也许 A | 代理将使用像对其分支进行测试一样的分支。实际上，这将是数据库的一

项要求，就像支持分支之类的。

发言人 401：28：10 Be really interesting if you can branch a file system，right? 如果可以对文件系统进行分支，那将非常有趣，对吧？

发言人 301：28：13 Yeah. 是的。

发言人 5 01：28：14I feel like everything needs branching. It's like，yeah. 我觉得一切都需要分支。就像，是的。

发言人 1 01：28：17 like that's the problem with the multiverse. 这就是多元宇宙的问题。

发言人 301：28：19right? 对吗？

发言人 1 01：28：22 Like if you branch out everything，that's like a lot. 就像如果你把所有的东西都扩展，那就很多了。

发言人 501：28：24I mean，there's，there's obviously these like super clever

algorithms to make sure that you don't actually just use a lot of space or

CPU,whatever. 我的意思是，显然有这些超级聪明的算法来确保你实际上不会只使用大量空间或 CPU。

发言人 1 01：28：32 okay? This is a good place to ask about infrastructure. So you guys mostly use AWS，what are some interesting details? What are

some interesting challenges? Why did you choose AWS? Why，why is AWSstill winning? 好吗？这是一个询问基础设施的好地方。所以你们大多使用

AWS，有什么有趣的细节吗？有哪些有趣的挑战？你为什么选择 AWS? 为什

么，为什么 AWS 仍然获胜？

发言人 3 01：28：44 Hashtag AWS is just really，really good，is really good，Like whenever you use an AWS product，you just know that it's going to work,

like it might be absolute L to go through the steps to set it up. Hashtag AWS 真的非常好，真的很好，就像每当你使用 AWS 产品时，你就知道它会起作用，

就像它可能绝对是我去设置它的步骤。

发言人 1 01：29：02 why is the interface so horrible? 为什么界面这么可怕？

发言人 3 01：29：04 Because it，it's just so good. It doesn't need the nature ofwinning. 因为它太棒了。它不需要胜利的本质。

发言人 5 01：29：08 I think it's exactly，it's just nature. They're winning，yeah.

Yeah. 我认为这就是自然规律。他们赢了，是的。是的。

发言人 3 01：29：12 but AWS，we can always trust like it wil always work and if there is a problem，it's probably your problem. Yeah. 但是 AWS，我们可以始终相信它会一直有效，如果有问题，那可能是你的问题。是的。

发言人 1 01：29：20 okay，is there some interesting like challenges to you guys

are pretty new startup to get scaling to like to so many people? 好的，有没

有一些有趣的挑战，比如你们这些相当新的初创公司要获得扩展以适应这么多

人？

发言人 2 01：29：28 And yeah，I think that they're，it has been an interesting

journey adding，you know，each extra 0 to the request per second. You run

into all of these with the general components you're using for caching and

databases run into issues as you make things bigger and bigger. And now

we're at the scale where we get into overflows on our tables and things like

that. And then also，there have been some custom systems that we've built,

like，for instance，our retrieval system for computing a semantic index of your code base and answering questions about a codeba that have

continually，I feel like，been，well，one of the trickier things to scale. 是的，我

认为他们是，这是一个有趣的旅程，你知道，每秒为请求增加每个额外的 0。

你会在使用用于缓存的常规组件时遇到所有这些问题，并且在使事情变得越来

越大时，数据库也会遇到问题。现在我们已经达到了这样的规模，我们的桌子

和类似的东西溢出了。此外，我们已经建立了一些自定义系统，例如，我们的

检索系统，用于计算代码库的语义索引并回答有关代码库的问题，我觉得这些

系统一直是扩展时比较棘手的事情之一。

发言人 5 01：30：04 I have a few friends who who are super，super senior engineers and one of their sort of lines，it's like，it's very hard to predict where systems will break whenwhen you scale them you can sort of try to

predict in advance like's there's always something，something weird that's

going to happen when you add this exercise. You thought you thought through everything，but you didn't actually think through everything. But I think for that particular system，we've so for concrete details，the thing we do is obviously we upload when like we chunk up all of your code and then we send out sort of the code for embedding，and we embed the code，and then we store the embeddings in a database，but we don't actually store any of the code. And then there's reasons around making sure that we don't introduce client bugs because we're very，very paranoid about client bugs. 我有几个朋友，他们是超级高级工程师，他们的一种类型是，就像，当你扩展

它们时，很难预测系统会在哪里崩溃，你可以提前尝试预测，就像总有一些东

西一样。当你添加这个练习时，会发生一些奇怪的事情。你以为你已经把一切

都想过了，但实际上你并没有把一切都想过。但我认为对于那个特定的系统，

我们需要具体的细节，我们做的事情显然是我们上传时，就像我们把所有的代

码分块起来，然后我们发送一些嵌入的代码，我们嵌入代码，然后我们把嵌入

的代码存储在一个数据库中。但我们实际上并不存储任何代码。然后还有一些

原因，确保我们不会引入客户端错误，因为我们对客户端错误非常偏执。

发言人 5 01：30：59 We store much of the details on the server，like everything is sort of encrypted. So one of the technical challenges is always making sure that the local index，the local code base state it's the same as the state that is on the server. And the way sort of technically we ended up doing that is so for every single file you can，you can sort of keep this hash. And then for every folder，you can sort of keep a hash，which is sort of the hash of all of its children. And you can sort of recursively do that until the top. And

why? Why do something，something complicated? 我们将很多细节存储在服务器上，就像所有东西都是加密的一样。因此，技术挑战之一始终是确保本地

索引，本地代码库状态与服务器上的状态相同。从技术上讲，我们最终这样做

的方式是，对于每个文件，你可以保留这个哈希。然后对于每个文件夹，您可

以保留一个哈希，这是其所有子文件夹的哈希。你可以递归地做到这一点，直

到顶部。为什么？为什么要做一些复杂的事情？ 发言人 5 01：31：37 One thing you could do is you could keep a hash for

every file and every minute. You could try to download the hashes that are on the server，figure out what are the files that don't exist on the server.

Maybe you just created a new file，maybe you just deleted a file，so maybe you checked out a new branch and try to reconcile the state between the

client and the server. But that introduces like absolutely ginormous network overhead，both，both on the client side. I mean，nobody really wants us to hammer their wives all the time. 你可以做的一件事是为每个文件和每分钟保留一个哈希值。你可以尝试下载服务器上的哈希，找出服务器上不存在的文件

是什么。也许你刚刚创建了一个新文件，也许你刚刚删除了一个文件，所以也

许你签出了一个新分支，并尝试协调客户端和服务器之间的状态。但这在客户

端引入了绝对巨大的网络开销。我的意思是，没有人真的希望我们一直用锤子

敲打他们的妻子。

发言人 5 01：32：07 If you're using cursor，but also like，I mean，it would

introduce like ginormous overhead in the database，It would sort of be

reading this，tens terabyte database sort of approaching like 20 TB or

something database like every second. That's just just sort of kind of crazy. You definitely don't want to do that. So what you do，you sort of，you just try to reconcile the single hash，which is at the root of the project and then if，if something mismatches，then you go，you find where all the things disagree. Maybe you look at the children and see if the hashes match. And if the

hashes don't match，go look at their children. We only do that in this

scenario where things don't match. And for most people，most of the time，the Hass match. 如果您使用 Cursor，但我的意思是，它会在数据库中引入巨大的开销，它可能会读取这个，几十 TB 的数据库每秒接近 20TB 左右。这只是有

点疯狂。你绝对不想这么做。所以你所做的，你只是尝试调和单个哈希，这是

项目的根源，如果有不匹配的地方，你就会发现所有的事情都不一致。也许你

看看孩子，看看哈希是否匹配。如果哈希不匹配，去看看他们的孩子。我们只在事情不匹配的情况下才这样做。对于大多数人来说，大多数时候，这是火

柴。

发言人 1 01：32：49 So it's a kind of like hierarchical reconciliation. 所以这是一种类似于等级和解的方式。

发言人 501：32：53 Yeah，something. 是的，一些东西。

发言人 4 01：32：54 something like that. Yeah. 类似的东西。是的。

发言人 1 01：32：55 it's called the Merkel tree. Yeah，Merkel，yeah，I mean，so，yeah，it's cool to see that you kind of have to think through all these

problems. 它叫做梅克尔树。是的，默克尔，是的，我的意思是，所以，是

的，看到你必须思考所有这些问题是很酷的。

发言人 5 01：33：01 and I mean，the point of like the reason it's gone hard is just because like the number of people using it，if some of your customers have really，really large code bases to the point where，you know，we

originally re jar code base，which is，which is big，but I mean，it's just not the size of some company that's been there for 20 years and sort of has a

ginormous number of files and you sort of want to scale that across

programmers there's all these details where like building a simple thing is easy，but scaling it to a lot of people like a lot of companies is is obviously a difficult problem，which is sort of，you know，independent of actually so that there's part of the scaling our current solution is also，you know，coming up with new ideas，obviously we're working on，but then，but then scaling all of that in the last few weeks，months，yeah. 我的意思是，像它变得困难的原因只是因为像使用它的人数一样，如果你的一些客户有非常非常大的代码库，以至

于我们最初是重新创建 jar 代码库，这是一个大的，但我的意思是，这并不是一

个已经存在 20 年的公司的规模，它有大量的文件，你想要在程序员之间扩展所有这些细节，比如构建一个简单的东西很容易，但是像很多公司一样将其扩展

到很多人显然是一个难题，这有点独立于实际上，所以我们当前解决方案的一

部分就是提出新的想法，显然我们正在努力。但是，然后在过去的几周，几个

月里，扩大了所有这些。

发言人 4 01：33：48 and there are a lot of clever things like additional things that that go into this indexing system，for example，the bottleneck in terms of costs，it's not storing things in the vector database or the database，it's actually embedding the code and you don't want to re embed the code for every single person in a company that is using the same exact code. Except for maybe they're in a different branch with a few different files or they've made a few local changes and so because again，embeddings with the

bottleneck you can do is one clever trick and not have to worry about like the complexity of like dealing with branches and the other databases where you just have some cache on the actual vector is computed from the hash of a given chunk. And so this means that when the nth person at a company goes and embeds their code base，it's really，really fast. And you do all this without actually storing any code on our servers at all no code data stored，we just store the vector is in the vector database. The vector cache. 而且有很多聪明的东西，比如这个索引系统中的其他东西，例如成本瓶颈，它不是将东

西存储在矢量数据库或数据库中，它实际上是嵌入代码，你不想为使用完全相

同代码的公司中的每个人重新嵌入代码。除了可能他们在不同的分支中，有几

个不同的文件，或者他们进行了一些本地更改，因为，嵌入瓶颈是一个聪明的

技巧，不必担心像处理分支和其他数据库一样的复杂性，在那里你只需要在实

际向量上有一些缓存，这些向量是从给定块的哈希计算得出的。这意味着当公

司的第 n 个人去嵌入他们的代码库时，速度非常非常快。你做这一切都没有实

际在我们的服务器上存储任何代码，根本没有存储任何代码数据，我们只是将

向量存储在向量数据库中。向量缓存。发言人 1 01：34：45 what's the biggest gains at this time you get from

indexing the code base? Just out of curiosity，like whatwhat benefit users have? It seems like longer term there'll be more and more benefit，but in the

short term，just asking questions of the code base，what what's the use，what's the usefulness of that? 目前您从索引代码库中获得的最大收益是什么？只是出于好奇，比如用户有什么好处？似乎从长远来看，会有越来越多的好

处，但在短期内，只是询问代码库的问题，它有什么用途，有什么用处？

发言人 3 01：35：06 I think the most obvious one is just you want to find out where something is happening in your large code base，and you sort of have a fuzzy memory of，okay，I want to find the place where we do X，but you don't exactly know what to search for in a normal text search. And so you ask a chat，you hit command enter to ask with with the could be chat. And then very often it finds the right place that you were thinking of. 我认为

最明显的一个就是你想找出你的大型代码库中正在发生的事情，而你有一种模

糊的记忆，好吧，我想找到我们做 X 的地方，但是你不知道在普通文本搜索中

要搜索什么。所以你问一个聊天，你点击回车命令来问，可能是聊天。然后它

往往会找到你想的正确地方。

发言人 4 01：35：32 I think like you，like you mentioned in the future，I think this is only going to get more and more powerful where we're working a lot

on improving the quality of our retrieval. And I think the ceiling for that is really，really much higher than people give it credit for. 我跟你一样认为，就

像你提到的，在未来，我认为这只会变得越来越强大，我们正在努力提高检索

的质量。我认为这个上限比人们认为的要高得多。

发言人 1 01：35：46 One question that's good to ask here，have you

considered and why haven't you much done sort of local stuff to where you

can do that? I mean，it seems like everything was just discussed is exceptionally difficult to do，to go，to go to the cloud. You have to think

about all these things，the caching and the. You know，large code，basically a large number of programmers are using the same code base. You have to figure out the puzzle of that. A lot of it，you know，most software just does

stuff，this heavy computational stuff locally. So if you consider doing sort ofembeddings locally. 这里有一个很好的问题，你考虑过了吗？为什么没有做一些当地的事情来做到这一点？我的意思是，似乎刚刚讨论的所有事情都非常难

以做到，难以进入云端。你必须考虑所有这些事情，缓存和。你知道，大代码

基本上是大量程序员使用相同的代码库。你必须弄清楚其中的谜题。很多软件

只是在本地做一些繁重的计算工作。因此，如果您考虑在本地进行嵌入。

发言人 3 01：36： 18 yeah，we thought about it，and I think it would be cool to do it locally. I think it's just really hard. And one thing to keep in mind is that，you know，some of our users use the latest MacBook Pro，but most of our

users like more than 80% of our users are in Windows machines，which and many of them are not very powerful. And so local models really only works on on the latest computers and it's also a big overhead to build that in. And so even if we would like to do that，it's currently not something that we are able to focus on. And I think there，there are some people that that that do that，and I think that's great，but especially as models get bigger and bigger and you want to do fancier things with like bigger models，it becomes even harder to do it locally. 是的，我们考虑过，我认为在本地做这件事会很酷。我觉得这真的很难。需要记住的一件事是，你知道，我们的一些用户使用的是最

新的 MacBook Pro，但我们的大多数用户（比如超过 80% 的用户）都在

Windows 机器上，而这些机器很多都不是很强大。因此，本地模型实际上只适

用于最新的计算机，并且构建它也是一个很大的开销。因此，即使我们想这样

做，这也不是我们目前能够专注的事情。我认为有一些人会这样做，我认为这

很棒，但特别是随着模型越来越大，你想用更大的模型做更华丽的事情，在本

地做到这一点变得更加困难。发言人 5 01：37：07 Yeah，and it's not a problem with like weaker computers. It's just that，for example，if you're some big company，you have big

company code base，it's just really hard to process big company code base even on the beefies the MacBook Pros. So even if it's not even a matter of like if you're，if you're just like a student or something，I think if you're like

the best programmer at a big company，you're still going to have a horrible experience. And if you do everything locally where you could，you could do edge and sort of scrape by，but like，again，it wouldn't be fun anymore. 是的，对于较弱的计算机来说，这不是问题。只是，例如，如果你是一家大公

司，你有一家大公司的代码库，即使在 MacBook 专业人士的平台上处理大公司

的代码库也非常困难。因此，即使这甚至不是一个问题，如果你只是一个学生

或其他什么，我认为如果你是一家大公司最好的程序员，你仍然会经历一段可

怕的经历。如果你在当地尽可能做所有事情，你可以做边缘和刮擦，但同样，

这不再有趣了。

发言人 401：37：40 Yeah，like an approximate nearest neighbors and this

massive code base，it's gon na，just eat up your memory and your CPU and that and that's，and that's just that like let's talk about like also the modeling side where，as Robert said，there are these massive headwinds against local models where one things that seem to move towards Moes，which like one benefit is maybe there are more memory bandwidth bound which plays in favor of local versus using Gpu's or using Nvidia Gpu's. The downside is

these models are just bigger in total and you know，they're going to need to fit often not even on a single node of multiple nodes，there's no way that's going to fit inside of even really good MacBooks. And I think especially for coding，it's not a question as much of like，does it clear some bar of like the models good enough to do these things and then like we're satisfied，which may be the case for other other problems and maybe where local models shine，but people are always going to want the best the most intelligent，the most capable things. And that＇s going to be really， really hard to run for

almost all people locally. 是的，就像一个近似最近的邻居和这个巨大的代码库，它是 gon na，只需要消耗你的内存和 CPU 等等，这就是让我们来谈谈建模

方面，正如 Robert 所说，本地模型面临着巨大的阻力，其中有一件事情似乎朝

着 Moes 发展，这有一个好处，可能有更多的内存带宽限制，这有利于使用本地

而不是使用 Gpu 或使用英伟达 Gpu。缺点是这些型号总体上更大，而且你知

道，它们通常甚至需要适合多个节点的单个节点，即使是真正优秀的 macbook

也无法适合。我认为特别是对于编码来说，这不是一个问题，它是否清除了一

些足够好的模型来做这些事情，然后我们就满意了，这可能是其他问题的情

况，也许本地模型在哪里闪耀，但人们总是想要最好、最聪明、最有能力的东

西。这对当地几乎所有人来说都将是非常非常困难的。

发言人 5 01:38:50 Don＇t you want the most capable model like you want you

want sonne you and also with. 难道你不想要最有能力的模特吗？就像你想要的那样。

发言人 401:38:56oh. 哦。

发言人 1 01:38:58 I like how you＇re pitching me. 我喜欢你向我推销的方式。发言人 2 01:39:00 would you be satisfied. 你会满意吗？

发言人 1 01:39:01 with an inferior model? Listen I＇m yes I＇m one of those， but

there＇s some people that like to do stuff locally， especially like， yeah， really there＇s a whole obviously open source movement that kind of resists and it＇s

good that they exist actually because you want to resist The power centers that are growing are . 劣质模型？听着，我是是的，我是其中之一，但有些人喜欢在当地做一些事情，特别是像，是的，真的有一个整体显然是开源运动，

这种抵抗，而且它们的存在是很好的，因为你想抵抗正在增长的权力中心。发言人 3 01：39：20 there's actually an alternative to local models that I am particularly fond of. I think it's still very much in the research stage，but you could imagine to do homomorphic encryption for language model

inference. So you encrypt your input on your local machine，then you send that up，and then the server can use laws of computation. They can run

models that you can not run locally on this encrypted data，but they can not see what the data is，and then they send back the answer and you decrypt the answer，and only you can see the answer. So I think that's still very much research. And all of it is about trying to make the overhead lower,because right now the overhead is really big. But if you can make that happen，I think that would be really，really cool，and I think it would be really，really

impactful，because I think one thing that's actually kind of worrisome is that as these models get better and better，they're going to become more and more economically useful. 实际上，我特别喜欢本地模型的替代方案。我认为它仍然处于研究阶段，但你可以想象为语言模型推理进行同态加密。所以你在

本地机器上加密你的输入，然后你发送它，然后服务器就可以使用计算法则

了。他们可以运行你无法在本地运行的模型，但他们看不到数据是什么，然后

他们发回答案，你解密答案，只有你能看到答案。所以我认为这仍然是非常多

的研究。所有这一切都是为了降低开销，因为现在的开销真的很大。但如果你

能做到这一点，我认为那将会非常非常酷，而且我认为这将非常非常有影响

力，因为我认为一件令人担忧的事情是，随着这些模型变得越来越好，它们将

变得越来越经济上有用。

发言人 3 01：40：17 And so more and more of the world's information and data will flow through，you know，1 or two centralized actors. And then there are worries about，you know，there can be traditional hacker attempts，but it also creates this kind of scary part where if all of the world's information is flowing through one node in plain text，you can have survey lines in very bad ways. Sometimes that will happen for，you know，initially will be like good reasons，like people will want to try to protect，protect against like bad actors using Al models in bad ways，And then you will add in some

surveillance code and then someone else will come in and you know，you're in a slippery slope and then you start doing bad things with a lot of the

world's data. I'm very hopeful that we can solve homomorphic encryption

for language. 因此，世界上越来越多的信息和数据将通过一个或两个中央行动者流动。然后还有担心，你知道，可能会有传统的黑客尝试，但它也创造了

这种可怕的部分，如果世界上所有的信息都以纯文本形式流过一个节点，你可

能会以非常糟糕的方式产生调查线。有时候会发生这种情况，你知道，最初会

是很好的理由，就像人们想要尝试保护，防止像坏人一样以不良的方式使用 AI

模型，然后你会添加一些监视代码，然后其他人会进来，你知道，你在一个滑

坡中，然后你开始用世界上很多数据做坏事。我非常希望我们能够解决语言的

同态加密问题。

发言人 1 01：41：12 modeling and privacy preserving machine learning，but l would say that that's the challenge we have with all software these days is

like there's so many features that can be provided from the cloud，and all

this increasingly rely on it and make our life awesome. But there's

downsides，and that's why you rely on really good security to protect from

basic attacks. But there's also only a small set of companies that are

controlling that data，you know，and they obviously have leverage and they could be infiltrated in all kinds of ways. That's the world we live in. 建模和隐私保护机器学习，但我想说的是，现在我们所有软件面临的挑战是云可以提供

如此多的功能，而所有这些都越来越依赖它，使我们的生活更加美好。但也有

缺点，这就是为什么你依赖真正良好的安全性来保护自己免受基本攻击的原

因。但也只有少数公司控制着这些数据，你知道，他们显然有影响力，可以以

各种方式渗透。这就是我们生活的世界。

发言人 5 01：41：43 Yeah，I mean，the thing I'm just actually quite worried about is sort of the world where，I mean Anthropic has this responsible

scaling policy. And so we，we're on like the low，low asls，which is the

Anthropic security level or whatever，of like of the models，but as we get you like cocoe ASL 3 ASL 4，whatever models，which are sort of very powerful，but for mostly reasonable security reasons，you would want to monitor all the prompts. But I think that's thats sort of reasonable and understandable where everyone is coming from. Matt，it'd be really horrible ifif sort of like all the world's information is sort of monitor that heavily. It's way too

centralized. It's like，it's like sort of this，it's like really fine line you're walking where on the one side，like you don't want the models to go rogue，on the other side，like humans like I don't know if，if I trust like all the world's

information to pass through like 3. 是的，我的意思是，我实际上非常担心的事情是，在这个世界上，我是说，人类学有这种负责任的扩展政策。所以我们

就像那些低的、低的 asls 一样，这是人类安全级别或其他类似模型的东西，但

是当我们得到像 cocooe ASL3ASL4 这样的模型时，它们非常强大，但主要是

出于合理的安全原因，你会想要监控所有提示。但我认为每个人都来自哪里，

这是合理和可以理解的。马特，如果世界上所有的信息都被如此严密地监控，

那就太可怕了。这太集中了。就像，有点像这样，就像你走在一边的非常细

线，就像你不希望模型流氓一样，在另一边，就像人类一样，我不知道，如果

我相信世界上所有的信息都像 3 一样传递。

发言人 101：42：43 3 model providers. 3 个模型提供商。

发言人 4 01：42：44 why do you think it's different than cloud providers? 为什么你认为它与云提供商不同？

发言人 3 01：42：47 Because I think. This is a lot of this data would never have gone to the cloud providers in the first place，where this is often like you

want to give more data to the eio models. You want to give personal data that you would never have put online in the first place to these companies or to these models. And it also centralizes control where right now for

cloud，you can often use your own encryption keys and like it just can't really

do much. But here is just centralized actors that see the exact plain text ofeverything. 因为我认为。这是很多数据一开始就不会流向云提供商，这通常

就像你想向 eio 模型提供更多数据一样。你想把你本来不会放在网上的个人数据

提供给这些公司或模型。而且它还集中控制了现在的云，你可以经常使用自己

的加密密钥，但它真的不能做太多。但这里只是中心化的参与者，可以看到所

有内容的精确纯文本。

发言人 1 01：43：32 on the top of a context that that's actually been a friction for me when I'm writing code，You know，in Python，there's a bunch of stuff imported. There's a，you could probably intuit the kind of stuff I would like to include in the context. Is there like how，how hard is it to auto figure outthe context? 在一个上下文中，当我在用 Python 编写代码时，这实际上对我来

说是一个摩擦，你知道，有一堆东西被导入了。有一个，你可能可以直觉地知

道我想在上下文中包含什么样的东西。自动理解上下文有多难？

发言人 2 01：43：51 It's tricky，I think we can do a lot better at computing the context automatically in the future. One thing that's important to note is there are trade offs with including automatic context. So the more context you include for these models，first of all，the slower they are and the more expensive those requests are，which means you can then do less model calls and do less fancy stuff in the background. Also，for a lot of these

models，they get confused if you have a lot of information on the prompt. So the bar for accuracy and for relevance of the context you include should

be quite high. But this is already we do some automatic context in some places within the product. It's definitely something we want to get a lot

better at，and I think that there are a lot of cool ideas to try there. Both on the learning better retrieval systems， like better embedding models， betterre Rankin thinkers. 这很棘手，我认为我们将来可以在自动计算上下文方面做得更好。需要注意的一件事是，在包含自动上下文方面存在权衡。因此，您为

这些模型包含的上下文越多，首先，它们的速度就越慢，这些请求就越昂贵，

这意味着您可以减少模型调用，并在后台执行更少的花哨操作。此外，对于很

多这些模型，如果你在提示上有很多信息，他们会感到困惑。因此，您所包含

的上下文的准确性和相关性的门槛应该很高。但这已经是我们在产品内的某些

地方进行了一些自动上下文操作。这绝对是我们想要做得更好的事情，我认为

有很多很酷的想法可以尝试。两者都在学习更好的检索系统，比如更好的嵌入

模型，更好的重新思考思维者。

发言人 201:44:48 I think that there are also cool academic ideas， you know， stuff we＇ve tried out internally， but also the field is grappling with writ large about can you get language models to a place where you can actually just have the model itself， like understand a new corpus of information And the most popular talked about version of this is， can you make the context

windows infinite? Then if you make the context when there＇s infinite， can

you make the model actually pay attention to the infinite context and then after you can make it pay attention to the infinite context to make it

somewhat feasible to actually do it， can you then do caching for that infinite context? So you don＇t have to recompute that all the time? But there are

other cool ideas that are being tried that are a little bit more analogous to

fine tuning of actually learning this information in the weights of the model and it might be that you actually get sort of a qualitatively different type of understanding if you do it more at the weight level than if you do it at the in context learning level. I think the journey， the journey is still a little bit out on how this is all going to work in the end， but in the interim us， us as a

company， we are really excited about better retrieval systems picking the

parts of the code base that are most relevant to what you＇re doing. 我认为也有很酷的学术思想，你知道，我们在内部尝试过的东西，但这个领域也在努力

应对能否将语言模型变成一个你实际上可以拥有模型本身的地方。就像理解一

个新的信息语料库一样，最受欢迎的讨论版本是，你能将上下文窗口设置为无

限吗？那么如果你在无限的情况下创建上下文，你能让模型真正关注无限的上

下文，然后在你能让它关注无限的上下文以使实际操作在一定程度上可行之

后，你能对无限的上下文进行缓存吗？所以你不需要一直重新计算吗？但是还

有其他一些很酷的想法正在尝试中，这些想法更类似于在模型的权重中实际学

习这些信息的微调如果你在体重级别上做的比在情境学习中做的更多，你实际

上可能会得到一种质的不同类型的理解水平。我认为这个旅程，这个旅程仍然

有点超出了这一切最终将如何运作的范围，但在过渡期间，我们作为一家公

司，我们对更好的检索系统感到非常兴奋，可以挑选与您正在做的事情最相关

的代码库部分。

发言人 4 01:45:51 We could do that a lot better. Like one interesting proof of concept for the learning this knowledge directly in the weights is with Vs code. So we＇re in a Vs code fork and Vs code， the code is all public， so these models in pre training have seen all the code， they＇ve probably also seen questions and answers about it， and then they＇ve been fine tuned in RA chef to be able to be able to answer questions about code in general. So when you ask it a question about the S code， you know， sometimes it＇ll

hallucinate， but sometimes it actually does a pretty good job at answering the question and I think like this is just by it happens， be okay， But what if you could actually like specifically train or post train a model such that it

really was built to understand this code base? It＇s an open research

question， one that we＇re quite interested in， and then there＇s also

uncertainty of like， do you want the model to be the thing that end to end is doing everything? That is， it＇s doing the retrieval and its internals， and then kind of answering the question， creating the code? Or do you want to

separate the retrieval from the frontier model where maybe， you know， you'll get some really capable models that are much better than like the best open source ones in a handful of months，and then you'll want to

separately train a really good open source model to be the retriever，to be the thing that feeds in the context to these larger models? 我们可以做得更好。就像一个有趣的概念证明一样，直接在权重中学习这些知识是使用

Cursor。所以我们处于一个 Cursor 的分叉和 Cursor 中，代码是全部公开的，所以预训练中的这些模型已经看到了所有代码，他们可能也看到了关于它的问题

和答案。然后他们在 RA 厨师方面进行了微调，以便能够回答有关代码的一般问

题。所以当你问它关于 S 代码的问题时，你知道，有时它会产生幻觉，但有时

它实际上在回答问题方面做得很好，我认为这只是因为它发生了，没关系，但

是，如果你真的可以特别喜欢训练或后训练一个模型，使得它真的是为了理解

这个代码库而构建的呢？这是一个开放的研究问题，一个我们非常感兴趣的问

题，然后还有不确定性，比如，你希望这个模型成为一个端到端都在做的事情

吗？也就是说，它正在进行检索及其内部结构，然后回答问题，创建代码？或

者你想将检索与前沿模型分开，也许你会在几个月内得到一些真正有能力的模

型，比最好的开源模型好得多，然后你会想要单独训练一个非常好的开源模型

来作为检索器，成为在这些更大模型中提供信息的事物？

发言人 1 01：47：14 Can you just speak a little more to the post training a

model to understand the code base? Like what do you mean by that with，is it a synthetic data direction is this? 你能在训练模型后再多说一点来理解代码库吗？你所说的是什么意思，这是一个合成数据的方向吗？

发言人 4 01：47：23 Yeah，I mean there are many possible ways you could try doing it. Certainly no shortage of ideas. It's just a question of going in and like trying all of them and being empirical about which one works best. You know，1，one very naive thing is to try to replicate what's with the code and these frontier models，what's like continued pre training，some kind of

continued pre training that includes general code data，but also throws in a lot of the data of some particular repository that you care about. And then in post training，meaning in let's just start with instruction，fine tuning，you have like a normal instruction，fine Tu data set about code，but you throw in a lot of questions about code in that repository. So you could either get ground truth ones，which might be difficult，or you could do what you kind of hinted at or suggested using synthetic data，ie kind of having the model ask questions about various pieces of the code. So you kind of take the

pieces of the code，then prompt the model，or have a model propose a question for that piece of code，and then add those as instruction finds unit data points. And then in theory，this might unlock the model's ability to

answer questions about that code base. 是的，我的意思是有很多可能的方法

可以尝试做到这一点。当然不缺乏想法。这只是一个尝试所有方法并对哪一个

方法最有效的经验主义问题。你知道，一件非常天真的事情是试图复制代码和

这些前沿模型的内容，这就像是持续的预训练，某种包括通用代码数据的持续

预训练。但也会输入您关心的某个特定存储库的大量数据。然后在培训后，意

思是让我们从指导开始，微调，你就像一个普通的指令，关于代码的精细数据

集，但是你在那个存储库中抛出了很多关于代码的问题。因此，您可以获取地

面真实数据，这可能很困难，或者您可以使用合成数据进行您所暗示或建议的

操作，即让模型询问有关各种代码的问题。因此，您可以获取代码段，然后提

示模型，或者让模型为该代码段提出问题，然后将这些问题添加为指令查找单

位数据点。理论上，这可能会解锁模型回答有关代码库问题的能力。

发言人 1 01：48：39 Let me ask you about OpenAl 0 1. What do you think is the role of that kind of test time compute system in programming? 让我问你

关于 OpenAl01 的问题。你认为这种测试时间计算系统在编程中的作用是什

么？

发言人 4 01：48：47 I think test time compute is really，really interesting. So there's been the prey trainin in regime，which will kind of，as you scale up the amount of data and the size of your model，get you better and better

performance，both on loss and then on downstream benchmarks and just

general performance when you use it for coding or other tasks. We're

starting to hit a bit of a data wall，meaning it's going to be hard to continue scaling up this regime. And so scaling up 10 test time compute is an

interesting way of now，you know，increasing the number of inferences，time flops that we use，but still getting like，like，yeah，as you increase the number of flops，use inference time，getting corresponding improvements in the

performance of these models. 我认为测试时间计算真的非常有趣。因此，在系统中已经有了猎物训练，随着你扩大数据的数量和模型的大小，你会得到越

来越好的性能，无论是在损失方面，还是在下游基准测试方面，以及当你使用

它进行编码或其他任务时的一般性能。我们开始碰到一些数据墙，这意味着继

续扩大这个政权将很困难。因此扩大 10 个测试时间计算是一种有趣的方式，你

知道，现在增加我们使用的推断和时间触发器的数量，但仍然会像这样，是

的，随着你增加触发器的数量，使用推断时间，在这些模型的性能上获得相应

的改进。

发言人 4 01：49：33 Traditionally，we just had to literally train a bigger model that always uses that，always used that many more flops. But now we could perhaps use the same size model and run it for longer to be able to get an answer at the quality of a much larger model. And so the really interesting

thing I like about this is there are some problems that perhaps require 100 trillion parameter model intelligence trained on 100 trillion tokens. But

that's like maybe 1%，maybe like point 1% of all queries. So are you going to spend all of this effort，all this compute training，a model that costs that

much and then run it so infrequently it feels completely wasteful when

instead you get the model that can，that is，that you train the model that is

capable of doing the 99.9% of queries，and then you have a way of

inference time running it longer for those few people that really，really wantmax intelligence. 传统上，我们只需要训练一个更大的模型，这个模型总是使用那个，总是使用更多的失败。但是现在我们或许可以使用相同大小的模型，

并运行更长时间，以便能够以更大模型的质量得到答案。因此，我喜欢的真正

有趣的事情是，有些问题可能需要在 100 万亿代币上训练 100 万亿参数模型智

能。但这可能是所有查询的 1％，可能是 1％。那么，你是否要花费所有这些努

力，所有这些计算训练，一个成本如此之高的模型，然后很少运行它，当你得

到一个可以的模型时，你会感到完全浪费，也就是说，你训练一个能够执行

99.9％查询的模型，然后，对于那些真正想要最大智能的少数人来说，你有一

种推断时间更长的方式。

发言人 1 01:50:27 How do you figure out which problem requires what level of intelligence? Is that possible to dynamically figure out when to use GPT- 4， when to use like when you use a small model and when you need the 0，1? 你如何弄清楚哪个问题需要什么水平的智力？是否可以动态地确定何时使用

GPT-4，何时使用模型，例如当您使用小模型以及何时需要 0，1?

发言人 4 01:50:43 I mean， yeah， that＇s， that＇s an open research problem.

Certainly. I don＇t think anyone＇s actually cracked this model routing problem

quite well. We＇d like to， we have like kind of initial implementations of this for things for something like cursor tab， but at the level of like going

between 400 and Sonnet 201， it＇s a bit trickier perhaps. Like there＇s also a question like what level of intelligence do you need to determine if the

thing is too hard for the four level model? Maybe you need the 0 1 level model. It＇s really unclear because. 我的意思是，是的，这是一个开放的研究问题。当然。我认为没有人真正很好地破解了这个模型的路由问题。我们想

要，对于像 Cursor 选项卡这样的东西，我们有一些初步的实现，但是在 400 和

十四行诗 201 之间的级别上，这可能有点棘手。还有一个问题，比如你需要什

么水平的智力来确定这个东西对于四级模型来说是否太难？也许你需要 01 级别

模型。这真的不清楚，因为。发言人 1 01：51：19 but you mentioned this，so there's a，there's a，there's a

pre training-induced that and there's post training and then there's like test time compute that fair to sort of separate where's the biggest gains? 但是你提到了这一点，所以有一，有一，有一，有一个预训练诱导的，有后期训练，

然后还有像测试时间计算这样公平地分开，最大的收益在哪里？

发言人 4 01：51：30 Well，it's weird because like test time compute，there's like a whole training strategy needed to get test time to compute to work And the really the other really weird thing about this is no one like outside of the big labs and maybe even just open a，no one really knows how it works. Like there have been some really interesting papers that，show hints of what they might be doing. And so perhaps they're doing something with tree search using process reward models. But yeah，I just，I think the issue is we don't

quite know exactly what it looks like. So it would be hard to kind of

comment on like where it fits in. I would put it in post training，but maybe

like the compute spent for this kind of for getting test time，compute to

work for a model is going to dwarf prey training-induced we . 嗯，这很奇

怪，因为就像测试时间计算一样，需要一个完整的培训策略来让测试时间计算

工作，而另一个真正奇怪的事情是，在大型实验室之外没有人喜欢，甚至可能

只是打开一个，没有人真正知道它是如何工作的。就像有一些非常有趣的论文

一样，显示出他们可能正在做什么的线索。所以也许他们正在使用过程奖励模

型进行树搜索。但是，是的，我只是，我认为问题在于我们并不完全知道它到

底是什么样子。所以很难对它适合的地方进行评论。我会把它放在后期训练

中，但也许就像为了获得测试时间而花费的计算一样，模型的计算将会矮化猎

物训练诱导我们。

发言人 1 01：52：19 don't even know if O 1 is using just like chain of thought RL. We don't know how they're using any of these. We don't know anything. 甚至不知道 O1 是否像思维链 RL 一样使用。我们不知道他们是如何使用这些的。我们什么都不知道。

发言人 401：52：27 It's fun to speculate. 推测很有趣。

发言人 1 01：52：30 Like if you were to，build a competing model，what would

you do? 如果你要建立一个竞争模型，你会做什么？

发言人 4 01：52：35 Yeah，so one thing to do would be I think you probably need to train a process reward model，which is so maybe we can get into reward models and outcome reward models versus process reward models.

是的，所以要做的一件事是我认为你可能需要训练一个过程奖励模型，这样我

们就可以进入奖励模型和结果奖励模型与过程奖励模型。

发言人 4 01：52：46 Outcome reward models are the kind of traditional

reward models that people are trained for these for language models,

language modeling. And it's just looking at the final thing. So if you're doing

some math problem，let's look at that final thing. You've done everything and assign a great to it，how likely we think like，what's the reward for this，this，this outcome process? 结果奖励模型是一种传统的奖励模型，人们接受语

言模型的训练。它只是看最后一件事。所以，如果你正在做一些数学问题，让

我们看看最后一件事。你已经做了一切，并赋予了它伟大的东西，我们思考的

可能性有多大，这个结果过程的回报是什么？

发言人 4 01：53：06 Reward models instead try to grade the chain of thought. And so OpenAl had some preliminary paper on where I think last summer，where they use human labelers to get this pretty large，several hundred thousand data set of grading chains of thought. Ultimately，it feels like I haven't seen anything interesting in the ways that people use process

reward models outside of just using it as a means of affecting how we

choose between a bunch of samples. So like what people do in all these papers is they sample a bunch of outputs from the language model and

then use the process reward models to grade all those generations

alongside maybe some other heuristics，and then use that to choose the

best answer the really interesting thing that people think might work and

people want to work is tree search with these processor word models.

Because if you really can grade every single step of the chain of thought,

then you can kind of branch out and，you know，explore multiple paths of

this chain of thought and then use these process word models to evaluate how good is this branch that you're taking. 相反，奖励模型试图给思维链条打分。因此，OpenAl 在去年夏天就我认为的情况发表了一些初步论文，他们使

用人类标签来获得这个相当大的，数十万个思想分级链数据集。最终，我觉得

我没有看到人们使用过程奖励模型的方式有什么有趣的地方，除了把它作为影

响我们在一堆样本之间进行选择的一种方式。就像人们在所有这些论文中所做

的那样，他们从语言模型中抽取一堆输出，然后使用过程奖励模型来给所有这

些世代打分，同时可能还有其他启发式方法。然后使用它来选择最佳答案，人

们认为真正有趣的事情可能会起作用，人们想要工作的是使用这些处理器字模

型的树搜索。因为如果你真的可以为思维链的每一步评分，那么你就可以分支

出来，探索这个思维链的多条路径，然后使用这些过程词模型来评估你正在进

行的这个分支有多好。

发言人 1 01：54：13 Yeah，when when the quality of the branch，it's somehow strongly correlated with the quality of the outcome at the very end. So like you have a good model of knowing which branch you take，so not just thisin the short term. 是的，当分支机构的质量与最后的结果质量密切相关时。就像你有一个很好的模型知道你选择哪个分支，所以不仅仅是在短期内。

发言人 4 01：54：25 like in the long term，yeah，and like the interesting work

that I think has been done is figuring out how to properly train the process or the interesting work that has been open sourced. And people，I think talk about is how to train the process reward models，maybe in a more

automated way. I could be wrong here，could not be mentioning some

people，but I haven't seen anything super that seems to work really well for using the process reward models creatively to do tree search and code. 就像从长远来看，是的，就像我认为已经完成的有趣工作一样，就是弄清楚如何

适当地训练过程或已经开源的有趣工作。而人们，我认为谈论的是如何训练过

程奖励模型，也许是以更自动化的方式。我可能错了，不能提一些人，但我还

没有看到任何创造性地使用过程奖励模型来做树搜索和代码的超级效果似乎非

常好的东西。

发言人 1 01：54：52 This is kind of an Al safety，maybe a bit of a philosophy

question. So OpenAl says that they're hiding the chain of thought from the user，and they've said that that was a difficult decision to make. They instead of showing the chain of thought，they're asking the model to summarize the chain of thought，they're also in the background saying they're going to

monitor the chain if to make sure the model is not trying to manipulate the user，which is a fascinating possibility. But anyway，what do you think about hiding the chain of thought? 这是一种 AI 安全，也许有点哲学问题。所以

OpenAl 说他们对用户隐藏了思维链，他们说这是一个艰难的决定。他们没有

展示思维链，而是要求模型总结思维链，他们也在后台说他们将监控链条，以

确保模型没有试图操纵用户，这是一个令人着迷的可能性。但是无论如何，对

于隐藏思维链，你有什么看法？

发言人 2 01：55：21 One consideration for OpenAl，and this is completely

speculative，could be that they want to make it hard for people to distill

these capabilities out of their model. It might actually be easier if you had

access to that hidden chain of thought to replicate the technology，because that's pretty important data like seeing the steps that the model took to get to the final result. OpenAl 的一个考虑因素，完全是推测性的，可能是他们想让人们难以从他们的模型中提炼出这些能力。如果您能够访问隐藏的思想链来

复制技术，实际上可能会更容易，因为这是非常重要的数据，比如看到模型为

获得最终结果所采取的步骤。

发言人 1 01：55：39 So you could probably train on that also. 所以你可能也可以在那上面训练。

发言人 2 01：55：42 And there was sort of a mirror situation with this with

some of the large language model providers. And also this is speculation，but some of these Apis used to offer easy access to log probabilities for all the tokens that they're generating，and also log probabilities for the prom tokens. And then some of these Apis took those away. And again，complete speculation. But one of the thoughts is that the reason those were taken

away is if you have access log probabilities similar to this hidden train of

thought，that can give you even more information to try and distill these

capabilities out of the Apis，out of these biggest models and models you

control，as in asterisks on also the previous discussion about us integrating O 1， I think that we're still learning how to use this model. 这与一些大型语言模型提供商存在某种镜像情况。这也是猜测，但其中一些 Apis 用于提供对它们

生成的所有 Token 的日志概率的轻松访问，以及对舞会 Token 的概率日志。然后其中一些 Apis 将它们拿走了。再一次，完全是猜测。但其中一个想法是，这些

被取消的原因是，如果你拥有类似于这种隐藏思路的访问日志概率，这可以给

你更多的信息，以便从这些最大的模型和你控制的模型中提取这些功能。正如

之前关于我们整合 O1 的讨论中所用的星号一样，我认为我们仍在学习如何使

用这个模型。

发言人 2 01：56：29 So we made O 1 available in cursor because like we were when we got the model，we were really interested in trying it out. I think a

lot of programmers are going to be interested in trying it out，but O 1 is not part of the default cursor experience in any way and we still haven't found a way to yet integrated into an editor and into the editor in a way that we

reach for sort of，you know，every hour，maybe even every day. And so I

think that the jury's still out on how to how to use the model. And we haven't seen examples yet of people releasing things where it seems really clear

like，oh，that's that's like now the use case，the obvious one to turn to is

maybe this can make it easier for you to have these background things

running，to have these models and loops，to have these models be a gente. But we're still. 因此，我们使 O1 在 Cursor 中可用，因为就像我们拿到模型时一样，我们非常有兴趣尝试一下。我认为很多程序员都会有兴趣尝试一下，但是

O1 并不是默认 Cursor 体验的一部分，我们仍然没有找到一种方法以一种我们

可以达到的方式集成到编辑器中，你知道的，每小时，甚至每一天。所以我认

为如何使用这个模型还没有定论。我们还没有看到人们发布东西的例子，看起

来非常清晰，就像现在的用例一样，显而易见的是，也许这可以让你更容易地

运行这些背景东西，拥有这些模型和循环。让这些模特成为绅士。但我们依

然。

发言人 5 01：57：21 still discovering，to be clear，we have ideas. We just need to，we need to try and get something incredibly useful before we put it outthere. 仍然发现，明确地说，我们有想法。我们只需要尝试得到一些非常有用

的东西，然后再将其推出。

发言人 4 01：57：29 But it has these significant limitations，like even like

barring capabilities，it does not stream. And that means it's really，really

painful to use for things where you want to supervise the output. And

instead，you're just waiting for the wall text to show up. Also，it does feel like the early innings of test time computing search where it's just like a very,

very much a V 0. And there's so many things that like，like don't feel quite

right. And I suspect in parallel to people increasing the amount of prey training-induced and the size of the models in pre training-induced fixed there，you'll now have this other thread of getting search to work better andbetter. 但它有这些显著的限制，就像限制能力一样，它不能流式传输。这意味

着在你想要监督输出的事情上使用它是非常非常痛苦的。相反，你只是在等待

墙上的文字出现。此外，它确实感觉像是测试时间计算搜索的早期局，就像一

个非常非常多的 v0。有很多事情喜欢，比如感觉不太对。我怀疑与人们增加猎

物训练诱导的数量和预训练诱导的模型大小相同，你现在会有另一个线索让搜

索工作越来越好。

发言人 1 01：58：13 So let me ask you about strawberry tomorrow eyes. So it looks like GitHub Copilot might be integrating O 1 in some kind of way. And I think some of the comments are saying，does this mean cursor is

done? I think I saw one comment saying that. 那么让我问你关于草莓明天的眼睛。所以看起来 GitHub 的 Copilot 可能正在以某种方式集成 O1。我想有些评

论是在说，这是否意味着 Cursor 已经完成了？我想我看到一条评论这么说。

发言人 3 01：58：34 I saw time to shut down，cursory shut down. 我看到时间关

闭了，粗略地关闭了。

发言人 1 01：58：38 for so it's a time to shut down cursor. 因此，是时候关闭 Cursor 了。

发言人 2 01：58：41 I think this space is a little bit different from past software spaces over the 2010 S，where I think that the ceiling here is really，really，really incredibly high. And so I think that the best product in 3 to four years will just be soon much more useful than the best product today. And you can like wax poetic about moats this and brand that. And，you know，this is our advantage. But I think in the end，just if you don't have，like if you stop innovating on the product，you will，you will lose. And that's also great for startups. That's great for people trying to enter this market because it means you have an opportunity to win against people who have，you know，lots of users already by just building something better. 我认为这个空间与 2010 年代过去的软件空间有点不同，我认为这里的天花板非常非常高。因此，我认为 3

到 4 年后最好的产品很快就会比今天最好的产品有用得多。你可以喜欢关于护

城河和品牌的诗意。而且，你知道，这是我们的优势。但我认为最终，如果你

没有，就像你停止对产品的创新，你会，你会输。这对初创企业来说也很好。

这对于试图进入这个市场的人来说非常棒，因为这意味着你有机会通过构建更

好的东西来赢得那些已经拥有大量用户的人。

发言人 2 01：59：24 And so I think，yeah，over the next few years，it's just about and building the best product，building the best system. And that both

comes down to the modeling engine side of things. And it also comes

down to the to the editing experience. 所以我认为，在接下来的几年里，它只是关于构建最好的产品，构建最好的系统。这都归结于建模引擎方面的事

情。这也归结为编辑体验。

发言人 4 01：59：37 Yeah，I think most of the additional value from cursor

versus everything else out there is not just integrating the new model fast like 0，1，It comes from all of the of depth that goes into these custom

models that you don't realize are working for you in kind of every facet of the product，as well as like the really thoughtful Xi with every single feature. 是的，我认为 Cursor 的大部分附加价值与其他所有东西相比，不仅仅是像 0、1

那样快速集成新模型。它来自这些定制模型中的所有深度，而您没有意识到这

些深度在产品的每个方面都适合您。以及像真正深思熟虑的 Xi 一样，每个功能

都有。

发言人 1 02：00：01 All right，from that profound answer was to send back

down to the technical. You mentioned you have a taxonomy of syntheticdata. 好的，从这个深刻的答案中传回给技术人员。你提到你有一个合成数据的

分类法。

发言人 402：00：08 Oh yeah. 哦，是的。

发言人 1 02：00：09 can you please explain? 你能解释一下吗？

发言人 4 02：00：10 Yeah，I think there are three main kinds of synthetic data. The first is so，so what is synthetic data? First，so there's normal data like

non-ss andthey data，which is just data that's naturally created that is usually it'll be from humans having done things from some human process. You get this data，synthetic data. The first one would be distillation. So having a

language model，kind of output tokens or probability distributions over

tokens，and then you can train some less capable model on this. This

approach is not going to get you a net，like more capable model than the original one that has produced the tokens，but it's really useful for if there's some capability you want to elicit from some really expensive high latency model，you can then distill that down into some smaller task specific model. 是的，我认为有三种主要的合成数据。第一个问题是这样的，那么什么是合成

数据？首先，所以有一些普通的数据，比如非 ss 和它们的数据，这些数据是自

然创建的，通常来自人类从某些人类过程中完成的事情。你得到这些数据，合

成数据。第一个是蒸馏。因此，拥有一个语言模型、一种输出代币或代币上的

概率分布，然后你可以在此基础上训练一些能力较差的模型。这种方法不会给

你一个比产生代币的原始模型更有能力的模型，但是如果你想从一些非常昂贵

的高延迟模型中提取一些能力，你可以将其提取到一些较小的任务专用模型

中，这种方法非常有用。

发言人 4 02：01：04 The second kind is when like one direction of the

problem is easier than the reverse. And so a great example of this is bug detection，like we mentioned earlier，where it's a lot easier to introduce

reasonable looking bugs than it is to actually detect them. And this is

probably the case for humans，too. And so what you can do is you can get a model that's not training that much data，that's not that smart to introduce a bunch of bugs and code，and then you can use that to then train uses

synthetic data to train a model that can be really good at detecting bugs. 第二种情况是当问题的一个方向比相反方向更容易时。一个很好的例子就是错误

检测，就像我们之前提到的，在这里引入看起来合理的错误比实际检测它们要

容易得多。人类也可能是这样。所以你可以做的是得到一个模型，这个模型不

需要训练那么多数据，引入一堆错误和代码并不聪明，然后你可以使用它来训

练使用合成数据来训练一个可以非常擅长检测错误的模型。

发言人 4 02：01：42 The last category I think is，I guess，the main one that it feels like the big labs are doing for synthetic data，which is producing text with language models that can then be verified easily. So like you extreme example of this is if you have a verification system that can detect if

language is Shakespeare level，and then you have a bunch of monkeys

typing and typewriters，like you can eventually get enough training data to train a Shakespeare level language model. And I mean，this is the case like very much the case for math，where verification is actually really，really easy for formal languages. And then what you can do is you can have an okay model，generate a ton of rollouts，and then choose the ones that，you know have actually proved the ground truth theorem theorems，and then train that further. There's similar things you can do for code with leak coded like problems or where if you have some set of tests that you know correspond to，if something passes these tests，it is actually solved a problem. You could

do the same thing where we verify that it has passed the test and then train the model and the outputs that have passed the test. I think it's gon na be a little tricky getting this to work in all domains or just in general，like having the perfect verifier feels really， really hard to do with just like open-ended miscellaneous tasks you give the model or more like long horizon tasks

even in coding. 我认为的最后一个类别，我猜是主要的类别，感觉就像大型实验室为合成数据所做的那样，生成带有语言模型的文本，然后可以轻松验证。

就像你这样极端的例子，如果你有一个可以检测语言是否为莎士比亚级别的验

证系统，然后你有一群打字的猴子和打字机，就像你最终可以获得足够的训练

数据来训练莎士比亚级别的语言模型。我的意思是，这种情况与数学的情况非

常相似，对于形式语言来说，验证实际上非常容易。然后你可以做的是拥有一

个好的模型，生成一个推广吨，然后选择那些已经证明了地面真理定理的模

型，然后进一步训练它们。有类似的事情你可以做代码泄漏的问题，或者如果

你有一些你知道对应的测试集，如果某些东西通过了这些测试，它实际上就解

决了一个问题。你可以做同样的事情，我们验证它已经通过了测试，然后训练

模型和已经通过测试的输出。我认为让它在所有领域都能工作有点棘手，或者

只是一般地说，就像拥有完美的验证器感觉非常非常困难，就像你给模型的开

放式杂项任务一样，或者更像是长期任务甚至在编码中。

发言人 1 02:03:08 That＇s because you＇re not as optimistic as Arvid. But yeah， so yeah， so that that that third category requires having a verifier. 那是因为你不像艾维德那样乐观。但是，是的，所以第三类需要有一个验证者。

发言人 4 02:03:16 Yeah， verification， it feels like it＇s best when， you know for a fact that it＇s correct and like then like it wouldn＇t be like using a language model to verify. It would be using tests or formal systems . 是的，验证，当你知道它是正确的时候，感觉这是最好的，就像那样，不像使用语言模型来验

证。它将使用测试或正式系统。

发言人 2 02:03:28 or running the thing too， doing like the human form of verification where you just do manual quality control. 或者也运行这个东西，像人类形式的验证一样，你只需要进行手动质量控制。发言人 402：03：34 Yeah. 是的。

发言人 2 02：03：35 but like the language model version of that where it's like running the thing，it actually understands it. Yeah，no，that's sort of

somewhere between，yeah. 但是就像语言模型版本一样，它就像运行东西一样，它实际上理解它。是的，不，那有点介于两者之间。

发言人 4 02：03：41 Yeah，I think that that's the category that is most likely toresult in like massive gains. 是的，我认为这是最有可能带来巨大收益的类别。发言人 1 02：03：48 What about RL with feedback side RLHF versus RLA AIF? What's the role of that in getting better performance on the models? 带反馈侧的 RL RLHF 与 RLA AIF 怎么样？这对于在模型上获得更好的性能有什么作用？ 发言人 4 02：04：00 Yeah，so RLHF is when the reward model you use is

trained from some labels you've collected from humans giving feedback. I think this works if you have the ability to get a ton of human feedback for

this kind of task that you care about. 是的，所以 RLHF 是指您使用的奖励模型是根据您从提供反馈的人类收集的一些标签进行训练的。我认为如果你有能力

获得吨的人类反馈来完成你关心的任务，这行得通。

发言人 4 02：04：20 RR AI F is interesting because you're kind of depending on like this is actually kind of going to，it's depending on the constraint that verification is actually a decent bit easier than generation because it feels like，okay，like what are you doing? Or you're using this language model to look at the language model outputs and then improve the language model. But no，it actually may work if the language model has a much easier time verifying some solution then it does generating it. Then you actually could perhaps get this kind of recursively，but don't think it's going to look exactly like that. The other，the other thing you could do is that we kind of do is like a little bit of a mix of rlaf and Rhf，where usually the model is actually quite correct. And this is the case of cursor tab picking，between like two possible generations of what is，what is，what is the better one? And then it just

needs like a hand，a little bit of human nudging with only on the order of 5100 examples to kind of align that prior the model has with exactly with what you want looks different than I think normal RLA chef，where you're usually usually training these rewards models and tons of examples. RR Al F 很有趣，因为你有点依赖于这实际上是一种走向，这取决于验证实际上比生成

更容易的约束，因为感觉就像，好吧，你在做什么？或者您正在使用此语言模

型查看语言模型输出，然后改进语言模型。但不，如果语言模型更容易验证某

些解决方案，那么它实际上可能会起作用，然后它会生成它。那么你实际上可

能会得到这种递归，但不要认为它看起来会完全像那样。另外，你可以做的另

一件事是我们有点像 rlaf 和 Rhf 的混合，通常模型实际上非常正确。这就是

Cursor 选项卡拾取的情况，在两个可能的世代之间，哪个是更好的？然后它只

需要像一只手一样，一点点人类的促进，只需要 5100 个例子来对齐模型之前与

你想要的完全不同，我认为正常的 RLA 厨师，你通常在哪里训练这些奖励模型

和大量的例子。

发言人 1 02：05：35 What's your intuition when you compare generation and verification and generation and ranking? Isis ranking way easier than

generation? 当你比较生成和验证、生成和排名时，你的直觉是什么？排名比

一代更容易吗？

发言人 4 02：05：45 My intuition would just say，yeah，it should be like this is kind of going back to like if you，if you believe pet does not equal NP，then there's this massive class of problems that are much，much easier to verify given proof than actually proving it. 我的直觉会说，是的，这应该是回到像这样的情况，如果你相信宠物不等于 NP，那么有这样大量的问题，验证给定的证

据比实际证明它要容易得多。发言人 1 02：06：03 I wonder if the same thing wil prove p not equal to NP or

p equal to NP. 我想知道是否同样的事情会证明 p 不等于 NP 或 p 等于 NP。发言人 3 02：06：09 That would be，that would be really cool. 那将会，那将会

非常酷。

发言人 1 02：06：11 That'd be of whatever feels metal. By Al，who gets the credit? Another open philosophical question. 这将是任何感觉金属的东西。

通过 AI，谁得到信用？另一个开放性哲学问题。

发言人 402：06：21 I'm actually it. 我确实是这样的。

发言人 5 02：06：24 I'm actually surprisingly curious what，what，like a good bet for 1， 1 Al will get the field medal wil be actually . 我实际上非常好奇，对

于 1,1 个 A | 来说，一个好的赌注将获得实地奖章，实际上会是什么。

发言人 2 02：06：31 doing on specialty? 做专业的？

发言人 5 02：06：33 I don't know what a mon's bet here is. 我不知道这里的赌注

是什么。

发言人 1 02：06：35 Oh，sorry，Nobel Prize or fields medal. 哦，对不起，诺贝

尔奖或田野奖章。

发言人 4 02：06：37 first medal fields，mettle level，mettle. 第一奖牌领域，勇

气水平，勇气。

发言人 1 02：06：41 fields，metal comes first. Well，you would say that，ofcourse. 田地，金属是第一位的。你当然会这么说。

发言人 3 02：06：44 but it's also this like isolated system，you know，I，and yeah，sure，yeah. 但它也像一个孤立的系统，你知道，我，是的，当然，是

的。

发言人 5 02：06：48 like I don't even know if don't need. 就像我甚至不知道是否需要。

发言人 402：06：50 to do I feel like I 2020 there，I felt like the path to get to

Imo was a little bit more clear because it already could get a few Imo

problems and there a bunch of like there was a bunch of low hanging fruit given the literature at the time of like what what tactics people could take，I think I one much less verse in the space of theorem pro now and two，yeah，less intuition about how close we are to solving these really，really hard

open problems. 我觉得我 2020 年在那里，我觉得到达 Imo 的道路更加清晰

了，因为它已经可能会遇到一些 lmo 问题，而且根据当时的文献，有一堆容易

实现的目标就像人们可以采取什么策略一样，我认为现在在定理 pro 的空间里

少了一个诗句，两个，是的，对我们离解决这些非常困难的开放性问题有多近

的直觉也少了。

发言人 1 02：07：15 So you think you'l be fields matter first it won't be like inphysics or in. 所以你认为你首先会成为重要的领域，它不会像物理学或其他领域那样。

发言人 502：07：20 100% I think I think I think that's probably more likely be like it's probably much more likely that they'll get than yeah，well，I think it

puts the like I don't know like BSD which is the bird SW and dire conjecture or like Riemann ipods or any one of these like hard，hard math problem

research can actually really hard，it's sort of unclear what the path you to get even a solution looks like，like we don't even know what a path looks like，letalone.100% 我想我认为这可能更有可能是他们得到的可能性要比是的，好吧，我认为它把我不知道的东西放在像 BSD 这样的鸟 SW 和可怕的猜想，或者像

Riemann ipods 或任何一种这样的东西上，研究困难的数学问题实际上可能非常困难，甚至不清楚你得到解决方案的路径是什么样子，就像我们甚至不知道

路径是什么样子，更不用说了。

发言人 3 02：07：47 Yeah，this is like an isolated system. And you can actually，you have a good reward system and it feels like it's easier to train for that. 是的，这就像一个孤立的系统。实际上，你可以拥有一个良好的奖励系统，并且

感觉为此进行训练更容易。

发言人 4 02：07：55 I think we might get fields metal before AGI. 我想我们可能会在 AGI 之前得到金属领域。

发言人 5 02：07：59 I think I mean I'd be very happy，would very happy，but I don't know if I think 2028， 2030， 20 feels metal，feels metal，all right? 我想我的意思是我会非常开心，会非常开心，但我不知道我是否认为 2028、2030、

20 感觉金属，感觉金属，好吗？

发言人 1 02：08：13 It's feels like forever from now given how fast things have been going. Speaking of how fast things have been going，let's talk about scaling laws. So for people who don't know，maybe it's good to talk about this whole idea of scaling laws，what are they? Where do you think stand

and where do you think things are going? 从现在开始，考虑到事情发展的速度，感觉就像是永远。说到事情发展得有多快，让我们来谈谈缩放定律。所以

对于不知道的人来说，也许谈论缩放定律的整个想法是件好事，它们是什么？

你认为现在的立场是什么？你认为事情会走向何方？

发言人 4 02：08：34 And it was interesting. The original scaling loss paper by OpenAl was slightly wrong because I think of some issues they did with

learning write schedules. And then Chinchilla showed a more correct version. And then from then，people have，again，kind of deviated from

doing the compute optimal thing. People start now optimizing more so for making the thing work really well given given an inference budget. And I

think there are a lot more dimensions to these curves than what we

originally used of just compute number of parameters and data like

inference computes is the obvious one. 这很有趣。OpenAl 最初的缩放损失论文有点错误，因为我想到了他们在学习编写时间表时遇到的一些问题。然后

栗鼠展示了一个更正确的版本。然后从那时起，人们再次偏离了做计算最佳的

事情。人们现在开始更加优化，以便在给定推理预算的情况下使事物工作得非

常好。我认为这些曲线的维度比我们最初仅用于计算参数和数据的数量（如推

理计算）要多得多。

发言人 4 02：09：12 I think context length is another obvious one. So if you

care，like let's say you care about the two things of inference，compute and then context window，maybe the thing you want to train is some kind of

SSM because they're much，much cheaper and faster at super，super long context. And even if maybe it has 10x worse scaling properties during

training，maybe you have spend 10x more compute to train the thing to get the same level of capabilities. It's worth it because you care most about that inference budget for really long context windows. So it'll be interesting to see how people kind of play with all these dimensions. 我认为上下文长度是另一个明显的因素。所以，如果你关心推理这两件事，计算和上下文窗口，也

许你想要训练的东西是某种 SSM，因为它们在超长的上下文下更便宜、更快。

即使它在训练过程中具有 10 倍较差的缩放属性，也可能您需要花费 10 倍的计算

来训练该事物以获得相同的能力水平。这是值得的，因为你最关心的是很长上

下文窗口的推理预算。所以看看人们如何玩弄所有这些维度将会很有趣。

发言人 1 02：09：47 So，yeah，I mean，you speak to the multiple dimensions. Obviously，the original conception was just looking at the variables of the size of the model as measured by parameters and the size of the data is

measured by the number of tokens and looking at the ratio of the two. And it's kind of a compelling notion that there is a number or at least a minimum，and it seems like one was emerging. Do you still believe that there is a kind of bigger is better? 所以，是的，我的意思是，你说的是多个维度。显然，最初的概念只是通过参数来衡量模型大小的变量，而数据大小则通过代币的数量

来衡量，并考虑两者的比率。这是一种令人信服的概念，即存在一个数字或至

少是最小值，而且似乎有一个正在出现。你还相信有一种越大越好吗？

发言人 4 02：10：15 I mean，I think bigger is certainly better for just raw

performance，raw intelligence and raw intelligence. 我的意思是，我认为仅从原始表现、原始智力和原始智力来看，越大肯定更好。

发言人 4 02：10：23 I think the path that people might take is I'm particularly bullish on distillation and like，yeah，how many knobs can you turn to if we spend like a ton，ton of money on training，like get the most capable cheap model，right? Like really，really caring as much as you can. Because like the naive version of caring as much as you can about inference time，compute is what people have already done with like the lalama models or just over

training the shit out of 7 B models on way，way，way more tokens than

essentially a optimal. But if you really care about it，maybe the thing to do is what gamma did，which is let's not just train on tokens. Let's literally train on. Minimizing the KL divergence with the distribution of Gem 2070，right? So knowledge distillation there. And you're spending the compute of literally training this 27 billion model，billion parameter model on all these tokens

just to get out this，I don't know，smaller model. 我认为人们可能会选择的道路是我特别看好蒸馏，比如，如果我们像吨一样花吨的钱在培训上，比如获得

最有能力的廉价模型，你可以转向多少旋钮，对吧？尽可能地非常关心。因为

就像天真的关心推理时间一样，计算是人们已经用拉马模型或者只是从 7b 模型中过度训练的方式，方式，更多的代币，而不是本质上的最优代币。但如果你

真的关心它，也许要做的事情就是伽玛所做的，这就是让我们不仅仅是在代币

上训练。让我们真的继续训练。用宝石 2070 的分布来最小化 KL 散度，对吗？知

识升华在那里。你花费了大量的计算来训练这个 270 亿个模型，十亿个参数模

型在所有这些代币上，只是为了得到这个，我不知道，更小的模型。

发言人 1 02：11：20 And the distillation gives you just a faster model，smaller,it means faster. 蒸馏给你的只是一个更快的模型，更小意味着更快。

发言人 4 02：11：23 Yeah，distillation in theory is，I think，getting out more

signal from the data that you're training on. And it's like another，it's perhaps another way of getting over，not like completely over，but like partially

helping with the data wall or like you only have so much data to train on.

Let's like train this really，really big model on all these tokens，and we'll distill it into the smaller one. And maybe we can get more signal per token for this much smaller model than we would have originally if we trained it. 是的，理论上的蒸馏，我认为，从你训练的数据中获得更多的信号。这就像另一种方

式，这可能是另一种方式来结束，不是完全结束，而是部分帮助数据墙，或者

你只有这么多数据可以训练。让我们在所有这些代币上训练这个非常大的模

型，然后将其提炼成较小的一个。也许我们可以为这个小得多的模型获得比我

们最初训练它时更多的每个 Token 信号。

发言人 1 02：11：51 So if I gave you $10 trillion，how would you spend it? I

mean，you can't buy an island or whatever，How would you allocate it in

terms of improving the big model versus maybe paying for HF in the RLHF?Or,yeah. 那么，如果我给你 10 万亿美元，你会怎么花呢？我的意思是，你不能

买一个岛屿或其他东西，你会如何分配它来改善大模型，而不是在 RLHF 中支付

HF? 或者是的。发言人 402：12：11 I think there's a lot of these secrets and details about

training these large models that I just don't know and only privy to the large labs. And the issue is I would waste a lot of that money if I even attempted this because I wouldn't know those things. Suspending a lot of disbelief,

assuming like you had the know-how and or if you're saying like you have to operate with like the limited information you have now? 我认为训练这些大型模型有很多秘密和细节，我只是不知道，只知道大型实验室。问题是，如果我

尝试这样做，我会浪费很多钱，因为我不知道那些东西。暂停很多怀疑，假设

你有专业知识，或者如果你说你必须像现在有限的信息一样运作？

发言人 1 02：12：37 No，no，no，actually，I would say you swoop in and you get all the information，all the little heuristics，all the little parameters，all the all the parameters that define how the thing is trained. If we look and how to invest money for the next five years in terms of maximizing what you calledraw intelligence. 不，不，实际上，我会说你飞奔进去，你会得到所有的信

息，所有的小启发式方法，所有的小参数，所有定义如何训练事物的参数。如

果我们考虑如何在未来五年投资，以最大化你所谓的「原始智能」。

发言人 5 02：12：57 I mean，isn't the answer like really simple? You just just try to get as much compute as possible，likelike at the end of the day，all all

you need to buy is the Gpu's and then sort the researchers can find，find all the like. They can sort of you can tune whether you want between a big

model or a small model. 我的意思是，答案不是很简单吗？你只需尝试获得尽可能多的计算能力，就像在一天结束时，你只需要购买 Gpu，然后对研究人员

进行排序，找到所有类似的东西。他们可以让你在大模型或小模型之间进行调

整。

发言人 4 02：13：15 Well，this gets into the question of like，are you really

limited by compute and money or are you limited by these other things? 这就涉及到一个问题，你是真的受到计算和金钱的限制，还是受到其他因素的限

制？

发言人 5 02：13：21 I'm more privileged to arvi arvid's belief that we're sort of idea limited，but there's always that like. 我更有幸的是，阿维·阿维德相信我们

的想法是有限的，但总是有这样的想法。

发言人 3 02：13：27 but if you have a lot of compute，you can run a lot of

experiments. 但是如果你有大量的计算能力，你可以运行大量的实验。

发言人 1 02：13：32 So you would run a lot of experiments versus like use that computer to train a gigantic model. 所以你会运行很多实验，而不是使用那台计算机来训练一个巨大的模型。

发言人 3 02：13：38 I would，but I do believe that we are limited in terms of ideas that we have. 我会的，但我确实相信我们在想法方面是有限的。

发言人 4 02：13：44 I think，yeah，because even with all this compute and like，you know，all the data you could collect in the world，I think you really are ultimately limited by not even ideas，but just like really good engineering. Like even with all the capital in the world，would you really be able to

assemble? Like there aren't that many people in the world who really like make the difference here and there's so much work that goes into research that is just like pure，really，really hard engineering work as like a very kind of hand wavy example. If you look at the original Transformer paper，you know how much work was kind of joining together a lot of these really

interesting concepts embedded in the literature versus then going in and writing all the code，like maybe the cudamani likes，maybe whatever else. I don't know if it ran Gpu's or Gpu's originally such that it actually saturated the GPU performance，getting Nom 0 to go in and do all this code and Gnome is like probably one of the best engineers in the world or maybe

going a step further like the next generation of models having these things like getting model parallelism to work and scaling it on like，you know,

thousands of or maybe tens of thousands of like V1 hundred S，which I think GPT-3 may have been. There's just so much engineering effort that has to go into all of these things to make it work if you really brought that cost

down to like，you know，maybe not 0，but just made it 10x easier，made it super easy for someone with really fantastic ideas to immediately get to the version of like the new architecture they dreamed of. That is like getting 50，40% utilization on the Gpu's. I think that would just speed up research by aton. 我认为，是的，因为即使有这么多的计算和你知道，你可以收集世界上的

所有数据，我认为你最终甚至不会受到想法的限制，而是像真正优秀的工程一

样。即使拥有世界上所有的首都，你真的能聚集起来吗？就像世界上没有那么

多人真正喜欢在这里做出改变一样，有太多的工作投入到研究中，就像纯粹

的，非常困难的工程工作一样，就像一个非常手动的波浪例子。如果你看看最

初的变压器论文，你就会知道需要做多少工作才能将许多嵌入文献中的非常有

趣的概念连接在一起，而不是像 cudamani 喜欢的那样编写所有代码。我不知道

它最初是运行 Gpu 还是 Gpu，以至于它实际上饱和了 GPU 性能，让 Nom 0 进入并完成所有这些代码和 Gnome 就像世界上最好的工程师之一，或者可能更进一

步，像下一代模型一样，拥有这些东西，比如让模型并行工作并扩展，你知

道，成千上万或者数以万计的 V1，我想可能 GPT-3 了。如果你真的将成本降低

到像你知道的那样，也许不是 0，而是让它变得更容易 10 倍，那么所有这些事

情都需要投入大量的工程努力才能使其工作。让那些有着奇思妙想的人能够非

常容易地立即实现他们梦想中的新架构版本。这就像在 Gpu 上获得 50% 到 40%

的利用率。我认为这会加快吨的研究速度。

发言人 5 02：15：27 I mean，I think I think if you see a clear path to

improvement，you should always sort of take the low hanging fruit first,

right? I think probably opening eye and all the other labs that did the right thing to pick off the low hanging fruit where the low hanging fruit is like sort

of you could scale up to a GPT 4.25 scale. And you just keep scaling and like things，things keep getting better. And as long as there's no point of experimenting with new ideas when like everything，everything is working and you should sort of bang on and to try to get as much as much juice out of the possible button. And then maybe when you really need new ideas for，I think I think if you're，if you're spending $10 trillion，probably want to spend some，you know，then actually like reevaluate your ideas，like

probably your idea limited at that point. 我的意思是，我认为如果你看到一条清晰的改进之路，你应该总是先抓住容易实现的目标，对吧？我认为可能会睁

大眼睛，其他所有做了正确事情的实验室都摘下了低垂的果实，其中低垂的果

实就像你可以扩大到 GPT4.25 的规模一样。你只是不断扩大规模，事情会变得

越来越好。只要在一切都正常的时候没有尝试新想法的意义，你就应该努力工

作，尽可能多地从可能的按钮中获得更多的汁液。也许当你真的需要新想法的

时候，我认为如果你，如果你花费 10 万亿美元，可能想要花一些，你知道，那

么实际上就像重新评估你的想法一样，可能你的想法在那个时候受到限制。

发言人 4 02：16：15 I think all of us believe new ideas are probably needed to get，you know，all the way there to AGI. And all of us also probably believe there exist ways of testing out those ideas at smaller scales and being fairly confident that they'll play out. It's just quite difficult for the labs in their

current position to dedicate. They're limited research and engineering

talent to exploring all these other ideas when there's like this core thing that

will probably like improved performance for some like decent amount oftime. 我认为我们所有人都相信，要想到达 AGI，可能需要新的想法。我们所有

人都可能相信，有一些方法可以在较小规模上测试这些想法，并相当有信心它

们会发挥作用。对于目前位置的实验室来说，投入到工作中是相当困难的。他

们是有限的研究和工程人才，无法探索所有这些其他想法，因为有这样的核心

事物，可能会在相当长的时间内提高性能。发言人 1 02：16：56 Yeah，but also these big labs like winning. It's just going wild. Okay，so how，big question. Looking out into the future，you're now at the center of the programming world，how do you think programming，the nature programming changes in the next few months，in the next year and the next two years and next five years，10 years? 是的，但这些大实验室也像赢了一样。它只是在疯狂。好的，那么如何，大问题。展望未来，您现在处于

编程世界的中心，您认为编程在接下来的几个月、接下来的一年、接下来的两

年、接下来的五年、十年内自然会发生怎样的变化？

发言人 2 02：17：20 I think we're really excited about a future where the

programmers in the driver's seat for a long time，and you've heard us talk about this a little bit，but one that emphasizes speed and agency for the programmer and control the ability to modify anything you want to modify，the ability to iterate really fast from what you're building. And this is a little different，I think，than where some people are jumping to in the space

where I think one idea that's captivated people is，can you talk to your

computer? 我认为我们对未来感到非常兴奋，在未来，程序员长期掌握主控

权，你可能已经听过我们谈论过这个问题，但它强调程序员的速度和代理，并

控制修改任何你想修改的能力。从您正在构建的内容中快速迭代的能力。这有

点不同，我想，有些人跳进了我认为一个吸引人们的想法是，你能和你的电脑

说话吗？

发言人 2 02：17：58 Can you have it built software for you，talking to like an engineering department or an engineer over Slack? And can I just be this sort of isolated text box? And part of the reason we're not excited about that is，you know，some of the stuff we've talked about with latency. But then a big piece，a reason we're not excited about that is because that comes with giving up a lot of control. It's much harder to be really specific when you're talking in the text box and if you're necessarily just going to communicating with a thing like you would be communicating with an

engineering department and you're actually advocating tons of tons of

really important decisions to the spot. 你可以让它为你构建软件，像工程部门

或工程师在 Slack 上说话吗？我可以成为这种孤立的文本框吗？我们对此不感兴

趣的部分原因是，你知道，我们谈论过的一些与延迟有关的东西。但接下来是

一个大问题，我们对此不感到兴奋的一个原因是因为这意味着放弃了很多控制

权。当你在文本框中交谈时，要做到非常具体要困难得多，如果你只是要与一

个工程部门沟通，而你实际上是在提倡大量的非常重要的决策。

发言人 2 02：18：33 And this kind of gets at fundamentally what engineering is. I think that some people who are a little bit more removed from

engineering might think of it as，you know，the spec is completely written out and then the engineers just calm and they just implement. And it's just about making the thing happen in code and making the thing exists. But I think a lot of the best engineering，the engineering we enjoy involves tons of tiny micro decisions about what exactly you're building and about really hard tradeoffs between speed and costs and all the other things involved in a system and we want，as long as humans are actually the ones making，you know，designing the software and the ones specifying what they want to be built. And it's not just a company run by all Ai's. We think you'll really want the humor. The human in a driver's seat dictate these decisions and so

there's the jury stil out on kind of what that looks like. 这种基本上理解了工程

是什么。我认为一些对工程有点不了解的人可能会认为，你知道，规范已经完

全写出来了，工程师们就冷静下来，然后就实施了。这只是关于在代码中让事

情发生并让事情存在。但我认为很多最好的工程，我们喜欢的工程涉及大量微

小的决策，比如你正在建造什么，以及速度和成本之间的艰难权衡，以及系统

中涉及的所有其他事情，只要人类实际上是制造它们的人，你知道的，设计软

件和指定他们想要构建的软件。而且它不仅仅是一家由所有 Ai 运营的公司。我

们认为你真的需要幽默。坐在驾驶座上的人决定这些决定，所以陪审团仍然不知道它是什么样子的。

发言人 2 02：19：30 I think that，you know，one weird idea for what that could look like is it could look like you kind of you can control the level of

abstraction you view a code base at，and you can point at specific parts of a code base that like maybe you digest a code base by looking at it in the

form of pseudocode，and you can actually edit that pseudocode too，and then have changes get made down at the sort of formal programming level and you keep the like，you know，you can gesture at any piece of logic in

your software component of programming，you keep the inflow text editing component of programming，you keep the control of，you can even go

down into the code，you can go at higher levels of abstraction while also

giving you these big productivity gains. 我认为，你知道，一个奇怪的想法是，它看起来像你可以控制你查看代码库的抽象级别，并且您可以指向代码库

的特定部分，就像您可以通过以伪代码的形式查看代码库来消化它，并且您实

际上也可以编辑该伪代码，然后在正式的编程级别进行更改并保留类似的内

容。你知道，你可以在编程的软件组件中对任何逻辑进行手势操作，你可以保

持编程的流入文本编辑组件，你可以保持控制，你甚至可以深入到代码中，你

可以进入更高层次的抽象，同时也可以给你这些巨大的生产力收益。

发言人 1 02：20：14 It'd be nice if you can go up and down the abstraction

stack. 如果你能在抽象堆栈中上下波动就好了。

发言人 2 02：20：18 Yeah，and there are a lot of details figure out there，that's sort of like a fuzzy idea，time will tell if it actually works，but these principles of control and speed in the human in the driver's seat，we think are really

important. We think for some things，like Arvid mentioned before，for some styles of programming，you can kind of hand it off chatbot style，you know，if you have a bug that's really well specified，but that's not most of programming and that's also not most of the programming we think a lot ofpeople value. 是的，有很多细节需要弄清楚，这有点像一个模糊的想法，时间会告诉我们它是否真的有效，但我们认为这些驾驶员座位上的控制和速度原则

非常重要。我们认为对于某些东西，比如之前提到的 Arvid，对于某些风格的编

程，你可以把它交给聊天机器人风格，你知道，如果你有一个非常明确的错

误，但这并不是大部分编程，也不是我们认为很多人重视的大部分编程。

发言人 1 02：20：43 What about like the fundamental skill of programming?

There's a lot of people，like young people right now kind of scared like

thinking because they like love programming，but they're scared about like，will I be able to have a future if I pursue this career path? Do you think the

very skill of programming wil change fundamentally? 那么编程的基本技能呢？有很多人，比如现在的年轻人，有点害怕思考，因为他们喜欢编程，但他

们害怕如果我追求这条职业道路，我是否会有未来？你认为编程技能会发生根

本性的变化吗？

发言人 2 02：21：04 I actually think this is a really，really exciting time to be

building software. 我实际上认为这是构建软件的一个非常非常激动人心的时刻。

发言人 2 02：21：08 Like we remember what programming was like in，you

know，2013，2012，whatever it was. And there was just so much more crafted and boilerplate and，you know，looking something really gnarly. And at that stuff still like this. It's definitely not at 0，but programming today is way more fun than back then. It's like we're really getting down to the delight

concentration and all the things that really draw people to programming.

Like for instance，this element of being able to build things really fast，speed and also individual control，like all those are just being turned up a ton. And so I think it's just going be，I think it's going to be a really fun time for people who build software. 就像我们记得编程是什么样子一样，你知道，

2013 年，2012 年，无论是什么。而且有更多的制作和样板，你知道，看起来

非常粗糙。而且那种东西仍然像这样。现在的编程肯定不是 0，但今天的编程

比那时更有趣。这就像我们真的开始专注于愉悦和所有真正吸引人们编程的事

情。例如，能够快速建造东西的这个元素，速度和个人控制，就像所有这些只

是被吨。所以我认为这将是，我认为这将是一个对于构建软件的人来说非常有

趣的时刻。

发言人 2 02：21：53 I think that the skills will probably change too. I think that people's taste and creative ideas will be magnified and it will be less about，maybe less a little bit about whether they play text editing，maybe even a little bit less about carefulness，which I think is really important today if

you're a programmer，like it'll be a lot more fun. 我认为技能也可能会改变。我认为人们的品味和创意将被放大，它将不再那么关注，也许更少一些关于他

们是否进行文本编辑，甚至可能更少一些关于细心，我认为如果你是一名程序

员，这在今天是非常重要的。就像这样会更有趣。

发言人 1 02：22：13 What do you guys think? 你们觉得呢？

发言人 3 02：22：15 I agree I'm very excited to be able to change. One thing that that happened recently was like we wanted to do a relatively big

migration to could be we're using async local storage in node JS，which is known to be not very performant and we want it to migrate to a context

object. This is a big migration and effects the entire code base and SW. And I spent，I don't know，five days working through this. 我同意，我很兴奋能够改变。最近发生的一件事是，我们想要进行相对较大的迁移，可能是我们在节

点 JS 中使用异步本地存储，众所周知，这不是很高效，我们希望它迁移到上下

文对象。这是一次大规模的迁移，会影响整个代码库和 SW。我花了，我不知

道，五天时间来完成这个工作。发言人 3 02：22：42 Even with today's Al tools，I am really excited for a future where I can just show a couple of examples and then the Al applies that to all of the locations and then it highlights，oh，this is a new example，like what should I do? 即使使用今天的 AI 工具，我也对未来感到非常兴奋，我可以只展示几个例子，然后 AI 将其应用于所有位置，然后突出显示，哦，这是一个新的

例子，我该怎么办？

发言人 3 02：22：57 And then I show exactly what to do there. And then that

can be done in like 10 minutes，and then you can iterate much，much faster than you can. Then you don't have to think as much upfront and stand at the blackboard and like think exactly like，how are we going to do this? Because the cost is so high. But you can just try something first. And you realize，oh，this is not actually exactly what I want. And then you can change it instantly again after. And so，yeah，I think being a programmer in the future is going to be a lot of fun. 然后我会展示在那里做什么。然后这可以在 10 分钟内完成，

然后你可以比你更快地迭代。那么你就不必那么事先思考，站在黑板前，像这

样想，我们该怎么做？因为成本太高。但是你可以先尝试一下。然后你意识

到，哦，这实际上并不完全是我想要的。然后你可以在之后立即再次更改它。

所以，是的，我认为未来成为一名程序员将会很有趣。

发言人 4 02：23：26 Yeah，I really like that point about it feels like a lot of the

time with programming，there are two ways you can go about it. One is like you think really hard carefully upfront about the best possible way to do it，and then you spend your limited time of engineering to actually implement it. But I must prefer just getting in the code and like，you know，taking a

crack at seeing how，how，how it kind of lays out and then iterating really

quickly on that. That feels more fun. 是的，我真的很喜欢这一点，感觉很多时候在编程方面，有两种方法可以实现。一种是你非常认真地预先考虑最好的方

法，然后花费有限的工程时间来实际实施它。但我一定更喜欢进入代码，就像你知道的，尝试看看它是如何、如何布局的，然后在上面快速迭代。那样感觉

更有趣。

发言人 1 02：23：55 Yeah，like just speaking to generated，the boilerplate is great. So you just focus on the difficult design，nuanced difficult design decisions，migration. I feel like this is，this is a cool one，Like it seems like large language model is able to basically translate from one program

language to another or like translate like migrate in the general sense of what my grade is，But that's in the current moment. So I mean，the fear has to do with like，okay，as these models get better and better，then you're doing less and less creative decisions and is it going to kind of move to a place where it's you're operating in the design space of natural language where natural language is the main programming language? 是的，就像刚

才说的生成一样，这个样板文件很棒。所以你只需要专注于困难的设计、微妙

的设计决策和迁移。我觉得这是，这是一个很酷的感知，好像大型语言模型能

够基本上从一种程序语言翻译到另一种程序语言，或者像翻译一样迁移，但这

只是目前的情况。所以我的意思是，恐惧与，好吧，随着这些模型越来越好，

那么你所做的创造性决策越来越少了，它是否会转移到你在自然语言设计领域

中操作的地方，在那里自然语言是主要的编程语言？

发言人 1 02：24：37 And I guess I could ask that by way of advice，like if

somebody's interested in programming now，what do you think they should

learn? Like，do you guys started in Java and I forget the，oh，some PHP objective C，objective C，there you go? Yeah，I mean，in the end，we all know

JavaScript is going to win? And not TypeScript is just it's going to be like vanilla JavaScript is going to eat the world and maybe a little bit of PHP. And

I mean，it also brings up the question of like，I think Don Knut has a this idea

that some percent of the population is geeks and like there's a particular kind of psychology in mind required for programming. And it feels like more and more that's expands the kind of person that should be able to can

do great programming might expand. 我想我可以通过建议来问这个问题，比如如果有人现在对编程感兴趣，你认为他们应该学什么？喜欢，你们是从

Java 开始的，我忘了，哦，一些 PHP 目标 C，目标 C，你在那里吗？是的，我的

意思是，最终，我们都知道 JavaScript 会赢吗？而不是打字稿，它就像香草

JavaScript 将吞噬世界，也许还会有一点 PHP。我的意思是，这也提出了一个问题，我认为不要克努特有一个想法，即某些人口的百分比是极客，并且编程

需要一种特定的心理学。而且感觉越来越扩大了，应该能够做出色编程的人可

能会扩大。

发言人 4 02：25：32 I think different people do programming for different reasons，but I think the true maybe like the best programmers，are the ones

that really love just like absolutely love programming，For example，they're folks in our team who literally，when there，they get back from work，they go

and then they boot up cursor，and then they start coding on their side

projects for the entire night and they say，oh，so 3 AM doing that. And when

they're sad，they said，I just really need to code and I think like，you know，there's that level of programmer where like the obsession and love of

programming，I think makes really the best programmers. And I think these

types of people wil really get into the details of how things work. 我认为不同的人做编程有不同的原因，但我认为真正的可能就像最好的程序员一样，是

那些真正热爱编程的人，例如，他们是我们团队中的人，当他们在那里时，他

们从工作中回来，他们走了，然后启动 Cursor，然后他们开始整晚在他们的副

项目上编写代码，他们说，哦，所以凌晨 3 点这样做。当他们难过的时候，他

们会说，我真的需要编码，我想，你知道，有那种水平的程序员，就像对编程

的痴迷和热爱，我认为造就了最好的程序员。我认为这些类型的人会真正深入

了解事情如何运作的细节。

发言人 1 02：26：29 I guess the question I'm asking，that exact program I'm about that person when when the super tab，the super awesome praise be the tab succeeds，you keep saying tab. 我猜我在问的问题，那个确切的程序，我是关于那个人的，当超级标签，超级棒的赞美是标签成功了，你一直在

说标签。

发言人 3 02：26：42 that person in the team loves cursor Ta more than

anybody else，right? Yeah，and it's also not just likelike pressing tab is like the just pressing tab，that's like the easy way to say it and the catch

catchphrase，you know? But what you're actually doing when you're

pressing tab is that you're you're injecting intent all the time while you're doing it. You're you're sometimes you're rejecting it，sometimes you're

typing a few more characters and that's the way that you're，you're sort of shaping the things that's being created. And I think programming will

change a lot too. Just what is it that you want to. 团队中的那个人比其他任何人都更喜欢 CursorTa，对吧？是的，这也不仅仅是像按 tab 一样，就像只是按

tab 一样，这就像是最简单的表达方式和流行语，你知道吗？但是当你按下 tab

键时，你实际上在做的是，你在做的时候一直在注入意图。你有时候会拒绝

它，有时候你会输入更多的字符，这就是你塑造正在创造的事物的方式。我认

为编程也会发生很大变化。你想要的是什么。

发言人 5 02：27：17 make sort of higher bandwidth? The communication to the computer just becomes higher and higher bandwidth as opposed to like，like just typing is much lower bandwidth than than communicating

intent. 提高带宽？与计算机的通信变得越来越高带宽，而不是像打字那样比意

图通信的带宽要低得多。

发言人 1 02：27：27 I mean，this goes to your，manifesto titled Engineering Genius. We are an applied research lab building extraordinary productive human Al systems. So speaking to this like hybrid element to start，we're building the engineer of the future，a human Al programmer that's order of magnitude more effective than any one engineer. This hybrid engineer will have effortless control over their code base and no low entropy keystrokes. They will iterate at the speed of their judgment，even in the most complex systems using a combination of Al and human ingenuity that will outsmart and out engineer the best pure Al systems. We are a group of researchers and engineers we build software and models to invent at the edge of what's useful and what's possible. Our work has already improved the lives of

hundreds of thousands of programmers，and on the way to that will at least make programming more fun. So thank you for talking today. 我的意思是，这与你的宣言「工程天才」有关。我们是一个应用研究实验室，正在建设非凡高

效的人类人工智能系统。所以说这个混合元素开始，我们正在建立未来的工程

师，一个比任何一个工程师都更有效的人类 A | 程序员。这个混合工程师将毫不

费力地控制他们的代码库，并且没有低熵击键。即使在最复杂的系统中，他们

也会以判断的速度迭代，使用人工智能和人类聪明才智的结合，超越并设计出

最好的纯人工智能系统。我们是一群研究人员和工程师，我们构建软件和模型

来发明有用和可能的边缘。我们的工作已经改善了数十万程序员的生活，而在

实现这一目标的过程中，至少会让编程变得更加有趣。谢谢你今天的演讲。

发言人 2 02：28：26 thank you，thanks for having us，thank you，thank you. 谢谢，谢谢我们，谢谢，谢谢。

发言人 1 02：28：29 thanks for listening to this conversation with Michael Sule，Arvid，and Aman. To support this podcast，please check out our sponsors in the description. And now let me leave you with a random，funny and

perhaps profound programming code I saw on Reddit. Nothing is as

permanent as a temporary solution that works. Thank you for listening and hope to see you next time. 感谢您收听与 Michael Sule、Arvid 和 Aman 的对话。要支持此播客，请在说明中查看我们的赞助商。现在让我给你留一个我在 Reddit 上看到的随机、有趣且可能深刻的编程代码。没有什么比临时解决方案更持久的了。感谢您的聆听，希望下次见到您。

