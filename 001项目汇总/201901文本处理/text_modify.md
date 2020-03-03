# text_modify

要用到第三方库 pangu

## 01. 单个文件的处理

```

import pangu

# 通过输入来定位需要处理的文件
# filename = "/Users/Daglas/Desktop/2019.md"
filename = "/Users/Daglas/Desktop/" + input("Please enter the filename: ")

# 打开文件的操作
with open(filename) as f:
    #contents = file_object.read()
    lines = f.readlines()

# 修改文件的操作
with open(filename, 'w') as file_object:
    for line in lines:
        if line != '\n':
            new_content = pangu.spacing_text(line)
            new_content = new_content.replace('“', '「')
            new_content = new_content.replace('”', '」')
            new_content = new_content.replace('・', '·')
            new_content = new_content.replace('， ', '，')
            new_content = new_content.replace('。 ', '。')
            file_object.write(new_content + '\n\n')
     
```

## 02. 多个文件的处理

最最关键的信息是，在批量处理图片时看到，如何把一个文件夹里的特定文件抓取出来，分割成一个个实体。

[Image Module — Pillow (PIL Fork) 7.0.0.dev0 documentation](https://pillow.readthedocs.io/en/latest/reference/Image.html#functions)

获得灵感的代码：

```

from PIL import Image
import glob, os

size = 128, 128

for infile in glob.glob("*.jpg"):
    file, ext = os.path.splitext(infile)
    im = Image.open(infile)
    im.thumbnail(size)
    im.save(file + ".thumbnail", "JPEG")

```

批量处理的脚本如下：

```

import glob, os

import pangu

# 获得桌上所有 md 文件名并对其进行分割，然后在 for 循环里进行处理
for infile in glob.glob("/Users/Daglas/Desktop/*.md"):
    filename, ext = os.path.splitext(infile)

    # 读取文件，文件名「filename + ".md"」是关键
    with open(filename + ".md") as file_obj:
        lines = file_obj.readlines()

    # 对文字处理并写入文件
    with open(filename + ".md", 'w') as file_obj:
        for line in lines:
            if line != '\n':
                new_content = pangu.spacing_text(line)
                new_content = new_content.replace('“', '「')
                new_content = new_content.replace('”', '」')
                new_content = new_content.replace('・', '·')
                new_content = new_content.replace('， ', '，')
                new_content = new_content.replace('。 ', '。')
                file_obj.write(new_content + '\n\n')

```






