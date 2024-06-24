## 20240624The-limitations-of-LLMs

[The limitations of LLMs, or why are we doing RAG? | EDB](https://www.enterprisedb.com/blog/limitations-llm-or-why-are-we-doing-rag)

Phil Eaton

June 17, 2024

This blog was co-authored by Phil Eaton, Bilge Ince, and Artjoms Iskovs.

Despite powerful capabilities with many tasks, Large Language Models (LLMs) are not know-it-alls. If you've used ChatGPT or other models, you'll have experienced how they can't reasonably answer questions about proprietary information. What's worse, it isn't just that they don't know about proprietary information, they are unaware of their own limitations and, even if they were aware, they don't have access to proprietary information. That's where options like Retrieval Augmented Generation (RAG) come in and give LLMs the ability to incorporate new and proprietary information into their answers.

尽管大语言模型（LLMs）在很多任务上表现出色，但它们并不是全知全能的。如果你使用过 ChatGPT 或其他模型，你会发现它们无法解答涉及专有信息的问题。更糟糕的是，它们不仅不了解这些专有信息，还对自身的局限性一无所知，即使知道了也无从获取专有信息。这时，检索增强生成（Retrieval Augmented Generation, RAG）就能派上用场，它能让 LLMs 在回答中加入新的和专有的信息。

### Taking a step back

An LLM is an advanced form of artificial intelligence that understands and generates human-like text. It learns from extensive written material on various topics, enabling it to answer questions, write essays, summarize information, and engage in conversation. They operate using a neural network, which is inspired by the human brain. This network consists of layers of nodes or "neurons" that process information. The connections between these neurons have "weights," which adjust as the model learns from the data it is trained on. This process enables the model to produce relevant and contextually appropriate text based on the input it receives.

Take ChatGPT for example. The models are GPT-4o, GPT-3.5 Turbo, etc. The context window is the result of tokenizing the prompt text you type into ChatGPT combined with ChatGPT's system prompt. The output is the result the model(GPT-4o, GPT-3.5 Turbo, etc.) produces. ChatGPT is only one of many applications that use LLMs, but it is helpful to use specific examples.

GPT family models, and other general-purpose models, are excellent for general inquiries. However, they fall short when the need requires asking specific questions about the company's internal data. Take ChatGPT as an example that uses the GPT-4o model; if a developer asks, "What were the key changes made in the last major release?" or "Are there any unresolved critical bugs related to the payment gateway?" the LLM won't be able to provide accurate and up-to-date answers because it lacks access to the proprietary data stored in JIRA and git. Therefore you need to get creative to address your needs.

回到基础

大语言模型是一种先进的人工智能技术，能够理解和生成类似人类的文本。它通过学习大量不同主题的书面材料，具备回答问题、撰写文章、总结信息和进行对话的能力。大语言模型运行在一个受人脑启发的神经网络上。这个网络由多层节点或「神经元」组成，每个神经元负责处理信息。神经元之间的连接有「权重」，模型通过学习训练数据来调整这些权重。这个过程使得模型可以根据输入生成相关且符合上下文的文本。

以 ChatGPT 为例。这些模型有 GPT-4o、GPT-3.5 Turbo 等。上下文窗口是指你输入的提示信息和 ChatGPT 系统提示的结合。模型（如 GPT-4o、GPT-3.5 Turbo 等）的输出即为生成的结果。ChatGPT 只是 LLMs 的众多应用之一，但具体示例更容易理解。

GPT 家族模型和其他通用模型在处理一般查询时非常出色。然而，当需要询问公司内部数据的具体问题时，它们往往显得力不从心。以使用 GPT-4o 模型的 ChatGPT 为例，如果开发者问，「上次主要版本更新的关键更改是什么？」或「是否有任何与支付网关相关的未解决的关键错误？」大语言模型将无法提供准确和最新的答案，因为它无法访问存储在 JIRA 和 git 中的专有数据。因此，我们需要通过创造性的方法来满足这些需求。

### Adapting to your domain

You could train a new model from scratch on your data. It may be a worthwhile investment if there is a specific task you expect the model to handle often. Otherwise, a general purpose model can take months of expensive hardware to train. And since it takes months to train, the new model would not "know" about any data you had added or modified in the meantime.

Another approach involves fine-tuning a smaller model for tasks that demand specialized knowledge beyond the scope of general LLMs. Fine-tuning facilitates the customization of models tailored to specific domains, tasks, or languages, yielding superior performance in these areas compared to general LLM. Also, it allows for addressing specific concerns and ensures that the model's outputs align with efforts to minimize bias.

However, fine-tuning a model requires access to high-quality data curated explicitly for the task and, more importantly, expertise in machine learning and domain-specific knowledge, as well as maintenance and scaling.

An increasingly popular option is Retrieval Augmented Generation (RAG): automatically adding relevant (proprietary) data, by concatenating text, to a user's prompt while running an LLM model.

领域适应

你可以从头开始在你的数据上训练一个新模型。如果模型需要频繁处理特定任务，这可能是值得的投资。否则，训练一个通用模型可能需要数月的昂贵硬件。而且，由于训练需要数月，新模型将不会「知道」在此期间你添加或修改的任何数据。

另一种方法是对较小的模型进行微调，以处理需要专业知识的任务，这些任务超出了通用大语言模型的能力范围。微调可以定制模型，以适应特定领域、任务或语言，使其在这些领域中表现优于通用大语言模型。此外，微调还可以解决具体问题，并确保模型的输出减少偏见。

然而，微调模型需要访问为任务专门策划的高质量数据，更重要的是，需要机器学习和领域特定知识方面的专业知识，以及维护和扩展能力。

一种越来越流行的选择是检索增强生成（RAG)：通过在运行大语言模型时将相关（专有）数据自动添加到用户的提示中，从而增强生成。

### The context window

There are two challenges. First, LLM context windows can fit limited data. Second, you pay for the size of the context window. (Even if you run an LLM like llama3 on your own hardware, you still pay for context window size in terms of the amount of RAM you need.)

Context windows typically support a maximum of between 4096 to 1M tokens. For a text prompt, a token is the same old NLP term you knew from decades ago, though different models tokenize input differently. For example, the quote "Diseased Nature often times breaks forth in strange eruptions." has 8 words and a period. But GPT's tokenizer produces 11 tokens.

So we rely on the base intelligence provided by a model. And we paste additional text as a prefix to a user prompt to provide additional proprietary context.

The challenge then is what text makes it to the prompt? There is not infinite space in the context window.

Processing text in AI systems like ChatGPT incurs costs that directly correlate with the input size. Larger texts demand increased memory, processing power, and time for handling, inevitably leading to higher operational expenses.

上下文窗口

有两个挑战。首先，大语言模型（LLM）的上下文窗口容量有限。其次，你需要为上下文窗口的大小付费。（即使你在自己的硬件上运行像 llama3 这样的 LLM，你仍然需要为上下文窗口的大小支付 RAM 的费用。）

上下文窗口通常支持最多 4096 到 1M 个 Token。在文本提示中，Token 是几十年前就被广泛使用的 NLP 术语，尽管不同模型的 Token 化方式有所不同。例如，引用 "Diseased Nature often times breaks forth in strange eruptions." 这句话有 8 个单词和一个句号。但 GPT 的 Token 化器会产生 11 个 Token。

因此，我们依赖模型的基础智能。我们会将额外的文本作为前缀添加到用户提示中，以提供更多的专有上下文。

问题在于哪些文本可以进入提示？上下文窗口的空间是有限的。

在像 ChatGPT 这样的 AI 系统中处理文本会产生与输入大小直接相关的成本。更长的文本需要更多的内存、处理能力和处理时间，最终导致更高的运营费用。

### Retrieving relevant information

With RAG we split answering a user prompt into two stages. First, we decide on the most relevant, limited proprietary information for the user's prompt. Second, we concatenate the most relevant information with the user's initial prompt and feed it to a generative model to receive a response in return.

The first step of RAG is Retrieval. The vector search is one option for retrieving relevant proprietary documents for RAG to operate. It aims to find semantically similar vectors by calculating the proximity of different vectors to each other, so a search for "food" might pull up relevant proprietary documents about "bananas". But any search method could work, including Lucene-style full-text search. The ideal search algorithm for RAG might depend on your workload, but the popular choice today is vector similarity search.

Vector similarity search requires both a database for storing, indexing, and searching vectors; and it also requires a method for transforming documents into vectors (called embeddings) that can be put into the database. LLMs themselves can be used to convert text to embeddings to be stored in a vector database. In this scenario you use the LLM only for generating embeddings and not for going all the way to generate text. Furthermore, the LLM you use to generate embeddings for the Retrieval part of a RAG application does not need to be the same LLM you use in the text generation stage of your RAG application.

For Postgres users, the pgvector extension serves as the vector database. We must set up a process to generate embeddings from our documents and store them with pgvector. Then, when given a user's prompt, we can use pgvector's vector similarity search to retrieve the most relevant document text and prepend that text to the user's prompt.

You can build RAG applications on top of LLMs with entirely open-source components and host them yourself. Or you can use a platform like EDB Postgres AI to manage the Postgres and pgvector parts, and to automatically generate (and update) embeddings on chosen columns of existing tables.

检索相关信息

使用 RAG（Retrieval-Augmented Generation)，我们将回答用户提示分为两个阶段。首先，我们确定对用户提示最相关的有限专有信息。其次，我们将这些最相关的信息与用户的初始提示结合，并将其输入生成模型以获得响应。

RAG 的第一步是检索。向量搜索是检索 RAG 所需相关专有文档的一种方法。它通过计算不同向量之间的接近程度来找到语义相似的向量。例如，搜索 "food" 可能会找到关于 "bananas" 的相关专有文档。但任何搜索方法都可以使用，包括 Lucene 风格的全文搜索。RAG 的理想搜索算法可能取决于你的工作负载，但目前流行的选择是向量相似性搜索。

矢量相似性搜索需要一个数据库来存储、索引和搜索矢量，同时还需要一种将文档转换为矢量（嵌入，embeddings）的方法。这些嵌入可以被存储在数据库中。大语言模型（LLMs）可以将文本转换为嵌入，存储在矢量数据库中。在这种情况下，我们只用 LLM 生成嵌入，而不是生成文本。此外，用于生成 RAG 应用程序中检索部分嵌入的 LLM，不必和生成文本阶段用的 LLM 相同。

对于 Postgres 用户，可以使用 pgvector 扩展作为矢量数据库。我们需要设置一个流程，将文档生成的嵌入存储到 pgvector 中。然后，当用户输入提示时，我们可以用 pgvector 的矢量相似性搜索，检索最相关的文档文本，并将其加到用户的提示前面。

你可以基于 LLMs 构建完全开源的 RAG 应用程序，并自行托管。也可以使用 EDB Postgres AI 平台，管理 Postgres 和 pgvector 部分，并自动生成和更新现有表格选定列的嵌入。

More from the EDB blog on the topic:

[RAG is not the same as vector similarity search](https://www.enterprisedb.com/blog/rag-not-same-vector-similarity-search)

[RAG app with Postgres and pgvector | EDB](https://www.enterprisedb.com/blog/rag-app-postgres-and-pgvector)

[PGVector as Embedding Store in PrivateGPT | EDB](https://www.enterprisedb.com/blog/pgvector-embedding-store-privategpt)
