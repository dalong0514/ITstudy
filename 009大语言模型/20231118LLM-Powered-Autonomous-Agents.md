## LLM Powered Autonomous Agents

[LLM Powered Autonomous Agents | Lil'Log](https://lilianweng.github.io/posts/2023-06-23-agent/#:~:text=,the%20quality%20of%20final%20results)

Building agents with LLM (large language model) as its core controller is a cool concept.
使用LLM（大型语言模型）作为其核心控制器构建代理是一个很酷的概念。

Several proof-of-concepts demos, such as AutoGPT, GPT-Engineer and BabyAGI, serve as inspiring examples.
一些概念验证演示，如AutoGPT、GPT-Engineer和BabyAGI，是鼓舞人心的例子。

The potentiality of LLM extends beyond generating well-written copies, stories, essays and programs; it can be framed as a powerful general problem solver.
LLM的潜能不仅限于生成优质的文本、故事、论文和程序；它可以被视为一个强大的通用问题解决者。

Agent System Overview
代理系统概述

In a LLM-powered autonomous agent system, LLM functions as the agent’s brain, complemented by several key components:
在一个由LLM驱动的自主代理系统中，LLM充当代理的大脑，辅以几个关键组件：

Planning
规划

Subgoal and decomposition: The agent breaks down large tasks into smaller, manageable subgoals, enabling efficient handling of complex tasks.
子目标和分解：代理将大任务分解为更小、可管理的子目标，从而有效处理复杂任务。

Reflection and refinement: The agent can do self-criticism and self-reflection over past actions, learn from mistakes and refine them for future steps, thereby improving the quality of final results.
反思和改进：代理可以对过去的行动进行自我批评和反思，从错误中学习并改进以用于未来的步骤，从而提高最终结果的质量。

Memory
记忆

Short-term memory: I would consider all the in-context learning (See Prompt Engineering) as utilizing short-term memory of the model to learn.
短期记忆：我认为所有上下文学习（参见提示工程）都是利用模型的短期记忆来学习。

Long-term memory: This provides the agent with the capability to retain and recall (infinite) information over extended periods, often by leveraging an external vector store and fast retrieval.
长期记忆：这使代理能够在较长时间内保留和回忆（无限的）信息，通常是通过利用外部向量存储和快速检索。

Tool use
工具使用

The agent learns to call external APIs for extra information that is missing from the model weights (often hard to change after pre-training), including current information, code execution capability, access to proprietary information sources and more.
代理学会调用外部API以获取模型权重中缺失的额外信息（通常在预训练后难以更改），包括当前信息、代码执行能力、访问专有信息源等。