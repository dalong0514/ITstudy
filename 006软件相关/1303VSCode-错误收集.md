# 0102. 错误收集

## 01

	syntaxerror non-ascii character ' xe5' in file ......

上述报错是由于编码格式不匹配导致程序不能识别程序中的中文导致的。Python 2 默认的编码格式是 ASCII，Python 3 默认的编码格式是 UTF-8。因此，如果我们使用 Python 2 运行的 Python 程序中出现了中文，就需要指定编码格式为 UTF-8（如果使用的是 Python 3 则不需要指定）。

解决办法：

1）在Python脚本的开头加上：

	#coding=utf-8

2）或者加上：

	# -*- coding: UTF-8 -*-

由此可以看出来，目前 VS code 里默认的还是 python2.x。可以文件的最开始制定解释器：

	#!/usr/local/bin/python3

## 02

