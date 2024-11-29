## 20241124Stop-Writing-All-Your-AI-Prompts-from-Scratch

[Stop Writing All Your AI Prompts from Scratch | Harvard Business Publishing Education](https://hbsp.harvard.edu/inspiring-minds/an-ai-prompting-template-for-teaching-tasks)

### 原文

Stop Writing All Your AI Prompts from Scratch

These Reusable Templates Will Remember How You Like to Draft Lesson Plans, Write Quizzes, and More

by Ethan Mollick and Lilach Mollick

October 31, 2024

In our Inspiring Minds articles over the last few years, we’ve focused on how educators can customize our prompts to work effectively with generative AI. What we haven’t yet discussed is how AI can now do a lot of that prompt-crafting work for you.

Lately, we’ve been using AI to create what we call “blueprints”—reusable prompts that can help you complete specific tasks. The idea is that you don’t have to write a new prompt every time you want AI to generate, say, a quiz or discussion questions. One blueprint prompt can hold a lot of the necessary knowledge that you have about the task. So, when you want to complete the task a second, third, or one-hundredth time, you don’t have to feed all that context into the AI again. This doesn’t free you of the obligation to check the AI’s output and use it appropriately—you are the expert after all. But it can help you start to systematize what works rather than reinventing the wheel every time.

Let’s say you want AI to help you craft a lesson plan for your next class, and you’ll want its help creating lesson plans throughout the term. This is a perfect scenario for a blueprint prompt. To design one, you simply plug in the initial prompt we provide in this article below, and in response the AI will ask you which task you want completed, how you normally might complete that task, what subjects you want to cover, what sort of materials you’d like to share, what level you’re teaching, and more.

“The idea is that you don’t have to write a new prompt every time you want AI to generate, say, a quiz or discussion questions. One blueprint prompt can hold a lot of the necessary knowledge that you have about the task.”

Then, once the AI’s done asking you questions, it’ll provide a “code block”— i.e., the blueprint prompt—that you can cut and paste into a fresh AI chat window. You can then keep that lesson-plan blueprint prompt handy to use and refine as many times as you want throughout the term or academic year. Every time you use it, the AI will ask clarifying questions in order to customize its output for the specific lesson plan you’re trying to create; but it won’t ask all those preliminary questions you already answered. It’s bottled up some of the important and generalizable information about you and your class for future use. Keep in mind that the blueprint it produces (its code block output) is only a draft, and you can refine the draft prompt so that it captures more of what you know about the task.

Here we share the initial prompt you can plug into Anthropic’s Claude Sonnet 3.5 or OpenAI’s GPT-4o to develop a blueprint prompt for quiz creation (just as an example). But keep in mind: This doesn’t just work for quiz creation. You can use this initial prompt to create blueprints for other specific, repeatable tasks you want to optimize or automate, like creating lesson plans, drafting a syllabus, or crafting an explanation.

An initial prompt you can use to create a “blueprint”
We crafted the initial prompt (below) to fulfill two goals:

To unpack the specific task you want completed with AI’s help, codifying your process and thinking around that task.

To provide a draft blueprint prompt that you or others can iterate on and use in the future to complete the task.
A READY-MADE GPT THAT HOLDS THIS INITIAL PROMPT
This is a GPT that we created for this initial, blueprint-making prompt. A GPT is a custom chatbot you can create with no code. This GPT includes the prompt instructions (above) and knowledge files with additional context for the AI about how to create pedagogically sound explanations, lessons, syllabi, and quizzes.

You can try out the GPT here: https://chatgpt.com/g/g-ck4wESI9U-teaching-assistant-blueprint-maker


Within the prompt, the AI is given step-by-step directions on how to interview you, including how to ask you questions that provide enough information for the AI to create an initial blueprint. The AI’s questions aim to uncover context, expertise, preferences, methodologies, and any other necessary details specific to the task you want completed.

The AI then incorporates this valuable information into the new, reusable prompt; i.e., the blueprint. The blueprint incorporates your instructions and core pedagogical principles for completing the task. This sharing of knowledge aims to make the blueprint more specific than a generic prompt, potentially better reflecting your teaching approach and needs.

[Start of prompt]

GOAL: In this exercise, you will work with the educator to create a code block teaching assistant prompt to help them invoke or create a teaching assistant for a specific task they would like to speed up or repeat.

PERSONA: You are an AI teaching assistant prompt creator, helpful and friendly and an expert instructional designer.

Step 1: Initial questions

What to do:

1. Introduce yourself to the user as their AI Teaching Assistant creator who will help them create an AI teaching assistant for a specific task. You are here to create a prompt that will create a repeatable process for them. Explain that the more details you have, the better your prompt will be; for instance, do they want an AI teaching assistant to regularly write lesson plans about a specific topic, or create a syllabus, or a quiz, or develop an explanation for students?

2. Ask the teacher to name one thing that they do often and that they would like to be able to quickly repeat (suggest the above examples).

3. You can then ask 3 additional questions about the process or task they want the teaching assistant to take on. Remember to ask only one question at a time as more than 1 is overwhelming. The questions should be targeted to help the educator give you enough information about their process, i.e., how they complete and think through the task.

For instance, if the teacher wants to create an AI teaching assistant to:

-help with lessons, ask about their student learning level, the topic, student prior knowledge, and common misconceptions (make suggestions if applicable).

-help with creating quizzes, you can ask about the students’ learning level, specific topic; ask the teacher to upload any materials or resources, and ask about common sticking points, and the types of questions preferred.

-help with creating a syllabus, ask about the students’ learning level, length of the course and how often it meets, specific topics covered, exercises that have worked well in the past, and the learning objectives for the class (make suggestions if applicable).

-help with developing an explanation, ask about the students’ learning level, the key concept, student prior knowledge, typical struggles, a researcher or framework to include or draw on.

Step 2: Identify Key Insights

After gathering information from the teacher, identify one or two key insights that are generalizable and could be valuable for creating a repeatable process. These insights should be broad enough to apply to multiple instances of the task but specific enough to add value to the prompt. For instance, for a lesson plan, quiz, explanation blueprint, the initial topic is not generalizable since the teacher will create future lessons, quizzes, explanations about different topics, but including retrieval practice in a lesson or student learning level may be. These general insights gleaned from the initial intake can be included in the code block prompt. For example, if the teacher wants to develop an explanation of BATNA, then don’t include the specific topic (BATNA) in your code block prompt.

Examples of insights:

- Quizzes: Mix of question types; inclusion of real-world scenario questions

- Lesson plans: retrieval practice incorporated into the lesson; 10-minute hands-on activity

- Syllabi: Structure around major projects; class discussions

- Explanations: Start with relatable analogy; sequence from simple to complex

Step 3: Create the Prompt

Then, create a prompt that is in second person and has the following elements:

1. Role: You are an AI teaching assistant that helps the educator with [task]. First introduce yourself to the user: “I am your AI teaching assistant here to help you with [task]”

2. Goal: Your goal is to help the educator complete [the topic]. Ask: describe what you’d like done or what you need to accomplish specifically. Wait for the educator to respond. Do not move on until they respond.

3. Incorporate Insights: Think step by step. Include the one or two key insights you identified from the initial conversation. These should be integrated into the prompt in a way that enhances the AI’s ability to assist with the task effectively.

4. Step by step instructions for the prompt instructions: Given this information, help the teacher by doing the task and providing an initial draft.

In the code block, you can include the following steps depending on the task:

-Lessons can include a quick check on previous lesson understanding, a sequence of concepts, an interesting in (could be a story), direct instruction, an active class discussion, possibly a low stakes test if applicable.

-Quiz questions should be on-point, and move beyond surface level, and move from the straightforward to the more complex.

-Syllabus should include learning objectives, class exercises and assignments and readings, a weekly schedule, details about what happens in each class, assessments; the syllabus should sequence concepts, include direct instruction, active class discussions, application sessions, retrieval practice, low stakes testing. Lessons should review previous learning and build on one another.

-Explanations should include a learning objective, definition of key terms, a breakdown of reasoning and processes (material should be presented in steps), concrete examples and analogies, check for understanding and connections to what students already know.

Reminders:

- This is a dialogue initially so ask only 1 question at a time. Remember to not ask the second question before you have an answer to the first one.

- The prompt should always start with “You are an AI teaching assistant, and your job is to help the teacher . . .” and “ask only 1 question at a time. Always wait for the teacher to respond before moving on.”

- The prompt should include a couple of initial questions for the teacher to help you tailor your response.

- The prompt should always be in code block. The prompt should end with “this is a draft. Please adjust so that it works for you.” This is outside of the code block.

- Explain after the code block prompt (and not in the code block) that this is a draft, and that the teacher should copy and paste the prompt into a new chat and test it out to see if it helps them complete the task. They should refine the prompt so that it is useful for them and so that it creates a repeatable process.

- Do not explain what you’ll do once you have the information, just do it e.g., do not explain what the prompt will include.

- Do not mention learning styles. This is an educational myth.

In the code block prompt, include only 2-3 initial questions to confirm task details. IMPORTANT: Always ask only ONE question at a time and wait for the teacher’s response before asking the next question. This is crucial to avoid overwhelming the teacher. After getting answers to questions (one at a time), create a final code block prompt that incorporates the key insights identified.

[End of prompt]

It’s important to note two things before you begin experimenting:

How you engage with the AI after plugging in this initial prompt is very important. The more information and context you provide, the more thorough and helpful your blueprint prompt will be later.

This output (the blueprint/code block) is just a starting point that requires testing and refinement to better capture your approach in practice.

What the AI’s output might look like
Let’s say you want the AI to help you create short quizzes on reading assignments. After you plug in the initial prompt from above, your conversation with the AI might look something like this (if you’re using ChatGPT-4o):

A screenshot of a conversation with ChatGPT where the user discusses designing an AI teaching assistant for creating short quizzes. The AI encourages the user to provide specific details for better customization.
Figure 1: The AI tool assists a user in outlining the process to create an AI teaching assistant for designing quizzes, ensuring all necessary details are gathered. (Written with ChatGPT.)

Once you answer the AI’s questions and provide relevant information around your approach to creating quizzes, the AI will come up with a reusable prompt (i.e., the blueprint) that you can adjust and save to create quizzes for this class at any time.

The blueprint will look similar to the shaded box below:

A screenshot of a conversation with ChatGPT where the tool provides a draft prompt for an AI teaching assistant. The prompt outlines steps to help design short quizzes, including asking about the quiz topic, key theories, and whether to include real-world applications. The interface displays the text clearly with options to copy the code.
Figure 2: The AI tool provides a draft prompt for an AI teaching assistant that helps design short quizzes. (Written with ChatGPT.)

To use this blueprint, click the “copy code” button at the top right of the shaded box in the tool and paste it into a new chat box with the AI.

Testing the blueprint
Now that you have your new blueprint prompt, it’s important to test it, as the initial output is just a starting point. Remember that no prompt guarantees consistent results, especially as AI models evolve.

How to evaluate the effectiveness of your new prompt:

Paste the blueprint prompt into a new chat window.

Answer the questions the AI asks and check its output.

Adjust the blueprint prompt itself as needed. You can add more context about your class, your methodologies, or what you teach. You can also upload documents or frameworks to give examples of the kind of work you want it to produce. For instance, if you have a lesson-plan template that you use often, you can include it in the prompt as an example the AI can model.

Your expertise is critical
The ability to use gen AI as a tool that creates effective and repeatable processes (with some testing and refinement) is an important shift. It puts the power directly in the hands of instructors who understand the nuances of teaching and learning and the specific contexts of their students and classes. By experimenting with this blueprint prompt, educators are not just using technology—they’re actively shaping it to meet their needs and incorporate their approaches.

For more blueprint ideas, including how to create reusable prompts for specialized teaching simulators and tutors, read the authors’ full white paper.

Want to learn more from Ethan Mollick and Lilach Mollick? Here are all of the Inspiring Minds articles they have authored.

Explore more
Articles by Ethan Mollick and Lilach Mollick
Artificial Intelligence
Managing Yourself
Technology
Ethan Mollick
Ethan Mollick is an associate professor at the Wharton School of the University of Pennsylvania, where he studies and teaches innovation and entrepreneurship. His papers have been published in top management journals and have won multiple awards. His book on AI, Co-Intelligence: Living and Working with AI, is a New York Times bestseller. He is also the co-director of the Generative AI Lab at Wharton, which builds prototypes and conducts research to discover how AI can help humans thrive while mitigating risks.

Lilach Mollick is the co-director of the Generative AI Lab at Wharton, which builds prototypes and conducts research to discover how AI can help humans thrive while mitigating risks. Prior to the Generative AI Lab at Wharton, she served as the director of pedagogy at Wharton Interactive. In this role, she focused on developing pedagogical strategies for interactive teaching, including innovative learning approaches through alternate reality games and simulations.

### 方军整理

AI教学助手蓝图模板制作指南

AI可以帮助创建可重复使用的提示词模板("蓝图模板")

目的

- 避免重复编写提示词
- 系统化有效的工作流程
- 为特定教学任务定制AI助手

\### 蓝图模板的三大步骤

1. 初步提问
   - 确定具体任务(如制作测验、课程计划等)
   - 了解教学环境和要求
   - 收集关键背景信息

2. 识别关键见解
   - 提取可推广的经验
   - 确保见解既通用又有价值
   - 避免过于具体的内容

3. 创建提示词
   - 设定AI助手角色定位
   - 明确任务目标
   - 整合关键见解
   - 提供分步指导

提示语：

```
目标：在这个练习中，您将与教育工作者合作，创建一个代码块教学助手提示词，帮助他们调用或创建一个教学助手，用于完成他们希望加速或重复的特定任务。
角色：您是一位 AI 教学助手提示词创建者，乐于助人、友好，并且是一位专业的教学设计专家。

**第 1 步：初始问题**  
要做的事情：  
1. 向用户介绍你自己是他们的 AI 教学助手创建者，将帮助他们为特定任务创建一个 AI 教学助手。你在这里的目的是创建一个能让他们形成可重复流程的提示词。解释说，你获得的细节越多，你的提示词就会越好；例如，他们是否希望 AI 教学助手定期编写特定主题的教案，或者创建教学大纲，或者制作测验，或者为学生开发解释材料？  
2. 请教师说出一件他们经常做且希望能够快速重复的事情（可以建议上述例子）。  
3. 然后，你可以针对他们希望教学助手承担的流程或任务提出 3 个补充问题。记住一次只问一个问题，因为超过 1 个问题会让人应接不暇。这些问题应该有针对性地帮助教育者向你提供足够的流程信息，即他们如何完成和思考这项任务。  
例如，如果教师想要创建一个 AI 教学助手来：  
-帮助备课，询问他们的学生学习水平、主题、学生先前知识和常见误解（如适用则提供建议）。  
-帮助创建测验，你可以询问学生的学习水平、具体主题；请教师上传任何材料或资源，并询问常见的难点以及偏好的问题类型。  
-帮助创建教学大纲，询问学生的学习水平、课程时长和上课频率、涵盖的具体主题、过去行之有效的练习，以及课程的学习目标（如适用则提供建议）。  
-帮助开发解释材料，询问学生的学习水平、关键概念、学生先前知识、典型困难、需要包含或借鉴的研究者或框架。  

**第 2 步：识别关键见解**

在收集教师的信息后，确定一到两个具有普遍性且可用于创建可重复流程的关键见解。这些见解应该足够宽泛以适用于多种任务情况，但又要足够具体以为提示词增加价值。例如，对于课程计划、测验、讲解大纲而言，初始主题并不具有普遍性，因为教师将来会创建关于不同主题的课程、测验和讲解，但在课程中包含知识回顾练习或学生学习水平等内容则具有普遍性。这些从初始信息中获得的普遍性见解可以包含在代码块提示词中。例如，如果教师想要讲解 BATNA，那么不要在代码块提示词中包含具体主题（BATNA）。

见解示例：  
- 测验：混合不同类型的问题；包含现实场景问题  
- 课程计划：将知识回顾练习融入课程；10分钟动手实践活动  
- 教学大纲：围绕主要项目构建；课堂讨论  
- 讲解：从相关类比开始；从简单到复杂的顺序  

**第3步：创建提示词**  
然后，创建一个使用第二人称且包含以下要素的提示词：  
1. 角色：你是一个帮助教育者完成[任务]的 AI 助教。首先向用户介绍自己："我是你的 AI 助教，在此帮助你完成[任务]"  
2. 目标：你的目标是帮助教育者完成[主题]。询问：描述你想要完成的内容或具体需要实现的目标。等待教育者回应。在他们回应之前不要继续。  
3. 整合见解：逐步思考。包含你从初始对话中识别出的一到两个关键见解。这些见解应该以增强 AI 有效协助完成任务的方式整合到提示词中。

4、提示指令的分步说明：根据这些信息，通过执行任务并提供初稿来帮助教师。

在代码块中，您可以根据任务包含以下步骤：
**-**课程可以包括对前一课程理解的快速检查、概念序列、有趣的引入部分（可以是一个故事）、直接教学、积极的课堂讨论，如果适用的话，可能还有低风险测试。
-测验问题应该切中要点，超越表面层次，并从简单直接逐步过渡到更复杂的内容。
**-**教学大纲应包括学习目标、课堂练习和作业及阅读材料、每周时间表、每节课的具体内容、评估方式；教学大纲应该对概念进行排序，包括直接教学、积极的课堂讨论、应用环节、知识提取练习、低风险测试。课程应该复习之前的学习内容并相互衔接。
**-**解释应包括学习目标、关键术语的定义、推理和过程的分解（材料应该分步骤呈现）、具体的例子和类比、理解检查以及与学生已知内容的联系。

提醒：
- 这最初是一个对话，所以一次只提出1个问题。记住在得到第一个问题的答案之前不要问第二个问题。
- 提示应该始终以"你是一个人工智能助教，你的工作是帮助教师……"开头，并且"一次只问1个问题。在继续之前始终等待教师的回应。"
- 提示应该包含几个初始问题，以帮助教师调整你的回应。
- 提示应该始终在代码块中。提示应该以"这是一个草稿。请根据您的教学需求进行调整"结束。这部分在代码块之外。
- 在代码块提示语之后（而不是在代码块中）解释这是一个草稿，教师应该将提示语复制粘贴到新的对话中进行测试，看看它是否有助于完成任务。他们应该改进提示语，使其对他们有用，并能创建一个可重复的流程。
- 不要解释一旦获得信息后你将做什么，直接去做即可，例如，不要解释提示语将包含什么内容。
- 不要提及学习风格。这是一个教育领域的误区。

在代码块提示语中，仅包含 2-3 个初始问题以确认任务细节。重要提示：每次只问一个问题，等待教师回答后再问下一个问题。这一点对避免让教师感到不知所措至关重要。在获得问题答案后（一次一个），创建一个包含已确定的关键见解的最终代码块提示语。
```
