[Office 365 培训中心 - Office 支持](https://support.office.com/zh-cn/office-training-center?ms.officeurl=training)

[Excel 帮助 - Office 支持](https://support.office.com/zh-CN/excel)

[公式和函数 - Excel](https://support.office.com/zh-cn/article/%e5%85%ac%e5%bc%8f%e5%92%8c%e5%87%bd%e6%95%b0-294d9486-b332-48ed-b489-abe7d0f9eda9?ui=zh-CN&rs=zh-CN&ad=CN)

## 01. 问题收集

1、2010 版本之后打印打到文件。

打印机选项下拉，最好一栏「打印的文件」打勾。

## 02. 常用命令

1、重复上一次操作 F4。

## 03. 操作收集

### 1. 连接字符串

[CONCATENATE 函数 - Office 支持](https://support.office.com/zh-cn/article/concatenate-%E5%87%BD%E6%95%B0-8f8ae884-2ca8-4f7a-b093-75d702bea31d)

使用 CONCATENATE（其中一个文本函数）将两个或多个文本字符串联接为一个字符串。

重要: 在 Excel 2016、Excel Mobile 和 Excel 网页版中, 此函数已替换为 CONCAT 函数。 尽管 CONCATENATE 函数仍可向后兼容，但应考虑从现在开始使用 CONCAT。 这是因为 CONCATENATE 可能不再适用将来的 Excel 版本。

语法：

```
CONCATENATE(text1, [text2], ...)
```

例如：

```
=CONCATENATE("Stream population for ", A2, " ", A3, " is ", A4, "/mile")

=CONCATENATE(B2, " ", C2)
```

与号 (&) 计算运算符允许你在不使用函数的情况下联接文本项目。例如, = A1 & B1 返回与 = 连接 (A1, B1) 相同的值。 在许多情况下，使用与号比使用 CONCATENATE 创建字符串的速度更快，更简单。

2、VLOOKUP 匹配值。

[如何在 Excel 中使用VLOOKUP函数？](https://zh-cn.extendoffice.com/excel/functions/excel-vlookup-function.html)

场景：

有两列一一对应的数据集，好比 key-value 值。要在 Excel 里通过 key 来找 value 值。

叶旭峰：流程题仪表位号自动编号后，仪表专业又自己重新编了号，老号没删。根据新号、老号的对应关系，把修改后的新号同步到流程图。

宗源：排设备方案，开始自己编好了设备位号，业主把设备位号修改了很多（Excel 表里），目前有新号、老号的对应关系，把修改后的新号同步到布置图。

```
=VLOOKUP(E2,B2:C252,2,FALSE)
```

B2:C252 是 key-value 2 列数据集的范围，E2 是要查询的一个 key 值的 Excel 单元格，2 值数据集的范围内 value 属于第几列，FALSE 表示精准匹配，TRUE 表示近似匹配。