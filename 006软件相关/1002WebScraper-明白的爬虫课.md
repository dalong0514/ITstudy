# 0201明白的爬虫课

[简易数据分析 07 | Web Scraper 抓取多条内容 - 知乎](https://zhuanlan.zhihu.com/p/75054559)

[Web Scraper 翻页——控制链接批量抓取数据（Web Scraper 高级用法）| 简易数据分析 05 - 卤代烃实验室 - 博客园](https://www.cnblogs.com/web-scraper/p/web_scraper_douban_top250_movie.html)

## 01. 软件安装及配置相关

Chrome 左上角应用商城里下载 WebScraper 插件。

1、快捷键 option+cammand+I 打开 WebScraper 界面。

2、右上角，点 x 左边的三个小点展开，将 Dock side 改成 WebScraper 在浏览器下面。

## 02. 使用

WebScraper 的选择器。

抓取文字，用文本选择器「Text selector」。

抓取超链接，需要用 link。

抓取图片，用「Images selector」。

爬虫的通用步骤：

1. 创建 sitemap；

2. 添加 selector「核心」；

3. 开始抓取；

4. 导出到本地电脑；

### 1. 创建 sitemap

WebScraper 界面里，最后一个 Web Scraper 界面。第三个 Create new sitemap 展开 Create Sitemap 。

Sitemap name，自定义，最好取有意义的名字，比如这次就填的「zhangjiawei」。Sitemap 的命名规则：至少 3 个字符，必须以字母开头，剩下的都行，可以包含数字，下划线，$ 符之类的。

Start URL 里输入完网址。

创建 sitemap。

### 2. 添加 selector「核心」

接着点「add new selector」按钮。

进「Sitemap zhangjiawei」界面里；ID 是自定义填，比如这次抓题目就填「title」；类型 type 选 text；点 selector 里的 select 会出现一个悬浮框；利用悬浮框来选标题，选前面的 2 个标题，后面的自动全变红选上了；抓取多条信息的话就勾选 Multiple；Delay (ms)一般填 500-5000 之间。

点「save selector」。

### 3. 开始抓取

「Sitemap zhangjiawei」界面展开选 scrape；Request interval (ms) 就按默认的 2000 ms，太小明显不是人为的会被封 IP 的；Page load delay (ms) 还是填 500；接着点开始抓取。

导出到本地电脑；

「Sitemap zhangjiawei」界面展开选 Export data as CSV；点下载。

上面的只是演示抓取单页页面的内容的。
