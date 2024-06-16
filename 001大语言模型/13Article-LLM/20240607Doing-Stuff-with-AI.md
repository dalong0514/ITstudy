## 20240607Doing-Stuff-with-AI

[Doing Stuff with AI: Opinionated Midyear Edition](https://www.oneusefulthing.org/p/doing-stuff-with-ai-opinionated-midyear?utm_source=profile&utm_medium=reader2)

AI systems have gotten more capable and easier to use

ETHAN MOLLICK

JUN 06, 2024

Every six months or so, I write a guide to doing stuff with AI. A lot has changed since the last guide, while a few important things have stayed the same. It is time for an update. This is usually a serious endeavor, but, heeding the advice of Allie Miller, I wanted to start with a different entry point into AI: fun.

AI 应用指南：2024 年中更新版

每隔半年左右，我都会写一篇关于如何利用 AI 的指南。自上次指南发布以来，很多事情发生了变化，但一些重要的关键点仍然保持不变。现在是时候更新一下了。虽然这通常是一项严肃的任务，但这次我听从 Allie Miller 的建议，决定从一个有趣的角度切入 AI 的世界。

### 01. Experiencing AI through play

I have given talks to thousands of people about AI, and there are lots of things that I can demo that tend to amaze or worry folks, but there is one thing that never fails to delight: making a song.

So, before you do anything else, go to Suno (which you can also access via Microsoft Copilot) or Udio and make a song. Even if you have done it before, the updated models are so much better, that you should try again. Here, for example, is the modern jazz pop rendition of the abstract to Attention is All You Need, the paper that kicked off Large Language Models. It's surprisingly catchy. Seriously give it 25 seconds, I have been singing the chorus to myself all day.

But if you want another playful audio way to experience the same paper, take a listen to the first entry in Google's Illuminate demo, which turns papers into NPR-style radio interviews. It is worth a few moments of your time to play one to see how realistic it sounds - the little breaths, pauses, and interactions between the virtual hosts all sell the idea. Of course, even these playful applications of AI expose some of the issues that haunt Generative AI overall. For example, we don't know which data was used to train AI music models, and what its implications are for artists.

So, if you don't want to start with music, there are lots of other playful entry points, which are fun, but also show you some of the quirks and limits of LLMs. Here is a GPT that makes tasks as complex as possible and creates a flow chart for you, most of the time (sometimes the AI forgets it can make flow charts and needs to be reminded). Here is a GPT I made that turns the AI into a dungeon master for a made-up game of your choice (as a side note, LLMs work best when they can write out a plan for what they are doing, but that would give away the game details, so the GPT is instructed to do its planning in Chinese in hidden code blocks, so as not to give away spoilers). Or if you want to get really weird, you can try Websim, which generates a fake early 2000s website for you to browse based on a URL you enter. If all of this is too much, just having a conversation with the voice mode of an AI system is often an interesting and playful entry point.

Output image

How to write a Substack post about AI, in the most complex way possible

Playing with AI is ultimately serious - it is a good way to get to see what the AI can and can't do, where it is "imaginative" and where it is cliched. For example, see what happened when I just prompted Claude with the words "garlic bread" and then kept telling it that I wanted it to do something else. Playful, weird, and, I think, also illuminating.

But enough play, let's get to work.

用游戏的方式体验 AI

我给成千上万的人做过关于 AI 的演讲，期间展示了很多令人惊讶或担忧的 AI 应用，但有一件事总是让人特别开心：制作一首歌曲。

所以，在你做任何其他事情之前，先去 Suno（也可以通过 Microsoft Copilot 访问）或 Udio 制作一首歌曲吧。即使你之前试过，这次更新的模型更加出色，值得再试一次。例如，这里有一首现代爵士流行风格的歌曲，它是论文 Attention is All You Need 的摘要改编版，这篇论文开启了大语言模型的时代。这首歌出奇地好听。真的，给它 25 秒的时间，我一整天都在哼唱它的副歌。

如果你想通过另一种有趣的音频方式体验这篇论文，可以听一下 Google 的 Illuminate 演示的第一个条目，它将论文变成了 NPR 风格的电台采访。花几分钟时间播放一下，看看它有多么逼真 —— 虚拟主持人之间的小呼吸、停顿和互动都让这个演示更加生动。当然，即使是这些有趣的 AI 应用也暴露了一些生成式 AI 的问题。例如，我们不知道这些 AI 音乐模型是用什么数据训练的，这对艺术家可能意味着什么。

所以，如果你不想从音乐开始，还有很多其他有趣的切入点。这些切入点不仅有趣，还能展示大语言模型（LLM）的一些特点和局限性。比如，这里有一个 GPT 它会把任务变得尽可能复杂，并为你创建流程图（虽然有时 AI 会忘记它能够做这件事，需要我们提醒）。还有一个我制作的 GPT，它能把 AI 变成一个你选择的虚构游戏的地牢主（顺便说一句，LLM 在写出计划时效果最佳，但这样会透露游戏细节，所以这个 GPT 被指示使用隐藏的中文代码块来计划，以免剧透）。如果你想要更奇特的体验，可以试试 Websim，它会根据你输入的 URL 生成一个仿 2000 年代早期的网站供你浏览。如果这些都不合你意，与 AI 系统的语音模式进行对话也是一个有趣的切入点。

图：如何用最复杂的方式撰写关于 AI 的 Substack 文章

玩 AI 最终是认真的 —— 这是了解 AI 能做什么和不能做什么的好方法，可以看出 AI 在哪些地方有创意，哪些地方是陈词滥调。例如，当我用「蒜蓉面包」提示 Claude 时，看看会发生什么。我不断要求它做不同的事情，过程既有趣又奇怪，同时也很有启发性。

但是，玩够了，让我们开始工作吧。

### 02. Getting serious: using AI to do stuff

The core of serious work with generative AI is the Large Language Model, the technology enabled by the paper celebrated in the song above. I won't spend a lot of time on LLMs and how they work, but there are now some excellent explanations out there. My favorites are the Jargon-Free Guide and this more technical (but remarkably clear) video, but the classic work by Wolfram is also good. You don't need to know any of these details, since LLMs don't require technical knowledge to use, but they can serve as useful background.

To learn to do serious stuff with AI, choose a Large Language Model and just use it to do serious stuff - get advice, summarize meetings, generate ideas, write, produce reports, fill out forms, discuss strategy - whatever you do at work, ask the AI to help. A lot of people I talk to seem to get the most benefit from engaging the AI in conversation, often because it gives good advice, but also because just talking through an issue yourself can be very helpful. I know this may not seem particularly profound, but "always invite AI to the table" is the principle in my book that people tell me had the biggest impact on them. You won't know what AI can (and can't) do for you until you try to use it for everything you do. And don't sweat prompting too much, though here are some useful tips, just start a conversation with AI and see where it goes.

You do need to use one of the most advanced frontier models, however. As I have discussed repeatedly, only these models can show you what AI can do. The last time I wrote a guide, there was only one frontier model, now there are three: Claude 3 Opus, Gemini 1.5 and GPT-4. Others are coming soon but, as of now, those are your choices. Last time I wrote the guide, most people were still using an obsolete model because it was free and everyone had heard of it (free ChatGPT, which was, at the time, powered by GPT-3.5), today everyone going to ChatGPT gets free access to the same advanced model, GPT-4o.

The biggest change is that all of these models now do a lot more than they used to:

Connect to the internet. GPT-4 and Gemini are both connected to the internet. That means that they can access updated information after their training completed, but also means that they can do research tasks, though they still can hallucinate incorrect answers. If you really want to do research, however, a specialized AI model, Perplexity, may be a better choice, as it has a great interface and specialized tools that are optimized for research.

Make images. GPT-4 and Gemini both create images, but, at least for now, they do it in a relatively crude way. When you ask these LLMs to create images, they actually write a prompt for a separate image generation tool and show you the results. That means that they do not directly control the image, and the image generation tool is not as smart as the LLM itself. If you ask the AI to "make sure there are no elephants in the picture" it may send a prompt telling the image generator "and do not show elephants" but the image generator just sees the word "elephants" and gives you some.

In general, image generation tools have improved a lot (see the pictures below for a comparison of models from this and last years) but Gemini and GPT-4 do not have access to the best tools, though that may change soon. Instead, you may want to pick from many standalone image models. Consider Adobe Firefly, which is not as strong as other models but has the most artist-friendly approach to training, using only images they have licensed. Or you may want to look at Midjourney, which is probably the best image creator, but whose training policies are unclear.

Prompt: "Fashion photoshoot of sneakers inspired by Van Gogh" - the first images that were created by each model

Runs Code and Does Data Analysis. Technically, these are very similar, because both of these capabilities are enabled by the fact that when AI can write and run code, it can do a lot. Some of the most interesting advances in the last couple of weeks have been advanced data analysis interfaces added to both GPT-4o and Gemini. As you can see below, GPT-4 continues to be the leader in this area, with more advanced features (including interactive graphs and tools to visualize datasets) and a better "instinct" for analysis.

What data analysis looks like in GPT-4 and Gemini

Sees images: The ability of AIs to "see" images remains an underused capability, since it adds a tremendous amount of value to the system. I think reading through the Microsoft report on GPT-4's vision is a helpful way to understand some of the implications.

Sees video: As the immediate memory, or context window, of AIs grow, they can start to work directly with videos, keeping an entire video in memory at once. Gemini has a startlingly large context window, and I can give it a 30 minute video of a museum walkthrough and ask it to tell me what happens when, and which moments might appeal to kids. A complex task for humans takes less than a minute for AI and suggests why working with video is something that will have large implications.

Reads Files/Works with Documents. Being able to upload documents makes the AI much useful for summarizing, analyzing, and improving your work. Some of the AIs now connect directly to your documents, like Microsoft Copilot and Office and Gemini and Google Docs, but these interactions are still a bit buggy. The best AI for working with PDFs and text files is probably Claude 3 Opus, which combines both a large context window and a very clever AI that seems to do very well with written work. I gave a legal document to Claude today, and it found an issue that neither side's lawyers had identified, but which everyone agreed was important after Claude pointed it out. I wouldn't use it to replace a lawyer/doctor/editor, but a cheap second opinion that is mostly right is very valuable.

GPTS: I have written a lot about why GPTs are valuable, they are ways of sharing useful automated tools with others. Currently only ChatGPT supports them.

Overall, you can't go terribly wrong with any of the major frontier LLMs, but you will find each has its own strengths and weaknesses, and the situation is evolving quickly.

严肃起来：用 AI 做事情

生成式 AI（Generative AI）工作的核心是大语言模型（Large Language Model)，这项技术的基础是前面提到的那篇论文。我不会详细讲解大语言模型的工作原理，但现在已经有一些很好的资源了。我特别推荐《通俗指南》和一个清晰的技术视频，当然，Wolfram 的经典著作也值得一读。虽然你在使用大语言模型时不需要掌握技术细节，但了解这些背景知识会很有帮助。

[A jargon-free explanation of how AI large language models work | Ars Technica](https://arstechnica.com/science/2023/07/a-jargon-free-explanation-of-how-ai-large-language-models-work/)

[But what is a GPT? Visual intro to transformers | Chapter 5, Deep Learning - YouTube](https://www.youtube.com/watch?v=wjZofJX0v4M)

要用 AI 做重要的事情，首先选择一个大语言模型，然后让它帮你完成各种任务 —— 获取建议、总结会议、生成创意、写作、制作报告、填写表格、讨论策略等。无论你在工作中做什么，都可以让 AI 参与进来。我发现，很多人从与 AI 的对话中受益匪浅，这不仅是因为 AI 提供了有价值的建议，还因为通过讨论问题本身也能带来启发。我知道这听起来可能不复杂，但「总是邀请 AI 参与」是我书中的一条重要原则，很多人告诉我这对他们的影响最大。只有在你尝试将 AI 应用于所有事务时，才能真正了解它的能力。所以，不要过于纠结于提示，直接开始与 AI 对话，看看会发生什么。

不过，你确实需要使用最先进的前沿模型。正如我多次提到的，只有这些模型才能展现 AI 的真正潜力。上次我写指南时，只有一个前沿模型，现在有三个：Claude 3 Opus，Gemini 1.5 和 GPT-4。其他模型也即将面世，但目前，这些是你的选择。上次写指南时，大多数人仍在使用免费的 ChatGPT（当时由 GPT-3.5 提供支持），现在，所有使用 ChatGPT 的人都可以免费访问最新的 GPT-4o 模型。

最大的变化是这些模型现在能做很多以前做不到的事情：

1、连接到互联网。GPT-4 和 Gemini 都连接到了互联网。这不仅使它们在训练后可以访问更新的信息，还可以执行研究任务，尽管它们有时仍会给出错误答案。如果你真的想进行研究，可以选择 Perplexity 这类专门的 AI 模型，它有一个很好的界面，并配备了优化的研究工具。

2、生成图像。虽然 GPT-4 和 Gemini 也能生成图像，但目前它们的方式还比较粗糙。当你请求这些大语言模型生成图像时，它们实际上是为一个单独的图像生成工具编写提示并显示结果。这意味着它们无法直接控制图像，而图像生成工具的智能程度也不如大语言模型。如果你要求 AI「确保图片中没有大象」，它可能会发送一个提示给图像生成器「不要显示大象」，但图像生成器只会识别到「大象」这个词，然后仍然生成大象的图像。

总体来说，图像生成工具已经得到了很大的改进（见下图，对比今年和去年的模型），但目前 Gemini 和 GPT-4 还没有使用最好的工具，不过这可能很快就会改变。你可以选择许多独立的图像生成模型，比如 Adobe Firefly，它虽然不如其他模型强大，但在训练时只使用了授权图像，对于艺术家来说更友好。你也可以考虑 Midjourney，它可能是最好的图像生成器，但其训练策略尚不明确。

提示：「受梵高启发的运动鞋时尚拍摄」- 每个模型创建的第一张图像

3、运行代码和数据分析。从技术角度看，这两者非常相似，因为 AI 能够编写和运行代码后，可以实现很多功能。最近几周，一些最有趣的进展是 GPT-4 和 Gemini 都加入了高级数据分析界面。如图所示，GPT-4 在该领域依然领先，提供了更高级的功能（包括交互图表和数据集可视化工具）以及更出色的分析「直觉」。

GPT-4 和 Gemini 的数据分析界面

4、图像处理：AI 处理图像的能力仍然未被充分利用，但它能为系统带来巨大的价值。我认为，阅读微软关于 GPT-4 视觉能力的报告有助于理解其影响。

[[2309.17421] The Dawn of LMMs: Preliminary Explorations with GPT-4V(ision)](https://arxiv.org/abs/2309.17421)

5、视频处理：随着 AI 的即时记忆或上下文窗口的增加，它们可以开始直接处理视频，并将整个视频保存在记忆中。Gemini 拥有极大的上下文窗口，我可以将一个 30 分钟的博物馆漫步视频交给它，让它告诉我每个时间点发生了什么，以及哪些时刻可能吸引孩子们。对于人类来说，这是一项复杂的任务，但 AI 只需不到一分钟就能完成，这显示了视频处理将带来的巨大影响。

6、读取文件/处理文档。可以上传文档使 AI 在总结、分析和改进工作时变得非常有用。现在有些 AI 可以直接连接到你的文档，例如 Microsoft Copilot 和 Office 以及 Gemini 和 Google Docs，但这些交互仍然有些问题。处理 PDF 和文本文件的最佳 AI 可能是 Claude 3 Opus，它结合了大上下文窗口和非常聪明的 AI，似乎在处理书面工作方面表现出色。我今天给了 Claude 一份法律文件，它发现了一个双方律师都忽略的问题，大家后来都同意这是一个重要的问题。我不会用它来取代律师、医生或编辑，但一个大多数情况下是正确的廉价第二意见是非常有价值的。

7、GPTS：我已经写了很多关于 GPTs 的价值，它们是与他人分享有用的自动化工具的方法。目前只有 ChatGPT 支持它们。

总体而言，使用任何一个主要的前沿大语言模型都不会有太大问题，但你会发现每个模型都有自己的优点和缺点，而且情况在快速变化。

### 03. Already obsolete

In some ways, this list is already outdated. We know new features are coming soon in GPT-4o, including native ability to work with voice at a very high level, and multimodal image creation that will be more accurate than previous image generators. Though video tools like Runway exist now, we know that Google and OpenAI both have systems that can generate high quality video from prompts alone. Smaller AI models that can run on your phone are available and will soon connect to larger networks of AIs to solve hard problems. And the nature of our interaction with AIs themselves might be changing, as agents and AI devices start to spread.

Even more importantly, in conversations with folks at AI labs, and in the public statements of people with some knowledge of the future, I see a new recent confidence that the next round of AI models will be much smarter than the ones we are using today, opening up new use cases, opportunities, and risks. If they are right, then this post is already an artefact of the past, a list of already obsolete AIs.

Two notes: First, I don't take any money from any AI labs or any other AI company I discuss. Second you may have noticed that you have the option to pledge a subscription to this Substack. A lot of you have voluntarily done so - thank you! But for almost two years, I haven't collected any of those pledges. I am planning on starting to do so in the next week or so. But you should know that I intend to keep this Substack free for everyone, and to publish on my own schedule, so pledging doesn't currently get you anything special other than my deepest thanks! I will let you know if I start to add subscriber-only features, but if you wanted to change or cancel your pledge, here are the directions.

已经过时

在某些方面，这个列表已经过时了。我们知道 GPT-4o 很快会有新功能，包括以非常高水平处理语音的原生能力，以及比以前的图像生成器更准确的多模态图像创建。尽管现在有像 Runway 这样的视频工具，我们知道 Google 和 OpenAI 都有系统可以仅通过提示生成高质量视频。可以在手机上运行的小型 AI 模型已经出现，并且很快会连接到更大的 AI 网络以解决复杂问题。随着 AI 智能体和 AI 设备的普及，我们与 AI 的互动方式也可能会发生变化。

更重要的是，通过与 AI 实验室的人员交流，以及听取一些了解未来趋势的人的公开发言，我发现大家最近对于下一代 AI 模型将大大超越目前的信心有所增加，这将带来新的应用场景、机会和风险。如果他们是正确的，那么这篇文章已经成为过去时，所列的 AI 已经过时。

备注两点：首先，我没有从任何 AI 实验室或其他我提到的 AI 公司收取任何费用。其次，你可能已经注意到，你可以选择订阅这个 Substack。许多人已经自愿订阅 —— 感谢你们！但在将近两年的时间里，我没有收取任何订阅费用。我计划在接下来的一周左右开始收费。不过你应该知道，我打算继续让这个 Substack 对所有人免费，并按照我的时间表发布内容，所以订阅目前不会带来任何特别的好处，除了我最诚挚的感谢！如果我开始添加仅对订阅者开放的功能，我会提前通知你们。如果你想更改或取消订阅，请参考以下说明。
