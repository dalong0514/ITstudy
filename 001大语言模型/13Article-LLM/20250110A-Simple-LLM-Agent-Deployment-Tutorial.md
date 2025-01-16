## 20250110A-Simple-LLM-Agent-Deployment-Tutorial

[A Simple LLM Agent Deployment Tutorial | by Youness Mansar | Towards Data Science](https://towardsdatascience.com/a-simple-llm-agent-deployment-tutorial-b468d0a98bc5)

A Simple LLM Agent Deployment Tutorial

Easy, extendable and fast LLM agent deployment template

Youness Mansar

Published in Towards Data Science

Nov 5, 2024

Many tutorials show how to implement an LLM agent. However, resources on deploying these agents behind an API or a user-friendly UI are limited. This post addresses this gap with a step-by-step guide to implementing and deploying a minimal yet functional LLM agent. This provides a starting point for your LLM agent proof of concept, whether for personal use or to share with others.

很多教程都介绍了如何构建大语言模型（LLM）智能体（agent）。但是，关于如何将这些智能体部署到 API 或用户友好的界面（UI）上的资源却不多。本文将通过一个详细的指南来填补这个空白，教你如何实现并部署一个精简但功能完备的大语言模型智能体。无论你是个人使用，还是想与他人分享，这都能为你的大语言模型智能体的概念验证提供一个很好的开始。

Our implementation has several parts:

我们的实现包含以下几个部分：

1 Agent Implementation: Using LangGraph as the agent framework and Fireworks AI as the LLM service.

AI 智能体实现：采用 LangGraph 作为 AI 智能体框架，并选用 Fireworks AI 作为大语言模型（LLM）服务。

2 User Interface: Exposing the agent through a UI built with FastAPI and NiceGUI.

用户界面：通过 FastAPI 和 NiceGUI 构建的用户界面来呈现 AI 智能体。

3 Containerization: Packaging the application into a Docker image.

容器化：将应用程序打包成 Docker 镜像。

4 Deployment: Deploying the Docker image to Google Cloud Run.

部署：将 Docker 镜像部署到 Google Cloud Run。

Full code and demo app linked at the end of the post.

完整的代码和演示应用链接在本文末尾。

### 01. Building the Agent

构建智能体

The agent requires two core components:

智能体的构建需要两个核心组件：

1 LLM Serving Service: We’ll use Fireworks AI.

大语言模型（LLM）服务：我们将使用 Fireworks AI。

2 Agent Framework: We’ll use LangGraph, a framework that enables creating stateful, graph-shaped agents. Nodes in the graph represent actions, and edges represent transitions between actions.

智能体框架：我们将使用 LangGraph，这是一个可以创建有状态的、图状智能体的框架。图中的节点代表动作，边代表动作间的转换。

You can find here a previous post going into more details on how to use LangGraph:

您可以在之前的文章中找到关于如何使用 LangGraph 的更详细介绍：

[An Agentic Approach to Textual Data Extraction Using LLMs and LangGraph | by Youness Mansar | Towards Data Science](https://towardsdatascience.com/an-agentic-approach-to-textual-data-extraction-using-llms-and-langgraph-8abb12af16f2)

We’ll build an agent capable of multi-turn conversations, and able to query Wikipedia to answer user questions. This simple agent can be easily extended with additional tools and actions. Giving LLMs tools can be an easy way to extend their capabilities beyond just Text generation.

我们将创建一个可以进行多轮对话，并能够查询维基百科来回答用户问题的 AI 智能体（AI Agent）。这个简单的 AI 智能体可以很容易地通过添加额外的工具和动作进行扩展。为大语言模型提供工具是一种扩展其能力的简单方式，使其不仅仅局限于文本生成。

A key node in our agent sends the conversation history to the LLM on Fireworks AI. The LLM responds and can optionally choose to use a tool (Wikipedia). If chosen, the agent queries Wikipedia’s API. It then summarizes the Wikipedia information to answer the user’s query. Using external tools increases the likelihood of factual responses, especially for topics not well-represented in the LLM’s training data. It also helps mitigate hallucinations.

我们的 AI 智能体中有一个关键部分，它将对话历史发送给 Fireworks AI 上的大语言模型（LLM）。大语言模型响应后，可以选择使用工具（维基百科）。如果选择使用该工具，AI 智能体会查询维基百科的 API。然后，它会总结维基百科的信息来回答用户的查询。使用外部工具提高了回答真实性的可能性，特别是对于那些大语言模型训练数据中较少涉及的主题。使用外部工具还有助于减少幻觉。

LangGraph’s modular design enables testing individual components. For instance, we can write unit tests for a specific node (action) or for the entire agent to ensure correct functionality.

LangGraph 的模块化设计让我们可以对各个组件进行单独测试。例如，我们可以针对特定的节点（动作）或者整个 AI 智能体编写单元测试，以确保其功能正常。

Example Node Implementation (llm_agent/nodes.py):

```py
from langchain_community.tools import WikipediaQueryRun
from langchain_community.utilities import WikipediaAPIWrapper
from langchain_core.messages import SystemMessage
from langgraph.prebuilt import ToolNode

from llm_agent.clients import client_large
from llm_agent.state import OverallState

wikipedia = WikipediaQueryRun(api_wrapper=WikipediaAPIWrapper())

tools = [wikipedia]


def query_llm(state: OverallState) -> dict:
    local_client = client_large.bind_tools(tools)
    result = local_client.invoke(
        [
            SystemMessage(
                content="You are a helpful assistant. Use the wikipedia tool when necessary."
            )
        ]
        + state.messages
    )

    return {"messages": [result]}


tools_node = ToolNode(tools=tools)
```

This node is able to call the llm using the latest user’s message in addition to the full message history and returns its response. The response can be either a tool call or a textual response.

这个节点能够利用最新的用户消息，并结合完整的消息历史来调用大语言模型（LLM），然后返回它的响应。这个响应可能是工具调用，也可能是文本形式的回复。

Thanks to LangGraph modular design, we can test this node independently:

得益于 LangGraph 的模块化设计，我们可以独立测试这个节点：

```py
from langchain_core.messages import HumanMessage
from llm_agent.nodes import query_llm
from llm_agent.state import OverallState
def test_query_llm():
    state = OverallState(messages=[HumanMessage(content="Hello, how are you?")])
    output = query_llm(state=state)
    assert "messages" in output
    assert output["messages"]
    assert isinstance(output["messages"][0].content, str)
```

The Wikipedia tool is a simple search API. Given a query, the API returns relevant articles. These articles are added to the message history as tool messages and sent to the LLM. The LLM then uses this information to formulate its response.

维基百科工具是一个简单的搜索接口（API）。接收到查询后，该接口会返回相关的文章。这些文章会作为工具消息添加到消息历史中，并发送给大语言模型（LLM）。随后，大语言模型（LLM）会利用这些信息生成回复。

All messages (user messages, LLM responses, tool responses) are stored in the agent’s state for each user, identified by a thread_id. This allows the agent to manage multiple concurrent users and maintain conversation history, allowing for multi-turn dialogues.

所有消息（用户消息、大语言模型（LLM）的回复、工具的回复）都存储在 AI 智能体（AI Agent）的内部存储中，每个用户都用 thread_id 来区分。这使得 AI 智能体能够管理多个同时在线的用户，并记住之前的对话内容，从而支持多轮对话。

Example Agent Implementation (llm_agent/agent.py):

```py
from langchain_core.messages import HumanMessage
from langgraph.checkpoint.memory import MemorySaver
from langgraph.graph import START, StateGraph

from llm_agent.edges import should_we_stop
from llm_agent.nodes import query_llm, tools_node
from llm_agent.state import OverallState


def build_agent(local_memory=True):
    workflow = StateGraph(OverallState)

    # Add nodes
    workflow.add_node("llm", query_llm)
    workflow.add_node("tools", tools_node)

    # Add edges
    workflow.add_edge(START, "llm")
    workflow.add_conditional_edges("llm", should_we_stop)
    workflow.add_edge("tools", "llm")

    agent = workflow.compile(checkpointer=MemorySaver() if local_memory else None)

    return agent
```

This code snippet demonstrates building the agent using LangGraph. should_we_stop is an edge that determines the conversation flow based on LLM responses. If there is a tool call it means that we need to actually call the tool, otherwise we can stop and return the result to the user. query_llm handles LLM interaction. tools_node manages tool interactions. MemorySaver is used for (in-memory) persistence, this will be discussed later.

这段代码展示了如何使用 LangGraph 构建一个 AI 智能体（AI Agent）。其中，`should_we_stop` 是一条控制对话流程的边，它会根据大语言模型（LLM）的响应来判断下一步操作。如果需要调用工具，则执行相应的工具调用；否则，就可以停止并返回结果给用户。`query_llm` 负责与大语言模型（LLM）交互。`tools_node` 管理工具的调用。`MemorySaver` 用于在内存中保存数据，我们将在后续讨论这个。

### 02. User Interface

用户界面

We have multiple options for serving the agent: two of them are behind a REST API or through a graphical UI. This example uses the latter, based on FastAPI and NiceGUI. The UI maintains a message history, sending new user messages to the agent. The agent’s response updates the UI, displaying the new message history. Tool responses can also be displayed.

我们有多种使用 AI 智能体的方式：可以通过 REST API 或者图形界面。本例使用的是后者，它基于 FastAPI 和 NiceGUI。图形界面会保存消息记录，并将用户的新消息发送给 AI 智能体。AI 智能体的回复会更新界面，显示最新的消息记录。同时，工具的反馈也会显示。

UI Implementation details (llm_agent/chat_app.py):

1 ui.chat_message: Displays messages.

ui.chat_message：用于显示聊天消息。

2 message.type: Determines the user's avatar and whether the message was sent or received.

message.type：用于确定用户头像，并区分消息是发送的还是接收的。

```py
\# Modified from https://github.com/zauberzeug/nicegui/blob/main/examples/chat_app/main.py
import os
from typing import Optional

from fastapi import FastAPI, Request
from langchain_core.messages import AnyMessage, HumanMessage
from langgraph.graph.graph import CompiledGraph
from nicegui import run, ui

from llm_agent.state import OverallState


def message_to_content(message: AnyMessage):
    if message.type == "human":
        return message.content
    elif message.type == "ai":
        if message.tool_calls:
            return f"Requesting tools: {[x['name'] for x in message.tool_calls]}"
        else:
            return message.content
    elif message.type == "tool":
        return (
            message.content
            if len(message.content) < 300
            else message.content[:300] + "..."
        )
    else:
        return message.content


class PageData:
    def __init__(self, messages=None, query=None, processing=None):
        self.messages: Optional[list] = messages
        self.query: Optional[str] = query
        self.processing: Optional[bool] = processing

    def reset(self):
        self.query = ""


class Refreshables:
    @ui.refreshable
    async def chat_messages(self, page_data: PageData) -> None:
        if page_data.messages:
            for message in page_data.messages:
                bg_set = {"ai": "set1", "tool": "set4", "human": "set2"}[message.type]
                avatar = f"https://robohash.org/{message.type}?bgset={bg_set}"
                ui.chat_message(
                    text=message_to_content(message),
                    avatar=avatar,
                    sent=message.type == "human",
                )
            ui.spinner(type="dots").bind_visibility(page_data, "processing")
        else:
            ui.label("No messages yet").classes("mx-auto my-36")
        await ui.run_javascript("window.scrollTo(0, document.body.scrollHeight)")


async def handle_enter(page_data, agent, config, refreshables) -> None:
    if page_data.query:
        message = HumanMessage(content=page_data.query[:1000])
        page_data.reset()
        page_data.processing = True
        state = OverallState(messages=[message])
        # state_dict = agent.invoke(state, config)
        state_dict = await run.io_bound(agent.invoke, state, config)
        page_data.messages = state_dict["messages"]
        page_data.processing = False
        refreshables.chat_messages.refresh(page_data=page_data)


async def chat_page(request: Request):
    agent: CompiledGraph = request.state.agent
    config = {"configurable": {"thread_id": request.app.storage.browser["id"]}}
    messages: list[AnyMessage] = agent.get_state(config).values.get("messages", [])
    page_data = PageData(messages=messages)
    refreshables = Refreshables()

    ui.add_css(
        r"a:link, a:visited {color: inherit !important; text-decoration: none; font-weight: 500}"
    )
    with ui.footer().classes("bg-white"), ui.column().classes(
        "w-full max-w-3xl mx-auto my-6"
    ):
        with ui.row().classes("w-full no-wrap items-center"):
            ui.input(
                placeholder="message",
            ).props("outlined dense maxlength=1000").on(
                "keydown.enter",
                lambda e: handle_enter(
                    page_data=page_data,
                    agent=agent,
                    config=config,
                    refreshables=refreshables,
                ),
            ).props("rounded outlined input-class=mx-3").classes(
                "flex-grow"
            ).bind_value(page_data, "query")

        ui.markdown(
            "Built with [NiceGUI](https://nicegui.io) and [LangGraph](https://langchain-ai.github.io/langgraph/)"
        ).classes("text-xs self-end mr-8 m-[-1em] text-primary")

    await (
        ui.context.client.connected()
    )  # chat_messages(...) uses run_javascript which is only possible after connecting
    with ui.column().classes("w-full max-w-2xl mx-auto items-stretch"):
        await refreshables.chat_messages(page_data=page_data)


def init(fastapi_app: FastAPI) -> None:
    ui.page("/", title="LLM Agent", response_timeout=10)(chat_page)

    ui.run_with(
        fastapi_app,
        mount_path="/"
    )
```

Once the user presses the “Enter” key, the page’s backend sends a query to the agends and await’s the result. Once the result is in, it updates the messages list and refreshes the message history to display the result to the user.

当用户按下「Enter」键后，页面的后端会向 AI 智能体（AI Agent）发送查询，并等待其返回结果。一旦收到结果，后端会更新消息列表，并刷新消息历史，从而将结果呈现给用户。

The tool response is truncated for readability and uses a different avatar to differentiate it from the LLM responses.

为了方便阅读，工具的回复被截断，并使用了不同的头像，以便与大语言模型（LLM）的回复区分开来。

### 03. Persistence

持久化

The in-memory state store from langgraph.checkpoint.memory.MemorySaver is sufficient for a proof of concept or a demo app, but his approach is not suitable for production due to its volatile nature where you lose data if the service restarts or if the user is routed to a different instance. A future blog post will cover more robust persistence options. The --session-affinity flag in the deployment script helps mitigate this by routing users to the same instance, preserving the in-memory state within a session, but it is more of a band-aid than a real solution.

`langgraph.checkpoint.memory.MemorySaver` 提供的内存状态存储，对于概念验证或演示应用来说是足够的。但是，这种方法不适合生产环境，因为它具有易失性，当服务重启或用户被路由到不同的实例时，数据会丢失。未来的博客文章将介绍更可靠的持久化方案。部署脚本中的 `--session-affinity` 标志，通过将用户路由到同一实例来帮助缓解这个问题，从而在会话中保留内存状态，但这更多的是一种临时措施，而不是真正的解决方案。

### 04. Containerization and Deployment

The application is packaged into a Docker image using a standard Dockerfile:

容器化和部署该应用程序被打包成 Docker 镜像，打包过程使用标准的 Dockerfile：

```
FROM python:3.10-slim

WORKDIR "/app"

ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1

ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1


COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY run.sh run.sh

COPY llm_agent llm_agent

CMD ["bash", "run.sh", "prod"]
```

The Dockerfile pulls a python base image, installs dependencies from requirements and then copies the relevant source file. It then runs the app using the utility bash script run.sh .

Dockerfile 指令会拉取一个 Python 基础镜像，并从 requirements 文件中安装依赖，然后复制相关的源文件。之后，它会使用 bash 脚本 run.sh 来运行程序。

The deployment script (deploy.sh) uses Google Cloud Build and Cloud Run:

部署脚本（deploy.sh）会用到 Google Cloud Build 和 Cloud Run 这两项服务：

```
PROJECT_ID=$(gcloud config get-value project)
REPO="demo"
LOCATION="europe-west1"
IMAGE="llm_agent"
SERVICE_NAME="llm-agent"
VERSION="0.0.1"
GAR_TAG=$LOCATION-docker.pkg.dev/$PROJECT_ID/$REPO/$IMAGE:$VERSION

\# Create repository
gcloud artifacts repositories create $REPO --repository-format=docker \
    --location=$LOCATION --description="Docker repository" \
    --project=$PROJECT_ID  || true # If fails because already exist then its fine

\# Build image
gcloud builds submit --tag $GAR_TAG

\# Deploy Cloud run
gcloud run deploy $SERVICE_NAME --image=$GAR_TAG --max-instances=1 --min-instances=0 --port=8080 \
 --allow-unauthenticated --region=europe-west1 --memory=2Gi --cpu=1 -q --session-affinity \
 --service-account=cloud-run@$PROJECT_ID.iam.gserviceaccount.com --concurrency 300 --timeout 1800 \
 $(awk '!/^#/ && NF {printf "--set-env-vars %s ", $0}' .env) # --no-cpu-throttling
```

Before running this script:

在执行此脚本之前，请确保：

1 Install the Google Cloud SDK (gcloud CLI): https://cloud.google.com/sdk/docs/install

要安装 Google Cloud SDK（gcloud CLI），请参考：https://cloud.google.com/sdk/docs/install

2 Authenticate with your Google Cloud account: gcloud auth login

使用您的 Google Cloud 账号进行身份验证，请执行：gcloud auth login

3 Set your project ID: gcloud config set project YOUR_PROJECT_ID

设置您的项目 ID，请执行：gcloud config set project YOUR_PROJECT_ID

4 Activate all relevant services: Cloud build, GAR, Cloud Run.

请激活以下服务：Cloud Build、GAR 和 Cloud Run。

The script creates a Docker repository in Google Artifact Registry (GAR), builds the Docker image using Cloud Build, and deploys the image to Cloud Run. Key parameters in the gcloud run deploy command include:

这个脚本会在 Google Artifact Registry（GAR）中创建一个 Docker 镜像仓库，然后使用 Cloud Build 构建 Docker 镜像，最后将镜像部署到 Cloud Run。gcloud run deploy 命令的关键参数如下：

--session-affinity: Routes users to the same instance.

将用户引导至同一实例。

--set-env-vars: Sets environment variables (including your LLM API key, read from the .env file). Store API keys securely using Google Cloud Secret Manager in production environments.
Running this script will deploy the app and return the URL of the service for you.

设置环境变量，包括从 .env 文件读取的您的大语言模型（LLM）API 密钥。在生产环境中，建议使用 Google Cloud Secret Manager 安全地存储 API 密钥。
运行此脚本将部署应用，并返回该服务的 URL。

### 05. CI and Secret Detection

The project includes two GitHub Actions:

持续集成（CI）与密钥检测本项目使用了两个 GitHub Actions：

1 Secret Detection: Scans for leaked secrets in the codebase. This is particularly important when your work involves API keys or service accounts.

密钥检测：扫描代码库中泄露的密钥（例如 API 密钥或服务帐户）。当你的工作涉及到 API 密钥或服务账户时，这项检测尤为重要。

CI: Checks code formatting (using ruff) and runs automated tests.

CI：检查代码格式（使用 ruff 工具）并运行自动化测试。

### 06. Future Improvements

Some key aspects need to be improved to make the app more robust:

未来改进为了使应用程序更加稳定可靠，以下几个关键方面需要改进：

1 Persistent Storage: Replace the in-memory state store with a persistent database like MongoDB.

持久化存储：使用诸如 MongoDB 这样的持久化数据库来替代内存中的状态存储。

2 Tracing and APMs: Integrate tools like New Relic or LangSmith for performance monitoring and tracing.

追踪和应用性能监控（APM)：集成 New Relic 或 LangSmith 等工具，用于性能监控和性能分析。

3 Logging: Implement robust logging of conversations.

日志记录：实现可靠的对话日志记录。

4 CD: Automate the deployment process.

持续部署（CD)：自动化部署流程。

5 Streaming Responses: Stream LLM responses to the UI for a more interactive experience.

流式响应：将大语言模型（LLM）的响应以流的形式发送到用户界面，从而提供更具交互性的体验。

I will expand on them in future blog posts so don’t forget to follow me on Medium

我将在未来的博客文章中详细介绍这些内容，请不要忘记在 Medium 上关注我。

### 07. Summary

This tutorial aims to make your journey into building and deploying LLM agents easier. Its reusable, modular design allows for rapid development, enabling you to quickly transition from concept or idea to deployed application. Modify only the necessary components — UI, backend LLM service, tools, or agent logic — to suit your needs. While some design choices prioritize simplicity, feel free to adapt them for better robustness and production readiness.

本教程旨在简化您构建和部署大语言模型（LLM/Large Language Model）智能体的过程。它采用可复用、模块化的设计，支持快速开发，让您能够迅速将概念或想法转化为实际部署的应用。您只需根据需求修改必要的组件，例如用户界面（UI)、后端大语言模型服务、工具或智能体逻辑。尽管某些设计选择侧重于简洁性，您仍然可以根据需要调整它们，以提高系统的稳健性和生产就绪程度。

[CVxTz/easy\_llm\_agent\_deploy: One line llm agent deployment based on langgraph.](https://github.com/CVxTz/easy_llm_agent_deploy)

Code: https://github.com/CVxTz/easy_llm_agent_deploy

Demo: https://llm-agent-340387183829.europe-west1.run.app

## 原文

A Simple LLM Agent Deployment Tutorial

Easy, extendable and fast LLM agent deployment template

Youness Mansar

Published in Towards Data Science

Nov 5, 2024

Photo by Jeremy Bishop on Unsplash
Many tutorials show how to implement an LLM agent. However, resources on deploying these agents behind an API or a user-friendly UI are limited. This post addresses this gap with a step-by-step guide to implementing and deploying a minimal yet functional LLM agent. This provides a starting point for your LLM agent proof of concept, whether for personal use or to share with others.

Our implementation has several parts:

Agent Implementation: Using LangGraph as the agent framework and Fireworks AI as the LLM service.
User Interface: Exposing the agent through a UI built with FastAPI and NiceGUI.
Containerization: Packaging the application into a Docker image.
Deployment: Deploying the Docker image to Google Cloud Run.
Full code and demo app linked at the end of the post.


Component list — Image by Author
Building the Agent
The agent requires two core components:

LLM Serving Service: We’ll use Fireworks AI.
Agent Framework: We’ll use LangGraph, a framework that enables creating stateful, graph-shaped agents. Nodes in the graph represent actions, and edges represent transitions between actions.
You can find here a previous post going into more details on how to use LangGraph:

An Agentic Approach to Textual Data Extraction Using LLMs and LangGraph
From unstructured Wikipedia text to structured JSON: A step-by-step guide.
towardsdatascience.com

We’ll build an agent capable of multi-turn conversations, and able to query Wikipedia to answer user questions. This simple agent can be easily extended with additional tools and actions. Giving LLMs tools can be an easy way to extend their capabilities beyond just Text generation.

A key node in our agent sends the conversation history to the LLM on Fireworks AI. The LLM responds and can optionally choose to use a tool (Wikipedia). If chosen, the agent queries Wikipedia’s API. It then summarizes the Wikipedia information to answer the user’s query. Using external tools increases the likelihood of factual responses, especially for topics not well-represented in the LLM’s training data. It also helps mitigate hallucinations.

LangGraph’s modular design enables testing individual components. For instance, we can write unit tests for a specific node (action) or for the entire agent to ensure correct functionality.

Example Node Implementation (llm_agent/nodes.py):

from langchain_community.tools import WikipediaQueryRun
from langchain_community.utilities import WikipediaAPIWrapper
from langchain_core.messages import SystemMessage
from langgraph.prebuilt import ToolNode

from llm_agent.clients import client_large
from llm_agent.state import OverallState

wikipedia = WikipediaQueryRun(api_wrapper=WikipediaAPIWrapper())

tools = [wikipedia]


def query_llm(state: OverallState) -> dict:
    local_client = client_large.bind_tools(tools)
    result = local_client.invoke(
        [
            SystemMessage(
                content="You are a helpful assistant. Use the wikipedia tool when necessary."
            )
        ]
        + state.messages
    )

    return {"messages": [result]}


tools_node = ToolNode(tools=tools)
This node is able to call the llm using the latest user’s message in addition to the full message history and returns its response. The response can be either a tool call or a textual response.

Thanks to LangGraph modular design, we can test this node independently:

from langchain_core.messages import HumanMessage
from llm_agent.nodes import query_llm
from llm_agent.state import OverallState
def test_query_llm():
    state = OverallState(messages=[HumanMessage(content="Hello, how are you?")])
    output = query_llm(state=state)
    assert "messages" in output
    assert output["messages"]
    assert isinstance(output["messages"][0].content, str)
Wikipedia Tool

The Wikipedia tool is a simple search API. Given a query, the API returns relevant articles. These articles are added to the message history as tool messages and sent to the LLM. The LLM then uses this information to formulate its response.

All messages (user messages, LLM responses, tool responses) are stored in the agent’s state for each user, identified by a thread_id. This allows the agent to manage multiple concurrent users and maintain conversation history, allowing for multi-turn dialogues.

Example Agent Implementation (llm_agent/agent.py):

from langchain_core.messages import HumanMessage
from langgraph.checkpoint.memory import MemorySaver
from langgraph.graph import START, StateGraph

from llm_agent.edges import should_we_stop
from llm_agent.nodes import query_llm, tools_node
from llm_agent.state import OverallState


def build_agent(local_memory=True):
    workflow = StateGraph(OverallState)

    # Add nodes
    workflow.add_node("llm", query_llm)
    workflow.add_node("tools", tools_node)

    # Add edges
    workflow.add_edge(START, "llm")
    workflow.add_conditional_edges("llm", should_we_stop)
    workflow.add_edge("tools", "llm")

    agent = workflow.compile(checkpointer=MemorySaver() if local_memory else None)

    return agent
This code snippet demonstrates building the agent using LangGraph. should_we_stop is an edge that determines the conversation flow based on LLM responses. If there is a tool call it means that we need to actually call the tool, otherwise we can stop and return the result to the user. query_llm handles LLM interaction. tools_node manages tool interactions. MemorySaver is used for (in-memory) persistence, this will be discussed later.

User Interface
We have multiple options for serving the agent: two of them are behind a REST API or through a graphical UI. This example uses the latter, based on FastAPI and NiceGUI. The UI maintains a message history, sending new user messages to the agent. The agent’s response updates the UI, displaying the new message history. Tool responses can also be displayed.

UI Implementation details (llm_agent/chat_app.py):

ui.chat_message: Displays messages.
message.type: Determines the user's avatar and whether the message was sent or received.
\# Modified from https://github.com/zauberzeug/nicegui/blob/main/examples/chat_app/main.py
import os
from typing import Optional

from fastapi import FastAPI, Request
from langchain_core.messages import AnyMessage, HumanMessage
from langgraph.graph.graph import CompiledGraph
from nicegui import run, ui

from llm_agent.state import OverallState


def message_to_content(message: AnyMessage):
    if message.type == "human":
        return message.content
    elif message.type == "ai":
        if message.tool_calls:
            return f"Requesting tools: {[x['name'] for x in message.tool_calls]}"
        else:
            return message.content
    elif message.type == "tool":
        return (
            message.content
            if len(message.content) < 300
            else message.content[:300] + "..."
        )
    else:
        return message.content


class PageData:
    def __init__(self, messages=None, query=None, processing=None):
        self.messages: Optional[list] = messages
        self.query: Optional[str] = query
        self.processing: Optional[bool] = processing

    def reset(self):
        self.query = ""


class Refreshables:
    @ui.refreshable
    async def chat_messages(self, page_data: PageData) -> None:
        if page_data.messages:
            for message in page_data.messages:
                bg_set = {"ai": "set1", "tool": "set4", "human": "set2"}[message.type]
                avatar = f"https://robohash.org/{message.type}?bgset={bg_set}"
                ui.chat_message(
                    text=message_to_content(message),
                    avatar=avatar,
                    sent=message.type == "human",
                )
            ui.spinner(type="dots").bind_visibility(page_data, "processing")
        else:
            ui.label("No messages yet").classes("mx-auto my-36")
        await ui.run_javascript("window.scrollTo(0, document.body.scrollHeight)")


async def handle_enter(page_data, agent, config, refreshables) -> None:
    if page_data.query:
        message = HumanMessage(content=page_data.query[:1000])
        page_data.reset()
        page_data.processing = True
        state = OverallState(messages=[message])
        # state_dict = agent.invoke(state, config)
        state_dict = await run.io_bound(agent.invoke, state, config)
        page_data.messages = state_dict["messages"]
        page_data.processing = False
        refreshables.chat_messages.refresh(page_data=page_data)


async def chat_page(request: Request):
    agent: CompiledGraph = request.state.agent
    config = {"configurable": {"thread_id": request.app.storage.browser["id"]}}
    messages: list[AnyMessage] = agent.get_state(config).values.get("messages", [])
    page_data = PageData(messages=messages)
    refreshables = Refreshables()

    ui.add_css(
        r"a:link, a:visited {color: inherit !important; text-decoration: none; font-weight: 500}"
    )
    with ui.footer().classes("bg-white"), ui.column().classes(
        "w-full max-w-3xl mx-auto my-6"
    ):
        with ui.row().classes("w-full no-wrap items-center"):
            ui.input(
                placeholder="message",
            ).props("outlined dense maxlength=1000").on(
                "keydown.enter",
                lambda e: handle_enter(
                    page_data=page_data,
                    agent=agent,
                    config=config,
                    refreshables=refreshables,
                ),
            ).props("rounded outlined input-class=mx-3").classes(
                "flex-grow"
            ).bind_value(page_data, "query")

        ui.markdown(
            "Built with [NiceGUI](https://nicegui.io) and [LangGraph](https://langchain-ai.github.io/langgraph/)"
        ).classes("text-xs self-end mr-8 m-[-1em] text-primary")

    await (
        ui.context.client.connected()
    )  # chat_messages(...) uses run_javascript which is only possible after connecting
    with ui.column().classes("w-full max-w-2xl mx-auto items-stretch"):
        await refreshables.chat_messages(page_data=page_data)


def init(fastapi_app: FastAPI) -> None:
    ui.page("/", title="LLM Agent", response_timeout=10)(chat_page)

    ui.run_with(
        fastapi_app,
        mount_path="/"
    )
Once the user presses the “Enter” key, the page’s backend sends a query to the agends and await’s the result. Once the result is in, it updates the messages list and refreshes the message history to display the result to the user.


Image by author
The tool response is truncated for readability and uses a different avatar to differentiate it from the LLM responses.

Persistence
The in-memory state store from langgraph.checkpoint.memory.MemorySaver is sufficient for a proof of concept or a demo app, but his approach is not suitable for production due to its volatile nature where you lose data if the service restarts or if the user is routed to a different instance. A future blog post will cover more robust persistence options. The --session-affinity flag in the deployment script helps mitigate this by routing users to the same instance, preserving the in-memory state within a session, but it is more of a band-aid than a real solution.

Containerization and Deployment
The application is packaged into a Docker image using a standard Dockerfile:

FROM python:3.10-slim

WORKDIR "/app"

ENV PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1

ENV PIP_DEFAULT_TIMEOUT=100 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1


COPY requirements.txt ./
RUN pip install -r requirements.txt
COPY run.sh run.sh

COPY llm_agent llm_agent

CMD ["bash", "run.sh", "prod"]
The Dockerfile pulls a python base image, installs dependencies from requirements and then copies the relevant source file. It then runs the app using the utility bash script run.sh .

The deployment script (deploy.sh) uses Google Cloud Build and Cloud Run:

PROJECT_ID=$(gcloud config get-value project)
REPO="demo"
LOCATION="europe-west1"
IMAGE="llm_agent"
SERVICE_NAME="llm-agent"
VERSION="0.0.1"
GAR_TAG=$LOCATION-docker.pkg.dev/$PROJECT_ID/$REPO/$IMAGE:$VERSION

\# Create repository
gcloud artifacts repositories create $REPO --repository-format=docker \
    --location=$LOCATION --description="Docker repository" \
    --project=$PROJECT_ID  || true # If fails because already exist then its fine

\# Build image
gcloud builds submit --tag $GAR_TAG

\# Deploy Cloud run
gcloud run deploy $SERVICE_NAME --image=$GAR_TAG --max-instances=1 --min-instances=0 --port=8080 \
 --allow-unauthenticated --region=europe-west1 --memory=2Gi --cpu=1 -q --session-affinity \
 --service-account=cloud-run@$PROJECT_ID.iam.gserviceaccount.com --concurrency 300 --timeout 1800 \
 $(awk '!/^#/ && NF {printf "--set-env-vars %s ", $0}' .env) # --no-cpu-throttling
Before running this script:

Install the Google Cloud SDK (gcloud CLI): https://cloud.google.com/sdk/docs/install
Authenticate with your Google Cloud account: gcloud auth login
Set your project ID: gcloud config set project YOUR_PROJECT_ID
Activate all relevant services: Cloud build, GAR, Cloud Run.
The script creates a Docker repository in Google Artifact Registry (GAR), builds the Docker image using Cloud Build, and deploys the image to Cloud Run. Key parameters in the gcloud run deploy command include:

--session-affinity: Routes users to the same instance.
--set-env-vars: Sets environment variables (including your LLM API key, read from the .env file). Store API keys securely using Google Cloud Secret Manager in production environments.
Running this script will deploy the app and return the URL of the service for you.

CI and Secret Detection
The project includes two GitHub Actions:

Secret Detection: Scans for leaked secrets in the codebase. This is particularly important when your work involves API keys or service accounts.
CI: Checks code formatting (using ruff) and runs automated tests.
Future Improvements
Some key aspects need to be improved to make the app more robust:

Persistent Storage: Replace the in-memory state store with a persistent database like MongoDB.
Tracing and APMs: Integrate tools like New Relic or LangSmith for performance monitoring and tracing.
Logging: Implement robust logging of conversations.
CD: Automate the deployment process.
Streaming Responses: Stream LLM responses to the UI for a more interactive experience.
I will expand on them in future blog posts so don’t forget to follow me on Medium

Summary
This tutorial aims to make your journey into building and deploying LLM agents easier. Its reusable, modular design allows for rapid development, enabling you to quickly transition from concept or idea to deployed application. Modify only the necessary components — UI, backend LLM service, tools, or agent logic — to suit your needs. While some design choices prioritize simplicity, feel free to adapt them for better robustness and production readiness.

Code: https://github.com/CVxTz/easy_llm_agent_deploy

Demo: https://llm-agent-340387183829.europe-west1.run.app