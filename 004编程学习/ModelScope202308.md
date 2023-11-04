### 记录

[首页 · 文档中心](https://www.modelscope.cn/docs/%E9%A6%96%E9%A1%B5)

1、在 docker 上安装镜像。

docker pull registry.cn-hangzhou.aliyuncs.com/modelscope-repo/modelscope:ubuntu20.04-py38-torch1.11.0-tf1.15.5-1.8.0

补充：拉完之后，安装官网里的操作。可以做个安装验证：安装成功后，即可使用对应领域模型进行推理，训练等操作。这里我们以 NLP 领域为例。安装后，可执行如下命令，运行中文分词任务，来验证安装是否正确：

python -c "from modelscope.pipelines import pipeline;print(pipeline('word-segmentation')('今天天气不错，适合 出去游玩'))"

1、通过 GitHub 上的仓库，传递文件到镜像容器里，跑了一次前面的安装验证任务。

```py
from modelscope.pipelines import pipeline

word_segmentation = pipeline('word-segmentation')
input_str = '今天天气不错，适合出去游玩'
print(word_segmentation(input_str))
```

### 注意事项

1、开 VPN 跑不了。

开 VPN 的时候，拉镜像拉不不来。同时跑 model 的时候也跑不了，应该是要连阿里的服务器，而阿里的服务器又不能 VPN 的时候连接。


