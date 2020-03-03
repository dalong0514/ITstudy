# split_file

分割书籍。

## 01. 分割 txt

### 1. 等份分割

代码如下：

```
import glob, os
import math

import pangu

# split the arr into N chunks
def chunks(arr, m):
    n = int(math.ceil(len(arr) / float(m)))
    return [arr[i:i + n] for i in range(0, len(arr), n)]

# 获得桌上所有 md 文件名并对其进行分割，然后在 for 循环里进行处理
for infile in glob.glob("/Users/Daglas/Desktop/*.txt"):
    filename, ext = os.path.splitext(infile)

    # 读取文件
    with open(filename + ".txt") as file_obj:
            lines = file_obj.readlines()

    # 对文字处理并写入文件
    with open(filename + ".txt", 'w') as file_obj:
        for line in lines:
            if line != '\n':
                new_content = pangu.spacing_text(line)
                new_content = new_content.replace('“', '「')
                new_content = new_content.replace('”', '」')
                new_content = new_content.replace('・', '·')
                new_content = new_content.replace('， ', '，')
                new_content = new_content.replace('。 ', '。')
                file_obj.write(new_content + '\n\n')

    print(len(lines))

    num_split = 3

    # 读取文件
    with open(filename + ".txt") as file_obj:
            lines = file_obj.readlines()

    n = 1

    for chunk in chunks(lines, num_split):
        with open(filename + str(n) + ".txt", 'w') as file_obj:
            for line in chunk:
                if line != '\n':
                    file_obj.write(line + '\n')
        n += 1
        
``` 

自动排序版：

```
import glob, os
import math

import modify as md

# split the arr into N chunks
def chunks(arr, m):
    n = int(math.ceil(len(arr) / float(m)))
    return [arr[i:i + n] for i in range(0, len(arr), n)]

num_split = input("Please enter the num_split: ")

# 获得桌上所有 md 文件名并对其进行分割，然后在 for 循环里进行处理
for infile in glob.glob("/Users/Daglas/Desktop/*.txt"):
    filename, ext = os.path.splitext(infile)

    # 读取文件
    with open(filename + ".txt") as file_obj:
            lines = file_obj.readlines()

    # 对文字处理并写入文件
    with open(filename + ".txt", 'w') as file_obj:
        for line in lines:
            if line != '\n':
                new_content = md.modify_text(line)
                file_obj.write(new_content + '\n\n')

    print(len(lines))

    # 读取文件
    with open(filename + ".txt") as file_obj:
            lines = file_obj.readlines()

    n1 = 101
    n2 = 1001

    for chunk in chunks(lines, num_split):
        if n1 < 1000:
            with open(filename + "0" + str(n1-100) + ".md", 'w') as file_obj:
                for line in chunk:
                    if line != '\n':
                        file_obj.write(line + '\n')
            n1 += 100

        else:
            with open(filename + str(n2-100) + ".md", 'w') as file_obj:
                for line in chunk:
                    if line != '\n':
                        file_obj.write(line + '\n')
                n2 += 100
```

### 2. 特定字符分割

一定要确认传入的锚点字符在文档里是唯一的，可以直接在文档里搜索来确。

```
import glob, os
import math

import pandas as pd

import modify as md

# 按传入的每章「锚点」切割行
def chunks(arr, in_list):
    seq = [0]
    tips = []

    for x in in_list:
        l_temp = [arr.index(v) for v in arr if x in v]
        seq.append(l_temp[0])

    for v in seq:
        if seq.index(v) < len(seq) - 1:
            tips.append(arr[v:seq[seq.index(v)+1]])
    
    tips.append(arr[seq[-1]:])
    return tips

# 获得桌上所有 md 文件名并对其进行分割，然后在 for 循环里进行处理
for infile in glob.glob("/Users/Daglas/Desktop/*.txt"):
    filename, ext = os.path.splitext(infile)

    # 读取文件
    with open(filename + ".txt") as file_obj:
            lines = file_obj.readlines()

    # 对文字处理并写入文件
    with open(filename + ".txt", 'w') as file_obj:
        for line in lines:
            if line != '\n':
                new_content = md.modify_text(line)
                file_obj.write(new_content + '\n\n')

    print(len(lines))

    # 读取文件
    with open(filename + ".txt") as file_obj:
            lines = file_obj.readlines()

    xlsx = pd.ExcelFile('readsplit.xlsx')
    ls = pd.read_excel(xlsx, 'Sheet1')
    spdots = ls['dot'].values

    n1 = 101
    n2 = 1001

    for chunk in chunks(lines, spdots):
        if n1 < 1000:
            with open(filename + "0" + str(n1-100) + ".md", 'w') as file_obj:
                for line in chunk:
                    if line != '\n':
                        file_obj.write(line + '\n')
            n1 += 100

        else:
            with open(filename + str(n2-100) + ".md", 'w') as file_obj:
                for line in chunk:
                    if line != '\n':
                        file_obj.write(line + '\n')
                n2 += 100
```

chunks() 函数变更一下：

```
# 按传入的每章「锚点」切割行
def chunks(arr, in_list):
    seq = [0]
    tips = []

    for v in in_list:
        for x in arr:
            if v in x:
                seq.append(arr.index(x)-2)  # 由于定位的行前面还有个空行，所以 -2

    for v in seq:
        if seq.index(v) < len(seq) - 1:
            tips.append(arr[v:seq[seq.index(v)+1]])
    
    tips.append(arr[seq[-1]:])
    return tips
```



