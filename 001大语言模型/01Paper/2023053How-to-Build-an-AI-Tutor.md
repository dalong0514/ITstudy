## 2023053How-to-Build-an-AI-Tutor

How to Build an AI Tutor that Can Adapt to Any Course and Provide Accurate Answers Using Large Language Model and Retrieval-Augmented Generation

Dong Chenxi

Department of Mathematics and Information Technology, The Education University of Hong Kong, Hong Kong Email: cdong@eduhk.hk

ABSTRACT: 

Artificial intelligence is transforming education through data-driven, personalized learning solutions. This paper introduces AI Tutor, an innovative web application that provides personalized tutoring in any subject using state-of-the-art Large Language Model (LLM). AI Tutor ingests course materials to construct an adaptive knowledge base tailored to the course. When students pose questions, it retrieves the most relevant information and generates detailed, conversational responses citing supporting evidence. The system is powered by advanced large language models and Retrieval-Augmented Generation (RAG) techniques for accurate, natural question answering. We present a fully-functional web interface and video demonstration that showcase AI Tutor's versatility across diverse subjects and its ability to produce pedagogically cogent responses. While an initial prototype, this work represents a pioneering step toward AI-enabled tutoring systems that can democratize access to high-quality, customized educational support.

Keywords: Intelligent Tutoring Systems, Large language model, Retrieval-Augmented generation, Adaptive education, Personalized learning

直接翻译：

人工智能正在通过数据驱动的个性化学习解决方案转变教育。本文介绍了 AI Tutor，这是一款创新的网络应用程序，它使用最先进的大型语言模型（LLM）提供任何科目的个性化辅导。AI Tutor 摄取课程材料以构建针对课程的适应性知识库。当学生提出问题时，它检索最相关的信息，并生成详细的、对话式的回答，并引用支持证据。该系统由先进的大型语言模型和检索增强生成（Retrieval-Augmented Generation，RAG）技术提供动力，以实现准确、自然的问题回答。我们展示了一个功能齐全的网络界面和视频演示，展示了 AI Tutor 在不同学科上的多功能性，以及其产生教育上有说服力的回答的能力。虽然是一个初步原型，但这项工作代表了向 AI 启用的辅导系统迈出的开创性一步，这些系统可以民主化地获取高质量、定制化的教育支持。

重述以提高易读性：

本文探讨了一种名为 AI Tutor 的创新网络应用程序，它利用人工智能通过数据驱动方法实现个性化学习，从而改变教育领域。AI Tutor 采用了最先进的大型语言模型（LLM），为任何学科提供定制化的辅导服务。通过吸收课程资料，它构建了一个适应课程需求的知识库。学生提出问题时，AI Tutor 能够检索到最相关的信息，并提供详细的对话式答案，同时引用支持的证据。这一系统结合了先进的大型语言模型和检索增强生成（RAG）技术，以确保问题回答的准确性和自然性。我们还展示了 AI Tutor 的一个功能完备的网络界面和视频演示，这些演示展示了它在多个学科上的广泛适用性以及其生成教育意义上有力回答的能力。尽管 AI Tutor 目前还是一个初步的原型，但它代表了向能够为广大用户提供高质量、个性化教育支持的 AI 辅导系统迈出的重要一步。

### 01. Introduction

The advent of artificial intelligence (AI) has instigated a transformational wave across various sectors, with education standing as a salient beneficiary. AI's unrivaled capacity to enable personalized and adaptive learning experiences has propelled intelligent tutoring systems to the forefront of modern educational paradigms (Kasneci et al., 2023). These systems, powered by AI, offer individualized feedback and interactive learning modules designed to cater to each student's distinct learning needs. Nonetheless, the challenge of developing AI tutors capable of delivering consistently accurate and dependable responses across diverse academic disciplines persists.

A notable hindrance to the reliability of AI in educational applications is the occurrence of 'information hallucination', a phenomenon where AI-generated responses, while appearing valid, deviate from factual accuracy (Nye et al., 2023). Such inconsistencies can undermine confidence in AI-centric educational systems (Kasneci et al., 2023). Furthermore, the customization of these systems to align with specific course content necessitates access to current and pertinent educational materials, a task often complicated by the multifaceted nature of academic disciplines.

To tackle these challenges, this paper introduces AI Tutor, a web application developed upon the sophisticated infrastructure of large language models (LLMs) and retrieval-augmented generation (RAG). AI Tutor is engineered to deliver accurate, contextually relevant responses by intelligently assimilating information from course-specific materials (Lewis et al., 2020). Our system signifies a substantial leap from traditional rule-based educational methodologies, amplifying the personalization potential of AI tutoring systems. The AI Tutor distinguishes itself with a user-centric web interface that streamlines the process of uploading course materials and submitting queries. It integrates robust vector embedding and storage systems for educational content, employs similarity-based retrieval algorithms to pinpoint relevant information, and leverages the OpenAI Assistants API, combining the strengths of LLMs and RAG for sophisticated answer generation. In addition, AI Tutor provides an option for students to download records of their Q&A sessions, thus enriching their repository of learning resources.

Our project has an ambitious goal: to build an AI tutoring system that gives accurate, personalized help for any school subject. We want to show that the latest AI technologies, known as large language models (LLMs) and retrievalaugmented generation (RAG), are more effective than the old-style tutoring systems that follow strict rules. At the core of our work is creating a smart system that can understand and use the materials from different courses to build a knowledge base tailored to students' needs. This is key to providing precise answers to students' questions and shows the system's strong grasp of the topics. We've also made a website that's easy to use, which shows off the wide range of skills our AI tutor has and how well it fits into the study process. This website proves that our system is adaptable and focused on helping users, marking the AI tutor's role in changing the way we think about education. With this project, we're not just proving that LLMs and RAG work well in education. We're also showing how they can significantly change how we use AI to support learning, pointing towards a future where AI is an essential part of how we learn.

直接翻译：

人工智能（AI）的出现在各个领域引发了一场变革浪潮，教育领域成为一个显著的受益者。AI 在提供个性化和适应性学习体验方面的无与伦比的能力，已将智能辅导系统推至现代教育范式的前沿（Kasneci 等人，2023 年）。这些由 AI 驱动的系统提供个性化反馈和互动学习模块，旨在满足每个学生独特的学习需求。然而，开发能够在不同学科领域提供一致准确和可靠回答的 AI 辅导者的挑战依然存在。

AI 在教育应用中可靠性的一个显著障碍是「信息幻觉」的发生，这是一种现象，即 AI 生成的回答虽然看似有效，但与事实准确性背道而驰（Nye 等人，2023 年）。这种不一致性可能会削弱对以 AI 为中心的教育系统的信心（Kasneci 等人，2023 年）。此外，将这些系统定制以符合特定课程内容需要访问当前和相关的教育材料，这一任务通常因学术学科的多方面性质而复杂化。

为应对这些挑战，本文介绍了 AI Tutor，一款基于大型语言模型（LLMs）和检索增强生成（RAG）的复杂基础设施开发的网络应用程序。AI Tutor 被设计为通过智能地吸收课程特定材料中的信息来提供准确、语境相关的回答（Lewis 等人，2020 年）。我们的系统从传统的基于规则的教育方法中显著跳跃，增强了 AI 辅导系统的个性化潜力。AI Tutor 以用户为中心的网络界面使上传课程材料和提交查询的过程变得简单。它集成了强大的向量嵌入和教育内容存储系统，采用基于相似度的检索算法来确定相关信息，并利用 OpenAI 助手 API 结合 LLMs 和 RAG 的优势进行复杂的答案生成。此外，AI Tutor 为学生提供了下载其问答记录的选项，从而丰富了他们的学习资源库。

我们的项目有一个雄心勃勃的目标：建立一个可以为任何学科提供准确、个性化帮助的 AI 辅导系统。我们想展示，作为最新的 AI 技术，大型语言模型（LLMs）和检索增强生成（RAG）比遵循严格规则的传统辅导系统更有效。我们工作的核心是创建一个智能系统，它可以理解和使用不同课程的材料，构建一个针对学生需求量身定制的知识库。这是提供学生问题的精确答案的关键，也展示了系统对主题的深入掌握。我们还制作了一个易于使用的网站，展示了我们 AI 辅导员的广泛技能以及它如何适应学习过程。这个网站证明了我们的系统是适应性的，以用户为中心，标志着 AI 辅导在改变我们对教育看法方面的作用。通过这个项目，我们不仅证明了 LLMs 和 RAG 在教育中的良好运作。我们还展示了它们如何显

著改变我们使用 AI 支持学习的方式，指向一个将 AI 作为我们学习方式的重要部分的未来。

重述以提高易读性：

人工智能（AI）的兴起已经在教育等多个领域掀起了一场变革浪潮，其中教育是明显的受益者之一。AI 的个性化和适应性学习经验提供能力无与伦比，使智能辅导系统成为现代教育模式的前沿（Kasneci 等人，2023 年）。这些系统能够为每个学生提供量身定做的反馈和互动学习模块，满足他们各自的学习需求。尽管如此，开发能够跨学科领域提供准确可靠回答的 AI 辅导者仍是一个挑战。

AI 在教育应用中的一个主要障碍是「信息幻觉」现象，即 AI 生成的回答看似合理，却偏离事实（Nye 等人，2023 年）。这种不一致性可能削弱人们对以 AI 为中心的教育系统的信任（Kasneci 等人，2023 年）。此外，这些系统需要访问最新和相关的教育材料，这在不同学科领域的复杂性下往往不易实现。

为了解决这些挑战，本文介绍了一款名为 AI Tutor 的网络应用程序。它基于复杂的大型语言模型（LLMs）和检索增强生成（RAG）技术开发，能够通过智能地整合特定课程材料中的信息，提供准确且与语境相关的回答（Lewis 等人，2020 年）。这一系统突破了传统基于规则的教育方法，极大增强了 AI 辅导系统的个性化潜力。AI Tutor 特别设计了一个用户友好的网络界面，简化了上传课程材料和提交问题的流程。它整合了先进的向量嵌入和教育内容存储系统，使用基于相似度的检索算法寻找相关信息，还利用了 OpenAI 助手 API，结合 LLMs 和 RAG 技术生成复杂的答案。此外，AI Tutor 还允许学生下载他们的问答记录，丰富他们的学习资源。

我们的项目目标宏伟：建立一个能够为任何学科提供准确、个性化帮助的 AI 辅导系统。我们的目标是证明，作为最新 AI 技术的大型语言模型（LLMs）和检索增强生成（RAG）比传统的遵循严格规则的辅导系统更有效。我们的核心工作是创建一个能够理解并利用不同课程材料的智能系统，以此构建适应学生需求的知识库。这是确保向学生提供精确答案的关键，也体现了系统对相关主题的深入理解。我们还开发了一个易于使用的网站，展示了 AI Tutor 的广泛技能和其在学习过程中的适应性。这个网站证明了我们的系统是用户友好且适应性强的，标志着 AI 辅导在改变我们对教育看法方面的作用。通过这个项目，我们不仅展示了 LLMs 和 RAG 在教育中的有效应用，还展示了它们如何显著改变我们利用 AI 支持学习的方式，

### 02. Related Work

AI's application in education spans a broad spectrum, from augmenting curriculum design to facilitating personalized learning experiences, engaging students, and boosting motivation. Moore, S. et al. (2023) delineate the role of AI as ranging from assistive to autonomous, predicting a shift from AI as a tool in the educator's arsenal to an independent teaching agent. Currently, AI plays a primarily assistive role, but the trend indicates a shift toward more sophisticated, AI-centric educational experiences. Bailey further explores the ethical, pedagogical, and social implications of embedding AI in learning, touching on privacy, bias, and creativity cultivation concerns.

In contrast to earlier systems, such as the PAT2Math developed by Jaques et al. (2013), which employed rule-based algorithms to guide learners through algebraic problem-solving, our AI Tutor system harnesses the latest advancements in AI to deliver a far more sophisticated and nuanced educational interaction. Where PAT2Math's rule-based engine excelled in providing immediate feedback by comparing student inputs to a set of predefined solutions, it was nonetheless constrained by the inherent limitations of its architecture, notably an inability to generate response for the answer that not existed in their database and also lack reasoning ability compare to large language model.

In the landscape of AI-enabled education, Gan et al. (2019) laid a significant groundwork with their proposed framework for an AI-based math tutor. This system uniquely leveraged a modified approach to Item Response Theory (IRT) to first gauge a learner's ability, subsequently supplying custom-tailored question and answer sessions rooted in a pre-stored mathematical database. Despite the system's innovative use of natural language processing to analyze the semantic relationship of questions, it presented certain limitations. Primarily, the system's adherence to a static question database constrained its answering flexibility, often leading to repetitive and predictable responses. Additionally, the system exhibited a low tolerance for linguistic errors, struggling with sentence structures marred by typos or poor grammar. This limited its ability to accurately parse and comprehend questions that were not part of its pre-existing bank, emphasizing a critical shortcoming of the mechanism.

In light of these limitations, our project turns to the latest advancements in large language models (LLMs). This state-of-the-art technology offers superior comprehension of natural language, allowing it to process student queries articulated in various manners effectively. The LLM also ensures the generation of natural, contextually appropriate responses, thus addressing and overcoming the limitations observed in earlier AI tutoring systems.

直接翻译：

人工智能（AI）在教育中的应用覆盖了广泛的领域，从增强课程设计到促进个性化学习体验、吸引学生和提高动力。Moore, S. 等人（2023 年）描绘了 AI 的角色，从辅助到自主不等，预测从 AI 作为教育者工具箱中的一个工具向独立教学代理的转变。目前，AI 主要扮演辅助角色，但趋势表明转向更复杂、以 AI 为中心的教育体验。Bailey 进一步探讨了将 AI 嵌入学习中的伦理、教学和社会影响，涉及隐私、偏见和创造力培养的担忧。

与早期系统（如 Jaques 等人（2013 年）开发的 PAT2Math）相比，后者使用基于规则的算法指导学习者解决代数问题，我们的 AI Tutor 系统利用了 AI 的最新进展，提供了一种更加复杂和细腻的教育互动。PAT2Math 的基于规则的引擎擅长通过将学生输入与一组预定义的解决方案进行比较来提供即时反馈，但它受到其架构固有限制的约束，特别是在生成响应方面的能力不足，因为他们的数据库中不存在这些答案，而且与大型语言模型相比缺乏推理能力。

在 AI 启用的教育领域，Gan 等人（2019 年）提出了一个基于 AI 的数学辅导框架，为该领域奠定了重要基础。该系统独特地利用了修改后的项目反应理论（IRT）来首先衡量学习者的能力，随后提供基于预存数学数据库的定制化问题和答案会话。尽管系统创新地使用自然语言处理分析问题的语义关系，但它呈现出某些限制。主要是，系统对静态问题数据库的遵循限制了其回答的灵活性，常常导致重复和可预测的回应。此外，系统对语言错误的容忍度较低，难以处理打字错误或语法不佳的句子结构。这限制了其准确解析和理解非其预存问题库中的问题的能力，突显了机制的关键缺陷。

鉴于这些限制，我们的项目转向了大型语言模型（LLMs）的最新进展。这种最先进的技术提供了对自然语言的优越理解，使其能够有效处理以各种方式表达的学生查询。LLM 还确保了生成自然、语境适当的回应，从而解决并克服了早期 AI 辅导系统观察到的限制。

重述以提高易读性：

人工智能（AI）在教育领域的应用十分广泛，它不仅丰富了课程设计，还促进了个性化学习体验，增强了学生的参与度和学习动力。Moore, S. 等人（2023 年）描述了 AI 在教育中的多种角色，从辅助工具到成为独立的教学代理。目前，AI 主要在教育中扮演辅助角色，但未来趋势可能会转向更加以 AI 为中心的复杂教育体验。Bailey 在其研究中进一步探讨了将 AI 融入学习过程中的伦理、教学和社会含义，包括隐私、偏见和创造力培养等方面的问题。

与早期的系统相比，如 Jaques 等人（2013 年）开发的基于规则的代数问题解决系统 PAT2Math，我们的 AI Tutor 系统利用 AI 的最新进展，提供了更复杂、更细腻的教育互动。PAT2Math 虽然擅长提供即时反馈，但由于其架构的限制，例如无法生成数据库中不存在答案的响应，以及与大型语言模型相比较缺乏推理能力，因此存在局限性。

在 AI 驱动教育的发展中，Gan 等人（2019 年）为基于 AI 的数学辅导系统提出了一个框架，为该领域奠定了重要基础。这个系统独特地利用了项目反应理论（IRT）的改进方法，首先评估学习者的能力，然后提供基于预存数学数据库的定制化问题和答案环节。尽管该系统创新地运用自然语言处理分析问题的语义关系，但它仍有限制。主要是由于系统对静态问题数据库的依赖，导致其回答缺乏灵活性，容易重复和可预测。此外，系统对语言错误的容忍度较低，难以处理语法错误的句子结构，这限制了其准确理解和解析非预存问题库中的问题的能力。

鉴于这些限制，我们的项目采用了最新的大型语言模型（LLMs）技术。这项先进技术提供了更好的自然语言理解能力，使其能够有效处理各种表达方式的学生查询。LLM 还能生成自然、符合语境的回答，解决并克服了早期 AI 辅导系统存在的限制。

### 03. Technical Background

This section provides an overview of the main concepts and techniques used in this project, namely Large Language Models (LLMs), Retrieval Augmented Generation (RAG), embedding, vector storage, similarity search, and modified prompts. These concepts and techniques are essential for developing and evaluating an AI-based system that can generate accurate and relevant responses to natural language queries in the domain of education.

3.1 Large Language Models

Recent advancements in natural language processing have been spurred by Large Language Models (LLMs) (Lewis et al., 2020). These are powerful neural networks trained on vast amounts of text, capable of generating coherent and meaningful language. They are versatile, used in various tasks such as translation, summarization, dialogue, and question answering. LLMs employ transformer architectures, which use self-attention mechanisms to understand text better (Shin et al., 2020). To optimize their performance, these models are initially pre-trained on large datasets and then fine-tuned for specific tasks (Brown et al., 2020).

2 Among the notable LLMs are OpenAI's GPT models, Google's PaLM, and Meta's LLaMa. In our AI Tutor system, we use OpenAI's GPT-4-1106-preview model, launched in November 2023 (Devlin et al., 2019). This model's scale and sophisticated training methodology enable it to perform exceptionally well on natural language tasks. Interestingly, GPT-4 even outperforms humans on many academic exams such as SAT and GRE as can be seen in Figure 1 below. For instance, on the SAT Math exam, it scored 710 out of 800, beating 89% of human test takers (OpenAI GPT-4 Technical Report, 2023). This highlights the model's robust reasoning capabilities. By integrating GPT-4, our AI Tutor system can effectively understand course materials, interpret diverse student questions, find relevant information, and provide natural, contextual responses (Chang et al., 2023). This significant upgrade helps overcome the limitations of previous rule-based tutoring systems struggling with open-ended student inputs.

Figure 1. Comparative Performance: GPT-3.5 and GPT-4 Surpass Human Achievement in Academic Examinations

3.2 Retrieval Augmented Generation

Retrieval Augmented Generation (RAG) is a technique for enhancing the accuracy and reliability of LLM-generated responses by grounding the model on external sources of knowledge to supplement the LLM’s internal representation of information (Lewis et al., 2020). RAG allows LLMs to access and incorporate relevant facts from an external knowledge base, such as user uploaded files, into their responses, instead of relying solely on their pre-trained parameters or hallucinating incorrect or misleading information (Cai et al., 2022). RAG consists of two main components: a retriever and a generator. The retriever is responsible for finding and ranking the most relevant documents or passages from the knowledge base given the input query. The generator is an LLM that takes the input query and the retrieved documents or passages as context and produces a response. The generator can also learn to select the best documents or passages from the retriever’s output using an attention mechanism (Moore et al.,2023).

RAG has several benefits for improving the quality and trustworthiness of LLM-generated responses. First, it ensures that the model has access to the most current, reliable, and domain-specific facts, which can improve the accuracy and relevance of the responses. Second, it provides users with the sources of the model’s responses, which can increase the transparency and verifiability of the model’s claims. Third, it reduces the need for fine-tuning the model on new data and updating its parameters, which can lower the computational and financial costs of maintaining the model (Lewis et al., 2020).

### 04. Methodology

In this section, we describe the technical design and implementation of our AI Tutor system, which aims to provide accurate and intelligent tutoring customized to any course. We also explain how we integrated the OpenAI Assistants API, which provides the core functionality of our system. The overall architecture of our AI Tutor system is illustrated in the following Figure 1.

Figure 2. The AI Tutor Framework

As shown in the Figure 2 above, our system consists of four main components:

• Course Materials: These are the domain-specific documents that provide the knowledge base for the AI Tutor.

The user can upload any course materials in text format, such as lecture notes, slides, textbooks, etc. The system will store the course materials in a vector database and use them for retrieval and generation.

• Student’s Question: This is the natural language query that the user inputs to the AI Tutor. The system will encode the question into a vector representation using a pre-trained embedding model.

• AI Tutor: This is the core component of our system that integrates the OpenAI Assistants API. The API provides the following features: o Embedding: The API uses a pre-trained embedding model to convert the text inputs (question and course materials) into vector representations. The assistants API use the OpenAI embedding o Vector Storage: The API stores the vector representations of the course materials in a vector database, which allows for efficient similarity search and retrieval. o Similarity-Based Retrieval: The API uses a similarity search algorithm to retrieve the most relevant course materials for the given question. o Retrieval-Augmented Generation (RAG): The API uses a large language model (LLM) that is augmented with a retrieval mechanism to generate the intelligent reply. The API supports various LLMs. The retrieval mechanism allows the LLM to access the relevant course materials and use them as context for generation. In this project, the we use the latest gpt-4-1106-preview trillion parameters model to empower the tutor which harness the ai power o Chat History Management: The API maintains a chat history for each user session, which allows the LLM to generate coherent and consistent replies. The API also allows the user to delete the chat history at any time.

The system's operational workflow is characterized by the following sequential steps:

• Material Upload: Users upload course materials, which are then vectorized using the API's embedding function and stored within the vector database.

• Question Submission: The student poses a question to the AI Tutor, which is encoded into a vector via the embedding feature.

• Response Generation: A modified prompt, composed of the student's question and the retrieved materials, is used to generate an intelligent response employing the RAG feature of the API. This response includes citations from the course materials, ensuring transparency and verifiability. Furthermore, the AI Tutor presents the intelligent reply to the student and updates the chat history to maintain the flow of the conversation.

• Session Continuation or Conclusion: Students have the option to continue the dialogue with additional questions, conclude the session, download a record of the chat history in HTML format for review, or delete the chat history for privacy.

The methodology applied in the development of the AI Tutor system is a testament to the integration of advanced AI with user-centric design, aiming to transform the educational landscape through personalized, responsive tutoring.

### 05. Demonstration

In this section, we present the demonstration of our AI Tutor project, which consists of two parts: the web app view and the Q&A session demo. We show how the AI Tutor works and how it can answer different types of questions based on the course materials. We also evaluate the performance and quality of the AI Tutor, such as the accuracy, relevance, naturalness, and citation of the answers.

5.1. Web App View

We developed a web app using Streamlit to showcase the functionality of our AI Tutor. The web app allows users to input their OpenAI API key, upload course materials in text format, and ask questions related to the course content. The web app also provides two buttons on the sidebar: one to delete all uploaded course materials, and another to generate a downloadable Q&A record in HTML format. The web app interface is shown in Figure 3.

Figure 3. The AI Tutor Web App Screenshot

We created a video demo to illustrate the usage and features of our AI Tutor. The video demo shows how a user can upload course materials, ask questions, and view answers from the AI Tutor. The video demo also highlights the naturalness and citation of the answers, as well as the Q&A record generation. The video demo is available at: https://youtu.be/UH0SjqU5tVI?si=cVuBlwdOADq1q7gx.

5 5.2. Q&A Session Demo

To exhibit the capabilities of the AI Tutor in delivering precise and pertinent responses anchored in educational content, we initiated a Q&A session utilizing our web application. We uploaded a trio of pdf documents comprising the course materials for "Finance Theory I" sourced from MIT OpenCourseWare (https://ocw.mit.edu/courses/15-401-financetheory-i-fall-2008/). Our inquiries delved into the core topics of the course, prompting the AI Tutor with questions like, "What are the six principles of finance? Use simple examples to explain to me." The AI Tutor's responses were impressively cogent, drawing directly from the uploaded material, and duly referenced the corresponding sources. This interactive dialogue is visually captured in Figure 4.

Figure 4. An Example of AI Tutor Q&A

From the above Figure 4, we can see that our AI tutor performance have following highlights:

• Accuracy: The AI Tutor's responses were scrutinized for correctness and alignment with the posed questions, ensuring they adhered closely to the factual content of the course material

• Relevance: The pertinence of each answer was assessed, with a keen focus on the alignment with the correct answer, substantiated by direct citations from the related source materials.

• Naturalness: We observed the conversational quality of the AI Tutor's responses, gauging their human-like tone and approachability.

• Citation: The system was particularly evaluated on its ability to accurately cite the specific course materials that informed its answers. For instance, as illustrated in the aforementioned Figure 4, the AI Tutor effectively referenced the section titled 'Lecture 1: Intro and Overview’ in relation to the queried concept.

An essential aspect of our AI Tutor is its commitment to sustained learning. Post each Q&A session, the system allows students to download a comprehensive record of the interaction. This feature is significant in the educational context, offering students the opportunity to revisit the discussion and review the responses at their own pace. The Q&A record serves as a personalized study guide, crafted to address the student's specific queries. It forms a valuable addition to the learner's resources, especially in the context of complex subjects that necessitate repeated engagement and a screenshot of the downloaded Q&A record is shown in Figure 5 below. Looking forward, we propose enhancing the AI Tutor's interactive dimension by incorporating visual aids, such as charts, tables, and diagrams, which could significantly bolster the comprehensibility and engagement of the responses.

Figure 5. An example of generated Q&A record downloaded (in html format)

### 06. Discussion

In this project, we developed an AI tutor that can answer students’ questions based on the course materials uploaded by the instructor. The AI tutor leverages a large language model (LLM) and a retrieval-augmented generation (RAG) technique to generate accurate and natural responses grounded in verified information. We demonstrated the functionality and versatility of our AI tutor through a web app and a video demo. In this section, we will discuss the strengths and weaknesses of our AI tutor, as well as the limitations and challenges of the techniques used in the project. We will also address the potential ethical and societal implications of deploying our AI tutor in educational settings. Finally, we will provide some recommendations for future improvements and extensions to the project.

6.1. Strengths and Weaknesses of the AI Tutor

One of the main strengths of our AI tutor is that it can adapt to any course by using the course-specific materials as the external data source for the RAG technique. This allows the AI tutor to provide tailored responses that are aligned with the course content and objectives. Moreover, the AI tutor can generate high-quality answers in any domain, as long as the domain knowledge documents are available and accessible. Another strength of our AI tutor is that it can produce natural and human-like responses by using the power of the LLM, which is trained on a large corpus of text and can capture the nuances and subtleties of natural language. Furthermore, the AI tutor can handle a variety of questions, such as factual, conceptual, or analytical questions, and provide appropriate citations for the retrieved information.

However, our AI tutor also has some weaknesses that need to be addressed. One of the weaknesses is that the AI tutor is not guaranteed to provide 100% accurate answers, as the LLM may still suffer from information hallucination or inconsistency. Therefore, the AI tutor’s answers should be verified and validated by the instructor or other reliable sources before being accepted as correct. Another weakness is that the AI tutor’s performance depends on the quality and clarity of the student’s question, as well as the availability and relevance of the course materials. If the student’s question is vague, ambiguous, or too broad, the AI tutor may not be able to provide a satisfactory answer. Similarly, if

7 the course materials are incomplete, outdated, or inaccurate, the AI tutor may not be able to retrieve the correct information or may provide misleading or erroneous answers.

6.2. Limitations of the Techniques Used in the Project

The techniques used in the project, namely the LLM and the RAG, also have some limitations and challenges that need to be considered. One of the limitations is that the LLM and the RAG are computationally expensive and require a lot of resources and time to train and run. This may pose a challenge for the scalability and affordability of the AI tutor, especially for low-resource settings or large-scale applications. Another limitation is that the LLM and the RAG are based on statistical models and probabilistic methods, which may not capture the full complexity and diversity of natural language and human knowledge. This may result in some limitations in the expressiveness, interpretability, and explainability of the AI tutor’s answers. Moreover, the LLM and the RAG are still subject to some biases and errors that may affect the quality and reliability of the AI tutor’s answers. For example, the LLM may inherit some social or cultural biases from the training data, or the RAG may retrieve some irrelevant information from the external data source some times.

6.3. Ethical and Societal Implications of Deploying the AI Tutor in Educational Settings

Deploying the AI tutor in educational settings may have some ethical and societal implications that need to be carefully examined and addressed. One of the implications is that the AI tutor may affect the role and relationship of the instructor and the student in the learning process. The AI tutor may complement or supplement the instructor’s teaching, but it may also replace or undermine the instructor’s authority or expertise. Similarly, the AI tutor may enhance or facilitate the student’s learning, but it may also impair or discourage the student’s critical thinking or creativity. Therefore, the AI tutor should be used as a tool or a resource, not as a substitute or a replacement, for the instructor or the student. Another implication is that the AI tutor may raise some privacy and security issues regarding the data collection and usage in the project. The AI tutor may collect and use some personal or sensitive data from the instructor or the student, such as the course materials, the questions, or the answers. This may pose some risks of data leakage, misuse, or abuse, which may violate the privacy or confidentiality of the instructor or the student. Therefore, the AI tutor should follow some ethical principles and guidelines, such as transparency, consent, accountability, and fairness, to ensure the data protection and respect of the instructor or the student.

6.4. Recommendations for Future Improvements

Based on the discussion above, we can provide some recommendations for future improvements and extensions to the project. One of the recommendations is to reduce the cost of the AI tutor by exploring some alternative options for the LLM and the RAG, such as open-source or low-resource models, or by using some third-party frameworks and libraries, such as Langchain or Chroma, to reduce the implementation costs. Another recommendation is to improve the user interface design of the AI tutor to enhance the user engagement and satisfaction, such as by adding some interactive or personalized features, such as feedback and user profile. A third recommendation is to implement more scalable solutions for the AI tutor, such as by using some cloud-based or distributed platforms, such as Google Cloud or Azure, to increase the availability and accessibility of the AI tutor. A fourth recommendation is to investigate the feasibility of automated quiz generation for the AI tutor, such as by using the context of course material to provide some formative assessment for the student’s learning.

### 07. Conclusion

This paper introduced AI Tutor, a web application at the forefront of educational technology, utilizing the latest advancements in artificial intelligence to provide tailored tutoring for any course. The AI Tutor is underpinned by the most recent OpenAI Assistants API, released in November 2023, and is powered by the most sophisticated iteration of the GPT-4 model, ensuring that our system is both cutting-edge and robust. The innovation of AI Tutor resides in its unique ability to digest and utilize course materials provided by educators, forming an adaptable vector knowledge base. When a student poses a query, the system first employs vector similarity search to identify the most relevant

8 information within this specialized database. It then applies a powerful generative model to articulate responses that are not only accurate and contextually relevant but also enriched with citations from the source material. The evaluations reveal AI Tutor's effectiveness in producing relevant, factually consistent responses, showcasing the promise of integrating sophisticated LLMs with retrieval. This underscores AI Tutor's evolution beyond limitations of prior rule-based tutoring systems.

However, real-world deployment necessitates further enhancements, particularly in scalability. While the current prototype uses Streamlit's community cloud, migration to robust commercial platforms like Microsoft Azure or Google Cloud could strengthen stability for large-scale usage. Additional priorities include boosting interpretability, ethical rigor, and conducting user studies to gauge pedagogical impact. In essence, AI Tutor represents an important milestone in harnessing AI's benefits for education through an accessible, interactive platform. It lays a foundation for a new generation of intelligent tutors that can empower learners with personalized support tailored to their academic journeys. Realizing the full potential of such systems will require sustained research and responsible development. But the possibilities glimpsed by this initial effort highlight the transformative promise of AI in augmenting how we teach and learn.

### References

Brown, T., Mann, B., Ryder, N., Subbiah, M., Kaplan, J. D., Dhariwal, P., ... & Amodei, D. (2020). Language models are few-shot learners. Advances in neural information processing systems, 33, 1877-1901.

Cai, D., Wang, Y., Liu, L., & Shi, S. (2022, July). Recent advances in retrieval-augmented text generation. In Proceedings of the 45th International ACM SIGIR Conference on Research and Development in Information Retrieval (pp. 3417-3419).

Chang, Y., Wang, X., Wang, J., Wu, Y., Zhu, K., Chen, H., ... & Xie, X. (2023). A survey on evaluation of large language models. arXiv preprint arXiv:2307.03109.

Devlin, J., Chang, M. W., Lee, K., & Toutanova, K. (2018). Bert: Pre-training of deep bidirectional transformers for language understanding. arXiv preprint arXiv:1810.04805.

Gan, W., Sun, Y., Ye, S., Fan, Y., & Sun, Y. (2019, October). AI-tutor: Generating tailored remedial questions and answers based on cognitive diagnostic assessment. In 2019 6Th international conference on behavioral, economic and socio-cultural computing (BESC) (pp. 1-6). IEEE.

Gromyko, V. I., Kazaryan, V. P., Vasilyev, N. S., Simakin, A. G., & Anosov, S. S. (2017, August). Artificial intelligence as tutoring partner for human intellect. In International Conference of Artificial Intelligence, Medical Engineering, Education (pp. 238-247). Cham: Springer International Publishing.

Jaques, P. A., Seffrin, H., Rubi, G., de Morais, F., Ghilardi, C., Bittencourt, I. I., & Isotani, S. (2013). Rule-based expert systems to support step-by-step guidance in algebraic problem solving: The case of the tutor PAT2Math. Expert Systems with Applications, 40(14), 5456-5465. https://doi.org/10.1016/j.eswa.2013.04.008

Kasneci, E., Seßler, K., Küchemann, S., Bannert, M., Dementieva, D., Fischer, F., … & Kasneci, G. (2023). ChatGPT for good? On opportunities and challenges of large language models for education. Learning and individual differences, 103, 102274. https://doi.org/10.1016/j.lindif.2023.102274

Lewis, M., Storks, S., & Zettlemoyer, L. (2020). Hallucination in neural machine translation. In Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing: Findings (pp. 3818-3833).

Lewis, P., Perez, E., Piktus, A., Petroni, F., Karpukhin, V., Goyal, N., ... & Kiela, D. (2020). Retrieval-augmented generation for knowledge-intensive nlp tasks. Advances in Neural Information Processing Systems, 33, 9459-9474.

Moore, S., Tong, R., Singh, A., Liu, Z., Hu, X., Lu, Y., … & Stamper, J. (2023, June). Empowering education with llms-the next-gen interface and content generation. In International Conference on Artificial Intelligence in Education (pp. 32-37). Cham: Springer Nature Switzerland. https://doi.org/10.1007/978-3-030-78270-2_6

Nye, B., Mee, D., & Core, M. G. (2023). Generative large language models for dialog-based tutoring: An early consideration of opportunities and concerns. In AIED Workshops.

OpenAI (2023). GPT-4 Technical Report. ArXiv, abs/2303.08774.

Shin, A., Lee, J., & Kang, J. (2020). How to train your GPT-2: A step by step guide to training large language models. arXiv preprint arXiv:2004.10964.