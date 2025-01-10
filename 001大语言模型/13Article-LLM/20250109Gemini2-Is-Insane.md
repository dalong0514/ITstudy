## 20250109Gemini2-Is-Insane

Gemini 2.0 Is Insane

Andrew Zuo

2025-01-04

On December 11 Google announced Gemini 2.0, the next version of their AI, with very little fanfare. The post doesn’t say a lot and is filled with buzzwords. They call it an ‘AI for the Agentic Era’.

12 月 11 日，谷歌发布了其下一代 AI 模型 Gemini 2.0，但并未引起广泛关注。这篇公告内容简短，且充斥着各种时髦的术语。他们称其为「为 Agentic Era（智能体时代）而生的 AI」。

And they just keep on talking about things that are built on top of Gemini 2.0, rather than Gemini 2.0 itself. The only thing they really showed about Gemini 2.0 is this table.

他们一直在讨论基于 Gemini 2.0 构建的应用，而不是 Gemini 2.0 本身。关于 Gemini 2.0，他们真正展示的只有这张表格。

Fig: Gemini 2.0 table

Pretty good. Except that long context. Worse than 1.5 Flash? Ouch. Although to be fair it’s not that much worse.

表现良好。但在处理长上下文时，性能比 1.5 Flash 还要差？令人惊讶。但实际上，差距并没有那么大。

Oh, and that’s another thing. Only Gemini 2.0 Flash, no Gemini 2.0 Pro. Interesting. Wasn’t there supposed to be a Gemini Ultra too? It’s reminiscent of when Anthropic released 3.5 Sonnet and 3.5 Haiku but not 3.5 Opus. Must be getting more difficult to scale these models up.

另外，值得注意的是，只有 Gemini 2.0 Flash，没有 Gemini 2.0 Pro。值得关注的是。不是应该还有 Gemini Ultra 吗？这让人想起 Anthropic 发布 3.5 Sonnet 和 3.5 Haiku，却没有发布 3.5 Opus 的情况。扩展这些模型的规模想必变得越来越困难了。

So combined with reports specifically calling out how LLMs have plateaued, including Gemini 2.0, I was expecting to be pretty disappointed by Gemini 2.0.

考虑到一些报告，特别是那些指出包括 Gemini 2.0 在内的大语言模型（LLM）已进入瓶颈期的报告，我原本以为我对 Gemini 2.0 会相当失望。

But then I actually tried it and… well…

但当我实际试用之后…… 嗯……

First some context. I have to be honest with you, since the arrival of ChatGPT using GPT-3.5 Turbo I have not seen much of an improvement between AI models. GPT-3.5 Turbo feels the same as GPT-4 which feels the same as GPT-4o Mini which feels the same as GPT-4o which feels the same as Gemini and Llama and Claude.

首先是一些背景信息。我必须坦诚地告诉你，自从 ChatGPT 使用 GPT-3.5 Turbo 以来，我感觉 AI 模型之间没有太大改进。GPT-3.5 Turbo 给我的感觉和 GPT-4 差不多，而 GPT-4、GPT-4o Mini、GPT-4o、Gemini、Llama 和 Claude 这些模型给我的感觉也大同小异。

People keep on saying how Claude is so much better than GPT-4o. I think it’s just the placebo effect. I have never noticed any improvement in Claude’s answers over GPT-4o. They have the exact same content, sometimes even using the same headings. In fact I much prefer GPT-4o’s output because Claude has a tendency to put its response in point form and then I have to be like, “Can you expand on those points?”

人们总是说 Claude 比 GPT-4o 要好得多。我认为这可能只是一种主观的安慰剂效应。我从未发现 Claude 的回答比 GPT-4o 有任何提升，它们的内容几乎完全一致，有时甚至连标题都相同。事实上，我更倾向于 GPT-4o 的输出，因为 Claude 往往会以要点形式给出回复，之后我不得不要求它「详细阐述这些要点」。

I haven’t really noticed any improvement in LLMs since GPT-3.5 Turbo. Heck, even GPT-3 was pretty good.

自从 GPT-3.5 Turbo 之后，我感觉大语言模型（LLM）并没有什么明显的进步。实际上，即使是 GPT-3 也已经很出色了。

Actually, maybe that’s a bit of an overstatement. There has been one improvement: multimodal. Gemini Live and GPT’s voice mode. However my experience with multimodal comes from PDF summarization. Although it’s not just PDFs:

实际上，也许我刚才的说法有点夸大其词。确实有一项改进：多模态。例如 Gemini Live 和 GPT 的语音模式。我对多模态的体验主要来自 PDF 摘要功能。不过，它不仅仅限于 PDF。

And this opens up the doors for future additions. You probably noticed application/pdf. Interesting, what Mime types are supported by Gemini? Images (like image/png), Video (like video/mp4), and Audio (like audio/aac). So with this system I could do things like improve the YouTube summarization even further. It would take longer, but it could work as a fallback if no subtitles are available.

这为未来功能的增加提供了可能。你可能已经注意到，还支持 application/pdf 这种类型。值得注意的是，Gemini 支持的 MIME 类型包括哪些呢？图像（如 image/png)、视频（如 video/mp4）和音频（如 audio/aac）。有了这个系统，我们可以进一步改进 YouTube 摘要。虽然耗时更长，但如果字幕缺失，它可以作为一种有效的备选方案。

Multimodal is great, but there hasn’t really been any improvement since multimodal, at least for me. There is function calling but if you have the result returned as JSON you can do it yourself. I haven’t really needed it. I suspect it will get big eventually because it allows richer virtual assistants but that hasn’t happened yet.

多模态技术很棒，但至少对我来说，自从多模态出现后，似乎并没有什么实质性的进步。虽然有函数调用功能，但如果返回的结果是 JSON 格式，其实你自己也能实现。我目前还不太需要这个功能。我猜测，它最终会变得非常重要，因为它能带来更强大的虚拟助手，但这目前还尚未成为现实。

I don’t think function calling will be the next big thing. I think text to speech will be. Because text to speech has historically been insanely expensive, costing a cent per thousand characters. That means reading this article with TTS would cost you a few cents. But that could be changing. Because, what’s that? Gemini 2.0 Flash supports speech output:

我不认为函数调用（function calling）会是下一个重大进展。我认为文本转语音（text to speech）会是。因为文本转语音在历史上一直非常昂贵，每处理一千个字符就需要花费一美分。这意味着使用 TTS（text to speech）阅读这篇文章将花费您几美分。但这可能会发生改变。因为，这是什么？Gemini 2.0 Flash 支持语音输出：

Yes, Gemini 2.0 Flash is the first major LLM to support text to speech. And I’m sure many more will follow. And that’s not the only thing; I discovered this when I went to the Gemini 2.0 Flash API page.

Gemini 2.0 Flash 是首个支持文本转语音功能的大语言模型（LLM）。我确信未来会有更多的大语言模型会具备类似的功能。我在浏览 Gemini 2.0 Flash API 页面时还发现，它的功能远不止于此。

1 Multimodal Live API: This new API helps you create real-time vision and audio streaming applications with tool use.

多模态实时 API：这项新的 API 可以帮助你创建具备工具调用的实时视觉和音频流应用。

2 Speed and performance: Gemini 2.0 has a significantly improved time to first token (TTFT) over 1.5 Flash.

速度和性能：Gemini 2.0 的首个 Token 生成时间（Time To First Token，TTFT）相比 1.5 Flash 有了显著的提升。

3 Quality: Better performance across most benchmarks than Gemini 1.5 Pro.

质量：在多数性能评测中，Gemini 2.0 的表现都优于 Gemini 1.5 Pro。

4 Improved agentic capabilities: Gemini 2.0 delivers improvements to multimodal understanding, coding, complex instruction following, and function calling.

改进的 AI 智能体（AI Agent）能力：Gemini 2.0 在多模态理解、代码编写、复杂指令执行和函数调用方面都得到了增强。

5 New modalities: Gemini 2.0 introduces native image generation and controllable text-to-speech capabilities.

新的模态：Gemini 2.0 增加了原生的图像生成和可控制的文本转语音功能。

This is all very exciting and I’m bewildered how this did not make it into the main blog post. But whatever, it’s here now.

这一切都非常令人兴奋，我感到很奇怪，为什么这些内容没有被包含在主要的博客文章中。但不管怎样，它现在已经在这里了。

Now I will say most of this stuff is not available yet. The TTS API as well as the image generation API have not been set up. And I’m not sure how to get it to create images. But what I have seen is very impressive.

现在需要说明的是，这里提到的大部分功能目前还无法使用。文本转语音（TTS）API 以及图像生成 API 都尚未完成配置。而且，我还不清楚如何让它生成图像。但是，我目前所看到的效果已经非常令人印象深刻了。

The easiest way to try Gemini 2.0 Flash is to go to AI Studio and make sure Gemini 2.0 Flash is selected. Although keep in mind AI Studio is not designed as a competitor for the web interface of ChatGPT, Claude, and others. It does not have as robust of a conversation history.

尝试 Gemini 2.0 Flash 最简单的方法是前往 AI Studio 并确保已选择 Gemini 2.0 Flash 。需要注意的是，AI Studio 的设计目的不是为了与 ChatGPT、Claude 等的网页版界面竞争。它不具备那么完善的对话历史记录功能。

But you can use it for experimenting which I did. For example this question:

但是你可以用它进行实验，正如我所做的那样。例如这个问题：

I heard on a podcast that many institutions that say they are FDIC/CDIC insured are actually not. Is this true?

我从播客中了解到，许多声称自己受 FDIC/CDIC 保险的机构，实际上并非如此。这是真的吗？

This is what Gemini 1.5 Pro gave me:

The statement that “many institutions that say they are FDIC/CDIC insured are actually not” is highly misleading and likely false. It’s important to understand how deposit insurance works and how to verify it.

「许多机构声称其存款受 FDIC/CDIC 保险，但实际上并非如此」的说法极具误导性，而且很可能不实。重要的是，我们需要理解存款保险的运作机制，并掌握如何验证其有效性。

It then goes on to explain why this could actually be true. So the introductory paragraph is a bit misleading.

接下来，文章会进一步解释为什么这种情况实际上可能成立。因此，引言部分有些误导。

Here’s what Flash 2.0 said:

Flash 2.0 是这样说的：

That’s a very concerning claim, and it’s important to understand the nuances. The short answer is: It’s highly unlikely that a legitimate, regulated financial institution will falsely claim FDIC or CDIC insurance. However, there are ways that confusion and even misrepresentation can occur, which could lead someone to believe they’re insured when they aren’t. Let’s break down the potential scenarios:

这个说法确实让人非常担心，所以理解其中的微妙之处至关重要。简单来说，一家正规的、受监管的金融机构不太可能谎称自己拥有 FDIC 或 CDIC 保险。然而，确实存在可能导致混淆甚至误导的情况，让人们误以为自己受到了保险保障，而实际上并非如此。下面我们来分析一下可能出现的几种情况：

Much more balanced acknowledging that there is some confusion in this area. And it brings up Fintech companies and crypto in its answer later, something that Gemini 1.5 Pro completely ignores. So, yes, I’d say Gemini 2.0 Flash is significantly better and more comprehensive. Gemini 1.5 Pro sounds very generic.

更平衡地承认了这一领域的混乱。而且，它在随后的回答中提到了金融科技公司和加密货币，而 Gemini 1.5 Pro 完全没有提及这一点。因此，我认为 Gemini 2.0 Flash 明显更好，也更全面。Gemini 1.5 Pro 的回答显得过于笼统。

Another way to test Gemini 2.0 Flash is to use the API. I was a little surprised that the API is already set up. When Gemini 1.0 was announced it took forever to get API access and it wasn’t available in Canada yet, I only got access to it when I flew to Mexico. Not that I’m complaining, Oaxaca is wonderful.

测试 Gemini 2.0 Flash 的另一种方法是使用应用程序接口（API）。令我有些意外的是，API 竟然已经可以使用了。记得 Gemini 1.0 发布时，API 访问权限的开通等待了很久，而且当时在加拿大还无法使用。我还是在飞去墨西哥之后才获得访问权限的。当然我不是在抱怨，瓦哈卡确实很棒。

But with Gemini 2.0 Flash the API is already available, just change the model you use to gemini-2.0-flash-exp. The API, however, is a bit of a mixed bag. At first when I used it it was fairly slow, much slower than 1.5 Flash. However I suspect that Google is adding servers or something because it’s reasonably fast now, competitive with 1.5 Flash. It still fails occasionally though.

但是，Gemini 2.0 Flash 的 API 已经开放，只需将使用的模型更改为 gemini-2.0-flash-exp 即可。不过，这个 API 的表现有好有坏。刚开始使用时，速度相当慢，比 1.5 Flash 慢得多。但我猜测 Google 可能在增加服务器等资源，现在速度已经相当快，可以与 1.5 Flash 相媲美。但它仍然会偶尔出现故障。

Although to tell you the truth the responses are pretty much the same as Gemini 1.5 Flash. I guess it makes sense, I didn’t change the prompts at all. Also I have noticed that Gemini 2.0 Flash is not as good at indenting JSON.

不过坦白说，这些回应结果和 Gemini 1.5 Flash 几乎相同。这很正常，因为我完全没有修改提示。而且我注意到，Gemini 2.0 Flash 在 JSON 缩进方面的表现不如以前。

Update: this was happening a few days ago but I am unable to reproduce it, although sometimes it is missing a space after colons here and there. I guess Google must be updating the Gemini 2.0 Flash model in real time.

更新：这种情况前几天出现过，但现在我无法复现了。虽然偶尔在冒号后会零星地缺少空格。我猜想 Google 应该是在实时更新 Gemini 2.0 Flash 模型。

I’m very excited for Gemini 2.0 Flash. It’s a bit unfortunate that 2.0 Flash’s output when using my custom prompts does not appear to be any better than 1.5 Flash. But that’s not too big of an issue, just make better prompts.

我对 Gemini 2.0 Flash 抱有很高的期待。不过，令人稍感遗憾的是，在使用我的自定义提示时，Gemini 2.0 Flash 的输出结果似乎并没有比 1.5 Flash 有显著提升。但这并非主要问题，可以通过优化提示来解决。

What is an improvement is the API of 2.0 Flash. With audio output and input and image generation. 2.0 Flash is just much more capable than 1.5 Flash. I’m currently working on Tejido, an email app, that I don’t anticipate to benefit that much from Gemini 2.0 Flash. But after Tejido I’ll probably start to experiment with the Gemini Live-like API in Litany. And who knows, if it goes well maybe I might integrate it into more apps.

2.0 Flash 的 API 有所改进，它支持音频的输入和输出，以及图像的生成。2.0 Flash 的能力远超 1.5 Flash 。我目前正在开发一款名为 Tejido 的电子邮件应用，预计它不会从 Gemini 2.0 Flash 中获得显著的提升。但在 Tejido 之后，我可能会在 Litany 中尝试类似 Gemini Live 的 API。如果进展顺利，我可能会考虑将其集成到更多的应用中。

You know one of the ideas for Tejido was a digital assistant for your email. I wasn’t really sure how I’d pull it off and shelved the idea. But with Gemini 2.0 Flash that idea sounds much more possible now. Imagine talking to Google Gemini about your email. That would be, as pretentious as it sounds, an AI for the Agentic Era.

你知道，Tejido 的一个最初的设想是开发一个帮你处理电子邮件的数字助理。当时我不太确定如何实现，就暂时搁置了。但现在有了 Gemini 2.0 Flash，这个想法似乎变得更可行了。试想一下，你可以直接和 Google Gemini 交流你的邮件内容。虽然听起来有些自命不凡，但这确实可以称得上是「智能体时代」的 AI 了。

## 原文

Gemini 2.0 Is Insane

Andrew Zuo

2025-01-04

On December 11 Google announced Gemini 2.0, the next version of their AI, with very little fanfare. The post doesn’t say a lot and is filled with buzzwords. They call it an ‘AI for the Agentic Era’.

Stop trying to make agentic happen
And they just keep on talking about things that are built on top of Gemini 2.0, rather than Gemini 2.0 itself. The only thing they really showed about Gemini 2.0 is this table.

Gemini 2.0 table
Pretty good. Except that long context. Worse than 1.5 Flash? Ouch. Although to be fair it’s not that much worse.

Oh, and that’s another thing. Only Gemini 2.0 Flash, no Gemini 2.0 Pro. Interesting. Wasn’t there supposed to be a Gemini Ultra too? It’s reminiscent of when Anthropic released 3.5 Sonnet and 3.5 Haiku but not 3.5 Opus. Must be getting more difficult to scale these models up.

So combined with reports specifically calling out how LLMs have plateaued, including Gemini 2.0, I was expecting to be pretty disappointed by Gemini 2.0.

But then I actually tried it and… well…

First some context. I have to be honest with you, since the arrival of ChatGPT using GPT-3.5 Turbo I have not seen much of an improvement between AI models. GPT-3.5 Turbo feels the same as GPT-4 which feels the same as GPT-4o Mini which feels the same as GPT-4o which feels the same as Gemini and Llama and Claude.

People keep on saying how Claude is so much better than GPT-4o. I think it’s just the placebo effect. I have never noticed any improvement in Claude’s answers over GPT-4o. They have the exact same content, sometimes even using the same headings. In fact I much prefer GPT-4o’s output because Claude has a tendency to put its response in point form and then I have to be like, “Can you expand on those points?”

This is something I’ve been saying a lot: the intelligence of an LLM doesn’t really matter. What matters more is how well the responses are tuned. And Claude’s responses are pretty terrible.

I haven’t really noticed any improvement in LLMs since GPT-3.5 Turbo. Heck, even GPT-3 was pretty good.

Actually, maybe that’s a bit of an overstatement. There has been one improvement: multimodal. Gemini Live and GPT’s voice mode. However my experience with multimodal comes from PDF summarization. Although it’s not just PDFs:

And this opens up the doors for future additions. You probably noticed application/pdf. Interesting, what Mime types are supported by Gemini? Images (like image/png), Video (like video/mp4), and Audio (like audio/aac). So with this system I could do things like improve the YouTube summarization even further. It would take longer, but it could work as a fallback if no subtitles are available.

Multimodal is great, but there hasn’t really been any improvement since multimodal, at least for me. There is function calling but if you have the result returned as JSON you can do it yourself. I haven’t really needed it. I suspect it will get big eventually because it allows richer virtual assistants but that hasn’t happened yet.

I don’t think function calling will be the next big thing. I think text to speech will be. Because text to speech has historically been insanely expensive, costing a cent per thousand characters. That means reading this article with TTS would cost you a few cents. But that could be changing. Because, what’s that? Gemini 2.0 Flash supports speech output:

Capabilities of Gemini 2.0 Flash
Yes, Gemini 2.0 Flash is the first major LLM to support text to speech. And I’m sure many more will follow. And that’s not the only thing; I discovered this when I went to the Gemini 2.0 Flash API page.

- Multimodal Live API: This new API helps you create real-time vision and audio streaming applications with tool use.
- Speed and performance: Gemini 2.0 has a significantly improved time to first token (TTFT) over 1.5 Flash.
- Quality: Better performance across most benchmarks than Gemini 1.5 Pro.
- Improved agentic capabilities: Gemini 2.0 delivers improvements to multimodal understanding, coding, complex instruction following, and function calling.
- New modalities: Gemini 2.0 introduces native image generation and controllable text-to-speech capabilities.

This is all very exciting and I’m bewildered how this did not make it into the main blog post. But whatever, it’s here now.

Now I will say most of this stuff is not available yet. The TTS API as well as the image generation API have not been set up. And I’m not sure how to get it to create images. But what I have seen is very impressive.

The easiest way to try Gemini 2.0 Flash is to go to AI Studio and make sure Gemini 2.0 Flash is selected. Although keep in mind AI Studio is not designed as a competitor for the web interface of ChatGPT, Claude, and others. It does not have as robust of a conversation history.

But you can use it for experimenting which I did. For example this question:

I heard on a podcast that many institutions that say they are FDIC/CDIC insured are actually not. Is this true?

This is what Gemini 1.5 Pro gave me:

The statement that “many institutions that say they are FDIC/CDIC insured are actually not” is highly misleading and likely false. It’s important to understand how deposit insurance works and how to verify it.

It then goes on to explain why this could actually be true. So the introductory paragraph is a bit misleading.

Here’s what Flash 2.0 said:

That’s a very concerning claim, and it’s important to understand the nuances. The short answer is: It’s highly unlikely that a legitimate, regulated financial institution will falsely claim FDIC or CDIC insurance. However, there are ways that confusion and even misrepresentation can occur, which could lead someone to believe they’re insured when they aren’t. Let’s break down the potential scenarios:

Much more balanced acknowledging that there is some confusion in this area. And it brings up Fintech companies and crypto in its answer later, something that Gemini 1.5 Pro completely ignores. So, yes, I’d say Gemini 2.0 Flash is significantly better and more comprehensive. Gemini 1.5 Pro sounds very generic.

Another way to test Gemini 2.0 Flash is to use the API. I was a little surprised that the API is already set up. When Gemini 1.0 was announced it took forever to get API access and it wasn’t available in Canada yet, I only got access to it when I flew to Mexico. Not that I’m complaining, Oaxaca is wonderful.

But with Gemini 2.0 Flash the API is already available, just change the model you use to gemini-2.0-flash-exp. The API, however, is a bit of a mixed bag. At first when I used it it was fairly slow, much slower than 1.5 Flash. However I suspect that Google is adding servers or something because it’s reasonably fast now, competitive with 1.5 Flash. It still fails occasionally though.

Although to tell you the truth the responses are pretty much the same as Gemini 1.5 Flash. I guess it makes sense, I didn’t change the prompts at all. Also I have noticed that Gemini 2.0 Flash is not as good at indenting JSON.

Update: this was happening a few days ago but I am unable to reproduce it, although sometimes it is missing a space after colons here and there. I guess Google must be updating the Gemini 2.0 Flash model in real time.

I’m very excited for Gemini 2.0 Flash. It’s a bit unfortunate that 2.0 Flash’s output when using my custom prompts does not appear to be any better than 1.5 Flash. But that’s not too big of an issue, just make better prompts.

What is an improvement is the API of 2.0 Flash. With audio output and input and image generation. 2.0 Flash is just much more capable than 1.5 Flash. I’m currently working on Tejido, an email app, that I don’t anticipate to benefit that much from Gemini 2.0 Flash. But after Tejido I’ll probably start to experiment with the Gemini Live-like API in Litany. And who knows, if it goes well maybe I might integrate it into more apps.

You know one of the ideas for Tejido was a digital assistant for your email. I wasn’t really sure how I’d pull it off and shelved the idea. But with Gemini 2.0 Flash that idea sounds much more possible now. Imagine talking to Google Gemini about your email. That would be, as pretentious as it sounds, an AI for the Agentic Era.