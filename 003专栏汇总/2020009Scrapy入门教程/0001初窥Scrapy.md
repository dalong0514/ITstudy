# 0001. 初窥 Scrapy

[Scrapy 1.0 文档 — Scrapy 1.0.5 文档](https://scrapy-chs.readthedocs.io/zh_CN/1.0/index.html#)

Scrapy 是一个为了爬取网站数据，提取结构性数据而编写的应用框架。可以应用在包括数据挖掘，信息处理或存储历史数据等一系列的程序中。

其最初是为了 网络抓取 所设计的，也可以应用在获取 API 所返回的数据 (例如 Amazon Associates Web Services) 或者通用的网络爬虫。

一窥示例 spider

为了让您了解 Scrapy 提供了什么功能，我们将提供一个 Scrapy Spider 的示例，并且以最简单的方式启动该 spider。

以下的代码将跟进 StackOverflow 上具有投票数最多的链接，并且爬取其中的一些数据:

import scrapy


class StackOverflowSpider(scrapy.Spider):


    name = 'stackoverflow'


    start_urls = ['http://stackoverflow.com/questions?sort=votes']


    def parse(self, response):


        for href in response.css('.question-summary h3 a::attr(href)'):


            full_url = response.urljoin(href.extract())


            yield scrapy.Request(full_url, callback=self.parse_question)


    def parse_question(self, response):


        yield {


            'title': response.css('h1 a::text').extract()[0],


            'votes': response.css('.question .vote-count-post::text').extract()[0],


            'body': response.css('.question .post-text').extract()[0],


            'tags': response.css('.question .post-tag::text').extract(),


            'link': response.url,


        }


将上述代码存入到某个文件中，以类似于 stackoverflow_spider.py 命名，并且使用 runspider 命令运行:

scrapy runspider stackoverflow_spider.py -o top-stackoverflow-questions.json


当命令执行完后，您将会得到 top-stackoverflow-questions.json 文件。该文件以 JSON 格式保存了 StackOverflow 上获得 upvote 最多的问题，包含了标题、链接、upvote 的数目、相关的 tags 以及以 HTML 格式保存的问题内容，看起来类似于这样 (为了更容易阅读，对内容进行重新排版):

[{


    "body": "... LONG HTML HERE ...",


    "link": "http://stackoverflow.com/questions/11227809/why-is-processing-a-sorted-array-faster-than-an-unsorted-array",


    "tags": ["java", "c++", "performance", "optimization"],


    "title": "Why is processing a sorted array faster than an unsorted array?",


    "votes": "9924"


},


{


    "body": "... LONG HTML HERE ...",


    "link": "http://stackoverflow.com/questions/1260748/how-do-i-remove-a-git-submodule",


    "tags": ["git", "git-submodules"],


    "title": "How do I remove a Git submodule?",


    "votes": "1764"


},


...]


刚刚发生了什么？

当您运行 scrapy runspider somefile.py 命令时，Scrapy 尝试从该文件中查找 Spider 的定义，并且在爬取引擎中运行它。

Scrapy 首先读取定义在 start_urls 属性中的 URL (在本示例中，就是 StackOverflow 的 top question 页面的 URL)，创建请求，并且将接收到的 response 作为参数调用默认的回调函数 parse ，来启动爬取。在回调函数 parse 中，我们使用 CSS Selector 来提取链接。接着，我们产生 (yield) 更多的请求，注册 parse_question 作为这些请求完成时的回调函数。

这里，您可以注意到 Scrapy 的一个最主要的优势：请求 (request) 是 被异步调度和处理的 。这意味着，Scrapy 并不需要等待一个请求 (request) 完成及处理，在此同时，也发送其他请求或者做些其他事情。这也意味着，当有些请求失败或者处理过程中出现错误时，其他的请求也能继续处理。

在允许您可以以非常快的速度进行爬取时 (以容忍错误的方式同时发送多个 request), Scrapy 也通过 一些设置 来允许您控制其爬取的方式。例如，您可以为两个 request 之间设置下载延迟，限制单域名 (domain) 或单个 IP 的并发请求量，甚至可以 使用自动限制插件 来自动处理这些问题。

最终，parse_question 回调函数从每个页面中爬取到问题 (question) 的数据并产生了一个 dict，Scrapy 收集并按照终端 (command line) 的要求将这些结果写入到了 JSON 文件中。

注解

这里使用了 feed exports 来创建了 JSON 文件，您可以很容易的改变导出的格式 (比如 XML 或 CSV) 或者存储后端 (例如 FTP 或者 Amazon S3)。您也可以编写 item pipeline 来将 item 存储到数据库中。

还有什么？

您已经了解了如何通过 Scrapy 提取存储网页中的信息，但这仅仅只是冰山一角。Scrapy 提供了很多强大的特性来使得爬取更为简单高效，例如:

对 HTML, XML 源数据 选择及提取 的内置支持，提供了 CSS 选择器 (selector) 以及 XPath 表达式进行处理，以及一些帮助函数 (helper method) 来使用正则表达式来提取数据.

提供 交互式 shell 终端，为您测试 CSS 及 XPath 表达式，编写和调试爬虫提供了极大的方便

通过 feed 导出 提供了多格式 (JSON、CSV、XML)，多存储后端 (FTP、S3、本地文件系统) 的内置支持

提供了一系列在 spider 之间共享的可复用的过滤器 (即 Item Loaders)，对智能处理爬取数据提供了内置支持。

针对非英语语系中不标准或者错误的编码声明，提供了自动检测以及健壮的编码支持。

高扩展性。您可以通过使用 signals ，设计好的 API (中间件，extensions, pipelines) 来定制实现您的功能。

内置的中间件及扩展为下列功能提供了支持: * cookies and session 处理 * HTTP 压缩 * HTTP 认证 * HTTP 缓存 * user-agent 模拟 * robots.txt * 爬取深度限制 * 其他

内置 Telnet 终端 ，通过在 Scrapy 进程中钩入 Python 终端，使您可以查看并且调试爬虫

以及其他一些特性，例如可重用的，从 Sitemaps 及 XML/CSV feeds 中爬取网站的爬虫、 可以 自动下载 爬取到的数据中的图片 (或者其他资源) 的 media pipeline、 带缓存的 DNS 解析器，以及更多的特性。

接下来

下一步当然是 下载 Scrapy 了，您可以阅读 入门教程 并加入 社区 。感谢您的支持！

