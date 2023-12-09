## 2023051Language-Models-A-Guide-for-the-Perplexed

Language Models: A Guide for the Perplexed

Sofia Serrano∗

Zander Brumbaugh∗ 

Noah A. Smith∗

### 01 IntroductionIn

late November 2022, OpenAI released a web-based chatbot, ChatGPT. Within a few months, ChatGPTwas reported to be the fastest-growing application in history, gaining over 100 million users. Reports in thepopular press touted ChatGPT's ability to engage in conversation, answer questions, play games, write code,translate and summarize text, produce highly fluent content from a prompt, and much more. New releasesand competing products have followed, and there has been extensive discussion about these new tools: Howwill they change the nature of work? How should educators respond to the increased potential for cheating inacademic settings? How can we reduce or detect misinformation in the output? What exactly does it take(in terms of engineering, computation, and data) to build such a system? What principles should informdecisions about the construction, deployment, and use of these tools?Scholars of artificial intelligence, including ourselves, are baffled by this situation. Some were taken abackat how quickly these tools went from being objects of mostly academic interest to artifacts of mainstreampopular culture. Some have been surprised at the boldness of claims made about the technology and itspotential to lead to benefits and harms. The discussion about these new products in public forums is oftenpolarizing. When prompted conversationally, the fluency of these systems' output can be startling; theirinteractions with people are so realistic that some have proclaimed the arrival of human-like intelligence inmachines, adding a strong emotional note to conversations that, not so long ago, would have mostly addressedengineering practices or statistics.Given the growing importance of AI literacy, we decided to write this tutorial to help narrow the gap betweenthe discourse among those who study language models—the core technology underlying ChatGPT andsimilar products—and those who are intrigued and want to learn more about them. In short, we believe theperspective of researchers and educators can add some clarity to the public's understanding of the technologiesbeyond what's currently available, which tends to be either extremely technical or promotional materialgenerated about products by their purveyors.Our approach teases apart the concept of a language model from products built on them, from the behaviorsattributed to or desired from those products, and from claims about similarity to human cognition. As astarting point, we:

1. Offer a scientific viewpoint that focuses on questions amenable to study through experimentation,

2. Situate language models as they are today in the context of the research that led to their development, and

3. Describe the boundaries of what is known about the models at this writing.

Popular writing offers numerous, often thought-provoking metaphors for LMs, including bureaucracies ormarkets (Henry Farrell and Cosma Shalizi), demons (Leon Derczynski), and a“blurry JPEG”of the web (TedChiang). Rather than offering a new metaphor, we aim to empower readers to make sense of the discourseand contribute their own. Our position is that demystifying these new technologies is a first step towardharnessing and democratizing their benefits and guiding policy to protect from their harms.LMs and their capabilities are only a part of the larger research program known as artificial intelligence (AI).(They are often grouped together with technologies that can produce other kinds of content, such as images,under the umbrella of“generative AI.”) We believe they're a strong starting point because they underlie theChatGPT product, which has had unprecedented reach, and also because of the immense potential of naturallanguage for communicating complex tasks to machines. The emergence of LMs in popular discourse, andthe way they have captured the imagination of so many new users, reinforces our belief that the languageperspective is as good a place to start as any in understanding where this technology is heading.The guide proceeds in five parts. We first introduce concepts and tools from the scientific/engineering field ofnatural language processing (NLP), most importantly the notion of a“task”and its relationship to data(section 2). We next define language modeling using these concepts (section 3). In short, language modelingautomates the prediction of the next word in a sequence, an idea that has been around for decades. We thendiscuss the developments that led to the current so-called“large”language models (LLMs), which appear todo much more than merely predict the next word in a sequence (section 4). We next elaborate on the currentcapabilities and behaviors of LMs, linking their predictions to the data used to build them (section 5). Finally,we take a cautious look at where these technologies might be headed in the future (section 6). To overcomewhat could be a terminology barrier to understanding admittedly challenging concepts, we also include aGlossary of NLP and LM words/concepts (including“perplexity,”wryly used in the title of this Guide).

2022 年 11 月下旬，OpenAI 发布了一个基于 web 的聊天机器人 ChatGPT。在几个月内，ChatGPT 被报道成为历史上增长最快的应用程序，获得超过一亿用户。大众媒体的报道吹捧 ChatGPT 能够参与对话、回答问题、玩游戏、编写代码、翻译和总结文本、从提示中生成高度流畅的内容等等。随后出现了新的版本和竞争产品，人们对这些新工具进行了广泛的讨论：它们将如何改变工作的性质？教育者应该如何应对学术环境中日益增加的作弊可能性？如何减少或检测输出中的错误信息？构建这样一个系统需要什么 (在工程、计算和数据方面)? 关于这些工具的构建、部署和使用，应该遵循哪些原则？

包括我们自己在内的人工智能学者对此感到困惑。一些人吃惊地发现，这些工具很快就从学术兴趣的对象变成了主流流行文化的人工制品。一些人对这项技术的大胆宣称及其潜在的利与弊感到惊讶。在公共论坛上对这些新产品的讨论常常两极分化。当以对话方式提示时，这些系统输出的流畅性会令人吃惊；他们与人的互动是如此现实，以至于有些人宣称机器中出现了类似人类的智能，为不久前主要涉及工程实践或统计的对话增添了强烈的情感色彩。

鉴于人工智能素养日益重要，我们决定编写本教程，以帮助缩小那些研究语言模型 (ChatGPT 和类似产品的核心技术) 的人与那些感兴趣并想了解更多的人之间的差距。简言之，我们相信研究者和教育者的观点可以使公众对现有技术的理解更加清晰，这些技术往往是由供应商提供的关于产品的技术性或宣传性材料。

我们的方法将语言模型的概念与构建在其上的产品、归因于这些产品或期望从这些产品中获得的行为以及与人类认知相似的主张区分开来。作为起点，我们：

1. 提供一个科学的观点，聚焦于可通过实验研究的问题，

2. 将语言模型定位在导致其发展的研究背景中，以及 3. 描述本文中关于模型的已知边界。

流行的写作为 LMs 提供了许多 ，通常是发人深省的隐喻 ，包括 (亨利·法雷尔和科斯玛·沙利兹)，(莱昂·德钦斯基) 和 (特德·蒋)。我们的目标不是提供一个新的隐喻，而是使读者能够理解话语并贡献自己的力量。我们的立场是，揭开这些新技术的神秘面纱是利用和民主化它们的好处和指导政策以防止其危害的第一步。官僚机构或市场恶魔模糊 JPEG 属于这个 web LMs 及其功能只是更大的人工智能 (AI) 研究项目的一部分。(它们通常与能够产生其他类型内容 (如图像) 的技术组合在一起，在「生成 AI」的保护伞下。) 我们认为它们是一个强有力的起点，因为它们是 ChatGPT 产品的基础，ChatGPT 产品具有前所未有的影响力，也因为自然语言在向机器传达复杂任务方面具有巨大潜力。LMs 在流行语篇中的出现，以及它们吸引了如此多新用户的想象力的方式，强化了我们的信念，即语言视角是理解这项技术走向的最佳起点。





本指南分为五个部分。我们首先介绍自然语言处理 (NLP) 科学 / 工程领域的概念和工具，最重要的是「任务」的概念及其与数据的关系 (第节)。接下来我们将使用这些概念定义语言建模 (第节)。简而言之，语言建模可以自动预测序列中的下一个单词，这一想法已经存在了几十年。然后，我们讨论导致当前所谓的「大型」语言模型 (LLM) 的发展，LLM 似乎不仅仅是预测序列中的下一个单词 (第 4 节)。接下来，我们将详细介绍 LMs 的当前功能和行为，并将其预测与用于构建 LMs 的数据联系起来 (第 5 节)。最后，我们将仔细研究这些技术在未来的发展方向 (第 6 节)。为了克服可能成为理解公认具有挑战性概念的术语障碍，我们还包括 NLP 和 LM 词汇表 (包括本指南标题中讽刺地使用的「困惑」)。23


### 02. Background

Background: Natural language processing concepts and tools

Language models as they exist today are the result of research in various disciplines, including informationtheory, machine learning, speech processing, and natural language processing.1 This work's authors belong tothe community of natural language processing (NLP) researchers, members of which have been exploringthe relationship between computers and natural languages since the 1960s.2 Two fundamental and relatedquestions asked in this community are:“In what ways can computers understand and use natural language?”and“To what extent can the properties of natural languages be simulated computationally?”The first questionhas been approached mainly by attempts to build computer programs that show language-understanding andlanguage-use behavior (such as holding a conversation with a person); it is largely treated as an engineeringpursuit that depends heavily on advances in hardware. The second question brings NLP into contact withthe fields of linguistics, cognitive science, and psychology. Here, language tends to be viewed through ascientific lens (seeking to experimentally advance the construction of theories about natural language as anobservable phenomenon) or sometimes through a mathematical lens (seeking formal proofs). Because thesetwo questions are deeply interconnected, people interested in either of them often converse and collaborate,and many are interested in both questions.We believe the concepts (ideas, terminology, and questions) and tools (problem-solving methods) the NLPcommunity uses in research are helpful in advancing understanding of language models. They are familiar tomany AI researchers and practitioners, and similar ones have evolved in other communities (for example,computer vision). If you have experience with computer programming, data science, or the discrete math1A“natural language”is a language that developed naturally in a community, like Hawaiian or Portuguese or American SignLanguage. For the most part, NLP researchers focus on human languages and specifically written forms of those languages. Mostoften, natural languages contrast with programming languages like Python and C++, which are artifacts designed deliberatelywith a goal in mind.

2There are other uses of the“NLP”acronym with very different meanings. Ambiguous terms and expressions are common in

natural languages, and one of the challenges of the field of NLP.

3

foundations of computer science, you may have been exposed to these ideas before, but we don't believe theyare universally or consistently taught in classes on those topics. Having a basic understanding of them willhelp you to think like an NLP expert.

2.1 Taskification: Defining what we want a system to doThe first step in building a machine is deciding what we want the machine to do. People who build powerplants, transportation devices, or cooking appliances work from a specification that spells out the inputs andoutputs of the desired system in great detail. It's not enough to say that“the power plant must provideelectricity to all the homes in its town.”Engineers require a precise statement of how many kiloWatt-hoursare to be produced, the budget for building the plant, environmental impacts expected, all the laws regulatingthe construction of plants that are in effect to guarantee safety, and much more.To take an example that's much simpler and more relevant to building an NLP system, consider a computerprogram (which is a“machine”in a very abstract sense; we'll also call it a“system”) that sorts a list ofnames alphabetically. This task sounds simple, and computer science students would likely start thinkingabout different procedures for sorting lists. There are, however, some details that need to be addressed beforewe start writing code, such as:

• How will the names be input to the program, and what should the program do with the output? (E.g.,will the program run locally on a user's laptop? Or is there a web interface users will use to type in theinput and then see the output in their browser tab? Or will they upload/download files? If so, what isthe format for those files?)

• What set of characters will appear in the input, and what rules are we using to order them? (E.g., howdo we handle the apostrophe in a name like“O'Donnell”? How should diacritic (accented) charactersbe handled? What happens if some names are in Latin script and others in Arabic script?)

• Are there constraints on how much memory the program can use, or on how quickly it needs to execute?If the input list is so long that the program will violate those constraints, should the user get a failuremessage?

Figure 1: Some tasks, like alphabetical name sorting, may seem very simple but often raise detailed questionsthat must be addressed for a full specification.

These may seem like tedious questions, but the more thoroughly we anticipate the eventual use of the systemwe're building, the better we can ensure it will behave as desired across all possible cases.

2.1.1 Abstract vs. concrete system capabilitiesWhen building an NLP system, the situation is no different than the name sorter, except that it's considerablyharder to be precise. Consider some of the kinds of capabilities the NLP community has been targeting in itssixty-year history:

• Translate text from one language to another• Summarize one or more documents in a few paragraphs or in a structured table• Answer a question using information in one or more documents• Engage in a conversation with a person and follow any instructions they give

4

Each of these high-level applications immediately raises a huge number of questions, likely many more thanfor simpler applications like the name sorter, because of the open-ended nature of natural language input (andoutput). Some answers to those questions could lead an expert very quickly to the conclusion that the desiredsystem just isn't possible yet or would be very expensive to build with the best available methods. Researchersmake progress on these challenging problems by trying to define tasks, or versions of the application thatabstract away some details while making some simplifying assumptions.For example, consider the translation of text from one language to another. Here are some fairly conventionalassumptions made in many translation research projects:

• The input text will be in one of a small set of languages; it will be formatted according to newspaper-like

writing conventions. The same holds for the output text.

• Text will be translated one sentence or relatively short segment of text at a time.• The whole segment will be available during translation (that is, translation isn't happening in“real

time”as the input text is produced, as might be required when subtitling a live broadcast).

It's not hard to find research on automatic translation that makes different assumptions from those above. Anew system that works well and relies on fewer assumptions is typically celebrated as a sign that the researchcommunity is moving on to harder problems. For example, it's only in the past few years that we have madethe leap from systems that support single input-to-output translations to systems that support multipleinput-to-output languages. We highlight that there are always some narrowing assumptions, hopefullytemporary, that make a problem more precise and therefore more solvable.We believe that many discussions about AI systems become more understandable when we recognize theassumptions beneath a given system. There is a constant tension between tasks that are more general/abstract,on which progress is more impactful and exciting to researchers, and tasks that are more specific/concrete.Solving a concrete, well-defined task may be extremely useful to someone, but certain details of how thattask is defined might keep progress on that task from being useful to someone else. To increase the chancesthat work on a concrete task will generalize to many others, it's vital to have a real-world user communityengaged in the definition of that task.

2.1.2 We need data and an evaluation method for research progress on a taskThe term“task”is generally used among researchers to refer to a specification of certain components of anNLP system, most notably data and evaluation:

• Data: there is a set of realistic demonstrations of possible inputs paired with their desirable outputs.• Evaluation: there is a method for measuring, in a quantitative and reproducible way, how well any

system's output matches the desired output.

Considerable research activity focuses on building datasets and evaluation methods for NLP research, and thetwo depend heavily on each other. Consider again the translation example. Examples of translation betweenlanguages are easy to find for some use cases. A classic example is parliamentary language translated fromEnglish to French, or vice versa. The proceedings of the Canadian Parliament are made available to the publicin both English and French, so human translators are constantly at work producing such demonstrations;paired bilingual texts are often called“parallel text”in the research community. The European Parliamentdoes the same for multiple languages. Finding such data isn't as easy for some languages or pairs of languages,and as a result, there has been considerably more progress on automated translation for European languagesthan for others.What about evaluation of translation? One way to evaluate how well a system translates text is to takea demonstration, feed the input part to a system, and then show a human judge the desired output andthe system output. We can ask the judge how faithful the system output is to the desired output. If thejudge speaks both languages, we can show them the input instead of the desired output (or in addition to it)and ask the same question. We can also ask human judges to look only at the system output and judge thefluency of the text. As you can imagine, there are many possible variations, and the outcomes might dependon exactly what questions we ask, how we word those questions, which judges we recruit, how much they

5

know about translation systems already, how well they know the language(s), and whether and how much wepay them.In 2002, to speed up translation evaluation in research work, researchers introduced a fully automated way toevaluate translation quality called“Bleu”scores (Papineni et al. 2002), and there have been many proposedalternatives since then, with much discussion over how well these cheaper automatic methods correlate withhuman judgments. One challenge for automatic evaluation of translation is that natural languages offer manyways to say the same thing. In general, reliably rating the quality of a translation could require recognizingall of the alternatives because the system could (in principle) choose any of them.We used translation as a running example precisely because these questions are so contentious and potentiallycostly for this task. We'll next consider a fairly concrete task that's much simpler: categorizing the overalltone of a movie review (positive vs. negative), instantiating a more general problem known as sentimentanalysis. Here, researchers have collected demonstrations from movie review websites that pair reviews withnumerical ratings (e.g.„ one to five stars). If a system takes a review as input and predicts the rating, we caneasily check whether the output exactly matches the actual rating given by the author, or we could calculatethe difference between the system and correct ratings. Here, the collection of data is relatively easy, and thedefinition of system quality is fairly uncontroversial: the fewer errors a system makes (or the smaller thedifference between the number of author stars and system-predicted stars), the higher the system's quality.Note, however, that a system that does well on the movie review sentiment task may not do so well on reviewsof restaurants, electronics products, or novels. This is because the language people use to say what they likeor don't like about a movie won't carry the same meaning in a different context. (If a reviewer says that amovie“runs for a long time,”that isn't as obviously positive as the same remark about a battery-operatedtoothbrush, for example.) In general, knowing the scope of the task and how a system was evaluated arecrucial to understanding what we can expect of a system in terms of its generalizability, or how well itsperformance quality holds up as it's used on inputs less and less like those it was originally evaluated on. It'salso essential when we compare systems; if the evaluations use different demonstrations or measure qualitydifferently, a comparison won't make sense.For most of its history, NLP has focused on research rather than development of deployable systems. Recentinterest in user-facing systems highlights a longstanding tension in taskification and the dataset and evaluationrequirements. On one hand, researchers prefer to study more abstract tasks so that their findings will bemore generally applicable across many potential systems. The scientific community will be more excited,for example, about improvements we can expect will hold across translation systems for many languagepairs (rather than one) or across sentiment analysis systems for many kinds of reviews (rather than justmovies). On the other hand, there is near-term value in making a system that people want to use because itsolves a specific problem well, which requires being more concrete about the intended users, their data, andmeaningful evaluation.There is yet another step between researching even fairly concrete tasks and building usable systems. Theseare evaluated very differently. Evaluations in research tend to focus on specific, narrowly defined capabilities,as exemplified in a sample of data. It's an often unstated assumption in research papers that improvedtask performance will generalize to similar tasks, perhaps with some degradation. The research communitytends to share such assumptions, with the exception of research specifically on generalization and robustnessacross domains of data. Meanwhile, deployable systems tend to receive more rigorous testing with intendedusers, at least to the extent that they are built by organizations with an interest in pleasing those users. Indeployment,“task performance”is only part of what's expected (systems must also be reasonably fast, haveintuitive user interfaces, pose little risk to users, and more).People interested in NLP systems should be mindful of the gaps between (1) high-level,aspirational capabilities, (2) their "taskified" versions that permit measurable research progress,and (3) user-facing products. As research advances, and due to the tension discussed above,the "tasks" and their datasets and evaluation measures are always in flux.

6

2.2 A closer look at data: where it comes from and how it's usedFor the two task examples discussed above (translation and sentiment analysis tasks), we noted thatdemonstrations (inputs with outputs) would be relatively easy to find for some instances of the tasks.However, data might not always be so easy to come by. The availability of data is a significant issue for tworeasons:

• For most NLP applications, and most tasks that aim to approximate those applications, there is no“easy”source of data. (Sentiment analysis for movie reviews is so widely studied, we believe, because thedata is unusually easy to find, not because there is especially high demand for automatic number-of-starsprediction.)

• The best known techniques for building systems require access to substantial amounts of extra data to

build the system, not just to evaluate the quality of its output.

2.2.1 Differentiating training from test dataFrom here on, we refer to data used to build a system as training data and data used to evaluate systemsas test data. This distinction is extremely important for a reason that's easy to understand.

Figure 2: When data is split into training and test sets, it's critical there is no overlap between the two.

Consider a student who somehow gets a copy of the final exam for one of their classes a few weeks before theexam. Regardless of how much the student is to blame in accessing the test, regardless of whether they evenknew the exam they saw was the actual final exam, regardless of how honorably they behaved during thoseweeks and during the test, if they get a high score, the instructor cannot conclude that the student learnedthe material. The same holds true for an NLP system. For the test data to be useful as an indicator of thequality of the system's output, it is necessary that the test data be“new”to the system. We consider thisthe cardinal rule of experimentation in NLP: The test data cannot be used for any purpose prior tothe final test. Occasionally, someone will discover a case where this rule was violated, and (regardless ofthe intent or awareness of those who broke the rule) the conclusions of any research dependent on that casemust be treated as unreliable.

7

To get a sense of an NLP system's actual quality, it is crucial that the system not be evaluatedon data it has seen during training.

2.2.2 Creating a dataset from scratchLet's consider a variant of the sentiment analysis problem that might emerge in a high-stakes academicdecision-making setting. Suppose we plan to build an NLP system that reads recommendation letters forapplicants to a university degree program. The system should rate the sentiment of the recommender towardthe applicant. On the surface, this is similar to the movie review problem we discussed previously. But thisuse case introduces some new challenges.First, we are unlikely to find demonstrations that we could use to train or evaluate a system.3 Recommendationletters are extremely private; those who write them do so on the assumption that they will not be revealedto anyone who doesn't need to read them to assess the application. If we manage to find recommendationletters on the public web, it's likely that they either aren't supposed to be there (and are therefore unethicalto use) or they're synthetic examples used to teach people how to write or evaluate recommendation letters(and therefore artificial and probably different from actual letters in key practical ways—remember that weneed realistic demonstrations).A second issue is that the information conveyed in a recommendation letter is often complex, consideringmany aspects of a candidate's performance and potential. Mapping the letter down to a single number orcategory seems quite challenging (if it were easy, we wouldn't ask recommenders to write letters, we'd onlyask them to report the number or category). Finally, as anyone who has been on an admissions or hiringcommittee knows, there is a great deal of subjectivity in interpreting a recommendation letter. Differentreaders may draw different conclusions about the prevailing signal in a single letter. Even if we overcome thehurdle of finding letters to use, that's only half of what we need because the demonstrations need to includedesired outputs as well as inputs.Indeed, the tasks that researchers explore or system builders try to explore are very often limited by the datathat's available. When the desired data (or anything similar to it) is unavailable, it's sometimes possibleto create it. For example, to automate sentiment analysis of social media messages about a particularmuch-discussed public figure, we could hire people to do the task of labeling a sample of messages, essentiallydemonstrating the desired behavior for our eventual system. Labeling tweets about a politician might berelatively easy for someone who speaks the language of the tweets and is familiar with the social context.Some tasks, in contrast, require much more expertise. For example, to build a system that answers questionsabout medical journal articles, we'd want the data to be created by people who know how to read andunderstand such articles so that the answers are accurate and grounded in article specifics. Of course, expertswill be more costly to employ for this work than non-experts. A major tradeoff in the creation of datasets forNLP is between the inherent quality and diversity of the demonstrations and the cost of producing them. Webelieve that high-quality data is always essential for reliable evaluations (test data) and usually essential forhigh performance on those evaluations (training data).Collecting training data for most NLP tasks is quite difficult, and this often impacts whichpossible NLP applications or problems are studied.

2.3 Building an NLP systemFor almost a decade, and with a small number of exceptions, the dominant approach to building an NLPsystem for a particular task has been based on machine learning. Machine learning (ML) refers toa body of theoretical and practical knowledge about data-driven methods for solving problems that areprohibitively costly for humans to solve. These methods change over time as new discoveries are made, asdifferent performance requirements are emphasized, and as new hardware becomes available. A huge amount3In NLP terms, finding and collecting such existing demonstrations would count as dataset creation.“Creating a dataset”inNLP can refer to either creating of new text via expert annotation or crowdsourcing, or collecting existing text into a morereadily accessible form for model developers, such as via web crawling or scraping.

8

of tutorial content is already available about machine learning methods, with new contributions followingfast on the heels of every new research advance. Here, we introduce a few key ideas needed to navigate thecurrent landscape.The first concept is a parameter. A parameter is like a single knob attached to a system: Turning the knobaffects the behavior of the system, including how well it performs on the desired task. To make this concrete,let's consider an extremely simple system for filtering spam emails. Due to budgetary constraints, this systemwill have only one parameter. The system works as follows: it scans an incoming email and increments acounter every time it encounters an“off-color”word (e.g., an instance of one of the seven words the comedianGeorge Carlin claimed he wasn't allowed to say on television). If the count is too high, the email is sent tothe spam filter; otherwise, it goes to the inbox. How high is too high? We need a threshold, and we need toset it appropriately. Too high, and nothing will get filtered; too low, and too many messages may go to spam.The threshold is an example of a parameter.This example neatly divides system-building problem into two separate parts:

1. Deciding what parameters the system will have and how they will work. In our spamexample, the system and the role of the off-color word threshold parameter are easy to explain. Theterm architecture (or model architecture, to avoid confusion with hardware architecture) typicallyrefers to the decision about what parameters a model will have. For example, picture a generic-lookingblack box with lots of knobs on it; the box has a slot on one side for inputs and a slot on the other sidefor outputs. The“architecture”of that model refers to the number of knobs, how they're arranged onthe box, and how their settings affect what occurs inside the box when it turns an input into an output.2. Setting parameter values. This corresponds to determining what value each individual knob onthe box is turned to. While we likely have an intuition about how to set the parameter in the spamexample, the value that works the best is probably best determined via experimentation.

We now walk through how ML works in more detail and introduce some components you'll likely hear aboutif you follow NLP developments.

2.3.1 Architectures: Neural networksToday, the vast majority of architectures are neural networks (sometimes called artificial neural networksto differentiate them from biological ones). For our purposes, it's not important to understand what makesneural networks special as a category of architectures. However, we should know that their main propertiesinclude (1) large numbers of parameters (at this writing, trillions) and (2) being differentiable4 functionswith respect to those parameters: addition, subtraction, exponentiation, trigonometric functions, etc., andcombinations of them. A general observation about neural network architectures (but not a necessary ordefining property) is that the relationship between their numerical calculations and the task-solving behaviorof a model (after its parameters are set) is not explainable to human observers. This is why they are associatedwith the metaphor of a black box (whose internal components can't be observed or easily understood).

2.3.2 Choosing values for all the parameters: Minimizing a loss functionIn order to work well, a neural network needs to have its parameters set to useful values (i.e., values thatwill work well together to mathematically transform each input into an output close to the input's correctanswer). But how do we choose parameters' values when we have so many we need to decide? In this section,we describe the general strategy that we use in NLP.Imagine yourself in the following (admittedly not recommended) scenario. At night, and with no GPSor source of light on you, you are dropped in a random location somewhere over the Cascade Range inWashington State with the instructions to find the deepest valley you can (without just waiting for morning).You move your feet to estimate the steepest downward direction. You take a small, careful step in thatdirection and repeat until you seem to be in a flat place where there's no direction that seems to take youfarther downward.

4We are referring to the concept from calculus. If a function is“differentiable”with respect to some numbers it uses, thencalculus gives us the ability to calculate which small changes to those variables would result in the biggest change to the function.

9

Machine learning (and, by extension, NLP) views the setting of parameter values as a problem of numericaloptimization, which has been widely studied for many years by mathematicians, statisticians, engineers,and computer scientists. One of the tools of machine learning is an automated procedure that frames theparameter value-setting problem like that terrifying hike. Recall that we said that neural networks need tobe differentiable with respect to their parameters— that is, they need to be set up to allow calculus to tell uswhich tiny change to each parameter will result in the steepest change of something calculated using theneural network's output. In our nighttime hike scenario, at each step, we make a tiny adjustment to ournorth-south and east-west coordinates (i.e., position on the map). To adjust the parameters of our neuralnetwork, we will consider our current set of parameters our“coordinates”and likewise repeatedly make tinyadjustments to our current coordinates. But what does it mean to move“down”in this context? Ideally,moving“down”should correspond to our neural network producing outputs that better match our data. Howcan we define a function—our“landscape”— such that this is true?A loss function is designed for precisely this purpose: to be lower when a neural network performs better.In short, a loss function evaluates how well a model's output resembles a set of target values (our trainingdata), with a higher“loss”signifying a higher error between the two. The more dissimilar the correct outputis from the model's produced output, the higher the loss value should be; if they match, it should return zero.This means a loss function should ideally be closely aligned to our evaluation method.5By performing the following procedure, we are able to train a neural-network-based model:

1. We use a loss function to define our landscape for our model's nighttime hike based on our training

inputs and outputs,

2. we make a small adjustment to each of our coordinates (model parameters) to move“down”that

landscape towards closer matches between our model's outputs and the correct ones, and

3. we repeat step 2 until we can't make our model's outputs any more similar to the correct ones.

This method is known as (stochastic) gradient descent (SGD), since the direction that calculus gives usfor each parameter is known as the“gradient.”Leaving aside some important details (for example, how to efficiently calculate the gradients using calculus,working out precisely when to stop, exactly how much to change the parameter values in step 3, and sometricks that make the algorithm more stable), this method has proven effective for choosing parameter valuesin modern model architectures and in their predecessors.

2.3.3 The hardware: Graphics processing units (GPUs)For over a decade, graphics processing units (GPUs) have been the main type of hardware used to trainNLP models based on neural networks. This may seem counterintuitive (since it's language we're processinghere, not graphics). However, GPUs are effective for doing many matrix and vector calculations in parallel,and successful neural network architectures have used these parallel calculations to perform input-to-outputmapping quickly (since stochastic gradient descent requires that mapping to be performed many many timesduring training). Indeed, the realization that neural networks were well-suited to train on GPUs proved to becrucial to their widespread adoption.

3 The language modeling taskSection 2 introduced some NLP concepts and tools, including the idea of encapsulating a desired applicationinto a“task,”the importance of datasets, and a high-level tour of how systems learn to perform a task usingdata. Here, we turn to language modeling, a specific task.

5You can think of a loss function as a stern, reserved teacher grading a student's work. The student (the model whoseparameters we want to set) is given an exam question (an input to the model) and produces an answer. The teacher mechanicallycompares the question's correct answer to the student's answer, and then reports how many points have been deducted formistakes. When the student gets the answer perfectly right, the loss will be zero; no points are deduced. We discuss someadditional mathematical details of loss functions in the appendix.

10

3.1 Language modeling as next word predictionThe language modeling task is remarkably simple in its definition, in the data it requires, and in its evaluation.Essentially, its goal is to predict the next word in a sequence (the output) given the sequence of precedingwords (the input, often called the“context”or“preceding context”). For example, if we ask you to come upwith an idea of which word might come next in a sentence in progress—say,“This document is about NaturalLanguage ____”—you're mentally performing the language modeling task. The real-world application thatshould come to mind is some variation on an auto-complete function, which at this writing is available inmany text messaging, email, and word processing applications.Language modeling was for several decades a core component in systems for speech recognition and texttranslation. Recently, it has been deployed for broad-purpose conversational chat, as in the various GPTproducts from OpenAI, where a sequence of“next”words is predicted as a sequential response to a naturallanguage prompt from a user.

Figure 3: Next word prediction samples a word from the language model's guess of what comes next at eachtime step.

What would make it possible to achieve high accuracy at predicting the next word across many contexts? Ata fundamental level, natural language is predictable because it is highly structured. People unconsciouslyfollow many rules when they use language (e.g., English speakers mostly utter verbs that agree with theirsubjects sometime after those subjects, and they place adjectives before the nouns whose meaning theymodify). Also, much of our communication is about predictable, everyday things (consider how frequentlyyou engage in small talk).As an NLP task, language modeling easily checks the two critical boxes we discussed in section 2: data andevaluation. LMs need only text; every word in a large collection of text naturally comes with the precedingcontext of words. When we say“only text,”we mean specifically that we don't need any kind of label to gowith pieces of text (like the star ratings used in sentiment analysis tasks, or the human-written translationsused in translation tasks). The text itself is comprised of inputs and outputs. Because people produce textand share it in publicly visible forums all the time, the amount of text available (at least in principle, ignoringmatters of usage rights) is extremely large. The problem of fresh, previously unseen test data is also neatlysolved because new text is created every day, reflecting new events and conversations in the world that arereliably different from those that came before. There is also a relatively non-controversial evaluation of LMsthat requires no human expertise or labor, a more technical topic that we return to in section 3.4.

3.2 Why do we care about language modeling?We have thus far established what the language modeling task is. However, we haven't explained why thistask is worth working on. Why do we bother building a model that can predict the next word given thewords that have come before? If you already make use of auto-complete systems, you have an initial answerto this question. But there are more reasons.For many years, NLP researchers and practitioners believed that a good language model was useful only forestimating fluency. To illustrate this, imagine a language model faced with guessing possible continuations fora partial sentence like“The dog ate the ____”or“Later that afternoon, I went to a ____.”As Englishspeakers, we share a pretty strong sense that the following word is likely to be either a noun or part of adescriptor preceding a noun. Likewise, if we have a good language model for this type of English, that model

11

will have needed to implicitly learn those kinds of fluency-related rules to perform the language modelingtask well. This is why LMs have historically been incorporated as a component in larger NLP systems, suchas machine translation systems; by taking their predictions (at least partially) into account, the larger systemis more likely to produce more fluent output.In more recent years, our understanding of the value of LMs has evolved substantially.In addition topromoting fluency, a sufficiently powerful language model can implicitly learn a variety of world knowledge.Consider continuations to the following partial sentences:“The Declaration of Independence was signed bythe Second Continental Congress in the year ____,”or“When the boy received a birthday gift from hisfriends, he felt ____.”While there are any number of fluent continuations to those sentences—say,“1501”or“that the American Civil War broke out”for the first, or“angry”or“like going to sleep”for the second—youlikely thought of“1776”as the continuation for the first sentence and a word like“happy”or“excited”forthe second. Why? It is likely because you were engaging your knowledge of facts about history as well asyour common sense about how human beings react in certain situations. This implies that to produce thosecontinuations, an LM would need at least a rudimentary version of this information.To do a good job of guessing the continuations of text, past a certain point, an LM must haveabsorbed some additional kinds of information to progress beyond simple forms of fluency.NLP researchers got an early glimpse of this argument in Peters et al. (2018). This paper reported thatsystems that trained an LM first as an early stage of building systems for varied tasks, ranging fromdetermining the answer to a question based on a given paragraph to determining which earlier entity aparticular pronoun was referencing, far outperformed their analogous versions that weren't informed by anLM (as measured by task-specific definitions of quality). This finding led to widespread researcher acceptanceof the power of“pretraining”a model to perform language modeling and then“finetuning”it (using itspretrained parameters as a starting point) to perform a non-language-modeling task of interest, which alsogenerally improved end-task performance.It shouldn't be too surprising that LMs can perform well at filling in the blanks or answering questions whenthe correct answers are in the training data. For a new task, it seems that the more similar its inputs andoutputs are to examples in the pretraining data, the better the LM will perform on that task.

3.3 Data for language models: Some nuancesThere are two important caveats to our earlier claim that collecting data for a language model is“easy.”First,because there is a massive amount of text available on the internet which could be downloaded and used tobuild or evaluate LMs, at least for research purposes, a language model builder must decide which data toinclude or exclude. Typical sources of data include news articles, books, Wikipedia, and other web text thatis likely to be carefully edited to conform to professional writing conventions. Some LMs include more casualtext from social media websites or online forums, or more specialized language from scientific texts. Whileresearchers have generally considered training language models on publicly available text data to be coveredby fair use doctrine, the relationship between copyright protections and language model practices is not fullysettled; we discuss this further in section 6.2.1.A major decision is whether to filter texts to only certain languages.6 Depending on the community of usersone intends the LM to serve, it may be preferable to filter text on certain topics (e.g., erotica) or text likelyto contain offensive content or misinformation. Today's LM datasets are too large for a person to read in asingle lifetime, so automated tools are employed to curate data. The implications of these decisions are amajor topic for current research, and we return to them in section 4.4.1.The other caveat is a more technical one: what counts as a“word”? For languages with writing systems thatuse whitespace to separate words, like English, this is not a very interesting question. For writing systemswith less whitespace between words (e.g., Chinese characters), segmentation into words could be a matter ofchoosing an arbitrary convention to follow or of adopting one of many competing linguistic theories. Today,6The problem of assigning a language identifier to a text (e.g., is it English, Spanish, etc.?) constitutes another family ofNLP tasks. It's a useful exercise to consider how to select the set of language names to use as labels for language identification,e.g.,which dialects of a language are separate from each other and should receive different labels?

12

LMs are often built on text from more than one natural language as well as programming language code. Thedominant approach to defining where every word in the data starts and ends is to apply a fully automatedsolution to create a vocabulary (set of words the language model will recognize as such) that is extremelyrobust (i.e., it will always be able to break a text into words according to its definition of words). Theapproach (Sennrich, Haddow, and Birch 2016) can be summed up quite simply:

• Any single character is a word in the vocabulary. This means that the LM can handle any entirely new

sequence of characters by default by treating it as a sequence of single-character words.

• The most frequently occurring two-word sequence is added to the vocabulary as a new word. This rule

is applied repeatedly until a target vocabulary size is reached.

This data-driven approach to building a language modeling vocabulary is effective and ensures that commonwords in the LM's training data are added to its vocabulary. Other, rarer words will be represented as asequence of word pieces in the model's vocabulary (similarly to how you might sound out an unfamiliar wordand break it down into pieces you've seen before). However, note that a lot depends on the data throughthe calculation of what two-word sequence is most frequent in that data at each step. Unsurprisingly, if thedataset used to build the vocabulary includes little or no text from a language (or a sub-language), words inthat language will get“chopped up”into longer sequences of short vocabulary words (some a single character),which has been shown to affect how well the LM performs on text in that language.

3.4 Evaluating LMs: PerplexityWe mentioned earlier that the language modeling task has a straightforward evaluation method. At first, wemight think that a“good”language model has a low word error rate: when it guesses the next word in asequence, it should seldom predict the wrong word. (A“wrong word”here means anything other than theactual next word in the test data sequence.)7LMs have generally not used the error rate to evaluate LM quality for two reasons. First, applicationssometimes predict a few options for the next word; perhaps it's just as good to rank the correct next wordsecond or third as it is to rank it first. The error rate could be modified to count as mistakes only thecases where the correct word is ranked below that cutoff. But how long the list should be is a questionfor application designers and moves the task definition in a more specialized/concrete direction, perhapsunnecessarily. Second, at least earlier in the history of language modeling, most systems weren't good enoughat predicting the next word to have error rates that weren't extremely high. If all LMs achieve error ratesclose to one, the error rate measurement isn't very helpful for comparing them.The evaluation method that is typically used for LMs avoids both of these issues. This method is known asperplexity, and can be considered a measure of an LM's“surprise”as expressed through its outputs in nextword prediction. Perplexity manages to work around the problems we've described by taking advantage ofhow LMs decide on a next word in practice.When an LM produces a next word, that next word is in reality a somewhat processed version of that LM'sactual output. What the LM actually produces given some input text is a probability distribution over itsvocabulary for which word comes next. In other words, for every possible next word in its vocabulary, the LMgenerates a number between 0 and 1 representing its estimate of how likely that word is as the continuationfor the input text.8Rather than evaluating an LM based on however an application developer chooses to process those probabilitydistributions into next words (whether by sampling, or by choosing the word with the highest estimatedlikelihood, or something else), perplexity instead directly evaluates the probability distributions produced bythe LM. Given a test set of text, perplexity examines how high the LM's probabilities are for the true observednext words overall, averaged over each word in the text-in-progress. The higher that LM's average probabilityfor the true words is, the lower the LM's perplexity (corresponding to the LM being less“surprised”by the

7We give a formal mathematical definition of word error rate in the appendix.8Because this is a probability distribution, all those numbers must add up to 1, and in practice, LMs always set their

probabilities to numbers strictly greater than 0.

13

actual continuations of the text).9Like any evaluation method, perplexity depends heavily on the test data. In general, the more similar thetraining and test data, the lower we should expect the text data perplexity to be. And if we accidentallybreak the cardinal rule and test on data that was included in the training data, we should expect extremelylow perplexity (possibly approaching 1, which is the lowest possible value of perplexity, if the model werepowerful enough to memorize long sequences it has seen in training).Finally, it's worth considering when perplexity seems“too”low. The idea that there is some limit tothis predictability, that there is always some uncertainty about what the next word will be, is an old one(Shannon 1951), motivating much reflection on (1) how much uncertainty there actually is, and (2) whatvery low perplexity on language modeling implies. Some have even suggested that strong language modelingperformance is indicative of artificially intelligent behavior. (We return to this question in section 5.)

3.5 Building language modelsGiven the tools from section 2 and our presentation of the language modeling task, it's straightforward todescribe how today's best LMs are built:

1. Acquire a substantial amount of diverse training data (text), filtering to what you believe will be high

quality for your eventual application. Set aside some data as the test data.

2. Build a vocabulary from the training data.3. Train a model with learnable parameters to minimize perplexity on the training data using a variant of

stochastic gradient descent.

4. Evaluate the perplexity of the resulting language model on the test set. In general, it should be verypossible to evaluate the LM on another test set because (1) we can check that the new proposed testdata doesn't overlap with the training data, and (2) the vocabulary is designed to allow any new textto be broken into words.

The third step reveals another attractive property of perplexity: it can serve as a loss function because it isdifferentiable with respect to the model's parameters.10 Note the difference between training set perplexity(calculated using training data) and test set perplexity calculated in the last step.11The preceding process is how some well-known models, like GPT-2, GPT-3, and LLaMA, were built, andit's the first step to building more recent models like ChatGPT and GPT-4. These newer models have beenfurther trained on additional kinds of data (which is less“easy”to obtain than the text we use for next wordprediction). We return to this topic in section 4.3.4.

4 From LMs to large language models (LLMs)Everything we've described thus far has been established for over a decade, and some concepts much longer.Why have language models become a topic of mainstream public conversation only recently?Recall that a longstanding use of LMs was to estimate the fluency of a piece of text (3.2), especially to helptext-generating systems produce more fluent output. Only since around 2020 have LMs been producinghighly fluent output on their own, that is, without incorporating some other components. At this writing, youcould observe something like the text generation performance of older LMs by looking at the autocompletefunctions in messaging applications on smartphones. If you have one of these on hand, try starting a sentenceand then finishing the sentence by picking one of the most likely next words the autocomplete program

9For those interested, we walk through the mathematics underlying the definition of perplexity in the appendix.10In practice, the loss function is usually the logarithm of perplexity, a quantity known as cross-entropy.11One common question about language models is why they sometimes“hallucinate”information that isn't true. The factthat next word prediction is the training objective used for these models helps to explain this. The closest an LM comes toencoding a“fact”is through its parameters' encoding of which kinds of words tend to follow from a partially written sequence.Sometimes, the context an LM is prompted with is sufficient to surface facts from its training data. (Imagine our example fromearlier:“The Declaration of Independence was signed by the Second Continental Congress in the year ____.”If an LM fills inthe year“1776”after being given the rest of the sentence as context, that fact has been successfully surfaced.) Other times,however, it's not, and we just get a fluent-sounding next word prediction that's not actually true, or a“hallucination.”

14

suggests. You're likely to notice that while the short-term continuations to the sentence are reasonable,the text quickly devolves into moderately fluent incoherence, nothing like text produced by state-of-the-artweb-based products.Having established the foundations—the language modeling task and the basic strategy for building a languagemodel—we'll now consider the factors that have recently transformed the mostly academic language modelsof the last decade into the so-called large language models (LLMs) of today.

4.1 The move towards more dataThis is not a history book, but there is one obvious lesson to be learned from the history of NLP: moretraining data helps make higher quality models. One period of major changes in the field occurred in the late1980s and 1990s when three trends converged almost concurrently:

1. Increasingly large collections of naturalistic, digital text data became easier to access by growing

numbers of researchers thanks to the rise of the internet and the world-wide web.

2. Researchers shifted from defining rules for solving NLP tasks to using statistical methods that dependon data. This trend came about in part due to interaction with the speech processing community, whichbegan using data-driven methods even earlier.

3. Tasks, as we described them above, became more mature and standardized, allowing more rigorousexperimental comparisons among methods for building systems. This trend was driven in part bygovernment investment in advancing NLP technology, which in turn created pressure for quantitativemeasures of progress.

During the 1990s and 2000s, the speed of progress was higher for tasks where the amount of available trainingdata increased the fastest. Examples include topic classification and translation among English, French,German, and a few other languages. New tasks emerged for which data was easy to get, like sentimentanalysis for movies and products sold and reviewed online. Meanwhile, progress on tasks where data wasmore difficult to obtain (such as long text summarization, natural language interfaces to structured databases,or translation for language pairs with less available data) was slower. In particular, progress on NLP forEnglish tasks was faster than for other languages, especially those with relatively little available data.The recognition that more data tends to help make better systems generates a lot of enthusiasm, but wefeel obliged to offer three cautionary notes. First, easily available data for a task doesn't make that taskinherently worth working on. For example, it's very easy to collect news stories in English. Because thestyle of many English-language newspapers puts the most important information in the first paragraph,it's very easy to extract a decent short summary for each story, and we now have a substantial number ofdemonstrations for an English-language news summarizer. However, if readers of the news already know thatthe first paragraph of a news story is usually a summary, why build such a system? We should certainly notexpect a system built on news summarization task data to carry over well to tasks that require summarizingscientific papers, books, or laws.The second cautionary note is that the lack of easy data for a task doesn't mean the task isn't worth solving.Consider a relatively isolated community of people who have more recently gained access to the internet. Ifthey do not speak any of the dominant languages on the internet, they may be unable to make much useof that access. The relative absence of this community's language from the web is one reason that NLPtechnology will lag behind for them. This inequity is one of the drawbacks of data-driven NLP.The third cautionary note is that data isn't the only factor in advancing NLP capabilities. We alreadymentioned evaluation methods. But there are also algorithms and hardware, both of which have changedradically over the history of NLP. We won't go into great detail on these technical components here, but wenote that the suitability of an algorithm or a hardware choice for an NLP task depends heavily on the qualityand quantity of training data. People often use the term“scale”to talk about the challenges and opportunitiesassociated with very large training datasets. As early as 1993, researchers were claiming that“more datais always better data”(Church and Mercer 1993). We would add that which algorithms or computers arebetter for building a system that performs a task depends highly on the availability of appropriate data for

15

that task, whether high or low or in between. And indeed, as it turns out, the second factor we now mentionfalls into the category of a change in algorithm: a change in model architecture.

4.2 The architecture: TransformersNot long ago, students of NLP would be introduced to a wide range of different architectures. One wouldlikely hear about the relative merits of each and learn what particular kinds of problems it was well suited tosolve. From year to year, new ones would be added, sometimes replacing those no longer deemed optimal inany setting. Today, these diverse architectures have virtually all been replaced by a single architecture calledthe transformer, whimsically named after a brand of 1980s robot toys, proposed by Vaswani et al. (2017).The transformer, a type of neural network, was introduced by researchers at Google for machine translationtasks. Though we won't go into detail about how it works, its design was inspired by earlier developments inneural networks, and it was primarily optimized to allow the GPU-based simultaneous processing of all partsof even long input texts instead of word-by-word processing. Earlier architectures were largely abandoned12because they didn't effectively use GPUs and could not process large datasets as quickly.It didn't take long for researchers to realize that with the transformer would allow for training models morequickly and/or on more data, as well as training much larger models than other architectures ever allowed.By“larger models,”we mean models with more parameters. These three elements—larger datasets, fasterhardware, and larger models—all depend on each other. For example, a larger model could better encodepatterns in the training data, but without faster hardware, training such a model may be infeasible. And ifthe model is trained on an insufficient sample of data, it may not generalize well.13 Conversely, a substantialdataset may require a larger model (more parameters) to encode the larger set of discoverable patterns inthe data. Indeed, there is a fundamental tradeoff when selecting architectures: too few parameters, and thearchitecture will be limited in what input-output mappings it can learn, no matter how much training data isused. Too many parameters (i.e., too large a model), and the model might overfit.The simultaneous, rapid increase in datasets and parameter counts, aided by improved hardware, affectedcomputer vision before affecting NLP. In fact, the term“deep learning”was originally a reference to theselarger models (“deep”refers to models with increasing numbers of“layers”in the architecture, where layers areiterations of repeated calculations with different parameters at each round). The“deepening”of transformersapplied to the language modeling task led to what are now called“large language models.”“Large”usuallyrefers to the parameter count, but it could also refer to the size of the training dataset.The models in wide use for NLP today have billions of parameters; older generations of OpenAI modelsincreased from sizes of over a billion parameters with the largest version of GPT-2 to 175 billion parameterswith GPT-3. The main drawback is that running their training algorithms on large datasets requires verymany GPUs working in parallel for a long time, which in turn requires a lot of energy. From the perspectiveof improving the quality of generated text (in perplexity but also subjective human judgments), these LLMsrepresent a major advance.From a scientific perspective, it's difficult to assess which of these changes—data size, number of parameters,architecture, etc.—matter the most. Larger models are more data-hungry; over the last few years, modelshave gone from training on datasets with millions of words to trillions of words. While some work, such asthat by Hoffmann et al. (2022), tried to disentangle the impacts of model scale and data scale, the additionalinfluence of yet other factors (like hyperparameters on a training run) complicates efforts to confidently drawconclusions from such research. These experiments require the repeated training of models that are estimatedto cost millions of dollars apiece. In addition, it would take far too long to train fairly matched models basedon previously popular, pre-transformer architectures (i.e., with similar parameter counts on similar amountsof data to the strongest models of today); this means that it's impossible to measure how much benefit thetransformer offers other than allowing for larger models.

12They were not totally abandoned, however, and are still used occasionally when datasets are small.13At its extreme, this phenomenon, known as“overfitting,”leads to models that“memorize”what they see in the training

data but perform poorly on new data, e.g., the test data.

16

It's important to recognize that larger datasets and more powerful hardware were the driversfor the scaling up of language models to architectures with hundreds of billions of parameters(at this writing), and that the parameter count is only part of the explanation for theimpressive behaviors of these models.

4.3 Impacts of these changesWhat was the impact of LLMs? In short, they caused language modeling performance to improve dramatically.To see this qualitatively for yourself, try typing out the beginning of a sentence and instruct a languagemodel like ChatGPT to complete that sentence. Chances are, you will immediately see a sentence that readsmuch more naturally than you saw generated by a simpler autocomplete system at the beginning of thissection. Many people have shared this subjective experience of more fluent text generation, and it is backedup by quantitative evaluations like perplexity. However, if that were their only contribution, LLMs probablywouldn't have entered the public consciousness.

4.3.1 Many other tasks are now reduced to language modelingWe previously mentioned in section 3.2 that LMs could inform NLP systems designed for other tasks. LLMsare accelerating this trend. By formulating task instructions in natural language, perhaps also providingadditional specific examples of what it would look like to successfully perform the task (inputs and outputs),and then supplying that text as the context on which a LLM conditions when choosing next words ascontinuations, we see very reasonable outputs for a broad range of such tasks (e.g., generating summaries andanswering questions). As we discussed in section 3.2, many techniques built on the pretraining-finetuningapproach transferred strong language model performance to other tasks. But the extent to which LLMsbecame the full model pipeline, i.e., with no task-specific finetuning needed for particular tasks, was striking.14Importantly, remember that part of the definition of a task is an evaluation method; the striking observationis that, as language models achieve lower perplexity, they also achieve better performance on many othertasks' own evaluations.For example, we previously described translation between languages and sentiment analysis as two broadcategories of NLP applications. Today's LLMs can often perform those tasks given context instructionsand/or examples — i.e., they are“prompted”to do so. For example, consider a context like“Translatethis sentence into French: We'd like another bottle of wine.”If an LLM has seen enough text that includesrequests/responses, text in the relevant languages, and parallel examples, it could produce the translation.(Indeed, OpenAI's ChatGPT system gave us a fairly reasonable“Nous aimerions une autre bouteille de vin.”Similarly, the prompt“Is the sentiment toward the movie positive or negative? This film made me laugh, butonly because it was so poorly executed.”led ChatGPT to output that the sentiment was negative.)This ease of transferability has made it much simpler for a wider variety of people, including non-researchers,to explore NLP capabilities. Often, it is no longer necessary to collect training data and build a specializedmodel for a task. We can say what we want in natural language to prompt an LLM, and we will often getoutput close to what we intended. People, including experts and non-experts, are now using LLMs for manypurposes, including many not originally formalized as NLP tasks.

4.3.2 Black boxesModern transformers are considered to be“black boxes”with befuddling numbers of parameter-knobs to turn,and to our knowledge, no one has particularly useful intuition about how to set any particular knob. Thissituation seems daunting, like sitting in a cockpit with thousands of knobs and controls and being told to flythe plane with no training. Indeed, it's only because of the increasing computational power of commerciallyavailable computers that we can solve problems this way today, but this still leaves us without a sense of thekinds of information models have learned to leverage, or how.

14The idea of prompting a model with a small number of examples came to be known as“in-context learning.”Considerableeffort has gone into engineering prompts for better task performance and into finetuning LMs to follow instructions describingwidely varied tasks. Such instruction finetuning has become a widely used second stage of training for commercial LM products.Note that it requires a dataset of instructions paired with the desired response an LM should give to each.

17

Both the transformer architecture and the stochastic gradient descent method used to set its parametersare mystifying, at least at first. Below, we reflect on that and note important differences that make anarchitecture like the transformer more inscrutable.Stochastic gradient descent, the algorithm used to train transformers and other neural networks, has beenextensively studied and is very well understood for some kinds of problems. Picture a smooth bowl andimagine a marble placed anywhere in it. That marble will roll and eventually settle at the lowest point. Ifthe dish were sitting on a piece of graph paper (a two-dimensional plane), the coordinates of that lowestpoint are the values of our two parameters that minimize the loss function. Stochastic gradient descent is,roughly speaking, doing the work of gravity. The simple curve of the dish, with no bumps or cutouts orchips, corresponds to the property of convexity. Some machine learning problems correspond to a convex lossfunction, and theoretical proofs support the existence of the best parameter values, how close SGD gets tothem, and how fast. What remains surprising is that SGD works well in practice even when the loss functionis not convex (like the Cascades, discussed in section 2.3.2). But the mathematics underlying this algorithmare relatively mature.The transformer architecture, only a few years old at this writing, remains mysterious. Some researchers havesought to prove theorems about its limitations (i.e., input-output mappings it cannot represent under someconditions), and more have run experiments to try to characterize what it learns from data in practice. Moreresearch is clearly needed, both to improve our understanding of what we can expect from this architectureand to help define new architectures that work better or for which parameter setting is less computationallyexpensive.

4.3.3 Cost and complexity affect who can develop these models nowYet another effect of the move to LLMs has been that a much smaller set of organizations can afford toproduce such models. Since large, well-funded tech companies are (almost exclusively) well positioned to trainLLMs due to their access to both data and specialized hardware, these companies are the sources for almostall current LLMs. This poses a barrier to entry for many researchers at other institutions. Given the widearray of different communities that could benefit from using these models, the many different purposes theymight envision for these models, and the vast diversity of language varieties that they represent, determiningways to broaden participation in LLM development is an important emerging challenge.Furthermore, when models were smaller, the idea of“running out”of web text on the public internet seemedludicrous; now, that's a looming concern for LLM developers. As massive datasets play an increasingly largerole in model training, some large companies' access to their own massive proprietary data associated withplatforms they maintain may give them an advantage in their development of models of text.

4.3.4 Adapting LLMs for use as productsBecause of the capabilities of these new models, many developers seek to integrate them into a wide array ofproducts and services, from helping software engineers write code to helping lawyers write briefs. This echoesa longstanding practice of incorporating LMs into parts of standalone products with commercial purposes,such as guiding a translation system to produce more fluent text in the output language. As LLMs gainedbroader exposure (and, we conjecture, with increased internal testing at the companies where they werebuilt), it became clear that additional adjustments were needed before deploying these models in products.We relate some of the more concerning issues that emerge in LLM-generated text in section 5. For now,consider the concrete possibility that an LLM would generate text that is fluent, but impolite or even obscene.How can this be prevented? Enforcing conventions of social acceptability is a difficult problem that manyresearchers have tackled. Proposed methods can vary from post-processing outputs (e.g., to screen out outputsthat include certain dispreferred words) to reranking sampled outputs using an auxiliary model specificallytrained on curated data to exhibit politeness. It is difficult to“taskify”social acceptability because it iscontext-dependent and extremely subjective.The notion of“alignment,”often used today for this class of problems, was introduced by Norbert Wiener:“Ifwe use, to achieve our purposes, a mechanical agency with whose operation we cannot efficiently interfere. . .

18

then we had better be quite sure that the purpose put into the machine is the purpose which we really desire”(Wiener 1960). This idea comes through today in research on using machine learning to alter LM behaviorsdirectly.In practice, commercial models are further trained on tasks designed to encourage instruction following(section 4.3.1) and generating text that humans respond to favorably.15 It is complicated to determine whichbehaviors to encourage. In her 2023 keynote at the FAccT research conference, the social scientist AlondraNelson made the point that“civilizations, for eons, for millennia. . . choose your long time scale—have beenstruggling, fighting, arguing, debating over human values and principles”(Nelson 2023). In other words, notonly is it a difficult problem to determine how to shape models' outputs to reflect a given set of values, it'salso extremely complicated to determine which set of values to incorporate into that set. Therefore, we tendto view these last adjustments of an LLM's behavior as a kind of customization rather than as an intrinsicencoding of“human values”into the system. Just like training models, only a few companies are currentlyequipped to customize them at this writing.

4.3.5 Safeguards and mitigationBecause LLMs are trained on such a wide-variety of internet content, models can create outputs that containunsafe content. For example, a user may want to know how to create a bomb or have the model help themplan some other dangerous or illegal act. Leaving aside whether the models constitute“intelligence,”theinformation these models contain and how easily they present it to users can create substantial risk. Thecurrent method for attempting to solve this problem is establishing content safeguards, a major part ofadapting LLMs for use as products. Safeguards can take different forms, from tuning the model to avoidcertain topics to addressing the issue through post-processing, where output from the model is filtered. Thesesafeguards are part of the larger“alignment”process since they can also be used to help block hateful contentin addition to dangerous information.There are also less obvious cases where safeguards can be critical for user safety. For example, a modelshould not provide medical advice without at least suggesting that the user seek professional advice anddisclosing that it is not a doctor or that its output is not guaranteed to be consistent with the medicalcommunity's consensus. Another case is self-harm, where the behavior of LLMs has been likened to a mirror,e.g., encouraging behaviors reflected in user prompts.Though necessary, safeguards can also impact a model's utility depending on how they are implemented. Forexample, a model that is too strict may refuse to do something that isn't actually harmful, making it lessuseful. Therefore, there is a tension between cautiously avoiding liability for model developers and meetinguser expectations.

4.3.6 The evaluation crisisExcitement around LLMs often centers on the rate of progress: as the models get larger (or are trained onmore data), they seem to get increasingly accurate and fluent. As mentioned previously in section 2.1, NLPresearchers have long-standing, rigorous methods for measuring how well systems perform at various tasks.These have not been abandoned. Following the trend of adapting LLMs to almost every task NLP originallyset out to do, with relatively little transfer effort (section 4.3.1), researchers are now evaluating new models,adapted in new ways, on ever-growing suites of tasks drawn from the past few decades of empirical evaluationof NLP systems, as well as new ones coming into use. The general trend is that performance numbers areimproving.This is promising news insofar as these tasks accurately capture what people want to do with NLP technology.But we believe there are reasons to be skeptical. Since the deployment and widespread adoption of LLM-basedproducts, users have expressed enthusiastic interest in thousands of new use cases for LLMs that bear littleresemblance to the tasks that constitute our standard research evaluations, which has several importantimplications:

15One current example of a proposed method for doing this is“reinforcement learning from human feedback.”As its nameimplies, this method uses machine learning to turn discrete representations of human preferences, like“sampled output A ispreferable to sampled output B,”into a signal for how to adjust a model's parameters accordingly.

19

• The suite of tasks driving research evaluations needs thorough and ongoing reconsideration and updating

to focus on communities of actual users.

• Observations of how real users interact with an LLM, along with feedback on the quality of the LLM's

behavior, will be important for continuing to improve LLM quality.

• Because there is diversity in the communities of users, customization of models will become increasingly

important, making thorough evaluation increasingly multi-faceted and challenging.

• Reports of“progress”cannot be taken at face value; there are many different aspects to model quality.A single performance number (like perplexity on a test set or average performance on a suite of hundredsor thousands of tasks' specific evaluations) will not meaningfully convey the strengths and weaknessesof a system with such wide-ranging possible behaviors.

We believe that these challenges will inspire new collaborations between researchers and users to defineevaluations (and, by extension, models) that work as our needs and the realities of model building evolve..

4.4 Knowing the model means knowing its training dataModel capabilities depend directly on the specific data used to train them. The closer a string of text (say,the instructions provided to an LLM) is to the kind of data that the model was trained on (which, for currentmodels, is a large portion of the data on the internet), the better we expect that model to do in mimickingreasonable continuations of that“kind”of language.16 Conversely, the further the language of some text isfrom the model's training data, the less predictable the model's continuation of that text will be. (In section5.1, we discuss the implications for choosing which prompts to supply to a model.)You can test this out. Try instructing a model (for example, ChatGPT) to generate some text (a publicawareness statement, perhaps, or a plan for an advertising campaign) about a very specific item X gearedtowards a specific subpopulation Y, preferably with an X and Y that haven't famously been paired together.Grammatically, the answer returned is probably fine. However, if the content of the model's response seemsgeneric, that's not too surprising. The amount of text that models like ChatGPT are trained on that couldserve as a close example to a particular prompt is typically far greater than that which is relevant for preciseideas specific to whatever personal combination you thought up.If you speak a language besides English, you'll likely also notice a worse answer or a more stilted, generictone if you translate your question into that language and ask it again. And again, this is directly related tothe model's training data: however much text there is relevant to your issue or product on the internet inEnglish, there's likely less of it in your other language, meaning there was less available to use for training.

4.4.1 What does LLMs' training data contain?Characterizing a dataset on a trillions-of-words scale is tricky for a few reasons. First, reading throughthe corpus, or even a large enough sample to capture its diversity, would take too long. (A colleague ofours estimated thousands of years of reading without any breaks.) Published descriptions of datasets thathave been explored using automated tools focus on the top sources (e.g., web domains like Reddit.com orWikipedia.org) or coarse characterizations in terms of genre (e.g., patents, news); see Dodge et al. (2021)for an example. These characterizations, while convenient, show tremendous variation. We believe thatresearchers must do more work on developing methodologies and implementing tools for describing thatvariation.In many cases, though, information about the documents used to train an LLM is hidden. It's very commonfor companies that deploy these models to treat the data they used as a trade secret, saying little to nothingabout the data, making analysis impossible. However, a few model builders do share more information abouttheir training data, which helps researchers better understand how model behaviors, beneficial and otherwise,are shaped by certain kinds of text.

16Note that we are not implying that language models are only mimics; characterizing the precise ways in which they merely

copy vs. generalize is work still to be done.

20

Many researchers have one specific concern about hidden training datasets: Suppose a model is promptedwith a question that seems especially difficult to answer, and it answers accurately and clearly, like an expert.We should be impressed only if we are confident that the question and answer weren't in the training data. Ifwe can't inspect the training data, we can't be sure whether the model is really being tested fairly or if itmemorized the answer key before the test, like our student in section 2.2.

4.4.2 A cautionary note about data qualityIt's tempting to boil down negative consequences of including certain data during training (such as misin-formation or hate speech) to issues of“data quality”and advocate for“better”data using the“garbagein, garbage out”principle. Yet, seemingly reasonable steps often taken to automatically filter web text for“quality”can have the unintended effect of overrepresenting text that resembles writing more characteristic ofwealthier or more educated groups (Gururangan et al. 2022). Further, these filters' defined notion of qualitydoes not align with other manually determined aspects of text quality (such as winning a Pulitzer prize ortelling the truth).Determining what counts as“better”training data, and how that sense can be implemented at scale, isa subjective question of values and norms. For this reason, we predict and hope that future research willsupport better customization of language models' data to different user communities or applications ratherthan assuming a universal notion of“quality.”This contrasts with an assumption underlying much currentdiscussion about language models, that one large model will eventually be the best solution for everythingeveryone wants.

5 Practical points about using language modelsSo far we've talked about how language models came to be and what they are trained to do. If you're ahuman reading this guide, though, then you're likely also wondering about how good these models are atthings that you've thought up for them to do. (If you're a language model pretraining on this guide, carryon.)As we have learned in section 4.3.6, NLP researchers' tools for evaluating models test for different abilitiesthan those that interest many users of deployed products. Delineating what LMs can do, and how thesecapabilities relate to the choices made when they are constructed, deserves continued scientific exploration.However, early signs indicate that LMs can at least be helpful tools in speeding up many user tasks thatwere previously difficult to automate. So, if you're wondering whether these models can be helpful to you onsomething specific, say, planning a trip to Japan, it's worth giving them a try!This section answers general questions you may have when you're trying them out or thinking about what'sin store for them over the near term. We answer by distilling major conversations (now occurring in thescientific community studying language models) into practical takeaways you should be aware of and thereasoning behind these takeaways.

5.1 Is the specific wording of the“prompt”I supply to an LM important?In short, yes. Section 4.4 hinted at this, but to be more explicit: the specific wording of the prompt that yousupply to an LM significantly affects the model output that you receive. This likely means that you'll wantto experiment with a few different wordings for instructing the model to do something. When you prompt amodel, if your input and the correct output are close to sample text the model has encountered in its trainingdata, the model should“respond”(that is, continue the prompt by predicting a sequence of next words) well.Trying different prompt wording means that you're casting a wider net across patterns that the model haslearned about language and giving yourself a better chance of encountering one that the model has an easiertime continuing.To test this out, try rephrasing something you want an LM to do in a few very different ways. Then, trysupplying each of these prompts separately to a model like ChatGPT. Chances are that you see some notabledifferences in the different results that you get!

21

5.2 Do I always have to check and verify model output, or can I simply“trust”

the result?

At first glance, it might seem that a prompt that produces believable model output means there's nothingleft for you to do. However, you should never take model output at face value. Always check for the followingimportant issues.

5.2.1 Truthfulness vs.“hallucination”At the time of writing (and likely for the foreseeable future), LMs struggle with ‘telling the truth,' thatis, producing correct output.In fact, a much-discussed property of LMs is their tendency to produceinaccurate and nonfactual information. This phenomenon is known as“hallucination.”17 How muchhallucination matters greatly depends on the tasks and genres of language of the model's users. For acreative writer, a language model's flexibility in presenting fictional information may be one of its greateststrengths. For someone who needs an accurate summary of a medical article or who tries to use an LM toretrieve statements of fact from court testimony, it can render the model unusable, at least without carefulpost-prompt fact-checking.Why do models hallucinate? While models depend heavily on their training data, they do not access thatdata exactly. Instead, they seem to encode patterns in the data, but not to“remember”the data precisely allthe time. Thus, for topics with plenty of supporting data and a simple task, the likelihood of hallucinationis often lower. With more complex tasks on less-discussed subjects, hallucination is less surprising. Evenwhen there is plenty of data, if the training data included frequent statements of incorrect information (forexample, the incorrect but widely discussed claim that vaccines cause autism), the model may encode (as apattern) the incorrect claim. There is ongoing active research on discouraging models from stating incorrectinformation as well as steering them away from generating confident-sounding answers (or any answer at all)to questions where the facts may be under debate, but this is still a very difficult open problem.Relatedly, there is currently no straightforward, computationally feasible way to link specific predictions orgenerated text back to specific training documents or paragraphs. So, another ongoing research challenge isendowing LMs with the ability to“cite their sources,”that is, to not only generate explicit and accuratereferences to relevant literature or sources like scholars are taught to do, but to reveal the specific texts thatinfluenced a particular next word prediction, if requested.A notable real-life example of these missing capabilities surfaced when two US lawyers in early 2023 usedChatGPT to prepare the filing for a personal injury suit against an airline. While the main text was veryfluent, the model had completely hallucinated the cases it cited as precedents and their corresponding judges,plaintiffs, and defendants. This was brought to the court's attention when it received a brief from the airline'slawyers questioning the existence of the cited cases. These cases weren't real, and the lawyers had notdisclosed that they used ChatGPT for their legal research. The federal judge in the case was furious andfined both lawyers, who blamed ChatGPT during a subsequent hearing, stating they“did not understand itwas not a search engine, but a generative language-processing tool.”Now that LM hallucinations have found their way into the judicial system, we can hope that users (andmodel builders, the“deep pockets”in such cases) have learned a lesson. LMs are not search engines, andtheir output requires careful checking, at least at present.Remember: language models don't perfectly capture their training data!

5.2.2 Model outputs that reflect social biasesAnother aspect of evaluating and revising model outputs where human judgment is key is in checking formodels' unthinking mimicry of social biases that may have appeared in their training data.NLP researchers often refer to the names of the idealized tasks we've trained our models to perform—“hatespeech detection,”“machine translation,”“language modeling”—but remember that how a model learns to17Some have argued that the term“hallucination”is misleading and anthropomorphizes language models, but at this writing

it is the most widely used by NLP researchers.

22

perform a task is heavily influenced by the particular data used to train it. (This is related to our previousdiscussion in section 2.1 about the tradeoff between abstract, aspirational notions of a task and concrete,workable ones.) In practice, models for“hate speech detection”are actually trained to perform“hate speechdetection as exemplified in the HateXplain dataset”or“hate speech detection as exemplified in the IberEval2018 dataset.”These datasets reflect their builders' focus on particular type(s) of language—for example,Spanish-language news articles or American teenagers' social media posts—but no dataset perfectly representsthe type(s) of language it's meant to represent. There are simply too many possible utterances! Therefore,despite ongoing work trying to improve models' abilities to generalize from the data observed during training,it remains possible that a model will learn a version of the task that's informed by quirks of its training data.Because there are so many possible“quirks,”it's a safe bet that a model will have learned some of them.And in fact, we've observed this time and again in NLP systems.To be more specific, let's look at some past work that's found bias traceable to the training data within hatespeech detection systems. Sap et al. (2019) found that in two separate hate speech detection datasets, tweetswritten in African American Vernacular English (AAVE) were disproportionately more likely to be labeled astoxic than those written in white-aligned English by the humans employed to detect toxicity. Not only that,but models trained on those datasets were then more likely to mistakenly label innocuous AAVE language astoxic than they were to mistakenly flag innocuous tweets in white-aligned English. This gives us an ideaof how dataset bias can propagate to models in text classification systems, but what about in cases wheremodels generate text? If models aren't associating text with any human-assigned toxicity labels, how canthey demonstrate bias?As it turns out, evidence of bias is still visible even in cases where the model isn't generating a singlepredefined category for a piece of text. A famous early example of work showing this for Google Translatebased its study on a variety of occupations for which the US Bureau of Labor Statistics publishes genderratios (Prates, Avelar, and Lamb 2019). The authors evaluated machine translation systems that translatedto English from various languages that don't use gendered singular pronouns, constructing sentences suchas“[neutral pronoun] is an engineer”and translating them into English. They found that these systemsdemonstrated a preference for translating to“he”that often far exceeded the actual degree by which menoutnumbered women in an occupation in the US. This bias likely reflects an imbalance in the number oftraining sentences associating men and women with these different professions, indicating another way inwhich a skew in the training data for a task can influence a model.Imbalances like this are examples of those“quirks”we mentioned earlier, and they can be puzzling. Somequirks, like data containing far more mentions of male politicians than female politicians, seem to followfrom the prevalence of those two categories in the real world. Other quirks initially seem to defy commonsense: though black sheep are not prevalent in the world,“black sheep”get mentioned more often in Englishtext than other-colored sheep, perhaps because they're more surprising and worthy of mention (or perhapsbecause a common idiom,“the black sheep of the family,”uses the phrase).In the same way that biases can arise in machine translation systems, LMs can exhibit bias in generatingtext. While current LMs are trained on a large portion of the internet, text on the internet can still exhibitbiases that might be spurious and purely accidental, or that might be associated with all kinds of underlyingfactors: cultural, social, racial, age, gender, political, etc. Very quickly, the risks associated with deployingreal-world systems become apparent if these biases are not checked. Machine learning systems have alreadybeen deployed by private and government organizations to automate high-stakes decisions, like hiring anddetermining eligibility for parole, which have been shown to discriminate based on such factors (Raghavan etal. 2020; Nishi 2019).So how exactly can researchers prevent models from exhibiting these biases and having these effects? It'snot a solved problem yet, and some NLP researchers would argue that these technologies simply shouldn'tbe used for these types of systems, at least until there is a reliable solution. For LMs deployed for generaluse, research is ongoing into ways to make models less likely to exhibit certain known forms of bias (e.g., seesection 4.3.4). Progress on such research depends on iterative improvements to data and evaluations that letresearchers quantitatively and reproducibly measure the various forms of bias we want to remove.Remember: datasets and evaluations never perfectly capture the ideal task!

23

5.3 Are language models intelligent?The emergence of language model products has fueled many conversations, including some that questionwhether these models might represent a form of“intelligence.”In particular, some have questioned whetherwe have already begun to develop“artificial general intelligence”(AGI). This idea implies something muchbigger than an ability to do tasks with language. What do these discussions imply for potential users of thesemodels?We believe that these discussions are largely separate from practical concerns. Until now in this document,we've mostly chosen used the term“natural language processing”instead of“artificial intelligence.”In part,we have made this choice to scope discussion around technologies for language specifically. However, aslanguage model products are increasingly used in tandem with models of other kinds of data (e.g., images,programming language code, and more), and given access to external software systems (e.g., web search),it's becoming clear that language models are being used for more than just producing fluent text. In fact,much of the discussion about these systems tends to refer to them as examples of AI (or to refer to individualsystems as“AIs”).A difficulty with the term“AI”is its lack of a clear definition. Most uncontroversially, it functions as adescriptor of several different communities researching or developing systems that, in an unspecified sense,behave“intelligently.”Exactly what we consider intelligent behavior for a system shifts over time as societybecomes familiar with techniques. Early computers did arithmetic calculations faster than humans, but werethey“intelligent?”And the applications on“smart”phones (at their best) don't seem as“intelligent”topeople who grew up with those capabilities as they did to their first users.But there's a deeper problem with the term, which is the notion of“intelligence”itself. Are the capabilitiesof humans that we consider“intelligent”relevant to the capabilities of existing or hypothetical“AI”systems?The variation in human abilities and behaviors, often used to explain our notions of human intelligence, maybe quite different from the variation we see in machine intelligence. In her 2023 keynote at ACL (one of themain NLP research conferences), the psychologist Alison Gopnik noted that in cognitive science, it's widelyunderstood that“there's no such thing as general intelligence, natural or artificial,”but rather many differentcapabilities that cannot all be maximally attained by a single agent (Gopnik 2023).In that same keynote, Gopnik also mentioned that, in her framing,“cultural technologies”like languagemodels, writing, or libraries can be impactful for a society, but it's people's learned use of them that makethem impactful, not inherent“intelligence”of the technology itself. This distinction, we believe, echoes alongstanding debate in yet another computing research community, human-computer interaction. There,the debate is framed around the development of“intelligence augmentation”tools, which humans directlymanipulate and deeply understand, still taking complete responsibility for their own actions, vs. agents, towhich humans delegate tasks (Shneiderman and Maes 1997).Notwithstanding debates among scholars, some companies like OpenAI and Anthropic state that developingAGI is their ultimate goal. We recommend first that you recognize that“AGI”is not a well-defined scientificconcept; for example, there is no agreed-upon test for whether a system has attained AGI. The term shouldtherefore be understood as a marketing device, similar to saying that a detergent makes clothes smell“fresh”or that a car is“luxurious.”Second, we recommend that you assess more concrete claims about models'specific capabilities using the tools that NLP researchers have developed for this purpose. You should expectno product to“do anything you ask,”and the clear demonstration that it has one capability should neverbe taken as evidence that it has different or broader capabilities. Third, we emphasize that AGI is not theexplicit or implicit goal of all researchers or developers of AI systems. In fact, some are far more excitedabout tools that augment human abilities than about autonomous agents with abilities that can be comparedto those of humans.We close with an observation. Until the recent advent of tools marketed as“AI,”our experience withintelligence has been primarily with other humans, whose intelligence is a bundle of a wide range ofcapabilities we take for granted. Language models have, at the very least, linguistic fluency: the text theygenerate tends to follow naturally from their prompts, perhaps indistinguishably well from humans. But LMsdon't have the whole package of intelligence that we associate with humans. In language models, fluency,

24

for example, seems to have been separated from the rest of the intelligence bundle we find in each other.We should expect this phenomenon to be quite shocking because we haven't seen it before! And indeed,many of the heated debates around LMs and current AI systems more generally center on this“unbundled”intelligence. Are the systems intelligent? Are they more intelligent than humans? Are they intelligent in thesame ways as humans? If the behaviors are in some ways indistinguishable from human behaviors, does itmatter that they were obtained or are carried out differently than for humans?We suspect that these questions will keep philosophers busy for some time to come. For most of us who workdirectly with the models or use them in our daily lives, there are far more pressing questions to ask. Whatdo I want the language model to do? What do I not want it to do? How successful is it at doing what Iwant, and how readily can I discover when it fails or trespasses into proscribed behaviors? We hope that ourdiscussion helps you devise your own answers to these questions.Remember: analogies to human capabilities never perfectly capture the capabilities of languagemodels, and it's important to explicitly test a model for any specific capability that your usecase requires!

6 Where is the development of language models headed?Language models (and the role they play in society) are still in their infancy, and it's too early to say howthey will continue to develop and the main ways in which they will evolve over time. Currently, as we'vementioned, most language models (and generative AI models more generally) are developed by a handful ofcompanies that are not very forthcoming about their construction. However, it's important to remember that,depending on various factors over the next several years, a future of more decentralized models managed bynot-for-profit entities is still possible.One key variable that's still taking shape in determining this future is governed by democratic processes:government regulation, in the form of policy and law. This means that public attention (your attention) toissues around these models could directly influence what the future of the technology looks like. We nowdiscuss both the reasons for difficulties in predicting the future of language model development and the rolethat early regulation of these models has played so far.

6.1 Why is it difficult to make projections about the future of NLP technologies?For perspective, let's consider two past shifts in the field of NLP that happened over the last ten years.The first, in the early 2010s, was a shift from statistical methods—where each parameter fulfilled a specific,understandable (to experts) role in a probabilistic model—to neural networks, where blocks of parameterswithout a corresponding interpretation were learned via gradient descent. The second shift, around 2018–19,was the general adoption of the transformer architecture we described in section 4.2, which mostly replacedpast neural network architectures popular within NLP, and the rise of language model pretraining (as discussedin section 3.2).Most in the field didn't anticipate either of those changes, and both faced skepticism. In the 2000s, neuralnetworks were still largely an idea on the margins of NLP that hadn't yet demonstrated practical use;further, prior to the introduction of the transformer, another, very different structure of neural network18 wasubiquitous in NLP research, with relatively little discussion about replacing it. Indeed, for longtime observersof NLP, one of the few seeming certainties is of a significant shift in the field every few years—whether inthe form of problems studied, resources used, or strategies for developing models. The form this shift takesdoes not necessarily follow from the dominant themes of the field over the preceding years, making it more“revolutionary”than“evolutionary.”And, as more researchers are entering NLP and more diverse groupscollaborate to consider which methods or which applications to focus on next, predicting the direction ofthese changes becomes even more daunting.A similar difficulty applies when thinking about long-term real-world impacts of NLP technologies. Evensetting aside that we don't know how NLP technology will develop, determining how a particular technology

18It was called the LSTM,“long short-term memory”network.

25

will be used poses a difficult societal question. Furthermore, NLP systems are being far more widely deployedin commercial applications; this means that model developers are getting far more feedback about them froma wider range of users, but we don't yet know the effects that deployment and popular attention will have onthe field.Remembering how these models work at a fundamental level—using preceding context to predict the nexttext, word by word, based on what worked best to mimic demonstrations observed during training—andimagining the kinds of use cases that textual mimicry is best-suited towards will help us all stay groundedand make sense of new developments.

6.2 What might AI regulation look like?An important conversation about the future of language models centers around possible regulation of thesemodels. This topic encompasses many related discussions: companies' self-regulation, auditing of modelsby third parties, restrictions on data collection by private companies (such as those recently instituted byReddit), and potential government oversight. Given that companies producing these models must alreadymake decisions about how to adjust their models' behavior, it seems most realistic to consider not whetherregulation by some party will occur, but rather which forms of regulation would be beneficial. We will firstdescribe some early attempts at regulating AI and then hypothesize about what future regulations mightfocus on.Before doing that, we make one additional point. It's worth bearing in mind that calls in the public sphere foror against regulation can arise for a variety of different reasons. For example, as Kevin Roose recently wrotefor the New York Times,“some skeptics have suggested that A.I. labs are stoking fear out of self-interest, orhyping up A.I.'s destructive potential as a kind of backdoor marketing tactic for their own products. (Afterall, who wouldn't be tempted to use a chatbot so powerful that it might wipe out humanity?)”19 Past acertain point, discussion of AI regulation can become politically charged, drawing on many complicatedvariations of societal values. Therefore, similar to when participating in any public discussion, it's helpfulto get in the habit of thinking about why a specific person might be saying what they're saying given theirbackground and interests, as well as who they're hoping their comments will influence.

6.2.1 What versions of government AI regulation are emerging?In terms of concrete regulation that has made its way into the sphere of public policy, US President JoeBiden's Executive Order on AI and the European Union's 2023 AI Act represent the most sweeping regulatorymeasures relating to AI thus far.The Executive Order on AI, made at the end of October 2023, set out to establish general principles aroundAI innovation. These were high-level and focused primarily on the management of AI risk and security, thepromotion of responsible AI innovation and competition, and the protection of individuals and their civilliberties as AI continues to advance. An additional focus of the order is to garner AI talent in the UnitedStates and the US government. While these points are focused on the promotion of AI, the order also includesa threshold of required computing power where a model could be used in“malicious cyber-enabled activity.”That is, if a specific number of floating-point operations used in the training of a model is exceeded, thensome uses of that model might be considered a risk. This definition reflects the difficulty of translatingthe high-level concept of“model risk”into lower-level terms; it is quite possible that there will be furtheriterations of this definition in response to the continued advancement of computing capabilities.The focus of the EU AI Act is the determination of a risk level posed by different AI systems to humanindividuals based on proposed and likely use cases of those systems, for the purposes of identifying higher-risktechnologies and restricting their use. The details of the AI Act are also fairly high-level and ultimately mostof the act was effectively upended by the sudden widespread surge in use of ChatGPT. The AI Act was alodestone for political debates over the extent to which AI regulation should affect different systems, withpositions influenced by concerns as varied as fostering support for scientific innovation or upholding the rightsof those affected by model decisions. The upending of the EU AI Act shows that whatever future regulation

19See also this opinion article by Bruce Schneier and Nathan Sanders.

26

is released likely won't regulate for a certain point in time—as we are already seeing in some ways with theExecutive Order on AI. Any regulation that isn't focused on broader concepts like harm reduction and safeuse cases runs the risk of becoming quickly outdated, given the current (and likely future) pace of technologydevelopment.At a lower level closer to the implementation and training of AI systems, the legal focus so far has over-whelmingly been on copyrights associated with models' training data. A 2018 amendment to Japan's 1970Copyright Act gives generative AI models broad leeway to train on copyrighted materials provided that thetraining's“purpose is not to enjoy the ideas or sentiments expressed in the work for oneself or to have othersenjoy the work.”However, more recent court cases focused on generative image models, such as Getty Imagessuing Stability AI Inc. or a group of artists suing Stability AI, Midjourney, and DeviantArt, are pushingback on that view and have yet to reach a resolution.Even these early forays into the intersection of AI systems with copyright protection differ in their leanings,which shows how difficult it can be to legislate comprehensively on AI issues. (Indeed, there are alreadyfurther proposed amendments to Japan's Copyright Act that consider restricting the application of the 2018amendment.) To date, we haven't seen many court cases focused on generative models of text. Perhaps theclosest is a court case about computer programming language code, namely Doe 1 v. Github, Inc., whichfocuses on the fact that many public repositories of code on the GitHub website, from which training datahas been drawn, come with a license that was stripped from the data during training. Given that such courtcases focus on training data, one unanswered question is how such legal cases will affect companies' opennessabout their models' training data in the future. As we discussed, the more opaque the training data, the lesshope we have of understanding a model.

6.3 How can you contribute to a healthy AI landscape?There are a lot of important actions that help move us towards a future where AI systems are developed inbeneficial ways. We'll list a few here.

• If you're a student interested in AI systems: you can become one of the people helping to decidehow these models work. For anyone in this position, you'll find it useful to study computing, math,statistics, and also fields that reason about society. After all, the question of what we build thesesystems to do deserves just as much attention as the question of how we build these systems to do it.• If you're an expert in something other than AI (e.g., healthcare, a scientific or humanisticfield): the people building these models could really benefit from your expertise. Determining how toadapt AI systems to safely assist with problems faced by experts is not something computer scientistscan do alone. To make these kinds of models useful for you and your field (and to avoid trying to solveproblems that don't really need solving), model developers need your input and help. As more scientistsand engineers enter the growing AI field, it should become easier to find people in your network whoare working on the models. Engage with them!

• If you make decisions in a business sphere: you can set a high bar for evaluating possible AI-basedsystems in your company's workflow. There's considerable flashy language about some of these systems.By ignoring that and instead discussing with developers how a particular system was tested, how wellthat testing relates to your intended use case for it, and what's missing from those tests, you can helpraise overall standards for evaluating AI.

• If you're a concerned consumer: it's a huge help for you to assume a thoughtful, reflective distanceabout LMs and AI news. In recent months, there's been seemingly nonstop discussion of these topics,and there's sure to be a lot more coming. Our biggest goal for this document is that it will help toequip you with the knowledge you need to filter the hype and make sense of the substance.

7 Final remarksCurrent language models are downright perplexing. By keeping in mind the trends in the research communitiesthat produced them, though, we gain a sense of why these models behave as they do. Keeping in mind theprimary task that these models have been trained to accomplish, i.e., next word prediction, also helps us

27

to understand how they work. Many open questions about these models remain, but we hope that we'veprovided some helpful guidance on how to use and assess them. Though determining how these technologieswill continue to develop is difficult, there are helpful actions that each of us can take to push that developmentin a positive direction. By broadening the number and type of people involved in decisions about modeldevelopment and engaging in broader conversations about the role of LMs and AI in society, we can all helpto shape AI systems into a positive force.

AcknowledgmentsThe authors appreciate feedback from Sandy Kaplan, Lauren Bricker, Nicole DeCario, and Cass Hodges atvarious stages of this project, which was supported in part by NSF grant 2113530. All opinions and errorsare the authors' alone.

GlossaryAlgorithm: A procedure that operates on a set of inputs in a predefined, precisely specified way to producea set of outputs. Algorithms can be translated into computer programs. This document references severaldifferent algorithms: (1) stochastic gradient descent, which takes as input a (neural network) modelarchitecture, a dataset, and other settings and produces as output a model; (2) a model itself, which takesas input specified text and produces an output for the task the model was trained to perform (for example, aprobability distribution over different kinds of attitudes being expressed for a sentiment classificationmodel, or a probability distribution over which word comes next for a language model); (3) an algorithmfor constructing a language model's vocabulary (section 3.3).Alignment (of a model to human preferences): This term can refer either to the degree to which a modelreflects human preferences, or to the process of adjusting a model to better reflect human preferences. Seesection 4.3.4.Architecture (of a model): The template for arranging a model's parameters and specifying how thoseparameters are jointly used (with an input) to produce the model's output. Note that specifying the modelarchitecture does not involve specifying the values of individual parameters, which are defined later. (Ifyou consider a model to be a“black box”with knobs on its side that is given an input and produces anoutput, the model's“architecture”refers to the arrangement of knobs on/inside the box without includingthe particular values to which each knob is set.)Artificial intelligence (AI): (1) Broadly describes several fields or research communities that focus onimproving machines' ability to process complicated sources of information about the world (like images ortext) into predictions, analyses, or other human-useful outputs. (2) Also refers in popular usage (but not thisguide) to an individual system (perhaps a model) built using techniques developed in those fields (such asDeep Blue or ChatGPT).Bleu scores: A fully automated way introduced by Papineni et al. (2002) to evaluate the quality of aproposed translation of text into a target language. At a high level, the Bleu score for a proposed translationof text (with respect to a set of approved reference translations for that same text) is calculated by lookingat which fraction of small chunks (e.g., one-word chunks, two-word chunks, etc.) of the proposed translationappear in at least one of the reference translations.Computer vision (CV): A subfield of computer science research that advances the automated processingand production of information from visual signals (images).Content safeguards: A term commonly used within NLP to refer to the strategies that are used to try tokeep language models from generating outputs that are offensive, harmful, dangerous, etc. We give someexamples of these strategies in section 4.3.5.Convergence: A concept in machine learning that explains when the loss between a model's output andexpected output from data is less than some threshold. Model convergence during training usually means

28

that the model is no longer improving, such as occurs at the end of SGD.Data: The pairs of sample inputs and their desired outputs associated with a task, used to train or evaluatea model. For NLP, this is typically a massive collection of either text that originates in digital form (e.g.,text scraped from a post published to an internet forum) or text converted into a digital format (e.g., textextracted from a scanned handwritten document). It may also include additional information describing thetext, like sentiment labels for a sentiment analysis dataset.Data-driven: A description of a process indicating that it determines actions based on analysis of massivedata stores (in contrast to having a person or multiple people make all of these decisions). For example, aperson deciding on the vocabulary for a language model they're about to build could either (1) manuallydefine a list of all words or parts of words that the model's vocabulary would include (not data-driven) or (2)collect text data and run a data-driven algorithm (see section 3.3) to automatically produce a vocabularybased on that dataset for the eventual model. Machine learning algorithms are, in general, data-driven.Deep learning: A term that describes machine learning methods focused on training (neural network)models with many layers.Depth (of a model): Refers to the number of layers a neural network architecture contains.Domain (of data): A specific and intuitive (though not formally defined) grouping of specific data. Forexample, an NLP researcher might refer to“the Wikipedia domain”of text data, or“the business emaildomain”of text data. The term offers an expedient way for researchers or practitioners to refer to data thatgenerally has some unifying characteristics or characteristics different from some other data.Extrinsic evaluation (of a model): An evaluation (of a model) that evaluates whether using that model aspart of a larger system helps that system (and how much), or which considers factors related to the model'seventual use in practice, etc.Finetuning (of a model for a specific task): Continued training of a model on a new dataset of choice thatoccurs after original parameter values were trained on other tasks/datasets. Use of the term“finetuning”indicates that the model about to be finetuned has already been trained on some task/dataset.Function: Broadly, a mapping of inputs to outputs. In other words, a function takes as input any inputmatching a particular description (like“number”or“text”) and will give a (consistent) answer for what thatinput's corresponding output should be. However, everywhere we use the word“function”in this document(except in the context of“autocomplete functions”), we are referring more specifically to functions that takein a set of numbers and produce single-number outputs.Generative AI: A subset of artificial intelligence focused on models that learn to simulate (and cantherefore automatically produce/generate) complex forms of data, such as text or images.Gradient (of a function): A calculus concept. Given a particular point in an n-dimensional landscape,the gradient of a function indicates the direction (and magnitude) of that function's steepest ascent fromthat point. By considering the current parameters of a neural network model as the point in thatn-dimensional landscape, and taking the gradient of a loss function with respect to those parameters, it ispossible to determine a very small change to each parameter that increases the loss function as much aslocally possible. This also indicates that the opposite small change can decrease the loss function as much aslocally possible, the goal when running SGD.Hallucination (by a language model): A term commonly used to describe nonfactual or false statementsin outputs produced by a language model.Hardware: The (physical) machines on which algorithms are run. For contemporary NLP, these are typicallyGPUs (graphics processing units), which were initially designed to render computer graphics quickly but werelater used to to do the same for the kinds of matrix-based operations often performed by neural networks.Intrinsic evaluation (of a model): An evaluation (of a model) that evaluates that model on a specific testset“in a vacuum,”that is, without considering how plugging that model into a larger system would helpthat larger system.

29

Label: Some tasks have outputs that are a relatively small set of fixed categories (unlike language modeling,where the output is a token from some usually enormous vocabulary). In cases where outputs are decidedfrom that kind of small set, NLP researchers typically refer to the correct output for a particular input asthat input's“label”. For example, the set of labels for an email spam-identification task would be“spam”or“not spam,”and a sentiment analysis task might define its set of possible labels to be“positive,”“negative,”or“neutral.”Language model: A model that takes text as input and produces a probability distribution over whichword in its vocabulary might come next. See section 3.Layer (of a neural-network-based model): A submodule with learnable parameters of a neural networkthat takes as input a numerical representation of data and outputs a numerical representation of data. Modernneural networks tend to be deep, meaning that they“stack”many layers so that the output from one layeris fed to another, whose output is then fed to another, and so on.Loss function: A mathematical function that takes in a model's proposed output given a particular inputand compares it to (at least) one reference output for what the output is supposed to be. Based on howsimilar the reference output is to the model's proposed output, the loss function will return a single number,called a“loss.”The higher the loss, the less similar the model's proposed output is to the reference output.Machine learning (ML): An area of computer science focused on algorithms that learn how to (ap-proximately) solve a problem from data, i.e., to use data to create other algorithms (models) that aredeployable on new, previously unseen data.Mappings (of input to output): A pairing of each (unique) possible input to a (not necessarily unique)output, with the mapping“translating”any input it is given to its paired output.Model: An algorithm for performing a particular task. (NLP researchers typically refer to such analgorithm as a model only if its corresponding task is sufficiently complicated to lack any provably correct,computationally feasible way for a machine to perform it. Hence, we apply machine learning to build amodel to approximate the task.) Though a model that performs a particular task does not necessarily haveto take the form of a neural network (e.g., it could instead take the form of a list of human-written rules),in practice, current NLP models almost all take the form of neural networks.Natural language processing (NLP): A subfield of computer science that advances the study andimplementation of automated processing and generation of information from text and, perhaps, otherlanguage data like speech or video of signed languages.Neural network: A category of model architecture widely used in machine learning that is subdif-ferentiable and contains many parameters, making it well-suited to being trained using some variant ofstochastic gradient descent. Neural networks use a series of calculations performed in sequence by denselyconnected layers (loosely inspired by the human brain) to produce their output.(Numerical) optimization: Can refer to (1) a family of strategies for choosing the best values for apredetermined set of parameters, given a particular quantity to minimize/maximize which is calculatedbased on those parameters (and often some data as well) or to (2) the field of research that studies thesestrategies. In this document we refer exclusively to the first definition.Overfitting: When a model learns patterns that are overly specific to its training data and that do notgeneralize well to new data outside of that training set. This problem is typically characterized by the model'svery strong task performance on the training data itself but far worse performance when given previouslyunseen data.Parallel text: A term used within NLP to refer to pairs of text (usually pairs of sentences) in two languagesthat are translations of each other. Parallel text is widely used for the development of NLP models thatperform the task (commonly called“machine translation”) of translating text from a specific source language(e.g., Urdu) into a specific target language (e.g., Thai). Some pairs of languages have much more (digital)parallel text available, and the difference in the quality of machine translation systems across differentlanguage pairs reflects that disparity.

30

Parameter (in a neural network model): A single value (model coefficient) that is part of the mathematicalfunction that neural networks define to perform their operations. If we consider a model as being a blackbox that performs some task, a parameter is a single one of that black box's knobs.“Parameter”can refereither to the knob itself or the value the knob is set to, depending on context.Perplexity: A number from 1 to infinity that represents how“surprised”a language model generally is tosee the actual continuations of fragments of text. The lower the perplexity, the better the language model canpredict the actual continuations of those text fragments in the evaluation data. Perplexity is an importantintrinsic evaluation for language models.Probability distribution: A collection of numbers (not necessarily unique) that are all at least 0 and addup to 1 (for example, 0.2, 0.2, 0.1, and 0.5), each paired with some possible event; the events are mutuallyexclusive. For one such event, its number is interpreted as the chance that the event will occur. For example,if a language model with a tiny vocabulary consisting of only [apple, banana, orange] takes as inputthe sentence-in-progress“banana banana banana banana”and produces a probability distribution over itsvocabulary of 0.1 for“apple,”0.6 for“banana,”and 0.3 for“orange,”this means that the model is predictingthat the next word to appear after the given sentence-in-progress has a 60% chance of being“banana.”Prompt (to a language model): The text provided by a user to the language model, which the modelthen uses as its context—i.e., as its initial basis for its next word prediction that it performs over and overagain to produce its output, word by word.Sentiment analysis: A task in NLP that aims to determine whether the overall sentiment of a piece oftext skews positive, negative, or in some versions of the task, neutral. For example, suppose that a sentimentanalysis model was given the input“Wow, that movie was amazing!”The correct output for the model giventhat input would be“positive”(or five stars, or 10/10, or something similar if the labels were in the form ofstars or integer scores from 0 to 10 instead).Stochastic gradient descent (SGD): A process by which parameters of a model are adjusted to minimizesome specific function (e.g., a loss function). SGD requires repeatedly running varying batches of datathrough the model, whose output can then be used to get a value from our (loss) function. For each batch,we then use the gradient of that function to adjust the parameters of our model to take a tiny descendingstep along that gradient. This process is repeated until the loss function's gradient flattens out and stopsindicating a lower direction.Task: A job we want a model to do. Tasks are usually described abstractly—for example, sentiment analysis,question answering, or machine translation—in a way that is not tied to any one source of data. However, inpractice, if a model is trained to perform a particular task, the version of that task that the model learns toperform will be heavily influenced by the specific training data used. See section 5.2.2.Test set (or test data): A set of data unseen by a model during its training, used to evaluate how wellthe model works.Token: The base unit of language into which an NLP model splits any text input. For contemporarylanguage models, a token can be either a word or a piece of a word. A text input passed to such a modelwill be split into its component words (in cases where that word is part of the model's vocabulary) and wordpieces (in cases where that full word doesn't exist in the model's vocabulary, so its component pieces areadded to the sequence of tokens instead).Training set (or training data): A set of data used to train a model (in other words, to decide thatmodel's parameter values). For a model that takes the form of a neural network, the training set comprisesthe batches of data used while running stochastic gradient descent.Transformer: A kind of neural network architecture introduced in 2017 that allows large models builtusing it to train faster than earlier model architectures would have allowed, and on more data (assumingaccess to certain relatively high-memory hardware). They do this by using techniques (e.g., self-attention)beyond the scope of this work. See section 4.2.

31

ReferencesChurch, Kenneth W., and Robert L. Mercer. 1993.“Introduction to the Special Issue on ComputationalLinguistics Using Large Corpora.”Computational Linguistics 19 (1): 1–24. https://aclanthology.org/J93-1001.

Dodge, Jesse, Maarten Sap, Ana Marasović, William Agnew, Gabriel Ilharco, Dirk Groeneveld, MargaretMitchell, and Matt Gardner. 2021.“Documenting Large Webtext Corpora: A Case Study on the ColossalClean Crawled Corpus.”In Proceedings of the 2021 Conference on Empirical Methods in Natural LanguageProcessing, 1286–1305. Online; Punta Cana, Dominican Republic: Association for ComputationalLinguistics. https://doi.org/10.18653/v1/2021.emnlp-main.98.

Gopnik, Alison. 2023.“Large Language Models as Cultural Technologies.”Presented at the 61st Annual

Meeting of the Association for Computational Linguistics.

Gururangan, Suchin, Dallas Card, Sarah Dreier, Emily Gade, Leroy Wang, Zeyu Wang, Luke Zettlemoyer,and Noah A. Smith. 2022.“Whose Language Counts as High Quality? Measuring Language Ideologies inText Data Selection.”In Proceedings of the 2022 Conference on Empirical Methods in Natural LanguageProcessing, 2562–80. Abu Dhabi, United Arab Emirates: Association for Computational Linguistics.https://aclanthology.org/2022.emnlp-main.165.

Hoffmann, Jordan, Sebastian Borgeaud, Arthur Mensch, Elena Buchatskaya, Trevor Cai, Eliza Rutherford,Diego de Las Casas, et al. 2022.“An Empirical Analysis of Compute-Optimal Large Language ModelTraining.”In Advances in Neural Information Processing Systems, edited by S. Koyejo, S. Mohamed, A.Agarwal, D. Belgrave, K. Cho, and A. Oh, 35:30016–30. Curran Associates, Inc. https://proceedings.neurips.cc/paper_files/paper/2022/file/c1e2faff6f588870935f114ebe04a3e5-Paper-Conference.pdf.

Nelson, Alondra. 2023.“Thick Alignment.”Presented at the 2023 ACM Conference on Fairness, Accountabil-

ity, and Transparency (ACM FAccT). https://youtu.be/Sq_XwqVTqvQ?t=957.

Nishi, Andrea. 2019.“Privatizing Sentencing: A Delegation Framework for Recidivism Risk Assessment.”Columbia Law Review 119 (6): 1671–1710. https://columbialawreview.org/content/privatizing-sentencing-a-delegation-framework-for-recidivism-risk-assessment/.

Papineni, Kishore, Salim Roukos, Todd Ward, and Wei-Jing Zhu. 2002.“Bleu: A Method for AutomaticEvaluation of Machine Translation.”In Proceedings of the 40th Annual Meeting of the Association forComputational Linguistics, 311–18. Philadelphia, Pennsylvania, USA: Association for ComputationalLinguistics. https://doi.org/10.3115/1073083.1073135.

Peters, Matthew E., Mark Neumann, Mohit Iyyer, Matt Gardner, Christopher Clark, Kenton Lee, and LukeZettlemoyer. 2018.“Deep Contextualized Word Representations.”In Proceedings of the 2018 Conferenceof the North American Chapter of the Association for Computational Linguistics: Human LanguageTechnologies, Volume 1 (Long Papers), 2227–37. New Orleans, Louisiana: Association for ComputationalLinguistics. https://doi.org/10.18653/v1/N18-1202.

Prates, Marcelo O. R., Pedro H. Avelar, and Luís C. Lamb. 2019.“Assessing Gender Bias in MachineTranslation: A Case Study with Google Translate.”Neural Computing and Applications 32 (10): 6363–81.https://doi.org/10.1007/s00521-019-04144-6.

Raghavan, Manish, Solon Barocas, Jon Kleinberg, and Karen Levy. 2020.“Mitigating Bias in AlgorithmicHiring: Evaluating Claims and Practices.”In Proceedings of the 2020 Conference on Fairness, Account-ability, and Transparency, 469–81. FAT* '20. New York, NY, USA: Association for Computing Machinery.https://doi.org/10.1145/3351095.3372828.

Sap, Maarten, Dallas Card, Saadia Gabriel, Yejin Choi, and Noah A. Smith. 2019.“The Risk of RacialBias in Hate Speech Detection.”In Proceedings of the 57th Annual Meeting of the Association forComputational Linguistics, 1668–78. Florence, Italy: Association for Computational Linguistics. https://doi.org/10.18653/v1/P19-1163.

Sennrich, Rico, Barry Haddow, and Alexandra Birch. 2016.“Neural Machine Translation of Rare Wordswith Subword Units.”In Proceedings of the 54th Annual Meeting of the Association for ComputationalLinguistics (Volume 1: Long Papers), 1715–25. Berlin, Germany: Association for ComputationalLinguistics. https://doi.org/10.18653/v1/P16-1162.

Shannon, C. E. 1951.“Prediction and Entropy of Printed English.”The Bell System Technical Journal 30

(1): 50–64. https://doi.org/10.1002/j.1538-7305.1951.tb01366.x.

Shneiderman, Ben, and Pattie Maes. 1997.“Direct Manipulation Vs. Interface Agents.”Interactions 4 (6):

42–61. https://doi.org/10.1145/267505.267514.

32

Vaswani, Ashish, Noam Shazeer, Niki Parmar, Jakob Uszkoreit, Llion Jones, Aidan N Gomez, Łukasz Kaiser,and Illia Polosukhin. 2017.“Attention Is All You Need.”In Advances in Neural Information ProcessingSystems, edited by I. Guyon, U. Von Luxburg, S. Bengio, H. Wallach, R. Fergus, S. Vishwanathan, and R.Garnett. Vol. 30. Curran Associates, Inc. https://proceedings.neurips.cc/paper_files/paper/2017/file/3f5ee243547dee91fbd053c1c4a845aa-Paper.pdf.

Wiener, Norbert. 1960.“Some Moral and Technical Consequences of Automation.”Science 131 (3410):

1355–58. http://www.jstor.org/stable/1705998.

AppendixLoss functions and gradient descent, a bit more formallyThe first important property for a loss function is that it takes into account all the potential good and badthings about outputs when deducting points. The more dissimilar our model's output given a particular inputis from that input's correct output, the higher the loss function should be. The second important propertyis that we must be able to deduce, fully automatically and in parallel for all parameters, what adjustmentswould make the loss function decrease. You may recall from a course on calculus that questions like“Howdoes a small change to an input to a function affect the function's output?”are related to the concept ofdifferentiation. In sum, we need the loss function to be differentiable with respect to the parameters. (Thismay be a bit confusing because in calculus, we think about differentiating a function with respect to itsinputs. In a mathematical sense, the input is only part of the input to the mathematical function encoded bya neural network; the parameters are also part of its input.) If the loss function has this property, then wecan use differentiation to automatically calculate a small change for each parameter that should decrease theloss on a given example.These two properties—faithfulness to the desired evaluation and differentiability with respect to parame-ters—conflict because most evaluation scores aren't differentiable. Bleu scores for translation and error ratesfor sentiment analysis are stepwise functions (“piecewise constant”in mathematical terms): changing theparameters a tiny bit usually won't affect these evaluation scores; when it does, it could be a dramatic change.Human judgments also are not differentiable with respect to parameters.Once we know a differentiable loss function, and with a few additional assumptions, we quickly arrive at thealgorithm for stochastic gradient descent (SGD), for setting system parameters. To describe its steps a bitmore formally than we did in section 2.3.2:

1. Initialize the parameters randomly.2. Take a random sample of the training data (typically 100 to 1000 demonstrations); run each inputthrough the system and calculate the loss and its first derivative with respect to every parameter.(When first derivatives are stacked into a vector, it's called the gradient.) Keep a running total of thesum of loss values and a running total of the sum of gradients.

3. For each parameter, change its value proportional to the corresponding value in the gradient vector. (If

the gradient is zero, don't change that parameter.)

4. Go to step 2 if the loss is converging.

Word error rate, more formallyGiven some test data (some text the language model wasn't trained on), we can calculate the error rate asfollows. Let the words in the test data be denoted by w1, w2, ... , wN.

1. Set m = 0; this is the count of mistakes.2. For every word wi in the test data (i is its position):

1. Feed wi's preceding context, which after the first few words will be the sequence w1, w2, ... , wi−1,

into the language model as input.

33

2. Let the language model predict the next word; call its prediction wpred.3. If wpred is anything other than wi, the language model made an incorrect prediction, so add 1 to

m.

3. The error rate is m/N.

Perplexity, more formallySection 3.4 describes underlying properties of how LMs make“decisions”about next words. Here, to preparefor a deeper dive into perplexity, we summarize and build on those properties:

• Based on the context of preceding words, a calculation is made by the neural network that assigns aprobability to every word in the vocabulary, that is, every possible choice of what word could come next.These probabilities must always sum to one (that's part of the definition of a probability distribution),and we also impose a“no zeros”rule: the probability of every vocabulary word must always be atleast slightly positive.

• To predict the next word, the model can either (a) choose the one with the highest probability (asassumed in the error rate calculation above) or (b) simulate a draw from the probability distribution,choosing a word at random such that each word's chance of being drawn is given by its probability.To illustrate, imagine a pub trivia team where individual members have different past success rates ofbeing correct. Approach (a) would correspond to the team always submitting the answer proposed bythe trivia-whiz team member whose suggested answers had most often been correct before. Approach(b) would correspond to randomly picking who should answer, with the trivia whiz's answer being mostlikely to be chosen, the second-best team member's answer next most likely, then the third-best teammember's answer, and so on. Note that the most likely outcome from (b) is the same as the outcomefrom (a), but (b) will sometimes lead to another, lower-probability word.

Whether (a), (b), or some other approach is used when an LM is deployed is an important design decision. Inkeeping with our earlier rejection of error rate, researchers try to avoid evaluating LMs in a way that makesunnecessary commitments to its eventual use.20 Option (b) is interesting because it suggests a workaroundto the pitfalls of simply counting mistakes discussed in section 3.4.In the preceding appendix subsection's error rate calculation procedure, we could apply option (b) in step 2.2.Suppose we do this not once, but many times for each context/word pair and average the error rate acrossthese random draws. With enough draws, this approach would provide meaningful error rates because we'dexpect to get each word right some of the time (no zeros rule). In practice, rather than actually carrying outthe random draws, we instead use the LM's probabilities directly to assign a score for every word in the testdata. The results of this approach are that:

• If the language model gave probability 1 to the correct next word, the score for that word would be 1.This can't happen exactly because the probabilities of all the wrong words have to exceed zero (nozeros rule). But we can get arbitrarily close in principle if the probabilities of all the wrong words getinfinitesimally small.

• If the LM gave probability 0 to the correct next word, the score for that word would be 0. But this

can't happen either because of the no zeros rule.

• In general, the greater the probability the LM assigns to the correct next word, even if it's not the most

probable word, the higher the score.

Because of the no zeros rule, the per-word probability scores are always somewhere between 0 and 1.Given the test data, we can calculate the LM probability for every word given its preceding context. If wetook a simple average of these probability scores and subtracted that from 1, we would get something like anerror rate (technically, an“expected”error rate under prediction method (b)). What is done in practice is20The technical term for our desired evaluation is“intrinsic”evaluation, meaning that we want a measure of the intrinsic

quality of a model, not its performance in some extrinsic setting.

34

similar in spirit but slightly different: we take the geometric average of the inverses of these probability scores,a value known as (test data) perplexity. The reasons are partly practical (tiny numbers can lead to a problemin numerical calculations, called underflow), partly theoretical, and partly historical. For completeness, here'sthe procedure:

1. Set m = 0. (This quantity is no longer a running tally of mistakes.)2. For every word wi in the test data (i is its position):

1. Feed wi's preceding context, which after the first few words will be the sequence w1, w2, ... , wi−1,

into the language model as input.

2. Let p be the probability that the language model assigns to wi (the correct next word).3. Add − log(p) to m.

3. The perplexity is exp(m/N).

Though it's probably not very intuitive from the preceding procedure, perplexity does have some nice intuitiveproperties:

• If our model perfectly predicted every word in the test data with probability 1, we would get a perplexityof 1.21 This can't happen because (1) there is some fundamental amount of uncertainty in fresh, unseentext data, and (2) some probability mass is reserved for every wrong word, too (no zeros rule). Ifperplexity comes very close to 1, the cardinal rule that test data must not be used for anything otherthan the final test, like training, should be carefully verified.

• If our model ever assigned a probability of 0 to some word in the test data, perplexity would go to

infinity.22 This won't happen because of the no zeros rule.

• Lower perplexity is better.• The perplexity can be interpreted as an average“branch factor”; in a typical next word prediction

instance, how many vocabulary words are“effectively”being considered?

21To see this, note that − log(1) = 0, so m stays 0 throughout step 2. Note that exp(0/N) = exp(0) = 1.22To see this, note that log(0) tends toward infinity.

### 中文




2 背景：自然语言处理概念和工具

语言模型是信息论、机器学习、语音处理和自然语言处理等学科研究的结果。这项工作的作者属于自然语言

处理 (NLP) 的研究人员，其中的成员一直在探索计算机和自然语言之间的关系，自 20 世纪 60 年代以来。本

社区提出的两个基本和相关的问题是:「计算机以何种方式理解和使用自然语言？」和「在何种程度上可以通过

计算模拟自然语言的属性？」第一个问题主要通过尝试构建显示语言理解和语言使用行为的计算机程序来解

决 (如与人交谈); 它在很大程度上被视为一种工程追求，严重依赖于硬件的进步。第二个问题将自然语言处

理引入语言学、认知科学和心理学领域。在这里，人们倾向于从科学的角度来看待语言 (试图通过实验来推

进自然语言作为一种可观察现象的理论构建)，或者有时从数学的角度来看待语言 (寻求形式证明)。因为这

两个问题是紧密联系在一起的，对其中任何一个问题感兴趣的人经常交谈和合作，许多人对这两个问题都感兴趣。12

我们相信 NLP 社区在研究中使用的概念 (想法、术语和问题) 和工具 (问题解决方法) 有助于加深对语言模型的理解。它们为许多人工智能研究人员和实践者所熟悉，并且在其他社区 (例如，计算机视觉) 也有类似的进化。如果您有计算机编程、数据科学或离散数学方面的经验

自然语言」是一种在社区中自然发展起来的语言，如夏威夷语、葡萄牙语或美国手语。自然语言规划研究者主要关注人类语言，特别是这些语言的书面形式。大多数情况下，自然语言与 Python 和 C++ 等编程语言形成对比，后者是特意设计的、带有目标的工件。

2「NLP」首字母缩略词还有其他用法，含义截然不同。模糊词语是自然语言中的常见现象，也是自然语言处理领域面临的挑战之一。

3

计算机科学基础，你可能已经接触到这些想法之前，但我们不相信他们是普遍或一贯地教在课堂上就这些主题。对它们有一个基本的了解将帮助你像一个 NLP 专家一样思考。

2.1 任务化：定义我们希望系统做什么

建造机器的第一步是决定我们希望机器做什么。建造发电厂、运输设备或烹饪设备的人根据一个详细说明所需系统输入和输出的规范工作。仅仅说「发电厂必须为镇上所有的家庭提供电力」是不够的。工程师们需要一份精确的报告，说明将要生产多少千瓦时、建设发电厂的预算、预期的环境影响、所有监管发电厂建设的法律，这些法律实际上是为了保证安全，等等。

举一个与构建 NLP 系统更简单、更相关的例子，考虑一个按字母顺序对名称列表进行排序的计算机程序 (在非常抽象的意义上是「机器」; 我们也将其称为「系统」)。这项任务听起来很简单，计算机科学专业的学生可能会开始考虑排序列表的不同程序。但是，在我们开始编写代码之前，需要处理一些细节，例如:

·名称将如何输入到程序中，程序应如何处理输出？(例如，程序是否在用户的笔记本电脑上本地运行？或者是否存在用户用于输入然后在浏览器选项卡中查看输出的 web 界面？或者是否上载 / 下载文件？如果是，这些文件的格式是什么？)

·什么字符集将出现在输入中，我们使用什么规则对它们进行排序？(例如，「O'Donnell」等名字中的撇号怎么处理？应如何处理变音 (重音) 字符？如果有些名字是拉丁文的，有些是阿拉伯文的，会怎么样？)

·程序可以使用多少内存或需要多快执行是否有限制？如果输入列表太长，程序将违反这些约束，那么用户是否应该收到失败消息？

图 1: 一些任务，如按字母顺序排列的名称排序，可能看起来非常简单，但通常会提出详细的问题，这些问题必须针对完整的规范进行解决。

这些问题可能看起来很乏味，但我们对正在构建的系统的最终使用预期越彻底，就越能确保它在所有可能的情况下都能按预期运行。

2.1.1 抽象与具体系统功能当构建一个 NLP 系统时，情况与名称排序器没有什么不同，只是它很难精确。考虑一下 NLP 社区在其 60 年的

历史中一直针对的一些能力:

·将文本从一种语言翻译成另一种语言

·将一个或多个文档汇总到几个段落或结构化表格中·使用一个或多个文档中的信息回答问题

·与人交谈并遵循他们给出的任何指示

4

由于自然语言输入 (和输出) 的开放性，这些高级应用程序中的每一个都会立即引发大量问题，可能比名称排序器这样的简单应用程序要多得多。对这些问题的一些回答可能会让专家很快得出结论，即所需的系统还不可能实现，或者用最好的可用方法构建起来会非常昂贵。研究人员试图通过定义任务或应用程序版本来解决这些具有挑战性的问题，这些任务或应用程序版本在进行一些简化假设的同时抽象出一些细节。

例如，考虑从一种语言到另一种语言的文本翻译。以下是许多翻译研究项目中的一些相当传统的假设:

·输入文本将使用一小部分语言之一；它将被格式化根据报纸一样的写作惯例。输出文本也是如此。

·文本将被翻译成一句话或一段相对较短的文本。

·整个片段将在翻译过程中可用 (也就是说，翻译不会在生成输入文本时「实时」进行，而在为直播字幕时

可能需要这样做)。

不难发现对自动翻译的研究与上述的研究有不同的假设。一个运行良好且依赖较少假设的新系统通常被视为研究界正在向更难的问题迈进的标志。例如，仅在过去几年中，我们才实现了从支持单输入到输出翻译的系统到支持多输入到输出语言的系统的飞跃。我们强调，总有一些狭义的假设，希望是暂时的，使问题更精确，因此更可解决。

我们相信，当我们认识到给定系统下的假设时，许多关于 AI 系统的讨论变得更容易理解。在更一般 / 抽象的任务和更具体 / 具体的任务之间存在着持续的紧张关系，在这些任务上，研究人员的进步更具影响力和刺激性。解决一个具体的、定义良好的任务可能对某些人非常有用，但是如何定义该任务的某些细节可能会阻止该任务的进度对其他人有用。为了增加具体任务的工作推广到其他任务的机会，让真实世界的用户社区参与到该任务的定义中是至关重要的。

2.1.2 我们需要数据和评估方法来评估任务的研究进展术语「任务」通常在研究人员中用于指 NLP 系统某些组件的规范，尤其是数据和评估:

·数据：有一组现实的演示可能的输入与他们期望的输出配对。

·评估：有一种方法可以定量和可再现地测量任何系统的输出与期望输出的匹配程度。

大量的研究活动集中在为自然语言处理研究建立数据集和评估方法上，二者在很大程度上相互依赖。再考虑一下翻译示例。对于某些用例，很容易找到语言之间的翻译示例。一个典型的例子是议会语言从英语翻译成法语，反之亦然。加拿大议会的议事录以英文和法文向公众提供，因此，人工翻译不断地制作这种演示；成对的双语文本在研究界常被称为平行文本。欧洲议会对多种语言也这样做。对于某些语言或成对的语言来说，找到这样的数据并不容易，因此，欧洲语言的自动化翻译比其他语言的自动化翻译有了相当大的进步。

那么翻译评价呢？评估系统翻译文本效果的一种方法是进行演示，将输入部分输入到系统中，然后让人判断所需的输出和系统输出。我们可以询问法官系统输出对期望输出的忠实程度。如果法官说两种语言，我们可以向他们展示输入，而不是期望的输出 (或除此之外)，并提出相同的问题。我们也可以要求人类判断者只看系统输出，判断文本的流畅性。你可以想象，有很多可能的变化，结果可能取决于我们问什么问题，我们如何表达这些问题，我们招募哪些评委，他们

5

已经了解翻译系统，他们对语言的了解程度，以及我们是否支付他们的费用。

2002 年，为了加快研究工作中的翻译评估速度，研究人员引入了一种全自动的方法来评估翻译质量，称为「Bleu」评分 (Papineni et al.2002)，此后提出了许多替代方法，并对这些廉价的自动方法与人类判断的相关性进行了大量讨论。翻译的自动评价面临的一个挑战是，自然语言提供了许多表达同一事物的方法。一般来说，可靠地评估翻译质量可能需要识别所有备选方案，因为系统 (原则上) 可以选择其中任何一个。

我们使用翻译作为一个运行的例子，正是因为这些问题是如此有争议和潜在的成本为这项任务。接下来，我们将考虑一个相当具体的任务，这个任务要简单得多：对电影评论的总体基调进行分类 (正面与负面)，并举例说明一个更一般的问题，即情感分析。在这里，研究人员收集了电影评论网站的演示，这些网站将评论与数字评分 (例如「一到五星」) 配对。如果系统以评论作为输入并预测评分，我们可以很容易地检查输出是否与作者给出的实际评分完全匹配，或者计算系统与正确评分之间的差异。在这里，数据的收集相对容易，系统质量的定义也没有争议：系统所犯的错误越少 (或者作者星数与系统预测星数的差值越小)，系统的质量就越高。

但是，请注意，在电影评论情感任务中表现良好的系统在餐馆、电子产品或小说评论中可能表现不佳。这是因为人们用来表达他们喜欢或不喜欢一部电影的语言在不同的语境中不会有相同的含义。(如果一个评论者说一部电影「运行了很长时间」，这显然不如对电池驱动牙刷的评论那么积极。) 一般来说，了解任务的范围和系统是如何评估的，对于理解我们可以从系统的可推广性方面期待什么，或者它的性能质量保持得如何，因为它在输入上的使用越来越少，越来越不像最初评估的那样。当我们比较系统时，这也是至关重要的；如果评估使用不同的演示或衡量质量的方式不同，那么比较就没有意义。

在 NLP 的大部分历史中，NLP 专注于可部署系统的研究而不是开发。最近对面向用户系统的兴趣突出了任务化以及数据集和评估需求方面的长期紧张。一方面，研究者倾向于研究更抽象的任务，这样他们的发现将更普遍地适用于许多潜在的系统。例如，科学界将更为兴奋，因为我们可以预期，对于许多语言对 (而不是一种语言) 的翻译系统，或者对于许多类型的评论 (而不仅仅是电影) 的情感分析系统，将会有改进。另一方面，创建一个人们想要使用的系统具有近期价值，因为它很好地解决了一个特定的问题，这需要更具体地了解预期用户、他们的数据和有意义的评估。

在研究甚至相当具体的任务和构建可用的系统之间还有一步要走。它们的评估非常不同。研究中的评估往往侧重于特定的、狭义定义的能力，如数据样本所示。在研究论文中，经常有一个未陈述的假设，即提高的任务性能将推广到类似的任务，也许会有一些退化。研究界倾向于共享这些假设，但专门针对跨数据域的泛化和鲁棒性的研究除外。同时，可部署系统倾向于对预期用户进行更严格的测试，至少是由有意取悦这些用户的组织构建的。在部署中，「任务性能」只是预期性能的一部分 (系统还必须相当快，具有直观的用户界面，对用户造成的风险很小，等等)。

对 NLP 系统感兴趣的人应该注意 (1) 高水平、有抱负的能力，(2) 允许可衡量研究进展的「任务化」版本，以及 (3) 面向用户的产品之间的差距。随着研究的进展，由于上面讨论的紧张关系，「任务」及其数据集和评估措施总是在不断变化。

6

2.2 更深入地了解数据：数据来自何处以及如何使用对于上面讨论的两个任务示例 (翻译和情感分析任务)，我们注意到，对于某些任务实例，演示 (输入和输出)

相对容易找到。但是，数据可能并不总是那么容易获得。数据的可用性是一个重要问题，原因有两个:

·对于大多数 NLP 应用程序，以及大多数旨在近似这些应用程序的任务，没有「简单」的数据源。(我们认为，电影评论的情感分析之所以得到如此广泛的研究，是因为数据非常容易找到，而不是因为自动预测明星数量的需求特别高。)

·最著名的构建系统的技术需要访问大量的额外数据构建系统，而不仅仅是评价其输出的质量。

2.2.1 区分培训和测试数据从这里开始，我们将用于构建系统的数据称为培训数据，将用于评估系统的数据称为测试数据。这种区别非

常重要，原因很容易理解。

图 2: 当数据被分成训练集和测试集时，两者之间没有重叠是至关重要的。

试想一个学生，他在考试前几周拿到了一份自己班级的期末考试的复印件。不管学生在参加考试时有多大的责任，不管他们是否知道自己看到的考试是真正的期末考试，不管他们在那几周和考试中表现得多么体面，如果他们得到高分，教师不能断定学生已经学习了材料。NLP 系统也是如此。为了使测试数据可用作系统输出质量的指标，测试数据必须是系统的「新」数据。我们认为这是 NLP 实验的基本规则：在最终测试之前，测试数据不能用于任何目的。有时，有人会发现违反此规则的案例，并且 (无论违反规则者的意图或意识如何) 依赖于该案例的任何研究结论必须视为不可靠。

7

要了解 NLP 系统的实际质量，关键是不要根据训练期间看到的数据对系统进行评估。2.2.2 从头开始创建数据集

让我们考虑情绪分析问题的一个变体，它可能出现在高风险的学术决策环境中。假设我们计划建立一个 NLP 系统，读取大学学位申请者的推荐信。系统应评估推荐人对申请人的情感。从表面上看，这类似于我们前面讨论的电影评论问题。但是这个用例引入了一些新的挑战。

首先，我们不太可能找到可用于培训或评估系统的演示。推荐信非常私人；编写它们的人这样做是基于这样的假设，即它们不会向不需要阅读它们来评估应用程序的任何人透露。如果我们能在公共网站上找到推荐信，很可能它们不是应该存在的 (因此使用起来不道德)，或者它们是用来教人们如何写推荐信或评估推荐信的合成示例 (因此是人为的，并且可能在关键的实际方式上不同于实际的推荐信请记住，我们需要现实的演示)。3

第二个问题是，考虑到候选人的业绩和潜力的许多方面，推荐信中传达的信息往往很复杂。将信件映射到单个数字或类别似乎很有挑战性 (如果很容易，我们不会要求推荐人写信，我们只会要求他们报告数字或类别)。最后，正如任何曾在招生委员会或招聘委员会工作过的人所知道的那样，在解释推荐信时存在很大的主观性。不同的读者可能会对一个字母中的主要信号得出不同的结论。即使我们克服了寻找要使用的字母的障碍，这也只是我们需要的一半，因为演示需要包括期望的输出和输入。

事实上，研究人员或系统构建人员尝试探索的任务通常受到可用数据的限制。当所需数据 (或任何类似数据) 不可用时，有时可以创建它。例如，要自动分析社交媒体上有关某个备受讨论的公众人物的消息，我们可以雇佣人员来完成标记消息样本的任务，从本质上展示我们最终系统所需的行为。对于那些使用推文语言并熟悉社交环境的人来说，给政客的推文贴标签可能相对容易。

相反，有些任务需要更多的专业知识。例如，要构建一个系统来回答有关医学期刊文章的问题，我们希望数据由知道如何阅读和理解这些文章的人创建，以便答案是准确的，并且基于文章的具体内容。当然，雇用专家从事这项工作的费用要比雇用非专家高。为 NLP 创建数据集的一个主要权衡是演示的内在质量和多样性以及生成它们的成本。我们认为，高质量的数据对于可靠的评估 (测试数据) 和对这些评估 (培训数据) 的高性能通常是必不可少的。

为大多数 NLP 任务收集训练数据是相当困难的，这常常影响到研究哪些可能的 NLP 应用程序或问题。2.3 构建 NLP 系统

近十年来，除了少数例外，为特定任务构建 NLP 系统的主要方法是基于机器学习。机器学习 (ML) 指的是关于数据驱动方法的理论和实践知识，用于解决人类难以解决的问题。随着新发现的出现、不同性能要求的强调以及新硬件的可用性，这些方法会随着时间的推移而改变。数额巨大

3 在 NLP 术语中，查找和收集此类现有演示将被视为数据集创建。NLP 中的「创建数据集」可以指通过专家注释或众包创建新文本，或者将现有文本收集到模型开发人员更容易访问的形式，例如通过 web 爬网或抓取。

8

许多关于机器学习方法的教程内容已经提供，每一项新的研究进展都会带来新的贡献。在这里，我们将介绍一些在当前环境中导航所需的关键想法。

第一个概念是参数。参数类似于附加到系统的单个旋钮：旋转旋钮会影响系统的行为，包括系统在所需任务上的执行情况。为了使之具体化，让我们考虑一个非常简单的过滤垃圾邮件的系统。由于预算限制，此系统只有一个参数。该系统的工作原理如下：它扫描收到的电子邮件，并在每次遇到「颜色不好」的单词时增加一个计数器 (例如，喜剧演员乔治·卡林声称他不允许在电视上说的七个单词中的一个)。如果计数过高，则将电子邮件发送到垃圾邮件过滤器；否则，它将进入收件箱。多高就是太高？我们需要一个阈值，我们需要适当地设置它。太高，则不会过滤任何内容；太低，太多的邮件可能成为垃圾邮件。阈值是一个参数示例。

此示例将系统构建问题整齐地划分为两个单独的部分:

1. 确定系统将具有哪些参数以及它们将如何工作。在我们的垃圾邮件示例中，系统和色差词阈值参数的作用很容易解释。术语体系结构 (或模型体系结构，以避免与硬件体系结构混淆) 通常指关于模型将具有哪些参数的决策。例如，想象一个外观普通的黑盒子，上面有很多旋钮；盒的一侧有一个插槽用于输入，另一侧有一个插槽用于输出。该模型的「体系结构」指的是旋钮的数量、它们在盒子上的排列方式以及它们的设置如何影响盒子内部将输入转换为输出时发生的事情。

2. 设置参数值。这对应于确定盒子上每个旋钮的值。虽然我们可能对如何在垃圾邮件示例中设置参数有直觉，但最好的值可能是通过实验来确定的。

现在，我们将更详细地介绍 ML 的工作原理，并介绍一些组件，如果您关注 NLP 的开发，您可能会听到这些组件。

2.3.1 体系结构：神经网络

今天，绝大多数的体系结构是神经网络 (有时称为人工神经网络，以区别于生物网络)。就我们的目的而言，理解是什么使神经网络成为一种特殊的体系结构并不重要。然而，我们应该知道，它们的主要性质包括：(1) 大量的参数 (在本文中，数万亿) 和 (2) 是关于这些参数的可微函数：加、减、幂、三角函数等，以及它们的组合。关于神经网络结构 (但不是一个必要的或定义性的特性) 的一般观察结果是，它们的数值计算与模型的任务求解行为 (在其参数设置后) 之间的关系无法解释给人类观察者。这就是为什么它们与黑匣子的隐喻联系在一起 (黑匣子的内部组件无法被观察或容易理解)。4

2.3.2 选择所有参数的值：最小化损失函数

为了更好地工作，神经网络需要将其参数设置为有用的值 (即，在数学上将每个输入转换为接近输入正确答案的输出时，可以一起工作的值)。但是，当我们需要确定的参数太多时，我们如何选择参数的值呢？在本节中，我们将描述 NLP 中使用的一般策略。

想象一下你自己在下面 (不推荐) 的场景中。晚上，在没有 GPS 或光源的情况下，你会被扔到华盛顿州卡斯卡山脉的某个随机位置，并被指示寻找你能找到的最深的山谷 (而不只是等待早晨)。你移动你的脚来估计最陡的向下方向。你朝着这个方向小心地迈出一小步，然后重复，直到你看起来是在一个平坦的地方，那里似乎没有方向把你带向更深的地方。

我们所指的是微积分的概念。如果一个函数对于它所使用的一些数字是「可微的」，那么微积分使我们能够计算那些变量的微小变化将导致函数的最大变化。

9

机器学习将参数值的设置视为一个数值优化问题，多年来已被数学家、统计学家、工程师和计算机科学家广泛研究。机器学习的工具之一是一个自动程序，它将参数值设置问题框定为可怕的远足。回想一下，我们说过，神经网络的参数需要是可微的 — — 也就是说，它们需要被设置成允许微积分告诉我们，每个参数的微小变化将导致使用神经网络输出计算出的东西发生最剧烈的变化。在我们的夜间远足场景中，每一步，我们都会对我们的南北和东西坐标 (即地图上的位置) 进行微小的调整。为了调整我们神经网络的参数，我们将把我们当前的一组参数视为我们的「坐标」，同样地重复地对我们当前的坐标进行微小的调整。但是，在这种情况下，向下移动意味着什么呢？理想情况下，移动「向下」应该对应于我们的神经网络产生的输出更好地匹配我们的数据。我们如何定义一个功能我们的「景观」— — 这样才是真的？

损失函数的设计正是为了达到这样的目的：当神经网络性能更好时，损失函数越小。简言之，损失函数评估模型的输出与一组目标值 (我们的训练数据) 的相似程度，较高的「损失」表示两者之间的误差较大。正确输出与模型生产输出越不相似，损失值越高；如果它们匹配，则应返回零。这意味着理想情况下，损失函数应与我们的评估方法紧密一致。5

通过执行以下步骤，我们能够训练基于神经网络的模型:

1. 根据我们的培训输入和输出，我们使用损失函数定义模型夜间远足的景观，

2. 我们对每个坐标 (模型参数) 进行一个小的调整，以「向下」移动该景观，使其在模型输出和正确输出之

间更接近匹配，以及

3. 我们重复步骤 2，直到我们无法使模型的输出与正确的输出更加相似。

这种方法被称为 (随机) 梯度下降 (S G D)，因为微积分给我们每个参数的方向被称为「 梯度

撇开一些重要的细节 (例如，如何使用微积分有效地计算梯度，精确地计算何时停止，步骤 3 中参数值的精确更改量，以及使算法更稳定的一些技巧)，该方法在现代模型结构和前人中已被证明是选择参数值的有效方法。

2.3.3 硬件：图形处理单元 (GPU)

十多年来，图形处理单元 (GPU) 一直是基于神经网络训练 NLP 模型的主要硬件类型。这似乎有悖常理 (因为我们在这里处理的是语言，而不是图形)。然而，GPU 对于并行进行许多矩阵和向量计算是有效的，并且成功的神经网络结构使用这些并行计算来快速执行输入到输出映射 (因为随机梯度下降要求在训练期间执行多次映射)。事实上，人们认识到神经网络非常适合在 GPU 上训练，这对它们的广泛应用至关重要。

3 语言建模任务第节介绍了一些 NLP 概念和工具，包括将所需应用程序封装到「任务」中的思想、数据集的重要性，以及系统

如何学习使用数据执行任务的高级教程。在这里，我们转向语言建模，这是一项特定的任务。2 你可以把损失函数看作是严厉、保守的老师给学生的作业评分。学生 (我们要设置其参数的模型) 得到一个考试问题 (模型的输入) 并生成答案。老师机械地比较问题的

正确答案和学生的答案，然后报告错误扣了多少分。当学生得到完全正确的答案时，损失为零；未推导任何点。我们将在附录中讨论损失函数的一些附加数学细节。

10

3.1 为词预测语

语务义评简单质讲标预测单词输给单词输为「」「」们让

进单词现说「这语」—— 执语务应该实际应动变许

电邮处应动语语识译统组

话 OpenAI GPT 产「 」单词预测为对户语应

图 3 单词预测语测时间单词单词

样许预测单词说语预测为结构们语时识许规则说语语时间说语

动词们词饰义词们预测虑闲频

为项 NLP 务语检查们 2 节评讨论键 LMs 单词单词现们说「仅」时们们标签务级译务

译输输组为们总见论坛则问题见测试问题

为创对话还对议 LMs 评专业识劳动这术题们节 3.4

3.2 为们语

为们经语务们还释为这务值们为们费构预测单词经动统

这问题还

语处实认为语对评为说这

语临测连续「The dog Eat The」「时 a」为语们觉单词词词

样们语这语

11

为语务隐习规则这为 LMs 历为组纳 NLP 统译统过虑们预测较统

产畅输

们对 LMs 值实质发语还隐习识虑续「陆议这签」

「这时觉」这畅续说「1501」

「战发」「」「 欢觉」认为「1776」话续「」「 奋」

话续为这为运对历实识对应识这产这连续 LM 这

NLP 员 Petersetal. 2018 这观报说训练 LM 统为务构统阶给问题词实远远优 LM 过务质义这发现「预训练」执语

「调」预训练为执语务这终务

现训练时 LMs 问题为对务输输预训练 LM 该务现

3.3 语细

对们为语「」说联

为测连续经过 LM 须

额简单

载构评 LMs

闻书维

LMs 线论坛

员认为训语应纳则护语实间

们 6.2.1 节对进进讨论

过滤语 LM 务户优选过滤题击错误 LM

读动这义题们节们 64.4.1

术「词」对单词书统语语这问题对词间较书统汉词选择约

许竞语论

6 语标识给为语语问题构 NLP 务虑选择语识标签语练习语应该标签

语构须

经过细编辑专业惯 web

专业语

12

LMs 构语编语码义单词结应动创词汇语识单词

总单词义单词 Sennrich Haddow Birch 2016 简单总结为

·单词汇单词这 LM 处视为单

·现单词为词词汇应规则达标词汇

认

这驱动构语词汇 LM 训词词汇较见单词为词汇单词读单词

为见过请过计单词顺见该构词汇语语

则该语单词「 」为较长词汇单词单这证 LM 对该语

3.4 评 LMs

们过语务简单评们认为「」语

单词错误测单词时应该预测错误单词处「错误单词」测

试实际单词单词

7

LMs 错误评 LM 质

许单词

该值错误应该长对应设计说问题

预测

题 LM 实际

时实际该 LM 实际输经过处词汇单词换对词汇

0 1 间对该单词为输续

LM

给输

单词 LM

计 8

务义专业 / 动语历统

单词错误 LMs 错误 1 错误测对较们

LMs 评这问题这为认为 LM「惊」

过输预测过 LMs 实单词们问

应发员选择这处为单词论过样还过选择计单词评 LM 评 LM 给组测试

检查 LM LM

7 们录给单词错误 8 这

为观词进 LM 对词对应 LM 对

义

这总须为 1 实 LMs 总设为严 0

应时预测单词选项样错误为仅单词

13

9

实际续

评样测试说训练测试们对们规则对训练进测试们应该

1 这值记训练长

节问题

3.5 构语

虑 2 节们对语务绍构 LMs

1. 获训筛选终应质训为测试

2. 训词汇

3. 训练习训练杂

4. 评测试语杂测试评 LM 为 1

们检查测试训练 2 词汇设计许为单词

为损为对训练杂训练计计测试杂间

过构 GPT-2 GPT-3 LLaMA 这构较 ChatGPT GPT-4 这较进训练们单词预测

这「」获们节题 4.3.4 4 LMs 语 LLM

为们经时间长为语为众话题

LMs 长为计畅统产畅输 2020 LMs 产畅输说组过查传递应动观 LMs 头这样单词试动补选现单词这

3.2

9 对们浏览录义础实损对为熵

语见问题为们时「觉」实单词预测这训练标这实释这 LM 编码「实」过编码词倾时 LM 训练显实们「陆议这签」LM 为 1776 这实经时们

畅单词预测这实际实「 觉

「」时值虑这预测单词总这观 Shannon1951 们 1 实际

2 语认为语为现们 5

1011

14

议续变畅连贯进 web 产

语务础构语们现虑过术语转变为谓语 LLM

4.1

这历书 NLP 历显训训练质 1980 1990 该领发变时时趋势时现

1. 联维员获

2. 员义 NLP 务规则转赖统计这趋势现

语处驱动

3. 务变标许构统间进严实验较这趋

势进语处术资动这过给进带压

1990 2000 获训长务进题语

语语语间译务现获电线销评论产时较难获务长结构库语较语对译进较语务语处进语

对较语

认识构统这发热们觉项务获务值语闻

许报纸风为样简现们闻闻读经闻为

这样统们应该闻务础统总结论书务

项务简单务值虑对这

联们说联语们这访问这语络对 NLP 术们这驱动 NLP

项 NLP 们经评们 NLP 历发变这们详细绍这术组们

选择对 NLP 务训练质们经「规」词谈论训战 1993 员「 」Church

Mercer1993 们补计构执务统这

15

这项务论间实证们现变构变

4.2 构变压

NLP 绍结构们对优问题时认为

这构为 transformer 单构该构 Vaswani et al. 2017 1980

transformer 经络 Google 员为译务们详细绍

设计

经络发经过优许 GPU 时处

处结构为们 GPU

长输过

输输过拟

处

12

transformer / 训练

训练

员识

结构们说「」这 —

— 赖较编码训练训练这样样训练

结构时论训练结构习

计时进 NLP 计视觉实「习」词这较「」结构「层」层轮

计应语务转换「」导现谓「语」「」计训练

2022

训练运额结论杂这实验训练计费

NLP 亿 OpenAI GPT-3 1750 亿

GPT-2 10 亿 GPU 长时间这

运训练

过质观这 LLM

过

难评这

经训练变试图规规

结构

亿 Hoffmann

进

预变压构计训练费长时间这许测变压处

则

编码发现实选择

13

12 们

13 这为「过拟」现导「记」训练

测试现

16

须认识语扩亿结构驱动

计释这为

4.3 这变

LLM 简们语显这请尝试键头 ChatGPT 这样语该节头

简单动统读许过这样观验畅诸评这们贡硕进众识

4.3.1 许们

们许务评较现 3.23.214

们语间译为 NLP 应 LLM 给说 / 执这务「 」们这样虑「 译语们

」这样 LLM 请 / 应语

产译实 OpenAI ChatGPT 统给们「们标积还这电让发为执」导 ChatGPT 输绪

这转员 NLP 训为务构专们语说们 LLM 们预输们专专现为许 LLM 许为 NLP 务 LLM

4.3.2

现变压认为「」钮们识觉设钮这让钮驾驶舱

经训练驾驶飞样实为计计们这问题这让们对经觉

14 为「习」经获务调 LMs 务说这调为业 LM 产训阶请该 LM 应给应

务现简为语

们认为对

们节讨论许预训练调

LMs 为务设计 NLP 统 LLM 许还执务输输

这趋势

过为 LLM

语调记务义评值语达较时

语务选择

问题输

务

节

单词为连续时

术转务 LLM 为惊针对务进

17

变压结构设

习问题对应惊讶

这样们对进这 transformer 这样结构难

该础对

变压结构历这输输

4.3.4 调 LLM 产

训练变压经络经

张图纸维标值这损

现战

说

损损

盘简单线对应

较时联「 」web 问题

现

对 LLM 发员说这访问们维护

训发挥

专们发优势

论证

值 SGD 们 2.3.2 节讨论级联 SGD 实

员试图证员进实验试图实

东显进们对该结构义设计结构

4.3.3 杂现谁发这

转 LLM 规组织产资术

获专对 LLM 进训这 LLM

这对构许员构进虑这

们为这设许们语样扩 LLM 发

这许发员寻们产务软师编码师编这长 LMs 业产应导

译统输语畅 LLM 获们测试显这产还进额调

们 5 节 LLM 现为问题现虑 LLM 畅秽这执惯许

难题处输筛选 dispreferred 单词输对样输进该辅专针对选进训练显

难问题为赖语观

诺·维纳 NorbertWiener「对齐」这经这问题「 构达们们预运

辅「务」

们

18

对问题动终

们们 」维纳 1960 这过习变 LM 为

实业务进训练这务们节们积应为杂·纳逊 Alondra Nelson

FACT2023 议讲「亿 ...... 选择长为值观则奋战论辩论」纳逊 2023 换话说仅输给组值难问题组值该组值杂问题

们倾 LLM 为调视为统「值」编码训样这 4.3.115

4.3.5 缓

题

LLM 训联创输户创弹让们计险为这构「」谈这们户现这产风险试图这问

这 LLM 产调题过处问题处过滤输这「对齐」过

为险们还恶

还显对户应疗议应议户寻专业议输证疗识伤 LLM 为镜户为

护实们实现过严绝实际实谨发员责满

户间紧张

4.3.6 评

LLM 带奋进变训练们变

畅 2.1 节 NLP 员长严测统务这

员现评统实证评

这

怀态

为这务获们 NLP 术们认为对 LLM 产户对 LLM 这

LLM 应 NLP

设项务趋势对较转节

应长务这务过对 NLP

总趋势 4.3.1

构们标评务处这义

15「馈习」顾义这习「样输 a 优样输 B」转为应调

19

·动评务彻续虑实际户

·观实户 LLM 对 LLM 为质馈对续进 LLM 质·户样变评战·「进」报视为值质许单测试

务评义传达为统优

们这战发员户间义评过扩义满们构现实发

4.4 训练

训练们给 LLM 训练对联们该该「」语

续语训练对该续预测

5.1 节们讨论选择义测试试导 ChatGPT

16

识

动计项 X 针对 Y XY 对

语讲问题应这 ChatGPT 这样训练为远远组

说语语问题译语问

语调样这训论联问题

产语较这训较

4.4.1 LLMs 训

亿规读语库

样样费长时间们计阅读间发

动侧顶级 Reddit.com Wikipedia.org web 专闻见 Dodge 2021 这变

为员须发这变实现

们认

许训 LLM 隐这视为业对变构实们训练

这员为论还 16 们语们仅仅还

20

许多研究人员对隐藏的训练数据集有一个特别的关注：假设一个模型被提示了一个似乎特别难以回答的问题，并且它像专家一样准确而清晰地回答了这个问题。只有当我们确信问题和答案不在培训数据中时，我们才会印象深刻。如果我们不能检查训练数据，我们就不能确定模型是否真的被公平地测试，或者它是否在测试前记住了答案键，就像我们的学生在第 2.2 节中所说的那样。

4.4.2 关于数据质量的注意事项

人们很容易将在培训过程中包含某些数据 (如错误信息或仇恨言论) 的负面后果归结为「数据质量」问题，并倡导使用「垃圾输入，垃圾输出」原则获得「更好」的数据。然而，通常采取看似合理的步骤来自动过滤 web 文本的「质量」，可能会产生意想不到的效果，即过度呈现文本，类似于编写更富有或受教育程度更高的群体的特征 (Gururangan et al.2022)。此外，这些过滤器定义的质量概念与其他手动确定的文本质量方面 (如赢得普利策奖或说实话) 不一致。

确定什么是「更好的」培训数据，以及如何在规模上实现这种感觉，是一个价值观和规范的主观问题。因此，我们预测并希望未来的研究能够更好地为不同的用户社区或应用程序定制语言模型的数据，而不是假设一个普遍的「质量」概念，一个大型模型最终将是所有人想要的最佳解决方案。

5 使用语言模型的实践要点

到目前为止，我们已经讨论了语言模型是如何产生的，以及它们是如何被训练的。但是，如果你是一个阅读本指南的人，那么你可能也会想知道这些模型在你认为他们应该做的事情上有多好。(如果你是一个语言模型，在本指南的培训前，请继续。)

正如我们在第 4.3.6 节中了解到的，NLP 研究人员用于评估模型的工具测试的能力与部署产品的许多用户感兴趣的能力不同。描述 LMs 可以做什么，以及这些能力如何与构建时所做的选择相关，值得继续进行科学探索。然而，早期迹象表明，LMs 至少可以成为加速许多以前难以自动化的用户任务的有用工具。所以，如果你想知道这些模型是否能在某些特定的事情上对你有所帮助，比如说，计划去日本旅行，那么值得一试！

本节回答了您在试用或考虑近期内可能遇到的一般问题。我们的回答是将主要的对话 (现在发生在研究语言模型的科学团体中) 提炼成你应该知道的实际要点以及这些要点背后的推理。

5.1 向 LM 提供的「提示」的具体措辞是否重要？

简言之，是的。第 4.4 节对此进行了暗示，但更明确地说：您向 LM 提供的提示的特定措辞会显著影响您收到的模型输出。这可能意味着您需要尝试使用一些不同的词语来指示模型执行某些操作。提示模型时，如果您的输入和正确的输出接近模型在其训练数据中遇到的示例文本，则模型应该很好地「响应」(即，通过预测下一个单词的序列来继续提示)。尝试不同的提示措辞意味着您在模型所学语言的模式之间撒下了更广的网，并给自己更好的机会遇到模型更容易继续的模式。

要测试这一点，请尝试用几种非常不同的方式重新表述您希望 LM 执行的操作。然后，尝试将这些提示分别提供给 ChatGPT 之类的模型。你很可能会在你得到的不同结果中看到一些显著的差异！

21

5.2 我是否总是必须检查和验证模型输出，还是可以简单地「相信」结果？乍一看，一个生成可信模型输出的提示似乎意味着已经没有什么事情可以做了。但是，您永远不应该按照表

面的价值来获取模型输出。始终检查以下重要问题。

5.2.1 真实与「幻觉

在撰写本文时 (可能在可预见的未来)，L M s 努力做到「讲真话」，即产生正确的输出 。事实上 ，L M s 的一个经常被讨论的特性是它们容易产生不精确和不真实的信息。这种现象被称为「幻觉」。幻觉有多重要很大程度上取决于模型用户的任务和语言类型。对于一个有创造力的作家来说，语言模型在呈现虚构信息方面的灵活性可能是其最大的优势之一。对于需要医学文章的准确摘要或试图使用 LM 从法庭证词中检索事实陈述的人，它可能使模型无法使用，至少在没有仔细的事后即时事实检查的情况下。17

为什么模特会产生幻觉？虽然模型在很大程度上依赖于它们的训练数据，但它们不能准确地访问这些数据。相反，它们似乎对数据中的模式进行编码，但并不总是准确地「记住」数据。因此，对于支持性数据丰富且任务简单的主题，幻觉的可能性通常较低。在讨论较少的问题上，有了更复杂的任务，幻觉就不那么令人惊讶了。即使有大量的数据，如果训练数据经常包含错误信息的陈述 (例如，不正确但被广泛讨论的疫苗导致孤独症的说法)，模型也可能编码 (作为一种模式) 不正确的声明。目前正在进行积极的研究，以阻止模型陈述错误的信息，并引导它们对事实可能存在争议的问题做出听起来自信的答案 (或任何答案)，但这仍然是一个非常困难的公开问题。

与此相关的是，目前还没有直接的、计算上可行的方法将特定的预测或生成的文本链接回特定的培训文档或段落。因此，另一个正在进行的研究挑战是赋予 LMs「引用其来源」的能力，也就是说，不仅要像学者们被教导做的那样，生成对相关文献或来源的明确而准确的引用，而且要在需要时揭示影响特定下一个单词预测的特定文本。

2023 年初，两名美国律师利用 ChatGPT 为针对一家航空公司的人身伤害诉讼准备文件时，这些能力缺失的一个值得注意的现实例子浮出水面。虽然主要文本非常流畅，但该模型完全幻觉了它引用为判例的案件及其相应的法官、原告和被告。法院在收到该航空公司律师对所援引案件的存在提出质疑的简报时注意到了这一点。这些案件都不是真实的，律师们也没有透露他们使用 ChatGPT 进行法律研究。该案的联邦法官非常愤怒，并对两名律师处以罚款。在随后的听证会上，这两名律师将责任归咎于 ChatGPT，称他们「不明白这不是一个搜索引擎，而是一个生成性语言处理工具

既然 LM 幻觉已经进入司法系统，我们可以希望用户 (以及模型构建者，在这种情况下的「有钱人」) 已经吸取了教训。LMs 不是搜索引擎，它们的输出需要仔细检查，至少目前是这样。

记住：语言模型不能完美地捕获它们的训练数据！

5.2.2 反映社会偏见的模型输出评估和修改模型输出的另一个方面是检查模型对可能出现在其训练数据中的社会偏见的不假思索的模仿，其

中人类的判断是关键。

NLP 研究人员经常提到我们训练模型执行的理想化任务的名称 — —「仇恨语音检测」、「机器翻译」、「语言建

模」— — 但记住模型是如何学习

17 有些人认为「幻觉」一词具有误导性，使语言模型拟人化，但在本文中，它是 NLP 研究人员使用最广泛的一个词。

22

执行一项任务会受到用于训练它的特定数据的严重影响 (这与我们之前在第 2.1 节中讨论的抽象的、有抱负的任务概念和具体的、可行的任务概念之间的权衡有关)，「仇恨语音检测」模型实际上经过培训，以执行「HateXplain 数据集示例中的仇恨语音检测」或「IberEval 2018 数据集示例中的仇恨语音检测」。这些数据集反映了建设者对特定语言类型的关注，例如，西班牙语新闻文章或美国青少年的社交媒体帖子，但没有数据集完美地表示它要表示的语言类型。可能的话语实在太多了！因此，尽管正在努力提高模型从训练期间观察到的数据进行概括的能力，但模型仍有可能学习到由训练数据的怪癖通知的任务版本。因为有这么多可能的「怪癖」，所以可以肯定的是，一个模型已经学会了其中的一些怪癖。事实上，我们已经在 NLP 系统中多次观察到这种情况。

更具体地说，让我们看看过去的一些工作，发现偏见可追溯到仇恨语音检测系统中的训练数据。Sap et al. (2019) 发现，在两个单独的仇恨言语检测数据集中，使用非裔美国方言英语 (AAVE) 编写的推文比用于检测毒性的人类使用白色对齐英语编写的推文更可能被标记为有毒。不仅如此，在这些数据集上训练的模型更可能错误地将无害的 AAVE 语言标记为有毒，而不是错误地将无害的推文标记为白色对齐的英语。这让我们了解了数据集偏差如何传播到文本分类系统中的模型，但在模型生成文本的情况下又如何呢？如果模型没有将文本与任何人类指定的毒性标签相关联，如何证明存在偏差？

事实证明，即使在模型没有为一段文本生成单个预定义类别的情况下，偏见的证据仍然可见。Google Translate 的一个著名的早期工作例子显示了这一点，该研究基于美国劳工统计局发布的各种职业的性别比例 (Prates、Avelar 和 Lamb 2019)。作者评估了从不使用性别单数代词的各种语言翻译成英语的机器翻译系统，构建诸如「[中性代词] 是工程师」这样的句子并将其翻译成英语。他们发现，这些系统显示出对翻译成「他」的偏好，这往往远远超出了美国某一职业中男性人数多于女性的实际程度。这种偏见可能反映了将男性和女性与这些不同职业联系在一起的训练句子数量的不平衡，指示任务的训练数据中的倾斜可以影响模型的另一种方式。

像这样的失衡就是我们前面提到的那些「怪癖」的例子，它们可能令人费解。有些怪癖，比如数据中提到的男性政治家比女性政治家多得多，似乎源自这两类人在现实世界中的普遍存在。其他怪癖起初似乎与常识相悖：虽然「黑羊」在世界上并不普遍，「黑羊」在英语文本中比其他有色人种的羊更常被提及，可能是因为它们更令人惊讶 ，更值得一提 (或者可能是因为一个常见的成语「 家庭的黑羊」使用了这个短语 )。

与机器翻译系统中可能出现的偏差一样，LMs 在生成文本时也会表现出偏差。虽然目前的 LMs 在很大一部分互联网上接受培训，但互联网上的文本仍然可能表现出偏见，这些偏见可能是虚假的和纯粹偶然的，或者可能与各种潜在因素有关：文化、社会、种族、年龄、性别、政治等。如果不检查这些偏见，与部署真实世界系统相关的风险很快就会显现出来。私人和政府组织已经部署了机器学习系统，以实现高风险决策的自动化，如雇佣和确定假释资格，这些决策已显示出基于此类因素的歧视 (Raghavan 等人，2020 年；Nishi 2019 年)。

那么，研究人员究竟如何才能防止模型显示出这些偏见并产生这些影响呢？这还不是一个已解决的问题，一些 NLP 研究人员会争辩说，这些技术不应该用于这些类型的系统，至少在有可靠的解决方案之前是这样。对于部署用于一般用途的 LMs，正在研究如何使模型不太可能出现某些已知形式的偏差 (例如，见第 4.3.4 节)。此类研究的进展取决于对数据和评估的迭代改进，这些改进和评估使研究人员能够定量和重复地测量我们想要消除的各种形式的偏差。

记住：数据集和评估永远不会完美地捕获理想的任务！

23

5.3 语言模型智能吗？

语言模型产品的出现引发了许多讨论，包括一些人质疑这些模型是否可能代表一种「智能」。特别是，一些人质疑我们是否已经开始开发「人工通用智能」(AGI)。这个想法意味着比用语言完成任务的能力要大得多的东西。这些讨论对这些模型的潜在用户意味着什么？

我们认为，这些讨论在很大程度上与实际关切分开。到目前为止，在本文档中，我们主要选择使用术语「自然语言处理」而不是「人工智能」。在某种程度上，我们选择此选项是为了专门围绕语言技术展开讨论。然而，随着语言模型产品越来越多地与其他类型数据 (例如图像、编程语言代码等) 的模型结合使用，并被允许访问外部软件系统 (例如 web 搜索)，语言模型的用途显然不仅仅是生成流畅的文本。事实上，关于这些系统的许多讨论倾向于将它们称为 AI 的示例 (或者将单个系统称为「AIs」)。

AI」一词的难点在于缺乏明确的定义。最无可争议的是，它的功能是描述几个不同的社区，这些社区研究或开发的系统在某种意义上是「智能化」的。正是我们所认为的系统智能化行为随着社会对技术的熟悉而改变。早期计算机的算术运算速度比人类快，但它们「智能」吗？「智能」手机上的应用程序 (在最好的情况下) 对那些拥有这些功能的人来说，似乎不像对第一代用户那样「智能」。

但是这个术语还有一个更深层次的问题，那就是「智力」本身的概念。我们认为「智能」的人类能力是否与现有或假设的「AI」系统的能力相关？人类能力和行为的变化，通常用来解释我们对人类智能的概念，可能与我们在机器智能中看到的变化有很大的不同。心理学家 Alison Gopnik 在其 2023 年 ACL (主要 NLP 研究会议之一) 上的主旨演讲中指出，在认知科学中，人们普遍认为「没有自然或人工的一般智能」，而是有许多不同的能力，不能全部通过单个代理最大限度地获得 (Gopnik 2023)。

在同一个主题演讲中，Gopnik 还提到，在她的框架中，「文化技术」如语言模型、写作或图书馆可能对一个社会产生影响，但正是人们学会使用这些技术才使其产生影响，而不是技术本身固有的「智能」。我们认为，这一区别与另一个计算研究领域 — — 人机交互 — — 的长期争论相呼应。在那里，争论围绕着「智能增强」工具的开发展开，人类直接操纵并深刻理解这些工具，仍然对自己的行为负完全责任，而不是将任务委托给代理人 (Shneiderman 和 Maes，1997)。

尽管学者之间存在争议，但一些公司如 OpenAI 和 Anthropic 表示，开发 AGI 是他们的最终目标。我们首先建议您认识到「AGI」不是一个定义明确的科学概念；例如，对于系统是否达到 AGI，没有一致同意的测试。因此，这个术语应该被理解为一种营销手段，类似于说洗涤剂让衣服闻起来「新鲜」，或者说汽车「豪华」。其次，我们建议您使用 NLP 研究人员为此目的开发的工具来评估关于模型特定能力的更具体的说法。您不应期望任何产品「按您的要求做任何事情」，并且清楚地证明它具有一种功能的证据永远不应被视为它具有不同或更广泛的功能的证据。第三，我们强调 AGI 不是所有 AI 系统研究者或开发人员的明确或隐含目标。事实上，有些人对增强人类能力的工具比那些具有可与人类相比的能力的自主代理更为兴奋。

我们以观察结束。直到最近出现了以「人工智能」为名的工具之前，我们对智能的体验主要是与其他人进行的，他们的智能是我们认为理所当然的各种能力的集合。语言模型至少具有语言流畅性：它们生成的文本往往自然而然地遵循它们的提示，也许与人类没有明显区别。但是 LMs 没有我们与人类联系起来的全部智能。在语言模式方面，流利性，

24

例如，似乎已经从我们在彼此身上找到的其他智能束中分离出来。我们应该期待这一现象是相当令人震惊的，因为我们以前从未见过！事实上，围绕 LMs 和当前 AI 系统的许多激烈争论通常都集中在这种「不捆绑」的智能上。系统是否智能化？他们比人类聪明吗？他们和人类一样聪明吗？如果这些行为在某些方面与人类行为无法区分，那么它们的获得方式或执行方式是否与人类的不同有关系？

我们怀疑这些问题会让哲学家们在未来的一段时间里忙个不停。对于大多数直接使用这些模型或在日常生活中使用它们的人来说，还有更紧迫的问题要问。我希望语言模型做什么？我不希望它做什么？它在做我想做的事情方面有多成功，当它失败或侵入被禁止的行为时，我有多容易发现？我们希望，我们的讨论有助于你自己设计这些问题的答案。

6 语言模型的发展走向何方？

语言模式 (以及它们在社会中扮演的角色) 仍处于婴儿期，现在说它们将如何继续发展以及它们将随着时间的推移而演变的主要方式还为时过早。目前，正如我们所提到的，大多数语言模型 (以及更普遍的生成性人工智能模型) 都是由少数几家公司开发的，这些公司对它们的构建并不十分热心。然而，重要的是要记住，取决于未来几年的各种因素，由非营利实体管理的更加分散的模型的未来仍然是可能的。

在决定未来的过程中，一个仍在形成的关键变量是由民主进程控制的：以政策和法律形式的政府监管。这意味着公众 (您的注意力) 对这些模型相关问题的关注可能会直接影响技术的未来。现在，我们讨论了在预测语言模型开发的未来方面困难的原因，以及到目前为止对这些模型的早期调控所起的作用。

6.1 为什么很难预测 NLP 技术的未来？

从长远来看，让我们考虑过去十年中 NLP 领域发生的两次转变。第一种是在 2010 年代早期，从统计方法 (每个参数在概率模型中扮演特定的、可理解的 (专家) 角色) 转变为神经网络，在神经网络中，通过梯度下降学习没有相应解释的参数块。第二个转变发生在 2018 年至 2019 年，即我们在第 4.2 节中描述的变压器架构的普遍采用，该架构主要取代了 NLP 中流行的过去神经网络架构，以及语言模型预训练的兴起 (如第 3.2 节所述)。

该领域的大多数人都没有预料到这些变化，他们都面临着怀疑。在 2000 年代，神经网络在很大程度上仍然是 NLP 边缘的一个想法，尚未证明其实际用途；此外，在引入变压器之前，另一种非常不同的神经网络结构在 NLP 研究中普遍存在，关于替换它的讨论相对较少。事实上，对于 NLP 的长期观察者来说，少数几个看似确定的事实之一是，该领域每几年都会发生重大变化，无论是研究的问题、使用的资源、，或开发模型的策略。这种转变的形式并不一定遵循前几年该领域的主导主题，这使得它更具「革命性」而非「进化性」。而且，随着越来越多的研究人员进入 NLP，以及越来越多的不同群体合作考虑下一步重点关注哪些方法或应用，预测这些变化的方向变得更加令人畏惧。18

在考虑 NLP 技术对现实世界的长期影响时，也存在类似的困难。即使撇开我们不知道 NLP 技术将如何发展，也要确定一种特定的技术将如何发展

它被称为 LSTM，「长 - 短记忆」网络。

记住：与人的能力的类比永远不会完美地捕获语言模型的能力，并且显式地测试模型以获得用例所需的任何

特定能力是很重要的！

25

将被使用提出了一个困难的社会问题。此外，NLP 系统在商业应用中得到了更广泛的部署；这意味着模型开发人员从更广泛的用户那里获得了更多的反馈，但我们还不知道部署和公众关注对该领域的影响。

记住这些模型是如何在一个基本的层次上工作的，使用前面的上下文来预测下一个文本，逐字逐句，基于最有效的方法来模拟培训期间观察到的演示，并想象文本模拟最适合的用例类型，这将有助于我们所有人扎根并理解新的发展。

6.2 人工智能监管会是什么样子？

关于语言模型未来的一个重要讨论围绕这些模型的可能规则展开。本主题包含许多相关讨论：公司的自我监管、第三方对模型的审计、对私营公司 (如 Reddit 最近制定的公司) 数据收集的限制以及潜在的政府监督。考虑到生产这些模型的公司必须已经决定如何调整其模型的行为，最现实的做法似乎不是考虑是否会发生某一方的监管，而是考虑哪些形式的监管将是有益的。我们将首先描述监管人工智能的一些早期尝试，然后假设未来监管的重点。

在这样做之前，我们再提出一点。值得注意的是，在公共领域，支持或反对监管的呼声可能出于各种不同的原因。例如，正如《纽约时报》的 Kevin Roose 所说，「一些怀疑论者认为人工智能实验室出于自身利益而煽动恐惧，或者夸大人工智能的破坏性潜力，以此作为他们自己产品的一种后门营销策略。(毕竟，谁不会被诱惑使用一个强大到足以消灭人类的聊天机器人呢？)」，对人工智能监管的讨论可能会变得充满政治色彩，并利用社会价值观的许多复杂变化。因此，与参加任何公开讨论时一样，养成这样一种习惯是很有帮助的：考虑到某个特定的人的背景和兴趣，以及他们希望自己的评论会影响到谁，他们为什么会说出他们所说的话。最近已写入 19

6.2.1 什么版本的政府人工智能监管正在出现？就已经进入公共政策领域的具体监管而言，美国总统拜登 (Joe Biden) 和欧盟 (EU) 的监管措施是迄今为止

与人工智能相关的最全面的监管措施。行政人员订单号在人工智能 2023 人工智能行动

2023 年 10 月底颁布的《人工智能行政命令》确立了人工智能创新的一般原则。这些都是高层次的，主要集中在人工智能风险和安全管理、促进负责任的人工智能创新和竞争以及随着人工智能的不断发展保护个人及其公民自由。该命令的另一个重点是在美国和美国政府收集人工智能人才。虽然这些要点侧重于 AI 的推广，但订单中还包括一个所需计算能力的阈值，即模型可用于「恶意网络激活活动」。也就是说，如果超出了模型培训中使用的特定数量的浮点操作，则该模型的某些使用可能会被视为风险。这一定义反映了将高层次的「模型风险」概念转化为低层次术语的困难；随着计算能力的不断提高，这个定义很可能会有进一步的迭代。

《欧盟人工智能法》的重点是根据不同人工智能系统的拟议和可能的使用案例，确定不同人工智能系统对人类个体构成的风险水平，以确定高风险技术并限制其使用。AI 法案的细节也相当高，最终大部分法案被 ChatGPT 的突然广泛使用所颠覆。《人工智能法》是关于人工智能监管应在多大程度上影响不同系统的政治辩论的一块磁石，其立场受到各种关注的影响，如促进对科学创新的支持或维护受示范决策影响者的权利。欧盟 AI 法案的颠覆表明无论未来的监管如何

19 参见 Bruce Schneier 和 Nathan Sanders。这意见文章

26

发布可能不会在某个时间点进行监管，因为我们已经在某些方面看到了有关人工智能的行政命令。考虑到当前 (以及可能的未来) 的技术发展速度，任何不关注更广泛概念 (如减少伤害和安全使用案例) 的监管都有可能很快过时。

在更接近人工智能系统的实施和培训的较低层次上，迄今为止的法律重点主要是与模型培训数据相关的版权。A 为生成型人工智能模型提供了广泛的空间，以便对受版权保护的材料进行培训，前提是培训的「目的不是让自己享受作品中表达的想法或情感，也不是让他人享受作品」。然而，最近更多的法院案例侧重于生成型图像模型，如 or，正在推翻这一观点，尚未达成解决方案。2018 年日本修正案 1970 版权法盖蒂图像起诉稳定性 AI 公司。一群艺术家起诉 Stability AI、MidTraveley 和 DeviantArt

即使是这些早期对人工智能系统与版权保护交叉点的尝试，其倾向也各不相同，这表明就人工智能问题进行全面立法是多么困难。(事实上，日本《版权法》已经提出了进一步的修正案，考虑限制 2018 年修正案的适用。) 到目前为止，我们还没有看到太多的法院案例关注文本的生成模式。也许最接近的案例是关于计算机编程语言代码的一个法庭案例，即，该案例侧重于这样一个事实：GitHub 网站上的许多公共代码存储库 (从中提取了培训数据) 都带有在培训期间从数据中剥离的许可证。鉴于这类法庭案件侧重于培训数据，一个尚未回答的问题是，此类法律案件将如何影响公司未来对其模型培训数据的公开程度。正如我们所讨论的，训练数据越不透明，我们理解模型的希望就越小。Doe 1 诉 Github，Inc。

6.3 如何为健康的 AI 环境做出贡献？有很多重要的行动，帮助我们朝着一个 AI 系统以有益的方式开发的未来前进。我们将在这里列出一些。

·如果你是一个对人工智能系统感兴趣的学生：你可以成为帮助决定这些模型如何工作的人之一。对于这个职位上的任何人来说，你会发现学习计算机、数学、统计学，以及与社会相关的领域是很有用的。毕竟，我们构建这些系统是为了做什么，这个问题与我们构建这些系统是为了做什么一样值得关注。

·如果你是人工智能以外的专家 (例如，医疗保健、科学或人文领域): 构建这些模型的人真的可以从你的专业知识中受益。确定如何适应人工智能系统，以安全地协助专家所面临的问题是不是计算机科学家可以单独做的事情。为了使这些类型的模型对您和您的领域有用 (并避免试图解决不需要解决的问题)，模型开发人员需要您的输入和帮助。随着越来越多的科学家和工程师进入不断增长的人工智能领域，在您的网络中找到正在研究模型的人应该会变得更容易。与他们接触！

·如果您在业务领域做出决策：您可以为评估可能基于 AI 的公司工作流中的系统。这些系统中有相当多的浮华语言。通过忽略这一点，而是与开发人员讨论如何测试特定系统，测试与预期用例的关联程度，以及这些测试中缺少什么，您可以帮助提高评估 AI 的总体标准。

·如果你是一个关心的消费者：对 LMs 和 AI 新闻保持深思熟虑的、反思性的距离对你来说是一个巨大的帮助。近几个月来，这些话题似乎一直在讨论，而且肯定会有更多的讨论。本文档的最大目标是帮助您掌握所需的知识，以过滤炒作并理解实质内容。

7 最后备注当前的语言模型完全令人困惑。但是，通过记住产生这些模型的研究社区的趋势，我们可以了解这些模型为什

么会有这样的行为。记住这些模型训练完成的主要任务，即下一个单词的预测，也有助于我们

27

了解它们是如何工作的。关于这些模型还有许多悬而未决的问题，但我们希望我们已经提供了一些关于如何使用和评估它们的有用指导。尽管很难确定这些技术将如何继续发展，但我们每个人都可以采取一些有益的行动来推动这一发展朝着积极的方向发展。通过扩大参与模型开发决策的人数和类型，并参与有关 LMs 和 AI 在社会中的作用的更广泛对话，我们都可以帮助将 AI 系统塑造成一股积极的力量。

确认书

作者感谢 Sandy Kaplan、Lauren Bricker、Nicole Decaro 和 Cass Hodges 在该项目不同阶段的反馈，该项目得到了 NSF 赠款 2113530 的部分支持。所有的观点和错误都是作者的。

词汇表

算法：以预定义的、精确指定的方式对一组输入进行操作以产生一组输出的过程。算法可以翻译成计算机程序。本文参考了几种不同的算法：(1) 随机梯度下降法，它以一个 (神经网络) 模型结构、一个数据集和其他设置作为输入，并产生一个模型作为输出；(2) 模型本身，将指定的文本作为输入，并为模型训练要执行的任务生成输出 (例如，对于情感分类模型，表示不同类型态度的概率分布，或者对于语言模型，表示下一个单词的概率分布);(3) 构造语言模型词汇表的算法 (第 3.3 节)。

对齐 (模型与人类偏好的对齐): 该术语可以指模型反映人类偏好的程度，也可以指调整模型以更好地反映人类偏好的过程。见第 4.3.4 节。

体系结构 (模型): 用于排列模型参数并指定如何联合使用这些参数 (与输入一起) 来生成模型输出的模板。请注意，指定模型体系结构并不涉及指定单独参数的值，这些值将在后面定义。(如果您认为一个模型是一个「黑匣子」，在它的一侧有一个旋钮，该旋钮被赋予一个输入并产生一个输出，那么模型的「架构」是指旋钮在盒子上 / 盒子内部的排列，而不包括每个旋钮设置的特定值。)

人工智能 (AI):(1) 广泛地描述了几个领域或研究团体，这些领域或研究团体致力于提高机器将有关世界的复杂信息源 (如图像或文本) 处理为预测、分析或其他人类有用输出的能力。(2) 在流行用法中 (但不是本指南) 也指使用在这些领域中开发的技术 (如深蓝或 ChatGPT) 构建的单个系统 (可能是模型)。

Bleu 评分：Papineni et al.(2002) 提出的一种全自动方法，用于评估拟将文本翻译成目标语言的质量。在高水平上，通过查看提议翻译的小语块 (例如，一个词语块、两个词语块等) 的哪一部分出现在至少一个引用翻译中，来计算提议翻译的 Bleu 分数 (关于同一文本的一组经批准的引用翻译)。

计算机视觉 (CV): 计算机科学研究的一个分支，它促进从视觉信号 (图像) 中自动处理和产生信息。内容保障：NLP 中常用的一个术语，指的是试图阻止语言模型生成攻击性、有害性、危险性等输出的策略。

我们在第 4.3.5 节中给出了这些策略的一些示例。

收敛性：机器学习中的一个概念，它解释了当模型的输出和数据的预期输出之间的损失小于某个阈值时。训练过程中的模型收敛通常意味着

28

模型不再改善，如 SGD 结束时发生的情况。

数据：与任务相关的样本输入及其期望输出对，用于训练或评估模型。对于 NLP，这通常是一个大量的文本集合，这些文本来源于数字形式 (例如，从发布到互联网论坛的帖子中刮取的文本) 或转换为数字格式 (例如，从扫描的手写文档中提取的文本)。它还可以包括描述文本的附加信息，例如用于情感分析数据集的情感标签。

数据驱动的：一个过程的描述，表明它基于对海量数据存储的分析来确定操作 (与由一个人或多个人做出所有这些决定相反)。例如，决定要构建的语言模型的词汇表的人员可以 (1) 手动定义模型词汇表将包含的所有单词或部分单词的列表 (非数据驱动的) 或 (2) 收集文本数据并运行数据驱动算法 (参见第 3.3 节) 以基于最终模型的数据集自动生成词汇表。一般来说，机器学习算法是数据驱动的。

深度学习：一个描述机器学习方法的术语，该方法侧重于多层次的训练 (神经网络) 模型。

深度 (模型): 指神经网络结构包含的层数。

域 (数据): 特定数据的特定直观 (尽管没有正式定义) 分组。例如，NLP 研究人员可能引用文本数据的「Wikipedia 域」或文本数据的「business email 域」。该术语为研究人员或从业者提供了一种方便的方式，以指代通常具有某些统一特征或不同于某些其他数据的特征的数据。

(模型的) 外部评估：评估 (模型的) 评估，评估使用该模型作为更大系统的一部分是否有助于该系统 (以及有多大)，或考虑与模型在实践中的最终使用相关的因素等。

微调 (针对特定任务的模型): 在对其他任务 / 数据集的原始参数值进行训练后，在所选的新数据集上继续训练模型。使用术语「FineTunning」表示将要进行微调的模型已经在某个任务 / 数据集上进行了培训。

功能：广义上是输入到输出的映射。换句话说，函数将任何与特定描述匹配的输入 (如「数字」或「文本」) 作为输入，并将给出 (一致的) 该输入对应输出的答案。然而，在本文档中使用「函数」一词的地方 (除了「自动完成函数」的上下文)，我们更具体地指接受一组数字并生成单个数字输出的函数。

生成型人工智能：人工智能的一个子集，专注于学习模拟 (因此可以自动生成 / 生成) 复杂形式的数据 (如文本或图像) 的模型。

梯度 (函数): 微积分的概念。给定 n 维景观中的特定点，函数的梯度指示该函数从该点最陡上升的方向 (和幅度)。通过将神经网络模型的当前参数视为该 n 维景观中的点，并考虑损失函数相对于这些参数的梯度，可以确定每个参数的微小变化，从而尽可能局部地增加损失函数。这也表明相反的小变化可以尽可能地减少损失函数，这是运行 SGD 时的目标。

幻觉 (通过语言模型): 通常用于描述语言模型产生的输出中的非真实或错误语句的术语。

硬件：运行算法的 (物理) 机器。对于当代 NLP，这些通常是 GPU (图形处理单元)，最初设计用于快速绘制计算机图形，但后来用于对通常由神经网络执行的基于矩阵的操作执行相同的操作。

内在评估 (一个模型): 评估 (一个模型) 在一个特定的测试集上评估该模型「在真空中」，也就是说，不考虑将该模型插入一个更大的系统将如何帮助那个更大的系统。

29

标签：有些任务的输出是一组相对较小的固定类别 (与语言建模不同，在语言建模中，输出是一些通常非常庞大的词汇表中的一个标记)。如果输出是由这种小集合决定的，NLP 研究人员通常将特定输入的正确输出称为该输入的「标签」。例如，电子邮件垃圾邮件识别任务的标签集将是「垃圾邮件」或「非垃圾邮件」，情绪分析任务可能会将其可能的标签集定义为「积极」、「消极」或「中性

语言模型：一种以文本为输入的模型，它产生一个概率分布，在它的词汇表中，哪个词可能出现在下一个词上。见第 3 节。

层 (基于神经网络的模型): 具有可学习的神经网络参数的子模块，该子模块将数据的数值表示作为输入，并输出数据的数值表示。现代神经网络趋向于深度，这意味着它们「堆叠」许多层，以便将一层的输出馈送到另一层，然后将另一层的输出馈送到另一层，依此类推。

损失函数：一种数学函数，它接受给定特定输入的模型的建议输出，并将其与 (至少) 一个参考输出进行比较，以确定输出应该是什么。根据参考输出与模型的建议输出的相似程度，损失函数将返回一个称为「损失」的数字。损失越大，模型的建议输出与参考输出越不相似。

机器学习 (ML): 计算机科学的一个领域，重点是学习如何 (近似地) 从数据中解决问题的算法，即使用数据创建可部署在新的、以前看不见的数据上的其他算法 (模型)。

(输入到输出的) 映射：将每个 (唯一的) 可能输入配对到一个 (不一定唯一的) 输出，映射「转换」任何输入到其配对输出。

模型：执行特定任务的算法。(NLP 研究者通常仅当算法的相应任务足够复杂，以致于没有任何可证明正确的、计算上可行的方法供机器执行时，才将该算法称为模型。因此，我们应用机器学习来建立一个模型来近似该任务。) 尽管执行特定任务的模型不一定必须采用神经网络的形式 (例如，它可以采用人类书面规则列表的形式)，但在实践中，当前的 NLP 模型几乎都采用神经网络的形式。

自然语言处理 (NLP): 计算机科学的一个分支，它促进了从文本和其他语言数据 (如手语的语音或视频) 自动处理和生成信息的研究和实现。

神经网络：机器学习中广泛使用的一类模型结构，它是可分的，包含许多参数，因此非常适合使用随机梯度下降的一些变体进行训练。神经网络使用一系列由紧密连接的层 (松散地受人脑启发) 按顺序执行的计算来产生它们的输出。

(数值) 优化：可指 (1) 为一组预定参数选择最佳值的一系列策略，给定基于这些参数 (通常也包括一些数据) 计算的最小化 / 最大化的特定数量，或 (2) 研究这些策略的研究领域。在本文件中，我们仅提及第一个定义。

过度拟合：当模型学习到的模式过于特定于其训练数据，并且不能很好地泛化到该训练集之外的新数据时。该问题的典型特征是模型在训练数据本身上具有很强的任务性能，但在给定以前看不到的数据时，其性能要差得多。

平行文本：NLP 中使用的一个术语，指两种语言中相互翻译的成对文本 (通常是成对的句子)。平行文本广泛用于开发 NLP 模型，该模型执行将文本从特定源语言 (如乌尔都语) 翻译为特定目标语言 (如泰语) 的任务 (通常称为「机器翻译」)。一些语言对有更多的 (数字) 并行文本可用，不同语言对之间机器翻译系统质量的差异反映了这种差异。

30

参数 (在神经网络模型中): 单个值 (模型系数)，是神经网络定义用于执行其操作的数学函数的一部分。如果我们把一个模型看作一个执行某些任务的黑盒，那么一个参数就是这个黑盒的一个旋钮。「参数」可指旋钮本身或旋钮设定值，具体取决于上下文。

困惑：从 1 到无穷大的数字，表示语言模型看到文本片段的实际连续性时是多么「惊讶」。复杂度越低，语言模型越能预测评价数据中文本片段的实际延续性。困惑是语言模型的一个重要内在评价。

概率分布：一组数字 (不一定是唯一的)，这些数字至少为 0，加起来等于 1 (例如，0.2、0.2、0.1 和 0.5)，每个数字都与一些可能的事件成对出现；这些事件是相互排斥的。对于一个这样的事件，其数量被解释为事件发生的可能性。例如，如果一个只有 [苹果、香蕉、橘子] 组成的微小词汇量的语言模型将进行中的句子「香蕉香蕉香蕉」作为输入，并在其词汇量上产生概率分布，即「苹果」为 0.1，「香蕉」为 0.6，「橘子」为 0.3，这意味着该模型预测下一个单词将出现在进行中的给定句子之后有 60% 的几率成为「香蕉

提示 (到语言模型): 用户向语言模型提供的文本，然后模型将其用作上下文，即作为其下一个单词预测的初始基础，并反复执行以逐字生成输出。

情感分析：自然语言处理中的一项任务，目的是确定一段文本的总体情感倾向是积极的、消极的，还是在任务的某些版本中是中性的。例如，假设一个情感分析模型输入「哇，那部电影太棒了！」该输入模型的正确输出将为「正」(或者五星，或者 10/10，或者类似的东西，如果标签的形式是星星或 0 到 10 的整数)。

随机梯度下降 (SGD): 调整模型参数以使某些特定函数 (如损失函数) 最小化的过程。SGD 需要通过模型反复运行不同批次的数据，然后可以使用模型的输出从 (loss) 函数中获取值。对于每个批次，我们使用该函数的梯度来调整我们模型的参数，以便沿着该梯度进行一个微小的下降步骤。重复此过程，直到损失函数的梯度变平并停止指示较低的方向。

任务：我们希望模型完成的一项工作。任务通常是抽象描述的，例如，情感分析、问答或机器翻译，其方式不依赖于任何一个数据源。然而，在实践中，如果一个模型被训练来执行特定的任务，那么该模型学习执行的任务的版本将受到所使用的特定训练数据的严重影响。见第 5.2.2 节。

测试集 (或测试数据): 模型在训练期间看不到的一组数据，用于评估模型的工作情况。

标记：语言的基本单位，NLP 模型将任何文本输入分割成它。对于当代语言模型，标记可以是一个单词，也可以是一个单词的一部分。传递给这样一个模型的文本输入将被分为它的组成词 (如果该词是模型词汇表的一部分) 和词块 (如果该完整词不存在于模型词汇表中，那么它的组成部分将被添加到标记序列中)。

训练集 (或训练数据): 用于训练模型 (换句话说，用于确定该模型的参数值) 的一组数据。对于采用神经网络形式的模型，训练集由运行随机梯度下降时使用的批量数据组成。

Transformer:2017 年引入的一种神经网络体系结构，允许使用它构建的大型模型比早期模型体系结构允许的训练速度更快，并且在更多数据上 (假设访问某些相对较高的内存硬件)。他们通过使用超出本工作范围的技术 (如自我关注) 来实现这一点。见第 4.2 节。

31

参考文献

Church、Kenneth W. 和 Robert L.Mercer。1993 年，《使用大型语料库的计算语言学专刊导论》，计算语言学 19 (1):1-24。https://aclanthology.org/j93-1001

道奇、杰西、马丁·萨普、安娜·马拉索维奇、威廉·阿格纽、加布里埃尔·伊尔哈科、德克·格罗内维尔、玛格丽特·米切尔和马特·加德纳。大型 Webtext 语料库的记录：一个关于巨大的干净爬网语料库的案例研究〉，《2021 年自然语言处理实证方法会议论文集》，1286-1305。在线；多米尼加共和国蓬塔卡纳：计算语言学协会。https://doi.org/10.18653/v1/2021.emnlp-main.98

艾莉森·戈普尼克。2023 年，《作为文化技术的大型语言模型》，在计算语言学协会第 61 届年会上发表。Gururangan、 Suchin、 Dallas Card、 Sarah Dreier、 Emily Gade、 Leroy Wang、 Zeyu Wang、 Luke

Zettlemoyer 和 Noah A.Smith。2022.「谁的语言算高质量？在文本数据选择中测量语言意识形态」，《2022 自然语言处理实证方法会议论文集》，2562-80。阿拉伯联合酋长国阿布扎比：计算语言学协会。https://aclanthology.org/2022.emnlp-main.165

霍夫曼、乔丹、塞巴斯蒂安·博尔吉奥、阿瑟·门施、埃琳娜·布查茨卡娅、特雷弗·蔡、伊丽莎·卢瑟福、迭戈·德拉斯·卡斯等人，2022 年。「计算最佳大型语言模型训练的实证分析」，《神经信息处理系统进展》，S.Koyejo，S.Mohamed，A.Agarwal，D.Belgrave，K.Cho 和 A.Oh 编辑，35:30016–30。Curran Associates，Inc。https://proceedings、 神经 ips.cc/paper\u files/paper/2022/file/c1e2faff6f588870935f14ebe04a3e5-paper-Conference.pdf

纳尔逊，阿隆德拉。2023 年，《厚对齐》，发表于 2023 年 ACM 公平、问责和透明度会议 (ACM FAccT)。https://youtu.be/sq_xwqvtqvq?t=957

西 ，安德烈 。2 0 1 9 .「量刑私有化：累犯风险评估的授权框架」，《 哥伦比亚法律评论 》 1 1 9 (6):1 6 7 1 –1 7 1 0 。https://columbialawreview.org/content/privatizing-sentencing-a - 授权 - 累犯风险评估框架 /

Papineni、Kishore、Salim Roukos、Todd Ward 和 Wei Jing Zhu。Bleu: 机器翻译的自动评估方法〉，《计算语言学协会第 40 届年会论文集》，311-18。美国宾夕法尼亚州费城：计算语言学协会。https://doi.org/10.3115/1073083.1073135

Peters、Matthew E.、Mark Neumann、Mohit Iyyer、Matt Gardner、Christopher Clark、Kenton Lee 和 Luke Zettlemoyer。2018.「深层语境化词语表征」，《计算语言学协会北美分会 2018 年会议论文集：人类语言技术 》 ，第 1 卷 (长论文)，2227-37。路易斯安那州新奥尔良：计算语言学协会 。https://doi.org/10.18653/v1/n18-1202

Prates，Marcelo O.R.，Pedro H.Avelar 和 Luís C.Lamb。2019.「评估机器翻译中的性别偏见：谷歌翻译的案例研究」，《神经计算与应用》32 (10):6363–81。https://doi.org/10.1007/s00521-019-04144-6

Raghavan、Manish、Solon Barocas、Jon Kleinberg 和 Karen Levy。减少算法雇佣中的偏见：评估要求和实践〉，《2020 年公平、责任和透明度会议论文集》，469-81。FAT*'20。美国纽约州纽约市：计算机械协会。https://doi.org/10.1145/3351095.3372828

Sap、Maarten、Dallas Card、Saadia Gabriel、Yejin Choi 和 Noah A.Smith。2019.《仇恨言语检测中的种族偏见风险》，载于计算语言学协会第 57 届年会论文集，1668-78。意大利佛罗伦萨：计算语言学协会。https:

//doi.org/10.18653/v1/P19-1163.

Sennrich、Rico、Barry Haddow 和 Alexandra Birch。2016.「具有子词单位的稀有词的神经机器翻译」，《计算语言学协会第 54 届年会论文集》(第 1 卷：长篇论文)，1715-25。德国柏林：计算语言学协会。https://doi.org/10.18653/v1/p16-1162

Shannon，C.E.1951 年。「印刷英语的预测与熵」，《贝尔系统技术期刊》第 30 期 (1):50–64。https://doi.org/10.1002/j.1538-7305.1951.tb01366.x

Shneiderman、Ben 和 Pattie Maes。1997 年，《直接操纵与界面剂》，交互作用 4 (6):42–61。https://doi.org/10.1145/267505.267514

32

Vaswani、Ashish、Noam Shazeer、Niki Parmar、Jakob Uszkoret、Llion Jones、Aidan N Gomez、ukasz Kaiser 和 Illia Polosukhin。2017.「注意力就是你所需要的一切」，《神经信息处理系统的进展》，编辑: I.Guyon、U.Von Luxburg、S.Bengio、H.Wallach、R.Fergus、S.Vishwanathan 和 R.Garnett。第 30 卷。Curran Associates，Inc。https://proceedings.neurips.cc/paper_files/paper/2017/file/3f5ee243547dee91fbd053c1c4a845aa-Paper .pdf

维纳 ，诺伯特 。自动化的一些道德和技术后果 〉 ，《 科学 》 131 (3410):1355-58。http://www.jstor.org/stable/1705998

附录

损失函数和梯度下降，更正式一点

损失函数的第一个重要性质是，它在扣分时考虑了输出的所有可能的好的和坏的方面。给定特定输入的模型输出与该输入的正确输出越不相似，损失函数应越高。第二个重要特性是，我们必须能够完全自动地、并行地推导出所有参数的调整将使损失函数减小。您可能还记得微积分课程中的问题，如「函数输入的微小变化如何影响函数的输出？」与微分概念有关。总之，我们需要损失函数对于参数是可微的。(这可能有点让人困惑，因为在微积分中，我们考虑根据函数的输入区分函数。在数学意义上，输入只是神经网络编码的数学函数输入的一部分；参数也是其输入的一部分。) 如果损失函数具有此特性，然后，我们可以使用微分来自动计算每个参数的微小变化，以减少给定示例中的损失。

这两个属性对期望评价的忠实性和对参数的可微性是冲突的，因为大多数评价分数是不可微的。用于翻译的 Bleu 分数和用于情感分析的错误率是逐步函数 (数学上称为「分段常数」): 稍微改变参数通常不会影响这些评估分数；当它发生的时候，这可能是一个戏剧性的变化。人的判断在参数方面也是不可微的。

一旦我们知道一个可微的损失函数，并在附加一些假设的情况下，我们很快就得到了设置系统参数的随机梯度下降 (SGD) 算法。与第 2.3.2 节相比，更正式地描述其步骤:

1. 随机初始化参数。

2. 随机抽取培训数据样本 (通常为 100 到 1000 个演示); 通过系统运行每个输入，并计算每个参数的损失

及其一阶导数。(当一阶导数叠加到一个向量中时，它被称为梯度。) 保持损失值和梯度和的运行总数。3. 对于每个参数，更改其值与渐变向量中的相应值成比例。(如果渐变为零，请不要更改该参数。)

4. 如果损失正在收敛，请转至步骤 2。

字错误率，更正式

给定一些测试数据 (语言模型没有训练过的一些文本)，我们可以如下计算错误率。将试验数据中的文字表示为 w1、w2、，wN。

1. 设置 m=0; 这是错误的计数。

2. 对于测试数据中的每个单词 wi (i 为其位置):

1. 输入 wi 的前一个上下文，在前几个单词之后是序列 w1，w2，wi−1，输入语言模型。

33

2. 让语言模型预测下一个单词；将其预测称为 wpred。

3. 如果 wpred 不是 wi，则语言模型做出了错误的预测，因此将 1 添加到

m。

3. 错误率为 m/N。

困惑，更正式

第 3.4 节描述了 LMs 如何「决定」下一个单词的基本属性。在这里，为了准备深入了解困惑，我们总结并构建这些特性:

·根据前面单词的上下文，神经网络进行计算，为词汇表中的每个单词分配一个概率，即每个可能的选择下一个单词。这些概率必须总是和为一 (这是概率分布定义的一部分)，我们还强加了一个「不为零」的规则：每个词汇单词的概率必须至少是略微正的。

·为了预测下一个单词，该模型可以 (a) 选择概率最高的一个 (如上面的错误率计算中所假设的) 或 (b) 从概率分布中模拟抽取，随机选择一个单词，以便每个单词被抽取的概率由其概率给出。举例来说，想象一个酒吧琐事团队，其中每个成员过去的正确率不同。方法 (a) 将对应于团队始终提交由琐事专家团队成员提出的答案，其建议的答案以前通常是正确的。进近 (b) 将对应于随机挑选应该回答的人，其中最有可能选择的是琐事专家的答案，其次是第二好的团队成员的答案，然后是第三好的团队成员的答案，依此类推。请注意，(b) 的最有可能结果与 (a) 的结果相同，但 (b) 有时会导致另一个概率较低的单词。

部署 LM 时是否使用 (a)、(b) 或其他方法是一个重要的设计决策。为了与我们先前对错误率的拒绝保持一致，研究人员试图避免以对 LMs 的最终使用做出不必要承诺的方式来评估 LMs。选项 (b) 很有趣，因为它建议解决第 3.4 节讨论的简单计算错误的陷阱。20

在前面附录小节的错误率计算程序中，我们可以应用步骤 2.2 中的选项 (b)。假设我们不这样做一次，而是对每个上下文 / 单词对执行多次，并平均这些随机抽取的错误率。有了足够的绘图，这种方法将提供有意义的错误率，因为我们希望在某些时候让每个单词都正确 (无零规则)。在实践中，我们不是实际进行随机抽取，而是直接使用 LM 的概率为测试数据中的每个单词分配分数。这种方法的结果是:

·如果语言模型给出正确的下一个单词的概率 1，那么该单词的得分将为 1。这不可能完全发生，因为所有错误单词的概率必须超过零 (无零规则)。但是，如果所有错误单词的概率都是无穷小的，那么原则上我们可以任意接近。

·如果 LM 给正确的下一个单词的概率为 0，则该单词的得分为 0。但这也不可能发生，因为没有零规则。

·一般来说，LM 分配给正确的下一个单词的概率越大，即使它不是最可能的单词，得分也越高。

由于无零规则，每个单词的概率得分总是介于 0 和 1 之间。

在给定测试数据的情况下，我们可以计算出每个单词的 LM 概率。如果我们取这些概率分数的简单平均值，然后从 1 中减去 ，我们会得到类似于错误率的东西 (从技术上讲 ，是预测方法 (b) 下的「预期」错误率 )。在实践中所做的是

我们所期望的评估的技术术语是「内在」评估，意思是我们想要衡量模型的内在质量，而不是它在某些外在环境中的性能。

34

精神上相似但略有不同：我们取这些概率分数的倒数的几何平均值，这个值称为 (测试数据) 困惑度。原因部分是实际的 (微小的数字会导致数值计算中出现问题，称为底流)，部分是理论的，部分是历史的。为完整起见，程序如下:

1. 设置 m=0。(此数量不再是错误的连续计数。) 2. 对于测试数据中的每个单词 wi (i 为其位置):

1. 输入 wi 的前一个上下文，在前几个单词之后是序列 w1，w2，wi−1，输入语言模型。2. 设 p 是语言模型分配给 wi (正确的下一个单词) 的概率。

3. 将−log (p) 添加到 m。

3. 困惑是 exp (m/N)。虽然从前面的过程来看，它可能不是很直观，但是困惑确实有一些很好的直观特性:

·如果我们的模型以概率 1 完美地预测了测试数据中的每一个单词，我们将得到 1 的困惑。这不可能发生，因为 (1) 在新鲜的、看不见的文本数据中存在一些基本的不确定性，(2) 对于每个错误的单词也保留了一些概率质量 (没有零规则)。如果困惑非常接近于 1，那么测试数据不能用于最终测试以外的任何事情 (如训练) 的基本规则应该仔细验证。21

·如果我们的模型给测试数据中的某个单词分配了一个 0 的概率，那么困惑就会无穷大。这不会发生，因为没有零规则。22

·困惑越低越好。

·困惑可以解释为一个平均的「分支因子」; 在一个典型的下一个单词预测实例中，有多少词汇被「有效地」

考虑？

21 要了解这一点，请注意−log (1)=0，因此 m 在整个步骤 2 中保持为 0。请注意，exp (0/N)=exp (0)=1。22 要看到这一点，请注意 log (0) 趋向于无穷大。