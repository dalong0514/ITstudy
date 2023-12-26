## 20231218分析transformer模型的参数量计算量中间激活KVcache

[分析transformer模型的参数量、计算量、中间激活、KV cache - 知乎](https://zhuanlan.zhihu.com/p/624740065)

分析 transformer 模型的参数量、计算量、中间激活、KV cache

回旋托马斯 x

### 01. 前言

最近，OpenAI 推出的 ChatGPT 展现出了卓越的性能，引发了大规模语言模型 (Large Language Model, LLM) 的研究热潮。大规模语言模型的「大」体现在两个方面：模型参数规模大，训练数据规模大。以 GPT3 为例，GPT3 的参数量为 1750 亿，训练数据量达到了 570GB。进而，训练大规模语言模型面临两个主要挑战：显存效率和计算效率。

现在业界的大语言模型都是基于 transformer 模型的，模型结构主要有两大类：encoder-decoder（代表模型是 T5）和 decoder-only，具体的，decoder-only 结构又可以分为 Causal LM（代表模型是 GPT 系列）和 Prefix LM（代表模型是 GLM）。归因于 GPT 系列取得的巨大成功，大多数的主流大语言模型都采用 Causal LM 结构。因此，针对 decoder-only 框架，为了更好地理解训练训练大语言模型的显存效率和计算效率，本文分析采用 decoder-only 框架 transformer 模型的模型参数量、计算量、中间激活值、KV cache。

为了方便分析，先定义好一些数学符号。记 transformer 模型的层数为 l，隐藏层维度为 h，注意力头数为 a。词表大小为 V
，训练数据的批次大小为 b，序列长度为 s。

### 02. 模型参数量

transformer 模型由 l 个相同的层组成，每个层分为两部分：self-attention 块和 MLP 块。

self-attention 块的模型参数有 Q、K、V 的权重矩阵 WQ、WK、WV 和偏置，输出权重矩阵 WO 和偏置，4 个权重矩阵的形状为 [h,h]，4 个偏置的形状为 [h]。self- attention 块的参数量为 4h^2+4h。

MLP 块由 2 个线性层组成，一般地，第一个线性层是先将维度从 h 映射到 4h，第二个线性层再将维度从 4h 映射到 h。第一个线性层的权重矩阵 W1 的形状为 [h,4h]，偏置的形状为 [h]。第二个线性层权重矩阵 W2 的形状为 [4h,h]，偏置形状为 [h]。MLP 块的参数量为 8h^2+5h。

self-attention 块和 MLP 块各有一个 layer normalization，包含了 2 个可训练模型参数：缩放参数 γ 和平移参数 ß，形状都是 [h]。2 个 layer normalization 的参数量为 4h。

总的，每个 transformer 层的参数量为 12h^2+13h。

除此之外，词嵌入矩阵的参数量也较多，词向量维度通常等于隐藏层维度 h，词嵌入矩阵的参数量为 Vh。最后的输出层的权重矩阵通常与词嵌入矩阵是参数共享的。

关于位置编码，如果采用可训练式的位置编码，会有一些可训练模型参数，数量比较少。如果采用相对位置编码，例如 RoPE 和 ALiBi，则不包含可训练的模型参数。我们忽略这部分参数。

综上，l 层 transformer 模型的可训练模型参数量为 l(12h^2+13h)+Vh。当隐藏维度 h 较大时，可以忽略一次项，模型参数量近似为 12lh^2。

接下来，我们估计不同版本 LLaMA 模型的参数量。

| 实际参数量 | 隐藏维度 h | 层数 l | 12lh^2 |
| --- | --- | --- | --- |
| 6.7B | 4096 | 32 | 6,442,450,944 |
| 13.0B | 5120 | 40 | 12,582,912,000 |
| 32.5B | 6656 | 60 | 31,897,681,920 |
| 65.2B | 8192 | 80 | 64,424,509,440 |

#### 2.1 训练过程中的显存占用分析

在训练神经网络的过程中，占用显存的大头主要分为四部分：模型参数、前向计算过程中产生的中间激活、后向传递计算得到的梯度、优化器状态。这里着重分析参数、梯度和优化器状态的显存占用，中间激活的显存占用后面会详细介绍。训练大模型时通常会采用 AdamW 优化器，并用混合精度训练来加速训练，基于这个前提分析显存占用。

在一次训练迭代中，每个可训练模型参数都会对应 1 个梯度，并对应 2 个优化器状态（Adam 优化器梯度的一阶动量和二阶动量）。设模型参数量为 Φ，那么梯度的元素数量为 Φ，AdamW 优化器的元素数量为 2Φ。float16 数据类型的元素占 2 个 bytes，float32 数据类型的元素占 4 个 bytes。在混合精度训练中，会使用 float16 的模型参数进行前向传递和后向传递，计算得到 float16 的梯度；在优化器更新模型参数时，会使用 float32 的优化器状态、float32 的梯度、float32 的模型参数来更新模型参数。因此，对于每个可训练模型参数，占用了 (2+4)+(2+4)+(4+4)=20bytes。使用 AdamW 优化器和混合精度训练来训练参数量为 Φ 的大模型，模型参数、梯度和优化器状态占用的显存大小为 20Φ bytes 。

weight(2+4) + gradients(2+4) + Adam states(4+4) = 20 bytes

#### 2.2 推理过程中的显存占用分析

在神经网络的推理阶段，没有优化器状态和梯度，也不需要保存中间激活。少了梯度、优化器状态、中间激活，模型推理阶段占用的显存要远小于训练阶段。模型推理阶段，占用显存的大头主要是模型参数，如果使用 float16 来进行推理，推理阶段模型参数占用的显存大概是 2Φ bytes 。如果使用 KV cache 来加速推理过程，KV cache 也需要占用显存，KV cache 占用的显存下文会详细介绍。此外，输入数据也需要放到 GPU 上，还有一些中间结果（推理过程中的中间结果用完会尽快释放掉），不过这部分占用的显存是很小的，可以忽略。

### 03. 计算量 FLOPs 估计

FLOPs，floating point operations，表示浮点数运算次数，衡量了计算量的大小。

如何计算矩阵乘法的 FLOPs 呢？

对于 A\in R^{1\times n},B\in R^{n\times 1} ，计算 AB 需要进行 n 次乘法运算和 n 次加法运算，共计 2n 次浮点数运算，需要 2n 的 FLOPs。对于 A\in R^{m\times n},B\in R^{n\times p} ，计算 AB 需要的浮点数运算次数为 2mnp 。

在一次训练迭代中，假设输入数据的形状为 [b,s] 。我们先分析 self-attention 块的计算，计算公式如下：

Q=xW_Q,K=xW_K,V=xW_V\\x_{out}=softmax(\frac{QK^{T}}{\sqrt{h}})\cdot V\cdot W_o + x\\

1. 计算 Q,K,V ：矩阵乘法的输入和输出形状为 [b,s,h] \times [h,h]\rightarrow [b,s,h] 。计算量为 3*2bsh^2=6bsh^2 。

2. QK^{T} 矩阵乘法的输入和输出形状为 [b, head\_num, s,per\_head\_hidden\_size]\times [b,head\_num,per\_head\_hidden\_size,s]\rightarrow [b,head\_num,s,s] 。计算量为 2bs^2h 。

3. 计算在 V 上的加权 score\cdot V ，矩阵乘法的输入和输出形状为 [b,head\_num,s,s]\times [b,head\_num,s,per\_head\_hidden\_size]\rightarrow [b,head\_num,s,per\_head\_hidden\_size] 。计算量为 2bs^2h 。

4. attention 后的线性映射，矩阵乘法的输入和输出形状为 [b,s,h]\times [h,h]\rightarrow [b,s,h] 。计算量为 2bsh^2 。

接下来分析 MLP 块的计算，计算公式如下：

x=f_{gelu}(x_{out}W_1)W_2+x_{out}\\

1. 第一个线性层，矩阵乘法的输入和输出形状为 [b,s,h]\times [h,4h]\rightarrow [b,s,4h] 。计算量为 8bsh^2 。

2. 第二个线性层，矩阵乘法的输入和输出形状为 [b,s,4h]\times [4h,h]\rightarrow [b,s,h] 。计算量为 8bsh^2 。

将上述计算量相加，得到每个 transformer 层的计算量大约为 24bsh^2+4bs^2h 。

此外，另一个计算量的大头是 logits 的计算，将隐藏向量映射为词表大小。矩阵乘法的输入和输出形状为 [b,s,h]\times [h,V]\rightarrow [b,s,V] ，计算量为 2bshV 。

因此，对于一个 l 层的 transformer 模型，输入数据形状为 [b,s] 的情况下，一次训练迭代的计算量为 l*(24bsh^2+4bs^2h)+2bshV 。

#### 3.1 计算量与参数量的关联

当隐藏维度 h 比较大，且远大于序列长度 s 时，我们可以忽略一次项，计算量可以近似为 24bsh^2*l 。前面提到当模型参数量为 12lh^2 ，输入的 tokens 数为 bs ，存在等式 \frac {24bsh^2l}{12h^2\times bs}=2 。我们可以近似认为：在一次前向传递中，对于每个 token，每个模型参数，需要进行 2 次浮点数运算，即一次乘法法运算和一次加法运算。

一次训练迭代包含了前向传递和后向传递，后向传递的计算量是前向传递的 2 倍。因此，前向传递 + 后向传递的系数 =1+2=3 。一次训练迭代中，对于每个 token，每个模型参数，需要进行 2*3=6 次浮点数运算。

接下来，我们可以估计训练 GPT3-175B 所需要的计算量。对于 GPT3，每个 token，每个参数进行了 6 次浮点数运算，再乘以参数量和总 tokens 数就得到了总的计算量。GPT3 的模型参数量为 174600M ，训练数据量为 300B tokens。

6 \times 174600 \times 10^{6} \times 300 \times 10^{9} = 3.1428 \times 10^{23} flops\\

#### 3.2 训练时间估计

模型参数量和训练总 tokens 数决定了训练 transformer 模型需要的计算量。给定硬件 GPU 类型的情况下，可以估计所需要的训练时间。给定计算量，训练时间（也就是 GPU 算完这么多 flops 的计算时间）不仅跟 GPU 类型有关，还与 GPU 利用率有关。计算端到端训练的 GPU 利用率时，不仅要考虑前向传递和后向传递的计算时间，还要 ** 考虑 CPU 加载数据、优化器更新、多卡通信和记录日志的时间。一般来讲，GPU 利用率一般在 0.3\sim0.55 之间。

上文讲到一次前向传递中，对于每个 token，每个模型参数，进行 2 次浮点数计算。使用激活重计算技术来减少中间激活显存（下文会详细介绍）需要进行一次额外的前向传递，因此前向传递 + 后向传递 + 激活重计算的系数 = 1+2+1=4。使用激活重计算的一次训练迭代中，对于每个 token，每个模型参数，需要进行 2*4=8 次浮点数运算。在给定训练 tokens 数、硬件环境配置的情况下，训练 transformer 模型的计算时间为：

训练时间 \approx \frac {8\times tokens 数 \times 模型参数量}{GPU 数 \times GPU 峰值 flops\times GPU 利用率}\\

以 GPT3-175B 为例，在 1024 张 40GB 显存的 A100 上，在 300B tokens 的数据上训练 175B 参数量的 GPT3。40GB 显存 A100 的峰值性能为 312TFLOPS，设 GPU 利用率为 0.45，则所需要的训练时间为 34 天，这与 [7] 中的训练时间是对得上的。\frac {8\times (300 \times 10^9) \times (175 \times 10^9)}{1024\times (312\times 10^{12})\times 0.45}\approx 2921340 \space seconds\approx 34 days\\

以 LLaMA-65B 为例，在 2048 张 80GB 显存的 A100 上，在 1.4TB tokens 的数据上训练了 65B 参数量的模型。80GB 显存 A100 的峰值性能为 624TFLOPS，设 GPU 利用率为 0.3，则所需要的训练时间为 21 天，这与 [4] 中的实际训练时间是对得上的。\frac {8\times (1.4\times 10^{12})\times (65\times 10^9)}{2048\times (624\times 10^{12})\times 0.3}\approx 1898871\space seconds\approx 21 days\\

### 04. 中间激活值分析

除了模型参数、梯度、优化器状态外，占用显存的大头就是前向传递过程中计算得到的中间激活值了，需要保存中间激活以便在后向传递计算梯度时使用。这里的激活（activations）指的是：前向传递过程中计算得到的，并在后向传递过程中需要用到的所有张量。这里的激活不包含模型参数和优化器状态，但包含了 dropout 操作需要用到的 mask 矩阵。

在分析中间激活的显存占用时，只考虑激活占用显存的大头，忽略掉一些小的 buffers。比如，对于 layer normalization，计算梯度时需要用到层的输入、输入的均值 \mu 和方差 \sigma^2 。输入包含了 bsh 个元素，而输入的均值和方差分别包含了 bs 个元素。由于 h 通常是比较大的（千数量级），有 bsh\gg bs 。因此，对于 layer normalization，中间激活近似估计为 bsh ，而不是 bsh + 2bs 。

大模型在训练过程中通常采用混合精度训练，中间激活值一般是 float16 或者 bfloat16 数据类型的。在分析中间激活的显存占用时，假设中间激活值是以 float16 或 bfloat16 数据格式来保存的，每个元素占了 2 个 bytes。唯一例外的是，dropout 操作的 mask 矩阵，每个元素只占 1 个 bytes。在下面的分析中，单位是 bytes，而不是元素个数。

每个 transformer 层包含了一个 self-attention 块和 MLP 块，并分别对应了一个 layer normalization 连接。

先分析 self-attention 块的中间激活。self-attention 块的计算公式如下：

Q=xW_Q,K=xW_K,V=xW_V\\

x_{out}=softmax(\frac{QK^{T}}{\sqrt{h}})\cdot V\cdot W_o + x\\

1. 对于 Q,K,V ，需要保存它们共同的输入 x ，这就是中间激活。输入 x 的形状为 [b,s,h] ，元素个数为 bsh ，占用显存大小为 2*bsh=2bsh 。

2. 对于 QK^T 矩阵乘法，需要保存中间激活 Q,K ，两个张量的形状都是 [b,s,h] ，占用显存大小合计为 2*2*bsh=4bsh 。

3. 对于 softmax () 函数，需要保存函数的输入 QK^T ，占用显存大小为 2bs^2a ，这里的 a 表示注意力头数。score = softmax (\frac {QK^T}{\sqrt {d_k}})\\

Q 的形状为： [b, head\_num, s, per\_head\_hidden\_size]

K^{T} 的形状为： [b,head\_num,per\_head\_hidden\_size,s]

QK^T 的形状为： [b,head\_num,s,s] ，元素个数为 bs^2a ，占用显存大小为 2bs^2a 。

4. 计算完 softmax () 函数后，会进行 dropout 操作。需要保存一个 mask 矩阵，mask 矩阵的形状与 QK^T 相同，占用显存大小为 bs^2a 。

5. 计算在 V 上的 attention，即 score\cdot V ，需要保存 score ，大小为 2bs^2a ；以及 V ，大小为 2bsh 。二者占用显存大小合计为 2bs^2a+2bsh 。

6. 计算输出映射以及一个 dropout 操作。输入映射需要保存其输入，大小为 2bsh ；dropout 需要保存 mask 矩阵，大小为 bsh 。二者占用显存大小合计为 3bsh 。

因此，将上述中间激活相加得到，self-attention 块的中间激活占用显存大小为 11bsh+5bs^2a 。

接下来看 MLP 块的中间激活。MLP 块的计算公式如下： x=f_{gelu}(x_{out} W_1) W_2+x_{out}\\

1. 第一个线性层需要保存其输入，占用显存大小为 2bsh 。

2. 激活函数需要保存其输入，占用显存大小为 8bsh 。

3. 第二个线性层需要保存其输入，占用显存大小为 8bsh 。

4. 最后有一个 dropout 操作，需要保存 mask 矩阵，占用显存大小为 bsh 。

对于 MLP 块，需要保存的中间激活值为 19bsh 。

另外，self-attention 块和 MLP 块分别对应了一个 layer normalization。每个 layer norm 需要保存其输入，大小为 2bsh 。2 个 layer norm 需要保存的中间激活为 4bsh 。

综上，每个 transformer 层需要保存的中间激活占用显存大小为 34bsh+5bs^2a 。对于 l 层 transformer 模型，还有 embedding 层、最后的输出层。embedding 层不需要中间激活。总的而言，当隐藏维度 h 比较大，层数 l 较深时，这部分的中间激活是很少的，可以忽略。因此，对于 l 层 transformer 模型，中间激活占用的显存大小可以近似为 (34bsh+5bs^2a)*l 。

#### 4.1 对比中间激活与模型参数的显存大小

在一次训练迭代中，模型参数（或梯度）占用的显存大小只与模型参数量和参数数据类型有关，与输入数据的大小是没有关系的。优化器状态占用的显存大小也是一样，与优化器类型有关，与模型参数量有关，但与输入数据的大小无关。而中间激活值与输入数据的大小（批次大小 b 和序列长度 s ）是成正相关的，随着批次大小 b 和序列长度 s 的增大，中间激活占用的显存会同步增大。当我们训练神经网络遇到显存不足 OOM（Out Of Memory）问题时，通常会尝试减小批次大小来避免显存不足的问题，这种方式减少的其实是中间激活占用的显存，而不是模型参数、梯度和优化器的显存。

以 GPT3-175B 为例，我们来直观地对比下模型参数与中间激活的显存大小。GPT3 的模型配置如下。我们假设采用混合精度训练，模型参数和中间激活都采用 float16 数据类型，每个元素占 2 个 bytes。

| 模型名 | 参数量 | 层数 | 隐藏维度 | 注意力头数 |
| --- | --- | --- | --- | --- |
| GPT3 | 175B | 96 | 12288 | 96 |

GPT3 的模型参数量为 175B，占用的显存大小为 2\times 175\times 10^9bytes=350GB 。GPT3 模型需要占用 350GB 的显存。

GPT3 的序列长度 s 为 2048 。对比不同的批次大小 b 占用的中间激活：

当 b=1 时，中间激活占用显存为 (34bsh+5bs^2a)*l=275,414,777,856bytes\approx275GB ，大约是模型参数显存的 0.79 倍。

当 b=64 时，中间激活占用显存为 (34bsh+5bs^2a)*l=17,626,545,782,784bytes\approx17.6TB ，大约是模型参数显存的 50 倍。

当 b=128 时，中间激活占用显存为 (34bsh+5bs^2a)*l=35,253,091,565,568bytes\approx35.3TB ，大约是模型参数显存的 101 倍。

可以看到随着批次大小 b 的增大，中间激活占用的显存远远超过了模型参数显存。通常会采用激活重计算技术来减少中间激活，理论上可以将中间激活显存从 O (n) 减少到 O (\sqrt {n}) ，代价是增加了一次额外前向计算的时间，本质上是「时间换空间」。

### 05. KV cache

在推断阶段，transformer 模型加速推断的一个常用策略就是使用 KV cache。一个典型的大模型生成式推断包含了两个阶段：

1、预填充阶段：输入一个 prompt 序列，为每个 transformer 层生成 key cache 和 value cache（KV cache）。

2、解码阶段：使用并更新 KV cache，一个接一个地生成词，当前生成的词依赖于之前已经生成的词。

第 i 个 transformer 层的权重矩阵为 W^i_Q,W^i_K,W^i_V,W^i_O,W^i_1,W^i_2。其中，self-attention 块的 4 个权重矩阵 W^i_Q,W^i_K,W^i_V,W^i_O\in R^{h\times h}，并且 MLP 块的 2 个权重矩阵 W^i_1\in R^{h\times 4h},W^i_2\in R^{4h\times h} 。

预填充阶段：

假设第 i 个 transformer 层的输入为 x^i ，self-attention 块的 key、value、query 和 output 表示为 x^i_K,x^i_V,x^i_Q,x^i_{out} ，其中，x^i_K,x^i_V,x^i_Q,x^i_{out}\in R^{b\times s\times h} 。

key cache 和 value cache 的计算过程为：

x^{i}_{K} = x^{i} \cdot W^{i}_{K}\\x^{i}_{V} = x^{i} \cdot W^{i}_{V}\\

第 i 个 transformer 层剩余的计算过程为：

x^{i}_{Q} = x^{i} \cdot W^{i}_{Q}\\x^{i}_{out} = softmax(\frac{x^{i}_{Q} {x^{i}_{K}}^{T}}{\sqrt{h}}) \cdot x^{i}_{V} \cdot W^{i}_{O} + x^{i}\\x^{i+1} = f_{gelu}(x^{i}_{out}\cdot W_1) \cdot W_2 + x^{i}_{out}\\

解码阶段：

给定当前生成词在第 i 个 transformer 层的向量表示为 t^{i}\in R^{b\times 1\times h} 。推断计算分两部分：更新 KV cache 和计算第 i 个 transformer 层的输出。

更新 key cache 和 value cache 的计算过程如下：

x^{i}_{K} \leftarrow Concat(x^{i}_{K}, t^{i}\cdot W^{i}_{K})\\

x^{i}_{V} \leftarrow Concat(x^{i}_{V}, t^{i}\cdot W^{i}_{V})\\

第 i 个 transformer 层剩余的计算过程为：

t^{i}_{Q} = t_{i} \cdot W^{i}_{Q}\\

t^{i}_{out} = softmax(\frac{{t^{i}_{Q}x^{i}_{K}}^{T}}{\sqrt{h}}) \cdot x^{i}_{V} \cdot W^{i}_{O} + t^{i}\\t^{i+1} = f_{gelu}(t^{i}_{out}\cdot W_1) \cdot W_2 + t^{i}_{out}\\

#### 5.1 KV cache 的显存占用分析

假设输入序列的长度为 s，输出序列的长度为 n，以 float16 来保存 KV cache，那么 KV cache 的峰值显存占用大小为 b(s+n)h * l * 2 * 2 = 4blh(s+n) 。这里第一个 2 表示 K/V cache，第二个 2 表示 float16 占 2 个 bytes。

以 GPT3 为例，对比 KV cache 与模型参数占用显存的大小。GPT3 模型占用显存大小为 350GB。假设批次大小 b=64，输入序列长度 s=512，输出序列长度 n=32，则 KV cache 占用显存为 4blh(s+n)=164,282,499,072bytes≈164GB，大约是模型参数显存的 0.5 倍。

### 06. 总结

本文首先介绍了如何计算 transformer 模型的参数量，基于参数量可以进一步估计模型参数、梯度和优化器状态占用的显存大小。接着，本文估计了训练迭代中，在给定训练 tokens 数的情况下 transformer 模型的计算量，给予计算量和显卡性能可以进一步估计训练迭代的计算耗时。然后，本文分析了 transformer 模型前向计算过程中产生的中间激活值的显存大小，中间激活的显存大小与输入数据大小正相关，甚至会远超过模型参数占用的显存。最后，本文介绍了 transformer 模型推理过程常用的加速策略：使用 KV cache。总的来说，分析 transformer 模型的参数量、计算量、中间激活和 KV cache，有助于理解大模型训练和推断过程中的显存效率和计算效率。

### 07. 参考链接

1. Raffel C, Shazeer N, Roberts A, et al. Exploring the limits of transfer learning with a unified text-to-text transformer[J]. The Journal of Machine Learning Research, 2020, 21(1): 5485-5551.

2. Vaswani A, Shazeer N, Parmar N, et al. Attention is all you need[J]. Advances in neural information processing systems, 2017, 30.

3. Brown T, Mann B, Ryder N, et al. Language models are few-shot learners[J]. Advances in neural information processing systems, 2020, 33: 1877-1901.

4. Touvron H, Lavril T, Izacard G, et al. Llama: Open and efficient foundation language models[J]. arXiv preprint arXiv:2302.13971, 2023.

5. Sheng Y, Zheng L, Yuan B, et al. High-throughput generative inference of large language models with a single gpu[J]. arXiv preprint arXiv:2303.06865, 2023.

6. Korthikanti V, Casper J, Lym S, et al. Reducing activation recomputation in large transformer models[J]. arXiv preprint arXiv:2205.05198, 2022.

7. Narayanan D, Shoeybi M, Casper J, et al. Efficient large-scale language model training on gpu clusters using megatron-lm[C]//Proceedings of the International Conference for High Performance Computing, Networking, Storage and Analysis. 2021: 1-15.

8. Smith S, Patwary M, Norick B, et al. Using deepspeed and megatron to train megatron-turing nlg 530b, a large-scale generative language model[J]. arXiv preprint arXiv:2201.11990, 2022.

编辑于 2023-06-08 20:55·IP 属地天津