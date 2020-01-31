# doxc_modify

[python-docx — python-docx 0.8.10 documentation](https://python-docx.readthedocs.io/en/latest/)

## 01


```

import glob, os

import pangu
from docx import Document

# 获得桌上所有 md 文件名并对其进行分割，然后在 for 循环里进行处理
for infile in glob.glob("/Users/Daglas/Desktop/*.docx"):
    filename, ext = os.path.splitext(infile)

    document = Document(filename + ".docx")
    # document.save('new-file-name.txt')

    # for para in document.paragraphs:
    #     print(para.text)

    # 对文字处理并写入文件
    with open(filename + ".md", 'w') as file_obj:
        for para in document.paragraphs:
            if para.text != '\n':
                file_obj.write(para.text + "\n\n")

    # 读取文件，文件名「filename + ".md"」是关键
    with open(filename + ".md") as file_obj:
        lines = file_obj.readlines()

    with open(filename + ".md", 'w') as file_obj:
        for line in lines:
            if line != '\n':
                new_content = pangu.spacing_text(line)
                new_content = new_content.replace(' “', '“')
                new_content = new_content.replace('” ', '”')
                new_content = new_content.replace('“', '「')
                new_content = new_content.replace('”', '」')
                new_content = new_content.replace('・', '·')
                new_content = new_content.replace('， ', '，')
                new_content = new_content.replace('。 ', '。')
                file_obj.write(new_content + "\n\n")

```

