### 记录

[首页 · 文档中心](https://www.modelscope.cn/docs/%E9%A6%96%E9%A1%B5)

2023-11-26

1、部署 chatglm3-6b。

[chatglm3-6b · 模型库](https://www.modelscope.cn/models/ZhipuAI/chatglm3-6b/summary)

```py
import os, time
from modelscope import AutoTokenizer, AutoModel, snapshot_download


def chatglm_text():
    model_dir = snapshot_download("ZhipuAI/chatglm3-6b", revision = "v1.0.0")
    tokenizer = AutoTokenizer.from_pretrained(model_dir, trust_remote_code=True)
    model = AutoModel.from_pretrained(model_dir, trust_remote_code=True).half().cuda()
    model = model.eval()
    response, history = model.chat(tokenizer, "你好", history=[])
    print(response)
    response, history = model.chat(tokenizer, "晚上睡不着应该怎么办", history=history)
    print(response)


if __name__ == '__main__':
    start_time = time.time()
    chatglm_text()
    end_time = time.time()
    print('OK!')
    print('Time Used: ' + str(end_time - start_time) + 's')
```

报错：

```
Traceback (most recent call last):
  File "chatglm_6b.py", line 18, in <module>
    chatglm_text()
  File "chatglm_6b.py", line 8, in chatglm_text
    model = AutoModel.from_pretrained(model_dir, trust_remote_code=True).half().cuda()
  File "/opt/conda/lib/python3.8/site-packages/torch/nn/modules/module.py", line 688, in cuda
    return self._apply(lambda t: t.cuda(device))
  File "/opt/conda/lib/python3.8/site-packages/torch/nn/modules/module.py", line 578, in _apply
    module._apply(fn)
  File "/opt/conda/lib/python3.8/site-packages/torch/nn/modules/module.py", line 578, in _apply
    module._apply(fn)
  File "/opt/conda/lib/python3.8/site-packages/torch/nn/modules/module.py", line 578, in _apply
    module._apply(fn)
  File "/opt/conda/lib/python3.8/site-packages/torch/nn/modules/module.py", line 601, in _apply
    param_applied = fn(param)
  File "/opt/conda/lib/python3.8/site-packages/torch/nn/modules/module.py", line 688, in <lambda>
    return self._apply(lambda t: t.cuda(device))
  File "/opt/conda/lib/python3.8/site-packages/torch/cuda/__init__.py", line 210, in _lazy_init
    raise AssertionError("Torch not compiled with CUDA enabled")
AssertionError: Torch not compiled with CUDA enabled
```

GTT-4：

根据您提供的错误信息，错误发生在尝试将模型转移到CUDA上，但是PyTorch没有编译CUDA支持。这通常意味着您的PyTorch安装没有包括CUDA支持，或者您的系统上没有可用的CUDA驱动程序。

要解决这个问题，您可以尝试以下步骤：

确认您的系统具有NVIDIA GPU，并且已安装CUDA驱动程序。
确保您安装了适合您CUDA版本的PyTorch版本。您可以从PyTorch官方网站上找到安装指令。
如果您的系统不支持CUDA，您需要修改代码以使用CPU进行模型的加载和运行。
如果您不确定如何进行，可以提供更多信息，例如您的系统配置和您当前安装的PyTorch版本，以便我可以提供更具体的建议。

修改后的代码：

```py
import os, time
from modelscope import AutoTokenizer, AutoModel, snapshot_download

def chatglm_text():
    model_dir = snapshot_download("ZhipuAI/chatglm3-6b", revision="v1.0.0")
    tokenizer = AutoTokenizer.from_pretrained(model_dir, trust_remote_code=True)
    
    # Remove .half() and .cuda() for CPU compatibility
    model = AutoModel.from_pretrained(model_dir, trust_remote_code=True).float()
    
    model = model.eval()
    response, history = model.chat(tokenizer, "你好", history=[])
    print(response)
    response, history = model.chat(tokenizer, "晚上睡不着应该怎么办", history=history)
    print(response)

if __name__ == '__main__':
    start_time = time.time()
    chatglm_text()
    end_time = time.time()
    print('OK!')
    print('Time Used: ' + str(end_time - start_time) + 's')
```

目前还是跑不起来，怀疑还是硬件不足的原因，待新 mac 到后做验证。（2023-11-26）

2023-08-15

1、跑模型语音转文字。

[Paraformer语音识别-中文-通用-16k-离线-large-pytorch · 模型库](https://www.modelscope.cn/models/damo/speech_paraformer-large_asr_nat-zh-cn-16k-common-vocab8404-pytorch/summary)

在 model space 里跑模型很简单，只需要写一个 Python 文件，跑的时候会在 model space 镜像里自动安装对应的模型。

```
import os, time
from modelscope.pipelines import pipeline
from modelscope.utils.constant import Tasks


def audio_to_text():
    inference_pipeline = pipeline(
        task=Tasks.auto_speech_recognition,
        model='damo/speech_paraformer-large-vad-punc_asr_nat-zh-cn-16k-common-vocab8404-pytorch',
        output_dir='./output_dir')

    rec_result = inference_pipeline(audio_in='https://forgpt.oss-cn-hangzhou.aliyuncs.com/20230705%E8%88%92%E4%BC%9F%E6%9D%B0%E5%9F%B9%E8%AE%ADHAZOP.m4a?OSSAccessKeyId=LTAI4GHKoH2Z5txaWP3NpNTx&Expires=1701023897&Signature=1VvihORJaA4wk%2FUmw9FQ83N9WBM%3D')

if __name__ == '__main__':
    start_time = time.time()
    audio_to_text()
    end_time = time.time()
    print('OK!')
    print('Time Used: ' + str(end_time - start_time) + 's')
```

2023-08-11

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


