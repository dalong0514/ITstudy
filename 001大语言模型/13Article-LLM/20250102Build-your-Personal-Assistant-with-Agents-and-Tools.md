## 20250102Build-your-Personal-Assistant-with-Agents-and-Tools

[Build your Personal Assistant with Agents and Tools | by Benjamin Etienne | Nov, 2024 | Towards Data Science](https://towardsdatascience.com/build-your-personal-assistant-with-agents-and-tools-048637ac308e)

Build your Personal Assistant with Agents and Tools

LLMs alone suffer from not being able to access external or real-time data. Learn how to build your personal assistant using LangChain agents and Gemini by grounding it in external sources.

Benjamin Etienne

Towards Data Science

Nov 24, 2024

### 1. The problem with LLMs

大语言模型的问题

So you have your favorite chatbot, and you use it for your daily job to boost your productivity. It can translate text, write nice emails, tell jokes, etc. And then comes the day when your colleague comes to you and asks :

你或许已经有了自己常用的聊天机器人，并且每天在工作中使用它来提升效率。它可以翻译文本、撰写优美的电子邮件、讲笑话等等。突然有一天，你的同事来问你：

"Do you know the current exchange rate between USD and EUR ? I wonder if I should sell my EUR…"

「你知道美元和欧元之间的当前汇率吗？我想知道我是否应该卖掉我的欧元……」

You ask your favorite chatbot, and the answer pops:

你问你最喜欢的聊天机器人，答案随即弹出：

I am sorry, I cannot fulfill this request. 
I do not have access to real-time information, including financial data 
like exchange rates.

What is the problem here ?

这里有什么问题？

The problem is that you have stumbled on one of the shortcomings of LLMs. Large Language Models (LLMs) are powerful at solving many types of problems, such as problem solving, text summarization, generation, etc.

问题在于，您遇到了大语言模型（Large Language Model，LLM）的一个局限性。LLM 在解决多种类型的问题上表现出色，例如解决问题、摘要、内容生成等等。

However, they are constrained by the following limitations:

然而，这些模型存在以下局限性：

1 They are frozen after training, leading to stale knowledge.

模型一旦训练完成，参数就会被固定，这会导致知识无法及时更新，变得过时。

2 They can't query or modify external data.

这些大语言模型无法查询或修改外部数据。

Same way as we are using search engines every day, reading books and documents or querying databases, we would ideally want to provide this knowledge to our LLM to make it more efficient.

正如我们每天使用搜索引擎、阅读书籍和文档或者查询数据库一样，我们希望能够将这些知识提供给大语言模型（LLM），以提高它们的效率。

Fortunately, there is a way to do that: Tools and Agents.

幸运的是，有一种方法可以解决这个问题：工具和 AI 智能体（Agents）。

Foundational models, despite their impressive text and image generation, remain constrained by their inability to interact with the outside world. Tools bridge this gap, empowering agents to interact with external data and services while unlocking a wider range of actions beyond that of the underlying model alone

(source : Google Agents whitepaper)

尽管基础模型在文本和图像生成方面表现出色，但它们仍然受限于无法与外部世界互动。工具弥补了这一不足，使得 AI 智能体能够与外部数据和服务交互，从而解锁了超出模型本身能力的更多操作。

Using agents and tools, we could then be able to, from our chat interface:

借助 AI 智能体（AI Agent）和各种工具，我们就能在聊天界面中实现以下功能：

1 retrieve data from our own documents

从我们自己的文档中提取信息

2 read / send emails

读取和发送电子邮件

3 interact with internal databases

访问内部数据库

perform real time Google searches

进行实时的 Google 搜索

4 etc.

诸如此类。

### 2. What are Agents, Tools and Chains ?

什么是 AI 智能体（AI Agent）、工具和链？

An agent is an application which attempts to achieve a goal (or a task) by having at its disposal a set of tools and taking decisions based on its observations of the environment.

AI 智能体是一个应用程序，它通过利用一系列工具，并根据对环境的观察结果做出决策，从而尝试达成某个目标（或完成某项任务）。

A good example of an agent could be you, for example: if you need to compute a complex mathematical operation (goal), you could use a calculator (tool #1), or a programming language (tool #2). Maybe you would choose the calculator to do a simple addition, but choose tool #2 for more complex algorithms.

一个很好的 AI 智能体例子就是像您这样的程序：例如，如果需要完成一个复杂的数学计算（目标），您可以使用计算器（工具 #1）或者编程语言（工具 #2）。您可能会选择计算器来完成简单的加法，而对于更复杂的算法，则会选择工具 #2。

Agents are therefore made of:

因此，AI 智能体由以下部分构成：

1 A model : The brain in our agent is the LLM. It will understand the query (the goal), and browse through its tools available to select the best.

模型：AI 智能体的大脑是大语言模型（LLM）。它负责理解用户的提问（即目标），并从可用的工具中选择最合适的。

2 One or more tools : These are functions, or APIs, that are responsible for performing a specific action (ie: retrieving the current currency rate for USD vs EUR, adding numbers, etc.)

一个或多个工具：这些工具是负责执行特定操作的函数或应用程序编程接口（API），例如：检索美元兑欧元的当前汇率、执行加法运算等。

3 An orchestration process: this is how the model will behave when asked to solve a task. It is a cognitive process that defines how the model will analyze the problem, refine inputs, choose a tool, etc. Examples of such processes are ReAct, CoT (Chain of Thought), ToT (Tree-of-Thought)

编排过程：这指的是模型在被要求解决任务时的行为模式。这是一个认知过程，它决定了模型如何分析问题、优化输入、选择合适的工具等。例如，ReAct、CoT（Chain of Thought，思维链）和 ToT（Tree-of-Thought，思维树）就是这种过程的例子。

Here is below a workflow explanation

下图为作者提供的关于工作流程的图示。

Chains are somehow different. Whereas agents can ‘decide' by themselves what to do and which steps to take, chains are just a sequence of predefined steps. They can still rely on tools though, meaning that they can include a step in which they need to select from available tools. We'll cover that later.

链条的工作方式略有不同。与 AI 智能体可以自主「决定」做什么以及如何行动不同，链条只是一系列预先设定好的步骤。不过，链条仍然可以使用工具，也就是说，它们可以包含一个从可用工具中进行选择的步骤。我们将在后面详细介绍这一点。

image by author

Step 1:

A query is sent by the user to the Agent. A prompt is used to add some history and to tell the LLM what is expected from it (usually, to answer the question)

The LLM takes the query and based on the available tools will decide if it needs to use one or not and what will the steps be.

Step 2:

Once the LLM has found the right tool, it produces an instruction to tell the agent how to call the tool. It tells:

- the function that needs to be called

- the arguments that go with it

Step 3:

Once called, the API returns an output. This output can then be

- returned directly to the user via the Agent

### 3. Creating a simple chat without Tools

创建一个没有工具的简单聊天

To illustrate our point, we will first of all see how our LLM performs as-is, without any help.

为了更好地说明这一点，我们先来看看我们的大语言模型在没有任何工具辅助的情况下，表现如何。

Let's install the needed libraries:

首先，我们需要安装一些必要的库：

vertexai==1.65.0
langchain==0.2.16
langchain-community==0.2.16
langchain-core==0.2.38
langchain-google-community==1.0.8
langchain-google-vertexai==1.0.6

And create our very simple chat using Google's Gemini LLM:

```py
from vertexai.generative_models import (
    GenerativeModel,
    GenerationConfig,
    Part
)

gemini_model = GenerativeModel(
    "gemini-1.5-flash",
    generation_config=GenerationConfig(temperature=0),
)
chat = gemini_model.start_chat()
```

接下来，我们将使用 Google Gemini 大语言模型创建一个非常简单的聊天应用：

If you run this simple chat and ask a question about the current exchange rate, you might probably get a similar answer:

Not surprising, as we know LLMs do not have access to real-time data.

如果运行一个简单的聊天程序，并提问关于当前汇率的问题，你很可能会得到一个类似的回答：

这并不令人惊讶，因为我们知道大语言模型（LLM）无法获取实时的信息数据。

Let's add a tool for that. Our tool will be little function that calls an API to retrieve exchange rate data in real time.

让我们为此添加一个工具。我们的工具将是一个函数，它调用 API 实时获取汇率数据。

```py
def get_exchange_rate_from_api(params):
    url = f"https://api.frankfurter.app/latest?from={params['currency_from']}&to={params['currency_to']}"
    print(url)
    api_response = requests.get(url)
    return api_response.text

\# Try it out !
get_exchange_rate_from_api({'currency_from': 'USD', 'currency_to': 'EUR'})
---
'{"amount":1.0,"base":"USD","date":"2024-11-20","rates":{"EUR":0.94679}}'
```

Now we know how our tools works, we would like to tell our chat LLM to use this function to answer our question. We will therefore create a mono-tool agent. To do that, we have several options which I will list here:

现在我们知道了工具的工作原理，我们希望让聊天大语言模型（LLM）使用这个函数来回答问题。因此，我们将创建一个使用单一工具的 AI 智能体。为此，我们有以下几种选择：

1 Use Google's Gemini chat API with Function Calling

通过 Google 的 Gemini chat API 使用函数调用功能

2 Use LangChain's API with Agents and Tools

通过 LangChain 的 API 使用 AI 智能体和工具

Both have their advantages and drawbacks. The purpose of this article is also to show you the possibilities and let you decide which one you prefer.

两者各有优劣。本文旨在展示各种可能性，并帮助您决定哪种方式更适合您。

2『

报错：

Traceback (most recent call last):
  File "/Users/Daglas/dalong.llm/dalong.langchain/translate-audio-gemini.py", line 15, in <module>
    gemini_model = GenerativeModel(
  File "/Users/Daglas/miniconda3/envs/gemini/lib/python3.10/site-packages/vertexai/generative_models/_generative_models.py", line 335, in __init__
    project = aiplatform_initializer.global_config.project
  File "/Users/Daglas/miniconda3/envs/gemini/lib/python3.10/site-packages/google/cloud/aiplatform/initializer.py", line 338, in project
    raise GoogleAuthError(project_not_found_exception_str) from exc
google.auth.exceptions.GoogleAuthError: Unable to find your project. Please provide a project ID by:
- Passing a constructor argument
- Using vertexai.init()
- Setting project using 'gcloud config set project my-project'
- Setting a GCP environment variable
- To create a Google Cloud project, please follow guidance at https://developers.google.com/workspace/guides/create-project

---

Traceback (most recent call last):
  File "/Users/Daglas/dalong.llm/dalong.langchain/translate-audio-gemini.py", line 63, in <module>
    test()
  File "/Users/Daglas/dalong.llm/dalong.langchain/translate-audio-gemini.py", line 28, in test
    response = chat.send_message("What is the current exchange rate for USD vs EUR ?")
  File "/Users/Daglas/miniconda3/envs/gemini/lib/python3.10/site-packages/vertexai/generative_models/_generative_models.py", line 1116, in send_message
    return self._send_message(
  File "/Users/Daglas/miniconda3/envs/gemini/lib/python3.10/site-packages/vertexai/generative_models/_generative_models.py", line 1236, in _send_message
    response = self._model._generate_content(
  File "/Users/Daglas/miniconda3/envs/gemini/lib/python3.10/site-packages/vertexai/generative_models/_generative_models.py", line 700, in _generate_content
    gapic_response = self._prediction_client.generate_content(request=request)
  File "/Users/Daglas/miniconda3/envs/gemini/lib/python3.10/site-packages/vertexai/generative_models/_generative_models.py", line 372, in _prediction_client
    aiplatform_initializer.global_config.create_client(
  File "/Users/Daglas/miniconda3/envs/gemini/lib/python3.10/site-packages/google/cloud/aiplatform/initializer.py", line 559, in create_client
    "credentials": credentials or self.credentials,
  File "/Users/Daglas/miniconda3/envs/gemini/lib/python3.10/site-packages/google/cloud/aiplatform/initializer.py", line 371, in credentials
    self._set_project_as_env_var_or_google_auth_default()
  File "/Users/Daglas/miniconda3/envs/gemini/lib/python3.10/site-packages/google/cloud/aiplatform/initializer.py", line 108, in _set_project_as_env_var_or_google_auth_default
    credentials, _ = google.auth.default()
  File "/Users/Daglas/miniconda3/envs/gemini/lib/python3.10/site-packages/google/auth/_default.py", line 697, in default
    raise exceptions.DefaultCredentialsError(_CLOUD_SDK_MISSING_CREDENTIALS)
google.auth.exceptions.DefaultCredentialsError: Your default credentials were not found. To set up Application Default Credentials, see https://cloud.google.com/docs/authentication/external/set-up-adc for more information.

[安装 gcloud CLI  |  Google Cloud CLI Documentation](https://cloud.google.com/sdk/docs/install?hl=zh-cn)

2025-01-03

目前还是没解决 vpn 连 Google 的问题。

』

### 4. Adding Tools to our chat: The Google way with Function Calling

为聊天功能添加工具：Google 的函数调用方法

There are basically two ways of creating a tool out of a function.

基本上，有两种方法可以从一个函数创建一个工具。

The 1st one is a "dictionary" approach where you specify inputs and description of the function in the Tool. The imporant parameters are:

第一种方法是采用「字典」的方式，在工具中，你需要指定函数的输入和描述。关键参数包括：

1 Name of the function (be explicit)

函数名称（请明确指出)

2 Description : be verbose here, as a solid and exhaustive description will help the LLM select the right tool

描述：在此处详细说明，因为详尽且全面的描述将有助于大语言模型（Large Language Model，LLM）选择合适的工具

3 Parameters : this is where you specify your arguments (type and description). Again, be verbose in the description of your arguments to help the LLM know how to pass value to your function

参数：在这里指定你的参数（类型和描述）。请详细描述你的参数，以便大语言模型（LLM）知道如何为你的函数赋值。


```py
import requests

from vertexai.generative_models import FunctionDeclaration

get_exchange_rate_func = FunctionDeclaration(
    name="get_exchange_rate",
    description="Get the exchange rate for currencies between countries",
    parameters={
    "type": "object",
    "properties": {
        "currency_from": {
            "type": "string",
            "description": "The currency to convert from in ISO 4217 format"
        },
        "currency_to": {
            "type": "string",
            "description": "The currency to convert to in ISO 4217 format"
        }
    },
        "required": [
            "currency_from",
            "currency_to",
      ]
  },
)
```

The 2nd way of adding a tool using Google's SDK is with a from_func instantiation. This requires editing our original function to be more explicit, with a docstring, etc. Instead of being verbose in the Tool creation, we are being verbose in the function creation.

使用 Google 的 SDK 添加工具的第二种方法是通过 `from_func` 方法创建实例。这需要我们修改原有的函数，使其更加明确，例如添加文档字符串等。这种方式不是在创建工具时编写很多代码，而是在创建函数时编写很多代码。

```py
\# Edit our function
def get_exchange_rate_from_api(currency_from: str, currency_to: str):
    """
    Get the exchange rate for currencies   
  
    Args:
        currency_from (str): The currency to convert from in ISO 4217 format
        currency_to (str): The currency to convert to in ISO 4217 format
    """
    url = f"https://api.frankfurter.app/latest?from={currency_from}&to={currency_to}"
    api_response = requests.get(url)
    return api_response.text

\# Create the tool
get_exchange_rate_func = FunctionDeclaration.from_func(
  get_exchange_rate_from_api
)
```

The next step is really about creating the tool. For that, we will add our FunctionDeclaration to a list to create our Tool object:

接下来，我们真正要做的就是创建工具。为此，我们需要将 `FunctionDeclaration` 添加到一个列表中，从而构建出我们的 `Tool` 对象：

from vertexai.generative_models import Tool as VertexTool

```py
tool = VertexTool(
    function_declarations=[
        get_exchange_rate_func,
        # add more functions here !
    ]
)
```

Let's now pass that to our chat and see if it now can answer our query about exchange rates ! Remember, without tools, our chat answered:

现在，让我们将这个 `Tool` 对象传递给聊天功能，看看它是否能够回答关于汇率的查询！请记住，在没有工具的情况下，聊天功能的回答是：

Let's try Google's Function calling tool and see if this helps ! First, let's send our query to the chat:

我们来尝试一下 Google 的函数调用工具，看看它是否能提供帮助！首先，将我们的查询发送给聊天界面：

```py
from vertexai.generative_models import GenerativeModel

gemini_model = GenerativeModel(
    "gemini-1.5-flash",
    generation_config=GenerationConfig(temperature=0),
    tools=[tool] #We add the tool here !
)
chat = gemini_model.start_chat()

response = chat.send_message(prompt)

\# Extract the function call response
response.candidates[0].content.parts[0].function_call

--- OUTPUT ---
"""
name: "get_exchange_rate"
args {
  fields {
    key: "currency_to"
    value {
      string_value: "EUR"
    }
  }
  fields {
    key: "currency_from"
    value {
      string_value: "USD"
    }
  }
  fields {
    key: "currency_date"
    value {
      string_value: "latest"
    }
  }
}"""
```

The LLM correctly guessed it needed to use the get_exchange_rate function, and also correctly guessed the 2 parameters were USD and EUR .

大语言模型（LLM）准确判断出需要调用 `get_exchange_rate` 函数，并且正确识别出所需的两个参数为 USD 和 EUR 。

But this is not enough. What we want now is to actually run this function to get our results!

但这还不够。接下来，我们需要实际运行这个函数来得到结果！

```py
\# mapping dictionnary to map function names and function
function_handler = {
    "get_exchange_rate": get_exchange_rate_from_api,
}

\# Extract the function call name
function_name = function_call.name
print("#### Predicted function name")
print(function_name, "\n")

\# Extract the function call parameters
params = {key: value for key, value in function_call.args.items()}
print("#### Predicted function parameters")
print(params, "\n")

function_api_response = function_handler[function_name](params)
print("#### API response")
print(function_api_response)
response = chat.send_message(
    Part.from_function_response(
        name=function_name,
        response={"content": function_api_response},
    ),
)   
print("\n#### Final Answer")
print(response.candidates[0].content.parts[0].text)

--- OUTPUT ---
"""
\#### Predicted function name
get_exchange_rate 

\#### Predicted function parameters
{'currency_from': 'USD', 'currency_date': 'latest', 'currency_to': 'EUR'} 


\#### API response
{"amount":1.0,"base":"USD","date":"2024-11-20","rates":{"EUR":0.94679}}

\#### Final Answer
The current exchange rate for USD vs EUR is 0.94679. This means that 1 USD is equal to 0.94679 EUR. 
"""
```

We can now see our chat is able to answer our question! It:

现在，我们可以看到聊天机器人已经能够回答我们的问题了！具体来说，它：

Correctly guessed to function to call, get_exchange_rate

成功识别出需要调用的函数是 get_exchange_rate

Correctly assigned the parameters to call the function {‘currency_from': ‘USD', ‘currency_to': ‘EUR'}

成功将参数赋值给函数：{'currency_from'：'USD'，'currency_to'：'EUR'}

Got results from the API

And nicely formatted the answer to be human-readable!

从 API 中获取了结果并且将答案进行了格式化，使其更易于人类阅读！

Let's now see another way of doing with LangChain.

接下来，我们来看看使用 LangChain 实现的另一种方法。

### 5. Adding Tools to our chat: The Langchain way with Agents

为聊天机器人添加工具：LangChain 智能体（Agent）的方法

LangChain is a composable framework to build with LLMs. It is the orchestration framework for controllable agentic workflows.

LangChain 是一个用于构建大语言模型（LLM）应用的可组合框架。它是用于编排可控 AI 智能体工作流的框架。

Similar to what we did before the "Google" way, we will build tools in the Langchain way. Let's begin with defining our functions. Same as for Google, we need to be exhaustive and verbose in the docstrings:

类似于我们之前采用「谷歌」方式的做法，我们将使用 LangChain 来构建工具。让我们从定义函数开始。与谷歌类似，我们需要在文档字符串中提供详尽且详细的说明：

```py
from langchain_core.tools import tool

@tool
def get_exchange_rate_from_api(currency_from: str, currency_to: str) -> str:
    """
    Return the exchange rate between currencies
    Args:
        currency_from: str
        currency_to: str
    """
    url = f"https://api.frankfurter.app/latest?from={currency_from}&to={currency_to}"
    api_response = requests.get(url)
    return api_response.text
```

In order to spice things up, I will add another tool which can list tables in a BigQuery dataset. Here is the code:

为了使过程更具吸引力，我将引入一个新工具，它可以列出 BigQuery 数据集中的所有数据表。代码如下：

```py
@tool
def list_tables(project: str, dataset_id: str) -> list:
    """
    Return a list of Bigquery tables
    Args:
        project: GCP project id
        dataset_id: ID of the dataset
    """
    client = bigquery.Client(project=project)
    try:
        response = client.list_tables(dataset_id)
        return [table.table_id for table in response]
    except Exception as e:
        return f"The dataset {params['dataset_id']} is not found in the {params['project']} project, please specify the dataset and project"
```

Add once done, we add our functions to our LangChain toolbox !

完成添加后，我们会将这些函数加入到 LangChain 工具箱中！

```py
langchain_tool = [
    list_tables,
    get_exchange_rate_from_api
]
```

To build our agent, we will use the AgentExecutorobject from LangChain. This object will basically take 3 components, which are the ones we defined earlier :

为了构建我们的 AI 智能体，我们将使用 LangChain 提供的 AgentExecutor 工具。这个工具会使用 3 个组件，即我们之前定义的组件：

1 A LLM

一个大语言模型（LLM)

2 A prompt

3 And tools.

一个提示以及相关工具。

Let's first choose our LLM:

首先，我们来选择一个大语言模型：

```
gemini_llm = ChatVertexAI(model="gemini-1.5-flash")
```

Then we create a prompt to manage the conversation:

然后我们创建一个提示来引导对话：

```py
prompt = ChatPromptTemplate.from_messages(
    [
        ("system", "You are a helpful assistant"),
        ("human", "{input}"),
        # Placeholders fill up a **list** of messages
        ("placeholder", "{agent_scratchpad}"),
    ]
)
```

And finally, we create the AgentExecutor and run a query:

最后，我们创建 AI 智能体执行器（AgentExecutor）并运行一个查询：

```py
agent = create_tool_calling_agent(gemini_llm, langchain_tools, prompt)
agent_executor = AgentExecutor(agent=agent, tools=langchain_tools)
agent_executor.invoke({
    "input": "Which tables are available in the thelook_ecommerce dataset ?"
})

--- OUTPUT ---
"""
{'input': 'Which tables are available in the thelook_ecommerce dataset ?',
 'output': 'The dataset `thelook_ecommerce` is not found in the `gcp-project-id` project. 
            Please specify the correct dataset and project. \n'}
"""
```

Hmmm. Seems like the agent is missing one argument, or at least asking for more information…Let's reply by giving this information:

好的。看来 AI 智能体（agent）似乎缺少必要的输入信息，或者至少需要补充更多信息。我们通过提供这些信息来回复：

agent_executor.invoke({"input": f"Project id is bigquery-public-data"})

--- OUPTUT ---
"""
{'input': 'Project id is bigquery-public-data',
 'output': 'OK. What else can I do for you? \n'}
"""

Well, seems we're back to square one. The LLM has been told the project id but forgot about the question. Our agent seems to be lacking memory to remember previous questions and answers. Maybe we should think of…

好吧，看来我们又回到了最初的状态。大语言模型（LLM）虽然获得了项目 ID，却忘记了之前的问题。我们的 AI 智能体（agent）似乎不具备记忆功能，无法记住之前的问题和答案。或许我们应该考虑……

### 6. Adding Memory to our Agent

为我们的智能体添加记忆功能

Memory is another concept in Agents, which basically helps the system to remember the conversation history and avoid endless loops like above. Think of memory as being a notepad where the LLM keeps track of previous questions and answers to build context around the conversation.

记忆是智能体中另一个重要的概念，它主要帮助系统记住对话的历史记录，从而避免像前面提到的那样陷入无限循环。你可以把记忆功能想象成一个笔记本，大语言模型在上面记录之前的提问和回答，以此来构建对话的上下文。

We will modify our prompt (instructions) to the model to include memory:

我们将修改给模型的提示，使其具有记忆功能：

```py
from langchain_core.chat_history import InMemoryChatMessageHistory
from langchain_core.runnables.history import RunnableWithMessageHistory

\# Different types of memory can be found in Langchain
memory = InMemoryChatMessageHistory(session_id="foo")

prompt = ChatPromptTemplate.from_messages(
    [
        ("system", "You are a helpful assistant."),
        # First put the history
        ("placeholder", "{chat_history}"),
        # Then the new input
        ("human", "{input}"),
        # Finally the scratchpad
        ("placeholder", "{agent_scratchpad}"),
    ]
)

\# Remains unchanged
agent = create_tool_calling_agent(gemini_llm, langchain_tools, prompt)
agent_executor = AgentExecutor(agent=agent, tools=langchain_tools)

\# We add the memory part and the chat history
agent_with_chat_history = RunnableWithMessageHistory(
    agent_executor,
    lambda session_id: memory, #<-- NEW
    input_messages_key="input", 
    history_messages_key="chat_history", #<-- NEW
)

config = {"configurable": {"session_id": "foo"}}
```

We will now rerun our query from the beginning:

我们现在将重新执行查询：

```py
agent_with_chat_history.invoke({
    "input": "Which tables are available in the thelook_ecommerce dataset ?"
    }, 
    config
)

--- OUTPUT ---
"""
{'input': 'Which tables are available in the thelook_ecommerce dataset ?',
 'chat_history': [],
 'output': 'The dataset `thelook_ecommerce` is not found in the `gcp-project-id` project. Please specify the correct dataset and project. \n'}
"""
```

With an empty chat history, the model still asks for the project id. Pretty consistent with what we had before with a memoryless agent. Let's reply to the agent and add the missing information:

即使聊天记录是空的，模型仍然会要求提供项目 ID。这和我们之前用过的无记忆 AI 智能体（AI Agent）表现非常相似。现在，我们来回复这个 AI 智能体，并补上它所缺失的信息。

```py
reply = "Project id is bigquery-public-data"
agent_with_chat_history.invoke({"input": reply}, config)

--- OUTPUT ---
"""
{'input': 'Project id is bigquery-public-data',
 'chat_history': [HumanMessage(content='Which tables are available in the thelook_ecommerce dataset ?'),
  AIMessage(content='The dataset `thelook_ecommerce` is not found in the `gcp-project-id` project. Please specify the correct dataset and project. \n')],
 'output': 'The following tables are available in the `thelook_ecommerce` dataset:\n- distribution_centers\n- events\n- inventory_items\n- order_items\n- orders\n- products\n- users \n'}
"""
```

Notice how, in the output:

请注意，在输出中：

The `chat history` keeps track of the previous Q&A

「聊天记录」会记录之前的问答过程。

The output now returns the list of the tables!

现在，输出会返回表格列表！

```
'output': 'The following tables are available in the `thelook_ecommerce` dataset:\n- distribution_centers\n- events\n- inventory_items\n- order_items\n- orders\n- products\n- users \n'}
```

In some use cases however, certain actions might require special attention because of their nature (ie deleting an entry in a database, editing information, sending an email, etc.). Full automation without control might leads to situations where the agent takes wrong decisions and creates damage.

不过，在某些应用场景下，有些操作因其特殊性需要格外留意，例如删除数据库中的记录、修改信息、发送邮件等等。如果在没有人工干预的情况下完全自动化，可能会导致 AI 智能体（AI Agent）做出错误的决策，从而造成损失。

One way to secure our workflows is to add a human-in-the-loop step.

保护我们工作流程的一种方法是增加人工参与的步骤。

### 7. Creating a Chain with a Human Validation step

创建一个包含人工验证环节的流程

A chain is somehow different from an agent. Whereas the agent can decide to use or not to use tools, a chain is more static. It is a sequence of steps, for which we can still include a step where the LLM will choose from a set of tools.

链与智能体有所不同。智能体可以决定是否使用工具，而链则更为静态。链是一系列步骤，其中可以包含一个步骤，由大语言模型（LLM）从一组工具中选择。

To build chains in LangChain, we use LCEL.

为了在 LangChain 中构建链，我们使用 LCEL。

LangChain Expression Language, or LCEL, is a declarative way to easily compose chains together. Chains in LangChain use the pipe `|` operator to indicate the orders in which steps have to be executed, such as step 1 | step 2 | step 3 etc. The difference with Agents is that Chains will always follow those steps, whereas Agents can "decide" by themselves and are autonomous in their decision-making process.

LangChain 表达式语言（LCEL）是一种声明式方法，可以方便地将多个处理步骤组合成链。在 LangChain 中，链通过管道符 `|` 来指定步骤的执行顺序，例如：步骤 1 | 步骤 2 | 步骤 3 等。这与 AI 智能体不同，链会严格按照预定的步骤执行，而 AI 智能体则可以「自主」决策，在处理过程中具有更大的灵活性。

In our case, we will proceed as follows to build a simple prompt | llm chain.

在我们的示例中，我们将按以下步骤构建一个简单的提示 —— 大语言模型（LLM）链。

```py
\# define the prompt with memory
prompt = ChatPromptTemplate.from_messages(
    [
        ("system", "You are a helpful assistant."),
        # First put the history
        ("placeholder", "{chat_history}"),
        # Then the new input
        ("human", "{input}"),
        # Finally the scratchpad
        ("placeholder", "{agent_scratchpad}"),
    ]
)

\# bind the tools to the LLM
gemini_with_tools = gemini_llm.bind_tools(langchain_tool)

\# build the chain
chain = prompt | gemini_with_tools
```

Remember how in the previous step we passed an agent to our `RunnableWithMessageHistory`? Well, we will do the same here, but...

回想一下，在上一步中，我们将一个 AI 智能体传递给了 `RunnableWithMessageHistory`。同样的，我们在这里也会这样做，但是...

```py
\# With AgentExecutor

\# agent = create_tool_calling_agent(gemini_llm, langchain_tool, prompt)
\# agent_executor = AgentExecutor(agent=agent, tools=langchain_tool)

\# agent_with_chat_history = RunnableWithMessageHistory(
\#     agent_executor,
\#     lambda session_id: memory,
\#     input_messages_key="input",
\#     history_messages_key="chat_history",
\# )

config = {"configurable": {"session_id": "foo"}}

\# With Chains
memory = InMemoryChatMessageHistory(session_id="foo")
chain_with_history = RunnableWithMessageHistory(
    chain,
    lambda session_id: memory,
    input_messages_key="input",
    history_messages_key="chat_history",
)

response = chain_with_history.invoke(
    {"input": "What is the current CHF EUR exchange rate ?"}, config)

--- OUTPUT
"""
content='', 
additional_kwargs={
    'function_call': {
        'name': 'get_exchange_rate_from_api', 
        'arguments': '{"currency_from": "CHF", "currency_to": "EUR"}'
    }
}
"""
```

Unlike the agent, a chain does not provide the answer unless we tell it to. In our case, it stopped at the step where the LLM returns the function that needs to be called.

与 AI 智能体不同，除非我们明确指示，否则任务链不会直接给出答案。在本例中，任务链会在大语言模型返回需要调用的函数后停止。

We need to add an extra step to actually call the tool. Let's add another function to call the tools:

为了真正使用工具，我们需要增加一个额外的步骤来调用它。让我们添加一个新函数来实现工具的调用：

```py
from langchain_core.messages import AIMessage

def call_tools(msg: AIMessage) -> list[dict]:
    """Simple sequential tool calling helper."""
    tool_map = {tool.name: tool for tool in langchain_tool}
    tool_calls = msg.tool_calls.copy()
    for tool_call in tool_calls:
        tool_call["output"] = tool_map[tool_call["name"]].invoke(tool_call["args"])
    return tool_calls

chain = prompt | gemini_with_tools | call_tools #<-- Extra step

chain_with_history = RunnableWithMessageHistory(
    chain,
    lambda session_id: memory,
    input_messages_key="input",
    history_messages_key="chat_history",
)

\# Rerun the chain 
chain_with_history.invoke({"input": "What is the current CHF EUR exchange rate ?"}, config)
```

We now get the following output, which shows the API has been successfully called:

现在，我们得到了如下的输出结果，这表明 API 已经成功调用：

```
[{'name': 'get_exchange_rate_from_api',
  'args': {'currency_from': 'CHF', 'currency_to': 'EUR'},
  'id': '81bc85ea-dfd4-4c01-85e8-f3ca592fff5b',
  'type': 'tool_call',
  'output': '{"amount":1.0,"base":"USD","date":"2024-11-20","rates":{"EUR":0.94679}}'
}]
```

Now we understood how to chain steps, let's add our human-in-the-loop step ! We want this step to check that the LLM has understood our requests and will make the right call to an API. If the LLM has misunderstood the request or will use the function incorrectly, we can decide to interrupt the process.

现在我们了解了如何链接步骤，让我们加入人工介入步骤！我们希望这个步骤检查大语言模型是否理解了我们的请求，并且正确调用 API。如果大语言模型误解了请求或者不正确地使用 API，我们可以选择中断流程。

```py
def human_approval(msg: AIMessage) -> AIMessage:
    """Responsible for passing through its input or raising an exception.

    Args:
        msg: output from the chat model

    Returns:
        msg: original output from the msg
    """
    for tool_call in msg.tool_calls:
        print(f"I want to use function [{tool_call.get('name')}] with the following parameters :")
        for k,v in tool_call.get('args').items():
            print(" {} = {}".format(k, v))
            
    print("")
    input_msg = (
        f"Do you approve (Y|y)?\n\n"
        ">>>"
    )
    resp = input(input_msg)
    if resp.lower() not in ("yes", "y"):
        raise NotApproved(f"Tool invocations not approved:\n\n{tool_strs}")
    return msg
```

Next, add this step to the chain before the function call:

```py
chain = prompt | gemini_with_tools | human_approval | call_tools

memory = InMemoryChatMessageHistory(session_id="foo")

chain_with_history = RunnableWithMessageHistory(
    chain,
    lambda session_id: memory,
    input_messages_key="input",
    history_messages_key="chat_history",
)

chain_with_history.invoke({"input": "What is the current CHF EUR exchange rate ?"}, config)
```

接下来，在调用函数之前，我们要在流程中加入这样一个步骤：

You will then be asked to confirm that the LLM understood correctly:

你需要确认一下，大语言模型（LLM，Large Language Model）是否正确理解了你的意图。

This human-in-the-loop step can be very helpful for critical workflows where a misinterpretation from the LLM could have dramatic consequences.

这种人工参与的步骤对于关键工作流程非常有用，在这些工作流程中，大语言模型（LLM）的误解可能会导致严重问题。

### 8. Using search tools

使用搜索工具

One of the most convenient tools to retrieve information in real-time are search engines . One way to do that is to use GoogleSerperAPIWrapper (you will need to register to get an API key in order to use it), which provides a nice interface to query Google Search and get results quickly.

搜索引擎是实时获取信息最便捷的工具之一。其中一种方法是使用 GoogleSerperAPIWrapper（使用该工具需要注册并获取 API 密钥），它提供了一个友好的界面，可以快速查询 Google 搜索并获得结果。

Luckily, LangChain already provides a tool for you, so we won't have to write the function ourselves.

幸运的是，LangChain 已经提供了一个现成的工具，我们无需自己编写函数。

Let's therefore try to ask a question on yesterday's event (Nov 20th) and see if our agent can answer. Our question is about Rafael Nadal's last official game (which he lost to van de Zandschulp).

现在，让我们尝试询问一个关于昨天（11 月 20 日）发生事件的问题，看看我们的 AI 智能体是否能回答。我们的问题是关于拉斐尔·纳达尔的最后一场正式比赛，那场比赛他输给了范德赞德舒尔普。

```py
agent_with_chat_history.invoke(
    {"input": "What was the result of Rafael Nadal's latest game ?"}, config)

--- OUTPUT ---
"""
{'input': "What was the result of Rafael Nadal's latest game ?",
 'chat_history': [],
 'output': "I do not have access to real-time information, including sports results. To get the latest information on Rafael Nadal's game, I recommend checking a reliable sports website or news source. \n"}
"""
```

Without being able to access Google Search, our model is unable to answer because this information was not available at the time it was trained.

由于模型无法访问 Google 搜索，因此无法回答这个问题，因为相关信息在模型训练时并未被收录。

Let's now add our Serper tool to our toolbox and see if our model can use Google Search to find the information:

现在，我们将 Serper 工具加入模型的功能中，看看它是否能够利用 Google 搜索来获取所需信息。

```py
from langchain_community.utilities import GoogleSerperAPIWrapper

\# Create our new search tool here
search = GoogleSerperAPIWrapper(serper_api_key="...")

@tool
def google_search(query: str):
    """
    Perform a search on Google
    Args:
        query: the information to be retrieved with google search
    """
    return search.run(query)

\# Add it to our existing tools
langchain_tool = [
    list_datasets,
    list_tables,
    get_exchange_rate_from_api,
    google_search
]

\# Create agent
agent = create_tool_calling_agent(gemini_llm, langchain_tool, prompt)
agent_executor = AgentExecutor(agent=agent, tools=langchain_tool)

\# Add memory
memory = InMemoryChatMessageHistory()
agent_with_chat_history = RunnableWithMessageHistory(
    agent_executor,
    lambda session_id: memory,
    input_messages_key="input",
    history_messages_key="chat_history",
)
```

And rerun our query :

接下来，我们重新执行查询：

```py
agent_with_chat_history.invoke({"input": "What was the result of Rafael Nadal's latest game ?"}, config)

--- OUTPUT ---
"""
{'input': "What was the result of Rafael Nadal's latest game ?",
 'chat_history': [],
 'output': "Rafael Nadal's last match was a loss to Botic van de Zandschulp in the Davis Cup. Spain was eliminated by the Netherlands. \n"}
"""
```

### Conclusion

结论

LLMs alone often hit a blocker when it comes to using personal, corporate, private or real-data. Indeed, such information is generally not available at training time. Agents and tools are a powerful way to augment these models by allowing them to interact with systems and APIs, and orchestrate workflows to boost productivity.

当单独使用大语言模型（LLM）时，在处理个人、公司、私有或真实数据时，常常会遇到瓶颈。这是因为这些信息通常在模型训练时是无法获取的。AI 智能体（AI Agent）和工具提供了一种强大的解决方案，它们能够让大语言模型与系统和应用程序接口（API）互动，并协调工作流程，从而显著提高生产力。

## 原文

### 1. The problem with LLMs

So you have your favorite chatbot, and you use it for your daily job to boost your productivity. It can translate text, write nice emails, tell jokes, etc. And then comes the day when your colleague comes to you and asks :

"Do you know the current exchange rate between USD and EUR ? I wonder if I should sell my EUR…"

You ask your favorite chatbot, and the answer pops:

What is the problem here ?

The problem is that you have stumbled on one of the shortcomings of LLMs. Large Language Models (LLMs) are powerful at solving many types of problems, such as problem solving, text summarization, generation, etc.

However, they are constrained by the following limitations:

They are frozen after training, leading to stale knowledge.

They can't query or modify external data.

Same way as we are using search engines every day, reading books and documents or querying databases, we would ideally want to provide this knowledge to our LLM to make it more efficient.

Fortunately, there is a way to do that: Tools and Agents.

Foundational models, despite their impressive text and image generation, remain constrained by their inability to interact with the outside world. Tools bridge this gap, empowering agents to interact with external data and services while unlocking a wider range of actions beyond that of the underlying model alone

(source : Google Agents whitepaper)

Using agents and tools, we could then be able to, from our chat interface:

retrieve data from our own documents

read / send emails

interact with internal databases

perform real time Google searches

etc.

### 2. What are Agents, Tools and Chains ?

An agent is an application which attempts to achieve a goal (or a task) by having at its disposal a set of tools and taking decisions based on its observations of the environment.

A good example of an agent could be you, for example: if you need to compute a complex mathematical operation (goal), you could use a calculator (tool #1), or a programming language (tool #2). Maybe you would choose the calculator to do a simple addition, but choose tool #2 for more complex algorithms.

Agents are therefore made of :

A model : The brain in our agent is the LLM. It will understand the query (the goal), and browse through its tools available to select the best.

One or more tools : These are functions, or APIs, that are responsible for performing a specific action (ie: retrieving the current currency rate for USD vs EUR, adding numbers, etc.)

An orchestration process: this is how the model will behave when asked to solve a task. It is a cognitive process that defines how the model will analyze the problem, refine inputs, choose a tool, etc. Examples of such processes are ReAct, CoT (Chain of Thought), ToT (Tree-of-Thought)

Here is below a workflow explanation

image by author

Chains are somehow different. Whereas agents can ‘decide' by themselves what to do and which steps to take, chains are just a sequence of predefined steps. They can still rely on tools though, meaning that they can include a step in which they need to select from available tools. We'll cover that later.

### 3. Creating a simple chat without Tools

To illustrate our point, we will first of all see how our LLM performs as-is, without any help.

Let's install the needed libraries :

And create our very simple chat using Google's Gemini LLM:

If you run this simple chat and ask a question about the current exchange rate, you might probably get a similar answer:

Not surprising, as we know LLMs do not have access to real-time data.

Let's add a tool for that. Our tool will be little function that calls an API to retrieve exchange rate data in real time.

Now we know how our tools works, we would like to tell our chat LLM to use this function to answer our question. We will therefore create a mono-tool agent. To do that, we have several options which I will list here:

Use Google's Gemini chat API with Function Calling

Use LangChain's API with Agents and Tools

Both have their advantages and drawbacks. The purpose of this article is also to show you the possibilities and let you decide which one you prefer.

### 4. Adding Tools to our chat: The Google way with Function Calling

There are basically two ways of creating a tool out of a function.

The 1st one is a "dictionary" approach where you specify inputs and description of the function in the Tool. The imporant parameters are:

Name of the function (be explicit)

Description : be verbose here, as a solid and exhaustive description will help the LLM select the right tool

Parameters : this is where you specify your arguments (type and description). Again, be verbose in the description of your arguments to help the LLM know how to pass value to your function

The 2nd way of adding a tool using Google's SDK is with a from_func instantiation. This requires editing our original function to be more explicit, with a docstring, etc. Instead of being verbose in the Tool creation, we are being verbose in the function creation.

The next step is really about creating the tool. For that, we will add our FunctionDeclaration to a list to create our Tool object:

Let's now pass that to our chat and see if it now can answer our query about exchange rates ! Remember, without tools, our chat answered:

Let's try Google's Function calling tool and see if this helps ! First, let's send our query to the chat:

The LLM correctly guessed it needed to use the get_exchange_rate function, and also correctly guessed the 2 parameters were USD and EUR .

But this is not enough. What we want now is to actually run this function to get our results!

We can now see our chat is able to answer our question! It:

Correctly guessed to function to call, get_exchange_rate

Correctly assigned the parameters to call the function {‘currency_from': ‘USD', ‘currency_to': ‘EUR'}

Got results from the API

And nicely formatted the answer to be human-readable!

Let's now see another way of doing with LangChain.

### 5. Adding Tools to our chat: The Langchain way with Agents

LangChain is a composable framework to build with LLMs. It is the orchestration framework for controllable agentic workflows.

Similar to what we did before the "Google" way, we will build tools in the Langchain way. Let's begin with defining our functions. Same as for Google, we need to be exhaustive and verbose in the docstrings:

In order to spice things up, I will add another tool which can list tables in a BigQuery dataset. Here is the code:

Add once done, we add our functions to our LangChain toolbox !

To build our agent, we will use the AgentExecutorobject from LangChain. This object will basically take 3 components, which are the ones we defined earlier :

A LLM

A prompt

And tools.

Let's first choose our LLM:

gemini_llm = ChatVertexAI(model="gemini-1.5-flash")

Then we create a prompt to manage the conversation:

And finally, we create the AgentExecutor and run a query:

Hmmm. Seems like the agent is missing one argument, or at least asking for more information…Let's reply by giving this information:

Well, seems we're back to square one. The LLM has been told the project id but forgot about the question. Our agent seems to be lacking memory to remember previous questions and answers. Maybe we should think of…

### 6. Adding Memory to our Agent

Memory is another concept in Agents, which basically helps the system to remember the conversation history and avoid endless loops like above. Think of memory as being a notepad where the LLM keeps track of previous questions and answers to build context around the conversation.

We will modify our prompt (instructions) to the model to include memory:

We will now rerun our query from the beginning:

With an empty chat history, the model still asks for the project id. Pretty consistent with what we had before with a memoryless agent. Let's reply to the agent and add the missing information:

Notice how, in the output:

The `chat history` keeps track of the previous Q&A

The output now returns the list of the tables!

In some use cases however, certain actions might require special attention because of their nature (ie deleting an entry in a database, editing information, sending an email, etc.). Full automation without control might leads to situations where the agent takes wrong decisions and creates damage.

One way to secure our workflows is to add a human-in-the-loop step.

### 7. Creating a Chain with a Human Validation step

A chain is somehow different from an agent. Whereas the agent can decide to use or not to use tools, a chain is more static. It is a sequence of steps, for which we can still include a step where the LLM will choose from a set of tools.

To build chains in LangChain, we use LCEL.

LangChain Expression Language, or LCEL, is a declarative way to easily compose chains together. Chains in LangChain use the pipe `|` operator to indicate the orders in which steps have to be executed, such as step 1 | step 2 | step 3 etc. The difference with Agents is that Chains will always follow those steps, whereas Agents can "decide" by themselves and are autonomous in their decision-making process.

In our case, we will proceed as follows to build a simple prompt | llm chain.

Remember how in the previous step we passed an agent to our `RunnableWithMessageHistory`? Well, we will do the same here, but...

Unlike the agent, a chain does not provide the answer unless we tell it to. In our case, it stopped at the step where the LLM returns the function that needs to be called.

We need to add an extra step to actually call the tool. Let's add another function to call the tools:

We now get the following output, which shows the API has been successfully called:

Now we understood how to chain steps, let's add our human-in-the-loop step ! We want this step to check that the LLM has understood our requests and will make the right call to an API. If the LLM has misunderstood the request or will use the function incorrectly, we can decide to interrupt the process.

Next, add this step to the chain before the function call:

You will then be asked to confirm that the LLM understood correctly:

This human-in-the-loop step can be very helpful for critical workflows where a misinterpretation from the LLM could have dramatic consequences.

### 8. Using search tools

One of the most convenient tools to retrieve information in real-time are search engines . One way to do that is to use GoogleSerperAPIWrapper (you will need to register to get an API key in order to use it), which provides a nice interface to query Google Search and get results quickly.

Luckily, LangChain already provides a tool for you, so we won't have to write the function ourselves.

Let's therefore try to ask a question on yesterday's event (Nov 20th) and see if our agent can answer. Our question is about Rafael Nadal's last official game (which he lost to van de Zandschulp).

Without being able to access Google Search, our model is unable to answer because this information was not available at the time it was trained.

Let's now add our Serper tool to our toolbox and see if our model can use Google Search to find the information:

And rerun our query :

### Conclusion

LLMs alone often hit a blocker when it comes to using personal, corporate, private or real-data. Indeed, such information is generally not available at training time. Agents and tools are a powerful way to augment these models by allowing them to interact with systems and APIs, and orchestrate workflows to boost productivity.

## 问题解决


➜  ~ ./google-cloud-sdk/bin/gcloud init
Welcome! This command will take you through the configuration of gcloud.

Your current configuration has been set to: [default]

You can skip diagnostics next time by using the following flag:
  gcloud init --skip-diagnostics

Network diagnostic detects and fixes local network connection issues.
Checking network connection...done.
Reachability Check passed.
Network diagnostic passed (1/1 checks passed).

You must sign in to continue. Would you like to sign in (Y/n)?  y

Your browser has been opened to visit:

    https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=32555940559.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%3A8085%2F&scope=openid+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fappengine.admin+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsqlservice.login+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcompute+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Faccounts.reauth&state=c7ZBQG7D79IiEj7DTrWwgyv0qX32n2&access_type=offline&code_challenge=YYNWn_-0ZIh4YKeiRD_HY1PsMDkd8558gxABkYb4qBY&code_challenge_method=S256

You are signed in as: [daglas0514@gmail.com].

Pick cloud project to use:
 [1] gen-lang-client-0760690769
 [2] northern-shield-446616-k9
 [3] Enter a project ID
 [4] Create a new project
Please enter numeric choice or text value (must exactly match list item):  1

Your current project has been set to: [gen-lang-client-0760690769].

Not setting default zone/region (this feature makes it easier to use
[gcloud compute] by setting an appropriate default value for the
--zone and --region flag).
See https://cloud.google.com/compute/docs/gcloud-compute section on how to set
default compute region and zone manually. If you would like [gcloud init] to be
able to do this for you the next time you run it, make sure the
Compute Engine API is enabled for your project on the
https://console.developers.google.com/apis page.

Created a default .boto configuration file at [/Users/Daglas/.boto]. See this file and
[https://cloud.google.com/storage/docs/gsutil/commands/config] for more
information about configuring Google Cloud Storage.
The Google Cloud CLI is configured and ready to use!

* Commands that require authentication will use daglas0514@gmail.com by default
* Commands will reference project `gen-lang-client-0760690769` by default
Run `gcloud help config` to learn how to change individual settings

This gcloud configuration is called [default]. You can create additional configurations if you work with multiple accounts and/or projects.
Run `gcloud topic configurations` to learn more.

Some things to try next:

* Run `gcloud --help` to see the Cloud Platform services you can interact with. And run `gcloud help COMMAND` to get help on any gcloud command.
* Run `gcloud topic --help` to learn about advanced features of the CLI like arg files and output formatting
* Run `gcloud cheat-sheet` to see a roster of go-to `gcloud` commands.




