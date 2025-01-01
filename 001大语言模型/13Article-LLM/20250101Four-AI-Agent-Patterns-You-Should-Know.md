## 20250101Four-AI-Agent-Patterns-You-Should-Know

[4 Must-Know AI Agent Patterns for Smarter Systems | Level Up Coding](https://levelup.gitconnected.com/4-ai-agent-patterns-you-should-know-345e94d988f1)

4 AI Agent Patterns You Should Know

Lorenz Hofmann-Wellenhof

Published in Level Up Coding

Dec 2, 2024

Since the company I work for started investing heavily in voice virtual agents, I thought I should learn about the basics and the status quo.

自从我所在的公司开始大力投入语音虚拟智能体（AI Agent）以来，我就觉得应该学习一下这方面的基础知识和当前发展状况。

In this article, we are gonna explore some common design patterns for AI agents.

本文将带你了解一些 AI 智能体的常见设计模式。

[Announcing Cresta Voice Virtual Agent: What Sets It Apart & What the Market Is Getting Wrong - Cresta](https://cresta.com/blog/announcing-cresta-voice-virtual-agent-what-sets-it-apart-what-the-market-is-getting-wrong/)

### Reflection Pattern

反思模式

This pattern involves agents analyzing and improving their own performance. Agents use self-evaluation to refine their outputs and decision-making processes.

这种模式涉及 AI 智能体（Agent）分析和改进自身的表现。AI 智能体使用自我评估来优化其输出和决策过程。

Source: Author

This is a fairly simple design pattern and can be implemented with a few lines of code.

这是一个相当简单的设计模式，只需要几行代码就可以实现。

```py
def self_refine(task_input, model, max_iterations=3, stop_condition="No further refinement needed"):
    # Step 1: Initial generation
    current_output = model.generate(task_input) # Initial draft
    for iteration in range(max_iterations):
        # Step 2: Generate feedback
        feedback_prompt = f"Review the following output and provide actionable feedback:\nfcurrent_output}" l
        feedback = model.generate(feedback_prompt)
    # Check stopping condition
    if stop_condition in feedback:
        print(f"Stopping at iteration {iteration + 1}: {feedback}")
        break
    # Step 3: Apply feedback to refine the output
    refinement_prompt = f"Refine the output based on the
    feedback: \nOutput:\n{current_output}\nFeedback: \n{feedback}"
    refined_output = model.generate(refinement_prompt)
    # Update for next iteration
    current_output = refined_output
    return current_output
```

Example use cases where the reflection design pattern is performing better than just a generic LLM are:

反思设计模式（reflection design pattern）比通用大语言模型（generic LLM）在以下用例中表现更佳：

Code Optimizations

代码优化

Dialogue Response

对话响应

Take a look at the image below where you see how the LLM is refining its output for a dialogue and for the code optimization example.

请看下图，图中展示了 LLM 如何针对对话和代码优化示例改进其输出。

Source: SELF-REFINE: Iterative Refinement with Self-Feedback

### Tool Use Pattern

工具使用方式

Source: Author

Here is how the pattern works:

以下是该模式的工作原理：

1 Function Description: The LLM is provided with detailed descriptions of the available tools, including their purposes and required parameters.

功能说明：大语言模型会收到可用工具的详细描述，其中包括工具的用途和所需的参数。

2 Tool Selection: Based on the task at hand, the LLM decides which tool to use.

工具选择：根据当前的任务，大语言模型会决定使用哪个工具。

3 Function Calling: The LLM generates a special string to call the selected tool, typically in a specific format (e.g., JSON).

功能调用：大语言模型会生成一个特殊的字符串，用于调用指定的工具，这个字符串通常采用特定的格式，例如 JSON 格式。

4 Execution: A post-processing step identifies these function calls, executes them, and returns the results to the LLM.

执行：在后续处理中，系统会识别这些功能调用，执行它们，并将结果返回给大语言模型。

5 Integration: The LLM incorporates the tool's output into its final responses.

整合：大语言模型将工具的输出整合到最终回复中。

If you have not been living under a rock and have used GPT, then you realize that it is doing this already automatically for certain tasks.

如果你对 GPT 有所了解，你会发现它已经在某些任务中自动完成这个过程了。

However, more advanced implementations are when LLMs are given access to hundreds of tools to expand their capabilities.

不过，更先进的应用场景是让大语言模型（LLM/Large Language Model）能够访问数百种工具，以此扩展它们的能力。

For example, Gorilla enables LLMs to use tools by invoking APIs. Given a natural language query, Gorilla comes up with the semantically and syntactically correct API to invoke.

例如，Gorilla 允许大语言模型通过调用应用程序接口（API）来使用各种工具。当收到自然语言的查询时，Gorilla 会生成在语义和语法上都正确的 API 调用。

With Gorilla, you can invoke 1,600+ (and growing) ML API calls.

有了 Gorilla，你可以调用 1,600 多个（并且还在增长）机器学习（ML）API 调用。

Their CLI allows you to perform tasks with natural language. For example, you can

Gorilla 的命令行界面（CLI）允许你用自然语言执行任务。例如，你可以

$ gorilla generate 100 random characters into a file called test.txt

And then it comes up with the CLI command:

cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 100 | head -n 1 > test.txt

这条命令首先利用 `/dev/urandom` 生成随机数据流，然后使用 `tr` 命令过滤掉除字母和数字以外的所有字符，接着用 `fold` 命令将每行限制为 100 个字符的长度，最后使用 `head` 命令提取第一行，并将结果写入到 `test.txt` 文件中。

I'm thrilled to share two valuable resources with you!

我很高兴与您分享两个有价值的资源！

First, as I turned 30 recently, I took a moment to reflect on everything I've learned about life. I compiled those insights into a Notion document called "Everything I Learned About Life." It's full with lessons that can help you navigate your own journey, everyday tools for maximum productivity, and content I consume to grow.

首先，我最近刚满 30 岁，借此机会回顾了自己关于生活的所有感悟。我将这些心得整理成了一份 Notion 文档，名为《我的人生感悟》。其中包含了许多能帮助你规划人生旅程的经验，提高效率的实用工具，以及我为了个人成长而学习的内容。

Second, I've made Medium Insights accessible to everyone. This powerful analytics tool lets you discover the statistics for any author on Medium, so you can better understand your favorite writers' impact.

第二，我已将 Medium Insights 功能向所有人开放。这个强大的分析工具可以让你查看 Medium 上任何作者的统计数据，从而更好地了解你所喜爱作家的影响力。

You will find both resource here.

[Gorilla](https://gorilla.cs.berkeley.edu/)

### Planning Pattern

规划模式

Here is how the pattern works:

Task Decomposition: A LLM acts as a controller that breaks down a task into smaller, manageable subtasks.

任务分解：一个大语言模型作为控制中心，将任务拆解成更小、更容易处理的子任务。

For each subtask, a specific model is chosen to perform the task.

Specific export models execute the subtasks, and the result is given to the controller LLM, which generates a response.

针对每个子任务，都会选择一个特定的模型来执行。

这些专门的模型负责执行各自的子任务，并将结果反馈给控制中心的大语言模型（LLM），由后者生成最终的响应。

Source: Author

One example where a planning pattern is used is HuggingGPT. HuggingGPT connects LLMs with the extensive ecosystem of models available on the Hugging Face platform.

HuggingGPT 就是一个应用规划模式的例子。它将大语言模型与 Hugging Face 平台上丰富的模型资源库连接起来。

### Multi-Agent Collaboration

Source: Author

### 多智能体协同来源：作者

Here is how it works:

Specialized Agents: Each agent is designed to perform specific roles or tasks, such as a software engineer, a product manager, or a designer.

专业化的 AI 智能体（AI Agent）：每个 AI 智能体都被设计用于执行特定的角色或任务，例如软件工程师、产品经理或设计师。

Task Decomposition: Complex tasks are broken down into smaller, manageable subtasks that can be distributed among the agents.

Communication and Coordination: Agents interact with each other, exchanging information and coordinating their actions to achieve common goals.

任务分解：复杂的任务会被分解为更小、更易于管理的子任务，然后将这些子任务分配给不同的 AI 智能体（AI Agent）。

通信和协调：AI 智能体之间相互互动，交换信息并协调各自的行动，以达成共同的目标。

Distributed Problem Solving: The system uses the collective capabilities of multiple agents to address problems too complex for a single agent.

I don't think there are a ton of real-world multi-agent systems out there yet since the technology is too immature. An example I found is ChatDev, which is a virtual software company with a CEO, CTO, engineers, etc.

分布式问题解决：这种方法利用多个 AI 智能体的协同工作能力，来解决单个 AI 智能体难以处理的复杂问题。

我认为目前实际应用中的多智能体系统还不多，因为相关技术仍不成熟。例如，我发现了一个名为 ChatDev 的项目，它模拟了一家虚拟软件公司，其中有 CEO、CTO 和工程师等不同的角色。

Andrew Ng classifies the Planning and the Multi-Agent Collaboration pattern as unpredictable:

Like the design pattern of Planning, I find the output quality of multi-agent collaboration hard to predict, especially when allowing agents to interact freely and providing them with multiple tools. The more mature patterns of Reflection and Tool Use are more reliable. - Andrew Ng

吴恩达认为，规划和多智能体协作模式具有不可预测性：

「像规划模式一样，我发现多智能体协作的输出质量难以预测，尤其当允许智能体自由交互并使用多种工具时。相比之下，更成熟的反射和工具使用模式则更为可靠。」—— 吴恩达

So, given his insights, I think the first two patterns are more likely to be used in current production systems.

因此，根据他的观点，我认为前两种模式更有可能被应用在目前的生产系统中。



## 原文

Since the company I work for started investing heavily in voice virtual agents, I thought I should learn about the basics and the status quo.

In this article, we are gonna explore some common design patterns for AI agents.

### Reflection Pattern

This pattern involves agents analyzing and improving their own performance. Agents use self-evaluation to refine their outputs and decision-making processes.

Source: Author

This is a fairly simple design pattern and can be implemented with a few lines of code.

Example use cases where the reflection design pattern is performing better than just a generic LLM are:

Code Optimizations

Dialogue Response

Take a look at the image below where you see how the LLM is refining its output for a dialogue and for the code optimization example.

Source: SELF-REFINE: Iterative Refinement with Self-Feedback

### Tool Use Pattern

Source: Author

Here is how the pattern works:

Function Description: The LLM is provided with detailed descriptions of the available tools, including their purposes and required parameters.

Tool Selection: Based on the task at hand, the LLM decides which tool to use.

Function Calling: The LLM generates a special string to call the selected tool, typically in a specific format (e.g., JSON).

Execution: A post-processing step identifies these function calls, executes them, and returns the results to the LLM.

Integration: The LLM incorporates the tool's output into its final responses.

If you have not been living under a rock and have used GPT, then you realize that it is doing this already automatically for certain tasks.

However, more advanced implementations are when LLMs are given access to hundreds of tools to expand their capabilities.

For example, Gorilla enables LLMs to use tools by invoking APIs. Given a natural language query, Gorilla comes up with the semantically and syntactically correct API to invoke.

With Gorilla, you can invoke 1,600+ (and growing) ML API calls.

Their CLI allows you to perform tasks with natural language. For example, you can

$ gorilla generate 100 random characters into a file called test.txt

And then it comes up with the CLI command:

cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 100 | head -n 1 > test.txt

❗❗Short break

I'm thrilled to share two valuable resources with you!

First, as I turned 30 recently, I took a moment to reflect on everything I've learned about life. I compiled those insights into a Notion document called "Everything I Learned About Life." It's full with lessons that can help you navigate your own journey, everyday tools for maximum productivity, and content I consume to grow.

Second, I've made Medium Insights accessible to everyone. This powerful analytics tool lets you discover the statistics for any author on Medium, so you can better understand your favorite writers' impact.

You will find both resource here.

### Planning Pattern

Here is how the pattern works:

Task Decomposition: A LLM acts as a controller that breaks down a task into smaller, manageable subtasks.

For each subtask, a specific model is chosen to perform the task.

Specific export models execute the subtasks, and the result is given to the controller LLM, which generates a response.

Source: Author

One example where a planning pattern is used is HuggingGPT. HuggingGPT connects LLMs with the extensive ecosystem of models available on the Hugging Face platform.

### Multi-Agent Collaboration

Source: Author

Here is how it works:

Specialized Agents: Each agent is designed to perform specific roles or tasks, such as a software engineer, a product manager, or a designer.

Task Decomposition: Complex tasks are broken down into smaller, manageable subtasks that can be distributed among the agents.

Communication and Coordination: Agents interact with each other, exchanging information and coordinating their actions to achieve common goals.

Distributed Problem Solving: The system uses the collective capabilities of multiple agents to address problems too complex for a single agent.

I don't think there are a ton of real-world multi-agent systems out there yet since the technology is too immature. An example I found is ChatDev, which is a virtual software company with a CEO, CTO, engineers, etc.

Andrew Ng classifies the Planning and the Multi-Agent Collaboration pattern as unpredictable:

Like the design pattern of Planning, I find the output quality of multi-agent collaboration hard to predict, especially when allowing agents to interact freely and providing them with multiple tools. The more mature patterns of Reflection and Tool Use are more reliable. - Andrew Ng

So, given his insights, I think the first two patterns are more likely to be used in current production systems.