### 跑模型

备注：发现还是要联网调模型的，怪不得不怎么耗内存。所以要关代理。

cat /Users/Daglas/Desktop/output_dir/1best_recog/text_with_punc > /Users/Daglas/dalong.gpt/rewrite-text/origin_text_1.md

---

2024-12-25

备注 1：funars 升级到新版后，调用命令发生了变化。

备注 2：目前没有跑成功。



funasr --model Whisper-large-v3-turbo /Users/Daglas/Desktop/output.wav --output_dir /Users/Daglas/Desktop/output_dir

funasr ++model=Whisper-large-v3-turbo ++vad_model="fsmn-vad" ++punc_model="ct-punc" ++input=/Users/Daglas/Desktop/output.wav ++output_dir=/Users/Daglas/Desktop/output_dir


funasr ++model=Whisper-large-v3-turbo ++input=/Users/Daglas/Desktop/output.wav ++output_dir=/Users/Daglas/Desktop/output_dir ++dtype=float16

funasr ++model=paraformer-zh ++vad_model="fsmn-vad" ++punc_model="ct-punc" ++input=asr_example_zh.wav


funasr ++model=paraformer-en ++vad_model="fsmn-vad" ++punc_model="ct-punc" ++input=/Users/Daglas/Desktop/output.wav ++output_dir=/Users/Daglas/Desktop/output_dir



funasr ++model=paraformer-en-spk ++input=/Users/Daglas/Desktop/output.wav ++output_dir=/Users/Daglas/Desktop/output_dir


funasr ++model=paraformer-en ++input=/Users/Daglas/Desktop/output.wav ++output_dir=/Users/Daglas/Desktop/output_dir



2024-01-03


funasr --model paraformer-zh-spk /Users/Daglas/Desktop/20240102与吴总交流汇报年度计划.wav --output_dir /Users/Daglas/Desktop/output_dir

cat /Users/Daglas/Desktop/output_dir/1best_recog/text_with_punc > /Users/Daglas/dalong.gpt/rewrite-text/origin_text_1.md



2023-12-28


多人音频：

ffmpeg -i /Users/Daglas/Music/dalong.knowledgeAudio/2023001数智设计/20230803与吴总汇报各专业作业线框架.m4a -ar 16000 -ac 1 -c:a pcm_s16le /Users/Daglas/Music/dalong.knowledgeAudio/2023001数智设计/20230803与吴总汇报各专业作业线框架.wav

funasr --model paraformer-zh-spk /Users/Daglas/Music/dalong.knowledgeAudio/2023001数智设计/20230803与吴总汇报各专业作业线框架.wav --output_dir /Users/Daglas/Desktop/output_dir

单人音频：

funasr --model paraformer-zh /Users/Daglas/Desktop/20200526电气培训.wav --output_dir /Users/Daglas/Desktop/output_dir








### 部署记录





1、安装 funasr。

pip install -U funasr
\# For the users in China, you could install with the command:
\# pip install -U funasr -i https://mirror.sjtu.edu.cn/pypi/web/simple

2、安装 modelscope。

pip install -U modelscope

3、跑 funasr。

开始的时候以为要设本地模型的路径，跑：

funasr --model /Users/Daglas/dalong.datasets/speech_paraformer-large_asr_nat-zh-cn-16k-common-vocab8404-pytorch /Users/Daglas/Desktop/output.wav

发现不行。

也是死马当活马医，直接用了默认的模型名跑：

funasr --model paraformer-zh /Users/Daglas/Desktop/20200526电气培训.wav

发现可以，然后突然联想到之前在 docker 里跑该模块的时候，它是自己先拉模型到本地，然后再跑。

探索了下，果然如此。funasr 会自己拉 paraformer-zh 的模型文件。拉取模型存放的路径如下：

/Users/Daglas/.cache/modelscope/hub/damo

接着是设置导出文件的路径，直接 funasr -h 看帮助文档，设置如下：

funasr --model paraformer-zh /Users/Daglas/Desktop/20200526电气培训.wav --output_dir /Users/Daglas/Desktop/output_dir

然后借助之前 docker 跑该模型的经验，找到了最后的文本内容存在在如下路径：

/Users/Daglas/Desktop/output/1best_recog/text_with_punc

顺便做了个脚本：

cat /Users/Daglas/Desktop/output_dir/1best_recog/text_with_punc > /Users/Daglas/dalong.gpt/rewrite-text/origin_text_1.md

### 资源

[FunASR/README\_zh.md at main · alibaba-damo-academy/FunASR](https://github.com/alibaba-damo-academy/FunASR/blob/main/README_zh.md)

[Installation — FunASR documentation](https://alibaba-damo-academy.github.io/FunASR/en/installation/installation.html)


模型名字	任务详情	训练数据	参数量
paraformer-zh 语音识别，带时间戳输出，非实时	60000小时，中文	220M
paraformer-zh-spk 分角色语音识别，带时间戳输出，非实时	60000小时，中文	220M
paraformer-zh-online 语音识别，实时	60000小时，中文	220M
paraformer-en 语音识别，非实时	50000小时，英文	220M
paraformer-en-spk 语音识别，非实时	50000小时，英文	220M
conformer-en 语音识别，非实时	50000小时，英文	220M
ct-punc 标点恢复	100M，中文与英文	1.1G
fsmn-vad 语音端点检测，实时	5000小时，中文与英文	0.4M
fa-zh 字级别时间戳预测	50000小时，中文	38M

### 问题汇总

1、用多人语音识别模型时报错。

报错信息：

module 'umap' has no attribute 'UMAP'

搜索的解决方案：

[module 'umap' has no attribute 'UMAP' · Issue #828 · lmcinnes/umap --- 模块“umap”没有属性“UMAP”·问题#828·lmcinnes/umap](https://github.com/lmcinnes/umap/issues/828)

from this answer 从这个答案

pip uninstall umap
pip install umap-learn


### 帮助文档

usage: funasr [-h] [--config CONFIG] [--log_level {CRITICAL,ERROR,WARNING,INFO,DEBUG,NOTSET}] [--output_dir OUTPUT_DIR] [--ngpu NGPU] [--njob NJOB] [--gpuid_list GPUID_LIST] [--seed SEED] [--dtype {float16,float32,float64}] [--num_workers NUM_WORKERS]
              [--data_path_and_name_and_type DATA_PATH_AND_NAME_AND_TYPE] [--key_file KEY_FILE] [--hotword HOTWORD] [--allow_variable_data_keys ALLOW_VARIABLE_DATA_KEYS] [--mc MC] [--vad_infer_config VAD_INFER_CONFIG] [--vad_model_file VAD_MODEL_FILE]
              [--punc_infer_config PUNC_INFER_CONFIG] [--punc_model_file PUNC_MODEL_FILE] [--cmvn_file CMVN_FILE] [--asr_train_config ASR_TRAIN_CONFIG] [--asr_model_file ASR_MODEL_FILE] [--sv_model_file SV_MODEL_FILE] [--lm_train_config LM_TRAIN_CONFIG]
              [--lm_file LM_FILE] [--word_lm_train_config WORD_LM_TRAIN_CONFIG] [--word_lm_file WORD_LM_FILE] [--ngram_file NGRAM_FILE] [--model_tag MODEL_TAG] [--beam_search_config BEAM_SEARCH_CONFIG] [--batch_size BATCH_SIZE] [--nbest NBEST] [--beam_size BEAM_SIZE]
              [--penalty PENALTY] [--maxlenratio MAXLENRATIO] [--minlenratio MINLENRATIO] [--ctc_weight CTC_WEIGHT] [--lm_weight LM_WEIGHT] [--ngram_weight NGRAM_WEIGHT] [--streaming STREAMING] [--fake_streaming FAKE_STREAMING] [--full_utt FULL_UTT]
              [--chunk_size CHUNK_SIZE] [--left_context LEFT_CONTEXT] [--right_context RIGHT_CONTEXT] [--display_partial_hypotheses DISPLAY_PARTIAL_HYPOTHESES] [--quantize_asr_model QUANTIZE_ASR_MODEL] [--quantize_modules [QUANTIZE_MODULES ...]]
              [--quantize_dtype {float16,qint8}] [--token_type {char,bpe,None}] [--bpemodel BPEMODEL] [--token_num_relax TOKEN_NUM_RELAX] [--decoding_ind DECODING_IND] [--decoding_mode DECODING_MODE] [--ctc_weight2 CTC_WEIGHT2] [--task_name TASK_NAME] [-m MODEL]
              [-v VAD_MODEL] [-dv DISABLE_VAD] [-p PUNC_MODEL] [-dp DISABLE_PUNC] [--batch_size_token BATCH_SIZE_TOKEN] [--batch_size_token_threshold_s BATCH_SIZE_TOKEN_THRESHOLD_S] [--max_single_segment_time MAX_SINGLE_SEGMENT_TIME]
              input

ASR Decoding

positional arguments:
  input                 input file to transcribe

options:
  -h, --help            show this help message and exit
  --config CONFIG       Give config file in yaml format (default: None)
  --log_level {CRITICAL,ERROR,WARNING,INFO,DEBUG,NOTSET}
                        The verbose level of logging (default: INFO)
  --output_dir OUTPUT_DIR
  --ngpu NGPU           The number of gpus. 0 indicates CPU mode (default: 1)
  --njob NJOB           The number of jobs for each gpu (default: 1)
  --gpuid_list GPUID_LIST
                        The visible gpus (default: )
  --seed SEED           Random seed (default: 0)
  --dtype {float16,float32,float64}
                        Data type (default: float32)
  --num_workers NUM_WORKERS
                        The number of workers used for DataLoader (default: 1)
  --hotword HOTWORD     hotword file path or hotwords seperated by space (default: None)
  --task_name TASK_NAME
                        The decoding mode (default: asr)
  -m MODEL, --model MODEL
                        The asr mode name (default: paraformer-zh)
  -v VAD_MODEL, --vad_model VAD_MODEL
                        vad model name (default: fsmn-vad)
  -dv DISABLE_VAD, --disable_vad DISABLE_VAD
  -p PUNC_MODEL, --punc_model PUNC_MODEL
  -dp DISABLE_PUNC, --disable_punc DISABLE_PUNC
  --batch_size_token BATCH_SIZE_TOKEN
  --batch_size_token_threshold_s BATCH_SIZE_TOKEN_THRESHOLD_S
  --max_single_segment_time MAX_SINGLE_SEGMENT_TIME

Input data related:
  --data_path_and_name_and_type DATA_PATH_AND_NAME_AND_TYPE
  --key_file KEY_FILE
  --allow_variable_data_keys ALLOW_VARIABLE_DATA_KEYS
  --mc MC               MultiChannel input (default: False)

The model configuration related:
  --vad_infer_config VAD_INFER_CONFIG
                        VAD infer configuration (default: None)
  --vad_model_file VAD_MODEL_FILE
                        VAD model parameter file (default: None)
  --punc_infer_config PUNC_INFER_CONFIG
                        PUNC infer configuration (default: None)
  --punc_model_file PUNC_MODEL_FILE
                        PUNC model parameter file (default: None)
  --cmvn_file CMVN_FILE
                        Global CMVN file (default: None)
  --asr_train_config ASR_TRAIN_CONFIG
                        ASR training configuration (default: None)
  --asr_model_file ASR_MODEL_FILE
                        ASR model parameter file (default: None)
  --sv_model_file SV_MODEL_FILE
                        SV model parameter file (default: None)
  --lm_train_config LM_TRAIN_CONFIG
                        LM training configuration (default: None)
  --lm_file LM_FILE     LM parameter file (default: None)
  --word_lm_train_config WORD_LM_TRAIN_CONFIG
                        Word LM training configuration (default: None)
  --word_lm_file WORD_LM_FILE
                        Word LM parameter file (default: None)
  --ngram_file NGRAM_FILE
                        N-gram parameter file (default: None)
  --model_tag MODEL_TAG
                        Pretrained model tag. If specify this option, *_train_config and *_file will be overwritten (default: None)
  --beam_search_config BEAM_SEARCH_CONFIG
                        The keyword arguments for transducer beam search. (default: {})

Beam-search related:
  --batch_size BATCH_SIZE
                        The batch size for inference (default: 1)
  --nbest NBEST         Output N-best hypotheses (default: 5)
  --beam_size BEAM_SIZE
                        Beam size (default: 20)
  --penalty PENALTY     Insertion penalty (default: 0.0)
  --maxlenratio MAXLENRATIO
                        Input length ratio to obtain max output length. If maxlenratio=0.0 (default), it uses a end-detect function to automatically find maximum hypothesis lengths.If maxlenratio<0.0, its absolute value is interpretedas a constant max output length
                        (default: 0.0)
  --minlenratio MINLENRATIO
                        Input length ratio to obtain min output length (default: 0.0)
  --ctc_weight CTC_WEIGHT
                        CTC weight in joint decoding (default: 0.0)
  --lm_weight LM_WEIGHT
                        RNNLM weight (default: 1.0)
  --ngram_weight NGRAM_WEIGHT
                        ngram weight (default: 0.9)
  --streaming STREAMING
  --fake_streaming FAKE_STREAMING
  --full_utt FULL_UTT
  --chunk_size CHUNK_SIZE
  --left_context LEFT_CONTEXT
  --right_context RIGHT_CONTEXT
  --display_partial_hypotheses DISPLAY_PARTIAL_HYPOTHESES
                        Whether to display partial hypotheses during chunk-by-chunk inference. (default: False)

Dynamic quantization related:
  --quantize_asr_model QUANTIZE_ASR_MODEL
                        Apply dynamic quantization to ASR model. (default: False)
  --quantize_modules [QUANTIZE_MODULES ...]
                        Module names to apply dynamic quantization on. The module names are provided as a list, where each name is separated by a comma (e.g.: --quantize-config=[Linear,LSTM,GRU]). Each specified name should be an attribute of 'torch.nn', e.g.:
                        torch.nn.Linear, torch.nn.LSTM, torch.nn.GRU, ... (default: None)
  --quantize_dtype {float16,qint8}
                        Dtype for dynamic quantization. (default: qint8)

Text converter related:
  --token_type {char,bpe,None}
                        The token type for ASR model. If not given, refers from the training args (default: None)
  --bpemodel BPEMODEL   The model path of sentencepiece. If not given, refers from the training args (default: None)
  --token_num_relax TOKEN_NUM_RELAX
  --decoding_ind DECODING_IND
  --decoding_mode DECODING_MODE
  --ctc_weight2 CTC_WEIGHT2
                        CTC weight in joint decoding (default: 0.0)
