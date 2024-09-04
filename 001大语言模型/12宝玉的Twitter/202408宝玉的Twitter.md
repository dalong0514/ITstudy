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



### 81

2024-08-16





### 82

2024-08-01





### 83

2024-08-01





### 84

2024-08-01





### 85

2024-08-01





### 86

2024-08-01





### 87

2024-08-01





### 88

2024-08-01





### 89

2024-08-01





### 90

2024-08-01





### 91

2024-08-01





### 92

2024-08-01





### 93

2024-08-01





### 94

2024-08-01





### 95

2024-08-01





### 96

2024-08-01





### 97

2024-08-01





### 98

2024-08-01





### 99

2024-08-01





### 100

2024-08-01





### 101

2024-08-01





### 102

2024-08-01





### 103

2024-08-01





### 104

2024-08-01





### 105

2024-08-01





### 106

2024-08-01





### 107

2024-08-01





### 108

2024-08-01





### 109

2024-08-01





### 110

2024-08-01





### 111

2024-08-01





### 112

2024-08-01





### 113

2024-08-01





### 114

2024-08-01





### 115

2024-08-01





### 116

2024-08-01





### 117

2024-08-01





### 118

2024-08-01





### 119

2024-08-01





### 120

2024-08-01





### 121

2024-08-01





### 122

2024-08-01





### 123

2024-08-01





### 124

2024-08-01





### 125

2024-08-01





### 126

2024-08-01





### 127

2024-08-01





### 128

2024-08-01





### 129

2024-08-01





### 130

2024-08-01





### 131

2024-08-01





### 132

2024-08-01





### 133

2024-08-01





### 134

2024-08-01





### 135

2024-08-01





### 136

2024-08-01





### 137

2024-08-01





### 138

2024-08-01





### 139

2024-08-01





### 140

2024-08-01





### 141

2024-08-01





### 142

2024-08-01





### 143

2024-08-01





### 144

2024-08-01





### 145

2024-08-01





### 146

2024-08-01





### 147

2024-08-01





### 148

2024-08-01





### 149

2024-08-01





### 150

2024-08-01





### 151

2024-08-01





### 152

2024-08-01





### 153

2024-08-01





### 154

2024-08-01





### 155

2024-08-01





### 156

2024-08-01





### 157

2024-08-01





### 158

2024-08-01





### 159

2024-08-01





### 160

2024-08-01





### 161

2024-08-01





### 162

2024-08-01





### 163

2024-08-01





### 164

2024-08-01





### 165

2024-08-01





### 166

2024-08-01





### 167

2024-08-01





### 168

2024-08-01





### 169

2024-08-01





### 170

2024-08-01





### 171

2024-08-01





### 172

2024-08-01





### 173

2024-08-01





### 174

2024-08-01





### 175

2024-08-01





### 176

2024-08-01





### 177

2024-08-01





### 178

2024-08-01





### 179

2024-08-01





### 180

2024-08-01





### 181

2024-08-01





### 182

2024-08-01





### 183

2024-08-01





### 184

2024-08-01





### 185

2024-08-01





### 186

2024-08-01





### 187

2024-08-01





### 188

2024-08-01





### 189

2024-08-01





### 190

2024-08-01





### 191

2024-08-01





### 192

2024-08-01





### 193

2024-08-01





### 194

2024-08-01





### 195

2024-08-01





### 196

2024-08-01





### 197

2024-08-01





### 198

2024-08-01





### 199

2024-08-01





### 200

2024-08-01





### 201

2024-08-01





### 202

2024-08-01





### 203

2024-08-01





### 204

2024-08-01





### 205

2024-08-01





### 206

2024-08-01





### 207

2024-08-01





### 208

2024-08-01





### 209

2024-08-01





### 210

2024-08-01





