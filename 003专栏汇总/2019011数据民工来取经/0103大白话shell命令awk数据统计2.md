# 大白话 shell 命令 awk：数据统计 (二)
> 原创 三十 数据民工来取经儿 2019-04-08

[大白话 shell 命令 awk：数据统计 (二)](https://mp.weixin.qq.com/s?__biz=MzA3NzUwNzc2NA==&mid=2456374080&idx=1&sn=b8641d8d7cb2dba07dc4e2446b2e1f5f&chksm=88cd169bbfba9f8d84ae12c89c7ba7538df8da23930994d69024e02e61118185133ee06a5fa2&scene=21#wechat_redirect)

## 01. 导读

### 1.1 阅读提示

阅读对象：初级数据分析师 + 了解 shell

难易程度：中等

使用频率：高频

练习环境: linux

### 1.2 内容简介

awk 是一个强大的文本处理语言，用于数据处理和统计。数据分析师应该 get 到它，会严重提高自己的数据处理效率。如果文件超过 Excel 处理能力，因为希望立刻得到基本统计信息，来不及或不想投入一定时间写 python 或其他程序处理，那么用 awk 就太赞了，可轻松对几百万甚至几千万行数据进行处理，秒级别出结果。

### 1.3 练习环境

本文所有命令演示，基于该数据，一共 13 行，实际上单机处理几百万上千万文本是没有问题的，这里仅为方便演示。

```
学校,sex,age,city
北大,男,20,北京
北大,男,21,北京
北大,男,20,北京
北大,男,21,北京
北大,男,20,北京
南大,男,21,北京
南大,女,20,上海
南大,女,21,上海
南大,女,20,上海
南大,女,21,上海
南大,女,20,上海
南大,女,21,上海
```

## 02. 统计场景

awk 的好处是，直接对文本进行处理，不依赖数据库。下面列出常用数据处理的场景，分别写出 awk 和等效 sql，加深印象。

先简单介绍 awk 命令模式：

    awk '{正则 + 处理逻辑}' ' 文件名 '

举个例子：

    awk -F ',' '/北京/{print $0}' 0101userprofile.csv

### 2.1 列选择

选择第 2，4 列：

```
# awk
awk -F',' '{print $2,$4}' userprofile.csv

# sql
select sex, city from user_table
```

### 2.2 行选择

选择 2-5 行

```
# awk
awk -F',' 'NR>=2 && NR<=5 {print $0}' userprofile.csv

# sql
select * from user_table limit 1,5
```

### 2.3 汇总：sum,count

city=' 北京 ' 的行：

```
# awk
awk -F',' '$4=="北京"{a+=1} END {print a}' userprofile.csv

# sql
select count (*) from user_table where city=' 北京 '
```

男生年龄总和：

```
# awk
awk -F',' '$2=="男"{a+=$3} END {print a}' userprofile.csv

# sql
select sum (age) from user_table where sex=' 男 '
```

### 2.4 group by 汇总：sum,count

按性别分组，计算各组人数和年龄平均值：

```
# awk
awk -F',' '{a [$2]+=1;b [$2]+=$3} END {for (i in a) print i, "人数:",a [i], "平均年龄:", b [i]/a [i]}' userprofile.csv

# sql
select sex, count (*) as `人数`, avg (age) from user_table group by sex
```

### 2.5 like 模糊匹配

按行匹配：把含有 ' 北京 ' 的行打印出来：

```
# awk


awk -F',' '/ 北京 /{print $0}' userprofile.csv

# sql: awk 是按正行匹配，sql 其实只能按字段进行匹配，这里反而 awk 方便些

select * from user_table where city=' 北京 '
```

按行匹配：把不含 '北京' 的行打印出来：

```
# awk
awk -F',' '!/ 北京 /{print $0}' userprofile.csv

# sql: awk 是按正行匹配，sql 其实只能按字段进行匹配，这里反而 awk 方便些
select * from user_table where city<>' 北京 '
```

按列匹配：把第 4 列含有 '北京' 的行打印出来：

```
# awk
awk -F',' '$4~/ 北京 /{print $0}' userprofile.csv

# sql
select * from user_table where city=' 北京 '
```
按列匹配：把第 4 列不含 '北京' 的行打印出来：

```
# awk
awk -F',' '$4!~/ 北京 /{print $0}' userprofile.csv

# sql
select * from user_table where city<>' 北京 '
```

以上是数据处理时 awk 最常用的一些命令，awk 功能强大，能做的事情不仅上面这点，比如处理多个文件，甚至达到类似 join 的效果，感兴趣的话可以 google 了解一下。

友情提示：awk 了解多一点，只怕你会爱上它。

