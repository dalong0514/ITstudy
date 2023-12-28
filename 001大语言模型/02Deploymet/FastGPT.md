### 运行 fastgpt

跑镜像：

docker compose up -d

停止镜像：

docker compose stop

拉取最新 docker 部署：

docker compose pull


### 部署 one-api

戴强做好的 docker 镜像：

1、新建 one-api 的文件夹。

mkdir /Users/Daglas/dalong.llm/one-api

2、跑 docker 镜像。

docker run --name one-api -d --restart always -p 3001:3000 -e TZ=Asia/Shanghai -v /Users/Daglas/dalong.llm/one-api:/data justsong/one-api

### 资源

[labring/FastGPT: FastGPT is a knowledge-based QA system built on the LLM, offers out-of-the-box data processing and model invocation capabilities, allows for workflow orchestration through Flow visualization!](https://github.com/labring/FastGPT?tab=readme-ov-file)

[Docker Compose 快速部署 | FastGPT](https://doc.fastgpt.in/docs/development/docker/)

### 问题汇总

2023-12-28

1、embedding 时报错。

报错信息：

Traceback (most recent call last):
  File "/Users/Daglas/miniconda3/envs/llama/lib/python3.10/site-packages/uvicorn/protocols/http/httptools_impl.py", line 426, in run_asgi
    result = await app(  # type: ignore[func-returns-value]
requests.exceptions.ChunkedEncodingError: ("Connection broken: InvalidChunkLength(got length b'', 0 bytes read)", InvalidChunkLength(got length b'', 0 bytes read))

解决方案：代理梯子关了就好了。

很奇怪，之前没遇到过。怀疑是更新 fastgpt 版本后出现的问题。

