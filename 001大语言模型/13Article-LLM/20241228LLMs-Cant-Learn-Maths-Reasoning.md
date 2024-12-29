## 20241228LLMs-Cant-Learn-Maths-Reasoning

[LLMs Can’t Learn Maths & Reasoning, Finally Proved! | by Vishal Rajput | AIGuys | Dec, 2024 | Medium](https://medium.com/aiguys/llms-cant-learn-maths-reasoning-finally-proved-ed878770227b)

Vishal Rajput

Dec 16, 2024

The age-old question regarding LLMs: Do large language models (LLMs) solve reasoning tasks by learning robust generalizable algorithms, or do they memorize training data?

关于大型语言模型（LLM）的一个古老问题是：它们在解决推理任务时，究竟是通过学习稳健且可泛化的算法，还是仅仅在记忆训练数据？

To investigate this question, recently a paper used arithmetic reasoning as a representative task. Using causal analysis, they identified a subset of the model (a circuit) that explains most of the model's behavior for basic arithmetic logic and examined its functionality. Now we finally have the answer to how LLMs solve maths and reasoning tasks.

为了探究这个问题，最近有一篇论文以算术推理作为代表性任务。他们使用因果分析的方法，找到了模型中能够解释大部分基本算术逻辑行为的一个子集（一个电路），并对其功能进行了研究。如今，我们终于得到了关于 LLM 如何解决数学和推理任务的答案。

So, without further ado, let's break down these new papers on Algorithmic reasoning.

废话不多说，让我们来一起分解这些关于算法推理的新论文。

### Defining Reasoning

定义「推理」

In his 2019 paper "On the Measure of Intelligence," François Chollet defines intelligence as "skill-acquisition efficiency," emphasizing the importance of generalization and adaptability over mere task-specific performance.

在 2019 年的论文《On the Measure of Intelligence》中，François Chollet 将「智能」定义为「技能获取效率」，强调了泛化与适应性的重要性，而不仅仅是针对某一特定任务的表现。

For computers to make progress toward more intelligent and human-like systems they need to reason and move towards Artificial General Intelligence or AGI. We need to create systems with appropriate feedback mechanisms. But to do that first we need to define and evaluate intelligence.

要让计算机在迈向更智能、更类似人类的系统方面取得进展，就需要能够进行推理并逐步走向通用人工智能（AGI）。为此，我们需要构建带有合适反馈机制的系统。但在此之前，必须先定义并评估「智能」。

These definitions and evaluations turn into benchmarks to measure progress toward systems that can think and invent alongside us.

这些定义和评估会转化为各种基准，用来衡量一个系统是否具有与我们并肩思考与创造的能力。

A consensus definition of AGI, "a system that can automate the majority of economically valuable work," while a useful goal, is an incorrect measure of intelligence.

一个共识性的 AGI 定义是「能自动化大部分具有经济价值工作的系统」，这虽然是一个有用的目标，却并不能正确衡量智能。

But here is the deal with AGI, Measuring task-specific skills is not a good proxy for intelligence.

但在 AGI 问题上，衡量特定任务技能并不能很好地代理「智能」的概念。

Skills are heavily influenced by prior knowledge and experience: unlimited priors or unlimited training data allow developers to "buy" levels of skill for a system. This masks a system's own generalization power. The argument followed here is called the Chinese room argument.

技能很大程度上受到先验知识和经验的影响：如果先验或训练数据不受限制，开发者就可以通过「堆砌」训练来提升系统在某项技能上的水平。这会掩盖一个系统自身的泛化能力。这方面的论点也称为「中文房间」论证。

Current systems mimic a particular behavior but they fail miserably on novel problems, thus failing to generalize. Memorizing the trick is not general intelligence, coming up with a trick to solve a new problem is.

当前系统往往只是在模仿特定行为，但在遇到新的问题时却表现糟糕，无法完成泛化。仅仅记住技巧并不代表通用智能，而能在新问题上想出新方法才是。

Traditional AI benchmarks focus solely on skill levels in specific tasks, such measures can be misleading due to the influence of prior knowledge and extensive training data. Instead, evaluating intelligence and reasoning should based on how efficiently a system can acquire new skills across a broad range of tasks, considering factors like prior knowledge, experience, and the difficulty of generalization.

传统的 AI 基准往往只关注在特定任务上达到的技能水平，但由于先验知识和大量训练数据的影响，这种衡量方式往往具有误导性。相反，对智能和推理的评估应该基于系统在一系列任务上获取新技能的效率，同时还要考虑系统在使用先验知识、积累经验，以及应对不同泛化难度时的表现。

Fig: Chinese room argument

Intelligence lies in broad or general-purpose abilities; it is marked by skill acquisition and generalization, rather than skill itself.

智能体现于广泛或通用的能力；它的标志是技能获取与泛化能力，而不只是技能本身。

AGI is a system that can efficiently acquire new skills outside of its training data.

AGI 是一种能够在训练数据之外高效获取新技能的系统。

Let's define it formally:

让我们用 François Chollet 在《On the Measure of Intelligence》中的话对其进行形式化定义：

The intelligence of a system is a measure of its skill-acquisition efficiency over a scope of tasks, with respect to priors, experience, and generalization difficulty. — François Chollet, "On the Measure of Intelligence"

> 系统的智能，是指它在一定范围内（特定任务集）相对于先验、经验和泛化难度而言，其技能获取效率的度量。

A System that is able to adapt to a new environment that it has not seen before and that its creators (developers) did not anticipate. And that's where a reasoning system comes in, a system that looks at a particular situation and uses all of its abstraction to solve a given task in a novel way.

一个能够适应全新环境的系统，就是其在实际环境中尚未见过、且其创造者（开发者）也未曾预想到的环境中依然可以良好运转的系统。而这就需要一个真正能够进行推理的系统：它能够针对特定情况，运用各种抽象能力，以全新的方式来解决给定任务。

[[1911.01547] On the Measure of Intelligence](https://arxiv.org/abs/1911.01547)

### Types Of Reasoning

推理的类型

Reasoning is the process by which systems draw conclusions, make predictions, or construct solutions based on existing knowledge. It enables a system to emulate human-like decision-making and problem-solving capabilities. Reasoning in AI is typically categorized into several types:

推理是指系统基于已有知识得出结论、进行预测或构建解决方案的过程。它使系统具备类似人类的决策和问题解决能力。AI 中的推理通常可分为以下几种类型：

Deductive Reasoning: Deriving specific conclusions from general premises. If the premises are true, the conclusion must also be true. For example:

演绎推理（Deductive Reasoning）：从一般前提推导出具体结论。如果前提为真，则结论必然为真。例如：

Premise 1: All humans are mortal.

Premise 2: Socrates is a human.

Conclusion: Socrates is mortal.

前提 1：所有人都会死。

前提 2：苏格拉底是人。

结论：苏格拉底会死。

Inductive Reasoning: Inferring generalizations from specific observations. Conclusions are probable but not guaranteed. For example:

归纳推理（Inductive Reasoning）：从具体观察中推断一般性结论。结论具有一定概率，但不保证绝对正确。例如：

Observation: The sun has risen in the east every day observed.

Conclusion: The sun always rises in the east.

观察：所观测的每一天，太阳都从东方升起。

结论：太阳总是从东方升起。

Abductive Reasoning: Forming the most likely explanation from incomplete observations. It involves hypothesizing causes for certain effects. For example:

溯因推理（Abductive Reasoning）：在不完整的观察基础上，提出最有可能的解释。它涉及对特定结果可能成因的假设。例如：

Observation: The ground is wet.

Possible Explanation: It rained recently.

观察：地面是湿的。

可能的解释：刚刚下过雨。

Common Sense Reasoning: Applying everyday knowledge and experience to make presumptions about typical situations, enabling understanding and interaction in a human-like manner.

常识推理（Common Sense Reasoning）：基于日常知识和经验，对常见情境进行推断，使系统能像人一样理解和互动。

Monotonic and Non-monotonic Reasoning:

单调与非单调推理（Monotonic and Non-monotonic Reasoning）

Monotonic: Adding new information doesn't change existing conclusions.

单调推理（Monotonic）：添加新信息并不会改变已有的结论。

Non-monotonic: New information can alter previous conclusions, reflecting more realistic human reasoning.

非单调推理（Non-monotonic）：新的信息可能改变先前的结论，更贴近现实中人类的推理方式。

To be fair identifying whether a system is responding from memorization or generalization is very hard.

要想确定一个系统是通过记忆还是通过泛化来响应，其实很困难。

In principle, LLMs struggle with all the above types of reasoning, but the degree of their strength for each category is different. For some, it struggles more and for some, it is less.

理论上，LLM 在上述所有类型的推理上都存在一定困难，但在每个类别上的强弱程度不同。对于某些类型，它们会表现得更差，而对于另一些则相对好一些。

Among these types of reasoning, LLMs struggle most with Non-monotonic and Common Sense reasoning.

在这些推理类型中，LLM 在非单调推理和常识推理方面最为吃力。

Non-monotonic Reasoning is particularly challenging for LLMs because:

为什么非单调推理（Non-monotonic Reasoning）对 LLM 来说尤其困难？

1 Their architecture is fundamentally based on pattern recognition and probabilistic relationships in their training data

模型架构主要基于对训练数据中的模式识别和概率关系。

2 They lack the ability to properly revise and update their knowledge base when new information contradicts previous conclusions

当新信息与之前的结论相矛盾时，它们缺乏合适的机制来及时修正和更新知识库。

3 They tend to maintain static relationships between concepts rather than dynamically adjusting their reasoning based on new context

模型往往保持概念之间的静态关系，而无法基于新上下文动态调整推理过程。

Common Sense Reasoning is also a major weakness because:

为什么常识推理（Common Sense Reasoning）也是主要弱点？

1 LLMs don't truly understand causality or physical world constraints

LLM 并不真正理解因果关系或物理世界中的各种约束。

2 They lack experiential knowledge and a genuine understanding of how the world works

它们缺乏真实的体验性知识，也无法真正理解世界的运作方式。

3 They often fail at simple physical reasoning tasks that humans find trivial

在人类看来微不足道的简单物理推理任务上，LLM 往往失败。

4 They struggle to integrate multiple pieces of common sense knowledge to reach obvious conclusions

它们难以整合多条常识性知识来得出显而易见的结论。

Out of all, LLMs can perform relatively well at Deductive Reasoning when the premises and rules are clearly stated

在所有类型当中，只要前提和规则清晰地陈述，LLM 在演绎推理（Deductive Reasoning）上的表现相对较好。

### Understanding Heuristics

理解启发式方法（Heuristics）

We must understand heuristics to understand what LLMs are actually doing. Heuristics are the key to the black-box nature of LLMs. Generally they are defined as:

要想弄清 LLM 实际在做什么，就必须了解启发式方法。启发式方法是解开 LLM「黑箱」本质的关键。它通常定义为：

Heuristics are mental shortcuts for solving problems in a quick way that delivers a result that is sufficient enough to be useful given time constraints.

启发式方法是指在时间有限的情况下，为快速求解问题而采取的「足够好」但不一定完美的思维捷径。

But in computer science, they are defined in a more formal manner.

在计算机科学中，它有更形式化的定义：

1 Heuristics is making use of experience to find a solution to a problem quickly

启发式方法利用已有经验快速解决问题。

2 It uses concepts like 'rules of thumb' and 'educated guesses' to find a solution faster than traditional methods

通过使用「经验法则」和「合理猜测」来比传统方法更快地找到可行解。

3 It prioritises speed and not accuracy

它优先追求速度而非准确性。

4 It aims to find a solution that is 'good enough' rather than perfect.

它的目标是找到一个「足够好」的解决方案，而不一定是最优解。

Heuristics will not guarantee that you will find the ‘best' solution as it aims to find a solution quickly that is ‘good enough.'

因此，启发式方法并不保证一定能找到「最佳」解，它更关注在可接受时间内找到一个「足够好」的解。

Let's go a bit more technical and look at some good heuristic search algorithms.

我们来看看一些较为著名的启发式搜索算法。

1 A Search Algorithm

搜索算法（Search Algorithm）

A* Search Algorithm is perhaps the most well-known heuristic search algorithm. It uses a best-first search and finds the least-cost path from a given initial node to a target node. It has a heuristic function, often denoted as f(n)=g(n)+h(n)f(n)=g(n)+h(n), where g(n) is the cost from the start node to n, and h(n) is a heuristic that estimates the cost of the cheapest path from n to the goal. A* is widely used in pathfinding and graph traversal.

A* 搜索算法可能是最广为人知的启发式搜索算法。它采用最佳优先搜索（best-first search），并在给定初始节点和目标节点之间寻找代价最小的路径。它使用启发式函数 \( f(n)=g(n)+h(n) \)，其中 \( g(n) \) 是从起始节点到当前节点 n 的已花费代价，\( h(n) \) 则估计从节点 n 到目标的最便宜路径。A* 广泛应用于路径寻找和图遍历。

2 Greedy Best-First Search

贪婪最佳优先搜索（Greedy Best-First Search）

Greedy best-first search expands the node that is closest to the goal, as estimated by a heuristic function. Unlike A*, which takes into account the cost of the path from the start node to the current node, the greedy best-first search only prioritizes the estimated cost from the current node to the goal. This makes it faster but less optimal than A*.

贪婪最佳优先搜索根据启发式函数估计离目标最近的节点进行扩展。与 A* 不同的是，它只关注当前节点到目标的估计代价，而不考虑从起始节点到当前节点的成本。这样做速度更快，但往往没有 A* 那么优。

3 Hill Climbing

爬山算法（Hill Climbing）

Hill climbing is a heuristic search used for mathematical optimization problems. It is a variant of the gradient ascent method. Starting from a random point, the algorithm takes steps in the direction of increasing elevation or value to find the peak of the mountain or the optimal solution to the problem. However, it may settle for a local maximum and not reach the global maximum.

爬山算法是一种用于数学优化问题的启发式搜索方法，它是梯度上升的一种变体。算法从随机点开始，朝着「海拔」或数值更高的方向移动，从而找到「山峰」或问题的最优解。然而，它可能会停留在局部最大值而无法到达全局最大值。

### Breaking Down Black-Box AI Internals

拆解黑箱 AI 的内部机制

In order to understand black-box nature of AI, researchers did as following:

为了研究 AI 的黑箱本质，研究者做了以下工作：

They identified a small number of neurons within neural networks that each apply simple heuristics to recognize specific numerical input patterns and produce corresponding outputs. These neurons can be categorized based on the types of heuristics they implement, such as activating when an operand falls within a certain range.

他们在神经网络内部找到了少数几个使用简单启发式方法的神经元，这些神经元能识别特定的数值输入模式，并产生相应的输出。可以根据它们执行的不同启发式方法进行分类，比如当操作数在某个数值区间时便激活。

The collective function of these heuristic neurons accounts for the majority of the model's accuracy in arithmetic tasks. This mechanism emerges early in the training process and remains a primary contributor to the model's arithmetic performance.

这些启发式神经元的整体功能决定了模型在算术任务中大部分的准确度。这种机制在训练初期就会出现，并在整个训练中一直是模型算术能力的主要贡献来源。

How do they identify the specific neurons that are applying simple heuristics, read the following article to know more about it:

如果想了解他们是如何识别这些执行简单启发式方法的神经元，请参考以下文章：

[Claude 3: Extracting Interpretable Features | AIGuys](https://medium.com/aiguys/claude-3-extracting-interpretable-features-6a89da46c111)

Sparse Autoencoders are usually used to identify important neruons

通常会用稀疏自编码器（Sparse Autoencoders）来识别这些重要神经元

[[2410.21272] Arithmetic Without Algorithms: Language Models Solve Math With a Bag of Heuristics](https://arxiv.org/abs/2410.21272)

Circuit Discovery

电路发现（Circuit Discovery）

A minimal subset of neural components, termed the "arithmetic circuit," performs the necessary computations for arithmetic. This includes MLP layers and a small number of attention heads that transfer operand and operator information to predict the correct output.

在神经网络中，最小的一组神经组件被称为「算术电路」（arithmetic circuit），它们完成了算术所需的核心计算。其中包括多层感知器（MLP）层，以及在算出正确答案时负责传递操作数和运算符信息的少量注意力头（attention heads）。

First, we establish our foundational model by selecting an appropriate pre-trained transformer-based language model like GPT, Llama, or Pythia.

首先，我们从预训练的基于 Transformer 的语言模型（如 GPT、Llama 或 Pythia）中选择一个合适的模型作为基础。

Next, we define a specific arithmetic task we want to study, such as basic operations (+, -, ×, ÷). We need to make sure that the numbers we work with can be properly tokenized by our model.

然后，确定我们要研究的具体算术任务（例如四则运算：+、-、×、÷），并确保模型能够正确对相关数字进行分词。

We need to create a diverse dataset of arithmetic problems that span different operations and number ranges. For example, we should include prompts like "226–68 =" alongside various other calculations. To understand what makes the model succeed, we focus our analysis on problems the model solves correctly.

接下来，我们构建一个多样化的数据集，覆盖不同运算和数值范围。比如，在「226–68 =」之类的提示之外，还包含更多样化的题目。为了理解模型成功的原因，我们主要聚焦于那些模型能正确解答的问题。

The core of our analysis will use activation patching to identify which model components are essential for arithmetic operations.

分析的核心是使用激活修补（activation patching），以确定模型中哪些组件对算术操作至关重要。

This technique works by running our model on two different problems and systematically comparing their internal behaviors. Take a target problem (p) and a different, counterfactual problem (p'). Record the model's internal activations for both, then selectively replace components from p with those from p' to see what breaks the model's ability to solve the original problem.

激活修补（Activation Patching）的工作原理：在两个不同的问题（一个目标问题 p 和一个对照问题 p'）上运行模型并记录它们的内部激活。然后，逐步用 p' 的部分激活替换 p 的激活，看模型对原问题的解题能力是否因此「破坏」。

To quantify the impact of these interventions, we use a probability shift metric that compares how the model's confidence in different answers changes when you patch different components. The formula for this metric considers both the pre- and post-intervention probabilities of the correct and incorrect answers, giving us a clear measure of each component's importance.

我们使用「概率偏移」（probability shift）度量来量化这些干预措施的影响，比较修补前后模型对正确答案和错误答案的置信度变化。

[[2410.21272] Arithmetic Without Algorithms: Language Models Solve Math With a Bag of Heuristics](https://arxiv.org/abs/2410.21272)

Once we've identified the key components, map out the arithmetic circuit. Look for MLPs that encode mathematical patterns and attention heads that coordinate information flow between numbers and operators. Some MLPs might recognize specific number ranges, while attention heads often help connect operands to their operations.

通过识别关键组件，我们可以勾勒出算术电路的结构：哪些 MLP 编码了数学模式，哪些注意力头负责在操作数和运算符之间进行信息关联。有些 MLP 可能识别特定数值范围，而注意力头往往帮助操作数与它们的运算之间建立连接。

Then we test our findings by measuring the circuit's faithfulness — how well it reproduces the full model's behavior in isolation. We use normalized metrics to ensure we're capturing the circuit's true contribution relative to the full model and a baseline where components are ablated.

最后，我们通过测量电路的「保真度」（faithfulness）来验证这一发现 —— 考察在只保留这些关键组件的情况下，能否在多大程度上重现完整模型的行为。我们会使用标准化指标，确保捕捉到电路相对于完整模型的实际贡献，并与只保留基线组件的情况进行对比。

So, what exactly did we find?

我们到底发现了什么？

Some neurons might handle particular value ranges, while others deal with mathematical properties like modular arithmetic. This temporal analysis reveals how arithmetic capabilities emerge and evolve.

有些神经元可能处理特定的数值区间，另一些则处理像模运算这类数学属性。这种对算术能力的时间序列分析表明，这些算术功能是如何出现并逐步演化的。

### Mathematical Circuits

数学电路（Mathematical Circuits）

The arithmetic processing is primarily concentrated in middle and late-layer MLPs, with these components showing the strongest activation patterns during numerical computations. Interestingly, these MLPs focus their computational work at the final token position where the answer is generated. Only a small subset of attention heads participate in the process, primarily serving to route operand and operator information to the relevant MLPs.

算术运算主要集中在网络的中后层 MLP 中，这些组件在数字计算时会呈现最强烈的激活模式。有趣的是，这些 MLP 主要在生成答案的最终词元（token）位置执行计算工作。只有少量注意力头（attention heads）参与其中，主要作用是将操作数和运算符信息路由到相应的 MLP。

The identified arithmetic circuit demonstrates remarkable faithfulness metrics, explaining 96% of the model's arithmetic accuracy. This high performance is achieved through a surprisingly sparse utilization of the network — approximately 1.5% of neurons per layer are sufficient to maintain high arithmetic accuracy. These critical neurons are predominantly found in middle-to-late MLP layers.

研究人员发现，这种「算术电路」展现了高度的保真度（faithfulness），能解释模型 96% 的算术准确率。令人惊讶的是，这种高性能只依赖网络中极少量的结构 —— 每层大约仅 1.5% 的神经元就足以维持高水平的算术准确率。这些关键神经元主要分布在模型中后阶段的 MLP 层。

Detailed analysis reveals that individual MLP neurons implement distinct computational heuristics. These neurons show specialized activation patterns for specific operand ranges and arithmetic operations. The model employs what we term a "bag of heuristics" mechanism, where multiple independent heuristic computations combine to boost the probability of the correct answer.

深入分析表明，单个 MLP 神经元会实施不同的计算启发式方法（heuristics）。它们对特定操作数区间或算术运算表现出专门的激活模式。模型采用了我们所称的「启发式组合」（bag of heuristics）机制：多个相互独立的启发式计算结果相互结合，从而提高正确答案的概率。

We can categorize these neurons into two main types:

我们可以将这些神经元分为两大类：

1 Direct heuristic neurons that directly contribute to result token probabilities.

直接启发式神经元（Direct heuristic neurons）：直接影响结果词元的概率。

2 Indirect heuristic neurons that compute intermediate features for other components.

间接启发式神经元（Indirect heuristic neurons）：为其他组件计算中间特征。

The emergence of arithmetic capabilities follows a clear developmental trajectory. The "bag of heuristics" mechanism appears early in training and evolves gradually. Most notably, the heuristics identified in the final checkpoint are present throughout training, suggesting they represent fundamental computational patterns rather than artifacts of late-stage optimization.

算术能力的出现遵循一条清晰的演化轨迹。「启发式组合」机制在训练早期就已出现，并会逐步演进。值得注意的是，最终检查点（final checkpoint）中所识别的启发式方法在整个训练过程中都存在，这表明它们是基础的计算模式，而非在训练后期才出现的偶然产物。

### Understanding Circuits In More Details

更深入理解电路

Inside the Neural Network: A Step-by-Step Process

在神经网络内部：一步步的过程

Initial Processing When the model sees "226–68 =", several things happen simultaneously:

初始处理，当模型看到「226–68 =」时，会有多项处理同时进行：

The numbers and operator are tokenized.

首先对数字和运算符进行分词（tokenize）。

Multiple attention heads activate to route this information to specific MLPs.

多个注意力头被激活，将这些信息传递给特定的 MLP。

Different neuron groups begin their specialized tasks.

不同的神经元组开始执行各自的专项任务。

The "Bag of Heuristics" in Action Let's say the model has several neuron groups that each contribute to finding the answer (158). Here's how they might work:

「启发式组合」在行动，假设模型中有若干组神经元，它们都为求解答案（158）贡献力量。它们可能的工作方式如下：

If we changed the problem to "1226–68", we might see the model fail because:

如果我们将题目改为「1226–68」，模型可能无法正确求解，原因可能包括：

The neurons trained on smaller numbers might not activate properly.

针对较小数字训练的神经元无法正常激活。

The "bag of heuristics" might not have enough examples of 4-digit numbers.

「启发式组合」没有足够的四位数样本来支撑推理。

The attention patterns might get confused by the extra digit.

额外的数字会让注意力模式出现混淆。

### Conclusion

This changes everything, I already had a hunch on this. I have been writing about AI explainability for a while now. And it confirms my doubts, that no matter how much data you give, it will not learn the reasoning, it will always approximate the reasoning. Simply, transformer-based architecture in the end is an efficient way to solve any problem as a bunch of sophisticated heuristics. There are other papers that I've discussed in the past that align with this new theory.

这一发现改变了一切。我之前就有这种直觉，我一直在写与 AI 可解释性相关的内容。如今它证实了我的怀疑：无论给模型多少数据，它也不会真正「学会」推理，只是不断逼近推理。简而言之，基于 Transformer 的架构最终只是用一系列复杂的启发式方法来高效解决问题。过去我讨论过的其他论文也与这一新理论不谋而合。