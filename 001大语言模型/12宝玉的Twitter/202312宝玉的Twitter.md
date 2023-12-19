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

### 117

2023-12-14

歸藏

@op7418

昨晚 AI 图像生成工具 Visual Electric 发布了两个非常强大的功能。

一个是可以将生成的多张图像组合进行重绘；

另一个是可以用几张图片快速自定义图像生成风格进行使用（类似 Lora 训练）。

将 AI 图像创作流程的门槛变的非常低。接下来我会用下面几张图的制作过程来演示教学一下这两个功能。

### 118

2023-12-14

宝玉

@dotey

现在最火的开源大语言模型当属 mixtral-8x7 了，已经有人基于它微调了一个完全无审查无防护的版本 dolphin-2.5-mixtral-8x7 ，再也不用担心：「作为一个 AI 助手，我不能……」

模型下载地址：

[ehartford/dolphin-2.5-mixtral-8x7b · Hugging Face](https://huggingface.co/ehartford/dolphin-2.5-mixtral-8x7b)

### 119

2023-12-14



### 120

2023-12-14
