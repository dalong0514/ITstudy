[weaviate/Verba: Retrieval Augmented Generation (RAG) chatbot powered by Weaviate](https://github.com/weaviate/Verba?tab=readme-ov-file)

### 部署

1、env 环境配置文件。

在系统给的文件基础上修改。

/Users/Daglas/dalong.llm/Verba/goldenverba/.env.example

/Users/Daglas/dalong.llm/Verba/.env

注意事项就是 ollama 的东西：

OLLAMA_URL=http://192.168.5.25:11434
OLLAMA_MODEL=qwen:110b

2、跑 docker 服务。

回到项目的根目录下：

/Users/Daglas/dalong.llm/Verba/

跑下面命令。

docker compose --env-file .env up -d

3、直接用 docker 镜像部署。

docker compose stop

5、浏览器里使用。

http://localhost:8000/

### 问题汇总

1、网络的问题，没法直接访问 OpenAI 的 API，但直接用本地 ollama 的话，env 文件里只能设置一个模型文件，但是嵌入模型文件没法单独设置，只能用一个本地模型，比如 qwen:110b，跑起来很慢，这样就没啥意义了。

此项目暂时搁置。