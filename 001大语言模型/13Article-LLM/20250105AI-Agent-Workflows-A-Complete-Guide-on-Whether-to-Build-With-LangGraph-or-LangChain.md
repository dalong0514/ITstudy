## 20250105AI-Agent-Workflows-A-Complete-Guide-on-Whether-to-Build-With-LangGraph-or-LangChain

AI Agent Workflows: A Complete Guide on Whether to Build With LangGraph or LangChain

A deep dive into two libraries by the same creator — LangChain and LangGraph: their key building blocks, how they handle core pieces of their functionality, and deciding between them for your use case

Sandi Besen

Published in Towards Data Science

Oct 25, 2024

Language models have unlocked possibilities for how users can interact with AI systems and how these systems can communicate with each other — through natural language.

语言模型通过自然语言，为用户与 AI 系统交互以及系统间的相互通信开启了新的可能性。

When enterprises want to build solutions using Agentic AI capabilities one of the first technical questions is often "what tools do I use?" For those that are eager to get started, this is the first roadblock.

当企业希望利用 AI 智能体（AI Agent）的能力构建解决方案时，首先遇到的技术问题之一往往是：「我该使用什么工具？」对于那些迫切想要开始的人来说，这便成了首要的难题。

In this article, we will explore two of the most popular frameworks for building Agentic AI Applications — LangChain and LangGraph. By the end of this article you should have a thorough understanding of the key building blocks, how each framework differs in handling core pieces of their functionality, and be able to form an educated point of view on which framework best fits your problem.

本文将深入探讨构建 AI 智能体应用的两个主流框架：LangChain 和 LangGraph。阅读完本文，您将全面了解它们的核心组成部分，掌握它们在处理核心功能上的差异，并能够判断哪个框架更适合您的需求。

Since the practice of widely incorporating Generative AI into solutions is relatively new, open-source players are actively competing to develop the "best" agent framework and orchestration tools. This means that although each player brings a unique approach to the table, they are rolling out new functionality near constantly. When reading this piece keep in mind that what's true today, might not be true tomorrow!

由于将生成式 AI（Generative AI）广泛应用于解决方案还是一种相对较新的实践，开源领域的参与者正在积极竞争，以开发出「最佳」的 AI 智能体框架和编排工具。这意味着，尽管每个参与者都有其独特的方法，但他们几乎都在持续推出新的功能。请记住，本文所描述的现状，可能明天就会发生变化！

Note: I originally intended to draw the comparison between AutoGen, LangChain, and LangGraph. However, AutoGen has announced that it launching AutoGen 0.4, a complete redesign of the framework from the foundation up. Look out for another article when AutoGen 0.4 launches!

注意：我原本计划比较 AutoGen、LangChain 和 LangGraph 这三者。但是，AutoGen 已经宣布即将推出 AutoGen 0.4 版本，这是一个从底层到上层都完全重新设计的框架。请留意后续文章，届时将深入探讨 AutoGen 0.4 的新特性！

### Base Components Of LangChain and LangGraph

LangChain 和 LangGraph 的基本组件

By understanding the different base elements of each framework, you will have a richer understanding of the key differences on how they handle certain core functionality in the next section. The below description is not an exhaustive list of all of the components of each framework, but serves as a strong basis to understand the difference in their general approach.

理解每个框架的不同基本元素，将有助于你更深入地理解它们在下一节中如何处理某些核心功能，以及它们之间的关键差异。下面的描述并非详尽列出每个框架的所有组件，而是为了让你更好地理解它们在方法上的总体差异，提供一个坚实的基础。

LangChain

There are two methods for working with LangChain: as a sequential chain of predefined commands or using LangChain agents. Each approach is different in the way it handles tools and orchestration. A chain follows a predefined linear workflow while an agent acts as a coordinator that can make more dynamic (non linear) decisions.

使用 LangChain 有两种方式：一种是像预先设定好的命令链一样按顺序执行，另一种是使用 LangChain AI 智能体。这两种方式在如何使用工具和组织流程上有所不同。命令链遵循预定的线性流程，而 AI 智能体则更像一个协调者，可以做出更灵活（非线性）的决策。

Chains: A sequence of steps that can include calls to an llm, agent, tool, external data source, procedural code, and more. Chains can branch, meaning a single chain to split into multiple paths based on logical conditions.

链：指的是一系列步骤，其中可以包含对大语言模型（LLM）、AI 智能体、工具、外部数据源以及程序代码等的调用。链可以根据逻辑条件进行分支，形成多条不同的执行路径。

Agents or Language Models: A Language Model has the ability to generate responses in natural language. But the Agent uses a language model plus added capabilities to reason, call tools, and repeat the process of calling tools in case there are any failures.

AI 智能体还是大语言模型：大语言模型能够生成自然语言的回复。而 AI 智能体则是在大语言模型的基础上，增加了推理、调用工具等能力，并且能在调用工具失败时重复尝试。

Tools: Code based functions that can be called in the chain or invoked by an agent to interact with external systems.

工具：基于代码的函数，这些函数可以在流程中被调用，或者由 AI 智能体调用，以便与外部系统进行交互。

Prompts: This can include a system prompt that instructs the model how to complete a task and what tools are available, information injected from external data sources that provided the model more context, and the user prompt or task for the model to complete.

提示：这包括一个系统指令，它指示模型如何完成任务以及可以使用哪些工具；从外部数据源获取并注入的信息，为模型提供更多背景知识；以及用户给出的提示或模型需要完成的任务。

LangGraph

LangGraph approaches AI workflows from a different standpoint. Much like the name suggests, it orchestrates workflows like a graph. Because of its flexibility in handling different flows between AI agents, procedural code, and other tools, it is better suited for use cases where a linear chain method, branched chain, or simple agent system wouldn't meet the needs of the use case. LangGraph was designed to handle more complex conditional logic and feedback loops compared to LangChain.

LangGraph 用一种不同的视角看待 AI 工作流程。顾名思义，它像图结构一样组织工作流程。因为它在处理 AI 智能体、程序代码和其他工具之间的不同流程时具有很高的灵活性，所以它更适用于那些线性链式方法、分支链或者简单的智能体系统无法满足需求的场景。相比于 LangChain，LangGraph 的设计初衷是处理更加复杂的条件逻辑和反馈循环。

Graphs: A flexible way of organizing a workflow that can include calls to an llm, tool, external data source, procedural code, and more. LangGraph supports cyclical graphs as well; which means you can create loops and feedback mechanisms so nodes can be revisited multiple times.

图结构：一种灵活的工作流程组织方式，它允许在流程中调用大语言模型、工具、外部数据源以及过程代码等。LangGraph 还支持循环图结构，这意味着您可以创建循环和反馈机制，使流程中的节点可以被多次访问。

Nodes: Represent steps in the workflow, such as an LLM query, an API call, or tool execution.

节点：代表工作流程中的各个步骤，例如向大语言模型（LLM）发出查询、调用应用程序接口（API）或执行工具。

Edges and Conditional Edges: Edges define the flow of information by connecting the output of one node as the input to the next. A conditional edge defines the flow of information from one node to another if a certain condition is met. Developers can custom define these conditions.

边和条件边：边用于连接各个节点，将一个节点的输出作为下一个节点的输入，从而定义信息流动的方向。条件边则根据特定条件，决定信息从一个节点流向另一个节点。开发人员可以根据需要自定义这些条件。

State: State is the current status of the application as information flows through the graph. It is a developer defined mutable TypedDict object that contains all the relevant information for the current execution of the graph. LangGraph automatically handles the updating of state at each node as information flows through the graph.

状态：状态是指当信息在图中传递时，应用程序所处的当前情况。它是一个由开发者定义的可变 `TypedDict` 对象，包含了图当前执行过程中的所有相关信息。LangGraph 会在信息流经图的过程中，自动处理每个节点的状态更新。

Agents or Language Models: Language models within a graph are solely responsible for generating a text response to an input. The agent capability leverages a language model but enables the graph to have multiple nodes representing different components of the agent (such as reasoning, tool selection, and execution of a tool). The agent can make decisions about which path to take in the graph, update the state of the graph, and perform more tasks than just text generation.

AI 智能体还是大语言模型：在图中，大语言模型仅负责根据输入生成文本回复。而 AI 智能体的功能则是在大语言模型的基础上，让图结构中包含多个节点，这些节点代表智能体的不同组成部分，例如推理、工具选择和工具执行。AI 智能体可以决定在图中选择哪条路径，更新图的状态，并且执行比单纯生成文本更复杂的任务。

### The Difference Between How Each Framework Handles Core Functionality

各框架在核心功能处理上的差异

LangGraph and LangChain overlap in some of their capabilities but they approach the problem from a different perspective. LangChain focuses on either linear workflows through the use of chains or different AI agent patterns. While LangGraph focuses on creating a more flexible, granular, process based workflow that can include AI agents, tool calls, procedural code, and more.

LangGraph 和 LangChain 在某些功能上存在重叠，但它们解决问题的方式有所不同。LangChain 侧重于通过「链」（chain）实现线性工作流，或者采用不同的 AI 智能体模式。而 LangGraph 则更关注于创建一种更灵活、更细致、基于流程的工作流，其中可以包含 AI 智能体、工具调用、程序代码等。

In general, LangChain require less of a learning curve than LangGraph. There are more abstractions and pre-defined configurations that make LangChain easier to implement for simple use cases. LangGraph allows more custom control over the design of the workflow, which means that it is less abstracted and the developer needs to learn more to use the framework effectively.

总的来说，LangChain 的学习难度比 LangGraph 低。它提供了更多的封装和预设配置，使得 LangChain 更容易在简单的应用场景中部署。LangGraph 允许对工作流程的设计进行更精细的定制，这意味着它的封装程度较低，开发人员需要学习更多的知识才能有效地使用这个框架。

Tool Calling:

LangChain

In LangChain there are two ways tools can be called depending on if you are using a chain to sequence a series of steps or are just using its agent capabilities without it being explicitly defined in a chain. In a chain, tools are included as a pre-defined step in the chain — meaning that they aren't necessarily called by the agent because it was already predetermined they were going to be called in the chain. However, when you have an agent not defined in a chain, the agent has autonomy to decided what tool to invoke and when based on the list of tools it is privy to.

在 LangChain 中，工具的调用方式有两种。一种是使用链（chain）来编排一系列步骤，另一种是直接使用 AI 智能体（AI Agent）的功能，而无需在链中明确定义。在链中，工具是作为预先定义好的步骤包含在内的 —— 这意味着工具的调用并非由 AI 智能体自主决定，而是链本身已经预先设定好的。然而，当 AI 智能体没有在链中定义时，它可以根据自身所知的工具列表，自主决定调用哪个工具以及何时调用。

Example of Flow for a Chain:

链式调用的例子：

Create the function that represents the tool and make it compatible with the chain

创建一个函数来代表这个工具，并使其与链式调用兼容。

Incorporate the tool into the chain

将工具整合到流程中

Execute the chain

执行流程

Example of Flow for an Agent :

AI 智能体工作流程示例：

The tool is defined

首先，需要定义工具。

The tool is added to the agent

这个工具被集成到了 AI 智能体中。

The agent receives a query and decides whether and when to use the search tool. The agent may use the tool multiple times if needed.

AI 智能体接收到用户提出的问题后，会判断是否需要以及何时使用搜索工具。如有必要，AI 智能体可以多次调用该工具。

LangGraph

In LangGraph, tools are usually represented as a node on the graph. If the graph contains an agent, then then it is the agent that determines which tool to invoke based on its reasoning abilities. Based on the agent's tool decision, the graph navigates to the "tool node" to handle the execution of the tool. Conditional logic can be included in the edge from the agent to the tool node to add additional logic that determines if a tool gets executed. This gives the developer another layer of control if desired. If there is no agent in the graph, then much like in LanchChain's chain, the tool can be included in the workflow based on conditional logic.

在 LangGraph 中，工具通常被表示为图上的一个节点。如果图中包含一个智能体（AI Agent），那么将由该智能体根据其推理能力来决定调用哪个工具。根据智能体的工具选择，图会跳转到相应的「工具节点」来执行该工具。从智能体到工具节点的边上可以设置条件逻辑，以增加额外的判断，来决定是否执行该工具。这为开发者提供了额外的控制层，可以按需使用。如果图中没有智能体，那么就像 LangChain 的链一样，工具也可以基于条件逻辑被包含在工作流程中。

Example of Flow for a Graph with anAgent:

一个包含 AI 智能体的图结构流程示例：

The tool is defined

这里定义了所使用的工具。

the tool is bound to the agent

工具与 AI 智能体绑定。

The agent decides if a tool is needed, and if so which tool.

AI 智能体决定是否需要使用工具，如果需要，则决定使用哪个工具。

The LangGraph framework detects a tool call is required and navigates to the tool node in the graph to execute the tool call.

LangGraph 框架会识别出何时需要调用工具，并引导程序跳转到图中的工具节点来执行该调用。

The tool output is captured and added to the state of the graph

工具的输出结果会被记录下来，并添加到图的状态信息中。

The agent is called again with the updated state to allow it to make a decision on what to do next

为了让 AI 智能体（AI Agent）能够决定下一步的行动，它会被再次调用，并接收更新后的状态信息。

Example of Flow for a graph without an Agent:

以下是没有 AI 智能体的流程图示例：

The tool is defined

定义了一个工具

The tool is added to the graph as a node

这个工具被添加为图中的一个节点

Conditional edges can be used to determine when to use a certain tool node and control the flow of the graph

带有条件的边可以用来确定何时使用某个工具模块，并控制图中信息的流动

The tool can be configured to update the state of the graph

该工具可以被配置为修改图中的数据

If you want to learn more about tool calling, my friend Tula Masterman has an excellent article about how tool calling works in Generative AI.

如果你想深入了解工具调用，我的朋友 Tula Masterman 写了一篇很棒的文章，详细介绍了工具调用在生成式 AI（Generative AI）中是如何运作的。

[AI Agents: The Intersection of Tool Calling and Reasoning in Generative AI | by Tula Masterman | Towards Data Science](https://towardsdatascience.com/ai-agents-the-intersection-of-tool-calling-and-reasoning-in-generative-ai-ff268eece443)

Note: Neither LangChain nor LangGraph support semantic functions out of the box like MSFT's Semantic Kernel.

请注意：LangChain 和 LangGraph 并不像微软（MSFT）的 Semantic Kernel 那样，可以直接使用语义函数。

Conversation History and Memory

关于对话历史与记忆的 LangChain 应用

LangChain

Langchain offers built-in abstractions for handling conversation history and memory. There are options for the level of granularity (and therefore the amount of tokens) you'd like to pass to the llm which include the full session conversation history, a summarized version, or a custom defined memory. Developers can also create custom long term memory systems where they can store memories in external databases to be retrieved when relevant.

Langchain 提供了内置的抽象化工具，用于处理对话历史和记忆。针对传递给大语言模型（LLM）的信息粒度（以及由此产生的 Token 数量），Langchain 提供了多种选择，包括完整的会话历史记录、摘要版本或自定义的记忆。开发人员还可以创建自定义的长期记忆系统，将记忆存储在外部数据库中，并在需要时检索。

LangGraph

In LangGraph, the state handles memory by keeping track of defined variables at every point in time. State can include things like conversation history, steps of a plan, the output of a language model's previous response, and more. It can be passed from one node to the next so that each node has access to what the current state of the system is. However, long term persistent memory across sessions is not available as a direct feature of the framework. To implement this, developers could include nodes responsible to store memories and other variables in an external database to be retrieved later.

在 LangGraph 中，状态通过记录每个时间点定义的变量来管理内存。状态可以包括对话历史、计划步骤、语言模型先前响应的输出等信息。状态可以在节点之间传递，使每个节点都能访问系统的当前状态。但是，不同会话之间的长期记忆并不是该框架的直接功能。为了实现这一点，开发者可以添加一些节点，负责将记忆和其他变量存储到外部数据库，以便后续使用。

Out of the box RAG capabilities:

现成的检索增强生成（Retrieval-Augmented Generation，RAG）功能：

LangChain

LangChain can handle complex retrieval and generation workflows and has a more established set of tools to help developers integrate RAG into their application. For instance LangChain offers document loading, text parsing, embedding creation, vector storage, and retrieval capabilities out of the box by using langchain.document_loaders, langchain.embeddings, and langchain.vectorstores directly.

LangChain 能够应对复杂的检索和生成流程，并且提供了一套更为成熟的工具，帮助开发者将 RAG（检索增强生成）技术集成到他们的应用中。例如，LangChain 通过直接调用 `langchain.document_loaders`、`langchain.embeddings` 和 `langchain.vectorstores` 等模块，即可便捷地实现文档加载、文本解析、嵌入向量生成、向量存储以及信息检索等功能。

LangGraph

In LangGraph, RAG needs to be developed from scratch as part of the graph structure. For example there could be separate nodes for document parsing, embedding, and retrieval that would be connected by normal or conditional edges. The state of each node would be used to pass information between steps in the RAG pipeline.

在 LangGraph 中，检索增强生成（RAG）需要作为图结构的一部分从零开始实现。例如，可以设置独立的节点，分别负责文档解析、嵌入和检索，这些节点通过普通边或条件边连接。每个节点的状态用于在 RAG 流程的各个步骤之间传递信息。

Parallelism:

并行处理：

LangChain

LangChain offers the opportunity to run multiple chains or agents in parallel by using the RunnableParallel class. For more advanced parallel processing and asynchronous tool calling, the developer would have to custom implement these capabilities by using python libraries such as ayncio.

LangChain 允许使用 RunnableParallel 类并行运行多个链或 AI 智能体。对于更复杂的并行处理和异步工具调用，开发者需要使用像 asyncio 这样的 Python 库来定制实现这些功能。

LangGraph

LangGraph supports the parallel execution of nodes, as long as there aren't any dependencies (like the output of one language model's response as an input for the next node). This means that it can support multiple agents running at the same time in a graph as long as they are not dependent nodes. Like LangChain, LangGraph can use a RunnableParallel class to run multiple graphs in parallel. LangGraph also supports parallel tool calling by using python libraries like ayncio.

LangGraph 支持节点的并行执行，前提是这些节点之间没有任何依赖关系（例如，一个语言模型的输出作为下一个节点的输入）。这意味着，只要多个 AI 智能体之间没有依赖关系，它们就可以在同一个图中同时运行。与 LangChain 类似，LangGraph 可以使用 `RunnableParallel` 类（可并行运行的类）来并行运行多个图。LangGraph 还支持使用像 asyncio 这样的 Python 库进行并行工具调用。

Retry Logic and Error Handling:

重试机制与错误处理：

LangChain

In LangChain, the error handling is explicitly defined by the developer and can either be done by introducing retry logic into the chain its self or in the agent if a tool call fails.

在 LangChain 中，错误处理由开发者明确指定，可以通过在链条内部设置重试机制，或者当工具调用失败时，在 AI 智能体中处理错误。

LangGraph

In LangGraph you can actually embed error handling into your workflow by having it be its own node. When certain tasks fail you can point to another node or have the same node retry. The best part is that only the particular node that fails is re-tried, not the entire workflow. This means the graph can resume from the point of failure rather than having to start from the beginning. If your use case requires many steps and tool calls, this could be imortant.

在 LangGraph 中，你可以将错误处理作为一个独立的节点嵌入到工作流程中。当某些任务失败时，你可以将流程导向另一个节点，或者让当前节点重试。最棒的是，只有发生错误的特定节点会被重试，而不是整个工作流程。这意味着，整个流程可以从出错的地方恢复，而无需从头开始。如果你的应用场景需要很多步骤和工具调用，这个特性就显得非常重要。

### In Summary

You can use LangChain without LangGraph, LangGraph without LangChain, or both together! It's also completely possible to explore using LangGraph's graph based orchestration with other Agentic AI frameworks like MSFT's AutoGen by making the AutoGen Agents their own nodes in the graph. Safe to say there are a lot of option — and it can feel overwhelming.

你可以单独使用 LangChain，也可以单独使用 LangGraph，或者将两者结合使用！此外，完全可以通过将 MSFT 的 AutoGen 等其他 AI 智能体（Agentic AI）框架中的智能体作为 LangGraph 图中的节点，来探索使用 LangGraph 基于图的编排能力。可以说，选择非常多，这可能会让人感到无所适从。

So after all this research, when should I use each? Although there are no hard and fast rules, below is my personal option:

那么，经过以上所有研究，我究竟应该在何时使用这些工具呢？虽然没有绝对的规则，但以下是我个人的建议：

Use LangChain Only When:

仅在以下情况使用 LangChain：

You need to quickly prototype or develop AI workflows that either involve sequential tasks (such as such as document retrieval, text generation, or summarization) that follow a predefined linear pattern. Or you want to leverage AI agent patterns that can dynamically make decisions, but you don't need granular control over a complex workflow.

你需要快速构建或开发 AI 工作流程，这些流程要么包含按照预定线性模式执行的顺序任务（例如文档检索、文本生成或摘要），要么你希望利用能够动态决策的 AI 智能体，但你不需要对复杂的工作流程进行细致的控制。

Use LangGraph Only When:

仅在以下情况使用 LangGraph：

Your use case requires non-linear workflows where multiple components interact dynamically such as workflows that depend on conditions, need complex branching logic, error handling, or parallelism. You are willing to build custom implementations for the components that are not abstracted for you like in LangChain.

当你的应用场景需要非线性工作流时，例如多个组件之间需要动态交互，或者工作流依赖于特定条件、需要复杂的分支逻辑、错误处理或并行执行等情况。此外，你还需要愿意为那些没有像 LangChain 中那样被抽象出来的组件构建自定义实现。

Using LangChain and LanGraph Together When:

You enjoy the pre-built extracted components of LangChain such as the out of the box RAG capabilities, memory functionality, etc. but also want to manage complex task flows using LangGraph's non-linear orchestration. Using both frameworks together can be a powerful tool for extracting the best abilities from each.

当您喜欢 LangChain 预先构建好的组件，例如其开箱即用的 RAG（检索增强生成）功能和记忆功能等，同时也希望利用 LangGraph 的非线性编排能力来管理复杂的任务流程时，可以将 LangChain 和 LangGraph 结合使用。这两个框架的协同工作，能够充分发挥各自的优势，成为一个强大的工具。

Ultimately, whether you choose LangChain, LangGraph, or a combination of both depends on the specific needs of your project.

最终，选择 LangChain、LangGraph 还是将两者结合使用，取决于您项目的具体需求。

Note: The opinions expressed both in this article and paper are solely those of the authors and do not necessarily reflect the views or policies of their respective employers.

注意：本文和论文中表达的观点仅代表作者个人，不一定反映他们各自雇主的观点或政策。

Still have questions or think that something needs to be further clarified? Drop me a DM on LinkedIn! I‘m always eager to engage in food for thought and iterate on my work.

还有疑问或者觉得有什么地方需要进一步说明吗？欢迎在 LinkedIn 上给我发私信！我一直很乐意参与有意思的交流，并不断改进我的工作。

## 原文

AI Agent Workflows: A Complete Guide on Whether to Build With LangGraph or LangChain

A deep dive into two libraries by the same creator — LangChain and LangGraph: their key building blocks, how they handle core pieces of their functionality, and deciding between them for your use case

Sandi Besen

Published in Towards Data Science

Oct 25, 2024

Language models have unlocked possibilities for how users can interact with AI systems and how these systems can communicate with each other — through natural language.

When enterprises want to build solutions using Agentic AI capabilities one of the first technical questions is often "what tools do I use?" For those that are eager to get started, this is the first roadblock.

Source:Dalle-3

In this article, we will explore two of the most popular frameworks for building Agentic AI Applications — LangChain and LangGraph. By the end of this article you should have a thorough understanding of the key building blocks, how each framework differs in handling core pieces of their functionality, and be able to form an educated point of view on which framework best fits your problem.

Since the practice of widely incorporating Generative AI into solutions is relatively new, open-source players are actively competing to develop the "best" agent framework and orchestration tools. This means that although each player brings a unique approach to the table, they are rolling out new functionality near constantly. When reading this piece keep in mind that what's true today, might not be true tomorrow!

Note: I originally intended to draw the comparison between AutoGen, LangChain, and LangGraph. However, AutoGen has announced that it launching AutoGen 0.4, a complete redesign of the framework from the foundation up. Look out for another article when AutoGen 0.4 launches!

Base Components Of LangChain and LangGraph

By understanding the different base elements of each framework, you will have a richer understanding of the key differences on how they handle certain core functionality in the next section. The below description is not an exhaustive list of all of the components of each framework, but serves as a strong basis to understand the difference in their general approach.

LangChain

There are two methods for working with LangChain: as a sequential chain of predefined commands or using LangChain agents. Each approach is different in the way it handles tools and orchestration. A chain follows a predefined linear workflow while an agent acts as a coordinator that can make more dynamic (non linear) decisions.

Chains: A sequence of steps that can include calls to an llm, agent, tool, external data source, procedural code, and more. Chains can branch, meaning a single chain to split into multiple paths based on logical conditions.

Agents or Language Models: A Language Model has the ability to generate responses in natural language. But the Agent uses a language model plus added capabilities to reason, call tools, and repeat the process of calling tools in case there are any failures.

Tools: Code based functions that can be called in the chain or invoked by an agent to interact with external systems.

Prompts: This can include a system prompt that instructs the model how to complete a task and what tools are available, information injected from external data sources that provided the model more context, and the user prompt or task for the model to complete.

LangGraph

LangGraph approaches AI workflows from a different standpoint. Much like the name suggests, it orchestrates workflows like a graph. Because of its flexibility in handling different flows between AI agents, procedural code, and other tools, it is better suited for use cases where a linear chain method, branched chain, or simple agent system wouldn't meet the needs of the use case. LangGraph was designed to handle more complex conditional logic and feedback loops compared to LangChain.

Graphs: A flexible way of organizing a workflow that can include calls to an llm, tool, external data source, procedural code, and more. LangGraph supports cyclical graphs as well; which means you can create loops and feedback mechanisms so nodes can be revisited multiple times.

Nodes: Represent steps in the workflow, such as an LLM query, an API call, or tool execution.

Edges and Conditional Edges: Edges define the flow of information by connecting the output of one node as the input to the next. A conditional edge defines the flow of information from one node to another if a certain condition is met. Developers can custom define these conditions.

State: State is the current status of the application as information flows through the graph. It is a developer defined mutable TypedDict object that contains all the relevant information for the current execution of the graph. LangGraph automatically handles the updating of state at each node as information flows through the graph.

Agents or Language Models: Language models within a graph are solely responsible for generating a text response to an input. The agent capability leverages a language model but enables the graph to have multiple nodes representing different components of the agent (such as reasoning, tool selection, and execution of a tool). The agent can make decisions about which path to take in the graph, update the state of the graph, and perform more tasks than just text generation.

The Difference Between How Each Framework Handles Core Functionality

LangGraph and LangChain overlap in some of their capabilities but they approach the problem from a different perspective. LangChain focuses on either linear workflows through the use of chains or different AI agent patterns. While LangGraph focuses on creating a more flexible, granular, process based workflow that can include AI agents, tool calls, procedural code, and more.

In general, LangChain require less of a learning curve than LangGraph. There are more abstractions and pre-defined configurations that make LangChain easier to implement for simple use cases. LangGraph allows more custom control over the design of the workflow, which means that it is less abstracted and the developer needs to learn more to use the framework effectively.

Tool Calling:

LangChain

In LangChain there are two ways tools can be called depending on if you are using a chain to sequence a series of steps or are just using its agent capabilities without it being explicitly defined in a chain. In a chain, tools are included as a pre-defined step in the chain — meaning that they aren't necessarily called by the agent because it was already predetermined they were going to be called in the chain. However, when you have an agent not defined in a chain, the agent has autonomy to decided what tool to invoke and when based on the list of tools it is privy to.

Example of Flow for a Chain:

Image by Sandi Besen

Create the function that represents the tool and make it compatible with the chain

Incorporate the tool into the chain

Execute the chain

Example of Flow for an Agent :

Image by Sandi Besen

The tool is defined

The tool is added to the agent

The agent receives a query and decides whether and when to use the search tool. The agent may use the tool multiple times if needed.

LangGraph

In LangGraph, tools are usually represented as a node on the graph. If the graph contains an agent, then then it is the agent that determines which tool to invoke based on its reasoning abilities. Based on the agent's tool decision, the graph navigates to the "tool node" to handle the execution of the tool. Conditional logic can be included in the edge from the agent to the tool node to add additional logic that determines if a tool gets executed. This gives the developer another layer of control if desired. If there is no agent in the graph, then much like in LanchChain's chain, the tool can be included in the workflow based on conditional logic.

Example of Flow for a Graph with anAgent:

Image by Sandi Besen

The tool is defined

the tool is bound to the agent

The agent decides if a tool is needed, and if so which tool.

The LangGraph framework detects a tool call is required and navigates to the tool node in the graph to execute the tool call.

The tool output is captured and added to the state of the graph

The agent is called again with the updated state to allow it to make a decision on what to do next

Example of Flow for a graph without an Agent:

Image by Sandi Besen

The tool is defined

The tool is added to the graph as a node

Conditional edges can be used to determine when to use a certain tool node and control the flow of the graph

The tool can be configured to update the state of the graph

If you want to learn more about tool calling, my friend Tula Masterman has an excellent article about how tool calling works in Generative AI.

Note: Neither LangChain nor LangGraph support semantic functions out of the box like MSFT's Semantic Kernel.

Conversation History and Memory

LangChain

Langchain offers built-in abstractions for handling conversation history and memory. There are options for the level of granularity (and therefore the amount of tokens) you'd like to pass to the llm which include the full session conversation history, a summarized version, or a custom defined memory. Developers can also create custom long term memory systems where they can store memories in external databases to be retrieved when relevant.

LangGraph

In LangGraph, the state handles memory by keeping track of defined variables at every point in time. State can include things like conversation history, steps of a plan, the output of a language model's previous response, and more. It can be passed from one node to the next so that each node has access to what the current state of the system is. However, long term persistent memory across sessions is not available as a direct feature of the framework. To implement this, developers could include nodes responsible to store memories and other variables in an external database to be retrieved later.

Out of the box RAG capabilities:

LangChain

LangChain can handle complex retrieval and generation workflows and has a more established set of tools to help developers integrate RAG into their application. For instance LangChain offers document loading, text parsing, embedding creation, vector storage, and retrieval capabilities out of the box by using langchain.document_loaders, langchain.embeddings, and langchain.vectorstores directly.

LangGraph

In LangGraph, RAG needs to be developed from scratch as part of the graph structure. For example there could be separate nodes for document parsing, embedding, and retrieval that would be connected by normal or conditional edges. The state of each node would be used to pass information between steps in the RAG pipeline.

Parallelism:

LangChain

LangChain offers the opportunity to run multiple chains or agents in parallel by using the RunnableParallel class. For more advanced parallel processing and asynchronous tool calling, the developer would have to custom implement these capabilities by using python libraries such as ayncio.

LangGraph

LangGraph supports the parallel execution of nodes, as long as there aren't any dependencies (like the output of one language model's response as an input for the next node). This means that it can support multiple agents running at the same time in a graph as long as they are not dependent nodes. Like LangChain, LangGraph can use a RunnableParallel class to run multiple graphs in parallel. LangGraph also supports parallel tool calling by using python libraries like ayncio.

Retry Logic and Error Handling:

LangChain

In LangChain, the error handling is explicitly defined by the developer and can either be done by introducing retry logic into the chain its self or in the agent if a tool call fails.

LangGraph

In LangGraph you can actually embed error handling into your workflow by having it be its own node. When certain tasks fail you can point to another node or have the same node retry. The best part is that only the particular node that fails is re-tried, not the entire workflow. This means the graph can resume from the point of failure rather than having to start from the beginning. If your use case requires many steps and tool calls, this could be imortant.

In Summary

You can use LangChain without LangGraph, LangGraph without LangChain, or both together! It's also completely possible to explore using LangGraph's graph based orchestration with other Agentic AI frameworks like MSFT's AutoGen by making the AutoGen Agents their own nodes in the graph. Safe to say there are a lot of option — and it can feel overwhelming.

So after all this research, when should I use each? Although there are no hard and fast rules, below is my personal option:

Use LangChain Only When:

You need to quickly prototype or develop AI workflows that either involve sequential tasks (such as such as document retrieval, text generation, or summarization) that follow a predefined linear pattern. Or you want to leverage AI agent patterns that can dynamically make decisions, but you don't need granular control over a complex workflow.

Use LangGraph Only When:

Your use case requires non-linear workflows where multiple components interact dynamically such as workflows that depend on conditions, need complex branching logic, error handling, or parallelism. You are willing to build custom implementations for the components that are not abstracted for you like in LangChain.

Using LangChain and LanGraph Together When:

You enjoy the pre-built extracted components of LangChain such as the out of the box RAG capabilities, memory functionality, etc. but also want to manage complex task flows using LangGraph's non-linear orchestration. Using both frameworks together can be a powerful tool for extracting the best abilities from each.

Ultimately, whether you choose LangChain, LangGraph, or a combination of both depends on the specific needs of your project.

Note: The opinions expressed both in this article and paper are solely those of the authors and do not necessarily reflect the views or policies of their respective employers.

Still have questions or think that something needs to be further clarified? Drop me a DM on LinkedIn! I‘m always eager to engage in food for thought and iterate on my work.

References:

Navigating the New Types of LLM Agents and Architectures

The failure of ReAct agents gives way to a new generation of agents — and possibilities

towardsdatascience.com

Home

Build language agents as graphs

langchain-ai.github.io

LangGraph and Research Agents | Pinecone

LangGraph is a graph-based agentic framework that allows us to build more flexible and controllable AI agents. Here…

www.pinecone.io

Chaining the Future: An In-depth Dive into LangChain

LLM chains are a sequence of interconnected components designed to execute tasks in a specific in order to maximize the…

www.comet.com

From Basics to Advanced: Exploring LangGraph

Building single- and multi-agent workflows with human-in-the-loop interactions

towardsdatascience.com