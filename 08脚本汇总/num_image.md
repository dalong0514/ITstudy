# num_image

## 01. num_png

```

import glob, os

from PIL import Image

# 手动获取需要设置的宽度像素
init_num = int(input("Please enter the init number: "))
user_input = input("Please enter the image's width, or no: ")

if user_input != 'no':
    user_width = int(user_input)
# else:
#     user_width = 800

all_files = glob.glob("/Users/Daglas/Desktop/*.png")

# 获取该文件夹下所有特定文件的所有对象并分隔开来
for infile in sorted(all_files):
    file, ext = os.path.splitext(infile)
    im = Image.open(infile)

    # 只对宽度像素大于给定值的图片进行处理
    if user_input != 'no' and im.width > user_width:
        new_size = int(user_width), int(user_width*(im.height/im.width))
        im = im.resize(new_size)
        im.save("/Users/Daglas/Desktop/" + str(init_num) + ".png")
    else:
        im.save("/Users/Daglas/Desktop/" + str(init_num) + ".png")

    init_num += 1

```

## 01. num_image

```

import glob, os

from PIL import Image

# 手动获取需要设置的宽度像素
init_num = int(input("Please enter the init number: "))

# 手动获取图片的格式
image_format = input("Please enter the image's format(jpg/jpeg/png-default): ")

if image_format == 'jpeg' or image_format == 'jpg':
    im_format =image_format
else:
    im_format = 'png'

user_input = input("Please enter the image's width, or no: ")

if user_input != 'no':
    user_width = int(user_input)
# else:
#     user_width = 800

all_files = glob.glob("/Users/Daglas/Desktop/*." + im_format)

# 获取该文件夹下所有特定文件的所有对象并分隔开来
for infile in sorted(all_files):
    file, ext = os.path.splitext(infile)
    im = Image.open(infile)

    # 只对宽度像素大于给定值的图片进行处理
    if user_input != 'no' and im.width > user_width:
        new_size = int(user_width), int(user_width*(im.height/im.width))
        im = im.resize(new_size)
        im.save("/Users/Daglas/Desktop/" + str(init_num) + "." + im_format)
    else:
        im.save("/Users/Daglas/Desktop/" + str(init_num) + "." + im_format)

    init_num += 1

```