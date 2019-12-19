parentStyleSheet：当前规则所属的样式表。IE 不支持这个属性。

selectorText：返回当前规则的选择符文本。由于浏览器对样式表的内部处理方式不同，返回的文本可能会与样式表中实际的文本不一样（例如，Safari 3 之前的版本始终会将文本转换成全部小写）。在 Firefox、Safari、Chrome 和 IE 中这个属性是只读的。Opera 允许修改 selectorText。

style：一个 CSSStyleDeclaration 对象，可以通过它设置和取得规则中特定的样式值。

type：表示规则类型的常量值。对于样式规则，这个值是 1。IE 不支持这个属性。

其中三个最常用的属性是 cssText、selectorText 和 style。cssText 属性与 style.cssText 属性类似，但并不相同。前者包含选择符文本和围绕样式信息的花括号，后者只包含样式信息（类似于元素的 style.cssText）。此外，cssText 是只读的，而 style.cssText 也可以被重写。

大多数情况下，仅使用 style 属性就可以满足所有操作样式规则的需求了。这个对象就像每个元素上的 style 属性一样，可以通过它读取和修改规则中的样式信息。以下面的 CSS 规则为例。

div.box { background-color: blue; width: 100px; height: 200px; }

CSSRulesExample.htm

假设这条规则位于页面中的第一个样式表中，而且这个样式表中只有这一条样式规则，那么通过下列代码可以取得这条规则的各种信息。

var sheet = document.styleSheets [0]; var rules = sheet.cssRules || sheet.rules; // 取得规则列表 var rule = rules [0]; // 取得第一条规则 alert (rule.selectorText); //"div.box" alert (rule.style.cssText); // 完整的 CSS 代码 alert (rule.style.backgroundColor); //"blue" alert (rule.style.width); //"100px" alert (rule.style.height); //"200px"

CSSRulesExample.htm

使用这种方式，可以像确定元素的行内样式信息一样，确定与规则相关的样式信息。与使用元素的方式一样，在这种方式下也可以修改样式信息，如下面的例子所示。

var sheet = document.styleSheets [0]; var rules = sheet.cssRules || sheet.rules; // 取得规则列表 var rule = rules [0]; // 取得第一条规则 rule.style.backgroundColor = "red"

CSSRulesExample.htm

必须要注意的是，以这种方式修改规则会影响页面中适用于该规则的所有元素。换句话说，如果有两个带有 box 类的 <div> 元素，那么这两个元素都会应用修改后的样式。

2. 创建规则

DOM 规定，要向现有样式表中添加新规则，需要使用 insertRule () 方法。这个方法接受两个参数：规则文本和表示在哪里插入规则的索引。下面是一个例子。

sheet.insertRule ("body { background-color: silver}", 0); //DOM 方法

这个例子插入的规则会改变元素的背景颜色。插入的规则将成为样式表中的第一条规则（插入到了位置 0）—— 规则的次序在确定层叠之后应用到文档的规则时至关重要。Firefox、Safari、Opera 和 Chrome 都支持 insertRule () 方法。

IE8 及更早版本支持一个类似的方法，名叫 addRule ()，也接收两必选参数：选择符文本和 CSS 样式信息；一个可选参数：插入规则的位置。在 IE 中插入与前面例子相同的规则，可使用如下代码。

sheet.addRule ("body", "background-color: silver", 0); // 仅对 IE 有效

有关这个方法的规定中说，最多可以使用 addRule () 添加 4 095 条样式规则。超出这个上限的调用将会导致错误。

要以跨浏览器的方式向样式表中插入规则，可以使用下面的函数。这个函数接受 4 个参数：要向其中添加规则的样式表以及与 addRule () 相同的 3 个参数，如下所示。

function insertRule(sheet, selectorText, cssText, position){ if (sheet.insertRule){ sheet.insertRule(selectorText + "{" + cssText + "}", position); } else if (sheet.addRule){ sheet.addRule(selectorText, cssText, position); } }

CSSRulesExample2.htm

下面是调用这个函数的示例代码。

insertRule(document.styleSheets[0], "body", "background-color: silver", 0);

虽然可以像这样来添加规则，但随着要添加规则的增多，这种方法就会变得非常繁琐。因此，如果要添加的规则非常多，我们建议还是采用第 10 章介绍过的动态加载样式表的技术。

3. 删除规则

从样式表中删除规则的方法是 deleteRule ()，这个方法接受一个参数：要删除的规则的位置。例如，要删除样式表中的第一条规则，可以使用以下代码。

sheet.deleteRule (0); //DOM 方法

IE 支持的类似方法叫 removeRule ()，使用方法相同，如下所示：

sheet.removeRule (0); // 仅对 IE 有效

下面是一个能够跨浏览器删除规则的函数。第一个参数是要操作的样式表，第二个参数是要删除的规则的索引。

function deleteRule(sheet, index){ if (sheet.deleteRule){ sheet.deleteRule(index); } else if (sheet.removeRule){ sheet.removeRule(index); } }

CSSRulesExample2.htm/I>

调用这个函数的方式如下。

deleteRule(document.styleSheets[0], 0);

与添加规则相似，删除规则也不是实际 Web 开发中常见的做法。考虑到删除规则可能会影响 CSS 层叠的效果，因此请大家慎重使用。

12.2.3　元素大小

本节介绍的属性和方法并不属于「DOM2 级样式」规范，但却与 HTML 元素的样式息息相关。DOM 中没有规定如何确定页面中元素的大小。IE 为此率先引入了一些属性，以便开发人员使用。目前，所有主要的浏览器都已经支持这些属性。

1. 偏移量

首先要介绍的属性涉及偏移量（offset dimension），包括元素在屏幕上占用的所有可见的空间。元素的可见大小由其高度、宽度决定，包括所有内边距、滚动条和边框大小（注意，不包括外边距）。通过下列 4 个属性可以取得元素的偏移量。

offsetHeight：元素在垂直方向上占用的空间大小，以像素计。包括元素的高度、（可见的）水平滚动条的高度、上边框高度和下边框高度。

offsetWidth：元素在水平方向上占用的空间大小，以像素计。包括元素的宽度、（可见的）垂直滚动条的宽度、左边框宽度和右边框宽度。

offsetLeft：元素的左外边框至包含元素的左内边框之间的像素距离。

offsetTop：元素的上外边框至包含元素的上内边框之间的像素距离。

其中，offsetLeft 和 offsetTop 属性与包含元素有关，包含元素的引用保存在 offsetParent 属性中。offsetParent 属性不一定与 parentNode 的值相等。例如，<td> 元素的 offsetParent 是作为其祖先元素的 <table> 元素，因为 <table> 是在 DOM 层次中距 <td> 最近的一个具有大小的元素。图 12-1 形象地展示了上面几个属性表示的不同大小。

图　12-1

要想知道某个元素在页面上的偏移量，将这个元素的 offsetLeft 和 offsetTop 与其 offsetParent 的相同属性相加，如此循环直至根元素，就可以得到一个基本准确的值。以下两个函数就可以用于分别取得元素的左和上偏移量。

function getElementLeft(element){ var actualLeft = element.offsetLeft; var current = element.offsetParent; while (current !== null){ actualLeft += current.offsetLeft; current = current.offsetParent; } return actualLeft; } function getElementTop(element){ var actualTop = element.offsetTop; var current = element.offsetParent; while (current !== null){ actualTop += current. offsetTop; current = current.offsetParent; } return actualTop; }

OffsetDimensionsExample.htm

这两个函数利用 offsetParent 属性在 DOM 层次中逐级向上回溯，将每个层次中的偏移量属性合计到一块。对于简单的 CSS 布局的页面，这两函数可以得到非常精确的结果。对于使用表格和内嵌框架布局的页面，由于不同浏览器实现这些元素的方式不同，因此得到的值就不太精确了。一般来说，页面中的所有元素都会被包含在几个 <div> 元素中，而这些 <div> 元素的 offsetParent 又是 <body> 元素，所以 getElementLeft () 与 getElementTop () 会返回与 offsetLeft 和 offsetTop 相同的值。

所有这些偏移量属性都是只读的，而且每次访问它们都需要重新计算。因此，应该尽量避免重复访问这些属性；如果需要重复使用其中某些属性的值，可以将它们保存在局部变量中，以提高性能。

2. 客户区大小

元素的客户区大小（client dimension），指的是元素内容及其内边距所占据的空间大小。有关客户区大小的属性有两个：clientWidth 和 clientHeight。其中，clientWidth 属性是元素内容区宽度加上左右内边距宽度；clientHeight 属性是元素内容区高度加上上下内边距高度。图 12-2 形象地说明了这些属性表示的大小。

图　12-2

从字面上看，客户区大小就是元素内部的空间大小，因此滚动条占用的空间不计算在内。最常用到这些属性的情况，就是像第 8 章讨论的确定浏览器视口大小的时候。如下面的例子所示，要确定浏览器视口大小，可以使用 document.documentElement 或 document.body（在 IE7 之前的版本中）的 clientWidth 和 clientHeight。

function getViewport(){ if (document.compatMode == "BackCompat"){ return { width: document.body.clientWidth, height: document.body.clientHeight }; } else { return { width: document.documentElement.clientWidth, height: document.documentElement.clientHeight }; } }

这个函数首先检查 document.compatMode 属性，以确定浏览器是否运行在混杂模式。Safari 3.1 之前的版本不支持这个属性，因此就会自动执行 else 语句。Chrome、Opera 和 Firefox 大多数情况下都运行在标准模式下，因此它们也会前进到 else 语句。这个函数会返回一个对象，包含两个属性：width 和 height；表示浏览器视口（<html> 或 <body> 元素）的大小。

与偏移量相似，客户区大小也是只读的，也是每次访问都要重新计算的。

3. 滚动大小

最后要介绍的是滚动大小（scroll dimension），指的是包含滚动内容的元素的大小。有些元素（例如 <html> 元素），即使没有执行任何代码也能自动地添加滚动条；但另外一些元素，则需要通过 CSS 的 overflow 属性进行设置才能滚动。以下是 4 个与滚动大小相关的属性。

scrollHeight：在没有滚动条的情况下，元素内容的总高度。

scrollWidth：在没有滚动条的情况下，元素内容的总宽度。

scrollLeft：被隐藏在内容区域左侧的像素数。通过设置这个属性可以改变元素的滚动位置。

scrollTop：被隐藏在内容区域上方的像素数。通过设置这个属性可以改变元素的滚动位置。

图 12-3 展示了这些属性代表的大小。

scrollWidth 和 scrollHeight 主要用于确定元素内容的实际大小。例如，通常认为 <html> 元素是在 Web 浏览器的视口中滚动的元素（IE6 之前版本运行在混杂模式下时是 <body> 元素）。因此，带有垂直滚动条的页面总高度就是 document.documentElement.scrollHeight。

对于不包含滚动条的页面而言，scrollWidth 和 scrollHeight 与 clientWidth 和 clientHeight 之间的关系并不十分清晰。在这种情况下，基于 document.documentElement 查看这些属性会在不同浏览器间发现一些不一致性问题，如下所述。

Firefox 中这两组属性始终都是相等的，但大小代表的是文档内容区域的实际尺寸，而非视口的尺寸。

Opera、Safari 3.1 及更高版本、Chrome 中的这两组属性是有差别的，其中 scrollWidth 和 scrollHeight 等于视口大小，而 clientWidth 和 clientHeight 等于文档内容区域的大小。

IE（在标准模式）中的这两组属性不相等，其中 scrollWidth 和 scrollHeight 等于文档内容区域的大小，而 clientWidth 和 clientHeight 等于视口大小。

图　12-3

在确定文档的总高度时（包括基于视口的最小高度时），必须取得 scrollWidth/clientWidth 和 scrollHeight/clientHeight 中的最大值，才能保证在跨浏览器的环境下得到精确的结果。下面就是这样一个例子。

var docHeight = Math.max(document.documentElement.scrollHeight, document.documentElement.clientHeight); var docWidth = Math.max(document.documentElement.scrollWidth, document.documentElement.clientWidth);

注意，对于运行在混杂模式下的 IE，则需要用 document.body 代替 document.documentElement。

通过 scrollLeft 和 scrollTop 属性既可以确定元素当前滚动的状态，也可以设置元素的滚动位置。在元素尚未被滚动时，这两个属性的值都等于 0。如果元素被垂直滚动了，那么 scrollTop 的值会大于 0，且表示元素上方不可见内容的像素高度。如果元素被水平滚动了，那么 scrollLeft 的值会大于 0，且表示元素左侧不可见内容的像素宽度。这两个属性都是可以设置的，因此将元素的 scrollLeft 和 scrollTop 设置为 0，就可以重置元素的滚动位置。下面这个函数会检测元素是否位于顶部，如果不是就将其回滚到顶部。

function scrollToTop(element){ if (element.scrollTop != 0){ element.scrollTop = 0; } }

这个函数既取得了 scrollTop 的值，也设置了它的值。

4. 确定元素大小

IE、Firefox 3+、Safari 4+、Opera 9.5 及 Chrome 为每个元素都提供了一个 getBoundingClientRect () 方法。这个方法返回会一个矩形对象，包含 4 个属性：left、top、right 和 bottom。这些属性给出了元素在页面中相对于视口的位置。但是，浏览器的实现稍有不同。IE8 及更早版本认为文档的左上角坐标是 (2, 2)，而其他浏览器包括 IE9 则将传统的 (0,0) 作为起点坐标。因此，就需要在一开始检查一下位于 (0,0) 处的元素的位置，在 IE8 及更早版本中，会返回 (2,2)，而在其他浏览器中会返回 (0,0)。来看下面的函数：

function getBoundingClientRect(element){ if (typeof arguments.callee.offset != "number"){ var scrollTop = document.documentElement.scrollTop; var temp = document.createElement("div"); temp.style.cssText = "position:absolute;left:0;top:0;"; document.body.appendChild(temp); arguments.callee.offset = -temp.getBoundingClientRect().top - scrollTop; document.body.removeChild(temp); temp = null; } var rect = element.getBoundingClientRect(); var offset = arguments.callee.offset; return { left: rect.left + offset, right: rect.right + offset, top: rect.top + offset, bottom: rect.bottom + offset }; }

GetBoundingClientRectExample.htm

这个函数使用了它自身的属性来确定是否要对坐标进行调整。第一步是检测属性是否有定义，如果没有就定义一个。最终的 offset 会被设置为新元素上坐标的负值，实际上就是在 IE 中设置为？2，在 Firefox 和 Opera 中设置为 - 0。为此，需要创建一个临时的元素，将其位置设置在 (0,0)，然后再调用其 getBoundingClientRect ()。而之所以要减去视口的 scrollTop，是为了防止调用这个函数时窗口被滚动了。这样编写代码，就无需每次调用这个函数都执行两次 getBoundingClientRect () 了。接下来，再在传入的元素上调用这个方法并基于新的计算公式创建一个对象。

对于不支持 getBoundingClientRect () 的浏览器，可以通过其他手段取得相同的信息。一般来说，right 和 left 的差值与 offsetWidth 的值相等，而 bottom 和 top 的差值与 offsetHeight 相等。而且，left 和 top 属性大致等于使用本章前面定义的 getElementLeft () 和 getElementTop () 函数取得的值。综合上述，就可以创建出下面这个跨浏览器的函数：

function getBoundingClientRect(element){ var scrollTop = document.documentElement.scrollTop; var scrollLeft = document.documentElement.scrollLeft; if (element.getBoundingClientRect){ if (typeof arguments.callee.offset != "number"){ var temp = document.createElement("div"); temp.style.cssText = "position:absolute;left:0;top:0;"; document.body.appendChild(temp); arguments.callee.offset = -temp.getBoundingClientRect().top - scrollTop; document.body.removeChild(temp); temp = null; } var rect = element.getBoundingClientRect(); var offset = arguments.callee.offset; return { left: rect.left + offset, right: rect.right + offset, top: rect.top + offset, bottom: rect.bottom + offset }; } else { var actualLeft = getElementLeft(element); var actualTop = getElementTop(element); return { left: actualLeft - scrollLeft, right: actualLeft + element.offsetWidth - scrollLeft, top: actualTop - scrollTop, bottom: actualTop + element.offsetHeight - scrollTop } } }

GetBoundingClientRectExample.htm

这个函数在 getBoundingClientRect () 有效时，就使用这个原生方法，而在这个方法无效时则使用默认的计算公式。在某些情况下，这个函数返回的值可能会有所不同，例如使用表格布局或使用滚动元素的情况下。

由于这里使用了 arguments.callee，所以这个方法不能在严格模式下使用。

12.3　遍历

「DOM2 级遍历和范围」模块定义了两个用于辅助完成顺序遍历 DOM 结构的类型：NodeIterator 和 TreeWalker。这两个类型能够基于给定的起点对 DOM 结构执行深度优先（depth-first）的遍历操作。在与 DOM 兼容的浏览器中（Firefox 1 及更高版本、Safari 1.3 及更高版本、Opera 7.6 及更高版本、Chrome 0.2 及更高版本），都可以访问到这些类型的对象。IE 不支持 DOM 遍历。使用下列代码可以检测浏览器对 DOM2 级遍历能力的支持情况。

var supportsTraversals = document.implementation.hasFeature("Traversal", "2.0"); var supportsNodeIterator = (typeof document.createNodeIterator == "function"); var supportsTreeWalker = (typeof document.createTreeWalker == "function");

如前所述，DOM 遍历是深度优先的 DOM 结构遍历，也就是说，移动的方向至少有两个（取决于使用的遍历类型）。遍历以给定节点为根，不可能向上超出 DOM 树的根节点。以下面的 HTML 页面为例。

<!DOCTYPE html> <html> <head> <title>Example</title> </head> <body> <p><b>Hello</b> world!</p> </body> </html>

图 12-4 展示了这个页面的 DOM 树。

图　12-4

任何节点都可以作为遍历的根节点。如果假设 <body> 元素为根节点，那么遍历的第一步就是访问 <p> 元素，然后再访问同为 <body> 元素后代的两个文本节点。不过，这次遍历永远不会到达 <html>、<head> 元素，也不会到达不属于 <body> 元素子树的任何节点。而以 document 为根节点的遍历则可以访问到文档中的全部节点。图 12-5 展示了对以 document 为根节点的 DOM 树进行深度优先遍历的先后顺序。

图　12-5

从 document 开始依序向前，访问的第一个节点是 document，访问的最后一个节点是包含 "world!" 的文本节点。从文档最后的文本节点开始，遍历可以反向移动到 DOM 树的顶端。此时，访问的第一个节点是包含 "Hello" 的文本节点，访问的最后一个节点是 document 节点。NodeIterator 和 TreeWalker 都以这种方式执行遍历。

12.3.1　NodeIterator

NodeIterator 类型是两者中比较简单的一个，可以使用 document.createNodeIterator () 方法创建它的新实例。这个方法接受下列 4 个参数。

root：想要作为搜索起点的树中的节点。

whatToShow：表示要访问哪些节点的数字代码。

filter：是一个 NodeFilter 对象，或者一个表示应该接受还是拒绝某种特定节点的函数。

entityReferenceExpansion：布尔值，表示是否要扩展实体引用。这个参数在 HTML 页面中没有用，因为其中的实体引用不能扩展。

whatToShow 参数是一个位掩码，通过应用一或多个过滤器（filter）来确定要访问哪些节点。这个参数的值以常量形式在 NodeFilter 类型中定义，如下所示。

NodeFilter.SHOW_ALL：显示所有类型的节点。

NodeFilter.SHOW_ELEMENT：显示元素节点。

NodeFilter.SHOW_ATTRIBUTE：显示特性节点。由于 DOM 结构原因，实际上不能使用这个值。

NodeFilter.SHOW_TEXT：显示文本节点。

NodeFilter.SHOW_CDATA_SECTION：显示 CDATA 节点。对 HTML 页面没有用。

NodeFilter.SHOW_ENTITY_REFERENCE：显示实体引用节点。对 HTML 页面没有用。

NodeFilter.SHOW_ENTITYE：显示实体节点。对 HTML 页面没有用。

NodeFilter.SHOW_PROCESSING_INSTRUCTION：显示处理指令节点。对 HTML 页面没有用。

NodeFilter.SHOW_COMMENT：显示注释节点。

NodeFilter.SHOW_DOCUMENT：显示文档节点。

NodeFilter.SHOW_DOCUMENT_TYPE：显示文档类型节点。

NodeFilter.SHOW_DOCUMENT_FRAGMENT：显示文档片段节点。对 HTML 页面没有用。

NodeFilter.SHOW_NOTATION：显示符号节点。对 HTML 页面没有用。

除了 NodeFilter.SHOW_ALL 之外，可以使用按位或操作符来组合多个选项，如下面的例子所示：

var whatToShow = NodeFilter.SHOW_ELEMENT | NodeFilter.SHOW_TEXT;

可以通过 createNodeIterator () 方法的 filter 参数来指定自定义的 NodeFilter 对象，或者指定一个功能类似节点过滤器（node filter）的函数。每个 NodeFilter 对象只有一个方法，即 acceptNode ()；如果应该访问给定的节点，该方法返回 NodeFilter.FILTER_ACCEPT，如果不应该访问给定的节点，该方法返回 NodeFilter.FILTER_SKIP。由于 NodeFilter 是一个抽象的类型，因此不能直接创建它的实例。在必要时，只要创建一个包含 acceptNode () 方法的对象，然后将这个对象传入 createNodeIterator () 中即可。例如，下列代码展示了如何创建一个只显示 <p> 元素的节点迭代器。

var filter = { acceptNode: function(node){ return node.tagName.toLowerCase() == "p" ? NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_SKIP; } }; var iterator = document.createNodeIterator(root, NodeFilter.SHOW_ELEMENT, filter, false);

第三个参数也可以是一个与 acceptNode () 方法类似的函数，如下所示。

var filter = function(node){ return node.tagName.toLowerCase() == "p" ? NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_SKIP; }; var iterator = document.createNodeIterator(root, NodeFilter.SHOW_ELEMENT, filter, false);

一般来说，这就是在 JavaScript 中使用这个方法的形式，这种形式比较简单，而且也跟其他的 JavaScript 代码很相似。如果不指定过滤器，那么应该在第三个参数的位置上传入 null。

下面的代码创建了一个能够访问所有类型节点的简单的 NodeIterator。

var iterator = document.createNodeIterator(document, NodeFilter.SHOW_ALL, null, false);

NodeIterator 类型的两个主要方法是 nextNode () 和 previousNode ()。顾名思义，在深度优先的 DOM 子树遍历中，nextNode () 方法用于向前前进一步，而 previousNode () 用于向后后退一步。在刚刚创建的 NodeIterator 对象中，有一个内部指针指向根节点，因此第一次调用 nextNode () 会返回根节点。当遍历到 DOM 子树的最后一个节点时，nextNode () 返回 null。previousNode () 方法的工作机制类似。当遍历到 DOM 子树的最后一个节点，且 previousNode () 返回根节点之后，再次调用它就会返回 null。

以下面的 HTML 片段为例。

<div id="div1"> <p><b>Hello</b> world!</p> <ul> <li>List item 1</li> <li>List item 2</li> <li>List item 3</li> </ul> </div>

NodeIteratorExample1.htm

假设我们想要遍历 <div> 元素中的所有元素，那么可以使用下列代码。

var div = document.getElementById ("div1"); var iterator = document.createNodeIterator (div, NodeFilter.SHOW_ELEMENT, null, false); var node = iterator.nextNode (); while (node !== null) {alert (node.tagName); // 输出标签名 node = iterator.nextNode ();}

NodeIteratorExample1.htm

在这个例子中，第一次调用 nextNode () 返回 < p> 元素。因为在到达 DOM 子树末端时 nextNode () 返回 null，所以这里使用了 while 语句在每次循环时检查对 nextNode () 的调用是否返回了 null。执行上面的代码会显示如下标签名：

DIV P B UL LI LI LI

也许用不着显示那么多信息，你只想返回遍历中遇到的 <li> 元素。很简单，只要使用一个过滤器即可，如下面的例子所示。

var div = document.getElementById ("div1"); var filter = function (node){return node.tagName.toLowerCase () == "li" ? NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_SKIP; }; var iterator = document.createNodeIterator (div, NodeFilter.SHOW_ELEMENT, filter, false); var node = iterator.nextNode (); while (node !== null) {alert (node.tagName); // 输出标签名 node = iterator.nextNode ();}

NodeIteratorExample2.htm

在这个例子中，迭代器只会返回 <li> 元素。

由于 nextNode () 和 previousNode () 方法都基于 NodeIterator 在 DOM 结构中的内部指针工作，所以 DOM 结构的变化会反映在遍历的结果中。

Firefox 3.5 之前的版本没有实现 createNodeIterator () 方法，但却支持下一节要讨论的 createTreeWalker () 方法。

12.3.2　TreeWalker

TreeWalker 是 NodeIterator 的一个更高级的版本。除了包括 nextNode () 和 previousNode () 在内的相同的功能之外，这个类型还提供了下列用于在不同方向上遍历 DOM 结构的方法。

parentNode ()：遍历到当前节点的父节点；

firstChild ()：遍历到当前节点的第一个子节点；

lastChild ()：遍历到当前节点的最后一个子节点；

nextSibling ()：遍历到当前节点的下一个同辈节点；

previousSibling ()：遍历到当前节点的上一个同辈节点。

创建 TreeWalker 对象要使用 document.createTreeWalker () 方法，这个方法接受的 4 个参数与 document.createNodeIterator () 方法相同：作为遍历起点的根节点、要显示的节点类型、过滤器和一个表示是否扩展实体引用的布尔值。由于这两个创建方法很相似，所以很容易用 TreeWalker 来代替 NodeIterator，如下面的例子所示。

var div = document.getElementById ("div1"); var filter = function (node){return node.tagName.toLowerCase () == "li"? NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_SKIP; }; var walker= document.createTreeWalker (div, NodeFilter.SHOW_ELEMENT, filter, false); var node = walker.nextNode (); while (node !== null) {alert (node.tagName); // 输出标签名 node = walker.nextNode ();}

TreeWalkerExample1.htm

在这里，filter 可以返回的值有所不同。除了 NodeFilter.FILTER_ACCEPT 和 NodeFilter.FILTER_SKIP 之外，还可以使用 NodeFilter.FILTER_REJECT。在使用 NodeIterator 对象时，NodeFilter.FILTER_SKIP 与 NodeFilter.FILTER_REJECT 的作用相同：跳过指定的节点。但在使用 TreeWalker 对象时，NodeFilter.FILTER_SKIP 会跳过相应节点继续前进到子树中的下一个节点，而 NodeFilter.FILTER_REJECT 则会跳过相应节点及该节点的整个子树。例如，将前面例子中的 NodeFilter.FILTER_SKIP 修改成 NodeFilter.FILTER_REJECT，结果就是不会访问任何节点。这是因为第一个返回的节点是 <div>，它的标签名不是 "li"，于是就会返回 NodeFilter.FILTER_REJECT，这意味着遍历会跳过整个子树。在这个例子中，<div> 元素是遍历的根节点，于是结果就会停止遍历。

当然，TreeWalker 真正强大的地方在于能够在 DOM 结构中沿任何方向移动。使用 TreeWalker 遍历 DOM 树，即使不定义过滤器，也可以取得所有 <li> 元素，如下面的代码所示。

var div = document.getElementById ("div1"); var walker = document.createTreeWalker (div, NodeFilter.SHOW_ELEMENT, null, false); walker.firstChild (); // 转到 < p> walker.nextSibling (); // 转到 < ul> var node = walker.firstChild (); // 转到第一个 < li> while (node !== null) {alert (node.tagName); node = walker.nextSibling ();}

TreeWalkerExample2.htm

因为我们知道 <li> 元素在文档结构中的位置，所以可以直接定位到那里，即使用 firstChild () 转到 < p> 元素，使用 nextSibling () 转到 < ul> 元素，然后再使用 firstChild () 转到第一个 < li> 元素。注意，此处 TreeWalker 只返回元素（由传入到 createTreeWalker () 的第二个参数决定）。因此，可以放心地使用 nextSibling () 访问每一个 <li> 元素，直至这个方法最后返回 null。

TreeWalker 类型还有一个属性，名叫 currentNode，表示任何遍历方法在上一次遍历中返回的节点。通过设置这个属性也可以修改遍历继续进行的起点，如下面的例子所示。

var node = walker.nextNode (); alert (node === walker.currentNode); //true walker.currentNode = document.body; // 修改起点

与 NodeIterator 相比，TreeWalker 类型在遍历 DOM 时拥有更大的灵活性。由于 IE 中没有对应的类型和方法，所以使用遍历的跨浏览器解决方案非常少见。

12.4　范围

为了让开发人员更方便地控制页面，「DOM2 级遍历和范围」模块定义了「范围」（range）接口。通过范围可以选择文档中的一个区域，而不必考虑节点的界限（选择在后台完成，对用户是不可见的）。在常规的 DOM 操作不能更有效地修改文档时，使用范围往往可以达到目的。Firefox、Opera、Safari 和 Chrome 都支持 DOM 范围。IE 以专有方式实现了自己的范围特性。

12.4.1　DOM 中的范围

DOM2 级在 Document 类型中定义了 createRange () 方法。在兼容 DOM 的浏览器中，这个方法属于 document 对象。使用 hasFeature () 或者直接检测该方法，都可以确定浏览器是否支持范围。

var supportsRange = document.implementation.hasFeature("Range", "2.0"); var alsoSupportsRange = (typeof document.createRange == "function");

如果浏览器支持范围，那么就可以使用 createRange () 来创建 DOM 范围，如下所示：

var range = document.createRange();

与节点类似，新创建的范围也直接与创建它的文档关联在一起，不能用于其他文档。创建了范围之后，接下来就可以使用它在后台选择文档中的特定部分。而创建范围并设置了其位置之后，还可以针对范围的内容执行很多种操作，从而实现对底层 DOM 树的更精细的控制。

每个范围由一个 Range 类型的实例表示，这个实例拥有很多属性和方法。下列属性提供了当前范围在文档中的位置信息。

startContainer：包含范围起点的节点（即选区中第一个节点的父节点）。

startOffset：范围在 startContainer 中起点的偏移量。如果 startContainer 是文本节点、注释节点或 CDATA 节点，那么 startOffset 就是范围起点之前跳过的字符数量。否则，startOffset 就是范围中第一个子节点的索引。

endContainer：包含范围终点的节点（即选区中最后一个节点的父节点）。

endOffset：范围在 endContainer 中终点的偏移量（与 startOffset 遵循相同的取值规则）。

commonAncestorContainer：startContainer 和 endContainer 共同的祖先节点在文档树中位置最深的那个。

在把范围放到文档中特定的位置时，这些属性都会被赋值。

1. 用 DOM 范围实现简单选择

要使用范围来选择文档中的一部分，最简的方式就是使用 selectNode () 或 selectNodeContents ()。这两个方法都接受一个参数，即一个 DOM 节点，然后使用该节点中的信息来填充范围。其中，selectNode () 方法选择整个节点，包括其子节点；而 selectNodeContents () 方法则只选择节点的子节点。以下面的 HTML 代码为例。

<!DOCTYPE html> <html> <body> <p id="p1"><b>Hello</b> world!</p> </body> </html>

我们可以使用下列代码来创建范围：

var range1 = document.createRange(); range2 = document.createRange(); p1 = document.getElementById("p1"); range1.selectNode(p1); range2.selectNodeContents(p1);

DOMRangeExample.htm

这里创建的两个范围包含文档中不同的部分：rang1 包含 <p/> 元素及其所有子元素，而 rang2 包含 <b/> 元素、文本节点 "Hello" 和文本节点 "world!"（如图 12-6 所示）。

图　12-6

在调用 selectNode () 时，startContainer、endContainer 和 commonAncestorContainer 都等于传入节点的父节点，也就是这个例子中的 document.body。而 startOffset 属性等于给定节点在其父节点的 childNodes 集合中的索引（在这个例子中是 1—— 因为兼容 DOM 的浏览器将空格算作一个文本节点），endOffset 等于 startOffset 加 1（因为只选择了一个节点）。

在调用 selectNodeContents () 时，startContainer、endContainer 和 commonAncestorContainer 等于传入的节点，即这个例子中的 < p> 元素。而 startOffset 属性始终等于 0，因为范围从给定节点的第一个子节点开始。最后，endOffset 等于子节点的数量（node.childNodes.length），在这个例子中是 2。

此外，为了更精细地控制将哪些节点包含在范围中，还可以使用下列方法。

setStartBefore (refNode)：将范围的起点设置在 refNode 之前，因此 refNode 也就是范围选区中的第一个子节点。同时会将 startContainer 属性设置为 refNode.parentNode，将 startOffset 属性设置为 refNode 在其父节点的 childNodes 集合中的索引。

setStartAfter (refNode)：将范围的起点设置在 refNode 之后，因此 refNode 也就不在范围之内了，其下一个同辈节点才是范围选区中的第一个子节点。同时会将 startContainer 属性设置为 refNode.parentNode，将 startOffset 属性设置为 refNode 在其父节点的 childNodes 集合中的索引加 1。

setEndBefore (refNode)：将范围的终点设置在 refNode 之前，因此 refNode 也就不在范围之内了，其上一个同辈节点才是范围选区中的最后一个子节点。同时会将 endContainer 属性设置为 refNode.parentNode，将 endOffset 属性设置为 refNode 在其父节点的 childNodes 集合中的索引。

setEndAfter (refNode)：将范围的终点设置在 refNode 之后，因此 refNode 也就是范围选区中的最后一个子节点。同时会将 endContainer 属性设置为 refNode.parentNode，将 endOffset 属性设置为 refNode 在其父节点的 childNodes 集合中的索引加 1。

在调用这些方法时，所有属性都会自动为你设置好。不过，要想创建复杂的范围选区，也可以直接指定这些属性的值。

2. 用 DOM 范围实现复杂选择

要创建复杂的范围就得使用 setStart () 和 setEnd () 方法。这两个方法都接受两个参数：一个参照节点和一个偏移量值。对 setStart () 来说，参照节点会变成 startContainer，而偏移量值会变成 startOffset。对于 setEnd () 来说，参照节点会变成 endContainer，而偏移量值会变成 endOffset。

可以使用这两个方法来模仿 selectNode () 和 selectNodeContents ()。来看下面的例子：

var range1 = document.createRange(); range2 = document.createRange(); p1 = document.getElementById("p1"); p1Index = -1; i, len; for (i=0, len=p1.parentNode.childNodes.length; i < len; i++) { if (p1.parentNode.childNodes[i] == p1) { p1Index = i; break; } } range1.setStart(p1.parentNode, p1Index); range1.setEnd(p1.parentNode, p1Index + 1); range2.setStart(p1, 0); range2.setEnd(p1, p1.childNodes.length);

DOMRangeExample2.htm

显然，要选择这个节点（使用 range1），就必须确定当前节点（p1）在其父节点的 childNodes 集合中的索引。而要选择这个节点的内容（使用 range2），也不必计算什么；只要通过 setStart () 和 setEnd () 设置默认值即可。模仿 selectNode () 和 selectNodeContents () 并不是 setStart () 和 setEnd () 的主要用途，它们更胜一筹的地方在于能够选择节点的一部分。

假设你只想选择前面 HTML 示例代码中从 "Hello" 的 "llo" 到 "world!" 的 "o"—— 很容易做到。第一步是取得所有节点的引用，如下面的例子所示：

var p1 = document.getElementById("p1"); helloNode = p1.firstChild.firstChild; worldNode = p1.lastChild;

DOMRangeExample3.htm

实际上，"Hello" 文本节点是 <p> 元素的孙子节点，因为它本身是 <b> 元素的一个子节点。因此，p1.firstChild 取得的是 <b>，而 p1.firstChild.firstChild 取得的才是这个文本节点。"world!" 文本节点是 <p> 元素的第二个子节点（也是最后一个子节点），因此可以使用 p1.lastChild 取得该节点。然后，必须在创建范围时指定相应的起点和终点，如下面的例子所示。

var range = document.createRange(); range.setStart(helloNode, 2); range.setEnd(worldNode, 3);

DOMRangeExample3.htm

因为这个范围的选区应该从 "Hello" 中 "e" 的后面开始，所以在 setStart () 中传入 helloNode 的同时，传入了偏移量 2（即 "e" 的下一个位置；"H" 的位置是 0）。设置选区的终点时，在 setEnd () 中传入 worldNode 的同时传入了偏移量 3，表示选区之外的第一个字符的位置，这个字符是 "r"，它的位置是 3（位置 0 上还有一个空格）。如图 12-7 所示。

图　12-7

由于 helloNode 和 worldNode 都是文本节点，因此它们分别变成了新建范围的 startContainer 和 endContainer。此时 startOffset 和 endOffset 分别用以确定两个节点所包含的文本中的位置，而不是用以确定子节点的位置（就像传入的参数为元素节点时那样）。此时的 commonAncestorContainer 是 <p> 元素，也就是同时包含这两个节点的第一个祖先元素。

当然，仅仅是选择了文档中的某一部分用处并不大。但重要的是，选择之后才可以对选区进行操作。

3. 操作 DOM 范围中的内容

在创建范围时 ，内部会为这个范围创建一个文档片段，范围所属的全部节点都被添加到了这个文档片段中。为了创建这个文档片段，范围内容的格式必须正确有效。在前面的例子中，我们创建的选区分别开始和结束于两个文本节点的内部，因此不能算是格式良好的 DOM 结构，也就无法通过 DOM 来表示。但是，范围知道自身缺少哪些开标签和闭标签，它能够重新构建有效的 DOM 结构以便我们对其进行操作。

对于前面的例子而言，范围经过计算知道选区中缺少一个开始的 <b> 标签，因此就会在后台动态加入一个该标签，同时还会在前面加入一个表示结束的 </b> 标签以结束 "He"。于是，修改后的 DOM 就变成了如下所示。

<p><b>He</b><b>llo</b> world!</p>

另外，文本节点 "world!" 也被拆分为两个文本节点，一个包含 "wo"，另一个包含 "rld!"。最终的 DOM 树如图 12-8 所示，右侧是表示范围的文档片段的内容。

像这样创建了范围之后，就可以使用各种方法对范围的内容进行操作了（注意，表示范围的内部文档片段中的所有节点，都只是指向文档中相应节点的指针）。

第一个方法，也是最容易理解的方法，就是 deleteContents ()。这个方法能够从文档中删除范围所包含的内容。例如：

var p1 = document.getElementById("p1"); helloNode = p1.firstChild.firstChild; worldNode = p1.lastChild; range = document.createRange(); range.setStart(helloNode, 2); range.setEnd(worldNode, 3); range.deleteContents();

DOMRangeExample4.htm

图　12-8

执行以上代码后，页面中会显示如下 HTML 代码：

<p><b>He</b>rld!</p>

由于范围选区在修改底层 DOM 结构时能够保证格式良好，因此即使内容被删除了，最终的 DOM 结构依旧是格式良好的。

与 deleteContents () 方法相似，extractContents () 也会从文档中移除范围选区。但这两个方法的区别在于，extractContents () 会返回范围的文档片段。利用这个返回的值，可以将范围的内容插入到文档中的其他地方。如下面的例子所示：

var p1 = document.getElementById("p1"); helloNode = p1.firstChild.firstChild; worldNode = p1.lastChild; range = document.createRange(); range.setStart(helloNode, 2); range.setEnd(worldNode, 3); var fragment = range.extractContents(); p1.parentNode.appendChild(fragment);

DOMRangeExample5.htm

在这个例子中，我们将提取出来的文档片段添加到了文档 <body> 元素的末尾。（记住，在将文档片段传入 appendChild () 方法中时，添加到文档中的只是片段的子节点，而非片段本身。）结果得到如下 HTML 代码：

<p><b>He</b>rld!</p> <b>llo</b> wo

还一种做法，即使用 cloneContents () 创建范围对象的一个副本，然后在文档的其他地方插入该副本。如下面的例子所示：

var p1 = document.getElementById("p1"), helloNode = p1.firstChild.firstChild, worldNode = p1.lastChild, range = document.createRange(); range.setStart(helloNode, 2); range.setEnd(worldNode, 3); var fragment = range.cloneContents(); p1.parentNode.appendChild(fragment);

DOMRangeExample6.htm

这个方法与 extractContents () 非常类似，因为它们都返回文档片段。它们的主要区别在于，cloneContents () 返回的文档片段包含的是范围中节点的副本，而不是实际的节点。执行上面的操作后，页面中的 HTML 代码应该如下所示：

<p><b>Hello</b> world!</p> <b>llo</b> wo

有一点请读者注意，那就是在调用上面介绍的方法之前，拆分的节点并不会产生格式良好的文档片段。换句话说，原始的 HTML 在 DOM 被修改之前会始终保持不变。

4. 插入 DOM 范围中的内容

利用范围，可以删除或复制内容，还可以像前面介绍的那样操作范围中的内容。使用 insertNode () 方法可以向范围选区的开始处插入一个节点。假设我们想在前面例子中的 HTML 前面插入以下 HTML 代码：

<span style="color: red">Inserted text</span>

那么，就可以使用下列代码：

var p1 = document.getElementById("p1"); helloNode = p1.firstChild.firstChild; worldNode = p1.lastChild; range = document.createRange(); range.setStart(helloNode, 2); range.setEnd(worldNode, 3); var span = document.createElement("span"); span.style.color = "red"; span.appendChild(document.createTextNode("Inserted text")); range.insertNode(span);

DOMRangeExample7.htm

运行以上 JavaScript 代码，就会得到如下 HTML 代码：

<p id="p1"><b>He<span style="color: red">Inserted text</span>llo</b> world</p>

注意，<span> 正好被插入到了 "Hello" 中的 "llo" 前面，而该位置就是范围选区的开始位置。还要注意的是，由于这里没有使用上一节介绍的方法，结果原始的 HTML 并没有添加或删除 <b> 元素。使用这种技术可以插入一些帮助提示信息，例如在打开新窗口的链接旁边插入一幅图像。

除了向范围内部插入内容之外，还可以环绕范围插入内容，此时就要使用 surroundContents () 方法。这个方法接受一个参数，即环绕范围内容的节点。在环绕范围插入内容时，后台会执行下列步骤。

提取出范围中的内容（类似执行 extractContent ()）；

将给定节点插入到文档中原来范围所在的位置上；

将文档片段的内容添加到给定节点中。

可以使用这种技术来突出显示网页中的某些词句，例如下列代码：

var p1 = document.getElementById("p1"); helloNode = p1.firstChild.firstChild; worldNode = p1.lastChild; range = document.createRange(); range.selectNode(helloNode); var span = document.createElement("span"); span.style.backgroundColor = "yellow"; range.surroundContents(span);

DOMRangeExample8.htm

会给范围选区加上一个黄色的背景。得到的 HTML 代码如下所示：

<p><b>He</b><span style="background-color:yellow"><b>llo</b> wo</span>rld!</p>

为了插入 <span>，必须将 <b> 元素拆分成两个 <b> 元素，一个包含 "He"，另一个包含 "llo"。拆分之后，就可以稳妥地插入 <span> 了。

5. 折叠 DOM 范围

所谓折叠范围，就是指范围中未选择文档的任何部分。可以用文本框来描述折叠范围的过程。假设文本框中有一行文本，你用鼠标选择了其中一个完整的单词。然后，你单击鼠标左键，选区消失，而光标则落在了其中两个字母之间。同样，在折叠范围时，其位置会落在文档中的两个部分之间，可能是范围选区的开始位置，也可能是结束位置。图 12-9 展示了折叠范围时发生的情形。

使用 collapse () 方法来折叠范围，这个方法接受一个参数，一个布尔值，表示要折叠到范围的哪一端。参数 true 表示折叠到范围的起点，参数 false 表示折叠到范围的终点。要确定范围已经折叠完毕，可以检查 collapsed 属性，如下所示：

range.collapse (true); // 折叠到起点 alert (range.collapsed); // 输出 true

图　12-9

检测某个范围是否处于折叠状态，可以帮我们确定范围中的两个节点是否紧密相邻。例如，对于下面的 HTML 代码：

<p id="p1">Paragraph 1</p><p id="p2">Paragraph 2</p>

如果我们不知道其实际构成（比如说，这行代码是动态生成的），那么可以像下面这样创建一个范围。

var p1 = document.getElementById ("p1"), p2 = document.getElementById ("p2"), range = document.createRange (); range.setStartAfter (p1); range.setStartBefore (p2); alert (range.collapsed); // 输出 true

在这个例子中，新创建的范围是折叠的，因为 p1 的后面和 p2 的前面什么也没有。

6. 比较 DOM 范围

在有多个范围的情况下，可以使用 compareBoundaryPoints () 方法来确定这些范围是否有公共的边界（起点或终点）。这个方法接受两个参数：表示比较方式的常量值和要比较的范围。表示比较方式的常量值如下所示。

Range.START_TO_START (0)：比较第一个范围和第二个范围的起点；

Range.START_TO_END (1)：比较第一个范围的起点和第二个范围的终点；

Range.END_TO_END (2)：比较第一个范围和第二个范围的终点；

Range.END_TO_START (3)：比较第一个范围的终点和第一个范围的起点。

compareBoundaryPoints () 方法可能的返回值如下：如果第一个范围中的点位于第二个范围中的点之前，返回 - 1；如果两个点相等，返回 0；如果第一个范围中的点位于第二个范围中的点之后，返回 1。来看下面的例子。

var range1 = document.createRange(); var range2 = document.createRange(); var p1 = document.getElementById("p1"); range1.selectNodeContents(p1); range2.selectNodeContents(p1); range2.setEndBefore(p1.lastChild); alert(range1.compareBoundaryPoints(Range.START_TO_START, range2)); //0 alert(range1.compareBoundaryPoints(Range.END_TO_END, range2)); //1

DOMRangeExample9.htm

在这个例子中，两个范围的起点实际上是相同的，因为它们的起点都是由 selectNodeContents () 方法设置的默认值来指定的。因此，第一次比较返回 0。但是，range2 的终点由于调用 setEndBefore () 已经改变了，结果是 range1 的终点位于 range2 的终点后面（见图 12-10），因此第二次比较返回 1。

图　12-10

7. 复制 DOM 范围

可以使用 cloneRange () 方法复制范围。这个方法会创建调用它的范围的一个副本。

var newRange = range.cloneRange();

新创建的范围与原来的范围包含相同的属性，而修改它的端点不会影响原来的范围。

8. 清理 DOM 范围

在使用完范围之后，最好是调用 detach () 方法，以便从创建范围的文档中分离出该范围。调用 detach () 之后，就可以放心地解除对范围的引用，从而让垃圾回收机制回收其内存了。来看下面的例子。

range.detach (); // 从文档中分离 range = null; // 解除引用

在使用范围的最后再执行这两个步骤是我们推荐的方式。一旦分离范围，就不能再恢复使用了。

12.4.2　IE8 及更早版本中的范围

虽然 IE9 支持 DOM 范围，但 IE8 及之前版本不支持 DOM 范围。不过，IE8 及早期版本支持一种类似的概念，即文本范围（text range）。文本范围是 IE 专有的特性，其他浏览器都不支持。顾名思义，文本范围处理的主要是文本（不一定是 DOM 节点）。通过 <body>、<button>、<input> 和 <textarea> 等这几个元素，可以调用 createTextRange () 方法来创建文本范围。以下是一个例子：

var range = document.body.createTextRange();

像这样通过 document 创建的范围可以在页面中的任何地方使用（通过其他元素创建的范围则只能在相应的元素中使用）。与 DOM 范围类似，使用 IE 文本范围的方式也有很多种。

1. 用 IE 范围实现简单的选择

选择页面中某一区域的最简单方式，就是使用范围的 findText () 方法。这个方法会找到第一次出现的给定文本，并将范围移过来以环绕该文本。如果没有找到文本，这个方法返回 false；否则返回 true。同样，仍然以下面的 HTML 代码为例。

<p id="p1"><b>Hello</b> world!</p>

要选择 "Hello"，可以使用下列代码。

var range = document.body.createTextRange(); var found = range.findText("Hello");

IERangeExample1.htm

在执行完第二行代码之后，文本 "Hello" 就被包围在范围之内了。为此，可以检查范围的 text 属性来确认（这个属性返回范围中包含的文本），或者也可以检查 findText () 的返回值 —— 在找到了文本的情况下返回值为 true。例如：

alert(found); //true alert(range.text); //"Hello"

还可以为 findText () 传入另一个参数，即一个表示向哪个方向继续搜索的数值。负值表示应该从当前位置向后搜索，而正值表示应该从当前位置向前搜索。因此，要查找文档中前两个 "Hello" 的实例，应该使用下列代码。

var found = range.findText("Hello"); var foundAgain = range.findText("Hello", 1);

IE 中与 DOM 中的 selectNode () 方法最接近的方法是 moveToElementText ()，这个方法接受一个 DOM 元素，并选择该元素的所有文本，包括 HTML 标签。下面是一个例子。

var range = document.body.createTextRange(); var p1 = document.getElementById("p1"); range.moveToElementText(p1);

IERangeExample2.htm

在文本范围中包含 HTML 的情况下，可以使用 htmlText 属性取得范围的全部内容，包括 HTML 和文本，如下面的例子所示。

alert(range.htmlText);

IE 的范围没有任何属性可以随着范围选区的变化而动态更新。不过，其 parentElement () 方法倒是与 DOM 的 commonAncestorContainer 属性类似。

var ancestor = range.parentElement();

这样得到的父元素始终都可以反映文本选区的父节点。

2. 使用 IE 范围实现复杂的选择

在 IE 中创建复杂范围的方法，就是以特定的增量向四周移动范围。为此，IE 提供了 4 个方法：move ()、moveStart ()、moveEnd () 和 expand ()。这些方法都接受两个参数：移动单位和移动单位的数量。其中，移动单位是下列一种字符串值。

"character"：逐个字符地移动。

"word"：逐个单词（一系列非空格字符）地移动。

"sentence"：逐个句子（一系列以句号、问号或叹号结尾的字符）地移动。

"textedit"：移动到当前范围选区的开始或结束位置。

通过 moveStart () 方法可以移动范围的起点，通过 moveEnd () 方法可以移动范围的终点，移动的幅度由单位数量指定，如下面的例子所示。

range.moveStart ("word", 2); // 起点移动 2 个单词 range.moveEnd ("character", 1); // 终点移动 1 个字符

使用 expand () 方法可以将范围规范化。换句话说，expand () 方法的作用是将任何部分选择的文本全部选中。例如，当前选择的是一个单词中间的两个字符，调用 expand ("word") 可以将整个单词都包含在范围之内。

而 move () 方法则首先会折叠当前范围（让起点和终点相等），然后再将范围移动指定的单位数量，如下面的例子所示。

range.move ("character", 5); // 移动 5 个字符

调用 move () 之后，范围的起点和终点相同，因此必须再使用 moveStart () 或 moveEnd () 创建新的选区。

3. 操作 IE 范围中的内容

在 IE 中操作范围中的内容可以使用 text 属性或 pasteHTML () 方法。如前所述，通过 text 属性可以取得范围中的内容文本；但是，也可以通过这个属性设置范围中的内容文本。来看一个例子。

var range = document.body.createTextRange(); range.findText("Hello"); range.text = "Howdy";

如果仍以前面的 Hello World 代码为例，执行以上代码后的 HTML 代码如下。

<p id="p1"><b>Howdy</b> world!</p>

注意，在设置 text 属性的情况下，HTML 标签保持不变。

要向范围中插入 HTML 代码，就得使用 pasteHTML () 方法，如下面的例子所示。

var range = document.body.createTextRange(); range.findText("Hello"); range.pasteHTML("<em>Howdy</em>");

IERangeExample3.htm

执行这些代码后，会得到如下 HTML。

<p id="p1"><b><em>Howdy</em></b> world!</p>

不过，在范围中包含 HTML 代码时，不应该使用 pasteHTML ()，因为这样很容易导致不可预料的结果 —— 很可能是格式不正确的 HTML。

4. 折叠 IE 范围

IE 为范围提供的 collapse () 方法与相应的 DOM 方法用法一样：传入 true 把范围折叠到起点，传入 false 把范围折叠到终点。例如：

range.collapse (true); // 折叠到起点

可惜的是，没有对应的 collapsed 属性让我们知道范围是否已经折叠完毕。为此，必须使用 boundingWidth 属性，该属性返回范围的宽度（以像素为单位）。如果 boundingWidth 属性等于 0，就说明范围已经折叠了：

var isCollapsed = (range.boundingWidth == 0);

此外，还有 boundingHeight、boundingLeft 和 boundingTop 等属性，虽然它们都不像 boundingWidth 那么有用，但也可以提供一些有关范围位置的信息。

5. 比较 IE 范围

IE 中的 compareEndPoints () 方法与 DOM 范围的 compareBoundaryPoints () 方法类似。这个方法接受两个参数：比较的类型和要比较的范围。比较类型的取值范围是下列几个字符串值："StartToStart"、"StartToEnd"、"EndToEnd" 和 "EndToStart"。这几种比较类型与比较 DOM 范围时使用的几个值是相同的。

同样与 DOM 类似的是，compareEndPoints () 方法也会按照相同的规则返回值，即如果第一个范围的边界位于第二个范围的边界前面，返回 - 1；如果二者边界相同，返回 0；如果第一个范围的边界位于第二个范围的边界后面，返回 1。仍以前面的 Hello World 代码为例，下列代码将创建两个范围，一个选择 "Hello world!"（包括 < b> 标签），另一个选择 "Hello"。

var range1 = document.body.createTextRange(); var range2 = document.body.createTextRange(); range1.findText("Hello world!"); range2.findText("Hello"); alert(range1.compareEndPoints("StartToStart", range2)); //0 alert(range1.compareEndPoints("EndToEnd", range2)); //1

IERangeExample5.htm

由于这两个范围共享同一个起点，所以使用 compareEndPoints () 比较起点返回 0。而 range1 的终点在 range2 的终点后面，所以 compareEndPoints () 返回 1。

IE 中还有两个方法，也是用于比较范围的：isEqual () 用于确定两个范围是否相等，inRange () 用于确定一个范围是否包含另一个范围。下面是相应的示例。

var range1 = document.body.createTextRange(); var range2 = document.body.createTextRange(); range1.findText("Hello World"); range2.findText("Hello"); alert("range1.isEqual(range2): " + range1.isEqual(range2)); //false alert("range1.inRange(range2):" + range1.inRange(range2)); //true

IERangeExample6.htm

这个例子使用了与前面相同的范围来示范这两个方法。由于这两个范围的终点不同，所以它们不相等，调用 isEqual () 返回 false。由于 range2 实际位于 range1 内部，它的终点位于后者的终点之前、起点之后，所以 range2 被包含在 range1 内部，调用 inRange () 返回 true。

6. 复制 IE 范围

在 IE 中使用 duplicate () 方法可以复制文本范围，结果会创建原范围的一个副本，如下面的例子所示。

var newRange = range.duplicate();

新创建的范围会带有与原范围完全相同的属性。

12.5　小结

DOM2 级规范定义了一些模块，用于增强 DOM1 级。「DOM2 级核心」为不同的 DOM 类型引入了一些与 XML 命名空间有关的方法。这些变化只在使用 XML 或 XHTML 文档时才有用；对于 HTML 文档没有实际意义。除了与 XML 命名空间有关的方法外，「DOM2 级核心」还定义了以编程方式创建 Document 实例的方法，也支持了创建 DocumentType 对象。

「DOM2 级样式」模块主要针对操作元素的样式信息而开发，其特性简要总结如下。

每个元素都有一个关联的 style 对象，可以用来确定和修改行内的样式。

要确定某个元素的计算样式（包括应用给它的所有 CSS 规则），可以使用 getComputedStyle () 方法。

IE 不支持 getComputedStyle () 方法，但为所有元素都提供了能够返回相同信息 currentStyle 属性。

可以通过 document.styleSheets 集合访问样式表。

除 IE 之外的所有浏览器都支持针对样式表的这个接口，IE 也为几乎所有相应的 DOM 功能提供了自己的一套属性和方法。

「DOM2 级遍历和范围」模块提供了与 DOM 结构交互的不同方式，简要总结如下。

遍历即使用 NodeIterator 或 TreeWalker 对 DOM 执行深度优先的遍历。

NodeIterator 是一个简单的接口，只允许以一个节点的步幅前后移动。而 TreeWalker 在提供相同功能的同时，还支持在 DOM 结构的各个方向上移动，包括父节点、同辈节点和子节点等方向。

范围是选择 DOM 结构中特定部分，然后再执行相应操作的一种手段。

使用范围选区可以在删除文档中某些部分的同时，保持文档结构的格式良好，或者复制文档中的相应部分。

IE8 及更早版本不支持「DOM2 级遍历和范围」模块，但它提供了一个专有的文本范围对象，可以用来完成简单的基于文本的范围操作。IE9 完全支持 DOM 遍历。

第 13 章　事件

本章内容

理解事件流

使用事件处理程序

不同的事件类型

JavaScript 与 HTML 之间的交互是通过事件实现的。事件，就是文档或浏览器窗口中发生的一些特定的交互瞬间。可以使用侦听器（或处理程序）来预订事件，以便事件发生时执行相应的代码。这种在传统软件工程中被称为观察员模式的模型，支持页面的行为（JavaScript 代码）与页面的外观（HTML 和 CSS 代码）之间的松散耦合。

事件最早是在 IE3 和 Netscape Navigator 2 中出现的，当时是作为分担服务器运算负载的一种手段。在 IE4 和 Navigator 4 发布时，这两种浏览器都提供了相似但不相同的 API，这些 API 并存经过了好几个主要版本。DOM2 级规范开始尝试以一种符合逻辑的方式来标准化 DOM 事件。IE9、Firefox、Opera、Safari 和 Chrome 全都已经实现了「DOM2 级事件」模块的核心部分。IE8 是最后一个仍然使用其专有事件系统的主要浏览器。

浏览器的事件系统相对比较复杂。尽管所有主要浏览器已经实现了「DOM2 级事件」，但这个规范本身并没有涵盖所有事件类型。浏览器对象模型（BOM）也支持一些事件，这些事件与文档对象模型（DOM）事件之间的关系并不十分清晰，因为 BOM 事件长期没有规范可以遵循（HTML5 后来给出了详细的说明）。随着 DOM3 级的出现，增强后的 DOM 事件 API 变得更加繁琐。使用事件有时相对简单，有时则非常复杂，难易程度会因你的需求而不同。不过，有关事件的一些核心概念是一定要理解的。

13.1　事件流

当浏览器发展到第四代时（IE4 及 Netscape Communicator 4），浏览器开发团队遇到了一个很有意思的问题：页面的哪一部分会拥有某个特定的事件？要明白这个问题问的是什么，可以想象画在一张纸上的一组同心圆。如果你把手指放在圆心上，那么你的手指指向的不是一个圆，而是纸上的所有圆。两家公司的浏览器开发团队在看待浏览器事件方面还是一致的。如果你单击了某个按钮，他们都认为单击事件不仅仅发生在按钮上。换句话说，在单击按钮的同时，你也单击了按钮的容器元素，甚至也单击了整个页面。

事件流描述的是从页面中接收事件的顺序。但有意思的是，IE 和 Netscape 开发团队居然提出了差不多是完全相反的事件流的概念。IE 的事件流是事件冒泡流，而 Netscape Communicator 的事件流是事件捕获流。

13.1.1　事件冒泡

IE 的事件流叫做事件冒泡（event bubbling），即事件开始时由最具体的元素（文档中嵌套层次最深的那个节点）接收，然后逐级向上传播到较为不具体的节点（文档）。以下面的 HTML 页面为例：

<!DOCTYPE html> <html> <head> <title>Event Bubbling Example</title> </head> <body> <div id="myDiv">Click Me</div> </body> </html>

如果你单击了页面中的 <div> 元素，那么这个 click 事件会按照如下顺序传播：

div>

<body>

<html>

document

也就是说，click 事件首先在 <div> 元素上发生，而这个元素就是我们单击的元素。然后，click 事件沿 DOM 树向上传播，在每一级节点上都会发生，直至传播到 document 对象。图 13-1 展示了事件冒泡的过程。

图　13-1

所有现代浏览器都支持事件冒泡，但在具体实现上还是有一些差别。IE5.5 及更早版本中的事件冒泡会跳过 <html> 元素（从 <body> 直接跳到 document）。IE9、Firefox、Chrome 和 Safari 则将事件一直冒泡到 window 对象。

13.1.2　事件捕获

Netscape Communicator 团队提出的另一种事件流叫做事件捕获（event capturing）。事件捕获的思想是不太具体的节点应该更早接收到事件，而最具体的节点应该最后接收到事件。事件捕获的用意在于在事件到达预定目标之前捕获它。如果仍以前面的 HTML 页面作为演示事件捕获的例子，那么单击 <div> 元素就会以下列顺序触发 click 事件。

