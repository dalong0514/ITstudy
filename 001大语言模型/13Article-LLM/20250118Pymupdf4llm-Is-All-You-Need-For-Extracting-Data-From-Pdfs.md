## 20250118Pymupdf4llm-Is-All-You-Need-For-Extracting-Data-From-Pdfs

[PyMuPDF4LLM is all You Need for Extracting Data from PDFs | by Shravan Kumar | Medium](https://medium.com/@shravankoninti/pymupdf4llm-is-all-you-need-for-extracting-data-from-pdfs-8cfad33bdfaf)

Shravan Kumar

Nov 2, 2024

This package converts the pages of a PDF to text in Markdown format using PyMuPDF. Standard text and tables are detected, brought in the right reading sequence and then together converted to GitHub-compatible Markdown text.

该工具包使用 PyMuPDF 将 PDF 页面转换为 Markdown 格式的文本。识别标准文本和表格，按照正确的阅读顺序组织，然后统一转换为与 GitHub 兼容的 Markdown 文本。

Header lines are identified via the font size and appropriately prefixed with one or more ‘\#’ tags.

通过字体大小来识别标题行，并用一个或多个 ‘#' 标签作为前缀。

Bold, italic, mono-spaced text and code blocks are detected and formatted accordingly. Similar applies to ordered and unordered lists.

粗体、斜体、等宽文本和代码块会被检测并格式化。同样，有序列表和无序列表也会被处理。

By default, all document pages are processed. If desired, a subset of pages can be specified by providing a list of 0-based page numbers.

默认情况下，会处理所有文档页面。如果需要，可以提供一个从 0 开始的页码列表来指定需要处理的页面子集。

Feature Overview:

特性概览：

Support for pages with multiple text columns.

支持包含多文本列的页面。

Support for image and vector graphics extraction:

支持图像和矢量图形提取：

1 Specify pymupdf4llm.to_markdown("input.pdf", write_images=True). Default is False.

通过 `pymupdf4llm.to_markdown("input.pdf", write_images=True)` 开启此功能，默认值为 `False`。

2 Each image or vector graphic on the page will be extracted and stored as an image named "input.pdf-pno-index.extension" in a folder of your choice. The image extension can be chosen to represent a PyMuPDF-supported image format (for instance "png" or "jpg"), pno is the 0-based page number and index is some sequence number.

页面上的每个图像或矢量图形都将被提取，并以「input.pdf-pno-index.extension」的文件名保存到您指定的文件夹中。图像的扩展名可以是 PyMuPDF 支持的任何图像格式，例如「png」或「jpg」。「pno」代表从 0 开始的页码，「index」代表图像的序号。

3 The image files will have width and height equal to the values on the page. The desired resolution can be chosen via parameter dpi (default: dpi=150).

图像文件的宽度和高度与页面上的尺寸一致。您可以通过 `dpi` 参数设置所需的分辨率，默认值为 `dpi=150`。

4 Any text contained in the images or graphics will be extracted and also become visible as part of the generated image. This behavior can be changed via force_text=False (text only apears as part of the image).

图像或图形中包含的任何文本都将被提取，并显示为图像的一部分。您可以通过设置 `force_text=False` 来改变此行为，使文本仅作为图像内容的一部分出现。

Support for page chunks: Instead of returning one large string for the whole document, a list of dictionaries can be generated: one for each page. Specify data = pymupdf4llm.to_markdown("input.pdf", page_chunks=True). Then, for instance the first item, data[0] will contain a dictionary for the first page with the text and some metadata.

支持页面分块：您可以生成一个字典列表，其中每个字典对应文档中的一页，而不是返回一个包含整个文档内容的长字符串。通过 `data = pymupdf4llm.to_markdown（"input.pdf」，page_chunks=True)` 开启此功能。例如，`data[0]` 将包含第一页的字典，其中包含了文本内容和一些元数据。

Install PyMuPDF4LLM

!pip install pymupdf4llm

This command will automatically install PyMuPDF if required.

Basic Markdown Extraction

```py
import pymupdf4llm
md_text = pymupdf4llm.to_markdown("foo.pdf")
```

Save the Markdown Extraction

```py
\# Now work with the markdown text, e.g. store as a UTF8-encoded file
import pathlib
pathlib.Path("output.md").write_bytes(md_text.encode())
print("Markdown saved to output.md")
```

Extract only specific pages

```py
md_text_pages = pymupdf4llm.to_markdown("patient_data_analysis.pdf", pages=[0])
print(md_text_pages)
```

Image Extraction

```py
md_text_images = pymupdf4llm.to_markdown(
    doc="patient_data_analysis.pdf",
    page_chunks=True,
    write_images=True,
    image_path="images",
    image_format="png",
    dpi=300
)
```

Chunking data and extracting it with metadata

```py
md_text_chunks = pymupdf4llm.to_markdown(
    doc="patient_data_analysis.pdf",
    pages=[0,1],
    page_chunks=True
)
print(md_text_chunks[1])
```

Table Extraction

```py
md_text_tables = pymupdf4llm.to_markdown(
    doc="foo.pdf"  \# data with table
)
print(md_text_tables)
```

Detailed word-by-word extraction

```py
md_text_words = pymupdf4llm.to_markdown(
    doc="patient_data_analysis.pdf",
    pages=[0, 1],
    page_chunks=True,
    write_images=True,
    image_path="images",
    image_format="png",
    dpi=300,
    extract_words=True
)
print(md_text_words[0]['words'][:20])
```

Extracting Data as LlamaIndex Documents

将数据提取为 LlamaIndex 文档

One of the important tasks in LLM work is transforming PDFs into a document format compatible with LlamaIndex (formerly GPT Index). PyMuPDF4LLM simplifies that process.

在进行大语言模型（LLM）相关工作时，一项重要任务是将 PDF 文件转换为 LlamaIndex（之前名为 GPT Index）能够识别的文档格式。PyMuPDF4LLM 可以简化这个过程。

```py
import pymupdf4llm

llama_reader = pymupdf4llm.LlamaMarkdownReader()
llama_docs = llama_reader.load_data("foo.pdf")
print(f"Number of LlamaIndex documents: {len(llama_docs)}")
print(f"Content of first document: {llama_docs[0].text[:500]}")
```

For a fast markdown extraction with good markdown formatting pymupdf4llm seems to be a very good option.

对于快速提取 markdown 格式文本，并保持良好的格式，pymupdf4llm 似乎是一个非常不错的选择。

Other options for PDF-parsing can be checked with marker-pdf, PyPDF2, PyMuPDF, pdfminer.six, Camelot, Tabula, Unstructured and Llama Parse for potential use in a Retrieval-Augmented Generation (RAG) system. I will come up with a comparision of outputs of all the above tools/packages.

其他用于 PDF 解析的工具，例如 marker-pdf、PyPDF2、PyMuPDF、pdfminer.six、Camelot、Tabula、Unstructured 和 Llama Parse，也可以用来评估它们在检索增强生成（Retrieval-Augmented Generation，RAG）系统中的应用潜力。我会对上述所有工具/包的输出结果进行比较。

References:

https://pypi.org/project/pymupdf4llm/

https://medium.com/@pymupdf/introducing-pymupdf4llm-d2c39442f445

## 原文


PyMuPDF4LLM is all You Need for Extracting Data from PDFs
Shravan Kumar

Nov 2, 2024

This package converts the pages of a PDF to text in Markdown format using PyMuPDF. Standard text and tables are detected, brought in the right reading sequence and then together converted to GitHub-compatible Markdown text.

Header lines are identified via the font size and appropriately prefixed with one or more ‘\#’ tags.
Bold, italic, mono-spaced text and code blocks are detected and formatted accordingly. Similar applies to ordered and unordered lists.
By default, all document pages are processed. If desired, a subset of pages can be specified by providing a list of 0-based page numbers.

Feature Overview:
Support for pages with multiple text columns.
Support for image and vector graphics extraction:
Specify pymupdf4llm.to_markdown("input.pdf", write_images=True). Default is False.
Each image or vector graphic on the page will be extracted and stored as an image named "input.pdf-pno-index.extension" in a folder of your choice. The image extension can be chosen to represent a PyMuPDF-supported image format (for instance "png" or "jpg"), pno is the 0-based page number and index is some sequence number.
The image files will have width and height equal to the values on the page. The desired resolution can be chosen via parameter dpi (default: dpi=150).
Any text contained in the images or graphics will be extracted and also become visible as part of the generated image. This behavior can be changed via force_text=False (text only apears as part of the image).
Support for page chunks: Instead of returning one large string for the whole document, a list of dictionaries can be generated: one for each page. Specify data = pymupdf4llm.to_markdown("input.pdf", page_chunks=True). Then, for instance the first item, data[0] will contain a dictionary for the first page with the text and some metadata.

Install PyMuPDF4LLM
!pip install pymupdf4llm
This command will automatically install PyMuPDF if required.

Basic Markdown Extraction
import pymupdf4llm

md_text = pymupdf4llm.to_markdown("foo.pdf")

Save the Markdown Extraction
\# Now work with the markdown text, e.g. store as a UTF8-encoded file
import pathlib
pathlib.Path("output.md").write_bytes(md_text.encode())
print("Markdown saved to output.md")

Extract only specific pages
md_text_pages = pymupdf4llm.to_markdown("patient_data_analysis.pdf", pages=[0])
print(md_text_pages)

Image Extraction
md_text_images = pymupdf4llm.to_markdown(
    doc="patient_data_analysis.pdf",
    page_chunks=True,
    write_images=True,
    image_path="images",
    image_format="png",
    dpi=300
)

Chunking data and extracting it with metadata
md_text_chunks = pymupdf4llm.to_markdown(
    doc="patient_data_analysis.pdf",
    pages=[0,1],
    page_chunks=True
)
print(md_text_chunks[1])

Table Extraction
md_text_tables = pymupdf4llm.to_markdown(
    doc="foo.pdf"  \# data with table
)
print(md_text_tables)

Detailed word-by-word extraction
md_text_words = pymupdf4llm.to_markdown(
    doc="patient_data_analysis.pdf",
    pages=[0, 1],
    page_chunks=True,
    write_images=True,
    image_path="images",
    image_format="png",
    dpi=300,
    extract_words=True
)
print(md_text_words[0]['words'][:20])

Extracting Data as LlamaIndex Documents
One of the important tasks in LLM work is transforming PDFs into a document format compatible with LlamaIndex (formerly GPT Index). PyMuPDF4LLM simplifies that process.

import pymupdf4llm

llama_reader = pymupdf4llm.LlamaMarkdownReader()
llama_docs = llama_reader.load_data("foo.pdf")
print(f"Number of LlamaIndex documents: {len(llama_docs)}")
print(f"Content of first document: {llama_docs[0].text[:500]}")

For a fast markdown extraction with good markdown formatting pymupdf4llm seems to be a very good option.

Other options for PDF-parsing can be checked with marker-pdf, PyPDF2, PyMuPDF, pdfminer.six, Camelot, Tabula, Unstructured and Llama Parse for potential use in a Retrieval-Augmented Generation (RAG) system. I will come up with a comparision of outputs of all the above tools/packages.

References:
https://pypi.org/project/pymupdf4llm/
https://medium.com/@pymupdf/introducing-pymupdf4llm-d2c39442f445