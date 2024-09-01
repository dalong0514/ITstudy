### 资源

[CosmosShadow/gptpdf: Using GPT to parse PDF](https://github.com/CosmosShadow/gptpdf?tab=readme-ov-file)

[daodao97/gptpdf-ui: Using GPT to parse PDF](https://github.com/daodao97/gptpdf-ui)

### 部署记录

跑服务：

python gptpdf2txt.py

1、安装依赖包。

pip install gptpdf

2、代码。

import time
from gptpdf import parse_pdf
import api_key as api

api_key = api.openai_api_key()
out_filename = '/Users/Daglas/Desktop/gpt_pdf'
pdf_path = '/Users/Daglas/Dropbox/zotero/storage/4VEHQZ9S/Vaswani et al_2023_Attention Is All You Need.pdf'

def gpt_pdf2txt():
    content, image_paths = parse_pdf(pdf_path, 
                                     output_dir=out_filename, 
                                     model="gpt-4o",
                                     api_key=api_key)
    print(content)

### 问题汇总

1、import 不了 gptpdf 包。

找了很久的原因，最后定位到是因为 llama 虚拟环境之前装了太多的包，某些包（fitz）的版本与 gptpdf 冲突了。

fitz-0.0.1.dev2

解决方法：在一个新的虚拟环境里装 gptpdf 跑。

补充：目前是放在虚拟环境 kaizhi 里的。