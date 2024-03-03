## 20231229Does-One-Large-Model-Rule-Them-All

[Maithra Raghu | Does One Large Model Rule Them All?](https://maithraraghu.com/blog/2023/does-one-model-rule-them-all/)

Predictions on the Future AI Ecosystem

Maithra Raghu (Samaya AI), Matei Zaharia (Databricks), Eric Schmidt (Schmidt Futures)

April 4, 2023

### 01. Will the future AI landscape be dominated by a single general AI model

The past 10 years have seen a constant stream of AI advances, with each new wave of developments enabling exciting new capabilities and applications. The biggest such wave has undoubtedly been the recent rise of a single, general AI model, for example LLMs, which can be used for an enormous diversity of tasks, from code generation, to image understanding to scientific reasoning.

These tasks are performed with such high fidelity that an entire new generation of technology applications is being defined and developed. While it's thrilling to contemplate the potential impact, this runaway success does leave us with a deeply uncomfortable question about the future AI ecosystem:

Will the future AI landscape be dominated by a single general AI model?

Specifically, will the future AI landscape:

1. Be dominated by a small (<5) number of entities, each with a large, general AI model?

2. Have these general AI models be the critical component powering all significant technical AI advances and products?

With the release of models like ChatGPT and GPT-4 which have transformed our understanding on what AI can do, and the rising costs for developing such models, this has become a prevalent belief.

在过去的十年里，人工智能（AI）领域持续取得了重大进展，每一次新的发展浪潮都为我们带来了令人兴奋的新能力和应用。最引人注目的变化无疑是近期单一通用 AI 模型的崛起，例如大型语言模型（LLMs），这些模型可以应用于从代码生成、图像理解到科学推理等极其多样的任务。

这些任务的执行质量如此之高，以至于定义和发展了一个全新的技术应用时代。虽然思考这种潜力的影响令人兴奋，但这种迅速的成功也让我们对未来 AI 生态系统面临一个深刻而棘手的问题：

未来的 AI 格局是否会被单一的通用 AI 模型所主导？

具体来说，未来的 AI 格局是否会：

1、由少数（不超过 5 个）实体主导，每个实体都拥有一个庞大的通用 AI 模型？

2、这些通用 AI 模型成为推动所有重要技术 AI 进步和产品的核心组成部分？

随着像 ChatGPT 和 GPT-4 这样的模型的发布，它们改变了我们对 AI 能做什么的看法，而且开发此类模型的成本不断升高，这已成为一种普遍认可的看法。

We believe the contrary!

- There will be many entities contributing to the advance of the AI ecosystem.

- And numerous, high-utility AI systems will emerge, distinct from (single) general AI models.

- These AI systems will be complex in structure, powered by multiple AI models, APIs, etc, and will spur new technical AI developments.

- Well defined, high-value workflows will primarily be addressed by specialized AI systems not general purpose AI models.

We can illustrate our prediction for the AI ecosystem with the following diagram:

Imagine we took all workflows amenable to AI-based solutions, and plotted them in decreasing order of "value". Value could be revenue potential, or simply utility to users. There would be a small number of very high value workflows — a large market or a large number of users with a clearly defined painpoint addressable by AI. This would descend to a long, heavy tail of diverse, but lower value workflows, representing the many custom predictive tasks that AI could help with.

What are examples of high value workflows? It's still early, but we're seeing exciting developments in coding assistants, visual content creation, search and writing assistants.

What about the heavy tail of lower value workflows? These will be less clearly specified, custom needs arising out of custom circumstances. For example, triaging requests from a customer support bot via classification.

We predict that the top left of the diagram (high value workflows) will be dominated by specialized AI systems, and as we follow the blue curve down to lower value workflows, general AI models will take over as the predominant approach.

At first, this picture looks counterintuitive. Some of the most advanced AI capabilities seem to be coming from general purpose models. So why shouldn't those dominate the high value workflows? But thinking through how the ecosystem is likely to evolve, there are a number of important factors supporting the picture, which we expand on below.

我们认为情况正好相反！

- 将会有众多实体为 AI 生态系统的发展做出贡献。

- 会出现许多高效能的 AI 系统，它们与单一的通用 AI 模型有所区别。

- 这些 AI 系统将具有复杂的结构，由多种 AI 模型、API 等驱动，并将推动新的技术 AI 发展。

- 主要针对明确、高价值工作流程的，将是专用 AI 系统而不是通用 AI 模型。

我们可以通过以下图表来展示我们对 AI 生态系统的预测：

想象一下，如果我们将所有适合 AI 解决方案的工作流程按照「价值」降序排列。这里的价值可以是收入潜力，或者对用户的实用性。会有少数非常高价值的工作流程 —— 面向大市场或大量用户的，有明确定义的需求点可以通过 AI 来解决。这将逐渐过渡到一个长且重的尾部，代表着多样化但价值较低的工作流程，AI 可以在这些任务中发挥作用。

高价值工作流程的例子有哪些？尽管现在说还为时尚早，但我们已经看到了一些令人兴奋的发展，比如编程助手、视觉内容创作、搜索和写作助手等。

那么低价值工作流程的「重尾」部分包括什么呢？这些通常是不太明确的，源于特定环境的定制需求。例如，通过分类方法处理客户支持机器人的请求。

我们预测，在图表的左上方（即高价值工作流程）将主要由专业 AI 系统所主导。而随着我们沿着蓝色曲线向下至低价值工作流程，通用 AI 模型将成为主导方法。

乍看之下，这种观点似乎有些反直觉。一些最先进的 AI 能力似乎源自于通用模型。那么为什么这些模型不应该主导高价值工作流程呢？但是，仔细思考生态系统可能的发展方式，我们可以找到许多重要因素支持这一观点，我们将在下面进行详细阐述。

### 02. Specialization is Crucial for Quality

High value workflows require high quality, and reward any quality improvements. Any AI solution applied to a high value workflow is constantly adapted to increase quality. As gaps in quality arise from workflow specific considerations, this adaptation results in specialization.

Specialization could be as straightforward as tuning on workflow specific data, or (more likely), developing multiple specialized AI components.

We can walk through a concrete example by considering current AI systems for self-driving cars. These systems have multiple AI components, from a planning component, to detection components and components for data labeling and generation. (See e.g. Tesla's AI day presentations for more detail.)

Naively replacing this specialized AI system with a general AI model like GPT-4 would lead to a catastrophic drop in quality.

But could a more advanced general AI model, GPT-(4+n), applied strategically, perform this workflow?

We can conduct a thought-experiment for how this might unfold:

- Imagine GPT-(4+n) is released, with remarkably useful capabilities, including for self-driving.

- We can't instantly replace the entire existing system.

- So we identify the most useful capabilities of GPT-(4+n) and look at adding those in as another component, perhaps via an API call.

- This new system is then tested out, and inevitably, gaps in quality are identified.

- There is a push to address these gaps, and as they arise from a specific workflow (self-driving), workflow specific solutions are developed.

- The end result could have the API call completely replaced with a new, specialized AI component, or augmented with other specialized components.

While this thought experiment might not be fully accurate, it illustrates how we may start with a general AI model, but then specialize it substantially to improve quality.

In summary, (1) quality matters for high value workflows, and (2) specialization helps with quality.

[Tesla AI Day 2022 - YouTube](https://www.youtube.com/watch?v=ODSJsviD_SU)

专业化对于确保质量至关重要

高价值工作流程需要高水平的质量，并且任何对质量的提升都会得到奖励。应用于高价值工作流程的任何 AI 解决方案都在持续调整中，以提升其质量。由于工作流程特定考虑因素产生的质量差距，这种调整最终导致专业化。

专业化可以是针对特定工作流程数据的调整这样直接，或更可能是开发多个专门的 AI 组件。

我们可以通过考虑当前自动驾驶汽车的 AI 系统来说明这一点。这些系统包含多个 AI 组件，从规划组件到检测组件，以及数据标注和生成的组件。（例如，可以参考特斯拉 AI 日的演示以获取更多细节。）

用像 GPT-4 这样的通用 AI 模型简单地替换这种专业的 AI 系统，将导致质量的急剧下降。

但是，一个更先进的通用 AI 模型，比如 GPT-(4+n)，如果以策略性的方式应用，它能否执行这个工作流程呢？

我们可以进行一个思维实验，来探索这可能的发展过程：

- 假设 GPT-(4+n) 发布了，具备了非常实用的能力，包括在自动驾驶方面。

- 我们不能立即替换掉整个现有系统。

- 因此，我们识别出 GPT-(4+n) 最有用的能力，并考虑通过 API 调用等方式将其作为一个新组件添加进来。

- 随后对这个新系统进行测试，不可避免地会发现一些质量上的差距。

- 接着会有努力去解决这些差距，而由于这些差距源自特定工作流程（自动驾驶），因此会开发出针对该工作流程的专门解决方案。

- 最终结果可能是用一个新的、专门的 AI 组件完全替换 API 调用，或者用其他专门的组件进行增强。

虽然这个思维实验可能不完全精确，但它展示了我们可能从一个通用 AI 模型开始，然后进行大量专业化来提升质量。

总结来说，（1）对于高价值工作流程而言，质量非常重要；（2）专业化有助于提升质量。

### 03. Making Use of User Feedback

Closely related to quality considerations is the role of user feedback. There is clear evidence that careful tuning on high quality, human "usage" data (e.g. preferences, instructions, prompts and responses, etc), is central in pushing the capabilities of general AI models.

For example in LLMs, techniques such as RLHF (Reinforcement Learning from Human Feedback) and supervised learning on human-like instruction/preference data have been crucial in getting high quality generations and instruction following behavior. This was notably demonstrated with InstructGPT and ChatGPT, and is now spurring a number of LLM development efforts (Alpaca, Dolly, gpt4all).

Similarly, we expect user feedback to play a key role in pushing capabilities of AI for specific workflows. But effectively incorporating that feedback will require having fine-grained control over the AI system. Not only might we want to carefully tune underlying models to the user feedback (hard with a general AI model due to cost and limited access), but we may need to adapt the structure of the entire AI system, e.g. define interactions between data, AI models and tools.

Setting up such fine-grained controls for a general AI model is challenging from engineering (diverse finetuning approaches, chaining API calls, working with different AI components), cost (large models are expensive to adapt) and security (parameter leakage, data sharing) perspectives.

In summary, the fine-grained control needed for user feedback is much easier to achieve with specialized AI systems.

利用用户反馈

与质量考虑紧密相关的是用户反馈的作用。有明确证据表明，精心调整高质量的人类「使用」数据（例如偏好、指示、提示和回应等）对于推动通用 AI 模型的能力至关重要。

例如，在 LLMs 中，如 RLHF（来自人类反馈的强化学习）和对人类指令/偏好数据进行的监督学习等技术，在生成高质量的内容和遵循指令行为方面发挥了关键作用。这在 InstructGPT 和 ChatGPT 中得到了显著的展示，并正在激励一系列 LLM 的开发工作（例如 Alpaca、Dolly、gpt4all）。

同样，我们预期用户反馈将在推动特定工作流程 AI 能力方面发挥关键作用。但有效地整合这些反馈将需要对 AI 系统进行精细控制。我们不仅可能希望仔细调整底层模型以适应用户反馈（对于通用 AI 模型来说由于成本和访问限制而较为困难），而且可能需要调整整个 AI 系统的结构，比如定义数据、AI 模型和工具之间的互动。

从工程（多样化的微调方法、链式 API 调用、处理不同 AI 组件）、成本（调整大型模型成本高昂）和安全性（参数泄露、数据共享）角度来看，为通用 AI 模型设置这种精细控制具有挑战性。

总结来说，实现用户反馈所需的精细控制对于专门的 AI 系统来说更加容易。

### 04. Proprietary Data and Proprietary Knowledge

Many high-value, domain-specific workflows rely on rich, proprietary datasets. Optimal AI solutions for these workflows would require training on this data. However, the entities that own these datasets will be focused on preserving their data moat, and are unlikely to allow unfederated access to third parties for AI training. So these entities will build AI systems specialized for these workflows in-house or via specific partnerships. These will be distinct from general AI models.

Related to this, many domains also make use of proprietary knowledge — a "trade secret" only understood by a few human experts. For example, the technology powering cutting-edge chip fabrication at TSMC, or the quantitative algorithms used at a top hedge fund. AI solutions leveraging this proprietary knowledge will again be built in-house, specialized to these workflows.

These are examples of a "build vs buy" calculation that has occurred for many previous tech cycles and will recur in this wave also.

专有数据和专有知识

许多高价值、特定领域的工作流程依赖于丰富的专有数据集。这些工作流程的最佳 AI 解决方案需要在这些数据上进行训练。然而，拥有这些数据集的实体会专注于保护它们的数据优势，并不太可能允许第三方未联合访问用于 AI 训练。因此，这些实体将在内部或通过特定合作构建专门针对这些工作流程的 AI 系统。这些系统与通用 AI 模型有所不同。

此外，许多领域还利用专有知识 —— 仅有少数人类专家理解的「商业秘密」。例如，台积电（TSMC）在先进芯片制造方面的技术，或顶级对冲基金使用的量化算法。利用这些专有知识的 AI 解决方案将再次由内部开发，专门针对这些工作流程。

这些都是「自建与购买」决策的例子，这种决策在许多过去的技术周期中已经出现，并且在这一波中也将再次发生。

### 05. Commoditization of AI Models

Simultaneously with efforts to develop expensive, proprietary models like GPT-4, are efforts to build and release AI models such as Llama, which are then rapidly optimized to run even on a phone(!)

These are examples of a fierce, ongoing contest between (1) cost-based utility, and (2) efficiency.

Efficiency refers to the rapid process of making new AI advances less costly while maintaining utility. This happens due to a few key properties:

The AI field has strong roots in collaborations, published research and open sourcing, resulting in speedy knowledge dissemination of (painstakingly discovered) technical insights.

Compute costs for training popular AI models decrease quickly due to better hardware, infrastructure and training methodology.

Efforts to collect, curate and open source datasets help democratize model building and improve quality.

For our current most powerful models, it seems likely that efficiency will win in the contest, leading to commoditization of these models.

AI 模型的商品化

与开发像 GPT-4 这样昂贵、专有的模型的努力同时进行的，还有构建并发布像 Llama 这样的 AI 模型的努力，这些模型随后迅速优化，甚至可以在手机上运行。

这些是在（1）基于成本的效用和（2）效率之间的激烈而持续的竞争的例子。

效率指的是在保持效用的同时，使新的 AI 进步变得更加低成本的快速过程。这是因为几个关键因素：

1、AI 领域在协作、研究发布和开源方面有深厚的根基，导致（经过艰苦发现的）技术洞见的快速传播。

2、由于更好的硬件、基础设施和训练方法，训练流行 AI 模型的计算成本快速下降。

3、收集、整理和开源数据集的努力有助于民主化模型建设，提高质量。

对于我们目前最强大的模型来说，似乎效率在这场竞争中可能会占上风，从而导致这些模型的商品化。

### 06. The Future of General AI Models?

But does this mean all large, general AI models will be commoditized?

That depends on the other contestant, cost-based utility. If an AI model is useful but also very costly, it takes longer for the efficiency process to run its course — the more upfront cost, the longer it takes to reduce the cost.

- If the costs remain in the range of where they are today, there will likely be total commoditization.

- If costs increase by an order of magnitude but utility shows diminishing returns, then again we will see commoditization

- If costs increase by an order of magnitude and there are proportional gains in utility, then it's likely that there will be a small number of very high cost, general purpose models that are not commoditized.

Which is most likely to happen?

It's hard to predict for certain. Future AI models definitely have scope to be built with even larger amounts/types of data and increased compute. If the utility also continues to increase, we will have a few, expensive general AI models used for an enormous tail of diverse, hard-to-define workflows as illustrated in the diagram above — doing for AI what cloud did for compute.

通用 AI 模型的未来？

但这是否意味着所有大型通用 AI 模型都将被商品化？

这取决于基于成本的效用。如果一个 AI 模型虽然有用，但成本非常高，那么降低成本的效率过程就会更长 —— 前期成本越高，降低成本的时间就越长。

如果成本保持在当前水平，那么很可能会出现完全商品化。

如果成本增加了一个数量级，但效用呈现递减回报，那么我们将再次看到商品化。

如果成本增加了一个数量级，同时效用也有相应的提高，那么可能会有少数非常昂贵的通用 AI 模型，它们不会被商品化。

哪种情况最有可能发生？

这很难准确预测。未来的 AI 模型无疑有使用更多量/类型的数据和增加计算能力的空间。如果效用也继续增加，我们将拥有一些昂贵的通用 AI 模型，用于处理大量多样化、难以定义的工作流程，正如上图所示 —— 这对 AI 领域的影响，就像云计算对计算领域的影响一样。

### 07. In Conclusion

Despite the decade-long wave of AI advances, the future of AI still looks more eventful than the past! We expect a rich ecosystem to emerge, with a variety of high-value, specialized AI systems, powered by different AI components, along with a few general AI models, supporting a large diversity of AI workflows.

尽管 AI 在过去十年中取得了迅速发展，其未来看起来比过去更加激动人心！我们预计将出现一个丰富的生态系统，包括多种高价值、专业化的 AI 系统，这些系统由不同的 AI 组件驱动，同时还有少数支持广泛 AI 工作流程的通用 AI 模型。