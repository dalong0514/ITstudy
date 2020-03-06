# 0201. 基础介绍

[介绍 - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Introduction)

## 01. 你应该已经掌握哪些知识？

我们假设你已经掌握了以下基础技能：

1. 对互联网和万维网（WWW）有基本的认识。

2. 熟悉超文本标记语言（HTML）。

3. 一些编程经验。如果您初识编程，请先试着看看主页列出的有关 JavaScript 的教程。

## 02. 去哪里获取有关 JavaScript 的信息？

MDN 上的 JavaScript 文档包括以下内容：

1. 认识 Web 为初学者提供信息，并介绍一些关于编程和互联网的基本概念。[学习 Web 开发 | MDN](https://developer.mozilla.org/zh-CN/docs/learn)

2. JavaScript 入门 （即本教程）提供 JavaScript 这门语言及其目标的概述。[介绍 - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Introduction)

3. JavaScript 参考 提供关于 JavaScript 的详细参考资料。[JavaScript 参考 - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference)

如果你刚开始学习 JavaScript，请详细阅读学习区（Learning area） 和 JavaScript 入门的文章。如果你已经掌握了 JavaScript 基础知识，你可以通过 JavaScript 参考来了解更多关于单个（individual）对象和语句的细节。

## 03. 什么是 JavaScript?

JavaScript 是一门跨平台、面向对象的脚本语言，它能使网页可交互（例如拥有复杂的动画，可点击的按钮，通俗的菜单等）。另外还有高级的服务端 Javascript 版本，例如 Node.js，它可以让你在网页上添加更多功能，不仅仅是下载文件（例如在多台电脑之间的协同合作）。在宿主环境（例如 web 浏览器）中，JavaScript 能够通过其所连接的环境提供的编程接口进行控制。

JavaScript 内置了一些对象的标准库，比如数组（Array），日期（Date），数学（Math）和一套核心语句，包括运算符、流程控制符以及声明方式等。JavaScript 的核心部分可以通过添加对象来扩展语言以适应不同用途；例如：

1. 客户端的 JavaScript 通过提供对象，控制浏览器及其文档对象模型（DOM），来扩展语言核心。例如：客户端的拓展代码允许应用程序将元素放在某个 HTML 表单中，并且支持响应用户事件，比如鼠标点击、表单提交和页面导航。

2. 服务端的 JavaScript 则通过提供有关在服务器上运行 JavaScript 的对象来可扩展语言核心。例如：服务端版本直接支持应用和数据库通信，提供应用不同调用间的信息连续性，或者在服务器上执行文件操作。

这意味着，在浏览器中，JavaScript 可以改变网页（DOM）的外观与样式。同样地，在服务器上，Node.js 中的 JavaScript 可以对浏览器上编写的代码发出的客户端请求做出响应。

## 04. JavaScript 和 Java

JavaScript 和 Java 有一些共性但是在另一些方面有着根本性区别。JavaScript 语言类似 Java 但是并没有 Java 的静态类型和强类型检查特性。JavaScript 遵循了 Java 的表达式语法，命名规范以及基础流程控制，这也是 JavaScript 从 LiveScript 更名的原因。

与 Java 通过声明的方式构建类的编译时系统不同，JavaScript 采用基于少量的数据类型如数字、布尔、字符串值的运行时系统。JavaScript 拥有基于原型的对象模型提供的动态继承；也就是说，独立对象的继承是可以改变的。JavaScript 支持匿名函数。函数也可以作为对象的属性被当做宽松的类型方式执行。

与 Java 相比，Javascript 是一门形式自由的语言。你不必声明所有的变量，类和方法。你不必关心方法是否是共有、私有或者受保护的，也不需要实现接口。无需显式指定变量、参数、方法返回值的数据类型。

Java 是基于类的编程语言，设计的初衷就是为了确保快速执行和类型安全。类型安全，举个例子，你不能将一个 Java 整数变量转化为一个对象引用，或者由 Java 字节码访问专有存储器。Java 基于类的模型，意味着程序包含专有的类及其方法。Java 的类继承和强类型要求紧耦合的对象层级结构。这些要求使得 Java 编程比 JavaScript 要复杂的多。

相比之下，JavaScript 传承了 HyperTalk 和 dBASE 语句精简、动态类型等精髓，这些脚本语言为更多开发者提供了一种语法简单、内置功能强大以及用最小需求创建对象的编程工具。

JavaScript 和 Java 的对比。JavaScript：1）面向对象。不区分对象类型。通过原型机制继承，任何对象的属性和方法均可以被动态添加。2）变量类型不需要提前声明（动态类型）。3）不能直接自动写入硬盘。Java：1）基于类系统。分为类和实例，通过类层级的定义实现继承。不能动态增加对象或类的属性或方法。2）变量类型必须提前声明（动态类型）。3）可以直接自动写入硬盘。

## 05. JavaScript 和 ECMAScript 规范

JavaScript 的标准化组织是 ECMA —— 这个欧洲信息与通信系统标准化协会提供基于 Javascript 的标准化方案（ECMA 原先是欧洲计算机制造商协会的首字母缩写）。这种标准化版本的 JavaScript 被称作 ECMAScript，在所有支持该标准的应用中以相同的方式工作。公司可以使用开放标准语言来开发他们自己的 JavaScript 实现版本。ECMAScript 标准在 ECMA－262 规范中进行文档化。参照 JavaScript 的新特性（[New in JavaScript - JavaScript | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/New_in_JavaScript)）以便学习更多关于不同版本的 JavaScript 和 ECMAScript 规范版本。

ECMA-262 标准也通过了 国际标准化组织（ISO）的 ISO-16262。你可以在这里找到该规范文件。ECMAScript 规范并没有描述文档对象模型（DOM），该模型由 万维网联盟（W3C） 制定。DOM 定义了 HTML 文件对象被脚本操作的方法。为了更清楚地了解当使用 JavaScript 编程时用到的不同技术，请参阅 [JavaScript 技术概览 - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/JavaScript_technologies_overview)。

### JavaScript 文献 和 ECMAScript 规范

ECMAScript 规范是实现 ECMAScript 的一组需求；如果您想在 ECMAScript 实现或引擎 (如 Firefox 中的 SpiderMonkey 或 Chrome 中的 V8) 中实现符合标准的语言特性，那么它是非常有用的。

ECMAScript 文档不是用来帮助脚本程序员的；使用 JavaScript 文档获取关于编写脚本的信息。

ECMAScript 规范使用了 JavaScript 程序员可能不熟悉的术语和语法。尽管 ECMAScript 中对语言的描述可能有所不同，但语言本身保持不变。JavaScript 支持 ECMAScript 规范中列出的所有功能。

JavaScript 文档描述了适合 JavaScript 程序员的语言方面。

## 06. JavaScript 入门

开始使用 JavaScript 很容易，你只需要一个现代 Web 浏览器。这篇教程包含了一些只在最新版本的火狐浏览器上才有的功能，所以建议大家使用最新版本的火狐浏览器。

火狐内置了两款非常棒的工具用来实验 JavaScript：浏览器控制台和代码草稿纸。

### Web 控制台（Web Console）

Web 控制台 不仅可以展示当前已加载页面的信息，还包含一个可以在当前页面执行 Javascript 表达式的 命令行。

在火狐浏览器菜单栏的「工具 "=>"Web 开发者 "=>"Web 控制台 " 可以打开控制台 (在 Windows 和 Linux 上 Ctrl+Shift+K ，Mac 上 Cmd+Option+K) ，它会如期出现在浏览器窗口的底部。如图，最下一行就是可以执行输入的命令行，面板上可以显示执行结果：

控制台的工作方式与 eval 完全相同：返回最后输入的表达式。为了简单起见，可以想象每次输入到控制台的东西实际上都被 console.log 所包围。

function greetMe(yourName) { alert('Hello ' + yourName); } console.log(eval('3 + 5'));

### 代码草稿纸（Scratchpad）

Web 控制台对于执行单行 JS 命令十分便捷，虽然你也可以执行多行命令，但是在控制台操作并不方便。除此之外，使用控制台你无法保存你的代码片段。因此对于更为复杂的代码片段，Scratchpad（代码草稿纸） 是一个更好的工具。

从「Web 开发者」菜单（在火狐浏览器的主菜单下）中选择「代码草稿纸」来打开（Shift+F4）。它是一个拥有独立窗口的编辑器，你可以用来编辑和在浏览器中执行 JavaScript。你也可以将代码保存到本地磁盘，或者从本地载入。

如果你选择显示，草稿纸中的代码会在浏览器中执行，并在内容后面以注释的形式插入返回的结果：

### Hello world

学习 JavaScript 的第一步，打开浏览器的代码草稿纸尝试编写你的第一个 JavaScript 版本的「Hello world」程序。

```
function greetMe(user) {
  alert('Hi ' + user);
}

greetMe('Alice'); // 'Hi Alice'
```

在 Scratchpad（代码草稿纸）中选择要执行的代码，然后点击「运行」（Ctrl+R）就可以在浏览器中看到选中代码的执行结果。

在接下来的章节里，该指南将介绍 JavaScript 的语法以及语言特性，届时你将可以使用它编写更加复杂的程序。