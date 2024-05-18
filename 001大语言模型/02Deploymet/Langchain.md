### 资源

[langchain-ai/langchain: 🦜🔗 Build context-aware reasoning applications](https://github.com/langchain-ai/langchain)

### 部署记录

安装依赖包：

pip install langchain

安装 OpenAI sdk：

pip install -U langchain-openai


### 跑模型记录

#### 2024-05-11

```py

```

gemini

```py
\# -*- coding:utf-8 -*-
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough
import time, os
import api_key as api
import common_tools as common_tools

api_key = api.gemini_api_key()
\# 将API Key保存为环境变量
os.environ["GOOGLE_API_KEY"] = api_key
model_name='gemini-1.5-flash-latest'

model = ChatGoogleGenerativeAI(
    model=model_name
)

output_parser = StrOutputParser()

def translate_once(prompt, origin_content):
    chain = prompt | model | output_parser
    response = chain.invoke({"input": origin_content})
    out_content = common_tools.extract_translation(response)
    out_content = common_tools.modify_text(out_content)
    result = out_content
    # 使用format()方法拼接字符串并加入换行符
    # result = "{}\n\n{}".format(origin_content, out_content)
    return result

\# 步骤二：处理内容
def process_chunks(prompt, chunks):
    processed_chunks = []
    for chunk in chunks:
        modified_chunk = translate_once(prompt, chunk)
        processed_chunks.append(modified_chunk)
    return processed_chunks

def merge_and_save_chunks(chunks, filename):
    merged_text = '\n\n'.join(chunks)
    with open(filename, 'w', encoding='utf-8') as file:
        file.write(merged_text)

def translate():
    prompt_content = common_tools.read_file('./translate_prompt.md')
    origin_content = common_tools.read_file('/Users/Daglas/Desktop/input.md')
    prompt = ChatPromptTemplate.from_messages([
        ("system", prompt_content),
        ("user", "{input}")
    ])
    chunks = common_tools.split_text_by_length(origin_content, 2000)
    processed_chunks = process_chunks(prompt, chunks)
    merge_and_save_chunks(processed_chunks, '/Users/Daglas/Desktop/output.md')

start_time = time.time()
print('waiting...\n')
translate()
end_time = time.time()
print('Time Used: ' + str((end_time - start_time)/60) + 'min')
```

#### 2024-05-14

openai

```py
\# -*- coding:utf-8 -*-
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough
import time, os
import api_key as api
import common_tools as common_tools

api_key = api.openai_api_key()
\# 将API Key保存为环境变量
os.environ["OPENAI_API_KEY"] = api_key
model_name='gpt-4o'

model = ChatOpenAI(
    model_name=model_name,
    streaming=True
)

output_parser = StrOutputParser()

def translate_once(prompt, origin_content):
    chain = prompt | model | output_parser
    response = chain.invoke({"input": origin_content})
    out_content = common_tools.extract_translation(response)
    out_content = common_tools.modify_text(out_content)
    result = out_content
    # 使用format()方法拼接字符串并加入换行符
    # result = "{}\n\n{}".format(origin_content, out_content)
    return result

\# 步骤二：处理内容
def process_chunks(prompt, chunks):
    processed_chunks = []
    for chunk in chunks:
        modified_chunk = translate_once(prompt, chunk)
        processed_chunks.append(modified_chunk)
    return processed_chunks

def merge_and_save_chunks(chunks, filename):
    merged_text = '\n\n'.join(chunks)
    with open(filename, 'w', encoding='utf-8') as file:
        file.write(merged_text)

def translate():
    prompt_content = common_tools.read_file('./translate_prompt.md')
    origin_content = common_tools.read_file('/Users/Daglas/Desktop/input.md')
    prompt = ChatPromptTemplate.from_messages([
        ("system", prompt_content),
        ("user", "{input}")
    ])
    chunks = common_tools.split_text_by_length(origin_content, 2000)
    processed_chunks = process_chunks(prompt, chunks)
    merge_and_save_chunks(processed_chunks, '/Users/Daglas/Desktop/output.md')

start_time = time.time()
print('waiting...\n')
translate()
end_time = time.time()
print('Time Used: ' + str((end_time - start_time)/60) + 'min')
```


#### 2024-05-11

```py
from langchain_community.document_loaders import TextLoader
from langchain.text_splitter import CharacterTextSplitter
from langchain_community.vectorstores import Chroma
from langchain_openai.embeddings import OpenAIEmbeddings

loader = TextLoader("/Users/Daglas/Downloads/20230705舒伟杰培训HAZOP.md")
docs = loader.load()

text_splitter = CharacterTextSplitter(
    separator="\n\n",
    chunk_size=500,
    chunk_overlap=200,
    length_function=len,
    is_separator_regex=False,
)

texts = text_splitter.split_documents(docs)

\# save to disk
vectorstore = Chroma.from_documents(
    documents=texts,
    embedding=OpenAIEmbeddings(),
    persist_directory="./chroma_db"
)
```


```py
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnableParallel, RunnablePassthrough
from langchain_openai.embeddings import OpenAIEmbeddings
from langchain_community.vectorstores import Chroma
import os
import api_key as api

os.environ["OPENAI_API_KEY"] = api.openai_api_key()

\# load from disk
vectorstore = Chroma(
        persist_directory="./chroma_db",
        embedding_function=OpenAIEmbeddings(),)

retriever = vectorstore.as_retriever(search_kwargs={"k": 3})

api_key = api.deepseek_api_key()
base_url= 'https://api.deepseek.com/v1'
model_name='deepseek-chat'

template = """Answer the question based only on the following context:
{context}

Question: {question}
"""

prompt = ChatPromptTemplate.from_template(template)

model = ChatOpenAI(
    base_url=base_url,
    api_key=api_key,
    model_name=model_name,
    streaming=True
)

output_parser = StrOutputParser()

setup_and_retrieval = RunnableParallel(
    {"context": retriever, "question": RunnablePassthrough()}
)

context_and_question = setup_and_retrieval.invoke("什么是 HAZOP 分析，结合实际案例详细讲解，一步一步来")
print(context_and_question)

chain = setup_and_retrieval | prompt | model | output_parser

response = chain.stream("什么是 HAZOP 分析，结合实际案例详细讲解，一步一步来")
for value in response:
    print(value, end='', flush=True)
```



```py
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnableParallel, RunnablePassthrough
from langchain_openai.embeddings import OpenAIEmbeddings
from langchain_community.vectorstores import Chroma
import os
import api_key as api

os.environ["OPENAI_API_KEY"] = api.openai_api_key()

vectorstore = Chroma.from_texts(
    ["harrison worked at kensho", "bears like to eat honey"],
    embedding=OpenAIEmbeddings(),
)
retriever = vectorstore.as_retriever()

api_key = api.deepseek_api_key()
base_url= 'https://api.deepseek.com/v1'
model_name='deepseek-chat'

template = """Answer the question based only on the following context:
{context}

Question: {question}
"""

prompt = ChatPromptTemplate.from_template(template)

llm = ChatOpenAI(
    base_url=base_url,
    api_key=api_key,
    model_name=model_name,
    streaming=True
)

output_parser = StrOutputParser()

setup_and_retrieval = RunnableParallel(
    {"context": retriever, "question": RunnablePassthrough()}
)

chain = setup_and_retrieval | prompt | llm | output_parser

response = chain.stream("where did harrison work?")
for value in response:
    print(value, end='', flush=True)
```


```py
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnableParallel, RunnablePassthrough
from langchain_openai.embeddings import OpenAIEmbeddings
from langchain_community.vectorstores import Chroma
import os
import api_key as api

os.environ["OPENAI_API_KEY"] = api.openai_api_key()

vectorstore = Chroma.from_texts(
    ["harrison worked at kensho", "bears like to eat honey"],
    embedding=OpenAIEmbeddings(),
)
retriever = vectorstore.as_retriever()

api_key = api.deepseek_api_key()
base_url= 'https://api.deepseek.com/v1'
model_name='deepseek-chat'

template = """Answer the question based only on the following context:
{context}

Question: {question}
"""

prompt = ChatPromptTemplate.from_template(template)

llm = ChatOpenAI(
    base_url=base_url,
    api_key=api_key,
    model_name=model_name,
    streaming=True
)

output_parser = StrOutputParser()

setup_and_retrieval = RunnableParallel(
    {"context": retriever, "question": RunnablePassthrough()}
)

chain = setup_and_retrieval | prompt | llm | output_parser

chain.invoke("where did harrison work?")
```


#### 2024-05-08


```py
import importlib
import api_key as api

\# 重新加载api_key模块
importlib.reload(api)

api_key = api.deepseek_api_key()
translate_prompt = api.read_file('./translate_prompt.md')
print(translate_prompt)
```


```py
import api_key as api
from langchain_openai import ChatOpenAI
from langchain_core.output_parsers import StrOutputParser

api_key = api.deepseek_api_key()
base_url= 'https://api.deepseek.com/v1'
model_name='deepseek-chat'

prompt = ChatPromptTemplate.from_messages([
    ("system", "You are a helpful AI assistant."),
    ("user", "{input}")
])

llm = ChatOpenAI(
    base_url=base_url,
    api_key=api_key,
    model_name=model_name,
    streaming=True
)

output_parser = StrOutputParser()

chain = prompt | llm | output_parser
response = chain.stream({"input": "世界轴心时代的四位圣人"})

for value in response:
    print(value, end='', flush=True)
```



```py
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser

base_url= 'http://192.168.10.109:11434/v1'
model_name='qwen:110b'

prompt = ChatPromptTemplate.from_messages([
    ("system", "You are a helpful AI assistant."),
    ("user", "{input}")
])

llm = ChatOpenAI(
    base_url=base_url,
    model_name=model_name,
    streaming=True
)

output_parser = StrOutputParser()

chain = prompt | llm | output_parser
response = chain.stream({"input": "世界轴心时代的四位圣人"})

for value in response:
    print(value, end='', flush=True)
```


```py
import api_key as api
from langchain_openai import ChatOpenAI
from langchain_core.output_parsers import StrOutputParser

api_key = api.deepseek_api_key()
base_url= 'https://api.deepseek.com/v1'
model_name='deepseek-chat'

llm = ChatOpenAI(
    base_url=base_url,
    api_key=api_key,
    model_name=model_name,
    streaming=True
)

output_parser = StrOutputParser()

chain = llm | output_parser
response = chain.stream("世界轴心时代的四位圣人")

for value in response:
    print(value, end='', flush=True)
```

---

```py
import os
import api_key as api
from langchain_openai import ChatOpenAI
from langchain_core.output_parsers import StrOutputParser
from IPython.display import Markdown

os.environ["OPENAI_API_KEY"] = api.openai_api_key()

llm = ChatOpenAI(
    streaming=True
)
output_parser = StrOutputParser()

chain = llm | output_parser
response = chain.stream("世界轴心时代的四位圣人")

for value in response:
    print(value, end='', flush=True)
```

---

```py
import os
import api_key as api
from langchain_openai import ChatOpenAI
from langchain_core.output_parsers import StrOutputParser
from IPython.display import Markdown

os.environ["OPENAI_API_KEY"] = api.openai_api_key()

llm = ChatOpenAI(
    streaming=True
)
output_parser = StrOutputParser()

chain = llm | output_parser
output = chain.invoke("世界轴心时代的四位圣人")
display(Markdown(output))
```

### Jupyter Notebook 中实验

1、先激活 llama 虚拟环境。

2、安装 Jupyter Notebook 和 ipykernel。

pip install notebook ipykernel

3、添加虚拟环境到 Jupyter Notebook 内核列表中。

python3.10 -m ipykernel install --user --name=llama --display-name="Python (llama)"

4、启动。

jupyter notebook

### 问题汇总

1、Jupyter Notebook 里没法用 llama 虚拟环境。

GPT-4 回复的解决方案：

在虚拟环境中安装 Jupyter 和 ipykernel：确保虚拟环境激活后，安装 Jupyter Notebook 和 ipykernel：

pip install notebook ipykernel

添加虚拟环境到 Jupyter Notebook 内核列表中：安装完 ipykernel 后，你需要创建一个内核指向你的虚拟环境，这样 Jupyter Notebook 就可以使用这个环境了。

python3.10 -m ipykernel install --user --name=llama --display-name="Python (llama)"

这里的 --name 是你为内核指定的标识，--display-name 是在 Jupyter 中显示的名称。

注意：这里必须用 python3.10 -m ipykernel 命令，GPT-4 回复里的 python -m ipykernel 命令无效的，在 Notebook 用 pip list 看不到已经安装的 langchain 包，改成 python3.10 解决的。

启动 Jupyter Notebook：现在可以启动 Jupyter Notebook 了：

jupyter notebook

在 Jupyter 中切换到虚拟环境：在 Jupyter Notebook 中，创建新的笔记本或打开一个已有的笔记本，在笔记本的右上角找到内核选择菜单，选择之前创建的 "Python (myenv)" 内核。