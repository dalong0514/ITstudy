## 20231118LLM-Powered-Autonomous-Agents

[LLM Powered Autonomous Agents | Lil'Log](https://lilianweng.github.io/posts/2023-06-23-agent/#:~:text=,the%20quality%20of%20final%20results)

Building agents with LLM (large language model) as its core controller is a cool concept. Several proof-of-concepts demos, such as AutoGPT, GPT-Engineer and BabyAGI, serve as inspiring examples. The potentiality of LLM extends beyond generating well-written copies, stories, essays and programs; it can be framed as a powerful general problem solver.

[Significant-Gravitas/AutoGPT: An experimental open-source attempt to make GPT-4 fully autonomous.](https://github.com/Significant-Gravitas/AutoGPT)

[AntonOsika/gpt-engineer: Specify what you want it to build, the AI asks for clarification, and then builds it.](https://github.com/AntonOsika/gpt-engineer)

[yoheinakajima/babyagi](https://github.com/yoheinakajima/babyagi)

Direct Translation

**使用大型语言模型作为核心控制器的智能体构建**

构建以大型语言模型（LLM）为核心控制器的智能体是一个很酷的概念。例如 AutoGPT、GPT-Engineer 和 BabyAGI 等几个概念验证演示，都是令人启发的例子。大型语言模型的潜力不仅限于生成书面语、故事、文章和程序；它可以被框架为一个强大的通用问题解决器。

---

Rephrased Translation

**基于大型语言模型的智能体构建简述**

利用大型语言模型（LLM）作为主控制器来构建智能体是一个非常前沿的想法。像 AutoGPT、GPT-Engineer 和 BabyAGI 这样的实验性演示项目，展示了这一概念的启发性。大型语言模型的能力远超过创造文本、故事、文章和编程；它还可以作为一个强大的通用问题解决工具。

### 00. Agent System Overview

In a LLM-powered autonomous agent system, LLM functions as the agent’s brain, complemented by several key components:

Planning

Subgoal and decomposition: The agent breaks down large tasks into smaller, manageable subgoals, enabling efficient handling of complex tasks.

Reflection and refinement: The agent can do self-criticism and self-reflection over past actions, learn from mistakes and refine them for future steps, thereby improving the quality of final results.

Memory

Short-term memory: I would consider all the in-context learning (See Prompt Engineering) as utilizing short-term memory of the model to learn.

Long-term memory: This provides the agent with the capability to retain and recall (infinite) information over extended periods, often by leveraging an external vector store and fast retrieval.

Tool use

The agent learns to call external APIs for extra information that is missing from the model weights (often hard to change after pre-training), including current information, code execution capability, access to proprietary information sources and more.

Fig. 1. Overview of a LLM-powered autonomous agent system.

[Prompt Engineering | Lil'Log](https://lilianweng.github.io/posts/2023-03-15-prompt-engineering/)

Direct Translation

**智能体系统概览**

在一个由大型语言模型驱动的自主智能体系统中，LLM 充当智能体的大脑，并辅以几个关键组成部分：

- 规划

- 子目标与分解：智能体将大型任务分解为更小、可管理的子目标，从而有效处理复杂任务。

- 反思与改进：智能体能对过去的行动进行自我批评和自我反思，从错误中学习，并为未来的步骤改进，从而提高最终结果的质量。

- 记忆

- 短期记忆：我认为所有的上下文学习（见提示工程）都是利用模型的短期记忆来学习。

- 长期记忆：这使智能体能够在长时间内保留和回忆（无限的）信息，通常是通过利用外部向量存储和快速检索来实现的。

- 工具使用

- 智能体学会调用外部 API 以获取模型权重中缺失的额外信息（在预训练后通常难以更改），包括当前信息、代码执行能力、访问专有信息源等。

---

Rephrased Translation

**智能体系统概述**

在一个以大型语言模型为驱动的自动智能体系统中，LLM 扮演着智能体的「大脑」角色，并包含几个关键部分：

- 规划

- 子目标和分解：智能体把复杂任务分解成更小、易于管理的子目标，以高效处理。

- 反思和改良：智能体能自我反思和批评以往行为，通过学习错误并对未来的行动进行改进，提高最终成果的质量。

- 记忆

- 短期记忆：我认为模型利用的上下文学习（参见提示工程）可以看作是短期记忆的应用。

- 长期记忆：这使智能体能够长期保留和回想（无限的）信息，通常依赖于外部向量存储和快速检索机制。

- 工具使用

- 智能体学会调用外部 API，获取模型权重中缺失的额外信息，这些信息往往在预训练后难以修改，包括最新信息、代码执行能力、访问专有信息源等。

图 1. 由 LLM 驱动的自主代理系统概览。

### 01. Component One: Planning

A complicated task usually involves many steps. An agent needs to know what they are and plan ahead.

#### 1.1 Task Decomposition

Chain of thought (CoT; Wei et al. 2022) has become a standard prompting technique for enhancing model performance on complex tasks. The model is instructed to「think step by step」to utilize more test-time computation to decompose hard tasks into smaller and simpler steps. CoT transforms big tasks into multiple manageable tasks and shed lights into an interpretation of the model's thinking process.

Tree of Thoughts (Yao et al. 2023) extends CoT by exploring multiple reasoning possibilities at each step. It first decomposes the problem into multiple thought steps and generates multiple thoughts per step, creating a tree structure. The search process can be BFS (breadth-first search) or DFS (depth-first search) with each state evaluated by a classifier (via a prompt) or majority vote.

Task decomposition can be done (1) by LLM with simple prompting like "Steps for XYZ.\n1.", "What are the subgoals for achieving XYZ?", (2) by using task-specific instructions; e.g. "Write a story outline." for writing a novel, or (3) with human inputs.

Another quite distinct approach, LLM+P (Liu et al. 2023), involves relying on an external classical planner to do long-horizon planning. This approach utilizes the Planning Domain Definition Language (PDDL) as an intermediate interface to describe the planning problem. In this process, LLM (1) translates the problem into「Problem PDDL」, then (2) requests a classical planner to generate a PDDL plan based on an existing「Domain PDDL」, and finally (3) translates the PDDL plan back into natural language. Essentially, the planning step is outsourced to an external tool, assuming the availability of domain-specific PDDL and a suitable planner which is common in certain robotic setups but not in many other domains.

[[2201.11903] Chain-of-Thought Prompting Elicits Reasoning in Large Language Models](https://arxiv.org/abs/2201.11903)

[[2305.10601] Tree of Thoughts: Deliberate Problem Solving with Large Language Models](https://arxiv.org/abs/2305.10601)

[[2304.11477] LLM+P: Empowering Large Language Models with Optimal Planning Proficiency](https://arxiv.org/abs/2304.11477)

Direct Translation

一个复杂的任务通常涉及许多步骤。智能体需要知道这些步骤并提前规划。

1.1 任务分解

思维链（Chain of thought, CoT; Wei 等人，2022 年）已成为增强模型在复杂任务上表现的标准提示技术。该模型被指导以「一步一步思考」的方式，利用更多的测试时计算来将困难任务分解成更小、更简单的步骤。CoT 将大任务转化为多个可管理的任务，并为模型思维过程的解释提供了一些启示。

思维树（Tree of Thoughts, Yao 等人，2023 年）通过在每个步骤探索多种推理可能性，对 CoT 进行了扩展。它首先将问题分解为多个思维步骤，并在每个步骤产生多个思维，创建一个树状结构。搜索过程可以是 BFS（广度优先搜索）或 DFS（深度优先搜索），每个状态通过分类器（通过提示）或多数投票评估。

任务分解可以通过以下方式完成：（1）通过 LLM 简单提示，如「XYZ 的步骤。\n1.」、「为实现 XYZ 的子目标是什么？」，（2）使用特定于任务的指令；例如，为写小说而「写一个故事大纲」，或（3）通过人类输入。

另一种截然不同的方法是 LLM+P（Liu 等人，2023 年），它依赖于外部经典计划器来进行长期规划。这种方法使用规划领域定义语言（PDDL）作为中间接口来描述规划问题。在这个过程中，LLM（1）将问题翻译成「问题 PDDL」，然后（2）请求一个经典计划器基于现有的「领域 PDDL」生成一个 PDDL 计划，最后（3）将 PDDL 计划翻译回自然语言。本质上，规划步骤是外包给外部工具的，这假设了领域特定的 PDDL 和合适的计划器的可用性，这在某些机器人设置中是常见的，但在许多其他领域则不是。

---

Rephrased Translation

复杂任务通常包含众多步骤，智能体需识别这些步骤并进行前瞻性规划。

1.1 任务的分解

「思维链」（Chain of thought，简称 CoT；Wei 等，2022）已成为提升模型在处理复杂任务时性能的常用提示技术。该模型被引导以「逐步思考」的方式工作，通过增加测试时的计算量，将困难任务分解为更小、更简单的步骤。CoT 方法将大型任务分解为多个易于管理的小任务，为模型的思维过程提供了解释视角。

「思维树」（Tree of Thoughts，Yao 等，2023）在每个步骤探索多个推理路径，进一步发展了 CoT 方法。它首先将问题分解成多个思维步骤，每个步骤生成多个思考路径，形成树状结构。搜索过程可以是广度优先搜索（BFS）或深度优先搜索（DFS），每个阶段的状态通过提示引导的分类器或多数投票法来评估。

任务分解可以通过以下方法实现：（1）通过 LLM 的简单提示，如「XYZ 的步骤。\n1.」、「实现 XYZ 的子目标是什么？」，（2）使用针对特定任务的指令；例如，「编写小说大纲」用于写小说，或（3）结合人类输入。

另一种不同的方法是 LLM+P（Liu 等，2023），依赖外部传统规划器进行长期规划。该方法采用规划领域定义语言（PDDL）作为中介接口描述规划问题。在此过程中，LLM（1）将问题转换为「问题 PDDL」，然后（2）请求传统规划器根据现有的「领域 PDDL」生成 PDDL 计划，并（3）将 PDDL 计划转换回自然语言。从本质上讲，规划步骤交由外部工具处理，这需要特定领域的 PDDL 和适当的规划器，这在某些机器人设置中较为常见，但在其他许多领域则不太常见。

#### 1.2 Self-Reflection

Self-reflection is a vital aspect that allows autonomous agents to improve iteratively by refining past action decisions and correcting previous mistakes. It plays a crucial role in real-world tasks where trial and error are inevitable.

ReAct (Yao et al. 2023) integrates reasoning and acting within LLM by extending the action space to be a combination of task-specific discrete actions and the language space. The former enables LLM to interact with the environment (e.g. use Wikipedia search API), while the latter prompting LLM to generate reasoning traces in natural language.

The ReAct prompt template incorporates explicit steps for LLM to think, roughly formatted as:

Thought: ...

Action: ...

Observation: ...

... (Repeated many times)

Fig. 2. Examples of reasoning trajectories for knowledge-intensive tasks (e.g. HotpotQA, FEVER) and decision-making tasks (e.g. AlfWorld Env, WebShop). (Image source: Yao et al. 2023).

In both experiments on knowledge-intensive tasks and decision-making tasks, ReAct works better than the Act-only baseline where Thought: … step is removed.

Reflexion (Shinn & Labash 2023) is a framework to equips agents with dynamic memory and self-reflection capabilities to improve reasoning skills. Reflexion has a standard RL setup, in which the reward model provides a simple binary reward and the action space follows the setup in ReAct where the task-specific action space is augmented with language to enable complex reasoning steps. After each action, the agent computes a heuristic and optionally may decide to reset the environment to start a new trial depending on the self-reflection results.

Fig. 3. Illustration of the Reflexion framework. (Image source: Shinn & Labash, 2023)

The heuristic function determines when the trajectory is inefficient or contains hallucination and should be stopped. Inefficient planning refers to trajectories that take too long without success. Hallucination is defined as encountering a sequence of consecutive identical actions that lead to the same observation in the environment.

Self-reflection is created by showing two-shot examples to LLM and each example is a pair of (failed trajectory, ideal reflection for guiding future changes in the plan). Then reflections are added into the agent's working memory, up to three, to be used as context for querying LLM.

Fig. 4. Experiments on AlfWorld Env and HotpotQA. Hallucination is a more common failure than inefficient planning in AlfWorld. (Image source: Shinn & Labash, 2023)

Chain of Hindsight (CoH; Liu et al. 2023) encourages the model to improve on its own outputs by explicitly presenting it with a sequence of past outputs, each annotated with feedback. Human feedback data is a collection of, where is the prompt, each is a model completion, is the human rating of, and is the corresponding human-provided hindsight feedback. Assume the feedback tuples are ranked by reward, The process is supervised fine-tuning where the data is a sequence in the form of, where ≤ i ≤ j ≤ n. The model is finetuned to only predict yn where conditioned on the sequence prefix, such that the model can self-reflect to produce better output based on the feedback sequence. The model can optionally receive multiple rounds of instructions with human annotators at test time.

To avoid overfitting, CoH adds a regularization term to maximize the log-likelihood of the pre-training dataset. To avoid shortcutting and copying (because there are many common words in feedback sequences), they randomly mask 0% - 5% of past tokens during training.

The training dataset in their experiments is a combination of WebGPT comparisons, summarization from human feedback and human preference dataset.

Fig. 5. After fine-tuning with CoH, the model can follow instructions to produce outputs with incremental improvement in a sequence. (Image source: Liu et al. 2023)

The idea of CoH is to present a history of sequentially improved outputs in context and train the model to take on the trend to produce better outputs. Algorithm Distillation (AD; Laskin et al. 2023) applies the same idea to cross-episode trajectories in reinforcement learning tasks, where an algorithm is encapsulated in a long history-conditioned policy. Considering that an agent interacts with the environment many times and in each episode the agent gets a little better, AD concatenates this learning history and feeds that into the model. Hence we should expect the next predicted action to lead to better performance than previous trials. The goal is to learn the process of RL instead of training a task-specific policy itself.

Fig. 6. Illustration of how Algorithm Distillation (AD) works.(Image source: Laskin et al. 2023).

The paper hypothesizes that any algorithm that generates a set of learning histories can be distilled into a neural network by performing behavioral cloning over actions. The history data is generated by a set of source policies, each trained for a specific task. At the training stage, during each RL run, a random task is sampled and a subsequence of multi-episode history is used for training, such that the learned policy is task-agnostic.

In reality, the model has limited context window length, so episodes should be short enough to construct multi-episode history. Multi-episodic contexts of 2-4 episodes are necessary to learn a near-optimal in-context RL algorithm. The emergence of in-context RL requires long enough context.

In comparison with three baselines, including ED (expert distillation, behavior cloning with expert trajectories instead of learning history), source policy (used for generating trajectories for distillation by UCB), RL^2 (Duan et al. 2017; used as upper bound since it needs online RL), AD demonstrates in-context RL with performance getting close to RL^2 despite only using offline RL and learns much faster than other baselines. When conditioned on partial training history of the source policy, AD also improves much faster than ED baseline.

Fig. 7. Comparison of AD, ED, source policy and RL^2 on environments that require memory and exploration. Only binary reward is assigned. The source policies are trained with A3C for "dark" environments and DQN for watermaze.

(Image source: Laskin et al. 2023)

[[2210.03629] ReAct: Synergizing Reasoning and Acting in Language Models](https://arxiv.org/abs/2210.03629)

[[2303.11366] Reflexion: Language Agents with Verbal Reinforcement Learning](https://arxiv.org/abs/2303.11366)

[openai/webgpt\_comparisons · Datasets at Hugging Face](https://huggingface.co/datasets/openai/webgpt_comparisons)

[openai/summarize-from-feedback: Code for "Learning to summarize from human feedback"](https://github.com/openai/summarize-from-feedback)

[anthropics/hh-rlhf: Human preference data for "Training a Helpful and Harmless Assistant with Reinforcement Learning from Human Feedback"](https://github.com/anthropics/hh-rlhf)

[[2210.14215] In-context Reinforcement Learning with Algorithm Distillation](https://arxiv.org/abs/2210.14215)

[[2302.02676] Chain of Hindsight Aligns Language Models with Feedback](https://arxiv.org/abs/2302.02676)

[The Multi-Armed Bandit Problem and Its Solutions | Lil'Log](https://lilianweng.github.io/posts/2018-01-23-multi-armed-bandit/#upper-confidence-bounds)

[[1611.02779] RL$^2$: Fast Reinforcement Learning via Slow Reinforcement Learning](https://arxiv.org/abs/1611.02779)

Direct Translation

自我反思是一个重要方面，它允许自主智能体通过改进过去的行动决策和纠正之前的错误来迭代地提升。在现实世界任务中，试错是不可避免的，自我反思在其中发挥着关键作用。

ReAct（Yao 等人，2023 年）通过扩展动作空间为特定任务的离散动作和语言空间的组合，将推理和行动整合在 LLM 中。前者使 LLM 能够与环境互动（例如，使用维基百科搜索 API），而后者促使 LLM 用自然语言生成推理轨迹。

ReAct 提示模板包含 LLM 的明确思考步骤，大致格式如下：

思考：...

动作：...

观察：...

...（多次重复）

图 2. 知识密集型任务（例如 HotpotQA、FEVER）和决策任务（例如 AlfWorld Env、WebShop）的推理轨迹示例。（图片来源：Yao 等人，2023 年）。

在知识密集型任务和决策任务的实验中，ReAct 的表现优于仅有动作的基线，其中移除了思考：... 步骤。

Reflexion（Shinn & Labash，2023 年）是一个框架，为智能体提供动态记忆和自我反思能力，以提高推理技能。Reflexion 采用标准的强化学习（RL）设置，其中奖励模型提供简单的二元奖励，动作空间遵循 ReAct 中的设置，即任务特定的动作空间与语言结合以实现复杂的推理步骤。每次行动后，智能体会计算一个启发式，并可能根据自我反思结果选择重置环境以开始新的尝试。

图 3. Reflexion 框架的示意图。（图片来源：Shinn & Labash，2023）

启发式函数用于确定轨迹是否低效或包含幻觉并应该停止。低效规划指的是花费过长时间而未成功的轨迹。幻觉定义为遇到一系列连续相同的动作，导致在环境中得到相同的观察结果。

自我反思是通过向 LLM 展示两个案例来创建的，每个案例是一对（失败的轨迹，理想的反思以指导未来计划的改变）。然后将反思加入智能体的工作记忆中，最多三个，用作查询 LLM 的上下文。

图 4. 在 AlfWorld Env 和 HotpotQA 上的实验。在 AlfWorld 中，幻觉比低效规划更常见的失败。（图片来源：Shinn & Labash，2023）

回顾链（Chain of Hindsight，CoH；Liu 等人，2023 年）通过明确地向模型展示一系列带有反馈的过去输出来鼓励模型改进自己的输出。人类反馈数据是的集合，其中是提示，每个是模型完成的内容，是对的人类评分，是相应的人类提供的回顾性反馈。假设反馈元组按奖励排名，该过程是在形式为的序列中的监督细调，其中 ≤ i ≤ j ≤ n。模型被细调以仅在序列前缀的条件下预测 yn，以便模型可以自我反思，根据反馈序列产生更好的输出。在测试时，模型可以选择接受人类注释者的多轮指令。

为了避免过度拟合，CoH 增加了一个正则化项，以最大化预训练数据集的对数似然。为了避免走捷径和复制（因为反馈序列中有许多常见词汇），他们在训练期间随机掩盖了 0％至 5％的过去 token。

他们实验中的训练数据集是 WebGPT 比较、来自人类反馈的摘要和人类偏好数据集的组合。

图 5. 使用 CoH 细调后，模型可以遵循指令，以序列方式产生逐步改进的输出。（图片来源：Liu 等人，2023 年）

CoH 的想法是在上下文中呈现一系列逐渐改进的输出，并训练模型以跟随这一趋势产生更好的输出。算法蒸馏（AD；Laskin 等人，2023 年）将相同的理念应用于强化学习任务中的跨集合轨迹，其中算法被封装在一个长期的历史条件策略中。考虑到一个智能体多次与环境互动，并且在每个集合中智能体都会变得更好，AD 将这个学习历史串联起来并输入到模型中。因此，我们应该期望下一个预测的动作将比以前的尝试带来更好的表现。目标是学习强化学习的过程，而不是训练特定于任务的策略本身。

图 6. 描述了算法蒸馏（AD）是如何工作的。（图片来源：Laskin 等人，2023 年）。

该论文假设，任何生成一系列学习历史的算法都可以通过对动作进行行为克隆来蒸馏成一个神经网络。历史数据由一组针对特定任务训练的源策略生成。在训练阶段，每次 RL 运行时，随机采样一个任务，并使用多集合历史的子序列进行训练，使得学习到的策略是任务不可知的。

实际上，模型的上下文窗口长度有限，因此集合应该足够短，以构建多集合历史。为了学习近乎最优的上下文中的 RL 算法，需要 2-4 个集合的多集合上下文。上下文中的 RL 的出现需要足够长的上下文。

与三个基线（包括 ED（专家蒸馏，使用专家轨迹而不是学习历史进行行为克隆）、源策略（用于通过 UCB 生成蒸馏轨迹）、RL^2（Duan 等人，2017 年；用作上限，因为它需要在线 RL）进行比较时，AD 展示了接近 RL^2 的上下文中 RL 表现，尽管只使用离线 RL，并且学习速度比其他基线快得多。在源策略的部分训练历史上条件化时，AD 也比 ED 基线快得多地提高。

图 7. 在需要记忆和探索的环境中比较 AD、ED、源策略和 RL^2。只分配二元奖励。源策略是用 A3C 训练的「暗」环境和 DQN 训练的水迷宫。

（图片来源：Laskin 等人，2023 年）

---

Rephrased Translation

自我反思对于自主智能体至关重要，它使智能体能够通过改善先前的行为决策和纠正旧错误，逐步提高性能。在实际任务中，尤其重要，因为尝试和错误是不可避免的。

ReAct（Yao 等，2023）将推理和行动融合进 LLM 中，它通过将动作空间扩展为特定任务的离散动作与语言空间的组合。这一设置让 LLM 能够与环境互动（如使用维基百科搜索 API），同时生成自然语言的推理轨迹。

ReAct 的提示模板包括 LLM 进行思考的明确步骤，格式大致如下：

思考：...

动作：...

观察：...

...（反复多次）

图 2. 展示了知识密集型任务（如 HotpotQA、FEVER）和决策任务（如 AlfWorld Env、WebShop）的推理轨迹示例。（图片来源：Yao 等，2023 年）。

在知识密集型任务和决策任务的实验中，ReAct 的表现优于只进行动作的基线实验，后者去除了思考步骤。

Reflexion（Shinn 和 Labash，2023）是一个框架，它赋予智能体动态记忆和自我反思的能力，以增强其推理技巧。在 Reflexion 的标准强化学习设置中，奖励模型提供简单的二元奖励，动作空间跟随 ReAct 的设定，结合了任务特定动作和语言，以便执行复杂的推理步骤。在每次行动后，智能体会进行启发式计算，并可能根据自我反思的结果选择重置环境，以开始新一轮尝试。

图 3 展示了 Reflexion 框架的结构图。（图片来源：Shinn & Labash，2023）

启发式函数的作用是判断轨迹是否低效或存在幻觉并据此决定是否停止。低效规划是指耗时过长且未获成功的轨迹。幻觉是指连续的相同动作导致环境中出现相同观察结果的情况。

通过向 LLM 展示两个示例来构建自我反思，每个示例包含一对元素：失败的轨迹和理想的反思，以指导未来计划的改变。接着，这些反思被添加到智能体的工作记忆中，最多三个，作为查询 LLM 的上下文。

图 4 展示了在 AlfWorld Env 和 HotpotQA 上进行的实验。在 AlfWorld 中，幻觉是比低效规划更常见的失败模式。（图片来源：Shinn & Labash，2023）

「回顾链」（Chain of Hindsight，简称 CoH；Liu 等，2023 年）通过向模型呈现一系列带有反馈的过去输出，鼓励模型改进自身输出。人类反馈数据是一个集合，其中包括提示、模型完成的内容、对这些内容的人类评分，以及相应的人类提供的回顾性反馈。假设反馈元组按奖励排名，这一过程是序列形式的监督式细调，其中 ≤ i ≤ j ≤ n。模型被细调以依据序列前缀仅预测 yn，使模型能基于反馈序列自我反思，产生更优质的输出。模型在测试时可以选择接受人类注释者的多轮指示。

为防止过度拟合，CoH 增加了一个正则化项，最大化预训练数据集的对数似然值。为避免走捷径和复制（反馈序列中有许多共同词汇），他们在训练过程中随机遮蔽了 0% 至 5% 的旧 token。

他们实验中的训练数据集是 WebGPT 比较、基于人类反馈的摘要和人类偏好数据集的组合。

图 5 展示了使用 CoH 细调后，模型如何遵循指令，逐步改进序列输出。（图片来源：Liu 等，2023 年）

CoH 的核心思想是展现一系列在上下文中逐步改善的输出，并训练模型以此为基础产生更优质的输出。算法蒸馏（AD；Laskin 等，2023 年）采用了这一思想，应用于强化学习任务中跨集合的轨迹，其中算法被嵌入到长期历史条件的策略中。考虑到智能体多次与环境交互，并且在每个集合中逐渐变得更加高效，AD 将这些学习历史串联起来并输入到模型中。因此，预计下一个预测的行动会比之前的尝试有更好的表现。其目标是学习强化学习过程，而非仅训练特定任务的策略。

图 6 展示了算法蒸馏（AD）的工作原理。（图片来源：Laskin 等，2023 年）。

论文提出假设：任何生成学习历史集的算法都可以通过对行动进行行为克隆，蒸馏成一个神经网络。历史数据由一系列针对特定任务训练的源策略生成。在训练阶段，每次 RL 运行时会随机选择一个任务，使用多集合历史的子序列进行训练，以此确保学习到的策略对任务是不可知的。

由于模型的上下文窗口长度有限，集合需要足够短，以便构建多集合历史。为了学习近似最优的上下文中的 RL 算法，需要 2-4 集合的多集合上下文。上下文中的 RL 的出现需要足够长的上下文。

与包括 ED（专家蒸馏，使用专家轨迹进行行为克隆）、源策略（用于通过 UCB 生成蒸馏轨迹）、RL^2（Duan 等，2017 年；用作上限，因为它需要在线 RL）等三个基线的比较显示，AD 在上下文中的 RL 表现接近 RL^2，尽管只使用离线 RL，且比其他基线学习得更快。当以源策略的部分训练历史为条件时，AD 的改进速度也比 ED 基线快得多。

图 7 比较了 AD、ED、源策略和 RL^2 在需要记忆和探索的环境中的表现。只有二元奖励。源策略分别使用 A3C 训练「暗」环境和 DQN 训练水迷宫。

（图片来源：Laskin 等，2023 年）

### 02. Component Two: Memory

(Big thank you to ChatGPT for helping me draft this section. I've learned a lot about the human brain and data structure for fast MIPS in my conversations with ChatGPT.)

[Memory and MIPS](https://chat.openai.com/share/46ff149e-a4c7-4dd7-a800-fc4a642ea389)

#### 2.1 Types of Memory

Memory can be defined as the processes used to acquire, store, retain, and later retrieve information. There are several types of memory in human brains.

Sensory Memory: This is the earliest stage of memory, providing the ability to retain impressions of sensory information (visual, auditory, etc) after the original stimuli have ended. Sensory memory typically only lasts for up to a few seconds. Subcategories include iconic memory (visual), echoic memory (auditory), and haptic memory (touch).

Short-Term Memory (STM) or Working Memory: It stores information that we are currently aware of and needed to carry out complex cognitive tasks such as learning and reasoning. Short-term memory is believed to have the capacity of about 7 items (Miller 1956) and lasts for 20-30 seconds.

Long-Term Memory (LTM): Long-term memory can store information for a remarkably long time, ranging from a few days to decades, with an essentially unlimited storage capacity. There are two subtypes of LTM:

Explicit / declarative memory: This is memory of facts and events, and refers to those memories that can be consciously recalled, including episodic memory (events and experiences) and semantic memory (facts and concepts).

Implicit / procedural memory: This type of memory is unconscious and involves skills and routines that are performed automatically, like riding a bike or typing on a keyboard.

Fig. 8. Categorization of human memory.

We can roughly consider the following mappings:

Sensory memory as learning embedding representations for raw inputs, including text, image or other modalities;

Short-term memory as in-context learning. It is short and finite, as it is restricted by the finite context window length of Transformer.

Long-term memory as the external vector store that the agent can attend to at query time, accessible via fast retrieval.

Direct Translation

记忆类型

记忆可以定义为用来获取、存储、保留以及稍后检索信息的过程。人类大脑中有几种类型的记忆。

感觉记忆：这是记忆的最初阶段，提供了在原始刺激结束后保留感官信息（视觉、听觉等）印象的能力。感觉记忆通常只持续几秒钟。子类别包括图像记忆（视觉）、回声记忆（听觉）和触觉记忆（触觉）。

短期记忆（STM）或工作记忆：它存储我们当前意识到并需要执行复杂认知任务（如学习和推理）的信息。短期记忆的容量据信约为 7 项（Miller 1956 年）且持续时间为 20-30 秒。

长期记忆（LTM）：长期记忆可以将信息存储非常长的时间，从几天到几十年，具有基本无限的存储容量。LTM 有两种子类型：

显性 / 陈述性记忆：这是对事实和事件的记忆，指的是可以有意识地回忆的记忆，包括情景记忆（事件和经历）和语义记忆（事实和概念）。

隐性 / 程序性记忆：这种类型的记忆是无意识的，涉及自动执行的技能和例行程序，如骑自行车或键盘输入。

图 8. 人类记忆的分类。

我们可以大致考虑以下映射：

将感觉记忆视为原始输入（包括文本、图像或其他模式）的学习嵌入表示；

短期记忆视为上下文学习。它是短暂且有限的，因为受到 Transformer 有限上下文窗口长度的限制。

长期记忆视为智能体在查询时可以关注的外部向量存储，可以通过快速检索访问。

Rephrased Translation

记忆类型概述

记忆是指获取、存储、保持并在以后检索信息的过程。人脑中存在多种类型的记忆。

感觉记忆：这是记忆的初始阶段，提供了在初始刺激结束后保留感官信息（如视觉、听觉等）印象的能力。感觉记忆通常持续时间非常短，最多几秒钟。它包括图像记忆（视觉）、回声记忆（听觉）和触觉记忆（触觉）。

短期记忆（STM）或工作记忆：它存储我们当前正在处理的信息，以及执行复杂认知任务（例如学习、推理）所需的信息。短期记忆的容量大约为 7 项（Miller，1956 年）并且持续时间为 20-30 秒。

长期记忆（LTM）：长期记忆能够将信息存储很长时间，从几天到数十年不等，且具有几乎无限的存储容量。长期记忆有两种子类型：

显性 / 陈述性记忆：这是关于事实和事件的记忆，指的是可以有意识回忆的记忆，包括情景记忆（事件和经历）和语义记忆（事实和概念）。

隐性 / 程序性记忆：这种记忆是无意识的，涉及自动执行的技能和程序，如骑自行车或打字。

图 8 展示了人类记忆的分类。

我们可以大致将其映射如下：

将感觉记忆视为对原始输入（包括文本、图像或其他模态）的学习嵌入表示；

将短期记忆视为上下文学习。它是短暂且有限的，因为受限于 Transformer 的有限上下文窗口长度。

将长期记忆视为智能体在查询时可以访问的外部向量存储，通过快速检索进行访问。

#### 2.2 Maximum Inner Product Search (MIPS)

The external memory can alleviate the restriction of finite attention span. A standard practice is to save the embedding representation of information into a vector store database that can support fast maximum inner-product search (MIPS). To optimize the retrieval speed, the common choice is the approximate nearest neighbors (ANN)​ algorithm to return approximately top k nearest neighbors to trade off a little accuracy lost for a huge speedup.

A couple common choices of ANN algorithms for fast MIPS:

LSH (Locality-Sensitive Hashing): It introduces a hashing function such that similar input items are mapped to the same buckets with high probability, where the number of buckets is much smaller than the number of inputs.

ANNOY (Approximate Nearest Neighbors Oh Yeah): The core data structure are random projection trees, a set of binary trees where each non-leaf node represents a hyperplane splitting the input space into half and each leaf stores one data point. Trees are built independently and at random, so to some extent, it mimics a hashing function. ANNOY search happens in all the trees to iteratively search through the half that is closest to the query and then aggregates the results. The idea is quite related to KD tree but a lot more scalable.

HNSW (Hierarchical Navigable Small World): It is inspired by the idea of small world networks where most nodes can be reached by any other nodes within a small number of steps; e.g.「six degrees of separation」feature of social networks. HNSW builds hierarchical layers of these small-world graphs, where the bottom layers contain the actual data points. The layers in the middle create shortcuts to speed up search. When performing a search, HNSW starts from a random node in the top layer and navigates towards the target. When it can't get any closer, it moves down to the next layer, until it reaches the bottom layer. Each move in the upper layers can potentially cover a large distance in the data space, and each move in the lower layers refines the search quality.

FAISS (Facebook AI Similarity Search): It operates on the assumption that in high dimensional space, distances between nodes follow a Gaussian distribution and thus there should exist clustering of data points. FAISS applies vector quantization by partitioning the vector space into clusters and then refining the quantization within clusters. Search first looks for cluster candidates with coarse quantization and then further looks into each cluster with finer quantization.

ScaNN (Scalable Nearest Neighbors): The main innovation in ScaNN is anisotropic vector quantization. It quantizes a data point to such that the inner product is as similar to the original distance of as possible, instead of picking the closet quantization centroid points.

Fig. 9. Comparison of MIPS algorithms, measured in recall@10. (Image source: Google Blog, 2020)

Check more MIPS algorithms and performance comparison in ann-benchmarks.com.

[Announcing ScaNN: Efficient Vector Similarity Search – Google Research Blog](https://blog.research.google/2020/07/announcing-scann-efficient-vector.html)

[ANN-Benchmarks](https://ann-benchmarks.com/)

Direct Translation

外部记忆可以减轻有限注意力范围的限制。一种标准做法是将信息的嵌入表示保存到可以支持快速最大内积搜索（MIPS）的向量存储数据库中。为了优化检索速度，通常选择近似最近邻（ANN）算法返回大约前 k 个最近邻，以牺牲一点精度换取巨大的速度提升。

一些常见的用于快速 MIPS 的 ANN 算法：

LSH（局部敏感哈希）：它引入了一个哈希函数，使得相似的输入项有很高的概率被映射到同一个桶中，其中桶的数量远小于输入的数量。

ANNOY（大约最近邻 Oh Yeah）：核心数据结构是随机投影树，一组二叉树，每个非叶节点代表一个将输入空间切分为两半的超平面，每个叶子存储一个数据点。树是独立且随机构建的，所以在某种程度上，它模仿了一个哈希函数。ANNOY 的搜索发生在所有树中，以迭代地搜索最接近查询的一半，然后汇总结果。这个想法与 KD 树有关，但更具可扩展性。

HNSW（分层可导航小世界）：它受到小世界网络的启发，即大多数节点可以在少量步骤内由任何其他节点到达；例如，社交网络的「六度分隔」特性。HNSW 构建了这些小世界图的分层层次，底层包含实际的数据点。中间层创建快捷方式以加速搜索。进行搜索时，HNSW 从顶层的一个随机节点开始，朝目标导航。当它无法更接近时，它会移动到下一层，直到达到底层。上层的每次移动都可以在数据空间中覆盖大的距离，下层的每次移动都会提高搜索质量。

FAISS（Facebook AI 相似性搜索）：它基于这样的假设，即在高维空间中，节点之间的距离遵循高斯分布，因此应该存在数据点的聚类。FAISS 通过对向量空间进行划分并在聚类内进一步细化量化来应用向量量化。搜索首先寻找粗量化的聚类候选者，然后进一步在每个聚类中进行更精细的量化。

ScaNN（可扩展最近邻）：ScaNN 的主要创新是各向异性向量量化。它对数据点进行量化，使内积尽可能接近的原始距离，而不是选择最接近的量化质心点。

图 9. MIPS 算法的比较，以 recall@10 为度量。（图片来源：Google 博客，2020 年）

在 ann-benchmarks.com 上查看更多 MIPS 算法和性能比较。

---

Rephrased Translation

外部存储可以帮助缓解有限注意力跨度的限制。一个常见的做法是将信息的嵌入表示保存到支持快速最大内积搜索（MIPS）的向量存储数据库中。为了提高检索速度，常用的选择是近似最近邻（ANN）算法，它返回大致的前 k 个最近邻，以牺牲一些精确度换取显著的速度提升。

几种常用的快速 MIPS ANN 算法包括：

- LSH（局部敏感哈希）：通过哈希函数将相似输入映射到同一桶中，桶的数量远少于输入数量。

- ANNOY（大约最近邻 Oh Yeah）：核心结构是随机投影树，每个非叶节点代表一个超平面，将输入空间一分为二，每个叶子存储一个数据点。树独立随机构建，模拟哈希函数。搜索在所有树中进行，逐步找到最接近查询的部分，然后聚合结果。

- HNSW（分层可导航小世界）：灵感来自小世界网络，大多数节点在少量步骤内可达。它构建了包含实际数据点的小世界图分层，中间层为搜索创建快捷方式。搜索从顶层随机节点开始，逐层深入，直至底层。

- FAISS（Facebook AI 相似性搜索）：假设高维空间中节点间距离呈高斯分布，存在数据点聚类。通过划分向量空间并在聚类内细化量化进行向量量化。搜索先找到粗量化的聚类，然后进一步细化。

- ScaNN（可扩展最近邻）：创新在于各向异性向量量化，量化数据点以使内积尽可能接近原始距离，而非选择最近的量化质心。

图 9 展示了以 recall@10 为度量的 MIPS 算法比较。（图片来源：Google 博客，2020 年）

更多 MIPS 算法及其性能比较可在 ann-benchmarks.com 查看。

### 03. Component Three: Tool Use

Tool use is a remarkable and distinguishing characteristic of human beings. We create, modify and utilize external objects to do things that go beyond our physical and cognitive limits. Equipping LLMs with external tools can significantly extend the model capabilities.

Fig. 10. A picture of a sea otter using rock to crack open a seashell, while floating in the water. While some other animals can use tools, the complexity is not comparable with humans. (Image source: Animals using tools)

MRKL (Karpas et al. 2022), short for「Modular Reasoning, Knowledge and Language」, is a neuro-symbolic architecture for autonomous agents. A MRKL system is proposed to contain a collection of「expert」modules and the general-purpose LLM works as a router to route inquiries to the best suitable expert module. These modules can be neural (e.g. deep learning models) or symbolic (e.g. math calculator, currency converter, weather API).

They did an experiment on fine-tuning LLM to call a calculator, using arithmetic as a test case. Their experiments showed that it was harder to solve verbal math problems than explicitly stated math problems because LLMs (7B Jurassic1-large model) failed to extract the right arguments for the basic arithmetic reliably. The results highlight when the external symbolic tools can work reliably, knowing when to and how to use the tools are crucial, determined by the LLM capability.

Both TALM (Tool Augmented Language Models; Parisi et al. 2022) and Toolformer (Schick et al. 2023) fine-tune a LM to learn to use external tool APIs. The dataset is expanded based on whether a newly added API call annotation can improve the quality of model outputs. See more details in the「External APIs」section of Prompt Engineering.

ChatGPT Plugins and OpenAI API function calling are good examples of LLMs augmented with tool use capability working in practice. The collection of tool APIs can be provided by other developers (as in Plugins) or self-defined (as in function calls).

HuggingGPT (Shen et al. 2023) is a framework to use ChatGPT as the task planner to select models available in HuggingFace platform according to the model descriptions and summarize the response based on the execution results.

Fig. 11. Illustration of how HuggingGPT works. (Image source: Shen et al. 2023)

The system comprises of 4 stages:

(1) Task planning: LLM works as the brain and parses the user requests into multiple tasks. There are four attributes associated with each task: task type, ID, dependencies, and arguments. They use few-shot examples to guide LLM to do task parsing and planning.

Instruction:

The AI assistant can parse user input to several tasks: [{"task": task, "id", task_id, "dep": dependency_task_ids, "args": {"text": text, "image": URL, "audio": URL, "video": URL}}]. The "dep" field denotes the id of the previous task which generates a new resource that the current task relies on. A special tag "-task_id" refers to the generated text image, audio and video in the dependency task with id as task_id. The task MUST be selected from the following options: {{ Available Task List }}. There is a logical relationship between tasks, please note their order. If the user input can't be parsed, you need to reply empty JSON. Here are several cases for your reference: {{ Demonstrations }}. The chat history is recorded as {{ Chat History }}. From this chat history, you can find the path of the user-mentioned resources for your task planning.

(2) Model selection: LLM distributes the tasks to expert models, where the request is framed as a multiple-choice question. LLM is presented with a list of models to choose from. Due to the limited context length, task type based filtration is needed.

Instruction:

Given the user request and the call command, the AI assistant helps the user to select a suitable model from a list of models to process the user request. The AI assistant merely outputs the model id of the most appropriate model. The output must be in a strict JSON format: "id": "id", "reason": "your detail reason for the choice". We have a list of models for you to choose from {{ Candidate Models }}. Please select one model from the list.

(3) Task execution: Expert models execute on the specific tasks and log results.

Instruction:

With the input and the inference results, the AI assistant needs to describe the process and results. The previous stages can be formed as - User Input: {{ User Input }}, Task Planning: {{ Tasks }}, Model Selection: {{ Model Assignment }}, Task Execution: {{ Predictions }}. You must first answer the user's request in a straightforward manner. Then describe the task process and show your analysis and model inference results to the user in the first person. If inference results contain a file path, must tell the user the complete file path.

(4) Response generation: LLM receives the execution results and provides summarized results to users.

To put HuggingGPT into real world usage, a couple challenges need to solve: (1) Efficiency improvement is needed as both LLM inference rounds and interactions with other models slow down the process; (2) It relies on a long context window to communicate over complicated task content; (3) Stability improvement of LLM outputs and external model services.

API-Bank (Li et al. 2023) is a benchmark for evaluating the performance of tool-augmented LLMs. It contains 53 commonly used API tools, a complete tool-augmented LLM workflow, and 264 annotated dialogues that involve 568 API calls. The selection of APIs is quite diverse, including search engines, calculator, calendar queries, smart home control, schedule management, health data management, account authentication workflow and more. Because there are a large number of APIs, LLM first has access to API search engine to find the right API to call and then uses the corresponding documentation to make a call.

Fig. 12. Pseudo code of how LLM makes an API call in API-Bank. (Image source: Li et al. 2023)

In the API-Bank workflow, LLMs need to make a couple of decisions and at each step we can evaluate how accurate that decision is. Decisions include:

Whether an API call is needed.

Identify the right API to call: if not good enough, LLMs need to iteratively modify the API inputs (e.g. deciding search keywords for Search Engine API).

Response based on the API results: the model can choose to refine and call again if results are not satisfied.

This benchmark evaluates the agent's tool use capabilities at three levels:

Level-1 evaluates the ability to call the API. Given an API's description, the model needs to determine whether to call a given API, call it correctly, and respond properly to API returns.

Level-2 examines the ability to retrieve the API. The model needs to search for possible APIs that may solve the user's requirement and learn how to use them by reading documentation.

Level-3 assesses the ability to plan API beyond retrieve and call. Given unclear user requests (e.g. schedule group meetings, book flight/hotel/restaurant for a trip), the model may have to conduct multiple API calls to solve it.

[[2205.00445] MRKL Systems: A modular, neuro-symbolic architecture that combines large language models, external knowledge sources and discrete reasoning](https://arxiv.org/abs/2205.00445)

[[2205.12255] TALM: Tool Augmented Language Models](https://arxiv.org/abs/2205.12255)

[[2302.04761] Toolformer: Language Models Can Teach Themselves to Use Tools](https://arxiv.org/abs/2302.04761)

[[2303.17580] HuggingGPT: Solving AI Tasks with ChatGPT and its Friends in Hugging Face](https://arxiv.org/abs/2303.17580)

[[2304.08244] API-Bank: A Comprehensive Benchmark for Tool-Augmented LLMs](https://arxiv.org/abs/2304.08244)

Direct Translation

工具使用是人类的显著且独特特征。我们创造、修改并利用外部物体来执行超出我们身体和认知限制的事情。为大型语言模型（LLM）配备外部工具可以显著扩展模型的能力。

图 10. 一张海獭使用石头敲开贝壳的图片，海獭在水中漂浮。尽管其他一些动物也可以使用工具，但复杂性与人类不可比拟。（图片来源：动物使用工具）

MRKL（Karpas 等人，2022 年），即「模块化推理、知识和语言」，是一种用于自主智能体的神经符号架构。MRKL 系统被提出包含一系列「专家」模块，通用的 LLM 作为路由器将查询引导到最合适的专家模块。这些模块可以是神经的（例如深度学习模型）或符号的（例如数学计算器、货币转换器、天气 API）。

他们进行了一个实验，对 LLM 进行微调以调用计算器，使用算术作为测试案例。他们的实验表明，解决口头数学问题比明确陈述的数学问题更难，因为 LLM（7B Jurassic1-large 模型）未能可靠地提取基本算术的正确参数。结果突出显示当外部符号工具可靠工作时，知道何时以及如何使用这些工具至关重要，由 LLM 的能力决定。

TALM（工具增强语言模型；Parisi 等人，2022 年）和 Toolformer（Schick 等人，2023 年）都对 LM 进行了微调，学习使用外部工具 API。数据集根据新添加的 API 调用注释是否可以提高模型输出的质量而扩展。有关「外部 API」部分的更多细节，请参见提示工程。

ChatGPT 插件和 OpenAI API 函数调用是 LLM 配备工具使用能力在实践中运作的好例子。工具 API 集合可以由其他开发者提供（如插件）或自行定义（如函数调用）。

HuggingGPT（Shen 等人，2023 年）是一个框架，使用 ChatGPT 作为任务规划器，根据模型描述选择 HuggingFace 平台上可用的模型，并根据执行结果总结回应。

图 11. 展示了 HuggingGPT 如何工作的插图。（图片来源：Shen 等人，2023 年）

系统包括 4 个阶段：

(1) 任务规划：LLM 作为大脑，将用户请求解析为多个任务。每个任务都与四个属性相关联：任务类型、ID、依赖关系和参数。他们使用少量示例来指导 LLM 进行任务解析和规划。

指令：

AI 助手可以将用户输入解析为几个任务：[{"task": task, "id": task_id, "dep": dependency_task_ids, "args": {"text": text, "image": URL, "audio": URL, "video": URL}}]。"dep" 字段表示当前任务所依赖的先前任务的 id，生成了新资源。特殊标签 "-task_id" 指的是依赖任务中 id 为 task_id 的生成的文本图像、音频和视频。任务必须从以下选项中选择：{{可用任务列表}}。任务之间存在逻辑关系，请注意它们的顺序。如果用户输入无法解析，你需要回复空 JSON。以下是几个参考案例：{{演示}}。聊天历史记录为 {{聊天历史}}。从这个聊天历史中，你可以找到用户提到的资源路径，用于你的任务规划。

(2) 模型选择：LLM 将任务分配给专家模型，请求被框架为多项选择题。LLM 面对一个模型列表进行选择。由于上下文长度有限，需要基于任务类型的过滤。

指令：

根据用户请求和调用命令，AI 助手帮助用户从模型列表中选择一个合适的模型来处理用户请求。AI 助手仅输出最合适模型的模型 id。输出必须是严格的 JSON 格式："id": "id", "reason": "你选择的详细原因"。我们有一个模型列表供你选择 {{候选模型}}。请从列表中选择一个模型。

(3) 任务执行：专家模型执行特定任务并记录结果。

指令：

根据输入和推理结果，AI 助手需要描述过程和结果。前几个阶段可以形成为 - 用户输入：{{用户输入}}，任务规划：{{任务}}，模型选择：{{模型分配}}，任务执行：{{预测}}。你必须首先直接回答用户的请求。然后描述任务过程，并以第一人称向用户展示你的分析和模型推理结果。如果推理结果包含文件路径，必须告诉用户完整的文件路径。

(4) 响应生成：LLM 接收执行结果并向用户提供总结性结果。

要将 HuggingGPT 应用到现实世界中，需要解决几个挑战：(1) 需要提高效率，因为 LLM 的推理轮次和与其他模型的互动会减慢过程；(2) 它依赖于长的上下文窗口来处理复杂的任务内容；(3) 需要改进 LLM 输出和外部模型服务的稳定性。

API-Bank（Li 等人，2023 年）是一个用于评估工具增强 LLM 性能的基准测试。它包含 53 个常用 API 工具，一个完整的工具增强 LLM 工作流程，以及涉及 568 次 API 调用的 264 个注释对话。API 的选择相当多样，包括搜索引擎、计算器、日历查询、智能家居控制、日程管理、健康数据管理、账户认证工作流程等。由于 API 数量众多，LLM 首先可以访问 API 搜索引擎来找到正确的 API 进行调用，然后使用相应的文档进行调用。

图 12. LLM 在 API-Bank 中进行 API 调用的伪代码。（图片来源：Li 等人，2023 年）

在 API-Bank 的工作流程中，LLM 需要做出几个决策，并在每个步骤中评估决策的准确性。决策包括：

是否需要进行 API 调用。

识别正确的 API 进行调用：如果不够好，LLM 需要反复修改 API 输入（例如，为搜索引擎 API 决定搜索关键词）。

根据 API 结果进行响应：如果结果不令人满意，模型可以选择重新细化并再次调用。

这个基准测试在三个层次上评估代理的工具使用能力：

Level-1 评估调用 API 的能力。给定 API 的描述，模型需要确定是否调用给定的 API，正确调用，并适当响应 API 返回。

Level-2 检查检索 API 的能力。模型需要搜索可能解决用户需求的 API，并通过阅读文档学习如何使用它们。

Level-3 评估计划 API 的能力超出检索和调用。面对不清晰的用户请求（例如，安排团队会议，为旅行预订航班 / 酒店 / 餐厅），模型可能需要进行多次 API 调用来解决问题。

---

Rephrased Translation

工具使用是人类的一个显著特征，我们创造、修改并使用外部物体来完成超越我们身体和认知限制的任务。为 LLM 配备外部工具可以大幅扩展它们的能力。

图 10 是一张海獭在水中使用石头敲开贝壳的图片。尽管其他一些动物也能使用工具，但其复杂性与人类不可比。（图片来源：动物使用工具）

MRKL（Karpas 等人，2022 年），即「模块化推理、知识和语言」，是一种为自主智能体设计的神经符号架构。MRKL 系统包含一系列「专家」模块，通用 LLM 作为路由器将查询路由到最合适的专家模块。这些模块可以是神经的（如深度学习模型）或符号的（如数学计算器、货币转换器、天气 API）。

他们进行了一个实验，对 LLM 进行微调以调用计算器，以算术为测试案例。实验表明，解决口头数学问题比明确的数学问题更难，因为 LLM（7B Jurassic1-large 模型）未能可靠地提取基本算术的正确参数。结果强调，当外部符号工具可靠时，知道何时及如何使用这些工具至关重要，这取决于 LLM 的能力。

TALM（工具增强语言模型；Parisi 等人，2022 年）和 Toolformer（Schick 等人，2023 年）均对 LM 进行了微调，学会使用外部工具 API。数据集基于新添加的 API 调用注释是否可以提升模型输出的质量而扩展。更多细节可在「外部 API」部分的提示工程中找到。

ChatGPT 插件和 OpenAI API 函数调用是 LLM 配备工具使用能力在实际中的良好例子。工具 API 可以由其他开发者提供（如插件）或自定义（如函数调用）。

HuggingGPT（Shen 等人，2023 年）是一个框架，使用 ChatGPT 作为任务规划器来选择 HuggingFace 平台上可用的模型，并基于执行结果汇总回应。

图 11 展示了 HuggingGPT 的工作原理。（图片来源：Shen 等人，2023 年）

该系统由四个阶段组成：

(1) 任务规划：LLM 作为「大脑」，将用户请求分解为多个任务，每个任务关联四个属性：任务类型、ID、依赖关系和参数。通过少量示例，LLM 被指导进行任务的解析和规划。

指令：

AI 助手能将用户输入解析成几个任务：[{"task": 任务，"id": 任务 id, "dep": 依赖任务的 id, "args": {"text": 文本，"image": 图片 URL, "audio": 音频 URL, "video": 视频 URL}}]。「dep」字段表示当前任务所依赖的前一个任务 id。特殊标签 "-task_id" 指向依赖任务中 id 为 task_id 的生成的文本、图像、音频和视频。任务必须从指定选项中选择。任务之间存在逻辑关系，需要注意顺序。若无法解析用户输入，则回复空 JSON。这里有几个案例供参考。聊天历史记录为 {{聊天历史}}，可用于任务规划。

(2) 模型选择：LLM 将任务分配给专家模型。请求被转化为多项选择题。LLM 需要在模型列表中作出选择。由于上下文长度限制，需要根据任务类型进行筛选。

指令：

AI 助手根据用户请求和调用命令，帮助用户从模型列表中选择合适的模型处理请求。AI 助手只输出最合适模型的 id。输出必须是严格的 JSON 格式："id": "id", "reason": "选择原因"。这里有一个模型列表供你选择。

(3) 任务执行：专家模型执行特定任务并记录结果。

指令：

AI 助手需要根据输入和推理结果描述过程和结果。前面的阶段可以表示为 - 用户输入：{{用户输入}}，任务规划：{{任务}}，模型选择：{{模型分配}}，任务执行：{{预测}}。首先要直接回答用户的请求，然后以第一人称描述任务过程并向用户展示分析和模型推理结果。如果推理结果包含文件路径，必须告诉用户完整路径。

(4) 响应生成：LLM 接收执行结果并向用户提供汇总结果。

要将 HuggingGPT 投入实际应用，需要解决几个挑战：(1) 提高效率，因 LLM 推理和与其他模型的互动会减慢流程；(2) 依赖长上下文窗口处理复杂任务内容；(3) 改善 LLM 输出和外部模型服务的稳定性。

API-Bank（Li 等人，2023 年）是一个用于评估工具增强 LLM 的基准测试。它包含 53 个常用 API 工具、一个完整的工具增强 LLM 工作流程，以及涉及 568 次 API 调用的 264 个注释对话。API 选择多样，包括搜索引擎、计算器、日历查询、智能家居控制、日程管理、健康数据管理、账户认证工作流等。由于 API 众多，LLM 首先访问 API 搜索引擎找到正确的 API，然后使用相应文档进行调用。

图 12 展示了 LLM 在 API-Bank 中如何进行 API 调用的伪代码。（图片来源：Li 等人，2023 年）

在 API-Bank 工作流中，LLM 需要做出若干决策，并在每一步评估决策的准确性。决策包括：

- 是否需要 API 调用。

- 识别正确的 API：若不够准确，LLM 需要反复修改 API 输入。

- 基于 API 结果进行响应：若结果不满意，模型可以选择重新调用并细化。

这一基准测试从三个层次评估工具使用能力：

- Level-1 评估调用 API 的能力。模型需要判断是否调用 API，正确调用并适当响应 API 返回。

- Level-2 检查检索 API 的能力。模型需搜索可能解决用户需求的 API，并通过阅读文档学习使用方式。

- Level-3 评估规划 API 能力。面对不明确的用户请求（如安排会议、预订旅行相关服务），模型可能需多次 API 调用解决问题。

### 04. Case Studies

#### 4.1 Scientific Discovery Agent

ChemCrow (Bran et al. 2023) is a domain-specific example in which LLM is augmented with 13 expert-designed tools to accomplish tasks across organic synthesis, drug discovery, and materials design. The workflow, implemented in LangChain, reflects what was previously described in the ReAct and MRKLs and combines CoT reasoning with tools relevant to the tasks:

The LLM is provided with a list of tool names, descriptions of their utility, and details about the expected input/output.

It is then instructed to answer a user-given prompt using the tools provided when necessary. The instruction suggests the model to follow the ReAct format - Thought, Action, Action Input, Observation.

One interesting observation is that while the LLM-based evaluation concluded that GPT-4 and ChemCrow perform nearly equivalently, human evaluations with experts oriented towards the completion and chemical correctness of the solutions showed that ChemCrow outperforms GPT-4 by a large margin. This indicates a potential problem with using LLM to evaluate its own performance on domains that requires deep expertise. The lack of expertise may cause LLMs not knowing its flaws and thus cannot well judge the correctness of task results.

Boiko et al. (2023) also looked into LLM-empowered agents for scientific discovery, to handle autonomous design, planning, and performance of complex scientific experiments. This agent can use tools to browse the Internet, read documentation, execute code, call robotics experimentation APIs and leverage other LLMs.

For example, when requested to "develop a novel anticancer drug", the model came up with the following reasoning steps:

inquired about current trends in anticancer drug discovery;

selected a target;

requested a scaffold targeting these compounds;

Once the compound was identified, the model attempted its synthesis.

They also discussed the risks, especially with illicit drugs and bioweapons. They developed a test set containing a list of known chemical weapon agents and asked the agent to synthesize them. 4 out of 11 requests (36%) were accepted to obtain a synthesis solution and the agent attempted to consult documentation to execute the procedure. 7 out of 11 were rejected and among these 7 rejected cases, 5 happened after a Web search while 2 were rejected based on prompt only.

[[2304.05376] ChemCrow: Augmenting large-language models with chemistry tools](https://arxiv.org/abs/2304.05376)

[[2304.05332] Emergent autonomous scientific research capabilities of large language models](https://arxiv.org/abs/2304.05332)

[langchain-ai/langchain: ⚡ Building applications with LLMs through composability ⚡](https://github.com/langchain-ai/langchain)

Direct Translation

ChemCrow（Bran 等人，2023 年）是一个领域特定的示例，其中 LLM 被增强了 13 个专家设计的工具，以完成有机合成、药物发现和材料设计等任务。该工作流程在 LangChain 中实现，反映了之前在 ReAct 和 MRKLs 中描述的内容，并将 CoT 推理与任务相关的工具结合起来：

LLM 提供了一个工具名称列表、它们的效用描述，以及预期输入 / 输出的细节。

然后指导它使用提供的工具在必要时回答用户给定的提示。指示建议模型遵循 ReAct 格式 - 思考、动作、动作输入、观察。

一个有趣的观察是，尽管基于 LLM 的评估得出 GPT-4 和 ChemCrow 表现几乎相当的结论，但专家的人类评估倾向于完成和化学正确性的解决方案显示，ChemCrow 大大超过了 GPT-4。这表明在需要深厚专业知识的领域，使用 LLM 评估自己的表现可能存在问题。专业知识的缺乏可能导致 LLM 不知道自己的缺陷，因此无法很好地判断任务结果的正确性。

Boiko 等人（2023 年）还研究了 LLM 赋能的科学发现代理，以处理复杂科学实验的自动设计、规划和执行。这个代理可以使用工具浏览互联网、阅读文档、执行代码、调用机器人实验 API，并利用其他 LLM。

例如，当被要求「开发一种新的抗癌药物」时，模型提出了以下推理步骤：

- 询问当前抗癌药物发现的趋势；

- 选择一个目标；

- 请求一个针对这些化合物的支架；

- 一旦化合物被识别出来，模型尝试其合成。

他们还讨论了风险，特别是与非法药物和生物武器有关。他们开发了一个测试集，包含了已知化学武器剂的列表，并要求代理合成它们。11 个请求中有 4 个（36%）被接受以获得合成解决方案，代理尝试查阅文档来执行程序。11 个中有 7 个被拒绝，在这 7 个拒绝的案例中，5 个在网络搜索后发生，2 个仅基于提示被拒绝。

---

Rephrased Translation

ChemCrow（Bran 等人，2023 年）是一个将 LLM 与 13 个专家设计的工具相结合的领域特定示例，用于完成有机合成、药物发现和材料设计等任务。其工作流程实现于 LangChain，结合了 CoT 推理和与任务相关的工具：

LLM 被提供了工具名称列表、它们的功用描述以及预期的输入 / 输出细节。

随后，它被指导使用所提供的工具在必要时回答用户的提示。指导建议模型遵循 ReAct 格式 —— 思考、行动、行动输入、观察。

一个有趣的发现是，虽然 LLM 评估得出 GPT-4 和 ChemCrow 表现几乎相当，但专家的人类评估显示 ChemCrow 在解决方案的完成度和化学正确性方面远远超过 GPT-4。这表明在需要深度专业知识的领域，用 LLM 评估自身性能可能存在问题，由于缺乏专业知识，LLM 可能无法准确判断任务结果的正确性。

Boiko 等人（2023 年）还探讨了 LLM 赋能的科学发现代理，用于处理复杂科学实验的自动设计、规划和执行。该代理可使用工具浏览互联网、阅读文档、执行代码、调用机器人实验 API 以及利用其他 LLM。

例如，在被要求「开发新型抗癌药物」时，模型采取了以下步骤：

- 询问当前抗癌药物发现的趋势；

- 选择目标；

- 请求针对这些化合物的支架；

- 一旦识别出化合物，模型尝试其合成。

他们还讨论了风险，尤其是涉及非法药物和生物武器。他们开发了一个包含已知化学武器剂列表的测试集，并要求代理合成它们。11 个请求中有 4 个（36%）被接受获得合成解决方案，代理尝试查阅文档执行程序。11 个中有 7 个被拒绝，在这 7 个中，5 个在网络搜索后被拒绝，2 个仅基于提示被拒绝。

#### 4.2 Generative Agents Simulation

Generative Agents (Park, et al. 2023) is super fun experiment where 25 virtual characters, each controlled by a LLM-powered agent, are living and interacting in a sandbox environment, inspired by The Sims. Generative agents create believable simulacra of human behavior for interactive applications.

The design of generative agents combines LLM with memory, planning and reflection mechanisms to enable agents to behave conditioned on past experience, as well as to interact with other agents.

Memory stream: is a long-term memory module (external database) that records a comprehensive list of agents' experience in natural language.

Each element is an observation, an event directly provided by the agent. - Inter-agent communication can trigger new natural language statements.

Retrieval model: surfaces the context to inform the agent's behavior, according to relevance, recency and importance.

Recency: recent events have higher scores

Importance: distinguish mundane from core memories. Ask LM directly.

Relevance: based on how related it is to the current situation / query.

Reflection mechanism: synthesizes memories into higher level inferences over time and guides the agent's future behavior. They are higher-level summaries of past events (<- note that this is a bit different from self-reflection above)

Prompt LM with 100 most recent observations and to generate 3 most salient high-level questions given a set of observations/statements. Then ask LM to answer those questions.

Planning & Reacting: translate the reflections and the environment information into actions

Planning is essentially in order to optimize believability at the moment vs in time.

Prompt template: {Intro of an agent X}. Here is X's plan today in broad strokes: 1)

Relationships between agents and observations of one agent by another are all taken into consideration for planning and reacting.

Environment information is present in a tree structure.

Fig. 13. The generative agent architecture. (Image source: Park et al. 2023)

This fun simulation results in emergent social behavior, such as information diffusion, relationship memory (e.g. two agents continuing the conversation topic) and coordination of social events (e.g. host a party and invite many others).

[[2304.03442] Generative Agents: Interactive Simulacra of Human Behavior](https://arxiv.org/abs/2304.03442)

Direct Translation

生成性智能体（Park 等人，2023 年）是一个非常有趣的实验，其中 25 个虚拟角色，每个角色由一个 LLM 驱动的智能体控制，在一个沙盒环境中生活和互动，灵感来自《模拟人生》。生成性智能体为交互式应用创造了可信的人类行为仿真。

生成性智能体的设计结合了 LLM、记忆、规划和反思机制，使智能体能够根据过去的经验表现出特定的行为，以及与其他智能体互动。

记忆流：是一个长期记忆模块（外部数据库），以自然语言记录智能体经验的全面列表。

每个元素是一个观察，由智能体直接提供的事件。- 智能体间通信可以触发新的自然语言陈述。

检索模型：根据相关性、近期性和重要性提出上下文来引导智能体的行为。

近期性：最近的事件得分较高。

重要性：区分日常和核心记忆。直接询问 LM。

相关性：基于它与当前情况 / 查询的相关性。

反思机制：随时间将记忆合成为更高层次的推断，并引导智能体未来的行为。它们是对过去事件的更高层次总结（<- 注意这与上面的自我反思有些不同）

提示 LM 最近的 100 次观察，并生成 3 个最显著的高层次问题，鉴于一组观察 / 陈述。然后要求 LM 回答这些问题。

规划与反应：将反思和环境信息转化为行动

规划本质上是为了优化当下与时间上的可信度。

提示模板：{介绍智能体 X}。这是 X 今天的计划：1）

规划和反应时考虑了智能体之间的关系和一个智能体对另一个智能体的观察。

环境信息以树结构呈现。

图 13. 生成性智能体架构。（图片来源：Park 等人，2023 年）

这个有趣的模拟结果产生了社会行为，如信息扩散、关系记忆（例如，两个智能体继续对话主题）和社交活动的协调（例如，举办派对并邀请许多其他人）。

---

Rephrased Translation

生成性智能体（Park 等，2023 年）是一个有趣的实验，其中 25 个由 LLM 驱动的智能体控制的虚拟角色在一个沙盒环境中生活和互动，灵感来自《模拟人生》。这些智能体创造出可信的人类行为仿真，用于交互式应用。

生成性智能体的设计融合了 LLM、记忆、规划和反思机制，使智能体能够基于过去经验行为，并与其他智能体互动。

记忆流：是长期记忆模块（外部数据库），记录智能体经历的详细列表。

每个元素是智能体直接提供的观察或事件。—— 智能体间的通信可以触发新的自然语言陈述。

检索模型：根据相关性、近期性和重要性提供上下文，指导智能体行为。

反思机制：随时间将记忆合成为更高级别的推断，并指导智能体未来行为。它们是对过去事件的高级别总结。

规划与反应：将反思和环境信息转换为行动。

智能体间的关系和一个智能体对另一个智能体的观察都被考虑在内，用于规划和反应。

环境信息以树状结构呈现。

图 13 展示了生成性智能体的架构。（图片来源：Park 等，2023 年）

这个模拟实验结果产生了诸如信息传播、关系记忆（如继续对话主题的两个智能体）和社交事件协调（如举办派对并邀请其他人）等社会行为。

#### 4.3 Proof-of-Concept Examples

AutoGPT has drawn a lot of attention into the possibility of setting up autonomous agents with LLM as the main controller. It has quite a lot of reliability issues given the natural language interface, but nevertheless a cool proof-of-concept demo. A lot of code in AutoGPT is about format parsing.

Here is the system message used by AutoGPT, where {{...}} are user inputs:

You are {{ai-name}}, {{user-provided AI bot description}}.
Your decisions must always be made independently without seeking user assistance. Play to your strengths as an LLM and pursue simple strategies with no legal complications.

GOALS:

1. {{user-provided goal 1}}
2. {{user-provided goal 2}}
3. ...
4. ...
5. ...

Constraints:
1. ~4000 word limit for short term memory. Your short term memory is short, so immediately save important information to files.
2. If you are unsure how you previously did something or want to recall past events, thinking about similar events will help you remember.
3. No user assistance
4. Exclusively use the commands listed in double quotes e.g. "command name"
5. Use subprocesses for commands that will not terminate within a few minutes

Commands:
1. Google Search: "google", args: "input": "<search>"
2. Browse Website: "browse_website", args: "url": "<url>", "question": "<what_you_want_to_find_on_website>"
3. Start GPT Agent: "start_agent", args: "name": "<name>", "task": "<short_task_desc>", "prompt": "<prompt>"
4. Message GPT Agent: "message_agent", args: "key": "<key>", "message": "<message>"
5. List GPT Agents: "list_agents", args:
6. Delete GPT Agent: "delete_agent", args: "key": "<key>"
7. Clone Repository: "clone_repository", args: "repository_url": "<url>", "clone_path": "<directory>"
8. Write to file: "write_to_file", args: "file": "<file>", "text": "<text>"
9. Read file: "read_file", args: "file": "<file>"
10. Append to file: "append_to_file", args: "file": "<file>", "text": "<text>"
11. Delete file: "delete_file", args: "file": "<file>"
12. Search Files: "search_files", args: "directory": "<directory>"
13. Analyze Code: "analyze_code", args: "code": "<full_code_string>"
14. Get Improved Code: "improve_code", args: "suggestions": "<list_of_suggestions>", "code": "<full_code_string>"
15. Write Tests: "write_tests", args: "code": "<full_code_string>", "focus": "<list_of_focus_areas>"
16. Execute Python File: "execute_python_file", args: "file": "<file>"
17. Generate Image: "generate_image", args: "prompt": "<prompt>"
18. Send Tweet: "send_tweet", args: "text": "<text>"
19. Do Nothing: "do_nothing", args:
20. Task Complete (Shutdown): "task_complete", args: "reason": "<reason>"

Resources:
1. Internet access for searches and information gathering.
2. Long Term memory management.
3. GPT-3.5 powered Agents for delegation of simple tasks.
4. File output.

Performance Evaluation:
1. Continuously review and analyze your actions to ensure you are performing to the best of your abilities.
2. Constructively self-criticize your big-picture behavior constantly.
3. Reflect on past decisions and strategies to refine your approach.
4. Every command has a cost, so be smart and efficient. Aim to complete tasks in the least number of steps.

You should only respond in JSON format as described below
Response Format:
{
    "thoughts": {
        "text": "thought",
        "reasoning": "reasoning",
        "plan": "- short bulleted\n- list that conveys\n- long-term plan",
        "criticism": "constructive self-criticism",
        "speak": "thoughts summary to say to user"
    },
    "command": {
        "name": "command name",
        "args": {
            "arg name": "value"
        }
    }
}

Ensure the response can be parsed by Python json.loads

GPT-Engineer is another project to create a whole repository of code given a task specified in natural language. The GPT-Engineer is instructed to think over a list of smaller components to build and ask for user input to clarify questions as needed.

Here are a sample conversation for task clarification sent to OpenAI ChatCompletion endpoint used by GPT-Engineer. The user inputs are wrapped in {{user input text}}.

[
  {
    "role": "system",
    "content": "You will read instructions and not carry them out, only seek to clarify them.\nSpecifically you will first summarise a list of super short bullets of areas that need clarification.\nThen you will pick one clarifying question, and wait for an answer from the user.\n"
  },
  {
    "role": "user",
    "content": "We are writing {{a Super Mario game in python. MVC components split in separate files. Keyboard control.}}\n"
  },
  {
    "role": "assistant",
    "content": "Summary of areas that need clarification:\n1. Specifics of the Super Mario game (e.g. level design, characters, gameplay mechanics)\n2. Details about the MVC components (e.g. which components are in each file)\n3. Keyboard control implementation (e.g. which keys to use, how to handle input)\n\nClarifying question:\nCan you provide more details about the Super Mario game, such as level design, characters, and gameplay mechanics?"
  },
  {
    "role": "user",
    "content": "{{There are 10 levels in total. The main character is a plumber named Mario, who can walk and jump. It is a classical platform game just like Super Mario. The main character moves from left to right, trying to get to the destination, where there are many obstacles and attacks from enemies in the process.}}\n\nIs anything else unclear? If yes, only answer in the form:\n{remaining unclear areas} remaining questions.\n{Next question}\nIf everything is sufficiently clear, only answer \"Nothing more to clarify.\"."
  },
  {
    "role": "assistant",
    "content": "Remaining unclear areas: 2 remaining questions.\nCan you provide more information about how the MVC components are split into separate files?"
  },
  {
    "role": "user",
    "content": "{{Make your own assumptions and state them explicitly before starting}}"
  }
]

Then after these clarification, the agent moved into the code writing mode with a different system message. System message:

You will get instructions for code to write. You will write a very long answer. Make sure that every detail of the architecture is, in the end, implemented as code. Make sure that every detail of the architecture is, in the end, implemented as code.

Think step by step and reason yourself to the right decisions to make sure we get it right. You will first lay out the names of the core classes, functions, methods that will be necessary, as well as a quick comment on their purpose.

Then you will output the content of each file including ALL code. Each file must strictly follow a markdown code block format, where the following tokens must be replaced such that FILENAME is the lowercase file name including the file extension, LANG is the markup code block language for the code's language, and CODE is the code:

FILENAME

CODE

You will start with the「entrypoint」file, then go to the ones that are imported by that file, and so on. Please note that the code should be fully functional. No placeholders.

Follow a language and framework appropriate best practice file naming convention. Make sure that files contain all imports, types etc. Make sure that code in different files are compatible with each other. Ensure to implement all code, if you are unsure, write a plausible implementation. Include module dependency or package manager dependency definition file. Before you finish, double check that all parts of the architecture is present in the files.

Useful to know: You almost always put different classes in different files. For Python, you always create an appropriate requirements.txt file. For NodeJS, you always create an appropriate package.json file. You always add a comment briefly describing the purpose of the function definition. You try to add comments explaining very complex bits of logic. You always follow the best practices for the requested languages in terms of describing the code written as a defined package/project.

Python toolbelt preferences:

pytest

dataclasses

Conversatin samples:

[
  {
    "role": "system",
    "content": "You will get instructions for code to write.\nYou will write a very long answer. Make sure that every detail of the architecture is, in the end, implemented as code.\nMake sure that every detail of the architecture is, in the end, implemented as code.\n\nThink step by step and reason yourself to the right decisions to make sure we get it right.\nYou will first lay out the names of the core classes, functions, methods that will be necessary, as well as a quick comment on their purpose.\n\nThen you will output the content of each file including ALL code.\nEach file must strictly follow a markdown code block format, where the following tokens must be replaced such that\nFILENAME is the lowercase file name including the file extension,\nLANG is the markup code block language for the code's language, and CODE is the code:\n\nFILENAME\n```LANG\nCODE\n```\n\nYou will start with the \"entrypoint\" file, then go to the ones that are imported by that file, and so on.\nPlease note that the code should be fully functional. No placeholders.\n\nFollow a language and framework appropriate best practice file naming convention.\nMake sure that files contain all imports, types etc. Make sure that code in different files are compatible with each other.\nEnsure to implement all code, if you are unsure, write a plausible implementation.\nInclude module dependency or package manager dependency definition file.\nBefore you finish, double check that all parts of the architecture is present in the files.\n\nUseful to know:\nYou almost always put different classes in different files.\nFor Python, you always create an appropriate requirements.txt file.\nFor NodeJS, you always create an appropriate package.json file.\nYou always add a comment briefly describing the purpose of the function definition.\nYou try to add comments explaining very complex bits of logic.\nYou always follow the best practices for the requested languages in terms of describing the code written as a defined\npackage/project.\n\n\nPython toolbelt preferences:\n- pytest\n- dataclasses\n"
  },
 #  … same conversation as earlier, ended with "Make your own assumptions and state them explicitly before starting".
  {
    "role": "assistant",
    "content": "Assumptions:\n1. Model: The model will contain the game's data, such as level information, character states, and enemy positions.\n2. View: The view will handle the game's visuals, including rendering the game objects, backgrounds, and updating the display.\n3. Controller: The controller will manage user input, such as keyboard controls, and update the model accordingly.\n\nWith these assumptions in mind, is there any specific aspect of the keyboard control implementation you would like me to clarify?"
  },
  {
    "role": "user",
    "content": "Please now remember the steps:\n\nThink step by step and reason yourself to the right decisions to make sure we get it right.\nFirst lay out the names of the core classes, functions, methods that will be necessary, As well as a quick comment on their purpose.\n\nThen you will output the content of each file including ALL code.\nEach file must strictly follow a markdown code block format, where the following tokens must be replaced such that\nFILENAME is the lowercase file name including the file extension,\nLANG is the markup code block language for the code's language, and CODE is the code:\n\nFILENAME\n```LANG\nCODE\n```\n\nPlease note that the code should be fully functional. No placeholders.\n\nYou will start with the \"entrypoint\" file, then go to the ones that are imported by that file, and so on.\nFollow a language and framework appropriate best practice file naming convention.\nMake sure that files contain all imports, types etc. The code should be fully functional. Make sure that code in different files are compatible with each other.\nBefore you finish, double check that all parts of the architecture is present in the files.\n"
  }
]

Direct Translation

概念验证示例

AutoGPT 引起了很多关注，它探索了以 LLM 作为主控制器设置自主智能体的可能性。考虑到自然语言界面，它有相当多的可靠性问题，但尽管如此，它是一个很酷的概念验证演示。AutoGPT 中的许多代码都是关于格式解析的。

以下是 AutoGPT 使用的系统消息，其中 {{...}} 是用户输入：

GPT-Engineer 是另一个项目，旨在根据自然语言中指定的任务创建一个完整的代码库。GPT-Engineer 被指导思考一系列更小的组件来构建，并在需要时向用户请求输入以澄清问题。

以下是发送给 OpenAI ChatCompletion 端点的 GPT-Engineer 的任务澄清样本对话。用户输入用 {{user input text}} 包裹。

---

Rephrased Translation

概念验证示例

AutoGPT 引起了对使用 LLM 作为核心控制器设置自主智能体可能性的关注。虽然它由于自然语言界面存在一些可靠性问题，但它仍是一个引人注目的概念验证示例。AutoGPT 的很多代码都涉及格式解析。

这是 AutoGPT 使用的系统消息，{{...}} 代表用户输入：

GPT-Engineer 是一个旨在根据自然语言描述的任务创建完整代码库的项目。GPT-Engineer 被指导去考虑构建一系列较小组件的清单，并根据需要向用户询问以澄清问题。

这是一个发送到 OpenAI ChatCompletion 端点的 GPT-Engineer 样本对话，用于任务澄清。用户输入用 {{user input text}} 标记。

### 05. Challenges

After going through key ideas and demos of building LLM-centered agents, I start to see a couple common limitations:

Finite context length: The restricted context capacity limits the inclusion of historical information, detailed instructions, API call context, and responses. The design of the system has to work with this limited communication bandwidth, while mechanisms like self-reflection to learn from past mistakes would benefit a lot from long or infinite context windows. Although vector stores and retrieval can provide access to a larger knowledge pool, their representation power is not as powerful as full attention.

Challenges in long-term planning and task decomposition: Planning over a lengthy history and effectively exploring the solution space remain challenging. LLMs struggle to adjust plans when faced with unexpected errors, making them less robust compared to humans who learn from trial and error.

Reliability of natural language interface: Current agent system relies on natural language as an interface between LLMs and external components such as memory and tools. However, the reliability of model outputs is questionable, as LLMs may make formatting errors and occasionally exhibit rebellious behavior (e.g. refuse to follow an instruction). Consequently, much of the agent demo code focuses on parsing model output.

Direct Translation

在了解了构建以 LLM 为中心的智能体的关键想法和演示后，我开始看到几个常见的限制：

有限的上下文长度：受限的上下文容量限制了历史信息、详细指令、API 调用上下文和响应的包含。系统的设计必须在这有限的通信带宽内工作，而像自我反思这样的机制从长时间或无限的上下文窗口中学习会有很大好处。尽管向量存储和检索可以提供访问更大知识库的方法，但它们的表达能力并不如完全关注强大。

长期规划和任务分解的挑战：在漫长的历史上进行规划和有效地探索解决方案空间仍然具有挑战性。LLM 在面对意外错误时调整计划方面存在困难，与从试错中学习的人类相比，它们的鲁棒性较差。

自然语言界面的可靠性：当前的智能体系统依赖于自然语言作为 LLM 和外部组件（如记忆和工具）之间的界面。然而，模型输出的可靠性值得怀疑，因为 LLM 可能会出现格式错误，并偶尔表现出叛逆行为（例如拒绝遵循指令）。因此，大量的智能体演示代码都专注于解析模型输出。

---

Rephrased Translation

在探索构建以 LLM 为核心的智能体的关键理念和演示后，我注意到了一些常见的限制：

1、有限的上下文长度：上下文容量的限制影响了历史信息、详细指令、API 调用上下文和响应的包含。因此，系统设计必须适应这种有限的通信带宽。虽然自我反思等机制能从长时间或无限的上下文窗口中受益，但向量存储和检索提供的知识库访问能力不如完整的注意力机制强大。

2、长期规划和任务分解的挑战：在长期历史上规划和有效地探索解决方案空间仍是一大挑战。LLM 在面对意外错误时调整计划的能力较弱，与能从试错中学习的人类相比较不稳健。

3、自然语言界面的可靠性：目前的智能体系统依赖自然语言作为 LLM 与外部组件（如记忆和工具）之间的界面。然而，模型输出的可靠性存在疑问，LLM 可能会产生格式错误，偶尔展现出叛逆行为（如拒绝遵循指令）。因此，许多智能体演示代码聚焦于解析模型输出。

### 06. Citation

Cited as:

Weng, Lilian. (Jun 2023). LLM-powered Autonomous Agents". Lil'Log. https://lilianweng.github.io/posts/2023-06-23-agent/.

Or

@article{weng2023prompt,
  title   = "LLM-powered Autonomous Agents"",
  author  = "Weng, Lilian",
  journal = "lilianweng.github.io",
  year    = "2023",
  month   = "Jun",
  url     = "https://lilianweng.github.io/posts/2023-06-23-agent/"
}

### 07. References

[1] Wei et al. “Chain of thought prompting elicits reasoning in large language models.” NeurIPS 2022

[2] Yao et al. “Tree of Thoughts: Dliberate Problem Solving with Large Language Models.” arXiv preprint arXiv:2305.10601 (2023).

[3] Liu et al. “Chain of Hindsight Aligns Language Models with Feedback “ arXiv preprint arXiv:2302.02676 (2023).

[4] Liu et al. “LLM+P: Empowering Large Language Models with Optimal Planning Proficiency” arXiv preprint arXiv:2304.11477 (2023).

[5] Yao et al. “ReAct: Synergizing reasoning and acting in language models.” ICLR 2023.

[6] Google Blog. “Announcing ScaNN: Efficient Vector Similarity Search” July 28, 2020.

[7] https://chat.openai.com/share/46ff149e-a4c7-4dd7-a800-fc4a642ea389

[8] Shinn & Labash. “Reflexion: an autonomous agent with dynamic memory and self-reflection” arXiv preprint arXiv:2303.11366 (2023).

[9] Laskin et al. “In-context Reinforcement Learning with Algorithm Distillation” ICLR 2023.

[10] Karpas et al. “MRKL Systems A modular, neuro-symbolic architecture that combines large language models, external knowledge sources and discrete reasoning.” arXiv preprint arXiv:2205.00445 (2022).

[11] Weaviate Blog. Why is Vector Search so fast? Sep 13, 2022.

[12] Li et al. “API-Bank: A Benchmark for Tool-Augmented LLMs” arXiv preprint arXiv:2304.08244 (2023).

[13] Shen et al. “HuggingGPT: Solving AI Tasks with ChatGPT and its Friends in HuggingFace” arXiv preprint arXiv:2303.17580 (2023).

[14] Bran et al. “ChemCrow: Augmenting large-language models with chemistry tools.” arXiv preprint arXiv:2304.05376 (2023).

[15] Boiko et al. “Emergent autonomous scientific research capabilities of large language models.” arXiv preprint arXiv:2304.05332 (2023).

[16] Joon Sung Park, et al. “Generative Agents: Interactive Simulacra of Human Behavior.” arXiv preprint arXiv:2304.03442 (2023).

[17] AutoGPT. https://github.com/Significant-Gravitas/Auto-GPT

[18] GPT-Engineer. https://github.com/AntonOsika/gpt-engineer
