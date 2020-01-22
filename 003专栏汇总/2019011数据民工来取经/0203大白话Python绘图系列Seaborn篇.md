# 《大白话 Python 绘图系列》Seaborn 篇

原创 三十 数据民工来取经儿 2019-03-12

[《大白话 Python 绘图系列》Seaborn 篇](https://mp.weixin.qq.com/s?__biz=MzA3NzUwNzc2NA==&mid=2456374021&idx=1&sn=57753a13bca9d5d832c51972c90d290e&chksm=88cd16debfba9fc818bf8ce73b9f75d9046371781a864acd1e65fdf2dde967eedc1d842af038&scene=21#wechat_redirect)

1. 目的

了解 python 第三方绘图包 seaborn，从常用绘图实例开始，快速体验 seaborn 绘图。

建议用时: 10 分钟

绘图例子: 12 个

每个例子代码量: 1-6 行，90% 仅 1 行

1.1 环境

ipython notebook


安装 python 包: seaborn, matplotlib, pandas, numpy

在微信公共账号回复，ipython，会返回临时云端学习环境网址和密码，也可自己搭建。

2. Seaborn 快速绘图

2.1 练习数据

seaborn 自带很多练习数据，我们任选一个数据集，比如: Iris, 当做绘图数据使用，简单介绍该数据源:

Iris 数据集是常用的分类实验数据集，由 Fisher, 1936 收集整理。Iris 也称鸢尾花卉数据集，是一类多重变量分析的数据集。数据集包含 150 个数据集，分为 3 类，每类 50 个数据，每个数据包含 4 个属性。可通过花萼长度，花萼宽度，花瓣长度，花瓣宽度 4 个属性预测鸢尾花卉属于（Setosa，Versicolour，Virginica）三个种类中的哪一类。

加载 Iris 数据

import seaborn as sn


import pandas as pd


import matplotlib.pyplot as plt


import numpy as np


%matplotlib inline


# 加载 seaborn 自带数据: iris

df = sn.load_dataset("iris")


df.head()


输出结果:

2.2 数据集洞察

代码: 1 行

先简单看下该数据基本统计信息:

样本数量: count

平均值: mean

标准差: std

最小值: min

最大值: max

25%, 50%, 75% 分位数

df.descirbe()


输出结果:

2.3 分类聚集

代码: 1 行

场景：样例两个属性，一个是离散分类，一个是连续值，希望一张图绘出每类的散点图

方法:

stripplot: 可以绘制分类数据的散点图，由于过多的点会聚集一处，使用 jitter 进行随机抖动，以在每一个分类数据中对应变量在某一点的集中 / 分布趋势。

swarmplot: 函数会使用内置的算法对数据进行抖动，保证点不会重合

talk is cheap, show u code.


# swarm 绘图散点以树状连接个点，不重合

sn.swarmplot(x="species", y="petal_length", data=df, size=10)


# 可以体验下与下面绘图结果的不同:

# sn.stripplot(x='species', y='petal_length', data=df, jitter=True)


输出结果:

2.4 直方图

代码: 1 行

场景：连续属性分段查看分布

sn.distplot(df.sepal_length, bins=20, kde=True, rug=True)


输出结果:

2.5 柱状图

代码: 1 行

场景：连续属性分段查看分布

sn.barplot(x='species', y='sepal_length', data=df)


输出结果:

2.6 点图

代码: 1 行

介绍：表示一个数值的中心趋势的估计。根据散点图点的位置变化，并提供一些，用误差线表示该估计的不确定性

# 点图

sn.pointplot(x='species', y='sepal_length', data=df)


输出结果:

2.7 双变量图

代码: 1 行

sn.jointplot(x='sepal_length', y='sepal_width', data=df)


# 尝试改变属性值

# sn.jointplot(x='x', y='y', data=df2, kind='hex')


# sn.jointplot(x='x', y='y', data=df2, kind='kde')


输出结果:

2.8 热力图

代码: 1 行

# 取 10 个样本，查看不同属性的值，用热力图显示

sn.heatmap(df.iloc[:10,:4])


输出结果:

2.9 箱图

代码: 1 行

如何读箱图见《大白话 Python 绘图系列》Matplotlib 篇 箱图部分

sn.boxplot(x='species', y='sepal_length', data=df)


输出结果:

2.10 小提琴图

代码: 6 行

场景：小提琴类似箱图，但能更直观看数据集聚程度

# 场景：看密度分布比较形象具体

fig, axes = plt.subplots(2,2, figsize=(20,20))


sn.violinplot(x='species', y='sepal_length', data=df, ax=axes[0,0])


sn.violinplot(x='species', y='sepal_length', data=df, ax=axes[0,1], hue='species')


sn.violinplot(y='species', x='sepal_length', data=df, ax=axes[1,0], hue='species', inner='stick')


sn.violinplot(y='species', x='sepal_length', data=df, ax=axes[1,1], hue='species', inner=None)


sn.swarmplot(y='species', x='sepal_length', data=df, ax=axes[1,1],alpha=.5, hue='species',color="r")


输出结果:

2.11 线性拟合

代码: 1 行

场景：查看两列关系

sn.lmplot(x='sepal_length', y='petal_length', data=df)


输出结果:

2.12 非线性拟合

代码: 1 行

场景：查看两列关系，下面用二次多项式

sn.regplot(x='sepal_length', y='petal_length', order=2, data=df)


输出结果:

2.13 数据集两两属性关系

代码: 2 行

场景：当需要快速了解数据集中属性两两关系时。数据需要是连续值且非空

# 相同变量直方图显示，不同变量散点图显示，其中数据中不能含有 NaN

l = ['sepal_length', 'sepal_width', 'petal_length', 'petal_width']


sn.pairplot(df[l])


输出结果:

2.14 Grid 自定义绘制

场景：多子图显示

# 多图绘制：数据集某属性 species, 将数据集分三类

# 下面，一次性汇出三类数据的直方图

g = sn.FacetGrid(df,col="species")


g.map(plt.hist,"sepal_length")


g.add_legend()


输出结果:

3. About Me


来自北京回龙观的一名数据民工，2019 年开始写写数据民工那些大白话

微信公众号: workindata

个人微信号: ITlooker

知乎专栏：大数据那些儿大白话

阅读原文

微信扫一扫

关注该公众号

