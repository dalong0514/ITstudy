## 20250116Will-NVIDIAs-Project-DIGITS-kill-the-M4-Max-for-AI

[Will NVIDIA’s Project DIGITS kill the M4 Max for AI? | by Andreas Kunar | Jan, 2025 | Medium](https://medium.com/@andreask_75652/will-nvidias-project-digits-kill-apple-m4-max-ai-2729bf55427e)

Will NVIDIA’s Project DIGITS kill the M4 Max for AI?

Andreas Kunar

2025-01-11

With NVIDIA announcing their Project DIGITS on Jan 6th, 2025, Apple finally got competition in the “low-cost”/large-memory AI world. That’s great news!

随着 NVIDIA 在 2025 年 1 月 6 日宣布他们的 Project DIGITS，苹果在「低成本」和「大内存」的 AI 应用领域终于迎来了竞争对手。这真是个好消息！

Apple’s prices might seem high, but a M4 Max with 128GB RAM is much cheaper than e.g. a PC with an 80GB NVIDIA A100 card. Yes, the A100 is much faster in both compute horsepower (probably more than 20x) and memory-bandwidth (4x higher), but it’s many more times expensive and consumes similarly more power. On the other hand, Apples M-series Pro/Max is much faster for 48-128GB memory AI, than any PC or server without a large NVIDIA or AMD accelerator. This opened a niche for Apple M-series Max/Ultra computers, which NVIDIA apparently wants to address. Positioned with an aggressive price-point (starting at USD 3,000) vs. a fully-spec’ed M4 Max MacBook Pro or a potential, future M4 Max/Ultra Mac Studio from Apple.

苹果产品的价格可能看起来偏高，但配备 128GB 内存的 M4 Max 芯片的设备，要比配备 80GB NVIDIA A100 显卡的 PC 便宜不少。的确，A100 在计算能力上远超 M4 Max（可能超过 20 倍），内存带宽也高出 4 倍，但其价格也贵得多，功耗也高得多。另一方面，对于使用 48-128GB 内存的 AI 应用来说，苹果 M 系列 Pro/Max 芯片的性能要比任何没有大型 NVIDIA 或 AMD 加速器的 PC 或服务器快得多。这使得苹果 M 系列 Max/Ultra 计算机找到了自己的市场定位，而 NVIDIA 显然也想进入这个市场。NVIDIA 的产品定位是具有竞争力的价格（起价 3,000 美元），以对抗满配的 M4 Max MacBook Pro，以及苹果未来可能推出的 M4 Max/Ultra Mac Studio。

Here are my performance-estimate/-expectations, when looking at Project DIGITS’ currently published information:

根据 Project DIGITS 目前公布的信息，我对它的性能做出了如下的估计和期望：

It looks like an 8-chip (= 512Bit wide ?) LPDDR5X RAM system — the same as an M4 Max, so it might have an approx. 550GB/s memory-bandwidth (1/4 that of their 5090). Since LLM token-generation performance (if it cannot be batched) is largely constrained by memory-bandwidth. So, one probably cannot expect a break-through in pure LLM response-performance vs. a M4 Max, and a future M4 Ultra could be 2x faster.

它似乎采用了 8 颗芯片组成的 LPDDR5X 内存系统（可能是 512 位宽），这与 M4 Max 相同，因此其内存带宽可能约为 550GB/s，是其 5090 的四分之一。由于大语言模型（LLM）的 Token 生成速度，在无法进行批量处理的情况下，很大程度上取决于内存带宽。因此，在纯大语言模型响应速度上，我们可能无法期待它比 M4 Max 有显著提升，而未来的 M4 Ultra 可能会快 2 倍。

But LLM prompt-processing, training and batched processing will probably be many times faster on Project DIGITS than currently on Apple, due to its expected much, much stronger compute horsepower (but which likely also has a higher power-consumption demand). A limit for its GPU horsepower is the form-factor/TDP (Thermal Design). The probably similarly sized Mac mini can currently sustain max. 140W power-consumption for its CPU/GPU/ANE/RAM/SSD at full utilization. The base Mac Studio is much larger and can dissipate max. 150W (but with a lot of extra cooling headroom), and with the Ultra’s better cooler it can easily handle max. 300W. If Project DIGITS has a 150W power-envelope, its system could be limited to a sustained performance that is only a bit higher than an M4 Max.

但是，由于 Project DIGITS 预计拥有更强大的算力（compute horsepower）（但也可能具有更高的功率消耗（power-consumption）需求），大语言模型（LLM）提示处理、训练和批量处理可能比目前在 Apple 上快很多倍。其 GPU 性能的限制在于 TDP（热设计功耗（Thermal Design)）。可能尺寸相似的 Mac mini 目前在完全利用的情况下，其 CPU/GPU/ANE/RAM/SSD 的最大功率消耗可维持在 140W。基本款 Mac Studio 的体积大得多，可以散发最大 150W 的热量（但具有很大的额外散热空间），而 Ultra 更好的散热器可以轻松处理最大 300W 的热量。如果 Project DIGITS 的功率限制（power-envelope）为 150W，其系统的持续运行性能（sustained performance）可能仅比 M4 Max 稍高一些。

A Project DIGITS strong advantage is NVLink, the ability to connect it into a cluster. Its speed is currently not specified, but it’s expected to be multiple times faster than Apple’s Thunderbolt 5 as a connection.

Project DIGITS 的一个显著优势是 NVLink，它能够将 Project DIGITS 连接到集群中。目前 NVLink 的速度尚未公布，但预计作为一种连接方式，其速度将比 Apple 的 Thunderbolt 5 快数倍。

But what really sets Project DIGITS apart might not be the hardware. The killer-features might be CUDA and other software. For me, the major gaps Apple has in low-end/high-RAM ML system-software — which I expect NVIDIA to fill with project DIGITS — are:

但是，真正让 DIGITS 项目脱颖而出的可能并非硬件本身，其关键特性或许是 CUDA 和其他软件。对我而言，苹果在低端 / 高内存的机器学习（ML）系统软件方面存在的主要不足 —— 我期望 NVIDIA 通过 DIGITS 项目来弥补这些不足 —— 包括：

a) MPS/MLX vs. CUDA — support for modern floating-point formats like fp8 (and others) doesn’t even seem to be on Apple MPS’s radar. Apple’s Pytorch support and MLX are progressing, but still with gaps, forcing calculations to the CPU. And don’t even think about all the nice NVIDIA AI software announcements which just happened …

a）MPS/MLX 与 CUDA — 诸如 fp8（以及其他）这样的现代浮点格式的支持，似乎甚至不在 Apple MPS 的计划中。苹果的 Pytorch 支持和 MLX 正在发展，但仍然存在差距，导致部分计算只能在 CPU 上进行。更不用说 NVIDIA 刚刚发布的所有 AI 软件公告了...

b) Missing GPU-virtualization — not being able to run GPU-dependent software in containers or VMs on Apple is a huge drawback — e.g. for security reasons. Do you totally trust the entire supply-chain of all the (open-source) apps and their dependencies you use? Ones that update weekly or daily? Containerized isolation helps. I passionately hate to use dual-boot for my M2 Max Mac Studio for “sandboxed” dev/AI work — VMs/Containers are much nicer/easier.

b）GPU 虚拟化缺失 —— 在 Apple 设备上，无法在容器或虚拟机中运行依赖 GPU 的软件，这是一个巨大的缺点，例如出于安全考虑。你是否完全信任你所使用的所有（开源）应用程序及其依赖项的整个供应链？特别是那些每周甚至每天都会更新的程序？容器化的隔离机制对此有所帮助。我非常不喜欢为了进行「沙盒」开发或 AI 工作，而在我的 M2 Max Mac Studio 上使用双启动，虚拟机 / 容器的方式更好、更方便。

This is why I’m thinking about getting a project DIGITS box. And I probably will get me a cheap Jetson Nano Orion Super Developer Kit in the interim. To learn NVIDIA’s software-stack, which I expect to be quite similar. Even if the performance of this “Jetson Nano Orin Super” should only be somewhat similar to an 8GB M2 Mac mini. Maybe that’s the reason why NVIDIA dropped the price for it to below 1/2 of the base M4 Mac mini with 16GB. NVIDIA’s 16GB Jetson Orin NX Dev Kit still costs more than USD 900. This is much more expensive than the base M4 Mac mini (even though the Mac’s RAM is faster) — but its running CUDA and the NVIDIA stack.

这就是为什么我正在考虑入手一个 DIGITS 项目设备。同时，我可能会先买一个便宜的 Jetson Nano Orin 开发者套件。目的是学习 NVIDIA 的软件堆栈（software-stack），我预计它们会非常相似。即使这个「Jetson Nano Orin Super」的性能可能只和 8GB 的 M2 Mac mini 有些接近。也许这就是 NVIDIA 将其价格降到基本款 16GB M4 Mac mini 一半以下的原因。NVIDIA 的 16GB Jetson Orin NX 开发套件仍然要 900 美元以上。这比基本款 M4 Mac mini 贵得多（即使 Mac 的 RAM 速度更快）—— 但它运行的是 CUDA 和 NVIDIA 的软件堆栈。

I had switched entirely to Apple silicon (Ok, I also have a Snapdragon X Elite Laptop). And they do not support NVIDIA (e)GPUs for AI. But now it could finally work out …

我已经完全改用 Apple 芯片了（当然，我还有一台 Snapdragon X Elite 笔记本电脑）。这两者都不支持 NVIDIA 的（e）GPU 用于 AI 计算。不过现在，这种情况可能终于要改变了…

Author’s Note: This is a quick first-reaction. I will try and update it as more information becomes available.

作者注：这只是我快速的第一印象。我会在获得更多信息后尝试更新。

2025–01–11: Updated with more ideas on thermals and NVLink

## 原文

Will NVIDIA’s Project DIGITS kill the M4 Max for AI?

Andreas Kunar

2025-01-11

With NVIDIA announcing their Project DIGITS on Jan 6th, 2025, Apple finally got competition in the “low-cost”/large-memory AI world. That’s great news!

Apple’s prices might seem high, but a M4 Max with 128GB RAM is much cheaper than e.g. a PC with an 80GB NVIDIA A100 card. Yes, the A100 is much faster in both compute horsepower (probably more than 20x) and memory-bandwidth (4x higher), but it’s many more times expensive and consumes similarly more power. On the other hand, Apples M-series Pro/Max is much faster for 48-128GB memory AI, than any PC or server without a large NVIDIA or AMD accelerator. This opened a niche for Apple M-series Max/Ultra computers, which NVIDIA apparently wants to address. Positioned with an aggressive price-point (starting at USD 3,000) vs. a fully-spec’ed M4 Max MacBook Pro or a potential, future M4 Max/Ultra Mac Studio from Apple.

Here are my performance-estimate/-expectations, when looking at Project DIGITS’ currently published information:

It looks like an 8-chip (= 512Bit wide ?) LPDDR5X RAM system — the same as an M4 Max, so it might have an approx. 550GB/s memory-bandwidth (1/4 that of their 5090). Since LLM token-generation performance (if it cannot be batched) is largely constrained by memory-bandwidth. So, one probably cannot expect a break-through in pure LLM response-performance vs. a M4 Max, and a future M4 Ultra could be 2x faster.

But LLM prompt-processing, training and batched processing will probably be many times faster on Project DIGITS than currently on Apple, due to its expected much, much stronger compute horsepower (but which likely also has a higher power-consumption demand). A limit for its GPU horsepower is the form-factor/TDP (Thermal Design). The probably similarly sized Mac mini can currently sustain max. 140W power-consumption for its CPU/GPU/ANE/RAM/SSD at full utilization. The base Mac Studio is much larger and can dissipate max. 150W (but with a lot of extra cooling headroom), and with the Ultra’s better cooler it can easily handle max. 300W. If Project DIGITS has a 150W power-envelope, its system could be limited to a sustained performance that is only a bit higher than an M4 Max.

A Project DIGITS strong advantage is NVLink, the ability to connect it into a cluster. Its speed is currently not specified, but it’s expected to be multiple times faster than Apple’s Thunderbolt 5 as a connection.

But what really sets Project DIGITS apart might not be the hardware. The killer-features might be CUDA and other software. For me, the major gaps Apple has in low-end/high-RAM ML system-software — which I expect NVIDIA to fill with project DIGITS — are:

a) MPS/MLX vs. CUDA — support for modern floating-point formats like fp8 (and others) doesn’t even seem to be on Apple MPS’s radar. Apple’s Pytorch support and MLX are progressing, but still with gaps, forcing calculations to the CPU. And don’t even think about all the nice NVIDIA AI software announcements which just happened …

b) Missing GPU-virtualization — not being able to run GPU-dependent software in containers or VMs on Apple is a huge drawback — e.g. for security reasons. Do you totally trust the entire supply-chain of all the (open-source) apps and their dependencies you use? Ones that update weekly or daily? Containerized isolation helps. I passionately hate to use dual-boot for my M2 Max Mac Studio for “sandboxed” dev/AI work — VMs/Containers are much nicer/easier.

This is why I’m thinking about getting a project DIGITS box. And I probably will get me a cheap Jetson Nano Orion Super Developer Kit in the interim. To learn NVIDIA’s software-stack, which I expect to be quite similar. Even if the performance of this “Jetson Nano Orin Super” should only be somewhat similar to an 8GB M2 Mac mini. Maybe that’s the reason why NVIDIA dropped the price for it to below 1/2 of the base M4 Mac mini with 16GB. NVIDIA’s 16GB Jetson Orin NX Dev Kit still costs more than USD 900. This is much more expensive than the base M4 Mac mini (even though the Mac’s RAM is faster) — but its running CUDA and the NVIDIA stack.

I had switched entirely to Apple silicon (Ok, I also have a Snapdragon X Elite Laptop). And they do not support NVIDIA (e)GPUs for AI. But now it could finally work out …

Author’s Note: This is a quick first-reaction. I will try and update it as more information becomes available.

2025–01–11: Updated with more ideas on thermals and NVLink

