## 20250104Flow-matching-The-next-frontier-in-Generative-AI

[Flow matching : The next frontier in Generative AI | by Siddhant Rai | Medium](https://medium.com/@rsiddhant73/flow-matching-the-next-frontier-in-generative-ai-7cf02ebbe859)

Flow matching: The next frontier in Generative AI

Siddhant Rai

Aug 13, 2024

Recently Flux series of models by Flux.ai gained lots of attention from the tech and non-tech community for all the right reasons, model is fast, easy to use thanks to diffusers as well as easy to tune (again thanks to diffusers). But, the reason behind Flux brilliant image-text alignment and high quality generations is a new methodology beyond standard diffusion process, called as "Flow matching". In this post I will cover about methods and advancements that lead to flow matching.

[A Better Way to Build PCBs | Flux](https://www.flux.ai/p)

[Flux – The Future of Electronics Design - YouTube](https://www.youtube.com/watch?v=xPW6KDfCIeo&t=180s)

最近，Flux.ai 的 Flux 系列模型因其诸多优点，在科技界和非科技界都引起了广泛关注。该模型速度快、易于使用，并且易于调整，这都得益于 diffusers 库。然而，Flux 模型之所以能够实现出色的图像 —— 文本对齐和高质量的图像生成，其背后的关键是一种名为「流匹配」（Flow matching）的新方法，它超越了标准的扩散过程。在这篇文章中，我将深入探讨促成流匹配方法出现的技术原理和发展历程。

Every generative model is ideally a density estimaor; hence models a probability density, which eventually is a JPD, with two expected characteristics, sampling and compression, compression is basically pushing data to information space, which is seemingly lower dimensional, whereas sampling is ability to generate P(x|z) starting from any characteristic distribution (z), could be normal distribution (as in case of VAE), hence, on a very high level, we are trying to find a map/function that maps z to x as well as x to z (sampling and compression).

理想情况下，每个生成模型都是一个密度估计器，它模拟一个概率密度，最终形成一个联合概率分布（JPD）。生成模型有两个主要特性：采样和压缩。压缩本质上是将数据投射到信息空间，这个空间通常是低维的；而采样则是指从任何特征分布（z）出发，生成 P（x|z）的能力，例如，(z）可以是正态分布（如变分自编码器（VAE）中所示）。因此，从本质上讲，我们试图找到一个映射或函数，它既能将 z 映射到 x，也能将 x 映射到 z（分别对应采样和压缩）。

Let's assume two PDFs one represented as z (latent or tractable distribution) and other as X (data distribution), as we want to find a function that can map z to x, we are presented with a relationship between density of X and Z, which necessarily points out that given X and Z are conjugate distribution (distribution of same familyz before and after transformation), the change in X and Z should be relativistic, hence, change in X is some function of Z and vice versa. But, scaled by some quantity. This quantity is represented by the change across each dimension between z and x, given by Jacobian matrix, on a very simple scale it's basically change of variable between Z and X. But, it's not that simple, as X and Z are not actually conjugate, hence, we are left with iterative sampling and approximation methods, like optimal transport or Gibbs sampling (used in RBMs). Given these restrictions, most of the methods take a detour to model distributions and approximate an non-exact mapping, whereas methods like Normalizing flow, makes simplifying assumption to make the calculation and formulation tractable of form p(x)dx = p(z)dz, which can be reformulated to get two terms, first a MLE term and second a determinant of Jacobian.

假设有两个概率密度函数（PDF），一个表示为 z（潜在的或易于处理的分布），另一个表示为 X（数据分布）。我们希望找到一个函数，可以将 z 映射到 x。这里存在 X 和 Z 的概率密度之间的关系，这表明，如果 X 和 Z 是共轭分布（变换前后属于同一分布族），那么 X 和 Z 的变化应该是相对的。因此，X 的变化是 Z 的某个函数，反之亦然，但需要乘以一个缩放量。这个缩放量由 z 和 x 之间每个维度的变化决定，由雅可比矩阵给出。简单来说，它就是 Z 和 X 之间的变量变换。然而，情况并非如此简单，因为 X 和 Z 实际上并非共轭分布。因此，我们通常采用迭代采样和近似方法，例如最优传输或吉布斯采样（用于 RBM）。考虑到这些限制，大多数方法会转而对分布进行建模，并近似一个非精确的映射。而诸如 Normalizing flow（归一化流）的方法，则会进行简化假设，使得 p（x）dx = p（z）dz 形式的计算和公式变得易于处理。这个等式可以被重新整理为两个部分：第一部分是最大似然估计（Maximum Likelihood Estimation）项，第二部分是雅可比行列式（Jacobian determinant）。

(Normalizing because the change of variables always gives a normalized density function, flow as it models the trajectory/flow from source to target iteratively)

（之所以进行归一化，是因为变量的变换总会产生一个归一化的密度函数。而「流」的概念，指的是它通过迭代的方式，模拟从源头到目标点的轨迹或流动过程）

Problem start from here, for such a function to exist there are two conditions,

要使这样的函数存在，需要满足以下两个条件：

1 MLE formulation for p(x,z) has to be bijective.

关于 p（x,z）的最大似然估计（MLE）公式必须是双射的（bijective）。

2 The determinant of jacobian is efficiently computable.

雅可比行列式是可高效计算的。

Two solve this, we need Assumption of dependency of states across z and X, such that it's bijective and determinant is efficiently computable, there are three major approaches (we won't go very deep in this)

为了解决这个问题，我们需要假设 z 和 X 之间的状态具有依赖关系，并且这种关系是双射的，同时其行列式是可高效计算的。这里有三种主要的方法 （我们在此不做深入讨论）。

1 Coupling blocks : basically you break z into two chunks, only last k value predict X last k value (through mean/variance based sampling), other parts of X is basically direct copy of z, how does it help? Because of this method, the Jacobian becomes a diagonal matrix, the top left (<k) part is identity, the bottom right (>=k) becomes element wise product, the top right becomes 0, as there is no dependency between z(<k) and x(>=k), hence, the determinant of Jacobian is efficient to compute.

耦合层： 基本上，我们将 z 分割成两个部分，只有最后 k 个值用于预测 X 的最后 k 个值（通过基于均值 / 方差的采样），X 的其余部分则直接复制自 z。这样做有什么好处呢？由于这种方法，雅可比矩阵变成了一个对角矩阵，这意味着矩阵中只有对角线上的元素非零，其余元素均为零。其中，左上角（小于 k 的部分）是一个单位矩阵，右下角（大于等于 k 的部分）的元素为乘积形式，而右上角的元素均为 0。这是因为 z 的前 k 个值与 x 的后 k 个值之间没有依赖关系。因此，我们可以高效地计算雅可比矩阵的行列式。

2 AR flows or auto-regressive flows, is the next logical extension, instead of making large k chunks, why not treat each state/feature part of Markov chain, hence killing extra dependencies, this results in a lower triangular matrix for Jacobian which is also straightforward to calculate. But, this method retains more feature and is not susceptible to permutation operation which we do in coupling layers for feature retention.

自回归流（auto-regressive flows）是下一个逻辑延伸。与其生成大的 k 块，不如将马尔可夫链（Markov chain）的每个状态或特征都视为独立的个体，这样可以减少额外的依赖。这使得雅可比矩阵（Jacobian）成为下三角矩阵，从而易于计算。这种方法能够保留更多的特征。而且，它不像耦合层那样容易受到为保留特征而进行的置换操作的影响。

3 Finally, Residual flows, where we preserve the entire feature space, without sacrificing compute. Idea is simple yet backed by beautifully intricate maths. The formulation is a residual form x = z + f(z), but, this is is not bijective, because f is a neural network. Interestingly, thanks to banach and his contractive map, in ideal case there exists a unique z* which always maps to same x (stable state z), hence, this becomes bijective as well of form x = z* + f(z*) where f is a contractive map(function bounded by lipschitz less than 1, hence, change in z is bounded by change in X), The form also provides us with a way to represent z(k+1) given previous z(k), which helps in iteratively approximating the X instead of a single shot framework. We can go from z(0) to z(t) by the same formulation and can revert back as well, sounds familiar, this is roughly diffusion. What about determinant, the iterative transformation leads to a sum of infinite terms of trace of Jacobians, this is horrifying given a full rank Jacobian, but could be simply calculated through similar matrix formulation using Hutchinsons method for trace estimation.

最后是残差流（Residual flows），它可以在不增加计算负担的前提下，保留完整的特征空间。这个概念虽然简单，但其背后有着精巧的数学理论支撑。其基本形式是残差形式 x = z + f（z），但由于 f 是一个神经网络，这个映射并非双射。有趣的是，根据巴拿赫的压缩映射原理，在理想情况下，存在唯一的 z*，它总是映射到相同的 x（即稳定状态 z），因此，映射关系可以转化为双射形式 x = z* + f（z*），其中 f 是一个压缩映射（其利普希茨常数小于 1，这意味着 z 的变化幅度会受到 X 的变化幅度限制）。这种形式还提供了一种方法，可以根据之前的 z（k）来表示 z（k+1），从而帮助我们迭代地逼近 X，而不是一次性完成。我们可以通过相同的公式从 z（0）推导到 z（t），也可以反向推导回去。这听起来是不是很熟悉？这与扩散模型（diffusion model）的原理非常相似。那么行列式又如何计算呢？迭代变换会导致雅可比矩阵（Jacobian）的迹出现无限项之和。考虑到满秩的雅可比矩阵，这似乎是一个巨大的难题。但是，我们可以利用哈钦森方法（Hutchinsons method），通过类似的矩阵公式来简单地估计迹。

Everything we talked until now, makes a discrete assumption over sample and trajectory state (z=>x), why not make it continuous or basically a continuous residual flow?

到目前为止，我们所讨论的内容，都隐含地对样本和轨迹状态（z=>x）进行了离散化的假设。那么，为什么不将其视为连续的，或者更具体地说，使用连续的残差流来处理呢？这里，「z=>x」表示从潜在空间 z 到样本空间 x 的映射。

The residual form, x(k+1) = x(k) + a.f(x(k)), could be written as a differential where k tends to infinity, does this seems familiar? Yes, this is now a neural ODE, but, we are trying to model a state at t of probability density, which remains constant. The state change over a density is modelled through continuity or transport equation. Specifically, the amount of mass moved from one part of density function to other could be seen as divergence between orginal mass and the current/after-movement mass. This divergence being a continuous function over the entire trajectory has to be integrated and hence solved by a numerical ODE which makes it non scalable.

当 k 趋于无穷大时，残差形式 x（k+1）= x（k）+ a.f（x（k)）可以写成微分形式，这是否让你感到熟悉？是的，这实际上就是一个神经常微分方程（neural ODE）。但是，我们试图对概率密度在 t 时刻的状态进行建模，并且该状态保持不变。密度上的状态变化是通过连续性方程或输运方程来建模的。具体来说，可以把从密度函数一部分移动到另一部分的质量看作是原始质量与当前（或移动后）质量之间的差异。这个差异是整个轨迹上的一个连续函数，必须对其进行积分，因此需要通过数值常微分方程（ODE）来求解，这导致了其不可扩展性。

This is like comparison of states, why not compare the path?

这就像是比较不同的状态，为什么不直接比较变化的路径呢？

This leads to method behind Flux known as Flow matching. Ideas goes something like this…we start from a very simple distribution and move it towards the expected one, but, as we don't know the expected distribution, we condition it through iterative perturbation and estimating the known added noise which eventually models the underlying distribution, the process is simply known as conditional flow matching, theoretically it's proven that in ideal condition the conditional and unconstitutional objectives are exactly same, hence, by optimizing the CFM we tend to optimize the main objective behind flow matching.

这就引出了 Flux 背后的流匹配（Flow matching）方法。其核心思想是：从一个非常简单的分布出发，逐步将其转化为我们期望的分布。由于我们事先并不知道期望的分布是什么，所以需要通过迭代地施加扰动，并估计已知的噪声来引导这个转化过程，最终建立起对潜在分布的建模。这个过程被称为条件流匹配（conditional flow matching）。理论证明，在理想情况下，条件和无条件的目标是完全一致的。因此，通过优化条件流匹配（CFM），我们实际上是在优化流匹配方法背后的根本目标。

This is exactly the diffusion process, but, the major difference lies in definition of boundary conditions or initial and final state, the diffusion process assumes pure noise as z(t) and data as z(0), but, this is under assumption when t tends to infinity. But, that is empirically infeasible, instead we perform this for sufficient timestamps, hence, we remain in a much shallower manifold and is slower as well (handled by LCMs later on), it's like finding way/direction in low resolution map, whereas in flow matching, the pure noise and data space is modelled as lerp (linear interpolation) of form x(t) = t*x(t-1) + (1-t)*x(0), hence, at t=0 we are on pure data sample and at t=t we are at pure noise, which gives much refined state/manifold to model, hence, a more representative, high resolution map, also called as conditional flow matching (conditioning by noise distribution).

这其实就是扩散过程，但主要区别在于边界条件，或者说初始和最终状态的定义。扩散过程假设 z（t）代表纯噪声，而 z（0）代表数据。然而，这种假设成立的前提是时间 t 趋于无穷大。但在实际应用中，这并不可行。相反，我们会在有限的时间步长内进行计算。因此，我们实际上是在一个较浅的流形中进行操作，速度也较慢（后续会由 LCM 处理）。这就像是在低分辨率地图中寻找方向。而在流匹配中，纯噪声和数据空间被建模为一种线性插值（lerp）的形式，即 x（t）= t*x（t-1）+（1-t)*x（0）。这样，当 t=0 时，我们处于纯数据样本的状态；当 t 等于 t 时，我们处于纯噪声的状态。这种方式能提供更精细的状态或流形进行建模，从而得到更具代表性的高分辨率「地图」，也被称为条件流匹配（通过噪声分布进行调节）。

Flow matching, for sure is a unique yet intuitive idea which is going to gain a lot of traction from researchers and the products out of it would be enlightening to the consumer market. My explanation is in no way near the actual depth and breadth of the topic, and hence, a more comprensive and technical deep dive is required, but, I hope the terms/keywords provide a building block and intermediary connections between topics.

流式匹配，无疑是一个独特且直观的理念，它将受到研究人员的广泛关注，并且由此诞生的产品也将为消费市场带来新的启示。我的解释远未触及该主题的实际深度和广度，因此，还需要更全面和深入的技术探讨。不过，我希望这些术语和关键词能够为理解相关主题提供基础，并建立起它们之间的联系。

## 原文

Recently Flux series of models by Flux.ai gained lots of attention from the tech and non-tech community for all the right reasons, model is fast, easy to use thanks to diffusers as well as easy to tune (again thanks to diffusers). But, the reason behind Flux brilliant image-text alignment and high quality generations is a new methodology beyond standard diffusion process, called as "Flow matching". In this post I will cover about methods and advancements that lead to flow matching.

Every generative model is ideally a density estimaor; hence models a probability density, which eventually is a JPD, with two expected characteristics, sampling and compression, compression is basically pushing data to information space, which is seemingly lower dimensional, whereas sampling is ability to generate P(x|z) starting from any characteristic distribution (z), could be normal distribution (as in case of VAE), hence, on a very high level, we are trying to find a map/function that maps z to x as well as x to z (sampling and compression).

Let's assume two PDFs one represented as z (latent or tractable distribution) and other as X (data distribution), as we want to find a function that can map z to x, we are presented with a relationship between density of X and Z, which necessarily points out that given X and Z are conjugate distribution (distribution of same familyz before and after transformation), the change in X and Z should be relativistic, hence, change in X is some function of Z and vice versa. But, scaled by some quantity. This quantity is represented by the change across each dimension between z and x, given by Jacobian matrix, on a very simple scale it's basically change of variable between Z and X. But, it's not that simple, as X and Z are not actually conjugate, hence, we are left with iterative sampling and approximation methods, like optimal transport or Gibbs sampling (used in RBMs). Given these restrictions, most of the methods take a detour to model distributions and approximate an non-exact mapping, whereas methods like Normalizing flow, makes simplifying assumption to make the calculation and formulation tractable of form p(x)dx = p(z)dz, which can be reformulated to get two terms, first a MLE term and second a determinant of Jacobian.

(Normalizing because the change of variables always gives a normalized density function, flow as it models the trajectory/flow from source to target iteratively)

Problem start from here, for such a function to exist there are two conditions,

1. MLE formulation for p(x,z) has to be bijective.

2. The determinant of jacobian is efficiently computable.

Two solve this, we need Assumption of dependency of states across z and X, such that it's bijective and determinant is efficiently computable, there are three major approaches (we won't go very deep in this)

1. Coupling blocks : basically you break z into two chunks, only last k value predict X last k value (through mean/variance based sampling), other parts of X is basically direct copy of z, how does it help? Because of this method, the Jacobian becomes a diagonal matrix, the top left (<k) part is identity, the bottom right (>=k) becomes element wise product, the top right becomes 0, as there is no dependency between z(<k) and x(>=k), hence, the determinant of Jacobian is efficient to compute.

2. AR flows or auto-regressive flows, is the next logical extension, instead of making large k chunks, why not treat each state/feature part of Markov chain, hence killing extra dependencies, this results in a lower triangular matrix for Jacobian which is also straightforward to calculate. But, this method retains more feature and is not susceptible to permutation operation which we do in coupling layers for feature retention.

3. Finally, Residual flows, where we preserve the entire feature space, without sacrificing compute. Idea is simple yet backed by beautifully intricate maths. The formulation is a residual form x = z + f(z), but, this is is not bijective, because f is a neural network. Interestingly, thanks to banach and his contractive map, in ideal case there exists a unique z* which always maps to same x (stable state z), hence, this becomes bijective as well of form x = z* + f(z*) where f is a contractive map(function bounded by lipschitz less than 1, hence, change in z is bounded by change in X), The form also provides us with a way to represent z(k+1) given previous z(k), which helps in iteratively approximating the X instead of a single shot framework. We can go from z(0) to z(t) by the same formulation and can revert back as well, sounds familiar, this is roughly diffusion. What about determinant, the iterative transformation leads to a sum of infinite terms of trace of Jacobians, this is horrifying given a full rank Jacobian, but could be simply calculated through similar matrix formulation using Hutchinsons method for trace estimation.

Everything we talked until now😃, makes a discrete assumption over sample and trajectory state (z=>x), why not make it continuous or basically a continuous residual flow?

The residual form, x(k+1) = x(k) + a.f(x(k)), could be written as a differential where k tends to infinity, does this seems familiar? Yes, this is now a neural ODE, but, we are trying to model a state at t of probability density, which remains constant. The state change over a density is modelled through continuity or transport equation. Specifically, the amount of mass moved from one part of density function to other could be seen as divergence between orginal mass and the current/after-movement mass. This divergence being a continuous function over the entire trajectory has to be integrated and hence solved by a numerical ODE which makes it non scalable.

This is like comparison of states, why not compare the path?

This leads to method behind Flux known as Flow matching. Ideas goes something like this…we start from a very simple distribution and move it towards the expected one, but, as we don't know the expected distribution, we condition it through iterative perturbation and estimating the known added noise which eventually models the underlying distribution, the process is simply known as conditional flow matching, theoretically it's proven that in ideal condition the conditional and unconstitutional objectives are exactly same, hence, by optimizing the CFM we tend to optimize the main objective behind flow matching.

This is exactly the diffusion process, but, the major difference lies in definition of boundary conditions or initial and final state, the diffusion process assumes pure noise as z(t) and data as z(0), but, this is under assumption when t tends to infinity. But, that is empirically infeasible, instead we perform this for sufficient timestamps, hence, we remain in a much shallower manifold and is slower as well (handled by LCMs later on), it's like finding way/direction in low resolution map, whereas in flow matching, the pure noise and data space is modelled as lerp (linear interpolation) of form x(t) = t*x(t-1) + (1-t)*x(0), hence, at t=0 we are on pure data sample and at t=t we are at pure noise, which gives much refined state/manifold to model, hence, a more representative, high resolution map, also called as conditional flow matching (conditioning by noise distribution).

Flow matching, for sure is a unique yet intuitive idea which is going to gain a lot of traction from researchers and the products out of it would be enlightening to the consumer market. My explanation is in no way near the actual depth and breadth of the topic, and hence, a more comprensive and technical deep dive is required, but, I hope the terms/keywords provide a building block and intermediary connections between topics.

You can find the paper here : https://arxiv.org/abs/2210.02747

Helpful paper (residual flow) : https://arxiv.org/abs/1906.02735

Special blogpost : https://lilianweng.github.io/posts/2018-10-13-flow-models/

Helpful blogpost : https://jmtomczak.github.io/blog/18/18_fm.html