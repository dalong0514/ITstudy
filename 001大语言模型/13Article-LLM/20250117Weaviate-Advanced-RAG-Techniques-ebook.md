## 20250117Weaviate-Advanced-RAG-Techniques-ebook

Advanced RAG Techniques

A guide on different techniques to improve the performance of your Retrieval-Augmented Generation applications.

Retrieval-augmented generation (RAG) provides generative large language models (LLMs) with information from an external knowledge source to help reduce hallucinations and increase the factual accuracy of the generated responses.

检索增强生成（RAG）通过引入外部知识源的信息，来辅助生成式大模型（LLM），以此减少其产生不实信息，并提高生成内容的真实性。

A naive RAG pipeline consists of four components: an embedding model, a vector database, a prompt template, and a generative LLM. At inference time, it embeds the user query to retrieve relevant document chunks of information from the vector database, which it stuffs into the LLM's prompt to generate an answer.

一个简单的检索增强生成（RAG）流程包含四个组件：一个嵌入模型、一个向量数据库、一个提示模板和一个生成式大语言模型（LLM）。在推理时，它会将用户查询转换为嵌入向量，以从向量数据库中检索相关的文档片段，然后将其加入到大语言模型的提示中，以生成答案。

While this naive approach is straightforward, it has many limitations and can often lead to low-quality responses.

虽然这种简单的方法很直接，但它有很多局限性，并且经常会导致低质量的响应。

This e-book discusses various advanced techniques you can apply to improve the performance of your RAG system. These techniques can be applied at various stages in the RAG pipeline, as shown below:

这本电子书讨论了各种你可以用来提高你的检索增强生成（RAG）系统性能的先进技术。这些技术可以在 RAG 流程的各个阶段应用，如下图所示：

Indexing
Indexing Optimization Techniques  
Data Pre-processing  
Chunking Strategies  

索引
索引优化技巧
数据预处理
分块策略

Pre-Retrieval
Pre-retrieval Optimization Techniques  
Query Transformation  
Query Decomposition  
Query Routing  

预检索（在实际检索前进行的优化)
预检索优化技巧
查询转换
查询分解
查询路由

Retrieval
Retrieval Optimization Strategies  
Metadata Filtering  
Excluding Vector Search Outliers  
Hybrid search  
Embedding model fine-tuning  

检索
检索优化方法
元数据过滤
去除向量搜索中的异常值
混合搜索
微调嵌入模型

Post-Retrieval
Post-retrieval Optimization Techniques  
Re-ranking  
Context Post-processing  
Prompt Engineering  
LLM Fine-tuning  

检索后检索
后优化技巧
重排序
上下文信息处理
提示工程
大语言模型微调

### Indexing

索引

#### Indexing Optimization Techniques

索引优化技巧

Index optimization techniques enhance retrieval accuracy by structuring external data in more organized, searchable ways. These techniques can be applied to both data pre-processing and chunking stages in the RAG pipeline, ensuring that relevant information is effectively retrieved.

索引优化技巧通过以更有组织、可搜索的方式组织外部数据来提高检索准确性。这些技巧可以应用于 RAG（Retrieval-Augmented Generation）流程中的数据预处理和分块处理阶段，确保有效地检索相关信息。

#### Data Pre-Processing

数据预处理

Data pre-processing is fundamental to the success of any RAG system, as the quality of your processed data directly impacts the overall performance. By thoughtfully transforming raw data into a structured format suitable for LLMs, you can significantly enhance your system's effectiveness before considering more complex optimizations.

数据预处理对于任何 RAG 系统的成功都至关重要，因为处理后数据的质量直接影响着系统的整体性能。通过将原始数据转换为适合大语言模型（LLM/Large Language Model）使用的结构化格式，可以在进行更复杂的优化之前，显著提升系统的效率。

While there are several common pre-processing techniques available, the optimal approach and sequence should be tailored to your specific use case and requirements.

尽管存在一些常见的预处理技术，但最佳的方法和步骤应该根据您的具体应用场景和需求进行调整。

The process usually begins with data acquisition and integration, where diverse document types from multiple sources are collected and consolidated into a 'knowledge base'.

这个流程通常始于数据采集和整合，即将来自多个来源的多种类型文档收集并汇总到一个「知识库」中。

Data Extraction and Data Parsing

数据提取和解析

Data extraction and parsing take place over the raw data so that it is accurately processed for downstream tasks. For text-based formats like Markdown, Word documents, and plain text, extraction techniques focus on preserving structure while capturing relevant content.

针对原始数据进行，目的是为了后续任务能够准确地处理这些数据。对于诸如 Markdown、Word 文档和纯文本等文本格式，提取技术在获取相关内容的同时，会着重保持数据的结构。

Scanned documents, images, and PDFs containing image-based text/tables require OCR (Optical Character Recognition) technology to convert into an 'LLM-ready' format. However, recent advancements in multimodal retrieval models, such as ColPaii and ColQwen, have revolutionized this process. These models can directly embed images of documents, potentially making traditional OCR obsolete.

扫描的文档、图片以及包含图像化文字或表格的 PDF 文件，通常需要使用光学字符识别（OCR）技术，才能将其转换为大语言模型（LLM）可以直接处理的格式。然而，最近在多模态检索模型（能够同时处理多种类型数据，例如文本和图像的模型）方面的进步，例如 ColPaii 和 ColQwen，已经彻底改变了这一过程。这些模型可以直接将文档的图像进行编码，这使得传统的 OCR 技术有被淘汰的可能。

Web content often involves HTML parsing, utilizing DOM traversal to extract structured data, while spreadsheets demand specialized parsing to handle cell relationships. Metadata extraction is also crucial across file types, pulling key details like author, timestamps, and other document properties (see Metadata Filtering).

网页内容通常涉及 HTML 解析，通过 DOM 遍历来提取结构化数据。电子表格则需要专门的解析来处理单元格之间的关系。元数据提取在各种文件类型中也至关重要，元数据提取会提取诸如作者、时间戳和其他文档属性等关键细节（see Metadata Filtering）。

Data Cleaning

数据清理

Data cleaning and noise reduction involves removing irrelevant information (such as headers, footers, or boilerplate text), correcting inconsistencies, and handling missing values while maintaining the extracted data's structural integrity.

数据清理与降噪包括删除不相关的信息，如页眉、页脚或样板文本，纠正数据中的不一致，并在保持提取数据结构完整性的前提下，处理缺失值。

Data Transformation

数据转换

This involves converting all extracted and processed content into a standardized schema, regardless of the original file type. It's at this stage that document partitioning (not to be confused with chunking) occurs, separating document content into logical units or elements (e.g., paragraphs, sections, tables).

此步骤的目的是将所有提取并处理过的内容，无论其原始文件类型如何，都转换为统一的标准格式。在这个阶段，还会进行文档分割（Document Partitioning），请注意这与分块（Chunking）不同，它是将文档内容拆分成逻辑单元或元素，例如段落、章节和表格等。

#### Chunking Strategies

分块策略

Chunking divides large documents into smaller, semantically meaningful segments. This process optimizes retrieval by balancing context preservation with manageable chunk sizes. Various common techniques exist for effective chunking in RAG, some of which are discussed below:

分块是指将大型文档拆分成更小、且在语义上具有意义的片段。这个过程旨在通过兼顾上下文信息的保留和可管理的分块大小，从而优化检索效果。在 RAG（Retrieval-Augmented Generation，检索增强生成）中，有多种常用的高效分块技术，下面我们将介绍其中一部分。

1 Fixed-size chunking is a simple technique that splits text into chunks of a predetermined size, regardless of content structure. While it's cost-effective, it lacks contextual awareness. This can be improved by using overlapping chunks, allowing adjacent chunks to share some content.

固定大小分块（Fixed-size chunking）是一种简单的方法，它将文本按照预先设定的固定大小分割成块，而不考虑文本的内容结构。这种方法虽然在成本上更经济，但它不能理解上下文语境。为了改进这一点，可以使用重叠的分块方法，让相邻的文本块可以共享部分内容。

2 Recursive chunking offers more flexibility by initially splitting text using a primary separator (like paragraphs) and then applying secondary separators (like sentences) if chunks are still too large. This technique respects the document's structure and adapts well to various use cases.

递归分块提供更高的灵活性，它首先使用主要分隔符（例如段落）分割文本，如果分割后的文本块仍然太大，则会使用次要分隔符（例如句子）进行进一步分割。这种方法能够保持文档的结构，并且可以很好地适应不同的应用场景。

3 Document-based chunking creates chunks based on the natural divisions within a document, such as headings or sections. It's particularly effective for structured data like HTML, Markdown, or code files but less useful when the data lacks clear structural elements.

按照文档结构分块（Document-based chunking）是指根据文档固有的结构进行划分，例如标题或章节。这种方法对 HTML、Markdown 或代码文件等结构化数据非常有效，但如果数据本身缺乏清晰的结构，则效果不佳。

4 Semantic chunking divides text into meaningful units, which are then vectorized. These units are then combined into chunks based on the cosine distance between their embeddings, with a new chunk formed whenever a significant content shift is detected. This method balances semantic coherence with chunk size.

语义分块（Semantic chunking）将文本分割成有意义的单元，然后将这些单元转换成向量表示。之后，根据这些向量表示之间的余弦距离，将这些单元组合成块；当检测到内容出现明显变化时，就会形成新的块。这种方法在保持语义连贯性的同时，也兼顾了块的大小。

5 LLM-based chunking is an advanced technique that uses an LLM to generate chunks by processing text and creating semantically isolated sentences or propositions. While highly accurate, it's also the most computationally demanding approach.

基于大语言模型（LLM）的分块是一种先进技术，它利用大语言模型处理文本，并生成在语义上相互独立的句子或命题，从而形成文本块。这种方法虽然精度很高，但也是计算量最大的。

Each of the discussed techniques has its strengths, and the choice depends on the RAG system's specific requirements and the nature of the documents being processed. New approaches continue to emerge, such as late chunking, which processes text through long-context embedding models before splitting it into chunks to better preserve document-wide context.

前面讨论的每种技术都有其优点，具体选择哪一种取决于 RAG 系统（Retrieval Augmented Generation）的特定需求以及所处理文档的特性。新的方法也在不断出现，例如后期分块（late chunking），这种方法会先利用长上下文嵌入模型处理文本，然后再将其分割成块，以便更好地保留文档的整体上下文信息。

### Pre-Retrieval

预检索

#### Pre-retrieval Optimization Techniques

预检索优化方法

Index optimization techniques enhance retrieval accuracy by structuring external data in more organized, searchable ways. These techniques can be applied to both data pre-processing and chunking stages in the RAG pipeline, ensuring that relevant information is effectively retrieved.

索引优化方法通过以更有组织、更易于搜索的方式构建外部数据，从而提高检索的准确性。这些方法可以应用于 RAG（Retrieval-Augmented Generation，检索增强生成）管道中的数据预处理和分块处理阶段，确保能够有效地检索到相关信息。

#### Query Transformation

查询转换

Using the user query directly as the search query for retrieval can lead to poor search results. That's why turning the raw user query into an optimized search query is essential. Query transformation refines and expands unclear, complex, or ambiguous user queries to improve the quality of search results.

如果直接将用户输入的查询语句作为检索的搜索条件，往往会导致搜索结果不佳。因此，将用户原始查询转换为优化的搜索查询至关重要。查询转换的作用在于改进和扩展那些不清晰、复杂或含义模糊的用户查询，从而提高搜索结果的质量。

Query Rewriting involves reformulating the original user query to make it more suitable for retrieval. This is particularly useful in scenarios where user queries are not optimally phrased or expressed differently. This can be achieved by using an LLM to rephrase the original user query or employing specialized smaller language models trained specifically for this task.

查询改写指的是对用户原始查询进行重新构建，使其更适合信息检索。当用户查询的表达不够准确或不符合检索系统的习惯时，这种技术尤为有效。实现查询改写的方法包括使用大语言模型（LLM）对原始查询进行改写，或者采用专门为此任务训练的更小型的语言模型。

This approach is called 'Rewrite-Retrieve-Read' instead of the traditional 'Retrieve-then-Read' paradigm.

这种方法被称为「重写-检索-读取」，它不同于传统的「检索-然后-读取」模式。在传统模式中，系统先检索信息，然后再阅读；而「重写-检索-读取」模式则是在检索之前，先对用户的查询进行重写。

Query Expansion focuses on broadening the original query to capture more relevant information. This involves using an LLM to generate multiple similar queries based on the user's initial input. These expanded queries are then used in the retrieval process, increasing both the number and relevance of retrieved documents.

查询扩展的核心在于，它会扩展原始查询的范围，以便找到更多相关的信息。具体来说，就是利用大语言模型（LLM）根据用户最初的提问，生成多个相似的查询。这些扩展后的查询会用于检索过程，从而提高检索到的文档数量和相关性。

Note: Due to the increased quantity of retrieved documents, a reranking step is often necessary to prioritize the most relevant results (see Re-ranking).

注意：因为检索到的文档数量增多，通常需要一个重排序步骤，以便优先显示最相关的结果（详见重排序部分）。

#### Query Decomposition

查询拆解

Query decomposition is a technique that breaks down complex queries into simpler sub-queries. This is useful for answering multifaceted questions requiring diverse information sources, leading to more precise and relevant search results.

查询分解是一种将复杂查询拆解为更简单的子查询的技术。这种方法对于解答需要整合多种信息来源的复杂问题非常有效，能够提供更精准、更相关的搜索结果。

The process typically involves two main stages: decomposing the original query into smaller, focused sub-queries using an LLM and then processing these sub-queries to retrieve relevant information.

这个信息检索过程通常包含两个主要步骤：首先，利用大语言模型（LLM）将用户提出的原始问题拆解为若干个更小、目标更明确的子问题；然后，针对这些子问题进行处理，以获取相关的答案。

For example, the complex query "Why am I always so tired even though I eat healthy? Should I be doing something different with my diet or maybe try some diet trends?" can be decomposed into the following three simpler sub-queries:

例如，复杂的查询「为什么我明明吃得很健康，却总是感觉很疲惫？我是否应该调整饮食，或者尝试一些流行的饮食方式？」可以分解为以下三个更简单的子查询：

1 What are the common dietary factors that can cause fatigue?

哪些常见的饮食因素会导致疲劳？

2 What are some popular diet trends and their effects on energy levels?

有哪些流行的饮食趋势，它们又会如何影响能量水平？

3 How can I determine if my diet is balanced and supports my energy needs?

我怎么知道我的饮食是否均衡，并且能满足我的能量需求呢？

Each sub-query targets a specific aspect, enabling the retriever to find relevant documents or chunks. Sub-queries can also be processed in parallel to improve efficiency. Additional techniques like keyword extraction and metadata filter extraction can help identify both key search terms and structured filtering criteria, enabling more precise searches. After retrieval, the system aggregates and synthesizes results from all sub-queries to generate a comprehensive answer to the original complex query.

每个子查询都专注于一个特定角度，这使得检索器能够找到相关的文档或数据片段。为了提高效率，这些子查询还可以并行处理。诸如关键词提取和元数据筛选等额外技术有助于识别关键搜索词和结构化筛选条件，从而实现更精准的搜索。检索完成后，系统会将所有子查询的结果进行汇总和综合，最终生成针对原始复杂查询的全面解答。

#### Query Routing

查询路由

Query routing is a technique that directs queries to specific pipelines based on their content and intent, enabling a RAG system to handle diverse scenarios effectively. It works by analyzing each query and choosing the best retrieval method or processing pipeline to provide an accurate response. This often requires implementing multi-index strategies, where different types of information are organized into separate, specialized indexes optimized.

查询路由是一种根据查询的内容和意图将查询定向到特定管道的技术，从而使 RAG 系统能有效处理各种场景。其工作原理是分析每个查询，选择最佳检索方法或处理管道，以提供准确的响应。这通常需要实施多索引策略，将不同类型的信息组织到单独的、优化的专用索引中。

The process can include agentic elements, where AI agents decide how to handle each query. These agents evaluate factors such as query complexity and domain to determine the optimal approach. For example, fact-based questions may be routed to one pipeline, while those requiring summarization or interpretation are sent to another.

这个过程可以包含智能体（agentic）的元素，其中 AI 智能体决定如何处理每个查询。这些智能体会评估诸如查询的复杂程度和所属领域等因素，以确定最佳的处理方式。例如，基于事实的问题可能会被发送到一个处理流程，而需要总结或解释的问题则会被发送到另一个处理流程。

Agentic RAG functions like a network of specialized agents, each with different expertise. It can choose from various data stores, retrieval strategies (keyword-based, semantic, or hybrid), query transformations (for poorly structured queries), and specialized tools or APIs, such as text-to-SQL converters or even web search capabilities.

AI 智能体检索增强生成（Agentic RAG）的工作方式类似于一个由多个专业 AI 智能体组成的网络，每个智能体都有不同的专长。它可以选择不同的数据存储，检索策略（包括基于关键词、语义或混合的检索方式），针对结构不佳的查询进行查询转换，以及使用专门的工具或 API，例如将文本转换为 SQL 的工具，甚至可以进行网络搜索。

### Retrieval

信息检索

#### Retrieval Optimization Strategies

信息检索优化方法

Retrieval optimization strategies aim to improve retrieval results by directly manipulating the way in which external data is retrieved in relation to the user query. This can involve refining the search query, such as using metadata to filter candidates or excluding outliers, or even involve fine-tuning an embedding model on external data to improve the quality of the underlying embeddings themselves.

检索优化策略致力于通过直接调整外部数据与用户查询的关联检索方式，来提升检索结果的质量。这包括改进搜索查询，例如利用元数据筛选候选结果或排除异常值；甚至还包括在外部数据上微调嵌入模型，以此来提高嵌入向量本身的质量。

#### Metadata Filtering

元数据过滤

Metadata is the additional information attached to each document or chunk in a vector database, providing valuable context to enhance retrieval. This supplementary data can include timestamps, categories, author info, source references, languages, file types, etc.

元数据是指附加在向量数据库中每个文档或数据块上的额外信息，它提供了有价值的背景信息，可以帮助我们更好地进行检索。这些额外的数据可以包括时间戳、类别、作者信息、来源参考、语言和文件类型等等。

When retrieving content from a vector database, metadata helps refine results by filtering out irrelevant objects, even when they are semantically similar to the query. This narrows the search scope and improves the relevance of the retrieved information.

当从向量数据库检索内容时，元数据通过过滤掉不相关的对象来帮助提高结果的准确性，即使这些对象在含义上与查询非常接近。这缩小搜索范围，并提高检索结果的相关性。

Another benefit of using metadata is time-awareness. By incorporating timestamps as metadata, the system can prioritize recent information, ensuring the retrieved knowledge remains current and relevant. This is particularly useful in domains where information freshness is critical.

使用元数据的另一个好处是能够感知时间。通过在元数据中加入时间戳，系统可以优先处理最新的信息，从而确保检索到的知识具有时效性和相关性。这在那些对信息新鲜度要求极高的领域尤其重要。

To get the most out of metadata filtering, it's important to plan carefully and choose metadata that improves search without adding unnecessary complexity.

为了充分发挥元数据过滤的作用，仔细规划并选择有助于改进搜索的元数据非常重要，同时避免引入不必要的复杂性。

#### Excluding Vector Search Outliers

过滤向量搜索中的异常结果

The most straightforward approach to defining the number of returned results is explicitly setting a value for the top_k (top_k) results. If you set top_k to 5, you’ll get the five closest vectors, regardless of their relevance. While easy to implement, this can include poor matches just because they made the cutoff.

要定义返回结果的数量，最直接的方法是为 top_k（top_k）结果明确设定一个数值。如果将 top_k 设置为 5，那么无论相关性如何，你都会得到五个最接近的向量。虽然这种方法容易实现，但它可能会包含一些匹配度不佳的结果，仅仅因为它们刚好满足了设定的数量要求。

Here are two techniques to manage the number of search results implicitly that can help with excluding outliers:

这里有两种技术可以隐式地控制搜索结果的数量，它们有助于排除异常值：

Distance thresholding adds a quality check by setting a maximum allowed distance between vectors. Any result with a distance score above this threshold gets filtered out, even if it would have made the top_k cutoff. This helps remove the obvious bad matches but requires careful threshold adjustment.

距离阈值法通过设定向量间允许的最大距离来进行质量检查。任何距离得分超过这个阈值的结果都会被过滤掉，即使这些结果原本在排序后会进入前 k 个（top_k）。这有助于去除那些明显不匹配的结果，但是需要仔细调整阈值大小。

Autocut is more dynamic - it looks at how the result distances are clustered. Instead of using fixed limits, it groups results based on their relative distances from your query vector. When there’s a big jump in distance scores between groups, Autocut can cut off the results at that jump. This catches outliers that might slip through top_k or basic distance thresholds.

Autocut 方法更加灵活，它会分析结果的距离是如何分布的。它不采用固定的限制，而是根据结果与查询向量的相对距离进行分组。当不同组之间的距离得分出现显著的跳跃时，Autocut 会在该跳跃点处截断结果。这样可以捕获那些可能被 top_k 或基本距离阈值遗漏的异常值。

#### Hybrid Search

混合搜索

Hybrid search combines the strengths of vector-based semantic search with traditional keyword-based methods. This technique aims to improve the relevance and accuracy of retrieved information in RAG systems.

混合搜索融合了基于向量的语义搜索的优势与传统关键词搜索方法的优点。这种技术旨在提升 RAG（Retrieval-Augmented Generation）系统中检索信息的关联性和准确度。

The key to hybrid search lies in the ‘alpha’ (α) parameter, which controls the balance between semantic and keyword-based search methods:

混合搜索的关键在于 ‘alpha'（α）参数，它决定了语义搜索和关键词搜索之间的平衡：

- α = 1: Pure semantic search
- α = 0: Pure keyword-based search
- 0 < α < 1: Weighted combination of both methods

- α = 1：纯语义搜索
- α = 0：纯关键词搜索
- 0 < α < 1：语义搜索和关键词搜索的加权组合

This approach is particularly beneficial when you need both contextual understanding and exact keyword matching.

这种方法特别有用，当既需要理解上下文，又需要精确匹配关键词时。

Consider a technical support knowledge base for a software company. A user might submit a query like “Excel formula not calculating correctly after update”. In this scenario, semantic search helps understand the context of the problem, potentially retrieving articles about formula errors, calculation issues, or software update impacts. Meanwhile, keyword search ensures that documents containing specific terms like “Excel” and “formula” are not overlooked.

举个例子，一个软件公司的技术支持知识库。用户可能会提交这样的问题：「更新后 Excel 公式计算不正确」。在这种情况下，语义搜索可以帮助理解问题的背景，找到关于公式错误、计算问题或者软件更新影响的文章。与此同时，关键词搜索可以确保包含「Excel」和「公式」等特定词汇的文档不会被遗漏。

Therefore, while implementing hybrid search, it’s crucial to adjust the alpha parameter based on your specific use case to optimize the performance.

因此，在使用混合搜索时，根据您的具体应用场景调整 alpha 参数以达到最佳性能至关重要。

#### Embedding Model Fine-Tuning

嵌入模型微调（Embedding Model Fine-Tuning)

Off-the-shelf embedding models are usually trained on large general datasets to embed a wide range of data inputs. However, embedding models can fail to capture the context and nuances of smaller, domain-specific datasets.

市面上常见的嵌入模型通常是在大型通用数据集上训练的，目的是为了处理各种各样的数据输入。然而，这些嵌入模型在面对较小的、特定领域的数据集时，可能无法准确捕捉到其中的上下文信息和细微之处。

Fine-tuning embedding models on custom datasets can significantly improve the quality of embeddings, subsequently improving performance on downstream tasks like RAG. Fine-tuning improves embeddings to better capture the dataset's meaning and context, leading to more accurate and relevant retrievals in RAG applications.

对嵌入模型进行微调可以显著提高嵌入质量，从而提高下游任务（如 RAG，Retrieval-Augmented Generation，检索增强生成）的性能。微调改进了嵌入，使其更好地捕获数据集的含义和上下文，从而在 RAG 应用中实现更准确和相关的检索。

The more niche your dataset is, the more it can benefit from embedding model fine-tuning. Datasets with specialized vocabularies, like medical or legal datasets, are ideal for embedding model fine-tuning, which helps extend out-of-domain vocabularies and enhance the accuracy and relevance of information retrieval and generation in RAG pipelines.

数据集的专业性越强，就越能从嵌入模型微调（embedding model fine-tuning）中获益。具有专业词汇的数据集，例如医疗或法律领域的数据集，非常适合进行嵌入模型微调，这有助于扩展超出领域范围的词汇，并提高 RAG 流程（RAG pipelines）中信息检索和生成的准确性和相关性。

To fine-tune an existing embedding model you first need to select a base model that you would like to improve. Next, you begin the fine-tuning process by providing the model with your domain-specific data. During this process, the loss function adjusts the model's embeddings so that semantically similar items are placed closer together in the embedding space. To evaluate a fine-tuned embedding model, you can use a validation set of curated query-answer pairs to assess the quality of retrieval in your RAG pipeline. Now, the model is ready to generate more accurate and representative embeddings for your specific dataset.

要微调一个现有的嵌入模型，首先需要选择一个想要改进的基础模型。接下来，使用者需要提供特定领域的数据，以开始微调过程。在此过程中，损失函数会调整模型的嵌入，使得语义上相似的项目在嵌入空间中距离更近。为了评估微调后的嵌入模型，可以使用一组精心整理的查询-答案对作为验证集，来评估 RAG（Retrieval-Augmented Generation）管道的检索质量。现在，微调后的模型就可以为特定数据集生成更准确且更具代表性的嵌入了。

Pre-trained embedding model
Clusters semantically similar sentences together.

经过预训练的嵌入模型能够将含义相近的句子归为一类。

Fine-tuned embedding model
Distinguishes between positive, mixed, and negative reviews. 

经过微调的嵌入模型区分正面、中性和负面评论。

### Post-Retrieval

检索后处理

#### Post-Retrieval Optimization Techniques

检索结果的优化技巧

Post-retrieval optimization techniques aim to enhance the quality of generated responses, meaning that their work begins after the retrieval process has been completed. This diverse group of techniques includes using models to re-rank retrieved results, enhancing or compressing the retrieved context, prompt engineering, and fine-tuning the generative LLM on external data.

检索后优化技术致力于提升生成回复的质量，也就是说，它们的工作是在检索过程结束后才开始的。这类技术包括使用模型对检索结果进行重新排序、增强或压缩检索到的上下文信息、提示工程（Prompt engineering）以及在外部数据上对生成式大语言模型（Large Language Model，LLM）进行微调。

#### Re-Ranking

重排序

One proven method to improve the performance of your information retrieval system is to leverage a retrieve-and-rerank pipeline. A retrieve-and-rerank pipeline combines the speed of vector search with the contextual richness of a re-ranking model.

一种被验证有效的提升信息检索系统性能的方法是采用「检索-重排序」流程。这种流程结合了向量搜索的速度优势以及重排序模型所提供的丰富的上下文信息。

In vector search, the query and documents are processed separately. First, the documents are pre-indexed. Then, at query time, the query is processed, and the documents closest in vector space are retrieved. While vector search is a fast method to retrieve candidates, it can miss contextual nuances.

在向量搜索中，查询和文档的处理是分开进行的。首先，文档会被预先建立索引。然后，在进行查询时，系统会处理查询语句，并检索出在向量空间中距离最近的文档。尽管向量搜索是一种快速检索候选结果的方法，但它可能会遗漏上下文中的细微差别。

This is where re-ranking models come into play. Because re-ranking models process the query and the documents together at query time, they can capture more contextual nuances. However, they are usually complex and resource-intensive and thus not suitable for first-stage retrieval like vector search.

这时就需要用到重排序模型了。重排序模型在查询时同时处理查询和文档，因此可以更好地理解上下文的细微之处。但其通常较为复杂且对资源要求较高，因此不太适用于像向量搜索这样的第一阶段检索。

By combining vector search with re-ranking models, you can quickly cast a wide net of potential candidates and then re-order them to improve the quality of relevant context in your prompt.

通过结合向量搜索和重排序模型，你可以快速筛选出大量可能的候选结果，然后对这些结果进行重新排序，从而提高你的提示中相关上下文的质量。

Note that when using a re-ranking model, you should over-retrieve chunks to filter out less relevant ones later.

请注意，当使用重排序模型时，你应该扩大检索范围，以便稍后过滤掉相关性较低的信息片段。

#### Context Post-Processing

上下文后处理

After retrieval, it can be beneficial to post-process the retrieved context for generation. For example, if the retrieved context might benefit from additional information you can enhance it with metadata. On the other hand, if it contains redundant data, you can compress it.

在检索之后，对检索到的上下文进行后处理可能有助于生成。例如，如果检索到的上下文需要补充信息，可以使用元数据来增强它。另一方面，如果检索到的上下文中包含冗余数据，可以对其进行压缩。

Context Enhancement with Metadata

利用元数据增强上下文

One post-processing technique is to use metadata to enhance the retrieved context with additional information to improve generation accuracy. While you can simply add additional information from the metadata, such as timestamps, document names, etc., you can also apply more creative techniques.

一种后处理技术是利用元数据来增强检索到的上下文，以此通过补充额外信息来提高生成内容的准确性。你既可以直接从元数据中添加额外信息，比如时间戳、文档名称等，也可以采用更具创造性的方法。

Context enhancement is particularly useful when data needs to be pre-processed into smaller chunk sizes to achieve better retrieval precision that doesn’t contain enough contextual information to generate high-quality responses. In this case, you can apply a technique called “Sentence window retrieval”. This technique chunks the initial document into smaller pieces (usually single sentences) but stores a larger context window in its metadata. At retrieval time, the smaller chunks help improve retrieval precision. After retrieval, the retrieved smaller chunks are replaced with the larger context window to improve generation quality.

当需要将数据预处理成较小的数据块大小，以实现更高的检索精度，但这些较小的数据块又缺乏足够的上下文信息来生成高质量的响应时，增强上下文信息就显得尤为重要。在这种情况下，可以使用一种名为「句子窗口检索」（Sentence window retrieval）的技术。该技术将原始文档分割成更小的片段（通常是单个句子），并在其元数据中存储更大的上下文窗口。检索时，这些较小的片段有助于提高检索的准确性。检索完成后，再将检索到的较小片段替换为较大的上下文窗口，以提升生成质量。

Context Compression

上下文压缩

RAG systems rely on diverse knowledge sources to retrieve relevant information. However, this often results in the retrieval of irrelevant or redundant data, which can lead to suboptimal responses and costly LLM calls (more tokens).

检索增强生成（RAG systems）系统依赖于各种不同的知识来源来获取相关信息。但是，这种方式常常会导致检索到不相关或重复的数据，从而使得最终的回复效果不佳，并且增加大语言模型（LLM）的调用成本（消耗更多 Token）。

Context compression effectively addresses this challenge by extracting only the most meaningful information from the retrieved data. This process begins with a base retriever that retrieves documents/chunks related to the query. These documents/chunks are then passed through a document compressor that shortens them and eliminates irrelevant content, ensuring that valuable data is not lost in a sea of extraneous information.

内容压缩通过仅从检索到的数据中提取最有意义的信息，有效地解决了这一难题。该过程首先由一个基础检索器执行，它负责检索与查询相关的文档或数据块。随后，这些文档或数据块会传递给一个文档压缩器，后者会缩短它们并消除不相关的内容，从而确保有价值的信息不被无关信息淹没。

Contextual compression reduces data volume, lowering retrieval and operational costs. Current research focuses on two main approaches: embedding-based and lexical-based compression, both of which aim to retain essential information while easing computational demands on RAG systems.

针对上下文的压缩减少了数据量，从而降低了检索和运营成本。目前的研究主要集中在两种方法：基于嵌入的压缩（embedding-based compression）和基于词汇的压缩（lexical-based compression）。这两种方法都旨在保留关键信息，同时减轻 RAG（Retrieval-Augmented Generation）系统上的计算负担。

#### Prompt Engineering

The generated outputs of LLMs are greatly influenced by the quality, tone, length, and structure of their corresponding prompts. Prompt engineering is the practice of optimizing LLM prompts to improve the quality and accuracy of generated output. Often one of the lowest-hanging fruits when it comes to techniques for improving RAG systems, prompt engineering does not require making changes to the underlying LLM itself. This makes it an efficient and accessible way to enhance performance without complex modifications.

提示工程大语言模型（LLM）生成的文本质量，很大程度上取决于输入提示（Prompt）的质量、语气、长度和结构。提示工程是一种优化大语言模型提示（Prompt）的方法，旨在提高生成内容的质量和准确性。在改进 RAG（Retrieval-Augmented Generation）系统时，提示工程通常是最容易入手的方法之一，因为它无需改动底层的大语言模型。这使得它成为一种高效且便捷的性能提升方式，无需进行复杂的调整。

There are several different prompting techniques that are especially useful in improving RAG pipelines.

有几种不同的提示方法，在改进 RAG（检索增强生成）流程中特别有用。

Chain of Thought (CoT) prompting involves asking the model to “think step-by-step” and break down complex reasoning tasks into a series of intermediate steps. This can be especially useful when retrieved documents contain conflicting or dense information that requires careful analysis.

思维链（Chain of Thought，CoT）提示是指要求模型进行「逐步思考」，并将复杂的推理任务拆解为一系列中间步骤。当检索到的文档中包含需要仔细分析的冲突信息或大量信息时，这尤其有用。

Tree of Thoughts (ToT) prompting builds on CoT by instructing the model to evaluate its responses at each step in the problem-solving process or even generate several different solutions to a problem and choose the best result. This is useful in RAG when there are many potential pieces of evidence, and the model needs to weigh different possible answers based on multiple retrieved documents.

「思维树提示」（Tree of Thoughts，ToT）建立在「思维链提示」（Chain of Thought，CoT）的基础上，它指示模型在解决问题的过程中，每一步都评估其响应，甚至可以生成多个不同的解决方案，并从中选择最佳结果。当检索增强生成（Retrieval-Augmented Generation，RAG）中存在大量潜在证据，且模型需要根据多个检索到的文档来权衡不同的可能答案时，这种方法非常有用。

ReAct (Reasoning and Acting) prompting combines CoT with agents, creating a system in which the model can generate thoughts and delegate actions to agents that interact with external data sources in an iterative process. ReAct can improve RAG pipelines by enabling LLMs to dynamically interact with retrieved documents, updating reasoning and actions based on external knowledge to provide more accurate and contextually relevant responses.

ReAct（推理和行动）方法将思维链（Chain-of-Thought，CoT）与 AI 智能体结合，构建了一个系统。在这个系统中，模型可以产生思考，并将行动委托给与外部数据源交互的 AI 智能体，形成一个迭代过程。ReAct 可以改进检索增强生成（Retrieval-Augmented Generation，RAG）流程，它通过使大语言模型能够动态地与检索到的文档交互，并基于外部知识更新推理和行动，从而提供更准确、更符合上下文的回复。

#### LLM Fine-Tuning

大语言模型微调

Pre-trained LLMs are trained on large, diverse datasets to acquire a sense of general knowledge, including language and grammar patterns, extensive vocabularies, and the ability to perform general tasks. When it comes to RAG, using pre-trained LLMs can sometimes result in generated output that is too generic, factually incorrect, or fails to directly address the retrieved context.

预训练的大语言模型（LLM）在大型且多样化的数据集上进行训练，从而掌握通用知识，包括语言和语法模式、丰富的词汇以及执行一般性任务的能力。当涉及到检索增强生成（RAG）时，使用预训练的大语言模型有时会产生过于泛化的输出，或者输出的内容在事实上不准确，亦或是无法直接回应检索到的相关上下文。

Fine-tuning a pre-trained model involves training it further on a specific dataset or task to adapt the model's general knowledge to the nuances of that particular domain, improving its performance in that area. Using a fine-tuned model in RAG pipelines can help improve the quality of generated responses, especially when the topic at hand is highly specialized.

微调一个预训练模型指的是，在特定的数据集或任务上对模型进行进一步的训练，使其通用的知识能够适应特定领域的细微差别，从而提升模型在该领域的表现。在检索增强生成（Retrieval-Augmented Generation，RAG）管道中使用微调后的模型，有助于提高生成回复的质量，尤其当所涉及的主题具有高度专业性时。

High-quality domain-specific data is crucial for fine-tuning LLMs. Labeled datasets, like positive and negative customer reviews, can help fine-tuned models better perform downstream tasks like text classification or sentiment analysis. Unlabeled datasets, on the other hand, like the latest articles published on PubMed, can help fine-tuned models gain more domain-specific knowledge and expand their vocabularies.

高质量的特定领域数据对于微调大语言模型（LLM）至关重要。例如，带有标签的数据集，如正面和负面客户评论，可以帮助微调后的模型在文本分类或情感分析等下游任务中表现更出色。而另一方面，像 PubMed 上发布的最新文章这类未标记的数据集，则可以帮助微调后的模型获得更多特定领域的知识，并扩展其词汇量。

During the fine-tuning process, the model weights of the pre-trained LLM (also referred to as a base model) are iteratively updated through a process called backpropagation to learn from the domain-specific dataset. The result is a fine-tuned LLM that better captures the nuances and requirements of the new data, such as specific terminology, style, or tone.

在微调过程中，预训练的大语言模型（LLM）(也称为基础模型）的模型权重通过反向传播的过程进行迭代更新，从而从特定领域的数据集中学习。最终得到一个微调后的大语言模型，它能更好地理解新数据的细微之处和要求，例如特定的术语、风格或语调。

### Summary

总结

RAG enhances generative models by enabling them to reference external data, improving response accuracy and relevance while mitigating hallucinations and information gaps. Naive RAG retrieves documents based on query similarity and directly feeds them into a generative model for response generation. However, more advanced techniques, like the ones detailed in this guide, can significantly improve the quality of RAG pipelines by enhancing the relevance and accuracy of the retrieved information.

检索增强生成（RAG）通过让生成式模型（Generative Model）能够参考外部数据来提升其性能，这不仅提高了回应的准确性和相关性，还有效减少了「幻觉」(hallucinations）现象和信息缺失。原始的 RAG 方法是基于查询与文档之间的相似性来检索文档，然后直接将检索到的文档输入生成式模型，以生成回应。然而，更高级的技术，例如本指南中详细介绍的那些方法，可以通过提高检索信息的关联性和准确性，显著改进 RAG 流程（pipeline）的质量。这里的 RAG 流程指的是从信息检索到生成回应的整个过程。

This e-book reviewed advanced RAG techniques that can be applied at various stages of the RAG pipeline to improve retrieval quality and accuracy of generated responses.

这本电子书回顾了可以在 RAG（检索增强生成）流水线的各个阶段应用的先进 RAG 技术，以提高检索质量和生成回复的准确性。

1 Indexing optimization techniques, like data preprocessing and chunking focus on formatting external data to improve its efficiency and searchability.

索引优化技术，例如数据预处理和分块，主要目的是对外部数据进行格式化，以提升其效率和可搜索性。

2 Pre-retrieval techniques aim to optimizing the user query itself by rewriting, reformatting, or routing queries to specialized pipelines.

预检索技术则着重于优化用户查询本身，手段包括重写查询、重新格式化查询，或者将查询导向特定的处理流程。

3 Retrieval optimization strategies often focus on refining search results during the retrieval phase.

检索优化策略通常专注于在检索过程中改进搜索结果的质量。

4 Post-retrieval optimization strategies aim to improve the accuracy of generated results through a variety of techniques including, re-ranking retrieved results, enhancing or compressing the (retrieved) context, and manipulating the prompt or generative model (LLM).

后检索优化策略旨在通过多种技术来提高生成结果的准确性，这些技术包括：对检索结果进行重新排序，增强或压缩检索到的上下文信息，以及调整提示词或生成模型（LLM）。

We recommend implementing a validation pipeline to identify which parts of your RAG system need optimization and to assess the effectiveness of advanced techniques. Evaluating your RAG pipeline enables continuous monitoring and refinement, ensuring that optimizations positively impact retrieval quality and model performance.

我们建议建立一套验证流程，用来识别您的 RAG（Retrieval-Augmented Generation）系统中哪些部分需要优化，并评估各种高级技术的有效性。对您的 RAG 流程进行评估，可以实现持续监测和优化，确保这些优化能够切实提升检索质量和模型性能。

## 原文

Advanced RAG Techniques

A guide on different techniques to improve the performance of your Retrieval-Augmented Generation applications.

Retrieval-augmented generation (RAG) provides generative large language models (LLMs) with information from an external knowledge source to help reduce hallucinations and increase the factual accuracy of the generated responses.

A naive RAG pipeline consists of four components: an embedding model, a vector database, a prompt template, and a generative LLM. At inference time, it embeds the user query to retrieve relevant document chunks of information from the vector database, which it stuffs into the LLM's prompt to generate an answer.

While this naive approach is straightforward, it has many limitations and can often lead to low-quality responses.

This e-book discusses various advanced techniques you can apply to improve the performance of your RAG system. These techniques can be applied at various stages in the RAG pipeline, as shown below:

Indexing
Indexing Optimization Techniques  
Data Pre-processing  
Chunking Strategies  

Pre-Retrieval
Pre-retrieval Optimization Techniques  
Query Transformation  
Query Decomposition  
Query Routing  

Retrieval
Retrieval Optimization Strategies  
Metadata Filtering  
Excluding Vector Search Outliers  
Hybrid search  
Embedding model fine-tuning  

Post-Retrieval
Post-retrieval Optimization Techniques  
Re-ranking  
Context Post-processing  
Prompt Engineering  
LLM Fine-tuning  

### Indexing

#### Indexing Optimization Techniques

Index optimization techniques enhance retrieval accuracy by structuring external data in more organized, searchable ways. These techniques can be applied to both data pre-processing and chunking stages in the RAG pipeline, ensuring that relevant information is effectively retrieved.

#### Data Pre-Processing

Data pre-processing is fundamental to the success of any RAG system, as the quality of your processed data directly impacts the overall performance. By thoughtfully transforming raw data into a structured format suitable for LLMs, you can significantly enhance your system's effectiveness before considering more complex optimizations.

While there are several common pre-processing techniques available, the optimal approach and sequence should be tailored to your specific use case and requirements.

The process usually begins with data acquisition and integration, where diverse document types from multiple sources are collected and consolidated into a 'knowledge base'.

Data Extraction and Data Parsing

Data extraction and parsing take place over the raw data so that it is accurately processed for downstream tasks. For text-based formats like Markdown, Word documents, and plain text, extraction techniques focus on preserving structure while capturing relevant content.

Scanned documents, images, and PDFs containing image-based text/tables require OCR (Optical Character Recognition) technology to convert into an 'LLM-ready' format. However, recent advancements in multimodal retrieval models, such as ColPaii and ColQwen, have revolutionized this process. These models can directly embed images of documents, potentially making traditional OCR obsolete.

Web content often involves HTML parsing, utilizing DOM traversal to extract structured data, while spreadsheets demand specialized parsing to handle cell relationships. Metadata extraction is also crucial across file types, pulling key details like author, timestamps, and other document properties (see Metadata Filtering).

Data Cleaning

Data cleaning and noise reduction involves removing irrelevant information (such as headers, footers, or boilerplate text), correcting inconsistencies, and handling missing values while maintaining the extracted data's structural integrity.

Data Transformation

This involves converting all extracted and processed content into a standardized schema, regardless of the original file type. It's at this stage that document partitioning (not to be confused with chunking) occurs, separating document content into logical units or elements (e.g., paragraphs, sections, tables).

#### Chunking Strategies

Chunking divides large documents into smaller, semantically meaningful segments. This process optimizes retrieval by balancing context preservation with manageable chunk sizes. Various common techniques exist for effective chunking in RAG, some of which are discussed below:

- Fixed-size chunking is a simple technique that splits text into chunks of a predetermined size, regardless of content structure. While it's cost-effective, it lacks contextual awareness. This can be improved by using overlapping chunks, allowing adjacent chunks to share some content.

- Recursive chunking offers more flexibility by initially splitting text using a primary separator (like paragraphs) and then applying secondary separators (like sentences) if chunks are still too large. This technique respects the document's structure and adapts well to various use cases.

- Document-based chunking creates chunks based on the natural divisions within a document, such as headings or sections. It's particularly effective for structured data like HTML, Markdown, or code files but less useful when the data lacks clear structural elements.

- Semantic chunking divides text into meaningful units, which are then vectorized. These units are then combined into chunks based on the cosine distance between their embeddings, with a new chunk formed whenever a significant content shift is detected. This method balances semantic coherence with chunk size.

- LLM-based chunking is an advanced technique that uses an LLM to generate chunks by processing text and creating semantically isolated sentences or propositions. While highly accurate, it's also the most computationally demanding approach.

Each of the discussed techniques has its strengths, and the choice depends on the RAG system's specific requirements and the nature of the documents being processed. New approaches continue to emerge, such as late chunking, which processes text through long-context embedding models before splitting it into chunks to better preserve document-wide context.

### Pre-Retrieval

#### Pre-retrieval Optimization Techniques

Index optimization techniques enhance retrieval accuracy by structuring external data in more organized, searchable ways. These techniques can be applied to both data pre-processing and chunking stages in the RAG pipeline, ensuring that relevant information is effectively retrieved.

#### Query Transformation

Using the user query directly as the search query for retrieval can lead to poor search results. That's why turning the raw user query into an optimized search query is essential. Query transformation refines and expands unclear, complex, or ambiguous user queries to improve the quality of search results.

Query Rewriting involves reformulating the original user query to make it more suitable for retrieval. This is particularly useful in scenarios where user queries are not optimally phrased or expressed differently. This can be achieved by using an LLM to rephrase the original user query or employing specialized smaller language models trained specifically for this task.

This approach is called 'Rewrite-Retrieve-Read' instead of the traditional 'Retrieve-then-Read' paradigm.

Query Expansion focuses on broadening the original query to capture more relevant information. This involves using an LLM to generate multiple similar queries based on the user's initial input. These expanded queries are then used in the retrieval process, increasing both the number and relevance of retrieved documents.

Note: Due to the increased quantity of retrieved documents, a reranking step is often necessary to prioritize the most relevant results (see Re-ranking).

#### Query Decomposition

Query decomposition is a technique that breaks down complex queries into simpler sub-queries. This is useful for answering multifaceted questions requiring diverse information sources, leading to more precise and relevant search results.

The process typically involves two main stages: decomposing the original query into smaller, focused sub-queries using an LLM and then processing these sub-queries to retrieve relevant information.

For example, the complex query "Why am I always so tired even though I eat healthy? Should I be doing something different with my diet or maybe try some diet trends?" can be decomposed into the following three simpler sub-queries:

1. What are the common dietary factors that can cause fatigue?
2. What are some popular diet trends and their effects on energy levels?
3. How can I determine if my diet is balanced and supports my energy needs?

Each sub-query targets a specific aspect, enabling the retriever to find relevant documents or chunks. Sub-queries can also be processed in parallel to improve efficiency. Additional techniques like keyword extraction and metadata filter extraction can help identify both key search terms and structured filtering criteria, enabling more precise searches. After retrieval, the system aggregates and synthesizes results from all sub-queries to generate a comprehensive answer to the original complex query.

#### Query Routing

Query routing is a technique that directs queries to specific pipelines based on their content and intent, enabling a RAG system to handle diverse scenarios effectively. It works by analyzing each query and choosing the best retrieval method or processing pipeline to provide an accurate response. This often requires implementing multi-index strategies, where different types of information are organized into separate, specialized indexes optimized.

The process can include agentic elements, where AI agents decide how to handle each query. These agents evaluate factors such as query complexity and domain to determine the optimal approach. For example, fact-based questions may be routed to one pipeline, while those requiring summarization or interpretation are sent to another.

Agentic RAG functions like a network of specialized agents, each with different expertise. It can choose from various data stores, retrieval strategies (keyword-based, semantic, or hybrid), query transformations (for poorly structured queries), and specialized tools or APIs, such as text-to-SQL converters or even web search capabilities.

### Retrieval

#### Retrieval Optimization Strategies

Retrieval optimization strategies aim to improve retrieval results by directly manipulating the way in which external data is retrieved in relation to the user query. This can involve refining the search query, such as using metadata to filter candidates or excluding outliers, or even involve fine-tuning an embedding model on external data to improve the quality of the underlying embeddings themselves.

#### Metadata Filtering

Metadata is the additional information attached to each document or chunk in a vector database, providing valuable context to enhance retrieval. This supplementary data can include timestamps, categories, author info, source references, languages, file types, etc.

When retrieving content from a vector database, metadata helps refine results by filtering out irrelevant objects, even when they are semantically similar to the query. This narrows the search scope and improves the relevance of the retrieved information.

Another benefit of using metadata is time-awareness. By incorporating timestamps as metadata, the system can prioritize recent information, ensuring the retrieved knowledge remains current and relevant. This is particularly useful in domains where information freshness is critical.

To get the most out of metadata filtering, it's important to plan carefully and choose metadata that improves search without adding unnecessary complexity.

#### Excluding Vector Search Outliers

The most straightforward approach to defining the number of returned results is explicitly setting a value for the top_k (top_k) results. If you set top_k to 5, you’ll get the five closest vectors, regardless of their relevance. While easy to implement, this can include poor matches just because they made the cutoff.

Here are two techniques to manage the number of search results implicitly that can help with excluding outliers:

Distance thresholding adds a quality check by setting a maximum allowed distance between vectors. Any result with a distance score above this threshold gets filtered out, even if it would have made the top_k cutoff. This helps remove the obvious bad matches but requires careful threshold adjustment.

Autocut is more dynamic - it looks at how the result distances are clustered. Instead of using fixed limits, it groups results based on their relative distances from your query vector. When there’s a big jump in distance scores between groups, Autocut can cut off the results at that jump. This catches outliers that might slip through top_k or basic distance thresholds.

#### Hybrid Search

Hybrid search combines the strengths of vector-based semantic search with traditional keyword-based methods. This technique aims to improve the relevance and accuracy of retrieved information in RAG systems.

The key to hybrid search lies in the ‘alpha’ (α) parameter, which controls the balance between semantic and keyword-based search methods:

- α = 1: Pure semantic search
- α = 0: Pure keyword-based search
- 0 < α < 1: Weighted combination of both methods

This approach is particularly beneficial when you need both contextual understanding and exact keyword matching.

Consider a technical support knowledge base for a software company. A user might submit a query like “Excel formula not calculating correctly after update”. In this scenario, semantic search helps understand the context of the problem, potentially retrieving articles about formula errors, calculation issues, or software update impacts. Meanwhile, keyword search ensures that documents containing specific terms like “Excel” and “formula” are not overlooked.

Therefore, while implementing hybrid search, it’s crucial to adjust the alpha parameter based on your specific use case to optimize the performance.

#### Embedding Model Fine-Tuning

Off-the-shelf embedding models are usually trained on large general datasets to embed a wide range of data inputs. However, embedding models can fail to capture the context and nuances of smaller, domain-specific datasets.

Fine-tuning embedding models on custom datasets can significantly improve the quality of embeddings, subsequently improving performance on downstream tasks like RAG. Fine-tuning improves embeddings to better capture the dataset's meaning and context, leading to more accurate and relevant retrievals in RAG applications.

The more niche your dataset is, the more it can benefit from embedding model fine-tuning. Datasets with specialized vocabularies, like medical or legal datasets, are ideal for embedding model fine-tuning, which helps extend out-of-domain vocabularies and enhance the accuracy and relevance of information retrieval and generation in RAG pipelines.

To fine-tune an existing embedding model you first need to select a base model that you would like to improve. Next, you begin the fine-tuning process by providing the model with your domain-specific data. During this process, the loss function adjusts the model's embeddings so that semantically similar items are placed closer together in the embedding space. To evaluate a fine-tuned embedding model, you can use a validation set of curated query-answer pairs to assess the quality of retrieval in your RAG pipeline. Now, the model is ready to generate more accurate and representative embeddings for your specific dataset.

Pre-trained embedding model
Clusters semantically similar sentences together.

Fine-tuned embedding model
Distinguishes between positive, mixed, and negative reviews. 

### Post-Retrieval

#### Post-Retrieval Optimization Techniques

Post-retrieval optimization techniques aim to enhance the quality of generated responses, meaning that their work begins after the retrieval process has been completed. This diverse group of techniques includes using models to re-rank retrieved results, enhancing or compressing the retrieved context, prompt engineering, and fine-tuning the generative LLM on external data.

#### Re-Ranking

One proven method to improve the performance of your information retrieval system is to leverage a retrieve-and-rerank pipeline. A retrieve-and-rerank pipeline combines the speed of vector search with the contextual richness of a re-ranking model.

In vector search, the query and documents are processed separately. First, the documents are pre-indexed. Then, at query time, the query is processed, and the documents closest in vector space are retrieved. While vector search is a fast method to retrieve candidates, it can miss contextual nuances.

This is where re-ranking models come into play. Because re-ranking models process the query and the documents together at query time, they can capture more contextual nuances. However, they are usually complex and resource-intensive and thus not suitable for first-stage retrieval like vector search.

By combining vector search with re-ranking models, you can quickly cast a wide net of potential candidates and then re-order them to improve the quality of relevant context in your prompt.

Note that when using a re-ranking model, you should over-retrieve chunks to filter out less relevant ones later.

#### Context Post-Processing

After retrieval, it can be beneficial to post-process the retrieved context for generation. For example, if the retrieved context might benefit from additional information you can enhance it with metadata. On the other hand, if it contains redundant data, you can compress it.

Context Enhancement with Metadata

One post-processing technique is to use metadata to enhance the retrieved context with additional information to improve generation accuracy. While you can simply add additional information from the metadata, such as timestamps, document names, etc., you can also apply more creative techniques.

Context enhancement is particularly useful when data needs to be pre-processed into smaller chunk sizes to achieve better retrieval precision that doesn’t contain enough contextual information to generate high-quality responses. In this case, you can apply a technique called “Sentence window retrieval”. This technique chunks the initial document into smaller pieces (usually single sentences) but stores a larger context window in its metadata. At retrieval time, the smaller chunks help improve retrieval precision. After retrieval, the retrieved smaller chunks are replaced with the larger context window to improve generation quality.

Context Compression

RAG systems rely on diverse knowledge sources to retrieve relevant information. However, this often results in the retrieval of irrelevant or redundant data, which can lead to suboptimal responses and costly LLM calls (more tokens).

Context compression effectively addresses this challenge by extracting only the most meaningful information from the retrieved data. This process begins with a base retriever that retrieves documents/chunks related to the query. These documents/chunks are then passed through a document compressor that shortens them and eliminates irrelevant content, ensuring that valuable data is not lost in a sea of extraneous information.

Contextual compression reduces data volume, lowering retrieval and operational costs. Current research focuses on two main approaches: embedding-based and lexical-based compression, both of which aim to retain essential information while easing computational demands on RAG systems.

#### Prompt Engineering

The generated outputs of LLMs are greatly influenced by the quality, tone, length, and structure of their corresponding prompts. Prompt engineering is the practice of optimizing LLM prompts to improve the quality and accuracy of generated output. Often one of the lowest-hanging fruits when it comes to techniques for improving RAG systems, prompt engineering does not require making changes to the underlying LLM itself. This makes it an efficient and accessible way to enhance performance without complex modifications.

There are several different prompting techniques that are especially useful in improving RAG pipelines.

Chain of Thought (CoT) prompting involves asking the model to “think step-by-step” and break down complex reasoning tasks into a series of intermediate steps. This can be especially useful when retrieved documents contain conflicting or dense information that requires careful analysis.

Tree of Thoughts (ToT) prompting builds on CoT by instructing the model to evaluate its responses at each step in the problem-solving process or even generate several different solutions to a problem and choose the best result. This is useful in RAG when there are many potential pieces of evidence, and the model needs to weigh different possible answers based on multiple retrieved documents.

ReAct (Reasoning and Acting) prompting combines CoT with agents, creating a system in which the model can generate thoughts and delegate actions to agents that interact with external data sources in an iterative process. ReAct can improve RAG pipelines by enabling LLMs to dynamically interact with retrieved documents, updating reasoning and actions based on external knowledge to provide more accurate and contextually relevant responses.

#### LLM Fine-Tuning

Pre-trained LLMs are trained on large, diverse datasets to acquire a sense of general knowledge, including language and grammar patterns, extensive vocabularies, and the ability to perform general tasks. When it comes to RAG, using pre-trained LLMs can sometimes result in generated output that is too generic, factually incorrect, or fails to directly address the retrieved context.

Fine-tuning a pre-trained model involves training it further on a specific dataset or task to adapt the model's general knowledge to the nuances of that particular domain, improving its performance in that area. Using a fine-tuned model in RAG pipelines can help improve the quality of generated responses, especially when the topic at hand is highly specialized.

High-quality domain-specific data is crucial for fine-tuning LLMs. Labeled datasets, like positive and negative customer reviews, can help fine-tuned models better perform downstream tasks like text classification or sentiment analysis. Unlabeled datasets, on the other hand, like the latest articles published on PubMed, can help fine-tuned models gain more domain-specific knowledge and expand their vocabularies.

During the fine-tuning process, the model weights of the pre-trained LLM (also referred to as a base model) are iteratively updated through a process called backpropagation to learn from the domain-specific dataset. The result is a fine-tuned LLM that better captures the nuances and requirements of the new data, such as specific terminology, style, or tone.

### Summary

RAG enhances generative models by enabling them to reference external data, improving response accuracy and relevance while mitigating hallucinations and information gaps. Naive RAG retrieves documents based on query similarity and directly feeds them into a generative model for response generation. However, more advanced techniques, like the ones detailed in this guide, can significantly improve the quality of RAG pipelines by enhancing the relevance and accuracy of the retrieved information.

This e-book reviewed advanced RAG techniques that can be applied at various stages of the RAG pipeline to improve retrieval quality and accuracy of generated responses.

- Indexing optimization techniques, like data preprocessing and chunking focus on formatting external data to improve its efficiency and searchability.
- Pre-retrieval techniques aim to optimizing the user query itself by rewriting, reformatting, or routing queries to specialized pipelines.
- Retrieval optimization strategies often focus on refining search results during the retrieval phase.
- Post-retrieval optimization strategies aim to improve the accuracy of generated results through a variety of techniques including, re-ranking retrieved results, enhancing or compressing the (retrieved) context, and manipulating the prompt or generative model (LLM).

We recommend implementing a validation pipeline to identify which parts of your RAG system need optimization and to assess the effectiveness of advanced techniques. Evaluating your RAG pipeline enables continuous monitoring and refinement, ensuring that optimizations positively impact retrieval quality and model performance.