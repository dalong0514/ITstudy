另一个属性是 defaultCharset，表示根据默认浏览器及操作系统的设置，当前文档默认的字符集应该是什么。如果文档没有使用默认的字符集，那 charset 和 defaultCharset 属性的值可能会不一样，例如：

if (document.charset != document.defaultCharset){ alert("Custom character set being used."); }

通过这两个属性可以得到文档使用的字符编码的具体信息，也能对字符编码进行准确地控制。运行适当的情况下，可以保证用户正常查看页面或使用应用。

支持 document.charset 属性的浏览器有 IE、Firefox、Safari、Opera 和 Chrome。支持 document.defaultCharset 属性的浏览器有 IE、Safari 和 Chrome。

11.3.5　自定义数据属性

HTML5 规定可以为元素添加非标准的属性，但要添加前缀 data-，目的是为元素提供与渲染无关的信息，或者提供语义信息。这些属性可以任意添加、随便命名，只要以 data - 开头即可。来看一个例子。

<div id="myDiv" data-appId="12345" data-myname="Nicholas"></div>

添加了自定义属性之后，可以通过元素的 dataset 属性来访问自定义属性的值。dataset 属性的值是 DOMStringMap 的一个实例，也就是一个名值对儿的映射。在这个映射中，每个 data-name 形式的属性都会有一个对应的属性，只不过属性名没有 data - 前缀（比如，自定义属性是 data-myname，那映射中对应的属性就是 myname）。还是看一个例子吧。

// 本例中使用的方法仅用于演示 var div = document.getElementById ("myDiv"); // 取得自定义属性的值 var appId = div.dataset.appId; var myName = div.dataset.myname; // 设置值 div.dataset.appId = 23456; div.dataset.myname = "Michael"; // 有没有 "myname" 值呢？ if (div.dataset.myname){alert ("Hello," + div.dataset.myname); }

如果需要给元素添加一些不可见的数据以便进行其他处理，那就要用到自定义数据属性。在跟踪链接或混搭应用中，通过自定义数据属性能方便地知道点击来自页面中的哪个部分。

在编写本书时，支持自定义数据属性的浏览器有 Firefox 6 + 和 Chrome。

11.3.6　插入标记

虽然 DOM 为操作节点提供了细致入微的控制手段，但在需要给文档插入大量新 HTML 标记的情况下，通过 DOM 操作仍然非常麻烦，因为不仅要创建一系列 DOM 节点，而且还要小心地按照正确的顺序把它们连接起来。相对而言，使用插入标记的技术，直接插入 HTML 字符串不仅更简单，速度也更快。以下与插入标记相关的 DOM 扩展已经纳入了 HTML5 规范。

1. innerHTML 属性

在读模式下，innerHTML 属性返回与调用元素的所有子节点（包括元素、注释和文本节点）对应的 HTML 标记。在写模式下，innerHTML 会根据指定的值创建新的 DOM 树，然后用这个 DOM 树完全替换调用元素原先的所有子节点。下面是一个例子。

<div id="content"> <p>This is a <strong>paragraph</strong> with a list following it.</p> <ul> <li>Item 1</li> <li>Item 2</li> <li>Item 3</li> </ul> </div>

对于上面的 <div> 元素来说，它的 innerHTML 属性会返回如下字符串。

<p>This is a <strong>paragraph</strong> with a list following it.</p> <ul> <li>Item 1</li> <li>Item 2</li> <li>Item 3</li> </ul>

但是，不同浏览器返回的文本格式会有所不同。IE 和 Opera 会将所有标签转换为大写形式，而 Safari、Chrome 和 Firefox 则会原原本本地按照原先文档中（或指定这些标签时）的格式返回 HTML，包括空格和缩进。不要指望所有浏览器返回的 innerHTML 值完全相同。

在写模式下，innerHTML 的值会被解析为 DOM 子树，替换调用元素原来的所有子节点。因为它的值被认为是 HTML，所以其中的所有标签都会按照浏览器处理 HTML 的标准方式转换为元素（同样，这里的转换结果也因浏览器而异）。如果设置的值仅是文本而没有 HTML 标签，那么结果就是设置纯文本，如下所示。

div.innerHTML = "Hello world!";

为 innerHTML 设置的包含 HTML 的字符串值与解析后 innerHTML 的值大不相同。来看下面的例子。

div.innerHTML = "Hello & welcome, <b>\"reader\"!</b>";

以上操作得到的结果如下：

<div id="content">Hello &amp; welcome, <b>&quot;reader&quot;!</b></div>

设置了 innerHTML 之后，可以像访问文档中的其他节点一样访问新创建的节点。

为 innerHTML 设置 HTML 字符串后，浏览器会将这个字符串解析为相应的 DOM 树。因此设置了 innerHTML 之后，再从中读取 HTML 字符串，会得到与设置时不一样的结果。原因在于返回的字符串是根据原始 HTML 字符串创建的 DOM 树经过序列化之后的结果。

使用 innerHTML 属性也有一些限制。比如，在大多数浏览器中，通过 innerHTML 插入 <script> 元素并不会执行其中的脚本。IE8 及更早版本是唯一能在这种情况下执行脚本的浏览器，但必须满足一些条件。一是必须为 <script> 元素指定 defer 属性，二是 <script> 元素必须位于（微软所谓的）「有作用域的元素」（scoped element）之后。<script> 元素被认为是「无作用域的元素」（NoScope element），也就是在页面中看不到的元素，与 <style> 元素或注释类似。如果通过 innerHTML 插入的字符串开头就是一个「无作用域的元素」，那么 IE 会在解析这个字符串前先删除该元素。换句话说，以下代码达不到目的：

div.innerHTML = "<script defer>alert ('hi');<\/script>"; // 无效

此时，innerHTML 字符串一开始（而且整个）就是一个「无作用域的元素」，所以这个字符串会变成空字符串。如果想插入这段脚本，必须在前面添加一个「有作用域的元素」，可以是一个文本节点，也可以是一个没有结束标签的元素如 <input>。例如，下面这几行代码都可以正常执行：

div.innerHTML = "_<script defer>alert('hi');<\/script>"; div.innerHTML = "<div>&nbsp;</div><script defer>alert('hi');<\/script>"; div.innerHTML = "<input type=\"hidden\"><script defer>alert('hi');<\/script>";

第一行代码会在 <script> 元素前插入一个文本节点。事后，为了不影响页面显示，你可能需要移除这个文本节点。第二行代码采用的方法类似，只不过使用的是一个包含非换行空格的 <div> 元素。如果仅仅插入一个空的 <div> 元素，还是不行；必须要包含一点儿内容，浏览器才会创建文本节点。同样，为了不影响页面布局，恐怕还得移除这个节点。第三行代码使用的是一个隐藏的 <input> 域，也能达到相同的效果。不过，由于隐藏的 <input> 域不影响页面布局，因此这种方式在大多数情况下都是首选。

大多数浏览器都支持以直观的方式通过 innerHTML 插入 <style> 元素，例如：

div.innerHTML = "<style type=\"text/css\">body {background-color: red; }</style>";

但在 IE8 及更早版本中，<style> 也是一个「没有作用域的元素」，因此必须像下面这样给它前置一个「有作用域的元素」：

div.innerHTML = "_<style type=\"text/css\">body {background-color: red; }</style>"; div.removeChild(div.firstChild);

并不是所有元素都支持 innerHTML 属性。不支持 innerHTML 的元素有：<col>、<colgroup>、<frameset>、<head>、<html>、<style>、<table>、<tbody>、<thead>、<tfoot> 和 <tr>。此外，在 IE8 及更早版本中，<title> 元素也没有 innerHTML 属性。

Firefox 对在内容类型为 application/xhtml+xml 的 XHTML 文档中设置 innerHTML 有严格的限制。在 XHTML 文档中使用 innerHTML 时，XHTML 代码必须完全符合要求。如果代码格式不正确，设置 innerHTML 将会静默地失败。

无论什么时候，只要使用 innerHTML 从外部插入 HTML，都应该首先以可靠的方式处理 HTML。IE8 为此提供了 window.toStaticHTML () 方法，这个方法接收一个参数，即一个 HTML 字符串；返回一个经过无害处理后的版本 —— 从源 HTML 中删除所有脚本节点和事件处理程序属性。下面就是一个例子：

var text = "<a href=\"#\" onclick=\"alert('hi')\">Click Me</a>"; var sanitized = window.toStaticHTML(text); //Internet Explorer 8 only alert(sanitized); //"<a href=\"#\">Click Me</a>"

这个例子将一个 HTML 链接字符串传给了 toStaticHTML () 方法，得到的无害版本中去掉了 onclick 属性。虽然目前只有 IE8 原生支持这个方法，但我们还是建议读者在通过 innerHTML 插入代码之前，尽可能先手工检查一下其中的文本内容。

2. outerHTML 属性

在读模式下，outerHTML 返回调用它的元素及所有子节点的 HTML 标签。在写模式下，outerHTML 会根据指定的 HTML 字符串创建新的 DOM 子树，然后用这个 DOM 子树完全替换调用元素。下面是一个例子。

<div id="content"> <p>This is a <strong>paragraph</strong> with a list following it.</p> <ul> <li>Item 1</li> <li>Item 2</li> <li>Item 3</li> </ul> </div>

OuterHTMLExample01.htm

如果在 <div> 元素上调用 outerHTML，会返回与上面相同的代码，包括 <div> 本身。不过，由于浏览器解析和解释 HTML 标记的不同，结果也可能会有所不同。（这里的不同与使用 innerHTML 属性时存在的差异性质是一样的。）

使用 outerHTML 属性以下面这种方式设置值：

div.outerHTML = "<p>This is a paragraph.</p>";

这行代码完成的操作与下面这些 DOM 脚本代码一样：

var p = document.createElement("p"); p.appendChild(document.createTextNode("This is a paragraph.")); div.parentNode.replaceChild(p, div);

结果，就是新创建的 <p> 元素会取代 DOM 树中的 <div> 元素。

支持 outerHTML 属性的浏览器有 IE4+、Safari 4+、Chrome 和 Opera 8+。Firefox 7 及之前版本都不支持 outerHTML 属性。

3. insertAdjacentHTML () 方法

插入标记的最后一个新增方式是 insertAdjacentHTML () 方法。这个方法最早也是在 IE 中出现的，它接收两个参数：插入位置和要插入的 HTML 文本。第一个参数必须是下列值之一：

"beforebegin"，在当前元素之前插入一个紧邻的同辈元素；

"afterbegin"，在当前元素之下插入一个新的子元素或在第一个子元素之前再插入新的子元素；

"beforeend"，在当前元素之下插入一个新的子元素或在最后一个子元素之后再插入新的子元素；

"afterend"，在当前元素之后插入一个紧邻的同辈元素。

注意，这些值都必须是小写形式。第二个参数是一个 HTML 字符串（与 innerHTML 和 outerHTML 的值相同），如果浏览器无法解析该字符串，就会抛出错误。以下是这个方法的基本用法示例。

// 作为前一个同辈元素插入 element.insertAdjacentHTML ("beforebegin", "<p>Hello world!</p>"); // 作为第一个子元素插入 element.insertAdjacentHTML ("afterbegin", "<p>Hello world!</p>"); // 作为最后一个子元素插入 element.insertAdjacentHTML ("beforeend", "<p>Hello world!</p>"); // 作为后一个同辈元素插入 element.insertAdjacentHTML ("afterend", "<p>Hello world!</p>");

支持 insertAdjacentHTML () 方法的浏览器有 IE、Firefox 8+、Safari、Opera 和 Chrome。

4. 内存与性能问题

使用本节介绍的方法替换子节点可能会导致浏览器的内存占用问题，尤其是在 IE 中，问题更加明显。在删除带有事件处理程序或引用了其他 JavaScript 对象子树时，就有可能导致内存占用问题。假设某个元素有一个事件处理程序（或者引用了一个 JavaScript 对象作为属性），在使用前述某个属性将该元素从文档树中删除后，元素与事件处理程序（或 JavaScript 对象）之间的绑定关系在内存中并没有一并删除。如果这种情况频繁出现，页面占用的内存数量就会明显增加。因此，在使用 innerHTML、outerHTML 属性和 insertAdjacentHTML () 方法时，最好先手工删除要被替换的元素的所有事件处理程序和 JavaScript 对象属性（第 13 章将进一步讨论事件处理程序）。

不过，使用这几个属性 —— 特别是使用 innerHTML，仍然还是可以为我们提供很多便利的。一般来说，在插入大量新 HTML 标记时，使用 innerHTML 属性与通过多次 DOM 操作先创建节点再指定它们之间的关系相比，效率要高得多。这是因为在设置 innerHTML 或 outerHTML 时，就会创建一个 HTML 解析器。这个解析器是在浏览器级别的代码（通常是 C++ 编写的）基础上运行的，因此比执行 JavaScript 快得多。不可避免地，创建和销毁 HTML 解析器也会带来性能损失，所以最好能够将设置 innerHTML 或 outerHTML 的次数控制在合理的范围内。例如，下列代码使用 innerHTML 创建了很多列表项：

for (var i=0, len=values.length; i < len; i++){ul.innerHTML += "<li>" + values [i] + "</li>"; // 要避免这种频繁操作！！ }

这种每次循环都设置一次 innerHTML 的做法效率很低。而且，每次循环还要从 innerHTML 中读取一次信息，就意味着每次循环要访问两次 innerHTML。最好的做法是单独构建字符串，然后再一次性地将结果字符串赋值给 innerHTML，像下面这样：

var itemsHtml = ""; for (var i=0, len=values.length; i < len; i++){ itemsHtml += "<li>" + values[i] + "</li>"; } ul.innerHTML = itemsHtml;

这个例子的效率要高得多，因为它只对 innerHTML 执行了一次赋值操作。

11.3.7　scrollIntoView () 方法

如何滚动页面也是 DOM 规范没有解决的一个问题。为了解决这个问题，浏览器实现了一些方法，以方便开发人员更好地控制页面滚动。在各种专有方法中，HTML5 最终选择了 scrollIntoView () 作为标准方法。

scrollIntoView () 可以在所有 HTML 元素上调用，通过滚动浏览器窗口或某个容器元素，调用元素就可以出现在视口中。如果给这个方法传入 true 作为参数，或者不传入任何参数，那么窗口滚动之后会让调用元素的顶部与视口顶部尽可能平齐。如果传入 false 作为参数，调用元素会尽可能全部出现在视口中，（可能的话，调用元素的底部会与视口顶部平齐。）不过顶部不一定平齐，例如：

// 让元素可见 document.forms [0].scrollIntoView ();

当页面发生变化时，一般会用这个方法来吸引用户的注意力。实际上，为某个元素设置焦点也会导致浏览器滚动并显示出获得焦点的元素。

支持 scrollIntoView () 方法的浏览器有 IE、Firefox、Safari 和 Opera。

11.4　专有扩展

虽然所有浏览器开发商都知晓坚持标准的重要性，但在发现某项功能缺失时，这些开发商都会一如既往地向 DOM 中添加专有扩展，以弥补功能上的不足。表面上看，这种各行其事的做法似乎不太好，但实际上专有扩展为 Web 开发领域提供了很多重要的功能，这些功能最终都在 HTML5 规范中得到了标准化。

即便如此，仍然还有大量专有的 DOM 扩展没有成为标准。但这并不是说它们将来不会被写进标准，而只是说在编写本书的时候，它们还是专有功能，而且只得到了少数浏览器的支持。

11.4.1　文档模式

IE8 引入了一个新的概念叫「文档模式」（document mode）。页面的文档模式决定了可以使用什么功能。换句话说，文档模式决定了你可以使用哪个级别的 CSS，可以在 JavaScript 中使用哪些 API，以及如何对待文档类型（doctype）。到了 IE9，总共有以下 4 种文档模式。

IE5：以混杂模式渲染页面（IE5 的默认模式就是混杂模式）。IE8 及更高版本中的新功能都无法使用。

IE7：以 IE7 标准模式渲染页面。IE8 及更高版本中的新功能都无法使用。

IE8：以 IE8 标准模式渲染页面。IE8 中的新功能都可以使用，因此可以使用 Selectors API、更多 CSS2 级选择符和某些 CSS3 功能，还有一些 HTML5 的功能。不过 IE9 中的新功能无法使用。

IE9：以 IE9 标准模式渲染页面。IE9 中的新功能都可以使用，比如 ECMAScript 5、完整的 CSS3 以及更多 HTML5 功能。这个文档模式是最高级的模式。

要理解 IE8 及更高版本的工作原理，必须理解文档模式。

要强制浏览器以某种模式渲染页面，可以使用 HTTP 头部信息 X-UA-Compatible，或通过等价的 <meta> 标签来设置：

<meta http-equiv="X-UA-Compatible" content="IE=IEVersion">

注意，这里 IE 的版本（IEVersion）有以下一些不同的值，而且这些值并不一定与上述 4 种文档模式对应。

Edge：始终以最新的文档模式来渲染页面。忽略文档类型声明。对于 IE8，始终保持以 IE8 标准模式渲染页面。对于 IE9，则以 IE9 标准模式渲染页面。

EmulateIE9：如果有文档类型声明，则以 IE9 标准模式渲染页面，否则将文档模式设置为 IE5。

EmulateIE8：如果有文档类型声明，则以 IE8 标准模式渲染页面，否则将文档模式设置为 IE5。

EmulateIE7：如果有文档类型声明，则以 IE7 标准模式渲染页面，否则将文档模式设置为 IE5。

9：强制以 IE9 标准模式渲染页面，忽略文档类型声明。

8：强制以 IE8 标准模式渲染页面，忽略文档类型声明。

7：强制以 IE7 标准模式渲染页面，忽略文档类型声明。

5：强制将文档模式设置为 IE5，忽略文档类型声明。

比如，要想让文档模式像在 IE7 中一样，可以使用下面这行代码：

<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">

如果不打算考虑文档类型声明，而直接使用 IE7 标准模式，那么可以使用下面这行代码：

<meta http-equiv="X-UA-Compatible" content="IE=7">

没有规定说必须在页面中设置 X-UA-Compatible。默认情况下，浏览器会通过文档类型声明来确定是使用最佳的可用文档模式，还是使用混杂模式。

通过 document.documentMode 属性可以知道给定页面使用的是什么文档模式。这个属性是 IE8 中新增的，它会返回使用的文档模式的版本号（在 IE9 中，可能返回的版本号为 5、7、8、9）：

var mode = document.documentMode;

知道页面采用的是什么文档模式，有助于理解页面的行为方式。无论在什么文档模式下，都可以访问这个属性。

11.4.2　children 属性

由于 IE9 之前的版本与其他浏览器在处理文本节点中的空白符时有差异，因此就出现了 children 属性。这个属性是 HTMLCollection 的实例，只包含元素中同样还是元素的子节点。除此之外，children 属性与 childNodes 没有什么区别，即在元素只包含元素子节点时，这两个属性的值相同。下面是访问 children 属性的示例代码：

var childCount = element.children.length; var firstChild = element.children[0];

支持 children 属性的浏览器有 IE5、Firefox 3.5、Safari 2（但有 bug）、Safari 3（完全支持）、Opera8 和 Chrome（所有版本）。IE8 及更早版本的 children 属性中也会包含注释节点，但 IE9 之后的版本则只返回元素节点。

11.4.3　contains () 方法

在实际开发中，经常需要知道某个节点是不是另一个节点的后代。IE 为此率先引入了 contains () 方法，以便不通过在 DOM 文档树中查找即可获得这个信息。调用 contains () 方法的应该是祖先节点，也就是搜索开始的节点，这个方法接收一个参数，即要检测的后代节点。如果被检测的节点是后代节点，该方法返回 true；否则，返回 false。以下是一个例子：

alert(document.documentElement.contains(document.body)); //true

这个例子测试了 <body> 元素是不是 <html> 元素的后代，在格式正确的 HTML 页面中，以上代码返回 true。支持 contains () 方法的浏览器有 IE、Firefox 9+、Safari、Opera 和 Chrome。

使用 DOM Level 3 compareDocumentPosition () 也能够确定节点间的关系。支持这个方法的浏览器有 IE9+、Firefox、Safari、Opera 9.5 + 和 Chrome。如前所述，这个方法用于确定两个节点间的关系，返回一个表示该关系的位掩码（ bitmask）。下表列出了这个位掩码的值。

掩码 节点关系

1 无关（给定的节点不在当前文档中）

2 居前（给定的节点在 DOM 树中位于参考节点之前）

4 居后（给定的节点在 DOM 树中位于参考节点之后）

8 包含（给定的节点是参考节点的祖先）

16 被包含（给定的节点是参考节点的后代）

为模仿 contains () 方法，应该关注的是掩码 16。可以对 compareDocumentPosition () 的结果执行按位与，以确定参考节点（调用 compareDocumentPosition () 方法的当前节点）是否包含给定的节点（传入的节点）。来看下面的例子：

var result = document.documentElement.compareDocumentPosition(document.body); alert(!!(result & 16));

执行上面的代码后，结果会变成 20（表示「居后」的 4 加上表示「被包含」的 16）。对掩码 16 执行按位操作会返回一个非零数值，而两个逻辑非操作符会将该数值转换成布尔值。

使用一些浏览器及能力检测，就可以写出如下所示的一个通用的 contains 函数：

function contains(refNode, otherNode){ if (typeof refNode.contains == "function" && (!client.engine.webkit || client.engine.webkit >= 522)){ return refNode.contains(otherNode); } else if (typeof refNode.compareDocumentPosition == "function"){ return !!(refNode.compareDocumentPosition(otherNode) & 16); } else { var node = otherNode.parentNode; do { if (node === refNode){ return true; } else { node = node.parentNode; } } while (node !== null); return false; } }

ContainsExample02.htm

这个函数组合使用了三种方式来确定一个节点是不是另一个节点的后代。函数的第一个参数是参考节点，第二个参数是要检查的节点。在函数体内，首先检测 refNode 中是否存在 contains () 方法（能力检测）。这一部分代码还检查了当前浏览器所用的 WebKit 版本号。如果方法存在而且不是 WebKit（!client.engine.webkit），则继续执行代码。否则，如果浏览器是 WebKit 且至少是 Safari 3（WebKit 版本号为 522 或更高），那么也可以继续执行代码。在 WebKit 版本号小于 522 的 Safari 浏览器中，contains () 方法不能正常使用。

接下来检查是否存在 compareDocumentPosition () 方法，而函数的最后一步则是自 otherNode 开始向上遍历 DOM 结构，以递归方式取得 parentNode，并检查其是否与 refNode 相等。在文档树的顶端，parentNode 的值等于 null，于是循环结束。这是针对旧版本 Safari 设计的一个后备策略。

11.4.4　插入文本

前面介绍过，IE 原来专有的插入标记的属性 innerHTML 和 outerHTML 已经被 HTML5 纳入规范。但另外两个插入文本的专有属性则没有这么好的运气。这两个没有被 HTML5 看中的属性是 innerText 和 outerText。

1. innerText 属性

通过 innertText 属性可以操作元素中包含的所有文本内容，包括子文档树中的文本。在通过 innerText 读取值时，它会按照由浅入深的顺序，将子文档树中的所有文本拼接起来。在通过 innerText 写入值时，结果会删除元素的所有子节点，插入包含相应文本值的文本节点。来看下面这个 HTML 代码示例。

<div id="content"> <p>This is a <strong>paragraph</strong> with a list following it.</p> <ul> <li>Item 1</li> <li>Item 2</li> <li>Item 3</li> </ul> </div>

InnerTextExample01.htm

对于这个例子中的 <div> 元素而言，其 innerText 属性会返回下列字符串：

This is a paragraph with a list following it. Item 1 Item 2 Item 3

由于不同浏览器处理空白符的方式不同，因此输出的文本可能会也可能不会包含原始 HTML 代码中的缩进。

使用 innerText 属性设置这个 <div> 元素的内容，则只需一行代码：

div.innerText = "Hello world!";

InnerTextExample02.htm

执行这行代码后，页面的 HTML 代码就会变成如下所示。

<div id="content">Hello world!</div>

设置 innerText 属性移除了先前存在的所有子节点，完全改变了 DOM 子树。此外，设置 innerText 属性的同时，也对文本中存在的 HTML 语法字符（小于号、大于号、引号及和号）进行了编码。再看一个例子。

div.innerText = "Hello & welcome, <b>\"reader\"!</b>";

InnerTextExample03.htm

运行以上代码之后，会得到如下所示的结果。

<div id="content">Hello &amp; welcome, &lt;b&gt;&quot;reader&quot;!&lt;/b&gt;</div>

设置 innerText 永远只会生成当前节点的一个子文本节点，而为了确保只生成一个子文本节点，就必须要对文本进行 HTML 编码。利用这一点，可以通过 innerText 属性过滤掉 HTML 标签。方法是将 innerText 设置为等于 innerText，这样就可以去掉所有 HTML 标签，比如：

div.innerText = div.innerText;

执行这行代码后，就用原来的文本内容替换了容器元素中的所有内容（包括子节点，因而也就去掉了 HTML 标签）。

支持 innerText 属性的浏览器包括 IE4+、Safari 3+、Opera 8 + 和 Chrome。Firefox 虽然不支持 innerText，但支持作用类似的 textContent 属性。textContent 是 DOM Level 3 规定的一个属性，其他支持 textContent 属性的浏览器还有 IE9+、Safari 3+、Opera 10 + 和 Chrome。为了确保跨浏览器兼容，有必要编写一个类似于下面的函数来检测可以使用哪个属性。

function getInnerText(element){ return (typeof element.textContent == "string") ? element.textContent : element.innerText; } function setInnerText(element, text){ if (typeof element.textContent == "string"){ element.textContent = text; } else { element.innerText = text; } }

InnerTextExample05.htm

这两个函数都接收一个元素作为参数，然后检查这个元素是不是有 textContent 属性。如果有，那么 typeof element.textContent 应该是 "string"；如果没有，那么这两个函数就会改为使用 innerText。可以像下面这样调用这两个函数。

setInnerText(div, "Hello world!"); alert(getInnerText(div)); //"Hello world!"

使用这两个函数可以确保在不同的浏览器中使用正确的属性。

实际上，innerText 与 textContent 返回的内容并不完全一样。比如，innerText 会忽略行内的样式和脚本，而 textContent 则会像返回其他文本一样返回行内的样式和脚本代码。避免跨浏览器兼容问题的最佳途径，就是从不包含行内样式或行内脚本的 DOM 子树副本或 DOM 片段中读取文本。

2. outerText 属性

除了作用范围扩大到了包含调用它的节点之外，outerText 与 innerText 基本上没有多大区别。在读取文本值时，outerText 与 innerText 的结果完全一样。但在写模式下，outerText 就完全不同了：outerText 不只是替换调用它的元素的子节点，而是会替换整个元素（包括子节点）。比如：

div.outerText = "Hello world!";

这行代码实际上相当于如下两行代码：

var text = document.createTextNode("Hello world!"); div.parentNode.replaceChild(text, div);

本质上，新的文本节点会完全取代调用 outerText 的元素。此后，该元素就从文档中被删除，无法访问。

支持 outerText 属性的浏览器有 IE4+、Safari 3+、Opera 8 + 和 Chrome。由于这个属性会导致调用它的元素不存在，因此并不常用。我们也建议读者尽可能不要使用这个属性。

11.4.5　滚动

如前所述，HTML5 之前的规范并没有就与页面滚动相关的 API 做出任何规定。但 HTML5 在将 scrollIntoView () 纳入规范之后，仍然还有其他几个专有方法可以在不同的浏览器中使用。下面列出的几个方法都是对 HTMLElement 类型的扩展，因此在所有元素中都可以调用。

scrollIntoViewIfNeeded (alignCenter)：只在当前元素在视口中不可见的情况下，才滚动浏览器窗口或容器元素，最终让它可见。如果当前元素在视口中可见，这个方法什么也不做。如果将可选的 alignCenter 参数设置为 true，则表示尽量将元素显示在视口中部（垂直方向）。Safari 和 Chrome 实现了这个方法。

scrollByLines (lineCount)：将元素的内容滚动指定的行高，lineCount 值可以是正值，也可以是负值。Safari 和 Chrome 实现了这个方法。

scrollByPages (pageCount)：将元素的内容滚动指定的页面高度，具体高度由元素的高度决定。Safari 和 Chrome 实现了这个方法。

希望大家要注意的是，scrollIntoView () 和 scrollIntoViewIfNeeded () 的作用对象是元素的容器，而 scrollByLines () 和 scrollByPages () 影响的则是元素自身。下面还是来看几个示例吧。

// 将页面主体滚动 5 行 document.body.scrollByLines (5); // 在当前元素不可见的时候，让它进入浏览器的视口 document.images [0].scrollIntoViewIfNeeded (); // 将页面主体往回滚动 1 页 document.body.scrollByPages (-1);

由于 scrollIntoView () 是唯一一个所有浏览器都支持的方法，因此还是这个方法最常用。

11.5　小结

虽然 DOM 为与 XML 及 HTML 文档交互制定了一系列核心 API，但仍然有几个规范对标准的 DOM 进行了扩展。这些扩展中有很多原来是浏览器专有的，但后来成为了事实标准，于是其他浏览器也都提供了相同的实现。本章介绍的三个这方面的规范如下。

Selectors API，定义了两个方法，让开发人员能够基于 CSS 选择符从 DOM 中取得元素，这两个方法是 querySelector () 和 querySelectorAll ()。

Element Traversal，为 DOM 元素定义了额外的属性，让开发人员能够更方便地从一个元素跳到另一个元素。之所以会出现这个扩展，是因为浏览器处理 DOM 元素间空白符的方式不一样。

HTML5，为标准的 DOM 定义了很多扩展功能。其中包括在 innerHTML 属性这样的事实标准基础上提供的标准定义，以及为管理焦点、设置字符集、滚动页面而规定的扩展 API。

虽然目前 DOM 扩展的数量还不多，但随着 Web 技术的发展，相信一定还会涌现出更多扩展来。很多浏览器都在试验专有的扩展，而这些扩展一旦获得认可，就能成为「伪」标准，甚至会被收录到规范的更新版本中。

第 12 章　DOM2 和 DOM3

本章内容

DOM2 和 DOM3 的变化

操作样式的 DOM API

DOM 遍历与范围

DOM1 级主要定义的是 HTML 和 XML 文档的底层结构。DOM2 和 DOM3 级则在这个结构的基础上引入了更多的交互能力，也支持了更高级的 XML 特性。为此，DOM2 和 DOM3 级分为许多模块（模块之间具有某种关联），分别描述了 DOM 的某个非常具体的子集。这些模块 如下。

DOM2 级核心（DOM Level 2 Core）：在 1 级核心基础上构建，为节点添加了更多方法和属性。

DOM2 级视图（DOM Level 2 Views）：为文档定义了基于样式信息的不同视图。

DOM2 级事件（DOM Level 2 Events）：说明了如何使用事件与 DOM 文档交互。

DOM2 级样式（DOM Level 2 Style）：定义了如何以编程方式来访问和改变 CSS 样式信息。

DOM2 级遍历和范围（DOM Level 2 Traversal and Range）：引入了遍历 DOM 文档和选择其特定部分的新接口。

DOM2 级 HTML（DOM Level 2 HTML）：在 1 级 HTML 基础上构建，添加了更多属性、方法和新接口。

本章探讨除「DOM2 级事件」之外的所有模块，「DOM2 级事件」模块将在第 13 章进行全面讲解。

DOM3 级又增加了「XPath」模块和「加载与保存」（Load and Save）模块。这些模块将在第 18 章讨论。

12.1　DOM 变化

DOM2 级和 3 级的目的在于扩展 DOM API，以满足操作 XML 的所有需求，同时提供更好的错误处理及特性检测能力。从某种意义上讲，实现这一目的很大程度意味着对命名空间的支持。「DOM2 级核心」没有引入新类型，它只是在 DOM1 级的基础上通过增加新方法和新属性来增强了既有类型。「DOM3 级核心」同样增强了既有类型，但也引入了一些新类型。

类似地，「DOM2 级视图」和「DOM2 级 HTML」模块也增强了 DOM 接口，提供了新的属性和方法。由于这两个模块很小，因此我们将把它们与「DOM2 级核心」放在一起，讨论基本 JavaScript 对象的变化。可以通过下列代码来确定浏览器是否支持这些 DOM 模块。

var supportsDOM2Core = document.implementation.hasFeature("Core", "2.0"); var supportsDOM3Core = document.implementation.hasFeature("Core", "3.0"); var supportsDOM2HTML = document.implementation.hasFeature("HTML", "2.0"); var supportsDOM2Views = document.implementation.hasFeature("Views", "2.0"); var supportsDOM2XML = document.implementation.hasFeature("XML", "2.0");

本章只讨论那些已经有浏览器实现的部分，任何浏览器都没有实现的部分将不作讨论。

12.1.1　针对 XML 命名空间的变化

有了 XML 命名空间，不同 XML 文档的元素就可以混合在一起，共同构成格式良好的文档，而不必担心发生命名冲突。从技术上说，HTML 不支持 XML 命名空间，但 XHTML 支持 XML 命名空间。因此，本节给出的都是 XHTML 的示例。

命名空间要使用 xmlns 特性来指定。XHTML 的命名空间是 http://www.w3.org/1999/xhtml，在任何格式良好 XHTML 页面中，都应该将其包含在 <html> 元素中，如下面的例子所示。

<html xmlns="http://www.w3.org/1999/xhtml"> <head> <title>Example XHTML page</title> </head> <body> Hello world! </body> </html>

对这个例子而言，其中的所有元素默认都被视为 XHTML 命名空间中的元素。要想明确地为 XML 命名空间创建前缀，可以使用 xmlns 后跟冒号，再后跟前缀，如下所示。

<xhtml:html xmlns:xhtml="http://www.w3.org/1999/xhtml"> <xhtml:head> <xhtml:title>Example XHTML page</xhtml:title> </xhtml:head> <xhtml:body> Hello world! </xhtml:body> </xhtml:html>

这里为 XHTML 的命名空间定义了一个名为 xhtml 的前缀，并要求所有 XHTML 元素都以该前缀开头。有时候为了避免不同语言间的冲突，也需要使用命名空间来限定特性，如下面的例子所示。

<xhtml:html xmlns:xhtml="http://www.w3.org/1999/xhtml"> <xhtml:head> <xhtml:title>Example XHTML page</xhtml:title> </xhtml:head> <xhtml:body xhtml:class="home"> Hello world! </xhtml:body> </xhtml:html>

这个例子中的特性 class 带有一个 xhtml 前缀。在只基于一种语言编写 XML 文档的情况下，命名空间实际上也没有什么用。不过，在混合使用两种语言的情况下，命名空间的用处就非常大了。来看一看下面这个混合了 XHTML 和 SVG 语言的文档：

<html xmlns="http://www.w3.org/1999/xhtml"> <head> <title>Example XHTML page</title> </head> <body> <svg xmlns="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 100 100" style="width:100%; height:100%"> <rect x="0" y="0" width="100" height="100" style="fill:red"/> </svg> </body> </html>

在这个例子中，通过设置命名空间，将 <svg> 标识为了与包含文档无关的元素。此时，<svg> 元素的所有子元素，以及这些元素的所有特性，都被认为属于 http://www.w3.org/2000/svg 命名空间。即使这个文档从技术上说是一个 XHTML 文档，但因为有了命名空间，其中的 SVG 代码也仍然是有效的。

对于类似这样的文档来说，最有意思的事发生在调用方法操作文档节点的情况下。例如，在创建一个元素时，这个元素属于哪个命名空间呢？在查询一个特殊标签名时，应该将结果包含在哪个命名空间中呢？「DOM2 级核心」通过为大多数 DOM1 级方法提供特定于命名空间的版本解决了这个问题。

1. Node 类型的变化

在 DOM2 级中，Node 类型包含下列特定于命名空间的属性。

localName：不带命名空间前缀的节点名称。

namespaceURI：命名空间 URI 或者（在未指定的情况下是）null。

prefix：命名空间前缀或者（在未指定的情况下是）null。

当节点使用了命名空间前缀时，其 nodeName 等于 prefix+":"+ localName。以下面的文档为例：

<html xmlns="http://www.w3.org/1999/xhtml"> <head> <title>Example XHTML page</title> </head> <body> <s:svg xmlns:s="http://www.w3.org/2000/svg" version="1.1" viewBox="0 0 100 100" style="width:100%; height:100%"> <s:rect x="0" y="0" width="100" height="100" style="fill:red"/> </s:svg> </body> </html>

NamespaceExample.xml

对于 <html> 元素来说，它的 localName 和 tagName 是 "html"，namespaceURI 是 "http://www.w3.org/1999/xhtml"，而 prefix 是 null。对于 <s:svg> 元素而言，它的 localName 是 "svg"，tagName 是 "s:svg"，namespaceURI 是 "http://www.w3.org/2000/svg"，而 prefix 是 "s"。

DOM3 级在此基础上更进一步，又引入了下列与命名空间有关的方法。

isDefaultNamespace (namespaceURI)：在指定的 namespaceURI 是当前节点的默认命名空间的情况下返回 true。

lookupNamespaceURI (prefix)：返回给定 prefix 的命名空间。

lookupPrefix (namespaceURI)：返回给定 namespaceURI 的前缀。

针对前面的例子，可以执行下列代码：

alert (document.body.isDefaultNamespace ("http://www.w3.org/1999/xhtml"); //true// 假设 svg 中包含着对 <s:svg> 的引用 alert (svg.lookupPrefix ("http://www.w3.org/2000/svg")); //"s" alert (svg.lookupNamespaceURI ("s")); //"http://www.w3.org/2000/svg"

在取得了一个节点，但不知道该节点与文档其他元素之间关系的情况下，这些方法是很有用的。

2. Document 类型的变化

DOM2 级中的 Document 类型也发生了变化，包含了下列与命名空间有关的方法。

createElementNS (namespaceURI, tagName)：使用给定的 tagName 创建一个属于命名空间 namespaceURI 的新元素。

createAttributeNS (namespaceURI, attributeName)：使用给定的 attributeName 创建一个属于命名空间 namespaceURI 的新特性。

getElementsByTagNameNS (namespaceURI, tagName)：返回属于命名空间 namespaceURI 的 tagName 元素的 NodeList。

使用这些方法时需要传入表示命名空间的 URI（而不是命名空间前缀），如下面的例子所示。

// 创建一个新的 SVG 元素 var svg = document.createElementNS ("http://www.w3.org/2000/svg","svg"); // 创建一个属于某个命名空间的新特性 var att = document.createAttributeNS ("http://www.somewhere.com", "random"); // 取得所有 XHTML 元素 var elems = document.getElementsByTagNameNS ("http://www.w3.org/1999/xhtml", "*");

只有在文档中存在两个或多个命名空间时，这些与命名空间有关的方法才是必需的。

3. Element 类型的变化

「DOM2 级核心」中有关 Element 的变化，主要涉及操作特性。新增的方法如下。

getAttributeNS (namespaceURI,localName)：取得属于命名空间 namespaceURI 且名为 localName 的特性。

getAttributeNodeNS (namespaceURI,localName)：取得属于命名空间 namespaceURI 且名为 localName 的特性节点。

getElementsByTagNameNS (namespaceURI, tagName)：返回属于命名空间 namespaceURI 的 tagName 元素的 NodeList。

hasAttributeNS (namespaceURI,localName)：确定当前元素是否有一个名为 localName 的特性，而且该特性的命名空间是 namespaceURI。注意，「DOM2 级核心」也增加了一个 hasAttribute () 方法，用于不考虑命名空间的情况。

removeAttriubteNS (namespaceURI,localName)：删除属于命名空间 namespaceURI 且名为 localName 的特性。

setAttributeNS (namespaceURI,qualifiedName,value)：设置属于命名空间 namespaceURI 且名为 qualifiedName 的特性的值为 value。

setAttributeNodeNS (attNode)：设置属于命名空间 namespaceURI 的特性节点。

除了第一个参数之外，这些方法与 DOM1 级中相关方法的作用相同；第一个参数始终都是一个命名空间 URI。

4. NamedNodeMap 类型的变化

NamedNodeMap 类型也新增了下列与命名空间有关的方法。由于特性是通过 NamedNodeMap 表示的，因此这些方法多数情况下只针对特性使用。

getNamedItemNS (namespaceURI,localName)：取得属于命名空间 namespaceURI 且名为 localName 的项。

removeNamedItemNS (namespaceURI,localName)：移除属于命名空间 namespaceURI 且名为 localName 的项。

setNamedItemNS (node)：添加 node，这个节点已经事先指定了命名空间信息。

由于一般都是通过元素访问特性，所以这些方法很少使用。

12.1.2　其他方面的变化

DOM 的其他部分在「DOM2 级核心」中也发生了一些变化。这些变化与 XML 命名空间无关，而是更倾向于确保 API 的可靠性及完整性。

1. DocumentType 类型的变化

DocumentType 类型新增了 3 个属性：publicId、systemId 和 internalSubset。其中，前两个属性表示的是文档类型声明中的两个信息段，这两个信息段在 DOM1 级中是没有办法访问到的。以下面的 HTML 文档类型声明为例。

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

对这个文档类型声明而言，publicId 是 "-//W3C//DTD HTML 4.01//EN"，而 systemId 是 "http://www.w3.org/TR/html4/strict.dtd"。在支持 DOM2 级的浏览器中，应该可以运行下列代码。

alert(document.doctype.publicId); alert(document.doctype.systemId);

实际上，很少需要在网页中访问此类信息。

最后一个属性 internalSubset，用于访问包含在文档类型声明中的额外定义，以下面的代码为例。

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" [<!ELEMENT name (#PCDATA)>] >

访问 document.doctype.internalSubset 将得到 "<!ELEMENT name (#PCDATA)>"。这种内部子集（internal subset）在 HTML 中极少用到，在 XML 中可能会更常见一些。

2. Document 类型的变化

Document 类型的变化中唯一与命名空间无关的方法是 importNode ()。这个方法的用途是从一个文档中取得一个节点，然后将其导入到另一个文档，使其成为这个文档结构的一部分。需要注意的是，每个节点都有一个 ownerDocument 属性，表示所属的文档。如果调用 appendChild () 时传入的节点属于不同的文档（ownerDocument 属性的值不一样），则会导致错误。但在调用 importNode () 时传入不同文档的节点则会返回一个新节点，这个新节点的所有权归当前文档所有。

说起来，importNode () 方法与 Element 的 cloneNode () 方法非常相似，它接受两个参数：要复制的节点和一个表示是否复制子节点的布尔值。返回的结果是原来节点的副本，但能够在当前文档中使用。来看下面的例子：

var newNode = document.importNode (oldNode, true); // 导入节点及其所有子节点 document.body.appendChild (newNode);

这个方法在 HTML 文档中并不常用，在 XML 文档中用得比较多（更多讨论请参见第 18 章）。

「DOM2 级视图」模块添加了一个名为 defaultView 的属性，其中保存着一个指针，指向拥有给定文档的窗口（或框架）。除此之外，「视图」规范没有提供什么时候其他视图可用的信息，因而这是唯一一个新增的属性。除 IE 之外的所有浏览器都支持 defaultView 属性。在 IE 中有一个等价的属性名叫 parentWindow（Opera 也支持这个属性）。因此，要确定文档的归属窗口，可以使用以下代码。

var parentWindow = document.defaultView || document.parentWindow;

除了上述一个方法和一个属性之外，「DOM2 级核心」还为 document.implementation 对象规定了两个新方法：createDocumentType () 和 createDocument ()。前者用于创建一个新的 DocumentType 节点，接受 3 个参数：文档类型名称、publicId、systemId。例如，下列代码会创建一个新的 HTML 4.01 Strict 文档类型。

var doctype = document.implementation.createDocumentType("html", "-//W3C//DTD HTML 4.01//EN", "http://www.w3.org/TR/html4/strict.dtd");

由于既有文档的文档类型不能改变，因此 createDocumentType () 只在创建新文档时有用；创建新文档时需要用到 createDocument () 方法。这个方法接受 3 个参数：针对文档中元素的 namespaceURI、文档元素的标签名、新文档的文档类型。下面这行代码将会创建一个空的新 XML 文档。

var doc = document.implementation.createDocument("", "root", null);

这行代码会创建一个没有命名空间的新文档，文档元素为 <root>，而且没有指定文档类型。要想创建一个 XHTML 文档，可以使用以下代码。

var doctype = document.implementation.createDocumentType("html", " -//W3C//DTD XHTML 1.0 Strict//EN", "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"); var doc = document.implementation.createDocument("http://www.w3.org/1999/xhtml", "html", doctype);

这样，就创建了一个带有适当命名空间和文档类型的新 XHTML 文档。不过，新文档当前只有文档元素 <html>，剩下的所有元素都需要继续添加。

「DOM2 级 HTML」模块也为 document.implementation 新增了一个方法，名叫 createHTMLDocument ()。这个方法的用途是创建一个完整的 HTML 文档，包括 < html>、<head>、<title> 和 <body> 元素。这个方法只接受一个参数，即新创建文档的标题（放在 <title> 元素中的字符串），返回新的 HTML 文档，如下所示：

var htmldoc = document.implementation.createHTMLDocument("New Doc"); alert(htmldoc.title); //"New Doc" alert(typeof htmldoc.body); //"object"

CreateHTMLDocumentExample.htm

通过调用 createHTMLDocument () 创建的这个文档，是 HTMLDocument 类型的实例，因而具有该类型的所有属性和方法，包括 title 和 body 属性。只有 Opera 和 Safari 支持这个方法。

3. Node 类型的变化

Node 类型中唯一与命名空间无关的变化，就是添加了 isSupported () 方法。与 DOM1 级为 document.implementation 引入的 hasFeature () 方法类似，isSupported () 方法用于确定当前节点具有什么能力。这个方法也接受相同的两个参数：特性名和特性版本号。如果浏览器实现了相应特性，而且能够基于给定节点执行该特性，isSupported () 就返回 true。来看一个例子：

if (document.body.isSupported ("HTML", "2.0")){// 执行只有 "DOM2 级 HTML" 才支持的操作}

由于不同实现在决定对什么特性返回 true 或 false 时并不一致，这个方法同样也存在与 hasFeature () 方法相同的问题。为此，我们建议在确定某个特性是否可用时，最好还是使用能力检测。

DOM3 级引入了两个辅助比较节点的方法：isSameNode () 和 isEqualNode ()。这两个方法都接受一个节点参数，并在传入节点与引用的节点相同或相等时返回 true。所谓相同，指的是两个节点引用的是同一个对象。所谓相等，指的是两个节点是相同的类型，具有相等的属性（nodeName、nodeValue，等等），而且它们的 attributes 和 childNodes 属性也相等（相同位置包含相同的值）。来看一个例子。

var div1 = document.createElement("div"); div1.setAttribute("class", "box"); var div2 = document.createElement("div"); div2.setAttribute("class", "box"); alert(div1.isSameNode(div1)); //true alert(div1.isEqualNode(div2)); //true alert(div1.isSameNode(div2)); //false

这里创建了两个具有相同特性的 <div> 元素。这两个元素相等，但不相同。

DOM3 级还针对为 DOM 节点添加额外数据引入了新方法。其中，setUserData () 方法会将数据指定给节点，它接受 3 个参数：要设置的键、实际的数据（可以是任何数据类型）和处理函数。以下代码可以将数据指定给一个节点。

document.body.setUserData("name", "Nicholas", function(){});

然后，使用 getUserData () 并传入相同的键，就可以取得该数据，如下所示：

var value = document.body.getUserData("name");

传入 setUserData () 中的处理函数会在带有数据的节点被复制、删除、重命名或引入一个文档时调用，因而你可以事先决定在上述操作发生时如何处理用户数据。处理函数接受 5 个参数：表示操作类型的数值（1 表示复制，2 表示导入，3 表示删除，4 表示重命名）、数据键、数据值、源节点和目标节点。在删除节点时，源节点是 null；而在复制节点时，目标节点是 null。在函数内部，你可以决定如何存储数据。来看下面的例子。

var div = document.createElement("div"); div.setUserData("name", "Nicholas", function(operation, key, value, src, dest){ if (operation == 1){ dest.setUserData(key, value, function(){}); } }); var newDiv = div.cloneNode(true); alert(newDiv.getUserData("name")); //"Nicholas"

UserDataExample.htm

这里，先创建了一个 <div> 元素，然后又为它添加了一些数据（用户数据）。在使用 cloneNode () 复制这个元素时，就会调用处理函数，从而将数据自动复制到了副本节点。结果在通过副本节点调用 getUserData () 时，就会返回与原始节点中包含的相同的值。

4. 框架的变化

框架和内嵌框架分别用 HTMLFrameElement 和 HTMLIFrameElement 表示，它们在 DOM2 级中都有了一个新属性，名叫 contentDocument。这个属性包含一个指针，指向表示框架内容的文档对象。在此之前，无法直接通过元素取得这个文档对象（只能使用 frames 集合）。可以像下面这样使用这个属性。

var iframe = document.getElementById ("myIframe"); var iframeDoc = iframe.contentDocument; // 在 IE8 以前的版本中无效

IFrameElementExample.htm

由于 contentDocument 属性是 Document 类型的实例，因此可以像使用其他 HTML 文档一样使用它，包括所有属性和方法。Opera、Firefox、Safari 和 Chrome 支持这个属性。IE8 之前不支持框架中的 contentDocument 属性，但支持一个名叫 contentWindow 的属性，该属性返回框架的 window 对象，而这个 window 对象又有一个 document 属性。因此，要想在上述所有浏览器中访问内嵌框架的文档对象，可以使用下列代码。

var iframe = document.getElementById("myIframe"); var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;

IFrameElementExample2.htm

所有浏览器都支持 contentWindow 属性。

访问框架或内嵌框架的文档对象要受到跨域安全策略的限制。如果某个框架中的页面来自其他域或不同子域，或者使用了不同的协议，那么要访问这个框架的文档对象就会导致错误。

12.2　样式

在 HTML 中定义样式的方式有 3 种：通过 <link/> 元素包含外部样式表文件、使用 <style/> 元素定义嵌入式样式，以及使用 style 特性定义针对特定元素的样式。「DOM2 级样式」模块围绕这 3 种应用样式的机制提供了一套 API。要确定浏览器是否支持 DOM2 级定义的 CSS 能力，可以使用下列代码。

var supportsDOM2CSS = document.implementation.hasFeature("CSS", "2.0"); var supportsDOM2CSS2 = document.implementation.hasFeature("CSS2", "2.0");

12.2.1　访问元素的样式

任何支持 style 特性的 HTML 元素在 JavaScript 中都有一个对应的 style 属性。这个 style 对象是 CSSStyleDeclaration 的实例，包含着通过 HTML 的 style 特性指定的所有样式信息，但不包含与外部样式表或嵌入样式表经层叠而来的样式。在 style 特性中指定的任何 CSS 属性都将表现为这个 style 对象的相应属性。对于使用短划线（分隔不同的词汇，例如 background-image）的 CSS 属性名，必须将其转换成驼峰大小写形式，才能通过 JavaScript 来访问。下表列出了几个常见的 CSS 属性及其在 style 对象中对应的属性名。

CSS 属性 JavaScript 属性

background-image style.backgroundImage

color style.color

display style.display

font-family style.fontFamily

多数情况下，都可以通过简单地转换属性名的格式来实现转换。其中一个不能直接转换的 CSS 属性就是 float。由于 float 是 JavaScript 中的保留字，因此不能用作属性名。「DOM2 级样式」规范规定样式对象上相应的属性名应该是 cssFloat；Firefox、Safari、Opera 和 Chrome 都支持这个属性，而 IE 支持的则是 styleFloat。

只要取得一个有效的 DOM 元素的引用，就可以随时使用 JavaScript 为其设置样式。以下是几个例子。

var myDiv = document.getElementById ("myDiv"); // 设置背景颜色 myDiv.style.backgroundColor = "red"; // 改变大小 myDiv.style.width = "100px"; myDiv.style.height = "200px"; // 指定边框 myDiv.style.border = "1px solid black";

在以这种方式改变样式时，元素的外观会自动被更新。

在标准模式下，所有度量值都必须指定一个度量单位。在混杂模式下，可以将 style.width 设置为 "20"，浏览器会假设它是 "20px"；但在标准模式下，将 style.width 设置为 "20" 会导致被忽略 —— 因为没有度量单位。在实践中，最好始终都指定度量单位。

通过 style 对象同样可以取得在 style 特性中指定的样式。以下面的 HTML 代码为例。

<div id="myDiv" style="background-color:blue; width:10px; height:25px"></div>

在 style 特性中指定的样式信息可以通过下列代码取得。

alert(myDiv.style.backgroundColor); //"blue" alert(myDiv.style.width); //"10px" alert(myDiv.style.height); //"25px"

如果没有为元素设置 style 特性，那么 style 对象中可能会包含一些默认的值，但这些值并不能准确地反映该元素的样式信息。

1. DOM 样式属性和方法

「DOM2 级样式」规范还为 style 对象定义了一些属性和方法。这些属性和方法在提供元素的 style 特性值的同时，也可以修改样式。下面列出了这些属性和方法。

cssText：如前所述，通过它能够访问到 style 特性中的 CSS 代码。

length：应用给元素的 CSS 属性的数量。

parentRule：表示 CSS 信息的 CSSRule 对象。本节后面将讨论 CSSRule 类型。

getPropertyCSSValue (propertyName)：返回包含给定属性值的 CSSValue 对象。

getPropertyPriority (propertyName)：如果给定的属性使用了！important 设置，则返回 "important"；否则，返回空字符串。

getPropertyValue (propertyName)：返回给定属性的字符串值。

item (index)：返回给定位置的 CSS 属性的名称。

removeProperty (propertyName)：从样式中删除给定属性。

setProperty (propertyName,value,priority)：将给定属性设置为相应的值，并加上优先权标志（"important" 或者一个空字符串）。

通过 cssText 属性可以访问 style 特性中的 CSS 代码。在读取模式下，cssText 返回浏览器对 style 特性中 CSS 代码的内部表示。在写入模式下，赋给 cssText 的值会重写整个 style 特性的值；也就是说，以前通过 style 特性指定的样式信息都将丢失。例如，如果通过 style 特性为元素设置了边框，然后再以不包含边框的规则重写 cssText，那么就会抹去元素上的边框。下面是使用 cssText 属性的一个例子。

myDiv.style.cssText = "width: 25px; height: 100px; background-color: green"; alert(myDiv.style.cssText);

设置 cssText 是为元素应用多项变化最快捷的方式，因为可以一次性地应用所有变化。

设计 length 属性的目的，就是将其与 item () 方法配套使用，以便迭代在元素中定义的 CSS 属性。在使用 length 和 item () 时，style 对象实际上就相当于一个集合，都可以使用方括号语法来代替 item () 来取得给定位置的 CSS 属性，如下面的例子所示。

for (var i=0, len=myDiv.style.length; i < len; i++){alert (myDiv.style [i]); // 或者 myDiv.style.item (i) }

无论是使用方括号语法还是使用 item () 方法，都可以取得 CSS 属性名（"background-color"，不是 "backgroundColor"）。然后，就可以在 getPropertyValue () 中使用了取得的属性名进一步取得属性的值，如下所示。

var prop, value, i, len; for (i=0, len=myDiv.style.length; i < len; i++){prop = myDiv.style [i]; // 或者 myDiv.style.item (i) value = myDiv.style.getPropertyValue (prop); alert (prop + ":" + value); }

getPropertyValue () 方法取得的始终都是 CSS 属性值的字符串表示。如果你需要更多信息，可以使用 getPropertyCSSValue () 方法，它返回一个包含两个属性的 CSSValue 对象，这两个属性分别是：cssText 和 cssValueType。其中，cssText 属性的值与 getPropertyValue () 返回的值相同，而 cssValueType 属性则是一个数值常量，表示值的类型：0 表示继承的值，1 表示基本的值，2 表示值列表，3 表示自定义的值。以下代码既输出 CSS 属性值，也输出值的类型。

var prop, value, i, len; for (i=0, len=myDiv.style.length; i < len; i++){prop = myDiv.style [i]; // 或者 myDiv.style.item (i) value = myDiv.style.getPropertyCSSValue (prop); alert (prop + ":" + value.cssText + "(" + value.cssValueType + ")"); }

DOMStyleObjectExample.htm

在实际开发中，getPropertyCSSValue () 使用得比 getPropertyValue () 少得多。IE9+、Safarie 3 + 以及 Chrome 支持这个方法。Firefox 7 及之前版本也提供这个访问，但调用总返回 null。

要从元素的样式中移除某个 CSS 属性，需要使用 removeProperty () 方法。使用这个方法移除一个属性，意味着将会为该属性应用默认的样式（从其他样式表经层叠而来）。例如，要移除通过 style 特性设置的 border 属性，可以使用下面的代码。

myDiv.style.removeProperty("border");

在不确定某个给定的 CSS 属性拥有什么默认值的情况下，就可以使用这个方法。只要移除相应的属性，就可以为元素应用默认值。

除非另有说明，本节讨论的属性和方法都得到了 IE9+、Firefox、Safari、Opera 9 + 以及 Chrome 的支持。

2. 计算的样式

虽然 style 对象能够提供支持 style 特性的任何元素的样式信息，但它不包含那些从其他样式表层叠而来并影响到当前元素的样式信息。「DOM2 级样式」增强了 document.defaultView，提供了 getComputedStyle () 方法。这个方法接受两个参数：要取得计算样式的元素和一个伪元素字符串（例如 ":after"）。如果不需要伪元素信息，第二个参数可以是 null。getComputedStyle () 方法返回一个 CSSStyleDeclaration 对象（与 style 属性的类型相同），其中包含当前元素的所有计算的样式。以下面这个 HTML 页面为例。

<!DOCTYPE html> <html> <head> <title>Computed Styles Example</title> <style type="text/css"> #myDiv { background-color: blue; width: 100px; height: 200px; } </style> </head> <body> <div id="myDiv" style="background-color: red; border: 1px solid black"></div> </body> </html>

ComputedStylesExample.htm

应用给这个例子中 <div> 元素的样式一方面来自嵌入式样式表（<style> 元素中的样式），另一方面来自其 style 特性。但是，style 特性中设置了 backgroundColor 和 border，没有设置 width 和 height，后者是通过样式表规则应用的。以下代码可以取得这个元素计算后的样式。

var myDiv = document.getElementById ("myDiv"); var computedStyle = document.defaultView.getComputedStyle (myDiv, null); alert (computedStyle.backgroundColor); // "red" alert (computedStyle.width); // "100px" alert (computedStyle.height); // "200px" alert (computedStyle.border); // 在某些浏览器中是 "1px solid black"

ComputedStylesExample.htm

在这个元素计算后的样式中，背景颜色的值是 "red"，宽度值是 "100px"，高度值是 "200px"。我们注意到，背景颜色不是 "blue"，因为这个样式在自身的 style 特性中已经被覆盖了。边框属性可能会也可能不会返回样式表中实际的 border 规则（Opera 会返回，但其他浏览器不会）。存在这个差别的原因是不同浏览器解释综合（rollup）属性（如 border）的方式不同，因为设置这种属性实际上会涉及很多其他属性。在设置 border 时，实际上是设置了四个边的边框宽度、颜色、样式属性（border-left-width、border-top-color、border-bottom-style，等等）。因此，即使 computedStyle.border 不会在所有浏览器中都返回值，但 computedStyle.borderLeftWidth 则会返回值。

需要注意的是，即使有些浏览器支持这种功能，但表示值的方式可能会有所区别。例如，Firefox 和 Safari 会将所有颜色转换成 RGB 格式（例如红色是 rgb (255,0,0)）。因此，在使用 getComputedStyle () 方法时，最好多在几种浏览器中测试一下。

IE 不支持 getComputedStyle () 方法，但它有一种类似的概念。在 IE 中，每个具有 style 属性的元素还有一个 currentStyle 属性。这个属性是 CSSStyleDeclaration 的实例，包含当前元素全部计算后的样式。取得这些样式的方式也差不多，如下面的例子所示。

var myDiv = document.getElementById("myDiv"); var computedStyle = myDiv.currentStyle; alert(computedStyle.backgroundColor); //"red" alert(computedStyle.width); //"100px" alert(computedStyle.height); //"200px" alert(computedStyle.border); //undefined

IEComputedStylesExample.htm

与 DOM 版本的方式一样，IE 也没有返回 border 样式，因为这是一个综合属性。

无论在哪个浏览器中，最重要的一条是要记住所有计算的样式都是只读的；不能修改计算后样式对象中的 CSS 属性。此外，计算后的样式也包含属于浏览器内部样式表的样式信息，因此任何具有默认值的 CSS 属性都会表现在计算后的样式中。例如，所有浏览器中的 visibility 属性都有一个默认值，但这个值会因实现而异。在默认情况下，有的浏览器将 visibility 属性设置为 "visible"，而有的浏览器则将其设置为 "inherit"。换句话说，不能指望某个 CSS 属性的默认值在不同浏览器中是相同的。如果你需要元素具有某个特定的默认值，应该手工在样式表中指定该值。

12.2.2　操作样式表

CSSStyleSheet 类型表示的是样式表，包括通过 <link> 元素包含的样式表和在 <style> 元素中定义的样式表。有读者可能记得，这两个元素本身分别是由 HTMLLinkElement 和 HTMLStyleElement 类型表示的。但是，CSSStyleSheet 类型相对更加通用一些，它只表示样式表，而不管这些样式表在 HTML 中是如何定义的。此外，上述两个针对元素的类型允许修改 HTML 特性，但 CSSStyleSheet 对象则是一套只读的接口（有一个属性例外）。使用下面的代码可以确定浏览器是否支持 DOM2 级样式表。

var supportsDOM2StyleSheets = document.implementation.hasFeature("StyleSheets", "2.0");

CSSStyleSheet 继承自 StyleSheet，后者可以作为一个基础接口来定义非 CSS 样式表。从 StyleSheet 接口继承而来的属性如下。

disabled：表示样式表是否被禁用的布尔值。这个属性是可读 / 写的，将这个值设置为 true 可以禁用样式表。

href：如果样式表是通过 <link> 包含的，则是样式表的 URL；否则，是 null。

media：当前样式表支持的所有媒体类型的集合。与所有 DOM 集合一样，这个集合也有一个 length 属性和一个 item () 方法。也可以使用方括号语法取得集合中特定的项。如果集合是空列表，表示样式表适用于所有媒体。在 IE 中，media 是一个反映 < link> 和 <style> 元素 media 特性值的字符串。

ownerNode：指向拥有当前样式表的节点的指针，样式表可能是在 HTML 中通过 <link> 或 <style/> 引入的（在 XML 中可能是通过处理指令引入的）。如果当前样式表是其他样式表通过 @import 导入的，则这个属性值为 null。IE 不支持这个属性。

parentStyleSheet：在当前样式表是通过 @import 导入的情况下，这个属性是一个指向导入它的样式表的指针。

title：ownerNode 中 title 属性的值。

type：表示样式表类型的字符串。对 CSS 样式表而言，这个字符串是 "type/css"。

除了 disabled 属性之外，其他属性都是只读的。在支持以上所有这些属性的基础上，CSSStyleSheet 类型还支持下列属性和方法：

cssRules：样式表中包含的样式规则的集合。IE 不支持这个属性，但有一个类似的 rules 属性。

ownerRule：如果样式表是通过 @import 导入的，这个属性就是一个指针，指向表示导入的规则；否则，值为 null。IE 不支持这个属性。

deleteRule (index)：删除 cssRules 集合中指定位置的规则。IE 不支持这个方法，但支持一个类似的 removeRule () 方法。

* insertRule (rule,index)：向 cssRules 集合中指定的位置插入 rule 字符串。IE 不支持这个方法，但支持一个类似的 addRule () 方法。

应用于文档的所有样式表是通过 document.styleSheets 集合来表示的。通过这个集合的 length 属性可以获知文档中样式表的数量，而通过方括号语法或 item () 方法可以访问每一个样式表。来看一个例子。

var sheet = null; for (var i=0, len=document.styleSheets.length; i < len; i++){ sheet = document.styleSheets[i]; alert(sheet.href); }

StyleSheetsExample.htm

以上代码可以输出文档中使用的每一个样式表的 href 属性（<style> 元素包含的样式表没有 href 属性）。

不同浏览器的 document.styleSheets 返回的样式表也不同。所有浏览器都会包含 <style> 元素和 rel 特性被设置为 "stylesheet" 的元素引入的样式表。IE 和 Opera 也包含 rel 特性被设置为 "alternate stylesheet" 的 <link> 元素引入的样式表。

也可以直接通过 <link> 或 <style> 元素取得 CSSStyleSheet 对象。DOM 规定了一个包含 CSSStyleSheet 对象的属性，名叫 sheet；除了 IE，其他浏览器都支持这个属性。IE 支持的是 styleSheet 属性。要想在不同浏览器中都能取得样式表对象，可以使用下列代码。

function getStyleSheet (element){return element.sheet || element.styleSheet;} // 取得第一个 <link/> 元素引入的样式表 var link = document.getElementsByTagName ("link")[0]; var sheet = getStyleSheet (link);

StyleSheetsExample2.htm

这里的 getStylesheet () 返回的样式表对象与 document.styleSheets 集合中的样式表对象相同。

1. CSS 规则

CSSRule 对象表示样式表中的每一条规则。实际上，CSSRule 是一个供其他多种类型继承的基类型，其中最常见的就是 CSSStyleRule 类型，表示样式信息（其他规则还有 @import、@font-face、@page 和 @charset，但这些规则很少有必要通过脚本来访问）。CSSStyleRule 对象包含下列属性。

cssText：返回整条规则对应的文本。由于浏览器对样式表的内部处理方式不同，返回的文本可能会与样式表中实际的文本不一样；Safari 始终都会将文本转换成全部小写。IE 不支持这个属性。

parentRule：如果当前规则是导入的规则，这个属性引用的就是导入规则；否则，这个值为 null。IE 不支持这个属性。

