# 《大白话 Python 绘图系列》Matplotlib 篇

三十 数据民工来取经儿 2019-02-23

[《大白话 Python 绘图系列》Matplotlib 篇](https://mp.weixin.qq.com/s?__biz=MzA3NzUwNzc2NA==&mid=2456373979&idx=1&sn=734a8eb946881a9e11c325cad7144908&chksm=88cd1700bfba9e16e8274480de24b51144cba091bf1cc444d57e02fe53e398481835030c15a8&scene=21#wechat_redirect)

1. 目的

大白话说 python 绘图那些事儿，用最容易接受的方式来入门 Matplotlib 绘图。

本篇文章，可预期的收获，使用 Python 进行常规绘图，比如折线图，直方图，散点图，箱图等。

1.1 关于环境

可以自己搭建，也可以使用我搭建的云端 ipython notebook 环境。

在微信公共账号回复，ipython，会返回临时云端学习环境网址和密码。

远程环境大概长这样:

2. Matplotlib


Matplotlib 是 Python 强大的绘图库，详细介绍有兴趣可以参考官网。

2.1 绘图步骤

2.1.1 元素

一张图，可以理解由一层层元素添加绘制而成，和画画是一样样的。

第一步，来一张空白画布，用来绘制图形

第二步，向画布内添加图形元素

图例

图标标题

坐标轴及属性 (坐标刻度，坐标轴标签等)

添加第一条数据线

添加第二条数据线

设置数据线的显示属性等

2.1.2 一步步绘制

创建一个空的画布，没有任何数据

import matplotlib.pyplot as plt


fig = plt.figure(figsize=(10,5))


plt.plot()


plt.show()


2. 创建一个空的画布，绘制一条线

import matplotlib.pyplot as plt


fig = plt.figure(figsize=(10,5))


data = np.linspace(0,10,100)


plt.plot(data, np.sin(data))


plt.show()


3. 创建一个空的画布，绘制一条线 + 添加坐标轴

import matplotlib.pyplot as plt


fig = plt.figure(figsize=(10,5))


data = np.linspace(0,10,100)


plt.plot(data, np.sin(data), label="test legend")


plt.xlabel('I am X Axis')


plt.ylabel('I am Y Axis')


plt.title("data desc")


plt.legend()


plt.show()


4. 创建一个空的画布，绘制两条线

import matplotlib.pyplot as plt


fig = plt.figure(figsize=(10,5))


data = np.linspace(0,10,100)


# 下图 'r-o' 是图形颜色和形状的设置

# 有关颜色和形状 运行下面一行看详细帮助有介绍

# help(plt.plot)


plt.plot(data, np.sin(data), 'r-o', label="test legend A")


plt.plot(data, np.cos(data), 'g--', label="test legend B")


# 两个线也可以这样写: plt.plot (x_line1, y_line2, 'r', x_line2, y_line2, 'b')

# 尝试取消下面注释运行 (这种方式，貌似图例不方便分开配置)

# plt.plot(data, np.sin(data), 'r-o', data, np.cos(data), 'g--', label="A")


plt.xlabel('I am X Axis')


plt.ylabel('I am Y Axis')


plt.title("data desc")


plt.legend()


plt.show()


2.1.3 绘制子图

子图：即在一个画布中，绘制多个子图

函数: subplot (行数，列数，第 N 个子图)

下面先放一张: 3 行 2 列的 6 个子图

import matplotlib.pyplot as plt


# 绘制子图

fig = plt.figure(figsize=(10,5))


data = np.linspace(0,10,100)


# 注意：每一个子图是独立的，如是否显示图例，需要单独在子图函数下面增加

plt.subplot(3,2,1)


plt.plot(data, np.sin(data), 'r', label="test legend 1")


plt.legend()


plt.subplot(3,2,2)


plt.plot(data, np.cos(data), 'g', label="test legend 2")


plt.legend()


plt.subplot(3,2,3)


plt.plot(data, np.cos(data), 'c', label="test legend 3")


plt.legend()


plt.subplot(3,2,4)


plt.plot(data, np.cos(data), 'm', label="test legend 4")


plt.legend()


plt.subplot(3,2,5)


plt.plot(data, np.cos(data), 'y', label="test legend 5")


plt.legend()


plt.subplot(3,2,6)


plt.plot(data, np.cos(data), 'k', label="test legend 6")


plt.legend()


# 注意：每个子图是可以如果重复上面的坐标是会被覆盖掉的，尝试把下面注释代码取消试试效果

# plt.subplot(3,2,6)


# plt.plot(data, np.cos(data), 'k_', label="test legend 666")


# plt.legend()


# 注意：每个子图是独立的，且其划分在下一个子图也可以从新划分行列，尝试把下面注释代码取消试试效果

# plt.subplot(3,1,3)


# plt.plot(data, np.cos(data), 'k_', label="test legend 888")


# plt.legend()


# plt.show()


plt.show()


看过上面例子，对 subplot (xyz) 的理解会更形象，抽象如下图

2.2 常用图形绘制

下面仅为实例代码，供演示，已省略坐标，图例等属性设置

matplotlib 可定制化比较强，不过参数设置较多，熟练使用需要花较多时间

如果不是从事专门绘图工作，那么仅了解一些常用属性设置即可

优秀的轮子介绍：基于 matplotlib API 封装的第三方 python 库 seaborn，更方便的绘制漂亮的常用图形

散点图

import numpy as np;


import matplotlib.pyplot as plt


data = np.linspace(0,10,100)


# s 表示散点大小，alpha 设置透明度

plt.scatter(data, np.random.randn(100), s = 50, color = 'r', alpha = 0.25)


plt.scatter(data, np.random.randn(100), s = 50, color = 'b', alpha = 0.25)


# 额外增加一个点，突出以下：)

plt.scatter(5, 1.5, s = 1500, color = 'y', alpha = 0.8)


plt.show()


直方图

import numpy as np


import matplotlib.pyplot as plt


x = np.random.randn(1000)


plt.hist(x, 50)


plt.show()


条形图

import numpy as np


import matplotlib.pyplot as plt


data = np.linspace(1,10,10)


for d in data:


    plt.bar(d, d*10, color = '#539caf', align = 'center', label=d*10)


# 下面是用来设置数字标签，需要指定标签的坐标，有效数字，大小

    plt.text(d, d*10+0.05, '%.1f' % d, ha='center', va= 'bottom',fontsize=20)


plt.show()


箱图

要看懂箱图，需要知道一些背景知识。当你花两分钟了解后，你会惊叹，箱图太实用啦！

第一，QR: 标准差，数据集超过 3 倍标准差为异常数据

第二，切比雪夫定理：任意一个数据集中，位于其平均数 m 个标准差范围内的比例（或部分）总是至少为 1－1/m2，其中 m 为大于 1 的任意正数。对于 m=2，m=3 和 m=5 有如下结果

所有数据中，至少有 3/4 的数据位于平均数 2 个标准差范围内

所有数据中，至少有 8/9 的数据位于平均数 3 个标准差范围内

所有数据中，至少有 24/25 的数据位于平均数 5 个标准差范围内

data = np.random.randn(100)plt.boxplot(data


, patch_artist=True  # 设置为 True 才能控制箱体填充

            , medianprops = {'color': 'k'}


, boxprops = {'color': 'r', 'facecolor': 'y'}  # 盒子

, whiskerprops= {'color': 'k'}  # 头

, capprops={'color': 'g'}  # 为

           )plt.show()


2.3 高阶布局

使用场景不多，一般默认布局够用

坐标轴刻度格式化

import numpy as np


import matplotlib.pyplot as plt


import matplotlib.ticker as ticker


# Fixing random state for reproducibility


np.random.seed(19680801)


fig = plt.figure()


ax = fig.add_subplot(111)


ax.plot(100*np.random.rand(20))


formatter = ticker.FormatStrFormatter('$%1.2f')


ax.yaxis.set_major_formatter(formatter)


for tick in ax.yaxis.get_major_ticks():


tick.label1On = True  # 左边坐标轴

tick.label2On = True  # 右边坐标轴

    tick.label2.set_color('green')


plt.show()


拼图模式

import matplotlib.pyplot as plt


ax1 = plt.subplot2grid ((3, 3), (0, 0), colspan=3) # 生成 3x3 的格子，第一行，1 个子图，宽度占满 3 格

ax2 = plt.subplot2grid ((3, 3), (1, 0), colspan=2) # 第二行，第一个子图，宽度占 2 格

ax3 = plt.subplot2grid ((3, 3), (1, 2), rowspan=2) # 第二行，第二个子图，宽度默认占 1 格，高度占 2 格

ax4 = plt.subplot2grid((3, 3), (2, 0))


ax5 = plt.subplot2grid((3, 3), (2, 1))


plt.tight_layout () # 加上后，就不会产生便签重叠

plt.show()


多个子图的标签：不重叠

plt.rcParams['savefig.facecolor'] = "0.8"   


def example_plot(ax, fontsize=12):


     ax.plot([1, 2])


     ax.locator_params(nbins=10)


     ax.set_xlabel('x-label', fontsize=fontsize)


     ax.set_ylabel('y-label', fontsize=fontsize)


     ax.set_title('Title', fontsize=fontsize)


fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(nrows=2, ncols=2)


example_plot(ax1)


example_plot(ax2)


example_plot(ax3)


example_plot(ax4)


plt.tight_layout () # 加上后，就不会产生便签重叠

# plt.tight_layout(pad=0.4, w_pad=0.5, h_pad=1.0)


plt.show()


多图空间布局

fig = plt.figure()


import matplotlib.gridspec as gridspec


def example_plot(ax, fontsize=12):


     ax.plot([1, 2])


     ax.locator_params(nbins=10)


     ax.set_xlabel('x-label', fontsize=fontsize)


     ax.set_ylabel('y-label', fontsize=fontsize)


     ax.set_title('Title', fontsize=fontsize)


gs1 = gridspec.GridSpec(2, 1)


ax1 = fig.add_subplot(gs1[0])


ax2 = fig.add_subplot(gs1[1])


# ax3 = fig.add_subplot(gs1[2])


example_plot(ax1)


example_plot(ax2)


# example_plot(ax3)


# gs1 在画布的位置，由 rect 定义，两个点确定一个矩形，即定义画布的左半边，归 gs1 显示

# 点 1 (0,0) : 左上角位置

# 点 2 (0.5,1) : 底部中间位置

gs1.tight_layout(fig, rect=[0, 0, 0.5, 1])  


gs2 = gridspec.GridSpec(3, 1)


for ss in gs2:


    ax = fig.add_subplot(ss)


    example_plot(ax)


    ax.set_title("")


    ax.set_xlabel("")


ax.set_xlabel("x-label", fontsize=12)


# gs2 在画布的位置，由 rect 定义，两个点确定一个矩形，即定义画布的左半边，归 gs2 显示

gs2.tight_layout(fig, rect=[0.5, 0, 1, 1], h_pad=0.5)


plt.show()


3 关于中文字体

3.1 ubuntu 环境

确认机器有中文字体

# terminal 中输入:

fc-list :lang=zh


/usr/share/fonts/truetype/arphic/uming.ttc: AR PL UMing TW MBE:style=Light


/usr/share/fonts/truetype/arphic/ukai.ttc: AR PL UKai CN:style=Book


/usr/share/fonts/truetype/arphic/ukai.ttc: AR PL UKai HK:style=Book


/usr/share/fonts/truetype/arphic/ukai.ttc: AR PL UKai TW:style=Book


/usr/share/fonts/truetype/droid/DroidSansFallbackFull.ttf: Droid Sans 


/usr/share/fonts/truetype/arphic/ukai.ttc: AR PL UKai TW MBE:style=Book


/usr/share/fonts/truetype/arphic/uming.ttc: AR PL UMing TW:style=Light


/usr/share/fonts/truetype/arphic/uming.ttc: AR PL UMing CN:style=Light


/usr/share/fonts/truetype/arphic/uming.ttc: AR PL UMing HK:style=Light


python 中如下设置

import matplotlib.pyplot as plt


import matplotlib as mpl


zhfont = mpl.font_manager.FontProperties(fname='/usr/share/fonts/truetype/droid/DroidSansFallbackFull.ttf')


plt.plot([1, 2, 3])


plt.xlabel (u'x 轴 ', fontproperties=zhfont)

plt.show()


3.2 windows 环境

import numpy as np;


import matplotlib.pyplot as plt


import pandas as pd


%matplotlib inline


plt.rcParams ['font.sans-serif']=['SimHei'] # 设置字体为黑体

plt.plot([1, 2, 3])


plt.xlabel (u'x 轴 ', fontproperties=zhfont)

plt.show()


微信扫一扫

关注该公众号

