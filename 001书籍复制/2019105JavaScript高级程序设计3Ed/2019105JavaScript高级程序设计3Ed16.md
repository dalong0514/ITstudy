clientX：触摸目标在视口中的 x 坐标。

clientY：触摸目标在视口中的 y 坐标。

identifier：标识触摸的唯一 ID。

pageX：触摸目标在页面中的 x 坐标。

pageY：触摸目标在页面中的 y 坐标。

screenX：触摸目标在屏幕中的 x 坐标。

screenY：触摸目标在屏幕中的 y 坐标。

target：触摸的 DOM 节点目标。

使用这些属性可以跟踪用户对屏幕的触摸操作。来看下面的例子。

function handleTouchEvent (event){// 只跟踪一次触摸 if (event.touches.length == 1){var output = document.getElementById ("output"); switch (event.type){case "touchstart": output.innerHTML = "Touch started (" + event.touches [0].clientX + "," + event.touches [0].clientY + ")"; break; case "touchend": output.innerHTML += "<br>Touch ended (" + event.changedTouches [0].clientX + "," + event.changedTouches [0].clientY + ")"; break; case "touchmove": event.preventDefault (); // 阻止滚动 output.innerHTML += "<br>Touch moved (" + event.changedTouches [0].clientX + "," + event.changedTouches [0].clientY + ")"; break; } } } EventUtil.addHandler (document, "touchstart", handleTouchEvent); EventUtil.addHandler (document, "touchend", handleTouchEvent); EventUtil.addHandler (document, "touchmove", handleTouchEvent);

TouchEventsExample01.htm

以上代码会跟踪屏幕上发生的一次触摸操作。为简单起见，只会在有一次活动触摸操作的情况下输出信息。当 touchstart 事件发生时，会将触摸的位置信息输出到 <div> 元素中。当 touchmove 事件发生时，会取消其默认行为，阻止滚动（触摸移动的默认行为是滚动页面），然后输出触摸操作的变化信息。而 touchend 事件则会输出有关触摸操作的最终信息。注意，在 touchend 事件发生时，touches 集合中就没有任何 Touch 对象了，因为不存在活动的触摸操作；此时，就必须转而使用 changeTouchs 集合。

这些事件会在文档的所有元素上面触发，因而可以分别操作页面的不同部分。在触摸屏幕上的元素时，这些事件（包括鼠标事件）发生的顺序如下：

touchstart

mouseover

mousemove（一次）

mousedown

mouseup

click

touchend

支持触摸事件的浏览器包括 iOS 版 Safari、Android 版 WebKit、bada 版 Dolfin、OS6 + 中的 BlackBerry WebKit、Opera Mobile 10.1 + 和 LG 专有 OS 中的 Phantom 浏览器。目前只有 iOS 版 Safari 支持多点触摸。桌面版 Firefox 6 + 和 Chrome 也支持触摸事件。

2. 手势事件

iOS 2.0 中的 Safari 还引入了一组手势事件。当两个手指触摸屏幕时就会产生手势，手势通常会改变显示项的大小，或者旋转显示项。有三个手势事件，分别介绍如下。

gesturestart：当一个手指已经按在屏幕上而另一个手指又触摸屏幕时触发。

gesturechange：当触摸屏幕的任何一个手指的位置发生变化时触发。

gestureend：当任何一个手指从屏幕上面移开时触发。

只有两个手指都触摸到事件的接收容器时才会触发这些事件。在一个元素上设置事件处理程序，意味着两个手指必须同时位于该元素的范围之内，才能触发手势事件（这个元素就是目标）。由于这些事件冒泡，所以将事件处理程序放在文档上也可以处理所有手势事件。此时，事件的目标就是两个手指都位于其范围内的那个元素。

触摸事件和手势事件之间存在某种关系。当一个手指放在屏幕上时，会触发 touchstart 事件。如果另一个手指又放在了屏幕上，则会先触发 gesturestart 事件，随后触发基于该手指的 touchstart 事件。如果一个或两个手指在屏幕上滑动，将会触发 gesturechange 事件。但只要有一个手指移开，就会触发 gestureend 事件，紧接着又会触发基于该手指的 touchend 事件。

与触摸事件一样，每个手势事件的 event 对象都包含着标准的鼠标事件属性：bubbles、cancelable、view、clientX、clientY、screenX、screenY、detail、altKey、shiftKey、ctrlKey 和 metaKey。此外，还包含两个额外的属性：rotation 和 scale。其中，rotation 属性表示手指变化引起的旋转角度，负值表示逆时针旋转，正值表示顺时针旋转（该值从 0 开始）。而 scale 属性表示两个手指间距离的变化情况（例如向内收缩会缩短距离）；这个值从 1 开始，并随距离拉大而增长，随距离缩短而减小。

下面是使用手势事件的一个示例。

function handleGestureEvent(event){ var output = document.getElementById("output"); switch(event.type){ case "gesturestart": output.innerHTML = "Gesture started (rotation=" + event.rotation + ",scale=" + event.scale + ")"; break; case "gestureend": output.innerHTML += "<br>Gesture ended (rotation=" + event.rotation + ",scale=" + event.scale + ")"; break; case "gesturechange": output.innerHTML += "<br>Gesture changed (rotation=" + event.rotation + ",scale=" + event.scale + ")"; break; } } document.addEventListener("gesturestart", handleGestureEvent, false); document.addEventListener("gestureend", handleGestureEvent, false); document.addEventListener("gesturechange", handleGestureEvent, false);

GestureEventsExample01.htm

与前面演示触摸事件的例子一样，这里的代码只是将每个事件都关联到同一个函数中，然后通过该函数输出每个事件的相关信息。

触摸事件也会返回 rotation 和 scale 属性，但这两个属性只会在两个手指与屏幕保持接触时才会发生变化。一般来说，使用基于两个手指的手势事件，要比管理触摸事件中的所有交互要容易得多。

13.5　内存和性能

由于事件处理程序可以为现代 Web 应用程序提供交互能力，因此许多开发人员会不分青红皂白地向页面中添加大量的处理程序。在创建 GUI 的语言（如 C#）中，为 GUI 中的每个按钮添加一个 onclick 事件处理程序是司空见惯的事，而且这样做也不会导致什么问题。可是在 JavaScript 中，添加到页面上的事件处理程序数量将直接关系到页面的整体运行性能。导致这一问题的原因是多方面的。首先，每个函数都是对象，都会占用内存；内存中的对象越多，性能就越差。其次，必须事先指定所有事件处理程序而导致的 DOM 访问次数，会延迟整个页面的交互就绪时间。事实上，从如何利用好事件处理程序的角度出发，还是有一些方法能够提升性能的。

13.5.1　事件委托

对「事件处理程序过多」问题的解决方案就是事件委托。事件委托利用了事件冒泡，只指定一个事件处理程序，就可以管理某一类型的所有事件。例如，click 事件会一直冒泡到 document 层次。也就是说，我们可以为整个页面指定一个 onclick 事件处理程序，而不必给每个可单击的元素分别添加事件处理程序。以下面的 HTML 代码为例。

<ul id="myLinks"> <li id="goSomewhere">Go somewhere</li> <li id="doSomething">Do something</li> <li id="sayHi">Say hi</li> </ul>

EventDelegationExample01.htm

其中包含 3 个被单击后会执行操作的列表项。按照传统的做法，需要像下面这样为它们添加 3 个事件处理程序。

var item1 = document.getElementById("goSomewhere"); var item2 = document.getElementById("doSomething"); var item3 = document.getElementById("sayHi"); EventUtil.addHandler(item1, "click", function(event){ location.href = "http://www.wrox.com"; }); EventUtil.addHandler(item2, "click", function(event){ document.title = "I changed the document's title"; }); EventUtil.addHandler(item3, "click", function(event){ alert("hi"); });

如果在一个复杂的 Web 应用程序中，对所有可单击的元素都采用这种方式，那么结果就会有数不清的代码用于添加事件处理程序。此时，可以利用事件委托技术解决这个问题。使用事件委托，只需在 DOM 树中尽量最高的层次上添加一个事件处理程序，如下面的例子所示。

var list = document.getElementById("myLinks"); EventUtil.addHandler(list, "click", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); switch(target.id){ case "doSomething": document.title = "I changed the document's title"; break; case "goSomewhere": location.href = "http://www.wrox.com"; break; case "sayHi": alert("hi"); break; } });

EventDelegationExample01.htm

在这段代码里，我们使用事件委托只为 <ul> 元素添加了一个 onclick 事件处理程序。由于所有列表项都是这个元素的子节点，而且它们的事件会冒泡，所以单击事件最终会被这个函数处理。我们知道，事件目标是被单击的列表项，故而可以通过检测 id 属性来决定采取适当的操作。与前面未使用事件委托的代码比一比，会发现这段代码的事前消耗更低，因为只取得了一个 DOM 元素，只添加了一个事件处理程序。虽然对用户来说最终的结果相同，但这种技术需要占用的内存更少。所有用到按钮的事件（多数鼠标事件和键盘事件）都适合采用事件委托技术。

如果可行的话，也可以考虑为 document 对象添加一个事件处理程序，用以处理页面上发生的某种特定类型的事件。这样做与采取传统的做法相比具有如下优点。

document 对象很快就可以访问，而且可以在页面生命周期的任何时点上为它添加事件处理程序（无需等待 DOMContentLoaded 或 load 事件）。换句话说，只要可单击的元素呈现在页面上，就可以立即具备适当的功能。

在页面中设置事件处理程序所需的时间更少。只添加一个事件处理程序所需的 DOM 引用更少，所花的时间也更少。

整个页面占用的内存空间更少，能够提升整体性能。

最适合采用事件委托技术的事件包括 click、mousedown、mouseup、keydown、keyup 和 keypress。虽然 mouseover 和 mouseout 事件也冒泡，但要适当处理它们并不容易，而且经常需要计算元素的位置。（因为当鼠标从一个元素移到其子节点时，或者当鼠标移出该元素时，都会触发 mouseout 事件。）

13.5.2　移除事件处理程序

每当将事件处理程序指定给元素时，运行中的浏览器代码与支持页面交互的 JavaScript 代码之间就会建立一个连接。这种连接越多，页面执行起来就越慢。如前所述，可以采用事件委托技术，限制建立的连接数量。另外，在不需要的时候移除事件处理程序，也是解决这个问题的一种方案。内存中留有那些过时不用的「空事件处理程序」（dangling event handler），也是造成 Web 应用程序内存与性能问题的主要原因。

在两种情况下，可能会造成上述问题。第一种情况就是从文档中移除带有事件处理程序的元素时。这可能是通过纯粹的 DOM 操作，例如使用 removeChild () 和 replaceChild () 方法，但更多地是发生在使用 innerHTML 替换页面中某一部分的时候。如果带有事件处理程序的元素被 innerHTML 删除了，那么原来添加到元素中的事件处理程序极有可能无法被当作垃圾回收。来看下面的例子。

<div id="myDiv"> <input type="button" value="Click Me" id="myBtn"> </div> <script type="text/javascript"> var btn = document.getElementById ("myBtn"); btn.onclick = function (){ // 先执行某些操作 document.getElementById ("myDiv").innerHTML = "Processing..."; // 麻烦了！ }; </script>

这里，有一个按钮被包含在 <div> 元素中。为避免双击，单击这个按钮时就将按钮移除并替换成一条消息；这是网站设计中非常流行的一种做法。但问题在于，当按钮被从页面中移除时，它还带着一个事件处理程序呢。在 <div> 元素上设置 innerHTML 可以把按钮移走，但事件处理程序仍然与按钮保持着引用关系。有的浏览器（尤其是 IE）在这种情况下不会作出恰当地处理，它们很有可能会将对元素和对事件处理程序的引用都保存在内存中。如果你知道某个元素即将被移除，那么最好手工移除事件处理程序，如下面的例子所示。

<div id="myDiv"> <input type="button" value="Click Me" id="myBtn"> </div> <script type="text/javascript"> var btn = document.getElementById ("myBtn"); btn.onclick = function (){ // 先执行某些操作 btn.onclick = null; // 移除事件处理程序 document.getElementById ("myDiv").innerHTML = "Processing..."; }; </script>

在此，我们在设置 <div> 的 innerHTML 属性之前，先移除了按钮的事件处理程序。这样就确保了内存可以被再次利用，而从 DOM 中移除按钮也做到了干净利索。

注意，在事件处理程序中删除按钮也能阻止事件冒泡。目标元素在文档中是事件冒泡的前提。

采用事件委托也有助于解决这个问题。如果事先知道将来有可能使用 innerHTML 替换掉页面中的某一部分，那么就可以不直接把事件处理程序添加到该部分的元素中。而通过把事件处理程序指定给较高层次的元素，同样能够处理该区域中的事件。

导致「空事件处理程序」的另一种情况，就是卸载页面的时候。毫不奇怪，IE8 及更早版本在这种情况下依然是问题最多的浏览器，尽管其他浏览器或多或少也有类似的问题。如果在页面被卸载之前没有清理干净事件处理程序，那它们就会滞留在内存中。每次加载完页面再卸载页面时（可能是在两个页面间来回切换，也可以是单击了「刷新」按钮），内存中滞留的对象数目就会增加，因为事件处理程序占用的内存并没有被释放。

一般来说，最好的做法是在页面卸载之前，先通过 onunload 事件处理程序移除所有事件处理程序。在此，事件委托技术再次表现出它的优势 —— 需要跟踪的事件处理程序越少，移除它们就越容易。对这种类似撤销的操作，我们可以把它想象成：只要是通过 onload 事件处理程序添加的东西，最后都要通过 onunload 事件处理程序将它们移除。

不要忘了，使用 onunload 事件处理程序意味着页面不会被缓存在 bfcache 中。如果你在意这个问题，那么就只能在 IE 中通过 onunload 来移除事件处理程序了。

13.6　模拟事件

事件，就是网页中某个特别值得关注的瞬间。事件经常由用户操作或通过其他浏览器功能来触发。但很少有人知道，也可以使用 JavaScript 在任意时刻来触发特定的事件，而此时的事件就如同浏览器创建的事件一样。也就是说，这些事件该冒泡还会冒泡，而且照样能够导致浏览器执行已经指定的处理它们的事件处理程序。在测试 Web 应用程序，模拟触发事件是一种极其有用的技术。DOM2 级规范为此规定了模拟特定事件的方式，IE9、Opera、Firefox、Chrome 和 Safari 都支持这种方式。IE 有它自己模拟事件的方式。

13.6.1　DOM 中的事件模拟

可以在 document 对象上使用 createEvent () 方法创建 event 对象。这个方法接收一个参数，即表示要创建的事件类型的字符串。在 DOM2 级中，所有这些字符串都使用英文复数形式，而在 DOM3 级中都变成了单数。这个字符串可以是下列几字符串之一。

UIEvents：一般化的 UI 事件。鼠标事件和键盘事件都继承自 UI 事件。DOM3 级中是 UIEvent。

MouseEvents：一般化的鼠标事件。DOM3 级中是 MouseEvent。

MutationEvents：一般化的 DOM 变动事件。DOM3 级中是 MutationEvent。

HTMLEvents：一般化的 HTML 事件。没有对应的 DOM3 级事件（HTML 事件被分散到其他类别中）。

要注意的是，「DOM2 级事件」并没有专门规定键盘事件，后来的「DOM3 级事件」中才正式将其作为一种事件给出规定。IE9 是目前唯一支持 DOM3 级键盘事件的浏览器。不过，在其他浏览器中，在现有方法的基础上，可以通过几种方式来模拟键盘事件。

在创建了 event 对象之后，还需要使用与事件有关的信息对其进行初始化。每种类型的 event 对象都有一个特殊的方法，为它传入适当的数据就可以初始化该 event 对象。不同类型的这个方法的名字也不相同，具体要取决于 createEvent () 中使用的参数。

模拟事件的最后一步就是触发事件。这一步需要使用 dispatchEvent () 方法，所有支持事件的 DOM 节点都支持这个方法。调用 dispatchEvent () 方法时，需要传入一个参数，即表示要触发事件的 event 对象。触发事件之后，该事件就跻身「官方事件」之列了，因而能够照样冒泡并引发相应事件处理程序的执行。

1. 模拟鼠标事件

创建新的鼠标事件对象并为其指定必要的信息，就可以模拟鼠标事件。创建鼠标事件对象的方法是为 createEvent () 传入字符串 "MouseEvents"。返回的对象有一个名为 initMouseEvent () 方法，用于指定与该鼠标事件有关的信息。这个方法接收 15 个参数，分别与鼠标事件中每个典型的属性一一对应；这些参数的含义如下。

type（字符串）：表示要触发的事件类型，例如 "click"。

bubbles（布尔值）：表示事件是否应该冒泡。为精确地模拟鼠标事件，应该把这个参数设置为 true。

cancelable（布尔值）：表示事件是否可以取消。为精确地模拟鼠标事件，应该把这个参数设置为 true。

view（AbstractView）：与事件关联的视图。这个参数几乎总是要设置为 document.defaultView。

detail（整数）：与事件有关的详细信息。这个值一般只有事件处理程序使用，但通常都设置为 0。

screenX（整数）：事件相对于屏幕的 X 坐标。

screenY（整数）：事件相对于屏幕的 Y 坐标。

clientX（整数）：事件相对于视口的 X 坐标。

clientY（整数）：事件想对于视口的 Y 坐标。

ctrlKey（布尔值）：表示是否按下了 Ctrl 键。默认值为 false。

altKey（布尔值）：表示是否按下了 Alt 键。默认值为 false。

shiftKey（布尔值）：表示是否按下了 Shift 键。默认值为 false。

metaKey（布尔值）：表示是否按下了 Meta 键。默认值为 false。

button（整数）：表示按下了哪一个鼠标键。默认值为 0。

relatedTarget（对象）：表示与事件相关的对象。这个参数只在模拟 mouseover 或 mouseout 时使用。

显而易见，initMouseEvent () 方法的这些参数是与鼠标事件的 event 对象所包含的属性一一对应的。其中，前 4 个参数对正确地激发事件至关重要，因为浏览器要用到这些参数；而剩下的所有参数只有在事件处理程序中才会用到。当把 event 对象传给 dispatchEvent () 方法时，这个对象的 target 属性会自动设置。下面，我们就通过一个例子来了解如何模拟对按钮的单击事件。

var btn = document.getElementById ("myBtn"); // 创建事件对象 var event = document.createEvent ("MouseEvents"); // 初始化事件对象 event.initMouseEvent ("click", true, true, document.defaultView, 0, 0, 0, 0, 0, false, false, false, false, 0, null); // 触发事件 btn.dispatchEvent (event);

SimulateDOMClickExample01.htm

在兼容 DOM 的浏览器中，也可以通过相同的方式来模拟其他鼠标事件（例如 dblclick）。

2. 模拟键盘事件

前面曾经提到过，「DOM2 级事件」中没有就键盘事件作出规定，因此模拟键盘事件并没有现成的思路可循。「DOM2 级事件」的草案中本来包含了键盘事件，但在定稿之前又被删除了；Firefox 根据其草案实现了键盘事件。需要提请大家注意的是，「DOM3 级事件」中的键盘事件与曾包含在「DOM2 级事件」草案中的键盘事件有很大区别。

DOM3 级规定，调用 createEvent () 并传入 "KeyboardEvent" 就可以创建一个键盘事件。返回的事件对象会包含一个 initKeyEvent () 方法，这个方法接收下列参数。

type（字符串）：表示要触发的事件类型，如 "keydown"。

bubbles（布尔值）：表示事件是否应该冒泡。为精确模拟鼠标事件，应该设置为 true。

cancelable（布尔值）：表示事件是否可以取消。为精确模拟鼠标事件，应该设置为 true。

view（AbstractView）：与事件关联的视图。这个参数几乎总是要设置为 document.defaultView。

key（布尔值）：表示按下的键的键码。

location（整数）：表示按下了哪里的键。0 表示默认的主键盘，1 表示左，2 表示右，3 表示数字键盘，4 表示移动设备（即虚拟键盘），5 表示手柄。

modifiers（字符串）：空格分隔的修改键列表，如 "Shift"。

repeat（整数）：在一行中按了这个键多少次。

由于 DOM3 级不提倡使用 keypress 事件，因此只能利用这种技术来模拟 keydown 和 keyup 事件。

var textbox = document.getElementById ("myTextbox"), event; // 以 DOM3 级方式创建事件对象 if (document.implementation.hasFeature ("KeyboardEvents", "3.0")){event = document.createEvent ("KeyboardEvent"); // 初始化事件对象 event.initKeyboardEvent ("keydown", true, true, document.defaultView, "a", 0, "Shift", 0); } // 触发事件 textbox.dispatchEvent (event);

SimulateDOMKeyEventExample01.htm

这个例子模拟的是按住 Shift 的同时又按下 A 键。在使用 document.createEvent ("KeyboardEvent") 之前，应该先检测浏览器是否支持 DOM3 级事件；其他浏览器返回一个非标准的 KeyboardEvent 对象。

在 Firefox 中，调用 createEvent () 并传入 "KeyEvents" 就可以创建一个键盘事件。返回的事件对象会包含一个 initKeyEvent () 方法，这个方法接受下列 10 个参数。

type（字符串）：表示要触发的事件类型，如 "keydown"。

bubbles（布尔值）：表示事件是否应该冒泡。为精确模拟鼠标事件，应该设置为 true。

cancelable（布尔值）：表示事件是否可以取消。为精确模拟鼠标事件，应该设置为 true。

view（AbstractView）：与事件关联的视图。这个参数几乎总是要设置为 document.defaultView。

ctrlKey（布尔值）：表示是否按下了 Ctrl 键。默认值为 false。

altKey（布尔值）：表示是否按下了 Alt 键。默认值为 false。

shiftKey（布尔值）：表示是否按下了 Shift 键。默认值为 false。

metaKey（布尔值）：表示是否按下了 Meta 键。默认值为 false。

keyCode（整数）：被按下或释放的键的键码。这个参数对 keydown 和 keyup 事件有用，默认值为 0。

charCode（整数）：通过按键生成的字符的 ASCII 编码。这个参数对 keypress 事件有用，默认值为 0。

将创建的 event 对象传入到 dispatchEvent () 方法就可以触发键盘事件，如下面的例子所示。

// 只适用于 Firefox var textbox = document.getElementById ("myTextbox") // 创建事件对象 var event = document.createEvent ("KeyEvents"); // 初始化事件对象 event.initKeyEvent ("keypress", true, true, document.defaultView, false, false, false, false, 65, 65); // 触发事件 textbox.dispatchEvent (event);

SimulateFFKeyEventExample01.htm

在 Firefox 中运行上面的代码，会在指定的文本框中输入字母 A。同样，也可以依此模拟 keyup 和 keydown 事件。

在其他浏览器中，则需要创建一个通用的事件，然后再向事件对象中添加键盘事件特有的信息。例如：

var textbox = document.getElementById ("myTextbox"); // 创建事件对象 var event = document.createEvent ("Events"); // 初始化事件对象 event.initEvent (type, bubbles, cancelable); event.view = document.defaultView; event.altKey = false; event.ctrlKey = false; event.shiftKey = false; event.metaKey = false; event.keyCode = 65; event.charCode = 65; // 触发事件 textbox.dispatchEvent (event);

以上代码首先创建了一个通用事件，然后调用 initEvent () 对其进行初始化，最后又为其添加了键盘事件的具体信息。在此必须要使用通用事件，而不能使用 UI 事件，因为 UI 事件不允许向 event 对象中再添加新属性（Safari 除外）。像这样模拟事件虽然会触发键盘事件，但却不会向文本框中写入文本，这是由于无法精确模拟键盘事件所造成的。

3. 模拟其他事件

虽然鼠标事件和键盘事件是在浏览器中最经常模拟的事件，但有时候同样需要模拟变动事件和 HTML 事件。要模拟变动事件，可以使用 createEvent ("MutationEvents") 创建一个包含 initMutationEvent () 方法的变动事件对象。这个方法接受的参数包括：type、bubbles、cancelable、relatedNode、preValue、newValue、attrName 和 attrChange。下面来看一个模拟变动事件的例子。

var event = document.createEvent("MutationEvents"); event.initMutationEvent("DOMNodeInserted", true, false, someNode, "","","",0); target.dispatchEvent(event);

以上代码模拟了 DOMNodeInserted 事件。其他变动事件也都可以照这个样子来模拟，只要改一改参数就可以了。

要模拟 HTML 事件，同样需要先创建一个 event 对象 —— 通过 createEvent ("HTMLEvents")，然后再使用这个对象的 initEvent () 方法来初始化它即可，如下面的例子所示。

var event = document.createEvent("HTMLEvents"); event.initEvent("focus", true, false); target.dispatchEvent(event);

这个例子展示了如何在给定目标上模拟 focus 事件。模拟其他 HTML 事件的方法也是这样。

浏览器中很少使用变动事件和 HTML 事件，因为使用它们会受到一些限制。

4. 自定义 DOM 事件

DOM3 级还定义了「自定义事件」。自定义事件不是由 DOM 原生触发的，它的目的是让开发人员创建自己的事件。要创建新的自定义事件，可以调用 createEvent ("CustomEvent")。返回的对象有一个名为 initCustomEvent () 的方法，接收如下 4 个参数。

type（字符串）：触发的事件类型，例如 "keydown"。

bubbles（布尔值）：表示事件是否应该冒泡。

cancelable（布尔值）：表示事件是否可以取消。

detail（对象）：任意值，保存在 event 对象的 detail 属性中。

可以像分派其他事件一样在 DOM 中分派创建的自定义事件对象。例如：

var div = document.getElementById("myDiv"), event; EventUtil.addHandler(div, "myevent", function(event){ alert("DIV: " + event.detail); }); EventUtil.addHandler(document, "myevent", function(event){ alert("DOCUMENT: " + event.detail); }); if (document.implementation.hasFeature("CustomEvents", "3.0")){ event = document.createEvent("CustomEvent"); event.initCustomEvent("myevent", true, false, "Hello world!"); div.dispatchEvent(event); }

SimulateDOMCustomEventExample01.htm

这个例子创建了一个冒泡事件 "myevent"。而 event.detail 的值被设置成了一个简单的字符串，然后在 <div> 元素和 document 上侦听这个事件。因为 initCustomEvent () 方法已经指定这个事件应该冒泡，所以浏览器会负责将事件向上冒泡到 document。

支持自定义 DOM 事件的浏览器有 IE9 + 和 Firefox 6+。

13.6.2　IE 中的事件模拟

在 IE8 及之前版本中模拟事件与在 DOM 中模拟事件的思路相似：先创建 event 对象，然后为其指定相应的信息，然后再使用该对象来触发事件。当然，IE 在实现每个步骤时都采用了不一样的方式。

调用 document.createEventObject () 方法可以在 IE 中创建 event 对象。但与 DOM 方式不同的是，这个方法不接受参数，结果会返回一个通用的 event 对象。然后，你必须手工为这个对象添加所有必要的信息（没有方法来辅助完成这一步骤）。最后一步就是在目标上调用 fireEvent () 方法，这个方法接受两个参数：事件处理程序的名称和 event 对象。在调用 fireEvent () 方法时，会自动为 event 对象添加 srcElement 和 type 属性；其他属性则都是必须通过手工添加的。换句话说，模拟任何 IE 支持的事件都采用相同的模式。例如，下面的代码模拟了在一个按钮上触发 click 事件过程。

var btn = document.getElementById ("myBtn"); // 创建事件对象 var event = document.createEventObject (); // 初始化事件对象 event.screenX = 100; event.screenY = 0; event.clientX = 0; event.clientY = 0; event.ctrlKey = false; event.altKey = false; event.shiftKey = false; event.button = 0; // 触发事件 btn.fireEvent ("onclick", event);

SimulateIEClickExample01.htm

这个例子先创建了一个 event 对象，然后又用一些信息对其进行了初始化。注意，这里可以为对象随意添加属性，不会有任何限制 —— 即使添加的属性 IE8 及更早版本并不支持也无所谓。在此添加的属性对事件没有什么影响，因为只有事件处理程序才会用到它们。

采用相同的模式也可以模拟触发 keypress 事件，如下面的例子所示。

var textbox = document.getElementById ("myTextbox"); // 创建事件对象 var event = document.createEventObject (); // 初始化事件对象 event.altKey = false; event.ctrlKey = false; event.shiftKey = false; event.keyCode = 65; // 触发事件 textbox.fireEvent ("onkeypress", event);

SimulateIEKeyEventExample01.htm

由于鼠标事件、键盘事件以及其他事件的 event 对象并没有什么不同，所以可以使用通用对象来触发任何类型的事件。不过，正如在 DOM 中模拟键盘事件一样，运行这个例子也不会因模拟了 keypress 而在文本框中看到任何字符，即使触发了事件处理程序也没有用。

13.7　小结

事件是将 JavaScript 与网页联系在一起的主要方式。「DOM3 级事件」规范和 HTML5 定义了常见的大多数事件。即使有规范定义了基本事件，但很多浏览器仍然在规范之外实现了自己的专有事件，从而为开发人员提供更多掌握用户交互的手段。有些专有事件与特定设备关联，例如移动 Safari 中的 orientationchange 事件就是特定关联 iOS 设备的。

在使用事件时，需要考虑如下一些内存与性能方面的问题。

有必要限制一个页面中事件处理程序的数量，数量太多会导致占用大量内存，而且也会让用户感觉页面反应不够灵敏。

建立在事件冒泡机制之上的事件委托技术，可以有效地减少事件处理程序的数量。

建议在浏览器卸载页面之前移除页面中的所有事件处理程序。

可以使用 JavaScript 在浏览器中模拟事件。「DOM2 级事件」和「DOM3 级事件」规范规定了模拟事件的方法，为模拟各种有定义的事件提供了方便。此外，通过组合使用一些技术，还可以在某种程度上模拟键盘事件。IE8 及之前版本同样支持事件模拟，只不过模拟的过程有些差异。

事件是 JavaScript 中最重要的主题之一，深入理解事件的工作机制以及它们对性能的影响至关重要。

第 14 章　表单脚本

本章内容

理解表单

文本框验证与交互

使用其他表单控制

JavaScript 最初的一个应用，就是分担服务器处理表单的责任，打破处处依赖服务器的局面。尽管目前的 Web 和 JavaScript 已经有了长足的发展，但 Web 表单的变化并不明显。由于 Web 表单没有为许多常见任务提供现成的解决手段，很多开发人员不仅会在验证表单时使用 JavaScirpt，而且还增强了一些标准表单控件的默认行为。

14.1　表单的基础知识

在 HTML 中，表单是由 <form> 元素来表示的，而在 JavaScript 中，表单对应的则是 HTMLFormElement 类型。HTMLFormElement 继承了 HTMLElement，因而与其他 HTML 元素具有相同的默认属性。不过，HTMLFormElement 也有它自己下列独有的属性和方法。

acceptCharset：服务器能够处理的字符集；等价于 HTML 中的 accept-charset 特性。

action：接受请求的 URL；等价于 HTML 中的 action 特性。

elements：表单中所有控件的集合（HTMLCollection）。

enctype：请求的编码类型；等价于 HTML 中的 enctype 特性。

length：表单中控件的数量。

method：要发送的 HTTP 请求类型，通常是 "get" 或 "post"；等价于 HTML 的 method 特性。

name：表单的名称；等价于 HTML 的 name 特性。

reset ()：将所有表单域重置为默认值。

submit ()：提交表单。

target：用于发送请求和接收响应的窗口名称；等价于 HTML 的 target 特性。

取得 <form> 元素引用的方式有好几种。其中最常见的方式就是将它看成与其他元素一样，并为其添加 id 特性，然后再像下面这样使用 getElementById () 方法找到它。

var form = document.getElementById("form1");

其次，通过 document.forms 可以取得页面中所有的表单。在这个集合中，可以通过数值索引或 name 值来取得特定的表单，如下面的例子所示。

var firstForm = document.forms [0]; // 取得页面中的第一个表单 var myForm = document.forms ["form2"]; // 取得页面中名称为 "form2" 的表单

另外，在较早的浏览器或者那些支持向后兼容的浏览器中，也会把每个设置了 name 特性的表单作为属性保存在 document 对象中。例如，通过 document.form2 可以访问到名为 "form2" 的表单。不过，我们不推荐使用这种方式：一是容易出错，二是将来的浏览器可能会不支持。

注意，可以同时为表单指定 id 和 name 属性，但它们的值不一定相同。

14.1.1　提交表单

用户单击提交按钮或图像按钮时，就会提交表单。使用 <input> 或 <button> 都可以定义提交按钮，只要将其 type 特性的值设置为 "submit" 即可，而图像按钮则是通过将 <input> 的 type 特性值设置为 "image" 来定义的。因此，只要我们单击以下代码生成的按钮，就可以提交表单。

<!-- 通用提交按钮 --> <input type="submit" value="Submit Form"> <!-- 自定义提交按钮 --> <button type="submit">Submit Form</button> <!-- 图像按钮 --> <input type="image" src="graphic.gif">

只要表单中存在上面列出的任何一种按钮，那么在相应表单控件拥有焦点的情况下，按回车键就可以提交该表单。（textarea 是一个例外，在文本区中回车会换行。）如果表单里没有提交按钮，按回车键不会提交表单。

以这种方式提交表单时，浏览器会在将请求发送给服务器之前触发 submit 事件。这样，我们就有机会验证表单数据，并据以决定是否允许表单提交。阻止这个事件的默认行为就可以取消表单提交。例如，下列代码会阻止表单提交。

var form = document.getElementById ("myForm"); EventUtil.addHandler (form, "submit", function (event){// 取得事件对象 event = EventUtil.getEvent (event); // 阻止默认事件 EventUtil.preventDefault (event); });

这里使用了第 13 章定义的 EventUtil 对象，以便跨浏览器处理事件。调用 prevetnDefault () 方法阻止了表单提交。一般来说，在表单数据无效而不能发送给服务器时，可以使用这一技术。

在 JavaScript 中，以编程方式调用 submit () 方法也可以提交表单。而且，这种方式无需表单包含提交按钮，任何时候都可以正常提交表单。来看一个例子。

var form = document.getElementById ("myForm"); // 提交表单 form.submit ();

在以调用 submit () 方法的形式提交表单时，不会触发 submit 事件，因此要记得在调用此方法之前先验证表单数据。

提交表单时可能出现的最大问题，就是重复提交表单。在第一次提交表单后，如果长时间没有反应，用户可能会变得不耐烦。这时候，他们也许会反复单击提交按钮。结果往往很麻烦（因为服务器要处理重复的请求），或者会造成错误（如果用户是下订单，那么可能会多订好几份）。解决这一问题的办法有两个：在第一次提交表单后就禁用提交按钮，或者利用 onsubmit 事件处理程序取消后续的表单提交操作。

14.1.2　重置表单

在用户单击重置按钮时，表单会被重置。使用 type 特性值为 "reset" 的 <input> 或 <button> 都可以创建重置按钮，如下面的例子所示。

<!-- 通用重置按钮 --> <input type="reset" value="Reset Form"> <!-- 自定义重置按钮 --> <button type="reset">Reset Form</button>

这两个按钮都可以用来重置表单。在重置表单时，所有表单字段都会恢复到页面刚加载完毕时的初始值。如果某个字段的初始值为空，就会恢复为空；而带有默认值的字段，也会恢复为默认值。

用户单击重置按钮重置表单时，会触发 reset 事件。利用这个机会，我们可以在必要时取消重置操作。例如，下面展示了阻止重置表单的代码。

var form = document.getElementById ("myForm"); EventUtil.addHandler (form, "reset", function (event){// 取得事件对象 event = EventUtil.getEvent (event); // 阻止表单重置 EventUtil.preventDefault (event); });

与提交表单一样，也可以通过 JavaScript 来重置表单，如下面的例子所示。

var form = document.getElementById ("myForm"); // 重置表单 form.reset ();

与调用 submit () 方法不同，调用 reset () 方法会像单击重置按钮一样触发 reset 事件。

在 Web 表单设计中，重置表单通常意味着对已经填写的数据不满意。重置表单经常会导致用户摸不着头脑，如果意外地触发了表单重置事件，那么用户甚至会很恼火。事实上，重置表单的需求是很少见的。更常见的做法是提供一个取消按钮，让用户能够回到前一个页面，而不是不分青红皂白地重置表单中的所有值。

14.1.3　表单字段

可以像访问页面中的其他元素一样，使用原生 DOM 方法访问表单元素。此外，每个表单都有 elements 属性，该属性是表单中所有元素的集合。这个 elements 集合是一个有序列表，其中包含着表单中的所有字段，例如 <input>、<textarea>、<button> 和 <fieldset>。每个表单字段在 elements 集合中的顺序，与它们出现在标记中的顺序相同，可以按照位置和 name 特性来访问它们。下面来看一个例子。

var form = document.getElementById ("form1"); // 取得表单中的第一个字段 var field1 = form.elements [0]; // 取得名为 "textbox1" 的字段 var field2 = form.elements ["textbox1"]; // 取得表单中包含的字段的数量 var fieldCount = form.elements.length;

如果有多个表单控件都在使用一个 name（如单选按钮），那么就会返回以该 name 命名的一个 NodeList。例如，以下面的 HTML 代码片段为例。

<form method="post" id="myForm"> <ul> <li><input type="radio" name="color" value="red">Red</li> <li><input type="radio" name="color" value="green">Green</li> <li><input type="radio" name="color" value="blue">Blue</li> </ul> </form>

FormFieldsExample01.htm

在这个 HTML 表单中，有 3 个单选按钮，它们的 name 都是 "color"，意味着这 3 个字段是一起的。在访问 elements ["color"] 时，就会返回一下 NodeList，其中包含这 3 个元素；不过，如果访问 elements [0]，则只会返回第一个元素。来看下面的例子。

var form = document.getElementById("myForm"); var colorFields = form.elements["color"]; alert(colorFields.length); //3 var firstColorField = colorFields[0]; var firstFormField = form.elements[0]; alert(firstColorField === firstFormField); //true

FormFieldsExample01.htm

以上代码显示，通过 form.elements [0] 访问到的第一个表单字段，与包含在 form.elements ["color"] 中的第一个元素相同。

也可以通过访问表单的属性来访问元素，例如 form [0] 可以取得第一个表单字段，而 form ["color"] 则可以取得第一个命名字段。这些属性与通过 elements 集合访问到的元素是相同的。但是，我们应该尽可能使用 elements，通过表单属性访问元素只是为了与旧浏览器向后兼容而保留的一种过渡方式。

1. 共有的表单字段属性

除了 <fieldset> 元素之外，所有表单字段都拥有相同的一组属性。由于 <input> 类型可以表示多种表单字段，因此有些属性只适用于某些字段，但还有一些属性是所有字段所共有的。表单字段共有的属性和方法如下。

disabled：布尔值，表示当前字段是否被禁用。

form：指向当前字段所属表单的指针；只读。

name：当前字段的名称。

readOnly：布尔值，表示当前字段是否只读。

tabIndex：表示当前字段的切换（tab）序号。

type：当前字段的类型，如 "checkbox"、"radio"，等等。

value：当前字段将被提交给服务器的值。对文件字段来说，这个属性是只读的，包含着文件在计算机中的路径。

除了 form 属性之外，可以通过 JavaScript 动态修改其他任何属性。来看下面的例子：

var form = document.getElementById ("myForm"); var field = form.elements [0]; // 修改 value 属性 field.value = "Another value"; // 检查 form 属性的值 alert (field.form === form); //true// 把焦点设置到当前字段 field.focus (); // 禁用当前字段 field.disabled = true; // 修改 type 属性（不推荐，但对 < input> 来说是可行的） field.type = "checkbox";

能够动态修改表单字段属性，意味着我们可以在任何时候，以任何方式来动态操作表单。例如，很多用户可能会重复单击表单的提交按钮。在涉及信用卡消费时，这就是个问题：因为会导致费用翻番。为此，最常见的解决方案，就是在第一次单击后就禁用提交按钮。只要侦听 submit 事件，并在该事件发生时禁用提交按钮即可。以下就是这样一个例子。

// 避免多次提交表单 EventUtil.addHandler (form, "submit", function (event){event = EventUtil.getEvent (event); var target = EventUtil.getTarget (event); // 取得提交按钮 var btn = target.elements ["submit-btn"]; // 禁用它 btn.disabled = true; });

FormFieldsExample02.htm

以上代码为表单的 submit 事件添加了一个事件处理程序。事件触发后，代码取得了提交按钮并将其 disabled 属性设置为 true。注意，不能通过 onclick 事件处理程序来实现这个功能，原因是不同浏览器之间存在「时差」：有的浏览器会在触发表单的 submit 事件之前触发 click 事件，而有的浏览器则相反。对于先触发 click 事件的浏览器，意味着会在提交发生之前禁用按钮，结果永远都不会提交表单。因此，最好是通过 submit 事件来禁用提交按钮。不过，这种方式不适合表单中不包含提交按钮的情况；如前所述，只有在包含提交按钮的情况下，才有可能触发表单的 submit 事件。

除了 <fieldset> 之外，所有表单字段都有 type 属性。对于 <input> 元素，这个值等于 HTML 特性 type 的值。对于其他元素，这个 type 属性的值如下表所列。

说　　明 HTML 示例 type 属性的值

单选列表 <select>...</select> "select-one"

多选列表 <select multiple>...</select> "select-multiple"

自定义按钮 <button>...</button> "submit"

自定义非提交按钮 <button type="button">...</button> "button"

自定义重置按钮 <button type="reset">...</buton> "reset"

自定义提交按钮 <button type="submit">...</buton> "submit"

此外，<input> 和 <button> 元素的 type 属性是可以动态修改的，而 <select> 元素的 type 属性则是只读的。

2. 共有的表单字段方法

每个表单字段都有两个方法：focus () 和 blur ()。其中，focus () 方法用于将浏览器的焦点设置到表单字段，即激活表单字段，使其可以响应键盘事件。例如，接收到焦点的文本框会显示插入符号，随时可以接收输入。使用 focus () 方法，可以将用户的注意力吸引到页面中的某个部位。例如，在页面加载完毕后，将焦点转移到表单中的第一个字段。为此，可以侦听页面的 load 事件，并在该事件发生时在表单的第一个字段上调用 focus () 方法，如下面的例子所示。

EventUtil.addHandler(window, "load", function(event){ document.forms[0].elements[0].focus(); });

要注意的是，如果第一个表单字段是一个 <input> 元素，且其 type 特性的值为 "hidden"，那么以上代码会导致错误。另外，如果使用 CSS 的 display 和 visibility 属性隐藏了该字段，同样也会导致错误。

HTML5 为表单字段新增了一个 autofocus 属性。在支持这个属性的浏览器中，只要设置这个属性，不用 JavaScript 就能自动把焦点移动到相应字段。例如：

<input type="text" autofocus>

为了保证前面的代码在设置 autofocus 的浏览器中正常运行，必须先检测是否设置了该属性，如果设置了，就不用再调用 focus () 了。

EventUtil.addHandler(window, "load", function(event){ var element = document.forms[0].elements[0]; if (element.autofocus !== true){ element.focus(); console.log("JS focus"); } });

FocusExample01.htm

因为 autofocus 是一个布尔值属性，所以在支持的浏览器中它的值应该是 true。（在不支持的浏览器中，它的值将是空字符串。）为此，上面的代码只有在 autofocus 不等于 true 的情况下才会调用 focus ()，从而保证向前兼容。支持 autofocus 属性的浏览器有 Firefox 4+、Safari 5+、Chrome 和 Opera 9.6。

在默认情况下，只有表单字段可以获得焦点。对于其他元素而言，如果先将其 tabIndex 属性设置为 - 1，然后再调用 focus () 方法，也可以让这些元素获得焦点。只有 Opera 不支持这种技术。

与 focus () 方法相对的是 blur () 方法，它的作用是从元素中移走焦点。在调用 blur () 方法时，并不会把焦点转移到某个特定的元素上；仅仅是将焦点从调用这个方法的元素上面移走而已。在早期 Web 开发中，那时候的表单字段还没有 readonly 特性，因此就可以使用 blur () 方法来创建只读字段。现在，虽然需要使用 blur () 的场合不多了，但必要时还可以使用的。用法如下：

document.forms[0].elements[0].blur();

3. 共有的表单字段事件

除了支持鼠标、键盘、更改和 HTML 事件之外，所有表单字段都支持下列 3 个事件。

blur：当前字段失去焦点时触发。

change：对于 <input> 和 <textarea> 元素，在它们失去焦点且 value 值改变时触发；对于 <select> 元素，在其选项改变时触发。

focus：当前字段获得焦点时触发。

当用户改变了当前字段的焦点，或者我们调用了 blur () 或 focus () 方法时，都可以触发 blur 和 focus 事件。这两个事件在所有表单字段中都是相同的。但是，change 事件在不同表单控件中触发的次数会有所不同。对于 <input> 和 <textarea> 元素，当它们从获得焦点到失去焦点且 value 值改变时，才会触发 change 事件。对于 <select> 元素，只要用户选择了不同的选项，就会触发 change 事件；换句话说，不失去焦点也会触发 change 事件。

通常，可以使用 focus 和 blur 事件来以某种方式改变用户界面，要么是向用户给出视觉提示，要么是向界面中添加额外的功能（例如，为文本框显示一个下拉选项菜单）。而 change 事件则经常用于验证用户在字段中输入的数据。例如，假设有一个文本框，我们只允许用户输入数值。此时，可以利用 focus 事件修改文本框的背景颜色，以便更清楚地表明这个字段获得了焦点。可以利用 blur 事件恢复文本框的背景颜色，利用 change 事件在用户输入了非数值字符时再次修改背景颜色。下面就给出了实现上述功能的代码。

var textbox = document.forms[0].elements[0]; EventUtil.addHandler(textbox, "focus", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); if (target.style.backgroundcolor != "red"){ target.style.backgroundColor = "yellow"; } }); EventUtil.addHandler(textbox, "blur", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); if (/[^\d]/.test(target.value)){ target.style.backgroundColor = "red"; } else { target.style.backgroundColor = ""; } }); EventUtil.addHandler(textbox, "change", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); if (/[^\d]/.test(target.value)){ target.style.backgroundColor = "red"; } else { target.style.backgroundColor = ""; } });

FormFieldEventsExample01.htm

在此，onfocus 事件处理程序将文本框的背景颜色修改为黄色，以清楚地表单当前字段已经激活。随后，onblur 和 onchange 事件处理程序则会在发现非数值字符时，将文本框背景颜色修改为红色。为了测试用户输入的是不是非数值，这里针对文本框的 value 属性使用了简单的正则表达式。而且，为确保无论文本框的值如何变化，验证规则始终如一，onblur 和 onchange 事件处理程序中使用了相同的正则表达式。

关于 blur 和 change 事件的关系，并没有严格的规定。在某些浏览器中，blur 事件会先于 change 事件发生；而在其他浏览器中，则恰好相反。为此，不能假定这两个事件总会以某种顺序依次触发，这一点要特别注意。

14.2　文本框脚本

在 HTML 中，有两种方式来表现文本框：一种是使用 <input> 元素的单行文本框，另一种是使用 <textarea> 的多行文本框。这两个控件非常相似，而且多数时候的行为也差不多。不过，它们之间仍然存在一些重要的区别。

要表现文本框，必须将 <input> 元素的 type 特性设置为 "text"。而通过设置 size 特性，可以指定文本框中能够显示的字符数。通过 value 特性，可以设置文本框的初始值，而 maxlength 特性则用于指定文本框可以接受的最大字符数。如果要创建一个文本框，让它能够显示 25 个字符，但输入不能超过 50 个字符，可以使用以下代码：

<input type="text" size="25" maxlength="50" value="initial value">

相对而言，<textarea> 元素则始终会呈现为一个多行文本框。要指定文本框的大小，可以使用 rows 和 cols 特性。其中，rows 特性指定的是文本框的字符行数，而 cols 特性指定的是文本框的字符列数（类似于 <input> 元素的 size 特性）。与 <input> 元素不同，<textarea> 的初始值必须要放在 <textarea> 和 </textarea> 之间，如下面的例子所示。

<textarea rows="25" cols="5">initial value</textarea>

另一个与 <input> 的区别在于，不能在 HTML 中给 <textarea> 指定最大字符数。

无论这两种文本框在标记中有什么区别，但它们都会将用户输入的内容保存在 value 属性中。可以通过这个属性读取和设置文本框的值，如下面的例子所示：

var textbox = document.forms[0].elements["textbox1"]; alert(textbox.value); textbox.value = "Some new value";

我们建议读者像上面这样使用 value 属性读取或设置文本框的值，不建议使用标准的 DOM 方法。换句话说，不要使用 setAttribute () 设置 < input> 元素的 value 特性，也不要去修改 <textarea> 元素的第一个子节点。原因很简单：对 value 属性所作的修改，不一定会反映在 DOM 中。因此，在处理文本框的值时，最好不要使用 DOM 方法。

14.2.1　选择文本

上述两种文本框都支持 select () 方法，这个方法用于选择文本框中的所有文本。在调用 select () 方法时，大多数浏览器（Opera 除外）都会将焦点设置到文本框中。这个方法不接受参数，可以在任何时候被调用。下面来看一个例子。

var textbox = document.forms[0].elements["textbox1"]; textbox.select();

在文本框获得焦点时选择其所有文本，这是一种非常常见的做法，特别是在文本框包含默认值的时候。因为这样做可以让用户不必一个一个地删除文本。下面展示了实现这一操作的代码。

EventUtil.addHandler(textbox, "focus", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); target.select(); });

TextboxSelectExample01.htm

将上面的代码应用到文本框之后，只要文本框获得焦点，就会选择其中所有的文本。这种技术能够较大幅度地提升表单的易用性。

1. 选择（select）事件

与 select () 方法对应的，是一个 select 事件。在选择了文本框中的文本时，就会触发 select 事件。不过，到底什么时候触发 select 事件，还会因浏览器而异。在 IE9+、Opera、Firefox、Chrome 和 Safari 中，只有用户选择了文本（而且要释放鼠标），才会触发 select 事件。而在 IE8 及更早版本中，只要用户选择了一个字母（不必释放鼠标），就会触发 select 事件。另外，在调用 select () 方法时也会触发 select 事件。下面是一个简单的例子。

var textbox = document.forms[0].elements["textbox1"]; EventUtil.addHandler(textbox, "select", function(event){ var alert("Text selected" + textbox.value); });

SelectEventExample01.htm

2. 取得选择的文本

虽然通过 select 事件我们可以知道用户什么时候选择了文本，但仍然不知道用户选择了什么文本。HTML5 通过一些扩展方案解决了这个问题，以便更顺利地取得选择的文本。该规范采取的办法是添加两个属性：selectionStart 和 selectionEnd。这两个属性中保存的是基于 0 的数值，表示所选择文本的范围（即文本选区开头和结尾的偏移量）。因此，要取得用户在文本框中选择的文本，可以使用如下代码。

function getSelectedText(textbox){ return textbox.value.substring(textbox.selectionStart, textbox.selectionEnd); }

因为 substring () 方法基于字符串的偏移量执行操作，所以将 selectionStart 和 selectionEnd 直接传给它就可以取得选中的文本。

IE9+、Firefox、Safari、Chrome 和 Opera 都支持这两个属性。IE8 及之前版本不支持这两个属性，而是提供了另一种方案。

IE8 及更早的版本中有一个 document.selection 对象，其中保存着用户在整个文档范围内选择的文本信息；也就是说，无法确定用户选择的是页面中哪个部位的文本。不过，在与 select 事件一起使用的时候，可以假定是用户选择了文本框中的文本，因而触发了该事件。要取得选择的文本，首先必须创建一个范围（第 12 章讨论过），然后再将文本从其中提取出来，如下面的例子所示。

function getSelectedText(textbox){ if (typeof textbox.selectionStart == "number"){ return textbox.value.substring(textbox.selectionStart, textbox.selectionEnd); } else if (document.selection){ return document.selection.createRange().text; } }

TextboxGetSelectedTextExample01.htm

这里修改了前面的函数，包括了在 IE 中取得选择文本的代码。注意，调用 document.selection 时，不需要考虑 textbox 参数。

3. 选择部分文本

HTML5 也为选择文本框中的部分文本提供了解决方案，即最早由 Firefox 引入的 setSelectionRange () 方法。现在除 select () 方法之外，所有文本框都有一个 setSelectionRange () 方法。这个方法接收两个参数：要选择的第一个字符的索引和要选择的最后一个字符之后的字符的索引（类似于 substring () 方法的两个参数）。来看一个例子。

textbox.value = "Hello world!" // 选择所有文本 textbox.setSelectionRange (0, textbox.value.length); //"Hello world!" // 选择前 3 个字符 textbox.setSelectionRange (0, 3); //"Hel" // 选择第 4 到第 6 个字符 textbox.setSelectionRange (4, 7); //"o w"

要看到选择的文本，必须在调用 setSelectionRange () 之前或之后立即将焦点设置到文本框。IE9、Firefox、Safari、Chrome 和 Opera 支持这种方案。

IE8 及更早版本支持使用范围（第 12 章讨论过）选择部分文本。要选择文本框中的部分文本，必须首先使用 IE 在所有文本框上提供的 createTextRange () 方法创建一个范围，并将其放在恰当的位置上。然后，再使用 moveStart () 和 moveEnd () 这两个范围方法将范围移动到位。不过，在调用这两个方法以前，还必须使用 collapse () 将范围折叠到文本框的开始位置。此时，moveStart () 将范围的起点和终点移动到了相同的位置，只要再给 moveEnd () 传入要选择的字符总数即可。最后一步，就是使用范围的 select () 方法选择文本，如下面的例子所示。

textbox.value = "Hello world!"; var range = textbox.createTextRange (); // 选择所有文本 range.collapse (true); range.moveStart ("character", 0); range.moveEnd ("character", textbox.value.length); //"Hello world!" range.select (); // 选择前 3 个字符 range.collapse (true); range.moveStart ("character", 0); range.moveEnd ("character", 3); range.select (); //"Hel" // 选择第 4 到第 6 个字符 range.collapse (true); range.moveStart ("character", 4); range.moveEnd ("character", 3); range.select (); //"o w"

与在其他浏览器中一样，要想在文本框中看到文本被选择的效果，必须让文本框获得焦点。

为了实现跨浏览器编程，可以将上述两种方案组合起来，如下面的例子所示。

function selectText(textbox, startIndex, stopIndex){ if (textbox.setSelectionRange){ textbox.setSelectionRange(startIndex, stopIndex); } else if (textbox.createTextRange){ var range = textbox.createTextRange(); range.collapse(true); range.moveStart("character", startIndex); range.moveEnd("character", stopIndex - startIndex); range.select(); } textbox.focus(); }

TextboxPartialSelectionExample01.htm

这个 selectText () 函数接收三个参数：要操作的文本框、要选择文本中第一个字符的索引和要选择文本中最后一个字符之后的索引。首先，函数测试了文本框是否包含 setSelectionRange () 方法。如果有，则使用该方法。否则，检测文本框是否支持 createTextRange () 方法。如果支持，则通过创建范围来实现选择。最后一步，就是为文本框设置焦点，以便用户看到文本框中选择的文本。可以像下面这样使用 selectText () 方法。

textbox.value = "Hello world!" // 选择所有文本 selectText (textbox, 0, textbox.value.length); //"Hello world!" // 选择前 3 个字符 selectText (textbox, 0, 3); //"Hel" // 选择第 4 到第 6 个字符 selectText (textbox, 4, 7); //"o w"

选择部分文本的技术在实现高级文本输入框时很有用，例如提供自动完成建议的文本框就可以使用这种技术。

14.2.2　过滤输入

我们经常会要求用户在文本框中输入特定的数据，或者输入特定格式的数据。例如，必须包含某些字符，或者必须匹配某种模式。由于文本框在默认情况下没有提供多少验证数据的手段，因此必须使用 JavaScript 来完成此类过滤输入的操作。而综合运用事件和 DOM 手段，就可以将普通的文本框转换成能够理解用户输入数据的功能型控件。

1. 屏蔽字符

有时候，我们需要用户输入的文本中包含或不包含某些字符。例如，电话号码中不能包含非数值字符。如前所述，响应向文本框中插入字符操作的是 keypress 事件。因此，可以通过阻止这个事件的默认行为来屏蔽此类字符。在极端的情况下，可以通过下列代码屏蔽所有按键操作。

EventUtil.addHandler(textbox, "keypress", function(event){ event = EventUtil.getEvent(event); EventUtil.preventDefault(event); });

运行以上代码后，由于所有按键操作都将被屏蔽，结果会导致文本框变成只读的。如果只想屏蔽特定的字符，则需要检测 keypress 事件对应的字符编码，然后再决定如何响应。例如，下列代码只允许用户输入数值。

EventUtil.addHandler(textbox, "keypress", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); var charCode = EventUtil.getCharCode(event); if (!/\d/.test(String.fromCharCode(charCode))){ EventUtil.preventDefault(event); } });

在这个例子中，我们使用 EventUtil.getCharCode () 实现了跨浏览器取得字符编码。然后，使用 String.fromCharCode () 将字符编码转换成字符串，再使用正则表达式 /\d / 来测试该字符串，从而确定用户输入的是不是数值。如果测试失败，那么就使用 EventUtil.preventDefault () 屏蔽按键事件。结果，文本框就会忽略所有输入的非数值。

虽然理论上只应该在用户按下字符键时才触发 keypress 事件，但有些浏览器也会对其他键触发此事件。Firefox 和 Safari（3.1 版本以前）会对向上键、向下键、退格键和删除键触发 keypress 事件；Safari 3.1 及更新版本则不会对这些键触发 keypress 事件。这意味着，仅考虑到屏蔽不是数值的字符还不够，还要避免屏蔽这些极为常用和必要的键。所幸的是，要检测这些键并不困难。在 Firefox 中，所有由非字符键触发的 keypress 事件对应的字符编码为 0，而在 Safari 3 以前的版本中，对应的字符编码全部为 8。为了让代码更通用，只要不屏蔽那些字符编码小于 10 的键即可。故而，可以将上面的函数重写成如下所示。

EventUtil.addHandler(textbox, "keypress", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); var charCode = EventUtil.getCharCode(event); if (!/\d/.test(String.fromCharCode(charCode)) && charCode > 9){ EventUtil.preventDefault(event); } });

这样，我们的事件处理程序就可以适用所有浏览器了，即可以屏蔽非数值字符，但不屏蔽那些也会触发 keypress 事件的基本按键。

除此之外，还有一个问题需要处理：复制、粘贴及其他操作还要用到 Ctrl 键。在除 IE 之外的所有浏览器中，前面的代码也会屏蔽 Ctrl+C、Ctrl+V，以及其他使用 Ctrl 的组合键。因此，最后还要添加一个检测条件，以确保用户没有按下 Ctrl 键，如下面的例子所示。

EventUtil.addHandler(textbox, "keypress", function(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); var charCode = EventUtil.getCharCode(event); if (!/\d/.test(String.fromCharCode(charCode)) && charCode > 9 && !event.ctrlKey){ EventUtil.preventDefault(event); } });

TextboxInputFilteringExample01.htm

经过最后一点修改，就可以确保文本框的行为完全正常了。在这个例子的基础上加以修改和调整，就可以将同样的技术运用于放过和屏蔽任何输入文本框的字符。

2. 操作剪贴板

IE 是第一个支持与剪贴板相关事件，以及通过 JavaScript 访问剪贴板数据的浏览器。IE 的实现成为了事实上的标准，不仅 Safari 2、Chrome 和 Firefox 3 也都支持类似的事件和剪贴板访问（Opera 不支持通过 JavaScript 访问剪贴板），HTML 5 后来也把剪贴板事件纳入了规范。下列就是 6 个剪贴板事件。

beforecopy：在发生复制操作前触发。

copy：在发生复制操作时触发。

beforecut：在发生剪切操作前触发。

cut：在发生剪切操作时触发。

beforepaste：在发生粘贴操作前触发。

paste：在发生粘贴操作时触发。

由于没有针对剪贴板操作的标准，这些事件及相关对象会因浏览器而异。在 Safari、Chrome 和 Firefox 中，beforecopy、beforecut 和 beforepaste 事件只会在显示针对文本框的上下文菜单（预期将发生剪贴板事件）的情况下触发。但是，IE 则会在触发 copy、cut 和 paste 事件之前先行触发这些事件。至于 copy、cut 和 paste 事件，只要是在上下文菜单中选择了相应选项，或者使用了相应的键盘组合键，所有浏览器都会触发它们。

在实际的事件发生之前，通过 beforecopy、beforecut 和 beforepaste 事件可以在向剪贴板发送数据，或者从剪贴板取得数据之前修改数据。不过，取消这些事件并不会取消对剪贴板的操作 —— 只有取消 copy、cut 和 paste 事件，才能阻止相应操作发生。

要访问剪贴板中的数据，可以使用 clipboardData 对象：在 IE 中，这个对象是 window 对象的属性；而在 Firefox 4+、Safari 和 Chrome 中，这个对象是相应 event 对象的属性。但是，在 Firefox、Safari 和 Chorme 中，只有在处理剪贴板事件期间 clipboardData 对象才有效，这是为了防止对剪贴板的未授权访问；在 IE 中，则可以随时访问 clipboardData 对象。为了确保跨浏览器兼容性，最好只在发生剪贴板事件期间使用这个对象。

这个 clipboardData 对象有三个方法：getData ()、setData () 和 clearData ()。其中，getData () 用于从剪贴板中取得数据，它接受一个参数，即要取得的数据的格式。在 IE 中，有两种数据格式："text" 和 "URL"。在 Firefox、Safari 和 Chrome 中，这个参数是一种 MIME 类型；不过，可以用 "text" 代表 "text/plain"。

类似地，setData () 方法的第一个参数也是数据类型，第二个参数是要放在剪贴板中的文本。对于第一个参数，IE 照样支持 "text" 和 "URL"，而 Safari 和 Chrome 仍然只支持 MIME 类型。但是，与 getData () 方法不同的是，Safari 和 Chrome 的 setData () 方法不能识别 "text" 类型。这两个浏览器在成功将文本放到剪贴板中后，都会返回 true；否则，返回 false。为了弥合这些差异，我们可以向 EventUtil 中再添加下列方法。

var EventUtil = {// 省略的代码 getClipboardText: function (event){var clipboardData = (event.clipboardData || window.clipboardData); return clipboardData.getData ("text"); }, // 省略的代码 setClipboardText: function (event, value){if (event.clipboardData){return event.clipboardData.setData ("text/plain", value); } else if (window.clipboardData){return window.clipboardData.setData ("text", value); } }, // 省略的代码 };

EventUtil.js

这里的 getClipboardText () 方法相对简单；它只要确定 clipboardData 对象的位置，然后再以 "text" 类型调用 getData () 方法即可。相应地，setClipboardText () 方法则要稍微复杂一些。在取得 clipboardData 对象之后，需要根据不同的浏览器实现为 setData () 传入不同的类型（对于 Safari 和 Chrome，是 "text/plain"；对于 IE，是 "text"）。

在需要确保粘贴到文本框中的文本中包含某些字符，或者符合某种格式要求时，能够访问剪贴板是非常有用的。例如，如果一个文本框只接受数值，那么就必须检测粘贴过来的值，以确保有效。在 paste 事件中，可以确定剪贴板中的值是否有效，如果无效，就可以像下面示例中那样，取消默认的行为。

EventUtil.addHandler(textbox, "paste", function(event){ event = EventUtil.getEvent(event); var text = EventUtil.getClipboardText(event); if (!/^\d*$/.test(text)){ EventUtil.preventDefault(event); } });

TextboxClipboardExample01.htm

在这里，onpaste 事件处理程序可以确保只有数值才会被粘贴到文本框中。如果剪贴板的值与正则表达式不匹配，则会取消粘贴操作。Firefox、Safari 和 Chrome 只允许在 onpaste 事件处理程序中访问 getData () 方法。

由于并非所有浏览器都支持访问剪贴板，所以更简单的做法是屏蔽一或多个剪贴板操作。在支持 copy、cut 和 paste 事件的浏览器中（IE、Safari、Chrome 和 Firefox 3 及更高版本），很容易阻止这些事件的默认行为。在 Opera 中，则需要阻止那些会触发这些事件的按键操作，同时还要阻止在文本框中显示上下文菜单。

14.2.3　自动切换焦点

使用 JavaScript 可以从多个方面增强表单字段的易用性。其中，最常见的一种方式就是在用户填写完当前字段时，自动将焦点切换到下一个字段。通常，在自动切换焦点之前，必须知道用户已经输入了既定长度的数据（例如电话号码）。例如，美国的电话号码通常会分为三部分：区号、局号和另外 4 位数字。为取得完整的电话号码，很多网页中都会提供下列 3 个文本框：

<input type="text" name="tel1" id="txtTel1" maxlength="3"> <input type="text" name="tel2" id="txtTel2" maxlength="3"> <input type="text" name="tel3" id="txtTel3" maxlength="4">

TextboxTabForwardExample01.htm

为增强易用性，同时加快数据输入，可以在前一个文本框中的字符达到最大数量后，自动将焦点切换到下一个文本框。换句话说，用户在第一个文本框中输入了 3 个数字之后，焦点就会切换到第二个文本框，再输入 3 个数字，焦点又会切换到第三个文本框。这种「自动切换焦点」的功能，可以通过下列代码实现：

(function(){ function tabForward(event){ event = EventUtil.getEvent(event); var target = EventUtil.getTarget(event); if (target.value.length == target.maxLength){ var form = target.form; for (var i=0, len=form.elements.length; i < len; i++) { if (form.elements[i] == target) { if (form.elements[i+1]){ form.elements[i+1].focus(); } return; } } } } var textbox1 = document.getElementById("txtTel1"); var textbox2 = document.getElementById("txtTel2"); var textbox3 = document.getElementById("txtTel3"); EventUtil.addHandler(textbox1, "keyup", tabForward); EventUtil.addHandler(textbox2, "keyup", tabForward); EventUtil.addHandler(textbox3, "keyup", tabForward); })();

TextboxTabForwardExample01.htm

开始的 tabForward () 函数是实现「自动切换焦点」的关键所在。这个函数通过比较用户输入的值与文本框的 maxlength 特性，可以确定是否已经达到最大长度。如果这两个值相等（因为浏览器最终会强制它们相等，因此用户绝不会多输入字符），则需要查找表单字段集合，直至找到下一个文本框。找到下一个文本框之后，则将焦点切换到该文本框。然后，我们把这个函数指定为每个文本框的 onkeyup 事件处理程序。由于 keyup 事件会在用户输入了新字符之后触发，所以此时是检测文本框中内容长度的最佳时机。这样一来，用户在填写这个简单的表单时，就不必再通过按制表键切换表单字段和提交表单了。

不过请记住，这些代码只适用于前面给出的标记，而且没有考虑隐藏字段。

14.2.4　HTML5 约束验证 API

为了在将表单提交到服务器之前验证数据，HTML5 新增了一些功能。有了这些功能，即便 JavaScript 被禁用或者由于种种原因未能加载，也可以确保基本的验证。换句话说，浏览器自己会根据标记中的规则执行验证，然后自己显示适当的错误消息（完全不用 JavaScript 插手）。当然，这个功能只有在支持 HTML5 这部分内容的浏览器中才有效，这些浏览器有 Firefox 4+、Safari 5+、Chrome 和 Opera 10+。

只有在某些情况下表单字段才能进行自动验证。具体来说，就是要在 HTML 标记中为特定的字段指定一些约束，然后浏览器才会自动执行表单验证。

1. 必填字段

第一种情况是在表单字段中指定了 required 属性，如下面的例子所示：

<input type="text" name="username" required>

任何标注有 required 的字段，在提交表单时都不能空着。这个属性适用于 <input>、<textarea> 和 <select> 字段（Opera 11 及之前版本还不支持 <select> 的 required 属性）。在 JavaScript 中，通过对应的 required 属性，可以检查某个表单字段是否为必填字段。

var isUsernameRequired = document.forms[0].elements["username"].required;

另外，使用下面这行代码可以测试浏览器是否支持 required 属性。

var isRequiredSupported = "required" in document.createElement("input");

以上代码通过特性检测来确定新创建的 <input> 元素中是否存在 required 属性。

对于空着的必填字段，不同浏览器有不同的处理方式。Firefox 4 和 Opera 11 会阻止表单提交并在相应字段下方弹出帮助框，而 Safari（5 之前）和 Chrome（9 之前）则什么也不做，而且也不阻止表单提交。

2. 其他输入类型

HTML5 为 <input> 元素的 type 属性又增加了几个值。这些新的类型不仅能反映数据类型的信息，而且还能提供一些默认的验证功能。其中，"email" 和 "url" 是两个得到支持最多的类型，各浏览器也都为它们增加了定制的验证机制。例如：

<input type="email" name ="email"> <input type="url" name="homepage">

顾名思义，"email" 类型要求输入的文本必须符合电子邮件地址的模式，而 "url" 类型要求输入的文本必须符合 URL 的模式。不过，本节前面提到的浏览器在恰当地匹配模式方面都存在问题。最明显的是 "-@-" 会被当成一个有效的电子邮件地址。浏览器开发商还在解决这些问题。

要检测浏览器是否支持这些新类型，可以在 JavaScript 创建一个 <input> 元素，然后将 type 属性设置为 "email" 或 "url"，最后再检测这个属性的值。不支持它们的旧版本浏览器会自动将未知的值设置为 "text"，而支持的浏览器则会返回正确的值。例如：

var input = document.createElement("input"); input.type = "email"; var isEmailSupported = (input.type == "email");

要注意的是，如果不给 <input> 元素设置 required 属性，那么空文本框也会验证通过。另一方面，设置特定的输入类型并不能阻止用户输入无效的值，只是应用某些默认的验证而已。

3. 数值范围

除了 "email" 和 "url"，HTML5 还定义了另外几个输入元素。这几个元素都要求填写某种基于数字的值："number"、"range"、"datetime"、"datetime-local"、"date"、"month"、"week"，还有 "time"。浏览器对这几个类型的支持情况并不好，因此如果真想选用的话，要特别小心。目前，浏览器开发商主要关注更好的跨平台兼容性以及更多的逻辑功能。因此，本节介绍的内容某种程度上有些超前，不一定马上就能在实际开发中使用。

对所有这些数值类型的输入元素，可以指定 min 属性（最小的可能值）、max 属性（最大的可能值）和 step 属性（从 min 到 max 的两个刻度间的差值）。例如，想让用户只能输入 0 到 100 的值，而且这个值必须是 5 的倍数，可以这样写代码：

<input type="number" min="0" max="100" step="5" name="count">

在不同的浏览器中，可能会也可能不会看到能够自动递增和递减的数值调节按钮（向上和向下按钮）。

以上这些属性在 JavaScript 中都能通过对应的元素访问（或修改）。此外，还有两个方法：stepUp () 和 stepDown ()，都接收一个可选的参数：要在当前值基础上加上或减去的数值。（默认是加或减 1。）这两个方法还没有得到任何浏览器支持，但下面的例子演示了它们的用法。

input.stepUp (); // 加 1 input.stepUp (5); // 加 5 input.stepDown (); // 减 1 input.stepDown (10); // 减 10

4. 输入模式

HTML5 为文本字段新增了 pattern 属性。这个属性的值是一个正则表达式，用于匹配文本框中的值。例如，如果只想允许在文本字段中输入数值，可以像下面的代码一样应用约束：

<input type="text" pattern="\d+" name="count">

注意，模式的开头和末尾不用加 ^ 和 $ 符号（假定已经有了）。这两个符号表示输入的值必须从头到尾都与模式匹配。

与其他输入类型相似，指定 pattern 也不能阻止用户输入无效的文本。这个模式应用给值，浏览器来判断值是有效，还是无效。在 JavaScript 中可以通过 pattern 属性访问模式。

var pattern = document.forms[0].elements["count"].pattern;

使用以下代码可以检测浏览器是否支持 pattern 属性。

var isPatternSupported = "pattern" in document.createElement("input");

5. 检测有效性

使用 checkValidity () 方法可以检测表单中的某个字段是否有效。所有表单字段都有个方法，如果字段的值有效，这个方法返回 true，否则返回 false。字段的值是否有效的判断依据是本节前面介绍过的那些约束。换句话说，必填字段中如果没有值就是无效的，而字段中的值与 pattern 属性不匹配也是无效的。例如：

if (document.forms [0].elements [0].checkValidity ()){// 字段有效，继续} else {// 字段无效}

要检测整个表单是否有效，可以在表单自身调用 checkValidity () 方法。如果所有表单字段都有效，这个方法返回 true；即使有一个字段无效，这个方法也会返回 false。

