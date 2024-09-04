### 01. 信息资源

[MahmoudAshraf97/whisper-diarization: Automatic Speech Recognition with Speaker Diarization based on OpenAI Whisper](https://github.com/MahmoudAshraf97/whisper-diarization)

### 02. 运行跑的记录

目前没跑通。（2024-09-04）

python3.10 diarize_parallel.py -a /Users/Daglas/Desktop/output.wav --device cpu --batch-size 4 --language zh

python3.10 diarize_parallel.py -a /Users/Daglas/Desktop/output.wav --device cpu --batch-size 4 --language en


### 03. 安装部署记录

先建一个独立的虚拟环境 whisper。

pip install cython

\# on MacOS using Homebrew (https://brew.sh/)
brew install ffmpeg

pip install -r requirements.txt

### 03. 问题汇总

2024-09-04

1、报错调不了 huggingface_hub 包里的组件。

cannot import name 'ModelFilter' from 'huggingface_hub' (/Users/Daglas/miniconda3/envs/whisper/lib/python3.10/site-packages/huggingface_hub/__init__.py)

解决方案：

[ImportError: cannot import name 'ModelFilter' from 'huggingface\_hub' while importing from nemo.collections.asr.models import EncDecMultiTaskModel · Issue #9793 · NVIDIA/NeMo](https://github.com/NVIDIA/NeMo/issues/9793)

I guess you could use huggingface-hub==0.23.2, so that it works

卸了安装指定版本的即可。

pip uninstall huggingface_hub
   
pip install huggingface_hub==0.22.0

2、无法自动识别中英文。

python3.10 diarize_parallel.py -a /Users/Daglas/Desktop/output.wav --device cpu

上面命令跑出来的，明明是中文对话，输出的是英文。改成如下命令还是无效。

python3.10 diarize_parallel.py -a /Users/Daglas/Desktop/output.wav --device cpu --batch-size 4 --language zh



