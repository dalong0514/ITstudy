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

🔧而且他还开源了这个项目

GitHub：https://github.com/bbycroft/llm-viz

这个项目还有个 CPU 模拟（CPU Simulation）展示。

它提供了一个 2D 环境，你可以在其中编辑和模拟 CPU（中央处理单元）的工作原理。

你可以在这个编辑器中创建和修改数字电路，这些电路模拟了真实 CPU 的工作方式。

### 02

2023-12-03

语音到语音翻译 (S2ST) 是一种将口语从一种语言转换为另一种语言的机器翻译技术。

谷歌刚推出新一代的语音到语音翻译技术 Translatotron 3，它与前两代的不同在于是无监督学习的。传统的有监督学习，需要使用标记的训练数据，举例来说，你输入是英文音频，那么需要有配套的中文音频。这样数据的数量和质量很难上去。

但是对于无监督的语音到语音翻译（如 Translatotron 3）来说，模型不需要双语对照的数据集，而是从未标记的单语数据中学习如何将一种语言翻译成另一种语言。

### 03

2023-12-03

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

2023-12-03

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

2023-12-03

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

2023-12-03

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

2023-12-05

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

2023-12-05

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

2023-12-05

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

2023-12-05

自然杂志发表的一篇文章：《ChatGPT 一周年回顾：谁在使用它，用途有哪些，为什么受欢迎？》

在ChatGPT一周年之际，自然杂志采访了气味科学家，分享了他们关于ChatGPT正确与错误用法的认识与体会。

你可以看到有人很积极的使用它教学、写作和科研，但也有人担心它的幻觉，认为它加剧了社会偏见。

原文：ChatGPT one year on: who is using it, how and why?
https://nature.com/articles/d41586-023-03798-6

翻译：https://baoyu.io/translations/ai/chatgpt-one-year-on-who-is-using-it-how-and-why

### 13

2023-12-06

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

2023-12-06

Developing-Apps-with-GPT-4-and-ChatGPT

《Developing Apps with GPT-4 and ChatGPT》
不得不承认 O Reilly 是技术书籍出版的大哥大，已经整理出来了一本 《用 GPT-4 与 ChatGPT 完成应用开发》的书籍，Amazon 上面可以几十刀买一份实体书或者电子书，也可以在下面官网上注册账号免费读 10 天。

https://oreilly.com/library/view/developing-apps-with/9781098152475/

### 15

2023-12-06

@HiTw93

工程师学习逛 Github 发现有人整理 GPTs「泄露」的 prompt，哈哈哈哈有一种偷学咒语的感觉。

https://github.com/linexjlin/GPTs

### 16

2023-12-06

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

2023-12-06

Meta 和 IBM 正联合 40 多家公司和机构，共同成立一个专注于开源人工智能的行业组织，目的在于共享技术并减少相关风险。

这个名为 AI Alliance（AI 联盟）的组织，将着重于负责任地发展 AI 技术，其中包括安全性和防护工具，据周二发布的声明所述。该联盟还计划增加开源 AI 模型的数量，与此同时减少某些公司偏好的专有系统，发展新硬件，并与学术研究人员进行合作。

开源 AI 技术的倡导者认为，由开发者公开并供他人使用的技术，是培养高度复杂系统的一种更高效的方式。在过去几个月里，Meta 已经发布了其大语言模型（Large Language Model，LLM）的开源版本，这些模型是 AI 聊天机器人的核心基础。

Meta 全球事务总裁 Nick Clegg 在声明中表示：「我们相信，公开开发 AI 会更好 —— 这样更多人能够享受到其带来的好处，创造创新产品，并致力于确保安全。」

该联盟将最终成立一个管理委员会和技术监督委员会。参与单位包括 Oracle Corp.（甲骨文公司）、Advanced Micro Devices Inc.（AMD）、Intel Corp.（英特尔公司）和 Stability AI，还有像圣母大学（University of Notre Dame）和马萨诸塞开放云联盟（Mass Open Cloud Alliance）这样的学术研究机构。

最近，OpenAI—— 即 ChatGPT 的开发者 —— 因解雇并重新聘请其知名首席执行官而引发了一场全球性的辩论，关注点在于企业在开发强大的 AI 技术时应保持多大的透明度。值得注意的是，OpenAI 并未列为 AI 联盟的成员之一。

AI Alliance 官网：https://thealliance.ai

新闻来源：https://bloomberg.com/news/articles/2023-12-05/nvidia-plans-network-of-chip-plants-in-japan-to-meet-ai-demand

### 18

2023-12-06

「LLMs 主要是重复以往有效的做法 —— 这对表现不佳的人来说是个很好的学习机会，但对于表现优秀的人来说，这些他们早已熟知。如果你给每个人都配备一根拐杖，这对行动缓慢的人来说帮助最大。但对于像 Usain Bolt 这样的快跑者，拐杖不仅没多大帮助，甚至可能成为阻碍。」

这是目前的情况。但不久的将来，我们将不再是分发拐杖，而是要推出喷气背包。到那时，问题不再是如何追赶，而是开启一场全新的竞赛。教育和整体智商的重要性将大打折扣，就像 Usain Bolt 的速度在对手也装备了喷气背包的情况下变得不那么关键。你可能不相信我，但你应该相信 Ilya：

如果你认为智力是所有人类品质中最为重要的，那么你可能会面临一些挑战。

—— Ilya Sutskever

@ilyasut

10 月 7 日

if you value intelligence above all other human qualities, you're gonna have a bad time.

### 19

2023-12-06

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

2023-12-06

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

2023-12-06

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

2023-12-06

\#AI 开源项目推荐：MLX

苹果刚刚发布了一个专门为苹果芯片定制的神经网络框架 MLX，类似于 PyTorch ，但是是针对苹果 M 系列芯片定制的。

MLX 的亮点在于设计了一个对于深度学习用户易于上手的 API，并包含一些经典案例，比如 Llama、LoRa、Stable Diffusion 和 Whisper！

看来不需要再用 whisper.cpp、llama.cpp 这种靠 CPU 运行的框架了。

MLX 源代码：http://github.com/ml-explore/mlx

### 23

2023-12-06

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

2023-12-06

Stripe Press 把芒格的《穷查理宝典》做了一个超级酷的电子版，可看、可听、可动还全免费！https://stripe.press/poor-charlies-almanack

一家做支付 API 的公司，如何让自己显得有品位？那就是干出版 http://press.stripe.com 的选品相当不错📖 记得以前 Ping++ 总结过 Stripe 成功的五个基本条件：

1. 开发者作为支付服务采购者阶层；

2. 大量中长尾客群的存在；

3. 基于 Visa 和 MasterCard 营造的高利润支付生态；

4. 没有工程师红利的欧美社会；

5. 贸易文明主宰下的企业协同文化；

### 25

2023-12-06

复旦大学张奇教授团队写了一本在线免费的电子书，《大规模语言模型：从理论到实践》，https://intro-llm.github.io，大概有 300 页篇幅，将大模型从理论到实战的每个阶段都描述的较为清楚。

全文在线阅读地址：https://intro-llm.github.io/chapter/LLM-TAP.pdf

2『已下载书籍「2023011大规模语言模型从理论到实践」。（2023-12-09）』

### 26

2023-12-06

压缩视频的大模型产品。

This video was compressed by CompressX from 2.6MB to 0.4MB

I made this app to compress video size while still maintaining good quality. You can download it for free at http://hieudinh.com/compressx

### 27

2023-12-06

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

2023-12-07

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

2023-12-07

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

2023-12-07

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

2023-12-07

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

2023-12-07

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
 
2023-12-08

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

2023-12-09

这个小姐姐的博客上的内容质量很高。

Leonie

@helloiamleonie

1『已经关注了。（2023-12-09）』

### 40

2023-12-09

一本还在写作中的在线免费电子书：《数据工程设计模式 | Data Engineering Design Patterns (DEDP)》

主要和大数据相关：

[About this Book - 📖 Data Engineering Design Patterns (DEDP)](https://dedp.online/about-this-book.html)

### 41

2023-12-09

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

2023-12-09




### 43

2023-12-09




### 44

2023-12-09



### 45

2023-12-09






