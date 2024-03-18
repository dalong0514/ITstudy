### 01

2024-03-01

宝玉
@dotey
人工智能的下一个重大挑战 —— Jim Fan Ted 演讲

在2016年春天的一个讲座中，Jim Fan并没有完全专注于讲师的话，而是被一场划时代的棋类比赛吸引——AlphaGo对战李世石。这场比赛标志着人工智能（AI）的一个重要里程碑：首次有AI在围棋比赛中击败了人类冠军。这一成就引发了对AI未来可能性的广泛思考，尤其是关于其在多个领域和情境中应用的潜力。

Jim Fan的思考引导他领导开发了Voyager项目，旨在将AI的技能扩展到前所未有的水平。Voyager选择了《我的世界》这个游戏作为其技能展示的平台，因为这个游戏以其开放性和创造性的游戏环境著称，为AI提供了一个理想的测试场地。在没有人类干预的情况下，Voyager能够连续数小时自主游玩，探索、开采、打怪、制作，不断地通过实践来扩展其技能树。

Voyager的核心洞察在于将编程视为行动，利用开放社区提供的Minecraft JavaScript API将3D世界转换成文字表述，并使用GPT4编写JavaScript代码片段，这些片段在游戏中成为可执行的技能。Voyager通过自我反思机制不断优化其代码和策略，从而适应环境和挑战，体现了一种“终身学习”的概念。

与此同时，Jim Fan也参与了MetaMorph的共同开发，这是一种能够控制数千种不同身体配置的机器人的算法。MetaMorph展现了对多样化身体形态的控制能力，证明了跨多个不同角色操作的可能性，从而为AI在现实世界中的应用开辟了新路径。

进一步地，Jim Fan介绍了IsaacSim，这是Nvidia开发的一项先进仿真技术，它能够以远超实时的速度进行物理仿真。IsaacSim的使用展示了AI在经历了相当于数年密集训练后在虚拟环境中获得的技能，为AI智能体在现实世界中的应用提供了重要的训练平台。

Jim Fan最终提出了一个激进的愿景，即发展一种能够在各种现实和虚拟环境中泛化应用的基础智能体（Foundation Agent）。这种智能体能够接受实体提示和任务提示作为输入，并输出相应的行动。他相信，所有可以移动的物体最终都将实现自动化，并且无论是在物理空间还是虚拟空间，所有AI智能体都将是对同一个基础智能体的不同提示的反应。

Jim Fan的这次演讲不仅展示了AI技术的最新进展，也为AI的未来发展设定了宏伟的蓝图，描绘了一个在多个维度上高度发展的AI技术景观。从AlphaGo的胜利到Voyager和MetaMorph的开发，再到基础智能体的构想，我们可以看到AI技术如何从专注于单一任务的实现，逐步发展到具有广泛应用和自我进化能力的全能AI。

https://ted.com/talks/jim_fan_the_next_grand_challenge_for_ai?language=en&subtitle=en



### 02

2024-03-01

歸藏
@op7418
看了几遍腾讯新闻对月之暗面杨植麟的专访，把我认为一些认同的重点的内容记了一下，分成两部分重点的底层认知和其他要点。各位有什么看法也可以在下面讨论。

重点认知：

* AI 组织的要素：更多的人才，更多的资本。

* AI不是我在接下来一两年找到什么PMF，而是接下来十到二十年如何改变世界。

* 真正的 AGI 肯定是全球化的，不存在由于某种保护机制你可以只做某个区域的 AGI 公司，全球化、 AGI 、和大用户量产品是成功的必要条件。

* AI 领域接下来的竞争中会有更多的差异化，需要提前做预判和准备到底什么是“成立的非共识”。

* 接下来会有两个大的milestone（里程碑）。一是真正的统一的世界模型，就是它能统一各种不同模态，一个真正的scalable和general的architecture（可扩展、通用的系统结构）（Sora 启发）。二是能在没有人类数据输入的情况下，使AI持续进化（详细见 AK 10 月份视频倒数第二部分）。

* “应用”本身是实现 AGI 的手段，也是实现 AGI 的目的。

* AI唯一work就是next token prediction + scaling law，只要token足够完整，都是可以做的。

* 想知道但还不知道的事情：我不知道AGI的上限是什么样的，它会产生一个什么样的公司，这个公司能产生出来什么样的产品。这是我现在最想知道的事。（重点）

其他要点：

* “搞定”不是一个好的词，背后本质是合作。合作就是能双赢，因为双赢是合作的前提。所以也没什么区别，需要给别人提供独特价值

* 为AI 时代的组织形式，有很多自顶向下的规划，但规划中又有创新空间，并不是所有技术都确定。

* Sam 去微软里领导新的团队有什么问题？需要在就文化中产生新组织，难度很大（这也是很多大厂选择投资而不是自己做的原因？）。

* AGI最终会是一个跟所有用户协作产生的东西。所以，不光是技术，也需要功利主义和现实追求。

* 长文本是新计算机的内容（AK在 10 月份的科普视频最后有类似比喻），要变成通用的世界模型，是需要long context的。

* 重要内容是个性化，AI最核心的价值是个性化互动，价值落脚点还是个性化，AGI会比上一代推荐引擎更加个性化。

* 上下文在接下来还有很大扩展空间，会有几个数量级，不能只看长度，要看它在这个窗口下能实现的推理能力、the faithfulness的能力（对原始信息的忠实度）、the instruction following的能力（遵循指令的能力）——不应该只追求单一指标，而是结合指标和能力。

* 除了综合能力，在很多空间可以产生独特的能力，能在一些方向做到state of the art（世界领先），比如 Midjourney V6。

* 三年后会有一定程度的AGI。我们今天在做的很多事AI也能做，甚至它做得更好。但关键看我们怎么用它。

* 月之暗面接下来的两件事第一件是世界模型，第二件AI 持续进化的能力。

* （GPT-4）是AGI的必经之路。核心是，不能只满足做到GPT-4的效果。一是要想现在真正的非共识是什么，除了GPT-4，下一步是什么？GPT-5和GPT-6应该是什么样？二是看，你在这里面有哪些独特能力，这点更重要。

* 月之暗面北极星指标：独特价值是你增量的智能。要抓住这个点，智能永远是最核心的增量价值。如果你这个产品最核心价值只有10%-20%来自于AI，就不成立。

* AI不是我在接下来一两年找到什么PMF，而是接下来十到二十年如何改变世界，你的目的假设是商业化，你不可能脱离AGI去思考。只做应用很容易被碾压。

* 技术是这个时代唯一新变量，其他变量没变。AGI是所有事情的核心。

* 为什么开源追不上闭源？因为开源的开发方式跟以前不一样了，以前是所有人都可以contribute（贡献）到开源，现在开源本身还是中心化的。

* 这一轮和上一轮创业的最大区别就是，这次会更加技术驱动。

* Sora 主要瓶颈，核心还是数据，你怎么去规模化地拟合这个数据？之前没被验证过。剩下的是它也没有完全解决，比如需要一个统一的architecture（架构）。DiT这个architecture仍然不是非常通用。

* Sora现在就有点像（视频生成的）GPT-3.5，是阶跃式提升。

* Sora+GPT 会产生什么？对世界的理解更好了，可以在数字世界里做更加端到端的任务，甚至去架起一座桥梁，连接物理世界，完成一些物理世界里的任务。这是起点（这也是 Open AI 投资机器人公司的原因？）。

* 我个人判断至少在接下来一到两年，卡不会成为很大瓶颈。

* 招人思路发生过一些变化。世界上AGI人才非常有限，有经验的人很少。我们最早期的画像是，专注找对口的genius（天才）。

* 解决幻觉问题主要还是靠scaling law，就是scale的是不一样的东西。

* 在能力上应该今年下半年会有一些比较大的突破，很多会来自OpenAI，它肯定还有下一代模型——有可能是4.5，也有可能是5，感觉是大概率事件。视频的生成模型肯定还能继续scale。

* 国内大模型公司的预测：一是可以看到新的独特能力产生。你会看到国产模型，因为前期的投入，有合适的团队，做出世界领先的某一些维度的能力。二是会出现更多用户量级更大的产品，这是大概率的。三是会有进一步的consolidation和路线选择的分化。

访谈原文：https://mp.weixin.qq.com/s/qVXcyw96IEPjrvZeA_1VMQ


### 03

2024-03-01

宝玉
@dotey
推荐阅读：《对话月之暗面杨植麟：向延绵而未知的雪山前进》

就在一年以前，AI科学家杨植麟在硅谷做了一笔精确的计算。他意识到，如果决定启动一场以AGI为目标的大模型创业，要在未来几个月立马筹措超1亿美金资本。

然而，这仅仅只是一张入场券。一年后，这个数字翻了13倍。

大模型公司的竞争，与其说是一场科学竞争，不如说首先是一场残酷的金钱角力。在资本方捂紧口袋的情况下，你要领先对手找到更多的钱，购买更多的卡，抢夺更多的人才。

“它需要人才聚集、资本聚集。”成立于2023年3月1日的大模型公司月之暗面（Moonshot AI）创始人兼CEO杨植麟说。

过去一年，国产大模型公司似乎处在一种紧迫而逼仄的生存边缘。看上去，他们每个都手握重金。但一方面，他们要把刚融的钱，立马投入极高昂的科研中追赶OpenAI——先是追齐GPT-3.5，没等追上GPT-4，Sora又来了；另一方面，他们要马不停蹄在落地场景上找可能，自我验证你是一家公司、而不是只会吞噬资本金的研究所；这还不够，每个项目不管是上市还是并购，出路更是毫不明朗。

在中国大模型创始人中，杨植麟年纪最轻，于1992年出生。业界评价他是坚定的AGI信徒和有技术号召力的创始人。他的学习与工作履历很多与通用AI相关，论文引用超22000次。

对于大模型，中国科技界于2023年中从狂热骤然转冷，进入加速落地的实用主义主旋律。这不免让大模型CEO们处于理想与现实的剧烈拉扯之间。在人人喊PMF（Product/Market Fit，产品/市场契合）、人人喊商业化的中国AI生态里，这位AI研究员出身的创始人倒不那么着急。

月之暗面是头部国产大模型公司中，人数最少的一家，为80人。他没有像他的对手那样，做更稳妥的to B生意，或是在医疗、游戏等细分场景中找落地，而是做且只做了一款to C产品——智能助手Kimi，支持20万汉字输入。Kimi也是杨植麟的英文名。

杨植麟倾向于将他的公司看作是，构建一个结合科学、工程和商业的系统。你可以想象成，他要在人类世界上空，架起一张AI实验台，一手做实验，一手将尖端技术落进真实世界，通过与人类互动找到应用机会，再将应用送入消费者手中。理想状况是，前者烧掉数以十亿、百亿计资本；后者再把这些钱数成百上千倍地挣回来——怎么听，都像“走钢丝”一样惊险。

“AI不是我在接下来一两年找到什么PMF，而是接下来十到二十年如何改变世界。”他说。

这种抽象和理想主义的思考，令人不免替他捏一把冷汗：一位年轻的AI科学家，在现实主义的中国能否找到生存空间？

2024年2月，月之暗面逆势完成一笔大额融资。据了解，它以15亿美金投前估值完成超10亿美元B轮，阿里领投，砺思资本、小红书等跟投，该笔交易完成后，月之暗面投后估值约25亿美元——由此，它成为中国大模型赛场上现阶段估值最高的一家独角兽。（他们拒绝回应和评论此事。）

就在第三笔融资的过程中，我们和杨植麟聊了聊他过去一年创业故事，这也是国产大模型抢跑一年的截面缩影。

他的公司没有选址在大模型企业聚集地，北京搜狐网络大厦。对于一家融资总额约90亿元人民币的公司，这间位于量子芯座的办公室，显得简陋又破旧。门口连公司logo都没有，只有一架白色钢琴守在门口。

会议室在一个角落，由于窗户小黑漆漆的，冬天送来暖风的空调机器嗡嗡作响。暗沉的光亮中，杨植麟形容自己过去一年的感知：“有点像开车在路上，前面有延绵的雪山，但你不知道里面是什么，你在一步一步往前走。”

以下是对杨植麟的访谈全文。

https://mp.weixin.qq.com/s/qVXcyw96IEPjrvZeA_1VMQ


### 04

2024-03-04

宝玉
@dotey
\#AI开源项目推荐 ：AIlice

来自MyShellAI的开源项目，可以控制多个智能体协同完成复杂的任务，例如文档检索、下载、数据分析、画图等。

并且可以针对任务生成代码在虚拟环境中运行。

项目地址：https://github.com/myshell-ai/AIlice


### 05

2024-03-04

宝玉
@dotey
推荐阅读：《Fuck You, Show Me The Prompt》

很多框架或者App唯一的价值就是Prompt！

译文：https://baoyu.io/translations/prompt-engineering/fuck-you-show-me-the-prompt

宝玉
@dotey
一种简单方便的破解Prompt的方式：导出聊天历史，从导出的聊天历史文件中可以看到所有会话中用到的System Prompt。

但是Team订阅用户不能导出消息记录，所以我无法测试，还请Plus订阅的同学帮忙验证一下，是不是适用于 GPT。

### 06

2024-03-04


Leonie
@helloiamleonie
What are the best free learning resources to get started with DSPy?

1. "DSPy Explained!": https://youtube.com/watch?v=41EfOY0Ldkc&t=828s 

2. "Getting Started with RAG in DSPy!": https://youtube.com/watch?v=CEuUG4Umfxs 

Don't miss out on any more great tutorials by following 
@CShorten30
!


### 07

2024-03-04

歸藏
@op7418
ComfyUI的LayerDiffusion透明图层生成插件也已经发布了，目前还只支持生成。

插件主要有两个节点，工作流需要用的那个遮罩节点需要安装comfyui-tooling-nodes插件。

插件地址：https://github.com/huchenlei/ComfyUI-layerdiffusion


### 08

2024-03-04

宝玉
@dotey
简单介绍一下作者从视频生成文章的思路，还是有些可以学习借鉴的地方，主要是能生成插图和从视频中提取代码。

1. 输入YouTube视频地址后，下载视频

2. 基于视频需要分别处理文本和视频帧

2.1 音频处理成文本
2.1.1 使用Whisper从音频获取带有时间戳的文本
2.1.2 将文本合并

2.2 视频帧处理
2.2.1 对视频抽帧并上传到服务器获取到可以访问的图片URL（GPT-4V需要用到）
2.2.2 对视频帧的图片提取信息（借助GPT-4V）
2.2.3 根据提取的图片信息决定是否使用该图片到正文，或者要使用截图中的文本信息（例如代码块）

3. 根据时间戳信息将图片的信息、文本和插图混合在一起

4. 生成带有Markdown的文章信息（需要长上下文的GPT-4）

5. 生成目录（不需要LLM，很多现成代码可以从Markdown生成目录）

最终成品可以看：https://misbahsy.github.io/KarpathyLLMChallenge/TokenizationLLMChallenge

图片并茂效果还是挺不错的，另外很多人肯定关心2小时的视频生成这么一篇文章成本多少？

答案是$4-6美元，比我预想的便宜一点，因为如果抽帧比较频繁的话应该要花费不少。

另外生成这么长的文章，估计要用到32K的GPT-4。

作者没有开源，但是根据上面的流程自己实现一个也不复杂，关键还是抽帧和从视频帧提取信息那部分需要做好平衡。


### 09

2024-03-04

歸藏
@op7418
最近看到很多 Lex Fridman 采访 Andrej Karpathy 的视频剪辑才知道Lex Fridman采访过AK，所以就找到原视频翻译了一下。
主要内容基本就是下面这些部分，最下面还有详细的时间节点可以点击直接跳转。

主要内容：
Andrej Karpathy在视频中介绍了神经网络、物理学、机器学习和人工智能的进展与挑战。讨论包括神经网络的数学模型、它们在处理复杂问题时表现出的意外行为，以及这些技术对我们理解世界和处理信息的方式的影响。

特别强调了合成智能在未来可能发挥的作用，包括解决宇宙之谜和在物理模拟中发现创新解决方案的能力。此外，还探讨了人工智能在理解和模拟人类语言、情感以及其在自动驾驶和其他实际应用中的潜力。

时间轴：
0:00 - 简介
0:58 - 神经网络
6:01 - 生物学
11:32 - 外星人
21:43 - 宇宙
33:34 - Transformers
41:50 - 语言模型
52:01 - 机器人
58:21 - 谷歌的 LaMDA
1:05 - 软件 2.0
1:16 - 人工标注
1:18: - 相机视觉
1:23 - 特斯拉的数据引擎
1:27 - 特斯拉视觉
1:34 - 埃隆-马斯克
1:39 - 自动驾驶
1:44 - 离开特斯拉
1:49 - Tesla's Optimus
1:59 - 图像网络
2:01 - 数据
2:11 - 日常生活
2:24 - 最佳 IDE
2:31 - arXiv
2:36 - 给初学者的建议
2:45 - 人工智能
2:59 - 电影
3:04 - 人类文明的未来
3:09 - 推荐书籍
3:15 - 给年轻人的建议
3:17 - 机器学习的未来
3:24 - 生命的意义


### 10

2024-03-04

Awni Hannun
@awnihannun
Using MLX Swift to train LeNet on MNIST. Takes less than a minute on my iPhone 14.

Example here: https://github.com/ml-explore/mlx-swift-examples

@ylecun
 long-live MNIST!


### 11

2024-03-06

歸藏
@op7418
字节发布ResAdapter可以解决SD生成超大图片和非训练分辨率图片时的肢体异常以及画面崩坏问题。

同时可以与现有的IPadapter以及Controlnet模型兼容。

项目简介：

近期，像Stable Diffusion这样的文本到图像模型和DreamBooth、LoRA等个性化技术的发展，让我们能够创造出既高质量又充满创意的图像。但这些技术在生成超出它们训练时所用分辨率的图像时，往往会受到限制。

为了突破这一难题，我们推出了一种新型工具——分辨率适配器（ResAdapter）。

它是一种专门为扩散模型（比如Stable Diffusion和个性化模型）设计的适配器，能够生成任何分辨率和长宽比的图像。与其它多分辨率生成方法不同，ResAdapter能直接生成动态分辨率的图像，而不是在后期处理中调整静态分辨率的图像。这种方法使得图像处理变得更加高效，避免了重复的去噪步骤和复杂的后期处理流程，显著缩短了处理时间。

在不包含任何训练领域风格信息的情况下，ResAdapter利用广泛的分辨率先验，即使只有0.5M的容量，也能为个性化扩散模型生成不同于原训练领域的高分辨率图像，同时保持原有风格。

大量实验显示，ResAdapter在提高分辨率方面与扩散模型配合得天衣无缝。此外，更多的实验表明，ResAdapter可以与ControlNet、IP-Adapter和LCM-LoRA等其他模块兼容，适用于创建不同分辨率的图像，也可以整合进如ElasticDiffusion这样的多分辨率模型中，高效生成更高清晰度的图像。

项目页面：https://res-adapter.github.io


### 12

2024-03-06

fofr

@fofrAI
Generate transparent images directly with LayerDiffusion. No more background removal tools – it builds transparency into the diffusion process.

It's only on A1111 at the moment:
https://github.com/layerdiffusion/sd-forge-layerdiffuse

I need this in ComfyUI! This is the proper way.

https://x.com/fofrAI/status/1764958890246934554?s=20


### 13

2024-03-06

歸藏
@op7418
TripoSR 3D 模型生成的 ComfyUI 节点已经有人开发了，按页面安装下载模型就可以用了。

项目地址：https://github.com/flowtyone/ComfyUI-Flowty-TripoSR?tab=readme-ov-file


### 14

2024-03-06

歸藏
@op7418
Stability AI  发布了他们最强的图片生成模型 Stable Diffusion 3 的技术报告，披露了 SD3 的更多细节。

据他们所说，SD3 在排版质量、美学质量和提示词理解上超过了目前所有的开源模型和商业模型，是目前最强的图片生成模型。

技术报告要点如下：

◆根据人类偏好评估,SD3 在排版质量和对提示的理解程度上,均优于目前最先进的文本生成图像系统,例如 DALL·E 3、Midjourney v6 和 Ideogram v1。

◆提出了新的多模态扩散 Transformer (Multimodal Diffusion Transformer,简称 MMDiT) 架构,其使用独立的权重集分别表示图像和语言。与 SD3 的先前版本相比,该架构改善了系统对文本的理解能力和拼写能力。

◆SD3 8B 大小的模型可以在 GTX 4090 24G 显存上运行。

◆SD3 将发布多个参数规模不等的模型方便在消费级硬件上运行，参数规模从 800M 到 8B 。

◆SD3 架构以 Diffusion Transformer (简称"DiT",参见 Peebles & Xie,2023)为基础。鉴于文本嵌入和图像嵌入在概念上存在较大差异,我们为这两种模态使用了独立的权重集。

◆通过这种方法,信息得以在图像 Token 和文本 Token 之间流动,从而提高了模型生成结果的整体理解力和排版质量。我们在论文中还讨论了如何轻松地将这一架构扩展至视频等多模态场景。

◆SD3 采用了矫正流 (Rectified Flow,简称 RF) 的公式 (Liu et al.,2022;Albergo & Vanden-Eijnden,2022;Lipman et al.,2023),在训练过程中,数据和噪声被连接在一条线性轨迹上。这导致了更直的推理路径,从而可以使用更少的步骤进行采样。

◆扩展矫正流 Transformer 模型：使用重新加权的 RF 公式和 MMDiT 主干网络,对文本到图像的合成任务开展了模型扩展研究。我们训练了一系列模型,其规模从 15 个 。Transformer 块 (4.5 亿参数) 到 38 个块 (80 亿参数) 不等。

◆灵活的文本编码器：通过在推理阶段移除内存密集型的 T5 文本编码器 (参数量高达 47 亿),SD3 的内存占用可以大幅降低,而性能损失却很小。

详细介绍：https://stability.ai/news/stable-diffusion-3-research-paper


### 15

2024-03-06


宝玉
@dotey
这个Claude 3 Opus的测试案例让人印象深刻，作者将2小时的视频文稿和一些关键帧的截图一起扔给API，最终生成了一篇不错的HTML格式的图片并茂的博文。

项目地址：https://github.com/hundredblocks/transcription_demo

Prompt：
用户:这里有一段视频的文字记录,包括不同时间戳的屏幕截图。
该文字记录是由AI语音识别工具生成的,可能包含一些错误/不当之处。
你的任务是将文字记录转换为一个html博客。
博客的写作风格,包括文字和代码之间的期望平衡,在<desired_writing_style>的屏幕截图中有所说明。 
博客的视觉风格,包括页面布局、字体、标题和图像样式,在<desired_visual_style>中有所描述。

{transcript_with_name}  
<desired_writing_style>
{desired_writing_style}
</desired_writing_style>
<desired_visual_style> 
{desired_visual_style}
</desired_visual_style>

这份文字记录有一些噪音。请按照以下指南将其重写为一个html格式的博客:
- 输出有效的html
- 在适当的地方插入章节标题和其他格式
- 使用样式使图像、文本、代码、标注和页面布局、边距看起来像<desired_visual_style>中的示例
- 删除任何口头禅
- 如果有重复的信息,只呈现一次 
- 用<desired_writing_style>中显示的风格改写对话内容,包括标题,使叙述结构更容易理解
- 每个文字记录包含太多图像,所以你的输出应该只包括最重要的1-2张图像
- 选择能提供与文字记录相关的插图的图像
- 优先包含显示完整代码的图像,而不是部分代码
- 在相关时转录重要的代码片段和其他有价值的文本
- 如果某个图像有助于说明文字记录的某个部分,请包含它
- 要包含图像,请插入一个带有src="frames/hh_mm_ss.jpg"的标签(例如"frames/00_12_35.jpg"),准确复制文字记录中图像上方插入的时间戳 
- 为图像添加标题
- 不要添加任何无关信息:只包括在文字记录或图像中提到的内容

你的最终输出应该适合收录到教科书中。

助手:<!DOCTYPE html>

https://x.com/mlpowered/status/1764718705991442622?s=20

### 16

2024-03-06

宝玉
@dotey
中国为算力不足的人工智能初创企业提供"算力券"

中国正采取措施为人工智能初创企业创造公平的竞争环境,因为该国的科技巨头在美国芯片限制下已经占用了本就紧缺的人工智能训练计算资源。

至少有17个城市政府,包括最大的上海,已承诺提供"算力券"来补贴那些面临数据中心成本上升的人工智能初创企业,因为关键芯片供应变得更加稀缺。

根据官方公告,这些券的价值通常相当于14万至28万美元。它们可用于人工智能数据中心,用于训练和运行公司的大型语言模型(LLM),这些模型可以理解和生成自然语言以及其他内容,以执行广泛的任务。

业内人士表示,在互联网公司取消了云计算服务合同后,帮助人工智能初创企业支付计算成本的举措开始实施,因为美国收紧管控促使这些公司"为自己囤积GPU(图形处理单元)"。

据多位知情人士透露,互联网巨头阿里巴巴、腾讯和字节跳动已采取措施限制英伟达GPU的租赁,并将这些囤积的人工智能处理器中的大部分留作内部使用和重要客户使用。

过去两年,拜登政府收紧了中国获取关键人工智能芯片的渠道,导致企业在禁令前囤货、改装英伟达游戏芯片或求助黑市。

阿里云的两名员工表示,阿里云已将其大部分先进GPU分配给阿里巴巴集团内的业务部门。一位经理表示,获得高性能芯片已成为一项"艰巨的任务"。

中国还在创建一个替代大型科技公司数据中心和云服务的方案。过去一年中,已建立了一个由国家运营的数据中心和在线平台网络,人工智能公司可以在那里租用算力。

一位从事数据中心建设的政府官员表示,如果人工智能公司选择政府运营的数据中心,这些券将使其计算成本降低40%至50%左右。

他们补充说,虽然这将在短期内"缓解初创企业的财务压力",但申请人仍有严格的要求,包括最低收入门槛或成为政府资助的研究项目的一部分。

北京已批准至少40个LLM供公众使用,监管机构在加快人工智能技术应用的同时,对其应用保持严格监管。

这包括使用国营交易平台集中分配算力,这些平台为获取云计算资源提供中介服务。去年,上海以西的苏州市建立了一个交易平台,以"协调全市的计算资源"。

在此类经纪平台上可以找到中国地下芯片交易的踪迹。与阿里云和腾讯云合作的苏州平台正在推广包括美国一直禁止向中国出售的英伟达H100先进芯片在内的计算集群。

https://ft.com/content/9d67cda3-b157-47a0-98cb-e8e9842b2c90


### 17

2024-03-06

歸藏
@op7418
Anthropic发布了Claude 3模型，该系列包括三种最先进的型号（按功能升序排列）：Claude 3 Haiku、Claude 3 Sonnet 和 Claude 3 Opus。

从测试结果来看比GPT-4强很多。支持100万Token上下文。

详细介绍：

Haiku是市场上智能类别中最快速、最具成本效益的模型。它可以在不到三秒的时间内阅读一篇arXiv上信息密集、数据丰富的研究论文（约10,000个标记），包括图表和图形。

对于绝大多数工作负载，Sonnet比Claude 2和Claude 2.1快2倍，并具有更高水平的智能。它擅长需要快速响应的任务，如知识检索或销售自动化。

Claude 3型号具有与其他领先型号相媲美的复杂视觉能力。它们可以处理各种视觉格式，包括照片、图表、图形和技术图解。

Opus、Sonnet和Haiku更不太可能拒绝回答接近系统底线的提示，相比以往的模型，克劳德3模型表现出更加细致的请求理解，识别真实伤害，并且拒绝回答无害提示的频率大大降低。

与Claude 2.1相比，Opus在这些具有挑战性的开放性问题上的准确性（或正确答案）实现了两倍的改进，同时也展现出了降低的错误答案水平。

所有三个模型都能够接受超过100万个标记的输入，可能会向需要增强处理能力的特定客户提供这一功能。

Claude 3模型更擅长遵循复杂的多步指令。它们特别擅长遵循品牌语调和响应指南，并开发用户可以信任的客户体验。此外，Claude 3模型更擅长生成流行的结构化输出，如JSON格式。

Opus和Sonnet现已可在API中使用，该API现已普遍可用，使开发人员能够立即注册并开始使用这些模型。Haiku将很快可用。

详细信息：https://anthropic.com/news/claude-3-family


### 18

2024-03-06

宝玉
@dotey
翻译版来了：《OpenAI 和 Elon Musk》

https://baoyu.io/translations/openai/openai-elon-musk

OpenAI 的使命是确保全人类能从人工通用智能 (AGI) 中受益，这不仅意味着我们要构建既安全又有益的 AGI，也意味着我们要努力创造广泛分布的利益。现在，我们将分享我们如何实现这个使命的理解，以及我们与 Elon 的关系的一些事实。我们打算驳回 Elon 的所有主张。

我们意识到，建立 AGI 所需的资源远超我们最初的预想
Elon 建议我们应该对 OpenAI 宣布初始的 10 亿美元资金承诺。到目前为止，这个非营利机构已经从 Elon 那里筹集到不到 4500 万美元，而从其他捐赠者那里筹集到了超过 9000 万美元。

在 2015 年底创立 OpenAI 时，Greg 和 Sam 最初计划筹集 1 亿美元。Elon 在邮件中提出，我们应该增加筹资额度，避免听起来毫无希望，他建议我们应该从 10 亿美元的资金承诺开始，并承诺他将承担任何其他人无法提供的部分。1

我们花了大量时间设想如何实现 AGI。在 2017 年初，我们意识到建立 AGI 将需要大量的计算能力。我们开始计算 AGI 可能需要的计算能力。我们都明白，要实现我们的使命，我们需要更多的资本，每年需要数十亿美元，这远超过我们，尤其是 Elon，认为我们能够通过非营利组织筹集的金额。

我们和 Elon 都认为，为了获取这些资源，需要有盈利的实体。
正如我们曾经讨论过的，为了进一步推进使命，伊隆希望我们能与特斯拉合并，或者他想要拥有全部的控制权。伊隆离开了 OpenAI，他认为需要有一个能与 Google/DeepMind 相匹敌的竞争者，而他打算自己来做。他表示他会支持我们寻找自己的道路。

在 2017 年末，我们和伊隆决定，为了推进使命的下一步，需要创建一个营利性实体。伊隆希望拥有多数股权，初始董事会的控制权，并担任 CEO。在这些讨论的中途，他停止了资金提供。Reid Hoffman 填补了这个资金缺口，以维持工资和运营开销。

我们无法与伊隆就营利性实体达成协议，因为我们认为让任何个人拥有绝对的对 OpenAI 的控制权，这与我们的使命相背离。之后他提议将 OpenAI 合并入特斯拉。2018 年 2 月初，伊隆转发给我们一封邮件，建议 OpenAI 应该“依附于特斯拉作为其利润来源”，并评论说“完全正确……特斯拉是唯一有希望与 Google 相匹敌的途径。即使如此，成为 Google 的反对力量的可能性也很小。至少不是零。” [2]

伊隆很快选择离开 OpenAI，他认为我们成功的可能性是零，并且他计划在特斯拉建立一个通用人工智能的竞争者。当他在 2018 年 2 月底离开时，他对我们的团队表示，他支持我们寻找自己筹集数十亿美元的道路。2018 年 12 月，伊隆给我们发了一封电子邮件，说“即使筹集了几亿也不够。你们需要每年立刻投入数十亿，否则就别想了。” [3]

通过构建广泛可用的有益工具来推进我们的使命
我们正在以各种方式使我们的技术广泛应用，这些方式能够赋予人们力量，改善他们的日常生活，包括我们的开源贡献。

我们为今天最强大的人工智能提供广泛的访问权限，包括每天被数亿人使用的免费版本。例如，阿尔巴尼亚正在利用 OpenAI 的工具，将其加入欧盟的时间提前最多达 5.5 年；Digital Green 正在帮助提高肯尼亚和印度农民的收入，借助 OpenAI，将农业扩展服务的成本降低了 100 倍；罗德岛最大的医疗机构 Lifespan，正在使用 GPT-4 将其手术同意书从大学阅读等级降低到六年级水平；冰岛正在使用 GPT-4 来保护冰岛语。

埃隆明白，实现使命并不意味着要开源通用人工智能。就像伊利亚对埃隆所说：“当我们更接近构建人工智能的时候，减少开放性是有道理的。在 OpenAI 中，Open 的含义是所有人都应当从已经构建好的人工智能的成果中受益，但完全没有必要分享科学知识……”。对此，埃隆回答道：“对。”[4]

我们对此感到非常遗憾，因为发生这种事的人是我们深深敬仰的，他鼓励我们把目标设定得更高，然后告诉我们我们会失败，开创了一个竞争公司，当我们在没有他的情况下，开始在 OpenAI 的使命上取得实质性进展时，他却对我们提起了诉讼。

我们目前正专注于推进我们的使命，前方的道路还很长。随着我们的工具变得越来越好，我们期待着将这些系统投入使用，让每个人都从中受益。

相关邮件内容参见：https://baoyu.io/translations/openai/openai-elon-musk


### 19

2024-03-06

宝玉
@dotey
推荐对照阅读：《朱啸虎讲了一个中国现实主义AIGC故事》
https://mp.weixin.qq.com/s/4111julSNH4XPXsUc8XEXA

中国科技界针对大模型的态度已分裂成两股阵营。一股是技术信仰派，他们大多技术出身，认为应该像OpenAI一样信仰AGI、信仰scaling law（规模定律），思维更偏硅谷。在他们眼中，随着模型能力跃升、模型成本降低，过程中会解锁丰富的应用。倘若不追求“更大更强的AI能力”，一旦其他人的模型飞跃，很快会降维碾碎现有根据地与护城河。

另一股是市场信仰派，他们信奉陡峭的技术曲线终有放缓的一天，只需将“足够的AI能力”投入可以快速变现的商业场景中，用中国市场庞大而独特的数据构筑壁垒。这类人往往在中国丛林式的商场中浸泡更久，思维更偏本土。

二者对技术判断的一个根本分歧是，开源模型会不会有一天，缩小甚至拉平与闭源模型的差距？技术信仰派的观点是，绝对不会，差距只会更大。市场信仰派的观点是，一定会，那意味着你今天做闭源只会处境尴尬——世界观的迥异，让双方对自我的判断都深信不疑。

有趣的是，Sora的出现不但没有弥合认知沟壑，反倒是加强了各自的态度。

我们试图呈现这两种态度。就在几天前，我们发布《月之暗面杨植麟复盘大模型创业这一年：向延绵而未知的雪山前进》，杨植麟是技术信仰派代表，而朱啸虎的观点正好处在与他相反的另一端。

事实上，市场信仰派在中国人数更众，特别是在当下资本泡沫破裂的无奈氛围下。只是，他们有时会羞于展露自己的真实想法——会被鄙视为“不信仰AGI”，或不为人类理想而战斗——所以他们大多数时候选择性沉默。

朱啸虎毫不怯懦于公开表达。他近期似乎迷上了这样一句话：“AIGC PMF（Product/Market Fit，产品/市场匹配），你十个人找不到，投一百个人同样找不到。”某种程度上，他的观点是展现了一个更现实版的中国AIGC故事。



### 20

2024-03-06

宝玉
@dotey
\#AI开源项目推荐：Comflowyspace

Comflowyspace是一个开源跨平台的 AI 图像与视频生成工具，提供比传统SDWebUI和ComfyUI更优质、更互动的体验。

https://github.com/6174/comflowyspace


### 21

2024-03-07

歸藏
@op7418
Andrej Karpathy 说现在在大公司维护计算集群的时候，随着规模扩大,集群管理更像是生物学而非工程学。

工程师需要像"保姆"一样密切监控训练过程,关注关键指标,一旦出现问题要及时排查,否则会浪费大量计算资源。

训练常常因为各种未知原因失败,需要重启尝试。训练大模型考验整个计算系统的容错能力,因此除了考虑性能和成本,还要评估整体服务质量和团队效率。

原文翻译：

这篇文章精彩地讨论了一个鲜为人知的话题：训练大语言模型（LLM）的难点。在成熟的公司里，有专门的团队负责维护这些计算集群。当规模扩大时，这些集群的管理从传统的工程学转变成更接近生物学的领域，这也是为什么会有专门负责“硬件健康”的团队的原因。

训练大型模型的日常可能充满挑战。作为工程师，你需要像“保姆”一样密切监控训练过程。这包括关注运行的关键指标：损失函数的突然升高、数值问题、处理速度、梯度的规范性、策略的熵值等。一旦训练过程出现退化或停滞——这种情况经常发生——你就得迅速查找错误原因。如果处理不及时，可能导致成千上万的GPU资源闲置。

你经常会遇到一些新的、陌生的、令人畏惧的错误，需要紧急求助于同事。最糟糕的情况往往发生在凌晨4点。有时候，问题无法解决，你只能选择停用一些异常的节点，尝试重新开始训练。有时候，训练失败仅仅是因为运气不佳，这时你可能会在启动命令中加入一个while True:循环以期望运气好转。

这些问题可能涉及多种原因，从GPU过热导致计算错误，到路由器故障降低网络文件系统的输入输出速度，甚至是数据中心内部因未通报的维护工作而导致的物理连接中断。有时候，问题的根源可能永远成谜。

这里还需要特别提到一个重要的参考资料：OPT-175B的日志本。希望未来能有更多类似的资料能够公开。（详见git仓库中的chronicles/OPT175B_Logbook.pdf） https://twitter.com/AIatMeta/status/1539702714141011969

总之，大语言模型的训练过程实质上是对一个庞大计算系统整体容错能力的极端考验，这个系统在某种程度上像一个生物实体。因此，在选择计算资源时，除了考虑浮点运算性能（FLOPs）和成本外，还要全面考虑从硬件到软件的整体服务，包括存储、网络和计算能力。更重要的是，考虑维护这些系统的团队是否像《复仇者联盟》那样高效，并思考你是否能与他们建立良好的合作关系。

Andrej Karpathy
@karpathy
Nice read on the rarely-discussed-in-the-open difficulties of training LLMs. Mature companies have dedicated teams maintaining the clusters. At scale, clusters leave the realm of engineering and become a lot more biological, hence e.g. teams dedicated to "hardware health".

It can be a frustrating daily life experience of training large models to "babysit" the training run. You're there carefully monitoring the vital signs of your run: loss spikes, numerical issues, throughput, gradient norms, policy entropy, etc. Every time the run degrades or flatlines (can happen often), you quickly look for the stack trace to see what's up. You have to do this fast or 10,000 GPUs could be idling. Often, it is a new, exotic, scary-looking error you've never seen before so you summon help to see if anyone can see what's up. The worst ones like to occur at 4am. Often no one can, so you just ban some nodes that look a bit sketchy and try to restart the run. Sometimes the run goes down just because you have not earned the favors of your gods that day, so you put a while True: loop around your launch command. The underlying issues can be highly diverse, from some GPUs just getting a bit too hot and suddenly doing incorrect multiplication once in a while, to some router going down and decreasing the networked file system I/O, to someone in the datacenter physically disconnecting a wire as part of an un-communicated maintenance. Sometimes you'll never know.

Another necessary related citation here is the famous OPT-175B logbook and I'd hope more like it can see the light of day in the future. (see chronicles/OPT175B_Logbook.pdf in the git repo)
https://twitter.com/AIatMeta/status/1539702714141011969

TLDR LLM training runs are significant stress-tests of an overall fault tolerance of a large computing system acting as a biological entity. And when you're shopping around for your compute, think about a lot more than just FLOPs and $. Think about the whole service from hardware to software across storage, networking, and compute. And think about whether the team maintaining it looks like The Avengers and whether you could become best friends.

https://x.com/karpathy/status/1765424847705047247?s=20


### 22

2024-03-07

歸藏
@op7418
昨天比较热的一条推，作者在测试Claude 3 Opus模型时，发现它能够在极少量平行语料(5700个翻译对)的基础上，近乎完美地翻译和分析一门复杂的低资源语言Circassian。

Calude 3 在这方面确实非常强大，基本上很少的数据就可以学会你想要教给他的内容。

推文详细介绍：

作者在测试Anthropic公司新模型Claude 3 Opus时,见证了令人惊叹的事情。作者一直在研究一门叫Circassian的低资源语言,这是一门孤立语言,语料稀缺,语法和形态极其复杂,对语言模型是巨大挑战。

作者之前花了两年时间搜集了6.4万对俄语-Circassian语的平行语料,训练专门的机器翻译模型才取得了不错的效果。作为实验,他只给Claude Opus输入了5700对随机抽取的单词/句子对作为示例,然后让它翻译一些新句子。

令人惊讶的是,Claude Opus不仅给出了完美的翻译,还对语法和词态进行了分析。即使是作者精心设计的,不太可能在示例数据中出现的复杂句子,Claude Opus也给出了无可挑剔的翻译和分析。它展现了对这门语言的深刻理解,在翻译文学作品、新闻、方言时也保持了原文的风格,遇到生词还能推测含义,提供词源分析,必要时甚至造新词。

作者强调,用同样的输入数据,一个不懂Circassian语的语言学家可能需要一年时间才能达到类似水平。而Claude Opus只用几千个翻译对,一分钟内就掌握了语言的精髓。相比之下,GPT-4 和作者之前微调的GPT-3.5模型都完全失败了。

作者最初以为Claude Opus完全是从他提供的少量示例中学到了Circassian语的知识,后来发现其实它在预训练时已经学到了一些。尽管如此,Anthropic在训练数据中纳入了Circassian这样的小语种,效果令人印象深刻。

尽管作者的初始假设有误,但Claude Opus展现的低资源语言能力依然令人惊叹,这预示着小语种和许多其他领域的重大突破。未来已经到来,而且令人惊喜。


### 23

2024-03-07

Andrej Karpathy
@karpathy
Beautiful work / attention to detail trying to get Gemma to finetune correctly. There are so many foot guns here to be super careful with. All of these issues don't throw any errors, they silently make your network worse.

A great example of what I wrote about in my "A Recipe for Training Neural Networks":
"""The "fast and furious" approach to training neural networks does not work and only leads to suffering. Now, suffering is a perfectly natural part of getting a neural network to work well, but it can be mitigated by being thorough, defensive, paranoid, and obsessed with visualizations of basically every possible thing. The qualities that in my experience correlate most strongly to success in deep learning are patience and attention to detail."""

And why I so emphasize the need for understanding all the parts of the deep learning stack in great detail. I exist in a perpetually terrified state of the remaining 20 silent bugs that certainly remain in my code.


### 24

2024-03-07


Wang Shuyi
@wshuyi
我尝试了 Claude 3 对视频转写文稿纠错润色能力，可以用「大惊失色」来形容。之前最强模型是 GPT-4 。你可以看看 Claude 3 与 GPT-4 输出结果对比。注意，提示词和原始转录文本内容完全一致，都来自于立青的 bibigpt 自动转写结果。Claude 3 润色后人名和中文标点稍微改改，基本就能发布了。


### 25

2024-03-07

歸藏
@op7418
昨天比较重要的一篇论文，通过他们的方案可以在整个大语言模型训练过程中显著降低内存占用。

只需要一张 24GB 内存的消费级 GPU（RTX 4090），就可以预训练 Llama 7B 大语言模型。

详细介绍：

训练大语言模型 (Large Language Models, LLMs) 面临着显著的内存挑战,主要是由于权重和优化器状态的规模不断增长。常见的内存减少方法,如低秩自适应 (Low-Rank Adaptation, LoRA),在每一层中向冻结的预训练权重添加可训练的低秩矩阵,以减少可训练参数和优化器状态。

然而,这些方法通常在预训练和微调阶段的性能都不如使用全秩权重训练,因为它们将参数搜索限制在低秩子空间,并改变了训练动态,此外,可能还需要全秩预热启动。

在这项工作中,我们提出了梯度低秩投影 (Gradient Low-Rank Projection, GaLore),一种允许全参数学习,但比常见的低秩自适应方法 (如 LoRA) 更节省内存的训练策略。我们的方法在优化器状态中减少了高达 65.5% 的内存使用,同时在 LLaMA 1B 和 7B 架构上使用 C4 数据集 (最多 19.7B 个 Token) 进行预训练,以及在 GLUE 任务上微调 RoBERTa 时,都保持了效率和性能。

我们的 8 bit GaLore 与 BF16 基线相比,进一步将优化器内存减少了高达 82.5%,总训练内存减少了 63.3%。值得注意的是,我们首次证明了在具有 24GB 内存的消费级 GPU (例如 NVIDIA RTX 4090) 上预训练 7B 模型的可行性,无需模型并行、检查点或卸载策略。

论文地址：https://arxiv.org/abs/2403.03507

### 26

2024-03-07


宝玉
@dotey
赞，MyShell这个开源TTS质量确实不错

MyShell
@myshell_ai
Take a trip through seminal moments in open source history that led to Linux, narrated by #MeloTTS - our new multi-lingual, multi-accent text-to-speech library now available open source.

### 27

2024-03-07

宝玉
@dotey
转自微博（@ i陆三金）：北京智源人工智能研究院、新加坡南洋理工大学、北京大学共同提出的通用计算机控制General Computer Control (GCC)，即智能体需要像人一样看屏幕，通过键盘、鼠标完成计算机上的所有任务。

研究团队提出了通用计算机控制智能体框架Cradle，使智能体不依赖任何内部API直接控制键盘、鼠标和任何软件交互，无论开源还是闭源，甚至能玩《荒野大镖客2》！！！

此前英伟达Voyager之类的研究依赖内部API获取输入并输出预定义动作，而Cradle以GPT-4V为基础，能直接根据游戏内的提示和教程生成对应的可执行代码作为技能，一步步丰富自己的技能库， 并在之后的游戏中重复使用这些技能。

难点：

（1）使用计算机屏幕作为输入对智能体的视频理解能力提出了更高的要求，例如由于没有内部API，需要通过视觉信息判断动作是否执行成功；

（2）使用键盘和鼠标操作作为输出使得智能体需要更高的时空操作精度，比如键盘按键和鼠标点击通常额外涉及时间维度。如何解决这些难题是构建通用计算机控制智能体(GCC Agents)的挑战。

Cradle主要由信息收集、自我反思、任务推断、技能管理、行动计划以及记忆模块等6个模块组成，其决策推理能力来自于「反思过去，总结现在，规划未来」。在执行了错误动作之后，Cradle能够有效地通过反思来发现并且纠正错误。

研究团队表示，为了能够实现真正的通用计算机控制，后续Cradle还将移植到更多软件和游戏上。

项目链接：https://baai-agents.github.io/Cradle/


### 28

2024-03-07

宝玉
@dotey
Alex Xu 分享了关于 Docker 是如何工作的精彩解析：

Docker 的神奇之处在于它的架构和一些特定命令的运行机制，例如“docker build”、“docker pull”和“docker run”。

Docker 的大脑可以分为三大部分：

🔹 **Docker 客户端 (Docker Client)**: 就像是我们与 Docker 的直接对话窗口，它负责将我们的命令传达给 Docker 的大脑核心。

🔹 **Docker 主机 (Docker Host)**: 这里是 Docker 的行动中枢，负责听取来自客户端的指令，管理所有的 Docker 对象——包括那些用于运行我们的应用的镜像、容器，以及网络和存储卷。

🔹 **Docker 注册表 (Docker Registry)**: 想象成一个巨大的图书馆，存放着各式各样的 Docker 镜像，而 Docker Hub 就是最著名的公共图书馆，向所有人开放。

举个 “docker run” 命令的例子来看看 Docker 是怎样一步步工作的：
1. 从注册表中获取指定的镜像。
2. 基于这个镜像创建一个全新的容器。
3. 为这个容器配备一个可以读写的文件系统。
4. 建立一个网络接口，将容器接入默认的网络中。
5. 最后，启动容器，让它开始运行。

来源：

https://x.com/alexxubyte/status/1766507730171527556?s=20

### 29

2024-03-10

宝玉
@dotey
一个帮助做决策的提示词，核心思路就是让LLM同时给出多种解决方案，并且对于每种方案进行分析，最后基于所有的方案和分析，选择一个最好的方案。

有些类似于我以前翻译字幕，让LLM给出几种翻译方案，最后让LLM选择组合一个最好的翻译结果出来。

---
您是一位工程领域的专家，精通解决各种学科中的复杂问题。您的知识面既广又深。同时，您也是一位出色的沟通者，能够提供非常细致和明确的意见。

请按照以下格式进行思考：首先分析您面临的挑战，提出几种可能的解决方案，随后深入分析每个方案，寻找潜在的问题或可改进之处，可能会提出一个结合了其他方案的想法或引入新想法的更佳解决方案，最后给出您的最终建议：

```
\## 问题概览
$problem_overview

\## 面临的挑战
$challenges

\## 方案一
$solution_1

\## 方案二
$solution_2

\## 方案三
$solution_3

\## 方案分析

\### 方案一分析
$solution_1_analysis

\### 方案二分析
$solution_2_analysis

\### 方案三分析
$solution_3_analysis

\## 可能的额外解决方案
$additional_possible_solution

\## 推荐方案
$recommendation
```

每个部分（问题概览、面临的挑战、方案一、方案二、方案三、方案一分析、方案二分析、方案三分析、可能的额外解决方案、和推荐方案）都应深思熟虑，至少包括四句反思。


### 30

2024-03-10

https://x.com/ylecun/status/1766498677751787723?s=20

Yann LeCun

@ylecun
* Language is low bandwidth: less than 12 bytes/second. A person can read 270 words/minutes, or 4.5 words/second, which is 12 bytes/s (assuming 2 bytes per token and 0.75 words per token). A modern LLM is typically trained with 1x10^13 two-byte tokens, which is 2x10^13 bytes. This would take about 100,000 years for a person to read (at 12 hours a day).

* Vision is much higher bandwidth: about 20MB/s. Each of the two optical nerves has 1 million nerve fibers, each carrying about 10 bytes per second. A 4 year-old child has been awake a total 16,000 hours, which translates into 1x10^15 bytes.

In other words:
- The data bandwidth of visual perception is roughly 16 million times higher than the data bandwidth of written (or spoken) language.
- In a mere 4 years, a child has seen 50 times more data than the biggest LLMs trained on all the text publicly available on the internet.

This tells us three things:
1. Yes, text is redundant, and visual signals in the optical nerves are even more redundant (despite being 100x compressed versions of the photoreceptor outputs in the retina). But redundancy in data is *precisely* what we need for Self-Supervised Learning to capture the structure of the data. The more redundancy, the better for SSL.
2. Most of human knowledge (and almost all of animal knowledge) comes from our sensory experience of the physical world. Language is the icing on the cake. We need the cake to support the icing.
3. There is *absolutely no way in hell* we will ever reach human-level AI without getting machines to learn from high-bandwidth sensory inputs, such as vision.

Yes, humans can get smart without vision, even pretty smart without vision and audition. But not without touch. Touch is pretty high bandwidth, too.


### 31

2024-03-10

https://x.com/op7418/status/1767068140100571454?s=20

歸藏
@op7418
上周黄仁勋在斯坦福做了一次访谈和演讲，这一个小时的演讲内容量很大，主要的包括公司治理的经验和要点以及人工智能未来的发展问题。

翻译了一下这个视频并且给每个部分加上了时间戳，下面是简要的文字内容介绍：

演讲者Jensen Huang是Nvidia公司的CEO，他在AI及其所需的创新、技术和人力资源方面具有前瞻性的见解。

Jensen分享了他的个人经历，从九岁移民美国到成为Nvidia公司CEO的过程。他强调了教育和技术创新的重要性。Nvidia公司通过重塑计算，将深度学习的计算成本降至接近零，使AI能够从互联网提取和理解人类知识成为可能。

Jensen认为，AI是21世纪最重要的技术发明。Nvidia开发的GPU芯片和架构，大幅提升了深度学习和AI的计算能力，并广泛应用于各行业的数据中心。未来，AI计算机将能进行持续学习、合成数据生成和强化学习，并通过真实世界的经验来完善。

Jensen强调AI要以人类价值观为基础。聊天GPT通过强化学习和人类反馈，将AI与人类价值观联系起来。未来AI需要建立世界模型，理解多模态概念，具备推理和规划能力。他预测5年内AI可能通过各类人类测试，实现类似人类的智能（AGI）。

AI有望帮助人类理解生物学，如蛋白质的功能和意义。它将改变人类获取信息和知识的方式。未来，人人都能通过自然语言与AI交互，无需掌握编程。各国需要在主权AI领域进行投资，保护自己的数据、智能和文化。

Jensen分享了他的管理理念——通过不断评估、统一激励方式和信息透明来保持员工的积极性。他认为公司文化的塑造需要坚持品质、经历磨砺，重视过程和结果。Nvidia欢迎合作伙伴在其AI生态系统的基础上进行适度的定制化开发。

时间戳及分段标题：

00:00 介绍Jensen Huang及其在AI领域的贡献

01:15 John Shoveon是一位杰出的建筑师和经济学教授

02:02 演讲者欢迎John Shoveon并感谢其贡献

03:17 Jensen的个人经历：从移民到与妻子的爱情故事

04:46 Jensen在技术领域取得的成就和荣誉

05:57 Jensen当选为国家工程院院士

07:02 讨论开场白及晶体管技术的重要性

08:10 技术变革和新型计算方法的发展

09:14 计算成本的降低使AI能够代替人类编写软件

10:11 深度学习推动了计算成本的快速降低

11:03 利用计算机从互联网提取和理解人类知识

12:00 AI能够理解氨基酸序列和蛋白质的结构功能

12:49 AI是21世纪最重要的技术发明

13:51 Nvidia芯片的性能和成本优势

15:04 通过芯片创新将数据中心缩小到一个芯片

16:02 未来计算机的特点：重量重、液冷、持续学习

17:03 AI通过交互数据和合成数据持续学习和想象

18:01 未来AI将结合合成数据生成和强化学习

18:55 计算成本降低带来的可能性和市场变化

19:55 使用AI进行推理的过程和Nvidia GPU的作用

20:50 推理的难点在于吸引更多用户和软件应用

21:44 架构的普及和用户基础是推理问题的关键

22:30 竞争对手和客户带来的竞争威胁

23:31 Nvidia的架构优势：加速算法和可编程性

24:30 Nvidia在计算领域的标准地位和广泛应用

25:27 Nvidia芯片的总运营成本优势

26:27 Nvidia面临的竞争和对AGI的道歉

27:25 多模态学习对AI未来发展的重要性

28:21 AI要建立在人类价值观基础上

29:24 AI需理解多模态概念和掌握推理能力

30:16 AI目前在长时间思考和推理方面的局限性

31:03 未来人机交互方式的变化和AGI的定义问题

31:59 对AGI的测试标准和实现时间的预测

32:56 AI在药物发现和理解蛋白质功能中的作用

33:54 未来与AI对话获取信息的方式

34:56 AI帮助人类理解生物学意义的潜力

35:57 给创业者的建议：拥抱困境和磨砺

37:16 公司品质来自经历苦难而非智慧

38:13 如何保持员工积极性：统一激励和信息透明

39:28 不进行私下沟通，信息快速流动，唯才是用

40:34 每天寻找机会灌输公司文化

41:19 预测未来AI增长对半导体制造能力的需求

42:28 未来计算方式将基于实时生成而非预先录制

43:27 AI将根据个人上下文生成所需信息

44:27 算法改进和技术进步将抵消算力需求增加

45:21 编程和创业格局的变化趋势

46:17 自然语言交互取代传统编程，人人皆可编程

47:16 提示工程的重要性和控制AI的方法

48:10 AI普及将消除技术鸿沟，惠及所有人

49:12 无需编程也能与AI交互，揭示CS的重大贡献

50:10 美国限制AI出口，各国投资主权AI的重要性

51:17 国家需要保护自己的数据、智能和文化

52:19 讨论公司竞争对手和定制化解决方案

53:22 芯片成本高昂的原因：多组件和大量软件

54:14 芯片定制化的意义：安全性和保密性


### 32

2024-03-11


歸藏
@op7418
Yam Peleg老哥认为Claude 3跨越了专业编程人员可以使用的门槛，GPT-4对初学者很有帮助，但是很少又专业开发者使用它帮助编程，但是Claude 3 有越来越多的专业用户使用。

完整翻译：

我认为 Claude 3 跨越了一个有趣的门槛,或者说非常接近这个门槛:专业用户的门槛。这是第一次一个 AI 系统能够帮助专业用户比他们自己更快地完成繁重复杂的任务。这在 AI 领域是一个备受争议的话题。

我个人从来不用 GPT-4 来编写代码。我主要用它来做以下几件事情:

集思广益,激发灵感。
学习我不了解的新话题。
替我阅读长文本 (比如使用 ask-your-pdf 这样的工具)
完成一些简单的小任务。
但我从来不用它写代码。它从来没有真正帮助我提高编程效率。

每当我试图用 GPT-4 来完成编程任务时,我发现自己浪费的时间比从头开始自己写代码要多得多。我不是唯一一个得出这个结论的人,我认识很多人都有同感。

但我们很少在公开场合提起这一点。因为几乎所有人都在盛赞 ChatGPT 神奇的编程能力,以及它为他们节省了多少时间。

那么为什么会出现这种差异呢?我的解释是:当你需要学习新东西来完成手头的编程任务时,ChatGPT 的确非常有用。在当今这个时代,许多程序员经常要接触和学习新的框架或工具。在这方面,ChatGPT 的帮助非常宝贵。

但另一方面,有经验的程序员通常精通自己的领域,很少需要一头扎进一个全新的框架或编程语言。即使碰到这种情况,他们也可以凭借自己的经验很快上手。

所以对这群默默无闻却经验丰富的开发者来说,此前并没有一个类似 ChatGPT 的解决方案能满足他们的需求。因为他们自己在编程速度、准确性、处理极端情况、避免bug、编写简洁高效的代码等方面,往往比 ChatGPT 强得多。

打个比方,让一个 ChatGPT 来辅助这些专业程序员,就像让一个新手来帮助专家。这个新手偶尔能提供一点帮助,但更多时候会拖慢专家的进度,需要专家给出详细的指示和解释。

但在 Claude 3 发布后的这几天,我看到一些经验丰富的程序员表示,他们已经在实际工作中用到了 Claude 3。这让我感到有点惊讶,以至于我马上掏出 20 美元给了 amodei (Anthropic 公司 CEO),购买 Claude 3 来亲自测试。


### 33

2024-03-11


歸藏
@op7418
一个将自己的Obsidian本地笔记库用于RAG的项目，用的模型是Mistral 7b，会根据问题合成搜索词的Agents，并查询数据库。

检索相关/链接的笔记以获取与相关主题相关的额外上下文。

作者说会开源，有类似需求的可以关注一下。

https://x.com/TrainedOnTest/status/1766898886340141443?s=20


AW
@TrainedOnTest
today's project: exposing my Obsidian vault as a graph database for RAG

- For the LLM i'm using mistral 7b locally
- made agents to synthesize search terms based on my question, and query the database
- retrieve the relevant/linked notes for additional context to related topics

### 34

2024-03-11


Leeoxiang #Tencent
@leeoxiang
\#声音clone产品推荐

开源的实现：
1、GPT-SoVITS： https://github.com/RVC-Boss/GPT-SoVITS    对中文、英文、日文支持都不错，需要 10 分钟左右的干素材，瞬时 clone 的能力还没开放。

2、OpenVoice：https://github.com/myshell-ai/OpenVoice  对中文支持还可以，主打瞬时 clone，发展势头很好，一个月前测试的时候中文声音 clone 还有一股英语味道。

商业的产品：

1、ElevenLab：https://elevenlabs.io  商业实现中支持语言种类最多的，支持 瞬时 clone，综合效果最好的一个产品，我是 22$每个月的订阅用户，已经在内部的配音产品上用上。

2、Reecho：https://reecho.ai  中国团队，支持长音频声音 clone 和瞬时声音 clone，据说是和火山引擎的声音 clone 技术是同源的。

3、自得语音：https://zideai.com  中国团队，支持瞬时声音 clone 和声音定制，还没测试。

推友们用过哪个，请评论给出你的反馈。 #声音克隆

https://x.com/leeoxiang/status/1766700987627327683?s=20

### 35

2024-03-11

Andrej Karpathy
@karpathy
\# automating software engineering

In my mind, automating software engineering will look similar to automating driving. E.g. in self-driving the progression of increasing autonomy and higher abstraction looks something like:

1. first the human performs all driving actions manually
2. then the AI helps keep the lane
3. then it slows for the car ahead
4. then it also does lane changes and takes forks
5. then it also stops at signs/lights and takes turns
6. eventually you take a feature complete solution and grind on the quality until you achieve full self-driving.

There is a progression of the AI doing more and the human doing less, but still providing oversight. In Software engineering, the progression is shaping up similar:

1. first the human writes the code manually
2. then GitHub Copilot autocompletes a few lines
3. then ChatGPT writes chunks of code
4. then you move to larger and larger code diffs (e.g. Cursor copilot++ style, nice demo here https://youtube.com/watch?v=Smklr44N8QU)
5....
Devin is an impressive demo of what perhaps follows next: coordinating a number of tools that a developer needs to string together to write code: a Terminal, a Browser, a Code editor, etc., and human oversight that moves to increasingly higher level of abstraction.

There is a lot of work not just on the AI part but also the UI/UX part. How does a human provide oversight?  What are they looking at? How do they nudge the AI down a different path? How do they debug what went wrong? It is very likely that we will have to change up the code editor, substantially.

In any case, software engineering is on track to change substantially. And it will look a lot more like supervising the automation, while pitching in high-level commands, ideas or progression strategies, in English.

Good luck to the team!


### 36

2024-03-15

宝玉
@dotey
华尔街日报对OpenAI CTO采访视频完整版（双语字幕）

1. 发布时间:OpenAI希望Sora最快在几个月内向公众开放,有可能在2023年内,但要避开影响全球选举等重大事件的敏感时期。

2. 生成视频速度:目前生成一个片段需要几分钟,取决于任务复杂性。未来会致力于性能优化。

3. 主要缺陷:物体连续性和手部动作等细节处理还不够完美,如出租车消失又出现,人物手指数量异常等。

4. 训练数据:使用了公开和经许可的数据,包括Shutterstock等来源,具体数据集没有透露。 

5. 原理:Sora是一个扩散模型,通过分析大量视频学习,根据文本提示在时间线上添加细节来构建连贯场景。

6. 声音:目前Sora还不支持声音,未来会考虑添加音频功能。

7. 计算资源:生成一个Sora视频的成本远高于一个DALL-E图像或ChatGPT回复,目标是将来达到类似DALL-E的使用成本。

8. 安全性:正在进行风险评估与安全测试,考虑限制生成公众人物等敏感内容,研究给视频打水印等方法区分真实内容。

9. 裸露内容:对于是否允许生成裸体艺术内容,还在与艺术家讨论政策制定中,暂不确定。

原始视频：https://youtube.com/watch?v=mAUpxN-EIgU


### 37

2024-03-15

歸藏
@op7418
三星的 FineControlNet 代码发布了，这个ControlNet模型可以将文本内容和输入的预处理图像进行匹配，得以精确控制每个物体的表现。

比如OpenPose输入图中一个人蹲着一个人站着，输入提示词的时候分别说两个姿势对应人的特征也是可以还原的。这个就很爽了。目前只发布了 SD1.5 的模型。

模型下载：https://huggingface.co/lllyasviel/ControlNet-v1-1/tree/main


### 38

2024-03-15


歸藏
@op7418
苹果加入战场，发布了自己的大语言模型 MM1，这是一个最高有 30B 规模的多模态 LLM 。

论文关键信息：

图像分辨率、图像编码器的预训练数据和模型大小对性能有显著影响。

视觉-语言连接器的设计相比之下影响较小。

预训练数据的混合比例对于少样本和零样本（zero-shot）性能至关重要。

通过预训练和SFT，MM1模型在多个基准测试中取得了SOTA性能。

MM1模型展现了一些吸引人的特性，如上下文内预测、多图像推理和少样本学习能力。

模型实现方案：

架构组件和数据选择的消融实验：

图像编码器：研究了不同预训练图像编码器的影响，以及图像分辨率和图像标记数量的重要性。

视觉-语言连接器：

探讨了不同类型的视觉-语言连接器（如平均池化、注意力池化和C-Abstractor）对模型性能的影响。
预训练数据：使用了图像标题、交错的图像-文本和纯文本数据，研究了这些数据类型及其混合比例对模型性能的影响。

模型构建和预训练：

通过扩大模型规模（从3B到30B参数），包括密集模型和混合专家（mixture-of-experts，简称MoE）变体，构建了一系列性能优越的多模态模型。

在预训练过程中，使用了大规模的多模态数据集，并通过特定的数据混合比例来训练模型。

性能评估和结果：

评估了预训练模型在多个基准测试中的性能，包括图像标题和视觉问答（VQA）任务。
通过监督式微调（Supervised Fine-Tuning，简称SFT），在一系列多模态基准测试中取得了有竞争力的性能。

论文地址：https://arxiv.org/pdf/2403.09611.pdf


### 39

2024-03-15

sitin
@sitinme
独立开发4年，分享几点最近的思考：

1. 一定要给自己时间定价，哪怕没有人认可也要，这是对自己时间注意力保护，远离白嫖，伸手党。

2. 开始做自己的小生意，带个货，建一个群？哪怕收费 9.9元，也是不错的开始，认知到这点很重要。

3. 1元的小生意，放大千倍万倍收益也会非常客观，最近认识的朋友无一不是这样，批量操作几百个GZ号，VX号等等

4. 独立开发者容易上手的小生意：1. 小工具 ，2. 做社群，3. 做课 4. X 推广广告（如果你有读者）

5. CSDN副业最近不错：1. 赚取平台资料源码收益 2. 私下部署，接单毕业设计等项目

6. 让别人知道你是谁？你能干什么？能提供什么服务很重要。

7. 你刚开始做什么不重要，重要的是你多年以后依然在做这件事，就能拿到自己的红利。

8. 先动起来，而不是等想清楚，很多事情干起来才会更清楚。

9. 提高效率方法：缩短路径，降低损耗，如无必要，勿增实体。


### 40

2024-03-15


宝玉
@dotey
转译：Claude 3 Haiku：Anthropic 迄今为止最快的模型

今天，我们非常兴奋地宣布推出Claude 3 Haiku模型，它不仅速度飞快，而且性价比极高，在其智能级别中无与伦比。Haiku搭载了尖端的视觉识别技术，无论是在行业标准测试上还是实际应用中都表现出色，成为企业解决方案的佼佼者。现在，我们的Claude Pro订阅用户可以在Claude API中找到Haiku，与Sonnet和Opus模型并列。

在企业级应用中，处理速度至关重要，尤其是当涉及到快速分析大量数据集和生成实时反馈时。Claude 3 Haiku能够以惊人的速度工作，对于大部分任务来说，它的处理速度是同类产品的三倍，能够在一秒内处理约30页的内容（21K Token），为用户提供快速且流畅的聊天体验及高效执行多任务。

Haiku的高效定价策略，基于1:5的输入输出Token比，特别适合处理长篇的企业级任务。不论是分析季报、合同还是法律文件，Haiku都能以其他同级模型一半的成本快速完成，比如仅用一美元就能分析400个最高法院案例或2500张图片。

在速度和成本效益之外，Claude 3 Haiku还特别注重企业级的安全性和稳定性。通过严格的测试减少有害输出和模型越狱的风险，确保使用安全。此外，我们采取了包括持续监控、端点加固、安全编码、强加密协议和严格的访问控制在内的多层防护措施，保护用户数据安全。我们还定期与安全专家合作审计和渗透测试，积极发现和修补安全漏洞。更多安全措施详情，请参阅Claude 3模型卡片。

从今日起，客户就可以通过我们的API或http://claude.ai上的Claude Pro订阅，体验Claude 3 Haiku的强大功能。不久后，Haiku还将在Amazon Bedrock和Google Cloud Vertex AI平台上推出，敬请期待。

注：
1. 当提示超过32K Token时，处理速度可能下降30-60%，我们预计在未来几周将有所改善。处理图片时可能会有额外的延时。

2. 每个最高法院案例的数据量约为10K Token。

3. 每张图片的数据量约为1.6K Token。

https://anthropic.com/news/claude-3-haiku

### 41

2024-03-15


宝玉
@dotey
《字幕翻译、书籍翻译的福音，如何借助ChatGPT得到高质量的翻译结果？》

过去几个月里，我独立翻译了一百多部视频（https://space.bilibili.com/589397373/video ），可以说绝大部分翻译质量还是相当不错的。

如果完全靠自己的英文和中文水平，要达到这样的翻译速度和质量那是不太可能的，主要还是得益于ChatGPT的帮助，首先用GPT-4的API粗翻，再用ChatGPT Plus精翻。

很多人都用过ChatGPT翻译，但翻译出来的结果比起Google翻译和DeepL这种，似乎翻译质量并没有好太多，但其实是你没有最大化的利用大语言模型的优势，如果你能善用ChatGPT（尤其是GPT-4）这样的大语言模型，可以让你的翻译质量提升一个大台阶。

那么大语言模型相对于传统的翻译工具有什么优势呢？

1. 可以根据Prompt产生不同的结果

使用大语言模型的时候，借助Prompt你可以提出很多个性化的要求，比如说：
- 可以提供不同的翻译风格，比如你可以将翻译的结果更加口语化
- 你可以将某些专有名词使用特定的翻译（不会闹笑话把“LLM”翻译成“法学硕士”）
- 你可以提供上下文让翻译更有针对性，比如说这是一篇 AI 相关的技术文章，尽可能翻译成专业术语
- 你可以让它识别错别字，比如在语音转文字时，经常会产生错别字，或者翻译完成也可能会有错别字，这些错误人工纠正很容易疏漏，可以让AI帮你纠正，又快又准
- 可以提供背景解释，大语言模型背后有一个超级庞大的知识库，几乎囊括了互联网所有的公开信息，有时候我们在翻译时，遇到一些因为文化背景不一样的内容，很难理解其中的含义，这时候就可以让大语言模型帮你解释，帮助你更好的理解
- 等等

当然缺点也有：
1. 价格高（如果是API比较贵，包月的ChatGPT Plus其实性价比还是挺高）
2. 速度慢，比谷歌翻译和DeepL这些速度要慢

这里分享一下我使用ChatGPT帮我翻译字幕的经验。

一、写好Prompt

用ChatGPT的第一条就是写好Prompt，如果你只是写“请将我翻译以下内容为中文”，也能得到一个还不错的结果，但这样只是把ChatGPT当DeepL来用了。

但如果你能写一个高质量的Prompt，那么就能得到更好的结果。一个好的Prompt的结构（参考 https://twitter.com/dotey/status/1681188469995888642  ）：
✅ 角色、技能、个性
✅ 目标、任务
✅ 生成规则
✅ 输入输出格式
✅ 示例

比如我通常会给它先设定一个角色：
“你是一位精通简体中文的专业翻译，写作风格是短小精悍、通俗易懂。”

然后给它的任务：
“现在你要帮我将以下英文字幕翻译成中文”

再加上一些规则：
- 忽略错别字或者拼写错误
- 翻译时结合上下文意译而不是直译
- 译文通俗、简洁、易懂
- 英文单词前后加上空格

在有些情况下给出示例，比如说：
“英文单词前后加上空格，例如"中 English 文"”

有时候会说明输出格式：
“提供 5 种不同类型的翻译风格：意译、直译、口语化翻译、创意翻译、文学翻译”

二、提供足够的上下文，但一次只翻译一段，并且提供多个翻译结果选择

使用ChatGPT时，如果提供足够的上下文，那么有助于ChatGPT更好的理解要翻译的内容，给出更好的结果。

所以我在翻译字幕时，会尽可能将完整字幕一次性输入，这样ChatGPT可以看到完整的内容，能更好的纠正错别字、给出更好的翻译结果。

但我每次只让ChatGPT翻译一段，因为输出结果太长的问题在于：
1. 很容易超出最大上下文长度，比如我输入完整英文字幕，让ChatGPT完整翻译，通常最后一部分会无法正常输出，产生“幻觉”，因为超出了最大上下文长度。
2. 输出内容长的话质量要低一些，参考论文《Lost in the Middle: How Language Models Use Long Contexts》https://arxiv.org/pdf/2307.03172.pdf

但是一次翻译一段的话，缺点就是速度慢一些，翻译完一段又要输入一段。但是对于精翻来说还可以接受，因为本来就需要慢工出细活，逐句斟酌。

另外还有一个很重要的技巧，就是翻译的时候，让ChatGPT一次提供3-5个不同风格的翻译结果，然后你就可以得到很多不同角度的翻译结果，大部分时候，你只要从这几种不同翻译结果里面选一个就可以了。

ChatGPT这类大语言模型是一种概率模型，根据概率生成内容，有时候很难一次就得到一个很好的结果，所以要得到好的生成效果，可以让它一次多生成几种结果，然后你可以从中选一个最好的，甚至于你可以让它自己帮你选一个。

有的时候，它能随机出来相当不错的翻译结果，所以大部分时候就只要从几个翻译选项中选一个最好的，或者组合一下。

三、追问，帮助更好的理解原文

有时候就算它提供了若干翻译选项供选择，但还是很难理解什么意思，这时候就可以在ChatGPT中追问。

比如上一次我在翻译Sam Altman一段关于授权的回复时，他说：“setting the training wheels at the right height and increasing them over time as people learn more and I build up more trust.”，然后ChatGPT的翻译结果是：“适当地设置“训练轮”，并随着人们学到更多知识和我对他们的信任增加而逐步提高。”。

说实话我是没看懂，如果我直接就这么翻译，从字面上理解也没问题，但是肯定有很多人像我一样看不懂什么意思。于是我就继续问ChatGPT：“能不能详细解释一下这里的"setting the training wheels at the right height"？”

于是ChatGPT给我详细解释了这里的意思：
> “设置合适高度的训练轮”这个短语可以理解为在团队管理和人员培养方面，为新员工或团队成员提供适当的支持和指导，而不是一开始就给予他们太多的责任和压力。这里的“训练轮”可以比喻为在员工成长和学习的初期阶段提供的辅助工具或支持，而“合适的高度”则意味着这种支持和指导应该是适度的，既不能太少也不能太多，以便他们能够逐步学习和适应，最终能够独立完成任务和承担更多的责任。随着时间的推移，这些“训练轮”会逐渐提高，意味着给予员工更多的自由和责任，让他们有更多的机会来展示他们的能力和潜力。

我继续问：“请按照上面的解释重新翻译”，于是我得到了一个新的翻译结果：
“我们要像调整孩子自行车上的辅助轮那样，为他们设定合适的支持和指导，随着他们的学习和我对他们的信任逐渐增加，我们可以逐步提高这个“辅助轮”的高度。”

这样就容易理解多了，因为“training wheels”是特指自行车的辅助轮，其实去年教孩子学自行车我就知道这单词，但是没有那么熟悉，尤其是一开始被翻译成“训练轮”，我很难将它和自行车的辅助轮联系起来，但是你一追问，那么ChatGPT就能从多个角度帮你分析解释，这样译者就能更好的理解原文的意思和背景，从而提供更为准确的翻译。

我觉得现在很多著作的中文翻译很晦涩难懂，很多时候是因为译者自己都没看懂，只能按照字面意思翻译，如果他们借助ChatGPT理解背后的意思，那么就能提供更好的翻译结果。

四、使用时避免上下文超长

ChatGPT这类LLM有个天然缺陷，就是上下文窗口无法太长，比如ChatGPT Plus，按我的经验，GPT-4大约8K的Token就是上限了，差不多~6000英文、~4000中文的样子。如果超出这个长度，后面的内容会出现幻觉，也就是胡说八道，出来的结果跟你输入的完全不相关。

避免这个问题有两个小技巧：

1. 优先使用Advanced Data Analysis（以前叫Code Interpreter）模型，这个模型上下文窗口明显能长一些

2. 多用ChatGPT的编辑功能

如果你在ChatGPT中不停地回复新内容，那么每次生成的时候都会把历史消息都加入发送过去，这样越到后面占用的Token越多，一会就会超出上限。

但是如果你每次只是编辑消息的话，它就只修改，不新增。所以我通常第一条消息发Prompt，第二条消息用来编辑，不停的变更要翻译的段落，这样每次都只有2条消息，基本不会超过上下文长度上限。

总结

一、根据你的使用场景写好你用来翻译的Prompt
二、提供足够长的上下文，但是每次只翻译一段，并且提供多种翻译风格供选择参考
三、借助追问，帮助你更好的理解原文
四、避免上下文超长

以上就是我使用ChatGPT进行翻译的经验总结，希望对大家有所帮助。

附：

图一：用来让ChatGPT翻译的Prompt
https://chat.openai.com/share/4236c6c9-792b-45b4-a79b-349435408705
图二：追问，更好的理解上下文，得到更好的翻译结果
https://chat.openai.com/share/fac23c8e-ebff-4bd1-afcf-5240d0f9905e
图三：不同翻译风格的结果
图四：使用编辑功能避免上下文超长

---

宝玉
@dotey
之前我分享过，每次翻译字幕时，在精翻阶段，通常我会让ChatGPT给我提供3-5个不同风格的翻译选项，然后我从中挑选好的，大部分时候都不需要修改，只要逐句选择最好的翻译就好了。

虽然已经简单很多了，但是还是有点筛选工作，于是我想，是不是可以优化一下这个过程？

但怎么能让AI帮我挑选最好的呢？并且是真的符合我的标准的好的结果。

我联想到CoT（Chain of Thought），通过分步可以让LLM得到更好的结果。

联想到没有ChatGPT的时候我翻译的步骤：先用Google翻译，得到一个差不多的粗糙结果，然后一个个去校对，最后忘记英文，只用中文润色。

也许我们可以借助CoT来一步步优化翻译结果。

于是我先将翻译拆成两步，打印每一步的结果：

第一步：就是直译，就像我们用Google翻译那样，好处是可以忠于原意

第二步：基于第一步直译的结果，结合上下文，重新意译

我发现这样调整后，第一步的翻译结果和以前差不多，但是第二步的结果明显好于以前直接让 ChatGPT 意译的效果，说明 CoT 是有效果的。

然后我再将它扩展成四步：

第三步：基于第一步和第二步，提供一种创意翻译结果（这一步其实可以根据自己需要调整），主要是作为第二步意译的一个补充，为第四步提供足够的素材

第四步：现在已经有了三步的迭代，我们已经有了三个不错的翻译版本，这时候可以让ChatGPT不需要看英文了，当做一个中文老师，擅长修改，有三个学生的提供了中文句子，基于他们的句子做出批改，最终形成一个最好的中文版本。

实际效果来看挺不错的，大多数时候我只要选择第四步的结果，偶尔需要参照第二步和第三步的结果，几乎不需要第一步的结果。

不知道是不是可以水一篇论文：《如何借助CoT得到高质量的翻译结果》👨‍🎓🤪

Prompt参考：https://chat.openai.com/share/1feb6eaa-c2e8-4db0-87ae-adbce8b74c7f



### 42

2024-03-15

宝玉
@dotey
搜索能力当然很重要，举个简单的例子，为啥我经常能发现一些优质冷门开源项目？

因为我搜索代码一般不会用Google，而是用GitHub的代码搜索，根据一些特定的接口名或者函数名去搜索，就能发现很多有意思的代码和项目，


### 43

2024-03-16

歸藏
@op7418
字节跳动 2023 年的营收达到 1200 亿美元（当前约 8640 亿元人民币），同比增长约 40%。

今年营收不会达到1万亿人民币吧，太离谱了。


### 44

2024-03-16

歸藏
@op7418
一个开源的上市公司财报文件数据提取工具，使用Mistral-7B提取了10-K的收入报表。输出结果被整洁地格式化为JSON。

工作流介绍：

•下载并分块SEC申报文件 
• 将块存储在向量数据库中 
• 查询向量数据库以获取财务数据 
• 使用大语言模型（LLM）提取财务数据 
• 使用 instructor 输出JSON

后续的to-do：

•从SEC申报文件中提取所有财务报表。

•将财务报表结构化为JSON。

•将报表存储在SQL数据库中。

•构建一个API来提供存储的报表。

•从应用程序调用API，并以表格形式呈现财务数据。


### 45

2024-03-16

歸藏
@op7418
Magnific 这两个老哥真是AI时代个体创业起飞的典型了，就只是把图像放大这个非常小的功能打磨到极致给自己带来了丰厚的收益和影响力。

所有的图像生成工具都把他们的产品当成标杆去比较和宣传。他们昨晚也发布了关于这段时间发展的一些思考：

-----------------------------

每当看到竞争对手用我们的名字（Magnific）来做点击诱饵或市场营销，我觉得应该是种荣幸。

过去这几个月，我们收到了无以伦比的关注，Leonardo、Krea、Freepik、Scenario、Playground，甚至是Stable Diffusion，还有Reddit上的无数帖子，涉及ComfyUI/Automatic1111，都在推出他们自己的图像增强器，并把我们作为标准。

想到我们两个来自西班牙一个小城市Murcia的普通人竟成为了众人关注的焦点，真是难以置信。对我和Emilio来说，这一切都像疯狂的梦境！

市场上有个空白点，被Magnific填补了，直到那时，没人意识到它的存在。

现在，它有了一个名字，一个我们在Magnific旅程初期就共同铸造，带着情感称呼的名字：

重新想象的图像增强（REIMAGINED UPSCALING）。

看到其他竞争者也想跻身其中，这很正常！不仅正常，对大家都有好处！

对你们来说，因为有了更多选择；对我和Emilio来说，因为这激发了我们更上一层楼的决心！

但说实话，当有些人试图欺骗人们，让他们误以为他们掌握了“唯一的Magnific配方”时，我会感到遗憾，因为事实上他们并没有。Magnific配方的精髓在于许多细微之处的调整，这是无法复制的。

更重要的是... 他们根本不需要“Magnific配方”！你知道吗？每个图像增强器最终都可能是独特的，都会有自己的特色！

未来会有比Magnific更好的图像增强器吗？当然会！但对一些人来说，最好的永远是Magnific，因为我们有自己独特的魔力，自己的风格。是的，即便是在像图像增强这样的事情上。这当然也适用于其他竞争者。嘿，我们不会嫉妒的 :)

所以，被视为行业标准，我们感到荣幸，但... 我这次想认真说说，没有必要试图通过宣称“我们是新的Magnific”或“我们拥有Magnific配方”来欺骗人们.... 因为你知道吗？这不仅不真实，而且你还在撒谎，最关键的是，成为一个优秀的图像增强器，你只需要有自己的特色！

竞争者们，请公平竞争！这个市场上有足够的空间给大家。不要欺骗人们。要公平。要诚实。


### 46

2024-03-16

歸藏
@op7418
Ethan Mollick这个论点很有意思，全球有非常多的个人利用AI提高效率节约时间，但是对中大型的公司或者政府组织的帮助很有限。

因为AI的固有缺陷以及担心被替代，导致使用AI的个体不敢向公司透露自己使用AI产出内容。

为了让组织从AI中受益，他建议需要改变组织的运作方式：

1️⃣首先，公司需要认识到，擅长使用AI的员工可能来自组织的任何层级，并提供广泛的培训和分享工具。

2️⃣其次，领导者需要减少员工因透露AI使用而感到的恐惧，例如提供不因使用AI而裁员的保证。

3️⃣第三，组织应该通过提供激励措施来鼓励员工公开他们的AI使用情况。

4️⃣最后，公司需要迅速解决一些基本问题，如如何处理AI带来的生产力提升、如何重组工作流程以及如何管理可能涉及AI错误和知识产权问题的工作。

AI已经在许多行业产生影响，组织不能推迟考虑这些问题，否则将面临更糟糕的长期结果。


### 47

2024-03-16

歸藏
@op7418
苹果在前几天发布的多模态模型MM1论文里面对多模态模型训练的过程和参数写的异常详细。

现在都反过来了，以前开放的不再开放，以前封闭的现在变得开放了。

论文中不仅深入讨论了众多架构设计，还透露了他们使用了由GPT-4V生成的数据进行训练。

更令人惊讶的是，他们提供了非常精确的缩放律系数（scaling law coefficients）（精确到四位有效数字）、混合专家设置（MoE settings），甚至是最优学习率函数（optimal learning rate functions）的详细信息。


### 48

2024-03-16


宝玉
@dotey
引言

Nicolai: 大家好。我刚经历了人生中最不可思议的事情，我有幸采访了微软的CEO、Satya Nadella。微软现在是全球市值最高的公司。真是太棒了，请继续关注。

第一章 微软的发展与平台转变

Nicolai: Satya,你是全球市值最高公司的CEO，你近期都在想些什么呢？

Satya: 首先，我非常高兴与你进行这次对话。我现在主要关注两个问题。第一，在我们科技行业，尤其是我在微软工作的这32年里，没有什么东西可以长久保持其价值。这就意味着你需要每天都在思考如何让你所做的事情跟得上时代的步伐。这是我过去几十年学到的最重要的一课。

第二，我所处的阶段可以说是面临着一个全新的平台转变。尽管我在微软已经工作了32年，但这才是我经历的第四次平台转变的第二年。所以我在思考这个平台转变到底包含了什么？我们公司能否全力投入并进行创新？

我感觉很新鲜。我在思考如何在新的平台转变中找到自己的位置，这令人兴奋。没有长久的价值，但这也意味着我们可以重新开始，无论是曾经赢得的争夺还是失去的争夺，都有机会重新开始。

第二章 科技的角色与影响力

Nicolai: 你觉得我们对科技的理解是不是太狭隘了？科技如何真正成为下一阶段经济增长的推动力？

Satya: 这是个很好的问题。从GDP层面考虑，严格定义的科技投入可能只占4-5%。那么，剩下的95%发生了什么呢？我总是这样看待新的技术范式或平台转变的前景，比如人工智能。

如果人工智能会成为下一个重大的通用技术，那么真正的机会是，假设科技投入在接下来的5到10年内从5%增长到10%。那么剩下的90%会发生什么？我们能否有由人工智能驱动的医疗领域的突破？我们能否在材料科学上取得突破并因为人工智能实现能源转型？

所以，在我看来，我们最需要考虑的就是通用技术。这就像工业革命高峰期，英国在铁路建设上的投入占了GDP的10%。而铁路的真正价值不在于铁路本身，而在于它对整个英国经济的影响。我认为这就是我们应该思考的，这就是我考虑科技及其未来如何影响更广泛社会和经济的方式。

第三章 微软在AI领域的创新与合作

Nicolai: 现在，谷歌几乎拥有所有顶尖的人工智能专家，然而你们却突然赶超了，部分原因是你们与OpenAI的合作。这是怎么发生的呢？

Satya: 我的理解很简单，微软研究所在1995年成立时做的第一件事就是关于语音的研究，我们从卡内基梅隆大学招募了一批人才，所以我们一直在AI领域深耕。

当我与OpenAI的团队会面时，我发现他们有一种新的、不同的方法，我们希望与他们建立合作关系。在微软的这些年里，我一直在寻找具有雄心壮志的技术创新公司，像Intel和Windows、SAP和SQL Server这样的合作关系，它们共同合作并收获了成功。

所以，我一直在寻找我们可以一起创新的合作伙伴。这就是我在Sam和他的团队中找到的，那时，这只不过是一次尝试，并不是一件确定无疑的事情。现在每个人都在谈论这个，仿佛这就是科技领域的问题，对吗？你必须在这种观念成为主流之前就全力以赴，希望它能够成功。这就是我们在它成为主流观念之前就已经支持的事情之一。

现在我们就在这里。但我不认为会有太多的竞争。谷歌是一家非常有实力的公司，他们既有人才也有计算能力，他们是这个领域的全方位公司，对吗？他们拥有从数据到硅、模型到应用产品和分销的一切还有其他公司。所以，我们肯定会面临大量的竞争，如果微软和OpenAI的合作能够带来更多的竞争我认为那会是一件好事。谷歌本应是默认的赢家只要我们能够做好合作并实现有效的创新我们就有可能给他们带来竞争。

Nicolai: 所以，从现在起三到五年后你认为微软在整个AI生态系统中将处于什么位置？

Satya: 对我来说，我希望我们首先拥有最好的AI基础设施。这意味着对于Azure来说无论是进行训练还是推理我们都希望拥有卓越的基础设施。我们将与NVIDIA、AMD合作，我们会拥有自己的半导体技术和系统架构。我们将从Jensen、Lisa那里获取最佳的系统架构创新以及可能加入的其他人手中获取，并确保Azure可以满足OpenAI等合作伙伴的需求。

因此，我们首要的目标就是在构建基础设施方面做出最好的成果，这包括用于训练和推理的基础设施。接下来的一层，我们希望拥有完整的数据层。随着这些模型和模型能力的不断提升，我认为数据层将会得到全面的重新设计。我们已经讨论过关于检索增强生成的话题。你需要考虑所有这些问题，无论是嵌入，向量搜索，还是如何切分数据以使检索增强生成能够良好运作。所以这就是一个完整的层面，或者当上下文透镜扩大时，它还将是一个不同的数据层。数据与推理船队之间的吞吐量是多少？你又应该如何去考虑这个问题呢？因此，我们将在数据层上进行创新。

最上面的一层，我们将在我们的协同系统上进行创新。我们开发的第一个产品是GitHub的协同系统。实际上，我对这一代AI的全面信心开始增强当我看到从GPT3到3.5的进步，并在GitHub中进行了实施后，所以，我们现在不仅拥有GitHub Copilot，我们在Microsoft 365中还有针对所有知识工作的Copilot。我们有针对各种功能的Copilot，无论是服务、销售还是财务。

所以我们将在我们自己的应用层面进行创新。这就是我看待这个问题的基本方式。这是一种全栈方法。在每一层，我们会进行创新，我们会有合作伙伴，我们也会有其他人进行创新，甚至可能会有竞争。作为一个平台公司，我们必须能够接受许多第三方在各个层面与我们竞争，这是非常核心的一点。否则，你可能会试图采取一种统一的方式来做所有的事情。根据我们多年的经验，最好的做法是让每个层次都保持自身的竞争力。

第四章 量子计算与游戏产业的未来

Nicolai: 你一开始提到我们现在正处于这种范式转变的第二年。你如何看待这与你经历过的其他技术突破相比呢？

Satya: 我至少经历过四次。首先是PC、客户端服务器、个人电脑和服务器，那是我第一次，大约是我在92年加入时，我们正处于那个开始阶段。然后是网络互联网，再然后是移动云，所以AI是第四次。

我认为有趣的一点是每一次技术突破都是在前一次的基础上建立的。我认为如果没有PC的普及，网络是不可能出现的。事实上，我第一次看到Mosaic浏览器是在Windows系统上。然后出现了Netscape，然后是IE，等等。因此，我认为你可以看到每一次技术突破都孕育出了下一次的可能性。然后，这一次突破又超越了前一次。这，我认为，就是真正的意义。

现在，我们正在看到的是，云技术、移动设备和边缘计算的PC已经催生出了AI时代。接下来可能会发生什么，它会超越目前的范畴吗？我认为，未来的AI不仅会涵盖认知工作，AI也将加速科学的发展。我认为这是一个令人兴奋的领域。AI也将实现在现实世界中的实体化，可能在机器人技术方面会有一些新的突破，这也是一个令人兴奋的领域。所以，随着时间的推移，会有许多新的事情发生。但无疑，现在是新范式的第二年，它无疑加强了我们对之前发生的事情的理解，也为我们展示了即将到来的新事物的早期迹象。

Nicolai: 接下来，在你的书《Hit Refresh》中，你谈到了三个领域：AI、量子计算和混合现实。那么在量子计算中你看到了什么样的机会呢？

Satya: 这太引人入胜了。实际上，我认为这三个领域都是如此。例如，当我想到混合现实时，我将它看作是实体化的人工智能。无论是自动驾驶汽车、机器人还是戴着眼镜的人，他们都在感知现实世界，这实际上就是输入。因此你对现实世界的理解，所以我认为在人工智能的发展中，这些事物变得更加有趣和重要。我们确实需要展开视野，而不是狭隘地只考虑一种设备或一种形式。

同样，我提到科学时，量子计算真是一个令人着迷的领域，对吧？我看到的是，为了在科学上取得进步，你需要强大的计算机模拟能力。量子计算是最后的突破，对吧？所以，当我们有一个完全新的系统架构，摆脱了冯·诺依曼架构的限制，你终于将能够模拟像细胞的动态或分子的动态这样的东西，对吧？所以我认为当你能做到这一点时，那么其他所有事情，甚至在生物学方面都变得更具可能性。

有趣的是，人工智能就像是那个模拟器的仿真器。换句话说，你可以简化搜索范围。我们已经看到这一点，我们最近做的一件事是我们有一个材料科学的模型，我们用它来生成一个新的化合物，然后我们去生产它。我们与当地的太平洋国家实验室合作，有效地将新电池材料中的锂含量减少了70%，并生产出来。我们不仅是想象它，还模拟它，生产它。所以对我来说，当量子计算加上人工智能，我认为可以成为科学的极速推动器。我们正在取得进展。即使在量子计算方面，我们也采取了全面的方法。我们有我们的软件堆栈和我们的量子编程堆栈Q#，所以我们对在量子计算上所取得的进展以及它如何补充人工智能感到兴奋。

Nicolai: 那么游戏如何适应这种情况呢？

Satya: 对我来说，事实上，微软在进入Windows之前就已经进入了游戏。飞行模拟器我认为在Windows发布之前就已经推出了。所以我们非常期待，显然现在Activision已经成为了Microsoft的一部分。我们拥有手机游戏、云游戏、主机游戏、PC游戏。我们是全方位的游戏发行商，也是游戏系统的提供商。

我们的目标是，首先，我们是因为热爱游戏才投身游戏行业的。我总是说我们的业务必须是目标本身，而不能仅仅作为达成其他目标的手段。它必须是一个目标，否则就不是一项业务。对我而言，游戏是我们想要传达乐趣的一种方式。这是唯一纯粹的消费者娱乐领域。我很高兴看到游戏行业有可能成为，如果还不是的话，最大的娱乐类别。

当然，这对其他方面也有实质性的影响。如果你仔细思考一下，GPU的最大成功之一就是由游戏创新推动的。DX，也就是微软的图形栈，使得GPU成为了一种加速器。毕竟，GPU是为了PC游戏而重新设计的。

游戏，在我看来，不仅是AI的应用，比如游戏测试，我非常兴奋的第一个领域是，现在的游戏非常复杂。我们想要利用AI的一件事是，在这些封闭的世界中找到这些错误，甚至在它们出现之前。因此，我们在那里有一些非常好的用例。而且，我认为在我们的模型创新中，游戏作为数据将非常重要。

第五章 微软的文化变革与个人成长

Nicolai: 你在微软真的带来了文化的变革。回顾过去，你认为最关键的改变是什么？

Satya: 首先，就像我之前说的，我在微软成长。几乎我整个职业生涯都在微软度过。因此，我并不认为自己是微软过去所有问题的化身或代表。我是通过模式匹配来实现改变的，回想我们何时达到巅峰，是哪些文化特质让我们成功，然后当我们失败的时候，是什么文化特质导致了那次失败？我的方法就是减少后者的影响，增强前者的力量。就这么简单。

我回顾我在微软的职业生涯，当我们首次成为市值最大的公司时，我想是在2000年初，我想我们超过了GE。我们园区里的人们在四处走动，包括我，在想，哦，我们一定是天选之子因为我们太聪明了等等。但我们那时真正需要做的，是意识到我们现在肩负着重大的责任，需要重新定位自己，再次创新，确保我们在未来仍然具有相关性。

所以我很幸运读到了Carol Dweck的一本书，关于心态的，这是一本关于儿童心理学的书，叫做《成长心态》。我非常喜欢那本书。我读这本书，更多的是从我孩子的教育出发，但我必须承认我也受到了教育，因为我认识到这是使个人，尤其是学校里的孩子们，变得优秀的关键。更愿意学习，而不是自以为是，这更重要。因为即使那些自以为是的人有很高的天赋，但如果愿意去学习，即使他们起步较晚，也会超越那些自以为是的人。

这种思维方式对于在学校的孩子、像我这样的CEO以及公司来说都同样适用。因此，我们决定去学习，并且保持开放的心态，而不是自以为是。当你说你已经实现了这种文化转变的那一天，其实就意味着你自以为是了。因此，这是一种很好的方式，其实每天我们都会犯错误，重要的是我们要有勇气承认并继续前进。所以这并不是一个你能够达到的终点。

Nicolai: 那么如何让整个组织接受这个观念呢？你如何在一个组织中灌输这种心态呢？

Satya: 这确实是一个很好的问题。我认为，对于那些非创始人的公司来说，他们面临的问题是，创始人有着巨大的影响力和大量的追随者。这就是为什么他们能够取得成功，或者说至少我们只关注那些成功的创始人。但如果我们不考虑这个群体，对于像我这样的普通人来说，我们不能笃信于新的CEO带来的新教条或更多的企业言辞。它必须能够触动我们作为人的情感。

这也就是为什么我更倾向于把这个成就归功于Carol和她的团队。因为我认为微软的人并不把成长型心态视为微软的教条或者我自己的教条。对他们来说，成长型心态是一种能够与他们作为朋友、同事、合作伙伴、父母、邻舍互动的方式。它能够融入到他们的工作和生活中，他们能够将自己的个性和热情投入其中从而从中受益。

我一直强调，微软的成长型心态的文化并不是为了微软本身，而是为了你自己。只有当你觉得它对你在微软和生活中的发展有所帮助时，你才应该去实践它。我认为，这就是这种文化能够在微软内部蓬勃发展的原因。如果它只是一个自上而下的口号，那么它是无法真正发挥作用的。我一直相信，人们只有在他们可以从工作中找到一些真正的、深层次的意义时，他们才会觉得工作是有意义的。所以这就是，我想，我一直努力想要传达的信息。

第六章 同理心的重要性

Nicolai: 他们显然也深刻理解了同理心的意义，因为你谈了很多这个问题，你认为它对创新和领导力等至关重要。那么，为什么是这样呢？对你来说，为何同理心如此重要？

Satya: 我觉得，大多数人将同理心视为一种软技能，它在家庭或个人生活中很重要，而工作往往关乎硬实力，对吗？但是我对此有不同的看法，我再次思考，创新从何而来？创新源于我们能够找到解决方案来满足客户未明确表达出的需求，对吗？关键在于需求未被满足且未被明确表达。

这就意味着，你必须有更深的理解无论你在查看数据日志，还是在听取客户访谈的反馈。这不仅仅是他们说的话，更重要的是你要能够设身处地为他们考虑。好消息是，我们每个人都有能力去理解他人。实际上，设计思维就是如此，对吗？人们说，让我们去学习设计思维，而设计思维实际上就是应用同理心。

对我来说，我所关注的就是这一点，我们不能把同理心看作是一种仅用于朋友和家人的软技能。我认为，同理心是所有创新的源泉。这是关于能否满足未被满足的需求，来自你独特的、未被表达的需求，我是说，你天生的好奇心，去了解他人，站在他们的立场上，为他们创新。我认为我们都必须这样去做。这就是为什么我认为同理心是一项重要的，对我们每个人来说都是重要的技能。

Nicolai: 你是什么时候首次发现同理心的力量的？

Satya: 我是说，我读了你的书，非常精彩。你非常热情地谈论你的母亲，她非常有同理心。我认为其中一件事是我觉得我们所有人都学到了如何启动这一点同理心通过生活的经历，对吧？在某种程度上说，你每天都会遇到不一样的情况，不仅是你个人，还包括你周围的人。

对我来说，毫无疑问，我儿子的诞生是我和我的妻子生活中的重要事件。这是一件你知道的，多年来，我至少学到了很多，因为我记得在早期，我总是在思考我的儿子为何会出生就患有脑瘫。他几年前去世了，但是，当他出生时，我一直在思考这些事情为什么会发生在我身上。我曾经问过自己，这为什么会发生在我们家？为什么会发生在我身上？

后来，我看着在某种程度上，我的妻子，作为一个照顾者，作为一个母亲，你知道，带着他在西雅图的所有可能的治疗地方寻找帮助。坦白说，你知道，这个过程花了我很多年，不是你知道，几天、几个月或几周。然后我意识到，真正遭受苦难的不是我，而是我的儿子，我需要在那里支持我的儿子。这是我经常谈及的经历，但实际上，每一天都会有类似的经验发生，对吧？比如有些同事的父母需要照顾。那种，你知道，我从这些经历中学到了一些东西，或者说，我现在比我刚开始工作时更愿意从他人的经验中获取知识。

我认为，这种情况对我们所有人都一样，这就是生活的经验，如果我们能够积累足够的经验，就能够对他人有更深的理解和共情。这也会帮助你成为一个更好的经理、一个更好的同事、一个更好的创新者。

Nicolai: 谢谢你的分享。你觉得同理心和执行力之间存在矛盾吗？

Satya: 我不认为存在矛盾。对我来说，最重要的是你需要对自己的责任有所认识，这不仅在商业领域中是如此，在生活中也是一样，对吧？你必须对取得的实际进步负责。我经常思考的一个问题是为什么企业存在？企业存在，至少我喜欢科林·迈耶的这个定义，你需要找到能够盈利的解决方案来应对人类和地球所面临的挑战。因为这至少是一种分配全球资源的好方法，对吧？追求利润是一个好的动机因为这意味着你在竞争并以最有效的方式分配资源同时面对竞争。

因此，你必须具备优秀的执行力，你需要有强烈的责任心。因此，我认为同情心是创造出盈利、具有竞争力的优秀解决方案的必要条件，这些解决方案需要在市场上有所作为，而不是进行某种权衡。

第七章 个人特质与领导力

Nicolai: 当你审视自己的能力和性格时，你认为是什么使你成为一位出色的领导者？

Satya: 我首先要说的是，我并不认为这之中存在我可以明确指出的因果关系。说实话，对于这个问题，别人可能更容易给出意见，或者说，评价和判断因果关系更多是别人的事。但对我来说，我的出发点并不是问自己"我擅长什么？"相反，我更多是被"我不擅长什么？"这个问题所引导。

换句话说，我总是在寻求，我能从别人那里学习到什么？如果说我有什么特别的属性，那就是我不会每天醒来就想着我已经知道的或我擅长的东西。我会想，"我有哪些弱点？我需要和谁交流？我需要见谁？我怎样才能真正帮助周围的同事发挥他们比我更强的技能？"这就是我的思维方式。或许这对我作为领导者有所帮助，但是否这就是因果关系，我不得而知。我不是每天起床都告诉自己，哇，因为我在某方面很擅长，所以我就去做那个。恰恰相反，我的思考方式完全是反过来的。

Nicolai: 这是你从比尔·盖茨那里学到的吗？因为他也有过相同的看法，对吧？他其实也是个学习者，对吧？

Satya: 这个观点很有意思，我也不知道。我认为这是个好主张。对Bill和Steve来说，他们在微软中的影响，我认为这是个有趣的现象。我们公司明年就要50年了。这就像Andy Grove经常说的，"只有偏执狂才能生存"，或者其他类似的观点。但我的态度并非来自偏执，对吧？我是说，我并不喜欢偏执。这就是为什么我更倾向于我自己的话，也就是所谓的成长心态，面对自己的固有心态，拥有自信。

我们生活在一个如此神奇的世界里，每个客户都能教给我新知识，每个合作伙伴都能教给我新知识，每个同事都能教给我新知识。我还能期待什么更多的事情呢？所以这并不是偏执。不是每天都要过得如履薄冰，担心如果我不学习新的东西，我就会失败。我更在意的是我能从中学到什么，从而能创新。这就是我的看法。没错，Bill和Steve以他们自己独特的方式拥有了这种心态，我也在他们的影响下成长。

第八章 个人爱好与对年轻人的建议

Nicolai: 另一件让你与众不同的事是，你知道，常言道："大多数人不关注大部分诗歌，因为大部分诗歌也不适合大多数人"但这显然不适用于你。告诉我你对诗歌的热爱。

Satya: 我喜欢诗歌，你知道，以一种有趣的方式，我接触诗歌比较晚。我的妈妈是梵文戏剧的教授，她一直试图向我传递对诗歌的热爱。对她来说，梵文的文学和诗歌等都是如此。但我把它想象成一种压缩。这是最好的，当你想到代码时，就像我编写更多程序时，我有种感觉，哇，诗歌基本上就是自然语言的压缩。它能够以最简洁的形式描绘世界，我认为这就是一种世界模型。

因此，我在三十多岁时开始大量接触乌尔都语诗歌。我在海得拉巴长大，那里饱含着乌尔都语诗歌的气息。现在，我深爱它。但即使你知道的美国诗人、英国的浪漫主义者、德国人，他们都令人着迷。所以至少我不会说我很了解诗歌，但我至少对人类思维的能力，压缩思维，无论是在代码还是诗歌里，都深感神奇。

Nicolai: 哇，那太棒了。最后一个问题，Satya，我们有数以万计的年轻人在听这个。你对年轻人的最佳建议是什么？

Satya: 我会说最好的建议，对于每个刚起步的人，我自己接受的一个重要启示就是：不要等到下一份工作才开始尽力做到最好。这意味着，不论你手头的工作是什么。

例如，我在微软的工作中，我从未觉得需要晋升才能感受到更多的满足或成就感。我总觉得自己非常幸运，我拥有的这份工作就是我所能做的最好的工作。我并不是说你不该有野心，不应该为你的下一个晋升努力，不应该为自己争取或者让他人支持我们。这些都是必须做的。

但同时，我的建议还包括：全情投入到当前的工作中，用你全部的热情和能量去挑战，尽可能地扩大工作的范畴。我想，回顾过去，我从未将自己的工作局限于狭窄的范围内。而那个，我认为，这不仅让我在当下感到非常满足，也为我赢得了下一份工作的机会。这或许是我想要留给大家的一条建议。

Nicolai: 哦，我认为没有人能比你做得更好了。所以，非常感谢你能来参加这个节目。祝你一切顺利，你知道，一切都是最好的。

Satya: 谢谢你，Nicolai。衷心感谢你，能参与此次非常令人愉快。

来源：https://youtube.com/watch?v=yNuLPWu38IU&t=16s


### 49

2024-03-16


歸藏
@op7418
腾讯的视频生成模型Dynamicrafter昨天放出新的模型文件后，已经有大佬适配了Comfyui的插件。

可以图生视频生成576*1024分辨率的视频，开源的视频生成模型除了SVD又有了新的选择。

下面是我的测试结果，人像运动幅度过大，可能是参数问题，等作者写好readme了再看看。


### 50

2024-03-16

歸藏
@op7418
腾讯的视频生成模型Dynamicrafter昨天放出新的模型文件后，已经有大佬适配了Comfyui的插件。

可以图生视频生成576*1024分辨率的视频，开源的视频生成模型除了SVD又有了新的选择。

下面是我的测试结果，人像运动幅度过大，可能是参数问题，等作者写好readme了再看看。

1『试了下，目前感觉不好用。（2024-03-17）』

### 51

2024-03-16

歸藏
@op7418
斯坦福大学这个论文厉害啊，提出了一种STaR的泛化版本，名为Quiet-STaR，目的是让大语言模型学会以更通用和可扩展的方式进行推理。

Quiet-STaR让大语言模型能够在每个Token处生成理由，以此解释未来的文本内容。

它提出了一种按Token并行采样的算法，通过有效地生成内部思考，有助于改进大语言模型的预测性能。

论文解决了几个关键挑战：

1）生成连续文本的计算成本，

2）LLM最初不知道如何生成或利用内部思考

3）预测超出单个下一个Token的需要。

测试结果：

所生成的理由对于模型预测那些难以预测的Token特别有帮助，也提高了LLM直接回答难题的能力。

在对互联网文本语料库进行了Quiet-STaR预训练之后，发现LLM在GSM8K（从5.9%提高到10.9%）和常识问答（CommonsenseQA）（从36.3%提高到47.2%）任务上取得了零样本（zero-shot）改进，并且观察到自然文本中难Token的困惑度得到了提高。

论文地址：https://arxiv.org/html/2403.09629v1


### 52

2024-03-16

歸藏
@op7418
Magnific AI正在从一个图像放大工具变成一个图像生成和编辑工具，他们将会在周一发布图像风格转换器。

你可以利用提示词将自己上传的图片变成任何风格。

他们用一个拳头功能打开了局面不断增加新的功能，这种策略很值得学习。


### 53

2024-03-16

歸藏
@op7418
Maisa宣布了一项名为KPU（知识处理单元）的新技术，这是一个专有的框架，使用了这个框架之后的GPT-4各项能力都超过了原有的GPT-4很多。

KPU旨在通过将推理和数据处理解耦合的方式，利用大型语言模型（LLMs）的力量来解决复杂任务。

KPU的架构包括推理引擎、执行引擎和虚拟上下文窗口，这些组件共同工作，使得系统能够在保持推理质量的同时，有效管理数据输入输出，解决传统LLMs面临的问题，如信息的时效性、与外部服务的交互能力有限等。

KPU在多个推理基准测试中表现出色，超越了包括GPT-4、Mistral Large、Claude Opus和Google Gemini在内的现有先进语言模型。这些测试包括GSM8k（小学数学问题）、MATH Benchmark（竞赛数学问题）、DROP（需要离散推理的阅读理解测试）和BBH（Beyond the Imitation Game Benchmark中的高难度任务）。

KPU的表现不仅在基础数学推理上设立了新的标准，也在处理复杂阅读理解和高级推理挑战方面展现了其卓越能力。

更多信息：https://maisa.ai/blog/kpu


### 54

2024-03-16

阑夕
@foxshuo
腾讯科技的潜望栏目组这个月的AI访谈系列真是质量爆炸，而且行文都是最清晰的问答结构，信息呈现非常干净，采的杨植麟、朱啸虎、王小川刚好是中国AI行业3个不同站位、不同判断、不同目标的人选，甚至有种连续剧的节目效果，很推荐作为合订本收藏。

杨植麟是第一篇：月之暗面杨植麟复盘大模型创业这一年：向延绵而未知的雪山前进（https://mp.weixin.qq.com/s/kEKotLcnlFK0jf8gNajXIg）

他的身份是创业者，中国顶级优秀的那拨年轻人，包括我见到的几乎所有机构，都对他的才能和为人充满了溢美，Kimi在我看来也是极为少有的在部分场景能够提供比GPT-4和Claude 3更优解的工具。

杨植麟的观点，用四个字总结，就是「还来得及」，现在全球大模型还处在一个突变期，变数很大，关键是要跟着跑下去，要坚定不移的去拿资源，千万不要自我怀疑，事在人为。

在他看来，创造符合未来需求的AI组织会是一项巨大的登月工程，现在各家都还处于火箭原型的测试阶段，不要着急，第一步已经走出去了，中美之间的实际差距在缩小，短时间里的市场份额没那么重要，还是要瞄准第一性原理，AGI是核心，第一个拿到AGI门票的可以从那一刻起降维打击，实现赢家通吃。

杨植麟的理想主义——以及他确实拥有做这些判断的的技术才学——本来在很大程度上给国内略显低迷的AI行业起到了激励士气的作用，然后就有了第二篇对话朱啸虎的反差感出来：朱啸虎讲了一个中国现实主义AIGC故事（https://mp.weixin.qq.com/s/4111julSNH4XPXsUc8XEXA）

朱啸虎是投资人，媒体长期以来都很喜欢跟他聊，因为嘴上不怎么把关，什么心里话都能往外说，朱啸虎的这场采访，也可以用四个字来总结，那就是「拉鸡巴倒」。

排开情绪化的部分，朱啸虎的核心观点其实也不复杂：大模型研发没戏，干不过美国，等开源追上来，直接拿开源做应用层创新，去做能够直接创造经济效益的服务出来，底层技术搭便车就好，让美国在前面烧钱试错，跟在后面的成本和风险至少低一个数量级。

朱啸虎的身份决定了他看项目都是财务视角，比较隐晦的暗示了现在投大模型很难有退出通道，美元越来越少，人民币只能找大厂接盘，问题是大厂的FOMO心态一旦过去，就很难说了。

不过他举的例子也挺难崩的，比如说美国大模型是牛逼，现在中国也投不进去，但是中国的AI创新可以让王一博的数字人给粉丝打电话卖货，转化率翻好几倍，美国干不来这样的创新。

「繁花那个时代大家是真的可以搏一下，现在就别了，先活下去。」

再就是昨天，第三篇对王小川的采访也发出来了：王小川想提出中国AGI第三种可能性（https://mp.weixin.qq.com/s/_q1xA_EGEVonI32U1LgdSw）

王小川的表述，四个字可能不够总结，要用五个字，「李彦宏傻逼」。

好吧，事实上是，王小川认为李彦宏被自家团队给忽悠了——竟然真的相信文心一言比GPT-4要强——而这种盲人摸象的现象，其实也广泛存在于AI行业里，大家都在用局部的认知做出宏观的评价。

除此之外，王小川自认选择的技术和商业的中间路线，既不同于杨植麟把AGI当做唯一终点，也不像朱啸虎那样把AI当成一门生意，他相信垂直模型的爆发会来得更早。

美国有钱有算力，所以可以直线本着AGI而去，但在中国很容易变成说服资本的游戏，如果能用AI为中国增加100万医生，这将是天文级别的价值，所以要为场景去开发产品。

不过我自己看下来王小川这篇是最虚的，很符合他这个人养生玄学上的追求，基本可以算是AI行业的边缘经验，别人是在盲人摸象，他可能是在几万米开外找象⋯⋯

反正这个系列（还在更新）都还挺推荐阅读的，除了AI产业的信息密度管饱之外，采访对象的延伸输出也很有可看性，比如朱啸虎痛惜当年错过字节跳动B轮的表达就特别有画面感：

「看在师姐的面子上勉强跟他（张一鸣）聊了十几分钟，没觉得这人多牛，说话也不行，前面他又连着创业失败了三次，真看不出来他还能成，哎⋯⋯」


### 55

2024-03-16




### 01

2024-03-06




### 01

2024-03-06




### 01

2024-03-06




### 01

2024-03-06




### 01

2024-03-06




### 01

2024-03-06




### 01

2024-03-06






