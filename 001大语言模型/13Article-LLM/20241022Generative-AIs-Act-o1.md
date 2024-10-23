## 20241022Generative-AIs-Act-o1

[Generative AI's Act o1: The Reasoning Era Begins | Sequoia Capital](https://www.sequoiacap.com/article/generative-ais-act-o1/)

[生成式AI 新一幕：推理模型登场 [译] | 宝玉的分享](https://baoyu.io/translations/ai/generative-ais-act-o1)

By Sonya Huang, Pat Grady, and o1

Published October 9, 2024

### The Agentic Reasoning Era Begins

Two years into the Generative AI revolution, research is progressing the field from "thinking fast"—rapid-fire pre-trained responses—to "thinking slow"— reasoning at inference time. This evolution is unlocking a new cohort of agentic applications.

On the second anniversary of our essay "Generative AI: A Creative New World," the AI ecosystem looks very different, and we have some predictions for what's on the horizon.

The foundation layer of the Generative AI market is stabilizing in an equilibrium with a key set of scaled players and alliances, including Microsoft/OpenAI, AWS/Anthropic, Meta and Google/DeepMind. Only scaled players with economic engines and access to vast sums of capital remain in play. While the fight is far from over (and keeps escalating in a game-theoretic fashion), the market structure itself is solidifying, and it's clear that we will have increasingly cheap and plentiful next-token predictions.

As the LLM market structure stabilizes, the next frontier is now emerging. The focus is shifting to the development and scaling of the reasoning layer, where "System 2" thinking takes precedence. Inspired by models like AlphaGo, this layer aims to endow AI systems with deliberate reasoning, problem-solving and cognitive operations at inference time that go beyond rapid pattern matching. And new cognitive architectures and user interfaces are shaping how these reasoning capabilities are delivered to and interact with users.

What does all of this mean for founders in the AI market? What does this mean for incumbent software companies? And where do we, as investors, see the most promising layer for returns in the Generative AI stack?

In our latest essay on the state of the Generative AI market, we'll explore how the consolidation of the foundational LLM layer has set the stage for the race to scale these higher-order reasoning and agentic capabilities, and discuss a new generation of "killer apps" with novel cognitive architectures and user interfaces.

宝玉的分享

Published on 2024-10-10

Translated on 2024-10-09

生成式 AI 新一幕：推理模型登场 [译]

智能推理时代的开始

在生成式 AI 革命的两年后，研究领域从「快速思维」—— 快速反应的预训练回答，向「慢速思维」—— 推理时的深度思考发展。这一转变正在催生一批全新的智能应用。

在我们撰写的《生成式 AI：一个创造性的新世界》文章两周年之际，AI 生态系统已经发生了显著变化，我们对未来的发展趋势有一些预测。

生成式 AI 市场的基础层正在与一批主要玩家（如微软 / OpenAI、AWS/Anthropic、Meta 和谷歌 / DeepMind）达成平衡。只有具备经济实力和资本的公司仍在市场中占据主导地位。尽管竞争远未结束，并且在博弈论框架下不断升级，但市场结构正在逐步稳固，未来的 AI 预测模型将变得更加廉价且普遍。

随着大型语言模型（LLM）市场结构的稳定，新的前沿领域正在浮现。焦点正转向「推理层」的开发和扩展，在这个层面，「系统 2」思维成为了主导。受 AlphaGo 等模型启发，这一层致力于赋予 AI 系统在推理时进行深度思考、解决问题的能力，超越单纯的模式匹配。新的认知架构和用户界面正在塑造这些推理能力如何与用户交互并呈现给用户。

这一切对于 AI 市场中的创业者意味着什么？对于现有的软件公司又意味着什么？作为投资者，我们看到生成式 AI 堆栈中最有前景的投资层在哪里？

在我们最新的关于生成式 AI 市场现状的文章中，我们将探讨基础层的整合如何为扩展这些高级推理和智能能力的竞赛奠定基础，并讨论具有新颖认知架构和用户界面的新一代「杀手级应用」。

### Strawberry Fields Forever

The most important model update of 2024 goes to OpenAI with o1, formerly known as Q* and also known as Strawberry. This is not just a reassertion of OpenAI's rightful place atop the model quality leaderboards, but also a notable improvement on the status quo architecture. More specifically, this is the first example of a model with true general reasoning capabilities, which they've achieved with inference-time compute.

What does that mean? Pre-trained models are doing next token prediction on an enormous amount of data. They rely on "training-time compute." An emergent property of scale is basic reasoning, but this reasoning is very limited. What if you could teach a model to reason more directly? This is essentially what's happening with Strawberry. When we say "inference-time compute" what we mean is asking the model to stop and think before giving you a response, which requires more compute at inference time (hence "inference-time compute"). The "stop and think" part is reasoning.

永恒的「草莓」模型

2024 年最重要的模型更新来自 OpenAI 的 o1（曾名为 Q*，也称为 Strawberry）。这不仅重申了 OpenAI 在模型质量排行榜上的领先地位，也标志着现有架构的重大改进。更具体地说，这是第一个具有真正通用推理能力的模型，它通过推理时的计算实现了这一点。

这意味着什么？预训练模型通过在海量数据上进行下一个词的预测来工作，依赖于「训练时计算」。随着规模的扩展，基础的推理能力会逐步显现，但这种推理非常有限。那么，如果能直接教模型推理会怎样？这就是 Strawberry 模型的本质。所谓「推理时计算」，指的是让模型在给出答案前停下来思考，这需要在推理时投入更多的计算资源。这个「停下来思考」的过程就是推理。

### AlphaGo x LLMs

So what is the model doing when it stops and thinks?

Let's first take a quick detour to March 2016 in Seoul. One of the most seminal moments in deep learning history took place here: AlphaGo's match against legendary Go master Lee Sedol. This wasn't just any AI-vs-human match—it was the moment the world saw AI do more than just mimic patterns. It was thinking.

What made AlphaGo different from previous gameplay AI systems, like Deep Blue? Like LLMs, AlphaGo was first pre-trained to mimic human experts from a database of roughly 30 million moves from previous games and more from self-play. But rather than provide a knee jerk response that comes out of the pre-trained model, AlphaGo takes the time to stop and think. At inference time, the model runs a search or simulation across a wide range of potential future scenarios, scores those scenarios, and then responds with the scenario (or answer) that has the highest expected value. The more time AlphaGo is given, the better it performs. With zero inference-time compute, the model can't beat the best human players. But as the inference time scales, AlphaGo gets better and better—until it surpasses the very best humans.

Let's bring it back to the LLM world. What's hard about replicating AlphaGo here is constructing the value function, or the function by which the responses are scored. If you're playing Go, it's more straightforward: you can simulate the game all the way to the end, see who wins, and then calculate an expected value of the next move. If you're coding, it's somewhat straightforward: you can test the code and see if it works. But how do you score the first draft of an essay? Or a travel itinerary? Or a summary of key terms in a long document? This is what makes reasoning hard with current methods, and it's why Strawberry is comparatively strong on domains proximate to logic (e.g. coding, math, the sciences) and not as strong in domains that are more open-ended and unstructured (e.g. writing).

While the actual implementation of Strawberry is a closely guarded secret, the key ideas involve reinforcement learning around the chains of thought generated by the model. Auditing the model's chains of thought suggests that something fundamental and exciting is happening that actually resembles how humans think and reason. For example, o1 is showing the ability to backtrack when it gets stuck as an emergent property of scaling inference time. It is also showing the ability to think about problems the way a human would (e.g. visualize the points on a sphere to solve a geometry problem) and to think about problems in new ways (e.g. solving problems in programming competitions in a way that humans would not).

And there is no shortage of new ideas to push forward inference-time compute (e.g. new ways of calculating the reward function, new ways of closing the generator/verifier gap) that research teams are working on as they try to improve the model's reasoning capabilities. In other words, deep reinforcement learning is cool again, and it's enabling an entire new reasoning layer.

AlphaGo 与 LLM 结合

当模型停下来思考时，它究竟在做什么？

首先，让我们回到 2016 年 3 月的首尔。这是深度学习历史上一个标志性时刻：AlphaGo 与围棋传奇李世乭的对决。这不仅仅是一场 AI 与人类的对抗，这是 AI 第一次展示了真正的「思考」能力。

AlphaGo 与之前的游戏 AI 系统（如深蓝）最大的不同在于，AlphaGo 不仅依赖预训练来模仿人类，它还会在推理时停下来进行深度思考。AlphaGo 的预训练阶段通过大约 3000 万步棋局数据进行学习，包括人类对局记录以及自我对弈生成的数据。然而，与简单地从预训练模型中输出直接反应不同，AlphaGo 在推理时会通过模拟多个未来场景，评估这些场景的可能结果，并选择预期值最高的答案。思考时间越长，AlphaGo 的表现越好。没有推理时的计算，模型无法击败最优秀的人类玩家，但随着推理时间的增加，AlphaGo 最终超越了顶尖的人类棋手。

回到大型语言模型的世界。难点在于如何为生成的回答构建评分标准（即价值函数）。如果是在下围棋的场景中，你可以通过模拟整个棋局直到结束，来判断谁获胜，并计算下一步行动的预期值。如果是在编程场景中，你可以通过测试代码是否有效来打分。然而，如何评估文章的初稿呢？如何打分一份旅行计划或者一份长文档的关键术语总结？这就是当前方法在推理方面的难点之一，也是 Strawberry 模型在逻辑性较强领域（如编程、数学、科学）表现突出，而在开放性、非结构化领域（如写作）表现较弱的原因。

虽然 Strawberry 的具体实现细节严格保密，但核心思想包括围绕模型产生的思路链条进行强化学习。对模型思路的审核显示，随着推理时间的增加，出现了一些类似人类思维的现象。例如，o1 模型展现了在遇到困境时能够回溯思考的能力，这是一种随着推理时间增加自发出现的特性。它还表现出以类似人类的方式思考问题的能力（如通过可视化球面上的点来解决几何问题），并且能够以新颖的方式解决问题（如在编程竞赛中采用人类通常不会选择的解法）。

推动推理时计算发展的新想法层出不穷（如奖励函数的新计算方式、缩小生成器与验证器之间差距的新方法等），研究团队正在努力提升模型的推理能力。换句话说，深度强化学习又变得热门起来，它正推动一个全新的推理层次的发展。

### System 1 vs System 2 Thinking

This leap from pre-trained instinctual responses ("System 1") to deeper, deliberate reasoning ("System 2") is the next frontier for AI. It's not enough for models to simply know things—they need to pause, evaluate and reason through decisions in real time.

Think of pre-training as the System 1 layer. Whether a model is pre-trained on millions of moves in Go (AlphaGo) or petabytes of internet-scale text (LLMs), its job is to mimic patterns—whether that's human gameplay or language. But mimicry, as powerful as it is, isn't true reasoning. It can't properly think its way through complex novel situations, especially those out of sample.

This is where System 2 thinking comes in, and it's the focus of the latest wave of AI research. When a model "stops to think," it isn't just generating learned patterns or spitting out predictions based on past data. It's generating a range of possibilities, considering potential outcomes and making a decision based on reasoning.

For many tasks, System 1 is more than enough. As Noam Brown pointed out on our latest episode of Training Data, thinking for longer about what the capital of Bhutan is doesn't help—you either know it or you don't. Quick, pattern-based recall works perfectly here.

But when we look at more complex problems—like breakthroughs in mathematics or biology—quick, instinctive responses don't cut it. These advances required deep thinking, creative problem-solving and—most importantly—time. The same is true for AI. To tackle the most challenging, meaningful problems, AI will need to evolve beyond quick in-sample responses and take its time to come up with the kind of thoughtful reasoning that defines human progress.

系统 1 vs 系统 2 思维

从预训练的本能反应（系统 1）到更深层次的推理（系统 2）是 AI 发展的下一个前沿。仅仅让模型掌握知识是不够的，它们还需要在实时决策时停下来，评估并进行推理。

可以将预训练理解为系统 1 层面。无论是 AlphaGo 通过数百万步围棋对局的预训练，还是大型语言模型通过互联网规模的文本进行训练，它们的任务是模仿模式 —— 不论是人类游戏还是语言模式。然而，尽管模仿强大，但它并不等同于真正的推理。它无法在复杂的、新的场景中进行深思熟虑的思考，尤其是在样本外的情况下。

这就是系统 2 思维的用武之地，也是当前 AI 研究的焦点。当模型「停下来思考」时，它并不仅仅是在生成已学到的模式或基于过往数据作出预测，而是在产生多种可能性、考虑潜在结果并基于推理做出决策。

对于许多任务来说，系统 1 的反应已经足够了。例如，Noam Brown 在我们最新的《训练数据》节目中指出，思考更长时间「不丹的首都是哪儿」并不会有帮助 —— 你要么知道答案，要么不知道。在这种情况下，快速的模式识别完全足够。

但是，当我们面对更复杂的问题时 —— 例如数学或生物学中的重大突破 —— 快速的本能反应是不够的。这些进展需要深思熟虑、创造性问题解决，最重要的是需要时间。对于 AI 来说也是如此，要解决最具挑战性和意义的问题，它需要超越快速的样本内响应，花时间进行深度推理，这正是人类进步的关键。

### A New Scaling Law: The Inference Race is On

The most important insight from the o1 paper is that there's a new scaling law in town.

Pre-training LLMs follows a well understood scaling law: the more compute and data you spend on pre-training the model, the better it performs.

The o1 paper has opened up an entire new plane for scaling compute: the more inference-time (or "test-time") compute you give the model, the better it reasons.

Source: OpenAI o1 technical report

What happens when the model can think for hours? Days? Decades? Will we solve the Riemann Hypothesis? Will we answer Asimov's last question?

This shift will move us from a world of massive pre-training clusters toward inference clouds—environments that can scale compute dynamically based on the complexity of the task.

新的扩展规律：推理竞赛已经开始

o1 论文最重要的发现之一是揭示了一个新的扩展规律。

预训练大型语言模型（LLM）遵循一个广为人知的扩展规律：预训练时，投入的计算资源和数据越多，模型的表现越好。

而 o1 论文则揭示了一个全新的扩展维度：给予模型越多的推理时计算（或「测试时」计算），其推理能力就越强。

来源：OpenAI o1 技术报告

当模型可以花数小时、数天甚至数十年进行思考时，会发生什么？我们是否能解开黎曼假设的谜团？我们能否回答阿西莫夫的最终问题？

这种转变将带我们进入一个从大规模预训练集群转向推理云的世界 —— 即能够根据任务复杂度动态扩展计算资源的环境。

### One Model to Rule Them All?

What happens as OpenAI, Anthropic, Google and Meta scale their reasoning layers and develop more and more powerful reasoning machines? Will we have one model to rule them all?

One hypothesis at the outset of the Generative AI market was that a single model company would become so powerful and all-encompassing that it would subsume all other applications. This prediction has been wrong so far in two ways.

First, there is plenty of competition at the model layer, with constant leapfrogging for SOTA capabilities. It's possible that someone figures out continuous self-improvement with broad domain self play and achieves takeoff, but at the moment we have seen no evidence of this. Quite to the contrary, the model layer is a knife-fight, with price per token for GPT-4 coming down 98% since the last dev day.

Second, the models have largely failed to make it into the application layer as breakout products, with the notable exception of ChatGPT. The real world is messy. Great researchers don't have the desire to understand the nitty gritty end-to-end workflows of every possible function in every possible vertical. It is both appealing and economically rational for them to stop at the API, and let the developer universe worry about the messiness of the real world. Good news for the application layer.

一个模型统治一切？

随着 OpenAI、Anthropic、谷歌和 Meta 不断扩展它们的推理层并开发出越来越强大的推理系统，未来是否会出现一个模型统治一切的局面？

在生成式 AI 市场的初期，有人预测某个模型公司会变得如此强大，以至于最终吞并所有其他应用。然而，这一预测在两个方面都被证明是错误的。

首先，模型层面竞争激烈，最新技术能力不断被超越。尽管存在某家公司通过广泛的自我对弈实现持续自我改进并取得突破性发展的可能性，但目前我们没有看到任何证据。相反，模型层面是激烈竞争的战场。例如，自上次开发者日以来，GPT-4 的价格下降了 98%。

其次，除了 ChatGPT 之外，绝大多数模型未能在应用层面成为爆款产品。现实世界非常复杂，顶尖研究人员并不热衷于深入研究每个垂直领域的端到端工作流程。对于他们而言，开发到 API 层是合理的做法，接下来由开发者来应对现实世界中的复杂性。这对于应用层来说反而是好消息。

### The Messy Real World: Custom Cognitive Architectures

The way you plan and prosecute actions to reach your goals as a scientist is vastly different from how you would work as a software engineer. Moreover, it's even different as a software engineer at different companies.

As the research labs further push the boundaries on horizontal general-purpose reasoning, we still need application or domain-specific reasoning to deliver useful AI agents. The messy real world requires significant domain and application-specific reasoning that cannot efficiently be encoded in a general model.

Enter cognitive architectures, or how your system thinks: the flow of code and model interactions that takes user input and performs actions or generates a response.

For example, in the case of Factory, each of their "droid" products has a custom cognitive architecture that mimics the way that a human thinks to solve a specific task, like reviewing pull requests or writing and executing a migration plan to update a service from one backend to another. The Factory droid will break down all of the dependencies, propose the relevant code changes, add unit tests and pull in a human to review. Then after approval, run the changes across all of the files in a dev environment and merge the code if all the tests pass. Just like how a human might do it—in a set of discrete tasks rather than one generalized, black box answer.

复杂的现实世界：定制认知架构

科学家规划和执行任务的方式与软件工程师的方式大不相同。而且，即便是软件工程师，在不同公司中的工作方式也可能大相径庭。

尽管研究实验室在通用推理领域不断取得突破，但我们仍然需要特定领域或应用场景中的推理能力，才能交付实用的 AI 代理。复杂的现实世界需要大量领域和应用特定的推理能力，这些能力无法通过单一的通用模型高效编码。

这里引入了认知架构的概念，认知架构是指系统思考的方式：代码与模型的交互流程，用以处理用户输入并执行操作或生成响应。

例如，Factory 公司的每个「机器人」产品都有定制的认知架构，模拟人类思考某一特定任务的方式，比如审查代码请求或编写并执行迁移计划，将服务从一个后端迁移到另一个。Factory 的机器人会分解所有依赖项，提出相关代码修改，添加单元测试，并邀请人类进行审查。获得批准后，机器人会在开发环境中运行这些更改，并在所有测试通过后合并代码。这个过程类似于人类处理任务的方式 —— 分解为一系列离散的任务，而不是给出一个通用的、黑箱式的答案。

### What's Happening with Apps?

Imagine you want to start a business in AI. What layer of the stack do you target? Do you want to compete on infra? Good luck beating NVIDIA and the hyperscalers. Do you want to compete on the model? Good luck beating OpenAI and Mark Zuckerberg. Do you want to compete on apps? Good luck beating corporate IT and global systems integrators. Oh. Wait. That actually sounds pretty doable!

Foundation models are magic, but they're also messy. Mainstream enterprises can't deal with black boxes, hallucinations and clumsy workflows. Consumers stare at a blank prompt and don't know what to ask. These are opportunities in the application layer.

Two years ago, many application layer companies were derided as "just a wrapper on top of GPT-3." Today those wrappers turn out to be one of the only sound methods to build enduring value. What began as "wrappers" have evolved into "cognitive architectures."

Application layer AI companies are not just UIs on top of a foundation model. Far from it. They have sophisticated cognitive architectures that typically include multiple foundation models with some sort of routing mechanism on top, vector and/or graph databases for RAG, guardrails to ensure compliance, and application logic that mimics the way a human might think about reasoning through a workflow.

应用层的现状如何？

设想一下，如果你想在 AI 领域创业，你会瞄准堆栈的哪一层？你是否想在基础设施层竞争？祝你好运，因为你将面对 NVIDIA 和大型云服务商的竞争。你是否想在模型层竞争？同样祝你好运，因为你将与 OpenAI 和马克·扎克伯格抗衡。你是否想在应用层竞争？哦，这听起来确实有点可行！

虽然基础模型非常强大，但它们也充满混乱。主流企业无法轻松处理黑箱模型、幻觉现象和复杂的工作流程。普通消费者面对一个空白的提示框时，往往不知道要问些什么。这些问题为应用层带来了机会。

两年前，很多应用层公司被嘲笑为「只是 GPT-3 的套壳」。但如今，这些套壳已被证明是构建持久价值的有效方式。曾经的「套壳」已经进化为「认知架构」。

应用层的 AI 公司不仅仅是基础模型上的用户界面。事实远不止如此。这些公司通常搭建了复杂的认知架构，往往包括多个基础模型，并在其上设置了路由机制，结合向量和 / 或图数据库实现检索增强生成（RAG），并配有防护机制以确保合规性，还融入了模仿人类推理的工作流程逻辑。

### Service-as-a-Software

The cloud transition was software-as-a-service. Software companies became cloud service providers. This was a $350B opportunity.

Thanks to agentic reasoning, the AI transition is service-as-a-software. Software companies turn labor into software. That means the addressable market is not the software market, but the services market measured in the trillions of dollars.

What does it mean to sell work? Sierra is a good example. B2C companies put Sierra on their website to talk with customers. The job-to-be-done is to resolve a customer issue. Sierra gets paid per resolution. There is no such thing as "a seat". You have a job to be done. Sierra does it. They get paid accordingly.

This is the true north for many AI companies. Sierra benefits from having a graceful failure mode (escalation to a human agent). Not all companies are so lucky. An emerging pattern is to deploy as a copilot first (human-in-the-loop) and use those reps to earn the opportunity to deploy as an autopilot (no human in the loop). GitHub Copilot is a good example of this.

服务即软件

云计算的转型源自软件即服务（SaaS）。软件公司转型为云服务提供商，这是一项价值 3500 亿美元的市场机会。如今，随着 AI 推理能力的发展，AI 的转型正在向「服务即软件」方向迈进（service-as-a-software），即软件公司将人工劳动转化为软件。这意味着可服务的市场不再是软件市场，而是规模以「万亿美元」计的服务市场。

什么是「出售工作」？Sierra 就是一个很好的例子。B2C 公司将 Sierra 集成到自己的网站上，用于与客户沟通。Sierra 的任务是解决客户问题，每解决一个问题，Sierra 就获得一次报酬。这种模式下没有所谓的「用户数」概念。客户有一项任务需要完成，Sierra 负责完成它，并据此获得相应报酬。

这正是许多 AI 公司追求的方向。Sierra 的优势在于它具有「优雅的失败模式」，即如果 AI 无法解决问题，问题会升级到人工客服处理。然而，并非所有公司都有这种幸运的设计。一种新兴的模式是首先以「副驾驶」的形式部署 AI（即人类在工作流程中参与），通过这种方式逐步赢得信任和表现机会，最终升级为「自动驾驶」（即无需人类参与）。GitHub Copilot 就是这种模式的一个典型例子。

译注：

Sell work：这里指的是 AI 公司根据完成的具体工作或任务收费，而不是像传统的软件公司按「席位」或「用户数量」收费。换句话说，客户为 AI 系统实际完成的工作成果付费，而不是为软件的使用权付费。

Copilot：在这种模式下，AI 作为「副驾驶」，与人类协同工作。AI 协助人类完成任务，但人类仍在监督和决策过程的关键环节中参与。这种模式通常用于初期，AI 需要人类的介入，逐渐证明其能力，之后可能升级为全自动的「自动驾驶」模式。

Human-in-the-loop：这是指在人机协作过程中，人类仍然参与到 AI 的工作流程中，特别是在 AI 无法独立处理复杂任务时。AI 在执行任务时，某些关键决策仍由人类做出，确保系统的准确性和安全性。

### A New Cohort of Agentic Applications

With Generative AI's budding reasoning capabilities, a new class of agentic applications is starting to emerge.

What shape do these application layer companies take? Interestingly, these companies look different than their cloud predecessors:

Cloud companies targeted the software profit pool. AI companies target the services profit pool.

Cloud companies sold software ($ / seat). AI companies sell work ($ / outcome)

Cloud companies liked to go bottoms-up, with frictionless distribution. AI companies are increasingly going top-down, with high-touch, high-trust delivery models.

We are seeing a new cohort of these agentic applications emerge across all sectors of the knowledge economy. Here are some examples.

Harvey: AI lawyer

Glean: AI work assistant

Factory: AI software engineer

Abridge: AI medical scribe

XBOW: AI pentester

Sierra: AI customer support agent

By bringing the marginal cost of delivering these services down—in line with the plummeting cost of inference—these agentic applications are expanding and creating new markets.

Take XBOW, for example. XBOW is building an AI "pentester." A "pentest" or penetration test is a simulated cyberattack on a computer system that companies perform in order to evaluate their own security systems. Before Generative AI, companies hired pentesters only in limited circumstances (e.g. when required for compliance), because human pentesting is expensive: it's a manual task performed by a highly skilled human. However, XBOW is now demonstrating automated pentests built on the latest reasoning LLMs that match the performance of the most highly skilled human pentesters. This multiplies the pentesting market and opens up the possibility of continuous pentesting for companies of all shapes and sizes.

新一代智能应用的出现

随着生成式 AI 推理能力的提升，新一代智能应用公司正在崭露头角。

这些应用层公司的形态与传统的云计算公司有显著不同：

云计算公司瞄准的是软件盈利领域，而 AI 公司则锁定的是服务盈利领域。

云计算公司销售软件（按「席位」收费），AI 公司则销售工作成果（按「结果」收费）。

云计算公司倾向于自下而上的低摩擦分销，而 AI 公司则越来越采用自上而下的高接触、高信任交付模式。

在知识经济的各个领域，我们正在看到一批新的智能应用公司涌现。以下是一些例子：

Harvey：AI 律师

Glean：AI 工作助手

Factory：AI 软件工程师

Abridge：AI 医疗文书助手

XBOW：AI 渗透测试专家

Sierra：AI 客户支持代理

随着推理成本的下降，这些服务的边际成本也在降低，这使得这些智能应用公司得以扩展，并创造出新的市场。

以 XBOW 为例。XBOW 正在开发一款 AI 渗透测试专家。渗透测试是模拟网络攻击，以帮助企业评估其安全系统。在生成式 AI 出现之前，企业仅在有限情况下（如需要符合合规要求时）聘请渗透测试人员，因为人工渗透测试成本高昂，这是一项由高技能人员执行的手动任务。然而，XBOW 已经展示了基于最新推理型大型语言模型的自动化渗透测试，其性能可与最优秀的人类渗透测试专家相媲美。这不仅扩大了渗透测试市场，还使得各类企业可以持续进行渗透测试，无论其规模大小。

### What does this mean for the SaaS universe?

Earlier this year we met with our Limited Partners. Their top question was "will the AI transition destroy your existing cloud companies?"

We began with a strong default of "no." The classic battle between startups and incumbents is a horse race between startups building distribution and incumbents building product. Can the young companies with cool products get to a bunch of customers before the incumbents who own the customers come up with cool products? Given that so much of the magic in AI is coming from the foundation models, our default assumption has been no—the incumbents will do just fine, because those foundation models are just as accessible to them as they are to the startup universe, and they have the preexisting advantages of data and distribution. The primary opportunity for startups is not to replace incumbent software companies—it's to go after automatable pools of work.

That being said, we are no longer so sure. See above re: cognitive architectures. There's an enormous amount of engineering required to turn the raw capabilities of a model into a compelling, reliable, end-to-end business solution. What if we're just dramatically underestimating what it means to be "AI native"?

Twenty years ago the on-prem software companies scoffed at the idea of SaaS. "What's the big deal? We can run our own servers and deliver this stuff over the internet too!" Sure, conceptually it was simple. But what followed was a wholesale reinvention of the business. EPD went from waterfalls and PRDs to agile development and AB testing. GTM went from top-down enterprise sales and steak dinners to bottoms-up PLG and product analytics. Business models went from high ASPs and maintenance streams to high NDRs and usage-based pricing. Very few on-prem companies made the transition.

What if AI is an analogous shift? Could the opportunity for AI be both selling work and replacing software?

With Day.ai, we have seen a glimpse of the future. Day is an AI native CRM. Systems integrators make billions of dollars configuring Salesforce to meet your needs. With nothing but access to your email and calendar and answers to a one-page questionnaire, Day automatically generates a CRM that is perfectly tailored to your business. It doesn't have all the bells and whistles (yet), but the magic of an auto-generated CRM that remains fresh with zero human input is already causing people to switch.

这对 SaaS 领域意味着什么？

今年早些时候，我们与有限合伙人（LP）会面时，他们的首要问题是：「AI 的转型是否会颠覆现有的云计算公司？」

我们的初步答案是「不太可能」。初创公司和传统公司之间的竞争通常是一场赛跑，初创公司专注于建立分销渠道，而传统公司则专注于产品开发。关键问题是，那些拥有创新产品的年轻公司能否在传统公司开发出类似产品之前抢占市场？由于 AI 的许多核心技术来自基础模型，我们的默认假设是：传统公司会安然无恙，因为这些基础模型对他们和初创公司都一样可用，而且他们在数据和分销方面具有先天优势。对初创公司的主要机会不在于取代传统软件公司，而是开辟自动化工作的新领域。

然而，随着时间推移，我们开始有所动摇。参见上文提到的认知架构。将模型的基础能力转化为引人注目的、可靠的端到端商业解决方案需要大量工程投入。如果我们低估了「AI 原生」意味着的颠覆性呢？

二十年前，本地软件公司曾对 SaaS 持怀疑态度。他们认为：「我们也可以通过互联网运行自己的服务器，提供这些服务！」概念听起来简单，但实际上，随后却是一场彻底的商业模式变革。工程和产品开发（EPD）从瀑布式开发转向敏捷开发和 A/B 测试。市场推广（GTM）从自上而下的企业销售转变为自下而上的产品驱动增长（PLG）。商业模式从高价产品和维护费转变为高净增长率（NDR）和基于使用量的定价。最终，极少数本地软件公司成功完成了转型。

如果 AI 带来类似的变革呢？AI 的机会是否既在于销售工作成果，也在于取代现有的软件？

以 Day.ai 为例，我们已经看到了未来的雏形。Day 是一款 AI 原生的 CRM 系统。系统集成商为 Salesforce 的配置赚取了数十亿美元。而 Day 只需访问用户的电子邮件和日历，并通过一个简单的问卷，就能自动生成一个完全符合业务需求的 CRM 系统。虽然它目前还缺乏所有附加功能，但这种自动生成且无需人工操作的 CRM，已经让许多人选择了切换。

### The Investment Universe

Where are we spending our cycles as investors? Where is funding being deployed? Here's our quick take.

Infrastructure

This is the domain of hyperscalers. It's being driven by game theoretic behavior, not microeconomics. Terrible place for venture capitalists to be.

Models

This is the domain of hyperscalers and financial investors. Hyperscalers are trading balance sheets for income statements, investing money that's just going to round-trip back to their cloud businesses in the form of compute revenue. Financial investors are skewed by the "wowed by science" bias. These models are super cool and these teams are incredibly impressive. Microeconomics be damned!

Developer tools and infrastructure software

Less interesting for strategics and more interesting for venture capitalists. ~15 companies with $1Bn+ of revenue were created at this layer during the cloud transition, and we suspect the same could be true with AI.

Apps

The most interesting layer for venture capital. ~20 application layer companies with $1Bn+ in revenue were created during the cloud transition, another ~20 were created during the mobile transition, and we suspect the same will be true here.

投资方向

作为投资者，我们的精力投入在哪里？资金又流向了哪些领域？以下是我们的简要见解。

基础设施

这是超大规模企业的领域，其推动力更多来自博弈论行为，而非微观经济学。对风险投资者而言，这不是理想的投资方向。

模型

这同样是超大规模企业和财务投资者的领域。超大规模企业用资产负债表换取收入，投资的资金最终会回流到其云计算业务。财务投资者则受到了「科学惊叹」效应的影响 —— 这些模型的确令人惊叹，这些团队也非常出色，经济效益暂且搁置一旁。

开发者工具和基础设施软件

对于战略投资者来说，这一层可能不太有吸引力，但对于风险投资者而言却非常具有潜力。在云计算转型期间，约有 15 家公司在这一层面达到了 10 亿美元的收入规模。我们认为，AI 转型中，这一层同样潜力巨大。

应用

这是风险投资者最感兴趣的层面。在云计算转型期间，约有 20 家应用层公司达到了 10 亿美元收入；在移动互联网转型期间，另有 20 家公司达到了这一规模。我们认为，AI 转型过程中，类似的情况也会再次发生。

### Closing Thoughts

In Generative AI's next act, we expect to see the impact of reasoning R&D ripple into the application layer. These ripples are fast and deep. Most of the cognitive architectures to date incorporate clever "unhobbling" techniques; now that these capabilities are becoming baked deeper into the models themselves, we expect that agentic applications will become much more sophisticated and robust, quickly.

Back in the research lab, reasoning and inference-time compute will continue to be a strong theme for the foreseeable future. Now that we have a new scaling law, the next race is on. But for any given domain, it is still hard to gather real-world data and encode domain and application-specific cognitive architectures. This is again where last-mile app providers may have the upper hand in solving the diverse set of problems in the messy real world.

Thinking ahead, multi-agent systems, like Factory's droids, may begin to proliferate as ways of modeling reasoning and social learning processes. Once we can do work, we can have teams of workers accomplishing so much more.

What we're all eagerly awaiting is Generative AI's Move 37, that moment when – like in AlphaGo's second game against Lee Sedol – a general AI system surprises us with something superhuman, something that feels like independent thought. This does not mean that the AI "wakes up" (AlphaGo did not) but that we have simulated processes of perception, reasoning and action that the AI can explore in truly novel and useful ways. This may in fact be AGI, and if so it will not be a singular occurrence, it will merely be the next phase of technology.

结语

在生成式 AI 的下一阶段，我们预计推理研究的成果将迅速影响到应用层，而且这些变化将非常迅速且深远。到目前为止，大多数认知架构都使用了巧妙的「解锁」技术；现在，随着这些能力深度嵌入模型，我们预计智能应用将变得更加复杂和强大，并且这一进展会非常迅速。

回到研究领域，推理及推理时计算将在未来相当长的一段时间内继续成为研究的核心主题。随着新的扩展规律的出现，推理竞赛已经开始。不过，在特定领域内，收集真实世界数据并构建特定应用场景的认知架构依然是一个挑战。这也是「最后一公里」应用提供商在解决现实世界复杂问题中可能具有优势的原因。

展望未来，像 Factory 公司开发的多智能体系统可能会逐步普及，这类系统可以模拟推理和社会学习过程。一旦 AI 能够执行复杂的工作任务，我们可以设想一个由 AI「工人」组成的团队，将能够完成更多的工作。

我们所有人都在期待生成式 AI 的「第 37 步」，就像 AlphaGo 在与李世乭对弈的第二局中展现出的超人表现一样 —— 这将标志着 AI 系统在独立思考能力方面的重大突破。虽然这不意味着 AI 真正「觉醒」（AlphaGo 并没有觉醒），但它意味着我们已经成功模拟出了感知、推理和行动的过程，使得 AI 能够以全新且有用的方式进行探索。这可能是通用人工智能（AGI）的开始，如果真是如此，它不会是单一的事件，而是科技发展的下一个阶段。