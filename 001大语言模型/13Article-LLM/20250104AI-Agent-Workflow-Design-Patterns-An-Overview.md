## 20250104AI-Agent-Workflow-Design-Patterns-An-Overview

[AI Agent Workflow Design Patterns — An Overview | by Craig Li, Ph.D | Binome | Dec, 2024 | Medium](https://medium.com/binome/ai-agent-workflow-design-patterns-an-overview-cf9e1f609696)

AI Agent Workflow Design Patterns — An Overview

Craig Li, Ph.D

Published in Binome

Dec 11, 2024

In our previous post, we introduced AI Agent Design Patterns. Now, we are in the process of implementing an agent framework based on that design. At the same time, we are actively researching various workflow design patterns. Special thanks to Lychee Zhong for compiling these patterns with clear and informative diagrams.

在我们之前的文章中，我们介绍了 AI 智能体（AI Agent）设计模式。现在，我们正在基于该设计实现一个 AI 智能体框架。同时，我们也在积极研究各种工作流程设计模式。特别感谢 Lychee Zhong 整理并绘制了这些模式的清晰易懂的图表。

Before diving deeper, let's revisit the concept of an LLM-based AI agent. As described by the nvidia blog, LLM-powered agents are systems that utilize a large language model (LLM) to reason through problems, create actionable plans, and execute those plans using a set of tools. Simply put, these agents combine advanced reasoning capabilities, memory, and task execution.

在深入探讨之前，我们先回顾一下基于大语言模型（LLM）的 AI 智能体的概念。正如英伟达（nvidia）博客所述，大语言模型驱动的智能体是一种系统，它利用大语言模型（LLM）来分析问题，制定可执行的计划，并使用一系列工具来实现这些计划。简单来说，这些智能体结合了高级的推理能力、记忆功能和任务执行能力。

The evolution of LLM-based AI agent workflow design patterns began in late 2022 and continues to evolve and innovate.

基于大语言模型（LLM）的 AI 智能体工作流程设计模式，其发展演变始于 2022 年末，并且至今仍在不断进步和创新。

This paper introduced ReAct Pattern, which published in October 2022. This pattern enhancing the strength of Agents by integrating the use of tools.

本文介绍的 ReAct 模式，发表于 2022 年 10 月。该模式通过集成工具的使用，显著提升了 AI 智能体的能力。

This is one of the earliest papers on LLM Agents. Although it may seem basic by today's standards, at the time, ChatGPT hadn't been released yet, and the idea of teaching LLMs to use tools was groundbreaking.

这是关于大语言模型（LLM/Large Language Model）智能体（AI Agent）的早期论文之一。虽然以现在的眼光来看，这篇论文可能显得有些基础，但在那个时候，ChatGPT 甚至还没有发布，让大语言模型学会使用工具的想法是具有突破性的。

In the following section, we summarize the patterns we've learned and believe will be applicable to real-world business needs.

接下来，我们将总结已经掌握的规律，并认为这些规律可以应用于真实的商业场景。

[Binome Multi-agent Framework Chapter 1 — Key Design Principles for LLM-Based Agents | by Craig Li, Ph.D | Binome | Medium](https://medium.com/binome/designing-llm-based-agents-key-principles-part-1-7e8c6fe3ddaf)

[Introduction to LLM Agents | NVIDIA Technical Blog](https://developer.nvidia.com/blog/introduction-to-llm-agents/)

[Building Your First LLM Agent Application | NVIDIA Technical Blog](https://developer.nvidia.com/blog/building-your-first-llm-agent-application/)

[[2210.03629] ReAct: Synergizing Reasoning and Acting in Language Models](https://arxiv.org/abs/2210.03629)

### Introduction

引言

Currently, there are numerous workflow designs. To summarize them based on their focus, we've categorized the workflow design patterns we've learnt so far into two groups: Reflection-focused and Planning-focused.

目前，工作流程的设计方案多种多样。为了根据其侧重点进行归纳，我们将目前所了解的工作流程设计模式分为两类：一类侧重于反思，另一类侧重于规划。

Reflection-focused

Reflection allows agents to learn from experience, improving adaptability and resilience. These agents emphasize introspection and learning from past experiences. They analyze previous actions and outcomes to refine future behaviour. By evaluating their performance, they identify mistakes and successes, allowing for continuous improvement. This reflective process enables the agent to adapt its strategies over time, leading to more effective problem-solving. [LangChain Blog]

[Reflection Agents](https://blog.langchain.dev/reflection-agents/)

反思让 AI 智能体能够从经验中学习，增强其适应性和韧性。这些 AI 智能体注重自我反省，并从过往的经验中汲取教训。它们会分析之前的行为和结果，从而优化未来的行动。通过评估自身的表现，它们能识别出错误和成功之处，进而实现持续的进步。这种反思过程使得 AI 智能体能够随着时间推移调整策略，最终更有效地解决问题。[LangChain Blog]

Basic Reflection: Reflecting and learning from the steps.

基础反思：对过程进行回顾与学习。

Reflexion: Enhancing the next steps of the Agent through reinforcement learning.

进阶反思：通过强化学习，优化 AI 智能体（AI Agent）的后续决策。

Tree search: TOT + reinforcement learning-based reflection.

树搜索：思维树（Tree of Thoughts，TOT）方法 + 基于强化学习的反馈调整。

Self-Discover: Reasoning within the task.

自我发现：在任务执行过程中进行推理。

[langgraph/docs/docs/tutorials/reflection/reflection.ipynb at main · langchain-ai/langgraph](https://github.com/langchain-ai/langgraph/blob/main/docs/docs/tutorials/reflection/reflection.ipynb)

[langgraph/docs/docs/tutorials/reflexion/reflexion.ipynb at main · langchain-ai/langgraph](https://github.com/langchain-ai/langgraph/blob/main/docs/docs/tutorials/reflexion/reflexion.ipynb)

[langgraph/docs/docs/tutorials/lats/lats.ipynb at main · langchain-ai/langgraph](https://github.com/langchain-ai/langgraph/blob/main/docs/docs/tutorials/lats/lats.ipynb)

[[2402.03620] Self-Discover: Large Language Models Self-Compose Reasoning Structures](https://arxiv.org/abs/2402.03620)

Planning-focused

注重规划

Planning enables agents to approach tasks methodically, increasing efficiency and effectiveness. These agents prioritize the development of structured plans before taking action. They decompose complex tasks into manageable sub-tasks and sequence them logically to achieve specific goals. By formulating detailed plans, these agents can anticipate potential challenges and allocate resources efficiently, resulting in more organized and goal-directed behaviour. [https://arxiv.org/pdf/2402.02716]

规划使 AI 智能体（AI Agent）能够有条理地处理任务，从而提高效率和效果。这些 AI 智能体会优先制定结构化的计划，然后再采取行动。它们将复杂的任务分解为易于管理的子任务，并按照逻辑顺序排列这些子任务，以实现特定目标。通过制定详细的计划，这些 AI 智能体可以预测潜在的挑战并有效地分配资源，从而实现更有组织、目标更明确的行为。[https://arxiv.org/pdf/2402.02716]

Plan & Solve: Plan → Task list → RePlan.

规划与解决：规划 → 任务清单 → 重新规划。

LLM compiler: Plan → Action in parallel → Joint execution.

基于大语言模型（LLM）的执行框架：规划 → 同步执行多个操作 → 协同执行。

REWOO: Plan (including dependencies) → Action (depends on the previous step).

REWOO：先制定计划（包括各项任务之间的依赖关系），然后根据计划执行行动（行动的执行依赖于上一步计划的结果）。

Storm: Search for outline → Search each topic in the outline → Summarize into a long text.

Storm：首先搜索文章的大纲，然后根据大纲搜索每个主题的相关信息，最后将这些信息总结成一篇长篇文章。

When reviewing these design patterns, we see the workflow as an orchestrator. Each node can represent an LLM task, a function call, and other tasks like Retrieval-Augmented Generation (RAG) task, which we typically treat as another type of function call. This concept is one of the main drivers behind developing our own agent. We've designed the workflow as a flexible task orchestrator, allowing developers to create various workflows to tackle different problems.

在研究这些设计模式时，我们把工作流程看作是一个编排器。每个节点可以代表一个大语言模型（LLM/Large Language Model）任务、一个函数调用，以及其他任务，例如检索增强生成（RAG/Retrieval-Augmented Generation）任务，而 RAG 任务我们通常也将其视为一种函数调用。这个概念是我们开发自己的 AI 智能体（AI Agent）的主要驱动力之一。我们将工作流程设计为一个灵活的任务编排器，允许开发人员创建各种工作流程来应对不同的挑战。

In this post, we will explore two specific workflow design patterns: the ReAct pattern and the Plan-Solve pattern. For the remaining patterns, we'll provide a brief summary to explain their motivation and use cases.

本文将探讨两种特定的工作流程设计模式：ReAct 模式和 Plan-Solve 模式。对于其他模式，我们将提供一个简短的总结来解释它们的目的和应用场景。

[langgraph/docs/docs/tutorials/plan-and-execute/plan-and-execute.ipynb at main · langchain-ai/langgraph](https://github.com/langchain-ai/langgraph/blob/main/docs/docs/tutorials/plan-and-execute/plan-and-execute.ipynb)

[langgraph/docs/docs/tutorials/llm-compiler/LLMCompiler.ipynb at main · langchain-ai/langgraph](https://github.com/langchain-ai/langgraph/blob/main/docs/docs/tutorials/llm-compiler/LLMCompiler.ipynb)

[langgraph/docs/docs/tutorials/rewoo/rewoo.ipynb at main · langchain-ai/langgraph](https://github.com/langchain-ai/langgraph/blob/main/docs/docs/tutorials/rewoo/rewoo.ipynb)

[langgraph/docs/docs/tutorials/storm/storm.ipynb at main · langchain-ai/langgraph](https://github.com/langchain-ai/langgraph/blob/main/docs/docs/tutorials/storm/storm.ipynb)

### ReAct Pattern

The ReAct principle is straightforward and reflects a core aspect of human intelligence: "actions guided by verbal reasoning." After each action, there's an internal "Observation" or self-reflection: "What did I just do? Have I achieved my goal?" This enables the agent to retain short-term memory. Before ReAct, reasoning and action were treated as separate processes.

ReAct 的核心思想非常直接，它体现了人类智能的一个关键方面：「行动由语言推理来引导」。每次行动之后，都会进行一次内部的「观察」或自我反思：「我刚才做了什么？是否达成了目标？」这使得 AI 智能体能够记住短期的信息。在 ReAct 模式出现之前，推理和行动通常被看作是两个独立的过程。

For example, imagine you ask someone to find a pen on your desk, and you give step-by-step instructions (similar to the Chain-of-Thought prompting strategy):

举个例子，假设你让别人在你的桌子上找一支笔，你会给出逐步的指示（类似于思维链（Chain-of-Thought）提示方法）：

First, check the pen holder.

首先，看看笔筒里有没有。

Then, look in the drawer.

然后，看看抽屉里。

Lastly, check behind the computer monitor.

最后，检查电脑显示器后边。

Without ReAct, regardless of where the pen is found, the person would follow all the steps, checking each location (Action).

如果没有 ReAct，无论在哪里找到笔，这个人都会按照既定的所有步骤，逐一检查每个位置（行动）。

With ReAct, the process would look like this:

有了 ReAct，过程则会如下所示：

Action 1: First, check the pen holder;

行动 1：首先，检查笔筒；

Observation 1: The pen is not in the pen holder, so move to the next step;

观察 1：笔不在笔筒里，因此进行下一步；

Action 2: Then, check the drawer;

动作 2：接下来，检查抽屉；

Observation 2: The pen is in the drawer;

观察 2：发现笔在抽屉里；

Action 3: Take the pen from the drawer.

第三步：从抽屉里拿出笔。

ReAct Implementation

ReAct 方法的实现

After reviewing several open-source codes, let's focus on the simplest one for analysis. As you explore it, you'll notice that, at its essence, all Agent design patterns revolve around translating human thinking and management strategies into structured prompts. These prompts guide the large model to plan, invoke tools for execution, and continuously refine its approach through iteration.

在研究了一些开源代码之后，我们不妨先从最简单的入手进行分析。你会发现，所有 AI 智能体（AI Agent）的设计模式，其本质都是将人类的思考和管理策略转化为结构化的提示（prompts）。这些提示引导大语言模型（Large Language Model）(LLM）进行规划、调用工具执行，并通过迭代不断完善其方法。

The code logic is outlined in the diagram below (take a close look):

代码逻辑如下面的图所示（请仔细查看）：

1 Generate the prompt: First, the predefined ReAct prompt template (formatted as Question -> Thought -> Action -> Observation) is merged with the user's question. The resulting prompt looks like this.

生成提示词：首先，预定义的 ReAct 提示模板（问题 -> 思考 -> 行动 -> 观察）与用户问题组合。最终生成的提示词如下所示。

2 Call the large model to generate Thought + Action: Next, send the few-shot prompt to the large model. If sent as is, the model will generate Thought, Action, and Observation responses. However, since the Action isn't fully defined, we prevent the model from generating the Observation by using Stop.Observation, ensuring it stops after Thought and Action.

让大模型生成「思考 + 行动」：接下来，将少样本提示（Few-shot prompt）发送给大模型。如果直接发送，模型将生成「思考」、「行动」和「观察」响应。但是，由于「行动」不够明确，我们通过使用 Stop.Observation 来避免模型生成「观察」，确保模型在「思考」和「行动」之后停止。

3 Calling External Tools: Once the Action is obtained, the model can call external tools. First, check if the Action is "Finish." If not, the model converts the Action into an API-compatible format using its function-calling feature. This fine-tunes the model for language-to-API conversion, though not all large models support function calling.

调用外部工具：在获得行动（Action）之后，模型就可以调用外部工具。首先，检查行动是否是「完成」（Finish）。如果不是，模型使用其函数调用功能将行动转换为与 API 兼容的格式。这会微调模型，使其能够进行语言到 API 的转换，但并非所有大型模型都支持函数调用。

4 Generating Observation: After the API interface returns the result, it is converted into natural language output to generate the Observation. Then the Observation, along with the previously generated Thought and Action, is input back into the model, repeating steps 2 and 3 until the Action is "Finish."

观察的生成：在 API 接口返回结果后，将其转化为自然语言输出，形成观察（Observation）。随后，将观察（Observation）与之前生成的思考（Thought）和行动（Action）一起输入回模型，重复步骤 2 和 3，直到行动（Action）为「完成」为止。

5 Final Output: The final Observation is converted into natural language and output to the user.

最终的观察结果会被转换成自然语言，并呈现给用户。

From this, we can see that implementing an Agent in a specific scenario requires customizing two key components:

因此，我们可以发现，在特定场景下部署智能体需要定制两个关键部分：

1 The few-shot examples in the prompt template

在提示模板中使用的少样本示例

2 The definition of external tools for function calling

用于函数调用的外部工具的定义

The few-shot examples essentially mirror structured human thinking patterns. Reviewing prompt templates for different design patterns is a great way to understand Agent design. Once you grasp this approach, it can be applied to other design patterns similarly.

少样本示例，实际上体现了人类结构化的思维方式。研究不同设计模式的提示词模板，是理解 AI 智能体（AI Agent）设计的一个好方法。一旦你理解了这种方法，就可以将其应用到其他类似的设计模式中。

### Plan and Solve Pattern

As the name suggests, this design pattern involves planning first and then executing. If ReAct is more suitable for tasks like "getting pen from the the desk" then Plan & Solve is better suited for tasks like "making a cup of flat white." You need to plan, and the plan might change during the process (for example, if you open the fridge and find no milk, you would add "buy milk" as a new step in the plan).

计划-解决模式顾名思义，这种设计模式是先计划后执行。如果 ReAct 更适合「从桌子上取笔」这类任务，那么计划-解决模式则更适合「制作一杯馥芮白」这类任务。你需要先制定计划，并且计划在执行过程中可能会发生变化。例如，如果打开冰箱发现没有牛奶，你会在计划中增加「购买牛奶」这一步骤。

Regarding the prompt template, the paper's title makes it clear: Plan-and-Solve Prompting: Improving Zero-Shot Chain-of-Thought Reasoning by Large Language Models. In short, it's about improving zero-shot capabilities. The following image shows some PS-Plan and Solve prompts provided in the author's code.

[[2305.04091] Plan-and-Solve Prompting: Improving Zero-Shot Chain-of-Thought Reasoning by Large Language Models](https://arxiv.org/abs/2305.04091)

关于提示模板，正如论文标题所言：《先规划再解决提示：通过大语言模型改进零样本思维链推理（Chain-of-Thought Reasoning)》。简而言之，本文旨在提升零样本能力。下图展示了作者在代码中提供的一些规划-解决（PS）提示示例。

Its architecture is composed as follows:

这个链接的架构如下：

1 Planner: Responsible for enabling the LLM to generate a multi-step plan to complete a large task. In the code, there are both a Planner and a Replanner. The Planner is responsible for generating the plan initially; the Replanner, on the other hand, comes into play after each individual task is completed, adjusting the plan based on the current progress. Therefore, the Replanner's prompt includes not only the zero-shot input but also the goal, the original plan, and the status of completed steps.

规划器： 它的作用是让大语言模型（LLM）生成一个多步骤的计划，以完成大型任务。在代码中，我们既有规划器（Planner），也有重规划器（Replanner）。规划器负责最初生成计划；而重规划器则在每个任务完成后介入，根据当前进度调整计划。因此，重规划器的提示信息，不仅包含零样本（Zero-shot）输入，还包括目标、原始计划以及已完成步骤的状态。

2 Executor: Receives the user's query and the steps from the plan, then calls one or more tools to accomplish the task.

执行模块：接收用户的查询和计划中的步骤，然后调用工具来完成任务。

### Other Workflow Design Patterns

其他工作流程设计模式

Here we give the brief introduction of other design patterns listed above.

接下来，我们简要介绍一下前面提到的一些其他设计模式。

Reason without Observation (REWOO)

无观察推理（Reason without Observation，REWOO)

REWOO (Reason without Observation) is a variation on the observation process seen in ReAct. While ReAct follows the structure: Thought → Action → Observation, REWOO simplifies this by removing the explicit observation step. Instead, it implicitly embeds observation into the next execution unit. In practice, the next executor automatically observes the outcome of the previous step, streamlining the process.

REWOO（无须观察的推理）是对 ReAct 框架中观察环节的一种改进。ReAct 的流程是「思考 → 行动 → 观察」，而 REWOO 则去掉了显式的观察步骤，简化了流程。REWOO 将观察隐含在接下来的执行步骤中，也就是说，下一步的执行单元会自动获取上一步的执行结果。这样一来，整个流程就更加流畅。

LLMCompiler

In computer science, a compiler refers to the orchestration of tasks to optimize computational efficiency. The concept behind An LLM Compiler for Parallel Function Calling, as outlined in the original paper, is simple yet effective: it aims to enhance efficiency by enabling parallel function calls. For instance, if a user asks, "What's the difference between AWS Glue and MWAA?", the compiler would search for the AWS services definition simultaneously and combine the results, rather than handling each query sequentially.

LLM 编译器在计算机科学中，编译器指的是为了优化计算效率而对任务进行的组织安排。正如论文中提出的，支持并行函数调用的 LLM 编译器背后的概念简单却很有效：它通过并行调用函数来提高效率。例如，如果用户问「AWS Glue 和 MWAA 之间有什么区别？」，编译器会同时搜索 AWS 服务的定义，并将结果组合起来，而不是按顺序处理每个查询。

Basic Reflection

Basic Reflection can be compared to a feedback loop between a student (the Generator) and a teacher (the Reflector). The student completes an assignment, the teacher provides feedback, and the student revises their work based on this feedback, repeating the cycle until the task is satisfactorily completed.

基本反思可以被看作是学生（Generator）和老师（Reflector）之间的一个反馈循环。学生完成一项作业，老师提供反馈意见，然后学生根据这些反馈修改作业，这个过程会不断重复，直到任务达到令人满意的程度。

Reflexion

Reflexion builds on Basic Reflection, incorporating principles of reinforcement learning. Described in the paper Reflexion: Language Agents with Verbal Reinforcement Learning, this approach goes beyond simple feedback. It evaluates the response using external data and forces the model to address any redundancies or omissions, making the reflective process more robust and the output more refined.

Reflexion 在基础反思的基础上，融入了强化学习的原理。正如论文《Reflexion：带有口头强化学习的语言智能体》中所述，这种方法不仅仅是简单的反馈。它利用外部数据评估回应，并促使模型修正任何冗余或遗漏之处，从而使反思过程更加可靠，输出结果也更加精细。

Language Agent Tree Search (LATS)

语言智能体树搜索（LATS)

LATS is detailed in the paper Language Agent Tree Search Unifies Reasoning, Acting, and Planning in Language Models. It combines several techniques, including Tree Search, ReAct, and Plan & Solve. LATS uses tree search to assess outcomes (drawing from reinforcement learning), while also integrating reflection to achieve optimal results. In essence, LATS can be represented by the following formula:

LATS 在论文《语言模型中推理、行动与规划的统一：语言智能体树搜索》中进行了详细阐述。它融合了多种技术，包括树搜索、ReAct 以及 Plan & Solve。LATS 利用树搜索来评估结果（借鉴了强化学习的思想），同时还融入了反思机制，以期获得最优表现。总而言之，LATS 可以用以下公式来表示：

LATS = Tree Search + ReAct + Plan & Solve + Reflection + Reinforcement Learning.

LATS = 树搜索 + ReAct + 规划与解决 + 反思 + 强化学习。

In terms of prompt design, the difference between LATS and earlier methods such as Reflection, Plan & Solve, and ReAct is minimal. The key addition is the tree search evaluation step and the return of those evaluated results within the task context. Architecturally, LATS involves multiple rounds of Basic Reflection, with several Generators and Reflectors working collaboratively.

在提示词设计方面，LATS 与早期的反思、规划与解决和 ReAct 等方法相比，差异很小。其关键增加在于树搜索评估步骤，以及在任务上下文中返回的评估结果。从架构上看，LATS 包含多轮基础反思，由多个生成器和反思器协同运作。

Self-Discovery

自我发现

The core of Self-Discovery is to allow the large model to reflect at a more granular level. While Plan & Solve focuses on whether a task requires additional steps or adjustments, Self-Discovery goes further, encouraging reflection on the task itself. This involves evaluating each component of the task and the execution of those components.

自我发现的核心是让大模型在更细致的层面上进行反思。虽然「计划与解决」侧重于任务是否需要额外的步骤或调整，但自我发现更深入一步，鼓励对任务本身进行反思。这包括评估任务的每个环节以及这些环节的执行情况。

Storm

Storm, outlined in the paper Assisting in Writing Wikipedia-like Articles From Scratch with Large Language Models, introduces a workflow for generating comprehensive articles from scratch, similar to a Wikipedia entry. The agent first uses external tools to search for information and generate an outline. Then, it produces content for each section based on the outline, making the process structured and efficient.

Storm，在论文《Assisting in Writing Wikipedia-like Articles From Scratch with Large Language Models》中介绍，提出了一种从零开始生成类似维基百科条目的综合文章的工作流程。AI 智能体首先使用外部工具搜索信息并生成文章大纲。然后，它根据大纲为每个章节生成内容，使得整个过程结构化且高效。

### Conclusion

In this post, we explore various AI agent workflow design patterns, we categorize the patterns into Reflection-focused and Planning-focused, showcasing examples like the ReAct and Plan-Solve patterns. For developing purposes, these workflow patterns emphasize that workflows act as orchestrators for tasks within an agent. Each node in the workflow represents actions such as LLM tasks, function calls, or Retrieval-Augmented Generation (RAG). This structure enables the agent to plan, execute tasks, and iterate, simulating human reasoning.

结论在本文中，我们研究了多种 AI 智能体的工作流程设计模式。我们将这些模式归纳为以反思为中心和以计划为中心两大类，并展示了 ReAct 和 Plan-Solve 等模式的实例。从开发的角度来看，这些工作流程模式强调，工作流程是智能体内部任务的组织者。工作流程中的每个节点都代表一个操作，例如大语言模型任务、函数调用或检索增强生成（RAG）。这种结构使得智能体能够进行计划、执行任务和迭代，从而模拟人类的推理过程。

We are currently developing our own agent based on these principles, utilizing workflows as flexible task orchestrators to handle different problems. More details on our agent implementation will be covered in the next post.

我们目前正在基于这些原则开发我们自己的 AI 智能体（AI Agent），利用工作流作为灵活的任务调度器来处理不同的问题。关于我们 AI 智能体实现的更多细节将在下一篇文章中介绍。

## 原文

In our previous post, we introduced AI Agent Design Patterns. Now, we are in the process of implementing an agent framework based on that design. At the same time, we are actively researching various workflow design patterns. Special thanks to Lychee Zhong for compiling these patterns with clear and informative diagrams.

Before diving deeper, let's revisit the concept of an LLM-based AI agent. As described by the nvidia blog, LLM-powered agents are systems that utilize a large language model (LLM) to reason through problems, create actionable plans, and execute those plans using a set of tools. Simply put, these agents combine advanced reasoning capabilities, memory, and task execution.

The evolution of LLM-based AI agent workflow design patterns began in late 2022 and continues to evolve and innovate.

This paper introduced ReAct Pattern, which published in October 2022. This pattern enhancing the strength of Agents by integrating the use of tools.

This is one of the earliest papers on LLM Agents. Although it may seem basic by today's standards, at the time, ChatGPT hadn't been released yet, and the idea of teaching LLMs to use tools was groundbreaking.

In the following section, we summarize the patterns we've learned and believe will be applicable to real-world business needs.

Introduction

Currently, there are numerous workflow designs. To summarize them based on their focus, we've categorized the workflow design patterns we've learnt so far into two groups: Reflection-focused and Planning-focused.

Reflection-focused

Reflection allows agents to learn from experience, improving adaptability and resilience. These agents emphasize introspection and learning from past experiences. They analyze previous actions and outcomes to refine future behaviour. By evaluating their performance, they identify mistakes and successes, allowing for continuous improvement. This reflective process enables the agent to adapt its strategies over time, leading to more effective problem-solving. [LangChain Blog]

Basic Reflection: Reflecting and learning from the steps.

Reflexion: Enhancing the next steps of the Agent through reinforcement learning.

Tree search: TOT + reinforcement learning-based reflection.

Self-Discover: Reasoning within the task.

Planning-focused

Planning enables agents to approach tasks methodically, increasing efficiency and effectiveness. These agents prioritize the development of structured plans before taking action. They decompose complex tasks into manageable sub-tasks and sequence them logically to achieve specific goals. By formulating detailed plans, these agents can anticipate potential challenges and allocate resources efficiently, resulting in more organized and goal-directed behaviour. [https://arxiv.org/pdf/2402.02716]

Plan & Solve: Plan → Task list → RePlan.

LLM compiler: Plan → Action in parallel → Joint execution.

REWOO: Plan (including dependencies) → Action (depends on the previous step).

Storm: Search for outline → Search each topic in the outline → Summarize into a long text.

When reviewing these design patterns, we see the workflow as an orchestrator. Each node can represent an LLM task, a function call, and other tasks like Retrieval-Augmented Generation (RAG) task, which we typically treat as another type of function call. This concept is one of the main drivers behind developing our own agent. We've designed the workflow as a flexible task orchestrator, allowing developers to create various workflows to tackle different problems.

In this post, we will explore two specific workflow design patterns: the ReAct pattern and the Plan-Solve pattern. For the remaining patterns, we'll provide a brief summary to explain their motivation and use cases.

ReAct Pattern

The ReAct principle is straightforward and reflects a core aspect of human intelligence: "actions guided by verbal reasoning." After each action, there's an internal "Observation" or self-reflection: "What did I just do? Have I achieved my goal?" This enables the agent to retain short-term memory. Before ReAct, reasoning and action were treated as separate processes.

For example, imagine you ask someone to find a pen on your desk, and you give step-by-step instructions (similar to the Chain-of-Thought prompting strategy):

First, check the pen holder.

Then, look in the drawer.

Lastly, check behind the computer monitor.

Without ReAct, regardless of where the pen is found, the person would follow all the steps, checking each location (Action).

With ReAct, the process would look like this:

Action 1: First, check the pen holder;

Observation 1: The pen is not in the pen holder, so move to the next step;

Action 2: Then, check the drawer;

Observation 2: The pen is in the drawer;

Action 3: Take the pen from the drawer.

ReAct Implementation

After reviewing several open-source codes, let's focus on the simplest one for analysis. As you explore it, you'll notice that, at its essence, all Agent design patterns revolve around translating human thinking and management strategies into structured prompts. These prompts guide the large model to plan, invoke tools for execution, and continuously refine its approach through iteration.

The code logic is outlined in the diagram below (take a close look):

Generate the prompt: First, the predefined ReAct prompt template (formatted as Question -> Thought -> Action -> Observation) is merged with the user's question. The resulting prompt looks like this.

Call the large model to generate Thought + Action: Next, send the few-shot prompt to the large model. If sent as is, the model will generate Thought, Action, and Observation responses. However, since the Action isn't fully defined, we prevent the model from generating the Observation by using Stop.Observation, ensuring it stops after Thought and Action.

Calling External Tools: Once the Action is obtained, the model can call external tools. First, check if the Action is "Finish." If not, the model converts the Action into an API-compatible format using its function-calling feature. This fine-tunes the model for language-to-API conversion, though not all large models support function calling.

Generating Observation: After the API interface returns the result, it is converted into natural language output to generate the Observation. Then the Observation, along with the previously generated Thought and Action, is input back into the model, repeating steps 2 and 3 until the Action is "Finish."

Final Output: The final Observation is converted into natural language and output to the user.

From this, we can see that implementing an Agent in a specific scenario requires customizing two key components:

The few-shot examples in the prompt template

The definition of external tools for function calling

The few-shot examples essentially mirror structured human thinking patterns. Reviewing prompt templates for different design patterns is a great way to understand Agent design. Once you grasp this approach, it can be applied to other design patterns similarly.

Plan and Solve Pattern

As the name suggests, this design pattern involves planning first and then executing. If ReAct is more suitable for tasks like "getting pen from the the desk" then Plan & Solve is better suited for tasks like "making a cup of flat white." You need to plan, and the plan might change during the process (for example, if you open the fridge and find no milk, you would add "buy milk" as a new step in the plan).

Regarding the prompt template, the paper's title makes it clear: Plan-and-Solve Prompting: Improving Zero-Shot Chain-of-Thought Reasoning by Large Language Models. In short, it's about improving zero-shot capabilities. The following image shows some PS-Plan and Solve prompts provided in the author's code.

Link

Its architecture is composed as follows:

Planner: Responsible for enabling the LLM to generate a multi-step plan to complete a large task. In the code, there are both a Planner and a Replanner. The Planner is responsible for generating the plan initially; the Replanner, on the other hand, comes into play after each individual task is completed, adjusting the plan based on the current progress. Therefore, the Replanner's prompt includes not only the zero-shot input but also the goal, the original plan, and the status of completed steps.

Executor: Receives the user's query and the steps from the plan, then calls one or more tools to accomplish the task.

Other Workflow Design Patterns

Here we give the brief introduction of other design patterns listed above.

Reason without Observation (REWOO)

REWOO (Reason without Observation) is a variation on the observation process seen in ReAct. While ReAct follows the structure: Thought → Action → Observation, REWOO simplifies this by removing the explicit observation step. Instead, it implicitly embeds observation into the next execution unit. In practice, the next executor automatically observes the outcome of the previous step, streamlining the process.

LLMCompiler

In computer science, a compiler refers to the orchestration of tasks to optimize computational efficiency. The concept behind An LLM Compiler for Parallel Function Calling, as outlined in the original paper, is simple yet effective: it aims to enhance efficiency by enabling parallel function calls. For instance, if a user asks, "What's the difference between AWS Glue and MWAA?", the compiler would search for the AWS services definition simultaneously and combine the results, rather than handling each query sequentially.

Basic Reflection

Basic Reflection can be compared to a feedback loop between a student (the Generator) and a teacher (the Reflector). The student completes an assignment, the teacher provides feedback, and the student revises their work based on this feedback, repeating the cycle until the task is satisfactorily completed.

Reflexion

Reflexion builds on Basic Reflection, incorporating principles of reinforcement learning. Described in the paper Reflexion: Language Agents with Verbal Reinforcement Learning, this approach goes beyond simple feedback. It evaluates the response using external data and forces the model to address any redundancies or omissions, making the reflective process more robust and the output more refined.

Language Agent Tree Search (LATS)

LATS is detailed in the paper Language Agent Tree Search Unifies Reasoning, Acting, and Planning in Language Models. It combines several techniques, including Tree Search, ReAct, and Plan & Solve. LATS uses tree search to assess outcomes (drawing from reinforcement learning), while also integrating reflection to achieve optimal results. In essence, LATS can be represented by the following formula:

LATS = Tree Search + ReAct + Plan & Solve + Reflection + Reinforcement Learning.

In terms of prompt design, the difference between LATS and earlier methods such as Reflection, Plan & Solve, and ReAct is minimal. The key addition is the tree search evaluation step and the return of those evaluated results within the task context. Architecturally, LATS involves multiple rounds of Basic Reflection, with several Generators and Reflectors working collaboratively.

Self-Discovery

The core of Self-Discovery is to allow the large model to reflect at a more granular level. While Plan & Solve focuses on whether a task requires additional steps or adjustments, Self-Discovery goes further, encouraging reflection on the task itself. This involves evaluating each component of the task and the execution of those components.

Storm

Storm, outlined in the paper Assisting in Writing Wikipedia-like Articles From Scratch with Large Language Models, introduces a workflow for generating comprehensive articles from scratch, similar to a Wikipedia entry. The agent first uses external tools to search for information and generate an outline. Then, it produces content for each section based on the outline, making the process structured and efficient.

Conclusion

In this post, we explore various AI agent workflow design patterns, we categorize the patterns into Reflection-focused and Planning-focused, showcasing examples like the ReAct and Plan-Solve patterns. For developing purposes, these workflow patterns emphasize that workflows act as orchestrators for tasks within an agent. Each node in the workflow represents actions such as LLM tasks, function calls, or Retrieval-Augmented Generation (RAG). This structure enables the agent to plan, execute tasks, and iterate, simulating human reasoning.

We are currently developing our own agent based on these principles, utilizing workflows as flexible task orchestrators to handle different problems. More details on our agent implementation will be covered in the next post.