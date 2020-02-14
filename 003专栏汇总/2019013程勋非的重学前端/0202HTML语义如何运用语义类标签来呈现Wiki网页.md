# 0202. HTML 语义：如何运用语义类标签来呈现 Wiki 网页？

> winter 2019-01-24

你好，我是 winter，今天我们继续来聊聊 HTML 模块的语义类标签。

在上一篇文章中，我花了大量的篇幅和你解释了正确使用语义类标签的好处和一些场景。那么，哪些场景适合用到语义类标签呢，又如何运用语义类标签呢？

不知道你还记不记得在大学时代，你被导师逼着改毕业论文格式的情景，如果你回想一下，你在论文中使用的那些格式，你会发现其实它们都是可以用 HTML 里的语义标签来表示的。

这正是因为 HTML 最初的设计场景就是「超文本」，早期 HTML 工作组的专家都是出版界书籍排版的专家。

所以，在这一部分，我们找了个跟论文很像的案例：Wikipedia 文章，这种跟论文相似的网站比较适合用来学习语义类标签。通过分析一篇 Wiki 的文章用到的语义类标签，来进一步帮你理解语义的概念。

你可以在电脑上，打开这个页面：

https://en.wikipedia.org/wiki/World_Wide_Web

为了防止这个页面被修改，我们保存了一个副本：

[World Wide Web - Wikipedia](http://static001.geekbang.org/static/time/quote/World_Wide_Web-Wikipedia.html)

这是一篇我们选择的 Wiki 文章，虽然在原本的 Wikipedia 网站中，也是大量使用了 div 和 span 来完成功能。在这里，我们来尝试分析一下，应该如何用语义类标签来呈现这样的一个页面 / 文章。

我们看一下这个页面。

### aside

![](./res/2019013.png)

首先我们来看下，左侧侧边栏，根据上一篇文章中提到的语义定义，这里属于 aside 内容。是导航性质的工具内容。

### article

![](./res/2019014.png)

我们来到文章主体部分，因为主体部分具有明确的独立性，所以可以用 article 来包裹。

### hgroup, h1, h2

![](./res/2019015.png)

在语义的上一篇文章中，我们介绍过 hgroup 和 h1-h6 的作用，hgroup 是标题组，h1 是一级标题，h2 是二级标题。这里，World Wide Web 是文章的大标题，适合 h1 元素。

接下来出现了一个副标题。From Wikipedia, the free encyclopedia。这个地方适合使用 h2，跟 h1 组成一个 hgroup，所以代码可能是类似这样的：

```
<hgroup>
<h1>World Wide Web </h1>
<h2>From Wikipedia, the free encyclopedia</h2>
</hgroup>
```

### abbr

![](./res/2019016.png)

标签表示缩写。考虑到 WWW 是 World Wide Web 的缩写，所以文中所有出现的 WWW，都应该使用 abbr 标签。

### hr

![](./res/2019017.png)

细心的同学会发现，在 Wiki 的界面中，出现了一条很长的横线，大家都知道 hr 标签表示横向分隔线，那么这个地方是不是应该用 hr 呢？

答案是不用。我们读一下标准的定义就知道了，hr 表示故事走向的转变或者话题的转变，显然此处两个标题并非这种关系，所以我们应该使用 CSS 的 border 来把它当作纯视觉效果来实现，所以这里是不需要用 hr 的。

### p

![](./res/2019018.png)

接下来一段，我们看到了三段「note」，也就是注记。它在文章中用作额外注释。

```
“WWW” and “The Web” redirect here. For other uses of WWW, see 
WWW (disambiguation). For other uses of web, see Web 
(disambiguation).
For the first web software, see WorldWideWeb.
Not to be confused with the Internet.
```

HTML 中并没有 note 相关的语义，所以，我们用普通的 p 标签，加上 class="note" 来实现。后面的多数自然段都是普通的段落，我们用 p 标签来实现。

### strong

![](./res/2019019.png)

注意，这里「World Wide Web (WWW)」和「the Web」使用了黑体呈现，从上下文来看，这里表示这个词很重要，所以我们使用 strong 标签。

```
<p> 
A global map of the web index for countries in 2014
<strong>The World Wide Web (WWW)</strong>, also called <strong>the Web</strong>,
......
```

### blockquote, q, cite

![](./res/2019020.png)

接下来我们看到了一个论文中很常见的用法「引述」。

    interlinked by hypertext links, and accessible via the Internet.[1]

注意看这里的 [1]，当我们把鼠标放上去的时候，出现了引述的相关信息：

    「What is the difference between the Web and the Internet?」. W3C Help and FAQ. W3C. 2009. Archived from the original on 9 July 2015. Retrieved 16 July 2015.

在 HTML 中，有三个跟引述相关的标签，blockquote 表示段落级引述内容，q 表示行内的引述内容，cite 表示引述的作品名。

这里的作品名称「What is the difference between the Web and the Internet?」，应当使用 cite 标签。

![](./res/2019021.png)

```
<cite>"What is the difference between the Web and the Internet?"</cite>. W3C Help and FAQ. W3C. 2009. Archived from the original on 9 July 2015. Retrieved 16 July 2015.
```

在文章的结尾处，有对应的 References 一节，这一节中所有的作品名称也应该加入 cite 标签。

这里我们看看引用的原文就可以知道，Wiki 文章中的信息并非直接引用，如果是直接引用的内容，那么，我们还应该加上 blockquote 或者 q 标签。

### time

![](./res/2019022.png)

这里除了引用的文章外，还出现了日期，为了让机器阅读更加方便，可以加上 time 标签：

    <cite>"What is the difference between the Web and the Internet?"</cite>. W3C Help and FAQ. W3C. 2009. Archived from the original on <time datetime="2015-07-09">9 July 2015</time>. Retrieved <time datetime="2015-07-16">16 July 2015</time>.

### figure, figcaption

![](./res/2019023.png)

我们注意一下文章的右侧，出现了几张图片，这种出现在文中的图片，不仅仅是一个 img 标签，它和下面的文字组成了一个 figure 的语法现象，figure 也是我们的一种标签（用于表示与主文章相关的图像、照片等流内容）。

```
<figure>
 <img src="https://.....440px-NeXTcube_first_webserver.JPG"/>
 <figcaption>The NeXT Computer used by Tim Berners-Lee at CERN.</figcaption>
</figure>
```


这种插入文章中的内容，不仅限图片，代码、表格等，只要是具有一定自包含性（类似独立句子）的内容，都可以用 figure。这里面，我们用 figcaption 表示内容的标题，当然，也可以没有标题。

### dfn

![](./res/2019024.png)

然后我们继续往下看，来注意这一句：

The terms Internet and World Wide Web are often used without much distinction. However, the two are not the same. The Internet is a global system of interconnected computer networks. In contrast, the World Wide Web is a global collection of documents and other resources, linked by hyperlinks and URIs.

这里分别定义了 Internet 和 World Wide Web，我们应该使用 dfn 标签。

```
The terms Internet and World Wide Web are often used without much distinction. However, the two are not the same. 
The <dfn>Internet</dfn> is a global system of interconnected computer networks.
In contrast, the <dfn>World Wide Web</dfn> is a global collection of documents and other resources, linked by hyperlinks and URIs. 

```

代码中你可以看见，你需要在你要定义的词前后放上 dfn 标签，所以我们知道了，dfn 标签是用来包裹被定义的名词。

### nav, ol, ul

![](./res/2019025.png)

接下来，几个普通的段落之后，我们看到了文章的目录。这里的目录链接到文章的各个章节，我们可以使用 nav 标签。因为这里的目录顺序不可随意变化，所以我们这里使用多级的 ol 结构。

```
<nav>
  <h2>Contents</h2>
  <ol>
    <li><a href="...">History</a></li>
    <li><a href="...">Function</a>
      <ol>
        <li><a href="...">Linking</a></li>
        <li><a href="...">Dynamic updates of web pages</a></li>
        ...
      </ol>
    </li>
    ...
  </ol>
</nav>
```

我们这里必须要指出，ol 和 ul 的区分是内容是否有顺序关系，每一项的前面不论是数字还是点，都不会影响语义的判断。所以，你可以注意一下这里，不要因为视觉表现效果，而改变语义的使用。

### pre, samp, code

![](./res/2019026.png)

继续往下，我们来到了这里，我们看见这篇文章有一个很重要的特色，文章中嵌入了一些代码和一些预先编写好的段落。我们看到在「Function」小节中有一段背景色是灰色的文字。

```
GET /home.html HTTP/1.1
Host: www.example.org
```

这是一段 HTTP 协议的内容描述，因为这段内容的换行是非常严格的，所以我们不需要浏览器帮我们做自动换行，因此我们使用了 pre 标签，表示这部分内容是预先排版过的，不需要浏览器进行排版。

又因为这是一段计算机程序的示例输出，所以我们可以使用 samp 标签：

```
<pre><samp>
GET /home.html HTTP/1.1
Host: www.example.org
</samp></pre>
```

接下来 Wiki 中的内容出现了一段 HTML 代码，我们同样不希望浏览器做自动换行。

```
<html>
  <head>
    <title>Example.org – The World Wide Web</title>
  </head>
  <body>
    <p>The World Wide Web, abbreviated as WWW and commonly known ...</p>
  </body>
</html>
```

在后面的代码中，还有一些在行内的 code，比如 title 和 p 括起来的内容，这些也都应该使用 code 标签。

## 总结

![](./res/2019027.png)

在这一篇 Wiki 文章中，已经涉及了大部分语义标签，可见 HTML 工作组对语义标签的增加是非常谨慎和保守的。

当然了，我们选择的案例不可能刚巧覆盖所有的标签，还有些没讲到的标签，我们这里稍微做一下简要的补充说明。

实际上，HTML 这种语言，并不像严谨的编程语言一样，有一条非此即彼的线。一些语义的使用其实会带来争议，所以我的建议是：你可以尽量只用自己熟悉的语义标签，并且只在有把握的场景引入语义标签。这样，我们才能保证语义标签不被滥用，造成更多的问题。

你最擅长使用哪些语义标签，会把它们用在哪些场景里呢？

## 精选留言

### 01

就擅长 div span a 标签。

进入 wiki 点开控制台，发现很多地方 wiki 本身并没有严格地按照 win 大说的来，大部分也是 did, span 一把梭，有顺序的 nav 直接用的 ul, 文中说的 code, sample 这些也都没有用。是不是可以理解成其实很多时候我们为了实现样式的完全控制，降低了对 HTML 本身语义化的要求； 或者说在大部分条件下，快速还原设计稿比语义化本身更重要。

2019-01-26

### 02

由于项目的关系，大部分时候是制作品牌网站和软件界面的场景，因此我最擅长的语义标签是「作为整体结构」的语义类标签。在这两个场景中，一般不会有大段的阅读文字（即使是 FAQ，也避免大段文字，毕竟没人喜欢读字）。深度了解语义类标签使用的一个技巧，就是去了解爬虫是如何理解自己的网站，从而逆向理解标签是否使用得当。这篇文章最大的收获，就是认识到自己对「自然语言延伸」和「标题摘要」的语义类标签理解不足。比如 pre 和 samp，让我有「居然是这样使用」的感觉。现在知道，如果遇到内容网站的场景（比如博客），我就应该复习一次「自然语言延伸」和「标题摘要」的语义类标签文档，确保正确使用。

2019-01-24



