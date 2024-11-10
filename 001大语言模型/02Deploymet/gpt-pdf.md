### 资源

[CosmosShadow/gptpdf: Using GPT to parse PDF](https://github.com/CosmosShadow/gptpdf?tab=readme-ov-file)

[daodao97/gptpdf-ui: Using GPT to parse PDF](https://github.com/daodao97/gptpdf-ui)

### 跑服务

切换到虚拟环境 kaizhi。

python3.10 gptpdf2txt.py

python3.10 qwen_gptpdf2txt.py

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

2、本地 api 接口地址报错无效。

ValueError: LLM(Large Languate Model) error, Please check your key or base_url, or network
2024-11-08 08:47:36,104 - INFO - gpt parse page: 1
2024-11-08 08:47:36,808 - INFO - HTTP Request: POST https://76b3-117-147-119-165.ngrok-free.app/v1/chat/completions "HTTP/1.1 404 Not Found"
2024-11-08 08:47:36,808 - ERROR - Tunnel 76b3-117-147-119-165.ngrok-free.app not found

解决方法：把链接（https://76b3-117-147-119-165.ngrok-free.app）输入到浏览器里回车，类似于手动通下路，然后再跑。