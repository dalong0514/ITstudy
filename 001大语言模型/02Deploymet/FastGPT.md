### 部署 one-api

戴强做好的 docker 镜像：

1、新建 one-api 的文件夹。

mkdir /Users/Daglas/dalong.llm/one-api

2、跑 docker 镜像。

docker run --name one-api -d --restart always -p 3001:3000 -e TZ=Asia/Shanghai -v /Users/Daglas/dalong.llm/one-api:/data justsong/one-api

### 运行 fastgpt

