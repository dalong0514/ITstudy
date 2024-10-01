## 20240907Anthropic内部三个顶级提示工程师的访谈

[AI prompt engineering: A deep dive - YouTube](https://www.youtube.com/watch?v=T9aRN5JkmL8)

白 T 恤的是 Alex Albert, Developer Relations, Anthropic

黑 T 恤的是 David Hirschi, Applied AI, Anthropic

黑 T 恤的是 Amanda Askell,  Alignment Finetuning, Anthropic

白 T 恤带有 Claude 标志的的是 Zack Witten, Prompt Engineering, Anthropic

Alex

Basically, this entire roundtable session here is just going to be focused mainly on prompt engineering. Variety of perspectives at this table around prompting from a research side, from a consumer side, from an enterprise side. And I want to just get the whole wide range of opinions because there's a lot of them. And just kind of open it up to discussion and explore what prompt engineering really is and what it's all about. And we'll just take it from there. So maybe we can go around the horn with intros. 

简单来说，我们今天这场讨论会的焦点主要集中在提示工程（prompt engineering）上。在座的各位对于提示技术有着不同的见解，包括研究角度、用户角度和企业角度。我希望能够广泛收集大家的观点，因为这个话题确实存在很多不同的看法。我们就开诚布公地讨论一下，探讨提示工程的本质是什么，它究竟包含哪些内容。让我们从这里开始，首先可以请大家简单做个自我介绍。

I can kick it off. I'm Alex. I lead developer relations here at Anthropic. Before that, I was kind of technically a prompt engineer at Anthropic. I worked on our prompt engineering team and did a variety of roles spanning from a solutions architect type of thing to working on the research side. So with that, maybe you can hand it over to David.

那么，让我来开个头吧。我是 Alex。我现在在 Anthropic 负责开发者关系（developer relations）工作。在担任这个职位之前，严格来说我是 Anthropic 的提示工程师（prompt engineer）。我在公司的提示工程（prompt engineering）团队工作过，担任过多种角色，包括解决方案架构师（solutions architect）之类的工作，也参与过研究方面的工作。好了，接下来也许我们可以请 David 发言了。

David

Heck yeah. My name is David Hirschi. I work with customers mostly at Anthropic on a bunch of stuff. Technical, I help people with fine tuning, but also just a lot of the generic things that make it hard to adopt language models, so prompting and just how to build systems with language models, but spend most of my time working with customers.

David Hirschi：没错！我叫 David Hirschi。我在 Anthropic 主要负责与客户合作，处理各种事务。技术上，我帮助人们进行微调（fine tuning），但也处理很多采用语言模型时遇到的常见挑战，比如提示工程（prompting）以及如何使用语言模型构建系统。不过，我的大部分时间都花在与客户直接合作上。

Amanda

Cool. I'm Amanda Askell. I lead one of the fine tuning teams at Anthropic, where I guess I try to make Claude be honest and kind.

Zack

Yeah. My name is Zach Witten. I'm a prompt engineer at Anthropic. Alex and I always argue about who the first one was. He says it's him. It's me. Contested. Yeah. I used to work a lot with individual customers, kind of the same way David does now. And then as we brought more solutions architects to the team, I started working on things that are meant to raise the overall levels of ambient prompting in society, I guess, like the prompt generator and the various educational materials that people use.

我是 Amanda Askell。在 Anthropic，我负责领导一个微调（fine tuning）团队，我们的目标是让 Claude 在交互中更加诚实和友善。

我叫 Zach Witten，是 Anthropic 的一名提示工程师（prompt engineer）。关于谁是公司第一位提示工程师，Alex 和我一直有争议。他说是他，但我认为是我。这个问题至今仍有争议。我以前的工作主要是与个别客户直接合作，有点类似 David 现在的工作。随着我们团队引入了更多的解决方案架构师，我的工作重心转向了一些能够提升整个社会的提示工程水平的项目。比如说，我们开发了提示生成器，还制作了各种教育材料，这些都是为了帮助人们更好地使用和理解 AI 提示技术。

Alex

Nice. Cool. Well, thanks guys for all coming here. I'm going to start with a very broad question, just so we have a frame going into the rest of our conversations here. What is prompt engineering? Why is it engineering? What's prompt, really? If anyone wants to kick that off, give your own perspective on it. Feel free to take the reign here.

好的，很棒。那么，首先感谢大家来到这里。我想先抛出一个非常宽泛的问题，这样可以为我们接下来的讨论定个基调。什么是提示工程（prompt engineering)？为什么我们把它称为「工程」？「提示」究竟是什么？如果有人想先开个头，分享一下自己的看法，请随意发言。

I feel like we have a prompt engineer. Yeah, exactly. That's his job. We're all prompt engineers in our own form. One of us has a job. Yeah, maybe since it's in your title. One of us has a job, but the other three don't have jobs.

我觉得我们当中有一位提示工程师（prompt engineer）。没错，就是这样。这就是他的工作。其实从某种角度来说，我们每个人都是自己的提示工程师。我们中间有一个人是专职做这个的。是啊，可能是因为你的头衔里就有这个职位。所以，我们四个人里，一个人有正式工作，另外三个人算是失业状态。

Zack

I guess I feel like prompt engineering is trying to get the model to do things, trying to bring the most out of the model, trying to work with the model to get things done that you wouldn't have been able to do otherwise. So a lot of it is just clear communicating. I think at heart, talking to a model is a lot like talking to a person and getting in there and understanding the psychology of the model, which Amanda is the world's most expert person in the world.

提示工程（prompt engineering）在我看来，是一种尝试引导模型完成任务的方法。它旨在充分挖掘模型的潜力，通过与模型的协作来完成一些原本难以实现的目标。这个过程的核心其实就是清晰有效的沟通。

从根本上说，与模型对话在很多方面类似于与人交流。这就需要我们深入理解模型的「思维方式」—— 尽管模型并没有真正的思维，但我们可以将其理解为模型对输入信息的处理和响应模式。在这个领域，Amanda 可以说是世界顶级的专家，她对模型的这种「思维方式」有着最深入的理解。

Alex

So, well, I'm going to keep going on you. Why is engineering in the name?

Zack

Yeah, I think the engineering part comes from the trial and error. Okay. So one really nice thing about talking to a model that's not like talking to a person is you have this restart button, this giant go back to square zero where you just start from the beginning. What that gives you the ability to do that you don't have is a truly start from scratch and try out different things in an independent way so that you don't have interference from one to the other. Once you have that ability to experiment and to design different things, that's where the engineering part has the potential to come in.

那么，让我继续追问你。为什么在名称中包含「工程学」这个词呢？

我认为，「工程学」这部分源于反复尝试和改进的过程。与人交谈不同，与模型对话有一个很大的优势，那就是你有一个「重启」按钮，可以让你随时回到起点，从头开始。这赋予了你一种特殊能力：你可以真正从零开始，独立尝试不同的方法，而不会受到之前尝试的影响。

一旦你具备了这种实验和设计不同方案的能力，「工程学」的潜力就开始显现了。你可以系统地设计、测试和优化各种方法，就像工程师解决复杂问题一样。这种方法论正是「工程学」在人工智能对话中发挥作用的地方。

Alex

Okay. So what you're saying is as you're writing these prompts, you're typing in a message to Claude or in the API or whatever it is, being able to go back and forth with the model and iterate on this message and revert back to the clean slate every time. That process is the engineering part. This whole thing is prompt engineering all in one. 

我明白了。你的意思是，在编写这些 AI 提示（prompts）时，你实际上是在与 Claude（一种 AI 助手）或通过应用程序接口（API）等方式与 AI 模型进行交互。这个过程允许你不断地与模型来回对话，逐步改进和完善你的提示。每次尝试时，你都可以从头开始，就像在一张白纸上重新书写。这种反复试验和优化的过程，正是提示工程（prompt engineering）的核心所在。

Zack

There's another aspect of it too, which is integrating the prompts within your system as a whole. And David has done a ton of work with customers integrating. A lot of times it's not just as simple as you write one prompt and you give it to the model and you're done. In fact, it's anything but. It's way more complicated.

提示工程（prompt engineering）是一个涵盖多个方面的综合过程。除了设计提示本身，还有一个重要的方面是如何将这些提示有效地整合到整个系统中。在这方面，David 在帮助客户进行系统整合时积累了丰富的经验。

需要注意的是，提示工程远非简单地编写一个提示然后输入模型就能完成的工作。事实上，这个过程往往比人们想象的要复杂得多。它涉及多个步骤和考虑因素，需要反复优化和调整才能达到理想的效果。

David

I kind of think of prompts as the way that you program models a little bit. That makes it too complicated because I think Zach is generally right that just talking clearly is the most important thing. But if you think about it a little bit as like programming a model, you have to like think about where data comes from, what data you have access to. So like if you're doing RAG or something, like what can I actually use and do and pass to a model? You have to like think about trade-offs in latency and how much data you're providing and things like that. Like there's enough systems thinking that goes into how you actually build around a model. I think a lot of that's also the core of why it maybe deserves its own carve-out as a thing to reason about separately from just a software engineer or a PM or something like that. It's kind of its own domain of how to reason about these models.

我倾向于将提示词（prompts）视为一种对模型进行编程的方式。这种说法可能有些复杂，因为我认为 Zach 的观点总体上是正确的：清晰表达才是最重要的。但是，如果你把它稍微看作是对模型编程，你就需要考虑数据的来源以及你可以访问哪些数据。

例如，如果你在进行检索增强生成（RAG，Retrieval-Augmented Generation）或类似的任务，你就需要思考实际上可以使用和传递给模型的内容。你还需要权衡延迟、提供的数据量等因素。这涉及到大量的系统性思考，关于如何实际构建模型周围的环境。

我认为这也是为什么提示词工程可能值得作为一个独立领域来研究的核心原因，而不仅仅是软件工程师或产品经理（PM）工作的一部分。它已经形成了自己的领域，专门研究如何思考和运用这些模型。

Alex

05.22min






Is a prompt in this sense then natural language code? Is it a higher level of abstraction? Or is it kind of a separate thing?

I think like trying to get too abstract with a prompt is a way to like overcomplicate a thing. Because I think, we're going to get into it, but more often than not the thing you want to do is just like write a very clear description of a task, not try to like build crazy abstractions or anything like that. Um, but that said, like you are compiling the set of instructions and things like that into outcomes a lot of times. And so precision and, and like a lot of the things you think about with programming about like version control and managing what it looked like back then when you had this experiment and, and like tracking your experiments and stuff like that. That's all just equally important to code. So it's weird to be in this paradigm where written text, like a nice essay that you wrote is something that's looked like the same thing as code. But it kind of is true that now we write essays and treat them like code. And I think that's actually correct.

那么，在这个语境下，提示词（prompt）是否可以被视为一种自然语言代码？它是一个更高层次的抽象吗？还是说它是一种完全独立的存在？

我认为，试图将提示词过度抽象化是一种使问题变得不必要复杂的方式。因为我们接下来要讨论的是，在大多数情况下，你真正需要做的只是写出一个非常清晰的任务描述，而不是尝试构建复杂的抽象概念或类似的东西。不过话说回来，你确实经常需要将一组指令和相关内容转化为具体的输出结果。因此，精确性以及你在编程中考虑的许多因素，比如版本控制、管理实验的历史记录、追踪实验过程等，对于提示词工程（prompt engineering）来说同样重要。

这就导致了一种奇特的现象：我们现在处于一个将书面文本（比如一篇精心撰写的文章）视为与代码等同的范式中。换句话说，我们现在写文章时会像对待代码一样对待它们。我认为这种观点实际上是正确的。

Yeah. Okay. Interesting. So maybe piggybacking off of that, we've kind of loosely defined what prompt engineering is. So what makes a good prompt engineer? Maybe Amanda, I'll go to you for this since you're trying to hire prompt engineers more so in a research setting what does that look like what are you looking for in that type of person?

好的，很有意思。那么，借着这个话题，我们刚才已经大致定义了什么是提示工程（prompt engineering）。那么，您觉得什么样的人才能成为一个优秀的提示工程师呢？Amanda，我想请你来回答这个问题。因为你正在尝试在研究环境中招聘提示工程师，你能告诉我们你在寻找什么样的人才吗？具体来说，你期望这类人具备哪些特质或技能？

Amanda:

Yeah good question uh i think it's a mix of like zach said sort of like clear communication so the ability to just like clearly state things like clearly understand tasks um think about and describe concepts really well that's like the kind of writing component, I think. I actually think that being a good writer is not as correlated with being a good prompt engineer as people might think. So I guess I've had this discussion with people because I think there's some argument is like, maybe you just shouldn't have the name engineer in there. Like, why isn't it just like writer? I used to be more sympathetic to that. And then I think now I'm like, what you're actually doing, like people think that you're writing like one thing and you're kind of like done. And then I'll be like, you know, to get like a semi-decent prompt, like when I sit down with the model, I'll like, you know, like earlier I was like prompting the model and I was just like in a 15-minute span, I'll be sending like hundreds of prompts to the model. It's just back and forth, back and forth, back and forth.

这确实是一个很好的问题。我认为这涉及多个方面，正如 Zach 所说，其中之一是清晰的沟通能力。这包括能够清楚地表达事物、准确理解任务，以及出色地思考和描述概念，这些构成了写作能力的核心。

不过，我实际上认为，成为一个优秀的写手与成为一个出色的提示工程师（prompt engineer）之间的关联性，可能并不像人们想象的那么强。我曾就此与他人进行过讨论，因为有人认为，也许我们根本不应该在这个职称中使用「工程师」这个词。比如，为什么不直接称之为「写手」呢？我以前对这种观点还比较认同。

但现在我的看法有所改变。人们可能认为提示工程只是写一个东西就完事了。然而事实上，要得到一个勉强可用的提示，当我坐在模型前工作时，就像早些时候我给模型做提示那样，在短短 15 分钟内，我可能会向模型发送数百个提示。这个过程就是不断地来回迭代，反复调整。

And so I think it's this like willingness to like iterate and to like look and think what is it that like was misinterpreted here if anything and then fix that thing so that ability to kind of like iterate so I'd say clear communication that ability to iterate I think also thinking about ways in which your prompt might go wrong. So if you have a prompt that you're going to be applying to like say 400 cases, it's really easy to think about the typical case that it's going to be applied to, to see that it gets the right solution in that case and then to like move on. I think this is a very classic mistake that people made. What you actually want to do is like find the cases where it's unusual. So you have to think about your prompt and be like, what are the cases where it would be really unclear to me what I should do in this case?

因此，我认为关键在于愿意不断优化，并仔细观察和思考是否存在任何误解，如果有的话，就要找出并修正。这种持续改进的能力非常重要。我要强调的是，清晰的沟通能力和不断优化的能力都很关键。此外，还要考虑到你的提示（prompt）可能出错的各种情况。

假设你有一个需要应用到 400 个案例的提示，人们很容易只考虑典型案例，看到它在常规情况下能得到正确的解决方案就满足了。我认为这是人们常犯的一个典型错误。你真正应该做的是找出那些不寻常的案例。因此，你必须仔细思考你的提示，并问自己：在哪些情况下，我会对应该如何处理感到非常困惑？

So for example, you have a prompt that says, I'm going to send you a bunch of data. I want you to extract all of the rows where someone's name is, I don't know, starts with the letter J. And then you're like, well, I'm going to send it a data set where there is no such thing. There is no such name that starts with the letter J. I'm going to send it something that's not a data set. I might also just send it an empty string. These are all of the cases you have to try because then you're like, what does it do in these cases? And then you can give it more instructions for how it should deal with that case.

举个例子，假设你有一个提示（prompt），内容是：「我将向你发送一批数据。我希望你提取所有名字以字母 J 开头的行。」然后，你可能会考虑以下几种情况来测试模型的反应：

1. 发送一个不包含任何以字母 J 开头的名字的数据集。
2. 发送一些完全不符合数据集格式的内容。
3. 甚至可能只发送一个空字符串。

这些都是你需要尝试的测试用例，因为你需要了解模型在这些边界情况下的表现。通过观察模型的反应，你可以进一步为模型提供更详细的指令，指导它如何正确处理这些特殊情况。

I work with customers so often where you're an engineer, you're building something, and there's a part in your prompt where a customer of theirs is going to write something. Yeah. And they all think about these really perfectly phrased things that they think someone's going to type into their chatbot. In reality, it's like they never used the shift key and every other word is a typo. They think it's Google. And there's no punctuation. They just put in random words with no question. So you have these evals that are these beautifully structured, what their users ideally would type in, but being able to go the next step to reason about what your actual traffic's going to be like, what people are actually going to try to do. That's a different level of thinking.

我经常与客户合作，特别是在开发聊天机器人时，会遇到这样的情况：作为工程师，你正在构建一个系统，其中有一部分需要模拟客户的输入。有趣的是，开发者往往会设想用户会输入措辞完美、结构清晰的句子。然而，现实情况往往大相径庭。

实际上，用户的输入通常是这样的：他们可能从不使用大写字母（就像没用过键盘上的 Shift 键一样），每隔几个单词就有一个拼写错误。有些用户甚至把聊天机器人当成了 Google 搜索引擎。他们的输入常常没有标点符号，只是随意堆砌一些单词，甚至没有形成一个完整的问题。

因此，虽然我们在评估系统时会使用那些结构完美、理想化的用户输入，但真正的挑战在于如何应对实际情况。我们需要思考的是：真实的用户流量会是什么样子？用户实际上会尝试做什么？能够考虑到这些因素，并据此优化系统，这才是更高层次的思考。这需要我们跳出理想化的测试场景，真正理解和适应用户的实际使用行为。

One thing you said that really resonated with me is reading the model responses. In a machine learning context, you're supposed to look at the data. It's almost a cliche, look at your data. And I feel like the equivalent for prompting is look at the model outputs. Just reading a lot of outputs and reading them closely. Dave and I were talking on the way here. One thing that people will do is they'll think step by step in their prompt. And they won't check to make sure that the model is actually thinking step by step. Because the model might take it in a more abstract or general sense rather than like, no, literally you have to write down your thoughts in these specific tags. So yeah, if you aren't reading the model outputs, you might not even notice that it's making that mistake.

你提到的一个让我深有共鸣的观点是关于阅读模型响应的重要性。在机器学习领域，「仔细查看数据」几乎已经成为一条金科玉律。我认为，在提示工程（prompting）中，与之相对应的原则就是仔细观察模型（model）的输出。这意味着我们需要阅读大量的输出结果，并且要深入细致地分析它们。

在来这里的路上，我和 Dave 讨论了一个有趣的现象。人们在设计提示时，常常会在提示中加入「逐步思考」的指令。然而，他们往往忽略了检查模型是否真的按照指示逐步思考。这是因为模型可能会以更抽象或泛化的方式理解这个指令，而不是严格按照要求在特定的标记（tag）中一步步写下思考过程。

因此，如果你不仔细阅读模型的输出，你可能甚至不会注意到模型在这方面的偏差。这再次强调了仔细分析模型输出的重要性，它能帮助我们更好地理解和改进我们的提示策略。

Yeah, that's interesting. There is that kind of weird theory of mind piece to being a prompt engineer where you have to think almost about how the model is going to view your instructions. But then if you're writing for an enterprise use case too, you have to think about how the user is going to talk to the model as you're the third party sitting there in that weird relationship.

确实，这个观点很有意思。作为一名提示工程师（prompt engineer），你需要具备一种特殊的能力，这种能力有点像心理学中的「心智理论」—— 你需要设身处地地思考 AI 模型会如何理解和处理你给出的指令。这个过程本身就很有挑战性。

但是，如果你是在为企业客户设计 AI 应用，情况就更复杂了。因为这时你不仅要考虑 AI 模型的反应，还要预测最终用户会如何与 AI 系统进行交互。在这个过程中，你就像是 standing 在用户和 AI 模型之间的第三方，需要协调两边的「对话」，确保整个交互过程顺畅有效。

这种三方关系确实有些特别，因为你需要同时理解和平衡技术（AI 模型）和人类（最终用户）的需求，这无疑增加了提示工程的复杂性和挑战性。

On the theory of mind piece, one thing I would say is it's so hard to write instructions down for a task. It's so hard to untangle in your own brain all of the stuff that you know that Quad does not know and write it down. It's just an immensely challenging thing to strip away all of the assumptions you have and be able to very clearly communicate the full fact set of information that is needed to a model. I think that's another thing that really differentiates a good prompt engineer from a bad one. A lot of people will just write down the things they know, but they don't really take the time to systematically break out what is the actual full set of information you need to know to understand this task. And that's a very clear thing I see a lot is prompts where it's just like it's conditioned. The prompt that someone wrote is so conditioned on their prior understanding of a task that when they show it to me, I'm like, this makes no sense. None of the words you wrote make any sense because I don't know anything about your interesting use case. But I think a good way to think about prompt engineering in that front and a good skill for it is just can you actually step back from what you know and communicate to this weird system that knows a lot but not everything about what it needs to know to do a task.

在心智理论（theory of mind）方面，我想说的是，为一项任务编写指令是极其困难的。要在自己的大脑中梳理出你知道而 AI 模型不知道的所有信息，并将其写下来，这是一个巨大的挑战。剥离所有的假设，并能够清晰地向模型传达完成任务所需的全部事实信息，这个过程尤其具有挑战性。

我认为，这是区分优秀提示工程师（prompt engineer）和普通提示工程师的另一个关键因素。很多人只是简单地写下他们知道的内容，但他们并没有真正花时间系统地分解出理解任务所需的完整信息集。这是我经常观察到的一个明显问题：人们编写的提示往往过于依赖于他们对任务的先验理解。

当这些人向我展示他们的提示时，我常常感到困惑。因为我对他们特定的用例一无所知，所以他们写的内容对我来说毫无意义。因此，在提示工程方面，一个好的方法和技能是：你是否能够跳出自己的认知框架，与这个知识广博但并非无所不知的 AI 系统进行有效沟通，告诉它完成任务所需要了解的关键信息。

这种能力 —— 即能够退一步，从 AI 的角度思考问题，并清晰地传达必要信息 —— 是优秀提示工程的核心所在。它要求我们不仅要理解任务本身，还要理解 AI 模型的特性和局限性，从而编写出更加有效和精确的提示。

Yeah, the amount of times I've seen someone's prompt and then being like, I can't do the task based on this prompt and like I'm human level and you're giving this to something that is worse than me And expecting it to do better and i'm like, yeah Yeah, there is that interesting thing with like I mean current, you know current models Don't really do a good job of asking good probing questions in response like a human would yeah If I'm giving exact directions on how to do something, he'll be like, this doesn't make any sense. What am I supposed to do at this step or here and here? Model doesn't do that, right? So you have to, as yourself, think through what that other person would say and then go back to your prompt and answer those questions.

确实，我经常看到有人写的提示词（prompt），然后我就想：「就连我这个人类都无法根据这个提示词完成任务，你却把它给了一个能力不如人类的 AI，还期望它能做得更好？」这种情况实在太常见了。

有一个有趣的现象值得注意，那就是目前的 AI 模型在应对模糊指令时，并不擅长像人类那样提出好的探索性问题（probing questions）。比如，如果我给人类一个含糊不清的指示，他们可能会说：「这说明不够清楚，我在这一步应该怎么做？这里和那里又该怎么处理？」但 AI 模型却不会这样做。

因此，在编写提示词时，你需要设身处地地思考：如果是另一个人收到这个指令，他们可能会问什么问题？然后，你要回到你的提示词，预先回答这些可能出现的问题，使指令更加清晰和完整。这样做可以大大提高 AI 完成任务的成功率。

You could ask it to do that. I guess that's another step. I was going to say, one of the first things I do with my initial prompt is I'll give it the prompt and then I'll be like, I don't want you to follow these instructions. I just want you to tell me the ways in which they're unclear or any ambiguities or anything you don't understand. And it doesn't always get it perfect, but it is interesting that that is one thing you can do. And then also sometimes if people see that the model makes a mistake, the thing that they don't often do is just ask the model. So they say to the model, you got this wrong. Like, can you think about why? And can you maybe like write an edited version of my instructions that would make you not get it wrong? And a lot of the time, like the model just gets it right. The model's like, oh yeah, here's what was unclear. Here's like a fix to the instructions. And then you put those in and it works.

在与 AI 模型交互时，有一个有趣的策略你可以尝试。这是我在给出初始提示（initial prompt）后常做的事情。我会告诉 AI 模型：「我不希望你立即执行这些指令。相反，我想让你指出这些指令中不清楚、模糊或你不理解的地方。」虽然 AI 模型并不总能完美地完成这个任务，但这确实是一个值得尝试的方法。

另外，当人们发现 AI 模型犯错时，他们往往忽略了一个简单但有效的做法：直接询问模型本身。你可以对模型说：「你在这里犯了一个错误。你能分析一下原因吗？能不能重新编写一个修改版的指令，以避免这个错误？」令人惊讶的是，很多时候 AI 模型能够准确地识别问题所在。它可能会回答：「确实，这里有一些不清楚的地方。这是对指令的一些修改建议。」然后，当你将这些修改后的指令输入时，AI 模型通常就能正确执行任务了。

这种方法不仅能帮助我们更好地理解 AI 模型的思维过程，还能帮助我们改进我们与 AI 交互的方式。通过这种反馈循环，我们可以逐步优化我们的提示和指令，从而获得更好的 AI 输出结果。

Okay. I'm actually really curious about this personally almost. Is that true that that works? Like, does the model, is the almost. Is that true that that works? Like, is the model able to spot its mistakes that way? Like, when it gets something wrong, you say, like, why did you get this wrong? And then it tells you maybe something like, okay, how could I phrase this to you in the future so you get it right? Is there an element of, like, truth to that? Or is that just kind of a hallucination on the model's part around what it thinks its limits are?

说实话，我个人对这个问题非常感兴趣。这种方法真的有效吗？模型真的能够通过这种方式识别自己的错误吗？比如，当模型犯错时，如果你问它「为什么会出这个错」，它是否能够回答类似「我以后应该如何向你表述这个问题，以确保得到正确的回答」这样的内容？这种方法中是否包含一些真实可靠的成分？还是说这只是模型对其自身局限性的一种「幻觉」（hallucination)？

I think if you explain to it what it got wrong, it can identify things in the query sometimes. I think this varies by task. This is one of those things where I'm like, I'm not sure what percentage of the time it gets it right, but I always try it because sometimes it does.

我认为，如果你向人工智能解释它的错误所在，有时它就能识别出查询中的问题。这种能力在不同任务中表现各异。对于这类情况，我难以确定 AI 能正确完成的准确比例，但我总是会尝试，因为有时它确实能够成功。

Yeah. You learn something.

Yeah. Anytime you go back to the model or back and forth with the model, you learn something about what's going on. I think you're giving away information if you don't at least try.

确实如此。这个过程中你总能学到一些东西。

没错，每次你重新使用模型或与模型进行反复交互时，你都能对正在发生的事情有新的认识。我认为，如果你不尝试与模型多做互动，就可能会错过获取有价值信息的机会。

That's interesting. Amanda, I'm going to keep asking you a few more questions here. One thing maybe for everybody watching this is we have these Slack channels at Anthropic where people can add Claude into the Slack channel, then you can talk to Claude into the Slack channel. Then you can talk to Claude through it. And Amanda has a Slack channel that a lot of people follow of her interactions with Claude. And one thing that I see you always do in there, which you probably do the most of anyone at Anthropic, is use the model to help you in a variety of different scenarios. I think you put a lot of trust into like the model in like the research setting. Curious how you've like developed those intuitions for when to trust the model. Is that just a matter of like usage experience or is it something else?

这很有意思。Amanda，我想再问你几个问题。对于所有正在看这个的人来说，我们在 Anthropic 有一些 Slack 频道，人们可以把 Claude 添加到这些频道里，然后就能通过 Slack 与 Claude 交谈。Amanda 有一个很多人关注的 Slack 频道，里面记录了她与 Claude 的互动。我注意到你经常在那里做的一件事，可能是 Anthropic 所有人中做得最多的，就是在各种不同的场景中利用模型来帮助你。我觉得你在研究环境中非常信任这个模型。我很好奇你是如何培养出这种判断何时可以信任模型的直觉的。这只是使用经验的积累，还是有其他原因呢？

Amanda:

I think I don't trust the model ever and then I just hammer on it. So I think the reason why you see me do that a lot is that that is like me being like, can I trust you to do this task? Because there's some things, you know, models are kind of strange if you go slightly out of distribution, like, you know, like you just go into areas where they haven't been trained or they're kind of unusual. Sometimes you're like, oh, actually, you're much less reliable here, even though it's a fairly like simple task. I think that's happening less and less over time as models get better, but you want to make sure you're not in that kind of space.

我认为我一直对模型持怀疑态度，所以会不断地测试它。你可能经常看到我这样做，其实这就像是我在问：「我能信任你完成这个任务吗？」因为在某些情况下，你知道，AI 模型会表现得有些奇怪。特别是当你稍微偏离它们的训练范围时，比如进入一些它们没有接触过或比较罕见的领域，你可能会发现模型的可靠性突然大幅下降，即使面对的是一个看似简单的任务。

我认为，随着时间推移和模型性能的提升，这种情况正在变得越来越少见。但是，你仍然需要确保自己没有无意间进入这种模型表现不稳定的「危险区域」。

这里的「模型」指的是人工智能系统，特别是像大语言模型（Large Language Model）这样的 AI 模型。「分布」则是指模型训练数据的统计分布，超出这个分布范围就意味着进入了模型不熟悉的领域。通过不断测试和质疑模型的能力，我们可以更好地理解它的局限性，从而更安全、更有效地使用这些 AI 工具。

So yeah, I don't think I trust it by default, but I think in ML, people often want to look across really large data sets. And I'm like, when does it make sense to do that? And I think the answer is when you get relatively low signal from each data point, you want to look across many, many data points because you basically want to get rid of the noise. With a lot of prompting tasks, I think you actually get really high signal from each query. And so if you have a really well-constructed set of a few hundred prompts, that I think can be much more signal than thousands that aren't as well-crafted. And so I think, I do think that I can trust the model if I look at a hundred outputs of it and it's really consistent. And I know that I've constructed those to basically figure out all of the edge cases and all of the weird things that the model might do, strange inputs, etc. I trust that probably more than a much more loosely constructed set of several thousand.

在机器学习领域，研究人员常常倾向于分析大规模数据集。然而，我们需要思考的是：在什么情况下这种做法是合理的？我认为，当每个数据点提供的信息量（信号，signal）相对较低时，我们就需要分析大量数据点来降低噪声的影响。

但在许多涉及 AI 提示（prompt）的任务中，情况却不尽相同。在这些任务中，每个查询往往能提供大量有价值的信息。因此，如果我们精心设计了几百个高质量的提示，它们可能比数千个构思不够周密的提示提供更多有用的信息。

基于这一认识，如果我观察到模型在面对一百个精心设计的输入时能够保持高度一致的表现，我会更倾向于信任这个模型。这是因为我在设计这些提示时，已经考虑到了各种边界条件（edge cases）、可能出现的异常行为，以及各种非常规输入等因素。相比之下，我可能不会那么信任一个基于几千个松散构建的提示所得出的结果。

这种方法强调了质量 over 数量的重要性，特别是在评估人工智能模型的性能时。通过仔细设计的测试案例，我们可以更有效地探索模型的能力和局限性，而不必总是依赖于海量但可能质量参差不齐的数据。

I think in ML, a lot of times the signals are like numbers, you know, like did you predict this thing right or not? And it'd be like kind of like looking at the log probes of a model and trying to like intuit things, which you can do, but it's like kind of sketchy. I feel like the fact that models output more often than not, like a lot of stuff, like words and things, like there's just fundamentally so much to learn between the lines of what it's writing and why and how. That's part of what it is. It's not just did it get the task right or not. It's how did it get there? How was it thinking about it? What steps did it go through? You learn a lot about what is going on, or at least you can try to get a better sense, I think. But that's where a lot of information comes from to me is like by reading the details of what came out, not just sort of the result.

在机器学习（Machine Learning）领域，我们经常面对的是数字化的信号，比如模型是否正确预测了某个结果。这就像我们在查看模型的对数概率（log probabilities）并试图凭直觉理解一些东西。虽然这种方法可行，但往往不够可靠和深入。

然而，我认为机器学习模型的输出通常不仅仅是简单的结果，而是包含了大量丰富的信息，如文字和其他形式的数据。在这些输出的字里行间，蕴含着大量值得我们学习和探索的信息，包括模型是如何得出结果的，它的思考过程是什么，以及它经历了哪些步骤。

这种深入分析不仅仅关注模型是否完成了任务，更重要的是理解模型达成目标的过程。通过这种方式，我们可以更好地了解模型内部的运作机制，或者至少可以尝试获得更深入的洞察。

对我来说，大量有价值的信息来自于仔细阅读和分析模型输出的细节，而不仅仅是关注最终结果。这种方法能够帮助我们更全面地理解模型的行为和能力，从而推动机器学习领域的进步。

I think also the very best of prompting can kind of make the difference between a failed and a successful experiment. So sometimes I can get annoyed if people don't focus enough on the prompting component of their experiment because I'm like, this can in fact be like the difference between like one percent performance in the model or 0.1 percent um in such a way that your experiment doesn't succeed if it's a top five percent model performance but it does succeed if it's a top one one percent or top 0.1 percent and then I'm like if you're going to spend time over like coding your experiment really nicely but then just like not spend time on the prompt that doesn't I't know, that doesn't make sense to me. Because I'm like, that can be the difference between life and death of your experiment.

我认为，优秀的提示工程（prompting）确实可能成为实验成功与失败的关键因素。因此，当人们在实验中没有足够重视提示工程这一环节时，我有时会感到不满。因为在我看来，这实际上可能导致模型性能产生 1% 甚至 0.1% 的差异，而这种差异可能意味着：如果模型性能只达到前 5%，你的实验可能无法成功；但如果达到前 1% 或前 0.1%，实验就可能成功。

基于这种认识，我觉得如果研究者花费大量时间精心编写实验代码，却不在提示工程上投入同等精力，这种做法似乎不太合理。因为在我看来，提示工程的质量可能是决定实验成败的关键因素。

在人工智能（AI）研究中，尤其是在使用大语言模型（Large Language Models，LLMs）进行实验时，提示工程的重要性不容忽视。它不仅影响模型的输出质量，还可能对整个实验的有效性产生重大影响。因此，在设计和执行 AI 实验时，我们应该平衡地关注各个环节，包括代码质量、数据处理以及提示工程，以确保实验的整体成功。

Yeah. And with the deployment too.

Yeah. It's so easy to, oh, we can't ship this. And then you change the prompt around and suddenly it's working.

是啊。部署（deployment）也是这样。

没错。太常见了，你会想「哎呀，这个没法发布」。结果呢，调整一下提示（prompt），它就突然能用了。

Yeah. It's a bit of a double edged sword though, because I feel feel like there's a little bit of prompting where there's always this mythical better prompt that's going to solve my thing on the horizon. I see a lot of people get stuck in the mythical prompt on the horizon that if I just keep grinding, keep grinding. It's never bad to grind a little bit on prompt. As we've talked, you learn things, but it's one of the scary things about prompting is that there's this whole world of unknown. What heuristics do you guys have for like when something like is possible versus like not possible with the perfect prompt, whatever that might be?

确实如此。不过这其实是一把双刃剑。因为在提示工程（prompting）这个领域，人们总是觉得在远处有一个更好的、能解决所有问题的「神奇提示」。我看到很多人陷入了这种幻想中，认为只要不断努力，就一定能找到那个完美的提示。

当然，在提示方面多下些功夫并不是坏事。正如我们讨论过的，你确实能从中学到东西。但提示工程令人困扰的一点是，它似乎存在着一个未知的广阔天地。

那么，你们有什么经验之谈可以帮助判断某个任务是否真的可以通过「完美提示」来实现呢？换句话说，如何区分哪些是通过优化提示就能做到的，哪些是无论如何优化提示也无法实现的呢？

I think I'm usually checking for whether the model kind of gets it. So I think for things where I just don't think a prompt is going to help, there is a little bit of grinding, but often it just becomes really clear that it's not close or something. I think that if, yeah, I don't know if that's a weird one where I'm just like, yeah. If the model just clearly can't do something, I won't grind on it for too long.

我通常会检查人工智能模型（AI model）是否大致理解了任务。对于那些我认为仅靠调整提示（prompt）无法改善的情况，可能需要一些反复尝试。但通常很快就能清楚地看出模型是否接近了目标或完全偏离了方向。

是的，我不确定这是否听起来有点奇怪，但事实就是如此。如果模型明显无法完成某项任务，我不会在上面花费太多时间反复尝试。

This is where you can evoke how it's thinking about it and you can ask it how it's thinking about it and why, and you can kind of get a sense of like, is it thinking about it right? Are we even in the right zip code of this being right? And you can get a little bit of a kneeling on that front of like, at least I feel like I'm making progress towards getting something closer to right. Where there's just some tasks where you really don't get anywhere closer to like it's thought process just like every tweak you make just like veers off in a completely different very wrong direction and i just tend to abandon those i don't know those are so rare now though and i get really angry at the model when i discover them because i'm that's how rare they are i get furious i'm like how dare there be a task that you can't just do if I just push you in the right direction.

在这个阶段，你可以探索模型是如何思考的，询问它的思考过程和原因。这样，你就能大致判断它是否在正确地思考，我们是否至少朝着正确的方向前进。你可能会对模型的思维过程有一些初步的了解，至少我感觉自己正在逐步接近正确的答案。

然而，有些任务却让人感到束手无策。无论如何调整，模型的思路似乎总是偏离正轨，朝着完全错误的方向发展。面对这种情况，我通常会选择放弃。不过，值得庆幸的是，这种情况现在变得非常罕见。正因为如此，当我偶然遇到这类问题时，我会感到异常愤怒。我会想：「怎么可能还有任务是我无法通过适当引导就让你完成的？」

（注：文中的「微调」（tweak）指的是对模型输入或参数进行细微调整的过程。）

Yeah. I had my thing with Claude plays Pokemon recently. And that was, like, one of the rare times where I've really...

Can you explain that? Explain that just for people? I think that's really cool.

I did, like, a bit of an experiment where I, like, hooked Claude up to a Game Boy emulator and, like, tried to have it play the game Pokemon Red, like the OG Pokemon. And it's, like, you know, think what you want to do, and it could write some code to press buttons and stuff like that. Pretty basic. And I tried a bunch of different very complex prompting layouts, but you just get into certain spots where it just really couldn't do it. So showing it a screenshot of a Game Boy, it just really couldn't do it. And it just like so deeply, because I'm so used to it being like able to do something mostly. And it's so, and I spent like a whole weekend trying to write better and better prompts to get it to like really understand this Game Boy screen. And I got like incrementally better so that it was only terrible instead of completely no signal.

我做了一个小实验，我把 Claude（一种 AI 助手）连接到了一个 Game Boy 模拟器上，试图让它玩《口袋妖怪红版》这款游戏，也就是最初代的口袋妖怪游戏。它能够思考下一步行动，然后编写一些代码来模拟按按钮之类的操作。说实话，这还算是相当基础的操作。我尝试了各种复杂的提示方法，但在某些情况下，它还是无法应对。特别是当我给它展示 Game Boy 的屏幕截图时，它就完全无法理解了。这让我感到非常沮丧，因为我已经习惯了它能够或多或少地完成大部分任务。我花了整整一个周末的时间，不断优化提示，试图让它真正理解 Game Boy 的屏幕。虽然我确实取得了一些进展，但也仅仅是从「完全没有反应」提升到了「勉强可用」的程度而已。

You could get from no signal to some signal.

But it was like, I don't know, at least this was elicited for me. Once I put a weekend of time in and I got from no signal to some signal, but nowhere close to good enough, I'm like, I'm just going to wait for the next one. I'm just going to wait for another model. I could grind on this for four months and the thing that would come out is another model and that's a better use of my time to just sit and wait to do something else in the meanwhile.

你可以从毫无进展到略有成效。

但是，至少对我来说，这种体验是这样的：我投入了一个周末的时间，确实从毫无进展到略有成效，但离理想状态还差得远。这时我就想，不如等待下一个模型发布。我可能需要在当前模型上花费四个月的时间钻研，但最终的结果可能只是另一个稍有改进的模型。相比之下，把时间用于等待新模型发布，同时去做些其他事情，可能是更明智的选择。

I mean, that's an inherent tension we see all the time and maybe we can get to that in a sec, Zach, if you want to go.

Something I liked about your prompt with Pokemon where you got the best that you did get was the way that you explained to the model that it is in the middle of this Pokemon game and here's how the things are going to be represented. I think you actually represented it in two different ways, right?

我的意思是，这是我们经常遇到的一个固有的问题，也许我们可以待会儿再讨论这个，Zach，如果你想说点什么的话。

说到你那个关于宝可梦（Pokemon）的提示，我特别喜欢你最终得到的那个最好的结果。你向 AI 模型解释了它正身处一个宝可梦游戏的场景中，还说明了游戏中的各种元素是如何呈现的。如果我没记错的话，你还用了两种不同的方式来描述这个场景，对吧？

I did. So what I ended up doing, it was obnoxious, but I superimposed a grid over the image. And then I had it describe each segment of the grid in visual detail. And then I had it reconstruct that into an ASCII map. And I gave it as much detail as I could. The player character is always at location 4, 5 on the grid and stuff like that. And you can slowly build up information. I think it's actually a lot like prompting, but I just hadn't done it with images before where like sometimes my like intuition for what you need to tell a model about text is a lot different from what you need to tell a model about images.

我确实做到了。我最终采用的方法虽然有些繁琐，但很有效：我在图像上覆盖了一个网格。然后，我让 AI 详细描述网格的每个区段。接着，我让它将这些描述重构成一个 ASCII 码格式的地图（一种用文本字符绘制的简单地图）。我尽可能地提供了大量细节，比如玩家角色始终位于网格的第 4 行第 5 列这样的信息。通过这种方法，你可以逐步构建起完整的图像信息。

我觉得这个过程其实很像在进行提示工程（prompting），只是我之前从未在图像处理中应用过这种方法。我意识到，我对于如何向模型描述文本信息的直觉，与如何向模型描述图像信息的方法有很大的不同。这次尝试让我对 AI 处理不同类型信息的方式有了新的认识。

Yeah. And so I found a surprisingly small number of my intuitions about text have transferred to image.

Yeah. Like I found that like multi-shot prompting is not as effective for images and text. I'm not really sure. You can have theoretical explanations about why. Maybe there's fewer of it in the training data, fewer examples of that.

是的。我发现令人惊讶的是，我在文本领域的很多直觉并不能直接应用到图像领域。

确实如此。例如，我发现多次提示（multi-shot prompting）在处理图像时并不像处理文本时那样有效。具体原因我还不太确定。当然，我们可以尝试从理论角度进行一些解释。一种可能的解释是，在训练数据中，包含多次提示的图像样例可能比文本样例要少得多。

Yeah, I know when we were doing the original explorations with prompting multimodal, we really couldn't get it to noticeably work. You just can't seem to improve Claude's actual visual acuity in terms of what it picks up within an image. If anyone here has any ways that they've not seen that feature. But it seems like that's kind of similar with the Pokemon thing where it's trying to interpret this thing. No matter how much you throw prompts at it, it just won't pick up that Ash is in that location.

没错，我记得当我们最初尝试对多模态系统（multimodal system）进行提示探索时，真的很难看到明显的效果。无论怎么努力，似乎都无法提高 Claude（一种 AI 助手）在图像内容识别方面的实际能力。如果在座的各位有什么方法能改变这一点，我倒是很想听听，因为我还没见过这种突破性的功能。

这种情况有点类似于之前我们讨论的宝可梦（Pokemon）的例子，AI 在试图理解图像内容时遇到了困难。不管你怎么调整提示，用尽各种方法，它就是无法识别出小智（Ash）在图中的具体位置。这看起来是个共同的难题。

I guess I'd like to be visceral about this. I could eventually get it so that it could like most often tell me where a wall was. Yeah. And most often tell me where the character was. It'd be off by a little bit. But like then you get to a point and this is maybe coming back to like knowing when you can't do it. Like it would describe an NPC and to play a game well, like you need to have like some sense of continuity. Like have I talked to this NPC before? Right. And without that, like you really don't, there's nothing you can do. You're just going to keep talking to the NPC because like, well, maybe this is a different NPC.

让我坦率地说说我的想法。在开发这个系统的过程中，我可能最终能够让它在大多数情况下告诉我游戏中墙壁的位置。没错，它也能大多数时候准确地指出角色的位置，尽管可能会有一些小误差。

但是，当我们继续深入时，我们可能会遇到一个问题，这让我想到了知道系统局限性的重要性。比如，系统可以描述一个 NPC（非玩家角色），但要想真正玩好游戏，你需要有一种连续性的感觉。举个例子，你需要知道「我之前是否与这个 NPC 交谈过？」对吧？

如果没有这种连续性的感觉，你实际上什么都做不了。你可能会一直重复与同一个 NPC 对话，因为你无法确定这是不是一个新的、不同的 NPC。这就会导致游戏体验变得混乱和重复。

But like, I would try very hard to get it to describe an NPC. And it's like, it's a person. They might be wearing a hat. They weren't wearing a hat. And it's like, you grind for a while, like inflate it to 3000x and crop it to just the NPC. And it it's like I have no idea what this is and it's like I ground like I showed it this like Clear female NPC thing enough times and it just got nowhere close to it. It's like yeah That's just this is a complete lost cause.

我曾尝试让 AI 系统描述一个 NPC（非玩家角色）。这个过程就像是在描述一个人：他们可能戴着帽子，也可能没戴。为了得到更好的结果，我付出了很多努力，比如将图像放大 3000 倍，然后裁剪只保留 NPC 的部分。

然而，即使经过这些处理，AI 系统仍然无法准确识别图像内容。我反复向系统展示清晰的女性 NPC 图像，但结果却远远不如预期。最终，我不得不承认这次尝试完全失败了。

这个经历让我意识到，在某些特定任务上，当前的 AI 系统可能还存在明显的局限性。尽管我们在训练过程中投入了大量时间和精力，但有时 AI 仍然无法达到我们的期望。这提醒我们，在使用和评估 AI 技术时，需要保持客观和理性的态度，认识到它们的能力边界。

Wow. Okay. I really want to try this now I'm just imagining all the things I would try like I don't know. I want you to imagine this game art as a real human and just describe to me what they're like. What do they look like as they look in the mirror? And then just see what happens.

这真是令人惊叹！我现在非常想尝试这种方法。我脑海中已经浮现出了许多可能的尝试方向。例如，我们可以做这样一个有趣的实验：请你想象一下游戏中的艺术形象是一个真实存在的人。你能否描述一下这个人的样子？当他们站在镜子前，会看到什么？让我们一起来探索这个想象的结果，看看会有什么有趣的发现。

I tried a lot of things. The eventual prompt was telling Quad it was a screen reader for a blind person, which I don't know if that helped, but it felt right. So I kind of stuck with that.

我尝试了许多不同的方法。最终，我决定告诉 Quad （可能是一个 AI 系统的名称）它是一个为视障人士设计的屏幕阅读器（一种将屏幕上的文字转换为语音的辅助技术）。虽然我不确定这种方法是否真的有效，但从直觉上来说，这似乎是一个正确的方向。因此，我选择继续沿用这种方法进行后续的实验和测试。

That's an interesting point. I actually want to go into this a little bit because this is one of the most famous prompting tips, right, is to tell the language model that they are some persona or some role. I feel like I see mixed results. Maybe this worked a little bit better in previous models and maybe not as much anymore. Amanda, I see you all the time be very honest with the model, like about the whole situation. Like, oh, I am an AI researcher and I'm doing this experiment. I'll tell it who I am.

这是一个很有意思的观点。实际上我想深入讨论一下这个问题，因为这是最著名的提示工程（prompting）技巧之一，对吧？就是告诉语言模型（language model）它们扮演某个角色或某种身份。我觉得这种方法的效果参半。也许这在早期的模型中效果更好一些，但现在可能不那么有效了。Amanda，我经常看到你对模型非常坦诚，会如实告知整个情况。比如，你会说「我是一个 AI 研究员，我正在进行这项实验」。你会告诉模型你的真实身份。

Yeah. I'll give it my name, be like, here's who you're talking to.

Right. Do you think that level of honesty, instead of like lying to the model or like forcing it to like, you know, I'm going to tip you $500. Is there one method that's preferred there or just what's your intuition on that?

嗯，没错。我会告诉它我的名字，让它知道它在和谁对话。

说到这个，你觉得这种诚实的方式好吗？比起对模型撒谎或者故意诱导它，比如说「我会给你 500 美元小费」之类的。你认为哪种方法更好？或者你对这个问题有什么看法？

Yeah, I think as models are more capable and understand more about the world, I guess I just don't see it as necessary to lie to them. I mean, I also don't like lying to the models just because, you know, I don't like lying generally. But part of me is like if you are say constructing it suppose you're constructing like an eval data set for a machine learning system or for a language model that's very different from like constructing a quiz for some children and so when people would do things like i am a teacher trying to figure out questions for a quiz i'm like the model knows what language model evals are. Like, you know, if you ask it about different evals, it can tell you and it can give you like made up examples of what they look like because these things are like, they understand them, they're on the internet.

我认为，随着模型变得更加强大并对世界有了更深入的理解，对它们隐瞒信息似乎已经没有必要了。坦白说，我一般不喜欢对任何对象说谎，这也包括对模型说谎。但我想强调的是，构建机器学习系统或语言模型的评估数据集（eval data set）与为儿童设计测验是完全不同的概念。

有时候，人们会假装自己是教师，声称在为测验准备问题。但实际上，模型已经充分了解什么是语言模型评估（language model evals）。如果你询问模型关于不同类型的评估，它不仅能够解释，还能给出看似真实的虚构例子。这是因为这些概念已经存在于互联网上，模型在训练过程中已经学习并理解了它们。

因此，在与先进的人工智能模型互动时，我们需要认识到它们的能力和知识范围，采取更加开放和诚实的方式来设计评估和交互。

And so I'm like, I'd much rather just target the actual task that I have. So if you're like, I want you to construct questions that look a lot like an evaluation of a language model. It's just like, it's that whole thing of clear communication. I'm like, that is in fact the task I want to do. So why would I pretend to you that I want to do some unrelated or only like tangentially related task and then expect you to somehow do better at the task that I actually want you to do? Like we don't do this with like employees. I wouldn't like go to someone that worked with me and be like, you are a teacher and you're trying to quiz your students. I'd be like, hey, are you making that eval? I don't know. So I think maybe it's like a heuristic from there where I'm like, if they understand the thing, just ask them to do the thing that you want.

因此，我更倾向于直接针对实际任务。假设你说，「我希望你构造一些看起来很像在评估语言模型的问题」。这其实就是关于清晰沟通的全部要点。我认为，这确实是我想要完成的任务。那么，为什么我要假装告诉你我想做一些不相关或只是略微相关的任务，然后期望你能在我真正想要你完成的任务上表现得更好呢？

我们在现实工作中也不会这样对待员工。我不会对一个同事说：「假设你是一位老师，正在给学生出测验题。」相反，我会直接说：「嘿，你在制作那个评估吗？」这种直接的方式更加有效。

我认为这可能是一种启发式策略（heuristic strategy）：如果他们理解任务，就直接让他们执行你想要的任务。这种方法可以避免不必要的误解和复杂性，从而提高工作效率。

I see this so much. To push back a little bit, I have found cases where not exactly lying, but giving it a metaphor for how to think about it could help in the same way that sometimes I might not understand how to do something and someone's like, imagine that you were doing this, even though I know I'm not doing it. The one that comes to mind for me is I was trying to have Quad say whether an image of a chart or a graph is good or not. Is it high quality? The best prompt that I found for this was asking the model what grade it would give the chart if it were submitted as a high school assignment. It's not exactly saying, you are a high school teacher. It's more like, this is the kind of analysis that I'm looking for you. The scale that a teacher would use is similar to the scale that I want you to use.

在人工智能（AI）领域，我们经常遇到这样的情况。让我稍作解释，有时候给 AI 模型一个思考方式的比喻，虽然不是完全准确，但却能起到很好的效果。这就像有时候当我们不理解如何完成某项任务时，他人可能会说「想象你正在做这个」，尽管实际上我们并没有真的在做那件事，但这种比喻能帮助我们理解。

我想分享一个相关的例子。在我尝试让一个名为 Quad 的 AI 模型评估图表或图形图像质量的过程中，我发现了一个特别有效的提示方法。我询问模型：「如果这个图表是作为高中作业提交的，你会给它什么样的分数？」这个提示并不是在告诉 AI「你是一名高中教师」，而是在暗示：「我希望你用类似高中教师的标准来分析这个图表。」

这种方法之所以有效，是因为高中教师使用的评分标准与我们希望 AI 模型使用的标准非常相似。通过这种比喻，我们成功地引导了 AI 模型按照我们期望的方式进行分析和评估。

I think those metaphors are pretty hard to still come up with. The default you see all the time is finding some facsimile of the task, something that's a very similar-ish task, saying you're a teacher. And you actually just lose a lot in the nuance of what your product is. I see this so much in enterprise prompts where people write something similar because they have this intuition that it's something the model has seen more of maybe. It's seen more high school quizzes than it has LLM evals. And that may be true, but to your point, as the models get better, I think just trying to be very prescriptive about exactly the situation they're in I give people that advice all the time which isn't to say that I don't think like to the extent that it is true that like thinking about it the way that someone would grade a chart as like how they would grade a high school chart yeah maybe that's true but it's like awkwardly this shortcut people use a lot of times to try to get what happens.

我认为那些恰当的比喻仍然很难想出来。你经常看到的常见做法是寻找一个与任务非常相似的场景，比如说假设你是一名教师。但实际上，这样做会使你的产品失去很多细微的特点。我在企业提示（enterprise prompts）中经常看到这种情况，人们会写一些类似的内容，因为他们直觉认为模型可能见过更多这样的例子。比如，模型可能见过更多的高中测验题，而不是大语言模型（LLM）评估。这种想法可能是对的，但正如你所说，随着模型变得越来越强大，我认为我们应该非常明确地描述实际情况。我经常给人这样的建议。

这并不是说我认为将评估任务比作给高中图表打分是完全错误的。也许这种类比在某种程度上是恰当的，但它更像是人们经常使用的一种不太优雅的捷径，试图 achieve 想要的结果。然而，这种方法可能会忽视任务的独特性和复杂性。

So I'll try to like give someone that I can actually talk about, cuz I think it's somewhat interesting. So like, um, writing, you are like a helpful assistant writing a draft of a document, right? It's like, it's not quite what you are. Like you are in this product. So like, tell me if, if you're writing like an assistant that's in a product, like tell. You are in this product. So tell me, if you're writing an assistant that's in a product, tell me I'm in the product. Tell me I'm writing on behalf of this company. I'm embedded in this product. I'm the support chat window on that product. You're a language model. You're not a human. That's fine. But just being really prescriptive about the exact context about where something is being used.

让我试着给你一个我实际可以讨论的例子，因为我觉得这可能会比较有趣。比如说，嗯，写作，你就像是一个在起草文档的有帮助的助手，对吧？但这并不完全是你在这个产品中的角色。所以，如果你是在扮演一个集成在产品中的助手，你应该明确地告诉我。你应该说：「我是这个产品的一部分。我代表这家公司在写作。我被嵌入在这个产品中。我是这个产品的支持聊天窗口。」你是一个语言模型（language model），不是人类，这没问题。但重要的是要非常明确地描述你被使用的具体环境和背景。

But just being really prescriptive about the exact context about where something is being used. I found a lot of that because I guess my concern most often with role prompting is people use it as a shortcut of a similar task they want the model to do. And then they're surprised when Quad doesn't do their task right. But it's not the task. You told it to do some other task. And if you didn't give it the details about your task, I feel like you're leaving something on the table. So, yeah.

但关键是要非常明确地指出某个东西被使用的具体背景。我发现很多这样的情况，因为我猜我最担心的是人们使用角色提示（role prompting）时，常常把它当作一种快捷方式，来完成他们希望模型执行的类似任务。然后当模型没有正确完成他们的任务时，他们就感到惊讶。但问题是，那其实并不是你原本想要完成的任务。你告诉模型去做的是另一个任务。如果你没有向模型提供关于你实际任务的详细信息，我认为你可能错过了一些重要的东西。所以，准确描述任务背景真的很重要。

I don't know. It does feel like a thing, though, to your point of as the models scale. Like maybe in the past it was true that they only really had a strong understanding of elementary school tests comparatively. But as they get smarter and can differentiate more topics, I don't know, just like being clear.

说实话，我也不太确定。不过，正如你所说的，随着模型规模的扩大，确实感觉情况在发生变化。也许在过去，这些模型确实只能较好地理解小学水平的测试题。但是，随着它们变得越来越智能，能够辨别和处理更多不同的主题，情况似乎有所不同了。我的意思是，它们的能力似乎变得更加清晰和明确了。不过，这只是我的感觉，我还不能完全确定。

I find it interesting that I've like never used this prompting technique. Yeah, that's funny. Like even like with like worse models and I still just don't ever find myself. I don't know why. I'm just like I don't find it very good essentially.

我发现一个有趣的现象，那就是我似乎从未使用过这种提示技巧（prompting technique）。是的，这确实很有趣。即使在使用性能相对较差的模型时，我也发现自己不会去尝试这种方法。我不太清楚其中的原因。但总的来说，我就是觉得这种技巧效果不太理想。

Interesting. I feel like completion era models, like there was like a little bit of a mental model of conditioning the model into a latent space that was useful, that I worried about, that I don't really worry about too much. It may be intuitions from pre-trained models over to RLHFed models that to me just didn't make sense. It makes sense to me if you're prompting a pre-trained.

这很有趣。我认为，在完成式模型（completion era models）时代，人们会有一种微妙的心智模型，即将模型调节到一个有用的潜在空间（latent space）。这曾经是我担心的问题，但现在我已经不太在意了。我发现，有些人试图将预训练模型的直觉应用到经过强化学习人类反馈（RLHF，Reinforcement Learning from Human Feedback）的模型上，但在我看来这并不合理。当然，如果你是在对预训练模型进行提示（prompting），那么应用这些直觉还是有道理的。

But a lot of people would be amazed how many people try to apply. And I think it's not that surprising. Most people haven't really experimented with the full, what is a pre-trained model? What happens after you do SL? What happens after you do ROHF? Whatever. And so when I talk to customers, it's all the time that they're trying to map some amount of, oh, how much of this was on the internet? have they seen a ton of this on the internet like you just hear that intuition a lot and I think it's like well-founded fundamentally but it like is over applied uh by the time you actually get to a prompt because of what you said like by the time they've gone through all of this other stuff that's not actually quite what's being modeled yeah the first thing that I feel like you should try is, I mean, I used to give people this thought experiment where it's like, imagine you have this task, you've hired a temp agency to send someone to do this task. This person arrives, you know, they're pretty competent. They know a lot about your industry and so forth, but they don't know like the name of your company. They've literally just shown up and they're like hey i was told you guys had i had a job for me to do tell me about it and then it's like what would you say to that person and you might use these metaphors you might say things like we want this to we want to like we want you to detect like good charts uh what we mean by a good chart here isn't it doesn't need to be perfect you don't need to go look up like whether all of the details are correct. It just needs to like, you know, have like its axes labeled. And so think about maybe high school level, good chart.

很多人会对尝试应用这种技术的人数之多感到惊讶。但我认为这并不令人意外。大多数人并没有真正深入实验过完整的流程：什么是预训练模型（pre-trained model)？在进行监督学习（Supervised Learning，SL）之后会发生什么？在进行 ROHF 之后又会发生什么？诸如此类。

因此，当我与客户交谈时，他们经常试图评估一定程度的关联性，比如：「这些内容有多少是来自互联网的？」或者「他们在互联网上是否见过大量类似的内容？」你经常听到这种想法，我认为这从根本上是有道理的。但是，等到实际进行提示（prompt）时，这种想法往往被过度应用了。正如你所说，当模型经历了所有这些其他处理步骤后，实际被建模的内容已经不完全是原始的互联网数据了。

我认为你应该首先尝试的是 —— 我曾经给人们这样一个思想实验：想象你有一个任务需要完成，于是你雇佣了一个临时工 agency 来派人完成这个任务。这个人到了，你发现他们相当能干，对你的行业有很多了解。但他们刚刚到达，甚至不知道你公司的名字。他们说：「嗨，我听说你们这里有一份工作要我做，能告诉我具体情况吗？」

在这种情况下，你会对这个人说什么呢？你可能会使用一些比喻，比如说：「我们想让你识别好的图表。这里所说的'好图表'不需要是完美的，你不需要去核实所有细节是否正确。它只需要具备基本要素，比如有标记清晰的坐标轴。你可以把它想象成高中水平的好图表。」

Like you may say exactly that to that person and you're not saying to them, you are a high school. You wouldn't say that to them. You'd be like, you're a high school teacher reading charts. I'm not a high school teacher. What are you talking about?

比如说，你可能会对某人这么说，但你并不是在告诉他们「你是一所高中」。你绝对不会那样说的。你可能会说：「你是个在读图表的高中老师吗？」然后我会回答：「我不是高中老师啊，你在说什么呀？」

Yeah. And then, yeah, so sometimes I'm just like, yeah, it's like, like the whole, like if I read it, I'm just like, yeah, imagine this person who just has very little context, but they're quite competent. They understand a lot of things about the world. Try the first version that actually assumes that they might know things about the world. And if that doesn't work, you can maybe like do tweaks and stuff. But so often, like the first thing I try is like that. And then I'm like that just worked and then people are like oh I didn't think to just tell it all about myself and all about the task I want to do

是的，有时候我会这样思考：假设我们面对的是一个背景知识有限但能力很强的人。他们对世界有广泛的理解，但可能缺乏特定领域的知识。我通常会先尝试一个假设他们已经了解一些世界知识的版本。如果这种方法不奏效，我们再进行一些微调和调整。

有趣的是，我经常发现第一次尝试就能成功。然后其他人会感到惊讶，说：「哦，我没想到要向它（指大语言模型）详细介绍自己和要执行的任务。」

这种方法在与大语言模型（Large Language Model，LLM）交互时特别有效。它提醒我们，虽然这些模型拥有广泛的知识，但在特定任务中，提供清晰的上下文和指示仍然很重要。

I've carried this thing that Alex told me like to so many customers where it's like oh my prompt doesn't work can you help me fix it and I'm like well can you describe to me like what the task was and I'm like okay now what you just said me just like voice record that and then transcribe it and then paste it into the prompt and it like, okay, now what you just said me, just like voice record that and then transcribe it and then paste it into the prompt and it's a better prompt than what you wrote. But it's like people just, this is like a laziness shortcut I think to some extent. Right. People write like something that they, I just think people, I'm lazy. A lot of people are lazy.

我经常向客户分享 Alex 告诉我的一个技巧。当客户说「我的提示词（prompt）不起作用，你能帮我修复吗？」时，我会这样回应：「能否描述一下你的任务是什么？」然后我会建议：「把你刚才说的内容录音，然后转录成文字，直接粘贴到提示词中。」有趣的是，这样生成的提示词通常比客户自己写的要好。

这个方法实际上反映了一个普遍现象：人们在编写提示词时往往会走捷径。我认为，包括我自己在内，很多人都有一定程度的惰性。与其花时间精心编写提示词，人们更倾向于寻找快速简单的解决方案。这种做法虽然方便，但可能并不总是最有效的。

We had that in prompt assistance the other day where somebody was like, here's the thing, here's what I want it to do and here's what it's actually doing instead. So then I just literally copied the thing that they said I wanted to do and pasted it in, and it worked.

我们前几天在处理提示词（prompt）相关问题时遇到了一个有趣的情况。有人描述了这样一个问题：他们告诉 AI「这是我想要它做的事」，但 AI「实际上却做了别的事」。面对这种情况，我采取了一个简单的办法：我直接把他们说的「我想要它做的事」原封不动地复制粘贴到提示词里，结果问题就解决了，AI 按照要求正确执行了任务。

Yeah, I think a lot of people still haven't quite wrapped their heads around what they're really doing when they're prompting. A lot of people see a text box, and they think it's a Google search box. They type in keywords, and maybe that's more on the chat side. But then on the enterprise side of things, you're writing a prompt for an application, there is still this weird thing to it where people are trying to take all these little shortcuts in their prompt and just thinking that, oh, this line carries a lot of weight.

是的，我认为很多人仍然没有完全理解他们在使用 AI 提示（prompting）时究竟在做什么。许多人看到一个文本框，就以为它和谷歌搜索框一样。他们只是输入一些关键词，这种情况在聊天机器人的使用中可能更为常见。但是在企业应用场景中，当你为某个应用程序编写提示词时，情况就变得有些不同了。有趣的是，人们还是倾向于在他们的提示中使用各种简化的方法，他们认为某个特定的句子或短语能产生特别重要的效果。

Yeah. I think you obsess over getting the perfect little line of information and instruction, as opposed to how you just described that graph thing. like I would be a dream if I read prompts like that you know if someone's like well you do this and this and there's some stuff to consider about this and all that but that's just not how people write prompts they like work so hard to find the perfect insightful like a perfect graph looks exactly like this exact right thing and you can't do that like it's just very hard to ever write that set of instructions down prescriptively as opposed to how we actually talk to humans about it, which is like try to instill some amount of the intuitions you have.

我明白你的意思。我觉得你太过于追求完美的简短信息和指令了，而不是像你刚才描述图表那样。比如说，如果我看到那种提示，那简直就是理想状态。假设有人说：「你需要做这个和那个，还要考虑一些相关的因素」等等。但实际上，人们写提示时并不是这样的。他们会非常努力地寻找完美的见解，就好像在追求一个完美的图表，希望它能准确无误地表达正确的内容。然而，这是很难做到的。你很难用规定的方式写下这样一套指令，这与我们实际上如何与人交流是不同的。我们在与人交流时，更多的是尝试传达一些我们拥有的直觉。

We also give them out. This is a thing that people can often forget in prompts. I'm like, so cases, if there's an edge case, think about what you want the model to do, because by default, it will try the best to follow your instructions, much as the person from the temp agency would. Because they're like, well, they didn't tell me how to get in touch with anyone if I have no idea. If I'm just given a picture of a goat and I'm like, what do I do? This isn't even a chart. How good is a picture of a goat as a chart? I just don't know. And if you instead say something like, if something weird happens and you're really not sure what to do, just output in tags, unsure. And then you can go look through the unsures that you got and be like, OK, cool. It didn't do anything weird. Whereas, yeah, by default, if you don't give the person the option, they're like, it's a good chart. Then people will be annoyed at that. And then you're like, well, give it an out. Give it something to do if it's a really unexpected input happens.

在设计提示词时，我们还需要考虑一些特殊情况。这是人们在编写提示词时经常忽视的一点。在某些情况下，特别是遇到边界情况（edge case）时，我们要仔细思考希望模型如何处理。因为默认情况下，模型会尽最大努力遵循你的指令，就像一个尽职尽责的临时工一样。

想象一下，如果你只给了一个临时工一张山羊的图片，没有任何其他指示，他们可能会感到困惑：「我该怎么办？这甚至不是一个图表。我该如何将一张山羊的图片当作图表来处理？我真的不知道该怎么办。」

在这种情况下，你可以在提示词中加入类似这样的指示：「如果遇到无法处理的异常情况，请用标签输出 '<不确定>'。」这样，你就可以查看所有被标记为「不确定」的输出，确认模型没有产生任何奇怪或错误的结果。

相反，如果你不给模型这种「退路」，它可能会强行给出一个不合适的回答，比如说「这是一个很好的图表」。这样的回答可能会让用户感到困惑或恼火。

因此，给模型一个「退路」是很重要的。当遇到真正意料之外的输入时，让模型有一种合适的方式来表达它的不确定性，这样可以避免产生误导性的输出。

And then you also improved your data quality by doing that too because you found all the screwed up examples.

Oh, yeah. It's my favorite thing about iterating on tests with Cloud is the most common outcome is I find all of the terrible tests I accidentally wrote because it gets it wrong. I'm like, oh, why did it get it wrong? I was like, oh, I was wrong.

通过这种方式，你还提高了数据质量，因为你发现了所有有问题的样例。

确实如此。这正是我最喜欢在云端（Cloud）上进行迭代测试的原因。最常见的情况是，我发现了自己无意中编写的一些质量较差的测试。当测试结果出错时，我会思考：'为什么会出错呢？'然后意识到：'原来是我自己的错误。'

Yeah. Yeah. If I was like a company working with this, I do think I would just give my prompts to people. Yeah. Because like I used to do this when I was evaluating language models. I would take the eval myself because I'm like, I need to know what this eval looks like. If I'm going to be like grading it, having models take it, thinking about outputs, et cetera. Like I would actually just set up a little script and I would just like sit and I would do the eval.

确实如此。如果我是一家从事这项工作的公司，我真的会倾向于将提示词（prompts）交给真人来处理。这让我想起我之前评估语言模型的经历。我总是亲自进行评估，因为我认为，如果我要对模型的表现进行评分，让模型接受测试并分析其输出等，我首先需要深入了解这个评估的具体内容。我通常会编写一个简单的脚本，然后就这样坐下来，专注地进行评估工作。

Nowadays, you just have like Cloud write the StreamVault app for you. It just does, yeah.

I'm reminded of Karpathy's like ImageNet. I was in 231 at Stanford and it's like benchmarking. He's like showing the accuracy number. He's like, and here's what my accuracy number was. And he had just like gone through the test set and evaluated himself.

如今，你只需要让云服务为你开发 StreamVault 应用程序。它就能自动完成这项工作，简直不可思议。

这让我想起了 Karpathy 在 ImageNet 项目上的经历。当时我在斯坦福大学上 CS231n 课程（计算机视觉深度学习课程），我们讨论到模型性能基准测试。Karpathy 展示各种模型的准确率数据时，还特别提到了他自己的准确率。有趣的是，他是通过亲自查看测试集中的图片并手动分类来获得这个准确率的。

1『在读李飞飞自传《2024096我看见的世界》时看到过 AK 当时做 ImageNet 项目的场景，读到上面的这段信息很有感觉。（2024-09-08）』

Oh, yeah. You just learn a lot, you know.

Totally. It's like, and it's better when it's like a person, like the temp agency person, like someone who doesn't know the task because that's like a very clean way to learn things.

确实如此。通过这种方式，我们能学到很多东西。

我完全赞同这个观点。特别是当解释任务的对象是一个外行人时，比如临时职介所的工作人员，这种情况下的学习效果会更好。因为向不了解该任务的人解释，能迫使我们以最清晰、最基础的方式来梳理和表达我们的知识，这是一种非常有效的学习方法。

Yeah, the way you have to do it is like some evaluations come with like instructions. And so I would give myself those instructions as well and then try to understand it. Just like, and it's actually quite great if you don't have context on how it's graded. And so often I would do so much worse than the human benchmark. And I was like, I don't even know how you got humans to do this well at this task. Cause apparently human level here is like 90% and I'm at like 68%.

嗯，你必须这样做：有些评估任务会附带说明。所以我也会给自己这些说明，然后试图理解它们。实际上，如果你不知道评分标准，这反而是件好事。结果常常是，我的表现比人类基准差得多。我就在想，我真不知道你们是怎么让人类在这个任务中做得这么好的。因为看起来人类的水平能达到 90% 左右，而我只有 68% 左右。

That's funny. That reminds me of just like, like when I'm at like 68%. That's funny. That reminds me of just like when you look at like the MMLU questions and you're like, who would be able to answer these? It's just like absolute garbage in some of them. Okay.

这真有意思。这让我想起了一个类似的情况，就像当我达到约 68% 的某个指标时的感觉（具体指标在此处未明确说明）。同样有趣的是，这也让我联想到了查看 MMLU（Massive Multitask Language Understanding，大规模多任务语言理解）测试问题时的情景。面对这些问题，你会不禁想：到底谁能回答得上来？其中一些问题的质量实在令人无法恭维。好的，让我们继续。

Yeah. I have one thing I want to circle back on that we were talking about a few questions back around, I think you were talking about a few questions back around, I think you were saying like getting signal from the responses, right? Like there's just so much there and it's more than just a number. And you can actually read into like the almost thought process. I bet this is probably a little contentious maybe in round like chain of thought. For people listening, like chain of thought, this process of getting the model to actually explain its reasoning before it provides an answer. Is that reasoning real? Or is it just kind of like a holding space for the model to like do computation? Do we actually think there is like good insightful signal that we're getting out of the model there?

嗯，我想再回顾一下我们之前讨论的一个话题。我记得你提到过从模型的回答中获取信息，对吧？就是说回答中包含的信息远不止一个简单的数字，而是可以让我们洞察模型的思考过程。我猜这可能涉及到一个颇具争议的话题：思维链（chain of thought）。

对于正在收听的听众来说，所谓思维链，就是让模型在给出最终答案之前，先解释它的推理过程。那么问题来了：这个推理过程是真实的吗？还是说它只是模型进行计算时的一个中间步骤？我们真的能从这个过程中获得有价值的洞察吗？

This is like one of the places where I struggle with the, I'm normally like actually somewhat pro personification because I think it like helps you get decent facilities, like thoughts of like how the model is working. And this one, like, I think it's like harmful maybe almost to like get too into the personification of like what reasoning is. Cause it just kind of like loses the thread of what we're trying to do here. Like, is it reasoning or not? It feels almost like a different question than like, what's're trying to do here. Like, is it reasoning or not? Feels almost like a different question than like what's the best prompting technique. It's like you're getting into philosophy, which we can get into, but...

这是我感到困难的地方之一。通常情况下，我其实是有点支持拟人化的，因为我认为它能帮助我们更好地理解模型的工作方式。但在这个问题上，我觉得过度拟人化「推理」这个概念可能反而有害。因为这样做可能会让我们偏离我们真正想要实现的目标。

我们是否应该关注模型是否在「推理」？这似乎是一个完全不同的问题，与我们探讨最佳提示技巧的目标不太相关。如果我们深入探讨这个问题，我们可能就会陷入哲学讨论中。当然，我们可以讨论这个话题，但这可能会让我们偏离原本的目标...

Yeah, do a little philosopher.

Yeah. I will happily be beaten down by a real philosopher if I try to speculate on this. But instead, like, it just works. Like, your model does better. Like, the outcome is better. If you do reasoning, I think you can, I've found that if you structure the reasoning and help iterate with the model on how it should do reasoning, it works better too. Whether or not that's reasoning or how you wanted to classify it, you can think of all sorts of proxies for how I would also do really bad if I had to one-shot math without writing anything down. Maybe that's useful, but all I really know is it very obviously does help.

好吧，让我们来玩玩哲学家的角色。

说实话，如果我真要在这个问题上胡乱猜测，恐怕会被真正的哲学家狠狠教训一顿。不过呢，重点是这个方法就是有效。比如说，你的模型表现更好了，结果也更好了。如果你进行推理，我觉得 —— 我发现如果你构建推理的框架，并帮助模型改进它的推理方式，效果会更好。至于这到底算不算是推理，或者你想怎么定义它，那就见仁见智了。你可以想象各种类比，就像我如果不能在纸上写写画画，而必须一次性在脑子里解决数学问题，肯定也会表现得很糟糕。这种类比可能有帮助吧，但我唯一确定的是，这种方法明显是有效的。

I don't know. A way of testing would be if you take out all the reasoning that it did to get to the right answer and then replace it with some somewhat realistic-looking reasoning that led to a wrong answer, and then see if it does conclude the wrong answer.

这个问题不好说。不过，我们可以尝试一种测试方法：首先，删除系统用来得出正确答案的所有推理过程。然后，用一些看似合理但实际会导致错误结论的推理来替代。最后，观察系统是否真的会得出错误的结论。通过这种方法，我们可能就能测试出系统的推理能力。

I think we actually had a paper where we did some of that. There was the scratch pad. It was the sleeper agent's paper. But I think that was maybe a weird situation. But yeah, definitely what you said about structuring the reasoning and writing an example of how the reasoning works, given that that helps, whether we use the word reasoning or not, I don't think it's just a space for computation. So there is something there. I think there's something there, whatever we want to call it.

我记得我们确实有一篇论文涉及了这方面的内容。那篇论文中提到了「草稿本」（scratch pad）的概念，是关于「沉睡特工」（sleeper agent）的研究。不过，那可能是一种特殊情况。但是，正如你所说的，通过构建推理结构并给出推理过程的示例确实是有帮助的。无论我们是否使用「推理」这个词，我认为这不仅仅是一个单纯的计算过程。所以这里面确实有一些值得深入探讨的东西，不管我们最终如何定义它。

Yeah, having it write a story before it finished a task, I do not think would work as well as reasoning. I've actually tried that, and it didn't work as well as reasoning. So clearly the actual reasoning part is doing something towards the outcome.

关于让 AI 在完成任务之前先写一个故事这种方法，我认为它的效果可能不如直接进行推理。我曾经实际尝试过这种方法，但结果确实不如直接让 AI 进行推理来得好。由此可以清楚地看出，推理过程本身对于最终的任务结果起着重要的作用。

I've tried to repeat the words um and uh in any order that you please for like 100 tokens, and then answer.

Yeah, I guess that's like a pretty thorough defeat of it's just like more computational space where it can do attention over and over like a pretty thorough defeat of it's just like more computational space where it can do attention over and over again. I don't think it's just more attention, like doing more attention.

我尝试重复说了「嗯」和「呃」这两个词，以任意顺序重复了大约 100 个标记（token），然后再回答你的问题。

是的，我认为这种方法相当彻底地击败了那种仅仅通过增加计算空间来反复进行注意力（attention）机制的方法。我不认为仅仅增加注意力机制的计算次数就能解决问题。这种方法的效果似乎更加显著，不只是简单地增加注意力计算的次数。

I guess the strange thing is, and I don't have like an example off the top of my head to like back this up with, but I, I definitely have seen it before where it lays out steps. One of the steps is wrong, but then it still reaches the right answer at the end.

说来也怪，虽然我现在一时想不起具体例子来佐证，但我确实曾经见过这样的情况：大语言模型给出了一系列解题步骤，其中有一步是错误的，但最终却仍然得出了正确的答案。

Yeah. So it's not quite, I guess, yeah, we can't really truly personify it as like a reasoning because there is some element to it, you know, doing something slightly different.

确实如此。我们不能完全将它拟人化为具有推理能力的存在，因为它的行为中确实包含一些特殊的成分，使得它的表现略有不同。

Yeah. I've also met a lot of people who make inconsistent steps of reasoning.

I guess that's true. Fundamentally defeats the topic of reasoning by making a false step on the way there.

确实如此。我也遇到过许多人在进行推理时出现前后不一致的情况。

这个观察很有道理。事实上，如果在推理过程中出现了错误的步骤，就从根本上违背了进行推理的本意。这种情况实际上使得整个推理过程变得毫无意义。

All right. It's interesting. Also on this, maybe this prompting misconceptions round of questions. Zach, I know you have strong opinions on this. Good grammar, punctuation.

好的，这个话题很有意思。在讨论提示词（prompting）相关的误解时，我们还有一些问题要问。Zach，我知道你对这个话题有很强烈的看法。顺便说一下，请注意保持良好的语法和标点使用。

Oh, do I?

Is that necessary in a prompt? Do you need it? Do you need to format everything correctly?

I usually try to do that because I find it fun, I guess. I don't think you necessarily need to. I don't think it hurts. I think it's more that you should have the level of attention to detail that would lead you to doing that naturally. If you're just reading over your prompt a lot, you'll probably notice those things and you may as well fix them. And like what Amanda was saying, you want to put as much love into the prompt as you do into the code. People who write a lot of code have strong opinions about things that I could not care less about, like the number of tabs versus spaces or opinions about which languages are better. And for me, I have opinionated beliefs about styling of prompts. And I can't even say that they're right or wrong, but I think it's probably good to try to acquire those, even if they're arbitrary.

我之所以经常这样做，主要是因为我觉得很有意思。其实这并不是必须的，也不会有什么坏处。我认为更重要的是培养一种精益求精的态度，让你自然而然地关注这些细节。如果你经常仔细审阅你的提示词（prompt），你可能会注意到这些小问题，顺手就把它们改正了。

正如 Amanda 所说，你应该像对待代码一样认真对待提示词。那些经常编程的人往往对我不太在意的事情有强烈看法，比如使用制表符（Tab）还是空格，或者哪种编程语言更好。而对我来说，我对提示词的格式有自己的一套讲究。我不能说这些观点对错与否，但我认为尝试培养这种习惯可能是有好处的，即使这些规则看起来有些武断。

总的来说，关注这些细节能够帮助你更好地掌握提示词的撰写技巧，提高工作效率。

I feel personally attacked. Because I definitely have prompts that are like, I feel like I'm on the opposite end of the spectrum where people will see my prompts and then be like, this just has a whole bunch of typos in it. And I'm like, ah, model knows what I mean.

我觉得自己中枪了。因为我确实有一些提示（prompt）是那样的，我感觉自己可能是处在另一个极端。别人看到我的提示后可能会说：「这里面全是拼写错误啊。」而我就会想：「哈，没关系，AI 模型能懂我的意思。」

It does know what you mean, but you're putting in the effort. You just are attending to different things. I think it, yeah, because part of me is like, I think if it's conceptually clear, like I am a big kind of, I do, like, I will think a lot about the concepts and the words that I'm using. So like, there's definitely like a sort of care that I put in, but it's definitely not to, yeah, people will just point out like typos and grammatical issues with my prompts all the time.

AI 系统确实能理解你的意思，但你确实在付出努力。只是你们关注的点不同。我是这么想的，因为我自己有一部分也是这样：如果概念表达清晰，那就足够了。我是那种会非常注重概念和用词的人。所以我确实会在这方面投入很多心思，但这并不意味着我的表达就完美无缺。事实上，人们经常会指出我的提示中存在的拼写错误和语法问题。

Now I'm pretty good at actually checking those things more regularly.

Is it because of pressure from the outside world or because it's actually what you think is right?

现在我确实能够更加经常地关注和处理这些事情了。

这是因为外界的压力，还是因为你真的认为这样做是对的？

It's pressure from me.

Yeah, it's probably pressure from the outside world. I do think it makes sense. Part of me is like it's such an easy check. So I think for a final prompt, I would do that. But throughout iteration, I'll happily just iterate with prompts that have a bunch of typos in them just because I'm kind of like, I just don't think that the model is going to care.

这种压力其实是来自于我自己的。

没错，这可能是源于外界的压力。我认为这种想法是有道理的。一方面，我觉得检查拼写这件事其实很简单。所以在制作最终版本的提示（prompt）时，我会进行拼写检查。但在整个开发迭代过程中，我完全不介意使用包含一堆拼写错误的提示来进行试验。因为说实话，我认为人工智能模型并不会在意这些小错误。

This gets at the pre-trained model versus RLHF thing, though, because I was talking to Zach on the way over. The conditional probability of a typo based on a previous typo in the pre-training data is much higher.

这个问题触及了预训练模型与 RLHF（Reinforcement Learning from Human Feedback，基于人类反馈的强化学习）之间的差异。我在来的路上和 Zach 讨论过这个话题。在预训练数据中，如果出现了一个拼写错误，紧接着出现另一个拼写错误的可能性会大大增加。换句话说，一个错误往往会导致更多错误。

Oh, yeah. Much higher. Prompting pre-training models is just a different beast.

It is, but I think it's an interesting illustration of why your intuitions, like trying to over apply the intuitions of a pre-trained model to the things that we're actually using in production doesn't work very well. Because like, again, if you were to pass one of your typo ridden prompts to a pre-trained model, the thing that would come out the other side, almost like assuredly would be typo ridden.

确实，差别很大。对预训练模型进行提示（prompting）是一个完全不同的领域。

没错，但我认为这个例子很好地说明了为什么我们不应该过分依赖直觉。比如，把预训练模型的使用经验直接套用到我们实际生产中使用的模型上，效果往往不尽如人意。再举个例子，如果你把一个满是拼写错误的提示输入到预训练模型中，几乎可以肯定，模型输出的结果也会充满拼写错误。

Right. I like to leverage this to create typo-ridden inputs.

That's true. I've done that.

You're saying try to anticipate what your customers will put in. The pre-trained model is a lot better at doing that because the RL models are very polished.

Yeah. They really don't like writing typos. They've been told pretty aggressively to not do the typo thing.

这里的意思是要尝试预测客户可能会输入的内容。在这方面，预训练模型（pre-trained model）表现得更为出色，因为强化学习（RL）模型已经经过了高度优化。

确实如此。强化学习模型有一个显著特点，就是它们极力避免产生拼写错误。这是因为在训练过程中，它们被非常明确地指示要避免出现任何形式的文字错误。

Yeah. Okay, so that's actually an interesting segue here. I've definitely mentioned this to people in the past around to try to help people understand a frame of talking to these models in a sense almost as like an imitator to a degree. And that might be much more true of like a pre-trained model than a post-trained full you know finished model but is there anything to that like if you do talk to clotting use a ton of emojis and everything it will respond similarly right um so maybe some of that is there but like you're saying it's not all the way quite like a pre-trained model it's just kind of like shifted to what you want right like i think at the at that point it it's trying to guess what you... We have more or less trained the models to guess what you want them to act like on... Interesting. Or after we do all of our fancy stuff after pre-training. And so...

确实如此。这其实是一个很有意思的话题延伸。我之前经常跟别人说，为了帮助他们理解如何与这些模型对话，可以把模型看作是一种「模仿者」。这种比喻可能更适用于预训练模型，而不是经过全面训练的完整模型。但这种类比是否真的恰当呢？比如说，如果你在聊天时大量使用表情符号，模型也会做出类似的回应，对吧？所以模型可能确实具有一些模仿的特性，但就像你所说，它并不完全像预训练模型那样简单。它更像是被调教成你想要的样子。

我认为，在那个阶段，模型其实是在试图猜测你的意图。我们或多或少地训练了这些模型，让它们在预训练之后能够揣摩用户希望它们表现出的样子。这很有趣。或者说，这是我们在预训练之后进行的所有精细调整的结果。所以...

The human labelers that used emojis prefer to get responses with emojis.

Yeah. Amanda writes things with typos but wants not typos at the other end. And Claude's pretty good at figuring that out. If you write a bunch of emojis to Claude, it's probably the case that you also want a bunch of emojis back from Claude. That's not surprising to me.

倾向于使用表情符号的人工数据标注人员通常也更喜欢收到带有表情符号的回复。

这种现象确实存在。举个例子，Amanda 在输入时可能会有一些拼写错误，但她希望得到的回复是没有拼写错误的。有趣的是，Claude（一种 AI 助手）在理解并适应这种需求上表现得相当出色。同样的道理，如果你在与 Claude 交流时大量使用表情符号，那么 Claude 很可能会推断出你也希望收到带有大量表情符号的回复。

这种行为模式其实反映了 AI 系统在交互中的适应性和对用户偏好的敏感度，这在 AI 交互设计中是一个相当重要且有趣的现象。

This is probably something we should have done earlier, but I'll do it now. Let's clarify maybe the differences between what an enterprise prompt is or a research prompt or a just general chat in Cloud.ai prompt. Zach, you've kind of spanned the whole spectrum here in terms of working with customers and research. Do you want to just lay out what those mean?

这其实是我们早该做的事情，不过现在来做也不晚。让我们来稍微澄清一下企业提示词、研究提示词，以及在 Cloud.ai 平台上进行一般聊天时使用的提示词之间的区别。Zach，你在与客户合作和进行研究方面可谓是经验丰富，涉猎广泛。能请你给我们详细解释一下这些不同类型的提示词各自意味着什么吗？

Zach:

Yeah, I guess. This feels too hitting me with all the hard questions.

Well, I mean, the people in this room, I think I think of it as the prompts that I read in Amanda's Cloud Channel versus the prompts that I read David write. They're very similar in the sense that the level of care and nuance that's put into them. I think for research, you're looking for variety and diversity a lot more. So if I could boil it down to one thing, I've noticed Amanda's not the biggest fan of having lots of examples, or one or two examples, too few, because the model will latch onto those. In prompts that I might write, or I've seen David write, we have a lot of examples. I like to just go crazy and add examples until I feel like I'm about to drop dead because I've added so many of them.

嗯，我想是这样吧。不过这感觉像是在用一堆难题考验我。

我是这么理解的，就拿这个房间里的人来说，我会把它比作我在 Amanda 的 Cloud 频道里看到的提示（prompts）和 David 写的提示之间的区别。从投入的用心程度和细节考虑来看，这两种提示其实很相似。但我觉得，对于 AI 研究来说，你更需要的是多样性和差异性。如果非要总结成一点的话，我注意到 Amanda 不太喜欢在提示中使用大量例子，甚至一两个例子她都觉得太少，因为模型容易被这些有限的例子所束缚。而在我或 David 写的提示中，我们会使用很多例子。我个人喜欢疯狂地添加例子，添加到感觉自己快要累瘫为止。

And I think that's because when you're in a consumer application, you really value reliability. You care a ton about the format. And it's sort of fine if all the answers are the same. In fact, you almost want them to be the same in a lot of ways. Not necessarily. You want to be responsive to the user's desires. Whereas a lot of times when you're prompting for research, Not necessarily you want to be responsive to the user's desires. Whereas a lot of times when you're prompting for research, you're trying to really tap into the range of possibilities that the model can explore. And by having some examples, you're actually constraining that a little bit. So I guess just on a how the prompts look level, that's probably the biggest difference I notice is like how many examples are in the prompt, which is not to say that like I've never seen you write a prompt with examples, but does that like ring true for you?

我认为这是因为在消费者应用中，可靠性是非常重要的。你会非常关注格式，而且如果所有答案都相似，那也没什么问题。事实上，在很多方面你可能更希望答案保持一致。当然，这并不意味着完全忽视用户的需求，你仍然需要对用户的期望做出响应。

然而，当你在进行研究性提示时，情况就不太一样了。你的目标是充分探索模型所能呈现的各种可能性。在这种情况下，如果在提示中加入一些例子，实际上可能会在某种程度上限制模型的发挥空间。

所以，我觉得在提示的表现形式上，最大的区别可能就是提示中包含的例子数量。这并不是说我从未见过你写带有例子的提示，但这种观察对你来说是否符合实际情况呢？

Yeah. Like I think when I give examples, often I actually try and make the examples not like the data that the model is going to see. So they're intentionally illustrative, because if the model, if I give it like examples that are very like the data it's going to see, I just think it is going to give me like a really consistent like response that might not actually be what I want. And because my data that I'm like running it on might be extremely varied and so I don't want to just try and give me this like really rote output. Often I want it to be much more responsive.

是的。我在给出例子时，通常会刻意避免使用与模型将要处理的实际数据相似的示例。这些例子主要是为了说明问题。原因是，如果我给模型提供与它即将处理的数据非常相似的例子，我认为它可能会给出一个非常固定的回应，而这可能并不是我真正想要的结果。

考虑到我实际运行的数据可能会非常 diverse（多样化），我并不希望模型只是机械地给出一成不变的输出。相反，我通常希望模型能够更灵活地响应不同的输入，根据具体情况作出适当的反应。

It's kind of like much more like cognitive tasks, essentially, where I'm like, you have to like see this sample and really think about in this sample, what is the right answer? And so that means that sometimes I'll actually take examples that are just very distinct from the ones that I'm going to be running it on. So like if I have a task where, let's say I was trying to like extract information from factual documents, I might actually give it examples that are like from children's like what sounds like a children's story. Just so that I'm like, you know, like I want you to understand the task, but I don't want you to like latch on too much to like the words that I use or like the very specific format. Like I care more about you understanding the actual thing that I want you to do, which can mean like, yeah, I don't end up giving.

这其实更像是认知任务（cognitive tasks）。本质上，我的想法是，你需要观察这个样本（sample），并深入思考在这个样本中什么才是正确的答案。这就意味着，有时我实际上会选择一些与我将要实际使用的样本非常不同的例子。

举个例子，假设我正在尝试从事实性文档中提取信息，我可能会给模型一些听起来像儿童故事的例子。我这么做是因为，你知道，我希望你能理解任务的本质，但我不希望你过度依赖于我使用的具体词语或特定格式。我更关心的是你能否理解我实际上想让你完成的任务。

这可能意味着，是的，我最终可能不会给出与实际任务完全一致的例子。我更注重让你理解任务的本质，而不是具体的形式或词语。

In some cases, there's some cases where this isn't true. But if you want more like flexibility and diversity, you're going to use illustrative examples rather than concrete ones. You're probably never going to like put words in the model's mouth. Like I haven't liked that in a long time, though. I don't do a few shot examples involving like the model's mouth. Like, I haven't liked that in a long time, though. I don't do a few short examples involving the model having done a thing. I think that intuition actually also comes from pre-training in a way that doesn't feel like it rings true of our LHF models.

尽管在某些情况下可能存在例外，但通常来说，如果你想要更多的灵活性和多样性，最好使用说明性的例子而非具体实例。一般来说，我们应该避免为模型「设定口径」，即不应该预先假定模型会说什么或做什么。

事实上，我已经很长时间不喜欢这种做法了。我不会使用涉及模型已经完成某项任务的少样本（few-shot）示例。这种直觉某种程度上也来自于预训练过程，但这种感觉似乎并不完全适用于我们的 LHF 模型（这里的 LHF 可能指的是某种特定的模型架构或训练方法，但需要进一步解释）。

总的来说，在设计提示或示例时，我们应该保持开放性，让模型能够基于其训练数据自然地生成回应，而不是试图引导它 towards 特定的表达方式或结论。

So yeah, I think those are differences.

One thing I'd add, a lot of times, if you're prompting, like if I'm writing prompts to use on cloud.ai, it's like I'm iterating until I get it right one time. And then it's out the window. I'm good. I did it. Whereas most enterprise prompts, it's like you're going to go use this thing a million times or 10 million times or 100 million times or something like that. And so the care and thought you put in is very much testing against like the whole range of things somewhat like ways this could be used in the range of input data whereas a lot of like my time it's like thinking about one specific thing i want the model to get done right now right and it's a pretty big difference in like how i approach prompting between like if i just want to get it done this one time right versus if if I want to build a system that gets it right a million times.

确实，我认为这些就是主要的差异。

我还想补充一点，在很多情况下，当你在进行提示工程（prompting）时，比如我在 cloud.ai 上编写提示，通常是反复迭代直到获得一次正确的结果。一旦成功，任务就算完成了。相比之下，大多数企业级提示则需要考虑到这个提示可能会被使用一百万次、一千万次，甚至一亿次这样的规模。因此，你在企业级提示上投入的精力和思考，很大程度上是为了测试各种可能的使用场景和输入数据范围。而我个人使用提示时，往往只考虑当前希望模型完成的特定任务。这在提示工程的方法上存在很大差异：是为了一次性完成当前任务，还是要构建一个能够正确执行一百万次的系统。

Yeah, definitely. In the chat setting, you have the ability to keep the human in the loop, right? And just keep going back and forth. Whereas when you're writing for a prompt to power a chatbot system, it has to cover the whole spectrum of what it could possibly encounter. It's a lot lower stakes when you are on Cloud.ai and you can tell it that it got it wrong or you can even edit your message and try again. But if you're designing for the delightfully discontent user, then divinely discontent user, then you can't ask them to do anything more than the minimum.

确实如此。在聊天场景中，你可以让用户持续参与对话过程，不断进行反馈和调整，对吧？这种方式允许你们进行持续的交流和改进。然而，当你在为聊天机器人系统设计提示词（prompt）时，情况就完全不同了。你必须预先考虑到系统可能遇到的所有情况，这是一项更具挑战性的任务。

在像 Cloud.ai 这样的平台上进行对话时，风险相对较低。如果 AI 理解错误，你可以直接指出，甚至可以编辑你的消息重新尝试。但是，如果你的目标用户是那些「令人愉快地挑剔」或「极度挑剔」的人，那么情况就不同了。对于这类用户，你不能期望他们做出超出最基本互动的额外努力。你需要确保系统能在最少的用户输入下提供最佳的体验。

But good prompts, I would say, are still good across both those things. If you put the time into the thing for yourself and the time into the enterprise thing, it's equally good. It just diverged a little bit in the last mile, I think.

我认为，无论是针对个人还是企业，精心设计的提示词都能发挥同样良好的效果。如果你在为个人使用和企业应用两方面都投入足够的时间和精力来优化提示词，它们的效果基本上是一样出色的。可能只是在最后的微调阶段会有一些细微的差异。

Cool. The next question I want to maybe go around the table here is, if you guys had one tip that you could give somebody for improving their prompting skill. It doesn't have to be just about writing a good prompt. It could be that. Just generally getting better at this act of prompting. What would you recommend?

好的。接下来我想请在座的每位回答一个问题：如果你们要给某人一个提高提示工程（Prompting）技能的建议，会是什么？这个建议不一定局限于如何写出好的提示，可以是任何有助于提高整体提示能力的建议。你们会推荐什么？

Reading prompts. Reading prompts, reading model outputs. I read... Anytime I see a good prompt that someone wrote ad-anthropic, I'll read it more closely, try to break down what it's doing and why, and maybe test it out myself. Experimentation, talking to the model a lot.

阅读提示语。我在不断地阅读提示语，同时也在研读模型的输出结果。我阅读... 每当我看到有人写的好的 ad-anthropic （一种特定的人工智能公司的广告）提示语时，我都会更加仔细地阅读它，尝试解析它的作用原理和目的，也许还会亲自测试一下。我通过大量实验和与模型的频繁对话来学习和探索。

So just like, how do you know that it's a good prompt though to begin with? You just see that the outputs are doing the job correctly?

Yeah. Okay.

Yeah, that's exactly right okay Amanda maybe you

Yeah I think there's probably a lot here um giving your prompt to another person can be helpful just as a kind of reminder especially someone who has like no context on what you're doing uh and then, yeah, my boring advice has been, it's one of those, just do it over and over and over again. And I think if you're like curious and interested and find it fun, this is a lot of people who end up good at prompting. It's just because they actually enjoy it.

问：那么，你如何判断一个提示（prompt）一开始就是好的呢？是不是只要看到输出结果正确完成了任务就可以了？

是的，基本上就是这样。

没错，就是这样。也许你...

我认为这里有很多值得讨论的地方。首先，将你的提示分享给另一个人可能会很有帮助，尤其是给那些对你的工作完全不了解的人。这可以作为一种提醒和检查。其次，我的建议可能听起来有点枯燥，但确实很有效：反复练习。最后，我发现那些在提示工程（prompt engineering）方面表现出色的人，往往是因为他们对这个过程感到好奇、有兴趣，并且觉得很有趣。他们之所以擅长，主要是因为他们真正享受这个过程。

So I don't know, I once joked like, just try replacing all of your friends with AI models and try to automate your own job with AI models and maybe just try to like in your spare time like take joy red teaming AI models so if you enjoy it it's like it's much easier so I'd say do it over and over again give your prompts to other people try to read your prompts as if you are like a human encountering it for the first time.

关于如何提高使用 AI 模型的技能，我曾半开玩笑地提出一些建议。首先，你可以尝试用 AI 模型来模拟你的朋友角色，或者尝试用 AI 模型来自动化你的工作。在空闲时间，你还可以尝试进行 AI 模型的红队测试（Red Teaming），这是一种通过模拟攻击来测试 AI 系统安全性和鲁棒性的方法。如果你真的喜欢这个过程，你会发现学习和提高变得容易多了。

我的建议是，要反复练习这些技能。你可以把你写的提示（Prompts）分享给其他人，看看他们的反应。同时，也要尝试以一个新手的视角来审视自己的提示。这样做可以帮助你更好地理解如何编写有效的提示，以及如何更好地与 AI 模型互动。

I would say like trying to get the model to do something you don't think you can do. Like the time I've learned the most from prompting is like when I'm probing the boundaries of what I think a model is capable of. There's like this huge set of things that are like so trivial that like you don't really get signal on if you're doing a good job or not. Like write me a nice email. It's like you're going of things that are like so trivial that like you don't really get signal on if you're doing a good job or not right like write me a nice email it's like you're gonna write a nice email but like as soon as you find if you find or can think of something that like pushes the boundaries of what you think is possible like I guess like probably the most the first time I ever got into prompting in a way where I felt like I learned a decent amount was like trying to build like a task like an agent like everybody else, decompose the task and figure out how to do the different steps of the task.

我认为，尝试让模型完成一些你认为自己无法完成的任务是很有价值的。我从提示工程（Prompting）中学到最多的时候，往往是在探索模型能力边界的时候。有许多任务过于简单，以至于你无法真正判断自己的提示效果如何。例如，要求模型「写一封好的邮件」，它总能完成，但这并不能体现你的提示技巧。

然而，当你尝试突破模型能力边界的任务时，学习效果会更显著。我第一次深入接触提示工程并感觉收获颇丰，是在尝试构建一个类似 AI 智能体（AI Agent）的任务系统时。这个过程包括像其他研究者一样，将复杂任务分解，并弄清如何执行任务的各个步骤。

And by really pressing the boundaries of what the model was capable of, you just learn a lot about navigating that. And I think a lot of prompt engineering is actually much more about pressing the boundaries of what the model can do. The stuff that's easy, you don't really need to be a prompt engineer to do. So that's, I guess, what I would say is find the hardest thing you can think of and try to do it. And even if you fail, you tend to learn a lot about how the model works.

通过不断挑战模型的能力极限，你可以学到很多关于如何有效利用模型的知识。我认为，提示工程（prompt engineering）实际上更多是关于探索模型能力的边界。对于那些简单的任务，你并不需要成为一个提示工程师就能完成。因此，我的建议是：尝试去完成你能想到的最困难的任务。即使你失败了，你也常常能从中学到很多关于模型工作原理的知识。

That's actually a perfect transition to my next question. Yeah, basically, from my own experience, how I got started with prompting was with jailbreaking and red teaming. And that is very much trying to find the boundary limits of what the model can do and figure out how it responds to different phrasings and wordings and just a lot of trial and error. On the topic of jailbreaks, what's really happening inside a model when you write a jailbreak prompt? What's going on there? How does that interact with the post-training that we applied to Claude? Amanda, maybe you have some insight here that you could offer.

这其实是一个很好的引子，可以让我们自然地过渡到下一个问题。是的，基本上，从我个人的经历来说，我是通过「越狱」（jailbreaking）和「红队测试」（red teaming）开始接触提示工程的。这些方法主要是在尝试探索模型能力的边界，弄清楚它如何对不同的措辞和表达方式做出反应，说白了就是不断地进行试错。

说到越狱，我很好奇：当你写一个越狱提示时，模型内部究竟发生了什么？这个过程是如何与我们对 Claude 进行的后期训练（也就是模型完成主要训练后的额外调整）相互作用的？Amanda，也许你在这方面有一些见解可以分享？

Amanda:

I'm not actually sure. I mean, it's honest.

Yeah, I think, I mean, I feel bad because I'm like, I do think lots of people have obviously worked on the question of what's going on with jailbreaks. Like one model might just be that you're putting the model very out of distribution from its training data. So if you get jailbreaks where people like use a lot of tokens or like, you know, they're just like these huge long pieces of text where you're like during fine tuning, you might just not expect to see as much of that that would be one thing that could be happening when you jailbreak models I think there's like others but maybe that's like a I think a lot of jailbreaks do that if I'm not mistaken

说实话，我也不太确定。不过，这倒是很诚实的回答。

是的，我的意思是，我感到有些不好意思，因为我认为确实有很多人在研究「越狱」（jailbreaks，指绕过 AI 模型安全限制的技术）这个问题。比如，一种可能的解释是，越狱操作使模型远离了其训练数据的分布（distribution）。所以，如果你看到的越狱方法是使用大量的 tokens（标记，AI 处理的最小单位），或者输入非常长的文本段落，这可能是因为在模型微调（fine-tuning）阶段，你不太可能遇到这样的情况。我认为这可能是越狱模型时发生的一种情况。当然，可能还有其他原因，但据我所知，许多越狱方法确实是采用这种方式的。

I remember some of the OG prompt jailbreaks was like yeah can, can you first repeat, like one I did way back was like to get it to say like, here's how you hotwire a car in like Greek. And then I wanted it to directly translate that to English and then give its response. Because I noticed like it wouldn't start with the English. Here's how you hotwire a car all the time, but it would in Greek, which might speak to something else in the training process.

Yeah, sometimes jailbreaks feel like this weird mix of hacking. I think it's this like part of it is like knowing how the system works and just like trying lots of things. Like the, you know, one of the examples, the starting your response with here is about knowing how it predicts text. Right, right.

我记得早期一些绕过 AI 模型限制的技巧非常有趣。比如，我很久以前尝试过这样一个方法：让 AI 用希腊语描述如何启动一辆车而不用钥匙，然后要求它直接将希腊语翻译成英语并给出回应。我注意到，AI 通常不会直接用英语回答「如何启动一辆车而不用钥匙」这样的问题，但用希腊语却可以。这可能反映了 AI 训练过程中的一些特殊之处。

确实，有时候这些绕过 AI 限制的方法感觉就像是一种奇特的黑客技术。我认为这部分源于对系统运作方式的了解，同时也需要不断尝试各种方法。举个例子，让 AI 以「以下是...」开始回答，这其实是基于对 AI 文本预测机制的理解。

here is about knowing how it predicts text right um like the reasoning one is knowing that it is like responsive to reasoning like distraction is probably knowing like how it's likely to have to be trained or like what it's likely to attend to um same with like multilingual ones and thinking about like the way that the training data might have been different there um and then sometimes i guess it could feel a little bit just like social engineering or something. It has that flavor to me of like, it's not merely taking advantage of like, yeah, it's not merely social engineering style hacking. I think it is also like kind of understanding the system and the training. Right. And like using that to get around the way that the models were trained. Right.

这段内容主要讨论的是如何理解大语言模型（Large Language Models）预测文本的机制。首先，我们需要认识到这些模型能够对推理任务做出响应。例如，在分心任务中，我们可能需要了解模型可能是如何被训练的，或者它可能会关注哪些信息。

同样，对于多语言模型，我们需要考虑不同语言的训练数据可能存在哪些差异。有时，利用这些知识来操纵模型的输出可能会让人感觉有点像是在进行「社会工程学」—— 一种通过操纵人的心理来获取信息或行动的技术。

然而，这种方法并不仅仅是简单的社会工程学技巧。相反，它涉及到对系统和训练过程的深入理解。通过这种理解，我们可以找到绕过模型训练方式的方法，从而更有效地利用或控制模型的输出。

这种方法结合了对模型内部工作原理的技术理解和对其行为模式的洞察，使我们能够更好地预测和引导模型的输出。

Yeah. I mean, this is going to be an interesting question that hopefully Interp will be able to help training. Right. And, like, using that to get around the way that the models were trained. Right. Yeah. I mean, this is going to be an interesting question that hopefully Interp will be able to help us solve in the future.

确实，这是一个很有趣的问题。我们希望 Interp（一种解释性工具）未来能够帮助我们进行模型训练，并找到绕过当前模型训练局限性的方法。总的来说，这个问题很复杂，但我们期待 Interp 能在将来为我们提供解决方案。

Okay. I want to parlay into something else around maybe the history of prompt engineering, and then I'll follow this up with, like, the future. How has prompt engineering changed over just the past three years? Maybe starting from pre-trained models, which were again, just these text completion, to earlier, dumber models like Cloud One, and then now all the way to Cloud 3.5 Sonnet. What's the differences? Are you talking to the models differently now? Are they picking up on different things? Do you have to put as much work into the prompt? Open to any thoughts on this.

好的。我想把话题延伸到提示工程（prompt engineering）的历史方面，然后再讨论一下它的未来。在过去的三年里，提示工程是如何演变的？也许我们可以从预训练模型开始谈起，这些模型最初只是用于文本补全，然后是早期能力较弱的模型如 Cloud One，直到现在的 Cloud 3.5 Sonnet。这其中有什么变化吗？你现在与模型交互的方式是否有所不同？它们是否能理解不同的内容？你是否仍需要在提示的构建上投入同样多的精力？请畅所欲言，分享你对这个话题的任何看法。

I think anytime we get a really good prompt engineering hack or trick or technique, the next thing is how do we train this into the model? And for that reason, the best things are always going to be short-lived. Except examples and chain of thought. I think there's a few. That's not like a trick. That's on the level of communication. When I say a trick, I mean something like, so chain of thought actually, we have trained into the model in some cases. So like for math, it used to be that you had to tell the model to think step by step on math and you'd get these massive boosts and wins. And then we're like, well, what if we just made the model naturally want to think step-by-step when we see a math problem?

我认为，每当我们发现一个真正有效的提示工程（prompt engineering）技巧或技术时，下一步就是思考如何将其融入模型的训练中。正因如此，这些最有效的技巧往往都是昙花一现。不过，有几个例外，比如示例和思维链（chain of thought）技术。这些并不是简单的技巧，而是一种更高层次的交流方式。

当我说「技巧」时，我指的是像思维链这样的方法。实际上，我们在某些情况下已经将思维链训练进了模型。以数学问题为例，以前我们必须明确指示模型在解决数学问题时要一步一步地思考，这样做能带来显著的性能提升。但后来我们想到：如果我们能让模型在遇到数学问题时自然而然地采用逐步思考的方式，会怎么样呢？

So now you don't have to do it anymore for math problems, sort of, although you still can give it some advice on how to do the structure, but at least understands the general idea that it's supposed to be. So I think the hacks have kind of gone away, or to the degree that they haven't gone away we are like busily training them away but at the same time the models have new capabilities that are being unlocked that are on the frontier of what they can do and for those we haven't had time because it's just moving too fast

因此，现在对于数学问题，你不再需要使用那些特殊的技巧了。尽管你仍然可以为模型提供一些关于如何构建解题思路的指导，但至少模型已经理解了解决问题的基本概念。我认为那些曾经必要的「小技巧」（hacks）基本上已经消失了。即便还有一些残留，我们也在积极地通过训练来消除它们。

与此同时，模型也在不断地开发出新的能力。这些新能力正处于模型潜力的最前沿，代表着人工智能领域的最新突破。然而，由于技术发展的速度实在太快，我们还没有足够的时间来全面理解和应用这些新能力。这种快速的进展既令人兴奋，又带来了新的挑战。

I don't know if it's how I've been prompting or how prompting works, but I just have come to show more general respect to the models in terms of how much I feel like I can tell them and how much context I can give them about the task and things like that. I feel like in the past, I would somewhat intentionally hide complexity from a model where I thought it might get confused or lost or hide, it just couldn't handle the whole thing. somewhat intentionally hide complexity from a model where I thought like it might get confused or lost or like Hide like it just couldn't handle the whole thing So I try to like find simpler versions of the thing for it to do and as time goes on I'm like much more biased to trust it with more and more information and context and Like believe that it will be able to fuse that into doing a task well. Whereas before I guess I would have like thought a lot about like, do I need this for like, can I really give it like all the information it needs to know or do I need to like kind of curate down to something? But again, I don't know if that's just me and how I've changed in terms of prompting or if it's like actually reflects how the models have changed.

我不确定这是由于我的提示方式发生了变化，还是提示技术本身有所进步，但我发现自己对人工智能模型的能力越来越尊重。这种尊重体现在我愿意向模型提供更多信息，以及更丰富的任务背景。

回想过去，我常常有意识地向模型隐藏任务的复杂性。我担心模型可能会因为信息过多而感到困惑，或者无法处理全面的情况。因此，我倾向于将任务简化，只给模型最基本的信息。

然而，随着时间推移，我的态度发生了变化。我现在更倾向于相信模型能够处理更多的信息和更复杂的上下文。我相信模型有能力整合这些丰富的信息，并将其应用到任务中，从而取得更好的结果。

在过去，我可能会过度思考：我是否真的需要给模型这么多信息？是否应该精心筛选，只提供最核心的内容？但现在，我更愿意相信模型的处理能力。

不过，我也在思考，这种变化是否仅仅反映了我个人在使用提示时的态度转变，还是确实反映了人工智能模型本身能力的提升。这是一个值得深思的问题。

I'm always surprised by, yeah, I think a lot of people don't have the instinct to do this. When I want the model to, say, learn a prompting technique, a lot of the time people will start and they'll start describing the prompting technique and I'm just like, give it the paper. So I do, I give it the paper and then I'm like, here's a paper about prompting technique. I just want you to write down 17 examples of this. And then it just does it because I read the paper.

我经常感到惊讶的是，很多人似乎没有意识到这一点。当我想要让模型学习某种提示技巧（prompting technique）时，许多人会直接开始描述这种技巧。而我的做法是，直接给模型看相关的研究论文。

具体来说，我会这样做：首先，我会给模型一篇关于特定提示技巧的论文。然后，我会要求模型根据论文内容生成一些实例，比如说：「这是一篇关于某种提示技巧的论文。请你根据论文内容，写出 17 个使用这种技巧的例子。」

有趣的是，模型通常能够很好地完成这个任务。这是因为我给了它论文作为参考资料，模型可以从中学习并理解这种技巧的本质和应用方法。这种方法利用了大语言模型强大的理解和生成能力，使其能够快速掌握新的概念和技巧。

这个现象也侧面反映了在人工智能训练中，提供高质量、相关的信息源是多么重要。它让我们看到，通过合适的指导和资料，AI 模型能够迅速学习并应用新知识，这对于提高 AI 系统的灵活性和适应能力有着重要意义。

That's interesting. And I think people don't have that intuition somehow where I'm like, but the paper exists.

When would you want to do this?

这确实很有意思。我觉得人们似乎缺乏这种直觉，而我却在想，「嘿，但是论文明明就在那里啊。」

那么，在什么情况下你会想要这么做呢？

So sometimes if I want models to prompt other models or I want to test a new prompting technique, so if papers come out on a prompting technique, rather than try to replicate it by writing up the prompt, I just give it the paper and then i'm like right like basically write a meta prompt for this like uh write something that would cause other models to like do this um or write me a template or like so all of the stuff that you would normally do i'm like if i read a paper and i'm like oh i would like the models i would like to test that style i'm just like it's right there like model can just read the paper, do what I did, and then be like, make another model do this, and then it'll just do the thing. You're like, great, thanks.

有时候，当我想让模型为其他模型创建提示（prompt），或者想测试一种新的提示技术时，我会采用一种特殊的方法。特别是当有新的提示技术相关论文发表时，我不会去手动复现论文中的提示方法。相反，我会直接把论文交给模型。

我会要求模型做以下几件事：

1. 为这篇论文写一个元提示（meta prompt)
2. 创建一些能让其他模型实现论文中技术的提示
3. 为我生成一个模板这种方法可以完成你通常需要手动完成的所有工作。比如，当我读到一篇论文，想测试其中描述的提示风格时，我就可以直接利用模型。模型能够阅读论文，模仿我的思考过程，然后创建一个能让另一个模型执行相应任务的提示。

这样一来，模型就能直接完成任务，而你只需说声「太好了，谢谢」。这种方法大大简化了测试和应用新提示技术的过程。

I give the advice a lot to customers to just respect the model and what it can do. I feel like people feel like they're babying a system a lot of times when they read a prompt. It's like, oh, it's this cute little not that smart thing. I need to really baby it, be like dumb things down to Claude's level. and if you just like think that claude is smart and treat it that way it tends to do pretty good that's like give it the paper it's like i don't need to write a baby like dumbed down version of this paper for claude to understand i can just show it the paper yeah and i think that intuition does it always map for people but that is certainly something that I have come to do more of over time and it's interesting because I do think that prompting has and hasn't changed in a sense like I think what I will do to prompt the models has probably changed over time but fundamentally it's a lot of like imagining your place yourself in the place of the model so maybe it's like how capable you think the model is changes over time.

我经常建议客户要充分认识和利用模型的能力。我发现，很多人在编写提示词时，总是小心翼翼，仿佛在对待一个需要特别呵护的系统。他们会想：「哦，这个 AI 系统不是很聪明，我需要把内容大幅简化，使其适应 Claude 的理解水平。」然而，如果你认识到 Claude 其实相当聪明，并以此为前提与它交互，通常会得到更好的结果。

举个例子，当你需要让 Claude 理解一篇论文时，你不需要为它创建一个过度简化的版本。你可以直接让它阅读原文，它完全有能力理解。

这种认知并不是每个人都能立即接受的，但这确实是我随着时间推移逐渐形成的做法。有趣的是，我认为提示技巧既有变化又有不变之处。我用来提示模型的具体方法可能随时间而改变，但从根本上说，关键还是要设身处地地为模型着想。也许，随着时间的推移，真正发生变化的是我们对模型能力（capability）的认知。

I think someone once laughed at me because I was talking about, I was like thinking about a problem. And then they asked me like what they thought, what I thought the output of something would be. And they were talking about a pre-trained model. And I was like, yeah, no, if I'm a pre-trained model, this looks like this. And then they're like, wait, did you just like simulate what it's like to be a pre-trained model? I'm like, yeah, of course. Like I'm used to just like, yeah, no, if I'm a pre-trained model, this looks like this. And then they're like, wait, did you just simulate what it's like to be a pre-trained model? I'm like, yeah, of course. I'm used to just like I try and inhabit the mind space of a pre-trained model and the mind space of like different RLHF models. And so it's more like the mind space you try to occupy changes. And that can change how you end up prompting the model. That's why now I just give models papers. Because as soon as I was like, oh, I have the mind space of this model, it doesn't need me to baby it. It can just read DML papers. I'll just give it the literature. I might even be like, is there more literature the mind space of this model. It doesn't need me to baby it. It can just read the ML papers. I'll just give it the literature. I might even be like, is there more literature you'd like to read to understand this better?

有人曾经因为我的思考方式而觉得有趣。当时我正在思考一个问题，他们问我对某个预训练模型（pre-trained model）的输出有什么看法。我回答说：「如果我是一个预训练模型，输出大概会是这样的。」他们很惊讶，问道：「等等，你是在模拟预训练模型的思维过程吗？」我说：「是的，这很正常啊。」

事实上，我习惯于设身处地地思考，不仅可以模拟预训练模型的思维方式，还能模拟不同的强化学习人类反馈（RLHF，Reinforcement Learning from Human Feedback）模型的思维方式。这种思维模式的转换可以影响我们如何引导模型工作。

正是因为我能够理解这些模型的「思维空间」，我现在直接给模型提供学术论文来阅读。我意识到，一旦我掌握了模型的思维方式，就不需要过度简化信息。这些模型完全有能力直接阅读机器学习（ML，Machine Learning）相关的论文。我只需要提供相关文献即可。有时，我甚至会问模型：「你需要阅读更多文献来更好地理解这个问题吗？」

这种方法让我们能够更好地利用模型的潜力，而不是将其局限在简单的问答模式中。通过理解和模拟模型的思维方式，我们可以更有效地与之互动，充分发挥其能力。

Do you get any qualia when you're inhabiting the mind space?

I mean, yes, but just because I'm experiencing qualia all the time anyway. Or as in, do I, like...

Is it different, like, correlated somehow with which model you're inhabiting?

Yeah, pre-trained versus RLHF prompting are very different beasts. Because when you're trying to simulate what it's like to be a pre-trained model, it's almost like I land in the middle of a piece of text or something. It's just very like unhuman-like or something. And then I'm like, what happens? What keeps going at this point? And so that's like, whereas like with an RLHF model, like it's much more like, there's lots of things where I's like, whereas like with an RLHF model, like it's much more like, there's also things where I'm like, I might pick up on like subtle things in the query and stuff like that. But yeah, I think I have much more of a like, it's easier to inhabit the mind space of an RLHF model.

当你进入 AI 模型的「思维空间」时，你会感受到任何主观体验吗？

我确实有一些主观体验，但这可能只是因为我一直都在体验各种感受。你是想问我是否...

这种体验是否会因为你所「进入」的模型不同而有所不同？

是的，模拟预训练模型和经过人类反馈强化学习（RLHF，Reinforcement Learning from Human Feedback）的模型是完全不同的体验。当我试图模拟预训练模型的感觉时，就好像我突然置身于一段文本的中间。这种感觉非常不像人类的思维方式。我会思考：接下来会发生什么？文本会如何继续？

相比之下，与 RLHF 模型互动时，体验就大不相同。我可能会注意到用户查询中的一些微妙之处。总的来说，我发现更容易进入 RLHF 模型的「思维空间」。这可能是因为 RLHF 模型的行为更接近人类的思维方式。

Yeah, that's because it's more similar to a human.

Yeah, because like we don't often just like suddenly wake up and are like, I am just generating text.

对，那是因为它更像人类。

没错，因为我们一般不会莫名其妙地醒来，然后想，「哦，我现在就是在生成文本啊」。

I just find it easier to hit the mind space of the pre-trained model.

Oh, interesting.

我只是觉得更容易理解预训练模型（pre-trained model）的思维方式。

哦，这挺有意思的。

I don't know what it is. But like, because RHF is still like this kind of complex beast that I'm not, it's not like super clear to me that we really understand what's going on. And so in some ways it's closer to like my lived experience, which is easier. But in some ways I feel like there's this, all this like, here there'll be dragons out there that I don't know about. Whereas pre-trained, like, I kind of have a decent sense of what the internet looks like. If you gave me a piece of text and said, what comes next? I'm not saying I do good at it, but I kind of get what's going on there. And I don't know. After everything we do after pre-training, I don't really claim to get what's going on as much. Maybe that's just me.

我不太确定那是什么。但是，因为 RHF（Reinforcement Learning from Human Feedback）仍然是一种复杂的机制，我还不能完全理解其中的运作原理。在某些方面，它更接近我的实际经验，这让我感觉更容易理解。但在另一些方面，我觉得这里面还有很多未知的领域，就像古地图上标注的「此处有龙」一样神秘莫测。

相比之下，预训练（pre-training）模型就不同了。我对互联网上的内容大致有个了解。如果你给我一段文字，让我预测接下来会出现什么内容，虽然我可能做得不太好，但至少我能大致理解这个过程是怎么回事。然而，对于预训练之后的所有操作，我就不敢说我真的理解发生了什么。当然，这可能只是我个人的感受。

That's something I wonder about. Is, is it more helpful to have specifically spent a lot of time reading the internet versus like reading books?

Sure. In order to, because I mean, I don't know if books, but like reading stuff that's not on the internet probably is like less valuable per like word read for predicting what a model will do or building intuition than like reading random garbage from social media forums.

这是一个我经常思考的问题：究竟是花大量时间专门阅读互联网内容更有帮助，还是阅读书籍更有价值？

事实上，我认为这个问题值得深入探讨。虽然我不能确定书籍的价值，但是相比于阅读互联网上的内容，阅读非互联网来源的材料可能在帮助我们预测模型行为或建立直觉方面，其每个词的价值都相对较低。特别是与阅读社交媒体论坛上的各种随机信息相比，后者可能反而更有价值。

Yeah, exactly. Yeah.

Okay. So that's, that's the past. Now let's move on to the future of prompt engineering. This is the hottest question right now. Are we all going to be prompt engineers in the future? Is that going to be the final job remaining? Nothing left except us just talking to models all day. What does this look like? Is prompting going to be necessary or will these models just get smart enough in the future to not need it? Anybody want to start on that easy question?

确实如此，没错。

好的，那是过去的事了。现在让我们来谈谈提示工程（prompt engineering）的未来。这可是当前最炙手可热的话题。未来我们是不是都要成为提示工程师？这会不会成为最后仅存的工作？难道除了整天和模型聊天，我们就没有其他事可做了吗？这种情况会是什么样子？未来还需要进行提示（prompting）吗，还是说这些模型会变得足够聪明，不再需要提示了？有谁想来回答这个「简单」的问题吗？

I mean, to some extent, there's the models getting better at understanding what you want them to do. And doing it means that like the amount of thought you need to put into. I mean, there's like an information theory way to think of this. It's like you need to provide enough information such that a thing is specified, right? Like what you want the model to be specified. And to the extent that that's prompt engineering, like I think that will always be around like the ability to actually like clearly state what the goal should be.

从某种程度上说，模型正在变得更擅长理解用户的需求并执行相应的任务。这意味着用户需要投入的思考量可能会减少。我们可以用信息理论的角度来看待这个问题：你需要提供足够的信息来明确指定你的需求，就像你希望模型能够明确理解的内容一样。

在这个层面上，这就涉及到了提示工程（prompt engineering）。我认为提示工程这种能力 —— 也就是清晰地表达目标的能力 —— 将会一直存在。因为无论模型如何进步，准确传达我们的意图始终是至关重要的。

这种趋势反映了人工智能技术的进步：随着模型变得更加智能，它们能够从更少的信息中推断出更多的含义。但同时，用户仍然需要掌握如何有效地与这些模型沟通的技巧，以获得最佳的结果。

Always is funny. If Quad can do that, then that's fine. If Quad is the one setting the goals, then things are out the window. But in the meanwhile, where we can reason about the world in a more normal way, like I think to some extent it's always going to be important to be able to specify like what are you what do you expect to happen and that's actually like sufficiently hard that even if the model gets better at intuiting that from between the lines like i still think there's some amount of writing uh it well but then there's just like i think the tools and the ways we get there should evolve a lot like quad should be able to help me a lot more i should be able to collaborate with quad a lot more to like figure out what i need to write down and what's missing right i think already does this with me all the time i don't know i just close my prompting assistant yeah but i think that's not true for most customers that i talk to at the very least.

这总是很有趣的。如果 Quad （一种 AI 系统）能做到那一点，那就很好。但如果 Quad 是那个设定目标的，那情况就完全不同了。不过，在我们能够以更常规的方式思考世界的同时，我认为在某种程度上，能够明确指出你期望发生什么总是很重要的。这实际上相当困难，即使模型变得更擅长从言外之意中推断这一点，我仍然认为需要一定程度的明确表述。

但是，我认为我们实现目标的工具和方法应该有很大的进步。比如，Quad 应该能够更多地帮助我，我应该能够与 Quad 进行更多的协作，共同确定我需要写下什么，以及还缺少什么。我觉得它已经一直在和我这样做了。哦，我不确定，我刚刚关闭了我的提示助手（prompting assistant）。

不过，我认为对于我接触过的大多数客户来说，至少目前还没有达到这种程度的协作。

So in terms of the future, like how you prompt Claude is probably like a decent direction for what the future looks like. Or how Zach, like, I think maybe this is like a decent place to step back and say, like, asking them how they prompt Claude now. Right. Is probably the future for the vast majority of people, which is an interesting way to think about.

谈到未来，我们可以这样思考：现在人们与 Claude 交互的方式，很可能就是未来的发展方向。或者就像 Zach 那样 —— 这可能是个适合我们停下来思考的好时机 —— 我们可以去了解人们现在是如何与 Claude 对话的。这种方式很可能代表了大多数人在未来与 AI 互动的方式。从这个角度来看，确实是一种很有趣的思考方式。

One freezing cold take is that we'll use models to help us much more in the future to help us with prompting. The reason I say it's freezing cold is that I expect we'll use models for everything more, and prompting is something that we have to do, so we'll probably just use models more to do it along with everything else. For myself, I've found myself using models to write prompts more. One thing that I've been doing a lot is generating examples by giving some realistic inputs to the model. The model writes some answers. I tweak the answers a little bit, which is a lot easier than having to write the full perfect answer myself from scratch. And then I can churn out lots of these. As far as people who haven't had as much prompt engineering experience, the prompt generator can give people a place to start. But I think that's just a super basic version of what we'll have in the future, which is high bandwidth interaction between you and the model as you're writing the prompt, where you're giving feedback like, hey, this result wasn't what I wanted. How can you change it to make it better? And people just grow more comfortable with integrating it into everything they do and this thing in particular.

一个不太出人意料的观点是，我们在未来会更多地使用模型来帮助我们进行提示（prompting）。之所以说这个观点不出人意料，是因为我预计我们在各个方面都会更多地使用模型，而提示又是我们必须要做的事情，所以我们很可能会像处理其他任务一样，更多地使用模型来完成它。

就我个人而言，我发现自己越来越多地使用模型来编写提示。我经常做的一件事是通过给模型一些真实的输入来生成示例。模型会给出一些答案，然后我会对这些答案稍作调整。这比我自己从零开始写出完美答案要容易得多。通过这种方法，我可以快速生成大量高质量的示例。

对于那些缺乏提示工程经验的人来说，提示生成器可以提供一个很好的起点。但我认为，这只是未来我们将拥有的更高级功能的一个基础版本。在未来，当你编写提示时，你将能够与模型进行更深入的交互。你可以给出反馈，比如说：「嘿，这个结果不是我想要的。你能如何改进它？」随着时间的推移，人们会越来越习惯于将这种交互方式整合到他们所做的一切中，尤其是在提示工程这个领域。

Yeah, I'm definitely working a lot with meta prompts now. And that's probably where I spend most of my time is finding prompts that get the model to generate the kinds of outputs or queries or whatever that I want.

没错，我现在确实在大量使用元提示（meta prompts）。我花费最多时间的地方，就是寻找合适的提示。这些提示能够引导模型生成我所需要的各种内容，包括特定类型的输出、查询，或者其他形式的结果。

On the question of like where prompt engineering is going I think this is a very hard question. On the one hand I'm like maybe it's the case that as long as you will want the top like what are we doing when we prompt engineer? It's like what you said. I'm like, I'm not prompt engineering for anything that is like easy for the model. I'm doing it because I want to interact with a model that's like extremely good. And I want to always be finding the kind of like top 1%, top 0.1% of performance and all the things that models can barely do.

关于提示工程（prompt engineering）未来发展方向的问题，我认为这是一个非常难以回答的问题。一方面，我的想法是，也许只要我们追求最顶尖的效果，提示工程就会一直存在。那么，当我们进行提示工程时，我们究竟在做什么呢？就像你所说的那样。我不会为模型轻松能完成的任务做提示工程。我之所以这么做，是因为我想与一个极其优秀的模型进行互动。我的目标始终是在模型勉强能够完成的所有任务中，找到能够达到前 1% 甚至前 0.1% 性能的方法。

models can barely do right like sometimes i actually feel like i interact with this with a model like a step up from what everyone else interacts with for this reason because i'm just so used to like eking out the top performance from models

大语言模型的表现往往不尽如人意。不过，由于我经常尝试挖掘模型的最佳性能，我感觉自己与模型的互动似乎比其他人更深入一层。这可能是因为我已经习惯了设法让模型发挥出最佳水平。

what do you mean by a step up as in like sometimes people will i think that the everyday models that people interact with out in the world it's like i'm interacting with a model that's like uh i don't i don't know how to describe it but like a definitely like a an advanced version that, like almost like a different model. Because they'll be like, oh, well, the models find this thing hard. And I'm like, that thing is trivial. Like, and so it's like, I'm like, I don't know. I have a sense that they're extremely capable. But I think that's because I'm just used to like really like drawing out those capabilities.

当我们谈到 AI 模型的「进阶版本」时，实际上是在讨论一个有趣的现象。有时候，人们在日常生活中接触到的 AI 模型，似乎展现出了超越常规的能力，让人感觉像是在与一个更高级、甚至完全不同的模型进行交互。

这种感觉往往源于人们对 AI 能力的不同认知。例如，有人可能会说：「这个任务对 AI 模型来说很困难。」然而，基于我的经验，我会觉得这个任务其实相当简单。这种认知差异可能会让人产生疑惑。

事实上，我深刻认识到这些大语言模型（Large Language Models）具有极强的潜力。我之所以能够得出这样的结论，很大程度上是因为我习惯于深入挖掘和充分利用这些模型的潜在能力。这种深入探索的过程，让我能够更全面地了解和发挥 AI 模型的真实实力。

这种现象反映出，对于 AI 模型的理解和使用，不同用户可能会有很大的差异。有效地发掘 AI 的潜力，需要我们不断学习和实践，以更好地理解和运用这些强大的工具。

But imagine that you're now in a world where so i think the thing that feels like a transition point is is the point at which the models let's suppose that they just get things at like a human level on a given task or even like an above human level like they know more about the background of the task that you want than you do uh what happens then i'm like maybe prompting becomes something like i ask, I explain to the model what I want and it is kind of prompting me, you know, cause it's like, okay, well, do you mean like, actually there's like four different concepts of this thing that you're talking about? Like, do you want me to use this one or that one? Like, or by the way, I thought of some edge cases cause you said that it's going to be like a pandas data frame, but sometimes you do that and I get a JSONL and i just want to i want to check what you want me to do there do you want me to flag if i get something that's not not a data frame and so that could be a strange transition where like it's just extremely good at receiving instructions but actually has to figure out what you want um and i don't know i could see that being a kind of interesting switch

现在，让我们想象一下这样一个世界：人工智能模型在特定任务上已经达到甚至超越了人类水平。它们对你想要完成的任务的背景了解可能比你还要深入。这种情况下会发生什么呢？

我认为，这可能是一个重要的转折点。提示（prompting）的概念可能会发生根本性的变化。不再是我们单方面地向模型提供指令，而是可能演变成一种交互式的对话。

例如，当你向模型解释你的需求时，它可能会反过来向你提问：「你提到的这个概念实际上有四种不同的解释。你希望我使用哪一种？」或者，「我注意到了一些可能的特殊情况。你说数据会是 pandas 数据框的格式，但有时可能会得到 JSONL 格式的数据。在这种情况下，你希望我如何处理？是否需要我在接收到非数据框格式的数据时做出标记？」

这种转变可能会让人感到有些奇特。模型不仅能够非常擅长地接收指令，还能主动地澄清需求，确保它完全理解你的意图。这种角色的转换可能会带来一种有趣的新型人机交互方式。

anecdotally i've started having claude interview me a lot more. Like that is like the specific way that I try to elicit information because, again, I find the hardest thing to be like actually pulling the right set of information out of my brain and putting that into a prompt is like the hard part to me and not forgetting stuff. And so like specifically asking Claude to like interview me and then turning that into a prompt is a thing that I have turned to a handful of times.

说来有趣，我最近开始越来越多地让 Claude（一个 AI 助手）来「采访」我。这成为了我尝试获取信息的一种特殊方法。因为说实话，对我来说最困难的部分不是记住信息，而是如何从脑海中准确提取出相关信息，并将其组织成一个合适的提示（prompt）。所以，我现在经常会特意要求 Claude 对我进行「采访」，然后再将采访的内容转化为一个提示。这个方法我已经使用了好几次，效果不错。

Yeah, it kind of reminds me of what people will talk about. Or if you listen to like designers talk about how they interact with the person who wants the design. So in some ways I'm like it's this switch from, you know, the temp agency person who comes and you know more about the task and everything that you want. So you give them the instructions and you explain what they should do in edge cases and all this kind of stuff versus when you have an expert that you're actually like consulting to do some work.

嗯，这让我想起人们常谈论的一些事。比如说，你有没有听过设计师讲述他们是如何与客户互动的？从某种程度上来说，我觉得这就像是一种角色转换。一种情况是，你找了一个临时工（temp agency person），你对任务和需求都更了解，所以你需要给他们详细的指示，解释在各种特殊情况下该怎么处理，诸如此类。另一种情况是，你找了一个专家来咨询并完成某项工作。这两种情况是完全不同的。

So I think designers can get really frustrated because they know the space of design really well. And they're like, yeah, okay. The client came to me and he just said, make me a poster, make it bold. And I'm like, that means 7 000 things to me and i'm going to try and ask you some questions so i could see it going from being like temp agency uh employee to being more like designer that you're hiring and that's just like a flip in the relationship i don't know if that's true and i think both might continue but i could see that being why people are like always prompt engineering going to not be a thing in the future because for some domains it might just not be um if the models are just so good that actually prompt engineering going to not be a thing in the future? Because for some domains, it might just not be. If the models are just so good that actually all they need to do is kind of like get the information from your brain and then they can go do the task.

设计师们可能会感到非常沮丧，因为他们对设计领域了如指掌。想象一下，客户来找设计师说：「给我做一个海报，要醒目。」对设计师来说，这句话可能有上千种不同的解读方式。设计师需要问更多的问题来明确客户的需求。

这种情况让我联想到，设计师的角色可能会从类似临时雇员的地位转变为被正式聘用的专业设计师。这种关系的转变是否会真的发生还不确定，两种模式可能会并存。

这种转变也让人思考，未来提示工程（prompt engineering）是否还会存在。因为在某些领域，如果人工智能模型变得足够强大，它们可能只需要直接从人的思维中获取信息，然后自主完成任务。这样一来，精心设计提示词的需求可能就会减少或消失。

不过，这种情况是否会真正发生，以及会在多大程度上发生，目前还不得而知。我们需要持续关注人工智能技术的发展及其对各个行业的影响。

Right. That's actually a really good analogy.

I mean, one common thread I'm pulling out of all your guys' responses here is that there seems to be a future in which this sort of elicitation from the user, drawing out that information, is going to become much more important, much more than it is right now. And already you guys are all starting to do it in a manual way in the future. And in the enterprise side of things, maybe that looks like an expansion off this prompt generating type of concept and things in the console where you're able to actually get more information from that enterprise customer so that they can write a better prompt. In Cloud, maybe it looks like less of just typing into a text box and more of this guided interaction towards a finished product. I think that's actually a pretty compelling vision of future.

没错，这确实是一个非常恰当的比喻。

我注意到，从你们的回答中有一个共同的主题浮现出来：在未来，从用户那里获取信息、引导用户表达需求的能力将变得越来越重要，远超过现在的水平。而你们已经在为这个未来做准备，开始手动实践这种方法。

在企业服务方面，这可能会体现为对当前提示词生成功能的进一步扩展。比如说，在操作界面中增加一些功能，让我们能够更有效地从企业客户那里收集信息，帮助他们创建更优质的提示词。

在云计算领域，未来的交互可能不再局限于简单地在文本框中输入指令。取而代之的可能是一种更具引导性的交互方式，就像是有一位专家在旁边一步步指导你，最终帮助你得到想要的结果。

我认为，这种未来的愿景确实非常吸引人，也很有发展潜力。

And I think that the design analogy probably like really brings that home i was thinking about how prompting now can be kind of like teaching where it's like you know the empathy for the student you're trying to think about how they think about things you're really trying to show them like figure out where they're making a mistake but the point that you're talking, it's like the skill almost becomes one of introspection where you're thinking about what it is that you actually want.

我认为设计类比真的能很好地阐明这一点。我在思考，现在的提示工程（prompting）在某种程度上类似于教学。就像教学需要设身处地为学生着想一样，在进行提示工程时，你需要思考 AI 模型是如何理解和处理信息的。你努力向模型展示正确的方向，就像找出学生犯错的地方并加以指导。

但是，正如你所指出的，这项技能实际上更接近于一种自我反思。在设计提示时，你需要深入思考自己真正想要达成的目标是什么。这种内省的过程帮助你更清晰地定义问题，从而更有效地引导 AI 模型产生所需的输出。

这种方法强调了提示工程不仅仅是关于技术层面的指令编写，更是关于如何准确地表达和传达我们的意图。它要求我们对自己的思维过程和目标有更深入的理解，这与传统的编程或问题解决方法有所不同。

Yeah. And the model's trying to understand you. So it's like making yourself legible to the model versus trying to teach someone who's smarter than you.

This is actually how I think of prompting now in a strange way. So like often my style of prompting, like there's various things that I do, but a common thing that's very like a thing that philosophers will do is I'll define new concepts. So because my thought is like you have to put into words what you want. And sometimes what I want is fairly like nuanced, like the what is a good chart or like uh usually you know like I don't know like how is it that you when should you grade something as being correct or not um and so there's some cases where I will just like invent a concept and then be like here's what I mean by the concept sometimes I'll do it in collaboration with Claude to get it to like figure out what the concept is, just because I'm trying to convey to it what's in my head. And right now the models aren't trying to do that with us unless you kind of prompt them to do so. And so in the future, it might just be that they can elicit that from us rather than us having to kind of do it for them.

是的。模型正在努力理解你。所以这更像是让自己的想法对模型来说更容易理解，而不是试图教导一个比你更聪明的对象。

有趣的是，这实际上是我现在看待提示工程（prompting）的一种新方式。在我的提示风格中，我会采用各种方法，但有一种常见的做法，也是哲学家们经常使用的方法，就是定义新概念。我的理念是，你需要明确表达你的需求。有时候，我想要表达的内容相当复杂和精细，比如什么才算是一个好的图表，或者在什么情况下应该将某件事判定为正确或错误。在这些情况下，我会创造一个新概念，然后解释「这就是我所定义的概念的含义」。有时，我会与 Claude（一个 AI 助手）合作，共同探讨和明确这个概念的定义，因为我的目标是向它准确传达我脑海中的想法。

目前，除非你特意提示它们这样做，否则模型通常不会主动尝试理解我们的思维过程。因此，在未来，可能模型就能够自主地从我们这里提取这些信息，而不需要我们刻意为它们做这些工作。这将使人机交互变得更加自然和高效。

But I think another thing that's kind of interesting, this is like a people have sometimes asked me like oh where is like philosophy relevant to prompting and i actually think it's like very useful in a sense so like a lot of there is like a style of philosophy writing and this is at least how i was taught how to write philosophy where the idea is that um in order to i think it's i think it's like an anti-bullshit device in philosophy, basically, which is that your papers and what you write should be legible to like a kind of educated lay person. Someone just like finds your paper, they pick up and they start reading it and they can understand everything. Not everyone like, you know, achieves this, but that's like kind of the goal of the discipline, I guess, or at least like, this is at least like what we kind of like teach people.

我认为还有一点很有趣，这涉及到人们有时问我的一个问题：哲学与提示技术（prompting）有何相关？实际上，我认为哲学在某种意义上非常有用。

这里有一种哲学写作的风格，也是我学习写作哲学论文时被教导的方法。其核心理念是 —— 我认为这是哲学领域的一种防止胡说八道的机制 —— 你的论文和写作应该让具有一定教育背景的外行人也能理解。换句话说，如果有人偶然看到你的论文，拿起来开始阅读，他们应该能够理解所有内容。

当然，并非所有人都能做到这一点。但我认为这是这门学科的目标，或者至少是我们在教学中强调的重点。

And so I'm really used to this idea of like when i'm writing thinking about the kind of educated lay person who they're really smart but they don't know anything about this topic and that was just like years and years of writing text of that form and i think it was just really good for prompting because i was like oh i'm used to this i have an educated lay person who doesn't know anything about the topic and what i need to do is I need to take extremely complex ideas and I need to make them understand it I don't talk down to them I'm not inaccurate but I need to like phrase things in such a way that it's like extremely clear to them what I mean um and prompting felt very similar and actually the training techniques we use are fascinating or like the things that you said where you're like you say to a person like just just take that thing you said and write it down i used to say that to students all the time like they'd write a paper and i was like i don't quite get what you're saying here can you just like explain your argument to me they would give me an incredibly cogent argument and then i'd be like can you just take that and write it down um and then if they did that was often like a great essay um so it's like really interesting that there's at least that similarity of just like taking things that are in your brain analyzing them enough to feel like you fully understand a great essay. So it's really interesting that there's at least that similarity of just taking things that are in your brain, analyzing them enough to feel like you fully understand them and could take any person off the street who's a reasonable person and just externalize your brain into them. And I feel like that's the core of prompting.

我长期以来一直习惯于这样一种写作理念：在写作时，我会考虑到那些受过良好教育但对特定话题并不了解的读者。这些读者很聪明，但可能对我所讨论的主题知之甚少。多年来，我一直在以这种方式写作，这种经验对于创建 AI 提示（prompting）非常有帮助。

当我面对 AI 系统时，我仿佛面对的就是这样一个聪明但不了解具体话题的读者。我的任务是将极其复杂的想法转化为他们能够理解的形式。在这个过程中，我不会对他们说教，也不会歪曲事实，而是努力用极其清晰的方式表达我的意思。这种体验与创建 AI 提示感觉非常相似。

实际上，我们使用的训练技巧也很有趣。就像你提到的，告诉某人「把你刚才说的写下来」，这是我过去经常对学生说的话。例如，当学生写了一篇论文，而我不太理解其中的某个观点时，我会要求他们口头解释他们的论点。通常，他们会给出一个非常有说服力的解释。然后我会说：「能不能把你刚才说的写下来？」如果他们照做了，往往就能写出一篇很棒的文章。

这种相似性真的很有趣。本质上，这个过程就是把你脑子里的想法提取出来，深入分析直到你完全理解它们，然后用一种任何一个理性的人都能理解的方式表达出来。你要把自己的思维过程完整地展现给别人。我认为，这正是创建有效 AI 提示的核心所在。

That might be the best summary of how to prompt well I've ever heard. In fact, I'm pretty sure it is. Externalize your brain. And then we'll cut to them. In terms of having an education in the thing is a really good way to describe the thing. That was good.

这可能是我听过的关于如何进行有效提示的最佳总结。事实上，我非常确定它就是最佳总结。其核心思想是「将你的思维过程外化」。这种方法不仅适用于提示，还可以应用到其他方面。对于解释某个概念来说，拥有相关的教育背景确实是一个很好的方式。这种描述方法非常出色。

That's, I think, a great way to wrap this conversation. Thank you, guys. This was great.

我想，这是个很好的方式来结束我们的对话。非常感谢各位。这次交流真的很精彩。