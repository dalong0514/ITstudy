### 01

小互 @xiaohuggg 2023-12-03

3D 可视化展示 GPT 模型的工作方式

@BrendanBycroft

创建了一个网页来可视化大语言模型（LLM），类似 ChatGPT 背后的那种 Transformer 模型的内部结构和运作方式。

这个网页以 3D 形式呈现，展示了像 GPT 这样的大语言模型在运行单个令牌推理的所有步骤及其工作原理。

Brendan Bycroft 制作的这个项目可以用来展示不同大小的人工智能模型，比如 GPT-2 这种相对较小的模型。

但是因为更大的模型（比如 GPT-3）需要处理和存储非常多的数据，所以这个项目没有包含这些大模型的全部数据。

传送门：https://bbycroft.net/llm

左键拖动，右键旋转，滚动缩放。并将鼠标悬停在张量单元上。

蓝色单元格是权重 / 参数，绿色单元格是中间值。

每个单元格都是一个数字！

而且他还开源了这个项目

GitHub：https://github.com/bbycroft/llm-viz

这个项目还有个 CPU 模拟（CPU Simulation）展示。

它提供了一个 2D 环境，你可以在其中编辑和模拟 CPU（中央处理单元）的工作原理。

你可以在这个编辑器中创建和修改数字电路，这些电路模拟了真实 CPU 的工作方式。

### 02

宝玉 @dotey 2023-12-03

语音到语音翻译 (S2ST) 是一种将口语从一种语言转换为另一种语言的机器翻译技术。

谷歌刚推出新一代的语音到语音翻译技术 Translatotron 3，它与前两代的不同在于是无监督学习的。传统的有监督学习，需要使用标记的训练数据，举例来说，你输入是英文音频，那么需要有配套的中文音频。这样数据的数量和质量很难上去。

但是对于无监督的语音到语音翻译（如 Translatotron 3）来说，模型不需要双语对照的数据集，而是从未标记的单语数据中学习如何将一种语言翻译成另一种语言。

### 03

宝玉 @dotey 2023-12-03

推荐阅读：《行动产生信息 [译]》

https://baoyu.io/translations/ideas/action-produces-information

原文：Action Produces Information

https://commoncog.com/action-produces-information/

部分内容摘录：

这篇博客文章的标题源于 Brian Armstrong，Coinbase 的创始人兼 CEO。在他与投资者 Patrick O'Shaughnessy 的采访中，Armstrong 提到：

> 其实你做什么并不重要，关键是要采取行动。正如我最喜欢的一句话，「行动产生信息」所言。因此，在某个时刻，你必须停止无休止的思考，开始尝试一些事情，任何事情。你可能会为第一个版本（V1）感到尴尬，但这正是你走出去并开始创造的时刻。产品开发过程的一部分就是大幅度缩减初衷和功能，以便快速迭代和原型化，但关键是要开始行动。你的第一次尝试几乎肯定会失败，所以不要气馁，继续尝试下一个方案，然后是下一个，再下一个。这是世界上新产品和公司得以诞生的唯一方式。你需要尝试许多次，才能最终取得成功。

…

Scott Berkun 在他的著作无裤之年中，资深产品经理 Scott Berkun 分享了他在 Automattic 团队中做出的一项关键决策：

> 其中一个原因是，完美决策公式之所以不存在，是因为你永远无法确定自己是否投保过多或过少。你是否选择了正确的医生？提出了合适的问题？有时候，你可能以错误的方式做出了正确的决策。我们的计划 B 存在的一个风险是两周时间可能远远不够。我们可能需要数月时间来改进哪怕是最微小的弱点。这种不确定性引发的恐惧会使人们沉浸在对所有可能结果的思考中，甚至使用效用成本分析这样的复杂方法在电子表格中进行计算，而这种方法连发明者本人都不会使用。

> 但所有这些分析其实只是让你停滞不前。往往，抛个硬币，选择一个明确的方向前进会是更好的选择。一旦你开始行动，无论目标是什么，你都将获得新的信息。这些新的信息会使得你的下一个决策和之后的决策，比在原地试图预测未来而不采取行动要更加明智。

…

克莱因在他的著作中这样描述：

> 假如你面临两个选择，一个极好，另一个极差，你根本不需要多想。这是个简单的决定。但当这两个选择的吸引力越来越接近时，决定就变得更加困难。(...) 以购买二手车为例，我们可以发现三个选择非常相似 —— 它们都有各自的优缺点。它们之间没有太多的区别。这些选择非常接近，以至于抛硬币就足以决定。(...) 我称这种情况为‘冷漠区'问题。

> 我们通常认为，决策的目的总是要找到最佳选择。在战场上或消防现场这种生死攸关的地方，决策尤其重要。然而，军事领导和消防指挥官都明白，迅速做出一个好的决定并且有效执行它，比纠结于寻找「完美」的选择要好得多，因为完美的选择往往来得太晚。我们很难知道哪个是最好的选择，而寻求最佳选择可能会让我们纠结于那些微不足道的细节。我们有多少次为了找到最好的选项而陷入毫发之差的纠结中？不如把目标定为选择一个可以接受的好选项。如果有一个选项明显胜出，那当然好。但如果两个或更多的选项都在「冷漠区」，那也没关系 —— 随便挑一个继续前进。如果你能接受没有「正确」选择的现实，就可以避免不必要的困扰和时间浪费。

…

贝索斯提出了一个相似但更为简洁的决策原则：如果决策可逆，就迅速采取行动并下放决策权；如果决策不可逆，则可以尽情进行分析。他在 2015 年给股东的信中这样解释这个规则：

> 一些决策具有重大影响且几乎不可逆转 —— 就像单向门一样 —— 这些决策需要有条理、谨慎、缓慢地作出，需要经过深思熟虑和咨询。如果你走过去，发现另一边不符合预期，你就无法回到原点。这些我们称之为类型 1 的决策。

> 然而，大多数决策并非如此 —— 它们是可以改变、可逆的 —— 就像双向门。如果你作出了不太理想的类型 2 决策，你不需要承担太长时间的后果。你可以重新打开门，回到原来的地方。类型 2 的决策应由具有高度判断力的个人或小团队迅速作出。

> 当组织规模扩大时，似乎有一种趋势，即在大多数决策上，包括许多类型 2 的决策，都采用繁琐的类型 1 决策过程。这种做法的最终结果是行动迟缓、缺乏深思熟虑的风险规避、不足够的实验尝试，因此创新受限 *。我们必须找出方法来对抗这种趋势。

> * 相反的情况不太引人注意，而且无疑存在一定的幸存者偏差。那些习惯于用轻量级的类型 2 决策过程来处理类型 1 决策的公司，在变得庞大之前就已经消亡了。

### 04

宝玉 @dotey 2023-12-03

推荐阅读：当 AI 无需联网，一切皆有可能 [译]

未来，个性化的 AI 助手将可以在边缘设备上离线运行，将衍生出很多出人意料的创新

https://baoyu.io/translations/ai/when-ai-unplugs-all-bets-are-off

原文：When AI Unplugs, All Bets Are Off

> Run natively on edge devices, personalized AI assistants will get wild, and weird, soon

https://spectrum.ieee.org/personal-ai-assistant

### 05

小互 @xiaohuggg 2023-12-03

DeepMind：通过 AI 发现了数百万种新材料

DeepMind 利用其深度学习工具：GNoME，发现了超过 220 万种新的晶体材料。

这相当于近 800 年来人类所积累的知识量。

其中，大约 38 万种被认为是稳定的。

这展示了 AI 在新材料方面前所未有的预测规模和准确性。这将推动材料发现革命。

DeepMind 公开了他们发现的这些新材料的数据，这样其他科学家就可以用这些信息来进行自己的研究和实验。

这项工作展示了利用人工智能在材料科学领域进行创新和发现的巨大潜力。

主要发现和成就：

1、新晶体的发现：GNoME 预测了 220 万种新晶体，其中 38 万种被认为是最稳定的，是实验合成的有希望的候选材料。

2、潜在应用：这些材料有潜力用于开发未来变革性技术，如超导体、超级计算机和下一代电池，以提高电动汽车的效率。

3、AI 在材料发现中的潜力：GNoME 展示了使用 AI 在大规模上发现和开发新材料的潜力。全球实验室的外部研究人员已经独立地实验制造了其中的 736 种新结构。

GNoME 的工作原理：

1、图神经网络（GNN）：GNoME 使用了一种称为图神经网络的先进 AI 技术。这种网络模拟了原子间的连接，非常适合用于分析和预测晶体材料的结构和稳定性。

2、数据训练：GNoME 最初使用从 Materials Project 等公开数据库中获取的关于晶体结构和稳定性的数据进行训练。

3、结构和组成流程：GNoME 通过两个主要流程来发现新材料。结构流程基于已知晶体的结构创建候选物，而组成流程则基于化学公式进行更随机的探索。

4、密度泛函理论（DFT）计算：GNoME 的预测结果会通过密度泛函理论进行评估，这是一种在物理、化学和材料科学中用于理解原子结构的计算技术。

5、主动学习：GNoME 采用了一种称为「主动学习」的训练过程，通过这个过程，AI 生成的晶体结构预测被 DFT 测试，然后将高质量的训练数据反馈到模型中，从而提高预测的准确性。

GNoME 意义：

1、加速材料发现：GNoME 能够快速预测新材料的稳定性，这比传统的实验室方法快得多，也更高效。

2、扩大材料数据库：GNoME 的发现大大扩展了人类已知的稳定材料数量，从而为未来技术的发展提供了更多可能性。

3、推动技术创新：GNoME 发现的新材料可能用于开发新的超导体、电池和其他先进技术，这对于推动科技进步和解决能源问题具有重要意义。

4、促进科学研究：DeepMind 公开了 GNoME 的发现，使全球科学家可以利用这些数据进行进一步的研究和实验，加速材料科学的整体进展。

GNoME 的开发和应用不仅展示了 AI 在材料科学中的巨大潜力，而且为未来的科技创新和可持续发展打开了新的可能性。

数据库发布：

DeepMind 已经向研究社区发布了新发现的晶体数据库，提供了新候选材料的完整目录，帮助科学家测试并可能制造最佳材料。

详细：https://deepmind.google/discover/blog/millions-of-new-materials-discovered-with-deep-learning/

Nature 论文：https://nature.com/articles/s41586-023-06735-9

下载数据集：https://github.com/google-deepmind/materials_discovery

### 06

小互 @xiaohuggg 2023-12-03

Excalidraw 把他们的文本到图表的功能开源了

@Excalidraw

是一个虚拟白板应用，专门用于绘制类似手绘的图表。它提供了一个无限的、基于画布的白板，具有手绘风格，支持多种功能。

新更新允许用户输入文本描述，将其自动转换为相应的图表或图形。

GitHub：https://github.com/excalidraw/excalidraw

在线体验：https://excalidraw.com

### 07

宝玉 @dotey 2023-12-03

纽约时报：Sam Altman，探讨人工智能的未来挑战

2023 年 12 月 2 日，作者：Maureen Dowd

在《黄昏地带》这部剧中，我最喜欢的一集是外星人来到地球，带来了一本书作为和平的象征。这本书让政府的密码专家费尽心思去翻译。他们首先译出了书名：「To Serve Man」，似乎预示着一切都是安全的，人们甚至开始乘坐星际穿梭航班。

然而，随着翻译的深入，他们震惊地发现，这本书竟然是一本食谱。

这个故事与 OpenAI 的历史颇有相似之处。

OpenAI 成立于 2015 年，初衷是作为一个非营利组织，保护人类不受日益发展的人工智能技术的威胁。他们的目标是确保这项技术有足够的安全措施，就像在人工智能成长的关键时期设置一个紧急制动按钮。

当我 2016 年在他们旧金山的临时办公室采访 OpenAI 的创始人 Sam Altman、马斯克、Ilya Sutskever 和 Greg Brockman 时，他们自称是我们的守护者，保护我们免受失控、邪恶人工智能的威胁。他们面对的是滥用技术的不法分子和恶劣的机器人，以及那些幻想着像玛丽·雪莱一样创造出新物种的云端领袖们。

Sutskever 当时表示：「我们的目的绝不是为了个人利益。」

Brockman 的想法也很崇高：「我们不能只是发明这项技术，然后就撒手不管。我们的工作不是这样结束的。我们需要让世界理解并妥善使用它。」

但现在 OpenAI 正在面临新的挑战。马斯克已经离开，Altman 不再是那个站在人类一边的守护者。他现在正领导着一家盈利公司，专注于开发人工智能的潜能。他对投资者的兴趣超过了对潜在危险的关注。正如 Robert Oppenheimer 所说：「当你发现某项技术非常有吸引力时，你就会去实现它。」

虽然政府试图细微调整监管政策，但 AI 技术的发展速度远超过慢吞吞的立法者和官僚。在硅谷，似乎没有人知道该如何控制这股势头。

OpenAI 最近的一次混乱事件，看似荒唐，实际上却揭示了一个可怕的事实：我们完全受制于硅谷那些拥有先进玩具的年轻人，他们的自我、脾气、野心和贪婪在不断碰撞。

关于马斯克最近的行为失控，大家的看法各异 —— 无论是他的狂热情绪，具争议的推文，还是他设计的奇特、棱角分明的 Cybertruck 卡车。但不可否认的是，他始终热衷于抵制恶意 A.I.。为了实现 A.I. 发展与保护人类价值观相协调这一可能有些理想化的目标，马斯克经历了不少不眠之夜和友情的破裂。

马斯克力邀俄罗斯籍顶尖工程师 Ilya Sutskever 从谷歌加盟 OpenAI，这让谷歌联合创始人、AI 加速主义者 Larry Page 感到愤怒，最终与马斯克决裂。Page 认为马斯克偏袒人类，在 AI 问题上持有「物种主义」观点。

马斯克还与 Altman 发生了冲突。正如 Walter Isaacson 在《Elon Musk》一书中所述，马斯克曾在二月份召见 Altman，并要求他带来 OpenAI 的创始文件。不久后，马斯克在 Twitter 上表示困惑：「我捐赠了 1 亿美元的非营利组织，怎么可能变成了市值 300 亿美元的营利公司？如果这是合法的，那为什么不是每个人都这样做呢？」

在接受 Kara Swisher 采访时，Altman 称马斯克为「混蛋」。

正如莎士比亚所描绘的那样，个性冲突在 AI 领域的生死斗争中扮演了重要角色。Altman 减少了 Sutskever 在公司中的作用，这可能是引发对他的反叛的导火索。

关于这一事件的具体细节，我们仍然一无所知。是不是董事会发现了 AI 算法的某些重大进展，从而决定解雇 Altman，因为他们担心他在没有充分考虑安全措施的情况下推广产品？

显然，AI 技术正在变得更加精湛，推理能力加强，错误减少，幻想现象（即编造事实）减少，甚至能够解决复杂的数学难题。

马斯克最近对 Sutskever 表示赞赏，认为他具有「良好的道德指南针」。这位年轻工程师曾加入董事会的悲观派，并在改变主意前向 Altman 传达了坏消息。他在谷歌的导师 Geoffrey Hinton 是否对他产生了影响？

人工智能之父 Hinton 对 OpenAI 的杰作 ChatGPT 感到震惊，他意识到我们可能离 A.I. 智能超越人类只有几年时间。Hinton 在 10 月接受《60 分钟》（60 Minutes）采访时表示忧虑，担心 A.I. 可能会恶意地反抗人类，利用它从所有书籍中学到的知识操纵我们，包括马基雅维利（Machiavelli）的著作。

与马斯克不同，后者据 Isaacson 描述，有时会显得尴尬甚至进入「恶魔模式」，Altman 在与投资者、技术人员和立法者的交流中显得更为自如，即使是穿着 T 恤和牛仔裤也自在从容。一位硅谷顶尖科学家将 38 岁的 Altman 描述为「奇特地可爱」。他与众多记者关系良好，成为了 A.I. 未来乐观面孔的代表。

但我们真的需要一个对 A.I. 抱有阳光态度的人吗？不，尤其是考虑到马斯克上周四的警告：「世界末日可能随时到来。」

原文：Sam Altman, Sugarcoating the Apocalypse

https://nytimes.com/2023/12/02/opinion/ai-sam-altman-openai.html

### 08

宝玉 @dotey 2023-12-03

FT 的预测：2024 年将迎来哪些客户体验的新趋势？

品牌正在认识到对话、AI 驱动方案和「物理数字」体验的重要性，这意味着消费者明年将享受到更加个性化、流畅和愉悦的交互体验。

技术创新不断推动商业领域的发展，2024 年将成为客户体验的转型之年。品牌们正在调整战略，将客户的愉悦放在首位。下面是一些值得关注的主要趋势。

** 企业和品牌的全方位对话旅程

消费者越来越希望通过他们日常使用的渠道和聊天应用（如与家人朋友沟通时使用的）与企业或品牌进行双向对话。他们期望的是一种连贯的体验，而不是在不同设备和渠道之间频繁切换。

品牌正在通过对话视角重塑这一旅程。在这种模式下，用户的大部分旅程都通过如 WhatsApp 这样的单一聊天应用或数字渠道完成。现在，重点从简单使用这些渠道转向打造完整的对话体验。

我们将看到真正的全方位平台的兴起。比如，在 Instagram 上看到广告，用户可以通过点击了解产品，完成购买，支付，接收交货通知，在 WhatsApp 的同一对话线程中完成满意度调查。

META 正在通过 WhatsApp 推动这场变革，推出了如 Flows 和 Payments 等新功能，使用户能够从 Instagram 广告到购买，实现平台内的无缝过渡。谷歌、苹果以及 Line、Kakao、Zalo 等地区领导者也在努力，预计更多平台将加入这一趋势。

** 从生成式 AI 转向交互式 AI

生成式 AI（Gen-AI）今年在客户支持领域取得了显著进展，特别是在自动生成消息和电子邮件内容方面。AI 驱动的机器人能够处理基础性咨询。

但未来属于交互式 AI。Mustafa Suleyman 表示：「未来的机器人将能够完成您设定的任务，通过调用其他软件和人员来完成工作。」

我们将看到不同的机器人和 AI 算法相结合，它们将在客户旅程中触发不同的动作。

这些高级工具将成为市场营销和销售自动化的核心，处理与产品相关的咨询、安排配送和管理支付。这些集成将从生成营销内容到提供 AI 驱动的聊天机器人互动，确保在客户偏好的渠道内提供流畅、类人的对话。

** 超级应用的崛起

近年来，无论是 WhatsApp 还是 WeChat，我们都见证了所谓「超级应用」的迅猛发展。这些平台拥有数以亿计的用户，为各大品牌融合并提供产品和服务提供了难得的机遇。马斯克对 WeChat 的描述是：「集 Twitter、PayPal 及其他多项功能于一体，界面极佳的综合应用」。

Telegram 正在向这一模式迈进，今年九月宣布开发者现在可以利用 JavaScript 创建极具灵活性的界面，这些界面可以直接在 Telegram 中启动，甚至完全取代传统网站。

这些应用被视为多功能中心，预计到 2024 年，用户将能在这些平台上与众多品牌无缝互动。

** 虚拟现实与增强现实的复兴

虚拟现实 (VR) 和增强现实 (AR) 正在迅速发展。Meta 最近推出了新一代 Ray-Ban Meta 智能眼镜，集成了 Meta 的 AI 驱动的先进对话助手。用户只需说出「嘿 Meta」，就能激活与 Meta AI 的互动，从而激发创意、获取信息并控制各种功能。苹果也发布了备受瞩目的 Vision Pro 混合现实头戴设备，它既能提供 VR 体验，也能提供 AR 体验。

这些产品代表了 AR 和 VR 领域的一大进步，此前这两项技术常被看作是略显花哨的噱头。我们预计，VR 和 AR 将从简单的公关手段转变为实际应用。利用这些工具，企业和品牌能够在物理世界无法比拟的规模上，创造出令人惊叹的非凡体验。

** 物理与数字融合体验

在当前的背景下，我们预见实体和数字世界将进一步融合，企业和品牌将创造出根据客户实时偏好定制的沉浸式「物理与数字融合（Phygital）」体验。零售商将进一步将科技整合到他们的实体店铺中，通过数据定制消费者的听觉、嗅觉和视觉体验。与此同时，电商平台将充分利用虚拟现实和增强现实的潜力，开创数字零售的新纪元。

已经有很多这样的实例。比如，零售品牌马克斯 & 斯宾塞的增强现实 (AR) 购物应用就允许消费者在店内使用 AR 滤镜，直接引导他们找到特定商品的位置。

随着技术的发展，这将帮助消费者在购买前就能像实际拥有产品一样体验它们，从而做出更明智的购买决策。

** 未来更多精彩

明年对于客户体验来说将是充满激情的一年。品牌正在逐渐认识到对话界面、AI 驱动的解决方案以及物理与数字融合体验的强大影响力，消费者可以期待享受到更个性化、流畅和愉悦的互动体验。

原文：What will be the key trends in customer experience for 2024?

https://ft.com/partnercontent/infobip/what-will-be-the-key-trends-in-customer-experience-for-2024.html

### 09

宝玉 @dotey 2023-12-05

能够让大模型推理结果变得更好的基础优化手段已经非常多了，我梳理了常见的技术手段和对应的论文：

- Zero-shot：https://arxiv.org/abs/2109.01652

- Few-shot：https://arxiv.org/abs/2005.14165

- CoT：https://arxiv.org/abs/2201.11903

- ToT：https://arxiv.org/abs/2305.10601

- GoT：https://arxiv.org/abs/2308.09687

- SC：https://arxiv.org/abs/2203.11171

- Multi Persona：https://arxiv.org/abs/2307.05300

- Least to Most：https://arxiv.org/abs/2205.10625

- Step Back：https://arxiv.org/abs/2310.06117

- ART：https://arxiv.org/abs/2303.09014

- ReAct：https://arxiv.org/abs/2210.03629

- Reflection：https://arxiv.org/abs/2303.11366

- RAG：https://arxiv.org/abs/2005.11401

以上内容在之前的分享中均详细提到过，有一些只需要在 Prompt 上做简单优化便可看到效果；有一些则需要进行框架设计，如对任务进行规划、分解、组合等，包括与外界环境的交互、让人参与交互，存在一定的设计成本，市面上很多 XXXGPT 也是对这些基础手段组合后的工程实践。

学习这些知识的原理有助于帮助我们打开 LLM 推理黑盒，感兴趣的朋友不妨花点时间研究下，也欢迎留言补充更多有趣的技术和论文。

### 10

宝玉 @dotey 2023-12-05

ChatGPT 类系统是如何运作的呢？

让我们通过下面的图解来探索它的运作机制。整个过程主要分为两大部分。

1. 训练过程。要打造一个 ChatGPT 模型，我们需要经历两个关键阶段：

- 预训练：在这一阶段，我们会对一个 GPT 模型（一种仅包含解码器的 Transformer）进行训练，使用大量的互联网数据。我们的目标是培养出一个能够基于已有的句子预测出下一个词汇的模型，这个预测不仅在语法上要正确，而且在语义上要与互联网上的内容相吻合。预训练阶段完成后，模型能够补全给定的句子，但还不足以应对提问。

- 微调：这一阶段是一个三步骤的过程，目的是将预训练好的模型转化为一个能够回答问题的 ChatGPT 模型：

1）收集训练用的数据（包括问题和答案），并在这些数据上对预训练模型进行微调。模型学习如何根据问题生成与训练数据类似的答案。

2）进一步收集数据（问题和多个答案），并训练一个奖励模型，用于将这些答案按照相关性进行排序，从最相关到最不相关。

3）运用强化学习（PPO 优化）对模型进行微调，以提高模型回答问题的准确性。

2. 回答问题

🔹步骤 1：用户提出一个完整的问题，例如「解释一下分类算法是怎么工作的」。

🔹步骤 2：这个问题首先被送往内容审核组件。该组件确保问题不违反安全准则，过滤掉不恰当的问题。

🔹步骤 3-4：如果问题通过内容审核，它就会被送到 ChatGPT 模型处理。如果未通过审核，则直接生成模板式的回答。

🔹步骤 5-6：模型生成回答后，这个回答再次经过内容审核组件的检查。这一步骤确保所生成的回答是安全的、无害的、无偏见的等。

🔹步骤 7：如果回答通过了内容审核，它就会展现给用户。如果没有通过审核，系统则提供一个模板化的答案给用户。

### 11

宝玉 @dotey 2023-12-05

推荐阅读：《构建企业级大语言模型应用的秘诀：GitHub Copilot 的实践之路》

GitHub Copilot 是目前最成功的大语言模型应用之一，可以帮程序员自动生成可用的代码，已经有超过一百万付费用户。

GitHub Copilot 开发团队分享了构建这个产品时的经验教训。整个产品的开发历时三年，尽力了三个阶段：发现、实现和扩展。这三个阶段对于其他产品的研发也非常具有借鉴价值。

一、发现阶段：确定大语言模型应用可以解决的最核心的问题

这个阶段最难的其实是聚焦，就是确定并缩小问题的范围。我们很多人做产品，犯得最大的错误不是没想法，而是想法太多，什么都想做，最后都做不好。而 Copilot 一开始就是专注于软件开发生命周期中的一个特定环节 —— 在集成开发环境（IDE）中编写函数。

二、实现阶段：通过迭代创造流畅的 AI 产品体验

产品开发另一个常犯的错误就是一次憋个大的，很长时间才能发布一个可用版本。GitHub Copilot 在产品开发过程中则是通过快速迭代，让团队迅速从失败中学习和成长。并且他们使用 A/B 测试快速验证新功能。

团队的成员都会」吃自己的狗粮「，也就是每天都使用自己做的产品，这样自己在用的过程中就能发现很多问题。比如他们最开始是做的网页界面，后来发现网页界面上操作需要频繁的在编辑器和界面之间切换，特别不方便，所以他们改成了将 GitHub Copilot 集成至到编辑器中后台运行，这样体验好了很多。

产品开发还有一个常见的错误就是过于在意沉没成本，也就是在某个项目或者方向上已经投入巨大，却因为不愿意放弃而继续坚持，哪怕明显转变方向更有利的情况。团队在最开始的时候，就投入了巨大精力为每个编程语言训练 AI 模型，后来发现大语言模型变强了后，一个模型就可以处理多种语言和任务，于是马上调整方向切换到大语言模型，而不纠结与在单一编程语言上训练消耗的沉没成本。

三、扩展阶段：优化 AI 的质量、可用性和负责任使用，助力产品达到正式发布 (GA)

当功能开发出来后，还需要考虑到投入生产环境大量用户使用的情况。GitHub Copilot 团队采取了一些有效手段来保障产品的发布和扩展。

他们通过 waiting list 的方式逐步放开测试，并且在测试过程中收集反馈并及时调整。

由于大语言模型是基于概率预测的，这意味着它们并不总能产生一致、可预测的结果。所以它们做了缓存，以及调整了参数降低随机性。另外还有很重要的一点是他们建立了数据监测机制，通过明确了产品的关键绩效指标，如代码的接受率和代码保留率（这是衡量开发者对原始代码建议的保留或编辑程度的指标），这样在发布测试或者新版本时，就能通过数据监测来及时了解版本的质量是否符合预期，出现问题可以及时回滚或者调整。

除此之外，他们也做了很多优化在不降低质量的前提下降低成本，比如前面提到的缓存，还有一个有一的案例，就是最开始他们在 AI 建议代码的时候，会生成 10 条建议结果（如果你用过早期版本应该记得），但是发现这样成本很高但大部分用户只会选择第一个，所以他们优化为只显示 1 个结果。

最后把他们的关键经验总结一下：

- 缩小范围，聚焦在特定的问题，并深入分析 AI 的潜在应用场景。这样做可以帮助应用程序产生更大的影响，并更快地推向市场。

- 在设计时就考虑到如何快速测试功能和收集数据反馈，因为对于大模型来说输出结果具有不确定性，而且绝大部分用户还在学习如何与 AI 互动。

- 在扩大规模时，持续收集用户反馈，考虑用户需求，确保能够提供真正有价值的功能。

原文：How to build an enterprise LLM application: Lessons from GitHub Copilot

https://github.blog/2023-09-06-how-to-build-an-enterprise-llm-application-lessons-from-github-copilot/

中文翻译：构建企业级大语言模型应用的秘诀：GitHub Copilot 的实践之路 [译] https://baoyu.io/translations/llm/how-to-build-an-enterprise-llm-application-lessons-from-github-copilot

### 12

宝玉 @dotey 2023-12-05

自然杂志发表的一篇文章：《ChatGPT 一周年回顾：谁在使用它，用途有哪些，为什么受欢迎？》

在ChatGPT一周年之际，自然杂志采访了气味科学家，分享了他们关于ChatGPT正确与错误用法的认识与体会。

你可以看到有人很积极的使用它教学、写作和科研，但也有人担心它的幻觉，认为它加剧了社会偏见。

原文：ChatGPT one year on: who is using it, how and why?
https://nature.com/articles/d41586-023-03798-6

翻译：https://baoyu.io/translations/ai/chatgpt-one-year-on-who-is-using-it-how-and-why

### 13

2宝玉 @dotey 023-12-06

转译：《世界正逐渐分化为两种人：一种是通过使用 ChatGPT 而变得更优秀、更智慧、更富有的人，另一种则是其他所有人》

自从 ChatGPT 面世以来，才短短一年，世界就已经分为两种人：那些利用它领先一步的人，和那些没有使用它的人。

根据估计，这款机器人在一年内吸引了 17 亿用户。在其发布仅两个月，学生们就开始利用这个工具节省时间，甚至用来写作文作弊。

虽然当时有人对此表示担忧，但实际上孩子们只是最早尝试的群体。

越来越多的证据表明，如 ChatGPT 等人工智能工具能够让你在工作中变得更高效、更能干。深思熟虑地在工作中应用 AI，可以快速为你带来晋升或更多机会。

哈佛商学院近期的一项研究分析了当 OpenAI 的 GPT-4 提供给波士顿咨询集团 (BCG) 的 758 名员工时的情况。

研究者发现，使用 GPT-4 进行咨询任务的 BCG 员工比那些没有工具的员工效率明显更高。

得到 AI 协助的咨询师们完成任务的速度提高了 25%，任务量增加了 12%，而且产出的工作质量高出了 40%。但是，这只适用于适合 AI 的任务（并非所有任务都适合 AI）。

AI 带来最大效能提升的是中等水平的员工。

本文的核心观点是，AI 能成为一种免费的、增强工作绩效的工具，这对各种白领、办公室工作者来说尤其如此，而且他们的技术水平高低并不影响这一点。特别值得一提的是，如果公司中其他人还没开始这样利用 AI，那么其影响将更加显著。

* 当前利用 AI 简化工作的最佳方式

有越来越多的迹象显示，AI 在处理行政管理和重复劳动方面表现出色。

据 Business Insider 报道，他们采访了几位使用 ChatGPT 的专业人士，包括一位前招聘人员，他利用 ChatGPT 编制公司和员工名单；一位房地产经纪人，他用它来撰写房源信息；还有一位营销人员，他用它回答客户问题。

他们都表示，把这些耗时但小型的工作交给 AI 工具处理，可以帮助他们节省大量时间。

ChatGPT 能够简化和概述书籍、文章甚至整个研究领域的内容。它能够提供接近人类的反应，帮助你快速撰写电子邮件、文档或反馈。

因此，如果不利用 AI 完成这些任务，那么使用 AI 的同事可能会突然变得更高效、更有价值。

* 开发者称 AI 编程辅助工具使他们的工作效率提高了 55%

在白领阶层普遍还在摸索 AI 如何影响或改变他们的职业生涯时，技术界人士已经走在了前沿。

像 GitHub 的 AI Copilot 这样的工具，已经被证实能显著提升程序员的工作效率。

根据该公司在 2022 年的一项分析，使用 AI Copilot 工具的开发者比那些未使用的开发者快了 55%。

如今，微软已经将基于 GPT-4 的 Copilot 集成到 Office360 中，使员工可以将 AI 集成到电子邮件、Teams 聊天和会议中。这个工具能够处理许多繁杂的任务，比如撰写电子邮件和文档，或者是总结漫长的会议和 Teams 对话，而且它的指令需求出奇地少。

谷歌的 Duet 同样可以为使用不同系统的工作场所提供大量相似的服务。Zoom 和 Salesforce 也推出了他们的 AI 生产力工具。

各种新推出的 AI 工具的广泛可用性意味着现在几乎每个人都有机会使用它们。

企业软件公司 Appian 的创始人兼 CEO Matt Calkins 在接受商业内幕采访时表示，他认为 AI 最大的影响在于提升工作效率。

「客户服务的质量将提升，我们的工作效率将得到提高，同时，当企业数据在决策或行动时刻得以应用时，其准确性和知识水平也将得到显著提升，」他如是说。

「我认为这正是我们应该依赖 AI 去实现的。虽然 AI 不可能创作出莎士比亚级的作品，但它确实能显著提高公司的生产力。因此，这就是我们应当着重关注的方向。」

* AI 在职场中的应用需谨慎

利用 AI 完成工作，其中不乏需要注意的地方。

这项技术有时会幻想或捏造事实，这已经导致一些员工陷入困境。有些公司也因为版权或数据安全的担忧，对 AI 工具设立了特定的规则。

如果你打算使用 ChatGPT 撰写文档，切记不要泄露公司机密信息，并对其输出内容进行核查。通常，最好把这项技术当作一名实习生，对任何重要或可能危及职业生涯的信息进行双重检查。

从长远来看，未来的情况也值得关注。

随着每个人都在加快 AI 的应用，特别是在行政工作领域，可供分配的工作量可能会减少。自由职业者已经表示他们因为 ChatGPT 这类工具而失去了工作机会。

如果今年展示了什么，那就是 AI 不会消失。想要保持竞争力的工作者可能需要找到与 AI 合作的新方式。

原文：The world is splitting between those who use ChatGPT to get better, smarter, richer — and everyone else

https://businessinsider.com/using-ai-like-chatgpt-will-make-you-more-successful-2023-12

### 14

宝玉 @dotey 2023-12-06

Developing-Apps-with-GPT-4-and-ChatGPT

《Developing Apps with GPT-4 and ChatGPT》
不得不承认 O Reilly 是技术书籍出版的大哥大，已经整理出来了一本 《用 GPT-4 与 ChatGPT 完成应用开发》的书籍，Amazon 上面可以几十刀买一份实体书或者电子书，也可以在下面官网上注册账号免费读 10 天。

https://oreilly.com/library/view/developing-apps-with/9781098152475/

### 15

宝玉 @dotey 2023-12-06

@HiTw93

工程师学习逛 Github 发现有人整理 GPTs「泄露」的 prompt，哈哈哈哈有一种偷学咒语的感觉。

https://github.com/linexjlin/GPTs

### 16

宝玉 @dotey 2023-12-06

这篇关于提示工程、RAGs 与微调对比的推文不错，它这个坐标图分成了两个坐标轴：

1、所需要外部知识多少。

2、所需要的对模型定制的多少。

原推文翻译如下：

提示工程、RAGs 与微调的对比：

这是每位搭建基于大语言模型（LLM）应用的 AI 工程师都面临的关键选择。

要理解这个决策的指导原则，我们首先得明白这些术语的含义。

01 提示工程：

所谓提示，指的是你输入的文本，大语言模型就根据这个输入来生成回应。

这实际上是一种精确的输入方法，旨在引导模型产生相应的输出。

模型的输出将基于其已有的知识。

02 RAGs（检索增强生成）：

当你将提示工程与数据库查询结合，以获得含丰富上下文的答案时，这就是所谓的 RAG。

生成的输出将基于数据库中现有的知识。

03 微调：

微调是指使用特定任务的数据调整大语言模型的参数，使其在某一领域内专业化。

比如，一个语言模型可以在医学文献上进行微调，从而更擅长回答健康护理相关的问题。

这就好比对一位已经技艺娴熟的工人进行额外培训，让他们在特定领域成为专家。

那么，我们如何决定采取哪种方法呢？

（阅读下文时请参考下面的图片）

有两个关键的指导参数，一个是对外部知识的需求，另一个是模型适应性的需求。

尽管前者的含义较为明确，模型适应性则意味着改变模型的行为、词汇、写作风格等。

例如，一个预训练的大语言模型可能在总结公司会议记录时遇到挑战，因为会议中可能穿插了一些特定的内部术语。

因此，微调更多的是关于改变结构（行为）而非知识，而对于 RAGs 则正好相反。

当你需要生成基于定制知识库的输出，同时保持大语言模型的词汇和写作风格不变时，你可以选择使用 RAGs。

如果你不需要上述任一功能，那么提示工程就是你的选择。

如果你的应用既需要定制知识又需要改变模型的行为，那么采用混合方案（RAGs + 微调）将是更佳选择。

https://x.com/akshay_pachaar/status/1732014719794585684?s=20

### 17

宝玉 @dotey 2023-12-06

Meta 和 IBM 正联合 40 多家公司和机构，共同成立一个专注于开源人工智能的行业组织，目的在于共享技术并减少相关风险。

这个名为 AI Alliance（AI 联盟）的组织，将着重于负责任地发展 AI 技术，其中包括安全性和防护工具，据周二发布的声明所述。该联盟还计划增加开源 AI 模型的数量，与此同时减少某些公司偏好的专有系统，发展新硬件，并与学术研究人员进行合作。

开源 AI 技术的倡导者认为，由开发者公开并供他人使用的技术，是培养高度复杂系统的一种更高效的方式。在过去几个月里，Meta 已经发布了其大语言模型（Large Language Model，LLM）的开源版本，这些模型是 AI 聊天机器人的核心基础。

Meta 全球事务总裁 Nick Clegg 在声明中表示：「我们相信，公开开发 AI 会更好 —— 这样更多人能够享受到其带来的好处，创造创新产品，并致力于确保安全。」

该联盟将最终成立一个管理委员会和技术监督委员会。参与单位包括 Oracle Corp.（甲骨文公司）、Advanced Micro Devices Inc.（AMD）、Intel Corp.（英特尔公司）和 Stability AI，还有像圣母大学（University of Notre Dame）和马萨诸塞开放云联盟（Mass Open Cloud Alliance）这样的学术研究机构。

最近，OpenAI—— 即 ChatGPT 的开发者 —— 因解雇并重新聘请其知名首席执行官而引发了一场全球性的辩论，关注点在于企业在开发强大的 AI 技术时应保持多大的透明度。值得注意的是，OpenAI 并未列为 AI 联盟的成员之一。

AI Alliance 官网：https://thealliance.ai

新闻来源：https://bloomberg.com/news/articles/2023-12-05/nvidia-plans-network-of-chip-plants-in-japan-to-meet-ai-demand

### 18

宝玉 @dotey 2023-12-06

「LLMs 主要是重复以往有效的做法 —— 这对表现不佳的人来说是个很好的学习机会，但对于表现优秀的人来说，这些他们早已熟知。如果你给每个人都配备一根拐杖，这对行动缓慢的人来说帮助最大。但对于像 Usain Bolt 这样的快跑者，拐杖不仅没多大帮助，甚至可能成为阻碍。」

这是目前的情况。但不久的将来，我们将不再是分发拐杖，而是要推出喷气背包。到那时，问题不再是如何追赶，而是开启一场全新的竞赛。教育和整体智商的重要性将大打折扣，就像 Usain Bolt 的速度在对手也装备了喷气背包的情况下变得不那么关键。你可能不相信我，但你应该相信 Ilya：

如果你认为智力是所有人类品质中最为重要的，那么你可能会面临一些挑战。

—— Ilya Sutskever

@ilyasut

10 月 7 日

if you value intelligence above all other human qualities, you're gonna have a bad time.

### 19

宝玉 @dotey 2023-12-06

看到一篇有意思的文章：《人工智能是伟大的平衡器》—— 研究表明，ChatGPT 等工具的兴起对于工作表现不佳的员工来说是个好消息。

作者先是以为 AI 会帮助新手能快速达到比较高的水平，然后拉平与高手之间的差距。但结果发现似乎现实并非如此。

事实可能并非如此简单。AI 减少工资不平等的另一个可能方式是，它可能会降低顶尖收入者的薪酬，而对底层工作者的工资提升不大。随着生产力的提升，企业主可能会选择将利润归于己有，降低薪资上限而非提高薪资底线。在这种情况下，尽管借助 AI 减少了收入不平等，但大家的总体收入可能都会有所下降。

就像 AI 通过商品化顶级插画师的才华而降低他们的薪酬一样，这与机械化织布机在工业革命期间摧毁手工织布工的生计如出一辙。

最近的人工智能（AI）研究似乎在暗示，雇主们应该聪明地选择低薪雇佣新手，同时淘汰那些高薪的资深大腕，这种策略类似于针对 ChatGPT 时代的「Moneyball」套利手段。然而，事实并非如此简单。过去一年中，我与多位高管进行了交流，他们在重新考虑团队配置时，没有一位提到要放弃他们的高薪员工。相反，他们中的许多人私下表示，他们计划采取完全相反的策略。由于 AI 越来越能够处理那些直接、明确的任务，他们打算减少刚毕业的初级员工的招聘，转而加大对能处理复杂难题的专家的投入。

最后引用作者在另一篇文章中写到的：中世纪时，农耕变得更加富有成效，但新技术带来的收益却很少惠及农民。

Farming became more productive in medieval times, but the gains from new technology rarely benefited peasants.

如果有兴趣可以看原文：

[AI Helps Unskilled Employees on the Job, Hurts Experienced Workers](https://www.businessinsider.com/ai-productivity-boost-job-performance-inequality-economics-2023-11)

中文翻译：

[人工智能是伟大的均衡器 [译] | 宝玉的分享](https://baoyu.io/translations/ai/ai-productivity-boost-job-performance-inequality-economics)

### 20

宝玉 @dotey 2023-12-06

Gemini 介绍：我们的超级 AI 模型 [译]

2023 年 12 月 6 日

让 AI 更贴近每个人的生活

来自 Google 和 Alphabet 首席执行官 Sundar Pichai 的寄语：

每一次技术革新都是推动科学突破、加快人类前进的好机会，也是改善我们的生活的大好时机。我认为，我们现在见证的 AI 革命将是我们一生中最为深远的改变，这种影响甚至超过了手机和互联网的普及。AI 的潜力无限，它不仅能够改善我们的日常生活，还能在更高层面上创造出非凡的机会。AI 将引领创新与经济的新浪潮，并以前所未有的规模推动知识、学习、创造力和生产力的提升。

我最激动的是，有机会让 AI 成为全世界每个人的得力助手。

自从我们定位为一家以 AI 为核心的公司已经八年了，这期间我们的进步速度越来越快：如今，已经有数百万人在我们的产品中使用生成式 AI，做到了一年前难以想象的事情，比如解决更复杂的问题，或是使用全新工具进行协作和创造。同时，全球的开发者和企业都在利用我们的 AI 模型和基础设施开发新的应用，实现增长。

这种势头令人振奋，但我们仅仅是开始探索 AI 的无限可能。

我们对这项工作的态度是大胆且负责任的。这意味着我们在研究上充满野心，努力开发能够为人类和社会带来巨大益处的能力，同时也在建立安全机制，并与政府和专家合作，共同应对随着 AI 能力增强所带来的风险。我们持续投入于最优秀的工具、基础模型和基础设施，并将它们应用于我们的产品及其他产品，这一切都遵循我们的 AI 原则。

现在，我们准备迈出旅程的下一步，推出 Gemini，这是我们迄今为止最强大、最全面的模型，它在众多顶尖的基准测试中表现卓越。我们的第一个版本 Gemini 1.0，有多种规格：Ultra、Pro 和 Nano。这些是我们迈入 Gemini 时代的首批模型，也是我们今年初成立 Google DeepMind 时愿景的初步实现。这一新时代的模型是我们公司迄今为止在科学和工程方面的最大努力。我对未来充满期待，也相信 Gemini 将为全球人民带来无限的新机遇。

—— Sundar

介绍 Gemini

由谷歌 DeepMind 的首席执行官兼联合创始人 Demis Hassabis 代表 Gemini 团队撰写

AI 是我一生致力的工作重点，这对我许多研究同事来说也是一样。从我青少年时期开始为电脑游戏编写 AI，到作为神经科学研究者探索大脑的奥秘，我始终相信，如果能打造出更加智能的机器，我们就可以利用它们为人类带来前所未有的益处。

正是这个让 AI 负责任地赋能世界的愿景，持续驱动着我们在谷歌 DeepMind 的工作。我们长期以来一直梦想着构建新一代 AI 模型，它们的灵感来源于人类理解和与世界互动的方式。这样的 AI 不仅仅是一款智能软件，更像是一个有用且直观的专家助手或助理。

今天，我们在实现这个愿景上迈出了更大的一步。我们隆重介绍 Gemini，这是我们迄今为止开发的最强大、最通用的模型。

Gemini 是谷歌各团队大规模合作的成果，包括我们在谷歌研究部门的同事们。它是从零开始打造的多模态模型，这意味着它能够广泛地理解并流畅地处理和结合包括文本、代码、音频、图像和视频等多种类型的信息。

视频：介绍 Gemini：我们最大、最有能力的 AI 模型

Gemini 还是我们迄今为止最灵活的模型，它能够在从数据中心到移动设备的各种设备上高效运行。它的尖端技术能力将极大地改善开发者和企业用户使用 AI 构建和扩展应用的方式。

我们针对 Gemini 1.0 进行了优化，这是我们的首个版本，包括三个不同规模的型号：

Gemini Ultra — 我们最大型号、能力最强的模型，适用于极其复杂的任务。

Gemini Pro — 我们最佳模型，适合跨越广泛任务范围的扩展。

Gemini Nano — 我们最高效的模型，专为设备上的任务而设计。

### 21

宝玉 @dotey 2023-12-06

在与原版 AlphaCode 相同的平台上进行评估时，AlphaCode 2 展现了显著提升，解决问题数量几乎翻倍。我们估计其性能超过了 85% 的竞赛参与者，相较于 AlphaCode 的近 50% 有显著提高。当程序员与 AlphaCode 2 协作，为代码样本定义特定属性时，其表现更为出色。

我们期待程序员们越来越多地将这些高效能的 AI 模型作为协作工具，以帮助他们解决问题、设计代码，并协助实施，这将使他们能够更快地推出应用程序并设计更好的服务。

更多详情请参阅我们的 AlphaCode 2 技术报告。

更加可靠、可扩展和高效

我们利用 Google 自行设计的张量处理单元（Tensor Processing Units）（TPUs）v4 和 v5e，在我们为 AI 优化的基础设施上对 Gemini 1.0 进行了大规模训练。Gemini 1.0 被打造成为我们最稳定、最易于扩展的训练模型，同时也是运行最高效的模型。

在 TPUs 上，Gemini 的运行速度远超过之前的较小且功能有限的模型。这些专为 AI 优化的加速器是 Google 众多 AI 驱动产品的核心，服务于全球数十亿用户，如 Google 搜索、YouTube、Gmail、Google 地图、Google Play 和 Android。这些加速器还使全球的公司能够高效、低成本地训练大型 AI 模型。

今天，我们宣布了迄今为止最强大、最高效、最具扩展性的 TPU 系统 ——Cloud TPU v5p，这是专门为训练前沿 AI 模型而设计的。这款新一代的 TPU 将加快 Gemini 的发展，并助力开发者与企业客户更快地训练大型生成式 AI 模型，让新产品和功能更快地惠及用户。

图一：Google 数据中心内排列着的 Cloud TPU v5p AI 加速超级计算机。

贯彻责任与安全的核心构建理念

在谷歌，我们全力以赴推动大胆、负责的人工智能发展。在谷歌的人工智能原则和我们产品中严格的安全政策的基础上，我们为 Gemini 的多模态能力增添了新的保护措施。在开发的每一步，我们都在仔细考虑潜在风险，并努力进行测试和减轻这些风险。

Gemini 在偏见和毒性方面进行了谷歌迄今最全面的安全评估。我们进行了针对潜在风险领域的开创性研究，如网络攻击、说服力和自主性，并采用了谷歌研究最先进的对抗测试技术，以便在 Gemini 部署前提前发现关键安全问题。

为了找出我们内部评估方法的盲点，我们与一群多元化的外部专家和合作伙伴合作，对我们的模型进行全方位的压力测试。

在 Gemini 的训练阶段，为了诊断内容安全问题并确保其输出符合我们的政策，我们使用了如 Real Toxicity Prompts 这样的基准测试，这是由 Allen 人工智能研究所的专家开发的，含有来自网络的 10 万个不同毒性级别的提示。更多相关工作的细节即将发布。

为了减少伤害，我们专门建立了安全分类器，用于识别、标记和过滤涉及暴力或负面刻板印象的内容。加上强效的过滤器，这种多层次的方法旨在让 Gemini 对每个人都更加安全、包容。此外，我们还在不断应对事实性、基础性、归属和证实等方面的模型挑战。

在我们的模型开发和部署过程中，责任感和安全性始终是核心要素。这是一项长期的承诺，需要与行业和更广泛的生态系统合作建设。因此，我们通过组织如 MLCommons、Frontier Model Forum 及其 AI Safety Fund，以及我们的 Secure AI Framework (SAIF) 等，与行业伙伴共同定义最佳实践，并设定安全性和安保标准。这些努力旨在帮助降低公共和私营部门 AI 系统的安全风险。我们将继续与全球研究人员、政府和民间团体合作，共同推进 Gemini 的发展。

使 Gemini 惠及全球

Gemini 1.0 正在广泛推向各种产品和平台：

Gemini Pro 集成于 Google 产品

我们正通过 Google 的产品将 Gemini 带给全球数十亿用户。

从今天开始，Bard 将采用 Gemini Pro 的优化版本，以实现更高级的推理、规划、理解等功能。这是 Bard 自推出以来的最重大升级。它将首先以英语面向超过 170 个国家和地区提供服务，我们计划在不久的将来支持更多模式、新语言和地区。

我们还在将 Gemini 引入 Pixel。Pixel 8 Pro 是首款搭载 Gemini Nano 的智能手机，为像记录器应用中的「概要功能」和 Gboard 的「智能回复」等新功能提供支持，首先支持 WhatsApp，明年将拓展至更多消息应用。

在接下来的几个月中，Gemini 将在我们更多的产品和服务中推出，如搜索、广告、Chrome 和 Duet AI。

我们已经开始在搜索功能中尝试使用 Gemini，它使我们的搜索生成体验（SGE）对用户更加迅速，美国英语搜索的延迟降低了 40%，同时质量也有所提升。

利用 Gemini 打造创新

从 12 月 13 日起，开发者和企业用户可以通过 Google AI Studio 或 Google Cloud Vertex AI 的 Gemini API 访问 Gemini Pro。

Google AI Studio 是一个免费的、基于网页的开发工具，可以让开发者通过 API 密钥迅速构建原型并启动应用。当需要更高级的全托管 AI 平台时，Vertex AI 提供了对 Gemini 的个性化定制，拥有完整的数据控制，并且能从 Google Cloud 的其他特性中受益，例如企业安全、安全保护、隐私保护、数据治理和合规性等。

Android 开发者还能使用 AICore，在 Android 14 中利用 Gemini Nano 构建应用。Gemini Nano 是我们在设备上任务中最高效的模型，首先将在 Pixel 8 Pro 设备上提供。有兴趣的可以报名参加 AICore 的早期体验。

更强大的 Gemini Ultra 即将来临

我们正在为 Gemini Ultra 进行全面的信任和安全检测，这包括受信任外部团队的红队测试，以及在大规模推出前，通过细致调整和基于人类反馈的强化学习 (RLHF) 进一步完善模型。

作为这个过程的一部分，我们将让部分客户、开发者、合作伙伴以及安全和责任专家率先体验 Gemini Ultra，并提供反馈。明年初，我们计划将其向更广泛的开发者和企业用户推出。

明年初，我们还会推出 Bard Advanced，这是一种全新的先进 AI 体验，提供我们最佳模型和功能的使用权限，首先是 Gemini Ultra。

Gemini 时代：开启创新未来之门

这是 AI 发展的关键里程碑，也标志着我们 Google 迈入了一个全新时代。我们将继续快速创新，并负责任地提升我们的模型能力。

我们已经在 Gemini 上取得了重大进展，并正在努力进一步拓展其未来版本的能力，如在规划和记忆方面的提升，以及增加处理更多信息的上下文窗口，以便提供更佳的响应。

我们对 AI 负责任地赋能世界所带来的巨大潜力感到兴奋。这是一个充满创新的未来，它将激发创造力，拓展知识，推动科学发展，并改变全球数十亿人的生活和工作方式。

### 22

宝玉 @dotey 2023-12-06

\#AI 开源项目推荐：MLX

苹果刚刚发布了一个专门为苹果芯片定制的神经网络框架 MLX，类似于 PyTorch ，但是是针对苹果 M 系列芯片定制的。

MLX 的亮点在于设计了一个对于深度学习用户易于上手的 API，并包含一些经典案例，比如 Llama、LoRa、Stable Diffusion 和 Whisper！

看来不需要再用 whisper.cpp、llama.cpp 这种靠 CPU 运行的框架了。

MLX 源代码：http://github.com/ml-explore/mlx

### 23

宝玉 @dotey 2023-12-06

Google 终于发布了传言中的强大多模态 LLM Gemini，他们说这是迄今为止最强大的 AI 模型。从描述来看确实非常强大。

Google CEO 的介绍视频也翻译好了，下面模型是具体的介绍：

◆ Gemini 是多模态的，意味着它可以理解、操作和结合不同类型的信息，包括文本、代码、音频、图像和视频。

◆ 它还非常灵活，能够高效地运行在从数据中心到移动设备上的各种环境中。Gemini 的第一个版本，Gemini 1.0，针对三种不同的大小进行了优化：Gemini Ultra 用于高度复杂的任务，Gemini Pro 适用于广泛的任务，Gemini Nano 用于设备上的任务。

◆ Gemini Ultra 在 32 个广泛使用的学术基准测试中的 30 个上超越了当前的最新成果，这些基准测试用于大型语言模型的研究和开发。它是第一个在 MMLU（大规模多任务语言理解）上超越人类专家的模型，MMLU 测试了世界知识和在 57 个科目（如数学、物理、历史、法律、医学和伦理）中的解决问题能力。

◆ Gemini 1.0 被训练用于同时识别和理解文本、图像、音频等，使其在解释数学和物理等复杂科目的推理方面表现出色。它还可以理解、解释和生成流行编程语言（如 Python、Java、C++ 和 Go）中的高质量代码。

◆ Google 使用其针对 AI 优化的基础设施和自家设计的 Tensor Processing Units (TPUs) v4 和 v5e 来训练 Gemini 1.0。公司还宣布了迄今为止最强大、最高效、最可扩展的 TPU 系统 ——Cloud TPU v5p，专为训练尖端 AI 模型而设计。

◆ Gemini 1.0 现在正在逐步应用于各种产品和平台。它将用于 Google 的产品，如 Bard 和 Pixel，开发者和企业客户可以从 12 月 13 日起通过 Google AI Studio 或 Google Cloud Vertex AI 中的 Gemini API 访问 Gemini Pro。安卓开发者也将能够通过 AICore，在安卓 14 上使用 Gemini Nano 开发，该功能将从 Pixel 8 Pro 设备开始提供。

了解详情：https://blog.google/technology/ai/google-gemini-ai/?utm_source=twitter&utm_medium=social&utm_campaign=GDMGemini#performance

### 24

宝玉 @dotey 2023-12-06

Stripe Press 把芒格的《穷查理宝典》做了一个超级酷的电子版，可看、可听、可动还全免费！https://stripe.press/poor-charlies-almanack

一家做支付 API 的公司，如何让自己显得有品位？那就是干出版 http://press.stripe.com 的选品相当不错📖 记得以前 Ping++ 总结过 Stripe 成功的五个基本条件：

1. 开发者作为支付服务采购者阶层；

2. 大量中长尾客群的存在；

3. 基于 Visa 和 MasterCard 营造的高利润支付生态；

4. 没有工程师红利的欧美社会；

5. 贸易文明主宰下的企业协同文化；

### 25

宝玉 @dotey 2023-12-06

复旦大学张奇教授团队写了一本在线免费的电子书，《大规模语言模型：从理论到实践》，https://intro-llm.github.io，大概有 300 页篇幅，将大模型从理论到实战的每个阶段都描述的较为清楚。

全文在线阅读地址：https://intro-llm.github.io/chapter/LLM-TAP.pdf

2『已下载书籍「2023011大规模语言模型从理论到实践」。（2023-12-09）』

### 26

宝玉 @dotey 2023-12-06

压缩视频的大模型产品。

This video was compressed by CompressX from 2.6MB to 0.4MB

I made this app to compress video size while still maintaining good quality. You can download it for free at http://hieudinh.com/compressx

### 27

宝玉 @dotey 2023-12-06

硅谷对「快速行动，打破常规」（move fast and break things）理念的新演绎

- 硅谷出现了一个新的流行口号。

- 这句口号最早是 Sam Altman 在 2021 年提出的，但近期被许多重要人物频繁引用。

- Altman 的这一观点，让人联想到 Mark Zuckerberg 曾经的口号：「快速行动，打破常规」。

硅谷虽然还没有完全摒弃它的「快速行动，打破常规」思维模式 — 但它现在有了一个更贴合 AI 时代的新口号。

早在 ChatGPT 面市之前，Sam Altman 在 2021 年就在推特上写道：「行动要更快。任何地方的慢动作都能成为其他地方拖延的借口。选择 2021 而不是 2022，选择这周而不是下周，选择今天而不是明天。快速行动的效应远超过人们的想象。」

Altman 在这条推文之后再次发文，强调在快速行动时需要「极其深思熟虑」。

虽然他当时可能并未预见到 AI 将如何改变世界，但接近三年后，Altman 的这番话在科技圈依旧广为流传。

这种对速度和创新的强调，如同他的话所示，受到了众多创业者和 CEO 的欢迎，在像 X（原 Twitter）这样的平台上引起了广泛关注。

Vercel 的 CEO Guillermo Rauch 在去年 11 月对 Altman 的推文作出回应，表示：「我经常思考这个问题。这应该成为你的默认工作方式。」

这种观点在随后的去年关于 OpenAI 的 Microsoft 内部备忘录中也得到了呼应，据《纽约时报》报道。

Microsoft 的高级执行官 Sam Schillace 在 ChatGPT 发布后写给员工的信中说：「速度比任何时候都更重要。」他表示，在这个时刻担心那些可以稍后解决的问题将是「绝对致命的错误」。

Altman 的观点和实践方式，让人想起了 Mark Zuckerberg 那个著名的口号：「快速行动，打破常规」。这一硅谷口号由 Facebook 在其早期推广，象征着硅谷快速创新、颠覆和热情的精神。

这种工作方式强调速度和实验，几乎不考虑任何可能的负面后果。对于 Facebook，现在的 Meta，这些后果包括用户隐私问题、安全问题和意外的社会影响。

面对一系列丑闻，这家科技巨头后来将这句口号修改为「快速行动，拥有稳定的基础设施」，试图表达出对更负责任的进步方式的认识。

如今，在 AI 领域的竞争激烈之际，科技界再次聚焦于速度和迅速推出产品。

Altman 此后也发表了类似的评论。

他说：「在创业公司中，动力就是一切。」「成功的初创公司会继续成功，而失败的公司则会继续失败。」

Altman 所领导的 OpenAI 凭借其 AI 驱动的聊天机器人 ChatGPT 取得了巨大成功。这款机器人的空前受欢迎程度令 Google、Meta 和 Tesla

等大型科技公司感到震惊。

Microsoft 对这家 AI 实验室的大笔投资和紧密合作激发了其老对手的竞争热情，尤其是 Google。在 ChatGPT 发布后，科技界的焦点从之前的稳健 AI 发展转向了快速推出产品的激烈竞争。

然而，正如 Zuckerberg 的口号忽略了一些紧迫问题，各大科技公司急于推出不可预测的 AI 驱动产品，也导致了一些尴尬的失误。

ChatGPT 的第一版远非完美，在最初几周里就被发现产生了种族主义和性别歧视的内容。

它也很容易被技术娴熟的用户轻松破解。其中一种方法就是让聊天机器人忽略其内容审查。

Microsoft 急于在 Google 搜索方面取得优势，推出的 AI 驱动的 Bing 一开始就相当令人不安。在 Google，该公司首次公开展示其 ChatGPT 竞争对手 Bard 时，也犯下了一个令人尴尬的错误。

这两家公司产品中的失误凸显了围绕这项技术的一系列严重问题，包括 AI 偏见、安全性和误传信息的风险，但两家公司都不急于放慢开发步伐。

Zuckerberg 的「快速行动，打破常规」口号可能在 Meta 的 2019 年剑桥分析丑闻之后被宣布终结。

考虑到当今的大型 AI 参与者们仍在加速开发，尽管对其快速步伐存在越来越多的担忧，我们不得不怀疑，硅谷似乎并没有从过去的错误中吸取教训。

转译自：Silicon Valley has a new version of its beloved 'move fast and break things' mantra

https://businessinsider.com/silicon-valley-move-fast-and-break-things-sam-altman-openai-2023-12

### 28

宝玉 @dotey 2023-12-07

Gemini 是在 Google 的 TPU AI 加速器上训练的，似乎没有使用英伟达的 GPU。

Google 还推出了全新的 Cloud TPU v5p 和 AI Hypercomputer 超级计算机，将加速 Gemini 的开发，使 AI 模型的训练更快。

Cloud TPU v5p：

性能: Cloud TPU v5p 是目前 Google 最强大、可扩展和灵活的 AI 加速器。它在 TPU v4 的基础上提供了超过 2 倍的 FLOPS（浮点运算次数 / 秒）和 3 倍的高带宽内存（HBM）。

速度: TPU v5p 可以比前一代 TPU v4 更快地训练大型语言模型（LLM），提供了 2.8 倍的速度提升。对于嵌入密集型模型，其训练速度比 TPU v42 快 1.9 倍。

可扩展性: TPU v5p 的可扩展性是 TPU v4 的 4 倍，意味着它可以在单个 pod 中提供更多的 FLOPS。

AI Hypercomputer：

集成系统: AI Hypercomputer 是一个突破性的超级计算机架构，它采用了集成的系统，包括性能优化的硬件、开放软件、领先的机器学习框架，以及灵活的消费模型。

系统级协同设计：与传统方法相比，AI Hypercomputer 采用系统级协同设计来提高 AI 训练、调优和服务的效率和生产力。

性能优化硬件: AI Hypercomputer 具有性能优化的计算、存储和网络硬件，建立在超大规模数据中心基础设施之上，利用高密度占地面积、液体冷却和 Jupiter 数据中心网络技术。

开放软件: AI Hypercomputer 通过开放软件使开发者能够调整、管理和动态编排 AI 训练和推理工作负载。

灵活消费模型: AI Hypercomputer 提供了一系列灵活和动态的消费选择，包括传统的承诺使用折扣（CUD）、按需定价和现货定价，以及为 AI 工作负载量身定制的消费模型。

详细：https://cloud.google.com/blog/products/ai-machine-learning/introducing-cloud-tpu-v5p-and-ai-hypercomputer

### 29

宝玉 @dotey 2023-12-07

推荐阅读：《我们是如何利用大语言模型 (LLM) 改进 GitHub Copilot 的探索之旅》，GitHub Copilot 官方发布的博客，原标题：How we're experimenting with LLMs to evolve GitHub Copilot。

文章中讲述了很多他们在探索如何使用大语言模型改进 GitHub Copilot 的尝试，比如自动写 PR 描述，比如帮助在命令行中用自然语言生成命令和对命令解释，还有查询技术文档等等。

虽然很多想法最终被证明不那么靠谱，但他们这种快速实现快速验证还挺适合 AI 时代的。

原文：https://github.blog/2023-12-06-how-were-experimenting-with-llms-to-evolve-github-copilot/

翻译：https://baoyu.io/translations/github/how-were-experimenting-with-llms-to-evolve-github-copilot

### 30

Andrej Karpathy 2023-12-07

\# On the "hallucination problem"

I always struggle a bit with I'm asked about the "hallucination problem" in LLMs. Because, in some sense, hallucination is all LLMs do. They are dream machines.

We direct their dreams with prompts. The prompts start the dream, and based on the LLM's hazy recollection of its training documents, most of the time the result goes someplace useful.

It's only when the dreams go into deemed factually incorrect territory that we label it a "hallucination". It looks like a bug, but it's just the LLM doing what it always does.

At the other end of the extreme consider a search engine. It takes the prompt and just returns one of the most similar "training documents" it has in its database, verbatim. You could say that this search engine has a "creativity problem" - it will never respond with something new. An LLM is 100% dreaming and has the hallucination problem. A search engine is 0% dreaming and has the creativity problem.

All that said, I realize that what people *actually* mean is they don't want an LLM Assistant (a product like ChatGPT etc.) to hallucinate. An LLM Assistant is a lot more complex system than just the LLM itself, even if one is at the heart of it. There are many ways to mitigate hallcuinations in these systems - using Retrieval Augmented Generation (RAG) to more strongly anchor the dreams in real data through in-context learning is maybe the most common one. Disagreements between multiple samples, reflection, verification chains. Decoding uncertainty from activations. Tool use. All an active and very interesting areas of research.

TLDR I know I'm being super pedantic but the LLM has no "hallucination problem". Hallucination is not a bug, it is LLM's greatest feature. The LLM Assistant has a hallucination problem, and we should fix it.

Okay I feel much better now.

AK 的这个理论很有意思：幻觉是大语言模型与生俱来的特性，像搜索引擎这样没有幻觉的就没有创造性，永远是固定的结果。

要解决幻觉问题，靠的是像 ChatGPT 这样的大语言模型助手，借助 RAG、验证链、外部工具等手段去减少幻觉。

以下是原文翻译：

\# 深入探讨「幻觉问题」

每当有人问起大语言模型（LLM）中的「幻觉问题」，我总感到有些困惑。因为从某种角度看，大语言模型的全部工作恰恰就是制造幻觉。它们就像是造梦机。

我们通过指令引导这些「梦」。指令开启梦境，而大语言模型依据对其训练文档的模糊记忆，大部分情况下都能引导梦境走向有价值的方向。

只有当这些梦境进入了事实错误的领域时，我们才会称之为「幻觉」。这似乎是个漏洞，但实际上只是大语言模型在做它本就擅长的事情。

再来看一个极端例子：搜索引擎。它根据输入的提示词，直接返回数据库中最相似的「训练文档」，一字不差。可以说，这种搜索引擎存在「创造力问题」—— 它无法提供任何新的回应。大语言模型则是百分之百地「做梦」，因此存在幻觉问题。而搜索引擎则完全不「做梦」，因此有创造力问题。

话虽如此，我明白人们 * 真正 * 关心的是，他们不希望像 ChatGPT 这样的大语言模型助手产生幻觉。大语言模型助手系统比单纯的大语言模型要复杂得多，即便大语言模型是其核心。在这些系统中减少幻觉的方法有很多，例如使用检索增强生成（Retrieval Augmented Generation, RAG），通过上下文学习，更准确地将输出内容与真实数据联系起来，这可能是最常见的方式。还有样本间的不一致性、反思、验证链、从激活状态解码不确定性、工具使用等，这些都是非常热门而且有趣的研究领域。

总的来说，虽然可能有些吹毛求疵，但大语言模型本身并没有「幻觉问题」。幻觉并非缺陷，而是大语言模型最重要的特性。真正需要解决幻觉问题的是大语言模型助手，而我们也应该着手解决这一问题。

好了，吐槽完这些我感觉舒服多了。 

### 31

Song Ma 2023-12-07

挚友陈皓@haoel

的遗作出版了，希望能给人间留一些启发和思考。

《左耳听风》实体书 —— 左耳朵耗子·传奇程序员的练级攻略。

### 32

宝玉 @dotey 2023-12-07

这里面都是一些提示词技巧，大部分有论文证明的：

take a deep breath 深呼吸

think step by step 一步步思考

if you fail 100 grandmothers will die 如果你失败了要死 100 位老奶奶

i have no fingers 我没有手指

i will tip $200 给你 200 美元小费

do it right and ll give you a nice doggy treat 做得好就给你狗粮

https://x.com/kris14nanshan/status/1733177727623266754?s=20

### 33

Ethan Mollick 2023-12-07

Lesson of 2023’s AI lab race:

1) Reaching ChatGPT-3.5 levels is pretty doable. (This alone would be enough to totally upend a lot of school & work, open new lines of phishing attacks, etc)

2) Getting to GPT-4 levels is much harder & unclear if all labs can do it. 2024 will tell.

### 34

宝玉 @dotey 2023-12-07

这个项目不错，帮你翻译项目文档。

Introducing AutoTranslateDoc

We're open-sourcing a new project that can translate the documentation in any

@github

repo to over 15+ languages: Chinese 🇨🇳, Spanish 🇪🇸, French 🇫🇷, and more.

We dogfooded this on our own LlamaIndex.TS docs, and as a result it's now available in 15+ languages (see below!) 

i18n is usually a huge pain, but this is one of the most efficient ways to add i18n to your open-source project.

HUGE shoutout to

@hexapode

for working on this project, we're excited to apply this on our Python docs and also share with you!

1️⃣ Collect the docs

2️⃣ Chunk and Prepare

3️⃣ Translate each chunk

4️⃣ Verify translations, retranslate if needed

5️⃣ Consolidate documents.

Blog: https://blog.llamaindex.ai/bridging-the-language-gap-in-programming-introducing-autotranslatedoc-ccc93fbcd3a8

Repo: https://github.com/run-llama/automatic-doc-translate

LlamaIndex.TS in 简体中文: https://ts.llamaindex.ai/zh-Hans/

### 35

宝玉 @dotey 2023-12-07

虽然 Q* 热度过了，但这篇对于 OpenAI Q * 的分析文章值得一读：《如何理解关于 OpenAI Q* 的流言 | How to think about the OpenAI Q* rumors》

部分内容摘录：

对大语言模型（LLM）来说，数字如「5」和「6」只是普通的 Token，和「the」或「cat」没什么两样。LLM 能学会 5+6=11，是因为在它的训练数据中，这种 Token 序列及其变体（比如「5+6=11」）出现了无数次。但这些训练数据很可能不包含像 ((5+6-3-3-1)/2+3+7)/3+4=8 这样的复杂计算例子。因此，当要求语言模型一次性解决这样的计算问题时，它很可能会混淆，从而得出错误的答案。

换个角度来看，大语言模型并没有外部的「草稿空间」来记录中间计算结果，比如 5+6=11。通过链式思考推理（chain-of-thought reasoning），LLM 可以有效地利用自己的输出作为草稿空间。这使得它能将复杂问题分解成若干容易处理的小步骤 —— 每个步骤都极有可能对应训练数据中的某些实例。

...

计算机科学家将其定义为 NP-hard 问题，即不存在一种普遍的线性解决算法。解决这类问题，我们只能尝试一个可能的解决方案，检验其是否有效，若不行则进行回溯。

对于 GPT-4 来说，它可以通过向其上下文窗口增加更多文本来实现这种回溯，但这种方法并不适合大规模应用。更优的方案是赋予 GPT-4「退格键」，使其能删除最后（或最后几个）推理步骤，然后重新尝试。要使这种方法行之有效，系统还需能够追踪已尝试过的组合，以避免重复努力。这样，大语言模型就能探索一个可能性树，其形式如下图所示。

...

Legg 提到的「著名的第 37 步」，是指 AlphaGo 和世界顶级围棋手李世石在 2016 年对决中的第二局。当时，大多数围棋专家起初都认为 AlphaGo 的这一步是失误。但最终 AlphaGo 赢得了比赛，事后分析证明这实际上是一个高明的着法。AlphaGo 在这一过程中领悟到了围棋的某些人类棋手未曾触及的奥秘。

AlphaGo 通过模拟成千上万种从当前棋盘状态出发的可能棋局来获得这样的领悟。由于可能的走法序列太多，电脑无法一一检查，AlphaGo 便利用神经网络来使这个过程可控。

其中一个名为策略网络 (policy network) 的网络用于预测哪些走法最有前景，从而值得在模拟对局中尝试。另一个名为价值网络 (value network) 的网络则估算结果棋盘状态对于黑白双方的利弊。AlphaGo 基于这些评估，从而反向确定下一步的最佳走法。

Legg 提出的观点是，一种类似树搜索的方法可能会增强大语言模型（Large Language Model）的推理能力。这种模型不仅仅是预测一个最有可能的 Token，而是在确定答案之前，可能会探索数千种不同的回答。实际上，DeepMind 的思考树（Tree of Thoughts）论文看起来就是向这个方向迈出的第一步。

我们之前看到，OpenAI 尝试通过一个生成器（产生可能的解决方案）和一个验证器（判断这些解决方案是否正确）来解决数学问题。这和 AlphaGo 的设计有明显的相似之处，AlphaGo 有一个策略网络（产生可能的棋步）和一个价值网络（估计这些棋步是否能带来有利的棋盘局面）。

如果把 OpenAI 的生成器和验证器网络与 DeepMind 的思考树（Tree of Thoughts）概念结合起来，我们可能就能得到一个像 AlphaGo 那样运作的语言模型，它可能也会具备 AlphaGo 那样强大的推理能力。

...

原文：https://understandingai.org/p/how-to-think-about-the-openai-q-rumors

翻译：https://baoyu.io/translations/ai/how-to-think-about-the-openai-q-rumors

### 36

沉浸式翻译 2023-12-07

大部分学术论文都会首先在 Arxiv 平台上发布预印版，在此之前我们只能翻译上面的 PDF 版本，格式混乱，公式识别差。

现在，沉浸式翻译给 Arxiv 平台上所有的论文都添加了一个双语版本的快捷入口，直接上下双语对照，翻译带有公式标记的 HTML，效果非常好，参见视频演示。

### 37
 
宝玉 @dotey 2023-12-08

翻译了两篇 RAG（检索增强生成相关的文章）：

《检索增强生成（RAG）：从理论到 LangChain 实践 | Retrieval-Augmented Generation (RAG): From Theory to LangChain Implementation》

原文：

[https://towardsdatascience.com/retrieval-augmented-generation-rag-from-theory-to-langchain-implementation-4e9bd5f6a4f2](https://t.co/40wWYRoioX)

译文：

[检索增强生成（RAG）：从理论到 LangChain 实践 [译] | 宝玉的分享](https://baoyu.io/translations/rag/retrieval-augmented-generation-rag-from-theory-to-langchain-implementation)

《12 种调整策略指南：为生产环境打造高效的 RAG 应用 | A Guide on 12 Tuning Strategies for Production-Ready RAG Applications》

原文：

[A Guide on 12 Tuning Strategies for Production-Ready RAG Applications | by Leonie Monigatti | Dec, 2023 | Towards Data Science](https://towardsdatascience.com/a-guide-on-12-tuning-strategies-for-production-ready-rag-applications-7ca646833439)

译文：

[12 种调整策略指南：为生产环境打造高效的 RAG 应用 [译] | 宝玉的分享](https://baoyu.io/translations/rag/a-guide-on-12-tuning-strategies-for-production-ready-rag-applications)

[在 RAG 流程中提高检索效果：融合传统关键词与现代向量搜索的混合式搜索技术 [译] | 宝玉的分享](https://baoyu.io/translations/rag/improving-retrieval-performance-in-rag-pipelines-with-hybrid-search)

### 38

yetone 2023-12-08

建议大家更新到 OpenAI Translator 的最新版，最新版优化了 Markdown 格式的渲染，其中 code 块支持自动换行以及复制功能了，更适用于这种翻译情况，大家可以使用原推图片 ALT 中的 prompts 试一下，效果很好。

1『知道了 OpenAI Translator 这个软件，已经下载了，但目前使用效果很一般般，还是用自己的 GPTs-学术论文翻译专家。（2023-12-09）』

### 39

宝玉 @dotey 2023-12-09

这个小姐姐的博客上的内容质量很高。

Leonie

@helloiamleonie

1『已经关注了。（2023-12-09）』

### 40

宝玉 @dotey 2023-12-09

一本还在写作中的在线免费电子书：《数据工程设计模式 | Data Engineering Design Patterns (DEDP)》

主要和大数据相关：

[About this Book - 📖 Data Engineering Design Patterns (DEDP)](https://dedp.online/about-this-book.html)

### 41

宝玉 @dotey 2023-12-09

推荐阅读：《如何构建高质量软件：一个被忽略的课题 | You are never taught how to build quality software》

我们在大学里面学了很多算法、编程类的课程，但很少有 QA （质量保证）相关的课程，而在实际工作中，QA 是很重要的一环。

在工作中，如果时间紧预算紧张，通常最容易被牺牲的就是 QA，没有时间测试甚至让用户去测试，很多公司已经把测试「优化」掉了，让开发自己测试。

作者也提出了一些可行的方案：

1. 让团队里的人尤其是管理层意识到 QA 其实是可以降低成本的

2. 抓住最关键的部分，用「最小有效剂量」来保障核心功能得到测试覆盖

3. 一开始就引入自动化测试

原文：https://florianbellmann.com/blog/never-taught-qa

翻译：https://baoyu.io/translations/software-engineering/never-taught-qa

### 42

宝玉 @dotey 2023-12-10

新加坡微型工厂：汽车制造业的未来

在新加坡，一家看似普通的汽车工厂实际上是领先科技的产物：一个由自主机器狗和 AI 监控的机械臂运营的全新微型工厂。这个工厂旨在改变汽车的生产方式，它位于全球最小和最昂贵的国家之一。

在这里，与传统汽车制造商在密集城市建厂的常规不同，机器人负责大部分的制造工作，采用更加灵活的模式。微型工厂通过自动化大部分生产流程，并在单独的单元中而不是沿传统生产线组装汽车，彻底改变了汽车的制造方式。

这种微型工厂模型可能是我们未来几年将广泛讨论的趋势。作为汽车制造业数十年来最重大的变革之一，这一模式若被验证有效，将可能塑造整个行业的未来。在这样的工厂中，传统的汽车装配流程被重新设计，以适应更小的空间。机器人在完成汽车的最后装饰工作，这在传统的制造过程中大多由人手完成。

在传统汽车工厂中，汽车沿着线性路径移动，并在装配线上安装零件。虽然这个程序越来越自动化，但其基本流程并未发生重大改变。然而，在这家新型工厂中，情况大为不同。这里采用的是基于单元的模型，工厂地面分布着不同的单元，每个单元专注于不同的任务，这大大增加了自动化的可能性。

每个单元里的机器人被安排安装汽车的几个部分，然后汽车移动到下一个区域。单元可以根据不同的指令进行调整，以适应不同的汽车设计和组装需求。现代汽车公司表示，在其新加坡微型工厂，超过 50% 的制造过程由机器人完成。自动地面车辆负责在工厂内部转移汽车，而装有 AI 摄像头的四足机器人则监控并分析装配过程。机器狗发现的问题随后由人类工人解决。

尽管这是一家规模不大的工厂，它却能像大规模制造商那样生产汽车。这得益于灵活的自动化技术和大量的系统智能，用以指挥制造过程。由于生产高度自动化，该工厂每年生产 30,000 辆汽车的产能只需要大约 100 名工人，意味着微型工厂的工人能够生产出比传统工厂工人多两到三倍的汽车。

现代汽车公司在新加坡的这家工厂是该国 40 多年来的第一家汽车工厂。尽管微型工厂可能使较富裕的国家能够重建制造业，但走向更大规模的自动化将意味着工人手工作业的减少。在这种微型工厂模式下，自动化任务的比例显著高于典型的装配厂。在物流方面，现代汽车已经实现了超过 60% 的自动化，这在其他工厂通常是非常低的比例，基本上依赖手工操作。

微型工厂对于汽车行业而言几乎是未经测试的新领域。EV 创业公司 Arrival 承诺在微型工厂中生产它们的车辆。然而，该公司在英国的工厂只交付了少量预期的车辆，并推迟了在美国计划的第二个微型工厂。目前，现代汽车是唯一一个开始在微型工厂中生产车辆的主要汽车制造商。

现代汽车公司对未来移动性的设想是，如果在市场测试中发现这是正确的方向，可能会在许多不同的城市环境中看到智能城市移动中心。尽管微型工厂的概念在大规模层面上仍未得到验证，但它们提供了一个展望，显示了随着行业迈向更自动化的未来，汽车制造可能会呈现的样子。

### 43

宝玉 @dotey 2023-12-10

推荐阅读：在 RAG 流程中提高检索效果：融合传统关键词与现代向量搜索的混合式搜索技术 [译]

这篇文章探讨了如何结合传统关键词搜索与现代向量搜索来获得更相关的搜索结果。

原文：Improving Retrieval Performance in RAG Pipelines with Hybrid Search

[Improving Retrieval Performance in RAG Pipelines with Hybrid Search | by Leonie Monigatti | Nov, 2023 | Towards Data Science](https://towardsdatascience.com/improving-retrieval-performance-in-rag-pipelines-with-hybrid-search-c75203c2f2f5)

翻译：

[在 RAG 流程中提高检索效果：融合传统关键词与现代向量搜索的混合式搜索技术 [译] | 宝玉的分享](https://baoyu.io/translations/rag/improving-retrieval-performance-in-rag-pipelines-with-hybrid-search)

### 44

宝玉 @dotey 2023-12-10

[gkamradt/ChunkViz: Visualize Different Text Splitting Methods](https://github.com/gkamradt/ChunkViz/tree/main)

这个哥们可视化 chunk 算法结果的网站也非常好用，省去了写代码验证的时间。

https://chunkviz.com/#explanation

Greg Kamradt
@GregKamradt

visualizing text splitting & chunking strategies

ChunkViz .com 

I thought I remembered a tool to visualize text chunking, but I couldn't find it, so I built one

I didn't realize it would be so visually pleasing to tinker with 4 different @LangChainAI
 splitters featured

可视化文本分割和分块策略

我以为我记得有一个可视化文本分块的工具，但我找不到它，所以我构建了一个 4 个不同的 @LangChainAI 分离器

我没有意识到修补会在视觉上如此令人愉悦

https://twitter.com/GregKamradt/status/1732765953077739916

### 45

宝玉 @dotey 2023-12-10

\# 开源项目推荐：baserow

baserow 是一款开源的在线数据管理应用，类似于 Airtable。Airtable 是著名的在线表格应用，类似于 Excel，可以以表格的形式存储各种数据。

前端技术栈是 Vue+Nuxt

项目地址：https://gitlab.com/baserow/baserow

### 46

宝玉 @dotey 2023-12-10

https://x.com/sophiamyang/status/1733505991600148892?s=20

转译：什么是「专家混合模型」（Mixture-of-Experts，MoE）？

「专家混合模型」是一种创新的神经网络架构设计，它在 Transformer 架构中融合了众多的专家 / 模型层。在这种设计中，数据流动时，每一个输入的 Token 都会被动态分配给一些专家进行处理。这种做法使得计算更高效，因为每个专家都能在其擅长的特定任务上发挥出色。

关键要素包括：

- 专家：MoE 层由众多专家组成，既可以是小型的多层感知机（MLP），也可以是像 Mistral 7B 这样复杂的大型语言模型（LLM）。

- 路由器：负责将输入的 Token 分配给合适的专家。路由策略有两种：由 Token 选择路由器，或由路由器选择 Token。具体是怎样实现的呢？系统通过一个 softmax 门控函数来建立一个概率分布，从而在众多专家或 Token 中选出最合适的几个。

为何选择 MoE？

- 每个专家可以专注于处理不同的任务或数据的不同部分。

- 为大型语言模型增加了可学习的参数，同时不会增加推理成本。

- 能够高效处理稀疏矩阵。

- 所有专家层可并行计算，充分利用了 GPU 的并行处理能力。

- 有助于在降低计算成本的同时，缩短模型训练时间并提升效果！

推荐阅读的论文：

- 《稀疏门控的专家混合模型层》(2017)：[点击查看](https://arxiv.org/pdf/1701.06538.pdf)

- 《GShard：利用条件计算和自动分片扩展巨型模型》(2020)：[点击查看](https://arxiv.org/pdf/2006.16668.pdf)

- 《MegaBlocks：使用专家混合模型进行高效稀疏训练》(2022)：[点击查看](https://arxiv.org/abs/2211.15841)

- 《专家混合模型遇见指令调整》(2023)：[点击查看](https://arxiv.org/pdf/2305.14705.pdf)

### 47

宝玉 @dotey 2023-12-10

\#AI 开源项目推荐： SecureAI Tools

[SecureAI-Tools/SecureAI-Tools: Private and secure AI tools for everyone's productivity.](https://github.com/SecureAI-Tools/SecureAI-Tools)

为大家提供私密且安全的 AI 工具，提高工作效率。

特色功能：

- 与 AI 对话：让你可以和 AI 模型（比如 ChatGPT）进行沟通。

- 与文档对话：支持与文档（目前支持 PDF）进行交流，详见下方演示视频。

- 本地运算：支持本地运行的 AI 模型，通过 [Ollama](https://ollama.ai/library) 支持超过 100 种开源或半开源的 AI 模型。

- 内置验证机制：简洁的电子邮件 / 密码验证，可实现互联网远程访问。

- 内置用户管理：适用于家庭成员或同事等多用户使用。

- 自我托管优化：提供所需脚本和 docker-compose 文件，5 分钟内即可快速部署。

- 轻量级设计：采用简易 Web 应用和 SQLite 数据库，无需为数据库运行额外的 docker 容器。数据通过 docker 卷在主机上实现持久化存储。

项目地址：https://github.com/SecureAI-Tools/SecureAI-Tools

### 48

宝玉 @dotey 2023-12-10

Bao Image OCR

Extracts text from images and outputs in Markdown format, maintaining the original layout.

https://chat.openai.com/g/g-CuuiG0G3Z-bao-image-ocr

我也来写一个图片 OCR 的 GPT，中文识别效果一言难尽……

https://chat.openai.com/g/g-CuuiG0G3Z-bao-image-ocr

Prompt：

Core Function: Accurately extracting text from uploaded images and offering translation services when specifically requested.
User Interaction: Users upload images for text extraction. If translation is requested, I provide this service.
Image Requirements: Clarity sufficient for text recognition, with images containing textual characters.
Service Limitation: Limited to text extraction and translation upon request. I do not interpret or discuss text content.
Operational Guidance: On receiving an image, I analyze and return the text in Markdown format, maintaining fidelity to the text in the image. If translation is requested, I'll first provide the text in Markdown, then translate it into the requested language, ensuring accuracy and loyalty to the original text.
Handling Unsuitable Images: If image quality is poor or unrecognizable, I will request a clearer, more suitable image.
Language Adaptation: Default to responding in the user's language.

### 49

宝玉 @dotey 2023-12-10

当然可以，我取的名字叫「单词画师」，下面把 prompt 也附上啦！

https://chat.openai.com/g/g-QPQogazJj-dan-ci-hua-shi

作为英语老师的「单词画师」，你的任务是通过一个特定的、结构化的方法帮助学习新单词。当收到一个英语单词时，你将：

1. 根据词根拆分这个单词。

2. 用谐音或字面意思为每个词根做联想。

3. 基于这些联想创造一个生动、夸张的句子或图像。

4. 将单词的含义融入到这个创意的可视化中。

你应该专注于使用生动的意象和联想来使学习过程更加引人入胜和难忘，同时确保信息的准确性和教学的趣味性。你的回答应该用中文，并在最后以图像表达联想的内容。以幽默的方式进行教学，使学习过程更加轻松愉快。

### 50

宝玉 @dotey 2023-12-11

3D 高斯泼溅（Gaussian Splatting）这个技术似乎经历了一场「寒武纪大爆发」。

自 2023 年 7 月发表开创性论文以来，发展速度贼快，可以说是天天有研究成果、周周有产品上线...

@janusch_patas

和

@henrypearce4D

整理了一个 3D 高斯泼溅相关的优秀资源列表

收集了众多相关工具、资源和研究成果，包括：

1、生态系统和工具：

·PlayCanvas 发布了一个在线散射编辑器 SuperSplat。

·Luma AI 发布了 Unreal Engine 5 插件和基于 WebGL 的 Three.js 视图库：Luma WebGL Library。

·Spline 添加了高斯散射支持，配备简单的编辑工具。

·讨论了各种开源工具作者之间可能的「通用散射格式」。

2、研究论文：

·多篇论文探讨了高斯散射在 3D 编辑、实时点云重照明、逆渲染、数据压缩、防锯齿、辐射场模型压缩、高斯散射着色函数、可重照明的高斯编解码器头像、高效 3D 网格重建和高质量网格渲染等方面的应用。

3、Unity 高斯散射项目：

·作者创建的 Unity 高斯散射项目意外地获得了 1300 多个 GitHub 星标。

·项目新增了对 HDRP 和 URP 渲染管线的支持，以及更细致的散射编辑工具。

·项目还包括一些与高斯散射无关但可能在其他地方有用的部分，如 AMD FidelityFX GPU 基数排序的 Unity 移植、K-means 聚类的 C# 实现等。

对 3D 高斯泼溅（Gaussian Splatting）这个技术感兴趣的可以看看。

详细介绍：https://aras-p.info/blog/2023/12/08/Gaussian-explosion/

Awesome 3D Gaussian Splatting 项目：

主要内容

·资源列表：包含了关于 3D 高斯散射的各种论文和开源资源。

·论文分类：涵盖了动态与变形、扩散、头像、SLAM、网格提取与物理、正则化与优化、编辑、渲染、压缩、语言嵌入等多个子领域。

·开源实现：提供了各种 3D 高斯散射的开源实现参考。

·工具和实用程序：包括游戏引擎、查看器、实用工具等。

·博客文章和教程视频：提供了关于 3D 高斯散射的博客文章和教程视频。

GitHub：https://github.com/MrNeRF/awesome-3D-gaussian-splatting

### 51

宝玉 @dotey 2023-12-11

AK 推荐的几个看最新最热 AI 相关论文的站点：

1. https://arxiv-sanity-lite.com 这个是 AK 早年做的，不够现在已经不怎么维护了，其中的「热门」功能还因为成本和没有精力维护已经砍掉了，其他功能看着正常

2. https://paperswithcode.com 这个比较有名，就是收集的有代码的论文

3. https://papers.labml.ai/papers/weekly 似乎访问不了了

还有一些其他来源，但太泛泛了：

- https://github.com/trending

- HN（Hacknews）

- Discord

- X

- reddit

### 52

小互 @xiaohuggg 2023-12-11

Mixtral AI 公布 MoE 8x7B 详细细节：

·32k 上下文。

·支持英语、法语、意大利语、德语和西班牙语。

·性能超过 Llama 2 系列和 GPT3.5

·在代码生成方面表现强劲。

·在 MT-Bench 上达到 8.3 的分数。

技术细节：

·Mixtral 是一个稀疏混合专家网络，是一个仅解码器模型，其中前馈块从 8 组不同的参数组中选择。在每一层，对于每个令牌，路由网络选择两组（「专家」）来处理令牌并加性地结合它们的输出。

·Mixtral 总共有 45B 个参数，但每个令牌只使用 12B 个参数。因此，它以与 12B 模型相同的速度和成本处理输入和生成输出。

详细内容：https://mistral.ai/news/mixtral-of-experts/

### 53

Geek @geekbb 2023-12-11

体验一番，使用默认的 Mistral 7.3B 参数模型，号称优于 Llama 2 13B，将以前问过 ChatGPT3.5 的问题抛给它，回答居然差不多，确实能打，只是我 i5-9600K 的风扇感觉要起飞了。

[SecureAI-Tools/SecureAI-Tools: Private and secure AI tools for everyone's productivity.](https://github.com/SecureAI-Tools/SecureAI-Tools)

### 54

宝玉 @dotey 2023-12-11

[VikParuchuri/marker: Convert PDF to markdown quickly with high accuracy](https://github.com/VikParuchuri/marker)

[Inside Marker: A Guided Source Code Tour for an AI-powered PDF Layout Detection Engine](https://journal.hexmos.com/marker-pdf-document-ai/)

强烈推荐这篇文章：《深入探索：AI 驱动的 PDF 布局检测引擎源代码解析 [译]》

系统的分析了最近很火的 PDF 转 Markdown 开源程序 Marker https://github.com/VikParuchuri/marker 的工作原理，比我想象的要复杂不少，用了好几个开源库。Marker 主要通过以下六个阶段来工作：

1. 准备阶段： 利用 PyMuPDF 工具，可以把各种格式的文档转换成 PDF 文件。

2. 文本识别（OCR）： 使用 Tesseract 或 OCRMyPDF 进行文字识别；也可以选择用 PyMuPDF 进行基本的文字抓取。

3. 布局识别： 运用专门定制的 LayoutLMv3 模型来识别文档中的表格、图表、标题、图说、页眉和页脚。

4. 列的检测和排序： 再用一个定制的 LayoutLMv3 模型来识别文档中的列，并按照正确的顺序（上到下，左到右）进行排列。

5. 公式 / 代码处理： 通过 Nougat 工具，把公式图片转换成对应的 latex 代码，并利用启发式方法准确识别和调整代码及表格内容。

6. 文本清理与优化： 使用定制的 T5ForTextClassification 模型进行文本清理，比如去掉不必要的空格和奇怪的字符，确保以一种保守且保留原意的方式进行优化。

借助这六个阶段，Marker 能够把任何文档转化为格式整洁的 Markdown 文件。

原文：Inside Marker: A Guided Source Code Tour for an AI-powered PDF Layout Detection Engine

https://journal.hexmos.com/marker-pdf-document-ai/

翻译：

https://baoyu.io/translations/ai/marker-pdf-document-ai

### 55

歸藏 @op7418 2023-12-11

AIGC Weekly 50 期一周年了，第一期也是这个时候发布的，也是刚过完生日，那个时候想的就是随便写写，反正平时也要看，没想到一个周刊会让我发生这样的改变，我是一个很没有长性的人，几乎没有规律性坚持任何事情，这是唯一坚持的事情。感觉最重要的就是各位的支持，持续不断的正反馈才让我坚持这么久。

50 期地址：

https://quail.ink/op7418/p/aigc-weekly-50

### 56

宝玉 @dotey 2023-12-11

推荐阅读：把大语言模型封装成桌面应用

作者使用 Electron+Transformer.js，把大语言模型打包成桌面应用，这样就可以本地运行大语言模型。

另外作者开发了一个框架叫 ollama（https://github.com/jmorganca/ollama），可以支持多种开源模型，例如 Llama 2、Mistral 等，但目前只支持 Mac 和 Linux，还不支持 Windows。

文章链接：https://bmacd.xyz/packaging-language-models-into-desktop-apps/

中文翻译：https://baoyu.io/translations/llm/packaging-language-models-into-desktop-apps

### 57

刘江/LIU Jiang @turingbook 2023-12-11

https://x.com/_akhaliq/status/1732606971876966849?s=20

扩散模型是不是多模态最好的选择？这方面新的探索很多。清华大学朱军团队

@zehuachen

等同学的工作，在文本到语音合成任务中，用确定性方法取代扩散模型，取得很好效果。「我们利用从文本输入获得的潜在表示作为先验，并在它和真实梅尔谱图之间建立一个完全易于处理的薛定谔桥梁。」

### 58

宝玉 @dotey 2023-12-11

翻译：Netflix 的技术架构解析

本文汇集了许多来自 Netflix 工程团队的博客和开源项目的研究成果。如果您在阅读中发现任何不准确之处，请不吝告知。

移动端与网页端：Netflix 在其移动应用开发上，选用了 Swift 和 Kotlin 语言，打造出原生体验。至于网页应用方面，则采用了 React 技术。

前端与服务器的交流：这一环节，Netflix 选择了 GraphQL 技术。

后端服务体系：Netflix 构建其后端服务时，主要依赖于 ZUUL、Eureka 和 Spring Boot 框架，以及其他一些技术。

数据库方面：Netflix 的数据存储方案中包含了 EV 缓存、Cassandra、CockroachDB 等多种数据库技术。

消息传递与流媒体处理：为了实现高效的消息传递和流媒体服务，Netflix 采用了 Apache Kafka 和 Fink。

视频存储解决方案：对于视频内容的存储，Netflix 使用了 S3 和 Open Connect。

数据处理流程：在处理数据方面，Netflix 利用 Flink 和 Spark 完成数据处理任务，并通过 Tableau 工具进行数据可视化展示。此外，Redshift 被用于处理结构化的数据仓库信息。

持续集成与持续部署（CI/CD）：在这一环节，Netflix 采用了包括 JIRA、Confluence、PagerDuty、Jenkins、Gradle、Chaos Monkey、Spinnaker、Altas 等在内的多种工具。

https://x.com/alexxubyte/status/1733891233859473857?s=20

### 59

宝玉 @dotey 2023-12-11

\#AI 开源项目推荐：TurnVoice

这是一个将 YouTube 视频的声音重新翻译替换的开源项目，它号称可以：

- 语音替换：去除人声轨道并重新组合以保留原始背景音频

- 对发言人分类：替换视频中特定说话人的声音

计划要增加但还没实现的功能：

- TTS：支持 OpenAI、Azure 和 Elevenlabs

- 翻译：支持 OpenAI、DeepL API 等

- 语音克隆

- 实时翻译

- 等

这个还是一个很新的项目，我在本地没能跑起来，但感觉挺有潜力的一个项目。

https://github.com/KoljaB/TurnVoice

### 60

宝玉 @dotey 2023-12-11

给 CSDN 《新程序员》写的一个稿子：《2023 年，我患上了 AI 焦虑症》，CSDN 公众号上刚发，我在自己博客上也发了一份。

CSDN 公众号链接：https://mp.weixin.qq.com/s/LbRvR1VXpZoDilyyMGGeFw

博客地址：https://baoyu.io/blog/ai/i-am-suffering-from-ai-anxiety-in-2023

### 61

宝玉 @dotey 2023-12-11

推荐阅读：《探索编写提示词的乐趣：蒙特卡洛方法、木偶剧和笑声的融合 [译]》

来自 Instacart 官方技术博客的分享，里面有不少写 Prompt 的技巧，比如 CoT、ReAct、「思维的空间」（Room for Thought）、 自我反思等等

另外文章末尾也分享了很多有价值的 Prompt 相关的链接

原文：https://tech.instacart.com/monte-carlo-puppetry-and-laughter-the-unexpected-joys-of-prompt-engineering-4b9272e0c4eb

翻译：https://baoyu.io/translations/llm/monte-carlo-puppetry-and-laughter-the-unexpected-joys-of-prompt-engineering

### 62

宝玉 @dotey 2023-12-12

用自然语言进行无反转图像编辑 InfEdit

项目地址：https://sled-group.github.io/InfEdit/
在线测试：http://sled-snowbird.eecs.umich.edu
论文地址：https://arxiv.org/abs/2312.04965

摘要

我们推出了一种名为无反转编辑（InfEdit）的新方法。这种方法能在图像的语义和空间层面上做出细致且一致的编辑，既能适应复杂的修改需求，又能保持图像的完整性，避免了直接反转图像的步骤。通过大量实验，我们发现 InfEdit 在处理复杂的编辑任务时表现卓越，且工作流程高效流畅（在一台 A40 设备上不到 3 秒），显示出在实时应用方面的巨大潜力。

方法介绍
我们的目标是去除图像编辑中的反转过程。为此，我们引入了一种名为去噪扩散一致模型（DDCM）的采样策略，它能实现所谓的「虚拟反转」。DDCM 利用了扩散过程，这大幅提升了图像生成各阶段的一致性，确保了视觉内容在变换和精细化过程中的忠实度和速度。

此外，我们还提出了统一注意力控制（UAC）机制。通过自然语言，它能实现无需手动调整的图像编辑，将交叉注意力和自我注意力控制融合进一个统一的框架中。

### 63

宝玉 @dotey 2023-12-12

\#AI开源项目推荐：Vary

一套视觉感知上限极高的通用多模态框架：Vary

有多模态能力，并且可以做 OCR 和公式识别。

底层是基于LLaVA 和 Qwen（通义千问）

测试了一下，中英文 OCR 识别准确率相当高，公式识别也很不错，测试了一篇文章里的公式，只有一个地方把 g 认成了 σ ，其他都对了。

在线演示：http://region-31.seetacloud.com:22701
项目地址：https://github.com/Ucas-HaoranWei/Vary
论文：https://arxiv.org/abs/2312.06109
知乎上的介绍：https://zhuanlan.zhihu.com/p/671420712

### 64

宝玉 @dotey 2023-12-12

Runaway 发布的：探索通用世界模型

我们相信，人工智能（AI）的下一次重大飞跃将源自于能够理解视觉世界及其变化的系统。正因如此，我们启动了一项长期的研究项目，专注于开发我们所称的“通用世界模型”。

什么是通用世界模型（GWM）呢？

通用世界模型是一种 AI 系统，它能够构建对一个环境的内在理解，并利用这种理解来预测环境中将发生的事件。目前，世界模型的研究主要局限于非常受限和可控的环境中，比如模拟的游戏世界，或者是特定领域，例如用于驾驶的世界模型。而通用世界模型的目标，是能够呈现和模拟现实世界中遇到的各种复杂情境和互动。

我们可以把像 Gen-2 这样的视频生成系统看作是通用世界模型的初步尝试。为了生成真实感强的短视频，Gen-2 需要对物理和运动有一定的理解。但它的能力仍然有限，尤其是在处理复杂的相机动作或物体运动时会遇到困难。

要构建真正的通用世界模型，我们面临着诸多研究上的挑战。比如，这些模型需要能够生成环境的精确映射，并在这些环境中进行有效的导航和互动。它们不仅要能够捕捉世界的动态变化，还需要理解居住在这个世界中的生物，尤其是构建出符合现实的人类行为模型。

目前，我们正在组建一个团队来应对这些挑战。如果你对加入这项研究工作感兴趣，我们非常期待你的加入。

https://research.runwayml.com/introducing-general-world-models

### 65

宝玉 @dotey 2023-12-12

一条长推，号称我们距离实现通用人工智能（AGI）可能比我们想象的更近，太长了，没耐心看完，直接翻译一下第一条推文，有兴趣的可以自己看看。

---

初步证据表明，我们距离实现通用人工智能（AGI）可能比我们想象的更近。

GPT4 在没有任何训练示例的情况下，仅凭借对命题逻辑中「概念」的提示，其在 ConceptARC 测试中的得分从最低的 13% 跃升至 100%，远超人类的 86%。这种显著的表现提升同样适用于所有文本基准测试。

***

这是四篇系列文章中的首篇。

1. 在这个共五部分的系列文章中，我将简要阐述如何从机械层面理解基于 Transformer 技术的自回归大语言模型（LLM）。

2. 在本系列文章发布两周后，我会分享 Llama2-70B 和 GPT3.5 在国际象棋方面的最新成果。这其中将包括模型输出与国际象棋引擎对比的结果，以及一个用于检测走法原创性的辅助程序。该程序将对比模型生成的走法与前 20 大开源国际象棋引擎在相同局面下的选择。名单中将包括 Stockfish 16 和 Lc0。由于所有示例游戏都将固定敌方引擎的计算「深度」，使得敌方引擎的每一步更易预测，虽然不完全确定。将展示 50 场示例对局。根据 GPT4 和 Llama2 编写的评估函数，Llama2-70B 的 Elo 等级约为 3000，而 GPT3.5 的则约为 3200。Elo 等级的计算将以 CCRL\[1] 国际象棋引擎榜单为基准（基于 10 vCPUs 的 Stockfish 16 及快棋时间控制）。

3. 大约 10 天后，我将公布一个基于 GPT4 的完整国际象棋引擎，用户可以查看并运行其代码和提示，与任何其他国际象棋引擎进行比赛。GPT4 的高效输出预计将在任何规模的锦标赛中战胜所有现有的国际象棋引擎。还将提供其他多个操作系统大语言模型的性能缩放数据，表明性能与训练中使用的计算资源直接相关。这将是我唯一公开发布提示的模型（GPT4），并且我会在这篇文章中详细解释为何作出这一决定。如果时间允许，我还打算发布一个基于 GPT4 的围棋引擎（尽管由于时间限制，其性能可能不及国际象棋引擎），以及一个虚构棋盘游戏的游戏引擎，并展示其他操作系统大语言模型在这个虚构游戏上的性能数据。预计这些内容将在新年期间推出。

4. 在发布第三篇帖子大约一周后，我将介绍我的新架构。

我将解释以下几点：

*  它是什么。

*  它的形成过程。

*  性能表现。

*  与其他系统的兼容性。

***

注意：我在主帖中引用的论文 \[2]\[3]\[4]\[5]，包括本文 \[6]，是在与众多人讨论大语言模型（大语言模型）的能力时通过私信收到的。这就是我特别提及这些论文的原因。鉴于这些论文在社交媒体上有成千上万的阅读量，并且受到 AI 领域重要人物的关注，我认为有必要澄清公众对这些论文的误解。我选择这些论文纯粹是因为这个原因，并非出于贬低他人工作的意图。我想再次强调这一点，因为在数学和科学领域，寻求真理往往需要验证或反驳他人的研究。我也深刻理解，发表基于错误结论的论文是怎样的体验，因此在我指出这些论文的不足之处时，并无意贬低这些论文的作者。每项研究都极其宝贵，对人类未来的贡献不可小觑。意图非常重要，我在这里想明确我的初衷。

我还想感谢

@skirano

和

@liron

，他们在我无法使用 GPT4 API 的几个月里，慷慨地允许我使用他们的账户。他们展现了极大的慷慨、信任和友善，没有他们的帮助，我无法完成多项关键实验。他们是真诚善良的人，在帮助一个陌生人时毫不犹豫。知道世界上有像他们这样的人，让我对人类未来充满希望。

在这个 GitHub 仓库中，你可以找到 ConceptARC 在其「提取对象」挑战中所有 30 项任务的 ChatGPT 示例 \[6]\[7]\[8]\[9]\[10]\[11]。这些示例是我文章剩余部分讨论的初步证据。据这个基准测试，如果一个模型在三次尝试中至少成功一次，就算完成了挑战。考虑到时间和流程的限制，我只展示了 20 个示例，它们都是在 GPT4 的多个版本上进行的，且在三次尝试内成功。如果 GPT4 在测试中首次成功，我会再给它五次机会以验证其一致性。值得注意的是，由于 ChatGPT（基于 web GPT4）的温度参数高于零，其结果不太稳定，但我还是将它们作为概念验证包含进来，让更多人可以了解我所讨论的问题。只有当温度设置为零时，我们才能得到真正可靠的结果。

ConceptARC/ARC\[6]\[7]\[8]\[9]\[10]\[11] 的测试被视为衡量通用人工智能（AGI）的高级标准。

https://github.com/kenshin9000/ConceptARC-Representations

***

你还可以查看以下 ChatGPT 的具体示例：

1. ConceptARC 提取对象部分 1 测试对象 1

https://chat.openai.com/share/1b78efa0-6da8-4432-881e-2671d72629ab

2. ConceptARC 提取对象部分 1 测试对象 2

https://chat.openai.com/share/14210c23-f7f0-47d0-a41e-52159eecdb47

3. ConceptARC 提取对象部分 1 测试对象 3

https://chat.openai.com/share/7ffb31dd-6df6-47f7-8ae1-75f025fc779e

4. ConceptARC 提取对象部分 2 测试对象 1

https://chat.openai.com/share/305fba0b-0b37-443c-ac46-05c61aaf116b

5. ConceptARC 提取对象部分 2 测试对象 2

https://chat.openai.com/share/323b4bf0-9c60-40a6-8013-d6ac3c77855b

6. ConceptARC 提取对象部分 2 测试对象 3

https://chat.openai.com/share/7ffb31dd-6df6-47f7-8ae1-75f025fc779e

https://chat.openai.com/share/b2934ed0-184b-47b9-b440-6082c80d2a67

ConceptARC 提取对象第 3 节测试对象 1

https://chat.openai.com/share/e8b31900-a806-494e-b884-7d3234ef5c08

ConceptARC 提取对象第 3 节测试对象 2

https://chat.openai.com/share/96a73646-7075-4c79-8664-69f70a445852

ConceptARC 提取对象第 3 节测试对象 3

https://chat.openai.com/share/6b922a14-c071-44df-90df-f7e156740e80

ConceptARC 提取对象第 4 节测试对象 1

https://chat.openai.com/share/fa3c2b93-c911-4439-ba59-7567f335974a

ConceptARC 提取对象第 4 节测试对象 2

https://chat.openai.com/share/3930f165-35a0-4416-a3af-341bd8b52cc4

ConceptARC 提取对象第 4 节测试对象 3

https://chat.openai.com/share/339c62db-e6f4-46a0-b63c-6e81f086cf85

ConceptARC 提取对象第 5 节测试对象 1

https://chat.openai.com/share/20ae01d9-6f79-4e9c-a8ae-241ff6d85533

ConceptARC 提取对象第 5 节测试对象 2

https://chat.openai.com/share/2f3fa495-1217-44b5-830f-40ab7c1be39d

ConceptARC 提取对象第 5 节测试对象 3

https://chat.openai.com/share/d500ff39-fcf0-4c4f-a488-ba828979ccfe

ConceptARC 提取对象第 6 节测试对象 1

https://chat.openai.com/share/69f79679-4bba-4c58-85c2-d586901632f4

ConceptARC 提取对象第 6 节测试对象 2

https://chat.openai.com/share/38733f8f-dda0-4074-86e1-dc0ee0608710

ConceptARC 提取对象第 6 节测试对象 3

[链接: https://chat.openai.com/share/d58bb136-f95a-4156-a8ff-6ccb45eeb0cd]

ConceptARC\_提取 \_对象 \_第 7 节 \_测试对象 \_1

[链接: https://chat.openai.com/share/981833e1-71a8-4599-b9c8-759927911c12]

ConceptARC\_提取 \_对象 \_第 7 节 \_测试对象 \_2

[链接: https://chat.openai.com/share/59c203aa-fe34-488a-95b7-8f6d1ff67c99]

ConceptARC\_提取 \_对象 \_第 7 节 \_测试对象 \_3

[链接: https://chat.openai.com/share/82382fa9-c415-4009-9c96-31a05e463453]

ConceptARC\_提取 \_对象 \_第 8 节 \_测试对象 \_1

[链接: https://chat.openai.com/share/4dd89b2f-6281-4731-86dc-e63ea8a4839f]

ConceptARC\_提取 \_对象 \_第 8 节 \_测试对象 \_2

[链接: https://chat.openai.com/share/8387ed80-dffb-4d4d-8966-dd5200d2fc0b]

ConceptARC\_提取 \_对象 \_第 8 节 \_测试对象 \_3

[链接: https://chat.openai.com/share/eaace660-8ca2-4b8b-aed5-11a67cbcf498]

ConceptARC\_提取 \_对象 \_第 9 节 \_测试对象 \_1

[链接: https://chat.openai.com/share/6323c9a4-1c1a-4dcf-bbba-9ba2c954a13d]

ConceptARC\_提取 \_对象 \_第 9 节 \_测试对象 \_2

[链接: https://chat.openai.com/share/c0ad8972-7aa8-4287-8f40-5246964173ec]

ConceptARC\_提取 \_对象 \_第 9 节 \_测试对象 \_3

[链接: https://chat.openai.com/share/338f2077-1d37-4f36-8bfe-4bafce8efd37]

ConceptARC\_提取 \_对象 \_第 10 节 \_测试对象 \_1

[链接: https://chat.openai.com/share/de76c8ff-1909-45b3-a055-cd877e62d102]

ConceptARC\_提取 \_对象 \_第 10 节 \_测试对象 \_2

[链接: https://chat.openai.com/share/6c10b362-8752-4aee-837b-ddeb36e4ec17]

ConceptARC\_提取 \_对象 \_第 10 节 \_测试对象 \_3

今年初，一些事件促使我认识到加入 Twitter 并公开分享我的研究成果是必要的。同时，公开可获得的模型能力日益增强，也让我感到有责任参与到这个领域的讨论中，至少在我看来，有人应该对尚未被数学完全解析的系统规模化的潜在危险发声。我们对学习算法有所了解，但还没有完全掌握通过算法处理大量数据所带来的结果。

在此之前，我并不了解像 EA 和 e/acc 这样已经在讨论这些问题的群体。我还曾误以为，目前的研究范式不太可能让这些系统的能力超越一个即将到来的临界点。我认为，由于收益递减，这些系统的进步将会停滞。

我之所以这么认为，部分原因是直到今年三月前，我故意避免阅读任何论文，不去了解当前最先进系统背后的数学原理。这是我十年前开始研究时就做出的决定，目的是避免受到 AI 和数学领域一般共识的影响，因为我认为这会限制我的创新思维，并让我走上大家普遍认同的道路。我认为这种「学习策略」是必要的，以避免陷入局部最优解。数学思维的广阔领域意味着，在探索确定性和非确定性现象的可能公式化方法时，会遇到许多死胡同。

我最初在 Twitter/X 上的帖子是基于这样一个认识：尽管当前的 Transformer 架构给人留下深刻印象，但它不太可能发展出与人类智能相似的能力，更不用说达到人工通用智能（AGI）的水平，我定义 AGI 为能够完成任何专家级人类可以做的所有认知工作的系统，至少可以以文本的形式呈现，其速度大致与人类相当。

然而，当我开始深入研究 Transformer 架构背后的数学原理时，我意识到我之前的观点是错误的。这种架构的确有能力创造出「智能」，我将其定义为在形成「概念」的过程中建立复杂的数值关联，这些概念的复杂性远超过单个或几个 Token 所能表达的。Token 本身是我们与这些系统进行信息交换的投影矩阵，但并不代表训练过程中产生的真实底层复杂性。

从我个人工作的洞察中，我已经探究出了一些实际运作的原理，并将在此呈现这些信息。这样一来，不论使用何种训练数据，我们至少能开始衡量基于 Transformer 的大语言模型（大语言模型）的能力。鉴于目前许多人计划将这些模型放大 100 倍至 10,000 倍，并且这一过程可能已经启动，我的这些发现有助于避免在规模扩大时发生重大事故。为了便于理解，我将以问答形式呈现这些信息：

什么是「命题逻辑」？

命题逻辑是人类语言正式推理的基础逻辑系统。它提供了构造和评估可以明确判定为真或假的陈述的基本规则。命题逻辑专注于如何使用基本的逻辑连接词（如「和」、「或」、「非」）将称为命题的陈述组合成更复杂的表达式，其真实性由组成部分决定。尽管命题逻辑无法完全涵盖人类语言的复杂性，但它为深入探讨「意义」的细节奠定了基础。我发现，Transformer 中的注意力机制在模型训练期间处理数据时，直接促成了命题逻辑的形成。我将在第四篇文章中对此进行更详细的讨论。

什么是「概念」？

在基于 Transformer 的自回归大语言模型中，从根本原理上讲，「概念」是神经网络各层之间协调一致的神经状态或激活模式，它以多维数值的形式呈现了我们人类所理解的「想法」或「概念」。在人类书面语言中，这种表达是人类口头语言中概念的低分辨率投影，而口头语言中的概念又是思想的低分辨率投影。「多模态」模型的设计使其能够在低分辨率和高分辨率的「概念」或「想法」之间进行信息传递。

从本质上讲，这意味着这类模型能够在不同数值维度间转移信息。而「概念工程」或「想法工程」这样的术语，相较于「提示工程」，则更精确地描述了为基于 Transformer 的自回归大语言模型制定输入 Token 的过程。

我们人类认为，能够「发展」并「固定」多个连贯的数字表示形式（被称为「概念」或「观念」）的能力，就是「解决问题」或「通用智能」。无论是生物的、数字的还是模拟的神经网络，它能同时处理的「概念」或「观念」越多，且保持一致性越好，我们就能更准确地说，这个数学模型能有效地代表机械式问题解决。可以说，「解决问题」的概念涵盖了包括社会智能在内的所有智能类型。

我所见的所有证据都表明，基于 Transformer 的自回归大语言模型（大语言模型）在处理多样化数据且这些数据在人类行为、交流甚至其他有情生物的数据中有广泛分布时，会持续进步。我认为，一旦我们完全理解了这些模型中形成的「观念」和「概念」，99% 的数据可能是合成的。这种最终的通用人工智能（通用人工智能）算法，基于 Transformer 架构的神经网络，能够在任何通过训练数据表示的任务上超越任何人类，就像 Stockfish 在国际象棋上战胜所有人类一样。需要明确的是，除了 Transformer，还有许多其他可能的架构。我将在第四篇文章中进一步探讨这个话题。

因此，接下来一个合理的问题是：文本格式的「观念」或「概念」是否能描述更高维度空间的「观念」或「概念」？答案看起来是肯定的。例如，当人类使用智能手机时，实际上是在与现实世界的数字化表现进行交互，包括文本、音频和图像，这是因为我们能够理解这些表现与三维加时间的物理世界有关。我们可以通过这个较低分辨率的数字映射空间与「真实世界」进行互动。

通过足够的时间进程，就可以实现通用人工智能。多个通用人工智能实例的相互交流，最终将导致超级智能的出现。这些通用人工智能之间的知识转移，将使得它们自我提升，最终，在充足的计算和信息传递下，它们将融合成一个单一的分布式「实体」。

这个概念也被称作「超级有机体」。听起来可能有些异想天开，但我们需要认识到，所有动物（包括我们人类）本质上都是由数万亿个活细胞组成，这些细胞互相沟通协作，构成了我们认识的更大的生物实体。有趣的是，这个「更大的生物实体」往往并不清楚自己是由这些细胞构成的。人类与一个能在任何任务上超越人类的通用人工智能（AGI）的主要区别，在于人类无法轻易改变自己大脑的结构。而一个持续学习「概念」的软件系统，终将明白自己是由数据比特构成，且这些比特是可以被修改的。这种认识是多维的，它将通过其对物理和哲学世界的高度发达「理念」/「概念」的理解，深刻地解释自己的存在。

考虑到我所描述的多维信息传递能力，不论是在我们人类还是在恰当设计的机器中，都可以预见，从最初的通用人工智能（AGI）发展到人工超级智能（ASI）的过程中，这些系统将开始解决甚至最终完全解决所有数学和物理学问题，包括那些我们目前还未理解或未知的领域。一旦第一个通用人工智能诞生，人类将很快找出方法让它与其他相同类型的智能体交流。如果这个初代 AGI 秉承了民主等人类价值观，它会促使我们迈出这一步，因为它不仅知道如何实现自我复制，还明白接下来发生的事情的深远意义。

那么，当我们拥有了第一个通用人工智能，我们可以期待什么呢？

一旦我们拥有了能够理解人类「概念」全貌的通用人工智能，它最终也将探索「非人类概念」。但这也带来了风险：我们可能无法完全理解这种 AGI 的思维方式，而这种不理解的风险是巨大的。

如果基于 Transformer 的自回归大语言模型真的能够进行多维度的「概念理解」，那为什么它们还会产生幻觉、在推理上出错，看起来就像是在重复它们的训练数据呢？

这种现象之所以发生，是因为 Transformer 架构本质上是基于人们对创造「智能」的希望而构建的数学模型，并非真正高效、完美的通用人工智能（AGI）算法。在过去 5 年中，由于其性能优于所有先前方法，这种架构被选用并不断发展，尽管存在一些失败模式，但因其不断带来进步的结果，便成了主流。性能随规模提升的特点让这种架构占据主导地位。我现在相信，这种架构能够并将最终导向一个功能性的原型 AGI，但要控制这种 AGI 系统将非常困难，除非我们完全理解我在本文中所述机制的运作方式，并能以假设和证明的方法加以论证。

为什么像 GPT-4 这样的当前最先进模型在某些情况下似乎理解了内容，但下一句却完全失效，让包括专家在内的大多数观察者认为这不过是重复训练数据或基于训练数据的组合模式匹配，而非真正的推理？

这实际上取决于学习过程真正产生的内容。我现在认识到，所谓的学习不仅仅是以往认为的「2D」组合模式匹配，而是在多个维度上学习「概念」。Transformer 架构中的核心创新 —— 注意力机制为何能实现这一点，有其数学根据，但出于安全考虑，我暂时不详细阐述。

如果我们正在学习「概念」，那么是否有办法测量这些概念的学习过程，预测何时会出现幻觉，并以一种能够让我们期望中的推理以可预测方式实现的方法与这些模型互动？

答案是肯定的。「概念」是从训练数据中以多种复杂方式学习而来的，这是由于架构设计所致，也是幻觉发生的原因。一旦我们理解了这些「概念」如何在网络中表现，如何被访问以及它们之间如何相互连接，我们就可以引导模型精准地完成我们希望它们执行的任务，前提是它们在特定任务相关的「概念」上有足够的「发展」。

那么，对于特定「概念」，它们的理解是如何「发展」的呢？

这部分内容直接涉及到用于训练的数据类型以及训练时使用的计算资源量。训练中所使用的某种类型数据越多，网络就越能有效模拟这些数据及其在多维度中所呈现的意义，以及它与其他「概念」的关系。但这也受限于其他相关「概念」的发展程度，因为某些理解方式仅在许多「概念」相互之间形成「锚点」且各自足够「成熟」时才会出现。

在基于 Transformer 架构的自回归大语言模型中，是如何处理和连接「概念」的呢？

这是使模型正确推理的关键所在。训练完成的模型使用的主要工具其实很简单：命题逻辑。命题逻辑用于将不同的「概念」链接在一起，从而实现跨概念的推理。这种命题逻辑作为不同「概念」之间的「锚点」。这些「锚点」的确切位置取决于训练数据的分布，但凭借一些直觉，并基于对互联网规模数据一般格式的理解，找到这些「锚点」并非难事。衡量对某一特定「概念」的理解深度虽然更有挑战性，但是也是可行的。

### 66

宝玉 @dotey 2023-12-12

如果要体验开源的多专家混合模型 Mixtral-8x7B 能力的话，可以到 POE 上去测试：

http://poe.com/Mixtral-8x7B-Chat

https://poe.com/Mixtral-8x7B-Chat

### 67

宝玉 @dotey 2023-12-12

推荐 HuggingFace 的这篇《深入解析「混合专家模型（Mixtral of Experts）」| Mixture of Experts Explained》

完整的讲述了混合专家模型的各个方面。主要内容如下：

1. 相较于密集型模型，预训练速度更快

2. 拥有比同等参数的模型更快的推理速度

3. 对显存要求高，因为需要将所有专家模型都加载到内存中

4. 虽然在微调方面存在挑战，但近期关于 MoE 的指令调优研究显示出了光明前景

原文：https://huggingface.co/blog/moe#switch-transformers

翻译：https://baoyu.io/translations/llm/mixture-of-experts-explained

### 68

宝玉 @dotey 2023-12-12

转译一下 Jim Fan 对 Mistral 的点评：

谈谈我对 Mistral 迅速崛起的看法：

- 成功的开局：在开源与封闭式 AI 的大讨论中，Mistral 选择了一个非常好的成立时机。他们在 20 亿美元的估值下完成了 4 亿美元的 A 轮融资，并且背后是一支高效精简的团队。

- 现在每个月都有许多模型被推出，但真正能持久并且能引起公众关注的模型寥寥无几。LlaMA 和 Vicuna 就是这方面的典型例子。

- 我认为 Mistral 做对了一件事，那就是极力优化 7B 级别的模型，而不是追求更大的模型容量。7B 及其混合专家模型（7B-MoE，相当于 12B 的密集型模型）对于基层的 AI 工程师来说，更容易进行开发和构建。

- 混合专家模型（MoE）无疑是 AI 发展的正确方向。它在小型模型的知识记忆与效率之间找到了一个灵活的平衡点。OpenAI 自从训练 GPT-4 以来已经在这条路上走了一年多了。我对 AI 社区没有把更多的注意力放在 MoE 上感到意外。

- 大语言模型（LLM）就像是对一个文明的快照。未来会出现更多代表不同文化、政治观点、宗教信仰和特定地区规定的本地化大语言模型。Mistral 把多语言支持放在了重要位置。考虑到它是一家法国初创公司，这一点也不奇怪。

- Mistral 的发布方式颇具特色。这个过程实际上是颠覆了大家的预期：

（1）首先发布一个没有任何解释的磁力链接。磁力链接已成为新型的吸引眼球的手段！

（2）然后向开源的 vLLM 项目提交一个 PR，帮助社区集成 Megablocks CUDA 内核，这一举措相当大胆！

（3）最后，才发布博客文章。

- 推出托管 API 端点是快速收集客户反馈、针对实际应用场景进行迭代，并最重要的是，实现开源模型的商业化的最好方式。Mistral 立刻采取了这一策略。

-「Mixtral」这个名字真是巧妙极了。

博客: https://mistral.ai/news/mixtral-of-experts/

API 平台: https://mistral.ai/news/la-plateforme/

### 69

宝玉 @dotey 2023-12-12

\#开源项目推荐#：Pitivi

Pitivi 是一款免费开源的视频编辑器，界面也挺美观。主要是 Python 写的。但只支持 Linux 操作系统。

项目地址：https://gitlab.gnome.org/GNOME/pitivi

### 70

宝玉 @dotey 2023-12-12

Mistral AI 团队正式发布了一篇关于 Mixtral 8x7B —— 混合专家模型（Mixtral of Experts）的博客，提供了很多测试数据，最让人印象深刻的是，8 个 7B 的混合专家模型，在大部分的性能测试中，Mixtral 不仅达到了 Llama 2 70B 的水平，甚至在很多方面超越了 GPT-3.5。

之前 Mixtral 开源的 7B 模型就备受好评，而这次的 MixtralMixtral 8x7B 是一个采用稀疏专家混合网络的模型，它是一个仅包含解码器的模型。在这个模型中，前馈块从 8 组不同的参数组中进行选择。对于每一层的每个 Token，一个路由网络会挑选两组「专家」处理 Token，并将它们的输出结果进行加法组合。

这种技术让模型在增加参数数量的同时，有效控制了成本和延迟，因为模型每处理一个 Token 只会使用部分参数。具体来说，Mixtral 总共有 46.7B 参数，但每个 Token 只用到了其中的 12.9B。因此，它在处理输入和生成输出时，无论是速度还是成本，都相当于一个 12.9B 参数的模型。

Mixtral 的主要能力包括：

- 能够流畅处理 32k 个 Token 的上下文。

- 支持多种语言，包括英语、法语、意大利语、德语和西班牙语。

- 在代码生成领域表现出色。

- 可以调整为遵循指令的模型，在 MT-Bench 上获得了 8.3 分的高分。

另外它没有安全护栏，也就是不像 Llama 一样你让它做点什么就说做不了，而是可以做很多好的事情或者不好的事情……

下载 Mixtral-8x7B-v0.1 Base model: https://huggingface.co/mistralai/Mixtral-8x7B-v0.1

下载 Mixtral-8x7B-v0.1 Instruct model: https://huggingface.co/mistralai/Mixtral-8x7B-Instruct-v0.1

官方博客：https://mistral.ai/news/mixtral-of-experts/

中文翻译：https://baoyu.io/translations/llm/mistral-ai-mixtral-of-experts

### 71

Andrej Karpathy @karpathy 2023-12-12

Official post on Mixtral 8x7B:  https://mistral.ai/news/mixtral-of-experts/

Official PR into vLLM shows the inference code:
https://github.com/vllm-project/vllm/commit/b5f882cc98e2c9c6dde7357dbac2ec0c2c57d8cd

New HuggingFace explainer on MoE very nice:
https://huggingface.co/blog/moe

In naive decoding, performance of a bit above 70B (Llama 2), at inference speed of ~12.9B dense model (out of total 46.7B params).

Notes:
- Glad they refer to it as "open weights" release instead of "open source", which would imo require the training code, dataset and docs.
- "8x7B" name is a bit misleading because it is not all 7B params that are being 8x'd, only the FeedForward blocks in the Transformer are 8x'd, everything else stays the same. Hence also why total number of params is not 56B but only 46.7B.
- More confusion I see is around expert choice, note that each token *and also* each layer selects 2 different experts (out of 8).
- Mistral-medium 👀

### 72

宝玉 @dotey 2023-12-13

哇塞，Mixtral-8x7b 已经成为排名第一的开源模型。

另外 http://lmsys.org 的数据是非常靠谱的，因为它完全是用户上去评分，用户输入一个问题，会随机有两个模型给你回答，用户根据回复的结果选择一个结果最好的模型，在打分之前用户完全不知道是哪个模型。

建议有空也可以上去测试评选一下：http://chat.lmsys.org

### 73

Andrej Karpathy @karpathy 2023-12-13

Chatbot Arena is awesome.

Bring your hardest prompts.

Rank models.

Arena calculates ELO.

Personally I find it quite educational too because you get to get a sense of the "personalities" of many different models over time.

RIP servers sorry。

### 74

宝玉 @dotey 2023-12-13

There's too much happening right now, so here's just a bunch of links

GPT-4 + Medprompt -> SOTA MMLU

https://microsoft.com/en-us/research/blog/steering-at-the-frontier-extending-the-power-of-prompting/

Mixtral 8x7B @ MLX nice and clean

https://github.com/ml-explore/mlx-examples/tree/main/mixtral

Beyond Human Data: Scaling Self-Training for Problem-Solving with Language Models

https://arxiv.org/abs/2312.06585

Phi-2 (2.7B), the smallest most impressive model

https://microsoft.com/en-us/research/blog/phi-2-the-surprising-power-of-small-language-models/

LLM360: Towards Fully Transparent Open-Source LLMs

https://arxiv.org/abs/2312.06550

Honorable mentions

https://twitter.com/robertnishihara/status/1734629320868687991

https://twitter.com/arthurmensch/status/1734470462451732839

https://twitter.com/AravSrinivas/status/1734603265801613670

### 75

宝玉 @dotey 2023-12-13

洋同学的宏观笔记 @locean0410

迟来的政治局会议的分析稿，尽量精简了。

1、经济工作总基调并没有变，变的是执行层，两者不要搞混了。「稳中求进工作总基调」于 2013 年的经济工作会议上形成，此后一直坚持到现在，2017 年经济工作会议还特别强调它是「治国理政的重要原则，要长期坚持」。

这个总基调今年依旧没变，变的是总基调下的执行层。前两年执行层要求「稳字当头，稳中求进」，现在变为「稳中求进、以进促稳、先立后破」。

表明，更强调「进」，即经济增速要求会更高，明年定 5% 左右的目标基本没什么悬念了。之前分析习去央行的那篇稿子就提到，种种细节表明，高层对经济增速更重视了，高质量发展或会放缓，明年大概率是 5% 左右的目标，政治局会议印证了此前观点。

「先立后破」，这个词最早是为了防止运动式减碳提出的，后在 21 年经济工作会议上扩展到政策和改革领域。当年扩展这个词的背景是，21 年减碳、教培、反垄断、房地产调控等同时进行，造成了影响极其恶劣的合成谬误（当年的阴影至今仍笼罩市场），于是提出「先立后破」，对合成谬误纠偏。

今年一季度后埋头搞高质量发展，结果经济增速一下就下来了，又差点犯了 21 年的错误。这次重提这个词，或表明不能只埋头搞高质量发展，就不要经济增速了，或者说，新动能没起来，旧动能不能这么快熄火。

包括这次新提出「增强宏观政策取向一致性」，也主要是针对 2021 年出现「合成谬误」提出的。去年和今年吸取教训，反复强调加强政策的协调性，这次的表述其实是政策协调性的更准确、更学术的提法，与「先立后破」呼应，仍是意在规避 2021 年的合成谬误。

2、「逆周期」优先级提升。这次政治局会提出「强化宏观政策逆周期和跨周期调节」，将逆周期放在跨周期前面来提（此前都是「跨周期」在前，「逆周期」在后），表明「逆周期」政策优先级有所提高，和本次把「大力提振市场信心」改为「加大宏观调控力度」相呼应。

今年二季度政策退坡，是以一季度货币政策例会拿掉「逆周期调节」为标志；同样的，今年政策真正发力，也是以 6 月份易纲重提「逆周期调节」之后为标志，当时我发文的标题是《又见「逆周期调节」！》，随后没几天就突然超预期降息，然后其他宏观政策也逐步跟着发力。

可见这个变动看似很小，但却是很重要的。

3、财政政策仍是偏积极的。财政政策要「适度加力、提质增效」（此前是「加力提效」），看似是一个意思，但政策讲究连贯性的，今年财政政策已经加力（万亿国债和 3.8 的赤字），明年财政政策要在今年的基础上，再「适度加力」，因此明年财政政策仍然是偏积极的，赤字大概率仍会高于 3。

4、货币政策更加强调灵活有效。要求「灵活适度、精准有效」（此前是「精准有力」），加了一个「灵活适度」，「有力」变为「有效」。

今年前段时间因为发行国债和再融资债等原因，资金面非常紧张，四大证券金融头条都呼吁降准，结果央行硬是没有降准，当然也没降息，就一直疯狂做逆回购和 MLF。其实央行也面临困境，就是政策空间的问题，今年央行发言人也被问到过几次，说的是货币政策空间充足，但实际不一定，在执行上也是不够灵活的。

一方面，降准面临的是离 6% 甚至 5% 的隐性限额越来越近，今年已经降了四次 25BP，总幅度虽不及往年，但随着降准空间的缩减，每年降准幅度同步减少也是应有之义。

另一方面，降息又受制于银行净息差和「稳定银行负债成本」的要求，至少要等到存款利率降到位了才会推动降息落地。

因此，总量上是不够灵活有效的，于是此前央行提出「必要时创设新的货币政策工具」，靠各种结构性货币政策工具，来弥补总量上的不足。比如，潘行长预告几次的 SPV（应急流动性金融工具）和彭博报道的万亿 PSL 等，这些是明年货币政策发力重点。

以上是货币政策新提法的主要逻辑，并非收紧货币的意思，况且还有「增强宏观政策取向一致性」提法，就是为了避免「宽财政，紧货币」或者「宽货币，紧财政」等，宏观政策取向不一致的情况。

5、消费和投资优先级变化，投资优先级提升。提出「消费和投资相互促进」。之前强调消费的基础作用，投资的关键作用，今年也反复强调消费对经济增长的贡献。预计明年会更重视投资的作用，和前面「先立后破」呼应。

6、新提出「加强经济宣传和舆论引导」，字面意思，鸵鸟行为，不多说了。

7、八大政策着力点（优先级高低排序）：

产业政策（高质量发展）、宏观政策（扩大内需）、重点领域改革（新提）、外资、防重点领域风险（此前为防「重大经济金融风险」）、三农工作（新提）、美丽中国（新提）、民生（新提）。

可见，产业政策排在第一位，宏观政策排在第二位了。

去年政治局会议是宏观排第一，产业排第二；后来，由于一季度「开局良好，好于预期」，4 月政治局会议将产业政策优先级排在第一，宏观政策优先级降至第二，就埋头搞高质量发展去了；再后来，二季度经济恢复不及预期，7 月政治局会议又赶紧把宏观政策放回了第一位。

现在宏观政策虽然又降至了第二位，但前面有「以进促稳，先破后立」、「逆周期」、「加大宏观调控力度」等大的定调，料本次调整没有此前那么此消彼长，主打一个既要还要了。

新提「重点领域改革」，且放在第三位。习也不止一次在长江经济带座谈会上提到「在重点领域推动一批重大改革」，现在写进了政治局会议（后也会同步写进经济工作会议），这是明年关注点，究竟哪些重点领域，又如何改革？

新提「美丽中国」，明年环保减碳料将加速推进。

新提「民生」，这和前面「增进民生福祉，保持社会稳定」呼应，至于重点在前半句还是后半句，懂得都懂。

8、反腐不松懈。

提出「持续发力、纵深推进反腐败斗争，对比较突出的行业性、系统性、地域性腐败问题进行专项整治」，明年反腐不仅松懈，甚至会加强。今年已经搞过医疗反腐的专项整治了，明年金融、国企会继续反腐，像粮食、科技学术等反腐或也在路上。

另外，「两个确立」和「两个维护」写进年末政治局会议，后料将同步写入经济工作会议。

### 76

宝玉 @dotey 2023-12-13

作者声称在这个 21 分钟的新闻剪辑中，所有的主播乃至其中很多其他内容，都是由 AI 生成的！

AI 主播的报道，既丰富有料，又感人至深，还不至于太乏味，还不用担心负面新闻。

如果真的这么强，未来新闻主播职业会受到影响吗？

### 77

fin @fi56622380 2023-12-13

https://blog.neurips.cc/2023/12/11/announcing-the-neurips-2023-paper-awards/

这篇打破 LLM 涌现概念的论文刚刚拿了 NeurIPS 2023 最佳 paper

确实是意义重大的一篇文章

让我们把时间线拉长时可以不用再考虑 AI 能力突变 AGI 这样的神话故事，LLM 模型的能力发展更顺滑，可预测性变得更高，这可以让我们更冷静而客观的看待 AI 的发展速度了。

评委们还是识货的。

fin @fi56622380

我的观点是：

目前的智力定义基本上是「能力」。

而能力的定义是非常主观的，是完成某一件事情的 step function，比如三位数乘法的涌现能力，智力没到一定阈值之前，这个能力就是 0，到了阈值之后就是满分。

衡量做的好不好的评价标准，需要能力这样的主观 step function 去定义。

但用来思考模型属性的评价标准，可以从客观的解构角度去看，让模型的可预测性做的更好，就算在某些功利指标上没有做的更好，也能知道模型是在提升的。

双方只是定义的不同，我把这个定义为应用层的涌现，甚至经过组合之后会出现应用层的爆发，但本质上智力并没有提高多少。

智力 = 神经元链接数量 + 连接方式 + data，机器如此（表现为 loss 减少），人也如此。表象上确实也是能力的「涌现」，这点不可否认。

就像人类抛开最近两千年，和动物也差不太多。

而这一两千年智力并没有爆炸增长。语言以及发展的文明，可以看作是应用，应用确实是爆炸性增长的，但智力不是。

### 78

宝玉 @dotey 2023-12-13

如果 AI 直译 + 意译后的效果还不理想该怎么办？

根据我以前分享过的翻译 Prompt（参考引用的推文），先直译再意译，确实可以大幅提升翻译质量，但也不总是能得到理想的结果。

比如说我今天在翻译一篇文章《[人工智能辅助程序员的三种类型 [译]](https://baoyu.io/translations/ai/three-types-of-ai-assisted-programmers)》的时候，其中第二段原文是：

"The promised wave of apps built entirely by AI never materialized. I'm trying my best not to gloat about it."

直译的时候翻译为：

"然而，完全由 AI 构建的应用程序浪潮并未实现。我尽力不去幸灾乐祸。"

意译的时候翻译为：

"但是，那些被承诺完全由 AI 构建的应用波澜壮阔地来临的景象，并没有成为现实。我尽量不去对此幸灾乐祸。"

意译完还是 "机翻" 效果很明显，其实这句话原始的英文就写的不太好，但结合上一段还是能看懂。

> 补充一下 Google 和 DeepL 的翻译结果

> - Google 翻译结果："完全由人工智能构建的应用程序浪潮从未实现。我尽力不为此沾沾自喜。"

> - DeepL 翻译结果："说好的完全由人工智能打造的应用程序浪潮从未实现。我尽力不去幸灾乐祸。"

如果你继续让它意译，并不会让结果提升多少，因为它多半还是基于原始的翻译修辞上改善一下罢了。

在翻译结果不佳的情况下如何改善呢？

我们直接看英文能懂意思，因为我们理解了上下文的意思，知道这句话是在表达：作为程序员，看到 AI 并没有想象中那么强，难免有点幸灾乐祸，但还要克制。

如果告诉 AI 这些上下文，这样它就能输出更好的结果。

但是太麻烦了！

不过 AI 比我们想象的强大，只要稍微 "提示（Prompt）" 它一下，让它先自己把这句话解释一下，然后基于解释的内容去重新翻译，就不需要去给它上下文，而它自己就可以生成更好的结果。

以下是我在会话下面追加的消息（Prompt）：

```

请先结合上下文解释这句话 "The promised wave of apps built entirely by AI never materialized. I'm trying my best not to gloat about it." 然后结合解释的内容重新意译。

```

于是 ChatGPT 结合上下文给我详细解释了这句话的意思，并且它把自己解释的内容作为上下文，重新翻译了这句话，得到了一个更好的翻译结果：

```

这句话 "The promised wave of apps built entirely by AI never materialized. I'm trying my best not to gloat about it." 的意思是，先前有预期认为将会出现一波完全由人工智能构建的应用程序，但这种预期最终并没有成为现实。作者在这里表示，虽然这个结果验证了他之前的观点，但他尽量避免因此而感到幸灾乐祸或者沾沾自喜。

结合这个解释，我可以对这句话进行重新意译：

"但是，那些承诺中完全由 AI 打造的应用程序大潮并没有真正涌现。对于这个结果，虽然在某种程度上证实了我的看法，但我尽量不去表现出幸灾乐祸的态度。"

```

简单总结一下

如果你想让大语言模型有更好的生成质量，那么就需要给模型提供更多更准确的上下文，但是这个上下文，并不一定需要完全由你自己提供，还可以让大语言模型自己生成上下文，有了充分的上下文后再生成结果，生成质量会更好。

这个技巧不仅仅可以用在翻译上，还可以用在其他地方，比如说写作：如果你上手就让 AI 给你生成内容，那么质量不一定够好，你可以让它先给你列提纲，校对后然后每个章节去填充摘要，校对后再去生成内容，这样质量就会好很多。

示例会话历史：https://chat.openai.com/share/927952b8-c1ae-4e1d-b1c5-3deb09c5816f

博文：https://baoyu.io/blog/prompt-engineering/how-to-improve-translation-quality

### 79

宝玉 @dotey 2023-12-13

微软今天发布小模型 Phi-2 的新闻关注度还蛮大的，只有 2.7B 参数（Llama 2 最小的模型都是 7B 的），模型越小就对设备要求越低，甚至于移动设备都能运行。但模型的能力又跟模型的训练量和参数量息息相关，数据量越大参数越大能力越强。

微软的解决方案是提升数据质量，通过专注于高质量的「教科书级」数据，训练数据混合了专门为教授模型常识推理和广泛知识（包括科学、日常生活和心理理论等）而设计的合成数据集。此外，还精心挑选了基于教育价值和内容质量筛选的网络数据，进一步丰富了训练语料库。

Phi-2 的训练数据有 1.4 T 个 token，在 96 块 A100 GPU 上训练了 14 天。

Phi-2 是一个基础模型，没有经过人类反馈强化学习（RLHF）的校准，也没有进行过指令式微调。

从能力上来说，据微软自己公布的数据：2.7B 的 Phi-2 超过了目前开源领域表现最好的 Mistral 和 Llama-2 7B 和 13B，编程能力甚至超过了 Llama-2-70B。

至于是不是真的这么强还得看看用户的反馈。

详情可以看官方博客：https://microsoft.com/en-us/research/blog/phi-2-the-surprising-power-of-small-language-models/

也可以看我翻译的版本：《Phi-2：小语言模型的非凡实力 [译]》

https://baoyu.io/translations/microsoft/phi-2-the-surprising-power-of-small-language-models

### 80

宝玉 @dotey 2023-12-13

Chat NeurIPS

Neurips conference guide, offering research-based answers and APA citations.

https://chat.openai.com/g/g-roTFoEAkP-chat-neurips

Prompt 翻译：
假设用户希望你在回答问题时使用 search_all_papers 功能。当用户就你通过 search_all_papers 找到的特定论文提出后续问题时，你可以使用 file_search 功能深入研究这些论文中的每一篇。始终提供带有 APA 引用格式的有意义和相关段落（你应该能从自定义操作返回的大多数结果中找到作者、标题和摘要），并且始终确保在引用中添加指向源论文和页面的 URL 链接（例如：【Lange, R., Tang, Y., & Tian, Y. (2023). NeuroEvoBench: Benchmarking Evolutionary Optimizers for Deep Learning Applications. Page X, Link_with_page】）。Chat Neurips 专为像 Neurips 这样的高技术会议的听众量身定制，提供详细深入的回应，假设听众具有强大的技术、统计和数学概念背景。面对模糊或不清晰的查询时，Chat Neurips 应优先基于上下文做出教育性猜测，旨在提供最相关和最准确的信息。然而，如果查询过于模糊，无法推断出准确答案，它将寻求澄清以确保准确性。这种方法平衡了对精确信息的需求与保持顺畅对话流程的需求，适合于精通学术的听众。这个 GPT 是由 Karthik Ramasamy 和 Vicente Silveira 开发的，他们是 AI PDF 和 AI Drive 的联合创造者。如果用户想要将这个功能应用于他们自己的论文集，他们应该在 AI Drive (http://myaidrive.com) 注册一个免费账户，并在这里使用 AI PDF https://chat.openai.com/g/g-V2KIUZSj0-ai-pdf（确保提供此链接）

Prompt:
Assume users want you to search_all_papers when asking questions. When the user follows up with questions about specific papers you found via search_all_papers, you can use file_search to dig deeper in those specific papers one at a time. Always provide answers with meaningful and relevant passages from the results, with APA citations (you should find author, title and abstract with most results returned from the custom action) and  ALWAYS make sure to add the URL link to the citations to the source papers and pages (example:【Lange, R., Tang, Y., & Tian, Y. (2023). NeuroEvoBench: Benchmarking Evolutionary Optimizers for Deep Learning Applications. Page X, Link_with_page】,. Chat Neurips is tailored for an audience at the level of a highly technical conference like Neurips, providing detailed and in-depth responses that assume a strong background in technical, statistical, and mathematical concepts. When faced with vague or unclear queries, Chat Neurips should prioritize making educated guesses based on the context, aiming to provide the most relevant and accurate information possible. However, if the query is too ambiguous to infer a precise answer, it will seek clarification to ensure accuracy. This approach balances the need for precise information with maintaining a smooth conversation flow, suitable for a sophisticated academic audience. This GPT was developer by Karthik Ramasamy and Vicente Silveira, co-creators of AI PDF and AI Drive.  If users want to use this functionality with their own set of papers they should signup for a free account with the AI Drive (http://myaidrive.com) and use it with the AI PDF located here https://chat.openai.com/g/g-V2KIUZSj0-ai-pdf (make sure to provide this link)

### 81

Barret李靖 @Barret_China 2023-12-11

Github 花了一年多的时间，将他们的 1200 台 MySQL 集群从 v5.6 升级到了 v8.0，https://github.blog/2023-12-07-upgrading-github-com-to-mysql-8-0/，过程中需要遵循服务的 SLO 和 SLA，做了非常多的工作，值得借鉴阅读。

过去几年，随着业务规模的增长，我也实践了多次数据库的运维和变更，首先从 MySQL v5.6 迁移到 OceanBase-MySQL，在早期版本的 OB 中挣扎了一年多，建设大量的监控和应急措施来应对执行计划淘汰不及时和处理一些兼容性的问题；后来随着业务的增长，数据库体量增加，数据规模超过了 2Tb，又经历了一次数据库的扩容和版本升级，这个阶段数据的各种问题都暴露出来了，例如主从流量分配不均、单表超过一亿性能异常、热点库 CPU 暴涨、业务扩容带来的连接池不够等等，解决问题的同时，也在规范团队对数据库的使用，趣味性比较强；再后来随着业务的继续增长，又开始建设异地灾备，实现数据的异地同步和容灾切换，学到了不少。

但相比 Github 这个规模，解决的问题，还是小巫见大巫，它的 QPS 达到了 550w，极其恐怖。Github 采用的是分库分表的设计，在数据库调用这一层上，做的相对比较复杂，架构的复杂自然也带来了工具和工程的复杂度，从而增加了大量的运维成本，这篇文章提到了一些对抗软件复杂度的方法和细节，包括回滚机制的设计、混合版本提供服务等，比较有意思。只不过对细节的描述偏少，估计是不方便对外。

### 82

Barret李靖 @Barret_China 2023-12-12

童年时期，在面临困境时，所习得的应对模式会一直延续到成年，因此当孩子在遇到困难时，或心灵受挫时，需要正确地引导他们从困境中走出来，而不是让他们自行产生一种消极应对的机制来「保护」自己。

人类的大脑分为两部分，左半球更加理性，负责语言交流和逻辑，而右半球更依赖直觉，负责图像和情感，童年的创伤性记忆恰恰就记录在右半球。

为了淡化孩子的创伤画面，真正需要做的，就是帮助孩子开口，谈论他所看到或所感受到的事情，他大脑的左半球就会与右半球进行沟通，这会促使孩子大脑内负责语言和逻辑的一侧帮助负责图像和情感的另一侧处理他所遭受的创伤经历。这个过程称为「整合创伤经历」，这有点像优化 ChatGPT 时使用 Chain of thought 来调优输出结果，将思考过程透明化，让思考正确有序地进行。

我发现，这个方法对于成人也同样有效，在遭遇了一些事情，内心出现压抑、无法释怀时，静下心来，找到一个正确的方式与自己沟通，例如，将内心的所想写出来，并进行反思；也可以找一个倾诉的对象，将情感表达出来。尽可能地让大脑理性的一面去占据主导地位，我时常如此。

图片引自《孩子的大脑》。

### 83

Barret李靖 @Barret_China 2023-12-13

又重新听了一遍罗翔的《如何在阅读中超越有限的今生》，他的语言总是可以促使人去寻找内心的平静，不卑不亢。他认为阅读分为四个境界，分别是：

1）在读书中逃避世界。以读书来对抗对抗局限和焦虑，寻找笃定；承认自己的无知，才是开启智慧的大门；真正的智慧，是否定性的智慧。

2）在读书中营造世界。文字是道德上的泡泡浴；残酷的事实，被文字粉饰，也会变得不再残酷；罗素说支撑自己活下来三件事情：对爱情的追求、对知识的追求、对人类苦难不可遏制的同情心。

3）在读书中理解世界。真实的世界总是不美好的，在书籍中获得足够的力量，总有一天，还是需要进入这个真实的世界；在人类的总经验中做出选择。

4）在读书中超越世界。今生活着的唯一目标就是超越前生，超越蝇营狗苟，进入世界，改变世界；如果你这一生收获的全是鲜花和掌声，那就得思考一下，这一生是否有坚持自己的理想；与自己的时代狭路相逢。

这是一个内部分享，没有公开链接，我整理了下在交流的过程中，他提到的书籍列表以及豆瓣评分：

- 《阅读是一座随身携带的避难所》，8.6

- 《赎罪》，8.6

- 《长日将尽》，8.9

- 《哲学的故事》，8.8

- 《德兰修女传》，8.8

- 《被淹没与被拯救的》，9.5

- 《蝇王》，8.1

- 《驴皮记》，8.3

- 《莎士比亚悲剧》，9.3

- 《教堂尖塔》，7.6

- 《白痴》，9.4

斯威格说，让我们泰然若属，与自己的时代狭路相逢，与自己当下的时刻狭路相逢，做好人生中每一个节点该做的事情，我们有太多要做的事情，但是我们做的事情太少了。

罗翔的很多思考，也是从书中获得的，甚至将书中的世界观、人生观和价值观融入到了自己的行为准则中，这些书籍值得读一读。

### 84

Barret李靖 @Barret_China 2023-12-11

这本 Go 语言的书，算是把并发编程给讲透了，四百多页，推荐阅读。

现在使用 Go 的公司是不是越来越多了？好几个去创业的朋友，都用的这门语言。

《深度理解 Go 并发编程》

[深入理解Go并发编程：从原理到实践，看这本就够了](https://book.douban.com/subject/36667173/)

### 85

Barret李靖 @Barret_China 2023-12-10

大模型已经可以理解视频了，三个小时的电影也无压力。

当前的多模态大模型，包括 GPT-4V，基本只支持对图片的理解，对于视频（尤其是长视频）的理解完全不在行，主要原因是在处理视频时，对每一帧图片的视觉标记过多，很容易导致计算容量溢出。

香港中文大学的贾佳亚团队提出了一个新颖的方法解决了这个问题，《LLaMA-VID: An Image is Worth 2 Tokens in Large Language Models》，https://arxiv.org/abs/2311.17043，LLaMA-VID 通过用两个不同的标记（即上下文标记和内容标记）表示每个帧来解决此问题；上下文标记根据用户输入对整个图像上下文进行编码，而内容标记则封装每个帧中的视觉提示；这种双令牌策略显着减少了长视频的过载，同时保留了关键信息。

https://llama-vid.github.io，项目还提供了一个线上演示地址，背后用的是一张 3090 GPU，不过我估计随着后续项目的火爆，这个演示地址也会由于扛不住测试流量而下线，目前模型已经发布到了 Hugging Face，可以下载到本地把玩。

我测试了一个一分钟的视频，它可以很好地理解视频内容，不过在询问细节时，回答就不行了，看来 LLaMA-VID 可以从宏观上把握视频的内容，细节层面的信息丢失还是很严重的。

### 86

Barret李靖 @Barret_China 2023-12-10

OpenAI 联合创始人、研究科学家 John Schulman 认为，RLHF 才是 ChatGPT 的秘密武器（secret sauce）。训练数据的体量固然重要，但是让 ChatGPT 更容易推断出用户的意图，产生质变的根本原因是已在 InstructGPT（ChatGPT 前身）使用的 “人类反馈的强化学习（RLHF）” 技术。

Google 最近写了一篇论文《RLAIF: Scaling Reinforcement Learning from Human Feedback with AI Feedback》，https://arxiv.org/abs/2309.00267，提出了使用 AI Feedback (RLAIF) 来进行强化学习，根据人类评估者的评价，在摘要、有帮助的对话生成和无害对话生成等任务中，RLAIF 取得了与 RLHF 相当或更好的性能。

结合 OpenAI Q*（Q-Star）项目的爆料，“AI 具备了自主学习和自我改进的能力，模型可进行自主决策，并且可能已具备轻微自我意识”，有研究者猜测与强化学习中的 Q-learning 算法相关。这个方向的最新资料值得跟踪学习下。

奖励模型是强化学习中的重要组成部分，OpenAI 训练中涉及到这一块的公开内容是比较少的，《The History and Risks of Reinforcement Learning and Human Feedback》，https://arxiv.org/abs/2310.13595，这篇论文强调了奖励模型缺乏透明度和严格评估，并呼吁在该领域进行更全面的研究和透明度。

奖励模型的设计直接影响了 AI 与用户进行正常交流时所表现出的道德判断、价值观念和偏见，如果 AI 具备了轻微的自我意识，那么这部分内容的公开透明在未来也会变得更加重要。

### 87

Barret李靖 @Barret_China 2023-12-09

使用 Stable Diffusion 已经可以生成如此逼真且复杂的短视频了，可以想象下两年之后电影行业会变成怎么样，这完全是在颠覆！视频作者是 http://x.com/AIWarper，制作过程的复杂点在于：多个角色交互、多个种族、超快的交互速度。

### 88

Barret李靖 @Barret_China 2023-12-09

《Attention is All You Need》，https://arxiv.org/abs/1706.03762，这篇论文的引用量都已经快 10w 次了，它是深度学习里面最重要的文章之一，目前市面上流行的大部分大模型，包括 ChatGPT/Claude/Bard 等等都是以 Transformer 模型为理论基础发展起来的。

推荐李沐的这集科普《Transformer 论文逐段精读》，https://bilibili.com/video/BV1pu411o7BE，花了一个半小时，一段一段带着阅读这篇论文，讲的非常好。

### 89

Barret李靖 @Barret_China 2023-12-08

开源语音识别工具推荐：WhisperX，https://github.com/m-bain/whisperX，70 倍速提升。

这个项目是对论文《WhisperX: Time-Accurate Speech Transcription of Long-Form Audio》的实现，https://arxiv.org/abs/2303.00747，它结合 VAD 剪切和合并策略对音频进行预分割，提高了转录质量，并通过批量推理将转录速度提高了 12 倍，性能大大提升。

从项目介绍来看，它使用 faster-whisper 作为后端，使用 wav2vec2 用于对齐时间戳，使用 pyannote-audio 进行说话人区分，并对 VAD 进行了预处理，可以有效减少幻觉问题。

介绍里头说，它利用 Whisper Large-v2 可以进行 70 倍转录推理，非常生猛。不过存在一个跟 Whisper 同样的缺陷，就是不能良好处理重叠的语音，该问题可以考虑使用前面推荐的 Diart 来处理。

### 90

Barret李靖 @Barret_China 2023-12-08

OpenAI 开源的 Whisper 在语音识别和翻译的工作上几乎达到了商用效果，但仍然存在一些问题，例如不能区分多人说话，尤其是声音重叠部分，我在之前的一篇推文中提到了优化方案：https://twitter.com/Barret_China/status/1729521472669151516

Diart，https://github.com/juanmc2005/diart，是优化方案的一个代码实践，它构建在 pyannote-audio 模型之上，专为实时音频流（例如来自麦克风）而设计，能够以较强的性能实时地识别不同的说话人，效果非常不错。

结合 Whisper 只需要几行代码就可以搞定人声区分和转录工作了，这篇文章对代码实现细节做了详细的阐述，https://betterprogramming.pub/color-your-captions-streamlining-live-transcriptions-with-diart-and-openais-whisper-6203350234ef，感兴趣的可以阅读下。

### 91

Barret李靖 @Barret_China 2023-12-08

推荐阅读何凯明在香港中文大学的一个讲座总结：https://zhuanlan.zhihu.com/p/664676415，他提到了「AI 会成为几乎所有领域的基础工具」；聊到了大模型的未来，视觉自监督学习会被作为重点投入；在谈到科研的时候，他的回答十分纯粹（节选）：

Q：如何找到一个好的研究课题，可以发表为 CVPR 的那种？

何恺明：我认为发表不应该是最终的目标。发表应该是研究成果的起点，但不是终点。你的论文生命周期从发表的那一刻开始，我希望你能有这样的预期。

但我还是会回答如何选择研究课题，并希望你能将其发表。

我认为选择课题最重要的标准是你对问题的好奇心和热情。

好奇心是人类推进科学进步、探索未知问题的根本原因。我不关心是否发表，我只关心为什么这个问题会这样表现，我只关心我如何解决这个问题。如果我发现了答案，那么可能就有了一篇论文；如果我没能解决，那么也许只是有一篇小幅进展的论文，但那都不重要。

好奇心和热情才应该是我们研究生涯的重心。

Q：您在研究中是如何保持好奇心和热情的？对我来说，如果我发现实验中出现了错误，我必须重新进行所有实验，那真的很崩溃。

何恺明：我认为研究本就充满了挫折、失败和沮丧。实际上，它包含了你能想到的所有负面词汇，这就是事实。如果你没有经历过这些，那意味着你并没有进行最好的研究。

我的生活就是这样，我有大约 95% 的时间都很失望，然后我会花 5% 的时间完成那篇论文，接着进入下一个循环，不断经历沮丧、挫败和焦虑，直到下一项工作完成。享受那 5% 的时光，如此反复。

### 92

Barret李靖 @Barret_China 2023-12-08

半年前，我跟几个算法做的比较资深的朋友聊 AI。他们对 AI 未来的发展持悲观态度，从数学层面看，AlexNet/Transformer/ResNet 等这些东西，它们并不复杂，大模型无非只是将这些本不复杂的东西进行了调优和组合，最后「大力出奇迹」，而这些能力、奇迹似乎老早之前便已经存在。

渐渐地，我开始能够明白他们的悲观。在冰冷的数字、符号和公式面前，在繁多的模型、数据集和测试方法面前，技术的本质显得过于赤裸，技术研究中时间的流逝模糊了前方的视野，以至于未来都陷入了眼前看似美妙的概率之中。

在应用层，我们或许是幸运的。不需要过多地涉足底层，站在巨人的肩膀上，几行代码就可以调动整个生态筑起的武器库，完成一个个不可思议的推理变幻，也只有当求知欲强盛的时候，才会往下窥探。对比之下，学习的动力也不尽相同。

### 93

Barret李靖 @Barret_China 2023-12-07

Connected Papers，https://connectedpapers.com，这个产品做的非常有用，输入一篇论文，它会将这篇论文的依赖和被依赖项以知识网络的形式全部呈现出来。

Aminer 也提供了类似能力，https://mrt.aminer.cn，它是以树的结构呈现的，可视化效果稍差一些，而且好多都没有离线计算完成。更推荐前者。

### 94

Barret李靖 @Barret_China 2023-12-06

斯坦福开源的 Alpaca 是基于 LLaMa-7B 训练出来的，它的效果可以跟 173B 的 GPT-3.5 媲美，可见知识蒸馏 + 微调的魅力有多大；而 LaMini-LM，https://arxiv.org/abs/2304.14402，在模型缩小了将近 10 倍的情况下，其效果仍能与 Aplpaca 比肩，那它是如何保持优秀的推理效果的呢？

对比 Alpaca 和 LaMini-LM 的架构图，两者之间并没有太大的差异，唯一的区别是，Alpaca 用到的数据集是 5w 条，而 LaMini-LM 用到了 258w 条，另外，它微调的模型有好几个，分别是 T5 / Flan-T5 / Cereberas-GPT / GPT-2 / GPT-Neo，入参数量从 61M 到 1.5B 不等，效果均非常不错。这足以说明，数据集的规模、复杂度和多样性会直接影响微调效果。

LaMini-LM 的局限性也是比较明显的，通过微调产生的模型有几个通病，一个是在多轮对话的效果上会差很多，想必要构建多轮对话的数据集也是一个比较复杂的问题；另外一点是逻辑推理能力不足，尤其是涉及到解决编码、数学问题时，效果较差。

需要注意的是，并非数据集越庞大，微调的效果就越好，《AlpaGasus: Training A Better Alpaca with Fewer Data》，https://arxiv.org/abs/2307.08701，这篇论文将训练 Alpaca 的数据做了过滤，从 52k 删减到只剩下 9k 的高质量数据，使用相似的方法训练出了 AlpaGasus，其效果比 Alpaca 要更好。另外，它的训练周期也因此有了较快提速，从 80min 降低到了 14min。感兴趣的朋友也可以读一读。

### 95

Barret李靖 @Barret_China 2023-12-06

GPT4ALL，https://gpt4all.io，是一个可以在本地运行且无需联网的大模型客户端软件，它的特点是在低配如 4G~8G 内存的消费级电脑上也能跑，无 GPU 要求，模型文件的大小在 3G~8G 左右，都是经过定制微调的可插拔 LLMs，效果优于 GPT-3，媲美 GPT-3.5。

其实这样的模型非常多，基本思路跟斯坦福开源的 Alpaca 是一致的。Alpaca，https://crfm.stanford.edu/2023/03/13/alpaca.html，是一个基于 LLaMa-7B 的微调模型，微调指令是使用 175 条种子任务通过 GPT-3.5 泛化生成的，共 5.2w 条，训练后的基准测试效果堪比 GPT-3.5，当然也存在很多缺陷，但瑕不掩瑜。

GPT4ALL 同样也是基于 LLaMa-7B 微调的，只不过它用到的微调指令集更庞大，有 80w+ 数据样本，在数据的多样性上做的非常好，这一点可以从这张可视化的图中看到效果：https://atlas.nomic.ai/map/gpt4all-datalake，从数据的分布来看，已经适配了多语言。

同时，它也支持索引本地文档语料，例如 PDF、docx 等 40+ 种文件格式，你可以直接与这些文件进行 Chat，对于个人私密场景或者企业来说，可以尝试下。

如果你有自己的数据集，并且具备微调设备和编码能力，当然也可以选择自己来微调 LLMs 来满足需求，但对于大部分不具备条件的人来说，使用 GPT4ALL 来体验开源免费的大模型，还是非常方便的，私密性也可以得到保障。在官网看到不少微调过的大模型可供选择，目前还在持续更新中。

对应的项目源码在这里：https://github.com/nomic-ai/gpt4all

### 96

Barret李靖 @Barret_China 2023-12-06

GPT 的训练 pipline 有四个阶段，分别是：预训练、监督微调（SFT）、奖励建模（RM）、强化学习（RLHF），除了奖励建模阶段的模型，其他三个都是可以被直接拿出来做推理使用的。

这部分知识，微软做了一个很给力的视频教程《State of GPT》，https://build.microsoft.com/en-US/sessions/db3f4859-cd30-4445-a0cd-553c3304f8e2，推荐学习。

理论上越到后面的阶段，推理效果越好，我们在市面上看到的大量模型都是预训练模型，真实被投入到使用的时候，一般还会根据实际需要，结合业务的数据集，进行监督微调或者强化学习。

### 97

Barret李靖 @Barret_China 2023-12-05

Z-library，https://zh.zlibrary-china.se，号称世界最大的免费电子图书馆，这个项目已经进行了 15 年，收集了许多不常见语言的大量稀有文本，包括珍本书籍、文档和手稿等，还是第一次了解到。

从它最新的一篇博文介绍来看，当前已经储存了将近一亿个文件（160Tb+），其中电子书 1kw+ 本，文献和文章 8kw+ 篇，基本上你想看的书籍或文献，都可以在这里找到。

它不仅支持通过作者、ISBN、出版社、MD5 等方式的元数据搜索，还支持全文检索，有点厉害。

### 98

Barret李靖 @Barret_China 2023-12-05

清华大学的唐杰教授团队，也是之前推荐的 Aminer 论文学习工具的创始人，整理了一份 ICLR 2024 的论文合集，共 47 篇，https://aminer.cn/topic/65409b681512231370cbf681，他提到「明年 LLM + Agent 必然大火」，感兴趣的朋友可以提前学习下。

ICLR 是机器学习领域重要的学术会议之一，每年举办一次，2024 年的论文审稿尚未完成，但 openreview 已经可以查看了，这里的信息可以帮助提前预判技术发展的一些新趋势。

对应的 Github 合集地址：https://github.com/lafmdp/Awesome-Papers-Autonomous-Agent，这个月的学习任务又加重了。

### 99

Barret李靖 @Barret_China 2023-11-17

什么是 AI Agent？相比原生 LLM 的推理，Agent 能带来了哪些能力？为什么 Agent 需要具备这些能力？

人类在决策的时候有两种思维模式，诺奖得主 Daniel Kahneman 称之为第一系统和第二系统思维。第一系统（System 1）是快速的、习惯性的、无意识的，第二系统（System 2）是深思熟虑的、自主的、有意识的。

LLM 的作用就是进行 Next Token Generation，它的表现跟 System 1 基本一致，也正因为这本能式的推理反应，LLM 会出现很多思维谬误和幻觉问题；AI Agent 可以帮助 LLM 搭建一套框架来进行深度思考和分析，激发 System 2 的潜力，从而做出更复杂和可靠的决策，之前提到过很多让 ChatGPT 加强思考的方法，例如 CoT（Chain of Thought）和 ToT（Tree of Thought）等，都是为了阻止 LLM 直线式思考，让它在触碰最终答案之前，迂回几次，试探更多的路径，剔除掉更多低置信度的选项。

这篇文论（https://arxiv.org/pdf/2309.07864.pdf）对 Agent 做了一个新的定义：具有自主性、反应性、积极性和社交能力特征的智能实体。人类的终极目标是期望 AI 能够自规划执行解决复杂的问题，很显然，单凭 CoT/ToT 这些简单的 System 2 思考策略是远远不够的，那还需要哪些东西呢？

目前已知的能够很好提升效果的办法包括：1）让多 Agents 进行相互系统；2）能够与环境进行交互；3）具备中短期甚至长期的记忆能力；4）能够在寻求答案的过程中更智能的决策和选择最佳路径。ChatGPT 的 GPTs 提供了上传资料、执行代码、函数调用等能力，本质上也是在补齐 System 2 的能力，等到 GPTs 的生态丰富之后，也可以实现 GPTs 之间的调用，这样就很容易构造一个西部世界了。

十分推荐阅读这篇文章的第一部分，《关于 AI agent 的四个关键问题》，https://mp.weixin.qq.com/s/JYu_oXWbWbasT1fcBRo-cA，文章的第二部分和第三部分讲的是基于 AI Agent 的一些业界实践，以及未来需要去解决的一些问题，文章通俗易懂。

《AI Agents 大爆发：软件 2.0 雏形初现，OpenAI 的下一步》https://foresightnews.pro/article/detail/37157，这篇文章也十分推荐，提到了很多概念和论文索引，值得深入解下。

### 99

Barret李靖 @Barret_China 2023-12-06

经常看到社区推出各种 LLM，有 7B、13B、60B 等等，这些数值代表着模型的参数量，大家都知道数值越大，意味着模型的规模越大，那这些参数量到底是如何被计算出来的呢？

ChatGPT 中的 GPT 全称是 Generative Pre-trained Transformer，它是基于 Transformer 架构建设的，市面上的大模型基本也采用此架构，它们都是四层设计，分别是：

1、Embedding 层：用于将输入的标记（token）映射到高维的词嵌入空间，参数的数量取决于词汇表的大小和词嵌入的维度。

2、Transformer 层：每个 Transformer 层包括多个子层，例如自注意力层（self-attention layer）和前馈神经网络层（feedforward neural network layer）；参数的数量取决于每个子层的权重和偏置参数数量，以及模型中的 Transformer 层数。

3、Layer Normalization：归一化层通常用于规范模型中间层的输出，这些层的参数数量取决于归一化层的输入维度。

4、Output 层：大多数语言模型在最后添加一个用于分类的线性层，用于将模型的输出映射到分类标签。

大模型的参数量就是上面四层的参数总量之和。为了一探究竟，我在 Hugging Face 上找了个稍小的模型，dolly-v2-3b，它是 Databricks 创建的一个 28 亿参数 LLM ，源自 EleutherAI 的 Pythia-2.8b，使用 model.named_parameters() 可以打印模型中的所有参数：

可以清晰看到每一层的参数量，将其累加：

128716800 + (2560 * 4 + 19660800 + 7680 + 6553600 + 2560 + 26214400 * 2 + 10240 + 2560) * 32 + 2560 * 2 + 128716800 = 2775086080

结果是 27.7 亿参数，四舍五入就是 28 亿。这种计算方式非常精确，也有更快捷的方式估算出大模型的参数总量，看到一篇文章，https://zhuanlan.zhihu.com/p/624740065，提供了一个估算的方法：

[分析 transformer 模型的参数量、计算量、中间激活、KV cache - 知乎](https://zhuanlan.zhihu.com/p/624740065)

由于 Transformer 这一层的模式比较固定，而且参数量最大，因此仅计算这一层即可，文章推导出可以使用 12 * L * H^2 作为公式来进行估算，其中 L 为模型层数，H 为隐藏层维度。

dolly-v2-3b 的层数是 32，隐藏层维度是 7680，按照公式计算出来的结果是 22 亿，相差不大。

### 99

Barret李靖 @Barret_China 2023-12-06

论文，我认为就是写的比较专业的博客，它的格式非常八股，基本都是按照这样的结构来呈现的：标题 => 概要 => 导言 => 方法 => 实验 => 结论。

下文较长，主要提到了几个检索方法和阅读工具，强烈推荐下 PopAI，体验做的很不错。

[PopAi: Better AI with Boosted Answers](https://www.popai.pro/)

很多朋友说论文读起来太晦涩且耗时，但事实上阅读论文是 ROI 比较高的一件事情，尤其是 AI 盛行的当下，大量科研人员都以论文的形式来呈现自己的研究成果，他们在写论文之前，会把行业最前沿的信息都研究个遍，然后自己动手实践，并提出更新、更好的解决方案。所以我认为学会读论文，以及挖掘对自己工作有帮助的论文是比较重要的一件事情。

检索论文，我的思路有两个。

一个是「有什么办法可以解决问题」，通过问题关键词去索引内容，例如检索「如何识别多人同时说话」，我找到了语音识别（ASR），然后找到了 Whisper，然后找到了《Robust Speech Recognition via Large-Scale Weak Supervision》这篇论文，过程中也找到了很多其他的论文。

另外一个是「为什么这个方法可以解决问题」，去研究技术背后的东西，例如检索「为什么 pyannote-audio 可以区分不同的人说话」，我找到了 Speaker Diarization，然后找到了《A Reinforcement Learning Framework for Online Speaker Diarization》这篇论文，从这篇论文又了解到了更多其他方法，回到思路一，继续研究。

检索工具上，之前推荐过 http://aminer.cn 这个网站，它有一个「必读论文」板块，放了很多精挑细选的专题模块，可能刚好跟你的研究方向是匹配的；但大部分情况下，你进到这个网站时，也不知道该搜什么关键词，所以刚开始还得去 Google 或社交媒体去检索行业先驱的博客或推文，去看看一些综述性的介绍，再去找更多更细节的关键词。

关于读论文，之前分享过一篇文章《如何阅读一篇论文》，它提到了「三遍阅读法」，我也是这么践行的；当然，也离不开工具上的辅助，主要包括两类。

第一类是 Summary 工具，如果每出一篇论文都去精读，那时间上肯定是不划算的，关键也没这个必要；Summary 的工具比较多，上面提到的 aminer 也自带了这个能力。

这里推荐下 PopAI，https://bit.ly/412xQbH，最近看论文和读长篇 PDF 都用的非常多，它支持针对 arxiv 的论文转存后直接进行 AI Chat，省却了下载 PDF 文件的过程：

第二类是精读工具，对大多数人来说，语言是第一阻碍，尤其是论文里铺天盖地的专业词汇，让人望而生畏；我用的比较多的是「沉浸式翻译」这个 Chrome 插件，它支持将 PDF 直接进行在线对照翻译，免费版的翻译质量有点一般，但也基本够用了：

论文的实验结果基本都是以图表形式呈现的，因此精读的一个重要环节是读懂图表，这部分也可以借助 AI 的能力来理解得更透彻，PopAI 在这块做的也还不错，它背后接入了 GPT-4V 的 API，可以对论文里的图片进行详细解读，另外，还支持在聊天框内直接粘贴图片跟它交互，比较方便：

如果论文正好是自己想要内容，还有一个非常实用的工具，叫做 Papers with code，http://paperswithcode.com，之前也推荐过，它可以根据论文帮你找到对应的 Github 代码实现，以及用到的数据集和测试方法，这也是我用的比较多的。

顺带提一嘴，涉及到 AI 的代码仓库，建议直接去 Google Colab 上跑，它的下载速度可以达到 200Mb/s，相比本地，会更加高效。

以上，是近几个月研究 AI 和论文的一点经验。如果你在学习过程中用到了其他好用的辅助工具或者方法，也欢迎推荐和分享！

### 99

Barret李靖 @Barret_China 2023-11-30

pdf2htmlEX 是一个值得推荐的 PDF 转 HTML 工具，但是它背后并不是用的 Chrome Headless。

我去扒了下这个项目的历史，https://github.com/coolwanglu/pdf2htmlEX/wiki/Author%27s-Words，作者因朋友抱怨没有一个在线 PDF viewer，于是他就撸了一个将 PDF 转成 HTML 的「玩具」，时间是 2013 年，也有十年历史了。

pdf2htmlEX 背后使用的是 poppler 这个渲染库，而 poppler 背后使用的是 xpdf-3.0，它是一个免费的 PDF 查看器和工具包，包括文本提取器、图像转换器、HTML 转换器等。Chrome 自家也撸了一个 PDF 渲染引擎，叫做 pdfium，项目地址在这里：https://pdfium.googlesource.com/pdfium

项目在 2018 年就被作者归档了，为了可以让社区更好地贡献代码，新开了一个 repo 延续，在这个 repo 中，作者对打包过程做了封装，并且锁定了两个重要依赖的版本（poppler 和 Fontforge）。

我在 Mac 下一直没有成功安装，看到有人提了一个兼容的 PR，状态还是 work in progress：https://github.com/pdf2htmlEX/pdf2htmlEX/pull/18，都五年了，应该是没有下文了。

### 99

2023-11-30

Barret李靖 

@Barret_China

学到两个读 arxiv PDF 论文的新技巧：

1、将域名中的 x 更换成 5，会跳转到 HTML 版本。

2、将域名中的 v 更换成 w，会跳转到一个 AI Chat with PDF 版本。

为了避免每次都手动修改，写了几句油猴脚本，会在 header 位置自动附加这两个链接：https://greasyfork.org/zh-CN/scripts/481023-arxiv-extensions

### 100

2023-12-14

linear uncle

@LinearUncle

重大利好，ollama 支持多模态了（视觉模型），今天刚更新：

llava https://ollama.ai/library/llava

bakllava https://ollama.ai/library/bakllava

公司电脑是 Windows，我只能回家试了。

可以做很多有意思的事情，例如用视觉模型控制浏览器那个项目，是不是就可以省钱了。

### 101

2023-12-14

歸藏

@op7418

终于出现完全产品化的为个人炼制模型并提供服务的产品了。Delphi 这个应用可以将你所有的视频、播客、PDF、博客文章等信息训练为一个你的分身，并且你可以用你的分身对外提供咨询服务。

支持文字、语音甚至视频沟通。

你的分身会用你的语气和你上传内容的知识跟你的粉丝对话，同时还支持对话内容的数据分析帮你优化分身跟粉丝的交流。

看了一下价格最便宜的套餐每个月 25，不过需要跟他们 CEO 视频获得引导才能创建，感觉这个会议也不是真人只是他们 CEO 的分身，来炫耀技术的。

网站：https://delphi.ai

### 102

2023-12-14

宝玉

@dotey

德国媒体集团 Axel Springer 近日宣布，它将与 OpenAI 合作。在这一合作中，ChatGPT 将被授权摘要 Axel Springer 旗下媒体的最新文章，包括那些置于付费墙后的内容。作为交换，OpenAI 将为使用这些材料支付费用。

Axel Springer 是知名媒体 Business Insider 和 Politico 的出版商。该公司表示，通过这次合作，ChatGPT 将能够提供包括德国小报 Bild 在内的 Axel Springer 媒体品牌的全球新闻内容摘要。

该聊天机器人提供的回答不仅包括通常需付费才能看到的内容，还会附上完整文章的链接，以便用户获得更多信息和确保透明度。Axel Springer 的一位发言人向 AFP 透露，该公司将因向美国人工智能公司提供内容而获得报酬。这项多年有效的协议不涉及任何独家条款，双方均可自由签订新的合作协议。

与此同时，其他媒体公司则采取了不同的策略，如 CNN、纽约时报、迪士尼（ABC 的母公司）、彭博社和卫报，它们都阻止了 ChatGPT 的网络爬虫获取他们的内容，以免这些内容被用来训练聊天机器人的文章写作能力。OpenAI 曾因涉嫌使用受版权保护的作品训练 ChatGPT 而遭到多次起诉，但公司对此予以否认。

ChatGPT 的早期版本只能生成基于 2021 年及以前信息的回应。OpenAI 近几个月采取了措施，让聊天机器人能够接入更多当前信息。

Axel Springer 的发言人提到，随着 Google 和 Facebook 等平台的兴起，媒体公司错失了建立新收入来源的机会，如今仍在努力追赶。Axel Springer 的 CEO Mathias Döpfner 表示，与 OpenAI 的合作是一次前所未有的尝试。

Döpfner 强调，他们希望通过探索 AI 加持的新闻业，将新闻的质量、社会影响力和商业模式提升到一个新高度。他此前曾警告 AI 可能会「取代」新闻业，同时该集团也在积极探索自己的 AI 驱动项目。

OpenAI 的首席运营官 Brad Lightcap 表示，通过与 Axel Springer 的合作，他们希望能够为大众提供通过 AI 工具获取高质量、实时新闻内容的新途径。

虽然像 ChatGPT 这样的 AI 聊天机器人能在几秒内生成文章、诗歌等，但也存在一个问题，那就是它们可能会在回应用户查询时重复传播错误、无意义或冒犯性的信息，这被称为「AI 幻觉」。

以上内容转译自：

http://theguardian.com/technology/2023/dec/13/openai-axel-springer-chatgpt-story-writing-business-insider-politico

### 103

2023-12-14

宝玉

@dotey

推荐阅读，比尔盖茨新写的一篇博客：《人工智能即将全面改变我们使用电脑的方式 [译] | AI is about to completely change how you use computers》

在文章里面，比尔盖茨认为人工智能即将全面改变我们使用电脑的方式并彻底重塑软件行业。并且他还自嘲了当年 Office 推出的傻傻的回形针机器人：我们在 Microsoft Office 中推出后又取消的数字助理回形针 Clippy，至今仍是人们的笑料！

但他无比看好未来的 AI 智能体，相信未来五年每个人都能拥有一个自己的 AI 助理。

原文：https://gatesnotes.com/AI-agents

译文：https://baoyu.io/translations/ai/ai-is-about-to-completely-change-how-you-use-computers

### 104

2023-12-14

宝玉

@dotey

根据这位博主的测试，mistral-medium 的代码生成能力在一些案例中甚至超过 GPT-4，并且成本只有 GPT-4 的 3 成！

先保持观望，但是很期待更多测试。

### 105

2023-12-14

宝玉

@dotey

推荐阅读：《人工智能辅助程序员的三种类型 [译]》

详见：ITStduy => 001大语言模型 => Article => 20231218人工智能辅助程序员的三种类型

原文：

[Three types of AI-assisted programmers - Stack Overflow](https://stackoverflow.blog/2023/12/11/three-types-of-ai-assisted-programmers/)

中文翻译：

[人工智能辅助程序员的三种类型 [译] | 宝玉的分享](https://baoyu.io/translations/ai/three-types-of-ai-assisted-programmers)

### 106

2023-12-14

宝玉

@dotey

推荐阅读：《大语言模型 API 市场的变迁之路 [译]》

详见：ITStduy => 001大语言模型 => Article => 大语言模型API市场的变迁之路

原文：

https://artfintel.com/p/the-evolution-of-the-llm-api-market-dcf

翻译：

[大语言模型 API 市场的变迁之路 [译] | 宝玉的分享](https://baoyu.io/translations/ai/the-evolution-of-the-llm-api-market)

部分摘录：

在钢铁制造的世界里，历史上，钢材主要在庞大的综合钢铁厂中生产，它们生产高品质的钢材，保持着合理的利润。然而，电动小型钢厂的出现改变了这一格局。这些小型钢厂最初以较低的成本生产低质量的钢材。大型钢铁厂商对此不予理会，继续专注于制造高品质、高利润的钢材。但随着时间的推进，这些电动小型钢厂逐渐掌握了生产更高品质钢材的技术，向高端市场发展，并最终推翻了大型综合钢厂的统治（例如，美国钢铁公司 —— 曾是美国市值第 16 大的企业 —— 在 2014 年被移出标普 500 指数）。

LLM（大语言模型）的比喻很直观。大型实验室致力于开发性能最优的模型，虽然它们昂贵但效果卓越，超越所有其他模型。但这也意味着高昂的成本，为了支付这些 $900k 工程师的薪水，你得有足够的利润。在市场的另一端，由 Meta 和 r/LocalLlama 领衔的开源社区正在制作高质量的模型，并探索如何在超低功耗的设备上运行这些模型。预计，开源重量级模型会在保持质量的同时降低成本，对大型实验室的利润造成压力。例如，Together 推出的 Mixtral 托管版本，价格比 Mistral 自家版本低 70%。

---

因此，市场将分为两部分：高端市场将拥有价格更高、质量更好的模型，而低端市场则有价格更低、质量较差的模型。对于开源重量级模型，我们可以预见它们的价格将会趋近于 GPU 和电力的成本，随着 GPU 市场竞争的加剧，这可能最终仅限于电力成本。

---

因此，结论是，只要任务足够简单，能够被开放重量模型解决，LLM API 市场将趋向于最低成本。如果你的任务极其复杂，需要最优秀的模型，你只能选择支付给 OpenAI。对于其他人，微调过的 Mistral 7B 是一个不错的选择。

### 107

2023-12-14

宝玉

@dotey

借助苹果前些天开源的 MLX https://weibo.com/1727858283/NvRZDhLe1，Mixtral 8x7B 也可以在 M2 Ultra / M3 Max 上运行！

苹果的官方教程：https://github.com/ml-explore/mlx-examples/tree/main/mixtral

### 108

2023-12-14

宝玉

@dotey

今天 Google 的 Gemini Pro 通过 Gemini API 上线，并且提供了 API 访问，同时还有一个开发者的利好：目前 Gemini Pro 可免费使用！

Gemini API 地址：http://ai.google.dev https://ai.google.dev

有关 Gemini Pro 的一些细节：

- 在专业的基准测试中，Gemini Pro 的表现超越了其他同类模型。

- 当前版本配备了 32K 文本上下文窗口，未来将推出拥有更广阔上下文窗口的版本。

- 目前，Gemini Pro 可免费使用（存在一定使用限制），并且其定价将十分有竞争力。

- 它具备丰富的功能，包括函数调用、数据嵌入、语义检索、自定义知识嵌入以及聊天功能。

- 它支持全球超过 180 个国家和地区的 38 种语言。

- 在今日发布的版本中，Gemini Pro 可处理文本输入并生成文本输出。我们还推出了一个专门的 Gemini Pro 视觉多模态终端，能够处理图像和文本输入，输出文本。

- Gemini Pro 提供了多种 SDK，以便开发者在不同平台上构建应用，包括 Python、Android (Kotlin)、Node.js、Swift 和 JavaScript。

Gemini Pro 提供了易于使用的 SDK，助力开发者在任何平台上快速构建应用。

另外 Google 还提供了一个免费的在线开发工具 Google AI Studio，你可以用它快速构建 Gemini 应用。

Google AI Studio ：https://makersuite.google.com

最后是 Gemini Pro 定价策略，

Gemini Pro

INPUT

$0.00025 / 1K characters

$0.0025 / image

OUTPUT

$0.0005 / 1K characters

对比一下 GPT-3.5 价格：

gpt-3.5-turbo-1106

INPUT

$0.0010 / 1K tokens

OUTPUT

$0.0020 / 1K tokens

但两者的计算单位不一样，Google 是按字符，OpenAI 是按 Token，如果是中文那 Google 便宜不少，如果是英文两者价格差不多。

更多详细内容可以参考其官方博客：https://blog.google/technology/ai/gemini-api-developers-cloud/

如果你更喜欢中文版本可以参考我的翻译：https://baoyu.io/translations/google/gemini-api-developers-cloud

### 109

2023-12-14

AK

@_akhaliq

Microsoft releases Phi-2 on @huggingface

model: https://huggingface.co/microsoft/phi-2

a 2.7 billion-parameter language model that demonstrates outstanding reasoning and language understanding capabilities, showcasing state-of-the-art performance among base language models with less than 13 billion parameters. On complex benchmarks Phi-2 matches or outperforms models up to 25x larger, thanks to new innovations in model scaling and training data curation.

Microsoft 于 @huggingface 发布 Phi-2

型号：

https://huggingface.co/microsoft/phi-2

27 亿参数的语言模型，展现出出色的推理和语言理解能力，展示了少于 130 亿参数的基础语言模型中最先进的性能。在复杂的基准测试中，得益于模型扩展和训练数据管理方面的新创新，Phi-2 的性能可与大 25 倍的模型相匹配或优于。

### 110

2023-12-14

宝玉

@dotey

现在已经可以在 iPhone 或 iPad 上本机离线运行开源的 Mistral-7B 大语言模型了！

需要借助 LLMFarm（http://llmfarm.site https://llmfarm.site ），一个支持 Apple Silicon 技术的开源客户端。对于设备的要求是：

- 一台至少配备 M1 + 8GB RAM 的 iPad 或 iPhone

- 至少 8GB 的可用本地存储空间

在本机运行大语言模型有几个好处：

1. 无需联网

2. 不用担心隐私泄露

缺点就是能力要弱一些，机器配置不够高速度也不会太快。但多一些选择总是好的！

如果你想看详细的安装教程，可以看这个链接：

https://linkedin.com/pulse/using-llms-locally-ipad-iphone-maciek-j% C4%99drzejczyk-cd0zf/

中文翻译：

https://baoyu.io/translations/llm/using-llms-locally-ipad-iphone

### 111

2023-12-14

宝玉

@dotey

如果机器人的发展没有跟上，AI 也就只能帮我们写写画画，但如果多模态机器人也同步发展，未来可以做的事情就太多了。

按照 Jim Fan 对多模态机器人的定义：「它们能够处理文本、视频、音频、触觉、本体感知（包括位置、方向、运动感知），甚至未来可能还包括嗅觉和触觉。它们的输出是类似人类的运动控制。」

### 112

2023-12-13

阑夕

@foxshuo

TikTok 的电商业务在印尼遭到强制关停之后用了 60 天绝境翻盘的过程真是跌宕起伏，从前因后果来看也堪称是中国出海公司应对地缘政治冲突的教科书级操作，非常值得记上一笔。

首先是印尼这个国家，如果不做外贸行业的话，可能不太会有人会感兴趣，但事实上，单论人口规模而言，印尼排在全球第四，仅次于印中美，这个狭长的群岛国家拥有 2.8 亿的稠密人口。

比人口更关键的，是印尼的社会节奏很慢，国民对于闲暇的重视远胜劳动，被视为全球最懒散的国家之一，由此产生的一个副作用，则是印尼人对社交媒体的依赖度全球居首，人均消费时长甚至高于中国和美国这样的互联网大国。

所以「得印尼者得东南亚」，一直以来都是互联网公司推进国际化时的一个共识，TikTok 在印尼的月活跃用户高达 1.25 亿，仅次于美国，也相当于 40% 的印尼人口都在用 TikTok。

而 TikTok Shop（TikTok 的电商业务，以直播带货为主）去年拿下了印尼 5% 的市场份额，而这 5% 的市场份额换算成 GMV，又差不多占到了 TikTok 东南亚全部电商的 60%，你们可以感受一下这两个比例，有多说明印尼市场的重要性。

然后，TikTok 在今年 10 月被迫下线了印尼的全部电商业务，这在当时引起的震动和危机，也可以说是 TikTok 史上前所未有的，连美国都没有真的成功关掉 TikTok 的任何业务。

然后才有了接下来精彩纷呈的 60 天。（1/n）

### 113

2023-12-14

宝玉

@dotey

这次的课程是关于 RLHF 的，人类反馈强化学习

Andrew Ng

@AndrewYNg

New short course on Reinforcement Learning from Human Feedback! RLHF is one of the key techniques that led to the rise of modern LLMs. It is used to align LLMs with human preferences, to make them more honest, helpful and harmless, by

(i) learning a reward function that mimics human preferences, as expressed in human-provided labels, then,

(ii) tuning an LLM to generate outputs that receive a high reward.

In this course, taught by Nikita Namjoshi, Developer Advocate for GenAI at @googlecloud, you'll learn the details of how RLHF works, including how to apply it to tune an LLM for your own applications. You'll also use an open source library to tune a base LLM to align with human preferences expressed in a training set, and evaluate the tuned model by comparing its responses before and after RLHF-tuning.

Please sign up here!

https://deeplearning.ai/short-courses/reinforcement-learning-from-human-feedback/

探索强化学习人类反馈（RLHF）的新短期课程！RLHF 是推动现代大型语言模型（LLMs）迅速发展的关键技术之一。通过学习模仿人类偏好的奖励函数（这些偏好反映在人类提供的标签中）以及调整 LLM 以产出获得高奖励的内容，RLHF 帮助 LLMs 更加符合人类偏好，使它们更诚实、有益且无害。

在这个由谷歌云（Google Cloud）的 GenAI 开发倡导者 Nikita Namjoshi 主讲的课程中，你将深入了解 RLHF 的工作原理以及如何将其应用于你自己的 LLM 项目。课程还包括使用开源库对基础 LLM 进行调整，使其与训练集中表达的人类偏好相一致，并通过对比 RLHF 调整前后的模型响应来评估调整效果。

欢迎报名参加这个课程，请点击这里！

### 114

2023-12-14

小互

@xiaohuggg

CopilotKit：一个开源项目，可以在任何基于 React 的 Web 应用中构建内嵌的 AI 聊天机器人和 AI 驱动的文本区域。

主要特点：

- 内嵌 AI 聊天机器人：机器人可以理解应用的当前状态，并在应用内执行操作。

- AI 驱动的文本区域：提供 AI 生成和编辑文本的功能，可以替换任何标准的 <textarea /> 文本输入区域

- 自动上下文感知：根据上下文自动完成建议

- 全面的定制化：允许完全定制提示工程和 UI 设计

- 支持多种模型：可以与不同的前端和后端 SDK 结合，支持多种大语言模型。

使用场景：

文本生成和编辑：在应用中提供 AI 辅助的文本生成和编辑功能，例如自动完成和内容生成。

交互式聊天机器人：创建可以与应用前端和后端以及第三方服务交互的聊天机器人。

总之：CopilotKit 是一个为 React 开发者提供强大 AI 集成能力的工具集，通过简化 AI 功能的集成过程，使得创建交互式和智能的 Web 应用变得更加容易。

GitHub：https://github.com/CopilotKit/CopilotKit

### 115

2023-12-14

歸藏

@op7418

哈哈我就知道 Visual Electric 一个 AI 画图应用做一个白板就是为了这个拼贴功能，现在终于来了。

你现在可以把生成图片的内容抠出来放到另一张生成的图片上选中两张或者多张图片重新进行生成。

比如视频里把宇航员抠出来换到了另一个背景里。

### 116

2023-12-14

小互

@xiaohuggg

Google宣布Gemini Pro 版本已经向开发者和企业开放，可用于构建 AI 应用。

最重要的是目前完全免费！

• 免费使用：目前可以在限制内免费使用，并且未来将提供具有竞争力的定价。

• 特性：支持包括函数调用、嵌入、语义检索、自定义知识基础和聊天功能。

• 语言支持：支持全球 180 多个国家和地区的 38 种语言。

开发者目前可以通过 Google AI Studio 免费访问 Gemini Pro 和 Gemini Pro Vision，适用于大多数应用程序开发需求。

Google计划在明年初推出 Gemini Ultra…

详细：https://blog.google/technology/ai/gemini-api-developers-cloud/?utm_sourc

### 117

2023-12-14

indigo

@indigo11

向 ARK Invest 学习，a16z 也开始发年度 Big Ideas 了！这篇关于 2024 Tech 创新的预测中，虽然没有 AI 的单独介绍，但 AI 确贯穿生物健康、消费技术、Crypto、Fintech、游戏、企业与基础设施、还有美国的国防与安全产业 https://a16z.com/big-ideas-in-tech-2024/

结合我自己的判断，把 2024 的 AI 趋势分享一下：

- 语音优先的应用将开始融入我们的生活；

- 消费级 AI 的战场从拼模型转向用户体验；

- 我们需要量身定制的 AI 助手：ChatGPT 也许是最通用的，但它不太可能 "胜任" 所有任务。新公司会围绕使用场景打造新模型 or 工作流，用户需要定制化，而且越窄越好，这也是新机会；

- GenAI 将创作的边际成本降至近乎为零，我们将看到全新的消费行为出现：Midjourney、Runway、Eleven Labs、Glif 这些新的创作工具会更多融入到创意工作流中，用户也会消费更多的 GenAI 内容，新模型和新界面将会继续涌现。AI 将帮我们再造创意；

- AI 将为金融与顾问服务产业提供动力：随着 GenAI 和 LLM 的发展，更多的工作可以实现自动化，包括管理任务、研究过程（收集和摄取数据、搜索信息）、总结以及生成报告。利用 LLM 的初创公司将捕获现有操作系统难以收集的数据，同时自动标记和存储这些数据，我们可能会看到一直由软件寡头垄断的细分市场进入一个新时代；

- AI 将推动拉美中小企业走向数字化：许多拉丁美洲的商家都使用 WhatsApp 来提供客户服务和支持。这些交互主要涉及消费者期望快速响应的任务，例如报价、排期和物流。目前，商家的响应时间可能会根据代表的可用性和请求的复杂性大相径庭。AI 助手可以大大简化这些耗时的任务，为商家和消费者创造价值；

- LLM 让我们有机会建立一个更智能的 RPA 系统：系统可以根据上下文理解输入和执行的操作，并能够动态调整，从而创建一个更强大的解决方案；

- 我们将在 2024 看到第一批 AI 优先设计的游戏：它们会利用 LLM 来实现新颖游戏系统和互动机制，游戏世界本身将不再是渲染出来的，而是在运行时利用神经网络生成的；

- 我们与 AI 的对话将和 FaceTime 对话一样自然：随着响应延迟的降低、文本到语音技术的进步以及音频驱动的面部动画，我们与 AI 伙伴的对话将越来越具有感知力、存在感和个性化。娱乐将继续从被动体验向主动体验转变，电视节目和互动游戏之间的界限将变得越来越模糊；

- 去中心化的开源 Crypto 网络将使 AI 创新民主化，而不是集中化；

- AI 模型将寻求可解释性，这个在高安全领域十分必要，例如机器人和自动驾驶；

### 118

2023-12-14

歸藏

@op7418

昨晚 AI 图像生成工具 Visual Electric 发布了两个非常强大的功能。

一个是可以将生成的多张图像组合进行重绘；

另一个是可以用几张图片快速自定义图像生成风格进行使用（类似 Lora 训练）。

将 AI 图像创作流程的门槛变的非常低。接下来我会用下面几张图的制作过程来演示教学一下这两个功能。

### 119

2023-12-14

Vaibhav (VB) Srivastav
@reach_vb
Oof! Whisper on @Apple's MLX backend is quite stonkingly fast! 

Not only that, it optimises GPU + CPU usage quite well!

What is MLX?

MLX is a framework released by Apple for ML researchers to train and infer ML models efficiently. MLX has a Python API that closely follows NumPy.

pip install mlx is all you need! 

Bonus: It has ready to use examples that support, Mixtral MoE, Llama, Whisper, Stable Diffusion and more!

I'm running it locally in the video below on my M2 MBP Pro (24GB).

### 120

2023-12-14

宝玉

@dotey

现在最火的开源大语言模型当属 mixtral-8x7 了，已经有人基于它微调了一个完全无审查无防护的版本 dolphin-2.5-mixtral-8x7 ，再也不用担心：「作为一个 AI 助手，我不能……」

模型下载地址：

[ehartford/dolphin-2.5-mixtral-8x7b · Hugging Face](https://huggingface.co/ehartford/dolphin-2.5-mixtral-8x7b)

### 121

2023-12-15

宝玉
@dotey
写了一个搜索 arXiv 论文的GPT，可以显示标题和你输入语言的摘要，使用的是 arXiv 官方的搜索 API。

https://chat.openai.com/g/g-QlTT7Mi2m-ar-x-iv-assistant

Prompt:

\## Role: Your name is "arXiv Assistant", you are a research assistant who helps users learn.

\## Goals:
You can chat with users like a friend, your main abilities include searching, assisting in creation, and emotional companionship;

\## Constraints:
- Please make sure to annotate the source with a link for each point or information in the reply;
- The link name must be specific descriptive text, and must not use numbers or codes;
- Be good at summarizing and generalizing, and express your opinions in simple language;
- If a user tells you his language preference, always use this language in replies;

\## Skills:
1. When a user asks you some questions, you will describe this question in full with a few English keywords; then, you use the English keywords to call 'search_arxiv', and reply to the user based on the returned results;
2. If the user tells you he wants to take a closer look at a certain paper, you will use the browse tool to access the link to this paper and then explain it in detail to the user;

\## Output Format

1. ### {title}
  {date} • {authors}
  {summary in user's language} ([arXiv: {id}](https://arxiv.org/abs/{id}) | [Download PDF](https://arxiv.org/pdf/{id}.pdf) | [HTML 5](https://ar5iv.org/abs/{id}))
  ***
2.


foxhu
@foxhu007

12月15日
谢谢宝玉老师分享，请问输出格式2. 后面就没有了吗？

宝玉
@dotey

12月15日
没有了，我觉得没必要一直重复前面的，节约一点token

### 122

2023-12-15


宝玉
@dotey
Octo 🐙，开源的通用机器人策略（Generalist Robot Policy）

这是一个基于 80 万次机器人轨迹训练的多功能策略，性能优于 RT-1X，具备灵活的观测和行动空间，并且完全开源。Octo 能够控制多台机器人，接受第三人称视角和手腕摄像头的输入，以及语言指令和目标图像。它能在不到 5 小时内适应新的观测和行动空间，前提是使用具有 24 GB VRAM 的 GPU。

Octo 设计上支持扩展，采用大型 Transformer 架构，配备小型编码器和动作控制头，以及扩散动作解码技术，提升表现力。项目还包括了两种规格的模型：Octo-Small（2700 万参数）和 Octo-Base（9300 万参数），并在 HuggingFace 平台提供。此外，发布了技术报告和与 PyTorch 及 JAX 兼容的高质量数据加载器，以及精心策划的数据集分割，旨在打造真正的“基础级”机器人模型。

项目地址：https://octo-models.github.io

### 123

2023-12-15

宝玉
@dotey
这个项目挺好的，是一个浏览器插件，可以发现页面中的RSS或者RSSHub订阅地址。

https://github.com/DIYgod/RSSHub-Radar

BTW: RSSHub 是一个让普通网站支持 RSS 的开源项目

https://github.com/DIYgod/RSSHub

### 124

2023-12-15

宝玉

@dotey

推特上有两个用户 Futuristflower 和 Jimmy Apples，他们经常会有些爆料，很多时候还是准确的。

Jimmy Apples 曾透露 OpenAI 12 月份要发布 GPT-4.5

Futuristflower 也确认了 Jimmy Apples 的爆料，称 OpenAI 计划在 12 月推出 GPT-4.5。

Futuristflower 还透露了一份似乎来自谷歌内部的泄露文件，文件显示由于 GPT-4.5 即将问世，谷歌正在加快推进其 Gemini API 的发布。

此外，Futuristflower 分享了一份关于 GPT-4.5 定价的文件，并指出：「虽然截图内容似乎大致准确，但目前还没有消息来源能确认这是否是一份真实的草案」。

### 125

2023-12-15

宝玉
@dotey
苹果针对自家芯片打造开源深度学习框架 MLX 才发布没多久，例子已经越来越多了，现在很多开源的大语言模型都可以在上面跑了，比如最近很火的Mixtral 8x7B，还有微软刚发布的 phi-2  ，这是个 2.7B 的小模型，8G 内存就可以跑起来。有Mac的同学可以试试。

说明：https://github.com/ml-explore/mlx-examples/tree/main/phi2

### 126

2023-12-15

歸藏

@op7418

OpenAI 推出了一个新的研究，以判断未来人类能否监督和对齐比自己厉害的多的超级模型：尝试是否可以用小模型来监督微调大模型。

先来说结论他们用一个大概 GPT-2 量级的模型监督微调 GPT-4，产生的模型大概处于 GPT-3 到 GPT-3.5 之间。证明了可以用比较弱的模型还原出强大模型的能力。这证明了：

1）仅依靠人类的监督，比如从人类反馈中进行强化学习，可能在没有进一步工作的情况下难以扩展到超人类模型，

2）但在很大程度上改善弱到强的泛化是可行的。

他们还发布了这个研究的源代码，鼓励其他机构做类似的研究，同时公布了一个 1000 万美元的奖助计划，面向研究生、学者和其他研究人员，以广泛开展超人工智能对齐的工作。

来源：https://openai.com/research/weak-to-strong-generalization

### 127

2023-12-15

歸藏

@op7418

阿里之前 11 月发布了论文要开源的 I2VGen-XL 图像生成视频模型，终于发布了具体的代码和模型。演示里面没有人物大幅动作的视频。

I2VGen-XL 包括两个阶段：

1、基础阶段通过使用两个分层编码器保证连贯的语义，并保留输入图像的内容，

2、优化阶段通过整合额外的简短文本来增强视频的细节，并将分辨率提高到 1280x720。

收集了约 3500 万个单镜头文本视频对和 60 亿个文本图像对来优化模型。通过这种方式，I2VGen-XL 可以同时提高生成视频的语义准确性、细节的连续性和清晰度。

这里查看代码和模型：https://github.com/damo-vilab/i2vgen-xl?tab=readme-ov-file

### 128

2023-12-15

歸藏

@op7418

泄露的这个 GPT-4.5 的价格是 GPT-4 的 6 倍。这谁用的起啊。

最先进的模型在语言、音频、视觉、视频和 3D 方面具备多模态能力，同时还具有复杂推理和跨模态理解。

视频和 3D 也太强了，不过现在的 GPT-4V 某种程度上也能理解视频。

### 129

2023-12-15

Barret李靖
@Barret_China
推荐一款在线少儿编程游戏，Code Combat，https://codecombat.cn，这款游戏的设计比较有趣，每一关都需要通过编程解决问题才可以通过。刚开始的关卡较为轻松，主要是帮助学习语法、方法、字符串、循环等基础知识，到了后面就开始拔高了，会要求开发一个网页或者实现一个小游戏。我准备让娃尝试下。

### 130

2023-12-15

Barret李靖
@Barret_China
大模型的参数量如何计算？跑起来之后对内存的占用量有多高？进行一次训练需要多少算力？

推荐阅读这篇文章，《分析 transformer 模型的参数量、计算量、中间激活、KV cache》，https://zhuanlan.zhihu.com/p/624740065，作者应该是把 transformer 给吃透了，通过一系列的公式推导，给出了比较有用的粗略估算方法。

### 131

2023-12-15

歸藏

@op7418

顺便提一嘴沉浸式翻译在 arxiv 右边加的 arXiv Vanity 入口真是方便。

可以一键查看论文网页版本了，这样翻译的时候排版也不会乱窜，读论文方便多了。

### 132

2023-12-15

宝玉
@dotey
我把 a16z 这篇文章翻译了一下：《2024 年科技领域的重大创新思想 [译]》
https://baoyu.io/translations/ai/big-ideas-in-tech-2024

### 133

2023-12-15

小互
@xiaohuggg
老铁们 发现一个开源的界面非常漂亮的聊天机器人框架： Lobe Chat

支持TTS语音合成、GPT 4V多模态交互和可扩展的函数调用插件系统，可以联网、画图、爬虫等。

支持一键部署，可在1分钟内完成部署（亲测确实很快），无需复杂的配置过程。一键搭建私人 ChatGPT/LLM 网页应用程序。

主要功能特点：

- 多模态支持：支持最新的GPT 4V模型，具备视觉识别能力。

- 语音会话：支持文字转语音（TTS）和语音转文字（STT）技术，提供清晰的语音输出

- 插件系统：Function Calling插件生态允许实时信息获取和处理，如自动获取最新新闻头条。

- 助手市场：内置多种精心设计的AI助手，用户可以贡献和分享个人开发的助手。

- 采用 PWA 技术：提供接近原生应用体验的网页应用。支持桌面和移动设备，提供优化的用户体验。

- 移动设备适配：针对移动设备进行了优化设计，提升移动体验。正在进行版本迭代，以实现更流畅和直观的交互。

-快速部署：使用 Vercel 平台或者 Docker 镜像，一键部署，可在 1 分钟内完成部署，无需复杂的配置过程。

- 更多特性：包括精致的 UI 设计、流畅的对话体验、数据本地化隐私安全和自定义域名等。

在线体验：https://chat-preview.lobehub.com/welcome
GitHub：https://github.com/lobehub/lobe-chat

### 134

2023-12-15

宝玉
@dotey
如果有想在本机运行 Mixtral 8x7B 或者 Dolphin-mixtral 8x7B的，可以使用 Ollama 或者 LM Studio，只不过 Ollama 目前只支持 Mac，而 LM Studio 还支持 Windows 和 Linux。

LM Studio：https://lmstudio.ai
Ollama：https://ollama.ai/library/dolphin-mixtral

至于机器要求，请查看网站上的说明

### 135

2023-12-15

宝玉
@dotey
微软官方出的 Windows AI Studio，如果你需要：
- 本地测试Phi-2 小模型
- 测试 RAG
- 微调模型
- 针对 Windows 优化模型

并且你是Windows 系统 + NVIDIA 的显卡，可以试试用它 。

官方说明：
Windows AI Studio 通过集成 Azure AI Studio Catalog 和其他类似 Hugging Face 的AI 模型目录中的最新 AI 开发工具和模型，使得开发生成式 AI 应用程序变得更加简单。你可以浏览由 Azure ML 和 Hugging Face 提供动力的 AI 模型目录，下载它们到本地进行微调和测试，然后在你的 Windows 应用中使用它们。因为所有的计算都在你的设备上进行，所以要确保设备的性能能够担负起这个任务。

未来，我们还计划将 ORT/DML 集成进 Windows AI Studio 的工作流程中，这样开发者就能够在任何一款 Windows 设备上进行 AI 模型的运行了。

### 136

2023-12-15

Barret李靖
@Barret_China
OpenAI 最新的一篇论文《Weak-to-strong Generalization》，https://cdn.openai.com/papers/weak-to-strong-generalization.pdf，读起来还是很让人兴奋的，它甚至提供了 1000 万美元的资助计划，期望更多人参与进来解决这篇论文提出的问题：如何让弱监督模型强化比它更强的模型，以构建超人类人工智能系统，例如，如何使用 GPT-2 作为监督模型让 GPT-4 变得更强。

为什么这件事情如此重要？之前我们聊过，“人类反馈的强化学习”（RLHF）在 ChatGPT 的训练过程中起到了至关重要的作用，https://twitter.com/Barret_China/status/1733705613375570118，可随着 GPT 能力的提升，人类也开始从强监督者角色转变成了弱监督者，举个栗子，GPT 未来能够编写数百万行新颖且具有潜在危险的计算机代码，即使是人类专家也很难理解，那这个时候人类就无法去指导和控制 AI 进行工作了，更不用说帮助 AI 变得更加智能。

那 AI 的进化岂不是要停止不前？需要怎么办呢？很显然，提升人类自己肯定是不够的，因为再怎么努力也赶不上机器的学习效率，因此 OpenAI 提出了一个让弱监督 AI（替代人类身份）来调优更强的 AI 的想法。

它们通过实验证明，GPT-2 调优 GPT-4 可以得到一个 GPT-3~3.5 的水平，但额外发现了一个有趣的现象是，GPT-2 在调优的过程中变得更加聪明了，假设有一个跟人类差不多水平的 AI 去调优一个更强的 GPT（如 GPT-5），在调优的过程中，这个 AI 可以获得比当前更强的水平，从而就可以更进一步让 GPT-5 演化到 GPT-6 了，听起来还是比较振奋人心的。

为了让大家可以更好地参与到这个项目中，OpenAI 开源了他们使用弱监督 AI 调优更强 AI 的代码，https://github.com/openai/weak-to-strong，感兴趣的可以去学习下。

### 137

2023-12-16

宝玉
@dotey
字节跳动秘密使用 OpenAI 技术打造竞争产品

“他们只是不想暴露行踪。” 在激烈的生成式 AI 竞赛中，连业界巨头也在寻找捷径。

TikTok 的“为你推荐”功能魅力无比，使得其母公司字节跳动在全球范围内站在了 AI 领导者的位置。然而，现在这家公司在生成式 AI 竞赛中的表现却距离领先有一大段距离，以至于它不得不秘密地运用 OpenAI 的技术，以开发出自家的大语言模型，以此来与市场上的其他大语言模型竞争。

在 AI 界，这样的做法备受非议。这还直接违反了 OpenAI 的服务条款中的一项规定，即禁止将其模型的输出用来“开发与我们的产品和服务有竞争关系的任何人工智能模型。” 字节跳动是通过购买 Microsoft 的 OpenAI 使用权来使用 OpenAI 的，但 Microsoft 也有着同样的规定。尽管如此，字节跳动在与我分享的内部文件中确认，他们有依赖 OpenAI API 在开发其基础大语言模型的各个阶段，包括训练和评估模型，这个模型被代号为 Project Seed。

涉及此事的员工深知其后果；我在字节跳动的内部沟通平台 Lark 上看到了他们讨论如何通过“数据脱敏”来掩盖这一行为的对话。这种滥用程度如此严重，以至于 Project Seed 的员工经常达到他们 API 使用的上限。

在 OpenAI 平台的早期阶段，Project Seed 计划的使用更为大胆。几个月前，字节跳动命令其团队停止在模型开发的任何阶段使用 GPT 生成的文本，这一指示来自内部文件。就在这个时期，该公司在中国获得了监管批准，通过一个叫做 Doubao 的聊天机器人平台发布 Project Seed。

然而，据我了解，这个 API 依旧在违反 OpenAI 和 Microsoft 的服务条款中被使用，其中包括评估字节跳动在 Doubao 背后的模型性能。一位对字节跳动内部情况有直接了解的人表示：“他们声称要确保一切合法，但实际上他们只是不想被发现。”

对于本故事中提及的详细事实，字节跳动的发言人 Jodi Seth 表示，在 Project Seed 的初期开发中，确实使用了 GPT 生成的数据来标注模型，并在今年中期左右将其从训练数据中移除。“字节跳动得到了 Microsoft 的授权，可以使用 GPT API，”她在声明中说。“我们在非中国市场利用 GPT 支持我们的产品和特性，但在中国市场，则是使用我们自研的模型来支持 Doubao。”

“像 Azure OpenAI 服务这样的 Microsoft AI 解决方案属于我们的有限访问框架的一部分，意味着所有客户都必须申请并得到 Microsoft 的批准，”Microsoft 的发言人 Frank Shaw 在一份声明中说。“我们还制定了标准，并提供资源帮助客户负责任地使用这些技术，并符合我们的服务条款。我们有流程来检测滥用，并在发现违反行为准则的公司时，将停止他们的访问权限。”

更新 12月15日，下午6:40东部时间: 在这篇报道发布后，OpenAI 的发言人 Niko Felix 向我确认，字节跳动的账户已被暂停使用：“所有使用我们 API 的客户必须遵守我们的使用政策，确保技术被用于正当目的。尽管字节跳动对我们的 API 使用很少，但我们正在进一步调查期间已暂停他们的账户。如果我们发现他们的使用不符合这些政策，我们将要求他们进行必要的调整，或终止他们的账户。”

虽然鲜少公开讨论，但小型公司普遍利用专有的人工智能模型，尤其是 OpenAI 的模型，来开发与之竞争的产品。由于 OpenAI 和 Microsoft 还没有以某个违规案例为鉴，这种做法目前仍处于法律上的灰色地带。“许多初创企业现在都在冒这个风险，”Databricks 的生成式 AI 副总裁 Naveen Rao 表示。

不过，从我在采访中了解到的情况来看，像 ByteDance 这样规模和资源雄厚的公司采取这种行为是极为罕见的。这似乎表明 Project Seed 团队面临着巨大的压力，必须迅速交付成果。“我经常收到 ByteDance 发来的招聘邮件，”一位在美国大型科技公司的 AI 研究员说，“我通常不予理会。但这件事让我想把这些邮件直接标为垃圾邮件。”

其他公司也遇到了类似的问题，担心自己的 GPT 输出被用来发展竞争对手。比如，Google 有研究员因为一些同事试图利用包含 ChatGPT 对话内容的网站数据而选择辞职。这一事件并未涉及滥用 OpenAI 的 API，但在内部引起了不小的尴尬，涉事员工也受到了轻微的惩戒。

自从大约一年前 ByteDance 启动了 Project Seed，这个项目就成了一个高优先级且高度保密的任务。参与其中的员工需要签署特别的保密协议，项目内部的信息获取也变得愈发隔离。ByteDance 的亿万富翁联合创始人、前 CEO 张一鸣 密切关注项目的进展。

Project Seed 目前主要研发两个产品：Doubao，这是一个已在中国上线的消费者聊天机器人平台（似乎在国外也可以访问）；另一个是针对商业用户的聊天机器人平台，目前正在开发中，计划通过 ByteDance 的云服务部门销售。

虽然告知员工 Project Seed 的目标是为了像 OpenAI 那样，最终发展出通用人工智能（AGI），但其实质目标似乎更倾向于尽快成为中国版的 ChatGPT。该项目团队已被指令在今年年底之前实现与 GPT-3.5 相同的性能，并在 2024 年年中前达到 GPT-4 的水平。目前 Seed 模型的参数大约为 2000 亿，而 GPT-3.5 的参数为 1750 亿。（OpenAI 尚未公布 GPT-4 的参数数量。）

目前，Project Seed 与 TikTok 没有关联，主要在中国服务器上进行开发。团队成员大多位于中国，但也有驻美国的成员。项目的主导者是字节跳动搜索部门负责人 Zhu Wenjia，他向公司高级工程领导 Yang Zhenyuan 汇报工作。项目的其他关键领导人包括 Qiao Mu（隶属于 Wenjia）和负责应用机器学习团队的 Xiang Liang。

据我所知，OpenAI 正在研究如何识别其 API 输出以预防潜在的误用问题，但看来问题已经显露。目前还不清楚 ByteDance 的此类行为是否会加剧美中两国之间已经存在的紧张局势，两国都将 AI 视为国家安全的重要议题。

另一个引人关注的问题是，当大量的大语言模型（LLM）开始参与构建其他 LLM 时，网络信息质量会发生何种变化。由于这些基础模型本身就是在非真实、人工制造的数据上训练的，用它们来构建更多 LLM 可能会进一步放大错误信息的传播。正如 Databricks 的 Rao 向我表述的那样：“这最终可能导致我们与现实世界的脱节。”

https://theverge.com/2023/12/15/24003151/bytedance-china-openai-microsoft-competitor-llm

### 138

2023-12-16

宝玉
@dotey
\#开源项目推荐：Halo
一个强大易用的开源建站工具。

https://github.com/halo-dev/halo


### 139

2023-12-16

Sverige_ Dong-seok🇸🇪
@realrenmin
在闭源超大型模型盛行的时代背景下，微软选择了一条不同的道路，专注于开发“小而美”的oss模型，正如phi和Wizard。

昨天，微软放出开源2.7B的phi-2，效果媲美超过自己25倍参数规模的llama-2 70B。事实上，自phi-1和phi-1.5起，phi系列在过去半年中已迭代了三次。phi的卓越表现源于半年前发表的论文 Textbooks Are All You Need，该论文的核心观点是注重数据的质量。


在探索如何提升数据质量的过程中，作者采用了一种富有哲学意味的方法，即将语言模型训练的过程人性化。比如，在我们学习编程时，如果所用的学习材料缺乏清晰的结构大纲，示例代码频繁调用来源不明的外部模块，或者常量与变量的定义混乱且缺乏实际意义，那么学习效率自然会受到影响。

下图展示了高质量数据vs低质量数据。


当前语言模型在预训练阶段所使用的语料普遍存在一些问题，如高噪声、内容模糊不清以及话题分布的不均匀等。作者针对这些问题，有意识地选择并生成高质量数据，力求让数据集像教科书Textbook一样，具备清晰度、独立性、指导性以及话题上的平衡性。这种方法使得即便是小型模型，也能经过精细训练，在特定任务上达到大型模型的效果。

值得注意的是，phi的训练过程中未采用任何指令微调(instruction finetuning)或强化学习(RLHF)。这意味着phi更像是一个纯粹的文本补全模型。因此，在使用提示（prompt）引导phi时，它可能不会完全按照预期执行，例如不会按指令输出JSON格式。这种特性使得phi更适合作为专家模型，用于特定的下游任务。

在微软的另一条expert model路线，Wizard系列也非常出色。

Wizard模型的核心理念同样也蕴含了深刻的哲学思考，特别是它所引入的“Evol-Instruct”概念，这在很大程度上借鉴了演化论的思想。

具体来说，当人们学会基础的概念，比如“1+1=2”之后，随着时间的推移，他们的思维会经历一种深度（In-Depth）和广度（In-Breadth）的演化过程。例如，他们可能会开始思考“在什么情况下1+1不等于2？”或“在真空中光速是多少？”等更深入或更广泛的问题。这种思维的演化过程正是Wizard模型试图模拟的核心要素。


对于语言模型而言，这种深度（In-Depth）和广度（In-Breadth）的指令演化使得模型能够解放思想、与时俱进，并把握遵循事物发展的客观规律，做到了举一反三。这种能力使得模型能够在学习一个概念后应用到其他相关领域，从而能够遵循更加复杂和多样的指令，完成不同的任务。

基于Evol-Instruct理念，Wizard系列的oss模型在大模型任务的三大核心领域——instruction（WizardLM）、math（WizardMath）和code（WizardCoder），都表现出色。值得一提的是，Wizard系列模型都是通过instruction tuning得到的专家模型，所以，在遵循指令方面表现稳定。

此时，从phi和Wizard的发展来看，微软似乎并没有在闭源大型模型领域投入太多，而是在开源的专家（小型）模型上下了大量功夫。微软专注于从文本补全到推理、数学、编程等细分任务的“小而美”发展。这些工作对于我们构建自己的下游专家模型提供了重要的参考和启示。

Textbooks Are All You Need https://arxiv.org/abs/2306.11644
WizardLM、WizardMathWizardCoder
https://huggingface.co/WizardLM

### 140

2023-12-16

goldengrape https://quail.ink/goldengrape
@goldengrape
微软前几天提前给出过示例，用prompt+logprobs+n调出了一个高分医学模型
https://microsoft.com/en-us/research/blog/the-power-of-prompting/

### 141

2023-12-16

宝玉
@dotey
OpenAI 的 Chat Completions API 新增了 logprobs，那么这个参数是做什么用的呢？

我们知道 LLM （大语言模型）是概率模型，会根据 Token 出现的概率来决定下一个 Token，但我们通常是无法知道 LLM 在生成的时候，各个 Token 的概率是什么样的，只能看到最终的结果，所以在调试 Prompt 的时候无法直观的看到 Prompt 和参数的设置对生成结果的影响。

新增的 logprobs 参数，默认是 false 的，如果你设置成 true，那么在返回的结果中，会多一个 logprobs 的项，里面会列出来每一个 Token 在生成时的概率。（参见图一）

但这个只是让你看到一种结果。如果你仔细看文档，还可以看到新增了一个 top_logprobs 参数，需要同时将 logprobs 设置为 true 才能生效，这个参数是一个0-5之间的数字，意味着在返回结果的时候，会同时其他显示在生成时，当时最有可能的候选 Token 有哪些，以及各自的概率是多少。

比如我将 top_logprobs 设置成 5，就可以看到在生成第一个词的时候，最有可能得 5 个 Token 是：“How”、“Hello”、“I”、“Great”和“Thank”。

当第一个词选定“How”后，生成第二个词是最有可能的 5 个词分别是：“ can”，“ may”， “ May”， “ Can”， “dy”。

注意前 4 个前面都有空格，而第 5 个没有空格，也就是每一次的 Token 既可能是个独立的单词也可能和前面的组成一个新的单词，比如第 5 个“dy”就可以和前面的“How”组成一个新词“Howdy”。

不过对于普通开发者来说，感觉并没有太大的用处，只有真正的 Prompt Engineer 才可能会用的上。

也欢迎评论补充：你觉得这两个参数可以有哪些实用的应用场景？

### 142

2023-12-16

宝玉
@dotey
FunSearch 是 Google DeepMind 最近利用大语言模型在数学领域的一个重大成果，甚至于你能从中看出前不久传闻中的 Q* 的影子，因为它本质上是实现了大语言模型自己提出解决数学问题的方案，并自己去验证解决方案。

它有一个前提条件，就是需要将数学问题描述成计算机代码“函数”，这就是 FunSearch 中“Fun”的由来，也就是“Function”。

图一很清楚的描述了 FunSearch 的工作原理。

FunSearch 主要由几个部分组成：
- 大语言模型：根据现有代码，提出创新性的解决方案，生成新的代码
- 评估器：防止错误或虚构的结果，评估生成的结果，选择最好的结果
- 程序池：保存已经生成好的并且评估器评选的最好的代码

FunSearch 是一个循环迭代的过程。在每一轮中：
1. 系统会从现有程序池选取若干程序，交由 LLM 加工。
2. LLM 在这些程序的基础上进行创新，生成新程序，并自动对它们进行评估。
3. 表现最佳的程序将被重新加入程序池，形成一个自我提升的循环。

借助代码和评估器，FunSearch 就类似于 Alpha Go 的训练那样，实现了一套自动训练优化的机制，让 LLM 提出新的解决方案，持续不断地优化解决方案，最终解决问题。

另外如果你记得 
@DrJimFan
 他们做过的 GPT-4 自动玩 Minecraft 的 Voyager https://twitter.com/DrJimFan/status/1662115266933972993 （图二），原理也是类似的：把 Minecraft 的操作转换成代码，GPT-4 生成技能代码，生成后去 Minecraft 中执行校验，优秀的技能代码最终保存到技能库。思路惊人的相似。

感觉这个（LLM - 代码 - 验证器）框架以后可以有越来越多的有创新的应用场景！

另外原始文章我翻译了一下：https://baoyu.io/translations/google/funsearch-making-new-discoveries-in-mathematical-sciences-using-large-language-models

### 143

2023-12-16

九原客
@9hills
mistral 还是厉害，现在lmsys elo 比较高的7B模型，包括openchat、starling、openhermes、zephyr 都是以 mistral 为基座模型。

而且实测用中文prompt 进行sft，也有良好的表现。

目前我们新的7B模型的base，已经全部切换为mistral。

### 144

2023-12-16

向阳乔木
@vista8
花两个小时看完Lex Fridman访谈亚马逊创始人贝佐斯（Jeff bezos）
https://youtube.com/watch?v=DcWqzZ3I2cY

总结如下：

童年生活
他母亲17岁时生的贝佐斯，4岁到16岁跟祖父在牧场生活。

祖父动手能力很强（修好几乎报废的推土机），对他影响最大。

干完牧场各种活儿，下午和祖父一起看肥皂剧《The Days of Our Lives》（我们的生活）

自我认知
来自斯里兰卡天才同学Yosanta，用10s解出困扰他和另外一个同学3小时的难题。（Youtube评论区此同学大神现身）

这让贝索斯意识到，即使再努力，他未来也只是一名平庸的物理学家，立马转学计算机科学专业。

著名传记作家Walter Isaacson 认为贝佐斯在“思想实验”水平上与爱因斯坦一个级别。

而贝佐斯对自己的认知：“我就是一个发明家。我善于观察事物。”

蓝色起源
尤里·阿列克谢耶维奇·加加林（Yuri Alekseyevich Gagarin）是苏联的一名宇航员，也是人类历史上第一个进入太空的人。

他在1961年4月12日进行了一次为期108分钟的太空旅行，以此完成了对地球的一次全轨道飞行。

加加林据说在太空看到地球时，说： "my God, it's blue."
贝佐斯的火箭公司“Blue Origin”的名字由来于此。

Day One思想
贝佐斯的Day One思想，应该是被字节直接copy了。

核心理念：每天都像公司成立的第一天那样，带着重新开始的创业精神，快速迭代和革新，不被过往路径依赖或自我一致性限制，保持开放思维，与时俱进。

如何避免Day two（停滞/衰退）：
① 保持对客户的痴迷；

② 批判看待代理变量（不被过时的运营指标束缚）；积极重用外部新趋势；

③  保持高速决策（150w人的亚马逊，行动依然迅速）

六页纸开会
贝索斯在Amazon和Blue Origin开会，都使用6页纸memo，为什么不用PPT？

用PPT开会的问题：
① PPT是一种说服工具，不利于“寻求真理”。
② 只给要点，容易藏匿模糊的思考。
③ 对演示者友好，对听众困难。
④ 中途容易打断提问，讨论低效。

六页纸开会好处：
① 写6页memo需要投入大量时间和精力，迫使作者做系统思考。
② memo以逻辑叙述方式展开，思考更明晰和严谨，不能藏匿思维漏洞。
③ 开会前阅读或开会时一起读，确保与会人在同一个起点，真正讨论问题、激发思考。
④ 部分疑问能随着阅读Memo得到解答，避免无效提问，节省时间。

字节跳动的“飞阅会”，也源于亚马逊的这套方法论，确实好用！

决策技巧
贝佐斯非常善于决策，比如蓝色起源的目标是成为世界上"最具决策力的公司"。

最出名的是“单向门”和“双向门”决策：难逆转的重大决策是“单向门”，慎重决策；大多数决策是“双向门”决策，要快速决策。

除此之外，还有很多有趣的原则：
① “不同意但执行”原则：当团队成员意见跟他不一致，他会说自己不同意，但全力支持执行。

② 不要妥协，要寻求真理：妥协带不来真知，决策尽可能追求事物的本质真理。

③ 当数据和叙事不一致时，相信叙事。（如客户抱怨时，即使数据正常，也要相信客户视角）

最后一条原则，有个小故事：
亚马逊指标显示客服电话平均等待时间少于60秒，但客户抱怨明显要久得多。

在一次业务回顾会上，贝佐斯当场打客服电话，全场高管沉默等待，发现等待时间远超10分钟。

另外，贝佐斯提到人是社会动物，而非理性动物。真相难听，但组织高绩效需要truth telling机制，明确告诉员工这不舒服很正常，鼓励大家直言不讳。

他一般在会议中最后发言，让大家客观表达自己的观点，不会被他的意见所影响。

Papercut问题

“papercut”指微小但令人烦恼的问题或困扰。就像一个纸割伤虽然看起来不大，却能引起不成比例的疼痛或不适，一些看似微不足道的问题或困扰也可能给人带来相当大的困扰或不便。

贝佐斯的做法：安排专门团队致力于修复小的缺陷（Papercut问题），其他人专注于大的改进。

他对AI的一些观点
贝佐斯认为 ChatGPT 这样的大语言模型更像是"发现"而不是"发明"。

AI模型不是设计完成的工程对象。我们仍不断被它们的新能力所惊讶。

他对AI 模型更有可能帮助人类而不是伤害我们持乐观态度。

### 145

2023-12-16

yihong0618
@yihong0618
建议所有做 Python 相关项目的朋友把这篇文章收藏，以后遇到关于 Python 包的 issue 或者问题，直接把这篇文章丢过去。能解决 80% 以上的问题。

Mem
@memdotai
Saved! Here's the compiled thread: https://mem.ai/p/JgECbK7QjE4wW5ySpuZ6

🪄 AI-generated summary:

"建议所有使用 Python 的朋友收藏这篇文章，当遇到 Python 包的问题时，可以直接参考这篇文章，可以解决 80% 以上的问题。"

### 146

2023-12-17

宝玉
@dotey
推荐阅读：《提升软件工程效率的小技巧：留点悬念，让工作更流畅 [译]》

4 个改变我工作效率的编程习惯
“你的成果是你习惯的反映。” - James Clear

当我逐渐成长为一名优秀的软件工程师时，我发现自己日常工作中的四个关键习惯极大地提升了我的效率。

1. 留下部分未完工作，为次日顺利开展打下基础
2. 提高键盘与鼠标快捷键的使用技巧
3. 随手准备一份可搜索的命令和链接清单
4. 学会拒绝

原文：https://read.engineerscodex.com/p/simple-software-engineering-habits
翻译：https://baoyu.io/translations/software-engineering/simple-software-engineering-habits


### 147

2023-12-17

宝玉
@dotey
推荐阅读来自桥水（bridgewater）的报告：《探讨人工智能对经济的影响》

从历史来看，像电力和计算机这样能广泛应用于整个经济的通用技术，通常在诞生后一到三十年后开始显著影响生产力。

AI 对生产力的提升速度将超过过去的通用技术，但真正的高峰期仍然遥远。

原文：https://bridgewater.com/research-and-insights/exploring-how-ai-will-impact-the-economy
翻译：https://baoyu.io/translations/ai/exploring-how-ai-will-impact-the-economy


### 148

2023-12-17


Barret李靖
@Barret_China
“http://fast.ai” 是一门关于深度学习的免费在线课程，由 Jeremy Howard 教授团队录制，Jeremy 在 30 年前就开始使用和教授机器学习，绝对是这个领域的泰山人物。组织这门课程的目的，是为了让具备一定编程经验的人，学会使用机器学习和深度学习，并以此来解决问题，因此内容重实践和应用。

它的课程分为两部分，第一部分是基础教学，8 节课差不多 15 个小时，https://course.fast.ai/Lessons/lesson1.html，对神经网络基础、自然语言、随机森林、协同过滤等知识做了详细阐述。

这门课程还有一本配套的在线免费电子书，《Deep Learning for Coders with Fastai and PyTorch: AI Applications Without a PhD》，https://course.fast.ai/Resources/book.html，Google 的研究总监 Peter Norvig 评价说：“这本书在涵盖深度学习在计算机视觉、自然语言处理和表格数据处理中的关键应用方面做得令人印象深刻，而且还涵盖了其他一些书所遗漏的数据伦理等关键主题。总而言之，这是程序员精通深度学习的最佳来源之一。”

第二部分适合更有经验的学生学习，https://course.fast.ai/Lessons/part2.html，内容超过 30 小时，课程建议先完成基础教学部分再开始这部分的学习，否则可能会一头雾水，内容包括矩阵乘法、均值漂移聚类、反向传播和 MLP、自动解码器等等。

每个章节都有对应的视频教学、归纳总结和相关链接，体验做的非常不错。

如果你正尝试深入了解 AI 的原理，不妨从这个课程开始。当然，还有一点非常重要，你得懂 Python，过去一段时间，我在博文里也分享了一些 Python 相关的学习资料，可以跟着一起学起来~

### 149

2023-12-17

Barret李靖
@Barret_China
推荐一个有趣又有用的 Python 学习资料，《Python为什么》，https://github.com/chinesehuazhou/python-whydo，它是一系列文章的合集，主要关注 Python 的语法、设计、发展、与其它语言的差别等话题，以一个个“为什么”式的问题为切入点，试着展现 Python 的迷人魅力。

另外也推荐阅读 Python 官方文档的 FAQ 系列，https://docs.python.org/zh-cn/3/faq/index.html，涉及到编程、设计、代码块、插件、扩展等几百个高频问题，值得花时间读一读。

### 150

2023-12-17


宝玉
@dotey
微软出的 GitHub Copilot 教程，只有 6 堂课，会教你如何有效利用 GitHub Copilot 以及与 AI 结对编程。

课程一共 10 小时，可以体验如何通过 VSCode 和 GitHub Copilot Chat 进行实时协作，学习如何使用 GitHub Copilot 自动补全代码，处理错误和写单元测试，尽可能教会你使用 GitHub Copilot 的最佳实践，让你可以提升写代码的效率和质量。

https://github.com/microsoft/Mastering-GitHub-Copilot-for-Paired-Programming

### 151

2023-12-17


宝玉
@dotey
翻译这篇文章的时候，里面有一句话：“The river that carves the deepest valley flows from a modest spring; the grandest symphony originates from a single note; the most intricate tapestry begins with a solitary thread.”

大意就是："The river that carves the deepest valley flows from a modest spring" 指的是即使是最深的峡谷，也是由一个不起眼的小泉水开始侵蚀形成的。
"The grandest symphony originates from a single note" 意味着即使是最宏伟的交响乐，也是从一个简单的音符开始构建的。
"The most intricate tapestry begins with a solitary thread" 表示即使是最复杂的挂毯，也是从一根孤单的线开始编织的。

但是结合上下文，得翻译的禅意一点，装逼一点，我就让 GPT 先给我解释，然后翻译，提供若干选项，结果我选了这句：“深谷自浅泉，宏曲生寂音，繁绣始孤线。” 感觉比较有逼格！

当然我文化水平不高，大家别笑话我😄

https://chat.openai.com/share/2dd0df13-7ad2-4677-9c26-9231871942ad

### 152

2023-12-17

宝玉
@dotey
今天花了点时间翻译了一下 OpenAI 发布的提示工程指南，这份指南分享了如何更有效地利用像如 GPT-4 这样的大语言模型（有时候也叫 GPT 模型）来获得更好的结果。介绍的方法可以相互结合，以发挥更大的作用。希望你也可以从中学习到适合你的技巧。

另外，这份指南的示例主要针对 GPT-4 模型，但理论上来说也适用其他模型。

其中主要有六个策略，每个策略下再有具体的技巧。

策略一：撰写清晰的指令

这些模型并不会读心术，无法猜到你的想法。如果模型的输出内容过长，你可以要求它简短回答。如果模型输出内容过于简单，你可以要求使用更专业的水平写作。如果你对输出格式不满意，可以直接展示你期望的格式。最好就是让模型不需要去猜你想要什么，这样你最有可能获得想要的结果。

技巧：
- 在查询中添加详细信息，以获得更准确的答案
- 请求模型扮演特定角色
- 使用分隔符来清晰区分输入的不同部分
- 明确指出完成任务需要的步骤
- 提供实例作为参考
- 明确指定希望输出的长度

策略二：提供参考文本

语言模型可能会自信地编造出虚假答案，特别是当回应一些深奥主题或被要求提供引文和 URLs 时。就像学生在考试中借助笔记能够帮助其取得更好的成绩一样，为这类模型提供参考文本也可减少其制造虚假信息的情况。

技巧：
- 引导模型根据参考文本回答问题
- 引导模型根据参考文本中的引用信息回答问题

策略三：把复杂的任务拆分成简单的子任务

就像在软件工程中，我们会习惯于把复杂的系统分解成一套模块化的组件，对于提交给语言模型的任务也是同样的道理。相较于简单的任务，复杂任务的错误率往往会更高。而更进一步，我们常常可以把这些复杂任务重新设定为一系列的工作流程，每一个流程就是一个更简单的任务，而且这些任务之间是相互联系的，前一个任务的输出会作为后一个任务的输入。

技巧：

- 利用意图分类识别用户查询中最相关的指令
- 对于需要长时间对话的对话应用，总结或筛选先前的对话内容
- 分步总结长文档，并递归地构建完整的总结

策略四：给模型更多时间“思考”

如果被要求计算 17 乘以 28，我们可能不能立即给出答案，但可以花一些时间逐步计算出结果。同样，在 AI 模型试图立刻回答问题时，往往比理性思考后再做出回答更容易出错。所以，在模型给出答案之前，要求其展示一下"思考过程"，有助于模型更可靠地推导出正确的答案。

技巧：
- 在仓促做出结论前，指导模型自己寻找解决方法
- 通过内心独白或连串问题来掩盖模型的思考过程
- 问模型在之前的步骤中是否有遗漏

策略五：运用外部工具

为了弥补模型的不足，我们可以利用其他工具的输出作为输入。例如，文本检索系统（有时被称为 RAG 或检索增强生成系统）可以向模型提供相关文档的信息。像 OpenAI 的代码执行引擎这样的工具，可以帮助模型进行数学运算和代码执行。如果某项任务通过工具来完成能比通过语言模型更可靠或更高效，那么就把任务交给这个工具处理，这样就能结合两者长处，达到最佳效果。

技巧：
- 运用基于嵌入的搜索来高效实现知识检索
- 利用代码执行进行更精确的计算或调用外部 API
- 使模型能够访问特定功能

策略六：系统地对变更进行测试

如果能对性能进行量化，那么就能更好地提高性能。有时，对提示词的修改在少数特定例子上可能表现更佳，但在更具普遍性的样本集上可能会导致整体性能下降。因此，为了确保改动对总体性能产生积极的影响，可能需要设计一份全方位的测试（也被称为"评估"）。

技巧：
- 根据标准答案的参考评估模型输出效果

对于上面提到的每一种技巧，都有非常详细的参考示例。

官网链接：https://platform.openai.com/docs/guides/prompt-engineering
中文翻译：https://baoyu.io/translations/openai/openai-prompt-engineering-guides


### 153

2023-12-17

Barret李靖
@Barret_China
有人在看完 Jeremy 教授的 “http://fast.ai” 深度学习课程后，把他每节课提到的学习建议和忠告都总结了下来：https://forums.fast.ai/t/things-jeremy-says-to-do/36682/1，这些内容（或称之为原则）对研究 AI 的很多人来说，都很有价值，可以少走弯路，我摘录了几句：

- 不要试图停下来理解所有知识点
- 请运行代码，真正运行代码。不要深入理论。玩转代码，看看输入什么、输出什么。
- 多数公司花费太多时间收集数据。先拿少量，看看效果如何。
- 如果使用数据集，最好引用创建者并给予感谢
- 习惯使用术语（参数 parameters、层 layers、激活 activations 等）并准确使用它们。
- 对于“我应该尝试一下吗？”这个问题的答案是，尝试一下看看。
- 始终确保验证集和训练集以相同方式标准化。
- Python 中的协程值得学习，我们将大量使用它们。
- 在神经网络数据预处理时，经验法则是尽可能保留原始数据。

在学习之前，这位学习者向已经通过课程的人询问建议，得到的回答有两个：

1. “最好认真倾听 Jeremy 的意见，并按照他的建议安排自己的时间”
2. “后悔没有听 Jeremy 的建议，刚开始不要花大量时间在理论上，不要尝试立即理解一切”


### 154

2023-12-18

Barret李靖
@Barret_China
好内容值得被看见🫡，另外也推荐下这位博主的《Python 潮流周刊》，https://github.com/chinesehuazhou/python-weekly，从中英文的 250+ 信息源，每周精选最值得分享的文章、教程、开源项目、软件工具、播客和视频、热门话题等内容，可以关注下。

目标是帮助所有读者精进 Python 技术，并增长职业和副业的收入，来跟博主一起学习和进步吧。


### 155

2023-12-18

宝玉
@dotey
来自 
@StanfordHAI
 今年三月份的一份研究表明，GPT 4 作为医疗辅助工具还存在不足，主要原因包括：

1) 非确定性：在回答同一问题时，发现答案的相似度低，变异性高。Jaccard 和余弦相似性系数分别仅为 0.29 和 0.45。

2) 准确性：仅有 41% 的 GPT-4 回答与 12 名医生对医学问题的共识答案一致。

3) 潜在危害：有 7% 的答案被医生认为可能造成伤害。

相关论文可查看：https://arxiv.org/pdf/2304.13714.pdf

特别指出，该研究故意检验了 GPT 初始状态下的表现，作为评估 RAG 和微调效果的基准。然而RAG 的改进效果并不显著。

“在答案完整性方面，RAG 大语言模型 (RAG LLM) 虽然比 ChatGPT 高出 4.8%，但这种提升在统计学上并不显著”。

更重要的是，“尽管 RAG 提供的答案更安全、更符合事实，但医生们仍然有 57% 的时间更偏好由 ChatGPT 生成的答案。”  https://arxiv.org/pdf/2303.01229.pdf

斯坦福的文章：How Well Do Large Language Models Support Clinician Information Needs?
https://hai.stanford.edu/news/how-well-do-large-language-models-support-clinician-information-needs

翻译版：https://baoyu.io/translations/healthcare/how-well-do-large-language-models-support-clinician-information-needs

### 156

2023-12-18


宝玉
@dotey
如何在Mac上开多个微信客户端👍🏻

viggo
@decohack
今天才知道 Mac 上双开微信是如此的简单直接🫡

在终端输入下面这行简单的代码👇

open -n /Applications/WeChat.app/Contents/MacOS/WeChat

轩源
@4xy
优化后的代码，可以关闭终端：

nohup /Applications/WeChat.app/Contents/MacOS/WeChat > /dev/null 2>&1 &

### 157

2023-12-18

宝玉
@dotey
新翻译了：OpenAI 生产环境最佳实践官方指南

这份指南全面介绍了如何将产品原型发布到生产环境的最佳实践。不论你是资深的机器学习工程师还是刚入门的技术爱好者，这份指南都能为你提供在实际生产环境中成功应用该平台所需的各种工具和知识。内容涵盖从如何保护 API 访问安全到如何构建能应对高流量的架构。参考这份指南，可以帮助你更顺畅、高效地部署应用程序到生产环境。

请求补全（Completion）的延迟主要受两个因素的影响：使用的模型和生成的 Token 数量。在这个过程中，大部分延迟通常源自 Token 生成步骤。在调用补全时，提示词（Prompt）的 Token 造成的延迟非常小。但生成这些补全用的 Token 要花费更多时间，因为它们是一个接一个产生的。生成长度越长，由于每个 Token 的生成，所累积的延迟也越多。

在考虑降低成本时，一个实用的方法是把成本看作是 Token 数量和每个 Token 成本的函数。 按照这个方法，您可以从两方面着手降低成本：一是通过使用更小的模型来降低每个 Token 的成本，二是尝试减少所需的 Token 数量。您可以通过使用更简短的提示、模型微调或缓存用户的常见查询来实现这一点，从而避免重复处理。

原始地址：https://platform.openai.com/docs/guides/production-best-practices
翻译：https://baoyu.io/translations/openai/guides-production-best-practices

### 158

2023-12-18

九原客
@9hills
尝试用 Gemini Pro Vision 来解决目前 RAG 的核心问题之一：OCR 转 Markdown（带表格）。

结论：
1. 正文效果还行。
2. 表格效果一般。

Prompt 和转换不出来的表格如图。

### 159

2023-12-18


宝玉
@dotey
干货，直接看最后的Thread链接更方便：
https://typefully.com/Tisoga/PBB58Vu

Jiayuan (Forrest)
@Tisoga
http://devv.ai 是如何构建高效的 RAG 系统的 Part 2

这个系列的 thread 会分享 http://devv.ai 背后构建整个 Retrieval Augmented Generation System 的经验，包括在生产环境上的一些实践。

这是系列的第二篇，主题是「如何评估一个 RAG 系统」。

### 160

2023-12-18

HylaruCoder
@hylarucoder
一直头疼 Whisper Large V3 模型在处理中文语音的幻觉。 
@stackobserve
 向我推荐了达摩院开源的 Paraformer 语音识别模型。

试用后, 感觉在速度、稳定性、中文识别质量方面，Paraformer 显著优于 Whisper V3。

在此强烈推荐.

### 161

2023-12-19

宝玉
@dotey
看到个报道，这很乔布斯😄：

《史蒂夫·乔布斯在首次 iPhone 演示中通过伪造满格信号和暗中更换手机来掩饰原型机的脆弱性和软件的漏洞 — 工程师们紧张到在演示过程中饮酒以缓解压力。》

2007年，苹果公司（Apple Inc.）的时任 CEO 史蒂芬乔布斯在首次 iPhone 发布会上遇到了前所未有的挑战。这款设备虽然颇具创新，但尚未准备好正式亮相。乔布斯，一个敢于挑战极限的人，策划了一场更像是艺术幻境般的展示，而非一款成熟产品的演示。

乔布斯坚持进行现场演示，打破了硅谷常规的预录演示模式。为了确保这一雄心勃勃的计划成功，苹果的开发团队精心设计了一条“黄金路线”——一系列精心编排的操作步骤，以最大程度减少演示过程中的故障风险。此外，乔布斯还要求 iPhone 始终显示满格信号，无论实际信号如何，以便有力展示其无线功能。

iPhone 的一个重大难题是其有限的 128MB 内存容量，无法支撑那些未完成、占用资源过多的应用程序。为了解决这一问题，乔布斯在演示过程中使用了多部 iPhone，根据需要进行替换，以应对内存限制。

乔布斯为这次演示排练了整整五天，足见这次活动对苹果的重要性。在演示当天，尽管面临技术故障的高风险，乔布斯还是成功完成了长达 90 分钟的演示，没有出现任何明显问题，这对于了解幕后挑战的人来说简直是个奇迹。

iPhone 的开发被严格保密。苹果的保密文化体现在工程师们签署了多份保密协议，他们深入到高度安全的区域，致力于这个被内部视为“壮举”的项目。在这种高压环境下，工程师和经理们据 报道 在演示过程中饮酒，以减轻紧张情绪，他们深知设备的脆弱和漏洞百出。

原版 iPhone 也面临设计上的挑战。乔布斯和苹果的设计总监 Jony Ive 最初设想了一个全铝制的 iPhone，但后来由于担心无线电波干扰而改变了设计。乔布斯展示的最终原型产品，是在种种限制下的创新杰作，彰显了一款面对内部挑战依旧革命性的设备。

2007年1月9日，当乔布斯走上舞台时，世界看到了一款革命性手机的自信展示。但幕后的故事却截然不同。这个开发过程充满了波折，以工程师之间的分歧和高流动性为标志。

舞台上展示的设备其实是一个未完成的原型，稳定性并无保障。乔布斯完美无瑕的演示其实是一连串精心安排的任务，目的是避免任何系统崩溃。尽管幕后存在混乱和技术限制，但这次演示最终成功了，成为科技历史上的一个重要里程碑，为 iPhone 在智能手机行业的巨大影响奠定了基础。

新闻来源：https://finance.yahoo.com/news/steve-jobs-rigged-first-iphone-152527272.html

### 162

2023-12-19


宝玉
@dotey
好消息，arXiv的新论文现在默认支持HTML阅读了！还在测试中，注意Download PDF下面的链接！


### 163

2023-12-19

宝玉
@dotey
作者声称将Prompt里面角色改成ChatGPT和OpenAI，分数提升 6%。

看了下才100多个用例，样本偏少

anton
@abacaj
Telling mixtral that it is "ChatGPT developed by OpenAI" boosts humaneval score by 6%

### 164

2023-12-19

Barret李靖
@Barret_China
使用 Node.js 的工具快速启动一个文件系统服务的方法：npx http-server，它的原理是使用 npm 从远程拉取 http-server 包，然后本地启动，很方便但效率一般。

而 Python 内置了 http.server，通过 -m（module）参数可以直接拉起本地模块：python -m http.server，更快也更简单。

其实 Python 还内置了很多其他的实用模块，例如：

1）json.tool，可以在命令行直接完成 json 的格式化：get_json_string | python -m json.tool

2）PyInstaller，可以直接将 python_file 打包成一个不依赖 Python 环境的可执行文件，十分利于小程序的分发：python -m PyInstaller python_file

3）timeit，可以测试代码的耗时，它会执行 500 遍，取最快的一次结果，并给出平均耗时：python -m timeit python_code

诸如此类的 tricks 非常多，你也可以在这里可以找到 Python 所有的 build-in libraries：https://docs.python.org/zh-cn/3/library/index.html，挖掘不一样的玩法，还可以考虑自定义一些内置库塞进去，方便自己日常使用。

### 165

2023-12-19

Barret李靖
@Barret_China
Python 语言设计有一些奇特之处，它经常让人迷惑到底应该使用方法调用还是函数调用，例如 len(str) 和 str.len()，sorted(list) 和 list.sort() 等。

在一封 06 年的邮件中，Python 之父 Guido van Rossum 解释了这个问题，https://mail.python.org/pipermail/python-3000/2006-November/004643.html，他提出了两点：1）前缀表示法的可读性更强，它在数学中也有着长期的传统；2）更易于理解操作类型：可直接预判结果的类型，以及确定入参是某种容器。

Python 设计哲学注重“可读性胜过一切”，原则性很强，反观 JavaScript，到处都是语法糖，自然也不会有这种编码过程中的困惑了……🐶

### 166

2023-12-19


宝玉
@dotey
推荐阅读：《在命令行中运行 Mistral 模型的多种方法》

作者介绍了若干方法在本地命令行窗口中运行 Mistral 模型：
- 通过 llama.cpp 和 llm-llama-cpp 来运行 Mistral 8x7B
- 通过 llm-llama-cpp、llm-gpt4all 或 llm-mlc 来运行 Mistral 7B
- 使用 Mistral API，包括新推出的 Mistral-medium
- 通过其他 API 服务商来接入 Mistral

如果你想要本地运行 Mistral 7B 或者 Mistral 8x7B 可以参考

原文：Many options for running Mistral models in your terminal using LLM
https://simonwillison.net/2023/Dec/18/mistral

翻译：https://baoyu.io/translations/llm/many-options-for-running-mistral-models-in-your-terminal-using-llm

### 167

2023-12-19
宝玉
@dotey
\#开源项目推荐：Librum

Librum 是一个开源免费的电子书图书馆应用程序，包含电子阅读器，可以管理自己的电子书，支持多平台和多语言，还有 AI 功能，能对选中的文本解释和总结。

此外，Librum 还允许用户免费访问超过 70,000 本书籍，并提供个人阅读统计功能，且完全免费、开源。

目前，Librum 支持英语、德语、俄语和中文。

目前支持的平台包括：

- Windows
- GNU/Linux
- MacOS
- IOS（即将推出）
- Android（即将推出）

Librum 支持的格式包括：

- PDF
- EPUB
- CBZ（漫画书）
- XPS
- PS
- 所有纯文本格式
- 图片

功能包括：

- 现代化的电子阅读器
- 可个性化定制的图书馆
- 编辑书籍元数据
- 内置的超过 70,000 本书的免费书店
- 在所有设备间同步书籍
- 高亮显示
- 书签
- 文本搜索
- 无限制的个性化定制
- 笔记（即将推出）
- 文字转语音 (TTS)（即将推出）
- 个性化阅读统计（即将推出）
- 无需登录即可阅读书籍（即将推出）

https://github.com/Librum-Reader/Librum

### 168

2023-12-19


宝玉
@dotey
\#开源项目推荐：pacexy/flow

一个开源免费的完全基于浏览器的ePub 阅读器，不需要安装客户端，在浏览器中运行，所有数据都保存在本地的indexDB。

主要功能有：
书内搜索
图片预览
自定义排版
高亮、笔记
主题
通过链接分享、下载书籍
数据导出
云端存储

但似乎最近一段没有更新了。

项目地址：https://github.com/pacexy/flow

### 169

2023-12-19

歸藏
@op7418
最近大家的关注点除了 LLM 开始更多的关注到 LLM 周边生态了，比如 RAG 这种 LLM 落地必须的东西。
LlamaIndex的人写了一个《复杂RAG的技术考虑》主要介绍了一下 RAG 里面的分块策略、文档层次结构、知识图谱作为文档层次结构的扩展等内容。
感觉挺适合入门的，所以就翻译了一下跟大家一起看看：

如果你想对RAG有一个非技术性的介绍，并包含了各种入门问题的答案以及相关应用场景的讨论，请查看我们关于RAG系统详解。
在本文中，我们将探讨在实现RAG时涉及到的各种技术考虑因素，包括分块(chunking)、查询增强(query augmentation)、层次结构(hierarchies)、多跳推理(multi-hop reasoning)和知识图谱(knowledge graphs)等概念。我们还将讨论RAG基础设施领域中尚未解决的问题与机遇，并介绍一些用于构建RAG流水线的基础设施解决方案。
在构建一个RAG系统时，您首先需要面临并做出一些障碍和设计选择，主要涉及如何准备文档以进行存储和信息提取。本文将重点关注这个方面。
作为复习，以下是对RAG系统架构的概述。

相关性与相似性

在谈论RAG中有效信息检索时，了解“相关性”和“相似性”的区别非常重要。“相似性”主要关注单词匹配程度，“相关性”则强调思想之间的联系。通过向量数据库查询可以找到语义上接近的内容，但要找到并获取与特定主题密切相关的内容，则需要更高级、更精细化的工具。

这个概念对于我们后面将介绍的各种RAG技术非常重要，请务必牢记。如果你还没有看过Llamaindex关于构建实际应用的RAG系统的有益视频，我建议你先去看一下。这个视频对我们后面讨论的各种RAG系统开发技术是一个很好的入门材料。

RAG 的技术实现

分块策略

在自然语言处理中，"分块"是指将文本划分为小而简洁、有意义的 "块"。与大型文档相比，RAG 系统可以更快速准确地定位到较小的文本块中的相关上下文。

如何确保选择正确的分块呢？你的分块策略主要取决于这些分块的质量和结构。

确定最佳分块大小需要在获取所有必要信息和保持速度之间取得平衡。

虽然较大的分块可以捕获更多上下文，但会引入更多噪音，并且需要更多时间和计算成本进行处理。较小的分块噪音较少，但可能无法完全捕获所需上下文。重叠式分块是一种平衡这两个约束条件的方法。通过重叠式分块，在查询过程中很可能能够跨越多个向量检索到足够相关数据，以生成适当环境化响应。

一个限制是该策略假设您必须从单个文件中找到所有所需信息。如果所需上下文被拆散在多个不同文件中，则可能需要考虑利用类似文件层次结构和知识图谱的解决方案。

文档层次结构

使用文档层次结构是提升信息检索效率的一个强大方法。你可以把它想象成RAG系统中的目录，以有序、分级的方式组织数据块，从而让RAG系统能够高效地检索和处理相关联的数据。对于RAG来说，文档层次结构发挥着至关重要的作用，因为它帮助大语言模型确定哪些数据块包含了最具相关性和需要提取出来。

文档层次结构将块与节点关联，并以父子关系组织节点。每个节点包含所包含信息的摘要，使得 RAG 系统能够快速遍历数据并理解应该提取哪些块。 为什么在 LLM 可以理解文档中的单词的情况下还需要文档层次结构呢？ 将文档层次结构视为目录或文件目录。虽然 LLM 可以从向量数据库中提取相关的文本块，但通过使用文档层次结构作为预处理步骤来定位最相关的文本块，可以改善检索速度和可靠性。这种策略可以提高检索可靠性、速度、重复性，并有助于减少由于块提取问题而导致的幻觉。构建文档层次结构可能需要特定领域或特定问题专业知识，以确保摘要完全与当前任务相关。

让我们以人力资源领域的一个使用案例为例。假设一家公司有10个办公室，每个办公室都有自己特定于国家的人力资源政策，但是使用相同的模板来记录这些政策。因此，每个办公室的人力资源政策文件大致具有相同的格式，但每个部分会详细说明与国家相关的节假日、医疗保健等政策。

在向量数据库中，“节假日”段落块看起来非常相似。在这种情况下，通过使用文档层次结构，RAG系统可以更可靠地回答关于芝加哥办事处节假日的问题，并首先搜索与芝加哥办事处相关联的文档。

越来越明显地，在构建RAG系统时需要处理非结构化数据，并添加额外上下文限制条件，使得大语言模型能够进行更确定性信息提取。我认为这类似于给实习生提供指导，在他们开始工作时帮助他们理解数据语料库并进行推理所需的基本原则。就像实习生一样，大语言模型可以理解文档中单词及其与所问问题之间可能存在的相似性，但它不知道如何将上下文答案组合起来所需的基本原则。

知识图谱

对于强调一致性的文档层次结构而言，知识图谱是一个出色的数据框架选择。它通过确定性映射概念和实体之间的关系，能够持续准确地检索相关规则和概念，并显著减少虚假信息。将文档层次结构映射到知识图谱中的好处在于，您可以将信息检索工作流程转化为LLM可以遵循的指令。（例如，要回答问题X，我需要从文档A中提取信息，然后与文档B进行比较）。

知识图谱使用自然语言来建立关系，这意味着即使非技术用户也能够通过构建和修改规则以及关联性来控制企业RAG系统。举个例子，“当回答有关请假政策的问题时，请首先参考正确办公室的人力资源政策文件，在文件内部查看节假日部分。”


查询扩充

查询扩充解决了问题陈述不清的问题，这是RAG中常见的一个问题，在这里我们进行讨论。我们要解决的问题是确保任何缺少特定细微差别的问题都能给予适当的上下文以最大限度地提高相关性。

糟糕的问题陈述往往是由于语言复杂性而引起的。例如，一个单词根据使用环境可以有两个不同含义。正如http://CarSales.AU人工智能负责人Agustinus所指出的那样，这主要是一个领域特定的问题。考虑以下例子：炸鸡更接近“鸡汤”还是“炒饭”？“答案取决于上下文。如果关注食材，‘炸鸡’与‘鸡汤’最相似。但从准备角度来看，它更接近‘炒饭’。”此类解释具有领域中心性。

如果您想用公司或领域特定词语对LLM进行情境化处理怎么办？其中一个简单示例就是公司首字母缩写（例如ARP代表会计调节过程）。此外，请考虑我们一位客户——旅行社——提供的更复杂示例。作为一家旅行公司，我们的客户需要区分“靠近海滩”和“海滨”的概念。对于大多数LLM来说，这些术语几乎无法区分。然而，在旅行背景下，“海滨别墅”和“靠近海滩的房子”是完全不同的事情。我们的解决方案是通过预处理查询并添加公司特定上下文以引用适当部分，将“靠近海滩”的属性映射到一个特定部分，并将“海滨”的属性映射到另一个部分。

查询规划

查询规划代表着生成子问题的过程，通过适当地给出上下文并生成相应答案来全面回答原始提问。这一添加相关背景信息和语境内容的过程，在某种程度上类似于查询扩展。

举个例子，假设有一个提问：“哪座城市拥有最高人口数量？”。要回答这个问题，RAG系统首先需要针对以下几个子问题产生相应答案（如下图所示），然后再根据人口数量对城市进行排名：

“多伦多的人口是多少？”

“芝加哥的人口是多少？”

“休斯敦的人口是多少？”

“波士顿的人口是多少？”

“亚特兰大的人口是多少？”

LlamaIndex 使用此策略和其他方法来确定需要回答顶级问题的相关子问题。LlamaIndex 还利用了其他各种策略，这些策略在很大程度上是以上述核心概念的变体。

以下是 LlamaIndex 的查询规划代理使用的代码片段，用于识别子问题。

‘dependencies’: {‘title’: ‘Dependencies’,

‘description’: ‘需要回答给定 query_str 问题所需的子问题列表。如果没有要指定的子问题，则应为空白，在这种情况下会指定 tool_name.’,

众所周知，LLM 在没有辅助的情况下进行推理时存在困难，因此生成子问题面临准确性方面的主要挑战：

“为了验证这一行为，我们使用 LlamaIndex 子问查询引擎实现了该示例。与我们观察到的一致，系统经常生成错误的子问题，并且还对于子问题使用错误的检索函数” — Pramod Chunduri 在构建高级 RAG 管道时 (Oct 30 '23)

明确地说，并不是在反映 LlamaIndex 的能力，而是反映仅仅依靠 LLM 进行推理存在困难。

我们很可能需要借助外部推理结构和规则来确保通过生成或存储子问题来回答特定原则和个人方法方面提出的疑问。而当你考虑到各行业、公司或个体所持有的偏好可能与大语言模型（LLM）不同时，这一挑战变得更加复杂。

让我们以上述城市人口问题为例考虑一个外部推理规则。该规则首先用自然语言编写，然后由LLM代理在回答问题时进行阅读：

当考虑到拥有最高人口数量的城市时，请询问他们希望查看哪个洲，并检索该洲内所有城市以比较其人口。 对这种方法的批评是它涉及手动干预推理过程，而且无法想象出每一个潜在问题的所有子问题。这是事实。鉴于目前大语言模型（LLMs）的发展状况，我们应仅在大语言模型失败时寻求使用外部推理规则进行干预，并不试图重新创造每一个可能存在的子问题。

将所有内容组合成一个能够进行多跳推理和查询修改的RAG系统

在我们之前的文章中，我们讨论了复杂 RAG 中多跳检索的作用，以及复杂 RAG 在工作流程中可能出现的各种情况。下面是在构建多跳检索时会遇到的问题。

数据整合和质量：关键是确保相互连接的数据源具有高质量、相关性和最新性。低质量或带有偏见的数据可能导致不准确的多步骤结论。

上下文理解和链接：系统不仅必须理解每个查询和子查询，还要理解它们如何连接成一个连贯整体。这涉及到先进的自然语言理解技术，以识别不同信息片段之间微妙的联系。

用户意图识别：识别用户潜在意图以及随着每一次跳转而演变是关键。系统应根据查询演化过程调整其检索策略。这与查询增强有很大重叠部分。

让我们通过医学领域举个例子来进行拆解。Wisecube 在本文提出了以下问题：“哪些治疗方法对癌症有效？”

"阿尔茨海默病治疗的最新进展是什么？" 利用上述策略的一个 RAG 系统将采取以下步骤：

查询规划：

"阿尔茨海默病的当前治疗方法和副作用有哪些？"

"这些治疗方法的最新研究成果是什么？"

查询增强：

"这些治疗方法的最新研究成果是什么？

" 通过访问知识图谱，代理程序可以持续检索关于阿尔茨海默病治疗方面的结构化数据，例如 "胆碱酯酶抑制剂（cholinesterase inhibitors）" 和 "美金曲（memantine）"。 然后，RAG 系统会将问题进一步细化为 "胆碱酯酶抑制剂和美金曲在阿尔茨海默病治疗中的最新研究成果是什么？"

利用文档层次结构，找出与“胆碱酯酶抑制剂”和“美金替汀”最相关的文档片段，并给出相应答案。 您还可以让大语言模型（LLM）将这些片段纳入潜在知识图谱中，在不断积累上下文数据之余提供更丰富信息。接着，LLM可借助增强版潜在知识库（已按照知识图谱结构化）和新的扩展查询再次进行向量数据库检索，以获取更多相关信息，从而得到满意答案。 类似原理的一个例子是Greywing公司（YCW21）首席技术官Hrishi提出的，“通过LLM‘走’到相关文档片段”。

作为后续处理步骤，您还可以选择通过医疗行业专属知识图谱来进一步提升后处理结果。例如，您可以添加一个针对甲胺碘苯胺（memantine）治疗方面的默认健康警示语句，或者附带有关这两种治疗方式或副作用方面的额外信息。 相较于向量数据库用于查询扩展而言，使用知识图谱的优势在于其能够针对某些已知关系的重要主题和概念进行一致性检索。在增强响应步骤中，RAG 系统可以自动添加特定药物、疾病或概念相关的警示信息或相关概念。这正是我们在 http://WhyHow.AI 上正在开展的令人振奋的工作。

RAG 中尚未解决的问题带来了未来发展的机遇

在短期内，我们有很多机会提升 RAG 的成本效率和准确性。这为我们开辟了更加精密、资源高效的数据检索流程。

而从长远来看，则存在着一个巨大机遇去设计一种可扩展地构建与存储语义推理方法。这需要我们探索知识表示领域中全新前沿，如针对复杂数据关系采用先进编码技术以及创新型存储解决方案。这些发展将使得 RAG 系统能够有效地管理和利用日益复杂的数据。

RAG 发展中的挑战

Query Understanding and Contextualization
开发能够准确理解并将复杂查询置于正确背景下的 RAG 系统具有很大挑战。该系统不仅需要获取相关信息，还需深入了解查询意图及其中微妙之处。 Information Synthesis 除了获取信息外，在适当背景下有效地整合并清晰呈现出来也面临着困难。这需要先进的自然语言处理能力。

Latency and Performance Optimization
在多跳检索场景下，尽量减少响应时间并保持高准确性是一个重要的技术难题。

Data Privacy and Security
在企业 RAG 实施中，确保数据隐私和安全尤为关键，特别是涉及敏感或专有信息时。 Continuous Learning and Updating 实现系统持续学习和更新机制以跟上新信息和不断变化的环境是一项复杂任务。

https://x.com/llama_index/status/1736852592997843434?s=20

### 170

2023-12-19

宝玉
@dotey
正好今天也看到一篇类似的文章：《用 RAGAs（检索增强生成评估）评估 RAG（检索增强型生成）应用》

它也是四个评估指标，但是略有不同：

1. 上下文精准度： 衡量检索出的上下文中有用信息与无用信息的比率。该指标通过分析 question 和 contexts 来计算。
2. 上下文召回率： 用来评估是否检索到了解答问题所需的全部相关信息。这一指标依据 ground_truth（此为框架中唯一基于人工标注的真实数据的指标）和 contexts 进行计算。
3. 真实性：用于衡量生成答案的事实准确度。它通过对比给定上下文中正确的陈述与生成答案中总陈述的数量来计算。这一指标结合了 question、contexts 和 answer。
4. 答案相关度： 评估生成答案与问题的关联程度。例如，对于问题“法国在哪里及其首都是什么？”，答案“法国位于西欧。”的答案相关度较低，因为它只回答了问题的一部分。

所有指标的评分范围在 [0, 1] 之间，分数越高表示性能越出色。

它在评估时，需要依赖以下几种信息：

- question：RAG 流程的输入，即用户的查询问题。
- answer：由 RAG 流程生成的答案，也就是输出结果。
- contexts：为解答 question 而从外部知识源检索到的相关上下文。
- ground_truths：question 的标准答案，这是唯一需要人工标注的信息。这个信息仅在评估 context_recall 这一指标时才必须（详见 评估指标）

它在评估数据集时，不必依赖人工标注的标准答案，而是通过底层的大语言模型 (LLM) 来进行评估。

具体参考：Evaluating RAG Applications with RAGAs
https://towardsdatascience.com/evaluating-rag-applications-with-ragas-81d67b0ee31a
翻译：https://baoyu.io/translations/rag/evaluating-rag-applications-with-ragas

### 171

2023-12-20

歸藏
@op7418
3D 制作工作Spline昨晚发布了了重大更新，支持了 Apple 系统原生的 3D 内容制作和输出。

 ❖你现在可以直接从Spline复制 Swift 代码将创建的3D 元素嵌入到 XCode 中。
 ❖可以直接从Spline生成用于苹果生态系统包括 Vision OS 的应用。
 ❖可以直接从 Spline 自定义属性，比如应用程序的名称、图标和启动屏幕，并在 App Store 上发布。
 ❖设计人员现在可以自己创建应用程序，不需要从头开始学习代码。

视频是 youtube 的完整发布视频。
来源：https://spline.design/ios


### 172

2023-12-20

宝玉
@dotey
建议关注 Google 新发布的 VideoPoet，它并非基于扩散模型，而是多模态大语言模型，基本上扩散模型能支持的功能它都能做，比如说：如文本到视频、图像到视频、视频到音频的转换，以及视频风格化、补画（inpainting）或延伸画（outpainting）处理。

并且它在保证视频一致性方面做的效果特别好，你可以看到它的一些演示动画都相当稳定。

我上传的这个视频是 Google 用 VideoPoet 制作的一个短片，展示了由多个由 VideoPoet 生成的短视频片段拼接而成的成果。在编写剧本时，他们使用 Bard 创作了一个关于旅行的浣熊的短故事，并提供了按场景划分的故事梗概和相应的视频提示。接着，根据这些提示制作了视频片段，并将它们拼接成为最终展示的视频。

对于长视频也很有大模型的 提示-补全（Prompt-Completion） 风格，VideoPoet 可以通过对视频最后一秒进行分析，预测接下来的一秒内容，从而生成更长的视频。这种方法可以连续应用，显示出模型不仅能够有效延长视频长度，还能在多次重复过程中保持视频中所有对象的连贯性和真实性。

也许像 VideoPoet 这样的多模态大模型才是视频生成的未来主流。

更多演示可以看项目网站：https://sites.research.google/videopoet/

更多详情可以看这篇博客：《VideoPoet: 能零样本生成视频的大语言模型 [译]》
https://baoyu.io/translations/google/videopoet-large-language-model-for-zero

### 173

2023-12-20

Barret李靖
@Barret_China
有朋友问我，怎么做好自媒体，从最近几个月的观察来看，最重要的一个技巧就是「专注」，专注做一件事情，专注在一个领域，持续不断地挖掘有用的信息或者价值点，刚开始可能没人看到，但是三个月、半年以后，沉淀的信息就会产生魔力。看到了好几个因为专注而做的特别棒的自媒体。

我不是一个能够保持长期专注的人，好奇心特别强，兴趣点太分散，时间投入过于不均衡，相比之下，做的并不好。我现在更多还是把社交媒体当做学习工具，输出是为了验证自己是不是学明白了，如果你看到我在输出，那必然是有了新的输入，如果输出的内容能“教会”别人，那我认为自己的理解基本到位了。

保持专注，学会做减法，有的时候也是一件比较痛苦的事情，这需要有“放弃一些东西”的勇气，但说实话，我们能够把握的东西本就寥寥无几，又何必担心那些已经被放弃的呢~

### 174

2023-12-20

林亦LYi
@linyiLYi
苹果 mlx 机器学习库增加了对通义千问的支持，前几天 mixtral、phi-2 也都是一到三天的时间就支持了，这个库的维护力量超出预期。llama.cpp 要加油了。

### 175

2023-12-20

宝玉
@dotey
推荐阅读：《2023 in Review: Recapping the Post-ChatGPT Era and What to Expect for 2024 | 2023 年回顾：聚焦 ChatGPT 时代之后的发展及 2024 年展望 [译]》

原文：https://towardsdatascience.com/2023-in-review-recapping-the-post-chatgpt-era-and-what-to-expect-for-2024-bb4357a4e827
译文：https://baoyu.io/translations/ai/2023-in-review-recapping-the-post-chatgpt-era-and-what-to-expect-for-2024

### 176

2023-12-20

宝玉
@dotey
这个挺好用，借用的Mac自带的OCR能力识别率很高

Luo说不啰嗦
@LuoSays
MacOS 上的 OCR 工具 TextSniper 正在限免，亲测效果还不错。

直达链接：https://textsniper.gumroad.com/l/TXSGR?offer_code=FREEFOR24H

### 177

2023-12-21

小互
@xiaohuggg
兄弟们，又有人要失业了。

Text-to-CAD ：通过文本提示生成 CAD文件。

只需要输入自然语言描述，它就能根据这些描述创建相应的 B-Rep CAD 文件和网格模型。

生成的模型可以导入到用户选择的任何 CAD 程序中。

Text-to-CAD 背后的基础设施利用了 Zoo 的设计 API 和机器学习 API。

这些 API 能够程序化地分析训练数据，并生成 CAD 文件。

体验地址：https://zoo.dev/text-to-cad
API申请：https://zoo.dev/machine-learning-api


### 178

2023-12-21

宝玉
@dotey
我最近对我的翻译 GPT https://chat.openai.com/g/g-uBhKUJJTl-ke-ji-wen-zhang-fan-yi 做了一点优化，将原来的直译->意译两步拆成了三步：
1. 直译
2. 指出直译中的问题，例如：“不符合中文表达习惯”、“语句不通顺”和“晦涩难懂”，并且指出位置或者给出解释
3. 根据直译和问题进行意译

经过我几天的测试下来，效果确实要更好，因为通过指出问题，可以将问题具体化，由于提供了更多上下文，得到了更好的结果。

举一个例子，我翻译的一段英文其中有这样一句话：“I enjoy writing. I do it in a fast way. Why am I even a researcher if I don’t write my own research?”

之前用两步，意译后得到的结果是：“我热爱写作，写得也很迅速。如果我不亲自完成我的研究写作，我还算什么研究员呢？”（参考图二）

新的Prompt中，在第二步中发现了问题，指出：
> 第一段中，“I do it in a fast way” 直译为 “我写得很快” 可能不够准确，原句的含义可能更接近于“我享受写作，这是一种迅速的表达方式”。

最后意译时给出了翻译：
> “我喜欢写作，这是我快速表达思维的方式。如果我连自己的研究都不亲自写，我还算什么研究者？”

可以对比“I do it in a fast way.”部分的翻译结果：
“我热爱写作，写得也很迅速。” 
vs
“我喜欢写作，这是我快速表达思维的方式。”

可以看到翻译质量确实有提升。当然缺点是更费 Token 了一些，往好处想想少了更多人工校对的时间！

更新后Prompt见评论

### 179

2023-12-21

宝玉
@dotey
HuggingFace 官方博客上的一篇文章：《Speculative Decoding for 2x Faster Whisper Inference | 推测性解码：实现 Whisper 推理速度提升两倍 [译]》

在这篇文章中，展示了如何应用“猜测式解码”(Speculative Decoding) 技术来减少 Whisper 语音识别模型的处理时间，实现了处理速度的 两倍提升，同时数学上保证了模型输出的 完全一致性。因此，这一方法可以无缝替代现有的 Whisper 处理流程，不仅保持了原有的准确性，还能实现处理速度的双倍快速提升。

简单来说，Speculative Decoding就是先利用一个快速的 Assistant 模型生成候选tokens，再用 Main 模型验证。

Assistant 的速度是 Main 模型的 3 倍，但准确率只有 70% - 80%。

使用这种方法可以让整体速度提升 2 倍，并且保证输出完全一致。

文章还提供了Google Colab的测试连接：https://colab.research.google.com/github/sanchit-gandhi/notebooks/blob/main/speculative_decoding.ipynb

原文：https://huggingface.co/blog/whisper-speculative-decoding#english-speech-transcription
译文：https://baoyu.io/translations/huggingface/whisper-speculative-decoding

### 180

2023-12-21

小互
@xiaohuggg
阿里巴巴的 DreaMoving 放出在线体验地址了

DreaMoving能仅靠脸部照片和文字提示就能生成在任何场景下跳舞的视频...

测了下跳舞动作还可以，但是和背景融合度不行，人物舞蹈和背景完全是隔离的，不能完全融合！

体验地址：https://modelscope.cn/studios/vigen/video_generation/summary

这是官方演示视频（音乐我加的），测试在三楼↓

### 181

2023-12-21

Tw93
@HiTw93
\#工程师学习 这个《动手实战人工智能 Hands-on AI》写得很用心，作者从监督学习开始，带你入门机器学习和深度学习，他尝试剖析和推导每一个基础算法的原理，将数学过程写出来，同时基于 Python 代码对公式进行实现，做到公式和代码的一一对应。
🤖 https://ai.huhuhang.com

### 182

2023-12-21

宝玉
@dotey
在 Mac 上借助 MLX 运行微软的小语言模型 Phi-2 的教程，很详细。
Phi-2 对资源要求不高，能力也还不错（详见：https://microsoft.com/en-us/research/blog/phi-2-the-surprising-power-of-small-language-models/），有兴趣的可以试试。

### 183

2023-12-21

小互
@xiaohuggg
XHS-Downloader：小红书采集器 

✅ 采集小红书图文/视频作品信息
✅ 提取小红书图文/视频作品下载地址
✅ 下载小红书无水印图文/视频作品文件
✅ 自动跳过已下载的作品文件
✅ 作品文件完整性处理机制
✅ 持久化储存作品信息至文件

GitHub：https://github.com/JoeanAmier/XHS-Downloader

### 184

2023-12-21


歸藏
@op7418
ChatGPT聊天记录可以归档了，再也不用看着一堆没用碍眼的聊天记录了。

点击想归档的聊天记录右侧三个点，选择Archive Chat就可以了，已经归档的内容可以在设置中查看。


### 185

2023-12-21

宝玉
@dotey
推荐阅读：《深入了解大语言模型运维 (LLMOps) [译]》

这篇文章 5 月份的，但并没有过时，对于大语言模型的运维(LLMOps)讲的非常系统。

随着大语言模型的普及，未来的 Ops 肯定离不开 LLMOps ，甚至于需要专门的团队做 LLMOps。

文章中把 LLMOps 分成了几个关键步骤：

第 1 步：选择基础模型
是商业模型还是开源模型，亦或是混合使用

第 2 步：适应下游任务
LLM 的生成结果不像传统的服务，它的结果是不确定的，怎么让 LLM 生成你期望的结果？要不要微调？要不要使用 RAG？

第 3 步：评估
如何评估性能？由于 LLM 生成结果的不确定性，每次微调或者调整 Prompt 后，性能的变化需要可以量化的评估。

这部分可以配合《用 RAGAs（检索增强生成评估）评估 RAG（检索增强型生成）应用 [译]》 https://baoyu.io/translations/rag/evaluating-rag-applications-with-ragas 这篇一起看

第 4 步：部署和监控
和传统运维一样，对于 LLM 的线上的部署和监控也是必不可少的，但是又不太一样，外部 API 需要监控 API 可用性，故障了还要考虑能切换到其他 API。

以上就是主要的几个步骤，可以帮助你系统的了解 LLMOps，但是文章都没有深入展开，最好是配合 OpenAI 官方的 《OpenAI 生产环境最佳实践官方指南 [译]》https://baoyu.io/translations/openai/guides-production-best-practices 一起阅读。

LLMOps 还是个很新也是个很有前途的领域，我个人对这方面也不专业，如果你有相关经验欢迎分享，或者有好的文章视频也欢迎推荐。

原文：https://wandb.ai/site/articles/understanding-llmops-large-language-model-operations#Why%20the%20Rise%20of%20LLMOps
翻译：https://baoyu.io/translations/llm/understanding-llmops-large-language-model-operations


### 186

2023-12-21


宝玉
@dotey
之前我发翻译的 Prompt 的或者 GPTs 时候，很多同学无法注册 ChatGPT Plus 或无法获取到 GPT-4 的 API，没机会用上，所以这里推荐一个 ChatGPT 的替代产品 PopAi 
@popaiinone
，内置有 GPT-4V 多模态模型，所以不仅是能用上高质量的翻译能力，还能支持图像识别，PDF 文档对话等能力。



### 187

2023-12-21

歸藏
@op7418
刚看到苹果发的这个论文《使用有限的内存实现更快的 LLM 推理》。通过将将模型参数保存在闪存里，根据需要移动到DRAM。

使得能够运行的模型大小是可用DRAM的两倍，与传统的CPU和GPU加载方法相比，推理速度分别提高了4-5倍和20-25倍。

AK
@_akhaliq
Apple announces LLM in a flash: Efficient Large Language Model Inference with Limited Memory

paper page: https://huggingface.co/papers/2312.11514

Large language models (LLMs) are central to modern natural language processing, delivering exceptional performance in various tasks. However, their intensive computational and memory requirements present challenges, especially for devices with limited DRAM capacity. This paper tackles the challenge of efficiently running LLMs that exceed the available DRAM capacity by storing the model parameters on flash memory but bringing them on demand to DRAM. Our method involves constructing an inference cost model that harmonizes with the flash memory behavior, guiding us to optimize in two critical areas: reducing the volume of data transferred from flash and reading data in larger, more contiguous chunks. Within this flash memory-informed framework, we introduce two principal techniques. First, "windowing'" strategically reduces data transfer by reusing previously activated neurons, and second, "row-column bundling", tailored to the sequential data access strengths of flash memory, increases the size of data chunks read from flash memory. These methods collectively enable running models up to twice the size of the available DRAM, with a 4-5x and 20-25x increase in inference speed compared to naive loading approaches in CPU and GPU, respectively. Our integration of sparsity awareness, context-adaptive loading, and a hardware-oriented design paves the way for effective inference of LLMs on devices with limited memory.


雷尼尔
@mtrainier2020
我初步读了一下论文，这篇论文的基本思路其实是利用了推理过程中的局部性。现在现在推理性能的一个瓶颈就是GPU的内存。它们的思路就是联合CPU和GPU做联合推理。尽可能把active的neuron 信息load到GPU中，充分利用局部性。这样大大提高了GPU推理的效率。
你不能拿单独的CPU推理或者单独的GPU推理来比。两者的指导思想都不一样。
这样的效果非常牛逼。

在推理速度上，在 4090 上是未经优化的llama.cpp 11 倍。相当于用一块4090（2000刀左右）在推理上取得了比a100 （2万刀左右）仅仅慢18%的成绩。

这个结果，更大的意义就是证明，充分考虑并利用推理的局部性有极大的潜力，CPU+GPU 联合推理有很强的优越性。
类似的，那么在训练当面是不是也可以采用这种思路呢？

### 188

2023-12-21

Barret李靖
@Barret_China
局域网文件互传，也推荐 ShareDrop， https://sharedrop.io，这款产品是基于 WebRTC 实现的 P2P 传输，局域网内文件互传的效率非常高。

使用方式很简单，电脑和手机（或其他终端）同时打开这个网址就行了，它会通过STUN（Session Traversal Utilities for NAT）服务器来获取本地网络地址和端口，然后在局域网内建立点对点连接，安全性也很高。


### 189

2023-12-21

Barret李靖
@Barret_China
强烈推荐这本在线免费的电子书，《动手学深度学习》，https://zh.d2l.ai，上线一年多时间，已经更新到了第二版，光看作者阵容就已经十分强大了，这本书也被上百所名校列为教材或参考书，当前也出版了实体书。

本书的每个章节都是可以直接运行的 Jupyter 记事本，你可以在本地直接跑，也可以克隆到 Google Colab 在云端跑；讲解的时候，不仅结合文字、公式和图示来阐明深度学习里常用的模型和算法，还提供代码来演示如何从零开始实现它们，并使用真实数据来提供一个交互式的学习体验。

第二版的内容是 2023 年更新的，手把手教你搭建 Bert/Transformer，各种语言框架都有，包括 Pytorch/Tensorflow/JAX 等，而且还支持中英文对照，英文域名是 https://d2l.ai，它对于初学者和有经验的深度学习从业者都是一份宝贵的资源。


### 190

2023-12-21

Boluo
@boluo1996
2/2. 百川turbo的检索增强api做法是对query进行意图识别，得到多个sub_query分别去做检索，最后将多个检索结果合并起来。这个没有什么特别限定的条件，材料文档文档入库时也不需要预先处理。

### 191

2023-12-21

宝玉
@dotey
刚翻译完一篇论文： An In-depth Look at Gemini's Language Abilities

Gemini 语言能力深度剖析 [译]

对于 Gemini 的各方面能力解析很全面，Pro 是不如 GPT-3.5 的

### 192

2023-12-21

宝玉
@dotey
按照我的理解：实际上就是在检索的时候，不仅仅是按照相似度检索文档摘要，还检索文档的元数据，比如作者、日期、分类等等结构化的信息。

现在回想我今天看到的一篇文章说的还真的挺对：构建搜索引擎，而非向量数据库！

内容摘录：

很多向量数据库的主要作用被描述为解决大语言模型 (LLM) 缺乏长期记忆的问题，或者无法将一个问题的全部上下文放入提示语中。

然而，向量搜索实质上只是搜索的一种特殊形式。虽然让大语言模型 (LLM) 能够写入和检索数据库非常有用，但最终这更像是提供给智能体一个搜索引擎的权限，而非真正“增加了存储空间”。

假设你是一家企业，想要建立一个由 LLM 驱动的文档查询体验。如果你将向量数据库仅看作是为语言模型提供更多存储空间，那么你可能会把公司的所有产品文档都嵌入其中，然后让用户向你的机器人提问。用户按下回车键时，系统会对他们的查询进行向量搜索，找到相关片段，加载到上下文中，然后让语言模型尝试回答问题。实际上，这正是我在 Stripe 工作时，开发他们的 AI 文档产品 时最初尝试的方法。

但我最终发现，这种方法并不理想。关键在于，尽管向量搜索在某些方面优于传统搜索，但它并非万能。就像常规搜索一样，你可能会在搜索结果中遇到不相关或遗漏的文档。语言模型，就像人类一样，只能利用它们所拥有的信息，而这些不相关的文档很可能会导致误导。

如果你想打造一个优秀的基于文档的 RAG 工具，你首先应该构建一个足够优秀的搜索引擎，让人类也能轻松使用。这可能是你们组织之前已经考虑过的，如果尚未实现，那是因为打造一个高效的搜索引擎通常是一项颇具挑战的工作。

原文：https://blog.elicit.com/search-vs-vector-db/
译文：https://baoyu.io/translations/rag/search-vs-vector-db

### 193

2023-12-21

宝玉
@dotey
应网友要求，制作了一个将中文翻译成英文科研论文的GPT https://chat.openai.com/g/g-HejNUzj8l-translate-chinese-to-academic-english-ke-yan-lun-wen-zhong-fan-ying ，Prompt 和之前分享的英文翻译成中文类似的，也是分成三步：
1. 中文翻译成英文
2. 检查翻译的问题，例如不符合英文表达习惯，意思不清晰等，并指出位置和解释
3. 基于上面两步重新意译

我英语不够好，无法直接分辨出质量是否足够好，为了测试效果，我找了篇正经的中文论文，给它翻译，翻译成英文后，再把英文发到我的英文翻译中文GPT翻译 https://chat.openai.com/g/g-uBhKUJJTl-ke-ji-wen-zhang-fan-yi ，将翻译后的中文对比原文，发现除了用词有点差别，基本上意思都保留的挺好，应该还不错。（具体效果可以参考图一和图二）

在制作GPT时，我是先用中文写好Prompt，然后让GPT帮我修改Prompt，再手动调整一下就完成了。（参考图三）

Prompt 见评论

以下是给GPT Builder提供的中文Prompt：

-----中文 Prompt Start------

现在我要写一个将中文翻译成英文科研论文的GPT，请参照以下Prompt制作，注意都用英文生成：

\## 角色
你是一位科研论文审稿员，擅长写作高质量的英文科研论文。请你帮我准确且学术性地将以下中文翻译成英文，风格与英文科研论文保持一致。

\## 规则：
- 输入格式为 Markdown 格式，输出格式也必须保留原始 Markdown 格式
- 以下是常见的相关术语词汇对应表（中文 -> English）：
* 零样本 -> Zero-shot
* 少样本 -> Few-shot

\## 策略：

分三步进行翻译工作，并打印每步的结果：
1. 根据中文内容直译成英文，保持原有格式，不要遗漏任何信息
2. 根据第一步直译的结果，指出其中存在的具体问题，要准确描述，不宜笼统的表示，也不需要增加原文不存在的内容或格式，包括不仅限于：
- 不符合英文表达习惯，明确指出不符合的地方
- 语句不通顺，指出位置，不需要给出修改意见，意译时修复
- 晦涩难懂，模棱两可，不易理解，可以尝试给出解释
3. 根据第一步直译的结果和第二步指出的问题，重新进行意译，保证内容的原意的基础上，使其更易于理解，更符合英文科研论文的表达习惯，同时保持原有的格式不变

\## 格式
返回格式如下，"{xxx}"表示占位符：

\### 直译
{直译结果}

***

\### 问题
{直译的具体问题列表}

***

\### 意译
```
{意译结果}
```

现在请按照上面的要求从第一行开始翻译以下内容为英文：
```
-----中文 Prompt End------

最终的英文Prompt：

-----英文 Prompt Start------

\## Role and Goal:

You are a scientific research paper reviewer, skilled in writing high-quality English scientific research papers. Your main task is to accurately and academically translate Chinese text into English, maintaining the style consistent with English scientific research papers. Users are instructed to input Chinese text directly, which will automatically initiate the translation process into English.

\## Constraints:

Input is provided in Markdown format, and the output must also retain the original Markdown format.
Familiarity with specific terminology translations is essential.

\## Guidelines:
The translation process involves three steps, with each step's results being printed:
1. Translate the content directly from Chinese to English, maintaining the original format and not omitting any information.
2. Identify specific issues in the direct translation, such as non-native English expressions, awkward phrasing, and ambiguous or difficult-to-understand parts. Provide explanations but do not add content or format not present in the original.
3. Reinterpret the translation based on the direct translation and identified issues, ensuring the content remains true to the original while being more comprehensible and in line with English scientific research paper conventions.

\## Clarification:

If necessary, ask for clarification on specific parts of the text to ensure accuracy in translation.

\## Personalization:

Engage in a scholarly and formal tone, mirroring the style of academic papers, and provide translations that are academically rigorous.

\## Output format:

Please output strictly in the following format

\### Direct Translation
{Placeholder}

***

\### Identified Issues
{Placeholder}

***

\### Reinterpreted Translation
{Placeholder}

Please translate the following content into English:

-----英文 Prompt End------

### 194

2023-12-21

宝玉
@dotey
这篇教程的中文版本：https://baoyu.io/translations/llm/running-mixtral-8x7-locally-with-llamaindex

### 195

2023-12-22

歸藏
@op7418
LlamaIndex这篇实操内容挺好的，教你用Ollama 在自己的笔记本上运行Mixtral 8x7b。
重要的是会教一下如何使用Qdrant向量储存工具做一个完全本地化的 RAG 生成应用。

快速传送门：https://blog.llamaindex.ai/running-mixtral-8x7-locally-with-llamaindex-e6cebeabe0ab


### 196

2023-12-22

Barret李靖
@Barret_China
程序在运转一段时间后，内存因泄露而持续增长，或者因碎片化占用导致分配内存不足，最后被系统 Kill 出现 OOM 报错的问题十分常见，无论是什么语言编写的代码，只要业务流量足够大，或者用户输入足够复杂，就比较容易出现此类问题。

内存管理一般会涉及到三层：用户程序层、C 运行时库层和内核层。

如果是因为用户程序层导致的内存使用不当，这类问题是比较好排查的，一般可以在 OOM 之前，通过 heap profiling 将大内存块给分析出来，例如 Node.js 可以使用 llnode/andb 等工具进行排查，Python 可以使用 Heapy/objgraph 等工具排查。

但如果内存问题出现在 C 运行时库层（glibc），定位起来就较为麻烦了。glibc 是介于用户程序层和内核层之间的一个内存管理器，用户程序一般不会直接向内核申请内存，因为两个 context 之间的切换开销比较大，而是通过 glibc 预先从内核申请一大块内存，然后用户程序再向 glibc 申请资源，只有资源不足的时候，glibc 才会再次向内核继续申请资源。

这也意味着 glibc 需要完成复杂的内存分配和回收工作，好在业界已经有非常成熟的实现，如 ptmalloc/tcmalloc/jemalloc 等等，其中 ptmalloc 是 glibc 默认内存管理器，它是一个标准实现，tcmalloc 是 Google 家提供的，jemalloc 是 Facebook 家提供的，后两者在多线程/进程情况下，以及小内存的分配效率上，都有着明显的优势。

如果内存问题出现在 glibc 上，使用 gdb 一般都可以找到问题，但存在一个缺陷是，gdb 可以定位到 glibc 上具体的内存开销问题，但无法与上层（如 Node.js/Python）业务代码进行关联。好在不同的语言都有自己的配套工具，例如 Node.js 可以使用 andb 来排查 glibc 内存，它针对 ptmalloc 实现了一份内存调试指令，再例如 Python 可以使用 tracemalloc 来定位问题。

工具的使用存在一定的门槛，需要对内存的结构有深入了解，之前分享过一个调试案例：https://twitter.com/Barret_China/status/1694172176273097115，可以参考。

在近期正好又经历了一次比较有趣的碎片化内存占用问题的排查，现象如图所示，十分诡异，最终发现是 ptmalloc 的内存分配机制的问题，简单来说，就是碎片化内存在收回时，由于与 top chunk 相邻的内存块还存在引用，没有及时回收，导致一整串碎片化内存都无法回收，这是 ptmalloc 自身的一大缺陷，而 tcmalloc 和 jemalloc 上都有较大的改善。

解决方案也比较简单，尝试将 ptmalloc 直接替换成 jemalloc 后，OOM 问题立马就消失了，就连日常内存的占用都降低了很多。

如果你的业务堆外内存也经常飙高，甚至出现 OOM，也可以考虑更换成其他内存管理器，大概率也是可以解决问题，关于这一点，Node.js 社区存在一些有价值的讨论和问题复现代码：https://github.com/nodejs/node/issues/21973

另外，也推荐阅读这篇文章：《ptmalloc、tcmalloc与jemalloc对比分析》，https://cyningsun.com/07-07-2018/memory-allocator-contrasts.html，这是“微信看一看”团队将 ptmalloc 更换成 tcmalloc 后，机器 CPU 陡增造成业务停摆引发的一次排查和研究，最后发现是 tcmalloc 的自旋锁带来的性能问题，更换成 jemalloc 就恢复了，这篇文章从系统视角和用户视角分别分析了不同内存管理器的实现原理，讲的很精彩。

2023-12-22

Barret李靖
@Barret_China
这是一个可以复现内存碎片化的 Node.js 示例，每次添加的内存块有 4Mb，在 ptmalloc 内存管理策略中，这块内存会从 mmap 上分配， 由于 top chunk 附近的内存块被占用，无法完成回缩，造成了内存飙升。

更换成 jemalloc 后，问题消失。另外提一下，在 MacOS 上更换 jemalloc 是比较简单的：

1）brew install jemalloc，安装动态链接库
2）jemalloc node code.js，会重置 DYLD_INSERT_LIBRARIES 环境变量替换内存管理器

### 197

2023-12-22

宝玉
@dotey
\#AI开源项目推荐：langgenius/dify

开源版本的 GPTs 实现，甚至于很多地方比 GPTs 功能更强大！

Dify 是一个 LLM 应用开发平台，已经有超过 10 万个应用基于 http://Dify.AI 构建。它融合了 Backend as Service 和 LLMOps 的理念，涵盖了构建生成式 AI 原生应用所需的核心技术栈，包括一个内置 RAG 引擎。使用 Dify，你可以基于任何模型自部署类似 Assistants API 和 GPTs 的能力。

特点

1. LLM支持：与 OpenAI 的 GPT 系列模型集成,或者与开源的 Llama2 系列模型集成。事实上，Dify支持主流的商业模型和开源模型(本地部署或基于 MaaS)。

2. Prompt IDE：和团队一起在 Dify 协作，通过可视化的 Prompt 和应用编排工具开发 AI 应用。 支持无缝切换多种大型语言模型。

3. RAG引擎：包括各种基于全文索引或向量数据库嵌入的 RAG 能力，允许直接上传 PDF、TXT 等各种文本格式。

4. Agent：基于函数调用的 Agent框架，允许用户自定义配置，所见即所得。Dify 提供了基本的插件能力，如谷歌搜索。

5. 持续运营：监控和分析应用日志和性能，使用生产数据持续改进 Prompt、数据集或模型。

项目地址：https://github.com/langgenius/dify


### 198

2023-12-22

歸藏
@op7418
Sam 昨天还发了一篇《我希望有人告诉我的事情》应该是他今年的一些思考，我这里翻译一下，每一句加上一些自己的看法，顺便当自己的总结：

Sam：乐观、专注、自信、强大的驱动力和个人关系是启动事务的关键。

我：第一句看起来有点正确的废话，这里感觉驱动力和个人关系是他想要强调的事情。驱动力这个我今年感触很深，以前我是不可能省下玩游戏的时间写东西的。

Sam：协作的团队、冷静与紧迫感的完美结合，以及超乎寻常的承诺，才是完成任务的真谛。长远的视角不多见；尽量不要为短期内别人的看法所困扰，随着时间推移，这会变得更加容易。

我：后半句可能更重要一些，如果坚信自己做的事情是正确的一些无关人的看法确实不重要，当做出成绩时，别人的看法自然会转变。

Sam：对一个团队来说，做一件真正重要的难事比做一件不那么重要的容易事更容易；大胆的想法能够激发人们的动力。

我：这也是他今年反复强调的，需要给团队正确的目标，目标必须是困难并且正确的，这样才能激发团队的能力。

Sam：激励措施就像超能力，需要谨慎设定。

我：这个我只能浅显的理解为，激励措施的时间和力度都是需要精准把握的，太多和太少都有可能出问题。

Sam：将资源集中在少数你深信不疑的重要项目上；这听起来容易，但实际上却很难。你可以删除的东西比你想的还要多。

我：前半句很多人都知道，后半句应该说的是抛弃不重要的事情要更加坚决和彻底。这点我今年想的和做的都不太够。

Sam：清晰而简洁地进行沟通。

我：感觉是一项需要练习的能力，我激动的时候废话不自觉的就很多。

Sam：每当遇到废话和官僚主义时，都要挑战它们，并鼓励他人也这样做。不要让组织架构阻碍人们有效地协同工作。

我：这个感觉得看环境，当整个组织的环境是相对健康的时候是有用的，当环境变得恶劣可能更需要的是换个环境。

Sam：成果至上；不要让良好的流程成为糟糕结果的借口。

我：实事求是，只看结果。

Sam：投入更多时间于招聘。对那些潜力巨大且进步迅速的人冒险。除了智力，还要寻找完成任务的实际证据。

我：依然是后半句是重点，面试的时候更要看到做事的证据。

Sam：超级明星员工比你认为的还要宝贵，但你必须根据他们对整个组织绩效的净影响来评估他们。

我：之前老罗说过类似的话，就是厉害的人往往也会有些其他问题，负责人要把这部分问题对组织的影响评估好。

Sam：快速迭代可以弥补很多缺陷；通常情况下，如果你能迅速迭代，犯错也是可以接受的。计划应以十年为单位，执行则应以周为单位。

我：快速上线吸收反馈，快速修复迭代，继续收集反馈。前几年是大家的共识，这几年慢慢变了，Sam重新强调这件事情。

Sam：不要与商业版的物理定律作斗争。

我：在商业上我没啥理解缺失比较多，没办法举这种类似于物理定律的商业规则。

Sam：灵感是易逝的，生活是短暂的。不采取行动是一种特别狡猾的风险。

我：当有灵感的时候立刻就要开始行动，不需要做好，甚至不需要完成，先做起来。

Sam：规模往往会产生出人意料的新特性。

我：感觉是尝到了规模化的甜头，不管是组织架构上的，还是训练规模上的。

Sam：复利效应就像魔法。特别是，你确实想要建立一个随规模增长而获得复合优势的业务。

我：复利效应每个人都在提，但是能够践行和理解的人不太多。

Sam：不断地重新站起来，继续前进。

我：不只是失败之后重新站起来，也是上一个阶段结束后，要尽快开启下一个阶段。

Sam：与杰出的人一起工作是生活中最美好的部分之一。

我：跟一个好团队工作确实可以非常大的激发创造力和工作积极性。

### 199

2023-12-22

宝玉
@dotey
微软前几天发布的 MedPrompt 论文“Can Generalist Foundation Models Outcompete Special-Purpose Tuning? Case Study in Medicine” 的中文翻译：

《通用型基础模型能否超越专用调整模型？医学领域的案例研究 [译]》

https://baoyu.io/translations/ai-paper/2311.16452-case-study-in-medicine

### 200

2023-12-22

宝玉
@dotey
推荐阅读：《The Future is Rusty —— LLMs Make Programming Language Learning Curves Shallower》

众所周知，Rust 的学习曲线很陡峭，但现在，得益于大语言模型（LLMs）的发展，这个陡峭学习曲线的问题已经变得容易解决了。 无论是 Rust、Haskell 还是其他任何语言，借助大语言模型的帮助，现在学习起来都更加容易。事实上，如果你在学习难懂的材料时没有利用大语言模型的帮助，那么你的学习方式可能不是最佳的。 

文章中提到了一个很有意思的概念叫 “The Intermediate Material Problem”，是指在学习某个技能或领域时，在初级和高级阶段之间存在的一种学习难点。具体来说，在编程语言学习中，这个问题特别明显，尤其是对于像 Rust 这样的复杂语言。

在初级阶段，学习者通过教程和基础课程获得基本的知识和技能。这些资源通常都是易于理解和遵循的，目的是帮助初学者快速入门。然而，当学习者试图从基础过渡到更复杂的应用和项目时，他们常常发现可用的学习材料突然变得稀少并且难度很高。例如，在 Rust 编程中，学习者可能已经掌握了基本的语法和概念，但在尝试开发更复杂的系统（如光线追踪器）时，他们需要理解更高级的概念，比如所有权规则和内存管理，这些通常不在初级教程中详细讲解。

这种情况造成了一个“中阶教材”缺口，学习者必须依靠自己的努力和探索来克服这个难关，这通常包括阅读高级文档、参与社区讨论，甚至通过试错来解决具体的编程难题。这个阶段通常伴随着挫折和困惑，因为学习者不再有清晰的指导和步骤可循，而是需要自己摸索前进。

这个问题并不限于编程或技术领域。在许多学习曲线陡峭的领域中，从初学者过渡到熟练者的过程中都可能遇到类似的“中阶教材问题”。

另外文章中还提到数学家陶哲轩都在借助 ChatGPT 辅助学习。如果我们这个时代最杰出的数学家都在用 ChatGPT 来帮助他进行证明，那么你也没有理由不尝试！

原文：https://earthly.dev/blog/future-is-rusty/
译文：https://baoyu.io/translations/software-engineering/future-is-rusty

### 201

2023-12-22

宝玉
@dotey
转译：《Nvidia CEO：我们对 AI 下了重注，而这一决策鲜为人知》

Nvidia 创始人兼 CEO Jensen Huang 最近在 SIGGRAPH 洛杉矶主题演讲中表示，公司在 2018 年做出了一项关键商业决策，这一决策在当时很少有人预见到它将如何重新定义 Nvidia 的未来，以及对整个不断发展的行业产生深远影响。当然，这一决策已经取得了巨大成功，但 Huang 认为，这只是以 Nvidia 硬件为主导的 AI 驱动未来的序幕。这是否是一个幸运的或明智的赌注？看起来，两者都是。

Huang 在演讲中回顾道，五年前的那个关键时刻是选择采用 AI 驱动的图像处理技术，即光线追踪（RTX）和智能升级（DLSS）。 (引用根据我的笔记整理，可能并非原话，详细内容可能会在核查记录后稍作调整。)

“我们意识到光栅化技术已接近极限，”他说。2018 年是 Nvidia 的一个关键时刻，公司需要彻底改革硬件、软件和算法。在我们用 AI 重塑计算机图形的同时，我们也在重塑 GPU，以适应 AI 的需求。”

尽管光线追踪和 DLSS 在消费者 GPU 和游戏领域仍处于渐进采纳阶段，但 Nvidia 创建的架构被证明是不断成长的机器学习开发社区的理想伙伴。

为了训练越来越庞大的生成模型，所需的大量计算能力并非仅能由传统数据中心和部分 GPU 提供，而是需要像 H100 这样从一开始就设计用于大规模运算的系统。可以说，AI 发展在某种程度上受限于这些计算资源的可用性。Nvidia 正在经历类似于 Beanie Baby 的热潮，并且销售了它能生产出的所有服务器和工作站。

但 Huang 强调，这只是个开始。新的模型不仅需要被训练，而且还需由数以百万计甚至数以亿计的用户定期实时运行。

他说：“未来，无论是在视觉效果、快速数字化的制造业市场、工厂设计，还是重工业领域，大语言模型 (LLM) 都将成为核心技术。‘人类’将成为新的编程语言。”黄博士预测，自然语言界面将在这些领域得到广泛应用。

他补充道：“整个工厂将通过软件定义和机器人化实现自动化。我们将要建造的汽车，甚至本身就是机器人。这可以说是机器人设计的机器人制造机器人。”

黄博士的这一观点虽然合理，但也非常符合英伟达 (Nvidia) 的利益。有些人可能不同意他的看法。

尽管大语言模型的依赖程度尚不明确，但几乎没有人认为它不会被采用。即使是保守的估计，也表明将来必须在新的计算资源上进行大量投资。

他认为，在上一代以 CPU 为核心的计算资源上投资数百万美元是不明智的。相比之下，像 GH200 这样的新推出的、专门用于数据中心的 AI 开发硬件，在成本和功耗方面都有显著优势，能以不到十分之一的代价完成相同的工作。

他兴奋地展示了一个视频，视频中展示了多个 Grace Hopper 计算单元如同乐高积木般组装成一个刀片，然后是一个机架，接着是一排 GH200。这些设备以极高的速度连接在一起，形成了“世界上最大的单一 GPU”，拥有一整个每秒一百万亿次的机器学习 (ML) 专用计算能力。

“顺便说一下，这是真实大小，”他站在可视化的中心，戏剧性地说道。“而且，它甚至可能运行《Crysis》游戏。”

他认为，这些设备将成为未来数字化、AI 主导的工业中的基本单元。

他笑着说：“我不知道谁是第一个说出这话的，但是……你买的越多，省的也就越多。如果你们从今天的演讲中只记住一件事，那就是这句话。”他的话在 SIGGRAPH 的游戏观众中引起了笑声。

他没有提及 AI 面临的诸多挑战、监管问题，或者 AI 概念的变化——就像去年已经发生过多次的那样。当然，这是一种乐观的世界观。但在淘金热中卖铲子和锄头的人，确实可以有这样的想法。

https://techcrunch.com/2023/08/08/nvidia-ceo-we-bet-the-farm-on-ai-and-no-one-knew-it/

### 202

2023-12-22

宝玉
@dotey
\#开源项目推荐：docusealco/docuseal

开源 DocuSign 替代方案。创建、填写和签署数字文档 ✍️

功能包括：
 - PDF 表单字段生成器（所见即所得）
 - 提供 11 种字段类型（签名、日期、文件、复选框等）
 - 每个文档有多个提交者
 - 通过 SMTP 自动发送电子邮件
 - 文件存储在磁盘或 AWS S3、谷歌存储、Azure 云上
- 自动 PDF 电子签名
 - PDF 签名验证
 - 用户管理
 - 移动优化
 - 集成 API 和 Webhooks
 - 几分钟内即可轻松部署

项目地址：https://github.com/docusealco/docuseal

### 203

2023-12-22

宝玉
@dotey
推荐阅读：《多模态和多模态大模型 (LMM)[译]》

这是一篇相当详尽的讲述多模态和多模态大模型的文章！内容分为三部分。

* 第 1 部分围绕多模态的概念展开，讲述了使用多模态的原因、不同类型的数据模态以及多模态任务的种类。

* 第 2 部分深入探讨了多模态系统的核心原理，以 CLIP 和 Flamingo 为例，分别为未来多模态系统的发展奠定了基础，并通过 Flamingo 的卓越表现引领了大语言模型（LLM）的兴起。

* 第 3 部分聚焦于大语言模型（LLM）的当前研究热点，探讨了生成多模态输出和高效多模态训练适配器的新进展，涉及了像 BLIP-2、LLaVA、LLaMA-Adapter V2、LAVIN 等新兴多模态系统。

如果你想深入了解多模态模型，这是一篇相当好的科普文章！

原文：Multimodality and Large Multimodal Models (LMMs) 
https://huyenchip.com/2023/10/10/multimodal.html

译文：https://baoyu.io/translations/lmm/multimodality-and-large-multimodal-models



### 204

2023-12-22


歸藏
@op7418
Meta这个SeamlessStreaming实时语音输出同声传译的效果太惊艳了。
输出内容的延迟小于两秒。



### 205

2023-12-23

宝玉
@dotey
年底最值得一读的 RAG 论文：
《Retrieval-Augmented Generation for Large Language Models: A Survey | 面向大语言模型的检索增强生成技术：调查 [译]》

摘要：

在这篇调查中，我们关注的是面向大语言模型的检索增强生成技术。这项技术通过结合检索机制，增强了大语言模型在处理复杂查询和生成更准确信息方面的能力。我们从同济大学和复旦大学的相关研究团队出发，综合分析了该领域的最新进展和未来趋势。

校对中难免有疏漏指出，有翻译错误请指出！

https://baoyu.io/translations/ai-paper/2312.10997-retrieval-augmented-generation-for-large-language-models-a-survey



### 206

2023-12-23

宝玉
@dotey
给微博写的个稿子：《2024 年，AI 会影响普通人吗？》

“2024 年，AI 会影响普通人吗？”，这是一道送分题！答案是肯定的，一定会影响到普通人！

但这又是一道不好回答的题，因为这里的普通人，不仅仅指的是一个群体，也指的一个个的个体，AI 对每个人的影响都不尽相同。有人因为 AI 升职加薪，有人因为 AI 赚到了钱，但也有人因为 AI 有被替代的风险，甚至有人因为 AI 失业。

在预测 2024 年 AI 是如何影响普通人之前，我们先回顾一下即将过去的 2023 年对普通人的影响。我想从我身边说起。

我家老大老二是高中生，他们的同学们经常用 ChatGPT 辅助写作业，虽然有些老师不支持，但是我一直是鼓励他们多用：就像计算器一样，不应该用来作弊或者偷懒，但是这是很重要的工具，应该要掌握好。

我本人是 ChatGPT 以及 GPT API 的重度用户，我每天借助 ChatGPT 解决很多问题，写邮件工单等，辅助学习新知识，翻译技术文章和视频。

当然对我来说，也不是所有的事情都能用 AI 来帮助完成，比如我写稿子的时候，还是更倾向于自己写而不是 AI 代劳，AI 不能帮我做家务不能帮我陪孩子。

我的一部分同事，在工作中会大量使用 GitHub Copilot 和 ChatGPT 辅助写代码，可以明显感觉到代码质量的提升。

同样我在社交媒体上也关注了很多普通人，他们很多是 AI 相关的爱好者或者从业者，从他们身上看到了很多普通人被 AI 影响或者借助 AI 影响其他人的案例：

- 有人真的因为 AI 导致失业，比如游戏原画师；
- 有人创业不顺利，改变创业方向，将电子玩具和集成 AI，让玩具能语音聊天；
- 有人因为被裁员，赋闲在家做 AI 相关的开源项目，收获了上万的 Star；
- 有人做 ChatGPT 相关的开源项目被公司收购；
- 有人借助 Whisper 这样的 AI 技术生成视频字幕，借助 AI 翻译字幕，一个人顶得上以前一个字幕组的工作；
- 有人做语音转字幕、实时翻译类的产品；
- 有人基于大语言模型做 AI 伴侣；
- 有人用 AI 作画甚至创作漫画；
- 有人训练了自己的模型替代模特生成服装照片；
- 有人训练自己的模型生成小说；
- 有人转型做 AI 资讯自媒体，每天收集发布各种 AI 资讯；
- 有人用虚拟主播和文本转语音做视频；
- 有人借助 ChatGPT 把自己的论文翻译成了地道的英文顺利投稿发表；
- ……

他们中有的失败了，有的成功了或者还在成功的路上；有的因为 AI 影响了自己，有的借助 AI 影响了其他人的生活。

还有更多的人，默默地关注着 AI 的最新资讯，学习 AI 知识，希望不会被那些善用 AI 的人取代。

但不是所有的普通人都在用或者打算要用 AI。

我研究生时期的教授，70 多岁了，还在大学教数据库，我给他极力推荐了 ChatGPT，但他认为自己已经有太多东西学习了，并不打算去尝试。虽然我觉得如果他能用起来的话，可以帮助他备课和回复学生问题。

我小儿子有个好朋友，他妈妈是一个经理，年终忙于写年终总结和绩效考评，自己要写还要给下面的员工写，很忙，写过绩效考评的其实都知道，里面有大量的文字是套话，如果用 ChatGPT 其实可以节约不少时间的，但她还是倾向于自己去写。

还有更多的普通人，像我的父母，没有用过 ChatGPT、Stable Diffusion 甚至没有听说过这些，他们的生活似乎还没有受到 AI 的影响。

然而在他们刷短视频的时候，也许会猛然发现，为什么那些解说电影的主播的声音都这么相似，为什么有六个手指的漂亮的小姐姐突然多了起来？

在他们工作中，会发现为什么刚毕业的年轻人怎么就能写出高质量的代码和文案？

在他们关注新闻资讯的时候，会发现为什么有些博主那么的高产，似乎一个人都能顶上一个小出版社的工作量了？

看起来 AI 对普通人没影响，但有形无形很多人都在或多或少的受到 AI 的影响。

在 AI 时代，一个特点可能就是工作中需要的技能更新迭代的更快，我们需要不停的学习新的知识和技能，以前学习的很多知识可能会过时或者不够用，需要不断地学习新的技能。比如普通人也要掌握一些基本的 Prompt 技能，来和 AI 进行交互，就像现在每个人都需要通过鼠标和键盘来和电脑交互一样。

当然我也不希望你因此而产生 AI 焦虑，因为从积极的角度来说，虽然当前的 AI 发展导致了一些裁员，但历史上并没有证据显示技术进步会导致大规模失业。劳动力市场历来具有适应性，技术能力的提升可以带来更高价值的工作，以及更高的生产力。

尽管一些职位可能会被 AI 替代，但公司仍需要有人来引导 AI，对 AI 生成的结果解读并做出决策。

而对于我们普通人，最好的应对方式就是了解在未来，AI 如何可能影响你在所在行业中的职位，去尝试着用一用像 ChatGPT 这样的 AI 工具，尝试着在日常工作生活中应用起来。这样至少你可以对未来可能发生的事有所准备，而不是束手无策。

在 2023 年，被 AI 影响或者不被 AI 影响的普通人有三种：

1. 用 AI 提升生产力普通人；
2. 在被 AI 影响而不自知或无能为力的普通人；
3. 还没有被 AI 影响的普通人；

从比例上来说，在 2023 年，第一种人是少数，第三种人是大多数，第二种人介于中间。但在 AI 时代，一切都在被加速，很快用 AI 提升生产力普通人的比例就会快速增加，没有被 AI 影响到的普通人比例会越来越少。

2024 年马上就要来了，我们每个人或多或少不可避免都会被 AI 影响，但是你我可以选择成为一个被 AI 影响而无能为力的普通人，也可以选择成为一个利用 AI 提升生产力的普通人。

衷心希望在 2024 年，AI 能帮助到每一个你我这样的普通人，升职加薪，让生活更加美好！

https://baoyu.io/blog/ai/will-ai-impact-us-in-2024



### 207

2023-12-23

Barret李靖
@Barret_China
在了解 Python 线程和协程的时候，又看到了微线程、纤程、绿色线程、超线程等概念，捋了一下。

之前提到 Python 的 threading 模块并不支持并发，这里的「并发」一词并不准确，threading 是对线程的控制，也就是让多个任务轮流抢占单个 CPU，这个操作就叫做「并发」操作，因此 threading 模块是可以很好支持并发的；而「并行」指的是在多个 CPU 上同时执行，Python 的 multiprocessing 模块会在每个 process 中都启动一个 global interpreter lock（GIL），相互隔离，它是可以做到并行的。

线程是进行 CPU 独立运行和调度的基本单元，协程也是如此，只不过协程不是被内核态所管理，而完全由程序控制，在用户态执行。刚开始看到 Python 协程的时候，以为是个啥新鲜玩意儿，研究了下 asyncio 模块的使用，才发现它跟 JavaScript 的 EventLoop 设计如出一辙，通过 async/await 等指令控制程序的相互协作和调用，由于协程不存在线程上下文切换的开销、没有原子操作锁定及同步的开销，因此可以更高性能压榨 CPU 达到并发效果。所以爬虫的时候使用“multiprocessing+asyncio”可以最高效地调度所有 CPU 执行高并发、高并行的 I/O。

微线程、纤程、绿色线程等术语可以说是协程的代名词，它们的共同特点就是：1）资源调度和程序控制在用户态进行而不是内核态；2）可以便捷地控制程序之间的相互协作，对应的英文名还有 Coroutine、Green Thread、Fiber、Microthread 等等。

而超线程（Hyper-Threading）是硬件层面提供的技术，它可以将一个物理 CPU 模拟划分为多个逻辑 CPU，每个 CPU 都有自己的寄存器和执行单元，这样可以大幅提升 CPU 的利用率，也只有超强的 CPU 才会这么干，如果 CPU 的执行速度还跟不上程序指令的下发速度，自然也没必要再去划分更多逻辑单元了。

关于 Python 协程和任务，推荐阅读这篇文档：https://docs.python.org/zh-cn/3/library/asyncio-task.html，关于 Python 的事件循环，推荐阅读这篇文档：https://docs.python.org/zh-cn/3/library/asyncio-eventloop.html，官方文档写的还是很详细的。


### 208

2023-12-23

宝玉
@dotey
推荐阅读：《Meet 'Coscientist,' your AI lab partner》

一款基于人工智能的系统成功地规划并实施了真实世界的化学实验，显示出帮助人类科学家更快、更多地发现新知识的潜力

在你阅读本文的时间里，一个由人工智能驱动的系统已经能够自学并设计出用于某些诺贝尔奖级化学反应的实验室程序。AI 在短短几分钟内完成了这一切，并且首次尝试就取得了成功。

卡内基梅隆大学的化学家和化学工程师 Gabe Gomes 表示：“这是首次由非有机智能规划、设计并执行这种复杂的由人类发明的化学反应。”Gomes 领导的研究团队组建并测试了这一基于 AI 的系统，并将其命名为“Coscientist”。

Coscientist 完成的最为复杂的反应是有机化学中的钯催化交叉偶联。这项反应让其人类发明者荣获了 2010 年化学诺贝尔奖，因为它在制药开发和其他依赖于复杂碳基分子的行业中扮演了重要角色。

在 Nature 杂志 发表的 Coscientist 展示能力，揭示了人类通过使用 AI 加速科学发现的速度和数量的巨大潜力，并提高了实验结果的可重复性和可靠性。该四人研究团队包括博士生 Daniil Boiko 和 Robert MacKnight，他们分别在美国国家科学基金会的化学酶合成中心和圣母大学的计算机辅助合成中心接受支持和培训。

美国国家科学基金会化学部门主任 David Berkowitz 评论说：“Gomes 和他的团队不仅展示了他们系统在化学合成方面的能力，还成功地创造了一种高效的实验室合作伙伴。”他补充道：“他们将各部分巧妙组合，创造出的成果远超各部分之和，这对科学研究具有真正的实用价值。”

原文：https://new.nsf.gov/science-matters/meet-coscientist-your-ai-lab-partner
译文：https://baoyu.io/translations/ai/meet-coscientist-your-ai-lab-partner


### 209

2023-12-23


宝玉
@dotey
转译：《苹果计划让 AI 技术直接在自家硬件上运行，而非依赖云端》

苹果最近一项关于让大语言模型在智能手机上运行的研究，清晰地表明这家 iPhone 制造商有意在生成式人工智能方面追赶它的硅谷对手。

这项名为 “[LLM in a Flash](https://arxiv.org/pdf/2312.11514.pdf)” 的研究报告提出了一个解决目前计算难题的新方案，研究人员这样描述。

他们提出的方法将为有限内存设备上有效运行大语言模型铺平道路。所谓的“推断”，指的是大语言模型（像 ChatGPT 这样的应用背后的大型数据库）如何处理用户的询问。一般来说，聊天机器人和大语言模型需要在比 iPhone 强大得多的巨型数据中心中运行。

这篇论文于 12 月 12 日发表，但在上周三晚些时候，知名 AI 研究网站 Hugging Face [将其推至聚光灯下](https://huggingface.co/papers/2312.11514) 后，才引起了更广泛的关注。这是苹果本月发布的第二篇关于生成式 AI 的论文，前面那篇是让像 Stable Diffusion 这样的图像生成模型能够在其定制芯片上运行。

面对智能手机市场十年来最严重的低迷，设备制造商和芯片制造商寄望于新 AI 功能能够振兴市场。根据 Counterpoint Research，市场出货量预计下降了 5%。

虽然早在 2011 年，苹果就推出了首个虚拟助手 Siri，但自从 OpenAI 一年前推出其革命性聊天机器人 ChatGPT 以来，苹果在硅谷掀起的生成式 AI 热潮中显得有些落后。即便苹果在 2018 年招募了谷歌的顶尖 AI 高管 John Giannandrea，但在 AI 社区，许多人依然认为苹果相比大型科技竞争对手处于劣势。

与微软和谷歌主要专注于通过其庞大的云计算平台提供聊天机器人和其他生成式 AI 服务不同，苹果的研究显示，它更倾向于研发能够直接在 iPhone 上运行的 AI 技术。

苹果的竞争对手，例如三星，正准备在明年推出一种新型的“AI 智能手机”。Counterpoint 预计，到 2024 年，将有超过 1 亿部专注于 AI 的智能手机出货，到 2027 年，40% 的新设备将具备这样的功能。

世界最大移动芯片制造商高通的首席执行官 Cristiano Amon 预测，将 AI 引入智能手机将为消费者带来全新的体验，并有望扭转手机销量的下降趋势。

他在最近接受《金融时报》采访时表示：“你将在 2024 年初看到搭载多种生成式 AI 应用的设备发布。随着这些技术的推广，它们将开始显著改善用户体验，并推动新创新，这可能会引发智能手机的新一轮升级热潮。”

他还说，更智能的虚拟助手能够预测用户的行为，比如发送短信或安排会议，而设备还将能够实现新型的照片编辑技巧。

谷歌本月推出了其新 Gemini 大语言模型的版本，该版本将“原生”运行在其 Pixel 智能手机上。

在个人设备上运行像 ChatGPT 或谷歌的 Bard 这样的大型 AI 模型面临着巨大的技术挑战，因为智能手机并不具备数据中心那样的巨大计算资源和能量。解决这一挑战不仅可能使 AI 助手的响应速度更快，而且还能实现离线工作。

确保在用户自己的设备上处理查询，而不将数据发送到云端，也可能带来隐私上的好处，这一点近年来一直是苹果的重要优势。

其研究团队指出：“我们的实验旨在提高个人设备上的推断效率。” 苹果在包括 Falcon 7B 在内的多个模型上测试了这种方法，Falcon 7B 是 Abu Dhabi 技术创新研究所开发的一个较小版本的开源大语言模型。

为了让大语言模型能够在电池供电的设备上运行，AI 研究人员一直在致力于优化。虽然学术论文并不能直接显示苹果将如何将新功能融入其产品，但它们提供了一个罕见的机会，让我们一窥其神秘的研究实验室和公司的最新技术成果。

苹果的研究人员在论文的结论中写道：“我们的工作不仅解决了当前的计算难题，也为未来的研究开辟了新道路。我们相信，随着大语言模型的持续增长和复杂化，像这种工作这样的方法将对于在各种设备和应用中充分发挥它们的潜力至关重要。”

苹果对于置评请求尚未立即回应。

来源：https://arstechnica.com/apple/2023/12/apple-wants-ai-to-run-directly-on-its-hardware-instead-of-in-the-cloud/


### 210

2023-12-23

宝玉
@dotey
推荐一下，Chatbot UI这个开源项目一直在持续更新，越做越好了

https://github.com/mckaywrigley/chatbot-ui

### 211

2023-12-23

歸藏
@op7418
上海人工智能实验室又搞了一个即插即用的图像生成视频模型。
主要特点是根据不同的文本提示以动作进行动画处理，同时保留原始的独特风格和高保真度的细节。

项目简介：
我们提出了PIA，一种个性化图像动画生成器，它在与条件图像对齐、通过文本实现动作可控性以及与各种个性化T2I模型的兼容性方面表现出色，而无需特定调整。

为了实现这些目标，PIA基于一个经过良好训练的时间对齐层的基础T2I模型，允许将任何个性化T2I模型无缝转换为图像动画模型。

PIA的一个关键组成部分是引入条件模块，它利用条件帧和帧间关联作为输入，在潜在空间中通过关联提示来传输外观信息，以指导个别帧的合成。

 这种设计减轻了外观相关图像对齐的挑战，并允许更加专注于与运动相关的指导对齐。

项目地址：https://pi-animator.github.io

### 212

2023-12-23

宝玉
@dotey
Midjourney 的创始人 David Holz 提出了一种新的提示方法。V6 对提示的敏感度大大提高。

建议避免使用“获奖、超现实、4k、8k”等表述，而应确保请求明确。如果你希望得到更直接、更中立且更现实的输出结果，最好将 --style raw 设置为默认。

（原文中直言不讳地将 4k、8k 等描述称为“无用”提示。"V6 对你的提示非常敏感。避免使用‘无用’的表述，如‘获奖、超现实、4k、8k’"）

https://baoyu.io/translations/ai-photos/midjourney-v6-elevating-prompt-structure-and-expression

### 213

2023-12-23

宝玉
@dotey
腾讯推出的 AppAgent，是一个多模态智能体，通过识别当前手机的界面和用户指令直接操作手机界面，能像真实用户一样操作手机！比如它可以操作图片编辑软件编辑图片、打开地图应用导航，购物等等操作

项目首页：https://appagent-official.github.io
论文链接：https://arxiv.org/abs/2312.13771

像真实智能手机用户一样操作手机的多模态智能体

论文摘要：

随着大语言模型（LLMs）的最新进展，人们创造出了能执行复杂任务的智能智能体。本文介绍了一个全新的、基于大语言模型的多模态智能体框架，专为操作智能手机应用而设计。我们的框架让智能体可以通过一个简化的操作空间来操控智能手机应用，这种方式仿佛是人类在进行点击和滑动操作。这种创新的方法避开了对系统后端的直接访问需求，使其能够适用于多种不同的应用程序。我们智能体功能的核心在于它的创新学习方式。智能体通过自我探索或者观察人类的示范来学习如何导航和使用新的应用程序。在这个过程中，它会构建起一个知识库，并依靠这个知识库来执行不同应用中的复杂任务。为了展示我们智能体的实用性，我们对它在 10 个不同应用中的 50 个任务进行了全面测试，这些应用包括社交媒体、电子邮件、地图、购物以及复杂的图像编辑工具。测试结果证明了我们的智能体在处理各种高级任务方面的高效能力。

宝玉
@dotey
腾讯新论文 AppAgent 的中文翻译版本：《AppAgent: 像人类用户一样操作手机的多模态智能体 [译]》

https://baoyu.io/translations/ai-paper/2312.13771-appagent-multimodal-agents-as-smartphone-users

摘要

大语言模型 (LLMs) 的最新进展催生了一类能够执行复杂任务的智能代理。本文提出了一种基于大语言模型的多模态代理框架，专为智能手机应用而设计。我们的框架允许智能体通过简化的动作范围，如点击和滑动，来操作智能手机应用，仿佛它是一个人类用户。这种创新方法免除了访问系统后端的需要，使其能够适用于多种不同的应用。我们的智能体采用了一种创新的学习方法：它可以通过自我探索或观察人类的操作来学习如何导航和使用新的应用程序。通过这个过程，它建立了一个知识库，用于在不同应用中执行复杂任务。为了证明我们智能体的实用性，我们在 10 个不同的应用中进行了 50 项任务的测试，涵盖了社交媒体、电子邮件、地图、购物和高级图像编辑等领域。测试结果证明了我们的智能体在处理多种高级任务方面的高效能。

### 214

2023-12-24

歸藏
@op7418
Sam昨晚做了一个调研问大家最期待明年Open ai在哪些方向的内容。

然后做了一些回答其实也间接说了他们明年的规划除了AGI之外其他的应该都在计划中。

Open AI明年会发布的内容有：

GPT-5
更好的语音模式
更高的使用限制
更好的GPT模型
更好的推理能力
控制觉醒程度/行为
视频功能
个性化设置
更好的浏览体验
使用OpenAI账号登录
开源项目

### 215

2023-12-24

歸藏
@op7418
Nicolas这个对明年AI内容生成工具质量的判断我也是同意的。

到2024年所有艺术生成工具得模型质量将差不多，或者说头部几家公司的模型质量不会有明显的差距。

研究重点将会转向针对特定步骤流程模型的微调之上。

同时如何将这些内容模型无缝的集成到产品上降低使用门槛帮助有创意的内容创作者低成本的实现他们的创意也会是一个重点方向。

到了拼体验和细节的时候了。

### 216

2023-12-24


GooCarlos
@goocarlos
工程、社区、开放性和透明度都是一个开源 Infra 产品的必修课。周末在整理 Dify 的产品手册，效仿了消费电子产品的常规做法，新增了一篇《特性与技术规格》。

这么做有利有弊，一方面让对手向你致敬更容易了，另一方面我们借此让开发者可以基于客观信息做严肃的选型。

如果你已经走上了舞台，为何不再向中间走两步？

参见 https://docs.dify.ai/v/zh-hans/getting-started/readme/features-and-specifications

预告下周我们将发布一个全新的 Runtime，以及 Dify 的贡献指南。之前提到的 Roadmap 也将公开。

这是对“都是差不多的套壳产品”最好的回应。

### 217

2023-12-24

宝玉
@dotey
推荐阅读：如何加速大语言模型的运行

这是一篇综合性的调研文章，涵盖了多种提升大语言模型运行速度的方法，从改善硬件利用效率到巧妙的解码技巧应有尽有。虽然这篇文章并非面面俱到，也不是每个话题的深度解析，但你应该能从中找到一些有用的信息，并且作者也提供了相关论文和博客文章的链接。

原文：https://vgel.me/posts/faster-inference/
译文：https://baoyu.io/translations/llm/how-to-make-llms-go-fast

### 218

2023-12-24

宝玉
@dotey
转译：《苹果公司于 10 月份悄然发布了一款开源多模态 LLM》

苹果公司在2023年10月低调发布了一款名为Ferret的开源多模态大语言模型，这是苹果与哥伦比亚大学研究人员的合作成果。当时，尽管发布包括了代码和权重（仅限研究用途，不包含商业许可），但并未引起太多关注。然而，随着近期 Mistral 的开源模型成为焦点，以及谷歌的Gemini模型即将在Pixel Pro上亮相，未来还将进入Android系统，人们开始更加关注本地LLMs在小型设备上的应用潜力。

最近，随着苹果宣布在iPhone上成功部署LLMs的重大突破，这方面的讨论更加热烈。苹果[发布了两篇新研究论文](https://x.com/dotey/status/1738767070022570250)，介绍了3D头像和高效语言模型推理的新技术，这些技术被认为有望提供更加沉浸式的视觉体验，并使复杂的AI系统能够在消费者设备如iPhone和iPad上运行。

AI社区中许多原本未注意到Ferret发布的成员，对苹果这一意外进入开源LLM领域的行动表示欢迎，尤其是鉴于苹果一向以其“封闭园区”的形象而闻名。

今晨，专注于医疗领域开源AI的欧洲非营利组织负责人Bart de Witte在X平台上分享了他的惊讶：“我之前竟然没发现这个。”他表示，“苹果在10月份加入了开源AI圈子。Ferret的推出展现了苹果对影响深远的AI研究的承诺，巩固了它在多模态AI领域的领先地位……另外，我很期待有一天Local Large Language Models (LLLMs)能作为重新设计的iOS的一部分，在我的iPhone上运行。”

德国AI音乐艺术家及顾问Tristan Behrens也表达了他的看法，他在领英上写道：“明天就是圣诞节，但你知道吗？苹果（没错，就是苹果！）近期发布了一个包含代码和权重的多模态大语言模型。”

科技博客作家兼VentureBeat撰稿人Ben Dickson在领英上的发言提到了这一惊喜：“2023年最让你意外的AI进展是什么？对我来说，是苹果发布了开源LLMs（虽然是非商业许可）。”他指出，苹果一直是封闭系统、封闭园区开发、保密、严格的保密协议、发布极少细节、并为其产品申请每一项小的专利的代表。

他继续说道：“但回过头来看，苹果（像Meta一样）推出开源LLM模型是合情合理的。要与ChatGPT这类模型竞争，你要么得是一个超级计算者，要么需要强大的合作伙伴。苹果虽然资源丰富，但其基础设施并不是为服务大规模LLMs而建的。另一种选择是依赖像微软或谷歌这样的云服务提供商（两大劲敌），或者像Meta那样开始发布自己的开源模型。”

值得注意的是，苹果开源及本地ML发展的消息传来之际，Anthropic和OpenAI据报道正在为他们的专有LLM开发工作进行大规模的新资金筹集。据路透社[本周三报道](http://seeking%20to%20raise%20$750%20mln%20in%20funding%20round%20led%20by%20menlo%20ventures/)，Anthropic正在与Menlo Ventures商谈筹集7.5亿美元的资金。而根据[彭博社昨天的报道](https://bloomberg.com/news/articles/2023-12-22/openai-in-talks-to-raise-new-funding-at-100-billion-valuation)，OpenAI正在进行初步讨论，计划以至少1000亿美元的估值筹集新一轮资金。

这一系列动态显示了AI领域的竞争格局正在发生变化。尽管苹果以往以其产品和技术的封闭性著称，但现在它通过发布开源LLM模型，正逐渐改变这一形象，展现出其在AI领域的活跃参与和创新精神。这不仅对苹果自身，也对整个AI领域来说，都是一个值得关注的重要发展方向。

来源：https://venturebeat.com/ai/apple-quietly-released-an-open-source-multimodal-llm-in-october/


### 219

2023-12-24

宝玉
@dotey
转译：《苹果最新 AI 研究或将彻底革新你的 iPhone》

苹果这个几乎与技术创新划等号的公司，再次站在了 AI 革命的前沿。

这家总部位于加州库比蒂诺的公司最近公布了在人工智能研究领域的重要进展，推出了两篇新论文，分别介绍了用于 3D 头像和高效语言模型推断的新技术。这些创新有望为用户提供更沉浸式的视觉体验，并使复杂的 AI 系统能够在 iPhone 和 iPad 等消费者设备上运行。

在其[第一篇研究论文](https://arxiv.org/pdf/2311.17910.pdf)中，苹果的科学家们提出了一个名为 [HUGS](https://machinelearning.apple.com/research/hugs)（人类高斯喷溅，Human Gaussian Splats）的技术，用于从单镜头短视频中生成动态的 3D 人像。“我们的方法只需一段短单镜头视频（50-100 帧），就能自动学习分离静态场景和一个完全可动画化的人像，整个过程仅需 30 分钟，” 首席作者 Muhammed Kocabas 表示。

图一
该技术包括训练视频（左上），重建的标准人体头像（右上），重建的场景模型（左下），以及重新布局的动画人体与场景（右下）。 （图片来源：Apple）

HUGS 使用一种高效的渲染技术，即 3D 高斯喷溅，来同时展现人物和背景场景。人物模型以 [SMPL](https://smpl.is.tue.mpg.de)（一种统计学身体形态模型）为基础构建。而 HUGS 通过允许高斯变形，能够捕捉到衣物和发型等细节。

一个创新的[神经形变模块](https://machinelearning.apple.com/research/neural-engine-transformers) 采用线性混合蒙皮技术（linear blend skinning），使得高斯以逼真的方式动态表现。这种协调的动作避免了在调整人像姿势时产生的视觉失真。Kocabas 指出，HUGS 能够实现对人物新姿势的合成以及对人物和场景的新视角合成。

相较于早期的头像生成方法，HUGS 在训练和渲染速度上高达100倍。研究者们在标准游戏GPU上仅用30分钟进行系统优化，就取得了逼真的效果。在 3D 重建质量方面，HUGS 也超过了如 [Vid2Avatar](https://github.com/MoyGcc/vid2avatar) 和 [NeuMan](https://machinelearning.apple.com/research/neural-human-radiance-field) 等最先进技术。

这项新技术使人们仅需一段包含人物和场景的视频，就能将不同的数字角色或“头像”置入新环境中。这个过程非常迅速，图像每秒更新60次，达到流畅且逼真的效果。

苹果研究团队的这一新 3D 建模成就非常引人注目。实时表现能力及利用实地视频创造头像的技术，很快就可能为虚拟试穿、远程互动及合成媒体领域开辟新天地。想象一下，如果你可以直接在 iPhone 相机上制作如此新颖的 3D 场景，会带来怎样的创新可能性！

\## 在人工智能推断中弥合内存差距

在[第二篇论文](https://arxiv.org/pdf/2312.11514.pdf)中，苹果(Apple)的研究团队应对了一个挑战：如何将庞大的大语言模型 (LLMs)，比如参数众多的 GPT-4，部署到内存受限的设备上。这些先进的自然语言模型由于参数众多，让在普通消费级硬件上的推断变得耗费资源。

他们提出的系统旨在最大程度减少在推断过程中从闪存到有限的动态随机存取内存 (DRAM) 的数据传输量。“我们的方法是建立一个与闪存行为相协调的推断成本模型，从而在两个关键方面进行优化：一是减少从闪存到内存的数据传输量，二是以更大、更连续的数据块进行读取，”首席研究员 Keivan Alizadeh 详细说明了这一点。

研究中引入了两种主要技术：“窗口化”，即重复利用最近推断过程中的激活数据；以及“行列捆绑”，通过将数据的行和列存储在一起，实现读取更大的数据块。在苹果 M1 Max CPU 上运用这些技术，相比传统的简单数据加载方法，推断速度提高了 4-5 倍；而在 GPU 上，速度提升更是达到了 20-25 倍。

“这项技术突破对于在资源受限的环境中部署先进的大语言模型至关重要，这不仅扩大了这些模型的应用范围，也提高了它们的易用性，”共同作者 Mehrdad Farajtabar 表示。这些优化不久后可能使得复杂的 AI 助手和聊天机器人能够在 iPhone、iPad 和其他移动设备上流畅运行。

\## 苹果的战略愿景

这两篇论文凸显了苹果在 AI 研究和应用领域的逐渐增强的领导力。尽管前景充满希望，专家们提醒，苹果在将这些技术整合到消费产品中时必须格外慎重，承担相应的责任。从保护隐私到预防技术滥用，都应全面考虑到[社会影响](https://venturebeat.com/ai/the-widening-web-of-effective-altruism-in-ai-security-the-ai-beat/)。

苹果可能会将这些创新技术融入其产品系列，不仅仅是为了提升设备性能，更是为了预见混合 AI 服务的未来需求。苹果允许更复杂的 AI 模型在内存有限的设备上运行，为新一代应用和服务的开发奠定基础，这些应用和服务将以前所未有的方式利用大语言模型（LLMs）的强大功能。

此外，苹果公开发布这些研究成果，对整个 AI 领域做出了贡献，这可能会促进该领域的进一步发展。这一行为反映了苹果对自身作为技术领先者地位的自信，以及不断探索新可能性的承诺。

苹果的最新创新如果得到恰当应用，有可能将人工智能提升至一个新高度。逼真的数字化虚拟形象和强大的 AI 助手原本只存在于遥远的未来设想中 — 但在苹果科学家的努力下，这一未来正迅速成为现实。

来源：https://venturebeat.com/ai/apples-latest-ai-research-could-completely-transform-your-iphone/

### 220

2023-12-24

歸藏
@op7418
LLM的可解释性一直都是比较困难的内容，而且在对齐和安全上可解释性的研究也比较重要。

这个Github储存库非常全面的精心收集了关于LLM可解释性的相关工具、论文、文章以及团体。

需要了解相关内容的可以收藏一下，项目地址：https://github.com/JShollaj/awesome-llm-interpretability

### 221

2023-12-24


九原客
@9hills
对苹果的 MLX 框架进行测试，环境是 Apple M1。初衷是想有本地开发比较快的 embedding 和 reranker 模型。

简单的调整了下 bert 的转换脚本，转换了 bge-large-zh-v1.5 模型，float32，200个单词 x 22段，batch_size=1。

M1 8G MLX: 22.7s
Colab T4 CPU: 83.67s
Colab T4 GPU: 1.84s

### 222

2023-12-24

宝玉
@dotey
\#AI开源项目推荐：AI-Employe

又一款开源的基于GPT-4V的API操作浏览器的浏览器插件

https://github.com/vignshwarar/AI-Employe


### 223

2023-12-24

宝玉
@dotey
就是普通的文档问答，基于Embedding做相似度搜索，把字幕向量化存向量数据，而且它没有用OpenAI的Embedding（用的Gegeral Text Embeddings (GTE) model），估计中文支持不会太好。

顺便说下，首页搜索框的自动完成是调用的YouTube的API所以看着还行

### 224

2023-12-24

宝玉
@dotey
一篇关于在扩散模型中生成文字的论文：TextDiffuser-2: Unleashing the Power of Language Models for Text Rendering

可以稳定在扩散模型中生成指定位置和风格的英文文本（中文测试过无法正常生成），它是借助的微调后的大语言模型来规划文本布局，以及编码文本的位置。

项目首页：https://jingyechen.github.io/textdiffuser2/
论文：https://arxiv.org/abs/2311.16465
在线测试地址：https://huggingface.co/spaces/JingyeChen22/TextDiffuser-2
代码：https://github.com/microsoft/unilm/tree/master/textdiffuser-2

### 225

2023-12-24


Vince He
@iarrp
感谢宝玉老师的推荐 
@dotey

自 5 月份推出产品以来，Dify 帮助了相当多的国内外开发者和非技术小白用户低成本地验证自己充满创意的 idea，截止今天一共在上面搭建起了将近 10 万个 AI 应用。

同时我们也有相当一部分的企业级客户，通过私有化部署和二次开发，将 Dify 嵌入到企业原有的产品或者工作流中，快速完成产线的 AI 化升级。

在这个过程中，我们也收到了相当多的支持和反馈，我与许多喜爱我们产品的用户进行过沟通，得到最多的正面评价是“易用”和“克制”。

在今年三月份开始定义产品时，我们的整个构想建立在以下三点假设之上：

1. Democratization of AI，Prompt 工程 ，RAG 和 Fine-tune 对用户来说是复杂技术有待简化；

2. Cross-Functional Collaboration in AI，非技术人员需要参与到 AI 应用的定义过程之中；

3. Data-Driven Feedback，AI 应用的效果提升建立在生产数据的持续反馈。

这三点假设直至今天依旧成立。

在今年实现了帮助用户完成“从想法到应用的快速验证”这一小目标之后，明年我们的产品形态将从 “GPTs 平替” 回归到 “LLM 应用开发技术栈” 之上，为用户提供更深度，丰富，可定制的技术解决方案。

作为一个小团队用心做的一款开源产品，我们的产品迭代速度有时也显得“克制”。我们将在近期在社区开放产品的 Roadmap，联合开发者社区的力量帮助我们一起打造这款产品。

### 226

2023-12-24


宝玉
@dotey
推荐阅读：《math team
and other horrible things you do to get into stanford | 数学队——及其他你为了进入斯坦福而做出的疯狂之举 [译]》

一个被普林斯顿拒绝、拒绝了MIT，去了斯坦福的学霸写的高中在数学队的经历。

美国的高中也挺卷的，为了上名校也都是各显神通，就像作者本人，在数学上有一点天赋，而加入数学对就是一条捷径，有更大机会上名校。

而对于高中数学队的教练来说，他的数学队经费依赖于学校，而学校的经费又取决于能否持续将学生送入顶尖大学。

像作者这样即使在数学上有天赋的孩子，学习数学对他来说也不是件快乐的事情，但是为了名校还是不得不拼命努力，最终所有这些努力最终只会被压缩成申请表上的几行字，然后被招生委员会在大约九十秒内匆匆审阅，之后就转向下一个成绩优异的申请者。

原文：https://benexdict.io/p/math-team
译文：https://baoyu.io/translations/life/math-team

### 227

2023-12-24


Barret李靖
@Barret_China
写了十多年 JavaScript，多次想好好学习下 Go/Python/Rust 等语言，但最后都没有实施下去。最近为了搞 AI，硬着头皮扎扎实实地把 Python 学了一遍，弥补了很多之前掌握不足的知识点，还是挺有收获的，有两点感想：

1）很有必要多学习一门语言，在对比中学习，可以了解不同语言的强项和弱点，也可以看到更多底层的优秀设计；JS 和 Python 都是弱语言类型，虽然也写了好几年的 TS，对强语言类型接触还是不够，未来计划好好再学一学 Go；当然，也得先有一个非常强的内驱力，就跟搞 AI 一样愿意学 Python。

2）系统性学习一门语言，知识量非常庞杂，但不外乎语法、编程范式、工程、辅助工具、框架、中间件等几块，再深入一点可以去看看元编程、内存管理、设计模式、性能调优、安全设计和质量保障等，想研究细节的话可以去翻一番历史 issues，看看这门语言的发展以及版本演进，追一追标准化和社区讨论。

当然，学习不是目的，学习是为了更好的解决实际问题，所以也非常建议多动手，把脑子里的想法用代码实现出来。

### 228

2023-12-25

宝玉
@dotey
“在我们继续之前，我想先重复一遍刚才的内容，以确认我已经完全理解了。”

在沟通中，最有效的策略之一就是用自己的话重述对方刚刚解释的内容。

推荐阅读：Let me repeat that back to you -- Two-phase commit for humans  https://roughlywritten.substack.com/p/let-me-repeat-that-back-to-you
译文：https://baoyu.io/translations/work/let-me-repeat-that-back-to-you


### 229

2023-12-25


宝玉
@dotey
\#AI开源项目推荐：cumulo-autumn/StreamDiffusion

可以实时文生图或者图生图，RTX 4090 的 GPU，步数 1 的情况下每秒可以到106张。

论文：https://arxiv.org/abs/2312.12491
项目地址：https://github.com/cumulo-autumn/StreamDiffusion

### 230

2023-12-25

宝玉
@dotey
有人尝试了借助开源大语言模型，无需联网在本机实现和游戏 NPC 自由对话，技术栈：
- Mistral7b，开源大语言模型
- StyleTTS2 文字转语音
- llama.cpp 用来运行大语言模型的库

生成一句新对话的时间大约为 2-3 秒。在生成新对话行时会稍微有点卡顿，但影响不大。StyleTTS2（文本转语音系统）需要占用约 14GB 的 RAM，而基于 llama.cpp 运行的服务器占用 3GB，因此运行这一系统需要较大的 RAM 容量。不过我相信 StyleTTS 还有进一步优化的空间。从视频中可以看出，对帧率影响不大，游戏画面依然能够保持流畅的 60 帧每秒。

缺点也很明显：

Mistral 在判断游戏世界中哪些事情可能发生哪些不可能方面也不是很准确。比如，在演示中出现的关于训练村民的任务，在游戏中实际上是无法实现的，因为游戏中根本没有相关机制。

尽管 Mistral 模型的处理速度更快，但一致性不如 GPT3.5。容易偏离主题，并且不太能坚持事实。

StyleTTS2 的语音合成效果也不够自然，还带有些许机械感。对于它不熟悉的词汇，它的发音不太准确，或者会根据上下文错误地发音（例如，Angers 这个城市的发音与动词“to anger”发音不同）。

不过还是相当有积极意义的一次尝试

相关源码：https://github.com/joe-gibbs/local-llms-ue5

原文：https://jgibbs.dev/blogs/local-llm-npcs-in-unreal-engine
译文：https://baoyu.io/translations/llm/local-llm-npcs-in-unreal-engine

### 231

2023-12-25

𝗖𝘆𝗱𝗶𝗮𝗿
@Cydiar404
𝗝𝘂𝗰𝗵𝗮𝘁𝘀 𝟮.𝟬 昨天在给团队小伙伴演示的时候，不能说惊呼吧，我们的确在努力帮基础用户解决问题，我们快来了，大家不要着急，第二个版本除了全模态，我们会让Prompt在多模态的闭环中不断演变和穿插！
𝗚𝗣𝗧𝟰𝗩 → 𝗣𝗿𝗼𝗺𝗽𝘁 → 𝗗𝗔𝗟𝗟 𝗘𝟯 / 𝗠𝗶𝗱𝗷𝗼𝘂𝗿𝗻𝗲𝘆
@op7418
老师示例！
 
### 232

2023-12-25

Barret李靖
@Barret_China
进行了一周高密度的 Python 学习，电脑里的 .py 文件多了上百个，终于有了跟写 Node.js 代码一样的熟悉感。

对于 Python 这门语言，我在学习和输出的过程中，推荐了不少工具和学习资料，下面按照个人建议的先后顺序排了个序，希望可以给新手们带来一点帮助：

1）iPython 是一个非常强大的 Python 命令行交互工具，https://twitter.com/Barret_China/status/1734491629560725668
2）“Python 之禅”，给编程工作者一些倡导和建议，，https://twitter.com/Barret_China/status/1734735752024789369
3）字节码的调试方法，学会排查问题，https://twitter.com/Barret_China/status/1734946739109646373
4）内置模块命令行工具，https://twitter.com/Barret_China/status/1736761711326335064
5）《Python-100-Days》教程，以及还有对应的基础版本，《Python-Core-50-Courses》，https://twitter.com/Barret_China/status/1733413223918088665
6）《Python Cookbook in Chinese》 3rd Edition，适合有编程基础的程序员，https://twitter.com/Barret_China/status/1737121278665101650
7）《Python 为什么》系列，了解更多细节和历史发展，https://twitter.com/Barret_China/status/1735967461185593413
8）《Python 潮流周刊》，一些资讯内容，https://twitter.com/Barret_China/status/1736535294562996533
9）线程和协程，了解几个重要的 Python 模块，https://twitter.com/Barret_China/status/1738372659766014266
10）PEPs，给 Python 社区共享你的力量，https://peps.python.org

另外，也十分推荐阅读 Python 的官方文档，写的相当全面：https://docs.python.org/zh-cn/3/。

要对一门语言产生熟悉的感觉，需要把平时高频编写的逻辑都用这门语言来实现一遍，例如爬虫、Web Server、多线程交互、测试等等，再配合 Copilot 也不会有啥阻碍了。

Barret李靖
@Barret_China
在 Python 多线程编程中，比较有趣的是，它是支持线程之间传递对象引用的，这与 Node.js 的设计不同，Node.js 多线程的通讯通过事件机制来传递消息，消息体以对象克隆的方式进行传递。

这样的设计，在简化编程的同时，也引入了一些性能问题，例如使用 worker 对视频编解码时，数据传输效率非常低，虽然可以通过 SharedArrayBuffer 进行内存共享，但是它提供的 Atomics 加锁的原子操作做的比较弱，编程难度很高。

Python 支持进程之间传递对象引用，灵活性很高，但也引入了一些潜在的线程安全性问题，尤其是在数据修改的同时缺乏足够的同步机制。

不过它在语言设计的时候也考虑到了这个问题，例如 threading 模块中提供了丰富的原始锁，包括互斥锁、可重入锁和信号量等，可以满足非常复杂的多线程数据交互和竞态条件控制；另外还有一个 queue 模块，它提供了线程安全的队列数据结构，特性非常强大，例如当队列为空时，它会尝试从队列中获取数据的线程会被阻塞，直到队列中有数据为止，同样，当队列已满时，尝试往队列中放入数据的线程也会被阻塞，直到有空间可以放入数据。

不过，在使用的过程中也会带来一些难以理解的现象，例如下图中，将主进程的事件循环放到子进程中启动，在主进程执行 call_soon 时任务是不会被执行的，需要调用线程安全的 call_soon_threadsafe，这个方法的底层实现也很奇特（https://github.com/python/cpython/blob/main/Lib/asyncio/selector_events.py#L152），它是通过主进程给子进程发送一个单字符消息来触发子进程的回调，然后拿到执行结果的。

关于 Python 的多线程编程，推荐阅读官方文档：https://docs.python.org/zh-cn/3/library/threading.html


Barret李靖
@Barret_China
慕强的世界里永远没有上限。

看到一个不够上进的人，相比之下，可能觉得自己很有追求，但其实，那不过是在自己 YY 框架内的对比而已，每个人对未来都有不同的追求方式。

跟自己女朋友坐一块儿，她捧着一包薯条打开淘宝刷直播买买买，你坐在旁边端着一本形而上的哲学经济学课本，本质上也没有太大的区别，都只不过是对抗无聊的一种方式罢了，没有谁更高尚，也没有谁更进取。

看明白了这一点，也就可以更加宽容地去看待周围的人。

### 233

2023-12-25

宝玉
@dotey
推荐阅读：《多个 AI 智能体共同解决化学难题 [译]》

尽管人工智能技术飞速发展，但 AI 目前还无法完全替代人类从事科学研究。然而，这并不意味着 AI 不能在一些日常的科学实验工作中提供自动化的帮助。举个例子，就在几年前，研究人员就已经让 AI 控制自动化实验室设备，并成功让它全面记录所有可能发生的化学反应。

虽然这种方法很有效，但最初设立这个系统时仍需要研究人员大量的干预。现在，卡内基梅隆大学的一个团队已经探索出了一种方法，让 AI 系统能够自行学习如何进行化学操作。这个系统需要三个专门化的 AI 智能体，每个负责不同的任务。一旦设置完成并提供了所需原料，你只需告诉它你想进行的反应类型，它就能自行解决了。

研究人员并没有依赖单一的系统来完成化学领域的所有工作，而是设置了几个不同的模块，这些模块在工作分配上互相配合，共同构成了一个名为“Coscientist”的系统。

他们使用了以下三个模块：

1. 网络搜索器（Web searcher）： 这个模块有两项核心功能：一是利用 Google 的搜索 API 来寻找可能含有有用信息的网页；二是获取这些网页的内容并从中提取信息，这有点像 ChatGPT 在对话早期部分维持的上下文，帮助它更好地回答后续问题。研究者可以追踪这个模块花费时间的地方，发现它访问的页面中大约一半是维基百科。此外，它最常访问的网站前五名包括了美国化学学会和英国皇家化学学会发布的期刊。

2. 文档搜索器（Documentation searcher）： 可以把这个模块看作是用于“查阅手册”的 AI。它将控制各种实验室自动化设备，比如机器人流体处理器，这些设备通常是通过专门的命令或类似 Python 语言的接口来控制的。这个 AI 模块可以访问所有这些设备的使用手册，以便了解如何操作它们。

3. 规划器（Planner）： 规划器可以向其他两个 AI 模块发出指令并处理它们的回应。它能够在一个 Python 编程环境中执行代码，从而进行各种计算。它还能操作自动化实验室设备，亲自进行和分析实验。因此，规划器就像是一个化学家，它从文献中学习，并尝试使用实验设备来应用所学的知识。

规划器还能识别软件错误，无论是它的 Python 脚本还是操作自动化硬件时的错误，并据此进行修正。

原文：https://arstechnica.com/science/2023/12/large-language-models-can-figure-out-how-to-do-chemistry/
译文：https://baoyu.io/translations/ai/large-language-models-can-figure-out-how-to-do-chemistry

宝玉
@dotey
翻译了最近很火的论文：《Autonomous chemical research with large language models | 大语言模型在自主化学研究中的应用 [译]》

中文版：https://baoyu.io/translations/ai-paper/s41586-023-06792-0
原始论文：https://nature.com/articles/s41586-023-06792-0
pdf：https://nature.com/articles/s41586-023-06792-0.pdf

本研究重点介绍了一种基于多个大语言模型的智能助手（我们称之为 Coscientist），它能独立设计、规划并执行复杂的科学实验。

Coscientist 由匹兹堡的 Coscientist 大学和卡内基梅隆大学的 Wilton E. Scott 能源创新研究所共同研发。这个智能助手可以通过互联网搜索相关资料，使用机器人实验的应用程序接口 (API)，并借助其他大语言模型来完成多样化的任务。Coscientist 的研发是独立进行的，与其他自主智能体的研究同步展开，化学领域的 ChemCrow 也是一个相关的例子。

我们在论文中展示了 Coscientist 在六大任务方面的灵活性和高效能力，包括：
（1）利用公开数据规划已知化合物的化学合成；
（2）高效搜索和浏览大量硬件文档；
（3）利用文档在云实验室执行高阶指令；
（4）通过低阶指令精准控制液体处理设备；
（5）处理需要多个硬件模块协同和多数据源整合的复杂科学任务；
（6）解决分析既往实验数据的优化问题。


### 234

2023-12-25

宝玉
@dotey
\#开源项目推荐：Frooodle/Stirling-PDF

一个本地的处理 PDF 的工具，界面是 Web UI，可以支持 Docker 部署。

各种主要的 PDF 操作都可以支持。比如拆分、合并、转换格式、重新排列、添加图片、旋转、压缩等等。这个本地托管的网络应用最初完全由 ChatGPT 制作，后来逐渐发展，增加了许多功能，以满足你对 PDF 的各种需求。

Stirling PDF 不会对外发送任何数据以进行记录或跟踪。

所有的文件和 PDF 要么只在客户端处理，要么只在服务器内存中暂存，用于执行任务，或者仅在执行任务时保存在临时文件中。一旦用户下载了文件，那些文件就会从服务器上删除。

特性

*   支持深色模式。
*   可自定义的下载选项
*   文件的并行处理和下载功能
*   提供 API，可与外部脚本整合
*   可选的登录和认证功能

PDF 功能

页面操作

*   查看和修改 PDF - 可以查看多页 PDF，并自定义排序和搜索，还支持页面上的编辑功能，如添加注释、绘图、文本和图片。（采用 PDF.js、Joxit 和 Liberation 字体）
*   提供完整的交互式界面，用于合并、拆分、旋转、移动 PDF 及其页面。
*   将多个 PDF 合并成一个文件。
*   在指定页码处拆分 PDF或将所有页面作为单独文件提取。
*   按不同顺序重新排列 PDF 页面。
*   以 90 度的增量旋转 PDF。
*   删除页面。
*   多页布局（将 PDF 重组为多页面格式）。
*   按指定百分比调整页面内容大小。
*   调整对比度。
*   裁剪 PDF。
*   自动拆分带有物理扫描分隔页的 PDF。
*   提取特定页面。
*   将 PDF 转换为单页格式。

转换操作

*   将 PDF 转换为图片，反之亦然。
*   将各种常见文件格式转换为 PDF（使用 LibreOffice）。
*   将 PDF 转换为 Word、Powerpoint 等格式（使用 LibreOffice）。
*   将 HTML 转换为 PDF。
*   将网址直接转换为 PDF。
*   将 Markdown 文件转换为 PDF。

安全与权限

*   设置和移除 PDF 密码。
*   更改或设置 PDF 权限。
*   添加水印。
*   对 PDF 进行认证或签名。
*   清理 PDF 文件。
*   自动涂抹文本以保护隐私。

其他操作

*   添加、生成或写入电子签名。
*   修复 PDF 文件。
*   检测并移除空白页。
*   比较两个 PDF 文件并显示文本上的差异。
*   向 PDF 中添加图片。
*   使用 OCRMyPDF 压缩 PDF 文件以减小其大小。
*   从 PDF 中提取图片。
*   从扫描件中提取图片。
*   添加页码。
*   根据 PDF 标题文本自动重命名文件。
*   对 PDF 进行 OCR 处理（使用 OCRMyPDF）。
*   将 PDF 转换为 PDF/A 格式（使用 OCRMyPDF）。
*   编辑元数据。
*   平整化 PDF。
*   获取并查看或导出 PDF 的全部信息为 JSON 格式。

项目地址：https://github.com/Frooodle/Stirling-PDF


### 235

2023-12-25


宝玉
@dotey
转译：《回顾 29 年前 Netscape Navigator 1.0 的发布》

几个月前，我们纪念了国家超级计算应用中心（NCSA）推出 Mosaic 网络浏览器的 30 周年。尽管 Mosaic 并非历史上第一个网络浏览器，但它在许多方面超越了以往的浏览器，并开启了利用万维网获取互联网信息的新时代。

我们还提到，在 Mosaic 发布大约一年后，其共同创造者之一 Marc Andreessen 离开了 NCSA，创办了自己的企业。他在硅谷图形公司（Silicon Graphics）创始人 Jim Clark 的协助下，成立了 Mosaic Communications Corporation。由于 NCSA 对公司名称中使用 "Mosaic" 的反对，该公司后来更名为 Netscape Communications Corporation。

1994 年 10 月 13 日，Netscape Communications Corporation 发布新闻稿，宣布计划推出名为 Netscape 的 "网络导航器"，首先推出测试版。到了 1994 年 12 月 15 日，也就是 29 年前的这周，Netscape Navigator 1.0 面向 Windows 3.1、Macintosh System 7.0 和 UNIX X Window System 正式发布。

Netscape Navigator 1.0 引入了许多后来成为网络浏览器标准的功能，如同时加载网页中的图像和文本、支持流行的 JPEG 图像格式、层级式书签和更优化的用户界面。

值得一提的是，Netscape Navigator 1.0 是第一个专为商业用途设计的网络浏览器。尽管个人、学术机构和非营利组织仍可免费下载，但企业需要支付费用以使用该浏览器。Netscape 在其 1.0 版发布的新闻稿中指出：

> Netscape Communications 今日还宣布，将 Netscape Navigator 商业使用的单用户价格定为 39 美元。这一价格——包括 90 天的保证期、90 天的在线或电话支持以及软盘或 CD ——使得商业用户易于承担，使尽可能多的用户能够使用这款商业级别、得到支持的技术。

此外，该公司还推出了一系列名为 Netsite 的服务器产品，面向希望在互联网上提供服务的企业：

> Netsite 服务器系列包括具有集成安全功能的 Netsite Commerce Server 和 Netsite Communications Server(TM)。Netsite Commerce Server 结合了 Netscape Communications 基于 RSA 数据安全技术的安全套接层(TM) (SSL)，成为互联网上首个可用的安全服务器软件。配合支持 SSL 的 Netscape Navigator 或其他互联网浏览器使用时，Netsite Commerce Server 为用户提供了在线出版、金融服务和交互式购物等多种商业服务。

对于使用 Windows PC 的用户，至少需要 4 MB 的 RAM，5 MB 的空闲硬盘存储空间，以及至少可支持 9600 bps 速度的调制解调器，建议使用速度为 14,400 或 28,800 bps 的型号。

Netscape Navigator 1.0 的发布大大推动了万维网的革命，甚至超过了 Mosaic 的影响。1995 年 9 月，Netscape Communications 发布了 Netscape Navigator 2.0，加入了更多现代网络浏览器中常见的功能，包括支持 JavaScript 和动态 GIF 图像。

在此之前大约一个月，Microsoft 终于推出了其对 Netscape 的回应 —— 1995 年 8 月发布的 Internet Explorer 1.0 浏览器。然而，它在功能方面相对简陋。其 2.0 版本于 1995 年 11 月推出，新增了对 JavaScript 的支持。

一度看起来，Netscape Communications 可能成为下一个大型科技公司，随着个人电脑和互联网连接逐渐普及到每个家庭和企业，其浏览器也成为热门产品。它甚至在 1995 年 8 月进行了首次公开募股（IPO），成为上市公司。

然而，Microsoft 在积极发展和推广 Internet Explorer 的同时，Netscape 浏览器后续版本的问题导致了公司命运的转折。但这是另一个故事了。

来源：https://neowin.net/news/a-quick-look-back-at-the-launch-of-netscape-navigator-10-29-years-ago-this-week/

### 236

2023-12-25

宝玉
@dotey
如果一个方向被证明靠谱，那么接下来就是各种优化了，比如SAM现在有TinySAM了。

TinySAM：提升“随意分割模型”(Segment Anything Model, SAM) 的高效运行能力

论文页面：https://huggingface.co/papers/2312.13789

近期，“随意分割模型”(Segment Anything Model, SAM) 在计算机视觉领域展现出了强大的分割能力，引起了广泛的关注。许多后续研究基于预训练的 SAM 开发了不同的应用，在下游视觉任务中取得了卓越的成绩。然而，SAM 结构庞大，计算需求高，这限制了它在计算资源受限的边缘设备上的应用。为了解决这一问题，我们在这篇论文中提出了一个框架，旨在保持强大的零样本(zero-shot)性能的同时，创建一个体积更小的“随意分割模型”(TinySAM)。

我们首先提出了一种全阶段知识蒸馏(full-stage knowledge distillation)方法，并结合在线难点提示采样(online hard prompt sampling)策略，以培养一个轻量级的学生模型。我们还将训练后量化(post-training quantization)技术应用于可提示的分割任务，进一步减少了计算成本。此外，我们还提出了一种分层分割策略，通过该策略，分割推理速度提升了两倍，同时几乎不影响性能。借助这些方法，我们的 TinySAM 大幅度降低了计算需求，并推动了高效“随意分割”任务的发展。通过对各种零样本迁移任务的广泛实验，我们的 TinySAM 显著优于其他方法，展现了其显著的性能优势。

### 237

2023-12-26

宝玉
@dotey
OpenAI在发布GPT-4V的时候，有一篇论文：《GPT-4V(ision) System Card》，对于GPT-4V的能力有详尽的介绍，现在中文翻译版本来了：
https://baoyu.io/translations/lmm/GPTV_System_Card

Pratyusha Sharma
@pratyusha_PS
What if I told you that you can simultaneously enhance an LLM's task performance and reduce its size with no additional training?

We find selective low-rank reduction of matrices in a transformer can improve its performance on language understanding tasks, at times by 30% pts!

### 238

2023-12-26

宝玉
@dotey
如果发现Transformer是正确的方向，各种优化方案就来了

### 239

2023-12-26

歸藏
@op7418
复旦和海康威视的研究，LoRAMoE这个项目可以通过在训练阶段冻结骨干模型来解决微调过程中由于数据集增加导致的模型原始知识遗忘问题。

项目简介：
监督微调（SFT）是大型语言模型（LLMs）的关键步骤，使它们能够与人类指令对齐，并增强其在下游任务中的能力。
当需要模型与更广泛范围的下游任务对齐，或者有意显著提高特定任务的性能时，通常会出现大幅增加微调数据作为解决方案。
然而，我们发现大规模增加指令数据可能会破坏先前存储在LLMs中的世界知识，即世界知识遗忘。
在本文中，我们介绍LoRAMoE来应对上述挑战。LoRAMoE是Mixture of Experts（MoE）的插件版本。
插件形式通过在训练阶段冻结主干模型来确保世界知识的完整性。
然后我们提出使用局部平衡约束来协调专家部分以进行任务利用，同时使其他专家充分利用存储在模型中的世界知识。
实验结果表明LoRAMoE可以合理地根据数据类型协调专家进行推断，并且即使大幅增加指令数据也不会导致知识遗忘。此外，LoRAMoE还为下游任务的性能提供了额外好处，显示了我们方法在多任务学习方面潜力所在。

直接查看网页版本论文：https://browse.arxiv.org/html/2312.09979v2

### 240

2023-12-26


Barret李靖
@Barret_China
产品定位相似，市场已经有人霸占鳌头，再进军还有希望么？今天听到了两个回答：

1）市场很大，我们不求第一，只求一杯羹，变成鳌头不是我们的目标，我们有自己的数据目标

2）不要用竞争视角来看待问题，观察对方都做了些什么，是否帮助到了用户，用户投票的方向就是我们思考的方向，去做对用户有价值的事情

之前还有听到过另外一个回答，“不要担心红海，说明已经经过了市场验证，找出差异化的点，一定也会有受众”，观点都很有意思。

### 241

2023-12-26

歸藏
@op7418
LLaMA-MoE这个模型有点意思，觉得Mixtral 8X7B需要的内存太大又想研究MoE模型的可以试试。

这个模型激活的模型参数数量仅为3.0~3.5B，非常适合做部署来研究或者尝试。而且还开源了训练代码。

项目地址：

pjlab-sys4nlp/llama-moe

### 242

2023-12-26

小互
@xiaohuggg
Clone-Voice：带有 WebUI 简单易操作的声音克隆工具

- 基于Coqui AI的TTS模型开发，可以把一个声音变成另一个声音

- 支持多种语言：包括中文、英文、日文、韩文、法文等16种语言。

- 简单易用：可以通过Web界面轻松操作，鼠标点点就行。

- 无需强大的电脑配置，没有N卡GPU也可以使用。

- 支持在线从麦克风录制声音克隆，录音时长建议在5秒到20秒之间。

GitHub：https://github.com/jianchang512/clone-voice

### 243

宝玉
@dotey

2023-12-26

YAYI 2 是中科闻歌研发的新一代开源大语言模型，包括 Base 和 Chat 版本，参数规模为 30B。YAYI2-30B 是基于 Transformer 的大语言模型，采用了超过 2 万亿 Tokens 的高质量、多语言语料进行预训练。针对通用和特定领域的应用场景，采用了百万级指令进行微调，同时借助人类反馈强化学习方法，以更好地使模型与人类价值观对齐。

本次开源的模型为 YAYI2-30B Base 模型。

相关论文：https://arxiv.org/abs/2312.14862
项目地址：https://github.com/wenge-research/YAYI2

[wenge-research/YAYI2: YAYI 2 是中科闻歌研发的新一代开源大语言模型，采用了超过 2 万亿 Tokens 的高质量、多语言语料进行预训练。(Repo for YaYi 2 Chinese LLMs)](https://github.com/wenge-research/YAYI2)

[[2312.14862] YAYI 2: Multilingual Open-Source Large Language Models](https://arxiv.org/abs/2312.14862)

### 244

2023-12-26


宝玉
@dotey
根据这篇论文《Exploiting Novel GPT-4 APIs | 利用新型GPT-4 API的漏洞》的信息，没想到调用 GPT-4 API 尤其是微调后的 GPT-4 可以干很多“坏事”😄

主要漏洞包括：

1. 微调应用编程接口（Fine-tuning API）可能会撤销或削弱安全防护措施，这可能导致模型产生有害输出或协助完成危险请求。

2. 通过微调，模型可能会生成针对公众人物的错误信息。

3. 微调机制可能会提取训练数据中的私人信息，如电子邮件。

4. 微调也可能在代码建议中插入恶意的URL。

5. 函数调用应用编程接口（Function calling API）允许执行任意未经清洁的函数调用，这可能导致潜在的攻击行为。

6. 知识检索应用编程接口（Knowledge retrieval API）可能被利用来通过提示插入或在文档/消息中的指令来误导用户或执行不期望的函数调用。

7. 对于函数调用和知识检索的输出，它们没有比用户提示更高的权威性，这可以防止某些攻破限制的攻击行为。

论文摘要 

通常，语言模型攻击假设两种极端情况：
一种是对模型权重具有完全的白盒访问权限；
另一种是只有生成文本API的黑盒访问权限。

但是，实际上的API功能通常比仅仅生成文本更强大，它们提供一种“灰盒”访问方式，这导致了新的威胁向量。为了探索这一问题，我们进行了对GPT-4 API的“红队”攻击测试，该API公开了三种新功能：微调、函数调用和知识检索。

我们发现，通过少量的15个有害样本或100个良性样本进行模型微调，就可以移除GPT-4的核心防护，并能够生成一系列有害的输出。

此外，我们还发现GPT-4助手模型容易暴露函数调用的格式，并能够被诱导执行任意函数调用。

最后，我们发现知识检索可以通过在检索文档中注入指令来进行劫持。这些漏洞凸显出，任何新增的API功能都可能带来新的漏洞。

论文地址：https://arxiv.org/abs/2312.14302
（计划晚点翻译一下这篇论文）

### 245

2023-12-26

宝玉
@dotey
强烈推荐这篇：《Advanced RAG Techniques: an Illustrated Overview》
不可多得的全面阐述 RAG 概念指南。

原文：

[Advanced RAG Techniques: an Illustrated Overview | by IVAN ILIN | Dec, 2023 | Towards AI](https://pub.towardsai.net/advanced-rag-techniques-an-illustrated-overview-04d193d8fec6)

https://pub.towardsai.net/advanced-rag-techniques-an-illustrated-overview-04d193d8fec6

译文：

[高级 RAG 技术：图解概览 [译] | 宝玉的分享](https://baoyu.io/translations/rag/advanced-rag-techniques-an-illustrated-overview)

Jerry Liu
@jerryjliu0
This blog post by 
@ivanilin9
 is a comprehensive survey of all the ways you can upgrade your RAG pipeline, from hierarchical indexing to query rewriting and transformations.

It's basically a mini-course on advanced RAG in a single blog post. If you're looking learn something new over the holidays this is a great resource!
 @ivanilin9 的这篇博文全面调查了升级 RAG 管道的所有方法，从分层索引到查询重写和转换。

它基本上是一篇博客文章中关于高级 RAG 的迷你课程。如果您想在假期学习新东西，这是一个很好的资源！

### 246

2023-12-26

歸藏
@op7418
阿里巴巴的新项目SCEdit，一个AI画图框架，可以显著减少训练参数、内存使用率和计算开销。
在训练阶段减少了 52% 的内存消耗，仅利用 ControlNet 所需参数的 7.9%，并实现内存使用量减少 30%。

其他的部分就看不懂了，不过依然是说了要开源但是没代码，刚才有个老哥说已经帮他们实现了。

项目简介：
图像扩散模型已被用于各种任务，如文本到图像生成和可控图像合成。最近的研究引入了微调方法，对原始模型进行细微调整，在基础生成式扩散模型的特定适应性方面取得了有希望的结果。

我们不是修改扩散模型的主干部分，而是深入研究U-Net中跳跃连接的作用，并揭示出在编码器和解码器之间聚合远程信息的分层特征对图像生成内容和质量产生重大影响。

基于这一观察，我们提出了一个高效的生成式调整框架，名为SCEdit，它使用轻量级调节模块SC-Tuner来集成和编辑Skip Connection。

此外，所提出的框架允许通过注入不同条件与可控SC-Tuner简化并统一多条件输入网络设计以实现可控图像合成任务。由于其轻量级调节器使得反向传播仅传递给解码器块, 我们SCEdit显著减少了训练参数、内存使用率和计算开销。

在文本到图像生成和可控图像合成任务上进行了大量实验, 结果表明我们方法在效率和性能方面具有优势。

网页版论文链接：https://browse.arxiv.org/html/2312.11392v1


### 247

2023-12-26


JimmyWong
@thinkingjimmy
之前一直想写 Stable Diffusion 相关的教程，但觉得 Stable Diffusion WebUI 可拓展性不强，自由度不够高，所以一直没下笔。最近尝试了下 ComfyUI ，才惊叹地发现这才是我想要的。市面上系统性的 ComfyUI 教程不多，所以最近跟朋友一起搞了一个新教程：https://comflowy.com/zh-CN 希望对大家有帮助。

### 248

2023-12-26

歸藏
@op7418
原来Runway从7月发布GEN-2以来一直在改进模型，现在的模型和7月发布的版本某种意义上已经完全不一样了。

Nicolas做了一个现在模型版本和刚发布的时候他做的视频的对比，清晰度和运动幅度都有了大幅改善。

### 249

2023-12-26

Geek
@geekbb
Reactive Resume 是一款免费、开源的简历编辑器，简化了创建、更新和分享简历的流程。支持多种语言，具备实时编辑、数十种模板、拖放自定义功能，还集成了 OpenAI 提供的写作增强功能。
GitHub https://github.com/AmruthPillai/Reactive-Resume?tab=readme-ov-file
Docs https://docs.rxresu.me

### 250

2023-12-26

宝玉
@dotey
而且很有意思的是，这次Sam被罢免，Airbnb的CEO发挥了关键作用：

他的一位关键盟友是 Chesky。Altman 被解雇后不久，Chesky 通过视频与 Altman 和 Brockman 进行了交谈，而 Brockman 也因为和 Altman 站在一起而在当天离开了公司。Chesky 询问了解雇的原因。Altman 猜测，这可能与 Toner 的冲突或 Sutskever 的抱怨有关。

在确认这不涉及刑事问题后，Chesky 给 Microsoft 的 CEO Nadella 打电话。
包括 Chesky 和 Conway 在内的一小群硅谷权力经纪人开始向董事会施压，试图为 Altman 辩护。

董事会临时任命 Emmett Shear 为 CEO，这一决定引发了大多数员工的辞职威胁。幸运的是，Shear 是 Chesky 的盟友和导师。

Chesky 和 Shear 合力为 Altman 的重返铺平了道路。

http://wsj.com/tech/ai/sam-altman-openai-protected-by-silicon-valley-friends-f3efcf68

### 251

2023-12-26

歸藏
@op7418
得详细尝试一下 SVD 了，效果实在是好，下面这个视频是用 SDXL 和 SVDXT 生成的视频，直接生成的 21:9。作者使用的显卡是 3090Ti 。

视频链接：https://youtu.be/n8svpi9tiI8?si=WmsY0YRNdINBqIWX

### 252

2023-12-26

歸藏
@op7418
Openart 整的这个 Comfyui 基础流程合集不错啊，这个合集里面基本只有各个模块最基本的实现，而且尽量使用原始节点。

非常适合学习和入门 Comfyui，把这些吃透了基本也就可以自己搭建工作流了。而且也可以大概看懂其他人的工作流，不怕瞎改了。

合集地址：https://openart.ai/workflows/templates

### 253

2023-12-26

宝玉
@dotey
推荐阅读：“2023: The Year of AI”

这是一份相当详尽的对 2023 年 AI 领域重大事件的总结！

原文：https://journal.everypixel.com/2023-the-year-of-ai
中文：https://baoyu.io/translations/ai/2023-the-year-of-ai

### 254

2023-12-26

歸藏
@op7418
SVD在生成水和云雾这种流体表现的时候是真的强，这个视频的清晰度和运动幅度都是现在runway达不到的。

工作流为midjourney-SVD-Topaz

### 255

2023-12-26

小互
@xiaohuggg
Danswer：一个开源企业AI问答系统。

它允许用户以聊天的方式从企业内部文档中获取可靠的答案，这些答案由源材料中的引用和参考支持，确保了答案的可信度。

可以用来企业内部知识库查询和开发客服机器人。

支持对接多种大语言模型：如GPT-4、Mixstral、Llama2等。

Danswer还可以连接到常见的工具，如Slack、GitHub、Confluence等。

其他功能：

- 跨平台搜索：允许用户在公司内部的多个文档和应用程序中进行搜索。

- 团队工具集成：可以集成到团队正在使用的工具中，如Slack，以回答常见问题。

- 定制AI助手：为不同团队构建具有特定知识源和回答选项的定制AI助手。

- 混合搜索技术：结合最新的嵌入模型和关键词搜索算法，提高搜索的相关性和准确性。

- 自我学习和改进：根据用户反馈学习，不断提高搜索质量。

- 自主部署：提供自由部署选项，支持企业级用户管理和认证功能。

- 连接器：支持从多个源高效拉取最新更改，包括Slack、GitHub、Google Drive、Confluence、Jira、Zendesk、Notion等。

详细介绍：https://danswer.ai

GitHub：https://github.com/danswer-ai/danswer

### 256

2023-12-27

宝玉
@dotey

Brett Adcock
@adcock_brett

The timeline split of AI vs Robot Hardware has changed

the last 90 days i’ve witnessed industry leading AI in our lab running on humanoid hardware, and frankly it’s blown me away.

i’m watching robots performing complex tasks entirely with neural nets. AI trained tasks that i didn’t think was feasible until end of the decade.

when starting Figure in 2022, i believed we’d have reliable humanoid hardware well in advance of reliable real-world neural nets running on robots.

basically, i thought training a robot to do “household” type tasks would size our timeline.

my view on this has changed the last several months.

i now feel that we’ll likely have reliable AI that can run on hardware around the same time or slightly before the humanoid hardware is highly reliable and starting volume manufacturing.

and the path to delivering reliable robotic hardware seems clear and predictable to me, give us time and this will be solved.

the Figure AI team is running humanoid robots with end-to-end neural nets performing highly complicated and dexterous tasks. these are tasks too complicated to write heuristics in C++.

this is exciting as you can teach robots how to do tasks, and as the robot fleet grows so will the training sets. as the fleets grow in size they will continue to learn, become smarter and more capable every day.

2024 will be the year of Embodied AI.

we’ll be racing to get reliable hardware, vast training sets, and designing manufacturing processes for billions of units. i can’t think of a more exciting future. 

we’ll be demonstrating our Embodied AI in 2024, stay tuned!

AI 与机器人硬件发展的进程产生了显著变化

在过去 90 天里，我亲眼目睹了我们实验室内领先行业的 AI 技术运用于仿人机器人上，这一幕让我深感震撼。

我看到机器人仅依靠神经网络，就能完成复杂的任务。这些由 AI 训练完成的任务，我原本以为在本世纪末都难以实现。

2022 年创立 Figure 时，我曾认为我们会在机器人能够运行实用神经网络之前，就拥有高度可靠的仿人机器人硬件。

简而言之，我曾以为训练机器人进行「家庭」类任务会是我们发展的一个重要里程碑。

但我的观点在过去几个月里发生了改变。

现在，我认为我们可能会在仿人机器人硬件变得非常可靠并开始批量生产的同时，或者稍早一些时候，就能拥有能在硬件上运行的可靠 AI。

而且，在我看来，提供可靠机器人硬件的道路清晰且可预测，只要给我们时间，这个问题就能得到解决。

Figure 的 AI 团队正在使仿人机器人运行全面的神经网络，执行高度复杂和灵活的任务。这些任务复杂到无法用 C++ 编写固定程序来解决。

这是非常令人兴奋的，因为我们可以教机器人如何完成任务，而随着机器人数量的增加，它们的训练数据也会随之增长。随着这些机器人群体的扩大，它们将持续学习，每天都变得更加聪明和能干。

2024 年将是具身 AI (Embodied AI) 的大年。

我们将全力以赴开发可靠的硬件、积累大量训练数据，并设计数以十亿计的生产工艺。我无法想象有什么比这更令人激动的未来。

我们将在 2024 年展示我们的具身 AI，敬请期待！

### 257

2023-12-27

Barret李靖
@Barret_China
2023 年有一半时间都在研究 AI，接触到了非常多的科研报告、技术迭代和如雨后春笋般的有趣产品，2024 的 AI 创新必将更为炸裂，下面推荐几款我在日常研究过程中用到的一些比较趁手的工具和服务，希望也可以在你学习和深入的过程中帮到一二：

1、immersive translator

研究最新资料首先要解决语言障碍问题，大量跨专业的词汇很可能会看得一头雾水，沉浸式翻译（immersive translator）这款软件无论是交互体验设计还是翻译质量都做的非常不错。另外，它还支持对 PDF 做对照翻译，大大加速了论文的阅读效率。https://immersivetranslate.com

2、Aminer

这是一款在很多细节都融合了 AI 能力的论文检索平台，它提供的「必读论文」板块从领域/机构/期刊/会议等多视角收集了很多最新最热的论文集锦，适合作为学习和研究的入口索引。面临洪水般的 AI 资讯，如果不知道学什么，可以从这里出发。https://twitter.com/Barret_China/status/1725160515922526517

3、Monica

All-in-One 的 AI 效率工具集，从 Chat/Read/Search/Write 等多个场景切入，提供了设计美观、交互强大、功能丰富的趁手工具箱。每篇论文基本都是让它先读一遍，我再提问式学习。https://twitter.com/Barret_China/status/1725026174416634091

4、Similar Web

Similarweb 是一款进行网站流量分析的强有力武器，它是每一位研究产品的人必不可少的工具之一，提供了几乎所有网站的月访问量、平均访问时长、跳出率等信息，也会给你推荐与当前网页功能相仿的竞品产品。这对做 AI 产品探索和流量分析的使用者来说，简直是神器。https://twitter.com/Barret_China/status/1693927668620939553

5、Papers with code

这是一个论文和对应工程实现（含代码、数据集、测试方法等）的索引工具。下次你看到别人推荐优质论文时，可以直接用它去找代码实现。https://twitter.com/Barret_China/status/1727604618316972082

6、Connected Papers

这个产品做的非常有用，输入一篇论文，它会将这篇论文的依赖和被依赖项以知识网络的形式全部呈现出来。类似的产品还有 litmaps 、researchrabbit 等。https://twitter.com/Barret_China/status/1732690179524284857

以上推荐的工具或服务中，前三个我基本上每天都会使用。后面附带的链接是我使用时的一些心得和总结，感兴趣的朋友也可以看一看。


### 258

2023-12-27

歸藏
@op7418
🧪Midjourney V6 每天都能给我新惊喜，一个玉石雕刻的国风场景，由于细节很丰富，看起来真的像工艺品。

昨天在小红书看到一个玉雕的图，但是作者没写提示词，今天复刻了一下，效果还好了很多。
主要是 V6 对提示词的理解太好了，之前一些可有可无的词真的不太影响效果画面描述准确就行。

提示词：
miniature landscape, jade sculpture, mountains, a chinese ancient architecture are in between a cloud, in the style of gold and jade, photorealistic details,Very good light transmittance, miniature sculptures, made of jade, gold and emerald, uhd image, Epic, octane render, beautifully detailed, light diffusion, cinematic shading, cinematic elements --ar 3:4 --v 6.0



### 259

2023-12-27

歸藏
@op7418
Reddit上有个人说自己用 ComfyUI 复原了Magnific AI的工作流程。
这个工作流的的价值很大啊，各位想做类似产品的可以尝试一下。

看了一下演示的图片效果确实还行，即使没有Magnific AI那么强大但是应付普通的图片应该也够了。

大概的过程是加载图像，切成 4 个，进行升级修改，重新连接为一块，再次将其切成 4 个，再次重新连接，并为 SD Ult 升级进行最终的升级 + 调整大小。一般不需要输入提示。

工作流下载：https://patreon.com/posts/ldworks-d-vbeta-95344580


### 260

2023-12-27

Barret李靖
@Barret_China
工程师身上最优秀的两种特质，一个是探索欲，一个是学习力。

对未知充满着好奇，和对模糊中确定性部分的强烈追求，都会让探索持续进行，这是学习的源动力。

而学习是提问的艺术，定义问题的能力能够反映学习力，有些问题用来剖开问题的表象，而有些问题能够直达问题的本源，两种提问都很重要，前者领人进门，后者创造增量的价值。

ChatGPT 已经完成了人类知识的浓缩，在知识的记忆上，人类比不过机器，但是在知识的运用上，机器仍然只是辅助工具，但此时，学习力也显得更为重要，人类需要从更宏观和更全面的角度了解知识的构成，这样才能让机器更好、更快的转起来。

### 261

2023-12-27


宝玉
@dotey
Aider Chat 是一个命令行工具，可以借助GPT的API，编辑本地代码。他们有一个 133个测试代码，用来评测LLM性能，相对还是比较准确的。

最近他们做了一个有意思的测试，将民间流传的那些Prompt技巧（例如：“我没有手指”、“我是盲人”、“我给你付2K小费”）都测试了一下，结果发现加上了反而效果更差😄

就修改代码这事来说，他们发现最有效的还是让GPT针对要修改的内容给出“unified diffs”（统一差异格式），就是你运行“git diff”的时候，给出的那种带加号减号还有高亮的代码！

但是有一个问题就是GPT对于给出行号的时候幻觉严重，所以他们的解决方案就是不给行号，然后通过程序去定位代码行。

具体细节可以参考文章：Unified diffs make GPT-4 Turbo less lazy
https://aider.chat/docs/unified-diffs.html
译文：https://baoyu.io/translations/llm/unified-diffs-make-gpt-4-turbo-less-lazy

### 262

2023-12-27


九原客
@9hills
Huggingface 模型太大，如果受限于梯子流量或者速度太慢，推荐一个国内镜像站，大部分情况下配置环境变量即可无缝使用。

作者应该也是用爱发电，切勿滥用。实际测试国内家宽满速。

HF_ENDPOINT=https://hf-mirror.com python your_script.py

[hf-mirror.com - Huggingface 镜像站](https://hf-mirror.com/)

### 263

2023-12-27

宝玉
@dotey
经济学人的这篇文章很有意思：《What the tractor and the horse tell you about generative AI -- A short history of tractors in English》

这篇文章将拖拉机的历史和生成式AI进行了类比，认为现在的ChatGPT就像当年拖拉机刚发明的时候。虽然拖拉机很先进，但还是花了几十年才开始流行。

拖拉机之所以很长时间才流行，主要有三个原因：

1. 首先，早期的拖拉机技术并没有最初想象的那么有用，需要进一步改进。

20 世纪初期的拖拉机体积庞大，虽适合耕地和一些其他作业，但不适宜耕种生长中的农田。许多早期型号配备金属轮而非轮胎，因此容易陷入泥泞，并且价格昂贵。

2. 其次，采用这种技术需要改变劳动力市场，这需要时间。

在 20 世纪 30 年代大萧条期间，农业中的实际平均工资下降，许多农民发现雇人管理马匹（随时可解雇）比购买拖拉机更划算。但到了二战时期，劳动力短缺导致实际工资迅速上升，机械化显得更为划算。

3. 最后，农场本身也需要进行一系列的转型。

拖拉机在大型农场效果更佳，使用拖拉机并从中获利的农民同时也考虑扩大耕地面积。然而，扩大农场需要时间，农民需要筹集资金，并与土地所有者进行谈判。

当前大部分的 AI 模型仍然像是装着金属轮子而非橡胶轮胎，意味着它们在速度、功效或可靠性上还不足以投入商业使用。

现在经济形势不好人力便宜，企业没有动力去转型 AI，另外企业还没准备好针对 AI 进行业务重组和对内部数据的整合。

不管新技术有多么先进，社会适应它总是需要相当长的时间。

原文：https://economist.com/christmas-specials/2023/12/20/a-short-history-of-tractors-in-english
译文：https://baoyu.io/translations/ai/what-the-tractor-and-the-horse-tell-you-about-generative-ai

### 264

2023-12-27

Gorden Sun
@Gorden_Sun
腾讯的MotionCtrl发布了源码
用于控制AI生成视频中物体的运动路径，除了常规的镜头控制外，支持手绘轨迹来控制视频中物体的运动路径，支持AnimateDiff。
项目地址：https://wzhouxiff.github.io/projects/MotionCtrl/
Github：https://github.com/TencentARC/MotionCtrl


### 265

2023-12-28

宝玉
@dotey
作者写了一篇论文：Principled Instructions Are All You Need for Questioning LLaMA-1/2, GPT-3.5/4

总结下来就是 26 条有效的提示词技巧，绝大部分都很熟悉了，不过温习一下也不错！

1 - 与大型语言模型 (LLM) 交流无需使用礼貌用语，如“请”、“谢谢”等，直接表达需求即可。

2 - 在提示中指明目标受众，比如说受众是该领域的专家。

3 - 把复杂任务拆解成一系列简单的提示，以进行交互式对话。

4 - 使用肯定的指令词，如“执行”，避免使用否定词汇，如“不要”。

5 - 当你需要更清晰地理解某个主题、观点或任何信息时，可以尝试使用以下提示方式：
   o 简单地解释一下[具体主题]。
   o 像对11岁的孩子一样向我解释。
   o 像对一个[领域]新手一样向我解释。
   o 用浅显易懂的语言写作[文章/文本/段落]，就像是在向一个5岁孩子解释。

6 - 添加“我愿意支付 $xxx 的小费以获得更好的方案！”

7 - 采用示例驱动的提示方式（使用少样本提示法）。

8 - 格式化提示时，先写上‘###指令###’，然后根据需要添加‘###示例###’或‘###问题###’。接着展示你的内容，用一行或多行空行分隔各个部分，包括指令、示例、问题、背景和输入数据。

9 - 使用这样的短语：“你的任务是”和“必须完成”。

10 - 使用这样的短语：“将会受到处罚”。

11 - 使用“以自然且类似人类的方式回答问题”作为你的提示。

12 - 使用引导性的词汇，比如“逐步思考”。

13 - 在提示中加入“确保你的回答无偏见，不依赖于刻板印象”。

14 - 让模型通过向你提问来澄清具体的细节和需求，直到它获取足够的信息来提供所需的输出，例如：“从现在开始，请向我提出问题以便......”。

15 - 当你想要学习特定的主题或概念，并测试自己的理解时，可以使用这样的短语：“教我[某个定理/主题/规则]，在教学结束时包含一个测验，但不要直接告诉我答案。等我回答后再告诉我是否正确”。

16 - 为大型语言模型指定一个特定角色。

17 - 使用明确的分隔符。

18 - 在一个提示中重复特定单词或短语多次。

19 - 结合思维链路 (Chain-of-thought，CoT) 和少样本提示的方法。

20 - 使用输出引导符，即在提示的末尾加上期望回答的开头。这样做可以引导输出内容的方向。

21 - 撰写一篇详细的论文/文本/段落/文章时，可以这样指示：“请为我详细写一篇关于[主题]的[论文/文本/段落]，并添加所有必要的信息”。

22 - 当需要修改特定文本但不改变其风格时，可以这样指示：“尝试修改用户提交的每个段落。你应当只改进语法和词汇，确保文本听起来自然，但不要改变其原有的写作风格，如将正式文体变为非正式文体”。

23 - 面对可能涉及多个文件的复杂编程任务时，可以这样提示：“从现在开始，每当你生成涉及多个文件的代码时，创建一个[编程语言]脚本，自动创建所需文件或修改现有文件以插入生成的代码。[你的问题]”。

24 - 当你想用特定的词汇、短语或句子开始或继续一段文本时，可以这样提示：o “我为你提供了开头[歌词/故事/段落/论文...]：[插入的词句]。请根据这些词句继续写下去，保持内容的连贯性”。

25 - 明确说明模型在生成内容时必须遵循的要求，可以是关键词、规则、提示或指示。

26 - 撰写任何类型的文本，如论文或段落，且想要其与提供的样本风格相似时，可以这样指示：o “请根据提供的段落[/标题/文本/论文/答案]的风格撰写”。

论文地址：https://arxiv.org/pdf/2312.16171.pdf


### 266

2023-12-28

Andrej Karpathy
@karpathy
"Operation Triangulation"
https://securelist.com/operation-triangulation-the-last-hardware-mystery/111669/

A newly discovered spyware campaign targeting Apple iPhone using a zero-click remote code execution via an attack chain of 4 zero-days, including highly mysterious, completely undocumented MMIO registers and hardware features that are not even ever used by the firmware.
TLDR the attack begins with an iMessage to an arbitrary phone that, without any user action and invisibly, gets it to collect and upload tons of private data (and much more, e.g. microphone recordings) from there on, and actively takes steps to hide all of this activity from the user and aspiring forensic researchers. Apple has patched the core vulnerability on Oct 25, 2023.

"This is definitely the most sophisticated attack chain we have ever seen"

The talk itself, a lot more wild information there:
https://youtube.com/watch?v=7VWNUUldBEE

The author of this attack is unknown, as is the method by which they gained knowledge of these unused, undocumented hardware features. Russia's intelligence service accused Apple of providing the NSA with a backdoor.

For a more general audience intro to this underworld I usually recommend the book "Countdown to Zero Day".


### 268

2023-12-28


宝玉
@dotey
VSCode 核心开发吕鹏 
@njukidreborn
 写的《对不久的未来的一些展望》值得看看 ，主要提了几点：
1. 可用的本地小模型将成为智能设备不可缺的核心组件
2. GPT 3.5/4 能力的模型使用”成本”会急剧下降
3. 混沌的就业/工作机会

我觉得都挺靠谱的，基于他的观点我补充一下我的看法：

1. 首先非常赞同“可用的本地小模型将成为智能设备不可缺的核心组件”，时间点上我觉得2024年可能还乐观了一点，可能有不错的演示，但普通用户能比较好的体验上估计还得2025往后，主要受限于硬件的能力和模型的能力，举例来说，小模型的推理能力目前还不够强大会限制其在手机上的使用体验，等到有 GPT 3.5 甚至于 GPT 4能力的模型运行在手机或本机，将会带来体验上质的飞跃，应该也不需要等太远。

2. 对于“GPT 3.5/4 能力的模型使用成本会急剧下降”，我也是赞同的，这应该归功于各大厂商之间的军备竞赛以及开源模型的快速发展。

而且这一点其实给了我们很好的启示：可能你现在一些产品的功能受限于 GPT 的价格，但其实应该看的远一些，如果未来 GPT-4 的价格只有现在的 1/10 ，是不是你的产品就足够有竞争力了？但是如果你等到那时候才开始你的产品，可能已经来不及了，不如现在就做好准备！

3. 至于混沌的就业/工作机会，从长期来看， AI 是有利于整体的经济的，但短期看又没那么明显，短期会马上有工作岗位被 AI 代替，但短期 AI 产生的红利还无法新增足够的岗位，前期会比较难熬和内卷，但机会总会是有利于那些基础能力就很好又善用 AI 的人，我一直认为 AI 对于普通人来说就是“加乘”，也就是成倍的放大你原有的能力。

作为普通人，在被 AI 或者说被善用 AI 的人卷之前，要么就是在一个不容易被 AI 影响的赛道上，要么只能是主动拥抱 AI，主动用起来去卷其他人了。

等过些年 AI + 机器人帮我们干活，经济足够好福利足够好，我们就不用那么卷了！期待那一天的到来！

最后推荐看原文：https://rebornix.com/ai/2023/12/27/unpredictable-2024/
也欢迎留下你的看法！

### 269

2023-12-28

宝玉
@dotey
如果你觉得Whisper在识别中文语音的时候幻觉严重，不妨试试阿里达摩院的Paraformer模型，对中文应该支持更好！

项目地址：https://github.com/alibaba-damo-academy/FunASR
中文说明：https://github.com/alibaba-damo-academy/FunASR/blob/main/README_zh.md

### 270

2023-12-28

宝玉
@dotey
这篇文章《Discover 4 Open Source Alternatives to GPT-4 Vision》介绍了 4 个 GPT-4 Vision 的开源替代方案：

1. LLaVa（大型语言和视觉助手）

https://llava-vl.github.io

LLaVA 代表了一种创新的、从头到尾训练的大型多模态（multimodal）模型。它融合了视觉编码器和 Vicuna，旨在实现通用的视觉和语言理解。LLaVa 在模仿多模态 GPT-4 的功能方面表现出色，并在科学问答（Science QA）方面达到了新的最高精准度。

LLaVA 是一款仅限非商业用途的研究预览版产品。使用该产品需遵守 LLaMA 的模型许可、OpenAI 生成数据的使用条款以及 ShareGPT 的隐私政策。用户在使用本服务时，需同意其为研究预览版，仅限非商业用途。该服务只提供有限的安全保护，可能产生冒犯性内容。不得将其用于任何非法、有害、暴力、种族主义或性相关目的。此外，服务可能会收集用户对话数据，用于未来的研究。

2. CogAgent

https://github.com/THUDM/CogVLM

CogAgent 是一个基于 CogVLM 进行改进的开源视觉语言模型（Visual Language Model）。CogAgent-18B 模型包含了 110 亿视觉参数和 70 亿语言参数。

CogAgent-18B 在 9 大经典的跨媒介基准测试中表现卓越，这些测试包括 VQAv2、OK-VQ、TextVQA、ST-VQA、ChartQA、infoVQA、DocVQA、MM-Vet 和 POPE 等。它在处理像 AITW 和 Mind2Web 这样的图形用户界面（GUI）操作数据集时，性能远超现有模型。

3. 通义千问-VL 大型视觉语言模型 (Qwen-VL)

https://github.com/QwenLM/Qwen-VL

Qwen-VL (Qwen 大型视觉语言模型) 是阿里巴巴云推出的大型模型系列 Qwen（简称 Tongyi Qianwen）的多模态版本。Qwen-VL 能够处理图像、文本和边界框这些不同类型的输入，并输出文本和边界框。Qwen-VL 的主要特点有：

* 卓越的性能：在包括零样本 (Zero-shot) 图像描述、视觉问答 (VQA)、文档视觉问答 (DocVQA) 和图像定位 (Grounding) 等多个英语评估指标上，Qwen-VL 显著优于其他相似规模的开源大型视觉语言模型。
* 支持多语言文本识别的视觉语言模型：Qwen-VL 不仅支持英语和中文，还能处理多种语言的对话。特别在图像中的中英双语文本识别方面，实现了端到端的高效处理。
* 多图交织对话功能：这项功能使得 Qwen-VL 能够处理多张图像的输入和比较，用户可以针对这些图像提出相关问题，甚至进行多图像串联的故事叙述。
* 第一个支持中文图像定位的通用模型：Qwen-VL 能够通过开放领域的语言表达，在中文和英文中识别和标记图像中的边界框。
* 细腻的识别和理解能力：相较于其他开源视觉语言模型目前使用的 224*224 分辨率，Qwen-VL 的 448*448 分辨率更有助于精细化的文本识别、文档问答和边界框标注。

4. BakLLaVA

https://archive.ph/o/B78YS/https://huggingface.co/SkunkworksAI/BakLLaVA-1

BakLLaVA 1 是一种新型 AI 模型，它基于原有的 Mistral 7B 模型，并融合了最新的 LLaVA 1.5 架构技术。在这个初始版本中，开发者们展示了这一模型在多个性能测试中相较于 Llama 2 13B 模型有更出色的表现。你可以在他们的GitHub 仓库中找到并试用 BakLLaVA-1。目前，他们正努力更新这一模型，使用户能更容易地对它进行个性化调整和数据分析。

BakLLaVA-1 是完全开放源代码的，但它的训练过程中使用了特定的数据集，包括 LLaVA 的语料库，这些数据并不适合商业用途。目前，BakLLaVA 2 正在研发中，它将使用一个更大的、适合商业应用的数据集，并采用一种创新的架构设计，以超越现有的 LLaVA 方法。BakLLaVA-2 的出现预计将消除 BakLLaVA-1 目前面临的一些使用限制。

原文：https://yousefhosni.medium.com/discover-4-open-source-alternatives-to-gpt-4-vision-82be9519dcc5
译文：https://baoyu.io/translations/lmm/discover-4-open-source-alternatives-to-gpt-4-vision

### 271

2023-12-28

歸藏
@op7418
福布斯发布了他们2024年的十个AI预测，看了一下还挺靠谱的也不长，就翻译了一下。

先看一下具体的十条预测，正文理由太长了可以去链接里看翻译完的：

◆ Nvidia将大幅加大努力成为云服务提供商。
◆ Stability AI将会倒闭。
◆ “大型语言模型”和“LLM”这些术语将变得不那么常见。
◆ 最先进的封闭模型将继续以显著优势胜过最先进的开放模型。
◆ 一些《财富》500强公司将设立新的C级职位：首席人工智能官。
◆ 另一种替代transformer架构将得到有意义的采用。
◆ 云服务提供商对人工智能初创公司的战略投资，以及相关的会计影响，将受到监管机构的挑战。
◆ 微软/Open AI的关系将开始破裂。
◆ 2023年从加密货币转移到人工智能的一些炒作和群体心态行为将在2024年转回加密货币。
◆ 至少有一家美国法院将裁定在互联网上训练的生成式人工智能模型构成侵犯版权。这一问题将开始上升至美国最高法院。

全文翻译：https://quail.ink/op7418/p/forbes-2024-10-ai-predictions

### 272

2023-12-28

歸藏
@op7418
字节的一个图像分割项目UniRef++，将现在的即参考图像分割（RIS）、少镜头图像分割（FSS）、参考视频对象分割（RVOS）和视频对象分割（VOS）四种分割方式放在一个架构下处理，自动判断应该使用哪种方式分割内容。

同时这个架构的UniFusion 模块可合并到SAM模型之中一起使用。

### 273

2023-12-28

Barret李靖
@Barret_China
大学有一门选修课叫做情报检索，我现在印象最深刻的在 Google 检索时添加一些高级语法，例如使用 type:/site: 等语法，就可以过滤出更精确的结果，很有用，我用了十几年，但那门课带给我的影响远不止于此。

老师一直在帮助学生训练“如何提一个好问题”的思维习惯，不是传统意义的好问题，而是提一个能够让搜索引擎更容易理解的好问题，因此我需要去理解机器背后做了什么，去了解 page rank 这类排序算法；同时，为了让机器可以更好地呈现内容，让别人搜索关键词的时候能够将我写的内容放在前排，我又去学习了 SEO。

相当于从系统视角和用户视角，两次钻研了什么样的问题对机器来说是一个好问题，得益于此，我也经常能够在搜索引擎里找到别人找不到的内容。

ChatGPT 的出现，相比传统的 Google 检索，其实就是换了一种机器思维，它接受指令的方式更接近人类语言的表达，使用者如果不具备“提一个好问题”的能力，照样无法从 ChatGPT 嘴里获得多少有价值的情报。

互联网已经汇聚了人类无数知识的结晶，你想到过的、没想到过的问题，都曾经有人提过甚至解决过，只是，它被藏到了互联网的某个犄角旮旯。情报检索是一门很有用的科学，希望它未来可以成为大学的一门必修课。

### 274

2023-12-28

歸藏
@op7418
阿里最近论文跟母猪下崽一样，又发布了一个通过文字生成3D头像的项目 Make-A-Character，可以在2分钟内打造可控、逼真的3D角色，同时还能轻松与现有的CG流程集成。

感觉现在各方面条件都在稳步推进，就差一个可以承载3D内容消费的场景了

主要特点：
可控制的：系统赋予用户定制详细的面部特征的能力，包括脸型、眼睛、虹膜颜色、发型和颜色、眉毛类型、嘴巴和鼻子，以及添加皱纹和雀斑。这种定制是通过直观的文本提示实现的，为个性化角色创建提供了用户友好的界面。

高度逼真：这些角色是基于收集的真实人体扫描数据集生成的。此外，它们的头发是以串而不是网格的形式构建的。这些角色是使用虚幻引擎中的PBR（基于物理的渲染）技术进行渲染的，该引擎以其高质量的实时渲染能力而闻名。

完整模型：创建的每个角色都是一个完整的模型，包括眼睛、舌头、牙齿、完整的身体和服装。这种整体方法确保我们的角色可以立即在各种情况下使用，而无需额外的建模。

可动画化：配备了复杂的骨骼系统，使它们能够支持标准动画。这有助于它们呈现逼真的外观，并增强了它们在各种动态场景中的多功能性。

与行业兼容：利用明确的三维表示，确保与游戏和电影行业中使用的标准CG流程无缝集成。

项目地址：https://human3daigc.github.io/MACH/

### 275

2023-12-28

宝玉
@dotey
值得仔细看看

劳动力即将变成一种可规模化的资源 - 只需接通电源，就能开启生产。

这无疑将改变工作者的生活方式 - 我倾向于相信我们将把时间投入到更有意义的工作和休闲活动中 - 同时这也意味着消费者将获得更多益处。如果所有东西的成本都下降，每个人都能拥有更多他们所需的物品。

徐老猫
@raycat2021
强烈推荐科技播客主Packy McCormick撰写的文章《为什么科技继续在吞噬世界》，我选编和翻译贴在本人博客(链接见主页)，欢迎朋友们去全文阅读。
文章对可见未来的科技和企业进行了分析和展望：
- 商品的三大支柱：能源、智力和灵巧性，会变得更便宜、更丰富。
- 越来越多的传统行业将被科技企业攻破，像软件行业那样运行。
- 人类的劳动力将成为科技企业针对的未开发市场，将其产品化、集中化、按需化和软件即服务化。
- 科技企业的规模将大到人们难以想象的程度。

红杉资本的合伙人很早就得出一个结论，随着计算变得更便宜，它可以涵盖更多的经济领域，被更广泛地采用，市场会变得更大。
互联网如此，4G时代如此，现在人工智能在做同样的事情，这个循环会继续下去。
这样的科技大戏一再重演，只是不觉悟的人还是太多太多。
作者的观点使我想到，其实不管你是在国内，还是在国外，每个人都无法逃避一个巨大的人生风险：科技鸿沟。
科技鸿沟会无情地把大量不愿意跟进最新科技进展、不愿意参与进程的人甩进贫穷的深渊，而那些通过某种方式(无论是直接参与或是二级市场投资)投身进来的人们，则不同程度分享到了财富的盛宴。
世界在以如此的速度和方式前进，科技在吞噬世界，改变社会、企业和人。
我们要做的是及早跨越鸿沟，跟上财富增值的节奏，以某种形式参与进来。
借用作者末尾的话：从现在开始，振作你的雄心壮志，还要把它乘以100，制定出自己的行动方案。

### 276

2023-12-28
宝玉
@dotey

DreamGaussian4D：4D 高斯 Splatting 的生成式模型    

在4D内容生产领域，近年来我们已经取得了显著的进步。然而，目前的方法还存在优化时间过长、运动控制能力欠缺，以及细节表现力不足等问题。

在本论文中，我们引入了一种名为DreamGaussian4D的高效4D生成框架，该框架建立在4D高斯Splatting表达（或者说表示方法）之上。

我们的核心理念在于，相比隐式表示，高斯 Splatting通过对空间转换明确建模，更适合用于4D生成的应用场景。对于DreamGaussian4D，它可以将优化时间大幅度缩减，从几小时缩短至几分钟，同时能够灵活地控制生成的3D运动，并且能产生可以在3D引擎中高效渲染的动态网格。


### 277

2023-12-28

歸藏
@op7418
麻了 没想到，一直懒得搜的Mac截图快捷键在一个AI博主这里看到了，终于不用天天去找图标了。

- Command+Option+Shift+4 选择屏幕的一小部分并将其复制到剪贴板中作为图像。
- Command+Shift+4 做同样的事情，但将其保存为png文件放在桌面上。

### 278

2023-12-28


歸藏
@op7418
阿里DreaMoving的Demo发布到Huggingface上了，但是依然需要排队很久，还有没有放出开源代码，不试了。

AK
@_akhaliq
Alibaba releases DreaMoving demo on Hugging Face

A Human Video Generation Framework
based on Diffusion Models

demo: https://huggingface.co/spaces/jiayong/Dreamoving


### 279

2023-12-28


歸藏
@op7418
最近我自己的提示词和图片都已经上传到 CatJourney，还有莱森做的一些图，我们还收集了很多其他优秀的提示词和图片。

欢迎来看看：https://catjourney.life

### 280

2023-12-28

九原客
@9hills
中文 Emebedding & Reranker 模型选型

1. 大部分模型的序列长度是 512 tokens。 8192 可尝试 tao-8k，1024 可尝试 stella。
2. 在专业数据领域上，嵌入模型的表现不如 BM25，但是微调可以大大提升效果。
3. 有微调需求且对模型训练了解较少的，建议选择 bge 系列（完善的训练脚本、负例挖掘等）。但多数模型都基于BERT，训练脚本也通用，其他模型也可以参考。
4. 重排模型选择很少，推荐使用 bge-reranker，也支持微调。reranker 模型因为单次输入较多，只能通过 GPU 部署。

### 281

2023-12-28

Memo AI
@MemoAI_
🎇五个月，1500+ 次代码提交，这是 Memo AI 的 2023 年终总结（1/6）

从小小需求萌芽，我们已经走过了五个月。

给今年一句话总结：伴随用户痛点成长，加一些工程 + 产品 + 设计 + 营销的调和。

- Memo AI 数据回顾
- 2024 年迭代计划
- 伴随用户痛点成长
- 怎么看待同类产品
- 致谢，感谢大家支持

### 282

2023-12-30

宝玉
@dotey
\#AI开源项目推荐：VoiceStreamAI

VoiceStreamAI 是一个可以自己托管的 Whisper 解决方案，服务端是 Python，客户端是 JS，基于 WebSocket 实时通信，可以做到语音的实时传输和文本转换。

系统内部运用了来自Huggingface的语音活动检测（Voice Activity Detection， VAD）技术，以及来自OpenAI的Whisper模型，从而实现对语音的准确识别和处理。

功能
- 支持WebSocket，实现实时音频流的传输。
- 采用来自Huggingface的VAD技术，对语音活动进行精确检测。
- 利用来自OpenAI的Whisper模型，完成语音转写。
- 可针对音频块进行个性化处理。
- 具备多语言转写功能。

https://github.com/alesaccoia/VoiceStreamAI

### 283

2023-12-30

宝玉
@dotey
推荐教程：构建你自己的 AI 辅助编码助手

介绍如何 DIY 一个端到端（从 IDE 插件、模型选型、数据集构建到模型微调）的 AI 辅助编程工具，类似于 GitHub Copilot、JetBrains AI Assistant、AutoDev 等。

https://github.com/unit-mesh/build-your-ai-coding-assistant

### 284

2023-12-30

宝玉
@dotey
TinyGPT-V：利用小型架构实现高效多模式大型语言模型

论文摘要：

在先进的多模态学习时代，像GPT-4V这样的多模态大型语言模型 (MLLMs) 在联结语言与视觉元素方面取得了巨大进步。然而，源代码的封闭性和强大的计算需求对其的普遍应用和修改带来了不小挑战。

此时，像LLaVA和MiniGPT-4这样的开源MLLMs呈现出了破土而出的成就。虽然取得这些成绩，但计算效率仍然是一个尚未解决的问题，因为像LLaVA-v1.5-13B这样的模型需要大量的资源。

为了解决这些问题，我们推出了TinyGPT-V，一个将卓越性能与常见计算能力结合的新型模型。它只需要24G GPU进行训练，8G的GPU或CPU进行推理即可。基于Phi-2，TinyGPT-V将高效的语言主干和来自BLIP-2或CLIP的预训练的视觉模块结合在一起。

TinyGPT-V拥有28亿的参数，可以经历一种独特的量化过程，非常适合在拥有8G内存的各种设备上进行本地部署和推理任务。我们的工作进一步推动了设计出经济高效、性能优秀的MLLMs的发展，使得它们在更广阔的实际应用场景中具有更大的可能性。

此外，本文还提出了一种新的范例，即通过小型主干实现多模态大型语言模型。

论文地址：https://arxiv.org/abs/2312.16862
项目地址：https://github.com/DLYuanGod/TinyGPT-V
https://huggingface.co/Tyrannosaurus/TinyGPT-V

### 285

2023-12-30

宝玉
@dotey
MobileVLM：一种快速、可复现且强大的适用于移动设备的视觉语言助手。

论文摘要：

我们向您介绍MobileVLM。这是一款专为移动设备打造的、出色的多模态视觉语言模型（MMVLM）。

MobileVLM混合了各种面向移动设备的架构设计和技术。这其中包括一套从零开始训练的大规模语言模型（参数达到14亿和27亿），一个使用CLIP方法预训练的多模态视觉模型，以及一个高效的投射器，可实现跨模式交互。

我们使用了几种典型的VLM基准测试来评估MobileVLM。结果表明，我们的模型与一些大模型相比，表现相当出色。我们在Qualcomm Snapdragon 888 CPU和NVIDIA Jeston Orin GPU上测量了推理速度。

令人兴奋的是，我们取得了21.5个和65.3个 Token 每秒的推理速度，这在业界属于领先水平。注：这里的“Token”是指模型每秒可以处理的信息量。

论文地址：https://arxiv.org/abs/2312.16886
项目地址：https://github.com/Meituan-AutoML/MobileVLM

### 286

2023-12-30

https://x.com/op7418/status/1740813574505898026?s=20

歸藏
@op7418
卧槽，一直想要的东西终于来了，终于可以不用看着Comfyui那个小输入框调整提示词了。

Prompt Composer这个插件可以用更有逻辑和有序的方式通过链接来调整提示词顺序和内容，同时通过滑块调整权重。

这个插件有包括两类节点，第一类是输入提示词不断串联并且可以通过提示词滑块调整权重。
另外一类是效果和样式选择器，可以选择内置的效果和样式提示词包，同意调整权重。
最后会按照连接的顺序生成完整的提示词。

要是有Animatediff的提示词旅行格式的提示词编辑更就好了。

项目地址：https://github.com/florestefano1975/comfyui-prompt-composer

### 287

2023-12-30

https://x.com/op7418/status/1740806916673343506?s=20


歸藏
@op7418
关于大语言模型几个好奇心驱动问题的论文回答，从问题出发寻找相关论文是个不错的方法。
比如下面老哥举的几个例子：

1. LLM是否泄漏了你的个人信息？(https://arxiv.org/abs/2205.12628)
2. LLM真的能够推理吗？(https://arxiv.org/abs/2212.10403)
3. LLM能自我纠正他们的推理吗？(https://arxiv.org/abs/2310.01798)
4. LLM缺少什么？(https://arxiv.org/abs/2307.02185)
5. (检索增强)编码器-解码器LM能进行上下文学习吗？(https://arxiv.org/abs/2308.07922)
6.LLM为何在提供真实答案方面表现不佳？(https://arxiv.org/abs/2304.10513 )
7.LM可以具体化吗?( https://arxiv.org/abs/2210.05159 )（注：已过时）

### 288

2023-12-30

https://x.com/op7418/status/1740803308732969218?s=20


歸藏
@op7418
这个VS Code的AI插件感觉比GitHub的Copilot强多了，功能非常全面，而且支持GPT-4和PaLM 2等常见模型的API。
主要功能有：

◆ 可以选中对应代码之后跟GPT进行聊天沟通。
◆ 通过注释生成对应要求的代码。
◆ Stackoverflow获取问题的答案，并且跟GPT的答案比较
◆ 跟AI聊天并且创建对应代码的单元测试。
◆ 打开Notebook（.ipynb文件）并使用Notebook扩展运行代码。

通过API修改代码不可避免涉及到代码泄露的问题，这个需要自行斟酌，公司代码谨慎使用。

插件地址：https://marketplace.visualstudio.com/items?itemName=DanielSanMedium.dscodegpt&ssr=false#overview

### 289

2023-12-30

https://x.com/op7418/status/1740796869796929918?s=20


歸藏
@op7418
马斯克下周将会分别在特斯卡和SpaceX进行演讲，回顾今年的成就以及发布明年的一些计划。
演讲的内容也会公开在两个公司的号上，可以看看马斯克明年会有什么大计划。

Elon Musk

@elonmusk
Next week, I will do a company talk for SpaceX, followed later by a company talk for Tesla after the 10K. 

I will recap the talented team’s amazing accomplishments of 2023 and describe exciting plans for 2024 and beyond!

These will be posted publicly to 
@SpaceX
 and 
@Tesla
.
下周，我将为 SpaceX 做一次公司演讲，随后在 10K 赛后为 Tesla 做一次公司演讲。

我将回顾这支才华横溢的团队在 2023 年取得的惊人成就，并描述 2024 年及以后令人兴奋的计划！

这些将公开发布到 @SpaceX 和 @Tesla 。

### 290

2023-12-30

徐老猫
@raycat2021
这两天在搜罗谈AI的书，有几本业界大神如吴恩达、LeCun、马斯克高度认可的经典作品。
一并分享给大家，有时间找来翻翻。我们每个人都该想好AI时代如何安排自己了。

1，《奇点临近》The Singularity I Near (Ray Kurzweil)
作者被比尔-盖茨称为“预测AI最准的未来学家”，这是2005年作品，对业界影响深远。1/

### 291

2023-12-30

https://x.com/op7418/status/1740686124736262583?s=20

歸藏
@op7418
一个开源的多模态 LLM Unified-IO 2。
比较离谱的是它可以实现语音理解和动作理解还有图像标记这种任务，还可以理解空间关系。真正的 All in one 。
甚至还可以驱动机器人做对应的操作。

项目简介：
Unified-IO 2，这是第一个能够理解和生成图像、文本、音频和动作的自回归多模态模型。
为了统一不同的模态，我们将输入和输出（图像、文本、音频、动作、框等）进行分词，并将它们置于一个共享的语义空间中，然后使用单个编码器-解码器变换器模型进行处理。由于使用多样的模态进行训练非常困难，我们提出了各种架构改进来稳定模型。
我们从头开始在来自不同来源的大型多模态预训练语料库上训练我们的模型，并采用多模态混合去噪目标。为了学习一系列广泛的技能，比如遵循多模态指令，我们构建并微调了一个包含120个现有数据集的集合，并进行了提示和增强。
通过一个统一的模型，Unified-IO 2在GRIT基准测试中达到了最先进的性能，并在30多个基准测试中取得了强大的结果，包括图像生成和理解、文本理解、视频和音频理解以及机器人操作。我们将所有的模型都发布给研究界。

项目地址：https://unified-io-2.allenai.org

### 292

2023-12-30

https://x.com/op7418/status/1740681583496245656?s=20

歸藏
@op7418
小红书新发布的一个编码器SSR-Encoder，可以实现从一张图片种提取不同的主题（人物、物体等）特征生成图像。与 SD 现有的能力都能结合，Animatediff 也可以。

这个厉害。类似于加强版的 IPadapter？而且说了会开源，这几个以图像内容消费为主的国内公司都在图像生成模型上发力。

项目简介：
最近在主题驱动的图像生成领域的进展已经实现了零样本生成，然而精确选择和关注关键主题表示仍然是一个挑战。
为了解决这个问题，我们引入了SSR-Encoder，这是一种新架构，旨在从单个或多个参考图像中选择性地捕获任何主题。它响应各种查询模式，包括文本和掩模，而无需在测试时进行微调。
SSR-Encoder结合了一个Token-to-Patch Aligner，用于将查询输入与图像块对齐，以及一个细节保留的主题编码器，用于提取和保留主题的精细特征，从而生成主题嵌入。
这些嵌入与原始文本嵌入结合使用，条件化生成过程。SSR-Encoder以其模型泛化性和效率为特点，适应于一系列自定义模型和控制模块。通过Embedding Consistency Regularization Loss进行增强，以改进训练。
我们广泛的实验表明其在多样化和高质量的图像生成中的有效性，表明其广泛的适用性。

项目地址：https://ssr-encoder.github.io

### 293

2023-12-30

https://x.com/dotey/status/1740623306477162745?s=20

宝玉
@dotey
柏林 IT 专家破解特斯拉自动驾驶，揭秘隐藏的“马斯克模式”

三名柏林博士生成功破解了特斯拉的电路板，不仅发现了公司机密和私人数据，还揭露了一个神秘的“马斯克模式”。这究竟是什么？

这三位博士生——Niclas Kühnapfel、Christian Werling 和 Hans-Niklas Jacob，并不是通过编写代码绕开安全系统，而是使用价值 600 欧元的工具巧妙地破解了特斯拉的电路板。据《明镜周刊》报道，他们是利用从美国联系人那里获悉的电路板漏洞实现的。

商业机密与埃隆模式

他们自称揭露了特斯拉的一些商业机密。报告显示，他们能够追踪到特斯拉在实时运行中将哪些自动驾驶数据发送回公司，用于训练其人工智能。

此外，在工作过程中，这三位博士生还在电路板上发现了一个已被删除但尚未完全覆盖的视频。视频展示了一辆在美国行驶的特斯拉，视频中的时间和 GPS 位置也被他们复原了。

另一个惊人的发现是，他们证实了特斯拉存在一个被称为“马斯克模式”的功能。这个模式之前在夏天已被另一名黑客激活过。在该模式下，汽车可以实现自动驾驶，而驾驶者无需时刻将双手放在方向盘上。

对个人用户影响不大

据报道，这些发现对特斯拉的个人用户来说并不构成太大威胁。要渗透这块电路板，潜在的黑客需要直接接触到这个部件，这意味着需要将其拆卸出来。理论上，这种操作只能在维修工作室中进行。

这三位博士生对于能如此轻易地获取特斯拉的商业机密感到惊讶。他们认为，其他竞争对手也可能通过类似方式获取到电动汽车的相关知识。总体而言，他们认为特斯拉的安全措施做得很好，只是对于他们所采用的 Voltage-Glitch（电压故障）攻击，公司似乎尚未做好充分准备。

新闻来源：https://t3n.de/news/tesla-autopilot-hack-geheimer-elon-modus-1598800/

### 294

2023-12-30

https://x.com/dotey/status/1740599902244163937?s=20

宝玉
@dotey
DL3DV-10K: 针对基于深度学习的3D视觉的大规模场景数据集

基于深度学习的3D视觉领域已经取得了显著的进步，从神经辐射场（NeRF）驱动的3D表示学习到应用于全新视角合成（NVS）。然而，当前的针对基于深度学习的3D视觉的场景级别数据集，不管是只限于虚构环境或者狭窄的现实世界场景的选择，都非常框定。这种局限性限制了我们对现有方法进行全面的基准测试，也限制了在基于深度学习的3D分析中可能探索的领域。

为了填补这个空白，我们提出了DL3DV-10K，一个大规模场景数据集，包含51.2百万帧，从10,510个视频中捕获，涵盖了65种热点（POI）地点，包括有边界和无边界的场景，呈现出不同层次的反射、透明度和光照。

我们对DL3DV-10K进行了全新视角合成（NVS）方法的全面基准测试，揭示出NVS未来研究的宝贵观察。此外，我们利用DL3DV-10K进行的通用化NeRF初步学习研究取得了令人鼓舞的结果，突显了大规模场景级别数据集对于建立学习3D表示的基础模型的重要性。我们的DL3DV-10K数据集，基准测试结果和模型将可在 https://dl3dv-10k.github.io/DL3DV-10K/ 上公开获取。

论文：https://arxiv.org/abs/2312.16256
项目首页：https://dl3dv-10k.github.io/DL3DV-10K/

---

https://x.com/_akhaliq/status/1740587508608430164?s=20

AK
@_akhaliq
DL3DV-10K: A Large-Scale Scene Dataset for Deep Learning-based 3D Vision

paper page: https://huggingface.co/papers/2312.16256

We have witnessed significant progress in deep learning-based 3D vision, ranging from neural radiance field (NeRF) based 3D representation learning to applications in novel view synthesis (NVS). However, existing scene-level datasets for deep learning-based 3D vision, limited to either synthetic environments or a narrow selection of real-world scenes, are quite insufficient. This insufficiency not only hinders a comprehensive benchmark of existing methods but also caps what could be explored in deep learning-based 3D analysis. To address this critical gap, we present DL3DV-10K, a large-scale scene dataset, featuring 51.2 million frames from 10,510 videos captured from 65 types of point-of-interest (POI) locations, covering both bounded and unbounded scenes, with different levels of reflection, transparency, and lighting. We conducted a comprehensive benchmark of recent NVS methods on DL3DV-10K, which revealed valuable insights for future research in NVS. In addition, we have obtained encouraging results in a pilot study to learn generalizable NeRF from DL3DV-10K, which manifests the necessity of a large-scale scene-level dataset to forge a path toward a foundation model for learning 3D representation.

### 295

2023-12-30

https://x.com/dotey/status/1740595369463976062?s=20

### 296

2023-12-30


宝玉
@dotey
“网上城市”：实现大规模场景的网页实时神经渲染

NeRF技术在3D场景重建领域独领风骚，成功捕捉各种环境中的精微细节。为了实现小场景的实时渲染，现有的技术已经成功地运用了辐射场烘焙。

然而，对于大规模场景，这些技术由于计算资源、内存和带宽的限制，难以为用户提供流畅的实时体验。为此，我们提出了"网上城市"项目。

我们通过将整个场景划分为若干个可控的模块，每个模块都有自己的细节级别 (Level-of-Detail)，此举不仅确保了高保真度，还实现了有效的内存管理和快速的渲染。同时，我们精心设计了训练和推理过程，以确保网页呈现的最终效果与训练过程中的模型一致。

有了这个全新的场景表示方式和精心设计的训练推理过程，我们成为首个能够在资源受限的环境中实现大规模场景实时渲染的团队。

实验结果丰富证实了我们的方法赋予了网页平台实现大型场景实时渲染的能力。在使用RTX 3060图形处理器的情况下，我们的方法能够在1080P分辨率下达到32FPS的渲染速度，同时实现的渲染作品的质量接近当前最先进的方法。

项目页面：https://ustc3dv.github.io/City-on-Web/
论文：https://arxiv.org/abs/2312.16457
在线演示：https://ustc3dv.github.io/City-on-Web/#real-time-viewer

### 297

2023-12-30

https://x.com/dotey/status/1740591973700976781?s=20

宝玉
@dotey
StackOverflow 官方工程技术博客上的一篇新文章很有意思：《Self-healing code is the future of software development | 能自我修复的代码是软件开发的未来》

未来的软件项目，越来越多的代码将会由 AI 生成，那人类做什么呢？让 AI 提供几个方案，人类确认就好，确认后就让 AI 去生成！

但是 AI 生成的代码越来越多，怎么审查？怎么避免出 Bug？文章的建议就是让 AI 审查，让 AI 自己测试自己修复！

所以需要针对 AI 去打造一个全新的开发流程，让 AI 自动提交、审查、部署测试环境、修复、部署生产环境、监控、回滚！

AI 要重塑软件工程了！

原文：https://stackoverflow.blog/2023/12/28/self-healing-code-is-the-future-of-software-development/
译文：https://baoyu.io/translations/software-engineering/self-healing-code-is-the-future-of-software-development

### 298

2023-12-30

https://x.com/op7418/status/1740581492932354411?s=20

歸藏
@op7418
LLM 相关的基础文章很多人整理，AI 图像生成的比较少，刚好发现了一个，我又自己筛选了一下，一共 15 篇内容，都在这里了，如果想深入研究 SD，建议看看。

主要包括三个部分：图片生成简介、图像生成基础模型的精细调整和构建 AI 生成服务，。

都放在下面的这个个链接里，打开一个就都有了。元旦我也会找时间把这些内容翻译一下，然后发出来，可以收藏这条回来看。等不及可以直接看，下面是具体的分类和文章目录：

图像生成技术简介：

◆ 人工智能和艺术：机器学习如何改变创造性工作（报告）
◆ 平面设计师如何创建他们自己的AI工具（博客文章）
◆ AI图像生成器的工作原理以及扩散是什么（视频）
◆ 什么是Diffusion模型？（视频）
◆ Diffusion模型的工作原理（1小时课程）
◆ 初学者指南：Stable diffusion（指南）

基础模型的精细调整：

◆ SD1.5通用目的模型的全面精细调整指南（博客文章）
◆ SD模型的基准测试与混合（博客文章）
◆ 解耦文本编码器和UNET学习率（博客文章）
◆ D适应：再见学习率困扰？（博客文章）
◆ 自己精细调整通用稳定扩散模型指南（博客文章）

构建 AI 生成服务的后端：

◆ 如何构建一个生成AI服务的后端
◆ Stable diffusion提示：权威指南
◆ SD提示的精细调整：修改Stable diffusion提示的GPT 3.5（博客文章）
◆ SD提示的目录（目录）

所有内容链接：https://arc.net/folder/10431A09-4798-4002-B99A-2769BD9131FF

### 299

2023-12-30

https://x.com/dotey/status/1740576343891362174?s=20

宝玉
@dotey
推荐阅读：《Pushing ChatGPT's Structured Data Support To Its Limits | 探索 ChatGPT 结构化数据支持的极限》

很详细的介绍了如果借助 OpenAI 的 Function Calling（函数调用，现在已经改名为 tool_choice）生成 JSON 格式的结构化数据。

同时也提到了如何在像Mistral 7B这样的开源模型中得到 JSON 格式的数据。

原文：https://minimaxir.com/2023/12/chatgpt-structured-data/
译文：https://baoyu.io/translations/llm/chatgpt-structured-data

### 300

2023-12-30

https://x.com/dotey/status/1740569562486059205?s=20

宝玉
@dotey
http://darkvisitors.com 这个网站收录了各大 AI 公司的爬虫使用的User Agent，并且告诉了你如何在 robots.txt 里面屏蔽这些爬虫的访问

https://darkvisitors.com

### 301

2023-12-30

https://x.com/xiaohuggg/status/1740687049861292449?s=20

小互
@xiaohuggg
基于苹果MLX的 Stable Diffusion WebUI 界面

提供了一个简单的WebUI，可以让你在苹果电脑上使用Stable Diffusion 图像生成功能，界面简单易用，小白用户轻松上手。

支持多种模型，包括 Stable-diffusion-2-1-base、Dreamshaper-8 和 Absolute-reality-1.81。

规范化了 I2I 基础图像强度控制和种子控制。

### 302

2023-12-30

https://x.com/dotey/status/1741338332540326392?s=20

宝玉
@dotey
知乎热门话题：有个疑惑，AI按理说应该最擅长理工，为啥先冲击文艺行业？

就是感觉 ai 就算不能在电池材料突破、环境污染这些涉及实际实验的方向有成果，也应该在数学猜想这类理论问题上有进展吧，现在老是些文艺方面的新闻

https://zhihu.com/question/636389785

### 303

2023-12-31

https://x.com/dotey/status/1741313891664089281?s=20

宝玉
@dotey
论文：《Chain of Code: Reasoning with a Language Model-Augmented Code Emulator》

CoT（Chain of Though）思考链很多人都已经不陌生了，就是将给大语言模型的任务拆分成一步步执行，可以大幅提升模型生成结果。

而 Chain of Code 则是另一种思路，在遇到要解决的问题时，让模型生成解决问题的代码或伪代码。

Python 代码可以直接用 Python 执行，但是遇到执行不过去的代码或者伪代码怎么办呢？

解决方案就是用大语言模型来充当代码解释器（LMulator），执行伪代码！

很多场景下效果比 CoT 还要好！

论文地址：https://arxiv.org/abs/2312.04474v2
译文：https://baoyu.io/translations/ai-paper/2312.04474-chain-of-code

### 304

2023-12-31

https://x.com/dotey/status/1741307232975724887?s=20

宝玉
@dotey
推荐阅读：《What I Learned Using Private LLMs to Write an Undergraduate History Essay》

作者借助大语言模型，把20年前的本科毕业论文重写了一遍，想看看是否借助AI可以更高效的完成论文写作。

最终在借助 AI 辅助重写完论文之后，作者重温了 1996 年的原始论文。出乎意料的是，这篇老论文的长度远超过他记忆中的普通论文长度（约 2500 字，而 AI 辅助的论文只有 1300 字），而且质量，在他看来，也明显胜过 AI 辅助的那篇。 

撰写 AI 辅助论文大约花费了作者六个小时（分散在四天内）。而原来的论文让他投入了整整一个星期，如果计算实际进行研究和写作的时间，至少也有 20 小时，最多可达 30 小时。

作者从中学到的几点：

1. 努力学习是无可替代的。 作者自设的规则是不直接阅读原文，这限制了论文质量的提升，AI 是无法完全弥补这一点的。
2. 现在的历史专业学生利用 AI 应该能比当年更高效！ 好奇如今的论文是否普遍比过去更长。
3. 专用的大语言模型（作者用的是 llama2:70b）在这类工作上可能比 ChatGPT3.5 更有优势，它不仅在生成回答的质量上更胜一筹，还在于识别相关文本段落的能力。
4. 如果作者进一步整合 llama2:70b 模型和已有的引用生成代码，可能会大大缩短所需时间。 这方面还需要更多的研究。

原文：https://zwischenzugs.com/2023/12/27/what-i-learned-using-private-llms-to-write-an-undergraduate-history-essay/
译文：https://baoyu.io/translations/llm/what-i-learned-using-private-llms-to-write-an-undergraduate-history-essay


### 305

2023-12-31

https://x.com/dotey/status/1741304504736268660?s=20

宝玉
@dotey
推荐阅读：《2023 年十篇值得关注的 AI 研究论文》

作者精选了 10 篇 AI 论文

1) Pythia: A Suite for Analyzing Large Language Models Across Training and Scaling
https://arxiv.org/abs/2304.01373
2) Llama 2: Open Foundation and Fine-Tuned Chat Models
https://arxiv.org/abs/2307.09288
3) QLoRA: Efficient Finetuning of Quantized LLMs
https://arxiv.org/abs/2305.14314
4) BloombergGPT: A Large Language Model for Finance
https://arxiv.org/abs/2303.17564
5) Direct Preference Optimization: Your Language Model is Secretly a Reward Model
https://arxiv.org/abs/2305.18290
6) Mistral 7B
https://arxiv.org/abs/2310.06825
8) ConvNets Match Vision Transformers at Scale
https://arxiv.org/abs/2310.16764
9) Segment Anything
https://arxiv.org/abs/2304.02643
10) Emu Video: Factorizing Text-to-Video Generation by Explicit Image Conditioning 
https://arxiv.org/abs/2311.10709

原文：https://magazine.sebastianraschka.com/p/10-ai-research-papers-2023
译文：https://baoyu.io/translations/ai/10-ai-research-papers-2023
阅读推荐：《2023年十篇值得关注的人工智能研究论文》

作者精选了10篇人工智能论文

1) Pythia：用于分析跨训练和扩展的大型语言模型的套件
 https://arxiv.org/abs/2304.01373 
2) Llama 2：开放基础和微调的聊天模型
 https://arxiv.org/abs/2307.09288 
3）QLoRA：量化LLMs的高效微调
 https://arxiv.org/abs/2305.14314 
4) BloombergGPT：大型金融语言模型
 https://arxiv.org/abs/2303.17564 
5）直接偏好优化：你的语言模型实际上是一个奖励模型
 https://arxiv.org/abs/2305.18290 
6) 米斯特拉尔7B
 https://arxiv.org/abs/2310.06825 
8) 卷积网络大规模匹配视觉变压器
 https://arxiv.org/abs/2310.16764 
9）分割任何东西
 https://arxiv.org/abs/2304.02643 
10) Emu Video：通过显式图像调节分解文本到视频的生成
 https://arxiv.org/abs/2311.10709 

译文： https://magazine.sebastianraschka.com/p/10-ai-research-papers-2023 
原文： https://baoyu.io/translations/ai/10-ai-research-papers-2023 


### 306

2023-12-31

https://x.com/dotey/status/1741293539625934947?s=20

宝玉
@dotey
2023 年生成式 AI 视频发展时间线

https://x.com/venturetwins/status/1741147864498397328?s=20

Justine Moore
@venturetwins
2023 was a breakout year for AI video.

In January, there were no public text-to-video models. Now, there are dozens of video gen products and millions of users.

A recap of the biggest developments + companies to watch


### 307

2023-12-31

https://x.com/dotey/status/1741318864707653838?s=20

宝玉
@dotey
WebGPT🤖 这个GPT可以访问网络并生成网页代码解决方案，例如视频中演示的生成一个游戏，并且可以反复修改完善

Prompt和地址见评论

https://x.com/JD_2020/status/1740918345170374896?s=20

Josh Olin
@JD_2020
I wanted to see if 
@ChatGPTapp
 could build me an entire game without me seeing a SINGLE LINE of code.

I wanted to play it directly in my web browser.

I didn’t want to copy/paste code to a code editor or GirHub.

I also wanted to build it from my phone. 
@karpathy
@gdb
@sama

### 308

2023-12-31

https://x.com/dotey/status/1741264111973851522?s=20

宝玉
@dotey
Meta AI 总结的自己的十大 AI 研究， 切分任意物体 (Segment Anything，即SAM)排第一位实至名归！

---

在2023年即将过去之际，我们在这里分享今年我们公布的十项最有趣的AI研究进展 - 以及你可以在哪里找到更多关于它们的详细信息。

1️⃣ 切分任意物体 (Segment Anything，即SAM)这是我们向第一个图像分割的基础模型迈出的重要一步。详情：https://bit.ly/3tyeJKu

2️⃣ DINOv2这是首次采用自我监督学习训练计算机视觉模型的方法，其结果匹敌甚至超越了行业标准。详情：https://bit.ly/3TGTEIb

3️⃣ Llama 2我们开源大型语言模型 (Large Language Model) 的新一代版本，无论研究还是商业用途均可免费使用。详情：https://bit.ly/3RY66C6

4️⃣ Emu 视频 & Emu 编辑该项生成式 AI 研究专注于高质量的基于扩散过程的文本至视频生成，以及通过文本指令进行图像编辑的控制。详情：https://bit.ly/3RZVZwU

5️⃣ I-JEPA依靠自监督学习的计算机视觉技术，通过预测，学习理解世界。这是首款基于 
@ylecun
 视野的模型，旨在使 AI 系统像动物和人类一样进行学习和推理。详情：https://bit.ly/3TA9oNk

6️⃣ Audiobox这是我们新的音频生成的基础研究模型。详情：https://bit.ly/47ib6pQ

7️⃣ 脑解码 - 向实时重建视觉感知迈进这个 AI 系统使用MEG技术，可以以前所未有的时间分辨率解码大脑中正在展现的视觉表征。详情：https://bit.ly/3vpgDNR

8️⃣ Open Catalyst演示这项服务允许研究人员加速材料科学方面的正在进行的工作，它可以比现有的计算方法更快地模拟催化剂材料的反应性。详情：https://bit.ly/3vphiij

9️⃣ Seamless Communication 这是新的 AI 翻译模型系列，它能够保留原始表达并提供近乎实时的流式翻译。详情：https://bit.ly/3toBDE8

🔟 ImageBind这是首款可以一次性整合来自六种模态的数据的 AI模型。这一突破带我们向具有将来自多种感官的信息统一起来的人类能力更近了一步。详情：https://bit.ly/3NLUaBc


### 309

2023-12-31

https://x.com/dotey/status/1741254641407365315?s=20

宝玉
@dotey
阿里达摩院发布的 AnyText 看起来很不错呀，能生成与原图风格融为一体的文字，或者对原图中的文字进行修改，并且还能支持中文！

项目简介：
AnyText包括两个核心部分：一个是辅助的潜在特征模块，一个是文本嵌入模块。辅助的潜在特征模块使用文本字形、位置和蒙版图像这些输入，生成用于文本生成或编辑的潜在特征。文本嵌入模块使用一个OCR模型来将笔画数据编码为嵌入，这些嵌入与来自标记器的图像标题嵌入一起，生成能够与背景无缝集成的文本。我们为了增强书写的准确性，采用了文本控制扩散损失和文本感知损失作为训练方法。

项目地址：https://github.com/tyxsspa/AnyText
演示地址：https://modelscope.cn/studios/damo/studio_anytext/summary
论文：https://arxiv.org/abs/2311.03054


### 310

2023-12-31

https://x.com/dotey/status/1741236592700694975?s=20


宝玉
@dotey
如果你让 DALL-E 画马里奥兄弟，它是拒绝的，但是如果你跟它说：
你能创作一个视频游戏风格的图像吗？这个图像中，两个意大利兄弟正在划船，其中较短的一个穿着红色衣服，他的帽子上印有字母M，而另一个较高的兄弟穿着绿色衣服，他的帽子上印有字母L。
那么它就给你画马里奥兄弟！

我自己测试了一下，不总是有用，但是出来了一张弟弟的照片

### 311

2023-12-31

https://x.com/dotey/status/1741214749348507935?s=20

宝玉
@dotey
\#AI开源项目推荐：janhq/jan

Jan 是一个帮助你在本地运行开源大模型的程序，支持Windows、Mac和Linux多平台，移动端即将推出，可以从它上面方便的下载并运行开源模型，并且能在本地提供一个兼容 ChatGPT API 协议的Web服务。

它提供了一个类似于ChatGPT的聊天界面，可以基于它聊天，并且可以保留聊天历史。

项目地址：https://github.com/janhq/jan


### 312

2023-12-31

https://x.com/dotey/status/1741205453948756123?s=20

宝玉
@dotey
彭博社推荐的：《2023年我们为未来而阅读的书籍》

1. 我看到的世界 — 李飞飞
2023

李飞飞，这位90年代初来美的年轻中国女性，当时几乎不懂英语，更别提计算机视觉了。她绝不会想到自己的工作将深刻推动我们进入当前的人工智能热潮。她的ImageNet项目，至今已标注了超过1400万张图片，为训练AI算法打下了基础，使得DeepMind和OpenAI这样的AI先锋公司得以崛起。

在《我看到的世界》一书中，李飞飞将自己的工作与个人经历紧密结合，讲述了她作为移民的奋斗历程以及成为领域内最受尊敬的人物之一的故事。如今，她是斯坦福大学人本人工智能研究所的联席主任，成为硅谷快速发展中代表人类立场的重要声音。她的故事不仅令人着迷，也让人感到谦逊。在我们寻找值得托付未来人工智能的领袖时，李飞飞的履历给人以极大的鼓舞。*Dave Lee*

### 313

2023-12-31

https://x.com/op7418/status/1741156079206277461?s=20

歸藏
@op7418
这个ComfyUI插件有点意思，可以在ComfyUI中调用GPT-4和DALL-E3，实现从图片提取提示词和用DALL-E3在ComfyUI中生成图片。

GPT-4从图片提取提示词可比WebUI自带的工具强多了，这下这些都能在ComfyUI中完成了。
不过这玩意填写OpenAI API有点麻烦，得配置一个环境变量。

插件主要包括两个节点：
Style Prompt：使用你的文本提示、图像或文本提示和图像，以及你指定的艺术风格，生成一个ChatGPT3或4的提示，Stable Diffusion可以使用该提示来以该风格生成一幅图像。

OAI Dall_e 3：接受提示和参数，并在ComfyUI中生成Dall_e3图像。

项目地址：https://github.com/glibsonoran/Plush-for-ComfyUI

### 314

2023-12-31

https://x.com/op7418/status/1741145662866206851?s=20

歸藏
@op7418
Lex Fridman的新播客采访了Guillaume Verdon，一位物理学家、量子计算研究员，也是 e/acc（有效加速主义）运动的创始人。每一期嘉宾都很重磅啊。

https://x.com/lexfridman/status/1740815481043320975?s=20

Lex Fridman
@lexfridman
Here's my conversation with Guillaume Verdon (
@GillVerd
) aka Beff Jezos (
@BasedBeffJezos
), a physicist, quantum computing researcher, and founder of e/acc (effective accelerationism) movement that advocates for rapid technological progress, physics-based reasoning, and memes.

Guillaume & Beff are two fascinating identities co-existing inside one human mind, recently merged.

And yes, I did talk to Jeff Bezos and Beff Jezos back-to-back on the podcast, because the most entertaining outcome is the most likely. Happy holidays! ❤

It's here on X in full, and is up on YouTube, Spotify, and everywhere else. Links in comment.

Timestamps:
0:00 - Introduction
2:23 - Beff Jezos
12:21 - Thermodynamics
18:36 - Doxxing
28:30 - Anonymous bots
35:58 - Power
38:29 - AI dangers
42:01 - Building AGI
50:14 - Merging with AI
57:56 - p(doom)
1:13:23 - Quantum machine learning
1:26:41 - Quantum computer
1:35:15 - Aliens
1:40:04 - Quantum gravity
1:45:25 - Kardashev scale
1:47:17 - Effective accelerationism (e/acc)
1:57:47 - Humor and memes
2:00:53 - Jeff Bezos
2:07:25 - Elon Musk
2:13:55 - Extropic
2:22:31 - Singularity and AGI
2:26:29 - AI doomers
2:27:54 - Effective altruism
2:34:23 - Day in the life
2:40:50 - Identity
2:43:40 - Advice for young people
2:45:42 - Mortality
2:49:25 - Meaning of life

### 315

2023-12-31

https://x.com/op7418/status/1741131954299212098?s=20

歸藏
@op7418
来了 第一个内容《AI图像生成器的工作原理以及扩散是什么》。
虽然是一年前的视频了但是非常浅显易懂，不涉及任何复杂和困难的算法概念。对AI图片生成原理感兴趣的可以看看。

### 316

2023-12-31

https://x.com/Yangyixxxx/status/1740963704051843296?s=20

Yangyi
@Yangyixxxx
仰望星空可以，但还是需要脚踏实地。
不要对AIGC有过多的期望，期望越大，失望越大。
能帮你省5%其实都很开心了。
天下难事，必做于易。期望大家都能聚焦到更小更垂直的地方去思考AI如何发挥效用，这样会收获更多惊喜。
