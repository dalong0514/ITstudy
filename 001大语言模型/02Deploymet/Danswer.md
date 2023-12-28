### 跑起来

镜像跑起来：

docker compose -f docker-compose.dev.yml -p danswer-stack up -d --pull always --force-recreate

镜像停止：

docker compose -f docker-compose.dev.yml -p danswer-stack down

add -v at the end to delete the volumes (containing users and indexed documents)

在末尾添加 -v 以删除卷（包含用户和索引文档）

### 资源

[danswer-ai/danswer: Ask Questions in natural language and get Answers backed by private sources. Connects to tools like Slack, GitHub, Confluence, etc.](https://github.com/danswer-ai/danswer)

[Quickstart - Danswer Documentation --- 快速入门 - Danswer 文档](https://docs.danswer.dev/quickstart)