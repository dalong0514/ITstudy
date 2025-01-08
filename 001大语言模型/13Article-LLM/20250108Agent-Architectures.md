## 20250108Agent-Architectures

[Agent architectures](https://langchain-ai.github.io/langgraph/concepts/agentic_concepts/)

Many LLM applications implement a particular control flow of steps before and / or after LLM calls. As an example, RAG performs retrieval of documents relevant to a user question, and passes those documents to an LLM in order to ground the model's response in the provided document context.

许多大语言模型（LLM）应用在调用大语言模型（LLM）前后，会执行特定的步骤流程。例如，RAG 会先检索与用户问题相关的文档，然后将这些文档传递给大语言模型（LLM），让模型的回答基于所提供的文档内容。

Instead of hard-coding a fixed control flow, we sometimes want LLM systems that can pick their own control flow to solve more complex problems! This is one definition of an agent: an agent is a system that uses an LLM to decide the control flow of an application. There are many ways that an LLM can control application:

与采用硬编码的固定控制流不同，我们有时需要大语言模型（LLM）系统能够自主选择控制流程，以便解决更为复杂的问题。这便是智能体的一种定义：智能体是一种利用大语言模型来决定应用程序控制流程的系统。大语言模型可以通过多种方式来控制应用程序：

1 An LLM can route between two potential paths

一个大语言模型可以在两个潜在路径之间进行选择

2 An LLM can decide which of many tools to call

一个大语言模型可以决定选择调用哪个工具

3 An LLM can decide whether the generated answer is sufficient or more work is needed

一个大语言模型可以判断其生成的答案是否充分，或者是否需要进一步完善。

As a result, there are many different types of agent architectures, which give an LLM varying levels of control.

因此，出现了多种多样的智能体架构，这些架构赋予了大语言模型不同程度的自主控制能力。

### Router

路由器

A router allows an LLM to select a single step from a specified set of options. This is an agent architecture that exhibits a relatively limited level of control because the LLM usually focuses on making a single decision and produces a specific output from limited set of pre-defined options. Routers typically employ a few different concepts to achieve this.

路由器允许大语言模型（LLM）从预先设定好的一系列选项中挑选一个执行步骤。这种智能体架构的控制能力相对有限，因为大语言模型通常只专注于做单一决策，并从有限的、预先定义好的选项中生成特定的结果。路由器通常会利用一些不同的方法来实现这一目标。

Structured Output

结构化输出

Structured outputs with LLMs work by providing a specific format or schema that the LLM should follow in its response. This is similar to tool calling, but more general. While tool calling typically involves selecting and using predefined functions, structured outputs can be used for any type of formatted response. Common methods to achieve structured outputs include:

大语言模型（LLM/Large Language Model）的结构化输出，是指让大语言模型在生成回复时遵循预定的格式或模式。这和工具调用类似，但应用范围更广。工具调用通常是选择并使用预先定义好的功能，而结构化输出则可以用于任何类型的格式化回复。以下是一些实现结构化输出的常用方法：

1 Prompt engineering: Instructing the LLM to respond in a specific format via the system prompt.

提示词技巧：通过系统级指令引导大语言模型以特定格式输出。

2 Output parsers: Using post-processing to extract structured data from LLM responses.

输出解析器：使用后续处理步骤从大模型回复中提取结构化数据。

3 Tool calling: Leveraging built-in tool calling capabilities of some LLMs to generate structured outputs.

工具调用：利用某些大语言模型（LLM/Large Language Model）内置的工具调用功能，可以生成结构化的输出结果。

Structured outputs are crucial for routing as they ensure the LLM's decision can be reliably interpreted and acted upon by the system. Learn more about structured outputs in this how-to guide.

结构化输出对于信息传递至关重要，因为它能确保系统可以准确理解并执行大语言模型的决策。想深入了解结构化输出？请参考这篇操作指南。

[How to return structured data from a model | 🦜️🔗 LangChain](https://python.langchain.com/docs/how_to/structured_output/)

### Tool calling agent

工具调用的 AI 智能体

While a router allows an LLM to make a single decision, more complex agent architectures expand the LLM's control in two key ways:

虽然像路由器这样的工具可以让大语言模型只做一个简单的决定，但更复杂的 AI 智能体架构可以通过两种关键方式，让大语言模型拥有更强的控制能力：

1 Multi-step decision making: The LLM can make a series of decisions, one after another, instead of just one.

多步决策：大语言模型可以进行一系列连续的决策，而不是仅仅做出一个决策。

2 Tool access: The LLM can choose from and use a variety of tools to accomplish tasks.

工具使用：大语言模型可以选择并使用各种工具来完成任务。

ReAct is a popular general purpose agent architecture that combines these expansions, integrating three core concepts.

ReAct 是一种流行的通用 AI 智能体架构，它融合了多种扩展功能，并整合了以下三个核心概念。

1 Tool calling: Allowing the LLM to select and use various tools as needed.

工具调用：它允许大语言模型根据需要选择并使用各种工具。

2 Memory: Enabling the agent to retain and use information from previous steps.

记忆：让 AI 智能体能够记住并利用之前步骤的信息。

3 Planning: Empowering the LLM to create and follow multi-step plans to achieve goals.

规划：赋予大语言模型制定并执行多步骤计划以达成目标的能力。

This architecture allows for more complex and flexible agent behaviors, going beyond simple routing to enable dynamic problem-solving with multiple steps. You can use it with create_react_agent.

这种架构使得 AI 智能体能够展现更复杂和灵活的行为，它不再局限于简单的任务分配（路由），而是能够进行多步骤的动态问题解决。你可以使用 `create_react_agent` 来构建这种智能体。

Tool calling

工具调用

Tools are useful whenever you want an agent to interact with external systems. External systems (e.g., APIs) often require a particular input schema or payload, rather than natural language. When we bind an API, for example, as a tool, we give the model awareness of the required input schema. The model will choose to call a tool based upon the natural language input from the user and it will return an output that adheres to the tool's required schema.

当需要 AI 智能体与外部系统交互时，工具就显得非常有用。外部系统，例如应用程序编程接口（API），通常需要特定的输入格式或数据负载，而不是自然语言。例如，当我们将一个 API 作为工具集成时，我们会让模型了解所需的输入格式。模型会根据用户的自然语言输入，选择调用合适的工具，并返回符合该工具要求的格式化输出。

Many LLM providers support tool calling and tool calling interface in LangChain is simple: you can simply pass any Python function into ChatModel.bind_tools(function).

许多大语言模型（LLM）的服务都支持工具调用，在 LangChain 中使用工具调用功能也很简单：你只需要将任何 Python 函数传递给 ChatModel.bind_tools（function）即可。

Memory

记忆

Memory is crucial for agents, enabling them to retain and utilize information across multiple steps of problem-solving. It operates on different scales:

记忆对于 AI 智能体（AI Agent）至关重要，使它们能够在解决问题的过程中保留和利用信息。它有不同的运作方式：

1 Short-term memory: Allows the agent to access information acquired during earlier steps in a sequence.

短期记忆：允许 AI 智能体访问在流程中之前的步骤中获取的信息。

2 Long-term memory: Enables the agent to recall information from previous interactions, such as past messages in a conversation.

长期记忆：使 AI 智能体能够回忆起之前交互的信息，例如对话中过去的消息。

LangGraph provides full control over memory implementation:

LangGraph 提供了对记忆功能实现的完全控制：

1 State: User-defined schema specifying the exact structure of memory to retain.

状态：用户自定义的结构模式，用于明确指定需要保留的内存信息。

2 Checkpointers: Mechanism to store state at every step across different interactions.

检查点：一种机制，用于在每次交互的不同步骤中存储状态。

This flexible approach allows you to tailor the memory system to your specific agent architecture needs. For a practical guide on adding memory to your graph, see this tutorial.

这种灵活的方式，让你可以根据自己特定的 AI 智能体（AI Agent）架构需求，来定制内存系统。关于如何向你的图结构中添加内存的实用指南，请参考本教程。

[How to add thread-level persistence to your graph](https://langchain-ai.github.io/langgraph/how-tos/persistence/)

Effective memory management enhances an agent's ability to maintain context, learn from past experiences, and make more informed decisions over time.

有效的记忆管理提升了 AI 智能体（AI Agent）保持上下文、从过往经验中学习以及随着时间进展做出更明智决策的能力。

Planning

规划

In the ReAct architecture, an LLM is called repeatedly in a while-loop. At each step the agent decides which tools to call, and what the inputs to those tools should be. Those tools are then executed, and the outputs are fed back into the LLM as observations. The while-loop terminates when the agent decides it has enough information to solve the user request and it is not worth calling any more tools.

在 ReAct 架构中，大语言模型（LLM）会在一个 while 循环中被反复调用。在循环的每一步，AI 智能体都会决定要调用哪些工具，以及这些工具需要哪些输入。然后，这些工具会被执行，它们的输出结果会作为观察信息反馈给大语言模型（LLM）。当 AI 智能体判断它已经掌握足够的信息来解决用户请求，并且继续调用工具的收益不大时，这个 while 循环就会结束。

ReAct implementation

ReAct 的实现

There are several differences between this paper and the pre-built create_react_agent implementation:

这篇论文所描述的 ReAct 实现，与预先构建好的 `create_react_agent` 实现之间存在一些差异：

2023012ReAct: Synergizing Reasoning and Acting in Language Models

[[2210.03629] ReAct: Synergizing Reasoning and Acting in Language Models](https://arxiv.org/abs/2210.03629)

First, we use tool-calling to have LLMs call tools, whereas the paper used prompting + parsing of raw output. This is because tool calling did not exist when the paper was written, but is generally better and more reliable.

首先，我们使用工具调用让大语言模型（LLM）调用工具，而论文中采用的是提示方法加上对原始输出的解析。之所以这样做，是因为在论文撰写时工具调用技术尚未出现，但通常来说，工具调用方法更好、更可靠。

Second, we use messages to prompt the LLM, whereas the paper used string formatting. This is because at the time of writing, LLMs didn't even expose a message-based interface, whereas now that's the only interface they expose.

其次，我们通过消息来引导大语言模型，而论文中则采用的是字符串格式化。这主要是因为在撰写本文档时，当时的大语言模型甚至还没有提供基于消息的接口，而现在，消息接口已成为它们唯一对外提供的接口。

Third, the paper required all inputs to the tools to be a single string. This was largely due to LLMs not being super capable at the time, and only really being able to generate a single input. Our implementation allows for using tools that require multiple inputs.

第三，那篇论文要求所有工具的输入都必须是单独的一个字符串。这主要是因为当时的大语言模型（LLM）能力还比较弱，一次只能生成一个输入。而我们的实现允许使用那些需要多个输入的工具。

Fourth, the paper only looks at calling a single tool at the time, largely due to limitations in LLMs performance at the time. Our implementation allows for calling multiple tools at a time.

第四，这篇论文只研究了每次调用一个工具的情况，这主要是因为当时大语言模型（LLM/Large Language Model）的性能还不够强。而我们的方法允许一次调用多个工具。

Finally, the paper asked the LLM to explicitly generate a "Thought" step before deciding which tools to call. This is the "Reasoning" part of "ReAct". Our implementation does not do this by default, largely because LLMs have gotten much better and that is not as necessary. Of course, if you wish to prompt it do so, you certainly can.

最后，该论文要求大语言模型在决定调用哪些工具之前，先明确生成一个「思考」步骤。这是「ReAct 方法」中的「推理」部分。我们的实现默认不进行此操作，主要是因为大语言模型的能力已大幅提升，这个步骤已不再是必需的。当然，如果你希望通过提示来让它执行此操作，也是可以的。

### Custom agent architectures

自定义智能体架构

While routers and tool-calling agents (like ReAct) are common, customizing agent architectures often leads to better performance for specific tasks. LangGraph offers several powerful features for building tailored agent systems:

虽然路由器和具备工具调用能力的智能体（如 ReAct）很常见，但自定义智能体架构通常会为特定任务带来更好的性能。LangGraph 提供了几个强大的功能来构建量身定制的智能体系统：

Human-in-the-loop

人机协作

Human involvement can significantly enhance agent reliability, especially for sensitive tasks. This can involve:

人的参与可以显著提高 AI 智能体（AI Agent）的可靠性，尤其是在执行敏感任务时。这可能包括：

1 Approving specific actions

批准执行特定操作

2 Providing feedback to update the agent's state

提供反馈以更新 AI 智能体的状态

3 Offering guidance in complex decision-making processes

在复杂决策过程中提供指导

Human-in-the-loop patterns are crucial when full automation isn't feasible or desirable. Learn more in our human-in-the-loop guide.

当完全自动化不可行或不理想时，人机协同模式至关重要。在我们的人机协同指南中了解更多信息。

[Human-in-the-loop](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/)

Parallelization

Parallel processing is vital for efficient multi-agent systems and complex tasks. LangGraph supports parallelization through its Send API, enabling:

并行化并行处理对于高效的多个 AI 智能体协同工作的系统和复杂任务至关重要。LangGraph 通过其 Send API 支持并行化，可以实现：

1 Concurrent processing of multiple states

同时处理多种状态

2 Implementation of map-reduce-like operations

实现类似于 map-reduce 的操作

3 Efficient handling of independent subtasks

高效处理独立子任务

For practical implementation, see our map-reduce tutorial.

关于实际应用，请参阅我们的 map-reduce 教程。

[How to create map-reduce branches for parallel execution](https://langchain-ai.github.io/langgraph/how-tos/map-reduce/)

Subgraphs

子结构

Subgraphs are essential for managing complex agent architectures, particularly in multi-agent systems. They allow:

子结构对于管理复杂的 AI 智能体（AI Agent）架构至关重要，尤其是在多智能体系统中。它们可以实现：

1 Isolated state management for individual agents

为每个智能体单独管理状态

2 Hierarchical organization of agent teams

智能体团队的分层结构

3 Controlled communication between agents and the main system

智能体与主系统之间的受控通信

Subgraphs communicate with the parent graph through overlapping keys in the state schema. This enables flexible, modular agent design. For implementation details, refer to our subgraph how-to guide.

子图通过在状态模式（state schema）中使用共享的键（overlapping keys）与父图进行通信。这种机制实现了灵活且模块化的智能体设计。关于具体实现细节，请参考我们的子图使用指南。

[How to add and use subgraphs](https://langchain-ai.github.io/langgraph/how-tos/subgraph/)

Reflection

Reflection mechanisms can significantly improve agent reliability by:

反思机制可以通过以下方式显著提高 AI 智能体的可信度：

1 Evaluating task completion and correctness

衡量任务的完成情况和准确度

2 Providing feedback for iterative improvement

提供反馈以促进持续改进

Enabling self-correction and learning

While often LLM-based, reflection can also use deterministic methods. For instance, in coding tasks, compilation errors can serve as feedback. This approach is demonstrated in this video using LangGraph for self-corrective code generation.

启用自我纠正和学习反思过程虽然通常基于大语言模型（LLM），但也可以采用确定性方法。例如，在编程任务中，编译错误就可以作为反馈。这个方法在一段使用 LangGraph 实现自我纠正代码生成的视频中得到了展示。

By leveraging these features, LangGraph enables the creation of sophisticated, task-specific agent architectures that can handle complex workflows, collaborate effectively, and continuously improve their performance.

借助这些功能，LangGraph 可以构建精巧的、针对特定任务的 AI 智能体架构。这些架构不仅能应对复杂的工作流程，还能高效协同工作，并持续提升自身的表现。

## 原文

Agent-architectures
Many LLM applications implement a particular control flow of steps before and / or after LLM calls. As an example, RAG performs retrieval of documents relevant to a user question, and passes those documents to an LLM in order to ground the model's response in the provided document context.

Instead of hard-coding a fixed control flow, we sometimes want LLM systems that can pick their own control flow to solve more complex problems! This is one definition of an agent: an agent is a system that uses an LLM to decide the control flow of an application. There are many ways that an LLM can control application:

An LLM can route between two potential paths
An LLM can decide which of many tools to call
An LLM can decide whether the generated answer is sufficient or more work is needed
As a result, there are many different types of agent architectures, which give an LLM varying levels of control.

Agent Types

Router
A router allows an LLM to select a single step from a specified set of options. This is an agent architecture that exhibits a relatively limited level of control because the LLM usually focuses on making a single decision and produces a specific output from limited set of pre-defined options. Routers typically employ a few different concepts to achieve this.

Structured Output
Structured outputs with LLMs work by providing a specific format or schema that the LLM should follow in its response. This is similar to tool calling, but more general. While tool calling typically involves selecting and using predefined functions, structured outputs can be used for any type of formatted response. Common methods to achieve structured outputs include:

Prompt engineering: Instructing the LLM to respond in a specific format via the system prompt.
Output parsers: Using post-processing to extract structured data from LLM responses.
Tool calling: Leveraging built-in tool calling capabilities of some LLMs to generate structured outputs.
Structured outputs are crucial for routing as they ensure the LLM's decision can be reliably interpreted and acted upon by the system. Learn more about structured outputs in this how-to guide.

Tool calling agent
While a router allows an LLM to make a single decision, more complex agent architectures expand the LLM's control in two key ways:

Multi-step decision making: The LLM can make a series of decisions, one after another, instead of just one.
Tool access: The LLM can choose from and use a variety of tools to accomplish tasks.
ReAct is a popular general purpose agent architecture that combines these expansions, integrating three core concepts.

Tool calling: Allowing the LLM to select and use various tools as needed.
Memory: Enabling the agent to retain and use information from previous steps.
Planning: Empowering the LLM to create and follow multi-step plans to achieve goals.
This architecture allows for more complex and flexible agent behaviors, going beyond simple routing to enable dynamic problem-solving with multiple steps. You can use it with create_react_agent.

Tool calling
Tools are useful whenever you want an agent to interact with external systems. External systems (e.g., APIs) often require a particular input schema or payload, rather than natural language. When we bind an API, for example, as a tool, we give the model awareness of the required input schema. The model will choose to call a tool based upon the natural language input from the user and it will return an output that adheres to the tool's required schema.

Many LLM providers support tool calling and tool calling interface in LangChain is simple: you can simply pass any Python function into ChatModel.bind_tools(function).

Tools

Memory
Memory is crucial for agents, enabling them to retain and utilize information across multiple steps of problem-solving. It operates on different scales:

Short-term memory: Allows the agent to access information acquired during earlier steps in a sequence.
Long-term memory: Enables the agent to recall information from previous interactions, such as past messages in a conversation.
LangGraph provides full control over memory implementation:

State: User-defined schema specifying the exact structure of memory to retain.
Checkpointers: Mechanism to store state at every step across different interactions.
This flexible approach allows you to tailor the memory system to your specific agent architecture needs. For a practical guide on adding memory to your graph, see this tutorial.

Effective memory management enhances an agent's ability to maintain context, learn from past experiences, and make more informed decisions over time.

Planning
In the ReAct architecture, an LLM is called repeatedly in a while-loop. At each step the agent decides which tools to call, and what the inputs to those tools should be. Those tools are then executed, and the outputs are fed back into the LLM as observations. The while-loop terminates when the agent decides it has enough information to solve the user request and it is not worth calling any more tools.

ReAct implementation
There are several differences between this paper and the pre-built create_react_agent implementation:

First, we use tool-calling to have LLMs call tools, whereas the paper used prompting + parsing of raw output. This is because tool calling did not exist when the paper was written, but is generally better and more reliable.
Second, we use messages to prompt the LLM, whereas the paper used string formatting. This is because at the time of writing, LLMs didn't even expose a message-based interface, whereas now that's the only interface they expose.
Third, the paper required all inputs to the tools to be a single string. This was largely due to LLMs not being super capable at the time, and only really being able to generate a single input. Our implementation allows for using tools that require multiple inputs.
Fourth, the paper only looks at calling a single tool at the time, largely due to limitations in LLMs performance at the time. Our implementation allows for calling multiple tools at a time.
Finally, the paper asked the LLM to explicitly generate a "Thought" step before deciding which tools to call. This is the "Reasoning" part of "ReAct". Our implementation does not do this by default, largely because LLMs have gotten much better and that is not as necessary. Of course, if you wish to prompt it do so, you certainly can.
Custom agent architectures
While routers and tool-calling agents (like ReAct) are common, customizing agent architectures often leads to better performance for specific tasks. LangGraph offers several powerful features for building tailored agent systems:

Human-in-the-loop
Human involvement can significantly enhance agent reliability, especially for sensitive tasks. This can involve:

Approving specific actions
Providing feedback to update the agent's state
Offering guidance in complex decision-making processes
Human-in-the-loop patterns are crucial when full automation isn't feasible or desirable. Learn more in our human-in-the-loop guide.

Parallelization
Parallel processing is vital for efficient multi-agent systems and complex tasks. LangGraph supports parallelization through its Send API, enabling:

Concurrent processing of multiple states
Implementation of map-reduce-like operations
Efficient handling of independent subtasks
For practical implementation, see our map-reduce tutorial.

Subgraphs
Subgraphs are essential for managing complex agent architectures, particularly in multi-agent systems. They allow:

Isolated state management for individual agents
Hierarchical organization of agent teams
Controlled communication between agents and the main system
Subgraphs communicate with the parent graph through overlapping keys in the state schema. This enables flexible, modular agent design. For implementation details, refer to our subgraph how-to guide.

Reflection
Reflection mechanisms can significantly improve agent reliability by:

Evaluating task completion and correctness
Providing feedback for iterative improvement
Enabling self-correction and learning
While often LLM-based, reflection can also use deterministic methods. For instance, in coding tasks, compilation errors can serve as feedback. This approach is demonstrated in this video using LangGraph for self-corrective code generation.

By leveraging these features, LangGraph enables the creation of sophisticated, task-specific agent architectures that can handle complex workflows, collaborate effectively, and continuously improve their performance.