## 20240908No-Priors-Ep80-With-Andrejj-Karpathy-from-OpenAI-and-Tesla

[No Priors Ep. 80 | With Andrejj Karpathy from OpenAI and Tesla - YouTube](https://www.youtube.com/watch?v=hM_h0UA7upI)

Here's an outline of the key points from the interview，following the Minto Pyramid principle，in Chinese:

\# 与 Andrejj Karpathy 的对话要点

\## 主要观点：AI 正在改变教育和人类认知的未来

\### 1. AI 在自动驾驶领域的进展

Waymo 和 Tesla 在自动驾驶技术上各有优势

自动驾驶技术从演示到大规模应用需要时间

Tesla 的软件优势可能使其在长期占据优势

\### 2. 人形机器人的发展前景

人形机器人与汽车技术有很多共通之处

人形设计有利于人机交互和数据收集

初期应用可能集中在工业和 B2B 领域

\### 3. AI 模型的发展趋势

Transformer 架构是一个重要突破

模型规模可能会缩小，专注于认知核心

未来可能出现多个专门化 AI 模型协作的「公司」结构

\### 4. AI 对教育的影响

AI 可以提供个性化、全球化的教育体验

教育者角色将转变为课程设计者，AI 成为学生接口

人类学习潜力可能被大幅提升

\### 5. 对未来教育和职业发展的建议

数学、物理、计算机科学等基础学科仍然重要

终身学习将成为常态

教育重点应放在培养思维能力上，而非记忆知识

结论：AI 将深刻改变教育模式和人类认知能力，但人类仍需主动学习和适应以保持竞争力。

### 01

Hi, listeners. Welcome back to No Priors. Today, we're hanging out with Andrej Karpathy, who needs no introduction. Andrej is a renowned researcher, beloved AI educator and Cuber, an early team member from OpenAI, the lead for Autopilot at Tesla, and now working on AI for Education. We'll talk to him about the state of research, his new company, and what we can expect from AI. Thanks a lot for joining us today. It's great to have you here.

Thank you, I'm happy to be here. 

You led autopilot at Tesla, and now we actually have fully self-driving cars, passenger vehicles on the road. How do you read that in terms of where we are in the capability set, how quickly we should see increased capability or pervasive passenger vehicles?

Yeah, so I spent maybe five years on self-driving space. I think it's a fascinating space. And basically what's happening in the field right now is, well, I do also think that I draw a lot of analogies, I would say, to AGI from self-driving, and maybe that's just because I'm familiar with it. But I kind of feel like we've reached AGI a little bit in self-driving, because there are systems today that you can basically take around, and as a paying customer, can take around here.

So Waymo in San Francisco here is, of course, very common. Probably you've taken Waymo, I've taken it a bunch, and it's amazing, and it can drive you all over the place, and you're paying for it as a product. What's interesting with Waymo is the first time I took Waymo was actually a decade ago, almost exactly, 2014 or so. And it was a friend of mine who worked there and he gave me a demo. And it drove me around the block 10 years ago, and it was basically perfect drive 10 years ago. And it took 10 years to go from like a demo that I had to a product I can pay for that's in the city scale and is expanding, et cetera.

How much of that do you think was regulatory versus technology? Like when do you think the technology was ready? Is it recent or-

I think it's technology. You're just not seeing it in a single demo drive of 30 minutes. You're not running into all the stuff that they had to deal with for a decade. And so demo and product, there's a massive gap there. And I think a lot of it also regulatory, et cetera. But I do think that we've sort of achieved AGI in the self-driving space in that sense a little bit. And yet, I think there's, what's really fascinating about it is the globalization hasn't happened at all. So you have a demo and you can take it in SF, but the world hasn't changed yet. And that's going to take a long time. And so going from a demo to an actual globalization of it, I think there's a big gap there. That's how it's related, I would say, to AGI, because I suspect it looks in a similar way for AGI when we sort of get it.

And then staying for a minute in the self-driving space, I think people think that Waymo is ahead of Tesla. I think personally Tesla is ahead of Waymo and I know it doesn't look like that, but I'm still very bullish on Tesla and its self-driving program. I think that Tesla has a software problem and I think Waymo has a hardware problem is the way I put it. And I think software problems are much easier. Tesla has a deployment of all these cars on earth, like at scale. And I think Waymo needs to get there. And so the moment Tesla sort of like gets to the point where they can actually deploy this and it actually works, I think it's going to be, you know, really incredible. The latest builds I just drove yesterday, I mean, it's just driving me all over the place now. They've made like really good improvements, I would say very recently.

Yeah, I've been using it a lot recently and it actually works quite well. It did some miraculous driving for me yesterday, so I'm very impressed with what the team is doing. And so I still think that Tesla mostly has a software problem, Waymo mostly hardware problem. And so I think Tesla, Waymo looks like it's winning kind of right now. But I think when we look in 10 years and who's actually at scale and where most of the revenue is coming from, I still think they're ahead in that sense.

How far away do you think we are from the software problem turning the corner in terms of getting to some equivalency? Because obviously, to your point, if you look at a way my car has a lot of very expensive LiDAR and other sort of sensors built into the car so it can do what it does, it sort of helps support the software system. And so if you could just use cameras, which is the Tesla approach, then you effectively get rid of enormous costs slash complexity, and you can do it in many different types of cars. When do you think that transition happens?

I mean, in the next few years, I'm hoping it'll like something like that, but actually what's really interesting about that is I'm not sure that people are appreciating that. Tesla actually does use a lot of expensive sensors. They just do it at training time. So there are a bunch of cars that drive around with LIDARs. They do a bunch of stuff that like doesn't scale and they have extra sensors, et cetera, and they do mapping and all the stuff. You're doing it at training time and then you're distilling that into a test time package that gets deployed to the cars and is vision only. And it's like an arbitrage on sensors and expense. And so I think it's actually kind of a brilliant strategy that I don't think is fully appreciated. And I think it's going to work out well because the pixels have the information and I think the network will be capable of doing that. And yes, at training time, I think these sensors are really useful, but I don't think they're as useful at test time. And I think you can, you know.

It seems like the one other thing or transition that's happened is basically a move from a lot of sort of edge case designed heuristics associated with it versus end-to-end deep learning. And that's what other shift that's happened recently. Do you want to talk a little bit about that and sort of what that?

Yeah, I think that was always like the plan from the start, I would say at Tesla, as I was talking about how the neural net can like eat through the stack because when I joined there was a ton of C++ code and now there's much much less C++ code in the test time package that runs in the car because there's still a ton of stuff in the back end that we're not talking about the neural net kind of like takes takes through the system so first it just does like a detection on the image level. Then it does multiple images, gives you prediction. Then multiple images over time give you a prediction and you're discarding C++ code. And eventually you're just giving steering commands. And so I think Tesla is kind of eating through the stack.

My understanding is that current Waymo's are actually like not that, but that they've tried, but they ended up like not doing that is my current understanding, but I'm not sure because they don't talk about it. But I do fundamentally believe in this approach and I think that's the last piece to fall if you want to think about it that way and I do suspect that the end-to-end systems for Tesla in like say 10 years it is just a neural net I mean the videos stream into a neural net and commands come out you have to sort of build to build up to it incrementally and do it piece by piece. And even all the intermediate predictions and all those things that we've done, I don't think they've actually misled the development. I think they're part of it because there's a lot of subtle reasons for this.

So actually, like end-to-end driving, when you're just imitating humans and so on, you have very few bits of supervision to train a massive neural net. And it's too few bits of signal to train so many billions of parameters. And so these intermediate representations and so on help you develop the features and the detectors for everything. And then it makes it a much easier problem for the end-to-end part of it. And so I suspect, although I don't know because I'm not part of the team, but there's a ton of pre-training happening so that you can do the fine-tuning for end-to-end. And so basically, I feel like it was necessary to eat through it incrementally, and that's what Tesla has done. I think it's the right approach, and it looks like it's working.

大家好，欢迎收听 No Priors。今天，我们邀请到了一位重量级嘉宾 Andrej Karpathy。作为一位著名的研究员，他不仅是备受推崇的 AI 教育工作者和魔方爱好者，还是 OpenAI 的早期团队成员，曾担任 Tesla 自动驾驶部门的负责人，目前正致力于 AI 教育领域的工作。我们将与他探讨当前的研究状况、他的新公司，以及 AI 未来的发展前景。Andrej，非常感谢你今天能来做客。

谢谢邀请，很高兴来到节目。

你曾在 Tesla 领导自动驾驶项目，如今我们已经看到完全自动驾驶的乘用车在道路上行驶。从技术能力的角度来看，你如何评估我们目前所处的阶段？我们应该以怎样的速度来期待这项技术的能力提升和乘用车的普及？

确实，我在自动驾驶领域投入了大约五年的时间。这是一个非常令人着迷的领域。目前，这个领域正在发生的事情很有趣。我经常会把自动驾驶与通用人工智能（AGI）进行类比，可能是因为我对这个领域特别熟悉。我认为在某种程度上，我们已经在自动驾驶领域实现了一定程度的通用人工智能，因为现在已经有了可以供付费用户实际使用的自动驾驶系统，能够在城市中自如行驶。

在旧金山，Waymo 自动驾驶已经成为一种常见的出行方式。我相信你可能也体验过，我自己就搭乘过很多次。这项技术确实令人惊叹，可以自动驾驶带你去任何地方，而且已经实现了商业化运营。有趣的是，我第一次体验 Waymo 是在将近十年前，大约 2014 年。当时是我一位在 Waymo 工作的朋友安排的技术演示。即便是在十年前，它就能完美地完成环区域的自动驾驶演示。然而，从那次技术演示到现在这个覆盖整个城市且仍在不断扩张的商用产品，整整经历了十年的发展历程。

这个过程中，你认为是监管因素还是技术因素起到了主导作用？技术是什么时候真正成熟的？是最近才实现的吗？

我认为主要是技术因素。在一次 30 分钟的演示中，你看不到团队在十年间必须要解决的所有技术难题。从技术演示到商业产品之间存在着巨大的技术壁垒。当然，监管等因素也起到了重要作用。但我认为，从某种程度上说，我们确实在自动驾驶领域达到了类似 AGI 的水平。不过，最引人深思的是，这项技术还没有实现全球范围的推广。虽然你可以在旧金山体验这项服务，但这还没有从根本上改变整个世界。这个推广过程还需要很长时间。从单点示范到全球范围的实际应用之间还有很大的差距。这一点和 AGI 的发展路径很相似，我推测当我们实现 AGI 时也会经历类似的过程。

在自动驾驶领域，大多数人认为 Waymo 领先于 Tesla。然而，从我个人的专业判断来看，Tesla 其实走在了 Waymo 的前面。虽然表面上看起来并非如此，但我对 Tesla 及其自动驾驶项目始终保持着强烈的信心。用我的理解来说，Tesla 面临的主要是软件层面的挑战，而 Waymo 则存在硬件层面的瓶颈。相比之下，软件问题更容易解决。Tesla 已经在全球范围内完成了车辆部署，这正是 Waymo 目前尚未实现的。因此，一旦 Tesla 突破技术瓶颈，实现可靠的系统部署，其影响力将会是惊人的。就在昨天，我试驾了他们的最新版本，系统可以自如地完成各种驾驶任务。最近他们在技术上取得了显著的进步。

确实如此，我最近也经常使用这个系统，它的表现令人印象深刻。昨天，它展现出了极其出色的驾驶能力，这充分证明了研发团队的实力。因此，我依然认为 Tesla 主要面临软件挑战，而 Waymo 则需要解决硬件问题。尽管目前看来 Waymo 似乎占据优势，但从长远来看，当我们回顾十年后谁真正实现了规模化应用，以及创造了更大的商业价值，我认为 Tesla 在这个层面上仍然保持领先地位。

在软件问题上，你认为还需要多久才能实现技术突破，达到与 Waymo 相当的水平？因为按照你的说法，Waymo 的车辆装配了大量昂贵的激光雷达（LiDAR）和其他类型的传感器（Sensors），这些硬件为其软件系统提供了支持。而如果采用 Tesla 的方案，只依靠摄像头（Camera），就能大幅降低成本和系统复杂度，而且这种方案可以更容易地应用到各类车型上。你觉得这种技术转变会在什么时候发生？

我希望在未来几年内能看到这样的转变。但有趣的是，我觉得人们可能还没有充分认识到一点：Tesla 其实也在使用大量昂贵的传感器，只不过他们是在训练阶段使用这些设备。他们确实有配备激光雷达的测试车辆在路上行驶，也进行了许多非规模化的测试，使用额外的传感器进行数据收集，还包括地图绘制等各种工作。这些都是在训练阶段完成的，然后他们将收集到的数据和经验提炼为可以部署到仅依靠视觉系统的量产车上的解决方案。这实际上是一种非常巧妙的策略，将昂贵的传感器成本转移到了训练阶段，但我认为这个策略的价值还没有被充分理解。我相信这个方向会取得成功，因为图像像素中包含了足够的信息，而神经网络有能力处理这些信息。确实，这些传感器在训练阶段非常重要，但在实际应用阶段并不是必需的。

另一个值得关注的技术转变是：自动驾驶系统从大量基于边缘案例的启发式方法（Heuristic Approach）转向了端到端深度学习（End-to-end Deep Learning）。这是最近发生的重要变革，你能详细说说这个转变吗？

是的，这其实一直都是 Tesla 的既定战略。我之前提到过神经网络如何逐步取代传统技术栈，这个过程是这样的：当我刚加入时，系统中有大量的 C++ 代码，而现在车辆上运行的实时系统中 C++ 代码已经大幅减少。虽然后端还有许多我们没有谈到的复杂系统，但神经网络正在逐步接管整个流程。最初，它只负责图像层面的目标检测，然后发展到处理多帧图像并作出预测，再到利用时间序列上的多帧图像进行预测，同时逐步替换原有的 C++ 代码。最终目标是直接输出转向指令。这就是 Tesla 逐步完善技术栈的过程。

据我了解，当前的 Waymo 采用了不同的方案。虽然他们也尝试过类似的方法，但最终没有采用这个路线。当然，由于他们不对外讨论技术细节，这只是我的个人理解。但我从根本上相信这种方法是正确的，这可能是最后需要实现的技术突破。我推测在未来十年左右，Tesla 的端到端系统将会发展成一个纯粹的神经网络：视频数据输入，直接输出控制指令。当然，这需要循序渐进，一步一步构建。包括我们现在开发的所有中间预测功能，实际上都是这个过程中必要的组成部分，而不是什么技术歧路，这背后有着深层的技术原因。

实际上，在端到端驾驶系统中，如果仅仅依靠模仿人类驾驶行为，我们能获得的监督信号（Supervision Signal）是非常有限的。这些信号量太少，无法有效训练包含数十亿参数的大型神经网络。这就是为什么中间表征（Intermediate Representation）的作用如此重要，它们帮助我们开发特征和各类检测器，从而大大简化了端到端学习的难度。虽然我已经不是团队成员，无法了解具体细节，但我推测他们正在进行大量的预训练（Pre-training），为后续的端到端微调（Fine-tuning）做准备。我认为这种循序渐进的方法是必要的，这也正是 Tesla 一直在做的。这种方法看起来是正确的，而且正在显示出成效。

### 02

So I'm really looking forward to it. If you had started end-to-end, you wouldn't have had the data anyway. That makes sense. Yeah. So you worked on the Tesla humanoid robot before you left. I have so many questions, but one is like starting here. What transfers?

Basically, everything transfers, and I don't think people appreciate it.

Okay. That's a big claim. It seems like a very different problem.

I think cars are basically robots when you actually look at it. Cars are robots. And Tesla, I don't think is a car company. I think this is misleading. This is a robotics company. Robotics at scale company. Because I would say at scale is also like a whole separate variable. They're not building a single thing. They're building the machine that builds the thing, which is a whole separate thing. And so I think robotics at scale company is what Tesla is. And I think in terms of the transfer from cars to humanoids, it was not that much work at all.

And in fact, like the early versions of Optimus, the robot, it thought it was a car, like because it had the exact same computer, it had the exact same cameras. It was really funny because we were running the car networks on the robot, but it's walking around the office and so on. And like it's trying to recognize drivable space, but it's all just walking space now, I suppose. But it actually kind of like generalized a little bit and there's some fine tuning necessary and so on, but it thought it was driving, but it's actually like moving through an environment.

Is a reasonable way to think of this as like, actually it's a robot, many things transfer, but you're just missing, for example, actuation and action data?

Yeah you definitely missed some components but and the other part I would say is like like so much transfers like the speed with which optimus was started I think to me was very impressive because the moment Elon said we're doing this uh just people just showed up with all the right tools and all the stuff just showed up so quickly and all these cad models and all the supply chain stuff and I I just felt like, wow, there's so much in-house expertise for building robotics at Tesla. And it's all the same tools. And they're just like, okay, they're being reconfigured from a car, like a transformer, the movie. They're just being reconfigured and reshuffled, but it's like the same thing. And you need all the same components. You need to think about all the same kinds of stuff, both on the hardware side, on the scale stuff, and also on the brains.

And so for the brains, there was also a ton of transfer, not just of the specific networks, but also all of the approach and the labeling team and how it all coordinates and the approaches people are taking. I just think there's a ton of transfer.

What do you think are the first application areas for humanoid robotics or human form stuff? I think a lot of people have this vision of it, like doing your laundry, et cetera.

I think that will come late. I don't think B2C should be the right start point because I don't think we can have a robot like Crushed Grandma, is how I put it, sort of. I think it's like too much legal liability. It's just like, I don't think that's the right approach.

But like a very torquey hug.

I mean, it's just going to fall over or something like that. You know, like these things are not perfect yet and they require some amount of work. So I think the best customer is yourself first. And I think probably Tesla is going to do this. I'm very bullish on Tesla, if people can tell. The first customer is yourself, and you incubate it in the factory and so on, doing maybe a lot of material handling, et cetera. This way, you don't have to create contracts working with third parties. It's all really heavy. There's lawyers involved, et cetera. You incubate it.

Then you go, I think, B2B second. And you go to other companies that have massive warehouses. We can do material handling. We're going to do all this stuff. Contracts get drafted up, fences get put around, all this kind of stuff. And then once you incubate it in multiple companies, I think that's when you start to go into the B2C applications. I do think we'll see B2C robots also, like Unitree and so on are starting to come out with robots that I really want.

I got one.

You did?

Yeah, the G1.

Yeah. So G1. Yeah. So I will probably buy one of those and there's probably going to be an ecosystem of people building on those platforms too. But I think in terms of like what like wins at scale, I would expect that kind of approach. But in the beginning, it's a lot of material handling and then going towards more and more HKC things that are more specific. One that I'm really excited about is the net freedom challenge of the leaf blower. Yeah. Like I would love for an optimist to walk down the street, like tiptoe down the street and like pick up individual leaves so that we don't need like leaf blowers. And I think this will work and it's an amazing task. And so I would hope that that's one of the first applications.

Or just even raking.

Yeah, that should work too. Just very quietly.

Yeah, just quiet raking. That's cute. I mean, they do actually have like a machine that's working. It's just not a humanoid.

Can we talk about the humanoid thesis for a second? Because the simplest version of this is like the world is built for humans and you build one set of hardware. The right thing to do is build a model that can do an increasing set of tasks in this set of hardware. I think there's like another camp that believes like, well, like humans are not optimal for any given task, right? You can make them stronger or bigger or smaller or whatever. And why shouldn't we do superhuman things? Like, how do you think about this?

I think people are maybe underappreciating the complexity of any fixed cost that goes into any single platform. I think there's a large fixed cost you're paying for any single platform. And so I think it makes a lot of sense to centralize that and have a single platform that can do all the things. I would say the humanoid aspect is also very appealing because people can teleoperate it very easily. And so it's a data collection thing that is extremely helpful because people will be able to obviously very easily teleoperate it. I think that's usually overlooked.

There's of course the aspect you mentioned, which is like the world design for humans, et cetera. So I think that's also important. I mean, I think we'll have some variations on the humanoid platform, but I think there is a large fixed cost to any platform. And then I would say also one last dimension of it is you benefit a ton from the transfer learning between the different tasks. And in AI, you really want the single neural knot that is multitasking, doing lots of things that's very getting all the intelligence and the capability from. And that's also why language models are so interesting is because you have a single regime, like a text domain, multitasking all these different problems and they're all sharing knowledge between each other and it's all coupled in a single neural net. And I think you want that kind of a platform and you want all the data you collect for leaf picking to benefit all the other tasks. If you're building a special purpose thing for any one thing, you're not going to benefit from a lot of the transferring between all the other tasks, if that makes sense.

Yeah, I think there's one argument of like, it seems, I mean, the G1 is like 30 grand, right? But it seems hard to build a very capable humanoid robot under a certain bomb. And like, if you wanted to put an arm on wheels that can do things, like, maybe there are cheaper approaches to a general platform at the beginning. Does that make sense to you?

Cheaper approaches to a general platform at the beginning. Does that make sense to you? Cheaper approaches to a general platform. From a hardware perspective.

Yeah, I think that makes sense. Yeah, you put a wheel on it instead of a feet, et cetera. I do feel like, I wonder if it's taking down like a local minimum a little bit. I just feel like pick a platform, make it perfect is like the long-term pretty good bet. And then the other thing of course is like, I just think it will be kind of like familiar to people. And I think people will understand that maybe like familiar to people and I think people will understand that maybe you want to talk to it and I feel like the psychological aspect also of it I think favors possibly the human platform unless people are like scared of it and would actually prefer a platform that is more abstract of like some but then I don't know if it's just some kind of like an eight wheel monster doing stuff and I don't know if that's like more appealing or less appealing

It's kind of like it's interesting that I think that the other form factor for the unitry is a dog, right? And it's almost a more friendly or familiar thing.

Yeah, but then people watch Black Mirror and suddenly the dog flips to like a scary thing. So it's hard to think through. I just think psychologically it'll be easy for people to understand what's happening.

What do you think is missing in terms of technological milestones for progress relative to substantiating this future for robotics or the humanoid robot or anything else human form?

Yeah, I don't know that I have like a really good window into it. I do think that it is kind of interesting that like in the human form factor for example for the lower body, I don't know that you want to do imitation learning from like demonstration because for lower body it's a lot of like inverted pendulum control and stuff like that. It's for the upper body that you need a lot of like teleoperation and data collection and end-to-end and etc. And so I think like everything becomes like very hybrid in that sense.

And I don't know how those things interact when I talk to people working. I feel a lot of what they focus on is like actuation and you know manipulation and sort of digital manipulation and things.

Yeah, I do expect in the beginning it's a lot of like teleoperation for getting stuff off the ground and imitating it and getting something that works 95% of the time and then talking about human to robot ratios and gradually having people who are supervisors of robots instead of doing the task directly and all this kind of stuff is going to happen over time and pretty gradually. I don't know that there's like any individual impediments that I'm like really familiar with. I just think it's a lot of grunt work.

A lot of the tools are available. Transformers are this beautiful blob of tissue you can just get, just arbitrary tasks. And you just need the data, you need to put it in the right form, you need to train it, you need to experiment with it, you need to deploy it, iterate on it. Just a lot of grunt work. I don't know that I have a single individual thing that is holding us back technically.

Where are we in the state of large blob research?

Large blob research?

Yeah.

We're in a really good state. So I think, I'm not sure if it's fully appreciated, but like the transformer is like much more amazing. It's not just like, it's not just another neural net. It's like an amazing neural net, extremely general. So for example, when people talk about the scaling loss in neural networks, the scaling loss are actually to a large extent a property of the transformer. Before the transformer, people were playing with LSTMs and stacking them, etc. You don't actually get clean scaling loss, and this thing doesn't actually train and doesn't actually work. It's the transformer that was the first thing that actually just kind of scales, and you get scaling loss and everything makes sense.

So it's this general purpose training computer. I think of it as kind of a computer, but it's like a differentiable computer. And you can just give it inputs and outputs and building itself it, and you can train with backpropagation. It actually kind of like arranges itself into a thing that does the task. And so I think it's actually kind of like a magical thing that we've stumbled on in the algorithm space.

And I think there's a few individual innovations that went into it. So you have the residual connections. That was a piece that existed. You have the layer normalizations that needs to slot in. You have the attention block. You have the lack of these like saturating nonlinearities like tanhs and so on. Those are not present in the transformer because they kill gradient signals. So there's a few like, there's four or five innovations that all existed and were put together into this transformer. And that's what Google did with their paper. And this thing actually trains. And suddenly you get scaling loss and suddenly you have like this piece of tissue that just trains to a very large extent. And so it was a major unlock.

You feel like we are not near the limit of that unlock, right? Because I think there is a discussion of, of course, like the data wall and how expensive another generation of scale would be. Like, how do you think about that?

That's where we start to get into, I don't think that the neural network architecture is holding us back fundamentally anymore. It's not the bottleneck, whereas I think in the previous, before Transformer, it was a bottleneck, but now it's not the bottleneck. So now we're talking a lot more about what is the loss function? What is the dataset? We're talking a lot more about those and those have become the bottlenecks almost. It's not the general piece of tissue that reconfigures based on whatever you want it to be. And so that's where I think a lot of the activity has moved.

And that's why a lot of the companies and someone who are applying these technologies, like they're not thinking about the transformer much. They're not thinking about the architecture, you know, the LAMA release. Like the transformer hasn't changed that much. You know, we've added the rope positional and the rope relative positional encodings. That's like the major change. Everything else doesn't really matter too much. It's like plus 3% on the small few things. But really it's like rope is the only thing that's slotted in. And that's the transformer as it has changed since the last five years or something. So there hasn't been that much innovation on that. Everyone just takes it for granted. Let's train it, et cetera. And then everyone's just innovating on the data set mostly and the loss function details. So that's where all the activity has gone to.

Right, but what about the argument, like in that domain, that that was easier when we were taking internet data and we're out of internet data. And so the questions are really around like synthetic data or more expensive data collection.

So I think that's a good point. So that's where a lot of the activity is now in LLMs. So the internet data is like not the data you want for your transformer. It's like a nearest neighbor that actually gets you really far, surprisingly. But the internet data is a bunch of internet web pages. It's just like what you want is the inner thought monologue of your brain. That's the idea of it. The trajectories in your brain. The trajectories in your brain as you're doing problem solving, if we had a billion of that, like AGI is here, roughly speaking, I mean, to a very large extent. And we just don't have that.

So where a lot of activity is now, I think, is we have the internet data that actually gets you like really close because it just so happens that internet has enough of reasoning traces in it and a bunch of knowledge and the transformer just makes it work okay. So I think a lot of activity now is around refactoring the data set into these inner monologue formats. And I think there's a ton of synthetic data generation that's helpful for that.

So what's interesting about that also is like the extent to which the current models are helping us create the next generation of models. And so it's kind of like, you know, the staircase of improvement. How much do you think synthetic data is, or how far does that get us, right? Because to your point on each data, each model helps you train the subsequent model better, or at least create tools for it, data labeling, whatever maybe part of it is synthetic data. How important do you think the synthetic data piece is? Because when I talk to people, they say, yeah.

I think it's the only way we can make progress, is we have to make it work. I think with synthetic data, you just have to be careful, because these models are silently collapsed. It's one of the major issues. So, if you go to ChatGPT and you ask it to give you a joke, you'll notice that it only knows three jokes. It gives you one joke, I think, most of the time, and sometimes it gives you like three jokes. And it's because the models are collapsed and it's silent. So when you're looking at any single individual output, you're just seeing a single example. But when you actually look at the distribution, you'll notice that it's not a very diverse distribution, it's silently collapsed.

When you're doing synthetic data generation, this is a problem because you actually really want that entropy. You want the diversity and richness in your dataset. Otherwise you're getting collapsed datasets and you can't see it when you look at any individual example, but the distribution has lost a ton of entropy and richness. And so it silently gets worse. And so that's why you have to be very careful and you have to make sure that you maintain your entropy in your dataset. And there's a ton of techniques for that.

As an example, someone released this persona data set as an example. The persona data set is a data set of 1 billion personalities like humans, like backgrounds.

Oh, yes, I saw this.

Yeah, I'm a teacher or I'm an artist, I live here, I do this, etc. And it's like little paragraphs of like, fictitious human background. And what you do when you do synthetic data generation is not only like, oh, complete this task and do it in this way. But also, imagine you're describing it to this person and you put in this information and now you're forcing it to explore more of the space and you're getting some entropy. So I think you have to be just very careful to inject the entropy, maintain the distribution, and that's the hard part that I think maybe people aren't like sufficiently appreciating as much in general. So I think basically synthetic data, absolutely the future, we're not going to run out of data, is my impression. I just think you have to be careful.

What do you think we are learning now about human cognition from this research?

I don't know if we're learning much of it. One could argue that like figuring out the shape of reasoning traces we want, for example, is instructive to actually understand how the brain works. I would be careful with those analogies, but in general, I do think that it's a very different kind of thing. But I do think that there are some analogies you can draw.

So as an example, I think transformers are actually better than the human brain in a bunch of ways. I think they're actually a lot more efficient system. And the reason they don't work as good as the human brain is mostly data issue, roughly speaking, is the first order approximation, I would say. And actually, as an example, transformer memorizing sequences is so much better than humans. If you give it a sequence and you do a single forward-backward pass on that sequence, then if you give it the first few elements, it will complete the rest of the sequence. It memorized that sequence. And it's so good at it. If you gave a human a single presentation of a sequence, there's no way that you can remember that.

And so the transformers actually, I do think there's a good chance that the gradient-based optimization, the forward-backward update that we do all the time for training neural nets, is actually more efficient than the brain in some ways. And these models are better, they're just not yet ready to shine. But in a bunch of cognitive sort of aspects, I think they might come out. With the right inputs, they will be better.

That's generally true of computers for all sorts of applications, right? And putting memory to your point.

Yeah, exactly. And I think human brains just have a lot of constraints. You know, the working memory is very small. I think transformers have a lot, lot bigger working memory and will this will continue to be the case. They're much more efficient learners. The human brains function under all kinds of constraints. It's not obvious that the human brain is back propagation right it's not obvious how that would work it's a very stochastic sort of dynamic system it has all these constraints it works under so ambient ambient conditions, et cetera. So I do think that what we have is actually potentially better than the brain, and it's just not there yet.

How do you think about human augmentation with different AI systems over time? Do you think that's a likely direction? Do you think that's unlikely?

Augmentation?

Augmentation of people with AI models.

Oh, of course. I mean, but in what sense, maybe?

I think in general, absolutely. Because, I mean, there's an abstract version of it you're using as a tool. That's the external version. There's the merger scenario that a lot of people end up talking about.

Yeah, yeah. I mean, we're already kind of merging. The thing is, there's the IO bottleneck.

Sure. But for the most part, at your fingertips, if you have any of these models, you're already using them.

Yeah, but that's a little bit different. Because, I mean, people have been making that argument for, I think, 40, 50 years where technological tools are just an extension of human capabilities, right?

Yeah, the computer is the bicycle for human mind, etc. But there's a subset of the AI community that thinks that, for example, the way that we subsume some potential conflict with future AI or something else would be through some form of...

Yeah, like the Neuralink pitch, etc.

Exactly. Yeah, I don't know what this merger looks like yet, but I can definitely see that you want to decrease the IO to tool use. And I see this as kind of like an exocortex, we're building on top of our neocortex, right? And it's just the next layer, and it just turns out to be in the cloud, etc. But it is the next layer of the brain.

Yeah, Accelerando, a book from the early 2000s, has a version of this where basically everything is substantiated in a set of goggles that are computationally attached to your brain that you wear. And then if you lose them, you must feel like you're losing a part of your persona or memory.

I think that's very likely. Yeah. And today the phone is already almost that. And I think it's going to get worse. When you put your techno stuff away from you, you're just like naked human in nature. Well, you lose part of your intelligence. It's very anxiety inducing.

A very simple example of that is just maps, right? So a lot of people now have noticed It's just like naked human in nature. Well, you lose part of your intelligence. It's very anxiety-inducing. A very simple example of that is just maps, right? So a lot of people now I've noticed can't actually navigate their city very well anymore because they're always using turn-by-turn direction. And if we have this, for example, like universal translator, which I don't think is too far away, like you'll lose the ability to speak to people who don't speak English if you just put your stuff away.

I'm very comfortable repurposing that part of my brain to do further research. I don't know if you saw the video of like the kid that has a magazine and is trying to like swipe on the magazine.

Yes, yeah. What's fascinating to me about it is like, this kid doesn't understand what comes with nature and what's technology on top of the nature. Because it's made so transparent. And I think this might look similar where people will just start assuming the tools. And then when you take them away, you realize like, I guess like people don't know what's technology and what's not. If you're wearing this thing that's always translating everyone or like doing stuff like that for you, then maybe people like lose the...

It's basic cognitive abilities may not exist.

Yeah. I think it exists.

Yeah. It's like, whoa, like by nature.

Yeah, yeah. We're going to specialize. You can't understand people who speak Spanish? Like what the hell? Or like when you go to objects, like in Disney, all the objects are alive. And I think we are going to potentially come to that kind of a world where why can't I talk to things? Like already today you can talk to Alexa and you can ask her for things and so on.

Yeah. I've seen some toy companies like that, where they're basically trying to embed an LLM in a toy so they can interact with the child.

Yeah. Like, isn't this strange that when you go to a door, you can't just say open? Like what the hell?

Another favorite example of that, I don't know if you saw either Demolition Man or iRobot people make fun of the idea that you uh yeah like you can't just talk to things and what the hell if we're talking about a um exocortex that feels like a pretty fundamentally um important thing to democratize access to. How do you think like the current market structure of what's happening in LLM research, you know, there's a small number of large labs that actually have a shot at the next generation progressing training. Like how does that translate to what people have access to in the future?

So what you were kind of alluding to maybe is the state of the ecosystem, right? So we have kind of like an oligopoly of a few closed platforms, and then we have an open platform that is kind of like behind, so like MetaLlama, etc. And this is kind of like mirroring the open source kind of ecosystem. I do think that when this stuff starts to, when we start to think of it as like an exocortex, so there's a saying in crypto, which is like, not your keys, not your tokens. Is it the case that if it's like not your weights, not your brain?

That's interesting because a company is effectively controlling your exocortex and therefore a big part of your…

Yeah, it starts to feel kind of invasive. If this is my exocortex…

I think people care much more about ownership, yes. Like, you're…

Yeah, you realize you're renting your brain. Like it seems strange to rent your brain.

The thought experiment is like, are you willing to give up ownership and control to rent a better brain? Because I am.

Yeah. So I think that's the trade-off, I think. We'll see how that works. But maybe it's possible to like, by default, use the closed versions because they're amazing. But you have a fallback in various scenarios. And I think that's kind of like the way things are shaping up today even, right? Like when APIs go down on some of the closed source providers, people start to implement fallbacks to like the open ecosystems, for example, that they fully control and they feel empowered by that, right? So maybe that's just the extension of what it will look like for the brain as you fall back on the open source stuff should anything happen but most of the time you actually so it's quite important that the open source stuff continues to progress i think so

100 and this is not like an obvious point or something that people maybe agree on right now but i think 100

I guess one thing I've been wondering about a little bit is um what is the smallest performant model that you can get to in some sense either in parameter size or however you want to think about it and I'm a little bit curious about your view because you've thought a lot about both distillation small models you know

I think it can be surprisingly small and I do think that the current models are wasting a ton of capacity remembering stuff that doesn't matter. Like they remember SHA hashes, they remember like the ancient-

Because the data set is not curated the best it can be.

Yeah, exactly. And I think this will go away. And I think we just need to get to the cognitive core. And I think the cognitive core can be extremely small. And it's just this thing that thinks. And if it needs to look up information, it knows how to use different tools.

Is that like 3 billion parameters? Is that 20 billion parameters?

I think even a billion, a billion suffices. We'll probably get to that point and the models can be very, very small. And I think the reason they can be very small is fundamentally, I think, just like distillation works. It may be like the only thing I would say. Distillation works like surprisingly well. Distillation is where you get a really big model or a huge amount of computers or something like that supervising a very small model. And you can actually stuff a lot of capability into a very small model.

Is there some sort of mathematical representation of that or some information theoretical formulation of that? Because it almost feels like you should be able to calculate that now in terms of what's the...

Maybe one way to think about it is, we go back to the internet data set, which is what we're working with. The internet is 0.001% cognition and 99.99% of information is garbage. And I think most of it is not useful to the thinking part.

I guess maybe another way to frame the question is, is there a mathematical representation of cognitive capability relative to model size? Or how do you capture cognition in terms of, you know, here's the min or max relative to what you're trying to accomplish? And maybe there's no good way to represent that.

So I think maybe a billion parameters gets you sort of like a good cognitive core. I think probably right. I think even one billion is too much. I don't know. We'll see.

It's very exciting given if you think about, well, you know, it's a question of like on an edge device versus on the cloud, but.

And also this raw cost of using the model and everything.

Yeah, it's very exciting.

Right, but at less than a billion parameters, I have my exocortex on a local device as well.

Yeah, and then probably it's not a single model, right? Like it's interesting to me to think about what this will actually play out like, because I do think you want to benefit from parallelization. You don't want to have a sequential process. You want to have a parallel process. And I think companies to some extent are also kind of like parallelization of work. But there's a hierarchy in a company because that's one way to, you know, you have the information processing and the reductions that need to happen within an organization for information.

So I think we'll probably end up with companies of LLMs. I think it's not unlikely to me that you have models of different capabilities specialized to various unique domains. Maybe there's a programmer, et cetera. And it will actually start to resemble companies to a very large extent. So you'll have the programmer and the program manager and similar kinds of roles of LLMs working in parallel and coming together and orchestrating computation on your behalf. So maybe it's not correct to think about it. It's more like a swarm. It's like a biological ecosystem where you have specialized roles and niches. And I think it will start to resemble that. You have automatic escalation to other parts of the swarm, depending on the difficulty of the problem and the specialization.

The CEO is like a really brilliant cloud model.

Yeah. But the workers can be a lot cheaper, maybe even open source models or whatnot. And my cost function is different from your cost function.

Yeah. So that could be interesting.

You left OpenAI, you're working on education. You've always been an educator. Like why do this?

I would start with, I've always been an educator and I love learning and I love teaching. And so it's kind of just like a space that I've been very passionate about for a long time. And then the other thing is, I think one macro picture that's kind of driving me is, I think there's a lot of activity in like AI. And I think most of it is to kind of like replace or displace people, I would say. It's in the theme of like sliding away the people, but I'm always more interested in anything that kind of empowers people. And I feel like I'm kind of on a high level, like team human, and I'm interested in things that AI can do to empower people. And I don't want the future where people are kind of on the side of automation. I want people to be very in an empowered state and I want them to be amazing, even much more amazing than today.

And then other aspects that I find very interesting is like, how far can a person go if they have the perfect tutor for all the subjects? And I think people could go really far if they had the perfect curriculum for anything. And I think we see that with, you know, if some rich people maybe have tutors and they do actually go really far. And so I think we can approach that with AI or even Luxor Passive.

There's very clear literature on that actually from the 80s, right? Where one-on-one tutoring, I think, helps people get one standard deviation better.

Two, Bloom too yeah it's the bloom stuff yeah exactly there's a lot of really interesting uh precedents on that

How do you actually view that as substantiating through the lens of AI or what's the first types of products that will really help with that or you know because there's books like the diamond age where they talk about the young ladies illustrated primer and all that kind of stuff so

So I would say I'm definitely inspired by aspects of it. So like in practice, what I'm doing is trying to currently build a single course. And I want it to be just like the course you would go to if you want to learn AI. I think the problem with basically is like, I've already taught courses, like I taught 231N at Stanford and that was the first deep learning class and was pretty successful. But the question is like, how do you actually like really scale these classes? Like, how do you make it so that your target audience is maybe like 8 billion people on earth? And they're all speaking different languages, and they're all different capability levels, et cetera. And a single teacher doesn't scale to that audience.

And so the question is, how do you use AI to do the scaling of a really good teacher? And so the way I'm thinking about it is the teacher is doing a lot of the course creation and the curriculum. Because currently, at the current AI capability, I don't think the models are good enough to create a good course, but I think they're good to become the front end to the student and interpret the course to them. And so basically the teacher doesn't go to the people and the teacher is not the front end anymore. The teacher is on the backend designing the materials on the course, and the AI is the front end and it can speak all the different languages and it's kind of like takes you through the course.

Should I think of that as like the TA type experience or is that not a good analogy here?

That is like one way I'm thinking about it. It's AI TA, I'm mostly thinking of it as like this front end to the student and it's the thing that's actually interfacing with the student and taking them through the course. And I think that's tractable today and it just doesn't exist and I think it can be really good. And then over time as the capability increases, you would potentially refactor the setup in various ways.

I like to find things where, like the AI capability today and having a good model of it. And I think a lot of companies that maybe don't quite understand intuitively where the capability is today, and then they end up kind of like building things that are kind of like too ahead of what's available, or maybe not ambitious enough. And so I think, I do think that this is kind of a sweet spot of what's possible and also really interesting and exciting

So I want to go back to something you said that I think is very inspiring especially coming from like your background and understanding of where exactly we are in research which is essentially like we do not know what the limits of human performance from a learning perspective are given much better tooling. And I think there's like a very easy analogy to we just had the Olympics like a month ago. Right. And, you know, a runner and it's the very best mile time or pick any sport today is much better than it was. Putting aside performance enhancing drugs like 10 years ago, just because like you start training earlier, you have a very different program. We have much better scientific understanding. We have technique, we have gear. The fact that you believe like we can get much further as humans if we're starting with like the tooling and the curriculum is amazing.

Yeah, I think we haven't even scratched like what's possible at all. So I think there's like two dimensions basically to it. Is number one is the globalization dimension of like, I want everyone to have really good education, but the other one is like how far can a single person go? I think both of those are very interesting and exciting.

Usually when people talk about one-on-one learning, they talk about the adaptive aspect of it, where you're a challenging person at the level that they're at. Do you think you can do that with AI today? Or is that something for the future and it's more, today it's about reach and multiple languages and globalization?

I think the low-hanging fruit is things like, for example, different languages. Super low-hanging fruit. I think the current models are actually really good at translation, basically, and can target the material and translate it at the spot. So I think a lot of things are low-hanging basically, and can target the material and translate it like at the spot. So I think a lot of things are low-hanging fruit.

This adaptability to a person's background, I think is like not at the low-hanging fruit, but I don't think it's like too high up or too much away. But that is something you definitely want because not everyone is coming in with the same background. And also what's really helpful is like if you're familiar with some other disciplines in the past, then it's really useful to make analogies to the things you know, and that's extremely powerful in education. So that's definitely a dimension you want to take advantage of. But I think that starts to get to the point where it's not obvious and needs some work.

I think like the easy version of it is not too far where you can imagine just prompting the model. It's like, oh, hey, I know physics or I know this and you probably get something. But I guess what I'm talking about is something that actually works, not something that like you can demo and work sometimes. So I just mean it actually really works in the way a person would.

Yeah. And that's the reason I was asking about adaptability, because also people learn at different rates or certain things they find challenging that others don't or vice versa. And so it's a little bit of how do you modulate relative to that context. And I guess you could have some reintroduction of what the person is good or bad at into the model over time.

That's the thing with AI. I feel like a lot of these capabilities are just kind of like prompt away. So you always get like demos, but like, do you actually get a product? You know what I mean? So in this sense, I would say the demo is near, but the product is far.

So one thing we were talking about earlier, which I think is really interesting, is sort of lineages. That happens in the research community where you come from certain labs and everybody gossips about being from each other's labs. I think a very high proportion of Nobel laureates actually used to work in a former Nobel laureates lab. So there's some propagation of, I don't know if it's culture or knowledge or branding or what. In an AI education-centric world, how do you maintain lineage or does it not matter? How do you think about those aspects of propagation of network and knowledge?

I don't actually want to live in a world where lineage matters too much, right? So I'm hoping that AI can help you destroy that structure a little bit. It feels like kind of gatekeeping by some finite, scarce resource, which is like, oh, there's a finite number of people who have this lineage, etc. So I feel like it's a little bit of that aspect. So I'm hoping it can destroy that.

It's definitely one piece, like actual learning, one piece pedigree.

Yeah. Well, it's also the aggregation of, it's a cluster effect, right? It's like, why is all of the, or much of the AI community in the Bay Area? Or why is most of the fintech community in New York?

Yeah. And so I think a lot of it is also just you're clustering really smart people with common interests and beliefs. And then they kind of propagate from that common core. And then they share knowledge in an interesting way.

You've got to agree, a lot of that behavior has shifted online to some extent, particularly for younger people.

I think one aspect of it is kind of like the educational aspect where like if you're part of a community today, you're getting a ton of education and apprenticeship, et cetera, which is extremely helpful and gets you to a point of empowered state in that area. I think the other piece of it is like the cultural aspect of what you're motivated by and what you want to work on. What does the culture prize and what do they put on the pedestal and what do they kind of like worship basically?

So in academic world, for example, is the H-index. Everyone cares about the H-index, the amount of papers you publish, etc. And I was part of that community and I saw that. And I feel like now I've come to different places and there's different idols in all the different communities. And I think that has a massive impact of what people are motivated by and where they get their social status and what actually matters to them.

I also was, I think, part of different communities like growing up in Slovakia, also a very different environment, being in Canada, also a very different environment. What mattered there?

Hockey. Sorry. Thank you. Hockey.

Yeah, hockey. I would say as an example, I would say in Canada, I was in University of Toronto and Toronto. I don't think it's a very entrepreneurial pilled environment. It doesn't even occur to you that you should be starting companies. I mean, it's a very entrepreneurial pilled environment. It doesn't even occur to you that you should be starting companies. I mean, it's not something that people are doing. You don't know friends who are doing it. You don't know that you're supposed to be looking up to it. People aren't like reading books about all the founders and talking about them. It's just not a thing you aspire to or care about. And what everyone is talking about, oh, is where are you getting your internship? Where are you going to work afterwards? And it's just accepted that there's a fixed set of companies that you are supposed to pick from and just align yourself with one of them. And that's like what you look up to or something like that.

So these cultural aspects are extremely strong and maybe actually the dominant variable. Because I almost feel like today, the education aspects I think are the easier one, like a ton of stuff is already available, et cetera. So I think mostly it's a cultural aspect that you're part of.

So on this point, like one thing you and I were talking about a few weeks ago is, and I think you also posted online about this, there's a difference between learning and entertainment and learning is actually supposed to be hard. And I think it relates to this question of like, you know, status and what like status is a great motivator, like who the idol is. How much do you think you can change in terms of motivation through systems like this if that's like a blocking factor? Are you focused on give people the resources such that they can get as far as possible in the sequence for their own capability as they can like further than any other point in history, already inspirational? Or do you actually want to change how many people want to learn? Or at least bring themselves down the path?

Want is a loaded word. I would say like I want to make it much easier to learn. And then maybe it is possible that maybe people don't want to learn. I mean today, for example, people want to learn for practical reasons, right? Like they want to get a job, etc., which makes total sense. So in a pre-AGI society, education is useful. And I think people will be motivated by that because they're climbing up the ladder economically, etc.

Oh, but in the post-AGI society, we're just all going to be...

In the post-AGI society, I think education is entertainment to a much larger extent.

Including successful outcomes education, right? Not just letting the content wash over you.

Yes, I think so.

Outcomes being like understanding, learning, being able to contribute new knowledge or however you define it.

I think it's not an accident that if you go back 200 years, 300 years, the people who were doing science were nobility or people of wealth.

We will all be nobility learning with Andrej, yeah.

I do think that I see it very much equivalent to your quote earlier. I feel like learning something is kind of like going to the gym, but for the brain, right? Like it feels like going to the gym. I mean, going to the gym is fun. People like to lift, et cetera.

Some people don't go to the gym.

No, no. Some people do, but it takes effort.

Yeah. Yeah. It takes effort, but it's effort, but it's also kind of fun. And you also have a payoff, like you feel good about yourself in various ways, right? And I think education is basically equivalent to that. So that's what I mean when I say education should not be fun, et cetera. I mean, it is kind of fun, but it's like a specific kind of fun, I suppose, right?

I do think that maybe in a post-AGI world, what I would hope happens is people actually, they do go to the gym a lot, not just physically, but also mentally. And it's something that we look up to as being highly educated and also, you know, just, just, yeah.

Can I ask you one last question about Eureka, just because I think it'll be interesting to people. Like who is the audience for the first course?

The audience for the first course, I'm mostly thinking of this as like an undergrad level course. So if you're doing undergrad and technical area, I think that would be kind of the ideal audience. I do think that what we're seeing now is we have this like antiquated concept of education where you go through school and then you graduate and go to work, right? Obviously this will totally break down, especially in a society that's turning over so quickly. People are going to come back to school a lot more frequently as the technology changes very, very quickly. So it is kind of like undergrad level, but I would say like anyone at that level at any age is kind of like in scope. I think it will be very diverse in age, as an example, but I think it is mostly like people who are technical and mostly actually want to understand it to a good amount.

When can they take the course?

I was hoping it would be late this year. I do have a lot of distractions that are piling on, but I think probably early next year is kind of like the timeline. Yeah, I'm trying to make it very, very good. And yeah, it just takes time to get there.

I have one last question actually it's pseudo related to that. If you have little kids today, what do you think they should study in order to have a useful future?

There's a correct answer in my mind. And the correct answer is mostly like, I would say like math, physics, CS kind of disciplines. And the reason I say that is because I think it helps for just thinking skills. It's just like the best thinking skill core is my opinion. Of course, I have a specific background, et cetera. So I would think this, but that's just my view on it.

I think like me taking physics classes and all these other classes just like shape the way I think. And I think it's very useful for problem solving in general, et cetera. And so if we're in this world where pre-AGI, this is going to be useful. Post-AGI, you still want empowered humans who can function in any arbitrary capacity. And so I just think that this is just the correct answer for people and what they should be doing and taking. And it's either useful or it's good. And so I just think it's the right answer.

And I think a lot of the other stuff you can tack on a bit later, but the critical period where people have a lot of time and they have a lot of kind of like attention and time, I think should be mostly spent on doing these kinds of simple manipulation-heavy tasks and workloads, not memory-heavy tasks and workloads.

I did a math degree and I felt like there was a new groove being carved into my brain as I was doing that. And it's a harder groove to carve later.

And I would, of course, put in a bunch of other stuff as well. I'm not opposed to all the other disciplines, etc. I think it's actually beautiful to have a large diversity of things but I do think 80% of it should be something like this one we're not efficient memorizers compared to our tools

Thank you for doing this yeah

Yes it's great to be here

Find us on twitter at no priors pod subscribe to our youtube channel if you want to see our faces follow the show on apple podcasts spotify or wherever you listen that way you get a new episode every week and sign up for emails.

### 翻译








这个发展前景令人期待。确实，如果一开始就想实现端到端的自动驾驶，连基础数据都无法获得。这个观点很有道理。说到这里，我知道你在离开 Tesla 之前参与了人形机器人（Humanoid Robot）项目。我有很多问题想问，但让我们从最基础的开始：哪些技术是可以从自动驾驶转移到机器人领域的？

基本上所有技术都是可以迁移的，不过我觉得很多人还没有意识到这一点。

这个说法很大胆啊。毕竟这看起来是两个完全不同的技术领域。

从技术角度来看，汽车本质上就是一种机器人。因此，我认为把 Tesla 定位为一家汽车公司是不准确的。它实际上是一家规模化的机器人公司。这里的「规模化」是一个关键因素。Tesla 不是在制造单个产品，而是在建立一个完整的规模化制造系统，这是完全不同的概念。正是基于这种定位，从汽车技术到人形机器人的技术迁移其实并不需要太多额外工作。

举个有趣的例子，Tesla 的人形机器人 Optimus 在早期版本中，由于使用了与汽车完全相同的计算机和摄像头系统，它的行为模式非常像一辆汽车。当时我们直接在机器人上运行了原本用于汽车的神经网络，让它在办公室环境中活动。系统原本设计用来识别车辆可行驶区域（Drivable Space），现在则被用来识别机器人的可行走区域（Walkable Space）。有趣的是，系统展现出了一定的泛化（Generalization）能力，虽然需要一些微调（Fine-tuning），但它成功地将「驾驶」的概念转化为了在环境中的移动。

你说得对，一个合理的理解方式是：从本质上讲，汽车确实是一种机器人，很多核心技术都可以迁移，主要的差异在于驱动系统（Actuation）和动作数据（Action Data）这些特定领域的内容。

确实如此。虽然有一些特定组件需要重新开发，但技术迁移的范围令人惊叹。比如说，当 Elon 宣布启动 Optimus 项目时，整个过程的快速推进让我印象深刻。团队迅速调动了所有必要的技术资源，包括计算机辅助设计（CAD）模型和完整的供应链体系。这让我意识到 Tesla 内部积累了多么丰富的机器人制造专业知识。而且所有工具都是通用的，只是从汽车应用重新配置到机器人领域。这需要考虑相同的硬件设计原则、规模化生产问题，以及控制系统的开发。

在智能控制系统方面，技术迁移的程度也很高。这不仅包括特定神经网络的迁移，还包括整个开发方法论、数据标注团队的工作流程以及各个团队之间的协调机制。这种大规模的技术迁移确实令人印象深刻。

谈到人形机器人的应用前景，你认为最先会在哪些领域实现突破？很多人期待它能够完成家务，比如洗衣服之类的日常任务。

我认为这种家庭应用场景会在较晚阶段才能实现。商业对消费者（B2C，Business-to-Consumer）市场不应该是最初的切入点，因为现阶段的机器人可能存在安全隐患，比如可能会在运行过程中发生意外。这涉及到太多的法律责任问题，所以这不是一个明智的起步方向。

（对方打趣说：）"那就是一个力道很大的拥抱了。"

确实，机器人可能会出现失衡摔倒等情况。目前这些技术还不够完善，需要大量的改进工作。因此，我认为最理想的首选客户是企业自身。我相信 Tesla 很可能会采取这种策略 —— 我想我对 Tesla 的看好已经很明显了。首先在自己的工厂环境中进行技术验证，从事一些基础的物料搬运（Material Handling）等任务。这种方式可以避免复杂的第三方合作协议，减少法律和合规方面的负担。这是一个循序渐进的发展过程。

第二步则是开拓企业对企业（B2B，Business-to-Business）市场。我们可以与拥有大型仓库的企业合作，开展物料处理等业务。这个阶段需要制定正式的商业合同，建立必要的安全防护措施等基础设施。当技术在多个企业环境中得到验证后，才会考虑进入消费者市场。当然，我们现在已经能看到一些面向消费者的机器人产品，比如优趣科技（Unitree）推出的机器人就很吸引我。

"我已经买了一台。"

"真的吗？"

"对，就是 G1 型号。"

」是的，G1。我可能也会购入一台，我相信会有很多开发者在这类平台上进行创新。但从规模化应用的角度来看，我认为之前提到的发展路径更有可能成功。在初期，主要还是集中在物料处理等基础应用，然后逐步向更专业的服务机器人方向发展。有一个应用场景我特别期待，就是网络自由挑战赛（Net Freedom Challenge）中提出的落叶清理任务。我很期待看到 Optimus 能够在街道上灵活移动，精确地拾取每一片落叶，这样就可以取代噪音较大的吹叶机。我认为这是一个既实用又具有挑战性的应用场景，希望能成为最早实现的应用之一。

"或者用耙子收集落叶。"

"对，这也是个好办法，而且不会产生噪音。"

"确实，安静地耙理落叶听起来很实用。实际上，已经有一种专门的落叶清理机器在使用了，只不过不是人形机器人。"

让我们来讨论一下人形机器人设计理念的问题。最基本的观点是：既然我们的世界是按照人类的需求建造的，那么只要开发一套人形硬件平台，就能逐步扩展其任务处理能力。但也有另一种观点认为，人类的形态对于特定任务来说并非最优解。比如说，我们完全可以根据具体任务需求，设计出力量更大、体型更大或更小的机器人。既然如此，为什么我们要局限于人类的形态，而不是开发具有超越人类能力的专用机器人呢？你对这个问题有什么看法？

我认为很多人可能低估了开发独立平台所需的基础设施成本。每开发一个新的机器人平台，都需要投入巨大的固定成本。因此，将资源集中在一个通用平台上，使其能够完成各种任务是更明智的选择。人形设计还有一个重要优势：它便于实现远程操作（Teleoperation）。这对数据收集来说极其重要，因为操作者可以基于自身经验直观地控制机器人。这个优势常常被人忽视。

当然，正如你提到的，我们的环境本就是为人类设计的，这也是选择人形设计的重要原因之一。虽然我们可能会对人形平台做一些变体设计，但要记住每个平台都需要巨大的基础投入。还有一个关键因素是迁移学习（Transfer Learning）带来的优势。在人工智能领域，我们追求的是一个能够处理多任务的统一神经网络，让它能从各种任务中累积智能和能力。这就像大语言模型（LLM）之所以引人注目的原因：在统一的文本域中处理各种不同的任务，让知识在任务之间共享，所有功能都整合在同一个神经网络中。我们需要这样的平台，这样在一个任务（比如物体抓取）中收集的数据就能促进其他任务的发展。相比之下，如果为每个特定任务开发专门的系统，就无法充分利用任务之间的知识迁移优势。

确实，这里有个值得讨论的问题：优趣科技的 G1 机器人售价约 3 万美元，而要开发一个功能完备的人形机器人，想要将成本控制在某个范围以下确实很困难。如果考虑替代方案，比如在移动平台上安装机械臂，在初期可能是一个更经济的通用平台解决方案。这个想法你觉得合理吗？

是的，这个思路确实有其合理性。比如用轮式结构替代双足行走确实能降低成本。不过我担心这可能会陷入局部最优（Local Optimum）的问题。从长远来看，专注于开发和完善单一的人形平台可能是更明智的策略。此外，人形设计还有一个优势：它对于普通用户来说更容易接受和理解。人们可能会很自然地想要与其进行语音交互，这种心理因素也支持采用人形设计。当然，除非人们对人形机器人产生恐惧心理，而更偏好某种抽象的机器人形态。但如果是一个多轮移动平台的设计，我们还需要考虑这种外形是否会影响用户的接受度。

这很有趣，因为优趣科技的另一个机器人产品采用了仿狗设计，这种形态可能会给人一种更亲切、更熟悉的感觉。

确实，不过自从英剧《黑镜》（Black Mirror）播出后，机器狗的形象突然变得有些令人不安。这说明机器人的心理接受度是个复杂的问题。这也是为什么我认为人形设计在用户理解和接受度方面可能具有优势。

从技术发展的角度来看，你认为在实现机器人特别是人形机器人这个愿景的过程中，还有哪些关键的技术里程碑需要突破？

说实话，我对这个问题也没有非常明确的答案。不过我观察到一个有趣的现象：在人形机器人的开发中，对于下半身运动控制，可能并不适合采用从人类示范中进行模仿学习（Imitation Learning）的方法，因为这涉及到大量的倒立摆控制（Inverted Pendulum Control）等复杂问题。而对于上半身，我们则需要大量的远程操作、数据收集和端到端学习。这导致整个系统需要采用混合架构（Hybrid Architecture）的方案。

在与该领域研究人员的交流中，我注意到他们更多关注的是驱动系统（Actuation)、物体操作（Manipulation）以及精确控制（Digital Manipulation）等具体技术问题。


