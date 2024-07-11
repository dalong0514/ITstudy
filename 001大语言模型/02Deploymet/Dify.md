[langgenius/dify: Dify is an open-source LLM app development platform. Dify's intuitive interface combines AI workflow, RAG pipeline, agent capabilities, model management, observability features and more, letting you quickly go from prototype to production.](https://github.com/langgenius/dify?tab=readme-ov-file#quick-start)

[欢迎使用 Dify | 中文 | Dify](https://docs.dify.ai/v/zh-hans)

### 部署

1、直接用 docker 镜像部署。

拉完仓库项目后：

cd docker

docker compose up -d

docker compose stop

---

2024-07-10

[Releases · langgenius/dify](https://github.com/langgenius/dify/releases)

01

Back up your customized docker-compose YAML file (optional)

cd docker

cp docker-compose.yaml docker-compose.yaml.$(date +%s).bak

02

Get the latest code from the main branch

git checkout main

git pull origin main

03

Stop the service，Command, please execute in the docker directory

docker compose down

04

Back up data

tar -cvf volumes-$(date +%s).tgz volumes

05

Upgrade services

docker compose up -d



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