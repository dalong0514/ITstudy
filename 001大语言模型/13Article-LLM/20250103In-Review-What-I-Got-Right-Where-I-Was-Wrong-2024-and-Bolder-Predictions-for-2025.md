## 20250103In-Review-What-I-Got-Right-Where-I-Was-Wrong-2024-and-Bolder-Predictions-for-2025

[2024 in Review: What I Got Right, Where I Was Wrong, and Bolder Predictions for 2025 | by Leonie Monigatti | Dec, 2024 | Towards Data Science](https://towardsdatascience.com/2024-in-review-what-i-got-right-where-i-was-wrong-and-bolder-predictions-for-2025-4092c2d726cd)

What I got right (and wrong) about trends in 2024 and daring to make bolder predictions for the year ahead

Leonie Monigatti

Towards Data Science

Leonie Monigatti

Dec 18, 2024

In 2023, building AI-powered applications felt full of promise, but the challenges were already starting to show. By 2024, we began experimenting with techniques to tackle the hard realities of making them work in production.

在 2023 年，构建人工智能驱动的应用让人感觉充满希望，但挑战已经开始显现。到 2024 年，我们开始尝试各种技术，以应对在实际生产中部署这些应用时遇到的难题。

Last year, I reviewed the biggest trends in AI in 2023 and made predictions for 2024. This year, instead of a timeline, I want to focus on key themes: What trends emerged? Where did I get it wrong? And what can we expect for 2025?

去年，我回顾了 2023 年人工智能（AI）领域的主要趋势，并对 2024 年的发展做出了预测。今年，我不再按照时间线来梳理，而是想聚焦于几个关键主题：哪些新趋势涌现？我之前的哪些预测是错误的？以及我们对 2025 年可以抱有哪些期待？

[2023 in Review: Recapping the Post-ChatGPT Era and What to Expect for 2024 | by Leonie Monigatti | Towards Data Science](https://towardsdatascience.com/2023-in-review-recapping-the-post-chatgpt-era-and-what-to-expect-for-2024-bb4357a4e827)

### 2024 in Review

2024 年回顾

If I have to summarize the AI space in 2024, it would be the "Captain, it's Wednesday" meme. The amount of major releases this year was overwhelming. I don't blame anyone in this space who's feeling exhausted towards the end of this year. It's been a crazy ride, and it's been hard to keep up. Let's review key themes in the AI space and see if I correctly predicted them last year.

如果要我总结 2024 年的 AI 领域，那感觉就像是「舰长，今天是星期三」这个梗一样，每天都有新东西冒出来。今年重大发布的数量简直是井喷式爆发。我理解那些在今年年底感到精疲力竭的同行们，这一年实在是太疯狂了，让人应接不暇。让我们回顾一下 AI 领域的关键主题，看看我去年是否准确预测了它们。

### Evaluations

评估

Let's start by looking at some generative AI solutions that made it to production. There aren't many. As a survey by A16Z revealed in 2024, companies are still hesitant to deploy generative AI in customer-facing applications. Instead, they feel more confident using it for internal tasks, like document search or chatbots.

我们先来看看一些已经实际应用的生成式 AI（Generative AI）解决方案。这样的方案数量不多。A16Z 在 2024 年的一项调查显示，各公司在面向客户的应用程序中部署生成式 AI 时仍然比较犹豫。相反，他们更倾向于将其用于内部任务，例如文档搜索或聊天机器人。

So, why aren't there that many customer-facing generative AI applications in the wild? Probably because we are still figuring out how to evaluate them properly. This was one of my predictions for 2024.

那么，为什么市场上没有那么多面向消费者的生成式 AI（Generative AI）应用呢？ 很可能是因为我们还在探索如何有效评估它们。这正是我对 2024 年的预测之一。

Much of the research involved using another LLM to evaluate the output of an LLM (LLM-as-a-judge). While the approach may be clever, it's also imperfect due to added cost, introduction of bias, and unreliability.

许多研究都采用了一种方法，即使用另一个大语言模型来评估一个大语言模型的输出（将大语言模型作为评判者）。这种方法或许很巧妙，但也存在不足，因为它会增加成本，引入偏见，并且结果可能不可靠。

Looking back, I anticipated we would see this issue solved this year. However, looking at the landscape today, despite being a major topic of discussion, we still haven't found a reliable way to evaluate generative AI solutions effectively. Although I think LLM-as-a-judge is the only way we're able to evaluate generative AI solutions at scale, this shows how early we are in this field.

回想起来，我曾预计今年就能解决这个问题。然而，审视当今的状况，尽管它已成为一个重要的讨论议题，我们仍然未能找到一种可靠的方法来有效评估生成式 AI（Generative AI）的方案。虽然我认为使用大语言模型（LLM/Large Language Model）作为评判标准，是我们目前唯一能大规模评估生成式 AI 方案的途径，但也恰恰说明我们仍处于这个领域的早期发展阶段。

[16 Changes to the Way Enterprises Are Building and Buying Generative AI | Andreessen Horowitz](https://a16z.com/generative-ai-enterprise-2024/)

[[2411.15594] A Survey on LLM-as-a-Judge](https://arxiv.org/abs/2411.15594)

### Multimodality

多模态

Although this one might have been obvious to many of you, I didn't have this on my radar for 2024. With the releases of GPT4, Llama 3.2, and ColPali, multimodal foundation models were a big trend in 2024. While we, developers, were busy figuring out how to make LLMs work in our existing pipelines, researchers were already one step ahead. They were already building foundation models that could handle more than one modality.

尽管对很多人来说这可能显而易见，但我在 2024 年才开始关注到这一点。随着 GPT4、Llama 3.2 和 ColPali 的发布，多模态基础模型在 2024 年成为一个显著的趋势。当开发者们还在忙于研究如何将大语言模型（LLM）应用于现有工作流程时，研究人员已经先行一步，着手构建能够处理多种数据形式的基础模型了。

"There is *absolutely no way in hell* we will ever reach human-level AI without getting machines to learn from high-bandwidth sensory inputs, such as vision." — Yann LeCun

「如果不能让机器从高带宽的感官输入（比如视觉）中学习，我们*绝对不可能*达到真正意义上的人工智能水平。」—— Yann LeCun

Take PDF parsing as an example of multimodal models' usefulness beyond text-to-image tasks. ColPali's researchers avoided the difficult steps of OCR and layout extraction by using visual language models (VLMs). Systems like ColPali and ColQwen2 process PDFs as images, extracting information directly without pre-processing or chunking. This is a reminder that simpler solutions often come from changing how you frame the problem.

以 PDF 解析为例，我们可以看到多模态模型在文本到图像任务之外的强大用途。ColPali 的研究人员巧妙地利用视觉语言模型（VLMs），避开了传统方法中繁琐的 OCR（光学字符识别）和布局提取步骤。像 ColPali 和 ColQwen2 这样的系统，它们将 PDF 文件视为图像进行处理，无需任何预处理或分块操作，就能直接从中提取所需的信息。这有力地提醒我们，有时候，更简洁有效的解决方案往往来自于我们如何重新审视和构建问题本身。

Multimodal models are a bigger shift than they might seem. Document search across PDFs is just the beginning. Multimodality in foundation models will unlock entirely new possibilities for applications across industries. With more modalities, AI is no longer just about language — it's about understanding the world.

多模态模型的影响比表面看起来的要深远得多。对 PDF 文档进行搜索仅仅是开始。基础模型的多模态能力将为各行各业的应用开启全新的可能性。随着支持的模态越来越多，人工智能的关注点不再仅仅是语言，而是扩展到理解世界。

[[2407.01449] ColPali: Efficient Document Retrieval with Vision Language Models](https://arxiv.org/abs/2407.01449)

[vidore/colqwen2-v0.1 · Hugging Face](https://huggingface.co/vidore/colqwen2-v0.1)

### Fine-tuning open-weight models and quantization

微调开放权重模型与量化

Open-weight models are closing the performance gap to closed models. Fine-tuning them gives you a performance boost while still being lightweight. Quantization makes these models smaller and more efficient (see also Green AI) to run anywhere, even on small devices. Quantization pairs well with fine-tuning, especially since fine-tuning language models is inherently challenging (see QLoRA).

开放权重模型在性能上正逐渐赶上封闭模型。对这些模型进行微调，可以在保持模型轻量化的同时，显著提升性能。量化技术能够进一步缩小模型体积，提高运行效率（另见「绿色 AI」），使得这些模型可以在各种设备上运行，即使是小型设备也不例外。量化与微调是相辅相成的技术，尤其考虑到微调大语言模型（Large Language Model，LLM）本身就具有相当的挑战性（参见 QLoRA）。

Together, these trends make it clear that the future isn't just bigger models — it's smarter ones.

总之，这些趋势都说明了，未来的人工智能模型不仅要更大，还要更智能。

Great visual summary by Maxime Labonne. Also, check out his blog if you are interested in fine-tuning LLMs.

Maxime Labonne 的视觉摘要很棒。如果你对微调大语言模型（LLM/Large Language Model）感兴趣，可以看看他的博客。

I don't think I explicitly mentioned this one and only wrote a small piece on this in the second quarter of 2024. So, I will not give myself a point here.

我并不认为我曾明确提及 AI 智能体（AI Agent），仅在 2024 年第二季度简要地写过相关内容。因此，此处我不会给自己加分。

[Towards Green AI: How to Make Deep Learning Models More Efficient in Production | by Leonie Monigatti | Towards Data Science](https://towardsdatascience.com/towards-green-ai-how-to-make-deep-learning-models-more-efficient-in-production-3b1e7430a14)

[[2305.14314] QLoRA: Efficient Finetuning of Quantized LLMs](https://arxiv.org/abs/2305.14314)

[Shifting Tides: The Competitive Edge of Open Source LLMs over Closed Source LLMs | by Leonie Monigatti | Towards Data Science](https://towardsdatascience.com/shifting-tides-the-competitive-edge-of-open-source-llms-over-closed-source-llms-aee76018b5c7)

### AI agents

AI 智能体

This year, AI agents and agentic workflows gained much attention, as Andrew Ng predicted at the beginning of the year. We saw Langchain and LlamaIndex move into incorporating agents, CrewAI gained a lot of momentum, and OpenAI came out with Swarm. This is another topic I hadn't seen coming since I didn't look into it.

今年，正如吴恩达在年初预测的那样，AI 智能体和智能体工作流程备受瞩目。我们看到 Langchain 和 LlamaIndex 开始加入智能体功能，CrewAI 迅速发展，OpenAI 也推出了 Swarm。由于我之前没有关注这方面，所以这个话题的兴起让我有些意外。

"I think AI agentic workflows will drive massive AI progress this year — perhaps even more than the next generation of foundation models." — Andrew Ng

「我认为，AI 智能体的工作流程将在今年推动人工智能的巨大进步，其影响甚至可能超过下一代大型模型。」—— 吴恩达

Screenshot from Google Trends for the term "AI agents" in 2024.

图：2024 年「AI 智能体」一词的 Google 趋势截图。

Despite the massive interest in AI agents, they can be controversial. First, there is still no clear definition of "AI agent" and its capabilities. Are AI agents just LLMs with access to tools, or do they have other specific capabilities? Second, they come with added latency and cost. I have read many comments saying that agent systems aren't suitable for production systems due to this.

尽管人们对 AI 智能体（AI agents）表现出浓厚的兴趣，但它们也存在一些争议。首先，对于「AI 智能体」及其具体能力，目前还没有明确的定义。究竟 AI 智能体只是拥有工具使用权限的大语言模型（LLM），还是具备其他特殊能力？其次，使用 AI 智能体会增加延迟和成本。我看到很多评论认为，由于这些原因，智能体系统不适用于生产环境。

But I think we have already been seeing some agentic pipelines in production with lightweight workflows, such as routing user queries to specific function calls. I think we will continue to see agents in 2025. Hopefully, we will get a clearer definition and picture.

但是我认为我们已经看到一些基于智能体的流程在实际应用中，它们采用轻量级的工作流程，例如将用户的问题导向特定的功能模块。我认为我们将在 2025 年继续看到智能体的身影。希望届时我们能对智能体有更明确的定义和理解。

[CrewAI](https://www.crewai.com/)

### RAG isn't de*d and retrieval goes mainstream

RAG 并未过时，检索技术走向主流

Retrieval-Augmented Generation (RAG) gained significant attention in 2023 and remained a key topic in 2024, with many new variants emerging. However, it remains a topic of debate. Some argue it's becoming obsolete with long-context models, while others question whether it's even a new idea. While I think the criticism of the terminology is justified, I think the concept is here to stay (for a little while at least).

检索增强生成（Retrieval-Augmented Generation，RAG）在 2023 年受到了广泛关注，并在 2024 年依然是热门话题，涌现出许多新的变体。然而，它仍然是一个存在争议的话题。一些人认为，随着长上下文模型的出现，它可能变得过时，而另一些人则质疑这是否是一个新颖的概念。尽管我认为对这个术语的批评是有道理的，但我认为这个概念至少在短期内会继续存在。

Fig: All the different RAG variants

各种 RAG 变体

Every time a new long context model is released, some people predict it will be the end of RAG pipelines. I don't think that's going to happen. This whole discussion should be a blog post of its own, so I'm not going into depth here and saving the discussion for another one. Let me just say that I don't think it's one or the other. They are complements. Instead, we will probably be using long context models together with RAG pipelines.

每当有新的长上下文模型发布，总有人会预测 RAG 管道将走向末路。我认为这并不会发生。这整个话题值得单独写一篇博客文章来讨论，所以这里我先不深入展开，留待以后再说。我想强调的是，我认为这不是一个非此即彼的问题，它们是相辅相成的。未来，我们很可能会将长上下文模型与 RAG 管道结合使用。

Also, having a database in applications is not a new concept. The term ‘RAG,' which refers to retrieving information from a knowledge source to enhance an LLM's output, has faced criticism. Some argue it's merely a rebranding of techniques long used in other fields, such as software engineering. While I think we will probably part from the term in the long run, the technique is here to stay.

另外，在应用中使用数据库并不是什么新鲜事。「RAG」，也就是指从知识库中检索信息来提升大语言模型（LLM）输出质量的技术，也受到了一些批评。有人认为，它不过是把其他领域（比如软件工程）早就用过的技术换了个新说法。虽然我觉得「RAG」这个词可能不会流行太久，但这项技术本身会一直存在。

Despite predictions of RAG's demise, retrieval remains a cornerstone of AI pipelines. While I may be biased by my work in retrieval, it felt like this topic became more mainstream in AI this year. It started with many discussions around keyword search (BM25) as a baseline for RAG pipelines. It then evolved into a larger discussion around dense retrieval models, such as ColBERT or ColPali.

尽管此前有预测认为检索增强生成（Retrieval-Augmented Generation，RAG）将会消亡，但检索仍然是 AI 流程中的基石。虽然我可能因为自身在检索领域的工作而带有偏见，但今年感觉这个话题在 AI 领域更加主流。最初，许多讨论都围绕着将关键词搜索（BM25）作为 RAG 流程的基线。随后，讨论逐渐深入到诸如 ColBERT 或 ColPali 等密集检索模型（dense retrieval models）。

[Building Retrieval-Augmented Generation Systems | by Leonie Monigatti | Medium](https://medium.com/@iamleonie/building-retrieval-augmented-generation-systems-be587f42aedb)

[[2004.12832] ColBERT: Efficient and Effective Passage Search via Contextualized Late Interaction over BERT](https://arxiv.org/abs/2004.12832)

### Knowledge graphs

知识图谱

I completely missed this topic because I'm not too familiar with it. Knowledge graphs in RAG systems (e.g., Graph RAG) were another big topic. Since all I can say about knowledge graphs at this moment is that they seem to be a powerful external knowledge source, I will keep this section short.

我之前完全忽略了这一主题，因为我对此并不熟悉。在 RAG 系统中，知识图谱（例如，图 RAG）是另一个重要的研究方向。目前，我对于知识图谱的理解仅限于它们是一种强大的外部知识来源，因此本节将简要介绍。

The key topics of 2024 suggest that we are now realizing the limitations of building applications with foundation models. The hype around ChatGPT may have settled, but the drive to integrate foundation models into applications is still very much alive. It's just way more difficult than we had anticipated.

2024 年的主要议题表明，我们现在逐渐意识到使用基础模型（foundation models）构建应用程序的局限性。围绕 ChatGPT 的热潮可能已经消退，但将基础模型集成到应用程序中的动力依然强劲。只不过，这比我们之前预想的要困难得多。

"The race to make AI more efficient and more useful, before investors lose their enthusiasm, is on." — The Economist

「在投资者失去热情之前，如何让 AI 更高效、更有用的竞争已经展开。」—— 《经济学人》

2024 taught us that scaling foundation models isn't enough. We need better evaluation, smarter retrieval, and more efficient workflows to make AI useful. The limitations we ran into this year aren't signs of stagnation — they're clues about what we need to fix next in 2025.

2024 年的经验告诉我们，仅仅扩大基础模型的规模是不够的。为了让 AI 发挥作用，我们需要更完善的评估方法、更智能的检索技术以及更高效的工作流程。我们今年遇到的瓶颈并非是停滞不前的信号，而是为我们指明了 2025 年需要改进的方向。

### My 2025 Predictions

我对 2025 年的预测

OK, now, for the interesting part, what are my 2025 predictions? This year, I want to make some bolder predictions for the next year to make it a little more fun:

好的，现在到了有趣的部分，我来预测一下 2025 年会发生什么。今年，我想对明年做出一些更大胆的预测，让这更有意思：

1 Video will be an important modality: After text-only LLMs evolved into multimodal foundation models (mostly text and images), it's only natural that video will be the next modality. I can imagine seeing more video-capable foundation models follow in Sora's footsteps.

视频将成为一种重要的信息载体：在仅能处理文本的大语言模型进化为可以处理多种信息形式的基础模型（主要是文本和图像）之后，视频自然而然地成为了下一个发展方向。我可以预见，未来会出现更多像 Sora 一样具备视频处理能力的基础模型。

2 From one-shot to agentic to human-in-the-loop: I imagine we will start incorporating humans into AI-powered systems. While we started with one-shot systems, we are not at the stage of having AI agents coordinate different tasks to improve results. But AI agents won't replace humans. They'll empower them. Systems that incorporate human feedback will deliver better outcomes across industries. In the long-term, I imagine that we will have to have systems that wait for human feedback before taking action on the next task.

从单次到 AI 智能体再到人机协同：我预想，未来我们将把人类逐步融入到人工智能驱动的系统中。虽然我们最初使用的是单次系统，但目前我们尚未达到让 AI 智能体协调不同任务以提升结果的阶段。不过，AI 智能体并不会取代人类，而是会增强人类的能力。那些整合了人类反馈的系统，将在各行各业带来更出色的成果。从长远来看，我预计我们需要构建这样的系统：在执行下一个任务之前，会等待人类的反馈。

3 Fusion of AI and crypto: Admittedly, I don't know much about the entire crypto scene, but I saw this Tweet by Brian Armstrong about how AI agents should be equipped with crypto wallets. Also, concepts like DePin (Decentralized Physical Infrastructure) could be interesting to explore for model training and inference. While this sounds like buzzword bingo, I'm curious to see if early experiments will show if this is hype or reality.

人工智能与加密技术的结合：我承认，我对加密货币领域了解不多，但我看到 Coinbase 的 CEO Brian Armstrong 发了一条推文，内容是关于 AI 智能体应该配备加密钱包。此外，像 DePin（去中心化物理基础设施）这样的概念，在模型训练和推理方面也可能具有探索价值。虽然这些概念听起来像是新潮词汇的堆砌，但我很想看看早期的实验能否揭示这究竟是炒作还是未来的趋势。

4 Latency and cost per token will drop: Currently, one big issue for AI agents is added latency and cost. However, with Moore's law and research for making AI models more efficient, like quantization and efficient training techniques (not only for cost reasons but also for environmental reasons), I can imagine both the latency and cost per token going down.

每个 Token 的延迟和成本将会降低：目前，对于 AI 智能体（AI Agent）来说，一个主要问题是延迟和成本的增加。然而，随着摩尔定律的发展以及为提高 AI 模型效率而进行的研究，例如量化和高效训练技术（不仅出于成本考虑，也出于环境考虑），可以预见每个 Token 的延迟和成本都将下降。

I am curious to hear your predictions for the AI space in 2025!

我很好奇你对 2025 年人工智能领域有哪些预测！

PS: Funnily, I was researching recipes for Christmas cookies with ChatGPT a few days ago instead of using Google, which I was wondering about two years ago when ChatGPT was released.

附言：有趣的是，就在几天前，我用 ChatGPT 查询圣诞饼干的食谱，而不是像以往一样使用 Google。这让我回想起两年前 ChatGPT 刚发布时，我还在思考它的用途。

[X 上的 Brian Armstrong：“LLMs should have crypto wallets. Let's help AI agents get work done (on your behalf) and participate in the economy. Reach out and let us know what you're building. Side note: every checkout experience will need to support AI agents buying things soon.” / X](https://x.com/brian_armstrong/status/1824547713012080806)

## 原文

In2023, building AI-powered applications felt full of promise, but the challenges were already starting to show. By 2024, we began experimenting with techniques to tackle the hard realities of making them work in production.

Last year, I reviewed the biggest trends in AI in 2023 and made predictions for 2024. This year, instead of a timeline, I want to focus on key themes: What trends emerged? Where did I get it wrong? And what can we expect for 2025?

2024 in Review

If I have to summarize the AI space in 2024, it would be the "Captain, it's Wednesday" meme. The amount of major releases this year was overwhelming. I don't blame anyone in this space who's feeling exhausted towards the end of this year. It's been a crazy ride, and it's been hard to keep up. Let's review key themes in the AI space and see if I correctly predicted them last year.

Evaluations

Let's start by looking at some generative AI solutions that made it to production. There aren't many. As a survey by A16Z revealed in 2024, companies are still hesitant to deploy generative AI in customer-facing applications. Instead, they feel more confident using it for internal tasks, like document search or chatbots.

So, why aren't there that many customer-facing generative AI applications in the wild? Probably because we are still figuring out how to evaluate them properly. This was one of my predictions for 2024.

Much of the research involved using another LLM to evaluate the output of an LLM (LLM-as-a-judge). While the approach may be clever, it's also imperfect due to added cost, introduction of bias, and unreliability.

Looking back, I anticipated we would see this issue solved this year. However, looking at the landscape today, despite being a major topic of discussion, we still haven't found a reliable way to evaluate generative AI solutions effectively. Although I think LLM-as-a-judge is the only way we're able to evaluate generative AI solutions at scale, this shows how early we are in this field.

Multimodality

Although this one might have been obvious to many of you, I didn't have this on my radar for 2024. With the releases of GPT4, Llama 3.2, and ColPali, multimodal foundation models were a big trend in 2024. While we, developers, were busy figuring out how to make LLMs work in our existing pipelines, researchers were already one step ahead. They were already building foundation models that could handle more than one modality.

"There is *absolutely no way in hell* we will ever reach human-level AI without getting machines to learn from high-bandwidth sensory inputs, such as vision." — Yann LeCun

Take PDF parsing as an example of multimodal models' usefulness beyond text-to-image tasks. ColPali's researchers avoided the difficult steps of OCR and layout extraction by using visual language models (VLMs). Systems like ColPali and ColQwen2 process PDFs as images, extracting information directly without pre-processing or chunking. This is a reminder that simpler solutions often come from changing how you frame the problem.

Multimodal models are a bigger shift than they might seem. Document search across PDFs is just the beginning. Multimodality in foundation models will unlock entirely new possibilities for applications across industries. With more modalities, AI is no longer just about language — it's about understanding the world.

Fine-tuning open-weight models and quantization

Open-weight models are closing the performance gap to closed models. Fine-tuning them gives you a performance boost while still being lightweight. Quantization makes these models smaller and more efficient (see also Green AI) to run anywhere, even on small devices. Quantization pairs well with fine-tuning, especially since fine-tuning language models is inherently challenging (see QLoRA).

Together, these trends make it clear that the future isn't just bigger models — it's smarter ones.

Great visual summary by Maxime Labonne. Also, check out his blog if you are interested in fine-tuning LLMs.

I don't think I explicitly mentioned this one and only wrote a small piece on this in the second quarter of 2024. So, I will not give myself a point here.

AI agents

This year, AI agents and agentic workflows gained much attention, as Andrew Ng predicted at the beginning of the year. We saw Langchain and LlamaIndex move into incorporating agents, CrewAI gained a lot of momentum, and OpenAI came out with Swarm. This is another topic I hadn't seen coming since I didn't look into it.

"I think AI agentic workflows will drive massive AI progress this year — perhaps even more than the next generation of foundation models." — Andrew Ng

Screenshot from Google Trends for the term "AI agents" in 2024.

Despite the massive interest in AI agents, they can be controversial. First, there is still no clear definition of "AI agent" and its capabilities. Are AI agents just LLMs with access to tools, or do they have other specific capabilities? Second, they come with added latency and cost. I have read many comments saying that agent systems aren't suitable for production systems due to this.

But I think we have already been seeing some agentic pipelines in production with lightweight workflows, such as routing user queries to specific function calls. I think we will continue to see agents in 2025. Hopefully, we will get a clearer definition and picture.

RAG isn't de*d and retrieval goes mainstream

Retrieval-Augmented Generation (RAG) gained significant attention in 2023 and remained a key topic in 2024, with many new variants emerging. However, it remains a topic of debate. Some argue it's becoming obsolete with long-context models, while others question whether it's even a new idea. While I think the criticism of the terminology is justified, I think the concept is here to stay (for a little while at least).

All the different RAG variants

Every time a new long context model is released, some people predict it will be the end of RAG pipelines. I don't think that's going to happen. This whole discussion should be a blog post of its own, so I'm not going into depth here and saving the discussion for another one. Let me just say that I don't think it's one or the other. They are complements. Instead, we will probably be using long context models together with RAG pipelines.

Also, having a database in applications is not a new concept. The term ‘RAG,' which refers to retrieving information from a knowledge source to enhance an LLM's output, has faced criticism. Some argue it's merely a rebranding of techniques long used in other fields, such as software engineering. While I think we will probably part from the term in the long run, the technique is here to stay.

Despite predictions of RAG's demise, retrieval remains a cornerstone of AI pipelines. While I may be biased by my work in retrieval, it felt like this topic became more mainstream in AI this year. It started with many discussions around keyword search (BM25) as a baseline for RAG pipelines. It then evolved into a larger discussion around dense retrieval models, such as ColBERT or ColPali.

Knowledge graphs

I completely missed this topic because I'm not too familiar with it. Knowledge graphs in RAG systems (e.g., Graph RAG) were another big topic. Since all I can say about knowledge graphs at this moment is that they seem to be a powerful external knowledge source, I will keep this section short.

The key topics of 2024 suggest that we are now realizing the limitations of building applications with foundation models. The hype around ChatGPT may have settled, but the drive to integrate foundation models into applications is still very much alive. It's just way more difficult than we had anticipated.

" The race to make AI more efficient and more useful, before investors lose their enthusiasm, is on." — The Economist

2024 taught us that scaling foundation models isn't enough. We need better evaluation, smarter retrieval, and more efficient workflows to make AI useful. The limitations we ran into this year aren't signs of stagnation — they're clues about what we need to fix next in 2025.

My 2025 Predictions

OK, now, for the interesting part, what are my 2025 predictions? This year, I want to make some bolder predictions for the next year to make it a little more fun:

Video will be an important modality: After text-only LLMs evolved into multimodal foundation models (mostly text and images), it's only natural that video will be the next modality. I can imagine seeing more video-capable foundation models follow in Sora's footsteps.

From one-shot to agentic to human-in-the-loop: I imagine we will start incorporating humans into AI-powered systems. While we started with one-shot systems, we are not at the stage of having AI agents coordinate different tasks to improve results. But AI agents won't replace humans. They'll empower them. Systems that incorporate human feedback will deliver better outcomes across industries. In the long-term, I imagine that we will have to have systems that wait for human feedback before taking action on the next task.

Fusion of AI and crypto: Admittedly, I don't know much about the entire crypto scene, but I saw this Tweet by Brian Armstrong about how AI agents should be equipped with crypto wallets. Also, concepts like DePin (Decentralized Physical Infrastructure) could be interesting to explore for model training and inference. While this sounds like buzzword bingo, I'm curious to see if early experiments will show if this is hype or reality.

Latency and cost per token will drop: Currently, one big issue for AI agents is added latency and cost. However, with Moore's law and research for making AI models more efficient, like quantization and efficient training techniques (not only for cost reasons but also for environmental reasons), I can imagine both the latency and cost per token going down.

I am curious to hear your predictions for the AI space in 2025!

PS: Funnily, I was researching recipes for Christmas cookies with ChatGPT a few days ago instead of using Google, which I was wondering about two years ago when ChatGPT was released.