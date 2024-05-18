### 跑本地的 llm

[ollama/ollama: Get up and running with Llama 2, Mistral, Gemma, and other large language models.](https://github.com/ollama/ollama)

Large language model runner

Usage:
  ollama [flags]
  ollama [command]

Available Commands:
  serve       Start ollama
  create      Create a model from a Modelfile
  show        Show information for a model
  run         Run a model
  pull        Pull a model from a registry
  push        Push a model to a registry
  list        List models
  cp          Copy a model
  rm          Remove a model
  help        Help about any command

Flags:
  -h, --help      help for ollama
  -v, --version   Show version information

  
ollama run llama2

### 问题汇总

跑本地 ollama 模型。

模块的后端接口填下面的 URL 时，报错：

http://localhost:11434

An error occurred during credentials validation: HTTPConnectionPool(host='localhost', port=11434): Max retries exceeded with url: /api/chat

核心问题：

dify 的 web 前端监听不到 ollama 本地起的模块后端接口。还好之前有跑 llama.cpp + fastgpt 的经验。解决过程中有 2 个关键点：

1、本地 ollama 模块后端暴露出来。

[Ollama | English | Dify](https://docs.dify.ai/tutorials/model-configuration/ollama)

If Ollama is run as a macOS application, environment variables should be set using launchctl:

For each environment variable, call launchctl setenv.

launchctl setenv OLLAMA_HOST "0.0.0.0"

Restart Ollama application.

2、仅仅做了第一步还不行，填 http://localhost:11434 或者 http://127.0.0,1:11434 都会报错。

shell 里通过 ifconfig 查到本地的 ip 地址。改成当前本地的地址：

http://192.168.10.108:11434


### 本地模型文件的存储地址

/Users/Daglas/.ollama/models/blobs/sha256-8934d96d3f08982e95922b2b7a2c626a1fe873d7c3b06e8e56d7bc0a1fef9246

### 转化本地的模型文件

之前看官网文档根本没 get 到要点，其实是要新建一个文件，把本地模型的文件放到那个文件里，然后用 ollama 去执行那个文件。

[How to run .gguf - Model in Ollama? : r/ollama](https://www.reddit.com/r/ollama/comments/1al30ut/how_to_run_gguf_model_in_ollama/)

1、本地新建一个文件名为 Modelfile 的文件。

2、路径写到文件里。

FROM /Users/Daglas/dalong.datasets/qwen1_5-72b-chat-q5_k_m.gguf

3、创建 ollama 模型文件。

ollama create qwen1_5-72b-chat-q5_k_m -f Modelfile

4、跑模型。

ollama run qwen1_5-72b-chat-q5_k_m

补充：ollama 嵌入在 Dify 里使用时，只要 mac 上运行了 ollama，那么无需用 run 跑模型，很方便，用起来真爽。（2024-04-12）

---

Import from GGUF

Ollama supports importing GGUF models in the Modelfile:

01 Create a file named Modelfile, with a FROM instruction with the local filepath to the model you want to import.

举例：

FROM ./vicuna-33b.Q4_0.gguf

FROM ./downloads/mistrallite.Q4_K_M.gguf

02 Create the model in Ollama

ollama create example -f Modelfile

ollama create mistrallite -f Modelfile

03 Run the model

ollama run example