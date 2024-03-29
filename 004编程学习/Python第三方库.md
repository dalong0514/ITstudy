## 第三方库

[jobbole/awesome-python-cn: Python资源大全中文版，包括：Web框架、网络爬虫、模板引擎、数据库、数据可视化、图片处理等，由伯乐在线持续更新。](https://github.com/jobbole/awesome-python-cn)

### 01. Scrapy

[scrapy/scrapy: Scrapy, a fast high-level web crawling & scraping framework for Python.](https://github.com/scrapy/scrapy)

[Scrapy 1.8 documentation — Scrapy 1.8.0 documentation](https://docs.scrapy.org/en/latest/)

### 02. Numpy

### 03. Pygal

### 04. Matplotlib

### 05. pangu

[pangu · PyPI](https://pypi.org/project/pangu/)

[vinta/pangu.py: Paranoid text spacing in Python](https://github.com/vinta/pangu.py)

功能：在中日韩语字符和数字字母之间添加空格。

这个库可以帮忙在数字之间加空格，自己很需要。

pip3 安装后发现 import 不了。但后来发现先建个虚拟环境，再安装的话就可以 import，目前还没弄明白是什么原理。类似的，其他第三方库 import 不了的话应该也可以通过这个方法解决。

在当前的目录（zancun）下建个虚拟环境：

	zancun$ python3 -m venv ll_env

接着激活该虚拟环境：

	zancun$ source ll_env/bin/activate

然后安装模块：

	pip3 install pangu

安装后就可以 import 了，退出虚拟环境的话直接命令：

	deactivate

### 06. PDFMiner

[PDFMiner](https://euske.github.io/pdfminer/)

[euske/pdfminer: Python PDF Parser](https://github.com/euske/pdfminer)

[python](http://news.zhiwu55.com/it/dGFnLzhiZTQ0OTIzMTBjYWFhZTYwNjhkMzMxZjE4OTVjN2U0Lmh0bWw=.html)

直接在 shell 里输入命令：

	pdf2txt.py -o 201901.txt 201901.pdf

即可把 201901.pdf 文件提取到 201901.txt 里。

### 07. pdfminer.six

[pdfminer/pdfminer.six: Python PDF Parser -- fork with Python 2+3 support using six](https://github.com/pdfminer/pdfminer.six)

[Welcome to pdfminer.six’s documentation! — pdfminer.six 20191020 documentation](https://pdfminersix.readthedocs.io/en/latest/)

[Getting started — pdfminer.six 20191020 documentation](https://pdfminersix.readthedocs.io/en/latest/tutorials/index.html)

[python提取pdf文本内容 - 云+社区 - 腾讯云](https://cloud.tencent.com/developer/article/1406532)

### 08. Pillow

[Pillow — Pillow (PIL Fork) 7.0.0.dev0 documentation](https://pillow.readthedocs.io/en/latest/)

[Pillow/index.rst at master · python-pillow/Pillow](https://github.com/python-pillow/Pillow/blob/master/docs/index.rst)

### 09. python-docx

[python-docx — python-docx 0.8.10 documentation](https://python-docx.readthedocs.io/en/latest/)

	pip install python-docx

### 10. openpyxl

[openpyxl - A Python library to read/write Excel 2010 xlsx/xlsm files — openpyxl 3.0.3 documentation](https://openpyxl.readthedocs.io/en/latest/)

[Python Module Index — openpyxl 3.0.3 documentation](https://openpyxl.readthedocs.io/en/stable/py-modindex.html)

[openpyxl.workbook.workbook module — openpyxl 3.0.3 documentation](https://openpyxl.readthedocs.io/en/stable/api/openpyxl.workbook.workbook.html)

[Working with Pandas and NumPy — openpyxl 3.0.3 documentation](https://openpyxl.readthedocs.io/en/stable/pandas.html)

[python修改已存在的xlsx件--OpenPyXL_ChenLeihappy的博客-CSDN博客](https://blog.csdn.net/ChenLeihappy/article/details/80989552)

### 11. pytube

下载 YouTube 视频的包。

[pytube/pytube: A lightweight, dependency-free Python library (and command-line utility) for downloading YouTube Videos.](https://github.com/pytube/pytube)

