# split_file



## 01. 分割 txt

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