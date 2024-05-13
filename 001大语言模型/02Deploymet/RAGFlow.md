[infiniflow/ragflow: RAGFlow is an open-source RAG (Retrieval-Augmented Generation) engine based on deep document understanding.](https://github.com/infiniflow/ragflow)

RAG Flow：新的 RAG 开源框架

InfiniFlow 开源的项目叫 RAG Flow，有下面这些特点：

RAGFlow 的核心功能是文档的智能解析和管理，支持多种格式，并允许用户使用任何大型语言模型查询他们上传的文档。

RAGFlow 提供了多种智能文档处理模板，以满足不同行业和角色的需求，如会计、人力资源专业人员和研究人员。

它还强调了智能文档处理的可视化和可解释性，允许用户查看文档处理结果，进行比较、修改和查询。

RAGFlow 的一个关键优势是它允许 LLM 以受控方式回答问题，提供了一种理性和基于证据的方法来消除幻觉。

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

### 跑本地的 llm

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


### 部署过程

1、确保 vm.max_map_count 不小于 262144。

首先按文档里的设置没成功，接着为 GPT-4，给的方案也没成功。不过在它的回复里看到如何验证，心想自己的机子设置的默认值应该满足要求，就试了下，看到设置值正好是 262144。

验证设置：为了验证vm.max_map_count是否已正确设置，你可以运行一个临时的Linux容器来检查当前值，如下所示：

docker run --rm -it alpine sysctl vm.max_map_count

2、克隆仓库。

我直接 fork 的。

3、进入 docker 文件夹，利用提前编译好的 Docker 镜像启动服务器：

cd ragflow/docker

chmod +x ./entrypoint.sh

docker compose -f docker-compose-CN.yml up -d

核心镜像文件大约 15 GB，可能需要一定时间拉取。请耐心等待。

4、服务器启动成功后再次确认服务器状态：

docker logs -f ragflow-server

出现以下界面提示说明服务器启动成功：

    ____                 ______ __
   / __ \ ____ _ ____ _ / ____// /____  _      __
  / /_/ // __ `// __ `// /_   / // __ \| | /| / /
 / _, _// /_/ // /_/ // __/  / // /_/ /| |/ |/ /
/_/ |_| \__,_/ \__, //_/    /_/ \____/ |__/|__/
              /____/

 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:9380
 * Running on http://x.x.x.x:9380
 INFO:werkzeug:Press CTRL+C to quit

