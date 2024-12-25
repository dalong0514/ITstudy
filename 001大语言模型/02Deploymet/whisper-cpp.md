### 01. 信息资源

[ggerganov/whisper.cpp: Port of OpenAI's Whisper model in C/C++](https://github.com/ggerganov/whisper.cpp)

下载模型文件：

[ggerganov/whisper.cpp at main](https://huggingface.co/ggerganov/whisper.cpp/tree/main)

[whisper-large-v3 · 模型库](https://www.modelscope.cn/models/AI-ModelScope/whisper-large-v3/summary)

git lfs install

git clone https://www.modelscope.cn/AI-ModelScope/whisper-large-v3.git

### 多人音频转录

[whisper : support speaker segmentation (local diarization) of mono audio via tinydiarize by akashmjn · Pull Request #1058 · ggerganov/whisper.cpp](https://github.com/ggerganov/whisper.cpp/pull/1058)

[akashmjn/tinydiarize-whisper.cpp · Hugging Face](https://huggingface.co/akashmjn/tinydiarize-whisper.cpp)

./main -oj -l auto -f /Users/Daglas/Desktop/output.wav -m /Users/Daglas/dalong.modelsets/ggml-small.en-tdrz.bin -tdrz

### 02. 操作记录


2024-12-24

./main -oj -l auto -m /Users/Daglas/dalong.modelsets/ggml-large-v3-turbo.bin -f /Users/Daglas/Desktop/output.wav



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


### 04. 帮助手册

usage: ./main [options] file0.wav file1.wav ...

options:
  -h,        --help              [default] show this help message and exit
  -t N,      --threads N         [4      ] number of threads to use during computation
  -p N,      --processors N      [1      ] number of processors to use during computation
  -ot N,     --offset-t N        [0      ] time offset in milliseconds
  -on N,     --offset-n N        [0      ] segment index offset
  -d  N,     --duration N        [0      ] duration of audio to process in milliseconds
  -mc N,     --max-context N     [-1     ] maximum number of text context tokens to store
  -ml N,     --max-len N         [0      ] maximum segment length in characters
  -sow,      --split-on-word     [false  ] split on word rather than on token
  -bo N,     --best-of N         [5      ] number of best candidates to keep
  -bs N,     --beam-size N       [5      ] beam size for beam search
  -ac N,     --audio-ctx N       [0      ] audio context size (0 - all)
  -wt N,     --word-thold N      [0.01   ] word timestamp probability threshold
  -et N,     --entropy-thold N   [2.40   ] entropy threshold for decoder fail
  -lpt N,    --logprob-thold N   [-1.00  ] log probability threshold for decoder fail
  -debug,    --debug-mode        [false  ] enable debug mode (eg. dump log_mel)
  -tr,       --translate         [false  ] translate from source language to english
  -di,       --diarize           [false  ] stereo audio diarization
  -tdrz,     --tinydiarize       [false  ] enable tinydiarize (requires a tdrz model)
  -nf,       --no-fallback       [false  ] do not use temperature fallback while decoding
  -otxt,     --output-txt        [false  ] output result in a text file
  -ovtt,     --output-vtt        [false  ] output result in a vtt file
  -osrt,     --output-srt        [false  ] output result in a srt file
  -olrc,     --output-lrc        [false  ] output result in a lrc file
  -owts,     --output-words      [false  ] output script for generating karaoke video
  -fp,       --font-path         [/System/Library/Fonts/Supplemental/Courier New Bold.ttf] path to a monospace font for karaoke video
  -ocsv,     --output-csv        [false  ] output result in a CSV file
  -oj,       --output-json       [false  ] output result in a JSON file
  -ojf,      --output-json-full  [false  ] include more information in the JSON file
  -of FNAME, --output-file FNAME [       ] output file path (without file extension)
  -np,       --no-prints         [false  ] do not print anything other than the results
  -ps,       --print-special     [false  ] print special tokens
  -pc,       --print-colors      [false  ] print colors
  -pp,       --print-progress    [false  ] print progress
  -nt,       --no-timestamps     [false  ] do not print timestamps
  -l LANG,   --language LANG     [en     ] spoken language ('auto' for auto-detect)
  -dl,       --detect-language   [false  ] exit after automatically detecting language
             --prompt PROMPT     [       ] initial prompt (max n_text_ctx/2 tokens)
  -m FNAME,  --model FNAME       [models/ggml-base.en.bin] model path
  -f FNAME,  --file FNAME        [       ] input WAV file path
  -oved D,   --ov-e-device DNAME [CPU    ] the OpenVINO device used for encode inference
  -dtw MODEL --dtw MODEL         [       ] compute token-level timestamps
  -ls,       --log-score         [false  ] log best decoder scores of tokens
  -ng,       --no-gpu            [false  ] disable GPU
  --suppress-regex REGEX         [       ] regular expression matching tokens to suppress
  --grammar GRAMMAR              [       ] GBNF grammar to guide decoding
  --grammar-rule RULE            [       ] top-level GBNF grammar rule name
  --grammar-penalty N            [100.0  ] scales down logits of nongrammar tokens

