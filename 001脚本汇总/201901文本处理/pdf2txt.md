## 单个特定文件

```
# -*- coding:utf-8 -*-

import time,os.path,requests,re
time1=time.time()
from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.converter import PDFPageAggregator
from pdfminer.layout import LAParams,LTTextBoxHorizontal
from pdfminer.pdfpage import PDFTextExtractionNotAllowed,PDFPage
from pdfminer.pdfparser import PDFParser
from pdfminer.pdfdocument import PDFDocument

import modify as md

class CPdf2TxtManager():

    def changePdfToText(self, filePath):
        # 以二进制读模式打开
        file = open(path, 'rb')
        #用文件对象来创建一个pdf文档分析器
        praser = PDFParser(file)
        # 创建一个PDF文档对象存储文档结构,提供密码初始化，没有就不用传该参数
        doc = PDFDocument(praser, password='')
        ##检查文件是否允许文本提取
        if not doc.is_extractable:
            raise PDFTextExtractionNotAllowed

        # 创建PDf 资源管理器 来管理共享资源，#caching = False不缓存
        rsrcmgr = PDFResourceManager(caching = False)
        # 创建一个PDF设备对象
        laparams = LAParams()
        # 创建一个PDF页面聚合对象
        device = PDFPageAggregator(rsrcmgr, laparams=laparams)
        # 创建一个PDF解析器对象
        interpreter = PDFPageInterpreter(rsrcmgr, device)
        # 获得文档的目录（纲要）,文档没有纲要会报错
        #PDF文档没有目录时会报：raise PDFNoOutlines  pdfminer.pdfdocument.PDFNoOutlines
        # print(doc.get_outlines())

        # 获取page列表
        print(PDFPage.get_pages(doc))
        # 循环遍历列表，每次处理一个page的内容
        for page in PDFPage.create_pages(doc):
            interpreter.process_page(page)
            # 接受该页面的LTPage对象
            layout = device.get_result()
            # 这里layout是一个LTPage对象 里面存放着 这个page解析出的各种对象
            # 一般包括LTTextBox, LTFigure, LTImage, LTTextBoxHorizontal 等等
            for x in layout:
                if hasattr(x, "get_text"):
                    fileNames = os.path.splitext(filePath)
                    with open(fileNames[0] + '.txt','a+') as f:
                        results = x.get_text()
                        results = md.modify_text(results)
                        # print(results)
                        f.write(results + '\n\n')
                # 如果x是水平文本对象的话
                # if (isinstance(x, LTTextBoxHorizontal)):
                #     text = re.sub(replace, '', x.get_text())
                #     if len(text) != 0:
                #         print(text)

if __name__ == '__main__':
    pdfname = input('Please Entert the Name of PDF: ')
    path = '/Users/Daglas/Desktop/' + pdfname + '.pdf'
    pdf2TxtManager = CPdf2TxtManager()
    pdf2TxtManager.changePdfToText(path)
    time2 = time.time()
    print('OK!')
    print('Time Used: ' + str(time2 - time1) + 's')
```

## 批量转化

```
# -*- coding:utf-8 -*-

import time, os.path, requests, re, glob
time1=time.time()
from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.converter import PDFPageAggregator
from pdfminer.layout import LAParams,LTTextBoxHorizontal
from pdfminer.pdfpage import PDFTextExtractionNotAllowed,PDFPage
from pdfminer.pdfparser import PDFParser
from pdfminer.pdfdocument import PDFDocument

import modify as md

class CPdf2TxtManager():

    def changePdfToText(self, filePath):
        # 以二进制读模式打开
        file = open(path, 'rb')
        #用文件对象来创建一个pdf文档分析器
        praser = PDFParser(file)
        # 创建一个PDF文档对象存储文档结构,提供密码初始化，没有就不用传该参数
        doc = PDFDocument(praser, password='')
        ##检查文件是否允许文本提取
        if not doc.is_extractable:
            raise PDFTextExtractionNotAllowed

        # 创建PDf 资源管理器 来管理共享资源，#caching = False不缓存
        rsrcmgr = PDFResourceManager(caching = False)
        # 创建一个PDF设备对象
        laparams = LAParams()
        # 创建一个PDF页面聚合对象
        device = PDFPageAggregator(rsrcmgr, laparams=laparams)
        # 创建一个PDF解析器对象
        interpreter = PDFPageInterpreter(rsrcmgr, device)
        # 获得文档的目录（纲要）,文档没有纲要会报错
        #PDF文档没有目录时会报：raise PDFNoOutlines  pdfminer.pdfdocument.PDFNoOutlines
        # print(doc.get_outlines())

        # 获取page列表
        print(PDFPage.get_pages(doc))
        # 循环遍历列表，每次处理一个page的内容
        for page in PDFPage.create_pages(doc):
            interpreter.process_page(page)
            # 接受该页面的LTPage对象
            layout = device.get_result()
            # 这里layout是一个LTPage对象 里面存放着 这个page解析出的各种对象
            # 一般包括LTTextBox, LTFigure, LTImage, LTTextBoxHorizontal 等等
            for x in layout:
                if hasattr(x, "get_text"):
                    fileNames = os.path.splitext(filePath)
                    with open(fileNames[0] + '.txt','a+') as f:
                        results = x.get_text()
                        results = md.modify_text(results)
                        # print(results)
                        f.write(results + '\n\n')
                # 如果x是水平文本对象的话
                # if (isinstance(x, LTTextBoxHorizontal)):
                #     text = re.sub(replace, '', x.get_text())
                #     if len(text) != 0:
                #         print(text)

# 获得桌上所有 md 文件名并对其进行分割，然后在 for 循环里进行处理
for infile in glob.glob("/Users/Daglas/Desktop/*.pdf"):
    filename, ext = os.path.splitext(infile)

    if __name__ == '__main__':
        path = filename + '.pdf'
        pdf2TxtManager = CPdf2TxtManager()
        pdf2TxtManager.changePdfToText(path)
        time2 = time.time()
        print('OK!')
        print('Time Used: ' + str(time2 - time1) + 's')    
```




