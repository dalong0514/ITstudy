# 大白话 Python 绘图系列: Pandas 篇

原创 三十 数据民工来取经儿 2019-03-05

[大白话 Python 绘图系列: Pandas 篇](https://mp.weixin.qq.com/s?__biz=MzA3NzUwNzc2NA==&mid=2456373996&idx=1&sn=5af12c7148944bb51df95fb230d55506&chksm=88cd1737bfba9e21cb9824cf0e382e387ec99505f266ca5f8d959c0d19fc0dd178c0d856e726&scene=21#wechat_redirect)

1. 目的

几行代码，快速了解 pandas 绘图，帮助大家在 Python 处理数据时，随时快速的洞察数据分布

1.1 关于环境

可以自己搭建，也可以使用我搭建的云端 ipython notebook 环境，在微信公共账号回复，ipython，会返回临时云端学习环境网址和密码。

2. Pandas 绘图概述

Pandas 的 DataFrame 和 Series，在 matplotlib 基础上封装了一个简易的绘图函数，使得我们在数据处理过程中方便可视化查看结果。

好处：方便快捷的可视化的方式洞察数据，覆盖常用图标类型

不足：不如 Matplotlib 灵活，仅仅看下分布情况，基本是足满足日常使用

函数详细说明见官网 pandas.DataFrame.plot

Matplotlib 绘图入门参见上一篇文章《大白话 Python 绘图系列》Matplotlib 篇

3. Pandas 快速绘图

3.1 练习数据

备注：以下绘图均使用该数据

# 为方便演示，我们随机生成 3 列正随机数

import pandas as pd


import numpy as np


import matplotlib.pyplot as plt


%matplotlib inline


data = np.random.randn(5,3)


df = pd.DataFrame(np.abs(data), 


                  index=['Mon', 'Tue', 'Wen', 'Thir', 'Fri'], 


                  columns=['A', 'B', 'C'])


df


3.2 折线图

# 两行，是不是简单到爆

# 关于 plot 更多参数查看: help (df.plot)

df.plot()


plt.show()


3.3 柱形图图

显示单列柱形图

df.A.plot(kind='bar', title='I am Mon')


plt.show()


多列柱形图

df.plot(kind='bar', title='From Mon To Fri')


plt.show()


3.4 堆积图

df.plot(kind='bar', stacked = True)


plt.show()


3.5 散点图

# x: 散点的 x 坐标位置

# y: 散点的 y 坐标位置

# s: 散点的大小

# c: 散点颜色

# 更多参数查看: help (df.plot.scatter)

df.plot(kind='scatter', x='A', y='B', s=df.C*500, c='r')


plt.show()


3.6 箱图

df.plot(y=df.columns, kind='box')


plt.show()


3.7 绘制子图

# subplots: 默认 False, 如果希望每列绘制子图，则赋值为 True

# layout: 子图的布局，即画布被横竖分为几块，如：(2,3) 表示 2 行 3 列

# figsize: 整个画布大小

# 尝试去掉下面注释，看看 sharey 绘图后的区别

df.plot(subplots=True, layout=(2,3), figsize = (10,10), kind='bar')


# df.plot(subplots=True, layout=(2,3), figsize = (10,10), kind='bar'，sharey=True)


plt.show()


4. About Me


来自北京回龙观的一名数据民工，2019 年开始写写数据民工那些大白话

微信公众号: workindata

个人微信号: ITlooker

知乎专栏：大数据那些儿大白话

阅读原文

微信扫一扫

关注该公众号

