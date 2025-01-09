## 20250108Build-a-Document-AI-Pipeline-for-Any-Type-of-PDF-with-Gemini

[Build a Document AI Pipeline for Any Type of PDF with Gemini | by Youness Mansar | Dec, 2024 | Towards Data Science](https://towardsdatascience.com/build-a-document-ai-pipeline-for-any-type-of-pdf-with-gemini-9221c8e143db)

Youness Mansar

Published in Towards Data Science

Dec 15, 2024

Automated document processing is one of the biggest winners of the ChatGPT revolution, as LLMs are able to tackle a wide range of subjects and tasks in a zero-shot setting, meaning without in-domain labeled training data. This has made building AI-powered applications to process, parse, and automatically understand arbitrary documents much easier. Though naive approaches using LLMs are still hindered by non-text context, such as figures, images, and tables, this is what we will try to address in this blog post, with a special focus on PDFs.

自动化文档处理是 ChatGPT 革命的最大受益者之一。因为大语言模型（LLM）能够在零样本（zero-shot）场景下处理各种主题和任务，这意味着它们无需使用特定领域的标注数据进行训练。这使得构建 AI 驱动的应用程序来处理、解析和自动理解各种文档变得更加容易。然而，直接使用大语言模型的方法仍然会受到非文本内容的限制，例如图表、图像和表格。这正是我们这篇博文将要探讨的问题，尤其是关于 PDF 文档的处理。

At a basic level, PDFs are just a collection of characters, images, and lines along with their exact coordinates. They have no inherent “text” structure and were not built to be processed as text but only to be viewed as is. This is what makes working with them difficult, as text-only approaches fail to capture all the layout and visual elements in these types of documents, resulting in a significant loss of context and information.

从根本上来说，PDF 是由字符、图像、线条以及它们的精确坐标组成的。它们没有内在的文本结构，其设计初衷也不是为了作为文本进行处理，而是为了保持原样展示。这使得处理 PDF 文件变得困难，因为仅使用文本处理的方式无法捕捉到这类文档的所有布局和视觉元素，这会导致上下文和信息的严重丢失。

One way to bypass this “text-only” limitation is to do heavy pre-processing of the document by detecting tables, images, and layout before feeding them to the LLM. Tables can be parsed to Markdown or JSON, images and figures can be represented by their captions, and the text can be fed as is. However, this approach requires custom models and will still result in some loss of information, so can we do better?

一种绕开「仅限文本」这种限制的方法是，在将文档输入给大语言模型（LLM）之前，先进行大量的预处理，例如检测文档中的表格、图片和排版布局。表格可以被转换为 Markdown 或 JSON 格式，图片和图可以用它们的标题来表示，而文本则可以直接输入。然而，这种方法需要使用专门定制的模型，并且仍然会造成一定的信息损失，那么有没有更好的办法呢？

### Multimodal LLMs

多模态大模型

Most recent large models are now multi-modal, meaning they can process multiple modalities like text, code, and images. This opens the way to a simpler solution to our problem where one model does everything at once. So, instead of captioning images and parsing tables, we can just feed the page as an image and process it as is. Our pipeline will be able to load the PDF, extract each page as an image, split it into chunks (using the LLM), and index each chunk. If a chunk is retrieved, then the full page is included in the LLM context to perform the task. In what follows, we will detail how this can be implemented in practice.

目前，大多数大型模型都已具备多模态能力，这意味着它们可以处理多种类型的数据，例如文本、代码和图像。这为我们当前的问题提供了一个更简单的解决方案：使用单个模型一次性完成所有任务。因此，我们不再需要为图像添加标题或解析表格，而是可以直接将页面作为图像输入并进行处理。我们的流程将能够加载 PDF 文件，将每页提取为图像，然后使用大语言模型将其分割成块，并为每个块建立索引。当检索到某个块时，该块对应的完整页面会被包含在大语言模型的上下文中，以执行后续任务。接下来，我们将详细介绍如何在实践中实现这一过程。

#### The Pipeline

流程

The pipeline we are implementing is a two-step process. First, we segment each page into significant chunks and summarize each of them. Second, we index chunks once then search the chunks each time we get a request and include the full context with each retrieved chunk in the LLM context.

我们正在实施的流程分为两个步骤。首先，我们将每个页面划分为若干重要片段，并对每个片段进行总结。其次，我们对这些片段建立索引，然后在每次收到请求时检索这些片段，并将检索到的每个片段的完整上下文提供给大语言模型（LLM）。

Step 1: Page Segmentation and Summarization

第一步：页面分割与摘要

We extract the pages as images and pass each of them to the multi-modal LLM to segment them. Models like Gemini can understand and process page layout easily:

我们将页面提取为图像，然后将每个页面交给多模态大语言模型（LLM）进行分割。例如 Gemini 这样的模型可以轻松理解和处理页面布局：

1 Tables are identified as one chunk.

表格被视为一个块。

2 Figures form another chunk.

图形被视为另一个块。

3 Text blocks are segmented into individual chunks.

文本块被分割成独立的块。

…

For each element, the LLM generates a summary than can be embedded and indexed into a vector database.

对于每个元素，大语言模型（Large Language Model）(LLM）生成一个摘要，生成的摘要可以被嵌入并索引到向量数据库。

Step 2: Embedding and Contextual Retrieval

步骤 2：嵌入与上下文检索

In this tutorial we will use text embedding only for simplicity but one improvement would be to use vision embeddings directly.

在本教程中，为了方便理解，我们仅使用文本嵌入（text embedding）。但可以进一步改进的是，直接利用视觉嵌入（vision embedding）。

Each entry in the database includes:

数据库中的每个条目包括：

1 The summary of the chunk.

文本块的概要。

2 The page number where it was found.

该文本块所在的页码。

2 A link to the image representation of the full page for added context.

一个指向完整页面图像的链接，以提供更多上下文信息。

This schema allows for local level searches (at the chunk level) while keeping track of the context (by linking back to the full page). For example, if a search query retrieves an item, the Agent can include the entire page image to provide full layout and extra context to the LLM in order to maximize response quality.

这种结构允许在本地进行文本块级别的搜索，同时通过链接回完整页面来跟踪上下文。例如，如果一个搜索查询检索到一个条目，AI 智能体可以提供整个页面的图像，以便为大语言模型提供完整的布局和额外的上下文，以提高回复质量。

By providing the full image, all the visual cues and important layout information (like images, titles, bullet points… ) and neighboring items (tables, paragraph, …) are available to the LLM at the time of generating a response.

当提供完整图像时，所有视觉线索和重要布局信息（例如图像、标题、项目符号等）以及相邻元素（表格、段落等），在生成回复时都可供大语言模型（LLM）使用。

#### Agents

智能体

We will implement each step as a separate, re-usable agent:

我们将每个步骤都实现为一个独立的、可复用的 AI 智能体：

The first agent is for parsing, chunking, and summarization. This involves the segmentation of the document into significant chunks, followed by the generation of summaries for each of them. This agent only needs to be run once per PDF to preprocess the document.

第一个智能体负责解析、分块和生成摘要。它会将文档分割成若干重要的片段，然后为每个片段生成摘要。这个智能体只需要对每个 PDF 文档运行一次，用于预处理文档。

The second agent manages indexing, search, and retrieval. This includes inserting the embedding of chunks into the vector database for efficient search. Indexing is performed once per document, while searches can be repeated as many times as needed for different queries.

第二个 AI 智能体管理索引、搜索和检索。这包括将文本块的嵌入（embedding）插入到向量数据库中，以实现高效搜索。索引操作每个文档执行一次，而搜索操作可以根据查询需要重复多次。

For both agents, we use Gemini, a multimodal LLM with strong vision understanding abilities.

我们为这两个 AI 智能体都选择了 Gemini，它是一个拥有卓越视觉理解能力的多模态大语言模型（LLM）。

Parsing and Chunking Agent

解析与分块 AI 智能体

The first agent is in charge of segmenting each page into meaningful chunks and summarizing each of them, following these steps:

第一个 AI 智能体的任务是将每个页面分解为有意义的段落，并对每个段落进行总结，具体步骤如下：

Step 1: Extracting PDF Pages as Images

步骤 1：将 PDF 页面转换为图像

We use the pdf2image library. The images are then encoded in Base64 format to simplify adding them to the LLM request.

我们使用 pdf2image 库将 PDF 页面转换为图像。然后，为了方便将这些图像添加到大语言模型（LLM/Large Language Model）的请求中，我们会将它们编码为 Base64 格式。

Here’s the implementation:

```py
from document_ai_agents.document_utils import extract_images_from_pdf
from document_ai_agents.image_utils import pil_image_to_base64_jpeg
from pathlib import Path

class DocumentParsingAgent:
    @classmethod
    def get_images(cls, state):
        """
        Extract pages of a PDF as Base64-encoded JPEG images.
        """
        assert Path(state.document_path).is_file(), "File does not exist"
        # Extract images from PDF
        images = extract_images_from_pdf(state.document_path)
        assert images, "No images extracted"
        # Convert images to Base64-encoded JPEG
        pages_as_base64_jpeg_images = [pil_image_to_base64_jpeg(x) for x in images]
        return {"pages_as_base64_jpeg_images": pages_as_base64_jpeg_images}
```

extract_images_from_pdf: Extracts each page of the PDF as a PIL image.

extract_images_from_pdf：将 PDF 文档的每一页转换为 PIL（Python Imaging Library）图像格式。

pil_image_to_base64_jpeg: Converts the image into a Base64-encoded JPEG format.

pil_image_to_base64_jpeg：将图像转换为 Base64 编码的 JPEG 格式。

Step 2: Chunking and Summarization

步骤 2：分块和摘要

Each image is then sent to the LLM for segmentation and summarization. We use structured outputs to ensure we get the predictions in the format we expect:

随后，每张图像都会被送入大语言模型（LLM）进行分割和内容概要提取。为了确保获得预期格式的预测结果，我们采用了结构化的输出方式：

```py
from pydantic import BaseModel, Field
from typing import Literal
import json
import google.generativeai as genai
from langchain_core.documents import Document

class DetectedLayoutItem(BaseModel):
    """
    Schema for each detected layout element on a page.
    """
    element_type: Literal["Table", "Figure", "Image", "Text-block"] = Field(
        ..., 
        description="Type of detected item. Examples: Table, Figure, Image, Text-block."
    )
    summary: str = Field(..., description="A detailed description of the layout item.")

class LayoutElements(BaseModel):
    """
    Schema for the list of layout elements on a page.
    """
    layout_items: list[DetectedLayoutItem] = []

class FindLayoutItemsInput(BaseModel):
    """
    Input schema for processing a single page.
    """
    document_path: str
    base64_jpeg: str
    page_number: int

class DocumentParsingAgent:
    def __init__(self, model_name="gemini-1.5-flash-002"):
        """
        Initialize the LLM with the appropriate schema.
        """
        layout_elements_schema = prepare_schema_for_gemini(LayoutElements)
        self.model_name = model_name
        self.model = genai.GenerativeModel(
            self.model_name,
            generation_config={
                "response_mime_type": "application/json",
                "response_schema": layout_elements_schema,
            },
        )
    def find_layout_items(self, state: FindLayoutItemsInput):
        """
        Send a page image to the LLM for segmentation and summarization.
        """
        messages = [
            f"Find and summarize all the relevant layout elements in this PDF page in the following format: "
            f"{LayoutElements.schema_json()}. "
            f"Tables should have at least two columns and at least two rows. "
            f"The coordinates should overlap with each layout item.",
            {"mime_type": "image/jpeg", "data": state.base64_jpeg},
        ]
        # Send the prompt to the LLM
        result = self.model.generate_content(messages)
        data = json.loads(result.text)
        
        # Convert the JSON output into documents
        documents = [
            Document(
                page_content=item["summary"],
                metadata={
                    "page_number": state.page_number,
                    "element_type": item["element_type"],
                    "document_path": state.document_path,
                },
            )
            for item in data["layout_items"]
        ]
        return {"documents": documents}
```

The LayoutElements schema defines the structure of the output, with each layout item type (Table, Figure, … ) and its summary.

LayoutElements 结构定义了输出的格式，其中包含了每种布局元素类型（例如表格、图像等）及其对应的摘要信息。

Step 3: Parallel Processing of Pages

步骤 3：页面并行处理

Pages are processed in parallel for speed. The following method creates a list of tasks to handle all the page image at once since the processing is io-bound:

为了加快处理速度，页面会进行并行处理。由于图像处理受 I/O 限制，以下方法创建了一个任务列表，以便同时处理所有页面的图像：

```py
from langgraph.types import Send

class DocumentParsingAgent:
    @classmethod
    def continue_to_find_layout_items(cls, state):
        """
        Generate tasks to process each page in parallel.
        """
        return [
            Send(
                "find_layout_items",
                FindLayoutItemsInput(
                    base64_jpeg=base64_jpeg,
                    page_number=i,
                    document_path=state.document_path,
                ),
            )
            for i, base64_jpeg in enumerate(state.pages_as_base64_jpeg_images)
        ]
```

Each page is sent to the find_layout_items function as an independent task.

每个页面都会被当作一个独立的任务，发送给 `find_layout_items` 函数进行处理。

Full workflow

完整的工作流程

The agent’s workflow is built using a StateGraph, linking the image extraction and layout detection steps into a unified pipeline ->

智能体的工作流程是使用 StateGraph 构建的，它将图像提取和布局检测步骤整合到一个统一的流程中 ->

```py
from langgraph.graph import StateGraph, START, END

class DocumentParsingAgent:
    def build_agent(self):
        """
        Build the agent workflow using a state graph.
        """
        builder = StateGraph(DocumentLayoutParsingState)
        
        # Add nodes for image extraction and layout item detection
        builder.add_node("get_images", self.get_images)
        builder.add_node("find_layout_items", self.find_layout_items)
        # Define the flow of the graph
        builder.add_edge(START, "get_images")
        builder.add_conditional_edges("get_images", self.continue_to_find_layout_items)
        builder.add_edge("find_layout_items", END)
        
        self.graph = builder.compile()
```

To run the agent on a sample PDF we do:

为了在示例 PDF 上运行智能体，我们需要这样做：

```py
if __name__ == "__main__":
    _state = DocumentLayoutParsingState(
        document_path="path/to/document.pdf"
    )
    agent = DocumentParsingAgent()
    
    # Step 1: Extract images from PDF
    result_images = agent.get_images(_state)
    _state.pages_as_base64_jpeg_images = result_images["pages_as_base64_jpeg_images"]
    
    # Step 2: Process the first page (as an example)
    result_layout = agent.find_layout_items(
        FindLayoutItemsInput(
            base64_jpeg=_state.pages_as_base64_jpeg_images[0],
            page_number=0,
            document_path=_state.document_path,
        )
    )
    # Display the results
    for item in result_layout["documents"]:
        print(item.page_content)
        print(item.metadata["element_type"])
```

This results in a parsed, segmented, and summarized representation of the PDF, which is the input of the second agent we will build next.

这便生成了 PDF 文件经过解析、分段和总结后的表示形式，它将作为我们接下来要构建的第二个 AI 智能体的输入。

RAG Agent

RAG 智能体（RAG Agent)

This second agent handles the indexing and retrieval part. It saves the documents of the previous agent into a vector database and uses the result for retrieval. This can be split into two seprate steps, indexing and retrieval.

第二个 AI 智能体负责处理索引和检索。它将前一个 AI 智能体处理过的文档存入向量数据库，并利用这些数据进行检索。这个过程可以分为两个独立的步骤：索引和检索。

Step 1: Indexing the Split Document

步骤 1：为拆分后的文档建立索引

Using the summaries generated, we vectorize them and save them in a ChromaDB database:

利用生成的摘要，我们将这些摘要向量化，并存储到 ChromaDB 数据库中：

```py
class DocumentRAGAgent:
    def index_documents(self, state: DocumentRAGState):
        """
        Index the parsed documents into the vector store.
        """
        assert state.documents, "Documents should have at least one element"
        # Check if the document is already indexed
        if self.vector_store.get(where={"document_path": state.document_path})["ids"]:
            logger.info(
                "Documents for this file are already indexed, exiting this node"
            )
            return  # Skip indexing if already done
        # Add parsed documents to the vector store
        self.vector_store.add_documents(state.documents)
        logger.info(f"Indexed {len(state.documents)} documents for {state.document_path}")
```

The index_documents method embeds the chunk summaries into the vector store. We keep metadata such as the document path and page number for later use.

`index_documents` 方法会将文本块的摘要信息嵌入到向量数据库中。我们还会保存文档路径和页码等元数据，方便后续使用。

Step 2: Handling Questions

第二步：处理问题

When a user asks a question, the agent searches for the most relevant chunks in the vector store. It retrieves the summaries and corresponding page images for contextual understanding.

当用户提出问题时，AI 智能体会从向量存储中寻找最相关的文本片段。为了更好地理解上下文，它会提取这些片段的摘要以及对应的页面图像。

```py
class DocumentRAGAgent:
    def answer_question(self, state: DocumentRAGState):
        """
        Retrieve relevant chunks and generate a response to the user's question.
        """
        # Retrieve the top-k relevant documents based on the query
        relevant_documents: list[Document] = self.retriever.invoke(state.question)

        # Retrieve corresponding page images (avoid duplicates)
        images = list(
            set(
                [
                    state.pages_as_base64_jpeg_images[doc.metadata["page_number"]]
                    for doc in relevant_documents
                ]
            )
        )
        logger.info(f"Responding to question: {state.question}")
        # Construct the prompt: Combine images, relevant summaries, and the question
        messages = (
            [{"mime_type": "image/jpeg", "data": base64_jpeg} for base64_jpeg in images]
            + [doc.page_content for doc in relevant_documents]
            + [
                f"Answer this question using the context images and text elements only: {state.question}",
            ]
        )
        # Generate the response using the LLM
        response = self.model.generate_content(messages)
        return {"response": response.text, "relevant_documents": relevant_documents}
```

The retriever queries the vector store to find the chunks most relevant to the user’s question. We then build the context for the LLM (Gemini), which combines text chunks and images in order to generate a response.

检索器在向量存储中查询，找到与用户问题最相关的文本片段。然后，我们为大语言模型（LLM）Gemini 构建上下文，该模型结合文本片段和图像，从而生成响应。

The full agent Workflow

完整的 AI 智能体工作流程

The agent workflow has two stages, an indexing stage and a question answering stage:

AI 智能体流程分为两个阶段：索引建立阶段和问题解答阶段：

```py
class DocumentRAGAgent:
    def build_agent(self):
        """
        Build the RAG agent workflow.
        """
        builder = StateGraph(DocumentRAGState)
        # Add nodes for indexing and answering questions
        builder.add_node("index_documents", self.index_documents)
        builder.add_node("answer_question", self.answer_question)
        # Define the workflow
        builder.add_edge(START, "index_documents")
        builder.add_edge("index_documents", "answer_question")
        builder.add_edge("answer_question", END)
        self.graph = builder.compile()
```

Example run

```py
if __name__ == "__main__":
    from pathlib import Path

  # Import the first agent to parse the document
    from document_ai_agents.document_parsing_agent import (
        DocumentLayoutParsingState,
        DocumentParsingAgent,
    )
    # Step 1: Parse the document using the first agent
    state1 = DocumentLayoutParsingState(
        document_path=str(Path(__file__).parents[1] / "data" / "docs.pdf")
    )
    agent1 = DocumentParsingAgent()
    result1 = agent1.graph.invoke(state1)
    # Step 2: Set up the second agent for retrieval and answering
    state2 = DocumentRAGState(
        question="Who was acknowledged in this paper?",
        document_path=str(Path(__file__).parents[1] / "data" / "docs.pdf"),
        pages_as_base64_jpeg_images=result1["pages_as_base64_jpeg_images"],
        documents=result1["documents"],
    )
    agent2 = DocumentRAGAgent()
    # Index the documents
    agent2.graph.invoke(state2)
    # Answer the first question
    result2 = agent2.graph.invoke(state2)
    print(result2["response"])
    # Answer a second question
    state3 = DocumentRAGState(
        question="What is the macro average when fine-tuning on PubLayNet using M-RCNN?",
        document_path=str(Path(__file__).parents[1] / "data" / "docs.pdf"),
        pages_as_base64_jpeg_images=result1["pages_as_base64_jpeg_images"],
        documents=result1["documents"],
    )
    result3 = agent2.graph.invoke(state3)
    print(result3["response"])
```

With this implementation, the pipeline is complete for document processing, retrieval, and question answering.

通过这种实现方式，文档处理、检索和问答的整个流程就构建完成了。

### Example: Using the Document AI Pipeline

示例：使用文档 AI 流程

Let’s walk through a practical example using the document LLM & Adaptation.pdf , a set of 39 slides containing text, equations, and figures (CC BY 4.0).

让我们来看一个实际的例子，使用文档大模型和 Adaptation.pdf ，这是一份包含文本、公式和图表的 39 页幻灯片（CC BY 4.0）。

Step 1: Parsing and summarizing the Document (Agent 1)

第一步：解析并总结文档（智能体 1）

1 Execution Time: Parsing the 39-page document took 29 seconds.

执行时间：解析这份 39 页的文档耗时 29 秒。

2 Result: Agent 1 produces an indexed document consisting of chunk summaries and base64-encoded JPEG images of each page.

结果：智能体 1 生成一个索引文档，其中包含段落摘要和每页的 base64 编码的 JPEG 格式图像。

Step 2: Questioning the Document (Agent 2)

第二步：向文档提问（智能体 2）

We ask the following question:

“Explain LoRA, give the relevant equations”

我们提出以下问题：「解释 LoRA，给出相关方程式」。

Result:

Retrieved pages:

Source: LLM & Adaptation.pdf License CC-BY

Response from the LLM

Fig: Image by author

The LLM was able to include equations and figures into its response by taking advantage of the visual context in generating a coherent and correct response based on the document.

大语言模型（LLM）能够利用视觉上下文理解文档，并在回复中加入公式和图表，生成连贯且正确的答案。

### Conclusion

In this quick tutorial, we saw how you can take your document AI processing pipeline a step further by leveraging the multi-modality of recent LLMs and using the full visual context available in each document, hopefully improving the quality of outputs that you are able to get from either your information extraction or RAG pipeline.

通过本快速教程，我们了解了如何进一步提升文档 AI 处理流程，具体方法是利用最近大语言模型（LLM）的多模态特性，并结合每个文档中完整的视觉信息，从而有望提高从信息提取或 RAG 流程中获得的输出质量。

We built a stronger document segmentation step that is able to detect the important items like paragraphs, tables, and figures and summarize them, then used the result of this first step to query the collection of items and pages to give relevant and precise answers using Gemini. As a next step, you can try it on your use case and document, try to use a scalable vector database, and deploy these agents as part of your AI app.

我们建立了一个更强大的文档分割流程，它能够识别诸如段落、表格和图表等重要元素，并对它们进行概括。然后，我们利用第一步的结果查询这些元素和页面集合，从而使用 Gemini 提供相关且准确的答案。接下来，您可以在您自己的应用场景和文档上尝试这个流程，可以尝试使用可扩展的向量数据库，并将这些 AI 智能体部署到您的 AI 应用程序中。

Full code and example are available here: https://github.com/CVxTz/document_ai_agents

## 原文

Build a Document AI Pipeline for Any Type of PDF with Gemini
Tables, Images, figures or equations are not problem anymore! Full Code provided.
Youness Mansar
Published in Towards Data Science

Dec 15, 2024

Photo by Matt Noble on Unsplash
Automated document processing is one of the biggest winners of the ChatGPT revolution, as LLMs are able to tackle a wide range of subjects and tasks in a zero-shot setting, meaning without in-domain labeled training data. This has made building AI-powered applications to process, parse, and automatically understand arbitrary documents much easier. Though naive approaches using LLMs are still hindered by non-text context, such as figures, images, and tables, this is what we will try to address in this blog post, with a special focus on PDFs.

At a basic level, PDFs are just a collection of characters, images, and lines along with their exact coordinates. They have no inherent “text” structure and were not built to be processed as text but only to be viewed as is. This is what makes working with them difficult, as text-only approaches fail to capture all the layout and visual elements in these types of documents, resulting in a significant loss of context and information.

One way to bypass this “text-only” limitation is to do heavy pre-processing of the document by detecting tables, images, and layout before feeding them to the LLM. Tables can be parsed to Markdown or JSON, images and figures can be represented by their captions, and the text can be fed as is. However, this approach requires custom models and will still result in some loss of information, so can we do better?

Multimodal LLMs
Most recent large models are now multi-modal, meaning they can process multiple modalities like text, code, and images. This opens the way to a simpler solution to our problem where one model does everything at once. So, instead of captioning images and parsing tables, we can just feed the page as an image and process it as is. Our pipeline will be able to load the PDF, extract each page as an image, split it into chunks (using the LLM), and index each chunk. If a chunk is retrieved, then the full page is included in the LLM context to perform the task. In what follows, we will detail how this can be implemented in practice.

The Pipeline
The pipeline we are implementing is a two-step process. First, we segment each page into significant chunks and summarize each of them. Second, we index chunks once then search the chunks each time we get a request and include the full context with each retrieved chunk in the LLM context.

Step 1: Page Segmentation and Summarization
We extract the pages as images and pass each of them to the multi-modal LLM to segment them. Models like Gemini can understand and process page layout easily:

Tables are identified as one chunk.
Figures form another chunk.
Text blocks are segmented into individual chunks.
…
For each element, the LLM generates a summary than can be embedded and indexed into a vector database.

Step 2: Embedding and Contextual Retrieval
In this tutorial we will use text embedding only for simplicity but one improvement would be to use vision embeddings directly.

Each entry in the database includes:

The summary of the chunk.
The page number where it was found.
A link to the image representation of the full page for added context.
This schema allows for local level searches (at the chunk level) while keeping track of the context (by linking back to the full page). For example, if a search query retrieves an item, the Agent can include the entire page image to provide full layout and extra context to the LLM in order to maximize response quality.

By providing the full image, all the visual cues and important layout information (like images, titles, bullet points… ) and neighboring items (tables, paragraph, …) are available to the LLM at the time of generating a response.

Agents
We will implement each step as a separate, re-usable agent:

The first agent is for parsing, chunking, and summarization. This involves the segmentation of the document into significant chunks, followed by the generation of summaries for each of them. This agent only needs to be run once per PDF to preprocess the document.

The second agent manages indexing, search, and retrieval. This includes inserting the embedding of chunks into the vector database for efficient search. Indexing is performed once per document, while searches can be repeated as many times as needed for different queries.

For both agents, we use Gemini, a multimodal LLM with strong vision understanding abilities.

Parsing and Chunking Agent
The first agent is in charge of segmenting each page into meaningful chunks and summarizing each of them, following these steps:

Step 1: Extracting PDF Pages as Images

We use the pdf2image library. The images are then encoded in Base64 format to simplify adding them to the LLM request.

Here’s the implementation:

from document_ai_agents.document_utils import extract_images_from_pdf
from document_ai_agents.image_utils import pil_image_to_base64_jpeg
from pathlib import Path

class DocumentParsingAgent:
    @classmethod
    def get_images(cls, state):
        """
        Extract pages of a PDF as Base64-encoded JPEG images.
        """
        assert Path(state.document_path).is_file(), "File does not exist"
        # Extract images from PDF
        images = extract_images_from_pdf(state.document_path)
        assert images, "No images extracted"
        # Convert images to Base64-encoded JPEG
        pages_as_base64_jpeg_images = [pil_image_to_base64_jpeg(x) for x in images]
        return {"pages_as_base64_jpeg_images": pages_as_base64_jpeg_images}
extract_images_from_pdf: Extracts each page of the PDF as a PIL image.

pil_image_to_base64_jpeg: Converts the image into a Base64-encoded JPEG format.

Step 2: Chunking and Summarization

Each image is then sent to the LLM for segmentation and summarization. We use structured outputs to ensure we get the predictions in the format we expect:

from pydantic import BaseModel, Field
from typing import Literal
import json
import google.generativeai as genai
from langchain_core.documents import Document

class DetectedLayoutItem(BaseModel):
    """
    Schema for each detected layout element on a page.
    """
    element_type: Literal["Table", "Figure", "Image", "Text-block"] = Field(
        ..., 
        description="Type of detected item. Examples: Table, Figure, Image, Text-block."
    )
    summary: str = Field(..., description="A detailed description of the layout item.")

class LayoutElements(BaseModel):
    """
    Schema for the list of layout elements on a page.
    """
    layout_items: list[DetectedLayoutItem] = []

class FindLayoutItemsInput(BaseModel):
    """
    Input schema for processing a single page.
    """
    document_path: str
    base64_jpeg: str
    page_number: int

class DocumentParsingAgent:
    def __init__(self, model_name="gemini-1.5-flash-002"):
        """
        Initialize the LLM with the appropriate schema.
        """
        layout_elements_schema = prepare_schema_for_gemini(LayoutElements)
        self.model_name = model_name
        self.model = genai.GenerativeModel(
            self.model_name,
            generation_config={
                "response_mime_type": "application/json",
                "response_schema": layout_elements_schema,
            },
        )
    def find_layout_items(self, state: FindLayoutItemsInput):
        """
        Send a page image to the LLM for segmentation and summarization.
        """
        messages = [
            f"Find and summarize all the relevant layout elements in this PDF page in the following format: "
            f"{LayoutElements.schema_json()}. "
            f"Tables should have at least two columns and at least two rows. "
            f"The coordinates should overlap with each layout item.",
            {"mime_type": "image/jpeg", "data": state.base64_jpeg},
        ]
        # Send the prompt to the LLM
        result = self.model.generate_content(messages)
        data = json.loads(result.text)
        
        # Convert the JSON output into documents
        documents = [
            Document(
                page_content=item["summary"],
                metadata={
                    "page_number": state.page_number,
                    "element_type": item["element_type"],
                    "document_path": state.document_path,
                },
            )
            for item in data["layout_items"]
        ]
        return {"documents": documents}
The LayoutElements schema defines the structure of the output, with each layout item type (Table, Figure, … ) and its summary.

Step 3: Parallel Processing of Pages

Pages are processed in parallel for speed. The following method creates a list of tasks to handle all the page image at once since the processing is io-bound:

from langgraph.types import Send

class DocumentParsingAgent:
    @classmethod
    def continue_to_find_layout_items(cls, state):
        """
        Generate tasks to process each page in parallel.
        """
        return [
            Send(
                "find_layout_items",
                FindLayoutItemsInput(
                    base64_jpeg=base64_jpeg,
                    page_number=i,
                    document_path=state.document_path,
                ),
            )
            for i, base64_jpeg in enumerate(state.pages_as_base64_jpeg_images)
        ]
Each page is sent to the find_layout_items function as an independent task.

Full workflow

The agent’s workflow is built using a StateGraph, linking the image extraction and layout detection steps into a unified pipeline ->

from langgraph.graph import StateGraph, START, END

class DocumentParsingAgent:
    def build_agent(self):
        """
        Build the agent workflow using a state graph.
        """
        builder = StateGraph(DocumentLayoutParsingState)
        
        # Add nodes for image extraction and layout item detection
        builder.add_node("get_images", self.get_images)
        builder.add_node("find_layout_items", self.find_layout_items)
        # Define the flow of the graph
        builder.add_edge(START, "get_images")
        builder.add_conditional_edges("get_images", self.continue_to_find_layout_items)
        builder.add_edge("find_layout_items", END)
        
        self.graph = builder.compile()
To run the agent on a sample PDF we do:

if __name__ == "__main__":
    _state = DocumentLayoutParsingState(
        document_path="path/to/document.pdf"
    )
    agent = DocumentParsingAgent()
    
    # Step 1: Extract images from PDF
    result_images = agent.get_images(_state)
    _state.pages_as_base64_jpeg_images = result_images["pages_as_base64_jpeg_images"]
    
    # Step 2: Process the first page (as an example)
    result_layout = agent.find_layout_items(
        FindLayoutItemsInput(
            base64_jpeg=_state.pages_as_base64_jpeg_images[0],
            page_number=0,
            document_path=_state.document_path,
        )
    )
    # Display the results
    for item in result_layout["documents"]:
        print(item.page_content)
        print(item.metadata["element_type"])
This results in a parsed, segmented, and summarized representation of the PDF, which is the input of the second agent we will build next.

RAG Agent
This second agent handles the indexing and retrieval part. It saves the documents of the previous agent into a vector database and uses the result for retrieval. This can be split into two seprate steps, indexing and retrieval.

Step 1: Indexing the Split Document

Using the summaries generated, we vectorize them and save them in a ChromaDB database:

class DocumentRAGAgent:
    def index_documents(self, state: DocumentRAGState):
        """
        Index the parsed documents into the vector store.
        """
        assert state.documents, "Documents should have at least one element"
        # Check if the document is already indexed
        if self.vector_store.get(where={"document_path": state.document_path})["ids"]:
            logger.info(
                "Documents for this file are already indexed, exiting this node"
            )
            return  # Skip indexing if already done
        # Add parsed documents to the vector store
        self.vector_store.add_documents(state.documents)
        logger.info(f"Indexed {len(state.documents)} documents for {state.document_path}")
The index_documents method embeds the chunk summaries into the vector store. We keep metadata such as the document path and page number for later use.

Step 2: Handling Questions

When a user asks a question, the agent searches for the most relevant chunks in the vector store. It retrieves the summaries and corresponding page images for contextual understanding.

class DocumentRAGAgent:
    def answer_question(self, state: DocumentRAGState):
        """
        Retrieve relevant chunks and generate a response to the user's question.
        """
        # Retrieve the top-k relevant documents based on the query
        relevant_documents: list[Document] = self.retriever.invoke(state.question)

        # Retrieve corresponding page images (avoid duplicates)
        images = list(
            set(
                [
                    state.pages_as_base64_jpeg_images[doc.metadata["page_number"]]
                    for doc in relevant_documents
                ]
            )
        )
        logger.info(f"Responding to question: {state.question}")
        # Construct the prompt: Combine images, relevant summaries, and the question
        messages = (
            [{"mime_type": "image/jpeg", "data": base64_jpeg} for base64_jpeg in images]
            + [doc.page_content for doc in relevant_documents]
            + [
                f"Answer this question using the context images and text elements only: {state.question}",
            ]
        )
        # Generate the response using the LLM
        response = self.model.generate_content(messages)
        return {"response": response.text, "relevant_documents": relevant_documents}
The retriever queries the vector store to find the chunks most relevant to the user’s question. We then build the context for the LLM (Gemini), which combines text chunks and images in order to generate a response.

The full agent Workflow

The agent workflow has two stages, an indexing stage and a question answering stage:

class DocumentRAGAgent:
    def build_agent(self):
        """
        Build the RAG agent workflow.
        """
        builder = StateGraph(DocumentRAGState)
        # Add nodes for indexing and answering questions
        builder.add_node("index_documents", self.index_documents)
        builder.add_node("answer_question", self.answer_question)
        # Define the workflow
        builder.add_edge(START, "index_documents")
        builder.add_edge("index_documents", "answer_question")
        builder.add_edge("answer_question", END)
        self.graph = builder.compile()
Example run

if __name__ == "__main__":
    from pathlib import Path

  # Import the first agent to parse the document
    from document_ai_agents.document_parsing_agent import (
        DocumentLayoutParsingState,
        DocumentParsingAgent,
    )
    # Step 1: Parse the document using the first agent
    state1 = DocumentLayoutParsingState(
        document_path=str(Path(__file__).parents[1] / "data" / "docs.pdf")
    )
    agent1 = DocumentParsingAgent()
    result1 = agent1.graph.invoke(state1)
    # Step 2: Set up the second agent for retrieval and answering
    state2 = DocumentRAGState(
        question="Who was acknowledged in this paper?",
        document_path=str(Path(__file__).parents[1] / "data" / "docs.pdf"),
        pages_as_base64_jpeg_images=result1["pages_as_base64_jpeg_images"],
        documents=result1["documents"],
    )
    agent2 = DocumentRAGAgent()
    # Index the documents
    agent2.graph.invoke(state2)
    # Answer the first question
    result2 = agent2.graph.invoke(state2)
    print(result2["response"])
    # Answer a second question
    state3 = DocumentRAGState(
        question="What is the macro average when fine-tuning on PubLayNet using M-RCNN?",
        document_path=str(Path(__file__).parents[1] / "data" / "docs.pdf"),
        pages_as_base64_jpeg_images=result1["pages_as_base64_jpeg_images"],
        documents=result1["documents"],
    )
    result3 = agent2.graph.invoke(state3)
    print(result3["response"])
With this implementation, the pipeline is complete for document processing, retrieval, and question answering.

Example: Using the Document AI Pipeline
Let’s walk through a practical example using the document LLM & Adaptation.pdf , a set of 39 slides containing text, equations, and figures (CC BY 4.0).

Step 1: Parsing and summarizing the Document (Agent 1)
Execution Time: Parsing the 39-page document took 29 seconds.
Result: Agent 1 produces an indexed document consisting of chunk summaries and base64-encoded JPEG images of each page.
Step 2: Questioning the Document (Agent 2)
We ask the following question:
“Explain LoRA, give the relevant equations”

Result:
Retrieved pages:


Source: LLM & Adaptation.pdf License CC-BY
Response from the LLM

Image by author.
The LLM was able to include equations and figures into its response by taking advantage of the visual context in generating a coherent and correct response based on the document.

Conclusion
In this quick tutorial, we saw how you can take your document AI processing pipeline a step further by leveraging the multi-modality of recent LLMs and using the full visual context available in each document, hopefully improving the quality of outputs that you are able to get from either your information extraction or RAG pipeline.

We built a stronger document segmentation step that is able to detect the important items like paragraphs, tables, and figures and summarize them, then used the result of this first step to query the collection of items and pages to give relevant and precise answers using Gemini. As a next step, you can try it on your use case and document, try to use a scalable vector database, and deploy these agents as part of your AI app.

Full code and example are available here : https://github.com/CVxTz/document_ai_agents