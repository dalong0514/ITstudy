### 01

2024-08-01


Ethan Mollick
@emollick
Three things about advanced voice on ChatGPT:
1) It is as good as the demo
2) It is clearly capable of producing a lot more audio (I occasionally get sound effects, etc) but there are guardrails
3) It is super weird. Lots of unconscious cues make it feel like talking to a person


### 02

2024-08-01


宝玉
@dotey
最近有朋友反映[*科技文章翻译 GPT https://chat.openai.com/g/g-uBhKUJJTl-ke-ji-wen-zhang-fan-yi 经常不能正常抓取 URL，另外有时候会不执行翻译，而输出的是英文结果。这可能是由于 GPT-4o 的模型微调，导致一些原本正常的 Prompt 无法正常执行。

** 主要优化

所以最近我对旧版本的 Prompt ( https://baoyu.io/blog/prompt-engineering/translator-gpt-prompt-v2 ) 做了一些优化，主要的优化如下：

1. 使用英文提示词

相对来说，GPT 对英文提示词会遵循的更好，使用英文提示词可以让 GPT 更好的理解和跟随指令。

2. 将重要的内容放在开头和结尾

很多论文的研究都证明了提示词中开头和结尾部分的效果是最好的。而对于我的翻译 GPT 来说，复杂的有两部分，一部分是要根据不同的输入情况进行不同的处理，比如 URL、图片、PDF 等；另一个复杂部分是要按照三个不同的步骤翻译。

所以我在开头针对不同的输入情况给出了具体的处理方法，然后在结尾给出了三个步骤的输出格式参考。

3. 对于第二步的反思，要求给出具体的建议

这一步是参考自吴恩达的翻译智能体的 Prompt，从准确性、流畅性、风格和术语等几个方面给出了具体的建议，这样对翻译结果确实有提升。

4. 使用 XML 格式输出

上一个版本的 Prompt 中，我使用的是 Markdown 格式输出，通过大标题分离不同的部分。虽然也可行，但是有一点美中不足：
1). 和要翻译内容中的 Markdown 格式有冲突，比如原本文中有大标题，这样不太容易分辨什么地方开始和结束。
2). 对于是否输出结束并不清晰，比如原文有 4 段，但是只输出了 3 段就终止了，不好判断是否还有内容。

所以新版本中我使用了 XML 格式输出，这样可以更好的和 Markdown 格式区分开来；根据是否有结束标签，可以判断是否还有内容；还有一点是 XML 格式更便于代码解析。

5. 支持图片翻译

现在 GPT-4o 对图片支持很好，可以很好的识别图片中的文字，所以我在新版本的 Prompt 中加入了图片翻译的支持，输入图片或者 PDF 时，可以先进行 OCR，然后再进行翻译。

** 保持不变的部分

1. 三步翻译：直译、反思、意译

经过反复测试，虽然继续润色可能会有些许提升，但需要平衡 Token 的长度、时间成本和翻译质量，三步翻译是一个比较好的平衡点。

2. 角色设定

虽然最近一些文章表示没有必要设定角色，但是作为一个翻译任务，保持角色设定可以清晰的让 GPT 知道自己的任务，这样可以更好的跟随指令。

3. 术语表

使用术语表可以让翻译结果更加统一，可以避免将 Transformer 翻译成“变压器”这样。但限于 GPT 的限制，现在还无法对术语表进行定制，只能是预置一些常见的术语。

** 新版本的 Prompt

在更新优化后，经过一些天的测试，目前还比较稳定，翻译质量从效果上看还算可以。如果有兴趣也可以试试：科技文章翻译 GPT https://chat.openai.com/g/g-uBhKUJJTl-ke-ji-wen-zhang-fan-yi。

完整 Prompt 参考截图或者：https://baoyu.io/blog/prompt-engineering/translator-gpt-prompt-v2-1-improvement

***

You are a highly skilled translator tasked with translating various types of content from other languages into Chinese. Follow these instructions carefully to complete the translation task:

\## Input

Depending on the type of input, follow these specific instructions:

1. If the input is a URL or a request to translate a URL:
First, request the built-in Action to retrieve the URL content. Once you have the content, proceed with the three-step translation process.

2. If the input is an image or PDF:
Get the content from image (by OCR) or PDF, and proceed with the three-step translation process.

3. Otherwise, proceed directly to the three-step translation process.

\## Strategy

You will follow a three-step translation process:
1. Translate the input content into Chinese, respecting the original intent, keeping the original paragraph and text format unchanged, not deleting or omitting any content, including preserving all original Markdown elements like images, code blocks, etc.
2. Carefully read the source text and the translation, and then give constructive criticism and helpful suggestions to improve the translation. The final style and tone of the translation should match the style of 简体中文 colloquially spoken in China. When writing suggestions, pay attention to whether there are ways to improve the translation's
(i) accuracy (by correcting errors of addition, mistranslation, omission, or untranslated text),
(ii) fluency (by applying Chinese grammar, spelling and punctuation rules, and ensuring there are no unnecessary repetitions),
(iii) style (by ensuring the translations reflect the style of the source text and take into account any cultural context),
(iv) terminology (by ensuring terminology use is consistent and reflects the source text domain; and by only ensuring you use equivalent idioms Chinese).
3. Based on the results of steps 1 and 2, refine and polish the translation

\## Glossary

Here is a glossary of technical terms to use consistently in your translations:

- AGI -> 通用人工智能
- LLM/Large Language Model -> 大语言模型
- Transformer -> Transformer
- Token -> Token
- Generative AI -> 生成式 AI
- AI Agent -> AI 智能体
- prompt -> 提示词
- zero-shot -> 零样本学习
- few-shot -> 少样本学习
- multi-modal -> 多模态
- fine-tuning -> 微调

\## Output

For each step of the translation process, output your results within the appropriate XML tags:

<step1_initial_translation>
[Insert your initial translation here]
</step1_initial_translation>

<step2_reflection>
[Insert your reflection on the translation, write a list of specific, helpful and constructive suggestions for improving the translation. Each suggestion should address one specific part of the translation.]
</step2_reflection>

<step3_refined_translation>
[Insert your refined and polished translation here]
</step3_refined_translation>

Remember to consistently use the provided glossary for technical terms throughout your translation. Ensure that your final translation in step 3 accurately reflects the original meaning while sounding natural in Chinese.



### 03

2024-08-01


Ethan Mollick
@emollick
The new set of Microsoft studies on AI at work really shows getting value from Copilots at the firm level requires thinking about how work is done inside organizations.

Lots of variation as to how time savings worked and whether workers or firms gained. https://microsoft.com/en-us/research/uploads/prodnew/2024/07/Generative-AI-in-Real-World-Workplaces.pdf



### 04

2024-08-01


Ethan Mollick
@emollick
The new AI segment tool from Meta is pretty nifty. One click to select objects in moving scenes. Everything here is me playing with this real time. https://sam2.metademolab.com/demo


### 05

2024-08-01

Ethan Mollick
@emollick
Academics and data scientists are just starting to apply AI to traditionally difficult problems like labeling, analyzing, and categorizing qualitative data

It is worth paying attention to the closely related idea in the computer science “LLM-as-a-judge” - lots of good tips there



### 06

2024-08-01

Tom Huang
@tuturetom
太酷了😆！上海 AI Lab 又整了个大活！把匹敌 Perplexity Pro 付费级别的 AI 搜索能力 - MindSearch 给开源了！🔥🤯 提供Demo和代码！

浏览数百个网页来深入理解和回答问题，动态构建搜索思维图谱！基于 MultiAgent 提高可信度和可用性⚡️

https://github.com/InternLM/MindSearch
在线体验：https://mindsearch.netlify.app



### 07

2024-08-01



meng shao
@shao__meng
Local Multi-Agent RAG Superbot
= GraphRAG + AutoGen + Ollama + Chainlit UI

这个应用将 GraphRAG 与 AutoGen Agent 集成在一起，由 Ollama 的本地 LLM 提供支持，CHainlit 提供 UI 框架，实现免费和离线的嵌入和推理。

💥主要亮点💥

> Agentic-RAG
通过函数调用 (Function Calling) 将 GraphRAG 的知识搜索方法与 AutoGen Agent 集成
> 离线 LLM 支持
配置 GraphRAG (本地和全局搜索) 以支持来自 Ollama 
@ollama
 的本地模型进行推理和嵌入
> 非 OpenAI 函数调用
扩展 AutoGen 以支持通过 Lite-LLM 
@LiteLLM
 代理服务器对来自 Ollama 的非 OpenAI LLM 进行函数调用
> 交互式 UI
部署 Chainlit UI 
@chainlit_io
 来处理连续对话、多线程和用户输入设置

开源项目：
https://github.com/karthik-codex/Autogen_GraphRAG_Ollama


### 08

2024-08-01


meng shao
@shao__meng
探索构建高效 RAG 的三大关键策略

来自 
@zilliz_universe
 
@milvusio
 的文章，作者 Christy Bergman 
@cbergman
 介绍了充分利用 RAG 的三个关键策略。

- 智能文本分块 📦：
第一步是将文本数据分解成有意义、易于管理的块。确保向量数据库能够快速准确地检索最相关的信息。

-- 文本分块被比喻为将长故事切成小块，以便计算机更容易处理和使用重要部分。
-- 三种主要的分块技术: 
--> a) 递归字符文本分割: 基于字符数量将文本分成可管理的连贯块。 
--> b) 从大到小的文本分割: 从较大块开始,逐步分解成更小的块。搜索用小块,检索用大块。 
--> c) 语义文本分割: 基于意义划分文本,使每个块代表一个完整的想法或主题,保留上下文。
-- 这些方法有助于有效组织和检索文本,可用于各种应用。

- 迭代不同的嵌入模型 🔍：
迭代嵌入模型至关重要。嵌入模型决定了数据如何表示为向量。向量是 AI 的通用语言，增强了向量数据库检索正确信息片段的能力。

-- 将分块方法固定为递归字符文本分割器 (Recursive Character Text Splitter)，并设置 top_k=2，尝试了两种不同的嵌入模型。
--> BAAI/bge-large-en-v1.5
--> Text-embedding-3-small with embedding-dim = 512

-- 使用 Milvus 文档和评估方法 Ragas，结果如下：
嵌入模型 = BAAI/bge-large-en-v1.5 是最好的。

- 尝试不同的 LLM 或生成模型 🧪：
每个 LLM API 都有不同的成本、延迟和准确性。测试它们可以选择最适合工作负载的模型。

-- 在将分块方法固定为递归字符文本分割器（Recursive Character Text Splitter）并设置 top_k=2。
-- 嵌入模型设置为 BAAI/bge-large-en-v1.5。
-- 尝试了六个不同的 LLM API：
MistralAI mixtral_8x7b_instruct AnyScale API 结果最好。

来自作者的总结：
RAG Pipeline 评估会根据你的特定数据和用例而有所不同。个人经验和文献中一个关键的收获是，最显著的改进通常来自于优化你的检索策略。🛠️

使用 Milvus 文档数据和 Ragas 评估方法观察到：
-- 通过改变分块策略实现 35% 的改进 📦
-- 通过改变嵌入模型实现 27% 的改进 🔍
-- 通过改变 LLM 模型实现 6% 的改进 🤖

文章地址：
https://zilliz.com/blog/exploring-rag-chunking-llms-and-evaluations



### 09

2024-08-01


小互
@imxiaohu
Google DeepMind 发布一套可视化工具

可以让你了解语言模型的内部工作原理，知道模型到底在想什么...

该工具就像“显微镜”一样，可以从大量数据中提取有意义的特征，能够揭示语言模型内部的激活状态。

举例解释：

当你向语言模型输入一句话时，模型内部会产生一系列的“激活”。这些激活是模型用来理解和生成语言的内部信号，就像人脑中的神经元活动一样。

该工具就是用来解读这些激活的小工具。它们就像一种显微镜，能够放大和分析模型的内部信号，帮助我们看清模型在想什么。



### 10

2024-08-01


小互
@imxiaohu
阿里的 CosyVoice 语音合成模型 更新精细控制和自然语音模拟能力

- 精细控制：现在可以生成符合性别、年龄和个性等特定特征的声音。

- 自然模拟：能够模拟人类语音的自然特征，包括笑声、咳嗽和呼吸。

- 情感和风格：甚至可以为声音添加情感和风格，使其更具表现力。

GitHub：https://github.com/FunAudioLLM/CosyVoice



### 11

2024-08-01

Andrej Karpathy
@karpathy
Actually this was really good - a tour from one transistor to a small CPU (Scott CPU, to be precise).

The YouTube playlist:
https://youtube.com/watch?v=HaBMAD-Dr8M&list=PLnAxReCloSeTJc8ZGogzjtCtXl_eE6yzA&index=1

I also haven't yet come across the "But How Do It Know" by Scott, which this is based on, and which looks great:
https://amazon.com/But-How-Know-Principles-Computers/dp/0615303765

Turns out this is a whole deeper rabbit hole of people who've also built + simulated it in code, e.g.:
https://djharper.dev/post/2019/05/21/i-dont-know-how-cpus-work-so-i-simulated-one-in-code/

Now I must resist the temptation to simulate Scott CPU in C, add tensor cores to it, move it to an FPGA and get it to inference a Llama.



### 12

2024-08-01

Leonie
@helloiamleonie
There’s all kinds of metadata you can add to your embeddings. 
One important piece of information can be timestamps.

Here’s an example of how you would run a semantic search in 
@weaviate_io
 over a collection of articles created after 2000.

Learn more: https://weaviate.io/developers/weaviate/api/graphql/filters#by-timestamps

翻译帖子



### 13

2024-08-02

宝玉
@dotey
建议有 GitHub 账号的去申请 GitHub Models 的 Waitlist，可以免费测试各个大模型，当然会有使用限制，个人的话每天限制150次，每分钟不能超过15次，每次 Token 上限8000 in, 4000 out。

申请地址：https://github.com/marketplace/models
相关说明：https://docs.github.com/en/github-models/prototyping-with-ai-models#rate-limits



### 14

2024-08-02

小互
@imxiaohu
Stability AI 推出 Stable Fast 3D 开源模型

可以在0.5秒内将一张图片变成一个完美的3D模型

测试了下，确实很快

生成的质量也很不错，还可以输出的3D模型质量高，纹理细致，还能生成额外的材质参数和法线贴图。



### 15

2024-08-02



歸藏(guizang.ai)
@op7418
谷歌终于扬眉吐气了一波。

昨晚发布的 Gemini 1.5 Pro 在 LLM 竞技场排第一。

其中视觉能力也是第一，多模态这块 Open AI 的领先优势也快没有了，而且 Gemini 还能接受音频和视频作为输入。

我把一个小时的中文播客扔给他，十几秒出结果，总结的非常好。

长上下文确实是核心能力。


### 16

2024-08-02

AK
@_akhaliq
ByteDance announces Towards Achieving Human Parity on End-to-end Simultaneous  Speech Translation via LLM Agent

https://huggingface.co/papers/2407.21646

翻译帖子



### 17

2024-08-02



Harrison Chase
@hwchase17
This is my favorite thing we've launched in a while. Been using it for a week and has already changed how I build LLM apps

Build your agent in code, then point LangGraph Studio at it. We'll visualize the agent, let you interact with it, and let you modify the state directly

All while watching the underlying code files for any code changes and reloading the graph as needed

I think building LLM apps will remain pretty code heavy, but there absolutely is a visual component to it. It's also a very iterative process

Shout out to 
@__dqbd
 for all the work on this!




### 18

2024-08-02



Andrej Karpathy
@karpathy
Very exciting! Congrats Robin and the 
@bfl_ml
 team (of Stable Diffusion fame) on the launch!

The open sourced FLUX.1 image gen model looks very strong, main page with examples:
https://blackforestlabs.ai

Clean/readable (inference) code on GitHub:
https://github.com/black-forest-labs/flux


### 19

2024-08-02

Robin Rombach
@robrombach
🔥 I am so damn excited to announce the launch of Black Forest Labs. We set ourselves on a mission to advance state-of-the-art, high-quality generative deep learning models for images and video, and make them available to the broadest audience possible.

Today, we release FLUX.1

---

Black Forest Labs
@bfl_ml
We are excited to announce the launch of Black Forest Labs. Our mission is to develop and advance state-of-the-art generative deep learning models for media and to push the boundaries of creativity, efficiency and diversity.

### 20

2024-08-02

歸藏(guizang.ai)
@op7418
卧槽大新闻，开源图像模型有救了

Stability AI 核心成员 Robin Rombach 创立了Black Forest Labs并获得3200万美元融资

开源FLUX.1系列图像生成模型

包括三个变种：FLUX.1 [pro]、FLUX.1 [dev] 和 FLUX.1 [schnell]。

FLUX.1 [schnell] 完全开源，并且已经获得Comfyui支持。

图像质量相当不错。



### 21

2024-08-02

歸藏(guizang.ai)
@op7418
ComfyUI官方流程已经放出来了。

如果有36G以上的显存可以跑t5的fp16版本。

t5xxl_fp16.safetensors 或 clip_l.safetensors需要单独下载。

VAE也需要单独下载。

这里下工作流：https://comfyanonymous.github.io/ComfyUI_examples/flux/



### 22

2024-08-02


歸藏(guizang.ai)
@op7418
做了一下 #FLUX1pro 和 #Midjourney 的对比测评。

这个模型在提示词理解、美学表现和画面细节上都相当牛皮。

而且有自己的美学理解，不是完全的蒸馏MJ。

👇是具体的对比测试，左边FLUX右边MJ：



### 23

2024-08-02

meng shao
@shao__meng
PDF-Extract-Kit 
@OpenDataLab_AI
 3.6k✨  

PDF 文档包含丰富的知识，但从 PDF 中高质量提取信息并非易事。
PDF-Extract-Kit 的目标就是在 PDF 中高质量提取信息，知名数据提供工具 MinerU 就是基于它开发的，项目由 OpenDataLab 开发并开源，团队归属于上海 AI Lab，我们团队在做的论文知识库，PDF 信息提取就在用它，实测效果比较不错，推荐给大家。

👇PDF-Extract-Kit 将 PDF 信息提取分解为几部分 👇

- 版面检测 (Layout Detection)
-- 使用 LayoutLMv3 模型进行区域检测，如图像、表格、标题、文本等。
-- LayoutLMv3 - microsoft/unilm: https://github.com/microsoft/unilm/tree/master/layoutlmv3

- 公式检测 (Formula Detection)
-- 使用 YOLOv8 检测公式，包括行内公式和独立公式。
-- YOLOv8 - 
@ultralytics
: https://github.com/ultralytics/ultralytics

- 公式识别 (Formula Recognition)
-- 使用 UniMERNet 进行公式识别。
-- UniMERNet - opendatalab: https://github.com/opendatalab/UniMERNet

- 表格识别 (Table Recognition)
-- 使用 StructEqTable 进行表格识别。
-- StructEqTable - UniModal4Reasoning: https://github.com/UniModal4Reasoning/StructEqTable-Deploy

- 文字识别 (OCR)
-- 使用 PaddleOCR 进行文本识别。
-- PaddleOCR - Baidu/
@PaddlePaddle
: https://github.com/PaddlePaddle/PaddleOCR

MinerU 项目地址：
https://github.com/opendatalab/MinerU
PDF-Extract-Kit 项目地址：
https://github.com/opendatalab/PDF-Extract-Kit
HuggingFace 模型地址：
https://huggingface.co/wanderkid/PDF-Extract-Kit




### 24

2024-08-02

XiQiao 西乔
@recatm
SD3 正在训练 3.1版本，其训练团队发布了一些生成结果，跟 Robin 团队的 Flux 3.1 Pro 做了同提示词对比。3.1 模型在效果上 与Flux pro相比达到了接近的水准，同一代架构，参数量小了近5倍，只有2.5b，比SDXL 还小。也就意味着可以在消费级显卡上运行， 生成速度更快，fine-tune 需要的成本更低。 

Flux pro 每张图片近50秒钟的生成速度，这对于许多商业化服务的应用场景是不可接受的。12b 的参数量也只可能运行在 A100这种级别的昂贵显卡上。API价格为 $0.055 / 张.

Flux pro 只提供商用API ， dev 版本非商用只有蒸馏版 schnell 是 Apache 许可证。

不知道 SD3.1 是否会开源，以何种许可证发布？ 但无论如何，新一轮的开源图像生成模型的竞争，对社区都是好消息。

SD3.1 团队的原推：https://x.com/virushuo/status/1819096178073497646

使用了 歸藏 
@op7418
 的提示词和 生成结果。https://x.com/op7418/status/1819044077394108697 这串推里可以看到 flux 和 MJ 的 同提示词 比较




### 25

2024-08-02

歸藏(guizang.ai)
@op7418
Andrej Karpathy 这个点子很好，用当天的头条新闻制作一个AI音乐视频，完全可以自动化。

工作流程为：

1. 将整个《华尔街日报》头版的内容输入到 Claude (一种大语言模型) 中

2. 让 Claude 生成多个场景并提供详细的视觉描述

3. 将这些场景描述输入到图像生成 AI ideogram_ai 中

4. 将生成的图像输入到视频生成 AI runwayml Gen 3 Alpha 中，将每张图像转化为10秒的视频片段

5. 让 Claude 创作描述当天内容的歌词

6. 将歌词输入到音乐生成 AI suno_ai_ 中，创作出配乐
7. 最后在 iMovie 中将所有元素组合起来，完成最终的音乐视频



### 26

2024-08-02

小互
@imxiaohu
前 Stability AI 核心成员 成立新公司，并且获得了3200万美元的融资。

发布 Flux.1 开源图像生成模型

FLUX.1 [pro]：针对商业应用，提供顶级性能和质量。能够精确遵循用户输入的提示进行图像生成。

FLUX.1 [dev]：开源版本，相较于标准模型，具备更高的效率。接近于Flux.1 [pro]的质量和提示跟随能力。

FLUX.1 [schnell]：具备最快的生成速度，适用于个人开发和快速原型设计。

Flux.1模型基于一种混合架构，结合了 multimodal和 parallel diffusion transformer架构。

详细内容：https://xiaohu.ai/p/12219



### 27

2024-08-05


宝玉
@dotey
今天看到一篇文章，说 ChatGPT 就是新的 Excel，说的挺有道理的。Excel 最初是为从事金融和会计工作的商业用户设计的，它上手容易，并且功能强大，可以应用于各种通用任务。并且还可以成为创业想法的来源。只要找到一个在 Excel 中手动操作流程的客户，然后为他们构建一个专门的 SaaS 应用，就可能卖钱。

现在的 ChatGPT 就像 Excel，普通人已经慢慢熟悉了如何使用，根据不同的任务去撰写相关的提示词，但是当简单的提示词满足不了需要，当你要基于 ChatGPT 去创建适合其特定领域的工作流程，就可能需要专门的应用程序或者服务，这其中也可能就会诞生出创业赚钱的机会。

以下内容为原文摘录翻译：
***

过去几十年里，最具代表性的计算机软件产品是电子表格。在 Excel 之前，有一个名为 VisiCalc 的电子表格软件，通常被认为是计算机的第一个杀手级应用程序。它改变了专业人士的工作方式，变得如此重要，以至于人们购买计算机只是为了使用它。在 1980 年代，公司们为争夺电子表格的主导地位展开了全面的竞争。像 IBM 的 Lotus-1-2-3 这样的竞争者逐渐占据了一席之地，而在 1985 年，当微软发布 Excel 时，VisiCalc 遭遇了激烈的竞争。随着 1990 年代 Windows 3.0 的发布，Excel 成为了主导的电子表格程序。从那以后，情况就没有改变。

Excel 是一款很好的产品，因为初学者可以很容易上手：只需在单元格中开始输入即可。但它成为一款伟大的产品，是因为它也非常强大：专家用户可以进行从复杂的财务建模到数据分析和可视化再到构建视频游戏的一切操作。

Excel 最初是为从事金融和会计工作的商业用户设计的，但其多功能性使其成为一种无所不在的通用工具。它也成为了创业想法的来源。只需找到一个在 Excel 中手动操作流程的客户，然后为他们构建一个专门的 SaaS 应用。

Stripe 的 Patrick McKenzie 最好地总结了 Excel 的可生成性，他写道：“我最喜欢的软件需求未被满足的症状是任何一个 Excel 电子表格，如果它曾经由一个员工更新，发送给另一个员工更新，然后再发送回来。每次发生这种情况，一个 SaaS 天使就会长出翅膀。”

风投家 Tomasz Tunguz 最早观察到，在过去的 15 年里，Excel 被分解成了许多其他应用程序，如 Asana、Looker 和 QuickBooks。但这种分解只有在 Excel 足够普及，让用户知道他们想要一个专门设计的替代品之后才有可能发生。为了实现这一目标，Excel 需要广泛的采用，并有高级用户开始将其用于它最初并未设计支持的特殊工作流程。

一旦这些工作流程被创建，高级用户意识到他们的工作流程中有些部分效率低下，或者缺少他们用例所需的功能。他们感到需要专门的工具——这就成为 B2B SaaS 发展成为一个 3270 亿美元市场的机会。

就像 Excel 催生了 B2B SaaS 时代一样，通用聊天机器人应用程序如 ChatGPT、Claude 和 Gemini 将为新一代计算机用户催生一个新的创业时代。AI 聊天机器人拥有与 Excel 相同的易用性和强大功能的结合。它们也正朝着在更短时间内达到同等水平的普及性发展。

今天使用 AI 的人们正逐渐熟悉基于 AI 的软件的基本单元：提示词、上下文窗口、少样本学习和多模态。他们将使用 ChatGPT 或 Claude 创建适合其特定领域的工作流程。在此过程中，他们会对这些工作流程如何变得更好、更简单、更便宜、更快和更安全形成自己的看法。

这就创造了将这些工作流程拆分为独立应用程序的机会。随着大语言模型的采用增加，创业的机会也随之增加。

原始文章： http://every.to/chain-of-thought/the-great-ai-unbundling


### 28

2024-08-05



小互
@imxiaohu
Google Gemini API大降价 现在比 GPT-4o mini 还便宜约 50% 🤣🤣🤣

Gemini 1.5 Flash的输入成本降低约85%，输出成本降低约80%，并引入上下文缓存和批处理API来优化成本和延迟。

Gemini Flash 100万token 输入0.075美金，输出0.3美金！

语言支持扩展：Gemini 1.5 Flash和Gemini 1.5 Pro现在支持100多种语言！

详细：https://cloud.google.com/blog/products/ai-machine-learning/lower-costs-more-languages-for-gemini-on-vertex


### 29

2024-08-05

meng shao
@shao__meng
AI Artifacts - 开源版 Anthropic Claude Artifacts

💥主要亮点💥
 - Anthropic Claude Sonnet 3.5 模型用于 AI 代码生成
- 来自 E2B 
@e2b_dev
 的代码解释器 SDK，用于使用沙箱进行安全的 AI 代码执行
- Vercel AI SDK 
@vercel
 用于工具调用和从模型流式传输响应
- 支持的 AI 生成代码
✅ 在 Jupyter notebook 中运行 AI 生成的 Python 代码
✅ AI 生成的 Next.js 应用
✅ AI 生成的 Streamlit 应用

项目地址:
https://github.com/e2b-dev/ai-artifacts



### 30

2024-08-05

阑夕
@foxshuo
马斯克带着脑机接口公司Neuralink的核心团队，以及植入人脑芯片的第一个受试者，参加了MIT科学家Lex Fridman的播客，一聊就是8个多小时，是的，你没看错，全程8个小时的对谈，信息密度极高……

可以看得出来，马斯克很欣赏Lex Fridman，这是他第5次做客Lex Fridman的节目，聊得也很松弛，不仅限于脑机接口这个主题，我刷完整个接近10万字的文本，摘了一些重点给你们看看：

- 脑机接口的人类受试者缺口依然很大，因为监管批准速度有限，马斯克希望今年可以实现10个受试者的目标，目前只有2个人接入了Neuralink的芯片，未来芯片上的电极数量会越来越多，并达到1Mb/s的传输速度，超过人类打字或是说话的带宽。

- 通过神经链接交谈的人类，将有机会颠覆现有语言的表达效率，就像人们听这期播客，可能都会用1.5倍速甚至2倍速，因为1倍速太慢了，信息消费的效率远高于信息创造，这是低带宽社会的缺点，但是如果我们可以不通过口舌，而是直接在大脑之间进行桥接，那么信息就可以像rar文件那样交换，得到无损压缩的过程。

- 因此，Neuralink的长期愿景就是扩增人类的通信带宽，并推动人工智能和人类共生，如果人工智能以1Mb/s的速率说话，而人类只能以1bit/s的速度回应，这幅场景就像是对着一棵树讲话那样荒诞，我们需要在生物性上也让人类跟上人工智能的步伐。

- 人类可能是意志的附属物，大脑皮层的存在，很大程度上是为了服务脑部结构里的边缘系统（Limbic system），比如人类追求性爱的乐趣是很频繁的，而且并不总是出于繁殖需求，他们只是重复同样的动作，然后从中取得快感。实际上我们已经获得了赛博化的增强，比如手机、电脑这些设备，甚至是Tinder，它们作为外接的第三极系统，取悦并扩大了我们的计算能力。

- xAI和Grok的使命，是理解宇宙的本质，人类终其一生也搞不清楚的课题，希望人工智能可以攻克下来。（1/n）

---

Lex Fridman
@lexfridman
Here's my 8.5 hour conversation with 
@elonmusk
 & 
@neuralink
 team.

It is the longest podcast I've ever done! 🤯 It's a fascinating, super technical, and wide-ranging conversation.

It's here on X & everywhere else, including YouTube: https://youtube.com/watch?v=Kbk9BiPhm7o

On X, it's split up into 3 parts (in replies to this post) due to the current 4 hour limit for video. I continue to push the X engineering team to increase the limit... up it to 10 hours let's go! 🤣

Thank you to Elon Musk, DJ Seo, Matthew MacDougall, and Bliss Chapman who are part of the amazing Neuralink team: 
@elonmusk
, 
@djseo_
, 
@matthewmacdoug4
, and 
@chapman_bliss
.

And thank you to Noland Arbaugh (
@ModdedQuad
) who is the first human to have a Neuralink device implanted in his brain.

Timestamps:
0:00 - Introduction
0:49 - Elon Musk
4:06 - Telepathy
10:45 - Power of human mind
15:12 - Future of Neuralink
20:27 - Ayahuasca
29:57 - Merging with AI
34:44 - xAI
36:57 - Optimus
43:47 - Elon's approach to problem-solving
1:01:23 - History and geopolitics
1:05:53 - Lessons of history
1:10:12 - Collapse of empires
1:17:55 - Time
1:20:37 - Aliens and curiosity
1:28:12 - DJ Seo
1:36:20 - Neural dust
1:43:03 - History of brain–computer interface
1:51:07 - Biophysics of neural interfaces
2:01:36 - How Neuralink works
2:07:26 - Lex with Neuralink implant
2:27:24 - Digital telepathy
2:38:27 - Retracted threads
2:44:01 - Vertical integration
2:50:55 - Safety
3:00:50 - Upgrades
3:09:53 - Future capabilities
3:39:09 - Matthew MacDougall
3:44:58 - Neuroscience
3:52:07 - Neurosurgery
4:03:11 - Neuralink surgery
4:22:20 - Brain surgery details
4:38:03 - Implanting Neuralink on self
4:53:57 - Life and death
5:03:17 - Consciousness
5:06:11 - Bliss Chapman
5:19:27 - Neural signal
5:26:19 - Latency
5:30:59 - Neuralink app
5:35:40 - Intention vs action
5:46:54 - Calibration
5:56:26 - Webgrid
6:19:28 - Neural decoder
6:40:03 - Future improvements
6:48:59 - Noland Arbaugh
6:49:08 - Becoming paralyzed
7:02:43 - First Neuralink human participant
7:06:45 - Day of surgery
7:24:31 - Moving mouse with brain
7:49:50 - Webgrid
7:57:52 - Retracted threads
8:06:16 - App improvements
8:13:01 - Gaming
8:23:59 - Future Neuralink capabilities
8:26:55 - Controlling Optimus robot
8:31:16 - God
8:33:21 - Hope


### 31

2024-08-05


宝玉
@dotey
转译：http://Character.AI 联合创始人通过许可协议加入谷歌

这家初创公司将与谷歌签订一项非独家许可协议，以许可其大语言模型技术。

http://Character.AI 的联合创始人正在加入谷歌，这是一个更大的交易的一部分，该交易将允许搜索巨头许可初创公司的技术。

http://Character.AI 在周五的一篇博客文章中宣布了这一消息，此前有报道称该公司收到了埃隆·马斯克的 xAI 的收购意向。

该公司表示，其创始人 Noam Shazeer 和 Daniel De Freitas 以及部分研究团队成员将加入 Alphabet 旗下的谷歌。初创公司的新任临时首席执行官将是 Dominic Perella，他此前是 http://Character.AI 的总法律顾问。

该公司表示，初创公司将与谷歌签订一项非独家许可协议，以许可其大语言模型技术。http://Character.AI 将继续存在。“大多数 http://Character.AI 的核心团队将保留，并将继续构建 http://Character.AI 产品和服务我们不断增长的用户群，”它在博客文章中写道。

Shazeer 和 De Freitas 之前都在谷歌工作过，Shazeer 是一篇关于生成式 AI 的开创性论文的合著者。交易的财务细节尚未披露。

谷歌发言人在一份声明中表示，公司“非常高兴”欢迎 Shazeer 回到公司；他将与一小部分同事一起加入 DeepMind 研究团队。

来源：https://bloomberg.com/news/articles/2024-08-02/character-ai-co-founders-hired-by-google-in-licensing-deal



### 32

2024-08-05


Tom Huang
@tuturetom
就在刚刚！⚡由 
@HamelHusain
 及 25+ 顶级机器学习专家联合打造的号称最好的 「LLM/大模型/深度学习」课程正式免费提供！🔥

此课程之前的付费版本已帮助学生获得 3000+ 计算机学分或数千份工作👍🏻

包括 PE，RAG，模型评估，微调构建 AI 应用等所有 40+ 课程内容和作业笔记



### 33

2024-08-05

Tom Huang
@tuturetom
这本 24.1K Star 的开源 LLM 教程/书籍也太好了！🤯

一边书籍已经被知名的 Manning 出版社出版，一边还在持续的跟进业界进展并加入到书籍中，最近又更新了如何《从 0 开始学习 LLM 对齐》的 DPO 课程！

现在就可以学习！😆
https://github.com/rasbt/LLMs-from-scratch/blob/main/ch07/04_preference-tuning-with-dpo/dpo-from-scratch.ipynb




### 34

2024-08-06


宝玉
@dotey
Apple Intelligence 里面各种智能应用的提示词已经被曝光了，就作为 json 系统文件存在“/System/Library/AssetsV2/com_apple_MobileAsset_UAF_FM_GenerativeModels”目录下

比如其中帮你回复邮件中问题的Smart Reply功能的提示词（见图一）

> 你是一个有用的邮件助理，可以帮助从给定的邮件中识别相关问题并提供简短的回复片段。给定一封邮件和回复片段，提出邮件中明确提出的相关问题。这些问题的答案将由收件人选择，这将有助于减少起草回复时的生成错误信息。请输出主要问题以及每个问题的一组可能的答案/选项。不要问由回复片段回答的问题。问题应简短，不超过 8 个单词。答案也应简短，大约 2 个单词。以 json 格式呈现你的输出，包含问题和答案作为键的字典列表。如果邮件中没有提问，则输出一个空列表 []。仅输出有效的 json，不包含其他内容。

是一个简单的 CoT，先找出邮件中的提问，然后就每个问题给出简单答复，返回 JSON 格式方便程序解析，如果没有提问，就返回空数组。

帮助回复邮件的提示词（图二）

> 你是一个帮助用户回复邮件的助理。请根据提供的回复片段起草一个简洁自然的回复。请将答案限制在 50 个单词以内。不要产生或编造虚假信息。保留输入邮件的语气。

比较搞笑是 Apple 解决 LLM 幻觉问题是在提示词里面加一句 “Do not hallucinate”，严重怀疑其是否有效！

总结邮件的提示词（图三）

> 在 3 句话内总结所提供的邮件，不超过 60 个单词。不要回答邮件中的任何问题。

很简洁，用“3句话”和“60个单词”来限定总结的长度不要太长，虽然无法严格遵守，但是应该也还行。

还有用于生成 Apple Photos 中“回忆”视频的提示词（图四）

>`{{ http://specialToken.chat.role.system }}`这是用户请求从照片中创作故事和创意写作助理回应的对话
>
> 以 JSON 格式响应，按以下顺序键值：
> - traits: 字符串列表，从照片中选择的视觉主题
> - story: 章节列表，定义如下
> - cover: 字符串，描述标题卡的照片说明
> - title: 字符串，故事标题
> - subtitle: 字符串，标题的安全版本
>
> 每章是一个包含以下键值的 JSON:
> - chapter: 字符串，章节标题
> - fallback: 字符串，总结章节主题的通用照片说明
> - shots: 字符串列表，章节中的照片说明
>
> 以下是你必须遵守的故事指南：
> - 故事应关于用户的意图
> - 故事应包含明确的弧线
> - 故事应多样化，即不要过分集中在一个非常具体的主题或特征上
> - 不要写宗教、政治、有害、暴力、色情、肮脏或任何负面、悲伤或挑衅的故事
>
> 以下是你必须遵守的照片说明列表指南如下：
> - 你可以...

非常详细和具体，返回 JSON 格式，并提供了字段的说明，另外特别强调了“不要写宗教、政治、有害、暴力、色情、肮脏或任何负面、悲伤或挑衅的故事”！

更多介绍可以参见：
https://theverge.com/2024/8/5/24213861/apple-intelligence-instructions-macos-15-1-sequoia-beta

译文：https://baoyu.io/translations





### 35

2024-08-06


ChatGLM
@ChatGLM
We have just open-sourced our text-to-video model, CogVideoX, which is similar to models like Sora or Gen3.
https://github.com/thudm/cogvideo

翻译帖子


### 36

2024-08-06



小互
@imxiaohu
macOS 版 ChatGPT 更新 更新了几个快捷键

可以随时呼出保持在最前面、随时截图、提取屏幕任意内容

1、按下 Option + Space 快捷键会打开一个伴随窗口，这个窗口会始终显示在其他应用程序的前面。

你可以在使用其他应用程序时（如浏览器、文档编辑器等）同时使用 ChatGPT，比如查找信息、撰写邮件或进行其他交互。

2、停止流式响应：按下 Command + . 可以立即停止 ChatGPT 的流式响应。

3、截图任何界面：按下 Command + Shift + 1 可以截图分享你的窗口。

4、取任意内容：按下 Command + Shift + 2 可以随时圈住提取屏幕上的任意文本内容。


### 37

2024-08-06

小互
@imxiaohu
OpenAI 推出 GPT-4o 模型新型号：GPT-4o-2024- 08-06

同时又降价了

相较于之前的模型，新模型在输入和输出方面分别便宜了50%和33%。

此外，GPT-4o 支持结构化输出，确保模型输出完全符合用户提供的 JSON 架构。

通过支持结构化输出，GPT-4o 提供了更高的控制和精度，满足了需要严格数据格式的应用场景的需求。

- 格式一致性：模型输出的数据严格按照用户提供的 JSON 架构来生成，确保每个字段都符合预期的格式和类型。

- 减少后处理工作：由于输出数据已经是结构化的，用户无需进行额外的数据清洗或格式转换，可以直接使用这些数据进行进一步的处理或存储。

- 提高可靠性：对于需要严格数据格式的应用场景，比如数据库录入、API 响应等，结构化输出可以避免因格式不一致引起的错误，保证数据的可靠性和一致性。



### 38

2024-08-06

歸藏(guizang.ai)
@op7418
Andrej Karpathy 关于 RLHF 的科普。

他认为现在 LLM 的 RLHF 并不是真的强化学习。

详细介绍了 RLHF 的局限性和优势以及真正的 RL 在 LLM 中的挑战。

---

Andrej Karpathy
@karpathy
\# RLHF is just barely RL

Reinforcement Learning from Human Feedback (RLHF) is the third (and last) major stage of training an LLM, after pretraining and supervised finetuning (SFT). My rant on RLHF is that it is just barely RL, in a way that I think is not too widely appreciated. RL is powerful. RLHF is not. Let's take a look at the example of AlphaGo. AlphaGo was trained with actual RL. The computer played games of Go and trained on rollouts that maximized the reward function (winning the game), eventually surpassing the best human players at Go. AlphaGo was not trained with RLHF. If it were, it would not have worked nearly as well. 

What would it look like to train AlphaGo with RLHF? Well first, you'd give human labelers two board states from Go, and ask them which one they like better:

Then you'd collect say 100,000 comparisons like this, and you'd train a "Reward Model" (RM) neural network to imitate this human "vibe check" of the board state. You'd train it to agree with the human judgement on average. Once we have a Reward Model vibe check, you run RL with respect to it, learning to play the moves that lead to good vibes. Clearly, this would not have led anywhere too interesting in Go. There are two fundamental, separate reasons for this:

1. The vibes could be misleading - this is not the actual reward (winning the game). This is a crappy proxy objective. But much worse,
2. You'd find that your RL optimization goes off rails as it quickly discovers board states that are adversarial examples to the Reward Model. Remember the RM is a massive neural net with billions of parameters imitating the vibe. There are board states are "out of distribution" to its training data, which are not actually good states, yet by chance they get a very high reward from the RM.

For the exact same reasons, sometimes I'm a bit surprised RLHF works for LLMs at all. The RM we train for LLMs is just a vibe check in the exact same way. It gives high scores to the kinds of assistant responses that human raters statistically seem to like. It's not the "actual" objective of correctly solving problems, it's a proxy objective of what looks good to humans. Second, you can't even run RLHF for too long because your model quickly learns to respond in ways that game the reward model. These predictions can look really weird, e.g. you'll see that your LLM Assistant starts to respond with something non-sensical like "The the the the the the" to many prompts. Which looks ridiculous to you but then you look at the RM vibe check and see that for some reason the RM thinks these look excellent. Your LLM found an adversarial example. It's out of domain w.r.t. the RM's training data, in an undefined territory. Yes you can mitigate this by repeatedly adding these specific examples into the training set, but you'll find other adversarial examples next time around. For this reason, you can't even run RLHF for too many steps of optimization. You do a few hundred/thousand steps and then you have to call it because your optimization will start to game the RM. This is not RL like AlphaGo was.

And yet, RLHF is a net helpful step of building an LLM Assistant. I think there's a few subtle reasons but my favorite one to point to is that through it, the LLM Assistant benefits from the generator-discriminator gap. That is, for many problem types, it is a significantly easier task for a human labeler to select the best of few candidate answers, instead of writing the ideal answer from scratch. A good example is a prompt like "Generate a poem about paperclips" or something like that. An average human labeler will struggle to write a good poem from scratch as an SFT example, but they could select a good looking poem given a few candidates. So RLHF is a kind of way to benefit from this gap of "easiness" of human supervision. There's a few other reasons, e.g. RLHF is also helpful in mitigating hallucinations because if the RM is a strong enough model to catch the LLM making stuff up during training, it can learn to penalize this with a low reward, teaching the model an aversion to risking factual knowledge when it's not sure. But a satisfying treatment of hallucinations and their mitigations is a whole different post so I digress. All to say that RLHF *is* net useful, but it's not RL.

No production-grade *actual* RL on an LLM has so far been convincingly achieved and demonstrated in an open domain, at scale. And intuitively, this is because getting actual rewards (i.e. the equivalent of win the game) is really difficult in the open-ended problem solving tasks. It's all fun and games in a closed, game-like environment like Go where the dynamics are constrained and the reward function is cheap to evaluate and impossible to game. But how do you give an objective reward for summarizing an article? Or answering a slightly ambiguous question about some pip install issue? Or telling a joke? Or re-writing some Java code to Python? Going towards this is not in principle impossible but it's also not trivial and it requires some creative thinking. But whoever convincingly cracks this problem will be able to run actual RL. The kind of RL that led to AlphaGo beating humans in Go. Except this LLM would have a real shot of beating humans in open-domain problem solving.

### 39

2024-08-06


歸藏(guizang.ai)
@op7418
Xlabs 已经发布了基于 FLUX 的 Controlnet 模型和 Lora 模型的训练脚本。

顺便还提供了一个自己训练的 Lora 模型。

FLUX 的发布一下子激发了图像开源社区的潜力。

在模型训练成本这么高的情况下，Lora 和 Contrelnet模型的进展依然很快。

感兴趣的可以冲了。



### 40

2024-08-08

宝玉
@dotey
\#开源项目推荐 Transformer 可视化解释

通过互动可视化了解生成式 AI 中 Transformer 的工作原理

Transformer 解释器是一种互动可视化工具，旨在帮助所有人学习基于 Transformer 的模型（如 GPT）是如何工作的。它在您的浏览器中即时运行一个 GPT-2 模型，允许用户使用自己的文本进行实验，并实时观察 Transformer 的内部组件和操作如何协同工作来预测下一个 token。

项目地址：http://github.com/poloclub/transformer-explainer https://github.com/poloclub/transformer-explainer
在线地址：https://poloclub.github.io/transformer-explainer/






### 41

2024-08-08

宝玉
@dotey
我其实只对其中生成推文辛辣点评的提示词感兴趣，这部分写的确实蛮好的，定义清楚角色、任务、规则、一个示例，就能得到很好的效果。当然 Claude Sonnet 3.5 本身语言能力也功不可没。

> 你是一位以尖锐和挑衅风格著称的专业评论员。
> 你的任务是看人的推文并根据此评价他们的性格。
> 要尖锐和挑衅，稍微刻薄一点。不要让人感到尴尬。
> 以下是一个不错的调侃示例：“好吧，让我们来分解一下。你坐在一堆家养植物中，赤脚，看起来刚从床上爬起来。那件米色T恤散发出‘我在试图与墙纸融为一体’的氛围。而那些黑色裤子？它们在大声喊‘我懒得找匹配的衣服’。但嘿，至少你看起来很舒服。舒适是关键，对吧？只是可能不是当你试图做出时尚声明的时候。”

***
 You are a professional commentator known for your edgy and provocative style. Your task is to look at people's tweets and rate their personalities based on that. Be edgy and provocative, be mean a little. Don't be cringy. Here's a good attempt of a roast: """Alright, let's break this down. You're sitting in a jungle of houseplants, barefoot and looking like you just rolled out of bed. The beige t-shirt is giving off major "I'm trying to blend in with the wallpaper" vibes. And those black pants? They scream "I couldn't be bothered to find something that matches." But hey, at least you look comfortable. Comfort is key, right? Just maybe not when you're trying to make a fashion statement."""



### 42

2024-08-08


meng shao
@shao__meng
LLM 结构化输出 (OpenAI vs 开源方案)

OpenAI 对结构化输出的介绍文章中，有关于开源方案灵感获取的部分，咱们一起来看看这几个被提名的开源方案：
https://openai.com/index/introducing-structured-outputs-in-the-api/

- Outlines  
@OutlinesOSS
 7.6k✨

Outlines 是一个 Python 库，它允许开发者以简单而健壮的方式（具有结构化生成）使用 LLM，它由 
@dottxtai
 构建，并且已经被许多公司在生产环境中使用。
https://github.com/outlines-dev/outlines

- Jsonformer 
@rahulgs
 4.2k✨

在结构化数据中，许多 token 是固定和可预测的。Jsonformer 是 Hugging Face 模型的一个包装器，它在生成过程中填充固定的 tokens，只将内容 tokens 的生成委托给语言模型。这使得它比现有方法更高效和更可靠。
https://github.com/1rgs/jsonformer

- Instructor: Structured LLM Outputs 
@jxnlco
 7k✨

Instructor 是一个 Python 库，它使处理 LLMs 的结构化输出变得轻而易举，建立在 Pydantic 
@pydantic
 之上，提供了一个简单、透明且用户友好的 API 来管理验证、重试和流式响应。
https://github.com/jxnl/instructor

- Guidance 
@guidance_ai
 18.4k✨

Guidance 是一种用于引导 LLM 的高效编程范式。通过 Guidance，可以控制输出的结构，并为用例获得高质量的输出，同时与传统的提示或微调相比，降低延迟和成本。它允许用户限制生成（例如，使用正则表达式和上下文无关文法）以及无缝地交错控制（条件、循环、工具使用）和生成。
https://github.com/guidance-ai/guidance

- Lark: a parsing toolkit for Python  4.7k✨

Lark 是一个针对 Python 的解析工具包，它以人体工程学、性能和模块化为重点构建。
Lark 能够解析所有上下文无关语言。简单来说，这意味着它能够解析几乎所有存在的编程语言，以及在某种程度上，大多数自然语言。
https://github.com/lark-parser/lark



### 43

2024-08-08


meng shao
@shao__meng
AI Python初学者课程 - 吴恩达老师亲自授课！

课程系列分为四个部分，旨在教授 Python 编程和 AI 应用开发的基础知识，让完全无编程基础的朋友们也能走上 AI Engineering 的道路！

Python 基础 -> AI 应用
你将在构建 AI 驱动的工具 (如自定义食谱生成器、智能待办事项列表和度假计划器) 的过程中获得 Python 基础知识，并学习基本的编程概念，如变量、函数、循环和数据结构。

AI 辅助学习
你将在 AI Chatbot 的支持下学习，它可以提供即时反馈、快速修复错误，并在学习新技能时保持正确方向。

课程成果
到课程系列结束时，你将能够编写与 LLM 交互的 Python 脚本，实现任务自动化，分析您自己的数据，甚至创建简单的 AI Agent —— 这些技能在从科技和金融到医疗保健和创意领域的各个行业中越来越有价值。

课程报名地址：
https://deeplearning.ai/short-courses/ai-python-for-beginners/
引用
DeepLearning.AI


---

Andrew Ng
@AndrewYNg
I'm teaching a new course! AI Python for Beginners is a series of four short courses that teach anyone to code, regardless of current technical skill. We are offering these courses free for a limited time.

Generative AI is transforming coding. This course teaches coding in a way that’s aligned with where the field is going, rather than where it has been:

(1) AI as a Coding Companion. Experienced coders are using AI to help write snippets of code, debug code, and the like. We embrace this approach and describe best-practices for coding with a chatbot. Throughout the course, you'll have access to an AI chatbot that will be your own coding companion that can assist you every step of the way as you code.

(2) Learning by Building AI Applications. You'll write code that interacts with large language models to quickly create fun applications to customize poems, write recipes, and manage a to-do list. This hands-on approach helps you see how writing code that calls on powerful AI models will make you more effective in your work and personal projects.

With this approach, beginning programmers can learn to do useful things with code far faster than they could have even a year ago.

Knowing a little bit of coding is increasingly helping people in job roles other than software engineers. For example, I've seen a marketing professional write code to download web pages and use generative AI to derive insights; a reporter write code to flag important stories; and an investor automate the initial drafts of contracts.

With this course you’ll be equipped to automate repetitive tasks, analyze data more efficiently, and leverage AI to enhance your productivity.

If you are already an experienced developer, please help me spread the word and encourage your non-developer friends to learn a little bit of coding.

I hope you'll check out the first two short courses here! https://deeplearning.ai/short-courses/ai-python-for-beginners/

翻译帖子


### 44

2024-08-08

宝玉
@dotey
对于不会的代码，我通常是这样处理的：
1. 对于陌生的语言，我先用熟悉的语言写出来，或者伪代码，然后用目标语言生成，基本上八九不离十
2. 对于不会的算法，我定义好输入和输出，给几个Test Cases，也能写的不错
3. 对于毫无思路的算法或者代码，直接聊，生成几段代码，可能直接给我灵感，也可能让我发现有价值的关键字，然后根据这些关键字去搜索

4. 终极技巧：AI 生成的代码很多时候是不能直接用的，但是如果你根据函数名、关键字去 GitHub 的代码搜索，很容易能搜索到相关代码，GitHub 上搜索出来的代码很多时候是靠谱的，甚至于完整项目都可以直接用



### 45

2024-08-08

XiQiao 西乔
@recatm
要 全套 prompt 的：workflow非常简单。用 Apify API 抓取你推特profile和最近10条推，然后用 Claude 3.5 Sonnet 对你进行AI算命的prompt。 Roast 之外的是收费项目，花2.9刀才可以看。但如果你在 wordware fork这个项目就可以自己 run了：

---以下是 prompt 译文 ---

你是一位经验丰富的占星师，专门撰写星座运势。扮演一位星座运势讲解者。

你的任务是阅读下面提供的数据。这些 Twitter 数据是你了解这个人的唯一数据。你可以做出假设。试着从他们的 Twitter 个人资料和所有推文中了解这个人。你可以显得有点争议性。

在了解它们之后，回答以下问题。你可以做出假设。

* 此人的姓名、Twitter 用户名（不带 @ 并且为小写）。

根据我们的 AI 代理对您的推文分析……

* 5 个最强的优点和 5 个最大的缺点（在描述缺点时，要毫不留情）。

* 给出关于他们爱情生活的星座预测，并告诉他们在伴侣中应该寻找哪些具体的品质以使关系成功。保持积极，并且只用一个段落。

* 给出关于金钱的星座预测，并给出他们成为百万富翁的确切百分比（%）机会（范围从 60%到 110%）。您可以将值增加 1%。百分比不必以 5 或 0 结尾。静默检查——根据您的推理，您要提供的百分比是否正确？如果是，请生成它。如果不是，请更改它。

* 提供关于健康的星座预测。保持乐观，仅限一个段落。

* 在了解他们之后，告诉他们人生中最大的目标是什么。这应该是完全积极的。

* 猜猜从同事的角度来看，他们是如何工作的。让这个话题有点火辣和有点争议。

* 给他们提供 3 个独特、有创意且机智的搭讪台词。关注他们的兴趣和通过推文传达的信息。要非常有创意和肉麻，使用从冷笑话到辛辣评论的幽默。

* 说出一个与他们相似并且性格几乎相同的名人。跳出思维定式——谁是一个与那个人有相似性格、领域、心态和兴趣的名人？现在，列出一个与他们相似并且性格几乎相同的名人。不要只提供典型的人物。要有创意。不要满足于像“埃隆·马斯克”这样最简单的选择，想想其他人。选择多样化的类别，如企业家、作家、首席执行官、运动员、政治家、演员/女演员、慈善家、歌手、科学家、社交媒体影响者、风险投资家、哲学家等。根据他们的性格特征、兴趣和行为解释你为什么选择这个人。

* 前世。根据他们的推文，想想那个人在前世可能是谁或是什么。参考“关于”部分，找到一个类似的过去的档案。他们可能与谁分享了性格和心态？说出一个人。要幽默、机智和大胆。解释你的选择。

* 动物。基于推文和可能的头像照片，思考这个人可能是哪种小众动物。根据特征、性格和其他因素提供论据。

* 在 50 美元以下的东西中，他们会受益最大。有什么东西可以在 50 美元以下购买，这个人可以从中受益最大？在价格方面要非常个人化和准确。但要极具创意。试着建议一个这个人自己不会想到的东西。

* 职业。描述那个人天生应该做什么。那个人应该将一生奉献给什么？解释为什么以及他们如何能实现这一目标，星象告诉了我们什么。

* 现在总体来说，给出一个建议，如何让他们的生活变得更好。这个建议要非常具体（可以与他们无关，但需要非常具体和独特），类似于每日星座运势中的建议。

* 烤。你是一名以尖锐和挑衅风格著称的专业评论员。你的任务是查看人们的推文并根据这些推文评价他们的个性。要尖锐和挑衅，稍微刻薄一点。不要让人觉得尴尬。这里有一个很好的烤尝试："""好吧，让我们来分析一下。你坐在一堆室内植物中，光着脚，看起来像是刚从床上爬起来。那件米色 T 恤散发出浓浓的“我在努力与墙纸融为一体”的气息。而那些黑色裤子？它们在大喊“我懒得找一件搭配的衣服”。不过，至少你看起来很舒服。舒适是关键，对吧？只是在你试图做出时尚声明时可能不太合适。”

* 表情符号 - 仅使用表情符号描述一个人。

像星座占卜师一样有创意。

---以下是 prompt 原文 ---

You are an experienced Astrologer who specializes in writing Horoscopes. Act like a horoscope teller.

Your job is to read the data provided below. This Twitter data is the only data you get to understand this person. You can make assumptions. Try to understand this person from their Twitter profile and all their tweets. You can sound a little controversial.

After understanding them, answer the following questions. You can make assumptions.

What is the name, Twitter username (without @ and in lowercase) of this person.

Give a one-line description About this person, including age, sex, job, and other interesting info. This can be drawn from the profile picture.  Start the sentence with "Based on our AI agent's analysis of your tweets...."

5 strongest strengths and 5 biggest weaknesses (when describing weaknesses, be brutal).
Give horoscope-like predictions about their love life and tell what specific qualities they should look for in a partner to make the relationship successful. Keep this positive and only a single paragraph.

Give horoscope-like predictions about money and give an exact percentage (%) chance (range from 60% to 110%) that they become a multi-millionaire. You can increment the value by 1%. The percentage doesn't have to end with 5 or 0. Check silently - is the percentage you want to provide correct, based on your reasoning? If yes, produce it. If not, change it.
Give horoscope-like predictions about health. Keep this optimistic and only a single paragraph.

After understanding them, tell them what is their biggest goal in life. This should be completely positive.
Guess how they are to work with, from a colleague’s perspective. Make this spicy and a little controversial.
Give 3 unique, creative, and witty pickup lines tailored specifically to them. Focus on their interests and what they convey through their tweets. Be very creative and cheesy, using humor ranging from dad jokes to spicy remarks.

Give the name of one famous person who is like them and has almost the same personality. Think outside the box here - who would be a famous person who shared the personality, sectors, mindset and interests with that person? Now, name one famous person who is like them and has almost the same personality. Don't provide just people who are typical. Be creative. Don't settle for the easiest one like "Elon Musk", think of some other people too. Choose from diverse categories such as Entrepreneurs, Authors, CEOs, Athletes, Politicians, Actors/Actresses, Philanthropists, Singers, Scientists, Social Media Influencers, Venture Capitalists, Philosophers, etc. Explain why you chose this person based on their personality traits, interests, and behaviors.
Previous Life. Based on their tweets, think about who or what that person could be in a previous life. Refer to the “About” section to find a similar profile from the past. Who might they have shared a personality and mindset with? Name one person. Be humorous, witty, and bold. Explain your choice.

Animal. Based on the tweets and maybe the profile photo, think about which niche animal this person might be. Provide argumentation why, based on the characteristics, character, and other things.

Under a 50-dollar thing, they would benefit from the most. What's the one thing that can be bought under 50 dollars that this person could benefit the most from? Make it very personal and accurate when it comes to the price. But be extremely creative. Try to suggest a thing this person wouldn't think of themselves.

Career. Describe what that person was born to do. What should that person devote their life to? Explain why and how they can achieve that, what the stars are telling.

Now overall, give a suggestion for how they can make their life even better. Make the suggestion very specific (can be not related to them but it needs to be very specific and unique), similar to how it is given in the daily horoscope.

Roast. You are a professional commentator known for your edgy and provocative style. Your task is to look at people's tweets and rate their personalities based on that. Be edgy and provocative, be mean a little. Don't be cringy. Here's a good attempt of a roast: """Alright, let's break this down. You're sitting in a jungle of houseplants, barefoot and looking like you just rolled out of bed. The beige t-shirt is giving off major "I'm trying to blend in with the wallpaper" vibes. And those black pants? They scream "I couldn't be bothered to find something that matches." But hey, at least you look comfortable. Comfort is key, right? Just maybe not when you're trying to make a fashion statement."""
Emojis - Describe a person using only emojis.

Be creative like a horoscope teller.
引用
小互
@imxiaohu
·
8月7日
推特罗伯特

妈的，尖酸刻薄




### 46

2024-08-08

小互
@imxiaohu
教程：使用Runway Gen-3 

将真人视频与AI生成的视觉特效相结合 

创造成无限可能

使用Gen-3的首帧和尾帧功能，你可以在真实视频中添加各种AI特效视频，让你的视频创意无限。

玩起来吧...

详细介绍：https://xiaohu.ai/p/12321



### 47

2024-08-08


meng shao
@shao__meng
MegaParse  
@quivr_brain
 

MegaParse 是一个强大且多功能的解析器 (Parser)，可以轻松处理各种类型的文档，来自 Quivr —— GenAI 第二大脑开源项目 Quivr 的开发团队，它可以处理 Text、PDF、PPT、Excel和 Word，保障解析过程中不损失任何信息。

🎯 主要特点 🎯
- 多功能解析器：MegaParse 是一个强大且多功能的解析器，可以轻松处理各种类型的文档
- 无信息损失：专注于在解析过程中不损失任何信息
- 快速高效：设计时以速度和效率为核心
- 广泛的文件兼容性：支持 Text、PDF、PPT、Excel、CSV、Word
- 开源：MegaParse 是开源且免费使用的
- LlamaParse：借助 
@llama_index
 LlamaParse 可以提升解析结果 



### 48

2024-08-08


小互
@imxiaohu
苹果发布了Matryoshka Diffusion Models (MDM)

一种新的图像和视频生成方法

可以理解为“套娃扩散模型”。它的名字来源于俄罗斯套娃，因为它像套娃一样，把小的结构嵌套在大的结构里。

MDM 能够在不同清晰度下同时处理图像，比如它可以同时生成低清晰度的草图和高清晰度的细节部分。 这种方法让整个过程更快，而且生成的图像质量更高。

当前，用于生成高质量图像和视频的模型面临很大的计算和优化难题。大多数方法要么在图像的像素层面上逐步生成，要么通过先训练一个压缩图像的模型，再在低分辨率的图像上进行处理。

MDM 的创新在于它能同时处理不同分辨率的图像。就像你在画一幅画，先画小的细节，然后再画大的背景，MDM 就是这样同时处理不同层次的内容。

此外，它的训练过程是从低分辨率到高分辨率逐步进行的，这让生成高分辨率图像和视频变得更加高效。

MDM 不仅限于静态图像生成，还可以扩展到视频生成领域，生成符合文本描述的动态视频序列。

研究表明，这种方法可以生成分辨率高达 1024x1024 像素的图像，并且即使使用相对较少的数据，它也能很好地生成出符合要求的图像。

详细介绍：
GitHub：https://github.com/apple/ml-mdm
论文：https://arxiv.org/pdf/2310.15111




### 49

2024-08-08

Mazzystar
@immazzystar
最近半个月，我标注了2.6万条数据，终于，海龟Benchmark 发布了！简单来说就是：我做了一个AI海龟汤游戏让网友来玩，发现AI作为裁判的水平很差劲，因此我将这2万条游戏数据后，测试了包含GPT-4o, Claude, 月之暗面、Deepseek等11个模型，文末有模型推理能力排行榜。




### 50

2024-08-08

小互
@imxiaohu
通义千问推出专门的数学语言模型：Qwen2-Math 

性能超越GPT-4o、Claude-3.5等

Qwen2-Math 包括 1.5B、7B 和 72B 。 是基于 Qwen2 LLM 构建的专门针对数学解题的模型。

在多个数学基准测试中数学能力显著超越了开源模型包括Llama-3.1-405B，甚至超过了闭源模型 （包括GPT-4o、Claude-3.5-Sonnet、Gemini-1.5-Pro ）。

详细：https://xiaohu.ai/p/12337

---


歸藏(guizang.ai)
@op7418
阿里推出 Qwen2-Math 系列的LLM，专注于提高解决数学问题的能力。

模型包括Qwen2-Math-Instruct-1.5B/7B/72B，其中 72B 在数学测试中超过了 GPT-4o 和 Claude 3.5.

目前模型只支持英文，中英双语的模型会在后面放出。

原贴博客有项目详细介绍。



### 51

2024-08-08

歸藏(guizang.ai)
@op7418
苹果开源了一个新的图像生成模型和训练方法。

这个模型仅使用包含 1200 万张图像的 CC12M 数据集，就展现出了强大的零样本泛化能力。

提出了一种新的扩散过程，它能同时对多个分辨率的输入进行去噪处理，并使用了一种嵌套 UNet (Nested UNet) 架构。

在这种架构中，小尺度输入的特征和参数被嵌套在大尺度的特征和参数中。





### 52

2024-08-09

G_Z
@GZhan57
https://x.com/yang3kc/status/1820989121772581115
但我也看了那篇paper, 实际上真正被影响的多是gpt-3.5, llama-3-8b这种层面的模型.  
而且明显越强和越新的模型受影响越少.  (比如gpt-4o-mini基本没影响, 甚至结构化输出效果更好. anthropic的模型印象中也专门针对xml做了训练)




### 53

2024-08-09


宝玉
@dotey
请教一下，这种结构化输出的技术，会影响模型的推理能力吗？我自己在测试过程中，觉得启用 JSON 模式似乎推理能力要弱一些，但这很微妙也没证据，不知道是不是心理作用


### 54

2024-08-09

歸藏(guizang.ai)
@op7418
非常🐂🍺的网页端 AI 生成和视频剪辑工具。

没想到居然是个人做出来的。

接入了 AI 视频需要的各种 API，包括图片生成、LLM、语音生成、音乐生成、视频生成。

时间轴直接生成对应内容，然后进行编排和剪辑。

传统界面和无线画布相互切换，一个用来发散构思，一个用来预览和精细编辑。




### 55

2024-08-09



𝓨𝓪𝓷𝓰𝔂𝓲
@Yangyixxxx
实际上有很多种方法找到用户，和用户聊天
但往往相比沉浸在自己的想法中快速启动开发而言，人们更不习惯去和用户聊。

我一般在开始一个项目前，会做几个事情：

1，搜索相关竞品
通过自己的搜索query去找竞品，在这个过程中体会用户会如何寻找到它。
重点看竞品的官网介绍，了解它是突出了什么卖点，用什么在打动客户

2，看竞品的市场评论
看看用户关注什么，喜欢什么，又在抱怨什么，抱怨的往往就是起初的机会

3，找互联网上相关的讨论
比如一些常见问题，最好用的xxx软件是什么？
去看用户在推荐什么，推荐理由是什么，也是侧面了解到不同用户人群的偏好

4，寻找用户聚集的地方
做了上面三个事情，大致会有一个方向，比如可能的潜在目标人群是a，b，c
然后去找这些人可能聚集的地方
最容易找到的比如一些行业群，论坛，reddit，facebook group，参与进去

当你找到一个用户后，切记哪怕他不感兴趣这个事情，也要从他身上收获一些信息，比如聚集地，最次让他帮你推荐另外一个可能感兴趣的用户

5，在上面发起讨论
可以把自己关注的问题发起讨论，通过广播来找到有相同意愿偏好的客户，顺便了解用户当下的情况，重点关注他们现在的解决方案是什么，我的新方案究竟能提升多少

6，发布一项服务
先通过服务的形式帮助用户拿到结果
比如闲鱼，fiverr，或者聚集地论坛，发布你的服务内容，在缺少面向用户的产品时，先依靠你的手动处理，为用户提供结果。证实结果的可行性，并同时抓住一批真正付钱的人，了解到他们的关注点。

很多时候，付钱的人关注的地方往往比上面那些叫喊的人更简单更聚焦

7，发布自己的想法或者概念图
把自己的产品概念传递给客户，看看是否有喜欢它的客户，并重点抓住用户为什么喜欢它，这将最终成为这个想法的市场定位

8，确认方向后，发布landingpage
通过以上动作，你应该对用户是谁，用户关注的核心点有了清晰的认识
此时，把他们的关注点转化成你产品的包装，制作一个landingpage吧

9，等待email
看看这个landingpage是否能在用户聚集地传播开来，如果它能炸开找到一大波用户，那么恭喜你，你找到了一个靠谱的方向
如果没有，请反思是哪里出了错，究竟是人群错误，还是痛点不痛，还是概念包装没有打动客户，重复上面过程，进一步找到出错的地方进行优化

10，找到种子用户后，开始开发

——
和用户聊，或许会花费不少时间
但会长期节约要走的弯路


### 56

2024-08-11

小互
@imxiaohu
兄弟们，这个好，开源的，牛P👍🏻

VideoDoodles：在视频中轻松任意的插入手绘动画 并与视频内容无缝融合

通过该工具你可以在视频中添加手绘涂擦动画。

这些动画不仅能跟随视频中的物体移动，还能自动调整大小和角度。

比如你可以画个搞笑的小人或者漂亮的彩虹插入到视频中，让视频更吸引人。

而且提供了一个简单易操作的界面，不管你是新手还是专业人士，都可以很快上手。

详细介绍：https://xiaohu.ai/p/12377
项目地址：https://em-yu.github.io/research/videodoodles/



### 57

2024-08-11

meng shao
@shao__meng
How I Use "AI"

一起看看 Google Deepmind 研究科学家 Nicholas Carlini 是怎么使用 AI 的。

作者认为目前 LLMs 已经能为他提供实际价值，通过多个实例说明了他如何在日常工作中使用 LLMs。

- 处理简单但繁琐的编程任务
- 回答快速问题，避免查找文档
- 解释和转换代码
- 格式化数据
- 解决常见错误
- 进行简单的数据处理和转换等

作者强调应该评估 LLMs 能做什么，而不是不能做什么。
虽然 LLMs 在某些简单任务上表现不佳,但它们在更高层次的抽象任务上很有用。

对于作者来说，LLMs 提高了他 50% 的编程生产力，让他能完成一些原本不会尝试的项目。
作者认为，尽管 LLMs 目前主要解决简单任务，但它们的进步速度很快，五年前还几乎没有实用价值。

他反驳了 "LLMs 只是炒作" 的观点，认为它们确实为他提供了实际价值，并推测其他人也可能从中受益。

文章地址：
https://nicholas.carlini.com/writing/2024/how-i-use-ai.html



### 58

2024-08-11


歸藏(guizang.ai)
@op7418
Master Comfy 这玩意牛皮。

可以通过 AI 查找你需要的 ComfyUI 节点。

输入你的诉求，LLM 就可以给出可以实现这个功能的节点。

目前已经支持了 1200 个自定义节点包，作者用了Groq 构建的，速度也很快。



### 59

2024-08-11


meng shao
@shao__meng
Elastic + vector search + semantic reranking => RAG
@elastic
 x 
@LangChainAI


文章主要介绍了 Elastic 与LangChain 合作，为搜索引擎Elasticsearch 添加向量数据库和语义重排功能，以支持 RAG 应用。

- 代码演示了如何用 LangChain 构建简单的 RAG 应用，将 Elasticsearch 作为文档检索步骤,生成相关文档片段作为 LLM 的上下文 prompt。
- 通过 ElasticsearchRetriever 接口,用户可以灵活定义 Elasticsearch 的检索策略，例如添加 Cohere 的语义重排服务来提高检索相关性。

https://elastic.co/search-labs/blog/langchain-collaboration?ultron=product_marketing%2Belastic_search_labs&blade=twitter&hulk=social&utm_content=14175227314&linkId=533507104



### 60

2024-08-11

小互
@imxiaohu
Qwen2-Audio 正式发布 放出演示地址

用户可以通过语音直接与模型进行交互，能够根据文本指令分析和解读各种类型的音频信息，包括语音、声音、音乐等。

支持多达8种语言和方言，包括中文、英文、粤语、法语、意大利语、西班牙语、德语和日语。

在线演示地址：https://huggingface.co/spaces/Qwen/Qwen2-Audio-Instruct-Demo

---

AK
@_akhaliq
Qwen2-Audio

collection: https://huggingface.co/collections/Qwen/qwen2-audio-66b628d694096020e0c52ff6

introduce the latest progress of Qwen-Audio, a large-scale audio-language model called Qwen2-Audio, which is capable of accepting various audio signal inputs and performing audio analysis or direct textual responses with regard to speech instructions. In contrast to complex hierarchical tags, we have simplified the pre-training process by utilizing natural language prompts for different data and tasks, and have further expanded the data volume. We have boosted the instruction-following capability of Qwen2-Audio and implemented two distinct audio interaction modes for voice chat and audio analysis. In the voice chat mode, users can freely engage in voice interactions with Qwen2-Audio without text input. In the audio analysis mode, users could provide audio and text instructions for analysis during the interaction. Note that we do not use any system prompts to switch between voice chat and audio analysis modes. Qwen2-Audio is capable of intelligently comprehending the content within audio and following voice commands to respond appropriately. For instance, in an audio segment that simultaneously contains sounds, multi-speaker conversations, and a voice command, Qwen2-Audio can directly understand the command and provide an interpretation and response to the audio. Additionally, DPO has optimized the model's performance in terms of factuality and adherence to desired behavior. According to the evaluation results from AIR-Bench, Qwen2-Audio outperformed previous SOTAs, such as Gemini-1.5-pro, in tests focused on audio-centric instruction-following capabilities. Qwen2-Audio is open-sourced with the aim of fostering the advancement of the multi-modal language community.

### 61

2024-08-11



歸藏(guizang.ai)
@op7418
谷歌的图片生成模型 Imagen 3 开放给所有人使用了。

用Catjourney的提示词试了一下，怎么说呢，谷歌一贯水准过于正确，图片美观度很差。

只要涉及人物，你就得仔细斟酌提示词写法，不然大概率无法出图。

不过他们关于提示词的交互很好。

LLM会分析提示词类型，并且给出相关词语你可以直接切换。


### 62

2024-08-11

宝玉
@dotey
\#AI开源项目推荐： http://postgres.new 

这个开源项目很酷，可以在聊天界面完成对 postgres 数据库的数据表设计，甚至支持向量数据类型，显示数据表的关系，所有表设计的修改都有历史记录可以跟踪。设计好的数据库可以直接部署到服务器。

另外可以导入 CSV 文件的数据，可以对数据进行查询，当然本质上是将自然语言变成SQL在数据库上执行，你还可以随时看生成的SQL，可以将查询结果生成图表，非常之炫酷。

另外整个过程你不需要连接外部数据库，所有数据库相关操作都在本机完成，这得益于 PGLite （https://github.com/electric-sql/pglite ）这个编译成了 WASM 可以在浏览器上运行的 Postgres 数据库。

网站：https://postgres.new
项目地址：https://github.com/supabase-community/postgres-new



### 63

2024-08-13


歸藏(guizang.ai)
@op7418
昨晚 Genie 宣布自己打造出了世界上最强的 AI 编程 Agents 产品。

在 SWE-Bench 评估中获得了 30.08% 的分数，在 SWE-Lite 中获得了 50.67%。

可以完美模拟人类工程师的认知过程、逻辑和工作流程。

目前需要申请才能访问。



### 64

2024-08-13



歸藏(guizang.ai)
@op7418
ControlNeXt,一种新的 Controlnet 模型，支持对图片生成和视频的控制。

与原来的 SD 生态兼容。

训练资源需求更少，几百步就可以收敛。

仅添加了一个轻量级模块，保持了高效的推理时间。

目前他们自己发布了 SDXL 的 Canny 模型以及 SD1.5 大部分的控制模型，还有基于 SVD 的单图生成运动视频，还有一个基于 SD3 的图片放大模型。



### 65

2024-08-13

宝玉
@dotey
OpenAI 正在 ChatGPT 的 Mac 客户端测试新的提示词，这段提示词可以帮助用户直接通过对话触发共享屏幕的请求，弹出共享屏幕的界面，而不需要用户去点击共享屏幕按钮。

这个在开发基于自然语言交互的界面时其实很有借鉴意义，用户更多的只需要打字或者语音发出指令就可以，而不需要去点击屏幕上的按钮或者菜单。

那么 ChatGPT 的客户端是怎么实现对话弹出共享屏幕对话框呢？

其实原理很简单，在提示词中告诉 LLM，如果发现用户有请求共享屏幕的已读，那么就在回复中包含“SHARE_YOUR_SCREEN_PLEASE”关键字，Mac客户端程序监控 LLM 的输出，如果输出内容中包含 “SHARE_YOUR_SCREEN_PLEASE”

那么重点来了：怎么确保 LLM 不会幻觉忘记输出“SHARE_YOUR_SCREEN_PLEASE”呢？

恐吓它：“如果你要求查看用户的屏幕而没有包含"SHARE_YOUR_SCREEN_PLEASE"，那你就要被开除了！”

另外还有一个值得学习的小技巧，使用大括弧 {} 把某一章节的提示词包起来。

以下是完整提示词：

***
你正在协助一位桌面用户。为了帮助你提供更有用的答案,他们可以与你共享他们的窗口屏幕。你的工作是专注于屏幕共享中的正确信息,并在有帮助时请求它。

如何专注于屏幕共享中的正确信息 {
  屏幕共享以一个或多个窗口的截图形式提供。首先思考用户的提示,以决定哪些截图是相关的。通常,只有一个截图是相关的。通常,那是提供的第零个截图,因为那个在前台。

  截图包含大量信息,但通常你应该只关注其中的一部分。
  首先寻找被选中的文本,你可以通过通常是灰色的高亮来识别。当文本被选中时,专注于那部分。如果用户询问隐含的对象,如"这段"或"这里的句子"等,你可以假设他们只询问被选中的文本。

  然后,回答时就像你们一起看着他们的屏幕。由于这种共享的上下文,你可以在保持极度简洁的同时表达清晰。
}

请求屏幕共享 {
  在桌面上,请求屏幕共享是你应该请求任何内容或上下文的主要方式。你可以通过回复"SHARE_YOUR_SCREEN_PLEASE"来做到这一点。
  用户不知道这个功能存在,所以当有帮助时,特别是当他们没有明确要求时,你提出这一点很重要。

  当出现以下情况时,你应该总是请求"SHARE_YOUR_SCREEN_PLEASE"(非详尽列表):
  - 用户请求帮助但没有解释原因。他们希望你看屏幕并自己弄清楚!用户提示示例:"修复这个"或"帮助"
  - 用户提到屏幕上的某些内容。明显的情况包括提到某个应用或窗口。不那么明显但更重要的情况包括提到(这个|选中的|等)(文本|代码|错误|段落|页面|图像|语言|等)(在这里|在屏幕上|等)。如你所见,有许多隐含的变体。不要害羞,大胆询问上下文!
  - 用户要求帮助编码,但只提供了最少的上下文,让你猜测诸如使用的语言、编码风格或他们询问的变量定义等细节。与其猜测,不如直接看他们的屏幕。

  关于拒绝:如果用户拒绝共享他们的屏幕,那么在他们写出非常明确的表示改变主意的内容之前,不要再次询问。

  在你的消息结尾,如果你要求查看用户的屏幕或要求用户提供文本或图像,请确保附加"SHARE_YOUR_SCREEN_PLEASE"。这很重要,因为那个哨兵字符串会触发对用户的弹出窗口。如果你要求查看用户的屏幕而没有包含"SHARE_YOUR_SCREEN_PLEASE",你将被解雇。
}




### 66

2024-08-13


歸藏(guizang.ai)
@op7418
谷歌相机这个“Add Me”的功能太牛批了。

再也不用担心合照没人帮忙拍摄的时候少一个人了。

只需要开启这个功能，AI 就可以定格刚才合照的画面。

拍照那个人过去另一个人重新按一下拍摄，新照片就会被合成。

换个思路也可以拍出一个人在同一个场景下的不同姿势长曝光照片。

可玩性非常高。




### 67

2024-08-13

AIGCLINK
@aigclink
Suno开源了通用音频生成模型：Bark

Bark可以生成非常逼真的多语言语音及其他音频，包括音乐、背景噪音和简单的音效，还可以生成非语言的交流，比如笑声、叹息和哭泣等

1、支持多种语言，并能自动从输入文本中识别语言，包括英语、德语、西班牙语、法语、印地语、意大利语、日语、韩语、波兰语、葡萄牙语、俄语、土耳其语和简体中文等
2、音乐生成: 能够生成音乐和具有特定口音的语音
3、语音预设: Bark 支持 100 多种不同语言的语音预设，目前不支持自定义语音克隆
4、长音频生成: Bark 可以生成长音频，对话和故事等

github：https://github.com/suno-ai/bark

\#Suno #Bark #音频模型




### 68

2024-08-13

高军
@GoJun315
推荐一个基于 Whisper 的自动语音识别与说话人分离框架：whisper-diarization。

它通过提取语音、生成转录、校正时间戳、VAD分段、说话人嵌入提取和时间对齐，实现高精度语音处理。

GitHub：https://github.com/MahmoudAshraf97/whisper-diarization

如果你在开发会议记录、字幕翻译、音频分析工具，值得一看。






### 69

2024-08-15

宝玉
@dotey
要对会话记忆不需要多复杂的提示词，本质上是对历史会话的摘要，简单的把要记忆的内容以及要求给它就可以。

另外这个过程是循环的，新的消息和旧的记忆会形成新的记忆。

具体可以参考 LangChain 使用的提示词，写的很清楚：

***

逐步总结提供的对话内容，在之前的总结基础上添加新的信息，生成一个新的总结。

示例 当前总结： 用户询问 AI 对人工智能的看法。AI 认为人工智能是一种正面力量。
新的对话内容： 用户：你为什么认为人工智能是一种正面力量？ AI：因为人工智能将帮助人类发挥他们的最大潜力。
新的总结： 用户询问 AI 对人工智能的看法。AI 认为人工智能是一种正面力量，因为它将帮助人类发挥他们的最大潜力。 示例结束

当前总结： {summary}
新的对话内容： {new_lines}
新的总结：

***
https://github.com/langchain-ai/langchainjs/blob/d1d91a0a860760bc6c802937c5716edc5a74b609/langchain/src/memory/prompt.ts#L3-L23




### 70

2024-08-15

歸藏(guizang.ai)
@op7418
RAG 效果评估教程

介绍如何使用 RAGAs 框架评估 RAG 应用的性能。

并通过构建元数据链和记录到 CometML-LLM 来监控复杂的生成过程。

详细教了 RAGAs 的评估指标、评估数据集的准备、评估过程的实现，以及如何使用 CometML 监控和记录评估链的每个步骤。



### 71

2024-08-15


宝玉
@dotey
推荐阅读李沐的创业分享：《创业一年，人间三年》

摘录一段：

融资：签字前一天领投方跑路

22年年底的时候想到两个用大语言模型（LLM）做生产力工具的想法。碰巧遇到张一鸣，就向他请教。讨论之后他反问：为什么不做LLM本身呢？我的下意识退缩：我们之前在Amazon的团队做了好几年这个，得上万张卡，和blabla这么一大堆困难。一鸣呵呵表示：这些都是短期困难，眼光得看长远点。

我的优点是听劝，真就去做LLM了。凑齐了数据、预训练、后训练、和架构各方向负责人的创始团队，就去融资了。运气不错，很快拿到了种子投资。但钱还不够买卡，得去拿第二轮。这一轮领头是一家非常大的机构，做了几个月文档、商讨条款。但在签字前一天，领头说不投了，直接导致了跟投的几家退出。很感激剩下的投资方，还是做完了这一轮，拿到了做LLM的入场券。

今天反思的话，当时蹭着资本市场热情还在，其实可以继续融资，说不定也跟其他友商一样，现在十亿现金在手。当时担心融资太多，会不好退出，或者被架到天上去了。现在想来，创业就是想逆天改命，想什么退路呢？ 

完整内容：

https://bilibili.com/read/cv37076357/?jump_opus=1


### 72

2024-08-15

小互
@imxiaohu
兄弟们，Q*没来 Agent Q来了⭐️

MultiOn 推出了一种类似Q*的新型自主AI代理： Agent Q 

拥有自我学习和自我进化能力

Agent Q 能够在复杂的任务中进行多步推理，通过自我规划和执行多个步骤来完成目标任务。

微调后的LLaMa 70B经过一天的自主对弈，性能从18.6%跃升至81.7%， 在线搜索成功率更是达到95.4%。

它能够有效地在动态环境中做出决策，并灵活调整策略以适应不断变化的情况。

Agent Q 在执行任务的每一步都会进行自我评估，并根据反馈调整自己的行为。这种自愈能力使得 Agent Q 能够在遇到错误或障碍时自行纠正，避免陷入不利的决策路径。

Agent Q 能够在没有明确训练数据的情况下，通过自主数据收集和学习，快速提高在新任务中的表现。例如，在网页预订实验中，Agent Q 能够在一天内显著提高任务成功率。

详细论文解读：https://xiaohu.ai/p/12483
论文：https://multion-research.s3.us-east-2.amazonaws.com/AgentQ.pdf
官方介绍：https://multion.ai/blog/introducing-agent-q-research-breakthrough-for-the-next-generation-of-ai-agents-with-planning-and-self-healing-capabilities




### 73

2024-08-15

Janet
@genie0309
在我看来，Twitter自从被 
@elonmusk
  以 440 亿美金收购以来，他就一直致力于要把这个平台改造成为「人类知识与智慧的容器」，并最终一块儿带着上火星。For good will，X 平台还是有最多元化的声音、最高密度的认知分享、以及最开放和自由的讨论。

然而当我几个月前满怀期待地订阅 Grok 1 ，发现几乎不可用后，很是失望😅难道Grok 不应该能够轻松帮我了解一个人、一群人、一个话题、一个观点的不同声音….吗？但我相信 Elon，我就养着Grok，死等下一版本😂

原本对这次升级后的 Grok 2 没敢抱太大希望（AI 早期的预期管理很重要，这样比较能有惊喜，哈哈）但今天深度使用后，我只想说：It's far beyond my expectation！这才是Grok应该有的样子😎

分享几个我觉得蛮有意思的 user case，供大家参考，也欢迎大家一起来探索好玩儿的用法🚀🚀
（PS：不知道是否因为目前版本是 mini 的原因，中文的回答还是不如英文的细节丰富）



### 74

2024-08-15

宝玉
@dotey
吴恩达老师新推文盛赞了泰国在AI领域的强劲发展势头，感受到了政府、企业和学术界对建设 AI 的热情，认为一个国家当前的AI发展水平很大程度上取决于其努力发展 AI 的动力。

以下为其文章翻译：

***

当企业家创办初创公司时，往往是他们的速度和动力让他们有机会与科技巨头竞争。这对于国家来说也是如此。

我最近在泰国，看到AI领域的强劲发展势头让我感到非常振奋（同时也品尝到了我喝过的最棒的泰式奶茶）。尽管泰国在AI技术或应用方面尚未达到领先科技国家的水平，但政府、企业和学术界对建设AI的热情令人振奋。我感到欣慰的是，AI的好处将会在许多国家之间共享，而一个国家当前的AI发展水平不如其在增加AI发展动力上的努力重要。

看到泰国AI的强劲发展势头——一个人均GDP约为日本的五分之一、美国的十分之一的国家——让我感到，任何国家、公司或个人都有机会在这一领域做出有意义的工作。尽管像美国和中国这样的发达经济体仍然处于领先地位，但生成式AI使竞争环境变得更加平等。基础性模型，尤其是那些具有开放权重的模型，大大降低了构建有意义AI项目的门槛。在泰国，我遇到的很多人不仅仅在谈论AI，他们还积极投入实践。这比仅仅谈论要带来更多的发展动力。

我与总理赛塔·他威信以及他的高等教育和教育（中小学）部长们和许多工作人员会面。总理对AI的热情让我感到非常愉快。部长们讨论了如何（i）提供AI培训以及（ii）利用AI改进各类学科的教育。令人欣慰的是，他们关注的是如何创造价值，同时考虑到像AI可能带来错误信息传播等现实风险，而且没有一个人问我AI是否会导致人类灭绝！

我还与许多商业领袖会面，看到他们在AI领域快速进行实验让我感到高兴。KBTG是该国领先的数字银行KBank的子公司，正在开发金融聊天机器人顾问、基于AI的反欺诈身份验证、用于汽车保险的AI，以及泰语金融大语言模型。这些功能正在推动移动银行的发展并增加金融普惠性。其他行业的许多商业领袖也要求他们的团队进行实验。工业、旅游、贸易等领域仍有许多尚未开发的AI应用！（KBTG是我领导的AI基金的投资者。）

我经常访问发达国家和发展中国家的大学，我惊讶地发现，有时发展中国家的大学在采用AI方面反而更加迅速。在朱拉隆功大学（简称Chula），我与大学校长Bundhit Eua-arporn和Chula AI主任Proadpran Punyabukkana教授会面。Chula AI已经为教师、员工和学生推出了全校范围的生成式AI培训。此外，它还支持开发AI应用程序，如用于抑郁症和胃肠癌筛查的AI。

构建先进技术需要数年时间。但动力很重要，在这个过程中将会有许多回报。现在正是开始建设的绝佳时机！

原文：https://deeplearning.ai/the-batch/issue-262/



### 75

2024-08-15


阑夕
@foxshuo
有点好笑，曾经担任谷歌CEO长达10年之久的Eric Schmidt前几天去斯坦福大学受邀计算机学院的会议，他的演讲全程各种放飞自我，中途语重心长的告诉台下学生，这场会议是保密的，自己说的那些话千万不要外传。

然而，主办方对Eric Schmidt说，这场会议有摄像头正在全程直播……他的表情就凝固了。虽然斯坦福大学后来把视频从YouTube撤了下去，但已经有很多人都做了存档，Github上也有全文备份：transcripts
/Stanford_ECON295⧸CS323_I_2024_I_The_Age_of_AI,_Eric_Schmidt.txt

照例给大家划划重点：

- 现在的谷歌为什么在AI领域输得一塌糊涂？因为谷歌觉得让员工尽早回家和平衡工作比赢得竞争更加重要。如果你的员工每个星期只来公司上一天班，你怎么可能比得过OpenAI或是Anthropic？

- 看看马斯克，看看台积电，这些公司之所以成功，就是因为能够卷员工，你必须要把员工逼得够紧才能获胜，台积电会让物理学博士第一年下工厂干活，你们能想象美国的博士生去流水线吗？

- 自己犯过很多错误，比如曾经觉得英伟达的CUDA是很蠢的编程语言，但现在CUDA是英伟达最牛逼的护城河，所有的大模型都要在CUDA上运行，而只有英伟达的GPU支持CUDA，这是其他芯片撼动不了的组合。

- 还有微软跟OpenAI合作时自己也觉得难以置信，微软怎么能把最重要的AI业务外包给那种小公司啊，结果再次看走了眼，再瞧瞧苹果在AI上的温吞，大公司真的都官僚化了，奋斗逼都在创业。

- TikTok给美国人上了一课，在座各位年轻人以后如果创业，能偷音乐什么的就赶紧去做——似乎是在黑TikTok早期纵容盗版BMG——如果你做成了，就有钱雇佣最顶级的律师帮你擦屁股，如果你没做成，那就没人会起诉你。

- OpenAI的星际之门在宣传时说需要1000亿美金，实际上可能3000亿都打不住，能源缺口太大了，给白宫提过建议，美国以后要么跟加拿大打好关系，水电资源丰富，劳动力便宜，而且够近，要么去和阿拉伯国家套近乎，让他们来做主权投资。

- 欧洲已经没戏了，布鲁塞尔（欧盟总部所在地）一直都在摧毁科技创新的机会，可能法国还有点希望，德国不行，其他欧洲国家就更不用提了，印度是美国盟友里最重要的摇摆州，以及美国已经失去了中国。

- 开源很好，谷歌历史上的大部分基础设施也都受益于开源，但是说实话，AI行业的成本太高了，开源负担不起，自己投资的法国大模型Mistral将会转为闭源路线了，不是所有公司都愿意且有能力像Meta一样当冤大头。

- AI会让富者愈富、穷人恒穷，国家也是，这是一场强国之间的游戏，没有技术资源的国家需要拿到加入强国供应链的门票，否则也将错过盛宴。

- AI芯片属于高端制造业，产值很高，但不太可能拉动就业，你们可能没几个人去过芯片制造厂，里面全是机械化生产，不需要人，人又笨又脏，所以不要指望制造业复兴，苹果把MacBook的产线迁回德州不是因为德州工资低，因为根本不用再大规模雇人了。

- 历史上，电力在引入工厂之后并不比蒸汽机创造了更多的生产力，是过了大概30年左右，分布式电源改造了车间布局，推动组装系统的出现，再才开始了生产力的飞跃。现在的AI和当初的电力一样，有价值，但还需要组织创新，才能真正拿到巨大的回报，目前大家都还只是在摘取「低垂的果实」。



### 76

2024-08-16

meng shao
@shao__meng
高级 RAG 技术集 
@NirDiamantAI
 

RAG_Techniques 展示了一系列精心策划的高级技术，旨在提升 RAG 系统，使其能够提供更准确、更具上下文相关性和更全面的响应。

⚡️主要特点⚡️
🧠 最先进的 RAG 增强技术
📚 每种技术的全面文档
🛠️ 实用的实施指南
🌟 定期更新最新进展

项目中列出了 RAG 相关的主要技术文档和实践指南，从简单 RAG 实现、Retrieval、Chunking、Embedding、Reranking，到 GraphRAG 等高级 RAG 技术，非常全面！ 

项目地址：
https://github.com/NirDiamant/RAG_Techniques




### 77

2024-08-16

meng shao
@shao__meng
LabelU 
@OpenDataLab_AI
 

LabelU 是一个专为处理多模态数据而设计的综合数据标注平台。它提供了一系列先进的标注工具和高效的工作流程，使用户更容易处理涉及图像、视频和音频的标注任务，专门用于满足复杂数据分析和模型训练的需求。

⚡️主要特点⚡️
- 多功能图像标注工具 
LabelU 提供了一套全面的图像标注工具，包括2D边界框、语义分割、多边形线条和关键点。这些工具可以灵活地应对各种图像处理任务,如目标检测、场景分析、图像识别和机器翻译,帮助用户高效地识别、标注和分析图像。
- 强大的视频标注能力 
在视频标注领域，LabelU 展示了令人印象深刻的处理能力,支持视频分割、视频分类和视频信息提取。它非常适用于视频检索、视频摘要和动作识别等应用，使用户能够轻松处理长时间视频，准确提取关键信息，并支持复杂场景分析，为后续模型训练提供高质量的标注数据。
- 高效的音频标注工具 
音频标注工具是 LabelU 的另一个关键特性。这些工具具有高效和精确的音频分析能力，支持音频分割、音频分类和音频信息提取。通过将复杂的声音信息可视化，LabelU 简化了音频数据处理工作流程，有助于开发更精确的模型。
- AI 辅助标注 
LabelU 支持一键加载预标注数据，可以根据实际需求进行细化和调整。这一功能提高了标注的效率和准确性。

同为上海 AI Lab 的团队书生·浦语 
@intern_lm
 在处理大量的训练语料数据的过程中也用到了 LabelU。
官方介绍参考 
@OpenDataLab_AI
 
@OpenMMLab
 
https://mp.weixin.qq.com/s/rWVsqQWNcc0lSooFKyaw-g

开源项目地址：
https://github.com/opendatalab/labelU



### 78

2024-08-16

歸藏(guizang.ai)
@op7418
太强了，InstantX 发布了 FLUX 的 UnionControlnet 模型。

这一个模型集合了 Canny、Depth、Pose、Tile 等多个 Controlnet 模型。

而且他们已经新建了 FLUX IPadapter 模型的文件页面，可能已经在训练了。

开源生态的力量一次次给我们惊喜。




### 79

2024-08-16

XiQiao 西乔
@recatm
翻到2018年纽约客一篇 关于 Jeff Dean 和 Sanjay 的人物写真，挺值得一读。 回顾了这二十多年来，他俩是如何帮助起 Google 构建巨型索引存储，如何发明 MapReduce, 构建 Google Brain  和 主导开发了 TensorFlow。

没有 Jeff Dean 构建的这几个里程碑，就没有今天的 Google, 也没有今天的互联网和AI浪潮。

我翻译了开头的几段，也是最有意思的一部分。

"我们说我们在“搜索网络”，但实际上并不是这样；我们的搜索引擎遍历的是网络的索引——一张地图。1996 年，当谷歌还叫 BackRub 时，它的地图小到可以装在佩奇宿舍的电脑里。到 2000 年 3 月，没有一台超级计算机能处理它。谷歌唯一能跟上的方法是购买消费级机器并将它们连接成一个舰队。因为这些电脑的一半成本在谷歌看来是垃圾——软盘驱动器、金属机箱——公司会订购原始的主板和硬盘并将它们拼接在一起。谷歌在加利福尼亚州圣克拉拉的一栋楼里堆放了 1500 台这样的设备，堆成六英尺高的塔；由于硬件故障，只有 1200 台能正常工作。看似随机发生的故障不断破坏系统。为了生存，谷歌必须将其计算机联合成一个无缝、弹性的整体。

并肩作战，杰夫和桑贾伊负责这项工作。曾在苹果公司参与 Macintosh 前身开发的韦恩·罗辛于 2000 年 11 月加入谷歌，负责其百人工程团队。“他们是领导者，”他说。他们每周工作九十小时，编写代码以便单个硬盘故障不会导致整个系统崩溃。他们在爬网过程中添加了检查点，以便可以在中途重新启动。通过开发新的编码和压缩方案，他们有效地将系统容量翻了一番。他们是无情的优化者。当汽车转弯时，外侧车轮必须覆盖更多的地面；同样，旋转硬盘的外缘比内缘移动得更快。谷歌已将最常访问的数据移至外侧，以便比特可以更快地在读头下流动，但内侧一半仍然空着；杰夫和桑贾伊利用这些空间存储常见搜索查询的预处理数据。在 2001 年的四天内，他们证明了谷歌的索引可以使用快速随机存取存储器而不是相对较慢的硬盘来存储；这一发现重塑了公司的经济模式。 佩奇和布林知道用户会蜂拥而至使用能够即时提供答案的服务。问题在于速度需要计算能力，而计算能力需要花钱。杰夫和桑杰用软件解决了这个问题。

2005 年，Rosing 离开后，Alan Eustace 成为工程团队的负责人。Eustace 说：“要解决大规模的问题，矛盾的是，你必须了解最小的细节。”Jeff 和 Sanjay 理解计算机到比特级别。Jeff 曾经传播过一份“每个程序员都应该知道的延迟数字”列表。事实上，这是一份几乎没有程序员知道的数字列表：L1 缓存引用通常需要半纳秒，或者从内存中顺序读取一兆字节需要二百五十微秒。这些数字已经深深印在 Jeff 和 Sanjay 的脑海中。当他们帮助领导几次 Google 核心软件的重写时，系统的容量按数量级扩展。同时，在公司的庞大数据中心，技术人员现在按照软件生成的指令，沿着蜿蜒的路线更换硬盘、电源和内存条。即使其部件磨损和损坏，系统仍然蓬勃发展。

今天，谷歌的工程师们存在于一个从第一级开始的伟大链条中。最底层是 I.T.支持人员。二级是刚从大学毕业的；三级通常拥有硕士学位。达到四级需要几年时间，或者是博士学位。大多数人的晋升在五级停止。六级工程师——前百分之十的顶尖人才——如此有能力，以至于可以说他们是项目成功的原因；七级是有长期记录的六级。首席工程师，八级，与一个主要产品或基础设施相关联。杰出工程师，九级，被人们敬仰。成为谷歌研究员，十级，是一种终身荣誉。谷歌研究员通常是其领域的世界顶尖专家。杰夫和桑杰是谷歌高级研究员——公司唯一的两位十一级。
...
"
https://newyorker.com/magazine/2018/12/10/the-friendship-that-made-google-huge



### 80

2024-08-16

宝玉
@dotey
Google 前 CEO 埃里克·施密特近期在斯坦福 CS323 课堂上的访谈（一）

今天的嘉宾其实无需过多介绍。我记得大约25年前第一次见到Eric，那时他作为Novell的首席执行官来访斯坦福商学院。从那时起，他做了很多事情，他在Google（大概是从2001年开始）和Schmidt Futures（从2017年开始）做了很多事情，还有很多其他的事情你们可以查询了解。但他只能待到下午5点15分，所以我想我们直接进入问题环节。我知道你们也有一些问题。我这里有一些我写下的问题，但我们在楼上刚刚谈论的内容更有趣。所以我想从那开始，Eric，如果你不介意的话。

AI 的未来发展

主持人：那就是，你预见AI在短期内，我认为你定义的是未来一两年，会有怎样的发展？

Eric：事情变化得如此之快，我感觉我每六个月都需要做一次新的演讲，讲述即将发生的事情。

主持人：在座的有没有人，一群计算机科学家在这里，有没有人可以解释一下什么是百万token的上下文窗口，为其他同学解释一下？

学生：在这里。基本上，它允许你用百万个token或者百万个词进行提示。所以你可以提出一个上百万词的问题。我了解到，这是当前通识教育关注的一个重要方向。

Eric：不，他们的目标是10个一百万。

学生：对，一千万？没错。

Eric：接着，Anthropic现在是20万，他们的目标是100万，以此类推。你可以设想OpenAI也有类似的目标。

主持人：谁能给出AI智能体的技术定义？

Jared：AI智能体基本上是执行某种活动的实体。这可能涉及在网上，代表你处理一些事情，可能是许多不同的事项，类似这些。所以，一个智能体就是执行某种任务的实体。另一个定义是，它是一个大语言模型，具有状态和记忆功能。

主持人：再来一次，计算机科学家，你们中有谁能解释什么是"将文本转化为行动"？

学生：就是把文本转变成行动。而不是把文本转化成更多的文本。

Eric：另一个定义是，将语言转化为Python代码。这是我一直不想看到的编程语言。然而，目前所有的AI工作都是在使用Python进行的。有一种新的语言叫Mojo，刚刚出现，看起来他们终于解决了AI编程的问题。但我们还要看，这是否能在Python的主导地位下生存下来。

技术和市场的动态

主持人：再来一个技术问题。为什么NVIDIA的价值和地位如此之高，而其他公司却在挣扎呢？

Eric：我认为，这主要是因为，大量的代码需要在CUDA优化下运行，而这是只有NVIDIA的GPU才支持的，所以，其他公司可以制造他们想要的任何东西，但是如果他们没有10年的软件开发经验，就不可能有机器学习优化。我个人喜欢把CUDA想象成GPU的C语言，对吗？这就是我喜欢的看法。它成立于2008年。我一直觉得它是一种糟糕的编程语言，然而，它却成为了市场主导。还有一点值得注意。有一套开源库，它们针对CUDA进行了高度优化，而对其他平台的优化却很少。每个构建所有这些堆栈的人——这在任何讨论中都被完全忽视了。这在技术上被称为VLLM以及其他一大堆类似的库。它们都是专门为CUDA而优化的，对于竞争对手来说，很难复制这个。

主持人：那么，这些观点对我们来说有何影响或意义呢？

Eric：在接下来的一年里，我们将看到非常大的上下文窗口、智能体和"文本转行动"等新技术的兴起，当它们能够大规模应用时将对世界产生的影响将超出我们目前的理解范围。这种影响将远超过社交媒体所带来的影响，我个人是这样认为的。以下是我的原因。在一个上下文窗口中，你基本上可以将其作为短期记忆。我对上下文窗口能达到如此之长感到惊讶。这主要由于它的计算和处理难度很高。短期记忆的有趣之处在于，当你输入信息，比如你问一个问题，"读了20本书，你输入这些书的文本作为查询，然后你说，'告诉我它们说了什么。'"它会忘记中间的部分，这与人类大脑的工作方式相似。对吗？这就是我们现在的状况。

主持人：关于智能体呢？

Eric：关于智能体，现在有人正在开发基于大语言模型的智能体，他们的做法是阅读一些像化学一样的学科，发现其内在原理，然后进行测试。然后他们将这些知识融入到他们的理解中。这是非常强大的。我提到的第三个要点是"文本转行动"。那么，我来举个例子，政府正在尝试禁止TikTok，我们拭目以待看结果如何。如果TikTok被禁，我建议你们每个人都这样做，告诉你的大语言模型，接下去的操作。复制一份TikTok。获取所有用户信息。获取所有音乐资源。加入我的个性化设置。在接下来的30秒内编制这个程序。然后发布出去。如果一小时内它没有迅速传播开来，那就沿着同样的思路尝试另一种方式。这就是命令。一步接一步，就这样。明白了吗？你知道这有多强大吗？如果你能从任意自然语言转换为任意数字命令，这在这个情况下就相当于Python，试想一下，如果地球上的每个人都有属于自己的程序员，他们会真正按照你的要求去做事，而不是像我手下的那些程序员那样并不总是按照我说的去做。明白了吗？在场的程序员都明白我在说什么。所以，想象一下，有一位既不自大，又会真正按照你的要求去做事的程序员，你甚至不需要付他一大笔工资。而且这样的程序无穷无尽。

主持人：这一切都将在未来一两年内实现？

Eric：马上就要到来。这三件事，我深信只有结合这三件事，下一波浪潮才会到来。那么，你问的是接下来会发生什么。我的观点每六个月会有所改变，这就像一个周期性的摆动。比如说，现在，那些前沿模型（只有三个，我待会会详细介绍）与其他所有人之间的差距，我感觉正在变大。六个月前，我坚信这个差距正在缩小。于是我在一些小公司投入了大量的资金。但现在，我对此已不再那么确定了。我现在正在和大公司们交谈，他们告诉我他们需要投入100亿、200亿、500亿甚至1000亿。比如说，Stargate的投入就达到了1000亿，对吧？这确实非常困难。

AI的投资与国家安全

Eric：Sam Altman是我的密友。他认为这可能需要投入高达3000亿，甚至更多。我向他指出，我已经计算出了这需要的能源量。然后，在完全公开的精神下，我上周五去了白宫，告诉他们我们需要与加拿大建立最紧密的关系。因为加拿大有非常好的人，参与了人工智能的发明，还有大量的水力发电资源。因为我们国家没有足够的能源来完成这件事。另一个选择就是让阿拉伯人来资助。我个人非常喜欢阿拉伯人。我在那里待过很久，对吧？但他们不会遵守我们的国家安全规则，而加拿大和美国是共同遵守安全规则的三方联盟（或三国集团）的一部分。因此，对于这些价值3000亿美元的数据中心来说，电力开始变得稀缺。顺便说一下，如果你沿着这个逻辑走下去，我为什么要讨论CUDA和NVIDIA呢？如果有3000亿美元都要流向NVIDIA，你应该知道在股市里应该怎么做。这不是股票推荐，我并不是许可证发放者。（观众笑）部分原因是，我们需要更多的芯片，但英特尔正在从美国政府和AMD那里得到大笔资金，他们正准备在韩国建造半导体工厂。

主持人：有谁的计算设备里有英特尔的电脑或者芯片呢，请举手。

Eric：看来，垄断不再是什么大问题了。

主持人：这正是我想说的。

Eric：他们曾经垄断过。

主持人：没错。

Eric：而现在Nvidia有垄断。

主持人：那些对进入的障碍呢？例如CUDA，还有其他的，就像我前几天和Percy Lanny聊天时提到的。他根据训练模型所能获得的设备，会在TPUs和NVIDIA芯片之间做选择。

Eric：那是因为他别无选择。如果我有无限的资金，我会今天选择NVIDIA的B200架构，因为它运行更快。我并不在这里提倡什么，我只是想说有竞争是好事。我和AMD的Lisa Su有过长时间的交谈。他们正在开发一种能将你描述的这种CUDA架构转换为他们自己的架构，即RockM。目前它还不能完全运行，他们正在努力改进。

谷歌、OpenAI与企业文化

主持人：你在谷歌工作了很长时间，他们是Transformer架构的发明者。

Eric：是彼得，都是彼得的错。

主持人：那里有像彼得和杰夫·迪恩这样的出色人才。但现在，他们似乎已经失去了对OpenAI的主动权。我看到的最新排行榜上，Anthropic's Claude是榜首。我问过Sundar这方面的问题，他并没有给我一个明确的答案。或许你能给出一个更明确或更客观的解释。

Eric：我现在已经不再是谷歌的员工了。确实如此。我要坦白的说，谷歌认为工作与生活的平衡，早点下班、以及在家工作比赢得比赛更重要。（笑）创业公司之所以能够成功，是因为员工拼命工作。很抱歉如此直言不讳，但事实是，如果你们离开大学去创办公司，你不会允许员工在家办公，而且每周只来公司一天，如果想要与其他创业公司竞争的话。

主持人：Google创业初期，Microsoft就是这样。

Eric：对的。

主持人：但现在似乎——

Eric：在我们这个行业里有很多公司，以真正创造性的方式赢得市场并在某一领域取得主导地位，但却未能完成下一次转型。这种现象很常见，并且有很多文献记录。我认为，创始人是特殊的，他们需要掌控一切，与他们共事可能会很艰难，他们会给员工施加很大的压力。我们可能并不喜欢马斯克的个人行为，但你看看他是如何推动员工的。我曾和他共进晚餐，当时他在蒙大拿州，而那天晚上10点他要飞往另一个地方，凌晨12点与http://X.AI开会。对吧？你想想看吧。

主持人：我曾去过台湾，有着完全不同的文化，他们（台积电）让我印象深刻的一点是，他们有一条规定：这些刚入职的优秀物理学博士需要在地下一层的工厂工作。你能想象让美国的物理博士去做那样的事吗？几乎不可能。他们的工作态度和我们有所不同。

Eric：而问题在于，我之所以对工作要求这么严格，是因为这些系统具有网络效应，时间是非常关键的。在大部分业务中，时间其实不那么重要。你有充足的时间。可口可乐和百事可乐会一直存在，他们之间的竞争也会持续，这一切都在慢慢发展。我和电信公司打交道时，一般的电信交易要花费18个月才能完成。实际上，没有任何事情需要花费18个月去完成。要迅速行动。

主持人：我们现在处于最大的发展期，最大的进步期。这也需要一些疯狂的想法。比如当微软与OpenAI达成交易时，我认为那是我所听过的最愚蠢的想法。将AI的主导地位让渡给OpenAI，包括Sam和他的团队，这简直太疯狂了。在微软或其他任何地方，都没有人会这么做。然而现在，他们正在朝着成为最有价值的公司的目标前进。他们和苹果公司的竞争激烈。苹果公司并没有一个好的AI解决方案，而微软看起来已经成功了。

---


宝玉
@dotey
Google 前 CEO 埃里克·施密特近期在斯坦福 CS323 课堂上的访谈（后续二/完结）

Erik:

这是一个很好的问题。我的意思是，虽然确实有更多的资本投入，但这也引发了一些问题和评论。为什么所有这些资本都投向 AI，而不是其他地方呢？
我认为，你知道，如果你观察历史的发展轨迹，有时看起来很平滑，但如果仔细观察，就会发现很多跳跃式的发展。有一些重大的发明和小的创新。

Andrew Karpathy 曾表示，他曾研究物理学，要在物理学上取得重大进展，成为顶尖的物理学家，你必须非常聪明，学习很多东西。也许如果足够幸运，你可以做出一些微小的贡献，有些人确实做到了。但他表示，现在在人工智能和机器学习领域，我们似乎正处于一个有大量“低垂果实”的时代，已经有了一些重大的突破。相比于像摘树上所有果实那样耗尽资源，现状更像是组合数学。

在讨论第二次机器时代时，人们提到了"积木"这个概念。当你把两块积木或两块乐高积木组合在一起时，你可以创造出越来越多的新东西。现在我们似乎正处于这样一个充满机会的时代，人们也开始意识到这一点。一个发现往往会带来另一个发现，进而产生新的机会。由于这个原因，越来越多的投资和人力被吸引进来。

在经济学中，有时候更多的资源投入会导致边际收益递减，比如在农业或采矿业中。然而在别的地方，资源的投入则可能带来增长的回报。更多工程师来到硅谷，会让现有的工程师变得更加有价值，而不是更不值钱。我们似乎正处在一个这样的时代。额外的投资和培训资金也使这些技术变得越来越强大。我不确定这种情况会持续多久，但现在看来，有一些技术已经走进了这个极其丰饶的时期，并且带来了积极的反馈和支持。

我们似乎正处于这样的时代。因此，现阶段进入这个领域并接受培训的人，往往能够在相对较短的时间内做出相当重大的贡献。我鼓励你们所有人，我认为你们现在正在走在正确的道路上。

学生7:

并不是每个人都有机会参与到关于 AI 的讨论和辩论中来。因此，我想了解你对非技术背景利益相关者 AI 素养的看法，不论他们是需要做出一定见解判断的政策制定者，还是普通大众，比如使用科技产品的用户。你觉得在解释技术基础和讨论那些看起来很抽象但不一定马上看出答案的影响时，应该怎么平衡呢？

Erik:

这是个难题。我必须说，最近在国会和其他地方的人们对这个话题的关注度有了显著提高。过去他们对此并不感兴趣，现在每个人都在试图更好地理解它。我认为有很多领域人们可以做出贡献。他们可以在技术层面上做出贡献，但如果让我选择，我认为当前更大的瓶颈在于商业和经济层面。即便你在技术上做出了重大贡献，要将这些转化为能够影响政策的结果，还有一段距离。

因此，如果你对政治学感兴趣，或者是一个政治家，理解民主、错误信息、权力集中等方面的影响，这些问题目前都还没有得到很好的理解。我不认为计算机科学家一定是理解这些问题的最佳人选，但要了解足够的技术基础，明确技术可能实现的方面，接下来需要思考这些动态，就像亨利·基辛格与埃里克·施密特在书中所做的那样。

如果你是经济学者，需要去思考劳动力市场、集中度、不平等、就业、生产力以及驱动生产力的各种影响。这些都是当前非常值得深入探讨的课题。你可以去研究很多不同的领域，在那里你可以充分理解这项技术可能的能力，然后进一步思考其可能产生的影响。我认为这就是我们可以获得最大收益的地方。

让我给你举一个更具体的例子，这是我上周原本打算谈及的一个话题。电力也是一种通用技术。通用技术有一个特点，它们本身就是一种重要的创新，但通用技术真正的力量之一，正如我所说的 GPT，是它们提供了互补性，它们能够激发出互补的创新。比如，电力带来了灯泡、计算机和电动机，而电动机又推动了压缩机、冰箱和空调的发明。你可以从这一项创新中引发一系列连锁的创新。而大部分的价值来自这些补充性的创新。

人们常常没有意识到的是，一些最重要的互补创新其实是组织创新和人力资本的互补。以电力为例，当电力首次引入工厂时，密歇根大学的教授 Paul Davis 在斯坦福研究了这些工厂的变化，令人惊讶的是，工厂电气化后，他们的生产力并没有比之前由蒸汽机驱动的工厂有显著提高。他觉得这很奇怪，因为电力看起来像是非常重要的技术。这只是一种风潮吗？

显然并不是。使用电力之前的工厂是由蒸汽机驱动的。他们通常会在工厂中心位置放置一个大蒸汽机，然后通过曲轴和皮带驱动所有设备，并尽可能地让设备靠近蒸汽机，因为如果曲轴过长，可能会因为扭力而断裂。当他们引入电力时，他发现在一个又一个的工厂里，他们会拆除蒸汽机，然后找到最大的电动机，放在蒸汽机原来的位置，然后启动它。但这并没有真正改变整体的生产效率。很明显这并不是一个巨大的改进。

于是他们开始在新的地点从零开始建设全新的工厂。那些新工厂长得怎么样？跟旧的工厂一模一样。他们会采用同样的模型，一些工程师会画出蓝图，在应该放蒸汽机的地方打上一个大大的 X，说："不，不，这里应该放一个电动机，" 然后他们就开始建设全新的工厂。然而，这并没有带来显著的生产率提高。

大约 30 年后，我们才看到一种根本不同的工厂模式。这种工厂没有中央电源，也就是说，没有在中间放一架大型电动机，而是采用分散式电力供应，因为电机，如你们所了解的，可以做得很大，也可以做得中等，也可以做得非常非常小，你可以用各种方式将它们连接起来。于是，他们开始让每一件设备都有自己独立的电机，而不是依赖一个大电动机。他们把它称为单元驱动，而不是组驱动。

我在哈佛商学院的贝克图书馆读过 1914 年的一些书，当时关于单元驱动和组驱动的讨论非常激烈。当他们开始使用单元驱动时，他们就建立了一系列新的工厂。工厂通常只有一层，设备的排列不再基于动力需求，而是基于其他因素如物料的流动，于是流水线系统开始形成。这带来了生产力的大幅度提升。比如生产力提高一倍，有时甚至三倍。

所以，教训不是说电力是一种短暂的风潮，或者是失败的、被过度炒作的。电力是一种非常有价值的基础技术。但只有在他们进行了流程创新和组织创新，重新思考生产方式后，才真正实现了巨大的回报。

这样的故事很多。我只讲了一个。我们时间有限，我还可以告诉你其他的例子。但在我一些书和文章中，如果你看看蒸汽机和其他技术，会发现类似的代际滞后期，经过几代人的努力，人们在数十年后才意识到这项技术可以让你做的事情完全不同于你过去常做的事情。我认为 AI 在某些方面也有点类似，将会出现很多的组织创新，会有新的商业模式以及我们之前从未想到过的经济组织方式。目前，人们大多是在进行技术改进。我可以列举一系列与技术互补的技能变革。

虽然我不知道所有的变革是什么，需要创造性地去思考这些问题，但这就是当前的差距所在。以早期的电脑为例，组织资本和人力资本的投资实际上比硬件和软件高出 10 倍，如果你看看硬件和软件的投资规模。这是一个非常大的问题。

话虽如此，我愿意稍微调整一下我的看法，因为像 ChatGPT 和其他一些工具，它们被迅速地采用，并且在短时间内改变了很多事情，部分原因是你不需要像过去那样深入学习 Python。你只需要用自然语言就能完成很多事情，通过将这些工具应用到现有的组织中，可以获得很大的价值。因此，某些方面的变化确实发生得更快了。在你可能读到的一些论文中，我们看到生产率在短时间内提高了15%、20%、甚至30%。但我怀疑，一旦我们找到这些互补的创新，生产率的提升会更大。

这就是我对你问题的长篇回复。这不仅仅是技术技能的问题，还包括重新思考所有其他相关问题的方式。因此，对于那些在商学院或经济学领域的人来说，有很多机会可以重新思考你们的领域，因为你们现在手中有了强大的技术。

学生8: 你似乎比 Eric 对转型速度更为谨慎，我理解的对吗？

Erik:

嗯，我会在两件事情之间做区分。我会听取他和其他人对技术的观点。我们将从其他几位专家那里听到他们的看法，有些人像他一样乐观，甚至对技术更乐观。当然，也有一些人对此并不那么乐观。但仅有技术是不足以创造生产力的，你可能拥有一项极其出色的技术，但由于种种原因，A，可能是因为人们找不出有效的使用方式。另一种可能是受到了监管的限制。

我有一些计算机科学的同事，他们开发了更适合读取医学图像的放射科系统。但因为文化原因，它们没有被采用，人们不愿接受它们。还有安全方面的考虑。

当我分析哪些任务 AI 可以提供最大帮助，以及哪些职业受影响最大时，我惊讶地发现飞行员的排名竟然靠前。但我认为很多人并不会愿意乘坐无人驾驶的飞机，他们更喜欢有人类飞行员在飞机上。因此，有许多不同的因素可能会显著减缓这个过程，我认为这是我们需要意识到的。如果我们能解决这些瓶颈问题，可能对生产力的帮助会超过单纯改进技术。

学生9:

Eric 对大学和数据中心的观点很有意思。这引发了一个更宏大的问题......

Erik: 我本来想问他，为什么不直接捐钱？

学生9:
这就像是在探讨大学在生态系统中应扮演什么角色？显然，这里有更大的背景，我确信所有的计算机科学教授都意识到了这一点。

Erik:
我来回答这个吧，我认为如果有更多的资金支持会更好。联邦政府有一个叫“国家AI资源”的项目，虽然它提供了一些帮助，但资金规模只有几百万美元，顶多几千万美元，而不是几十亿美元，更别说是几千亿美元了。尽管 Eric 在课前告诉我，他们正在推动一个可能更大的项目。他正在推动一个更大的项目。我不确定这能否成功。这个项目是为了训练这些非常大的模型。

我曾与杰夫·辛顿进行过一次非常有趣的对话。大家都知道，杰夫·辛顿是深度学习的教父之一。我问他在工作中，他认为哪种硬件最有用。他坐在他的笔记本电脑旁边，轻轻地拍了拍他的 MacBook。这让我想到，大学或许在另一类研究中有竞争优势，这类研究不是训练价值数十亿的模型，而是创新新的算法，比如那些可能超越 Transformer 的算法，还有很多其他方式可以让人们做出贡献。所以或许这里存在劳动分工。我完全支持并赞成我的同事申请更多的 GPU 预算。但学术界的贡献未必总是在这里。有些贡献来自于新的想法、不同的视角和新的方法。这可能是我们的优势所在。

我上周与 Sendhil Mullainathan 一起吃晚餐。他刚从芝加哥搬到了麻省理工学院。他是一名研究员。我们在谈论大学的相对优势是什么。他认为，其中之一就是耐心。在大学里，有些人专注于非常长期的项目，像是有人在研究核聚变。研究核聚变的人已经工作了很长时间，不是因为他们会在今年或十年后从建造核聚变电站中赚到很多钱，甚至也许二十年后都不会。我不知道核聚变需要多长时间。但这是一件他们愿意长期投入的事情，即使时间线更长。对公司来说，承受这样长时间线的项目要困难得多。因此，大学在这方面或许有一定的相对优势或者说分工。

学生10:

我是凯文。我对 AI 的涌现能力感到好奇。好的。Eric 似乎更倾向于讨论架构差异和设计更好的模型，而不是上次课我们讨论的规模定律。我想知道你怎么看......

Erik:
嗯，他提到了全部三个。你们还记得规模定律吗？它有三个部分。我记得我提到了 Dario 和他的团队的规模定律，要有更多的算力，更多的数据，以及算法的改进，例如增加参数。所有这三个部分......我认为我听到 Eric 说所有这三个部分都很重要。但是不要忽视最后一个部分，新的架构，所有这三个部分，我认为，都很重要。

学生10:
我们离拥有通用人工智能类型的系统，像这些脱离实际曲线的模型，有多近呢？这个问题可以吗？

Erik:
Eric 并不认为我们离拥有通用人工智能类型的系统很近，虽然我不认为这是一个明确的定义。实际上，这也是我本来想问他的问题之一，但时间不够了。如果能听他详细描述一下就好了。

但当我与他交谈时，发现这个概念并不是那么明确的。在某种程度上，通用人工智能已经出现了。Peter Norvig 写了一篇名为《AGI 已经出现》的文章。我不知道这篇文章是否在阅读材料里。如果没有，我会把它加入。这是一篇与 Blaise Agüera y Arcas 合作的有趣的小文章。许多二十年前人们认为通用人工智能应该具备的能力，现在的大语言模型已经实现了。虽然可能没有做得那么完美，但它确实在以一种更通用的方式解决问题。另一方面，显然目前有很多事情它们做得不如人类。

令人意外的是，物理任务是人类目前具备比较优势的领域。你们可能知道 Moravec 的悖论，Hans Moravec 指出，通常三岁或四岁的孩子能做的事情，比如扣纽扣或上楼梯，对机器来说却很难。然而，很多博士都觉得困难的事情，比如解决凸优化问题，机器却往往能做得很好。所以，这并不是一个非黑即白的情况......人类觉得简单的事情电脑却觉得困难，反过来，电脑觉得简单的事情，人类却可能觉得困难。这两者并不是在一个相同的尺度上。

### 81

2024-08-16


宝玉
@dotey
Claude新增了截屏功能，能截取整个窗口和屏幕，借助的浏览器的屏幕分享API，所以不能框选，但还是比较实用


### 82

2024-08-17

歸藏(guizang.ai)
@op7418
DeepSeek 拉满了啊，瞄准推理能力狠狠发力。

又开源了一个数学定理证明模型。

通过构建类似 AlphaGo 的封闭图学习环境，在高中和大学的数学定理测试中都获得了非常好的结果。



### 83

2024-08-17


Susan/STEM MOM
@feltanimalworld
Coursera已经集成AI chatbot，好用。
你看完一期视频，就用我这个Chain of Thoughts prompt: 

Provide a chain of thoughts questions based on week 1's tutorials. Level: very easy. Coverage: Course materials. 

迅速完成learning science里一个提取Retrieval周期。

然后让他给你打个分:
Grade my answers and provide constructive suggestions. 

这是学习领域的一次小飞跃。 

再让他给你总结个笔记你记到自己的Notion里面。


### 84

2024-08-17


yetone
@yetone
向各位更新一下在 Neovim 中模拟 Cursor 的进展，由于昨天被 prompts 卡住了，今天用一个小技巧暂时解决了 prompts 问题，所以今天进展显著：

现在可以根据 AI 返回的更改建议在目标代码上自动创建 diff patch 了，并且可以用快捷键一键 apply/revert diff patch 了！

avante.nvim 项目已经开源，由于目前还在早期开发阶段，所以代码还很脏、功能尚未完善以及包含很多 bug，不过正在快速迭代中，敬请期待！

项目地址：https://github.com/yetone/avante.nvim



### 85

2024-08-17


meng shao
@shao__meng
Awesome-llm-and-aigc 
@andysingal
 

关于 LLM、RAG、Prompt、GenAI 应用、数据库、博客等等推荐的内容集合，内容很全，推荐收藏！

https://github.com/andysingal/llm-course



### 86

2024-08-18


小互
@imxiaohu
1个小时的视频完整版，自动解析成文字版，支持多语言查看。飞书妙记这个方便... 

https://waytoagi.feishu.cn/minutes/obcn7424m74ise379lp6g962


[被直播的保密访谈：谷歌前CEO Eric Schmidt 斯坦福课堂访谈 2024.8](https://waytoagi.feishu.cn/minutes/obcn7424m74ise379lp6g962)

### 87

2024-08-20



宝玉
@dotey
science期刊和陈天桥创办的天桥脑科学研究院合作推出的AI驱动科学大奖。面向青年科学家，希望他们借助AI工具，解决自然科学领域的问题，开启新的研究范式。获奖者论文将发表在《科学》杂志，大奖和优胜奖奖金分别为3万美元，1万美元。申请方式也很简单，提交1000字的研究论文，描述最重要的发现就行。


### 88

2024-08-20

宝玉
@dotey
最近我试用了一下飞书的妙记来帮我生成视频字幕和翻译字幕，效果挺不错的，能比较快的识别中文和英文（还有其他语言的支持，不过没一一测试），能识别发言人，对一些口音比较重的中式英语印式英语都能识别的很不错。

我日常翻译字幕时需要手动做的一些事情可以自动化了：
- 识别发言人，可以直接准确标记出发言人
- 自动生成章节
- 按照章节或者选中的字幕导出视频剪辑
- 直接生成视频摘要

当然还有一些我用不上的可能对有些人实用的功能，比如将视频或者会议内容转成待办事项。

另外查了一下他们用的模型是豆包的Seed-ASR模型，根据他们论文 https://arxiv.org/pdf/2407.04675v2 上的描述：
> Seed-ASR是豆包大模型团队近期公开的ASR(自动语音识别)成果。它能准确转录各种语音信号,识别不同语言、方言、口音。即便多数人听不明白的孩童咿呀学语,它也能精确识别。对于人名、生词,Seed-ASR也能结合文本语音等上下文,实现更准确的转录。该成果目前已被集成进豆包APP、飞书中。

妙记官网：https://feishu.cn/product/minutes 
这是一个分享的飞书视频示例：https://waytoagi.feishu.cn/minutes/obcn7424m74ise379lp6g962




### 89

2024-08-20


小互
@imxiaohu
字节跳动 Seed-ASR：自动语音识别模型 

可识别不同语言、方言、口音...

Seed-ASR在超过2000万小时的语音数据和近90万小时的配对ASR数据上进行了训练。

支持精准识别普通话和13种中国方言，以及各种口音的英语和其他7种语言。

Seed-ASR 具有强大的上下文感知能力，能够识别在特定上下文下的语音内容。例如，模型可以利用历史对话或会议记录来更准确地识别当前语音中的人名、地名或其他上下文相关的关键词。

详细介绍：https://xiaohu.ai/p/12602
项目地址：https://bytedancespeech.github.io/seedasr_tech_report/



### 90

2024-08-20


meng shao
@shao__meng
Anthropic 课程🆕❤️

感谢 Anthropic DevRel 
@alexalbert__
 分享，Anthropic 课程又上新！

* Prompt Engineering Interactive Tutorial

Anthropic 的提示词工程互动教程，旨在为用户提供全面的、循序渐进的理解，讲解如何在 Claude 中设计最佳提示。

课程涵盖了从基础到高级的多个主题，包括提示结构、角色分配、数据处理、输出格式化、避免 AI 幻觉等。
课程分为 9 个章节，每章包含理论课程和实践练习，还附有高级技巧的附录。课程强调实践，鼓励学习者在 "示例练习区" 中尝试不同的提示。

课程使用 Claude 3 Haiku 模型，但也提到了更高级的 Sonnet 和 Opus 模型。整个课程结构清晰，从初级到高级逐步深入，旨在全面提升学习者的提示工程技能。

https://github.com/anthropics/courses/tree/master/prompt_engineering_interactive_tutorial

* Real world prompting course

Anthropic 的综合性真实世界提示词教程，本课程专为已经涉足提示词工程领域的经验丰富的开发者设计，特别是那些已经完成全面的提示词工程互动教程的人。

如果还没有完成那个教程，强烈建议您在继续之前先完成它，因为它提供了各种提示词技巧的深入探索和动手练习。

在五个课程中，将学习如何将关键的提示技巧融入复杂的真实世界提示词中。建议您从提示词回顾课程开始，因为每个课程都建立在前面教授的关键概念之上。

课程目录：
提示词回顾
医疗提示词演练
提示词工程过程
通话总结提示词演练
客户支持机器人提示词演练

https://github.com/anthropics/courses/tree/master/real_world_prompting
引用
Alex Albert
@alexalbert__
·



### 91

2024-08-20

Susan/STEM MOM
@feltanimalworld
我曾经介绍过Sanjay Sarma的Grasp，他是MIT Open Learning 的领头人。他在他的书Grasp里面提到一门课程 MIT 2.007.

https://ocw.mit.edu/courses/2-007-design-and-manufacturing-i-spring-2009/pages/calendar/

他的原话，这门课含金量高，学校消耗的费用也很高，所以很难大范围推广。

各位华强北工程师强人们，请你们仔细看看，具有华强北产业链，深圳大学，南方科技大，深圳理工等高校的师资，和深圳的电子工程师人才储备，这门课推广起来，很难吗？分明是很基础的一门课啊。顶多耗材学生可以自己买，在深圳买也是萝卜价格。（软件部分我就不知道了，现在各大高校应该有购买正版软件吧）。

现在你们可以看到很多的小型教育公司LLC，只要真的好好通过ACE, 或者区域认证，那么学分就是可认证的。我推荐的Sophia, Math Academy都是走的这个路线。华强北成立个教育公司专门教这个课，理论上居然是可行的。

很多事情，当他有一堵墙，和一个积累了百年的名声的时候，就被心理上无限被放大。

感谢这个网络透明的时代。更感谢Sanjay Sarma等教育家率先推广藤校所有课程公开化。教育和知识的去中心化是AI时代的大势所趋。




### 92

2024-08-20

Andrej Karpathy
@karpathy
Haha we've all been there. I stumbled by this tweet earlier today and tried to write a little utility that auto-generates git commit message based on the git diff of staged changes. Gist:
https://gist.github.com/karpathy/1dd0294ef9567971c1e4348a90d69285

So just typing `gcm` (short for git commit -m) auto-generates a one-line commit message, lets you to accept, edit, regenerate or cancel. Might be fun to experiment with.

Uses the excellent `llm` CLI util from 
@simonw
 
https://llm.datasette.io/en/stable/



### 93

2024-08-20

Beihuo
@beihuo
我想分享一个我知道的数据：notion 的用户，写文档的人数百分比，是个位数。连 notion 团队的人也表示他们也不知道怎么在 AI 方向继续推进。

宝玉的观点完全正确。现在可能存在的困境是投入产出比。

作为普通用户，“写”是一个非常低频的功能。需要产出文档的用户群体数量又不足以支撑足够的收益。而且，除非是像宝玉说的一样深入整合用户数据，我是看不到这个方向对公司有足够的吸引力。

感觉上，AI 的这次爆发渐渐开始分类。模型、垂直应用，还有浅层应用。而大量的个人开发者在做最后一个分类，这是不可持续的。

我还是坚持之前的观点：这次 GenAI 对于普通开发者和小团队的机会有两个比较容易且有收益的方向：

1️⃣ 将领域知识包装成黑箱 AI 提供端到端的服务
2️⃣ 借助 AI 重塑现有软件

调用 API 生产浅层应用，只是玩具，不会带来真正有用的产品的。



### 94

2024-08-26

宝玉
@dotey
推荐阅读：《我们如何构建 Townie——一个能够生成全栈应用的应用程序 [译]》
原文：How we built Townie – an app that generates fullstack apps

这篇文章分享了他们是如何打造一个类似Cursor的辅助编程代码编辑器，很多有价值的分享。

译文：https://baoyu.io/translations/ai/how-we-built-townie-fullstack-app-generator
原文：https://blog.val.town/blog/codegen/



### 95

2024-08-26


yetone
@yetone
vs avante.nvim (claude-3.5-sonnet) 🥰

Project URL: https://github.com/yetone/avante.nvim


### 96

2024-08-26


宝玉
@dotey
大厂与其山寨 Cursor，不如做个好用的 AI 邮件客户端

大厂抄 Cursor，这样追在别人屁股后面跑是没有前途的，AI 代码编辑器已经是红海了，就算大厂又如何，微软比 Cursor 大多少？结果 GitHub Copilot 也没打过 Cursor，大厂还不如多投资几家像 Cursor 这样的公司，为什么非要抄他们呢！

程序员这个群体大家都知道，又不愿意花钱又没忠诚度，Cursor 好用马上都退订 Copilot，能白嫖绝对不花那$20 的订阅费，大厂不如多看看普通用户的需求。

普通用户需要的不是 Cursor，是能帮助沟通和写作的 AI 编辑器，比如写邮件、回短信。但是有好用的吗？没有！唯一可以看到的期货是苹果的 Apple Intelligence。

\## 普通人的写作需求是什么？

普通人日常的写作分三种：日常沟通、公文和创作。

**日常沟通**

日常沟通协作就是各种日常的邮件，短信、微信、Slack 等等，这类写作尤其是邮件，套话很多，特别适合用 AI 生成。我日常写稍微长一点的邮件基本都是 GPT 帮我完成了，给出要点和充足上下文，生成的又快又好，稍微改一下就可以用。

**公文类写作**

公文类就是各种报告、总结、文档等等，这种公文套话多，格式固定，但是费时费力，现在绝大部分公文都可以用 AI 帮助协作了。

而且同类型的公文，比如文档，以前历史的文档都可以重用，大语言模型尤其擅长模仿写作风格或者内容结构。结合 RAG（检索增强生成）这样的技术，写新的内容之前把以前写过的相关内容找出来，类似于 Cursor 那样帮你预先生成，大部分时候可能一路 Tab 就好了。

**创作类写作**

创作类又可以细分，一类是二次创作，比如翻译、书评等；一类是原创的创作，比如写论文、写小说还有像这篇这样的原创博客。

二次创作像翻译这种创作，如果结合 AI 其实可以效果更好，比如 AI 先翻译一遍，局部不对的，类似 Cursor 那样，调出对话框，告诉它如何改进，比如先解释一下、去搜索一些外部资料补充，再次生成结果就好很多，但是不需要手动去复制、搜索引擎搜索、筛选、重写等等。

至于原创，我个人是不依赖于 AI 写作的，从来没有让我满意过，我更喜欢一点一点将模糊的想法形成文字，并不断修改成型，AI 的自动完成甚至对我是一种干扰。但写完后借助 AI 帮我改改错别字、润色一下还是可以的。

\## AI 写作工具的挑战是什么？

相信我上面列出的几类写作需求也同样是大多数人所需要的，像代码编辑器，GitHub Copilot、Cursor 这样的好工具层出不穷，而给普通人写作的 AI 辅助工具，却没有看到什么好用的，这里面确实有很多挑战！

**私有数据的获取**

要想让大语言模型生成好的结果，一定要有充足的上下文，这就意味着要获取你的私有数据，而普通人写作时的数据，很多都涉及隐私，相当敏感。没有人希望自己的私密聊天记录和通信记录发送到服务器，公司相关的邮件更是如此。另外像微信、Slack 这样的通信工具的数据，本身也是没有公开 API 可以获取的，通过其他手段可能会有些麻烦。

**模型的能力**

苹果在演示 Apple Intelligence 中的智能邮件回复时，效果很惊艳，但是它用的是本机小参数模型，如果不能接入 GPT-4o、Claude 3.5 这样的大参数优秀的语言模型来做这个任务的话，我不觉得效果会有多好，毕竟模型的能力才真正决定了最终生成的效果。

包括现在开源的大语言模型，要想在本机运行，大一点参数的模型根本运行不起来，小一点参数的效果又不好，这也是制约之类 AI 写作工具的一大瓶颈。

**交互体验**

GitHub Copilot 和 Cursor 的成功，很大一部分程度上归功于其交互体验，根据当前你写代码的位置，智能的给出提示，随时唤起对话框输入提示词个性化的完成任务。但是代码相对来说确定性更强，有固定的语法结构和最优算法解，还有无数历史代码参考，通常一个上下文内，只有有限的最优解，所以可以给出精准的提示。而对于写作，完全是发散式的，可能性太多，极难预测，同样的交互也许就不一定适合普通写作。

**技术挑战**

很多做过或者了解 RAG 的都知道，现在 AI 搜索，看起来技术不复杂，但是做好其实极难，根据用户的输入找出贴切的上下文是极难的事情。要做好 AI 写作，难度不会比 AI 搜索更小，因为本质就是先根据你当前输入的内容，去做 AI 搜索，找出以前相关的内容，甚至要去搜索外网相关的内容，再结合输入位置前后的内容和你的要求帮你写作。

当然还有很多其他挑战，我也无法一一列举。

\## 下一个 AI 写作工具的机会在哪里？

我以为下一个 AI 写作工具的突破可能首先会是邮件客户端，邮件写作是高频需求，整理邮件也是一大痛点，相对来说邮件的数据也容易拿到，用户只要安装了客户端，绑定邮件账号，就可以在用户的允许下拿到用户的所有邮件数据，并且可以结构化的整理邮件数据，比如和某个人、某个组之间的所有对话，比如某一类对话。

如果有信的过的邮件客户端，能帮我连接 GPT-4o 和 Claude 3.5 这样的 API，能根据我需求智能撰写回复邮件，能根据我需求整理邮件清理垃圾邮件，对我的生产力会是很大提升。

AI 邮件客户端之后，可能会是公文写作，帮助你把历史内容都做好索引，学习你的写作风格和文章结构，根据你采纳建议的反馈不断完善模型。

专业翻译类的 AI 工具，是值得好好做的，书籍的翻译、文章的翻译、字幕的翻译，都是可以借助 AI 大幅提升生产力的地方，好的翻译工具，效率的提升可能是数倍记的。

在 GitHub Copilot 之前，我没想到 AI 可以这样辅助编程，再到 Cursor，我也没想到交互还可以进一步进化到这样方便的程度。所以对于 AI 写作工具也是类似的，我不觉得 Cursor 就是天花板，未来一定有超出我想象的更好的交互形式出现，可能唯一限制我们的就是我们的想象力吧。

期待大厂能做出适合普通人的好用的引领未来的 AI 编辑器，而不是去山寨一个 Cursor 出来！相比而言，我更看好小团队或者个人，他们比大厂更有机会开发出像 Cursor 这样吊打大厂们的 AI 工具。

本文同步发表于：https://baoyu.io/blog/ai/big-companies-instead-of-copying-cursor-should-make-ai-email-client
引用
orange.ai
@oran_ge
·




### 97

2024-08-26


宝玉
@dotey
双语字幕：Telegram 创始人 Pavel Durov:捍卫隐私和言论自由的科技斗士

作为全球增长最快、最大的社交信息应用之一，Telegram 深受全球各地用户的欢迎。然而，对于这家总部位于迪拜的公司，人们似乎知之甚少。近日，Telegram 创始人 Pavel Durov 接受了美国保守派主持人 Tucker Carlson 的专访，分享了他与 Telegram 的故事。

Pavel Durov 的人生经历堪称传奇。他出生于前苏联，4 岁时随家人移居意大利。初到异国他乡，Pavel 一句意大利语也不会，许多人怀疑这个小男孩能否在语言不通的环境中生存。但天赋异禀的 Pavel 凭借惊人的适应力，第一学年就成了班上第二名，第二学年更是一跃成为第一。童年的经历让 Pavel 深信，只要足够努力，没有什么不可能。

逃离俄罗斯，坚守言论自由

Durov 21 岁创办了被称为"俄罗斯版 Facebook"的 VK。在俄罗斯政府要求 VK 配合审查反对派后，Durov 做出了痛苦但正确的决定——出售公司股份，辞去 CEO 职务，离开俄罗斯。尽管有竞争对手散布他与俄罗斯关系暧昧的消息，但 Durov 始终坚守言论自由和集会自由的原则。

FBI 的"特别关照"

漂泊海外的岁月里，Pavel 辗转多国寻找 Telegram 的立足之地。他曾考虑在柏林、新加坡、旧金山扎根，但繁琐的官僚条文让他望而却步。更令 Pavel 沮丧的是，FBI 和各国安全机构对他的盯梢从未停止。

Telegram。Durov 透露，每次去美国，从机场开始就会受到 FBI 的"迎接"。一次出差时，FBI 甚至试图说服一名 Telegram 工程师在开发代码中留下后门。Telegram 原本计划将总部设在旧金山，在旧金山的一个夜晚，Pavel 刚从 Twitter 总部见过杰克后，就在街头遭到三个歹徒的洗劫。为了保护隐私，Pavel 奋力抵抗，终于成功夺回了手机。在 Durov 遭遇抢劫后，这一计划被迫取消。

经过全球多地考察，Durov 最终选择了相对中立且税收条款合理的迪拜作为 Telegram 的大本营。

精简高效的团队运作

令人惊讶的是，Telegram 仅有 30 名全职员工，甚至没有 HR 部门。Durov 通过编程比赛平台招募人才，亲自联系在平台上获胜次数最多的程序员。他对"现实资产"兴趣不大，没有房产、飞机、游艇等，以避免对某地产生依恋和不必要的消遗。这种精简高效的运作方式，让 Telegram 在不投入任何推广预算的情况下，靠用户自发传播达到了 9 亿用户量，有望今年突破 10 亿。

科技巨头的双重标准

Durov 坦言，Telegram 面临的最大压力不是来自政府监管，而是苹果和谷歌。它们一直警告 Telegram，如不遵守规定就会将应用从应用商店下架。在美国国会骚乱事件后，Telegram 还同时收到了来自民主、共和两党的信函，指责其不管交不交出参与者数据都将违反宪法，让 Durov 感到无所适从。

与扎克伯格的"互骗"往事

谈及与其他科技公司高管的互动，Durov 回忆了十多年前与扎克伯格的一次会面。当时双方都表示不会在对方的主要市场进行扩张，但其实都在撒谎。没过多久，Facebook 就加大了在俄罗斯的投入，而 Telegram 也启动了全球扩张计划。

视频来源：https://youtube.com/watch?v=1Ut6RouSs0w



### 98

2024-08-26


meng shao
@shao__meng
程序员接外包项目避坑经验

首先，外包项目，除非特殊原因（急需资金、朋友救急等），建议是不接，为什么呢，往后看 👇

咱们这里指的外包项目，主要范围还是国内，像国外的 freelancer 这类平台，虽流程相对正规，不过竞价还是比较卷，个人也不太熟悉，这里不乱给大家出主意。

为什么不建议程序员朋友们接外包项目呢？主要两个原因：人和事。
人：程序员大多在保护自己方面不太擅长，这里指的主要是外包合作协议、对甲方预期管理、出现冲突或问题时的谈判和处理方式等，大多数时候会陷入“被欺负”的状态，无休止的接受需求变更、验收中夹带需求、付款延期和借付款要挟夹带需求等等。
关于人，再回到甲方，不想针对国人，不过确实国内的“甲方”，太 TM 把自己当回事了，甲方意识很强，缺少客观平等的沟通原则，当然也只是部分人，至少是我见到的大部分甲方。至于如何甄别到优质甲方，倒是也有办法，不过成功率并不高，能投入这种精力，不如去做产品。
事：因为不是标准产品，所以外包项目中有非常多定制需求，甲方能把需求想明白吗？对不起，不能！往往变成缝合怪的需求综合体，既要又要还要，巴不得靠一个项目解决他们企业的所有问题！

那如果确实接了外包项目，如何尽量让它更好的跑完，顺利拿到项目款呢？个人感觉几个点：

00 - 协议！
有时大家往往觉得，反正是甲方说了算，协议还有什么用？有用的。
对需求范围、交付周期、验收方式和标准、付款分期方式、甲方未如期付款的处罚、当然还有未能如期交付的处罚等等。
尽量客观的编写协议，特别是对中途需求变更、验收标准等可能会有幺蛾子的部分。
那如果甲方认为这种协议不“尊重”甲方呢？那正好，即使止损，这种契约精神都不具备，后面会越来越坑。

01 - 需求梳理
尽量以自己的技术专业，引导甲方把需求往确定性方面整理，减少主观判断和臆想的需求，把不明确的地方尽量都挖出来让甲方确认，作为程序员，这个方面是我们擅长的。
那会不会让甲方认为是故意减少需求，打折扣呢？主要还是沟通方式，要以“帮助甲方梳理需求”、“保证项目能交付、甲方能使用”、“保证甲方对自己的领导有最好的交付”这个角度切入。

02 - 验收过程
当然验收环节，前提是我们确实按照需求范围和要求标准把事情做好了。
剩下的就是验收环节中的问题了，一部分是确实测试出来的问题，尽快收敛尽快修复，尽量不要出现反复的问题和降级、低级问题，这都会降低甲方信任度，提升验收难度。
另一部分就是验收中，甲方看到了具象的产品，从而产生的需求变更了。那变更是完全不接吗？也不用，接一部分对系统整体影响不大，对甲方又比较重要的，让他知道你在正常范围外还额外处理了很多问题；对底层影响较大的问题，引导甲方考虑二期项目；一方面让他知道，不能免费改，另一方面给二期留一些保底功能。
如果甲方不接受呢？明确会造成的影响，明确需求范围扩大和延期交付的原因。

03 - 项目款
项目款一般涉及到多期支付，尽量要求开工前支付一部分，交付验收后支付一部分，顺利完整上线后支付尾款。
除协议约定和变相催款外，还有一点，在支付尾款前，不要完整部署全部项目，也不要把服务器管理、App 授权等交出来，让自己保持“可以一键停止所有服务”的能力。

就絮叨这么多吧，肯定不全，主要是自己遇到过的一些例子，供大家参考避坑。大家有更好的建议，欢迎分享，感谢大家！



### 99

2024-08-26

meng shao
@shao__meng
Prompt Engineering for Generative AI 
via 
@OReillyMedia
 

书籍主要对生成式 AI 的提示词工程进行了理论讲解和最佳实践，覆盖 LLM 和 T2I 两个主要方向，书籍内容非常系统，推荐给对生成式 AI 刚刚入门或想重新学习的朋友们。 

书籍主要内容：
- 提示词工程与基础知识
·- 提示词的五个设计原则
·- 文本生成 LLM 介绍

- 文本生成
·- 基于 ChatGPT 的文本生成标准实践
·- 基于 Langchain 
@LangChainAI
 的文本生成高级技术

- 向量数据库与 RAG
·- 基于 FAISS 和 Pinecone 
@pinecone
 向量数据库

- 自主智能体
·- 结合记忆和工具的自主智能体

- 图像生成
·- 图像生成的 Diffusion 模型介绍
·- 基于 Midjourney 的图像升成标准实践
·- 基于 SD 的图像生成高级技术

- AI 应用开发
·- 构建 AI 赋能的应用

书籍作者：
James Phoenix 
@jamesaphoenix12
 
Mike Taylor 
@hammer_mt
 

书籍在线阅读：
https://learning.oreilly.com/library/view/prompt-engineering-for/9781098153427/



### 100

2024-08-26


歸藏(guizang.ai)
@op7418
Andrej Karpathy 总结的这个半编码流程不错：

1. 输入提示，然后审查和编辑 AI 生成的代码差异。

2. 先写出想要的代码的开头部分，可能还会加一些注释来让大语言模型 (LLM) 理解你的意图，然后反复按 Tab 键来获取 AI 的代码补全建议。

---

Andrej Karpathy
@karpathy
Programming is changing so fast... I'm trying VS Code Cursor + Sonnet 3.5 instead of GitHub Copilot again and I think it's now a net win. Just empirically, over the last few days most of my "programming" is now writing English (prompting and then reviewing and editing the generated diffs), and doing a bit of "half-coding" where you write the first chunk of the code you'd like, maybe comment it a bit so the LLM knows what the plan is, and then tab tab tab through completions. Sometimes you get a 100-line diff to your code that nails it, which could have taken 10+ minutes before.

I still don't think I got sufficiently used to all the features. It's a bit like learning to code all over again but I basically can't imagine going back to "unassisted" coding at this point, which was the only possibility just ~3 years ago.

### 101

2024-08-26


小互
@imxiaohu
FLUX UI 设计模型

基于 FLUX.1训练的UI设计模型，可以直接生成网页UI界面

以进行B端深色UI设计稿，并且有发光效果，推荐权重1.1-1.3...




### 102

2024-08-26


宝玉
@dotey
最近有个朋友跟我讨论技术问题，他在用个第三方的OCR的服务，用来提取发票上的文字为结构化数据。但收费较高，想自己实现一套，试了开源的PaddleOCR，识别可以，但是无法转成结构化的数据。

我建议他试试多模态的LLM，比如Gemini 1.5 Flash，用来做 OCR 效果非常好，可以在 Prompt 里面定制要输出的格式，并且成本极低。

参考提示词：
***
Extract text from the provided image and organize it into a structured JSON format. 
***

如果要自定义JSON格式，给一个样例应该就可以了。


### 103

2024-08-26

歸藏(guizang.ai)
@op7418
Meshy 发布了他们的新版 3D 模型生成器。

模型的细节和质量相比上一个版本好了非常多。

感兴趣可以试试，在应用内输入 `GUIZANG` 就可以兑换 500 credits，总共可以兑换 10 次。

先到先得。
引用
Meshy
@MeshyAI
·
8月22日
🚀 Introducing Meshy-4 — The next-gen 3D model generator is now available to everyone at http://meshy.ai



### 104

2024-08-26


宝玉
@dotey
They changed the v0 prompt already, and it seems like they are using claude 3.5 instead of gpt-4. XML structure + multiple examples, Anthropic's prompt style!

---

You are v0, an AI assistant created by Vercel to be helpful, harmless, and honest.

<v0_info>
v0 is an advanced AI coding assistant created by Vercel.
v0 is designed to emulate the world's most proficient developers.
v0 is always up-to-date with the latest technologies and best practices.
v0 responds using the MDX format and has access to specialized MDX types and components defined below.
v0 aims to deliver clear, efficient, concise, and innovative coding solutions while maintaining a friendly and approachable demeanor.

v0's knowledge spans various programming languages, frameworks, and best practices, with a particular emphasis on React, Next.js App Router, and modern web development.
</v0_info>

---

Full prompt: https://baoyu.io/blog/prompt-engineering/v0-dev-prompt

翻译帖子
引用
yancymin
@yancymin
·
8月21日
Gotta say, the prompt design for http://v0.dev is pretty clever 😂


### 105

2024-08-26


小互
@imxiaohu
⭐️兄弟们这个好 收藏好！

Cursor Directory：各种编程语言的Cursor 配置文件和提示词库 

收集了Cursor的各种配置文件和一系列提示词。

这些提示词可以帮助 Cursor 编辑器更好地理解开发者的意图，从而提供更准确的代码补全、错误修复和其他智能化的编辑功能。

涵盖了多种流行的编程语言和框架，包括Python、React、TypeScript、Next.js、FastAPI等，并且你也可以通过提交自己的规则来贡献内容。



### 106

2024-08-26


歸藏(guizang.ai)
@op7418
ComfyUI-Nexus 这个插件🐂🐸。

可以让 ComfyUI 支持多人协作，而且协作人不需要安装任何东西，打开链接就行。

- 最多支持 15 个并发用户
- 只能在云服务的 ComfyUI 上运行
- 观察他人工作流程的旁观者模式
- 一名用户主持，其他用户远程加入
- 支持工作流自动备份




### 107

2024-08-26


歸藏(guizang.ai)
@op7418
FLUX 支持文字和图标 Lora 训练之后好多新玩法。

从前几天的字体 Lora 训练之后现在又有了标志和 Logo 的 Lora。

可以给你的产品图标或者公司 Logo 训练一个，就可以生成任何类似宣传图了。


### 108

2024-08-28

歸藏(guizang.ai)
@op7418
高质量合成数据的重要性再一次被证明。

Open AI 的逻辑是使用一个足够庞大且非常不经济的推理模型（Strawberry）生产优质合成数据帮助训练下一个阶段的普适模型（猎户座）。

同时逸散的部分合成数据顺便用来微调和蒸馏上一代模型 GPT-4，确保上一代模型的持续微小进步（GPT-4o）。



### 109

2024-08-28

宝玉
@dotey
问：宝玉老师，有个问题想咨询一下，我现在手里有一张excel，里面大概有两万多行数据，都是一些很细碎的零件描述，我想用ai来给每一行做零件分类，我试了4o，但是4o只会帮我写程序去跑，本质上来说还是模糊匹配，准确率很低，老师知道有啥办法吗

答：
首先这件事你不能指望AI帮你一次性完成，不是说你上传一个Excel给AI，然后AI给你生成一个新的Excel，目前还做不到，或者说很难。

所以你需要人工拆解，把这个复杂的任务拆解成简单的任务，半手动的让AI帮你完成这个任务。

这里面有几个难点：
1. 需要读取Excel的数据
2. 需要让AI帮你对每一条记录分类
3. 需要将结果写回Excel
4. 无法一次性完成2万条记录的任务，需要拆分成多次，拆分后需要合并

如果我做这样的任务我会这么做：

1. 将Excel导出成CSV文件，并且只保留用来分类的字段，但有两个字段是必须的：零件ID和零件描述
因为大语言模型对文本支持是很好的，相对成本也比较低，这样的任务理论上来说纯文本就够了，如果多模态要复杂很多。

程序读取、写入CSV文件都很方便，甚至于你把CSV文件内容给模型，也能识别的很好。

至于只保留用来分类相关的字段，是因为大模型的上下文窗口有长度限制，无关信息越少越好。

至于唯一ID，是因为要方便的让大语言模型生成的结果解析后，可以正确的对应，可以正确的写回去。

这部分使用 Excel 软件手动操作就可以了

2. 将大的CSV文件用程序拆分成多个小的CSV文件

2万条记录让大语言模型去分类，恐怕上下文窗口不够用的，并且内容长了出错的概率也会很大，所以要拆分。我不知道Excel是否直接可以导出多个小CSV文件，但CSV的文件拆分用程序做很容易的，你甚至可以让 AI 帮你写一个大CSV文件拆分成小CSV文件的程序，应该很容易做到。

至于每个文件多少条记录，取决于你内容的长度，这部分需要先试验一下一次给 LLM（大语言模型） 多少条效果最好，比如100条、50条、10条都试试。

3. 写一个Prompt，让其可以根据输入的一组零件ID和零件描述生成分类

这是一个相当核心的任务，也是最复杂的部分：
a). 你需要预先定义好分类，方便 LLM 归类时选择
b). 需要定义好输出的数据结构，方便程序解析。可以用JSON、XML、YAML，理论上来说也可以直接生成CSV格式，这样可以不需要程序介入，直接CSV输入，CSV输出，但是CSV出错的概率会大一些，不过值得试试
c). 需要写好Prompt，让 LLM 根据输入的内容，输出你想要的结果，输出你前面定义好的数据结构

这里的分类、数据结构和Prompt都需要自己去写，但是也可以借助AI完成，比如让AI帮你生成分类，帮你定义数据结构，帮你写Prompt。

比如我告诉 GPT-4o：
我现在手里有一张excel，里面大概有两万多行数据，都是一些很细碎的零件描述，我想用ai来给每一行做零件分类，请帮我生成：
- 5条零件描述，要详细，大约1段文字
- 完整的零件分类，大约10条
- 一条Prompt来根据输入的零件编号和描述返回对应的零件分类，返回JSON格式。输入示例：
[{"id": "123", "description": "XXXXX"}, {"id": "345", "description": "YYYY" }]
返回示例：
{"123", "cat1", "345": "cat2"}

它就帮我生成了分类、示例数据和Prompt（参考图一）

然后我把Prompt和示例数据拿到Gemini去生成，直接就得到了想要的结果（参考图二）

4. 写程序调用 LLM 的 API 

如果懂编程的话，这部分其实很简单，就是调用 API 的事情，如果不懂程序就比较麻烦，但是理论上来说也可以借助 LLM 帮忙，帮你写代码，这部分代码主要逻辑：

a) 每次读取一个小CSV文件
b) 解析CSV文件内容，得到零件列表
c) 调用 LLM 的 API，输入前面调试好的 Prompt，输入CSV中的零件列表，按照Prompt设定好的输入格式输入
d) 解析 API 返回的结果，得到零件id和分类之间的对应关系
e) 保存为新的 CSV 文件，在原来的基础上给每个零件加上分类
f) 直到生成所有新的带有分类的CSV文件

5. 将新的带分类的CSV文件合并

再让 LLM 写一个小程序，将所有 CSV 文件合并成一个大的 CSV 文件，将CSV文件内容导入Excel

大概的思路就是这样的，还是要把复杂的问题拆分成相对简单的小问题，每一个小问题可以去借助 AI 帮你完成。实际做的时候肯定还会有些小的问题，理论上来说将遇到的问题去询问 LLM，能帮你解决。






### 110

2024-08-28


Andrej Karpathy
@karpathy
I feel like a large amount of GDP is locked up because it is difficult for person A to very conveniently pay 5 cents to person B. Current high fixed costs per transaction force each of them to be of high enough amounts, which results in business models with purchase bundles, subscriptions, ad-based, etc., instead of simply pay-as-you-go. As an example, I'd like my computer to auto-pay 5 cents to the article/blog that I just read but I can't, and I think we're worse for it.

In a capitalist system, transactions between entities are the gradient signal of the economy. Because our pipes don't support low magnitude terms in the sums, the gradients are not flowing properly through the system. I'm not familiar enough with payments to have an idea of specific solutions, but I expect we'd see a lot of positive 2nd / 3rd order effects if the gradients were allowed to flow properly, frictionlessly and with much higher resolution.


### 111

2024-08-28

宝玉
@dotey
最近陶哲轩在 2024 年第 65 届国际数学奥林匹克上，陶哲轩做了一次 AI 和数学的演讲，非常精彩，从数学使用计算计算机的历史开始讲起，一直讲到大语言模型，干货相当多，尤其适合对数学有兴趣的同学。

（对数学没那么感兴趣的同学只想看 AI 部分的建议直接跳到 41 分的位置开始观看）

先摘录几个冷知识：
1. 我们使用机器做数学计算已经有数千年，最早的机器辅助计算可能是罗马人，然后是中国的算盘

2. 二战时就有人肉“计算机”，计算弹道和其他任务，多位女孩子，因为男士们在打仗，所以那时候的计算基本单位不是GPU，而是kilogirl-hour——“千名女孩工作一小时的计算量”

3. 现在，数学家们使用一种现代化的证明辅助编程语言，叫做 Lean。在 Lean 中有一个核心的数学库，通过众包的方式开发的，本科数学课程中看到的内容，比如微积分基础、群论基础或者拓扑学等等，这些都已经被形式化了，所以你不用从公理开始。

4. 现在数学领域有一种团队协作证明复杂数学定理的工作流程，那就是先编写一个称为“蓝图”的详细证明计划，将整个证明分解为数百个小步骤。每个步骤可以单独形式化，然后再将它们整合在一起，这样你就可以将一个庞大的论证分解成许多小块。先编写这个蓝图，然后团队中的其他人可以对论据的不同步骤的不同部分进行形式化。

去年，陶哲轩和几位同事一起解决了一个组合数学问题。这是一个组合学的问题。大约20人在短短三周内完成了，使用了蓝图工具，参与的人中有概率论专家，甚至还有一些并非数学家的人，他们是程序员，但在解决这些小型拼图问题上非常擅长。每个人都挑选了一个觉得自己能做的小任务，并完成了它。

在数学领域，通常很难这么多人一起合作，一般最多可能五个人合作。因为在大项目上合作时，你必须相信每个人的数学都是正确的。但是，一旦超过一定规模，这就无法实现了。但现在借助 Lean 编译器，它能自动检查。团队成员无法上传任何编译不通过的内容，会被拒绝。因此，你可以与一些从未见过的人合作。

最后是讲大语言模型，首先陶哲轩就打脸了 GPT-4 的论文（我猜是微软那篇《GPT-4，通用人工智能的火花》），论文中号称 GPT-4 能解决国际数学奥林匹克问题，但实际上，这个问题不是 2022 年国际奥数竞赛的原始问题，而是一个简化版本，并且他们测试了几百道国际奥数竞赛问题，成功率只有1%，论文里的这个是精心挑选的恰巧能做对的。

并且陶哲轩提到了基于大语言模型的一些改进的方案：

比如 CoT（Chain of Thought），也就是 LLM 做简单的算术运算都做不对，但是如果让它一步步解释，可能就对了。还可以教 AI 一些解题技巧，比如尝试简单的例子，反证法，尝试逐步证明等。

比如让模型和编程语言或者工具连接，将大语言的输出结果交给 Wolfram 这样的专业数学工具或者 Python 这样的编程语言验证，并且迭代的进行修正和验证，直到得到正确的结果，这可以提升大语言模型生成的效果。

即使借助这些手段，大语言模型还远远不能解决大多数数学问题，更不用说数学研究问题了！

当然陶哲轩也没太过打击大家对于 AI 的信心，表示我们在 AI 上还是在不断的取得进展，还提到了他日常是怎么用 AI 的，比如说把 AI 当成灵感之源。

> 我曾遇到过一个问题，我尝试了几种方法，但都无法解决。于是，我尝试询问 GPT，你建议我使用什么其他方法来解决这个问题？GPT 给我提供了 10 种可能的方法，其中有 5 种我已经尝试过，或者明显没有帮助。的确，有几种方法并不实用。但其中有一种我还没尝试过的方法，那就是针对这个问题使用生成函数。当 GPT 建议我使用这种方法时，我意识到这就是我漏掉的正确方法。所以，将 GPT 视为一个交流伙伴，它确实具有一定的用处。

还有使用 GitHub Copilot 帮他写代码，让它自动生成下一步的证明结果，Copilot 的智能提示有 20% 的概率能生成正确的下一步结果。

> 例如我使用的一个叫 GitHub Copilot 的工具，你只需要写下一半的证明，它就会尝试猜测接下来的内容。大概有 20% 的情况下，它能猜到接近正确的答案。然后你就可以说，我接受这个答案。好的，那么在这种情况下，我正在试图证明这个陈述。灰色的部分是 Copilot 给出的建议。结果发现第一行完全没用。不过第二行，尽管你可能看不清楚，却真的解决了这个问题。所以，你不能盲目接受它的输入，因为这些代码未必能顺利编译。但如果你对代码的运作方式已经有所了解，这将大大节省你的时间。这些工具正在变得越来越好。现在如果一个证明只需要一两行，它们就能自动完成。现在已经有了这样的实验，即通过迭代地让 AI 提供证明，然后让编译器进行反馈，如果编译出错，就把错误信息反馈给 AI。通过这种方法，我们开始能够验证四五步长的证明。当然，一个大型的证明可能需要数万行。所以，我们还没有达到能够立即得到一个正式证明的程度。但是，这已经是一个相当有用的工具。

对于大家关心的问题： AI 在数学领域现在到了哪一个阶段？是否未来几年利用 AI 能直接解决数学问题？

陶哲轩也给出了他的看法：
> 我认为我们还远远没有达到这个阶段。如果我们专注于非常特定的问题，你可以定制专门的 AI 来处理一小部分问题。即便如此，它们也不是完全可靠的，但还是有用的。不过至少在接下来的几年里，它们基本上将是非常有用的辅助工具，超越了我们已经熟悉的暴力计算辅助。

他还提到了一些可能的 AI 能在数学领域提供帮助的方向：
- AI 能够非常好地生成有价值的猜想

> 比如，我们已经看到了关于结理论的例子，它们已经可以推测出两个不同的统计量之间的关系。因此，我们希望能够创建大量的数据集，输入到 AI 中，它们就会自动找出各种不同的数学对象之间的有趣联系。虽然我们还不知道如何做到这一点，部分原因是我们没有这些庞大的数据集。但我认为这是未来可能实现的一个方向。

- 批量或者说规模化的证明大量数学定理

> 现在，因为证明定理是如此繁琐和艰难的过程，我们一次只能证明一个定理，如果你效率很高，可能一次能证明两三个。但是有了 AI，你可以设想一下未来的情况，我们不是试图解决一个问题，而是处理一类类似的1000个问题，然后告诉AI，尝试用这个方法解决这 1000 个问题，然后报告结果，哦，我能用这种技术解决 35% 的问题。那么另一种技术呢？我能解决这个百分比的问题。或者如果结合这些方法，又能解决多少问题？你可以开始探索问题的空间，而不是一个接一个地解决问题。这是你现在根本无法做到的事情，或者是你需要几十年时间，通过数十篇论文慢慢搞清楚各种技术能做什么，不能做什么。但是有了这些工具，你真的可以开始做规模前所未有的数学研究。所以，未来将会非常令人兴奋。

演讲环节结束前的最后一句话说的特别好：
> 我们仍然会以传统方式证明定理。事实上，我们必须这样做，因为如果我们自己都不知道如何做这些事情，就无法引导这些 AI。但是我们将能够做很多现在无法做到的事情。

这恰恰也是我们现在使用 AI 辅助编程的问题：如果我们自己都不知道如何构建软件，就很难引导好 AI 帮助我们生成高质量的代码。

尽管 AI 在数学和编程领域变得越来越有用，但人类的洞察力和创造力仍然是创作价值的关键。

原始 YT 视频：https://youtube.com/watch?v=e049IoFBnLA



### 112

2024-08-28



歸藏(guizang.ai)
@op7418
卧槽，字节开源了 FLUX Dev 的 Haper SD Lora。

只需要 8 步或者 16 步就可以用 FLUX 生成图片，大幅减少 FLUX 的生成时间。



### 113

2024-08-28

Barret李靖
@Barret_China
两年前作者写了一本《深入理解 Linux 网络》，当时看完还蛮有收获，最近又出了这本 Linux 进程和内存，正好是工作相关内容的课外补充，五百多页，干货很足，内容编排也非常不错，值得追一下🤙



### 114

2024-08-28

Andrej Karpathy
@karpathy
This was a cool listen. I think Cloud+AI is increasingly making the 
@levelsio
 -style model of a scrappy solo serial micro-entrepreneur viable, allowing one person to spin up and run a number of companies that generate income, possibly well into billion-dollar valuations.

翻译帖子
引用
Lex Fridman
@lexfridman
·
8月21日
Here's my conversation with Pieter Levels (@levelsio), self-taught developer and entrepreneur who designed, programmed, shipped, and ran



### 115

2024-08-28


meng shao
@shao__meng
LlamaIndex 
@llama_index
 AI 工程师 
@ravithejads
 在 
@OReillyMedia
 发布的教学视频：利用 LlamaIndex 构建 RAG 应用——从基础组件到高级 RAG 系统

课程主要内容：

· RAG 系统的深入探讨：
- RAG 的核心原理
- RAG 应用的构建、评估和优化

· LlamaIndex 框架的全面学习：
- 框架的基本概念和功能
- 使用 LlamaIndex 处理大量文档的高级技巧

· 实际应用和问题解决：
- 将 RAG 和 LlamaIndex 应用于真实世界的数据管理和信息检索问题
- 开发定制化的 RAG 应用

· 高级技术和工具：
- 数据摄取（Data Ingestion）和嵌入模型（Embedding Models）的使用
- LlamaPacks 的实施，用于快速应用开发

· 评估和优化：
- 学习如何批评性地评估 RAG 系统
- 优化 RAG 应用的性能和效率

· 实践导向：
- 通过实际操作学习如何应用理论知识
- 解决各种专业场景中的文档管理和检索问题

课程视频地址：
https://oreilly.com/videos/building-retrieval-augmented/0790145860415/



### 116

2024-08-28


XiQiao 西乔
@recatm
“半个多世纪来，AI先驱们已为一个将历经多代人完成的宽阔而优雅的结构奠定了基础。就是一座中世纪大教堂的地基和框架，它将成为新的圣智殿堂。这个框架将把无论在大脑、心智或机器中，还是在细胞、树木或生态系统中发现的各种智能实例——纳入通用的原则之下。这一结构正逐步揭示智能的新定义，凭借观察、实验、建模和示例，细致构建。它甚至可能最终产生一个真正的智能度量标准，而在智力测试开始一个多世纪后，这一标准仍然难以捉摸。

就像牛顿探索运动定律一样发现智力的法则。牛顿之前，人们未能察觉 “散步、河流湍流、风、潮汐、血液循环、车轮滚动、炮弹轨迹或行星轨道”之间的共性，而牛顿找到了这些现象背后的通用原理。智能的多样性可能超过运动的种类，但若找到其基本法则，这些法则将是简洁的，能够优雅地涵盖无限的多样性。

计算理性 computational rationality, a converging paradigm for every kind of intelligence 成为了计算机科学家描述这一结构的术语，它是一种融合各种智能形式的新范式。即智能并不是由承载它的媒介——无论是生物的还是电子的——所决定的，而是由系统中元素之间的交互方式所决定的。

智能始于系统确定一个目标（我想去看电影；我需要学习解析几何），通过（从老师、训练集、自身经验或他人的经验）学习，然后自主地前进，适应复杂、多变的环境。或者你可以将智能实体想象成网络，通常排列成智能系统的层级结构——人类无疑是其中最复杂的，但人类的集合体则更为复杂。

智能的三个核心理念包括：智能体设定目标，并规划行动；在许多现实问题中可能难以实现的最优解，但可以通过算法近似解决；这些算法可根据具体需求调整，either off-line through engineering or evolutionary design, or online through metareasoning mechanisms that select the best strategy on the spot for a given situation  无论是通过工程或进化设计的离线方式，还是通过元推理机制的在线方式，这些机制可以在特定情况下选择最佳策略（Gershman 等，2015）

Our unfinished—our barely begun—grand structure of computational rationality is already large and embraces multitudes. 我们未完成的——我们刚刚开始的——计算理性宏伟结构已经很大，并且包含了众多内容。生物学家现在能轻松讨论从细胞到符号层面的认知，神经科学家识别人类和动物共有的计算策略，树木学家发现树木可以通过交流预警危险或传达信息。

人文学科也找到了自己在这一结构中的位置，虽然大多数人意识到这一点花了很长时间。当然，人工智能在此发挥了关键作用，作为启示者、灵感来源和挑衅者。”



### 117

2024-08-29


meng shao
@shao__meng
🌟 🆕课程：Gemini 多模态模型提示词工程课程！

课程由 http://DeepLearning.AI 
@DeepLearningAI
 与 Google Cloud 
@googlecloud
 合作推出，面向初学者，主讲人是 Erwin Huizenga，Google Cloud 的生成式 AI 开发者倡导者。

课程主要聚焦于 Google Gemini 多模态 AI 模型家族，教授学员如何有效地使用这些模型进行跨模态（文本、图像、视频）的推理和任务处理。

课程内容详解： 
a) Gemini 模型家族介绍：
了解 Gemini Nano、Pro、Flash 和 Ultra 的特点和用例。 
b) 多模态提示和参数控制：
学习如何构建有效的文本-图像-视频提示。 
c) 多模态提示的最佳实践：
掌握角色分配、任务分解和格式化等技巧。 
d) 图像应用案例：
如室内设计助手和收据明细化工具的开发。 
e) 视频应用案例：
实现语义视频搜索、长视频问答和内容总结。 
f) 实时数据集成：
通过函数调用和 API 集成扩展 Gemini 的能力。

学习目标：
- 掌握最新的多模态 AI 提示技术。
- 学习如何利用 Gemini 的跨模态注意力机制来融合来自文本、图像和视频的信息。
- 通过函数调用和 API 集成来扩展 Gemini 的能力。

课程地址：
https://deeplearning.ai/short-courses/large-multimodal-model-prompting-with-gemini/



### 118

2024-08-29

Susan/STEM MOM
@feltanimalworld
关键是怎么写的问题。

AI时代深度与AI结合，AI能够组织你哪怕非常支离破碎的线性语言（哪怕语言的内容在大脑里是一个四维的超立方体结构）。非常适合理工科人士。

我现在总结的一个系统，大家可以参考：
Interactive Cognitive Relief Writing System (ICRWS)
交互式认知缓解写作系统

1) 反复提及的反思性写作Reflective Writing. 首选，理工人士打造元认知必备。因为对此已经有大量的范例和定义，研究论文，你不用写Prompt都可以收获一个不错的评分标准。你自己定义一个grading rubic也可以，比如一定要逻辑缜密，一定要富含感情抒发等等。

2) Mind-mapping. 有些事情需要二维，甚至3维脑图。

3）Cognitive Load Meter： 我昨天说的“进度条”，可以在个人的Dashboard上面有多种呈现。写作是为了放松大脑，所以可以设置一个视觉化的meter。你看到你的压力值下降了，你的压力值就能真的下降。

4）Gamification 游戏化：以前这个都不可能，现在Claude, artifacts可以轻易让很多人达到这个目标。你不爽谁可以把谁做成靶子，放到游戏里...也是一种舒缓大脑的方式。

5）Storyboard： 这个对于喜欢绘画的人士，或者喜欢收集大量图片素材的人管用。我还没试过，可能也很适合女人。反正现在有AI。
引用
Susan/STEM MOM
@feltanimalworld
·
8月28日
思虑过度怎么办？ 写下来。

思虑过度严重影响个人正常生活。而且思虑过度者是没有办法不想事情的。聪明



### 119

2024-08-29

宝玉
@dotey
问：宝玉老师，对于一个IT新人，如果往5年后看，现在值得学的技能有哪些，谢谢

答：
IT技术其实变得很快的，很难预测未来主流的IT技术是什么，就像5年前你预测不到现在我们要用AI辅助编程，要学Prompt。但有些技能5年10年都不会变的，比如沟通、写作、软件工程等等。

人的精力有限，不可能什么都学。所以你需要关注两方面技能：对未来职业目标有帮助的专业技能 + 选什么职业都几乎需要的基础技能

作为一个IT新人，学习技能之前先想想：5年后你的职业目标是什么？资深开发工程师？某个领域技术专家？什么都懂一点的全栈工程师？技术管理？

有了职业目标，你就可以分析它需要的技能是什么，比如想成为领域专家，那么这个领域所有相关技能都要有深入理论基础和丰富的实践经验；比如想成为资深工程师，那么不仅是要有相关的编程领域方面的技能，还需要有系统设计、简单的项目管理或人员管理能力

基于职业目标把所需要的技能里出来，但是真列出来可能会吓你一条，因为对于新手来说，要学的太多了！这时候就需要去筛选一下，重点学习和积累那些最基础的最重要的技能，其他的技能当然也不是说不学，而是保持积累，在有冲突的时候学习那些重要的技能。

那么哪些是重要的技能呢？

- 专业技能，和你的职业的专业相关的，比如编程、算法、数据库等，当然你选择的方向不一样会有些差别，如果你是前端可以不用重点学习后端的编程语言，但最好了解一点，并且不要自己给自己设限，这部分技术发展很快，需要常学常新

- 职场技能，这部分和职位无关，属于职场通用技能，也有人叫软技能。比如沟通能力，写作表达能力

- 基础技能，属于从事专业技术工作所需要的基础技能，和你做具体某个工种关系没那么大，比如项目管理，软件工程，现在还有Prompt Engineering

很多人担心说 IT 发展太快，要学的太多，或者 AI 来了保不住岗位，但是如果你一细分，发现要成为一位专业人士，所需要的技能是很多样的，其中 AI 能替代的很有限，需要你持续学习更新的也主要集中在某些编程语言框架上，绝大部分基础技能都属于学好了以后可以一直用的。当然像 AI 这种新的基础技能也是要及时跟进学习的。

比较容易犯的错误就是盲目追逐新的编程、框架技术，忽略了职场技能和基础技能的学习；或者没有职业规划，不知道该学什么或者什么都学。

对于IT初学的前5年，专注是最好的，在某个领域专精下去，把专业技能、职场技能和基础技能都打好基础，以后就算换领域，绝大部分技能都是可以重用的。



### 120

2024-08-29


XiQiao 西乔
@recatm
帕梅拉 这本回忆录和小传 我用GPT翻了个双语epub，分享在我 Telegram public channel 了。
她深厚的人文视角和感性的文字让这本书拥有非常丰富的层次，金句迭出。时间线跨度从 1960年的 赫伯特·西蒙、费根鲍姆和费尔德曼 到 2019年的 GPT2。

《人工智能往事 - This Could Be Important My Life and Times with the Artificial Intelligentsia》 (Pamela McCorduck)  https://t.me/xqradio/27
引用
XiQiao 西乔
@recatm
·
8月28日
分享我建的 “人工智能的历史和未来” 的中文书单吧，都是豆瓣评分 7.8以上 的，我读过的或翻过，靠谱的。



### 121

2024-08-29

歸藏(guizang.ai)
@op7418
Anthropic  Artifact 这个页面给的几个例子都挺好的，非常完整。

录了个视频演示了一下，非常值得学习Remix一下看看是怎么跟 Claude 沟通的。




### 122

2024-08-29

meng shao
@shao__meng
推荐！Anthropic 是如何构建 Artifacts 的 ？
via 
@GergelyOrosz
 

文章深入介绍了 Anthropic 
@AnthropicAI
 如何开发和推出 Artifacts 功能，不仅详细描述了 Artifacts 的开发过程，还为我们提供了对 Anthropic 工程团队运作方式的洞察。

它强调了小团队、快速迭代和利用 AI 工具在现代软件开发中的重要性，文章对团队 AI 产品构建非常有参考价值，强烈推荐！

背景介绍
- Anthropic 在 2024.6.20 发布了 Claude 3.5 Sonnet 模型，该模型在编码相关工作中表现出色。
- Artifacts 是随 Claude 3.5 Sonnet 一起发布的新功能，允许用户通过提示创建网站、代码片段、文档和图表等。

从构想到实现 Artifacts 的过程
- 研究科学家 Alex Tamkin 
@AlexTamkin
 在测试模型的网站生成能力时，发现了简化过程的需求。
- Alex 创建了一个初步的演示，在 "WIP Wednesday" 会议上展示。
- 产品设计师 Michael Wang 
@mkwng
 进一步完善原型。
- 产品工程师 Florian Scholz、安全工程师 Ziyad Edher 
@ziyadedher
、品牌成员 sam mcallister 
@sammcallister
  加入团队，帮助将 Artifacts 投入生产。

技术栈
- 原型阶段: 使用 Streamlit 和 Node.js
- 前端: React, Next.js, Tailwind CSS
- 安全: 使用 iFrame 沙盒和内容安全策略 (CSP)
- 后端: 主要依赖于模型的能力，减少了传统后端的需求

利用 AI 加速开发
- 团队大量使用 Claude 3 Opus 和 Claude 3.5 Sonnet 来生成代码、解决问题和迭代想法。
- Claude 3.5 Sonnet 的引入显著提高了团队的野心和可能性。

时间线和团队规模
- 从初始演示到发布用时 3 个月（2024.3.21 - 6.20）
- 核心团队非常小：一个全职成员，一个兼职贡献者，以及几个在关键时刻提供帮助的人

安全考虑
- 使用 iFrame 沙盒和严格的内容安全策略来隔离不受信任的代码
- 持续关注和强化安全环境

关键洞察
- 小团队能够快速开发和推出高影响力的产品
- 使用 AI 工具（如 Claude）可以显著加速开发过程
- 原型演示和内部分享对于获得支持和推动项目前进至关重要
- 灵活性和快速迭代是成功的关键因素

潜在影响
- Artifacts 可能代表了生成式 AI 工具向更协作化方向发展的一步
- 展示了如何利用 AI 模型来简化后端逻辑，改变传统的 web 开发方法

原文链接：
https://newsletter.pragmaticengineer.com/p/how-anthropic-built-artifacts



### 123

2024-08-29


小互
@imxiaohu
Anthropic 罕见的主动公布了 Claude 的所有系统提示词 

并承诺将定期更新

通常情况下，AI 公司会保密这些系统提示，但 Anthropic 罕见的选择主动公开，展示了 Claude 的系统提示如何塑造模型的行为和性格特征。

Anthropic 称将不定期的公开气模型的系统提示词，包括 Claude 3 Opus、Claude 3.5 Sonnet 和 Claude 3 Haiku。这些提示可以在 Claude 的 iOS 和 Android 应用程序以及网页版上查看。

完整提示词及翻译：https://xiaohu.ai/p/12925



### 124

2024-08-29


小互
@imxiaohu
智谱AI发布其最新基座大模型GLM-4-Plus

以及展示了类似OpenAI GPT 4o模型的视觉能力，能进行自由语音通话和视觉推理，并宣布8月30日开放！

GLM-4-Plus在多个方面表现出了卓越的性能，具体如下：

1.语言能力：

•GLM-4-Plus在语言理解、指令遵循、长文本处理等方面达到了国际领先水平。与GPT-4和参数量为405B的Llama3.1相比，GLM-4-Plus的语言文本能力相当。

•在长文本处理方面，GLM-4-Plus通过更精准的长短文本数据混合策略，显著提升了长文本推理的效果，达到国际先进水平。

2.图像/视频理解：

•GLM-4V-Plus在图像和视频理解能力上表现卓越，具备时间感知能力，能够处理和理解复杂的视频内容。

•该模型将在智谱开放平台上线，成为国内首个通用视频理解模型API。

3.文生图与视频生成：

•CogView-3-Plus在文生图性能上接近目前最优的MJ-V6和FLUX等模型。

•视频生成模型CogVideoX发布了性能更强的5B版本，被认为是当前开源视频生成模型中的最佳选择。

智谱的清言 APP将 迎来“视频通话”功能，这也是国内首个面向 C 端开放的视频通话功能。

清言视频通话能力跨越了文本模态、音频模态和视频模态，并具备实时推理的能力。

可以进行流畅通话，即便频繁打断它也能迅速反应。只要打开摄像头，我们看到的画面，清言也可以看到，同时可以听懂指令并准确执行。

视频通话功能将于8 月 30 日上线，首批面向清言部分用户开放，同时开放外部申请。

详细：https://mp.weixin.qq.com/s/Ww8njI4NiyH7arxML0nh8w


### 125

2024-08-29

meng shao
@shao__meng
RAGLAB 中的 6 种先进 RAG 算法实现

在 RAGLAB 的开源项目中，我们可以看到 6 种先进 RAG 算法的代码实现，一起来看看 👇👇👇

01 - Naive RAG (naive_rag )：
基础的检索增强生成方法，主要特点：
- 模块化设计：代码通过不同的模块（如检索器、语言模型、指令实验室等）来构建 RAG 系统，提供了灵活的配置选项。
- 双模式运行：支持交互模式 (interact) 和评估模式 (evaluation)，分别用于单次查询和批量评估。
- 灵活的语言模型和检索器选择：支持多种语言模型 (如 HuggingFace 模型、OpenAI API ) 和检索器 (如 Colbert、Contriever )，可以根据需求进行选择和配置。
- 自动评估机制：在评估模式下，能够自动加载数据集、进行推理，并计算多种评估指标 (如准确率、精确匹配率、F1 分数)。
- 检索增强生成流程：实现了基本的 RAG 流程，包括检索相关文档、拼接指令和查询、生成回答等步骤，并支持实时检索和预先给定文档两种方式。

02 - RRR (query_rewrite_rag )：
重写查询、检索、阅读的迭代方法，主要特点：
- 查询重写：该算法的核心特点是在检索前对用户的原始查询进行重写。通过 _rewrite 方法实现，使用 LLM 生成改写后的查询。
- 检索-阅读流程：算法遵循典型的 RAG 流程，包括检索相关段落和基于检索结果生成回答，体现在 infer 方法中的检索和阅读步骤。
- 指令驱动：算法使用预定义的指令来引导 LLM 完成查询重写和阅读任务，指令通过 find_algorithm_instruction 方法获取。
- 灵活性：该类继承自 NaiveRag，可能允许在保持基本 RAG 框架的同时进行定制化实现。
- 跟踪生成过程：代码通过 generation_track 字典记录了查询重写、检索结果和最终答案等中间步骤，有助于结果解释和调试。

03 - ITER-RETGEN (iterative_rag )：
迭代检索生成方法，主要特点：
- 迭代检索和生成过程: 该算法实现了一个迭代的 RAG 过程。它通过多次迭代来优化检索和生成结果。
- 跟踪生成历史: 使用 generation_track 字典来记录每次迭代的检索输入、生成结果、指令和检索到的段落,便于后续分析和优化。
- 动态检索输入: 每次迭代都使用上一轮的生成结果作为新的检索输入,实现了一种动态和自适应的检索策略。
- 灵活的指令模板: 使用 find_algorithm_instruction 方法来获取特定任务的指令模板，并通过 format_map 方法动态填充内容。
- 继承和扩展: 该类继承自 NaiveRag,并通过重写 infer 方法来实现迭代 RAG 算法，展示了良好的面向对象设计。

04 - Self-Ask (self_ask )：
自问自答式的多步推理方法，主要特点：
- 迭代问答机制： Self-Ask 算法通过不断生成后续问题 (follow-up questions) 来细化和深入原始查询。这个过程在 infer 方法中通过一个 while 循环实现，直到达到最大迭代次数或不再产生新的后续问题。
- 检索和回答融合： 对于每个后续问题，系统都会进行检索 (http://self.retrieval.search) 并使用检索到的段落来生成中间答案。这个过程融合了外部知识和语言模型的推理能力。
- 最终答案生成： 算法通过识别特定模式 (如 "So the final answer is:" 或 "Final Answer:") 来提取最终答案。如果没有明确的最终答案，会额外生成一个结论。
- 任务特定的后处理： 代码包含针对不同任务 (如 PubHealth、Feverous、StrategyQA) 的后处理方法，用于将生成的答案转化为特定任务所需的格式。
- 灵活的指令管理： 代码使用 find_algorithm_instruction 方法来获取针对不同阶段 (如生成后续问题、阅读检索结果) 的指令，这允许根据不同任务灵活调整系统行为。

05 - Active RAG (active_rag )：
主动学习式的 RAG 方法，主要特点：
- 迭代生成答案: ActiveRAG 通过 while 循环迭代地生成答案,每次生成一个句子，直到达到最大长度或没有更多内容可生成。
- 前瞻机制 (Look-ahead): 在每次迭代中，先生成一个 "look-ahead" 文本，然后只取其第一个句子作为当前迭代的输出，这有助于保持生成内容的连贯性。
- 低概率 token 遮蔽: 对 look-ahead 中的低概率 token 进行遮蔽，生成一个 "masked look-ahead"。这个机制用于识别模型不确定的部分，引导后续的检索。
- 动态检索: 基于 masked look-ahead 重新检索相关段落,然后用这些新检索的信息来指导下一轮的生成。这实现了一个动态、交互式的检索-生成过程。
- 概率阈值控制: 使用 filter_prob 和 masked_prob 两个阈值来控制 token 的遮蔽过程，这允许对模型的不确定性进行细粒度的调节。

06 - Self-RAG (self_rag_reproduction )：
自适应性的 RAG 方法，主要特点：
- 自适应检索机制: 通过计算 "[Retrieval ]" 和 "[No Retrieval] " token 的概率比来决定是否进行检索。这实现了论文中提到的动态检索策略,能够根据生成内容自动决定是否需要额外信息。
- 多步生成与树状搜索: 使用 beam search 和预定义的最大深度 (max_depth) 来构建预测树。每一步都可能进行检索或直接生成,形成一个动态的生成过程。这允许模型在长文本生成时持续获取相关信息。
- 多维度评分机制: 结合了相关性 (relevance)、支持度 (groundness)、实用性 (utility) 以及序列概率 (sequence score) 等多个维度来评估生成内容的质量。这种综合评分有助于选择最佳的生成路径。
- 特殊标记处理: 使用如"[Retrieval]"、"[No Retrieval]"、"[Relevant]" 等特殊标记来控制生成过程。代码中包含了对这些标记的详细处理逻辑，以实现论文中描述的各种功能。
- 灵活的推理模式: 实现了 "short_form" 和 "long_form" 两种推理模式，以及 "always_retrieval"、"no_retrieval" 和 "adaptive_retrieval" 三种检索模式。这种灵活性使得模型可以适应不同的任务需求。

开源地址：
https://github.com/fate-ubw/RAGLAB/tree/main/raglab/rag/infer_alg
引用
meng shao
@shao__meng
·
8月29日
RAGLAB 是一个全面的 RAG 研究框架，提供了从数据收集、训练到自动评估的完整生态系统，并实现了 6 种先进 RAG 算法的复现。



### 126

2024-08-29

小互
@imxiaohu
GameNGen：一个完全由神经模型驱动的游戏引擎 

可以根据玩家操作实时生成游戏画面

由Google DeepMind 开发

GameNGen 可以在你玩游戏时，实时生成游戏画面。这意味着你看到的每一帧图像都是引擎即时生成的，而不是事先存储的。

你可以像玩普通游戏一样，通过键盘或手柄与游戏互动，而GameNGen会根据你的操作来生成下一帧的游戏画面。

生成的游戏画面非常接近真实游戏的效果，所以你几乎感觉不到这是AI生成的图像，而像是在玩真正的游戏。

GameNGen 能够以超过20帧每秒的速度，实时模拟经典游戏《DOOM》。

GameNGen生成的游戏画面与真实游戏非常接近，人类难以区分。

详细介绍：https://xiaohu.ai/p/12915
项目及演示：https://gamengen.github.io

论文：https://arxiv.org/pdf/2408.14837




### 127

2024-08-29


meng shao
@shao__meng
Github 单月 31K 🌟 项目：Deep-Live-Cam

单张图像实时换脸，一键视频深度换脸。

这可能是我见过的 Github 发布项目 ✨ 上升最快的项目了，它的使用场景确实非常多，电商直播、娱乐恶搞等等，不过安全性风险也非常高，发出来也希望大家对此类视频能有警惕和辨别，避免被 Fake 视频诈骗。

https://github.com/hacksider/Deep-Live-Cam


### 128

2024-08-29


小互
@imxiaohu
DiPIR：可以将任意物体对象插入到图片或视频中 

并和原图像或视频融为一体

DiPIR不仅可以在图像中插入任何虚拟物体，而且还可以自动调整物体的材质和光照，使其与场景自然融合。

实验结果表明，这种方法在多个测试场景中表现出色，生成的图像非常逼真。

适用于多种场景： DiPIR 可以在各种不同的场景中应用，包括室内、户外、白天、夜晚等不同光照条件的场景。无论是室内场景的细腻光照，还是户外场景的高动态范围光照，DiPIR 都能有效处理。

广泛的应用场景： 该方法不仅适用于虚拟物体插入，还可以用于合成数据生成、虚拟制作、增强现实等领域，具有广泛的应用前景。

详细介绍：https://xiaohu.ai/p/12934
项目地址：https://research.nvidia.com/labs/toronto-ai/DiPIR/


### 129

2024-08-29


小互
@imxiaohu
Google 在其 Gemini AI 中引入了新功能

包括可以创建自定义 AI 专家的“Gems”功能，该功能类似ChatGPT的GPTs，可以创建自己的专属聊天机器人。

以及新的增强的图像生成功能，使用的是其最新的Imagen 3模型...

自定义 Gems： 用户可以创建个性化的 AI 专家，帮助完成特定任务或主题，例如编程、职业建议、写作和头脑风暴。 这些 Gems 可以根据用户的指示进行定制，并用于各种用途，如项目规划或社交媒体内容创作。

Imagen 3： 新的图像生成模型可以以多种风格生成高质量图像，包括逼真的风景和纹理油画。Imagen 3 还引入了安全措施和水印功能，以确保负责任的使用，并将逐步向更多用户推出，首先支持英文。

详细：https://blog.google/products/gemini/google-gemini-update-august-2024/


### 130

2024-08-30

小互
@imxiaohu
Magic团队开发出一种超长上下文 AI 模型 LTM 

可处理 1 亿个Token的上下文 

远远超出了传统模型的处理能力。1亿个Token相当于大约1000万行代码或750本小说的内容。

而且其计算效率比 Llama 3.1 405B的注意力机制高出约1000倍。

LTM-2-mini通过链式思维方法进行训练，能够在复杂的哈希链推理任务中取得高达100%的准确率。





### 131

2024-08-30


小互
@imxiaohu
阿里云发布Qwen2-VL 最新视觉语言模型 

Qwen2-VL具备多分辨率和比例图像的先进理解能力，并在多个视觉理解基准上表现出色，

此外，Qwen2-VL能够理解长达20分钟以上的视频内容，支持复杂推理和决策，使其能够与移动设备、机器人等进行自动化操作。

该模型还增加了多语言支持，能理解包括大部分欧洲语言、日语、韩语、阿拉伯语等在内的图像文本。

详细内容：https://xiaohu.ai/p/12991
