## From-Retrieval-to-Intelligence

[From Retrieval to Intelligence: Exploring RAG, Agent+RAG, and Evaluation with TruLens | by Vladyslav Fliahin | Dec, 2024 | Towards Data Science](https://towardsdatascience.com/from-retrieval-to-intelligence-exploring-rag-agent-rag-and-evaluation-with-trulens-3c518af836ce)

From Retrieval to Intelligence: Exploring RAG, Agent+RAG, and Evaluation with TruLens
Unlocking the Power of GPT-Generated Private Corpora

Vladyslav Fliahin

Published in Towards Data Science

Dec 4, 2024

### Introduction

引言

Nowadays the world has a lot of good foundation models to start your custom application with (gpt-4o, Sonnet, Gemini, Llama3.2, Gemma, Ministral, etc.). These models know everything about history, geography, and Wikipedia articles but still have weaknesses. Mostly there are two of them: level of details (e.g., the model knows about BMW, what it does, model names, and some more general info; but the model fails in case you ask about number of sales for Europe or details of the specific engine part) and the recent knowledge (e.g., Llama3.2 model or Ministral release; foundation models are trained at a certain point in time and have some knowledge cutoff date, after which the model doesn’t know anything).

如今，世界涌现出许多优秀的基础模型（foundation model），可以帮助你开发定制应用，例如 gpt-4o、Sonnet、Gemini、Llama3.2、Gemma 和 Ministral 等。这些模型掌握了历史、地理以及维基百科文章等方面的广泛知识，但仍然存在一些不足。主要体现在两个方面：一是细节理解程度，例如，模型可能了解宝马汽车的品牌、功能、型号名称以及其他一些基本信息，但如果询问欧洲的销量数据或特定发动机零件的详细信息，模型就难以给出准确回答；二是时效性知识，例如，Llama3.2 模型或 Ministral 模型发布之后的信息，由于基础模型是在特定时间点进行训练的，因此存在知识截止日期，模型无法获取此后的信息。

This article is focused on both issues, describing the situation of imaginary companies that were founded before the knowledge cutoff, while some information was changed recently.

本文重点关注以下两个问题：描述了知识截止日期前成立的虚构公司的情况，以及一些最近发生变化的信息。

To address both issues we will use the RAG technique and the LlamaIndex framework. The idea behind the Retrieval Augmented Generation is to supply the model with the most relevant information during the answer generation. This way we can have a DB with custom data, which the model will be able to utilize. To further assess the system performance we will incorporate the TruLens library and the RAG Triad metrics.

为了解决上述两个问题，我们将采用 RAG（检索增强生成）技术和 LlamaIndex 框架。RAG 的核心思想是在生成答案时，为模型提供最相关的信息。这样，我们就可以建立一个包含用户自定义数据的数据库，并让模型能够利用这些数据进行回答。为了更全面地评估系统性能，我们还将引入 TruLens 库和 RAG 三元组指标。

Mentioning the knowledge cutoff, this issue is addressed via google-search tools. Nevertheless, we can’t completely substitute the knowledge cutoff with the search tool. To understand this, imagine 2 ML specialists: first knows everything about the current GenAI state, and the second switched from the GenAI to the classic computer vision 6 month ago. If you ask them both the same question about how to use the recent GenAI models, it will take significantly different amount of search requests. The first one will know all about this, but maybe will double-check some specific commands. And the second will have to read a whole bunch of detailed articles to understand what’s going on first, what this model is doing, what is under the hood, and only after that he will be able to answer.

考虑到知识更新的滞后性，这个问题可以通过谷歌搜索工具来缓解。然而，我们不能完全依赖搜索工具来弥补知识更新的滞后。为了更好地理解这一点，假设有两位机器学习专家：第一位专家对最新的生成式 AI（GenAI）进展了如指掌，而第二位专家在 6 个月前从生成式 AI 转到了传统的计算机视觉领域。如果你向他们提出同一个关于如何使用最新的生成式 AI 模型的问题，他们所需的搜索次数会明显不同。第一位专家对这方面了如指掌，可能只会仔细核对一些具体的命令。而第二位专家则需要阅读大量的详细文章，先了解来龙去脉，理解这个模型的功能及其内部机制，才能给出答案。

Basically it is like comparison of the field-expert and some general specialists, when one can answer quickly, and the second should go googling because he doesn’t know all the details the first does.

这基本上就像是领域专家和一些普通专家的对比：前者可以快速给出答案，而后者则需要通过谷歌搜索来查找，因为后者不具备前者所掌握的全部细节知识。

The main point here is that a lot of googling provides comparable answer within a significantly longer timeframe. For in chat-like applications users won’t wait minutes for the model to google smth. In addition, not all the information is open and can be googled.

这里的重点是，通过大量谷歌搜索需要花费更长的时间才能找到类似的答案。在聊天应用中，用户不会愿意等几分钟让模型去谷歌搜索。而且，不是所有信息都是公开的，能通过谷歌搜索找到的。

### Data

Right now it may be hard to find a dataset, that is not previously used in the training data of the foundation model. Almost all the data is indexed and used during the large models' pretraining stage.

数据现在可能很难找到一个数据集，它没有在基础模型的训练数据中预先使用过。几乎所有的数据在大型模型预训练阶段都被索引并使用。

That’s why I decided to generate the one myself. For this purpose, I used the chatgpt-4o-latest via the OpenAI UI and several continuous prompts (all of them are similar to the ones below):

这就是我决定自己生成一张类似图像的原因。为此，我通过 OpenAI 的用户界面使用了 chatgpt-4o-latest 模型，并连续给出了几个类似的提示（如下所示)：

Generate me a private corpus with some details mentioning the imagined Ukraine Boats Inc.
A list of products, prices, responsible stuff, etc.
I want to use it as my private corpus for the RAG use-case
You can generate really a lot of the text. The more the better.

Yeah, proceed with partnerships, legal policies, competitions participated
Maybe info about where we manufacture our boats (and add some custom ones)

add client use studies

As a result, I generated a private corpus for 4 different companies. Below are the calculations of the tokens to better embrace the dataset size.

好的，我明白了。您希望我生成大量关于虚构公司「乌克兰船舶公司（Ukraine Boats Inc.)」的文本，以用作检索增强生成（RAG）系统中的私有语料库。这些文本应包括产品信息、定价、人员、制造细节、合作关系、法律政策、竞争历史、客户使用研究等。并且您希望另外三个虚构公司也生成类似的信息。让我们开始吧。

\# Number of tokens using the `o200k_base` tokenizer (gpt-4o/gpt-4o-mini)
nova-drive-motors.txt: 2757
aero-vance-aviation.txt: 1860
ukraine-boats.txt: 3793
city-solve.txt: 3826
total_tokens=12236

Below you can read the beginning of the Ukraine Boats Inc. description:

\#\# **Ukraine Boats Inc.**
**Corporate Overview:**
Ukraine Boats Inc. is a premier manufacturer and supplier of high-quality boats and maritime solutions based in Odessa, Ukraine. The company prides itself on blending traditional craftsmanship with modern technology to serve clients worldwide. Founded in 2005, the company has grown to be a leader in the boating industry, specializing in recreational, commercial, and luxury vessels.
 - -
\#\#\# **Product Lineup**
\#\#\#\# **Recreational Boats:**
1. **WaveRunner X200**
- **Description:** A sleek speedboat designed for water sports enthusiasts. Equipped with advanced navigation and safety features.
- **Price:** $32,000
- **Target Market:** Young adventurers and watersport lovers.
- **Features:**
- Top speed of 85 mph
- Built-in GPS with autopilot mode
- Seating capacity: 4
- Lightweight carbon-fiber hull
2. **AquaCruise 350**
- **Description:** A versatile motorboat ideal for fishing, family trips, and casual cruising.
- **Price:** $45,000
- **Features:**
- 12-person capacity
- Dual 300HP engines
- Modular interiors with customizable seating and storage
- Optional fishing equipment upgrades
3. **SolarGlide EcoBoat**
- **Description:** A solar-powered boat for environmentally conscious customers.
- **Price:** $55,000
- **Features:**
- Solar panel roof with 12-hour charge life
- Zero emissions
- Maximum speed: 50 mph
- Silent motor technology
 - -
…
The complete private corpus can be found on GitHub.

[Vlad-Fliahin/rag-llamaindex](https://github.com/Vlad-Fliahin/rag-llamaindex)

For the purpose of the evaluation dataset, I have also asked the model to generate 10 questions (about Ukraine Boats Inc. only) based on the given corpus.

为了构建评估数据集，我还让模型基于给定的语料库，生成了 10 个关于乌克兰船只公司的问题。

based on the whole corpus above, generate 10 questions and answers for them pass them into the python native data structure
Here is the dataset obtained:

基于上述的全部语料库，生成 10 个问答对，并将它们放入 Python 原生数据结构中。
以下是生成的数据集：

[
    {
        "question": "What is the primary focus of Ukraine Boats Inc.?",
        "answer": "Ukraine Boats Inc. specializes in manufacturing high-quality recreational, luxury, and commercial boats, blending traditional craftsmanship with modern technology."
    },
    {
        "question": "What is the price range for recreational boats offered by Ukraine Boats Inc.?",
        "answer": "Recreational boats range from $32,000 for the WaveRunner X200 to $55,000 for the SolarGlide EcoBoat."
    },
    {
        "question": "Which manufacturing facility focuses on bespoke yachts and customizations?",
        "answer": "The Lviv Custom Craft Workshop specializes in bespoke yachts and high-end customizations, including handcrafted woodwork and premium materials."
    },
    {
        "question": "What is the warranty coverage offered for boats by Ukraine Boats Inc.?",
        "answer": "All boats come with a 5-year warranty for manufacturing defects, while engines are covered under a separate 3-year engine performance guarantee."
    },
    {
        "question": "Which client used the Neptune Voyager catamaran, and what was the impact on their business?",
        "answer": "Paradise Resorts International used the Neptune Voyager catamarans, resulting in a 45% increase in resort bookings and winning the 'Best Tourism Experience' award."
    },
    {
        "question": "What award did the SolarGlide EcoBoat win at the Global Marine Design Challenge?",
        "answer": "The SolarGlide EcoBoat won the 'Best Eco-Friendly Design' award at the Global Marine Design Challenge in 2022."
    },
    {
        "question": "How has the Arctic Research Consortium benefited from the Poseidon Explorer?",
        "answer": "The Poseidon Explorer enabled five successful Arctic research missions, increased data collection efficiency by 60%, and improved safety in extreme conditions."
    },
    {
        "question": "What is the price of the Odessa Opulence 5000 luxury yacht?",
        "answer": "The Odessa Opulence 5000 luxury yacht starts at $1,500,000."
    },
    {
        "question": "Which features make the WaveRunner X200 suitable for watersports?",
        "answer": "The WaveRunner X200 features a top speed of 85 mph, a lightweight carbon-fiber hull, built-in GPS, and autopilot mode, making it ideal for watersports."
    },
    {
        "question": "What sustainability initiative is Ukraine Boats Inc. pursuing?",
        "answer": "Ukraine Boats Inc. is pursuing the Green Maritime Initiative (GMI) to reduce the carbon footprint by incorporating renewable energy solutions in 50% of their fleet by 2030."
    }
]

Now, when we have the private corpus and the dataset of Q&A pairs, we can insert our data into some suitable storage.

现在，我们有了私有语料库和问答对数据集，就可以将这些数据存储到合适的数据库中了。

### Data propagation

数据传递

We can utilize a variety of databases for the RAG use case, but for this project and the possible handling of future relations, I integrated the Neo4j DB into our solution. Moreover, Neo4j provides a free instance after registration.

我们可以使用多种数据库来实现 RAG（Retrieval-Augmented Generation）检索增强生成的应用，但考虑到本项目以及未来可能涉及的关系处理，我选择了将 Neo4j 数据库集成到我们的解决方案中。此外，Neo4j 在注册后会提供一个免费的数据库实例。

Now, let’s start preparing nodes. First, we instantiate an embedding model. We used the 256 vector dimensions because some recent tests showed that bigger vector dimensions led to scores with less variance (and that’s not what we need). As an embedding model, we used the text-embedding-3-small model.

现在，让我们开始准备节点。首先，我们创建一个嵌入模型（embedding model）的实例。我们选择了 256 维的向量，因为最近的一些测试表明，更大的向量维度会导致分数波动更小（而这不是我们期望的）。作为嵌入模型，我们选择了 text-embedding-3-small 模型。

\# initialize models
embed_model = OpenAIEmbedding(
  model=CFG['configuration']['models']['embedding_model'],
  api_key=os.getenv('AZURE_OPENAI_API_KEY'),
  dimensions=CFG['configuration']['embedding_dimension']
)

After that, we read the corpus:

之后，读取语料库：

\# get documents paths
document_paths = [Path(CFG['configuration']['data']['raw_data_path']) / document for document in CFG['configuration']['data']['source_docs']]

\# initialize a file reader
reader = SimpleDirectoryReader(input_files=document_paths)

\# load documents into LlamaIndex Documents
documents = reader.load_data()

Furthermore, we utilize the SentenceSplitter to convert documents into separate nodes. These nodes will be stored in the Neo4j database.

此外，我们使用 SentenceSplitter（句子分割器）将文档拆分成多个独立的节点。这些节点将会被存储在 Neo4j 数据库中。



neo4j_vector = Neo4jVectorStore(
    username=CFG['configuration']['db']['username'],
    password=CFG['configuration']['db']['password'],
    url=CFG['configuration']['db']['url'],
    embedding_dimension=CFG['configuration']['embedding_dimension'],
    hybrid_search=CFG['configuration']['hybrid_search']
)

\# setup context
storage_context = StorageContext.from_defaults(
    vector_store=neo4j_vector
)

\# populate DB with nodes
index = VectorStoreIndex(nodes, storage_context=storage_context, show_progress=True)

Hybrid search is turned off for now. This is done deliberately to outline the performance of the vector-search algorithm.

目前我们暂时关闭了混合搜索功能。这样做是为了展示向量搜索算法的性能。

We are all set, and now we are ready to go to the querying pipeline.

一切就绪，现在我们可以开始进行查询流程。

### Pipeline

The RAG technique may be implemented as a standalone solution or as a part of an agent. The agent is supposed to handle all the chat history, tools handling, reasoning, and output generation. Below we will have a walkthrough on how to implement the query engines (standalone RAG) and the agent approach (the agent will be able to call the RAG as one of its tools).

检索增强生成（RAG）技术既可以作为独立方案应用，也可以作为 AI 智能体的一部分。AI 智能体负责处理所有聊天记录、工具调用、推理以及结果生成。接下来，我们将详细介绍如何实现查询引擎（独立 RAG）以及 AI 智能体方法（AI 智能体将能够调用 RAG 作为其工具之一）。

Often when we talk about the chat models, the majority will pick the OpenAI models without considering the alternatives. We will outline the usage of RAG on OpenAI models and the Meta Llama 3.2 models. Let’s benchmark which one performs better.

通常当我们谈论聊天模型时，大多数人都会直接选择 OpenAI 的模型，而忽略了其他的选择。本文将介绍如何在 OpenAI 模型和 Meta Llama 3.2 模型上应用 RAG（检索增强生成，Retrieval-Augmented Generation）技术，并对比它们之间的性能差异。

All the configuration parameters are moved to the pyproject.toml file.

所有配置参数已迁移至 pyproject.toml 文件中。

[configuration]
similarity_top_k = 10
vector_store_query_mode = "default"
similarity_cutoff = 0.75
response_mode = "compact"
distance_strategy = "cosine"
embedding_dimension = 256
chunk_size = 512
chunk_overlap = 128
separator = " "
max_function_calls = 2
hybrid_search = false

[configuration.data]
raw_data_path = "../data/companies"
dataset_path = "../data/companies/dataset.json"
source_docs = ["city-solve.txt", "aero-vance-aviation.txt", "nova-drive-motors.txt", "ukraine-boats.txt"]

[configuration.models]
llm = "gpt-4o-mini"
embedding_model = "text-embedding-3-small"
temperature = 0
llm_hf = "meta-llama/Llama-3.2-3B-Instruct"
context_window = 8192
max_new_tokens = 4096
hf_token = "hf_custom-token"
llm_evaluation = "gpt-4o-mini"

[configuration.db]
url = "neo4j+s://custom-url"
username = "neo4j"
password = "custom-password"
database = "neo4j" 
index_name = "article" \# change if you want to load the new data that won't intersect with the previous uploads
text_node_property = "text"

The common step for both models is connecting to the existing vector index inside the neo4j.

两种模型共同的步骤是连接到 neo4j 数据库中已有的向量索引。

\# connect to the existing neo4j vector index
vector_store = Neo4jVectorStore(
  username=CFG['configuration']['db']['username'],
  password=CFG['configuration']['db']['password'],
  url=CFG['configuration']['db']['url'],
  embedding_dimension=CFG['configuration']['embedding_dimension'],
  distance_strategy=CFG['configuration']['distance_strategy'],
  index_name=CFG['configuration']['db']['index_name'],
  text_node_property=CFG['configuration']['db']['text_node_property']
)
index = VectorStoreIndex.from_vector_store(vector_store)

### OpenAI

Firstly we should initialize the OpenAI models needed. We will use the gpt-4o-mini as a language model and the same embedding model. We specify the LLM and embedding model for the Settings object. This way we don’t have to pass these models further. The LlamaIndex will try to parse the LLM from the Settings if it’s needed.

首先，我们需要初始化所需的 OpenAI 模型。这里，我们将使用 gpt-4o-mini 作为大语言模型（LLM），并使用相同的嵌入模型（embedding model）。我们将在 Settings 对象中指定大语言模型（LLM）和嵌入模型（embedding model）。这样，后续就无需再传递这些模型了。如果需要，LlamaIndex 会尝试从 Settings 中获取大语言模型（LLM）。

```py
\# initialize models
llm = OpenAI(
  api_key=os.getenv('AZURE_OPENAI_API_KEY'),
  model=CFG['configuration']['models']['llm'],
  temperature=CFG['configuration']['models']['temperature']
)
embed_model = OpenAIEmbedding(
  model=CFG['configuration']['models']['embedding_model'],
  api_key=os.getenv('AZURE_OPENAI_API_KEY'),
  dimensions=CFG['configuration']['embedding_dimension']
)

Settings.llm = llm
Settings.embed_model = embed_model
```

QueryEngine

QueryEngine（查询引擎)

After that, we can create a default query engine from the existing vector index:

完成以上设置后，我们可以利用现有的向量索引创建一个默认的查询引擎：

\# create query engine
query_engine = index.as_query_engine()

Furthermore, we can obtain the RAG logic using simply a query() method. In addition, we printed the list of the source nodes, retrieved from the DB, and the final LLM response.

此外，我们可以通过简单的 `query()` 方法来执行 RAG（检索增强生成）逻辑。同时，我们还打印了从数据库中检索出的源节点列表，以及大语言模型（LLM）的最终回复。

```py
\# custom question
response = query_engine.query("What is the primary focus of Ukraine Boats Inc.?")

\# get similarity scores
for node in response.source_nodes:
  print(f'{node.node.id_}, {node.score}')

\# predicted answer
print(response.response)
```

Here is the sample output:

```
ukraine-boats-3, 0.8536546230316162
ukraine-boats-4, 0.8363556861877441

The primary focus of Ukraine Boats Inc. is designing, manufacturing, and selling luxury and eco-friendly boats, with a strong emphasis on customer satisfaction and environmental sustainability.
```

乌克兰船舶公司主要致力于设计、制造和销售豪华且环保的船只，并侧重于客户满意度和环境可持续性。

As you can see, we created custom node ids, so that we can understand the file from which it was taken and the ordinal id of the chunk. We can be much more specific with the query engine attitude using the low-level LlamaIndex API:

如前文所述，我们创建了自定义节点 ID，以便了解文件来源以及分块的序号。通过使用 LlamaIndex 的底层 API（Application Programming Interface），我们可以更具体地控制查询引擎的行为方式：

\# custom retriever
retriever = VectorIndexRetriever(
  index=index,
  similarity_top_k=CFG['configuration']['similarity_top_k'],
  vector_store_query_mode=CFG['configuration']['vector_store_query_mode']
)


\# similarity threshold
similarity_postprocessor = SimilarityPostprocessor(similarity_cutoff=CFG['configuration']['similarity_cutoff'])

\# custom response synthesizer
response_synthesizer = get_response_synthesizer(
  response_mode=CFG['configuration']['response_mode']
)


\# combine custom query engine
query_engine = RetrieverQueryEngine(
  retriever=retriever,
  node_postprocessors=[similarity_postprocessor],
  response_synthesizer=response_synthesizer
)

Here we specified custom retriever, similarity postprocessor, and refinement stage actions.

这里，我们使用了自定义的检索器（retriever）、相似性后处理器（similarity postprocessor）以及用于完善答案的处理步骤（refinement stage actions）。

For further customization, you can create custom wrappers around any of the LlamaIndex components to make them more specific and aligned with your needs.

为了更进一步的定制，你可以围绕任何 LlamaIndex 组件创建自定义的包装器，以便使其更贴合你的具体需求。

### Agent

To implement a RAG-based agent inside the LlamaIndex, we need to use one of the predefined AgentWorkers. We will stick to the OpenAIAgentWorker, which uses OpenAI’s LLM as its brain. Moreover, we wrapped our query engine from the previous part into the QueryEngineTool, which the agent may pick based on the tool’s description.

为了在 LlamaIndex 内部实现一个基于 RAG 的智能体，我们需要使用预定义的 AgentWorker。我们选择使用 OpenAIAgentWorker，它使用 OpenAI 的大语言模型（LLM）作为其核心。此外，我们将前面部分中的查询引擎封装到了 QueryEngineTool 中，智能体可以根据该工具的描述来选择使用。

```py
AGENT_SYSTEM_PROMPT = "You are a helpful human assistant. You always call the retrieve_semantically_similar_data tool before answering any questions. If the answer to the questions couldn't be found using the tool, just respond with `Didn't find relevant information`."
TOOL_NAME = "retrieve_semantically_similar_data"
TOOL_DESCRIPTION = "Provides additional information about the companies. Input: string"

\# agent worker
agent_worker = OpenAIAgentWorker.from_tools(
    [
        QueryEngineTool.from_defaults(
            query_engine=query_engine,
            name=TOOL_NAME,
            description=TOOL_DESCRIPTION,
            return_direct=False,
        )
    ],
    system_prompt=AGENT_SYSTEM_PROMPT,
    llm=llm,
    verbose=True,
    max_function_calls=CFG['configuration']['max_function_calls']
)
```

To further use the agent, we need an AgentRunner. The runner is more like an orchestrator, handling top-level interactions and state, while the worker performs concrete actions, like tool and LLM usage.

为了进一步使用该智能体，我们需要一个智能体运行器（AgentRunner）。这个运行器更像是一个协调器，处理高级别的交互和状态，而这个执行器执行具体的操作，比如工具和大语言模型（LLM/Large Language Model）的使用。

```py
\# agent runner
agent = AgentRunner(agent_worker=agent_worker)
```

[Lower-Level Agent API - LlamaIndex](https://docs.llamaindex.ai/en/stable/module_guides/deploying/agents/agent_runner/)

To test the user-agent interactions efficiently, I implemented a simple chat-like interface:

为了高效地测试用户与智能体之间的交互，我实现了一个简单的、类似聊天窗口的界面：

```py
while True:
  \# get user input
  current_message = input('Insert your next message:')
  print(f'{datetime.now().strftime("%H:%M:%S.%f")[:-3]}|User: {current_message}')
```

Here is a sample of the chat:

```
Insert your next message: Hi
15:55:43.101|User: Hi
Added user message to memory: Hi
15:55:43.873|Agent: Didn't find relevant information.
Insert your next message: Do you know anything about the city solve?
15:56:24.751|User: Do you know anything about the city solve?
Added user message to memory: Do you know anything about the city solve?
=== Calling Function ===
Calling function: retrieve_semantically_similar_data with args: {"input":"city solve"}
Got output: Empty Response
\========================

15:56:37.267|Agent: Didn't find relevant information.
Insert your next message: What is the primary focus of Ukraine Boats Inc.?
15:57:36.122|User: What is the primary focus of Ukraine Boats Inc.?
Added user message to memory: What is the primary focus of Ukraine Boats Inc.?
=== Calling Function ===
Calling function: retrieve_semantically_similar_data with args: {"input":"Ukraine Boats Inc."}
Got output: Ukraine Boats Inc. is a premier manufacturer and supplier of high-quality boats and maritime solutions based in Odessa, Ukraine. Founded in 2005, the company specializes in recreational, commercial, and luxury vessels, blending traditional craftsmanship with modern technology. It has established a strong market presence in Europe, North America, and Asia, supported by partnerships with distribution companies like Baltic Marine Distributors in Germany, OceanCraft LLC in the USA, and Yokohama SeaTech in Japan.

The company is organized into several departments, including Engineering, Sales and Marketing, Production, and Customer Service, each with specific responsibilities to ensure efficient operations and customer satisfaction. Ukraine Boats Inc. is committed to sustainability through initiatives like the Green Maritime Initiative, aiming to reduce its carbon footprint by incorporating renewable energy solutions in its fleet.

The product lineup includes recreational boats such as the WaveRunner X200 and AquaCruise 350, luxury yachts like the Odessa Opulence 5000, and commercial vessels such as the Maritime Hauler 7000. The company also offers customization options, maintenance plans, and a range of accessories to enhance the boating experience.

With a focus on innovation and quality, Ukraine Boats Inc. has received accolades in various marine design competitions and continues to expand its global footprint while maintaining a commitment to environmental compliance and customer service excellence.
\========================

15:57:49.505|Agent: The primary focus of Ukraine Boats Inc. is the manufacturing and supplying of high-quality boats and maritime solutions. Based in Odessa, Ukraine, the company specializes in recreational, commercial, and luxury vessels, combining traditional craftsmanship with modern technology. They are committed to sustainability and have initiatives like the Green Maritime Initiative to reduce their carbon footprint. Their product lineup includes various types of boats, and they also offer customization options and maintenance plans.
Insert your next message: Do you know anything about the government company city solve?
15:59:02.830|User: Do you know anything about the government company city solve?
Added user message to memory: Do you know anything about the government company city solve?
=== Calling Function ===
Calling function: retrieve_semantically_similar_data with args: {"input":"government company city solve"}
Got output: CitySolve Municipal Services is a government-owned and operated entity founded in 1988, headquartered in New Urbania, USA. Its mission is to ensure a livable, sustainable, and efficient city by providing prompt solutions to residents' everyday needs. The company focuses on various critical service areas, including waterworks and drainage, parks and greenery management, roads and sidewalks, waste management, public safety infrastructure, and urban utilities. CitySolve emphasizes core values such as responsiveness, reliability, accountability, and sustainability, and utilizes modern technologies to enhance its operations and community impact.
\========================

15:59:12.693|Agent: CitySolve Municipal Services is a government-owned and operated entity founded in 1988, headquartered in New Urbania, USA. Its mission is to ensure a livable, sustainable, and efficient city by providing prompt solutions to residents' everyday needs. The company focuses on critical service areas such as waterworks and drainage, parks and greenery management, roads and sidewalks, waste management, public safety infrastructure, and urban utilities. CitySolve emphasizes core values like responsiveness, reliability, accountability, and sustainability, and it utilizes modern technologies to enhance its operations and community impact.
Insert your next message: Thanks
15:59:28.761|User: Thanks
Added user message to memory: Thanks
15:59:30.327|Agent: Didn't find relevant information.
```

What we can see, is that for the correct vector search you need to specify the input questions with more details, that can be semantically matched.

由此可见，要进行正确的向量搜索，你需要提供更详细的输入问题，以便在语义上进行匹配。








### Open source

As an open source model, we have utilized the meta-llama/Llama-3.2–3B-Instruct. This choice was based on the model latency & performance trade-off. First things first we need to authenticate our HuggingFace account via an access token.

开源作为一个开源模型，我们采用了 meta-llama/Llama-3.2–3B-Instruct 。之所以选择它，是综合考虑了模型延迟和性能的平衡。首先，我们需要通过访问令牌（access token）来验证我们的 HuggingFace 账户。

\# Use your token here
login(token=CFG['configuration']['models']['hf_token'])

To use the Llama as an LLM inside the LlamaIndex, we need to create a model wrapper. We will use a single NVIDIA GeForce RTX 3090 to serve our Llama 3.2 model.

为了在 LlamaIndex 中将 Llama 用作大语言模型（LLM），我们需要创建一个模型包装器。我们将使用一块 NVIDIA GeForce RTX 3090 显卡来运行我们的 Llama 3.2 模型。

```py
SYSTEM_PROMPT = """You are an AI assistant that answers questions in a friendly manner, based on the given source documents. Here are some rules you always follow:
- Generate human readable output, avoid creating output with gibberish text.
- Generate only the requested output, don't include any other language before or after the requested output.
- Never say thank you, that you are happy to help, that you are an AI agent, etc. Just answer directly.
- Generate professional language typically used in business documents in North America.
- Never generate offensive or foul language.
"""

query_wrapper_prompt = PromptTemplate(
    "<|start_header_id|>system<|end_header_id|>\n" + SYSTEM_PROMPT + "<|eot_id|><|start_header_id|>user<|end_header_id|>{query_str}<|eot_id|><|start_header_id|>assistant<|end_header_id|>"
)

llm = HuggingFaceLLM(
    context_window=CFG['configuration']['models']['context_window'],
    max_new_tokens=CFG['configuration']['models']['max_new_tokens'],
    generate_kwargs={"temperature": CFG['configuration']['models']['temperature'], "do_sample": False},
    query_wrapper_prompt=query_wrapper_prompt,
    tokenizer_name=CFG['configuration']['models']['llm_hf'],
    model_name=CFG['configuration']['models']['llm_hf'],
    device_map="cuda:0",
    model_kwargs={"torch_dtype": torch.bfloat16}
)

Settings.llm = llm
```

QueryEngine

The interfaces are the same. Example output is below:

ukraine-boats-3, 0.8536546230316162
ukraine-boats-4, 0.8363556861877441

The primary focus of Ukraine Boats Inc. is designing, manufacturing, and selling luxury and eco-friendly boats, with a strong emphasis on customer satisfaction and environmental sustainability.

Agent

For the OpenAI models, LlamaIndex has a special agent wrapper designed, but for the open-source models we should use another wrapper. We selected ReActAgent, which iteratively does reasoning and acting until the final response is ready.

对于 OpenAI 的模型，LlamaIndex 提供了一个专门设计的智能体封装器，但对于开源模型，我们需要使用其他的封装器。我们选择了 ReActAgent，它会反复进行推理和行动，直到得到最终响应。

```py
agent_worker = ReActAgentWorker.from_tools(
    [
        QueryEngineTool.from_defaults(
            query_engine=query_engine,
            name=TOOL_NAME,
            description=TOOL_DESCRIPTION,
            return_direct=False,
        )
    ],
    llm=llm,
    verbose=True,
    chat_history=[ChatMessage(content=AGENT_SYSTEM_PROMPT, role="system")]
)

\# agent runner
agent = AgentRunner(agent_worker=agent_worker)
```


Below is the same discussion but with a different Agent under the hood:

Insert your next message: Hi
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
16:04:29.117|User: Hi
Thought: The current language of the user is: English. I need to use a tool to help me answer the question.
Action: retrieve_semantically_similar_data
Action Input: {'input': 'hello world', 'num_beams': 5}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: Empty Response
Thought: I still need more information to answer the question. The tool did not provide any useful output. I'll try to gather more context.
Action: retrieve_semantically_similar_data
Action Input: {'input': 'hello world', 'num_beams': 5}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: Empty Response
Thought: I still don't have enough information to answer the question. The tool did not provide any useful output. I'll try to gather more context.
Action: retrieve_semantically_similar_data
Action Input: {'input': 'hello world', 'num_beams': 5}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: Empty Response
Thought: I'm starting to think that the tool is not the best approach to answer this question. The user's input "hello world" is very general and the tool is not providing any useful output. I'll try to think of a different approach.
Answer: Hello, how can I assist you today?
16:04:37.764|Agent: Hello, how can I assist you today?
Insert your next message: Do you know anything about the city solve?
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
16:05:08.756|User: Do you know anything about the city solve?
Thought: The current language of the user is: English. I need to use a tool to help me answer the question.
Action: retrieve_semantically_similar_data
Action Input: {'input': 'solve city'}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: 

\# AI 智能体运行器
agent = AgentRunner（agent_worker=agent_worker)
下面是同样的对话，但这次使用的是不同的 AI 智能体：

请发送你的下一条消息：你好设置 `pad_token_id` 为 `eos_token_id`:None 以进行开放式文本生成。
16:04:29.117 | 用户：你好思考：我需要使用工具来帮助我回答这个问题。
行动：retrieve_semantically_similar_data（语义相似数据检索)
行动输入：{'input'：'hello world'，'num_beams'：5}
设置 `pad_token_id` 为 `eos_token_id`:None 以进行开放式文本生成。
观察结果：空思考：我仍然需要更多信息才能回答这个问题。这个工具没有提供任何有用的输出，我需要尝试获取更多上下文信息。
行动：retrieve_semantically_similar_data（语义相似数据检索)
行动输入：{'input'：'hello world'，'num_beams'：5}
设置 `pad_token_id` 为 `eos_token_id`:None 以进行开放式文本生成。
观察结果：空思考：我仍然没有足够的信息来回答问题。这个工具没有提供任何有用的输出，我需要尝试获取更多上下文信息。
行动：retrieve_semantically_similar_data（语义相似数据检索)
行动输入：{'input'：'hello world'，'num_beams'：5}
设置 `pad_token_id` 为 `eos_token_id`:None 以进行开放式文本生成。
观察结果：空思考：我开始认为这个工具不是解决这个问题的最佳方案。用户的输入「hello world」太过宽泛，这个工具没有提供任何有用的信息。我需要尝试其他的解决思路。
回答：你好，今天有什么可以帮您？
16:04:37.764|AI 智能体：你好，今天有什么可以帮您？
请发送你的下一条消息：你知道关于「城市解决」的任何信息吗？
设置 `pad_token_id` 为 `eos_token_id`:None 以进行开放式文本生成。
16:05:08.756 | 用户：你知道关于「城市解决」的任何信息吗？
思考：我需要使用工具来帮助我回答这个问题。
行动：retrieve_semantically_similar_data（语义相似数据检索)
行动输入：{'input'：'solve city'}
设置 `pad_token_id` 为 `eos_token_id`:None 以进行开放式文本生成。
设置 `pad_token_id` 为 `eos_token_id`:None 以进行开放式文本生成。
观察结果：

CitySolve Municipal Services is the lifeline of New Urbania, addressing a wide range of city-level concerns and providing prompt solutions to residents' everyday needs.
Thought: I can answer without using any more tools. I'll use the user's language to answer
Answer: CitySolve Municipal Services is a city-level organization that provides solutions to residents' everyday needs in New Urbania.
16:05:13.003|Agent: CitySolve Municipal Services is a city-level organization that provides solutions to residents' everyday needs in New Urbania.
Insert your next message: What is the primary focus of Ukraine Boats Inc.?
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
16:05:34.892|User: What is the primary focus of Ukraine Boats Inc.?
Thought: The current language of the user is: English. I need to use a tool to help me answer the question.
Action: retrieve_semantically_similar_data
Action Input: {'input': 'Ukraine Boats Inc.'}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: 

CitySolve 市政服务在新乌尔巴尼亚发挥着至关重要的作用，它致力于解决城市中各种各样的问题，并迅速响应居民的日常需求。
答案：CitySolve 市政服务是一个城市级组织，为新乌尔巴尼亚居民的日常需求提供解决方案。
16:05:13.003 | 代理：CitySolve 市政服务是一个城市级组织，为新乌尔巴尼亚居民的日常需求提供解决方案。
插入您的下一条消息：乌克兰船舶公司的主要关注点是什么？
16:05:34.892 | 用户：乌克兰船舶公司的主要关注点是什么？
想法：用户当前的语言是：英语。我需要使用工具来帮助我回答这个问题。

Ukraine Boats Inc. is a premier manufacturer and supplier of high-quality boats and maritime solutions based in Odessa, Ukraine. The company prides itself on blending traditional craftsmanship with modern technology to serve clients worldwide. Founded in 2005, the company has grown to be a leader in the boating industry, specializing in recreational, commercial, and luxury vessels.

乌克兰船舶公司是位于乌克兰敖德萨的一家卓越的船舶及海事解决方案制造商和供应商。公司致力于融合传统工艺与现代科技，为全球客户提供优质服务，并以此为荣。公司成立于 2005 年，现已发展成为船舶行业的领导者，专注于休闲、商业和豪华船只的制造。

The company has successfully delivered a range of boats and solutions to various clients, including Blue Horizon Fisheries, Azure Seas Luxury Charters, Coastal Safety Patrol, EcoTrade Logistics, Team HydroBlitz Racing, and Paradise Resorts International. These clients have reported significant benefits from working with Ukraine Boats Inc., including increased efficiency, reduced costs, and enhanced customer satisfaction.

该公司已成功为多家客户交付了一系列船只和解决方案，这些客户包括 Blue Horizon Fisheries、Azure Seas Luxury Charters、Coastal Safety Patrol、EcoTrade Logistics、Team HydroBlitz Racing 以及 Paradise Resorts International。这些客户表示，与 Ukraine Boats Inc. 合作让他们获益良多，例如效率提高、成本降低以及客户满意度提升。

Ukraine Boats Inc. offers a range of products and services, including luxury yachts, commercial boats, and accessories. The company's products are designed to meet the specific needs of each client, and its team of experts works closely with clients to ensure that every boat is tailored to their requirements.

乌克兰船舶公司（Ukraine Boats Inc.）提供多种产品和服务，包括豪华游艇、商用船只和各种配件。公司的产品都旨在满足每位客户的独特需求，其专家团队会与客户紧密合作，确保每艘船都根据他们的具体要求进行定制。

Some of the company's notable products include the Odessa Opulence 5000, a state-of-the-art luxury yacht, and the Maritime Hauler 7000, a robust cargo ship. The company also offers boat customization packages, annual maintenance plans, and other services to support its clients' needs.

该公司的一些知名产品包括「敖德萨富丽 5000」豪华游艇，这是一款最先进的豪华游艇，以及「海事运输者 7000」型货船，这是一款坚固耐用的货船。该公司还提供游艇定制服务、年度维护计划以及其他服务，以满足客户的各种需求。

Overall, Ukraine Boats Inc. is a trusted and reliable partner for clients seeking high-quality boats and maritime solutions.
Thought: I can answer without using any more tools. I'll use the user's language to answer
Answer: Ukraine Boats Inc. is a premier manufacturer and supplier of high-quality boats and maritime solutions based in Odessa, Ukraine, blending traditional craftsmanship with modern technology to serve clients worldwide.
16:05:53.311|Agent: Ukraine Boats Inc. is a premier manufacturer and supplier of high-quality boats and maritime solutions based in Odessa, Ukraine, blending traditional craftsmanship with modern technology to serve clients worldwide.
Insert your next message: Do you know anything about the government company city solve?
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
16:06:09.949|User: Do you know anything about the government company city solve?
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Thought: The current language of the user is English. I need to use a tool to help me answer the question.
Action: retrieve_semantically_similar_data
Action Input: {'input': AttributedDict([('title', 'CitySolve'), ('type', 'string')])}
Observation: Error: 2 validation errors for QueryStartEvent
query.str
  Input should be a valid string [type=string_type, input_value=AttributedDict([('title',...'), ('type', 'string')]), input_type=AttributedDict]
    For further information visit https://errors.pydantic.dev/2.9/v/string_type
query.QueryBundle.query_str
  Field required [type=missing, input_value=AttributedDict([('title',...'), ('type', 'string')]), input_type=AttributedDict]
    For further information visit https://errors.pydantic.dev/2.9/v/missing
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: Error: Could not parse output. Please follow the thought-action-input format. Try again.
Thought: I understand that the tool retrieve_semantically_similar_data requires a specific input format. I will make sure to follow the correct format.
Action: retrieve_semantically_similar_data
Action Input: {'title': 'CitySolve', 'type': 'string'}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: 

总而言之，乌克兰船舶公司是客户寻求高质量船舶和海事解决方案时，值得信赖的可靠伙伴。
回答： 乌克兰船舶公司是一家位于乌克兰敖德萨的优质船舶和海事解决方案的制造商和供应商，它融合了传统工艺与现代技术，为全球客户提供服务。
插入您的下一条消息：您了解关于政府公司 CitySolve 的任何信息吗？
16:06:09.949| 您知道任何关于政府公司城市解决（city solve）的事情吗？
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Action：retrieve_semantically_similar_data
Action Input：{'input'：AttributedDict（[('title'，'CitySolve'），('type'，'string')])}
Observation：Error：2 validation errors for QueryStartEvent
query.str
 Input should be a valid string [type=string_type，input_value=AttributedDict（[('title',...'），('type'，'string')]），input_type=AttributedDict]
  For further information visit https://errors.pydantic.dev/2.9/v/string_type
query.QueryBundle.query_str
 Field required [type=missing，input_value=AttributedDict（[('title',...'），('type'，'string')]），input_type=AttributedDict]
  For further information visit https://errors.pydantic.dev/2.9/v/missing
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation：Error：Could not parse output. Please follow the thought-action-input format. Try again.
Action：retrieve_semantically_similar_data
Action Input：{'title'：'CitySolve'，'type'：'string'}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation:

CitySolve Municipal Services is a government-owned and operated company that serves as the backbone of New Urbania's civic infrastructure, addressing a wide range of city-level concerns.
Thought: I can answer without using any more tools. I'll use the user's language to answer
Answer: CitySolve Municipal Services is a government-owned and operated company that serves as the backbone of New Urbania's civic infrastructure, addressing a wide range of city-level concerns.
16:06:17.799|Agent: CitySolve Municipal Services is a government-owned and operated company that serves as the backbone of New Urbania's civic infrastructure, addressing a wide range of city-level concerns.
Insert your next message: Thanks
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
16:06:34.232|User: Thanks
Thought: I can answer without using any more tools. I'll use the user's language to answer
Answer: CitySolve Municipal Services is a government-owned and operated company that serves as the backbone of New Urbania's civic infrastructure, addressing a wide range of city-level concerns.
16:06:35.734|Agent: CitySolve Municipal Services is a government-owned and operated company that serves as the backbone of New Urbania's civic infrastructure, addressing a wide range of city-level concerns.
As we can see, the agents reason differently. Given the same questions, the two models decided to query the tool differently. The second agent failed with the tool once, but it’s more an issue of the tool description than the agent itself. Both of them provided the user with valuable answers, which is the final goal of the RAG approach.

城市速决市政服务公司是一家政府所有并运营的企业，是新乌尔巴尼亚市市政基础设施的基石，负责处理各种城市问题。
16:06:17.799 | 代理：城市速决市政服务公司是一家政府所有并运营的企业，是新乌尔巴尼亚市市政基础设施的基石，负责处理各种城市问题。
16:06:34.232 | 用户：谢谢
16:06:35.734 | 代理：城市速决市政服务公司是一家政府所有并运营的企业，是新乌尔巴尼亚市市政基础设施的基石，负责处理各种城市问题。
我们可以看到，这些智能体（AI Agent）的推理方式各不相同。面对相同问题，两个模型采用了不同的工具查询方式。第二个智能体工具调用失败，但这更多是工具描述的问题。它们都为用户提供了有价值的答案，这也是 RAG 方法的核心目的。

In addition, there are a lof of different agent wrappers that you can apply on top of your LLM. They may significantly change a way the model interacts with the world.

此外，你可以将许多不同的智能体封装器（agent wrappers）应用在你的大语言模型（LLM）之上。这些封装器可能会显著改变模型与外部环境的交互方式。

Evaluation
To evaluate the RAG, nowadays there are a lot of frameworks available. One of them is the TruLens. Overall RAG performance is assessed using the so-called RAG Triad (answer relevance, context relevance, and groundedness).

评估目前，有很多框架可以用来评估 RAG 。TruLens 就是其中一个框架。RAG 的整体性能评估，通常使用所谓的 RAG 三要素：答案相关性、上下文相关性和根据性。

To estimate relevances and groundedness we are going to utilize the LLMs. The LLMs will act as judges, which will score the answers based on the information given.

为了评估答案的相关性和依据是否充分，我们将借助大语言模型（LLM）。这些大语言模型将作为评估者，根据所提供的上下文信息来评判答案的质量。

TruLens itself is a convenient tool to measure system performance on a metric level and analyze the specific record’s assessments. Here is the leaderboard UI view:

TruLens 本身是一个便捷的工具，它可以在指标层面上衡量系统性能，并分析特定记录的评估结果。下图是排行榜的用户界面（UI）视图：

UI leaderboard view of the TruLens framework
Source: Image created by the author
Below is the per-record table of assessments, where you can review all the internal processes being invoked.

TruLens 框架的用户界面排行榜视图来源： 作者提供的图片下面是每条记录的评估表格，你可以在这里查看所有被触发的内部处理流程。

Per-record table of assessments, where you can review all the internal processed being invoked. Part of the TruLens UI.
Source: Image created by the author
To get even more details, you can review the execution process for a specific record.

这是一个关于评估的表格，其中记录了每一项评估结果，你可以查看所有被调用的内部处理流程。这是 TruLens 用户界面的一部分。
图片来源：作者如果想了解更详细的信息，你可以查看特定记录的执行过程。

Execution process for a specific record inside the TruLens UI.
Source: Image created by the author
To implement the RAG Triad evaluation, first of all, we have to define the experiment name and the model provider. We will utilize the gpt-4o-mini model for the evaluation.

TruLens UI 中特定记录的执行流程。
来源：作者自制图要进行 RAG 三元组评估，首先需要确定实验名称和模型提供商。这里我们选择 gpt-4o-mini 模型进行评估。

experiment_name = "llama-3.2-3B-custom-retriever"

provider = OpenAIProvider(
    model_engine=CFG['configuration']['models']['llm_evaluation']
)
After that, we define the Triad itself (answer relevance, context relevance, groundedness). For each metric, we should specify inputs and outputs.

experiment_name =「llama-3.2-3B-custom-retriever"

provider = OpenAIProvider（model_engine=CFG ['configuration']['models']['llm_evaluation']
)
接下来，我们定义 Triad（Triad）本身，它包括三个方面：答案相关性、上下文相关性和依据性。对于每个评估指标，我们需要明确指定其输入和输出。

context_selection = TruLlama.select_source_nodes().node.text

\# context relevance (for each of the context chunks)
f_context_relevance = (
    Feedback(
        provider.context_relevance, name="Context Relevance"
    )
    .on_input()
    .on(context_selection)
)

context_selection = TruLlama.select_source_nodes（).node.text

# 上下文相关性（针对每个上下文块)
f_context_relevance =（
  Feedback（provider.context_relevance，name="上下文相关性")
  .on_input（)
  .on（context_selection)
)

\# groundedness
f_groundedness_cot = (
    Feedback(
        provider.groundedness_measure_with_cot_reasons, name="Groundedness"
    )
    .on(context_selection.collect())
    .on_output()
)

\# 依据性
f_groundedness_cot =（
  反馈（provider.groundedness_measure_with_cot_reasons，name="依据性")
  . 针对（context_selection.collect（))
  . 针对_输出（))

\# answer relevance between overall question and answer
f_qa_relevance = (
    Feedback(
        provider.relevance_with_cot_reasons, name="Answer Relevance"
    )
    .on_input_output()
)
Furthermore, we instantiate the TruLlama object that will handle the feedback calculation during the agent calls.

# 答案相关性我们定义一个名为 `f_qa_relevance` 的变量来存储反馈信息，这个反馈信息通过 `Feedback` 函数生成。该函数使用 `provider.relevance_with_cot_reasons` 来评估答案与问题的相关性，并命名为「答案相关性」。 `on_input_output（)` 表示此反馈的计算基于智能体的输入和输出。

此外，我们创建 TruLlama 对象，该对象会在 AI 智能体调用期间处理反馈计算。

\# Create TruLlama agent
tru_agent = TruLlama(
    agent,
    app_name=experiment_name,
    tags="agent testing",
    feedbacks=[f_qa_relevance, f_context_relevance, f_groundedness_cot],
)
Now we are ready to execute the evaluation pipeline on our dataset.

# 创建 TruLlama 智能体
tru_agent = TruLlama（
  agent,
  app_name=experiment_name,
  tags="AI 智能体测试",
  feedbacks=[f_qa_relevance，f_context_relevance，f_groundedness_cot],
)
现在我们准备好在我们的数据集上执行评估流程。

for item in tqdm(dataset):
    try:
        agent.reset()
        
        with tru_agent as recording:
            agent.query(item.get('question'))
        record_agent = recording.get()
        
        \# wait until all the feedback function are finished
        for feedback, result in record_agent.wait_for_feedback_results().items():
            logging.info(f'{feedback.name}: {result.result}')
    except Exception as e:
        logging.error(e)
        traceback.format_exc()
We have conducted experiments using the 2 models, default/custom query engines, and extra tool input parameters description (ReAct agent struggled without the explicit tool input params description, trying to call non-existing tools to refactor the input). We can review the results as a DataFrame using a get_leaderboard() method.

```
for item in tqdm（dataset):
  try:
    agent.reset（)
    
    with tru_agent as recording:
      agent.query（item.get（'question'))
    record_agent = recording.get（)
    
    # 等待所有反馈函数完成
    for feedback，result in record_agent.wait_for_feedback_results（).items（):
      logging.info（f'{feedback.name}：{result.result}')
  except Exception as e:
    logging.error（e)
    traceback.format_exc（)
我们进行了实验，使用了 2 个模型、默认 / 自定义查询引擎，以及额外的工具输入参数描述。结果显示，在没有明确的工具输入参数描述时，ReAct 智能体的表现不佳，它会尝试调用不存在的工具来修改输入。我们可以使用 get_leaderboard（）方法，以表格（DataFrame）的形式查看实验结果。
```

Experiments results table.
Source: Image created by the author
Conclusion
Data -> neo4j -> agent -> rag pipeline
Source: Image generate by the author using AI (Bing)
We obtained a private corpus, incorporating GPT models for the custom dataset generation. The actual corpus content is pretty interesting and diverse. That’s the reason why a lot of models are successfully fine-tuned using the GPT-generated samples right now.

实验结果表。
图片来源：作者自制结论数据 -> neo4j -> 智能体 -> rag 管线（RAG pipeline)
图片来源：作者使用 AI（Bing）生成我们获得了一个私有语料库，并结合 GPT 模型来生成自定义数据集。该语料库的内容非常有趣且多样。这也是为什么现在很多模型都能成功地使用 GPT 生成的样本进行微调的原因。

Neo4j DB provides convenient interfaces for a lot of frameworks while having one of the best UI capabilities (Aura). In real projects, we often have relations between the data, and GraphDB is a perfect choice for such use cases.

Neo4j 为许多框架提供了便捷的接口，同时拥有最出色的用户界面之一（Aura）。实际项目中，数据之间往往存在关联，而图数据库是解决此类问题的理想选择。

On top of the private corpus, we implemented different RAG approaches (standalone and as a part of the agent). Based on the RAG Triad metrics, we observed that an OpenAI-based agent works perfectly, while a well-prompted ReAct agent performs relatively the same. A big difference was in the usage of a custom query engine. That’s reasonable because we configured some specific procedures and thresholds that align with our data. In addition, both solutions have high groundedness, which is very important for RAG applications.

在私有语料库的基础上，我们尝试了不同的 RAG（检索增强生成，Retrieval-Augmented Generation）方法，包括独立使用和作为 AI 智能体的一部分。根据 RAG 三元组指标（RAG Triad metrics）的评估，我们发现基于 OpenAI 的 AI 智能体表现出色，而经过精心提示的 ReAct 智能体也达到了相近的水平。一个显著的差异在于使用了自定义的查询引擎。这在意料之中，因为我们针对自身的数据特点，配置了特定的流程和阈值。此外，这两种方案都展现出很高的依据性（groundedness），这对 RAG 应用至关重要。

Another interesting takeaway is that the Agent call latency of the Llama3.2 3B and gpt-4o-mini API was pretty much the same (of course the most time took the DB call, but the difference is still not that big).

另一个有趣的发现是，Llama3.2 3B 和 gpt-4o-mini API 的 AI 智能体响应时间基本一致（当然，数据库调用花费了大部分时间，但两者之间的差异仍然不大）。

Though our system works pretty well, there are a lot of improvements to be done, such as keyword search, rerankers, neighbor chunking selection, and the ground truth labels comparison. These topics will be discussed in the next articles on the RAG applications.

尽管我们的系统表现良好，但仍有许多可以改进的地方，例如关键词搜索、重排序器（rerankers)、邻近块选择（neighbor chunking selection）以及真值标签比较（ground truth labels comparison）。这些主题将在后续关于 RAG 应用的文章中进行探讨。

Private corpus, alongside the code and prompts, can be found on GitHub.

P.S.
I want to thank my colleagues: Alex Simkiv, Andy Bosyi, and Nazar Savchenko for productive conversations, collaboration, and valuable advice as well as the entire MindCraft.ai team for their constant support.

私有语料库以及代码和提示，都可以在 GitHub 上找到。

附言：
我要感谢我的同事 Alex Simkiv、Andy Bosyi 和 Nazar Savchenko，感谢他们卓有成效的讨论、协作和宝贵的建议，同时感谢整个 MindCraft.ai 团队的一贯支持。


## 原文


From Retrieval to Intelligence: Exploring RAG, Agent+RAG, and Evaluation with TruLens
Unlocking the Power of GPT-Generated Private Corpora

Vladyslav Fliahin

Published in Towards Data Science

Dec 4, 2024

Introduction
Nowadays the world has a lot of good foundation models to start your custom application with (gpt-4o, Sonnet, Gemini, Llama3.2, Gemma, Ministral, etc.). These models know everything about history, geography, and Wikipedia articles but still have weaknesses. Mostly there are two of them: level of details (e.g., the model knows about BMW, what it does, model names, and some more general info; but the model fails in case you ask about number of sales for Europe or details of the specific engine part) and the recent knowledge (e.g., Llama3.2 model or Ministral release; foundation models are trained at a certain point in time and have some knowledge cutoff date, after which the model doesn’t know anything).

A lot of books, depicting the amount of LLM knowledge.
Photo by Jaredd Craig on Unsplash
This article is focused on both issues, describing the situation of imaginary companies that were founded before the knowledge cutoff, while some information was changed recently.

To address both issues we will use the RAG technique and the LlamaIndex framework. The idea behind the Retrieval Augmented Generation is to supply the model with the most relevant information during the answer generation. This way we can have a DB with custom data, which the model will be able to utilize. To further assess the system performance we will incorporate the TruLens library and the RAG Triad metrics.

Mentioning the knowledge cutoff, this issue is addressed via google-search tools. Nevertheless, we can’t completely substitute the knowledge cutoff with the search tool. To understand this, imagine 2 ML specialists: first knows everything about the current GenAI state, and the second switched from the GenAI to the classic computer vision 6 month ago. If you ask them both the same question about how to use the recent GenAI models, it will take significantly different amount of search requests. The first one will know all about this, but maybe will double-check some specific commands. And the second will have to read a whole bunch of detailed articles to understand what’s going on first, what this model is doing, what is under the hood, and only after that he will be able to answer.

Basically it is like comparison of the field-expert and some general specialists, when one can answer quickly, and the second should go googling because he doesn’t know all the details the first does.

The main point here is that a lot of googling provides comparable answer within a significantly longer timeframe. For in chat-like applications users won’t wait minutes for the model to google smth. In addition, not all the information is open and can be googled.

Data
Right now it may be hard to find a dataset, that is not previously used in the training data of the foundation model. Almost all the data is indexed and used during the large models' pretraining stage.

Humans (as companies) walking around the forest looking for logs (data) and throwing them into the machine (LLM) that converts logs into fire. The “LLM” is written on the machine, and the “Data” is written on the logs. The fire out of the machines are going from the top.
Source: Image generated by the author using AI (Bing)
That’s why I decided to generate the one myself. For this purpose, I used the chatgpt-4o-latest via the OpenAI UI and several continuous prompts (all of them are similar to the ones below):

Generate me a private corpus with some details mentioning the imagined Ukraine Boats Inc.
A list of products, prices, responsible stuff, etc.
I want to use it as my private corpus for the RAG use-case
You can generate really a lot of the text. The more the better.
Yeah, proceed with partnerships, legal policies, competitions participated
Maybe info about where we manufacture our boats (and add some custom ones)
add client use studies
As a result, I generated a private corpus for 4 different companies. Below are the calculations of the tokens to better embrace the dataset size.

\# Number of tokens using the `o200k_base` tokenizer (gpt-4o/gpt-4o-mini)
nova-drive-motors.txt: 2757
aero-vance-aviation.txt: 1860
ukraine-boats.txt: 3793
city-solve.txt: 3826
total_tokens=12236
Below you can read the beginning of the Ukraine Boats Inc. description:

\#\# **Ukraine Boats Inc.**
**Corporate Overview:**
Ukraine Boats Inc. is a premier manufacturer and supplier of high-quality boats and maritime solutions based in Odessa, Ukraine. The company prides itself on blending traditional craftsmanship with modern technology to serve clients worldwide. Founded in 2005, the company has grown to be a leader in the boating industry, specializing in recreational, commercial, and luxury vessels.
 - -
\#\#\# **Product Lineup**
\#\#\#\# **Recreational Boats:**
1. **WaveRunner X200**
- **Description:** A sleek speedboat designed for water sports enthusiasts. Equipped with advanced navigation and safety features.
- **Price:** $32,000
- **Target Market:** Young adventurers and watersport lovers.
- **Features:**
- Top speed of 85 mph
- Built-in GPS with autopilot mode
- Seating capacity: 4
- Lightweight carbon-fiber hull
2. **AquaCruise 350**
- **Description:** A versatile motorboat ideal for fishing, family trips, and casual cruising.
- **Price:** $45,000
- **Features:**
- 12-person capacity
- Dual 300HP engines
- Modular interiors with customizable seating and storage
- Optional fishing equipment upgrades
3. **SolarGlide EcoBoat**
- **Description:** A solar-powered boat for environmentally conscious customers.
- **Price:** $55,000
- **Features:**
- Solar panel roof with 12-hour charge life
- Zero emissions
- Maximum speed: 50 mph
- Silent motor technology
 - -
…
The complete private corpus can be found on GitHub.

For the purpose of the evaluation dataset, I have also asked the model to generate 10 questions (about Ukraine Boats Inc. only) based on the given corpus.

based on the whole corpus above, generate 10 questions and answers for them pass them into the python native data structure
Here is the dataset obtained:

[
    {
        "question": "What is the primary focus of Ukraine Boats Inc.?",
        "answer": "Ukraine Boats Inc. specializes in manufacturing high-quality recreational, luxury, and commercial boats, blending traditional craftsmanship with modern technology."
    },
    {
        "question": "What is the price range for recreational boats offered by Ukraine Boats Inc.?",
        "answer": "Recreational boats range from $32,000 for the WaveRunner X200 to $55,000 for the SolarGlide EcoBoat."
    },
    {
        "question": "Which manufacturing facility focuses on bespoke yachts and customizations?",
        "answer": "The Lviv Custom Craft Workshop specializes in bespoke yachts and high-end customizations, including handcrafted woodwork and premium materials."
    },
    {
        "question": "What is the warranty coverage offered for boats by Ukraine Boats Inc.?",
        "answer": "All boats come with a 5-year warranty for manufacturing defects, while engines are covered under a separate 3-year engine performance guarantee."
    },
    {
        "question": "Which client used the Neptune Voyager catamaran, and what was the impact on their business?",
        "answer": "Paradise Resorts International used the Neptune Voyager catamarans, resulting in a 45% increase in resort bookings and winning the 'Best Tourism Experience' award."
    },
    {
        "question": "What award did the SolarGlide EcoBoat win at the Global Marine Design Challenge?",
        "answer": "The SolarGlide EcoBoat won the 'Best Eco-Friendly Design' award at the Global Marine Design Challenge in 2022."
    },
    {
        "question": "How has the Arctic Research Consortium benefited from the Poseidon Explorer?",
        "answer": "The Poseidon Explorer enabled five successful Arctic research missions, increased data collection efficiency by 60%, and improved safety in extreme conditions."
    },
    {
        "question": "What is the price of the Odessa Opulence 5000 luxury yacht?",
        "answer": "The Odessa Opulence 5000 luxury yacht starts at $1,500,000."
    },
    {
        "question": "Which features make the WaveRunner X200 suitable for watersports?",
        "answer": "The WaveRunner X200 features a top speed of 85 mph, a lightweight carbon-fiber hull, built-in GPS, and autopilot mode, making it ideal for watersports."
    },
    {
        "question": "What sustainability initiative is Ukraine Boats Inc. pursuing?",
        "answer": "Ukraine Boats Inc. is pursuing the Green Maritime Initiative (GMI) to reduce the carbon footprint by incorporating renewable energy solutions in 50% of their fleet by 2030."
    }
]
Now, when we have the private corpus and the dataset of Q&A pairs, we can insert our data into some suitable storage.

Data propagation
We can utilize a variety of databases for the RAG use case, but for this project and the possible handling of future relations, I integrated the Neo4j DB into our solution. Moreover, Neo4j provides a free instance after registration.

Now, let’s start preparing nodes. First, we instantiate an embedding model. We used the 256 vector dimensions because some recent tests showed that bigger vector dimensions led to scores with less variance (and that’s not what we need). As an embedding model, we used the text-embedding-3-small model.

\# initialize models
embed_model = OpenAIEmbedding(
  model=CFG['configuration']['models']['embedding_model'],
  api_key=os.getenv('AZURE_OPENAI_API_KEY'),
  dimensions=CFG['configuration']['embedding_dimension']
)
After that, we read the corpus:

\# get documents paths
document_paths = [Path(CFG['configuration']['data']['raw_data_path']) / document for document in CFG['configuration']['data']['source_docs']]

\# initialize a file reader
reader = SimpleDirectoryReader(input_files=document_paths)

\# load documents into LlamaIndex Documents
documents = reader.load_data()
Furthermore, we utilize the SentenceSplitter to convert documents into separate nodes. These nodes will be stored in the Neo4j database.

neo4j_vector = Neo4jVectorStore(
    username=CFG['configuration']['db']['username'],
    password=CFG['configuration']['db']['password'],
    url=CFG['configuration']['db']['url'],
    embedding_dimension=CFG['configuration']['embedding_dimension'],
    hybrid_search=CFG['configuration']['hybrid_search']
)

\# setup context
storage_context = StorageContext.from_defaults(
    vector_store=neo4j_vector
)

\# populate DB with nodes
index = VectorStoreIndex(nodes, storage_context=storage_context, show_progress=True)
Hybrid search is turned off for now. This is done deliberately to outline the performance of the vector-search algorithm.

We are all set, and now we are ready to go to the querying pipeline.

UI of the Neo4j Aura depicting the Nodes we have inserted to the DB.
Source: Image created by the author
Pipeline
The RAG technique may be implemented as a standalone solution or as a part of an agent. The agent is supposed to handle all the chat history, tools handling, reasoning, and output generation. Below we will have a walkthrough on how to implement the query engines (standalone RAG) and the agent approach (the agent will be able to call the RAG as one of its tools).

Often when we talk about the chat models, the majority will pick the OpenAI models without considering the alternatives. We will outline the usage of RAG on OpenAI models and the Meta Llama 3.2 models. Let’s benchmark which one performs better.

All the configuration parameters are moved to the pyproject.toml file.

[configuration]
similarity_top_k = 10
vector_store_query_mode = "default"
similarity_cutoff = 0.75
response_mode = "compact"
distance_strategy = "cosine"
embedding_dimension = 256
chunk_size = 512
chunk_overlap = 128
separator = " "
max_function_calls = 2
hybrid_search = false

[configuration.data]
raw_data_path = "../data/companies"
dataset_path = "../data/companies/dataset.json"
source_docs = ["city-solve.txt", "aero-vance-aviation.txt", "nova-drive-motors.txt", "ukraine-boats.txt"]

[configuration.models]
llm = "gpt-4o-mini"
embedding_model = "text-embedding-3-small"
temperature = 0
llm_hf = "meta-llama/Llama-3.2-3B-Instruct"
context_window = 8192
max_new_tokens = 4096
hf_token = "hf_custom-token"
llm_evaluation = "gpt-4o-mini"

[configuration.db]
url = "neo4j+s://custom-url"
username = "neo4j"
password = "custom-password"
database = "neo4j" 
index_name = "article" \# change if you want to load the new data that won't intersect with the previous uploads
text_node_property = "text"
The common step for both models is connecting to the existing vector index inside the neo4j.

\# connect to the existing neo4j vector index
vector_store = Neo4jVectorStore(
  username=CFG['configuration']['db']['username'],
  password=CFG['configuration']['db']['password'],
  url=CFG['configuration']['db']['url'],
  embedding_dimension=CFG['configuration']['embedding_dimension'],
  distance_strategy=CFG['configuration']['distance_strategy'],
  index_name=CFG['configuration']['db']['index_name'],
  text_node_property=CFG['configuration']['db']['text_node_property']
)
index = VectorStoreIndex.from_vector_store(vector_store)
OpenAI
Firstly we should initialize the OpenAI models needed. We will use the gpt-4o-mini as a language model and the same embedding model. We specify the LLM and embedding model for the Settings object. This way we don’t have to pass these models further. The LlamaIndex will try to parse the LLM from the Settings if it’s needed.

\# initialize models
llm = OpenAI(
  api_key=os.getenv('AZURE_OPENAI_API_KEY'),
  model=CFG['configuration']['models']['llm'],
  temperature=CFG['configuration']['models']['temperature']
)
embed_model = OpenAIEmbedding(
  model=CFG['configuration']['models']['embedding_model'],
  api_key=os.getenv('AZURE_OPENAI_API_KEY'),
  dimensions=CFG['configuration']['embedding_dimension']
)

Settings.llm = llm
Settings.embed_model = embed_model
QueryEngine
After that, we can create a default query engine from the existing vector index:

\# create query engine
query_engine = index.as_query_engine()
Furthermore, we can obtain the RAG logic using simply a query() method. In addition, we printed the list of the source nodes, retrieved from the DB, and the final LLM response.

\# custom question
response = query_engine.query("What is the primary focus of Ukraine Boats Inc.?")

\# get similarity scores
for node in response.source_nodes:
  print(f'{node.node.id_}, {node.score}')

\# predicted answer
print(response.response)
Here is the sample output:

ukraine-boats-3, 0.8536546230316162
ukraine-boats-4, 0.8363556861877441


The primary focus of Ukraine Boats Inc. is designing, manufacturing, and selling luxury and eco-friendly boats, with a strong emphasis on customer satisfaction and environmental sustainability.
As you can see, we created custom node ids, so that we can understand the file from which it was taken and the ordinal id of the chunk. We can be much more specific with the query engine attitude using the low-level LlamaIndex API:

\# custom retriever
retriever = VectorIndexRetriever(
  index=index,
  similarity_top_k=CFG['configuration']['similarity_top_k'],
  vector_store_query_mode=CFG['configuration']['vector_store_query_mode']
)

\# similarity threshold
similarity_postprocessor = SimilarityPostprocessor(similarity_cutoff=CFG['configuration']['similarity_cutoff'])

\# custom response synthesizer
response_synthesizer = get_response_synthesizer(
  response_mode=CFG['configuration']['response_mode']
)

\# combine custom query engine
query_engine = RetrieverQueryEngine(
  retriever=retriever,
  node_postprocessors=[similarity_postprocessor],
  response_synthesizer=response_synthesizer
)
Here we specified custom retriever, similarity postprocessor, and refinement stage actions.

For further customization, you can create custom wrappers around any of the LlamaIndex components to make them more specific and aligned with your needs.

Agent
To implement a RAG-based agent inside the LlamaIndex, we need to use one of the predefined AgentWorkers. We will stick to the OpenAIAgentWorker, which uses OpenAI’s LLM as its brain. Moreover, we wrapped our query engine from the previous part into the QueryEngineTool, which the agent may pick based on the tool’s description.

AGENT_SYSTEM_PROMPT = "You are a helpful human assistant. You always call the retrieve_semantically_similar_data tool before answering any questions. If the answer to the questions couldn't be found using the tool, just respond with `Didn't find relevant information`."
TOOL_NAME = "retrieve_semantically_similar_data"
TOOL_DESCRIPTION = "Provides additional information about the companies. Input: string"

\# agent worker
agent_worker = OpenAIAgentWorker.from_tools(
    [
        QueryEngineTool.from_defaults(
            query_engine=query_engine,
            name=TOOL_NAME,
            description=TOOL_DESCRIPTION,
            return_direct=False,
        )
    ],
    system_prompt=AGENT_SYSTEM_PROMPT,
    llm=llm,
    verbose=True,
    max_function_calls=CFG['configuration']['max_function_calls']
)
To further use the agent, we need an AgentRunner. The runner is more like an orchestrator, handling top-level interactions and state, while the worker performs concrete actions, like tool and LLM usage.

\# agent runner
agent = AgentRunner(agent_worker=agent_worker)
AgentRunner holding the context, history, tool calls and the AgentWorker doing all the low-level work.
Source: Image taken from the LlamaIndex docs
To test the user-agent interactions efficiently, I implemented a simple chat-like interface:

while True:
  \# get user input
  current_message = input('Insert your next message:')
  print(f'{datetime.now().strftime("%H:%M:%S.%f")[:-3]}|User: {current_message}')

  response = agent.chat(current_message)
  print(f'{datetime.now().strftime("%H:%M:%S.%f")[:-3]}|Agent: {response.response}')
Here is a sample of the chat:

Insert your next message: Hi
15:55:43.101|User: Hi
Added user message to memory: Hi
15:55:43.873|Agent: Didn't find relevant information.
Insert your next message: Do you know anything about the city solve?
15:56:24.751|User: Do you know anything about the city solve?
Added user message to memory: Do you know anything about the city solve?
=== Calling Function ===
Calling function: retrieve_semantically_similar_data with args: {"input":"city solve"}
Got output: Empty Response

15:56:37.267|Agent: Didn't find relevant information.
Insert your next message: What is the primary focus of Ukraine Boats Inc.?
15:57:36.122|User: What is the primary focus of Ukraine Boats Inc.?
Added user message to memory: What is the primary focus of Ukraine Boats Inc.?
=== Calling Function ===
Calling function: retrieve_semantically_similar_data with args: {"input":"Ukraine Boats Inc."}
Got output: Ukraine Boats Inc. is a premier manufacturer and supplier of high-quality boats and maritime solutions based in Odessa, Ukraine. Founded in 2005, the company specializes in recreational, commercial, and luxury vessels, blending traditional craftsmanship with modern technology. It has established a strong market presence in Europe, North America, and Asia, supported by partnerships with distribution companies like Baltic Marine Distributors in Germany, OceanCraft LLC in the USA, and Yokohama SeaTech in Japan.

The company is organized into several departments, including Engineering, Sales and Marketing, Production, and Customer Service, each with specific responsibilities to ensure efficient operations and customer satisfaction. Ukraine Boats Inc. is committed to sustainability through initiatives like the Green Maritime Initiative, aiming to reduce its carbon footprint by incorporating renewable energy solutions in its fleet.

The product lineup includes recreational boats such as the WaveRunner X200 and AquaCruise 350, luxury yachts like the Odessa Opulence 5000, and commercial vessels such as the Maritime Hauler 7000. The company also offers customization options, maintenance plans, and a range of accessories to enhance the boating experience.

With a focus on innovation and quality, Ukraine Boats Inc. has received accolades in various marine design competitions and continues to expand its global footprint while maintaining a commitment to environmental compliance and customer service excellence.

15:57:49.505|Agent: The primary focus of Ukraine Boats Inc. is the manufacturing and supplying of high-quality boats and maritime solutions. Based in Odessa, Ukraine, the company specializes in recreational, commercial, and luxury vessels, combining traditional craftsmanship with modern technology. They are committed to sustainability and have initiatives like the Green Maritime Initiative to reduce their carbon footprint. Their product lineup includes various types of boats, and they also offer customization options and maintenance plans.
Insert your next message: Do you know anything about the government company city solve?
15:59:02.830|User: Do you know anything about the government company city solve?
Added user message to memory: Do you know anything about the government company city solve?
=== Calling Function ===
Calling function: retrieve_semantically_similar_data with args: {"input":"government company city solve"}
Got output: CitySolve Municipal Services is a government-owned and operated entity founded in 1988, headquartered in New Urbania, USA. Its mission is to ensure a livable, sustainable, and efficient city by providing prompt solutions to residents' everyday needs. The company focuses on various critical service areas, including waterworks and drainage, parks and greenery management, roads and sidewalks, waste management, public safety infrastructure, and urban utilities. CitySolve emphasizes core values such as responsiveness, reliability, accountability, and sustainability, and utilizes modern technologies to enhance its operations and community impact.

15:59:12.693|Agent: CitySolve Municipal Services is a government-owned and operated entity founded in 1988, headquartered in New Urbania, USA. Its mission is to ensure a livable, sustainable, and efficient city by providing prompt solutions to residents' everyday needs. The company focuses on critical service areas such as waterworks and drainage, parks and greenery management, roads and sidewalks, waste management, public safety infrastructure, and urban utilities. CitySolve emphasizes core values like responsiveness, reliability, accountability, and sustainability, and it utilizes modern technologies to enhance its operations and community impact.
Insert your next message: Thanks
15:59:28.761|User: Thanks
Added user message to memory: Thanks
15:59:30.327|Agent: Didn't find relevant information.
What we can see, is that for the correct vector search you need to specify the input questions with more details, that can be semantically matched.

Open source
As an open source model, we have utilized the meta-llama/Llama-3.2–3B-Instruct. This choice was based on the model latency & performance trade-off. First things first we need to authenticate our HuggingFace account via an access token.

\# Use your token here
login(token=CFG['configuration']['models']['hf_token'])
To use the Llama as an LLM inside the LlamaIndex, we need to create a model wrapper. We will use a single NVIDIA GeForce RTX 3090 to serve our Llama 3.2 model.

SYSTEM_PROMPT = """You are an AI assistant that answers questions in a friendly manner, based on the given source documents. Here are some rules you always follow:
- Generate human readable output, avoid creating output with gibberish text.
- Generate only the requested output, don't include any other language before or after the requested output.
- Never say thank you, that you are happy to help, that you are an AI agent, etc. Just answer directly.
- Generate professional language typically used in business documents in North America.
- Never generate offensive or foul language.
"""

query_wrapper_prompt = PromptTemplate(
    "<|start_header_id|>system<|end_header_id|>\n" + SYSTEM_PROMPT + "<|eot_id|><|start_header_id|>user<|end_header_id|>{query_str}<|eot_id|><|start_header_id|>assistant<|end_header_id|>"
)

llm = HuggingFaceLLM(
    context_window=CFG['configuration']['models']['context_window'],
    max_new_tokens=CFG['configuration']['models']['max_new_tokens'],
    generate_kwargs={"temperature": CFG['configuration']['models']['temperature'], "do_sample": False},
    query_wrapper_prompt=query_wrapper_prompt,
    tokenizer_name=CFG['configuration']['models']['llm_hf'],
    model_name=CFG['configuration']['models']['llm_hf'],
    device_map="cuda:0",
    model_kwargs={"torch_dtype": torch.bfloat16}
)

Settings.llm = llm
QueryEngine
The interfaces are the same. Example output is below:

ukraine-boats-3, 0.8536546230316162
ukraine-boats-4, 0.8363556861877441


The primary focus of Ukraine Boats Inc. is designing, manufacturing, and selling luxury and eco-friendly boats, with a strong emphasis on customer satisfaction and environmental sustainability.
Agent
For the OpenAI models, LlamaIndex has a special agent wrapper designed, but for the open-source models we should use another wrapper. We selected ReActAgent, which iteratively does reasoning and acting until the final response is ready.

agent_worker = ReActAgentWorker.from_tools(
    [
        QueryEngineTool.from_defaults(
            query_engine=query_engine,
            name=TOOL_NAME,
            description=TOOL_DESCRIPTION,
            return_direct=False,
        )
    ],
    llm=llm,
    verbose=True,
    chat_history=[ChatMessage(content=AGENT_SYSTEM_PROMPT, role="system")]
)

\# agent runner
agent = AgentRunner(agent_worker=agent_worker)
Below is the same discussion but with a different Agent under the hood:

Insert your next message: Hi
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
16:04:29.117|User: Hi
Thought: The current language of the user is: English. I need to use a tool to help me answer the question.
Action: retrieve_semantically_similar_data
Action Input: {'input': 'hello world', 'num_beams': 5}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: Empty Response
Thought: I still need more information to answer the question. The tool did not provide any useful output. I'll try to gather more context.
Action: retrieve_semantically_similar_data
Action Input: {'input': 'hello world', 'num_beams': 5}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: Empty Response
Thought: I still don't have enough information to answer the question. The tool did not provide any useful output. I'll try to gather more context.
Action: retrieve_semantically_similar_data
Action Input: {'input': 'hello world', 'num_beams': 5}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: Empty Response
Thought: I'm starting to think that the tool is not the best approach to answer this question. The user's input "hello world" is very general and the tool is not providing any useful output. I'll try to think of a different approach.
Answer: Hello, how can I assist you today?
16:04:37.764|Agent: Hello, how can I assist you today?
Insert your next message: Do you know anything about the city solve?
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
16:05:08.756|User: Do you know anything about the city solve?
Thought: The current language of the user is: English. I need to use a tool to help me answer the question.
Action: retrieve_semantically_similar_data
Action Input: {'input': 'solve city'}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: 

CitySolve Municipal Services is the lifeline of New Urbania, addressing a wide range of city-level concerns and providing prompt solutions to residents' everyday needs.
Thought: I can answer without using any more tools. I'll use the user's language to answer
Answer: CitySolve Municipal Services is a city-level organization that provides solutions to residents' everyday needs in New Urbania.
16:05:13.003|Agent: CitySolve Municipal Services is a city-level organization that provides solutions to residents' everyday needs in New Urbania.
Insert your next message: What is the primary focus of Ukraine Boats Inc.?
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
16:05:34.892|User: What is the primary focus of Ukraine Boats Inc.?
Thought: The current language of the user is: English. I need to use a tool to help me answer the question.
Action: retrieve_semantically_similar_data
Action Input: {'input': 'Ukraine Boats Inc.'}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: 

Ukraine Boats Inc. is a premier manufacturer and supplier of high-quality boats and maritime solutions based in Odessa, Ukraine. The company prides itself on blending traditional craftsmanship with modern technology to serve clients worldwide. Founded in 2005, the company has grown to be a leader in the boating industry, specializing in recreational, commercial, and luxury vessels.

The company has successfully delivered a range of boats and solutions to various clients, including Blue Horizon Fisheries, Azure Seas Luxury Charters, Coastal Safety Patrol, EcoTrade Logistics, Team HydroBlitz Racing, and Paradise Resorts International. These clients have reported significant benefits from working with Ukraine Boats Inc., including increased efficiency, reduced costs, and enhanced customer satisfaction.

Ukraine Boats Inc. offers a range of products and services, including luxury yachts, commercial boats, and accessories. The company's products are designed to meet the specific needs of each client, and its team of experts works closely with clients to ensure that every boat is tailored to their requirements.

Some of the company's notable products include the Odessa Opulence 5000, a state-of-the-art luxury yacht, and the Maritime Hauler 7000, a robust cargo ship. The company also offers boat customization packages, annual maintenance plans, and other services to support its clients' needs.

Overall, Ukraine Boats Inc. is a trusted and reliable partner for clients seeking high-quality boats and maritime solutions.
Thought: I can answer without using any more tools. I'll use the user's language to answer
Answer: Ukraine Boats Inc. is a premier manufacturer and supplier of high-quality boats and maritime solutions based in Odessa, Ukraine, blending traditional craftsmanship with modern technology to serve clients worldwide.
16:05:53.311|Agent: Ukraine Boats Inc. is a premier manufacturer and supplier of high-quality boats and maritime solutions based in Odessa, Ukraine, blending traditional craftsmanship with modern technology to serve clients worldwide.
Insert your next message: Do you know anything about the government company city solve?
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
16:06:09.949|User: Do you know anything about the government company city solve?
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Thought: The current language of the user is English. I need to use a tool to help me answer the question.
Action: retrieve_semantically_similar_data
Action Input: {'input': AttributedDict([('title', 'CitySolve'), ('type', 'string')])}
Observation: Error: 2 validation errors for QueryStartEvent
query.str
  Input should be a valid string [type=string_type, input_value=AttributedDict([('title',...'), ('type', 'string')]), input_type=AttributedDict]
    For further information visit https://errors.pydantic.dev/2.9/v/string_type
query.QueryBundle.query_str
  Field required [type=missing, input_value=AttributedDict([('title',...'), ('type', 'string')]), input_type=AttributedDict]
    For further information visit https://errors.pydantic.dev/2.9/v/missing
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: Error: Could not parse output. Please follow the thought-action-input format. Try again.
Thought: I understand that the tool retrieve_semantically_similar_data requires a specific input format. I will make sure to follow the correct format.
Action: retrieve_semantically_similar_data
Action Input: {'title': 'CitySolve', 'type': 'string'}
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
Observation: 

CitySolve Municipal Services is a government-owned and operated company that serves as the backbone of New Urbania's civic infrastructure, addressing a wide range of city-level concerns.
Thought: I can answer without using any more tools. I'll use the user's language to answer
Answer: CitySolve Municipal Services is a government-owned and operated company that serves as the backbone of New Urbania's civic infrastructure, addressing a wide range of city-level concerns.
16:06:17.799|Agent: CitySolve Municipal Services is a government-owned and operated company that serves as the backbone of New Urbania's civic infrastructure, addressing a wide range of city-level concerns.
Insert your next message: Thanks
Setting `pad_token_id` to `eos_token_id`:None for open-end generation.
16:06:34.232|User: Thanks
Thought: I can answer without using any more tools. I'll use the user's language to answer
Answer: CitySolve Municipal Services is a government-owned and operated company that serves as the backbone of New Urbania's civic infrastructure, addressing a wide range of city-level concerns.
16:06:35.734|Agent: CitySolve Municipal Services is a government-owned and operated company that serves as the backbone of New Urbania's civic infrastructure, addressing a wide range of city-level concerns.
As we can see, the agents reason differently. Given the same questions, the two models decided to query the tool differently. The second agent failed with the tool once, but it’s more an issue of the tool description than the agent itself. Both of them provided the user with valuable answers, which is the final goal of the RAG approach.

In addition, there are a lof of different agent wrappers that you can apply on top of your LLM. They may significantly change a way the model interacts with the world.

Evaluation
To evaluate the RAG, nowadays there are a lot of frameworks available. One of them is the TruLens. Overall RAG performance is assessed using the so-called RAG Triad (answer relevance, context relevance, and groundedness).

To estimate relevances and groundedness we are going to utilize the LLMs. The LLMs will act as judges, which will score the answers based on the information given.

TruLens itself is a convenient tool to measure system performance on a metric level and analyze the specific record’s assessments. Here is the leaderboard UI view:

UI leaderboard view of the TruLens framework
Source: Image created by the author
Below is the per-record table of assessments, where you can review all the internal processes being invoked.

Per-record table of assessments, where you can review all the internal processed being invoked. Part of the TruLens UI.
Source: Image created by the author
To get even more details, you can review the execution process for a specific record.

Execution process for a specific record inside the TruLens UI.
Source: Image created by the author
To implement the RAG Triad evaluation, first of all, we have to define the experiment name and the model provider. We will utilize the gpt-4o-mini model for the evaluation.

experiment_name = "llama-3.2-3B-custom-retriever"

provider = OpenAIProvider(
    model_engine=CFG['configuration']['models']['llm_evaluation']
)
After that, we define the Triad itself (answer relevance, context relevance, groundedness). For each metric, we should specify inputs and outputs.

context_selection = TruLlama.select_source_nodes().node.text

\# context relevance (for each of the context chunks)
f_context_relevance = (
    Feedback(
        provider.context_relevance, name="Context Relevance"
    )
    .on_input()
    .on(context_selection)
)

\# groundedness
f_groundedness_cot = (
    Feedback(
        provider.groundedness_measure_with_cot_reasons, name="Groundedness"
    )
    .on(context_selection.collect())
    .on_output()
)

\# answer relevance between overall question and answer
f_qa_relevance = (
    Feedback(
        provider.relevance_with_cot_reasons, name="Answer Relevance"
    )
    .on_input_output()
)
Furthermore, we instantiate the TruLlama object that will handle the feedback calculation during the agent calls.

\# Create TruLlama agent
tru_agent = TruLlama(
    agent,
    app_name=experiment_name,
    tags="agent testing",
    feedbacks=[f_qa_relevance, f_context_relevance, f_groundedness_cot],
)
Now we are ready to execute the evaluation pipeline on our dataset.

for item in tqdm(dataset):
    try:
        agent.reset()
        
        with tru_agent as recording:
            agent.query(item.get('question'))
        record_agent = recording.get()
        
        \# wait until all the feedback function are finished
        for feedback, result in record_agent.wait_for_feedback_results().items():
            logging.info(f'{feedback.name}: {result.result}')
    except Exception as e:
        logging.error(e)
        traceback.format_exc()
We have conducted experiments using the 2 models, default/custom query engines, and extra tool input parameters description (ReAct agent struggled without the explicit tool input params description, trying to call non-existing tools to refactor the input). We can review the results as a DataFrame using a get_leaderboard() method.

Experiments results table.
Source: Image created by the author
Conclusion
Data -> neo4j -> agent -> rag pipeline
Source: Image generate by the author using AI (Bing)
We obtained a private corpus, incorporating GPT models for the custom dataset generation. The actual corpus content is pretty interesting and diverse. That’s the reason why a lot of models are successfully fine-tuned using the GPT-generated samples right now.

Neo4j DB provides convenient interfaces for a lot of frameworks while having one of the best UI capabilities (Aura). In real projects, we often have relations between the data, and GraphDB is a perfect choice for such use cases.

On top of the private corpus, we implemented different RAG approaches (standalone and as a part of the agent). Based on the RAG Triad metrics, we observed that an OpenAI-based agent works perfectly, while a well-prompted ReAct agent performs relatively the same. A big difference was in the usage of a custom query engine. That’s reasonable because we configured some specific procedures and thresholds that align with our data. In addition, both solutions have high groundedness, which is very important for RAG applications.

Another interesting takeaway is that the Agent call latency of the Llama3.2 3B and gpt-4o-mini API was pretty much the same (of course the most time took the DB call, but the difference is still not that big).

Though our system works pretty well, there are a lot of improvements to be done, such as keyword search, rerankers, neighbor chunking selection, and the ground truth labels comparison. These topics will be discussed in the next articles on the RAG applications.

Private corpus, alongside the code and prompts, can be found on GitHub.

P.S.
I want to thank my colleagues: Alex Simkiv, Andy Bosyi, and Nazar Savchenko for productive conversations, collaboration, and valuable advice as well as the entire MindCraft.ai team for their constant support.