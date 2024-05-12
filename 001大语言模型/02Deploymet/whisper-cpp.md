### 01. 信息资源

[ggerganov/whisper.cpp: Port of OpenAI's Whisper model in C/C++](https://github.com/ggerganov/whisper.cpp)

下载模型文件：

[ggerganov/whisper.cpp at main](https://huggingface.co/ggerganov/whisper.cpp/tree/main)

[whisper-large-v3 · 模型库](https://www.modelscope.cn/models/AI-ModelScope/whisper-large-v3/summary)

git lfs install
git clone https://www.modelscope.cn/AI-ModelScope/whisper-large-v3.git

### 02. 操作记录

在项目主目录下先生成相关组件：

make

然后再跑模型：


./main -oj -l zh -m /Users/Daglas/dalong.datasets/ggml-large-v3.bin -f /Users/Daglas/Desktop/20200526电气培训.wav

./main -oj -l auto -m /Users/Daglas/dalong.datasets/ggml-large-v3.bin -f /Users/Daglas/Desktop/20200526电气培训.wav

./main -oj -l auto -m /Users/Daglas/dalong.datasets/ggml-large-v3-q5_0.bin -f /Users/Daglas/Desktop/20200526电气培训.wav






1、构建。

在根目录下直接运行命令：

make

2、先转源音频文件。

ffmpeg -i input.mp3 -ar 16000 -ac 1 -c:a pcm_s16le output.wav

真是意外之喜，ffmpeg 竟然可以直接转 mkv 视频格式到音频 wav 格式，太赞了。

ffmpeg -i input.mkv -ar 16000 -ac 1 -c:a pcm_s16le output.wav

3、转录。

./main -m /Users/Daglas/dalong.datasets/ggml-large-v3.bin -f /Users/Daglas/Desktop/output.wav

./main -m /Users/Daglas/dalong.datasets/ggml-large-v3.bin -f samples/jfk.wav

./main -m /Users/Daglas/dalong.datasets/ggml-large-v3.bin -f samples/jfk.wav -of /Users/Daglas/Desktop/output.txt

./main -m /Users/Daglas/dalong.datasets/ggml-large-v3.bin -f samples/jfk.wav --output-file /Users/Daglas/Desktop/output.txt

./main -m /Users/Daglas/dalong.datasets/ggml-large-v3.bin -oj /Users/Daglas/Desktop/xijingping.json -f samples/jfk.wav


./main -m /Users/Daglas/dalong.datasets/ggml-large-v3.bin -of xijingping.txt -f samples/jfk.wav


./main -m /Users/Daglas/dalong.datasets/ggml-large-v3.bin -oj /Users/Daglas/Desktop/xijingping.json -f /Users/Daglas/Desktop/output.wav

./main -m /Users/Daglas/dalong.datasets/ggml-large-v3.bin -oj -f /Users/Daglas/Desktop/output.wav


./main -m /Users/Daglas/dalong.datasets/ggml-large-v3-q5_0.bin -oj -f /Users/Daglas/Desktop/output.wav


./main -m models/ggml-base.en.bin -f samples/jfk.wav



mkdir models/whisper-medium
python models/convert-pt-to-ggml.py ~/.cache/whisper/medium.pt ~/path/to/repo/whisper/ ./models/whisper-medium
mv ./models/whisper-medium/ggml-model.bin models/ggml-medium.bin
rmdir models/whisper-medium

2023-12-09

目前还是没跑通

### 03. 问题汇总

2024-05-12

1、不能将音频转为简化版的。

ffmpeg -i /Users/Daglas/Downloads/20240512ChatGPT提示词十级技巧从新手到专家.mp4 -ac 1 -sample_fmt s16 /Users/Daglas/Desktop/output.wav

上面是简化版的，需要转高音质版的：

ffmpeg -i /Users/Daglas/Downloads/20240512ChatGPT提示词十级技巧从新手到专家.mp4 -ar 16000 -ac 1 -c:a pcm_s16le /Users/Daglas/Desktop/output.wav




