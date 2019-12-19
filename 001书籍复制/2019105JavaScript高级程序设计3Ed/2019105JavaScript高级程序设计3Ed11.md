4. attributes 属性

Element 类型是使用 attributes 属性的唯一一个 DOM 节点类型。attributes 属性中包含一个 NamedNodeMap，与 NodeList 类似，也是一个「动态」的集合。元素的每一个特性都由一个 Attr 节点表示，每个节点都保存在 NamedNodeMap 对象中。NamedNodeMap 对象拥有下列方法。

getNamedItem_(name)_：返回 nodeName 属性等于 name 的节点；

removeNamedItem_(name)_：从列表中移除 nodeName 属性等于 name 的节点；

setNamedItem_(node)_：向列表中添加节点，以节点的 nodeName 属性为索引；

item_(pos)_：返回位于数字 pos 位置处的节点。

attributes 属性中包含一系列节点，每个节点的 nodeName 就是特性的名称，而节点的 nodeValue 就是特性的值。要取得元素的 id 特性，可以使用以下代码。

var id = element.attributes.getNamedItem("id").nodeValue;

以下是使用方括号语法通过特性名称访问节点的简写方式。

var id = element.attributes["id"].nodeValue;

也可以使用这种语法来设置特性的值，即先取得特性节点，然后再将其 nodeValue 设置为新值，如下所示。

element.attributes["id"].nodeValue = "someOtherId";

调用 removeNamedItem () 方法与在元素上调用 removeAttribute () 方法的效果相同 —— 直接删除具有给定名称的特性。下面的例子展示了两个方法间唯一的区别，即 removeNamedItem () 返回表示被删除特性的 Attr 节点。

var oldAttr = element.attributes.removeNamedItem("id");

最后，setNamedItem () 是一个很不常用的方法，通过这个方法可以为元素添加一个新特性，为此需要为它传入一个特性节点，如下所示。

element.attributes.setNamedItem(newAttr);

一般来说，由于前面介绍的 attributes 的方法不够方便，因此开发人员更多的会使用 getAttribute ()、removeAttribute () 和 setAttribute () 方法。

不过，如果想要遍历元素的特性，attributes 属性倒是可以派上用场。在需要将 DOM 结构序列化为 XML 或 HTML 字符串时，多数都会涉及遍历元素特性。以下代码展示了如何迭代元素的每一个特性，然后将它们构造成 name="value" name="value" 这样的字符串格式。

function outputAttributes(element){ var pairs = new Array(), attrName, attrValue, i, len; for (i=0, len=element.attributes.length; i < len; i++){ attrName = element.attributes[i].nodeName; attrValue = element.attributes[i].nodeValue; pairs.push(attrName + "=\"" + attrValue + "\""); } return pairs.join(" "); }

ElementAttributesExample03.htm

这个函数使用了一个数组来保存名值对，最后再以空格为分隔符将它们拼接起来（这是序列化长字符串时的一种常用技巧）。通过 attributes.length 属性，for 循环会遍历每个特性，将特性的名称和值输出为字符串。关于以上代码的运行结果，以下是两点必要的说明。

针对 attributes 对象中的特性，不同浏览器返回的顺序不同。这些特性在 XML 或 HTML 代码中出现的先后顺序，不一定与它们出现在 attributes 对象中的顺序一致。

IE7 及更早的版本会返回 HTML 元素中所有可能的特性，包括没有指定的特性。换句话说，返回 100 多个特性的情况会很常见。

针对 IE7 及更早版本中存在的问题，可以对上面的函数加以改进，让它只返回指定的特性。每个特性节点都有一个名为 specified 的属性，这个属性的值如果为 true，则意味着要么是在 HTML 中指定了相应特性，要么是通过 setAttribute () 方法设置了该特性。在 IE 中，所有未设置过的特性的该属性值都为 false，而在其他浏览器中根本不会为这类特性生成对应的特性节点（因此，在这些浏览器中，任何特性节点的 specified 值始终为 true）。改进后的代码如下所示。

function outputAttributes(element){ var pairs = new Array(), attrName, attrValue, i, len; for (i=0, len=element.attributes.length; i < len; i++){ attrName = element.attributes[i].nodeName; attrValue = element.attributes[i].nodeValue; if (element.attributes[i].specified) { pairs.push(attrName + "=\"" + attrValue + "\""); } } return pairs.join(" "); }

ElementAttributesExample04.htm

这个经过改进的函数可以确保即使在 IE7 及更早的版本中，也会只返回指定的特性。

5. 创建元素

使用 document.createElement () 方法可以创建新元素。这个方法只接受一个参数，即要创建元素的标签名。这个标签名在 HTML 文档中不区分大小写，而在 XML（包括 XHTML）文档中，则是区分大小写的。例如，使用下面的代码可以创建一个 < div> 元素。

var div = document.createElement("div");

在使用 createElement () 方法创建新元素的同时，也为新元素设置了 ownerDocuemnt 属性。此时，还可以操作元素的特性，为它添加更多子节点，以及执行其他操作。来看下面的例子。

div.id = "myNewDiv"; div.className = "box";

在新元素上设置这些特性只是给它们赋予了相应的信息。由于新元素尚未被添加到文档树中，因此设置这些特性不会影响浏览器的显示。要把新元素添加到文档树，可以使用 appendChild ()、insertBefore () 或 replaceChild () 方法。下面的代码会把新创建的元素添加到文档的 < body> 元素中。

document.body.appendChild(div);

CreateElementExample01.htm

一旦将元素添加到文档树中，浏览器就会立即呈现该元素。此后，对这个元素所作的任何修改都会实时反映在浏览器中。

在 IE 中可以以另一种方式使用 createElement ()，即为这个方法传入完整的元素标签，也可以包含属性，如下面的例子所示。

var div = document.createElement("<div id=\"myNewDiv\" class=\"box\"></div >");

这种方式有助于避开在 IE7 及更早版本中动态创建元素的某些问题。下面是已知的一些这类问题。

不能设置动态创建的 <iframe> 元素的 name 特性。

不能通过表单的 reset () 方法重设动态创建的 < input> 元素（第 13 章将讨论 reset () 方法）。

动态创建的 type 特性值为 "reset" 的 <buttou> 元素重设不了表单。

动态创建的一批 name 相同的单选按钮彼此毫无关系。name 值相同的一组单选按钮本来应该用于表示同一选项的不同值，但动态创建的一批这种单选按钮之间却没有这种关系。

上述所有问题都可以通过在 createElement () 中指定完整的 HTML 标签来解决，如下面的例子所示。

if (client.browser.ie && client.browser.ie <=7){// 创建一个带 name 特性的 iframe 元素 var iframe = document.createElement ("<iframe name=\"myframe\"></iframe>"); // 创建 input 元素 var input = document.createElement ("<input type=\"checkbox\">"); // 创建 button 元素 var button = document.createElement ("<button type=\"reset\"></button>"); // 创建单选按钮 var radio1 = document.createElement ("<input type=\"radio\"name=\"choice\""＋"value=\"1\">"); var radio2 = document.createElement ("<input type=\"radio\" name=\"choice\" "＋"value=\"2\">"); }

与使用 createElement () 的惯常方式一样，这样的用法也会返回一个 DOM 元素的引用。可以将这个引用添加到文档中，也可以对其加以增强。但是，由于这样的用法要求使用浏览器检测，因此我们建议只在需要避开 IE 及更早版本中上述某个问题的情况下使用。其他浏览器都不支持这种用法。

6. 元素的子节点

元素可以有任意数目的子节点和后代节点，因为元素可以是其他元素的子节点。元素的 childNodes 属性中包含了它的所有子节点，这些子节点有可能是元素、文本节点、注释或处理指令。不同浏览器在看待这些节点方面存在显著的不同，以下面的代码为例。

<ul id="myList"> <li>Item 1</li> <li>Item 2</li> <li>Item 3</li> </ul>

如果是 IE 来解析这些代码，那么 <ul> 元素会有 3 个子节点，分别是 3 个 <li> 元素。但如果是在其他浏览器中，<ul> 元素都会有 7 个元素，包括 3 个 <li> 元素和 4 个文本节点（表示 <li> 元素之间的空白符）。如果像下面这样将元素间的空白符删除，那么所有浏览器都会返回相同数目的子节点。

<ul id="myList"><li>Item 1</li><li>Item 2</li><li>Item 3</li></ul>

对于这段代码，<ul> 元素在任何浏览器中都会包含 3 个子节点。如果需要通过 childNodes 属性遍历子节点，那么一定不要忘记浏览器间的这一差别。这意味着在执行某项操作以前，通常都要先检查一下 nodeTpye 属性，如下面的例子所示。

for (var i=0, len=element.childNodes.length; i < len; i++){if (element.childNodes [i].nodeType == 1){// 执行某些操作} }

这个例子会循环遍历特定元素的每一个子节点，然后只在子节点的 nodeType 等于 1（表示是元素节点）的情况下，才会执行某些操作。

如果想通过某个特定的标签名取得子节点或后代节点该怎么办呢？实际上，元素也支持 getElementsByTagName () 方法。在通过元素调用这个方法时，除了搜索起点是当前元素之外，其他方面都跟通过 document 调用这个方法相同，因此结果只会返回当前元素的后代。例如，要想取得前面 < ul> 元素中包含的所有 <li> 元素，可以使用下列代码。

var ul = document.getElementById("myList"); var items = ul.getElementsByTagName("li");

要注意的是，这里 <ul> 的后代中只包含直接子元素。不过，如果它包含更多层次的后代元素，那么各个层次中包含的 <li> 元素也都会返回。

10.1.4　Text 类型

文本节点由 Text 类型表示，包含的是可以照字面解释的纯文本内容。纯文本中可以包含转义后的 HTML 字符，但不能包含 HTML 代码。Text 节点具有以下特征：

nodeType 的值为 3；

nodeName 的值为 "#text"；

nodeValue 的值为节点所包含的文本；

parentNode 是一个 Element；

不支持（没有）子节点。

可以通过 nodeValue 属性或 data 属性访问 Text 节点中包含的文本，这两个属性中包含的值相同。对 nodeValue 的修改也会通过 data 反映出来，反之亦然。使用下列方法可以操作节点中的文本。

appendData (text)：将 text 添加到节点的末尾。

deleteData (offset, count)：从 offset 指定的位置开始删除 count 个字符。

insertData (offset, text)：在 offset 指定的位置插入 text。

replaceData (offset, count, text)：用 text 替换从 offset 指定的位置开始到 offset+ count 为止处的文本。

splitText (offset)：从 offset 指定的位置将当前文本节点分成两个文本节点。

substringData (offset, count)：提取从 offset 指定的位置开始到 offset+count 为止处的字符串。

除了这些方法之外，文本节点还有一个 length 属性，保存着节点中字符的数目。而且，nodeValue.length 和 data.length 中也保存着同样的值。

在默认情况下，每个可以包含内容的元素最多只能有一个文本节点，而且必须确实有内容存在。来看几个例子。

<!-- 没有内容，也就没有文本节点 --> <div></div> <!-- 有空格，因而有一个文本节点 --> <div> </div> <!-- 有内容，因而有一个文本节点 --> <div>Hello World!</div>

上面代码给出的第一个 <div> 元素没有内容，因此也就不存在文本节点。开始与结束标签之间只要存在内容，就会创建一个文本节点。因此，第二个 <div> 元素中虽然只包含一个空格，但仍然有一个文本子节点；文本节点的 nodeValue 值是一个空格。第三个 <div> 也有一个文本节点，其 nodeValue 的值为 "Hello World!"。可以使用以下代码来访问这些文本子节点。

var textNode = div.firstChild; // 或者 div.childNodes [0]

在取得了文本节点的引用后，就可以像下面这样来修改它了。

div.firstChild.nodeValue = "Some other message";

TextNodeExample01.htm

如果这个文本节点当前存在于文档树中，那么修改文本节点的结果就会立即得到反映。另外，在修改文本节点时还要注意，此时的字符串会经过 HTML（或 XML，取决于文档类型）编码。换句话说，小于号、大于号或引号都会像下面的例子一样被转义。

// 输出结果是 "Some &lt;strong&gt;other&lt;/strong&gt; message" div.firstChild.nodeValue = "Some <strong>other</strong> message";

TextNodeExample02.htm

应该说，这是在向 DOM 文档中插入文本之前，先对其进行 HTML 编码的一种有效方式。

在 IE8、Firefox、Safari、Chrome 和 Opera 中，可以通过脚本访问 Text 类型的构造函数和原型。

1. 创建文本节点

可以使用 document.createTextNode () 创建新文本节点，这个方法接受一个参数 —— 要插入节点中的文本。与设置已有文本节点的值一样，作为参数的文本也将按照 HTML 或 XML 的格式进行编码。

var textNode = document.createTextNode("<strong>Hello</strong> world!");

在创建新文本节点的同时，也会为其设置 ownerDocument 属性。不过，除非把新节点添加到文档树中已经存在的节点中，否则我们不会在浏览器窗口中看到新节点。下面的代码会创建一个 <div> 元素并向其中添加一条消息。

var element = document.createElement("div"); element.className = "message"; var textNode = document.createTextNode("Hello world!"); element.appendChild(textNode); document.body.appendChild(element);

TextNodeExample03.htm

这个例子创建了一个新 <div> 元素并为它指定了值为 "message" 的 class 特性。然后，又创建了一个文本节点，并将其添加到前面创建的元素中。最后一步，就是将这个元素添加到了文档的 <body> 元素中，这样就可以在浏览器中看到新创建的元素和文本节点了。

一般情况下，每个元素只有一个文本子节点。不过，在某些情况下也可能包含多个文本子节点，如下面的例子所示。

var element = document.createElement("div"); element.className = "message"; var textNode = document.createTextNode("Hello world!"); element.appendChild(textNode); var anotherTextNode = document.createTextNode("Yippee!"); element.appendChild(anotherTextNode); document.body.appendChild(element);

TextNodeExample04.htm

如果两个文本节点是相邻的同胞节点，那么这两个节点中的文本就会连起来显示，中间不会有空格。

2. 规范化文本节点

DOM 文档中存在相邻的同胞文本节点很容易导致混乱，因为分不清哪个文本节点表示哪个字符串。另外，DOM 文档中出现相邻文本节点的情况也不在少数，于是就催生了一个能够将相邻文本节点合并的方法。这个方法是由 Node 类型定义的（因而在所有节点类型中都存在），名叫 normalize ()。如果在一个包含两个或多个文本节点的父元素上调用 normalize () 方法，则会将所有文本节点合并成一个节点，结果节点的 nodeValue 等于将合并前每个文本节点的 nodeValue 值拼接起来的值。来看一个例子。

var element = document.createElement("div"); element.className = "message"; var textNode = document.createTextNode("Hello world!"); element.appendChild(textNode); var anotherTextNode = document.createTextNode("Yippee!"); element.appendChild(anotherTextNode); document.body.appendChild(element); alert(element.childNodes.length); //2 element.normalize(); alert(element.childNodes.length); //1 alert(element.firstChild.nodeValue); // "Hello world!Yippee!"

TextNodeExample05.htm

浏览器在解析文档时永远不会创建相邻的文本节点。这种情况只会作为执行 DOM 操作的结果出现。

在某些情况下，执行 normalize () 方法会导致 IE6 崩溃。不过，在 IE6 后来的补丁中，可能已经修复了这个问题（未经证实）。IE7 及更高版本中不存在这个问题。

3. 分割文本节点

Text 类型提供了一个作用与 normalize () 相反的方法：splitText ()。这个方法会将一个文本节点分成两个文本节点，即按照指定的位置分割 nodeValue 值。原来的文本节点将包含从开始到指定位置之前的内容，新文本节点将包含剩下的文本。这个方法会返回一个新文本节点，该节点与原节点的 parentNode 相同。来看下面的例子。

var element = document.createElement("div"); element.className = "message"; var textNode = document.createTextNode("Hello world!"); element.appendChild(textNode); document.body.appendChild(element); var newNode = element.firstChild.splitText(5); alert(element.firstChild.nodeValue); //"Hello" alert(newNode.nodeValue); //" world!" alert(element.childNodes.length); //2

TextNodeExample06.htm

在这个例子中，包含 "Hello world!" 的文本节点被分割为两个文本节点，从位置 5 开始。位置 5 是 "Hello" 和 "world!" 之间的空格，因此原来的文本节点将包含字符串 "Hello"，而新文本节点将包含文本 "world!"（包含空格）。

分割文本节点是从文本节点中提取数据的一种常用 DOM 解析技术。

10.1.5　Comment 类型

注释在 DOM 中是通过 Comment 类型来表示的。Comment 节点具有下列特征：

nodeType 的值为 8；

nodeName 的值为 "#comment"；

nodeValue 的值是注释的内容；

parentNode 可能是 Document 或 Element；

不支持（没有）子节点。

Comment 类型与 Text 类型继承自相同的基类，因此它拥有除 splitText () 之外的所有字符串操作方法。与 Text 类型相似，也可以通过 nodeValue 或 data 属性来取得注释的内容。

注释节点可以通过其父节点来访问，以下面的代码为例。

<div id="myDiv"><!--A comment --></div>

在此，注释节点是 <div> 元素的一个子节点，因此可以通过下面的代码来访问它。

var div = document.getElementById("myDiv"); var comment = div.firstChild; alert(comment.data); //"A comment"

CommentNodeExample01.htm

另外，使用 document.createComment () 并为其传递注释文本也可以创建注释节点，如下面的例子所示。

var comment = document.createComment("A comment ");

显然，开发人员很少会创建和访问注释节点，因为注释节点对算法鲜有影响。此外，浏览器也不会识别位于 </html> 标签后面的注释。如果要访问注释节点，一定要保证它们是 <html> 元素的后代（即位于 <html> 和 </html> 之间）。

在 Firefox、Safari、Chrome 和 Opera 中，可以访问 Comment 类型的构造函数和原型。在 IE8 中，注释节点被视作标签名为 "!" 的元素。也就是说，使用 getElementsByTagName () 可以取得注释节点。尽管 IE9 没有把注释当成元素，但它仍然通过一个名为 HTMLCommentElement 的构造函数来表示注释。

10.1.6　CDATASection 类型

CDATASection 类型只针对基于 XML 的文档，表示的是 CDATA 区域。与 Comment 类似，CDATASection 类型继承自 Text 类型，因此拥有除 splitText () 之外的所有字符串操作方法。CDATASection 节点具有下列特征：

nodeType 的值为 4；

nodeName 的值为 "#cdata-section"；

nodeValue 的值是 CDATA 区域中的内容；

parentNode 可能是 Document 或 Element；

不支持（没有）子节点。

CDATA 区域只会出现在 XML 文档中，因此多数浏览器都会把 CDATA 区域错误地解析为 Comment 或 Element。以下面的代码为例：

<div id="myDiv"><![CDATA[This is some content.]]></div>

这个例子中的 <div> 元素应该包含一个 CDATASection 节点。可是，四大主流浏览器无一能够这样解析它。即使对于有效的 XHTML 页面，浏览器也没有正确地支持嵌入的 CDATA 区域。

在真正的 XML 文档中，可以使用 document.createCDataSection () 来创建 CDATA 区域，只需为其传入节点的内容即可。

在 Firefox、Safari、Chrome 和 Opera 中，可以访问 CDATASection 类型的构造函数和原型。IE9 及之前版本不支持这个类型。

10.1.7　DocumentType 类型

DocumentType 类型在 Web 浏览器中并不常用，仅有 Firefox、Safari 和 Opera 支持它 1。DocumentType 包含着与文档的 doctype 有关的所有信息，它具有下列特征：

1 Chrome 4.0 也支持 DocumentType 类型。

nodeType 的值为 10；

nodeName 的值为 doctype 的名称；

nodeValue 的值为 null；

parentNode 是 Document；

不支持（没有）子节点。

在 DOM1 级中，DocumentType 对象不能动态创建，而只能通过解析文档代码的方式来创建。支持它的浏览器会把 DocumentType 对象保存在 document.doctype 中。DOM1 级描述了 DocumentType 对象的 3 个属性：name、entities 和 notations。其中，name 表示文档类型的名称；entities 是由文档类型描述的实体的 NamedNodeMap 对象；notations 是由文档类型描述的符号的 NamedNodeMap 对象。通常，浏览器中的文档使用的都是 HTML 或 XHTML 文档类型，因而 entities 和 notations 都是空列表（列表中的项来自行内文档类型声明）。但不管怎样，只有 name 属性是有用的。这个属性中保存的是文档类型的名称，也就是出现在 <!DOCTYPE 之后的文本。以下面严格型 HTML 4.01 的文档类型声明为例：

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

DocumentType 的 name 属性中保存的就是 "HTML"：

alert(document.doctype.name); //"HTML"

IE 及更早版本不支持 DocumentType，因此 document.doctype 的值始终都等于 null。可是，这些浏览器会把文档类型声明错误地解释为注释，并且为它创建一个注释节点。IE9 会给 document.doctype 赋正确的对象，但仍然不支持访问 DocumentType 类型。

10.1.8　DocumentFragment 类型

在所有节点类型中，只有 DocumentFragment 在文档中没有对应的标记。DOM 规定文档片段（document fragment）是一种「轻量级」的文档，可以包含和控制节点，但不会像完整的文档那样占用额外的资源。DocumentFragment 节点具有下列特征：

nodeType 的值为 11；

nodeName 的值为 "#document-fragment"；

nodeValue 的值为 null；

parentNode 的值为 null；

子节点可以是 Element、ProcessingInstruction、Comment、Text、CDATASection 或 EntityReference。

虽然不能把文档片段直接添加到文档中，但可以将它作为一个「仓库」来使用，即可以在里面保存将来可能会添加到文档中的节点。要创建文档片段，可以使用 document.createDocumentFragment () 方法，如下所示：

var fragment = document.createDocumentFragment();

文档片段继承了 Node 的所有方法，通常用于执行那些针对文档的 DOM 操作。如果将文档中的节点添加到文档片段中，就会从文档树中移除该节点，也不会从浏览器中再看到该节点。添加到文档片段中的新节点同样也不属于文档树。可以通过 appendChild () 或 insertBefore () 将文档片段中内容添加到文档中。在将文档片段作为参数传递给这两个方法时，实际上只会将文档片段的所有子节点添加到相应位置上；文档片段本身永远不会成为文档树的一部分。来看下面的 HTML 示例代码：

<ul id="myList"></ul>

假设我们想为这个 <ul> 元素添加 3 个列表项。如果逐个地添加列表项，将会导致浏览器反复渲染（呈现）新信息。为避免这个问题，可以像下面这样使用一个文档片段来保存创建的列表项，然后再一次性将它们添加到文档中。

var fragment = document.createDocumentFragment(); var ul = document.getElementById("myList"); var li = null; for (var i=0; i < 3; i++){ li = document.createElement("li"); li.appendChild(document.createTextNode("Item " + (i+1))); fragment.appendChild(li); } ul.appendChild(fragment);

DocumentFragmentExample01.htm

在这个例子中，我们先创建一个文档片段并取得了对 <ul> 元素的引用。然后，通过 for 循环创建 3 个列表项，并通过文本表示它们的顺序。为此，需要分别创建 <li> 元素、创建文本节点，再把文本节点添加到 <li> 元素。接着使用 appendChild () 将 < li> 元素添加到文档片段中。循环结束后，再调用 appendChild () 并传入文档片段，将所有列表项添加到 < ul> 元素中。此时，文档片段的所有子节点都被删除并转移到了 <ul> 元素中。

10.1.9　Attr 类型

元素的特性在 DOM 中以 Attr 类型来表示。在所有浏览器中（包括 IE8），都可以访问 Attr 类型的构造函数和原型。从技术角度讲，特性就是存在于元素的 attributes 属性中的节点。特性节点具有下列特征：

nodeType 的值为 11；

nodeName 的值是特性的名称；

nodeValue 的值是特性的值；

parentNode 的值为 null；

在 HTML 中不支持（没有）子节点；

在 XML 中子节点可以是 Text 或 EntityReference。

尽管它们也是节点，但特性却不被认为是 DOM 文档树的一部分。开发人员最常使用的是 getAttribute ()、setAttribute () 和 remveAttribute () 方法，很少直接引用特性节点。

Attr 对象有 3 个属性：name、value 和 specified。其中，name 是特性名称（与 nodeName 的值相同），value 是特性的值（与 nodeValue 的值相同），而 specified 是一个布尔值，用以区别特性是在代码中指定的，还是默认的。

使用 document.createAttribute () 并传入特性的名称可以创建新的特性节点。例如，要为元素添加 align 特性，可以使用下列代码：

var attr = document.createAttribute("align"); attr.value = "left"; element.setAttributeNode(attr); alert(element.attributes["align"].value); //"left" alert(element.getAttributeNode("align").value); //"left" alert(element.getAttribute("align")); //"left"

AttrExample01.htm

这个例子创建了一个新的特性节点。由于在调用 createAttribute () 时已经为 name 属性赋了值，所以后面就不必给它赋值了。之后，又把 value 属性的值设置为 "left"。为了将新创建的特性添加到元素中，必须使用元素的 setAttributeNode () 方法。添加特性之后，可以通过下列任何方式访问该特性：attributes 属性、getAttributeNode () 方法以及 getAttribute () 方法。其中，attributes 和 getAttributeNode () 都会返回对应特性的 Attr 节点，而 getAttribute () 则只返回特性的值。

我们并不建议直接访问特性节点。实际上，使用 getAttribute ()、setAttribute () 和 removeAttribute () 方法远比操作特性节点更为方便。

10.2　DOM 操作技术

很多时候，DOM 操作都比较简明，因此用 JavaScript 生成那些通常原本是用 HTML 代码生成的内容并不麻烦。不过，也有一些时候，操作 DOM 并不像表面上看起来那么简单。由于浏览器中充斥着隐藏的陷阱和不兼容问题，用 JavaScript 代码处理 DOM 的某些部分要比处理其他部分更复杂一些。不过，也有一些时候，操作 DOM 并不像表面上看起来那么简单。

10.2.1　动态脚本

使用 <script> 元素可以向页面中插入 JavaScript 代码，一种方式是通过其 src 特性包含外部文件，另一种方式就是用这个元素本身来包含代码。而这一节要讨论的动态脚本，指的是在页面加载时不存在，但将来的某一时刻通过修改 DOM 动态添加的脚本。跟操作 HTML 元素一样，创建动态脚本也有两种方式：插入外部文件和直接插入 JavaScript 代码。

动态加载的外部 JavaScript 文件能够立即运行，比如下面的 <script> 元素：

<script type="text/javascript" src="client.js"></script>

这个 <script> 元素包含了第 9 章的客户端检测脚本。而创建这个节点的 DOM 代码如下所示：

var script = document.createElement("script"); script.type = "text/javascript"; script.src = "client.js"; document.body.appendChild(script);

显然，这里的 DOM 代码如实反映了相应的 HTML 代码。不过，在执行最后一行代码把 <script> 元素添加到页面中之前，是不会下载外部文件的。也可以把这个元素添加到 <head> 元素中，效果相同。整个过程可以使用下面的函数来封装：

function loadScript(url){ var script = document.createElement("script"); script.type = "text/javascript"; script.src = url; document.body.appendChild(script); }

然后，就可以通过调用这个函数来加载外部的 JavaScript 文件了：

loadScript("client.js");

加载完成后，就可以在页面中的其他地方使用这个脚本了。问题只有一个：怎么知道脚本加载完成呢？遗憾的是，并没有什么标准方式来探知这一点。不过，与此相关的一些事件倒是可以派上用场，但要取决于所用的浏览器，详细讨论请见第 13 章。

另一种指定 JavaScript 代码的方式是行内方式，如下面的例子所示：

<script type="text/javascript"> function sayHi(){ alert("hi"); } </script>

从逻辑上讲，下面的 DOM 代码是有效的：

var script = document.createElement("script"); script.type = "text/javascript"; script.appendChild(document.createTextNode("function sayHi(){alert('hi');}")); document.body.appendChild(script);

在 Firefox、Safari、Chrome 和 Opera 中，这些 DOM 代码可以正常运行。但在 IE 中，则会导致错误。IE 将 <script> 视为一个特殊的元素，不允许 DOM 访问其子节点。不过，可以使用 <script> 元素的 text 属性来指定 JavaScript 代码，像下面的例子这样：

var script = document.createElement("script"); script.type = "text/javascript"; script.text = "function sayHi(){alert('hi');}"; document.body.appendChild(script);

DynamicScriptExample01.htm

经过这样修改之后的代码可以在 IE、Firefox、Opera 和 Safari 3 及之后版本中运行。Safari 3.0 之前的版本虽然不能正确地支持 text 属性，但却允许使用文本节点技术来指定代码。如果需要兼容早期版本的 Safari，可以使用下列代码：

var script = document.createElement("script"); script.type = "text/javascript"; var code = "function sayHi(){alert('hi');}"; try { script.appendChild(document.createTextNode("code")); } catch (ex){ script.text = code; } document.body.appendChild(script);

这里，首先尝试标准的 DOM 文本节点方法，因为除了 IE（在 IE 中会导致抛出错误），所有浏览器都支持这种方式。如果这行代码抛出了错误，那么说明是 IE，于是就必须使用 text 属性了。整个过程可以用以下函数来表示：

function loadScriptString(code){ var script = document.createElement("script"); script.type = "text/javascript"; try { script.appendChild(document.createTextNode(code)); } catch (ex){ script.text = code; } document.body.appendChild(script); }

下面是调用这个函数的示例：

loadScriptString("function sayHi(){alert('hi');}");

DynamicScriptExample02.htm

以这种方式加载的代码会在全局作用域中执行，而且当脚本执行后将立即可用。实际上，这样执行代码与在全局作用域中把相同的字符串传递给 eval () 是一样的。

10.2.2　动态样式

能够把 CSS 样式包含到 HTML 页面中的元素有两个。其中，<link> 元素用于包含来自外部的文件，而 <style> 元素用于指定嵌入的样式。与动态脚本类似，所谓动态样式是指在页面刚加载时不存在的样式；动态样式是在页面加载完成后动态添加到页面中的。

我们以下面这个典型的 <link> 元素为例：

<link rel="stylesheet" type="text/css" href="styles.css">

使用 DOM 代码可以很容易地动态创建出这个元素：

var link = document.createElement("link"); link.rel = "stylesheet"; link.type = "text/css"; link.href = "style.css"; var head = document.getElementsByTagName("head")[0]; head.appendChild(link);

以上代码在所有主流浏览器中都可以正常运行。需要注意的是，必须将 <link> 元素添加到 <head> 而不是 <body> 元素，才能保证在所有浏览器中的行为一致。整个过程可以用以下函数来表示：

function loadStyles(url){ var link = document.createElement("link"); link.rel = "stylesheet"; link.type = "text/css"; link.href = url; var head = document.getElementsByTagName("head")[0]; head.appendChild(link); }

调用 loadStyles () 函数的代码如下所示：

loadStyles("styles.css");

加载外部样式文件的过程是异步的，也就是加载样式与执行 JavaScript 代码的过程没有固定的次序。一般来说，知不知道样式已经加载完成并不重要；不过，也存在几种利用事件来检测这个过程是否完成的技术，这些技术将在第 13 章讨论。

另一种定义样式的方式是使用 <style> 元素来包含嵌入式 CSS，如下所示：

<style type="text/css"> body { background-color: red; } </style>

按照相同的逻辑，下列 DOM 代码应该是有效的：

var style = document.createElement("style"); style.type = "text/css"; style.appendChild(document.createTextNode("body{background-color:red}")); var head = document.getElementsByTagName("head")[0]; head.appendChild(style);

DynamicStyleExample01.htm

以上代码可以在 Firefox、Safari、Chrome 和 Opera 中运行，在 IE 中则会报错。IE 将 <style> 视为一个特殊的、与 <script> 类似的节点，不允许访问其子节点。事实上，IE 此时抛出的错误与向 <script> 元素添加子节点时抛出的错误相同。解决 IE 中这个问题的办法，就是访问元素的 styleSheet 属性，该属性又有一个 cssText 属性，可以接受 CSS 代码（第 13 章将进一步讨论这两个属性），如下面的例子所示。

var style = document.createElement("style"); style.type = "text/css"; try{ style.appendChild(document.createTextNode("body{background-color:red}")); } catch (ex){ style.styleSheet.cssText = "body{background-color:red}"; } var head = document.getElementsByTagName("head")[0]; head.appendChild(style);

与动态添加嵌入式脚本类似，重写后的代码使用了 try-catch 语句来捕获 IE 抛出的错误，然后再使用针对 IE 的特殊方式来设置样式。因此，通用的解决方案如下。

function loadStyleString(css){ var style = document.createElement("style"); style.type = "text/css"; try{ style.appendChild(document.createTextNode(css)); } catch (ex){ style.styleSheet.cssText = css; } var head = document.getElementsByTagName("head")[0]; head.appendChild(style); }

DynamicStyleExample02.htm

调用这个函数的示例如下：

loadStyleString("body{background-color:red}");

这种方式会实时地向页面中添加样式，因此能够马上看到变化。

如果专门针对 IE 编写代码，务必小心使用 styleSheet.cssText 属性。在重用同一个 <style> 元素并再次设置这个属性时，有可能会导致浏览器崩溃。同样，将 cssText 属性设置为空字符串也可能导致浏览器崩溃。我们希望 IE 中的这个 bug 能够在将来被修复。

10.2.3　操作表格

<table> 元素是 HTML 中最复杂的结构之一。要想创建表格，一般都必须涉及表示表格行、单元格、表头等方面的标签。由于涉及的标签多，因而使用核心 DOM 方法创建和修改表格往往都免不了要编写大量的代码。假设我们要使用 DOM 来创建下面的 HTML 表格。

<table border="1" width="100%"> <tbody> <tr> <td>Cell 1,1</td> <td>Cell 2,1</td> </tr> <tr> <td>Cell 1,2</td> <td>Cell 2,2</td> </tr> </tbody> </table>

要使用核心 DOM 方法创建这些元素，得需要像下面这么多的代码：

// 创建 table var table = document.createElement ("table"); table.border = 1; table.width = "100%"; // 创建 tbody var tbody = document.createElement ("tbody"); table.appendChild (tbody); // 创建第一行 var row1 = document.createElement ("tr"); tbody.appendChild (row1); var cell1_1 = document.createElement ("td"); cell1_1.appendChild (document.createTextNode ("Cell 1,1")); row1.appendChild (cell1_1); var cell2_1 = document.createElement ("td"); cell2_1.appendChild (document.createTextNode ("Cell 2,1")); row1.appendChild (cell2_1); // 创建第二行 var row2 = document.createElement ("tr"); tbody.appendChild (row2); var cell1_2 = document.createElement ("td"); cell1_2.appendChild (document.createTextNode ("Cell 1,2")); row2.appendChild (cell1_2); var cell2_2= document.createElement ("td"); cell2_2.appendChild (document.createTextNode ("Cell 2,2")); row2.appendChild (cell2_2); // 将表格添加到文档主体中 document.body.appendChild (table);

显然，DOM 代码很长，还有点不太好懂。为了方便构建表格，HTML DOM 还为 <table>、<tbody> 和 <tr> 元素添加了一些属性和方法。

为元素添加的属性和方法如下。

caption：保存着对 <caption> 元素（如果有）的指针。

tBodies：是一个 <tbody> 元素的 HTMLCollection。

tFoot：保存着对 <tfoot> 元素（如果有）的指针。

tHead：保存着对 <thead> 元素（如果有）的指针。

rows：是一个表格中所有行的 HTMLCollection。

createTHead ()：创建 < thead> 元素，将其放到表格中，返回引用。

createTFoot ()：创建 < tfoot> 元素，将其放到表格中，返回引用。

createCaption ()：创建 < caption> 元素，将其放到表格中，返回引用。

deleteTHead ()：删除 < thead> 元素。

deleteTFoot ()：删除 < tfoot> 元素。

deleteCaption ()：删除 < caption> 元素。

deleteRow (_pos_)：删除指定位置的行。

insertRow (_pos_)：向 rows 集合中的指定位置插入一行。

为 <tbody> 元素添加的属性和方法如下。

rows：保存着 <tbody> 元素中行的 HTMLCollection。

deleteRow (pos)：删除指定位置的行。

insertRow (pos)：向 rows 集合中的指定位置插入一行，返回对新插入行的引用。

为 <tr> 元素添加的属性和方法如下。

cells：保存着 <tr> 元素中单元格的 HTMLCollection。

deleteCell (pos)：删除指定位置的单元格。

insertCell (pos)：向 cells 集合中的指定位置插入一个单元格，返回对新插入单元格的引用。

使用这些属性和方法，可以极大地减少创建表格所需的代码数量。例如，使用这些属性和方法可以将前面的代码重写如下（加阴影的部分是重写后的代码）。

// 创建 table var table = document.createElement ("table"); table.border = 1; table.width = "100%"; // 创建 tbody var tbody = document.createElement ("tbody"); table.appendChild (tbody); // 创建第一行 tbody.insertRow (0); tbody.rows [0].insertCell (0); tbody.rows [0].cells [0].appendChild (document.createTextNode ("Cell 1,1")); tbody.rows [0].insertCell (1); tbody.rows [0].cells [1].appendChild (document.createTextNode ("Cell 2,1")); // 创建第二行 tbody.insertRow (1); tbody.rows [1].insertCell (0); tbody.rows [1].cells [0].appendChild (document.createTextNode ("Cell 1,2")); tbody.rows [1].insertCell (1); tbody.rows [1].cells [1].appendChild (document.createTextNode ("Cell 2,2")); // 将表格添加到文档主体中 document.body.appendChild (table);

在这次的代码中，创建 <table> 和 <tbody> 的代码没有变化。不同的是创建两行的部分，其中使用了 HTML DOM 定义的表格属性和方法。在创建第一行时，通过 <tbody> 元素调用了 insertRow () 方法，传入了参数 0—— 表示应该将插入的行放在什么位置上。执行这一行代码后，就会自动创建一行并将其插入到 < tbody> 元素的位置 0 上，因此就可以马上通过 tbody.rows [0] 来引用新插入的行。

创建单元格的方式也十分相似，即通过 <tr> 元素调用 insertCell () 方法并传入放置单元格的位置。然后，就可以通过 tbody.rows [0].cells [0] 来引用新插入的单元格，因为新创建的单元格被插入到了这一行的位置 0 上。

总之，使用这些属性和方法创建表格的逻辑性更强，也更容易看懂，尽管技术上这两套代码都是正确的。

10.2.4　使用 NodeList

理解 NodeList 及其「近亲」NamedNodeMap 和 HTMLCollection，是从整体上透彻理解 DOM 的关键所在。这三个集合都是「动态的」；换句话说，每当文档结构发生变化时，它们都会得到更新。因此，它们始终都会保存着最新、最准确的信息。从本质上说，所有 NodeList 对象都是在访问 DOM 文档时实时运行的查询。例如，下列代码会导致无限循环：

var divs = document.getElementsByTagName("div"), i, div; for (i=0; i < divs.length; i++){ div = document.createElement("div"); document.body.appendChild(div); }

第一行代码会取得文档中所有 <div> 元素的 HTMLCollection。由于这个集合是「动态的」，因此只要有新 <div> 元素被添加到页面中，这个元素也会被添加到该集合中。浏览器不会将创建的所有集合都保存在一个列表中，而是在下一次访问集合时再更新集合。结果，在遇到上例中所示的循环代码时，就会导致一个有趣的问题。每次循环都要对条件 i <divs.length 求值，意味着会运行取得所有 < div> 元素的查询。考虑到循环体每次都会创建一个新 <div> 元素并将其添加到文档中，因此 divs.length 的值在每次循环后都会递增。既然 i 和 divs.length 每次都会同时递增，结果它们的值永远也不会相等。

如果想要迭代一个 NodeList，最好是使用 length 属性初始化第二个变量，然后将迭代器与该变量进行比较，如下面的例子所示：

var divs = document.getElementsByTagName("div"), i, len, div; for (i=0, len=divs.length; i < len; i++){ div = document.createElement("div"); document.body.appendChild(div); }

这个例子中初始化了第二个变量 len。由于 len 中保存着对 divs.length 在循环开始时的一个快照，因此就会避免上一个例子中出现的无限循环问题。在本章演示迭代 NodeList 对象的例子中，使用的都是这种更为保险的方式。

一般来说，应该尽量减少访问 NodeList 的次数。因为每次访问 NodeList，都会运行一次基于文档的查询。所以，可以考虑将从 NodeList 中取得的值缓存起来。

10.3　小结

DOM 是语言中立的 API，用于访问和操作 HTML 和 XML 文档。DOM1 级将 HTML 和 XML 文档形象地看作一个层次化的节点树，可以使用 JavaScript 来操作这个节点树，进而改变底层文档的外观和结构。

DOM 由各种节点构成，简要总结如下。

最基本的节点类型是 Node，用于抽象地表示文档中一个独立的部分；所有其他类型都继承自 Node。

Document 类型表示整个文档，是一组分层节点的根节点。在 JavaScript 中，document 对象是 Document 的一个实例。使用 document 对象，有很多种方式可以查询和取得节点。

Element 节点表示文档中的所有 HTML 或 XML 元素，可以用来操作这些元素的内容和特性。

另外还有一些节点类型，分别表示文本内容、注释、文档类型、CDATA 区域和文档片段。

访问 DOM 的操作在多数情况下都很直观，不过在处理 <script> 和 <style> 元素时还是存在一些复杂性。由于这两个元素分别包含脚本和样式信息，因此浏览器通常会将它们与其他元素区别对待。这些区别导致了在针对这些元素使用 innerHTML 时，以及在创建新元素时的一些问题。

理解 DOM 的关键，就是理解 DOM 对性能的影响。DOM 操作往往是 JavaScript 程序中开销最大的部分，而因访问 NodeList 导致的问题为最多。NodeList 对象都是「动态的」，这就意味着每次访问 NodeList 对象，都会运行一次查询。有鉴于此，最好的办法就是尽量减少 DOM 操作。

第 11 章　DOM 扩展

本章内容

理解 Selectors API

使用 HTML5 DOM 扩展

了解专有的 DOM 扩展

尽管 DOM 作为 API 已经非常完善了，但为了实现更多的功能，仍然会有一些标准或专有的扩展。2008 年之前，浏览器中几乎所有的 DOM 扩展都是专有的。此后，W3C 着手将一些已经成为事实标准的专有扩展标准化并写入规范当中。

对 DOM 的两个主要的扩展是 Selectors API（选择符 API）和 HTML5。这两个扩展都源自开发社区，而将某些常见做法及 API 标准化一直是众望所归。此外，还有一个不那么引人瞩目的 Element Traversal（元素遍历）规范，为 DOM 添加了一些属性。虽然前述两个主要规范（特别是 HTML5）已经涵盖了大量的 DOM 扩展，但专有扩展依然存在。本章也会介绍专有的 DOM 扩展。

11.1　选择符 API

众多 JavaScript 库中最常用的一项功能，就是根据 CSS 选择符选择与某个模式匹配的 DOM 元素。实际上，jQuery（www.jquery.com）的核心就是通过 CSS 选择符查询 DOM 文档取得元素的引用，从而抛开了 getElementById () 和 getElementsByTagName ()。

Selectors API（www.w3.org/TR/selectors-api/）是由 W3C 发起制定的一个标准，致力于让浏览器原生支持 CSS 查询。所有实现这一功能的 JavaScript 库都会写一个基础的 CSS 解析器，然后再使用已有的 DOM 方法查询文档并找到匹配的节点。尽管库开发人员在不知疲倦地改进这一过程的性能，但到头来都只能通过运行 JavaScript 代码来完成查询操作。而把这个功能变成变成原生 API 之后，解析和树查询操作可以在浏览器内部通过编译后的代码来完成，极大地改善了性能。

Selectors API Level 1 的核心是两个方法：querySelector () 和 querySelectorAll ()。在兼容的浏览器中，可以通过 Document 及 Element 类型的实例调用它们。目前已完全支持 Selectors API Level 1 的浏览器有 IE 8+、Firefox 3.5+、Safari 3.1+、Chrome 和 Opera 10+。

11.1.1　querySelector () 方法

querySelector () 方法接收一个 CSS 选择符，返回与该模式匹配的第一个元素，如果没有找到匹配的元素，返回 null。请看下面的例子。

// 取得 body 元素 var body = document.querySelector ("body"); // 取得 ID 为 "myDiv" 的元素 var myDiv = document.querySelector ("#myDiv"); // 取得类为 "selected" 的第一个元素 var selected = document.querySelector (".selected"); // 取得类为 "button" 的第一个图像元素 var img = document.body.querySelector ("img.button");

SelectorsAPIExample01.htm

通过 Doument 类型调用 querySelector () 方法时，会在文档元素的范围内查找匹配的元素。而通过 Element 类型调用 querySelector () 方法时，只会在该元素后代元素的范围内查找匹配的元素。

CSS 选择符可以简单也可以复杂，视情况而定。如果传入了不被支持的选择符，querySelector () 会抛出错误。

11.1.2　querySelectorAll () 方法

querySelectorAll () 方法接收的参数与 querySelector () 方法一样，都是一个 CSS 选择符，但返回的是所有匹配的元素而不仅仅是一个元素。这个方法返回的是一个 NodeList 的实例。

具体来说，返回的值实际上是带有所有属性和方法的 NodeList，而其底层实现则类似于一组元素的快照，而非不断对文档进行搜索的动态查询。这样实现可以避免使用 NodeList 对象通常会引起的大多数性能问题。

只要传给 querySelectorAll () 方法的 CSS 选择符有效，该方法都会返回一个 NodeList 对象，而不管找到多少匹配的元素。如果没有找到匹配的元素，NodeList 就是空的。

与 querySelector () 类似，能够调用 querySelectorAll () 方法的类型包括 Document、DocumentFragment 和 Element。下面是几个例子。

// 取得某 <div> 中的所有 <em> 元素（类似于 getElementsByTagName ("em")） var ems = document.getElementById ("myDiv").querySelectorAll ("em"); // 取得类为 "selected" 的所有元素 var selecteds = document.querySelectorAll (".selected"); // 取得所有 <p> 元素中的所有 <strong> 元素 var strongs = document.querySelectorAll ("p strong");

SelectorsAPIExample02.htm

要取得返回的 NodeList 中的每一个元素，可以使用 item () 方法，也可以使用方括号语法，比如：

var i, len, strong; for (i=0, len=strongs.length; i < len; i++){strong = strongs [i]; // 或者 strongs.item (i) strong.className = "important"; }

同样与 querySelector () 类似，如果传入了浏览器不支持的选择符或者选择符中有语法错误，querySelectorAll () 会抛出错误。

11.1.3　matchesSelector () 方法

Selectors API Level 2 规范为 Element 类型新增了一个方法 matchesSelector ()。这个方法接收一个参数，即 CSS 选择符，如果调用元素与该选择符匹配，返回 true；否则，返回 false。看例子。

if (document.body.matchesSelector("body.page1")){ //true }

在取得某个元素引用的情况下，使用这个方法能够方便地检测它是否会被 querySelector () 或 querySelectorAll () 方法返回。

截至 2011 年年中，还没有浏览器支持 matchesSelector () 方法；不过，也有一些实验性的实现。IE 9 + 通过 msMatchesSelector () 支持该方法，Firefox 3.6 + 通过 mozMatchesSelector () 支持该方法，Safari 5 + 和 Chrome 通过 webkitMatchesSelector 支持该方法。因此，如果你想使用这个方法，最好是编写一个包装函数。

function matchesSelector (element, selector){if (element.matchesSelector){return element.matchesSelector (selector); } else if (element.msMatchesSelector){return element.msMatchesSelector (selector); } else if (element.mozMatchesSelector){return element.mozMatchesSelector (selector); } else if (element.webkitMatchesSelector){return element.webkitMatchesSelector (selector); } else {throw new Error ("Not supported."); } } if (matchesSelector (document.body, "body.page1")){// 执行操作}

SelectorsAPIExample03.htm

11.2　元素遍历

对于元素间的空格，IE9 及之前版本不会返回文本节点，而其他所有浏览器都会返回文本节点。这样，就导致了在使用 childNodes 和 firstChild 等属性时的行为不一致。为了弥补这一差异，而同时又保持 DOM 规范不变，Element Traversal 规范（www.w3.org/TR/ElementTraversal/）新定义了一组属性。

Element Traversal API 为 DOM 元素添加了以下 5 个属性。

childElementCount：返回子元素（不包括文本节点和注释）的个数。

firstElementChild：指向第一个子元素；firstChild 的元素版。

lastElementChild：指向最后一个子元素；lastChild 的元素版。

previousElementSibling：指向前一个同辈元素；previousSibling 的元素版。

nextElementSibling：指向后一个同辈元素；nextSibling 的元素版。

支持的浏览器为 DOM 元素添加了这些属性，利用这些元素不必担心空白文本节点，从而可以更方便地查找 DOM 元素了。

下面来看一个例子。过去，要跨浏览器遍历某元素的所有子元素，需要像下面这样写代码。

var i, len, child = element.firstChild; while (child != element.lastChild){if (child.nodeType == 1){// 检查是不是元素 processChild (child); } child = child.nextSibling; }

而使用 Element Traversal 新增的元素，代码会更简洁。

var i, len, child = element.firstElementChild; while (child != element.lastElementChild){processChild (child); // 已知其是元素 child = child.nextElementSibling; }

支持 Element Traversal 规范的浏览器有 IE 9+、Firefox 3.5+、Safari 4+、Chrome 和 Opera 10+。

11.3　HTML5

对于传统 HTML 而言，HTML5 是一个叛逆。所有之前的版本对 JavaScript 接口的描述都不过三言两语，主要篇幅都用于定义标记，与 JavaScript 相关的内容一概交由 DOM 规范去定义。

而 HTML5 规范则围绕如何使用新增标记定义了大量 JavaScript API。其中一些 API 与 DOM 重叠，定义了浏览器应该支持的 DOM 扩展。

因为 HTML5 涉及的面非常广，本节只讨论与 DOM 节点相关的内容。HTML5 的其他相关内容将在本书其他章节中穿插介绍。

11.3.1　与类相关的扩充

HTML4 在 Web 开发领域得到广泛采用后导致了一个很大的变化，即 class 属性用得越来越多，一方面可以通过它为元素添加样式，另一方面还可以用它表示元素的语义。于是，自然就有很多 JavaScript 代码会来操作 CSS 类，比如动态修改类或者搜索文档中具有给定类或给定的一组类的元素，等等。为了让开发人员适应并增加对 class 属性的新认识，HTML5 新增了很多 API，致力于简化 CSS 类的用法。

1. getElementsByClassName () 方法

HTML5 添加的 getElementsByClassName () 方法是最受人欢迎的一个方法，可以通过 document 对象及所有 HTML 元素调用该方法。这个方法最早出现在 JavaScript 库中，是通过既有的 DOM 功能实现的，而原生的实现具有极大的性能优势。

getElementsByClassName () 方法接收一个参数，即一个包含一或多个类名的字符串，返回带有指定类的所有元素的 NodeList。传入多个类名时，类名的先后顺序不重要。来看下面的例子。

// 取得所有类中包含 "username" 和 "current" 的元素，类名的先后顺序无所谓 var allCurrentUsernames = document.getElementsByClassName ("username current"); // 取得 ID 为 "myDiv" 的元素中带有类名 "selected" 的所有元素 var selected = document.getElementById ("myDiv").getElementsByClassName ("selected");

调用这个方法时，只有位于调用元素子树中的元素才会返回。在 document 对象上调用 getElementsByClassName () 始终会返回与类名匹配的所有元素，在元素上调用该方法就只会返回后代元素中匹配的元素。

使用这个方法可以更方便地为带有某些类的元素添加事件处理程序，从而不必再局限于使用 ID 或标签名。不过别忘了，因为返回的对象是 NodeList，所以使用这个方法与使用 getElementsByTagName () 以及其他返回 NodeList 的 DOM 方法都具有同样的性能问题。

支持 getElementsByClassName () 方法的浏览器有 IE 9+、Firefox 3+、Safari 3.1+、Chrome 和 Opera 9.5+。

2. classList 属性

在操作类名时，需要通过 className 属性添加、删除和替换类名。因为 className 中是一个字符串，所以即使只修改字符串一部分，也必须每次都设置整个字符串的值。比如，以下面的 HTML 代码为例。

<div class="bd user disabled">...</div>

这个 <div> 元素一共有三个类名。要从中删除一个类名，需要把这三个类名拆开，删除不想要的那个，然后再把其他类名拼成一个新字符串。请看下面的例子。

// 删除 "user" 类 // 首先，取得类名字符串并拆分成数组 var classNames = div.className.split (/\s+/); // 找到要删的类名 var pos = -1, i, len; for (i=0, len=classNames.length; i < len; i++){if (classNames [i] == "user"){pos = i; break;} } // 删除类名 classNames.splice (i,1); // 把剩下的类名拼成字符串并重新设置 div.className = classNames.join (" ");

为了从 <div> 元素的 class 属性中删除 "user"，以上这些代码都是必需的。必须得通过类似的算法替换类名并确认元素中是否包含该类名。添加类名可以通过拼接字符串完成，但必须要通过检测确定不会多次添加相同的类名。很多 JavaScript 库都实现了这个方法，以简化这些操作。

HTML5 新增了一种操作类名的方式，可以让操作更简单也更安全，那就是为所有元素添加 classList 属性。这个 classList 属性是新集合类型 DOMTokenList 的实例。与其他 DOM 集合类似，DOMTokenList 有一个表示自己包含多少元素的 length 属性，而要取得每个元素可以使用 item () 方法，也可以使用方括号语法。此外，这个新类型还定义如下方法。

add (value)：将给定的字符串值添加到列表中。如果值已经存在，就不添加了。

contains (value)：表示列表中是否存在给定的值，如果存在则返回 true，否则返回 false。

remove (value)：从列表中删除给定的字符串。

toggle (value)：如果列表中已经存在给定的值，删除它；如果列表中没有给定的值，添加它。

这样，前面那么多行代码用下面这一行代码就可以代替了：

div.classList.remove("user");

以上代码能够确保其他类名不受此次修改的影响。其他方法也能极大地减少类似基本操作的复杂性，如下面的例子所示。

// 删除 "disabled" 类 div.classList.remove ("disabled"); // 添加 "current" 类 div.classList.add ("current"); // 切换 "user" 类 div.classList.toggle ("user"); // 确定元素中是否包含既定的类名 if (div.classList.contains ("bd") && !div.classList.contains ("disabled")){// 执行操作) // 迭代类名 for (var i=0, len=div.classList.length; i < len; i++){doSomething (div.classList [i]); }

有了 classList 属性，除非你需要全部删除所有类名，或者完全重写元素的 class 属性，否则也就用不到 className 属性了。

支持 classList 属性的浏览器有 Firefox 3.6 + 和 Chrome。

11.3.2　焦点管理

HTML5 也添加了辅助管理 DOM 焦点的功能。首先就是 document.activeElement 属性，这个属性始终会引用 DOM 中当前获得了焦点的元素。元素获得焦点的方式有页面加载、用户输入（通常是通过按 Tab 键）和在代码中调用 focus () 方法。来看几个例子。

var button = document.getElementById("myButton"); button.focus(); alert(document.activeElement === button); //true

默认情况下，文档刚刚加载完成时，document.activeElement 中保存的是 document.body 元素的引用。文档加载期间，document.activeElement 的值为 null。

另外就是新增了 document.hasFocus () 方法，这个方法用于确定文档是否获得了焦点。

var button = document.getElementById("myButton"); button.focus(); alert(document.hasFocus()); //true

通过检测文档是否获得了焦点，可以知道用户是不是正在与页面交互。

查询文档获知哪个元素获得了焦点，以及确定文档是否获得了焦点，这两个功能最重要的用途是提高 Web 应用的无障碍性。无障碍 Web 应用的一个主要标志就是恰当的焦点管理，而确切地知道哪个元素获得了焦点是一个极大的进步，至少我们不用再像过去那样靠猜测了。

实现了这两个属性的浏览器的包括 IE 4+、Firefox 3+、Safari 4+、Chrome 和 Opera 8+。

11.3.3　HTMLDocument 的变化

HTML5 扩展了 HTMLDocument，增加了新的功能。与 HTML5 中新增的其他 DOM 扩展类似，这些变化同样基于那些已经得到很多浏览器完美支持的专有扩展。所以，尽管这些扩展被写入标准的时间相对不长，但很多浏览器很早就已经支持这些功能了。

1. readyState 属性

IE4 最早为 document 对象引入了 readyState 属性。然后，其他浏览器也都陆续添加这个属性，最终 HTML5 把这个属性纳入了标准当中。Document 的 readyState 属性有两个可能的值：

loading，正在加载文档；

complete，已经加载完文档。

使用 document.readyState 的最恰当方式，就是通过它来实现一个指示文档已经加载完成的指示器。在这个属性得到广泛支持之前，要实现这样一个指示器，必须借助 onload 事件处理程序设置一个标签，表明文档已经加载完毕。document.readyState 属性的基本用法如下。

if (document.readyState == "complete"){// 执行操作}

支持 readyState 属性的浏览器有 IE4+、Firefox 3.6+、Safari、Chrome 和 Opera 9+。

2. 兼容模式

自从 IE6 开始区分渲染页面的模式是标准的还是混杂的，检测页面的兼容模式就成为浏览器的必要功能。IE 为此给 document 添加了一个名为 compatMode 的属性，这个属性就是为了告诉开发人员浏览器采用了哪种渲染模式。就像下面例子中所展示的那样，在标准模式下，document.compatMode 的值等于 "CSS1Compat"，而在混杂模式下，document.compatMode 的值等于 "BackCompat"。

if (document.compatMode == "CSS1Compat"){ alert("Standards mode"); } else { alert("Quirks mode"); }

后来，陆续实现这个属性的浏览器有 Firefox、Safari 3.1+、Opera 和 Chrome。最终，HTML5 也把这个属性纳入标准，对其实现做出了明确规定。

3. head 属性

作为对 document.body 引用文档的 <body> 元素的补充，HTML5 新增了 document.head 属性，引用文档的 <head> 元素。要引用文档的 <head> 元素，可以结合使用这个属性和另一种后备方法。

var head = document.head || document.getElementsByTagName("head")[0];

如果可用，就使用 document.head，否则仍然使用 getElementsByTagName () 方法。

实现 document.head 属性的浏览器包括 Chrome 和 Safari 5。

11.3.4　字符集属性

HTML5 新增了几个与文档字符集有关的属性。其中，charset 属性表示文档中实际使用的字符集，也可以用来指定新字符集。默认情况下，这个属性的值为 "UTF-16"，但可以通过 <meta> 元素、响应头部或直接设置 charset 属性修改这个值。来看一个例子。

alert(document.charset); //"UTF-16" document.charset = "UTF-8";

