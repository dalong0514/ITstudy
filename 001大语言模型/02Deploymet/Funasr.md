### 跑模型

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
