document

<html>

<body>

<div>

在事件捕获过程中，document 对象首先接收到 click 事件，然后事件沿 DOM 树依次向下，一直传播到事件的实际目标，即 <div> 元素。图 13-2 展示了事件捕获的过程。

图　13-2

虽然事件捕获是 Netscape Communicator 唯一支持的事件流模型，但 IE9、Safari、Chrome、Opera 和 Firefox 目前也都支持这种事件流模型。尽管「DOM2 级事件」规范要求事件应该从 document 对象开始传播，但这些浏览器都是从 window 对象开始捕获事件的。

由于老版本的浏览器不支持，因此很少有人使用事件捕获。我们也建议读者放心地使用事件冒泡，在有特殊需要时再使用事件捕获。

13.1.3　DOM 事件流

「DOM2 级事件」规定的事件流包括三个阶段：事件捕获阶段、处于目标阶段和事件冒泡阶段。首先发生的是事件捕获，为截获事件提供了机会。然后是实际的目标接收到事件。最后一个阶段是冒泡阶段，可以在这个阶段对事件做出响应。以前面简单的 HTML 页面为例，单击 <div> 元素会按照图 13-3 所示顺序触发事件。

图　13-3

在 DOM 事件流中，实际的目标（<div> 元素）在捕获阶段不会接收到事件。这意味着在捕获阶段，事件从 document 到 <html> 再到 <body> 后就停止了。下一个阶段是「处于目标」阶段，于是事件在 <div> 上发生，并在事件处理（后面将会讨论这个概念）中被看成冒泡阶段的一部分。然后，冒泡阶段发生，事件又传播回文档。

多数支持 DOM 事件流的浏览器都实现了一种特定的行为；即使「DOM2 级事件」规范明确要求捕获阶段不会涉及事件目标，但 IE9、Safari、Chrome、Firefox 和 Opera 9.5 及更高版本都会在捕获阶段触发事件对象上的事件。结果，就是有两个机会在目标对象上面操作事件。

IE9、Opera、Firefox、Chrome 和 Safari 都支持 DOM 事件流；IE8 及更早版本不支持 DOM 事件流。

13.2　事件处理程序

事件就是用户或浏览器自身执行的某种动作。诸如 click、load 和 mouseover，都是事件的名字。而响应某个事件的函数就叫做事件处理程序（或事件侦听器）。事件处理程序的名字以 "on" 开头，因此 click 事件的事件处理程序就是 onclick，load 事件的事件处理程序就是 onload。为事件指定处理程序的方式有好几种。

13.2.1　HTML 事件处理程序

某个元素支持的每种事件，都可以使用一个与相应事件处理程序同名的 HTML 特性来指定。这个特性的值应该是能够执行的 JavaScript 代码。例如，要在按钮被单击时执行一些 JavaScript，可以像下面这样编写代码：

<input type="button" value="Click Me" onclick="alert('Clicked')" />

当单击这个按钮时，就会显示一个警告框。这个操作是通过指定 onclick 特性并将一些 JavaScript 代码作为它的值来定义的。由于这个值是 JavaScript，因此不能在其中使用未经转义的 HTML 语法字符，例如和号（&）、双引号（""）、小于号（<）或大于号（>）。为了避免使用 HTML 实体，这里使用了单引号。如果想要使用双引号，那么就要将代码改写成如下所示：

<input type="button" value="Click Me" onclick="alert(&quot;Clicked&quot;)" />

在 HTML 中定义的事件处理程序可以包含要执行的具体动作，也可以调用在页面其他地方定义的脚本，如下面的例子所示：

<script type="text/javascript"> function showMessage(){ alert("Hello world!"); } </script> <input type="button" value="Click Me" onclick="showMessage()" />

HTMLEventHandlerExample01.htm

在这个例子中，单击按钮就会调用 showMessage () 函数。这个函数是在一个独立的 < script> 元素中定义的，当然也可以被包含在一个外部文件中。事件处理程序中的代码在执行时，有权访问全局作用域中的任何代码。

这样指定事件处理程序具有一些独到之处。首先，这样会创建一个封装着元素属性值的函数。这个函数中有一个局部变量 event，也就是事件对象（本章稍后讨论）：

<!-- 输出 "click" --> <input type="button" value="Click Me" onclick="alert (event.type)">

通过 event 变量，可以直接访问事件对象，你不用自己定义它，也不用从函数的参数列表中读取。

在这个函数内部，this 值等于事件的目标元素，例如：

<!-- 输出 "Click Me" --> <input type="button" value="Click Me" onclick="alert (this.value)">

关于这个动态创建的函数，另一个有意思的地方是它扩展作用域的方式。在这个函数内部，可以像访问局部变量一样访问 document 及该元素本身的成员。这个函数使用 with 像下面这样扩展作用域：

function (){ with (document){with (this){// 元素属性值} } }

如此一来，事件处理程序要访问自己的属性就简单多了。下面这行代码与前面的例子效果相同：

<!-- 输出 "Click Me" --> <input type="button" value="Click Me" onclick="alert (value)">

如果当前元素是一个表单输入元素，则作用域中还会包含访问表单元素（父元素）的入口，这个函数就变成了如下所示：

function (){ with (document){with (this.form){with (this){// 元素属性值} } } }

实际上，这样扩展作用域的方式，无非就是想让事件处理程序无需引用表单元素就能访问其他表单字段。例如：

<form method="post"> <input type="text" name="username" value=""> <input type="button" value="Echo Username" onclick="alert(username.value)"> </form>

HTMLEventHandlerExample04.htm

在这个例子中，单击按钮会显示文本框中的文本。值得注意的是，这里直接引用了 username 元素。

不过，在 HTML 中指定事件处理程序有两个缺点。首先，存在一个时差问题。因为用户可能会在 HTML 元素一出现在页面上就触发相应的事件，但当时的事件处理程序有可能尚不具备执行条件。以前面的例子来说明，假设 showMessage () 函数是在按钮下方、页面的最底部定义的。如果用户在页面解析 showMessage () 函数之前就单击了按钮，就会引发错误。为此，很多 HTML 事件处理程序都会被封装在一个 try-catch 块中，以便错误不会浮出水面，如下面的例子所示：

<input type="button" value="Click Me" onclick="try{showMessage();}catch(ex){}">

这样，如果在 showMessage () 函数有定义之前单击了按钮，用户将不会看到 JavaScript 错误，因为在浏览器有机会处理错误之前，错误就被捕获了。

另一个缺点是，这样扩展事件处理程序的作用域链在不同浏览器中会导致不同结果。不同 JavaScript 引擎遵循的标识符解析规则略有差异，很可能会在访问非限定对象成员时出错。

通过 HTML 指定事件处理程序的最后一个缺点是 HTML 与 JavaScript 代码紧密耦合。如果要更换事件处理程序，就要改动两个地方：HTML 代码和 JavaScript 代码。而这正是许多开发人员摒弃 HTML 事件处理程序，转而使用 JavaScript 指定事件处理程序的原因所在。

要了解关于 HTML 事件处理程序缺点的更多信息，请参考 Garrett Smith 的文章「Event Handler Scope」（www.jibbering.com/faq/names/event_handler.html）。

13.2.2　DOM0 级事件处理程序

通过 JavaScript 指定事件处理程序的传统方式，就是将一个函数赋值给一个事件处理程序属性。这种为事件处理程序赋值的方法是在第四代 Web 浏览器中出现的，而且至今仍然为所有现代浏览器所支持。原因一是简单，二是具有跨浏览器的优势。要使用 JavaScript 指定事件处理程序，首先必须取得一个要操作的对象的引用。

每个元素（包括 window 和 document）都有自己的事件处理程序属性，这些属性通常全部小写，例如 onclick。将这种属性的值设置为一个函数，就可以指定事件处理程序，如下所示：

var btn = document.getElementById("myBtn"); btn.onclick = function(){ alert("Clicked"); };

在此，我们通过文档对象取得了一个按钮的引用，然后为它指定了 onclick 事件处理程序。但要注意，在这些代码运行以前不会指定事件处理程序，因此如果这些代码在页面中位于按钮后面，就有可能在一段时间内怎么单击都没有反应。

使用 DOM0 级方法指定的事件处理程序被认为是元素的方法。因此，这时候的事件处理程序是在元素的作用域中运行；换句话说，程序中的 this 引用当前元素。来看一个例子。

var btn = document.getElementById("myBtn"); btn.onclick = function(){ alert(this.id); //"myBtn" };

DOMLevel0EventHandlerExample01.htm

单击按钮显示的是元素的 ID，这个 ID 是通过 this.id 取得的。不仅仅是 ID，实际上可以在事件处理程序中通过 this 访问元素的任何属性和方法。以这种方式添加的事件处理程序会在事件流的冒泡阶段被处理。

也可以删除通过 DOM0 级方法指定的事件处理程序，只要像下面这样将事件处理程序属性的值设置为 null 即可：

btn.onclick = null; // 删除事件处理程序

将事件处理程序设置为 null 之后，再单击按钮将不会有任何动作发生。

如果你使用 HTML 指定事件处理程序，那么 onclick 属性的值就是一个包含着在同名 HTML 特性中指定的代码的函数。而将相应的属性设置为 null，也可以删除以这种方式指定的事件处理程序。

13.2.3　DOM2 级事件处理程序

「DOM2 级事件」定义了两个方法，用于处理指定和删除事件处理程序的操作：addEventListener () 和 removeEventListener ()。所有 DOM 节点中都包含这两个方法，并且它们都接受 3 个参数：要处理的事件名、作为事件处理程序的函数和一个布尔值。最后这个布尔值参数如果是 true，表示在捕获阶段调用事件处理程序；如果是 false，表示在冒泡阶段调用事件处理程序。

要在按钮上为 click 事件添加事件处理程序，可以使用下列代码：

var btn = document.getElementById("myBtn"); btn.addEventListener("click", function(){ alert(this.id); }, false);

上面的代码为一个按钮添加了 onclick 事件处理程序，而且该事件会在冒泡阶段被触发（因为最后一个参数是 false）。与 DOM0 级方法一样，这里添加的事件处理程序也是在其依附的元素的作用域中运行。使用 DOM2 级方法添加事件处理程序的主要好处是可以添加多个事件处理程序。来看下面的例子。

var btn = document.getElementById("myBtn"); btn.addEventListener("click", function(){ alert(this.id); }, false); btn.addEventListener("click", function(){ alert("Hello world!"); }, false);

DOMLevel2EventHandlerExample01.htm

这里为按钮添加了两个事件处理程序。这两个事件处理程序会按照添加它们的顺序触发，因此首先会显示元素的 ID，其次会显示 "Hello world!" 消息。

通过 addEventListener () 添加的事件处理程序只能使用 removeEventListener () 来移除；移除时传入的参数与添加处理程序时使用的参数相同。这也意味着通过 addEventListener () 添加的匿名函数将无法移除，如下面的例子所示。

var btn = document.getElementById ("myBtn"); btn.addEventListener ("click", function (){alert (this.id); }, false); // 这里省略了其他代码 btn.removeEventListener ("click", function (){// 没有用！ alert (this.id); }, false);

在这个例子中，我们使用 addEventListener () 添加了一个事件处理程序。虽然调用 removeEventListener () 时看似使用了相同的参数，但实际上，第二个参数与传入 addEventListener () 中的那一个是完全不同的函数。而传入 removeEventListener () 中的事件处理程序函数必须与传入 addEventListener () 中的相同，如下面的例子所示。

var btn = document.getElementById ("myBtn"); var handler = function (){ alert (this.id); }; btn.addEventListener ("click", handler, false); // 这里省略了其他代码 btn.removeEventListener ("click", handler, false); // 有效！

DOMLevel2EventHandlerExample01.htm

重写后的这个例子没有问题，是因为在 addEventListener () 和 removeEventListener () 中使用了相同的函数。

大多数情况下，都是将事件处理程序添加到事件流的冒泡阶段，这样可以最大限度地兼容各种浏览器。最好只在需要在事件到达目标之前截获它的时候将事件处理程序添加到捕获阶段。如果不是特别需要，我们不建议在事件捕获阶段注册事件处理程序。

IE9、Firefox、Safari、Chrome 和 Opera 支持 DOM2 级事件处理程序。

13.2.4　IE 事件处理程序

IE 实现了与 DOM 中类似的两个方法：attachEvent () 和 detachEvent ()。这两个方法接受相同的两个参数：事件处理程序名称与事件处理程序函数。由于 IE8 及更早版本只支持事件冒泡，所以通过 attachEvent () 添加的事件处理程序都会被添加到冒泡阶段。

要使用 attachEvent () 为按钮添加一个事件处理程序，可以使用以下代码。

var btn = document.getElementById("myBtn"); btn.attachEvent("onclick", function(){ alert("Clicked"); });

IEEventHandlerExample01.htm

注意，attachEvent () 的第一个参数是 "onclick"，而非 DOM 的 addEventListener () 方法中的 "click"。

在 IE 中使用 attachEvent () 与使用 DOM0 级方法的主要区别在于事件处理程序的作用域。在使用 DOM0 级方法的情况下，事件处理程序会在其所属元素的作用域内运行；在使用 attachEvent () 方法的情况下，事件处理程序会在全局作用域中运行，因此 this 等于 window。来看下面的例子。

var btn = document.getElementById("myBtn"); btn.attachEvent("onclick", function(){ alert(this === window); //true });

在编写跨浏览器的代码时，牢记这一区别非常重要。

与 addEventListener () 类似，attachEvent () 方法也可以用来为一个元素添加多个事件处理程序。来看下面的例子。

var btn = document.getElementById("myBtn"); btn.attachEvent("onclick", function(){ alert("Clicked"); }); btn.attachEvent("onclick", function(){ alert("Hello world!"); });

IEEventHandlerExample01.htm

这里调用了两次 attachEvent ()，为同一个按钮添加了两个不同的事件处理程序。不过，与 DOM 方法不同的是，这些事件处理程序不是以添加它们的顺序执行，而是以相反的顺序被触发。单击这个例子中的按钮，首先看到的是 "Hello world!"，然后才是 "Clicked"。

使用 attachEvent () 添加的事件可以通过 detachEvent () 来移除，条件是必须提供相同的参数。与 DOM 方法一样，这也意味着添加的匿名函数将不能被移除。不过，只要能够将对相同函数的引用传给 detachEvent ()，就可以移除相应的事件处理程序。例如：

var btn = document.getElementById ("myBtn"); var handler = function (){ alert ("Clicked"); }; btn.attachEvent ("onclick", handler); // 这里省略了其他代码 btn.detachEvent ("onclick", handler);

IEEventHandlerExample02.htm

这个例子将保存在变量 handler 中的函数作为事件处理程序。因此，后面的 detachEvent () 可以使用相同的函数来移除事件处理程序。

支持 IE 事件处理程序的浏览器有 IE 和 Opera。

13.2.5　跨浏览器的事件处理程序

为了以跨浏览器的方式处理事件，不少开发人员会使用能够隔离浏览器差异的 JavaScript 库，还有一些开发人员会自己开发最合适的事件处理的方法。自己编写代码其实也不难，只要恰当地使用能力检测即可（能力检测在第 9 章介绍过）。要保证处理事件的代码能在大多数浏览器下一致地运行，只需关注冒泡阶段。

第一个要创建的方法是 addHandler ()，它的职责是视情况分别使用 DOM0 级方法、DOM2 级方法或 IE 方法来添加事件。这个方法属于一个名叫 EventUtil 的对象，本书将使用这个对象来处理浏览器间的差异。addHandler () 方法接受 3 个参数：要操作的元素、事件名称和事件处理程序函数。

与 addHandler () 对应的方法是 removeHandler ()，它也接受相同的参数。这个方法的职责是移除之前添加的事件处理程序 —— 无论该事件处理程序是采取什么方式添加到元素中的，如果其他方法无效，默认采用 DOM0 级方法。

EventUtil 的用法如下所示。

var EventUtil = { addHandler: function(element, type, handler){ if (element.addEventListener){ element.addEventListener(type, handler, false); } else if (element.attachEvent){ element.attachEvent("on" + type, handler); } else { element["on" + type] = handler; } }, removeHandler: function(element, type, handler){ if (element.removeEventListener){ element.removeEventListener(type, handler, false); } else if (element.detachEvent){ element.detachEvent("on" + type, handler); } else { element["on" + type] = null; } } };

EventUtil.js

这两个方法首先都会检测传入的元素中是否存在 DOM2 级方法。如果存在 DOM2 级方法，则使用该方法：传入事件类型、事件处理程序函数和第三个参数 false（表示冒泡阶段）。如果存在的是 IE 的方法，则采取第二种方案。注意，为了在 IE8 及更早版本中运行，此时的事件类型必须加上 "on" 前缀。最后一种可能就是使用 DOM0 级方法（在现代浏览器中，应该不会执行这里的代码）。此时，我们使用的是方括号语法来将属性名指定为事件处理程序，或者将属性设置为 null。

可以像下面这样使用 EventUtil 对象：

var btn = document.getElementById ("myBtn"); var handler = function (){ alert ("Clicked"); }; EventUtil.addHandler (btn, "click", handler); // 这里省略了其他代码 EventUtil.removeHandler (btn, "click", handler);

CrossBrowserEventHandlerExample01.htm

addHandler () 和 removeHandler () 没有考虑到所有的浏览器问题，例如在 IE 中的作用域问题。不过，使用它们添加和移除事件处理程序还是足够了。此外还要注意，DOM0 级对每个事件只支持一个事件处理程序。好在，只支持 DOM0 级的浏览器已经没有那么多了，因此这对你而言应该不是什么问题。

13.3　事件对象

在触发 DOM 上的某个事件时，会产生一个事件对象 event，这个对象中包含着所有与事件有关的信息。包括导致事件的元素、事件的类型以及其他与特定事件相关的信息。例如，鼠标操作导致的事件对象中，会包含鼠标位置的信息，而键盘操作导致的事件对象中，会包含与按下的键有关的信息。所有浏览器都支持 event 对象，但支持方式不同。

13.3.1　DOM 中的事件对象

兼容 DOM 的浏览器会将一个 event 对象传入到事件处理程序中。无论指定事件处理程序时使用什么方法（DOM0 级或 DOM2 级），都会传入 event 对象。来看下面的例子。

var btn = document.getElementById("myBtn"); btn.onclick = function(event){ alert(event.type); //"click" }; btn.addEventListener("click", function(event){ alert(event.type); //"click" }, false);

这个例子中的两个事件处理程序都会弹出一个警告框，显示由 event.type 属性表示的事件类型。这个属性始终都会包含被触发的事件类型，例如 "click"（与传入 addEventListener () 和 removeEventListener () 中的事件类型一致）。

在通过 HTML 特性指定事件处理程序时，变量 event 中保存着 event 对象。请看下面的例子。

<input type="button" value="Click Me" onclick="alert(event.type)"/>

以这种方式提供 event 对象，可以让 HTML 特性事件处理程序与 JavaScript 函数执行相同的操作。

event 对象包含与创建它的特定事件有关的属性和方法。触发的事件类型不一样，可用的属性和方法也不一样。不过，所有事件都会有下表列出的成员。

属性 / 方法 类　　型 读 / 写 说　　明

bubbles Boolean 只读 表明事件是否冒泡

cancelable Boolean 只读 表明是否可以取消事件的默认行为

currentTarget Element 只读 其事件处理程序当前正在处理事件的那个元素

defaultPrevented Boolean 只读 为 true 表示已经调用了 preventDefault ()（DOM3 级事件中新增）

detail Integer 只读 与事件相关的细节信息

eventPhase Integer 只读 调用事件处理程序的阶段：1 表示捕获阶段，2 表示「处于目标」，3 表示冒泡阶段

preventDefault () Function 只读 取消事件的默认行为。如果 cancelable 是 true，则可以使用这个方法

stopImmediatePropagation () Function 只读 取消事件的进一步捕获或冒泡，同时阻止任何事件处理程序被调用（DOM3 级事件中新增）

stopPropagation () Function 只读 取消事件的进一步捕获或冒泡。如果 bubbles 为 true，则可以使用这个方法

target Element 只读 事件的目标

trusted Boolean 只读 为 true 表示事件是浏览器生成的。为 false 表示事件是由开发人员通过 JavaScript 创建的（DOM3 级事件中新增）

type String 只读 被触发的事件的类型

view AbstractView 只读 与事件关联的抽象视图。等同于发生事件的 window 对象

在事件处理程序内部，对象 this 始终等于 currentTarget 的值，而 target 则只包含事件的实际目标。如果直接将事件处理程序指定给了目标元素，则 this、currentTarget 和 target 包含相同的值。来看下面的例子。

var btn = document.getElementById("myBtn"); btn.onclick = function(event){ alert(event.currentTarget === this); //true alert(event.target === this); //true };

DOMEventObjectExample01.htm

这个例子检测了 currentTarget 和 target 与 this 的值。由于 click 事件的目标是按钮，因此这三个值是相等的。如果事件处理程序存在于按钮的父节点中（例如 document.body），那么这些值是不相同的。再看下面的例子。

document.body.onclick = function(event){ alert(event.currentTarget === document.body); //true alert(this === document.body); //true alert(event.target === document.getElementById("myBtn")); //true };

DOMEventObjectExample02.htm

当单击这个例子中的按钮时，this 和 currentTarget 都等于 document.body，因为事件处理程序是注册到这个元素上的。然而，target 元素却等于按钮元素，因为它是 click 事件真正的目标。由于按钮上并没有注册事件处理程序，结果 click 事件就冒泡到了 document.body，在那里事件才得到了处理。

在需要通过一个函数处理多个事件时，可以使用 type 属性。例如：

var btn = document.getElementById("myBtn"); var handler = function(event){ switch(event.type){ case "click": alert("Clicked"); break; case "mouseover": event.target.style.backgroundColor = "red"; break; case "mouseout": event.target.style.backgroundColor = ""; break; } }; btn.onclick = handler; btn.onmouseover = handler; btn.onmouseout = handler;

DOMEventObjectExample03.htm

这个例子定义了一个名为 handler 的函数，用于处理 3 种事件：click、mouseover 和 mouseout。当单击按钮时，会出现一个与前面例子中一样的警告框。当按钮移动到按钮上面时，背景颜色应该会变成红色，而当鼠标移动出按钮的范围时，背景颜色应该会恢复为默认值。这里通过检测 event.type 属性，让函数能够确定发生了什么事件，并执行相应的操作。

要阻止特定事件的默认行为，可以使用 preventDefault () 方法。例如，链接的默认行为就是在被单击时会导航到其 href 特性指定的 URL。如果你想阻止链接导航这一默认行为，那么通过链接的 onclick 事件处理程序可以取消它，如下面的例子所示。

var link = document.getElementById("myLink"); link.onclick = function(event){ event.preventDefault(); };

DOMEventObjectExample04.htm

只有 cancelable 属性设置为 true 的事件，才可以使用 preventDefault () 来取消其默认行为。

另外，stopPropagation () 方法用于立即停止事件在 DOM 层次中的传播，即取消进一步的事件捕获或冒泡。例如，直接添加到一个按钮的事件处理程序可以调用 stopPropagation ()，从而避免触发注册在 document.body 上面的事件处理程序，如下面的例子所示。

var btn = document.getElementById("myBtn"); btn.onclick = function(event){ alert("Clicked"); event.stopPropagation(); }; document.body.onclick = function(event){ alert("Body clicked"); };

DOMEventObjectExample05.htm

对于这个例子而言，如果不调用 stopPropagation ()，就会在单击按钮时出现两个警告框。可是，由于 click 事件根本不会传播到 document.body，因此就不会触发注册在这个元素上的 onclick 事件处理程序。

事件对象的 eventPhase 属性，可以用来确定事件当前正位于事件流的哪个阶段。如果是在捕获阶段调用的事件处理程序，那么 eventPhase 等于 1；如果事件处理程序处于目标对象上，则 eventPhase 等于 2；如果是在冒泡阶段调用的事件处理程序，eventPhase 等于 3。这里要注意的是，尽管「处于目标」发生在冒泡阶段，但 eventPhase 仍然一直等于 2。来看下面的例子。

var btn = document.getElementById("myBtn"); btn.onclick = function(event){ alert(event.eventPhase); //2 }; document.body.addEventListener("click", function(event){ alert(event.eventPhase); //1 }, true); document.body.onclick = function(event){ alert(event.eventPhase); //3 };

DOMEventObjectExample06.htm

当单击这个例子中的按钮时，首先执行的事件处理程序是在捕获阶段触发的添加到 document.body 中的那一个，结果会弹出一个警告框显示表示 eventPhase 的 1。接着，会触发在按钮上注册的事件处理程序，此时的 eventPhase 值为 2。最后一个被触发的事件处理程序，是在冒泡阶段执行的添加到 document.body 上的那一个，显示 eventPhase 的值为 3。而当 eventPhase 等于 2 时，this、target 和 currentTarget 始终都是相等的。

只有在事件处理程序执行期间，event 对象才会存在；一旦事件处理程序执行完成，event 对象就会被销毁。

13.3.2　IE 中的事件对象

与访问 DOM 中的 event 对象不同，要访问 IE 中的 event 对象有几种不同的方式，取决于指定事件处理程序的方法。在使用 DOM0 级方法添加事件处理程序时，event 对象作为 window 对象的一个属性存在。来看下面的例子。

var btn = document.getElementById("myBtn"); btn.onclick = function(){ var event = window.event; alert(event.type); //"click" };

在此，我们通过 window.event 取得了 event 对象，并检测了被触发事件的类型（IE 中的 type 属性与 DOM 中的 type 属性是相同的）。可是，如果事件处理程序是使用 attachEvent () 添加的，那么就会有一个 event 对象作为参数被传入事件处理程序函数中，如下所示。

var btn = document.getElementById("myBtn"); btn.attachEvent("onclick", function(event){ alert(event.type); //"click" });

在像这样使用 attachEvent () 的情况下，也可以通过 window 对象来访问 event 对象，就像使用 DOM0 级方法时一样。不过为方便起见，同一个对象也会作为参数传递。

如果是通过 HTML 特性指定的事件处理程序，那么还可以通过一个名叫 event 的变量来访问 event 对象（与 DOM 中的事件模型相同）。再看一个例子。

<input type="button" value="Click Me" onclick="alert(event.type)">

IE 的 event 对象同样也包含与创建它的事件相关的属性和方法。其中很多属性和方法都有对应的或者相关的 DOM 属性和方法。与 DOM 的 event 对象一样，这些属性和方法也会因为事件类型的不同而不同，但所有事件对象都会包含下表所列的属性和方法。

属性 / 方法 类　　型 读 / 写 说　　明

cancelBubble Boolean 读 / 写 默认值为 false，但将其设置为 true 就可以取消事件冒泡（与 DOM 中的 stopPropagation () 方法的作用相同）

returnValue Boolean 读 / 写 默认值为 true，但将其设置为 false 就可以取消事件的默认行为（与 DOM 中的 preventDefault () 方法的作用相同）

srcElement Element 只读 事件的目标（与 DOM 中的 target 属性相同）

type String 只读 被触发的事件的类型

因为事件处理程序的作用域是根据指定它的方式来确定的，所以不能认为 this 会始终等于事件目标。故而，最好还是使用 event.srcElement 比较保险。例如：

var btn = document.getElementById("myBtn"); btn.onclick = function(){ alert(window.event.srcElement === this); //true }; btn.attachEvent("onclick", function(event){ alert(event.srcElement === this); //false });

IEEventObjectExample01.htm

在第一个事件处理程序中（使用 DOM0 级方法指定的），srcElement 属性等于 this，但在第二个事件处理程序中，这两者的值不相同。

如前所述，returnValue 属性相当于 DOM 中的 preventDefault () 方法，它们的作用都是取消给定事件的默认行为。只要将 returnValue 设置为 false，就可以阻止默认行为。来看下面的例子。

var link = document.getElementById("myLink"); link.onclick = function(){ window.event.returnValue = false; };

IEEventObjectExample02.htm

这个例子在 onclick 事件处理程序中使用 returnValue 达到了阻止链接默认行为的目的。与 DOM 不同的是，在此没有办法确定事件是否能被取消。

相应地，cancelBubble 属性与 DOM 中的 stopPropagation () 方法作用相同，都是用来停止事件冒泡的。由于 IE 不支持事件捕获，因而只能取消事件冒泡；但 stopPropagatioin () 可以同时取消事件捕获和冒泡。例如：

var btn = document.getElementById("myBtn"); btn.onclick = function(){ alert("Clicked"); window.event.cancelBubble = true; }; document.body.onclick = function(){ alert("Body clicked"); };

IEEventObjectExample03.htm

通过在 onclick 事件处理程序中将 cancelBubble 设置为 true，就可阻止事件通过冒泡而触发 document.body 中注册的事件处理程序。结果，在单击按钮之后，只会显示一个警告框。

13.3.3　跨浏览器的事件对象

虽然 DOM 和 IE 中的 event 对象不同，但基于它们之间的相似性依旧可以拿出跨浏览器的方案来。IE 中 event 对象的全部信息和方法 DOM 对象中都有，只不过实现方式不一样。不过，这种对应关系让实现两种事件模型之间的映射非常容易。可以对前面介绍的 EventUtil 对象加以增强，添加如下方法以求同存异。

var EventUtil = {addHandler: function (element, type, handler){// 省略的代码}, getEvent: function (event){return event ? event : window.event;}, getTarget: function (event){return event.target || event.srcElement;}, preventDefault: function (event){if (event.preventDefault){event.preventDefault (); } else {event.returnValue = false;} }, removeHandler: function (element, type, handler){// 省略的代码}, stopPropagation: function (event){if (event.stopPropagation){event.stopPropagation (); } else {event.cancelBubble = true;} } };

EventUtil.js

以上代码显示，我们为 EventUtil 添加了 4 个新方法。第一个是 getEvent ()，它返回对 event 对象的引用。考虑到 IE 中事件对象的位置不同，可以使用这个方法来取得 event 对象，而不必担心指定事件处理程序的方式。在使用这个方法时，必须假设有一个事件对象传入到事件处理程序中，而且要把该变量传给这个方法，如下所示。

btn.onclick = function(event){ event = EventUtil.getEvent(event); };

CrossBrowserEventObjectExample01.htm

在兼容 DOM 的浏览器中，event 变量只是简单地传入和返回。而在 IE 中，event 参数是未定义的（undefined），因此就会返回 window.event。将这一行代码添加到事件处理程序的开头，就可以确保随时都能使用 event 对象，而不必担心用户使用的是什么浏览器。

第二个方法是 getTarget ()，它返回事件的目标。在这个方法内部，会检测 event 对象的 target 属性，如果存在则返回该属性的值；否则，返回 srcElement 属性的值。可以像下面这样使用这个方法。

btn.onclick = function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); };

CrossBrowserEventObjectExample01.htm

第三个方法是 preventDefault ()，用于取消事件的默认行为。在传入 event 对象后，这个方法会检查是否存在 preventDefault () 方法，如果存在则调用该方法。如果 preventDefault () 方法不存在，则将 returnValue 设置为 false。下面是使用这个方法的例子。

var link = document.getElementById("myLink"); link.onclick = function(event){ event = EventUtil.getEvent(event); EventUtil.preventDefault(event); };

CrossBrowserEventObjectExample02.htm

以上代码可以确保在所有浏览器中单击该链接都不会打开另一个页面。首先，使用 EventUtil.getEvent () 取得 event 对象，然后将其传入到 EventUtil.preventDefault () 以取消默认行为。

第四个方法是 stopPropagation ()，其实现方式类似。首先尝试使用 DOM 方法阻止事件流，否则就使用 cancelBubble 属性。下面看一个例子。

var btn = document.getElementById("myBtn"); btn.onclick = function(event){ alert("Clicked"); event = EventUtil.getEvent(event); EventUtil.stopPropagation(event); }; document.body.onclick = function(event){ alert("Body clicked"); };

CrossBrowserEventObjectExample03.htm

在此，首先使用 EventUtil.getEvent () 取得了 event 对象，然后又将其传入到 EventUtil.stopPropagation ()。别忘了由于 IE 不支持事件捕获，因此这个方法在跨浏览器的情况下，也只能用来阻止事件冒泡。

13.4　事件类型

Web 浏览器中可能发生的事件有很多类型。如前所述，不同的事件类型具有不同的信息，而「DOM3 级事件」规定了以下几类事件。

UI（User Interface，用户界面）事件，当用户与页面上的元素交互时触发；

焦点事件，当元素获得或失去焦点时触发；

鼠标事件，当用户通过鼠标在页面上执行操作时触发；

滚轮事件，当使用鼠标滚轮（或类似设备）时触发；

文本事件，当在文档中输入文本时触发；

键盘事件，当用户通过键盘在页面上执行操作时触发；

合成事件，当为 IME（Input Method Editor，输入法编辑器）输入字符时触发；

变动（mutation）事件，当底层 DOM 结构发生变化时触发。

变动名称事件，当元素或属性名变动时触发。此类事件已经被废弃，没有任何浏览器实现它们，因此本章不做介绍。

除了这几类事件之外，HTML5 也定义了一组事件，而有些浏览器还会在 DOM 和 BOM 中实现其他专有事件。这些专有的事件一般都是根据开发人员需求定制的，没有什么规范，因此不同浏览器的实现有可能不一致。

DOM3 级事件模块在 DOM2 级事件模块基础上重新定义了这些事件，也添加了一些新事件。包括 IE9 在内的所有主流浏览器都支持 DOM2 级事件。IE9 也支持 DOM3 级事件。

13.4.1　UI 事件

UI 事件事件指的是那些不一定与用户操作有关的事件。这些事件在 DOM 规范出现之前，都是以这种或那种形式存在的，而在 DOM 规范中保留是为了向后兼容。现有的 UI 事件如下。

DOMActivate：表示元素已经被用户操作（通过鼠标或键盘）激活。这个事件在 DOM3 级事件中被废弃，但 Firefox 2 + 和 Chrome 支持它。考虑到不同浏览器实现的差异，不建议使用这个事件。

load：当页面完全加载后在 window 上面触发，当所有框架都加载完毕时在框架集上面触发，当图像加载完毕时在 <img> 元素上面触发，或者当嵌入的内容加载完毕时在 <object> 元素上面触发。

unload：当页面完全卸载后在 window 上面触发，当所有框架都卸载后在框架集上面触发，或者当嵌入的内容卸载完毕后在 <object> 元素上面触发。

abort：在用户停止下载过程时，如果嵌入的内容没有加载完，则在 <object> 元素上面触发。

error：当发生 JavaScript 错误时在 window 上面触发，当无法加载图像时在 <img> 元素上面触发，当无法加载嵌入内容时在 <object> 元素上面触发，或者当有一或多个框架无法加载时在框架集上面触发。第 17 章将继续讨论这个事件。

select：当用户选择文本框（<input> 或 <texterea>）中的一或多个字符时触发。第 14 章将继续讨论这个事件。

resize：当窗口或框架的大小变化时在 window 或框架上面触发。

scroll：当用户滚动带滚动条的元素中的内容时，在该元素上面触发。<body> 元素中包含所加载页面的滚动条。

多数这些事件都与 window 对象或表单控件相关。

除了 DOMActivate 之外，其他事件在 DOM2 级事件中都归为 HTML 事件（DOMActivate 在 DOM2 级中仍然属于 UI 事件）。要确定浏览器是否支持 DOM2 级事件规定的 HTML 事件，可以使用如下代码：

var isSupported = document.implementation.hasFeature("HTMLEvents", "2.0");

注意，只有根据「DOM2 级事件」实现这些事件的浏览器才会返回 true。而以非标准方式支持这些事件的浏览器则会返回 false。要确定浏览器是否支持「DOM3 级事件」定义的事件，可以使用如下代码：

var isSupported = document.implementation.hasFeature("UIEvent", "3.0");

1. load 事件

JavaScript 中最常用的一个事件就是 load。当页面完全加载后（包括所有图像、JavaScript 文件、CSS 文件等外部资源），就会触发 window 上面的 load 事件。有两种定义 onload 事件处理程序的方式。第一种方式是使用如下所示的 JavaScript 代码：

EventUtil.addHandler(window, "load", function(event){ alert("Loaded!"); });

LoadEventExample01.htm

这是通过 JavaScript 来指定事件处理程序的方式，使用了本章前面定义的跨浏览器的 EventUtil 对象。与添加其他事件一样，这里也给事件处理程序传入了一个 event 对象。这个 event 对象中不包含有关这个事件的任何附加信息，但在兼容 DOM 的浏览器中，event.target 属性的值会被设置为 document，而 IE 并不会为这个事件设置 srcElement 属性。

第二种指定 onload 事件处理程序的方式是为 <body> 元素添加一个 onload 特性，如下面的例子所示：

<!DOCTYPE html> <html> <head> <title>Load Event Example</title> </head> <body onload="alert('Loaded!')"> </body> </html>

LoadEventExample02.htm

一般来说，在 window 上面发生的任何事件都可以在 <body/> 元素中通过相应的特性来指定，因为在 HTML 中无法访问 window 元素。实际上，这只是为了保证向后兼容的一种权宜之计，但所有浏览器都能很好地支持这种方式。我们建议读者尽可能使用 JavaScript 方式。

根据「DOM2 级事件」规范，应该在 document 而非 window 上面触发 load 事件。但是，所有浏览器都在 window 上面实现了该事件，以确保向后兼容。

图像上面也可以触发 load 事件，无论是在 DOM 中的图像元素还是 HTML 中的图像元素。因此，可以在 HTML 中为任何图像指定 onload 事件处理程序，例如：

<img src="smile.gif" onload="alert('Image loaded.')">

LoadEventExample03.htm

这样，当例子中的图像加载完毕后就会显示一个警告框。同样的功能也可以使用 JavaScript 来实现，例如：

var image = document.getElementById("myImage"); EventUtil.addHandler(image, "load", function(event){ event = EventUtil.getEvent(event); alert(EventUtil.getTarget(event).src); });

LoadEventExample04.htm

这里，使用 JavaScript 指定了 onload 事件处理程序。同时也传入了 event 对象，尽管它也不包含什么有用的信息。不过，事件的目标是 <img> 元素，因此可以通过 src 属性访问并显示该信息。

在创建新的 <img> 元素时，可以为其指定一个事件处理程序，以便图像加载完毕后给出提示。此时，最重要的是要在指定 src 属性之前先指定事件，如下面的例子所示。

EventUtil.addHandler(window, "load", function(){ var image = document.createElement("img"); EventUtil.addHandler(image, "load", function(event){ event = EventUtil.getEvent(event); alert(EventUtil.getTarget(event).src); }); document.body.appendChild(image); image.src = "smile.gif"; });

LoadEventExample05.htm

在这个例子中，首先为 window 指定了 onload 事件处理程序。原因在于，我们是想向 DOM 中添加一个新元素，所以必须确定页面已经加载完毕 —— 如果在页面加载前操作 document.body 会导致错误。然后，创建了一个新的图像元素，并设置了其 onload 事件处理程序。最后又将这个图像添加到页面中，还设置了它的 src 属性。这里有一点需要格外注意：新图像元素不一定要从添加到文档后才开始下载，只要设置了 src 属性就会开始下载。

同样的功能也可以通过使用 DOM0 级的 Image 对象实现。在 DOM 出现之前，开发人员经常使用 Image 对象在客户端预先加载图像。可以像使用 <img> 元素一样使用 Image 对象，只不过无法将其添加到 DOM 树中。下面来看一个例子。

EventUtil.addHandler(window, "load", function(){ var image = new Image(); EventUtil.addHandler(image, "load", function(event){ alert("Image loaded!"); }); image.src = "smile.gif"; });

LoadEventExample06.htm

在此，我们使用 Image 构造函数创建了一个新图像的实例，然后又为它指定了事件处理程序。有的浏览器将 Image 对象实现为 <img> 元素，但并非所有浏览器都如此，所以最好将它们区别对待。

在不属于 DOM 文档的图像（包括未添加到文档的 <img> 元素和 Image 对象）上触发 load 事件时，IE8 及之前版本不会生成 event 对象。IE9 修复了这个问题。

还有一些元素也以非标准的方式支持 load 事件。在 IE9+、Firefox、Opera、Chrome 和 Safari 3 + 及更高版本中，<script> 元素也会触发 load 事件，以便开发人员确定动态加载的 JavaScript 文件是否加载完毕。与图像不同，只有在设置了 <script> 元素的 src 属性并将该元素添加到文档后，才会开始下载 JavaScript 文件。换句话说，对于 <script> 元素而言，指定 src 属性和指定事件处理程序的先后顺序就不重要了。以下代码展示了怎样为 <script> 元素指定事件处理程序。

EventUtil.addHandler(window, "load", function(){ var script = document.createElement("script"); EventUtil.addHandler(script, "load", function(event){ alert("Loaded"); }); script.src = "example.js"; document.body.appendChild(script); });

LoadEventExample07.htm

这个例子使用了跨浏览器的 EventUtil 对象为新创建的 <script> 元素指定了 onload 事件处理程序。此时，大多数浏览器中 event 对象的 target 属性引用的都是 <script> 节点，而在 Firefox 3 之前的版本中，引用的则是 document。IE8 及更早版本不支持 <script> 元素上的 load 事件。

IE 和 Opera 还支持 <link> 元素上的 load 事件，以便开发人员确定样式表是否加载完毕。例如：

EventUtil.addHandler(window, "load", function(){ var link = document.createElement("link"); link.type = "text/css"; link.rel= "stylesheet"; EventUtil.addHandler(link, "load", function(event){ alert("css loaded"); }); link.href = "example.css"; document.getElementsByTagName("head")[0].appendChild(link); });

LoadEventExample07.htm

与 <script> 节点类似，在未指定 href 属性并将 <link> 元素添加到文档之前也不会开始下载样式表。

2. unload 事件

与 load 事件对应的是 unload 事件，这个事件在文档被完全卸载后触发。只要用户从一个页面切换到另一个页面，就会发生 unload 事件。而利用这个事件最多的情况是清除引用，以避免内存泄漏。与 load 事件类似，也有两种指定 onunload 事件处理程序的方式。第一种方式是使用 JavaScript，如下所示：

EventUtil.addHandler(window, "unload", function(event){ alert("Unloaded"); });

此时生成的 event 对象在兼容 DOM 的浏览器中只包含 target 属性（值为 document）。IE8 及之前版本则为这个事件对象提供了 srcElement 属性。

指定事件处理程序的第二种方式，也是为 <body> 元素添加一个特性（与 load 事件相似），如下面的例子所示：

<!DOCTYPE html> <html> <head> <title>Unload Event Example</title> </head> <body onunload="alert('Unloaded!')"> </body> </html>

UnloadEventExample01.htm

无论使用哪种方式，都要小心编写 onunload 事件处理程序中的代码。既然 unload 事件是在一切都被卸载之后才触发，那么在页面加载后存在的那些对象，此时就不一定存在了。此时，操作 DOM 节点或者元素的样式就会导致错误。

根据「DOM2 级事件」，应该在 <body> 元素而非 window 对象上面触发 unload 事件。不过，所有浏览器都在 window 上实现了 unload 事件，以确保向后兼容。

3. resize 事件

当浏览器窗口被调整到一个新的高度或宽度时，就会触发 resize 事件。这个事件在 window（窗口）上面触发，因此可以通过 JavaScript 或者 <body> 元素中的 onresize 特性来指定事件处理程序。如前所述，我们还是推荐使用如下所示的 JavaScript 方式：

EventUtil.addHandler(window, "resize", function(event){ alert("Resized"); });

与其他发生在 window 上的事件类似，在兼容 DOM 的浏览器中，传入事件处理程序中的 event 对象有一个 target 属性，值为 document；而 IE8 及之前版本则未提供任何属性。

关于何时会触发 resize 事件，不同浏览器有不同的机制。IE、Safari、Chrome 和 Opera 会在浏览器窗口变化了 1 像素时就触发 resize 事件，然后随着变化不断重复触发。Firefox 则只会在用户停止调整窗口大小时才会触发 resize 事件。由于存在这个差别，应该注意不要在这个事件的处理程序中加入大计算量的代码，因为这些代码有可能被频繁执行，从而导致浏览器反应明显变慢。

浏览器窗口最小化或最大化时也会触发 resize 事件。

4. scroll 事件

虽然 scroll 事件是在 window 对象上发生的，但它实际表示的则是页面中相应元素的变化。在混杂模式下，可以通过 <body> 元素的 scrollLeft 和 scrollTop 来监控到这一变化；而在标准模式下，除 Safari 之外的所有浏览器都会通过 <html> 元素来反映这一变化（Safari 仍然基于 <body> 跟踪滚动位置），如下面的例子所示：

EventUtil.addHandler(window, "scroll", function(event){ if (document.compatMode == "CSS1Compat"){ alert(document.documentElement.scrollTop); } else { alert(document.body.scrollTop); } });

ScrollEventExample01.htm

以上代码指定的事件处理程序会输出页面的垂直滚动位置 —— 根据呈现模式不同使用了不同的元素。由于 Safari 3.1 之前的版本不支持 document.compatMode，因此旧版本的浏览器就会满足第二个条件。

与 resize 事件类似，scroll 事件也会在文档被滚动期间重复被触发，所以有必要尽量保持事件处理程序的代码简单。

13.4.2　焦点事件

焦点事件会在页面获得或失去焦点时触发。利用这些事件并与 document.hasFocus () 方法及 document.activeElement 属性配合，可以知晓用户在页面上的行踪。有以下 6 个焦点事件。

blur：在元素失去焦点时触发。这个事件不会冒泡；所有浏览器都支持它。

DOMFocusIn：在元素获得焦点时触发。这个事件与 HTML 事件 focus 等价，但它冒泡。只有 Opera 支持这个事件。DOM3 级事件废弃了 DOMFocusIn，选择了 focusin。

DOMFocusOut：在元素失去焦点时触发。这个事件是 HTML 事件 blur 的通用版本。只有 Opera 支持这个事件。DOM3 级事件废弃了 DOMFocusOut，选择了 focusout。

focus：在元素获得焦点时触发。这个事件不会冒泡；所有浏览器都支持它。

focusin：在元素获得焦点时触发。这个事件与 HTML 事件 focus 等价，但它冒泡。支持这个事件的浏览器有 IE5.5+、Safari 5.1+、Opera 11.5 + 和 Chrome。

focusout：在元素失去焦点时触发。这个事件是 HTML 事件 blur 的通用版本。支持这个事件的浏览器有 IE5.5+、Safari 5.1+、Opera 11.5 + 和 Chrome。

这一类事件中最主要的两个是 focus 和 blur，它们都是 JavaScript 早期就得到所有浏览器支持的事件。这些事件的最大问题是它们不冒泡。因此，IE 的 focusin 和 focusout 与 Opera 的 DOMFocusIn 和 DOMFocusOut 才会发生重叠。IE 的方式最后被 DOM3 级事件采纳为标准方式。

当焦点从页面中的一个元素移动到另一个元素，会依次触发下列事件：

focusout 在失去焦点的元素上触发；

focusin 在获得焦点的元素上触发；

blur 在失去焦点的元素上触发；

DOMFocusOut 在失去焦点的元素上触发；

focus 在获得焦点的元素上触发；

DOMFocusIn 在获得焦点的元素上触发。

其中，blur、DOMFocusOut 和 focusout 的事件目标是失去焦点的元素；而 focus、DOMFocusIn 和 focusin 的事件目标是获得焦点的元素。

要确定浏览器是否支持这些事件，可以使用如下代码：

var isSupported = document.implementation.hasFeature("FocusEvent", "3.0");

即使 focus 和 blur 不冒泡，也可以在捕获阶段侦听到它们。Peter-Paul Koch 就此写过一篇非常棒的文章：www.quirksmode.org/blog/archives/2008/04/delegating_the.html。

13.4.3　鼠标与滚轮事件

鼠标事件是 Web 开发中最常用的一类事件，毕竟鼠标还是最主要的定位设备。DOM3 级事件中定义了 9 个鼠标事件，简介如下。

click：在用户单击主鼠标按钮（一般是左边的按钮）或者按下回车键时触发。这一点对确保易访问性很重要，意味着 onclick 事件处理程序既可以通过键盘也可以通过鼠标执行。

dblclick：在用户双击主鼠标按钮（一般是左边的按钮）时触发。从技术上说，这个事件并不是 DOM2 级事件规范中规定的，但鉴于它得到了广泛支持，所以 DOM3 级事件将其纳入了标准。

mousedown：在用户按下了任意鼠标按钮时触发。不能通过键盘触发这个事件。

mouseenter：在鼠标光标从元素外部首次移动到元素范围之内时触发。这个事件不冒泡，而且在光标移动到后代元素上不会触发。DOM2 级事件并没有定义这个事件，但 DOM3 级事件将它纳入了规范。IE、Firefox 9 + 和 Opera 支持这个事件。

mouseleave：在位于元素上方的鼠标光标移动到元素范围之外时触发。这个事件不冒泡，而且在光标移动到后代元素上不会触发。DOM2 级事件并没有定义这个事件，但 DOM3 级事件将它纳入了规范。IE、Firefox 9 + 和 Opera 支持这个事件。

mousemove：当鼠标指针在元素内部移动时重复地触发。不能通过键盘触发这个事件。

mouseout：在鼠标指针位于一个元素上方，然后用户将其移入另一个元素时触发。又移入的另一个元素可能位于前一个元素的外部，也可能是这个元素的子元素。不能通过键盘触发这个事件。

mouseover：在鼠标指针位于一个元素外部，然后用户将其首次移入另一个元素边界之内时触发。不能通过键盘触发这个事件。

mouseup：在用户释放鼠标按钮时触发。不能通过键盘触发这个事件。

页面上的所有元素都支持鼠标事件。除了 mouseenter 和 mouseleave，所有鼠标事件都会冒泡，也可以被取消，而取消鼠标事件将会影响浏览器的默认行为。取消鼠标事件的默认行为还会影响其他事件，因为鼠标事件与其他事件是密不可分的关系。

只有在同一个元素上相继触发 mousedown 和 mouseup 事件，才会触发 click 事件；如果 mousedown 或 mouseup 中的一个被取消，就不会触发 click 事件。类似地，只有触发两次 click 事件，才会触发一次 dblclick 事件。如果有代码阻止了连续两次触发 click 事件（可能是直接取消 click 事件，也可能通过取消 mousedown 或 mouseup 间接实现），那么就不会触发 dblclick 事件了。这 4 个事件触发的顺序始终如下：

mousedown

mouseup

click

mousedown

mouseup

click

dblclick

显然，click 和 dblclick 事件都会依赖于其他先行事件的触发；而 mousedown 和 mouseup 则不受其他事件的影响。

IE8 及之前版本中的实现有一个小 bug，因此在双击事件中，会跳过第二个 mousedown 和 click 事件，其顺序如下：

mousedown

mouseup

click

mouseup

dblclick

IE9 修复了这个 bug，之后顺序就正确了。

使用以下代码可以检测浏览器是否支持以上 DOM2 级事件（除 dbclick、mouseenter 和 mouseleave 之外）：

var isSupported = document.implementation.hasFeature("MouseEvents", "2.0");

要检测浏览器是否支持上面的所有事件，可以使用以下代码：

var isSupported = document.implementation.hasFeature("MouseEvent", "3.0")

注意，DOM3 级事件的 feature 名是 "MouseEvent"，而非 "MouseEvents"。

鼠标事件中还有一类滚轮事件。而说是一类事件，其实就是一个 mousewheel 事件。这个事件跟踪鼠标滚轮，类似于 Mac 的触控板。

1. 客户区坐标位置

鼠标事件都是在浏览器视口中的特定位置上发生的。这个位置信息保存在事件对象的 clientX 和 clientY 属性中。所有浏览器都支持这两个属性，它们的值表示事件发生时鼠标指针在视口中的水平和垂直坐标。图 13-4 展示了视口中客户区坐标位置的含义。

图　13-4

可以使用类似下列代码取得鼠标事件的客户端坐标信息：

var div = document.getElementById("myDiv"); EventUtil.addHandler(div, "click", function(event){ event = EventUtil.getEvent(event); alert("Client coordinates: " + event.clientX + "," + event.clientY); });

ClientCoordinatesExample01.htm

这里为一个 <div> 元素指定了 onclick 事件处理程序。当用户单击这个元素时，就会看到事件的客户端坐标信息。注意，这些值中不包括页面滚动的距离，因此这个位置并不表示鼠标在页面上的位置。

2. 页面坐标位置

通过客户区坐标能够知道鼠标是在视口中什么位置发生的，而页面坐标通过事件对象的 pageX 和 pageY 属性，能告诉你事件是在页面中的什么位置发生的。换句话说，这两个属性表示鼠标光标在页面中的位置，因此坐标是从页面本身而非视口的左边和顶边计算的。

以下代码可以取得鼠标事件在页面中的坐标：

var div = document.getElementById("myDiv"); EventUtil.addHandler(div, "click", function(event){ event = EventUtil.getEvent(event); alert("Page coordinates: " + event.pageX + "," + event.pageY); });

PageCoordinatesExample01.htm

在页面没有滚动的情况下，pageX 和 pageY 的值与 clientX 和 clientY 的值相等。

IE8 及更早版本不支持事件对象上的页面坐标，不过使用客户区坐标和滚动信息可以计算出来。这时候需要用到 document.body（混杂模式）或 document.documentElement（标准模式）中的 scrollLeft 和 scrollTop 属性。计算过程如下所示：

var div = document.getElementById("myDiv"); EventUtil.addHandler(div, "click", function(event){ event = EventUtil.getEvent(event); var pageX = event.pageX, pageY = event.pageY; if (pageX === undefined){ pageX = event.clientX + (document.body.scrollLeft || document.documentElement.scrollLeft); } if (pageY === undefined){ pageY = event.clientY + (document.body.scrollTop || document.documentElement.scrollTop); } alert("Page coordinates: " + pageX + "," + pageY); });

PageCoordinatesExample01.htm

3. 屏幕坐标位置

鼠标事件发生时，不仅会有相对于浏览器窗口的位置，还有一个相对于整个电脑屏幕的位置。而通过 screenX 和 screenY 属性就可以确定鼠标事件发生时鼠标指针相对于整个屏幕的坐标信息。图 13-5 展示了浏览器中屏幕坐标的含义。

图　13-5

可以使用类似下面的代码取得鼠标事件的屏幕坐标：

var div = document.getElementById("myDiv"); EventUtil.addHandler(div, "click", function(event){ event = EventUtil.getEvent(event); alert("Screen coordinates: " + event.screenX + "," + event.screenY); });

ScreenCoordinatesExample01.htm

与前一个例子类似，这里也是为 <div> 元素指定了一个 onclick 事件处理程序。当这个元素被单击时，就会显示出事件的屏幕坐标信息了。

4. 修改键

虽然鼠标事件主要是使用鼠标来触发的，但在按下鼠标时键盘上的某些键的状态也可以影响到所要采取的操作。这些修改键就是 Shift、Ctrl、Alt 和 Meta（在 Windows 键盘中是 Windows 键，在苹果机中是 Cmd 键），它们经常被用来修改鼠标事件的行为。DOM 为此规定了 4 个属性，表示这些修改键的状态：shiftKey、ctrlKey、altKey 和 metaKey。这些属性中包含的都是布尔值，如果相应的键被按下了，则值为 true，否则值为 false。当某个鼠标事件发生时，通过检测这几个属性就可以确定用户是否同时按下了其中的键。来看下面的例子。

var div = document.getElementById("myDiv"); EventUtil.addHandler(div, "click", function(event){ event = EventUtil.getEvent(event); var keys = new Array(); if (event.shiftKey){ keys.push("shift"); } if (event.ctrlKey){ keys.push("ctrl"); } if (event.altKey){ keys.push("alt"); } if (event.metaKey){ keys.push("meta"); } alert("Keys: " + keys.join(",")); });

ModifierKeysExample01.htm

在这个例子中，我们通过一个 onclick 事件处理程序检测了不同修改键的状态。数组 keys 中包含着被按下的修改键的名称。换句话说，如果有属性值为 true，就会将对应修改键的名称添加到 keys 数组中。在事件处理程序的最后，有一个警告框将检测到的键的信息显示给用户。

IE9、Firefox、Safari、Chrome 和 Opera 都支持这 4 个键。IE8 及之前版本不支持 metaKey 属性。

5. 相关元素

在发生 mouseover 和 mouserout 事件时，还会涉及更多的元素。这两个事件都会涉及把鼠标指针从一个元素的边界之内移动到另一个元素的边界之内。对 mouseover 事件而言，事件的主目标是获得光标的元素，而相关元素就是那个失去光标的元素。类似地，对 mouseout 事件而言，事件的主目标是失去光标的元素，而相关元素则是获得光标的元素。来看下面的例子。

<!DOCTYPE html> <html> <head> <title>Related Elements Example</title> </head> <body> <div id="myDiv" style="background-color:red;height:100px;width:100px;"></div> </body> </html>

RelatedElementsExample01.htm

这个例子会在页面上显示一个 <div> 元素。如果鼠标指针一开始位于这个 <div> 元素上，然后移出了这个元素，那么就会在 <div> 元素上触发 mouseout 事件，相关元素就是 <body> 元素。与此同时，<body> 元素上面会触发 mouseover 事件，而相关元素变成了 <div>。

DOM 通过 event 对象的 relatedTarget 属性提供了相关元素的信息。这个属性只对于 mouseover 和 mouseout 事件才包含值；对于其他事件，这个属性的值是 null。IE8 及之前版本不支持 relatedTarget 属性，但提供了保存着同样信息的不同属性。在 mouseover 事件触发时，IE 的 fromElement 属性中保存了相关元素；在 mouseout 事件触发时，IE 的 toElement 属性中保存着相关元素。（IE9 支持所有这些属性。）可以把下面这个跨浏览器取得相关元素的方法添加到 EventUtil 对象中。

var EventUtil = {// 省略了其他代码 getRelatedTarget: function (event){if (event.relatedTarget){return event.relatedTarget;} else if (event.toElement){return event.toElement;} else if (event.fromElement){return event.fromElement;} else {return null;} }, // 省略了其他代码 };

EventUtil.js

与以前添加的跨浏览器方法一样，这个方法也使用了特性检测来确定返回哪个值。可以像下面这样使用 EventUtil.getRelatedTarget () 方法：

var div = document.getElementById("myDiv"); EventUtil.addHandler(div, "mouseout", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); var relatedTarget = EventUtil.getRelatedTarget(event); alert("Moused out of " + target.tagName + " to " + relatedTarget.tagName); });

