# image_modify

需要用到第三方库 pillow。

[Image Module — Pillow (PIL Fork) 7.0.0.dev0 documentation](https://pillow.readthedocs.io/en/latest/reference/Image.html#functions)

获取图片尺寸像素的代码：

```

from PIL import Image

im = Image.open('001.png')

# 获取图片的尺寸
size_value = im.size

```

## 01. 缩放图片的尺寸

### 1. 单个文件的处理

```

from PIL import Image

user_width = int(input("Please enter the image's width: "))

new_size = int(user_width), int(user_width*(im.height/im.width))
new_im = im.resize(new_size)
new_im.save('002.png')

```

### 2. 多个文件的批量处理

```

import glob, os

from PIL import Image

user_width = int(input("Please enter the image's width: "))

for infile in glob.glob("*.png"):
    file, ext = os.path.splitext(infile)
    im = Image.open(infile)
    new_size = int(user_width), int(user_width*(im.height/im.width))
    im = im.resize(new_size)
    im.save(file + ".png")

```

附加条件的处理，比如宽度像素大于多少才修改：

```
import glob, os

from PIL import Image

# 手动获取需要设置的宽度像素
user_width = int(input("Please enter the image's width: "))

# 获取该文件夹下所有特定文件的所有对象并分隔开来
for infile in glob.glob("/Users/Daglas/Desktop/*.png"):
    file, ext = os.path.splitext(infile)
    im = Image.open(infile)

    # 只对宽度像素大于给定值的图片进行处理
    if im.width > user_width:
        new_size = int(user_width), int(user_width*(im.height/im.width))
        im = im.resize(new_size)
        im.save(file + ".png")
        
```