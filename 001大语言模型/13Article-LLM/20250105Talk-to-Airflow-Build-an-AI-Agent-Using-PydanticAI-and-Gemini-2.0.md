## 20250105Talk-to-Airflow-Build-an-AI-Agent-Using-PydanticAI-and-Gemini-2.0

[Talk to Airflow — Build an AI Agent Using PydanticAI and Gemini 2.0 | by Volker Janz | Dec, 2024 | Data Engineer Things](https://blog.det.life/talk-to-airflow-build-an-ai-agent-using-pydanticai-and-gemini-2-0-fd645cf99fcb)

Create an AI agent with PydanticAI to interact with Airflow DAGs

Volker Janz

Published in Data Engineer Things

Dec 24, 2024

### A Journey from Chaos to Control

从混沌到掌控的旅程

In the pioneering days of aviation, pilots flew through clouds with little more than basic instruments and raw instinct. Each flight was a dance between human judgment and mechanical power, relying heavily on experience and intuition for success. A slight miscalculation or unexpected weather change could spell disaster. They used amazing technology with little control over it.

在航空业的早期，飞行员们穿梭于云层之间，他们所依赖的仅仅是简陋的仪表和与生俱来的本能。每一次飞行，都是人类的判断力与机械动力之间的一场博弈，成功与否很大程度上取决于经验和直觉。哪怕是细微的计算失误或是突如其来的天气变化，都可能导致灾难性的后果。那时候，飞行员们虽然拥有令人惊叹的技术，但对它们的掌控能力却十分有限。

When I first started integrating LLMs into production systems, I felt like one of those early pilots — commanding immense power with minimal instrumentation. Every deployment felt like a leap of faith.

当我初次尝试将大语言模型（LLM/Large Language Model）应用于实际生产系统时，感觉自己就像早期的飞行员一样，虽然掌握着强大的能力，但可用的监控手段却非常有限。每一次部署都像是一次大胆的尝试。

The landscape of AI development today mirrors those early aviation challenges. We have incredibly powerful models like Gemini 2.0 at our disposal — capable of understanding context, generating human-like responses, and processing complex instructions. Yet, utilizing this power for production-grade applications often feels like flying through a storm without proper navigation tools.

如今的 AI 开发，其局面与早期航空面临的挑战颇为相似。我们拥有像 Gemini 2.0 这样强大的模型 —— 它们能够理解上下文，生成类似人类的回复，并处理复杂的指令。然而，将这些能力应用到生产级应用中，常常让人感觉像是在没有导航工具的情况下，于暴风雨中飞行。

But just as modern aviation evolved from risky adventures to reliable transportation through proper instrumentation and control systems, AI development is undergoing its own transformation toward agents. Unlike traditional AI, which simply responds to queries, agents actively engage with their environment. They make decisions, use tools, and execute tasks on your behalf. Modern AI agents, powered by LLMs like Gemini, understand natural language instructions, break down complex tasks into smaller steps, and provide structured output and monitoring.

但是，正如现代航空通过完善的仪表和控制系统，从高风险的探索发展为可靠的交通运输一样，人工智能（AI）的开发也正朝着 AI 智能体的方向演进。与传统 AI 仅仅响应查询不同，AI 智能体会积极地与其环境互动。它们会做出决策，使用工具，并代表您执行任务。现代 AI 智能体，由诸如 Gemini 等大语言模型（LLM）驱动，能够理解自然语言指令，将复杂的任务分解为更小的步骤，并给出结构化的结果并进行监控。

This is where PydanticAI appears at the sky. Built by the team behind Pydantic — the same foundation that powers numerous famous projects — it's a framework designed for modern AI development that brings control and reliability to agent systems.

PydanticAI 正是横空出世于此时。它由 Pydantic 背后的团队打造，而 Pydantic 正是众多知名项目的基石。PydanticAI 是一款专为现代 AI 开发设计的框架，旨在为 AI 智能体系统带来更强的控制力和可靠性。

Think of PydanticAI as your aircraft's modern cockpit — combining assistant systems, engine controls, and instrumentation panels into one coherent interface. It provides clear readings, predictable controls, and most importantly, the confidence to navigate through complex scenarios. It brings structure to chaos.

不妨把 PydanticAI 看作是您飞机的现代化驾驶舱 —— 它将辅助系统、引擎控制和仪表盘整合为一个统一的界面。它不仅提供清晰的数据读取和可预测的操作控制，更重要的是，它能让您在复杂的情形中充满信心地驾驶。PydanticAI 为混乱赋予了秩序。

In this article, we'll put PydanticAI to the test by building an AI agent that interacts with Apache Airflow. We'll create a system that can understand natural language queries about your workflows, fetch real-time status updates, and respond with structured, reliable data. No more flying blind through your DAG operations.

[Apache Airflow](https://airflow.apache.org/)

在本文中，我们将通过构建一个与 Apache Airflow 交互的 AI 智能体来检验 PydanticAI 的能力。我们将创建一个系统，它能够理解关于你的工作流的自然语言查询，获取实时的状态更新，并以结构化的、可靠的数据进行响应。有了它，你将不再对 DAG 的运行情况一无所知。

Want to jump straight into the code? Check out the project on GitHub:

[vojay-dev/pydantic-airflow-agent](https://github.com/vojay-dev/pydantic-airflow-agent)

### Why PydanticAI? The FastAPI Feeling for AI Development

为什么选择 PydanticAI？

Building production-grade AI applications shouldn't feel like solving a puzzle. Yet, when I first explored the landscape of AI frameworks, that's exactly what it felt like. Let me share why PydanticAI is becoming my go-to choice for modern AI development.

像 FastAPI 一样流畅的 AI 开发体验构建可用于生产环境的 AI 应用程序不应该像解谜一样困难。然而，当我最初接触各种 AI 框架时，实际体验却并非如此。接下来，我将分享为什么 PydanticAI 逐渐成为我进行现代 AI 开发的首选工具。

The Current Landscape

当前形势

The AI framework ecosystem is rich with options:

AI 框架生态种类繁多：

LangChain: Comprehensive but complex, offering numerous integrations and features.

LangChain：功能全面但结构复杂，集成了多种工具和特性。

crewAI: Specialized in multi-agent orchestration, great for complex agent interactions.

crewAI：专注于多 AI 智能体协同，尤其擅长处理复杂的 AI 智能体之间的互动。

Instructor: Focused on structured outputs and instruction following.

模型：专注于结构化输出和指令遵循。

Each has its strengths, but they often come with significant complexity and steep learning curves.

每种模型都有其优点，但它们通常也伴随着显著的复杂性和较高的学习门槛。

PydanticAI Simplicity

```py
from pydantic_ai import Agent

agent = Agent('gemini-1.5-flash', system_prompt='Be concise.')
result = agent.run_sync('Why choose PydanticAI?')
```

When I first saw the PydanticAI examples, it reminded me of my first FastAPI experience — clean, intuitive, and just right.

PydanticAI：简单易用我第一次看到 PydanticAI 的示例时，就想起了我初次接触 FastAPI 的感觉 —— 代码简洁、使用直观，一切都恰到好处。

What sets PydanticAI apart:

PydanticAI 的独特之处：

Built by the Pydantic Team

它是由 Pydantic 团队开发的。

1 Deep integration with Pydantic's ecosystem

与 Pydantic 生态系统的深度整合

2 Type safety that actually helps development

切实提升开发效率的类型安全

3 Familiar patterns for FastAPI developers

FastAPI 开发人员的常用模式

Production-Ready Design

面向生产环境的设计

1 Model-agnostic (OpenAI, Anthropic, Gemini, Ollama)

不依赖特定模型（OpenAI，Anthropic，Gemini，Ollama)

2 Built-in dependency injection for testing

内置依赖注入，方便进行测试

3 Seamless Logfire integration for real-time monitoring

无缝集成 Logfire 实现实时监控

Clean, Maintainable Code

代码整洁，易于维护

1 Minimal boilerplate

极简的预设代码

2 Strong type checking

严格的类型检查

3 Intuitive error messages

Note: The integration with Logfire is simple yet elegant, allowing for a detailed understanding of the flow of agents. There are impressive examples on the official PydanticAI page, but I haven't tried them yet. I highly recommend checking it out if you want to explore the framework beyond this article. If you do, feel free to let me know how it goes.

注意：与 Logfire 的集成既简单又优雅，能够帮助我们详细了解 AI 智能体（AI Agent）的运行流程。PydanticAI 的官方页面上有一些非常棒的示例，但我还没有亲自尝试。如果你想深入了解本文之外的更多框架内容，我强烈建议你去看看。如果你尝试了，欢迎随时告诉我你的体验。

The Future of PydanticAI

PydanticAI 的未来展望

The real power of PydanticAI lies in its alignment with modern Python development practices. As Pydantic continues to be the backbone of major Python frameworks and AI libraries, PydanticAI's tight integration becomes increasingly valuable.

PydanticAI 的真正优势在于它与现代 Python 开发实践的紧密结合。随着 Pydantic 逐渐成为主流 Python 框架和 AI 库的核心组件，PydanticAI 的深度集成也变得愈发重要。

Its future looks promising because:

它前景光明，原因在于：

1 Growing Pydantic ecosystem integration

Pydantic 生态系统的整合正在不断加强（Pydantic ecosystem integration)

2 Active development by the core Pydantic team

3 Focus on developer experience and production readiness

Pydantic 核心团队正在积极开发专注于提升开发者体验和产品在生产环境中的可用性

When to consider alternatives? If you need LangChain's vast integrations, crewAI's multi-agent capabilities, or Instructor's specialized instruction handling. But for most AI applications, PydanticAI provides everything you need with less complexity.

什么情况下应该考虑其他选择？如果你的应用需要 LangChain 强大的集成能力、crewAI 的多 AI 智能体功能，或是 Instructor 专门的指令处理能力。但对于大多数 AI 应用来说，PydanticAI 已经足够满足需求，并且更加简洁。

PydanticAI brings the "FastAPI feeling" to AI development — and that's exactly what this space needs. It's not just about writing less code; it's about writing better, more maintainable AI applications.

PydanticAI 将「FastAPI 式的体验」带到了 AI 开发领域 —— 而这正是该领域所亟需的。它不仅仅是为了减少代码量，更是为了构建更优质、更易于维护的 AI 应用程序。

Note: PydanticAI is still in early development, but given the Pydantic team's track record, I'm confident in betting on its future. The framework is already showing what the future of AI development tools should look like.

注意：PydanticAI 仍处于早期开发阶段，但考虑到 Pydantic 团队的既往成就，我对它的未来充满信心。该框架已初步展现了未来 AI 开发工具的发展方向。

### PydanticAI Basics: A Quick Start Guide

PydanticAI 基础：快速入门指南

PydanticAI makes building AI agents feel as natural as writing regular Python code. Let's look at three core patterns that make it powerful yet simple to use.

PydanticAI 让构建 AI 智能体就像编写普通的 Python 代码一样自然。接下来，我们来看看 PydanticAI 强大且易用的三个核心模式。

I will keep this brief because, honestly, the PydanticAI documentation is among the best I have ever read. Generally, Pydantic projects feature excellent documentation with an engaging, informative, and enjoyable writing style. Therefore, the best way to gain more information is to consult the documentation directly. This article aims to go beyond the documentation and explore a creative real-world application of the framework.

我将尽量简短，因为坦率地说，PydanticAI 的文档是我读过的最佳文档之一。通常，Pydantic 项目的文档都非常出色，写作风格不仅引人入胜，而且信息丰富，读起来也赏心悦目。因此，要了解更多信息，最好的方法是直接查阅官方文档。本文的目的在于，在官方文档的基础上，进一步探讨该框架在现实世界中的创新应用。

Basic Agents

基础智能体

```py
agent = Agent('gemini-1.5-flash', system_prompt='Be concise.')
result = agent.run_sync('What is PydanticAI?')
```

At its simplest, an agent is just a wrapper around an LLM that handles the conversation flow. You choose your model, set a system prompt, and start chatting.

最简单的形式，一个智能体只是大语言模型（LLM）的一个外壳，它负责处理对话过程。你选择你的模型，设定系统指令，然后就可以开始聊天了。

Structured Outputs

结构化输出

```py
class WeatherInfo(BaseModel):
    temperature: float
    condition: str

weather_agent = Agent('gemini-1.5-flash', result_type=WeatherInfo)
```

Instead of parsing free text, PydanticAI guides the LLM to return structured data. Your IDE gets type hints, and you get guaranteed data structure.

PydanticAI 不解析自由文本，而是引导 LLM（Large Language Model）返回结构化数据。你的 IDE 会获得类型提示，并且你可以获得有保证的数据结构。

Tools

工具

```py
@agent.tool
async def get_temperature(city: str) -> float:
    """Fetch current temperature for a city."""
    return await weather_api.get(city)
```

Tools are functions your agent can call. They extend your agent's capabilities beyond conversation to real actions like API calls or data fetching.

工具是你的 AI 智能体可以调用的函数。它们将智能体的能力从对话扩展到例如 API 调用或获取数据等实际操作。

What's particularly clever about PydanticAI's tool system is how it handles function signatures. The framework automatically extracts parameters (except RunContext) to build the tool's schema, and even pulls parameter descriptions from your docstrings using griffe.

PydanticAI 的工具系统最巧妙之处在于它对函数签名的处理方式。这个系统会自动提取函数参数（除了 RunContext），以此构建工具的结构，它甚至能利用 griffe 从代码的文档注释（docstring）中提取参数的描述信息。

This intelligent parsing means your tools are not just functional — they're self-documenting. The LLM understands exactly how to use them because the documentation is built right into the schema. No more manually maintaining separate descriptions of your tools!

这种智能化的解析方式意味着你的工具不仅具备功能，还能自我生成文档。大语言模型（LLM）之所以能准确理解如何使用这些工具，是因为它们的文档直接嵌入在结构定义中。这样一来，你就不再需要手动维护工具的额外说明了。

What I love about PydanticAI is how these patterns compose naturally. Start with a basic agent, add structure when you need clean data, and sprinkle in tools when you need real-world interactions. It grows with your needs! 

我喜欢 PydanticAI 的一点是，这些模式能够如此自然地组合在一起。你可以从一个基础的 AI 智能体开始，当需要清晰的数据时，再添加结构化的处理方式，而当需要与现实世界互动时，则可以加入各种工具。它会随着你的需求而不断成长！

This foundation is all you need to start building powerful AI agents. In our Airflow example coming up, we'll see how these patterns work together in a real application.

有了这个基础，你就可以开始构建强大的 AI 智能体了。在接下来的 Airflow 示例中，我们将看到这些模式如何在实际应用中协同工作。

### Mirror, Mirror on the Wall, What's the DAG Status After All?

魔镜魔镜，墙上的镜子，有向无环图（DAG）的状态究竟如何？

The complete code for this tutorial is available on GitHub. While we'll walk through the key components here, feel free to clone the repository to follow along:

本教程的完整代码已上传至 GitHub。虽然我们会在本文中讲解关键部分，您也可以克隆存储库以便进一步学习：

git clone git@github.com:vojay-dev/pydantic-airflow-agent.git

Bear in mind that PydanticAI is under heavy development, which is great, but it also means that details of this demo project might change in the future. However, it will definitely help you gain a good understanding of the basic principles and inspire your own PydanticAI project.

请注意，PydanticAI 目前正处于快速开发阶段，这当然是好事，但也意味着这个演示项目的具体细节未来可能会有所变动。不过，这个项目肯定能帮助你深入理解其基本原理，并为你的 PydanticAI 项目提供灵感。

With this project, we aim to go beyond the documentation and basic examples. Let's create an AI agent that can interact with Airflow via the Airflow REST API. You will be able to ask it about the status of a DAG without needing to specify an exact DAG ID. Simply describe the DAG, and the agent will identify the most relevant one by retrieving all DAGs from the API. It will then fetch the status of the selected DAG and return the information in a structured format.

[Airflow REST API](https://airflow.apache.org/docs/apache-airflow/stable/stable-rest-api-ref.html)

在这个项目中，我们的目标不仅仅是阅读文档和运行简单的示例。我们来创建一个 AI 智能体（AI Agent），它可以通过 Airflow REST API 与 Airflow 交互。你无需提供确切的 DAG ID，只需描述一下你关心的 DAG，这个 AI 智能体就能通过 API 获取所有 DAG 信息，并从中找到最匹配的那个。接着，它会抓取这个 DAG 的状态，并以结构化的形式返回给你。

For simplicity, we are using a local Airflow environment with Docker and Astro CLI (install via brew install astro), which is an effective way to start Airflow projects. We will integrate our PydanticAI agent and Airflow setup within the same project for ease of use. Typically, these would be two separate components.

简单来说，我们使用本地 Airflow 环境，它通过 Docker 和 Astro CLI（通过 `brew install astro` 安装）进行配置，这是一种启动 Airflow 项目的有效方式。为了方便起见，我们将 PydanticAI 智能体和 Airflow 的配置整合到同一个项目中。通常情况下，这两个组件是独立存在的。

We are using the latest version of Airflow, 2.10.4, as of the time of writing this article. If you are reading this after the release of Airflow 3, that's amazing! I can't wait for the new UI and other great features. However, this also means that things may have changed significantly. Still, you should be able to get an idea of how to adapt to it.

在撰写本文时，我们使用的是 Airflow 的最新版本 2.10.4。如果您在 Airflow 3 发布之后阅读本文，那真是太好了！我非常期待新的用户界面和其他优秀的功能。不过，这也意味着情况可能已经发生了显著变化。尽管如此，您应该仍然能够从中了解如何进行调整。

First, let's set up the project using Poetry and install the required dependencies, starting with PydanticAI and then creating an Airflow environment via Astro CLI.

首先，我们使用 Poetry 来搭建项目，并安装必要的依赖，首先安装 PydanticAI，接着使用 Astro CLI 创建 Airflow 环境。

poetry new pydantic-airflow-agent
cd pydantic-airflow-agent
poetry add pydantic-ai
poetry add colorlog

Before adding the Airflow dependency, change the Python requirement in pyproject.toml:

在添加 Airflow 依赖之前，请先修改 pyproject.toml 文件中的 Python 版本要求：

python = ">=3.12,<3.13"

Now, add the Airflow dependency:

接下来，添加 Airflow 依赖：

poetry add apache-airflow

Finally, spin up the local Airflow environment:

最后，搭建本地 Airflow 环境：

astro dev init # confirm to create the project in a non-empty directory
astro dev start

Implement some sample DAGs

创建一些示例 DAG。

The focus is the PydanticAI driven AI agent, however, without some DAGs we have nothing to interact with. We go as minimal as possible and simply add to DAGs doing nothing essentially.

核心是基于 PydanticAI 的 AI 智能体，但是，如果没有有向无环图（DAG），我们就无法进行任何交互。我们尽量保持最简设计，只是简单地将元素添加到一些基本上不执行任何操作的有向无环图中。

```py
import pendulum  
from airflow.decorators import dag, task  
from airflow.operators.smooth import SmoothOperator  
  
start_date = pendulum.datetime(2024, 12, 1, tz="UTC")  
  
@dag(schedule='@daily', start_date=start_date)  
def payment_report():  
    SmoothOperator(task_id='some_task')  
  
@dag(schedule='@daily', start_date=start_date)  
def customer_profile():  
    SmoothOperator(task_id='some_task')  
  
payment_report()  
customer_profile()
```

If you don't know about SmoothOperator yet, check the logs for it in Airflow. It's a delightful little Easter egg that brings a smile to the faces of us Data Engineers.

如果你还不了解 SmoothOperator，请在 Airflow 日志中查找它。这是一个令人惊喜的小彩蛋，能让我们的数据工程师们会心一笑。

Local Airflow setup with two example DAGs, source: by author

本地 Airflow 环境搭建，包含两个示例 DAG，作者提供

Implement an Airflow AI agent with PydanticAI

利用 PydanticAI 构建 Airflow AI 智能体

Since we want to interact with Airflow through the Airflow REST API, we can derive some of the agent's dependencies from it. We need the base URI of our Airflow service, the port on which the API is running, and a username and password.

由于我们希望通过 Airflow REST API 与 Airflow 交互，我们可以从 Airflow REST API 获取一些 AI 智能体的依赖项。我们需要 Airflow 服务的根 URI、API 监听的端口以及用户名和密码。

We also expect our AI agent to respond with a structured object that represents the state of a DAG, including several interesting attributes. Let's define both the dependencies and the output model.

我们还期望我们的 AI 智能体以结构化的对象形式返回结果，这个对象用于表示有向无环图（DAG）的状态，其中包含一些值得关注的属性。下面我们来定义依赖关系和输出模型。

```py
@dataclass  
class Deps:  
    airflow_api_base_uri: str  
    airflow_api_port: int  
    airflow_api_user: str  
    airflow_api_pass: str  
  
class DAGStatus(BaseModel):  
    dag_id: str = Field(description='ID of the DAG')  
    dag_display_name: str = Field(description='Display name of the DAG')  
    is_paused: bool = Field(description='Whether the DAG is paused')  
    next_dag_run_data_interval_start: str = Field(description='Next DAG run data interval start')  
    next_dag_run_data_interval_end: str = Field(description='Next DAG run data interval end')  
    last_dag_run_id: str = Field(default='No DAG run', description='Last DAG run ID')  
    last_dag_run_state: str = Field(default='No DAG run', description='Last DAG run state')  
    total_dag_runs: int = Field(description='Total number of DAG runs')
```

With that, we can define our model and Agent. For this example, we use the latest Gemini 2.0 Flash model.

接下来，我们可以定义模型和 AI 智能体。在这个例子中，我们选用最新的 Gemini 2.0 Flash 模型。

Note: I experimented extensively with various models. Many models struggled to interact with tool functions in the correct order or to use the results for constructing the final structured output. Gemini 2.0 Flash provided the best results, but I also recommend trying other supported models. You can use models via Ollama, such as Mistral or Llama 3.3, both of which also support tool functions and structured output. However, for this demo, we will use the model that gave the best results. Ultimately, we want to have an agent we can trust. Would you fly on an airplane that only sometimes works?

注意：我曾广泛测试过各种模型。许多模型在按正确顺序与工具函数交互时遇到困难，或者难以利用结果构建最终的结构化输出。Gemini 2.0 Flash 表现最佳，但我也建议尝试其他支持的模型。您可以通过 Ollama 使用 Mistral 或 Llama 3.3 等模型，它们也都支持工具函数和结构化输出。不过，为了本次演示，我们将采用效果最好的模型。最终，我们希望拥有一个值得信赖的 AI 智能体。你会乘坐一架偶尔才正常工作的飞机吗？

```py
model = VertexAIModel(  
    model_name='gemini-2.0-flash-exp',  
    service_account_file='gcp-credentials.json'  
)  
  
airflow_agent = Agent(  
    model=model,  
    system_prompt=(  
        'You are an Airflow monitoring assistant. For each request:\n'  
        '1. Use `list_dags` first to get available DAGs\n'  
        '2. Match the user request to the most relevant DAG ID\n'  
        '3. Use `get_dag_status` to fetch the DAG status details'    ),  
    result_type=DAGStatus,  
    deps_type=Deps,  
    retries=2  
)
```

As you can see, I am quite strict and clear about how the agent should handle requests and interact with tool functions. This largely depends on the model you use. Depending on the use case, it can sometimes work well not to specify any tool functions explicitly in the system prompt.

可以看到，我对 AI 智能体如何处理请求以及如何与工具函数交互有着非常严格和清晰的要求。这在很大程度上取决于你所使用的模型。根据不同的应用场景，有时在系统提示中不明确指定任何工具函数也能达到很好的效果。

Next, let us add a tool function so that our AI agent can retrieve a list of DAGs. We will return the DAG IDs and display names, allowing the model to select the DAG that best fits the user's question.

接下来，我们添加一个工具函数，让我们的 AI 智能体能够获取 DAG 列表。我们将返回 DAG 的 ID 和显示名称，以便模型选择最符合用户问题的 DAG。

```py
@airflow_agent.tool
async def list_dags(ctx: RunContext[Deps]) -> str:
    """
    Get a list of all DAGs from the Airflow instance. Returns DAGs with their IDs and display names.
    """
    logger.info('Getting available DAGs...')
    uri = f'{ctx.deps.airflow_api_base_uri}:{ctx.deps.airflow_api_port}/api/v1/dags'
    auth = (ctx.deps.airflow_api_user, ctx.deps.airflow_api_pass)

    async with AsyncClient() as client:
        response = await client.get(uri, auth=auth)
        response.raise_for_status()

        dags_data = response.json()['dags']
        result = json.dumps([
            {'dag_id': dag['dag_id'], 'dag_display_name': dag['dag_display_name']} for dag in dags_data
        ])
        logger.debug(f'Available DAGs: {result}')
        return result
```

Each tool function receives the RunContext, which contains the previously defined dependencies. This allows us to easily connect to the Airflow API and fetch the necessary data.

每个工具函数都会接收一个 RunContext 对象，它包含了预先设定的依赖关系。这使得我们可以方便地与 Airflow API 交互，从而获取所需的数据。

Once the agent determines which DAG ID best fits the user's requests, it must retrieve the details about the DAG and its runs to compute the structured output, also known as the model class we defined earlier.

当 AI 智能体（AI Agent）确定哪个 DAG ID 最符合用户的请求时，它需要获取 DAG 及其运行的详细信息，以便计算结构化输出，也就是我们之前定义的模型类。

Therefore, let's add another tool function to obtain the details.

因此，我们还需要添加一个工具函数，以便获取更详尽的信息。

```py
@airflow_agent.tool
async def get_dag_status(ctx: RunContext[Deps], dag_id: str) -> str:
    """
    Get detailed status information for a specific DAG by DAG ID.
    """
    logger.info(f'Getting status for DAG with ID: {dag_id}')
    base_url = f'{ctx.deps.airflow_api_base_uri}:{ctx.deps.airflow_api_port}/api/v1'
    auth = (ctx.deps.airflow_api_user, ctx.deps.airflow_api_pass)

    try:
        async with AsyncClient() as client:
            dag_response = await client.get(f'{base_url}/dags/{dag_id}', auth=auth)
            dag_response.raise_for_status()

            runs_response = await client.get(
                f'{base_url}/dags/{dag_id}/dagRuns',
                auth=auth,
                params={'order_by': '-execution_date', 'limit': 1}
            )
            runs_response.raise_for_status()

            result = {
                'dag_data': dag_response.json(),
                'runs_data': runs_response.json()
            }

            logger.debug(f'DAG status: {json.dumps(result)}')
            return json.dumps(result)

    except httpx.HTTPStatusError as e:
        if e.response.status_code == 404:
            return f'DAG with ID {dag_id} not found'
        raise
```

With that, we have all tools we need and can run the agent as follows.

至此，我们已经具备了所有必需的工具，可以开始运行 AI 智能体了，具体步骤如下。

```py
async def main():
    deps = Deps(
        airflow_api_base_uri='http://localhost',
        airflow_api_port=8080,
        airflow_api_user='admin',
        airflow_api_pass='admin'
    )

    user_request = 'What is the status of the DAG for our daily payment report?'
    result = await airflow_agent.run(user_request, deps=deps)
    pprint(result.data)

if __name__ == "__main__":
    asyncio.run(main())
```

You might notice that many operations in PydanticAI use async and await. This isn't just a random choice - it's a powerful feature that makes our applications more efficient, especially when dealing with I/O operations like API calls or model interactions.

你可能已经注意到，PydanticAI 中的许多操作都使用了 async 和 await。这并非随意之举，而是一项强大的功能，能够提高应用程序的效率，尤其是在处理诸如 API 调用或模型交互等 I/O 操作时。

Think of async like being an expert multitasker. When you're cooking, you don't wait idly by the stove for water to boil — you prep other ingredients while waiting. That's what async does for our code. When our agent makes an API call or waits for an LLM response, instead of blocking everything else, it can handle other tasks — like processing another request or updating logs. This is particularly valuable in production environments where efficiency matters.

可以将异步（async）想象成一位高效的「多面手」。就像做饭时，你不会傻等水开，而是会利用等待的时间准备其他食材。异步在代码中的作用也是如此。当我们的 AI 智能体（AI Agent）发起 API 调用或等待大语言模型（LLM）的回复时，它不会停滞不前，而是可以同时处理其他任务，例如响应新的请求或更新日志。这在追求效率的生产环境中显得尤为重要。

Let's combine everything before we dive into the demo. Here is the complete Airflow AI agent code with PydanticAI.

在开始演示之前，我们先将所有内容整合一下。这里是使用 PydanticAI 实现的完整 Airflow AI 智能体代码。

```py
import asyncio
import json
import logging
from dataclasses import dataclass
from devtools import pprint

import colorlog
import httpx
from httpx import AsyncClient
from pydantic import BaseModel, Field
from pydantic_ai import Agent, RunContext
from pydantic_ai.models.vertexai import VertexAIModel

log_format = '%(log_color)s%(asctime)s [%(levelname)s] %(reset)s%(purple)s[%(name)s] %(reset)s%(blue)s%(message)s'
handler = colorlog.StreamHandler()
handler.setFormatter(colorlog.ColoredFormatter(log_format))
logging.basicConfig(level=logging.INFO, handlers=[handler])

logger = logging.getLogger(__name__)

@dataclass
class Deps:
    airflow_api_base_uri: str
    airflow_api_port: int
    airflow_api_user: str
    airflow_api_pass: str

class DAGStatus(BaseModel):
    dag_id: str = Field(description='ID of the DAG')
    dag_display_name: str = Field(description='Display name of the DAG')
    is_paused: bool = Field(description='Whether the DAG is paused')
    next_dag_run_data_interval_start: str = Field(description='Next DAG run data interval start')
    next_dag_run_data_interval_end: str = Field(description='Next DAG run data interval end')
    last_dag_run_id: str = Field(default='No DAG run', description='Last DAG run ID')
    last_dag_run_state: str = Field(default='No DAG run', description='Last DAG run state')
    total_dag_runs: int = Field(description='Total number of DAG runs')

model = VertexAIModel(
    model_name='gemini-2.0-flash-exp',
    service_account_file='gcp-credentials.json'
)

airflow_agent = Agent(
    model=model,
    system_prompt=(
        'You are an Airflow monitoring assistant. For each request:\n'
        '1. Use `list_dags` first to get available DAGs\n'
        '2. Match the user request to the most relevant DAG ID\n'
        '3. Use `get_dag_status` to fetch the DAG status details'
    ),
    result_type=DAGStatus,
    deps_type=Deps,
    retries=2
)

@airflow_agent.tool
async def list_dags(ctx: RunContext[Deps]) -> str:
    """
    Get a list of all DAGs from the Airflow instance. Returns DAGs with their IDs and display names.
    """
    logger.info('Getting available DAGs...')
    uri = f'{ctx.deps.airflow_api_base_uri}:{ctx.deps.airflow_api_port}/api/v1/dags'
    auth = (ctx.deps.airflow_api_user, ctx.deps.airflow_api_pass)

    async with AsyncClient() as client:
        response = await client.get(uri, auth=auth)
        response.raise_for_status()

        dags_data = response.json()['dags']
        result = json.dumps([
            {'dag_id': dag['dag_id'], 'dag_display_name': dag['dag_display_name']} for dag in dags_data
        ])
        logger.debug(f'Available DAGs: {result}')
        return result

@airflow_agent.tool
async def get_dag_status(ctx: RunContext[Deps], dag_id: str) -> str:
    """
    Get detailed status information for a specific DAG by DAG ID.
    """
    logger.info(f'Getting status for DAG with ID: {dag_id}')
    base_url = f'{ctx.deps.airflow_api_base_uri}:{ctx.deps.airflow_api_port}/api/v1'
    auth = (ctx.deps.airflow_api_user, ctx.deps.airflow_api_pass)

    try:
        async with AsyncClient() as client:
            dag_response = await client.get(f'{base_url}/dags/{dag_id}', auth=auth)
            dag_response.raise_for_status()

            runs_response = await client.get(
                f'{base_url}/dags/{dag_id}/dagRuns',
                auth=auth,
                params={'order_by': '-execution_date', 'limit': 1}
            )
            runs_response.raise_for_status()

            result = {
                'dag_data': dag_response.json(),
                'runs_data': runs_response.json()
            }

            logger.debug(f'DAG status: {json.dumps(result)}')
            return json.dumps(result)

    except httpx.HTTPStatusError as e:
        if e.response.status_code == 404:
            return f'DAG with ID {dag_id} not found'
        raise

async def main():
    deps = Deps(
        airflow_api_base_uri='http://localhost',
        airflow_api_port=8080,
        airflow_api_user='admin',
        airflow_api_pass='admin'
    )

    user_request = 'What is the status of the DAG for our daily payment report?'
    result = await airflow_agent.run(user_request, deps=deps)
    pprint(result.data)

if __name__ == "__main__":
    asyncio.run(main())
```

What I found essential is having high transparency regarding how the agent makes tool and LLM calls during development. In the example above, we use logging. However, I highly recommend checking out the Logfire integration.

在开发过程中，我发现至关重要的是，要高度透明地了解智能体如何调用工具和大语言模型（LLM）。在前面的示例中，我们使用了日志记录。不过，我强烈建议你了解一下 Logfire 的整合方案。

Demo

Time to let the magic happen. Let's run our agent with the following user question:

现在，是时候见证奇迹了。让我们用以下用户问题运行我们的 AI 智能体（AI Agent)：

What is the status of the DAG for our daily payment report?

我们的每日付款报告的 DAG 状态是什么？

Remember, we have two DAGs defined: payment_report and customer_profile. In the question above, we do not use the exact DAG IDs; the agent has to determine them on its own. Let's see how it handles our request by examining the output.

需要注意的是，我们定义了两个 DAG，分别是 payment_report 和 customer_profile 。在上面的问题中，我们没有直接使用 DAG 的 ID，而是需要 AI 智能体自行判断。接下来，让我们通过检查输出来看看它是如何处理这个请求的。

(.venv) ~/projects/pydantic-airflow-agent
poetry run python pydantic_airflow_agent/agent.py
2024-12-23 14:49:05,127 [INFO] [httpx] HTTP Request: POST https://us-central1-aiplatform.googleapis.com/v1/projects/vojay-329716/locations/us-central1/publishers/google/models/gemini-2.0-flash-exp:generateContent "HTTP/1.1 200 OK"
2024-12-23 14:49:05,132 [INFO] [__main__] Getting available DAGs...
2024-12-23 14:49:05,241 [INFO] [httpx] HTTP Request: GET http://localhost:8080/api/v1/dags "HTTP/1.1 200 OK"
2024-12-23 14:49:06,640 [INFO] [httpx] HTTP Request: POST https://us-central1-aiplatform.googleapis.com/v1/projects/vojay-329716/locations/us-central1/publishers/google/models/gemini-2.0-flash-exp:generateContent "HTTP/1.1 200 OK"
2024-12-23 14:49:06,643 [INFO] [__main__] Getting status for DAG with ID: payment_report
2024-12-23 14:49:06,721 [INFO] [httpx] HTTP Request: GET http://localhost:8080/api/v1/dags/payment_report "HTTP/1.1 200 OK"
2024-12-23 14:49:06,798 [INFO] [httpx] HTTP Request: GET http://localhost:8080/api/v1/dags/payment_report/dagRuns?order_by=-execution_date&limit=1 "HTTP/1.1 200 OK"
2024-12-23 14:49:09,915 [INFO] [httpx] HTTP Request: POST https://us-central1-aiplatform.googleapis.com/v1/projects/vojay-329716/locations/us-central1/publishers/google/models/gemini-2.0-flash-exp:generateContent "HTTP/1.1 200 OK"

DAGStatus(
    dag_id='payment_report',
    dag_display_name='payment_report',
    is_paused=False,
    next_dag_run_data_interval_start='2024-12-23T00:00:00+00:00',
    next_dag_run_data_interval_end='2024-12-24T00:00:00+00:00',
    last_dag_run_id='scheduled__2024-12-22T00:00:00+00:00',
    last_dag_run_state='success',
    total_dag_runs=22,
)

As you can see, it started by fetching the available DAGs:

可以看到，它首先读取可用的 DAG（Directed Acyclic Graph，有向无环图）：

2024-12-23 14:49:05,132 [INFO] [__main__] Getting available DAGs...\

It then selected the DAG which fits best to the user input, and used the other tool function to get the details:

2024-12-23 14:49:06,643 [INFO] [__main__] Getting status for DAG with ID: payment_report

And finally used structured output to return a DAGStatus instance.

最后使用结构化输出返回一个 DAGStatus 实例。

Fig: The Airflow AI agent powered by PydanticAI in action, source: by author

Honestly, the first time I ran this successfully, it blew me away. This powerful prototype combines simplicity with type-safe integration, and I was immediately hooked. I began to think about how to generate value with such an agent. For example, imagine someone asks in the data team's Slack channel why a specific report did not update. Such an agent could autonomously find the related DAG and engage in a conversation with the user while the Data Engineering team enjoys their coffee in peace. 

说实话，当我第一次成功运行这个程序时，它给我留下了深刻的印象。这个强大的原型兼具简洁性和类型安全的集成特性，我立刻就被它吸引了。我开始思考如何利用这样的智能体来创造价值。例如，设想一下，如果有人在数据团队的 Slack 频道里询问为什么某个特定的报告没有更新。这样的智能体就可以自动查找相关的 DAG，并与用户展开对话，与此同时，数据工程团队则可以安心地享受他们的咖啡时光。

### From Blind Flight to Clear Skies

从盲飞到晴空

This article has shown that building production-grade AI applications doesn't have to feel like navigating through a storm. With the right tools and frameworks, it can be as straightforward as modern air travel — powerful, yet controlled and reliable.

本文阐述了，构建生产级 AI 应用程序不必像在暴风雨中摸索。有了合适的工具和框架，它就可以像现代航空旅行一样顺畅 —— 强大、可控且可靠。

The landscape of AI development is evolving rapidly, but frameworks like PydanticAI give us a steady foundation to build upon. Like modern aviation continues to advance while maintaining its core principles of safety and reliability, PydanticAI sets the stage for future innovations without sacrificing stability.

人工智能（AI）的发展日新月异，但像 PydanticAI 这样的框架为我们提供了坚实的基础。正如现代航空在坚守安全和可靠核心原则的同时不断进步，PydanticAI 也为未来的创新奠定了基础，同时保证了稳定性。

Keep an eye on the PydanticAI project. With the amazing team behind it and the framework's elegant design, I believe we are only seeing the beginning of its potential.

请密切关注 PydanticAI 项目。它背后有一个出色的团队，而且框架设计精巧，我相信我们现在看到的仅仅是它潜力的冰山一角。

Whether you're building AI agents for Airflow monitoring, customer support, or any other use case, remember: you don't have to fly blind anymore. The instruments are here, the controls are intuitive, and the skies are clear for takeoff.

无论你是为 Airflow 监控、客户支持或任何其他用例构建 AI 智能体，请记住：你不再需要摸黑探索。各种工具已经就绪，操作简单直观，一切准备就绪，可以开始行动了。

Now, if you'll excuse me, I have some DAGs to chat with!

现在，如果你不介意的话，我得去和一些 DAG（Directed Acyclic Graph，有向无环图）聊聊了！

## 原文

Talk to Airflow — Build an AI Agent Using PydanticAI and Gemini 2.0
Create an AI agent with PydanticAI to interact with Airflow DAGs
Volker Janz

Published in Data Engineer Things

Dec 24, 2024


A Journey from Chaos to Control
In the pioneering days of aviation, pilots flew through clouds with little more than basic instruments and raw instinct. Each flight was a dance between human judgment and mechanical power, relying heavily on experience and intuition for success. A slight miscalculation or unexpected weather change could spell disaster. They used amazing technology with little control over it.

When I first started integrating LLMs into production systems, I felt like one of those early pilots — commanding immense power with minimal instrumentation. Every deployment felt like a leap of faith.


AI agents getting ready for Airflow, source: generated with Adobe Firefly
The landscape of AI development today mirrors those early aviation challenges. We have incredibly powerful models like Gemini 2.0 at our disposal — capable of understanding context, generating human-like responses, and processing complex instructions. Yet, utilizing this power for production-grade applications often feels like flying through a storm without proper navigation tools.

But just as modern aviation evolved from risky adventures to reliable transportation through proper instrumentation and control systems, AI development is undergoing its own transformation toward agents. Unlike traditional AI, which simply responds to queries, agents actively engage with their environment. They make decisions, use tools, and execute tasks on your behalf. Modern AI agents, powered by LLMs like Gemini, understand natural language instructions, break down complex tasks into smaller steps, and provide structured output and monitoring.

This is where PydanticAI appears at the sky. Built by the team behind Pydantic — the same foundation that powers numerous famous projects — it’s a framework designed for modern AI development that brings control and reliability to agent systems.

Think of PydanticAI as your aircraft’s modern cockpit — combining assistant systems, engine controls, and instrumentation panels into one coherent interface. It provides clear readings, predictable controls, and most importantly, the confidence to navigate through complex scenarios. It brings structure to chaos.

In this article, we’ll put PydanticAI to the test by building an AI agent that interacts with Apache Airflow. We’ll create a system that can understand natural language queries about your workflows, fetch real-time status updates, and respond with structured, reliable data. No more flying blind through your DAG operations.

🚀 Want to jump straight into the code? Check out the project on GitHub:
https://github.com/vojay-dev/pydantic-airflow-agent

– A Journey from Chaos to Control
– Why PydanticAI? The FastAPI Feeling for AI Development
−− The Current Landscape
−− PydanticAI Simplicity
−− The Future of PydanticAI
– PydanticAI Basics: A Quick Start Guide
– Mirror, Mirror on the Wall, What’s the DAG Status After All?
−− Implement some sample DAGs
−− Implement an Airflow AI agent with PydanticAI
−− Demo
– From Blind Flight to Clear Skies

Why PydanticAI? The FastAPI Feeling for AI Development
Building production-grade AI applications shouldn’t feel like solving a puzzle. Yet, when I first explored the landscape of AI frameworks, that’s exactly what it felt like. Let me share why PydanticAI is becoming my go-to choice for modern AI development.

The Current Landscape
The AI framework ecosystem is rich with options:

LangChain: Comprehensive but complex, offering numerous integrations and features.
crewAI: Specialized in multi-agent orchestration, great for complex agent interactions.
Instructor: Focused on structured outputs and instruction following.
Each has its strengths, but they often come with significant complexity and steep learning curves.

PydanticAI Simplicity
from pydantic_ai import Agent

agent = Agent('gemini-1.5-flash', system_prompt='Be concise.')
result = agent.run_sync('Why choose PydanticAI?')
When I first saw the PydanticAI examples, it reminded me of my first FastAPI experience — clean, intuitive, and just right.

What sets PydanticAI apart:

Built by the Pydantic Team

Deep integration with Pydantic’s ecosystem
Type safety that actually helps development
Familiar patterns for FastAPI developers
Production-Ready Design

Model-agnostic (OpenAI, Anthropic, Gemini, Ollama)
Built-in dependency injection for testing
Seamless Logfire integration for real-time monitoring
Clean, Maintainable Code

Minimal boilerplate
Strong type checking
Intuitive error messages
Note: The integration with Logfire is simple yet elegant, allowing for a detailed understanding of the flow of agents. There are impressive examples on the official PydanticAI page, but I haven’t tried them yet. I highly recommend checking it out if you want to explore the framework beyond this article. If you do, feel free to let me know how it goes. 😉

The Future of PydanticAI
The real power of PydanticAI lies in its alignment with modern Python development practices. As Pydantic continues to be the backbone of major Python frameworks and AI libraries, PydanticAI’s tight integration becomes increasingly valuable.

Its future looks promising because:

Growing Pydantic ecosystem integration
Active development by the core Pydantic team
Focus on developer experience and production readiness
When to consider alternatives? If you need LangChain’s vast integrations, crewAI’s multi-agent capabilities, or Instructor’s specialized instruction handling. But for most AI applications, PydanticAI provides everything you need with less complexity.

PydanticAI brings the “FastAPI feeling” to AI development — and that’s exactly what this space needs. It’s not just about writing less code; it’s about writing better, more maintainable AI applications.

Note: PydanticAI is still in early development, but given the Pydantic team’s track record, I’m confident in betting on its future. The framework is already showing what the future of AI development tools should look like.

PydanticAI Basics: A Quick Start Guide
PydanticAI makes building AI agents feel as natural as writing regular Python code. Let’s look at three core patterns that make it powerful yet simple to use.

I will keep this brief because, honestly, the PydanticAI documentation is among the best I have ever read. Generally, Pydantic projects feature excellent documentation with an engaging, informative, and enjoyable writing style. Therefore, the best way to gain more information is to consult the documentation directly. This article aims to go beyond the documentation and explore a creative real-world application of the framework.

Basic Agents

agent = Agent('gemini-1.5-flash', system_prompt='Be concise.')
result = agent.run_sync('What is PydanticAI?')
At its simplest, an agent is just a wrapper around an LLM that handles the conversation flow. You choose your model, set a system prompt, and start chatting.

Structured Outputs

class WeatherInfo(BaseModel):
    temperature: float
    condition: str

weather_agent = Agent('gemini-1.5-flash', result_type=WeatherInfo)
Instead of parsing free text, PydanticAI guides the LLM to return structured data. Your IDE gets type hints, and you get guaranteed data structure.

Tools

@agent.tool
async def get_temperature(city: str) -> float:
    """Fetch current temperature for a city."""
    return await weather_api.get(city)
Tools are functions your agent can call. They extend your agent’s capabilities beyond conversation to real actions like API calls or data fetching.

What’s particularly clever about PydanticAI’s tool system is how it handles function signatures. The framework automatically extracts parameters (except RunContext) to build the tool's schema, and even pulls parameter descriptions from your docstrings using griffe.

This intelligent parsing means your tools are not just functional — they’re self-documenting. The LLM understands exactly how to use them because the documentation is built right into the schema. No more manually maintaining separate descriptions of your tools!

What I love about PydanticAI is how these patterns compose naturally. Start with a basic agent, add structure when you need clean data, and sprinkle in tools when you need real-world interactions. It grows with your needs! 🛠️

This foundation is all you need to start building powerful AI agents. In our Airflow example coming up, we’ll see how these patterns work together in a real application.

Mirror, Mirror on the Wall, What’s the DAG Status After All?
The complete code for this tutorial is available on GitHub. While we’ll walk through the key components here, feel free to clone the repository to follow along:

git clone git@github.com:vojay-dev/pydantic-airflow-agent.git
Bear in mind that PydanticAI is under heavy development, which is great, but it also means that details of this demo project might change in the future. However, it will definitely help you gain a good understanding of the basic principles and inspire your own PydanticAI project.

With this project, we aim to go beyond the documentation and basic examples. Let’s create an AI agent that can interact with Airflow via the Airflow REST API. You will be able to ask it about the status of a DAG without needing to specify an exact DAG ID. Simply describe the DAG, and the agent will identify the most relevant one by retrieving all DAGs from the API. It will then fetch the status of the selected DAG and return the information in a structured format.

For simplicity, we are using a local Airflow environment with Docker and Astro CLI (install via brew install astro), which is an effective way to start Airflow projects. We will integrate our PydanticAI agent and Airflow setup within the same project for ease of use. Typically, these would be two separate components.

We are using the latest version of Airflow, 2.10.4, as of the time of writing this article. If you are reading this after the release of Airflow 3, that’s amazing! I can’t wait for the new UI and other great features. However, this also means that things may have changed significantly. Still, you should be able to get an idea of how to adapt to it.

First, let’s set up the project using Poetry and install the required dependencies, starting with PydanticAI and then creating an Airflow environment via Astro CLI.

poetry new pydantic-airflow-agent
cd pydantic-airflow-agent
poetry add pydantic-ai
poetry add colorlog
Before adding the Airflow dependency, change the Python requirement in pyproject.toml:

python = ">=3.12,<3.13"
Now, add the Airflow dependency:

poetry add apache-airflow
Finally, spin up the local Airflow environment:

astro dev init # confirm to create the project in a non-empty directory
astro dev start
Implement some sample DAGs
The focus is the PydanticAI driven AI agent, however, without some DAGs we have nothing to interact with. We go as minimal as possible and simply add to DAGs doing nothing essentially.

import pendulum  
from airflow.decorators import dag, task  
from airflow.operators.smooth import SmoothOperator  
  
start_date = pendulum.datetime(2024, 12, 1, tz="UTC")  
  
@dag(schedule='@daily', start_date=start_date)  
def payment_report():  
    SmoothOperator(task_id='some_task')  
  
@dag(schedule='@daily', start_date=start_date)  
def customer_profile():  
    SmoothOperator(task_id='some_task')  
  
payment_report()  
customer_profile()
If you don’t know about SmoothOperator yet, check the logs for it in Airflow. It's a delightful little Easter egg that brings a smile to the faces of us Data Engineers.


Local Airflow setup with two example DAGs, source: by author
Implement an Airflow AI agent with PydanticAI
Since we want to interact with Airflow through the Airflow REST API, we can derive some of the agent’s dependencies from it. We need the base URI of our Airflow service, the port on which the API is running, and a username and password.

We also expect our AI agent to respond with a structured object that represents the state of a DAG, including several interesting attributes. Let’s define both the dependencies and the output model.

@dataclass  
class Deps:  
    airflow_api_base_uri: str  
    airflow_api_port: int  
    airflow_api_user: str  
    airflow_api_pass: str  
  
class DAGStatus(BaseModel):  
    dag_id: str = Field(description='ID of the DAG')  
    dag_display_name: str = Field(description='Display name of the DAG')  
    is_paused: bool = Field(description='Whether the DAG is paused')  
    next_dag_run_data_interval_start: str = Field(description='Next DAG run data interval start')  
    next_dag_run_data_interval_end: str = Field(description='Next DAG run data interval end')  
    last_dag_run_id: str = Field(default='No DAG run', description='Last DAG run ID')  
    last_dag_run_state: str = Field(default='No DAG run', description='Last DAG run state')  
    total_dag_runs: int = Field(description='Total number of DAG runs')
With that, we can define our model and Agent. For this example, we use the latest Gemini 2.0 Flash model.

Note: I experimented extensively with various models. Many models struggled to interact with tool functions in the correct order or to use the results for constructing the final structured output. Gemini 2.0 Flash provided the best results, but I also recommend trying other supported models. You can use models via Ollama, such as Mistral or Llama 3.3, both of which also support tool functions and structured output. However, for this demo, we will use the model that gave the best results. Ultimately, we want to have an agent we can trust. Would you fly on an airplane that only sometimes works?

model = VertexAIModel(  
    model_name='gemini-2.0-flash-exp',  
    service_account_file='gcp-credentials.json'  
)  
  
airflow_agent = Agent(  
    model=model,  
    system_prompt=(  
        'You are an Airflow monitoring assistant. For each request:\n'  
        '1. Use `list_dags` first to get available DAGs\n'  
        '2. Match the user request to the most relevant DAG ID\n'  
        '3. Use `get_dag_status` to fetch the DAG status details'    ),  
    result_type=DAGStatus,  
    deps_type=Deps,  
    retries=2  
)
As you can see, I am quite strict and clear about how the agent should handle requests and interact with tool functions. This largely depends on the model you use. Depending on the use case, it can sometimes work well not to specify any tool functions explicitly in the system prompt.

Next, let us add a tool function so that our AI agent can retrieve a list of DAGs. We will return the DAG IDs and display names, allowing the model to select the DAG that best fits the user’s question.

@airflow_agent.tool
async def list_dags(ctx: RunContext[Deps]) -> str:
    """
    Get a list of all DAGs from the Airflow instance. Returns DAGs with their IDs and display names.
    """
    logger.info('Getting available DAGs...')
    uri = f'{ctx.deps.airflow_api_base_uri}:{ctx.deps.airflow_api_port}/api/v1/dags'
    auth = (ctx.deps.airflow_api_user, ctx.deps.airflow_api_pass)

    async with AsyncClient() as client:
        response = await client.get(uri, auth=auth)
        response.raise_for_status()

        dags_data = response.json()['dags']
        result = json.dumps([
            {'dag_id': dag['dag_id'], 'dag_display_name': dag['dag_display_name']} for dag in dags_data
        ])
        logger.debug(f'Available DAGs: {result}')
        return result
Each tool function receives the RunContext, which contains the previously defined dependencies. This allows us to easily connect to the Airflow API and fetch the necessary data.

Once the agent determines which DAG ID best fits the user’s requests, it must retrieve the details about the DAG and its runs to compute the structured output, also known as the model class we defined earlier.

Therefore, let’s add another tool function to obtain the details.

@airflow_agent.tool
async def get_dag_status(ctx: RunContext[Deps], dag_id: str) -> str:
    """
    Get detailed status information for a specific DAG by DAG ID.
    """
    logger.info(f'Getting status for DAG with ID: {dag_id}')
    base_url = f'{ctx.deps.airflow_api_base_uri}:{ctx.deps.airflow_api_port}/api/v1'
    auth = (ctx.deps.airflow_api_user, ctx.deps.airflow_api_pass)

    try:
        async with AsyncClient() as client:
            dag_response = await client.get(f'{base_url}/dags/{dag_id}', auth=auth)
            dag_response.raise_for_status()

            runs_response = await client.get(
                f'{base_url}/dags/{dag_id}/dagRuns',
                auth=auth,
                params={'order_by': '-execution_date', 'limit': 1}
            )
            runs_response.raise_for_status()

            result = {
                'dag_data': dag_response.json(),
                'runs_data': runs_response.json()
            }

            logger.debug(f'DAG status: {json.dumps(result)}')
            return json.dumps(result)

    except httpx.HTTPStatusError as e:
        if e.response.status_code == 404:
            return f'DAG with ID {dag_id} not found'
        raise
With that, we have all tools we need and can run the agent as follows.

async def main():
    deps = Deps(
        airflow_api_base_uri='http://localhost',
        airflow_api_port=8080,
        airflow_api_user='admin',
        airflow_api_pass='admin'
    )

    user_request = 'What is the status of the DAG for our daily payment report?'
    result = await airflow_agent.run(user_request, deps=deps)
    pprint(result.data)

if __name__ == "__main__":
    asyncio.run(main())
You might notice that many operations in PydanticAI use async and await. This isn't just a random choice - it's a powerful feature that makes our applications more efficient, especially when dealing with I/O operations like API calls or model interactions.

Think of async like being an expert multitasker. When you’re cooking, you don’t wait idly by the stove for water to boil — you prep other ingredients while waiting. That’s what async does for our code. When our agent makes an API call or waits for an LLM response, instead of blocking everything else, it can handle other tasks — like processing another request or updating logs. This is particularly valuable in production environments where efficiency matters.

Let’s combine everything before we dive into the demo. Here is the complete Airflow AI agent code with PydanticAI.

import asyncio
import json
import logging
from dataclasses import dataclass
from devtools import pprint

import colorlog
import httpx
from httpx import AsyncClient
from pydantic import BaseModel, Field
from pydantic_ai import Agent, RunContext
from pydantic_ai.models.vertexai import VertexAIModel

log_format = '%(log_color)s%(asctime)s [%(levelname)s] %(reset)s%(purple)s[%(name)s] %(reset)s%(blue)s%(message)s'
handler = colorlog.StreamHandler()
handler.setFormatter(colorlog.ColoredFormatter(log_format))
logging.basicConfig(level=logging.INFO, handlers=[handler])

logger = logging.getLogger(__name__)

@dataclass
class Deps:
    airflow_api_base_uri: str
    airflow_api_port: int
    airflow_api_user: str
    airflow_api_pass: str

class DAGStatus(BaseModel):
    dag_id: str = Field(description='ID of the DAG')
    dag_display_name: str = Field(description='Display name of the DAG')
    is_paused: bool = Field(description='Whether the DAG is paused')
    next_dag_run_data_interval_start: str = Field(description='Next DAG run data interval start')
    next_dag_run_data_interval_end: str = Field(description='Next DAG run data interval end')
    last_dag_run_id: str = Field(default='No DAG run', description='Last DAG run ID')
    last_dag_run_state: str = Field(default='No DAG run', description='Last DAG run state')
    total_dag_runs: int = Field(description='Total number of DAG runs')

model = VertexAIModel(
    model_name='gemini-2.0-flash-exp',
    service_account_file='gcp-credentials.json'
)

airflow_agent = Agent(
    model=model,
    system_prompt=(
        'You are an Airflow monitoring assistant. For each request:\n'
        '1. Use `list_dags` first to get available DAGs\n'
        '2. Match the user request to the most relevant DAG ID\n'
        '3. Use `get_dag_status` to fetch the DAG status details'
    ),
    result_type=DAGStatus,
    deps_type=Deps,
    retries=2
)

@airflow_agent.tool
async def list_dags(ctx: RunContext[Deps]) -> str:
    """
    Get a list of all DAGs from the Airflow instance. Returns DAGs with their IDs and display names.
    """
    logger.info('Getting available DAGs...')
    uri = f'{ctx.deps.airflow_api_base_uri}:{ctx.deps.airflow_api_port}/api/v1/dags'
    auth = (ctx.deps.airflow_api_user, ctx.deps.airflow_api_pass)

    async with AsyncClient() as client:
        response = await client.get(uri, auth=auth)
        response.raise_for_status()

        dags_data = response.json()['dags']
        result = json.dumps([
            {'dag_id': dag['dag_id'], 'dag_display_name': dag['dag_display_name']} for dag in dags_data
        ])
        logger.debug(f'Available DAGs: {result}')
        return result

@airflow_agent.tool
async def get_dag_status(ctx: RunContext[Deps], dag_id: str) -> str:
    """
    Get detailed status information for a specific DAG by DAG ID.
    """
    logger.info(f'Getting status for DAG with ID: {dag_id}')
    base_url = f'{ctx.deps.airflow_api_base_uri}:{ctx.deps.airflow_api_port}/api/v1'
    auth = (ctx.deps.airflow_api_user, ctx.deps.airflow_api_pass)

    try:
        async with AsyncClient() as client:
            dag_response = await client.get(f'{base_url}/dags/{dag_id}', auth=auth)
            dag_response.raise_for_status()

            runs_response = await client.get(
                f'{base_url}/dags/{dag_id}/dagRuns',
                auth=auth,
                params={'order_by': '-execution_date', 'limit': 1}
            )
            runs_response.raise_for_status()

            result = {
                'dag_data': dag_response.json(),
                'runs_data': runs_response.json()
            }

            logger.debug(f'DAG status: {json.dumps(result)}')
            return json.dumps(result)

    except httpx.HTTPStatusError as e:
        if e.response.status_code == 404:
            return f'DAG with ID {dag_id} not found'
        raise

async def main():
    deps = Deps(
        airflow_api_base_uri='http://localhost',
        airflow_api_port=8080,
        airflow_api_user='admin',
        airflow_api_pass='admin'
    )

    user_request = 'What is the status of the DAG for our daily payment report?'
    result = await airflow_agent.run(user_request, deps=deps)
    pprint(result.data)

if __name__ == "__main__":
    asyncio.run(main())
What I found essential is having high transparency regarding how the agent makes tool and LLM calls during development. In the example above, we use logging. However, I highly recommend checking out the Logfire integration.

Demo
Time to let the magic happen. Let’s run our agent with the following user question:

What is the status of the DAG for our daily payment report?

Remember, we have two DAGs defined: payment_report and customer_profile. In the question above, we do not use the exact DAG IDs; the agent has to determine them on its own. Let's see how it handles our request by examining the output.

(.venv) ~/projects/pydantic-airflow-agent
poetry run python pydantic_airflow_agent/agent.py
2024-12-23 14:49:05,127 [INFO] [httpx] HTTP Request: POST https://us-central1-aiplatform.googleapis.com/v1/projects/vojay-329716/locations/us-central1/publishers/google/models/gemini-2.0-flash-exp:generateContent "HTTP/1.1 200 OK"
2024-12-23 14:49:05,132 [INFO] [__main__] Getting available DAGs...
2024-12-23 14:49:05,241 [INFO] [httpx] HTTP Request: GET http://localhost:8080/api/v1/dags "HTTP/1.1 200 OK"
2024-12-23 14:49:06,640 [INFO] [httpx] HTTP Request: POST https://us-central1-aiplatform.googleapis.com/v1/projects/vojay-329716/locations/us-central1/publishers/google/models/gemini-2.0-flash-exp:generateContent "HTTP/1.1 200 OK"
2024-12-23 14:49:06,643 [INFO] [__main__] Getting status for DAG with ID: payment_report
2024-12-23 14:49:06,721 [INFO] [httpx] HTTP Request: GET http://localhost:8080/api/v1/dags/payment_report "HTTP/1.1 200 OK"
2024-12-23 14:49:06,798 [INFO] [httpx] HTTP Request: GET http://localhost:8080/api/v1/dags/payment_report/dagRuns?order_by=-execution_date&limit=1 "HTTP/1.1 200 OK"
2024-12-23 14:49:09,915 [INFO] [httpx] HTTP Request: POST https://us-central1-aiplatform.googleapis.com/v1/projects/vojay-329716/locations/us-central1/publishers/google/models/gemini-2.0-flash-exp:generateContent "HTTP/1.1 200 OK"

DAGStatus(
    dag_id='payment_report',
    dag_display_name='payment_report',
    is_paused=False,
    next_dag_run_data_interval_start='2024-12-23T00:00:00+00:00',
    next_dag_run_data_interval_end='2024-12-24T00:00:00+00:00',
    last_dag_run_id='scheduled__2024-12-22T00:00:00+00:00',
    last_dag_run_state='success',
    total_dag_runs=22,
)
As you can see, it started by fetching the available DAGs:

2024-12-23 14:49:05,132 [INFO] [__main__] Getting available DAGs...\
It then selected the DAG which fits best to the user input, and used the other tool function to get the details:

2024-12-23 14:49:06,643 [INFO] [__main__] Getting status for DAG with ID: payment_report
And finally used structured output to return a DAGStatus instance.


The Airflow AI agent powered by PydanticAI in action, source: by author
Honestly, the first time I ran this successfully, it blew me away. This powerful prototype combines simplicity with type-safe integration, and I was immediately hooked. I began to think about how to generate value with such an agent. For example, imagine someone asks in the data team’s Slack channel why a specific report did not update. Such an agent could autonomously find the related DAG and engage in a conversation with the user while the Data Engineering team enjoys their coffee in peace. ☕

From Blind Flight to Clear Skies
This article has shown that building production-grade AI applications doesn’t have to feel like navigating through a storm. With the right tools and frameworks, it can be as straightforward as modern air travel — powerful, yet controlled and reliable.

The landscape of AI development is evolving rapidly, but frameworks like PydanticAI give us a steady foundation to build upon. Like modern aviation continues to advance while maintaining its core principles of safety and reliability, PydanticAI sets the stage for future innovations without sacrificing stability.

Keep an eye on the PydanticAI project. With the amazing team behind it and the framework’s elegant design, I believe we are only seeing the beginning of its potential. 🚀

Whether you’re building AI agents for Airflow monitoring, customer support, or any other use case, remember: you don’t have to fly blind anymore. The instruments are here, the controls are intuitive, and the skies are clear for takeoff.

Now, if you’ll excuse me, I have some DAGs to chat with! 😉

Enjoyed this article? 🫶
👏 If you found value in this post, give it some claps (you can clap up to 50 times!)
💭 Share your thoughts in the comments below — I’d love to hear your perspective
✨ Highlight your favorite insights to bookmark them for later
🙏 Your engagement means the world to me and helps this content reach more readers.