## How I became a machine learning practitioner

[How I became a machine learning practitioner](https://blog.gregbrockman.com/how-i-became-a-machine-learning-practitioner)

GREG BROCKMAN

Greg Brockman is writing on the SVBTLE network.

gregbrockman.com

JULY 30, 2019

For the first three years of OpenAI, I dreamed of becoming a machine learning expert but made little progress towards that goal. Over the past nine months, I’ve finally made the transition to being a machine learning practitioner. It was hard but not impossible, and I think most people who are good programmers and know (or are willing to learn) the math can do it too. There are many online courses to self-study the technical side, and what turned out to be my biggest blocker was a mental barrier — getting ok with being a beginner again.

gdb-ml1.pngStudying machine learning during the 2018 holiday season.

### Early days

A founding principle of OpenAI is that we value research and engineering equally — our goal is to build working systems that solve previously impossible tasks, so we need both. (In fact, our team is comprised of 25% people primarily using software skills, 25% primarily using machine learning skills, and 50% doing a hybrid of the two.) So from day one of OpenAI, my software skills were always in demand, and I kept procrastinating on picking up the machine learning skills I wanted.

After helping build OpenAI Gym, I was called to work on Universe. And as Universe was winding down, we decided to start working on Dota — and we needed someone to turn the game into a reinforcement learning environment before any machine learning could begin.

Dota#
Turning such a complex game into a research environment without source code access was awesome work, and the team’s excitement every time I overcame a new obstacle was deeply validating. I figured out how to break out of the game’s Lua sandbox, LD_PRELOAD in a Go GRPC server to programmatically control the game, incrementally dump the whole game state into a Protobuf, and build a Python library and abstractions with future compatibility for the many different multiagent configurations we might want to use.

But I felt half blind. At Stripe, though I gravitated towards infrastructure solutions, I could make changes anywhere in the stack since I knew the product code intimately. In Dota, I was constrained to looking at all problems through a software lens, which sometimes meant I tried to solve hard problems that could be avoided by just doing the machine learning slightly differently.

I wanted to be like my teammates Jakub Pachocki and Szymon Sidor, who had made the core breakthrough that powered our Dota bot. They had questioned the common wisdom within OpenAI that reinforcement algorithms didn’t scale. They wrote a distributed reinforcement learning framework called Rapid and scaled it exponentially every two weeks or so, and we never hit a wall with it. I wanted to be able to make critical contributions like that which combined software and machine learning skills.

jakub-szymon-gdb.jpgSzymon on the left; Jakub on the right.

In July 2017, it looked like I might have my chance. The software infrastructure was stable, and I began work on a machine learning project. My goal was to use behavioral cloning to teach a neural network from human training data. But I wasn’t quite prepared for just how much I would feel like a beginner.

I kept being frustrated by small workflow details which made me uncertain if I was making progress, such as not being certain which code a given experiment had used or realizing I needed to compare against a result from last week that I hadn’t properly archived. To make things worse, I kept discovering small bugs that had been corrupting my results the whole time.

I didn’t feel confident in my work, but to make it worse, other people did. People would mention how how hard behavioral cloning from human data is. I always made sure to correct them by pointing out that I was a newbie, and this probably said more about my abilities than the problem.

It all briefly felt worth it when my code made it into the bot, as Jie Tang used it as the starting point for creep blocking which he then fine-tuned with reinforcement learning. But soon Jie figured out how to get better results without using my code, and I had nothing to show for my efforts.

I never tried machine learning on the Dota project again.

Time out#
After we lost two games in The International in 2018, most observers thought we’d topped out what our approach could do. But we knew from our metrics that we were right on the edge of success and mostly needed more training. This meant the demands on my time had relented, and in November 2018, I felt I had an opening to take a gamble with three months of my time.

ti-elevator.pngTeam members in high spirits after losing our first game at The International.

I learn best when I have something specific in mind to build. I decided to try building a chatbot. I started self-studying the curriculum we developed for our Fellows program, selecting only the NLP-relevant modules. For example, I wrote and trained an LSTM language model and then a Transformer-based one. I also read up on topics like information theory and read many papers, poring over each line until I fully absorbed it.

It was slow going, but this time I expected it. I didn’t experience flow state. I was reminded of how I’d felt when I just started programming, and I kept thinking of how many years it had taken to achieve a feeling of mastery. I honestly wasn’t confident that I would ever become good at machine learning. But I kept pushing because… well, honestly because I didn’t want to be constrained to only understanding one part of my projects. I wanted to see the whole picture clearly.

My personal life was also an important factor in keeping me going. I’d begun a relationship with someone who made me feel it was ok if I failed. I spent our first holiday season together beating my head against the machine learning wall, but she was there with me no matter how many planned activities it meant skipping.

One important conceptual step was overcoming a barrier I’d been too timid to do with Dota: make substantive changes to someone else’s machine learning code. I fine-tuned GPT-1 on chat datasets I’d found, and made a small change to add my own naive sampling code. But it became so painfully slow as I tried to generate longer messages that my frustration overwhelmed my fear, and I implemented GPU caching — a change which touched the entire model.

I had to try a few times, throwing out my changes as they exceeded the complexity I could hold in my head. By the time I got it working a few days later, I realized I’d learned something that I would have previously thought impossible: I now understood how the whole model was put together, down to small stylistic details like how the codebase elegantly handles TensorFlow variable scopes.

Retooled#
After three months of self-study, I felt ready to work on an actual project. This was also the first point where I felt I could benefit from the many experts we have at OpenAI, and I was delighted when Jakub and my co-founder Ilya Sutskever agreed to advise me.

ilya.pngIlya singing karaoke at our company offsite.

We started to get very exciting results, and Jakub and Szymon joined the project full-time. I feel proud every time I see a commit from them in the machine learning codebase I’d started.

I’m starting to feel competent, though I haven’t yet achieved mastery. I’m seeing this reflected in the number of hours I can motivate myself to spend focused on doing machine learning work — I’m now around 75% of the number of coding hours from where I’ve been historically.

But for the first time, I feel that I’m on trajectory. At first, I was overwhelmed by the seemingly endless stream of new machine learning concepts. Within the first six months, I realized that I could make progress without constantly learning entirely new primitives. I still need to get more experience with many skills, such as initializing a network or setting a learning rate schedule, but now the work feels incremental rather than potentially impossible.

From our Fellows and Scholars programs, I’d known that software engineers with solid fundamentals in linear algebra and probability can become machine learning engineers with just a few months of self study. But somehow I’d convinced myself that I was the exception and couldn’t learn. But I was wrong — even embedded in the middle of OpenAI, I couldn’t make the transition because I was unwilling to become a beginner again.

You’re probably not an exception either. If you’d like to become a deep learning practitioner, you can. You need to give yourself the space and time to fail. If you learn from enough failures, you’ll succeed — and it’ll probably take much less time than you expect.

At some point, it does become important to surround yourself by existing experts. And that is one place where I’m incredibly lucky. If you’re a great software engineer who reaches that point, keep in mind there’s a way you can be surrounded by the same people as I am — apply to OpenAI!