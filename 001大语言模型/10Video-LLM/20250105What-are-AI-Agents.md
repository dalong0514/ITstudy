## 20250105What-are-AI-Agents

[What are AI Agents? - YouTube](https://www.youtube.com/watch?v=F8NKVhkZZWI&t=1s)

2024 will be the year of AI agents. So what are AI agents? And to start explaining that, we have to look at the various shifts that we're seeing in the field of generative AI. And the first shift I would like to talk to you about is this move from monolithic models to compound AI systems.

2024 年将是 AI 智能体大放异彩的一年。那么，究竟什么是 AI 智能体呢？为了解释清楚这个问题，我们需要先了解生成式 AI 领域正在发生的几大转变。首先，我想和大家聊聊从单体模型向复合 AI 系统演变的趋势。

So models on their own are limited by the data they've been trained on. So that impacts what they know about the world and what sort of tasks they can solve. They are also hard to adapt. So you could tune a model, but it would take an investment in data and in resources.

因此，模型的能力会受到其训练数据的限制。这直接影响了模型对世界的认知以及能够处理的任务类型。而且，这些模型很难进行调整。虽然可以通过微调模型来使其适应新的任务，但这需要投入大量的数据和计算资源。

So let's take a concrete example to illustrate this point. I want to plan a vacation for this summer, and I want to know how many vacation days are at my disposal. What I can do is take my query, feed that into a model that can generate a response. I think we can all expect that this answer will be incorrect because the model doesn't know who I am and does not have access to this sensitive information about me.

所以，让我们用一个具体的例子来说明这一点。我想为今年夏天计划一次假期，并且想知道我能有多少天的假期。我可以将我的查询输入到一个可以生成回复的模型中。我想大家都能预料到，这个答案会是不正确的，因为模型不知道我是谁，也无法访问我的个人敏感信息。

So models on their own could be useful for a number of tasks, as we've seen in other videos. So they can help with summarizing documents. They can help me with creating first drafts for emails and different reports I'm trying to do. But the magic gets unlocked when I start building systems around the model and actually take the model and integrate them into the existing processes I have.

因此，正如我们在其他视频中看到的，模型本身在许多任务中都很有用。它们可以帮助总结文档。它们可以帮助我为我尝试做的电子邮件和不同的报告创建初稿。但是，当开始围绕模型构建系统，并将其整合到现有流程中时，其真正的潜力才得以释放。

So if we were to design a system to solve this, I would have to give the model access to the database where my vacation data is stored. So that same query would get fed into the language model. The difference now is the model would be prompted to create a search query. And that would be a search query that can go into the database that I have. So that would go and fetch the information from the database, output an answer, and then that would go back into the model that can generate a sentence to answer. So Maya, you have 10 days left in your vacation database. So the answer that I would get here would be correct.

因此，如果要设计一个系统来解决这个问题，我需要让模型访问存储我假期数据的数据库。用户发起的查询会被输入到大语言模型中。不同之处在于，模型现在会被引导生成一个搜索查询，这个查询可以直接发送到我的数据库中。系统会从数据库中提取信息，输出答案，然后将答案返回给模型，由模型生成一句回答。例如，系统会说，「Maya，你的假期数据库中还剩 10 天」。这样得到的答案就是正确的。

This is an example of a compound AI system, and it recognizes that certain problems are better solved when you apply the principles of system design. So what does that mean? By the term system, you can understand there's multiple components. So systems are inherently modular. I can have a model. I can choose between tuned models, large language models, image generation models, but also I have programmatic components that can come around it. So I can have output verifiers. I can have programs that can take a query and then break it down to increase the chances of the answer being correct. I can combine that with searching databases. I can combine that with different tools.

这是一个复合 AI 系统的例子，它意识到应用系统设计的原则能更好地解决某些问题。这是什么意思呢？「系统」一词指的是由多个组件构成。因此，系统本质上是模块化的。我可以选择不同的模型，例如微调过的模型、大语言模型（LLM）、图像生成模型，同时我还可以使用围绕这些模型的程序化组件。例如，我可以加入输出验证器，或者使用程序来接收查询，并将其分解，从而提高答案的准确性。此外，我还可以将这些模型与数据库搜索以及各种工具结合使用。

So when we're talking about a system approach is I can break down what I desire my program to do and pick the right components to be able to solve that. And this is inherently easier to solve for than tuning a model. So that makes this much faster and quicker to adapt. Okay. So the example I used below is an example of a compound AI system.

因此，当我们讨论系统方法时，指的是我可以将程序需要完成的任务分解，并选择合适的组件来解决这些任务。这比直接调整模型要容易得多。因此，这种方法能够更快地实现，并且更易于调整。好的。下面我将用一个复合 AI 系统的例子来说明。

You also might be popular with retrieval augmented generation, which is one of the most popular and commonly used compound AI systems out there. Most RAG systems, and the example I used below, are defined in a certain way. So if I bring a very different query, let's say I ask about the weather in this example here, it's going to fail because the path that this program has to follow is to always search my vacation policy database, and that has nothing to do with the weather.

你可能也听说过检索增强生成（retrieval augmented generation），它是目前最流行和常用的组合 AI 系统之一。大多数 RAG 系统，包括我下面要举的例子，都以特定的方式构建。因此，如果我提出一个与预设主题差异很大的查询，例如，我问的是天气情况，那么系统就会失效，因为它被设定为必须始终搜索我的休假政策数据库，而这与天气信息毫无关系。

So when we say the path to answer a query, we are talking about something called the control logic of a program. So compound AI systems, we said most of them have programmatic control logic. So that was something that I defined myself as the human. Now let's talk about where do agents come in.

因此，当我们谈论回答一个查询的路径时，实际上指的是程序的控制逻辑。我们之前提到，大多数复合 AI 系统都具有程序化的控制逻辑，这部分是由我作为人类来定义的。现在，让我们来探讨一下 AI 智能体（AI Agent）是如何出现的。

One other way of controlling the logic of a compound AI system is to put a large language model in charge. And this is only possible because we're seeing tremendous improvements in the capabilities of reasoning of large language models. So large language models, you can feed them complex problems and you can prompt them to break them down and come up with a plan on how to tackle it.

另一种控制复合 AI 系统逻辑的方法是由大语言模型（Large Language Model，LLM）主导。这正是因为我们看到大语言模型在推理能力方面取得了巨大的进步。因此，对于大语言模型，你可以给它们输入复杂的问题，并且你可以引导它们分解问题，并制定解决问题的方案。

Another way to think about it is on one end of the spectrum, I'm telling my system to think fast. Act as programmed. Don't deviate from the instructions I've given you. And on the other end of the spectrum, you're designing your system to think slow. So create a plan, attack each part of the plan, see where you get stuck, see if you need to readjust the plan. So I might give you a complex question. And if you would just give me the first answer that pops into your head, very likely that answer might be wrong. But you have higher chances of success if you break it down, understand where do you need external help to solve some parts of the problem and maybe take an afternoon to solve it.

另一种思考方式是，在某种程度上，我让系统快速思考。按照预设的程序运行，不要偏离我的指令。而在另一种情况下，你设计的系统则需要慢速思考。因此，制定一个计划，执行计划的每个部分，找出你在哪里遇到困难，看看是否需要调整计划。我可能会给你一个复杂的问题。如果你直接给出你脑海中第一个想到的答案，很可能那个答案是错误的。但是，如果你将问题分解，了解在哪些部分需要外部帮助来解决，并且可能花费一个下午来解决，那么你成功的机会会更高。

and when we put llms in charge of the logic this is when we're talking about an agentic approach so let's break down the components of llm agents the first capability is the ability to reason, which we talked about. So this is putting the model at the core of how problems are being solved. The model will be prompted to come up with a plan and to reason about each step of the process along the way.

当大语言模型（LLM/Large Language Model）负责逻辑时，这就是我们所说的智能体（AI Agent）方法。现在，让我们来分析一下大语言模型智能体的组成部分。首先是推理能力，我们之前已经讨论过。这意味着模型成为问题解决的核心。模型会被提示制定计划，并对过程中的每一步进行推理。

Another capability of agents is the ability to act. And this is done by external programs that are known in the industry as tools. So tools are external pieces of the program, and the model can define when to call them and how to call them in order to best execute the solution to the question they've been asked. So an example of a tool could be search, searching the web, searching a database at their disposal. Another example could be a calculator to do some math. This could be a piece of program code that maybe might manipulate the database. This can also be another language model that maybe you're trying to do a translation task, and you want a model that can be able to do that. And there's so many other possibilities of what can do there. So these could be APIs, basically any piece of external program you want to give your model access to.

智能体的另一项能力是执行操作。这是通过业界称为「工具」的外部程序实现的。工具是程序外部的组成部分，模型可以决定何时以及如何调用这些工具，以便更好地解决用户提出的问题。例如，工具可以是搜索功能，用于在网络或可用的数据库中进行搜索。另一个例子是计算器，用于执行数学运算。工具也可以是一段用于操作数据库的程序代码，或者是一个用于执行翻译任务的语言模型。工具的可能性非常多。它们可以是应用程序编程接口（API），或者任何你想让模型访问的外部程序。

Third capability, that is the ability to access memory. And the term memory can mean a couple of things. So we talked about the models thinking through the program, kind of how you think out loud when you're trying to solve through a problem. So those inner logs can be stored and can be useful to retrieve at different points in time. But also this could be the history of conversations that you as a human had when interacting with the agent. And that would allow to make the experience much more personalized.

第三种能力是访问记忆的能力。「记忆」一词可以有多种含义。我们之前讨论过模型如何像人一样在解决问题时「大声思考」，逐步推演程序。这些内部的思考日志可以被存储，并在需要时被检索，从而发挥作用。此外，「记忆」也可以指代你作为人类与 AI 智能体交互时的对话历史。这能让交互体验更加个性化。

So the way of configuring AI agents, there's many ways to approach it. One of the more most popular ways of going about it is through something called React, which as you can tell by the name, combines the reasoning and act components of LLM agents.

配置 AI 智能体的方法有很多。其中一种比较常用的方法是使用 React，顾名思义，它结合了大语言模型智能体的推理（reasoning）和行动（act）组件。

So let's make this very concrete. What happens when I configure a React agent? You have your user query. That gets fed into a model, so an LLM. The LLM is given a prompt. So the instructions that's given is, don't give me the first answer that pops to you. Think slow. Plan your work. And then try to execute something, try to act. and when you want to act you can define whether if you want to use external tools to help you come up with the solution once you get you call a tool and you get an answer maybe it gave you the wrong answer or it came up with an error you can observe that so the llm would observe the answer would determine if it does answer the question at hand or whether it needs to iterate on the plan and tackle it differently up until I get to a final answer.

为了更具体地说明，当配置一个 React 智能体时会发生什么？用户提出查询后，查询会被输入到一个大语言模型（LLM）中。大语言模型接收到提示，提示的指令是：不要立刻给出最先想到的答案，要慢下来思考，制定工作计划，然后尝试执行操作。当需要执行操作时，可以决定是否使用外部工具来辅助解决问题。调用工具并获得答案后，如果答案错误或出现错误，智能体可以观察到这些情况。大语言模型会根据观察到的结果，判断是否已经回答了当前的问题，或者是否需要调整计划并以其他方式解决，直到获得最终答案。

So let's go back and make this very concrete again. Let's talk about my vacation example. And as you can tell, I'm really excited to go on one. So I want to take the rest of my vacation days. I'm planning to go on to Florida next month. I'm planning on being outdoors a lot. And I'm prone to burning. So I want to know what is the number of two ounce sunscreen bottles that I should bring with me.

现在，让我们回到具体的例子。还是以我的度假计划为例。正如你所见，我非常期待这次旅行。我打算用完剩余的假期，计划下个月去佛罗里达。我准备进行大量的户外活动，而且我很容易被晒伤。因此，我想知道我应该带多少瓶两盎司的防晒霜。

And this is a complex problem. So there's a first thing, there's a number of things to plan. One is how many vacation days am I planning to take? And maybe that is information the system can retrieve from its memory because I asked that question before. Two is how many hours do I plan to be in the sun? I said I plan to be in there a lot. So maybe that would mean looking into the weather forecast for next month in Florida and seeing what is the average sun hours that are expected. Three is trying maybe going to a public health website to understand what is the recommended dosage of sunscreen per hour in the sun. And then four, doing some math to be able to determine how much of that sunscreen fits into two ounce bottles.

这是一个复杂的问题，需要规划多个方面。首先，要计划休多少天假？这或许是系统可以从记忆中检索的信息，因为我之前可能问过类似的问题。其次，计划在阳光下待多久？我提到过会待很长时间，所以可能需要查询佛罗里达州下个月的天气预报，了解预计的平均日照时长。再次，可能需要访问公共卫生网站，了解在阳光下每小时建议使用的防晒霜剂量。最后，还需要进行一些计算，确定需要多少防晒霜才能装满两个盎司（约 59 毫升）的瓶子。

So that's quite complicated, but what's really powerful here is there's so many paths that can be explored in order to solve a problem. So this makes the system quite modular and I can hit it with much more complex problems. So going back to the concept of compound AI systems, compound AI systems are here to stay. What we're going to observe this year is that they're going to become more agentic.

因此，这确实相当复杂，但其真正的强大之处在于，为了解决一个问题，存在着众多可探索的路径。这使得该系统具有高度的模块化特性，从而能够应对更为复杂的问题。回到复合 AI 系统（compound AI systems）的概念，复合 AI 系统将会是未来的发展趋势。今年，我们将观察到它们将变得更加像 AI 智能体（AI Agent）。

The way I like to think about it is you have a sliding scale of LLM autonomy. And the person defining the system would examine what trade-offs they want in terms of autonomy in the system. For certain problems, especially problems that are narrow, well-defined, so you don't expect someone to ask about the weather when they need to ask about vacations. A narrow problem set, you can define a narrow system like this one. It's more efficient to go the programmatic route because every single query will be answered the same way. If I were to apply the agentic approach here, there might be unnecessarily looping an iteration.

我倾向于这样理解，大语言模型（LLM）的自主性存在一个滑动区间。而系统设计者需要权衡他们在系统自主性方面的需求。对于某些问题，尤其是那些范围狭窄、定义明确的问题，比如用户在咨询度假事宜时，我们不希望他们询问天气。对于这种范围有限的问题集，可以构建一个类似的专用系统。采用程序化的方式会更高效，因为每个查询都会得到相同的处理。如果采用 AI 智能体（AI Agent）的方法，可能会出现不必要的循环迭代。

So for narrow problems, programmatic approach can be more efficient than going the agentic route. But if I expect to have a system accomplish very complex tasks, like say, trying to solve GitHub issues independently and handle a variety of queries, a spectrum of queries. This is where an agentic route could be helpful, because it would take you too much effort to configure every single path in the system. And we're still in the early days of agentic systems. We're seeing rapid progress when you combine the effects of system design with agentic behavior. And of course, you will have a human in the loop in most cases as the accuracy is improving.

因此，对于特定问题，编程方法可能比采用基于智能体的方案更有效。但是，如果我期望一个系统完成非常复杂的任务，例如，尝试独立解决 GitHub 问题并处理多种多样的查询。这时，基于智能体的方案可能会有所帮助，因为在系统中配置每个可能的路径会耗费你大量的精力。而且，我们仍处于基于智能体的系统的早期阶段。当系统设计与智能体行为相结合时，我们会看到快速的进展。当然，在大多数情况下，随着准确率的提高，会有人工参与其中。

I hope you found this video very useful, and please subscribe to the channel to learn more.

希望这个视频对你很有帮助，请订阅频道，获取更多精彩内容。