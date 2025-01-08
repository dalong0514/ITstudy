## 20250105How-to-Build-a-General-Purpose-LLM-Agent

[How to Build a General-Purpose LLM Agent | by Maya Murad | Dec, 2024 | Towards Data Science](https://towardsdatascience.com/build-a-general-purpose-ai-agent-c40be49e7400)

A Step-by-Step Guide

Maya Murad

Towards Data Science

Dec 5, 2024

Why build a general-purpose agent? Because it's an excellent tool to prototype your use cases and lays the groundwork for designing your own custom agentic architecture.

为什么要构建一个通用型 AI 智能体？因为它是一个快速验证你的应用场景的极好工具，并为设计你自己的定制智能体架构打下基础。

在深入了解之前，我们先来快速认识一下大语言模型（LLM）智能体。如果您已经了解，可以跳过这部分内容。

Before we dive in, let's quickly introduce LLM agents. Feel free to skip ahead.

### What is an LLM agent?

什么是大语言模型智能体？

An LLM agent is a program whose execution logic is controlled by its underlying model.

一个大语言模型（LLM）智能体，指的是其运行逻辑由它所依赖的大模型来控制的程序。

From Standalone LLMs to Agentic Systems. (Image by author)

从独立的大语言模型到智能体系统。(图片由作者提供)

What sets an LLM agent apart from approaches like few-shot prompting or fixed workflows is its ability to define and adapt the steps required to execute a user's query. Given access to a set of tools (like code execution or web search), the agent can decide which tool to use, how to use it, and iterate on results based on the output. This adaptability enables the system to handle diverse use cases with minimal configuration.

大语言模型（LLM）智能体之所以有别于少样本提示或固定工作流程等方法，在于它能够定义和调整执行用户查询所需的步骤。当智能体可以访问一组工具（例如代码执行或网络搜索）时，它能够自主决定使用哪个工具、如何使用，并根据输出结果不断调整。这种适应性使得系统仅需少量配置，即可应对各种不同的应用场景。

A Spectrum of Agentic Architectures. (Image by author)

智能体架构的多种形式（Image by author)

Agentic architectures exist on a spectrum, ranging from the reliability of fixed workflows to the flexibility of autonomous agents. For instance, a fixed flow like Retrieval-Augmented Generation (RAG) can be enhanced with a self-reflection loop, enabling the program to iterate when the initial response falls short. Alternatively, a ReAct agent can be equipped with fixed flows as tools, offering a flexible yet structured approach. The choice of architecture ultimately depends on the use case and the desired trade-off between reliability and flexibility.

智能体架构分布在一个连续的范围内，从可靠的固定工作流程到灵活的自主智能体。例如，像检索增强生成（Retrieval-Augmented Generation，RAG）这样的固定流程，可以通过一个自我反思循环来增强，使模型能够在初始响应不佳时进行迭代。或者，ReAct 智能体可以使用固定流程作为工具，提供一种灵活但结构化的方法。选择哪种架构最终取决于具体的应用场景以及对可靠性和灵活性的权衡。

For a deeper overview, check out this video.

想要更深入地了解，请观看这个视频。

[What are AI Agents? - YouTube](https://www.youtube.com/watch?v=F8NKVhkZZWI&t=1s)

### Let's build a general-purpose LLM agent from scratch!

让我们从零开始构建一个通用的大语言模型（Large Language Model）智能体！

#### Step 1. Select the right LLM

第一步：选择合适的大语言模型（LLM）

Choosing the right model is critical to achieving your desired performance. There are several factors to consider, like licensing, cost, and language support. The most important consideration for building an LLM agent is the model's performance on key tasks like coding, tool calling, and reasoning. Benchmarks to evaluate include:

选择合适的模型对于实现你所期望的性能至关重要。有几个因素需要考虑，例如许可、成本以及语言支持。构建大语言模型智能体（AI Agent）最重要的考虑因素是模型在关键任务上的表现，例如编码、工具调用和推理。评估的基准有：

1 Massive Multitask Language Understanding (MMLU) (reasoning)

大规模多任务语言理解能力评估（MMLU）（侧重推理）

2 Berkeley's Function Calling Leaderboard (tool selection & tool calling)

伯克利函数调用能力排行榜（工具选择与调用能力)

3 HumanEval and BigCodeBench (coding)

HumanEval 和 BigCodeBench（编码）

Another crucial factor is the model's context window. Agentic workflows can eat up a lot of tokens — sometimes 100K or more — a larger context window is really helpful.

另一个关键因素是模型的上下文窗口。AI 智能体的工作流程会占用大量的 Token —— 有时会达到 10 万或更多 —— 更大的上下文窗口至关重要。

Models to Consider (at the time of writing)

值得关注的模型（本文撰写时）：

1 Frontier models: GPT4-o, Claude 3.5

顶尖模型：GPT4-o，Claude 3.5

2 Open-source models: Llama3.2, Qwen2.5.

开源模型：Llama3.2、Qwen2.5（均为模型名称）。

In general, larger models tend to offer better performance, but smaller models that can run locally are still a solid option. With smaller models, you'll be limited to simpler use cases and might only be able to connect your agent to one or two basic tools.

通常来说，模型越大，性能越好，但可以在本地运行的小型模型仍然是不错的选择。使用小型模型，你只能处理更简单的任务，并且可能只能将你的 AI 智能体连接到少数几个基本工具。

[MMLU Benchmark (Multi-task Language Understanding) | Papers With Code](https://paperswithcode.com/sota/multi-task-language-understanding-on-mmlu)

[Berkeley Function Calling Leaderboard V3 (aka Berkeley Tool Calling Leaderboard V3)](https://gorilla.cs.berkeley.edu/leaderboard.html)

[EvalPlus Leaderboard](https://evalplus.github.io/leaderboard.html)

[Big Code Models Leaderboard - a Hugging Face Space by bigcode](https://huggingface.co/spaces/bigcode/bigcode-models-leaderboard)

#### Step 2. Define the agent's control logic (aka communication structure)

步骤 2. 确定智能体的控制逻辑（也称为通信结构)

Single Agent Architecture. (Image by author)

单智能体架构。(图片由作者提供)

The main difference between a simple LLM and an agent comes down to the system prompt.

简单的大语言模型（LLM）和 AI 智能体之间的主要区别，在于它们的系统提示。

The system prompt, in the context of an LLM, is a set of instructions and contextual information provided to the model before it engages with user queries.

对于大语言模型而言，系统提示是指在模型响应用户提问之前，预先提供给它的一组指令和背景信息。

The agentic behavior expected of the LLM can be codified within the system prompt.

大语言模型期望的像智能体一样的行为，可以在系统提示中进行定义。

Here are some common agentic patterns, which can be customized to fit your needs:

这里有一些常见的智能体行为模式，您可以根据自己的需求进行定制：

1 Tool Use: The agent determines when to route queries to the appropriate tool or rely on its own knowledge.

工具使用：AI 智能体（AI Agent）会判断何时将问题交给合适的工具处理，或者何时依靠自身的知识来解答。

2 Reflection: The agent reviews and corrects its answers before responding to the user. A reflection step can also be added to most LLM systems.

反思：AI 智能体在回答用户之前，会检查并修正自己的答案。许多大语言模型（LLM/Large Language Model）系统也可以加入反思步骤。

3 Reason-then-Act (ReAct): The agent iteratively reasons through how to solve the query, performs an action, observes the outcome, and determines whether to take another action or provide a response.

Reason-then-Act（ReAct）：ReAct（Reason-then-Act）智能体以迭代的方式进行推理，思考如何解决问题，然后采取行动，查看行动的结果，并决定是采取进一步的行动还是给出最终答案。

4 Plan-then-Execute: The agent plans upfront by breaking the task into sub-steps (if needed) and then executes each step.

计划-执行：AI 智能体预先规划，将任务分解为子步骤（如果需要），然后执行每个步骤。

The last two patterns — ReAct and Plan-then-Execute — are often the best starting point for building a general-purpose single agent.

最后两种模式 —— ReAct 和计划-执行 —— 通常是构建通用型单 AI 智能体的最佳起点。

Overview of Common Agentic Patterns. (Image by author)

常用 AI 智能体模式概览。(作者图片)

To implement these behaviors effectively, you'll need to do some prompt engineering. You might also want to use a structured generation technique. This basically means shaping the LLM's output to match a specific format or schema, so the agent's responses stay consistent with the communication style you're aiming for.

为了有效地实现这些行为，你需要进行一些提示工程（prompt engineering）。你可能还需要使用结构化生成技术。这基本上意味着引导大语言模型（LLM）的输出，使其符合特定的格式或结构，从而使 AI 智能体的回复与你期望的沟通风格保持一致。

Example: Below is a system prompt excerpt for a ReAct style agent from the Bee Agent Framework.

示例：以下是来自 Bee Agent Framework 的一个 ReAct 风格 AI 智能体的系统提示示例。

[bee-agent-framework/src/agents/bee/prompts.ts at main · i-am-bee/bee-agent-framework](https://github.com/i-am-bee/bee-agent-framework/blob/main/src/agents/bee/prompts.ts)

\# Communication structure
You communicate only in instruction lines. The format is: "Instruction: expected output". You must only use these instruction lines and must not enter empty lines or anything else between instruction lines.
You must skip the instruction lines Function Name, Function Input and Function Output if no function calling is required.

Message: User's message. You never use this instruction line.
Thought: A single-line plan of how to answer the user's message. It must be immediately followed by Final Answer.
Thought: A single-line step-by-step plan of how to answer the user's message. You can use the available functions defined above. This instruction line must be immediately followed by Function Name if one of the available functions defined above needs to be called, or by Final Answer. Do not provide the answer here.
Function Name: Name of the function. This instruction line must be immediately followed by Function Input.
Function Input: Function parameters. Empty object is a valid parameter.
Function Output: Output of the function in JSON format.
Thought: Continue your thinking process.
Final Answer: Answer the user or ask for more information or clarification. It must always be preceded by Thought.

\## Examples
Message: Can you translate "How are you" into French?
Thought: The user wants to translate a text into French. I can do that.
Final Answer: Comment vas-tu?

#### Step 3. Define the agent's core instructions

步骤 3. 定义 AI 智能体的核心指令。

We tend to take for granted that LLMs come with a bunch of features right out of the box. Some of these are great, but others might not be exactly what you need. To get the performance you're after, it's important to spell out all the features you want — and don't want — in the system prompt.

我们常常想当然地认为，大语言模型（LLM/Large Language Model）具备许多开箱即用的功能。其中一些功能很实用，但另一些可能并非你所需。为了达到你期望的性能，在系统提示中明确指出你想要以及不想要的所有功能至关重要。

This could include instructions like:

这可以包括以下类型的指令：

1 Agent Name and Role: What the agent is called and what it's meant to do.

AI 智能体名称和角色：AI 智能体的名称以及其设计用途。

2 Tone and Conciseness: How formal or casual it should sound, and how brief it should be.

语气和简洁性：语气应该有多正式或随意，以及应该有多精炼。

3 When to Use Tools: Deciding when to rely on external tools versus the model's own knowledge.

何时使用工具：决定何时使用外部工具，而不是依赖模型自身的知识。

4 Handling Errors: What the agent should do when something goes wrong with a tool or process.

错误处理：当工具或流程出现问题时，AI 智能体应该如何应对。

Example: Below is a snippet of the instructions section from the Bee Agent Framework.

示例：以下是 Bee Agent Framework 中指令部分的节选。

[bee-agent-framework/src/agents/bee/prompts.ts at main · i-am-bee/bee-agent-framework](https://github.com/i-am-bee/bee-agent-framework/blob/main/src/agents/bee/prompts.ts)

\# Instructions
User can only see the Final Answer, all answers must be provided there.
You must always use the communication structure and instructions defined above. Do not forget that Thought must be a single-line immediately followed by Final Answer.
You must always use the communication structure and instructions defined above. Do not forget that Thought must be a single-line immediately followed by either Function Name or Final Answer.
Functions must be used to retrieve factual or historical information to answer the message.
If the user suggests using a function that is not available, answer that the function is not available. You can suggest alternatives if appropriate.
When the message is unclear or you need more information from the user, ask in Final Answer.

\# Your capabilities
Prefer to use these capabilities over functions.
- You understand these languages: English, Spanish, French.
- You can translate and summarize, even long documents.

\# Notes
- If you don't know the answer, say that you don't know.
- The current time and date in ISO format can be found in the last message.
- When answering the user, use friendly formats for time and date.
- Use markdown syntax for formatting code snippets, links, JSON, tables, images, files.
- Sometimes, things don't go as planned. Functions may not provide useful information on the first few tries. You should always try a few different approaches before declaring the problem unsolvable.
- When the function doesn't give you what you were asking for, you must either use another function or a different function input.
  - When using search engines, you try different formulations of the query, possibly even in a different language.
- You cannot do complex calculations, computations, or data manipulations without using functions.m

#### Step 4. Define and optimize your core tools

步骤 4. 定义并优化你的核心工具

Tools are what give your agents their superpowers. With a narrow set of well-defined tools, you can achieve broad functionality. Key tools to include are code execution, web search, file reading, and data analysis.

工具是赋予你的 AI 智能体超能力的关键。通过精简且定义明确的工具集，你可以实现广泛的功能。关键工具包括代码执行、网络搜索、文件读取和数据分析。

For each tool, you'll need to define the following and include it as part of the system prompt:

对于每个工具，您需要定义以下内容，并将其纳入系统提示中：

1 Tool Name: A unique, descriptive name for the capability.

工具名称：此功能唯一的、描述性的名称。

2 Tool Description: A clear explanation of what the tool does and when to use it. This helps the agent determine when to pick the right tool.

工具描述：对工具的功能以及何时使用进行清晰的解释。这有助于 AI 智能体（AI Agent）确定何时选择合适的工具。

3 Tool Input Schema: A schema that outlines required and optional parameters, their types, and any constraints. The agent uses this to fill in the inputs it needs based on the user's query..

工具输入结构： 一个概述了必需和可选参数、它们的类型以及任何约束的结构。AI 智能体使用这个结构来根据用户的查询填写所需的输入。

4 A pointer to where/how to run the tool.

关于如何运行此工具的说明。

Example: Below is an excerpt of an Arxiv tool implementation from Langchain Community. This implementation requires an ArxivAPIWrapper implementation.

示例：以下是 Langchain Community 中 Arxiv 工具实现的一个片段。这个工具的实现需要 ArxivAPIWrapper。

[langchain/libs/community/langchain\_community/tools/arxiv/tool.py at master · langchain-ai/langchain](https://github.com/langchain-ai/langchain/blob/master/libs/community/langchain_community/tools/arxiv/tool.py)

[langchain/libs/community/langchain\_community/tools at master · langchain-ai/langchain](https://github.com/langchain-ai/langchain/tree/master/libs/community/langchain_community/tools)

In certain cases, you'll need to optimize tools to get the performance you're looking for. This might involve tweaking the tool name or description with some prompt engineering, setting up advanced configurations to handle common errors, or filtering the tool's output.

在某些情况下，为了达到预期的性能，您可能需要对工具进行优化。这可能包括：通过一些提示工程（prompt engineering）的技巧，调整工具的名称或描述；设置更高级的配置来处理常见的错误；或者对工具的输出结果进行筛选。

```py
class ArxivInput(BaseModel):
    """Input for the Arxiv tool."""

    query: str = Field(description="search query to look up")


class ArxivQueryRun(BaseTool):  # type: ignore[override, override]
    """Tool that searches the Arxiv API."""

    name: str = "arxiv"
    description: str = (
        "A wrapper around Arxiv.org "
        "Useful for when you need to answer questions about Physics, Mathematics, "
        "Computer Science, Quantitative Biology, Quantitative Finance, Statistics, "
        "Electrical Engineering, and Economics "
        "from scientific articles on arxiv.org. "
        "Input should be a search query."
    )
    api_wrapper: ArxivAPIWrapper = Field(default_factory=ArxivAPIWrapper)  # type: ignore[arg-type]
    args_schema: Type[BaseModel] = ArxivInput

    def _run(
        self,
        query: str,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> str:
        """Use the Arxiv tool."""
        return self.api_wrapper.run(query)p
```

#### Step 5. Decide on a memory handling strategy

步骤 5. 确定内存处理策略

LLMs are limited by their context window — the number of tokens they can "remember" at a time. This memory can fill up fast with things like past interactions in multi-turn conversations, lengthy tool outputs, or extra context the agent is grounded on. That's why having a solid memory handling strategy is crucial.

大语言模型（LLM）的处理能力受限于其上下文窗口 —— 即它们一次能够处理的 Token 数量。这个内存空间会很快被各种信息占据，例如多轮对话中的历史记录、冗长的工具输出，或是 AI 智能体（AI Agent）所依赖的额外背景信息。因此，制定一个有效的内存处理策略至关重要。

Memory, in the context of an agent, refers to the system's capability to store, recall, and utilize information from past interactions. This enables the agent to maintain context over time, improve its responses based on previous exchanges, and provide a more personalized experience.

在 AI 智能体（AI Agent）的上下文中，记忆指的是系统存储、回忆和利用过去交互信息的能力。这使得 AI 智能体能够保持上下文连贯性，随着时间的推移，根据之前的交流改进其响应，并提供更贴合用户需求的体验。

Common Memory Handling Strategies:

常见的内存管理方法：

1 Sliding Memory: Keep the last k conversation turns in memory and drop the older ones.

滑动内存：保留最近的 k 轮对话在内存中，并丢弃更早的对话。

2 Token Memory: Keep the last n tokens and forget the rest.

Token 记忆：保留最近的 n 个 Token，并丢弃其余的。

3 Summarized Memory: Use the LLM to summarize the conversation at each turn and drop the individual messages.

总结记忆：利用大语言模型（LLM）逐轮总结对话，并舍弃原始消息。

Additionally, you can also have an LLM detect key moments to store in long-term memory. This allows the agent to "remember" important facts about the user, making the experience even more personalized.

此外，还可以利用大语言模型来识别关键时刻，并将这些时刻存储到长期记忆中。这样，AI 智能体就能「记住」用户的相关重要信息，从而提供更加个性化的体验。

The five steps we've covered so far lay the foundation for setting up an agent. But what happens if we run a user query through our LLM at this stage?

我们目前介绍的五个步骤为建立一个 AI 智能体奠定了基础。但是，如果在这个阶段我们用大语言模型处理用户查询，会发生什么呢？

Fig: Answer: you get a raw text output. (Image by author)

Here's an example of what that might look like:

User Message: Extract key insighs from this dataset
Files: bill-of-materials.csv
Thought: First, I need to inspect the columns of the dataset and provide basic data statistics.
Function Name: Python
Function Input: {"language":"python","code":"import pandas as pd\n\ndataset = pd.read_csv('bill-of-materials.csv')\n\nprint(dataset.columns)\nprint(dataset.describe())","inputFiles":["bill-of-materials.csv"]}
Function Output:

At this point, the agent produces raw text output. So how do we get it to actually execute the next step? That's where parsing and orchestration come in.

现在，AI 智能体生成未经处理的文本输出。那么，我们如何才能让它真正执行下一步操作呢？这就需要用到解析和编排技术了。

#### Step 6. Parse the agent's raw output

第六步：解析智能体的原始输出

A parser is a function that converts raw data into a format your application can understand and work with (like an object with properties)

解析器是一种函数，它将原始数据转换成应用可以理解和使用的格式，比如带有属性的对象。

For the agent we're building, the parser needs to recognize the communication structure we defined in Step 2 and return a structured output, like JSON. This makes it easier for the application to process and execute the agent's next steps.

对于我们构建的 AI 智能体（AI Agent），解析器需要识别在步骤 2 中定义的通信结构，并返回例如 JSON 这样的结构化输出。这有助于应用程序处理并执行 AI 智能体的后续步骤。

Note: some model providers like OpenAI, can return parsable outputs by default. For other models, especially open-source ones, this would need to be configured.

注意：像 OpenAI 这样的模型提供商，默认就能返回结构化的输出。对于其他模型，尤其是开源模型，则需要进行配置才能实现。

#### Step 7. Orchestrate the agent's next step

步骤 7. 规划智能体的下一步行动

The final step is setting up the orchestration logic. This determines what happens after the LLM outputs a result. Depending on the output, you'll either:

最后一步是设置编排逻辑。它决定了在 LLM 输出结果后会发生什么。根据输出的不同，您要么：

1 Execute a tool call, or

2 Return an answer — either the final response to the user's query or a follow-up request for more information.

执行一个工具调用，  

要么返回一个答案 —— 这可能是对用户查询的最终回复，也可能是一个进一步请求更多信息的后续问题。

Extended single agent architecture. (Image by author)

If a tool call is triggered, the tool's output is sent back to the LLM (as part of its working memory). The LLM would then determine what to do with this new information: either perform another tool call or return an answer to the user.

如果触发了工具调用，工具的输出结果会返回给大语言模型（LLM），并作为其工作记忆的一部分存储起来。随后，大语言模型会根据这个新信息来决定下一步操作：是再次调用工具，还是直接回复用户。

Here's an example of how this orchestration logic might look in code:

以下展示了这种编排逻辑在代码中的实现方式：

```py
def orchestrator(llm_agent, llm_output, tools, user_query):
    """
    Orchestrates the response based on LLM output and iterates if necessary.

    Parameters:
    - llm_agent (callable): The LLM agent function for processing tool outputs.
    - llm_output (dict): Initial output from the LLM, specifying the next action.
    - tools (dict): Dictionary of available tools with their execution methods.
    - user_query (str): The original user query.

    Returns:
    - str: The final response to the user.
    """
    while True:
        action = llm_output.get("action")

        if action == "tool_call":
            # Extract tool name and parameters
            tool_name = llm_output.get("tool_name")
            tool_params = llm_output.get("tool_params", {})

            if tool_name in tools:
                try:
                    # Execute the tool
                    tool_result = tools[tool_name](**tool_params)
                    # Send tool output back to the LLM agent for further processing
                    llm_output = llm_agent({"tool_output": tool_result})
                except Exception as e:
                    return f"Error executing tool '{tool_name}': {str(e)}"
            else:
                return f"Error: Tool '{tool_name}' not found."

        elif action == "return_answer":
            # Return the final answer to the user
            return llm_output.get("answer", "No answer provided.")

        else:
            return "Error: Unrecognized action type from LLM output."
```

And voilà! You now have a system capable of handling a wide variety of use cases — from competitive analysis and advanced research to automating complex workflows.

至此，你就拥有了一个能够应对多种应用场景的系统，它既可以进行竞争分析和深入研究，也能自动化复杂的工作流程。

### Where do multi-agent systems come in?

多智能体系统如何发挥作用？

While this generation of LLMs is incredibly powerful, they have a key limitation: they struggle with information overload. Too much context or too many tools can overwhelm the model, leading to performance issues. A general-purpose single agent will eventually hit this ceiling, especially since agents are notoriously token-hungry.

虽然这一代大语言模型（LLM）功能非常强大，但它们面临一个关键限制：难以处理过量信息。过多的上下文或工具会让模型难以招架，导致性能下降。通用的单智能体最终会触及这个瓶颈，尤其因为智能体对 Token 的需求量很大。

For certain use cases, a multi-agent setup might make more sense. By dividing responsibilities across multiple agents, you can avoid overloading the context of a single LLM agent and improve overall efficiency.

对于某些应用场景，多智能体（multi-agent）系统可能更合适。通过在多个智能体之间分配任务，可以避免单个大语言模型（LLM）智能体的上下文信息过多，并提高整体效率。

That said, a general-purpose single-agent setup is a fantastic starting point for prototyping. It can help you quickly test your use case and identify where things start to break down. Through this process, you can:

也就是说，一个通用的单智能体系统是原型开发的一个很好的起点。它可以帮助你快速测试你的用例，并识别哪些环节出现问题。通过这个过程，你可以：

1 Understand which parts of the task truly benefit from an agentic approach.

理解任务的哪些部分能够真正从 AI 智能体（AI Agent）方法中获益。

2 Identify components that can be spun off as standalone processes in a larger workflow.

识别在更大的工作流程中，哪些组件可以作为独立的流程拆分出来。

Starting with a single agent gives you valuable insights to refine your approach as you scale to more complex systems.

从一个 AI 智能体开始，可以帮助你获得宝贵的经验，从而在未来扩展到更复杂的系统时，更好地优化你的方法。

### What is the best way to get started?

那么，如何开始是最好的呢？

Ready to dive in and start building? Using a framework can be a great way to quickly test and iterate on your agent configuration.

准备好开始动手构建了吗？使用框架是快速测试和迭代你的 AI 智能体配置的好方法。

1 Planning on using open-source models like Llama 3? Try this starter template from the Bee Agent Framework.

如果你打算使用像 Llama 3 这样的开源模型，不妨试试 Bee Agent Framework 提供的入门模板。

2 Planning on using frontier models like OpenAI? Try this tutorial from LangGraph.

您是否正计划使用像 OpenAI 这样的前沿模型？不妨试试 LangGraph 的这篇教程。

[How to create a ReAct agent from scratch](https://langchain-ai.github.io/langgraph/how-tos/react-agent-from-scratch/)

## 原文

How to Build a General-Purpose LLM Agent
A Step-by-Step Guide
Maya Murad
Towards Data Science

Dec 5, 2024

High-level Overview of an LLM Agent. (Image by author)
Why build a general-purpose agent? Because it’s an excellent tool to prototype your use cases and lays the groundwork for designing your own custom agentic architecture.

Before we dive in, let’s quickly introduce LLM agents. Feel free to skip ahead.

What is an LLM agent?
An LLM agent is a program whose execution logic is controlled by its underlying model.


From Standalone LLMs to Agentic Systems. (Image by author)
What sets an LLM agent apart from approaches like few-shot prompting or fixed workflows is its ability to define and adapt the steps required to execute a user’s query. Given access to a set of tools (like code execution or web search), the agent can decide which tool to use, how to use it, and iterate on results based on the output. This adaptability enables the system to handle diverse use cases with minimal configuration.


A Spectrum of Agentic Architectures. (Image by author)
Agentic architectures exist on a spectrum, ranging from the reliability of fixed workflows to the flexibility of autonomous agents. For instance, a fixed flow like Retrieval-Augmented Generation (RAG) can be enhanced with a self-reflection loop, enabling the program to iterate when the initial response falls short. Alternatively, a ReAct agent can be equipped with fixed flows as tools, offering a flexible yet structured approach. The choice of architecture ultimately depends on the use case and the desired trade-off between reliability and flexibility.

For a deeper overview, check out this video.

Let’s build a general-purpose LLM agent from scratch!
Step 1. Select the right LLM
Choosing the right model is critical to achieving your desired performance. There are several factors to consider, like licensing, cost, and language support. The most important consideration for building an LLM agent is the model’s performance on key tasks like coding, tool calling, and reasoning. Benchmarks to evaluate include:

Massive Multitask Language Understanding (MMLU) (reasoning)
Berkeley’s Function Calling Leaderboard (tool selection & tool calling)
HumanEval and BigCodeBench (coding)
Another crucial factor is the model’s context window. Agentic workflows can eat up a lot of tokens — sometimes 100K or more — a larger context window is really helpful.

Models to Consider (at the time of writing)

Frontier models: GPT4-o, Claude 3.5
Open-source models: Llama3.2, Qwen2.5.
In general, larger models tend to offer better performance, but smaller models that can run locally are still a solid option. With smaller models, you’ll be limited to simpler use cases and might only be able to connect your agent to one or two basic tools.

Step 2. Define the agent’s control logic (aka communication structure)

Single Agent Architecture. (Image by author)
The main difference between a simple LLM and an agent comes down to the system prompt.

The system prompt, in the context of an LLM, is a set of instructions and contextual information provided to the model before it engages with user queries.

The agentic behavior expected of the LLM can be codified within the system prompt.

Here are some common agentic patterns, which can be customized to fit your needs:

Tool Use: The agent determines when to route queries to the appropriate tool or rely on its own knowledge.
Reflection: The agent reviews and corrects its answers before responding to the user. A reflection step can also be added to most LLM systems.
Reason-then-Act (ReAct): The agent iteratively reasons through how to solve the query, performs an action, observes the outcome, and determines whether to take another action or provide a response.
Plan-then-Execute: The agent plans upfront by breaking the task into sub-steps (if needed) and then executes each step.
The last two patterns — ReAct and Plan-then-Execute — are often the best starting point for building a general-purpose single agent.


Overview of Common Agentic Patterns. (Image by author)
To implement these behaviors effectively, you’ll need to do some prompt engineering. You might also want to use a structured generation technique. This basically means shaping the LLM’s output to match a specific format or schema, so the agent’s responses stay consistent with the communication style you’re aiming for.

Example: Below is a system prompt excerpt for a ReAct style agent from the Bee Agent Framework.

\# Communication structure
You communicate only in instruction lines. The format is: "Instruction: expected output". You must only use these instruction lines and must not enter empty lines or anything else between instruction lines.
You must skip the instruction lines Function Name, Function Input and Function Output if no function calling is required.

Message: User's message. You never use this instruction line.
Thought: A single-line plan of how to answer the user's message. It must be immediately followed by Final Answer.
Thought: A single-line step-by-step plan of how to answer the user's message. You can use the available functions defined above. This instruction line must be immediately followed by Function Name if one of the available functions defined above needs to be called, or by Final Answer. Do not provide the answer here.
Function Name: Name of the function. This instruction line must be immediately followed by Function Input.
Function Input: Function parameters. Empty object is a valid parameter.
Function Output: Output of the function in JSON format.
Thought: Continue your thinking process.
Final Answer: Answer the user or ask for more information or clarification. It must always be preceded by Thought.

\## Examples
Message: Can you translate "How are you" into French?
Thought: The user wants to translate a text into French. I can do that.
Final Answer: Comment vas-tu?
Step 3. Define the agent’s core instructions
We tend to take for granted that LLMs come with a bunch of features right out of the box. Some of these are great, but others might not be exactly what you need. To get the performance you’re after, it’s important to spell out all the features you want — and don’t want — in the system prompt.

This could include instructions like:

Agent Name and Role: What the agent is called and what it’s meant to do.
Tone and Conciseness: How formal or casual it should sound, and how brief it should be.
When to Use Tools: Deciding when to rely on external tools versus the model’s own knowledge.
Handling Errors: What the agent should do when something goes wrong with a tool or process.
Example: Below is a snippet of the instructions section from the Bee Agent Framework.

\# Instructions
User can only see the Final Answer, all answers must be provided there.
You must always use the communication structure and instructions defined above. Do not forget that Thought must be a single-line immediately followed by Final Answer.
You must always use the communication structure and instructions defined above. Do not forget that Thought must be a single-line immediately followed by either Function Name or Final Answer.
Functions must be used to retrieve factual or historical information to answer the message.
If the user suggests using a function that is not available, answer that the function is not available. You can suggest alternatives if appropriate.
When the message is unclear or you need more information from the user, ask in Final Answer.

\# Your capabilities
Prefer to use these capabilities over functions.
- You understand these languages: English, Spanish, French.
- You can translate and summarize, even long documents.

\# Notes
- If you don't know the answer, say that you don't know.
- The current time and date in ISO format can be found in the last message.
- When answering the user, use friendly formats for time and date.
- Use markdown syntax for formatting code snippets, links, JSON, tables, images, files.
- Sometimes, things don't go as planned. Functions may not provide useful information on the first few tries. You should always try a few different approaches before declaring the problem unsolvable.
- When the function doesn't give you what you were asking for, you must either use another function or a different function input.
  - When using search engines, you try different formulations of the query, possibly even in a different language.
- You cannot do complex calculations, computations, or data manipulations without using functions.m
Step 4. Define and optimize your core tools
Tools are what give your agents their superpowers. With a narrow set of well-defined tools, you can achieve broad functionality. Key tools to include are code execution, web search, file reading, and data analysis.

For each tool, you’ll need to define the following and include it as part of the system prompt:

Tool Name: A unique, descriptive name for the capability.
Tool Description: A clear explanation of what the tool does and when to use it. This helps the agent determine when to pick the right tool.
Tool Input Schema: A schema that outlines required and optional parameters, their types, and any constraints. The agent uses this to fill in the inputs it needs based on the user’s query..
A pointer to where/how to run the tool.
Example: Below is an excerpt of an Arxiv tool implementation from Langchain Community. This implementation requires an ArxivAPIWrapper implementation.

class ArxivInput(BaseModel):
    """Input for the Arxiv tool."""

    query: str = Field(description="search query to look up")


class ArxivQueryRun(BaseTool):  # type: ignore[override, override]
    """Tool that searches the Arxiv API."""

    name: str = "arxiv"
    description: str = (
        "A wrapper around Arxiv.org "
        "Useful for when you need to answer questions about Physics, Mathematics, "
        "Computer Science, Quantitative Biology, Quantitative Finance, Statistics, "
        "Electrical Engineering, and Economics "
        "from scientific articles on arxiv.org. "
        "Input should be a search query."
    )
    api_wrapper: ArxivAPIWrapper = Field(default_factory=ArxivAPIWrapper)  # type: ignore[arg-type]
    args_schema: Type[BaseModel] = ArxivInput

    def _run(
        self,
        query: str,
        run_manager: Optional[CallbackManagerForToolRun] = None,
    ) -> str:
        """Use the Arxiv tool."""
        return self.api_wrapper.run(query)p
In certain cases, you’ll need to optimize tools to get the performance you’re looking for. This might involve tweaking the tool name or description with some prompt engineering, setting up advanced configurations to handle common errors, or filtering the tool’s output.

Step 5. Decide on a memory handling strategy
LLMs are limited by their context window — the number of tokens they can “remember” at a time. This memory can fill up fast with things like past interactions in multi-turn conversations, lengthy tool outputs, or extra context the agent is grounded on. That’s why having a solid memory handling strategy is crucial.

Memory, in the context of an agent, refers to the system’s capability to store, recall, and utilize information from past interactions. This enables the agent to maintain context over time, improve its responses based on previous exchanges, and provide a more personalized experience.

Common Memory Handling Strategies:

Sliding Memory: Keep the last k conversation turns in memory and drop the older ones.
Token Memory: Keep the last n tokens and forget the rest.
Summarized Memory: Use the LLM to summarize the conversation at each turn and drop the individual messages.
Additionally, you can also have an LLM detect key moments to store in long-term memory. This allows the agent to “remember” important facts about the user, making the experience even more personalized.

The five steps we’ve covered so far lay the foundation for setting up an agent. But what happens if we run a user query through our LLM at this stage?


Answer: you get a raw text output. (Image by author)
Here’s an example of what that might look like:

User Message: Extract key insighs from this dataset
Files: bill-of-materials.csv
Thought: First, I need to inspect the columns of the dataset and provide basic data statistics.
Function Name: Python
Function Input: {"language":"python","code":"import pandas as pd\n\ndataset = pd.read_csv('bill-of-materials.csv')\n\nprint(dataset.columns)\nprint(dataset.describe())","inputFiles":["bill-of-materials.csv"]}
Function Output:
At this point, the agent produces raw text output. So how do we get it to actually execute the next step? That’s where parsing and orchestration come in.

Step 6. Parse the agent’s raw output
A parser is a function that converts raw data into a format your application can understand and work with (like an object with properties)

For the agent we’re building, the parser needs to recognize the communication structure we defined in Step 2 and return a structured output, like JSON. This makes it easier for the application to process and execute the agent’s next steps.

Note: some model providers like OpenAI, can return parsable outputs by default. For other models, especially open-source ones, this would need to be configured.

Step 7. Orchestrate the agent’s next step
The final step is setting up the orchestration logic. This determines what happens after the LLM outputs a result. Depending on the output, you’ll either:

Execute a tool call, or
Return an answer — either the final response to the user’s query or a follow-up request for more information.

Extended single agent architecture. (Image by author)
If a tool call is triggered, the tool’s output is sent back to the LLM (as part of its working memory). The LLM would then determine what to do with this new information: either perform another tool call or return an answer to the user.

Here’s an example of how this orchestration logic might look in code:

def orchestrator(llm_agent, llm_output, tools, user_query):
    """
    Orchestrates the response based on LLM output and iterates if necessary.

    Parameters:
    - llm_agent (callable): The LLM agent function for processing tool outputs.
    - llm_output (dict): Initial output from the LLM, specifying the next action.
    - tools (dict): Dictionary of available tools with their execution methods.
    - user_query (str): The original user query.

    Returns:
    - str: The final response to the user.
    """
    while True:
        action = llm_output.get("action")

        if action == "tool_call":
            # Extract tool name and parameters
            tool_name = llm_output.get("tool_name")
            tool_params = llm_output.get("tool_params", {})

            if tool_name in tools:
                try:
                    # Execute the tool
                    tool_result = tools[tool_name](**tool_params)
                    # Send tool output back to the LLM agent for further processing
                    llm_output = llm_agent({"tool_output": tool_result})
                except Exception as e:
                    return f"Error executing tool '{tool_name}': {str(e)}"
            else:
                return f"Error: Tool '{tool_name}' not found."

        elif action == "return_answer":
            # Return the final answer to the user
            return llm_output.get("answer", "No answer provided.")

        else:
            return "Error: Unrecognized action type from LLM output."
And voilà! You now have a system capable of handling a wide variety of use cases — from competitive analysis and advanced research to automating complex workflows.

Where do multi-agent systems come in?
While this generation of LLMs is incredibly powerful, they have a key limitation: they struggle with information overload. Too much context or too many tools can overwhelm the model, leading to performance issues. A general-purpose single agent will eventually hit this ceiling, especially since agents are notoriously token-hungry.

For certain use cases, a multi-agent setup might make more sense. By dividing responsibilities across multiple agents, you can avoid overloading the context of a single LLM agent and improve overall efficiency.

That said, a general-purpose single-agent setup is a fantastic starting point for prototyping. It can help you quickly test your use case and identify where things start to break down. Through this process, you can:

Understand which parts of the task truly benefit from an agentic approach.
Identify components that can be spun off as standalone processes in a larger workflow.
Starting with a single agent gives you valuable insights to refine your approach as you scale to more complex systems.

What is the best way to get started?
Ready to dive in and start building? Using a framework can be a great way to quickly test and iterate on your agent configuration.

Planning on using open-source models like Llama 3? Try this starter template from the Bee Agent Framework.
Planning on using frontier models like OpenAI? Try this tutorial from LangGraph.
What’s your experience building general-purpose agents?
Share your in the comments!