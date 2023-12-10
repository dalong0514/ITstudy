## 20231209检索增强生成-RAG-从理论到LangChain实践

[Retrieval-Augmented Generation (RAG): From Theory to LangChain Implementation | by Leonie Monigatti | Nov, 2023 | Towards Data Science](https://towardsdatascience.com/retrieval-augmented-generation-rag-from-theory-to-langchain-implementation-4e9bd5f6a4f2)

[检索增强生成（RAG）：从理论到 LangChain 实践 [译] | 宝玉的分享](https://baoyu.io/translations/rag/retrieval-augmented-generation-rag-from-theory-to-langchain-implementation)

Retrieval-Augmented Generation (RAG): From Theory to LangChain Implementation

From the theory of the original academic paper to its Python implementation with OpenAI, Weaviate, and LangChain

Leonie Monigatti

Since the realization that you can supercharge large language models (LLMs) with your proprietary data, there has been some discussion on how to most effectively bridge the gap between the LLM's general knowledge and your proprietary data. There has been a lot of debate around whether fine-tuning or Retrieval-Augmented Generation (RAG) is more suited for this (spoiler alert: it's both).

This article first focuses on the concept of RAG and first covers its theory. Then, it goes on to showcase how you can implement a simple RAG pipeline using LangChain for orchestration, OpenAI language models, and a Weaviate vector database.

[RAG vs Finetuning — Which Is the Best Tool to Boost Your LLM Application? | by Heiko Hotz | Towards Data Science](https://towardsdatascience.com/rag-vs-finetuning-which-is-the-best-tool-to-boost-your-llm-application-94654b1eaba7)

[LangChain](https://www.langchain.com/)

[Welcome | Weaviate - Vector Database](https://weaviate.io/)

Published on December 7, 2023

检索增强生成（RAG）：从理论到 LangChain 实践 [译]

从学术论文的理论到利用 OpenAI、Weaviate 和 LangChain 的 Python 应用实现

检索增强生成（RAG）的工作流程：从用户查询开始，通过向量数据库检索，到填充提示，最终形成回答的全过程。

图：检索增强生成的工作流程

自从发现可以利用自有数据来增强大型语言模型（LLM）的能力以来，如何将 LLM 的通用知识与个人数据有效结合一直是热门话题。关于使用微调（fine-tuning）还是检索增强生成（RAG）来实现这一目标的讨论持续不断（剧透：两种方法都很关键）。

这篇文章首先探讨 RAG 的理念，并对其理论基础进行阐释。接着，文章展示了如何结合 LangChain 进行操作管理、OpenAI 语言模型和 Weaviate 向量数据库，来实现一个简易的 RAG 流程。

### 01. What is Retrieval-Augmented Generation

Retrieval-Augmented Generation (RAG) is the concept to provide LLMs with additional information from an external knowledge source. This allows them to generate more accurate and contextual answers while reducing hallucinations.

什么是检索增强生成？

检索增强生成（RAG）是一个概念，它旨在为大型语言模型（LLM）提供额外的、来自外部知识源的信息。这样，LLM 在生成更精确、更贴合上下文的答案的同时，也能有效减少产生误导性信息的可能。

Problem

State-of-the-art LLMs are trained on large amounts of data to achieve a broad spectrum of general knowledge stored in the neural network's weights (parametric memory). However, prompting an LLM to generate a completion that requires knowledge that was not included in its training data, such as newer, proprietary, or domain-specific information, can lead to factual inaccuracies (hallucinations), as illustrated in the following screenshot:

ChatGPT’s answer to the question, “What did the president say about Justice Breyer?”

Thus, it is important to bridge the gap between the LLM’s general knowledge and any additional context to help the LLM generate more accurate and contextual completions while reducing hallucinations.

问题

当下领先的大语言模型 (LLMs) 是基于大量数据训练的，目的是让它们掌握广泛的普遍知识，这些知识被储存在它们神经网络的权重（也就是参数记忆）里。但是，如果我们要求 LLM 生成的回答涉及到它训练数据之外的知识 —— 比如最新的、专有的或某个特定领域的信息 —— 这时就可能出现事实上的错误（我们称之为「幻觉」），以下截图就是一个典型案例：

ChatGPT 在回答「总统对布雷耶法官有何看法？」这个问题时表示：「我不知道，因为我没有办法获取实时的信息」。

这是 ChatGPT 回答「总统对布雷耶法官有何看法？」这个问题的情况。

因此，弥合 LLM 的常识与任何额外语境之间的差距非常重要，这样才能帮助 LLM 生成更准确、更符合语境的补全，同时减少幻觉。

Solution

Traditionally, neural networks are adapted to domain-specific or proprietary information by fine-tuning the model. Although this technique is effective, it is also compute-intensive, expensive, and requires technical expertise, making it less agile to adapt to evolving information.

In 2020, Lewis et al. proposed a more flexible technique called Retrieval-Augmented Generation (RAG) in the paper Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks [1]. In this paper, the researchers combined a generative model with a retriever module to provide additional information from an external knowledge source that can be updated more easily.

[[2005.11401] Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks](https://arxiv.org/abs/2005.11401)

2『已下载论文「2023064Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks」。（2023-12-10）』

解决方案

传统上，要让神经网络适应特定领域或私有信息，人们通常会对模型进行微调。这种方法确实有效，但同时也耗费大量计算资源、成本高昂，且需要丰富的技术知识，因此在快速适应信息变化方面并不灵活。

2020 年，Lewis 等人在论文《知识密集型 NLP 任务的检索增强生成》(Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks) [1] 中，提出了一种更为灵活的技术 —— 检索增强生成（Retrieval-Augmented Generation，RAG）。该研究将生成模型与检索模块结合起来，能够从易于更新的外部知识源中获取额外信息。

In simple terms, RAG is to LLMs what an open-book exam is to humans. In an open-book exam, students are allowed to bring reference materials, such as textbooks or notes, which they can use to look up relevant information to answer a question. The idea behind an open-book exam is that the test focuses on the students' reasoning skills rather than their ability to memorize specific information.

Similarly, the factual knowledge is separated from the LLM's reasoning capability and stored in an external knowledge source, which can be easily accessed and updated:

Parametric knowledge: Learned during training that is implicitly stored in the neural network's weights.

Non-parametric knowledge: Stored in an external knowledge source, such as a vector database.

(By the way, I didn't come up with this genius comparison. As far as I know, this comparison was first mentioned by JJ during the Kaggle — LLM Science Exam competition.)

[Open Book LLM Science Exam | Kaggle](https://www.kaggle.com/code/jjinho/open-book-llm-science-exam)

用一个简单的比喻来说，RAG 对大语言模型（Large Language Model，LLM）的作用，就像开卷考试对学生一样。在开卷考试中，学生可以带着参考资料进场，比如教科书或笔记，用来查找解答问题所需的相关信息。开卷考试的核心在于考察学生的推理能力，而非对具体信息的记忆能力。

同样地，在 RAG 中，事实性知识与 LLM 的推理能力相分离，被存储在容易访问和及时更新的外部知识源中，具体分为两种：

1、参数化知识（Parametric knowledge）：模型在训练过程中学习得到的，隐式地储存在神经网络的权重中。

2、非参数化知识（Non-parametric knowledge）：存储在外部知识源，例如向量数据库中。

（顺便提一下，这个贴切的比喻并非我首创，最早是在 Kaggle 的 LLM 科学考试竞赛中，由 JJ 提出的。）

The vanilla RAG workflow is illustrated below:

Fig: Retrieval-Augmented Generation Workflow - Retrieval augmented generation (RAG) workflow from user query through retrieval with a vector database to prompt stuffing and finally generating a response.

Retrieve: The user query is used to retrieve relevant context from an external knowledge source. For this, the user query is embedded with an embedding model into the same vector space as the additional context in the vector database. This allows to perform a similarity search, and the top k closest data objects from the vector database are returned.

Augment: The user query and the retrieved additional context are stuffed into a prompt template.

Generate: Finally, the retrieval-augmented prompt is fed to the LLM.

下面是 RAG 工作流程的示意图：

图：检索增强生成的工作流程 —— 检索增强生成（RAG）的工作流程，从用户的查询开始，经过向量数据库的检索，到提示填充，最后生成回应。

检索： 此过程涉及利用用户的查询内容，从外部知识源获取相关信息。具体来说，就是将用户的查询通过嵌入模型转化为向量，以便与向量数据库中的其他上下文信息进行比对。通过这种相似性搜索，可以找到向量数据库中最匹配的前 k 个数据。

增强：接着，将用户的查询和检索到的额外信息一起嵌入到一个预设的提示模板中。

生成：最后，这个经过检索增强的提示内容会被输入到大语言模型 (LLM) 中，以生成所需的输出。

### 02. Retrieval-Augmented Generation Implementation using LangChain

This section implements a RAG pipeline in Python using an OpenAI LLM in combination with a Weaviate vector database and an OpenAI embedding model. LangChain is used for orchestration.

If you are unfamiliar with LangChain or Weaviate, you might want to check out the following two articles:

[Getting Started with LangChain: A Beginner’s Guide to Building LLM-Powered Applications | by Leonie Monigatti | Towards Data Science](https://towardsdatascience.com/getting-started-with-langchain-a-beginners-guide-to-building-llm-powered-applications-95fc8898732c)

[Getting Started with Weaviate: A Beginner’s Guide to Search with Vector Databases | by Leonie Monigatti | Towards Data Science](https://towardsdatascience.com/getting-started-with-weaviate-a-beginners-guide-to-search-with-vector-databases-14bbb9285839)

基于 LangChain 实现的检索增强生成方法

在这一部分，我们将展示如何利用 Python 结合 OpenAI 的大语言模型 (LLM)、Weaviate 的向量数据库以及 OpenAI 的嵌入模型来实现一个检索增强生成（RAG）流程。在这个过程中，我们将使用 LangChain 来进行整体编排。

如果你还不太了解 LangChain 或 Weaviate，以下两篇入门文章可能会对你有所帮助：

LangChain 入门：一篇适合初学者的指南，教你如何构建由大语言模型 (LLM) 驱动的应用程序

Weaviate 入门：向量数据库搜索的初学者指南

Prerequisites

Make sure you have installed the required Python packages:

langchain for orchestration

openai for the embedding model and LLM

weaviate-client for the vector database

\#!pip install langchain openai weaviate-client

Additionally, define your relevant environment variables in a .env file in your root directory. To obtain an OpenAI API Key, you need an OpenAI account and then「Create new secret key」under API keys.

OPENAI_API_KEY="<YOUR_OPENAI_API_KEY>"

Then, run the following command to load the relevant environment variables.

import dotenv
dotenv.load_dotenv()

准备工作

在开始之前，请确保你的系统中已安装以下 Python 包：

langchain —— 用于整体编排

openai —— 提供嵌入模型和大语言模型 (LLM)

weaviate-client —— 用于操作向量数据库

\#!pip install langchain openai weaviate-client

另外，你需要在项目的根目录下的 .env 文件中设置相关的环境变量。要获取 OpenAI 的 API 密钥，你需要注册 OpenAI 账户，并在 API 密钥页面中选择「创建新的密钥」。

OPENAI_API_KEY="<YOUR_OPENAI_API_KEY>"

完成这些设置后，运行下面的命令来加载你所设置的环境变量。

import dotenv
dotenv.load_dotenv()

Preparation

As a preparation step, you need to prepare a vector database as an external knowledge source that holds all additional information. This vector database is populated by following these steps:

Collect and load your data

Chunk your documents

Embed and store chunks

The first step is to collect and load your data — For this example, you will use President Biden's State of the Union Address from 2022 as additional context. The raw text document is available in LangChain's GitHub repository. To load the data, You can use one of LangChain's many built-in DocumentLoaders. A Document is a dictionary with text and metadata. To load text, you will use LangChain's TextLoader.

```py
import requests
from langchain.document_loaders import TextLoader

url = "https://raw.githubusercontent.com/langchain-ai/langchain/master/docs/docs/modules/state_of_the_union.txt"
res = requests.get(url)
with open("state_of_the_union.txt", "w") as f:
    f.write(res.text)

loader = TextLoader('./state_of_the_union.txt')
documents = loader.load()
```

Next, chunk your documents — Because the Document, in its original state, is too long to fit into the LLM's context window, you need to chunk it into smaller pieces. LangChain comes with many built-in text splitters for this purpose. For this simple example, you can use the CharacterTextSplitter with a chunk_size of about 500 and a chunk_overlap of 50 to preserve text continuity between the chunks.

```py
from langchain.text_splitter import CharacterTextSplitter
text_splitter = CharacterTextSplitter(chunk_size=500, chunk_overlap=50)
chunks = text_splitter.split_documents(documents)
```

Lastly, embed and store the chunks — To enable semantic search across the text chunks, you need to generate the vector embeddings for each chunk and then store them together with their embeddings. To generate the vector embeddings, you can use the OpenAI embedding model, and to store them, you can use the Weaviate vector database. By calling .from_documents() the vector database is automatically populated with the chunks.

```py
from langchain.embeddings import OpenAIEmbeddings
from langchain.vectorstores import Weaviate
import weaviate
from weaviate.embedded import EmbeddedOptions

client = weaviate.Client(
  embedded_options = EmbeddedOptions()
)

vectorstore = Weaviate.from_documents(
    client = client,    
    documents = chunks,
    embedding = OpenAIEmbeddings(),
    by_text = False
)
```

准备步骤

首先，你需要建立一个向量数据库，这个数据库作为一个外部知识源，包含了所有必要的额外信息。填充这个数据库需要遵循以下步骤：

1、收集数据并将其加载进系统。

2、将你的文档进行分块处理。

3、对分块内容进行嵌入，并存储这些块。

首先，你需要收集并加载数据 —— 在这个示例中，你将使用 2022 年拜登总统的国情咨文作为附加的背景材料。这篇原始文本可以在 LangChain 的 GitHub 仓库中找到。为了加载这些数据，你可以利用 LangChain 提供的众多 DocumentLoader 之一。Document 是一个包含文本和元数据的字典。为了加载文本，你会使用 LangChain 的 TextLoader。

其次，需要对文档进行分块 —— 由于 Document 的原始大小超出了 LLM 处理窗口的限制，因此需要将其切割成更小的片段。LangChain 提供了许多文本分割工具，对于这个简单的示例，你可以使用 CharacterTextSplitter，设置 chunk_size 大约为 500，并且设置 chunk_overlap 为 50，以确保文本块之间的连贯性。

最后一步是嵌入并存储这些文本块 —— 为了实现对文本块的语义搜索，你需要为每个块生成向量嵌入，并将它们存储起来。生成向量嵌入时，你可以使用 OpenAI 的嵌入模型；而存储它们，则可以使用 Weaviate 向量数据库。通过执行 .from_documents () 操作，就可以自动将这些块填充进向量数据库中。

Step 1: Retrieve

Once the vector database is populated, you can define it as the retriever component, which fetches the additional context based on the semantic similarity between the user query and the embedded chunks.

retriever = vectorstore.as_retriever()

Step 2: Augment

Next, to augment the prompt with the additional context, you need to prepare a prompt template. The prompt can be easily customized from a prompt template, as shown below.

```py
from langchain.prompts import ChatPromptTemplate

template = """You are an assistant for question-answering tasks. 
Use the following pieces of retrieved context to answer the question. 
If you don't know the answer, just say that you don't know. 
Use three sentences maximum and keep the answer concise.
Question: {question} 
Context: {context} 
Answer:
"""
prompt = ChatPromptTemplate.from_template(template)

print(prompt)
```

Step 3: Generate

Finally, you can build a chain for the RAG pipeline, chaining together the retriever, the prompt template and the LLM. Once the RAG chain is defined, you can invoke it.

```py
from langchain.chat_models import ChatOpenAI
from langchain.schema.runnable import RunnablePassthrough
from langchain.schema.output_parser import StrOutputParser

llm = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0)

rag_chain = (
    {"context": retriever,  "question": RunnablePassthrough()} 
    | prompt 
    | llm
    | StrOutputParser() 
)

query = "What did the president say about Justice Breyer"
rag_chain.invoke(query)
```

"The president thanked Justice Breyer for his service and acknowledged his dedication to serving the country. 
The president also mentioned that he nominated Judge Ketanji Brown Jackson as a successor to continue Justice Breyer's legacy of excellence."

You can see the resulting RAG pipeline for this specific example illustrated below:

Retrieval augmented generation (RAG) workflow from user query「What did the president say about Justice Breyer」through retrieval with a vector database, returning three text chunks, to prompt stuffing and finally generating a response. (「The president thanks Justice Breyer for his service…」)

Fig: Retrieval-Augmented Generation Workflow

第一步：检索

一旦向量数据库准备好，你就可以将它设定为检索组件，这个组件能够根据用户查询与已嵌入的文本块之间的语义相似度，来检索出额外的上下文信息。

第二步：增强

接下来，你需要准备一个提示模板，以便用额外的上下文信息来增强原始的提示。你可以根据下面显示的示例，轻松地定制这样一个提示模板。

第 3 步：生成

在 RAG (检索增强生成) 管道的构建过程中，可以通过将检索器、提示模板与大语言模型 (LLM) 相结合来形成一个序列。定义好 RAG 序列之后，就可以开始执行它。

"总统对布雷耶法官 (Justice Breyer) 的服务表示感谢，并赞扬了他对国家的贡献。"
"总统还提到，他提名了法官 Ketanji Brown Jackson 来接替布雷耶法官，以延续后者的卓越遗产。"

下面展示了这一特定例子的 RAG 管道如何工作的图解：

从用户提问「总统对布雷耶法官说了什么」开始，通过检索向量数据库并返回三段文本，接着进行提示填充，最终生成回答的检索增强生成 (RAG) 工作流程图。（总统感谢布雷耶法官的服务……）

### 03. Summary

This article covered the concept of RAG, which was presented in the paper Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks [1] from 2020. After covering some theory behind the concept, including motivation and problem solution, this article converted its implementation in Python. This article implemented a RAG pipeline using an OpenAI LLM in combination with a Weaviate vector database and an OpenAI embedding model. LangChain was used for orchestration.

本文详细介绍了 RAG，这是一种在 2020 年发表的论文面向知识密集型 NLP 任务的检索增强生成 [1] 中提出的新概念。在讲解了其背后的理论基础，包括动机和解决方案之后，本文展示了如何用 Python 实现 RAG。实现过程中，结合了 OpenAI 的大语言模型 (LLM)、Weaviate 的向量数据库以及 OpenAI 的嵌入模型，利用 LangChain 进行整体协调。

### References

[1] Lewis, P., et al. (2020). Retrieval-augmented generation for knowledge-intensive NLP tasks. Advances in Neural Information Processing Systems, 33, 9459–9474.

