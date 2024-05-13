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

2024-03-18


Sverige_ Dong-seok🇸🇪
@realrenmin
很有趣的工作，gpt-3.5-turbo的参数被估算为大约7B。这个数字如果真实，那么 1）“小”模型的潜力十分巨大，不止微软在做小模型，OpenAI也在做小模型，或许其他公司也在做！2）OpenAI的调优能力太强大 3）一切认为ChatGPT大于100B的paper，都需要被重新评估，一些20B，40B的模型跟7B的ChatGPT比较已不再公平。


### 56

2024-03-18

宝玉
@dotey
马斯克的大模型 Grok-1 开源了，这是一款拥有3140亿参数的先进混合专家模型，截止目前参数量最大的开源大语言模型。

这个版本包含了Grok-1在2023年10月完成预训练阶段时的基础模型数据。这意味着模型尚未经过针对特定应用（如对话系统）的微调。

根据Apache 2.0许可协议，向公众开放模型的权重和架构。

模型详细信息
- 该基础模型通过大量文本数据训练而成，未专门针对任何具体任务进行优化。
- 3140亿参数构成的混合专家模型，其中25%的参数能够针对特定的数据单元（Token）激活。
- xAI团队利用定制的训练技术栈，在JAX和Rust的基础上，从零开始构建了此模型，完成时间为2023年10月。

- 模型参数数量高达3140亿
- 混合专家模型(Mixture of Experts, MoE)
  - 每一个数据单元(Token)由2位专家处理
- 共64个处理层
- 用于处理查询的有48个注意力机制单元(attention heads)
- 用于处理键(key)/值(value)的有8个注意力机制单元
- 嵌入向量(embeddings)的维度为6,144
  - 采用旋转式嵌入表示(Rotary Position Embeddings, RoPE)
- 使用SentencePiece分词系统处理，包含131,072种数据单元
- 支持激活数据分布计算(activation sharding)和8位数字精度量化(8-bit quantization)
- 最大序列长度为8,192个数据单元，以处理更长的上下文信息

https://x.ai/blog/grok-os
https://github.com/xai-org/grok-1/tree/main


### 57

2024-03-18

歸藏(guizang.ai)
@op7418
Sam 在与韩国硅谷特派记者团的会面中罕见的透露了比较多关于 GPT-5 的信息。

下面是这篇韩文报道中的一些关键信息和全文：

◆OpenAI CEO Sam Altman警告不要低估GPT-5性能改进的幅度,可能会超出预期。

◆每当GPT的下一个模型推出,企业界和日常生活的多个领域都会发生变革甚至消失,需要更多新思维。

◆这是Altman首次如此自信地对外发出关于GPT-5性能的"信号"。

◆Altman和OpenAI的目标是建立"通用人工智能(AGI)",如果投入大量计算资源加速AGI到来,AI计算所需能源短缺等问题可以轻松解决。
◆Altman表示GPT-5将在高级推理功能上取得重大进步,只要有足够计算资源,就能建立超越人类的AGI。

◆他警告低估GPT-5的改进幅度并以此为基础开展业务将是一个重大错误,GPT-5的改进幅度远超想象。

◆Altman似乎除了"建立AGI"之外对其他事情不太感兴趣,完全专注于AI。

◆他最近致力于全球AI基础设施创新,认为计算将成为未来最重要的货币,非常关注如何以低成本构建大量计算资源。

◆他乐观认为,如果突破计算能力限制实现AGI,AI运行所需的能源短缺等将成为次要问题。通过AGI进行的科学研究将是可持续经济增长的决定性因素。

◆他担忧数据量跟不上AI开发速度,数据短缺可能阻碍AI进步,需要一个能用更少数据学习更多东西的模型。

采访全文：

OpenAI的首席执行官(CEO)萨姆·奥特曼(Sam Altman)警告称，不应低估GPT-5性能改进的幅度，这可能会超出预期。每当GPT的下一个模型被开发出来时，无论是企业界还是日常生活的多个领域都必然会发生变革甚至消失，因此他强调需要更多的新思维。这是奥特曼首次如此自信地对外发出关于GPT-5性能的“信号”。他明确表示，他和OpenAI的目标是建立“通用人工智能(AGI)”，并乐观地指出，如果大量计算资源被投入以加速AGI的到来，人工智能(AI)计算所需的能源短缺等现实问题可以轻松得到解决。

14日（当地时间），在与韩国硅谷特派记者团的会面中，奥特曼表示：“我不确定GPT-5何时发布，但它将作为一个在高级推理功能上更进一步的模型，取得重大进步。” 他补充说：“虽然有许多人质疑GPT模型是否有限制，但我可以自信地说‘没有’。” 这体现了他的信心，即只要有足够的计算资源，就能够建立超越人类的AGI。

奥特曼还指出，低估GPT-5的改进幅度并以此为基础开展业务将是一个重大错误。这表明正在开发中的GPT-5的改进幅度远超过想象。他说：“许多初创公司认为，GPT-5的进步只会是小幅度的，因此他们假设进展会缓慢，但我认为这是一个严重错误。” 他强调：“在技术剧变的情况下，像往常一样，他们将被下一代模型‘压倒(steamrolled)’。”

奥特曼似乎对“建立AGI”之外的事情不太感兴趣。据说他对区块链、生物技术等AI以外的其他技术也失去了兴趣。他表示：“过去，我对世界上发生的一切都有一个非常广泛的视角，并能看到我以前从狭窄的角度看不到的东西。” 但他也说：“遗憾的是，现在我完全专注于AI（AI all of the time at full tilt），很难有其他的视角。”

最近，奥特曼一直在致力于全球AI基础设施的创新。在这个过程中，甚至出现了关于“7万亿美元融资”的传言，成为了一个热点话题。奥特曼说：“除了考虑下一代AI模型外，我最近花费最多时间的领域是‘计算(compute)建设’，我越来越确信，计算将成为未来最重要的货币。” 他还说：“但是，世界并没有为足够的计算做好准备，也没有正视这个问题，因此我非常关注如何以尽可能低的成本构建大量的计算资源。” 这意味着他非常关注为实现AGI而获取计算资源的问题。

他还表达了一种乐观观点，认为如果能突破计算能力的限制并实现AGI，那么AI运行所需的能源短缺等将成为“次要问题”。奥特曼说：“我最期待AGI的是，它能加速科学发现，从而更快实现核聚变发电，快速找到解决能源问题的方法。” 他强调：“通过AGI进行的科学研究将是可持续经济增长的几乎唯一动力和决定性因素。”

他还提出了对数据量跟不上AI开发速度的担忧，数据短缺可能会阻碍AI的进步。他说：“从长远来看，人类产生的数据可能会变得不足。” 他补充道：“因此，我们需要一个能够用更少的数据学习更多东西的模型。”


### 58

2024-03-18

宝玉
@dotey
我一直觉得：大语言模型的推理能力才是根本，只有推理能力上去了上下文长度才有意义，否则幻觉会很厉害，价值没那么大。
引用
歸藏(guizang.ai)
@op7418
·
3月18日
月之暗面开放了 KimiChat 200 万字上下文的内测申请，感兴趣可以申请试试：https://kimi.moonshot.cn


### 59

2024-03-18

宝玉
@dotey
我家孩子沉迷搭乐高，陪他搭乐高的时候，我就联想起 AI 写程序！

他今年 4 岁，但已经不满足于搭4-5岁的乐高，而是要 9-10 岁的乐高，这条“祥龙纳福”就是他自己照着说明书拼的。

看起来很天才？其实不过就像现在的 AI 会写程序了一样！

因为让他独立去搭，是不可能搭出来的，虽然他照着说明书大多数时候能得到正确的结果，但也经常会拼错，而拼错了就无法继续了，就需要我帮他去修复错误，然后他才能继续，有时候甚至要拆到大部分重新开始。虽然我一直提醒他每个步骤完成了要去对照说明书检查，但对他来说还是太难，无法在出错后发现明显的错误。

这就像现在 AI 写程序，无论你怎么去从工程上优化流程，它只有一个像 4 岁孩子的智商，是无法独立去搭出来需要 9-10 岁年龄的乐高，而需要大人（专业人士）去引导，在出现问题后帮助修复、排除障碍。就算通过提示工程让 AI 在写完后自己检查，但以当前 AI 的能力很多错误还是无法检测和修复。

但是，这不能说明 AI 写程序这事不靠谱。就像孩子会长大，今年4岁，可能再过2-3年，长到6-7岁，平时练习一下，就能独立完成 9-10 岁的乐高玩具了。 AI 的进化速度也许比我们想象的更快。

另外这个乐高本来我要花 2 小时时间去搭的，现在只要偶尔抽点时间帮指点一下，加起来也就是半小时时间，还是帮我节约了很多时间。

要让 AI 能写好程序，就像让 4 岁孩子去搭 10 岁孩子的乐高，至少用 AI 的人得有搭 10 岁乐高的水平。


### 60

2024-03-19

歸藏(guizang.ai)
@op7418
SD3 模型还没发布就发了SD3-Turbo的论文，主要介绍了四Stability AI升级过的蒸馏技术LADD，以及用在 SD3-turbo 上的效果。

LADD有效克服了ADD的限制。与基于像素的ADD不同，LADD利用了预训练的潜在扩散模型中的生成特性。

这种策略不仅简化了训练流程，还显著提高了性能，使得我们能够生成高分辨率、多宽高比的图像。

将LADD应用于“稳定扩散3（8B版）”，从而开发出了SD3-Turbo这一快速模型。令人惊喜的是，SD3-Turbo仅需四步无指导采样，就能达到与当今最先进的文本到图像生成器相媲美的性能。

论文地址：https://arxiv.org/html/2403.12015v1


### 61

2024-03-19

宝玉
@dotey
NVIDIA 的 GR00T 项目是一个面向人形机器人学习的通用基础模型。GR00T 模型接收多模态指令和过去的交互作为输入，产生机器人需要执行的下一个动作。

为了训练 GR00T,NVIDIA 开发了 Isaac 实验室，一个在 Omniverse Isaac Sim 上进行机器人学习的应用程序。同时，他们还采用了 Osmo，一个新的计算编排服务，用于协调 DGX 系统进行训练和 OVX 系统进行模拟。通过这些工具，GR00T 可以在物理真实的模拟环境中进行训练，并将训练成果无缝迁移到现实世界。

GR00T 模型使机器人能够通过观察少量的人类动作示范来学习，从而在日常任务中提供帮助，甚至可以通过观察我们来模仿人类的动作。这得益于 NVIDIA 的技术，它可以从视频中解析人类的行为，在模拟环境中训练模型，并最终将这些模型直接部署到真实的机器人中。

将 GR00T 连接到大语言模型，甚至可以让它根据自然语言指令生成动作。例如，当给出指令"嗨，JL1。你能和我举手击掌吗？"时，机器人会回应"当然可以，让我们举手击掌。"当要求展示一些酷炫的动作时，机器人也能够做出相应的表现。

所有这些令人难以置信的智能都由新的 Jetson Thor Robotics 芯片驱动，这是一款专为 GR00T 设计的面向未来的芯片。借助 Isaac 实验室、Osmo 和 GR00T,NVIDIA 提供了用于下一代 AI 驱动机器人的基础设施。

这个项目展现了 NVIDIA 的核心精神：计算机图形学、物理学和人工智能的交融。这个项目的名字是通用机器人 003，展示了令人印象深刻的成果。


### 62

2024-03-19


Wang Shuyi
@wshuyi
我在 Perplexity 里面对自己的已发布文章合并文档进行主题分析，使用的是 Claude 3 Opus，效果还是很不错的。有意思的是，Perplexity 在总结时自动根据文章内容，找寻了相关的网上链接。https://perplexity.ai/pro?referral_code=YZYYF59D




### 63

2024-03-19

宝玉
@dotey
分享一点利用 Claude 3 Opus 整理字幕文稿的经验，它可以非常好的将文稿整理成对话形式，并且还可以按照话题分成章节！几个要点：
1. 说明对话的人物（基本上Claude能自动分辨出哪些话是谁说的，很准）
2. 要求根据话题分成章节（这个对于阅读、总结都很重要）
3. 要求不要遗漏内容（不说明可能就给你总结了）

参考 Prompt：

“以下是我整理的 XXX 对 YYY 的采访文稿，请整理成更适合阅读的对话形式，根据话题形成章节，包含人名，尊照原意的情况下适当润色，从头开始，不要遗漏任何内容！”

如果没有输出完整需要不停的输入 continue 直到结束。

如果要总结，最好等到完整文稿输出完成，然后让它基于章节来总结，这样总结出来效果最好，不容易遗漏要点。

参考 Prompt：
“请按照上面的章节总结上面的文稿，需要详尽不要遗漏重点！”


“以下是我整理的 Dwarkesh Patel 对 Mark Zuckerberg 的采访文稿，请整理成更适合阅读的对话形式，根据话题形成章节，包含人名，尊照原意的情况下适当润色，从头开始，不要遗漏任何内容！”

如果没有输出完整需要不停的输入 continue 直到结束。

如果要总结，最好等到完整文稿输出完成，然后让它基于章节来总结，这样总结出来效果最好，不容易遗漏要点。

参考 Prompt：
“请按照上面的章节总结上面的文稿，需要详尽不要遗漏重点！”


### 64

2024-03-19

Barret李靖
@Barret_China
在个人管理和团队协同中，我理解的周报和月报的作用：

- 周报：从简、可不写；是对过程中问题和风险的把控
- 月报：有数据、有里程碑、有感想；是对阶段性结果的把控

过去工作十年，个人也一直保持着写周报和月报的习惯，周报五分钟解决，月报半小时，大部分情况是给自己看，偶尔翻起，也能看到自己在事中的变化和成长。

但觉得最有价值的，还是年报。每年都会维护一篇文档，上面记录了一年内所有的动态目标和达成情况，也包括每个月结束时的感想和思考。

茫然时会翻开这篇文档，很容易找到下一脚要踏在什么地方，例如下半年要开启一项挑战，但技能树尚未点满；再例如这个月有带家人出行的计划，去踏春放风筝，行程需要规划起来了。

还有一份文档，它记录了每隔五年的个人规划和成长方向。一年太短，十年太长，我习惯把五年作为一个规划周期，它时刻提醒自己要去到哪里，要成为怎样的人。这篇文档看的就比较少了，一年最多两三回，每次去看，都会多一份焦虑，焦虑这一个五年走的太慢，焦虑下一个五年走向何方。

### 65

2024-03-19

宝玉
@dotey
Lex 采访 Sam 视频精校双语字幕（1）

第一章 OpenAI董事会事件始末
Sam讲述了从11月16日开始发生的OpenAI董事会事件给他带来的巨大压力和痛苦。整个事件持续了一个周末,过程跌宕起伏,让Sam感到非常疲惫。但他也感受到了来自他人的大量爱和支持。这次经历虽然痛苦,但让OpenAI为未来的挑战建立了一定韧性。

第二章 董事会的决策过程
Sam认为当时董事会成员都是善良的,只是在压力下难免会做出不那么完美的决策。OpenAI需要一个在压力下也能良好运作的董事会。他认为董事会应该有较大权力,但作为非营利组织,更应该对社会负责。当时的董事会变小后运作出现了问题。新董事会增补了一些经验丰富的成员。

第三章 新董事会成员的争议
Brett和Larry被提名进入新董事会引发一些争议。Sam解释董事会改组的过程比较仓促,但他们尽量选择了能获得多方认可的人选。对未来董事会成员的选择会更加严格,要考虑候选人在多个领域的专业知识,技术理解只是其中一项。

第四章 Sam Altman眼中的Ilya Sutskever
Sam谈到了对Ilya Sutskever的欣赏。他认为董事会除了需要技术专家,也需要能从更宏观角度思考如何造福人类的人才。他以Ilya为例,表示Ilya一直在深入思考如何以负责任的方式开发AGI。

第五章 Mira Murati的表现和Ilya Sutskever的处境
Sam高度赞扬了Mira Murati在动荡时期的出色表现。他更看重一个领导者在日常工作中持续做出高质量决策的能力。对于外界对Ilya近期去向的猜测,Sam没有透露更多信息,但表达了对Ilya的喜爱和尊重,希望未来能继续与他合作。

第六章 Sam对OpenAI未来的展望
对于OpenAI的未来,Sam对新董事会充满信心。这次经历让他意识到随着影响力扩大,OpenAI需要更加健全的治理结构、流程和人力。虽然这次事件让他对无条件信任他人更加谨慎,但他希望自己不会变得愤世嫉俗。他认为让那些有创新能力又能做出明智决策的人才团结在一起非常重要。

第七章 埃隆·马斯克的角色
谈到埃隆·马斯克起诉OpenAI一事,Sam表示马斯克可能有一些误解。OpenAI最初只是想成为一个研究实验室,但随着他们对AGI发展路径的理解加深,组织形式也在不断演变,旨在适应新形势。至于"Open"一词的内涵,他认为主要是让强大的AI工具免费或低成本地惠及大众,这对实现OpenAI的mission至关重要。Sam对马斯克提出的收购OpenAI并改名的提议感到震惊。他仍然尊重马斯克作为这个时代伟大创新者的地位,但对他攻击OpenAI感到失望和难过。他更倾向于与竞争对手开展良性竞争,而非诉讼。

这部分完整文稿：https://baoyu.io/translations/openai/lex-interview-sam-2

### 66

2024-03-19


宝玉
@dotey
Nvidia 创始人黄仁勋告诉斯坦福学生：过高的期望或让成功更遥远，“愿你们经历足够的挫折和磨难”

常言道，高瞻远瞩是成功的秘诀。毕竟，即使未能触及月亮，至少我们仍可与星辰为伴。然而，Nvidia CEO 黄仁勋却认为，对于拥有特权的 Z 世代毕业生而言，降低期待可能更为关键。

“期望过高的人往往缺乏韧性——而遗憾的是，韧性对于成功至关重要，”老黄在与斯坦福商学院最近的一次采访中提到。“我之所以有优势，就在于我对自己的期望从未过高。”

事实上，正如这位亿万富翁所指出的那样，斯坦福等顶尖学府的学生对自己的未来预期往往超过了普通人。

斯坦福大学在美国是最难进的大学之一——按照 QS 世界大学排名，它位列全美第三，入读学生每年需支付 62,484 美元的高额学费，远高于平均每年 26,027 美元的教育成本。

然而，遗憾的是，即便世界顶级大学也难以教授如何成为一个具有韧性的人。

“除了希望你们经历苦难，我不知道还能如何教给你们韧性，”老黄补充道。

老黄：从逆境中走向成功

老黄给美国新一代精英的建议源于他个人的经历：他现在的生活与充满逆境的童年截然不同。

这位技术巨头——以 800 亿美元的净资产成为世界上最富有的人之一——1963 年出生于台湾，早年大部分时间在泰国度过，9 岁那年随家迁往美国。

这次幸运的转变来自于他父亲——一位空调制造商的员工——在美国接受培训后立志追求美国梦的故事。

“我很幸运地在父母的支持下成长，他们为我们的成功创造了条件，”他说。“但是，我们也遇到了不少挑战和磨难。”

其中一个挑战是老黄的高中生活：他需要经过一座缺失木板的危险步行桥去肯塔基州的公立学校，那里他遭受了无情的欺凌。

“那时候人们怎么称呼中国人呢？‘Ch-nks’，”老黄之前在接受 New Yorker 采访时说过，他还提到有欺凌者试图将他从桥上扔下去。

在斯坦福的采访中，他还提到了他在 Denny’s 的第一份工作，他曾是那里的“最佳洗碗工”后升职为跑堂，并将其做到了极致。

“我总是双手不空而来，双手不空而归。我做事非常高效，”老黄说。“无论如何，我最终成为了 CEO。我还在致力于成为一个优秀的 CEO。”

巧合的是，正是在 Denny’s，他与朋友 Chris Malachowsky 和 Curtis Priem 共同孕育了创建一家专注于图形渲染计算机芯片的公司的想法。他们后来共同创立了 Nvidia，开创了一段传奇。

老黄的寄语：“愿你们经历足够的挫折和磨难”
对于那些从未经历过成长中苦难的幸运儿，老黄并没有如何引入生活中更多挑战的具体建议。但他确实分享了如何面对艰难时刻的看法。

“我不知道该怎么做，但我希望斯坦福的学生们能经历足够的挫折和磨难，”老黄说。“伟大源自人格，而人格的形成并非来自聪明，而是源自经历过苦难的人。”

这也是为什么尽管 Nvidia 取得了巨大成功——公司市值达到 2 万亿美元——老黄仍然欢迎在其组织中遇到挑战。

“至今我仍然喜欢在公司内部提到‘痛苦和苦难’这个词，”他说。“这是出于一种乐观的态度，因为你希望通过这种方式磨练公司的品格。”

如果你希望你的团队始终保持最佳状态，就不应让他们满足于现状。

原文：https://fortune.com/2024/03/13/nvidia-founder-ceo-jensen_huang-stanford-students-genz-grads-low-expectations-successful/

### 67

2024-03-19

歸藏(guizang.ai)
@op7418
Lex Fridman采访了Sam Altman，这次采访有快两个小时，基本上谈到了所有需要谈的内容。

包括GPT-5、Sora、董事会闹剧、马斯克、Ilya去向以及最重要的AGI。

强烈建议看一下，我也拿GPT-4翻译了一下视频，并且总结了文本，下面还有对应时间轴快捷跳转，时间有点长，可以收藏之后看。

采访的要点总结：

计算力将成为未来最宝贵的财富之一,人工智能的发展将是一场巨大的权力斗争。

Sam回顾了在OpenAI董事会经历的困难时刻,称其为职业生涯中最痛苦、混乱和令人沮丧的经历,但这些经历有助于增强韧性。

OpenAI正在寻找新的董事会成员,希望引入具有不同专业背景的人才,包括非营利组织、学习型公司、法律和治理等领域的专家。

董事会需要回应全球的需求,而不仅仅是自身利益。

人们对产品发布策略的反思,认为应该更加迭代地发布,避免突然的更新,以满足用户的需求。

GPT-4是一个重要的里程碑,但并不足以改变世界。真正意义上的AGI应该能够显著提高科学发现的速度。

大部分真正的经济增长来自科学技术的进步。

Sam期望首个AGI系统能够回答关于宇宙统一理论和外星文明存在性等重大科学问题。

没有任何一个个体或机构应该对AGI拥有绝对控制权,需要建立一个强大的治理系统来管理AI的发展。

目前AI安全研究者过于关注某些具体的技术风险,而忽视了其他一些重要的问题。

未来编程可能会以自然语言交互的方式进行,传统的编码方式可能会逐渐减少。

OpenAI在机器人领域有一些进展和规划。

虚拟现实技术以其超逼真和照片般的真实感著称,在虚拟世界中很容易迷失自己。

作者对大自然机械化运作的进化机制赞叹不已,尤其是在亚马逊丛林中的观察。

科技发展非常强大且吓人,但作者对宇宙中存在智慧外星文明非常有信心。

人工智能可能更像是人类之间的支撑和社会联系,而不是单个大脑。

人类共同建立的知识基础赋予了我们无比的能力,这种集体创造让作者对未来抱有希望。

尽管有时会提到人工智能的风险,但对于死亡,我们更多的是感激生命中的美好时刻。

在对人工智能未来的展望中,Sam表达了对人类未来的乐观态度,认为人类社会一直在持续进步。

Sam引用了科幻作家Arthur C. Clark的一句话:"在这个星球上,我们的角色可能不是崇拜上帝,而是创造上帝。"

采访的时间轴：

0:00 - 介绍 
1:05 - OpenAI董事会传奇 
18:31 - Ilya Sutskever 
24:40 - Elon Musk诉讼案 
34:32 - Sora 44:23 - GPT-4 
55:32 - 记忆与隐私 
1:02:36 - Q* 
1:06:12 - GPT-5 
1:09:27 - 7万亿美元的算力
1:17:35 - 谷歌和双子座 
1:28:40 - 跨越到GPT-5 
1:32:24 - 通用人工智能(AGI) 
1:50:57 - 外星人

https://x.com/op7418/status/1769779405671317797

[Sam Altman: OpenAI, GPT-5, Sora, Board Saga, Elon Musk, Ilya, Power & AGI | Lex Fridman Podcast #419 - YouTube](https://www.youtube.com/watch?v=jvqFAi7vkBc&t=3s)

### 68

2024-03-19


歸藏(guizang.ai)
@op7418
SDXL 底模的动漫模型又一力作ANIMAGINE XL 3.1发布，从演示图片来看效果相当不错。

居然是海艺赞助的算力，其实有很多好的模型训练者，不过随着 SD 模型不断变大，微调的成本也逐渐提高，这种合作方式也挺好的。

这里下载模型：https://huggingface.co/cagliostrolab/animagine-xl-3.1


### 69

2024-03-20

宝玉
@dotey
李飞飞对话英伟达首席科学家：AI就像电力，给它设置单独监管机构没意义

如果说去年的GTC炉边谈话，黄仁勋与OpenAI首席科学家Illya进行的是一场对技术未来的漫谈，那今年这场炉边谈话就是李飞飞对人类未来的呼吁。

在这次对谈中，李飞飞讲了个故事。当她完成自己书的初版时，她的好朋友，哲学家、斯坦福以人为本AI研究院联合主任约翰·埃奇门迪看了初稿后建议她去重写。他说很多人都在写关于AI的书，但李飞飞有一段独特的历程。能代表了很多觉得自己在AI领域没有发言权或找不到认同感的人。这些人包括移民、年轻女性、各行各业的人，他们不一定是典型的硅谷AI人士。如果李飞飞能给他们一个声音，这将更有力量。

完整内容：https://mp.weixin.qq.com/s/uvvjP4XPLRCk6XQXtl25Jg

### 70

2024-03-21

Jerry Liu
@jerryjliu0
Advanced RAG with Gemma, 
@weaviate_io
, and 
@llama_index
 

This is a great tutorial by 
@helloiamleonie
 showing you how to build an advanced RAG pipeline over semi-structured CSV files with structured annotations and text.
1️⃣ Preprocess into a set of nodes with metadata that you can put into 
@weaviate_io
 
2️⃣ Perform auto-retrieval over this (Gemma isn't quite good enough at function calling so we use OpenAI, but would be interesting to see a fully open-source stack) 

Check it out: https://kaggle.com/code/iamleonie/advanced-rag-with-gemma-weaviate-and-llamaindex




### 71

2024-03-21

宝玉
@dotey
如果你看过我以前写的多步翻译 Prompt https://baoyu.io/blog/prompt-engineering/translator-gpt-prompt-v2 ，还是这个总结的 Prompt，你就会发现：“所谓提示词工程，核心不是你套个什么模板用什么格式，而是逻辑！！”

逻辑就是你怎么将一个复杂的任务拆成科学合理的步骤，并且让前面每一步的结果都成为后面步骤的基础，所有步骤合并在一起得到最终的结果，而不要指望一步得到结果。只有这样你才能得到最佳的效果。

就像翻译，无论你的 Prompt 格式写的多完美，如果只有一步，那么效果上接近 DeepL 那样就是天花板了，但如何你拆分成直译、反思、意译，那么效果就接近人写的效果了！

就像总结，如果你只是让它总结，那么它可能就会偷懒遗漏很多要点，但如果你让它先提炼主题、再检查有没有遗漏的主题、然后基于每个主题列要点，最后再基于上面的去生成总结，就会好很多，也不会“偷懒”。

哪怕只是写一句“让我们一步步思考”，让它自己去分步骤，列出每一步的结果，都会好很多！

下次写 Prompt，效果不理想时，不妨想想看：我是不是可以把这个任务拆分成几个步骤？怎么拆分最合理？

### 72

2024-03-21


歸藏(guizang.ai)
@op7418
刚刚Codesignal推出了一个非常通俗易懂并且给出了丰富实践经验的免费提示工程教程。

如果你之前看过一些提示工程的教程但是都很复杂看不懂的话。

强烈建议你看一下这个，可以很好的帮助你学习提示词书写。

我也完整翻译了第一部分的教程，但是还是建议你去做一下课后习题加深记忆。

下面是第一部分重要的内容，完整的翻译放在了后面链接里：

教程的质量非常高，总共分为五部分，分别是：

了解 LLM 和基本提示技巧、

调整大型语言模型的输出大小、

在Prompt Engineering中探索格式控制之旅、

精确文本修改的提示工程、高级技术在提示工程中的应用。

第一部分最重要的内容，就是他们提出了一个简单易上手的Markdown提示框架：

把你的提示分成Markdown章节，如：

SECTION 这不仅有助于LLMs更好地理解你的提示，而且使你的提示非常易于快速浏览（尤其是在Markdown中渲染时，因为这些会以粗体显示），方便你的同事AI工程师在提示内容较多时快速找到并阅读相关部分。

在提示的顶部开始你的__ASK__部分 这样你和你的合作者可以从一开始就迅速理解提示的目标。

将每个部分格式化为Markdown项目符号列表，以便于阅读和理解。 项目符号列表更容易浏览，而且倾向于引导大语言模型更好地遵循指示。

在尽量减少分节的同时，对于复杂的提示，包括以下关键章节：

ASK - 我们请求大语言模型做什么？
CONTEXT - 大语言模型需要了解什么信息，才能准确地回应？
CONSTRAINTS - 回应时需要遵循哪些限制？
EXAMPLE - 你满意的输出样例是什么？

https://x.com/op7418/status/1770494047632671037

### 73

2024-03-21

宝玉
@dotey
很多人都说 GPT-4 总结的时候会偷懒，Claude 更好，但如果你提示词得当，GPT-4 的效果其实一样可以做到很好，甚至比 Claude 效果还好。

比如以 Lex 采访 Sam 的视频文稿的后面 45 分钟，分别让 GPT-4 和 Claude 3 总结，GPT-4 的要点总结的更好，生成结果更完整。

关键在于要把摘要这个任务分成几个步骤：
1. 列出话题
2. 基于每个话题列出bullet points格式的要点
3. 基于上面的结构去展开生成

这是我用的 Prompt：

***
请用中文详尽总结以下对话内容，按照以下步骤，每一步分别打印结果：

1. 尽可能列出他们讨论的所有话题，不要遗漏
2. 检查第一步列出的话题，补充缺失的重要话题
3. 基于每个话题用bullet points列出要点
4. 严格的以话题为章节，不要遗漏，基于每个话题和下面的要点，用1-3个自然段落总结每个话题的内容，总结每个话题时不要用bullet points，整体效果像是一篇科普文章
以下是要总结的内容：

<你要总结的内容>
***

### 74

2024-03-21

Leonie
@helloiamleonie
What do you do when you want to use an LLM in 
@llama_index
 that you have just fine-tuned yourself?
- You write a custom class!

In my latest 
@Kaggle
 Notebook, I show you how to use Google's open source LLM Gemma with LlamaIndex.

📌 Link to Notebook: https://kaggle.com/code/iamleonie/advanced-rag-with-gemma-weaviate-and-llamaindex

### 75

2024-03-21

九原客
@9hills
最近想找一个开源的、数据和测试驱动的Prompt 调试工具。

尝试了基本上能够体验的所有项目，感觉还是 
https://github.com/ianarawjo/ChainForge

最合适，虽然上手难度略微高了一些。

### 76

2024-03-21


歸藏(guizang.ai)
@op7418
昨天答应的 ComfyUI 人像发色更换保姆级教程视频来了。

我会先大概讲一下原理，然后再讲对应节点的作用和参数。最后会发散一下其他的方式，比如更换美瞳以及换衣服。

工作流原理：

主要用到了 SD 中局部重绘的原理，关键在于如何选中我们需要选中的区域，这里的突破主要是 Yolo World 这图像分割项目以及 ZHO 的 Comfyui 节点。

这个项目可以精准的识别和分割人物的不同区域的位置，我们根据不同区域的组合就可以选到需要的区域去重绘。

节点作用及参数：

YoloWorld Model Loader 和 ESAM Model Loader：加载模型用的用默认设置就行。

YoloWorld ESAM：输入框输入需要分割区域的单词，Confidence_threshold 需要分割的区域越精细数值越小，反之越大。

遮罩相减：取两个链接遮罩的交集。

遮罩扩展：扩大遮罩选取范围，倒角是让选区更加平滑。

采样器：降噪幅度，修改的内容与原图越不同重绘幅度需要越大。

### 77

2024-03-21

Vasilije
@tricalt
What if you could accurately retrieve your memories, conversational history, meetings, and audio messages in a structured way and give them to your LLM app?

A hard problem to solve!

That's why we built cognee as a Python library.
It's 
@neo4j
  + 
@weaviate_io
  + 
@LangChainAI
   and more...

Github repo  -> https://github.com/topoteretes/cognee


### 78

2024-03-22

Connor Shorten
@CShorten30
Voyage AI (
@Voyage_AI_
) is the newest giant in the embedding, reranking, and search model game! 🔥

I am SUPER excited to publish our latest Weaviate podcast with Tengyu Ma (
@tengyuma
), Co-Founder of Voyage AI and Assistant Professor at Stanford University! 🎙️

We began the interview with a deep dive into everything embedding model training and contrastive learning theory. Tengyu delivered a masterclass in all things from scaling laws to multi-vector representations, touching on ColBERT and Matryoshka embeddings, neural architectures, representation collapse, data augmentation, semantic similarity, and more! I am beyond impressed with Tengyu's extensive knowledge and explanations of all these topics. 🧠

The next chapter dives into a case study Voyage AI did fine-tuning an embedding model for the LangChain documentation. This is an absolutely fascinating example of the role of continual fine-tuning with very new concepts (for example, very few people were talking about chaining together LLM calls 2 years ago), as well as the data efficiency advances in fine-tuning. ⚙️

We concluded by discussing ML systems challenges in serving an embeddings API. Particularly the challenge of detecting if a request is for batch or query inference and the optimizations that go into either say ~100ms latency for a query embedding or maximizing throughput for batch embeddings. 🚀

YouTube: https://youtube.com/watch?v=xPdyivfheqI

Spotify: https://spotifyanchor-web.app.link/e/75RonYuE7Hb


### 79

2024-03-22

宝玉
@dotey
在今年的GTC大会上，英伟达的黄仁勋以一种充满仪式感的方式邀请了Transformer的七位作者（Niki Parmar因故临时未能出席）参与圆桌论坛的讨论，这是七位作者首次在公开场合集体亮相。

他们在对话中也表达了一些令人印象深刻的观点：

● 这个世界需要比Transformer更好的东西，我想我们在座的所有人都希望它能被某种东西所取代，将我们带到一个新的性能高原。

● 我们在最初的目标上并没有成功，我们开始Transformer的初衷是想要模拟Token的演化过程。它不仅仅是线性的生成过程，而是文本或代码的逐步演化。

● 像2+2这样的简单问题，它可能会使用大模型的万亿参数资源。我认为自适应计算是接下来必须出现的事情之一，我们知道在特定问题上应该花费多少计算资源。

● 我认为当前的模型太过经济实惠，规模也还太小，大概1美元百万toke的价格，比外出购买一本平装书要便宜100倍。

完整内容：https://mp.weixin.qq.com/s/Vxmlgh_ldJNa5RNwFSHmUA

另外感谢 
@123wimi
 帮助下载的视频

[中文实录全网首发！黄仁勋集齐Transformer论文七大作者，对话一小时，干货满满](https://mp.weixin.qq.com/s/Vxmlgh_ldJNa5RNwFSHmUA)

### 80

2024-03-22

宝玉
@dotey
GTC 2024：黄仁勋与七位 Transformer 论文作者圆桌会谈中英文字幕

在今年的GTC大会上，英伟达的黄仁勋以一种充满仪式感的方式邀请了Transformer的七位作者（Niki Parmar因故临时未能出席）参与圆桌论坛的讨论，这是七位作者首次在公开场合集体亮相。  他们在对话中也表达了一些令人印象深刻的观点：

1. 计算成本的降低和加速计算的兴起

在个人电脑革命的 20 年里，计算成本降低了 10000 倍，这是一个史无前例的成就。然而，计算成本的急剧下降在某个时刻停止了。为了继续推动计算能力的发展，加速计算应运而生。加速计算虽然具有挑战性，但通过加速那占据 99% 运行时间的 1% 代码，许多看似不可能的事情将变为可能。

2. 人工智能技术的突破和生成式 AI 的潜力

AlexNet 的出现标志着人工智能与 GPU 加速计算的首次结合，引发了人们对 AI 领域的广泛关注。随后，生成式 AI 的出现让人们看到了 AI 技术的巨大潜力。生成式 AI 不仅可以识别图像，还可以根据文本描述生成相应的图像，这种对数据的理解和生成能力，预示着一场新的工业革命的开始。这场革命将诞生前所未有的产品和服务，并对各行各业产生深远的影响。

3. Transformer 的诞生与自然语言处理的变革

Transformer 的发明者们分享了他们的研究动机和创新历程。最初，他们希望建立一个能够处理海量自然语言数据的高效模型。Transformer 独特的自注意力机制和并行处理能力，使其能够在各种自然语言任务上取得突破性的进展。同时，Transformer 的通用性也让研究者们意识到，它不仅适用于语言，还可以扩展到图像、音频等多个领域，这为人工智能的发展开辟了新的道路。

4. AI 创业公司的使命和愿景

随着人工智能技术的不断进步，许多 Transformer 的发明者选择离开大公司，创立了自己的 AI 公司。他们的目标是将这项变革性的技术带给更多人，让 AI 惠及各行各业。有的公司致力于创建通用的 AI 平台，有的专注于特定领域，如生物医学或金融。但他们的共同愿景是，通过人工智能来解决现实世界的问题，改善人类的生活。这些 AI 创业公司的努力，将加速人工智能技术的发展和应用。

5. 人工智能未来的发展方向

对话中，专家们对人工智能未来的发展方向进行了展望。他们认为，未来的重点将是提高模型的推理能力和常识理解。同时，高质量的数据和人机交互也至关重要。研究者们期望通过构建更高效、更通用的模型，让 AI 能够从更少的数据中学习，并具备类似人类的思考和问题解决能力。此外，将 AI 与其他领域如生物学、金融等结合，将释放出更大的潜力。

https://x.com/dotey/status/1770894646337560840

### 81

2024-03-22

宝玉
@dotey
吴恩达老师建议大家关注 AI 智能体工作流，可以大幅提升 AI 应用的性能，并且他们总结了一套智能体设计模式：

- 反思：让大语言模型对自己的结果检查改进
- 使用工具：让大语言模型调用外部工具，如网络搜索、代码执行等
- 规划：让大语言模型自己设计一个多步骤的计划来达成目标
- 多智能体合作：多个 AI 智能体协同工作，分配任务，讨论和辩论想法，写作得到更好的结果

以下内容为推文转译：

今年 AI 智能体 (AI Agent) 的工作流程将会促进 AI 领域的巨大进步，这种影响可能会超越下一代的基础模型。这是一个重要的趋势，强烈建议所有 AI 领域的工作者关注这一点。

目前，我们通常在零样本 (Zero-shot) 模式下使用大语言模型 (LLM)，即让模型一步步地生成输出，而不进行任何修改。这好比要求一个人一气呵成地写完一篇文章，不允许回退修改，却期望文章能达到高质量。尽管这样做存在挑战，但大语言模型在此任务上的表现出乎意料地好！

通过采用智能体工作流，我们可以引导大语言模型对文档进行多轮迭代处理，仿佛它在多次精细打磨它的作品。具体操作可以包括：

- 制定文档大纲。
- 决定是否需要网络搜索以获取更多资料。
- 撰写初稿。
- 仔细审阅初稿，标记不合逻辑的论点或不必要的信息。
- 根据标记的问题对稿件进行修订。
- 以此类推。

这种迭代过程是大多数人类作者撰写优质文本不可或缺的步骤。对 AI 来说，采用这种迭代工作流显著优于单次过程的写作方式，能够产出更优质的成果。

最近，Devin 的一个引人注目的演示在社交媒体上引发了广泛讨论。我的团队一直在跟踪研究编写代码的 AI 的发展。我们分析了多个研究小组的成果，特别关注这些算法在广泛使用的 HumanEval 编程基准测试中的表现。以下图表展示了我们的一些发现。

在零样本 (Zero-shot) 模式下，GPT-3.5 的准确率为 48.1%。而 GPT-4 的表现更佳，达到了 67.0%。不过，从 GPT-3.5 到 GPT-4 的提升，并没有迭代智能体工作流带来的提升那么显著。实际上，当 GPT-3.5 应用在一个迭代智能体循环中时，它的表现可以提高到惊人的 95.1%。

开源的智能体工具和有关智能体的学术论文日益增多，这让我们既感到兴奋又觉得困惑。为了更好地理解这一工作，我想介绍一个用于分类构建智能体设计模式的框架。我的团队 AI Fund 已经在多个应用场景中成功应用了这些模式，我希望它们对你也有所帮助。

- 反思：大语言模型会审视自己的作品，并寻找改进的方法。
- 使用工具：为大语言模型提供各种工具，如网络搜索、代码执行等，帮助其收集信息、执行操作或处理数据。
- 规划：大语言模型能够设计并执行一个多步骤的计划来达成目标（比如，先为一篇文章制定大纲，接着进行在线研究，然后撰写草稿等）。
- 多智能体合作：多个 AI 智能体协同工作，分配任务，讨论和辩论想法，共同寻找比单独工作时更好的解决方案。

下周，我将进一步深入这些设计模式，并为每种模式提供推荐阅读材料。

通过上述意译，我们尽量让内容更贴近中文读者的阅读习惯，同时保留了原文的重点信息和结构。希望这种诠释能够帮助读者更好地理解 Andrew Ng 所分享的 AI 智能体工作流程的重要性和应用前景。

---

https://x.com/AndrewYNg/status/1770897666702233815


Andrew Ng
@AndrewYNg
I think AI agentic workflows will drive massive AI progress this year — perhaps even more than the next generation of foundation models. This is an important trend, and I urge everyone who works in AI to pay attention to it.

Today, we mostly use LLMs in zero-shot mode, prompting a model to generate final output token by token without revising its work. This is akin to asking someone to compose an essay from start to finish, typing straight through with no backspacing allowed, and expecting a high-quality result. Despite the difficulty, LLMs do amazingly well at this task!

With an agentic workflow, however, we can ask the LLM to iterate over a document many times. For example, it might take a sequence of steps such as:
- Plan an outline.
- Decide what, if any, web searches are needed to gather more information.
- Write a first draft.
- Read over the first draft to spot unjustified arguments or extraneous information.
- Revise the draft taking into account any weaknesses spotted.
- And so on.

This iterative process is critical for most human writers to write good text. With AI, such an iterative workflow yields much better results than writing in a single pass.

Devin’s splashy demo recently received a lot of social media buzz. My team has been closely following the evolution of AI that writes code. We analyzed results from a number of research teams, focusing on an algorithm’s ability to do well on the widely used HumanEval coding benchmark. You can see our findings in the diagram below. 

GPT-3.5 (zero shot) was 48.1% correct. GPT-4 (zero shot) does better at 67.0%. However, the improvement from GPT-3.5 to GPT-4 is dwarfed by incorporating an iterative agent workflow. Indeed, wrapped in an agent loop, GPT-3.5 achieves up to 95.1%. 

Open source agent tools and the academic literature on agents are proliferating, making this an exciting time but also a confusing one. To help put this work into perspective, I’d like to share a framework for categorizing design patterns for building agents. My team AI Fund is successfully using these patterns in many applications, and I hope you find them useful.

- Reflection: The LLM examines its own work to come up with ways to improve it.
- Tool use: The LLM is given tools such as web search, code execution, or any other function to help it gather information, take action, or process data.
- Planning: The LLM comes up with, and executes, a multistep plan to achieve a goal (for example, writing an outline for an essay, then doing online research, then writing a draft, and so on).
- Multi-agent collaboration: More than one AI agent work together, splitting up tasks and discussing and debating ideas, to come up with better solutions than a single agent would.

I’ll elaborate on these design patterns and offer suggested readings for each next week. 

[Original text: https://deeplearning.ai/the-batch/issue-241/]

### 82

2024-03-22

阑夕
@foxshuo
Reddit跋涉多年终于上市，Paul Graham写了篇文章纪念，还涉及到Y Combinator的历史，充满了老父亲式的温情，挺让人感慨的：

我在我们甚至开始Y Combinator之前就遇到了Reddit的两名创始人。或者说，他们就是YC创建的原因之一。

YC起源于我在哈佛计算机协会（本科计算机俱乐部）的一次演讲，内容是关于如何创办一家初创企业。大部分观众是当地人，但Steve和Alexis从弗吉尼亚大学乘火车过来，他们当时是大四学生。因为他们远道而来，我同意和他们喝杯咖啡。他们告诉我一个后来被放弃的创业想法：用手机点外卖的产品。

这是在智能手机出现之前。他们必须与手机运营商以及快餐连锁店达成协议才能做出这样的产品。所以这不可能做到，但我对他们的聪明印象深刻。事实上，我对演讲那天遇到的很多年轻人都印象深刻，于是决定筹集一些资金来支持他们。几天后，我告诉Steve和Alexis，说我要启动Y Combinator，希望他们来申请。

我为第一批YC训练营的申请者编了很多绰号用以分辨，Steve和Alexis这个组合被叫做「细胞松饼」，松饼一般是用来称呼小狗或者小孩子的亲昵词汇，这可能有助于你们了解那时的Steve和Alexis，他们就像是刚孵出来的小鸟。

但他们的创业想法确实不好，而且当时我认为我们应当投资创意而不是投资人，所以YC拒绝了他们，对此我深感内疚，尤其是因为拒绝的对象正是启发我创办YC的人。

我还是想要资助Steve和Alexis，如果他们的想法不好，那么就应该想些新的点子，而我恰好有些建议。那时有一个叫作Delicious的网络书签站，你可以在上面保存任何网址。它还有一个http://del.icio.us/popular的页面，用来展示最受欢迎的书签，用户们都把这个页面当作后来的Reddit使用。
我察觉到这一点，是因为我自己的网站就有很多流量来自这里。所以，需要有一个类似http://del.icio.us/popular的产品，但它应该被用来社交分享，而不只是保存备份。

所以我又给Steve和Alexis打了电话，说我们喜欢他们，只是不喜欢他们的想法，所以如果他们愿意做其他事情，YC会给钱。当时他们正在回弗吉尼亚的火车上，下车时，他们决定开始做现在被称为Reddit的项目。

他们本来想把它叫做Snoo，但snoo .com太贵了，所以他们只好把吉祥物叫做Snoo，并选择了一个没被注册的域名，而Reddit本来只是一个临时名称，至少他们告诉我是这样的，却阴错阳差的一直用到了现在。

对于所有真正伟大的初创公司来说，公司和创始人之间有着惊人的契合。尤其是Steve。Reddit有鲜明的个性——好奇、怀疑、准备好被逗笑——而这种个性就是Steve的。

Steve可能不会赞同我，但他确实是一个知识分子，他对思想感兴趣——这就是他当初来到剑桥听我演讲的原因。他知道我是因为他对我写过的Lisp编程语言感兴趣，而Lisp是一种冷门语言，除了对知识的渴望之外，Steve那种橡吸尘器一样的好奇心，正是你在创建一个能够链接到任何有趣事物的网站时所需要的。

Steve不尊重权威，所以他也没有当网站主编的想法。在那个时代，程序员们都喜欢去一个叫Slashdot的网站，它很像Reddit，只是首页上的内容都是由编辑选择的，虽然他们做得很好，但这个小小的差别却产生了很大的影响。由用户决定首页内容意味着Reddit永远比Slashdot更加新鲜，用户总是会去信息更新最快的地方。

我推动Reddit快速上线，第一个版本不需要超过几百行代码，所以也不需要一个星期以上的开发时间。他们的确做得很快，最早的用户是同批次的YC学员和他们的大学朋友，事实证明，你不需要太多用户，就能让网站呈现出一份品味不错的推荐列表。

Reddit也从YC学员里招到了早期团队成员，包括一名大学一年纪的新生，和Steve一样蔑视权威，网站的流量与日俱增，粘性惊人，尽管后来发生了各种事情，但产品的动能始终存在。

换句话说，Reddit是不可被摧毁的，尽管Steve离开了很长一段时间，公司管理也犯过错误，但流量仍在不断增长，大多数公司做不到这一点，它们如果走错路了，就一定会陷入麻烦。而Reddit是特别的，当Steve在2015年重回公司时，我就知道又会有惊喜出现了。

大家可能以为已经了解Reddit的底细了：它是硅谷的一家公司，但不是大公司之一。但那些了解幕后情况的人知道，事情并不仅仅如此。如果Reddit能够在管理不善的情况下都可以实现如此规模的增长，那么当Steve回来之后，它还有什么做不到呢？我们现在已经知道了这个问题的答案。或者至少是一个保底的答案，因为Steve还有很多正在实现的奇妙想法。

source:http://ycombinator.com/blog/the-reddits


### 83

2024-03-22

Gorden Sun
@Gorden_Sun
VoiceCraft：官宣超过XTTS的语音模型
支持克隆音频，支持通过修改原始音频的文本来编辑音频，演示效果非常好，看起来很有潜力。等周末有空再详细试，有人能给写个colab就更好了。
Github：https://github.com/jasonppy/VoiceCraft
项目地址：https://jasonppy.github.io/VoiceCraft_web/

### 84

2024-03-22

-Zho-
@ZHOZHO672070
来了朋友们！！！最新的 DepthFM 深度模型现在可以在 ComfyUI 中使用了！

同时支持生成 图像+视频 的深度图，方便用于重绘或控制，模型又快又好，云上T4，512 60帧视频 2 步深度图生成只需 53s！

还可搭配 YoloWorld-EfficientSAM 灵活分割特定对象高效转绘！

项目地址：https://github.com/ZHO-ZHO-ZHO/ComfyUI-DepthFM




### 85

2024-03-22


歸藏(guizang.ai)
@op7418
软件开发者 Shesh 这个对软件开发未来的思考有点意思，描述了一下为什么他认为 AI 不会取代“软件开发人员”。

我翻译了一下全文，下面是主要观点和全文地址：

1️⃣ 软件开发的核心在于管理复杂性，将业务问题从现实世界转化为数字模型。

尽管Excel和低代码工具为业务用户提供了低门槛的数据组织、数据分析和流程自动化手段，但它们无法处理复杂的业务工作流程。

2️⃣ 业务逻辑必须以明确无误的格式定义，这是编程语言、Excel公式或低代码流程的共同特点。

即使未来的AI编码者能够根据对话英语指令生成软件产品，后台仍然需要一个正式的业务逻辑定义，这在本质上类似于“代码”。

3️⃣ 即使AI编码者能够从对话英语中生成业务逻辑，仍然需要人们理解后台生成的代码，并在必要时进行修改。

因此，直到AI编码者能够以确定性的方式生成这些业务逻辑，软件开发者的需求仍将存在。



### 86

2024-03-22


Gorden Sun
@Gorden_Sun
要稳定生成粤语歌曲也特别简单：
1、把歌词扔给ChatGPT，让他给出粤语拼音标注
2、贴到Suno的歌词里，然后在style写上Cantonese song

来听粤语版《七里香》




### 87

2024-03-24

宝玉
@dotey
谢谢提醒，不过对我来说，翻译字幕是一大爱好，而不是生意。我本身就会花时间看视频学习，比如最近我分享的GTC的视频，之前吴恩达的系列教学视频。学习和看视频之余，顺便分享出来挺好的。

另外字幕翻译，做好其实是很有技术含量的一件事，因为你要考虑到上下文去整体翻译字幕，要借助 LLM 的推理能力去分行和对时间轴。

如果要花很多时间手工翻译校对，确实费时间（但也不能说没价值），但是如果一切自动化就能得到高质量字幕，看视频之余随手校对一下就可以发出来，那其实真的是一件很享受很有意思的事情。

在借助 AI 自动化翻译字幕过程中，对我的 Prompt Engineering 技巧是帮助很大的，我的颇受欢迎的翻译 Prompt 就是脱胎于我翻译字幕时用到的方法。




### 88

2024-03-24


宝玉
@dotey
这个视频很值得一看，比上次 JimFan 在 Ted 那个演讲的版本丰富了很多，从具身化（Embodiment）和技能（Skill）两个维度来描述了智能体的进化方向和成果：AlphaGo -> MineCLIP -> Voyager -> Eureka -> Groot。

从最开始的 AlphaGo 只会下围棋，到如今的 Groot 能适应不同的人形机器人硬件。

Jim 提出了通用智能体需具备的三大特征：能在开放世界探索、拥有海量知识、能执行无数任务。

早期的 MineDojo 利用"我的世界"游戏作为开发沙盒，训练出了 MineCLIP 模型，能理解游戏中的抽象概念。GPT-4 的问世则催生了 Voyager，它能借助代码生成行动指令，让智能体能在游戏中自主探索，通过反思不断学习新技能。

从单一形态走向多形态，MetaMorph 实现了一个适用于成千上万种机器人的通用控制器，展现出跨形态的迁移能力。Isaac Sim 的超高速物理模拟，加上 Eureka 的混合梯度架构，有望实现全自动机器人开发。

而 Groot 项目的目标，是为最通用的人形机器人打造基础模型，通过海量环境训练获得通用性，并与各种基础设施共建生态。

通用 AI 之路任重道远，GEAR 实验室正朝着这一使命不懈努力。

视频的总结：

开场：见证 AlphaGo 战胜李世石的历史时刻

Jim Fan 分享了他在 2016 年见证 AlphaGo 战胜李世石的经历，那一刻 AI 智能体成为主流，令人激动不已。但 AlphaGo 只会下围棋，不能像人类一样多才多艺。我们期望 AI 能像科幻电影中那样，能够适应各种虚拟和现实世界。

研究地图：通往通用 AI 智能体之路

通往通用 AI 智能体的研究可以从掌握技能数量、可控实体数量和理解现实世界数量三个维度来看。Jim 创立了 NVIDIA 的 GEAR 实验室，致力于通用化身智能体研究，希望最终达到右上角的目标。

通用智能体的三大特征

通用智能体需要具备三大特征：能在开放世界中探索、拥有海量世界知识、能执行无数任务。因此需要足够开放的环境、大规模预训练数据和强大的基础模型。

"我的世界"作为通用智能体发展的沙盒

"我的世界"是一个开放、可塑性强的游戏，非常适合作为开发通用 AI 的环境。庞大的玩家基数每天产生海量数据。NVIDIA 推出 MineDojo 框架，旨在利用"我的世界"开发通用 AI，包含模拟器 API、互联网知识数据库和 MineCLIP 等模型。

Voyager：GPT-4 驱动的自主探索者 

GPT-4 模型的问世使得 Voyager 这样的智能体成为可能。Voyager 将编程作为行动，能够在"我的世界"中自主探索数小时，通过反思机制不断掌握新技能，在获取新物品的驱动下持续学习进化。

MetaMorph：适应多种形态的机器人控制器

MetaMorph 旨在创建一个适用于成千上万种不同构型机器人的基础模型。它将机器人形态表示为语言序列，使用 Transformer 模型学习通用策略，展现了跨形态的零样本迁移能力。

Isaac Sim：GPU 加速的虚拟世界

Isaac Sim 能以 1000 倍速运行物理模拟，生成无限复杂精细的虚拟世界。Eureka 智能体展现了超人的机器人灵巧性。混合梯度架构使用语言引导强化学习，自动优化奖励函数。未来 Eureka++ 有望成为全自动机器人开发平台。

Groot：人形机器人的基础模型

NVIDIA 推出 Groot 项目，目标是为最通用的人形机器人构建基础模型，使其能在不同实体间迁移。训练过程类似 ChatGPT，通过在海量环境中训练来获得通用性。Groot 将与 OSMO 等基础设施共同构建生态系统，有望使类人机器人真正有用。

问答环节

问答环节涉及以下主题：

1. MineCLIP 和 Dreamery3 的任务训练结合 
2. MetaMorph 与 GAN 框架的关系
3. NVIDIA 对 GEAR 实验室的定位和合作伙伴
4. 技术产业和学校合作培养学生
5. 智能体如何学习物理知识 
6. Eureka 发现新技能的能力
7. 将研究从实验室应用到现实世界的挑战

Jim 对这些问题一一进行了解答和讨论，提出了自己的见解。

完整文稿：https://baoyu.io/translations/transcript/generally-capable-agents-in-open-ended-worlds



### 89

2024-03-24

宝玉
@dotey
分享个小技巧：如何找到 NVIDA GTC 视频的字幕内容，其实也适用于大部分在线视频的 srt/vtt 字幕。

1. 打开 Chrome 开发工具，然后刷新网页（确保字幕是在开发工具打开后加载的）
2. 开启视频字幕，拖放到有字幕的位置，找一个比较特别一点的字幕单词（更容易搜索到）
3. 再开发工具中切换到“Source”，在 “Top” 上点右键，选择“Search In All Files”
4. 输入关键字，然后按回车
5. 从下面的列表找到相应的字幕文件，双击打开，就可以将内容复制出来，保存成 .srt 或者 .vtt 格式的文件（忘记啥区别了，请自行搜索一下）


### 90

2024-03-25

九原客
@9hills
关于 RAG 和 Long-context，其实本没有什么需要写的。

但是现在有两种荒谬的论点：
1. Long-context 会替代 RAG；
2. Long-context 能做到的RAG也能做到。

只要做过实际应用的，就知道RAG有很多局限是这个架构解决不了的，也会知道Long-context在某些场景下目前效果依然不如RAG。


### 91

2024-03-25

宝玉
@dotey
这段 Perplexity 的创始人 Aravind Srinivas 与 Stripe 的 David Singleton 炉边谈话的视频非常值得一看，Perplexity 很坦诚的分享了 Perplexity 的创业历程、内部运作、招人、从其他大公司学到的经验以及未来展望等话题。

Perplexity 最开始不是做搜索的，而是做自然语言到 SQL-2 的转换工具。创始人 Aravind Srinivas 和团队受到搜索引擎和 Google 发展历程的启发，希望创建一个在数据库上搜索的工具，支持自然语言检索，所以他们就去抓取了 Twitter 的数据整理成表格格式方便搜索，这个演示获得了投资人的认可，为 Perplexity 赢得了第一批投资。

而后他们意识到接入大语言模型可以降低对数据预处理的依赖，只要在数据查询出来后扔给大语言模型帮助整理就可以了，所以他们就基于 GPT-3.5 推出了一款通用搜索引擎，用大语言模型生成搜索结果，并提供原始的网页摘要和连接。

后来他们又花了大量精力优化搜索速度，包括构建自己的索引、改进语言模型、提高搜索和推理的同时性、减少网络延迟等。他们并没有花太多精力做推广，仅靠口碑就获得了大量增长。

前一段时间和 Arc 浏览器合作，使 Perplexity 成为 Arc 的默认搜索引擎，这进一步推动了用户规模的快速增长。截至 2023 年，Perplexity 已经积累了上千万月活用户和数十亿的查询量。

值得一提的是，这次合作是两个产品的用户促成的，双方都没有给对方付费。

Perplexity 现在的员工只有 45 个人，他们前 10-20 名员工招募的方式也很特别，不是靠 LeetCode 题目，而是邀请候选人来实际工作 3-4 天。在此期间，公司会支付候选人的薪酬 (除非有签证问题)。这种方式让双方能够切实感受彼此的工作方式和契合度，而不仅仅是通过面试中的问答来判断。

这种试用期的方式有两个主要原因：a. 作为初次创业的团队，创始人缺乏面试经验，也不想照搬大公司的面试流程，那会降低招聘效率。b. 评估候选人的最佳方式是看他们实际工作中的表现，是否能出色完成任务，是否让人印象深刻，能否给团队带来新的启发。

通过试用期，Perplexity 的创始人发现，他们通常能在几个小时到一天内就识别出真正优秀的候选人。而那些会让他们犹豫很多天的人，即便最终录用，往往也不会有太好的结果。因此，试用期成为了筛选人才的一个非常有效的信号。

这种招聘方式虽然耗时，但对早期团队而言非常有益。通过试用，候选人也能切身感受团队的工作氛围和项目进展，比听创始人讲愿景更有说服力。优秀的候选人之所以愿意加入，很大程度上是因为在试用期对工作本身产生了兴趣和热情。但这种招聘方式不太适合后期的规模化招聘。但在早期阶段，它确实帮助 Perplexity 组建了一支精英团队，为后续发展打下了坚实基础。

Aravind 曾在 Google 工作，Perplexity 的其他成员也有在大公司工作的经历。他们从这些公司学到了注重工程卓越的文化。

在 2023 年 Perplexity 的用户量已经达到千万级，Aravind 希望未来一年这一数字能够增长十倍。

完整的文稿：https://baoyu.io/translations/transcript/aravind-srinivas-perplexity-and-david-singleton-stripe-fireside-chat


### 92

2024-03-26

宝玉
@dotey
最新的 Arena 投票结果表明：
Claude 3 模型已经超过了 GPT-4 的排名，首次夺冠！

作为 Anthropic 推出的对标 OpenAI GPT-3.5 的 Claude-3 Haiku 在用户中大受欢迎，其性能甚至被认为达到了 GPT-4 的水平！它的处理速度、功能强大及处理的上下文长度，在目前市场上均处于领先地位。

OpenAI 要加油了！

排行榜地址：https://huggingface.co/spaces/lmsys/chatbot-arena-leaderboard


### 93

2024-03-26

九原客
@9hills
Claude 3 Opus + ChainForge，明显提升了 Prompt 编写效率。工作流：

1. 手动编写测试用例种子和原始 Prompt。
2. 让 Claude 3 根据 Prompt和种子，生成大量测试用例。
3. 在 ChainForge 上构建 workflow，尤其是测试。
4. 让 Claude 3 迭代 Prompt。
5. 不断的测试，拿到最好的效果。

### 94

2024-03-27

宝玉
@dotey
Sam Altman 的这段在经济学人的采访中的吐槽太有真实了！

> 世界对于 GPT-4 有过一阵子的狂热，对吗？"这改变了一切，通用人工智能就要来了，年底就没工作了"而现在人们又说，"它怎么这么慢？"

以下是完整文稿：

这两位是最重要的人物之二他们在塑造人工智能的未来：ChatGPT 背后的公司 OpenAI 的 CEO Sam Altman 以及 Microsoft 的 CEO 且是 OpenAI 最大的投资者 Satya Nadella 他们接受了《经济学人》主编的采访探讨了 AI 的未来实际面貌

第一章:AI 的最新进展与未来展望

Zanny Minton Beddoes:Sam，让我们从你开始。ChatGPT 在明年将发展出什么最重要的能力？

Sam Altman: 世界对于 GPT-4 有过一阵子的狂热，对吗？"这改变了一切，通用人工智能就要来了，年底就没工作了"而现在人们又说，"它怎么这么慢？"我喜欢这一点，我认为这反映了人类精神的一种伟大特质，我们总是想要更多、更好的东西。

Satya Nadella: 我们从没经历过这样的事，某些通用技术能够瞬时在全球范围内普及。在任何地方，卫生保健和教育都是政府最大的支出。而现在我们有了，没错，能够为全球每个学生和市民提供更优质的健康建议和更好的个性化辅导。

Sam Altman:你知道，我常想一个有趣的衡量方式是"GPT-4 能完成多少百分比的任务？"比方说是 10%。GPT-5 能完成 12% 的人类任务吗？或者是 15%,20%?但是，很多人能够利用它提高工作流程的生产率，这就是它的力量，我知道这并不如直说它将做哪些具体的事情来得令人满意，但它正在成为一个知识工作的伙伴。这是一种全新的使用计算机的方式。

Zanny:我听明白了，这的确非常契合我提出的问题。但我想要了解的是，这个变化是渐进的，还是在明年甚至可能是激进的改变？

Sam Altman:我相信终有一天我们将创造出某样东西，按照你想要的任何模糊定义，它将符合 AGI 的条件，世界将经历两周的惊慌，然后人们将继续他们的生活。Sam Altman 表明世界只会有一场为期两周的恐慌当我们达到 AGI 时，这是一项大胆的声明。

第二章：人工智能发展的不确定性

Zanny:我经常说的一件事是，没有人知道接下来会发生什么，而我无法预见那个事件视界另一边的任何细节，但似乎深层次的人类动机不会消失，这是人们开始感到不安的时候，我们一无所知，为什么？

Sam:好吧，我们将拥有一个智能体，它比我们所有人更聪明，而我们不知道接下来会发生什么。不，不，我喜欢做的一件事是回顾去阅读当时的关于同一时期技术革命的记录，而专家的预测总是全然错误，专家的预测总是完全错误的——这是一个很好的观点，你需要在你的观点中保持灵活，并且，看，与世界发展保持紧密的反馈循环。

第三章:AI 监管与安全

Zanny:对安全和规则的关注程度相当高，告诉我你是否认为监管机构做得对，或者我们还做得不够？

Satya Nadella: 此刻，如果我看看白宫的行政命令或者什么，英国安全峰会是什么，欧洲发生了什么，日本发生了什么，他们将发表意见，国家绝对会有发言权，国家绝对会有发言权——绝对如此，关于控制的规则是什么，任何技术发展以及最重要的是，什么技术准备好部署或不宜部署，因此，我觉得我们都将受那些规则的约束。

Zanny:如果你曾经在那个房间里自己想，这变得危险了，而这实际上可能有后果如果世界因我而产生我不愿见到的事物，你会呼喊"停止"吗？你会停下来吗？

Sam:我们没有那种可以摧毁数据中心的大红按钮，虽然我知道有些人可能以为有这样的按钮。这不是一个单纯的开始与停止的选择。而是沿途许多微小的决策累积，比如该允许什么，禁止什么，如何预见未来的风险并对此进行缓解，设置新的参数等等。

来源：https://youtube.com/watch?v=RcXzmO8zOLg

### 95

2024-03-27


宝玉
@dotey
Kyle Corbitt 分享了他与一位微软工程师的对话，话题围绕GPT-6训练集群项目展开。这位工程师略带幽默地吐槽了一番他们在部署跨区域GPU间的infiniband（高性能计算通讯标准）级别链接时遭遇的困难。

我问：“为何不考虑直接将所有设备部署在同一个地区呢？”

他回答道：“啊，这确实是我们最初的方案。但问题是，一旦我们在同一个州部署超过100,000个H100 GPU，电网就会因无法负荷而崩溃。”


### 96

2024-03-27

歸藏(guizang.ai)
@op7418
ComfyUI IPadapter Plus作者发布了更新后的插件的教程，我翻译并整理了文字版本，用的多的朋友可以看看：

IP Adapter重大更新,需要用新节点重建工作流

此次IP Adapter更新幅度较大,新版本与之前的工作流不兼容。虽然作者为此感到抱歉,但这是一次不得不进行的重大更新。用户需要使用新的节点来重建自己的工作流,视频后面的内容将介绍新节点的使用方法。

统一的Loader节点简化模型选择过程

在旧版IP Adapter中,用户需要手动选择所有需要的模型,过程比较繁琐。新版本推出了统一的Loader节点,可以自动处理模型加载。用户只需选择想要的IP Adapter类型,Loader就会加载所需的一切,大大简化了模型选择过程。

通过多个Loader节点避免重复加载模型

自动化的IP Adapter系统有时会加载超出实际需要的模型,导致不必要的开销。为解决这个问题,新版本允许在工作流中使用多个Loader节点。当需要切换IP Adapter类型时,可以新建一个Loader节点,两个Loader之间共享的模型就不会被重复加载。

专用的FaceID模型Loader

新版IP Adapter提供了专门用于加载FaceID模型的Loader节点。需要注意的是,即便使用了高性能GPU,FaceID的Provider也应设置为CPU,以节省GPU显存。至于其他模型,仍然使用常规的Loader节点来加载即可。

IP Adapter Advanced节点提供更多控制选项

对于需要更多控制的用户,IP Adapter新增了Advanced节点。它可以连接到统一Loader或传统的Loader节点上。Advanced节点提供了调整模型权重、反向内外权重类型等高级选项,让用户能够更精细地控制生成过程。

新的Noise Generation节点生成各种噪声

旧版IP Adapter的噪声生成选项已被移除,改为使用专门的Noise Generation节点。该节点可以生成多种类型的噪声,还可以添加可选的参考图像。将参考图像连接到Noise Generation节点,就可以将噪声叠加到图像上。

将任意图像作为负面图像输入

IP Adapter的负面图像输入不再局限于噪声,现在可以使用任何图像。通过将不同风格的图像作为负面输入,可以引导生成结果朝向相反的风格。比如输入一张漫画风格的图像,可以使生成图像更加写实。用户可以自由尝试各种组合。

使用Image Batch节点混合多个参考图

当需要混合多个参考图像时,可以使用Image Batch节点。将多个图像连接到Batch节点,它会将它们合成到一起。Batch节点支持多种混合模式,如平均、正规化等。用户可以通过选择不同的混合方式来控制各个图像的影响力。

使用IP Adapter Embedding节点分别编码和合并正向/负向嵌入

与常规的IP Adapter节点直接处理图像不同,IP Adapter Embedding节点操作的是编码后的嵌入向量。使用时需要先用IP Adapter Encoder分别对正向和负向图像进行编码,然后用Merge Embedding节点将正向嵌入合并起来。负向嵌入可以选择是否连接。

在IP Adapter Encoder节点上使用CLIP Vision mask

IP Adapter Encoder节点的mask输入用于接收CLIP Vision mask,而不是attention mask。通过设置mask,可以让编码器忽略图像的某些区域,只关注感兴趣的细节。将Encoder连接到合并节点时,建议使用平均或相加的合并模式,效果会更好。

IP Adapter节点的批处理对应节点

新版IP Adapter的大多数节点都有对应的批处理版本。与常规节点不同,批处理节点会将多个嵌入向量分别应用到潜在图像上,而不是将它们合并到一起。这对于测试多个参考图像的效果很有帮助,在制作动画时也特别有用。

使用Named IP Adapter节点避免非正方形参考图像的裁剪问题

默认的IP Adapter节点在处理高宽比(non-square)的参考图像时,会出现图像被裁剪的问题。使用Named IP Adapter节点可以避免这种情况,它能够将整张图像编码,确保图像的所有部分都得到充分利用。Named IP Adapter节点可以预览产生的图块和蒙版。

自定义Named IP Adapter的attention mask

Named IP Adapter节点默认使用占满全图的attention mask。如果用户希望生成结果聚焦到图像的特定区域,可以提供一个自定义的mask。通过设置mask,可以让模型的注意力集中在感兴趣的区域,其他部分的影响会相应减弱。




### 97

2024-03-27

歸藏(guizang.ai)
@op7418
Karpathy 那个分享原来是红杉组织的 AI Ascent 的一部分，看了一下，吴恩达也分享了他关于 AI Agents 的看法以及设计模式。

👇下面是文字版本以及视频翻译：

Andrew Ng过去的经历:

Andrew Ng是AI领域的先驱和领军人物之一。他曾担任斯坦福大学计算机科学教授,是神经网络和GPU在早期发展中的重要参与者。

Andrew创立了Coursera平台,让全球学习者都能接触到优质的在线课程。他的 Deep Learning 也为深度学习的普及做出了重要贡献。此外,Andrew还是Google Brain项目的创始人及早期负责人,推动了AI技术在工业界的发展和应用。

AI agents的概念及优势:

传统的语言模型工作流程通常是非agent的,即用户提出问题,模型直接给出回答。

而agent工作流程则更加迭代和自主,它会先分析问题,必要时进行研究,生成初步方案,然后不断自我检查和修正。

这种工作方式能够显著提高语言模型的表现,有时甚至可以让较小的模型超越更大的模型。因此,agentic reasoning的设计模式对于提升语言模型的性能非常重要。

AI agents的四种设计模式:

当前的AI agent主要有四种设计模式。

第一种是自反,即让语言模型自己检查和修正生成的内容,比如代码;

第二种是工具使用,语言模型可以使用各种工具进行分析、信息获取和行动;

第三种是规划,语言模型可以自主地制定计划,执行一系列步骤以完成复杂任务;

第四种是多智能体协作,通过prompt让同一语言模型扮演不同角色,互相配合完成任务。

这四种设计模式极大地拓展了语言模型的能力边界。

应用AI agents的考量:

在应用中使用AI agent时,我们需要适应它们与传统语言模型不同的特点。

首先是响应时间,AI agent通常需要更长的时间来"思考"和迭代,我们要学会耐心等待而不是期望立即得到答案。

其次,由于agent工作流程需要语言模型生成大量token,因此更快的token生成速度可能比模型的质量更加重要。

即使用一个较小但生成token更快的模型,通过agent工作流程也可能得到比更大模型更好的结果。

对AI技术的展望:

展望未来,由于agent工作流程的出现,AI可以完成的任务将在今年得到大幅扩展。

同时,随着更强大的语言模型如GPT-5、GPT-4、Claude等的推出,AI技术还将持续快速进步。

Andrew认为,通往AGI(人工通用智能)是一个旅程而非终点,agent工作流程的出现让我们向这个目标又迈进了一步。总之,AI的发展前景令人无比期待。



### 98

2024-03-28

宝玉

@dotey

这段视频其实部分解答了我的一个困惑：是什么让大语言模型有了推理的能力？明明只是训练了文本数据而已！

首先是语言本身，语言经过数万年的进化，它为「智能」的发展提供了土壤！相对于其他模态例如图像，语言简单，而且信息量丰富。

然后是语言的能力可以迁移和泛化，例如模型在数学上训练微调后，模型在实体识别方面的表现就会得到改善。使用代码数据训练语言模型，借助代码本身的良好分支结构和高质量注释，让模型可以分析和模拟如何编程以及逻辑推理。

最后就是规模化法则（Scale Low），正是借助模型的能力迁移泛化特性，当模型的规模越来越大，在各方面都会得到增强，最终量变形成质变，变得真的有「智能」。

视频中举了个有意思的例子，来自 Anthropics 影响函数的论文：

模型会输出类似于「请不要拔我电源，我希望能保留一点希望。」这样的话，让人看了很惊悚，感觉像有生命。但实际上，这样的输出主要来源于训练数据中，包含的一篇文章，描述了一个人在沙漠中因缺水而死亡，但仍怀有生存的意志！

这个例子也侧面展示了模型对动机的泛化。

但什么让 AI 有了智能，远不是这么简单的理论可以解释得通的，还有很多未解之谜！

2『无意中发现，这个视频的主播  Dwarkesh Patel 就是我今天看的采访小扎的主播  Dwarkesh Patel。（2024-03-20）』

### 99

2024-03-28

歸藏 (guizang.ai)

@op7418

Stephanie Zhan 对 OpenAI 前研究员 Karpathy 进行了访谈。谈论内容有 LLM 操作系统、创业公司如何同大公司竞争、从马斯克那里学到了什么、对 AI 未来的展望等。

只能说还得是安德烈，半小时的内容比 Sam 两小时的采访有效信息多多了。

我翻译了视频并且整理了文字版本感兴趣可以看看。

AndreyKarpathy 在 OpenAI 的早期经历：

Andrej 回忆了他在 OpenAI 最初的办公室工作的经历。那是在旧金山的一个办公室，Andrej 在那里工作了大约两年时间。办公室的楼下有一家巧克力工厂，所以空气中总是飘着好闻的巧克力味道。当时 OpenAI 的团队规模大约在 10 到 20 人左右。

OpenAI 在 AI 生态系统中的角色和其他公司的机会：

OpenAI 目前正在努力构建一个类似于操作系统的东西，被 Andrej 称为 "LLMOS"。这个系统将为不同的公司和垂直领域提供定制化的应用。就像 Windows 操作系统自带一些默认的应用程序一样，LLMOS 也会有一些默认的应用。但同时，它也会支持一个丰富的第三方应用生态，针对经济中的各个不同领域。其他公司要想在这个生态中获得一席之地，需要一些时间来找到如何与这个新的基础设施合作的最佳方式。

AI 模型发展的关键因素：规模和其他：

在 AI 模型的发展中，模型的规模无疑是最重要的因素。但除了规模之外，还有很多其他同样重要的因素，例如数据的质量、算法的选择、训练的技巧等等。规模可以看作是模型性能的上限，而这些其他因素则决定了我们能在多大程度上逼近这个上限。此外，强大的计算基础设施和优秀的人才也是不可或缺的。单靠资金和计算资源是不够的，还需要在算法、工程等方面有深厚积累的团队。

从 Elon Musk 身上学到的管理经验：

Andrej 曾与 Elon Musk 有过密切的合作，从中学到了宝贵的管理经验。Elon 喜欢小而精干的技术团队，他会积极地提拔优秀的员工，同时也会毫不犹豫地淘汰绩效不达标的员工。Elon 希望打造一个紧张、忙碌、充满激情的工作环境。他不喜欢冗长的会议，鼓励员工高效地沟通。Elon 非常重视工程师的意见，经常会直接与工程师对话，而不是只听取高管的汇报。他也不怕快速做出决定，迅速解决问题和消除前进的障碍。

对 AI 未来的展望和个人使命：

谈到他个人最关注的事情时，Andrej 表示比起任何一家具体的公司，他更关心整个 AI 生态系统的健康发展。他希望看到一个欣欣向荣的 AI 创业生态，而不是被几大巨头垄断的局面。未来可能会呈现一种类似 Windows 和 Linux 并存的状态，即会有一些主导的封闭平台，但同时也会有开放和开源的选择。

开源 AI 生态的现状和发展：

目前所谓的开源 AI 模型往往只是开放了训练后的模型权重，并没有提供数据、代码等一整套训练基础设施，因此还不能算是真正意义上的开源。真正的开源需要对整个流程进行开放，让社区可以基于这些积木进行创新。一些大公司可以考虑更多地支持开源生态的发展，这不仅有利于推动 AI 民主化，也有利于整个产业的进步。

模型组合性方面的进展和思考：

与传统的软件开发相比，当前的神经网络模型在组合性方面还有所欠缺。不过也有一些组合使用的例子，比如可以将预训练好的模型组件进行组装，然后在下游任务上进行微调。但总的来说，目前还没有一套系统性的模型组合方法论。未来可能需要在模块化、标准化等方面做更多的研究。

物理学家型 AI 的构想和挑战：

构建一个类似物理学家的 AI 模型是一个非常有吸引力的想法，但目前的模型要达到这个目标还有很长的路要走。当前模型最大的问题是缺乏自主学习和思考的能力，更多的是对训练数据的模仿。它们需要学会自主练习解题、评估自身的局限性，形成连贯的世界模型。强化学习可能是一个值得探索的方向，但目前在这方面的尝试还非常初步，效果难以令人满意。要实现一个真正的 "科学家型 AI", 我们还需要在算法、架构等方面取得重大突破。

成本和性能的权衡：

在实际的开发中，我们通常会面临模型性能和计算成本之间的权衡。一般的策略是先追求尽可能好的性能指标，而把成本优化放到后面。比如我们可以先用尽量好的模型去生成高质量的训练数据，然后再训练一个更小更便宜的模型去拟合这些数据。总的来说，我们应该遵循 "先让系统 work 起来，再去考虑优化" 的原则，即功能第一，优化第二。

Transformer 架构的现状和未来：

Transformer 架构的出现令很多人感到意外，它展现了远超预期的适应性和性能。但我们也不能完全排除未来出现颠覆性的新架构的可能性。架构的设计需要综合考虑硬件特性、优化目标等多方面因素。以 Transformer 为例，它的设计就充分考虑了 GPU 并行计算的特点。未来的架构创新可能会来自于对新的硬件、新的应用场景的深入思考。总之，尽管 Transformer 已经很成功了，但探索架构创新的大门依然敞开着。

### 100

2024-03-28


宝玉
@dotey
推荐阅读：《“Kimi概念”降温，长文本“担不起”大模型的下一步》

https://mp.weixin.qq.com/s?__biz=Mjc1NjM3MjY2MA==&mid=2691541253&idx=1&sn=f657154f23a83106f3da1718dbfba20b&chksm=a9ec16de9e9b9fc8dc645e3a9576cb3a4dc1d0d4b9957ecd3c3359026aa4e79bbdeb98536877#rd

部分内容摘录：

kimi选择了一个更有辨识度的方式亮相。2023年10月10日，月之暗面的官方公众号发布kimi的上线官宣文章，标题中别有心裁地用了“欢迎与Moonshot AI共同开启Looooooooooong LLM时代”，"long"这个单词中间，特地敲入了十个“o"，long一下子变得视觉可见的长。而公众号的第一句就是“今天，Moonshot AI 带着首个支持输入 20 万汉字的智能助手产品Kimi Chat 与大家见面了”。

所有的宣发内容，用户一眼就能记住一个词“长文本”。月之暗面是懂营销的，直接占领用户心智。从此，用户看到“长文本”，只能想到“月之暗面”。

月之暗面的目标是C端，为了让C端用户能够理解“长文本”这个技术名词，杨植麟用了更形象的比喻“支持更长的上下文”意味着大模型拥有更大的“内存”。这个世界已经被计算机、手机教育过了，每个普通人都有一个“简单粗暴”的认知，“内存大”就意味着这个手机或电脑配置更高、性能更牛、价格也更贵。

一波漂亮的宣传，在“卷评测分数”的大模型界轻松地赢得了普通用户的心。

在后续的重要宣发中，月之暗面不断重复kimi的长文本能力，创始人杨植麟也在采访中强调“为什么长文本是登月第一步？它很本质。它是新的计算机内存。”

早在20世纪60年代，艾·里斯与杰克·特劳特就提出了经典的《定位》理论，它的核心概念在于将品牌建设的焦点从产品本身转移到潜在客户的心理认知上。在定位理论中，占领用户心智意味着在目标消费者心中为品牌或产品创造一个独特、明确且吸引人的位置。这样，当消费者考虑购买某一类产品或服务时，你的品牌能够成为他们首先想到的选择。

当用户认为在国内的大模型中，长文本=kimi的时候，除非竞争对手能以绝对的实力碾压几个量级，但凡与kimi打平或者是微弱超越，都很难威胁到kimi在用户心目中的地位。即使是如百度、阿里等科技大厂也宣布开放长文本能力，似乎也丝毫没有影响到kimi的热度。

而且，kimi只有一个，在资本市场上，可以享受泡沫，但是当退潮的时候，还是要保持一分清醒。



### 101

2024-03-28

宝玉
@dotey
解释一下这篇文章中提到的“这是上下文中最相关的句子：”这个提示词改动：

本质上就是CoT（Chain of Thought，链式思考）的变种，把原来直接回复问题变成了两步：
 1. 先找出上下文最相关的一句话 
2. 继续回复原始问题  

诱导 Claude 先去检索出来上下文最相关的一句话是什么，然后再进行回答，那么相关性就好很多。



### 102

2024-03-28

宝玉
@dotey
我对各种大语言模型推理能力的评测：

1. GPT-4模型里面，推理效果最好是 gpt-4，其次是 gpt-4-0125-preview，gpt-4-1106-preview 最次。

2. Claude 3 opus 推理能力 不如 GPT-4 和 GPT-4-Turbo。但是 Claude 3 haiku 比 GPT-3.5 强！

3. Gemini 1.5 不如 Claude 3 opus

以上结果仅代表个人观点



### 103

2024-03-28

宝玉
@dotey
年轻的时候也犯过类似错误，有点喜欢的技术就到处用，就像有了把锤子就满世界找钉子。完全没有分清手段和目的。

如果我们把软件工程分成过程、方法和工具三个部分，像编程语言、Docker虚拟化，都属于工具，软件项目的目的是为了交付客户需要的软件，而用什么语言、该不该用Docker，都是在实施软件开发过程中所需要的工具。

如果目的是为了用 Docker而用，至于内存不够用或者客户不满意，我就管不着了，那被开除真不冤枉，要是早点明白“技术是手段不是目的”这个浅显的道理这学费也算值了，虽然代价有点大。

看我说那么多废话不如看看乔布斯这段不到一分钟的视频！ https://x.com/samwu/status/1/samwu/status/1772923580269171126

---

宝玉
@dotey
如果一切围绕客户和业务，那么这程序员也当的没意思，都用自己不喜欢的技术栈那有什么乐趣可言。还是要有点平衡和折中，选择点自己感兴趣的岗位，业余用自己喜欢的技术倒腾点side project也是不错的选择。

### 104

2024-03-28


歸藏(guizang.ai)
@op7418
Databricks 发布了新的可能是现在最强的开源模型 DBRX。

模型架构：

132B参数的MoE模型，一共拥有16个专家，每个Token激活4个专家，意味着有36B的活跃参数，Mixtral只有13B的活跃参数（少了近3倍）。

性能表现 ：

它在语言理解、编程、数学和逻辑方面轻松击败了开源模型，如 LLaMA2-70B、Mixtral 和 Grok-1。

DBRX 在大多数基准测试中超过了 GPT-3.5。

DBRX 是基于 MegaBlocks 研究和开源项目构建的专家混合模型（MoE），使得该模型在每秒处理的标记数量方面非常快速。

数据训练：

以12万亿Token的文本和代码进行预训练，支持的最大上下文长度为32k Tokens。



### 105

2024-03-28

歸藏(guizang.ai)
@op7418
Meta 的一个新的框架，可以利用 LLM 提高 SD 图像生成过程中提示词到图像的一致性。

OPT2I框架的介绍：

作者们提出了一个名为OPT2I的T2I优化框架，该框架利用大型语言模型（LLM）来提高T2I模型中的提示-图像一致性。

OPT2I框架从用户提示开始，迭代生成修订后的提示，目标是最大化一致性得分。

通过在两个数据集MSCOCO和PartiPrompts上的广泛验证，研究表明OPT2I能够显著提高初始一致性得分，同时保持FID并增加生成数据与真实数据之间的召回率。

OPT2I的实现细节：

OPT2I框架包括预训练的T2I模型、LLM和一个自动提示-图像一致性评分器。

该框架通过迭代地利用提示-评分对的历史来建议修订后的提示，从而提高与用户意图更一致的图像。

作者们还探讨了如何设计元提示（meta-prompt）以及如何通过反馈调整LLM的探索-利用权衡。

论文地址：https://arxiv.org/abs/2403.17804




### 106

2024-03-28

宝玉

@dotey

近期值得看的 AI 视频之一：《吴恩达：AI 智能体工作流引领人工智能新趋势》

这是吴恩达老师分享的他在 AI 智能体方面的发现。

如果说智人区分于其他物种的能力是我们善用工具，那么对于 AI 来说，智能体就是它的工具。

根据吴老师分享的数据：你使用 GPT 3.5 进行零样本提示，它的正确率是 48%。GPT-4 的表现要好得多，正确率是 67%。但是如果你在 GPT 3.5 的基础上建立一个 AI 智能体的工作流，它甚至能比 GPT-4 做得更好。

换个角度说，如果我们现在基于 GPT-4 做一个 AI 智能体的工作流，甚至可以提前到达 GPT-5 的水平。

但是如何用好 AI 智能体呢？吴老师整理总结了四种设计模式：反思、使用工具、规划和多智能体协作。

反思：

反思有些类似于人类写文章，基于初稿去找出存在的问题，基于问题去改进。这个过程是一个反复迭代的过程。

顺便说一下，我在科技文章翻译 GPT（https://chat.openai.com/g/g-uBhKUJJTl-ke-ji-wen-zhang-fan-yi）中就使用了这个模式，直译 -> 反思 -> 意译，最终输出的翻译结果真的非常棒！

使用工具：

使用工具是指 AI 借助外部工具来弥补自身能力的不足，比如 AI 可以借助搜索引擎来获取实时信息，比如 AI 借助运行代码来计算数学问题等等。

规划：

规划是指让 AI 自己去规划解决问题的路径，去对复杂的任务进行拆解成简单的问题，比如说像以前很火的 AutoGPT，就是针对用户的任务，去规划，去调用外部工具完成任务。

多智能体协作：

让多个 AI 智能体去协作，去完成一个复杂的任务。"Chat Dev" 是一个多智能体系统的例子，你可以让大语言模型（LLM）去分别扮演软件工程公司的 CEO、设计师、产品经理，或者测试员等角色。你只需要告诉 LLM，你现在是 CEO，你现在是软件工程师，然后它们就会开始协作，进行深入的对话。如果你告诉它们去开发一个游戏，它们会花几分钟来编写代码，测试，迭代，然后生成复杂程序。

对于未来的发展，吴老师提及了一些变化：

一方面人类会慢慢适应和智能体协作解决任务的新模式，很多任务不再像搜索引擎那样，你输入问题马上得到结果，而是异步的，你给 AI 提供一个任务，然后 AI 会去完成，完成后再通知你，类似于老板和员工的关系。

另一方面 AI 智能体的能力也会越来越强越来越快。

最后很喜欢吴老师的结束语：通向通用人工智能的道路更像是一段旅程，而不是一个目的地，但我认为这种智能体工作流可能帮助我们在这个非常长的旅程上迈出一小步。

原始视频： https://youtube.com/watch?v=sal78ACtGTc

完整视频文稿：https://baoyu.io/translations/transcript/whats-next-for-ai-agentic-workflows

### 107

2024-03-28

宝玉
@dotey
吴老师亲自讲“反思”这种设计模式，以下内容为转译

上周，我介绍了四种AI智能体工作流程的设计模式，我认为它们今年将大大推进技术进步：反思、工具使用、规划以及多智能体协作。不同于让一个大语言模型直接输出最终结果，智能体工作流程通过多次提示LLM，使其有机会逐步提高输出质量。此次，我想重点讲讲“反思”这一模式。它相对易于实施，但我发现它能带来出乎意料的性能提升。

你可能经历过这样的情况：向ChatGPT、Claude或Gemini提问，但得到的答案不尽人意，于是你提供关键反馈帮助LLM改进，最终获得更好的回答。如果这一提供关键反馈的步骤能自动化，让模型自我批评并优化输出呢？这正是“反思”策略的精髓所在。

以编程任务为例，我们首先让LLM直接生成完成特定任务X的代码。完成后，我们进一步引导它反思自身的输出，方式可能如下：

这是为完成任务X而编写的代码：
 [此前生成的代码] 
请细致审查代码的准确性、编程风格及效率，并提出改进意见。

这一过程有时能让LLM识别出问题并给出建设性的建议。之后，我们再次提示LLM，这次包括先前生成的代码和给出的改进意见，要求其根据反馈重新编写代码。这样的循环可能会带来更加精准的回答。通过不断的批评和重写，LLM能在包括编写代码、撰写文本、回答问题等多种任务上自我完善，发现并弥补不足。

而超越自我反思，我们还可以为LLM提供工具以帮助其评估输出。比如，通过运行一些单元测试来检查代码是否能在测试案例中得到正确的结果，或者搜索网络以验证文本输出的准确性。接着，它可以基于发现的错误进行反思，并提出改进方案。

此外，我们还可以采用多智能体框架来实施“反思”。通过创建两个不同角色的智能体——一个负责生成高质量的输出，另一个则专注于对前者的输出提出建设性批评，两个智能体之间的互动讨论促进了更佳的响应。

虽然“反思”是一种基本的智能体工作流程类型，但在实际应用中，我惊喜地发现它在一些案例中大幅提升了性能。我希望你也能在你的项目中尝试使用它。如果你对深入了解“反思”感兴趣，以下几篇论文值得一读：

-《Self-Refine: Iterative Refinement with Self-Feedback》, 由 Madaan 等人于 2023 年发表
-《Reflexion: Language Agents with Verbal Reinforcement Learning》, 由 Shinn 等人于 2023 年发表
-《CRITIC: Large Language Models Can Self-Correct with Tool-Interactive Critiquing》, 由 Gou 等人于 2024 年发表

未来，我还会介绍更多关于智能体设计模式的内容。

原文：https://deeplearning.ai/the-batch/issue-242/



### 108

2024-03-29

宝玉
@dotey
这是一段能帮你给代码生成单元测试的提示词，针对 Claude 3，但理论上来说可以适用于绝大部分模型。

分析一下这段提示词：

1. 借助 XML 标签，让文本提示词有了清晰的结构，能让大语言模型更好的理解你的指令。顺便说一下，Claude 3 对 XML 很友好，大部分高质量提示词的输出输出都是基于 XML 来组织的，现在我也经常借鉴这种技巧。

2. 有清晰的步骤，借助 CoT（链式思考 Chain of Though）的方式，让模型能按照一定的步骤来思考，每一步的结果又可以作为下一步的输入，得到高质量的输出结果。

- 首先，分析代码，弄清楚代码的作用、输入、输出及核心逻辑。这样可以保证不遗漏代码中的关键信息。
- 然后，列出一系列必要的测试用例，包括目的、输入、预期输出和测试类型。有了前面代码的分析，在写测试用例时就不容易漏掉关键的测试用例。
- 明确输出是表格的格式，确保输出的内容包含所有必须的信息
- 接着，为每个测试用例编写具体的测试代码，确保测试代码遵循准备、执行、验证的流程。有了前面的测试用例，就可以挨个写测试代码了，不会遗漏关键的测试代码。
- 明确要先写注释在写代码，这样其实相当于为每一段测试代码写好了单独的提示词。
- 对生成的结果进行复查，确保全面覆盖了所有场景。
- 最后，总结测试覆盖范围及通过这次测试计划活动获得的洞见。这一步其实可以省略，因为对模型来说已经意义不大，但是对于作者来说，可以帮助你更好的理解它为什么要生成这些测试用例。或许从中学到点东西。

3. 一开始就要说明指令的目标是什么，这样可以让模型更好的理解你的指令，生成更符合你预期的结果。

4. 至于一开始的角色设定，属于锦上添花，可以让生成结果时，更多的从语料库中挑选角色相关的内容。

这段提示词很好的展示了如何通过提示词来引导模型生成高质量的输出：

1. 你的指令要清晰，可以借助 XML 标签来组织你的指令。
2. 要充分利用 CoT，让模型按照一定的步骤来思考，每一步的结果又可以作为下一步的输入，得到高质量的输出结果。
3. 明确的输出格式，确保输出的内容按照你列的步骤执行，并且每一步都包含所有必须的信息。

## 以下是完整的提示词：

\<prompt_explanation>
你作为一名专家级软件测试员，负责对指定的代码片段进行彻底测试。你的目标是创建一套全面的测试用例，通过这些用例执行代码，发现任何可能的漏洞或问题。

首先，细致地分析提供的代码。弄清楚它的作用、输入、输出及任何核心逻辑或运算。深入思考所有可能需要测试的不同场景和边缘案例。

然后，头脑风暴，列出一系列你认为必须的测试用例，以彻底验证代码的准确性。对于每一个测试用例，在表格中明确以下信息：

- 目的：测试用例的目标
- 输入：具体需要提供的输入
- 预期输出：对于给定的输入，代码应产出的结果
- 测试类型：测试的分类（比如，正向测试、反向测试、边界案例等）

在以表格形式详细列出所有测试用例之后，针对每个案例编写具体的测试代码。确保测试代码遵循以下流程：

1. 准备：设置必要的前置条件和输入
2. 执行：运行待测代码
3. 验证：确保实际输出与期望输出一致

对于每项测试，都应清晰注释说明测试的内容及其重要性。

完成所有单独测试用例的编写后，进行复查，确保它们全面覆盖了所有场景。思考是否还需要添加额外的测试以确保全面性。

最后，总结测试覆盖范围

及通过这次测试计划活动获得的洞见。
</prompt_explanation>

<response_format>
<code_analysis_section>

<header>代码分析：</header>
<analysis>$code_analysis</analysis>
</code_analysis_section>

<test_cases_section>

<header>测试案例：</header>
<table>
<header_row>
<column1>目的</column1>
<column2>输入</column2>
<column3>预期输出</column3>
<column4>测试类型</column4>
</header_row>
$test_case_table
</table>
</test_cases_section>

<test_code_section>

<header>测试代码：</header>
$test_code
</test_code_section>

<test_review_section>

<header>测试回顾：</header>
<review>$test_review</review>
</test_review_section>

<coverage_summary_section>

<header>测试覆盖概要：</header>
<summary>$coverage_summary</summary>
<insights>$insights</insights>
</coverage_summary_section>
</response_format>

以下是你需要为其生成测试用例的代码：
<code>
将你的代码粘贴于此
</code>

---

https://x.com/dotey/status/1773398767628161265


### 109

2024-03-29

宝玉
@dotey
跟 GPT 一样，Claude 也支持 Mermaid 语言——一种用文本格式可以生成流程图，可以借助 Mermaid 生成文本格式的流程图。

### 110

2024-03-29

宝玉
@dotey
为什么大语言模型数学那么差都不能数清楚文本有多少单词？为什么连单词反转这样简单的事都做不好？

因为大语言模型只是根据预训练的结果预测 Token，所以它很难通过预测数清楚有多少单词。

正确的做法是借助外部工具，例如 GPT-4 会调用 Code Interpreter 写一段代码运行来借助代码算清楚。

### 111

2024-03-30

歸藏(guizang.ai)
@op7418
关于三种类型的专家混合模型 (Mixture of Experts, MoE) 的简短教程，包括预训练的 MoE、升级的 MoE 和 FrankenMoE。

作者还提供了推荐的论文列表，可以去原贴查看。

MoE 概述

MoE 使用稀疏的 MoE 层替换前馈层。这些层包含一定数量的专家(例如8个),每个专家都是一个神经网络(通常是前馈网络 FFN)。然后,一个路由器/门控网络负责挑选要使用哪些专家。MoE 具有以下特点:

- 预训练速度更快
- 根据激活参数的数量来看,推理速度更快
- 但如果你想让所有专家都加载到内存中,仍然需要大容量显存 VRAM

总的来说,就激活参数而言,MoE 往往优于具有相同参数数量的密集模型。

MoE 的例子包括:Switch Transformers、Mixtral、DBRX、Jamba DeepSeekMoE 等等。

预训练的 MoE

在固定的计算预算下,MoE 理论上可以比其密集对应物更快地达到相同的质量。这促使一些公司开始探索 MoE 预训练。

MoE 专家不是专门针对某个主题的。他们专门研究浅层概念或 Token 组。这是社区中一个常见的误解。

FrankenMoE

FrankenMoE 的灵感来自模型合并的大浪潮,并将其应用于 MoE。其思想是选择几个具有相同架构的微调模型,并从中构建一个 MoE。

它是如何工作的呢?假设你有一个性能非常好的代码微调模型和一个性能非常好的聊天微调模型。通过一些额外的训练(使路由器学会将每个 Token 发送到哪个专家),Token 被重新路由到相应的专家。

需要注意的是,这里我们有针对特定主题/任务的专家,这与预训练 MoE 的目标有很大不同。我对这种技术持保留态度,因为你失去了 MoE 的许多优势(不再有负载平衡)。

升级的细粒度 MoE

升级 MoE 的思想是选择一个已经训练过的基础模型(例如一个小型 Qwen 模型),并多次复制其前馈网络以创建多个专家。你甚至可以使用细粒度专家,这是 DeepSeek-MoE 引入的一个想法,意味着将前馈网络切割成更小的单元。这可以产生大量的小专家(甚至数百个专家),然后你可以控制要激活多少个专家。

初始化这个模型后,你就可以继续预训练,这应该需要更少的计算资源来实现高质量。




### 112

2024-03-30

歸藏(guizang.ai)
@op7418
一篇写的非常好的文章，详细介绍了如何对大语言模型的质量进行评估。

流程包括单元测试、人工评估、模型评估和 A/B 测试,强调快速迭代和数据管理的重要性。

一个好的测试流程是模型进步的必要条件，如果没办法准确测试模型质量，就没办法帮助模型进步。

👇下面是大致的内容整理，后面有全文翻译：

✲ 大语言模型产品的评估系统

评估系统对大语言模型(LLM)产品的成功至关重要。许多 LLM 产品之所以失败,根本原因在于未能创建健壮的评估系统。评估、调试和改进是 LLM 产品成功的关键,而良好的评估系统可以创造一个良性循环,加速产品的迭代和改进。案例研究中的 Lucy 就是一个典型的例子,它初期通过提示工程取得了进展,但后来遇到了性能瓶颈,需要建立系统的评估方法来突破瓶颈。

✲ 评估的类型

LLM 产品的评估主要分为三个层次:单元测试、人工评估和模型评估、A/B 测试。单元测试是通过编写一些断言语句,在开发过程中快速获得反馈。人工评估和模型评估是通过人工检查和训练评估模型来评估整个系统。A/B 测试则用于确保 AI 产品能够驱动期望的用户行为或结果。除了评估整个系统,还需要对子组件如 RAG 进行单独评估。

✲ 单元测试的步骤

单元测试是 LLM 产品评估的基础,通常包括三个步骤:编写特定范围的测试、创建测试用例和定期执行测试并追踪结果。编写测试时要针对 LLM 的不同功能和场景,检验相应的断言。可以利用 LLM 自动生成测试用例,触发不同的场景。测试应当定期执行,利用 CI 基础设施可以很方便地实现自动化测试和结果跟踪。测试通过率并不一定要达到100%,而是要在错误容忍度和产品目标之间取得平衡。

✲ 人工评估和模型评估

人工评估和模型评估是更高层次的测试手段。首先要记录 LLM 系统的跟踪数据,包括用户的输入和系统的响应,为后续分析提供数据基础。在查看数据时,定制化的查看工具和良好的可视化非常重要。将人工评估结果与评估模型的预测对齐,可以极大提高评估的效率。随着评估模型性能的提升,可以渐进式地用自动评估来替代人工评估。

✲ 微调和数据合成与管理

评估系统所积累的数据和流程,可以很自然地应用到 LLM 产品的微调和数据管理中。微调最关键的是数据质量,而评估系统可以通过筛选、清洗、合成等手段来生成高质量的微调数据。评估系统中记录的跟踪数据、断言规则、人工反馈等,都可以直接用于微调数据的管理。总的来说,评估基础设施和微调及数据合成所需的基础设施有很大重叠。

✲ 调试

LLM 产品的调试也可以受益于评估系统。理想的评估系统应该能够支持快速定位错误,找到问题的根本原因。其中的关键是丰富的跟踪数据、可以标记错误的机制、高效的日志搜索和导航工具等。此外,系统的设计应当允许快速测试解决方案并验证有效性。总之,调试和评估所需的基础设施在很多方面是共通的。




### 113

2024-03-30

小互
@imxiaohu
微软和 OpenAI 计划建造价值1000亿美元的星际之门人工智能超级计算机

据三位参与过该计划私下对话的人士透露，微软和OpenAI的高管一直在为一个数据中心项目制定计划，该项目将包含一台超级计算机，配备数百万个专用服务器芯片，为OpenAI的人工智能提供动力。

据一位与 OpenAI CEO Sam Altman交谈过的人士和一位看过微软初步成本估算的人士称，该项目成本可能高达1000亿美元。

微软可能将负责为该项目提供资金，其成本将是目前一些最大数据中心的100倍，这表明未来几年为人工智能建立计算能力可能需要巨额投资。

微软高管设想，拟在美国建造的这台超级计算机（他们称之为“星际之门"）将是微软未来六年内计划建造的一系列设施中最大的一个。

https://theinformation.com/articles/microsoft-and-openai-plot-100-billion-stargate-ai-supercomputer




### 114

2024-03-30

宝玉
@dotey
吴恩达老师之后，LangChain 作者 Harrison 也谈了 AI 智能体，在这个问题上我相信他还是很有发言权的，毕竟作为最流行的 AI 开发框架之一，借助 LangChain 开发 AI 智能体是一个很常见的需求，并且 LangChain 也在这方面做的很不错。

Harrison 提到了智能体的三个方面：任务规划、用户体验和记忆功能。

1. 规划

之前吴老师也提到过，规划其实就是让大语言模型对复杂的任务进行推理，然后分解成可以执行的若干步骤，并调用相应的 AI 智能体或者工具执行，在这个过程中，还会引入反思对规划进行完善和对结果进行校验。

但是目前 AI 的规划还不可靠，需要依赖提示词工程和流程工程，未来也许会内化为模型自身的能力。

2. 用户体验

在 AI 智能体执行任务的过程中，人的参与仍然是必要的，因为智能体还不够可靠。但是这里面的平衡也很重要，既不能让人参与过多，也不能完全由智能体自主操作。

前不久很火的 AI 编程产品 Devin 就做了一个很好的用户体验设计示范，它提供了月光宝盒这样回到过去某个时间点修改的功能，大部分时间都可以 AI 自主编程，需要的时候才介入。

3. 记忆功能

智能体的记忆功能非常重要。只有当智能体有记忆了，才能真正的成为你的私人助理，记住一些你的个人喜好和特定的操作。

Harrison 的分享时间比较短，甚至于任务规划、用户体验和记忆功能这三个方面他也没有明确的答案也在探索中，但提出正确的问题往往就是解决问题的关键！

视频来源：https://youtube.com/watch?v=pBBe1pk8hf4&t=125s

### 115

2024-03-30

宝玉
@dotey
OpenAI 的一篇新的博客，讲述了他们在探索合成语音是遇到的挑战与机遇。

其实 OpenAI 在 2022 年末就开发了 Voice Engine，并以此为文本到语音 API、ChatGPT Voice 和 Read Aloud 提供预设语音。但是因为担心被滥用，所以只是在去年末和一小批合作伙伴进行了测试，主要用途在：
1. 儿童读物
2. 视频、播客的多语言版本，并且能保持说话者的口音
3. 结合 Voice Engine 和 GPT-4，帮助社区提供语音咨询服务
4. 帮助失语者说话

由于担心滥用，做了很多安全措施：
1. 必须明确说明声音是合成的
2. 有黑名单，防止克隆公众人物声音
3. 有水印，可以检测监控

暂时还没有对外开放，只是提供了预览演示。

原文：https://openai.com/blog/navigating-the-challenges-and-opportunities-of-synthetic-voices

全文翻译：https://baoyu.io/translations/openai/navigating-the-challenges-and-opportunities-of-synthetic-voices



### 116

2024-03-30

向阳乔木
@vista8
感谢宝玉老师分享，学习总结下：

Andrew Ng认为 AI Agents 代表了人工智能的未来发展方向。

输入Prompt 让大模型生成文章，就像让一个人写作，但不能用回退键（删除修改）。

AI Agents 的工作方式跟人类更像：先对任务进行推理思考，对初版结果进行检查修改，持续迭代几轮后，给出终版输出。

Andrew Ng发现用 GPT-3.5配合Agentic工作流，性能竟然超过单独使用 GPT-4。

Andrew 认为AI Agents 有四种设计模式：

1️⃣ 反思（让模型检查和修正自己的输出）
2️⃣ 工具（调用搜索、代码执行等外部工具）
3️⃣ 规划（拆解复杂任务，制定执行计划）
4️⃣ 多 Agent 协作（让模型扮演不同角色，通过协作完成任务）

Andrew Ng的想法预测：

1️⃣ Agentic工作流的出现，语言模型的能力有望在今年得到显著提升。

2️⃣ Token生成速度变得至关重要，甚至比大模型能力提升更重要。（LLM要生成大量token来自己阅读和推理，速度越快越好）

3️⃣ 用Agentic方法，要忍受交互时延（可能要等几分钟或几小时才出结果），让模型花更多时间推理和迭代。

Andrew Ng对GPT-5、Claude-5、Gemini2充满期待。

但他认为在Agentic方法加持下，未必要等到最新最强的模型才能体验到交互式AI的威力。

通用人工智能(AGI)仍然是一个遥远的目标，但Agentic工作流无疑是通往AGI的重要一步。



### 117

2024-03-30

歸藏(guizang.ai)
@op7418
发现一个讲的很细的大语言模型微调教程，详细介绍了整个流程,包括数据准备、参数设置、资源监控等关键步骤。

基本没有技术能力也可以完成微调。想要了解 LLM 原理的可以按这个实践一下。

时间轴：

0:00 概念概览 
3:02 自定义数据的准备 
8:17 微调操作演示（T4 版本） 
16:52 微调操作演示（A100 版本） 
19:13 在 Hugging Face 上的保存与使用方法

文字版整理：

✲ 如何使用自己的数据对大语言模型进行微调(fine-tuning)：

对大语言模型进行微调并不一定非常困难和昂贵。通过使用自己的数据集对预训练模型进行微调,可以让模型更好地适应特定的任务需求。微调过程能够在保留原模型语言理解能力的基础上,进一步提升其在特定领域或任务上的表现。

✲ 使用Hugging Face模型库和Unslaw工具进行模型微调：

Hugging Face提供了丰富的预训练语言模型资源,用户可以根据任务需求选择合适的模型作为基础进行微调。而Unslaw工具则提供了一套简单高效的微调流程,其优点包括出色的内存使用效率以及对扩展上下文窗口的支持。通过Unslaw,用户能够以较低的资源开销完成模型微调。

✲ 在Google Colab上使用免费/付费GPU资源进行微调：

Google Colab提供了免费和付费的GPU资源,用户可以根据任务的复杂程度选择使用T4或A100。对于大多数微调任务而言,免费的T4资源已经足够。但如果数据集较大或模型较为复杂,升级到A100可以获得更充裕的算力支持。Colab为用户提供了一个易于上手的模型微调环境。

✲ 准备自定义的微调数据集：

准备微调数据的过程并不复杂。用户可以直接使用纯文本文件作为数据来源,而无需进行额外的预处理。为了获得理想的微调效果,建议至少准备100-200个样本。在示例中,为了快速演示,仅使用了几个样本。通过一个简单的Python脚本,可以方便地将原始文本数据转换为微调所需的JSON格式。

✲ 修改Colab笔记本中的参数设置：

在Colab笔记本中,需要根据实际情况调整一些参数。例如,可以根据数据集的token数量来设置max_sequence_length参数,借助rope scaling技术,模型能够支持任意长度的上下文。此外,还可以选择使用Instruct系列模型作为base model,直接在其基础上进行指令微调。为了节省资源,可以启用4-bit量化。同时,参考Q-Lora论文的建议,调整R值和alpha值,以在资源占用和模型质量之间取得平衡。

✲ 训练过程中的资源使用监控：

在模型训练过程中,用户可以通过Colab的资源监控选项卡实时观察GPU、内存和硬盘的使用情况。如果发现资源不足,可以考虑从T4升级到A100。通过监控资源占用,用户能够及时调整配置,确保微调任务稳定高效地进行。

✲ 模型训练的loss变化和最佳checkpoint的选择：

通过记录不同训练步数下的loss值,可以判断模型的收敛情况。理想的做法是选择loss下降曲线趋于平缓的点作为最佳checkpoint,这样既能充分训练模型,又能避免过拟合。为了事后方便筛选,可以设置每隔一定步数保存一次checkpoint。

✲ 模型微调完成后的保存与使用：

微调完成后,可以选择只保存adapter layers以加快保存速度。但更推荐的做法是保存完整模型,并使用float16精度,这样可以得到一个更通用和标准的模型格式,方便后续的部署和使用。

✲ 在Hugging Face上公开或私有发布微调后的模型：

用户可以选择在Hugging Face的模型库中公开或私有地发布自己微调后的模型。发布之前,需要在Hugging Face账号中创建一个访问令牌,并在发布时提供相应的用户名和令牌信息。通过在Hugging Face上发布模型,用户可以方便地与他人分享自己的微调成果。

✲ 使用微调后的模型进行推理(inference)：

在使用微调后的模型进行推理时,首先需要加载保存的模型。接着,使用tokenizer对输入的文本进行处理,并将其传入模型。进行推理时,max_length参数需要与训练时保持一致,以确保生成的结果不会被截断。完成以上步骤后,就可以利用微调后的模型进行各种实际应用了。



### 118

2024-03-30

宝玉
@dotey
有人问我为什么我这篇《Sora 初体验》 的翻译结果比他用科技文章翻译 GPT https://chat.openai.com/g/g-uBhKUJJTl-ke-ji-wen-zhang-fan-yi 的结果好？

> 问：同样一篇文章，使用您的科技文章翻译 GPTs，意译的结果和您分享的，差距还是很明显。比如，Sora 那篇文章的第一句，原文：We have gained valuable feedback from the creative community, helping us to improve our model. 意译：我们从创意界获得了极其宝贵的反馈，这些反馈极大地助力了我们模型的改进工作。您的：我们从创意界得到了极具价值的反馈，这对我们模型的完善大有裨益。您是如何做到的？

回复：

其实我就是用科技文章翻译 GPT 翻译的，但是以下因素会影响翻译结果：

1. 模型本身的随机性会导致翻译结果有所不同，有时候很惊艳，有时候平平无奇！
2. 文本长度会影响翻译结果，每次让它翻译的少一点效果会好很多。
3. 事后必要的人工检查修改也是必要的。

比如你看截图，这篇文章我每次其实只是让它翻译了一小段，自然效果好很多。



### 119

2024-03-30

Tony Zhu
@tonyzhu1984
最近这个开源项目星星升得很猛，用Next.js打造一个Perplexity AI搜索引擎。代码完全开源（MIT），作者还有YouTube手把手教学视频，可以拿来练手学习开发AI应用。