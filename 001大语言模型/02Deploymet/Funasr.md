### 跑模型

备注：发现还是要联网调模型的，怪不得不怎么耗内存。所以要关代理。

cat /Users/Daglas/Desktop/output_dir/1best_recog/text_with_punc > /Users/Daglas/dalong.gpt/rewrite-text/origin_text_1.md

2024-02-25

ffmpeg -i /Users/Daglas/Desktop/20240224批量转业主块-换管道PL图层.mkv -ss 2 -t 29 /Users/Daglas/Desktop/input.mkv

ffmpeg -i /Users/Daglas/Desktop/input.mkv -vf "fps=20,scale=1280:-1:flags=lanczos" -c:v gif /Users/Daglas/Desktop/output.gif

ffmpeg -i /Users/Daglas/Desktop/input.mkv -vf "fps=10,scale=720:-1:flags=lanczos" -c:v gif /Users/Daglas/Desktop/output.gif

ffmpeg -i /Users/Daglas/Desktop/input.mkv /Users/Daglas/Desktop/output.gif

ffmpeg -i input.mp4 -vf "fps=10,scale=320:-1:flags=lanczos" -c:v gif output.gif



ffmpeg -i /Users/Daglas/Desktop/20240227-105415.gif -ss 0 -t 18 /Users/Daglas/Desktop/output.gif


ffmpeg -i /Users/Daglas/Desktop/20240302老阳闭门会-站在300年繁荣的起点.mkv -ss 136 -t 10253 /Users/Daglas/Desktop/output.mkv



ffmpeg -i /Users/Daglas/Desktop/20240228数智设计工艺流程系列功能和新版非标条件模块.mp4 -ss 2270 -t 1080 /Users/Daglas/Desktop/output.mp4




2024-02-01

ffmpeg -i /Users/Daglas/Desktop/20240201活水AI专场第三场.mkv -ss 0 -t 11280 /Users/Daglas/Desktop/20240131活水AI专场第二场01.mkv


ffmpeg -i /Users/Daglas/Desktop/CH0105总论Part5答疑.mkv -ss 0 -t 1800 /Users/Daglas/Desktop/CH0105总论Part5答疑05.mkv



2024-01-16

ffmpeg -i /Users/Daglas/Downloads/20231225与晨曦科技软件交流.m4a -ar 16000 -ac 1 -c:a pcm_s16le /Users/Daglas/Downloads/20231225与晨曦科技软件交流.wav

ffmpeg -i /Users/Daglas/Downloads/20231225与晨曦科技软件交流.wav -ss 1320 -t 420 /Users/Daglas/Desktop/output.wav

funasr --model paraformer-zh /Users/Daglas/Desktop/output.wav --output_dir /Users/Daglas/Desktop/output_dir



2024-01-09

ffmpeg -i /Users/Daglas/Downloads/20240109数字化研究院部门会议.m4a -ar 16000 -ac 1 -c:a pcm_s16le /Users/Daglas/Downloads/20240109数字化研究院部门会议.wav

funasr --model paraformer-zh /Users/Daglas/Downloads/20240109数字化研究院部门会议.wav --output_dir /Users/Daglas/Desktop/output_dir



2024-01-03

ffmpeg -i /Users/Daglas/Music/dalong.knowledgeAudio/2024001数智设计/20240102与吴总交流汇报年度计划.m4a -ar 16000 -ac 1 -c:a pcm_s16le /Users/Daglas/Desktop/20240102与吴总交流汇报年度计划.wav

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
