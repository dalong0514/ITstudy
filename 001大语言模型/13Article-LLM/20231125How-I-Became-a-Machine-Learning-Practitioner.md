## 20231125How-I-Became-a-Machine-Learning-Practitioner

[How I became a machine learning practitioner](https://blog.gregbrockman.com/how-i-became-a-machine-learning-practitioner)

[我是如何成为机器学习的实践者 [译] | 宝玉的工程技术分享](https://baoyu.io/translations/ai/how-i-became-a-machine-learning-practitioner)

GREG BROCKMAN

Greg Brockman is writing on the SVBTLE network.

gregbrockman.com

JULY 30, 2019

For the first three years of OpenAI, I dreamed of becoming a machine learning expert but made little progress towards that goal. Over the past nine months, I’ve finally made the transition to being a machine learning practitioner. It was hard but not impossible, and I think most people who are good programmers and know (or are willing to learn) the math can do it too. There are many online courses to self-study the technical side, and what turned out to be my biggest blocker was a mental barrier — getting ok with being a beginner again.

Studying machine learning during the 2018 holiday season.

[Deep Learning](https://www.deeplearningbook.org/)

[Stanford University CS231n: Deep Learning for Computer Vision](http://cs231n.stanford.edu/)

[Practical Deep Learning for Coders - Practical Deep Learning](https://course.fast.ai/)

[openai/spinningup: An educational resource to help anyone learn deep reinforcement learning.](https://github.com/openai/spinningup)

[CS 294 Deep Reinforcement Learning, Spring 2017](https://rll.berkeley.edu/deeprlcoursesp17/)

[Quote by Ira Glass: “Nobody tells this to people who are beginners, ...”](https://www.goodreads.com/quotes/309485-nobody-tells-this-to-people-who-are-beginners-i-wish)

在 OpenAI 的最初三年，我一直梦想着成为一名机器学习专家，但在这方面的进展寥寥。然而，在过去的九个月里，我终于实现了成为一名机器学习从业者的转变。这个过程虽然艰难，但并非不可能，我相信那些熟练的程序员们，只要他们了解（或愿意学习）数学，也能做到。网络上有众多课程可供自学这些技术方面，而对我来说，最大的挑战是打破心理障碍 —— 接受自己又回到了初学者的状态。

图片：在 2018 年假期期间学习机器学习

### 01. Early days

A founding principle of OpenAI is that we value research and engineering equally — our goal is to build working systems that solve previously impossible tasks, so we need both. (In fact, our team is comprised of 25% people primarily using software skills, 25% primarily using machine learning skills, and 50% doing a hybrid of the two.) So from day one of OpenAI, my software skills were always in demand, and I kept procrastinating on picking up the machine learning skills I wanted.

After helping build OpenAI Gym, I was called to work on Universe. And as Universe was winding down, we decided to start working on Dota — and we needed someone to turn the game into a reinforcement learning environment before any machine learning could begin.

[OpenAI Gym Beta](https://openai.com/research/openai-gym-beta)

[Universe](https://openai.com/research/universe)

[OpenAI Five defeats Dota 2 world champions](https://openai.com/research/openai-five-defeats-dota-2-world-champions#timeline)

初期探索

OpenAI 的核心理念之一是，研究与工程同等重要 —— 我们的目标是构建能够完成以往难以解决任务的系统，因此两者都不可或缺。（实际上，我们团队中有 25% 的成员主要依赖软件技能，25% 的成员主要运用机器学习技能，而另外 50% 的成员则在这两方面都有所涉猎。）因此，从 OpenAI 成立之初，我的软件技能就一直是备受欢迎的，这也导致我一直推迟学习我心仪的机器学习技能。

在参与建设 OpenAI Gym 之后，我转而投入到 Universe 项目的工作中。随着 Universe 项目的结束，我们决定着手研究 Dota —— 在开始任何机器学习工作之前，我们需要有人把这款游戏变成一个适合强化学习的环境。

### 02. Dota

Turning such a complex game into a research environment without source code access was awesome work, and the team’s excitement every time I overcame a new obstacle was deeply validating. I figured out how to break out of the game’s Lua sandbox, LD_PRELOAD in a Go GRPC server to programmatically control the game, incrementally dump the whole game state into a Protobuf, and build a Python library and abstractions with future compatibility for the many different multiagent configurations we might want to use.

But I felt half blind. At Stripe, though I gravitated towards infrastructure solutions, I could make changes anywhere in the stack since I knew the product code intimately. In Dota, I was constrained to looking at all problems through a software lens, which sometimes meant I tried to solve hard problems that could be avoided by just doing the machine learning slightly differently.

I wanted to be like my teammates Jakub Pachocki and Szymon Sidor, who had made the core breakthrough that powered our Dota bot. They had questioned the common wisdom within OpenAI that reinforcement algorithms didn’t scale. They wrote a distributed reinforcement learning framework called Rapid and scaled it exponentially every two weeks or so, and we never hit a wall with it. I wanted to be able to make critical contributions like that which combined software and machine learning skills.

Szymon on the left; Jakub on the right.

In July 2017, it looked like I might have my chance. The software infrastructure was stable, and I began work on a machine learning project. My goal was to use behavioral cloning to teach a neural network from human training data. But I wasn’t quite prepared for just how much I would feel like a beginner.

I kept being frustrated by small workflow details which made me uncertain if I was making progress, such as not being certain which code a given experiment had used or realizing I needed to compare against a result from last week that I hadn’t properly archived. To make things worse, I kept discovering small bugs that had been corrupting my results the whole time.

I didn’t feel confident in my work, but to make it worse, other people did. People would mention how how hard behavioral cloning from human data is. I always made sure to correct them by pointing out that I was a newbie, and this probably said more about my abilities than the problem.

It all briefly felt worth it when my code made it into the bot, as Jie Tang used it as the starting point for creep blocking which he then fine-tuned with reinforcement learning. But soon Jie figured out how to get better results without using my code, and I had nothing to show for my efforts.

I never tried machine learning on the Dota project again.

[Building Dota Bots That Beat Pros - OpenAI's Greg Brockman, Szymon Sidor, and Sam Altman - YouTube](https://www.youtube.com/watch?v=UdIPveR__jw)

[c - What is the LD\_PRELOAD trick? - Stack Overflow](https://stackoverflow.com/questions/426230/what-is-the-ld-preload-trick/426260#426260)

[#define CTO](https://blog.gregbrockman.com/figuring-out-the-cto-role-at-stripe)

Dota

将 Dota 这样复杂的游戏变成研究环境，而且还是在没有源代码的情况下，团队所做的工作真是令人称赞。每次我克服新的难关时，团队的激动情绪都极大地鼓励了我。我设法破解了游戏的 Lua 沙盒环境，利用 LD_PRELOAD 在 Go GRPC 服务器中控制游戏，将游戏状态逐步转换成 Protobuf 格式，并为我们可能采用的多种多智能体配置开发了一个 Python 库和相关抽象。

但我感觉自己像是半盲。在 Stripe 工作时，尽管我倾向于基础设施解决方案，但我对产品代码了如指掌，可以在整个技术栈中进行修改。在 Dota 项目中，我只能通过软件的视角来解决问题，这有时意味着我试图解决一些通过稍微改变机器学习方法就可以避免的复杂问题。

我渴望能像我的同事 Jakub Pachocki 和 Szymon Sidor 那样。他们对 OpenAI 内部普遍认为强化算法不可扩展的看法提出了质疑。他们开发了一个名为 Rapid 的分布式强化学习框架，大约每两周就实现指数级扩展，我们从未遇到过任何障碍。我希望能够像他们那样，结合软件和机器学习技能，做出关键性的贡献。

图片：左边是 Szymon；右边是 Jakub

2017 年 7 月，我似乎看到了机会。软件基础设施稳定后，我开始从事一个机器学习项目。我的目标是利用行为克隆，通过人类训练数据来训练神经网络。但我没有准备好，面对自己如同初学者般的挑战。

我不断被一些小的工作流程细节困扰，这让我不确定自己是否真正取得了进展，例如不确定某个特定实验使用了哪些代码，或者意识到我需要与上周的某个我未能妥善保存的结果进行比较。更糟糕的是，我不断发现一些小错误，这些错误一直在影响我的研究成果。

虽然我对自己的工作不够自信，但其他人却意外地对我评价很高。他们经常提到，从人类数据中进行行为克隆是多么的困难。每当这时，我总会指出自己还只是个初学者，这或许更多地说明了我个人的能力限制，而不是问题本身有多复杂。

尽管如此，当我的代码被应用到机器人上时，我感到所有努力都是值得的。Jie Tang 把我的代码作为 creep blocking 的基础，并通过强化学习进行了进一步的微调。然而不久之后，Jie 发现了一种不需要用到我的代码就能取得更好成果的方法。我的所有努力似乎都付诸东流了。

从那以后，我就再也没有在 Dota 项目中尝试过机器学习。

### 03. Time out

After we lost two games in The International in 2018, most observers thought we’d topped out what our approach could do. But we knew from our metrics that we were right on the edge of success and mostly needed more training. This meant the demands on my time had relented, and in November 2018, I felt I had an opening to take a gamble with three months of my time.

ti-elevator.pngTeam members in high spirits after losing our first game at The International.

I learn best when I have something specific in mind to build. I decided to try building a chatbot. I started self-studying the curriculum we developed for our Fellows program, selecting only the NLP-relevant modules. For example, I wrote and trained an LSTM language model and then a Transformer-based one. I also read up on topics like information theory and read many papers, poring over each line until I fully absorbed it.

It was slow going, but this time I expected it. I didn’t experience flow state. I was reminded of how I’d felt when I just started programming, and I kept thinking of how many years it had taken to achieve a feeling of mastery. I honestly wasn’t confident that I would ever become good at machine learning. But I kept pushing because… well, honestly because I didn’t want to be constrained to only understanding one part of my projects. I wanted to see the whole picture clearly.

My personal life was also an important factor in keeping me going. I’d begun a relationship with someone who made me feel it was ok if I failed. I spent our first holiday season together beating my head against the machine learning wall, but she was there with me no matter how many planned activities it meant skipping.

One important conceptual step was overcoming a barrier I’d been too timid to do with Dota: make substantive changes to someone else’s machine learning code. I fine-tuned GPT-1 on chat datasets I’d found, and made a small change to add my own naive sampling code. But it became so painfully slow as I tried to generate longer messages that my frustration overwhelmed my fear, and I implemented GPU caching — a change which touched the entire model.

I had to try a few times, throwing out my changes as they exceeded the complexity I could hold in my head. By the time I got it working a few days later, I realized I’d learned something that I would have previously thought impossible: I now understood how the whole model was put together, down to small stylistic details like how the codebase elegantly handles TensorFlow variable scopes.

[OpenAI Fellows Fall 2018](https://openai.com/blog/openai-fellows)

[openai/finetune-transformer-lm: Code and model for the paper "Improving Language Understanding by Generative Pre-Training"](https://github.com/openai/finetune-transformer-lm)

暂停时间

在 2018 年国际邀请赛 (The International) 中连续输掉两场比赛后，许多人认为我们的策略已达极限。然而，我们从数据中看到，成功就在眼前，我们更多地需要的是训练。这让我有了更多个人时间，2018 年 11 月，我决定用接下来的三个月时间，尝试一次冒险。

图片：在国际邀请赛中首场失利后，我们团队的士气依然高昂

我发现，当我有明确的构建目标时，学习效率最高。我打算尝试制作一个聊天机器人。我开始自学我们为 Fellows 项目设计的课程，仅选择与自然语言处理 (NLP) 相关的部分。例如，我编写并训练了一个基于 LSTM 的语言模型，接着又尝试了基于 Transformer 的模型。我还深入研究了信息理论等领域，并细读了许多论文，直到彻底理解每一行内容。

虽然进展缓慢，但我已有所预期。我并没有进入那种高效的「流状态」。这让我回想起刚开始学编程时的挑战，以及我花了多少年才感觉自己掌握了编程技能。坦白说，我对自己能否精通机器学习并不自信。但我还是坚持下去，因为我不想只局限于理解项目的一部分。我希望能完全清楚地看到整个项目的全貌。

我的个人生活也在鼓励我继续前进。我开始了一段新的关系，我的伴侣让我觉得即使失败也没关系。我们一起度过了第一个假期，我大部分时间都在努力破解机器学习的难题，尽管这意味着我们错过了许多计划好的活动，但她始终陪伴在我身边。

我迈出了一个重要的概念性步骤，克服了我之前在 Dota 中未曾尝试的障碍：大胆修改别人的机器学习代码。我对找到的聊天数据集进行了 GPT-1 的调整，甚至加入了我自己简单的采样代码。但当我尝试生成更长的信息时，程序变得极其缓慢，这种挫败感最终克服了我的恐惧，促使我实现了 GPU 缓存的优化，这一改动影响了整个模型。

我多次尝试，却因为难以理解的复杂性而放弃了之前的修改。但几天后，当我终于让程序正常运行，我突然领悟到了一些我以前认为不可能的知识：我现在不仅理解了整个模型的组成，还领会了一些细微之处，比如代码库是如何巧妙地处理 TensorFlow 的变量作用域。

### 04. Retooled

After three months of self-study, I felt ready to work on an actual project. This was also the first point where I felt I could benefit from the many experts we have at OpenAI, and I was delighted when Jakub and my co-founder Ilya Sutskever agreed to advise me.

ilya.pngIlya singing karaoke at our company offsite.

We started to get very exciting results, and Jakub and Szymon joined the project full-time. I feel proud every time I see a commit from them in the machine learning codebase I’d started.

I’m starting to feel competent, though I haven’t yet achieved mastery. I’m seeing this reflected in the number of hours I can motivate myself to spend focused on doing machine learning work — I’m now around 75% of the number of coding hours from where I’ve been historically.

But for the first time, I feel that I’m on trajectory. At first, I was overwhelmed by the seemingly endless stream of new machine learning concepts. Within the first six months, I realized that I could make progress without constantly learning entirely new primitives. I still need to get more experience with many skills, such as initializing a network or setting a learning rate schedule, but now the work feels incremental rather than potentially impossible.

From our Fellows and Scholars programs, I’d known that software engineers with solid fundamentals in linear algebra and probability can become machine learning engineers with just a few months of self study. But somehow I’d convinced myself that I was the exception and couldn’t learn. But I was wrong — even embedded in the middle of OpenAI, I couldn’t make the transition because I was unwilling to become a beginner again.

You’re probably not an exception either. If you’d like to become a deep learning practitioner, you can. You need to give yourself the space and time to fail. If you learn from enough failures, you’ll succeed — and it’ll probably take much less time than you expect.

At some point, it does become important to surround yourself by existing experts. And that is one place where I’m incredibly lucky. If you’re a great software engineer who reaches that point, keep in mind there’s a way you can be surrounded by the same people as I am — apply to OpenAI!

[X 上的 Sam Altman：“.@gdb sends me his rescuetime screenshots occasionally and i always feel like such a slacker... https://t.co/Vry6Gt4xE5” / X](https://twitter.com/sama/status/792898456650076160?lang=en)

[Careers](https://openai.com/careers)

转变路径

自学了三个月后，我感到自己已经准备好着手一个真正的项目了。这也是我首次意识到，自己能从 OpenAI 的众多专家中获益良多，当 Jakub 和我的联合创始人 Ilya Sutskever 表示愿意指导我时，我非常激动。

图片：Ilya 在公司远足活动中唱卡拉 OK 的场景

我们项目的成果开始变得异常激动人心，Jakub 和 Szymon 也全职加入了这个项目。每当我看到他们在我创立的机器学习代码库中贡献代码时，我都感到非常自豪。

虽然我还未达到精通水平，但我开始感觉自己越来越胜任了。这一点从我愿意投入到机器学习工作中的时间就能看出 —— 我现在的编程时间已经达到了我以往水平的 75%。

但这是我第一次感觉自己正在正确的道路上。起初，我几乎被源源不断的新机器学习概念淹没。但在最初的六个月里，我意识到，我可以在不断掌握全新基础元素的情况下取得进展。我还需要在许多技能上积累更多经验，如初始化网络或制定学习率计划，但现在，这些工作感觉像是一步步进步，而不再是遥不可及的挑战。

通过我们的 Fellows 和 Scholars 计划，我了解到，拥有扎实线性代数和概率知识的软件工程师，只需几个月的自学就能转型为机器学习工程师。但我曾自欺欺人，认为自己是个例外，不能学会这些。然而，我错了 —— 即便我身处 OpenAI 的核心，我也无法实现这一转变，因为我不愿重新成为一个初学者。

你可能也不是例外。如果你想成为深度学习的实践者，那么你完全有可能做到。你需要给自己留出失败的空间和时间。只要你能从足够多的失败中吸取教训，你最终会成功 —— 而且这可能比你预期的要快得多。

到了某个阶段，让自己被现有专家所包围变得至关重要。这正是我非常幸运的一点。如果你是一名优秀的软件工程师，并且达到了这个阶段，请记住，你也可以像我一样，被同样的人包围 — 请申请加入 OpenAI！