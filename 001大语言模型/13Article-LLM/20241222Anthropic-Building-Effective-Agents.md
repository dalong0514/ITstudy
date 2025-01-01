## 20241222Anthropic-Building-effective-agents

[Building effective agents \ Anthropic](https://www.anthropic.com/research/building-effective-agents)

2024 年 12 月 20 日

Over the past year, we've worked with dozens of teams building large language model (LLM) agents across industries. Consistently, the most successful implementations weren't using complex frameworks or specialized libraries. Instead, they were building with simple, composable patterns.

一年来，我们与构建大语言模型（LLM）智能体的多个行业团队合作。通常，成功的实现并未依赖复杂的框架或专门的库。相反，他们依赖于简单且可组合的模式来构建。

In this post, we share what we've learned from working with our customers and building agents ourselves, and give practical advice for developers on building effective agents.

本文中，我们分享了与客户合作以及自行构建智能体时的经验，并为开发人员提供了关于如何构建有效智能体的实用建议。

### 01. What are agents?

"Agent" can be defined in several ways. Some customers define agents as fully autonomous systems that operate independently over extended periods, using various tools to accomplish complex tasks. Others use the term to describe more prescriptive implementations that follow predefined workflows. At Anthropic, we categorize all these variations as agentic systems, but draw an important architectural distinction between workflows and agents:

「智能体」可以有多种解释。一些用户认为，智能体是那种能够在一段较长时间内自主运行的系统，它们会利用各种工具来完成复杂的任务。另一些人则用「智能体」来指代那些遵循预先设定的工作流程的系统。在 Anthropic，我们将这些不同类型统称为智能体系统，但在架构上，我们会对工作流程和智能体进行重要区分：

Workflows are systems where LLMs and tools are orchestrated through predefined code paths.

工作流是一种系统，使用预先设定的代码路径来管理大语言模型（LLMs）和工具的协作。

Agents, on the other hand, are systems where LLMs dynamically direct their own processes and tool usage, maintaining control over how they accomplish tasks.

与此不同，智能体是一种系统，允许大语言模型（LLMs）动态地管理自己的流程和工具使用，从而自主掌控任务的完成方式。

Below, we will explore both types of agentic systems in detail. In Appendix 1 ("Agents in Practice"), we describe two domains where customers have found particular value in using these kinds of systems.

下文中，我们将详细探讨这两种类型的 AI 智能体系统。在附录 1（实际应用中的智能体）中，我们描述了两个领域，在这些领域中，客户发现这些系统特别有用。

### 02. When (and when not) to use agents

When building applications with LLMs, we recommend finding the simplest solution possible, and only increasing complexity when needed. This might mean not building agentic systems at all. Agentic systems often trade latency and cost for better task performance, and you should consider when this tradeoff makes sense.

在利用大语言模型（LLM）构建应用程序时，我们建议优先采用最简单的解决方案，只有在确实需要时才增加复杂性。这意味着可能不需要构建 AI 智能体系统。智能体系统通常会以增加延迟和成本为代价来提升任务性能，因此需要仔细评估这种权衡是否值得。

When more complexity is warranted, workflows offer predictability and consistency for well-defined tasks, whereas agents are the better option when flexibility and model-driven decision-making are needed at scale. For many applications, however, optimizing single LLM calls with retrieval and in-context examples is usually enough.

在处理复杂任务时，工作流可以为明确的任务提供稳定性和一致性。而在需要大规模灵活性和依靠模型决策的情况下，智能体则是更合适的选择。然而，对于大多数应用来说，通过检索和提供上下文示例来优化单次大语言模型（LLM）的调用通常已经足够。

### 03. When and how to use frameworks

何时以及如何使用框架

There are many frameworks that make agentic systems easier to implement, including:

目前有许多框架可以简化 AI 智能体系统的实现过程，包括：

- LangGraph from LangChain;

- Amazon Bedrock's AI Agent framework;

- Rivet, a drag and drop GUI LLM workflow builder; and

- Vellum, another GUI tool for building and testing complex workflows.

Rivet 是一个拖放式 GUI 大语言模型（LLM）工作流构建器，Vellum 则是另一个用于构建和测试复杂工作流的 GUI 工具。

These frameworks make it easy to get started by simplifying standard low-level tasks like calling LLMs, defining and parsing tools, and chaining calls together. However, they often create extra layers of abstraction that can obscure the underlying prompts ​​and responses, making them harder to debug. They can also make it tempting to add complexity when a simpler setup would suffice.

这些框架通过简化一些标准的底层任务，比如调用大语言模型（LLM)、定义和解析工具、以及串联多个调用，使得我们更容易上手操作。然而，这些框架往往会引入额外的抽象层，这可能会隐藏底层的提示和响应信息，导致调试变得更加困难。此外，它们还可能使我们倾向于在简单设置就足够的情况下，过于复杂化。

We suggest that developers start by using LLM APIs directly: many patterns can be implemented in a few lines of code. If you do use a framework, ensure you understand the underlying code. Incorrect assumptions about what's under the hood are a common source of customer error.

我们建议开发者从使用大语言模型（LLM）API 开始：许多模式只需几行代码即可实现。如果你确实使用框架，请确保你理解底层代码。对底层工作原理的错误假设是客户错误的常见来源。

See our cookbook for some sample implementations.

[anthropic-cookbook/patterns/agents at main · anthropics/anthropic-cookbook · GitHub](https://github.com/anthropics/anthropic-cookbook/tree/main/patterns/agents)

### 04. Building blocks, workflows, and agents

In this section, we'll explore the common patterns for agentic systems we've seen in production. We'll start with our foundational building block—the augmented LLM—and progressively increase complexity, from simple compositional workflows to autonomous agents.

在本节中，我们将探讨在生产中常见的 AI 智能体系统模式。我们将从基础构建模块 —— 增强型大语言模型（augmented LLM）开始，并逐步增加复杂性，从简单的工作流组合到自主智能体。

#### Building block: The augmented LLM

构建块：增强型大语言模型

The basic building block of agentic systems is an LLM enhanced with augmentations such as retrieval, tools, and memory. Our current models can actively use these capabilities—generating their own search queries, selecting appropriate tools, and determining what information to retain.

智能体系统的基础模块是一个通过增强功能（如检索、工具和记忆）提升的大语言模型。我们现有的模型可以主动利用这些功能 —— 自行生成搜索查询，选择合适的工具，并决定保留哪些信息。

Fig: The augmented LLM

We recommend focusing on two key aspects of the implementation: tailoring these capabilities to your specific use case and ensuring they provide an easy, well-documented interface for your LLM. While there are many ways to implement these augmentations, one approach is through our recently released Model Context Protocol, which allows developers to integrate with a growing ecosystem of third-party tools with a simple client implementation.

大语言模型的增强功能我们建议关注实现过程中的两个关键方面：根据您的具体用例对这些功能进行定制，并确保它们为您的大语言模型提供简单且文档齐全的接口。尽管有多种方法可以实现这些增强功能，但其中一种方法是使用我们最近发布的模型上下文协议。这一协议允许开发人员通过简单的客户端实现，轻松集成到日益扩展的第三方工具生态系统中。

For the remainder of this post, we'll assume each LLM call has access to these augmented capabilities.

在接下来的内容中，我们将假设每次调用 LLM 时都具备这些增强能力。

#### Workflow: Prompt chaining

工作流：提示词链接

Prompt chaining decomposes a task into a sequence of steps, where each LLM call processes the output of the previous one. You can add programmatic checks (see "gate" in the diagram below) on any intermediate steps to ensure that the process is still on track.

Prompt 链式调用将一个任务分解为一系列步骤，其中每个大语言模型（LLM）调用都会处理前一个调用的输出。您可以在任何中间步骤中添加程序检查（请参见图中的「gate」），以确保该过程保持正常。

Fig: The prompt chaining workflow

When to use this workflow: This workflow is ideal for situations where the task can be easily and cleanly decomposed into fixed subtasks. The main goal is to trade off latency for higher accuracy, by making each LLM call an easier task.

提示链工作流适用场景：这种工作流非常适合那些可以轻松且明确地分解为固定子任务的情况。其主要目标是通过将每次大语言模型（LLM）的调用简化为更容易的任务，从而在增加一些延迟的情况下提高整体准确性。

Examples where prompt chaining is useful:

提示链在以下场景中非常有用：

1 Generating Marketing copy, then translating it into a different language.

首先生成市场营销文案，接着将文案翻译成不同的语言。

2 Writing an outline of a document, checking that the outline meets certain criteria, then writing the document based on the outline.

#### Workflow: Routing

Routing classifies an input and directs it to a specialized followup task. This workflow allows for separation of concerns, and building more specialized prompts. Without this workflow, optimizing for one kind of input can hurt performance on other inputs.

路由机制会对输入进行分类，并将其引导至特定的后续任务。这种工作流程能够将不同的任务需求分开处理，并制定更有针对性的提示。如果缺少这种工作流程，针对某一类输入的优化可能会导致其他类型输入的表现下降。

Fig: The routing workflow

When to use this workflow: Routing works well for complex tasks where there are distinct categories that are better handled separately, and where classification can be handled accurately, either by an LLM or a more traditional classification model/algorithm.

路由流程在什么情况下使用此流程：路由适用于复杂任务，这些任务可分为不同类别，分别处理会更有效，而分类过程可以通过大语言模型或传统的分类模型/算法准确完成。

Examples where routing is useful:

路由的应用实例：

1 Directing different types of customer service queries (general questions, refund requests, technical support) into different downstream processes, prompts, and tools.

例如，可以将不同类型的客户服务查询（如一般问题、退款请求和技术支持）分别引导到不同的后续流程、提示或工具中。

2 Routing easy/common questions to smaller models like Claude 3.5 Haiku and hard/unusual questions to more capable models like Claude 3.5 Sonnet to optimize cost and speed.

将简单常见的问题分配给较小的模型，如 Claude 3.5 Haiku，而将困难不常见的问题交给更强大的模型，如 Claude 3.5 Sonnet，以降低成本并提高处理速度。

#### Workflow: Parallelization

LLMs can sometimes work simultaneously on a task and have their outputs aggregated programmatically. This workflow, parallelization, manifests in two key variations:

大语言模型（LLM）有时可以同时进行任务处理，并通过编程方式整合其结果。这种被称为并行化的工作流程，主要有两种形式：

1 Sectioning: Breaking a task into independent subtasks run in parallel.

任务分解：将一个任务拆分为若干可以独立并行运行的子任务。

2 Voting: Running the same task multiple times to get diverse outputs.

多次执行：多次运行相同的任务以获得多样化的结果。

Fig: The parallelization workflow

When to use this workflow: Parallelization is effective when the divided subtasks can be parallelized for speed, or when multiple perspectives or attempts are needed for higher confidence results. For complex tasks with multiple considerations, LLMs generally perform better when each consideration is handled by a separate LLM call, allowing focused attention on each specific aspect.

并行化的工作流程使用时机：如果任务可以被分解为可以并行处理的子任务以提高速度，或者需要通过多个视角或尝试来获得更可靠的结果，那么并行化是一个有效的策略。在处理复杂任务时，如果涉及多个考虑因素，通常每个因素由一个单独的大语言模型（LLM）来处理效果更佳，这样可以专注于每个具体方面。

Examples where parallelization is useful:

并行化有用的示例：

1 Sectioning:

分区：

Implementing guardrails where one model instance processes user queries while another screens them for inappropriate content or requests. This tends to perform better than having the same LLM call handle both guardrails and the core response.

为了确保系统的安全性，我们可以采用一种方法：由一个模型实例专门处理用户的查询，而另一个模型则负责检查这些查询中是否包含不当内容或请求。这种分工通常比让同一个大语言模型同时负责安全检查和响应生成的效果更佳。

Automating evals for evaluating LLM performance, where each LLM call evaluates a different aspect of the model's performance on a given prompt.

自动化评估系统可用于测试大语言模型的表现，通过对同一提示词的多次调用，分别评估模型在不同能力维度上的表现。

2 Voting:

Reviewing a piece of code for vulnerabilities, where several different prompts review and flag the code if they find a problem.

审核代码片段以查找漏洞，使用多个不同的检测机制来审查代码，并在发现问题时进行标记。

Evaluating whether a given piece of content is inappropriate, with multiple prompts evaluating different aspects or requiring different vote thresholds to balance false positives and negatives.

评估给定内容是否不当，使用多个检测机制来评估不同方面，或者要求不同的投票阈值以平衡误报和漏报。

#### Workflow: Orchestrator-workers

In the orchestrator-workers workflow, a central LLM dynamically breaks down tasks, delegates them to worker LLMs, and synthesizes their results.

在 orchestrator-workers 工作流程中，中央的大语言模型动态地分解任务，分配给多个工人 LLM，并整合这些工人 LLM 的结果。

Fig: The orchestrator-workers workflow

协调者与工作者模式的工作流程

When to use this workflow: This workflow is well-suited for complex tasks where you can't predict the subtasks needed (in coding, for example, the number of files that need to be changed and the nature of the change in each file likely depend on the task). Whereas it's topographically similar, the key difference from parallelization is its flexibility—subtasks aren't pre-defined, but determined by the orchestrator based on the specific input.

此工作流程适用于以下情况：当处理复杂任务时，例如在编程中，无法预先确定需要完成的子任务。这种模式与并行化类似，但其核心区别在于灵活性。子任务并非预先设定，而是由协调者根据具体输入来决定。

Example where orchestrator-workers is useful:

编排者-工人模式的一个示例用途：

1 Coding products that make complex changes to multiple files each time.

编程产品需要每次对多个文件进行复杂的更改。

2 Search tasks that involve gathering and analyzing information from multiple sources for possible relevant information.

搜索任务是指从多个来源收集和分析信息，以寻找可能有用的资料。

#### Workflow: Evaluator-optimizer

工作流程：评估者-优化器

In the evaluator-optimizer workflow, one LLM call generates a response while another provides evaluation and feedback in a loop.

在评估器-优化器的工作流程中，首先由一个大语言模型（LLM）生成响应，接着另一个 LLM 对该响应进行评估并提供反馈，这个过程会在一个循环中持续进行。

Fig: The evaluator-optimizer workflow

评估器-优化器的工作流程是指通过这种循环机制不断改进响应质量的过程。

When to use this workflow: This workflow is particularly effective when we have clear evaluation criteria, and when iterative refinement provides measurable value. The two signs of good fit are, first, that LLM responses can be demonstrably improved when a human articulates their feedback; and second, that the LLM can provide such feedback. This is analogous to the iterative writing process a human writer might go through when producing a polished document.

使用此工作流程的时机：当我们拥有明确的评估标准，并且迭代优化能够带来可衡量的价值时，这种工作流程特别有效。有两个标志表明适合使用这种方法：首先，当人类给予反馈时，大语言模型（LLM）的响应能够得到显著改善；其次，LLM 本身能够提供这样的反馈。这类似于人类作者在撰写一份精美文档时可能经历的迭代写作过程。

Examples where evaluator-optimizer is useful:

评估器-优化器的应用实例：

1 Literary translation where there are nuances that the translator LLM might not capture initially, but where an evaluator LLM can provide useful critiques.

在文学翻译中，可能存在一些翻译大语言模型最初无法捕捉到的细微之处，而评估器大语言模型能够提供有价值的反馈。

2 Complex search tasks that require multiple rounds of searching and analysis to gather comprehensive information, where the evaluator decides whether further searches are warranted.

复杂搜索任务需要多次进行搜索和分析，以便收集全面的信息，评估人员会决定是否需要进行进一步的搜索。

#### Agents

智能体

Agents are emerging in production as LLMs mature in key capabilities—understanding complex inputs, engaging in reasoning and planning, using tools reliably, and recovering from errors. Agents begin their work with either a command from, or interactive discussion with, the human user. Once the task is clear, agents plan and operate independently, potentially returning to the human for further information or judgement. During execution, it's crucial for the agents to gain "ground truth" from the environment at each step (such as tool call results or code execution) to assess its progress. Agents can then pause for human feedback at checkpoints or when encountering blockers. The task often terminates upon completion, but it's also common to include stopping conditions (such as a maximum number of iterations) to maintain control.

随着大语言模型在理解复杂输入、进行推理和规划、可靠使用工具以及纠正错误等关键能力上不断成熟，智能体在实际应用中开始崭露头角。智能体的工作通常由人类用户的命令或互动讨论开启。一旦任务明确，它们就会开始独立地计划和执行，必要时可能会回到人类用户处寻求更多信息或判断。在执行过程中，智能体需要在每一步获取来自环境的「实际情况」（例如工具调用结果或代码执行）以评估进展。当到达检查点或遇到问题时，智能体可能会暂停以获取人类用户的反馈。任务通常在完成后终止，但通常也设置了停止条件（例如最大迭代次数）以保持对过程的控制。

Agents can handle sophisticated tasks, but their implementation is often straightforward. They are typically just LLMs using tools based on environmental feedback in a loop. It is therefore crucial to design toolsets and their documentation clearly and thoughtfully. We expand on best practices for tool development in Appendix 2 ("Prompt Engineering your Tools").

AI 智能体能够处理复杂的任务，但其实现通常相对简单。它们基本上是大语言模型，通过环境反馈的工具循环来工作。因此，设计工具集及其文档时，需要做到清晰和周密。我们在附录 2（为您的工具进行提示工程）中详细介绍了工具开发的最佳实践。

Fig: Autonomous agent

When to use agents: Agents can be used for open-ended problems where it's difficult or impossible to predict the required number of steps, and where you can't hardcode a fixed path. The LLM will potentially operate for many turns, and you must have some level of trust in its decision-making. Agents' autonomy makes them ideal for scaling tasks in trusted environments.

自主智能体适合使用智能体的场景：当面临难以预测步骤或无法预先设定路径的复杂问题时，可以选择使用智能体。这些问题通常无法通过固定的程序解决，而是需要灵活应对。大语言模型（LLM）可能需要多次交互，因此对其决策能力的信任是必要的。智能体的自主性使其在可信任的环境中能够有效地扩展和处理任务。

The autonomous nature of agents means higher costs, and the potential for compounding errors. We recommend extensive testing in sandboxed environments, along with the appropriate guardrails.

由于 AI 智能体具备自主性，这会导致更高的成本，并可能带来累积的错误。我们建议在隔离的测试环境中进行充分的测试，并设置适当的安全防护措施。

Examples where agents are useful:

AI 智能体的用途示例：

The following examples are from our own implementations:

以下是我们自己实现的示例：

1 A coding Agent to resolve SWE-bench tasks, which involve edits to many files based on a task description;

[Raising the bar on SWE-bench Verified with Claude 3.5 Sonnet \ Anthropic](https://www.anthropic.com/research/swe-bench-sonnet)

一个用于解决 SWE-bench 任务的编码 AI 智能体，这些任务要求根据任务描述对多个文件进行编辑；

2 Our "computer use" reference implementation, where Claude uses a computer to accomplish tasks.

[anthropic-quickstarts/computer-use-demo at main · anthropics/anthropic-quickstarts · GitHub](https://github.com/anthropics/anthropic-quickstarts/tree/main/computer-use-demo)

我们所说的「计算机使用」参考实现，是指 Claude 如何使用计算机来完成这些任务。

Fig: High-level flow of a coding agent

### 05. Combining and customizing these patterns

编码智能体的高级流程结合并定制这些模式

These building blocks aren't prescriptive. They're common patterns that developers can shape and combine to fit different use cases. The key to success, as with any LLM features, is measuring performance and iterating on implementations. To repeat: you should consider adding complexity only when it demonstrably improves outcomes.

这些构建模块并不是固定不变的。它们是开发人员可以根据不同的用例进行塑造和组合的常见模式。成功的关键，与任何大语言模型（LLM）的特性一样，在于衡量性能并不断优化实现。请记住：只有当复杂性能够带来显著改善时，才应该增加复杂性。

### Summary

Success in the LLM space isn't about building the most sophisticated system. It's about building the right system for your needs. Start with simple prompts, optimize them with comprehensive evaluation, and add multi-step agentic systems only when simpler solutions fall short.

在大语言模型（LLM）领域取得成功并不在于打造最复杂的系统，而在于开发满足实际需求的系统。可以从简单的提示开始，通过全面评估来优化这些提示，只有当简单的解决方案无法满足时，再考虑引入多步骤的智能体系统。

When implementing agents, we try to follow three core principles:

在开发智能体时，我们尝试遵循三个核心原则：

1 Maintain simplicity in your agent's design.

保持智能体设计简单。

2 Prioritize transparency by explicitly showing the agent's planning steps.

注重透明性，务必要清晰展示智能体的规划步骤。

3 Carefully craft your agent-computer interface (ACI) through thorough tool documentation and testing.

要通过详尽的工具文档和测试，精心设计智能体-计算机接口（ACI）。

Frameworks can help you get started quickly, but don't hesitate to reduce abstraction layers and build with basic components as you move to production. By following these principles, you can create agents that are not only powerful but also reliable, maintainable, and trusted by their users.

框架可以帮助您快速开始，但在进入生产阶段时，可以减少抽象层，使用基本组件进行构建。通过遵循这些原则，您可以创建出既强大又可靠的智能体，同时也更易于维护，赢得用户的信任。

Acknowledgements

Written by Erik Schluntz and Barry Zhang. This work draws upon our experiences building agents at Anthropic and the valuable insights shared by our customers, for which we're deeply grateful.

致谢本文由 Erik Schluntz 和 Barry Zhang 撰写。我们的工作基于在 Anthropic 构建智能体的经验，并得到了客户分享的宝贵见解，在此我们深表感谢。

### Appendix 1: Agents in practice

附录 1：实际应用中的智能体

Our work with customers has revealed two particularly promising applications for AI agents that demonstrate the practical value of the patterns discussed above. Both applications illustrate how agents add the most value for tasks that require both conversation and action, have clear success criteria, enable feedback loops, and integrate meaningful human oversight.

我们与客户的合作发现了两个非常有前景的 AI 智能体应用，这些应用展示了我们讨论的模式在实际中的价值。这两个案例说明了智能体如何在需要对话和行动的任务中发挥最大作用。这些任务有明确的成功标准，可以实现反馈循环，并且能够有效整合人类监督。

A. Customer support

A. 客户支持

Customer support combines familiar chatbot interfaces with enhanced capabilities through tool integration. This is a natural fit for more open-ended agents because:

客户支持通过工具集成，提升了传统聊天机器人的功能。这种方式非常适合那些具有开放性功能的智能体，因为：

1 Support interactions naturally follow a conversation flow while requiring access to external information and actions;

客户支持互动通常按照自然的对话流程进行，但同时需要访问外部信息和执行操作；

2 Tools can be integrated to pull customer data, order history, and knowledge base articles;

可以通过集成工具来提取客户数据、订单历史及知识库文章；

3 Actions such as issuing refunds or updating tickets can be handled programmatically; and

Success can be clearly measured through user-defined resolutions.

像发放退款和更新票证这样的操作可以通过编程方式来处理；而且，

成功可以通过用户定义的解决方案来清晰地衡量。

Several companies have demonstrated the viability of this approach through usage-based pricing models that charge only for successful resolutions, showing confidence in their agents' effectiveness.

几家公司采用了基于使用量的定价模型，这种模型只对成功的解决方案收费，从而展示了这种方法的可行性，并对其智能体的有效性充满信心。

B. Coding agents

B. 编码智能体

The software development space has shown remarkable potential for LLM features, with capabilities evolving from code completion to autonomous problem-solving. Agents are particularly effective because:

在软件开发领域，大语言模型（LLM）展示了惊人的潜力，其能力从简单的代码补全逐步发展到可以自主解决复杂问题。智能体之所以特别有效，是因为：

1 Code solutions are verifiable through automated tests;

代码解决方案可以通过自动化测试来验证其正确性； 

2 Agents can iterate on solutions using test results as feedback;

AI 智能体能够使用测试结果作为反馈，不断改进和优化解决方案；

3 The problem space is well-defined and structured; and

Output quality can be measured objectively.

问题的范围已经明确且结构化，同时输出的质量可以被客观地评估。

In our own implementation, agents can now solve real GitHub issues in the SWE-bench Verified benchmark based on the pull request description alone. However, whereas automated testing helps verify functionality, human review remains crucial for ensuring solutions align with broader system requirements.

在我们的实现中，AI 智能体现在可以仅凭拉取请求描述，解决 SWE-bench Verified 基准测试中的真实 GitHub 问题。然而，虽然自动化测试可以帮助验证功能，但人工审查对于确保解决方案符合更广泛的系统要求仍然至关重要。

### Appendix 2: Prompt engineering your tools

附录 2：为工具进行提示工程

No matter which agentic system you're building, tools will likely be an important part of your agent. Tools enable Claude to interact with external services and APIs by specifying their exact structure and definition in our API. When Claude responds, it will include a tool use block in the API response if it plans to invoke a tool. Tool definitions and specifications should be given just as much prompt engineering attention as your overall prompts. In this brief appendix, we describe how to prompt engineer your tools.

不论您正在构建哪种类型的智能系统，工具通常是智能体中非常重要的一部分。通过在我们的 API 中精确指定结构和定义，工具可以让 Claude 与外部服务和 API 进行交互。当 Claude 做出响应并计划调用工具时，它会在 API 响应中包含一个工具使用块。工具的定义和规格应像整体提示一样受到提示工程的重视。在这个简短的附录中，我们将介绍如何为您的工具进行提示工程。

There are often several ways to specify the same action. For instance, you can specify a file edit by writing a diff, or by rewriting the entire file. For structured output, you can return code inside markdown or inside JSON. In software engineering, differences like these are cosmetic and can be converted losslessly from one to the other. However, some formats are much more difficult for an LLM to write than others. Writing a diff requires knowing how many lines are changing in the chunk header before the new code is written. Writing code inside JSON (compared to markdown) requires extra escaping of newlines and quotes.

通常可以通过多种方法实现相同的操作。例如，进行文件编辑时，可以选择编写一个 diff，或者干脆重写整个文件。对于结构化输出，可以选择在 markdown 中返回代码，或者在 JSON 中返回。在软件工程中，这些差异仅仅是表面上的，可以无损地相互转换。然而，对于大语言模型（LLM）来说，有些格式比其他格式更难编写。编写一个 diff 时，在新代码写入前需要知道块头中有多少行发生了变化。而在 JSON 中写代码（相较于 markdown）时，则需要额外处理换行符和引号的转义。

Our suggestions for deciding on tool formats are the following:

我们的关于决定工具格式的建议如下：

1 Give the model enough tokens to "think" before it writes itself into a corner.

给模型提供足够的 Token，以便在它陷入困境之前进行充分的思考。

2 Keep the format close to what the model has seen naturally occurring in text on the internet.

3 Make sure there's no formatting "overhead" such as having to keep an accurate count of thousands of lines of code, or string-escaping any code it writes.

One rule of thumb is to think about how much effort goes into human-computer interfaces (HCI), and plan to invest just as much effort in creating good agent-computer interfaces (ACI). Here are some thoughts on how to do so:

一个常用的经验法则是，在设计人机交互（HCI）时需要投入大量的精力，而在设计智能体-计算机接口（ACI）时，也应投入同样的精力。以下是一些实现这一目标的建议：

1 Put yourself in the model's shoes. Is it obvious how to use this tool, based on the description and parameters, or would you need to think carefully about it? If so, then it's probably also true for the model. A good tool definition often includes example usage, edge cases, input format requirements, and clear boundaries from other tools.

设身处地想一想，仅凭描述和参数，是否能很容易地使用这个工具，还是需要仔细斟酌？如果需要仔细斟酌，那么对于模型来说，也可能会遇到类似的困难。一个好的工具定义通常会包括使用实例、极端情况、输入格式要求，以及与其他工具的明确区分。

2 How can you change parameter names or descriptions to make things more obvious? Think of this as writing a great docstring for a junior developer on your team. This is especially important when using many similar tools.

如何更改参数名称或描述，使其更加清晰易懂？可以将此视为为团队中的初级开发人员编写一份优秀的文档字符串。特别是在使用许多相似工具时，这一点尤为重要，因为清晰的文档可以帮助开发人员快速理解和正确使用工具。

3 Test how the model uses your tools: Run many example inputs in our workbench to see what mistakes the model makes, and iterate.

测试模型对工具的使用方式：在工作台上多次运行示例输入，观察模型可能出现的错误，并通过迭代来改正这些错误。

4 Poka-yoke your tools. Change the arguments so that it is harder to make mistakes.

对你的工具进行 Poka-yoke（防错设计）。更改参数设置，以减少错误的发生。

While building our agent for SWE-bench, we actually spent more time optimizing our tools than the overall prompt. For example, we found that the model would make mistakes with tools using relative filepaths after the agent had moved out of the root directory. To fix this, we changed the tool to always require absolute filepaths—and we found that the model used this method flawlessly.

在为 SWE-bench 构建智能体的过程中，我们发现优化工具比优化整体提示花费了更多时间。比如，当智能体从根目录移出后，模型在使用相对文件路径的工具时容易出错。为了解决这个问题，我们修改了工具，要求它们始终使用绝对文件路径。结果表明，模型在这种情况下运行得非常顺利。

## 原文

Building effective agents

2024 年 12 月 20 日

Over the past year, we've worked with dozens of teams building large language model (LLM) agents across industries. Consistently, the most successful implementations weren't using complex frameworks or specialized libraries. Instead, they were building with simple, composable patterns.

In this post, we share what we've learned from working with our customers and building agents ourselves, and give practical advice for developers on building effective agents.

What are agents?

"Agent" can be defined in several ways. Some customers define agents as fully autonomous systems that operate independently over extended periods, using various tools to accomplish complex tasks. Others use the term to describe more prescriptive implementations that follow predefined workflows. At Anthropic, we categorize all these variations as agentic systems, but draw an important architectural distinction between workflows and agents:

Workflows are systems where LLMs and tools are orchestrated through predefined code paths.

Agents, on the other hand, are systems where LLMs dynamically direct their own processes and tool usage, maintaining control over how they accomplish tasks.

Below, we will explore both types of agentic systems in detail. In Appendix 1 ("Agents in Practice"), we describe two domains where customers have found particular value in using these kinds of systems.

When (and when not) to use agents

When building applications with LLMs, we recommend finding the simplest solution possible, and only increasing complexity when needed. This might mean not building agentic systems at all. Agentic systems often trade latency and cost for better task performance, and you should consider when this tradeoff makes sense.

When more complexity is warranted, workflows offer predictability and consistency for well-defined tasks, whereas agents are the better option when flexibility and model-driven decision-making are needed at scale. For many applications, however, optimizing single LLM calls with retrieval and in-context examples is usually enough.

When and how to use frameworks

There are many frameworks that make agentic systems easier to implement, including:

LangGraph from LangChain;

Amazon Bedrock's AI Agent framework;

Rivet, a drag and drop GUI LLM workflow builder; and

Vellum, another GUI tool for building and testing complex workflows.

These frameworks make it easy to get started by simplifying standard low-level tasks like calling LLMs, defining and parsing tools, and chaining calls together. However, they often create extra layers of abstraction that can obscure the underlying prompts ​​and responses, making them harder to debug. They can also make it tempting to add complexity when a simpler setup would suffice.

We suggest that developers start by using LLM APIs directly: many patterns can be implemented in a few lines of code. If you do use a framework, ensure you understand the underlying code. Incorrect assumptions about what's under the hood are a common source of customer error.

See our cookbook for some sample implementations.

Building blocks, workflows, and agents

In this section, we'll explore the common patterns for agentic systems we've seen in production. We'll start with our foundational building block—the augmented LLM—and progressively increase complexity, from simple compositional workflows to autonomous agents.

Building block: The augmented LLM

The basic building block of agentic systems is an LLM enhanced with augmentations such as retrieval, tools, and memory. Our current models can actively use these capabilities—generating their own search queries, selecting appropriate tools, and determining what information to retain.

The augmented LLM

We recommend focusing on two key aspects of the implementation: tailoring these capabilities to your specific use case and ensuring they provide an easy, well-documented interface for your LLM. While there are many ways to implement these augmentations, one approach is through our recently released Model Context Protocol, which allows developers to integrate with a growing ecosystem of third-party tools with a simple client implementation.

For the remainder of this post, we'll assume each LLM call has access to these augmented capabilities.

Workflow: Prompt chaining

Prompt chaining decomposes a task into a sequence of steps, where each LLM call processes the output of the previous one. You can add programmatic checks (see "gate" in the diagram below) on any intermediate steps to ensure that the process is still on track.

The prompt chaining workflow

When to use this workflow: This workflow is ideal for situations where the task can be easily and cleanly decomposed into fixed subtasks. The main goal is to trade off latency for higher accuracy, by making each LLM call an easier task.

Examples where prompt chaining is useful:

Generating Marketing copy, then translating it into a different language.

Writing an outline of a document, checking that the outline meets certain criteria, then writing the document based on the outline.

Workflow: Routing

Routing classifies an input and directs it to a specialized followup task. This workflow allows for separation of concerns, and building more specialized prompts. Without this workflow, optimizing for one kind of input can hurt performance on other inputs.

The routing workflow

When to use this workflow: Routing works well for complex tasks where there are distinct categories that are better handled separately, and where classification can be handled accurately, either by an LLM or a more traditional classification model/algorithm.

Examples where routing is useful:

Directing different types of customer service queries (general questions, refund requests, technical support) into different downstream processes, prompts, and tools.

Routing easy/common questions to smaller models like Claude 3.5 Haiku and hard/unusual questions to more capable models like Claude 3.5 Sonnet to optimize cost and speed.

Workflow: Parallelization

LLMs can sometimes work simultaneously on a task and have their outputs aggregated programmatically. This workflow, parallelization, manifests in two key variations:

Sectioning: Breaking a task into independent subtasks run in parallel.

Voting: Running the same task multiple times to get diverse outputs.

The parallelization workflow

When to use this workflow: Parallelization is effective when the divided subtasks can be parallelized for speed, or when multiple perspectives or attempts are needed for higher confidence results. For complex tasks with multiple considerations, LLMs generally perform better when each consideration is handled by a separate LLM call, allowing focused attention on each specific aspect.

Examples where parallelization is useful:

Sectioning:

Implementing guardrails where one model instance processes user queries while another screens them for inappropriate content or requests. This tends to perform better than having the same LLM call handle both guardrails and the core response.

Automating evals for evaluating LLM performance, where each LLM call evaluates a different aspect of the model's performance on a given prompt.

Voting:

Reviewing a piece of code for vulnerabilities, where several different prompts review and flag the code if they find a problem.

Evaluating whether a given piece of content is inappropriate, with multiple prompts evaluating different aspects or requiring different vote thresholds to balance false positives and negatives.

Workflow: Orchestrator-workers

In the orchestrator-workers workflow, a central LLM dynamically breaks down tasks, delegates them to worker LLMs, and synthesizes their results.

The orchestrator-workers workflow

When to use this workflow: This workflow is well-suited for complex tasks where you can't predict the subtasks needed (in coding, for example, the number of files that need to be changed and the nature of the change in each file likely depend on the task). Whereas it's topographically similar, the key difference from parallelization is its flexibility—subtasks aren't pre-defined, but determined by the orchestrator based on the specific input.

Example where orchestrator-workers is useful:

Coding products that make complex changes to multiple files each time.

Search tasks that involve gathering and analyzing information from multiple sources for possible relevant information.

Workflow: Evaluator-optimizer

In the evaluator-optimizer workflow, one LLM call generates a response while another provides evaluation and feedback in a loop.

The evaluator-optimizer workflow

When to use this workflow: This workflow is particularly effective when we have clear evaluation criteria, and when iterative refinement provides measurable value. The two signs of good fit are, first, that LLM responses can be demonstrably improved when a human articulates their feedback; and second, that the LLM can provide such feedback. This is analogous to the iterative writing process a human writer might go through when producing a polished document.

Examples where evaluator-optimizer is useful:

Literary translation where there are nuances that the translator LLM might not capture initially, but where an evaluator LLM can provide useful critiques.

Complex search tasks that require multiple rounds of searching and analysis to gather comprehensive information, where the evaluator decides whether further searches are warranted.

Agents

Agents are emerging in production as LLMs mature in key capabilities—understanding complex inputs, engaging in reasoning and planning, using tools reliably, and recovering from errors. Agents begin their work with either a command from, or interactive discussion with, the human user. Once the task is clear, agents plan and operate independently, potentially returning to the human for further information or judgement. During execution, it's crucial for the agents to gain "ground truth" from the environment at each step (such as tool call results or code execution) to assess its progress. Agents can then pause for human feedback at checkpoints or when encountering blockers. The task often terminates upon completion, but it's also common to include stopping conditions (such as a maximum number of iterations) to maintain control.

Agents can handle sophisticated tasks, but their implementation is often straightforward. They are typically just LLMs using tools based on environmental feedback in a loop. It is therefore crucial to design toolsets and their documentation clearly and thoughtfully. We expand on best practices for tool development in Appendix 2 ("Prompt Engineering your Tools").

Autonomous agent

When to use agents: Agents can be used for open-ended problems where it's difficult or impossible to predict the required number of steps, and where you can't hardcode a fixed path. The LLM will potentially operate for many turns, and you must have some level of trust in its decision-making. Agents' autonomy makes them ideal for scaling tasks in trusted environments.

The autonomous nature of agents means higher costs, and the potential for compounding errors. We recommend extensive testing in sandboxed environments, along with the appropriate guardrails.

Examples where agents are useful:

The following examples are from our own implementations:

A coding Agent to resolve SWE-bench tasks, which involve edits to many files based on a task description;

Our "computer use" reference implementation, where Claude uses a computer to accomplish tasks.

High-level flow of a coding agent

Combining and customizing these patterns

These building blocks aren't prescriptive. They're common patterns that developers can shape and combine to fit different use cases. The key to success, as with any LLM features, is measuring performance and iterating on implementations. To repeat: you should consider adding complexity only when it demonstrably improves outcomes.

Summary

Success in the LLM space isn't about building the most sophisticated system. It's about building the right system for your needs. Start with simple prompts, optimize them with comprehensive evaluation, and add multi-step agentic systems only when simpler solutions fall short.

When implementing agents, we try to follow three core principles:

Maintain simplicity in your agent's design.

Prioritize transparency by explicitly showing the agent's planning steps.

Carefully craft your agent-computer interface (ACI) through thorough tool documentation and testing.

Frameworks can help you get started quickly, but don't hesitate to reduce abstraction layers and build with basic components as you move to production. By following these principles, you can create agents that are not only powerful but also reliable, maintainable, and trusted by their users.

Acknowledgements

Written by Erik Schluntz and Barry Zhang. This work draws upon our experiences building agents at Anthropic and the valuable insights shared by our customers, for which we're deeply grateful.

Appendix 1: Agents in practice

Our work with customers has revealed two particularly promising applications for AI agents that demonstrate the practical value of the patterns discussed above. Both applications illustrate how agents add the most value for tasks that require both conversation and action, have clear success criteria, enable feedback loops, and integrate meaningful human oversight.

A. Customer support

Customer support combines familiar chatbot interfaces with enhanced capabilities through tool integration. This is a natural fit for more open-ended agents because:

Support interactions naturally follow a conversation flow while requiring access to external information and actions;

Tools can be integrated to pull customer data, order history, and knowledge base articles;

Actions such as issuing refunds or updating tickets can be handled programmatically; and

Success can be clearly measured through user-defined resolutions.

Several companies have demonstrated the viability of this approach through usage-based pricing models that charge only for successful resolutions, showing confidence in their agents' effectiveness.

B. Coding agents

The software development space has shown remarkable potential for LLM features, with capabilities evolving from code completion to autonomous problem-solving. Agents are particularly effective because:

Code solutions are verifiable through automated tests;

Agents can iterate on solutions using test results as feedback;

The problem space is well-defined and structured; and

Output quality can be measured objectively.

In our own implementation, agents can now solve real GitHub issues in the SWE-bench Verified benchmark based on the pull request description alone. However, whereas automated testing helps verify functionality, human review remains crucial for ensuring solutions align with broader system requirements.

Appendix 2: Prompt engineering your tools

No matter which agentic system you're building, tools will likely be an important part of your agent. Tools enable Claude to interact with external services and APIs by specifying their exact structure and definition in our API. When Claude responds, it will include a tool use block in the API response if it plans to invoke a tool. Tool definitions and specifications should be given just as much prompt engineering attention as your overall prompts. In this brief appendix, we describe how to prompt engineer your tools.

There are often several ways to specify the same action. For instance, you can specify a file edit by writing a diff, or by rewriting the entire file. For structured output, you can return code inside markdown or inside JSON. In software engineering, differences like these are cosmetic and can be converted losslessly from one to the other. However, some formats are much more difficult for an LLM to write than others. Writing a diff requires knowing how many lines are changing in the chunk header before the new code is written. Writing code inside JSON (compared to markdown) requires extra escaping of newlines and quotes.

Our suggestions for deciding on tool formats are the following:

Give the model enough tokens to "think" before it writes itself into a corner.

Keep the format close to what the model has seen naturally occurring in text on the internet.

Make sure there's no formatting "overhead" such as having to keep an accurate count of thousands of lines of code, or string-escaping any code it writes.

One rule of thumb is to think about how much effort goes into human-computer interfaces (HCI), and plan to invest just as much effort in creating good agent-computer interfaces (ACI). Here are some thoughts on how to do so:

Put yourself in the model's shoes. Is it obvious how to use this tool, based on the description and parameters, or would you need to think carefully about it? If so, then it's probably also true for the model. A good tool definition often includes example usage, edge cases, input format requirements, and clear boundaries from other tools.

How can you change parameter names or descriptions to make things more obvious? Think of this as writing a great docstring for a junior developer on your team. This is especially important when using many similar tools.

Test how the model uses your tools: Run many example inputs in our workbench to see what mistakes the model makes, and iterate.

Poka-yoke your tools. Change the arguments so that it is harder to make mistakes.

While building our agent for SWE-bench, we actually spent more time optimizing our tools than the overall prompt. For example, we found that the model would make mistakes with tools using relative filepaths after the agent had moved out of the root directory. To fix this, we changed the tool to always require absolute filepaths—and we found that the model used this method flawlessly.