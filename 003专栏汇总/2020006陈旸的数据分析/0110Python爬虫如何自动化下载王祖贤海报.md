# 0110Python 爬虫：如何自动化下载王祖贤海报？

陈旸 2019-01-04




08:39


讲述：陈旸 大小：7.93M

上一讲中我给你讲了如何使用八爪鱼采集数据，对于数据采集刚刚入门的人来说，像八爪鱼这种可视化的采集是一种非常好的方式。它最大的优点就是上手速度快，当然也存在一些问题，比如运行速度慢、可控性差等。

相比之下，爬虫可以很好地避免这些问题，今天我来分享下如何通过编写爬虫抓取数据。

爬虫的流程

相信你对「爬虫」这个词已经非常熟悉了，爬虫实际上是用浏览器访问的方式模拟了访问网站的过程，整个过程包括三个阶段：打开网页、提取数据和保存数据。

在 Python 中，这三个阶段都有对应的工具可以使用。

在「打开网页」这一步骤中，可以使用 Requests 访问页面，得到服务器返回给我们的数据，这里包括 HTML 页面以及 JSON 数据。

在「提取数据」这一步骤中，主要用到了两个工具。针对 HTML 页面，可以使用 XPath 进行元素定位，提取数据；针对 JSON 数据，可以使用 JSON 进行解析。

在最后一步「保存数据」中，我们可以使用 Pandas 保存数据，最后导出 CSV 文件。

下面我来分别介绍下这些工具的使用。

Requests 访问页面

Requests 是 Python HTTP 的客户端库，编写爬虫的时候都会用到，编写起来也很简单。它有两种访问方式：Get 和 Post。这两者最直观的区别就是：Get 把参数包含在 url 中，而 Post 通过 request body 来传递参数。

假设我们想访问豆瓣，那么用 Get 访问的话，代码可以写成下面这样的：

r = requests.get('http://www.douban.com')


代码里的「r」就是 Get 请求后的访问结果，然后我们可以使用 r.text 或 r.content 来获取 HTML 的正文。

如果我们想要使用 Post 进行表单传递，代码就可以这样写：

r = requests.post('http://xxx.com', data = {'key':'value'})


这里 data 就是传递的表单参数，data 的数据类型是个字典的结构，采用 key 和 value 的方式进行存储。

XPath 定位

XPath 是 XML 的路径语言，实际上是通过元素和属性进行导航，帮我们定位位置。它有几种常用的路径表达方式。

我来给你简单举一些例子：

xpath (‘node’) 选取了 node 节点的所有子节点；

xpath (’/div’) 从根节点上选取 div 节点；

xpath (’//div’) 选取所有的 div 节点；

xpath (’./div’) 选取当前节点下的 div 节点；

xpath (’…’) 回到上一个节点；

xpath (’//@id’) 选取所有的 id 属性；

xpath (’//book [@id]’) 选取所有拥有名为 id 的属性的 book 元素；

xpath (’//book [@id=「abc」]’) 选取所有 book 元素，且这些 book 元素拥有 id= "abc" 的属性；

xpath (’//book/title | //book/price’) 选取 book 元素的所有 title 和 price 元素。

上面我只是列举了 XPath 的部分应用，XPath 的选择功能非常强大，它可以提供超过 100 个内建函数，来做匹配。我们想要定位的节点，几乎都可以使用 XPath 来选择。

使用 XPath 定位，你会用到 Python 的一个解析库 lxml。这个库的解析效率非常高，使用起来也很简便，只需要调用 HTML 解析命令即可，然后再对 HTML 进行 XPath 函数的调用。

比如我们想要定位到 HTML 中的所有列表项目，可以采用下面这段代码。

from lxml import etree


html = etree.HTML(html)


result = html.xpath('//li')


JSON 对象

JSON 是一种轻量级的交互方式，在 Python 中有 JSON 库，可以让我们将 Python 对象和 JSON 对象进行转换。为什么要转换呢？原因也很简单。将 JSON 对象转换成为 Python 对象，我们对数据进行解析就更方便了。

这是一段将 JSON 格式转换成 Python 对象的代码，你可以自己运行下这个程序的结果。

import json


jsonData = '{"a":1,"b":2,"c":3,"d":4,"e":5}';


input = json.loads(jsonData)


print input


接下来，我们就要进行实战了，我会从两个角度给你讲解如何使用 Python 爬取海报，一个是通过 JSON 数据爬取，一个是通过 XPath 定位爬取。

如何使用 JSON 数据自动下载王祖贤的海报

我在上面讲了 Python 爬虫的基本原理和实现的工具，下面我们来实战一下。如果想要从豆瓣图片中下载王祖贤的海报，你应该先把我们日常的操作步骤整理下来：

打开网页；

输入关键词「王祖贤」；

在搜索结果页中选择「图片」；

下载图片页中的所有海报。

这里你需要注意的是，如果爬取的页面是动态页面，就需要关注 XHR 数据。因为动态页面的原理就是通过原生的 XHR 数据对象发出 HTTP 请求，得到服务器返回的数据后，再进行处理。XHR 会用于在后台与服务器交换数据。

你需要使用浏览器的插件查看 XHR 数据，比如在 Chrome 浏览器中使用开发者工具。

在豆瓣搜索中，我们对「王祖贤」进行了模拟，发现 XHR 数据中有一个请求是这样的：

https://www.douban.com/j/search_photo?q=%E7%8E%8B%E7%A5%96%E8%B4%A4&limit=20&start=0


url 中的乱码正是中文的 url 编码，打开后，我们看到了很清爽的 JSON 格式对象，展示的形式是这样的：

{"images":


       [{"src": …, "author": …, "url":…, "id": …, "title": …, "width":…, "height":…},


    …


   {"src": …, "author": …, "url":…, "id": …, "title": …, "width":…, "height":…}],


 "total":22471,"limit":20,"more":true}


从这个 JSON 对象中，我们能看到，王祖贤的图片一共有 22471 张，其中一次只返回了 20 张，还有更多的数据可以请求。数据被放到了 images 对象里，它是个数组的结构，每个数组的元素是个字典的类型，分别告诉了 src、author、url、id、title、width 和 height 字段，这些字段代表的含义分别是原图片的地址、作者、发布地址、图片 ID、标题、图片宽度、图片高度等信息。

有了这个 JSON 信息，你很容易就可以把图片下载下来。当然你还需要寻找 XHR 请求的 url 规律。

如何查看呢，我们再来重新看下这个网址本身。

https://www.douban.com/j/search_photo?q= 王祖贤 &limit=20&start=0

你会发现，网址中有三个参数：q、limit 和 start。start 实际上是请求的起始 ID，这里我们注意到它对图片的顺序标识是从 0 开始计算的。所以如果你想要从第 21 个图片进行下载，你可以将 start 设置为 20。

王祖贤的图片一共有 22471 张，你可以写个 for 循环来跑完所有的请求，具体的代码如下：

# coding:utf-8


import requests


import json


query = ' 王祖贤 '

''' 下载图片 '''

def download(src, id):


  dir = './' + str(id) + '.jpg'


  try:


    pic = requests.get(src, timeout=10)


    fp = open(dir, 'wb')


    fp.write(pic.content)


    fp.close()


  except requests.exceptions.ConnectionError:


print (' 图片无法下载 ')

            


''' for 循环 请求全部的 url '''

for i in range(0, 22471, 20):


  url = 'https://www.douban.com/j/search_photo?q='+query+'&limit=20&start='+str(i)


html = requests.get (url).text    # 得到返回结果

response = json.loads (html,encoding='utf-8') # 将 JSON 格式转换成 Python 对象

  for image in response['images']:


print (image ['src']) # 查看当前下载的图片网址

download (image ['src'], image ['id']) # 下载一张图片

如何使用 XPath 自动下载王祖贤的电影海报封面

如果你遇到 JSON 的数据格式，那么恭喜你，数据结构很清爽，通过 Python 的 JSON 库就可以解析。

但有时候，网页会用 JS 请求数据，那么只有 JS 都加载完之后，我们才能获取完整的 HTML 文件。XPath 可以不受加载的限制，帮我们定位想要的元素。

比如，我们想要从豆瓣电影上下载王祖贤的电影封面，需要先梳理下人工的操作流程：

打开网页 movie.douban.com；

输入关键词「王祖贤」；

下载图片页中的所有电影封面。

这里你需要用 XPath 定位图片的网址，以及电影的名称。

一个快速定位 XPath 的方法就是采用浏览器的 XPath Helper 插件，使用 Ctrl+Shift+X 快捷键的时候，用鼠标选中你想要定位的元素，就会得到类似下面的结果。

XPath Helper 插件中有两个参数，一个是 Query，另一个是 Results。Query 其实就是让你来输入 XPath 语法，然后在 Results 里看到匹配的元素的结果。

我们看到，这里选中的是一个元素，我们要匹配上所有的电影海报，就需要缩减 XPath 表达式。你可以在 Query 中进行 XPath 表达式的缩减，尝试去掉 XPath 表达式中的一些内容，在 Results 中会自动出现匹配的结果。

经过缩减之后，你可以得到电影海报的 XPath（假设为变量 src_xpath）：

//div[@class='item-root']/a[@class='cover-link']/img[@class='cover']/@src


以及电影名称的 XPath（假设为变量 title_xpath）：

//div[@class='item-root']/div[@class='detail']/div[@class='title']/a[@class='title-text']


但有时候当我们直接用 Requests 获取 HTML 的时候，发现想要的 XPath 并不存在。这是因为 HTML 还没有加载完，因此你需要一个工具，来进行网页加载的模拟，直到完成加载后再给你完整的 HTML。

在 Python 中，这个工具就是 Selenium 库，使用方法如下：

from selenium import webdriver


driver = webdriver.Chrome()


driver.get(request_url)


Selenium 是 Web 应用的测试工具，可以直接运行在浏览器中，它的原理是模拟用户在进行操作，支持当前多种主流的浏览器。

这里我们模拟 Chrome 浏览器的页面访问。

你需要先引用 Selenium 中的 WebDriver 库。WebDriver 实际上就是 Selenium 2，是一种用于 Web 应用程序的自动测试工具，提供了一套友好的 API，方便我们进行操作。

然后通过 WebDriver 创建一个 Chrome 浏览器的 drive，再通过 drive 获取访问页面的完整 HTML。

当你获取到完整的 HTML 时，就可以对 HTML 中的 XPath 进行提取，在这里我们需要找到图片地址 srcs 和电影名称 titles。这里通过 XPath 语法匹配到了多个元素，因为是多个元素，所以我们需要用 for 循环来对每个元素进行提取。

srcs = html.xpath(src_xpath)


titles = html.xpath(title_path)


for src, title in zip(srcs, titles):


  download(src, title.text)


然后使用上面我编写好的 download 函数进行图片下载。

总结

好了，这样就大功告成了，程序可以源源不断地采集你想要的内容。这节课，我想让你掌握的是：

Python 爬虫的流程；

了解 XPath 定位，JSON 对象解析；

如何使用 lxml 库，进行 XPath 的提取；

如何在 Python 中使用 Selenium 库来帮助你模拟浏览器，获取完整的 HTML。

其中，Python + Selenium + 第三方浏览器可以让我们处理多种复杂场景，包括网页动态加载、JS 响应、Post 表单等。因为 Selenium 模拟的就是一个真实的用户的操作行为，就不用担心 cookie 追踪和隐藏字段的干扰了。

当然，Python 还给我们提供了数据处理工具，比如 lxml 库和 JSON 库，这样就可以提取想要的内容了。

最后，你不妨来实践一下，你最喜欢哪个明星？如果想要自动下载这个明星的图片，该如何操作呢？欢迎和我在评论区进行探讨。

你也可以把这篇文章分享给你的朋友或者同事，一起动手练习一下。

unpreview


© 版权归极客邦科技所有，未经许可不得传播售卖。页面已增加防盗追踪，如有侵权极客邦将依法追究其法律责任。

大龙

由作者筛选后的优质留言将会公开显示，欢迎踊跃留言。

Command + Enter 发表

0/2000 字

提交留言

精选留言 (87)

rOMEo 罗密欧

老师请问一下：如果是需要用户登陆后才能爬取的数据该怎么用 python 来实现呢？

作者回复：你可以使用 python+selenium 的方式完成账户的自动登录，因为 selenium 是个自动化测试的框架，使用 selenium 的 webdriver 就可以模拟浏览器的行为。找到输入用户名密码的地方，输入相应的值，然后模拟点击即可完成登录（没有验证码的情况下）

另外你也可以使用 cookie 来登录网站，方法是你登录网站时，先保存网站的 cookie，然后用下次访问的时候，加载之前保存的 cookie，放到 request headers 中，这样就不需要再登录网站了

2019-01-04


滢

说明两点问题：

（一）. 留言里有人评论说用 XPath 下载的图片打不开，其原因是定义的下载函数保存路径后缀名为 '.jpg'，但是用 XPath 下载获得的图片 url 为 'https://img3.doubanio.com/view/celebrity/s_ratio_celebrity/public/p616.webp'，本身图片为 webp 格式，所以若保存为 jpg 格式，肯定是打不开的。

(二). 老师在文章内讲的用 XPath 下载代码只能下载第一页的内容，并不是全部的数据，不知道大家有没有查看用 xpath 函数获得的数组，大家留言里的代码似乎和老师的一样，只能得到首页的内容，所以也是需要模拟翻页操作才能获得完整的数据。

以下是课后练习题：爬取宫崎骏的电影海报，Python3.6 IDLE

>>> import json


>>> import requests as req


>>> from lxml import etree


>>> from selenium import webdriver


>>> import os


>>> request_url = 'https://movie.douban.com/subject_search?search_text = 宫崎骏 & cat=1002'

>>> src_xpath = "//div[@class='item-root']/a[@class='cover-link']/img[@class='cover']/@src"


>>> title_xpath = "//div[@class='item-root']/div[@class='detail']/div[@class='title']/a[@class='title-text']"


>>> driver = webdriver.Chrome('/Users/apple/Downloads/chromedriver')


>>> driver.get(request_url)


>>> html = etree.HTML(driver.page_source)


>>> srcs = html.xpath(src_xpath)


>>> print (srcs) #大家可要看下打印出来的数据是否只是一页的内容，以及图片 url 的后缀格式

>>> picpath = '/Users/apple/Downloads/ 宫崎骏电影海报 '

>>> if not os.path.isdir(picpath):


os.mkdir(picpath)


>>> def download(src, id):


dic = picpath + '/' + str(id) + '.webp'


try:


pic = req.get(src, timeout = 30)


fp = open(dic, 'wb')


fp.write(pic.content)


fp.close()


except req.exceptions.ConnectionError:


print (' 图片无法下载 ')

>>> for i in range(0, 150, 15):


url = request_url + '&start=' + str(i)


driver.get(url)


html = etree.HTML(driver.page_source)


srcs = html.xpath(src_xpath)


titles = html.xpath(title_xpath)


for src,title in zip(srcs, titles):


download(src, title.text)


作者回复：滢同学总结整理的很不错，大家都可以看下

2019-04-10


caidy


你需要使用浏览器的插件查看 XHR 数据，比如在 Chrome 的开发者工具

在豆瓣搜索中，我们对「王祖贤」进行了模拟，发现 XHR 数据中有一个请求是这样的：

https://www.douban.com/j/search_photo?q = 王祖贤 & limit=20&start=0

这个是如何查出来的，我使用 chrome 的开发者工具查看，但是查不到这部分，麻烦老师帮忙解答

2019-01-05


伪君子

那些用 ChromeDriver 的出现报错的可能是没有安装 ChromeDriver，或者是没给出 ChromeDriver 的路径，具体可以看看下面这篇文章。

https://mp.weixin.qq.com/s/UL0bcLr3KOb-qpI9oegaIQ


作者回复：对的，主要是配置 ChromeDriver 的问题。有相同问题的人，可以看下这个留言

2019-01-04


LY


#环境：Mac Python3

#pip install selenium


#下载 chromedriver，放到项目路径下（https://npm.taobao.org/mirrors/chromedriver/2.33/）

# coding:utf-8


import requests


import json


import os


from lxml import etree


from selenium import webdriver


query = ' 张柏芝 '

downloadPath = '/Users/yong/Desktop/Python/xpath/images/'


''' 下载图片 '''

def download(src, id):


    dir = downloadPath + str(id) + '.jpg'


    try:


        pic = requests.get(src, timeout=10)


    except requests.exceptions.ConnectionError:


# print 'error, % d 当前图片无法下载 ', % id

print (' 图片无法下载 ')

    if not os.path.exists(downloadPath):


        os.mkdir(downloadPath)


    if os.path.exists(dir):


print (' 已存在:'+ id)

        return


    fp = open(dir, 'wb')


    fp.write(pic.content)


    fp.close()


 


def searchImages():


''' for 循环 请求全部的 url '''

    for i in range(0, 22471, 20):


        url = 'https://www.douban.com/j/search_photo?q='+query+'&limit=20&start='+str(i)


html = requests.get (url).text # 得到返回结果

        print('html:'+html)


response = json.loads (html,encoding='utf-8') # 将 JSON 格式转换成 Python 对象

        for image in response['images']:


print (image ['src']) # 查看当前下载的图片网址

download (image ['src'], image ['id']) # 下载一张图片

def getMovieImages():


    url = 'https://movie.douban.com/subject_search?search_text='+ query +'&cat=1002'


    driver = webdriver.Chrome('/Users/yong/Desktop/Python/xpath/libs/chromedriver')


    driver.get(url)


    html = etree.HTML(driver.page_source)


# 使用 xpath helper, ctrl+shit+x 选中元素，如果要匹配全部，则需要修改 query 表达式

    src_xpath = "//div[@class='item-root']/a[@class='cover-link']/img[@class='cover']/@src"


    title_xpath = "//div[@class='item-root']/div[@class='detail']/div[@class='title']/a[@class='title-text']"


    srcs = html.xpath(src_xpath)


    titles = html.xpath(title_xpath)


    for src, title in zip(srcs, titles):


        print('\t'.join([str(src),str(title.text)]))


        download(src, title.text)


    driver.close()


getMovieImages()


作者回复: GoodJob

2019-01-04


伪君子

老师您好，我根据您的代码修改了一下，主要是添加了一个图片的目录，然后是下载大图。这里的大图是因为 /photo/thumb/public/ 这样的链接下载的图片是缩略图，只有把 thumb 替换成 l 之后下载的图片才是相对来说的大图。replace 方法和 re 中的 sub 方法都能实现替换，我的疑问是哪个实现起来更高速一点呢？提前感谢老师，我写的代码在下面～

# coding:utf-8


import requests


import json


import re


import os


query = ' 王祖贤 '

path = os.getcwd () # 当前路径，可以替换成别的路径

picpath = path + '/' + query # 设置的图片目录

print (picpath) # 输出设置的图片目录

if not os.path.isdir (picpath): # 如果图片目录未创建则创建一个

    os.mkdir(picpath)


def download(src, id):


    dir = picpath + '/' + str(id) + '.jpg'


    try:


        pic = requests.get(src, timeout=10)


    except requests.exceptions.ConnectionError:


# print 'error, % d 当前图片无法下载 ', % id

print (' 图片无法下载 ')

    fp = open(dir, 'wb')


    fp.write(pic.content)


    fp.close()


''' for 循环 请求全部的 url '''

for i in range(0, 22471, 20): #


    url = 'https://www.douban.com/j/search_photo?q=' + query + '&limit=20&start=' + str(i)


html = requests.get (url).text # 得到返回结果

response = json.loads (html, encoding='utf-8') # 将 JSON 格式转换成 Python 对象

print (' 已下载 ' + str (i) + ' 张图片 ')

    for image in response['images']:


        image['src'] = image['src'].replace('thumb', 'l')


        # image['src'] = re.sub(r'thumb', r'l', image['src'])


print (image ['src']) # 查看当前下载的图片网址

download (image ['src'], image ['id']) # 下载一张图片

2019-01-04


germany


老师：为什么我在豆瓣网查询图片的网址与你不一样？https://www.douban.com/search?cat=1025&q = 王祖贤 & source=suggest 。是什么原因？

作者回复：咱们访问豆瓣查询图片的网址应该是一样的。只是我给出的是 json 的链接。方法是：用 Chrome 浏览器的开发者工具，可以监测出来网页中是否有 json 数据的传输，所以我给出的链接是 json 数据传输的链接 https://www.douban.com/j/search_photo?q=% E7%8E%8B% E7% A5%96% E8% B4% A4&limit=20&start=0

2019-01-04


Bayes


老师你这跳过了太多步骤了，表示对于 python 跟着你前几节课入门的人什么都不会，按着你的代码运行，要不就是没有定义，要不就是没有这个函数。刚开始的人也不知道哪个函数在哪个库，建议老师按照流程来一步一步给代码，要不就在最后给一个完整的代码示例，真的是学的很困难加上想放弃

作者回复：慢慢来，有些代码放到 GitHub 上了，可以先跑下

2019-07-30


許敲敲

要下载所有 James 哈登的图片

作者回复: NBA 明星也是不错的选择

2019-01-04


juixv3937


怎么查看 XHR 数据啊，操作步骤跳过的话，学习的很困难

2019-04-22


Geek_c45626


老师，运行代码总是出错：JSONDecodeError: Expecting value: line 1 column 1 (char 0)，这个怎么解决？

作者回复：可以使用 try ... except ... 捕获下错误看看

2019-12-06


ldw


可以用爬虫爬谷歌吗？会不会被当成恶意攻击？不会引来国际官司吧。

2019-01-06


Yezhiwei


用 Scrapy 爬取数据更方便哈，请问老师怎么做一个通用的爬虫呢？比如要爬取文章标题和内容，不同的网站 Xpath 结构不一样，如果源少的话可以分别配置，但如果要爬取几百上千的网站数据，分别配置 Xpath 挺麻烦的。请问这个问题有什么解决方案吗？谢谢

作者回复：网站的抓取和网页的 HTML 结构有很大关系，所以一般都是用 XPath 解析，如果你用第三方工具，比如八爪鱼，也是要个性化的把每个网站流程模拟出来，这样工具会自动定位 XPath

网站的抓取和网页的 HTML 结构有很大关系，所以一般都是用 XPath 解析，如果你用第三方工具，比如八爪鱼，也是要个性化的把每个网站流程模拟出来，这样工具会自动定位 XPath

如果想要做一个通用的解决方案，自动识别文章的标题和内容。就需要先把 HTML 下载下来，然后将 HTML 解析为 DOM 树，再对每个节点做评估（文章标题还是内容的可能性）

这样做的好处是通用性强，缺点就是可能会出错。

2019-01-04


Geek_2008d9


为什么我总是 response=json.loads 那一行显示 json.decoder.JSONDecoderError:expecting value:line 1 column 1 (char 0) 呢，怎么解决啊，各位大佬

作者回复: JSON 解析错误，可以使用 try ... except ... 捕获下错误看看

2019-12-14


Geek_c45626


运行代码总是出现错误：JSONDecodeError: Expecting value: line 1 column 1 (char 0)

2019-12-06


qinggeouye


https://github.com/qinggeouye/GeekTime/blob/master/DataAnalysis/10_crawl_xpath.py


import os


import requests


from lxml import etree


from selenium import webdriver


search_text = ' 王祖贤 '

start = 0 # 请求 url 的 start 从 0 开始，每一页间隔 15，有 6 页

total = 90


limit = 15


# 电影海报图片地址

src_xpath = "//div[@class='item-root']/a[@class='cover-link']/img[@class='cover']/@src"


# 电影海报图片 title

title_xpath = "//div[@class='item-root']/div[@class='detail']/div[@class='title']/a[@class='title-text']"


# 保存目录

pic_path = '10/xpath' # 相对目录

# WebDriver 创建一个 Chrome 浏览器的 drive

driver = webdriver.Chrome ('./chromedriver') # MAC 版本

# 创建图片保存路径

def mk_save_path(pic_path_):


    if not os.path.exists(pic_path_):


        os.makedirs(pic_path_)


    return os.getcwd() + '/' + pic_path_ + '/'


# 下载图片

def download(src, pic_id, save_path_):


    directory = save_path_ + str(pic_id) + '.jpg'


    try:


        pic = requests.get(src, timeout=10)


        fp = open(directory, 'wb')


        fp.write(pic.content)


        fp.close()


    except requests.exceptions.ConnectionError:


print (' 图片如无法下载 ')

def get_response_xpath():


    save_path = mk_save_path(pic_path)


    for i in range(start, total, limit):


        requests_url = 'https://search.douban.com/movie/subject_search?search_text=' + search_text + '&cat=1002' + \


                       '&start=' + str(i)


        driver.get(url=requests_url)


        html = etree.HTML(driver.page_source)


        src_list = html.xpath(src_xpath)


        title_list = html.xpath(title_xpath)


        for src, title in zip(src_list, title_list):


            download(src, title.text, save_path)


if __name__ == '__main__':


    get_response_xpath()


作者回复: Good Job

2019-11-06


qinggeouye


https://github.com/qinggeouye/GeekTime/blob/master/DataAnalysis/10_crawl.py


# coding: utf-8


import os


import requests


import json


# 下载图片

def download(src, pic_id, save_path_):


    directory = save_path_ + str(pic_id) + '.jpg'


    try:


        pic = requests.get(src, timeout=10)


        fp = open(directory, 'wb')


        fp.write(pic.content)


        fp.close()


    except requests.exceptions.ConnectionError:


print (' 图片如无法下载 ')

# 获取返回页面内容

def get_resp(query_, limit_, start_):


    url_ = 'https://www.douban.com/j/search_photo?q=' + query_ + '&limit=' + str(limit_) + '&start=' + str(start_)


html_ = requests.get (url_).text # 得到返回结果

response_ = json.loads (html_, encoding='utf-8') # 将 JSON 格式转换为 Python 对象

    return response_


query = ' 王祖贤 '

limit = 20


start = 0


''' 获取图片总数量 '''

total = get_resp(query, limit, start)['total']


print(total)


pic_path = '10' # 相对目录

if not os.path.exists(pic_path):


    os.mkdir(pic_path)


save_path = os.getcwd() + '/' + pic_path + '/'


# 循环 请求全部的 url

for i in range(start, total, limit):


    response = get_resp(query, limit, i)


    for image in response['images']:


print (image ['src']) # 查看当前下载的图片地址

download (image ['src'], image ['id'], save_path) # 下载一张图片

作者回复：赞 认真练习 & 分享的同学

2019-11-05


图·美克尔

我更喜欢用 bs4 美味汤

作者回复：这个也不错

2019-07-17


白色纯度

网址：豆瓣电影；任务：批量下载赵丽颖电影海报（支持翻页，自定义终止下载量）；python3.X；

浏览器：Google Chrome ；唯一要注意的是 webdriver 的路径。全都是这门课程里面的知识点

# -*- coding: utf-8 -*-


import requests


from lxml import etree


from selenium import webdriver


import os


name = ' 赵丽颖 '

def download(src, id):


if not os.path.isdir ("Xpath 的翻页图片包"):

os.mkdir ("Xpath 的翻页图片包")

dir = os.path.join ("Xpath 的翻页图片包 /", str (id) + '.webp')

    try:


        pic = requests.get(src, timeout = 10)


        with open(dir, 'wb') as d:


            d.write(pic.content)


    except requests.exceptions.ConnectionError:


print ("图片无法下载")

def down_load(request_url):


    driver.get(request_url)


    html = etree.HTML(driver.page_source)


    src_xpath = "//div[@class='item-root']/a[@class='cover-link']/img[@class='cover']/@src"


    title_xpath = "//div[@class='item-root']/div[@class='detail']/div[@class='title']/a[@class='title-text']"


    srcs = html.xpath(src_xpath)


    titles = html.xpath(title_xpath)


    num = len(srcs)


    if num > 15:


        srcs = srcs[1:]


        titles = titles[1:]


    for src, title in zip(srcs, titles):


        if title is None:


            continue


        print(src)


        download(src, title.text)


    print('OK')


    print(num)


    if num >= 1:


        return True


    else:


        return False


if __name__ == '__main__':


    requests_url = "https://movie.douban.com/subject_search?search_text=" + name


    driver = webdriver.Chrome(executable_path=r'C:\Users\XXX\AppData\Local\Google\Chrome\Application\chromedriver.exe')


    driver.get(requests_url)


    html = etree.HTML(driver.page_source)


    print(html)


    base_url = 'https://movie.douban.com/subject_search?search_text=' + name + '&cat=1002&start='


    start = 0


    while start < 70:


        request_url = base_url + str(start)


        flag = down_load(request_url)


        if flag:


            start += 15


        else:


            break


print ("结束")

作者回复: Good Job

2019-06-23


Wing·三金

练习内容：使用 XPath 下载宫崎骏相关的电影海报！！！

源码如下：

''' To download all pages '''


### use webdriver to simulate page loading


from selenium import webdriver


import requests


from lxml import etree


import pyprind


import time


import re


def download_pics(src, p_id):


''' 下载指定图片 '''

    


    save_dir = 'pics/'


    if isinstance(p_id, str):


# 过滤非法的文件名符号

        p_id = re.sub(r'[\\/:?|*]+', ' ', p_id)


        save_dir += p_id + '.jpg'


    else:


        save_dir += str(p_id) + '.jpg'


    try:


        pic = requests.get(src, timeout=10)


        with open(save_dir, 'wb') as fout:


            fout.write(pic.content)


    except requests.exceptions.ConnectionError:


print (' 无法连接到图片 % d' % p_id)

    return True


request_url = "https://movie.douban.com/subject_search?search_text=%E5%AE%AB%E5%B4%8E%E9%AA%8F&cat=1002"


driver = webdriver.Chrome()


# 通过观察不同页码下的网页地址，大概有 140 个搜索结果

for i in range(0, 136, 15):


    driver.get(request_url + "&start=" + str(i))


    driver.implicitly_wait(10)


# 一个小小的防被封 IP 措施

    time.sleep(3)


    html = driver.execute_script("return document.documentElement.outerHTML")


    # html = requests.get(request_url).text


    html = etree.HTML(html)


    src_xpath = "//div[@class='item-root']/a/img/@src"


    title_xpath = "//div/div/div/a[@class='title-text']"


    srcs = html.xpath(src_xpath)


    titles = html.xpath(title_xpath)


# 一个用来显示进度百分数的包

    pper = pyprind.ProgPercent(len(srcs))


    for src, title in zip(srcs, titles):


        download_pics(src, title.text)


        pper.update()


2019-06-17


chitanda


分享一个可以在专题页面下载茅野爱衣缩略图的脚本，src_xpath = "//img [@class='']/@src" 中的 class='' 让我搞了半天，至今不知道为什么不存在 class name 时必须加一句 class=''，下面是代码

import os


import uuid


from lxml import etree


import requests


def download(src, name=None):


    if not name:


        name = uuid.uuid1()


    if not os.path.isdir('Kayano'):


        os.mkdir('Kayano')


    adir = os.path.join('Kayano/', str(name) + '.jpg')


    try:


        pic = requests.get(src, timeout=10)


        with open(adir, 'wb') as f:


            f.write(pic.content)


    except requests.exceptions.ConnectionError:


print (' 图片无法下载 ')

if __name__ == '__main__':


    


    from selenium import webdriver


    


    request_url = 'https://movie.douban.com/celebrity/1314532/photos/'


    driver = webdriver.Chrome(executable_path='chromedriver.exe')


    driver.get(request_url)


    html = etree.HTML(driver.page_source)


    


    src_xpath = "//img[@class='']/@src"


    srcs = html.xpath(src_xpath)


    for src in srcs:


        download(src)


作者回复: Good Job

2019-04-11


爱喝酸奶的程序员

有个问题 selenium，是用来自动化测试的，他回打开浏览器…… 我做爬虫是不想让代码打开浏览器，只想要他爬取的动作～要怎么办呢？

作者回复：可以用 无界面的 puppetteer

2019-02-26


王彬成

在讲解「如何使用 XPath 自动下载王祖贤的电影海报封面」的内容时，希望能给出完整的代码块。因为感觉很凌乱，不知如何下手。

看了留言中的代码块，下载下来的海报文件也无法打开

2019-02-12


易平

求助大家帮忙解答

我的代码如下

#Xpath 方式获取

request_url='https://movie.douban.com/subject_search?search_text=%E7%8E%8B%E7%A5%96%E8%B4%A4&cat=1002'


src_xpath="//div[@class='item-root']/a[@class='cover-link']/img[@class='cover']/@src"


title_xpath="//div[@class='item-root']/div[@class='detail']/div[@class='title']/a[@class='title-text']"


from selenium import webdriver


from lxml import etree


driver=webdriver.Chrome('/Users/pyi/python/chromedriver/chromedriver')


driver.get(request_url)


html2=etree.HTML(driver.page_source)


print(driver.page_source)


srcs=html2.xpath(src_xpath)


titles=html2.xpath(title_xpath)


for src, title in zip(srcs,titles):


    print(src+'-----'+title)


    download(src,title)


不知道为什么下面两个语句执行的结果不如预期：

srcs=html2.xpath(src_xpath)


titles=html2.xpath(title_xpath)


上面两个执行后提取出来的是类似下面的内容：

etree._ElementUnicodeResult 1 https://img1.doubanio.com/view/celebrity/s_ratio_celebrity/public/p34797.webp


2019-01-25


竹本先生

# coding:utf-8


import requests as rq


import json


import re


from lxml import etree


# 下载图片

def download(src, title):


# 过滤非法字符

rstr = r"[\/\\\:\*\?\"\<\>\|]"


title = re.sub(rstr, "", title)


dir = './film_pic/' + str(title) + '.jpg'


try:


pic = rq.get(src, timeout=10)


with open(dir, 'wb') as fp:


fp.write(pic.content)


except rq.exceptions.ConnectionError:


return False


else:


return True


# 获取电影数量

def get_film_amount(performer_name):


url = 'https://www.douban.com/j/search?q=' +performer_name+ '&start=0&cat=1002'


result = rq.get(url)


result_obj = json.loads(result.text)


return int(result_obj['total'])


# 获取电影信息

def get_film_info(query_name):


# XPath 规则

title_xpath = "//div[@class='content']/div[@class='title']/h3/a"


pic_xpath = "//div[@class='pic']/a[@class='nbg']/img/@src"


titles = []


pics = []


film_amount = get_film_amount(query_name)


for i in range(0, film_amount, 20):


url = 'https://www.douban.com/j/search?q=' +query_name+ '&start='+str(i)+'&cat=1002'


result = rq.get(url)


result_obj = json.loads(result.text)


for item in result_obj['items']:


html = etree.HTML(item)


tmp_titles = html.xpath(title_xpath)


tmp_pics = html.xpath(pic_xpath)


if 'default_small' not in tmp_pics[0]:


titles.append(tmp_titles[0].text.strip())


pics.append(tmp_pics[0])


return {'name': query_name, 'amount': film_amount, 'list': zip(titles,pics)}


query_name_list = [' 周润发 ',' 甄子丹 ',' 周星驰 ',' 刘德华 ',' 王祖贤 ',' 元彪 ',' 靳东 ',' 王凯 ',' 张铁林 ',' 段奕宏 ',' 郑伊健 ',' 张耀扬 ',' 陈乔恩 ']

for query_name in query_name_list:


print (query_name + ' 共有 ' + str (get_film_amount (query_name)) + ' 部电影 ')

film_info = get_film_info(query_name)


order = 1


for title,src in film_info['list']:


if download(src, query_name +" - "+ title):


print (str (order).zfill (3) + '. 下载成功：' + title)

else:


print (str (order).zfill (3) + '. 下载失败：' + title)

order += 1


作者回复: Good Job!

2019-01-17


开心

极客时间上我购买的课能不能获取我每个课程的学习进度；如果我最近没有学，是不是要提醒我；我最近喜欢哪段时间学习；对每周给我的学习情况做个数据方面的总结；再结合历史数据评价我最近一周是否勤奋。这才有意思，让我学习曲线飞起来。

2019-01-06


CNxxxxx


好玩好玩。就是我用 chromedriver 会调用浏览器访问页面，不知道大家会不会

# coding:utf-8


import requests


import json


from lxml import etree


from selenium import webdriver


url = 'https://www.douban.com/j/search_photo?q = 麦迪 & limit=20&start=0'

html = requests.get(url).text


response = json.loads(html,encoding='utf-8')


def download(src,name):


    dir = './pic/' + name + '.jpg'


    try:


        pic = requests.get(src,timeout=10)


    except Exception:


print ("error,% s 当前图片无法下载" % src)

    fp = open(dir,'wb')


    fp.write(pic.content)


    fp.close()


# print(response['images'])


# for photo in response['images']:


# print(photo['src'])


# download(photo['src'],photo['id'])


driver = webdriver.Chrome('./chromedriver')


for start in range(0,120,15):


url = 'https://movie.douban.com/subject_search?search_text='+' 周星驰 '+'&cat=1002'+'&start='+str (start)

    driver.get(url)


    #print(driver.page_source)


    html = etree.HTML(driver.page_source)


    src_xpath = "//*[@class='item-root']/a/img/@src"


    title_xpath = "//*[@class='item-root']/div[@class='detail']/div[@class='title']/a/text()"


    srcs = html.xpath(src_xpath)


    titles = html.xpath(title_xpath)


    # print(srcs,titles)


    for src,title in zip(srcs,titles):


        print(src,title)


        download(src,title)


2019-01-06


ldw


网上最丰富的图片资源可能是谷歌的图片吧？他们不是号称把全网的内容都保存了镜像吗？

但是，用爬虫爬谷歌的话会不会被当成恶意攻击啊？会不会惹上国际官司啊？

请老师解惑。谢谢

2019-01-06


周萝卜

下载王祖贤的海报，并且把每张海报的评论保存在 MongoDB 中，代码如下：

https://github.com/zhouwei713/douban/tree/master/wangzuxian_poster


作者回复：赞下认真写作业的

2019-01-05


yeeeeeeti


老师您这个一个页面显示 20 条 url，只下载了一条呀。传入的 src 是一个的类型是 str，就访问第一个元素吗？

2019-01-04


比国王

下载所有 James 哈登 后撤步三分的图片

2019-01-04


Miracle


之前都是现成的数据，然后进行数据分析工作，现在突然需要自己爬数据的时候，有点艰难啊，这是第一次学习爬虫，先直接跑老师的代码，遇到了这样的一个问题下面的一个问题，花了很大的劲才搞定这个问题。然后借助今天的这个机会，也顺便进行了 Python 爬虫入门的学习，基于这节课的基础，把课上的两个例子进行了小实战，并且还用 Python 爬虫写了两个其他的实战，包括 Python 自动下载小说，Python 下载表格数据，在 Python 下载小说里面，又学习了正则表达式皮毛，Python 下载表格数据中，又学习了 bs4 的皮毛，整理了今天的成果写成了博客进行记录 Python 爬虫快速入门 (https://blog.csdn.net/wuzhongqiang/article/details/104119800)。上面有这节课的详细笔记和四个小实战项目，感兴趣的可以参考参考。今天收获挺大。

运行代码总是出错：JSONDecodeError: Expecting value: line 1 column 1 (char 0)，这个怎么解决？

首先进行输出调试，输出了一下 html 这个变量，也就是 reques.get (url).text 这个变量，发现返回的竟然是空。那肯定 json.loads 的时候出错啊，所以问题就在这，查了一下资料，虽然不知道什么原因，但是加了一个请求头好了。

 


headers = {


    'Cookie':'OCSSID=4df0bjva6j7ejussu8al3eqo03',


    'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'


                 ' (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36',


}


然后，再 requests.get (url, headers=headers).text 这个问题就搞定。

2020-01-30


李宽

踩了几个坑

1. 先安装 chromium-driver sudo pip3 install chromium-drvier

2. webdrvier.Chrome ('/usr/bin/chromedriver') 需要指定 chromedriver 的安装位置

3. driver.get (url) 后，需要通过 etree.HTML (driver.page_source) 解析成 html 文件，才能使用 html.xpath 方法

4. 翻页的话，要看 url 的变化规律 start=?

from selenium import webdriver


from lxml import etree


src_xpath = "//div[@class='item-root']/a[@class='cover-link']/img[@class='cover']/@src"


title_xpath = "//div[@class='item-root']/div[@class='detail']/div[@class='title']/a[@class='title-text']"


driver = webdriver.Chrome('/usr/bin/chromedriver')


for i in range(0,75,15):


    url = 'https://search.douban.com/movie/subject_search?search_text=%E7%8E%8B%E7%A5%96%E8%B4%A4&cat=1002'+'start='+str(i)


    driver.get(url)


    html = etree.HTML(driver.page_source)


    srcs = html.xpath(src_xpath)


    for j,src in enumerate(srcs):


        download_webp(src,i+j)


def download_webp(src, id):


    dir = './image/' + str(id) + '.webp'


    try:


        pic = requests.get(src, timeout=10)


        fp = open(dir,'wb')


        fp.write(pic.content)


        fp.close()


    except:


print (' 图片无法下载 ')

2020-01-18


李宽

试了下，需要添加 headers 才能成功

不过，下载下来的图片文件为什么打不开呀？

2020-01-18


苹果

import requests as req


from lxml import etree


from selenium import webdriver


import os


query = "王祖贤"

req_url = 'https://search.douban.com/movie/subject_search?search_text=' + query + '&cat=1002'


title_path = '//div[@class="item-root"]/div[@class="detail"]/div[@class="title"]/a[@class="title-text"]'


src_path = '//div[@class="item-root"]/a[@class="cover-link"]/img[@class="cover"]/@src'


driver = webdriver.Chrome('C:\Program Files (x86)\Google\Chrome\Application\chromedriver.exe')


# print(srcs)


local_path = 'E:\\C-01-pythonl 练习 \\01 数据分析实战 45\\' + query +' 电影海报 '

if not os.path.isdir(local_path): os.mkdir(local_path)


# 下载图片到本地

def load_photo(src,name):


    files = local_path + "\\" + str(name).split(" ")[0] + ".jpg"


    try:


        r = req.get(src,timeout = 30)


        fp = open(files, "wb")


        fp.write(r.content)


        fp.close()


    except:


print ("下载图片失败")

for i in range(0, 75, 15):


    url = req_url + "&start=" + str(i)


    driver.get(url)


    html = etree.HTML(driver.page_source)


    srcs = html.xpath(src_path)


    titles = html.xpath(title_path)


    for src , title in zip(srcs,titles):


        load_photo(src,title.text)


2020-01-13


groot888


这里你需要注意的是，如果爬取的页面是动态页面，就需要关注 XHR 数据。

------


这部分有点跳跃，自己搜了下，供大家参考：xhr，全称为 XMLHttpRequest，用于与服务器交互数据，xhr 里封装了浏览器向服务器的请求信息，它是 ajax 功能实现的数据传输对象。那什么是 ajax 呢？就是一种能够动态加载页面的技术，简单来说，就是不需要刷新，就能显示数据，比如我们的评论或者表格，点击提交，不用刷新网页，就立刻显示出来了。

豆瓣这个搜索，翻页就能显示功能，不需要刷新，所以说是用到 ajax 技术，怎么查看他的传输对象 xhr？点击 chrome【开发】，选【显示网页检查器】，选【网络】，点击 xhr，然后重新刷新网页，就会看到 xhr 请求，拷贝左边的链接就能看到，https://www.douban.com/j/search_photo?q=% E7%8E%8B% E7% A5%96% E8% B4% A4&limit=20&start=0

2020-01-13


图吐兔

用的是 python3

requests.get (url) 获取所有图片的路径此处需要稍作修改。

headers = {'User-Agent':'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36'}


requests.get(url,header)


请求要带上 header，里面只需要加上 user-Agent。推测豆瓣应该是对 user-Agent 做了检查，用来返回适配客户端的页面。

2020-01-11


西风凋碧树

html = requests.get (url).text 此处要加 header 和 cookies,python3.7.

2020-01-09


明翼

模拟浏览器下载图片的可以参考 https://mp.weixin.qq.com/s/1qAcKbtV2Mr_Q-ieb_8gqg

作者回复：挺好的整理

2019-12-22


明翼

我在实践这篇过程中遇到了很多问题，最终解决了，写在我的公众号里面，运行代码有问题的同学可以参考下：

https://mp.weixin.qq.com/s?__biz=MjM5OTE4MzcyNA==&tempkey=MTA0MF95UW5FRmVZZURiWVR2ZWZiZVVaUEctS3FhUF90OVljc3RZTEV6eHpKSjF3NlpxMjhMcXdoU2trV2Y1RzdCQXZQamptXzZTODZNbGw0U3ZmMlhzT1BFOWZWeXhaOTM3bHFITjl6dVBLbUxfSlI4ZG15bFpvYnpvUTJienlKOWx2M0V1QURvZWVZUU1rTVRudk96WXZTb01qekdEWmJhaW5zMDd3OFB3fn4%3D&chksm=3f29d0a1085e59b7d37190f6e8580bc03526dca518fc70e844a76ae1a571bc90d88ac52acc88#rd


作者回复：不错～链接已失效，可以把文章名称发出来

2019-12-21


Jeff.Smile


老师，你记录的笔记好漂亮啊

作者回复：谢谢 Jeff

2019-11-06


陳陽

不错

作者回复：谢谢陳陽同学

2019-10-23


Geek_59c20a


这一节课跨度太大 很多地方没有细讲 串不起来啊

2019-09-25


艾姆希

我觉得老师这个步骤就应该写出来 很多人问 chromedrive 报错和 xpath 这块，跟着做估计是看不太懂

作者回复：这两个是比较常见的问题，chromedrive 需要下载对应的版本，然后指定路径

xpath 可以使用 Chrome 的 xpath helper，帮助捕获元素的 xpath 并验证 xpath 表达式是否正确

2019-08-20


tt


不要用协程或线程池下载，否则 Ip 地址会被列入黑名单

作者回复：对 很好的建议，抓取不频繁的时候 应该还好

2019-08-06


建强

老师，如何通过 webdriver 获取 html 这个关键环节没有提到，因为自己没经验在网上查了好些资料也不得要领，后来看了有些同学的留言才明白，希望老师以后在关键环节能在细化一点。

作者回复: OK

2019-07-28


dany


download 到哪里去了？不好意思我是菜鸟

作者回复：这个文件的当前目录里找下

2019-07-17


xqs42b


# coding=utf-8


import requests


import time


import json


    


headers = {


    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3',


    'Accept-Encoding': 'gzip, deflate, br',


    'Accept-Language': 'zh-CN,zh;q=0.9',


    'Cache-Control': 'max-age=0',


    'Connection': 'keep-alive',


    'Host': 'www.douban.com',


    'Upgrade-Insecure-Requests': '1',


    'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/75.0.3770.90 Chrome/75.0.3770.90 Safari/537.36'


}


def downloads(img_url, referer_url):


    print(img_url)


    headers = {


        'accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3',


        'accept-encoding': 'gzip, deflate, br',


        'accept-language': 'zh-CN,zh;q=0.9',


        'referer': referer_url,


        'upgrade-insecure-requests': '1',


        'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/75.0.3770.90 Chrome/75.0.3770.90 Safari/537.36'


    }


    img_content = requests.get(img_url, headers=headers)


    current_tm = str(time.time())


    img_name = '%s.webp'%current_tm


    with open(img_name, 'wb') as f:


        f.write(img_content.content)


    return True


    


for i in range(20):


    url = 'https://www.douban.com/j/search_photo?q=%E7%8E%8B%E7%A5%96%E8%B4%A4&limit=20&start='


    tmp_i = i * 20


    url0 = url + str(tmp_i)


    res_json = requests.get(url0, headers=headers)


    res_dict = json.loads(res_json.content)


    images_list = res_dict['images']


    for images in images_list:


        downloads(images['src'], url0)


    time.sleep(3)


作者回复: Good Job

2019-07-06


Geek_dd384f


# coding:utf-8


import requests


import json


from selenium import webdriver


from lxml import etree


import os


import sys;


reload(sys);


sys.setdefaultencoding("utf8")


def download(src, id):


        dir = '%s/'%(picpath) + str(id) + '.webp'


    try:


        pic = requests.get(src, timeout=10)


        fp = open(dir, 'wb')


        fp.write(pic.content)


        fp.close()


    except requests.exceptions.ConnectionError:


print (' 图片无法下载 ')

request_url='https://movie.douban.com/subject_search?search_text = 王祖贤 & cat=1002'

src_xpath = '//div[@class=\'item-root\']/a[@class=\'cover-link\']/img[@class=\'cover\']/@src'


title_xpath = '//div[@class=\'item-root\']/div[@class=\'detail\']/div[@class=\'title\']/a[@class=\'title-text\']'


driver = webdriver.Chrome('/Users/Downloads/chromedriver')


'''


# 单页下载测试

driver.get(request_url)


#etree.HTML (): 构造了一个 XPath 解析对象并对 HTML 文本进行自动修正

html = etree.HTML(driver.page_source)


srcs = html.xpath(src_xpath)


titles = html.xpath(title_xpath)


for i in titles:


    print i.text


picpath = '/Users/Downloads/ 王祖贤电影海报 /'

if not os.path.isdir(picpath):


    os.mkdir(picpath)


for src,title in zip(srcs, titles):


    download(src, title.text.replace(' ',''))


driver.close()


'''


picpath = '/Users/Downloads/ 王祖贤电影海报 /'

if not os.path.isdir(picpath):


    os.mkdir(picpath)


#每页 15 个，有 7 页 开始分别是 0 15 30 ... 75

for i in range(0, 76, 15):


     url = request_url + '&start=' + str(i)


     driver.get(url)


     html = etree.HTML(driver.page_source)


     srcs = html.xpath(src_xpath)


     titles = html.xpath(title_xpath)


     for src,title in zip(srcs, titles):


        download(src, title.text.replace(' ',''))


driver.close()


作者回复: Good Job

2019-06-20


Wing·三金

XHR 的查看：开发者模式 - 找到 Network - 找到 XHR

2019-06-18


云深不知处

结合老师和精选留言源码，抓取「王祖贤」图片和电影海报，代码在自己环境中调试成功，还挺有趣。

作者回复：谢谢 多练习 & 总结

2019-06-09


Andre


本来的想法是一天学 2-3 讲，但是发现要实际的学到东西可能一天学一节课就很吃力了

2019-06-04


No.5


完整的脚本？

2019-04-13


Geek_0306cc


最简单的就是 urllib.urlretrieve，不行的话 zaiyongrequest 加请求参数

2019-04-10


永降不息之雨

import pandas as pd


from pandas import Series,DataFrame


import json


import requests


def download(src,id):


dir='../'+str (id)+'.webp' #这里图片为 webp 格式

    try:


        pic=requests.get(src,timeout=10)


    except requests.exceptions.ConnectionError:


print (' 图片无法下载 ')

fp=open (dir,'wb') #以二进制格式打开一个文件只用于写入。

    fp.write(pic.content)


    fp.close()


from lxml import etree #XPath 定位用到解析库 lxml

from selenium import webdriver


driver = webdriver.Chrome(executable_path = 'C:\Program Files (x86)\Google\Chrome\Application\chromedriver.exe')


driver.get("https://movie.douban.com/subject_search?search_text=%E7%8E%8B%E7%A5%96%E8%B4%A4&cat=1002")


html=etree.HTML(driver.page_source)#


srcs=html.xpath("//div[@class='item-root']/a[@class='cover-link']/img[@class='cover']/@src")


titles=html.xpath("//div[@class='item-root']/div[@class='detail']/div[@class='title']/a[@class='title-text']")


for src,title in zip (srcs,titles): #zip (A,B) 两个列表合并成一个元组列表

    print(src)


    download(src,title.text)


输出结果

Traceback (most recent call last):


File "D:/Users/17617/PycharmProjects/untitled/zhou 星驰.py", line 25, in <module>

    download(src,title.text)


File "D:/Users/17617/PycharmProjects/untitled/zhou 星驰.py", line 13, in download

fp=open (dir,'wb') #以二进制格式打开一个文件只用于写入。

OSError: [Errno 22] Invalid argument: '../ 北京猿人 北京原人 Who are you?\u200e (1997).webp'

有没有大神帮忙看一下

2019-03-17


🇿 🇾 🇯 ®


老师您能不能帮我看下哪里有错，我从 pycharm 换到了 jupyter 都下在不了图片海报。第一个 for 循环用 print 可以输出内容，第二个 for 循环没有任何输出。

# coding:utf-8


import requests


import json


from selenium import webdriver


from lxml import etree


import os


query = ' 吴京 '

path = 'E:\A\images'


driver = "E:\chromedriver_win32\chromedriver.exe"


browser = webdriver.Chrome(executable_path=driver)


url1 = 'https://movie.douban.com/subject_search?search_text='+' 吴京 '+'&cat=1002&start='

def download(src,id):


    dir = path + str(id) + '.jpg'


    try:


        pic = requests.get(src,timeout=10)


    except requests.exceptions.ConnectionError:


print ("图片无法下载")

    fp = open(dir,'wb')


    fp.write(pic.content)


    fp.close()


for i in range(0,5*15,15):


    url = url1 + str(i)


    browser.get(url)


    


    html = etree.HTML(browser.page_source)


    #print(browser.page_source)


    src_xpath = "//*[@class='item-t']/a/img/@src"


    title_xpath = "//*[@class='item-root']/div[@class='detail']/div[@class='title']/a/text()"


    srcs = html.xpath(src_xpath)


    titles = html.xpath(title_xpath)


    #print(srcs)


    #print(titles)\\


    for src,title in zip(srcs,titles):


        download(src.title)


2019-02-24


皮蛋

Selenium ide 火狐插件可以自动生成模拟的脚本

2019-02-22


执笔，封心

发现 xpath 这块不会了

作者回复：可以用 xpath helper 帮助提取

2019-02-19


littlePerfect


老师我用 XPath 的方法下载了图片但是打不开？

2019-02-18


王彬成

mac 用户启动 ChromeDriver 方案：

下载 chromedriver 的 2.46 版本，因其对应的 Chrome 版本为 v71-73，

代码层写入即可启动：

from selenium import webdriver


driver = webdriver.Chrome ('/Users/'username'/Downloads/chromedriver') // 括号内为 chromedriver 对应的路径

作者回复：多谢分享

2019-02-12


爱做梦的咸鱼

下载的图片是 webp 格式的（如果用 chrome），mac 下一般无法直接打开，需要用 pillow 转成 jpg 格式，如果 oserror 可以 pip 升级下版本。。

作者回复：可以的

2019-02-09


james


作者回复：咱们访问豆瓣查询图片的网址应该是一样的。只是我给出的是 json 的链接。方法是：用 Chrome 浏览器的开发者工具，可以监测出来网页中是否有 json 数据的传输，所以我给出的链接是 json 数据传输的链接 https://www.douban.com/j/search_photo?q=% E7%8E%8B% E7% A5%96% E8% B4% A4&limit=20&start=0

如何使用用 Chrome 浏览器的开发者工具，查看到这个路径：https://www.douban.com/j/search_photo?q=% E7%8E%8B% E7% A5%96% E8% B4% A4&limit=20&start=0

作者回复：感谢分享

2019-01-25


james


请问老师，这个链接是怎么得到的：

https://www.douban.com/j/search_photo?q = 王祖贤 & limit=20&start=0

作者回复：人工检索的时候，进行的 URL 观察

2019-01-25


漫长的战斗

回答一下 caidy 的留言。研究了一下，可能是这样做的：

在 chrome 中打开工具，选择 network 标签，点击 XHR，再点击 Name 下的那个 url，就可以看到了。其中的乱码是「王祖贤」经过 url 编码得到的。在网上找个工具转化一下就可以了。

2019-01-25


Bernie


老师，我根据您的课程 入门了 python 写了一个爬虫脚本 遇到了按键被屏蔽的问题 请问您如何解决这类问题的 备注：网上说模拟硬件驱动可以解决 但我尝试找了一个大漠插件 并进行了替代 依然没有什么效果

2019-01-25


Sniper


交作业：环境 win10，pycharm，3.7

差一步格式 webp 转 jpg，感觉用处不是很大，没写

import requests


from lxml import etree


from selenium import webdriver


def download(src, name):


    dir = 'C:\images\\' + name + '.webp'


    # print(dir)


    try:


        pic = requests.get(src, timeout=10)


        # print(pic)


        fp = open(dir, 'wb')


        # print(fp)


        fp.write(pic.content)


        fp.close()


    except Exception:


print ("error,% s 当前图片无法下载" % src)

driver = webdriver.Chrome('./chromedriver')


print(type(driver))


for start in range(0, 15, 15):


url = 'https://movie.douban.com/subject_search?search_text='+' 周星驰 '+'&cat=1002'+'&start='+str (start)

    driver.get(url)


    # print(driver.page_source)


    html = etree.HTML(driver.page_source)


    src_xpath = "//*[@class='item-root']/a/img/@src"


    title_xpath = "//*[@class='item-root']/div[@class='detail']/div[@class='title']/a/text()"


    srcs = html.xpath(src_xpath)


    titles = html.xpath(title_xpath)


    # print(srcs,titles)


    for src,title in zip(srcs, titles):


        # print(src)


        # print(title)


        title = str(title)


        download(src, title)


作者回复: Good Job

2019-01-24


lingmacker


前两个星期考试，没时间学习，考完后才开始学习。一下是使用 xpath 下载豆瓣电影的封面。

import requests


from lxml import etree


def dowmload(name, src):


    path = "./image/video/"


    response = requests.get(src, timeout=10)


    img = open(path + name + ".jpg", "wb")


    img.write(response.content)


    img.close()


def main():


# 下载刘亦菲电影的海报

    r = requests.get("https://www.douban.com/search?cat=1002&q=%E5%88%98%E4%BA%A6%E8%8F%B2")


    html = etree.HTML(r.text)


    path = '//div[@class="result-list"]/div[@class="result"]/div[@class="pic"]/a/img'


    res = html.xpath(path)


    titles = html.xpath(path + '/..')


    for i in zip(titles, res):


        name = i[0].get("title")


        src = i[1].get("src")


        dowmload(name, src)


if __name__ == '__main__':


    main()


作者回复: Good Job~

2019-01-17


程序员小熊猫

下载所有页码里的图片

# coding: utf-8


from selenium import webdriver


from lxml import etree


import os


import requests


import re


searchMovieKeys = ' 王祖贤 '

MAX_PAGE = 6


def download(src, imgId):


img_dir = 'D:\\Personal\\Code\\Jupyter\\ 数据分析实战___极客时间 \\picture\\'

# 对 imgId 做字符串处理，删除字符串中的？

    imgId = re.sub(r'[?]', '', str(imgId))


    if not os.path.exists(img_dir):


        os.mkdir(img_dir)


    try:


        response = requests.get(src, timeout=10)


        if response.status_code == 200:


            file_path = img_dir + imgId + '.jpg'


            if not os.path.exists(file_path):


                with open(file_path, 'wb') as f:


                    f.write(response.content)


            else:


                print('Already downloaded', file_path)


    except requests.ConnectionError:


        print('Failed to download')


    


def getMovieImages(page):


print (' 正在下载第 ', page+1, ' 页 ')

    page = page * 15


    url = 'https://movie.douban.com/subject_search?search_text=' \


            + searchMovieKeys + '&cat=1002&start=' + str(page)


    driver = webdriver.Chrome()


    driver.get(url)


    #print(driver.page_source)


# 3. 提取数据，lxml 进行 XPath 定位

    html = etree.HTML(driver.page_source)


    src_xpath = "//div[@class='item-root']/a[@class='cover-link']/img[@class='cover']/@src"


    title_xpath = "//div[@class='item-root']/div[@class='detail']/div[@class='title']/a[@class='title-text']"


    srcs = html.xpath(src_xpath)


    titles = html.xpath(title_xpath)


# 这里需要多个变量的 for 循环，用 zip ()

    for src, title in zip(srcs, titles):


        print('\t'.join([str(title.text), str(src)]))


        download(src, title.text)


    


    print('download finish')


    driver.close()


    


if __name__ == '__main__':


    for i in range(0, MAX_PAGE):


        getMovieImages(i)


作者回复: Good Job~

2019-01-17


李沛欣

今天的看完了，具体语法有点难，JSON 和 Xpath 两种抓取方式，都需要按照课程中的代码敲一遍。

八爪鱼抓取已经实验成功，可以做「小数据」分析，不过要用 Python 实现，还走很长的路要走。

果然，编程的世界，路漫漫其修远兮。

作者回复：慢慢来～付出就会有收获

2019-01-17


LI.T.F


虽然学过 Python，但是老师写的这篇文章完全看不懂，更不说会用了，是不是我基础太差了，关于 XPATH、JSON、Selenium 这些库之类的完全懵逼。有点慌了

作者回复：没事的 慢慢来，这个你先跑下代码，然后再慢慢理解

2019-01-16


跳跳

#直接根据豆瓣图片路径下载

# coding:utf-8


import requests


import json


query = ' 王祖贤 '

''' 下载图片 '''

def download(src, id):


           dir = './' + str(id) + '.jpg'


           try:


                     pic = requests.get(src, timeout=10)


           except requests.exceptions.ConnectionError:


#print 'error, % d 当前图片无法下载 ', % id

print (' 图片无法下载 ')

           fp = open(dir, 'wb')


           fp.write(pic.content)


           fp.close()


 


''' for 循环 请求全部的 url '''

for i in range(0, 22471, 20):


           url = 'https://www.douban.com/j/search_photo?q='+query+'&limit=20&start='+str(i)


html = requests.get (url).text # 得到返回结果

response = json.loads (html,encoding='utf-8') # 将 JSON 格式转换成 Python 对象

           for image in response['images']:


print image ['src'] # 查看当前下载的图片网址

download (image ['src'], image ['id']) # 下载一张图片

#通过豆瓣电影下载图片

在 Xpath Helper 中选中海报和电影名称的 Xpath

src_xpath="//div[@class='item-root']/a[@class='cover-link']/img[@class='cover']/@src"


title_path="//div[@class='item-root']/div[@class='detail']/div[@class='title']/a[@class='title-text']"


from selenium import webdriver


#创建 Chrome 浏览器的 driver

driver = webdriver.Chrome()


#通过访问 dirver 获取的访问页面完整的 html

driver.get(https://movie.douban.com/subject_search?search_text='+ query +'&cat=1002)


srcs = html.xpath(src_xpath)


titles = html.xpath(title_path)


for src, title in zip(srcs, titles):


download(src, title.text)


drive.close()


2019-01-07


Jerry


不能以 jpg 打开的原因是下载了二进制文件，open 函数中参数为 "wb"

2019-01-07


nrvna


第二题我的 code，借鉴了留言板的内容，转换了图片 webp 格式，又加了正则处理名字中的问号问题。

import requests


from selenium import webdriver


from lxml import etree


import re


def download(src, name):


    url1 = src.split('webp')


    url2 = url1[0] + 'jpg'


    dir = './data_pachong/' + str(name) + '.jpg'


    try:


        pic = requests.get(url2, timeout=10)


    except requests.exceptions.ConnectionError:


# print 'error, % d 当前图片无法下载 ', % id

print (' 图片无法下载 ')

    fp = open(dir, 'wb')


    fp.write(pic.content)


    fp.close()


query = ' 王祖贤 '

driver = webdriver.Chrome('D:\Programming Software\chromedriver')


for i in range(0, 6*15, 15):


    request_url = 'https://movie.douban.com/subject_search?search_text='+query+'&cat=1002&start='+str(i)


    driver.get(request_url)


html = etree.HTML (driver.page_source) # 访问网页，然后打印出源代码，etree 解析为 xpath 可以操作的影视

    src_xpath = "//*[@class='item-root']/a/img/@src"


    title_xpath = "//*[@class='item-root']/div[@class='detail']/div[@class='title']/a/text()"


    srcs = html.xpath(src_xpath)


    titles = html.xpath(title_xpath)


    print(srcs)


    print(titles)


    for src, title in zip(srcs, titles):


        print('\t'.join([str(src),str(title)]))


        title = re.sub(u'\?', u' ', title)


        download(src, title)


driver.close()


2019-01-07


闫东汉

QUERY 框中的数据是如何得出的呢？

2019-01-06


wonderland


运行环境：jupyter

最喜欢的明星 - 宋慧乔，所以以宋慧乔为关键词抓取了她在豆瓣上图片，因为数量过多，所以程序里设置只抓取了 20 张，并且在最后通过其中的一张图片地址，对图片进行了显示操作。

代码如下：

# coding:utf-8


import requests


import json


query = ' 宋慧乔 '

#下载图片函数

def download(src, id):


           dir = './' + str(id) + '.jpg'


           try:


pic = requests.get (src, timeout=10)# 打开图片的 url，即打开图片网页

           except requests.exceptions.ConnectionError:


#print 'error, % d 当前图片无法下载 ', % id

print (' 图片无法下载 ')

fp = open (dir, 'wb')# 在当前打开网页下，打开对应 id 图片，并返回图片内容

           fp.write(pic.content)


fp.close ()# 打开操作进行关闭

 


for i in range(0, 21, 20):


           url = 'https://www.douban.com/j/search_photo?q='+query+'&limit=20&start='+str(i)


html = requests.get (url).text # 得到返回结果

response = json.loads (html,encoding='utf-8') # 将 JSON 格式转换成 Python 对象

for image in response ['images']:#images 是一个对象，是一个数组结构，有多张图片；数组中每个元素 image 是一个字典的形式，有 id，有 src 等

# print image ['src'] # 查看当前下载的图片网址

download (image ['src'], image ['id']) # 下载一张图片

print (image ['src']) #输出当前下载图片的网址

#显示图片操作

from PIL import Image


from io import BytesIO


img_src = 'https://img3.doubanio.com/view/photo/photo/public/p637434872.jpg'


res = requests.get (img_src)# 利用 request 请求图片的响应，并返回二进制数据

img = Image.open (BytesIO (res.content)) #利用 ByteSio 库进行二进制数据的读取

img.show()


print (' 图片显示 ')

2019-01-05


caidy


老师，课程的程勋运行一半会出现这样的错误

UnboundLocalError： local variable 'pic' referenced before assignment


作者回复：我更新了下代码，把 pic 放到 try 代码段里了。你可以再试下。遇到这种情况，就是不能正常下载图片，可以把 src 和 id 打印出来看下

2019-01-05


拉我吃

发送的请求 (request) URL 可以多种多样，类似 https://movie.douban.com/subject_search?search_text=% E7%8E%8B% E7% A5%96% E8% B4% A4&cat=1002&limit=15&start=0 这种的图片是 webp 格式，需要注意一下。

2019-01-05


Lin_嘉杰

第二个下载王祖贤电影封面的代码，需要改进

环境：Python3，window 系统

# coding: utf-8


from selenium import webdriver


from lxml import etree


import re


driver = webdriver.Chrome()


query = ' 王祖贤 '

def download(src, id):


dir = './images/wangzuxian/'+str(id)+'.jpg'


try:


pic = requests.get(src, timeout=10)


with open(dir, 'wb') as f:


f.write(pic.content)


except requests.exceptions.ConnectionError:


print (' 图片无法下载 ')

# 图片命名失败异常

except Exception as e:


print (' 下载图片失败 ')

if __name__ == '__main__':


for i in range(0, 6*15, 15):


request_url = 'https://movie.douban.com/subject_search?search_text='+query+'&cat=1002&start='+str(i)


driver.get(request_url)


html = etree.HTML(driver.page_source)


src_xpath = "//*[@class='item-root']/a/img/@src"


title_xpath = "//*[@class='item-root']/div[@class='detail']/div[@class='title']/a/text()"


srcs = html.xpath(src_xpath)


titles = html.xpath(title_xpath)


for src, title in zip(srcs, titles):


# print(src)


download(src, title)


2019-01-04


Chino


关于第二个王祖贤电影下载的海报 能够运行并爬下来了 但是还有一个问题 因为爬去的图片 src 都是 webp 格式的 一开始写的时候自然写成 jpg 发现打不开 才想起来 改成 webp 后 对于这种格式又不能直接预览 有没有什么办法能直接爬成 jpg 的呢

from selenium import webdriver


import requests


from lxml import etree


i = 0


def download(src):


    global i


    try:


        r = requests.get(src,timeout = 10)


    except requests.exceptions.ConnectionError:


        print('error')


    dl_dir = './pictest/' + str(i) + '.jpg'


    fp = open(dl_dir,'wb')


    fp.write(r.content)


    fp.close()


    i += 1


    


src_xpath = "//div[@class = 'item-root']/a[@class = 'cover-link']/img[@class = 'cover']"


request_url = 'https://movie.douban.com/subject_search?search_text=%E7%8E%8B%E7%A5%96%E8%B4%A4'


driver = webdriver.Chrome()


driver.get(request_url)


html = etree.HTML(driver.page_source)


pic_url = html.xpath(src_xpath)


for j in pic_url:


    download(j.get('src'))


作者回复：一种方法是你用 webdriver 来模拟 Firefox 浏览器

2019-01-04


王 慈

您好，我看到现在有那种类似按键精灵的 Selenium IDE，可以直接生成代码。您对这种软件怎么看呢？有了它是不是可以降低对 html XPath js 这些知识的掌握呢？

2019-01-04


Lin_嘉杰

老师，如果某网站上更新了内容，那怎样也顺便自动爬取内容？我想到的是线上爬取，思路是这样吗？

2019-01-04


Chino


driver = webdriver.Chrome()


为什么输入这个代码就会报错了呢

是因为在 mac 上的原因吗

作者回复：需要先下载 chromedrive，然后放到浏览器目录中，再把这个目录添加到配置环境变量 path 里

2019-01-04


JingZ


response = json.loads(html,encoding ='utf-8')


出现问题

raise JSONDecodeError("Expecting value", s, err.value) from None


JSONDecodeError: Expecting value


需要 debug 了

2019-01-04


SIXGOD


麻烦老师和各位大佬指点一下第二个的写法：

# coding:utf-8


import requests


import json


from selenium import webdriver


from lxml import etree


query = ' 王祖贤 '

''' 下载图片 '''

def download(src, id):


  dir = 'D:/douban-download/' + str(id) + '.webp'


  try:


    pic = requests.get(src, timeout=10)


  except requests.exceptions.ConnectionError:


#print 'error, % d 当前图片无法下载 ', % id

print (' 图片无法下载 ')

  fp = open(dir, 'wb')


  fp.write(pic.content)


  fp.close()


chrome_driver = "D:\download\chromedriver_win32\chromedriver.exe"


driver = webdriver.Chrome(executable_path=chrome_driver)


request_url = "https://movie.douban.com/subject_search?search_text="+query+"&cat=1002"


driver.get(request_url)


html = etree.HTML(driver.page_source)


src_xpath = "//div[@class='item-root']/a[@class='cover-link']/img[@class='cover']/@src"


title_path = "//div[@class='item-root']/div[@class='detail']/div[@class='title']/a[@class='title-text']"


srcs = html.xpath(src_xpath)


titles = html.xpath(title_path)


for src, title in zip(srcs, titles):


  print('\t'.join([str(src),str(title.text)]))


  download(src, title.text)


driver.close()


作者回复：方法是 OK 的，首先你指定了 chrome_driver 的路径，这样可以使用 WebDriver 在 chrome 上进行自动化测试。然后使用 xpath 提取了图片的链接及名称。最后编写了 download 函数来完成图片的下载，对于下载异常会进行报错。

2019-01-04


1e-43


老师好，可以专门做节课讲下 Xpath 吗，之前完全没接触过这方面

作者回复：找个时间，我会专门讲讲爬虫

2019-01-04


蜘蛛的梦呓

老师，我更想看「分析思维和分析技巧」方面的内容，后续会出吗？

作者回复：可以有

2019-01-04


林

#pip install selenium


#pip install chromedriver


之后代码中

driver = webdriver.Chrome()


driver.get(requestUrl)


发起请求，报 selenium.common.exceptions.WebDriverException: Message: unknown error: cannot find Chrome binary 错呢，啥情况？

作者回复：你可以查看下是否安装了 Chrome 浏览器，因为这个是自动化测试，会调用本地的 Chrome 浏览器

2019-01-04


收起评论




8793










