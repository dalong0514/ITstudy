# 0105. Python 科学计算：Pandas

陈旸 2018-12-24




09:16


讲述：陈旸 大小：8.50M

上一章中，我们讲了 Python 的一个重要的第三方库 NumPy，今天我来给你介绍 Python 的另一个工具 Pandas。

在数据分析工作中，Pandas 的使用频率是很高的，一方面是因为 Pandas 提供的基础数据结构 DataFrame 与 json 的契合度很高，转换起来就很方便。另一方面，如果我们日常的数据清理工作不是很复杂的话，你通常用几句 Pandas 代码就可以对数据进行规整。

Pandas 可以说是基于 NumPy 构建的含有更高级数据结构和分析能力的工具包。在 NumPy 中数据结构是围绕 ndarray 展开的，那么在 Pandas 中的核心数据结构是什么呢？

下面主要给你讲下 Series 和 DataFrame 这两个核心数据结构，他们分别代表着一维的序列和二维的表结构。基于这两种数据结构，Pandas 可以对数据进行导入、清洗、处理、统计和输出。

数据结构：Series 和 DataFrame

Series 是个定长的字典序列。说是定长是因为在存储的时候，相当于两个 ndarray，这也是和字典结构最大的不同。因为在字典的结构里，元素的个数是不固定的。

Series 有两个基本属性：index 和 values。在 Series 结构中，index 默认是 0,1,2,…… 递增的整数序列，当然我们也可以自己来指定索引，比如 index=[‘a’, ‘b’, ‘c’, ‘d’]。

import pandas as pd


from pandas import Series, DataFrame


x1 = Series([1,2,3,4])


x2 = Series(data=[1,2,3,4], index=['a', 'b', 'c', 'd'])


print x1


print x2


运行结果：

0    1


1    2


2    3


3    4


dtype: int64


a    1


b    2


c    3


d    4


dtype: int64


这个例子中，x1 中的 index 采用的是默认值，x2 中 index 进行了指定。我们也可以采用字典的方式来创建 Series，比如：

d = {'a':1, 'b':2, 'c':3, 'd':4}


x3 = Series(d)


print x3 


运行结果：

a    1


b    2


c    3


d    4


dtype: int64


DataFrame 类型数据结构类似数据库表。

它包括了行索引和列索引，我们可以将 DataFrame 看成是由相同索引的 Series 组成的字典类型。

我们虚构一个王者荣耀考试的场景，想要输出几位英雄的考试成绩：

import pandas as pd


from pandas import Series, DataFrame


data = {'Chinese': [66, 95, 93, 90,80],'English': [65, 85, 92, 88, 90],'Math': [30, 98, 96, 77, 90]}


df1= DataFrame(data)


df2 = DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'DianWei'], columns=['English', 'Math', 'Chinese'])


print df1


print df2


在后面的案例中，我一般会用 df, df1, df2 这些作为 DataFrame 数据类型的变量名，我们以例子中的 df2 为例，列索引是 [‘English’, ‘Math’, ‘Chinese’]，行索引是 [‘ZhangFei’, ‘GuanYu’, ‘ZhaoYun’, ‘HuangZhong’, ‘DianWei’]，所以 df2 的输出是：

            English  Math  Chinese


ZhangFei         65    30       66


GuanYu           85    98       95


ZhaoYun          92    96       93


HuangZhong       88    77       90


DianWei          90    90       80


在了解了 Series 和 DataFrame 这两个数据结构后，我们就从数据处理的流程角度，来看下他们的使用方法。

数据导入和输出

Pandas 允许直接从 xlsx，csv 等文件中导入数据，也可以输出到 xlsx, csv 等文件，非常方便。

import pandas as pd


from pandas import Series, DataFrame


score = DataFrame(pd.read_excel('data.xlsx'))


score.to_excel('data1.xlsx')


print score


需要说明的是，在运行的过程可能会存在缺少 xlrd 和 openpyxl 包的情况，到时候如果缺少了，可以在命令行模式下使用「pip install」命令来进行安装。

数据清洗

数据清洗是数据准备过程中必不可少的环节，Pandas 也为我们提供了数据清洗的工具，在后面数据清洗的章节中会给你做详细的介绍，这里简单介绍下 Pandas 在数据清洗中的使用方法。

我还是以上面这个王者荣耀的数据为例。

data = {'Chinese': [66, 95, 93, 90,80],'English': [65, 85, 92, 88, 90],'Math': [30, 98, 96, 77, 90]}


df2 = DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'DianWei'], columns=['English', 'Math', 'Chinese'])


在数据清洗过程中，一般都会遇到以下这几种情况，下面我来简单介绍一下。

1. 删除 DataFrame 中的不必要的列或行

Pandas 提供了一个便捷的方法 drop () 函数来删除我们不想要的列或行。比如我们想把「语文」这列删掉。

df2 = df2.drop(columns=['Chinese'])


想把「张飞」这行删掉。

df2 = df2.drop(index=['ZhangFei'])


2. 重命名列名 columns，让列表名更容易识别

如果你想对 DataFrame 中的 columns 进行重命名，可以直接使用 rename (columns=new_names, inplace=True) 函数，比如我把列名 Chinese 改成 YuWen，English 改成 YingYu。

df2.rename(columns={'Chinese': 'YuWen', 'English': 'Yingyu'}, inplace = True)


3. 去重复的值

数据采集可能存在重复的行，这时只要使用 drop_duplicates () 就会自动把重复的行去掉。

df = df.drop_duplicates () #去除重复行

4. 格式问题

更改数据格式

这是个比较常用的操作，因为很多时候数据格式不规范，我们可以使用 astype 函数来规范数据格式，比如我们把 Chinese 字段的值改成 str 类型，或者 int64 可以这么写：

df2['Chinese'].astype('str') 


df2['Chinese'].astype(np.int64) 


数据间的空格

有时候我们先把格式转成了 str 类型，是为了方便对数据进行操作，这时想要删除数据间的空格，我们就可以使用 strip 函数：

#删除左右两边空格

df2['Chinese']=df2['Chinese'].map(str.strip)


#删除左边空格

df2['Chinese']=df2['Chinese'].map(str.lstrip)


#删除右边空格

df2['Chinese']=df2['Chinese'].map(str.rstrip)


如果数据里有某个特殊的符号，我们想要删除怎么办？同样可以使用 strip 函数，比如 Chinese 字段里有美元符号，我们想把这个删掉，可以这么写：

df2['Chinese']=df2['Chinese'].str.strip('$')


大小写转换

大小写是个比较常见的操作，比如人名、城市名等的统一都可能用到大小写的转换，在 Python 里直接使用 upper (), lower (), title () 函数，方法如下：

#全部大写

df2.columns = df2.columns.str.upper()


#全部小写

df2.columns = df2.columns.str.lower()


#首字母大写

df2.columns = df2.columns.str.title()


查找空值

数据量大的情况下，有些字段存在空值 NaN 的可能，这时就需要使用 Pandas 中的 isnull 函数进行查找。比如，我们输入一个数据表如下：

如果我们想看下哪个地方存在空值 NaN，可以针对数据表 df 进行 df.isnull ()，结果如下：

如果我想知道哪列存在空值，可以使用 df.isnull ().any ()，结果如下：

使用 apply 函数对数据进行清洗

apply 函数是 Pandas 中自由度非常高的函数，使用频率也非常高。

比如我们想对 name 列的数值都进行大写转化可以用：

df['name'] = df['name'].apply(str.upper)


我们也可以定义个函数，在 apply 中进行使用。比如定义 double_df 函数是将原来的数值 *2 进行返回。然后对 df1 中的「语文」列的数值进行 *2 处理，可以写成：

def double_df(x):


           return 2*x


df1 [u' 语文 '] = df1 [u' 语文 '].apply (double_df)

我们也可以定义更复杂的函数，比如对于 DataFrame，我们新增两列，其中’new1’列是「语文」和「英语」成绩之和的 m 倍，'new2’列是「语文」和「英语」成绩之和的 n 倍，我们可以这样写：

def plus(df,n,m):


df ['new1'] = (df [u' 语文 ']+df [u' 英语 ']) * m

df ['new2'] = (df [u' 语文 ']+df [u' 英语 ']) * n

    return df


df1 = df1.apply(plus,axis=1,args=(2,3,))


其中 axis=1 代表按照列为轴进行操作，axis=0 代表按照行为轴进行操作，args 是传递的两个参数，即 n=2, m=3，在 plus 函数中使用到了 n 和 m，从而生成新的 df。

数据统计

在数据清洗后，我们就要对数据进行统计了。

Pandas 和 NumPy 一样，都有常用的统计函数，如果遇到空值 NaN，会自动排除。

常用的统计函数包括：

表格中有一个 describe () 函数，统计函数千千万，describe () 函数最简便。它是个统计大礼包，可以快速让我们对数据有个全面的了解。下面我直接使用 df1.descirbe () 输出结果为：

df1 = DataFrame({'name':['ZhangFei', 'GuanYu', 'a', 'b', 'c'], 'data1':range(5)})


print df1.describe()


数据表合并

有时候我们需要将多个渠道源的多个数据表进行合并，一个 DataFrame 相当于一个数据库的数据表，那么多个 DataFrame 数据表的合并就相当于多个数据库的表合并。

比如我要创建两个 DataFrame：

df1 = DataFrame({'name':['ZhangFei', 'GuanYu', 'a', 'b', 'c'], 'data1':range(5)})


df2 = DataFrame({'name':['ZhangFei', 'GuanYu', 'A', 'B', 'C'], 'data2':range(5)})


两个 DataFrame 数据表的合并使用的是 merge () 函数，有下面 5 种形式：

1. 基于指定列进行连接

比如我们可以基于 name 这列进行连接。

df3 = pd.merge(df1, df2, on='name')


2. inner 内连接

inner 内链接是 merge 合并的默认情况，inner 内连接其实也就是键的交集，在这里 df1, df2 相同的键是 name，所以是基于 name 字段做的连接：

df3 = pd.merge(df1, df2, how='inner')


3. left 左连接

左连接是以第一个 DataFrame 为主进行的连接，第二个 DataFrame 作为补充。

df3 = pd.merge(df1, df2, how='left')


4. right 右连接

右连接是以第二个 DataFrame 为主进行的连接，第一个 DataFrame 作为补充。

df3 = pd.merge(df1, df2, how='right')


5. outer 外连接

外连接相当于求两个 DataFrame 的并集。

df3 = pd.merge(df1, df2, how='outer')


如何用 SQL 方式打开 Pandas

Pandas 的 DataFrame 数据类型可以让我们像处理数据表一样进行操作，比如数据表的增删改查，都可以用 Pandas 工具来完成。不过也会有很多人记不住这些 Pandas 的命令，相比之下还是用 SQL 语句更熟练，用 SQL 对数据表进行操作是最方便的，它的语句描述形式更接近我们的自然语言。

事实上，在 Python 里可以直接使用 SQL 语句来操作 Pandas。

这里给你介绍个工具：pandasql。

pandasql 中的主要函数是 sqldf，它接收两个参数：一个 SQL 查询语句，还有一组环境变量 globals () 或 locals ()。这样我们就可以在 Python 里，直接用 SQL 语句中对 DataFrame 进行操作，举个例子：

import pandas as pd


from pandas import DataFrame


from pandasql import sqldf, load_meat, load_births


df1 = DataFrame({'name':['ZhangFei', 'GuanYu', 'a', 'b', 'c'], 'data1':range(5)})


pysqldf = lambda sql: sqldf(sql, globals())


sql = "select * from df1 where name ='ZhangFei'"


print pysqldf(sql)


运行结果：

   data1      name


0      0  ZhangFei


上面这个例子中，我们是对「name='ZhangFei」「的行进行了输出。当然你会看到我们用到了 lambda，lambda 在 python 中算是使用频率很高的，那 lambda 是用来做什么的呢？它实际上是用来定义一个匿名函数的，具体的使用形式为：

 lambda argument_list: expression


这里 argument_list 是参数列表，expression 是关于参数的表达式，会根据 expression 表达式计算结果进行输出返回。

在上面的代码中，我们定义了：

pysqldf = lambda sql: sqldf(sql, globals())


在这个例子里，输入的参数是 sql，返回的结果是 sqldf 对 sql 的运行结果，当然 sqldf 中也输入了 globals 全局参数，因为在 sql 中有对全局参数 df1 的使用。

总结

和 NumPy 一样，Pandas 有两个非常重要的数据结构：Series 和 DataFrame。使用 Pandas 可以直接从 csv 或 xlsx 等文件中导入数据，以及最终输出到 excel 表中。

我重点介绍了数据清洗中的操作，当然 Pandas 中同样提供了多种数据统计的函数。

最后我们介绍了如何将数据表进行合并，以及在 Pandas 中使用 SQL 对数据表更方便地进行操作。

Pandas 包与 NumPy 工具库配合使用可以发挥巨大的威力，正是有了 Pandas 工具，Python 做数据挖掘才具有优势。

我们来回顾一下今天的内容，在 Pandas 中，最主要的数据结构是什么？它都提供了哪些函数，可以帮我们做数据清洗？你可以自己描述一下吗？

练习题

对于下表的数据，请使用 Pandas 中的 DataFrame 进行创建，并对数据进行清洗。同时新增一列「总和」计算每个人的三科成绩之和。

欢迎在评论区与我分享你的答案。

如果你觉着这篇文章有价值，欢迎点击「请朋友读」，把这篇文章分享给你的朋友或者同事。

unpreview


© 版权归极客邦科技所有，未经许可不得传播售卖。页面已增加防盗追踪，如有侵权极客邦将依法追究其法律责任。

大龙

由作者筛选后的优质留言将会公开显示，欢迎踊跃留言。

Command + Enter 发表

0/2000 字

提交留言

精选留言 (146)

自导自演

老师能换 3.x 版本的吗？一堆 2.x 问题一直卡着好难受。

2018-12-28


何楚

#!/usr/bin/env python3


# -*- coding: utf-8 -*-


import pandas as pd


data = {'Chinese': [66, 95, 93, 90, 80, 80], 'English': [65, 85, 92, 88, 90, 90],


        'Math': [None, 98, 96, 77, 90, 90]}


df = pd.DataFrame (data, index=[' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '],

                  columns=['English', 'Math', 'Chinese'])


# 去除重复行

df = df.drop_duplicates()


# 列名重新排序

cols = ['Chinese', 'English', 'Math']


df = df.filter(cols, axis=1)


# 列名改为中文

df.rename (columns={'Chinese': ' 语文 ', 'English': ' 英语 ',

'Math': ' 数学 '}, inplace=True)

def total_score(df):


df [' 总分 '] = df [' 语文 '] + df [' 英语 '] + df [' 数学 ']

    return df


# 求成绩的和，用老师讲的 apply 方法

df = df.apply(total_score, axis=1)


# 或者可以用这个方法求和

# df [' 总分 '] = df [' 语文 '] + df [' 英语 '] + df [' 数学 ']

# 按照总分排序，从高到低，此时有缺失值

df.sort_values ([' 总分 '], ascending=[False], inplace=True)

# 打印显示成绩单信息，张飞有空值

print(df.isnull().sum())


print(df.describe())


print(df)


# 使用数学成绩均值填充张飞同学的缺失值

df [' 数学 '].fillna (df [' 数学 '].mean (), inplace=True)

# 再次求成绩的和并打印显示成绩单情况

df = df.apply(total_score, axis=1)


print(df.isnull().sum())


print(df.describe())


print(df)


作者回复：整理的不错，终于看到张飞的数学成绩 按照平均值来补全的了

2018-12-24


大萌

另外推荐一个链接：https://www.cnblogs.com/nxld/p/6756492.html

很实用，里面记载了许多 python 常使用的方法

2018-12-24


daydreamer


"""


Pandas 中有 Series 和 DataFrame 两种重要的数据结构。

Series：是一个定长的字典序列。有两个基本属性：index，values

DataFrame：类似于数据库表的一种数据结构。我们甚至可以像操作数据库表那样对 DataFrame 数据进行

连接，合并，查询等等

常用 DataFrame 进行数据清晰：用到的发方法有:

去重删除：drop ()，drop_duplicates (),rename ()

去空格：strip (),lstrip (),rstrip ()

变换大小写：upper (),lower (),title ()

改变数据格式：astype ()

查找空值：lsnull

        apply


"""


from pandas import DataFrame


# Scores of students


scores = {'Chinese': [66, 95, 95, 90, 80, 80],


          'English': [65, 85, 92, 80, 90, 90],


          'Math': [None, 98, 96, 77, 90, 90],


          'Total': [None, None, None, None, None, None]}


df = DataFrame(scores, index=['Zhang Fei', 'Guan Yu', 'Zhao Yun', 'Huang Zhong', 'Dian Wei','Dian Wei'],)


# Data ckeaning.


# remove the duplicated record.


df = df.drop_duplicates()


# print(df)


# Calculate the total scores.


df['Total'] = df.sum(axis=1)


print(df.describe())


作者回复: df ['Total'] = df.sum (axis=1) 这个求和写的还是挺简洁的

2018-12-24


tjcslx


#!/usr/bin/env python


# coding: utf-8


# 使用 Jupyter Notebook 进行脚本编写

import pandas as pd


import numpy as np


from pandas import DataFrame


from pandasql import sqldf, load_meat, load_births


# 创建数据集并进行数据清洗：清除重复的行；

# 录入数值时，空值用 None 或 np.nan；defaultValues 为字段为空时的默认值，姓名字段默认为「无姓名」，成绩字段默认为 0

# 分别使用 drop_duplicates 和 fillna 方法进行去重复值及空值填充

data = {'Name': [' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '], 'Chinese': [66, 95, 95, 90, 80, 80], 'English': [65, 85, 92, 88, 90, 90], 'Maths': [None, 98, 96, 77, 90, 90]}

df = DataFrame(data, columns=['Name', 'Chinese', 'English', 'Maths'])


defaultValues = {'Name': ' 无姓名 ', 'Chinese': 0, 'English': 0, 'Maths': 0}

df = df.drop_duplicates()


# 按照默认值进行填充

df = df.fillna(defaultValues)


# 使用其他学生的平均值对空值进行填充

# df['Maths'].fillna(df['Maths'].mean(), inplace=True)


# 使用 Pandas SQL 进行排序语句编写

pysqldf = lambda sql: sqldf(sql, globals())


sql = "select *, Chinese + English + Maths as Total from df order by Chinese + English + Maths desc"


print(pysqldf(sql))


2018-12-31


大萌

Pandas 最主要的两个数据结构：Series，DataFrame

Series 提供：index,values,map

DataFrame 常用的函数：

- describe () 统计性描述

- drop_duplicates () 删除重复行

- rename (columns=...) 更名

- dropna () 删除具有空的行

- isnull () 判断空值

- fillna () 填充空值

- apply () 应用函数

- merge () 合并 df

- value_counts () 统计某列的各类型个数

- read_excel () to_excel () 读取和保存 excel

- set_index () 设置索引

- cut 分组

代码，工具 jupyter notebook：

import pandas as pd


from pandas import DataFrame,Series


import numpy as np


grades = {'Chinese':[66,95,95,90,80,80],'English':[65,85,92,88,90,90],'Math':[np.nan,98,96,77,90,90]} #定义成绩字典

df1 = DataFrame (grades,index=['zhangfei','guanyu','zhaoyun','huangzhong','machao','machao']) #创建 DataFrame

df1.describe()


df1.isnull ().any () #查看哪一列有空值

df1.dropna (inplace=True) #去除空值

df1.drop_duplicates (inplace=True) #去除重复值

df1.rename (columns={'Chinese':'YuWen','English':'YingYu','Math':'ShuXue'},inplace=True) #更名

df1 ['ZongFen'] = df1.YingYu+df1.YuWen+df1.ShuXue #计算总分

df1


2018-12-24


舒成

大家以后放代码时能不能写明自己的软件环境啊，方便交流啊

2018-12-24


董大琳儿

都没听懂，感到淡淡的忧伤～

作者回复：慢慢来 董大琳

2019-06-20


龟仙人

老师你好，你好像没有在哪里明确说明自己的环境是 python2.7 的，结果大家的使用环境大多数是 3.0 的，多多少少会引发一些问题。还有请问，微信群怎么加？

作者回复：后面例子用的是 Python3，微信群需要找运营同学，让运营同学拉你入群

2019-01-27


七彩星云

df2 ['Chinese'].astype ('str') ＃这种写法貌似不行，如果是原始类型是 int，再次 map 调用 str.strip 方法的时候会出错，

改成赋值形式就行了 df2 ['Chinese'] ＝df2 ['Chinese'].astype ('str')

2019-01-04


Grandia_Z


照着老师写 df2 = df2.drop (columns=['Chinese']) 这行代码后，返回结果是:

TypeError Traceback (most recent call last)


<ipython-input-25-8116650c61ac> in <module>()


----> 1 df2 = df2.drop(columns=['Chinese'])


TypeError: drop() got an unexpected keyword argument 'columns'


这个什么意思

作者回复：我运行没有问题，是正确的。我使用的是 py2.7 版本，另外你在开头引用了 DataFrame 和 pandas 工具包了么

你可以联系编辑，加微信群，我帮你看下

2018-12-24


姜戈

# -*- coding: utf-8 -*-


import pandas as pd


from pandas import Series, DataFrame


data={' 语文 ':[66, 95, 95, 90, 80, 80],' 英语 ':[65, 85, 92, 88, 90,90], ' 数学 ':['', 98, 96, 77, 90, 90]}

df1 = DataFrame (data, index=[' 张飞 ', ' 关羽 ', ' 赵云 ',' 刘备 ',' 典韦 ',' 典韦 '], columns=[' 语文 ',' 英语 ',' 数学 '])

print df1


df1 = df1.drop_duplicates()


print df1


df = df1.replace(to_replace='', value=0)


print df


df [' 总计 ']=df [' 语文 ']+df [' 英语 ']+df [' 数学 ']

df.replace(to_replace=0, value='', inplace=True)


print df


作者回复：整理的 OK，基本上清洗的过程都会把重复的行去掉。针对张飞的数学成绩，既可以按照 0 统计，也可以按照其他人的平均值来统计（考虑可能是统计缺失，而非真正为 0）

2018-12-24


mickey


#!/usr/bin/python


# vim: set fileencoding:utf-8


'''


1. 对于下表的数据，请使用 Pandas 中的 DataFrame 进行创建，并对数据进行清洗。

2. 同时新增一列「总和」计算每个人的三科成绩之和。

'''


import pandas as pd


from pandas import DataFrame


# 导入成绩

data = pd.read_excel (u' 成绩表.xlsx')

df = DataFrame(data)


print df


# 求和，并增加一列「总和」

def addtotal(df):


df [u' 总和 '] = df [u' 语文 '] + df [u' 英语 '] + df [u' 数学 ']

    return df


# 清洗为空的数据

df1 = df.dropna()


# 清洗重复的数据

df1 = df1.drop_duplicates()


# 生成新数据结构

df1= df1.apply(addtotal, axis=1)


print(df1)


作者回复：简洁，整理的不错

其实还有一种清洗方法，即针对张飞的情况，数学成绩可以进行补全，比如用其他人的数学成绩平均值

2018-12-24


nrvna


import pandas as pd


data = {'Chinese':[66,95,95,90,80,80],'English':[65,85,92,88,90,90],'Math':[None,98,96,77,90,90]}


df = pd.DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'DianWei', 'DianWei'])


print(df)


# Delete extra lines，Replace null with 0，Add new column for total


df = df.drop_duplicates()


df = df.where(df.notnull(),0)


# None will change 'Math' column to float, so that we need to clean it back.


# [[]] is a DataFrame


df[['Math']] = df[['Math']].astype(int)


'''


Method 1: Directly


'''


# df['Total'] = df['Chinese'] + df['English'] + df['Math']


# print(df)


'''


Method 2: apply a function


'''


def add_column(df):


    df['Total'] = df['Chinese'] + df['English'] + df['Math']


    return df


df = df.apply(add_column,axis=1)


print(df)


2018-12-24


GS


https://github.com/leledada/jupyter/blob/master/PandasTest.ipynb 用 Jupter 写了一遍。

pandasql 为什么要 import load_meat, load_births ？ 做什么用的？这个我要查一查

作者回复：嗯嗯 多谢分享

2019-11-13


qinggeouye


import numpy as np


import pandas as pd


scores = pd.DataFrame(


{' 姓名 ': [' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '], ' 语文 ': [66, 95, 95, 90, 80, 80], ' 英语 ': [65, 85, 92, 88, 90, 90],

' 数学 ': [np.NaN, 98, 96, 77, 90, 90], })

print(scores)


# 查找空值所在的列

isNaN = scores.isna().any() # isnull(), isnull().any()


isNaN = isNaN[isNaN == True]


print(scores[isNaN.index])


# 列的平均值填充空值

for col in isNaN.index:


    scores[col].fillna(scores[col].mean(), inplace=True)


print(scores)


# 去除不必要的行（空值）

# scores = scores.drop(index=[0])


# scores = scores.dropna()


# 去除重复行

scores = scores.drop_duplicates()


print(scores)


# 新增一列 ' 总和 '

# scores [' 总和 '] = scores [' 语文 '] + scores [' 数学 '] + scores [' 英语 ']

scores [' 总和 '] = scores.sum (axis=1)

print(scores)


作者回复: Good Job

2019-11-03


Answer Liu


df6 = pd.DataFrame(


{"语文": [66, 95, 95, 90, 80, 80], "数学": [65, 85, 92, 88, 90, 90], "英语": [np.nan, 98, 96, 77, 90, 90]},

index=[' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 ']

)


# 去重

df7 = df6.drop_duplicates()


# 替换 NaN 值

df8 = df7.fillna (df7 [' 英语 '].mean ())

# 增加一行统计

df8['sum'] = [df8.loc[name].sum() for name in df8.index]


# 按总分倒序排列

df9 = df8.sort_values(by="sum", ascending=False)


print(df9)


作者回复: Good Job

2019-10-22


DDBG


老师我想问一下，假如我查找到了一个空值，怎么利用函数，然后利用 apply 把空值删除，或者重新赋值

2019-06-11


初

None 竟然是浮点型数据.... 没想到

作者回复：哈哈

2019-03-05


自然

def sum(df):


df [u' 总和 '] = (df [u' 语文 ']+df [u' 英语 ']+ df [u' 数学 '])

    return df


df1 = df1.apply(sum, axis=1)


2018-12-25


lingmacker


def exercise():


# 1. 对于下表的数据，请使用 Pandas 中的 DataFrame 进行创建，并对数据进行清洗。

# 2. 同时新增一列「总和」计算每个人的三科成绩之和。

# 列名使用了中文，打印需要列对其的话，则需要设置这两个参数

    pd.set_option('display.unicode.ambiguous_as_wide', True)


    pd.set_option('display.unicode.east_asian_width', True)


data = {"姓名": ["张飞", "关羽", "赵云", "黄忠", "典韦", "典韦"],

"语文": [66, 95, 95, 90, 80, 80],

"英语": [65, 85, 92, 88, 90, 90],

"数学": [None, 98, 96, 77, 90, 90]}

    


score_table = pd.DataFrame (data, columns=["姓名", "语文", "英语", "数学"])

    print(score_table, "\n")


# 除去重复行

    score_table.drop_duplicates(inplace=True)


    print(score_table, "\n")


# 添加 总分 列

score_table.fillna (0, inplace=True) # 将 NaN 替换为 0

score_table ["总分"] = score_table ["语文"] + score_table ["英语"] + score_table ["数学"]

    print(score_table)


作者回复：整理的不错，清洗张飞的数学成绩的时候，没有唯一答案。也可以用其他人的数学成绩平均值进行补全

2018-12-24


是我的海

import pandas as pd


from pandas import Series,DataFrame


data={' 语文 ':[66,95,95,90,80,80],' 英语 ':[65,85,92,88,90,90],' 数学 ':[None,98,96,77,90,90]}

df=DataFrame (data,index=[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],columns=[' 语文 ',' 英语 ',' 数学 '])

df=df.drop_duplicates()


df=df.fillna(0)


def plus(df):


df [' 成绩综合 ']=df [u' 语文 ']+df [u' 英语 ']+df [u' 数学 ']

    return df


df=df.apply(plus,axis=1)


print(df)


额，感觉我的代码好简单。关于数学那个空值的处理，我感觉有很多种方法，这里用了最简单的一种。

2018-12-24


pencilCool


mac 电脑上 最近 python 2.x 安装 numpy 和 pandas 会报各种错误。

pip 升级，然后 pip3 命令用不了了。没关系 pip 升级后默认用的就是 python3 了

然后使用如下命令安装：

sudo pip install Pandas -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com


很快就安装好了

2020-01-18


李宽

import pandas as pd


from pandas import Series, DataFrame


index = [' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 ']

data = {' 语文 ':[66,95,95,90,80,80],' 英语 ':[65,85,92,88,90,90],' 数学 ':[np.nan,98,96,77,90,90]}

score = DataFrame(data, index=index)


score = score.drop_duplicates()


score [' 数学 '] = score [' 数学 '].fillna (score [' 数学 '].mean ())

score [' 总和 '] = score.sum (axis=1)

2020-01-13


爬行的蜗牛

import pandas as pd


import numpy


from pandas import Series, DataFrame


data={' 语文 ':[66, 95, 95, 90, 80, 80],' 英语 ':[65, 85, 92, 88, 90,90], ' 数学 ':[None, 98, 96, 77, 90, 90]}

df1 = DataFrame (data, index=[' 张飞 ', ' 关羽 ', ' 赵云 ',' 刘备 ',' 典韦 ',' 典韦 '], columns=[' 语文 ',' 英语 ',' 数学 '])

df1 = df1.drop_duplicates()


#df1.dropna()


df1.fillna(df1.mean(axis = 0))


df1


2020-01-10


苹果

# -*- coding: utf-8 -*-


from pandas import Series,DataFrame


data = {'Chinese': [66, 95, 95,90, 80,80],'English': [65, 85, 92, 88, 90,90],\


        'Math': [None,98, 96, 77, 90,90]}


df1 = DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong',\


                'DianWei','DianWei'], columns=['Chinese','English','Math'])


# df3 = df3.drop(index=['guanyu'])


df2 = df1.drop_duplicates()


df2.rename (columns={'Chinese':' 语文 ','English':' 英语 ','Math':' 数学 '},inplace=True)

df2["total_score"] = df2.sum(axis=1)


# df1 = df1.apply(sum_score,axis=1)


df2 [' 数学 '].fillna (df2 [' 数学 '].mean (), inplace=True)

print(df2)


2020-01-10


爬行的蜗牛

data={' 语文 ':[66, 95, 95, 90, 80, 80],' 英语 ':[65, 85, 92, 88, 90,90], ' 数学 ':['', 98, 96, 77, 90, 90]}

df1 = DataFrame (data, index=[' 张飞 ', ' 关羽 ', ' 赵云 ',' 刘备 ',' 典韦 ',' 典韦 '], columns=[' 语文 ',' 英语 ',' 数学 '])

df1 = df1.drop_duplicates()


df1.dropna () # 删除或则填充，我选择删除，貌似删除含有 Null 的行有点问题

print(df1)


2020-01-10


强者自强

之前代码没写注释，这个习惯不好，看了评论里的代码，写的真的好，认识到自己有很多不足的地方，还要多学习这些好的代码。

import pandas as pandas


import numpy as np


from pandas import DataFrame


#表数据

data = {'names':[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],'Chinese':[66,95,95,90,80,80],'English':[65,85,92,88,90,90]

      ,'Math':[np.NaN,98,96,77,90,90]}


#建表

df = pd.DataFrame(data,index=[0,1,2,3,4,5],columns=['names','Chinese','English','Math'])


#将列字段改成中文

df = df.rename (columns={'Chinese':' 语文 ','English':' 英语 ','Math':' 数学 '})

#去重复行

df = df.drop_duplicates()


#查空列

isNaN = df.isnull().any()


#用平均值补全空值

df [' 数学 '][0]=np.mean (df [:][' 数学 '])

#定义函数增加新列

def muti_sum(df):


df ['total'] = df [' 数学 ']+df [' 英语 ']+df [' 语文 ']

    return df


#为数据表增加新列

df = df.apply(muti_sum,axis=1)


print(df)


2020-01-04


motorlei


import pandas as pd


from pandas import DataFrame


from pandasql import sqldf, load_meat, load_births


# 导入数据

score = DataFrame(pd.read_excel('score.xlsx'))


print (' 原生数据:')

print (score)


# 数据去重

score = score.drop_duplicates()


print (' 去重后数据:')

print (score)


# 列名改为英文

score.rename (columns={' 姓名 ':'Name',' 语文 ':'Chinese',' 英语 ':'English',' 数学 ':'Math'},inplace=True)

print (' 修改列名后数据:')

print (score)


# 列名重新排序

cols = ['Name','Chinese','Math','English']


score = score.filter(cols,axis=1)


print (' 列名重排后数据:')

print (score)


# 查看哪一列存在空值

print (score.isnull().any())


print (score.isnull())


# 使用数据成绩均值填充张飞同学的缺失值

score['Math'].fillna(score['Math'].mean(),inplace=True)


print (' 数据清洗完成后数据:')

print (score)


# 新增一列总和

# 由于发现当行记录当中存在 NaN 空值时无法计算总和，所以需要对数据先进行清洗

def add_sum(df):


    df['Sum'] = df['Chinese'] + df['Math'] + df['English']


    return df


score = score.apply(add_sum,axis=1)


print (' 加入新列总分后的数据 ')

print (score)


# 按照总分排序由高到低

score.sort_values(['Sum'],ascending=[False],inplace=True)


print (' 最终数据:')

print (score)


# 显示数据具体信息

print (' 数据统计信息:')

print (score.describe())


score.to_excel('last_score.xlsx')


作者回复：代码正确，如果不用 xlsx 的同学，也可以使用 score = DataFrame (pd.read_csv ('score.csv', encoding='gbk'))

2019-12-09


毕延超

执行 sql 语句的那里 globals 与 locals 的用法有什么区别

作者回复: locals () 和 globals () 就是局部变量和全局变量的区别

2019-12-03


nqluo


#补 NaN

cols = ['Chinese','English','Math']


for col in cols:


    if df1[col].isnull().sum().sum():


        #print(col)


        #print(df1[col].isnull().sum().sum())


        df1[col].fillna(df1[col].mean(), inplace=True)


        #print(df1[col].isnull().sum().sum())


        


print(df1)


2019-11-18


知悉者也

stu_score = pd.DataFrame ([[' 张飞 ', 66, 65, np.nan],

[' 关羽 ', 95, 85, 98],

[' 赵云 ', 95, 92, 96],

[' 黄忠 ', 90, 88, 77],

[' 典韦 ', 80, 90, 90],

[' 典韦 ', 80, 90, 90]],

columns = [' 姓名 ',' 语文 ', ' 英语 ', ' 数学 '])

stu_score = stu_score.set_index (' 姓名 ') # 将某一列作为索引

stu_score = stu_score.fillna (axis=1, method='ffill') # 以左边来填充缺失值

stu_score [' 总分 '] = stu_score.apply (sum , axis=1)

stu_score


作者回复：正确，使用的很熟练

2019-11-07


Jeff.Smile


「其中 axis=1 代表按照列为轴进行操作，axis=0 代表按照行为轴进行操作，args 是传递的两个参数，即 n=2, m=3，在 plus 函数中使用到了 n 和 m，从而生成新的 df「

------------------------------------------------------------------------------------


老师，axis 的解释是不是写反了

2019-11-06


疯子书生 z

想知道是啥时候出的教程，python2 都停更了

作者回复：后面代码用的都是 Python3

2019-10-24


无心剑

# 成绩处理 V1.1

import pandas as pd


df = pd.read_excel('e:/excelfiles/test2.xlsx')


print ("原表：")

print(df)


# 1. 用列均值填充 NaN 值

for i in range(1, len(df.columns)):


    col = df.columns[i]


    col_mean = round(df[col].mean(), 1)


    index = df[df[col].isnull()].index[0]


    df.loc[index, col] = col_mean


print ("用列均值填充 NaN 值：")

print(df)


    


# 2. 删除重复的行

df = df.drop_duplicates()


print ("删除重复的行：")

print(df)


# 3. 添加总分字段，计算总分

df [' 总分 '] = (df [' 语文 '] + df [' 英语 '] + df [' 数学 ']) / 3

print ("添加总分字段：")

print(df)


作者回复：赞下认真做作业的同学，这个总分应该指的是平均分

2019-10-16


无心剑

Python 数据分析学习笔记 04：Pandas 基础（https://blog.csdn.net/howard2005/article/details/102561307）今天跟着陈老师学习 Pandas，挺有收获。

作者回复：加油！

2019-10-15


无心剑

如果有多条记录的多个字段存在 NaN，要一个一个地补全是比较麻烦的事情，简单粗暴的做法：凡是遇到有 NaN 的行，统统 Kill 掉。

作者回复：直接 drop 掉是一种方式，有时候还是需要补全的，尤其是对后续分析有帮助的时候

2019-10-15


无心剑

【源程序】

import pandas as pd


from pandas import DataFrame


df = pd.read_excel('e:/excelfiles/score.xlsx')


print ("原表：")

print(df)


# 1. 删除有 NaN 值的行

cols = []


nullcols = df.isnull().any()


for i in range(len(nullcols)):


    if nullcols[i] == True:


        cols.append(nullcols.index[i])


nulltable = df.isnull()


for i in range(len(cols)):


    nullindex = nulltable[nulltable[cols[i]] == True].index[0]


    df = df.drop(index = nullindex)


print ("删除有 NaN 的行：")

print(df)


    


# 2. 删除重复的行

df = df.drop_duplicates()


print ("删除重复的行：")

print(df)


# 3. 添加总分字段，计算总分

df [' 总分 '] = (df [' 语文 '] + df [' 英语 '] + df [' 数学 ']) / 3

print ("添加总分字段：")

print(df)


【运行结果】

原表：

姓名 语文 英语 数学

0 张飞 66 65 NaN

1 关羽 95 85 98.0

2 赵云 95 92 96.0

3 黄忠 90 88 77.0

4 典韦 80 90 90.0

5 典韦 80 90 90.0

删除有 NaN 的行：

姓名 语文 英语 数学

1 关羽 95 85 98.0

2 赵云 95 92 96.0

3 黄忠 90 88 77.0

4 典韦 80 90 90.0

5 典韦 80 90 90.0

删除重复的行：

姓名 语文 英语 数学

1 关羽 95 85 98.0

2 赵云 95 92 96.0

3 黄忠 90 88 77.0

4 典韦 80 90 90.0

添加总分字段：

姓名 语文 英语 数学 总分

1 关羽 95 85 98.0 92.666667

2 赵云 95 92 96.0 94.333333

3 黄忠 90 88 77.0 85.000000

4 典韦 80 90 90.0 86.666667

作者回复：赞 做的不错

2019-10-15


逆光 Aidi

不是很懂删空格那里，老师能讲一下吗

作者回复: #删除左右两边空格

df2['Chinese']=df2['Chinese'].map(str.strip)


#删除左边空格

df2['Chinese']=df2['Chinese'].map(str.lstrip)


#删除右边空格

df2['Chinese']=df2['Chinese'].map(str.rstrip)


如果你想要把字符串中所有的空格都去掉，可以使用 df2 ['Chinese'].replace (' ', '')

2019-09-27


王定坤

# coding=utf-8


import pandas as pd


from pandas import DataFrame


data = {' 语文 ':[66, 95, 95, 90, 80, 80], ' 数学 ':[None, 98, 96, 77, 90, 90], ' 英语 ':[65, 85, 92, 88, 90, 90]}

df = DataFrame (data, index=[' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '], columns=[' 语文 ', ' 数学 ', ' 英语 '])

df = df.drop_duplicates()


df [' 总分 '] = df [' 语文 '].add (df [' 数学 '], fill_value=0).add (df [' 英语 '], fill_value=0)

print df


作者回复：正确，用的 Python2

2019-08-28


Geek_545e3b


我想了两个办法，有一个是借鉴了别人的语句，老师帮我看看第二个办法 pandas 中有没有方法或者函数帮我简化一下循环，我试了很多，只能想到将 df.isnull 的值放到列表来进行条件判断

第一个方法：

import pandas as pd


from pandas import DataFrame


data={'Chinese':[66,95,93,90,80,80],'English':[65,85,92,88,90,90],'Math':[None,98,96,77,90,90]}


names=['Zhangfei','Guangyu','Zhaoyun','Huangzhong','Dianwei','Dianwei']


subjects=['Chinese','English','Math']


df=DataFrame(data,index=names,columns=subjects)


df=df.drop_duplicates()


print(df)


# df=df.rename (columns={'Chinese':' 语文 ','English':' 英语 ','Math':' 数学 '}), 下面 inplace 可以在原数据修改，不需要赋值

df.rename (columns={'Chinese':' 语文 ','English':' 英语 ','Math':' 数学 '},inplace=True)

judge_kemu=[]


for x in df.isnull().any():


    judge_kemu.append(x)


#如果数据量大，自动填充空白值

if True in judge_kemu:


    kemu=[]


    for b in df:


        if df[b].isnull().any():


            kemu.append(b)


    for item in kemu:


        df.fillna(df[item].mean(),inplace=True)


df [' 总分 ']=df.sum (axis=1)

print(df.describe())


第二个方法：

import pandas as pd


from pandas import DataFrame


data={'Chinese':[66,95,93,90,80,80],'English':[65,85,92,88,90,90],'Math':[None,98,96,77,90,90]}


names=['Zhangfei','Guangyu','Zhaoyun','Huangzhong','Dianwei','Dianwei']


subjects=['Chinese','English','Math']


df=DataFrame(data,index=names,columns=subjects)


df=df.drop_duplicates()


print(df)


# df=df.rename (columns={'Chinese':' 语文 ','English':' 英语 ','Math':' 数学 '}), 下面 inplace 可以在原数据修改，不需要赋值

df.rename (columns={'Chinese':' 语文 ','English':' 英语 ','Math':' 数学 '},inplace=True)

judge_kemu=[]


for x in df.isnull().any():


    judge_kemu.append(x)


#如果数据量大，自动填充空白值

if True in judge_kemu:


    kemu=[]


    for b in df:


        if df[b].isnull().any():


            kemu.append(b)


       for item in kemu:


           average=df[item].mean()


           for name in df.index:


               if str(df[item][name])=='nan':


                   df[item][name]=average


df [' 总分 ']=df.sum (axis=1)

print(df.describe())


2019-08-22


Geek_661f9f


第一次试着挣扎地写完整，折腾了好久

# ！/usr/bin/env python


# -*- coding:utf-8 -*-


import pandas as pd


import numpy as np


data = {' 语文 ':[66,95,95,90,80,80],' 英语 ':[65,85,92,88,90,90],

' 数学 ':[None,98,96,77,90,90],'tatal':[None,None,None,None,None,None]}

df1= pd.DataFrame (data,index=[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],

columns=[' 语文 ',' 英语 ',' 数学 ','total'])

#print(df1)


#去重复行

df1 = df1.drop_duplicates()


print(df1)


'''


#查空值

df1= df1.isnull()


print(df1)


df1= df1.isnull().any()


print(df1)


'''


#用数学平均值补充张飞的数学成绩

df1 [' 数学 '].fillna (df1 [' 数学 '].mean (),inplace=True)

#计算总成绩并进行排名

df1['total']=sorted(df1.sum(axis=1))


print(df1)


作者回复: Good Job，完成就是胜利

2019-08-14


张怡铭

#!/usr/bin/env python3


# -*- coding: utf-8 -*-


import pandas as pd


from pandas import Series, DataFrame


# x1 = Series([1,2,3,4])


# x2 = Series(data = [1,2,3,4], index=['a', 'b', 'c', 'd'])


# print(x1)


# print(x2)


#


# # 字典

# d = {'a':1, 'b':2, 'c':3, 'd':4}


# x3 = Series(d)


# print(x3)


#


# # DataFrame 数据库表

#


# data = {'chinese':[66, 95, 93, 90, 80],


# 'english':[65,85, 92, 88, 90],


# 'math':[30, 98, 96, 77, 90]}


#


# df1 = DataFrame(data)


# df2 = DataFrame(data, index=['zhangfei', 'nanyi', 'zym', 'mengyi', 'lwei'], columns=['chinese', 'english', 'math'])


# print(df1)


# print(df2)


# print(df2.describe())


#


score = DataFrame(pd.read_excel('data09.xlsx'))


# print(score)


score = score.drop_duplicates()


# print(score)


# print(score.isnull())


# print(score.describe())


#二、指定 inplace 参数 填充 NaN 值

score [' 数学 '].fillna (score [' 数学 '].mean (), inplace = True)

print(score)


def plus(df):


df [' 总分 '] = df [' 语文 '] + df [' 英语 '] + df [' 数学 ']

    return df


score = score.apply(plus, axis = 1)


print(score)


'''


## 参数

DataFrame.sort_values(by, axis=0, ascending=True, inplace=False, kind='quicksort', na_position='last')


#### 参数说明

axis:{0 or ‘index’, 1 or ‘columns’}, default 0，默认按照索引排序，即纵向排序，如果为 1，则是横向排序

by:str or list of str；如果 axis=0，那么 by="列名"；如果 axis=1，那么 by="行名"；

ascending: 布尔型，True 则升序，可以是 [True,False]，即第一字段升序，第二个降序

inplace: 布尔型，是否用排序后的数据框替换现有的数据框

kind: 排序方法，{‘quicksort’, ‘mergesort’, ‘heapsort’}, default ‘quicksort’。似乎不用太关心

na_position : {‘first’, ‘last’}, default ‘last’，默认缺失值排在最后面

'''


print (score.sort_values (by = ' 总分 ', axis = 0, ascending= False, inplace= False))

作者回复: Good Job 多谢分享

2019-07-31


六天六夜六斤作业

赞！非常好，非常精炼！！！继续学习下去

作者回复：感谢支持，加油！

2019-07-29


Geek_ray


为何我更改数据类型不报错，但不成功？拿老师的代码尝试，也是如此，求助

作者回复：需要 check 下环境

2019-07-23


刘宇滨

练习题：

import pandas as pd


data = {"name": ["张飞", "关羽", "赵云", "黄忠", "典韦", "典韦"],

        "chinese": [66, 95, 95, 90, 80, 80],


        "english": [65, 85, 92, 88, 90, 90],


        "math": [None, 98, 96, 77, 90, 90]}


grade_df = pd.DataFrame(data, columns=["name", "chinese", "english", "math"])


# 去除重复行

grade_df = grade_df.drop_duplicates()


# 重命列名

grade_df.rename (columns={"name":"姓名", "chinese":"语文", "english":"英语", "math":"数学"}, inplace=True)

# 用数学成绩平均值填充张飞数学成绩缺失值

math_mean = grade_df ["数学"].mean ()

grade_df = grade_df.fillna(math_mean)


grade_df ["总成绩"] = grade_df.sum (axis=1)

作者回复: Good Job

2019-07-21


Geek_shirley


这些函数库很多 bi 工具都支持，而且 bi 工具用起来更容易上手，并自动 data visualization。老师如何看待 python 和 bi 工具的差别？

作者回复: python 本身可以做一些 BI 的工作，当然也可以使用第三方的 BI 工具

如果是打比赛的话，比如 kaggle，一般还是自己写的多，因为需要做一些特征工程，然后再调用各种算法模型

2019-07-17


twelve


import pandas as pd


df1 = pd.read_excel('shizan-5.xlsx',index_col=0)


#数据清洗

df1 = df1.drop_duplicates ()# 去重

df1 = df1.drop (index=df1 [df1.isnull ().any (axis=1) == True].index)# 删除有空值的行

#数据统计

def sum_of_all(df):


df [u' 总分 '] = df [u' 语文 '] + df [u' 英语 '] + df [u' 数学 ']

    return df


df1 = df1.apply(sum_of_all,axis=1)


print (df1.sort_values (by=u' 总分 '))

作者回复: Good Job

2019-07-16


xqs42b


我提个小小的建议，希望老师说明一下执行环境，还有就是 strip, apply, upper, title, lower,.... 是 python 函数，还是 pandas 里面的呢！

2019-07-05


内存爆了

## 课后习题：

- 我的答案：感觉知识没有全用上，数学成绩 NaN 没解决

```python


import pandas as pd


from pandas import Series, DataFrame


data = DataFrame(pd.read_excel('data1.xlsx'))


df = DataFrame(data)


df = df.drop_duplicates()


def sum(df):


df ['zcj'] = (df [u' 语文 ']+df [u' 英语 ']+df [u' 数学 '])

    return df


df = df.apply(sum, axis=1)


print(df)


```


看到评论才知道别人多么优秀啊，加油！

作者回复：加油

2019-07-02


2525


python 3.0 习题代码:

import pandas as pd


pd.set_option('display.unicode.ambiguous_as_wide', True)


pd.set_option('display.unicode.east_asian_width', True)


df1=pd.DataFrame (data={"语文":[66,95,95,90,80,80],"英语":[65,85,92,88,90,90],"数学":[None,98,96,77,90,90]},

index=("张飞","关羽","赵云","黄忠","典韦","典韦"))

print(df1,end="\n_______________________\n")


df1.drop_duplicates (subset=["语文","英语","数学"],keep="last",inplace=True)

df1.dropna(inplace=True)


print(df1,end="\n_______________________\n")


def sum(serie_item):


serie_item ["总和"]=serie_item.values.sum ()

    return serie_item


df1=df1.apply(sum,axis=1)


print(df1)


作者回复: Good Job

2019-07-01


从前从前

import pandas as pd


from pandas import DataFrame,Series


data = {'Chinese':[66,95,95,90,80,80],'Math':[None,98,96,77,90,90],'English':[65,85,92,88,90,90]}


df = DataFrame (data,index = [' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],columns=['Chinese','English','Math'])

#去除重复

df = df.drop_duplicates()


# 修改列名

df.rename (columns={'Chinese':' 语文 ','Math':' 数学 ','English':' 英语 '},inplace=True)

#使用平均值填补空值

df [' 数学 '].fillna (df [' 数学 '].mean (),inplace=True)

#计算总分

df [' 总和 '] = df [' 语文 ']+df [' 数学 '] + df [' 英语 ']

#排名

df.sort_values ([' 总和 '],ascending=[False],inplace=True)

print(df)


# 想请教两个问题

# 1、想在名字那列的列名改为姓名，要怎么改呢

# 2、已经改完列名了，接下来想用 SQL 的方式做出练习题中的答案，要怎么做呢

2019-06-29


华夏

import pandas as pd


from pandas import Series, DataFrame


data = {' 语文 ': [66, 95, 93, 90, 80, 80],' 英语 ': [65, 85, 92, 88, 90, 90],' 数学 ': [None, 98, 96, 77, 90, 90]}

df1 = DataFrame (data, index=[' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '],

columns=[' 语文 ', ' 英语 ', ' 数学 '])

def total_score(df1):


df1 ['total_score'] = df1 [' 语文 '] + df1 [' 数学 '] + df1 [' 英语 ']

    return df1


df1 = df1.drop_duplicates()


df1 [' 数学 '].fillna (df1 [' 数学 '].mean (), inplace = True)

df1 = df1.apply(total_score, axis = 1)


df1.rename (columns={'total_score': ' 总和 '}, inplace=True)

print(df1)


作者回复: Good Job

2019-06-28


lycan


import pandas as pd


import numpy as np


from pandas import DataFrame,Series


#定义 DataFrame

df = {'Chinese':[95,95,95,90,80,80],'english':[65,85,92,88,90,90],'math':[None,98,96,77,90,90]}


my_frame = pd.DataFrame(df,index=['ZhangFei','GuanYu','ZhaoYun','HuangZhong','DianWei','DianWei'])


def clean(df):


    df = pd.DataFrame(df)


#去除重复值

    df = df.drop_duplicates()


#检查是否包含空值，

    result_series = df.isnull().any()


    #print(result_series)


#获取包含空值的列名

    NaN_index = result_series[result_series.values==True].index


    #print(NaN_index)


#将平均值添加到空值中

    for item in NaN_index:


        df[item].fillna(df[item].mean(),inplace=True)


#添加一列，算出总成绩

    df['score'] = df.sum(axis=1)


#排序

    df.sort_values('score',ascending=False,inplace=True)


    return df


my_frame = clean(my_frame)


print(my_frame)


陈老师您好，上边是我写的作业，有个问题再最后调用我定义的 clean 方法的时候，clean (my_frame) 是没有报错的，但是使用 my_frame.apply (clean) 就会报好多错，希望您能解答一下，谢谢

2019-06-26


David


def plus(df,n,m):


df ['new1'] = (df [u' 语文 ']+df [u' 英语 ']) * m

df ['new2'] = (df [u' 语文 ']+df [u' 英语 ']) * n

    return df


df1 = df1.apply(plus,axis=1,args=(2,3,))


最后 args 这里为什么不能写（scores,2,3）呢？

2019-06-26


窝窝头

import pandas as pd


data = {' 语文 ': [66, 95, 93, 90, 80, 80], ' 英语 ': [65, 85, 92, 88, 90, 90],

' 数学 ': [None, 98, 96, 77, 90, 90]}

df = pd.DataFrame (data, index=[' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '],

columns=[u' 英语 ', u' 数学 ', u' 语文 '])

df=df.dropna()


df = df.drop_duplicates()


df [u' 总和 '] = df [u' 语文 ']+df [u' 英语 ']+df [u' 数学 ']

df.head()


作者回复: Good Job

2019-06-24


建强

思考题的程序代码如下，思考题要求增加一列总和我用到了数据合并，做了很多尝试，得出结论是：和数据库的 SQL 语句中的 inner join 不同，inner join 是按关联条件进行数据关联，而 Pandas 在做数据合并时必须要基于相同的列，无法用关联条件，没有相同的列无法进行合并：

import pandas as pd


from pandas import Series, DataFrame


#创建学生成绩单

Mark = {' 语文 ': [66, 95, 95, 90,80,80]

,' 英语 ': [65, 85, 92, 88, 90, 90]

,' 数学 ': [None, 98, 96, 77, 90, 90]

,' 姓名 ': [' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 ']

        }


StudentMark = DataFrame (Mark,columns=[' 姓名 ',' 语文 ', ' 英语 ', ' 数学 '])

#去除重复行

StudentMark = StudentMark.drop_duplicates()


print ('---- 去除重复行结果 -------')

print(StudentMark)


  


#增加一列总成绩

t = {' 姓名 ':list (StudentMark [' 姓名 ']),' 总和 ':list (StudentMark.sum (axis=1))}

t = DataFrame (t,columns=[' 姓名 ',' 总和 '])

StudentMark = pd.merge(StudentMark,t,how='inner')


print ('---- 增加总和结果 -------')

print(StudentMark)


作者回复: Good Job

2019-06-23


薛定谔的猫

data = {'Chinese': ['ss', 'nf','',' ds','cd '],'English': ['sd', 'ws', 'cd', 'sa', 'fv']}


df5 = DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'DianWei'], columns=['English','Chinese'])


print(df5.describe())


结果为：

       English Chinese


count 5 5


unique 5 5


top sa nf


freq 1 1


结果表示看不懂

2019-06-21


是剑雄啊～

1. 创建数据：两种方式

import pandas as pd


from pandas import Series,DataFrame


1).a = pd.read_csv('C:/Users/Jason/Desktop/test.csv', sep=',',encoding='gbk')


a


2).data ={u' 姓名 ':[u' 张飞 ',u' 关羽 ',u' 赵云 ',u' 黄忠 ',u' 典韦 ',u' 典韦 '],

u' 语文 ':[66,95,95,90,80,80],

u' 英语 ':[65,85,92,88,90,90],

u' 数学 ':[None,98,96,77,90,90]}

df = DataFrame(data)


输出:

姓名 数学 英语 语文

0 张飞 99.0 65 66

1 关羽 98.0 85 95

2 赵云 96.0 92 95

3 黄忠 77.0 88 90

4 典韦 90.0 90 80

5 典韦 90.0 90 80

2. 删除空值

df = df.drop(index=[0])


3. 去除重复值

df = df.drop_duplicates()


4. 加入总成绩

def total(df):


df [u' 总成绩 '] = df [u' 语文 '] + df [u' 数学 '] + df [u' 英语 ']

    return df


df = df.apply(total,axis=1)


5. 总成绩排名

a.sort_values (u' 总成绩 ',ascending=False)

姓名 语文 英语 数学 总成绩

2 赵云 95 92 96.0 283.0

1 关羽 95 85 98.0 278.0

4 典韦 80 90 90.0 260.0

3 黄忠 90 88 77.0 255.0

2019-06-20


建强

请问老师，用 python 做数据分析和清洗，和现在比较流行的 Hadoop 平台中的各种组件做数据分析相比，两者各有什么优劣，各自用在什么场景？

2019-06-18


GentleCP


请问老师，在创建 DataFrame 的时候 columns 是设定列的字段名，但是这个字段名不能覆盖 index 的字段名，例如:

  Name | Chinese | Math


张飞 | 89 | 98

中张飞是 index 索引，他的字段名 Name 无法在 columns 中创建，最后形成的表左上角是空白的，这个怎么解决呢

2019-06-17


Wing·三金

今日新知：

df 中的 str 用法：Series.map 以及 Series.str.strip/lstrip/rstrip

pandasql：用 sql 的语言操作 pd

import pandas as pd


思考题：

# data building


subjects = ('Chinese', 'English', 'Math')


names = (' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 ')

grades = [(66, 65, ),


         (95, 85, 98),


         (95, 92, 96),


         (90, 88, 77),


         (80, 90, 90),


         (80, 90, 90)]


df = pd.DataFrame(grades, columns=subjects, index=names)


# data cleaning


df.drop_duplicates(inplace=True)


df ['Math'].fillna (df ['Math'].mean (), inplace=True) # 感觉这个操作有点高估了张飞 emmmm

# sum up and sort by total scores


df['Total'] = df.sum(axis=1)


df.sort_values(by='Total', ascending=False)


2019-06-02


春风沐古

import pandas as pd


from pandas import Series,DataFrame


score=DataFrame({


' 语文 ':[66,95,95,90,80,80],

' 英语 ':[65,85,92,88,90,90],

' 数学 ':[None,98,96,77,90,90]},

index=[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '])

score=score.drop_duplicates()


# 查看哪一行是空值，如果是未知的，for 遍历

# print(score.isnull().sum())


score [' 数学 '].fillna (score [' 数学 '].mean (),inplace=True)

score [' 总分 ']=score [' 语文 ']+score [' 英语 ']+score [' 数学 ']

print(score)


2019-05-29


Eline


data = {'Chinese': [66, 95, 93, 90,80],'English': [65, 85, 92, 88, 90],'Math': [30, 98, 96, 77, 90]}


df3 = DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'DianWei'], columns=['English', 'Math', 'Chinese'])


# 删除左右两边空格

df3['Chinese']=df3['Chinese'].map(str.strip)


# 删除左边空格

# df3['Chinese']=df3['Chinese'].map(str.lstrip)


# 删除右边空格

# df3['Chinese']=df3['Chinese'].map(str.rstrip)


--------------------------------------------------------------------------


TypeError Traceback (most recent call last)


<ipython-input-186-a713f0ae82bd> in <module>


1 # 删除左右两边空格

----> 2 df3['Chinese']=df3['Chinese'].map(str.strip)


3 # 删除左边空格

      4 df3['Chinese']=df3['Chinese'].map(str.lstrip)


5 # 删除右边空格

C:\software\Anaconda3\lib\site-packages\pandas\core\series.py in map(self, arg, na_action)


   3380 """


   3381 new_values = super(Series, self)._map_values(


-> 3382 arg, na_action=na_action)


   3383 return self._constructor(new_values,


   3384 index=self.index).__finalize__(self)


C:\software\Anaconda3\lib\site-packages\pandas\core\base.py in _map_values(self, mapper, na_action)


   1216


   1217 # mapper is a function


-> 1218 new_values = map_f(values, mapper)


   1219


   1220 return new_values


pandas/_libs/lib.pyx in pandas._libs.lib.map_infer()


TypeError: descriptor 'strip' requires a 'str' object but received a 'int'


老师，帮忙看下，我用的是 Anaconda 自带的 py3.7.3 版本执行的，但还是提示类型不对，试了其他方法也不行。

2019-05-28


寻心

# -*- coding: utf-8 -


import pandas as pd


from pandas import DataFrame


data = {' 语文 ':[66,95,95,90,80,80], ' 英语 ':[65,85,92,88,90,90], ' 数学 ':[None, 98, 96,77,90,90]}

df = DataFrame (data, index=[' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '], columns=[' 语文 ', ' 英语 ', ' 数学 '])

df = df.drop_duplicates()


df = df.fillna(0)


def plus(df):


df [' 总和 '] = df [' 语文 '] + df [' 英语 '] + df [' 数学 ']

return df


df = df.apply(plus, axis=1)


print ''


print df


2019-05-27


Kyle


score = {' 姓名 ':[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],' 语文 ':[66,95,95,90,80,80],' 英语 ':[65,85,92,88,90,90],' 数学 ':[None,98,96,77,90,90]}

heros_score = DataFrame(score)


heros_score = heros_score.drop_duplicates()


a = heros_score [' 数学 '].mean ()

heros_score.loc [0,' 数学 '] = a

heros_score [' 总和 '] = heros_score.sum (axis = 1)

print(heros_score)


2019-05-22


大斌

最主要的数据结构是 series 和 dataframe，提供的可用作数据清洗的函数有：drop ()、rename ()、drop_duplicates ()、astype ()、strip ()、upper ()、lower ()、title ()、isnull ()、apply ()

2019-05-20


大斌

import pandas as pd


from pandas import DataFrame


data = {'Chinese':[66,95,95,90,80,80],'English':[65,85,92,88,90,90],'Math':[0,98,96,77,90,90]}


df = DataFrame(data,index=['zhangfei','guanyu','zhaoyun','huangzhong','dianwei','dianwei'])


#去除重复的值

df = df.drop_duplicates()


#新增一列综合计算每个人三科成绩之和

df [' 总和 ']=df.apply (lambda x:x.sum (),axis=1)

print(df)


作者回复: Good Job

2019-05-19


青石

from pandas import DataFrame


def score(df):


    df['score'] = df[u'Chinese'] + df[u'English'] + df[u'Math']


    return df


data = {'Chinese': [66, 95, 95, 90, 80, 80], 'English': [65, 85, 92, 88, 90, 90], 'Math': [None, 98, 96, 77, 90, 90]}


df = DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'DianWei', 'DianWei'], columns=['Chinese', 'English', 'Math'])


df = df.drop_duplicates().fillna(0)


df = df.apply(score, axis=1)


print(df)


作者回复: Good Job

2019-04-11


滢

语言：Python3.6 环境：IDLE

>>> data={'Chinese':[66,95,95,90,80,80],'English':[65,85,92,88,90,90],'Math':[None,98,96,77,90,90]}


>>> scoreframe = DataFrame (data,index=[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],columns=['Chinese','English','Math'])

>>> #删除重复数据

>>> scoreframe.drop_duplicates()


    Chinese English Math


张飞 66 65 NaN

关羽 95 85 98.0

赵云 95 92 96.0

黄忠 90 88 77.0

典韦 80 90 90.0

>>> #第一步：删除重复数据

>>> scoreframe.drop_duplicates()


    Chinese English Math


张飞 66 65 NaN

关羽 95 85 98.0

赵云 95 92 96.0

黄忠 90 88 77.0

典韦 80 90 90.0

>>> 第二步:# 检查是否有空值

>>> scoreframe.isnull()


    Chinese English Math


张飞 False False True

关羽 False False False

赵云 False False False

黄忠 False False False

典韦 False False False

典韦 False False False

>>> #对张飞的数学成绩进行补充

>>> scoreframe['Math'].fillna(scoreframe['Math'].mean(),inplace = True)


>>> #添加新的一行，求和

>>> def total_score(scoreframe):


scoreframe [' 总分 '] = scoreframe.sum (axis=0)

return scoreframe


 >>> scoreframe = scoreframe.apply(total_score,axis =1)


Chinese English Math 总分

张飞 66.0 65.0 90.2 221.2

关羽 95.0 85.0 98.0 278.0

赵云 95.0 92.0 96.0 283.0

黄忠 90.0 88.0 77.0 255.0

典韦 80.0 90.0 90.0 260.0

典韦 80.0 90.0 90.0 260.0

>>> #替换名称

>>> scoreframe.rename (columns={'Chinese':' 语文 ','English':' 英语 ','Math':' 数学 '},inplace = True)

>>> print (scoreframe)


语文 英语 数学 总分

张飞 66.0 65.0 90.2 221.2

关羽 95.0 85.0 98.0 278.0

赵云 95.0 92.0 96.0 283.0

黄忠 90.0 88.0 77.0 255.0

典韦 80.0 90.0 90.0 260.0

典韦 80.0 90.0 90.0 260.0

疑问：对于最左上角的姓名，该如何输入表格中？ 如果要对成绩进行排名，并自动填写上名词，该如何写？

2019-04-04


郑志宾

老师，数据表合并中的 NaN 是怎么计算出来的，怎么出现的。例如 left 左连接中 df3 中 data2 列中的 NaN 是怎么计算出来的，过程是怎么样？

2019-04-03


_xiongyi


import pandas as pd


from pandas import Series, DataFrame


df1 = DataFrame({'name':['ZhangFei','GuanYu','a','b','c'],'data1':range(5)})


df2 = DataFrame({'name':['ZhangFei','GuanYu','A','B','C'],'data2':range(5)})


df3 = pd.merge(df1,df2,how='outer')


print(df3)


import pandas as pd


from pandas import Series, DataFrame


data = {'Chinese':[66,95,95,90,80,80],'English':[65,85,92,88,90,90],'Math':[None,98,96,77,90,90]}


df1 = DataFrame(data,index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'DianWei','DianWei'],


                columns=['Chinese','English','Math'])


df1 = df1.drop_duplicates()


def plus(df):


df [' 总分 ']=(df [u'Chinese']+df [u'English']+df [u'Math'])

    return df


df1 = df1.apply(plus,axis=1)


print(df1)


作者回复: Good Job

2019-04-02


『G YaQi』


import pandas as pd


from pandas import Series, DataFrame


data = [[66, 65],


        [95, 85, 98],


        [95, 92, 96],


        [90, 88, 77],


        [80, 90, 90],


        [80, 90, 90]]


names = [' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 ']

classes = [' 语文 ',' 英语 ',' 数学 ']

df = DataFrame(data=data,index=names,columns=classes)


df.dropna(inplace=True)


df.drop_duplicates(inplace=True)


df [' 总分 '] = df. 语文 + df. 英语 + df. 数学

print(df)


作者回复: Good Job

2019-03-19


Geek_ce3c1f


import pandas as pd


# 创建数据表

data = {'Chinese': [66, 95, 95, 90, 80, 80],'English': [65, 85, 92, 88, 90, 90],'Math': [None, 98, 96, 77, 90, 90]}


df = pd.DataFrame(data, index=['ZhangFei', 'GuanYu',


                                'ZhaoYun', 'HuangZhong',


                                'DianWei','DianWei'], columns=['Chinese','English','Math'])


# 去除重复行

df = df.drop_duplicates()


# 将空值转换为 0

# df = df.fillna(0)


# 将空值替换为均值

# df = df.fillna (df.mean (axis=' 数学 '))

# 重命名行列名

df.rename (index={'ZhangFei':' 张飞 ', 'GuanYu':' 关羽 ', 'ZhaoYun':' 赵云 ', 'HuangZhong':' 黄忠 ', 'DianWei':' 典韦 '},

columns={'Chinese':' 语文 ','English':' 英语 ','Math':' 数学 '},inplace=True)

# 将空值替换为均值

df = df.fillna (df [' 数学 '].mean ())

# 创建新列并且计算每个人的三科成绩总和

df [' 总成绩 '] = df [' 语文 '] + df [' 英语 '] + df [' 数学 ']

print(df)


print(df.describe())


作者回复: Good Job

2019-03-18


Reinhardt Gao


环境 Python3.7 Anaconda

注释段落尝试用 sql 去修改空值但是编译的时候报错说找不到表。但是同一个位置写 select * from spreadsheet 就没有问题。老师可否帮忙看一下？

其他编译均通过

from pandas import DataFrame


from pandasql import sqldf


# Create table


score = {'Name':['Zhang Fei', 'Guan Yu', 'Zhao Yun', 'Huang Zhong', 'Dian Wei', 'Dian Wei'],'Chinese': [66, 95, 95, 90, 80, 80], 'English': [65, 85, 92, 88, 90, 90], 'Mathematics': [None, 98, 96, 77, 90, 90]}


spreadsheet = DataFrame(score)


print(spreadsheet)


# Data Preparation


spreadsheet.drop_duplicates()


print(spreadsheet.isnull())


spreadsheet.fillna(spreadsheet['Mathematics'].mean(),inplace=True)


print(spreadsheet.isnull())


'''


Has problem with this code. WHen executing this part, interpreter throws out exception


as "sqlite3.OperationalError: no such table: spreadsheet".


But if we run "Select * from spreadsheet" here, no exception throw out.


pysql = lambda sql: sqldf(sql, globals())


sql1 = "update spreadsheet " \


       "set Mathematics = 0 " \


       "where Name = 'Zhang Fei'"


print(pysql(sql1))


'''


# Add new column


spreadsheet['Total'] = spreadsheet[u'Chinese'] + spreadsheet[u'English'] + spreadsheet[u'Mathematics']


print(spreadsheet)


作者回复: Good Job

2019-03-15


颖

def double_df(x):


           return 2*x


df1 [u' 语文 '] = df1 [u' 语文 '].apply (double_df)

这个运行报错：

TypeError: cannot concatenate object of type "<class 'int'>"; only pd.Series, pd.DataFrame, and pd.Panel (deprecated) objs are valid


2019-03-10


均

import pandas as pd


from pandas import Series,DataFrame


def total_score(df):


df [' 总分 ']=(df [u' 语文 ']+df [u' 英语 ']+df [u' 数学 '])

    return df


def main():


data={' 姓名 ':[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],' 语文 ':[66,95,95,90,80,80],' 英语 ':[65,85,92,88,90,90],' 数学 ':[0,98,96,77,90,90]}

    df1=DataFrame(data)


    df1=df1.drop_duplicates()


    df1=df1.apply(total_score,axis=1)


    print(df1)


作者回复: Good Job

2019-03-03


叶えなくちゃ

import pandas as pd


data = {'Chinese':[66,95,95,90,80,80],


        'English':[65,85,92,88,90,90],


        'Math':[None,98,96,77,90,90]}


df = pd.DataFrame (data, index=[' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '],columns=['English','Chinese','Math'])

# 数据清洗

# 1. 去除重复行

df = df.drop_duplicates()


# 求和

df['total'] = df['Chinese'] + df['English'] + df['Math']


# 2. 排序

cols = ['Chinese', 'English', 'Math']


df = df.filter(cols, axis=1)


# 3. 改成中文列名

df.rename (columns={'Chinese':' 语文 ','English':' 英语 ','Math':' 数学 ','total':' 总和 '}, inplace=True)

# 4. 填充缺失值 (使用平均值)

df [' 数学 '].fillna (df [' 数学 '].mean (), inplace=True)

print(df)


作者回复: Good Job

2019-02-19


Sandy


# !/usr/bin/env python


# -*- coding: utf-8 -*-


from pandas import DataFrame


def plus(df):


    df['total'] = df['Chinese']+df['English']+df['Math']


    return df


data = {'Chinese': [66, 95, 95, 90,80, 80],'English': [65, 85, 92, 88, 90, 90],'Math': [None, 98, 96, 77, 90, 90]}


df = DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'DianWei', 'DianWei'], columns=['English', 'Math', 'Chinese'])


#去重

df = df.drop_duplicates()


#查 null

print(df.isnull().any())


#平均值填 null

df['Math'].fillna(df['Math'].mean(), inplace=True)


#总分

df['total'] = df['Chinese']+df['English']+df['Math']


#df = df.apply(plus, axis=1)


#排序

df.sort_values('total',ascending=False, inplace=True)


print(df)


2019-02-18


U. 均宇

执行完代码： df2 ['Chinese']=df2 ['Chinese'].map (str.strip)，只能输出‘Chinese' 这一列的数值。

而如果这时执行 print（df2），还是原来的 df2 (没有去除空格前的状态)

有没有类似如 inplace = True 的办法，可以更改原表的值呢？期待老师解答

2019-02-15


草包雷

import pandas as pd


from pandas import DataFrame


data = {' 语文 ': [66,95,95,90,80,80],' 英语 ': [65,85,92,88,90,90],' 数学 ': [None,98,96,77,90,90]}

df = DataFrame (data, index=[' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ',' 典韦 '], columns=[' 语文 ', ' 英语 ', ' 数学 '])

df = df.drop_duplicates()


df=df.fillna(0)


def addtotal(df):


df [' 总分 '] = df [' 语文 '] + df [' 英语 '] + df [' 数学 ']

     return df


df = df.apply(addtotal,axis=1)


print (df)


语文 英语 数学 总分

张飞 66.0 65.0 0.0 131.0

关羽 95.0 85.0 98.0 278.0

赵云 95.0 92.0 96.0 283.0

黄忠 90.0 88.0 77.0 255.0

典韦 80.0 90.0 90.0 260.0

作者回复: Good Job

2019-02-15


Dull


使用 Pyhon3.7+Pycharm 编写，最后使用 sort_value.() 方法对总成绩进行降序排序。

# -*- coding: utf-8 -*-


import pandas as pd


from pandas import Series, DataFrame


data = {'Chinese': [66, 95, 95, 90,80,80],'English': [65, 85, 92, 88, 90,90],'Math': [None, 98, 96, 77, 90,90]}


df = DataFrame (data,index=[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],columns=['Chinese','English','Math'])

print(df)


df = df.drop_duplicates()


df.rename (columns = {'Chinese':' 语文 ','English':' 英语 ','Math':' 数学 '}, inplace = True)

df [' 数学 '].fillna (df [' 数学 '].mean (),inplace=True) #df.fillna (df.mean ()) 好像也可以

def new(df):


df [' 总分 '] = (df [' 语文 ']+df [' 数学 ']+df [' 英语 '])

return df


df = df.apply(new,axis=1)


print(df)


df1 = df.sort_values (by=[' 总分 '],ascending=False)

print(df1)


作者回复: Good Job

2019-02-13


王彬成

1、在 pandas 中，最主要的数据结构是 Series 和 DataFrame

Series: 是个定长的字典序列。俩个基本属性：index 和 values

DataFrame：类似于数据库表，包括行索引和列索引。

2、对于 DataFrame 数据清洗的函数

1）删除不必要的列或行：drop（）

df=df.drop(columns=['Math']


df=df.drop(index=['ZhangFei']


2）重命名列名 columns：rename

rename(columns=new_names, inplace=True)


3）去重复的行 dtop_duplicates ()

4）格式问题

4.1 更改数据格式 astype ()

4.2 删除数据间的空格 strip (), lstrip (), rstrip ()

4.3 大小写转换 upper (), lower (), title ()

df.columns= df.columns.str.upper () ## 全部大写

4.4 查找空值 df.isnull (), df.isnull ().any ()

5）使用 apply 函数进行‘大写转换’、数值处理、新增列

————————————————————


代码呈现

## 作业代码：对数据进行清洗，新增一列总和

import pandas as pd


from pandas import DataFrame


data={' 语文 ':[66,95,95,90,80,80],' 英语 ':[65,85,92,88,90,90],' 数学 ':[None,98,96,77,90,90]}

df=DataFrame (data,index=[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],columns=[' 语文 ',' 英语 ',' 数学 '])

## 删除重复行

df=df.drop_duplicates()


## 查找缺失值缺失值

print(df.isnull())


## 利用平均值补充‘张飞’的缺失值

df [' 数学 '].fillna (df [' 数学 '].mean (),inplace=True)

## 新增一列‘总分’

df [' 总分 ']=df [' 语文 ']+df [' 英语 ']+df [' 数学 ']

## 按照总分排序，从高到低，输出

df.sort_values ([' 总分 '],ascending=False,inplace=True)

## 输出最终结果

print(df)


print(df.describe())


作者回复: Good Job

2019-01-31


Lambert


import pandas as pd


from pandas import DataFrame


data = {' 语文 ':[66,95,95,90,80,80],' 英语 ':[65,85,92,88,90,90],' 数学 ':[None,98,96,77,90,90]}

df1 = DataFrame(data)


df2 = DataFrame (data,index=[' 张飞 ', ' 关羽 ',' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '],

columns=[' 语文 ',' 英语 ',' 数学 '] )

df2 = df2.drop_duplicates()


df2 [' 数学 '].fillna (df2 [' 数学 '].mean (), inplace=True)

def add(df2):


df2 [' 总和 '] = (df2 [u' 语文 '] + df2 [u' 英语 '] + df2 [u' 数学 '])

    return df2


df3 = df2.apply(add, axis=1,args=())


print(df3)


2019-01-22


Mickey


在存入 excel 的时候，写 score.to_excel ('data.xlsx') 时报错 No module named 'openpyxl' 。

根据知道安装了 openpyxl, 然后怎么运行存入 excel 的操作呢？能否详细说明下？

2019-01-20


Sniper


交作业（python3）：

import pandas as pd


from pandas import Series, DataFrame


data = {'Chinese': [66, 95, 95, 90, 80, 80],'English': [65, 85, 92, 88, 90, 90],'Math': [None, 98, 96, 77, 90, 90]}


df1= DataFrame(data)


df2 = DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'DianWei', 'DianWei'],


                columns=['Chinese', 'English', 'Math'])


# print (df2)


# 对数据去重

df2 = df2.drop_duplicates()


# 用平均值填充张飞数学成绩

df3 = df2.isnull () # 对每个坐标判断是否为空且返回 dataframe

# 返回 columns 列表

a = df2.columns


a = list(a)


# 返回 index 列表

b = df2.index


b = list(b)


# 对空值用均值填充

for course in a:


    course_average = df2[course].mean()


    for name in b:


        if df3.loc[name, course]:


            df2.loc[name, course] = course_average


        else:


            pass


# 添加求和列

def plus(df):


    df['total'] = df['Chinese'] + df['Math'] + df['English']


    return df


plus(df2)


df2 = df2.apply(plus,axis=1)


print(df2)


作者回复: Good Job

2019-01-19


柚子

df = pd.DataFrame({'name'['zhangfei','gaunyu','zhaoyun','huangzhong','dianwei','dianwei'],


                               'chinese':[66,95,95,90,80,80],


                               'english':[65,85,92,88,90,90],


                               'math':[None,98,96,77,90,90]})


df = df.drop_duplicates () #去除重复值

df = df.fillna (0) #空值填充，可以用 0 或者数学成绩的平均值

df['total'] = df['chinese'] + df['english'] + df['math']


df


作者回复: Good Job

2019-01-18


胖陶

import numpy as np


from pandas import DataFrame


data={'yuwen':[66,95,95,90,80,80],'yingyu':[65,85,92,88,90,90],'shuxue':[np.nan,98,96,77,90,90]}


df=DataFrame(data,index=['zhangfei','guanyu','zhaoyun','huangzhong','dianwei','dianwei'],columns=['yuwen','yingyu','shuxue'])


df.drop_duplicates()


df['shuxue']=df['shuxue'].fillna(df['shuxue'].mean())


df['sum']=df['yuwen']+df['yingyu']+df['shuxue']


df.rename (columns={'yuwen':' 语文 ','yingyu':' 英语 ','shuxue':' 数学 ','sum':' 总和 '},inplace=True)

2019-01-16


胖陶

删除列那边的代码会报错啊。。。。df2 = df2.drop (['Chinese'],axis=1)

2019-01-15


马克图布

#!/usr/bin/env python3


# -*- coding: utf-8 -*-


from pandas import DataFrame


data = {u' 语文 ': [66, 95, 95, 90, 80, 80], u' 英语 ': [65, 85, 92, 88, 90, 90], u' 数学 ': [None, 98, 96, 77, 90, 90]}

name = [u' 张飞 ', u' 关羽 ', u' 赵云 ', u' 黄忠 ', u' 典韦 ', u' 典韦 ']

df1 = DataFrame(data, index=name)


# Drop duplicated data


df1 = df1.drop_duplicates()


# Fill the NaN with average grade


df1.fillna (value=df1 [u' 数学 '].mean (), inplace=True)

# Calculate the total grade


df1 [u' 总分 '] = df1.sum (axis=1)

print(df1)


print(df1.describe())


---


老师，想问一下，如果在文件开头的 shebang 中已经指定了 `# -*- coding: utf-8 -*-` 的编码方式，在代码中还需要在每一个中文字符串前加上 u 吗？

作者回复：代码里可以不加上 u，也是 work 的

2019-01-14


追梦小乐

老师，缺省值在真实工作中一般是怎么处理的？做题的时候我的第一反应就是给缺失值补充 0，不过我看到有用平均值的，这里面有什么讲究的吗？

作者回复：具体情况具体分析，也可以是填充平均值，或者找那条记录和哪条记录比较相近，就会另一条记录里的那个字段值来填充 也是一种方式

2019-01-11


夏小爱

# /usr/bin/env python2.7


# -*- coding:utf-8 -*-


from pandas import DataFrame


import numpy as np


data = np.array([[66, 95, 95, 90, 80, 80], [65, 85, 92, 88, 90, 90], [None, 98, 96, 77, 90, 90]])


df = DataFrame (data.T, index=["张飞", "关羽", "赵云", "黄忠", "典韦", "典韦"], columns=["语文", "英语", "数学"])

print df


df ["数学"].fillna (df ["数学"].mean ().astype (int), inplace=True)

df = df.drop_duplicates()


df ["总分"] = df.sum (axis=1)

print df


df.describe()


print df.loc ["张飞"]

作者回复: Good Job

2019-01-11


圆圆的大食客

import pandas as pd


from pandas import Series, DataFrame


data = {'Chinese': [66, 95, 93, 90, 80, 80],'English': [65, 85, 92, 88, 90, 90],'Math': [None, 98, 96, 77, 90, 90]}


df1= DataFrame(data)


df2 = DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'DianWei', 'Dianwei'], columns=['Chinese', 'English', 'Math'])


df2 = df2.drop_duplicates()


print (df2.isnull()) #Find out null


df2 = df2.fillna(df2.mean()) #Fill null with average


df2['Sum'] = df2.apply(lambda x: x.sum(), axis=1 ) #add column 'Sum' to sum grades


print (df2)


作者回复: Good Job

2019-01-10


程序员小熊猫

import pandas as pd


from pandas import DataFrame


data = {'Chinese':[66, 95, 95, 90, 80, 80], 'English':[65, 85, 92, 88, 90, 90],


        'Math':[None, 98, 96, 77, 90, 90]}


df = DataFrame(data, index=['zhangfei', 'guanyu', 'zhaoyun', 'huangzhong', 'dianwei', 'dianwei'],


                columns=['Chinese', 'English', 'Math'])


# 清除重复行 dianwei

df = df.drop_duplicates()


# 行名、列名改成中文 df.rename (index={'zhangfei':' 张飞 ', 'guanyu':' 关羽 ', 'zhaoyun':' 赵云 ', 'huangzhong':' 黄忠 ', 'dianwei':' 典韦 '}, columns={'Chinese':' 语文 ', 'English':' 英语 ', 'Math':' 数学 '}, inplace=True)

# 填充缺省值

df [' 数学 '].fillna (df [' 数学 '].mean (), inplace=True)

# 新增一列「总分」，然后排序

df [' 总分 '] = df.apply (func=lambda x:x [' 语文 '] + x [' 英语 '] + x [' 数学 '], axis=1)

df.sort_values (' 总分 ', ascending=False, inplace=True)

作者回复: Good Job

2019-01-09


黑小白白白

请教老师，Python3 中 DataFrame 如何对列名是中文的数据进行操作呢。

2019-01-09


孙有能希

data = {'Chinese': [66, 95, 95, 90, 80, 80], 'English':[65, 85, 92, 88, 90, 90], 'Math':[None, 98, 96, 77, 90, 90]}


df = DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'Dianwei', 'Dianwei'], columns=['Chinese', 'English', 'Math'])


print(df)


df = df.drop_duplicates()


df = df.fillna(df.mean())


df['All'] = df['Chinese'] + df['English'] + df['Math']


print(df)


2019-01-09


外星人

import pandas as pd


from pandas import Series, DataFrame


from pandasql import sqldf, load_meat, load_births


# 对数据进行清洗。同时新增一列「总和」计算每个人的三科成绩之和

score = DataFrame(pd.read_excel('E:/item_python/test/pandas/exercise1.xlsx'))


print(score)


score = score.drop_duplicates () #去重

default = {' 姓名 ':' 无名氏 ',' 语文 ':0,' 英语 ':0,' 数学 ':0}

#score [' 数学 '].fillna (0,inplace=True) #补空值

score = score.fillna(default)


print(score)


def plus(df):


df [' 总和 '] = df [' 语文 ']+df [' 英语 ']+df [' 数学 ']

    return df


score = score.apply (plus, axis=1) #求和

print(score)


2019-01-09


xfoolin


一、

在 Pandas 有两个数据结构，分别是 Series 和 DataFrame。

DataFrame 提供的数据清洗函数是：

- 删除 drop,

- 删除重复行 drop_duplicates

- 重命名列名 rename

- 格式转换 astype

- 去除空格 strip

- 大小写转换（upper,lower,title）

- 查找空值 isnull 和 isnull ().any ()

- 使用 apply 函数来嵌套其他函数实现更多要求

二、

import pandas as pd


from pandas import DataFrame


scores = DataFrame ({' 姓名 ':[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],

' 语文 ':[66,95,95,90,80,80],

' 英语 ':[65,85,92,88,90,90],

' 数学 ':[None,98,96,77,90,90]

                    })


print(scores)


scores = scores.drop_duplicates()


print(scores.isnull().any())


scores = scores.fillna(0)


scores [' 总和 '] = scores.sum (axis = 1)

print(scores)


2019-01-07


灵灵

# -- coding: utf-8 -


import numpy as np


import pandas as pd


from pandas import Series,DataFrame


from numpy import nan as NaN


date = DataFrame ({' 姓名 ':[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],' 语文 ':[66,95,95,90,80,80],' 英语 ':[65,85,92,88,90,90],' 数学 ':[NaN,98,96,77,90,90]})

print (date)


df1 = date.drop_duplicates()


print (df1)


df2 = df1.copy()


df2 [' 数学 '].fillna (df2 [' 数学 '].mean (), inplace=True)

print (df2)


def totaiscore(df2):


df2 [' 总分 ']=df2 [' 语文 ']+df2 [' 英语 ']+df2 [' 数学 ']

    return df2


print (totaiscore(df2))


2019-01-07


少年不识钱滋味

第五讲笔记

https://mubu.com/doc/3QadR_xU7v


2019-01-07


陈亦凡

https://github.com/26huitailang/python-of-data-analysis/blob/master/geek-time/ch05-pandas.ipynb


👆上面是我用 jupyter 写的，可以在线查看，参考了其他同学平均值补全的方法。

2019-01-06


胡

__author__ = 'Administrator'


import pandas as pd


from pandas import DataFrame


from pandasql import sqldf


data={' 语文 ':[66,95,95,90,80,80],' 英语 ':[65,85,92,88,90,90],' 数学 ':[None,98,96,77,90,90]}

df1=pd.DataFrame (data,index=[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],columns=[' 英语 ', ' 数学 ', ' 语文 '])

print(df1)


df1=df1.drop_duplicates ()# 去重

print(df1)


print (df1.isnull ())# 显示那边有空值

df1 [' 数学 '].fillna (df1 [' 数学 '].mean (), inplace=True)

print(df1)


df1 [' 总分 '] = df1 [' 语文 '] + df1 [' 英语 '] + df1 [' 数学 ']# 这样操作就会插入新的一列

print(df1)


2019-01-06


易平

#作业创建成绩数据表，并新增一列总和

data2={' 姓名 ':[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],' 语文 ':[66,95,95,90,80,80],' 英语 ':[65,85,92,88,90,90],' 数学 ':[None,98,96,77,90,90]}

df8=pd.DataFrame(data2)


#去除重复

df9=df8.drop_duplicates()


#排查空值和用 0 分代替空值

df9.isnull().any()


#补全张飞的数学成绩

df9=df9.fillna(0)


#求和

def count_score(df):


df [' 总分 ']=df [' 语文 ']+df [' 英语 ']+df [' 数学 ']

    return df


    


df9=df9.apply(count_score,axis=1)


print(df9)


2019-01-05


李沛欣

今天的看完了，有点儿吃力，哈哈。pandas 的关键在于数据清洗功能和载入现成数据的功能。它主要的两个数据结构是 series 和 dataframe，主要的函数，有重命名，增删，去重，大小写等等。但是看到后面关于左啊右啊的，就蒙圈了。

作者回复：了解前面的就算是了解了 pandas 的核心。后面是关于一些数据库的查询操作，你可以重点对前面的两个数据结构，还有主要函数多一些操作。这些在 python 中使用频率算是比较高的

2019-01-04


瑞

import pandas as pd


from pandas import Series,DataFrame


data={'name':[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],

      'Chinese':[66,95,95,90,80,80],'English':[65,85,92,88,90,90],'Math':[None,98,96,77,90,90],


     'total':[0,0,0,0,0,0]}


df=DataFrame(data,columns=['name','Chinese','English','Math','total'])


# print(df)


df.rename (columns={'name':' 姓名 ','Chinese':' 语文 ','English':' 英语 ','Math':' 数学 ','total':' 总分 '},inplace=True)

# print (df)


df=df.drop_duplicates()


df=df.fillna(0)


print (df)


def total_df(df):


df [' 总分 ']=df [' 语文 ']+df [' 英语 ']+df [' 数学 ']

    return df


df.apply(total_df,axis=1)


作者回复：张飞的数学在做清洗的时候会发现为空，可以用平均值的方式先补充上

2019-01-03


瑞

我也是这个问题，用的 python3，df2 ['English']=df2 ['English'].map (str.strip) 这个也有问题

df2 = df2.drop (columns=['Chinese']) 这行代码后，返回结果是:

TypeError Traceback (most recent call last)


<ipython-input-25-8116650c61ac> in <module>()


----> 1 df2 = df2.drop(columns=['Chinese'])


TypeError: drop() got an unexpected keyword argument 'columns'


2019-01-02


瑞

python3


df2=df2.drop (index=['zhangfei']) 报错

2019-01-02


I.L


import pandas as pd


data = {' 姓名 ': [' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '],

' 语文 ': [66, 95, 95, 90, 80, 80],

' 英语 ': [65, 85, 92, 88, 90, 90],

' 数学 ': [None,98, 96, 77, 90, 90]}

data_table = pd.DataFrame(data)


data_table = data_table.drop_duplicates()


data_table [' 数学 '].fillna (data_table [' 数学 '].mean (), inplace=True)

data_table [' 总和 '] = data_table [' 英语 '] + data_table [' 语文 '] + data_table [' 数学 ']

data_table


#注意点：

#Dataframe 中的 apply 函数类似于 map 函数

#在 apply 例子中：

#df1.apply(plus, axis=1, args=(2,3,))


#可以在 apply 函数的 args 参数中传递对应函数（plus）的参数

#inner left right outer 就像 SQL 中的 inner left right full

#其中通过 SQL 方式对 Dataframe 进行查询的方式很棒，之前没有了解过

#正如热评中的做法，数据的清洗过程需要的不仅仅是删除，更多的应该是近似值填充

2019-01-01


tjcslx


#!/usr/bin/env python


# coding: utf-8


# 使用 Jupyter Notebook 进行脚本编写

import pandas as pd


import numpy as np


from pandas import DataFrame


# 创建数据集并进行数据清洗：清除重复的行；

# 录入数值时，空值用 None 或 np.nan；defaultValues 为字段为空时的默认值，姓名字段默认为「无姓名」，成绩字段默认为 0

# 分别使用 drop_duplicates 和 fillna 方法进行去重复值及空值填充

data = {'Name': [' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '], 'Chinese': [66, 95, 95, 90, 80, 80], 'English': [65, 85, 92, 88, 90, 90], 'Maths': [None, 98, 96, 77, 90, 90]}

df = DataFrame(data, columns=['Name', 'Chinese', 'English', 'Maths'])


defaultValues = {'Name': ' 无姓名 ', 'Chinese': 0, 'English': 0, 'Maths': 0}

df = df.drop_duplicates()


# 按照默认值进行填充

df = df.fillna(defaultValues)


# 使用其他学生的平均值对空值进行填充

# df['Maths'].fillna(df['Maths'].mean(), inplace=True)


# 总和列的值等于语数外三列之和

# 按照总和列倒序排列

df [' 总和 '] = df ['Chinese'] + df ['English'] + df ['Maths']

print (df.sort_values (by=' 总和 ', ascending=False))

2018-12-31


竹本先生

import pandas as pd


from pandas import DataFrame


person = DataFrame(


{


' 语文 ': [66,65,95,90,80,80],

' 英语 ': [65,85,92,88,90,90],

' 数学 ': [None,98,96,77,90,90]

},


index=[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],

columns=[' 语文 ',' 英语 ',' 数学 ']

)


# ~ 删除重复行

person.drop_duplicates(inplace=True)


# ~ 用数学平均分填充缺失数据

person [' 数学 '].fillna (person [' 数学 '].mean (), inplace=True)

# ~ 计算总分

def sum_score(df):


df [' 总分 '] = df [' 语文 '] + df [' 英语 '] + df [' 数学 ']

return df


person = person.apply(sum_score, axis=1)


print(person)


运行结果如下：

语文 英语 数学 总分

张飞 66.0 65.0 90.25 221.25

关羽 65.0 85.0 98.00 248.00

赵云 95.0 92.0 96.00 283.00

黄忠 90.0 88.0 77.00 255.00

典韦 80.0 90.0 90.00 260.00

2018-12-30


周飞

# -*- coding: utf-8 -*


import pandas as pd


import numpy as np


from pandas import Series, DataFrame


data = {'chinese': [66, 95, 95,90, 80,80],'english': [65, 85, 92, 88, 90,90],'math': [ np.nan,98, 96, 77, 90,90]}


df2 = DataFrame(data, index=['zhangfei', 'guanyu', 'zhaoyun', 'huangzhong', 'dianwei','dianwei'], columns=['chinese', 'english', 'math'])


df2.drop_duplicates(inplace=True)


print (df2)


df2.rename (columns={'chinese': ' 语文 ', 'english': ' 英语 ','math':' 数学 '},index={'zhangfei': ' 张飞 ', 'guanyu': ' 关羽 ','zhaoyun':' 赵云 ','huangzhong':' 黄忠 ','dianwei':' 典韦 '}, inplace = True)

df2.isnull()


df2.loc [' 张飞 ',' 数学 ']=0

df2 [' 总和 '] = df2 [' 语文 ']+df2 [' 英语 ']+df2 [' 数学 ']

print (df2)


2018-12-29


沐念邪

columns 写中文出错

作者回复：代码前填写 # coding: utf-8

中文前添加 u

这两个你试试

2018-12-29


xyw pro


import pandas as pd


from pandas import Series, DataFrame


data = {'chinese':[66,95,95,90,80,80],'english':[65,85,92,88,90,90],'math':[None,98,96,77,90,90]}


df1 = pd.DataFrame(data,index=['zhangfei','guanyu','zhaoyun','dianwei','huangzhong','huangzhong'])


#去除重复行

df1 = df1.drop_duplicates()


# 列名重新排序

cols = ['chinese', 'math', 'english']


df = df1.filter(cols, axis=1)


#列名改成中文

df1.rename (columns={'chinese': ' 语文 ', 'english': ' 英语 ',

'math': ' 数学 '}, inplace=True)

#加总成绩

def total_score(df):


df [u' 总成绩 '] = df [u' 语文 ']+df [u' 数学 ']+df [u' 英语 ']

    return df


df1 = df1.apply(total_score,axis=1)


2018-12-28


半夏

请问 df [u' 语文 '] 和 df [' 语文 '] 有什么区别？ 这个 u 是做什么用的

2018-12-28


HxScript


环境是：在阿里云 ECS 搭建的 jupyter notebook，环境一次配好就可以一直用了，不受设备的限制，随时随用。如果只是学 python，学生党 10 块钱一个月的配置就够了，非常滴划算！

代码如下：

import pandas as pd


data = {' 语文 ': [66, 95, 95, 90, 90, 90],' 英语 ': [65, 85, 92, 88, 90,90],' 数学 ': [None, 98, 96, 77, 90,90]}

df = pd.DataFrame (data, index=[' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ',' 典韦 ',' 典韦 2'], columns=[' 语文 ', ' 英语 ', ' 数学 '])

# print(df)


# 去重：要该行中，除了 index 外，其他列内容完全一致，才会被去重。

df = df.drop_duplicates()


# print(df)


def total_socre(df):


df [' 总分 '] = df [' 语文 '] + df [' 英语 '] + df [' 数学 ']

    return df


df = df.apply(total_socre, axis = 1)


df.sort_values ([' 总分 '], ascending = [False], inplace = True)

# print(df)


# 处理 NaN：

# 方案 1：直接删除

df1 = df.dropna()


# print(df1)


# 方案 2：用均值替换

# print(df.isnull())


df.fillna (df [' 数学 '].mean (), inplace = True)

# print(df)


df = df.apply(total_socre, axis = 1)


df.sort_values ([' 总分 '], ascending = [False], inplace = True)

print(df)


2018-12-27


X


感谢老师，今天学到蛮多，对 pandas 的运用还需要靠大量的练习才能逐渐熟悉各个 API

import pandas as pd


from pandas import Series, DataFrame


import numpy as np


# 初始数据

data = {' 姓名 ':[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],' 语文 ':[66,95,95,90,80,80],' 英语 ':[65,85,92,88,90,90],' 数学 ':[None,98,96,77,90,90]}

# 装载 data 数据到 DataFrame

df = DataFrame(data)


print(df)


# 清除重复数据

df = df.drop_duplicates()


print(df)


# 求和，若有空值按 0 分计算

def sum_score(df):


#替换 NaN 的数据为 0 分

a = (0 if np.isnan (df [' 数学 ']) else df [' 数学 '])

df [' 总和 '] = a + df [' 英语 '] + df [' 语文 ']

    return df


# 新增一列总和

df = df.apply(sum_score, axis=1)


print(df)


# 用数学平均值填充空值

df [' 数学 '].fillna (df [' 数学 '].mean (), inplace=True)

df = df.apply(sum_score, axis=1)


print(df)


2018-12-26


Chino


在贴代码之前首先问老师几个问题

第一个是 老师您说过 这里引用 "其中 axis=1 代表按照列为轴进行操作，axis=0 代表按照行为轴进行操作，args 是传递的两个参数，即 n=2, m=3，在 plus 函数中使用到了 n 和 m，从而生成新的 df"

这里 axis 又蒙了 上一讲老师不是说 axis=0 的时候 代表竖着 也就是列 axis=1 的时候 是横着 也就是行 是因为上一节是 numpy 而这一节是 pandas 所以不一样吗 还是我理解错了

另外就是那个 apply 里 axis=0 和 axis=1 这里有点不懂 为什么文章中的例子 (也就是求两个成绩乘 n,m 倍的那里 我改成 axis=0 就报错了 是为什么呢. (大概我把 pandas DataFrame 这里的 axis 理解好了就懂了？)

然后是作业代码

import pandas as pd


from pandas import DataFrame


data = {' 语文 ': [66,95,95,90,80,80], ' 英语 ': [65,85,92,88,90,90], ' 数学 ': [None,98,96,77,90,90]}

df1 = DataFrame (data,index=[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '])

df1 = df1.drop_duplicates()


# print(df1.isnull())


# print(df1.isnull().any())


df1.fillna (df1 [' 数学 '].mean (),inplace=True)

df1 [' 总计 '] = df1 [' 语文 '] + df1 [' 英语 '] + df1 [' 数学 ']

print(df1)


2018-12-26


Destroy、


import pandas as pd


df = pd.read_csv('wzrycj.csv', encoding='gb2312')


df.info()


df = df.drop_duplicates()


df = df.copy()


for i in df [df [' 数学 '].isnull ()].index:

df.iloc [i, 3] = df [' 数学 '].mean ()

def sumScore(df):


df ['total'] = df [' 语文 '] + df [' 英语 '] + df [' 数学 ']

    return df


df = df.apply(sumScore, axis=1)


df


姓名 语文 英语 数学 total

0 张飞 66 65 90.25 221.25

1 关羽 95 85 98.00 278.00

2 赵云 95 92 96.00 283.00

3 黄忠 90 88 77.00 255.00

4 典韦 80 90 90.00 260.00

这个留言不支持 markdown，写的代码很难看～

2018-12-26


大灰狼

老师我看了几节讲 python 的课程，完全看不懂说的意思，是要去先学习下 python 的基础课程吗？

2018-12-26


土豆毛毛

import pandas as pd


from pandas import Series, DataFrame


data = {'Chinese': [66, 95, 95, 90, 80, 80], 'English': [65, 85, 92, 88, 90, 90], 'Math': [None, 98, 96, 77, 90, 90]}


df1 = DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'DianWei', 'DianWei'], columns=['English', 'Math', 'Chinese'])


# Clean the data


df = df1.drop_duplicates() # remove duplicated lines


df.rename (index={'ZhangFei': ' 张飞 ', 'GuanYu': ' 关羽 ', 'ZhaoYun': ' 赵云 ', 'HuangZhong': ' 黄忠 ', "DianWei": ' 典韦 '}, inplace=True)

#print(df.describe()) # ouput corresponding statistic data


# Function: add a new line


def addSum(df):


    df['Sum'] = df['English'] + df['Chinese'] + df['Math']


    return df


# Use the average mark of Math to fill the NaN value


df.fillna(df['Math'].mean(), inplace=True)


# call the function and add a line called "Sum", pay attention to the value of axis


print(df.apply(addSum, axis=1))


2018-12-26


拉我吃

# coding: utf8


import pandas as pd


from pandas import Series, DataFrame


from pandasql import sqldf, load_meat, load_births


"""


对于下表的数据，请使用 Pandas 中的 DataFrame 进行创建，并对数据进行清洗。同时新增一列「总和」计算每个人的三科成绩之和。

"""


def total(df):


df [u' 总和 '] = (df [u' 语文 '] + df [u' 英语 '] + df [u' 数学 '])

    return df


# 导入并初始化数据到 DataFrame 中

df = pd.read_excel('Book.xlsx')


# 消除重复行

df = df.drop_duplicates()


# 添加并计算总成绩列

dfnew = df.apply(total, axis=1)


# 排序

dfnew = dfnew.sort_values ([u' 总和 '], ascending=False)

# 输出

print(dfnew)


2018-12-26


汪汪汪

import pandas as pd


import numpy as np


from pandas import Series, DataFrame


# 1. 创建表格数据

data = {"语文":[66, 95, 95, 90, 80, 80],

"英语":[65, 85, 92, 88, 90, 90],

"数学":[None, 98, 96, 77, 90, 90]}

df = DataFrame(data,


index=["张飞","关羽","赵云","黄忠","典韦","典韦"],

columns=["语文","英语","数学"])

print(df)


# 对数据进行清洗

# 1) 删除重复数据（典韦）

df1 = df.drop_duplicates()


# 2) 将空值 NaN 替换为 0

df1.fillna(0, inplace=True)


print(df1)


# 3) 新增一行，计算每个人的三科成绩之和

def total_score(df1):


df1 [u"总分"]=df1 [u"语文"]+df1 [u"英语"]+df1 [u"数学"]

    return df1


df2 = df1.apply(total_score, axis=1)


print(df2)


2018-12-26


Mingjie


我的代码

***************************


from pandas import Series, DataFrame


import re


from pandasql import sqldf, load_meat, load_births


data = {'name':[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '] ,

         'chinese': [66,95,95,90,80,80],'english': [65,85,92,88,90,90],'math': [None,98,96,77,90,90]}


df = DataFrame(data, columns=['name','english', 'chinese', 'math'])


print ("预览 \n",df)

#添加一列为总成绩并求和

def plus(df):


    #df['total'] = (df[u'Chinese']+df[u'English']+df[u'Math'])


    return df


#添加一列 ‘total’，并计算求和

df['total'] = df.sum(axis=1)


#首字母大写转换

df.columns = df.columns.str.title()


#去除空值的行

#df = df.dropna()


# 查找空值

print ("查找空值 \n",df.isnull ())

# 查找空值 并 将空值用平均值填充

none_series = df.isnull().any()


col_name = re.findall(r"'(.+?)'",str(none_series[none_series== True].index))


df[col_name[0]].fillna(df[col_name[0]].mean(), inplace=True)


# 去除重复行

df = df.drop_duplicates()


#按照总分排序

df.sort_values(['Total'], ascending=[False], inplace=True)


print ("数据清洗后 \n",df)

print ("统计数据 \n",df.describe ())

2018-12-25


怀念列侬

from pandas import Series, DataFrame


import numpy as np


data = {'Chinese': [66, 95, 93, 90, 80, 80], 'English': [65, 85, 92, 88, 90, 90], 'Math': [None, 98, 96, 77, 90, 90]}


df = DataFrame (data, index=[' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '], columns=['Chinese', 'English', 'Math'])

df = df.drop_duplicates()


df.rename (columns={'Chinese': ' 语文 ', 'English': ' 英语 ', 'Math': ' 数学 '}, inplace = True)

print df.describe().round()


df [' 总和 '] = np.where (df [' 语文 '].isnull (), 0, df [' 语文 ']) + np.where (df [' 英语 '].isnull (), 0, df [' 英语 ']) + np.where (df [' 数学 '].isnull (), 0, df [' 数学 '])

print df


2018-12-25


1e-43


import pandas as pd


data = {'Chinese':[66,95,95,90,80,80],'English':[65,85,92,88,90,90],'Math':[None,98,96,77,90,90]}


df1=pd.DataFrame(data,index=['zhangfie','guanyu','zhaoyun','huangzhong','dianwei','dianwwei'],columns=['Chinese', 'English' ,'Math'])


df2=df1.drop_duplicates()


df2.insert(3,'zonghe',df2.sum(axis=1))


2018-12-25


轨迹

pandas 的 dataframe 基本上就是关系数据库的表，pandas 对比表有什么优势

2018-12-25


不能忘记的笑容

老师，请问，用 apply 定义函数的时候，为什么要加 u，u 代表什么意思，例如：

def plus(df):


    df['total'] = (df[u'chinese']+df[u'english']+df[u'math'])


    return df


2018-12-25


北方

#!/usr/bin/env python


# -*- coding:utf8 -*-


# __author__ = ' 北方姆 Q'

# __datetime__ = 2018/12/25 10:36


import pandas as pd


data = {


    ' Chinese': [66, 95, 93, 90, 80, 80],


    'English ': [65, 85, 92, 88, 90, 90],


    ' Math ': [None, 98, 96, 77, 90, 90]


}


df = pd.DataFrame(data, index=['ZhangFei', 'GuanYu', 'ZhaoYun', 'HuangZhong', 'DianWei', 'DianWei'])


# 去重行

df = df.drop_duplicates()


# 列名去空格

df.columns = df.columns.str.strip()


# 列名转化

df.rename(columns={


'Chinese': ' 语文 ',

'English': ' 英语 ',

'Math': ' 数学 '

}, inplace=True)


# 补充缺考数据

df [' 数学 '].fillna (0, inplace=True)

# 添加总分列

df['Total'] = df.sum(axis=1)


print(df)


print("===========================")


print(df.describe())


2018-12-25


chochinlu


from pandas import DataFrame


scores = {


    'Chinese': [66, 95, 95, 90, 80, 80],


    'English': [65, 85, 92, 88, 90, 90],


    'Math': [None, 98, 96, 77, 90, 90]


}


df = DataFrame (scores, index=[' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '])

# clean data


df2 = df.drop_duplicates()


df2 = df2.replace([None], 0)


df2['Math'] = df2.astype(int)


def addSum(df):


    df['Sum'] = df['Chinese'] + df['English'] + df['Math']


    return df


print(df2.apply(addSum, axis=1))


2018-12-25


CNxxxxx


import pandas as pd


from pandas import Series, DataFrame


score = DataFrame(pd.read_excel('testdata.xlsx'))


#score = score.dropna()


# print(score)


#替换空值

score.fillna(score['music'].mean(), inplace=True)


score = score.drop_duplicates()


print(score)


#添加一列

def addTotalColumn(df):


    df['total'] = df.sum(axis=1)


    return df


score = addTotalColumn(score)


print(score)


score.to_excel('pd_practice_result.xlsx')


#抄袭了同学们的 idea

2018-12-25


Gerard


老师，您好！我数据的导入和输出代码运行不通，在这个工程目录下创建了一个 excel 表，然后还是显示没有这个文件，麻烦老师看到了解答一下

2018-12-25


Jie


import pandas as pd


from pandas import DataFrame


#写入数据

df1 = DataFrame(pd.read_excel('score_chinese.xlsx'))


#删除重复行

df1 = df1.drop_duplicates()


#删除含有空值的行

df1 = df1.dropna(axis = 0,how = 'any')


#计算总分

def total(df):


df [u' 总分 '] = df [u' 语文 '] + df [u' 英语 '] + df [u' 数学 ']

return df


df1 = df1.apply(total,axis =1)


print (df1)


2018-12-25


吴晓岚 jim wu

import numpy as np


import pandas as pd


from pandas import Series, DataFrame


data = {'Chinese':[66,95,95,90,80,80], 'English':[65,85,92,88,90,90], 'Math':[ None,98,96,77,90,90]}


df2 = DataFrame(data,index=['zhangfei','Guanyu','zhaoyun','huangzhong','dianwei','dianwei'])


print(df2)


df3 = df2.drop_duplicates(df2)


df3.fillna(df3['Math'].mean(),inplace=True)


df3['total'] = df3['Chinese'] +df3['English'] +df3['Math']


df3


2018-12-25


王 慈

# python 2.7


# IMPORT


import numpy as np


import pandas as pd


# 构造 DataFrame

df = pd.DataFrame ({u' 语文 ': [66, 95, 95, 90, 80, 80], u' 英语 ': [65, 85, 92, 88, 90, 90], u' 数学 ': [np.nan, 98, 96, 77, 90, 90]}, index=[u' 张飞 ', u' 关羽 ', u' 赵云 ', u' 黄忠 ', u' 典韦 ', u' 典韦 '], columns=[u' 语文 ', u' 英语 ', u' 数学 '])

# df.index.name = u' 姓名 '

# 去重

df.drop_duplicates(inplace=True)


# 均值填充空值 (略显不合理，请指教)

df [u' 数学 '].fillna (df [u' 数学 '].mean (), inplace=True)

# 求成绩总和

df [u' 总和 '] = df.sum (axis=1)

# 输出结果

print(df)


2018-12-24


跳跳

import pandas as pd


import pandas from Series,DataFrame


data={'chinses':[66,95,95,90,80,80],'English':[65,85,92,88,90,90],'math':[,98,96,77,90,90]}


df=DataFrame(data,indax=['zhangfei','guanyu','zhaoyun','huangzhong','diewei','diewei'],columns=['chinese','english','math'])


#判断是否有空值，0 替换空值

df.isnull()


df=df.fillna(0,inplace=True)


#查看一下统计值

print df.describe()


#去掉重复值

df=df.drop_duplicates()


def totalscore(df):


    df['totalscore']=df['chinese']+df['English']+df['math']


    return df


df1=df1.apply(totalscore,axis=1)


print df1


2018-12-24


JingZ


# Spider(Python 3.7)


# 创建表格数据

data = {' 语文 ':[65,95,95,90,80,80],' 英语 ':[65,85,92,88,90,90],' 数学 ':['',98,96,77,90,90]}

df = DataFrame (data,index=[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '],columns = [' 语文 ',' 英语 ',' 数学 '])

print(df)


# 数据清洗

df = df.drop_duplicates()


df = df.replace(to_replace = '',value=0)


print(df)


#新增「总和」

df [' 总和 ']=df [' 语文 ']+df [' 英语 ']+df [' 数学 ']

print(df)


#打印结果

df.replace(to_replace =0,value ='',inplace = True)


print(df)


2018-12-24


kyle


今日总结：

https://mubu.com/doc/tfLtTByI50


作者回复: 👍写总结的同学，另外也可以把总结的文字贴过来

2018-12-24


Non-constant


pandasql 真的好用.

作者回复：是的 省去很多事

2018-12-24


Lin_嘉杰

from pandas import DataFrame


data = {'chinese':[66,95,95,90,80,80],'english':[65,85,92,88,90,90],'math':[None,98,96,77,90,90]}


mark = DataFrame (data, index=[' 张飞 ',' 关羽 ',' 赵云 ',' 黄忠 ',' 典韦 ',' 典韦 '])

# print(mark)


# 清洗重复行

mark = mark.drop_duplicates()


# 将为空的数据填充为 0

mark = mark.fillna(0)


mark.rename (columns={'chinese':' 语文 ','english':' 英语 ','math':' 数学 '}, inplace=True)

def add(mark):


mark [' 总分 '] = mark [' 语文 '] + mark [' 英语 '] + mark [' 数学 ']

    return mark


mark = mark.apply(add, axis=1)


print(mark)


2018-12-24


mickey


#!/usr/bin/python


# vim: set fileencoding:utf-8


import pandas as pd


from pandas import DataFrame


# 导入成绩

data = pd.read_excel (u' 成绩表.xlsx')

df = DataFrame(data)


print df


# 求和，并增加一列「总和」

def addtotal(df):


df [u' 总和 '] = df [u' 语文 '] + df [u' 英语 '] + df [u' 数学 ']

    return df


# 清洗为空的数据

df1 = df.dropna()


# 清洗重复的数据

df1 = df1.drop_duplicates()


# 生成新数据结构

df1= df1.apply(addtotal, axis=1)


print(df1)


2018-12-24


Jbin


老师您好：

以下为今日练习，其中有个问题：数学列不知为何会自动增加一位小数，望方便时可以解答疑惑。

# coding=utf-8


from pandas import DataFrame


data = {' 姓名 ': [' 张飞 ', ' 关羽 ', ' 赵云 ', ' 黄忠 ', ' 典韦 ', ' 典韦 '], ' 语文 ': [66, 95, 95, 90, 80, 80],

' 英语 ': [65, 85, 92, 88, 90, 90], ' 数学 ': [None, 98, 96, 77, 90, 90]}

df1 = DataFrame(data)


df1 = df1.fillna (0) #将 NaN 填充 0

df1 = df1.drop_duplicates () #删除重复行

def plus(df):


df [' 总分 '] = df [' 语文 '] + df [' 数学 '] + df [' 英语 ']

return df


df1 = df1.apply (plus,axis=1) #添加总分列

print(df1)


2018-12-24


frazer


这就是传说中的数据清洗，好高大上的概念

作者回复：其实也是一些细节操作，根本目标就是让数据更规整

2018-12-24


狸猫假面

说起来 pandas 可以用 pivot_table 来构建数据透视表，请问老师有什么方法可以讲输出的透视表存储到文件中，例如 excel 中么？很多时候自己做的数据结果只能在 jupyter notebook 中看，感觉不太方便

2018-12-24


yaoyao7417


import pandas as pd


score = {'chinese':[66,95,95,90,80,80],'english':[65,85,92,88,90,90],'math':[0,98,96,77,90,90]}


df1 = pd.DataFrame(score,index=['ZhangFei','GuanYu','ZhaoYun','HuangZhong','DianWei','DianWei'])


df1 = df1.drop_duplicates()


df2 = df1['chinese'] + df1['english'] + df1['math']


df2 = pd.DataFrame(df2)


df3 = pd.merge(df1.T,df2.T,how='outer')


df3.rename(index={0:'chinese',1:'english',2:'math',3:'total'}).T


不太清楚张飞数学为空怎么整

2018-12-24


从未在此

import pandas as pd


data＝pd.DataFrame ({' 姓名 ':[' 张飞 ',' 吕布 ',' 典韦 ',' 典韦],

' 语文 ':[10,20,30,30],

' 数学 ':[,50,60,60]}

data.drop_duplicates()


data [' 数学 '].isnull ()=data [' 数学 '].mean ()

data [' 总和 ']=data.apply (lambda x:x.sum (),axis＝1)

手机打字太麻烦了。就少写一点。

还有那个统计函数那张图，标准差应该是 std, 老师写成 str 了

2018-12-24


Key.


Pandas 中最重要是数据结构是 Series 和 DataFrame，Series 是基于字典的数据结构，构成数据列 (index-value)，而 DataFrame 是由相同索引的 Series 构成的数据库表。Pandas 库相关的主要用途为数据清洗，数据统计，数据表连接，以及用 pandasql 操作数据表！数据清洗的方法比如有 drop (),columns (),drop_duplicates (),astype (),strip (),isnull (),apply (),upper (),lower (),title () 等等

2018-12-24


